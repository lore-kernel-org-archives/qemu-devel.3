Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AD99CEACE7
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 16:41:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svfuW-0005Xt-Un; Tue, 01 Oct 2024 12:39:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfuT-0005OW-Qw
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:37 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfuO-00063M-PU
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:37 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42f6bec84b5so20163105e9.1
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 09:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727800771; x=1728405571; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1NFdQFBmhDhh52nx6Dx9xhs8L+fjw/7HyeJJPyE/TKQ=;
 b=xAyaABtPKuaY+29c812obR9dKcNhFDzww7bie3+XLwF3badD/2XIIchzrIfLnG5cSn
 lRg/xf35RgGkWcxNNrzAe+920ZapylscUna+ou9IgE9GahFUrOv68bDXokSPzEBX27O1
 uMFXYFnvm968RDajXlbfSzjLbuY+axJxxyFbUZMAuaBqSInizN6OBqhKsmTc4QXNKPr9
 3pxcwzn5lv2RDMfjdt3e3mRkJeVznPKZNpCq8N0LN2WGViDJHawJq9GyRIPZ0QHoSWV3
 dR6FzHGWCOkiIBKrQPwc/JH1SPSsI+9H91NfO5cHG/vi+vOVVIEO8zyd9Df6/QyVz+qv
 rpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727800771; x=1728405571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1NFdQFBmhDhh52nx6Dx9xhs8L+fjw/7HyeJJPyE/TKQ=;
 b=AND1lIhfxRthNUfgTgynlPUFhdLpLc3QLRHYp96PmVyDEA5/ebETwCcBJMkv5zjAG6
 /xt4nzD7vCMut8Vvchv9+xhBpmci1pU4SFYBBHNwCio+JR/NFTKV8QkfCUSCrbsfrVZh
 aHItC9fFAgYbiUg36h7ZcJabjEtg5nAqiqfV/WxZtS+Go1smQTnbrl/7pizH26PE/O6B
 OyIijQQdsioppKLI+iPtoJGjzp5tqU7suuMan0+A7NBrIH0OoZgnmiLNDFtA2bOUZY9h
 ELUVOzo+H5xG0UFKRtuHT1h7J+GUF3XbS+AM/5fgSY0T56Dt1GPdXC1iPO3fWERTu31n
 BJjA==
X-Gm-Message-State: AOJu0YwXJKmElnzZmTMV2Zz12UCJnsQCjphQn9F1K+BRLygSh0o54oUN
 WwVDdLLdk/293vkpqt+RIQawJcV/D+p+R0J7acLWlGa+qMuK9a85JFIpmKdDE+44Y9QO6vqSDfl
 C
X-Google-Smtp-Source: AGHT+IFhlVuGC6+MNnwHB1eTHKDyW9/RO2S8KkAS/X4YTUDzmqjqhaM5jDLbfQLPR3BkYSfHzNFdow==
X-Received: by 2002:a5d:4a0c:0:b0:374:c64d:5379 with SMTP id
 ffacd0b85a97d-37cfb9d022bmr134821f8f.27.1727800771258; 
 Tue, 01 Oct 2024 09:39:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e6547sm12243771f8f.58.2024.10.01.09.39.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 09:39:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/54] hw/input: Remove pxa2xx_keypad
Date: Tue,  1 Oct 2024 17:38:45 +0100
Message-Id: <20241001163918.1275441-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001163918.1275441-1-peter.maydell@linaro.org>
References: <20241001163918.1275441-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Remove the pxa2xx-specific pxa2xx_keypad device.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240903160751.4100218-18-peter.maydell@linaro.org
---
 include/hw/arm/pxa.h     |  12 --
 hw/input/pxa2xx_keypad.c | 331 ---------------------------------------
 hw/input/meson.build     |   1 -
 3 files changed, 344 deletions(-)
 delete mode 100644 hw/input/pxa2xx_keypad.c

diff --git a/include/hw/arm/pxa.h b/include/hw/arm/pxa.h
index cc4de0750af..40f9356b226 100644
--- a/include/hw/arm/pxa.h
+++ b/include/hw/arm/pxa.h
@@ -94,16 +94,4 @@ int pxa2xx_pcmcia_attach(void *opaque, PCMCIACardState *card);
 int pxa2xx_pcmcia_detach(void *opaque);
 void pxa2xx_pcmcia_set_irq_cb(void *opaque, qemu_irq irq, qemu_irq cd_irq);
 
-/* pxa2xx_keypad.c */
-struct  keymap {
-    int8_t column;
-    int8_t row;
-};
-typedef struct PXA2xxKeyPadState PXA2xxKeyPadState;
-PXA2xxKeyPadState *pxa27x_keypad_init(MemoryRegion *sysmem,
-                                      hwaddr base,
-                                      qemu_irq irq);
-void pxa27x_register_keypad(PXA2xxKeyPadState *kp,
-                            const struct keymap *map, int size);
-
 #endif /* PXA_H */
