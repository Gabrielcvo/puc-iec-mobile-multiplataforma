// src/components/UpdatePrompt.tsx
// Aviso de PWA: "pronto para uso offline" (1ª visita) e "Nova versão disponível" (SW novo em espera).

import type React from 'react';
import { useRegisterSW } from 'virtual:pwa-register/react';

const box: React.CSSProperties = {
  position: 'fixed',
  left: 16,
  right: 16,
  bottom: 80, // acima da BottomTabBar (64px)
  zIndex: 200,
  maxWidth: 420,
  margin: '0 auto',
  display: 'flex',
  alignItems: 'center',
  justifyContent: 'space-between',
  gap: 12,
  padding: '12px 16px',
  background: '#112233',
  color: '#e5e5e5',
  border: '1px solid #01b4e4',
  borderRadius: 12,
  fontSize: 14,
  boxShadow: '0 4px 16px rgba(0,0,0,0.4)',
};

const btn: React.CSSProperties = {
  padding: '6px 12px',
  borderRadius: 8,
  border: '1px solid #2a3f55',
  background: '#1c2d40',
  color: '#e5e5e5',
  fontSize: 13,
  fontWeight: 600,
  cursor: 'pointer',
};

const btnPrimary: React.CSSProperties = { ...btn, background: '#01b4e4', color: '#0d253f', border: 'none' };

export function UpdatePrompt() {
  const {
    offlineReady: [offlineReady, setOfflineReady],
    needRefresh: [needRefresh, setNeedRefresh],
    updateServiceWorker,
  } = useRegisterSW();

  const close = () => {
    setOfflineReady(false);
    setNeedRefresh(false);
  };

  if (!offlineReady && !needRefresh) return null;

  return (
    <div role="status" aria-live="polite" style={box}>
      <span>{needRefresh ? 'Nova versão disponível' : 'App pronto para uso offline'}</span>
      <div style={{ display: 'flex', gap: 8 }}>
        {needRefresh && (
          <button style={btnPrimary} onClick={() => updateServiceWorker(true)}>
            Atualizar
          </button>
        )}
        <button style={btn} onClick={close}>
          {needRefresh ? 'Depois' : 'OK'}
        </button>
      </div>
    </div>
  );
}