diff --git a/hw/input/pxa2xx_keypad.c b/hw/input/pxa2xx_keypad.c
deleted file mode 100644
index 3858648d9f6..00000000000
--- a/hw/input/pxa2xx_keypad.c
+++ /dev/null
@@ -1,331 +0,0 @@
-/*
- * Intel PXA27X Keypad Controller emulation.
- *
- * Copyright (c) 2007 MontaVista Software, Inc
- * Written by Armin Kuster <akuster@kama-aina.net>
- *              or  <Akuster@mvista.com>
- *
- * This code is licensed under the GPLv2.
- *
- * Contributions after 2012-01-13 are licensed under the terms of the
- * GNU GPL, version 2 or (at your option) any later version.
- */
-
-#include "qemu/osdep.h"
-#include "qemu/log.h"
-#include "hw/irq.h"
-#include "migration/vmstate.h"
-#include "hw/arm/pxa.h"
-#include "ui/console.h"
-
-/*
- * Keypad
- */
-#define KPC         0x00    /* Keypad Interface Control register */
-#define KPDK        0x08    /* Keypad Interface Direct Key register */
-#define KPREC       0x10    /* Keypad Interface Rotary Encoder register */
-#define KPMK        0x18    /* Keypad Interface Matrix Key register */
-#define KPAS        0x20    /* Keypad Interface Automatic Scan register */
-#define KPASMKP0    0x28    /* Keypad Interface Automatic Scan Multiple
-                                Key Presser register 0 */
-#define KPASMKP1    0x30    /* Keypad Interface Automatic Scan Multiple
-                                Key Presser register 1 */
-#define KPASMKP2    0x38    /* Keypad Interface Automatic Scan Multiple
-                                Key Presser register 2 */
-#define KPASMKP3    0x40    /* Keypad Interface Automatic Scan Multiple
-                                Key Presser register 3 */
-#define KPKDI       0x48    /* Keypad Interface Key Debounce Interval
-                                register */
-
-/* Keypad defines */
-#define KPC_AS          (0x1 << 30)  /* Automatic Scan bit */
-#define KPC_ASACT       (0x1 << 29)  /* Automatic Scan on Activity */
-#define KPC_MI          (0x1 << 22)  /* Matrix interrupt bit */
-#define KPC_IMKP        (0x1 << 21)  /* Ignore Multiple Key Press */
-#define KPC_MS7         (0x1 << 20)  /* Matrix scan line 7 */
-#define KPC_MS6         (0x1 << 19)  /* Matrix scan line 6 */
-#define KPC_MS5         (0x1 << 18)  /* Matrix scan line 5 */
-#define KPC_MS4         (0x1 << 17)  /* Matrix scan line 4 */
-#define KPC_MS3         (0x1 << 16)  /* Matrix scan line 3 */
-#define KPC_MS2         (0x1 << 15)  /* Matrix scan line 2 */
-#define KPC_MS1         (0x1 << 14)  /* Matrix scan line 1 */
-#define KPC_MS0         (0x1 << 13)  /* Matrix scan line 0 */
-#define KPC_ME          (0x1 << 12)  /* Matrix Keypad Enable */
-#define KPC_MIE         (0x1 << 11)  /* Matrix Interrupt Enable */
-#define KPC_DK_DEB_SEL  (0x1 <<  9)  /* Direct Keypad Debounce Select */
-#define KPC_DI          (0x1 <<  5)  /* Direct key interrupt bit */
-#define KPC_RE_ZERO_DEB (0x1 <<  4)  /* Rotary Encoder Zero Debounce */
-#define KPC_REE1        (0x1 <<  3)  /* Rotary Encoder1 Enable */
-#define KPC_REE0        (0x1 <<  2)  /* Rotary Encoder0 Enable */
-#define KPC_DE          (0x1 <<  1)  /* Direct Keypad Enable */
-#define KPC_DIE         (0x1 <<  0)  /* Direct Keypad interrupt Enable */
-
-#define KPDK_DKP        (0x1 << 31)
-#define KPDK_DK7        (0x1 <<  7)
-#define KPDK_DK6        (0x1 <<  6)
-#define KPDK_DK5        (0x1 <<  5)
-#define KPDK_DK4        (0x1 <<  4)
-#define KPDK_DK3        (0x1 <<  3)
-#define KPDK_DK2        (0x1 <<  2)
-#define KPDK_DK1        (0x1 <<  1)
-#define KPDK_DK0        (0x1 <<  0)
-
-#define KPREC_OF1       (0x1 << 31)
-#define KPREC_UF1       (0x1 << 30)
-#define KPREC_OF0       (0x1 << 15)
-#define KPREC_UF0       (0x1 << 14)
-
-#define KPMK_MKP        (0x1 << 31)
-#define KPAS_SO         (0x1 << 31)
-#define KPASMKPx_SO     (0x1 << 31)
-
-
-#define KPASMKPx_MKC(row, col)  (1 << (row + 16 * (col % 2)))
-
-#define PXAKBD_MAXROW   8
-#define PXAKBD_MAXCOL   8
-
-struct PXA2xxKeyPadState {
-    MemoryRegion iomem;
-    qemu_irq    irq;
-    const struct  keymap *map;
-    int         pressed_cnt;
-    int         alt_code;
-
-    uint32_t    kpc;
-    uint32_t    kpdk;
-    uint32_t    kprec;
-    uint32_t    kpmk;
-    uint32_t    kpas;
-    uint32_t    kpasmkp[4];
-    uint32_t    kpkdi;
-};
-
-static void pxa27x_keypad_find_pressed_key(PXA2xxKeyPadState *kp, int *row, int *col)
-{
-    int i;
-    for (i = 0; i < 4; i++)
-    {
-        *col = i * 2;
-        for (*row = 0; *row < 8; (*row)++) {
-            if (kp->kpasmkp[i] & (1 << *row))
-                return;
-        }
-        *col = i * 2 + 1;
-        for (*row = 0; *row < 8; (*row)++) {
-            if (kp->kpasmkp[i] & (1 << (*row + 16)))
-                return;
-        }
-    }
-}
-
-static void pxa27x_keyboard_event (PXA2xxKeyPadState *kp, int keycode)
-{
-    int row, col, rel, assert_irq = 0;
-    uint32_t val;
-
-    if (keycode == 0xe0) {
-        kp->alt_code = 1;
-        return;
-    }
-
-    if(!(kp->kpc & KPC_ME)) /* skip if not enabled */
-        return;
-
-    rel = (keycode & 0x80) ? 1 : 0; /* key release from qemu */
-    keycode &= ~0x80; /* strip qemu key release bit */
-    if (kp->alt_code) {
-        keycode |= 0x80;
-        kp->alt_code = 0;
-    }
-
-    row = kp->map[keycode].row;
-    col = kp->map[keycode].column;
-    if (row == -1 || col == -1) {
-        return;
-    }
-
-    val = KPASMKPx_MKC(row, col);
-    if (rel) {
-        if (kp->kpasmkp[col / 2] & val) {
-            kp->kpasmkp[col / 2] &= ~val;
-            kp->pressed_cnt--;
-            assert_irq = 1;
-        }
-    } else {
-        if (!(kp->kpasmkp[col / 2] & val)) {
-            kp->kpasmkp[col / 2] |= val;
-            kp->pressed_cnt++;
-            assert_irq = 1;
-        }
-    }
-    kp->kpas = ((kp->pressed_cnt & 0x1f) << 26) | (0xf << 4) | 0xf;
-    if (kp->pressed_cnt == 1) {
-        kp->kpas &= ~((0xf << 4) | 0xf);
-        if (rel) {
-            pxa27x_keypad_find_pressed_key(kp, &row, &col);
-        }
-        kp->kpas |= ((row & 0xf) << 4) | (col & 0xf);
-    }
-
-    if (!(kp->kpc & (KPC_AS | KPC_ASACT)))
-        assert_irq = 0;
-
-    if (assert_irq && (kp->kpc & KPC_MIE)) {
-        kp->kpc |= KPC_MI;
-        qemu_irq_raise(kp->irq);
-    }
-}
-
-static uint64_t pxa2xx_keypad_read(void *opaque, hwaddr offset,
-                                   unsigned size)
-{
-    PXA2xxKeyPadState *s = (PXA2xxKeyPadState *) opaque;
-    uint32_t tmp;
-
-    switch (offset) {
-    case KPC:
-        tmp = s->kpc;
-        if(tmp & KPC_MI)
-            s->kpc &= ~(KPC_MI);
-        if(tmp & KPC_DI)
-            s->kpc &= ~(KPC_DI);
-        qemu_irq_lower(s->irq);
-        return tmp;
-    case KPDK:
-        return s->kpdk;
-    case KPREC:
-        tmp = s->kprec;
-        if(tmp & KPREC_OF1)
-            s->kprec &= ~(KPREC_OF1);
-        if(tmp & KPREC_UF1)
-            s->kprec &= ~(KPREC_UF1);
-        if(tmp & KPREC_OF0)
-            s->kprec &= ~(KPREC_OF0);
-        if(tmp & KPREC_UF0)
-            s->kprec &= ~(KPREC_UF0);
-        return tmp;
-    case KPMK:
-        tmp = s->kpmk;
-        if(tmp & KPMK_MKP)
-            s->kpmk &= ~(KPMK_MKP);
-        return tmp;
-    case KPAS:
-        return s->kpas;
-    case KPASMKP0:
-        return s->kpasmkp[0];
-    case KPASMKP1:
-        return s->kpasmkp[1];
-    case KPASMKP2:
-        return s->kpasmkp[2];
-    case KPASMKP3:
-        return s->kpasmkp[3];
-    case KPKDI:
-        return s->kpkdi;
-    default:
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "%s: Bad read offset 0x%"HWADDR_PRIx"\n",
-                      __func__, offset);
-    }
-
-    return 0;
-}
-
-static void pxa2xx_keypad_write(void *opaque, hwaddr offset,
-                                uint64_t value, unsigned size)
-{
-    PXA2xxKeyPadState *s = (PXA2xxKeyPadState *) opaque;
-
-    switch (offset) {
-    case KPC:
-        s->kpc = value;
-        if (s->kpc & KPC_AS) {
-            s->kpc &= ~(KPC_AS);
-        }
-        break;
-    case KPDK:
-        s->kpdk = value;
-        break;
-    case KPREC:
-        s->kprec = value;
-        break;
-    case KPMK:
-        s->kpmk = value;
-        break;
-    case KPAS:
-        s->kpas = value;
-        break;
-    case KPASMKP0:
-        s->kpasmkp[0] = value;
-        break;
-    case KPASMKP1:
-        s->kpasmkp[1] = value;
-        break;
-    case KPASMKP2:
-        s->kpasmkp[2] = value;
-        break;
-    case KPASMKP3:
-        s->kpasmkp[3] = value;
-        break;
-    case KPKDI:
-        s->kpkdi = value;
-        break;
-
-    default:
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "%s: Bad write offset 0x%"HWADDR_PRIx"\n",
-                      __func__, offset);
-    }
-}
-
-static const MemoryRegionOps pxa2xx_keypad_ops = {
-    .read = pxa2xx_keypad_read,
-    .write = pxa2xx_keypad_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-};
-
-static const VMStateDescription vmstate_pxa2xx_keypad = {
-    .name = "pxa2xx_keypad",
-    .version_id = 0,
-    .minimum_version_id = 0,
-    .fields = (const VMStateField[]) {
-        VMSTATE_UINT32(kpc, PXA2xxKeyPadState),
-        VMSTATE_UINT32(kpdk, PXA2xxKeyPadState),
-        VMSTATE_UINT32(kprec, PXA2xxKeyPadState),
-        VMSTATE_UINT32(kpmk, PXA2xxKeyPadState),
-        VMSTATE_UINT32(kpas, PXA2xxKeyPadState),
-        VMSTATE_UINT32_ARRAY(kpasmkp, PXA2xxKeyPadState, 4),
-        VMSTATE_UINT32(kpkdi, PXA2xxKeyPadState),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-PXA2xxKeyPadState *pxa27x_keypad_init(MemoryRegion *sysmem,
-                                      hwaddr base,
-                                      qemu_irq irq)
-{
-    PXA2xxKeyPadState *s;
-
-    s = g_new0(PXA2xxKeyPadState, 1);
-    s->irq = irq;
-
-    memory_region_init_io(&s->iomem, NULL, &pxa2xx_keypad_ops, s,
-                          "pxa2xx-keypad", 0x00100000);
-    memory_region_add_subregion(sysmem, base, &s->iomem);
-
-    vmstate_register(NULL, 0, &vmstate_pxa2xx_keypad, s);
-
-    return s;
-}
-
-void pxa27x_register_keypad(PXA2xxKeyPadState *kp,
-                            const struct keymap *map, int size)
-{
-    if(!map || size < 0x80) {
-        fprintf(stderr, "%s - No PXA keypad map defined\n", __func__);
-        exit(-1);
-    }
-
-    kp->map = map;
-    qemu_add_kbd_event_handler((QEMUPutKBDEvent *) pxa27x_keyboard_event, kp);
-}
diff --git a/hw/input/meson.build b/hw/input/meson.build
index 07a28c2c01c..fe60b6e28fc 100644
--- a/hw/input/meson.build
+++ b/hw/input/meson.build
@@ -11,6 +11,5 @@ system_ss.add(when: 'CONFIG_VIRTIO_INPUT', if_true: files('virtio-input.c'))
 system_ss.add(when: 'CONFIG_VIRTIO_INPUT', if_true: files('virtio-input-hid.c'))
 system_ss.add(when: 'CONFIG_VIRTIO_INPUT_HOST', if_true: files('virtio-input-host.c'))
 
-system_ss.add(when: 'CONFIG_PXA2XX', if_true: files('pxa2xx_keypad.c'))
 system_ss.add(when: 'CONFIG_TSC210X', if_true: files('tsc210x.c'))
 system_ss.add(when: 'CONFIG_LASIPS2', if_true: files('lasips2.c'))
-- 
2.34.1


