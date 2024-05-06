Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9CFFC4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 06:21:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3rie-0002jQ-Sf; Mon, 06 May 2024 02:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanmaynpatil105@gmail.com>)
 id 1s3rib-0002is-MN; Mon, 06 May 2024 02:20:58 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tanmaynpatil105@gmail.com>)
 id 1s3riR-0006sC-2o; Mon, 06 May 2024 02:20:57 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-22e6b61d652so820305fac.0; 
 Sun, 05 May 2024 23:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714976445; x=1715581245; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=l8uARPOXLgNrD5x5VbymwJHQnEgheFii2ZdPuVb1ADE=;
 b=C7TYFl/OUjyzRg3618PcWU17mJTcRVgNESYAk2QYRNhZ+CTEft77JPyqd6UoD3oPmu
 xV1niJuEUTQEV0/v5HXWz2Ec78lAgm/0Uv7YplbBDK/kMILeTDP1JVuanocc5YFKKJjM
 19PDz/AKo/lRwNPnBMSy4UXZaV7We8O2jLtuuxiNVoQqxf+3EnGs3YWsYZ67zKZGc1e/
 jFU7weptTbRG9O/1F/hfWBuBKaQ9IY5cWKwkgJR6+VWUG9Xc/Cwlv1lLqS0jWdaZEkoS
 lL6JyGqyOYALoGXJMcbtoKukOu0FEu3GBs/nM9sldksjG4o3o+0RdPeGOwECges48KPm
 yO+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714976445; x=1715581245;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l8uARPOXLgNrD5x5VbymwJHQnEgheFii2ZdPuVb1ADE=;
 b=PuhH+enQrh72HTXTzzD8y7KKsFgu/1RuY/r8DOzylzAXCZUXjjwhOTJcAHhST+A2EF
 mgIXlonwHzycJaHbjq9Rx6hvEz7b4lV8JMDrZ/JvNWS4OXKtvghqOEN7UBzyoaMvS+XG
 De7etHwxMdMuXm6DYSNXYZ+Zj4guyT5kbU+EiOvNZL40m9ke8VmQWlryjK/ho2ErYM8A
 awZyoC7xRQ23PPNs31mjGxX+RJ3RAWd26qKQehDb1UOqvw9YpX861HIAERZQ7AbJRQbV
 /4Vdxp1XIw4pFsu7CnOIkt/ey8E5s9iOqnHRerKy/pw7XEzLHiDWuuos5+LFneb2pZQX
 +Zdg==
X-Gm-Message-State: AOJu0YxkZLMvqB21lGWWSLTXQc84fNg8SP0Hsxp9nieS05DaRFkuPlrL
 K9erpya8vTRI0LRuhgig3upC6Aw/heqZECC3VeSZt6hb339PN/lsm6IHvYVL317KnH9XO5vwJlD
 36qK/ytEYvZQH6GIkpmvdAnPtQyRw9zJlRbudNg==
X-Google-Smtp-Source: AGHT+IGEOTJuGbhS2Bv++AQA/gD1BZPNURqFA0PIAXIvZnIpmdlmfK+SLwRTJdiPMkXT8RyF1hbP6mVxBj3AbSYj35w=
X-Received: by 2002:a05:6870:b023:b0:233:b5dd:471c with SMTP id
 y35-20020a056870b02300b00233b5dd471cmr9815548oae.51.1714976444564; Sun, 05
 May 2024 23:20:44 -0700 (PDT)
MIME-Version: 1.0
From: Tanmay <tanmaynpatil105@gmail.com>
Date: Mon, 6 May 2024 11:50:30 +0530
Message-ID: <CAHnsOnN6AkE3visU9jaycp61G87XRJFwDGx4D1=HJSJpA2tfXw@mail.gmail.com>
Subject: [PATCH] Fixes: Indentation using TABs and improve formatting
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 pbonzini@redhat.com, richard.henderson@linaro.org
Content-Type: multipart/alternative; boundary="000000000000c6e3b70617c3118c"
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=tanmaynpatil105@gmail.com; helo=mail-oa1-x33.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--000000000000c6e3b70617c3118c
Content-Type: text/plain; charset="UTF-8"

Hi,

I have added a patch inline that fixes indentation and formatting for some
files as listed in https://gitlab.com/qemu-project/qemu/-/issues/373.

Thanks,
Tanmay

From 46026574821c46804111eea6607a1b39314b7abe Mon Sep 17 00:00:00 2001
From: Tanmay Patil <tanmaynpatil105@gmail.com>
Date: Sat, 25 Nov 2023 00:53:54 +0530
Subject: [PATCH] Fixes: Indentation using TABs and improve formatting
 Resolves: https://gitlab.com/qemu-project/qemu/-/issues/373

   Files changed:
        - hw/arm/boot.c
        - hw/char/omap_uart.c
        - hw/dma/pxa2xx_dma.c
        - hw/gpio/omap_gpio.c
        - hw/gpio/zaurus.c
        - hw/input/tsc2005.c
        - hw/input/tsc210x.c
        - hw/intc/omap_intc.c
        - hw/misc/cbus.c
        - hw/misc/omap_clk.c
        - hw/misc/omap_l4.c
        - hw/misc/omap_sdrc.c
        - hw/misc/omap_tap.c
        - hw/sd/omap_mmc.c
        - hw/sd/pxa2xx_mmci.c
        - hw/timer/omap_gptimer.c
        - hw/timer/omap_synctimer.c
        - hw/timer/pxa2xx_timer.c
        - include/hw/arm/pxa.h
        - include/hw/arm/sharpsl.h
        - include/hw/arm/soc_dma.h
        - tcg/arm/tcg-target.h

Signed-off-by: Tanmay Patil <tanmaynpatil105@gmail.com>
---
 hw/arm/boot.c             |   8 +-
 hw/char/omap_uart.c       |  49 +-
 hw/dma/pxa2xx_dma.c       | 198 ++++----
 hw/gpio/omap_gpio.c       | 243 +++++-----
 hw/gpio/zaurus.c          |  61 +--
 hw/input/tsc2005.c        | 130 ++---
 hw/input/tsc210x.c        | 442 +++++++++--------
 hw/intc/omap_intc.c       | 261 +++++-----
 hw/misc/cbus.c            | 202 ++++----
 hw/misc/omap_clk.c        | 999 +++++++++++++++++++-------------------
 hw/misc/omap_l4.c         |  21 +-
 hw/misc/omap_sdrc.c       | 135 +++---
 hw/misc/omap_tap.c        |  28 +-
 hw/sd/omap_mmc.c          | 208 ++++----
 hw/sd/pxa2xx_mmci.c       | 149 +++---
 hw/timer/omap_gptimer.c   | 126 ++---
 hw/timer/omap_synctimer.c |   7 +-
 hw/timer/pxa2xx_timer.c   | 279 ++++++-----
 include/hw/arm/pxa.h      | 100 ++--
 include/hw/arm/sharpsl.h  |   2 +-
 include/hw/arm/soc_dma.h  |   4 +-
 tcg/arm/tcg-target.h      |   4 +-
 22 files changed, 1903 insertions(+), 1753 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 84ea6a807a..d480a7da02 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -347,13 +347,13 @@ static void set_kernel_args_old(const struct
arm_boot_info *info,
     WRITE_WORD(p, info->ram_size / 4096);
     /* ramdisk_size */
     WRITE_WORD(p, 0);
-#define FLAG_READONLY 1
-#define FLAG_RDLOAD 4
-#define FLAG_RDPROMPT 8
+#define FLAG_READONLY 1
+#define FLAG_RDLOAD   4
+#define FLAG_RDPROMPT 8
     /* flags */
     WRITE_WORD(p, FLAG_READONLY | FLAG_RDLOAD | FLAG_RDPROMPT);
     /* rootdev */
-    WRITE_WORD(p, (31 << 8) | 0); /* /dev/mtdblock0 */
+    WRITE_WORD(p, (31 << 8) | 0); /* /dev/mtdblock0 */
     /* video_num_cols */
     WRITE_WORD(p, 0);
     /* video_num_rows */
diff --git a/hw/char/omap_uart.c b/hw/char/omap_uart.c
index 6848bddb4e..c2ef4c137e 100644
--- a/hw/char/omap_uart.c
+++ b/hw/char/omap_uart.c
@@ -61,7 +61,7 @@ struct omap_uart_s *omap_uart_init(hwaddr base,
     s->fclk = fclk;
     s->irq = irq;
     s->serial = serial_mm_init(get_system_memory(), base, 2, irq,
-                               omap_clk_getrate(fclk)/16,
+                               omap_clk_getrate(fclk) / 16,
                                chr ?: qemu_chr_new(label, "null", NULL),
                                DEVICE_NATIVE_ENDIAN);
     return s;
@@ -76,27 +76,27 @@ static uint64_t omap_uart_read(void *opaque, hwaddr
addr, unsigned size)
     }

     switch (addr) {
-    case 0x20: /* MDR1 */
+    case 0x20:  /* MDR1 */
         return s->mdr[0];
-    case 0x24: /* MDR2 */
+    case 0x24:  /* MDR2 */
         return s->mdr[1];
-    case 0x40: /* SCR */
+    case 0x40:  /* SCR */
         return s->scr;
-    case 0x44: /* SSR */
+    case 0x44:  /* SSR */
         return 0x0;
-    case 0x48: /* EBLR (OMAP2) */
+    case 0x48:  /* EBLR (OMAP2) */
         return s->eblr;
-    case 0x4C: /* OSC_12M_SEL (OMAP1) */
+    case 0x4C:  /* OSC_12M_SEL (OMAP1) */
         return s->clksel;
-    case 0x50: /* MVR */
+    case 0x50:  /* MVR */
         return 0x30;
-    case 0x54: /* SYSC (OMAP2) */
+    case 0x54:  /* SYSC (OMAP2) */
         return s->syscontrol;
-    case 0x58: /* SYSS (OMAP2) */
+    case 0x58:  /* SYSS (OMAP2) */
         return 1;
-    case 0x5c: /* WER (OMAP2) */
+    case 0x5c:  /* WER (OMAP2) */
         return s->wkup;
-    case 0x60: /* CFPS (OMAP2) */
+    case 0x60:  /* CFPS (OMAP2) */
         return s->cfps;
     }

@@ -115,35 +115,36 @@ static void omap_uart_write(void *opaque, hwaddr addr,
     }

     switch (addr) {
-    case 0x20: /* MDR1 */
+    case 0x20:  /* MDR1 */
         s->mdr[0] = value & 0x7f;
         break;
-    case 0x24: /* MDR2 */
+    case 0x24:  /* MDR2 */
         s->mdr[1] = value & 0xff;
         break;
-    case 0x40: /* SCR */
+    case 0x40:  /* SCR */
         s->scr = value & 0xff;
         break;
-    case 0x48: /* EBLR (OMAP2) */
+    case 0x48:  /* EBLR (OMAP2) */
         s->eblr = value & 0xff;
         break;
-    case 0x4C: /* OSC_12M_SEL (OMAP1) */
+    case 0x4C:  /* OSC_12M_SEL (OMAP1) */
         s->clksel = value & 1;
         break;
-    case 0x44: /* SSR */
-    case 0x50: /* MVR */
-    case 0x58: /* SYSS (OMAP2) */
+    case 0x44:  /* SSR */
+    case 0x50:  /* MVR */
+    case 0x58:  /* SYSS (OMAP2) */
         OMAP_RO_REG(addr);
         break;
-    case 0x54: /* SYSC (OMAP2) */
+    case 0x54:  /* SYSC (OMAP2) */
         s->syscontrol = value & 0x1d;
-        if (value & 2)
+        if (value & 2) {
             omap_uart_reset(s);
+        }
         break;
-    case 0x5c: /* WER (OMAP2) */
+    case 0x5c:  /* WER (OMAP2) */
         s->wkup = value & 0x7f;
         break;
-    case 0x60: /* CFPS (OMAP2) */
+    case 0x60:  /* CFPS (OMAP2) */
         s->cfps = value & 0xff;
         break;
     default:
diff --git a/hw/dma/pxa2xx_dma.c b/hw/dma/pxa2xx_dma.c
index 9f62f0b633..beed1cd9a5 100644
--- a/hw/dma/pxa2xx_dma.c
+++ b/hw/dma/pxa2xx_dma.c
@@ -61,98 +61,104 @@ struct PXA2xxDMAState {
     int running;
 };

-#define DCSR0 0x0000 /* DMA Control / Status register for Channel 0 */
-#define DCSR31 0x007c /* DMA Control / Status register for Channel 31 */
-#define DALGN 0x00a0 /* DMA Alignment register */
-#define DPCSR 0x00a4 /* DMA Programmed I/O Control Status register */
-#define DRQSR0 0x00e0 /* DMA DREQ<0> Status register */
-#define DRQSR1 0x00e4 /* DMA DREQ<1> Status register */
-#define DRQSR2 0x00e8 /* DMA DREQ<2> Status register */
-#define DINT 0x00f0 /* DMA Interrupt register */
-#define DRCMR0 0x0100 /* Request to Channel Map register 0 */
-#define DRCMR63 0x01fc /* Request to Channel Map register 63 */
-#define D_CH0 0x0200 /* Channel 0 Descriptor start */
-#define DRCMR64 0x1100 /* Request to Channel Map register 64 */
-#define DRCMR74 0x1128 /* Request to Channel Map register 74 */
+#define DCSR0   0x0000  /* DMA Control / Status register for Channel 0 */
+#define DCSR31  0x007c  /* DMA Control / Status register for Channel 31 */
+#define DALGN   0x00a0  /* DMA Alignment register */
+#define DPCSR   0x00a4  /* DMA Programmed I/O Control Status register */
+#define DRQSR0  0x00e0  /* DMA DREQ<0> Status register */
+#define DRQSR1  0x00e4  /* DMA DREQ<1> Status register */
+#define DRQSR2  0x00e8  /* DMA DREQ<2> Status register */
+#define DINT    0x00f0  /* DMA Interrupt register */
+#define DRCMR0  0x0100  /* Request to Channel Map register 0 */
+#define DRCMR63 0x01fc  /* Request to Channel Map register 63 */
+#define D_CH0   0x0200  /* Channel 0 Descriptor start */
+#define DRCMR64 0x1100  /* Request to Channel Map register 64 */
+#define DRCMR74 0x1128  /* Request to Channel Map register 74 */

 /* Per-channel register */
-#define DDADR 0x00
-#define DSADR 0x01
-#define DTADR 0x02
-#define DCMD 0x03
+#define DDADR 0x00
+#define DSADR 0x01
+#define DTADR 0x02
+#define DCMD  0x03

 /* Bit-field masks */
-#define DRCMR_CHLNUM 0x1f
-#define DRCMR_MAPVLD (1 << 7)
-#define DDADR_STOP (1 << 0)
-#define DDADR_BREN (1 << 1)
-#define DCMD_LEN 0x1fff
-#define DCMD_WIDTH(x) (1 << ((((x) >> 14) & 3) - 1))
-#define DCMD_SIZE(x) (4 << (((x) >> 16) & 3))
-#define DCMD_FLYBYT (1 << 19)
-#define DCMD_FLYBYS (1 << 20)
-#define DCMD_ENDIRQEN (1 << 21)
-#define DCMD_STARTIRQEN (1 << 22)
-#define DCMD_CMPEN (1 << 25)
-#define DCMD_FLOWTRG (1 << 28)
-#define DCMD_FLOWSRC (1 << 29)
-#define DCMD_INCTRGADDR (1 << 30)
-#define DCMD_INCSRCADDR (1 << 31)
-#define DCSR_BUSERRINTR (1 << 0)
-#define DCSR_STARTINTR (1 << 1)
-#define DCSR_ENDINTR (1 << 2)
-#define DCSR_STOPINTR (1 << 3)
-#define DCSR_RASINTR (1 << 4)
-#define DCSR_REQPEND (1 << 8)
-#define DCSR_EORINT (1 << 9)
-#define DCSR_CMPST (1 << 10)
-#define DCSR_MASKRUN (1 << 22)
-#define DCSR_RASIRQEN (1 << 23)
-#define DCSR_CLRCMPST (1 << 24)
-#define DCSR_SETCMPST (1 << 25)
-#define DCSR_EORSTOPEN (1 << 26)
-#define DCSR_EORJMPEN (1 << 27)
-#define DCSR_EORIRQEN (1 << 28)
-#define DCSR_STOPIRQEN (1 << 29)
-#define DCSR_NODESCFETCH (1 << 30)
-#define DCSR_RUN (1 << 31)
+#define DRCMR_CHLNUM     0x1f
+#define DRCMR_MAPVLD     (1 << 7)
+#define DDADR_STOP       (1 << 0)
+#define DDADR_BREN       (1 << 1)
+#define DCMD_LEN         0x1fff
+#define DCMD_WIDTH(x)    (1 << ((((x) >> 14) & 3) - 1))
+#define DCMD_SIZE(x)     (4 << (((x) >> 16) & 3))
+#define DCMD_FLYBYT      (1 << 19)
+#define DCMD_FLYBYS      (1 << 20)
+#define DCMD_ENDIRQEN    (1 << 21)
+#define DCMD_STARTIRQEN  (1 << 22)
+#define DCMD_CMPEN       (1 << 25)
+#define DCMD_FLOWTRG     (1 << 28)
+#define DCMD_FLOWSRC     (1 << 29)
+#define DCMD_INCTRGADDR  (1 << 30)
+#define DCMD_INCSRCADDR  (1 << 31)
+#define DCSR_BUSERRINTR  (1 << 0)
+#define DCSR_STARTINTR   (1 << 1)
+#define DCSR_ENDINTR     (1 << 2)
+#define DCSR_STOPINTR    (1 << 3)
+#define DCSR_RASINTR     (1 << 4)
+#define DCSR_REQPEND     (1 << 8)
+#define DCSR_EORINT      (1 << 9)
+#define DCSR_CMPST       (1 << 10)
+#define DCSR_MASKRUN     (1 << 22)
+#define DCSR_RASIRQEN    (1 << 23)
+#define DCSR_CLRCMPST    (1 << 24)
+#define DCSR_SETCMPST    (1 << 25)
+#define DCSR_EORSTOPEN   (1 << 26)
+#define DCSR_EORJMPEN    (1 << 27)
+#define DCSR_EORIRQEN    (1 << 28)
+#define DCSR_STOPIRQEN   (1 << 29)
+#define DCSR_NODESCFETCH (1 << 30)
+#define DCSR_RUN         (1 << 31)

 static inline void pxa2xx_dma_update(PXA2xxDMAState *s, int ch)
 {
     if (ch >= 0) {
         if ((s->chan[ch].state & DCSR_STOPIRQEN) &&
-                (s->chan[ch].state & DCSR_STOPINTR))
+                (s->chan[ch].state & DCSR_STOPINTR)) {
             s->stopintr |= 1 << ch;
-        else
+        } else {
             s->stopintr &= ~(1 << ch);
+        }

         if ((s->chan[ch].state & DCSR_EORIRQEN) &&
-                (s->chan[ch].state & DCSR_EORINT))
+                (s->chan[ch].state & DCSR_EORINT)) {
             s->eorintr |= 1 << ch;
-        else
+        } else {
             s->eorintr &= ~(1 << ch);
+        }

         if ((s->chan[ch].state & DCSR_RASIRQEN) &&
-                (s->chan[ch].state & DCSR_RASINTR))
+                (s->chan[ch].state & DCSR_RASINTR)) {
             s->rasintr |= 1 << ch;
-        else
+        } else {
             s->rasintr &= ~(1 << ch);
+        }

-        if (s->chan[ch].state & DCSR_STARTINTR)
+        if (s->chan[ch].state & DCSR_STARTINTR) {
             s->startintr |= 1 << ch;
-        else
+        } else {
             s->startintr &= ~(1 << ch);
+        }

-        if (s->chan[ch].state & DCSR_ENDINTR)
+        if (s->chan[ch].state & DCSR_ENDINTR) {
             s->endintr |= 1 << ch;
-        else
+        } else {
             s->endintr &= ~(1 << ch);
+        }
     }

-    if (s->stopintr | s->eorintr | s->rasintr | s->startintr | s->endintr)
+    if (s->stopintr | s->eorintr | s->rasintr | s->startintr | s->endintr)
{
         qemu_irq_raise(s->irq);
-    else
+    } else {
         qemu_irq_lower(s->irq);
+    }
 }

 static inline void pxa2xx_dma_descriptor_fetch(
@@ -160,8 +166,9 @@ static inline void pxa2xx_dma_descriptor_fetch(
 {
     uint32_t desc[4];
     hwaddr daddr = s->chan[ch].descr & ~0xf;
-    if ((s->chan[ch].descr & DDADR_BREN) && (s->chan[ch].state &
DCSR_CMPST))
+    if ((s->chan[ch].descr & DDADR_BREN) && (s->chan[ch].state &
DCSR_CMPST)) {
         daddr += 32;
+    }

     cpu_physical_memory_read(daddr, desc, 16);
     s->chan[ch].descr = desc[DDADR];
@@ -169,16 +176,20 @@ static inline void pxa2xx_dma_descriptor_fetch(
     s->chan[ch].dest = desc[DTADR];
     s->chan[ch].cmd = desc[DCMD];

-    if (s->chan[ch].cmd & DCMD_FLOWSRC)
+    if (s->chan[ch].cmd & DCMD_FLOWSRC) {
         s->chan[ch].src &= ~3;
-    if (s->chan[ch].cmd & DCMD_FLOWTRG)
+    }
+    if (s->chan[ch].cmd & DCMD_FLOWTRG) {
         s->chan[ch].dest &= ~3;
+    }

-    if (s->chan[ch].cmd & (DCMD_CMPEN | DCMD_FLYBYS | DCMD_FLYBYT))
+    if (s->chan[ch].cmd & (DCMD_CMPEN | DCMD_FLYBYS | DCMD_FLYBYT)) {
         printf("%s: unsupported mode in channel %i\n", __func__, ch);
+    }

-    if (s->chan[ch].cmd & DCMD_STARTIRQEN)
+    if (s->chan[ch].cmd & DCMD_STARTIRQEN) {
         s->chan[ch].state |= DCSR_STARTINTR;
+    }
 }

 static void pxa2xx_dma_run(PXA2xxDMAState *s)
@@ -190,18 +201,20 @@ static void pxa2xx_dma_run(PXA2xxDMAState *s)
     uint8_t buffer[32];
     PXA2xxDMAChannel *ch;

-    if (s->running ++)
+    if (s->running++) {
         return;
+    }

     while (s->running) {
         s->running = 1;
-        for (c = 0; c < s->channels; c ++) {
+        for (c = 0; c < s->channels; c++) {
             ch = &s->chan[c];

             while ((ch->state & DCSR_RUN) && !(ch->state & DCSR_STOPINTR))
{
                 /* Test for pending requests */
-                if ((ch->cmd & (DCMD_FLOWSRC | DCMD_FLOWTRG)) &&
!ch->request)
+                if ((ch->cmd & (DCMD_FLOWSRC | DCMD_FLOWTRG)) &&
!ch->request) {
                     break;
+                }

                 length = ch->cmd & DCMD_LEN;
                 size = DCMD_SIZE(ch->cmd);
@@ -228,11 +241,13 @@ static void pxa2xx_dma_run(PXA2xxDMAState *s)
                     if ((ch->cmd & (DCMD_FLOWSRC | DCMD_FLOWTRG)) &&
                             !ch->request) {
                         ch->state |= DCSR_EORINT;
-                        if (ch->state & DCSR_EORSTOPEN)
+                        if (ch->state & DCSR_EORSTOPEN) {
                             ch->state |= DCSR_STOPINTR;
+                        }
                         if ((ch->state & DCSR_EORJMPEN) &&
-                                        !(ch->state & DCSR_NODESCFETCH))
+                                        !(ch->state & DCSR_NODESCFETCH)) {
                             pxa2xx_dma_descriptor_fetch(s, c);
+                        }
                         break;
                     }
                 }
@@ -241,8 +256,9 @@ static void pxa2xx_dma_run(PXA2xxDMAState *s)

                 /* Is the transfer complete now? */
                 if (!length) {
-                    if (ch->cmd & DCMD_ENDIRQEN)
+                    if (ch->cmd & DCMD_ENDIRQEN) {
                         ch->state |= DCSR_ENDINTR;
+                    }

                     if ((ch->state & DCSR_NODESCFETCH) ||
                                 (ch->descr & DDADR_STOP) ||
@@ -259,7 +275,7 @@ static void pxa2xx_dma_run(PXA2xxDMAState *s)
             }
         }

-        s->running --;
+        s->running--;
     }
 }

@@ -290,8 +306,9 @@ static uint64_t pxa2xx_dma_read(void *opaque, hwaddr
offset,

     case DCSR0 ... DCSR31:
         channel = offset >> 2;
-        if (s->chan[channel].request)
+        if (s->chan[channel].request) {
             return s->chan[channel].state | DCSR_REQPEND;
+        }
         return s->chan[channel].state;

     case DINT:
@@ -363,8 +380,9 @@ static void pxa2xx_dma_write(void *opaque, hwaddr
offset,
                          DCSR_STARTINTR | DCSR_BUSERRINTR));
         s->chan[channel].state |= value & 0xfc800000;

-        if (s->chan[channel].state & DCSR_STOPIRQEN)
+        if (s->chan[channel].state & DCSR_STOPIRQEN) {
             s->chan[channel].state &= ~DCSR_STOPINTR;
+        }

         if (value & DCSR_NODESCFETCH) {
             /* No-descriptor-fetch mode */
@@ -382,13 +400,16 @@ static void pxa2xx_dma_write(void *opaque, hwaddr
offset,
         }

         /* Shouldn't matter as our DMA is synchronous.  */
-        if (!(value & (DCSR_RUN | DCSR_MASKRUN)))
+        if (!(value & (DCSR_RUN | DCSR_MASKRUN))) {
             s->chan[channel].state |= DCSR_STOPINTR;
+        }

-        if (value & DCSR_CLRCMPST)
+        if (value & DCSR_CLRCMPST) {
             s->chan[channel].state &= ~DCSR_CMPST;
-        if (value & DCSR_SETCMPST)
+        }
+        if (value & DCSR_SETCMPST) {
             s->chan[channel].state |= DCSR_CMPST;
+        }

         pxa2xx_dma_update(s, channel);
         break;
@@ -439,19 +460,23 @@ static void pxa2xx_dma_request(void *opaque, int
req_num, int on)
 {
     PXA2xxDMAState *s = opaque;
     int ch;
-    if (req_num < 0 || req_num >= PXA2XX_DMA_NUM_REQUESTS)
+    if (req_num < 0 || req_num >= PXA2XX_DMA_NUM_REQUESTS) {
         hw_error("%s: Bad DMA request %i\n", __func__, req_num);
+    }

-    if (!(s->req[req_num] & DRCMR_MAPVLD))
+    if (!(s->req[req_num] & DRCMR_MAPVLD)) {
         return;
+    }
     ch = s->req[req_num] & DRCMR_CHLNUM;

-    if (!s->chan[ch].request && on)
+    if (!s->chan[ch].request && on) {
         s->chan[ch].state |= DCSR_RASINTR;
-    else
+    } else {
         s->chan[ch].state &= ~DCSR_RASINTR;
-    if (s->chan[ch].request && !on)
+    }
+    if (s->chan[ch].request && !on) {
         s->chan[ch].state |= DCSR_EORINT;
+    }

     s->chan[ch].request = on;
     if (on) {
@@ -488,8 +513,9 @@ static void pxa2xx_dma_realize(DeviceState *dev, Error
**errp)

     s->chan = g_new0(PXA2xxDMAChannel, s->channels);

-    for (i = 0; i < s->channels; i ++)
+    for (i = 0; i < s->channels; i++) {
         s->chan[i].state = DCSR_STOPINTR;
+    }
 }

 DeviceState *pxa27x_dma_init(hwaddr base, qemu_irq irq)
diff --git a/hw/gpio/omap_gpio.c b/hw/gpio/omap_gpio.c
index a3341d70f1..60e97a0839 100644
--- a/hw/gpio/omap_gpio.c
+++ b/hw/gpio/omap_gpio.c
@@ -57,10 +57,11 @@ static void omap_gpio_set(void *opaque, int line, int
level)
     struct omap_gpio_s *s = &p->omap1;
     uint16_t prev = s->inputs;

-    if (level)
+    if (level) {
         s->inputs |= 1 << line;
-    else
+    } else {
         s->inputs &= ~(1 << line);
+    }

     if (((s->edge & s->inputs & ~prev) | (~s->edge & ~s->inputs & prev)) &
                     (1 << line) & s->dir & ~s->mask) {
@@ -80,25 +81,25 @@ static uint64_t omap_gpio_read(void *opaque, hwaddr
addr,
     }

     switch (offset) {
-    case 0x00: /* DATA_INPUT */
+    case 0x00:  /* DATA_INPUT */
         return s->inputs & s->pins;

-    case 0x04: /* DATA_OUTPUT */
+    case 0x04:  /* DATA_OUTPUT */
         return s->outputs;

-    case 0x08: /* DIRECTION_CONTROL */
+    case 0x08:  /* DIRECTION_CONTROL */
         return s->dir;

-    case 0x0c: /* INTERRUPT_CONTROL */
+    case 0x0c:  /* INTERRUPT_CONTROL */
         return s->edge;

-    case 0x10: /* INTERRUPT_MASK */
+    case 0x10:  /* INTERRUPT_MASK */
         return s->mask;

-    case 0x14: /* INTERRUPT_STATUS */
+    case 0x14:  /* INTERRUPT_STATUS */
         return s->ints;

-    case 0x18: /* PIN_CONTROL (not in OMAP310) */
+    case 0x18:  /* PIN_CONTROL (not in OMAP310) */
         OMAP_BAD_REG(addr);
         return s->pins;
     }
@@ -121,47 +122,50 @@ static void omap_gpio_write(void *opaque, hwaddr addr,
     }

     switch (offset) {
-    case 0x00: /* DATA_INPUT */
+    case 0x00:  /* DATA_INPUT */
         OMAP_RO_REG(addr);
         return;

-    case 0x04: /* DATA_OUTPUT */
+    case 0x04:  /* DATA_OUTPUT */
         diff = (s->outputs ^ value) & ~s->dir;
         s->outputs = value;
         while ((ln = ctz32(diff)) != 32) {
-            if (s->handler[ln])
+            if (s->handler[ln]) {
                 qemu_set_irq(s->handler[ln], (value >> ln) & 1);
+            }
             diff &= ~(1 << ln);
         }
         break;

-    case 0x08: /* DIRECTION_CONTROL */
+    case 0x08:  /* DIRECTION_CONTROL */
         diff = s->outputs & (s->dir ^ value);
         s->dir = value;

         value = s->outputs & ~s->dir;
         while ((ln = ctz32(diff)) != 32) {
-            if (s->handler[ln])
+            if (s->handler[ln]) {
                 qemu_set_irq(s->handler[ln], (value >> ln) & 1);
+            }
             diff &= ~(1 << ln);
         }
         break;

-    case 0x0c: /* INTERRUPT_CONTROL */
+    case 0x0c:  /* INTERRUPT_CONTROL */
         s->edge = value;
         break;

-    case 0x10: /* INTERRUPT_MASK */
+    case 0x10:  /* INTERRUPT_MASK */
         s->mask = value;
         break;

-    case 0x14: /* INTERRUPT_STATUS */
+    case 0x14:  /* INTERRUPT_STATUS */
         s->ints &= ~value;
-        if (!s->ints)
+        if (!s->ints) {
             qemu_irq_lower(s->irq);
+        }
         break;

-    case 0x18: /* PIN_CONTROL (not in OMAP310 TRM) */
+    case 0x18:  /* PIN_CONTROL (not in OMAP310 TRM) */
         OMAP_BAD_REG(addr);
         s->pins = value;
         break;
@@ -233,12 +237,15 @@ static inline void
omap2_gpio_module_int_update(struct omap2_gpio_s *s,

 static void omap2_gpio_module_wake(struct omap2_gpio_s *s, int line)
 {
-    if (!(s->config[0] & (1 << 2))) /* ENAWAKEUP */
+    if (!(s->config[0] & (1 << 2))) {   /* ENAWAKEUP */
         return;
-    if (!(s->config[0] & (3 << 3))) /* Force Idle */
+    }
+    if (!(s->config[0] & (3 << 3))) {   /* Force Idle */
         return;
-    if (!(s->wumask & (1 << line)))
+    }
+    if (!(s->wumask & (1 << line))) {
         return;
+    }

     qemu_irq_raise(s->wkup);
 }
@@ -279,12 +286,14 @@ static void omap2_gpio_set(void *opaque, int line,
int level)

     line &= 31;
     if (level) {
-        if (s->dir & (1 << line) & ((~s->inputs & s->edge[0]) |
s->level[1]))
+        if (s->dir & (1 << line) & ((~s->inputs & s->edge[0]) |
s->level[1])) {
             omap2_gpio_module_int(s, line);
+        }
         s->inputs |= 1 << line;
     } else {
-        if (s->dir & (1 << line) & ((s->inputs & s->edge[1]) |
s->level[0]))
+        if (s->dir & (1 << line) & ((s->inputs & s->edge[1]) |
s->level[0])) {
             omap2_gpio_module_int(s, line);
+        }
         s->inputs &= ~(1 << line);
     }
 }
@@ -312,66 +321,66 @@ static uint32_t omap2_gpio_module_read(void *opaque,
hwaddr addr)
     struct omap2_gpio_s *s = opaque;

     switch (addr) {
-    case 0x00: /* GPIO_REVISION */
+    case 0x00:  /* GPIO_REVISION */
         return s->revision;

-    case 0x10: /* GPIO_SYSCONFIG */
+    case 0x10:  /* GPIO_SYSCONFIG */
         return s->config[0];

-    case 0x14: /* GPIO_SYSSTATUS */
+    case 0x14:  /* GPIO_SYSSTATUS */
         return 0x01;

-    case 0x18: /* GPIO_IRQSTATUS1 */
+    case 0x18:  /* GPIO_IRQSTATUS1 */
         return s->ints[0];

-    case 0x1c: /* GPIO_IRQENABLE1 */
-    case 0x60: /* GPIO_CLEARIRQENABLE1 */
-    case 0x64: /* GPIO_SETIRQENABLE1 */
+    case 0x1c:  /* GPIO_IRQENABLE1 */
+    case 0x60:  /* GPIO_CLEARIRQENABLE1 */
+    case 0x64:  /* GPIO_SETIRQENABLE1 */
         return s->mask[0];

-    case 0x20: /* GPIO_WAKEUPENABLE */
-    case 0x80: /* GPIO_CLEARWKUENA */
-    case 0x84: /* GPIO_SETWKUENA */
+    case 0x20:  /* GPIO_WAKEUPENABLE */
+    case 0x80:  /* GPIO_CLEARWKUENA */
+    case 0x84:  /* GPIO_SETWKUENA */
         return s->wumask;

-    case 0x28: /* GPIO_IRQSTATUS2 */
+    case 0x28:  /* GPIO_IRQSTATUS2 */
         return s->ints[1];

-    case 0x2c: /* GPIO_IRQENABLE2 */
-    case 0x70: /* GPIO_CLEARIRQENABLE2 */
-    case 0x74: /* GPIO_SETIREQNEABLE2 */
+    case 0x2c:  /* GPIO_IRQENABLE2 */
+    case 0x70:  /* GPIO_CLEARIRQENABLE2 */
+    case 0x74:  /* GPIO_SETIREQNEABLE2 */
         return s->mask[1];

-    case 0x30: /* GPIO_CTRL */
+    case 0x30:  /* GPIO_CTRL */
         return s->config[1];

-    case 0x34: /* GPIO_OE */
+    case 0x34:  /* GPIO_OE */
         return s->dir;

-    case 0x38: /* GPIO_DATAIN */
+    case 0x38:  /* GPIO_DATAIN */
         return s->inputs;

-    case 0x3c: /* GPIO_DATAOUT */
-    case 0x90: /* GPIO_CLEARDATAOUT */
-    case 0x94: /* GPIO_SETDATAOUT */
+    case 0x3c:  /* GPIO_DATAOUT */
+    case 0x90:  /* GPIO_CLEARDATAOUT */
+    case 0x94:  /* GPIO_SETDATAOUT */
         return s->outputs;

-    case 0x40: /* GPIO_LEVELDETECT0 */
+    case 0x40:  /* GPIO_LEVELDETECT0 */
         return s->level[0];

-    case 0x44: /* GPIO_LEVELDETECT1 */
+    case 0x44:  /* GPIO_LEVELDETECT1 */
         return s->level[1];

-    case 0x48: /* GPIO_RISINGDETECT */
+    case 0x48:  /* GPIO_RISINGDETECT */
         return s->edge[0];

-    case 0x4c: /* GPIO_FALLINGDETECT */
+    case 0x4c:  /* GPIO_FALLINGDETECT */
         return s->edge[1];

-    case 0x50: /* GPIO_DEBOUNCENABLE */
+    case 0x50:  /* GPIO_DEBOUNCENABLE */
         return s->debounce;

-    case 0x54: /* GPIO_DEBOUNCINGTIME */
+    case 0x54:  /* GPIO_DEBOUNCINGTIME */
         return s->delay;
     }

@@ -387,55 +396,56 @@ static void omap2_gpio_module_write(void *opaque,
hwaddr addr,
     int ln;

     switch (addr) {
-    case 0x00: /* GPIO_REVISION */
-    case 0x14: /* GPIO_SYSSTATUS */
-    case 0x38: /* GPIO_DATAIN */
+    case 0x00:  /* GPIO_REVISION */
+    case 0x14:  /* GPIO_SYSSTATUS */
+    case 0x38:  /* GPIO_DATAIN */
         OMAP_RO_REG(addr);
         break;

-    case 0x10: /* GPIO_SYSCONFIG */
+    case 0x10:  /* GPIO_SYSCONFIG */
         if (((value >> 3) & 3) == 3) {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "%s: Illegal IDLEMODE value: 3\n", __func__);
         }
-        if (value & 2)
+        if (value & 2) {
             omap2_gpio_module_reset(s);
+        }
         s->config[0] = value & 0x1d;
         break;

-    case 0x18: /* GPIO_IRQSTATUS1 */
+    case 0x18:  /* GPIO_IRQSTATUS1 */
         if (s->ints[0] & value) {
             s->ints[0] &= ~value;
             omap2_gpio_module_level_update(s, 0);
         }
         break;

-    case 0x1c: /* GPIO_IRQENABLE1 */
+    case 0x1c:  /* GPIO_IRQENABLE1 */
         s->mask[0] = value;
         omap2_gpio_module_int_update(s, 0);
         break;

-    case 0x20: /* GPIO_WAKEUPENABLE */
+    case 0x20:  /* GPIO_WAKEUPENABLE */
         s->wumask = value;
         break;

-    case 0x28: /* GPIO_IRQSTATUS2 */
+    case 0x28:  /* GPIO_IRQSTATUS2 */
         if (s->ints[1] & value) {
             s->ints[1] &= ~value;
             omap2_gpio_module_level_update(s, 1);
         }
         break;

-    case 0x2c: /* GPIO_IRQENABLE2 */
+    case 0x2c:  /* GPIO_IRQENABLE2 */
         s->mask[1] = value;
         omap2_gpio_module_int_update(s, 1);
         break;

-    case 0x30: /* GPIO_CTRL */
+    case 0x30:  /* GPIO_CTRL */
         s->config[1] = value & 7;
         break;

-    case 0x34: /* GPIO_OE */
+    case 0x34:  /* GPIO_OE */
         diff = s->outputs & (s->dir ^ value);
         s->dir = value;

@@ -449,71 +459,71 @@ static void omap2_gpio_module_write(void *opaque,
hwaddr addr,
         omap2_gpio_module_level_update(s, 1);
         break;

-    case 0x3c: /* GPIO_DATAOUT */
+    case 0x3c:  /* GPIO_DATAOUT */
         omap2_gpio_module_out_update(s, s->outputs ^ value);
         break;

-    case 0x40: /* GPIO_LEVELDETECT0 */
+    case 0x40:  /* GPIO_LEVELDETECT0 */
         s->level[0] = value;
         omap2_gpio_module_level_update(s, 0);
         omap2_gpio_module_level_update(s, 1);
         break;

-    case 0x44: /* GPIO_LEVELDETECT1 */
+    case 0x44:  /* GPIO_LEVELDETECT1 */
         s->level[1] = value;
         omap2_gpio_module_level_update(s, 0);
         omap2_gpio_module_level_update(s, 1);
         break;

-    case 0x48: /* GPIO_RISINGDETECT */
+    case 0x48:  /* GPIO_RISINGDETECT */
         s->edge[0] = value;
         break;

-    case 0x4c: /* GPIO_FALLINGDETECT */
+    case 0x4c:  /* GPIO_FALLINGDETECT */
         s->edge[1] = value;
         break;

-    case 0x50: /* GPIO_DEBOUNCENABLE */
+    case 0x50:  /* GPIO_DEBOUNCENABLE */
         s->debounce = value;
         break;

-    case 0x54: /* GPIO_DEBOUNCINGTIME */
+    case 0x54:  /* GPIO_DEBOUNCINGTIME */
         s->delay = value;
         break;

-    case 0x60: /* GPIO_CLEARIRQENABLE1 */
+    case 0x60:  /* GPIO_CLEARIRQENABLE1 */
         s->mask[0] &= ~value;
         omap2_gpio_module_int_update(s, 0);
         break;

-    case 0x64: /* GPIO_SETIRQENABLE1 */
+    case 0x64:  /* GPIO_SETIRQENABLE1 */
         s->mask[0] |= value;
         omap2_gpio_module_int_update(s, 0);
         break;

-    case 0x70: /* GPIO_CLEARIRQENABLE2 */
+    case 0x70:  /* GPIO_CLEARIRQENABLE2 */
         s->mask[1] &= ~value;
         omap2_gpio_module_int_update(s, 1);
         break;

-    case 0x74: /* GPIO_SETIREQNEABLE2 */
+    case 0x74:  /* GPIO_SETIREQNEABLE2 */
         s->mask[1] |= value;
         omap2_gpio_module_int_update(s, 1);
         break;

-    case 0x80: /* GPIO_CLEARWKUENA */
+    case 0x80:  /* GPIO_CLEARWKUENA */
         s->wumask &= ~value;
         break;

-    case 0x84: /* GPIO_SETWKUENA */
+    case 0x84:  /* GPIO_SETWKUENA */
         s->wumask |= value;
         break;

-    case 0x90: /* GPIO_CLEARDATAOUT */
+    case 0x90:  /* GPIO_CLEARDATAOUT */
         omap2_gpio_module_out_update(s, s->outputs & value);
         break;

-    case 0x94: /* GPIO_SETDATAOUT */
+    case 0x94:  /* GPIO_SETDATAOUT */
         omap2_gpio_module_out_update(s, ~s->outputs & value);
         break;

@@ -541,39 +551,39 @@ static void omap2_gpio_module_writep(void *opaque,
hwaddr addr,
     }

     switch (addr & ~3) {
-    case 0x00: /* GPIO_REVISION */
-    case 0x14: /* GPIO_SYSSTATUS */
-    case 0x38: /* GPIO_DATAIN */
+    case 0x00:  /* GPIO_REVISION */
+    case 0x14:  /* GPIO_SYSSTATUS */
+    case 0x38:  /* GPIO_DATAIN */
         OMAP_RO_REG(addr);
         break;

-    case 0x10: /* GPIO_SYSCONFIG */
-    case 0x1c: /* GPIO_IRQENABLE1 */
-    case 0x20: /* GPIO_WAKEUPENABLE */
-    case 0x2c: /* GPIO_IRQENABLE2 */
-    case 0x30: /* GPIO_CTRL */
-    case 0x34: /* GPIO_OE */
-    case 0x3c: /* GPIO_DATAOUT */
-    case 0x40: /* GPIO_LEVELDETECT0 */
-    case 0x44: /* GPIO_LEVELDETECT1 */
-    case 0x48: /* GPIO_RISINGDETECT */
-    case 0x4c: /* GPIO_FALLINGDETECT */
-    case 0x50: /* GPIO_DEBOUNCENABLE */
-    case 0x54: /* GPIO_DEBOUNCINGTIME */
+    case 0x10:  /* GPIO_SYSCONFIG */
+    case 0x1c:  /* GPIO_IRQENABLE1 */
+    case 0x20:  /* GPIO_WAKEUPENABLE */
+    case 0x2c:  /* GPIO_IRQENABLE2 */
+    case 0x30:  /* GPIO_CTRL */
+    case 0x34:  /* GPIO_OE */
+    case 0x3c:  /* GPIO_DATAOUT */
+    case 0x40:  /* GPIO_LEVELDETECT0 */
+    case 0x44:  /* GPIO_LEVELDETECT1 */
+    case 0x48:  /* GPIO_RISINGDETECT */
+    case 0x4c:  /* GPIO_FALLINGDETECT */
+    case 0x50:  /* GPIO_DEBOUNCENABLE */
+    case 0x54:  /* GPIO_DEBOUNCINGTIME */
         cur = omap2_gpio_module_read(opaque, addr & ~3) &
                 ~(mask << ((addr & 3) << 3));

         /* Fall through.  */
-    case 0x18: /* GPIO_IRQSTATUS1 */
-    case 0x28: /* GPIO_IRQSTATUS2 */
-    case 0x60: /* GPIO_CLEARIRQENABLE1 */
-    case 0x64: /* GPIO_SETIRQENABLE1 */
-    case 0x70: /* GPIO_CLEARIRQENABLE2 */
-    case 0x74: /* GPIO_SETIREQNEABLE2 */
-    case 0x80: /* GPIO_CLEARWKUENA */
-    case 0x84: /* GPIO_SETWKUENA */
-    case 0x90: /* GPIO_CLEARDATAOUT */
-    case 0x94: /* GPIO_SETDATAOUT */
+    case 0x18:  /* GPIO_IRQSTATUS1 */
+    case 0x28:  /* GPIO_IRQSTATUS2 */
+    case 0x60:  /* GPIO_CLEARIRQENABLE1 */
+    case 0x64:  /* GPIO_SETIRQENABLE1 */
+    case 0x70:  /* GPIO_CLEARIRQENABLE2 */
+    case 0x74:  /* GPIO_SETIREQNEABLE2 */
+    case 0x80:  /* GPIO_CLEARWKUENA */
+    case 0x84:  /* GPIO_SETWKUENA */
+    case 0x90:  /* GPIO_CLEARDATAOUT */
+    case 0x94:  /* GPIO_SETDATAOUT */
         value <<= (addr & 3) << 3;
         omap2_gpio_module_write(opaque, addr, cur | value);
         break;
@@ -616,22 +626,22 @@ static uint64_t omap2_gpif_top_read(void *opaque,
hwaddr addr, unsigned size)
     Omap2GpioState *s = opaque;

     switch (addr) {
-    case 0x00: /* IPGENERICOCPSPL_REVISION */
+    case 0x00:  /* IPGENERICOCPSPL_REVISION */
         return 0x18;

-    case 0x10: /* IPGENERICOCPSPL_SYSCONFIG */
+    case 0x10:  /* IPGENERICOCPSPL_SYSCONFIG */
         return s->autoidle;

-    case 0x14: /* IPGENERICOCPSPL_SYSSTATUS */
+    case 0x14:  /* IPGENERICOCPSPL_SYSSTATUS */
         return 0x01;

-    case 0x18: /* IPGENERICOCPSPL_IRQSTATUS */
+    case 0x18:  /* IPGENERICOCPSPL_IRQSTATUS */
         return 0x00;

-    case 0x40: /* IPGENERICOCPSPL_GPO */
+    case 0x40:  /* IPGENERICOCPSPL_GPO */
         return s->gpo;

-    case 0x50: /* IPGENERICOCPSPL_GPI */
+    case 0x50:  /* IPGENERICOCPSPL_GPI */
         return 0x00;
     }

@@ -645,20 +655,21 @@ static void omap2_gpif_top_write(void *opaque, hwaddr
addr,
     Omap2GpioState *s = opaque;

     switch (addr) {
-    case 0x00: /* IPGENERICOCPSPL_REVISION */
-    case 0x14: /* IPGENERICOCPSPL_SYSSTATUS */
-    case 0x18: /* IPGENERICOCPSPL_IRQSTATUS */
-    case 0x50: /* IPGENERICOCPSPL_GPI */
+    case 0x00:  /* IPGENERICOCPSPL_REVISION */
+    case 0x14:  /* IPGENERICOCPSPL_SYSSTATUS */
+    case 0x18:  /* IPGENERICOCPSPL_IRQSTATUS */
+    case 0x50:  /* IPGENERICOCPSPL_GPI */
         OMAP_RO_REG(addr);
         break;

-    case 0x10: /* IPGENERICOCPSPL_SYSCONFIG */
-        if (value & (1 << 1)) /* SOFTRESET */
+    case 0x10:  /* IPGENERICOCPSPL_SYSCONFIG */
+        if (value & (1 << 1)) {       /* SOFTRESET */
             omap2_gpif_reset(DEVICE(s));
+        }
         s->autoidle = value & 1;
         break;

-    case 0x40: /* IPGENERICOCPSPL_GPO */
+    case 0x40:  /* IPGENERICOCPSPL_GPO */
         s->gpo = value & 1;
         break;

diff --git a/hw/gpio/zaurus.c b/hw/gpio/zaurus.c
index 5884804c58..7342440b95 100644
--- a/hw/gpio/zaurus.c
+++ b/hw/gpio/zaurus.c
@@ -49,19 +49,20 @@ struct ScoopInfo {
     uint16_t isr;
 };

-#define SCOOP_MCR 0x00
-#define SCOOP_CDR 0x04
-#define SCOOP_CSR 0x08
-#define SCOOP_CPR 0x0c
-#define SCOOP_CCR 0x10
-#define SCOOP_IRR_IRM 0x14
-#define SCOOP_IMR 0x18
-#define SCOOP_ISR 0x1c
-#define SCOOP_GPCR 0x20
-#define SCOOP_GPWR 0x24
-#define SCOOP_GPRR 0x28
-
-static inline void scoop_gpio_handler_update(ScoopInfo *s) {
+#define SCOOP_MCR       0x00
+#define SCOOP_CDR       0x04
+#define SCOOP_CSR       0x08
+#define SCOOP_CPR       0x0c
+#define SCOOP_CCR       0x10
+#define SCOOP_IRR_IRM   0x14
+#define SCOOP_IMR       0x18
+#define SCOOP_ISR       0x1c
+#define SCOOP_GPCR      0x20
+#define SCOOP_GPWR      0x24
+#define SCOOP_GPRR      0x28
+
+static inline void scoop_gpio_handler_update(ScoopInfo *s)
+{
     uint32_t level, diff;
     int bit;
     level = s->gpio_level & s->gpio_dir;
@@ -125,8 +126,9 @@ static void scoop_write(void *opaque, hwaddr addr,
         break;
     case SCOOP_CPR:
         s->power = value;
-        if (value & 0x80)
+        if (value & 0x80) {
             s->power |= 0x8040;
+        }
         break;
     case SCOOP_CCR:
         s->ccr = value;
@@ -145,7 +147,7 @@ static void scoop_write(void *opaque, hwaddr addr,
         scoop_gpio_handler_update(s);
         break;
     case SCOOP_GPWR:
-    case SCOOP_GPRR: /* GPRR is probably R/O in real HW */
+    case SCOOP_GPRR:    /* GPRR is probably R/O in real HW */
         s->gpio_level = value & s->gpio_dir;
         scoop_gpio_handler_update(s);
         break;
@@ -166,10 +168,11 @@ static void scoop_gpio_set(void *opaque, int line,
int level)
 {
     ScoopInfo *s = (ScoopInfo *) opaque;

-    if (level)
+    if (level) {
         s->gpio_level |= (1 << line);
-    else
+    } else {
         s->gpio_level &= ~(1 << line);
+    }
 }

 static void scoop_init(Object *obj)
@@ -203,7 +206,7 @@ static int scoop_post_load(void *opaque, int version_id)
     return 0;
 }

-static bool is_version_0 (void *opaque, int version_id)
+static bool is_version_0(void *opaque, int version_id)
 {
     return version_id == 0;
 }
@@ -265,7 +268,7 @@ type_init(scoop_register_types)

 /* Write the bootloader parameters memory area.  */

-#define MAGIC_CHG(a, b, c, d) ((d << 24) | (c << 16) | (b << 8) | a)
+#define MAGIC_CHG(a, b, c, d)   ((d << 24) | (c << 16) | (b << 8) | a)

 static struct QEMU_PACKED sl_param_info {
     uint32_t comadj_keyword;
@@ -286,16 +289,16 @@ static struct QEMU_PACKED sl_param_info {
     uint32_t phad_keyword;
     int32_t phadadj;
 } zaurus_bootparam = {
-    .comadj_keyword = MAGIC_CHG('C', 'M', 'A', 'D'),
-    .comadj = 125,
-    .uuid_keyword = MAGIC_CHG('U', 'U', 'I', 'D'),
-    .uuid = { -1 },
-    .touch_keyword = MAGIC_CHG('T', 'U', 'C', 'H'),
-    .touch_xp = -1,
-    .adadj_keyword = MAGIC_CHG('B', 'V', 'A', 'D'),
-    .adadj = -1,
-    .phad_keyword = MAGIC_CHG('P', 'H', 'A', 'D'),
-    .phadadj = 0x01,
+    .comadj_keyword     = MAGIC_CHG('C', 'M', 'A', 'D'),
+    .comadj             = 125,
+    .uuid_keyword       = MAGIC_CHG('U', 'U', 'I', 'D'),
+    .uuid               = { -1 },
+    .touch_keyword      = MAGIC_CHG('T', 'U', 'C', 'H'),
+    .touch_xp           = -1,
+    .adadj_keyword      = MAGIC_CHG('B', 'V', 'A', 'D'),
+    .adadj              = -1,
+    .phad_keyword       = MAGIC_CHG('P', 'H', 'A', 'D'),
+    .phadadj            = 0x01,
 };

 void sl_bootparam_write(hwaddr ptr)
diff --git a/hw/input/tsc2005.c b/hw/input/tsc2005.c
index 941f163d36..05094ab2b1 100644
--- a/hw/input/tsc2005.c
+++ b/hw/input/tsc2005.c
@@ -28,10 +28,10 @@
 #include "migration/vmstate.h"
 #include "trace.h"

-#define TSC_CUT_RESOLUTION(value, p) ((value) >> (16 - (p ? 12 : 10)))
+#define TSC_CUT_RESOLUTION(value, p)  ((value) >> (16 - (p ? 12 : 10)))

 typedef struct {
-    qemu_irq pint; /* Combination of the nPENIRQ and DAV signals */
+    qemu_irq pint;  /* Combination of the nPENIRQ and DAV signals */
     QEMUTimer *timer;
     uint16_t model;

@@ -63,7 +63,7 @@ typedef struct {
 } TSC2005State;

 enum {
-    TSC_MODE_XYZ_SCAN = 0x0,
+    TSC_MODE_XYZ_SCAN = 0x0,
     TSC_MODE_XY_SCAN,
     TSC_MODE_X,
     TSC_MODE_Y,
@@ -82,100 +82,100 @@ enum {
 };

 static const uint16_t mode_regs[16] = {
-    0xf000, /* X, Y, Z scan */
-    0xc000, /* X, Y scan */
-    0x8000, /* X */
-    0x4000, /* Y */
-    0x3000, /* Z */
-    0x0800, /* AUX */
-    0x0400, /* TEMP1 */
-    0x0200, /* TEMP2 */
-    0x0800, /* AUX scan */
-    0x0040, /* X test */
-    0x0020, /* Y test */
-    0x0080, /* Short-circuit test */
-    0x0000, /* Reserved */
-    0x0000, /* X+, X- drivers */
-    0x0000, /* Y+, Y- drivers */
-    0x0000, /* Y+, X- drivers */
+    0xf000, /* X, Y, Z scan */
+    0xc000, /* X, Y scan */
+    0x8000, /* X */
+    0x4000, /* Y */
+    0x3000, /* Z */
+    0x0800, /* AUX */
+    0x0400, /* TEMP1 */
+    0x0200, /* TEMP2 */
+    0x0800, /* AUX scan */
+    0x0040, /* X test */
+    0x0020, /* Y test */
+    0x0080, /* Short-circuit test */
+    0x0000, /* Reserved */
+    0x0000, /* X+, X- drivers */
+    0x0000, /* Y+, Y- drivers */
+    0x0000, /* Y+, X- drivers */
 };

-#define X_TRANSFORM(s) \
+#define X_TRANSFORM(s)      \
     ((s->y * s->tr[0] - s->x * s->tr[1]) / s->tr[2] + s->tr[3])
-#define Y_TRANSFORM(s) \
+#define Y_TRANSFORM(s)      \
     ((s->y * s->tr[4] - s->x * s->tr[5]) / s->tr[6] + s->tr[7])
-#define Z1_TRANSFORM(s) \
+#define Z1_TRANSFORM(s)     \
     ((400 - ((s)->x >> 7) + ((s)->pressure << 10)) << 4)
-#define Z2_TRANSFORM(s) \
+#define Z2_TRANSFORM(s)     \
     ((4000 + ((s)->y >> 7) - ((s)->pressure << 10)) << 4)

-#define AUX_VAL (700 << 4) /* +/- 3 at 12-bit */
-#define TEMP1_VAL (1264 << 4) /* +/- 5 at 12-bit */
-#define TEMP2_VAL (1531 << 4) /* +/- 5 at 12-bit */
+#define AUX_VAL       (700 << 4)  /* +/- 3 at 12-bit */
+#define TEMP1_VAL     (1264 << 4) /* +/- 5 at 12-bit */
+#define TEMP2_VAL     (1531 << 4) /* +/- 5 at 12-bit */

 static uint16_t tsc2005_read(TSC2005State *s, int reg)
 {
     uint16_t ret;

     switch (reg) {
-    case 0x0: /* X */
+    case 0x0: /* X */
         s->dav &= ~mode_regs[TSC_MODE_X];
         return TSC_CUT_RESOLUTION(X_TRANSFORM(s), s->precision) +
                 (s->noise & 3);
-    case 0x1: /* Y */
+    case 0x1: /* Y */
         s->dav &= ~mode_regs[TSC_MODE_Y];
-        s->noise ++;
+        s->noise++;
         return TSC_CUT_RESOLUTION(Y_TRANSFORM(s), s->precision) ^
                 (s->noise & 3);
-    case 0x2: /* Z1 */
+    case 0x2: /* Z1 */
         s->dav &= 0xdfff;
         return TSC_CUT_RESOLUTION(Z1_TRANSFORM(s), s->precision) -
                 (s->noise & 3);
-    case 0x3: /* Z2 */
+    case 0x3: /* Z2 */
         s->dav &= 0xefff;
         return TSC_CUT_RESOLUTION(Z2_TRANSFORM(s), s->precision) |
                 (s->noise & 3);

-    case 0x4: /* AUX */
+    case 0x4: /* AUX */
         s->dav &= ~mode_regs[TSC_MODE_AUX];
         return TSC_CUT_RESOLUTION(AUX_VAL, s->precision);

-    case 0x5: /* TEMP1 */
+    case 0x5: /* TEMP1 */
         s->dav &= ~mode_regs[TSC_MODE_TEMP1];
         return TSC_CUT_RESOLUTION(TEMP1_VAL, s->precision) -
                 (s->noise & 5);
-    case 0x6: /* TEMP2 */
+    case 0x6: /* TEMP2 */
         s->dav &= 0xdfff;
         s->dav &= ~mode_regs[TSC_MODE_TEMP2];
         return TSC_CUT_RESOLUTION(TEMP2_VAL, s->precision) ^
                 (s->noise & 3);

-    case 0x7: /* Status */
+    case 0x7: /* Status */
         ret = s->dav | (s->reset << 7) | (s->pdst << 2) | 0x0;
         s->dav &= ~(mode_regs[TSC_MODE_X_TEST] |
mode_regs[TSC_MODE_Y_TEST] |
                         mode_regs[TSC_MODE_TS_TEST]);
         s->reset = true;
         return ret;

-    case 0x8:   /* AUX high threshold */
+    case 0x8: /* AUX high threshold */
         return s->aux_thr[1];
-    case 0x9:   /* AUX low threshold */
+    case 0x9: /* AUX low threshold */
         return s->aux_thr[0];

-    case 0xa:   /* TEMP high threshold */
+    case 0xa: /* TEMP high threshold */
         return s->temp_thr[1];
-    case 0xb:   /* TEMP low threshold */
+    case 0xb: /* TEMP low threshold */
         return s->temp_thr[0];

-    case 0xc: /* CFR0 */
+    case 0xc: /* CFR0 */
         return (s->pressure << 15) | ((!s->busy) << 14) |
-                (s->nextprecision << 13) | s->timing[0];
-    case 0xd: /* CFR1 */
+                (s->nextprecision << 13) | s->timing[0];
+    case 0xd: /* CFR1 */
         return s->timing[1];
-    case 0xe: /* CFR2 */
+    case 0xe: /* CFR2 */
         return (s->pin_func << 14) | s->filter;

-    case 0xf: /* Function select status */
+    case 0xf: /* Function select status */
         return s->function >= 0 ? 1 << s->function : 0;
     }

@@ -200,13 +200,14 @@ static void tsc2005_write(TSC2005State *s, int reg,
uint16_t data)
         s->temp_thr[0] = data;
         break;

-    case 0xc: /* CFR0 */
+    case 0xc: /* CFR0 */
         s->host_mode = (data >> 15) != 0;
         if (s->enabled != !(data & 0x4000)) {
             s->enabled = !(data & 0x4000);
             trace_tsc2005_sense(s->enabled ? "enabled" : "disabled");
-            if (s->busy && !s->enabled)
+            if (s->busy && !s->enabled) {
                 timer_del(s->timer);
+            }
             s->busy = s->busy && s->enabled;
         }
         s->nextprecision = (data >> 13) & 1;
@@ -216,10 +217,10 @@ static void tsc2005_write(TSC2005State *s, int reg,
uint16_t data)
                           "tsc2005_write: illegal conversion clock
setting\n");
         }
         break;
-    case 0xd: /* CFR1 */
+    case 0xd: /* CFR1 */
         s->timing[1] = data & 0xf07;
         break;
-    case 0xe: /* CFR2 */
+    case 0xe: /* CFR2 */
         s->pin_func = (data >> 14) & 3;
         s->filter = data & 0x3fff;
         break;
@@ -258,10 +259,12 @@ static void tsc2005_pin_update(TSC2005State *s)
     switch (s->nextfunction) {
     case TSC_MODE_XYZ_SCAN:
     case TSC_MODE_XY_SCAN:
-        if (!s->host_mode && s->dav)
+        if (!s->host_mode && s->dav) {
             s->enabled = false;
-        if (!s->pressure)
+        }
+        if (!s->pressure) {
             return;
+        }
         /* Fall through */
     case TSC_MODE_AUX_SCAN:
         break;
@@ -269,8 +272,9 @@ static void tsc2005_pin_update(TSC2005State *s)
     case TSC_MODE_X:
     case TSC_MODE_Y:
     case TSC_MODE_Z:
-        if (!s->pressure)
+        if (!s->pressure) {
             return;
+        }
         /* Fall through */
     case TSC_MODE_AUX:
     case TSC_MODE_TEMP1:
@@ -278,8 +282,9 @@ static void tsc2005_pin_update(TSC2005State *s)
     case TSC_MODE_X_TEST:
     case TSC_MODE_Y_TEST:
     case TSC_MODE_TS_TEST:
-        if (s->dav)
+        if (s->dav) {
             s->enabled = false;
+        }
         break;

     case TSC_MODE_RESERVED:
@@ -290,13 +295,14 @@ static void tsc2005_pin_update(TSC2005State *s)
         return;
     }

-    if (!s->enabled || s->busy)
+    if (!s->enabled || s->busy) {
         return;
+    }

     s->busy = true;
     s->precision = s->nextprecision;
     s->function = s->nextfunction;
-    s->pdst = !s->pnd0; /* Synchronised on internal clock */
+    s->pdst = !s->pnd0; /* Synchronised on internal clock */
     expires = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
         (NANOSECONDS_PER_SECOND >> 7);
     timer_mod(s->timer, expires);
@@ -331,7 +337,7 @@ static uint8_t tsc2005_txrx_word(void *opaque, uint8_t
value)
     TSC2005State *s = opaque;
     uint32_t ret = 0;

-    switch (s->state ++) {
+    switch (s->state++) {
     case 0:
         if (value & 0x80) {
             /* Command */
@@ -343,8 +349,9 @@ static uint8_t tsc2005_txrx_word(void *opaque, uint8_t
value)
                 if (s->enabled != !(value & 1)) {
                     s->enabled = !(value & 1);
                     trace_tsc2005_sense(s->enabled ? "enabled" :
"disabled");
-                    if (s->busy && !s->enabled)
+                    if (s->busy && !s->enabled) {
                         timer_del(s->timer);
+                    }
                     s->busy = s->busy && s->enabled;
                 }
                 tsc2005_pin_update(s);
@@ -368,10 +375,11 @@ static uint8_t tsc2005_txrx_word(void *opaque,
uint8_t value)
         break;

     case 1:
-        if (s->command)
+        if (s->command) {
             ret = (s->data >> 8) & 0xff;
-        else
+        } else {
             s->data |= value << 8;
+        }
         break;

     case 2:
@@ -409,8 +417,9 @@ static void tsc2005_timer_tick(void *opaque)

     /* Timer ticked -- a set of conversions has been finished.  */

-    if (!s->busy)
+    if (!s->busy) {
         return;
+    }

     s->busy = false;
     s->dav |= mode_regs[s->function];
@@ -435,8 +444,9 @@ static void tsc2005_touchscreen_event(void *opaque,
      * signaling TS events immediately, but for now we simulate
      * the first conversion delay for sake of correctness.
      */
-    if (p != s->pressure)
+    if (p != s->pressure) {
         tsc2005_pin_update(s);
+    }
 }

 static int tsc2005_post_load(void *opaque, int version_id)
diff --git a/hw/input/tsc210x.c b/hw/input/tsc210x.c
index c4e32c7a42..b94e346af1 100644
--- a/hw/input/tsc210x.c
+++ b/hw/input/tsc210x.c
@@ -33,13 +33,13 @@
 #include "migration/vmstate.h"
 #include "qapi/error.h"

-#define TSC_DATA_REGISTERS_PAGE 0x0
-#define TSC_CONTROL_REGISTERS_PAGE 0x1
-#define TSC_AUDIO_REGISTERS_PAGE 0x2
+#define TSC_DATA_REGISTERS_PAGE     0x0
+#define TSC_CONTROL_REGISTERS_PAGE  0x1
+#define TSC_AUDIO_REGISTERS_PAGE    0x2

 #define TSC_VERBOSE

-#define TSC_CUT_RESOLUTION(value, p) ((value) >> (16 - resolution[p]))
+#define TSC_CUT_RESOLUTION(value, p)  ((value) >> (16 - resolution[p]))

 typedef struct {
     qemu_irq pint;
@@ -105,60 +105,60 @@ typedef struct {

 static const int resolution[4] = { 12, 8, 10, 12 };

-#define TSC_MODE_NO_SCAN 0x0
-#define TSC_MODE_XY_SCAN 0x1
-#define TSC_MODE_XYZ_SCAN 0x2
-#define TSC_MODE_X 0x3
-#define TSC_MODE_Y 0x4
-#define TSC_MODE_Z 0x5
-#define TSC_MODE_BAT1 0x6
-#define TSC_MODE_BAT2 0x7
-#define TSC_MODE_AUX 0x8
-#define TSC_MODE_AUX_SCAN 0x9
-#define TSC_MODE_TEMP1 0xa
-#define TSC_MODE_PORT_SCAN 0xb
-#define TSC_MODE_TEMP2 0xc
-#define TSC_MODE_XX_DRV 0xd
-#define TSC_MODE_YY_DRV 0xe
-#define TSC_MODE_YX_DRV 0xf
+#define TSC_MODE_NO_SCAN    0x0
+#define TSC_MODE_XY_SCAN    0x1
+#define TSC_MODE_XYZ_SCAN   0x2
+#define TSC_MODE_X          0x3
+#define TSC_MODE_Y          0x4
+#define TSC_MODE_Z          0x5
+#define TSC_MODE_BAT1       0x6
+#define TSC_MODE_BAT2       0x7
+#define TSC_MODE_AUX        0x8
+#define TSC_MODE_AUX_SCAN   0x9
+#define TSC_MODE_TEMP1      0xa
+#define TSC_MODE_PORT_SCAN  0xb
+#define TSC_MODE_TEMP2      0xc
+#define TSC_MODE_XX_DRV     0xd
+#define TSC_MODE_YY_DRV     0xe
+#define TSC_MODE_YX_DRV     0xf

 static const uint16_t mode_regs[16] = {
-    0x0000, /* No scan */
-    0x0600, /* X, Y scan */
-    0x0780, /* X, Y, Z scan */
-    0x0400, /* X */
-    0x0200, /* Y */
-    0x0180, /* Z */
-    0x0040, /* BAT1 */
-    0x0030, /* BAT2 */
-    0x0010, /* AUX */
-    0x0010, /* AUX scan */
-    0x0004, /* TEMP1 */
-    0x0070, /* Port scan */
-    0x0002, /* TEMP2 */
-    0x0000, /* X+, X- drivers */
-    0x0000, /* Y+, Y- drivers */
-    0x0000, /* Y+, X- drivers */
+    0x0000, /* No scan */
+    0x0600, /* X, Y scan */
+    0x0780, /* X, Y, Z scan */
+    0x0400, /* X */
+    0x0200, /* Y */
+    0x0180, /* Z */
+    0x0040, /* BAT1 */
+    0x0030, /* BAT2 */
+    0x0010, /* AUX */
+    0x0010, /* AUX scan */
+    0x0004, /* TEMP1 */
+    0x0070, /* Port scan */
+    0x0002, /* TEMP2 */
+    0x0000, /* X+, X- drivers */
+    0x0000, /* Y+, Y- drivers */
+    0x0000, /* Y+, X- drivers */
 };

-#define X_TRANSFORM(s) \
+#define X_TRANSFORM(s)      \
     ((s->y * s->tr[0] - s->x * s->tr[1]) / s->tr[2] + s->tr[3])
-#define Y_TRANSFORM(s) \
+#define Y_TRANSFORM(s)      \
     ((s->y * s->tr[4] - s->x * s->tr[5]) / s->tr[6] + s->tr[7])
-#define Z1_TRANSFORM(s) \
+#define Z1_TRANSFORM(s)     \
     ((400 - ((s)->x >> 7) + ((s)->pressure << 10)) << 4)
-#define Z2_TRANSFORM(s) \
+#define Z2_TRANSFORM(s)     \
     ((4000 + ((s)->y >> 7) - ((s)->pressure << 10)) << 4)

-#define BAT1_VAL 0x8660
-#define BAT2_VAL 0x0000
-#define AUX1_VAL 0x35c0
-#define AUX2_VAL 0xffff
-#define TEMP1_VAL 0x8c70
-#define TEMP2_VAL 0xa5b0
+#define BAT1_VAL      0x8660
+#define BAT2_VAL      0x0000
+#define AUX1_VAL      0x35c0
+#define AUX2_VAL      0xffff
+#define TEMP1_VAL     0x8c70
+#define TEMP2_VAL     0xa5b0

-#define TSC_POWEROFF_DELAY 50
-#define TSC_SOFTSTEP_DELAY 50
+#define TSC_POWEROFF_DELAY    50
+#define TSC_SOFTSTEP_DELAY    50

 static void tsc210x_reset(TSC210xState *s)
 {
@@ -224,34 +224,34 @@ typedef struct {
     int fsref;
 } TSC210xRateInfo;

-/*  { rate,   dsor, fsref } */
+/*  { rate,   dsor, fsref } */
 static const TSC210xRateInfo tsc2102_rates[] = {
     /* Fsref / 6.0 */
-    { 7350, 63, 1 },
-    { 8000, 63, 0 },
+    { 7350, 63, 1 },
+    { 8000, 63, 0 },
     /* Fsref / 6.0 */
-    { 7350, 54, 1 },
-    { 8000, 54, 0 },
+    { 7350, 54, 1 },
+    { 8000, 54, 0 },
     /* Fsref / 5.0 */
-    { 8820, 45, 1 },
-    { 9600, 45, 0 },
+    { 8820, 45, 1 },
+    { 9600, 45, 0 },
     /* Fsref / 4.0 */
-    { 11025, 36, 1 },
-    { 12000, 36, 0 },
+    { 11025, 36, 1 },
+    { 12000, 36, 0 },
     /* Fsref / 3.0 */
-    { 14700, 27, 1 },
-    { 16000, 27, 0 },
+    { 14700, 27, 1 },
+    { 16000, 27, 0 },
     /* Fsref / 2.0 */
-    { 22050, 18, 1 },
-    { 24000, 18, 0 },
+    { 22050, 18, 1 },
+    { 24000, 18, 0 },
     /* Fsref / 1.5 */
-    { 29400, 9, 1 },
-    { 32000, 9, 0 },
+    { 29400, 9, 1 },
+    { 32000, 9, 0 },
     /* Fsref */
-    { 44100, 0, 1 },
-    { 48000, 0, 0 },
+    { 44100, 0, 1 },
+    { 48000, 0, 0 },

-    { 0, 0, 0 },
+    { 0, 0, 0 },
 };

 static inline void tsc210x_out_flush(TSC210xState *s, int len)
@@ -259,12 +259,14 @@ static inline void tsc210x_out_flush(TSC210xState *s,
int len)
     uint8_t *data = s->codec.out.fifo + s->codec.out.start;
     uint8_t *end = data + len;

-    while (data < end)
+    while (data < end) {
         data += AUD_write(s->dac_voice[0], data, end - data) ?: (end -
data);
+    }

     s->codec.out.len -= len;
-    if (s->codec.out.len)
+    if (s->codec.out.len) {
         memmove(s->codec.out.fifo, end, s->codec.out.len);
+    }
     s->codec.out.start = 0;
 }

@@ -285,11 +287,12 @@ static void tsc2102_audio_rate_update(TSC210xState *s)

     s->codec.tx_rate = 0;
     s->codec.rx_rate = 0;
-    if (s->dac_power & (1 << 15)) /* PWDNC */
+    if (s->dac_power & (1 << 15)) {     /* PWDNC */
         return;
+   }

-    for (rate = tsc2102_rates; rate->rate; rate ++)
-        if (rate->dsor == (s->audio_ctrl1 & 0x3f) && /* DACFS */
+    for (rate = tsc2102_rates; rate->rate; rate++)
+        if (rate->dsor == (s->audio_ctrl1 & 0x3f) &&    /* DACFS */
                         rate->fsref == ((s->audio_ctrl3 >> 13) & 1))/*
REFFS */
             break;
     if (!rate->rate) {
@@ -315,10 +318,11 @@ static void tsc2102_audio_output_update(TSC210xState
*s)
     s->codec.cts = 0;

     enable =
-            (~s->dac_power & (1 << 15)) && /* PWDNC */
-            (~s->dac_power & (1 << 10)); /* DAPWDN */
-    if (!enable || !s->codec.tx_rate)
+            (~s->dac_power & (1 << 15)) &&     /* PWDNC */
+            (~s->dac_power & (1 << 10));       /* DAPWDN */
+    if (!enable || !s->codec.tx_rate) {
         return;
+    }

     /* Force our own sampling rate even in slave DAC mode */
     fmt.endianness = 0;
@@ -337,28 +341,28 @@ static void tsc2102_audio_output_update(TSC210xState
*s)
 static uint16_t tsc2102_data_register_read(TSC210xState *s, int reg)
 {
     switch (reg) {
-    case 0x00: /* X */
+    case 0x00:  /* X */
         s->dav &= 0xfbff;
         return TSC_CUT_RESOLUTION(X_TRANSFORM(s), s->precision) +
                 (s->noise & 3);

-    case 0x01: /* Y */
-        s->noise ++;
+    case 0x01:  /* Y */
+        s->noise++;
         s->dav &= 0xfdff;
         return TSC_CUT_RESOLUTION(Y_TRANSFORM(s), s->precision) ^
                 (s->noise & 3);

-    case 0x02: /* Z1 */
+    case 0x02:  /* Z1 */
         s->dav &= 0xfeff;
         return TSC_CUT_RESOLUTION(Z1_TRANSFORM(s), s->precision) -
                 (s->noise & 3);

-    case 0x03: /* Z2 */
+    case 0x03:  /* Z2 */
         s->dav &= 0xff7f;
         return TSC_CUT_RESOLUTION(Z2_TRANSFORM(s), s->precision) |
                 (s->noise & 3);

-    case 0x04: /* KPData */
+    case 0x04:  /* KPData */
         if ((s->model & 0xff00) == 0x2300) {
             if (s->kb.intr && (s->kb.mode & 2)) {
                 s->kb.intr = 0;
@@ -369,34 +373,34 @@ static uint16_t
tsc2102_data_register_read(TSC210xState *s, int reg)

         return 0xffff;

-    case 0x05: /* BAT1 */
+    case 0x05:  /* BAT1 */
         s->dav &= 0xffbf;
         return TSC_CUT_RESOLUTION(BAT1_VAL, s->precision) +
                 (s->noise & 6);

-    case 0x06: /* BAT2 */
+    case 0x06:  /* BAT2 */
         s->dav &= 0xffdf;
         return TSC_CUT_RESOLUTION(BAT2_VAL, s->precision);

-    case 0x07: /* AUX1 */
+    case 0x07:  /* AUX1 */
         s->dav &= 0xffef;
         return TSC_CUT_RESOLUTION(AUX1_VAL, s->precision);

-    case 0x08: /* AUX2 */
+    case 0x08:  /* AUX2 */
         s->dav &= 0xfff7;
         return 0xffff;

-    case 0x09: /* TEMP1 */
+    case 0x09:  /* TEMP1 */
         s->dav &= 0xfffb;
         return TSC_CUT_RESOLUTION(TEMP1_VAL, s->precision) -
                 (s->noise & 5);

-    case 0x0a: /* TEMP2 */
+    case 0x0a:  /* TEMP2 */
         s->dav &= 0xfffd;
         return TSC_CUT_RESOLUTION(TEMP2_VAL, s->precision) ^
                 (s->noise & 3);

-    case 0x0b: /* DAC */
+    case 0x0b:  /* DAC */
         s->dav &= 0xfffe;
         return 0xffff;

@@ -413,11 +417,11 @@ static uint16_t tsc2102_control_register_read(
                 TSC210xState *s, int reg)
 {
     switch (reg) {
-    case 0x00: /* TSC ADC */
+    case 0x00:  /* TSC ADC */
         return (s->pressure << 15) | ((!s->busy) << 14) |
-                (s->nextfunction << 10) | (s->nextprecision << 8) |
s->filter;
+                (s->nextfunction << 10) | (s->nextprecision << 8) |
s->filter;

-    case 0x01: /* Status / Keypad Control */
+    case 0x01:  /* Status / Keypad Control */
         if ((s->model & 0xff00) == 0x2100)
             return (s->pin_func << 14) | ((!s->enabled) << 13) |
                     (s->host_mode << 12) | ((!!s->dav) << 11) | s->dav;
@@ -425,29 +429,32 @@ static uint16_t tsc2102_control_register_read(
             return (s->kb.intr << 15) | ((s->kb.scan || !s->kb.down) <<
14) |
                     (s->kb.debounce << 11);

-    case 0x02: /* DAC Control */
-        if ((s->model & 0xff00) == 0x2300)
+    case 0x02:  /* DAC Control */
+        if ((s->model & 0xff00) == 0x2300) {
             return s->dac_power & 0x8000;
-        else
+        } else {
             goto bad_reg;
+        }

-    case 0x03: /* Reference */
+    case 0x03:  /* Reference */
         return s->ref;

-    case 0x04: /* Reset */
+    case 0x04:  /* Reset */
         return 0xffff;

-    case 0x05: /* Configuration */
+    case 0x05:  /* Configuration */
         return s->timing;

-    case 0x06: /* Secondary configuration */
-        if ((s->model & 0xff00) == 0x2100)
+    case 0x06:  /* Secondary configuration */
+        if ((s->model & 0xff00) == 0x2100) {
             goto bad_reg;
+        }
         return ((!s->dav) << 15) | ((s->kb.mode & 1) << 14) | s->pll[2];

-    case 0x10: /* Keypad Mask */
-        if ((s->model & 0xff00) == 0x2100)
+    case 0x10:  /* Keypad Mask */
+        if ((s->model & 0xff00) == 0x2100) {
             goto bad_reg;
+        }
         return s->kb.mask;

     default:
@@ -466,19 +473,19 @@ static uint16_t
tsc2102_audio_register_read(TSC210xState *s, int reg)
     uint16_t val;

     switch (reg) {
-    case 0x00: /* Audio Control 1 */
+    case 0x00:  /* Audio Control 1 */
         return s->audio_ctrl1;

     case 0x01:
         return 0xff00;

-    case 0x02: /* DAC Volume Control */
+    case 0x02:  /* DAC Volume Control */
         return s->volume;

     case 0x03:
         return 0x8b00;

-    case 0x04: /* Audio Control 2 */
+    case 0x04:  /* Audio Control 2 */
         l_ch = 1;
         r_ch = 1;
         if (s->softstep && !(s->dac_power & (1 << 10))) {
@@ -490,46 +497,46 @@ static uint16_t
tsc2102_audio_register_read(TSC210xState *s, int reg)

         return s->audio_ctrl2 | (l_ch << 3) | (r_ch << 2);

-    case 0x05: /* Stereo DAC Power Control */
+    case 0x05:  /* Stereo DAC Power Control */
         return 0x2aa0 | s->dac_power |
                 (((s->dac_power & (1 << 10)) &&
                   (qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) >
                    s->powerdown + TSC_POWEROFF_DELAY)) << 6);

-    case 0x06: /* Audio Control 3 */
+    case 0x06:  /* Audio Control 3 */
         val = s->audio_ctrl3 | 0x0001;
         s->audio_ctrl3 &= 0xff3f;
         return val;

-    case 0x07: /* LCH_BASS_BOOST_N0 */
-    case 0x08: /* LCH_BASS_BOOST_N1 */
-    case 0x09: /* LCH_BASS_BOOST_N2 */
-    case 0x0a: /* LCH_BASS_BOOST_N3 */
-    case 0x0b: /* LCH_BASS_BOOST_N4 */
-    case 0x0c: /* LCH_BASS_BOOST_N5 */
-    case 0x0d: /* LCH_BASS_BOOST_D1 */
-    case 0x0e: /* LCH_BASS_BOOST_D2 */
-    case 0x0f: /* LCH_BASS_BOOST_D4 */
-    case 0x10: /* LCH_BASS_BOOST_D5 */
-    case 0x11: /* RCH_BASS_BOOST_N0 */
-    case 0x12: /* RCH_BASS_BOOST_N1 */
-    case 0x13: /* RCH_BASS_BOOST_N2 */
-    case 0x14: /* RCH_BASS_BOOST_N3 */
-    case 0x15: /* RCH_BASS_BOOST_N4 */
-    case 0x16: /* RCH_BASS_BOOST_N5 */
-    case 0x17: /* RCH_BASS_BOOST_D1 */
-    case 0x18: /* RCH_BASS_BOOST_D2 */
-    case 0x19: /* RCH_BASS_BOOST_D4 */
-    case 0x1a: /* RCH_BASS_BOOST_D5 */
+    case 0x07:  /* LCH_BASS_BOOST_N0 */
+    case 0x08:  /* LCH_BASS_BOOST_N1 */
+    case 0x09:  /* LCH_BASS_BOOST_N2 */
+    case 0x0a:  /* LCH_BASS_BOOST_N3 */
+    case 0x0b:  /* LCH_BASS_BOOST_N4 */
+    case 0x0c:  /* LCH_BASS_BOOST_N5 */
+    case 0x0d:  /* LCH_BASS_BOOST_D1 */
+    case 0x0e:  /* LCH_BASS_BOOST_D2 */
+    case 0x0f:  /* LCH_BASS_BOOST_D4 */
+    case 0x10:  /* LCH_BASS_BOOST_D5 */
+    case 0x11:  /* RCH_BASS_BOOST_N0 */
+    case 0x12:  /* RCH_BASS_BOOST_N1 */
+    case 0x13:  /* RCH_BASS_BOOST_N2 */
+    case 0x14:  /* RCH_BASS_BOOST_N3 */
+    case 0x15:  /* RCH_BASS_BOOST_N4 */
+    case 0x16:  /* RCH_BASS_BOOST_N5 */
+    case 0x17:  /* RCH_BASS_BOOST_D1 */
+    case 0x18:  /* RCH_BASS_BOOST_D2 */
+    case 0x19:  /* RCH_BASS_BOOST_D4 */
+    case 0x1a:  /* RCH_BASS_BOOST_D5 */
         return s->filter_data[reg - 0x07];

-    case 0x1b: /* PLL Programmability 1 */
+    case 0x1b:  /* PLL Programmability 1 */
         return s->pll[0];

-    case 0x1c: /* PLL Programmability 2 */
+    case 0x1c:  /* PLL Programmability 2 */
         return s->pll[1];

-    case 0x1d: /* Audio Control 4 */
+    case 0x1d:  /* Audio Control 4 */
         return (!s->softstep) << 14;

     default:
@@ -545,16 +552,16 @@ static void tsc2102_data_register_write(
                 TSC210xState *s, int reg, uint16_t value)
 {
     switch (reg) {
-    case 0x00: /* X */
-    case 0x01: /* Y */
-    case 0x02: /* Z1 */
-    case 0x03: /* Z2 */
-    case 0x05: /* BAT1 */
-    case 0x06: /* BAT2 */
-    case 0x07: /* AUX1 */
-    case 0x08: /* AUX2 */
-    case 0x09: /* TEMP1 */
-    case 0x0a: /* TEMP2 */
+    case 0x00:  /* X */
+    case 0x01:  /* Y */
+    case 0x02:  /* Z1 */
+    case 0x03:  /* Z2 */
+    case 0x05:  /* BAT1 */
+    case 0x06:  /* BAT2 */
+    case 0x07:  /* AUX1 */
+    case 0x08:  /* AUX2 */
+    case 0x09:  /* TEMP1 */
+    case 0x0a:  /* TEMP2 */
         return;

     default:
@@ -567,18 +574,19 @@ static void tsc2102_control_register_write(
                 TSC210xState *s, int reg, uint16_t value)
 {
     switch (reg) {
-    case 0x00: /* TSC ADC */
+    case 0x00:  /* TSC ADC */
         s->host_mode = value >> 15;
         s->enabled = !(value & 0x4000);
-        if (s->busy && !s->enabled)
+        if (s->busy && !s->enabled) {
             timer_del(s->timer);
+        }
         s->busy = s->busy && s->enabled;
         s->nextfunction = (value >> 10) & 0xf;
         s->nextprecision = (value >> 8) & 3;
         s->filter = value & 0xff;
         return;

-    case 0x01: /* Status / Keypad Control */
+    case 0x01:  /* Status / Keypad Control */
         if ((s->model & 0xff00) == 0x2100)
             s->pin_func = value >> 14;
         else {
@@ -591,7 +599,7 @@ static void tsc2102_control_register_write(
         }
         return;

-    case 0x02: /* DAC Control */
+    case 0x02:  /* DAC Control */
         if ((s->model & 0xff00) == 0x2300) {
             s->dac_power &= 0x7fff;
             s->dac_power |= 0x8000 & value;
@@ -599,14 +607,15 @@ static void tsc2102_control_register_write(
             goto bad_reg;
         break;

-    case 0x03: /* Reference */
+    case 0x03:  /* Reference */
         s->ref = value & 0x1f;
         return;

-    case 0x04: /* Reset */
+    case 0x04:  /* Reset */
         if (value == 0xbb00) {
-            if (s->busy)
+            if (s->busy) {
                 timer_del(s->timer);
+            }
             tsc210x_reset(s);
 #ifdef TSC_VERBOSE
         } else {
@@ -616,7 +625,7 @@ static void tsc2102_control_register_write(
         }
         return;

-    case 0x05: /* Configuration */
+    case 0x05:  /* Configuration */
         s->timing = value & 0x3f;
 #ifdef TSC_VERBOSE
         if (value & ~0x3f)
@@ -625,16 +634,18 @@ static void tsc2102_control_register_write(
 #endif
         return;

-    case 0x06: /* Secondary configuration */
-        if ((s->model & 0xff00) == 0x2100)
+    case 0x06:  /* Secondary configuration */
+        if ((s->model & 0xff00) == 0x2100) {
             goto bad_reg;
+        }
         s->kb.mode = value >> 14;
         s->pll[2] = value & 0x3ffff;
         return;

-    case 0x10: /* Keypad Mask */
-        if ((s->model & 0xff00) == 0x2100)
+    case 0x10:  /* Keypad Mask */
+        if ((s->model & 0xff00) == 0x2100) {
             goto bad_reg;
+        }
         s->kb.mask = value;
         return;

@@ -649,7 +660,7 @@ static void tsc2102_audio_register_write(
                 TSC210xState *s, int reg, uint16_t value)
 {
     switch (reg) {
-    case 0x00: /* Audio Control 1 */
+    case 0x00:  /* Audio Control 1 */
         s->audio_ctrl1 = value & 0x0f3f;
 #ifdef TSC_VERBOSE
         if ((value & ~0x0f3f) || ((value & 7) != ((value >> 3) & 7)))
@@ -668,7 +679,7 @@ static void tsc2102_audio_register_write(
 #endif
         return;

-    case 0x02: /* DAC Volume Control */
+    case 0x02:  /* DAC Volume Control */
         s->volume = value;
         s->volume_change = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
         return;
@@ -681,7 +692,7 @@ static void tsc2102_audio_register_write(
 #endif
         return;

-    case 0x04: /* Audio Control 2 */
+    case 0x04:  /* Audio Control 2 */
         s->audio_ctrl2 = value & 0xf7f2;
 #ifdef TSC_VERBOSE
         if (value & ~0xf7fd)
@@ -690,9 +701,10 @@ static void tsc2102_audio_register_write(
 #endif
         return;

-    case 0x05: /* Stereo DAC Power Control */
-        if ((value & ~s->dac_power) & (1 << 10))
+    case 0x05:  /* Stereo DAC Power Control */
+        if ((value & ~s->dac_power) & (1 << 10)) {
             s->powerdown = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+        }

         s->dac_power = value & 0x9543;
 #ifdef TSC_VERBOSE
@@ -704,7 +716,7 @@ static void tsc2102_audio_register_write(
         tsc2102_audio_output_update(s);
         return;

-    case 0x06: /* Audio Control 3 */
+    case 0x06:  /* Audio Control 3 */
         s->audio_ctrl3 &= 0x00c0;
         s->audio_ctrl3 |= value & 0xf800;
 #ifdef TSC_VERBOSE
@@ -715,30 +727,30 @@ static void tsc2102_audio_register_write(
         tsc2102_audio_output_update(s);
         return;

-    case 0x07: /* LCH_BASS_BOOST_N0 */
-    case 0x08: /* LCH_BASS_BOOST_N1 */
-    case 0x09: /* LCH_BASS_BOOST_N2 */
-    case 0x0a: /* LCH_BASS_BOOST_N3 */
-    case 0x0b: /* LCH_BASS_BOOST_N4 */
-    case 0x0c: /* LCH_BASS_BOOST_N5 */
-    case 0x0d: /* LCH_BASS_BOOST_D1 */
-    case 0x0e: /* LCH_BASS_BOOST_D2 */
-    case 0x0f: /* LCH_BASS_BOOST_D4 */
-    case 0x10: /* LCH_BASS_BOOST_D5 */
-    case 0x11: /* RCH_BASS_BOOST_N0 */
-    case 0x12: /* RCH_BASS_BOOST_N1 */
-    case 0x13: /* RCH_BASS_BOOST_N2 */
-    case 0x14: /* RCH_BASS_BOOST_N3 */
-    case 0x15: /* RCH_BASS_BOOST_N4 */
-    case 0x16: /* RCH_BASS_BOOST_N5 */
-    case 0x17: /* RCH_BASS_BOOST_D1 */
-    case 0x18: /* RCH_BASS_BOOST_D2 */
-    case 0x19: /* RCH_BASS_BOOST_D4 */
-    case 0x1a: /* RCH_BASS_BOOST_D5 */
+    case 0x07:  /* LCH_BASS_BOOST_N0 */
+    case 0x08:  /* LCH_BASS_BOOST_N1 */
+    case 0x09:  /* LCH_BASS_BOOST_N2 */
+    case 0x0a:  /* LCH_BASS_BOOST_N3 */
+    case 0x0b:  /* LCH_BASS_BOOST_N4 */
+    case 0x0c:  /* LCH_BASS_BOOST_N5 */
+    case 0x0d:  /* LCH_BASS_BOOST_D1 */
+    case 0x0e:  /* LCH_BASS_BOOST_D2 */
+    case 0x0f:  /* LCH_BASS_BOOST_D4 */
+    case 0x10:  /* LCH_BASS_BOOST_D5 */
+    case 0x11:  /* RCH_BASS_BOOST_N0 */
+    case 0x12:  /* RCH_BASS_BOOST_N1 */
+    case 0x13:  /* RCH_BASS_BOOST_N2 */
+    case 0x14:  /* RCH_BASS_BOOST_N3 */
+    case 0x15:  /* RCH_BASS_BOOST_N4 */
+    case 0x16:  /* RCH_BASS_BOOST_N5 */
+    case 0x17:  /* RCH_BASS_BOOST_D1 */
+    case 0x18:  /* RCH_BASS_BOOST_D2 */
+    case 0x19:  /* RCH_BASS_BOOST_D4 */
+    case 0x1a:  /* RCH_BASS_BOOST_D5 */
         s->filter_data[reg - 0x07] = value;
         return;

-    case 0x1b: /* PLL Programmability 1 */
+    case 0x1b:  /* PLL Programmability 1 */
         s->pll[0] = value & 0xfffc;
 #ifdef TSC_VERBOSE
         if (value & ~0xfffc)
@@ -747,7 +759,7 @@ static void tsc2102_audio_register_write(
 #endif
         return;

-    case 0x1c: /* PLL Programmability 2 */
+    case 0x1c:  /* PLL Programmability 2 */
         s->pll[1] = value & 0xfffc;
 #ifdef TSC_VERBOSE
         if (value & ~0xfffc)
@@ -756,7 +768,7 @@ static void tsc2102_audio_register_write(
 #endif
         return;

-    case 0x1d: /* Audio Control 4 */
+    case 0x1d:  /* Audio Control 4 */
         s->softstep = !(value & 0x4000);
 #ifdef TSC_VERBOSE
         if (value & ~0x4000)
@@ -789,8 +801,9 @@ static void tsc210x_pin_update(TSC210xState *s)
         pin_state = s->pressure && !s->dav;
     }

-    if (!s->enabled)
+    if (!s->enabled) {
         pin_state = false;
+    }

     if (pin_state != s->irq) {
         s->irq = pin_state;
@@ -800,23 +813,26 @@ static void tsc210x_pin_update(TSC210xState *s)
     switch (s->nextfunction) {
     case TSC_MODE_XY_SCAN:
     case TSC_MODE_XYZ_SCAN:
-        if (!s->pressure)
+        if (!s->pressure) {
             return;
+        }
         break;

     case TSC_MODE_X:
     case TSC_MODE_Y:
     case TSC_MODE_Z:
-        if (!s->pressure)
+        if (!s->pressure) {
             return;
+        }
         /* Fall through */
     case TSC_MODE_BAT1:
     case TSC_MODE_BAT2:
     case TSC_MODE_AUX:
     case TSC_MODE_TEMP1:
     case TSC_MODE_TEMP2:
-        if (s->dav)
+        if (s->dav) {
             s->enabled = false;
+        }
         break;

     case TSC_MODE_AUX_SCAN:
@@ -831,8 +847,9 @@ static void tsc210x_pin_update(TSC210xState *s)
         return;
     }

-    if (!s->enabled || s->busy || s->dav)
+    if (!s->enabled || s->busy || s->dav) {
         return;
+    }

     s->busy = true;
     s->precision = s->nextprecision;
@@ -846,14 +863,16 @@ static uint16_t tsc210x_read(TSC210xState *s)
 {
     uint16_t ret = 0x0000;

-    if (!s->command)
+    if (!s->command) {
         fprintf(stderr, "tsc210x_read: SPI underrun!\n");
+    }

     switch (s->page) {
     case TSC_DATA_REGISTERS_PAGE:
         ret = tsc2102_data_register_read(s, s->offset);
-        if (!s->dav)
+        if (!s->dav) {
             qemu_irq_raise(s->davint);
+        }
         break;
     case TSC_CONTROL_REGISTERS_PAGE:
         ret = tsc2102_control_register_read(s, s->offset);
@@ -868,7 +887,7 @@ static uint16_t tsc210x_read(TSC210xState *s)
     tsc210x_pin_update(s);

     /* Allow sequential reads.  */
-    s->offset ++;
+    s->offset++;
     s->state = false;
     return ret;
 }
@@ -921,10 +940,12 @@ uint32_t tsc210x_txrx(void *opaque, uint32_t value,
int len)
     /* TODO: sequential reads etc - how do we make sure the host doesn't
      * unintentionally read out a conversion result from a register while
      * transmitting the command word of the next command?  */
-    if (!value || (s->state && s->command))
+    if (!value || (s->state && s->command)) {
         ret = tsc210x_read(s);
-    if (value || (s->state && !s->command))
+    }
+    if (value || (s->state && !s->command)) {
         tsc210x_write(s, value);
+    }

     return ret;
 }
@@ -935,8 +956,9 @@ static void tsc210x_timer_tick(void *opaque)

     /* Timer ticked -- a set of conversions has been finished.  */

-    if (!s->busy)
+    if (!s->busy) {
         return;
+    }

     s->busy = false;
     s->dav |= mode_regs[s->function];
@@ -961,16 +983,18 @@ static void tsc210x_touchscreen_event(void *opaque,
      * signaling TS events immediately, but for now we simulate
      * the first conversion delay for sake of correctness.
      */
-    if (p != s->pressure)
+    if (p != s->pressure) {
         tsc210x_pin_update(s);
+    }
 }

 static void tsc210x_i2s_swallow(TSC210xState *s)
 {
-    if (s->dac_voice[0])
+    if (s->dac_voice[0]) {
         tsc210x_out_flush(s, s->codec.out.len);
-    else
+    } else {
         s->codec.out.len = 0;
+    }
 }

 static void tsc210x_i2s_set_rate(TSC210xState *s, int in, int out)
@@ -1163,32 +1187,6 @@ I2SCodec *tsc210x_codec(uWireSlave *chip)
 void tsc210x_set_transform(uWireSlave *chip, const MouseTransformInfo
*info)
 {
     TSC210xState *s = (TSC210xState *) chip->opaque;
-#if 0
-    int64_t ltr[8];
-
-    ltr[0] = (int64_t) info->a[1] * info->y;
-    ltr[1] = (int64_t) info->a[4] * info->x;
-    ltr[2] = (int64_t) info->a[1] * info->a[3] -
-            (int64_t) info->a[4] * info->a[0];
-    ltr[3] = (int64_t) info->a[2] * info->a[4] -
-            (int64_t) info->a[5] * info->a[1];
-    ltr[4] = (int64_t) info->a[0] * info->y;
-    ltr[5] = (int64_t) info->a[3] * info->x;
-    ltr[6] = (int64_t) info->a[4] * info->a[0] -
-            (int64_t) info->a[1] * info->a[3];
-    ltr[7] = (int64_t) info->a[2] * info->a[3] -
-            (int64_t) info->a[5] * info->a[0];
-
-    /* Avoid integer overflow */
-    s->tr[0] = ltr[0] >> 11;
-    s->tr[1] = ltr[1] >> 11;
-    s->tr[2] = muldiv64(ltr[2], 1, info->a[6]);
-    s->tr[3] = muldiv64(ltr[3], 1 << 4, ltr[2]);
-    s->tr[4] = ltr[4] >> 11;
-    s->tr[5] = ltr[5] >> 11;
-    s->tr[6] = muldiv64(ltr[6], 1, info->a[6]);
-    s->tr[7] = muldiv64(ltr[7], 1 << 4, ltr[6]);
-#else

     /* This version assumes touchscreen X & Y axis are parallel or
      * perpendicular to LCD's  X & Y axis in some way.  */
@@ -1218,17 +1216,17 @@ void tsc210x_set_transform(uWireSlave *chip, const
MouseTransformInfo *info)
     s->tr[4] >>= 11;
     s->tr[5] >>= 11;
     s->tr[7] <<= 4;
-#endif
 }

 void tsc210x_key_event(uWireSlave *chip, int key, int down)
 {
     TSC210xState *s = (TSC210xState *) chip->opaque;

-    if (down)
+    if (down) {
         s->kb.down |= 1 << key;
-    else
+    } else {
         s->kb.down &= ~(1 << key);
+    }

     if (down && (s->kb.down & ~s->kb.mask) && !s->kb.intr) {
         s->kb.intr = 1;
diff --git a/hw/intc/omap_intc.c b/hw/intc/omap_intc.c
index 435c47600f..4a5b413d0a 100644
--- a/hw/intc/omap_intc.c
+++ b/hw/intc/omap_intc.c
@@ -104,8 +104,8 @@ static inline void omap_inth_update(OMAPIntcState *s,
int is_fiq)
     }
 }

-#define INT_FALLING_EDGE 0
-#define INT_LOW_LEVEL 1
+#define INT_FALLING_EDGE        0
+#define INT_LOW_LEVEL           1

 static void omap_set_intr(void *opaque, int irq, int req)
 {
@@ -117,9 +117,9 @@ static void omap_set_intr(void *opaque, int irq, int
req)

     if (req) {
         rise = ~bank->irqs & (1 << n);
-        if (~bank->sens_edge & (1 << n))
+        if (~bank->sens_edge & (1 << n)) {
             rise &= ~bank->inputs;
-
+        }
         bank->inputs |= (1 << n);
         if (rise) {
             bank->irqs |= rise;
@@ -164,66 +164,69 @@ static uint64_t omap_inth_read(void *opaque, hwaddr
addr,
     offset &= 0xff;

     switch (offset) {
-    case 0x00: /* ITR */
+    case 0x00:  /* ITR */
         return bank->irqs;

-    case 0x04: /* MIR */
+    case 0x04:  /* MIR */
         return bank->mask;

-    case 0x10: /* SIR_IRQ_CODE */
+    case 0x10:  /* SIR_IRQ_CODE */
     case 0x14:  /* SIR_FIQ_CODE */
-        if (bank_no != 0)
+        if (bank_no != 0) {
             break;
+        }
         line_no = s->sir_intr[(offset - 0x10) >> 2];
         bank = &s->bank[line_no >> 5];
         i = line_no & 31;
-        if (((bank->sens_edge >> i) & 1) == INT_FALLING_EDGE)
+        if (((bank->sens_edge >> i) & 1) == INT_FALLING_EDGE) {
             bank->irqs &= ~(1 << i);
+        }
         return line_no;

-    case 0x18: /* CONTROL_REG */
-        if (bank_no != 0)
+    case 0x18:  /* CONTROL_REG */
+        if (bank_no != 0) {
             break;
+        }
         return 0;

-    case 0x1c: /* ILR0 */
-    case 0x20: /* ILR1 */
-    case 0x24: /* ILR2 */
-    case 0x28: /* ILR3 */
-    case 0x2c: /* ILR4 */
-    case 0x30: /* ILR5 */
-    case 0x34: /* ILR6 */
-    case 0x38: /* ILR7 */
-    case 0x3c: /* ILR8 */
-    case 0x40: /* ILR9 */
-    case 0x44: /* ILR10 */
-    case 0x48: /* ILR11 */
-    case 0x4c: /* ILR12 */
-    case 0x50: /* ILR13 */
-    case 0x54: /* ILR14 */
-    case 0x58: /* ILR15 */
-    case 0x5c: /* ILR16 */
-    case 0x60: /* ILR17 */
-    case 0x64: /* ILR18 */
-    case 0x68: /* ILR19 */
-    case 0x6c: /* ILR20 */
-    case 0x70: /* ILR21 */
-    case 0x74: /* ILR22 */
-    case 0x78: /* ILR23 */
-    case 0x7c: /* ILR24 */
-    case 0x80: /* ILR25 */
-    case 0x84: /* ILR26 */
-    case 0x88: /* ILR27 */
-    case 0x8c: /* ILR28 */
-    case 0x90: /* ILR29 */
-    case 0x94: /* ILR30 */
-    case 0x98: /* ILR31 */
+    case 0x1c:  /* ILR0 */
+    case 0x20:  /* ILR1 */
+    case 0x24:  /* ILR2 */
+    case 0x28:  /* ILR3 */
+    case 0x2c:  /* ILR4 */
+    case 0x30:  /* ILR5 */
+    case 0x34:  /* ILR6 */
+    case 0x38:  /* ILR7 */
+    case 0x3c:  /* ILR8 */
+    case 0x40:  /* ILR9 */
+    case 0x44:  /* ILR10 */
+    case 0x48:  /* ILR11 */
+    case 0x4c:  /* ILR12 */
+    case 0x50:  /* ILR13 */
+    case 0x54:  /* ILR14 */
+    case 0x58:  /* ILR15 */
+    case 0x5c:  /* ILR16 */
+    case 0x60:  /* ILR17 */
+    case 0x64:  /* ILR18 */
+    case 0x68:  /* ILR19 */
+    case 0x6c:  /* ILR20 */
+    case 0x70:  /* ILR21 */
+    case 0x74:  /* ILR22 */
+    case 0x78:  /* ILR23 */
+    case 0x7c:  /* ILR24 */
+    case 0x80:  /* ILR25 */
+    case 0x84:  /* ILR26 */
+    case 0x88:  /* ILR27 */
+    case 0x8c:  /* ILR28 */
+    case 0x90:  /* ILR29 */
+    case 0x94:  /* ILR30 */
+    case 0x98:  /* ILR31 */
         i = (offset - 0x1c) >> 2;
         return (bank->priority[i] << 2) |
                 (((bank->sens_edge >> i) & 1) << 1) |
                 ((bank->fiq >> i) & 1);

-    case 0x9c: /* ISR */
+    case 0x9c:  /* ISR */
         return 0x00000000;

     }
@@ -241,26 +244,27 @@ static void omap_inth_write(void *opaque, hwaddr addr,
     offset &= 0xff;

     switch (offset) {
-    case 0x00: /* ITR */
+    case 0x00:  /* ITR */
         /* Important: ignore the clearing if the IRQ is level-triggered and
            the input bit is 1 */
         bank->irqs &= value | (bank->inputs & bank->sens_edge);
         return;

-    case 0x04: /* MIR */
+    case 0x04:  /* MIR */
         bank->mask = value;
         omap_inth_update(s, 0);
         omap_inth_update(s, 1);
         return;

-    case 0x10: /* SIR_IRQ_CODE */
-    case 0x14: /* SIR_FIQ_CODE */
+    case 0x10:  /* SIR_IRQ_CODE */
+    case 0x14:  /* SIR_FIQ_CODE */
         OMAP_RO_REG(addr);
         break;

-    case 0x18: /* CONTROL_REG */
-        if (bank_no != 0)
+    case 0x18:  /* CONTROL_REG */
+        if (bank_no != 0) {
             break;
+        }
         if (value & 2) {
             qemu_set_irq(s->parent_intr[1], 0);
             s->new_agr[1] = ~0;
@@ -273,38 +277,38 @@ static void omap_inth_write(void *opaque, hwaddr addr,
         }
         return;

-    case 0x1c: /* ILR0 */
-    case 0x20: /* ILR1 */
-    case 0x24: /* ILR2 */
-    case 0x28: /* ILR3 */
-    case 0x2c: /* ILR4 */
-    case 0x30: /* ILR5 */
-    case 0x34: /* ILR6 */
-    case 0x38: /* ILR7 */
-    case 0x3c: /* ILR8 */
-    case 0x40: /* ILR9 */
-    case 0x44: /* ILR10 */
-    case 0x48: /* ILR11 */
-    case 0x4c: /* ILR12 */
-    case 0x50: /* ILR13 */
-    case 0x54: /* ILR14 */
-    case 0x58: /* ILR15 */
-    case 0x5c: /* ILR16 */
-    case 0x60: /* ILR17 */
-    case 0x64: /* ILR18 */
-    case 0x68: /* ILR19 */
-    case 0x6c: /* ILR20 */
-    case 0x70: /* ILR21 */
-    case 0x74: /* ILR22 */
-    case 0x78: /* ILR23 */
-    case 0x7c: /* ILR24 */
-    case 0x80: /* ILR25 */
-    case 0x84: /* ILR26 */
-    case 0x88: /* ILR27 */
-    case 0x8c: /* ILR28 */
-    case 0x90: /* ILR29 */
-    case 0x94: /* ILR30 */
-    case 0x98: /* ILR31 */
+    case 0x1c:  /* ILR0 */
+    case 0x20:  /* ILR1 */
+    case 0x24:  /* ILR2 */
+    case 0x28:  /* ILR3 */
+    case 0x2c:  /* ILR4 */
+    case 0x30:  /* ILR5 */
+    case 0x34:  /* ILR6 */
+    case 0x38:  /* ILR7 */
+    case 0x3c:  /* ILR8 */
+    case 0x40:  /* ILR9 */
+    case 0x44:  /* ILR10 */
+    case 0x48:  /* ILR11 */
+    case 0x4c:  /* ILR12 */
+    case 0x50:  /* ILR13 */
+    case 0x54:  /* ILR14 */
+    case 0x58:  /* ILR15 */
+    case 0x5c:  /* ILR16 */
+    case 0x60:  /* ILR17 */
+    case 0x64:  /* ILR18 */
+    case 0x68:  /* ILR19 */
+    case 0x6c:  /* ILR20 */
+    case 0x70:  /* ILR21 */
+    case 0x74:  /* ILR22 */
+    case 0x78:  /* ILR23 */
+    case 0x7c:  /* ILR24 */
+    case 0x80:  /* ILR25 */
+    case 0x84:  /* ILR26 */
+    case 0x88:  /* ILR27 */
+    case 0x8c:  /* ILR28 */
+    case 0x90:  /* ILR29 */
+    case 0x94:  /* ILR30 */
+    case 0x98:  /* ILR31 */
         i = (offset - 0x1c) >> 2;
         bank->priority[i] = (value >> 2) & 0x1f;
         bank->sens_edge &= ~(1 << i);
@@ -313,8 +317,8 @@ static void omap_inth_write(void *opaque, hwaddr addr,
         bank->fiq |= (value & 1) << i;
         return;

-    case 0x9c: /* ISR */
-        for (i = 0; i < 32; i ++)
+    case 0x9c:  /* ISR */
+        for (i = 0; i < 32; i++)
             if (value & (1 << i)) {
                 omap_set_intr(s, 32 * bank_no + i, 1);
                 return;
@@ -339,7 +343,7 @@ static void omap_inth_reset(DeviceState *dev)
     OMAPIntcState *s = OMAP_INTC(dev);
     int i;

-    for (i = 0; i < s->nbanks; ++i){
+    for (i = 0; i < s->nbanks; ++i) {
         s->bank[i].irqs = 0x00000000;
         s->bank[i].mask = 0xffffffff;
         s->bank[i].sens_edge = 0x00000000;
@@ -348,8 +352,9 @@ static void omap_inth_reset(DeviceState *dev)
         s->bank[i].swi = 0x00000000;
         memset(s->bank[i].priority, 0, sizeof(s->bank[i].priority));

-        if (s->level_only)
+        if (s->level_only) {
             s->bank[i].sens_edge = 0xffffffff;
+        }
     }

     s->new_agr[0] = ~0;
@@ -440,58 +445,59 @@ static uint64_t omap2_inth_read(void *opaque, hwaddr
addr,
     }

     switch (offset) {
-    case 0x00: /* INTC_REVISION */
+    case 0x00:  /* INTC_REVISION */
         return s->revision;

-    case 0x10: /* INTC_SYSCONFIG */
+    case 0x10:  /* INTC_SYSCONFIG */
         return (s->autoidle >> 2) & 1;

-    case 0x14: /* INTC_SYSSTATUS */
-        return 1; /* RESETDONE */
+    case 0x14:  /* INTC_SYSSTATUS */
+        return 1;                                               /*
RESETDONE */

-    case 0x40: /* INTC_SIR_IRQ */
+    case 0x40:  /* INTC_SIR_IRQ */
         return s->sir_intr[0];

-    case 0x44: /* INTC_SIR_FIQ */
+    case 0x44:  /* INTC_SIR_FIQ */
         return s->sir_intr[1];

-    case 0x48: /* INTC_CONTROL */
-        return (!s->mask) << 2; /* GLOBALMASK */
+    case 0x48:  /* INTC_CONTROL */
+        return (!s->mask) << 2;                                /*
GLOBALMASK */

-    case 0x4c: /* INTC_PROTECTION */
+    case 0x4c:  /* INTC_PROTECTION */
         return 0;

-    case 0x50: /* INTC_IDLE */
+    case 0x50:  /* INTC_IDLE */
         return s->autoidle & 3;

     /* Per-bank registers */
-    case 0x80: /* INTC_ITR */
+    case 0x80:  /* INTC_ITR */
         return bank->inputs;

-    case 0x84: /* INTC_MIR */
+    case 0x84:  /* INTC_MIR */
         return bank->mask;

-    case 0x88: /* INTC_MIR_CLEAR */
-    case 0x8c: /* INTC_MIR_SET */
+    case 0x88:  /* INTC_MIR_CLEAR */
+    case 0x8c:  /* INTC_MIR_SET */
         return 0;

-    case 0x90: /* INTC_ISR_SET */
+    case 0x90:  /* INTC_ISR_SET */
         return bank->swi;

-    case 0x94: /* INTC_ISR_CLEAR */
+    case 0x94:  /* INTC_ISR_CLEAR */
         return 0;

-    case 0x98: /* INTC_PENDING_IRQ */
+    case 0x98:  /* INTC_PENDING_IRQ */
         return bank->irqs & ~bank->mask & ~bank->fiq;

-    case 0x9c: /* INTC_PENDING_FIQ */
+    case 0x9c:  /* INTC_PENDING_FIQ */
         return bank->irqs & ~bank->mask & bank->fiq;

     /* Per-line registers */
-    case 0x100 ... 0x300: /* INTC_ILR */
+    case 0x100 ... 0x300:       /* INTC_ILR */
         bank_no = (offset - 0x100) >> 7;
-        if (bank_no > s->nbanks)
+        if (bank_no > s->nbanks) {
             break;
+        }
         bank = &s->bank[bank_no];
         line_no = (offset & 0x7f) >> 2;
         return (bank->priority[line_no] << 2) |
@@ -521,7 +527,7 @@ static void omap2_inth_write(void *opaque, hwaddr addr,
     }

     switch (offset) {
-    case 0x10: /* INTC_SYSCONFIG */
+    case 0x10:  /* INTC_SYSCONFIG */
         s->autoidle &= 4;
         s->autoidle |= (value & 1) << 2;
         if (value & 2) {                                        /*
SOFTRESET */
@@ -529,21 +535,21 @@ static void omap2_inth_write(void *opaque, hwaddr
addr,
         }
         return;

-    case 0x48: /* INTC_CONTROL */
-        s->mask = (value & 4) ? 0 : ~0; /* GLOBALMASK */
-        if (value & 2) { /* NEWFIQAGR */
+    case 0x48:  /* INTC_CONTROL */
+        s->mask = (value & 4) ? 0 : ~0;                         /*
GLOBALMASK */
+        if (value & 2) {                                        /*
NEWFIQAGR */
             qemu_set_irq(s->parent_intr[1], 0);
             s->new_agr[1] = ~0;
             omap_inth_update(s, 1);
         }
-        if (value & 1) { /* NEWIRQAGR */
+        if (value & 1) {                                        /*
NEWIRQAGR */
             qemu_set_irq(s->parent_intr[0], 0);
             s->new_agr[0] = ~0;
             omap_inth_update(s, 0);
         }
         return;

-    case 0x4c: /* INTC_PROTECTION */
+    case 0x4c:  /* INTC_PROTECTION */
         /* TODO: Make a bitmap (or sizeof(char)map) of access privileges
          * for every register, see Chapter 3 and 4 for privileged mode.  */
         if (value & 1)
@@ -551,44 +557,45 @@ static void omap2_inth_write(void *opaque, hwaddr
addr,
                             __func__);
         return;

-    case 0x50: /* INTC_IDLE */
+    case 0x50:  /* INTC_IDLE */
         s->autoidle &= ~3;
         s->autoidle |= value & 3;
         return;

     /* Per-bank registers */
-    case 0x84: /* INTC_MIR */
+    case 0x84:  /* INTC_MIR */
         bank->mask = value;
         omap_inth_update(s, 0);
         omap_inth_update(s, 1);
         return;

-    case 0x88: /* INTC_MIR_CLEAR */
+    case 0x88:  /* INTC_MIR_CLEAR */
         bank->mask &= ~value;
         omap_inth_update(s, 0);
         omap_inth_update(s, 1);
         return;

-    case 0x8c: /* INTC_MIR_SET */
+    case 0x8c:  /* INTC_MIR_SET */
         bank->mask |= value;
         return;

-    case 0x90: /* INTC_ISR_SET */
+    case 0x90:  /* INTC_ISR_SET */
         bank->irqs |= bank->swi |= value;
         omap_inth_update(s, 0);
         omap_inth_update(s, 1);
         return;

-    case 0x94: /* INTC_ISR_CLEAR */
+    case 0x94:  /* INTC_ISR_CLEAR */
         bank->swi &= ~value;
         bank->irqs = bank->swi & bank->inputs;
         return;

     /* Per-line registers */
-    case 0x100 ... 0x300: /* INTC_ILR */
+    case 0x100 ... 0x300:       /* INTC_ILR */
         bank_no = (offset - 0x100) >> 7;
-        if (bank_no > s->nbanks)
+        if (bank_no > s->nbanks) {
             break;
+        }
         bank = &s->bank[bank_no];
         line_no = (offset & 0x7f) >> 2;
         bank->priority[line_no] = (value >> 2) & 0x3f;
@@ -596,13 +603,13 @@ static void omap2_inth_write(void *opaque, hwaddr
addr,
         bank->fiq |= (value & 1) << line_no;
         return;

-    case 0x00: /* INTC_REVISION */
-    case 0x14: /* INTC_SYSSTATUS */
-    case 0x40: /* INTC_SIR_IRQ */
-    case 0x44: /* INTC_SIR_FIQ */
-    case 0x80: /* INTC_ITR */
-    case 0x98: /* INTC_PENDING_IRQ */
-    case 0x9c: /* INTC_PENDING_FIQ */
+    case 0x00:  /* INTC_REVISION */
+    case 0x14:  /* INTC_SYSSTATUS */
+    case 0x40:  /* INTC_SIR_IRQ */
+    case 0x44:  /* INTC_SIR_FIQ */
+    case 0x80:  /* INTC_ITR */
+    case 0x98:  /* INTC_PENDING_IRQ */
+    case 0x9c:  /* INTC_PENDING_FIQ */
         OMAP_RO_REG(addr);
         return;
     }
diff --git a/hw/misc/cbus.c b/hw/misc/cbus.c
index 653e8ddcd5..a09232e755 100644
--- a/hw/misc/cbus.c
+++ b/hw/misc/cbus.c
@@ -26,7 +26,7 @@
 #include "hw/misc/cbus.h"
 #include "sysemu/runstate.h"

-//#define DEBUG
+/*#define DEBUG*/

 typedef struct {
     void *opaque;
@@ -78,13 +78,15 @@ static void cbus_cycle(CBusPriv *s)
         s->dir = !s->rw;
         s->val = 0;

-        if (s->rw)
+        if (s->rw) {
             cbus_io(s);
+        }
         break;

     case cbus_value:
-        if (!s->rw)
+        if (!s->rw) {
             cbus_io(s);
+        }

         s->cycle = cbus_address;
         s->bit = 8;
@@ -99,13 +101,15 @@ static void cbus_clk(void *opaque, int line, int level)
     CBusPriv *s = (CBusPriv *) opaque;

     if (!s->sel && level && !s->clk) {
-        if (s->dir)
-            s->val |= s->dat << (s->bit --);
-        else
-            qemu_set_irq(s->dat_out, (s->val >> (s->bit --)) & 1);
+        if (s->dir) {
+            s->val |= s->dat << (s->bit--);
+        } else {
+            qemu_set_irq(s->dat_out, (s->val >> (s->bit--)) & 1);
+        }

-        if (s->bit < 0)
+        if (s->bit < 0) {
             cbus_cycle(s);
+        }
     }

     s->clk = level;
@@ -179,61 +183,61 @@ static void retu_interrupt_update(CBusRetu *s)
     qemu_set_irq(s->irq, s->irqst & ~s->irqen);
 }

-#define RETU_REG_ASICR 0x00 /* (RO) ASIC ID & revision */
-#define RETU_REG_IDR 0x01 /* (T)  Interrupt ID */
-#define RETU_REG_IMR 0x02 /* (RW) Interrupt mask */
-#define RETU_REG_RTCDSR 0x03 /* (RW) RTC seconds register */
-#define RETU_REG_RTCHMR 0x04 /* (RO) RTC hours and minutes reg */
-#define RETU_REG_RTCHMAR 0x05 /* (RW) RTC hours and minutes set reg */
-#define RETU_REG_RTCCALR 0x06 /* (RW) RTC calibration register */
-#define RETU_REG_ADCR 0x08 /* (RW) ADC result register */
-#define RETU_REG_ADCSCR 0x09 /* (RW) ADC sample control register */
-#define RETU_REG_AFCR 0x0a /* (RW) AFC register */
-#define RETU_REG_ANTIFR 0x0b /* (RW) AntiF register */
-#define RETU_REG_CALIBR 0x0c /* (RW) CalibR register*/
-#define RETU_REG_CCR1 0x0d /* (RW) Common control register 1 */
-#define RETU_REG_CCR2 0x0e /* (RW) Common control register 2 */
-#define RETU_REG_RCTRL_CLR 0x0f /* (T)  Regulator clear register */
-#define RETU_REG_RCTRL_SET 0x10 /* (T)  Regulator set register */
-#define RETU_REG_TXCR 0x11 /* (RW) TxC register */
-#define RETU_REG_STATUS 0x16 /* (RO) Status register */
-#define RETU_REG_WATCHDOG 0x17 /* (RW) Watchdog register */
-#define RETU_REG_AUDTXR 0x18 /* (RW) Audio Codec Tx register */
-#define RETU_REG_AUDPAR 0x19 /* (RW) AudioPA register */
-#define RETU_REG_AUDRXR1 0x1a /* (RW) Audio receive register 1 */
-#define RETU_REG_AUDRXR2 0x1b /* (RW) Audio receive register 2 */
-#define RETU_REG_SGR1 0x1c /* (RW) */
-#define RETU_REG_SCR1 0x1d /* (RW) */
-#define RETU_REG_SGR2 0x1e /* (RW) */
-#define RETU_REG_SCR2 0x1f /* (RW) */
+#define RETU_REG_ASICR      0x00  /* (RO) ASIC ID & revision */
+#define RETU_REG_IDR        0x01  /* (T)  Interrupt ID */
+#define RETU_REG_IMR        0x02  /* (RW) Interrupt mask */
+#define RETU_REG_RTCDSR     0x03  /* (RW) RTC seconds register */
+#define RETU_REG_RTCHMR     0x04  /* (RO) RTC hours and minutes reg */
+#define RETU_REG_RTCHMAR    0x05  /* (RW) RTC hours and minutes set reg */
+#define RETU_REG_RTCCALR    0x06  /* (RW) RTC calibration register */
+#define RETU_REG_ADCR       0x08  /* (RW) ADC result register */
+#define RETU_REG_ADCSCR     0x09  /* (RW) ADC sample control register */
+#define RETU_REG_AFCR       0x0a  /* (RW) AFC register */
+#define RETU_REG_ANTIFR     0x0b  /* (RW) AntiF register */
+#define RETU_REG_CALIBR     0x0c  /* (RW) CalibR register*/
+#define RETU_REG_CCR1       0x0d  /* (RW) Common control register 1 */
+#define RETU_REG_CCR2       0x0e  /* (RW) Common control register 2 */
+#define RETU_REG_RCTRL_CLR  0x0f  /* (T)  Regulator clear register */
+#define RETU_REG_RCTRL_SET  0x10  /* (T)  Regulator set register */
+#define RETU_REG_TXCR       0x11  /* (RW) TxC register */
+#define RETU_REG_STATUS     0x16  /* (RO) Status register */
+#define RETU_REG_WATCHDOG   0x17  /* (RW) Watchdog register */
+#define RETU_REG_AUDTXR     0x18  /* (RW) Audio Codec Tx register */
+#define RETU_REG_AUDPAR     0x19  /* (RW) AudioPA register */
+#define RETU_REG_AUDRXR1    0x1a  /* (RW) Audio receive register 1 */
+#define RETU_REG_AUDRXR2    0x1b  /* (RW) Audio receive register 2 */
+#define RETU_REG_SGR1       0x1c  /* (RW) */
+#define RETU_REG_SCR1       0x1d  /* (RW) */
+#define RETU_REG_SGR2       0x1e  /* (RW) */
+#define RETU_REG_SCR2       0x1f  /* (RW) */

 /* Retu Interrupt sources */
 enum {
-    retu_int_pwr = 0, /* Power button */
-    retu_int_char = 1, /* Charger */
-    retu_int_rtcs = 2, /* Seconds */
-    retu_int_rtcm = 3, /* Minutes */
-    retu_int_rtcd = 4, /* Days */
-    retu_int_rtca = 5, /* Alarm */
-    retu_int_hook = 6, /* Hook */
-    retu_int_head = 7, /* Headset */
-    retu_int_adcs = 8, /* ADC sample */
+    retu_int_pwr  = 0,  /* Power button */
+    retu_int_char = 1,  /* Charger */
+    retu_int_rtcs = 2,  /* Seconds */
+    retu_int_rtcm = 3,  /* Minutes */
+    retu_int_rtcd = 4,  /* Days */
+    retu_int_rtca = 5,  /* Alarm */
+    retu_int_hook = 6,  /* Hook */
+    retu_int_head = 7,  /* Headset */
+    retu_int_adcs = 8,  /* ADC sample */
 };

 /* Retu ADC channel wiring */
 enum {
-    retu_adc_bsi = 1, /* BSI */
-    retu_adc_batt_temp = 2, /* Battery temperature */
-    retu_adc_chg_volt = 3, /* Charger voltage */
-    retu_adc_head_det = 4, /* Headset detection */
-    retu_adc_hook_det = 5, /* Hook detection */
-    retu_adc_rf_gp = 6, /* RF GP */
-    retu_adc_tx_det = 7, /* Wideband Tx detection */
-    retu_adc_batt_volt = 8, /* Battery voltage */
-    retu_adc_sens = 10, /* Light sensor */
-    retu_adc_sens_temp = 11, /* Light sensor temperature */
-    retu_adc_bbatt_volt = 12, /* Backup battery voltage */
-    retu_adc_self_temp = 13, /* RETU temperature */
+    retu_adc_bsi = 1,         /* BSI */
+    retu_adc_batt_temp = 2,   /* Battery temperature */
+    retu_adc_chg_volt = 3,    /* Charger voltage */
+    retu_adc_head_det = 4,    /* Headset detection */
+    retu_adc_hook_det = 5,    /* Hook detection */
+    retu_adc_rf_gp = 6,       /* RF GP */
+    retu_adc_tx_det = 7,      /* Wideband Tx detection */
+    retu_adc_batt_volt = 8,   /* Battery voltage */
+    retu_adc_sens = 10,       /* Light sensor */
+    retu_adc_sens_temp = 11,  /* Light sensor temperature */
+    retu_adc_bbatt_volt = 12, /* Backup battery voltage */
+    retu_adc_self_temp = 13,  /* RETU temperature */
 };

 static inline uint16_t retu_read(CBusRetu *s, int reg)
@@ -246,7 +250,7 @@ static inline uint16_t retu_read(CBusRetu *s, int reg)
     case RETU_REG_ASICR:
         return 0x0215 | (s->is_vilma << 7);

-    case RETU_REG_IDR: /* TODO: Or is this ffs(s->irqst)?  */
+    case RETU_REG_IDR:  /* TODO: Or is this ffs(s->irqst)?  */
         return s->irqst;

     case RETU_REG_IMR:
@@ -355,8 +359,9 @@ static inline void retu_write(CBusRetu *s, int reg,
uint16_t val)
         break;

     case RETU_REG_WATCHDOG:
-        if (val == 0 && (s->cc[0] & 2))
+        if (val == 0 && (s->cc[0] & 2)) {
             qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
+        }
         break;

     case RETU_REG_TXCR:
@@ -380,10 +385,11 @@ static void retu_io(void *opaque, int rw, int reg,
uint16_t *val)
 {
     CBusRetu *s = (CBusRetu *) opaque;

-    if (rw)
+    if (rw) {
         *val = retu_read(s, reg);
-    else
+    } else {
         retu_write(s, reg, *val);
+    }
 }

 void *retu_init(qemu_irq irq, int vilma)
@@ -424,47 +430,12 @@ void retu_key_event(void *retu, int state)
     s->irqst |= 1 << retu_int_pwr;
     retu_interrupt_update(s);

-    if (state)
+    if (state) {
         s->status &= ~(1 << 5);
-    else
+    } else {
         s->status |= 1 << 5;
-}
-
-#if 0
-static void retu_head_event(void *retu, int state)
-{
-    CBusSlave *slave = (CBusSlave *) retu;
-    CBusRetu *s = (CBusRetu *) slave->opaque;
-
-    if ((s->cc[0] & 0x500) == 0x500) { /* TODO: Which bits? */
-        /* TODO: reissue the interrupt every 100ms or so.  */
-        s->irqst |= 1 << retu_int_head;
-        retu_interrupt_update(s);
     }
-
-    if (state)
-        s->result[retu_adc_head_det] = 50;
-    else
-        s->result[retu_adc_head_det] = 123;
-}
-
-static void retu_hook_event(void *retu, int state)
-{
-    CBusSlave *slave = (CBusSlave *) retu;
-    CBusRetu *s = (CBusRetu *) slave->opaque;
-
-    if ((s->cc[0] & 0x500) == 0x500) {
-        /* TODO: reissue the interrupt every 100ms or so.  */
-        s->irqst |= 1 << retu_int_hook;
-        retu_interrupt_update(s);
-    }
-
-    if (state)
-        s->result[retu_adc_hook_det] = 50;
-    else
-        s->result[retu_adc_hook_det] = 123;
 }
-#endif

 /* Tahvo/Betty */
 typedef struct {
@@ -485,20 +456,20 @@ static void tahvo_interrupt_update(CBusTahvo *s)
     qemu_set_irq(s->irq, s->irqst & ~s->irqen);
 }

-#define TAHVO_REG_ASICR 0x00 /* (RO) ASIC ID & revision */
-#define TAHVO_REG_IDR 0x01 /* (T)  Interrupt ID */
-#define TAHVO_REG_IDSR 0x02 /* (RO) Interrupt status */
-#define TAHVO_REG_IMR 0x03 /* (RW) Interrupt mask */
-#define TAHVO_REG_CHAPWMR 0x04 /* (RW) Charger PWM */
-#define TAHVO_REG_LEDPWMR 0x05 /* (RW) LED PWM */
-#define TAHVO_REG_USBR 0x06 /* (RW) USB control */
-#define TAHVO_REG_RCR 0x07 /* (RW) Some kind of power management */
-#define TAHVO_REG_CCR1 0x08 /* (RW) Common control register 1 */
-#define TAHVO_REG_CCR2 0x09 /* (RW) Common control register 2 */
-#define TAHVO_REG_TESTR1 0x0a /* (RW) Test register 1 */
-#define TAHVO_REG_TESTR2 0x0b /* (RW) Test register 2 */
-#define TAHVO_REG_NOPR 0x0c /* (RW) Number of periods */
-#define TAHVO_REG_FRR 0x0d /* (RO) FR */
+#define TAHVO_REG_ASICR   0x00  /* (RO) ASIC ID & revision */
+#define TAHVO_REG_IDR     0x01  /* (T)  Interrupt ID */
+#define TAHVO_REG_IDSR    0x02  /* (RO) Interrupt status */
+#define TAHVO_REG_IMR     0x03  /* (RW) Interrupt mask */
+#define TAHVO_REG_CHAPWMR 0x04  /* (RW) Charger PWM */
+#define TAHVO_REG_LEDPWMR 0x05  /* (RW) LED PWM */
+#define TAHVO_REG_USBR    0x06  /* (RW) USB control */
+#define TAHVO_REG_RCR     0x07  /* (RW) Some kind of power management */
+#define TAHVO_REG_CCR1    0x08  /* (RW) Common control register 1 */
+#define TAHVO_REG_CCR2    0x09  /* (RW) Common control register 2 */
+#define TAHVO_REG_TESTR1  0x0a  /* (RW) Test register 1 */
+#define TAHVO_REG_TESTR2  0x0b  /* (RW) Test register 2 */
+#define TAHVO_REG_NOPR    0x0c  /* (RW) Number of periods */
+#define TAHVO_REG_FRR     0x0d  /* (RO) FR */

 static inline uint16_t tahvo_read(CBusTahvo *s, int reg)
 {
@@ -508,10 +479,10 @@ static inline uint16_t tahvo_read(CBusTahvo *s, int
reg)

     switch (reg) {
     case TAHVO_REG_ASICR:
-        return 0x0021 | (s->is_betty ? 0x0b00 : 0x0300); /* 22 in N810 */
+        return 0x0021 | (s->is_betty ? 0x0b00 : 0x0300);  /* 22 in N810 */

     case TAHVO_REG_IDR:
-    case TAHVO_REG_IDSR: /* XXX: what does this do?  */
+    case TAHVO_REG_IDSR:  /* XXX: what does this do?  */
         return s->irqst;

     case TAHVO_REG_IMR:
@@ -596,10 +567,11 @@ static void tahvo_io(void *opaque, int rw, int reg,
uint16_t *val)
 {
     CBusTahvo *s = (CBusTahvo *) opaque;

-    if (rw)
+    if (rw) {
         *val = tahvo_read(s, reg);
-    else
+    } else {
         tahvo_write(s, reg, *val);
+   }
 }

 void *tahvo_init(qemu_irq irq, int betty)
diff --git a/hw/misc/omap_clk.c b/hw/misc/omap_clk.c
index c77ca2fc74..ec2345e9ab 100644
--- a/hw/misc/omap_clk.c
+++ b/hw/misc/omap_clk.c
@@ -30,174 +30,174 @@ struct clk {
     struct clk *parent;
     struct clk *child1;
     struct clk *sibling;
-#define ALWAYS_ENABLED (1 << 0)
-#define CLOCK_IN_OMAP310 (1 << 10)
-#define CLOCK_IN_OMAP730 (1 << 11)
-#define CLOCK_IN_OMAP1510 (1 << 12)
-#define CLOCK_IN_OMAP16XX (1 << 13)
-#define CLOCK_IN_OMAP242X (1 << 14)
-#define CLOCK_IN_OMAP243X (1 << 15)
-#define CLOCK_IN_OMAP343X (1 << 16)
+#define ALWAYS_ENABLED    (1 << 0)
+#define CLOCK_IN_OMAP310  (1 << 10)
+#define CLOCK_IN_OMAP730  (1 << 11)
+#define CLOCK_IN_OMAP1510 (1 << 12)
+#define CLOCK_IN_OMAP16XX (1 << 13)
+#define CLOCK_IN_OMAP242X (1 << 14)
+#define CLOCK_IN_OMAP243X (1 << 15)
+#define CLOCK_IN_OMAP343X (1 << 16)
     uint32_t flags;
     int id;

-    int running; /* Is currently ticking */
-    int enabled; /* Is enabled, regardless of its input clk */
-    unsigned long rate; /* Current rate (if .running) */
-    unsigned int divisor; /* Rate relative to input (if .enabled) */
-    unsigned int multiplier; /* Rate relative to input (if .enabled) */
-    qemu_irq users[16]; /* Who to notify on change */
-    int usecount; /* Automatically idle when unused */
+    int running;    /* Is currently ticking */
+    int enabled;    /* Is enabled, regardless of its input clk */
+    unsigned long rate;    /* Current rate (if .running) */
+    unsigned int divisor; /*g Rate relative to input (if .enabled) */
+    unsigned int multiplier; /*g Rate relative to input (if .enabled) */
+    qemu_irq users[16];    /* Who to notify on change */
+    int usecount;    /* Automatically idle when unused */
 };

 static struct clk xtal_osc12m = {
-    .name = "xtal_osc_12m",
-    .rate = 12000000,
-    .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310,
+    .name = "xtal_osc_12m",
+    .rate = 12000000,
+    .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310,
 };

 static struct clk xtal_osc32k = {
-    .name = "xtal_osc_32k",
-    .rate = 32768,
-    .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310 |
+    .name = "xtal_osc_32k",
+    .rate = 32768,
+    .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310 |
             CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 };

 static struct clk ck_ref = {
-    .name = "ck_ref",
-    .alias = "clkin",
-    .parent = &xtal_osc12m,
-    .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310 |
+    .name = "ck_ref",
+    .alias = "clkin",
+    .parent = &xtal_osc12m,
+    .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310 |
             ALWAYS_ENABLED,
 };

 /* If a dpll is disabled it becomes a bypass, child clocks don't stop */
 static struct clk dpll1 = {
-    .name = "dpll1",
-    .parent = &ck_ref,
-    .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310 |
+    .name = "dpll1",
+    .parent = &ck_ref,
+    .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310 |
             ALWAYS_ENABLED,
 };

 static struct clk dpll2 = {
-    .name = "dpll2",
-    .parent = &ck_ref,
-    .flags = CLOCK_IN_OMAP310 | ALWAYS_ENABLED,
+    .name = "dpll2",
+    .parent = &ck_ref,
+    .flags = CLOCK_IN_OMAP310 | ALWAYS_ENABLED,
 };

 static struct clk dpll3 = {
-    .name = "dpll3",
-    .parent = &ck_ref,
-    .flags = CLOCK_IN_OMAP310 | ALWAYS_ENABLED,
+    .name = "dpll3",
+    .parent = &ck_ref,
+    .flags = CLOCK_IN_OMAP310 | ALWAYS_ENABLED,
 };

 static struct clk dpll4 = {
-    .name = "dpll4",
-    .parent = &ck_ref,
-    .multiplier = 4,
-    .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310,
+    .name = "dpll4",
+    .parent = &ck_ref,
+    .multiplier = 4,
+    .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310,
 };

 static struct clk apll = {
-    .name = "apll",
-    .parent = &ck_ref,
-    .multiplier = 48,
-    .divisor = 12,
-    .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310,
+    .name = "apll",
+    .parent = &ck_ref,
+    .multiplier = 48,
+    .divisor = 12,
+    .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310,
 };

 static struct clk ck_48m = {
-    .name = "ck_48m",
-    .parent = &dpll4, /* either dpll4 or apll */
-    .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310,
+    .name = "ck_48m",
+    .parent = &dpll4, /*g either dpll4 or apll */
+    .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310,
 };

 static struct clk ck_dpll1out = {
-    .name = "ck_dpll1out",
-    .parent = &dpll1,
-    .flags = CLOCK_IN_OMAP16XX,
+    .name = "ck_dpll1out",
+    .parent = &dpll1,
+    .flags = CLOCK_IN_OMAP16XX,
 };

 static struct clk sossi_ck = {
-    .name = "ck_sossi",
-    .parent = &ck_dpll1out,
-    .flags = CLOCK_IN_OMAP16XX,
+    .name = "ck_sossi",
+    .parent = &ck_dpll1out,
+    .flags = CLOCK_IN_OMAP16XX,
 };

 static struct clk clkm1 = {
-    .name = "clkm1",
-    .alias = "ck_gen1",
-    .parent = &dpll1,
-    .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310 |
+    .name = "clkm1",
+    .alias = "ck_gen1",
+    .parent = &dpll1,
+    .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310 |
             ALWAYS_ENABLED,
 };

 static struct clk clkm2 = {
-    .name = "clkm2",
-    .alias = "ck_gen2",
-    .parent = &dpll1,
-    .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310 |
+    .name = "clkm2",
+    .alias = "ck_gen2",
+    .parent = &dpll1,
+    .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310 |
             ALWAYS_ENABLED,
 };

 static struct clk clkm3 = {
-    .name = "clkm3",
-    .alias = "ck_gen3",
-    .parent = &dpll1, /* either dpll1 or ck_ref */
-    .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310 |
+    .name = "clkm3",
+    .alias = "ck_gen3",
+    .parent = &dpll1, /*g either dpll1 or ck_ref */
+    .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310 |
             ALWAYS_ENABLED,
 };

 static struct clk arm_ck = {
-    .name = "arm_ck",
-    .alias = "mpu_ck",
-    .parent = &clkm1,
-    .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310 |
+    .name = "arm_ck",
+    .alias = "mpu_ck",
+    .parent = &clkm1,
+    .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310 |
             ALWAYS_ENABLED,
 };

 static struct clk armper_ck = {
-    .name = "armper_ck",
-    .alias = "mpuper_ck",
-    .parent = &clkm1,
-    .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310,
+    .name = "armper_ck",
+    .alias = "mpuper_ck",
+    .parent = &clkm1,
+    .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310,
 };

 static struct clk arm_gpio_ck = {
-    .name = "arm_gpio_ck",
-    .alias = "mpu_gpio_ck",
-    .parent = &clkm1,
-    .divisor = 1,
-    .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310,
+    .name = "arm_gpio_ck",
+    .alias = "mpu_gpio_ck",
+    .parent = &clkm1,
+    .divisor = 1,
+    .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310,
 };

 static struct clk armxor_ck = {
-    .name = "armxor_ck",
-    .alias = "mpuxor_ck",
-    .parent = &ck_ref,
-    .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310,
+    .name = "armxor_ck",
+    .alias = "mpuxor_ck",
+    .parent = &ck_ref,
+    .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310,
 };

 static struct clk armtim_ck = {
-    .name = "armtim_ck",
-    .alias = "mputim_ck",
-    .parent = &ck_ref, /* either CLKIN or DPLL1 */
-    .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310,
+    .name = "armtim_ck",
+    .alias = "mputim_ck",
+    .parent = &ck_ref, /*g either CLKIN or DPLL1 */
+    .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310,
 };

 static struct clk armwdt_ck = {
-    .name = "armwdt_ck",
-    .alias = "mpuwd_ck",
-    .parent = &clkm1,
-    .divisor = 14,
-    .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310 |
+    .name = "armwdt_ck",
+    .alias = "mpuwd_ck",
+    .parent = &clkm1,
+    .divisor = 14,
+    .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310 |
             ALWAYS_ENABLED,
 };

 static struct clk arminth_ck16xx = {
-    .name = "arminth_ck",
-    .parent = &arm_ck,
-    .flags = CLOCK_IN_OMAP16XX | ALWAYS_ENABLED,
+    .name = "arminth_ck",
+    .parent = &arm_ck,
+    .flags = CLOCK_IN_OMAP16XX | ALWAYS_ENABLED,
     /* Note: On 16xx the frequency can be divided by 2 by programming
      * ARM_CKCTL:ARM_INTHCK_SEL(14) to 1
      *
@@ -206,48 +206,48 @@ static struct clk arminth_ck16xx = {
 };

 static struct clk dsp_ck = {
-    .name = "dsp_ck",
-    .parent = &clkm2,
-    .flags = CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX,
+    .name = "dsp_ck",
+    .parent = &clkm2,
+    .flags = CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX,
 };

 static struct clk dspmmu_ck = {
-    .name = "dspmmu_ck",
-    .parent = &clkm2,
-    .flags = CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
+    .name = "dspmmu_ck",
+    .parent = &clkm2,
+    .flags = CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
             ALWAYS_ENABLED,
 };

 static struct clk dspper_ck = {
-    .name = "dspper_ck",
-    .parent = &clkm2,
-    .flags = CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX,
+    .name = "dspper_ck",
+    .parent = &clkm2,
+    .flags = CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX,
 };

 static struct clk dspxor_ck = {
-    .name = "dspxor_ck",
-    .parent = &ck_ref,
-    .flags = CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX,
+    .name = "dspxor_ck",
+    .parent = &ck_ref,
+    .flags = CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX,
 };

 static struct clk dsptim_ck = {
-    .name = "dsptim_ck",
-    .parent = &ck_ref,
-    .flags = CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX,
+    .name = "dsptim_ck",
+    .parent = &ck_ref,
+    .flags = CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX,
 };

 static struct clk tc_ck = {
-    .name = "tc_ck",
-    .parent = &clkm3,
-    .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
+    .name = "tc_ck",
+    .parent = &clkm3,
+    .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
             CLOCK_IN_OMAP730 | CLOCK_IN_OMAP310 |
             ALWAYS_ENABLED,
 };

 static struct clk arminth_ck15xx = {
-    .name = "arminth_ck",
-    .parent = &tc_ck,
-    .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 | ALWAYS_ENABLED,
+    .name = "arminth_ck",
+    .parent = &tc_ck,
+    .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 | ALWAYS_ENABLED,
     /* Note: On 1510 the frequency follows TC_CK
      *
      * 16xx version is in MPU clocks.
@@ -256,606 +256,606 @@ static struct clk arminth_ck15xx = {

 static struct clk tipb_ck = {
     /* No-idle controlled by "tc_ck" */
-    .name = "tipb_ck",
-    .parent = &tc_ck,
-    .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 | ALWAYS_ENABLED,
+    .name = "tipb_ck",
+    .parent = &tc_ck,
+    .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 | ALWAYS_ENABLED,
 };

 static struct clk l3_ocpi_ck = {
     /* No-idle controlled by "tc_ck" */
-    .name = "l3_ocpi_ck",
-    .parent = &tc_ck,
-    .flags = CLOCK_IN_OMAP16XX,
+    .name = "l3_ocpi_ck",
+    .parent = &tc_ck,
+    .flags = CLOCK_IN_OMAP16XX,
 };

 static struct clk tc1_ck = {
-    .name = "tc1_ck",
-    .parent = &tc_ck,
-    .flags = CLOCK_IN_OMAP16XX,
+    .name = "tc1_ck",
+    .parent = &tc_ck,
+    .flags = CLOCK_IN_OMAP16XX,
 };

 static struct clk tc2_ck = {
-    .name = "tc2_ck",
-    .parent = &tc_ck,
-    .flags = CLOCK_IN_OMAP16XX,
+    .name = "tc2_ck",
+    .parent = &tc_ck,
+    .flags = CLOCK_IN_OMAP16XX,
 };

 static struct clk dma_ck = {
     /* No-idle controlled by "tc_ck" */
-    .name = "dma_ck",
-    .parent = &tc_ck,
-    .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310 |
+    .name = "dma_ck",
+    .parent = &tc_ck,
+    .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310 |
             ALWAYS_ENABLED,
 };

 static struct clk dma_lcdfree_ck = {
-    .name = "dma_lcdfree_ck",
-    .parent = &tc_ck,
-    .flags = CLOCK_IN_OMAP16XX | ALWAYS_ENABLED,
+    .name = "dma_lcdfree_ck",
+    .parent = &tc_ck,
+    .flags = CLOCK_IN_OMAP16XX | ALWAYS_ENABLED,
 };

 static struct clk api_ck = {
-    .name = "api_ck",
-    .alias = "mpui_ck",
-    .parent = &tc_ck,
-    .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310,
+    .name = "api_ck",
+    .alias = "mpui_ck",
+    .parent = &tc_ck,
+    .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310,
 };

 static struct clk lb_ck = {
-    .name = "lb_ck",
-    .parent = &tc_ck,
-    .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310,
+    .name = "lb_ck",
+    .parent = &tc_ck,
+    .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310,
 };

 static struct clk lbfree_ck = {
-    .name = "lbfree_ck",
-    .parent = &tc_ck,
-    .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310,
+    .name = "lbfree_ck",
+    .parent = &tc_ck,
+    .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310,
 };

 static struct clk hsab_ck = {
-    .name = "hsab_ck",
-    .parent = &tc_ck,
-    .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310,
+    .name = "hsab_ck",
+    .parent = &tc_ck,
+    .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310,
 };

 static struct clk rhea1_ck = {
-    .name = "rhea1_ck",
-    .parent = &tc_ck,
-    .flags = CLOCK_IN_OMAP16XX | ALWAYS_ENABLED,
+    .name = "rhea1_ck",
+    .parent = &tc_ck,
+    .flags = CLOCK_IN_OMAP16XX | ALWAYS_ENABLED,
 };

 static struct clk rhea2_ck = {
-    .name = "rhea2_ck",
-    .parent = &tc_ck,
-    .flags = CLOCK_IN_OMAP16XX | ALWAYS_ENABLED,
+    .name = "rhea2_ck",
+    .parent = &tc_ck,
+    .flags = CLOCK_IN_OMAP16XX | ALWAYS_ENABLED,
 };

 static struct clk lcd_ck_16xx = {
-    .name = "lcd_ck",
-    .parent = &clkm3,
-    .flags = CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP730,
+    .name = "lcd_ck",
+    .parent = &clkm3,
+    .flags = CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP730,
 };

 static struct clk lcd_ck_1510 = {
-    .name = "lcd_ck",
-    .parent = &clkm3,
-    .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310,
+    .name = "lcd_ck",
+    .parent = &clkm3,
+    .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310,
 };

 static struct clk uart1_1510 = {
-    .name = "uart1_ck",
+    .name = "uart1_ck",
     /* Direct from ULPD, no real parent */
-    .parent = &armper_ck, /* either armper_ck or dpll4 */
-    .rate = 12000000,
-    .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 | ALWAYS_ENABLED,
+    .parent = &armper_ck, /*g either armper_ck or dpll4 */
+    .rate = 12000000,
+    .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 | ALWAYS_ENABLED,
 };

 static struct clk uart1_16xx = {
-    .name = "uart1_ck",
+    .name = "uart1_ck",
     /* Direct from ULPD, no real parent */
-    .parent = &armper_ck,
-    .rate = 48000000,
-    .flags = CLOCK_IN_OMAP16XX,
+    .parent = &armper_ck,
+    .rate = 48000000,
+    .flags = CLOCK_IN_OMAP16XX,
 };

 static struct clk uart2_ck = {
-    .name = "uart2_ck",
+    .name = "uart2_ck",
     /* Direct from ULPD, no real parent */
-    .parent = &armper_ck, /* either armper_ck or dpll4 */
-    .rate = 12000000,
-    .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310 |
+    .parent = &armper_ck, /*g either armper_ck or dpll4 */
+    .rate = 12000000,
+    .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310 |
             ALWAYS_ENABLED,
 };

 static struct clk uart3_1510 = {
-    .name = "uart3_ck",
+    .name = "uart3_ck",
     /* Direct from ULPD, no real parent */
-    .parent = &armper_ck, /* either armper_ck or dpll4 */
-    .rate = 12000000,
-    .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 | ALWAYS_ENABLED,
+    .parent = &armper_ck, /*g either armper_ck or dpll4 */
+    .rate = 12000000,
+    .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 | ALWAYS_ENABLED,
 };

 static struct clk uart3_16xx = {
-    .name = "uart3_ck",
+    .name = "uart3_ck",
     /* Direct from ULPD, no real parent */
-    .parent = &armper_ck,
-    .rate = 48000000,
-    .flags = CLOCK_IN_OMAP16XX,
+    .parent = &armper_ck,
+    .rate = 48000000,
+    .flags = CLOCK_IN_OMAP16XX,
 };

-static struct clk usb_clk0 = { /* 6 MHz output on W4_USB_CLK0 */
-    .name = "usb_clk0",
-    .alias = "usb.clko",
+static struct clk usb_clk0 = { /*g 6 MHz output on W4_USB_CLK0 */
+    .name = "usb_clk0",
+    .alias = "usb.clko",
     /* Direct from ULPD, no parent */
-    .rate = 6000000,
-    .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310,
+    .rate = 6000000,
+    .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310,
 };

 static struct clk usb_hhc_ck1510 = {
-    .name = "usb_hhc_ck",
+    .name = "usb_hhc_ck",
     /* Direct from ULPD, no parent */
-    .rate = 48000000, /* Actually 2 clocks, 12MHz and 48MHz */
-    .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310,
+    .rate = 48000000, /* Actually 2 clocks, 12MHz and 48MHz */
+    .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310,
 };

 static struct clk usb_hhc_ck16xx = {
-    .name = "usb_hhc_ck",
+    .name = "usb_hhc_ck",
     /* Direct from ULPD, no parent */
-    .rate = 48000000,
+    .rate = 48000000,
     /* OTG_SYSCON_2.OTG_PADEN == 0 (not 1510-compatible) */
-    .flags = CLOCK_IN_OMAP16XX,
+    .flags = CLOCK_IN_OMAP16XX,
 };

 static struct clk usb_w2fc_mclk = {
-    .name = "usb_w2fc_mclk",
-    .alias = "usb_w2fc_ck",
-    .parent = &ck_48m,
-    .rate = 48000000,
-    .flags = CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX,
+    .name = "usb_w2fc_mclk",
+    .alias = "usb_w2fc_ck",
+    .parent = &ck_48m,
+    .rate = 48000000,
+    .flags = CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX,
 };

 static struct clk mclk_1510 = {
-    .name = "mclk",
+    .name = "mclk",
     /* Direct from ULPD, no parent. May be enabled by ext hardware. */
-    .rate = 12000000,
-    .flags = CLOCK_IN_OMAP1510,
+    .rate = 12000000,
+    .flags = CLOCK_IN_OMAP1510,
 };

 static struct clk bclk_310 = {
-    .name = "bt_mclk_out", /* Alias midi_mclk_out? */
-    .parent = &armper_ck,
-    .flags = CLOCK_IN_OMAP310,
+    .name = "bt_mclk_out", /*g Alias midi_mclk_out? */
+    .parent = &armper_ck,
+    .flags = CLOCK_IN_OMAP310,
 };

 static struct clk mclk_310 = {
-    .name = "com_mclk_out",
-    .parent = &armper_ck,
-    .flags = CLOCK_IN_OMAP310,
+    .name = "com_mclk_out",
+    .parent = &armper_ck,
+    .flags = CLOCK_IN_OMAP310,
 };

 static struct clk mclk_16xx = {
-    .name = "mclk",
+    .name = "mclk",
     /* Direct from ULPD, no parent. May be enabled by ext hardware. */
-    .flags = CLOCK_IN_OMAP16XX,
+    .flags = CLOCK_IN_OMAP16XX,
 };

 static struct clk bclk_1510 = {
-    .name = "bclk",
+    .name = "bclk",
     /* Direct from ULPD, no parent. May be enabled by ext hardware. */
-    .rate = 12000000,
-    .flags = CLOCK_IN_OMAP1510,
+    .rate = 12000000,
+    .flags = CLOCK_IN_OMAP1510,
 };

 static struct clk bclk_16xx = {
-    .name = "bclk",
+    .name = "bclk",
     /* Direct from ULPD, no parent. May be enabled by ext hardware. */
-    .flags = CLOCK_IN_OMAP16XX,
+    .flags = CLOCK_IN_OMAP16XX,
 };

 static struct clk mmc1_ck = {
-    .name = "mmc_ck",
-    .id = 1,
+    .name = "mmc_ck",
+    .id  = 1,
     /* Functional clock is direct from ULPD, interface clock is ARMPER */
-    .parent = &armper_ck, /* either armper_ck or dpll4 */
-    .rate = 48000000,
-    .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310,
+    .parent = &armper_ck, /*g either armper_ck or dpll4 */
+    .rate = 48000000,
+    .flags = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310,
 };

 static struct clk mmc2_ck = {
-    .name = "mmc_ck",
-    .id = 2,
+    .name = "mmc_ck",
+    .id  = 2,
     /* Functional clock is direct from ULPD, interface clock is ARMPER */
-    .parent = &armper_ck,
-    .rate = 48000000,
-    .flags = CLOCK_IN_OMAP16XX,
+    .parent = &armper_ck,
+    .rate = 48000000,
+    .flags = CLOCK_IN_OMAP16XX,
 };

 static struct clk cam_mclk = {
-    .name = "cam.mclk",
-    .flags = CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX,
-    .rate = 12000000,
+    .name = "cam.mclk",
+    .flags = CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX,
+    .rate = 12000000,
 };

 static struct clk cam_exclk = {
-    .name = "cam.exclk",
-    .flags = CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX,
+    .name = "cam.exclk",
+    .flags = CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX,
     /* Either 12M from cam.mclk or 48M from dpll4 */
-    .parent = &cam_mclk,
+    .parent = &cam_mclk,
 };

 static struct clk cam_lclk = {
-    .name = "cam.lclk",
-    .flags = CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX,
+    .name = "cam.lclk",
+    .flags = CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX,
 };

 static struct clk i2c_fck = {
-    .name = "i2c_fck",
-    .id = 1,
-    .flags = CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
+    .name = "i2c_fck",
+    .id  = 1,
+    .flags = CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
             ALWAYS_ENABLED,
-    .parent = &armxor_ck,
+    .parent = &armxor_ck,
 };

 static struct clk i2c_ick = {
-    .name = "i2c_ick",
-    .id = 1,
-    .flags = CLOCK_IN_OMAP16XX | ALWAYS_ENABLED,
-    .parent = &armper_ck,
+    .name = "i2c_ick",
+    .id  = 1,
+    .flags = CLOCK_IN_OMAP16XX | ALWAYS_ENABLED,
+    .parent = &armper_ck,
 };

 static struct clk clk32k = {
-    .name = "clk32-kHz",
-    .flags = CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
+    .name = "clk32-kHz",
+    .flags = CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
             CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | ALWAYS_ENABLED,
-    .parent = &xtal_osc32k,
+    .parent = &xtal_osc32k,
 };

 static struct clk ref_clk = {
-    .name = "ref_clk",
-    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | ALWAYS_ENABLED,
-    .rate = 12000000, /* 12 MHz or 13 MHz or 19.2 MHz */
-    /*.parent = sys.xtalin */
+    .name = "ref_clk",
+    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | ALWAYS_ENABLED,
+    .rate = 12000000, /*g 12 MHz or 13 MHz or 19.2 MHz */
+    /*.parent = sys.xtalin */
 };

 static struct clk apll_96m = {
-    .name = "apll_96m",
-    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | ALWAYS_ENABLED,
-    .rate = 96000000,
-    /*.parent = ref_clk */
+    .name = "apll_96m",
+    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | ALWAYS_ENABLED,
+    .rate = 96000000,
+    /*.parent = ref_clk */
 };

 static struct clk apll_54m = {
-    .name = "apll_54m",
-    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | ALWAYS_ENABLED,
-    .rate = 54000000,
-    /*.parent = ref_clk */
+    .name = "apll_54m",
+    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | ALWAYS_ENABLED,
+    .rate = 54000000,
+    /*.parent = ref_clk */
 };

 static struct clk sys_clk = {
-    .name = "sys_clk",
-    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | ALWAYS_ENABLED,
-    .rate = 32768,
-    /*.parent = sys.xtalin */
+    .name = "sys_clk",
+    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | ALWAYS_ENABLED,
+    .rate = 32768,
+    /*.parent = sys.xtalin */
 };

 static struct clk sleep_clk = {
-    .name = "sleep_clk",
-    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | ALWAYS_ENABLED,
-    .rate = 32768,
-    /*.parent = sys.xtalin */
+    .name = "sleep_clk",
+    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | ALWAYS_ENABLED,
+    .rate = 32768,
+    /*.parent = sys.xtalin */
 };

 static struct clk dpll_ck = {
-    .name = "dpll",
-    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | ALWAYS_ENABLED,
-    .parent = &ref_clk,
+    .name = "dpll",
+    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | ALWAYS_ENABLED,
+    .parent = &ref_clk,
 };

 static struct clk dpll_x2_ck = {
-    .name = "dpll_x2",
-    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | ALWAYS_ENABLED,
-    .parent = &ref_clk,
+    .name = "dpll_x2",
+    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | ALWAYS_ENABLED,
+    .parent = &ref_clk,
 };

 static struct clk wdt1_sys_clk = {
-    .name = "wdt1_sys_clk",
-    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | ALWAYS_ENABLED,
-    .rate = 32768,
-    /*.parent = sys.xtalin */
+    .name = "wdt1_sys_clk",
+    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | ALWAYS_ENABLED,
+    .rate = 32768,
+    /*.parent = sys.xtalin */
 };

 static struct clk func_96m_clk = {
-    .name = "func_96m_clk",
-    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .divisor = 1,
-    .parent = &apll_96m,
+    .name = "func_96m_clk",
+    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+    .divisor = 1,
+    .parent = &apll_96m,
 };

 static struct clk func_48m_clk = {
-    .name = "func_48m_clk",
-    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .divisor = 2,
-    .parent = &apll_96m,
+    .name = "func_48m_clk",
+    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+    .divisor = 2,
+    .parent = &apll_96m,
 };

 static struct clk func_12m_clk = {
-    .name = "func_12m_clk",
-    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .divisor = 8,
-    .parent = &apll_96m,
+    .name = "func_12m_clk",
+    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+    .divisor = 8,
+    .parent = &apll_96m,
 };

 static struct clk func_54m_clk = {
-    .name = "func_54m_clk",
-    .flags = CLOCK_IN_OMAP242X,
-    .divisor = 1,
-    .parent = &apll_54m,
+    .name = "func_54m_clk",
+    .flags = CLOCK_IN_OMAP242X,
+    .divisor = 1,
+    .parent = &apll_54m,
 };

 static struct clk sys_clkout = {
-    .name = "clkout",
-    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent = &sys_clk,
+    .name = "clkout",
+    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+    .parent = &sys_clk,
 };

 static struct clk sys_clkout2 = {
-    .name = "clkout2",
-    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent = &sys_clk,
+    .name = "clkout2",
+    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+    .parent = &sys_clk,
 };

 static struct clk core_clk = {
-    .name = "core_clk",
-    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent = &dpll_x2_ck, /* Switchable between dpll_ck and clk32k */
+    .name = "core_clk",
+    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+    .parent = &dpll_x2_ck, /*g Switchable between dpll_ck and clk32k */
 };

 static struct clk l3_clk = {
-    .name = "l3_clk",
-    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent = &core_clk,
+    .name = "l3_clk",
+    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+    .parent = &core_clk,
 };

 static struct clk core_l4_iclk = {
-    .name = "core_l4_iclk",
-    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent = &l3_clk,
+    .name = "core_l4_iclk",
+    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+    .parent = &l3_clk,
 };

 static struct clk wu_l4_iclk = {
-    .name = "wu_l4_iclk",
-    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent = &l3_clk,
+    .name = "wu_l4_iclk",
+    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+    .parent = &l3_clk,
 };

 static struct clk core_l3_iclk = {
-    .name = "core_l3_iclk",
-    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent = &core_clk,
+    .name = "core_l3_iclk",
+    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+    .parent = &core_clk,
 };

 static struct clk core_l4_usb_clk = {
-    .name = "core_l4_usb_clk",
-    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent = &l3_clk,
+    .name = "core_l4_usb_clk",
+    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+    .parent = &l3_clk,
 };

 static struct clk wu_gpt1_clk = {
-    .name = "wu_gpt1_clk",
-    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent = &sys_clk,
+    .name = "wu_gpt1_clk",
+    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+    .parent = &sys_clk,
 };

 static struct clk wu_32k_clk = {
-    .name = "wu_32k_clk",
-    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent = &sys_clk,
+    .name = "wu_32k_clk",
+    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+    .parent = &sys_clk,
 };

 static struct clk uart1_fclk = {
-    .name = "uart1_fclk",
-    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent = &func_48m_clk,
+    .name = "uart1_fclk",
+    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+    .parent = &func_48m_clk,
 };

 static struct clk uart1_iclk = {
-    .name = "uart1_iclk",
-    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent = &core_l4_iclk,
+    .name = "uart1_iclk",
+    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+    .parent = &core_l4_iclk,
 };

 static struct clk uart2_fclk = {
-    .name = "uart2_fclk",
-    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent = &func_48m_clk,
+    .name = "uart2_fclk",
+    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+    .parent = &func_48m_clk,
 };

 static struct clk uart2_iclk = {
-    .name = "uart2_iclk",
-    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent = &core_l4_iclk,
+    .name = "uart2_iclk",
+    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+    .parent = &core_l4_iclk,
 };

 static struct clk uart3_fclk = {
-    .name = "uart3_fclk",
-    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent = &func_48m_clk,
+    .name = "uart3_fclk",
+    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+    .parent = &func_48m_clk,
 };

 static struct clk uart3_iclk = {
-    .name = "uart3_iclk",
-    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent = &core_l4_iclk,
+    .name = "uart3_iclk",
+    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+    .parent = &core_l4_iclk,
 };

 static struct clk mpu_fclk = {
-    .name = "mpu_fclk",
-    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent = &core_clk,
+    .name = "mpu_fclk",
+    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+    .parent = &core_clk,
 };

 static struct clk mpu_iclk = {
-    .name = "mpu_iclk",
-    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent = &core_clk,
+    .name = "mpu_iclk",
+    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+    .parent = &core_clk,
 };

 static struct clk int_m_fclk = {
-    .name = "int_m_fclk",
-    .alias = "mpu_intc_fclk",
-    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent = &core_clk,
+    .name = "int_m_fclk",
+    .alias = "mpu_intc_fclk",
+    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+    .parent = &core_clk,
 };

 static struct clk int_m_iclk = {
-    .name = "int_m_iclk",
-    .alias = "mpu_intc_iclk",
-    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent = &core_clk,
+    .name = "int_m_iclk",
+    .alias = "mpu_intc_iclk",
+    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+    .parent = &core_clk,
 };

 static struct clk core_gpt2_clk = {
-    .name = "core_gpt2_clk",
-    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent = &sys_clk,
+    .name = "core_gpt2_clk",
+    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+    .parent = &sys_clk,
 };

 static struct clk core_gpt3_clk = {
-    .name = "core_gpt3_clk",
-    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent = &sys_clk,
+    .name = "core_gpt3_clk",
+    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+    .parent = &sys_clk,
 };

 static struct clk core_gpt4_clk = {
-    .name = "core_gpt4_clk",
-    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent = &sys_clk,
+    .name = "core_gpt4_clk",
+    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+    .parent = &sys_clk,
 };

 static struct clk core_gpt5_clk = {
-    .name = "core_gpt5_clk",
-    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent = &sys_clk,
+    .name = "core_gpt5_clk",
+    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+    .parent = &sys_clk,
 };

 static struct clk core_gpt6_clk = {
-    .name = "core_gpt6_clk",
-    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent = &sys_clk,
+    .name = "core_gpt6_clk",
+    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+    .parent = &sys_clk,
 };

 static struct clk core_gpt7_clk = {
-    .name = "core_gpt7_clk",
-    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent = &sys_clk,
+    .name = "core_gpt7_clk",
+    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+    .parent = &sys_clk,
 };

 static struct clk core_gpt8_clk = {
-    .name = "core_gpt8_clk",
-    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent = &sys_clk,
+    .name = "core_gpt8_clk",
+    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+    .parent = &sys_clk,
 };

 static struct clk core_gpt9_clk = {
-    .name = "core_gpt9_clk",
-    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent = &sys_clk,
+    .name = "core_gpt9_clk",
+    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+    .parent = &sys_clk,
 };

 static struct clk core_gpt10_clk = {
-    .name = "core_gpt10_clk",
-    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent = &sys_clk,
+    .name = "core_gpt10_clk",
+    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+    .parent = &sys_clk,
 };

 static struct clk core_gpt11_clk = {
-    .name = "core_gpt11_clk",
-    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent = &sys_clk,
+    .name = "core_gpt11_clk",
+    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+    .parent = &sys_clk,
 };

 static struct clk core_gpt12_clk = {
-    .name = "core_gpt12_clk",
-    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent = &sys_clk,
+    .name = "core_gpt12_clk",
+    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+    .parent = &sys_clk,
 };

 static struct clk mcbsp1_clk = {
-    .name = "mcbsp1_cg",
-    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .divisor = 2,
-    .parent = &func_96m_clk,
+    .name = "mcbsp1_cg",
+    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+    .divisor = 2,
+    .parent = &func_96m_clk,
 };

 static struct clk mcbsp2_clk = {
-    .name = "mcbsp2_cg",
-    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .divisor = 2,
-    .parent = &func_96m_clk,
+    .name = "mcbsp2_cg",
+    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+    .divisor = 2,
+    .parent = &func_96m_clk,
 };

 static struct clk emul_clk = {
-    .name = "emul_ck",
-    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent = &func_54m_clk,
+    .name = "emul_ck",
+    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+    .parent = &func_54m_clk,
 };

 static struct clk sdma_fclk = {
-    .name = "sdma_fclk",
-    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent = &l3_clk,
+    .name = "sdma_fclk",
+    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+    .parent = &l3_clk,
 };

 static struct clk sdma_iclk = {
-    .name = "sdma_iclk",
-    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent = &core_l3_iclk, /* core_l4_iclk for the configuration port */
+    .name = "sdma_iclk",
+    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+    .parent = &core_l3_iclk, /* core_l4_iclk for the configuration port */
 };

 static struct clk i2c1_fclk = {
-    .name = "i2c1.fclk",
-    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent = &func_12m_clk,
-    .divisor = 1,
+    .name = "i2c1.fclk",
+    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+    .parent = &func_12m_clk,
+    .divisor = 1,
 };

 static struct clk i2c1_iclk = {
-    .name = "i2c1.iclk",
-    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent = &core_l4_iclk,
+    .name = "i2c1.iclk",
+    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+    .parent = &core_l4_iclk,
 };

 static struct clk i2c2_fclk = {
-    .name = "i2c2.fclk",
-    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent = &func_12m_clk,
-    .divisor = 1,
+    .name = "i2c2.fclk",
+    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+    .parent = &func_12m_clk,
+    .divisor = 1,
 };

 static struct clk i2c2_iclk = {
-    .name = "i2c2.iclk",
-    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent = &core_l4_iclk,
+    .name = "i2c2.iclk",
+    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+    .parent = &core_l4_iclk,
 };

 static struct clk gpio_dbclk[5] = {
     {
-        .name = "gpio1_dbclk",
-        .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-        .parent = &wu_32k_clk,
+        .name = "gpio1_dbclk",
+        .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+        .parent = &wu_32k_clk,
     }, {
-        .name = "gpio2_dbclk",
-        .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-        .parent = &wu_32k_clk,
+        .name = "gpio2_dbclk",
+        .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+        .parent = &wu_32k_clk,
     }, {
-        .name = "gpio3_dbclk",
-        .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-        .parent = &wu_32k_clk,
+        .name = "gpio3_dbclk",
+        .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+        .parent = &wu_32k_clk,
     }, {
-        .name = "gpio4_dbclk",
-        .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-        .parent = &wu_32k_clk,
+        .name = "gpio4_dbclk",
+        .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+        .parent = &wu_32k_clk,
     }, {
         .name   = "gpio5_dbclk",
         .flags  = CLOCK_IN_OMAP243X,
@@ -864,90 +864,90 @@ static struct clk gpio_dbclk[5] = {
 };

 static struct clk gpio_iclk = {
-    .name = "gpio_iclk",
-    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent = &wu_l4_iclk,
+    .name = "gpio_iclk",
+    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+    .parent = &wu_l4_iclk,
 };

 static struct clk mmc_fck = {
-    .name = "mmc_fclk",
-    .flags = CLOCK_IN_OMAP242X,
-    .parent = &func_96m_clk,
+    .name = "mmc_fclk",
+    .flags = CLOCK_IN_OMAP242X,
+    .parent = &func_96m_clk,
 };

 static struct clk mmc_ick = {
-    .name = "mmc_iclk",
-    .flags = CLOCK_IN_OMAP242X,
-    .parent = &core_l4_iclk,
+    .name = "mmc_iclk",
+    .flags = CLOCK_IN_OMAP242X,
+    .parent = &core_l4_iclk,
 };

 static struct clk spi_fclk[3] = {
     {
-        .name = "spi1_fclk",
-        .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-        .parent = &func_48m_clk,
+        .name = "spi1_fclk",
+        .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+        .parent = &func_48m_clk,
     }, {
-        .name = "spi2_fclk",
-        .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-        .parent = &func_48m_clk,
+        .name = "spi2_fclk",
+        .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+        .parent = &func_48m_clk,
     }, {
-        .name = "spi3_fclk",
-        .flags = CLOCK_IN_OMAP243X,
-        .parent = &func_48m_clk,
+        .name = "spi3_fclk",
+        .flags = CLOCK_IN_OMAP243X,
+        .parent = &func_48m_clk,
     },
 };

 static struct clk dss_clk[2] = {
     {
-        .name = "dss_clk1",
-        .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-        .parent = &core_clk,
+        .name = "dss_clk1",
+        .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+        .parent = &core_clk,
     }, {
-        .name = "dss_clk2",
-        .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-        .parent = &sys_clk,
+        .name = "dss_clk2",
+        .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+        .parent = &sys_clk,
     },
 };

 static struct clk dss_54m_clk = {
-    .name = "dss_54m_clk",
-    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent = &func_54m_clk,
+    .name = "dss_54m_clk",
+    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+    .parent = &func_54m_clk,
 };

 static struct clk dss_l3_iclk = {
-    .name = "dss_l3_iclk",
-    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent = &core_l3_iclk,
+    .name = "dss_l3_iclk",
+    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+    .parent = &core_l3_iclk,
 };

 static struct clk dss_l4_iclk = {
-    .name = "dss_l4_iclk",
-    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-    .parent = &core_l4_iclk,
+    .name = "dss_l4_iclk",
+    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+    .parent = &core_l4_iclk,
 };

 static struct clk spi_iclk[3] = {
     {
-        .name = "spi1_iclk",
-        .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-        .parent = &core_l4_iclk,
+        .name = "spi1_iclk",
+        .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+        .parent = &core_l4_iclk,
     }, {
-        .name = "spi2_iclk",
-        .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-        .parent = &core_l4_iclk,
+        .name = "spi2_iclk",
+        .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+        .parent = &core_l4_iclk,
     }, {
-        .name = "spi3_iclk",
-        .flags = CLOCK_IN_OMAP243X,
-        .parent = &core_l4_iclk,
+        .name = "spi3_iclk",
+        .flags = CLOCK_IN_OMAP243X,
+        .parent = &core_l4_iclk,
     },
 };

 static struct clk omapctrl_clk = {
-    .name = "omapctrl_iclk",
-    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+    .name = "omapctrl_iclk",
+    .flags = CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
     /* XXX Should be in WKUP domain */
-    .parent = &core_l4_iclk,
+    .parent = &core_l4_iclk,
 };

 static struct clk *onchip_clks[] = {
@@ -1100,7 +1100,9 @@ void omap_clk_adduser(struct clk *clk, qemu_irq user)
 {
     qemu_irq *i;

-    for (i = clk->users; *i; i ++);
+    for (i = clk->users; *i; i++) {
+        ;
+    }
     *i = user;
 }

@@ -1108,21 +1110,23 @@ struct clk *omap_findclk(struct omap_mpu_state_s
*mpu, const char *name)
 {
     struct clk *i;

-    for (i = mpu->clks; i->name; i ++)
-        if (!strcmp(i->name, name) || (i->alias && !strcmp(i->alias,
name)))
+    for (i = mpu->clks; i->name; i++)
+        if (!strcmp(i->name, name) || (i->alias && !strcmp(i->alias,
name))) {
             return i;
+        }
     hw_error("%s: %s not found\n", __func__, name);
 }

 void omap_clk_get(struct clk *clk)
 {
-    clk->usecount ++;
+    clk->usecount++;
 }

 void omap_clk_put(struct clk *clk)
 {
-    if (!(clk->usecount --))
+    if (!(clk->usecount--)) {
         hw_error("%s: %s is not in use\n", __func__, clk->name);
+    }
 }

 static void omap_clk_update(struct clk *clk)
@@ -1131,19 +1135,22 @@ static void omap_clk_update(struct clk *clk)
     qemu_irq *user;
     struct clk *i;

-    if (clk->parent)
+    if (clk->parent) {
         parent = clk->parent->running;
-    else
+    } else {
         parent = 1;
+    }

     running = parent && (clk->enabled ||
                     ((clk->flags & ALWAYS_ENABLED) && clk->usecount));
     if (clk->running != running) {
         clk->running = running;
-        for (user = clk->users; *user; user ++)
+        for (user = clk->users; *user; user++) {
             qemu_set_irq(*user, running);
-        for (i = clk->child1; i; i = i->sibling)
+        }
+        for (i = clk->child1; i; i = i->sibling) {
             omap_clk_update(i);
+        }
     }
 }

@@ -1155,8 +1162,9 @@ static void omap_clk_rate_update_full(struct clk
*clk, unsigned long int rate,

     clk->rate = muldiv64(rate, mult, div);
     if (clk->running)
-        for (user = clk->users; *user; user ++)
+        for (user = clk->users; *user; user++) {
             qemu_irq_raise(*user);
+        }
     for (i = clk->child1; i; i = i->sibling)
         omap_clk_rate_update_full(i, rate,
                         div * i->divisor, mult * i->multiplier);
@@ -1180,7 +1188,9 @@ void omap_clk_reparent(struct clk *clk, struct clk
*parent)
     struct clk **p;

     if (clk->parent) {
-        for (p = &clk->parent->child1; *p != clk; p = &(*p)->sibling);
+        for (p = &clk->parent->child1; *p != clk; p = &(*p)->sibling) {
+            ;
+        }
         *p = clk->sibling;
     }

@@ -1202,10 +1212,11 @@ void omap_clk_onoff(struct clk *clk, int on)

 void omap_clk_canidle(struct clk *clk, int can)
 {
-    if (can)
+    if (can) {
         omap_clk_put(clk);
-    else
+    } else {
         omap_clk_get(clk);
+    }
 }

 void omap_clk_setrate(struct clk *clk, int divide, int multiply)
@@ -1226,27 +1237,29 @@ void omap_clk_init(struct omap_mpu_state_s *mpu)
     int count;
     int flag;

-    if (cpu_is_omap310(mpu))
+    if (cpu_is_omap310(mpu)) {
         flag = CLOCK_IN_OMAP310;
-    else if (cpu_is_omap1510(mpu))
+    } else if (cpu_is_omap1510(mpu)) {
         flag = CLOCK_IN_OMAP1510;
-    else if (cpu_is_omap2410(mpu) || cpu_is_omap2420(mpu))
+    } else if (cpu_is_omap2410(mpu) || cpu_is_omap2420(mpu)) {
         flag = CLOCK_IN_OMAP242X;
-    else if (cpu_is_omap2430(mpu))
+    } else if (cpu_is_omap2430(mpu)) {
         flag = CLOCK_IN_OMAP243X;
-    else if (cpu_is_omap3430(mpu))
+    } else if (cpu_is_omap3430(mpu)) {
         flag = CLOCK_IN_OMAP243X;
-    else
+    } else {
         return;
+    }

-    for (i = onchip_clks, count = 0; *i; i ++)
-        if ((*i)->flags & flag)
-            count ++;
+    for (i = onchip_clks, count = 0; *i; i++)
+        if ((*i)->flags & flag) {
+            count++;
+        }
     mpu->clks = g_new0(struct clk, count + 1);
-    for (i = onchip_clks, j = mpu->clks; *i; i ++)
+    for (i = onchip_clks, j = mpu->clks; *i; i++)
         if ((*i)->flags & flag) {
             memcpy(j, *i, sizeof(struct clk));
-            for (k = mpu->clks; k < j; k ++)
+            for (k = mpu->clks; k < j; k++)
                 if (j->parent && !strcmp(j->parent->name, k->name)) {
                     j->parent = k;
                     j->sibling = k->child1;
@@ -1258,9 +1271,9 @@ void omap_clk_init(struct omap_mpu_state_s *mpu)
                 }
             j->divisor = j->divisor ?: 1;
             j->multiplier = j->multiplier ?: 1;
-            j ++;
+            j++;
         }
-    for (j = mpu->clks; count --; j ++) {
+    for (j = mpu->clks; count--; j++) {
         omap_clk_update(j);
         omap_clk_rate_update(j);
     }
diff --git a/hw/misc/omap_l4.c b/hw/misc/omap_l4.c
index b7875489da..e0f5cea921 100644
--- a/hw/misc/omap_l4.c
+++ b/hw/misc/omap_l4.c
@@ -61,13 +61,13 @@ static uint64_t omap_l4ta_read(void *opaque, hwaddr
addr, unsigned size)
     }

     switch (addr) {
-    case 0x00: /* COMPONENT */
+    case 0x00:  /* COMPONENT */
         return s->component;

-    case 0x20: /* AGENT_CONTROL */
+    case 0x20:  /* AGENT_CONTROL */
         return s->control;

-    case 0x28: /* AGENT_STATUS */
+    case 0x28:  /* AGENT_STATUS */
         return s->status;
     }

@@ -86,15 +86,16 @@ static void omap_l4ta_write(void *opaque, hwaddr addr,
     }

     switch (addr) {
-    case 0x00: /* COMPONENT */
-    case 0x28: /* AGENT_STATUS */
+    case 0x00:  /* COMPONENT */
+    case 0x28:  /* AGENT_STATUS */
         OMAP_RO_REG(addr);
         break;

-    case 0x20: /* AGENT_CONTROL */
+    case 0x20:  /* AGENT_CONTROL */
         s->control = value & 0x01000700;
-        if (value & 1) /* OCP_RESET */
-            s->status &= ~1; /* REQ_TIMEOUT */
+        if (value & 1) {        /* OCP_RESET */
+            s->status &= ~1;        /* REQ_TIMEOUT */
+        }
         break;

     default:
@@ -117,7 +118,7 @@ struct omap_target_agent_s *omap_l4ta_get(struct
omap_l4_s *bus,
     struct omap_target_agent_s *ta = NULL;
     const struct omap_l4_agent_info_s *info = NULL;

-    for (i = 0; i < bus->ta_num; i ++)
+    for (i = 0; i < bus->ta_num; i++)
         if (agents[i].ta == cs) {
             ta = &bus->ta[i];
             info = &agents[i];
@@ -134,7 +135,7 @@ struct omap_target_agent_s *omap_l4ta_get(struct
omap_l4_s *bus,

     ta->component = ('Q' << 24) | ('E' << 16) | ('M' << 8) | ('U' << 0);
     ta->status = 0x00000000;
-    ta->control = 0x00000200; /* XXX 01000200 for L4TAO */
+    ta->control = 0x00000200; /* XXX 01000200 for L4TAO */

     memory_region_init_io(&ta->iomem, NULL, &omap_l4ta_ops, ta,
"omap.l4ta",
                           omap_l4_region_size(ta, info->ta_region));
diff --git a/hw/misc/omap_sdrc.c b/hw/misc/omap_sdrc.c
index 6aa1b3ef7f..21d3ca8683 100644
--- a/hw/misc/omap_sdrc.c
+++ b/hw/misc/omap_sdrc.c
@@ -40,44 +40,44 @@ static uint64_t omap_sdrc_read(void *opaque, hwaddr
addr, unsigned size)
     }

     switch (addr) {
-    case 0x00: /* SDRC_REVISION */
+    case 0x00:  /* SDRC_REVISION */
         return 0x20;

-    case 0x10: /* SDRC_SYSCONFIG */
+    case 0x10:  /* SDRC_SYSCONFIG */
         return s->config;

-    case 0x14: /* SDRC_SYSSTATUS */
-        return 1; /* RESETDONE */
-
-    case 0x40: /* SDRC_CS_CFG */
-    case 0x44: /* SDRC_SHARING */
-    case 0x48: /* SDRC_ERR_ADDR */
-    case 0x4c: /* SDRC_ERR_TYPE */
-    case 0x60: /* SDRC_DLLA_SCTRL */
-    case 0x64: /* SDRC_DLLA_STATUS */
-    case 0x68: /* SDRC_DLLB_CTRL */
-    case 0x6c: /* SDRC_DLLB_STATUS */
-    case 0x70: /* SDRC_POWER */
-    case 0x80: /* SDRC_MCFG_0 */
-    case 0x84: /* SDRC_MR_0 */
-    case 0x88: /* SDRC_EMR1_0 */
-    case 0x8c: /* SDRC_EMR2_0 */
-    case 0x90: /* SDRC_EMR3_0 */
-    case 0x94: /* SDRC_DCDL1_CTRL */
-    case 0x98: /* SDRC_DCDL2_CTRL */
-    case 0x9c: /* SDRC_ACTIM_CTRLA_0 */
-    case 0xa0: /* SDRC_ACTIM_CTRLB_0 */
-    case 0xa4: /* SDRC_RFR_CTRL_0 */
-    case 0xa8: /* SDRC_MANUAL_0 */
-    case 0xb0: /* SDRC_MCFG_1 */
-    case 0xb4: /* SDRC_MR_1 */
-    case 0xb8: /* SDRC_EMR1_1 */
-    case 0xbc: /* SDRC_EMR2_1 */
-    case 0xc0: /* SDRC_EMR3_1 */
-    case 0xc4: /* SDRC_ACTIM_CTRLA_1 */
-    case 0xc8: /* SDRC_ACTIM_CTRLB_1 */
-    case 0xd4: /* SDRC_RFR_CTRL_1 */
-    case 0xd8: /* SDRC_MANUAL_1 */
+    case 0x14:  /* SDRC_SYSSTATUS */
+        return 1;           /* RESETDONE */
+
+    case 0x40:  /* SDRC_CS_CFG */
+    case 0x44:  /* SDRC_SHARING */
+    case 0x48:  /* SDRC_ERR_ADDR */
+    case 0x4c:  /* SDRC_ERR_TYPE */
+    case 0x60:  /* SDRC_DLLA_SCTRL */
+    case 0x64:  /* SDRC_DLLA_STATUS */
+    case 0x68:  /* SDRC_DLLB_CTRL */
+    case 0x6c:  /* SDRC_DLLB_STATUS */
+    case 0x70:  /* SDRC_POWER */
+    case 0x80:  /* SDRC_MCFG_0 */
+    case 0x84:  /* SDRC_MR_0 */
+    case 0x88:  /* SDRC_EMR1_0 */
+    case 0x8c:  /* SDRC_EMR2_0 */
+    case 0x90:  /* SDRC_EMR3_0 */
+    case 0x94:  /* SDRC_DCDL1_CTRL */
+    case 0x98:  /* SDRC_DCDL2_CTRL */
+    case 0x9c:  /* SDRC_ACTIM_CTRLA_0 */
+    case 0xa0:  /* SDRC_ACTIM_CTRLB_0 */
+    case 0xa4:  /* SDRC_RFR_CTRL_0 */
+    case 0xa8:  /* SDRC_MANUAL_0 */
+    case 0xb0:  /* SDRC_MCFG_1 */
+    case 0xb4:  /* SDRC_MR_1 */
+    case 0xb8:  /* SDRC_EMR1_1 */
+    case 0xbc:  /* SDRC_EMR2_1 */
+    case 0xc0:  /* SDRC_EMR3_1 */
+    case 0xc4:  /* SDRC_ACTIM_CTRLA_1 */
+    case 0xc8:  /* SDRC_ACTIM_CTRLB_1 */
+    case 0xd4:  /* SDRC_RFR_CTRL_1 */
+    case 0xd8:  /* SDRC_MANUAL_1 */
         return 0x00;
     }

@@ -96,49 +96,50 @@ static void omap_sdrc_write(void *opaque, hwaddr addr,
     }

     switch (addr) {
-    case 0x00: /* SDRC_REVISION */
-    case 0x14: /* SDRC_SYSSTATUS */
-    case 0x48: /* SDRC_ERR_ADDR */
-    case 0x64: /* SDRC_DLLA_STATUS */
-    case 0x6c: /* SDRC_DLLB_STATUS */
+    case 0x00:  /* SDRC_REVISION */
+    case 0x14:  /* SDRC_SYSSTATUS */
+    case 0x48:  /* SDRC_ERR_ADDR */
+    case 0x64:  /* SDRC_DLLA_STATUS */
+    case 0x6c:  /* SDRC_DLLB_STATUS */
         OMAP_RO_REG(addr);
         return;

-    case 0x10: /* SDRC_SYSCONFIG */
+    case 0x10:  /* SDRC_SYSCONFIG */
         if ((value >> 3) != 0x2)
             fprintf(stderr, "%s: bad SDRAM idle mode %i\n",
                     __func__, (unsigned)value >> 3);
-        if (value & 2)
+        if (value & 2) {
             omap_sdrc_reset(s);
+        }
         s->config = value & 0x18;
         break;

-    case 0x40: /* SDRC_CS_CFG */
-    case 0x44: /* SDRC_SHARING */
-    case 0x4c: /* SDRC_ERR_TYPE */
-    case 0x60: /* SDRC_DLLA_SCTRL */
-    case 0x68: /* SDRC_DLLB_CTRL */
-    case 0x70: /* SDRC_POWER */
-    case 0x80: /* SDRC_MCFG_0 */
-    case 0x84: /* SDRC_MR_0 */
-    case 0x88: /* SDRC_EMR1_0 */
-    case 0x8c: /* SDRC_EMR2_0 */
-    case 0x90: /* SDRC_EMR3_0 */
-    case 0x94: /* SDRC_DCDL1_CTRL */
-    case 0x98: /* SDRC_DCDL2_CTRL */
-    case 0x9c: /* SDRC_ACTIM_CTRLA_0 */
-    case 0xa0: /* SDRC_ACTIM_CTRLB_0 */
-    case 0xa4: /* SDRC_RFR_CTRL_0 */
-    case 0xa8: /* SDRC_MANUAL_0 */
-    case 0xb0: /* SDRC_MCFG_1 */
-    case 0xb4: /* SDRC_MR_1 */
-    case 0xb8: /* SDRC_EMR1_1 */
-    case 0xbc: /* SDRC_EMR2_1 */
-    case 0xc0: /* SDRC_EMR3_1 */
-    case 0xc4: /* SDRC_ACTIM_CTRLA_1 */
-    case 0xc8: /* SDRC_ACTIM_CTRLB_1 */
-    case 0xd4: /* SDRC_RFR_CTRL_1 */
-    case 0xd8: /* SDRC_MANUAL_1 */
+    case 0x40:  /* SDRC_CS_CFG */
+    case 0x44:  /* SDRC_SHARING */
+    case 0x4c:  /* SDRC_ERR_TYPE */
+    case 0x60:  /* SDRC_DLLA_SCTRL */
+    case 0x68:  /* SDRC_DLLB_CTRL */
+    case 0x70:  /* SDRC_POWER */
+    case 0x80:  /* SDRC_MCFG_0 */
+    case 0x84:  /* SDRC_MR_0 */
+    case 0x88:  /* SDRC_EMR1_0 */
+    case 0x8c:  /* SDRC_EMR2_0 */
+    case 0x90:  /* SDRC_EMR3_0 */
+    case 0x94:  /* SDRC_DCDL1_CTRL */
+    case 0x98:  /* SDRC_DCDL2_CTRL */
+    case 0x9c:  /* SDRC_ACTIM_CTRLA_0 */
+    case 0xa0:  /* SDRC_ACTIM_CTRLB_0 */
+    case 0xa4:  /* SDRC_RFR_CTRL_0 */
+    case 0xa8:  /* SDRC_MANUAL_0 */
+    case 0xb0:  /* SDRC_MCFG_1 */
+    case 0xb4:  /* SDRC_MR_1 */
+    case 0xb8:  /* SDRC_EMR1_1 */
+    case 0xbc:  /* SDRC_EMR2_1 */
+    case 0xc0:  /* SDRC_EMR3_1 */
+    case 0xc4:  /* SDRC_ACTIM_CTRLA_1 */
+    case 0xc8:  /* SDRC_ACTIM_CTRLB_1 */
+    case 0xd4:  /* SDRC_RFR_CTRL_1 */
+    case 0xd8:  /* SDRC_MANUAL_1 */
         break;

     default:
diff --git a/hw/misc/omap_tap.c b/hw/misc/omap_tap.c
index 4d7fb7d85f..daa15696ee 100644
--- a/hw/misc/omap_tap.c
+++ b/hw/misc/omap_tap.c
@@ -32,25 +32,25 @@ static uint64_t omap_tap_read(void *opaque, hwaddr
addr, unsigned size)
     }

     switch (addr) {
-    case 0x204: /* IDCODE_reg */
+    case 0x204: /* IDCODE_reg */
         switch (s->mpu_model) {
         case omap2420:
         case omap2422:
         case omap2423:
-            return 0x5b5d902f; /* ES 2.2 */
+            return 0x5b5d902f;  /* ES 2.2 */
         case omap2430:
-            return 0x5b68a02f; /* ES 2.2 */
+            return 0x5b68a02f;  /* ES 2.2 */
         case omap3430:
-            return 0x1b7ae02f; /* ES 2 */
+            return 0x1b7ae02f;  /* ES 2 */
         default:
             hw_error("%s: Bad mpu model\n", __func__);
         }

-    case 0x208: /* PRODUCTION_ID_reg for OMAP2 */
-    case 0x210: /* PRODUCTION_ID_reg for OMAP3 */
+    case 0x208: /* PRODUCTION_ID_reg for OMAP2 */
+    case 0x210: /* PRODUCTION_ID_reg for OMAP3 */
         switch (s->mpu_model) {
         case omap2420:
-            return 0x000254f0; /* POP ESHS2.1.1 in N91/93/95, ES2 in N800
*/
+            return 0x000254f0;  /* POP ESHS2.1.1 in N91/93/95, ES2 in N800
*/
         case omap2422:
             return 0x000400f0;
         case omap2423:
@@ -68,22 +68,22 @@ static uint64_t omap_tap_read(void *opaque, hwaddr
addr, unsigned size)
         case omap2420:
         case omap2422:
         case omap2423:
-            return 0xcafeb5d9; /* ES 2.2 */
+            return 0xcafeb5d9;  /* ES 2.2 */
         case omap2430:
-            return 0xcafeb68a; /* ES 2.2 */
+            return 0xcafeb68a;  /* ES 2.2 */
         case omap3430:
-            return 0xcafeb7ae; /* ES 2 */
+            return 0xcafeb7ae;  /* ES 2 */
         default:
             hw_error("%s: Bad mpu model\n", __func__);
         }

-    case 0x218: /* DIE_ID_reg */
+    case 0x218: /* DIE_ID_reg */
         return ('Q' << 24) | ('E' << 16) | ('M' << 8) | ('U' << 0);
-    case 0x21c: /* DIE_ID_reg */
+    case 0x21c: /* DIE_ID_reg */
         return 0x54 << 24;
-    case 0x220: /* DIE_ID_reg */
+    case 0x220: /* DIE_ID_reg */
         return ('Q' << 24) | ('E' << 16) | ('M' << 8) | ('U' << 0);
-    case 0x224: /* DIE_ID_reg */
+    case 0x224: /* DIE_ID_reg */
         return ('Q' << 24) | ('E' << 16) | ('M' << 8) | ('U' << 0);
     }

diff --git a/hw/sd/omap_mmc.c b/hw/sd/omap_mmc.c
index edd3cf2a1e..848e42f076 100644
--- a/hw/sd/omap_mmc.c
+++ b/hw/sd/omap_mmc.c
@@ -104,11 +104,11 @@ static void omap_mmc_fifolevel_update(struct
omap_mmc_s *host)
 }

 typedef enum {
-    sd_nore = 0, /* no response */
-    sd_r1, /* normal response command */
-    sd_r2, /* CID, CSD registers */
-    sd_r3, /* OCR register */
-    sd_r6 = 6, /* Published RCA response */
+    sd_nore = 0,  /* no response */
+    sd_r1,        /* normal response command */
+    sd_r2,        /* CID, CSD registers */
+    sd_r3,        /* OCR register */
+    sd_r6 = 6,    /* Published RCA response */
     sd_r1b = -1,
 } sd_rsp_type_t;

@@ -125,8 +125,9 @@ static void omap_mmc_command(struct omap_mmc_s *host,
int cmd, int dir,
         return;
     }

-    if (resptype == sd_r1 && busy)
+    if (resptype == sd_r1 && busy) {
         resptype = sd_r1b;
+    }

     if (type == sd_adtc) {
         host->fifo_start = 0;
@@ -164,8 +165,9 @@ static void omap_mmc_command(struct omap_mmc_s *host,
int cmd, int dir,
                 LOCK_UNLOCK_FAILED | COM_CRC_ERROR | ILLEGAL_COMMAND |
                 CARD_ECC_FAILED | CC_ERROR | SD_ERROR |
                 CID_CSD_OVERWRITE;
-        if (host->sdio & (1 << 13))
+        if (host->sdio & (1 << 13)) {
             mask |= AKE_SEQ_ERROR;
+        }
         rspstatus = ldl_be_p(response);
         break;

@@ -185,10 +187,11 @@ static void omap_mmc_command(struct omap_mmc_s *host,
int cmd, int dir,
         rsplen = 4;

         rspstatus = ldl_be_p(response);
-        if (rspstatus & 0x80000000)
+        if (rspstatus & 0x80000000) {
             host->status &= 0xe000;
-        else
+        } else {
             host->status |= 0x1000;
+        }
         break;

     case sd_r6:
@@ -202,35 +205,39 @@ static void omap_mmc_command(struct omap_mmc_s *host,
int cmd, int dir,
         rspstatus = (response[2] << 8) | (response[3] << 0);
     }

-    if (rspstatus & mask)
+    if (rspstatus & mask) {
         host->status |= 0x4000;
-    else
+    } else {
         host->status &= 0xb000;
+    }

     if (rsplen)
-        for (rsplen = 0; rsplen < 8; rsplen ++)
+        for (rsplen = 0; rsplen < 8; rsplen++)
             host->rsp[~rsplen & 7] = response[(rsplen << 1) | 1] |
                     (response[(rsplen << 1) | 0] << 8);

-    if (timeout)
+    if (timeout) {
         host->status |= 0x0080;
-    else if (cmd == 12)
-        host->status |= 0x0005; /* Makes it more real */
-    else
+    } else if (cmd == 12) {
+        host->status |= 0x0005; /* Makes it more real */
+    } else {
         host->status |= 0x0001;
+    }
 }

 static void omap_mmc_transfer(struct omap_mmc_s *host)
 {
     uint8_t value;

-    if (!host->transfer)
+    if (!host->transfer) {
         return;
+    }

     while (1) {
         if (host->ddir) {
-            if (host->fifo_len > host->af_level)
+            if (host->fifo_len > host->af_level) {
                 break;
+            }

             value = sd_read_byte(host->card);
             host->fifo[(host->fifo_start + host->fifo_len) & 31] = value;
@@ -238,29 +245,30 @@ static void omap_mmc_transfer(struct omap_mmc_s *host)
                 value = sd_read_byte(host->card);
                 host->fifo[(host->fifo_start + host->fifo_len) & 31] |=
                         value << 8;
-                host->blen_counter --;
+                host->blen_counter--;
             }

-            host->fifo_len ++;
+            host->fifo_len++;
         } else {
-            if (!host->fifo_len)
+            if (!host->fifo_len) {
                 break;
+            }

             value = host->fifo[host->fifo_start] & 0xff;
             sd_write_byte(host->card, value);
             if (-- host->blen_counter) {
                 value = host->fifo[host->fifo_start] >> 8;
                 sd_write_byte(host->card, value);
-                host->blen_counter --;
+                host->blen_counter--;
             }

-            host->fifo_start ++;
-            host->fifo_len --;
+            host->fifo_start++;
+            host->fifo_len--;
             host->fifo_start &= 31;
         }

         if (host->blen_counter == 0) {
-            host->nblk_counter --;
+            host->nblk_counter--;
             host->blen_counter = host->blen;

             if (host->nblk_counter == 0) {
@@ -331,82 +339,82 @@ static uint64_t omap_mmc_read(void *opaque, hwaddr
offset, unsigned size)
     }

     switch (offset) {
-    case 0x00: /* MMC_CMD */
+    case 0x00:  /* MMC_CMD */
         return s->last_cmd;

-    case 0x04: /* MMC_ARGL */
+    case 0x04:  /* MMC_ARGL */
         return s->arg & 0x0000ffff;

-    case 0x08: /* MMC_ARGH */
+    case 0x08:  /* MMC_ARGH */
         return s->arg >> 16;

-    case 0x0c: /* MMC_CON */
-        return (s->dw << 15) | (s->mode << 12) | (s->enable << 11) |
+    case 0x0c:  /* MMC_CON */
+        return (s->dw << 15) | (s->mode << 12) | (s->enable << 11) |
                 (s->be << 10) | s->clkdiv;

-    case 0x10: /* MMC_STAT */
+    case 0x10:  /* MMC_STAT */
         return s->status;

-    case 0x14: /* MMC_IE */
+    case 0x14:  /* MMC_IE */
         return s->mask;

-    case 0x18: /* MMC_CTO */
+    case 0x18:  /* MMC_CTO */
         return s->cto;

-    case 0x1c: /* MMC_DTO */
+    case 0x1c:  /* MMC_DTO */
         return s->dto;

-    case 0x20: /* MMC_DATA */
+    case 0x20:  /* MMC_DATA */
         /* TODO: support 8-bit access */
         i = s->fifo[s->fifo_start];
         if (s->fifo_len == 0) {
             printf("MMC: FIFO underrun\n");
             return i;
         }
-        s->fifo_start ++;
-        s->fifo_len --;
+        s->fifo_start++;
+        s->fifo_len--;
         s->fifo_start &= 31;
         omap_mmc_transfer(s);
         omap_mmc_fifolevel_update(s);
         omap_mmc_interrupts_update(s);
         return i;

-    case 0x24: /* MMC_BLEN */
+    case 0x24:  /* MMC_BLEN */
         return s->blen_counter;

-    case 0x28: /* MMC_NBLK */
+    case 0x28:  /* MMC_NBLK */
         return s->nblk_counter;

-    case 0x2c: /* MMC_BUF */
+    case 0x2c:  /* MMC_BUF */
         return (s->rx_dma << 15) | (s->af_level << 8) |
             (s->tx_dma << 7) | s->ae_level;

-    case 0x30: /* MMC_SPI */
+    case 0x30:  /* MMC_SPI */
         return 0x0000;
-    case 0x34: /* MMC_SDIO */
+    case 0x34:  /* MMC_SDIO */
         return (s->cdet_wakeup << 2) | (s->cdet_enable) | s->sdio;
-    case 0x38: /* MMC_SYST */
+    case 0x38:  /* MMC_SYST */
         return 0x0000;

-    case 0x3c: /* MMC_REV */
+    case 0x3c:  /* MMC_REV */
         return s->rev;

-    case 0x40: /* MMC_RSP0 */
-    case 0x44: /* MMC_RSP1 */
-    case 0x48: /* MMC_RSP2 */
-    case 0x4c: /* MMC_RSP3 */
-    case 0x50: /* MMC_RSP4 */
-    case 0x54: /* MMC_RSP5 */
-    case 0x58: /* MMC_RSP6 */
-    case 0x5c: /* MMC_RSP7 */
+    case 0x40:  /* MMC_RSP0 */
+    case 0x44:  /* MMC_RSP1 */
+    case 0x48:  /* MMC_RSP2 */
+    case 0x4c:  /* MMC_RSP3 */
+    case 0x50:  /* MMC_RSP4 */
+    case 0x54:  /* MMC_RSP5 */
+    case 0x58:  /* MMC_RSP6 */
+    case 0x5c:  /* MMC_RSP7 */
         return s->rsp[(offset - 0x40) >> 2];

     /* OMAP2-specific */
-    case 0x60: /* MMC_IOSR */
-    case 0x64: /* MMC_SYSC */
+    case 0x60:  /* MMC_IOSR */
+    case 0x64:  /* MMC_SYSC */
         return 0;
-    case 0x68: /* MMC_SYSS */
-        return 1; /* RSTD */
+    case 0x68:  /* MMC_SYSS */
+        return 1;           /* RSTD */
     }

     OMAP_BAD_REG(offset);
@@ -425,13 +433,15 @@ static void omap_mmc_write(void *opaque, hwaddr
offset,
     }

     switch (offset) {
-    case 0x00: /* MMC_CMD */
-        if (!s->enable)
+    case 0x00:  /* MMC_CMD */
+        if (!s->enable) {
             break;
+        }

         s->last_cmd = value;
-        for (i = 0; i < 8; i ++)
+        for (i = 0; i < 8; i++) {
             s->rsp[i] = 0x0000;
+        }
         omap_mmc_command(s, value & 63, (value >> 15) & 1,
                 (sd_cmd_type_t) ((value >> 12) & 3),
                 (value >> 11) & 1,
@@ -440,17 +450,17 @@ static void omap_mmc_write(void *opaque, hwaddr
offset,
         omap_mmc_update(s);
         break;

-    case 0x04: /* MMC_ARGL */
+    case 0x04:  /* MMC_ARGL */
         s->arg &= 0xffff0000;
         s->arg |= 0x0000ffff & value;
         break;

-    case 0x08: /* MMC_ARGH */
+    case 0x08:  /* MMC_ARGH */
         s->arg &= 0x0000ffff;
         s->arg |= value << 16;
         break;

-    case 0x0c: /* MMC_CON */
+    case 0x0c:  /* MMC_CON */
         s->dw = (value >> 15) & 1;
         s->mode = (value >> 12) & 3;
         s->enable = (value >> 11) & 1;
@@ -464,101 +474,109 @@ static void omap_mmc_write(void *opaque, hwaddr
offset,
             qemu_log_mask(LOG_UNIMP,
                           "omap_mmc_wr: Big Endian not implemented\n");
         }
-        if (s->dw != 0 && s->lines < 4)
+        if (s->dw != 0 && s->lines < 4) {
             printf("4-bit SD bus enabled\n");
-        if (!s->enable)
+        }
+        if (!s->enable) {
             omap_mmc_pseudo_reset(s);
+        }
         break;

-    case 0x10: /* MMC_STAT */
+    case 0x10:  /* MMC_STAT */
         s->status &= ~value;
         omap_mmc_interrupts_update(s);
         break;

-    case 0x14: /* MMC_IE */
+    case 0x14:  /* MMC_IE */
         s->mask = value & 0x7fff;
         omap_mmc_interrupts_update(s);
         break;

-    case 0x18: /* MMC_CTO */
+    case 0x18:  /* MMC_CTO */
         s->cto = value & 0xff;
-        if (s->cto > 0xfd && s->rev <= 1)
+        if (s->cto > 0xfd && s->rev <= 1) {
             printf("MMC: CTO of 0xff and 0xfe cannot be used!\n");
+        }
         break;

-    case 0x1c: /* MMC_DTO */
+    case 0x1c:  /* MMC_DTO */
         s->dto = value & 0xffff;
         break;

-    case 0x20: /* MMC_DATA */
+    case 0x20:  /* MMC_DATA */
         /* TODO: support 8-bit access */
-        if (s->fifo_len == 32)
+        if (s->fifo_len == 32) {
             break;
+        }
         s->fifo[(s->fifo_start + s->fifo_len) & 31] = value;
-        s->fifo_len ++;
+        s->fifo_len++;
         omap_mmc_transfer(s);
         omap_mmc_fifolevel_update(s);
         omap_mmc_interrupts_update(s);
         break;

-    case 0x24: /* MMC_BLEN */
+    case 0x24:  /* MMC_BLEN */
         s->blen = (value & 0x07ff) + 1;
         s->blen_counter = s->blen;
         break;

-    case 0x28: /* MMC_NBLK */
+    case 0x28:  /* MMC_NBLK */
         s->nblk = (value & 0x07ff) + 1;
         s->nblk_counter = s->nblk;
         s->blen_counter = s->blen;
         break;

-    case 0x2c: /* MMC_BUF */
+    case 0x2c:  /* MMC_BUF */
         s->rx_dma = (value >> 15) & 1;
         s->af_level = (value >> 8) & 0x1f;
         s->tx_dma = (value >> 7) & 1;
         s->ae_level = value & 0x1f;

-        if (s->rx_dma)
+        if (s->rx_dma) {
             s->status &= 0xfbff;
-        if (s->tx_dma)
+        }
+        if (s->tx_dma) {
             s->status &= 0xf7ff;
+        }
         omap_mmc_fifolevel_update(s);
         omap_mmc_interrupts_update(s);
         break;

     /* SPI, SDIO and TEST modes unimplemented */
-    case 0x30: /* MMC_SPI (OMAP1 only) */
+    case 0x30:  /* MMC_SPI (OMAP1 only) */
         break;
-    case 0x34: /* MMC_SDIO */
+    case 0x34:  /* MMC_SDIO */
         s->sdio = value & (s->rev >= 2 ? 0xfbf3 : 0x2020);
         s->cdet_wakeup = (value >> 9) & 1;
         s->cdet_enable = (value >> 2) & 1;
         break;
-    case 0x38: /* MMC_SYST */
+    case 0x38:  /* MMC_SYST */
         break;

-    case 0x3c: /* MMC_REV */
-    case 0x40: /* MMC_RSP0 */
-    case 0x44: /* MMC_RSP1 */
-    case 0x48: /* MMC_RSP2 */
-    case 0x4c: /* MMC_RSP3 */
-    case 0x50: /* MMC_RSP4 */
-    case 0x54: /* MMC_RSP5 */
-    case 0x58: /* MMC_RSP6 */
-    case 0x5c: /* MMC_RSP7 */
+    case 0x3c:  /* MMC_REV */
+    case 0x40:  /* MMC_RSP0 */
+    case 0x44:  /* MMC_RSP1 */
+    case 0x48:  /* MMC_RSP2 */
+    case 0x4c:  /* MMC_RSP3 */
+    case 0x50:  /* MMC_RSP4 */
+    case 0x54:  /* MMC_RSP5 */
+    case 0x58:  /* MMC_RSP6 */
+    case 0x5c:  /* MMC_RSP7 */
         OMAP_RO_REG(offset);
         break;

     /* OMAP2-specific */
-    case 0x60: /* MMC_IOSR */
-        if (value & 0xf)
+    case 0x60:  /* MMC_IOSR */
+        if (value & 0xf) {
             printf("MMC: SDIO bits used!\n");
+        }
         break;
-    case 0x64: /* MMC_SYSC */
-        if (value & (1 << 2)) /* SRTS */
+    case 0x64:  /* MMC_SYSC */
+        if (value & (1 << 2)) {       /* SRTS */
             omap_mmc_reset(s);
+        }
         break;
-    case 0x68: /* MMC_SYSS */
+    case 0x68:  /* MMC_SYSS */
         OMAP_RO_REG(offset);
         break;

@@ -601,7 +619,7 @@ struct omap_mmc_s *omap_mmc_init(hwaddr base,
     s->irq = irq;
     s->dma = dma;
     s->clk = clk;
-    s->lines = 1; /* TODO: needs to be settable per-board */
+    s->lines = 1; /* TODO: needs to be settable per-board */
     s->rev = 1;

     memory_region_init_io(&s->iomem, NULL, &omap_mmc_ops, s, "omap.mmc",
0x800);
diff --git a/hw/sd/pxa2xx_mmci.c b/hw/sd/pxa2xx_mmci.c
index 82529708c8..4fd17da95b 100644
--- a/hw/sd/pxa2xx_mmci.c
+++ b/hw/sd/pxa2xx_mmci.c
@@ -113,55 +113,55 @@ static const VMStateDescription vmstate_pxa2xx_mmci =
{
     }
 };

-#define MMC_STRPCL 0x00 /* MMC Clock Start/Stop register */
-#define MMC_STAT 0x04 /* MMC Status register */
-#define MMC_CLKRT 0x08 /* MMC Clock Rate register */
-#define MMC_SPI 0x0c /* MMC SPI Mode register */
-#define MMC_CMDAT 0x10 /* MMC Command/Data register */
-#define MMC_RESTO 0x14 /* MMC Response Time-Out register */
-#define MMC_RDTO 0x18 /* MMC Read Time-Out register */
-#define MMC_BLKLEN 0x1c /* MMC Block Length register */
-#define MMC_NUMBLK 0x20 /* MMC Number of Blocks register */
-#define MMC_PRTBUF 0x24 /* MMC Buffer Partly Full register */
-#define MMC_I_MASK 0x28 /* MMC Interrupt Mask register */
-#define MMC_I_REG 0x2c /* MMC Interrupt Request register */
-#define MMC_CMD 0x30 /* MMC Command register */
-#define MMC_ARGH 0x34 /* MMC Argument High register */
-#define MMC_ARGL 0x38 /* MMC Argument Low register */
-#define MMC_RES 0x3c /* MMC Response FIFO */
-#define MMC_RXFIFO 0x40 /* MMC Receive FIFO */
-#define MMC_TXFIFO 0x44 /* MMC Transmit FIFO */
-#define MMC_RDWAIT 0x48 /* MMC RD_WAIT register */
-#define MMC_BLKS_REM 0x4c /* MMC Blocks Remaining register */
+#define MMC_STRPCL    0x00  /* MMC Clock Start/Stop register */
+#define MMC_STAT      0x04  /* MMC Status register */
+#define MMC_CLKRT     0x08  /* MMC Clock Rate register */
+#define MMC_SPI       0x0c  /* MMC SPI Mode register */
+#define MMC_CMDAT     0x10  /* MMC Command/Data register */
+#define MMC_RESTO     0x14  /* MMC Response Time-Out register */
+#define MMC_RDTO      0x18  /* MMC Read Time-Out register */
+#define MMC_BLKLEN    0x1c  /* MMC Block Length register */
+#define MMC_NUMBLK    0x20  /* MMC Number of Blocks register */
+#define MMC_PRTBUF    0x24  /* MMC Buffer Partly Full register */
+#define MMC_I_MASK    0x28  /* MMC Interrupt Mask register */
+#define MMC_I_REG     0x2c  /* MMC Interrupt Request register */
+#define MMC_CMD       0x30  /* MMC Command register */
+#define MMC_ARGH      0x34  /* MMC Argument High register */
+#define MMC_ARGL      0x38  /* MMC Argument Low register */
+#define MMC_RES       0x3c  /* MMC Response FIFO */
+#define MMC_RXFIFO    0x40  /* MMC Receive FIFO */
+#define MMC_TXFIFO    0x44  /* MMC Transmit FIFO */
+#define MMC_RDWAIT    0x48  /* MMC RD_WAIT register */
+#define MMC_BLKS_REM  0x4c  /* MMC Blocks Remaining register */

 /* Bitfield masks */
-#define STRPCL_STOP_CLK (1 << 0)
-#define STRPCL_STRT_CLK (1 << 1)
-#define STAT_TOUT_RES (1 << 1)
-#define STAT_CLK_EN (1 << 8)
-#define STAT_DATA_DONE (1 << 11)
-#define STAT_PRG_DONE (1 << 12)
-#define STAT_END_CMDRES (1 << 13)
-#define SPI_SPI_MODE (1 << 0)
-#define CMDAT_RES_TYPE (3 << 0)
-#define CMDAT_DATA_EN (1 << 2)
-#define CMDAT_WR_RD (1 << 3)
-#define CMDAT_DMA_EN (1 << 7)
-#define CMDAT_STOP_TRAN (1 << 10)
-#define INT_DATA_DONE (1 << 0)
-#define INT_PRG_DONE (1 << 1)
-#define INT_END_CMD (1 << 2)
-#define INT_STOP_CMD (1 << 3)
-#define INT_CLK_OFF (1 << 4)
-#define INT_RXFIFO_REQ (1 << 5)
-#define INT_TXFIFO_REQ (1 << 6)
-#define INT_TINT (1 << 7)
-#define INT_DAT_ERR (1 << 8)
-#define INT_RES_ERR (1 << 9)
-#define INT_RD_STALLED (1 << 10)
-#define INT_SDIO_INT (1 << 11)
-#define INT_SDIO_SACK (1 << 12)
-#define PRTBUF_PRT_BUF (1 << 0)
+#define STRPCL_STOP_CLK (1 << 0)
+#define STRPCL_STRT_CLK (1 << 1)
+#define STAT_TOUT_RES   (1 << 1)
+#define STAT_CLK_EN     (1 << 8)
+#define STAT_DATA_DONE  (1 << 11)
+#define STAT_PRG_DONE   (1 << 12)
+#define STAT_END_CMDRES (1 << 13)
+#define SPI_SPI_MODE    (1 << 0)
+#define CMDAT_RES_TYPE  (3 << 0)
+#define CMDAT_DATA_EN   (1 << 2)
+#define CMDAT_WR_RD     (1 << 3)
+#define CMDAT_DMA_EN    (1 << 7)
+#define CMDAT_STOP_TRAN (1 << 10)
+#define INT_DATA_DONE   (1 << 0)
+#define INT_PRG_DONE    (1 << 1)
+#define INT_END_CMD     (1 << 2)
+#define INT_STOP_CMD    (1 << 3)
+#define INT_CLK_OFF     (1 << 4)
+#define INT_RXFIFO_REQ  (1 << 5)
+#define INT_TXFIFO_REQ  (1 << 6)
+#define INT_TINT        (1 << 7)
+#define INT_DAT_ERR     (1 << 8)
+#define INT_RES_ERR     (1 << 9)
+#define INT_RD_STALLED  (1 << 10)
+#define INT_SDIO_INT    (1 << 11)
+#define INT_SDIO_SACK   (1 << 12)
+#define PRTBUF_PRT_BUF  (1 << 0)

 /* Route internal interrupt lines to the global IC and DMA */
 static void pxa2xx_mmci_int_update(PXA2xxMMCIState *s)
@@ -179,23 +179,25 @@ static void pxa2xx_mmci_int_update(PXA2xxMMCIState *s)

 static void pxa2xx_mmci_fifo_update(PXA2xxMMCIState *s)
 {
-    if (!s->active)
+    if (!s->active) {
         return;
+    }

     if (s->cmdat & CMDAT_WR_RD) {
         while (s->bytesleft && s->tx_len) {
             sdbus_write_byte(&s->sdbus, s->tx_fifo[s->tx_start++]);
             s->tx_start &= 0x1f;
-            s->tx_len --;
-            s->bytesleft --;
+            s->tx_len--;
+            s->bytesleft--;
         }
-        if (s->bytesleft)
+        if (s->bytesleft) {
             s->intreq |= INT_TXFIFO_REQ;
+        }
     } else
         while (s->bytesleft && s->rx_len < 32) {
-            s->rx_fifo[(s->rx_start + (s->rx_len ++)) & 0x1f] =
+            s->rx_fifo[(s->rx_start + (s->rx_len++)) & 0x1f] =
                 sdbus_read_byte(&s->sdbus);
-            s->bytesleft --;
+            s->bytesleft--;
             s->intreq |= INT_RXFIFO_REQ;
         }

@@ -226,44 +228,50 @@ static void pxa2xx_mmci_wakequeues(PXA2xxMMCIState *s)

     request.cmd = s->cmd;
     request.arg = s->arg;
-    request.crc = 0; /* FIXME */
+    request.crc = 0;  /* FIXME */

     rsplen = sdbus_do_command(&s->sdbus, &request, response);
     s->intreq |= INT_END_CMD;

     memset(s->resp_fifo, 0, sizeof(s->resp_fifo));
     switch (s->cmdat & CMDAT_RES_TYPE) {
-#define PXAMMCI_RESP(wd, value0, value1) \
-        s->resp_fifo[(wd) + 0] |= (value0); \
-        s->resp_fifo[(wd) + 1] |= (value1) << 8;
-    case 0: /* No response */
+#define PXAMMCI_RESP(wd, value0, value1)    \
+    do {                                    \
+        s->resp_fifo[(wd) + 0] = (value0);  \
+        s->resp_fifo[(wd) + 1] = (value1);  \
+    } while (0)
+    case 0: /* No response */
         goto complete;

-    case 1: /* R1, R4, R5 or R6 */
-        if (rsplen < 4)
+    case 1: /* R1, R4, R5 or R6 */
+        if (rsplen < 4) {
             goto timeout;
+        }
         goto complete;

-    case 2: /* R2 */
-        if (rsplen < 16)
+    case 2: /* R2 */
+        if (rsplen < 16) {
             goto timeout;
+        }
         goto complete;

-    case 3: /* R3 */
-        if (rsplen < 4)
+    case 3: /* R3 */
+        if (rsplen < 4) {
             goto timeout;
+        }
         goto complete;

     complete:
-        for (i = 0; rsplen > 0; i ++, rsplen -= 2) {
+        for (i = 0; rsplen > 0; i++, rsplen -= 2) {
             PXAMMCI_RESP(i, response[i * 2], response[i * 2 + 1]);
         }
         s->status |= STAT_END_CMDRES;

-        if (!(s->cmdat & CMDAT_DATA_EN))
+        if (!(s->cmdat & CMDAT_DATA_EN)) {
             s->active = 0;
-        else
+        } else {
             s->bytesleft = s->numblk * s->blklen;
+        }

         s->resp_len = 0;
         break;
@@ -333,7 +341,7 @@ static uint64_t pxa2xx_mmci_read(void *opaque, hwaddr
offset, unsigned size)
         while (size-- && s->rx_len) {
             ret |= s->rx_fifo[s->rx_start++] << (size << 3);
             s->rx_start &= 0x1f;
-            s->rx_len --;
+            s->rx_len--;
         }
         s->intreq &= ~INT_RXFIFO_REQ;
         pxa2xx_mmci_fifo_update(s);
@@ -399,8 +407,9 @@ static void pxa2xx_mmci_write(void *opaque,
         if (!(value & CMDAT_STOP_TRAN)) {
             s->status &= STAT_CLK_EN;

-            if (s->status & STAT_CLK_EN)
+            if (s->status & STAT_CLK_EN) {
                 pxa2xx_mmci_wakequeues(s);
+            }
         }

         pxa2xx_mmci_int_update(s);
@@ -451,7 +460,7 @@ static void pxa2xx_mmci_write(void *opaque,

     case MMC_TXFIFO:
         while (size-- && s->tx_len < 0x20)
-            s->tx_fifo[(s->tx_start + (s->tx_len ++)) & 0x1f] =
+            s->tx_fifo[(s->tx_start + (s->tx_len++)) & 0x1f] =
                     (value >> (size << 3)) & 0xff;
         s->intreq &= ~INT_TXFIFO_REQ;
         pxa2xx_mmci_fifo_update(s);
diff --git a/hw/timer/omap_gptimer.c b/hw/timer/omap_gptimer.c
index 34e6af7aff..078ce294eb 100644
--- a/hw/timer/omap_gptimer.c
+++ b/hw/timer/omap_gptimer.c
@@ -69,27 +69,29 @@ struct omap_gp_timer_s {
     uint32_t match_val;
     int capt_num;

-    uint16_t writeh; /* LSB */
-    uint16_t readh; /* MSB */
+    uint16_t writeh;  /* LSB */
+    uint16_t readh;   /* MSB */
 };

-#define GPT_TCAR_IT (1 << 2)
-#define GPT_OVF_IT (1 << 1)
-#define GPT_MAT_IT (1 << 0)
+#define GPT_TCAR_IT (1 << 2)
+#define GPT_OVF_IT  (1 << 1)
+#define GPT_MAT_IT  (1 << 0)

 static inline void omap_gp_timer_intr(struct omap_gp_timer_s *timer, int
it)
 {
     if (timer->it_ena & it) {
-        if (!timer->status)
+        if (!timer->status) {
             qemu_irq_raise(timer->irq);
+        }

         timer->status |= it;
         /* Or are the status bits set even when masked?
          * i.e. is masking applied before or after the status register?  */
     }

-    if (timer->wu_ena & it)
+    if (timer->wu_ena & it) {
         qemu_irq_pulse(timer->wkup);
+    }
 }

 static inline void omap_gp_timer_out(struct omap_gp_timer_s *timer, int
level)
@@ -108,10 +110,11 @@ static inline uint32_t omap_gp_timer_read(struct
omap_gp_timer_s *timer)
         distance = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) - timer->time;
         distance = muldiv64(distance, timer->rate, timer->ticks_per_sec);

-        if (distance >= 0xffffffff - timer->val)
+        if (distance >= 0xffffffff - timer->val) {
             return 0xffffffff;
-        else
+        } else {
             return timer->val + distance;
+        }
     } else
         return timer->val;
 }
@@ -148,13 +151,14 @@ static inline void omap_gp_timer_update(struct
omap_gp_timer_s *timer)

 static inline void omap_gp_timer_trigger(struct omap_gp_timer_s *timer)
 {
-    if (timer->pt)
+    if (timer->pt) {
         /* TODO in overflow-and-match mode if the first event to
          * occur is the match, don't toggle.  */
         omap_gp_timer_out(timer, !timer->out_val);
-    else
+    } else {
         /* TODO inverted pulse on timer->out_val == 1?  */
         qemu_irq_pulse(timer->out);
+    }
 }

 static void omap_gp_timer_tick(void *opaque)
@@ -181,8 +185,9 @@ static void omap_gp_timer_match(void *opaque)
 {
     struct omap_gp_timer_s *timer = opaque;

-    if (timer->trigger == gpt_trigger_both)
+    if (timer->trigger == gpt_trigger_both) {
         omap_gp_timer_trigger(timer);
+    }

     omap_gp_timer_intr(timer, GPT_MAT_IT);
 }
@@ -212,8 +217,9 @@ static void omap_gp_timer_input(void *opaque, int line,
int on)
     if (s->inout && trigger && s->capt_num < 2) {
         s->capture_val[s->capt_num] = omap_gp_timer_read(s);

-        if (s->capt2 == s->capt_num ++)
+        if (s->capt2 == s->capt_num++) {
             omap_gp_timer_intr(s, GPT_TCAR_IT);
+        }
     }
 }

@@ -265,26 +271,26 @@ static uint32_t omap_gp_timer_readw(void *opaque,
hwaddr addr)
     struct omap_gp_timer_s *s = opaque;

     switch (addr) {
-    case 0x00: /* TIDR */
+    case 0x00:  /* TIDR */
         return 0x21;

-    case 0x10: /* TIOCP_CFG */
+    case 0x10:  /* TIOCP_CFG */
         return s->config;

-    case 0x14: /* TISTAT */
+    case 0x14:  /* TISTAT */
         /* ??? When's this bit reset? */
-        return 1; /* RESETDONE */
+        return 1;           /* RESETDONE */

-    case 0x18: /* TISR */
+    case 0x18:  /* TISR */
         return s->status;

-    case 0x1c: /* TIER */
+    case 0x1c:  /* TIER */
         return s->it_ena;

-    case 0x20: /* TWER */
+    case 0x20:  /* TWER */
         return s->wu_ena;

-    case 0x24: /* TCLR */
+    case 0x24:  /* TCLR */
         return (s->inout << 14) |
                 (s->capt2 << 13) |
                 (s->pt << 12) |
@@ -297,28 +303,28 @@ static uint32_t omap_gp_timer_readw(void *opaque,
hwaddr addr)
                 (s->ar << 1) |
                 (s->st << 0);

-    case 0x28: /* TCRR */
+    case 0x28:  /* TCRR */
         return omap_gp_timer_read(s);

-    case 0x2c: /* TLDR */
+    case 0x2c:  /* TLDR */
         return s->load_val;

-    case 0x30: /* TTGR */
+    case 0x30:  /* TTGR */
         return 0xffffffff;

-    case 0x34: /* TWPS */
-        return 0x00000000; /* No posted writes pending.  */
+    case 0x34:  /* TWPS */
+        return 0x00000000;  /* No posted writes pending.  */

-    case 0x38: /* TMAR */
+    case 0x38:  /* TMAR */
         return s->match_val;

-    case 0x3c: /* TCAR1 */
+    case 0x3c:  /* TCAR1 */
         return s->capture_val[0];

-    case 0x40: /* TSICR */
+    case 0x40:  /* TSICR */
         return s->posted << 2;

-    case 0x44: /* TCAR2 */
+    case 0x44:  /* TCAR2 */
         return s->capture_val[1];
     }

@@ -345,47 +351,54 @@ static void omap_gp_timer_write(void *opaque, hwaddr
addr, uint32_t value)
     struct omap_gp_timer_s *s = opaque;

     switch (addr) {
-    case 0x00: /* TIDR */
-    case 0x14: /* TISTAT */
-    case 0x34: /* TWPS */
-    case 0x3c: /* TCAR1 */
-    case 0x44: /* TCAR2 */
+    case 0x00:  /* TIDR */
+    case 0x14:  /* TISTAT */
+    case 0x34:  /* TWPS */
+    case 0x3c:  /* TCAR1 */
+    case 0x44:  /* TCAR2 */
         OMAP_RO_REG(addr);
         break;

-    case 0x10: /* TIOCP_CFG */
+    case 0x10:  /* TIOCP_CFG */
         s->config = value & 0x33d;
-        if (((value >> 3) & 3) == 3) /* IDLEMODE */
+        if (((value >> 3) & 3) == 3) {      /* IDLEMODE */
             fprintf(stderr, "%s: illegal IDLEMODE value in TIOCP_CFG\n",
                             __func__);
-        if (value & 2) /* SOFTRESET */
+        }
+        if (value & 2)            /* SOFTRESET */
             omap_gp_timer_reset(s);
         break;

-    case 0x18: /* TISR */
-        if (value & GPT_TCAR_IT)
+    case 0x18:  /* TISR */
+        if (value & GPT_TCAR_IT) {
             s->capt_num = 0;
-        if (s->status && !(s->status &= ~value))
-            qemu_irq_lower(s->irq);
+        }
+        if (s->status) {
+            s->status &= ~value;
+            if (!s->status) {
+                qemu_irq_lower(s->irq);
+            }
+        }
         break;

-    case 0x1c: /* TIER */
+    case 0x1c:  /* TIER */
         s->it_ena = value & 7;
         break;

-    case 0x20: /* TWER */
+    case 0x20:  /* TWER */
         s->wu_ena = value & 7;
         break;

-    case 0x24: /* TCLR */
+    case 0x24:  /* TCLR */
         omap_gp_timer_sync(s);
         s->inout = (value >> 14) & 1;
         s->capt2 = (value >> 13) & 1;
         s->pt = (value >> 12) & 1;
         s->trigger = (value >> 10) & 3;
         if (s->capture == gpt_capture_none &&
-                        ((value >> 8) & 3) != gpt_capture_none)
+                        ((value >> 8) & 3) != gpt_capture_none) {
             s->capt_num = 0;
+        }
         s->capture = (value >> 8) & 3;
         s->scpwm = (value >> 7) & 1;
         s->ce = (value >> 6) & 1;
@@ -399,39 +412,41 @@ static void omap_gp_timer_write(void *opaque, hwaddr
addr, uint32_t value)
         if (!s->inout && s->capture != gpt_capture_none)
             fprintf(stderr, "%s: GP timer pin must be an input "
                             "for this capture mode\n", __func__);
-        if (s->trigger == gpt_trigger_none)
+        if (s->trigger == gpt_trigger_none) {
             omap_gp_timer_out(s, s->scpwm);
+        }
         /* TODO: make sure this doesn't overflow 32-bits */
         s->ticks_per_sec = NANOSECONDS_PER_SECOND << (s->pre ? s->ptv + 1
: 0);
         omap_gp_timer_update(s);
         break;

-    case 0x28: /* TCRR */
+    case 0x28:  /* TCRR */
         s->time = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
         s->val = value;
         omap_gp_timer_update(s);
         break;

-    case 0x2c: /* TLDR */
+    case 0x2c:  /* TLDR */
         s->load_val = value;
         break;

-    case 0x30: /* TTGR */
+    case 0x30:  /* TTGR */
         s->time = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
         s->val = s->load_val;
         omap_gp_timer_update(s);
         break;

-    case 0x38: /* TMAR */
+    case 0x38:  /* TMAR */
         omap_gp_timer_sync(s);
         s->match_val = value;
         omap_gp_timer_update(s);
         break;

-    case 0x40: /* TSICR */
+    case 0x40:  /* TSICR */
         s->posted = (value >> 2) & 1;
-        if (value & 2) /* How much exactly are we supposed to reset? */
+        if (value & 2) { /* How much exactly are we supposed to reset? */
             omap_gp_timer_reset(s);
+        }
         break;

     default:
@@ -443,10 +458,11 @@ static void omap_gp_timer_writeh(void *opaque, hwaddr
addr, uint32_t value)
 {
     struct omap_gp_timer_s *s = opaque;

-    if (addr & 2)
+    if (addr & 2) {
         omap_gp_timer_write(opaque, addr, (value << 16) | s->writeh);
-    else
+    } else {
         s->writeh = (uint16_t) value;
+    }
 }

 static uint64_t omap_gp_timer_readfn(void *opaque, hwaddr addr,
diff --git a/hw/timer/omap_synctimer.c b/hw/timer/omap_synctimer.c
index d93a9344ed..645170c015 100644
--- a/hw/timer/omap_synctimer.c
+++ b/hw/timer/omap_synctimer.c
@@ -27,7 +27,8 @@ struct omap_synctimer_s {
 };

 /* 32-kHz Sync Timer of the OMAP2 */
-static uint32_t omap_synctimer_read(struct omap_synctimer_s *s) {
+static uint32_t omap_synctimer_read(struct omap_synctimer_s *s)
+{
     return muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), 0x8000,
                     NANOSECONDS_PER_SECOND);
 }
@@ -42,10 +43,10 @@ static uint32_t omap_synctimer_readw(void *opaque,
hwaddr addr)
     struct omap_synctimer_s *s = opaque;

     switch (addr) {
-    case 0x00: /* 32KSYNCNT_REV */
+    case 0x00:  /* 32KSYNCNT_REV */
         return 0x21;

-    case 0x10: /* CR */
+    case 0x10:  /* CR */
         return omap_synctimer_read(s) - s->val;
     }

diff --git a/hw/timer/pxa2xx_timer.c b/hw/timer/pxa2xx_timer.c
index 6479ab1a8b..040668631e 100644
--- a/hw/timer/pxa2xx_timer.c
+++ b/hw/timer/pxa2xx_timer.c
@@ -20,42 +20,42 @@
 #include "qom/object.h"
 #include "sysemu/watchdog.h"

-#define OSMR0 0x00
-#define OSMR1 0x04
-#define OSMR2 0x08
-#define OSMR3 0x0c
-#define OSMR4 0x80
-#define OSMR5 0x84
-#define OSMR6 0x88
-#define OSMR7 0x8c
-#define OSMR8 0x90
-#define OSMR9 0x94
-#define OSMR10 0x98
-#define OSMR11 0x9c
-#define OSCR 0x10 /* OS Timer Count */
-#define OSCR4 0x40
-#define OSCR5 0x44
-#define OSCR6 0x48
-#define OSCR7 0x4c
-#define OSCR8 0x50
-#define OSCR9 0x54
-#define OSCR10 0x58
-#define OSCR11 0x5c
-#define OSSR 0x14 /* Timer status register */
-#define OWER 0x18
-#define OIER 0x1c /* Interrupt enable register  3-0 to E3-E0 */
-#define OMCR4 0xc0 /* OS Match Control registers */
-#define OMCR5 0xc4
-#define OMCR6 0xc8
-#define OMCR7 0xcc
-#define OMCR8 0xd0
-#define OMCR9 0xd4
-#define OMCR10 0xd8
-#define OMCR11 0xdc
-#define OSNR 0x20
-
-#define PXA25X_FREQ 3686400 /* 3.6864 MHz */
-#define PXA27X_FREQ 3250000 /* 3.25 MHz */
+#define OSMR0   0x00
+#define OSMR1   0x04
+#define OSMR2   0x08
+#define OSMR3   0x0c
+#define OSMR4   0x80
+#define OSMR5   0x84
+#define OSMR6   0x88
+#define OSMR7   0x8c
+#define OSMR8   0x90
+#define OSMR9   0x94
+#define OSMR10  0x98
+#define OSMR11  0x9c
+#define OSCR    0x10  /* OS Timer Count */
+#define OSCR4   0x40
+#define OSCR5   0x44
+#define OSCR6   0x48
+#define OSCR7   0x4c
+#define OSCR8   0x50
+#define OSCR9   0x54
+#define OSCR10  0x58
+#define OSCR11  0x5c
+#define OSSR    0x14  /* Timer status register */
+#define OWER    0x18
+#define OIER    0x1c  /* Interrupt enable register  3-0 to E3-E0 */
+#define OMCR4   0xc0  /* OS Match Control registers */
+#define OMCR5   0xc4
+#define OMCR6   0xc8
+#define OMCR7   0xcc
+#define OMCR8   0xd0
+#define OMCR9   0xd4
+#define OMCR10  0xd8
+#define OMCR11  0xdc
+#define OSNR    0x20
+
+#define PXA25X_FREQ 3686400 /* 3.6864 MHz */
+#define PXA27X_FREQ 3250000 /* 3.25 MHz */

 static int pxa2xx_timer4_freq[8] = {
     [0] = 0,
@@ -108,7 +108,7 @@ struct PXA2xxTimerInfo {
     PXA2xxTimer4 tm4[8];
 };

-#define PXA2XX_TIMER_HAVE_TM4 0
+#define PXA2XX_TIMER_HAVE_TM4 0

 static inline int pxa2xx_timer_has_tm4(PXA2xxTimerInfo *s)
 {
@@ -125,7 +125,7 @@ static void pxa2xx_timer_update(void *opaque, uint64_t
now_qemu)
     now_vm = s->clock +
             muldiv64(now_qemu - s->lastload, s->freq,
NANOSECONDS_PER_SECOND);

-    for (i = 0; i < 4; i ++) {
+    for (i = 0; i < 4; i++) {
         new_qemu = now_qemu + muldiv64((uint32_t) (s->timer[i].value -
now_vm),
                         NANOSECONDS_PER_SECOND, s->freq);
         timer_mod(s->timer[i].qtimer, new_qemu);
@@ -141,10 +141,11 @@ static void pxa2xx_timer_update4(void *opaque,
uint64_t now_qemu, int n)
     int counter;

     assert(n < ARRAY_SIZE(counters));
-    if (s->tm4[n].control & (1 << 7))
+    if (s->tm4[n].control & (1 << 7)) {
         counter = n;
-    else
+    } else {
         counter = counters[n];
+    }

     if (!s->tm4[counter].freq) {
         timer_del(s->tm4[n].tm.qtimer);
@@ -167,52 +168,71 @@ static uint64_t pxa2xx_timer_read(void *opaque,
hwaddr offset,
     int tm = 0;

     switch (offset) {
-    case OSMR3:  tm ++;
+    case OSMR3:
+        tm++;
         /* fall through */
-    case OSMR2:  tm ++;
+    case OSMR2:
+        tm++;
         /* fall through */
-    case OSMR1:  tm ++;
+    case OSMR1:
+        tm++;
         /* fall through */
     case OSMR0:
         return s->timer[tm].value;
-    case OSMR11: tm ++;
+    case OSMR11:
+        tm++;
         /* fall through */
-    case OSMR10: tm ++;
+    case OSMR10:
+        tm++;
         /* fall through */
-    case OSMR9:  tm ++;
+    case OSMR9:
+        tm++;
         /* fall through */
-    case OSMR8:  tm ++;
+    case OSMR8:
+        tm++;
         /* fall through */
-    case OSMR7:  tm ++;
+    case OSMR7:
+        tm++;
         /* fall through */
-    case OSMR6:  tm ++;
+    case OSMR6:
+        tm++;
         /* fall through */
-    case OSMR5:  tm ++;
+    case OSMR5:
+        tm++;
         /* fall through */
     case OSMR4:
-        if (!pxa2xx_timer_has_tm4(s))
+        if (!pxa2xx_timer_has_tm4(s)) {
             goto badreg;
+        }
         return s->tm4[tm].tm.value;
     case OSCR:
         return s->clock + muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) -
                         s->lastload, s->freq, NANOSECONDS_PER_SECOND);
-    case OSCR11: tm ++;
+    case OSCR11:
+        tm++;
         /* fall through */
-    case OSCR10: tm ++;
+    case OSCR10:
+        tm++;
         /* fall through */
-    case OSCR9:  tm ++;
+    case OSCR9:
+        tm++;
         /* fall through */
-    case OSCR8:  tm ++;
+    case OSCR8:
+        tm++;
         /* fall through */
-    case OSCR7:  tm ++;
+    case OSCR7:
+        tm++;
         /* fall through */
-    case OSCR6:  tm ++;
+    case OSCR6:
+        tm++;
         /* fall through */
-    case OSCR5:  tm ++;
+    case OSCR5:
+        tm++;
         /* fall through */
     case OSCR4:
-        if (!pxa2xx_timer_has_tm4(s))
+        if (!pxa2xx_timer_has_tm4(s)) {
             goto badreg;
+        }

         if ((tm == 9 - 4 || tm == 11 - 4) && (s->tm4[tm].control & (1 <<
9))) {
             if (s->tm4[tm - 1].freq)
@@ -224,35 +244,44 @@ static uint64_t pxa2xx_timer_read(void *opaque,
hwaddr offset,
                 s->snapshot = s->tm4[tm - 1].clock;
         }

-        if (!s->tm4[tm].freq)
+        if (!s->tm4[tm].freq) {
             return s->tm4[tm].clock;
+        }
         return s->tm4[tm].clock +
             muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) -
                      s->tm4[tm].lastload, s->tm4[tm].freq,
                      NANOSECONDS_PER_SECOND);
     case OIER:
         return s->irq_enabled;
-    case OSSR: /* Status register */
+    case OSSR:  /* Status register */
         return s->events;
     case OWER:
         return s->reset3;
-    case OMCR11: tm ++;
+    case OMCR11:
+        tm++;
         /* fall through */
-    case OMCR10: tm ++;
+    case OMCR10:
+        tm++;
         /* fall through */
-    case OMCR9:  tm ++;
+    case OMCR9:
+        tm++;
         /* fall through */
-    case OMCR8:  tm ++;
+    case OMCR8:
+        tm++;
         /* fall through */
-    case OMCR7:  tm ++;
+    case OMCR7:
+        tm++;
         /* fall through */
-    case OMCR6:  tm ++;
+    case OMCR6:
+        tm++;
         /* fall through */
-    case OMCR5:  tm ++;
+    case OMCR5:
+        tm++;
         /* fall through */
     case OMCR4:
-        if (!pxa2xx_timer_has_tm4(s))
+        if (!pxa2xx_timer_has_tm4(s)) {
             goto badreg;
+        }
         return s->tm4[tm].control;
     case OSNR:
         return s->snapshot;
@@ -277,33 +306,44 @@ static void pxa2xx_timer_write(void *opaque, hwaddr
offset,
     PXA2xxTimerInfo *s = (PXA2xxTimerInfo *) opaque;

     switch (offset) {
-    case OSMR3:  tm ++;
+    case OSMR3:
+        tm++;
         /* fall through */
-    case OSMR2:  tm ++;
+    case OSMR2:
+        tm++;
         /* fall through */
-    case OSMR1:  tm ++;
+    case OSMR1:
+        tm++;
         /* fall through */
     case OSMR0:
         s->timer[tm].value = value;
         pxa2xx_timer_update(s, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
         break;
-    case OSMR11: tm ++;
+    case OSMR11:
+        tm++;
         /* fall through */
-    case OSMR10: tm ++;
+    case OSMR10:
+        tm++;
         /* fall through */
-    case OSMR9:  tm ++;
+    case OSMR9:
+        tm++;
         /* fall through */
-    case OSMR8:  tm ++;
+    case OSMR8:
+        tm++;
         /* fall through */
-    case OSMR7:  tm ++;
+    case OSMR7:
+        tm++;
         /* fall through */
-    case OSMR6:  tm ++;
+    case OSMR6:
+        tm++;
         /* fall through */
-    case OSMR5:  tm ++;
+    case OSMR5:
+        tm++;
         /* fall through */
     case OSMR4:
-        if (!pxa2xx_timer_has_tm4(s))
+        if (!pxa2xx_timer_has_tm4(s)) {
             goto badreg;
+        }
         s->tm4[tm].tm.value = value;
         pxa2xx_timer_update4(s, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), tm);
         break;
@@ -313,23 +353,31 @@ static void pxa2xx_timer_write(void *opaque, hwaddr
offset,
         s->clock = value;
         pxa2xx_timer_update(s, s->lastload);
         break;
-    case OSCR11: tm ++;
+    case OSCR11:
+        tm++;
         /* fall through */
-    case OSCR10: tm ++;
+    case OSCR10:
+        tm++;
         /* fall through */
-    case OSCR9:  tm ++;
+    case OSCR9:
+        tm++;
         /* fall through */
-    case OSCR8:  tm ++;
+    case OSCR8:
+        tm++;
         /* fall through */
-    case OSCR7:  tm ++;
+    case OSCR7:
+        tm++;
         /* fall through */
-    case OSCR6:  tm ++;
+    case OSCR6:
+        tm++;
         /* fall through */
-    case OSCR5:  tm ++;
+    case OSCR5:
+        tm++;
         /* fall through */
     case OSCR4:
-        if (!pxa2xx_timer_has_tm4(s))
+        if (!pxa2xx_timer_has_tm4(s)) {
             goto badreg;
+        }
         s->tm4[tm].oldclock = s->tm4[tm].clock;
         s->tm4[tm].lastload = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
         s->tm4[tm].clock = value;
@@ -338,27 +386,33 @@ static void pxa2xx_timer_write(void *opaque, hwaddr
offset,
     case OIER:
         s->irq_enabled = value & 0xfff;
         break;
-    case OSSR: /* Status register */
+    case OSSR:  /* Status register */
         value &= s->events;
         s->events &= ~value;
-        for (i = 0; i < 4; i ++, value >>= 1)
-            if (value & 1)
+        for (i = 0; i < 4; i++, value >>= 1)
+            if (value & 1) {
                 qemu_irq_lower(s->timer[i].irq);
-        if (pxa2xx_timer_has_tm4(s) && !(s->events & 0xff0) && value)
+            }
+        if (pxa2xx_timer_has_tm4(s) && !(s->events & 0xff0) && value) {
             qemu_irq_lower(s->irq4);
+        }
         break;
-    case OWER: /* XXX: Reset on OSMR3 match? */
+    case OWER:  /* XXX: Reset on OSMR3 match? */
         s->reset3 = value;
         break;
-    case OMCR7:  tm ++;
+    case OMCR7:
+        tm++;
         /* fall through */
-    case OMCR6:  tm ++;
+    case OMCR6:
+        tm++;
         /* fall through */
-    case OMCR5:  tm ++;
+    case OMCR5:
+        tm++;
         /* fall through */
     case OMCR4:
-        if (!pxa2xx_timer_has_tm4(s))
+        if (!pxa2xx_timer_has_tm4(s)) {
             goto badreg;
+        }
         s->tm4[tm].control = value & 0x0ff;
         /* XXX Stop if running (shouldn't happen) */
         if ((value & (1 << 7)) || tm == 0)
@@ -368,15 +422,20 @@ static void pxa2xx_timer_write(void *opaque, hwaddr
offset,
             pxa2xx_timer_update4(s, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
tm);
         }
         break;
-    case OMCR11: tm ++;
+    case OMCR11:
+        tm++;
         /* fall through */
-    case OMCR10: tm ++;
+    case OMCR10:
+        tm++;
         /* fall through */
-    case OMCR9:  tm ++;
+    case OMCR9:
+        tm++;
         /* fall through */
-    case OMCR8:  tm += 4;
-        if (!pxa2xx_timer_has_tm4(s))
+    case OMCR8:
+        tm += 4;
+        if (!pxa2xx_timer_has_tm4(s)) {
             goto badreg;
+        }
         s->tm4[tm].control = value & 0x3ff;
         /* XXX Stop if running (shouldn't happen) */
         if ((value & (1 << 7)) || !(tm & 1))
@@ -428,12 +487,15 @@ static void pxa2xx_timer_tick4(void *opaque)
     PXA2xxTimerInfo *i = (PXA2xxTimerInfo *) t->tm.info;

     pxa2xx_timer_tick(&t->tm);
-    if (t->control & (1 << 3))
+    if (t->control & (1 << 3)) {
         t->clock = 0;
-    if (t->control & (1 << 6))
+    }
+    if (t->control & (1 << 6)) {
         pxa2xx_timer_update4(i, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
t->tm.num - 4);
-    if (i->events & 0xff0)
+    }
+    if (i->events & 0xff0) {
         qemu_irq_raise(i->irq4);
+    }
 }

 static int pxa25x_timer_post_load(void *opaque, int version_id)
@@ -446,8 +508,9 @@ static int pxa25x_timer_post_load(void *opaque, int
version_id)
     pxa2xx_timer_update(s, now);

     if (pxa2xx_timer_has_tm4(s))
-        for (i = 0; i < 8; i ++)
+        for (i = 0; i < 8; i++) {
             pxa2xx_timer_update4(s, now, i);
+        }

     return 0;
 }
@@ -474,7 +537,7 @@ static void pxa2xx_timer_realize(DeviceState *dev,
Error **errp)
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     int i;

-    for (i = 0; i < 4; i ++) {
+    for (i = 0; i < 4; i++) {
         s->timer[i].value = 0;
         sysbus_init_irq(sbd, &s->timer[i].irq);
         s->timer[i].info = s;
@@ -486,7 +549,7 @@ static void pxa2xx_timer_realize(DeviceState *dev,
Error **errp)
     if (s->flags & (1 << PXA2XX_TIMER_HAVE_TM4)) {
         sysbus_init_irq(sbd, &s->irq4);

-        for (i = 0; i < 8; i ++) {
+        for (i = 0; i < 8; i++) {
             s->tm4[i].tm.value = 0;
             s->tm4[i].tm.info = s;
             s->tm4[i].tm.num = i + 4;
diff --git a/include/hw/arm/pxa.h b/include/hw/arm/pxa.h
index 4c6caee113..9c6d434a4b 100644
--- a/include/hw/arm/pxa.h
+++ b/include/hw/arm/pxa.h
@@ -16,57 +16,57 @@
 #include "qom/object.h"

 /* Interrupt numbers */
-# define PXA2XX_PIC_SSP3 0
-# define PXA2XX_PIC_USBH2 2
-# define PXA2XX_PIC_USBH1 3
-# define PXA2XX_PIC_KEYPAD 4
-# define PXA2XX_PIC_PWRI2C 6
-# define PXA25X_PIC_HWUART 7
-# define PXA27X_PIC_OST_4_11 7
-# define PXA2XX_PIC_GPIO_0 8
-# define PXA2XX_PIC_GPIO_1 9
-# define PXA2XX_PIC_GPIO_X 10
-# define PXA2XX_PIC_I2S 13
-# define PXA26X_PIC_ASSP 15
-# define PXA25X_PIC_NSSP 16
-# define PXA27X_PIC_SSP2 16
-# define PXA2XX_PIC_LCD 17
-# define PXA2XX_PIC_I2C 18
-# define PXA2XX_PIC_ICP 19
-# define PXA2XX_PIC_STUART 20
-# define PXA2XX_PIC_BTUART 21
-# define PXA2XX_PIC_FFUART 22
-# define PXA2XX_PIC_MMC 23
-# define PXA2XX_PIC_SSP 24
-# define PXA2XX_PIC_DMA 25
-# define PXA2XX_PIC_OST_0 26
-# define PXA2XX_PIC_RTC1HZ 30
-# define PXA2XX_PIC_RTCALARM 31
+# define PXA2XX_PIC_SSP3        0
+# define PXA2XX_PIC_USBH2       2
+# define PXA2XX_PIC_USBH1       3
+# define PXA2XX_PIC_KEYPAD      4
+# define PXA2XX_PIC_PWRI2C      6
+# define PXA25X_PIC_HWUART      7
+# define PXA27X_PIC_OST_4_11    7
+# define PXA2XX_PIC_GPIO_0      8
+# define PXA2XX_PIC_GPIO_1      9
+# define PXA2XX_PIC_GPIO_X      10
+# define PXA2XX_PIC_I2S         13
+# define PXA26X_PIC_ASSP        15
+# define PXA25X_PIC_NSSP        16
+# define PXA27X_PIC_SSP2        16
+# define PXA2XX_PIC_LCD         17
+# define PXA2XX_PIC_I2C         18
+# define PXA2XX_PIC_ICP         19
+# define PXA2XX_PIC_STUART      20
+# define PXA2XX_PIC_BTUART      21
+# define PXA2XX_PIC_FFUART      22
+# define PXA2XX_PIC_MMC         23
+# define PXA2XX_PIC_SSP         24
+# define PXA2XX_PIC_DMA         25
+# define PXA2XX_PIC_OST_0       26
+# define PXA2XX_PIC_RTC1HZ      30
+# define PXA2XX_PIC_RTCALARM    31

 /* DMA requests */
-# define PXA2XX_RX_RQ_I2S 2
-# define PXA2XX_TX_RQ_I2S 3
-# define PXA2XX_RX_RQ_BTUART 4
-# define PXA2XX_TX_RQ_BTUART 5
-# define PXA2XX_RX_RQ_FFUART 6
-# define PXA2XX_TX_RQ_FFUART 7
-# define PXA2XX_RX_RQ_SSP1 13
-# define PXA2XX_TX_RQ_SSP1 14
-# define PXA2XX_RX_RQ_SSP2 15
-# define PXA2XX_TX_RQ_SSP2 16
-# define PXA2XX_RX_RQ_ICP 17
-# define PXA2XX_TX_RQ_ICP 18
-# define PXA2XX_RX_RQ_STUART 19
-# define PXA2XX_TX_RQ_STUART 20
-# define PXA2XX_RX_RQ_MMCI 21
-# define PXA2XX_TX_RQ_MMCI 22
-# define PXA2XX_USB_RQ(x) ((x) + 24)
-# define PXA2XX_RX_RQ_SSP3 66
-# define PXA2XX_TX_RQ_SSP3 67
-
-# define PXA2XX_SDRAM_BASE 0xa0000000
-# define PXA2XX_INTERNAL_BASE 0x5c000000
-# define PXA2XX_INTERNAL_SIZE 0x40000
+# define PXA2XX_RX_RQ_I2S       2
+# define PXA2XX_TX_RQ_I2S       3
+# define PXA2XX_RX_RQ_BTUART    4
+# define PXA2XX_TX_RQ_BTUART    5
+# define PXA2XX_RX_RQ_FFUART    6
+# define PXA2XX_TX_RQ_FFUART    7
+# define PXA2XX_RX_RQ_SSP1      13
+# define PXA2XX_TX_RQ_SSP1      14
+# define PXA2XX_RX_RQ_SSP2      15
+# define PXA2XX_TX_RQ_SSP2      16
+# define PXA2XX_RX_RQ_ICP       17
+# define PXA2XX_TX_RQ_ICP       18
+# define PXA2XX_RX_RQ_STUART    19
+# define PXA2XX_TX_RQ_STUART    20
+# define PXA2XX_RX_RQ_MMCI      21
+# define PXA2XX_TX_RQ_MMCI      22
+# define PXA2XX_USB_RQ(x)       ((x) + 24)
+# define PXA2XX_RX_RQ_SSP3      66
+# define PXA2XX_TX_RQ_SSP3      67
+
+# define PXA2XX_SDRAM_BASE      0xa0000000
+# define PXA2XX_INTERNAL_BASE   0x5c000000
+# define PXA2XX_INTERNAL_SIZE   0x40000

 /* pxa2xx_pic.c */
 DeviceState *pxa2xx_pic_init(hwaddr base, ARMCPU *cpu);
@@ -189,7 +189,7 @@ struct PXA2xxI2SState {
     uint32_t fifo[16];
 };

-# define PA_FMT "0x%08lx"
+# define PA_FMT                 "0x%08lx"

 PXA2xxState *pxa270_init(unsigned int sdram_size, const char *revision);
 PXA2xxState *pxa255_init(unsigned int sdram_size);
diff --git a/include/hw/arm/sharpsl.h b/include/hw/arm/sharpsl.h
index e986b28c52..7e5e7ca60b 100644
--- a/include/hw/arm/sharpsl.h
+++ b/include/hw/arm/sharpsl.h
@@ -11,7 +11,7 @@

 /* zaurus.c */

-#define SL_PXA_PARAM_BASE 0xa0000a00
+#define SL_PXA_PARAM_BASE       0xa0000a00
 void sl_bootparam_write(hwaddr ptr);

 #endif
diff --git a/include/hw/arm/soc_dma.h b/include/hw/arm/soc_dma.h
index e93a7499a8..bcdb91425a 100644
--- a/include/hw/arm/soc_dma.h
+++ b/include/hw/arm/soc_dma.h
@@ -54,7 +54,7 @@ struct soc_dma_ch_s {
     int bytes;
     /* Initialised by the DMA module, call soc_dma_ch_update after
writing.  */
     enum soc_dma_access_type type[2];
-    hwaddr vaddr[2]; /* Updated by .transfer_fn().  */
+    hwaddr vaddr[2];    /* Updated by .transfer_fn().  */
     /* Private */
     void *paddr[2];
     soc_dma_io_t io_fn[2];
@@ -70,7 +70,7 @@ struct soc_dma_ch_s {
 struct soc_dma_s {
     /* Following fields are set by the SoC DMA module and can be used
      * by anybody.  */
-    uint64_t drqbmp; /* Is zeroed by soc_dma_reset() */
+    uint64_t drqbmp;    /* Is zeroed by soc_dma_reset() */
     qemu_irq *drq;
     void *opaque;
     int64_t freq;
diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
index a43875cb09..9a07372fd9 100644
--- a/tcg/arm/tcg-target.h
+++ b/tcg/arm/tcg-target.h
@@ -86,8 +86,8 @@ extern bool use_neon_instructions;
 #endif

 /* used for function call generation */
-#define TCG_TARGET_STACK_ALIGN 8
-#define TCG_TARGET_CALL_STACK_OFFSET 0
+#define TCG_TARGET_STACK_ALIGN          8
+#define TCG_TARGET_CALL_STACK_OFFSET    0
 #define TCG_TARGET_CALL_ARG_I32         TCG_CALL_ARG_NORMAL
 #define TCG_TARGET_CALL_ARG_I64         TCG_CALL_ARG_EVEN
 #define TCG_TARGET_CALL_ARG_I128        TCG_CALL_ARG_EVEN
-- 
2.43.0

--000000000000c6e3b70617c3118c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Hi,<br><br></div>I have added a patch inlin=
e that fixes indentation and formatting for some files as listed in <a href=
=3D"https://gitlab.com/qemu-project/qemu/-/issues/373" target=3D"_blank">ht=
tps://gitlab.com/qemu-project/qemu/-/issues/373</a>.<br><br></div>Thanks,<b=
r></div>Tanmay<br><br>From 46026574821c46804111eea6607a1b39314b7abe Mon Sep=
 17 00:00:00 2001<br>From: Tanmay Patil &lt;<a href=3D"mailto:tanmaynpatil1=
05@gmail.com">tanmaynpatil105@gmail.com</a>&gt;<br>Date: Sat, 25 Nov 2023 0=
0:53:54 +0530<br>Subject: [PATCH] Fixes: Indentation using TABs and improve=
 formatting<br>=C2=A0Resolves: <a href=3D"https://gitlab.com/qemu-project/q=
emu/-/issues/373">https://gitlab.com/qemu-project/qemu/-/issues/373</a><br>=
<br>=C2=A0 =C2=A0Files changed:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 - hw/arm/boo=
t.c<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 - hw/char/omap_uart.c<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 - hw/dma/pxa2xx_dma.c<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 - hw/gpi=
o/omap_gpio.c<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 - hw/gpio/zaurus.c<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 - hw/input/tsc2005.c<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 - =
hw/input/tsc210x.c<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 - hw/intc/omap_intc.c<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 - hw/misc/cbus.c<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 - hw/misc/omap_clk.c<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 - hw/misc/omap_l4.c<br=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 - hw/misc/omap_sdrc.c<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 - hw/misc/omap_tap.c<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 - hw/sd/omap_mmc=
.c<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 - hw/sd/pxa2xx_mmci.c<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 - hw/timer/omap_gptimer.c<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 - hw=
/timer/omap_synctimer.c<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 - hw/timer/pxa2xx_ti=
mer.c<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 - include/hw/arm/pxa.h<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 - include/hw/arm/sharpsl.h<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 - include/hw/arm/soc_dma.h<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 - tcg/arm/tcg-ta=
rget.h<br><br>Signed-off-by: Tanmay Patil &lt;<a href=3D"mailto:tanmaynpati=
l105@gmail.com">tanmaynpatil105@gmail.com</a>&gt;<br>---<br>=C2=A0hw/arm/bo=
ot.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 8 +-<br>=C2=A0hw/ch=
ar/omap_uart.c =C2=A0 =C2=A0 =C2=A0 | =C2=A049 +-<br>=C2=A0hw/dma/pxa2xx_dm=
a.c =C2=A0 =C2=A0 =C2=A0 | 198 ++++----<br>=C2=A0hw/gpio/omap_gpio.c =C2=A0=
 =C2=A0 =C2=A0 | 243 +++++-----<br>=C2=A0hw/gpio/zaurus.c =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| =C2=A061 +--<br>=C2=A0hw/input/tsc2005.c =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| 130 ++---<br>=C2=A0hw/input/tsc210x.c =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 442 +++++++++--------<br>=C2=A0hw/intc/omap_intc.c =C2=A0 =C2=A0 =
=C2=A0 | 261 +++++-----<br>=C2=A0hw/misc/cbus.c =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0| 202 ++++----<br>=C2=A0hw/misc/omap_clk.c =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| 999 +++++++++++++++++++-------------------<br>=C2=A0hw/misc/oma=
p_l4.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A021 +-<br>=C2=A0hw/misc/omap_sdrc=
.c =C2=A0 =C2=A0 =C2=A0 | 135 +++---<br>=C2=A0hw/misc/omap_tap.c =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| =C2=A028 +-<br>=C2=A0hw/sd/omap_mmc.c =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| 208 ++++----<br>=C2=A0hw/sd/pxa2xx_mmci.c =C2=A0 =C2=A0 =
=C2=A0 | 149 +++---<br>=C2=A0hw/timer/omap_gptimer.c =C2=A0 | 126 ++---<br>=
=C2=A0hw/timer/omap_synctimer.c | =C2=A0 7 +-<br>=C2=A0hw/timer/pxa2xx_time=
r.c =C2=A0 | 279 ++++++-----<br>=C2=A0include/hw/arm/pxa.h =C2=A0 =C2=A0 =
=C2=A0| 100 ++--<br>=C2=A0include/hw/arm/sharpsl.h =C2=A0| =C2=A0 2 +-<br>=
=C2=A0include/hw/arm/soc_dma.h =C2=A0| =C2=A0 4 +-<br>=C2=A0tcg/arm/tcg-tar=
get.h =C2=A0 =C2=A0 =C2=A0| =C2=A0 4 +-<br>=C2=A022 files changed, 1903 ins=
ertions(+), 1753 deletions(-)<br><br>diff --git a/hw/arm/boot.c b/hw/arm/bo=
ot.c<br>index 84ea6a807a..d480a7da02 100644<br>--- a/hw/arm/boot.c<br>+++ b=
/hw/arm/boot.c<br>@@ -347,13 +347,13 @@ static void set_kernel_args_old(con=
st struct arm_boot_info *info,<br>=C2=A0 =C2=A0 =C2=A0WRITE_WORD(p, info-&g=
t;ram_size / 4096);<br>=C2=A0 =C2=A0 =C2=A0/* ramdisk_size */<br>=C2=A0 =C2=
=A0 =C2=A0WRITE_WORD(p, 0);<br>-#define FLAG_READONLY	1<br>-#define FLAG_RD=
LOAD	4<br>-#define FLAG_RDPROMPT	8<br>+#define FLAG_READONLY 1<br>+#define =
FLAG_RDLOAD =C2=A0 4<br>+#define FLAG_RDPROMPT 8<br>=C2=A0 =C2=A0 =C2=A0/* =
flags */<br>=C2=A0 =C2=A0 =C2=A0WRITE_WORD(p, FLAG_READONLY | FLAG_RDLOAD |=
 FLAG_RDPROMPT);<br>=C2=A0 =C2=A0 =C2=A0/* rootdev */<br>- =C2=A0 =C2=A0WRI=
TE_WORD(p, (31 &lt;&lt; 8) | 0);	/* /dev/mtdblock0 */<br>+ =C2=A0 =C2=A0WRI=
TE_WORD(p, (31 &lt;&lt; 8) | 0); /* /dev/mtdblock0 */<br>=C2=A0 =C2=A0 =C2=
=A0/* video_num_cols */<br>=C2=A0 =C2=A0 =C2=A0WRITE_WORD(p, 0);<br>=C2=A0 =
=C2=A0 =C2=A0/* video_num_rows */<br>diff --git a/hw/char/omap_uart.c b/hw/=
char/omap_uart.c<br>index 6848bddb4e..c2ef4c137e 100644<br>--- a/hw/char/om=
ap_uart.c<br>+++ b/hw/char/omap_uart.c<br>@@ -61,7 +61,7 @@ struct omap_uar=
t_s *omap_uart_init(hwaddr base,<br>=C2=A0 =C2=A0 =C2=A0s-&gt;fclk =3D fclk=
;<br>=C2=A0 =C2=A0 =C2=A0s-&gt;irq =3D irq;<br>=C2=A0 =C2=A0 =C2=A0s-&gt;se=
rial =3D serial_mm_init(get_system_memory(), base, 2, irq,<br>- =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 omap_clk_getrate(fclk)/16,<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 omap_clk_getrate(fclk) / 16,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 chr ?: qemu_chr_new(label, &quot;null&quot;, NULL),<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 DEVICE_NATIVE_ENDIAN);<br>=C2=A0 =C2=A0 =C2=A0retu=
rn s;<br>@@ -76,27 +76,27 @@ static uint64_t omap_uart_read(void *opaque, h=
waddr addr, unsigned size)<br>=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0<br>=C2=A0 =C2=
=A0 =C2=A0switch (addr) {<br>- =C2=A0 =C2=A0case 0x20:	/* MDR1 */<br>+ =C2=
=A0 =C2=A0case 0x20: =C2=A0/* MDR1 */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
return s-&gt;mdr[0];<br>- =C2=A0 =C2=A0case 0x24:	/* MDR2 */<br>+ =C2=A0 =
=C2=A0case 0x24: =C2=A0/* MDR2 */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retu=
rn s-&gt;mdr[1];<br>- =C2=A0 =C2=A0case 0x40:	/* SCR */<br>+ =C2=A0 =C2=A0c=
ase 0x40: =C2=A0/* SCR */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return s-&gt=
;scr;<br>- =C2=A0 =C2=A0case 0x44:	/* SSR */<br>+ =C2=A0 =C2=A0case 0x44: =
=C2=A0/* SSR */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0x0;<br>- =C2=
=A0 =C2=A0case 0x48:	/* EBLR (OMAP2) */<br>+ =C2=A0 =C2=A0case 0x48: =C2=A0=
/* EBLR (OMAP2) */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return s-&gt;eblr;<=
br>- =C2=A0 =C2=A0case 0x4C:	/* OSC_12M_SEL (OMAP1) */<br>+ =C2=A0 =C2=A0ca=
se 0x4C: =C2=A0/* OSC_12M_SEL (OMAP1) */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0return s-&gt;clksel;<br>- =C2=A0 =C2=A0case 0x50:	/* MVR */<br>+ =C2=A0 =
=C2=A0case 0x50: =C2=A0/* MVR */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retur=
n 0x30;<br>- =C2=A0 =C2=A0case 0x54:	/* SYSC (OMAP2) */<br>+ =C2=A0 =C2=A0c=
ase 0x54: =C2=A0/* SYSC (OMAP2) */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret=
urn s-&gt;syscontrol;<br>- =C2=A0 =C2=A0case 0x58:	/* SYSS (OMAP2) */<br>+ =
=C2=A0 =C2=A0case 0x58: =C2=A0/* SYSS (OMAP2) */<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return 1;<br>- =C2=A0 =C2=A0case 0x5c:	/* WER (OMAP2) */<br>+ =
=C2=A0 =C2=A0case 0x5c: =C2=A0/* WER (OMAP2) */<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return s-&gt;wkup;<br>- =C2=A0 =C2=A0case 0x60:	/* CFPS (OMAP2) *=
/<br>+ =C2=A0 =C2=A0case 0x60: =C2=A0/* CFPS (OMAP2) */<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0return s-&gt;cfps;<br>=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0<b=
r>@@ -115,35 +115,36 @@ static void omap_uart_write(void *opaque, hwaddr ad=
dr,<br>=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0switch (addr)=
 {<br>- =C2=A0 =C2=A0case 0x20:	/* MDR1 */<br>+ =C2=A0 =C2=A0case 0x20: =C2=
=A0/* MDR1 */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;mdr[0] =3D value &=
amp; 0x7f;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>- =C2=A0 =C2=A0ca=
se 0x24:	/* MDR2 */<br>+ =C2=A0 =C2=A0case 0x24: =C2=A0/* MDR2 */<br>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;mdr[1] =3D value &amp; 0xff;<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>- =C2=A0 =C2=A0case 0x40:	/* SCR */<br=
>+ =C2=A0 =C2=A0case 0x40: =C2=A0/* SCR */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0s-&gt;scr =3D value &amp; 0xff;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
break;<br>- =C2=A0 =C2=A0case 0x48:	/* EBLR (OMAP2) */<br>+ =C2=A0 =C2=A0ca=
se 0x48: =C2=A0/* EBLR (OMAP2) */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&g=
t;eblr =3D value &amp; 0xff;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br=
>- =C2=A0 =C2=A0case 0x4C:	/* OSC_12M_SEL (OMAP1) */<br>+ =C2=A0 =C2=A0case=
 0x4C: =C2=A0/* OSC_12M_SEL (OMAP1) */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0s-&gt;clksel =3D value &amp; 1;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bre=
ak;<br>- =C2=A0 =C2=A0case 0x44:	/* SSR */<br>- =C2=A0 =C2=A0case 0x50:	/* =
MVR */<br>- =C2=A0 =C2=A0case 0x58:	/* SYSS (OMAP2) */<br>+ =C2=A0 =C2=A0ca=
se 0x44: =C2=A0/* SSR */<br>+ =C2=A0 =C2=A0case 0x50: =C2=A0/* MVR */<br>+ =
=C2=A0 =C2=A0case 0x58: =C2=A0/* SYSS (OMAP2) */<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0OMAP_RO_REG(addr);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;=
<br>- =C2=A0 =C2=A0case 0x54:	/* SYSC (OMAP2) */<br>+ =C2=A0 =C2=A0case 0x5=
4: =C2=A0/* SYSC (OMAP2) */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;sysc=
ontrol =3D value &amp; 0x1d;<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if (value &amp=
; 2)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (value &amp; 2) {<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0omap_uart_reset(s);<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>- =C2=A0 =C2=
=A0case 0x5c:	/* WER (OMAP2) */<br>+ =C2=A0 =C2=A0case 0x5c: =C2=A0/* WER (=
OMAP2) */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;wkup =3D value &amp; 0=
x7f;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>- =C2=A0 =C2=A0case 0x6=
0:	/* CFPS (OMAP2) */<br>+ =C2=A0 =C2=A0case 0x60: =C2=A0/* CFPS (OMAP2) */=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;cfps =3D value &amp; 0xff;<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>=C2=A0 =C2=A0 =C2=A0default:<br=
>diff --git a/hw/dma/pxa2xx_dma.c b/hw/dma/pxa2xx_dma.c<br>index 9f62f0b633=
..beed1cd9a5 100644<br>--- a/hw/dma/pxa2xx_dma.c<br>+++ b/hw/dma/pxa2xx_dma=
.c<br>@@ -61,98 +61,104 @@ struct PXA2xxDMAState {<br>=C2=A0 =C2=A0 =C2=A0i=
nt running;<br>=C2=A0};<br>=C2=A0<br>-#define DCSR0	0x0000	/* DMA Control /=
 Status register for Channel 0 */<br>-#define DCSR31	0x007c	/* DMA Control =
/ Status register for Channel 31 */<br>-#define DALGN	0x00a0	/* DMA Alignme=
nt register */<br>-#define DPCSR	0x00a4	/* DMA Programmed I/O Control Statu=
s register */<br>-#define DRQSR0	0x00e0	/* DMA DREQ&lt;0&gt; Status registe=
r */<br>-#define DRQSR1	0x00e4	/* DMA DREQ&lt;1&gt; Status register */<br>-=
#define DRQSR2	0x00e8	/* DMA DREQ&lt;2&gt; Status register */<br>-#define D=
INT	0x00f0	/* DMA Interrupt register */<br>-#define DRCMR0	0x0100	/* Reques=
t to Channel Map register 0 */<br>-#define DRCMR63	0x01fc	/* Request to Cha=
nnel Map register 63 */<br>-#define D_CH0	0x0200	/* Channel 0 Descriptor st=
art */<br>-#define DRCMR64	0x1100	/* Request to Channel Map register 64 */<=
br>-#define DRCMR74	0x1128	/* Request to Channel Map register 74 */<br>+#de=
fine DCSR0 =C2=A0 0x0000 =C2=A0/* DMA Control / Status register for Channel=
 0 */<br>+#define DCSR31 =C2=A00x007c =C2=A0/* DMA Control / Status registe=
r for Channel 31 */<br>+#define DALGN =C2=A0 0x00a0 =C2=A0/* DMA Alignment =
register */<br>+#define DPCSR =C2=A0 0x00a4 =C2=A0/* DMA Programmed I/O Con=
trol Status register */<br>+#define DRQSR0 =C2=A00x00e0 =C2=A0/* DMA DREQ&l=
t;0&gt; Status register */<br>+#define DRQSR1 =C2=A00x00e4 =C2=A0/* DMA DRE=
Q&lt;1&gt; Status register */<br>+#define DRQSR2 =C2=A00x00e8 =C2=A0/* DMA =
DREQ&lt;2&gt; Status register */<br>+#define DINT =C2=A0 =C2=A00x00f0 =C2=
=A0/* DMA Interrupt register */<br>+#define DRCMR0 =C2=A00x0100 =C2=A0/* Re=
quest to Channel Map register 0 */<br>+#define DRCMR63 0x01fc =C2=A0/* Requ=
est to Channel Map register 63 */<br>+#define D_CH0 =C2=A0 0x0200 =C2=A0/* =
Channel 0 Descriptor start */<br>+#define DRCMR64 0x1100 =C2=A0/* Request t=
o Channel Map register 64 */<br>+#define DRCMR74 0x1128 =C2=A0/* Request to=
 Channel Map register 74 */<br>=C2=A0<br>=C2=A0/* Per-channel register */<b=
r>-#define DDADR	0x00<br>-#define DSADR	0x01<br>-#define DTADR	0x02<br>-#de=
fine DCMD	0x03<br>+#define DDADR 0x00<br>+#define DSADR 0x01<br>+#define DT=
ADR 0x02<br>+#define DCMD =C2=A00x03<br>=C2=A0<br>=C2=A0/* Bit-field masks =
*/<br>-#define DRCMR_CHLNUM		0x1f<br>-#define DRCMR_MAPVLD		(1 &lt;&lt; 7)<=
br>-#define DDADR_STOP		(1 &lt;&lt; 0)<br>-#define DDADR_BREN		(1 &lt;&lt; =
1)<br>-#define DCMD_LEN		0x1fff<br>-#define DCMD_WIDTH(x)		(1 &lt;&lt; ((((=
x) &gt;&gt; 14) &amp; 3) - 1))<br>-#define DCMD_SIZE(x)		(4 &lt;&lt; (((x) =
&gt;&gt; 16) &amp; 3))<br>-#define DCMD_FLYBYT		(1 &lt;&lt; 19)<br>-#define=
 DCMD_FLYBYS		(1 &lt;&lt; 20)<br>-#define DCMD_ENDIRQEN		(1 &lt;&lt; 21)<br=
>-#define DCMD_STARTIRQEN		(1 &lt;&lt; 22)<br>-#define DCMD_CMPEN		(1 &lt;&=
lt; 25)<br>-#define DCMD_FLOWTRG		(1 &lt;&lt; 28)<br>-#define DCMD_FLOWSRC	=
	(1 &lt;&lt; 29)<br>-#define DCMD_INCTRGADDR		(1 &lt;&lt; 30)<br>-#define D=
CMD_INCSRCADDR		(1 &lt;&lt; 31)<br>-#define DCSR_BUSERRINTR		(1 &lt;&lt; 0)=
<br>-#define DCSR_STARTINTR		(1 &lt;&lt; 1)<br>-#define DCSR_ENDINTR		(1 &l=
t;&lt; 2)<br>-#define DCSR_STOPINTR		(1 &lt;&lt; 3)<br>-#define DCSR_RASINT=
R		(1 &lt;&lt; 4)<br>-#define DCSR_REQPEND		(1 &lt;&lt; 8)<br>-#define DCSR=
_EORINT		(1 &lt;&lt; 9)<br>-#define DCSR_CMPST		(1 &lt;&lt; 10)<br>-#define=
 DCSR_MASKRUN		(1 &lt;&lt; 22)<br>-#define DCSR_RASIRQEN		(1 &lt;&lt; 23)<b=
r>-#define DCSR_CLRCMPST		(1 &lt;&lt; 24)<br>-#define DCSR_SETCMPST		(1 &lt=
;&lt; 25)<br>-#define DCSR_EORSTOPEN		(1 &lt;&lt; 26)<br>-#define DCSR_EORJ=
MPEN		(1 &lt;&lt; 27)<br>-#define DCSR_EORIRQEN		(1 &lt;&lt; 28)<br>-#defin=
e DCSR_STOPIRQEN		(1 &lt;&lt; 29)<br>-#define DCSR_NODESCFETCH	(1 &lt;&lt; =
30)<br>-#define DCSR_RUN		(1 &lt;&lt; 31)<br>+#define DRCMR_CHLNUM =C2=A0 =
=C2=A0 0x1f<br>+#define DRCMR_MAPVLD =C2=A0 =C2=A0 (1 &lt;&lt; 7)<br>+#defi=
ne DDADR_STOP =C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 0)<br>+#define DDADR_BREN =
=C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 1)<br>+#define DCMD_LEN =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 0x1fff<br>+#define DCMD_WIDTH(x) =C2=A0 =C2=A0(1 &lt;&lt; ((((x)=
 &gt;&gt; 14) &amp; 3) - 1))<br>+#define DCMD_SIZE(x) =C2=A0 =C2=A0 (4 &lt;=
&lt; (((x) &gt;&gt; 16) &amp; 3))<br>+#define DCMD_FLYBYT =C2=A0 =C2=A0 =C2=
=A0(1 &lt;&lt; 19)<br>+#define DCMD_FLYBYS =C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; =
20)<br>+#define DCMD_ENDIRQEN =C2=A0 =C2=A0(1 &lt;&lt; 21)<br>+#define DCMD=
_STARTIRQEN =C2=A0(1 &lt;&lt; 22)<br>+#define DCMD_CMPEN =C2=A0 =C2=A0 =C2=
=A0 (1 &lt;&lt; 25)<br>+#define DCMD_FLOWTRG =C2=A0 =C2=A0 (1 &lt;&lt; 28)<=
br>+#define DCMD_FLOWSRC =C2=A0 =C2=A0 (1 &lt;&lt; 29)<br>+#define DCMD_INC=
TRGADDR =C2=A0(1 &lt;&lt; 30)<br>+#define DCMD_INCSRCADDR =C2=A0(1 &lt;&lt;=
 31)<br>+#define DCSR_BUSERRINTR =C2=A0(1 &lt;&lt; 0)<br>+#define DCSR_STAR=
TINTR =C2=A0 (1 &lt;&lt; 1)<br>+#define DCSR_ENDINTR =C2=A0 =C2=A0 (1 &lt;&=
lt; 2)<br>+#define DCSR_STOPINTR =C2=A0 =C2=A0(1 &lt;&lt; 3)<br>+#define DC=
SR_RASINTR =C2=A0 =C2=A0 (1 &lt;&lt; 4)<br>+#define DCSR_REQPEND =C2=A0 =C2=
=A0 (1 &lt;&lt; 8)<br>+#define DCSR_EORINT =C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; =
9)<br>+#define DCSR_CMPST =C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 10)<br>+#define =
DCSR_MASKRUN =C2=A0 =C2=A0 (1 &lt;&lt; 22)<br>+#define DCSR_RASIRQEN =C2=A0=
 =C2=A0(1 &lt;&lt; 23)<br>+#define DCSR_CLRCMPST =C2=A0 =C2=A0(1 &lt;&lt; 2=
4)<br>+#define DCSR_SETCMPST =C2=A0 =C2=A0(1 &lt;&lt; 25)<br>+#define DCSR_=
EORSTOPEN =C2=A0 (1 &lt;&lt; 26)<br>+#define DCSR_EORJMPEN =C2=A0 =C2=A0(1 =
&lt;&lt; 27)<br>+#define DCSR_EORIRQEN =C2=A0 =C2=A0(1 &lt;&lt; 28)<br>+#de=
fine DCSR_STOPIRQEN =C2=A0 (1 &lt;&lt; 29)<br>+#define DCSR_NODESCFETCH (1 =
&lt;&lt; 30)<br>+#define DCSR_RUN =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 3=
1)<br>=C2=A0<br>=C2=A0static inline void pxa2xx_dma_update(PXA2xxDMAState *=
s, int ch)<br>=C2=A0{<br>=C2=A0 =C2=A0 =C2=A0if (ch &gt;=3D 0) {<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((s-&gt;chan[ch].state &amp; DCSR_STOPIRQEN) =
&amp;&amp;<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(s-&=
gt;chan[ch].state &amp; DCSR_STOPINTR))<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0(s-&gt;chan[ch].state &amp; DCSR_STOPINTR)) {<br=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;stopintr |=3D 1 &lt;=
&lt; ch;<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0} else {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;stopin=
tr &amp;=3D ~(1 &lt;&lt; ch);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0<b=
r>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((s-&gt;chan[ch].state &amp; DCSR_EO=
RIRQEN) &amp;&amp;<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(s-&gt;chan[ch].state &amp; DCSR_EORINT))<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(s-&gt;chan[ch].state &amp; DCSR_EORINT))=
 {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;eorintr |=3D 1 =
&lt;&lt; ch;<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>+ =C2=A0 =C2=A0 =C2=A0=
 =C2=A0} else {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;eo=
rintr &amp;=3D ~(1 &lt;&lt; ch);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=
=A0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((s-&gt;chan[ch].state &amp; DC=
SR_RASIRQEN) &amp;&amp;<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0(s-&gt;chan[ch].state &amp; DCSR_RASINTR))<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(s-&gt;chan[ch].state &amp; DCSR_RASI=
NTR)) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;rasintr |=
=3D 1 &lt;&lt; ch;<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0} else {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-=
&gt;rasintr &amp;=3D ~(1 &lt;&lt; ch);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br=
>=C2=A0<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;chan[ch].state &amp; DCSR=
_STARTINTR)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;chan[ch].state &amp; =
DCSR_STARTINTR) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;=
startintr |=3D 1 &lt;&lt; ch;<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0s-&gt;startintr &amp;=3D ~(1 &lt;&lt; ch);<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}<br>=C2=A0<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;chan[ch].st=
ate &amp; DCSR_ENDINTR)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;chan[ch].=
state &amp; DCSR_ENDINTR) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0s-&gt;endintr |=3D 1 &lt;&lt; ch;<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0els=
e<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0s-&gt;endintr &amp;=3D ~(1 &lt;&lt; ch);<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0<br>- =C2=A0 =C2=A0=
if (s-&gt;stopintr | s-&gt;eorintr | s-&gt;rasintr | s-&gt;startintr | s-&g=
t;endintr)<br>+ =C2=A0 =C2=A0if (s-&gt;stopintr | s-&gt;eorintr | s-&gt;ras=
intr | s-&gt;startintr | s-&gt;endintr) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0qemu_irq_raise(s-&gt;irq);<br>- =C2=A0 =C2=A0else<br>+ =C2=A0 =C2=A0}=
 else {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_irq_lower(s-&gt;irq);<br>=
+ =C2=A0 =C2=A0}<br>=C2=A0}<br>=C2=A0<br>=C2=A0static inline void pxa2xx_dm=
a_descriptor_fetch(<br>@@ -160,8 +166,9 @@ static inline void pxa2xx_dma_de=
scriptor_fetch(<br>=C2=A0{<br>=C2=A0 =C2=A0 =C2=A0uint32_t desc[4];<br>=C2=
=A0 =C2=A0 =C2=A0hwaddr daddr =3D s-&gt;chan[ch].descr &amp; ~0xf;<br>- =C2=
=A0 =C2=A0if ((s-&gt;chan[ch].descr &amp; DDADR_BREN) &amp;&amp; (s-&gt;cha=
n[ch].state &amp; DCSR_CMPST))<br>+ =C2=A0 =C2=A0if ((s-&gt;chan[ch].descr =
&amp; DDADR_BREN) &amp;&amp; (s-&gt;chan[ch].state &amp; DCSR_CMPST)) {<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0daddr +=3D 32;<br>+ =C2=A0 =C2=A0}<br>=C2=
=A0<br>=C2=A0 =C2=A0 =C2=A0cpu_physical_memory_read(daddr, desc, 16);<br>=
=C2=A0 =C2=A0 =C2=A0s-&gt;chan[ch].descr =3D desc[DDADR];<br>@@ -169,16 +17=
6,20 @@ static inline void pxa2xx_dma_descriptor_fetch(<br>=C2=A0 =C2=A0 =
=C2=A0s-&gt;chan[ch].dest =3D desc[DTADR];<br>=C2=A0 =C2=A0 =C2=A0s-&gt;cha=
n[ch].cmd =3D desc[DCMD];<br>=C2=A0<br>- =C2=A0 =C2=A0if (s-&gt;chan[ch].cm=
d &amp; DCMD_FLOWSRC)<br>+ =C2=A0 =C2=A0if (s-&gt;chan[ch].cmd &amp; DCMD_F=
LOWSRC) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;chan[ch].src &amp;=3D =
~3;<br>- =C2=A0 =C2=A0if (s-&gt;chan[ch].cmd &amp; DCMD_FLOWTRG)<br>+ =C2=
=A0 =C2=A0}<br>+ =C2=A0 =C2=A0if (s-&gt;chan[ch].cmd &amp; DCMD_FLOWTRG) {<=
br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;chan[ch].dest &amp;=3D ~3;<br>+ =
=C2=A0 =C2=A0}<br>=C2=A0<br>- =C2=A0 =C2=A0if (s-&gt;chan[ch].cmd &amp; (DC=
MD_CMPEN | DCMD_FLYBYS | DCMD_FLYBYT))<br>+ =C2=A0 =C2=A0if (s-&gt;chan[ch]=
.cmd &amp; (DCMD_CMPEN | DCMD_FLYBYS | DCMD_FLYBYT)) {<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0printf(&quot;%s: unsupported mode in channel %i\n&quot;, _=
_func__, ch);<br>+ =C2=A0 =C2=A0}<br>=C2=A0<br>- =C2=A0 =C2=A0if (s-&gt;cha=
n[ch].cmd &amp; DCMD_STARTIRQEN)<br>+ =C2=A0 =C2=A0if (s-&gt;chan[ch].cmd &=
amp; DCMD_STARTIRQEN) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;chan[ch]=
.state |=3D DCSR_STARTINTR;<br>+ =C2=A0 =C2=A0}<br>=C2=A0}<br>=C2=A0<br>=C2=
=A0static void pxa2xx_dma_run(PXA2xxDMAState *s)<br>@@ -190,18 +201,20 @@ s=
tatic void pxa2xx_dma_run(PXA2xxDMAState *s)<br>=C2=A0 =C2=A0 =C2=A0uint8_t=
 buffer[32];<br>=C2=A0 =C2=A0 =C2=A0PXA2xxDMAChannel *ch;<br>=C2=A0<br>- =
=C2=A0 =C2=A0if (s-&gt;running ++)<br>+ =C2=A0 =C2=A0if (s-&gt;running++) {=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>+ =C2=A0 =C2=A0}<br>=C2=A0=
<br>=C2=A0 =C2=A0 =C2=A0while (s-&gt;running) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0s-&gt;running =3D 1;<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0for (c =3D 0=
; c &lt; s-&gt;channels; c ++) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0for (c =3D=
 0; c &lt; s-&gt;channels; c++) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ch =3D &amp;s-&gt;chan[c];<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0while ((ch-&gt;state &amp; DCSR_RUN) &amp;&amp; !(c=
h-&gt;state &amp; DCSR_STOPINTR)) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Test for pending requests */<br>- =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((ch-&gt;cmd &amp; (DCMD_FL=
OWSRC | DCMD_FLOWTRG)) &amp;&amp; !ch-&gt;request)<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((ch-&gt;cmd &amp; (DCMD_FLOWSRC |=
 DCMD_FLOWTRG)) &amp;&amp; !ch-&gt;request) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0length =3D ch-&gt;cmd &amp;=
 DCMD_LEN;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0size =3D DCMD_SIZE(ch-&gt;cmd);<br>@@ -228,11 +241,13 @@ static void pxa=
2xx_dma_run(PXA2xxDMAState *s)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((ch-&gt;cmd &amp; (DCMD_FLOWSRC | DC=
MD_FLOWTRG)) &amp;&amp;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!ch-&gt;request) {<=
br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0ch-&gt;state |=3D DCSR_EORINT;<br>- =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ch-&g=
t;state &amp; DCSR_EORSTOPEN)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ch-&gt;state &amp; DCSR_EO=
RSTOPEN) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ch-&gt;state |=3D DCSR_STOPINT=
R;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((ch-&gt;state &amp; DCSR_EORJMPEN=
) &amp;&amp;<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0!(ch-&gt;state &amp; DCSR_NODESCFETCH))<br>+ =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!(ch-&gt;state &amp; DCSR_NODE=
SCFETCH)) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pxa2xx_dma_descriptor_fetch(s,=
 c);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>@@ -241,8 +256,9 @@ stati=
c void pxa2xx_dma_run(PXA2xxDMAState *s)<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Is the transfer complete now? *=
/<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!len=
gth) {<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0if (ch-&gt;cmd &amp; DCMD_ENDIRQEN)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ch-&gt;cmd &amp; DCMD_ENDIRQEN=
) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0ch-&gt;state |=3D DCSR_ENDINTR;<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if=
 ((ch-&gt;state &amp; DCSR_NODESCFETCH) ||<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0(ch-&gt;descr &amp; DDADR_STOP) ||<br>@@ -259,7 +275,7 @@ =
static void pxa2xx_dma_run(PXA2xxDMAState *s)<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0<=
br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;running --;<br>+ =C2=A0 =C2=A0 =C2=A0=
 =C2=A0s-&gt;running--;<br>=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0}<br>=C2=A0<br>@@=
 -290,8 +306,9 @@ static uint64_t pxa2xx_dma_read(void *opaque, hwaddr offs=
et,<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0case DCSR0 ... DCSR31:<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0channel =3D offset &gt;&gt; 2;<br>- =C2=A0 =C2=A0 =
=C2=A0 =C2=A0if (s-&gt;chan[channel].request)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0if (s-&gt;chan[channel].request) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return s-&gt;chan[channel].state | DCSR_REQPEND;<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return s-&gt;cha=
n[channel].state;<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0case DINT:<br>@@ -363,8 =
+380,9 @@ static void pxa2xx_dma_write(void *opaque, hwaddr offset,<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 DCSR_STARTINTR | DCSR_BUSERRINTR));<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0s-&gt;chan[channel].state |=3D value &amp; 0xfc800000;<br>=C2=
=A0<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;chan[channel].state &amp; DCS=
R_STOPIRQEN)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;chan[channel].state =
&amp; DCSR_STOPIRQEN) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
s-&gt;chan[channel].state &amp;=3D ~DCSR_STOPINTR;<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (value &amp; =
DCSR_NODESCFETCH) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* N=
o-descriptor-fetch mode */<br>@@ -382,13 +400,16 @@ static void pxa2xx_dma_=
write(void *opaque, hwaddr offset,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<b=
r>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Shouldn&#39;t matter as ou=
r DMA is synchronous. =C2=A0*/<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(value =
&amp; (DCSR_RUN | DCSR_MASKRUN)))<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(val=
ue &amp; (DCSR_RUN | DCSR_MASKRUN))) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0s-&gt;chan[channel].state |=3D DCSR_STOPINTR;<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if (value &=
amp; DCSR_CLRCMPST)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (value &amp; DCSR_CL=
RCMPST) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;chan[cha=
nnel].state &amp;=3D ~DCSR_CMPST;<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if (value=
 &amp; DCSR_SETCMPST)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0if (value &amp; DCSR_SETCMPST) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;chan[channel].state |=3D DCSR_CMPST;<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0px=
a2xx_dma_update(s, channel);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br=
>@@ -439,19 +460,23 @@ static void pxa2xx_dma_request(void *opaque, int req=
_num, int on)<br>=C2=A0{<br>=C2=A0 =C2=A0 =C2=A0PXA2xxDMAState *s =3D opaqu=
e;<br>=C2=A0 =C2=A0 =C2=A0int ch;<br>- =C2=A0 =C2=A0if (req_num &lt; 0 || r=
eq_num &gt;=3D PXA2XX_DMA_NUM_REQUESTS)<br>+ =C2=A0 =C2=A0if (req_num &lt; =
0 || req_num &gt;=3D PXA2XX_DMA_NUM_REQUESTS) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0hw_error(&quot;%s: Bad DMA request %i\n&quot;, __func__, req_num)=
;<br>+ =C2=A0 =C2=A0}<br>=C2=A0<br>- =C2=A0 =C2=A0if (!(s-&gt;req[req_num] =
&amp; DRCMR_MAPVLD))<br>+ =C2=A0 =C2=A0if (!(s-&gt;req[req_num] &amp; DRCMR=
_MAPVLD)) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>+ =C2=A0 =C2=A0=
}<br>=C2=A0 =C2=A0 =C2=A0ch =3D s-&gt;req[req_num] &amp; DRCMR_CHLNUM;<br>=
=C2=A0<br>- =C2=A0 =C2=A0if (!s-&gt;chan[ch].request &amp;&amp; on)<br>+ =
=C2=A0 =C2=A0if (!s-&gt;chan[ch].request &amp;&amp; on) {<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0s-&gt;chan[ch].state |=3D DCSR_RASINTR;<br>- =C2=A0 =C2=
=A0else<br>+ =C2=A0 =C2=A0} else {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&=
gt;chan[ch].state &amp;=3D ~DCSR_RASINTR;<br>- =C2=A0 =C2=A0if (s-&gt;chan[=
ch].request &amp;&amp; !on)<br>+ =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0if (s-&gt=
;chan[ch].request &amp;&amp; !on) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-=
&gt;chan[ch].state |=3D DCSR_EORINT;<br>+ =C2=A0 =C2=A0}<br>=C2=A0<br>=C2=
=A0 =C2=A0 =C2=A0s-&gt;chan[ch].request =3D on;<br>=C2=A0 =C2=A0 =C2=A0if (=
on) {<br>@@ -488,8 +513,9 @@ static void pxa2xx_dma_realize(DeviceState *de=
v, Error **errp)<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0s-&gt;chan =3D g_new0(PXA=
2xxDMAChannel, s-&gt;channels);<br>=C2=A0<br>- =C2=A0 =C2=A0for (i =3D 0; i=
 &lt; s-&gt;channels; i ++)<br>+ =C2=A0 =C2=A0for (i =3D 0; i &lt; s-&gt;ch=
annels; i++) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;chan[i].state =3D=
 DCSR_STOPINTR;<br>+ =C2=A0 =C2=A0}<br>=C2=A0}<br>=C2=A0<br>=C2=A0DeviceSta=
te *pxa27x_dma_init(hwaddr base, qemu_irq irq)<br>diff --git a/hw/gpio/omap=
_gpio.c b/hw/gpio/omap_gpio.c<br>index a3341d70f1..60e97a0839 100644<br>---=
 a/hw/gpio/omap_gpio.c<br>+++ b/hw/gpio/omap_gpio.c<br>@@ -57,10 +57,11 @@ =
static void omap_gpio_set(void *opaque, int line, int level)<br>=C2=A0 =C2=
=A0 =C2=A0struct omap_gpio_s *s =3D &amp;p-&gt;omap1;<br>=C2=A0 =C2=A0 =C2=
=A0uint16_t prev =3D s-&gt;inputs;<br>=C2=A0<br>- =C2=A0 =C2=A0if (level)<b=
r>+ =C2=A0 =C2=A0if (level) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;in=
puts |=3D 1 &lt;&lt; line;<br>- =C2=A0 =C2=A0else<br>+ =C2=A0 =C2=A0} else =
{<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;inputs &amp;=3D ~(1 &lt;&lt; l=
ine);<br>+ =C2=A0 =C2=A0}<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0if (((s-&gt;edge=
 &amp; s-&gt;inputs &amp; ~prev) | (~s-&gt;edge &amp; ~s-&gt;inputs &amp; p=
rev)) &amp;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0(1 &lt;&lt; line) &amp; s-&gt;dir &amp; ~s-&gt;mask) {<br>=
@@ -80,25 +81,25 @@ static uint64_t omap_gpio_read(void *opaque, hwaddr add=
r,<br>=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0switch (offset=
) {<br>- =C2=A0 =C2=A0case 0x00:	/* DATA_INPUT */<br>+ =C2=A0 =C2=A0case 0x=
00: =C2=A0/* DATA_INPUT */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return s-&g=
t;inputs &amp; s-&gt;pins;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x04:	/* DATA_O=
UTPUT */<br>+ =C2=A0 =C2=A0case 0x04: =C2=A0/* DATA_OUTPUT */<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0return s-&gt;outputs;<br>=C2=A0<br>- =C2=A0 =C2=A0c=
ase 0x08:	/* DIRECTION_CONTROL */<br>+ =C2=A0 =C2=A0case 0x08: =C2=A0/* DIR=
ECTION_CONTROL */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return s-&gt;dir;<br=
>=C2=A0<br>- =C2=A0 =C2=A0case 0x0c:	/* INTERRUPT_CONTROL */<br>+ =C2=A0 =
=C2=A0case 0x0c: =C2=A0/* INTERRUPT_CONTROL */<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return s-&gt;edge;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x10:	/* INTE=
RRUPT_MASK */<br>+ =C2=A0 =C2=A0case 0x10: =C2=A0/* INTERRUPT_MASK */<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return s-&gt;mask;<br>=C2=A0<br>- =C2=A0 =
=C2=A0case 0x14:	/* INTERRUPT_STATUS */<br>+ =C2=A0 =C2=A0case 0x14: =C2=A0=
/* INTERRUPT_STATUS */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return s-&gt;in=
ts;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x18:	/* PIN_CONTROL (not in OMAP310) =
*/<br>+ =C2=A0 =C2=A0case 0x18: =C2=A0/* PIN_CONTROL (not in OMAP310) */<br=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OMAP_BAD_REG(addr);<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0return s-&gt;pins;<br>=C2=A0 =C2=A0 =C2=A0}<br>@@ -121,47 =
+122,50 @@ static void omap_gpio_write(void *opaque, hwaddr addr,<br>=C2=A0=
 =C2=A0 =C2=A0}<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0switch (offset) {<br>- =C2=
=A0 =C2=A0case 0x00:	/* DATA_INPUT */<br>+ =C2=A0 =C2=A0case 0x00: =C2=A0/*=
 DATA_INPUT */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OMAP_RO_REG(addr);<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>=C2=A0<br>- =C2=A0 =C2=A0case =
0x04:	/* DATA_OUTPUT */<br>+ =C2=A0 =C2=A0case 0x04: =C2=A0/* DATA_OUTPUT *=
/<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0diff =3D (s-&gt;outputs ^ value) &am=
p; ~s-&gt;dir;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;outputs =3D value=
;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0while ((ln =3D ctz32(diff)) !=3D 32)=
 {<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;handler[ln])<br>=
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;handler[ln]) {<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_set_irq(s-&=
gt;handler[ln], (value &gt;&gt; ln) &amp; 1);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0diff =
&amp;=3D ~(1 &lt;&lt; ln);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x08:	/=
* DIRECTION_CONTROL */<br>+ =C2=A0 =C2=A0case 0x08: =C2=A0/* DIRECTION_CONT=
ROL */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0diff =3D s-&gt;outputs &amp; (s=
-&gt;dir ^ value);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;dir =3D value=
;<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0value =3D s-&gt;outputs &a=
mp; ~s-&gt;dir;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0while ((ln =3D ctz32(d=
iff)) !=3D 32) {<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;ha=
ndler[ln])<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;handler[=
ln]) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qem=
u_set_irq(s-&gt;handler[ln], (value &gt;&gt; ln) &amp; 1);<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0diff &amp;=3D ~(1 &lt;&lt; ln);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0}<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>=C2=A0<br>- =C2=A0 =
=C2=A0case 0x0c:	/* INTERRUPT_CONTROL */<br>+ =C2=A0 =C2=A0case 0x0c: =C2=
=A0/* INTERRUPT_CONTROL */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;edge =
=3D value;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>=C2=A0<br>- =C2=
=A0 =C2=A0case 0x10:	/* INTERRUPT_MASK */<br>+ =C2=A0 =C2=A0case 0x10: =C2=
=A0/* INTERRUPT_MASK */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;mask =3D=
 value;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>=C2=A0<br>- =C2=A0 =
=C2=A0case 0x14:	/* INTERRUPT_STATUS */<br>+ =C2=A0 =C2=A0case 0x14: =C2=A0=
/* INTERRUPT_STATUS */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;ints &amp=
;=3D ~value;<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!s-&gt;ints)<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0if (!s-&gt;ints) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0qemu_irq_lower(s-&gt;irq);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0}<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>=C2=A0<br>- =C2=A0 =C2=
=A0case 0x18:	/* PIN_CONTROL (not in OMAP310 TRM) */<br>+ =C2=A0 =C2=A0case=
 0x18: =C2=A0/* PIN_CONTROL (not in OMAP310 TRM) */<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0OMAP_BAD_REG(addr);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&g=
t;pins =3D value;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>@@ -233,12=
 +237,15 @@ static inline void omap2_gpio_module_int_update(struct omap2_gp=
io_s *s,<br>=C2=A0<br>=C2=A0static void omap2_gpio_module_wake(struct omap2=
_gpio_s *s, int line)<br>=C2=A0{<br>- =C2=A0 =C2=A0if (!(s-&gt;config[0] &a=
mp; (1 &lt;&lt; 2)))			/* ENAWAKEUP */<br>+ =C2=A0 =C2=A0if (!(s-&gt;config=
[0] &amp; (1 &lt;&lt; 2))) { =C2=A0 /* ENAWAKEUP */<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return;<br>- =C2=A0 =C2=A0if (!(s-&gt;config[0] &amp; (3 &lt;=
&lt; 3)))			/* Force Idle */<br>+ =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0if (!(s-=
&gt;config[0] &amp; (3 &lt;&lt; 3))) { =C2=A0 /* Force Idle */<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>- =C2=A0 =C2=A0if (!(s-&gt;wumask &am=
p; (1 &lt;&lt; line)))<br>+ =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0if (!(s-&gt;wu=
mask &amp; (1 &lt;&lt; line))) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retur=
n;<br>+ =C2=A0 =C2=A0}<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0qemu_irq_raise(s-&g=
t;wkup);<br>=C2=A0}<br>@@ -279,12 +286,14 @@ static void omap2_gpio_set(voi=
d *opaque, int line, int level)<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0line &amp;=
=3D 31;<br>=C2=A0 =C2=A0 =C2=A0if (level) {<br>- =C2=A0 =C2=A0 =C2=A0 =C2=
=A0if (s-&gt;dir &amp; (1 &lt;&lt; line) &amp; ((~s-&gt;inputs &amp; s-&gt;=
edge[0]) | s-&gt;level[1]))<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;dir &=
amp; (1 &lt;&lt; line) &amp; ((~s-&gt;inputs &amp; s-&gt;edge[0]) | s-&gt;l=
evel[1])) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0omap2_gpio_m=
odule_int(s, line);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0s-&gt;inputs |=3D 1 &lt;&lt; line;<br>=C2=A0 =C2=A0 =C2=A0=
} else {<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;dir &amp; (1 &lt;&lt; li=
ne) &amp; ((s-&gt;inputs &amp; s-&gt;edge[1]) | s-&gt;level[0]))<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;dir &amp; (1 &lt;&lt; line) &amp; ((s-&gt=
;inputs &amp; s-&gt;edge[1]) | s-&gt;level[0])) {<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0omap2_gpio_module_int(s, line);<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;inputs &amp;=
=3D ~(1 &lt;&lt; line);<br>=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0}<br>@@ -312,66 +=
321,66 @@ static uint32_t omap2_gpio_module_read(void *opaque, hwaddr addr)=
<br>=C2=A0 =C2=A0 =C2=A0struct omap2_gpio_s *s =3D opaque;<br>=C2=A0<br>=C2=
=A0 =C2=A0 =C2=A0switch (addr) {<br>- =C2=A0 =C2=A0case 0x00:	/* GPIO_REVIS=
ION */<br>+ =C2=A0 =C2=A0case 0x00: =C2=A0/* GPIO_REVISION */<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0return s-&gt;revision;<br>=C2=A0<br>- =C2=A0 =C2=A0=
case 0x10:	/* GPIO_SYSCONFIG */<br>+ =C2=A0 =C2=A0case 0x10: =C2=A0/* GPIO_=
SYSCONFIG */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return s-&gt;config[0];<b=
r>=C2=A0<br>- =C2=A0 =C2=A0case 0x14:	/* GPIO_SYSSTATUS */<br>+ =C2=A0 =C2=
=A0case 0x14: =C2=A0/* GPIO_SYSSTATUS */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0return 0x01;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x18:	/* GPIO_IRQSTATUS1 *=
/<br>+ =C2=A0 =C2=A0case 0x18: =C2=A0/* GPIO_IRQSTATUS1 */<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0return s-&gt;ints[0];<br>=C2=A0<br>- =C2=A0 =C2=A0case=
 0x1c:	/* GPIO_IRQENABLE1 */<br>- =C2=A0 =C2=A0case 0x60:	/* GPIO_CLEARIRQE=
NABLE1 */<br>- =C2=A0 =C2=A0case 0x64:	/* GPIO_SETIRQENABLE1 */<br>+ =C2=A0=
 =C2=A0case 0x1c: =C2=A0/* GPIO_IRQENABLE1 */<br>+ =C2=A0 =C2=A0case 0x60: =
=C2=A0/* GPIO_CLEARIRQENABLE1 */<br>+ =C2=A0 =C2=A0case 0x64: =C2=A0/* GPIO=
_SETIRQENABLE1 */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return s-&gt;mask[0]=
;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x20:	/* GPIO_WAKEUPENABLE */<br>- =C2=
=A0 =C2=A0case 0x80:	/* GPIO_CLEARWKUENA */<br>- =C2=A0 =C2=A0case 0x84:	/*=
 GPIO_SETWKUENA */<br>+ =C2=A0 =C2=A0case 0x20: =C2=A0/* GPIO_WAKEUPENABLE =
*/<br>+ =C2=A0 =C2=A0case 0x80: =C2=A0/* GPIO_CLEARWKUENA */<br>+ =C2=A0 =
=C2=A0case 0x84: =C2=A0/* GPIO_SETWKUENA */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0return s-&gt;wumask;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x28:	/* GPIO_I=
RQSTATUS2 */<br>+ =C2=A0 =C2=A0case 0x28: =C2=A0/* GPIO_IRQSTATUS2 */<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return s-&gt;ints[1];<br>=C2=A0<br>- =C2=
=A0 =C2=A0case 0x2c:	/* GPIO_IRQENABLE2 */<br>- =C2=A0 =C2=A0case 0x70:	/* =
GPIO_CLEARIRQENABLE2 */<br>- =C2=A0 =C2=A0case 0x74:	/* GPIO_SETIREQNEABLE2=
 */<br>+ =C2=A0 =C2=A0case 0x2c: =C2=A0/* GPIO_IRQENABLE2 */<br>+ =C2=A0 =
=C2=A0case 0x70: =C2=A0/* GPIO_CLEARIRQENABLE2 */<br>+ =C2=A0 =C2=A0case 0x=
74: =C2=A0/* GPIO_SETIREQNEABLE2 */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0re=
turn s-&gt;mask[1];<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x30:	/* GPIO_CTRL */<=
br>+ =C2=A0 =C2=A0case 0x30: =C2=A0/* GPIO_CTRL */<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return s-&gt;config[1];<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x34:=
	/* GPIO_OE */<br>+ =C2=A0 =C2=A0case 0x34: =C2=A0/* GPIO_OE */<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0return s-&gt;dir;<br>=C2=A0<br>- =C2=A0 =C2=A0ca=
se 0x38:	/* GPIO_DATAIN */<br>+ =C2=A0 =C2=A0case 0x38: =C2=A0/* GPIO_DATAI=
N */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return s-&gt;inputs;<br>=C2=A0<br=
>- =C2=A0 =C2=A0case 0x3c:	/* GPIO_DATAOUT */<br>- =C2=A0 =C2=A0case 0x90:	=
/* GPIO_CLEARDATAOUT */<br>- =C2=A0 =C2=A0case 0x94:	/* GPIO_SETDATAOUT */<=
br>+ =C2=A0 =C2=A0case 0x3c: =C2=A0/* GPIO_DATAOUT */<br>+ =C2=A0 =C2=A0cas=
e 0x90: =C2=A0/* GPIO_CLEARDATAOUT */<br>+ =C2=A0 =C2=A0case 0x94: =C2=A0/*=
 GPIO_SETDATAOUT */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return s-&gt;outpu=
ts;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x40:	/* GPIO_LEVELDETECT0 */<br>+ =C2=
=A0 =C2=A0case 0x40: =C2=A0/* GPIO_LEVELDETECT0 */<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return s-&gt;level[0];<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x44:	=
/* GPIO_LEVELDETECT1 */<br>+ =C2=A0 =C2=A0case 0x44: =C2=A0/* GPIO_LEVELDET=
ECT1 */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return s-&gt;level[1];<br>=C2=
=A0<br>- =C2=A0 =C2=A0case 0x48:	/* GPIO_RISINGDETECT */<br>+ =C2=A0 =C2=A0=
case 0x48: =C2=A0/* GPIO_RISINGDETECT */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0return s-&gt;edge[0];<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x4c:	/* GPIO_FAL=
LINGDETECT */<br>+ =C2=A0 =C2=A0case 0x4c: =C2=A0/* GPIO_FALLINGDETECT */<b=
r>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return s-&gt;edge[1];<br>=C2=A0<br>- =
=C2=A0 =C2=A0case 0x50:	/* GPIO_DEBOUNCENABLE */<br>+ =C2=A0 =C2=A0case 0x5=
0: =C2=A0/* GPIO_DEBOUNCENABLE */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retu=
rn s-&gt;debounce;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x54:	/* GPIO_DEBOUNCIN=
GTIME */<br>+ =C2=A0 =C2=A0case 0x54: =C2=A0/* GPIO_DEBOUNCINGTIME */<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return s-&gt;delay;<br>=C2=A0 =C2=A0 =C2=
=A0}<br>=C2=A0<br>@@ -387,55 +396,56 @@ static void omap2_gpio_module_write=
(void *opaque, hwaddr addr,<br>=C2=A0 =C2=A0 =C2=A0int ln;<br>=C2=A0<br>=C2=
=A0 =C2=A0 =C2=A0switch (addr) {<br>- =C2=A0 =C2=A0case 0x00:	/* GPIO_REVIS=
ION */<br>- =C2=A0 =C2=A0case 0x14:	/* GPIO_SYSSTATUS */<br>- =C2=A0 =C2=A0=
case 0x38:	/* GPIO_DATAIN */<br>+ =C2=A0 =C2=A0case 0x00: =C2=A0/* GPIO_REV=
ISION */<br>+ =C2=A0 =C2=A0case 0x14: =C2=A0/* GPIO_SYSSTATUS */<br>+ =C2=
=A0 =C2=A0case 0x38: =C2=A0/* GPIO_DATAIN */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0OMAP_RO_REG(addr);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>=
=C2=A0<br>- =C2=A0 =C2=A0case 0x10:	/* GPIO_SYSCONFIG */<br>+ =C2=A0 =C2=A0=
case 0x10: =C2=A0/* GPIO_SYSCONFIG */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
if (((value &gt;&gt; 3) &amp; 3) =3D=3D 3) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0qemu_log_mask(LOG_GUEST_ERROR,<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&quot;%s: Illegal IDLEMODE value: 3\n&quot;, __func__);<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0}<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if (value &amp; 2)<b=
r>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (value &amp; 2) {<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0omap2_gpio_module_reset(s);<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;config[0] =3D val=
ue &amp; 0x1d;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>=C2=A0<br>- =
=C2=A0 =C2=A0case 0x18:	/* GPIO_IRQSTATUS1 */<br>+ =C2=A0 =C2=A0case 0x18: =
=C2=A0/* GPIO_IRQSTATUS1 */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;=
ints[0] &amp; value) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s=
-&gt;ints[0] &amp;=3D ~value;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0omap2_gpio_module_level_update(s, 0);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0}<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>=C2=A0<br>- =C2=A0 =
=C2=A0case 0x1c:	/* GPIO_IRQENABLE1 */<br>+ =C2=A0 =C2=A0case 0x1c: =C2=A0/=
* GPIO_IRQENABLE1 */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;mask[0] =3D=
 value;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0omap2_gpio_module_int_update(s=
, 0);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>=C2=A0<br>- =C2=A0 =C2=
=A0case 0x20:	/* GPIO_WAKEUPENABLE */<br>+ =C2=A0 =C2=A0case 0x20: =C2=A0/*=
 GPIO_WAKEUPENABLE */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;wumask =3D=
 value;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>=C2=A0<br>- =C2=A0 =
=C2=A0case 0x28:	/* GPIO_IRQSTATUS2 */<br>+ =C2=A0 =C2=A0case 0x28: =C2=A0/=
* GPIO_IRQSTATUS2 */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;ints[1]=
 &amp; value) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;in=
ts[1] &amp;=3D ~value;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0o=
map2_gpio_module_level_update(s, 1);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>=C2=A0<br>- =C2=A0 =C2=A0ca=
se 0x2c:	/* GPIO_IRQENABLE2 */<br>+ =C2=A0 =C2=A0case 0x2c: =C2=A0/* GPIO_I=
RQENABLE2 */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;mask[1] =3D value;<=
br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0omap2_gpio_module_int_update(s, 1);<br=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>=C2=A0<br>- =C2=A0 =C2=A0case =
0x30:	/* GPIO_CTRL */<br>+ =C2=A0 =C2=A0case 0x30: =C2=A0/* GPIO_CTRL */<br=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;config[1] =3D value &amp; 7;<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0=
x34:	/* GPIO_OE */<br>+ =C2=A0 =C2=A0case 0x34: =C2=A0/* GPIO_OE */<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0diff =3D s-&gt;outputs &amp; (s-&gt;dir ^ va=
lue);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;dir =3D value;<br>=C2=A0<b=
r>@@ -449,71 +459,71 @@ static void omap2_gpio_module_write(void *opaque, h=
waddr addr,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0omap2_gpio_module_level_up=
date(s, 1);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>=C2=A0<br>- =C2=
=A0 =C2=A0case 0x3c:	/* GPIO_DATAOUT */<br>+ =C2=A0 =C2=A0case 0x3c: =C2=A0=
/* GPIO_DATAOUT */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0omap2_gpio_module_o=
ut_update(s, s-&gt;outputs ^ value);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0b=
reak;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x40:	/* GPIO_LEVELDETECT0 */<br>+ =
=C2=A0 =C2=A0case 0x40: =C2=A0/* GPIO_LEVELDETECT0 */<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0s-&gt;level[0] =3D value;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0omap2_gpio_module_level_update(s, 0);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0omap2_gpio_module_level_update(s, 1);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0break;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x44:	/* GPIO_LEVELDETECT1 */=
<br>+ =C2=A0 =C2=A0case 0x44: =C2=A0/* GPIO_LEVELDETECT1 */<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;level[1] =3D value;<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0omap2_gpio_module_level_update(s, 0);<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0omap2_gpio_module_level_update(s, 1);<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0break;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x48:	/* GPIO_RISINGDE=
TECT */<br>+ =C2=A0 =C2=A0case 0x48: =C2=A0/* GPIO_RISINGDETECT */<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;edge[0] =3D value;<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0break;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x4c:	/* GPIO_F=
ALLINGDETECT */<br>+ =C2=A0 =C2=A0case 0x4c: =C2=A0/* GPIO_FALLINGDETECT */=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;edge[1] =3D value;<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x50:	/*=
 GPIO_DEBOUNCENABLE */<br>+ =C2=A0 =C2=A0case 0x50: =C2=A0/* GPIO_DEBOUNCEN=
ABLE */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;debounce =3D value;<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0=
x54:	/* GPIO_DEBOUNCINGTIME */<br>+ =C2=A0 =C2=A0case 0x54: =C2=A0/* GPIO_D=
EBOUNCINGTIME */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;delay =3D value=
;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>=C2=A0<br>- =C2=A0 =C2=A0c=
ase 0x60:	/* GPIO_CLEARIRQENABLE1 */<br>+ =C2=A0 =C2=A0case 0x60: =C2=A0/* =
GPIO_CLEARIRQENABLE1 */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;mask[0] =
&amp;=3D ~value;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0omap2_gpio_module_int=
_update(s, 0);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>=C2=A0<br>- =
=C2=A0 =C2=A0case 0x64:	/* GPIO_SETIRQENABLE1 */<br>+ =C2=A0 =C2=A0case 0x6=
4: =C2=A0/* GPIO_SETIRQENABLE1 */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&g=
t;mask[0] |=3D value;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0omap2_gpio_modul=
e_int_update(s, 0);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>=C2=A0<b=
r>- =C2=A0 =C2=A0case 0x70:	/* GPIO_CLEARIRQENABLE2 */<br>+ =C2=A0 =C2=A0ca=
se 0x70: =C2=A0/* GPIO_CLEARIRQENABLE2 */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0s-&gt;mask[1] &amp;=3D ~value;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0o=
map2_gpio_module_int_update(s, 1);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bre=
ak;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x74:	/* GPIO_SETIREQNEABLE2 */<br>+ =
=C2=A0 =C2=A0case 0x74: =C2=A0/* GPIO_SETIREQNEABLE2 */<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0s-&gt;mask[1] |=3D value;<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0omap2_gpio_module_int_update(s, 1);<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x80:	/* GPIO_CLEARWKUENA=
 */<br>+ =C2=A0 =C2=A0case 0x80: =C2=A0/* GPIO_CLEARWKUENA */<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;wumask &amp;=3D ~value;<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0break;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x84:	/* GPIO_SETW=
KUENA */<br>+ =C2=A0 =C2=A0case 0x84: =C2=A0/* GPIO_SETWKUENA */<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;wumask |=3D value;<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0break;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x90:	/* GPIO_CLEARDA=
TAOUT */<br>+ =C2=A0 =C2=A0case 0x90: =C2=A0/* GPIO_CLEARDATAOUT */<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0omap2_gpio_module_out_update(s, s-&gt;output=
s &amp; value);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>=C2=A0<br>- =
=C2=A0 =C2=A0case 0x94:	/* GPIO_SETDATAOUT */<br>+ =C2=A0 =C2=A0case 0x94: =
=C2=A0/* GPIO_SETDATAOUT */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0omap2_gpio=
_module_out_update(s, ~s-&gt;outputs &amp; value);<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0break;<br>=C2=A0<br>@@ -541,39 +551,39 @@ static void omap2_gp=
io_module_writep(void *opaque, hwaddr addr,<br>=C2=A0 =C2=A0 =C2=A0}<br>=C2=
=A0<br>=C2=A0 =C2=A0 =C2=A0switch (addr &amp; ~3) {<br>- =C2=A0 =C2=A0case =
0x00:	/* GPIO_REVISION */<br>- =C2=A0 =C2=A0case 0x14:	/* GPIO_SYSSTATUS */=
<br>- =C2=A0 =C2=A0case 0x38:	/* GPIO_DATAIN */<br>+ =C2=A0 =C2=A0case 0x00=
: =C2=A0/* GPIO_REVISION */<br>+ =C2=A0 =C2=A0case 0x14: =C2=A0/* GPIO_SYSS=
TATUS */<br>+ =C2=A0 =C2=A0case 0x38: =C2=A0/* GPIO_DATAIN */<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0OMAP_RO_REG(addr);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0break;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x10:	/* GPIO_SYSCONFIG */<br=
>- =C2=A0 =C2=A0case 0x1c:	/* GPIO_IRQENABLE1 */<br>- =C2=A0 =C2=A0case 0x2=
0:	/* GPIO_WAKEUPENABLE */<br>- =C2=A0 =C2=A0case 0x2c:	/* GPIO_IRQENABLE2 =
*/<br>- =C2=A0 =C2=A0case 0x30:	/* GPIO_CTRL */<br>- =C2=A0 =C2=A0case 0x34=
:	/* GPIO_OE */<br>- =C2=A0 =C2=A0case 0x3c:	/* GPIO_DATAOUT */<br>- =C2=A0=
 =C2=A0case 0x40:	/* GPIO_LEVELDETECT0 */<br>- =C2=A0 =C2=A0case 0x44:	/* G=
PIO_LEVELDETECT1 */<br>- =C2=A0 =C2=A0case 0x48:	/* GPIO_RISINGDETECT */<br=
>- =C2=A0 =C2=A0case 0x4c:	/* GPIO_FALLINGDETECT */<br>- =C2=A0 =C2=A0case =
0x50:	/* GPIO_DEBOUNCENABLE */<br>- =C2=A0 =C2=A0case 0x54:	/* GPIO_DEBOUNC=
INGTIME */<br>+ =C2=A0 =C2=A0case 0x10: =C2=A0/* GPIO_SYSCONFIG */<br>+ =C2=
=A0 =C2=A0case 0x1c: =C2=A0/* GPIO_IRQENABLE1 */<br>+ =C2=A0 =C2=A0case 0x2=
0: =C2=A0/* GPIO_WAKEUPENABLE */<br>+ =C2=A0 =C2=A0case 0x2c: =C2=A0/* GPIO=
_IRQENABLE2 */<br>+ =C2=A0 =C2=A0case 0x30: =C2=A0/* GPIO_CTRL */<br>+ =C2=
=A0 =C2=A0case 0x34: =C2=A0/* GPIO_OE */<br>+ =C2=A0 =C2=A0case 0x3c: =C2=
=A0/* GPIO_DATAOUT */<br>+ =C2=A0 =C2=A0case 0x40: =C2=A0/* GPIO_LEVELDETEC=
T0 */<br>+ =C2=A0 =C2=A0case 0x44: =C2=A0/* GPIO_LEVELDETECT1 */<br>+ =C2=
=A0 =C2=A0case 0x48: =C2=A0/* GPIO_RISINGDETECT */<br>+ =C2=A0 =C2=A0case 0=
x4c: =C2=A0/* GPIO_FALLINGDETECT */<br>+ =C2=A0 =C2=A0case 0x50: =C2=A0/* G=
PIO_DEBOUNCENABLE */<br>+ =C2=A0 =C2=A0case 0x54: =C2=A0/* GPIO_DEBOUNCINGT=
IME */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cur =3D omap2_gpio_module_read(=
opaque, addr &amp; ~3) &amp;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0~(mask &lt;&lt; ((addr &amp; 3) &lt;&lt; 3));<br>=C2=A0=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Fall through. =C2=A0*/<br>- =C2=A0=
 =C2=A0case 0x18:	/* GPIO_IRQSTATUS1 */<br>- =C2=A0 =C2=A0case 0x28:	/* GPI=
O_IRQSTATUS2 */<br>- =C2=A0 =C2=A0case 0x60:	/* GPIO_CLEARIRQENABLE1 */<br>=
- =C2=A0 =C2=A0case 0x64:	/* GPIO_SETIRQENABLE1 */<br>- =C2=A0 =C2=A0case 0=
x70:	/* GPIO_CLEARIRQENABLE2 */<br>- =C2=A0 =C2=A0case 0x74:	/* GPIO_SETIRE=
QNEABLE2 */<br>- =C2=A0 =C2=A0case 0x80:	/* GPIO_CLEARWKUENA */<br>- =C2=A0=
 =C2=A0case 0x84:	/* GPIO_SETWKUENA */<br>- =C2=A0 =C2=A0case 0x90:	/* GPIO=
_CLEARDATAOUT */<br>- =C2=A0 =C2=A0case 0x94:	/* GPIO_SETDATAOUT */<br>+ =
=C2=A0 =C2=A0case 0x18: =C2=A0/* GPIO_IRQSTATUS1 */<br>+ =C2=A0 =C2=A0case =
0x28: =C2=A0/* GPIO_IRQSTATUS2 */<br>+ =C2=A0 =C2=A0case 0x60: =C2=A0/* GPI=
O_CLEARIRQENABLE1 */<br>+ =C2=A0 =C2=A0case 0x64: =C2=A0/* GPIO_SETIRQENABL=
E1 */<br>+ =C2=A0 =C2=A0case 0x70: =C2=A0/* GPIO_CLEARIRQENABLE2 */<br>+ =
=C2=A0 =C2=A0case 0x74: =C2=A0/* GPIO_SETIREQNEABLE2 */<br>+ =C2=A0 =C2=A0c=
ase 0x80: =C2=A0/* GPIO_CLEARWKUENA */<br>+ =C2=A0 =C2=A0case 0x84: =C2=A0/=
* GPIO_SETWKUENA */<br>+ =C2=A0 =C2=A0case 0x90: =C2=A0/* GPIO_CLEARDATAOUT=
 */<br>+ =C2=A0 =C2=A0case 0x94: =C2=A0/* GPIO_SETDATAOUT */<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0value &lt;&lt;=3D (addr &amp; 3) &lt;&lt; 3;<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0omap2_gpio_module_write(opaque, addr, cur | =
value);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>@@ -616,22 +626,22 @=
@ static uint64_t omap2_gpif_top_read(void *opaque, hwaddr addr, unsigned s=
ize)<br>=C2=A0 =C2=A0 =C2=A0Omap2GpioState *s =3D opaque;<br>=C2=A0<br>=C2=
=A0 =C2=A0 =C2=A0switch (addr) {<br>- =C2=A0 =C2=A0case 0x00:	/* IPGENERICO=
CPSPL_REVISION */<br>+ =C2=A0 =C2=A0case 0x00: =C2=A0/* IPGENERICOCPSPL_REV=
ISION */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0x18;<br>=C2=A0<br>- =
=C2=A0 =C2=A0case 0x10:	/* IPGENERICOCPSPL_SYSCONFIG */<br>+ =C2=A0 =C2=A0c=
ase 0x10: =C2=A0/* IPGENERICOCPSPL_SYSCONFIG */<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return s-&gt;autoidle;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x14:	/* =
IPGENERICOCPSPL_SYSSTATUS */<br>+ =C2=A0 =C2=A0case 0x14: =C2=A0/* IPGENERI=
COCPSPL_SYSSTATUS */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0x01;<br>=
=C2=A0<br>- =C2=A0 =C2=A0case 0x18:	/* IPGENERICOCPSPL_IRQSTATUS */<br>+ =
=C2=A0 =C2=A0case 0x18: =C2=A0/* IPGENERICOCPSPL_IRQSTATUS */<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0return 0x00;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x40:=
	/* IPGENERICOCPSPL_GPO */<br>+ =C2=A0 =C2=A0case 0x40: =C2=A0/* IPGENERICO=
CPSPL_GPO */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return s-&gt;gpo;<br>=C2=
=A0<br>- =C2=A0 =C2=A0case 0x50:	/* IPGENERICOCPSPL_GPI */<br>+ =C2=A0 =C2=
=A0case 0x50: =C2=A0/* IPGENERICOCPSPL_GPI */<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return 0x00;<br>=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0<br>@@ -645,20 +65=
5,21 @@ static void omap2_gpif_top_write(void *opaque, hwaddr addr,<br>=C2=
=A0 =C2=A0 =C2=A0Omap2GpioState *s =3D opaque;<br>=C2=A0<br>=C2=A0 =C2=A0 =
=C2=A0switch (addr) {<br>- =C2=A0 =C2=A0case 0x00:	/* IPGENERICOCPSPL_REVIS=
ION */<br>- =C2=A0 =C2=A0case 0x14:	/* IPGENERICOCPSPL_SYSSTATUS */<br>- =
=C2=A0 =C2=A0case 0x18:	/* IPGENERICOCPSPL_IRQSTATUS */<br>- =C2=A0 =C2=A0c=
ase 0x50:	/* IPGENERICOCPSPL_GPI */<br>+ =C2=A0 =C2=A0case 0x00: =C2=A0/* I=
PGENERICOCPSPL_REVISION */<br>+ =C2=A0 =C2=A0case 0x14: =C2=A0/* IPGENERICO=
CPSPL_SYSSTATUS */<br>+ =C2=A0 =C2=A0case 0x18: =C2=A0/* IPGENERICOCPSPL_IR=
QSTATUS */<br>+ =C2=A0 =C2=A0case 0x50: =C2=A0/* IPGENERICOCPSPL_GPI */<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OMAP_RO_REG(addr);<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0break;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x10:	/* IPGENERIC=
OCPSPL_SYSCONFIG */<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if (value &amp; (1 &lt;=
&lt; 1))					/* SOFTRESET */<br>+ =C2=A0 =C2=A0case 0x10: =C2=A0/* IPGENERI=
COCPSPL_SYSCONFIG */<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (value &amp; (1 &lt=
;&lt; 1)) { =C2=A0 =C2=A0 =C2=A0 /* SOFTRESET */<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0omap2_gpif_reset(DEVICE(s));<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;autoidle =3D valu=
e &amp; 1;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>=C2=A0<br>- =C2=
=A0 =C2=A0case 0x40:	/* IPGENERICOCPSPL_GPO */<br>+ =C2=A0 =C2=A0case 0x40:=
 =C2=A0/* IPGENERICOCPSPL_GPO */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt=
;gpo =3D value &amp; 1;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>=C2=
=A0<br>diff --git a/hw/gpio/zaurus.c b/hw/gpio/zaurus.c<br>index 5884804c58=
..7342440b95 100644<br>--- a/hw/gpio/zaurus.c<br>+++ b/hw/gpio/zaurus.c<br>=
@@ -49,19 +49,20 @@ struct ScoopInfo {<br>=C2=A0 =C2=A0 =C2=A0uint16_t isr;=
<br>=C2=A0};<br>=C2=A0<br>-#define SCOOP_MCR	0x00<br>-#define SCOOP_CDR	0x0=
4<br>-#define SCOOP_CSR	0x08<br>-#define SCOOP_CPR	0x0c<br>-#define SCOOP_C=
CR	0x10<br>-#define SCOOP_IRR_IRM	0x14<br>-#define SCOOP_IMR	0x18<br>-#defi=
ne SCOOP_ISR	0x1c<br>-#define SCOOP_GPCR	0x20<br>-#define SCOOP_GPWR	0x24<b=
r>-#define SCOOP_GPRR	0x28<br>-<br>-static inline void scoop_gpio_handler_u=
pdate(ScoopInfo *s) {<br>+#define SCOOP_MCR =C2=A0 =C2=A0 =C2=A0 0x00<br>+#=
define SCOOP_CDR =C2=A0 =C2=A0 =C2=A0 0x04<br>+#define SCOOP_CSR =C2=A0 =C2=
=A0 =C2=A0 0x08<br>+#define SCOOP_CPR =C2=A0 =C2=A0 =C2=A0 0x0c<br>+#define=
 SCOOP_CCR =C2=A0 =C2=A0 =C2=A0 0x10<br>+#define SCOOP_IRR_IRM =C2=A0 0x14<=
br>+#define SCOOP_IMR =C2=A0 =C2=A0 =C2=A0 0x18<br>+#define SCOOP_ISR =C2=
=A0 =C2=A0 =C2=A0 0x1c<br>+#define SCOOP_GPCR =C2=A0 =C2=A0 =C2=A00x20<br>+=
#define SCOOP_GPWR =C2=A0 =C2=A0 =C2=A00x24<br>+#define SCOOP_GPRR =C2=A0 =
=C2=A0 =C2=A00x28<br>+<br>+static inline void scoop_gpio_handler_update(Sco=
opInfo *s)<br>+{<br>=C2=A0 =C2=A0 =C2=A0uint32_t level, diff;<br>=C2=A0 =C2=
=A0 =C2=A0int bit;<br>=C2=A0 =C2=A0 =C2=A0level =3D s-&gt;gpio_level &amp; =
s-&gt;gpio_dir;<br>@@ -125,8 +126,9 @@ static void scoop_write(void *opaque=
, hwaddr addr,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>=C2=A0 =C2=A0=
 =C2=A0case SCOOP_CPR:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;power =3D=
 value;<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if (value &amp; 0x80)<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0if (value &amp; 0x80) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0s-&gt;power |=3D 0x8040;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0}<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>=C2=A0 =C2=A0 =C2=A0cas=
e SCOOP_CCR:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;ccr =3D value;<br>@=
@ -145,7 +147,7 @@ static void scoop_write(void *opaque, hwaddr addr,<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0scoop_gpio_handler_update(s);<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>=C2=A0 =C2=A0 =C2=A0case SCOOP_GPWR:<b=
r>- =C2=A0 =C2=A0case SCOOP_GPRR:	/* GPRR is probably R/O in real HW */<br>=
+ =C2=A0 =C2=A0case SCOOP_GPRR: =C2=A0 =C2=A0/* GPRR is probably R/O in rea=
l HW */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;gpio_level =3D value &am=
p; s-&gt;gpio_dir;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0scoop_gpio_handler_=
update(s);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>@@ -166,10 +168,1=
1 @@ static void scoop_gpio_set(void *opaque, int line, int level)<br>=C2=
=A0{<br>=C2=A0 =C2=A0 =C2=A0ScoopInfo *s =3D (ScoopInfo *) opaque;<br>=C2=
=A0<br>- =C2=A0 =C2=A0if (level)<br>+ =C2=A0 =C2=A0if (level) {<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;gpio_level |=3D (1 &lt;&lt; line);<br>- =
=C2=A0 =C2=A0else<br>+ =C2=A0 =C2=A0} else {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0s-&gt;gpio_level &amp;=3D ~(1 &lt;&lt; line);<br>+ =C2=A0 =C2=A0}<br=
>=C2=A0}<br>=C2=A0<br>=C2=A0static void scoop_init(Object *obj)<br>@@ -203,=
7 +206,7 @@ static int scoop_post_load(void *opaque, int version_id)<br>=C2=
=A0 =C2=A0 =C2=A0return 0;<br>=C2=A0}<br>=C2=A0<br>-static bool is_version_=
0 (void *opaque, int version_id)<br>+static bool is_version_0(void *opaque,=
 int version_id)<br>=C2=A0{<br>=C2=A0 =C2=A0 =C2=A0return version_id =3D=3D=
 0;<br>=C2=A0}<br>@@ -265,7 +268,7 @@ type_init(scoop_register_types)<br>=
=C2=A0<br>=C2=A0/* Write the bootloader parameters memory area. =C2=A0*/<br=
>=C2=A0<br>-#define MAGIC_CHG(a, b, c, d)	((d &lt;&lt; 24) | (c &lt;&lt; 16=
) | (b &lt;&lt; 8) | a)<br>+#define MAGIC_CHG(a, b, c, d) =C2=A0 ((d &lt;&l=
t; 24) | (c &lt;&lt; 16) | (b &lt;&lt; 8) | a)<br>=C2=A0<br>=C2=A0static st=
ruct QEMU_PACKED sl_param_info {<br>=C2=A0 =C2=A0 =C2=A0uint32_t comadj_key=
word;<br>@@ -286,16 +289,16 @@ static struct QEMU_PACKED sl_param_info {<br=
>=C2=A0 =C2=A0 =C2=A0uint32_t phad_keyword;<br>=C2=A0 =C2=A0 =C2=A0int32_t =
phadadj;<br>=C2=A0} zaurus_bootparam =3D {<br>- =C2=A0 =C2=A0.comadj_keywor=
d	=3D MAGIC_CHG(&#39;C&#39;, &#39;M&#39;, &#39;A&#39;, &#39;D&#39;),<br>- =
=C2=A0 =C2=A0.comadj		=3D 125,<br>- =C2=A0 =C2=A0.uuid_keyword	=3D MAGIC_CH=
G(&#39;U&#39;, &#39;U&#39;, &#39;I&#39;, &#39;D&#39;),<br>- =C2=A0 =C2=A0.u=
uid		=3D { -1 },<br>- =C2=A0 =C2=A0.touch_keyword	=3D MAGIC_CHG(&#39;T&#39;=
, &#39;U&#39;, &#39;C&#39;, &#39;H&#39;),<br>- =C2=A0 =C2=A0.touch_xp		=3D =
-1,<br>- =C2=A0 =C2=A0.adadj_keyword	=3D MAGIC_CHG(&#39;B&#39;, &#39;V&#39;=
, &#39;A&#39;, &#39;D&#39;),<br>- =C2=A0 =C2=A0.adadj		=3D -1,<br>- =C2=A0 =
=C2=A0.phad_keyword	=3D MAGIC_CHG(&#39;P&#39;, &#39;H&#39;, &#39;A&#39;, &#=
39;D&#39;),<br>- =C2=A0 =C2=A0.phadadj		=3D 0x01,<br>+ =C2=A0 =C2=A0.comadj=
_keyword =C2=A0 =C2=A0 =3D MAGIC_CHG(&#39;C&#39;, &#39;M&#39;, &#39;A&#39;,=
 &#39;D&#39;),<br>+ =C2=A0 =C2=A0.comadj =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =3D 125,<br>+ =C2=A0 =C2=A0.uuid_keyword =C2=A0 =C2=A0 =C2=A0 =3D M=
AGIC_CHG(&#39;U&#39;, &#39;U&#39;, &#39;I&#39;, &#39;D&#39;),<br>+ =C2=A0 =
=C2=A0.uuid =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D { -1 },<br=
>+ =C2=A0 =C2=A0.touch_keyword =C2=A0 =C2=A0 =C2=A0=3D MAGIC_CHG(&#39;T&#39=
;, &#39;U&#39;, &#39;C&#39;, &#39;H&#39;),<br>+ =C2=A0 =C2=A0.touch_xp =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D -1,<br>+ =C2=A0 =C2=A0.adadj_keyword =
=C2=A0 =C2=A0 =C2=A0=3D MAGIC_CHG(&#39;B&#39;, &#39;V&#39;, &#39;A&#39;, &#=
39;D&#39;),<br>+ =C2=A0 =C2=A0.adadj =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0=3D -1,<br>+ =C2=A0 =C2=A0.phad_keyword =C2=A0 =C2=A0 =C2=A0 =3D =
MAGIC_CHG(&#39;P&#39;, &#39;H&#39;, &#39;A&#39;, &#39;D&#39;),<br>+ =C2=A0 =
=C2=A0.phadadj =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0x01,<br>=C2=A0=
};<br>=C2=A0<br>=C2=A0void sl_bootparam_write(hwaddr ptr)<br>diff --git a/h=
w/input/tsc2005.c b/hw/input/tsc2005.c<br>index 941f163d36..05094ab2b1 1006=
44<br>--- a/hw/input/tsc2005.c<br>+++ b/hw/input/tsc2005.c<br>@@ -28,10 +28=
,10 @@<br>=C2=A0#include &quot;migration/vmstate.h&quot;<br>=C2=A0#include =
&quot;trace.h&quot;<br>=C2=A0<br>-#define TSC_CUT_RESOLUTION(value, p)	((va=
lue) &gt;&gt; (16 - (p ? 12 : 10)))<br>+#define TSC_CUT_RESOLUTION(value, p=
) =C2=A0((value) &gt;&gt; (16 - (p ? 12 : 10)))<br>=C2=A0<br>=C2=A0typedef =
struct {<br>- =C2=A0 =C2=A0qemu_irq pint;	/* Combination of the nPENIRQ and=
 DAV signals */<br>+ =C2=A0 =C2=A0qemu_irq pint; =C2=A0/* Combination of th=
e nPENIRQ and DAV signals */<br>=C2=A0 =C2=A0 =C2=A0QEMUTimer *timer;<br>=
=C2=A0 =C2=A0 =C2=A0uint16_t model;<br>=C2=A0<br>@@ -63,7 +63,7 @@ typedef =
struct {<br>=C2=A0} TSC2005State;<br>=C2=A0<br>=C2=A0enum {<br>- =C2=A0 =C2=
=A0TSC_MODE_XYZ_SCAN	=3D 0x0,<br>+ =C2=A0 =C2=A0TSC_MODE_XYZ_SCAN =3D 0x0,<=
br>=C2=A0 =C2=A0 =C2=A0TSC_MODE_XY_SCAN,<br>=C2=A0 =C2=A0 =C2=A0TSC_MODE_X,=
<br>=C2=A0 =C2=A0 =C2=A0TSC_MODE_Y,<br>@@ -82,100 +82,100 @@ enum {<br>=C2=
=A0};<br>=C2=A0<br>=C2=A0static const uint16_t mode_regs[16] =3D {<br>- =C2=
=A0 =C2=A00xf000,	/* X, Y, Z scan */<br>- =C2=A0 =C2=A00xc000,	/* X, Y scan=
 */<br>- =C2=A0 =C2=A00x8000,	/* X */<br>- =C2=A0 =C2=A00x4000,	/* Y */<br>=
- =C2=A0 =C2=A00x3000,	/* Z */<br>- =C2=A0 =C2=A00x0800,	/* AUX */<br>- =C2=
=A0 =C2=A00x0400,	/* TEMP1 */<br>- =C2=A0 =C2=A00x0200,	/* TEMP2 */<br>- =
=C2=A0 =C2=A00x0800,	/* AUX scan */<br>- =C2=A0 =C2=A00x0040,	/* X test */<=
br>- =C2=A0 =C2=A00x0020,	/* Y test */<br>- =C2=A0 =C2=A00x0080,	/* Short-c=
ircuit test */<br>- =C2=A0 =C2=A00x0000,	/* Reserved */<br>- =C2=A0 =C2=A00=
x0000,	/* X+, X- drivers */<br>- =C2=A0 =C2=A00x0000,	/* Y+, Y- drivers */<=
br>- =C2=A0 =C2=A00x0000,	/* Y+, X- drivers */<br>+ =C2=A0 =C2=A00xf000, /*=
 X, Y, Z scan */<br>+ =C2=A0 =C2=A00xc000, /* X, Y scan */<br>+ =C2=A0 =C2=
=A00x8000, /* X */<br>+ =C2=A0 =C2=A00x4000, /* Y */<br>+ =C2=A0 =C2=A00x30=
00, /* Z */<br>+ =C2=A0 =C2=A00x0800, /* AUX */<br>+ =C2=A0 =C2=A00x0400, /=
* TEMP1 */<br>+ =C2=A0 =C2=A00x0200, /* TEMP2 */<br>+ =C2=A0 =C2=A00x0800, =
/* AUX scan */<br>+ =C2=A0 =C2=A00x0040, /* X test */<br>+ =C2=A0 =C2=A00x0=
020, /* Y test */<br>+ =C2=A0 =C2=A00x0080, /* Short-circuit test */<br>+ =
=C2=A0 =C2=A00x0000, /* Reserved */<br>+ =C2=A0 =C2=A00x0000, /* X+, X- dri=
vers */<br>+ =C2=A0 =C2=A00x0000, /* Y+, Y- drivers */<br>+ =C2=A0 =C2=A00x=
0000, /* Y+, X- drivers */<br>=C2=A0};<br>=C2=A0<br>-#define X_TRANSFORM(s)=
			\<br>+#define X_TRANSFORM(s) =C2=A0 =C2=A0 =C2=A0\<br>=C2=A0 =C2=A0 =C2=
=A0((s-&gt;y * s-&gt;tr[0] - s-&gt;x * s-&gt;tr[1]) / s-&gt;tr[2] + s-&gt;t=
r[3])<br>-#define Y_TRANSFORM(s)			\<br>+#define Y_TRANSFORM(s) =C2=A0 =C2=
=A0 =C2=A0\<br>=C2=A0 =C2=A0 =C2=A0((s-&gt;y * s-&gt;tr[4] - s-&gt;x * s-&g=
t;tr[5]) / s-&gt;tr[6] + s-&gt;tr[7])<br>-#define Z1_TRANSFORM(s)			\<br>+#=
define Z1_TRANSFORM(s) =C2=A0 =C2=A0 \<br>=C2=A0 =C2=A0 =C2=A0((400 - ((s)-=
&gt;x &gt;&gt; 7) + ((s)-&gt;pressure &lt;&lt; 10)) &lt;&lt; 4)<br>-#define=
 Z2_TRANSFORM(s)			\<br>+#define Z2_TRANSFORM(s) =C2=A0 =C2=A0 \<br>=C2=A0 =
=C2=A0 =C2=A0((4000 + ((s)-&gt;y &gt;&gt; 7) - ((s)-&gt;pressure &lt;&lt; 1=
0)) &lt;&lt; 4)<br>=C2=A0<br>-#define AUX_VAL				(700 &lt;&lt; 4)	/* +/- 3 =
at 12-bit */<br>-#define TEMP1_VAL			(1264 &lt;&lt; 4)	/* +/- 5 at 12-bit *=
/<br>-#define TEMP2_VAL			(1531 &lt;&lt; 4)	/* +/- 5 at 12-bit */<br>+#defi=
ne AUX_VAL =C2=A0 =C2=A0 =C2=A0 (700 &lt;&lt; 4) =C2=A0/* +/- 3 at 12-bit *=
/<br>+#define TEMP1_VAL =C2=A0 =C2=A0 (1264 &lt;&lt; 4) /* +/- 5 at 12-bit =
*/<br>+#define TEMP2_VAL =C2=A0 =C2=A0 (1531 &lt;&lt; 4) /* +/- 5 at 12-bit=
 */<br>=C2=A0<br>=C2=A0static uint16_t tsc2005_read(TSC2005State *s, int re=
g)<br>=C2=A0{<br>=C2=A0 =C2=A0 =C2=A0uint16_t ret;<br>=C2=A0<br>=C2=A0 =C2=
=A0 =C2=A0switch (reg) {<br>- =C2=A0 =C2=A0case 0x0:	/* X */<br>+ =C2=A0 =
=C2=A0case 0x0: /* X */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;dav &amp=
;=3D ~mode_regs[TSC_MODE_X];<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return TS=
C_CUT_RESOLUTION(X_TRANSFORM(s), s-&gt;precision) +<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(s-&gt;noise &amp; 3);<br>- =C2=
=A0 =C2=A0case 0x1:	/* Y */<br>+ =C2=A0 =C2=A0case 0x1: /* Y */<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;dav &amp;=3D ~mode_regs[TSC_MODE_Y];<br>- =
=C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;noise ++;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0=
s-&gt;noise++;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return TSC_CUT_RESOLUTI=
ON(Y_TRANSFORM(s), s-&gt;precision) ^<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0(s-&gt;noise &amp; 3);<br>- =C2=A0 =C2=A0case 0=
x2:	/* Z1 */<br>+ =C2=A0 =C2=A0case 0x2: /* Z1 */<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0s-&gt;dav &amp;=3D 0xdfff;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0return TSC_CUT_RESOLUTION(Z1_TRANSFORM(s), s-&gt;precision) -<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(s-&gt;noise &amp; 3=
);<br>- =C2=A0 =C2=A0case 0x3:	/* Z2 */<br>+ =C2=A0 =C2=A0case 0x3: /* Z2 *=
/<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;dav &amp;=3D 0xefff;<br>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0return TSC_CUT_RESOLUTION(Z2_TRANSFORM(s), s-&g=
t;precision) |<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(s-&gt;noise &amp; 3);<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x4:	/* AUX *=
/<br>+ =C2=A0 =C2=A0case 0x4: /* AUX */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0s-&gt;dav &amp;=3D ~mode_regs[TSC_MODE_AUX];<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return TSC_CUT_RESOLUTION(AUX_VAL, s-&gt;precision);<br>=C2=A0<br=
>- =C2=A0 =C2=A0case 0x5:	/* TEMP1 */<br>+ =C2=A0 =C2=A0case 0x5: /* TEMP1 =
*/<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;dav &amp;=3D ~mode_regs[TSC_M=
ODE_TEMP1];<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return TSC_CUT_RESOLUTION(=
TEMP1_VAL, s-&gt;precision) -<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0(s-&gt;noise &amp; 5);<br>- =C2=A0 =C2=A0case 0x6:	/* T=
EMP2 */<br>+ =C2=A0 =C2=A0case 0x6: /* TEMP2 */<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0s-&gt;dav &amp;=3D 0xdfff;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s=
-&gt;dav &amp;=3D ~mode_regs[TSC_MODE_TEMP2];<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return TSC_CUT_RESOLUTION(TEMP2_VAL, s-&gt;precision) ^<br>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(s-&gt;noise &amp; =
3);<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x7:	/* Status */<br>+ =C2=A0 =C2=A0ca=
se 0x7: /* Status */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D s-&gt;dav=
 | (s-&gt;reset &lt;&lt; 7) | (s-&gt;pdst &lt;&lt; 2) | 0x0;<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;dav &amp;=3D ~(mode_regs[TSC_MODE_X_TEST] | m=
ode_regs[TSC_MODE_Y_TEST] |<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mode_regs[TSC_MODE_TS_TEST]=
);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;reset =3D true;<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x8: =
=C2=A0 /* AUX high threshold */<br>+ =C2=A0 =C2=A0case 0x8: /* AUX high thr=
eshold */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return s-&gt;aux_thr[1];<br>=
- =C2=A0 =C2=A0case 0x9: =C2=A0 /* AUX low threshold */<br>+ =C2=A0 =C2=A0c=
ase 0x9: /* AUX low threshold */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retur=
n s-&gt;aux_thr[0];<br>=C2=A0<br>- =C2=A0 =C2=A0case 0xa: =C2=A0 /* TEMP hi=
gh threshold */<br>+ =C2=A0 =C2=A0case 0xa: /* TEMP high threshold */<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return s-&gt;temp_thr[1];<br>- =C2=A0 =C2=
=A0case 0xb: =C2=A0 /* TEMP low threshold */<br>+ =C2=A0 =C2=A0case 0xb: /*=
 TEMP low threshold */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return s-&gt;te=
mp_thr[0];<br>=C2=A0<br>- =C2=A0 =C2=A0case 0xc:	/* CFR0 */<br>+ =C2=A0 =C2=
=A0case 0xc: /* CFR0 */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return (s-&gt;=
pressure &lt;&lt; 15) | ((!s-&gt;busy) &lt;&lt; 14) |<br>- =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(s-&gt;nextprecision &lt;&lt; 13) =
| s-&gt;timing[0]; <br>- =C2=A0 =C2=A0case 0xd:	/* CFR1 */<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(s-&gt;nextprecision &lt;&lt; =
13) | s-&gt;timing[0];<br>+ =C2=A0 =C2=A0case 0xd: /* CFR1 */<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0return s-&gt;timing[1];<br>- =C2=A0 =C2=A0case 0xe:=
	/* CFR2 */<br>+ =C2=A0 =C2=A0case 0xe: /* CFR2 */<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return (s-&gt;pin_func &lt;&lt; 14) | s-&gt;filter;<br>=C2=A0<=
br>- =C2=A0 =C2=A0case 0xf:	/* Function select status */<br>+ =C2=A0 =C2=A0=
case 0xf: /* Function select status */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0return s-&gt;function &gt;=3D 0 ? 1 &lt;&lt; s-&gt;function : 0;<br>=C2=
=A0 =C2=A0 =C2=A0}<br>=C2=A0<br>@@ -200,13 +200,14 @@ static void tsc2005_w=
rite(TSC2005State *s, int reg, uint16_t data)<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0s-&gt;temp_thr[0] =3D data;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
break;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0xc:	/* CFR0 */<br>+ =C2=A0 =C2=A0c=
ase 0xc: /* CFR0 */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;host_mode =
=3D (data &gt;&gt; 15) !=3D 0;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&=
gt;enabled !=3D !(data &amp; 0x4000)) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0s-&gt;enabled =3D !(data &amp; 0x4000);<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_tsc2005_sense(s-&gt;enabled ? &quot=
;enabled&quot; : &quot;disabled&quot;);<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0if (s-&gt;busy &amp;&amp; !s-&gt;enabled)<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;busy &amp;&amp; !s-&gt;enabled) {<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0timer_del(s-&=
gt;timer);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;busy =3D s-&gt;busy &amp;&amp; s-&=
gt;enabled;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0s-&gt;nextprecision =3D (data &gt;&gt; 13) &amp; 1;<br>@@ -216=
,10 +217,10 @@ static void tsc2005_write(TSC2005State *s, int reg, uint16_t=
 data)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;tsc2005_write: illegal conversion c=
lock setting\n&quot;);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0break;<br>- =C2=A0 =C2=A0case 0xd:	/* CFR1 */<br>+ =
=C2=A0 =C2=A0case 0xd: /* CFR1 */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&g=
t;timing[1] =3D data &amp; 0xf07;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0brea=
k;<br>- =C2=A0 =C2=A0case 0xe:	/* CFR2 */<br>+ =C2=A0 =C2=A0case 0xe: /* CF=
R2 */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;pin_func =3D (data &gt;&gt=
; 14) &amp; 3;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;filter =3D data &=
amp; 0x3fff;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>@@ -258,10 +259=
,12 @@ static void tsc2005_pin_update(TSC2005State *s)<br>=C2=A0 =C2=A0 =C2=
=A0switch (s-&gt;nextfunction) {<br>=C2=A0 =C2=A0 =C2=A0case TSC_MODE_XYZ_S=
CAN:<br>=C2=A0 =C2=A0 =C2=A0case TSC_MODE_XY_SCAN:<br>- =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (!s-&gt;host_mode &amp;&amp; s-&gt;dav)<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (!s-&gt;host_mode &amp;&amp; s-&gt;dav) {<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;enabled =3D false;<br>- =C2=A0 =C2=A0 =
=C2=A0 =C2=A0if (!s-&gt;pressure)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!s-&gt;pressure) {<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Fall through */<br>=C2=A0 =C2=A0 =C2=A0ca=
se TSC_MODE_AUX_SCAN:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>@@ -26=
9,8 +272,9 @@ static void tsc2005_pin_update(TSC2005State *s)<br>=C2=A0 =C2=
=A0 =C2=A0case TSC_MODE_X:<br>=C2=A0 =C2=A0 =C2=A0case TSC_MODE_Y:<br>=C2=
=A0 =C2=A0 =C2=A0case TSC_MODE_Z:<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!s-&g=
t;pressure)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!s-&gt;pressure) {<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Fall through */<br>=C2=
=A0 =C2=A0 =C2=A0case TSC_MODE_AUX:<br>=C2=A0 =C2=A0 =C2=A0case TSC_MODE_TE=
MP1:<br>@@ -278,8 +282,9 @@ static void tsc2005_pin_update(TSC2005State *s)=
<br>=C2=A0 =C2=A0 =C2=A0case TSC_MODE_X_TEST:<br>=C2=A0 =C2=A0 =C2=A0case T=
SC_MODE_Y_TEST:<br>=C2=A0 =C2=A0 =C2=A0case TSC_MODE_TS_TEST:<br>- =C2=A0 =
=C2=A0 =C2=A0 =C2=A0if (s-&gt;dav)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&g=
t;dav) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;enabled =
=3D false;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0break;<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0case TSC_MODE_RESERVED:<br>@=
@ -290,13 +295,14 @@ static void tsc2005_pin_update(TSC2005State *s)<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0<b=
r>- =C2=A0 =C2=A0if (!s-&gt;enabled || s-&gt;busy)<br>+ =C2=A0 =C2=A0if (!s=
-&gt;enabled || s-&gt;busy) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<=
br>+ =C2=A0 =C2=A0}<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0s-&gt;busy =3D true;<b=
r>=C2=A0 =C2=A0 =C2=A0s-&gt;precision =3D s-&gt;nextprecision;<br>=C2=A0 =
=C2=A0 =C2=A0s-&gt;function =3D s-&gt;nextfunction;<br>- =C2=A0 =C2=A0s-&gt=
;pdst =3D !s-&gt;pnd0;	/* Synchronised on internal clock */<br>+ =C2=A0 =C2=
=A0s-&gt;pdst =3D !s-&gt;pnd0; /* Synchronised on internal clock */<br>=C2=
=A0 =C2=A0 =C2=A0expires =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(NANOSECONDS_PER_SECOND &gt;&gt; 7);<br>=C2=
=A0 =C2=A0 =C2=A0timer_mod(s-&gt;timer, expires);<br>@@ -331,7 +337,7 @@ st=
atic uint8_t tsc2005_txrx_word(void *opaque, uint8_t value)<br>=C2=A0 =C2=
=A0 =C2=A0TSC2005State *s =3D opaque;<br>=C2=A0 =C2=A0 =C2=A0uint32_t ret =
=3D 0;<br>=C2=A0<br>- =C2=A0 =C2=A0switch (s-&gt;state ++) {<br>+ =C2=A0 =
=C2=A0switch (s-&gt;state++) {<br>=C2=A0 =C2=A0 =C2=A0case 0:<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0if (value &amp; 0x80) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0/* Command */<br>@@ -343,8 +349,9 @@ static uint8_t=
 tsc2005_txrx_word(void *opaque, uint8_t value)<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;enabled !=3D !(value &amp; =
1)) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0s-&gt;enabled =3D !(value &amp; 1);<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_tsc2005_sense(s-&=
gt;enabled ? &quot;enabled&quot; : &quot;disabled&quot;);<br>- =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;busy &=
amp;&amp; !s-&gt;enabled)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;busy &amp;&amp; !s-&gt;enabled) {<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0timer_del(s-&gt;timer);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;busy =3D s-&gt;busy &=
amp;&amp; s-&gt;enabled;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0tsc2005_pin_update(s);<br>@@ -368,10 +375,11 @@ static uint8_t ts=
c2005_txrx_word(void *opaque, uint8_t value)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0break;<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0case 1:<br>- =C2=A0 =C2=A0 =
=C2=A0 =C2=A0if (s-&gt;command)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;c=
ommand) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D (s-&gt=
;data &gt;&gt; 8) &amp; 0xff;<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0s-&gt;data |=3D value &lt;&lt; 8;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0}<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>=C2=A0<br>=C2=A0 =C2=A0=
 =C2=A0case 2:<br>@@ -409,8 +417,9 @@ static void tsc2005_timer_tick(void *=
opaque)<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0/* Timer ticked -- a set of conver=
sions has been finished. =C2=A0*/<br>=C2=A0<br>- =C2=A0 =C2=A0if (!s-&gt;bu=
sy)<br>+ =C2=A0 =C2=A0if (!s-&gt;busy) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0return;<br>+ =C2=A0 =C2=A0}<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0s-&gt;busy =
=3D false;<br>=C2=A0 =C2=A0 =C2=A0s-&gt;dav |=3D mode_regs[s-&gt;function];=
<br>@@ -435,8 +444,9 @@ static void tsc2005_touchscreen_event(void *opaque,=
<br>=C2=A0 =C2=A0 =C2=A0 * signaling TS events immediately, but for now we =
simulate<br>=C2=A0 =C2=A0 =C2=A0 * the first conversion delay for sake of c=
orrectness.<br>=C2=A0 =C2=A0 =C2=A0 */<br>- =C2=A0 =C2=A0if (p !=3D s-&gt;p=
ressure)<br>+ =C2=A0 =C2=A0if (p !=3D s-&gt;pressure) {<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0tsc2005_pin_update(s);<br>+ =C2=A0 =C2=A0}<br>=C2=A0}<b=
r>=C2=A0<br>=C2=A0static int tsc2005_post_load(void *opaque, int version_id=
)<br>diff --git a/hw/input/tsc210x.c b/hw/input/tsc210x.c<br>index c4e32c7a=
42..b94e346af1 100644<br>--- a/hw/input/tsc210x.c<br>+++ b/hw/input/tsc210x=
.c<br>@@ -33,13 +33,13 @@<br>=C2=A0#include &quot;migration/vmstate.h&quot;=
<br>=C2=A0#include &quot;qapi/error.h&quot;<br>=C2=A0<br>-#define TSC_DATA_=
REGISTERS_PAGE		0x0<br>-#define TSC_CONTROL_REGISTERS_PAGE	0x1<br>-#define =
TSC_AUDIO_REGISTERS_PAGE	0x2<br>+#define TSC_DATA_REGISTERS_PAGE =C2=A0 =C2=
=A0 0x0<br>+#define TSC_CONTROL_REGISTERS_PAGE =C2=A00x1<br>+#define TSC_AU=
DIO_REGISTERS_PAGE =C2=A0 =C2=A00x2<br>=C2=A0<br>=C2=A0#define TSC_VERBOSE<=
br>=C2=A0<br>-#define TSC_CUT_RESOLUTION(value, p)	((value) &gt;&gt; (16 - =
resolution[p]))<br>+#define TSC_CUT_RESOLUTION(value, p) =C2=A0((value) &gt=
;&gt; (16 - resolution[p]))<br>=C2=A0<br>=C2=A0typedef struct {<br>=C2=A0 =
=C2=A0 =C2=A0qemu_irq pint;<br>@@ -105,60 +105,60 @@ typedef struct {<br>=
=C2=A0<br>=C2=A0static const int resolution[4] =3D { 12, 8, 10, 12 };<br>=
=C2=A0<br>-#define TSC_MODE_NO_SCAN	0x0<br>-#define TSC_MODE_XY_SCAN	0x1<br=
>-#define TSC_MODE_XYZ_SCAN	0x2<br>-#define TSC_MODE_X		0x3<br>-#define TSC=
_MODE_Y		0x4<br>-#define TSC_MODE_Z		0x5<br>-#define TSC_MODE_BAT1		0x6<br>=
-#define TSC_MODE_BAT2		0x7<br>-#define TSC_MODE_AUX		0x8<br>-#define TSC_M=
ODE_AUX_SCAN	0x9<br>-#define TSC_MODE_TEMP1		0xa<br>-#define TSC_MODE_PORT_=
SCAN	0xb<br>-#define TSC_MODE_TEMP2		0xc<br>-#define TSC_MODE_XX_DRV		0xd<b=
r>-#define TSC_MODE_YY_DRV		0xe<br>-#define TSC_MODE_YX_DRV		0xf<br>+#defin=
e TSC_MODE_NO_SCAN =C2=A0 =C2=A00x0<br>+#define TSC_MODE_XY_SCAN =C2=A0 =C2=
=A00x1<br>+#define TSC_MODE_XYZ_SCAN =C2=A0 0x2<br>+#define TSC_MODE_X =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x3<br>+#define TSC_MODE_Y =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A00x4<br>+#define TSC_MODE_Z =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A00x5<br>+#define TSC_MODE_BAT1 =C2=A0 =C2=A0 =C2=A0 0x6<br>+#define TSC_M=
ODE_BAT2 =C2=A0 =C2=A0 =C2=A0 0x7<br>+#define TSC_MODE_AUX =C2=A0 =C2=A0 =
=C2=A0 =C2=A00x8<br>+#define TSC_MODE_AUX_SCAN =C2=A0 0x9<br>+#define TSC_M=
ODE_TEMP1 =C2=A0 =C2=A0 =C2=A00xa<br>+#define TSC_MODE_PORT_SCAN =C2=A00xb<=
br>+#define TSC_MODE_TEMP2 =C2=A0 =C2=A0 =C2=A00xc<br>+#define TSC_MODE_XX_=
DRV =C2=A0 =C2=A0 0xd<br>+#define TSC_MODE_YY_DRV =C2=A0 =C2=A0 0xe<br>+#de=
fine TSC_MODE_YX_DRV =C2=A0 =C2=A0 0xf<br>=C2=A0<br>=C2=A0static const uint=
16_t mode_regs[16] =3D {<br>- =C2=A0 =C2=A00x0000,	/* No scan */<br>- =C2=
=A0 =C2=A00x0600,	/* X, Y scan */<br>- =C2=A0 =C2=A00x0780,	/* X, Y, Z scan=
 */<br>- =C2=A0 =C2=A00x0400,	/* X */<br>- =C2=A0 =C2=A00x0200,	/* Y */<br>=
- =C2=A0 =C2=A00x0180,	/* Z */<br>- =C2=A0 =C2=A00x0040,	/* BAT1 */<br>- =
=C2=A0 =C2=A00x0030,	/* BAT2 */<br>- =C2=A0 =C2=A00x0010,	/* AUX */<br>- =
=C2=A0 =C2=A00x0010,	/* AUX scan */<br>- =C2=A0 =C2=A00x0004,	/* TEMP1 */<b=
r>- =C2=A0 =C2=A00x0070,	/* Port scan */<br>- =C2=A0 =C2=A00x0002,	/* TEMP2=
 */<br>- =C2=A0 =C2=A00x0000,	/* X+, X- drivers */<br>- =C2=A0 =C2=A00x0000=
,	/* Y+, Y- drivers */<br>- =C2=A0 =C2=A00x0000,	/* Y+, X- drivers */<br>+ =
=C2=A0 =C2=A00x0000, /* No scan */<br>+ =C2=A0 =C2=A00x0600, /* X, Y scan *=
/<br>+ =C2=A0 =C2=A00x0780, /* X, Y, Z scan */<br>+ =C2=A0 =C2=A00x0400, /*=
 X */<br>+ =C2=A0 =C2=A00x0200, /* Y */<br>+ =C2=A0 =C2=A00x0180, /* Z */<b=
r>+ =C2=A0 =C2=A00x0040, /* BAT1 */<br>+ =C2=A0 =C2=A00x0030, /* BAT2 */<br=
>+ =C2=A0 =C2=A00x0010, /* AUX */<br>+ =C2=A0 =C2=A00x0010, /* AUX scan */<=
br>+ =C2=A0 =C2=A00x0004, /* TEMP1 */<br>+ =C2=A0 =C2=A00x0070, /* Port sca=
n */<br>+ =C2=A0 =C2=A00x0002, /* TEMP2 */<br>+ =C2=A0 =C2=A00x0000, /* X+,=
 X- drivers */<br>+ =C2=A0 =C2=A00x0000, /* Y+, Y- drivers */<br>+ =C2=A0 =
=C2=A00x0000, /* Y+, X- drivers */<br>=C2=A0};<br>=C2=A0<br>-#define X_TRAN=
SFORM(s)			\<br>+#define X_TRANSFORM(s) =C2=A0 =C2=A0 =C2=A0\<br>=C2=A0 =C2=
=A0 =C2=A0((s-&gt;y * s-&gt;tr[0] - s-&gt;x * s-&gt;tr[1]) / s-&gt;tr[2] + =
s-&gt;tr[3])<br>-#define Y_TRANSFORM(s)			\<br>+#define Y_TRANSFORM(s) =C2=
=A0 =C2=A0 =C2=A0\<br>=C2=A0 =C2=A0 =C2=A0((s-&gt;y * s-&gt;tr[4] - s-&gt;x=
 * s-&gt;tr[5]) / s-&gt;tr[6] + s-&gt;tr[7])<br>-#define Z1_TRANSFORM(s)			=
\<br>+#define Z1_TRANSFORM(s) =C2=A0 =C2=A0 \<br>=C2=A0 =C2=A0 =C2=A0((400 =
- ((s)-&gt;x &gt;&gt; 7) + ((s)-&gt;pressure &lt;&lt; 10)) &lt;&lt; 4)<br>-=
#define Z2_TRANSFORM(s)			\<br>+#define Z2_TRANSFORM(s) =C2=A0 =C2=A0 \<br>=
=C2=A0 =C2=A0 =C2=A0((4000 + ((s)-&gt;y &gt;&gt; 7) - ((s)-&gt;pressure &lt=
;&lt; 10)) &lt;&lt; 4)<br>=C2=A0<br>-#define BAT1_VAL			0x8660<br>-#define =
BAT2_VAL			0x0000<br>-#define AUX1_VAL			0x35c0<br>-#define AUX2_VAL			0xff=
ff<br>-#define TEMP1_VAL			0x8c70<br>-#define TEMP2_VAL			0xa5b0<br>+#defin=
e BAT1_VAL =C2=A0 =C2=A0 =C2=A00x8660<br>+#define BAT2_VAL =C2=A0 =C2=A0 =
=C2=A00x0000<br>+#define AUX1_VAL =C2=A0 =C2=A0 =C2=A00x35c0<br>+#define AU=
X2_VAL =C2=A0 =C2=A0 =C2=A00xffff<br>+#define TEMP1_VAL =C2=A0 =C2=A0 0x8c7=
0<br>+#define TEMP2_VAL =C2=A0 =C2=A0 0xa5b0<br>=C2=A0<br>-#define TSC_POWE=
ROFF_DELAY		50<br>-#define TSC_SOFTSTEP_DELAY		50<br>+#define TSC_POWEROFF_=
DELAY =C2=A0 =C2=A050<br>+#define TSC_SOFTSTEP_DELAY =C2=A0 =C2=A050<br>=C2=
=A0<br>=C2=A0static void tsc210x_reset(TSC210xState *s)<br>=C2=A0{<br>@@ -2=
24,34 +224,34 @@ typedef struct {<br>=C2=A0 =C2=A0 =C2=A0int fsref;<br>=C2=
=A0} TSC210xRateInfo;<br>=C2=A0<br>-/* =C2=A0{ rate, =C2=A0 dsor, fsref }	*=
/<br>+/* =C2=A0{ rate, =C2=A0 dsor, fsref } */<br>=C2=A0static const TSC210=
xRateInfo tsc2102_rates[] =3D {<br>=C2=A0 =C2=A0 =C2=A0/* Fsref / 6.0 */<br=
>- =C2=A0 =C2=A0{ 7350,	63,	1 },<br>- =C2=A0 =C2=A0{ 8000,	63,	0 },<br>+ =
=C2=A0 =C2=A0{ 7350, 63, 1 },<br>+ =C2=A0 =C2=A0{ 8000, 63, 0 },<br>=C2=A0 =
=C2=A0 =C2=A0/* Fsref / 6.0 */<br>- =C2=A0 =C2=A0{ 7350,	54,	1 },<br>- =C2=
=A0 =C2=A0{ 8000,	54,	0 },<br>+ =C2=A0 =C2=A0{ 7350, 54, 1 },<br>+ =C2=A0 =
=C2=A0{ 8000, 54, 0 },<br>=C2=A0 =C2=A0 =C2=A0/* Fsref / 5.0 */<br>- =C2=A0=
 =C2=A0{ 8820,	45,	1 },<br>- =C2=A0 =C2=A0{ 9600,	45,	0 },<br>+ =C2=A0 =C2=
=A0{ 8820, 45, 1 },<br>+ =C2=A0 =C2=A0{ 9600, 45, 0 },<br>=C2=A0 =C2=A0 =C2=
=A0/* Fsref / 4.0 */<br>- =C2=A0 =C2=A0{ 11025,	36,	1 },<br>- =C2=A0 =C2=A0=
{ 12000,	36,	0 },<br>+ =C2=A0 =C2=A0{ 11025, 36, 1 },<br>+ =C2=A0 =C2=A0{ 1=
2000, 36, 0 },<br>=C2=A0 =C2=A0 =C2=A0/* Fsref / 3.0 */<br>- =C2=A0 =C2=A0{=
 14700,	27,	1 },<br>- =C2=A0 =C2=A0{ 16000,	27,	0 },<br>+ =C2=A0 =C2=A0{ 14=
700, 27, 1 },<br>+ =C2=A0 =C2=A0{ 16000, 27, 0 },<br>=C2=A0 =C2=A0 =C2=A0/*=
 Fsref / 2.0 */<br>- =C2=A0 =C2=A0{ 22050,	18,	1 },<br>- =C2=A0 =C2=A0{ 240=
00,	18,	0 },<br>+ =C2=A0 =C2=A0{ 22050, 18, 1 },<br>+ =C2=A0 =C2=A0{ 24000,=
 18, 0 },<br>=C2=A0 =C2=A0 =C2=A0/* Fsref / 1.5 */<br>- =C2=A0 =C2=A0{ 2940=
0,	9,	1 },<br>- =C2=A0 =C2=A0{ 32000,	9,	0 },<br>+ =C2=A0 =C2=A0{ 29400, 9,=
 1 },<br>+ =C2=A0 =C2=A0{ 32000, 9, 0 },<br>=C2=A0 =C2=A0 =C2=A0/* Fsref */=
<br>- =C2=A0 =C2=A0{ 44100,	0,	1 },<br>- =C2=A0 =C2=A0{ 48000,	0,	0 },<br>+=
 =C2=A0 =C2=A0{ 44100, 0, 1 },<br>+ =C2=A0 =C2=A0{ 48000, 0, 0 },<br>=C2=A0=
<br>- =C2=A0 =C2=A0{ 0,	0, 	0 },<br>+ =C2=A0 =C2=A0{ 0, 0, 0 },<br>=C2=A0};=
<br>=C2=A0<br>=C2=A0static inline void tsc210x_out_flush(TSC210xState *s, i=
nt len)<br>@@ -259,12 +259,14 @@ static inline void tsc210x_out_flush(TSC21=
0xState *s, int len)<br>=C2=A0 =C2=A0 =C2=A0uint8_t *data =3D s-&gt;codec.o=
ut.fifo + s-&gt;codec.out.start;<br>=C2=A0 =C2=A0 =C2=A0uint8_t *end =3D da=
ta + len;<br>=C2=A0<br>- =C2=A0 =C2=A0while (data &lt; end)<br>+ =C2=A0 =C2=
=A0while (data &lt; end) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data +=3D A=
UD_write(s-&gt;dac_voice[0], data, end - data) ?: (end - data);<br>+ =C2=A0=
 =C2=A0}<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0s-&gt;codec.out.len -=3D len;<br>=
- =C2=A0 =C2=A0if (s-&gt;codec.out.len)<br>+ =C2=A0 =C2=A0if (s-&gt;codec.o=
ut.len) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memmove(s-&gt;codec.out.fifo=
, end, s-&gt;codec.out.len);<br>+ =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0s-&=
gt;codec.out.start =3D 0;<br>=C2=A0}<br>=C2=A0<br>@@ -285,11 +287,12 @@ sta=
tic void tsc2102_audio_rate_update(TSC210xState *s)<br>=C2=A0<br>=C2=A0 =C2=
=A0 =C2=A0s-&gt;codec.tx_rate =3D 0;<br>=C2=A0 =C2=A0 =C2=A0s-&gt;codec.rx_=
rate =3D 0;<br>- =C2=A0 =C2=A0if (s-&gt;dac_power &amp; (1 &lt;&lt; 15))			=
	/* PWDNC */<br>+ =C2=A0 =C2=A0if (s-&gt;dac_power &amp; (1 &lt;&lt; 15)) {=
 =C2=A0 =C2=A0 /* PWDNC */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>=
+ =C2=A0 }<br>=C2=A0<br>- =C2=A0 =C2=A0for (rate =3D tsc2102_rates; rate-&g=
t;rate; rate ++)<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rate-&gt;dsor =3D=3D (=
s-&gt;audio_ctrl1 &amp; 0x3f) &amp;&amp;		/* DACFS */<br>+ =C2=A0 =C2=A0for=
 (rate =3D tsc2102_rates; rate-&gt;rate; rate++)<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0if (rate-&gt;dsor =3D=3D (s-&gt;audio_ctrl1 &amp; 0x3f) &amp;&amp; =
=C2=A0 =C2=A0/* DACFS */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rate-&gt;fsref =3D=3D ((s-&gt;=
audio_ctrl3 &gt;&gt; 13) &amp; 1))/* REFFS */<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0break;<br>=C2=A0 =C2=A0 =C2=A0if (!rate-&gt;rate) {=
<br>@@ -315,10 +318,11 @@ static void tsc2102_audio_output_update(TSC210xSt=
ate *s)<br>=C2=A0 =C2=A0 =C2=A0s-&gt;codec.cts =3D 0;<br>=C2=A0<br>=C2=A0 =
=C2=A0 =C2=A0enable =3D<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(~s-&=
gt;dac_power &amp; (1 &lt;&lt; 15)) &amp;&amp;			/* PWDNC */<br>- =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(~s-&gt;dac_power &amp; (1 &lt;&lt; 10));=
			/* DAPWDN */<br>- =C2=A0 =C2=A0if (!enable || !s-&gt;codec.tx_rate)<br>+=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(~s-&gt;dac_power &amp; (1 &lt;&l=
t; 15)) &amp;&amp; =C2=A0 =C2=A0 /* PWDNC */<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0(~s-&gt;dac_power &amp; (1 &lt;&lt; 10)); =C2=A0 =C2=A0 =
=C2=A0 /* DAPWDN */<br>+ =C2=A0 =C2=A0if (!enable || !s-&gt;codec.tx_rate) =
{<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>+ =C2=A0 =C2=A0}<br>=C2=
=A0<br>=C2=A0 =C2=A0 =C2=A0/* Force our own sampling rate even in slave DAC=
 mode */<br>=C2=A0 =C2=A0 =C2=A0fmt.endianness =3D 0;<br>@@ -337,28 +341,28=
 @@ static void tsc2102_audio_output_update(TSC210xState *s)<br>=C2=A0stati=
c uint16_t tsc2102_data_register_read(TSC210xState *s, int reg)<br>=C2=A0{<=
br>=C2=A0 =C2=A0 =C2=A0switch (reg) {<br>- =C2=A0 =C2=A0case 0x00:	/* X */<=
br>+ =C2=A0 =C2=A0case 0x00: =C2=A0/* X */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0s-&gt;dav &amp;=3D 0xfbff;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retur=
n TSC_CUT_RESOLUTION(X_TRANSFORM(s), s-&gt;precision) +<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(s-&gt;noise &amp; 3);<br>=
=C2=A0<br>- =C2=A0 =C2=A0case 0x01:	/* Y */<br>- =C2=A0 =C2=A0 =C2=A0 =C2=
=A0s-&gt;noise ++;<br>+ =C2=A0 =C2=A0case 0x01: =C2=A0/* Y */<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0s-&gt;noise++;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&=
gt;dav &amp;=3D 0xfdff;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return TSC_CUT=
_RESOLUTION(Y_TRANSFORM(s), s-&gt;precision) ^<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(s-&gt;noise &amp; 3);<br>=C2=A0<br>-=
 =C2=A0 =C2=A0case 0x02:	/* Z1 */<br>+ =C2=A0 =C2=A0case 0x02: =C2=A0/* Z1 =
*/<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;dav &amp;=3D 0xfeff;<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return TSC_CUT_RESOLUTION(Z1_TRANSFORM(s), s=
-&gt;precision) -<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0(s-&gt;noise &amp; 3);<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x03:	/* =
Z2 */<br>+ =C2=A0 =C2=A0case 0x03: =C2=A0/* Z2 */<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0s-&gt;dav &amp;=3D 0xff7f;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0return TSC_CUT_RESOLUTION(Z2_TRANSFORM(s), s-&gt;precision) |<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(s-&gt;noise &amp; 3=
);<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x04:	/* KPData */<br>+ =C2=A0 =C2=A0ca=
se 0x04: =C2=A0/* KPData */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((s-&gt=
;model &amp; 0xff00) =3D=3D 0x2300) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (s-&gt;kb.intr &amp;&amp; (s-&gt;kb.mode &amp; 2)) {<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;kb.intr=
 =3D 0;<br>@@ -369,34 +373,34 @@ static uint16_t tsc2102_data_register_read=
(TSC210xState *s, int reg)<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r=
eturn 0xffff;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x05:	/* BAT1 */<br>+ =C2=A0=
 =C2=A0case 0x05: =C2=A0/* BAT1 */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&=
gt;dav &amp;=3D 0xffbf;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return TSC_CUT=
_RESOLUTION(BAT1_VAL, s-&gt;precision) +<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(s-&gt;noise &amp; 6);<br>=C2=A0<br>- =C2=A0=
 =C2=A0case 0x06:	/* BAT2 */<br>+ =C2=A0 =C2=A0case 0x06: =C2=A0/* BAT2 */<=
br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;dav &amp;=3D 0xffdf;<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0return TSC_CUT_RESOLUTION(BAT2_VAL, s-&gt;precis=
ion);<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x07:	/* AUX1 */<br>+ =C2=A0 =C2=A0c=
ase 0x07: =C2=A0/* AUX1 */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;dav &=
amp;=3D 0xffef;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return TSC_CUT_RESOLUT=
ION(AUX1_VAL, s-&gt;precision);<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x08:	/* A=
UX2 */<br>+ =C2=A0 =C2=A0case 0x08: =C2=A0/* AUX2 */<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0s-&gt;dav &amp;=3D 0xfff7;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0return 0xffff;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x09:	/* TEMP1 */<br>=
+ =C2=A0 =C2=A0case 0x09: =C2=A0/* TEMP1 */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0s-&gt;dav &amp;=3D 0xfffb;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retur=
n TSC_CUT_RESOLUTION(TEMP1_VAL, s-&gt;precision) -<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(s-&gt;noise &amp; 5);<br>=C2=A0<b=
r>- =C2=A0 =C2=A0case 0x0a:	/* TEMP2 */<br>+ =C2=A0 =C2=A0case 0x0a: =C2=A0=
/* TEMP2 */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;dav &amp;=3D 0xfffd;=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return TSC_CUT_RESOLUTION(TEMP2_VAL, =
s-&gt;precision) ^<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0(s-&gt;noise &amp; 3);<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x0b:	/* =
DAC */<br>+ =C2=A0 =C2=A0case 0x0b: =C2=A0/* DAC */<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0s-&gt;dav &amp;=3D 0xfffe;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0return 0xffff;<br>=C2=A0<br>@@ -413,11 +417,11 @@ static uint16_t tsc210=
2_control_register_read(<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0TSC210xState *s, int reg)<br>=C2=A0{<br>=C2=A0 =C2=A0 =C2=
=A0switch (reg) {<br>- =C2=A0 =C2=A0case 0x00:	/* TSC ADC */<br>+ =C2=A0 =
=C2=A0case 0x00: =C2=A0/* TSC ADC */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r=
eturn (s-&gt;pressure &lt;&lt; 15) | ((!s-&gt;busy) &lt;&lt; 14) |<br>- =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(s-&gt;nextfunction &lt=
;&lt; 10) | (s-&gt;nextprecision &lt;&lt; 8) | s-&gt;filter; <br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(s-&gt;nextfunction &lt;&lt=
; 10) | (s-&gt;nextprecision &lt;&lt; 8) | s-&gt;filter;<br>=C2=A0<br>- =C2=
=A0 =C2=A0case 0x01:	/* Status / Keypad Control */<br>+ =C2=A0 =C2=A0case 0=
x01: =C2=A0/* Status / Keypad Control */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0if ((s-&gt;model &amp; 0xff00) =3D=3D 0x2100)<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0return (s-&gt;pin_func &lt;&lt; 14) | ((!s-&gt;e=
nabled) &lt;&lt; 13) |<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0(s-&gt;host_mode &lt;&lt; 12) | ((!!s-&gt;dav) &=
lt;&lt; 11) | s-&gt;dav;<br>@@ -425,29 +429,32 @@ static uint16_t tsc2102_c=
ontrol_register_read(<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0re=
turn (s-&gt;kb.intr &lt;&lt; 15) | ((s-&gt;kb.scan || !s-&gt;kb.down) &lt;&=
lt; 14) |<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0(s-&gt;kb.debounce &lt;&lt; 11);<br>=C2=A0<br>- =C2=A0 =C2=A0=
case 0x02:	/* DAC Control */<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((s-&gt;mod=
el &amp; 0xff00) =3D=3D 0x2300)<br>+ =C2=A0 =C2=A0case 0x02: =C2=A0/* DAC C=
ontrol */<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((s-&gt;model &amp; 0xff00) =
=3D=3D 0x2300) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return =
s-&gt;dac_power &amp; 0x8000;<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0goto bad_reg;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0<br>- =
=C2=A0 =C2=A0case 0x03:	/* Reference */<br>+ =C2=A0 =C2=A0case 0x03: =C2=A0=
/* Reference */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return s-&gt;ref;<br>=
=C2=A0<br>- =C2=A0 =C2=A0case 0x04:	/* Reset */<br>+ =C2=A0 =C2=A0case 0x04=
: =C2=A0/* Reset */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0xffff;<br>=
=C2=A0<br>- =C2=A0 =C2=A0case 0x05:	/* Configuration */<br>+ =C2=A0 =C2=A0c=
ase 0x05: =C2=A0/* Configuration */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0re=
turn s-&gt;timing;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x06:	/* Secondary conf=
iguration */<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((s-&gt;model &amp; 0xff00)=
 =3D=3D 0x2100)<br>+ =C2=A0 =C2=A0case 0x06: =C2=A0/* Secondary configurati=
on */<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((s-&gt;model &amp; 0xff00) =3D=3D=
 0x2100) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto bad_reg;=
<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret=
urn ((!s-&gt;dav) &lt;&lt; 15) | ((s-&gt;kb.mode &amp; 1) &lt;&lt; 14) | s-=
&gt;pll[2];<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x10:	/* Keypad Mask */<br>- =
=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((s-&gt;model &amp; 0xff00) =3D=3D 0x2100)<br=
>+ =C2=A0 =C2=A0case 0x10: =C2=A0/* Keypad Mask */<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if ((s-&gt;model &amp; 0xff00) =3D=3D 0x2100) {<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto bad_reg;<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0}<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return s-&gt;kb.mask;<br>=C2=
=A0<br>=C2=A0 =C2=A0 =C2=A0default:<br>@@ -466,19 +473,19 @@ static uint16_=
t tsc2102_audio_register_read(TSC210xState *s, int reg)<br>=C2=A0 =C2=A0 =
=C2=A0uint16_t val;<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0switch (reg) {<br>- =
=C2=A0 =C2=A0case 0x00:	/* Audio Control 1 */<br>+ =C2=A0 =C2=A0case 0x00: =
=C2=A0/* Audio Control 1 */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return s-&=
gt;audio_ctrl1;<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0case 0x01:<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0return 0xff00;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x0=
2:	/* DAC Volume Control */<br>+ =C2=A0 =C2=A0case 0x02: =C2=A0/* DAC Volum=
e Control */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return s-&gt;volume;<br>=
=C2=A0<br>=C2=A0 =C2=A0 =C2=A0case 0x03:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0return 0x8b00;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x04:	/* Audio Control 2=
 */<br>+ =C2=A0 =C2=A0case 0x04: =C2=A0/* Audio Control 2 */<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0l_ch =3D 1;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r_=
ch =3D 1;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;softstep &amp;&amp=
; !(s-&gt;dac_power &amp; (1 &lt;&lt; 10))) {<br>@@ -490,46 +497,46 @@ stat=
ic uint16_t tsc2102_audio_register_read(TSC210xState *s, int reg)<br>=C2=A0=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return s-&gt;audio_ctrl2 | (l_ch &lt;=
&lt; 3) | (r_ch &lt;&lt; 2);<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x05:	/* Ster=
eo DAC Power Control */<br>+ =C2=A0 =C2=A0case 0x05: =C2=A0/* Stereo DAC Po=
wer Control */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0x2aa0 | s-&gt;d=
ac_power |<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(((s-&gt;dac_power &amp; (1 &lt;&lt; 10)) &amp;&amp;<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(qemu_clock_get_ns(Q=
EMU_CLOCK_VIRTUAL) &gt;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 s-&gt;powerdown + TSC_POWEROFF_DELAY)) &lt;&lt; 6);<b=
r>=C2=A0<br>- =C2=A0 =C2=A0case 0x06:	/* Audio Control 3 */<br>+ =C2=A0 =C2=
=A0case 0x06: =C2=A0/* Audio Control 3 */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0val =3D s-&gt;audio_ctrl3 | 0x0001;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0s-&gt;audio_ctrl3 &amp;=3D 0xff3f;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0return val;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x07:	/* LCH_BASS_BOOST_N0 =
*/<br>- =C2=A0 =C2=A0case 0x08:	/* LCH_BASS_BOOST_N1 */<br>- =C2=A0 =C2=A0c=
ase 0x09:	/* LCH_BASS_BOOST_N2 */<br>- =C2=A0 =C2=A0case 0x0a:	/* LCH_BASS_=
BOOST_N3 */<br>- =C2=A0 =C2=A0case 0x0b:	/* LCH_BASS_BOOST_N4 */<br>- =C2=
=A0 =C2=A0case 0x0c:	/* LCH_BASS_BOOST_N5 */<br>- =C2=A0 =C2=A0case 0x0d:	/=
* LCH_BASS_BOOST_D1 */<br>- =C2=A0 =C2=A0case 0x0e:	/* LCH_BASS_BOOST_D2 */=
<br>- =C2=A0 =C2=A0case 0x0f:	/* LCH_BASS_BOOST_D4 */<br>- =C2=A0 =C2=A0cas=
e 0x10:	/* LCH_BASS_BOOST_D5 */<br>- =C2=A0 =C2=A0case 0x11:	/* RCH_BASS_BO=
OST_N0 */<br>- =C2=A0 =C2=A0case 0x12:	/* RCH_BASS_BOOST_N1 */<br>- =C2=A0 =
=C2=A0case 0x13:	/* RCH_BASS_BOOST_N2 */<br>- =C2=A0 =C2=A0case 0x14:	/* RC=
H_BASS_BOOST_N3 */<br>- =C2=A0 =C2=A0case 0x15:	/* RCH_BASS_BOOST_N4 */<br>=
- =C2=A0 =C2=A0case 0x16:	/* RCH_BASS_BOOST_N5 */<br>- =C2=A0 =C2=A0case 0x=
17:	/* RCH_BASS_BOOST_D1 */<br>- =C2=A0 =C2=A0case 0x18:	/* RCH_BASS_BOOST_=
D2 */<br>- =C2=A0 =C2=A0case 0x19:	/* RCH_BASS_BOOST_D4 */<br>- =C2=A0 =C2=
=A0case 0x1a:	/* RCH_BASS_BOOST_D5 */<br>+ =C2=A0 =C2=A0case 0x07: =C2=A0/*=
 LCH_BASS_BOOST_N0 */<br>+ =C2=A0 =C2=A0case 0x08: =C2=A0/* LCH_BASS_BOOST_=
N1 */<br>+ =C2=A0 =C2=A0case 0x09: =C2=A0/* LCH_BASS_BOOST_N2 */<br>+ =C2=
=A0 =C2=A0case 0x0a: =C2=A0/* LCH_BASS_BOOST_N3 */<br>+ =C2=A0 =C2=A0case 0=
x0b: =C2=A0/* LCH_BASS_BOOST_N4 */<br>+ =C2=A0 =C2=A0case 0x0c: =C2=A0/* LC=
H_BASS_BOOST_N5 */<br>+ =C2=A0 =C2=A0case 0x0d: =C2=A0/* LCH_BASS_BOOST_D1 =
*/<br>+ =C2=A0 =C2=A0case 0x0e: =C2=A0/* LCH_BASS_BOOST_D2 */<br>+ =C2=A0 =
=C2=A0case 0x0f: =C2=A0/* LCH_BASS_BOOST_D4 */<br>+ =C2=A0 =C2=A0case 0x10:=
 =C2=A0/* LCH_BASS_BOOST_D5 */<br>+ =C2=A0 =C2=A0case 0x11: =C2=A0/* RCH_BA=
SS_BOOST_N0 */<br>+ =C2=A0 =C2=A0case 0x12: =C2=A0/* RCH_BASS_BOOST_N1 */<b=
r>+ =C2=A0 =C2=A0case 0x13: =C2=A0/* RCH_BASS_BOOST_N2 */<br>+ =C2=A0 =C2=
=A0case 0x14: =C2=A0/* RCH_BASS_BOOST_N3 */<br>+ =C2=A0 =C2=A0case 0x15: =
=C2=A0/* RCH_BASS_BOOST_N4 */<br>+ =C2=A0 =C2=A0case 0x16: =C2=A0/* RCH_BAS=
S_BOOST_N5 */<br>+ =C2=A0 =C2=A0case 0x17: =C2=A0/* RCH_BASS_BOOST_D1 */<br=
>+ =C2=A0 =C2=A0case 0x18: =C2=A0/* RCH_BASS_BOOST_D2 */<br>+ =C2=A0 =C2=A0=
case 0x19: =C2=A0/* RCH_BASS_BOOST_D4 */<br>+ =C2=A0 =C2=A0case 0x1a: =C2=
=A0/* RCH_BASS_BOOST_D5 */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return s-&g=
t;filter_data[reg - 0x07];<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x1b:	/* PLL Pr=
ogrammability 1 */<br>+ =C2=A0 =C2=A0case 0x1b: =C2=A0/* PLL Programmabilit=
y 1 */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return s-&gt;pll[0];<br>=C2=A0<=
br>- =C2=A0 =C2=A0case 0x1c:	/* PLL Programmability 2 */<br>+ =C2=A0 =C2=A0=
case 0x1c: =C2=A0/* PLL Programmability 2 */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return s-&gt;pll[1];<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x1d:	/* Audio=
 Control 4 */<br>+ =C2=A0 =C2=A0case 0x1d: =C2=A0/* Audio Control 4 */<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return (!s-&gt;softstep) &lt;&lt; 14;<br>=
=C2=A0<br>=C2=A0 =C2=A0 =C2=A0default:<br>@@ -545,16 +552,16 @@ static void=
 tsc2102_data_register_write(<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0TSC210xState *s, int reg, uint16_t value)<br>=C2=A0{<br=
>=C2=A0 =C2=A0 =C2=A0switch (reg) {<br>- =C2=A0 =C2=A0case 0x00:	/* X */<br=
>- =C2=A0 =C2=A0case 0x01:	/* Y */<br>- =C2=A0 =C2=A0case 0x02:	/* Z1 */<br=
>- =C2=A0 =C2=A0case 0x03:	/* Z2 */<br>- =C2=A0 =C2=A0case 0x05:	/* BAT1 */=
<br>- =C2=A0 =C2=A0case 0x06:	/* BAT2 */<br>- =C2=A0 =C2=A0case 0x07:	/* AU=
X1 */<br>- =C2=A0 =C2=A0case 0x08:	/* AUX2 */<br>- =C2=A0 =C2=A0case 0x09:	=
/* TEMP1 */<br>- =C2=A0 =C2=A0case 0x0a:	/* TEMP2 */<br>+ =C2=A0 =C2=A0case=
 0x00: =C2=A0/* X */<br>+ =C2=A0 =C2=A0case 0x01: =C2=A0/* Y */<br>+ =C2=A0=
 =C2=A0case 0x02: =C2=A0/* Z1 */<br>+ =C2=A0 =C2=A0case 0x03: =C2=A0/* Z2 *=
/<br>+ =C2=A0 =C2=A0case 0x05: =C2=A0/* BAT1 */<br>+ =C2=A0 =C2=A0case 0x06=
: =C2=A0/* BAT2 */<br>+ =C2=A0 =C2=A0case 0x07: =C2=A0/* AUX1 */<br>+ =C2=
=A0 =C2=A0case 0x08: =C2=A0/* AUX2 */<br>+ =C2=A0 =C2=A0case 0x09: =C2=A0/*=
 TEMP1 */<br>+ =C2=A0 =C2=A0case 0x0a: =C2=A0/* TEMP2 */<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0return;<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0default:<br>@@=
 -567,18 +574,19 @@ static void tsc2102_control_register_write(<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TSC210xState *s, int=
 reg, uint16_t value)<br>=C2=A0{<br>=C2=A0 =C2=A0 =C2=A0switch (reg) {<br>-=
 =C2=A0 =C2=A0case 0x00:	/* TSC ADC */<br>+ =C2=A0 =C2=A0case 0x00: =C2=A0/=
* TSC ADC */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;host_mode =3D value=
 &gt;&gt; 15;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;enabled =3D !(valu=
e &amp; 0x4000);<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;busy &amp;&amp; =
!s-&gt;enabled)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;busy &amp;&amp; !=
s-&gt;enabled) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0timer_d=
el(s-&gt;timer);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0s-&gt;busy =3D s-&gt;busy &amp;&amp; s-&gt;enabled;<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;nextfunction =3D (value &gt;&gt; 10) &amp;=
 0xf;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;nextprecision =3D (value &=
gt;&gt; 8) &amp; 3;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;filter =3D v=
alue &amp; 0xff;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>=C2=A0<br>=
- =C2=A0 =C2=A0case 0x01:	/* Status / Keypad Control */<br>+ =C2=A0 =C2=A0c=
ase 0x01: =C2=A0/* Status / Keypad Control */<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if ((s-&gt;model &amp; 0xff00) =3D=3D 0x2100)<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;pin_func =3D value &gt;&gt; 14;<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else {<br>@@ -591,7 +599,7 @@ static void=
 tsc2102_control_register_write(<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>=C2=A0<br>- =C2=A0 =C2=A0case =
0x02:	/* DAC Control */<br>+ =C2=A0 =C2=A0case 0x02: =C2=A0/* DAC Control *=
/<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((s-&gt;model &amp; 0xff00) =3D=
=3D 0x2300) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;dac_=
power &amp;=3D 0x7fff;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s=
-&gt;dac_power |=3D 0x8000 &amp; value;<br>@@ -599,14 +607,15 @@ static voi=
d tsc2102_control_register_write(<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0goto bad_reg;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>=C2=
=A0<br>- =C2=A0 =C2=A0case 0x03:	/* Reference */<br>+ =C2=A0 =C2=A0case 0x0=
3: =C2=A0/* Reference */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;ref =3D=
 value &amp; 0x1f;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>=C2=A0<b=
r>- =C2=A0 =C2=A0case 0x04:	/* Reset */<br>+ =C2=A0 =C2=A0case 0x04: =C2=A0=
/* Reset */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (value =3D=3D 0xbb00) {=
<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;busy)<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;busy) {<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0timer_del(s-&gt;timer);<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0tsc210x_reset(s);<br>=C2=A0#ifdef TSC_VERBOSE<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>@@ -616,7 +625,7 @@ static void tsc2=
102_control_register_write(<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x0=
5:	/* Configuration */<br>+ =C2=A0 =C2=A0case 0x05: =C2=A0/* Configuration =
*/<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;timing =3D value &amp; 0x3f;<=
br>=C2=A0#ifdef TSC_VERBOSE<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (value =
&amp; ~0x3f)<br>@@ -625,16 +634,18 @@ static void tsc2102_control_register_=
write(<br>=C2=A0#endif<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>=C2=
=A0<br>- =C2=A0 =C2=A0case 0x06:	/* Secondary configuration */<br>- =C2=A0 =
=C2=A0 =C2=A0 =C2=A0if ((s-&gt;model &amp; 0xff00) =3D=3D 0x2100)<br>+ =C2=
=A0 =C2=A0case 0x06: =C2=A0/* Secondary configuration */<br>+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if ((s-&gt;model &amp; 0xff00) =3D=3D 0x2100) {<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto bad_reg;<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;kb.mode =3D value &g=
t;&gt; 14;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;pll[2] =3D value &amp=
; 0x3ffff;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>=C2=A0<br>- =C2=
=A0 =C2=A0case 0x10:	/* Keypad Mask */<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if (=
(s-&gt;model &amp; 0xff00) =3D=3D 0x2100)<br>+ =C2=A0 =C2=A0case 0x10: =C2=
=A0/* Keypad Mask */<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((s-&gt;model &amp;=
 0xff00) =3D=3D 0x2100) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0goto bad_reg;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0s-&gt;kb.mask =3D value;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
return;<br>=C2=A0<br>@@ -649,7 +660,7 @@ static void tsc2102_audio_register=
_write(<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TS=
C210xState *s, int reg, uint16_t value)<br>=C2=A0{<br>=C2=A0 =C2=A0 =C2=A0s=
witch (reg) {<br>- =C2=A0 =C2=A0case 0x00:	/* Audio Control 1 */<br>+ =C2=
=A0 =C2=A0case 0x00: =C2=A0/* Audio Control 1 */<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0s-&gt;audio_ctrl1 =3D value &amp; 0x0f3f;<br>=C2=A0#ifdef TSC_=
VERBOSE<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((value &amp; ~0x0f3f) || (=
(value &amp; 7) !=3D ((value &gt;&gt; 3) &amp; 7)))<br>@@ -668,7 +679,7 @@ =
static void tsc2102_audio_register_write(<br>=C2=A0#endif<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0return;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x02:	/* DAC V=
olume Control */<br>+ =C2=A0 =C2=A0case 0x02: =C2=A0/* DAC Volume Control *=
/<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;volume =3D value;<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;volume_change =3D qemu_clock_get_ns(QEMU_C=
LOCK_VIRTUAL);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>@@ -681,7 +6=
92,7 @@ static void tsc2102_audio_register_write(<br>=C2=A0#endif<br>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x04:	=
/* Audio Control 2 */<br>+ =C2=A0 =C2=A0case 0x04: =C2=A0/* Audio Control 2=
 */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;audio_ctrl2 =3D value &amp; =
0xf7f2;<br>=C2=A0#ifdef TSC_VERBOSE<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if=
 (value &amp; ~0xf7fd)<br>@@ -690,9 +701,10 @@ static void tsc2102_audio_re=
gister_write(<br>=C2=A0#endif<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<=
br>=C2=A0<br>- =C2=A0 =C2=A0case 0x05:	/* Stereo DAC Power Control */<br>- =
=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((value &amp; ~s-&gt;dac_power) &amp; (1 &lt;=
&lt; 10))<br>+ =C2=A0 =C2=A0case 0x05: =C2=A0/* Stereo DAC Power Control */=
<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((value &amp; ~s-&gt;dac_power) &amp; (=
1 &lt;&lt; 10)) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;=
powerdown =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;dac_power =
=3D value &amp; 0x9543;<br>=C2=A0#ifdef TSC_VERBOSE<br>@@ -704,7 +716,7 @@ =
static void tsc2102_audio_register_write(<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0tsc2102_audio_output_update(s);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
return;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x06:	/* Audio Control 3 */<br>+ =
=C2=A0 =C2=A0case 0x06: =C2=A0/* Audio Control 3 */<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0s-&gt;audio_ctrl3 &amp;=3D 0x00c0;<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0s-&gt;audio_ctrl3 |=3D value &amp; 0xf800;<br>=C2=A0#ifdef TSC=
_VERBOSE<br>@@ -715,30 +727,30 @@ static void tsc2102_audio_register_write(=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tsc2102_audio_output_update(s);<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>=C2=A0<br>- =C2=A0 =C2=A0case =
0x07:	/* LCH_BASS_BOOST_N0 */<br>- =C2=A0 =C2=A0case 0x08:	/* LCH_BASS_BOOS=
T_N1 */<br>- =C2=A0 =C2=A0case 0x09:	/* LCH_BASS_BOOST_N2 */<br>- =C2=A0 =
=C2=A0case 0x0a:	/* LCH_BASS_BOOST_N3 */<br>- =C2=A0 =C2=A0case 0x0b:	/* LC=
H_BASS_BOOST_N4 */<br>- =C2=A0 =C2=A0case 0x0c:	/* LCH_BASS_BOOST_N5 */<br>=
- =C2=A0 =C2=A0case 0x0d:	/* LCH_BASS_BOOST_D1 */<br>- =C2=A0 =C2=A0case 0x=
0e:	/* LCH_BASS_BOOST_D2 */<br>- =C2=A0 =C2=A0case 0x0f:	/* LCH_BASS_BOOST_=
D4 */<br>- =C2=A0 =C2=A0case 0x10:	/* LCH_BASS_BOOST_D5 */<br>- =C2=A0 =C2=
=A0case 0x11:	/* RCH_BASS_BOOST_N0 */<br>- =C2=A0 =C2=A0case 0x12:	/* RCH_B=
ASS_BOOST_N1 */<br>- =C2=A0 =C2=A0case 0x13:	/* RCH_BASS_BOOST_N2 */<br>- =
=C2=A0 =C2=A0case 0x14:	/* RCH_BASS_BOOST_N3 */<br>- =C2=A0 =C2=A0case 0x15=
:	/* RCH_BASS_BOOST_N4 */<br>- =C2=A0 =C2=A0case 0x16:	/* RCH_BASS_BOOST_N5=
 */<br>- =C2=A0 =C2=A0case 0x17:	/* RCH_BASS_BOOST_D1 */<br>- =C2=A0 =C2=A0=
case 0x18:	/* RCH_BASS_BOOST_D2 */<br>- =C2=A0 =C2=A0case 0x19:	/* RCH_BASS=
_BOOST_D4 */<br>- =C2=A0 =C2=A0case 0x1a:	/* RCH_BASS_BOOST_D5 */<br>+ =C2=
=A0 =C2=A0case 0x07: =C2=A0/* LCH_BASS_BOOST_N0 */<br>+ =C2=A0 =C2=A0case 0=
x08: =C2=A0/* LCH_BASS_BOOST_N1 */<br>+ =C2=A0 =C2=A0case 0x09: =C2=A0/* LC=
H_BASS_BOOST_N2 */<br>+ =C2=A0 =C2=A0case 0x0a: =C2=A0/* LCH_BASS_BOOST_N3 =
*/<br>+ =C2=A0 =C2=A0case 0x0b: =C2=A0/* LCH_BASS_BOOST_N4 */<br>+ =C2=A0 =
=C2=A0case 0x0c: =C2=A0/* LCH_BASS_BOOST_N5 */<br>+ =C2=A0 =C2=A0case 0x0d:=
 =C2=A0/* LCH_BASS_BOOST_D1 */<br>+ =C2=A0 =C2=A0case 0x0e: =C2=A0/* LCH_BA=
SS_BOOST_D2 */<br>+ =C2=A0 =C2=A0case 0x0f: =C2=A0/* LCH_BASS_BOOST_D4 */<b=
r>+ =C2=A0 =C2=A0case 0x10: =C2=A0/* LCH_BASS_BOOST_D5 */<br>+ =C2=A0 =C2=
=A0case 0x11: =C2=A0/* RCH_BASS_BOOST_N0 */<br>+ =C2=A0 =C2=A0case 0x12: =
=C2=A0/* RCH_BASS_BOOST_N1 */<br>+ =C2=A0 =C2=A0case 0x13: =C2=A0/* RCH_BAS=
S_BOOST_N2 */<br>+ =C2=A0 =C2=A0case 0x14: =C2=A0/* RCH_BASS_BOOST_N3 */<br=
>+ =C2=A0 =C2=A0case 0x15: =C2=A0/* RCH_BASS_BOOST_N4 */<br>+ =C2=A0 =C2=A0=
case 0x16: =C2=A0/* RCH_BASS_BOOST_N5 */<br>+ =C2=A0 =C2=A0case 0x17: =C2=
=A0/* RCH_BASS_BOOST_D1 */<br>+ =C2=A0 =C2=A0case 0x18: =C2=A0/* RCH_BASS_B=
OOST_D2 */<br>+ =C2=A0 =C2=A0case 0x19: =C2=A0/* RCH_BASS_BOOST_D4 */<br>+ =
=C2=A0 =C2=A0case 0x1a: =C2=A0/* RCH_BASS_BOOST_D5 */<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0s-&gt;filter_data[reg - 0x07] =3D value;<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0return;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x1b:	/* PLL P=
rogrammability 1 */<br>+ =C2=A0 =C2=A0case 0x1b: =C2=A0/* PLL Programmabili=
ty 1 */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;pll[0] =3D value &amp; 0=
xfffc;<br>=C2=A0#ifdef TSC_VERBOSE<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if =
(value &amp; ~0xfffc)<br>@@ -747,7 +759,7 @@ static void tsc2102_audio_regi=
ster_write(<br>=C2=A0#endif<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br=
>=C2=A0<br>- =C2=A0 =C2=A0case 0x1c:	/* PLL Programmability 2 */<br>+ =C2=
=A0 =C2=A0case 0x1c: =C2=A0/* PLL Programmability 2 */<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0s-&gt;pll[1] =3D value &amp; 0xfffc;<br>=C2=A0#ifdef TSC_V=
ERBOSE<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (value &amp; ~0xfffc)<br>@@ =
-756,7 +768,7 @@ static void tsc2102_audio_register_write(<br>=C2=A0#endif<=
br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>=C2=A0<br>- =C2=A0 =C2=A0ca=
se 0x1d:	/* Audio Control 4 */<br>+ =C2=A0 =C2=A0case 0x1d: =C2=A0/* Audio =
Control 4 */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;softstep =3D !(valu=
e &amp; 0x4000);<br>=C2=A0#ifdef TSC_VERBOSE<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (value &amp; ~0x4000)<br>@@ -789,8 +801,9 @@ static void tsc210x_=
pin_update(TSC210xState *s)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pin_state =
=3D s-&gt;pressure &amp;&amp; !s-&gt;dav;<br>=C2=A0 =C2=A0 =C2=A0}<br>=C2=
=A0<br>- =C2=A0 =C2=A0if (!s-&gt;enabled)<br>+ =C2=A0 =C2=A0if (!s-&gt;enab=
led) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pin_state =3D false;<br>+ =C2=
=A0 =C2=A0}<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0if (pin_state !=3D s-&gt;irq) =
{<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;irq =3D pin_state;<br>@@ -800,=
23 +813,26 @@ static void tsc210x_pin_update(TSC210xState *s)<br>=C2=A0 =C2=
=A0 =C2=A0switch (s-&gt;nextfunction) {<br>=C2=A0 =C2=A0 =C2=A0case TSC_MOD=
E_XY_SCAN:<br>=C2=A0 =C2=A0 =C2=A0case TSC_MODE_XYZ_SCAN:<br>- =C2=A0 =C2=
=A0 =C2=A0 =C2=A0if (!s-&gt;pressure)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!=
s-&gt;pressure) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return=
;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0br=
eak;<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0case TSC_MODE_X:<br>=C2=A0 =C2=A0 =C2=
=A0case TSC_MODE_Y:<br>=C2=A0 =C2=A0 =C2=A0case TSC_MODE_Z:<br>- =C2=A0 =C2=
=A0 =C2=A0 =C2=A0if (!s-&gt;pressure)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!=
s-&gt;pressure) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return=
;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*=
 Fall through */<br>=C2=A0 =C2=A0 =C2=A0case TSC_MODE_BAT1:<br>=C2=A0 =C2=
=A0 =C2=A0case TSC_MODE_BAT2:<br>=C2=A0 =C2=A0 =C2=A0case TSC_MODE_AUX:<br>=
=C2=A0 =C2=A0 =C2=A0case TSC_MODE_TEMP1:<br>=C2=A0 =C2=A0 =C2=A0case TSC_MO=
DE_TEMP2:<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;dav)<br>+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (s-&gt;dav) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0s-&gt;enabled =3D false;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0case TS=
C_MODE_AUX_SCAN:<br>@@ -831,8 +847,9 @@ static void tsc210x_pin_update(TSC2=
10xState *s)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>=C2=A0 =C2=A0 =
=C2=A0}<br>=C2=A0<br>- =C2=A0 =C2=A0if (!s-&gt;enabled || s-&gt;busy || s-&=
gt;dav)<br>+ =C2=A0 =C2=A0if (!s-&gt;enabled || s-&gt;busy || s-&gt;dav) {<=
br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>+ =C2=A0 =C2=A0}<br>=C2=A0<=
br>=C2=A0 =C2=A0 =C2=A0s-&gt;busy =3D true;<br>=C2=A0 =C2=A0 =C2=A0s-&gt;pr=
ecision =3D s-&gt;nextprecision;<br>@@ -846,14 +863,16 @@ static uint16_t t=
sc210x_read(TSC210xState *s)<br>=C2=A0{<br>=C2=A0 =C2=A0 =C2=A0uint16_t ret=
 =3D 0x0000;<br>=C2=A0<br>- =C2=A0 =C2=A0if (!s-&gt;command)<br>+ =C2=A0 =
=C2=A0if (!s-&gt;command) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(st=
derr, &quot;tsc210x_read: SPI underrun!\n&quot;);<br>+ =C2=A0 =C2=A0}<br>=
=C2=A0<br>=C2=A0 =C2=A0 =C2=A0switch (s-&gt;page) {<br>=C2=A0 =C2=A0 =C2=A0=
case TSC_DATA_REGISTERS_PAGE:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D =
tsc2102_data_register_read(s, s-&gt;offset);<br>- =C2=A0 =C2=A0 =C2=A0 =C2=
=A0if (!s-&gt;dav)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!s-&gt;dav) {<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_irq_raise(s-&gt;davint);<=
br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0brea=
k;<br>=C2=A0 =C2=A0 =C2=A0case TSC_CONTROL_REGISTERS_PAGE:<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0ret =3D tsc2102_control_register_read(s, s-&gt;offset)=
;<br>@@ -868,7 +887,7 @@ static uint16_t tsc210x_read(TSC210xState *s)<br>=
=C2=A0 =C2=A0 =C2=A0tsc210x_pin_update(s);<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=
=A0/* Allow sequential reads. =C2=A0*/<br>- =C2=A0 =C2=A0s-&gt;offset ++;<b=
r>+ =C2=A0 =C2=A0s-&gt;offset++;<br>=C2=A0 =C2=A0 =C2=A0s-&gt;state =3D fal=
se;<br>=C2=A0 =C2=A0 =C2=A0return ret;<br>=C2=A0}<br>@@ -921,10 +940,12 @@ =
uint32_t tsc210x_txrx(void *opaque, uint32_t value, int len)<br>=C2=A0 =C2=
=A0 =C2=A0/* TODO: sequential reads etc - how do we make sure the host does=
n&#39;t<br>=C2=A0 =C2=A0 =C2=A0 * unintentionally read out a conversion res=
ult from a register while<br>=C2=A0 =C2=A0 =C2=A0 * transmitting the comman=
d word of the next command? =C2=A0*/<br>- =C2=A0 =C2=A0if (!value || (s-&gt=
;state &amp;&amp; s-&gt;command))<br>+ =C2=A0 =C2=A0if (!value || (s-&gt;st=
ate &amp;&amp; s-&gt;command)) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =
=3D tsc210x_read(s);<br>- =C2=A0 =C2=A0if (value || (s-&gt;state &amp;&amp;=
 !s-&gt;command))<br>+ =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0if (value || (s-&gt=
;state &amp;&amp; !s-&gt;command)) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0t=
sc210x_write(s, value);<br>+ =C2=A0 =C2=A0}<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=
=A0return ret;<br>=C2=A0}<br>@@ -935,8 +956,9 @@ static void tsc210x_timer_=
tick(void *opaque)<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0/* Timer ticked -- a se=
t of conversions has been finished. =C2=A0*/<br>=C2=A0<br>- =C2=A0 =C2=A0if=
 (!s-&gt;busy)<br>+ =C2=A0 =C2=A0if (!s-&gt;busy) {<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return;<br>+ =C2=A0 =C2=A0}<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0=
s-&gt;busy =3D false;<br>=C2=A0 =C2=A0 =C2=A0s-&gt;dav |=3D mode_regs[s-&gt=
;function];<br>@@ -961,16 +983,18 @@ static void tsc210x_touchscreen_event(=
void *opaque,<br>=C2=A0 =C2=A0 =C2=A0 * signaling TS events immediately, bu=
t for now we simulate<br>=C2=A0 =C2=A0 =C2=A0 * the first conversion delay =
for sake of correctness.<br>=C2=A0 =C2=A0 =C2=A0 */<br>- =C2=A0 =C2=A0if (p=
 !=3D s-&gt;pressure)<br>+ =C2=A0 =C2=A0if (p !=3D s-&gt;pressure) {<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tsc210x_pin_update(s);<br>+ =C2=A0 =C2=A0}<b=
r>=C2=A0}<br>=C2=A0<br>=C2=A0static void tsc210x_i2s_swallow(TSC210xState *=
s)<br>=C2=A0{<br>- =C2=A0 =C2=A0if (s-&gt;dac_voice[0])<br>+ =C2=A0 =C2=A0i=
f (s-&gt;dac_voice[0]) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tsc210x_out_f=
lush(s, s-&gt;codec.out.len);<br>- =C2=A0 =C2=A0else<br>+ =C2=A0 =C2=A0} el=
se {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;codec.out.len =3D 0;<br>+ =
=C2=A0 =C2=A0}<br>=C2=A0}<br>=C2=A0<br>=C2=A0static void tsc210x_i2s_set_ra=
te(TSC210xState *s, int in, int out)<br>@@ -1163,32 +1187,6 @@ I2SCodec *ts=
c210x_codec(uWireSlave *chip)<br>=C2=A0void tsc210x_set_transform(uWireSlav=
e *chip, const MouseTransformInfo *info)<br>=C2=A0{<br>=C2=A0 =C2=A0 =C2=A0=
TSC210xState *s =3D (TSC210xState *) chip-&gt;opaque;<br>-#if 0<br>- =C2=A0=
 =C2=A0int64_t ltr[8];<br>-<br>- =C2=A0 =C2=A0ltr[0] =3D (int64_t) info-&gt=
;a[1] * info-&gt;y;<br>- =C2=A0 =C2=A0ltr[1] =3D (int64_t) info-&gt;a[4] * =
info-&gt;x;<br>- =C2=A0 =C2=A0ltr[2] =3D (int64_t) info-&gt;a[1] * info-&gt=
;a[3] -<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(int64_t) info-&gt;a[=
4] * info-&gt;a[0];<br>- =C2=A0 =C2=A0ltr[3] =3D (int64_t) info-&gt;a[2] * =
info-&gt;a[4] -<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(int64_t) inf=
o-&gt;a[5] * info-&gt;a[1];<br>- =C2=A0 =C2=A0ltr[4] =3D (int64_t) info-&gt=
;a[0] * info-&gt;y;<br>- =C2=A0 =C2=A0ltr[5] =3D (int64_t) info-&gt;a[3] * =
info-&gt;x;<br>- =C2=A0 =C2=A0ltr[6] =3D (int64_t) info-&gt;a[4] * info-&gt=
;a[0] -<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(int64_t) info-&gt;a[=
1] * info-&gt;a[3];<br>- =C2=A0 =C2=A0ltr[7] =3D (int64_t) info-&gt;a[2] * =
info-&gt;a[3] -<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(int64_t) inf=
o-&gt;a[5] * info-&gt;a[0];<br>-<br>- =C2=A0 =C2=A0/* Avoid integer overflo=
w */<br>- =C2=A0 =C2=A0s-&gt;tr[0] =3D ltr[0] &gt;&gt; 11;<br>- =C2=A0 =C2=
=A0s-&gt;tr[1] =3D ltr[1] &gt;&gt; 11;<br>- =C2=A0 =C2=A0s-&gt;tr[2] =3D mu=
ldiv64(ltr[2], 1, info-&gt;a[6]);<br>- =C2=A0 =C2=A0s-&gt;tr[3] =3D muldiv6=
4(ltr[3], 1 &lt;&lt; 4, ltr[2]);<br>- =C2=A0 =C2=A0s-&gt;tr[4] =3D ltr[4] &=
gt;&gt; 11;<br>- =C2=A0 =C2=A0s-&gt;tr[5] =3D ltr[5] &gt;&gt; 11;<br>- =C2=
=A0 =C2=A0s-&gt;tr[6] =3D muldiv64(ltr[6], 1, info-&gt;a[6]);<br>- =C2=A0 =
=C2=A0s-&gt;tr[7] =3D muldiv64(ltr[7], 1 &lt;&lt; 4, ltr[6]);<br>-#else<br>=
=C2=A0<br>=C2=A0 =C2=A0 =C2=A0/* This version assumes touchscreen X &amp; Y=
 axis are parallel or<br>=C2=A0 =C2=A0 =C2=A0 * perpendicular to LCD&#39;s =
=C2=A0X &amp; Y axis in some way. =C2=A0*/<br>@@ -1218,17 +1216,17 @@ void =
tsc210x_set_transform(uWireSlave *chip, const MouseTransformInfo *info)<br>=
=C2=A0 =C2=A0 =C2=A0s-&gt;tr[4] &gt;&gt;=3D 11;<br>=C2=A0 =C2=A0 =C2=A0s-&g=
t;tr[5] &gt;&gt;=3D 11;<br>=C2=A0 =C2=A0 =C2=A0s-&gt;tr[7] &lt;&lt;=3D 4;<b=
r>-#endif<br>=C2=A0}<br>=C2=A0<br>=C2=A0void tsc210x_key_event(uWireSlave *=
chip, int key, int down)<br>=C2=A0{<br>=C2=A0 =C2=A0 =C2=A0TSC210xState *s =
=3D (TSC210xState *) chip-&gt;opaque;<br>=C2=A0<br>- =C2=A0 =C2=A0if (down)=
<br>+ =C2=A0 =C2=A0if (down) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;k=
b.down |=3D 1 &lt;&lt; key;<br>- =C2=A0 =C2=A0else<br>+ =C2=A0 =C2=A0} else=
 {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;kb.down &amp;=3D ~(1 &lt;&lt;=
 key);<br>+ =C2=A0 =C2=A0}<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0if (down &amp;&=
amp; (s-&gt;kb.down &amp; ~s-&gt;kb.mask) &amp;&amp; !s-&gt;kb.intr) {<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;kb.intr =3D 1;<br>diff --git a/hw/i=
ntc/omap_intc.c b/hw/intc/omap_intc.c<br>index 435c47600f..4a5b413d0a 10064=
4<br>--- a/hw/intc/omap_intc.c<br>+++ b/hw/intc/omap_intc.c<br>@@ -104,8 +1=
04,8 @@ static inline void omap_inth_update(OMAPIntcState *s, int is_fiq)<b=
r>=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0}<br>=C2=A0<br>-#define INT_FALLING_EDGE	0=
<br>-#define INT_LOW_LEVEL		1<br>+#define INT_FALLING_EDGE =C2=A0 =C2=A0 =
=C2=A0 =C2=A00<br>+#define INT_LOW_LEVEL =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 1<br>=C2=A0<br>=C2=A0static void omap_set_intr(void *opaque, int irq, int =
req)<br>=C2=A0{<br>@@ -117,9 +117,9 @@ static void omap_set_intr(void *opaq=
ue, int irq, int req)<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0if (req) {<br>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0rise =3D ~bank-&gt;irqs &amp; (1 &lt;&lt; n);<b=
r>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if (~bank-&gt;sens_edge &amp; (1 &lt;&lt; n)=
)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (~bank-&gt;sens_edge &amp; (1 &lt;&lt;=
 n)) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rise &amp;=3D ~ba=
nk-&gt;inputs;<br>-<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0bank-&gt;inputs |=3D (1 &lt;&lt; n);<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0if (rise) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0bank-&gt;irqs |=3D rise;<br>@@ -164,66 +164,69 @@ static uint64_t oma=
p_inth_read(void *opaque, hwaddr addr,<br>=C2=A0 =C2=A0 =C2=A0offset &amp;=
=3D 0xff;<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0switch (offset) {<br>- =C2=A0 =
=C2=A0case 0x00:	/* ITR */<br>+ =C2=A0 =C2=A0case 0x00: =C2=A0/* ITR */<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return bank-&gt;irqs;<br>=C2=A0<br>- =C2=
=A0 =C2=A0case 0x04:	/* MIR */<br>+ =C2=A0 =C2=A0case 0x04: =C2=A0/* MIR */=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return bank-&gt;mask;<br>=C2=A0<br>- =
=C2=A0 =C2=A0case 0x10:	/* SIR_IRQ_CODE */<br>+ =C2=A0 =C2=A0case 0x10: =C2=
=A0/* SIR_IRQ_CODE */<br>=C2=A0 =C2=A0 =C2=A0case 0x14: =C2=A0/* SIR_FIQ_CO=
DE */<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if (bank_no !=3D 0)<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0if (bank_no !=3D 0) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0break;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0line_no =3D s-&gt;sir_intr[(offset - 0x10) &gt;&gt; 2];=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bank =3D &amp;s-&gt;bank[line_no &gt;=
&gt; 5];<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i =3D line_no &amp; 31;<br>- =
=C2=A0 =C2=A0 =C2=A0 =C2=A0if (((bank-&gt;sens_edge &gt;&gt; i) &amp; 1) =
=3D=3D INT_FALLING_EDGE)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (((bank-&gt;sen=
s_edge &gt;&gt; i) &amp; 1) =3D=3D INT_FALLING_EDGE) {<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bank-&gt;irqs &amp;=3D ~(1 &lt;&lt; i);<br>+=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return l=
ine_no;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x18:	/* CONTROL_REG */<br>- =C2=
=A0 =C2=A0 =C2=A0 =C2=A0if (bank_no !=3D 0)<br>+ =C2=A0 =C2=A0case 0x18: =
=C2=A0/* CONTROL_REG */<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (bank_no !=3D 0)=
 {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>=C2=
=A0<br>- =C2=A0 =C2=A0case 0x1c:	/* ILR0 */<br>- =C2=A0 =C2=A0case 0x20:	/*=
 ILR1 */<br>- =C2=A0 =C2=A0case 0x24:	/* ILR2 */<br>- =C2=A0 =C2=A0case 0x2=
8:	/* ILR3 */<br>- =C2=A0 =C2=A0case 0x2c:	/* ILR4 */<br>- =C2=A0 =C2=A0cas=
e 0x30:	/* ILR5 */<br>- =C2=A0 =C2=A0case 0x34:	/* ILR6 */<br>- =C2=A0 =C2=
=A0case 0x38:	/* ILR7 */<br>- =C2=A0 =C2=A0case 0x3c:	/* ILR8 */<br>- =C2=
=A0 =C2=A0case 0x40:	/* ILR9 */<br>- =C2=A0 =C2=A0case 0x44:	/* ILR10 */<br=
>- =C2=A0 =C2=A0case 0x48:	/* ILR11 */<br>- =C2=A0 =C2=A0case 0x4c:	/* ILR1=
2 */<br>- =C2=A0 =C2=A0case 0x50:	/* ILR13 */<br>- =C2=A0 =C2=A0case 0x54:	=
/* ILR14 */<br>- =C2=A0 =C2=A0case 0x58:	/* ILR15 */<br>- =C2=A0 =C2=A0case=
 0x5c:	/* ILR16 */<br>- =C2=A0 =C2=A0case 0x60:	/* ILR17 */<br>- =C2=A0 =C2=
=A0case 0x64:	/* ILR18 */<br>- =C2=A0 =C2=A0case 0x68:	/* ILR19 */<br>- =C2=
=A0 =C2=A0case 0x6c:	/* ILR20 */<br>- =C2=A0 =C2=A0case 0x70:	/* ILR21 */<b=
r>- =C2=A0 =C2=A0case 0x74:	/* ILR22 */<br>- =C2=A0 =C2=A0case 0x78:	/* ILR=
23 */<br>- =C2=A0 =C2=A0case 0x7c:	/* ILR24 */<br>- =C2=A0 =C2=A0case 0x80:=
	/* ILR25 */<br>- =C2=A0 =C2=A0case 0x84:	/* ILR26 */<br>- =C2=A0 =C2=A0cas=
e 0x88:	/* ILR27 */<br>- =C2=A0 =C2=A0case 0x8c:	/* ILR28 */<br>- =C2=A0 =
=C2=A0case 0x90:	/* ILR29 */<br>- =C2=A0 =C2=A0case 0x94:	/* ILR30 */<br>- =
=C2=A0 =C2=A0case 0x98:	/* ILR31 */<br>+ =C2=A0 =C2=A0case 0x1c: =C2=A0/* I=
LR0 */<br>+ =C2=A0 =C2=A0case 0x20: =C2=A0/* ILR1 */<br>+ =C2=A0 =C2=A0case=
 0x24: =C2=A0/* ILR2 */<br>+ =C2=A0 =C2=A0case 0x28: =C2=A0/* ILR3 */<br>+ =
=C2=A0 =C2=A0case 0x2c: =C2=A0/* ILR4 */<br>+ =C2=A0 =C2=A0case 0x30: =C2=
=A0/* ILR5 */<br>+ =C2=A0 =C2=A0case 0x34: =C2=A0/* ILR6 */<br>+ =C2=A0 =C2=
=A0case 0x38: =C2=A0/* ILR7 */<br>+ =C2=A0 =C2=A0case 0x3c: =C2=A0/* ILR8 *=
/<br>+ =C2=A0 =C2=A0case 0x40: =C2=A0/* ILR9 */<br>+ =C2=A0 =C2=A0case 0x44=
: =C2=A0/* ILR10 */<br>+ =C2=A0 =C2=A0case 0x48: =C2=A0/* ILR11 */<br>+ =C2=
=A0 =C2=A0case 0x4c: =C2=A0/* ILR12 */<br>+ =C2=A0 =C2=A0case 0x50: =C2=A0/=
* ILR13 */<br>+ =C2=A0 =C2=A0case 0x54: =C2=A0/* ILR14 */<br>+ =C2=A0 =C2=
=A0case 0x58: =C2=A0/* ILR15 */<br>+ =C2=A0 =C2=A0case 0x5c: =C2=A0/* ILR16=
 */<br>+ =C2=A0 =C2=A0case 0x60: =C2=A0/* ILR17 */<br>+ =C2=A0 =C2=A0case 0=
x64: =C2=A0/* ILR18 */<br>+ =C2=A0 =C2=A0case 0x68: =C2=A0/* ILR19 */<br>+ =
=C2=A0 =C2=A0case 0x6c: =C2=A0/* ILR20 */<br>+ =C2=A0 =C2=A0case 0x70: =C2=
=A0/* ILR21 */<br>+ =C2=A0 =C2=A0case 0x74: =C2=A0/* ILR22 */<br>+ =C2=A0 =
=C2=A0case 0x78: =C2=A0/* ILR23 */<br>+ =C2=A0 =C2=A0case 0x7c: =C2=A0/* IL=
R24 */<br>+ =C2=A0 =C2=A0case 0x80: =C2=A0/* ILR25 */<br>+ =C2=A0 =C2=A0cas=
e 0x84: =C2=A0/* ILR26 */<br>+ =C2=A0 =C2=A0case 0x88: =C2=A0/* ILR27 */<br=
>+ =C2=A0 =C2=A0case 0x8c: =C2=A0/* ILR28 */<br>+ =C2=A0 =C2=A0case 0x90: =
=C2=A0/* ILR29 */<br>+ =C2=A0 =C2=A0case 0x94: =C2=A0/* ILR30 */<br>+ =C2=
=A0 =C2=A0case 0x98: =C2=A0/* ILR31 */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0i =3D (offset - 0x1c) &gt;&gt; 2;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r=
eturn (bank-&gt;priority[i] &lt;&lt; 2) |<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(((bank-&gt;sens_edge &gt;&gt; i) &amp; 1=
) &lt;&lt; 1) |<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0((bank-&gt;fiq &gt;&gt; i) &amp; 1);<br>=C2=A0<br>- =C2=A0 =C2=A0case=
 0x9c:	/* ISR */<br>+ =C2=A0 =C2=A0case 0x9c: =C2=A0/* ISR */<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0return 0x00000000;<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=
=A0}<br>@@ -241,26 +244,27 @@ static void omap_inth_write(void *opaque, hwa=
ddr addr,<br>=C2=A0 =C2=A0 =C2=A0offset &amp;=3D 0xff;<br>=C2=A0<br>=C2=A0 =
=C2=A0 =C2=A0switch (offset) {<br>- =C2=A0 =C2=A0case 0x00:	/* ITR */<br>+ =
=C2=A0 =C2=A0case 0x00: =C2=A0/* ITR */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0/* Important: ignore the clearing if the IRQ is level-triggered and<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 the input bit is 1 */<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0bank-&gt;irqs &amp;=3D value | (bank-&gt;inputs =
&amp; bank-&gt;sens_edge);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>=
=C2=A0<br>- =C2=A0 =C2=A0case 0x04:	/* MIR */<br>+ =C2=A0 =C2=A0case 0x04: =
=C2=A0/* MIR */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bank-&gt;mask =3D valu=
e;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0omap_inth_update(s, 0);<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0omap_inth_update(s, 1);<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x10:	/* SIR_IRQ_CODE=
 */<br>- =C2=A0 =C2=A0case 0x14:	/* SIR_FIQ_CODE */<br>+ =C2=A0 =C2=A0case =
0x10: =C2=A0/* SIR_IRQ_CODE */<br>+ =C2=A0 =C2=A0case 0x14: =C2=A0/* SIR_FI=
Q_CODE */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OMAP_RO_REG(addr);<br>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x18:	/=
* CONTROL_REG */<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if (bank_no !=3D 0)<br>+ =
=C2=A0 =C2=A0case 0x18: =C2=A0/* CONTROL_REG */<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0if (bank_no !=3D 0) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0break;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (value &amp; 2) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0qemu_set_irq(s-&gt;parent_intr[1], 0);<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;new_agr[1] =3D ~0;<br>@@ -273,38 +277,38 @@ s=
tatic void omap_inth_write(void *opaque, hwaddr addr,<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>=C2=A0<b=
r>- =C2=A0 =C2=A0case 0x1c:	/* ILR0 */<br>- =C2=A0 =C2=A0case 0x20:	/* ILR1=
 */<br>- =C2=A0 =C2=A0case 0x24:	/* ILR2 */<br>- =C2=A0 =C2=A0case 0x28:	/*=
 ILR3 */<br>- =C2=A0 =C2=A0case 0x2c:	/* ILR4 */<br>- =C2=A0 =C2=A0case 0x3=
0:	/* ILR5 */<br>- =C2=A0 =C2=A0case 0x34:	/* ILR6 */<br>- =C2=A0 =C2=A0cas=
e 0x38:	/* ILR7 */<br>- =C2=A0 =C2=A0case 0x3c:	/* ILR8 */<br>- =C2=A0 =C2=
=A0case 0x40:	/* ILR9 */<br>- =C2=A0 =C2=A0case 0x44:	/* ILR10 */<br>- =C2=
=A0 =C2=A0case 0x48:	/* ILR11 */<br>- =C2=A0 =C2=A0case 0x4c:	/* ILR12 */<b=
r>- =C2=A0 =C2=A0case 0x50:	/* ILR13 */<br>- =C2=A0 =C2=A0case 0x54:	/* ILR=
14 */<br>- =C2=A0 =C2=A0case 0x58:	/* ILR15 */<br>- =C2=A0 =C2=A0case 0x5c:=
	/* ILR16 */<br>- =C2=A0 =C2=A0case 0x60:	/* ILR17 */<br>- =C2=A0 =C2=A0cas=
e 0x64:	/* ILR18 */<br>- =C2=A0 =C2=A0case 0x68:	/* ILR19 */<br>- =C2=A0 =
=C2=A0case 0x6c:	/* ILR20 */<br>- =C2=A0 =C2=A0case 0x70:	/* ILR21 */<br>- =
=C2=A0 =C2=A0case 0x74:	/* ILR22 */<br>- =C2=A0 =C2=A0case 0x78:	/* ILR23 *=
/<br>- =C2=A0 =C2=A0case 0x7c:	/* ILR24 */<br>- =C2=A0 =C2=A0case 0x80:	/* =
ILR25 */<br>- =C2=A0 =C2=A0case 0x84:	/* ILR26 */<br>- =C2=A0 =C2=A0case 0x=
88:	/* ILR27 */<br>- =C2=A0 =C2=A0case 0x8c:	/* ILR28 */<br>- =C2=A0 =C2=A0=
case 0x90:	/* ILR29 */<br>- =C2=A0 =C2=A0case 0x94:	/* ILR30 */<br>- =C2=A0=
 =C2=A0case 0x98:	/* ILR31 */<br>+ =C2=A0 =C2=A0case 0x1c: =C2=A0/* ILR0 */=
<br>+ =C2=A0 =C2=A0case 0x20: =C2=A0/* ILR1 */<br>+ =C2=A0 =C2=A0case 0x24:=
 =C2=A0/* ILR2 */<br>+ =C2=A0 =C2=A0case 0x28: =C2=A0/* ILR3 */<br>+ =C2=A0=
 =C2=A0case 0x2c: =C2=A0/* ILR4 */<br>+ =C2=A0 =C2=A0case 0x30: =C2=A0/* IL=
R5 */<br>+ =C2=A0 =C2=A0case 0x34: =C2=A0/* ILR6 */<br>+ =C2=A0 =C2=A0case =
0x38: =C2=A0/* ILR7 */<br>+ =C2=A0 =C2=A0case 0x3c: =C2=A0/* ILR8 */<br>+ =
=C2=A0 =C2=A0case 0x40: =C2=A0/* ILR9 */<br>+ =C2=A0 =C2=A0case 0x44: =C2=
=A0/* ILR10 */<br>+ =C2=A0 =C2=A0case 0x48: =C2=A0/* ILR11 */<br>+ =C2=A0 =
=C2=A0case 0x4c: =C2=A0/* ILR12 */<br>+ =C2=A0 =C2=A0case 0x50: =C2=A0/* IL=
R13 */<br>+ =C2=A0 =C2=A0case 0x54: =C2=A0/* ILR14 */<br>+ =C2=A0 =C2=A0cas=
e 0x58: =C2=A0/* ILR15 */<br>+ =C2=A0 =C2=A0case 0x5c: =C2=A0/* ILR16 */<br=
>+ =C2=A0 =C2=A0case 0x60: =C2=A0/* ILR17 */<br>+ =C2=A0 =C2=A0case 0x64: =
=C2=A0/* ILR18 */<br>+ =C2=A0 =C2=A0case 0x68: =C2=A0/* ILR19 */<br>+ =C2=
=A0 =C2=A0case 0x6c: =C2=A0/* ILR20 */<br>+ =C2=A0 =C2=A0case 0x70: =C2=A0/=
* ILR21 */<br>+ =C2=A0 =C2=A0case 0x74: =C2=A0/* ILR22 */<br>+ =C2=A0 =C2=
=A0case 0x78: =C2=A0/* ILR23 */<br>+ =C2=A0 =C2=A0case 0x7c: =C2=A0/* ILR24=
 */<br>+ =C2=A0 =C2=A0case 0x80: =C2=A0/* ILR25 */<br>+ =C2=A0 =C2=A0case 0=
x84: =C2=A0/* ILR26 */<br>+ =C2=A0 =C2=A0case 0x88: =C2=A0/* ILR27 */<br>+ =
=C2=A0 =C2=A0case 0x8c: =C2=A0/* ILR28 */<br>+ =C2=A0 =C2=A0case 0x90: =C2=
=A0/* ILR29 */<br>+ =C2=A0 =C2=A0case 0x94: =C2=A0/* ILR30 */<br>+ =C2=A0 =
=C2=A0case 0x98: =C2=A0/* ILR31 */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i =
=3D (offset - 0x1c) &gt;&gt; 2;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bank-&=
gt;priority[i] =3D (value &gt;&gt; 2) &amp; 0x1f;<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0bank-&gt;sens_edge &amp;=3D ~(1 &lt;&lt; i);<br>@@ -313,8 +317=
,8 @@ static void omap_inth_write(void *opaque, hwaddr addr,<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0bank-&gt;fiq |=3D (value &amp; 1) &lt;&lt; i;<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>=C2=A0<br>- =C2=A0 =C2=A0case =
0x9c:	/* ISR */<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; 32; i =
++)<br>+ =C2=A0 =C2=A0case 0x9c: =C2=A0/* ISR */<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0for (i =3D 0; i &lt; 32; i++)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0if (value &amp; (1 &lt;&lt; i)) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0omap_set_intr(s, 32 * bank_no + i, 1)=
;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<=
br>@@ -339,7 +343,7 @@ static void omap_inth_reset(DeviceState *dev)<br>=C2=
=A0 =C2=A0 =C2=A0OMAPIntcState *s =3D OMAP_INTC(dev);<br>=C2=A0 =C2=A0 =C2=
=A0int i;<br>=C2=A0<br>- =C2=A0 =C2=A0for (i =3D 0; i &lt; s-&gt;nbanks; ++=
i){<br>+ =C2=A0 =C2=A0for (i =3D 0; i &lt; s-&gt;nbanks; ++i) {<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;bank[i].irqs =3D 0x00000000;<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;bank[i].mask =3D 0xffffffff;<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0s-&gt;bank[i].sens_edge =3D 0x00000000;<br>@@ -348,8 +=
352,9 @@ static void omap_inth_reset(DeviceState *dev)<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0s-&gt;bank[i].swi =3D 0x00000000;<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0memset(s-&gt;bank[i].priority, 0, sizeof(s-&gt;bank[i].priorit=
y));<br>=C2=A0<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;level_only)<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;level_only) {<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;bank[i].sens_edge =3D 0xffffffff;<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0<br>=C2=A0 =C2=
=A0 =C2=A0s-&gt;new_agr[0] =3D ~0;<br>@@ -440,58 +445,59 @@ static uint64_t=
 omap2_inth_read(void *opaque, hwaddr addr,<br>=C2=A0 =C2=A0 =C2=A0}<br>=C2=
=A0<br>=C2=A0 =C2=A0 =C2=A0switch (offset) {<br>- =C2=A0 =C2=A0case 0x00:	/=
* INTC_REVISION */<br>+ =C2=A0 =C2=A0case 0x00: =C2=A0/* INTC_REVISION */<b=
r>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return s-&gt;revision;<br>=C2=A0<br>- =
=C2=A0 =C2=A0case 0x10:	/* INTC_SYSCONFIG */<br>+ =C2=A0 =C2=A0case 0x10: =
=C2=A0/* INTC_SYSCONFIG */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return (s-&=
gt;autoidle &gt;&gt; 2) &amp; 1;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x14:	/* =
INTC_SYSSTATUS */<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0return 1;						/* RESETDO=
NE */<br>+ =C2=A0 =C2=A0case 0x14: =C2=A0/* INTC_SYSSTATUS */<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0return 1; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* RESETDONE */<br>=C2=A0<br>- =
=C2=A0 =C2=A0case 0x40:	/* INTC_SIR_IRQ */<br>+ =C2=A0 =C2=A0case 0x40: =C2=
=A0/* INTC_SIR_IRQ */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return s-&gt;sir=
_intr[0];<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x44:	/* INTC_SIR_FIQ */<br>+ =
=C2=A0 =C2=A0case 0x44: =C2=A0/* INTC_SIR_FIQ */<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return s-&gt;sir_intr[1];<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x4=
8:	/* INTC_CONTROL */<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0return (!s-&gt;mask) =
&lt;&lt; 2;					/* GLOBALMASK */<br>+ =C2=A0 =C2=A0case 0x48: =C2=A0/* INTC=
_CONTROL */<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0return (!s-&gt;mask) &lt;&lt; 2=
; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* GLOBALMASK */<br>=C2=A0<br>- =C2=
=A0 =C2=A0case 0x4c:	/* INTC_PROTECTION */<br>+ =C2=A0 =C2=A0case 0x4c: =C2=
=A0/* INTC_PROTECTION */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>=
=C2=A0<br>- =C2=A0 =C2=A0case 0x50:	/* INTC_IDLE */<br>+ =C2=A0 =C2=A0case =
0x50: =C2=A0/* INTC_IDLE */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return s-&=
gt;autoidle &amp; 3;<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0/* Per-bank registers=
 */<br>- =C2=A0 =C2=A0case 0x80:	/* INTC_ITR */<br>+ =C2=A0 =C2=A0case 0x80=
: =C2=A0/* INTC_ITR */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return bank-&gt=
;inputs;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x84:	/* INTC_MIR */<br>+ =C2=A0 =
=C2=A0case 0x84: =C2=A0/* INTC_MIR */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
return bank-&gt;mask;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x88:	/* INTC_MIR_CL=
EAR */<br>- =C2=A0 =C2=A0case 0x8c:	/* INTC_MIR_SET */<br>+ =C2=A0 =C2=A0ca=
se 0x88: =C2=A0/* INTC_MIR_CLEAR */<br>+ =C2=A0 =C2=A0case 0x8c: =C2=A0/* I=
NTC_MIR_SET */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>=C2=A0<br>=
- =C2=A0 =C2=A0case 0x90:	/* INTC_ISR_SET */<br>+ =C2=A0 =C2=A0case 0x90: =
=C2=A0/* INTC_ISR_SET */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return bank-&=
gt;swi;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x94:	/* INTC_ISR_CLEAR */<br>+ =
=C2=A0 =C2=A0case 0x94: =C2=A0/* INTC_ISR_CLEAR */<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return 0;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x98:	/* INTC_PENDI=
NG_IRQ */<br>+ =C2=A0 =C2=A0case 0x98: =C2=A0/* INTC_PENDING_IRQ */<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return bank-&gt;irqs &amp; ~bank-&gt;mask &a=
mp; ~bank-&gt;fiq;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x9c:	/* INTC_PENDING_F=
IQ */<br>+ =C2=A0 =C2=A0case 0x9c: =C2=A0/* INTC_PENDING_FIQ */<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0return bank-&gt;irqs &amp; ~bank-&gt;mask &amp; =
bank-&gt;fiq;<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0/* Per-line registers */<br>=
- =C2=A0 =C2=A0case 0x100 ... 0x300:	/* INTC_ILR */<br>+ =C2=A0 =C2=A0case =
0x100 ... 0x300: =C2=A0 =C2=A0 =C2=A0 /* INTC_ILR */<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0bank_no =3D (offset - 0x100) &gt;&gt; 7;<br>- =C2=A0 =C2=
=A0 =C2=A0 =C2=A0if (bank_no &gt; s-&gt;nbanks)<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0if (bank_no &gt; s-&gt;nbanks) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0break;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0bank =3D &amp;s-&gt;bank[bank_no];<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0line_no =3D (offset &amp; 0x7f) &gt;&gt; 2;<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0return (bank-&gt;priority[line_no] &lt;&lt; 2) |<br=
>@@ -521,7 +527,7 @@ static void omap2_inth_write(void *opaque, hwaddr addr=
,<br>=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0switch (offset)=
 {<br>- =C2=A0 =C2=A0case 0x10:	/* INTC_SYSCONFIG */<br>+ =C2=A0 =C2=A0case=
 0x10: =C2=A0/* INTC_SYSCONFIG */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&g=
t;autoidle &amp;=3D 4;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;autoidle =
|=3D (value &amp; 1) &lt;&lt; 2;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (v=
alue &amp; 2) { =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0/* SOFTRESET */<br>@@ -529,21 +535,21 @@ static void omap2_inth_write=
(void *opaque, hwaddr addr,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x4=
8:	/* INTC_CONTROL */<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;mask =3D (value=
 &amp; 4) ? 0 : ~0;				/* GLOBALMASK */<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if =
(value &amp; 2) {					/* NEWFIQAGR */<br>+ =C2=A0 =C2=A0case 0x48: =C2=A0/*=
 INTC_CONTROL */<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;mask =3D (value &amp=
; 4) ? 0 : ~0; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 /* GLOBALMASK */<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0i=
f (value &amp; 2) { =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* NEWFIQAGR */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0qemu_set_irq(s-&gt;parent_intr[1], 0);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0s-&gt;new_agr[1] =3D ~0;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0omap_inth_update(s, 1);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if (value &amp; 1) {					/* NEWIRQ=
AGR */<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (value &amp; 1) { =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* NEWIRQAGR */<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_set_irq(s-&gt;parent_intr=
[0], 0);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;new_agr[0=
] =3D ~0;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0omap_inth_upda=
te(s, 0);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x4c:	/* INTC_PROTECT=
ION */<br>+ =C2=A0 =C2=A0case 0x4c: =C2=A0/* INTC_PROTECTION */<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0/* TODO: Make a bitmap (or sizeof(char)map) of a=
ccess privileges<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * for every register=
, see Chapter 3 and 4 for privileged mode. =C2=A0*/<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (value &amp; 1)<br>@@ -551,44 +557,45 @@ static void omap2=
_inth_write(void *opaque, hwaddr addr,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__=
func__);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>=C2=A0<br>- =C2=A0=
 =C2=A0case 0x50:	/* INTC_IDLE */<br>+ =C2=A0 =C2=A0case 0x50: =C2=A0/* INT=
C_IDLE */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;autoidle &amp;=3D ~3;<=
br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;autoidle |=3D value &amp; 3;<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0=
/* Per-bank registers */<br>- =C2=A0 =C2=A0case 0x84:	/* INTC_MIR */<br>+ =
=C2=A0 =C2=A0case 0x84: =C2=A0/* INTC_MIR */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0bank-&gt;mask =3D value;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0omap_i=
nth_update(s, 0);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0omap_inth_update(s, =
1);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>=C2=A0<br>- =C2=A0 =C2=
=A0case 0x88:	/* INTC_MIR_CLEAR */<br>+ =C2=A0 =C2=A0case 0x88: =C2=A0/* IN=
TC_MIR_CLEAR */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bank-&gt;mask &amp;=3D=
 ~value;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0omap_inth_update(s, 0);<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0omap_inth_update(s, 1);<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0return;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x8c:	/* INTC_=
MIR_SET */<br>+ =C2=A0 =C2=A0case 0x8c: =C2=A0/* INTC_MIR_SET */<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0bank-&gt;mask |=3D value;<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0return;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x90:	/* INTC_ISR=
_SET */<br>+ =C2=A0 =C2=A0case 0x90: =C2=A0/* INTC_ISR_SET */<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0bank-&gt;irqs |=3D bank-&gt;swi |=3D value;<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0omap_inth_update(s, 0);<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0omap_inth_update(s, 1);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0return;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x94:	/* INTC_ISR_CLEAR */<br>+=
 =C2=A0 =C2=A0case 0x94: =C2=A0/* INTC_ISR_CLEAR */<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0bank-&gt;swi &amp;=3D ~value;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0bank-&gt;irqs =3D bank-&gt;swi &amp; bank-&gt;inputs;<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0return;<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0/* Per-lin=
e registers */<br>- =C2=A0 =C2=A0case 0x100 ... 0x300:	/* INTC_ILR */<br>+ =
=C2=A0 =C2=A0case 0x100 ... 0x300: =C2=A0 =C2=A0 =C2=A0 /* INTC_ILR */<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bank_no =3D (offset - 0x100) &gt;&gt; 7;<=
br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if (bank_no &gt; s-&gt;nbanks)<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0if (bank_no &gt; s-&gt;nbanks) {<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bank =3D &amp;s-&gt;bank[bank_no];<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0line_no =3D (offset &amp; 0x7f) &gt;&gt; 2;<=
br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bank-&gt;priority[line_no] =3D (value =
&gt;&gt; 2) &amp; 0x3f;<br>@@ -596,13 +603,13 @@ static void omap2_inth_wri=
te(void *opaque, hwaddr addr,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bank-&gt=
;fiq |=3D (value &amp; 1) &lt;&lt; line_no;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0return;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x00:	/* INTC_REVISION */<br=
>- =C2=A0 =C2=A0case 0x14:	/* INTC_SYSSTATUS */<br>- =C2=A0 =C2=A0case 0x40=
:	/* INTC_SIR_IRQ */<br>- =C2=A0 =C2=A0case 0x44:	/* INTC_SIR_FIQ */<br>- =
=C2=A0 =C2=A0case 0x80:	/* INTC_ITR */<br>- =C2=A0 =C2=A0case 0x98:	/* INTC=
_PENDING_IRQ */<br>- =C2=A0 =C2=A0case 0x9c:	/* INTC_PENDING_FIQ */<br>+ =
=C2=A0 =C2=A0case 0x00: =C2=A0/* INTC_REVISION */<br>+ =C2=A0 =C2=A0case 0x=
14: =C2=A0/* INTC_SYSSTATUS */<br>+ =C2=A0 =C2=A0case 0x40: =C2=A0/* INTC_S=
IR_IRQ */<br>+ =C2=A0 =C2=A0case 0x44: =C2=A0/* INTC_SIR_FIQ */<br>+ =C2=A0=
 =C2=A0case 0x80: =C2=A0/* INTC_ITR */<br>+ =C2=A0 =C2=A0case 0x98: =C2=A0/=
* INTC_PENDING_IRQ */<br>+ =C2=A0 =C2=A0case 0x9c: =C2=A0/* INTC_PENDING_FI=
Q */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OMAP_RO_REG(addr);<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0return;<br>=C2=A0 =C2=A0 =C2=A0}<br>diff --git a/hw=
/misc/cbus.c b/hw/misc/cbus.c<br>index 653e8ddcd5..a09232e755 100644<br>---=
 a/hw/misc/cbus.c<br>+++ b/hw/misc/cbus.c<br>@@ -26,7 +26,7 @@<br>=C2=A0#in=
clude &quot;hw/misc/cbus.h&quot;<br>=C2=A0#include &quot;sysemu/runstate.h&=
quot;<br>=C2=A0<br>-//#define DEBUG<br>+/*#define DEBUG*/<br>=C2=A0<br>=C2=
=A0typedef struct {<br>=C2=A0 =C2=A0 =C2=A0void *opaque;<br>@@ -78,13 +78,1=
5 @@ static void cbus_cycle(CBusPriv *s)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0s-&gt;dir =3D !s-&gt;rw;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;val =
=3D 0;<br>=C2=A0<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;rw)<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0if (s-&gt;rw) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0cbus_io(s);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0break;<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0case cbus_valu=
e:<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!s-&gt;rw)<br>+ =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (!s-&gt;rw) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
cbus_io(s);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0s-&gt;cycle =3D cbus_address;<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0s-&gt;bit =3D 8;<br>@@ -99,13 +101,15 @@ static void cbus_clk(=
void *opaque, int line, int level)<br>=C2=A0 =C2=A0 =C2=A0CBusPriv *s =3D (=
CBusPriv *) opaque;<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0if (!s-&gt;sel &amp;&a=
mp; level &amp;&amp; !s-&gt;clk) {<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&g=
t;dir)<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;val |=3D s-&gt;d=
at &lt;&lt; (s-&gt;bit --);<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>- =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_set_irq(s-&gt;dat_out, (s-&gt;va=
l &gt;&gt; (s-&gt;bit --)) &amp; 1);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-=
&gt;dir) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;val |=3D s-&=
gt;dat &lt;&lt; (s-&gt;bit--);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>=
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_set_irq(s-&gt;dat_out, (s-&=
gt;val &gt;&gt; (s-&gt;bit--)) &amp; 1);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<=
br>=C2=A0<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;bit &lt; 0)<br>+ =C2=A0=
 =C2=A0 =C2=A0 =C2=A0if (s-&gt;bit &lt; 0) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0cbus_cycle(s);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=
=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0s-&gt;clk =3D level;=
<br>@@ -179,61 +183,61 @@ static void retu_interrupt_update(CBusRetu *s)<br=
>=C2=A0 =C2=A0 =C2=A0qemu_set_irq(s-&gt;irq, s-&gt;irqst &amp; ~s-&gt;irqen=
);<br>=C2=A0}<br>=C2=A0<br>-#define RETU_REG_ASICR		0x00	/* (RO) ASIC ID &a=
mp; revision */<br>-#define RETU_REG_IDR		0x01	/* (T) =C2=A0Interrupt ID */=
<br>-#define RETU_REG_IMR		0x02	/* (RW) Interrupt mask */<br>-#define RETU_=
REG_RTCDSR		0x03	/* (RW) RTC seconds register */<br>-#define RETU_REG_RTCHM=
R		0x04	/* (RO) RTC hours and minutes reg */<br>-#define RETU_REG_RTCHMAR	0=
x05	/* (RW) RTC hours and minutes set reg */<br>-#define RETU_REG_RTCCALR	0=
x06	/* (RW) RTC calibration register */<br>-#define RETU_REG_ADCR		0x08	/* =
(RW) ADC result register */<br>-#define RETU_REG_ADCSCR		0x09	/* (RW) ADC s=
ample control register */<br>-#define RETU_REG_AFCR		0x0a	/* (RW) AFC regis=
ter */<br>-#define RETU_REG_ANTIFR		0x0b	/* (RW) AntiF register */<br>-#def=
ine RETU_REG_CALIBR		0x0c	/* (RW) CalibR register*/<br>-#define RETU_REG_CC=
R1		0x0d	/* (RW) Common control register 1 */<br>-#define RETU_REG_CCR2		0x=
0e	/* (RW) Common control register 2 */<br>-#define RETU_REG_RCTRL_CLR	0x0f=
	/* (T) =C2=A0Regulator clear register */<br>-#define RETU_REG_RCTRL_SET	0x=
10	/* (T) =C2=A0Regulator set register */<br>-#define RETU_REG_TXCR		0x11	/=
* (RW) TxC register */<br>-#define RETU_REG_STATUS		0x16	/* (RO) Status reg=
ister */<br>-#define RETU_REG_WATCHDOG	0x17	/* (RW) Watchdog register */<br=
>-#define RETU_REG_AUDTXR		0x18	/* (RW) Audio Codec Tx register */<br>-#def=
ine RETU_REG_AUDPAR		0x19	/* (RW) AudioPA register */<br>-#define RETU_REG_=
AUDRXR1	0x1a	/* (RW) Audio receive register 1 */<br>-#define RETU_REG_AUDRX=
R2	0x1b	/* (RW) Audio receive register 2 */<br>-#define RETU_REG_SGR1		0x1c=
	/* (RW) */<br>-#define RETU_REG_SCR1		0x1d	/* (RW) */<br>-#define RETU_REG=
_SGR2		0x1e	/* (RW) */<br>-#define RETU_REG_SCR2		0x1f	/* (RW) */<br>+#defi=
ne RETU_REG_ASICR =C2=A0 =C2=A0 =C2=A00x00 =C2=A0/* (RO) ASIC ID &amp; revi=
sion */<br>+#define RETU_REG_IDR =C2=A0 =C2=A0 =C2=A0 =C2=A00x01 =C2=A0/* (=
T) =C2=A0Interrupt ID */<br>+#define RETU_REG_IMR =C2=A0 =C2=A0 =C2=A0 =C2=
=A00x02 =C2=A0/* (RW) Interrupt mask */<br>+#define RETU_REG_RTCDSR =C2=A0 =
=C2=A0 0x03 =C2=A0/* (RW) RTC seconds register */<br>+#define RETU_REG_RTCH=
MR =C2=A0 =C2=A0 0x04 =C2=A0/* (RO) RTC hours and minutes reg */<br>+#defin=
e RETU_REG_RTCHMAR =C2=A0 =C2=A00x05 =C2=A0/* (RW) RTC hours and minutes se=
t reg */<br>+#define RETU_REG_RTCCALR =C2=A0 =C2=A00x06 =C2=A0/* (RW) RTC c=
alibration register */<br>+#define RETU_REG_ADCR =C2=A0 =C2=A0 =C2=A0 0x08 =
=C2=A0/* (RW) ADC result register */<br>+#define RETU_REG_ADCSCR =C2=A0 =C2=
=A0 0x09 =C2=A0/* (RW) ADC sample control register */<br>+#define RETU_REG_=
AFCR =C2=A0 =C2=A0 =C2=A0 0x0a =C2=A0/* (RW) AFC register */<br>+#define RE=
TU_REG_ANTIFR =C2=A0 =C2=A0 0x0b =C2=A0/* (RW) AntiF register */<br>+#defin=
e RETU_REG_CALIBR =C2=A0 =C2=A0 0x0c =C2=A0/* (RW) CalibR register*/<br>+#d=
efine RETU_REG_CCR1 =C2=A0 =C2=A0 =C2=A0 0x0d =C2=A0/* (RW) Common control =
register 1 */<br>+#define RETU_REG_CCR2 =C2=A0 =C2=A0 =C2=A0 0x0e =C2=A0/* =
(RW) Common control register 2 */<br>+#define RETU_REG_RCTRL_CLR =C2=A00x0f=
 =C2=A0/* (T) =C2=A0Regulator clear register */<br>+#define RETU_REG_RCTRL_=
SET =C2=A00x10 =C2=A0/* (T) =C2=A0Regulator set register */<br>+#define RET=
U_REG_TXCR =C2=A0 =C2=A0 =C2=A0 0x11 =C2=A0/* (RW) TxC register */<br>+#def=
ine RETU_REG_STATUS =C2=A0 =C2=A0 0x16 =C2=A0/* (RO) Status register */<br>=
+#define RETU_REG_WATCHDOG =C2=A0 0x17 =C2=A0/* (RW) Watchdog register */<b=
r>+#define RETU_REG_AUDTXR =C2=A0 =C2=A0 0x18 =C2=A0/* (RW) Audio Codec Tx =
register */<br>+#define RETU_REG_AUDPAR =C2=A0 =C2=A0 0x19 =C2=A0/* (RW) Au=
dioPA register */<br>+#define RETU_REG_AUDRXR1 =C2=A0 =C2=A00x1a =C2=A0/* (=
RW) Audio receive register 1 */<br>+#define RETU_REG_AUDRXR2 =C2=A0 =C2=A00=
x1b =C2=A0/* (RW) Audio receive register 2 */<br>+#define RETU_REG_SGR1 =C2=
=A0 =C2=A0 =C2=A0 0x1c =C2=A0/* (RW) */<br>+#define RETU_REG_SCR1 =C2=A0 =
=C2=A0 =C2=A0 0x1d =C2=A0/* (RW) */<br>+#define RETU_REG_SGR2 =C2=A0 =C2=A0=
 =C2=A0 0x1e =C2=A0/* (RW) */<br>+#define RETU_REG_SCR2 =C2=A0 =C2=A0 =C2=
=A0 0x1f =C2=A0/* (RW) */<br>=C2=A0<br>=C2=A0/* Retu Interrupt sources */<b=
r>=C2=A0enum {<br>- =C2=A0 =C2=A0retu_int_pwr	=3D 0,	/* Power button */<br>=
- =C2=A0 =C2=A0retu_int_char	=3D 1,	/* Charger */<br>- =C2=A0 =C2=A0retu_in=
t_rtcs	=3D 2,	/* Seconds */<br>- =C2=A0 =C2=A0retu_int_rtcm	=3D 3,	/* Minut=
es */<br>- =C2=A0 =C2=A0retu_int_rtcd	=3D 4,	/* Days */<br>- =C2=A0 =C2=A0r=
etu_int_rtca	=3D 5,	/* Alarm */<br>- =C2=A0 =C2=A0retu_int_hook	=3D 6,	/* H=
ook */<br>- =C2=A0 =C2=A0retu_int_head	=3D 7,	/* Headset */<br>- =C2=A0 =C2=
=A0retu_int_adcs	=3D 8,	/* ADC sample */<br>+ =C2=A0 =C2=A0retu_int_pwr =C2=
=A0=3D 0, =C2=A0/* Power button */<br>+ =C2=A0 =C2=A0retu_int_char =3D 1, =
=C2=A0/* Charger */<br>+ =C2=A0 =C2=A0retu_int_rtcs =3D 2, =C2=A0/* Seconds=
 */<br>+ =C2=A0 =C2=A0retu_int_rtcm =3D 3, =C2=A0/* Minutes */<br>+ =C2=A0 =
=C2=A0retu_int_rtcd =3D 4, =C2=A0/* Days */<br>+ =C2=A0 =C2=A0retu_int_rtca=
 =3D 5, =C2=A0/* Alarm */<br>+ =C2=A0 =C2=A0retu_int_hook =3D 6, =C2=A0/* H=
ook */<br>+ =C2=A0 =C2=A0retu_int_head =3D 7, =C2=A0/* Headset */<br>+ =C2=
=A0 =C2=A0retu_int_adcs =3D 8, =C2=A0/* ADC sample */<br>=C2=A0};<br>=C2=A0=
<br>=C2=A0/* Retu ADC channel wiring */<br>=C2=A0enum {<br>- =C2=A0 =C2=A0r=
etu_adc_bsi	=3D 1,	/* BSI */<br>- =C2=A0 =C2=A0retu_adc_batt_temp	=3D 2,	/*=
 Battery temperature */<br>- =C2=A0 =C2=A0retu_adc_chg_volt	=3D 3,	/* Charg=
er voltage */<br>- =C2=A0 =C2=A0retu_adc_head_det	=3D 4,	/* Headset detecti=
on */<br>- =C2=A0 =C2=A0retu_adc_hook_det	=3D 5,	/* Hook detection */<br>- =
=C2=A0 =C2=A0retu_adc_rf_gp	=3D 6,	/* RF GP */<br>- =C2=A0 =C2=A0retu_adc_t=
x_det	=3D 7,	/* Wideband Tx detection */<br>- =C2=A0 =C2=A0retu_adc_batt_vo=
lt	=3D 8,	/* Battery voltage */<br>- =C2=A0 =C2=A0retu_adc_sens	=3D 10,	/* =
Light sensor */<br>- =C2=A0 =C2=A0retu_adc_sens_temp	=3D 11,	/* Light senso=
r temperature */<br>- =C2=A0 =C2=A0retu_adc_bbatt_volt	=3D 12,	/* Backup ba=
ttery voltage */<br>- =C2=A0 =C2=A0retu_adc_self_temp	=3D 13,	/* RETU tempe=
rature */<br>+ =C2=A0 =C2=A0retu_adc_bsi =3D 1, =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 /* BSI */<br>+ =C2=A0 =C2=A0retu_adc_batt_temp =3D 2, =C2=A0 /* Battery te=
mperature */<br>+ =C2=A0 =C2=A0retu_adc_chg_volt =3D 3, =C2=A0 =C2=A0/* Cha=
rger voltage */<br>+ =C2=A0 =C2=A0retu_adc_head_det =3D 4, =C2=A0 =C2=A0/* =
Headset detection */<br>+ =C2=A0 =C2=A0retu_adc_hook_det =3D 5, =C2=A0 =C2=
=A0/* Hook detection */<br>+ =C2=A0 =C2=A0retu_adc_rf_gp =3D 6, =C2=A0 =C2=
=A0 =C2=A0 /* RF GP */<br>+ =C2=A0 =C2=A0retu_adc_tx_det =3D 7, =C2=A0 =C2=
=A0 =C2=A0/* Wideband Tx detection */<br>+ =C2=A0 =C2=A0retu_adc_batt_volt =
=3D 8, =C2=A0 /* Battery voltage */<br>+ =C2=A0 =C2=A0retu_adc_sens =3D 10,=
 =C2=A0 =C2=A0 =C2=A0 /* Light sensor */<br>+ =C2=A0 =C2=A0retu_adc_sens_te=
mp =3D 11, =C2=A0/* Light sensor temperature */<br>+ =C2=A0 =C2=A0retu_adc_=
bbatt_volt =3D 12, /* Backup battery voltage */<br>+ =C2=A0 =C2=A0retu_adc_=
self_temp =3D 13, =C2=A0/* RETU temperature */<br>=C2=A0};<br>=C2=A0<br>=C2=
=A0static inline uint16_t retu_read(CBusRetu *s, int reg)<br>@@ -246,7 +250=
,7 @@ static inline uint16_t retu_read(CBusRetu *s, int reg)<br>=C2=A0 =C2=
=A0 =C2=A0case RETU_REG_ASICR:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return =
0x0215 | (s-&gt;is_vilma &lt;&lt; 7);<br>=C2=A0<br>- =C2=A0 =C2=A0case RETU=
_REG_IDR:	/* TODO: Or is this ffs(s-&gt;irqst)? =C2=A0*/<br>+ =C2=A0 =C2=A0=
case RETU_REG_IDR: =C2=A0/* TODO: Or is this ffs(s-&gt;irqst)? =C2=A0*/<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return s-&gt;irqst;<br>=C2=A0<br>=C2=A0 =
=C2=A0 =C2=A0case RETU_REG_IMR:<br>@@ -355,8 +359,9 @@ static inline void r=
etu_write(CBusRetu *s, int reg, uint16_t val)<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break;<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0case RETU_REG_WATCHDOG:<b=
r>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if (val =3D=3D 0 &amp;&amp; (s-&gt;cc[0] &am=
p; 2))<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (val =3D=3D 0 &amp;&amp; (s-&gt;c=
c[0] &amp; 2)) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_sy=
stem_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>=C2=A0<br>=C2=
=A0 =C2=A0 =C2=A0case RETU_REG_TXCR:<br>@@ -380,10 +385,11 @@ static void r=
etu_io(void *opaque, int rw, int reg, uint16_t *val)<br>=C2=A0{<br>=C2=A0 =
=C2=A0 =C2=A0CBusRetu *s =3D (CBusRetu *) opaque;<br>=C2=A0<br>- =C2=A0 =C2=
=A0if (rw)<br>+ =C2=A0 =C2=A0if (rw) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0*val =3D retu_read(s, reg);<br>- =C2=A0 =C2=A0else<br>+ =C2=A0 =C2=A0} e=
lse {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retu_write(s, reg, *val);<br>+ =
=C2=A0 =C2=A0}<br>=C2=A0}<br>=C2=A0<br>=C2=A0void *retu_init(qemu_irq irq, =
int vilma)<br>@@ -424,47 +430,12 @@ void retu_key_event(void *retu, int sta=
te)<br>=C2=A0 =C2=A0 =C2=A0s-&gt;irqst |=3D 1 &lt;&lt; retu_int_pwr;<br>=C2=
=A0 =C2=A0 =C2=A0retu_interrupt_update(s);<br>=C2=A0<br>- =C2=A0 =C2=A0if (=
state)<br>+ =C2=A0 =C2=A0if (state) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
s-&gt;status &amp;=3D ~(1 &lt;&lt; 5);<br>- =C2=A0 =C2=A0else<br>+ =C2=A0 =
=C2=A0} else {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;status |=3D 1 &lt=
;&lt; 5;<br>-}<br>-<br>-#if 0<br>-static void retu_head_event(void *retu, i=
nt state)<br>-{<br>- =C2=A0 =C2=A0CBusSlave *slave =3D (CBusSlave *) retu;<=
br>- =C2=A0 =C2=A0CBusRetu *s =3D (CBusRetu *) slave-&gt;opaque;<br>-<br>- =
=C2=A0 =C2=A0if ((s-&gt;cc[0] &amp; 0x500) =3D=3D 0x500) {	/* TODO: Which b=
its? */<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0/* TODO: reissue the interrupt ever=
y 100ms or so. =C2=A0*/<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;irqst |=3D 1 =
&lt;&lt; retu_int_head;<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0retu_interrupt_upda=
te(s);<br>=C2=A0 =C2=A0 =C2=A0}<br>-<br>- =C2=A0 =C2=A0if (state)<br>- =C2=
=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;result[retu_adc_head_det] =3D 50;<br>- =C2=A0=
 =C2=A0else<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;result[retu_adc_head_det]=
 =3D 123;<br>-}<br>-<br>-static void retu_hook_event(void *retu, int state)=
<br>-{<br>- =C2=A0 =C2=A0CBusSlave *slave =3D (CBusSlave *) retu;<br>- =C2=
=A0 =C2=A0CBusRetu *s =3D (CBusRetu *) slave-&gt;opaque;<br>-<br>- =C2=A0 =
=C2=A0if ((s-&gt;cc[0] &amp; 0x500) =3D=3D 0x500) {<br>- =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* TODO: reissue the interrupt every 100ms or so. =C2=A0*/<br>- =
=C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;irqst |=3D 1 &lt;&lt; retu_int_hook;<br>- =
=C2=A0 =C2=A0 =C2=A0 =C2=A0retu_interrupt_update(s);<br>- =C2=A0 =C2=A0}<br=
>-<br>- =C2=A0 =C2=A0if (state)<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;resul=
t[retu_adc_hook_det] =3D 50;<br>- =C2=A0 =C2=A0else<br>- =C2=A0 =C2=A0 =C2=
=A0 =C2=A0s-&gt;result[retu_adc_hook_det] =3D 123;<br>=C2=A0}<br>-#endif<br=
>=C2=A0<br>=C2=A0/* Tahvo/Betty */<br>=C2=A0typedef struct {<br>@@ -485,20 =
+456,20 @@ static void tahvo_interrupt_update(CBusTahvo *s)<br>=C2=A0 =C2=
=A0 =C2=A0qemu_set_irq(s-&gt;irq, s-&gt;irqst &amp; ~s-&gt;irqen);<br>=C2=
=A0}<br>=C2=A0<br>-#define TAHVO_REG_ASICR		0x00	/* (RO) ASIC ID &amp; revi=
sion */<br>-#define TAHVO_REG_IDR		0x01	/* (T) =C2=A0Interrupt ID */<br>-#d=
efine TAHVO_REG_IDSR		0x02	/* (RO) Interrupt status */<br>-#define TAHVO_RE=
G_IMR		0x03	/* (RW) Interrupt mask */<br>-#define TAHVO_REG_CHAPWMR	0x04	/*=
 (RW) Charger PWM */<br>-#define TAHVO_REG_LEDPWMR	0x05	/* (RW) LED PWM */<=
br>-#define TAHVO_REG_USBR		0x06	/* (RW) USB control */<br>-#define TAHVO_R=
EG_RCR		0x07	/* (RW) Some kind of power management */<br>-#define TAHVO_REG=
_CCR1		0x08	/* (RW) Common control register 1 */<br>-#define TAHVO_REG_CCR2=
		0x09	/* (RW) Common control register 2 */<br>-#define TAHVO_REG_TESTR1	0x=
0a	/* (RW) Test register 1 */<br>-#define TAHVO_REG_TESTR2	0x0b	/* (RW) Tes=
t register 2 */<br>-#define TAHVO_REG_NOPR		0x0c	/* (RW) Number of periods =
*/<br>-#define TAHVO_REG_FRR		0x0d	/* (RO) FR */<br>+#define TAHVO_REG_ASIC=
R =C2=A0 0x00 =C2=A0/* (RO) ASIC ID &amp; revision */<br>+#define TAHVO_REG=
_IDR =C2=A0 =C2=A0 0x01 =C2=A0/* (T) =C2=A0Interrupt ID */<br>+#define TAHV=
O_REG_IDSR =C2=A0 =C2=A00x02 =C2=A0/* (RO) Interrupt status */<br>+#define =
TAHVO_REG_IMR =C2=A0 =C2=A0 0x03 =C2=A0/* (RW) Interrupt mask */<br>+#defin=
e TAHVO_REG_CHAPWMR 0x04 =C2=A0/* (RW) Charger PWM */<br>+#define TAHVO_REG=
_LEDPWMR 0x05 =C2=A0/* (RW) LED PWM */<br>+#define TAHVO_REG_USBR =C2=A0 =
=C2=A00x06 =C2=A0/* (RW) USB control */<br>+#define TAHVO_REG_RCR =C2=A0 =
=C2=A0 0x07 =C2=A0/* (RW) Some kind of power management */<br>+#define TAHV=
O_REG_CCR1 =C2=A0 =C2=A00x08 =C2=A0/* (RW) Common control register 1 */<br>=
+#define TAHVO_REG_CCR2 =C2=A0 =C2=A00x09 =C2=A0/* (RW) Common control regi=
ster 2 */<br>+#define TAHVO_REG_TESTR1 =C2=A00x0a =C2=A0/* (RW) Test regist=
er 1 */<br>+#define TAHVO_REG_TESTR2 =C2=A00x0b =C2=A0/* (RW) Test register=
 2 */<br>+#define TAHVO_REG_NOPR =C2=A0 =C2=A00x0c =C2=A0/* (RW) Number of =
periods */<br>+#define TAHVO_REG_FRR =C2=A0 =C2=A0 0x0d =C2=A0/* (RO) FR */=
<br>=C2=A0<br>=C2=A0static inline uint16_t tahvo_read(CBusTahvo *s, int reg=
)<br>=C2=A0{<br>@@ -508,10 +479,10 @@ static inline uint16_t tahvo_read(CBu=
sTahvo *s, int reg)<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0switch (reg) {<br>=C2=
=A0 =C2=A0 =C2=A0case TAHVO_REG_ASICR:<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0retu=
rn 0x0021 | (s-&gt;is_betty ? 0x0b00 : 0x0300);	/* 22 in N810 */<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0return 0x0021 | (s-&gt;is_betty ? 0x0b00 : 0x0300);=
 =C2=A0/* 22 in N810 */<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0case TAHVO_REG_IDR=
:<br>- =C2=A0 =C2=A0case TAHVO_REG_IDSR:	/* XXX: what does this do? =C2=A0*=
/<br>+ =C2=A0 =C2=A0case TAHVO_REG_IDSR: =C2=A0/* XXX: what does this do? =
=C2=A0*/<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return s-&gt;irqst;<br>=C2=A0=
<br>=C2=A0 =C2=A0 =C2=A0case TAHVO_REG_IMR:<br>@@ -596,10 +567,11 @@ static=
 void tahvo_io(void *opaque, int rw, int reg, uint16_t *val)<br>=C2=A0{<br>=
=C2=A0 =C2=A0 =C2=A0CBusTahvo *s =3D (CBusTahvo *) opaque;<br>=C2=A0<br>- =
=C2=A0 =C2=A0if (rw)<br>+ =C2=A0 =C2=A0if (rw) {<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0*val =3D tahvo_read(s, reg);<br>- =C2=A0 =C2=A0else<br>+ =C2=
=A0 =C2=A0} else {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tahvo_write(s, reg,=
 *val);<br>+ =C2=A0 }<br>=C2=A0}<br>=C2=A0<br>=C2=A0void *tahvo_init(qemu_i=
rq irq, int betty)<br>diff --git a/hw/misc/omap_clk.c b/hw/misc/omap_clk.c<=
br>index c77ca2fc74..ec2345e9ab 100644<br>--- a/hw/misc/omap_clk.c<br>+++ b=
/hw/misc/omap_clk.c<br>@@ -30,174 +30,174 @@ struct clk {<br>=C2=A0 =C2=A0 =
=C2=A0struct clk *parent;<br>=C2=A0 =C2=A0 =C2=A0struct clk *child1;<br>=C2=
=A0 =C2=A0 =C2=A0struct clk *sibling;<br>-#define ALWAYS_ENABLED		(1 &lt;&l=
t; 0)<br>-#define CLOCK_IN_OMAP310	(1 &lt;&lt; 10)<br>-#define CLOCK_IN_OMA=
P730	(1 &lt;&lt; 11)<br>-#define CLOCK_IN_OMAP1510	(1 &lt;&lt; 12)<br>-#def=
ine CLOCK_IN_OMAP16XX	(1 &lt;&lt; 13)<br>-#define CLOCK_IN_OMAP242X	(1 &lt;=
&lt; 14)<br>-#define CLOCK_IN_OMAP243X	(1 &lt;&lt; 15)<br>-#define CLOCK_IN=
_OMAP343X	(1 &lt;&lt; 16)<br>+#define ALWAYS_ENABLED =C2=A0 =C2=A0(1 &lt;&l=
t; 0)<br>+#define CLOCK_IN_OMAP310 =C2=A0(1 &lt;&lt; 10)<br>+#define CLOCK_=
IN_OMAP730 =C2=A0(1 &lt;&lt; 11)<br>+#define CLOCK_IN_OMAP1510 (1 &lt;&lt; =
12)<br>+#define CLOCK_IN_OMAP16XX (1 &lt;&lt; 13)<br>+#define CLOCK_IN_OMAP=
242X (1 &lt;&lt; 14)<br>+#define CLOCK_IN_OMAP243X (1 &lt;&lt; 15)<br>+#def=
ine CLOCK_IN_OMAP343X (1 &lt;&lt; 16)<br>=C2=A0 =C2=A0 =C2=A0uint32_t flags=
;<br>=C2=A0 =C2=A0 =C2=A0int id;<br>=C2=A0<br>- =C2=A0 =C2=A0int running;		=
/* Is currently ticking */<br>- =C2=A0 =C2=A0int enabled;		/* Is enabled, r=
egardless of its input clk */<br>- =C2=A0 =C2=A0unsigned long rate;		/* Cur=
rent rate (if .running) */<br>- =C2=A0 =C2=A0unsigned int divisor;	/* Rate =
relative to input (if .enabled) */<br>- =C2=A0 =C2=A0unsigned int multiplie=
r;	/* Rate relative to input (if .enabled) */<br>- =C2=A0 =C2=A0qemu_irq us=
ers[16];		/* Who to notify on change */<br>- =C2=A0 =C2=A0int usecount;		/*=
 Automatically idle when unused */<br>+ =C2=A0 =C2=A0int running; =C2=A0 =
=C2=A0/* Is currently ticking */<br>+ =C2=A0 =C2=A0int enabled; =C2=A0 =C2=
=A0/* Is enabled, regardless of its input clk */<br>+ =C2=A0 =C2=A0unsigned=
 long rate; =C2=A0 =C2=A0/* Current rate (if .running) */<br>+ =C2=A0 =C2=
=A0unsigned int divisor; /*g Rate relative to input (if .enabled) */<br>+ =
=C2=A0 =C2=A0unsigned int multiplier; /*g Rate relative to input (if .enabl=
ed) */<br>+ =C2=A0 =C2=A0qemu_irq users[16]; =C2=A0 =C2=A0/* Who to notify =
on change */<br>+ =C2=A0 =C2=A0int usecount; =C2=A0 =C2=A0/* Automatically =
idle when unused */<br>=C2=A0};<br>=C2=A0<br>=C2=A0static struct clk xtal_o=
sc12m =3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;xtal_osc_12m&quot;,<br>- =C2=
=A0 =C2=A0.rate	=3D 12000000,<br>- =C2=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP151=
0 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310,<br>+ =C2=A0 =C2=A0.name =3D &quot=
;xtal_osc_12m&quot;,<br>+ =C2=A0 =C2=A0.rate =3D 12000000,<br>+ =C2=A0 =C2=
=A0.flags =3D CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310,<br>=
=C2=A0};<br>=C2=A0<br>=C2=A0static struct clk xtal_osc32k =3D {<br>- =C2=A0=
 =C2=A0.name	=3D &quot;xtal_osc_32k&quot;,<br>- =C2=A0 =C2=A0.rate	=3D 3276=
8,<br>- =C2=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLO=
CK_IN_OMAP310 |<br>+ =C2=A0 =C2=A0.name =3D &quot;xtal_osc_32k&quot;,<br>+ =
=C2=A0 =C2=A0.rate =3D 32768,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP151=
0 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310 |<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>=C2=A0};<br>=
=C2=A0<br>=C2=A0static struct clk ck_ref =3D {<br>- =C2=A0 =C2=A0.name	=3D =
&quot;ck_ref&quot;,<br>- =C2=A0 =C2=A0.alias	=3D &quot;clkin&quot;,<br>- =
=C2=A0 =C2=A0.parent	=3D &amp;xtal_osc12m,<br>- =C2=A0 =C2=A0.flags	=3D CLO=
CK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310 |<br>+ =C2=A0 =C2=A0.=
name =3D &quot;ck_ref&quot;,<br>+ =C2=A0 =C2=A0.alias =3D &quot;clkin&quot;=
,<br>+ =C2=A0 =C2=A0.parent =3D &amp;xtal_osc12m,<br>+ =C2=A0 =C2=A0.flags =
=3D CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310 |<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ALWAYS_ENABLED,<br>=C2=A0};<br>=C2=
=A0<br>=C2=A0/* If a dpll is disabled it becomes a bypass, child clocks don=
&#39;t stop */<br>=C2=A0static struct clk dpll1 =3D {<br>- =C2=A0 =C2=A0.na=
me	=3D &quot;dpll1&quot;,<br>- =C2=A0 =C2=A0.parent	=3D &amp;ck_ref,<br>- =
=C2=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OM=
AP310 |<br>+ =C2=A0 =C2=A0.name =3D &quot;dpll1&quot;,<br>+ =C2=A0 =C2=A0.p=
arent =3D &amp;ck_ref,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP1510 | CLO=
CK_IN_OMAP16XX | CLOCK_IN_OMAP310 |<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0ALWAYS_ENABLED,<br>=C2=A0};<br>=C2=A0<br>=C2=A0static struct c=
lk dpll2 =3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;dpll2&quot;,<br>- =C2=A0 =
=C2=A0.parent	=3D &amp;ck_ref,<br>- =C2=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP31=
0 | ALWAYS_ENABLED,<br>+ =C2=A0 =C2=A0.name =3D &quot;dpll2&quot;,<br>+ =C2=
=A0 =C2=A0.parent =3D &amp;ck_ref,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OM=
AP310 | ALWAYS_ENABLED,<br>=C2=A0};<br>=C2=A0<br>=C2=A0static struct clk dp=
ll3 =3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;dpll3&quot;,<br>- =C2=A0 =C2=A0=
.parent	=3D &amp;ck_ref,<br>- =C2=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP310 | AL=
WAYS_ENABLED,<br>+ =C2=A0 =C2=A0.name =3D &quot;dpll3&quot;,<br>+ =C2=A0 =
=C2=A0.parent =3D &amp;ck_ref,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP31=
0 | ALWAYS_ENABLED,<br>=C2=A0};<br>=C2=A0<br>=C2=A0static struct clk dpll4 =
=3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;dpll4&quot;,<br>- =C2=A0 =C2=A0.par=
ent	=3D &amp;ck_ref,<br>- =C2=A0 =C2=A0.multiplier	=3D 4,<br>- =C2=A0 =C2=
=A0.flags	=3D CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310,<br>=
+ =C2=A0 =C2=A0.name =3D &quot;dpll4&quot;,<br>+ =C2=A0 =C2=A0.parent =3D &=
amp;ck_ref,<br>+ =C2=A0 =C2=A0.multiplier =3D 4,<br>+ =C2=A0 =C2=A0.flags =
=3D CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310,<br>=C2=A0};<b=
r>=C2=A0<br>=C2=A0static struct clk apll =3D {<br>- =C2=A0 =C2=A0.name	=3D =
&quot;apll&quot;,<br>- =C2=A0 =C2=A0.parent	=3D &amp;ck_ref,<br>- =C2=A0 =
=C2=A0.multiplier	=3D 48,<br>- =C2=A0 =C2=A0.divisor	=3D 12,<br>- =C2=A0 =
=C2=A0.flags	=3D CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310,<=
br>+ =C2=A0 =C2=A0.name =3D &quot;apll&quot;,<br>+ =C2=A0 =C2=A0.parent =3D=
 &amp;ck_ref,<br>+ =C2=A0 =C2=A0.multiplier =3D 48,<br>+ =C2=A0 =C2=A0.divi=
sor =3D 12,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP1=
6XX | CLOCK_IN_OMAP310,<br>=C2=A0};<br>=C2=A0<br>=C2=A0static struct clk ck=
_48m =3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;ck_48m&quot;,<br>- =C2=A0 =C2=
=A0.parent	=3D &amp;dpll4,	/* either dpll4 or apll */<br>- =C2=A0 =C2=A0.fl=
ags	=3D CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310,<br>+ =C2=
=A0 =C2=A0.name =3D &quot;ck_48m&quot;,<br>+ =C2=A0 =C2=A0.parent =3D &amp;=
dpll4, /*g either dpll4 or apll */<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OM=
AP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310,<br>=C2=A0};<br>=C2=A0<br>=C2=
=A0static struct clk ck_dpll1out =3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;ck=
_dpll1out&quot;,<br>- =C2=A0 =C2=A0.parent	=3D &amp;dpll1,<br>- =C2=A0 =C2=
=A0.flags	=3D CLOCK_IN_OMAP16XX,<br>+ =C2=A0 =C2=A0.name =3D &quot;ck_dpll1=
out&quot;,<br>+ =C2=A0 =C2=A0.parent =3D &amp;dpll1,<br>+ =C2=A0 =C2=A0.fla=
gs =3D CLOCK_IN_OMAP16XX,<br>=C2=A0};<br>=C2=A0<br>=C2=A0static struct clk =
sossi_ck =3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;ck_sossi&quot;,<br>- =C2=
=A0 =C2=A0.parent	=3D &amp;ck_dpll1out,<br>- =C2=A0 =C2=A0.flags	=3D CLOCK_=
IN_OMAP16XX,<br>+ =C2=A0 =C2=A0.name =3D &quot;ck_sossi&quot;,<br>+ =C2=A0 =
=C2=A0.parent =3D &amp;ck_dpll1out,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_O=
MAP16XX,<br>=C2=A0};<br>=C2=A0<br>=C2=A0static struct clk clkm1 =3D {<br>- =
=C2=A0 =C2=A0.name	=3D &quot;clkm1&quot;,<br>- =C2=A0 =C2=A0.alias	=3D &quo=
t;ck_gen1&quot;,<br>- =C2=A0 =C2=A0.parent	=3D &amp;dpll1,<br>- =C2=A0 =C2=
=A0.flags	=3D CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310 |<br=
>+ =C2=A0 =C2=A0.name =3D &quot;clkm1&quot;,<br>+ =C2=A0 =C2=A0.alias =3D &=
quot;ck_gen1&quot;,<br>+ =C2=A0 =C2=A0.parent =3D &amp;dpll1,<br>+ =C2=A0 =
=C2=A0.flags =3D CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310 |=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ALWAYS_ENABLED,<br>=C2=
=A0};<br>=C2=A0<br>=C2=A0static struct clk clkm2 =3D {<br>- =C2=A0 =C2=A0.n=
ame	=3D &quot;clkm2&quot;,<br>- =C2=A0 =C2=A0.alias	=3D &quot;ck_gen2&quot;=
,<br>- =C2=A0 =C2=A0.parent	=3D &amp;dpll1,<br>- =C2=A0 =C2=A0.flags	=3D CL=
OCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310 |<br>+ =C2=A0 =C2=A0=
.name =3D &quot;clkm2&quot;,<br>+ =C2=A0 =C2=A0.alias =3D &quot;ck_gen2&quo=
t;,<br>+ =C2=A0 =C2=A0.parent =3D &amp;dpll1,<br>+ =C2=A0 =C2=A0.flags =3D =
CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310 |<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ALWAYS_ENABLED,<br>=C2=A0};<br>=C2=A0<br=
>=C2=A0static struct clk clkm3 =3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;clkm=
3&quot;,<br>- =C2=A0 =C2=A0.alias	=3D &quot;ck_gen3&quot;,<br>- =C2=A0 =C2=
=A0.parent	=3D &amp;dpll1,	/* either dpll1 or ck_ref */<br>- =C2=A0 =C2=A0.=
flags	=3D CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310 |<br>+ =
=C2=A0 =C2=A0.name =3D &quot;clkm3&quot;,<br>+ =C2=A0 =C2=A0.alias =3D &quo=
t;ck_gen3&quot;,<br>+ =C2=A0 =C2=A0.parent =3D &amp;dpll1, /*g either dpll1=
 or ck_ref */<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP1510 | CLOCK_IN_OMA=
P16XX | CLOCK_IN_OMAP310 |<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0ALWAYS_ENABLED,<br>=C2=A0};<br>=C2=A0<br>=C2=A0static struct clk arm_ck =
=3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;arm_ck&quot;,<br>- =C2=A0 =C2=A0.al=
ias	=3D &quot;mpu_ck&quot;,<br>- =C2=A0 =C2=A0.parent	=3D &amp;clkm1,<br>- =
=C2=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OM=
AP310 |<br>+ =C2=A0 =C2=A0.name =3D &quot;arm_ck&quot;,<br>+ =C2=A0 =C2=A0.=
alias =3D &quot;mpu_ck&quot;,<br>+ =C2=A0 =C2=A0.parent =3D &amp;clkm1,<br>=
+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_=
OMAP310 |<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ALWAYS_ENABLED=
,<br>=C2=A0};<br>=C2=A0<br>=C2=A0static struct clk armper_ck =3D {<br>- =C2=
=A0 =C2=A0.name	=3D &quot;armper_ck&quot;,<br>- =C2=A0 =C2=A0.alias	=3D &qu=
ot;mpuper_ck&quot;,<br>- =C2=A0 =C2=A0.parent	=3D &amp;clkm1,<br>- =C2=A0 =
=C2=A0.flags	=3D CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310,<=
br>+ =C2=A0 =C2=A0.name =3D &quot;armper_ck&quot;,<br>+ =C2=A0 =C2=A0.alias=
 =3D &quot;mpuper_ck&quot;,<br>+ =C2=A0 =C2=A0.parent =3D &amp;clkm1,<br>+ =
=C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OM=
AP310,<br>=C2=A0};<br>=C2=A0<br>=C2=A0static struct clk arm_gpio_ck =3D {<b=
r>- =C2=A0 =C2=A0.name	=3D &quot;arm_gpio_ck&quot;,<br>- =C2=A0 =C2=A0.alia=
s	=3D &quot;mpu_gpio_ck&quot;,<br>- =C2=A0 =C2=A0.parent	=3D &amp;clkm1,<br=
>- =C2=A0 =C2=A0.divisor	=3D 1,<br>- =C2=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP1=
510 | CLOCK_IN_OMAP310,<br>+ =C2=A0 =C2=A0.name =3D &quot;arm_gpio_ck&quot;=
,<br>+ =C2=A0 =C2=A0.alias =3D &quot;mpu_gpio_ck&quot;,<br>+ =C2=A0 =C2=A0.=
parent =3D &amp;clkm1,<br>+ =C2=A0 =C2=A0.divisor =3D 1,<br>+ =C2=A0 =C2=A0=
.flags =3D CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310,<br>=C2=A0};<br>=C2=A0<br>=
=C2=A0static struct clk armxor_ck =3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;a=
rmxor_ck&quot;,<br>- =C2=A0 =C2=A0.alias	=3D &quot;mpuxor_ck&quot;,<br>- =
=C2=A0 =C2=A0.parent	=3D &amp;ck_ref,<br>- =C2=A0 =C2=A0.flags	=3D CLOCK_IN=
_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310,<br>+ =C2=A0 =C2=A0.name =
=3D &quot;armxor_ck&quot;,<br>+ =C2=A0 =C2=A0.alias =3D &quot;mpuxor_ck&quo=
t;,<br>+ =C2=A0 =C2=A0.parent =3D &amp;ck_ref,<br>+ =C2=A0 =C2=A0.flags =3D=
 CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310,<br>=C2=A0};<br>=
=C2=A0<br>=C2=A0static struct clk armtim_ck =3D {<br>- =C2=A0 =C2=A0.name	=
=3D &quot;armtim_ck&quot;,<br>- =C2=A0 =C2=A0.alias	=3D &quot;mputim_ck&quo=
t;,<br>- =C2=A0 =C2=A0.parent	=3D &amp;ck_ref,	/* either CLKIN or DPLL1 */<=
br>- =C2=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_=
IN_OMAP310,<br>+ =C2=A0 =C2=A0.name =3D &quot;armtim_ck&quot;,<br>+ =C2=A0 =
=C2=A0.alias =3D &quot;mputim_ck&quot;,<br>+ =C2=A0 =C2=A0.parent =3D &amp;=
ck_ref, /*g either CLKIN or DPLL1 */<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_=
OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310,<br>=C2=A0};<br>=C2=A0<br>=
=C2=A0static struct clk armwdt_ck =3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;a=
rmwdt_ck&quot;,<br>- =C2=A0 =C2=A0.alias	=3D &quot;mpuwd_ck&quot;,<br>- =C2=
=A0 =C2=A0.parent	=3D &amp;clkm1,<br>- =C2=A0 =C2=A0.divisor	=3D 14,<br>- =
=C2=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OM=
AP310 |<br>+ =C2=A0 =C2=A0.name =3D &quot;armwdt_ck&quot;,<br>+ =C2=A0 =C2=
=A0.alias =3D &quot;mpuwd_ck&quot;,<br>+ =C2=A0 =C2=A0.parent =3D &amp;clkm=
1,<br>+ =C2=A0 =C2=A0.divisor =3D 14,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN=
_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310 |<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0ALWAYS_ENABLED,<br>=C2=A0};<br>=C2=A0<br>=C2=A0s=
tatic struct clk arminth_ck16xx =3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;arm=
inth_ck&quot;,<br>- =C2=A0 =C2=A0.parent	=3D &amp;arm_ck,<br>- =C2=A0 =C2=
=A0.flags	=3D CLOCK_IN_OMAP16XX | ALWAYS_ENABLED,<br>+ =C2=A0 =C2=A0.name =
=3D &quot;arminth_ck&quot;,<br>+ =C2=A0 =C2=A0.parent =3D &amp;arm_ck,<br>+=
 =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP16XX | ALWAYS_ENABLED,<br>=C2=A0 =C2=
=A0 =C2=A0/* Note: On 16xx the frequency can be divided by 2 by programming=
<br>=C2=A0 =C2=A0 =C2=A0 * ARM_CKCTL:ARM_INTHCK_SEL(14) to 1<br>=C2=A0 =C2=
=A0 =C2=A0 *<br>@@ -206,48 +206,48 @@ static struct clk arminth_ck16xx =3D =
{<br>=C2=A0};<br>=C2=A0<br>=C2=A0static struct clk dsp_ck =3D {<br>- =C2=A0=
 =C2=A0.name	=3D &quot;dsp_ck&quot;,<br>- =C2=A0 =C2=A0.parent	=3D &amp;clk=
m2,<br>- =C2=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLO=
CK_IN_OMAP16XX,<br>+ =C2=A0 =C2=A0.name =3D &quot;dsp_ck&quot;,<br>+ =C2=A0=
 =C2=A0.parent =3D &amp;clkm2,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP31=
0 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX,<br>=C2=A0};<br>=C2=A0<br>=C2=A0s=
tatic struct clk dspmmu_ck =3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;dspmmu_c=
k&quot;,<br>- =C2=A0 =C2=A0.parent	=3D &amp;clkm2,<br>- =C2=A0 =C2=A0.flags=
	=3D CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |<br>+ =C2=A0=
 =C2=A0.name =3D &quot;dspmmu_ck&quot;,<br>+ =C2=A0 =C2=A0.parent =3D &amp;=
clkm2,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | =
CLOCK_IN_OMAP16XX |<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ALWA=
YS_ENABLED,<br>=C2=A0};<br>=C2=A0<br>=C2=A0static struct clk dspper_ck =3D =
{<br>- =C2=A0 =C2=A0.name	=3D &quot;dspper_ck&quot;,<br>- =C2=A0 =C2=A0.par=
ent	=3D &amp;clkm2,<br>- =C2=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP310 | CLOCK_I=
N_OMAP1510 | CLOCK_IN_OMAP16XX,<br>+ =C2=A0 =C2=A0.name =3D &quot;dspper_ck=
&quot;,<br>+ =C2=A0 =C2=A0.parent =3D &amp;clkm2,<br>+ =C2=A0 =C2=A0.flags =
=3D CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX,<br>=C2=A0};<b=
r>=C2=A0<br>=C2=A0static struct clk dspxor_ck =3D {<br>- =C2=A0 =C2=A0.name=
	=3D &quot;dspxor_ck&quot;,<br>- =C2=A0 =C2=A0.parent	=3D &amp;ck_ref,<br>-=
 =C2=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OM=
AP16XX,<br>+ =C2=A0 =C2=A0.name =3D &quot;dspxor_ck&quot;,<br>+ =C2=A0 =C2=
=A0.parent =3D &amp;ck_ref,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP310 |=
 CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX,<br>=C2=A0};<br>=C2=A0<br>=C2=A0stat=
ic struct clk dsptim_ck =3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;dsptim_ck&q=
uot;,<br>- =C2=A0 =C2=A0.parent	=3D &amp;ck_ref,<br>- =C2=A0 =C2=A0.flags	=
=3D CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX,<br>+ =C2=A0 =
=C2=A0.name =3D &quot;dsptim_ck&quot;,<br>+ =C2=A0 =C2=A0.parent =3D &amp;c=
k_ref,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | =
CLOCK_IN_OMAP16XX,<br>=C2=A0};<br>=C2=A0<br>=C2=A0static struct clk tc_ck =
=3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;tc_ck&quot;,<br>- =C2=A0 =C2=A0.par=
ent	=3D &amp;clkm3,<br>- =C2=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP1510 | CLOCK_=
IN_OMAP16XX |<br>+ =C2=A0 =C2=A0.name =3D &quot;tc_ck&quot;,<br>+ =C2=A0 =
=C2=A0.parent =3D &amp;clkm3,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP151=
0 | CLOCK_IN_OMAP16XX |<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
CLOCK_IN_OMAP730 | CLOCK_IN_OMAP310 |<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0ALWAYS_ENABLED,<br>=C2=A0};<br>=C2=A0<br>=C2=A0static struct =
clk arminth_ck15xx =3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;arminth_ck&quot;=
,<br>- =C2=A0 =C2=A0.parent	=3D &amp;tc_ck,<br>- =C2=A0 =C2=A0.flags	=3D CL=
OCK_IN_OMAP1510 | CLOCK_IN_OMAP310 | ALWAYS_ENABLED,<br>+ =C2=A0 =C2=A0.nam=
e =3D &quot;arminth_ck&quot;,<br>+ =C2=A0 =C2=A0.parent =3D &amp;tc_ck,<br>=
+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 | ALWAYS_ENA=
BLED,<br>=C2=A0 =C2=A0 =C2=A0/* Note: On 1510 the frequency follows TC_CK<b=
r>=C2=A0 =C2=A0 =C2=A0 *<br>=C2=A0 =C2=A0 =C2=A0 * 16xx version is in MPU c=
locks.<br>@@ -256,606 +256,606 @@ static struct clk arminth_ck15xx =3D {<br=
>=C2=A0<br>=C2=A0static struct clk tipb_ck =3D {<br>=C2=A0 =C2=A0 =C2=A0/* =
No-idle controlled by &quot;tc_ck&quot; */<br>- =C2=A0 =C2=A0.name	=3D &quo=
t;tipb_ck&quot;,<br>- =C2=A0 =C2=A0.parent	=3D &amp;tc_ck,<br>- =C2=A0 =C2=
=A0.flags	=3D CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 | ALWAYS_ENABLED,<br>+ =
=C2=A0 =C2=A0.name =3D &quot;tipb_ck&quot;,<br>+ =C2=A0 =C2=A0.parent =3D &=
amp;tc_ck,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP31=
0 | ALWAYS_ENABLED,<br>=C2=A0};<br>=C2=A0<br>=C2=A0static struct clk l3_ocp=
i_ck =3D {<br>=C2=A0 =C2=A0 =C2=A0/* No-idle controlled by &quot;tc_ck&quot=
; */<br>- =C2=A0 =C2=A0.name	=3D &quot;l3_ocpi_ck&quot;,<br>- =C2=A0 =C2=A0=
.parent	=3D &amp;tc_ck,<br>- =C2=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP16XX,<br>=
+ =C2=A0 =C2=A0.name =3D &quot;l3_ocpi_ck&quot;,<br>+ =C2=A0 =C2=A0.parent =
=3D &amp;tc_ck,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP16XX,<br>=C2=A0};=
<br>=C2=A0<br>=C2=A0static struct clk tc1_ck =3D {<br>- =C2=A0 =C2=A0.name	=
=3D &quot;tc1_ck&quot;,<br>- =C2=A0 =C2=A0.parent	=3D &amp;tc_ck,<br>- =C2=
=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP16XX,<br>+ =C2=A0 =C2=A0.name =3D &quot;t=
c1_ck&quot;,<br>+ =C2=A0 =C2=A0.parent =3D &amp;tc_ck,<br>+ =C2=A0 =C2=A0.f=
lags =3D CLOCK_IN_OMAP16XX,<br>=C2=A0};<br>=C2=A0<br>=C2=A0static struct cl=
k tc2_ck =3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;tc2_ck&quot;,<br>- =C2=A0 =
=C2=A0.parent	=3D &amp;tc_ck,<br>- =C2=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP16X=
X,<br>+ =C2=A0 =C2=A0.name =3D &quot;tc2_ck&quot;,<br>+ =C2=A0 =C2=A0.paren=
t =3D &amp;tc_ck,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP16XX,<br>=C2=A0=
};<br>=C2=A0<br>=C2=A0static struct clk dma_ck =3D {<br>=C2=A0 =C2=A0 =C2=
=A0/* No-idle controlled by &quot;tc_ck&quot; */<br>- =C2=A0 =C2=A0.name	=
=3D &quot;dma_ck&quot;,<br>- =C2=A0 =C2=A0.parent	=3D &amp;tc_ck,<br>- =C2=
=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP3=
10 |<br>+ =C2=A0 =C2=A0.name =3D &quot;dma_ck&quot;,<br>+ =C2=A0 =C2=A0.par=
ent =3D &amp;tc_ck,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP1510 | CLOCK_=
IN_OMAP16XX | CLOCK_IN_OMAP310 |<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ALWAYS_ENABLED,<br>=C2=A0};<br>=C2=A0<br>=C2=A0static struct clk =
dma_lcdfree_ck =3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;dma_lcdfree_ck&quot;=
,<br>- =C2=A0 =C2=A0.parent	=3D &amp;tc_ck,<br>- =C2=A0 =C2=A0.flags	=3D CL=
OCK_IN_OMAP16XX | ALWAYS_ENABLED,<br>+ =C2=A0 =C2=A0.name =3D &quot;dma_lcd=
free_ck&quot;,<br>+ =C2=A0 =C2=A0.parent =3D &amp;tc_ck,<br>+ =C2=A0 =C2=A0=
.flags =3D CLOCK_IN_OMAP16XX | ALWAYS_ENABLED,<br>=C2=A0};<br>=C2=A0<br>=C2=
=A0static struct clk api_ck =3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;api_ck&=
quot;,<br>- =C2=A0 =C2=A0.alias	=3D &quot;mpui_ck&quot;,<br>- =C2=A0 =C2=A0=
.parent	=3D &amp;tc_ck,<br>- =C2=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP1510 | CL=
OCK_IN_OMAP16XX | CLOCK_IN_OMAP310,<br>+ =C2=A0 =C2=A0.name =3D &quot;api_c=
k&quot;,<br>+ =C2=A0 =C2=A0.alias =3D &quot;mpui_ck&quot;,<br>+ =C2=A0 =C2=
=A0.parent =3D &amp;tc_ck,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP1510 |=
 CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310,<br>=C2=A0};<br>=C2=A0<br>=C2=A0stati=
c struct clk lb_ck =3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;lb_ck&quot;,<br>=
- =C2=A0 =C2=A0.parent	=3D &amp;tc_ck,<br>- =C2=A0 =C2=A0.flags	=3D CLOCK_I=
N_OMAP1510 | CLOCK_IN_OMAP310,<br>+ =C2=A0 =C2=A0.name =3D &quot;lb_ck&quot=
;,<br>+ =C2=A0 =C2=A0.parent =3D &amp;tc_ck,<br>+ =C2=A0 =C2=A0.flags =3D C=
LOCK_IN_OMAP1510 | CLOCK_IN_OMAP310,<br>=C2=A0};<br>=C2=A0<br>=C2=A0static =
struct clk lbfree_ck =3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;lbfree_ck&quot=
;,<br>- =C2=A0 =C2=A0.parent	=3D &amp;tc_ck,<br>- =C2=A0 =C2=A0.flags	=3D C=
LOCK_IN_OMAP1510 | CLOCK_IN_OMAP310,<br>+ =C2=A0 =C2=A0.name =3D &quot;lbfr=
ee_ck&quot;,<br>+ =C2=A0 =C2=A0.parent =3D &amp;tc_ck,<br>+ =C2=A0 =C2=A0.f=
lags =3D CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310,<br>=C2=A0};<br>=C2=A0<br>=C2=
=A0static struct clk hsab_ck =3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;hsab_c=
k&quot;,<br>- =C2=A0 =C2=A0.parent	=3D &amp;tc_ck,<br>- =C2=A0 =C2=A0.flags=
	=3D CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310,<br>+ =C2=A0 =C2=A0.name =3D &quo=
t;hsab_ck&quot;,<br>+ =C2=A0 =C2=A0.parent =3D &amp;tc_ck,<br>+ =C2=A0 =C2=
=A0.flags =3D CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310,<br>=C2=A0};<br>=C2=A0<b=
r>=C2=A0static struct clk rhea1_ck =3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;=
rhea1_ck&quot;,<br>- =C2=A0 =C2=A0.parent	=3D &amp;tc_ck,<br>- =C2=A0 =C2=
=A0.flags	=3D CLOCK_IN_OMAP16XX | ALWAYS_ENABLED,<br>+ =C2=A0 =C2=A0.name =
=3D &quot;rhea1_ck&quot;,<br>+ =C2=A0 =C2=A0.parent =3D &amp;tc_ck,<br>+ =
=C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP16XX | ALWAYS_ENABLED,<br>=C2=A0};<br>=
=C2=A0<br>=C2=A0static struct clk rhea2_ck =3D {<br>- =C2=A0 =C2=A0.name	=
=3D &quot;rhea2_ck&quot;,<br>- =C2=A0 =C2=A0.parent	=3D &amp;tc_ck,<br>- =
=C2=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP16XX | ALWAYS_ENABLED,<br>+ =C2=A0 =C2=
=A0.name =3D &quot;rhea2_ck&quot;,<br>+ =C2=A0 =C2=A0.parent =3D &amp;tc_ck=
,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP16XX | ALWAYS_ENABLED,<br>=C2=
=A0};<br>=C2=A0<br>=C2=A0static struct clk lcd_ck_16xx =3D {<br>- =C2=A0 =
=C2=A0.name	=3D &quot;lcd_ck&quot;,<br>- =C2=A0 =C2=A0.parent	=3D &amp;clkm=
3,<br>- =C2=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP730,<br>+ =
=C2=A0 =C2=A0.name =3D &quot;lcd_ck&quot;,<br>+ =C2=A0 =C2=A0.parent =3D &a=
mp;clkm3,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP730=
,<br>=C2=A0};<br>=C2=A0<br>=C2=A0static struct clk lcd_ck_1510 =3D {<br>- =
=C2=A0 =C2=A0.name	=3D &quot;lcd_ck&quot;,<br>- =C2=A0 =C2=A0.parent	=3D &a=
mp;clkm3,<br>- =C2=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310=
,<br>+ =C2=A0 =C2=A0.name =3D &quot;lcd_ck&quot;,<br>+ =C2=A0 =C2=A0.parent=
 =3D &amp;clkm3,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP1510 | CLOCK_IN_=
OMAP310,<br>=C2=A0};<br>=C2=A0<br>=C2=A0static struct clk uart1_1510 =3D {<=
br>- =C2=A0 =C2=A0.name	=3D &quot;uart1_ck&quot;,<br>+ =C2=A0 =C2=A0.name =
=3D &quot;uart1_ck&quot;,<br>=C2=A0 =C2=A0 =C2=A0/* Direct from ULPD, no re=
al parent */<br>- =C2=A0 =C2=A0.parent	=3D &amp;armper_ck,	/* either armper=
_ck or dpll4 */<br>- =C2=A0 =C2=A0.rate	=3D 12000000,<br>- =C2=A0 =C2=A0.fl=
ags	=3D CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 | ALWAYS_ENABLED,<br>+ =C2=A0 =
=C2=A0.parent =3D &amp;armper_ck, /*g either armper_ck or dpll4 */<br>+ =C2=
=A0 =C2=A0.rate =3D 12000000,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP151=
0 | CLOCK_IN_OMAP310 | ALWAYS_ENABLED,<br>=C2=A0};<br>=C2=A0<br>=C2=A0stati=
c struct clk uart1_16xx =3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;uart1_ck&qu=
ot;,<br>+ =C2=A0 =C2=A0.name =3D &quot;uart1_ck&quot;,<br>=C2=A0 =C2=A0 =C2=
=A0/* Direct from ULPD, no real parent */<br>- =C2=A0 =C2=A0.parent	=3D &am=
p;armper_ck,<br>- =C2=A0 =C2=A0.rate	=3D 48000000,<br>- =C2=A0 =C2=A0.flags=
	=3D CLOCK_IN_OMAP16XX,<br>+ =C2=A0 =C2=A0.parent =3D &amp;armper_ck,<br>+ =
=C2=A0 =C2=A0.rate =3D 48000000,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP=
16XX,<br>=C2=A0};<br>=C2=A0<br>=C2=A0static struct clk uart2_ck =3D {<br>- =
=C2=A0 =C2=A0.name	=3D &quot;uart2_ck&quot;,<br>+ =C2=A0 =C2=A0.name =3D &q=
uot;uart2_ck&quot;,<br>=C2=A0 =C2=A0 =C2=A0/* Direct from ULPD, no real par=
ent */<br>- =C2=A0 =C2=A0.parent	=3D &amp;armper_ck,	/* either armper_ck or=
 dpll4 */<br>- =C2=A0 =C2=A0.rate	=3D 12000000,<br>- =C2=A0 =C2=A0.flags	=
=3D CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310 |<br>+ =C2=A0 =
=C2=A0.parent =3D &amp;armper_ck, /*g either armper_ck or dpll4 */<br>+ =C2=
=A0 =C2=A0.rate =3D 12000000,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP151=
0 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310 |<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0ALWAYS_ENABLED,<br>=C2=A0};<br>=C2=A0<br>=C2=A0static s=
truct clk uart3_1510 =3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;uart3_ck&quot;=
,<br>+ =C2=A0 =C2=A0.name =3D &quot;uart3_ck&quot;,<br>=C2=A0 =C2=A0 =C2=A0=
/* Direct from ULPD, no real parent */<br>- =C2=A0 =C2=A0.parent	=3D &amp;a=
rmper_ck,	/* either armper_ck or dpll4 */<br>- =C2=A0 =C2=A0.rate	=3D 12000=
000,<br>- =C2=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 | AL=
WAYS_ENABLED,<br>+ =C2=A0 =C2=A0.parent =3D &amp;armper_ck, /*g either armp=
er_ck or dpll4 */<br>+ =C2=A0 =C2=A0.rate =3D 12000000,<br>+ =C2=A0 =C2=A0.=
flags =3D CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 | ALWAYS_ENABLED,<br>=C2=A0}=
;<br>=C2=A0<br>=C2=A0static struct clk uart3_16xx =3D {<br>- =C2=A0 =C2=A0.=
name	=3D &quot;uart3_ck&quot;,<br>+ =C2=A0 =C2=A0.name =3D &quot;uart3_ck&q=
uot;,<br>=C2=A0 =C2=A0 =C2=A0/* Direct from ULPD, no real parent */<br>- =
=C2=A0 =C2=A0.parent	=3D &amp;armper_ck,<br>- =C2=A0 =C2=A0.rate	=3D 480000=
00,<br>- =C2=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP16XX,<br>+ =C2=A0 =C2=A0.pare=
nt =3D &amp;armper_ck,<br>+ =C2=A0 =C2=A0.rate =3D 48000000,<br>+ =C2=A0 =
=C2=A0.flags =3D CLOCK_IN_OMAP16XX,<br>=C2=A0};<br>=C2=A0<br>-static struct=
 clk usb_clk0 =3D {	/* 6 MHz output on W4_USB_CLK0 */<br>- =C2=A0 =C2=A0.na=
me	=3D &quot;usb_clk0&quot;,<br>- =C2=A0 =C2=A0.alias	=3D &quot;usb.clko&qu=
ot;,<br>+static struct clk usb_clk0 =3D { /*g 6 MHz output on W4_USB_CLK0 *=
/<br>+ =C2=A0 =C2=A0.name =3D &quot;usb_clk0&quot;,<br>+ =C2=A0 =C2=A0.alia=
s =3D &quot;usb.clko&quot;,<br>=C2=A0 =C2=A0 =C2=A0/* Direct from ULPD, no =
parent */<br>- =C2=A0 =C2=A0.rate	=3D 6000000,<br>- =C2=A0 =C2=A0.flags	=3D=
 CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310,<br>+ =C2=A0 =C2=
=A0.rate =3D 6000000,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP1510 | CLOC=
K_IN_OMAP16XX | CLOCK_IN_OMAP310,<br>=C2=A0};<br>=C2=A0<br>=C2=A0static str=
uct clk usb_hhc_ck1510 =3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;usb_hhc_ck&q=
uot;,<br>+ =C2=A0 =C2=A0.name =3D &quot;usb_hhc_ck&quot;,<br>=C2=A0 =C2=A0 =
=C2=A0/* Direct from ULPD, no parent */<br>- =C2=A0 =C2=A0.rate	=3D 4800000=
0, /* Actually 2 clocks, 12MHz and 48MHz */<br>- =C2=A0 =C2=A0.flags	=3D CL=
OCK_IN_OMAP1510 | CLOCK_IN_OMAP310,<br>+ =C2=A0 =C2=A0.rate =3D 48000000, /=
* Actually 2 clocks, 12MHz and 48MHz */<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_=
IN_OMAP1510 | CLOCK_IN_OMAP310,<br>=C2=A0};<br>=C2=A0<br>=C2=A0static struc=
t clk usb_hhc_ck16xx =3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;usb_hhc_ck&quo=
t;,<br>+ =C2=A0 =C2=A0.name =3D &quot;usb_hhc_ck&quot;,<br>=C2=A0 =C2=A0 =
=C2=A0/* Direct from ULPD, no parent */<br>- =C2=A0 =C2=A0.rate	=3D 4800000=
0,<br>+ =C2=A0 =C2=A0.rate =3D 48000000,<br>=C2=A0 =C2=A0 =C2=A0/* OTG_SYSC=
ON_2.OTG_PADEN =3D=3D 0 (not 1510-compatible) */<br>- =C2=A0 =C2=A0.flags	=
=3D CLOCK_IN_OMAP16XX,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP16XX,<br>=
=C2=A0};<br>=C2=A0<br>=C2=A0static struct clk usb_w2fc_mclk =3D {<br>- =C2=
=A0 =C2=A0.name	=3D &quot;usb_w2fc_mclk&quot;,<br>- =C2=A0 =C2=A0.alias	=3D=
 &quot;usb_w2fc_ck&quot;,<br>- =C2=A0 =C2=A0.parent	=3D &amp;ck_48m,<br>- =
=C2=A0 =C2=A0.rate	=3D 48000000,<br>- =C2=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP=
310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX,<br>+ =C2=A0 =C2=A0.name =3D &q=
uot;usb_w2fc_mclk&quot;,<br>+ =C2=A0 =C2=A0.alias =3D &quot;usb_w2fc_ck&quo=
t;,<br>+ =C2=A0 =C2=A0.parent =3D &amp;ck_48m,<br>+ =C2=A0 =C2=A0.rate =3D =
48000000,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510=
 | CLOCK_IN_OMAP16XX,<br>=C2=A0};<br>=C2=A0<br>=C2=A0static struct clk mclk=
_1510 =3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;mclk&quot;,<br>+ =C2=A0 =C2=
=A0.name =3D &quot;mclk&quot;,<br>=C2=A0 =C2=A0 =C2=A0/* Direct from ULPD, =
no parent. May be enabled by ext hardware. */<br>- =C2=A0 =C2=A0.rate	=3D 1=
2000000,<br>- =C2=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP1510,<br>+ =C2=A0 =C2=A0=
.rate =3D 12000000,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP1510,<br>=C2=
=A0};<br>=C2=A0<br>=C2=A0static struct clk bclk_310 =3D {<br>- =C2=A0 =C2=
=A0.name	=3D &quot;bt_mclk_out&quot;,	/* Alias midi_mclk_out? */<br>- =C2=
=A0 =C2=A0.parent	=3D &amp;armper_ck,<br>- =C2=A0 =C2=A0.flags	=3D CLOCK_IN=
_OMAP310,<br>+ =C2=A0 =C2=A0.name =3D &quot;bt_mclk_out&quot;, /*g Alias mi=
di_mclk_out? */<br>+ =C2=A0 =C2=A0.parent =3D &amp;armper_ck,<br>+ =C2=A0 =
=C2=A0.flags =3D CLOCK_IN_OMAP310,<br>=C2=A0};<br>=C2=A0<br>=C2=A0static st=
ruct clk mclk_310 =3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;com_mclk_out&quot=
;,<br>- =C2=A0 =C2=A0.parent	=3D &amp;armper_ck,<br>- =C2=A0 =C2=A0.flags	=
=3D CLOCK_IN_OMAP310,<br>+ =C2=A0 =C2=A0.name =3D &quot;com_mclk_out&quot;,=
<br>+ =C2=A0 =C2=A0.parent =3D &amp;armper_ck,<br>+ =C2=A0 =C2=A0.flags =3D=
 CLOCK_IN_OMAP310,<br>=C2=A0};<br>=C2=A0<br>=C2=A0static struct clk mclk_16=
xx =3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;mclk&quot;,<br>+ =C2=A0 =C2=A0.n=
ame =3D &quot;mclk&quot;,<br>=C2=A0 =C2=A0 =C2=A0/* Direct from ULPD, no pa=
rent. May be enabled by ext hardware. */<br>- =C2=A0 =C2=A0.flags	=3D CLOCK=
_IN_OMAP16XX,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP16XX,<br>=C2=A0};<b=
r>=C2=A0<br>=C2=A0static struct clk bclk_1510 =3D {<br>- =C2=A0 =C2=A0.name=
	=3D &quot;bclk&quot;,<br>+ =C2=A0 =C2=A0.name =3D &quot;bclk&quot;,<br>=C2=
=A0 =C2=A0 =C2=A0/* Direct from ULPD, no parent. May be enabled by ext hard=
ware. */<br>- =C2=A0 =C2=A0.rate	=3D 12000000,<br>- =C2=A0 =C2=A0.flags	=3D=
 CLOCK_IN_OMAP1510,<br>+ =C2=A0 =C2=A0.rate =3D 12000000,<br>+ =C2=A0 =C2=
=A0.flags =3D CLOCK_IN_OMAP1510,<br>=C2=A0};<br>=C2=A0<br>=C2=A0static stru=
ct clk bclk_16xx =3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;bclk&quot;,<br>+ =
=C2=A0 =C2=A0.name =3D &quot;bclk&quot;,<br>=C2=A0 =C2=A0 =C2=A0/* Direct f=
rom ULPD, no parent. May be enabled by ext hardware. */<br>- =C2=A0 =C2=A0.=
flags	=3D CLOCK_IN_OMAP16XX,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP16XX=
,<br>=C2=A0};<br>=C2=A0<br>=C2=A0static struct clk mmc1_ck =3D {<br>- =C2=
=A0 =C2=A0.name	=3D &quot;mmc_ck&quot;,<br>- =C2=A0 =C2=A0.id		=3D 1,<br>+ =
=C2=A0 =C2=A0.name =3D &quot;mmc_ck&quot;,<br>+ =C2=A0 =C2=A0.id =C2=A0=3D =
1,<br>=C2=A0 =C2=A0 =C2=A0/* Functional clock is direct from ULPD, interfac=
e clock is ARMPER */<br>- =C2=A0 =C2=A0.parent	=3D &amp;armper_ck,	/* eithe=
r armper_ck or dpll4 */<br>- =C2=A0 =C2=A0.rate	=3D 48000000,<br>- =C2=A0 =
=C2=A0.flags	=3D CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310,<=
br>+ =C2=A0 =C2=A0.parent =3D &amp;armper_ck, /*g either armper_ck or dpll4=
 */<br>+ =C2=A0 =C2=A0.rate =3D 48000000,<br>+ =C2=A0 =C2=A0.flags =3D CLOC=
K_IN_OMAP1510 | CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP310,<br>=C2=A0};<br>=C2=A0=
<br>=C2=A0static struct clk mmc2_ck =3D {<br>- =C2=A0 =C2=A0.name	=3D &quot=
;mmc_ck&quot;,<br>- =C2=A0 =C2=A0.id		=3D 2,<br>+ =C2=A0 =C2=A0.name =3D &q=
uot;mmc_ck&quot;,<br>+ =C2=A0 =C2=A0.id =C2=A0=3D 2,<br>=C2=A0 =C2=A0 =C2=
=A0/* Functional clock is direct from ULPD, interface clock is ARMPER */<br=
>- =C2=A0 =C2=A0.parent	=3D &amp;armper_ck,<br>- =C2=A0 =C2=A0.rate	=3D 480=
00000,<br>- =C2=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP16XX,<br>+ =C2=A0 =C2=A0.p=
arent =3D &amp;armper_ck,<br>+ =C2=A0 =C2=A0.rate =3D 48000000,<br>+ =C2=A0=
 =C2=A0.flags =3D CLOCK_IN_OMAP16XX,<br>=C2=A0};<br>=C2=A0<br>=C2=A0static =
struct clk cam_mclk =3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;cam.mclk&quot;,=
<br>- =C2=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_=
IN_OMAP16XX,<br>- =C2=A0 =C2=A0.rate	=3D 12000000,<br>+ =C2=A0 =C2=A0.name =
=3D &quot;cam.mclk&quot;,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP310 | C=
LOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX,<br>+ =C2=A0 =C2=A0.rate =3D 12000000,=
<br>=C2=A0};<br>=C2=A0<br>=C2=A0static struct clk cam_exclk =3D {<br>- =C2=
=A0 =C2=A0.name	=3D &quot;cam.exclk&quot;,<br>- =C2=A0 =C2=A0.flags	=3D CLO=
CK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX,<br>+ =C2=A0 =C2=A0.n=
ame =3D &quot;cam.exclk&quot;,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP31=
0 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX,<br>=C2=A0 =C2=A0 =C2=A0/* Either=
 12M from cam.mclk or 48M from dpll4 */<br>- =C2=A0 =C2=A0.parent	=3D &amp;=
cam_mclk,<br>+ =C2=A0 =C2=A0.parent =3D &amp;cam_mclk,<br>=C2=A0};<br>=C2=
=A0<br>=C2=A0static struct clk cam_lclk =3D {<br>- =C2=A0 =C2=A0.name	=3D &=
quot;cam.lclk&quot;,<br>- =C2=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP310 | CLOCK_=
IN_OMAP1510 | CLOCK_IN_OMAP16XX,<br>+ =C2=A0 =C2=A0.name =3D &quot;cam.lclk=
&quot;,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 |=
 CLOCK_IN_OMAP16XX,<br>=C2=A0};<br>=C2=A0<br>=C2=A0static struct clk i2c_fc=
k =3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;i2c_fck&quot;,<br>- =C2=A0 =C2=A0=
.id		=3D 1,<br>- =C2=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP310 | CLOCK_IN_OMAP15=
10 | CLOCK_IN_OMAP16XX |<br>+ =C2=A0 =C2=A0.name =3D &quot;i2c_fck&quot;,<b=
r>+ =C2=A0 =C2=A0.id =C2=A0=3D 1,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMA=
P310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0ALWAYS_ENABLED,<br>- =C2=A0 =C2=A0.parent	=3D &amp;=
armxor_ck,<br>+ =C2=A0 =C2=A0.parent =3D &amp;armxor_ck,<br>=C2=A0};<br>=C2=
=A0<br>=C2=A0static struct clk i2c_ick =3D {<br>- =C2=A0 =C2=A0.name	=3D &q=
uot;i2c_ick&quot;,<br>- =C2=A0 =C2=A0.id		=3D 1,<br>- =C2=A0 =C2=A0.flags	=
=3D CLOCK_IN_OMAP16XX | ALWAYS_ENABLED,<br>- =C2=A0 =C2=A0.parent	=3D &amp;=
armper_ck,<br>+ =C2=A0 =C2=A0.name =3D &quot;i2c_ick&quot;,<br>+ =C2=A0 =C2=
=A0.id =C2=A0=3D 1,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP16XX | ALWAYS=
_ENABLED,<br>+ =C2=A0 =C2=A0.parent =3D &amp;armper_ck,<br>=C2=A0};<br>=C2=
=A0<br>=C2=A0static struct clk clk32k =3D {<br>- =C2=A0 =C2=A0.name	=3D &qu=
ot;clk32-kHz&quot;,<br>- =C2=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP310 | CLOCK_I=
N_OMAP1510 | CLOCK_IN_OMAP16XX |<br>+ =C2=A0 =C2=A0.name =3D &quot;clk32-kH=
z&quot;,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 =
| CLOCK_IN_OMAP16XX |<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CL=
OCK_IN_OMAP242X | CLOCK_IN_OMAP243X | ALWAYS_ENABLED,<br>- =C2=A0 =C2=A0.pa=
rent	=3D &amp;xtal_osc32k,<br>+ =C2=A0 =C2=A0.parent =3D &amp;xtal_osc32k,<=
br>=C2=A0};<br>=C2=A0<br>=C2=A0static struct clk ref_clk =3D {<br>- =C2=A0 =
=C2=A0.name	=3D &quot;ref_clk&quot;,<br>- =C2=A0 =C2=A0.flags	=3D CLOCK_IN_=
OMAP242X | CLOCK_IN_OMAP243X | ALWAYS_ENABLED,<br>- =C2=A0 =C2=A0.rate	=3D =
12000000,	/* 12 MHz or 13 MHz or 19.2 MHz */<br>- =C2=A0 =C2=A0/*.parent	=
=3D sys.xtalin */<br>+ =C2=A0 =C2=A0.name =3D &quot;ref_clk&quot;,<br>+ =C2=
=A0 =C2=A0.flags =3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | ALWAYS_ENABLED=
,<br>+ =C2=A0 =C2=A0.rate =3D 12000000, /*g 12 MHz or 13 MHz or 19.2 MHz */=
<br>+ =C2=A0 =C2=A0/*.parent =3D sys.xtalin */<br>=C2=A0};<br>=C2=A0<br>=C2=
=A0static struct clk apll_96m =3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;apll_=
96m&quot;,<br>- =C2=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP24=
3X | ALWAYS_ENABLED,<br>- =C2=A0 =C2=A0.rate	=3D 96000000,<br>- =C2=A0 =C2=
=A0/*.parent	=3D ref_clk */<br>+ =C2=A0 =C2=A0.name =3D &quot;apll_96m&quot=
;,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | ALW=
AYS_ENABLED,<br>+ =C2=A0 =C2=A0.rate =3D 96000000,<br>+ =C2=A0 =C2=A0/*.par=
ent =3D ref_clk */<br>=C2=A0};<br>=C2=A0<br>=C2=A0static struct clk apll_54=
m =3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;apll_54m&quot;,<br>- =C2=A0 =C2=
=A0.flags	=3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | ALWAYS_ENABLED,<br>- =
=C2=A0 =C2=A0.rate	=3D 54000000,<br>- =C2=A0 =C2=A0/*.parent	=3D ref_clk */=
<br>+ =C2=A0 =C2=A0.name =3D &quot;apll_54m&quot;,<br>+ =C2=A0 =C2=A0.flags=
 =3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | ALWAYS_ENABLED,<br>+ =C2=A0 =
=C2=A0.rate =3D 54000000,<br>+ =C2=A0 =C2=A0/*.parent =3D ref_clk */<br>=C2=
=A0};<br>=C2=A0<br>=C2=A0static struct clk sys_clk =3D {<br>- =C2=A0 =C2=A0=
.name	=3D &quot;sys_clk&quot;,<br>- =C2=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP24=
2X | CLOCK_IN_OMAP243X | ALWAYS_ENABLED,<br>- =C2=A0 =C2=A0.rate	=3D 32768,=
<br>- =C2=A0 =C2=A0/*.parent	=3D sys.xtalin */<br>+ =C2=A0 =C2=A0.name =3D =
&quot;sys_clk&quot;,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP242X | CLOCK=
_IN_OMAP243X | ALWAYS_ENABLED,<br>+ =C2=A0 =C2=A0.rate =3D 32768,<br>+ =C2=
=A0 =C2=A0/*.parent =3D sys.xtalin */<br>=C2=A0};<br>=C2=A0<br>=C2=A0static=
 struct clk sleep_clk =3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;sleep_clk&quo=
t;,<br>- =C2=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | AL=
WAYS_ENABLED,<br>- =C2=A0 =C2=A0.rate	=3D 32768,<br>- =C2=A0 =C2=A0/*.paren=
t	=3D sys.xtalin */<br>+ =C2=A0 =C2=A0.name =3D &quot;sleep_clk&quot;,<br>+=
 =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | ALWAYS_ENA=
BLED,<br>+ =C2=A0 =C2=A0.rate =3D 32768,<br>+ =C2=A0 =C2=A0/*.parent =3D sy=
s.xtalin */<br>=C2=A0};<br>=C2=A0<br>=C2=A0static struct clk dpll_ck =3D {<=
br>- =C2=A0 =C2=A0.name	=3D &quot;dpll&quot;,<br>- =C2=A0 =C2=A0.flags	=3D =
CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | ALWAYS_ENABLED,<br>- =C2=A0 =C2=A0.=
parent	=3D &amp;ref_clk,<br>+ =C2=A0 =C2=A0.name =3D &quot;dpll&quot;,<br>+=
 =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | ALWAYS_ENA=
BLED,<br>+ =C2=A0 =C2=A0.parent =3D &amp;ref_clk,<br>=C2=A0};<br>=C2=A0<br>=
=C2=A0static struct clk dpll_x2_ck =3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;=
dpll_x2&quot;,<br>- =C2=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP242X | CLOCK_IN_OM=
AP243X | ALWAYS_ENABLED,<br>- =C2=A0 =C2=A0.parent	=3D &amp;ref_clk,<br>+ =
=C2=A0 =C2=A0.name =3D &quot;dpll_x2&quot;,<br>+ =C2=A0 =C2=A0.flags =3D CL=
OCK_IN_OMAP242X | CLOCK_IN_OMAP243X | ALWAYS_ENABLED,<br>+ =C2=A0 =C2=A0.pa=
rent =3D &amp;ref_clk,<br>=C2=A0};<br>=C2=A0<br>=C2=A0static struct clk wdt=
1_sys_clk =3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;wdt1_sys_clk&quot;,<br>- =
=C2=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | ALWAYS_ENAB=
LED,<br>- =C2=A0 =C2=A0.rate	=3D 32768,<br>- =C2=A0 =C2=A0/*.parent	=3D sys=
.xtalin */<br>+ =C2=A0 =C2=A0.name =3D &quot;wdt1_sys_clk&quot;,<br>+ =C2=
=A0 =C2=A0.flags =3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | ALWAYS_ENABLED=
,<br>+ =C2=A0 =C2=A0.rate =3D 32768,<br>+ =C2=A0 =C2=A0/*.parent =3D sys.xt=
alin */<br>=C2=A0};<br>=C2=A0<br>=C2=A0static struct clk func_96m_clk =3D {=
<br>- =C2=A0 =C2=A0.name	=3D &quot;func_96m_clk&quot;,<br>- =C2=A0 =C2=A0.f=
lags	=3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>- =C2=A0 =C2=A0.divisor	=
=3D 1,<br>- =C2=A0 =C2=A0.parent	=3D &amp;apll_96m,<br>+ =C2=A0 =C2=A0.name=
 =3D &quot;func_96m_clk&quot;,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP24=
2X | CLOCK_IN_OMAP243X,<br>+ =C2=A0 =C2=A0.divisor =3D 1,<br>+ =C2=A0 =C2=
=A0.parent =3D &amp;apll_96m,<br>=C2=A0};<br>=C2=A0<br>=C2=A0static struct =
clk func_48m_clk =3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;func_48m_clk&quot;=
,<br>- =C2=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>- =
=C2=A0 =C2=A0.divisor	=3D 2,<br>- =C2=A0 =C2=A0.parent	=3D &amp;apll_96m,<b=
r>+ =C2=A0 =C2=A0.name =3D &quot;func_48m_clk&quot;,<br>+ =C2=A0 =C2=A0.fla=
gs =3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>+ =C2=A0 =C2=A0.divisor =
=3D 2,<br>+ =C2=A0 =C2=A0.parent =3D &amp;apll_96m,<br>=C2=A0};<br>=C2=A0<b=
r>=C2=A0static struct clk func_12m_clk =3D {<br>- =C2=A0 =C2=A0.name	=3D &q=
uot;func_12m_clk&quot;,<br>- =C2=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP242X | CL=
OCK_IN_OMAP243X,<br>- =C2=A0 =C2=A0.divisor	=3D 8,<br>- =C2=A0 =C2=A0.paren=
t	=3D &amp;apll_96m,<br>+ =C2=A0 =C2=A0.name =3D &quot;func_12m_clk&quot;,<=
br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>+ =
=C2=A0 =C2=A0.divisor =3D 8,<br>+ =C2=A0 =C2=A0.parent =3D &amp;apll_96m,<b=
r>=C2=A0};<br>=C2=A0<br>=C2=A0static struct clk func_54m_clk =3D {<br>- =C2=
=A0 =C2=A0.name	=3D &quot;func_54m_clk&quot;,<br>- =C2=A0 =C2=A0.flags	=3D =
CLOCK_IN_OMAP242X,<br>- =C2=A0 =C2=A0.divisor	=3D 1,<br>- =C2=A0 =C2=A0.par=
ent	=3D &amp;apll_54m,<br>+ =C2=A0 =C2=A0.name =3D &quot;func_54m_clk&quot;=
,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP242X,<br>+ =C2=A0 =C2=A0.diviso=
r =3D 1,<br>+ =C2=A0 =C2=A0.parent =3D &amp;apll_54m,<br>=C2=A0};<br>=C2=A0=
<br>=C2=A0static struct clk sys_clkout =3D {<br>- =C2=A0 =C2=A0.name	=3D &q=
uot;clkout&quot;,<br>- =C2=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP242X | CLOCK_IN=
_OMAP243X,<br>- =C2=A0 =C2=A0.parent	=3D &amp;sys_clk,<br>+ =C2=A0 =C2=A0.n=
ame =3D &quot;clkout&quot;,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP242X =
| CLOCK_IN_OMAP243X,<br>+ =C2=A0 =C2=A0.parent =3D &amp;sys_clk,<br>=C2=A0}=
;<br>=C2=A0<br>=C2=A0static struct clk sys_clkout2 =3D {<br>- =C2=A0 =C2=A0=
.name	=3D &quot;clkout2&quot;,<br>- =C2=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP24=
2X | CLOCK_IN_OMAP243X,<br>- =C2=A0 =C2=A0.parent	=3D &amp;sys_clk,<br>+ =
=C2=A0 =C2=A0.name =3D &quot;clkout2&quot;,<br>+ =C2=A0 =C2=A0.flags =3D CL=
OCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>+ =C2=A0 =C2=A0.parent =3D &amp;sys=
_clk,<br>=C2=A0};<br>=C2=A0<br>=C2=A0static struct clk core_clk =3D {<br>- =
=C2=A0 =C2=A0.name	=3D &quot;core_clk&quot;,<br>- =C2=A0 =C2=A0.flags	=3D C=
LOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>- =C2=A0 =C2=A0.parent	=3D &amp;dp=
ll_x2_ck,	/* Switchable between dpll_ck and clk32k */<br>+ =C2=A0 =C2=A0.na=
me =3D &quot;core_clk&quot;,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP242X=
 | CLOCK_IN_OMAP243X,<br>+ =C2=A0 =C2=A0.parent =3D &amp;dpll_x2_ck, /*g Sw=
itchable between dpll_ck and clk32k */<br>=C2=A0};<br>=C2=A0<br>=C2=A0stati=
c struct clk l3_clk =3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;l3_clk&quot;,<b=
r>- =C2=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>- =C2=
=A0 =C2=A0.parent	=3D &amp;core_clk,<br>+ =C2=A0 =C2=A0.name =3D &quot;l3_c=
lk&quot;,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243=
X,<br>+ =C2=A0 =C2=A0.parent =3D &amp;core_clk,<br>=C2=A0};<br>=C2=A0<br>=
=C2=A0static struct clk core_l4_iclk =3D {<br>- =C2=A0 =C2=A0.name	=3D &quo=
t;core_l4_iclk&quot;,<br>- =C2=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP242X | CLOC=
K_IN_OMAP243X,<br>- =C2=A0 =C2=A0.parent	=3D &amp;l3_clk,<br>+ =C2=A0 =C2=
=A0.name =3D &quot;core_l4_iclk&quot;,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_I=
N_OMAP242X | CLOCK_IN_OMAP243X,<br>+ =C2=A0 =C2=A0.parent =3D &amp;l3_clk,<=
br>=C2=A0};<br>=C2=A0<br>=C2=A0static struct clk wu_l4_iclk =3D {<br>- =C2=
=A0 =C2=A0.name	=3D &quot;wu_l4_iclk&quot;,<br>- =C2=A0 =C2=A0.flags	=3D CL=
OCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>- =C2=A0 =C2=A0.parent	=3D &amp;l3_=
clk,<br>+ =C2=A0 =C2=A0.name =3D &quot;wu_l4_iclk&quot;,<br>+ =C2=A0 =C2=A0=
.flags =3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>+ =C2=A0 =C2=A0.parent=
 =3D &amp;l3_clk,<br>=C2=A0};<br>=C2=A0<br>=C2=A0static struct clk core_l3_=
iclk =3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;core_l3_iclk&quot;,<br>- =C2=
=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>- =C2=A0 =C2=
=A0.parent	=3D &amp;core_clk,<br>+ =C2=A0 =C2=A0.name =3D &quot;core_l3_icl=
k&quot;,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X=
,<br>+ =C2=A0 =C2=A0.parent =3D &amp;core_clk,<br>=C2=A0};<br>=C2=A0<br>=C2=
=A0static struct clk core_l4_usb_clk =3D {<br>- =C2=A0 =C2=A0.name	=3D &quo=
t;core_l4_usb_clk&quot;,<br>- =C2=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP242X | C=
LOCK_IN_OMAP243X,<br>- =C2=A0 =C2=A0.parent	=3D &amp;l3_clk,<br>+ =C2=A0 =
=C2=A0.name =3D &quot;core_l4_usb_clk&quot;,<br>+ =C2=A0 =C2=A0.flags =3D C=
LOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>+ =C2=A0 =C2=A0.parent =3D &amp;l3=
_clk,<br>=C2=A0};<br>=C2=A0<br>=C2=A0static struct clk wu_gpt1_clk =3D {<br=
>- =C2=A0 =C2=A0.name	=3D &quot;wu_gpt1_clk&quot;,<br>- =C2=A0 =C2=A0.flags=
	=3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>- =C2=A0 =C2=A0.parent	=3D &=
amp;sys_clk,<br>+ =C2=A0 =C2=A0.name =3D &quot;wu_gpt1_clk&quot;,<br>+ =C2=
=A0 =C2=A0.flags =3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>+ =C2=A0 =C2=
=A0.parent =3D &amp;sys_clk,<br>=C2=A0};<br>=C2=A0<br>=C2=A0static struct c=
lk wu_32k_clk =3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;wu_32k_clk&quot;,<br>=
- =C2=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>- =C2=
=A0 =C2=A0.parent	=3D &amp;sys_clk,<br>+ =C2=A0 =C2=A0.name =3D &quot;wu_32=
k_clk&quot;,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP=
243X,<br>+ =C2=A0 =C2=A0.parent =3D &amp;sys_clk,<br>=C2=A0};<br>=C2=A0<br>=
=C2=A0static struct clk uart1_fclk =3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;=
uart1_fclk&quot;,<br>- =C2=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP242X | CLOCK_IN=
_OMAP243X,<br>- =C2=A0 =C2=A0.parent	=3D &amp;func_48m_clk,<br>+ =C2=A0 =C2=
=A0.name =3D &quot;uart1_fclk&quot;,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_=
OMAP242X | CLOCK_IN_OMAP243X,<br>+ =C2=A0 =C2=A0.parent =3D &amp;func_48m_c=
lk,<br>=C2=A0};<br>=C2=A0<br>=C2=A0static struct clk uart1_iclk =3D {<br>- =
=C2=A0 =C2=A0.name	=3D &quot;uart1_iclk&quot;,<br>- =C2=A0 =C2=A0.flags	=3D=
 CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>- =C2=A0 =C2=A0.parent	=3D &amp;=
core_l4_iclk,<br>+ =C2=A0 =C2=A0.name =3D &quot;uart1_iclk&quot;,<br>+ =C2=
=A0 =C2=A0.flags =3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>+ =C2=A0 =C2=
=A0.parent =3D &amp;core_l4_iclk,<br>=C2=A0};<br>=C2=A0<br>=C2=A0static str=
uct clk uart2_fclk =3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;uart2_fclk&quot;=
,<br>- =C2=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>- =
=C2=A0 =C2=A0.parent	=3D &amp;func_48m_clk,<br>+ =C2=A0 =C2=A0.name =3D &qu=
ot;uart2_fclk&quot;,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP242X | CLOCK=
_IN_OMAP243X,<br>+ =C2=A0 =C2=A0.parent =3D &amp;func_48m_clk,<br>=C2=A0};<=
br>=C2=A0<br>=C2=A0static struct clk uart2_iclk =3D {<br>- =C2=A0 =C2=A0.na=
me	=3D &quot;uart2_iclk&quot;,<br>- =C2=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP24=
2X | CLOCK_IN_OMAP243X,<br>- =C2=A0 =C2=A0.parent	=3D &amp;core_l4_iclk,<br=
>+ =C2=A0 =C2=A0.name =3D &quot;uart2_iclk&quot;,<br>+ =C2=A0 =C2=A0.flags =
=3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>+ =C2=A0 =C2=A0.parent =3D &a=
mp;core_l4_iclk,<br>=C2=A0};<br>=C2=A0<br>=C2=A0static struct clk uart3_fcl=
k =3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;uart3_fclk&quot;,<br>- =C2=A0 =C2=
=A0.flags	=3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>- =C2=A0 =C2=A0.par=
ent	=3D &amp;func_48m_clk,<br>+ =C2=A0 =C2=A0.name =3D &quot;uart3_fclk&quo=
t;,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>=
+ =C2=A0 =C2=A0.parent =3D &amp;func_48m_clk,<br>=C2=A0};<br>=C2=A0<br>=C2=
=A0static struct clk uart3_iclk =3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;uar=
t3_iclk&quot;,<br>- =C2=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP242X | CLOCK_IN_OM=
AP243X,<br>- =C2=A0 =C2=A0.parent	=3D &amp;core_l4_iclk,<br>+ =C2=A0 =C2=A0=
.name =3D &quot;uart3_iclk&quot;,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMA=
P242X | CLOCK_IN_OMAP243X,<br>+ =C2=A0 =C2=A0.parent =3D &amp;core_l4_iclk,=
<br>=C2=A0};<br>=C2=A0<br>=C2=A0static struct clk mpu_fclk =3D {<br>- =C2=
=A0 =C2=A0.name	=3D &quot;mpu_fclk&quot;,<br>- =C2=A0 =C2=A0.flags	=3D CLOC=
K_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>- =C2=A0 =C2=A0.parent	=3D &amp;core_=
clk,<br>+ =C2=A0 =C2=A0.name =3D &quot;mpu_fclk&quot;,<br>+ =C2=A0 =C2=A0.f=
lags =3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>+ =C2=A0 =C2=A0.parent =
=3D &amp;core_clk,<br>=C2=A0};<br>=C2=A0<br>=C2=A0static struct clk mpu_icl=
k =3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;mpu_iclk&quot;,<br>- =C2=A0 =C2=
=A0.flags	=3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>- =C2=A0 =C2=A0.par=
ent	=3D &amp;core_clk,<br>+ =C2=A0 =C2=A0.name =3D &quot;mpu_iclk&quot;,<br=
>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>+ =C2=
=A0 =C2=A0.parent =3D &amp;core_clk,<br>=C2=A0};<br>=C2=A0<br>=C2=A0static =
struct clk int_m_fclk =3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;int_m_fclk&qu=
ot;,<br>- =C2=A0 =C2=A0.alias	=3D &quot;mpu_intc_fclk&quot;,<br>- =C2=A0 =
=C2=A0.flags	=3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>- =C2=A0 =C2=A0.=
parent	=3D &amp;core_clk,<br>+ =C2=A0 =C2=A0.name =3D &quot;int_m_fclk&quot=
;,<br>+ =C2=A0 =C2=A0.alias =3D &quot;mpu_intc_fclk&quot;,<br>+ =C2=A0 =C2=
=A0.flags =3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>+ =C2=A0 =C2=A0.par=
ent =3D &amp;core_clk,<br>=C2=A0};<br>=C2=A0<br>=C2=A0static struct clk int=
_m_iclk =3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;int_m_iclk&quot;,<br>- =C2=
=A0 =C2=A0.alias	=3D &quot;mpu_intc_iclk&quot;,<br>- =C2=A0 =C2=A0.flags	=
=3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>- =C2=A0 =C2=A0.parent	=3D &a=
mp;core_clk,<br>+ =C2=A0 =C2=A0.name =3D &quot;int_m_iclk&quot;,<br>+ =C2=
=A0 =C2=A0.alias =3D &quot;mpu_intc_iclk&quot;,<br>+ =C2=A0 =C2=A0.flags =
=3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>+ =C2=A0 =C2=A0.parent =3D &a=
mp;core_clk,<br>=C2=A0};<br>=C2=A0<br>=C2=A0static struct clk core_gpt2_clk=
 =3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;core_gpt2_clk&quot;,<br>- =C2=A0 =
=C2=A0.flags	=3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>- =C2=A0 =C2=A0.=
parent	=3D &amp;sys_clk,<br>+ =C2=A0 =C2=A0.name =3D &quot;core_gpt2_clk&qu=
ot;,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br=
>+ =C2=A0 =C2=A0.parent =3D &amp;sys_clk,<br>=C2=A0};<br>=C2=A0<br>=C2=A0st=
atic struct clk core_gpt3_clk =3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;core_=
gpt3_clk&quot;,<br>- =C2=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP242X | CLOCK_IN_O=
MAP243X,<br>- =C2=A0 =C2=A0.parent	=3D &amp;sys_clk,<br>+ =C2=A0 =C2=A0.nam=
e =3D &quot;core_gpt3_clk&quot;,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP=
242X | CLOCK_IN_OMAP243X,<br>+ =C2=A0 =C2=A0.parent =3D &amp;sys_clk,<br>=
=C2=A0};<br>=C2=A0<br>=C2=A0static struct clk core_gpt4_clk =3D {<br>- =C2=
=A0 =C2=A0.name	=3D &quot;core_gpt4_clk&quot;,<br>- =C2=A0 =C2=A0.flags	=3D=
 CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>- =C2=A0 =C2=A0.parent	=3D &amp;=
sys_clk,<br>+ =C2=A0 =C2=A0.name =3D &quot;core_gpt4_clk&quot;,<br>+ =C2=A0=
 =C2=A0.flags =3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>+ =C2=A0 =C2=A0=
.parent =3D &amp;sys_clk,<br>=C2=A0};<br>=C2=A0<br>=C2=A0static struct clk =
core_gpt5_clk =3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;core_gpt5_clk&quot;,<=
br>- =C2=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>- =
=C2=A0 =C2=A0.parent	=3D &amp;sys_clk,<br>+ =C2=A0 =C2=A0.name =3D &quot;co=
re_gpt5_clk&quot;,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP242X | CLOCK_I=
N_OMAP243X,<br>+ =C2=A0 =C2=A0.parent =3D &amp;sys_clk,<br>=C2=A0};<br>=C2=
=A0<br>=C2=A0static struct clk core_gpt6_clk =3D {<br>- =C2=A0 =C2=A0.name	=
=3D &quot;core_gpt6_clk&quot;,<br>- =C2=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP24=
2X | CLOCK_IN_OMAP243X,<br>- =C2=A0 =C2=A0.parent	=3D &amp;sys_clk,<br>+ =
=C2=A0 =C2=A0.name =3D &quot;core_gpt6_clk&quot;,<br>+ =C2=A0 =C2=A0.flags =
=3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>+ =C2=A0 =C2=A0.parent =3D &a=
mp;sys_clk,<br>=C2=A0};<br>=C2=A0<br>=C2=A0static struct clk core_gpt7_clk =
=3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;core_gpt7_clk&quot;,<br>- =C2=A0 =
=C2=A0.flags	=3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>- =C2=A0 =C2=A0.=
parent	=3D &amp;sys_clk,<br>+ =C2=A0 =C2=A0.name =3D &quot;core_gpt7_clk&qu=
ot;,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br=
>+ =C2=A0 =C2=A0.parent =3D &amp;sys_clk,<br>=C2=A0};<br>=C2=A0<br>=C2=A0st=
atic struct clk core_gpt8_clk =3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;core_=
gpt8_clk&quot;,<br>- =C2=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP242X | CLOCK_IN_O=
MAP243X,<br>- =C2=A0 =C2=A0.parent	=3D &amp;sys_clk,<br>+ =C2=A0 =C2=A0.nam=
e =3D &quot;core_gpt8_clk&quot;,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP=
242X | CLOCK_IN_OMAP243X,<br>+ =C2=A0 =C2=A0.parent =3D &amp;sys_clk,<br>=
=C2=A0};<br>=C2=A0<br>=C2=A0static struct clk core_gpt9_clk =3D {<br>- =C2=
=A0 =C2=A0.name	=3D &quot;core_gpt9_clk&quot;,<br>- =C2=A0 =C2=A0.flags	=3D=
 CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>- =C2=A0 =C2=A0.parent	=3D &amp;=
sys_clk,<br>+ =C2=A0 =C2=A0.name =3D &quot;core_gpt9_clk&quot;,<br>+ =C2=A0=
 =C2=A0.flags =3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>+ =C2=A0 =C2=A0=
.parent =3D &amp;sys_clk,<br>=C2=A0};<br>=C2=A0<br>=C2=A0static struct clk =
core_gpt10_clk =3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;core_gpt10_clk&quot;=
,<br>- =C2=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>- =
=C2=A0 =C2=A0.parent	=3D &amp;sys_clk,<br>+ =C2=A0 =C2=A0.name =3D &quot;co=
re_gpt10_clk&quot;,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP242X | CLOCK_=
IN_OMAP243X,<br>+ =C2=A0 =C2=A0.parent =3D &amp;sys_clk,<br>=C2=A0};<br>=C2=
=A0<br>=C2=A0static struct clk core_gpt11_clk =3D {<br>- =C2=A0 =C2=A0.name=
	=3D &quot;core_gpt11_clk&quot;,<br>- =C2=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP=
242X | CLOCK_IN_OMAP243X,<br>- =C2=A0 =C2=A0.parent	=3D &amp;sys_clk,<br>+ =
=C2=A0 =C2=A0.name =3D &quot;core_gpt11_clk&quot;,<br>+ =C2=A0 =C2=A0.flags=
 =3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>+ =C2=A0 =C2=A0.parent =3D &=
amp;sys_clk,<br>=C2=A0};<br>=C2=A0<br>=C2=A0static struct clk core_gpt12_cl=
k =3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;core_gpt12_clk&quot;,<br>- =C2=A0=
 =C2=A0.flags	=3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>- =C2=A0 =C2=A0=
.parent	=3D &amp;sys_clk,<br>+ =C2=A0 =C2=A0.name =3D &quot;core_gpt12_clk&=
quot;,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<=
br>+ =C2=A0 =C2=A0.parent =3D &amp;sys_clk,<br>=C2=A0};<br>=C2=A0<br>=C2=A0=
static struct clk mcbsp1_clk =3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;mcbsp1=
_cg&quot;,<br>- =C2=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP24=
3X,<br>- =C2=A0 =C2=A0.divisor	=3D 2,<br>- =C2=A0 =C2=A0.parent	=3D &amp;fu=
nc_96m_clk,<br>+ =C2=A0 =C2=A0.name =3D &quot;mcbsp1_cg&quot;,<br>+ =C2=A0 =
=C2=A0.flags =3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>+ =C2=A0 =C2=A0.=
divisor =3D 2,<br>+ =C2=A0 =C2=A0.parent =3D &amp;func_96m_clk,<br>=C2=A0};=
<br>=C2=A0<br>=C2=A0static struct clk mcbsp2_clk =3D {<br>- =C2=A0 =C2=A0.n=
ame	=3D &quot;mcbsp2_cg&quot;,<br>- =C2=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP24=
2X | CLOCK_IN_OMAP243X,<br>- =C2=A0 =C2=A0.divisor	=3D 2,<br>- =C2=A0 =C2=
=A0.parent	=3D &amp;func_96m_clk,<br>+ =C2=A0 =C2=A0.name =3D &quot;mcbsp2_=
cg&quot;,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243=
X,<br>+ =C2=A0 =C2=A0.divisor =3D 2,<br>+ =C2=A0 =C2=A0.parent =3D &amp;fun=
c_96m_clk,<br>=C2=A0};<br>=C2=A0<br>=C2=A0static struct clk emul_clk =3D {<=
br>- =C2=A0 =C2=A0.name	=3D &quot;emul_ck&quot;,<br>- =C2=A0 =C2=A0.flags	=
=3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>- =C2=A0 =C2=A0.parent	=3D &a=
mp;func_54m_clk,<br>+ =C2=A0 =C2=A0.name =3D &quot;emul_ck&quot;,<br>+ =C2=
=A0 =C2=A0.flags =3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>+ =C2=A0 =C2=
=A0.parent =3D &amp;func_54m_clk,<br>=C2=A0};<br>=C2=A0<br>=C2=A0static str=
uct clk sdma_fclk =3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;sdma_fclk&quot;,<=
br>- =C2=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>- =
=C2=A0 =C2=A0.parent	=3D &amp;l3_clk,<br>+ =C2=A0 =C2=A0.name =3D &quot;sdm=
a_fclk&quot;,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP242X | CLOCK_IN_OMA=
P243X,<br>+ =C2=A0 =C2=A0.parent =3D &amp;l3_clk,<br>=C2=A0};<br>=C2=A0<br>=
=C2=A0static struct clk sdma_iclk =3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;s=
dma_iclk&quot;,<br>- =C2=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP242X | CLOCK_IN_O=
MAP243X,<br>- =C2=A0 =C2=A0.parent	=3D &amp;core_l3_iclk, /* core_l4_iclk f=
or the configuration port */<br>+ =C2=A0 =C2=A0.name =3D &quot;sdma_iclk&qu=
ot;,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br=
>+ =C2=A0 =C2=A0.parent =3D &amp;core_l3_iclk, /* core_l4_iclk for the conf=
iguration port */<br>=C2=A0};<br>=C2=A0<br>=C2=A0static struct clk i2c1_fcl=
k =3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;i2c1.fclk&quot;,<br>- =C2=A0 =C2=
=A0.flags	=3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>- =C2=A0 =C2=A0.par=
ent	=3D &amp;func_12m_clk,<br>- =C2=A0 =C2=A0.divisor	=3D 1,<br>+ =C2=A0 =
=C2=A0.name =3D &quot;i2c1.fclk&quot;,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_I=
N_OMAP242X | CLOCK_IN_OMAP243X,<br>+ =C2=A0 =C2=A0.parent =3D &amp;func_12m=
_clk,<br>+ =C2=A0 =C2=A0.divisor =3D 1,<br>=C2=A0};<br>=C2=A0<br>=C2=A0stat=
ic struct clk i2c1_iclk =3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;i2c1.iclk&q=
uot;,<br>- =C2=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<b=
r>- =C2=A0 =C2=A0.parent	=3D &amp;core_l4_iclk,<br>+ =C2=A0 =C2=A0.name =3D=
 &quot;i2c1.iclk&quot;,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP242X | CL=
OCK_IN_OMAP243X,<br>+ =C2=A0 =C2=A0.parent =3D &amp;core_l4_iclk,<br>=C2=A0=
};<br>=C2=A0<br>=C2=A0static struct clk i2c2_fclk =3D {<br>- =C2=A0 =C2=A0.=
name	=3D &quot;i2c2.fclk&quot;,<br>- =C2=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP2=
42X | CLOCK_IN_OMAP243X,<br>- =C2=A0 =C2=A0.parent	=3D &amp;func_12m_clk,<b=
r>- =C2=A0 =C2=A0.divisor	=3D 1,<br>+ =C2=A0 =C2=A0.name =3D &quot;i2c2.fcl=
k&quot;,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X=
,<br>+ =C2=A0 =C2=A0.parent =3D &amp;func_12m_clk,<br>+ =C2=A0 =C2=A0.divis=
or =3D 1,<br>=C2=A0};<br>=C2=A0<br>=C2=A0static struct clk i2c2_iclk =3D {<=
br>- =C2=A0 =C2=A0.name	=3D &quot;i2c2.iclk&quot;,<br>- =C2=A0 =C2=A0.flags=
	=3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>- =C2=A0 =C2=A0.parent	=3D &=
amp;core_l4_iclk,<br>+ =C2=A0 =C2=A0.name =3D &quot;i2c2.iclk&quot;,<br>+ =
=C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>+ =C2=A0 =
=C2=A0.parent =3D &amp;core_l4_iclk,<br>=C2=A0};<br>=C2=A0<br>=C2=A0static =
struct clk gpio_dbclk[5] =3D {<br>=C2=A0 =C2=A0 =C2=A0{<br>- =C2=A0 =C2=A0 =
=C2=A0 =C2=A0.name	=3D &quot;gpio1_dbclk&quot;,<br>- =C2=A0 =C2=A0 =C2=A0 =
=C2=A0.flags	=3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>- =C2=A0 =C2=A0 =
=C2=A0 =C2=A0.parent	=3D &amp;wu_32k_clk,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.=
name =3D &quot;gpio1_dbclk&quot;,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.flags =
=3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0=
.parent =3D &amp;wu_32k_clk,<br>=C2=A0 =C2=A0 =C2=A0}, {<br>- =C2=A0 =C2=A0=
 =C2=A0 =C2=A0.name	=3D &quot;gpio2_dbclk&quot;,<br>- =C2=A0 =C2=A0 =C2=A0 =
=C2=A0.flags	=3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>- =C2=A0 =C2=A0 =
=C2=A0 =C2=A0.parent	=3D &amp;wu_32k_clk,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.=
name =3D &quot;gpio2_dbclk&quot;,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.flags =
=3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0=
.parent =3D &amp;wu_32k_clk,<br>=C2=A0 =C2=A0 =C2=A0}, {<br>- =C2=A0 =C2=A0=
 =C2=A0 =C2=A0.name	=3D &quot;gpio3_dbclk&quot;,<br>- =C2=A0 =C2=A0 =C2=A0 =
=C2=A0.flags	=3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>- =C2=A0 =C2=A0 =
=C2=A0 =C2=A0.parent	=3D &amp;wu_32k_clk,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.=
name =3D &quot;gpio3_dbclk&quot;,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.flags =
=3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0=
.parent =3D &amp;wu_32k_clk,<br>=C2=A0 =C2=A0 =C2=A0}, {<br>- =C2=A0 =C2=A0=
 =C2=A0 =C2=A0.name	=3D &quot;gpio4_dbclk&quot;,<br>- =C2=A0 =C2=A0 =C2=A0 =
=C2=A0.flags	=3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>- =C2=A0 =C2=A0 =
=C2=A0 =C2=A0.parent	=3D &amp;wu_32k_clk,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.=
name =3D &quot;gpio4_dbclk&quot;,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.flags =
=3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0=
.parent =3D &amp;wu_32k_clk,<br>=C2=A0 =C2=A0 =C2=A0}, {<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0.name =C2=A0 =3D &quot;gpio5_dbclk&quot;,<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0.flags =C2=A0=3D CLOCK_IN_OMAP243X,<br>@@ -864,90 +=
864,90 @@ static struct clk gpio_dbclk[5] =3D {<br>=C2=A0};<br>=C2=A0<br>=
=C2=A0static struct clk gpio_iclk =3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;g=
pio_iclk&quot;,<br>- =C2=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP242X | CLOCK_IN_O=
MAP243X,<br>- =C2=A0 =C2=A0.parent	=3D &amp;wu_l4_iclk,<br>+ =C2=A0 =C2=A0.=
name =3D &quot;gpio_iclk&quot;,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP2=
42X | CLOCK_IN_OMAP243X,<br>+ =C2=A0 =C2=A0.parent =3D &amp;wu_l4_iclk,<br>=
=C2=A0};<br>=C2=A0<br>=C2=A0static struct clk mmc_fck =3D {<br>- =C2=A0 =C2=
=A0.name	=3D &quot;mmc_fclk&quot;,<br>- =C2=A0 =C2=A0.flags	=3D CLOCK_IN_OM=
AP242X,<br>- =C2=A0 =C2=A0.parent	=3D &amp;func_96m_clk,<br>+ =C2=A0 =C2=A0=
.name =3D &quot;mmc_fclk&quot;,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP2=
42X,<br>+ =C2=A0 =C2=A0.parent =3D &amp;func_96m_clk,<br>=C2=A0};<br>=C2=A0=
<br>=C2=A0static struct clk mmc_ick =3D {<br>- =C2=A0 =C2=A0.name	=3D &quot=
;mmc_iclk&quot;,<br>- =C2=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP242X,<br>- =C2=
=A0 =C2=A0.parent	=3D &amp;core_l4_iclk,<br>+ =C2=A0 =C2=A0.name =3D &quot;=
mmc_iclk&quot;,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP242X,<br>+ =C2=A0=
 =C2=A0.parent =3D &amp;core_l4_iclk,<br>=C2=A0};<br>=C2=A0<br>=C2=A0static=
 struct clk spi_fclk[3] =3D {<br>=C2=A0 =C2=A0 =C2=A0{<br>- =C2=A0 =C2=A0 =
=C2=A0 =C2=A0.name	=3D &quot;spi1_fclk&quot;,<br>- =C2=A0 =C2=A0 =C2=A0 =C2=
=A0.flags	=3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>- =C2=A0 =C2=A0 =C2=
=A0 =C2=A0.parent	=3D &amp;func_48m_clk,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.n=
ame =3D &quot;spi1_fclk&quot;,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.flags =3D C=
LOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.pare=
nt =3D &amp;func_48m_clk,<br>=C2=A0 =C2=A0 =C2=A0}, {<br>- =C2=A0 =C2=A0 =
=C2=A0 =C2=A0.name	=3D &quot;spi2_fclk&quot;,<br>- =C2=A0 =C2=A0 =C2=A0 =C2=
=A0.flags	=3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>- =C2=A0 =C2=A0 =C2=
=A0 =C2=A0.parent	=3D &amp;func_48m_clk,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.n=
ame =3D &quot;spi2_fclk&quot;,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.flags =3D C=
LOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.pare=
nt =3D &amp;func_48m_clk,<br>=C2=A0 =C2=A0 =C2=A0}, {<br>- =C2=A0 =C2=A0 =
=C2=A0 =C2=A0.name	=3D &quot;spi3_fclk&quot;,<br>- =C2=A0 =C2=A0 =C2=A0 =C2=
=A0.flags	=3D CLOCK_IN_OMAP243X,<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0.parent	=
=3D &amp;func_48m_clk,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.name =3D &quot;spi3=
_fclk&quot;,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP243X,<=
br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.parent =3D &amp;func_48m_clk,<br>=C2=A0 =
=C2=A0 =C2=A0},<br>=C2=A0};<br>=C2=A0<br>=C2=A0static struct clk dss_clk[2]=
 =3D {<br>=C2=A0 =C2=A0 =C2=A0{<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0.name	=3D &=
quot;dss_clk1&quot;,<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0.flags	=3D CLOCK_IN_OM=
AP242X | CLOCK_IN_OMAP243X,<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0.parent	=3D &am=
p;core_clk,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.name =3D &quot;dss_clk1&quot;,=
<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP242X | CLOCK_IN_OM=
AP243X,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.parent =3D &amp;core_clk,<br>=C2=
=A0 =C2=A0 =C2=A0}, {<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0.name	=3D &quot;dss_c=
lk2&quot;,<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP242X | C=
LOCK_IN_OMAP243X,<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0.parent	=3D &amp;sys_clk,=
<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.name =3D &quot;dss_clk2&quot;,<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<b=
r>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.parent =3D &amp;sys_clk,<br>=C2=A0 =C2=A0 =
=C2=A0},<br>=C2=A0};<br>=C2=A0<br>=C2=A0static struct clk dss_54m_clk =3D {=
<br>- =C2=A0 =C2=A0.name	=3D &quot;dss_54m_clk&quot;,<br>- =C2=A0 =C2=A0.fl=
ags	=3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>- =C2=A0 =C2=A0.parent	=
=3D &amp;func_54m_clk,<br>+ =C2=A0 =C2=A0.name =3D &quot;dss_54m_clk&quot;,=
<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>+ =
=C2=A0 =C2=A0.parent =3D &amp;func_54m_clk,<br>=C2=A0};<br>=C2=A0<br>=C2=A0=
static struct clk dss_l3_iclk =3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;dss_l=
3_iclk&quot;,<br>- =C2=A0 =C2=A0.flags	=3D CLOCK_IN_OMAP242X | CLOCK_IN_OMA=
P243X,<br>- =C2=A0 =C2=A0.parent	=3D &amp;core_l3_iclk,<br>+ =C2=A0 =C2=A0.=
name =3D &quot;dss_l3_iclk&quot;,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMA=
P242X | CLOCK_IN_OMAP243X,<br>+ =C2=A0 =C2=A0.parent =3D &amp;core_l3_iclk,=
<br>=C2=A0};<br>=C2=A0<br>=C2=A0static struct clk dss_l4_iclk =3D {<br>- =
=C2=A0 =C2=A0.name	=3D &quot;dss_l4_iclk&quot;,<br>- =C2=A0 =C2=A0.flags	=
=3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>- =C2=A0 =C2=A0.parent	=3D &a=
mp;core_l4_iclk,<br>+ =C2=A0 =C2=A0.name =3D &quot;dss_l4_iclk&quot;,<br>+ =
=C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>+ =C2=A0 =
=C2=A0.parent =3D &amp;core_l4_iclk,<br>=C2=A0};<br>=C2=A0<br>=C2=A0static =
struct clk spi_iclk[3] =3D {<br>=C2=A0 =C2=A0 =C2=A0{<br>- =C2=A0 =C2=A0 =
=C2=A0 =C2=A0.name	=3D &quot;spi1_iclk&quot;,<br>- =C2=A0 =C2=A0 =C2=A0 =C2=
=A0.flags	=3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>- =C2=A0 =C2=A0 =C2=
=A0 =C2=A0.parent	=3D &amp;core_l4_iclk,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.n=
ame =3D &quot;spi1_iclk&quot;,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.flags =3D C=
LOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.pare=
nt =3D &amp;core_l4_iclk,<br>=C2=A0 =C2=A0 =C2=A0}, {<br>- =C2=A0 =C2=A0 =
=C2=A0 =C2=A0.name	=3D &quot;spi2_iclk&quot;,<br>- =C2=A0 =C2=A0 =C2=A0 =C2=
=A0.flags	=3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>- =C2=A0 =C2=A0 =C2=
=A0 =C2=A0.parent	=3D &amp;core_l4_iclk,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.n=
ame =3D &quot;spi2_iclk&quot;,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.flags =3D C=
LOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.pare=
nt =3D &amp;core_l4_iclk,<br>=C2=A0 =C2=A0 =C2=A0}, {<br>- =C2=A0 =C2=A0 =
=C2=A0 =C2=A0.name	=3D &quot;spi3_iclk&quot;,<br>- =C2=A0 =C2=A0 =C2=A0 =C2=
=A0.flags	=3D CLOCK_IN_OMAP243X,<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0.parent	=
=3D &amp;core_l4_iclk,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.name =3D &quot;spi3=
_iclk&quot;,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.flags =3D CLOCK_IN_OMAP243X,<=
br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.parent =3D &amp;core_l4_iclk,<br>=C2=A0 =
=C2=A0 =C2=A0},<br>=C2=A0};<br>=C2=A0<br>=C2=A0static struct clk omapctrl_c=
lk =3D {<br>- =C2=A0 =C2=A0.name	=3D &quot;omapctrl_iclk&quot;,<br>- =C2=A0=
 =C2=A0.flags	=3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,<br>+ =C2=A0 =C2=A0=
.name =3D &quot;omapctrl_iclk&quot;,<br>+ =C2=A0 =C2=A0.flags =3D CLOCK_IN_=
OMAP242X | CLOCK_IN_OMAP243X,<br>=C2=A0 =C2=A0 =C2=A0/* XXX Should be in WK=
UP domain */<br>- =C2=A0 =C2=A0.parent	=3D &amp;core_l4_iclk,<br>+ =C2=A0 =
=C2=A0.parent =3D &amp;core_l4_iclk,<br>=C2=A0};<br>=C2=A0<br>=C2=A0static =
struct clk *onchip_clks[] =3D {<br>@@ -1100,7 +1100,9 @@ void omap_clk_addu=
ser(struct clk *clk, qemu_irq user)<br>=C2=A0{<br>=C2=A0 =C2=A0 =C2=A0qemu_=
irq *i;<br>=C2=A0<br>- =C2=A0 =C2=A0for (i =3D clk-&gt;users; *i; i ++);<br=
>+ =C2=A0 =C2=A0for (i =3D clk-&gt;users; *i; i++) {<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0;<br>+ =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0*i =3D user;<br>=C2=
=A0}<br>=C2=A0<br>@@ -1108,21 +1110,23 @@ struct clk *omap_findclk(struct o=
map_mpu_state_s *mpu, const char *name)<br>=C2=A0{<br>=C2=A0 =C2=A0 =C2=A0s=
truct clk *i;<br>=C2=A0<br>- =C2=A0 =C2=A0for (i =3D mpu-&gt;clks; i-&gt;na=
me; i ++)<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!strcmp(i-&gt;name, name) || =
(i-&gt;alias &amp;&amp; !strcmp(i-&gt;alias, name)))<br>+ =C2=A0 =C2=A0for =
(i =3D mpu-&gt;clks; i-&gt;name; i++)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!=
strcmp(i-&gt;name, name) || (i-&gt;alias &amp;&amp; !strcmp(i-&gt;alias, na=
me))) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return i;<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0hw_error(&quot;%s: %s n=
ot found\n&quot;, __func__, name);<br>=C2=A0}<br>=C2=A0<br>=C2=A0void omap_=
clk_get(struct clk *clk)<br>=C2=A0{<br>- =C2=A0 =C2=A0clk-&gt;usecount ++;<=
br>+ =C2=A0 =C2=A0clk-&gt;usecount++;<br>=C2=A0}<br>=C2=A0<br>=C2=A0void om=
ap_clk_put(struct clk *clk)<br>=C2=A0{<br>- =C2=A0 =C2=A0if (!(clk-&gt;usec=
ount --))<br>+ =C2=A0 =C2=A0if (!(clk-&gt;usecount--)) {<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0hw_error(&quot;%s: %s is not in use\n&quot;, __func__, =
clk-&gt;name);<br>+ =C2=A0 =C2=A0}<br>=C2=A0}<br>=C2=A0<br>=C2=A0static voi=
d omap_clk_update(struct clk *clk)<br>@@ -1131,19 +1135,22 @@ static void o=
map_clk_update(struct clk *clk)<br>=C2=A0 =C2=A0 =C2=A0qemu_irq *user;<br>=
=C2=A0 =C2=A0 =C2=A0struct clk *i;<br>=C2=A0<br>- =C2=A0 =C2=A0if (clk-&gt;=
parent)<br>+ =C2=A0 =C2=A0if (clk-&gt;parent) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0parent =3D clk-&gt;parent-&gt;running;<br>- =C2=A0 =C2=A0else<br>=
+ =C2=A0 =C2=A0} else {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0parent =3D 1;<=
br>+ =C2=A0 =C2=A0}<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0running =3D parent &am=
p;&amp; (clk-&gt;enabled ||<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0((clk-&gt;flags &amp; ALWAYS_ENABLED) &am=
p;&amp; clk-&gt;usecount));<br>=C2=A0 =C2=A0 =C2=A0if (clk-&gt;running !=3D=
 running) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0clk-&gt;running =3D runnin=
g;<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0for (user =3D clk-&gt;users; *user; user=
 ++)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0for (user =3D clk-&gt;users; *user; us=
er++) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_set_irq(*us=
er, running);<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D clk-&gt;child1; i;=
 i =3D i-&gt;sibling)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0for (i =3D clk-&gt;child1; i; i =3D i-&gt;sibling) {<br>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0omap_clk_update(i);<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0}<br>=C2=A0<br>@@ -=
1155,8 +1162,9 @@ static void omap_clk_rate_update_full(struct clk *clk, un=
signed long int rate,<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0clk-&gt;rate =3D mul=
div64(rate, mult, div);<br>=C2=A0 =C2=A0 =C2=A0if (clk-&gt;running)<br>- =
=C2=A0 =C2=A0 =C2=A0 =C2=A0for (user =3D clk-&gt;users; *user; user ++)<br>=
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0for (user =3D clk-&gt;users; *user; user++) {<=
br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_irq_raise(*user);<b=
r>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0for (i =3D clk-&gt;=
child1; i; i =3D i-&gt;sibling)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0omap_c=
lk_rate_update_full(i, rate,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0div * i-&gt;divisor, mult *=
 i-&gt;multiplier);<br>@@ -1180,7 +1188,9 @@ void omap_clk_reparent(struct =
clk *clk, struct clk *parent)<br>=C2=A0 =C2=A0 =C2=A0struct clk **p;<br>=C2=
=A0<br>=C2=A0 =C2=A0 =C2=A0if (clk-&gt;parent) {<br>- =C2=A0 =C2=A0 =C2=A0 =
=C2=A0for (p =3D &amp;clk-&gt;parent-&gt;child1; *p !=3D clk; p =3D &amp;(*=
p)-&gt;sibling);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0for (p =3D &amp;clk-&gt;pa=
rent-&gt;child1; *p !=3D clk; p =3D &amp;(*p)-&gt;sibling) {<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*p =3D clk-&gt;sibling;<br>=C2=A0 =C2=A0 =
=C2=A0}<br>=C2=A0<br>@@ -1202,10 +1212,11 @@ void omap_clk_onoff(struct clk=
 *clk, int on)<br>=C2=A0<br>=C2=A0void omap_clk_canidle(struct clk *clk, in=
t can)<br>=C2=A0{<br>- =C2=A0 =C2=A0if (can)<br>+ =C2=A0 =C2=A0if (can) {<b=
r>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0omap_clk_put(clk);<br>- =C2=A0 =C2=A0el=
se<br>+ =C2=A0 =C2=A0} else {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0omap_clk=
_get(clk);<br>+ =C2=A0 =C2=A0}<br>=C2=A0}<br>=C2=A0<br>=C2=A0void omap_clk_=
setrate(struct clk *clk, int divide, int multiply)<br>@@ -1226,27 +1237,29 =
@@ void omap_clk_init(struct omap_mpu_state_s *mpu)<br>=C2=A0 =C2=A0 =C2=A0=
int count;<br>=C2=A0 =C2=A0 =C2=A0int flag;<br>=C2=A0<br>- =C2=A0 =C2=A0if =
(cpu_is_omap310(mpu))<br>+ =C2=A0 =C2=A0if (cpu_is_omap310(mpu)) {<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0flag =3D CLOCK_IN_OMAP310;<br>- =C2=A0 =C2=
=A0else if (cpu_is_omap1510(mpu))<br>+ =C2=A0 =C2=A0} else if (cpu_is_omap1=
510(mpu)) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0flag =3D CLOCK_IN_OMAP1510=
;<br>- =C2=A0 =C2=A0else if (cpu_is_omap2410(mpu) || cpu_is_omap2420(mpu))<=
br>+ =C2=A0 =C2=A0} else if (cpu_is_omap2410(mpu) || cpu_is_omap2420(mpu)) =
{<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0flag =3D CLOCK_IN_OMAP242X;<br>- =C2=
=A0 =C2=A0else if (cpu_is_omap2430(mpu))<br>+ =C2=A0 =C2=A0} else if (cpu_i=
s_omap2430(mpu)) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0flag =3D CLOCK_IN_O=
MAP243X;<br>- =C2=A0 =C2=A0else if (cpu_is_omap3430(mpu))<br>+ =C2=A0 =C2=
=A0} else if (cpu_is_omap3430(mpu)) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
flag =3D CLOCK_IN_OMAP243X;<br>- =C2=A0 =C2=A0else<br>+ =C2=A0 =C2=A0} else=
 {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>+ =C2=A0 =C2=A0}<br>=C2=
=A0<br>- =C2=A0 =C2=A0for (i =3D onchip_clks, count =3D 0; *i; i ++)<br>- =
=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((*i)-&gt;flags &amp; flag)<br>- =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0count ++;<br>+ =C2=A0 =C2=A0for (i =3D onchi=
p_clks, count =3D 0; *i; i++)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((*i)-&gt;=
flags &amp; flag) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0count++;<=
br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0mpu-&gt;clks =3D g=
_new0(struct clk, count + 1);<br>- =C2=A0 =C2=A0for (i =3D onchip_clks, j =
=3D mpu-&gt;clks; *i; i ++)<br>+ =C2=A0 =C2=A0for (i =3D onchip_clks, j =3D=
 mpu-&gt;clks; *i; i++)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((*i)-&gt;f=
lags &amp; flag) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memcp=
y(j, *i, sizeof(struct clk));<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0for (k =3D mpu-&gt;clks; k &lt; j; k ++)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0for (k =3D mpu-&gt;clks; k &lt; j; k++)<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (j-&gt;parent &amp;&amp;=
 !strcmp(j-&gt;parent-&gt;name, k-&gt;name)) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0j-&gt;parent =3D k;<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0j-&gt;sibling =3D k-&gt;child1;<br>@@ -1258,9 +1271,9 @@ void omap_clk_i=
nit(struct omap_mpu_state_s *mpu)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0j-&gt;divisor =3D j-&gt;divisor ?: 1;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0j-&gt;multiplier =3D j-&gt;multiplier ?: 1;<br>- =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0j ++;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0j++;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>- =C2=A0 =C2=A0=
for (j =3D mpu-&gt;clks; count --; j ++) {<br>+ =C2=A0 =C2=A0for (j =3D mpu=
-&gt;clks; count--; j++) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0omap_clk_up=
date(j);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0omap_clk_rate_update(j);<br>=
=C2=A0 =C2=A0 =C2=A0}<br>diff --git a/hw/misc/omap_l4.c b/hw/misc/omap_l4.c=
<br>index b7875489da..e0f5cea921 100644<br>--- a/hw/misc/omap_l4.c<br>+++ b=
/hw/misc/omap_l4.c<br>@@ -61,13 +61,13 @@ static uint64_t omap_l4ta_read(vo=
id *opaque, hwaddr addr, unsigned size)<br>=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0<=
br>=C2=A0 =C2=A0 =C2=A0switch (addr) {<br>- =C2=A0 =C2=A0case 0x00:	/* COMP=
ONENT */<br>+ =C2=A0 =C2=A0case 0x00: =C2=A0/* COMPONENT */<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0return s-&gt;component;<br>=C2=A0<br>- =C2=A0 =C2=
=A0case 0x20:	/* AGENT_CONTROL */<br>+ =C2=A0 =C2=A0case 0x20: =C2=A0/* AGE=
NT_CONTROL */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return s-&gt;control;<br=
>=C2=A0<br>- =C2=A0 =C2=A0case 0x28:	/* AGENT_STATUS */<br>+ =C2=A0 =C2=A0c=
ase 0x28: =C2=A0/* AGENT_STATUS */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret=
urn s-&gt;status;<br>=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0<br>@@ -86,15 +86,16 @@=
 static void omap_l4ta_write(void *opaque, hwaddr addr,<br>=C2=A0 =C2=A0 =
=C2=A0}<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0switch (addr) {<br>- =C2=A0 =C2=A0=
case 0x00:	/* COMPONENT */<br>- =C2=A0 =C2=A0case 0x28:	/* AGENT_STATUS */<=
br>+ =C2=A0 =C2=A0case 0x00: =C2=A0/* COMPONENT */<br>+ =C2=A0 =C2=A0case 0=
x28: =C2=A0/* AGENT_STATUS */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OMAP_RO_=
REG(addr);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>=C2=A0<br>- =C2=
=A0 =C2=A0case 0x20:	/* AGENT_CONTROL */<br>+ =C2=A0 =C2=A0case 0x20: =C2=
=A0/* AGENT_CONTROL */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;control =
=3D value &amp; 0x01000700;<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if (value &amp;=
 1)					/* OCP_RESET */<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt=
;status &amp;=3D ~1;				/* REQ_TIMEOUT */<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0i=
f (value &amp; 1) { =C2=A0 =C2=A0 =C2=A0 =C2=A0/* OCP_RESET */<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;status &amp;=3D ~1; =C2=A0 =C2=A0 =
=C2=A0 =C2=A0/* REQ_TIMEOUT */<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0default:=
<br>@@ -117,7 +118,7 @@ struct omap_target_agent_s *omap_l4ta_get(struct om=
ap_l4_s *bus,<br>=C2=A0 =C2=A0 =C2=A0struct omap_target_agent_s *ta =3D NUL=
L;<br>=C2=A0 =C2=A0 =C2=A0const struct omap_l4_agent_info_s *info =3D NULL;=
<br>=C2=A0<br>- =C2=A0 =C2=A0for (i =3D 0; i &lt; bus-&gt;ta_num; i ++)<br>=
+ =C2=A0 =C2=A0for (i =3D 0; i &lt; bus-&gt;ta_num; i++)<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0if (agents[i].ta =3D=3D cs) {<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0ta =3D &amp;bus-&gt;ta[i];<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0info =3D &amp;agents[i];<br>@@ -134,7 +135,7=
 @@ struct omap_target_agent_s *omap_l4ta_get(struct omap_l4_s *bus,<br>=C2=
=A0<br>=C2=A0 =C2=A0 =C2=A0ta-&gt;component =3D (&#39;Q&#39; &lt;&lt; 24) |=
 (&#39;E&#39; &lt;&lt; 16) | (&#39;M&#39; &lt;&lt; 8) | (&#39;U&#39; &lt;&l=
t; 0);<br>=C2=A0 =C2=A0 =C2=A0ta-&gt;status =3D 0x00000000;<br>- =C2=A0 =C2=
=A0ta-&gt;control =3D 0x00000200;	/* XXX 01000200 for L4TAO */<br>+ =C2=A0 =
=C2=A0ta-&gt;control =3D 0x00000200; /* XXX 01000200 for L4TAO */<br>=C2=A0=
<br>=C2=A0 =C2=A0 =C2=A0memory_region_init_io(&amp;ta-&gt;iomem, NULL, &amp=
;omap_l4ta_ops, ta, &quot;omap.l4ta&quot;,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0omap_l=
4_region_size(ta, info-&gt;ta_region));<br>diff --git a/hw/misc/omap_sdrc.c=
 b/hw/misc/omap_sdrc.c<br>index 6aa1b3ef7f..21d3ca8683 100644<br>--- a/hw/m=
isc/omap_sdrc.c<br>+++ b/hw/misc/omap_sdrc.c<br>@@ -40,44 +40,44 @@ static =
uint64_t omap_sdrc_read(void *opaque, hwaddr addr, unsigned size)<br>=C2=A0=
 =C2=A0 =C2=A0}<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0switch (addr) {<br>- =C2=
=A0 =C2=A0case 0x00:	/* SDRC_REVISION */<br>+ =C2=A0 =C2=A0case 0x00: =C2=
=A0/* SDRC_REVISION */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0x20;<br=
>=C2=A0<br>- =C2=A0 =C2=A0case 0x10:	/* SDRC_SYSCONFIG */<br>+ =C2=A0 =C2=
=A0case 0x10: =C2=A0/* SDRC_SYSCONFIG */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0return s-&gt;config;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x14:	/* SDRC_SYSS=
TATUS */<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0return 1;						/* RESETDONE */<br>=
-<br>- =C2=A0 =C2=A0case 0x40:	/* SDRC_CS_CFG */<br>- =C2=A0 =C2=A0case 0x4=
4:	/* SDRC_SHARING */<br>- =C2=A0 =C2=A0case 0x48:	/* SDRC_ERR_ADDR */<br>-=
 =C2=A0 =C2=A0case 0x4c:	/* SDRC_ERR_TYPE */<br>- =C2=A0 =C2=A0case 0x60:	/=
* SDRC_DLLA_SCTRL */<br>- =C2=A0 =C2=A0case 0x64:	/* SDRC_DLLA_STATUS */<br=
>- =C2=A0 =C2=A0case 0x68:	/* SDRC_DLLB_CTRL */<br>- =C2=A0 =C2=A0case 0x6c=
:	/* SDRC_DLLB_STATUS */<br>- =C2=A0 =C2=A0case 0x70:	/* SDRC_POWER */<br>-=
 =C2=A0 =C2=A0case 0x80:	/* SDRC_MCFG_0 */<br>- =C2=A0 =C2=A0case 0x84:	/* =
SDRC_MR_0 */<br>- =C2=A0 =C2=A0case 0x88:	/* SDRC_EMR1_0 */<br>- =C2=A0 =C2=
=A0case 0x8c:	/* SDRC_EMR2_0 */<br>- =C2=A0 =C2=A0case 0x90:	/* SDRC_EMR3_0=
 */<br>- =C2=A0 =C2=A0case 0x94:	/* SDRC_DCDL1_CTRL */<br>- =C2=A0 =C2=A0ca=
se 0x98:	/* SDRC_DCDL2_CTRL */<br>- =C2=A0 =C2=A0case 0x9c:	/* SDRC_ACTIM_C=
TRLA_0 */<br>- =C2=A0 =C2=A0case 0xa0:	/* SDRC_ACTIM_CTRLB_0 */<br>- =C2=A0=
 =C2=A0case 0xa4:	/* SDRC_RFR_CTRL_0 */<br>- =C2=A0 =C2=A0case 0xa8:	/* SDR=
C_MANUAL_0 */<br>- =C2=A0 =C2=A0case 0xb0:	/* SDRC_MCFG_1 */<br>- =C2=A0 =
=C2=A0case 0xb4:	/* SDRC_MR_1 */<br>- =C2=A0 =C2=A0case 0xb8:	/* SDRC_EMR1_=
1 */<br>- =C2=A0 =C2=A0case 0xbc:	/* SDRC_EMR2_1 */<br>- =C2=A0 =C2=A0case =
0xc0:	/* SDRC_EMR3_1 */<br>- =C2=A0 =C2=A0case 0xc4:	/* SDRC_ACTIM_CTRLA_1 =
*/<br>- =C2=A0 =C2=A0case 0xc8:	/* SDRC_ACTIM_CTRLB_1 */<br>- =C2=A0 =C2=A0=
case 0xd4:	/* SDRC_RFR_CTRL_1 */<br>- =C2=A0 =C2=A0case 0xd8:	/* SDRC_MANUA=
L_1 */<br>+ =C2=A0 =C2=A0case 0x14: =C2=A0/* SDRC_SYSSTATUS */<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0return 1; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* RESETDO=
NE */<br>+<br>+ =C2=A0 =C2=A0case 0x40: =C2=A0/* SDRC_CS_CFG */<br>+ =C2=A0=
 =C2=A0case 0x44: =C2=A0/* SDRC_SHARING */<br>+ =C2=A0 =C2=A0case 0x48: =C2=
=A0/* SDRC_ERR_ADDR */<br>+ =C2=A0 =C2=A0case 0x4c: =C2=A0/* SDRC_ERR_TYPE =
*/<br>+ =C2=A0 =C2=A0case 0x60: =C2=A0/* SDRC_DLLA_SCTRL */<br>+ =C2=A0 =C2=
=A0case 0x64: =C2=A0/* SDRC_DLLA_STATUS */<br>+ =C2=A0 =C2=A0case 0x68: =C2=
=A0/* SDRC_DLLB_CTRL */<br>+ =C2=A0 =C2=A0case 0x6c: =C2=A0/* SDRC_DLLB_STA=
TUS */<br>+ =C2=A0 =C2=A0case 0x70: =C2=A0/* SDRC_POWER */<br>+ =C2=A0 =C2=
=A0case 0x80: =C2=A0/* SDRC_MCFG_0 */<br>+ =C2=A0 =C2=A0case 0x84: =C2=A0/*=
 SDRC_MR_0 */<br>+ =C2=A0 =C2=A0case 0x88: =C2=A0/* SDRC_EMR1_0 */<br>+ =C2=
=A0 =C2=A0case 0x8c: =C2=A0/* SDRC_EMR2_0 */<br>+ =C2=A0 =C2=A0case 0x90: =
=C2=A0/* SDRC_EMR3_0 */<br>+ =C2=A0 =C2=A0case 0x94: =C2=A0/* SDRC_DCDL1_CT=
RL */<br>+ =C2=A0 =C2=A0case 0x98: =C2=A0/* SDRC_DCDL2_CTRL */<br>+ =C2=A0 =
=C2=A0case 0x9c: =C2=A0/* SDRC_ACTIM_CTRLA_0 */<br>+ =C2=A0 =C2=A0case 0xa0=
: =C2=A0/* SDRC_ACTIM_CTRLB_0 */<br>+ =C2=A0 =C2=A0case 0xa4: =C2=A0/* SDRC=
_RFR_CTRL_0 */<br>+ =C2=A0 =C2=A0case 0xa8: =C2=A0/* SDRC_MANUAL_0 */<br>+ =
=C2=A0 =C2=A0case 0xb0: =C2=A0/* SDRC_MCFG_1 */<br>+ =C2=A0 =C2=A0case 0xb4=
: =C2=A0/* SDRC_MR_1 */<br>+ =C2=A0 =C2=A0case 0xb8: =C2=A0/* SDRC_EMR1_1 *=
/<br>+ =C2=A0 =C2=A0case 0xbc: =C2=A0/* SDRC_EMR2_1 */<br>+ =C2=A0 =C2=A0ca=
se 0xc0: =C2=A0/* SDRC_EMR3_1 */<br>+ =C2=A0 =C2=A0case 0xc4: =C2=A0/* SDRC=
_ACTIM_CTRLA_1 */<br>+ =C2=A0 =C2=A0case 0xc8: =C2=A0/* SDRC_ACTIM_CTRLB_1 =
*/<br>+ =C2=A0 =C2=A0case 0xd4: =C2=A0/* SDRC_RFR_CTRL_1 */<br>+ =C2=A0 =C2=
=A0case 0xd8: =C2=A0/* SDRC_MANUAL_1 */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0return 0x00;<br>=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0<br>@@ -96,49 +96,50 @@ s=
tatic void omap_sdrc_write(void *opaque, hwaddr addr,<br>=C2=A0 =C2=A0 =C2=
=A0}<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0switch (addr) {<br>- =C2=A0 =C2=A0cas=
e 0x00:	/* SDRC_REVISION */<br>- =C2=A0 =C2=A0case 0x14:	/* SDRC_SYSSTATUS =
*/<br>- =C2=A0 =C2=A0case 0x48:	/* SDRC_ERR_ADDR */<br>- =C2=A0 =C2=A0case =
0x64:	/* SDRC_DLLA_STATUS */<br>- =C2=A0 =C2=A0case 0x6c:	/* SDRC_DLLB_STAT=
US */<br>+ =C2=A0 =C2=A0case 0x00: =C2=A0/* SDRC_REVISION */<br>+ =C2=A0 =
=C2=A0case 0x14: =C2=A0/* SDRC_SYSSTATUS */<br>+ =C2=A0 =C2=A0case 0x48: =
=C2=A0/* SDRC_ERR_ADDR */<br>+ =C2=A0 =C2=A0case 0x64: =C2=A0/* SDRC_DLLA_S=
TATUS */<br>+ =C2=A0 =C2=A0case 0x6c: =C2=A0/* SDRC_DLLB_STATUS */<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OMAP_RO_REG(addr);<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x10:	/* SDRC_SYSCONF=
IG */<br>+ =C2=A0 =C2=A0case 0x10: =C2=A0/* SDRC_SYSCONFIG */<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0if ((value &gt;&gt; 3) !=3D 0x2)<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &quot;%s: bad SDRAM idle =
mode %i\n&quot;,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0__func__, (unsigned)value &gt;&gt; 3);<br>- =C2=A0 =C2=
=A0 =C2=A0 =C2=A0if (value &amp; 2)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (val=
ue &amp; 2) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0omap_sdrc_=
reset(s);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0s-&gt;config =3D value &amp; 0x18;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0break;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x40:	/* SDRC_CS_CFG */<br>- =C2=
=A0 =C2=A0case 0x44:	/* SDRC_SHARING */<br>- =C2=A0 =C2=A0case 0x4c:	/* SDR=
C_ERR_TYPE */<br>- =C2=A0 =C2=A0case 0x60:	/* SDRC_DLLA_SCTRL */<br>- =C2=
=A0 =C2=A0case 0x68:	/* SDRC_DLLB_CTRL */<br>- =C2=A0 =C2=A0case 0x70:	/* S=
DRC_POWER */<br>- =C2=A0 =C2=A0case 0x80:	/* SDRC_MCFG_0 */<br>- =C2=A0 =C2=
=A0case 0x84:	/* SDRC_MR_0 */<br>- =C2=A0 =C2=A0case 0x88:	/* SDRC_EMR1_0 *=
/<br>- =C2=A0 =C2=A0case 0x8c:	/* SDRC_EMR2_0 */<br>- =C2=A0 =C2=A0case 0x9=
0:	/* SDRC_EMR3_0 */<br>- =C2=A0 =C2=A0case 0x94:	/* SDRC_DCDL1_CTRL */<br>=
- =C2=A0 =C2=A0case 0x98:	/* SDRC_DCDL2_CTRL */<br>- =C2=A0 =C2=A0case 0x9c=
:	/* SDRC_ACTIM_CTRLA_0 */<br>- =C2=A0 =C2=A0case 0xa0:	/* SDRC_ACTIM_CTRLB=
_0 */<br>- =C2=A0 =C2=A0case 0xa4:	/* SDRC_RFR_CTRL_0 */<br>- =C2=A0 =C2=A0=
case 0xa8:	/* SDRC_MANUAL_0 */<br>- =C2=A0 =C2=A0case 0xb0:	/* SDRC_MCFG_1 =
*/<br>- =C2=A0 =C2=A0case 0xb4:	/* SDRC_MR_1 */<br>- =C2=A0 =C2=A0case 0xb8=
:	/* SDRC_EMR1_1 */<br>- =C2=A0 =C2=A0case 0xbc:	/* SDRC_EMR2_1 */<br>- =C2=
=A0 =C2=A0case 0xc0:	/* SDRC_EMR3_1 */<br>- =C2=A0 =C2=A0case 0xc4:	/* SDRC=
_ACTIM_CTRLA_1 */<br>- =C2=A0 =C2=A0case 0xc8:	/* SDRC_ACTIM_CTRLB_1 */<br>=
- =C2=A0 =C2=A0case 0xd4:	/* SDRC_RFR_CTRL_1 */<br>- =C2=A0 =C2=A0case 0xd8=
:	/* SDRC_MANUAL_1 */<br>+ =C2=A0 =C2=A0case 0x40: =C2=A0/* SDRC_CS_CFG */<=
br>+ =C2=A0 =C2=A0case 0x44: =C2=A0/* SDRC_SHARING */<br>+ =C2=A0 =C2=A0cas=
e 0x4c: =C2=A0/* SDRC_ERR_TYPE */<br>+ =C2=A0 =C2=A0case 0x60: =C2=A0/* SDR=
C_DLLA_SCTRL */<br>+ =C2=A0 =C2=A0case 0x68: =C2=A0/* SDRC_DLLB_CTRL */<br>=
+ =C2=A0 =C2=A0case 0x70: =C2=A0/* SDRC_POWER */<br>+ =C2=A0 =C2=A0case 0x8=
0: =C2=A0/* SDRC_MCFG_0 */<br>+ =C2=A0 =C2=A0case 0x84: =C2=A0/* SDRC_MR_0 =
*/<br>+ =C2=A0 =C2=A0case 0x88: =C2=A0/* SDRC_EMR1_0 */<br>+ =C2=A0 =C2=A0c=
ase 0x8c: =C2=A0/* SDRC_EMR2_0 */<br>+ =C2=A0 =C2=A0case 0x90: =C2=A0/* SDR=
C_EMR3_0 */<br>+ =C2=A0 =C2=A0case 0x94: =C2=A0/* SDRC_DCDL1_CTRL */<br>+ =
=C2=A0 =C2=A0case 0x98: =C2=A0/* SDRC_DCDL2_CTRL */<br>+ =C2=A0 =C2=A0case =
0x9c: =C2=A0/* SDRC_ACTIM_CTRLA_0 */<br>+ =C2=A0 =C2=A0case 0xa0: =C2=A0/* =
SDRC_ACTIM_CTRLB_0 */<br>+ =C2=A0 =C2=A0case 0xa4: =C2=A0/* SDRC_RFR_CTRL_0=
 */<br>+ =C2=A0 =C2=A0case 0xa8: =C2=A0/* SDRC_MANUAL_0 */<br>+ =C2=A0 =C2=
=A0case 0xb0: =C2=A0/* SDRC_MCFG_1 */<br>+ =C2=A0 =C2=A0case 0xb4: =C2=A0/*=
 SDRC_MR_1 */<br>+ =C2=A0 =C2=A0case 0xb8: =C2=A0/* SDRC_EMR1_1 */<br>+ =C2=
=A0 =C2=A0case 0xbc: =C2=A0/* SDRC_EMR2_1 */<br>+ =C2=A0 =C2=A0case 0xc0: =
=C2=A0/* SDRC_EMR3_1 */<br>+ =C2=A0 =C2=A0case 0xc4: =C2=A0/* SDRC_ACTIM_CT=
RLA_1 */<br>+ =C2=A0 =C2=A0case 0xc8: =C2=A0/* SDRC_ACTIM_CTRLB_1 */<br>+ =
=C2=A0 =C2=A0case 0xd4: =C2=A0/* SDRC_RFR_CTRL_1 */<br>+ =C2=A0 =C2=A0case =
0xd8: =C2=A0/* SDRC_MANUAL_1 */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;=
<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0default:<br>diff --git a/hw/misc/omap_tap=
.c b/hw/misc/omap_tap.c<br>index 4d7fb7d85f..daa15696ee 100644<br>--- a/hw/=
misc/omap_tap.c<br>+++ b/hw/misc/omap_tap.c<br>@@ -32,25 +32,25 @@ static u=
int64_t omap_tap_read(void *opaque, hwaddr addr, unsigned size)<br>=C2=A0 =
=C2=A0 =C2=A0}<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0switch (addr) {<br>- =C2=A0=
 =C2=A0case 0x204:	/* IDCODE_reg */<br>+ =C2=A0 =C2=A0case 0x204: /* IDCODE=
_reg */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (s-&gt;mpu_model) {<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case omap2420:<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0case omap2422:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case omap2=
423:<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0x5b5d902f;	/* ES=
 2.2 */<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0x5b5d902f; =
=C2=A0/* ES 2.2 */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case omap2430:<br>-=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0x5b68a02f;	/* ES 2.2 */<b=
r>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0x5b68a02f; =C2=A0/* ES=
 2.2 */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case omap3430:<br>- =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0x1b7ae02f;	/* ES 2 */<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0x1b7ae02f; =C2=A0/* ES 2 */<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0hw_error(&quot;%s: Bad mpu model\n&quot;, __func__);<br=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x208=
:	/* PRODUCTION_ID_reg for OMAP2 */<br>- =C2=A0 =C2=A0case 0x210:	/* PRODUC=
TION_ID_reg for OMAP3 */<br>+ =C2=A0 =C2=A0case 0x208: /* PRODUCTION_ID_reg=
 for OMAP2 */<br>+ =C2=A0 =C2=A0case 0x210: /* PRODUCTION_ID_reg for OMAP3 =
*/<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (s-&gt;mpu_model) {<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case omap2420:<br>- =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0return 0x000254f0;	/* POP ESHS2.1.1 in N91/93/95, ES2 in N=
800 */<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0x000254f0; =C2=
=A0/* POP ESHS2.1.1 in N91/93/95, ES2 in N800 */<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0case omap2422:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0return 0x000400f0;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case omap2423=
:<br>@@ -68,22 +68,22 @@ static uint64_t omap_tap_read(void *opaque, hwaddr=
 addr, unsigned size)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case omap2420:<b=
r>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case omap2422:<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0case omap2423:<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r=
eturn 0xcafeb5d9;	/* ES 2.2 */<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0return 0xcafeb5d9; =C2=A0/* ES 2.2 */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0case omap2430:<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0xca=
feb68a;	/* ES 2.2 */<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0=
xcafeb68a; =C2=A0/* ES 2.2 */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case oma=
p3430:<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0xcafeb7ae;	/* =
ES 2 */<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0xcafeb7ae; =
=C2=A0/* ES 2 */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hw_error(&quot;%s: Bad mpu model\n=
&quot;, __func__);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0<br>- =
=C2=A0 =C2=A0case 0x218:	/* DIE_ID_reg */<br>+ =C2=A0 =C2=A0case 0x218: /* =
DIE_ID_reg */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return (&#39;Q&#39; &lt;=
&lt; 24) | (&#39;E&#39; &lt;&lt; 16) | (&#39;M&#39; &lt;&lt; 8) | (&#39;U&#=
39; &lt;&lt; 0);<br>- =C2=A0 =C2=A0case 0x21c:	/* DIE_ID_reg */<br>+ =C2=A0=
 =C2=A0case 0x21c: /* DIE_ID_reg */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0re=
turn 0x54 &lt;&lt; 24;<br>- =C2=A0 =C2=A0case 0x220:	/* DIE_ID_reg */<br>+ =
=C2=A0 =C2=A0case 0x220: /* DIE_ID_reg */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0return (&#39;Q&#39; &lt;&lt; 24) | (&#39;E&#39; &lt;&lt; 16) | (&#39;=
M&#39; &lt;&lt; 8) | (&#39;U&#39; &lt;&lt; 0);<br>- =C2=A0 =C2=A0case 0x224=
:	/* DIE_ID_reg */<br>+ =C2=A0 =C2=A0case 0x224: /* DIE_ID_reg */<br>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0return (&#39;Q&#39; &lt;&lt; 24) | (&#39;E&#39;=
 &lt;&lt; 16) | (&#39;M&#39; &lt;&lt; 8) | (&#39;U&#39; &lt;&lt; 0);<br>=C2=
=A0 =C2=A0 =C2=A0}<br>=C2=A0<br>diff --git a/hw/sd/omap_mmc.c b/hw/sd/omap_=
mmc.c<br>index edd3cf2a1e..848e42f076 100644<br>--- a/hw/sd/omap_mmc.c<br>+=
++ b/hw/sd/omap_mmc.c<br>@@ -104,11 +104,11 @@ static void omap_mmc_fifolev=
el_update(struct omap_mmc_s *host)<br>=C2=A0}<br>=C2=A0<br>=C2=A0typedef en=
um {<br>- =C2=A0 =C2=A0sd_nore =3D 0,	/* no response */<br>- =C2=A0 =C2=A0s=
d_r1,		/* normal response command */<br>- =C2=A0 =C2=A0sd_r2,		/* CID, CSD =
registers */<br>- =C2=A0 =C2=A0sd_r3,		/* OCR register */<br>- =C2=A0 =C2=
=A0sd_r6 =3D 6,		/* Published RCA response */<br>+ =C2=A0 =C2=A0sd_nore =3D=
 0, =C2=A0/* no response */<br>+ =C2=A0 =C2=A0sd_r1, =C2=A0 =C2=A0 =C2=A0 =
=C2=A0/* normal response command */<br>+ =C2=A0 =C2=A0sd_r2, =C2=A0 =C2=A0 =
=C2=A0 =C2=A0/* CID, CSD registers */<br>+ =C2=A0 =C2=A0sd_r3, =C2=A0 =C2=
=A0 =C2=A0 =C2=A0/* OCR register */<br>+ =C2=A0 =C2=A0sd_r6 =3D 6, =C2=A0 =
=C2=A0/* Published RCA response */<br>=C2=A0 =C2=A0 =C2=A0sd_r1b =3D -1,<br=
>=C2=A0} sd_rsp_type_t;<br>=C2=A0<br>@@ -125,8 +125,9 @@ static void omap_m=
mc_command(struct omap_mmc_s *host, int cmd, int dir,<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0return;<br>=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0<br>- =C2=A0 =C2=
=A0if (resptype =3D=3D sd_r1 &amp;&amp; busy)<br>+ =C2=A0 =C2=A0if (resptyp=
e =3D=3D sd_r1 &amp;&amp; busy) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0resp=
type =3D sd_r1b;<br>+ =C2=A0 =C2=A0}<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0if (t=
ype =3D=3D sd_adtc) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0host-&gt;fifo_st=
art =3D 0;<br>@@ -164,8 +165,9 @@ static void omap_mmc_command(struct omap_=
mmc_s *host, int cmd, int dir,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0LOCK_UNLOCK_FAILED | COM_CRC_ERROR | ILLEGAL_COMMAND |=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CARD_ECC_=
FAILED | CC_ERROR | SD_ERROR |<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0CID_CSD_OVERWRITE;<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if =
(host-&gt;sdio &amp; (1 &lt;&lt; 13))<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (h=
ost-&gt;sdio &amp; (1 &lt;&lt; 13)) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0mask |=3D AKE_SEQ_ERROR;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rspstatus =3D ldl_be_p(response);<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>=C2=A0<br>@@ -185,10 +187,11 @@ st=
atic void omap_mmc_command(struct omap_mmc_s *host, int cmd, int dir,<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rsplen =3D 4;<br>=C2=A0<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0rspstatus =3D ldl_be_p(response);<br>- =C2=A0 =C2=A0 =
=C2=A0 =C2=A0if (rspstatus &amp; 0x80000000)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0if (rspstatus &amp; 0x80000000) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0host-&gt;status &amp;=3D 0xe000;<br>- =C2=A0 =C2=A0 =C2=A0 =C2=
=A0else<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0host-&gt;status |=3D 0x1000;<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>=C2=A0<br>=C2=
=A0 =C2=A0 =C2=A0case sd_r6:<br>@@ -202,35 +205,39 @@ static void omap_mmc_=
command(struct omap_mmc_s *host, int cmd, int dir,<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0rspstatus =3D (response[2] &lt;&lt; 8) | (response[3] &lt;&lt;=
 0);<br>=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0<br>- =C2=A0 =C2=A0if (rspstatus &am=
p; mask)<br>+ =C2=A0 =C2=A0if (rspstatus &amp; mask) {<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0host-&gt;status |=3D 0x4000;<br>- =C2=A0 =C2=A0else<br>+ =
=C2=A0 =C2=A0} else {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0host-&gt;status =
&amp;=3D 0xb000;<br>+ =C2=A0 =C2=A0}<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0if (r=
splen)<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0for (rsplen =3D 0; rsplen &lt; 8; rs=
plen ++)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0for (rsplen =3D 0; rsplen &lt; 8; =
rsplen++)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0host-&gt;rsp[~=
rsplen &amp; 7] =3D response[(rsplen &lt;&lt; 1) | 1] |<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(response[(rs=
plen &lt;&lt; 1) | 0] &lt;&lt; 8);<br>=C2=A0<br>- =C2=A0 =C2=A0if (timeout)=
<br>+ =C2=A0 =C2=A0if (timeout) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0host=
-&gt;status |=3D 0x0080;<br>- =C2=A0 =C2=A0else if (cmd =3D=3D 12)<br>- =C2=
=A0 =C2=A0 =C2=A0 =C2=A0host-&gt;status |=3D 0x0005;	/* Makes it more real =
*/<br>- =C2=A0 =C2=A0else<br>+ =C2=A0 =C2=A0} else if (cmd =3D=3D 12) {<br>=
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0host-&gt;status |=3D 0x0005; /* Makes it more =
real */<br>+ =C2=A0 =C2=A0} else {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hos=
t-&gt;status |=3D 0x0001;<br>+ =C2=A0 =C2=A0}<br>=C2=A0}<br>=C2=A0<br>=C2=
=A0static void omap_mmc_transfer(struct omap_mmc_s *host)<br>=C2=A0{<br>=C2=
=A0 =C2=A0 =C2=A0uint8_t value;<br>=C2=A0<br>- =C2=A0 =C2=A0if (!host-&gt;t=
ransfer)<br>+ =C2=A0 =C2=A0if (!host-&gt;transfer) {<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0return;<br>+ =C2=A0 =C2=A0}<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=
=A0while (1) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (host-&gt;ddir) {<br=
>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (host-&gt;fifo_len &gt; host=
-&gt;af_level)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (host-&gt;f=
ifo_len &gt; host-&gt;af_level) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0break;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0}<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0value =3D=
 sd_read_byte(host-&gt;card);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0host-&gt;fifo[(host-&gt;fifo_start + host-&gt;fifo_len) &amp; 31] =3D=
 value;<br>@@ -238,29 +245,30 @@ static void omap_mmc_transfer(struct omap_=
mmc_s *host)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0value =3D sd_read_byte(host-&gt;card);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0host-&gt;fifo[(host-&gt;fifo_start + host=
-&gt;fifo_len) &amp; 31] |=3D<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0value &lt;&lt; 8;<br>- =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0host-&gt;blen_counter -=
-;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0host-&gt;ble=
n_counter--;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0=
<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0host-&gt;fifo_len ++;<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0host-&gt;fifo_len++;<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0if (!host-&gt;fifo_len)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0if (!host-&gt;fifo_len) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0break;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<=
br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0value =3D host=
-&gt;fifo[host-&gt;fifo_start] &amp; 0xff;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0sd_write_byte(host-&gt;card, value);<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (-- host-&gt;blen_counter) {<br>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0value =3D host-&gt;=
fifo[host-&gt;fifo_start] &gt;&gt; 8;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0sd_write_byte(host-&gt;card, value);<br>- =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0host-&gt;blen_counter -=
-;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0host-&gt;ble=
n_counter--;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0=
<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0host-&gt;fifo_start ++;<br>-=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0host-&gt;fifo_len --;<br>+ =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0host-&gt;fifo_start++;<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0host-&gt;fifo_len--;<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0host-&gt;fifo_start &amp;=3D 31;<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if=
 (host-&gt;blen_counter =3D=3D 0) {<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0host-&gt;nblk_counter --;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0host-&gt;nblk_counter--;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0host-&gt;blen_counter =3D host-&gt;blen;<br>=C2=A0<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (host-&gt;nblk_counter =3D=3D 0) {<br>=
@@ -331,82 +339,82 @@ static uint64_t omap_mmc_read(void *opaque, hwaddr of=
fset, unsigned size)<br>=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0<br>=C2=A0 =C2=A0 =
=C2=A0switch (offset) {<br>- =C2=A0 =C2=A0case 0x00:	/* MMC_CMD */<br>+ =C2=
=A0 =C2=A0case 0x00: =C2=A0/* MMC_CMD */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0return s-&gt;last_cmd;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x04:	/* MMC_ARG=
L */<br>+ =C2=A0 =C2=A0case 0x04: =C2=A0/* MMC_ARGL */<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0return s-&gt;arg &amp; 0x0000ffff;<br>=C2=A0<br>- =C2=A0 =
=C2=A0case 0x08:	/* MMC_ARGH */<br>+ =C2=A0 =C2=A0case 0x08: =C2=A0/* MMC_A=
RGH */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return s-&gt;arg &gt;&gt; 16;<b=
r>=C2=A0<br>- =C2=A0 =C2=A0case 0x0c:	/* MMC_CON */<br>- =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return (s-&gt;dw &lt;&lt; 15) | (s-&gt;mode &lt;&lt; 12) | (s-&gt=
;enable &lt;&lt; 11) | <br>+ =C2=A0 =C2=A0case 0x0c: =C2=A0/* MMC_CON */<br=
>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0return (s-&gt;dw &lt;&lt; 15) | (s-&gt;mode &=
lt;&lt; 12) | (s-&gt;enable &lt;&lt; 11) |<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(s-&gt;be &lt;&lt; 10) | s-&gt;clkdiv;<br=
>=C2=A0<br>- =C2=A0 =C2=A0case 0x10:	/* MMC_STAT */<br>+ =C2=A0 =C2=A0case =
0x10: =C2=A0/* MMC_STAT */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return s-&g=
t;status;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x14:	/* MMC_IE */<br>+ =C2=A0 =
=C2=A0case 0x14: =C2=A0/* MMC_IE */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0re=
turn s-&gt;mask;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x18:	/* MMC_CTO */<br>+ =
=C2=A0 =C2=A0case 0x18: =C2=A0/* MMC_CTO */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0return s-&gt;cto;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x1c:	/* MMC_DTO *=
/<br>+ =C2=A0 =C2=A0case 0x1c: =C2=A0/* MMC_DTO */<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return s-&gt;dto;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x20:	/* MM=
C_DATA */<br>+ =C2=A0 =C2=A0case 0x20: =C2=A0/* MMC_DATA */<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0/* TODO: support 8-bit access */<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0i =3D s-&gt;fifo[s-&gt;fifo_start];<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0if (s-&gt;fifo_len =3D=3D 0) {<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;MMC: FIFO underrun\n&quot;);<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return i;<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0}<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;fifo_start ++;<br>=
- =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;fifo_len --;<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0s-&gt;fifo_start++;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;fifo_len--;=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;fifo_start &amp;=3D 31;<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0omap_mmc_transfer(s);<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0omap_mmc_fifolevel_update(s);<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0omap_mmc_interrupts_update(s);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0return i;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x24:	/* MMC_BLEN */<br>+ =C2=
=A0 =C2=A0case 0x24: =C2=A0/* MMC_BLEN */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0return s-&gt;blen_counter;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x28:	/* =
MMC_NBLK */<br>+ =C2=A0 =C2=A0case 0x28: =C2=A0/* MMC_NBLK */<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0return s-&gt;nblk_counter;<br>=C2=A0<br>- =C2=A0 =
=C2=A0case 0x2c:	/* MMC_BUF */<br>+ =C2=A0 =C2=A0case 0x2c: =C2=A0/* MMC_BU=
F */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return (s-&gt;rx_dma &lt;&lt; 15)=
 | (s-&gt;af_level &lt;&lt; 8) |<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0(s-&gt;tx_dma &lt;&lt; 7) | s-&gt;ae_level;<br>=C2=A0<br>- =C2=A0=
 =C2=A0case 0x30:	/* MMC_SPI */<br>+ =C2=A0 =C2=A0case 0x30: =C2=A0/* MMC_S=
PI */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0x0000;<br>- =C2=A0 =C2=
=A0case 0x34:	/* MMC_SDIO */<br>+ =C2=A0 =C2=A0case 0x34: =C2=A0/* MMC_SDIO=
 */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return (s-&gt;cdet_wakeup &lt;&lt;=
 2) | (s-&gt;cdet_enable) | s-&gt;sdio;<br>- =C2=A0 =C2=A0case 0x38:	/* MMC=
_SYST */<br>+ =C2=A0 =C2=A0case 0x38: =C2=A0/* MMC_SYST */<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0return 0x0000;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x3c:	=
/* MMC_REV */<br>+ =C2=A0 =C2=A0case 0x3c: =C2=A0/* MMC_REV */<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0return s-&gt;rev;<br>=C2=A0<br>- =C2=A0 =C2=A0ca=
se 0x40:	/* MMC_RSP0 */<br>- =C2=A0 =C2=A0case 0x44:	/* MMC_RSP1 */<br>- =
=C2=A0 =C2=A0case 0x48:	/* MMC_RSP2 */<br>- =C2=A0 =C2=A0case 0x4c:	/* MMC_=
RSP3 */<br>- =C2=A0 =C2=A0case 0x50:	/* MMC_RSP4 */<br>- =C2=A0 =C2=A0case =
0x54:	/* MMC_RSP5 */<br>- =C2=A0 =C2=A0case 0x58:	/* MMC_RSP6 */<br>- =C2=
=A0 =C2=A0case 0x5c:	/* MMC_RSP7 */<br>+ =C2=A0 =C2=A0case 0x40: =C2=A0/* M=
MC_RSP0 */<br>+ =C2=A0 =C2=A0case 0x44: =C2=A0/* MMC_RSP1 */<br>+ =C2=A0 =
=C2=A0case 0x48: =C2=A0/* MMC_RSP2 */<br>+ =C2=A0 =C2=A0case 0x4c: =C2=A0/*=
 MMC_RSP3 */<br>+ =C2=A0 =C2=A0case 0x50: =C2=A0/* MMC_RSP4 */<br>+ =C2=A0 =
=C2=A0case 0x54: =C2=A0/* MMC_RSP5 */<br>+ =C2=A0 =C2=A0case 0x58: =C2=A0/*=
 MMC_RSP6 */<br>+ =C2=A0 =C2=A0case 0x5c: =C2=A0/* MMC_RSP7 */<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0return s-&gt;rsp[(offset - 0x40) &gt;&gt; 2];<br=
>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0/* OMAP2-specific */<br>- =C2=A0 =C2=A0case =
0x60:	/* MMC_IOSR */<br>- =C2=A0 =C2=A0case 0x64:	/* MMC_SYSC */<br>+ =C2=
=A0 =C2=A0case 0x60: =C2=A0/* MMC_IOSR */<br>+ =C2=A0 =C2=A0case 0x64: =C2=
=A0/* MMC_SYSC */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>- =C2=
=A0 =C2=A0case 0x68:	/* MMC_SYSS */<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0return =
1;						/* RSTD */<br>+ =C2=A0 =C2=A0case 0x68: =C2=A0/* MMC_SYSS */<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0return 1; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* =
RSTD */<br>=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0OMAP_BAD_=
REG(offset);<br>@@ -425,13 +433,15 @@ static void omap_mmc_write(void *opaq=
ue, hwaddr offset,<br>=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=
=A0switch (offset) {<br>- =C2=A0 =C2=A0case 0x00:	/* MMC_CMD */<br>- =C2=A0=
 =C2=A0 =C2=A0 =C2=A0if (!s-&gt;enable)<br>+ =C2=A0 =C2=A0case 0x00: =C2=A0=
/* MMC_CMD */<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!s-&gt;enable) {<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;last_cmd =
=3D value;<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; 8; i ++)<br=
>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; 8; i++) {<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;rsp[i] =3D 0x0000;<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0omap_mmc_command=
(s, value &amp; 63, (value &gt;&gt; 15) &amp; 1,<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(sd_cmd_type_t) ((value &gt;&gt; 1=
2) &amp; 3),<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(value &gt;&gt; 11) &amp; 1,<br>@@ -440,17 +450,17 @@ static void omap_m=
mc_write(void *opaque, hwaddr offset,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
omap_mmc_update(s);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>=C2=A0<b=
r>- =C2=A0 =C2=A0case 0x04:	/* MMC_ARGL */<br>+ =C2=A0 =C2=A0case 0x04: =C2=
=A0/* MMC_ARGL */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;arg &amp;=3D 0=
xffff0000;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;arg |=3D 0x0000ffff &=
amp; value;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>=C2=A0<br>- =C2=
=A0 =C2=A0case 0x08:	/* MMC_ARGH */<br>+ =C2=A0 =C2=A0case 0x08: =C2=A0/* M=
MC_ARGH */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;arg &amp;=3D 0x0000ff=
ff;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;arg |=3D value &lt;&lt; 16;<=
br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>=C2=A0<br>- =C2=A0 =C2=A0cas=
e 0x0c:	/* MMC_CON */<br>+ =C2=A0 =C2=A0case 0x0c: =C2=A0/* MMC_CON */<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;dw =3D (value &gt;&gt; 15) &amp; 1;=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;mode =3D (value &gt;&gt; 12) &a=
mp; 3;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;enable =3D (value &gt;&gt=
; 11) &amp; 1;<br>@@ -464,101 +474,109 @@ static void omap_mmc_write(void *=
opaque, hwaddr offset,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0q=
emu_log_mask(LOG_UNIMP,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;omap_mmc_wr: Big End=
ian not implemented\n&quot;);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>- =
=C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;dw !=3D 0 &amp;&amp; s-&gt;lines &lt; =
4)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;dw !=3D 0 &amp;&amp; s-&gt;lin=
es &lt; 4) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quo=
t;4-bit SD bus enabled\n&quot;);<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!s-&gt=
;enable)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0=
if (!s-&gt;enable) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0oma=
p_mmc_pseudo_reset(s);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0break;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x10:	/* MMC_ST=
AT */<br>+ =C2=A0 =C2=A0case 0x10: =C2=A0/* MMC_STAT */<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0s-&gt;status &amp;=3D ~value;<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0omap_mmc_interrupts_update(s);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0break;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x14:	/* MMC_IE */<br>+ =C2=
=A0 =C2=A0case 0x14: =C2=A0/* MMC_IE */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0s-&gt;mask =3D value &amp; 0x7fff;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
omap_mmc_interrupts_update(s);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<=
br>=C2=A0<br>- =C2=A0 =C2=A0case 0x18:	/* MMC_CTO */<br>+ =C2=A0 =C2=A0case=
 0x18: =C2=A0/* MMC_CTO */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;cto =
=3D value &amp; 0xff;<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;cto &gt; 0x=
fd &amp;&amp; s-&gt;rev &lt;=3D 1)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&g=
t;cto &gt; 0xfd &amp;&amp; s-&gt;rev &lt;=3D 1) {<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;MMC: CTO of 0xff and 0xfe cannot be=
 used!\n&quot;);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0break;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x1c:	/* MMC_DTO */<br=
>+ =C2=A0 =C2=A0case 0x1c: =C2=A0/* MMC_DTO */<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0s-&gt;dto =3D value &amp; 0xffff;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0break;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x20:	/* MMC_DATA */<br>+ =C2=
=A0 =C2=A0case 0x20: =C2=A0/* MMC_DATA */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0/* TODO: support 8-bit access */<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if (=
s-&gt;fifo_len =3D=3D 32)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;fifo_le=
n =3D=3D 32) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br=
>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;=
fifo[(s-&gt;fifo_start + s-&gt;fifo_len) &amp; 31] =3D value;<br>- =C2=A0 =
=C2=A0 =C2=A0 =C2=A0s-&gt;fifo_len ++;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&g=
t;fifo_len++;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0omap_mmc_transfer(s);<br=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0omap_mmc_fifolevel_update(s);<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0omap_mmc_interrupts_update(s);<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0break;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x24:	/* MMC_BL=
EN */<br>+ =C2=A0 =C2=A0case 0x24: =C2=A0/* MMC_BLEN */<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0s-&gt;blen =3D (value &amp; 0x07ff) + 1;<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;blen_counter =3D s-&gt;blen;<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0break;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x28:	/* MMC_N=
BLK */<br>+ =C2=A0 =C2=A0case 0x28: =C2=A0/* MMC_NBLK */<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0s-&gt;nblk =3D (value &amp; 0x07ff) + 1;<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;nblk_counter =3D s-&gt;nblk;<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0s-&gt;blen_counter =3D s-&gt;blen;<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0break;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x2c:	/* MMC_BU=
F */<br>+ =C2=A0 =C2=A0case 0x2c: =C2=A0/* MMC_BUF */<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0s-&gt;rx_dma =3D (value &gt;&gt; 15) &amp; 1;<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;af_level =3D (value &gt;&gt; 8) &amp; 0x1f=
;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;tx_dma =3D (value &gt;&gt; 7) =
&amp; 1;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;ae_level =3D value &amp=
; 0x1f;<br>=C2=A0<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;rx_dma)<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;rx_dma) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;status &amp;=3D 0xfbff;<br>- =C2=A0 =C2=A0 =
=C2=A0 =C2=A0if (s-&gt;tx_dma)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;tx_dma) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0s-&gt;status &amp;=3D 0xf7ff;<br>+ =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0omap_mmc_fifolevel_update(s);=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0omap_mmc_interrupts_update(s);<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0/* S=
PI, SDIO and TEST modes unimplemented */<br>- =C2=A0 =C2=A0case 0x30:	/* MM=
C_SPI (OMAP1 only) */<br>+ =C2=A0 =C2=A0case 0x30: =C2=A0/* MMC_SPI (OMAP1 =
only) */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>- =C2=A0 =C2=A0case=
 0x34:	/* MMC_SDIO */<br>+ =C2=A0 =C2=A0case 0x34: =C2=A0/* MMC_SDIO */<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;sdio =3D value &amp; (s-&gt;rev &gt=
;=3D 2 ? 0xfbf3 : 0x2020);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;cdet_=
wakeup =3D (value &gt;&gt; 9) &amp; 1;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0s-&gt;cdet_enable =3D (value &gt;&gt; 2) &amp; 1;<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0break;<br>- =C2=A0 =C2=A0case 0x38:	/* MMC_SYST */<br>+ =
=C2=A0 =C2=A0case 0x38: =C2=A0/* MMC_SYST */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0break;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x3c:	/* MMC_REV */<br>- =C2=
=A0 =C2=A0case 0x40:	/* MMC_RSP0 */<br>- =C2=A0 =C2=A0case 0x44:	/* MMC_RSP=
1 */<br>- =C2=A0 =C2=A0case 0x48:	/* MMC_RSP2 */<br>- =C2=A0 =C2=A0case 0x4=
c:	/* MMC_RSP3 */<br>- =C2=A0 =C2=A0case 0x50:	/* MMC_RSP4 */<br>- =C2=A0 =
=C2=A0case 0x54:	/* MMC_RSP5 */<br>- =C2=A0 =C2=A0case 0x58:	/* MMC_RSP6 */=
<br>- =C2=A0 =C2=A0case 0x5c:	/* MMC_RSP7 */<br>+ =C2=A0 =C2=A0case 0x3c: =
=C2=A0/* MMC_REV */<br>+ =C2=A0 =C2=A0case 0x40: =C2=A0/* MMC_RSP0 */<br>+ =
=C2=A0 =C2=A0case 0x44: =C2=A0/* MMC_RSP1 */<br>+ =C2=A0 =C2=A0case 0x48: =
=C2=A0/* MMC_RSP2 */<br>+ =C2=A0 =C2=A0case 0x4c: =C2=A0/* MMC_RSP3 */<br>+=
 =C2=A0 =C2=A0case 0x50: =C2=A0/* MMC_RSP4 */<br>+ =C2=A0 =C2=A0case 0x54: =
=C2=A0/* MMC_RSP5 */<br>+ =C2=A0 =C2=A0case 0x58: =C2=A0/* MMC_RSP6 */<br>+=
 =C2=A0 =C2=A0case 0x5c: =C2=A0/* MMC_RSP7 */<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0OMAP_RO_REG(offset);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<=
br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0/* OMAP2-specific */<br>- =C2=A0 =C2=A0cas=
e 0x60:	/* MMC_IOSR */<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if (value &amp; 0xf)=
<br>+ =C2=A0 =C2=A0case 0x60: =C2=A0/* MMC_IOSR */<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (value &amp; 0xf) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0printf(&quot;MMC: SDIO bits used!\n&quot;);<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>- =C2=A0 =C2=
=A0case 0x64:	/* MMC_SYSC */<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if (value &amp=
; (1 &lt;&lt; 2))					/* SRTS */<br>+ =C2=A0 =C2=A0case 0x64: =C2=A0/* MMC_=
SYSC */<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (value &amp; (1 &lt;&lt; 2)) { =
=C2=A0 =C2=A0 =C2=A0 /* SRTS */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0omap_mmc_reset(s);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>- =C2=A0 =C2=A0case 0x68:	/* MMC_SYSS =
*/<br>+ =C2=A0 =C2=A0case 0x68: =C2=A0/* MMC_SYSS */<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0OMAP_RO_REG(offset);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
break;<br>=C2=A0<br>@@ -601,7 +619,7 @@ struct omap_mmc_s *omap_mmc_init(hw=
addr base,<br>=C2=A0 =C2=A0 =C2=A0s-&gt;irq =3D irq;<br>=C2=A0 =C2=A0 =C2=
=A0s-&gt;dma =3D dma;<br>=C2=A0 =C2=A0 =C2=A0s-&gt;clk =3D clk;<br>- =C2=A0=
 =C2=A0s-&gt;lines =3D 1;	/* TODO: needs to be settable per-board */<br>+ =
=C2=A0 =C2=A0s-&gt;lines =3D 1; /* TODO: needs to be settable per-board */<=
br>=C2=A0 =C2=A0 =C2=A0s-&gt;rev =3D 1;<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0me=
mory_region_init_io(&amp;s-&gt;iomem, NULL, &amp;omap_mmc_ops, s, &quot;oma=
p.mmc&quot;, 0x800);<br>diff --git a/hw/sd/pxa2xx_mmci.c b/hw/sd/pxa2xx_mmc=
i.c<br>index 82529708c8..4fd17da95b 100644<br>--- a/hw/sd/pxa2xx_mmci.c<br>=
+++ b/hw/sd/pxa2xx_mmci.c<br>@@ -113,55 +113,55 @@ static const VMStateDesc=
ription vmstate_pxa2xx_mmci =3D {<br>=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0};<br>=
=C2=A0<br>-#define MMC_STRPCL	0x00	/* MMC Clock Start/Stop register */<br>-=
#define MMC_STAT	0x04	/* MMC Status register */<br>-#define MMC_CLKRT	0x08	=
/* MMC Clock Rate register */<br>-#define MMC_SPI		0x0c	/* MMC SPI Mode reg=
ister */<br>-#define MMC_CMDAT	0x10	/* MMC Command/Data register */<br>-#de=
fine MMC_RESTO	0x14	/* MMC Response Time-Out register */<br>-#define MMC_RD=
TO	0x18	/* MMC Read Time-Out register */<br>-#define MMC_BLKLEN	0x1c	/* MMC=
 Block Length register */<br>-#define MMC_NUMBLK	0x20	/* MMC Number of Bloc=
ks register */<br>-#define MMC_PRTBUF	0x24	/* MMC Buffer Partly Full regist=
er */<br>-#define MMC_I_MASK	0x28	/* MMC Interrupt Mask register */<br>-#de=
fine MMC_I_REG	0x2c	/* MMC Interrupt Request register */<br>-#define MMC_CM=
D		0x30	/* MMC Command register */<br>-#define MMC_ARGH	0x34	/* MMC Argumen=
t High register */<br>-#define MMC_ARGL	0x38	/* MMC Argument Low register *=
/<br>-#define MMC_RES		0x3c	/* MMC Response FIFO */<br>-#define MMC_RXFIFO	=
0x40	/* MMC Receive FIFO */<br>-#define MMC_TXFIFO	0x44	/* MMC Transmit FIF=
O */<br>-#define MMC_RDWAIT	0x48	/* MMC RD_WAIT register */<br>-#define MMC=
_BLKS_REM	0x4c	/* MMC Blocks Remaining register */<br>+#define MMC_STRPCL =
=C2=A0 =C2=A00x00 =C2=A0/* MMC Clock Start/Stop register */<br>+#define MMC=
_STAT =C2=A0 =C2=A0 =C2=A00x04 =C2=A0/* MMC Status register */<br>+#define =
MMC_CLKRT =C2=A0 =C2=A0 0x08 =C2=A0/* MMC Clock Rate register */<br>+#defin=
e MMC_SPI =C2=A0 =C2=A0 =C2=A0 0x0c =C2=A0/* MMC SPI Mode register */<br>+#=
define MMC_CMDAT =C2=A0 =C2=A0 0x10 =C2=A0/* MMC Command/Data register */<b=
r>+#define MMC_RESTO =C2=A0 =C2=A0 0x14 =C2=A0/* MMC Response Time-Out regi=
ster */<br>+#define MMC_RDTO =C2=A0 =C2=A0 =C2=A00x18 =C2=A0/* MMC Read Tim=
e-Out register */<br>+#define MMC_BLKLEN =C2=A0 =C2=A00x1c =C2=A0/* MMC Blo=
ck Length register */<br>+#define MMC_NUMBLK =C2=A0 =C2=A00x20 =C2=A0/* MMC=
 Number of Blocks register */<br>+#define MMC_PRTBUF =C2=A0 =C2=A00x24 =C2=
=A0/* MMC Buffer Partly Full register */<br>+#define MMC_I_MASK =C2=A0 =C2=
=A00x28 =C2=A0/* MMC Interrupt Mask register */<br>+#define MMC_I_REG =C2=
=A0 =C2=A0 0x2c =C2=A0/* MMC Interrupt Request register */<br>+#define MMC_=
CMD =C2=A0 =C2=A0 =C2=A0 0x30 =C2=A0/* MMC Command register */<br>+#define =
MMC_ARGH =C2=A0 =C2=A0 =C2=A00x34 =C2=A0/* MMC Argument High register */<br=
>+#define MMC_ARGL =C2=A0 =C2=A0 =C2=A00x38 =C2=A0/* MMC Argument Low regis=
ter */<br>+#define MMC_RES =C2=A0 =C2=A0 =C2=A0 0x3c =C2=A0/* MMC Response =
FIFO */<br>+#define MMC_RXFIFO =C2=A0 =C2=A00x40 =C2=A0/* MMC Receive FIFO =
*/<br>+#define MMC_TXFIFO =C2=A0 =C2=A00x44 =C2=A0/* MMC Transmit FIFO */<b=
r>+#define MMC_RDWAIT =C2=A0 =C2=A00x48 =C2=A0/* MMC RD_WAIT register */<br=
>+#define MMC_BLKS_REM =C2=A00x4c =C2=A0/* MMC Blocks Remaining register */=
<br>=C2=A0<br>=C2=A0/* Bitfield masks */<br>-#define STRPCL_STOP_CLK	(1 &lt=
;&lt; 0)<br>-#define STRPCL_STRT_CLK	(1 &lt;&lt; 1)<br>-#define STAT_TOUT_R=
ES	(1 &lt;&lt; 1)<br>-#define STAT_CLK_EN	(1 &lt;&lt; 8)<br>-#define STAT_D=
ATA_DONE	(1 &lt;&lt; 11)<br>-#define STAT_PRG_DONE	(1 &lt;&lt; 12)<br>-#def=
ine STAT_END_CMDRES	(1 &lt;&lt; 13)<br>-#define SPI_SPI_MODE	(1 &lt;&lt; 0)=
<br>-#define CMDAT_RES_TYPE	(3 &lt;&lt; 0)<br>-#define CMDAT_DATA_EN	(1 &lt=
;&lt; 2)<br>-#define CMDAT_WR_RD	(1 &lt;&lt; 3)<br>-#define CMDAT_DMA_EN	(1=
 &lt;&lt; 7)<br>-#define CMDAT_STOP_TRAN	(1 &lt;&lt; 10)<br>-#define INT_DA=
TA_DONE	(1 &lt;&lt; 0)<br>-#define INT_PRG_DONE	(1 &lt;&lt; 1)<br>-#define =
INT_END_CMD	(1 &lt;&lt; 2)<br>-#define INT_STOP_CMD	(1 &lt;&lt; 3)<br>-#def=
ine INT_CLK_OFF	(1 &lt;&lt; 4)<br>-#define INT_RXFIFO_REQ	(1 &lt;&lt; 5)<br=
>-#define INT_TXFIFO_REQ	(1 &lt;&lt; 6)<br>-#define INT_TINT	(1 &lt;&lt; 7)=
<br>-#define INT_DAT_ERR	(1 &lt;&lt; 8)<br>-#define INT_RES_ERR	(1 &lt;&lt;=
 9)<br>-#define INT_RD_STALLED	(1 &lt;&lt; 10)<br>-#define INT_SDIO_INT	(1 =
&lt;&lt; 11)<br>-#define INT_SDIO_SACK	(1 &lt;&lt; 12)<br>-#define PRTBUF_P=
RT_BUF	(1 &lt;&lt; 0)<br>+#define STRPCL_STOP_CLK (1 &lt;&lt; 0)<br>+#defin=
e STRPCL_STRT_CLK (1 &lt;&lt; 1)<br>+#define STAT_TOUT_RES =C2=A0 (1 &lt;&l=
t; 1)<br>+#define STAT_CLK_EN =C2=A0 =C2=A0 (1 &lt;&lt; 8)<br>+#define STAT=
_DATA_DONE =C2=A0(1 &lt;&lt; 11)<br>+#define STAT_PRG_DONE =C2=A0 (1 &lt;&l=
t; 12)<br>+#define STAT_END_CMDRES (1 &lt;&lt; 13)<br>+#define SPI_SPI_MODE=
 =C2=A0 =C2=A0(1 &lt;&lt; 0)<br>+#define CMDAT_RES_TYPE =C2=A0(3 &lt;&lt; 0=
)<br>+#define CMDAT_DATA_EN =C2=A0 (1 &lt;&lt; 2)<br>+#define CMDAT_WR_RD =
=C2=A0 =C2=A0 (1 &lt;&lt; 3)<br>+#define CMDAT_DMA_EN =C2=A0 =C2=A0(1 &lt;&=
lt; 7)<br>+#define CMDAT_STOP_TRAN (1 &lt;&lt; 10)<br>+#define INT_DATA_DON=
E =C2=A0 (1 &lt;&lt; 0)<br>+#define INT_PRG_DONE =C2=A0 =C2=A0(1 &lt;&lt; 1=
)<br>+#define INT_END_CMD =C2=A0 =C2=A0 (1 &lt;&lt; 2)<br>+#define INT_STOP=
_CMD =C2=A0 =C2=A0(1 &lt;&lt; 3)<br>+#define INT_CLK_OFF =C2=A0 =C2=A0 (1 &=
lt;&lt; 4)<br>+#define INT_RXFIFO_REQ =C2=A0(1 &lt;&lt; 5)<br>+#define INT_=
TXFIFO_REQ =C2=A0(1 &lt;&lt; 6)<br>+#define INT_TINT =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(1 &lt;&lt; 7)<br>+#define INT_DAT_ERR =C2=A0 =C2=A0 (1 &lt;&lt; 8)<b=
r>+#define INT_RES_ERR =C2=A0 =C2=A0 (1 &lt;&lt; 9)<br>+#define INT_RD_STAL=
LED =C2=A0(1 &lt;&lt; 10)<br>+#define INT_SDIO_INT =C2=A0 =C2=A0(1 &lt;&lt;=
 11)<br>+#define INT_SDIO_SACK =C2=A0 (1 &lt;&lt; 12)<br>+#define PRTBUF_PR=
T_BUF =C2=A0(1 &lt;&lt; 0)<br>=C2=A0<br>=C2=A0/* Route internal interrupt l=
ines to the global IC and DMA */<br>=C2=A0static void pxa2xx_mmci_int_updat=
e(PXA2xxMMCIState *s)<br>@@ -179,23 +179,25 @@ static void pxa2xx_mmci_int_=
update(PXA2xxMMCIState *s)<br>=C2=A0<br>=C2=A0static void pxa2xx_mmci_fifo_=
update(PXA2xxMMCIState *s)<br>=C2=A0{<br>- =C2=A0 =C2=A0if (!s-&gt;active)<=
br>+ =C2=A0 =C2=A0if (!s-&gt;active) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0return;<br>+ =C2=A0 =C2=A0}<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0if (s-&gt;c=
mdat &amp; CMDAT_WR_RD) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0while (s-&gt=
;bytesleft &amp;&amp; s-&gt;tx_len) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0sdbus_write_byte(&amp;s-&gt;sdbus, s-&gt;tx_fifo[s-&gt;tx_sta=
rt++]);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;tx_start &=
amp;=3D 0x1f;<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;tx_len --=
;<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;bytesleft --;<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;tx_len--;<br>+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;bytesleft--;<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;bytesleft)<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;bytesleft) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;intreq |=3D INT_TXFIFO_REQ;<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0} else<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0while (s-&gt;bytesleft &amp;&amp; s-&gt;rx_len &lt; 32) {<br>-=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;rx_fifo[(s-&gt;rx_start + (=
s-&gt;rx_len ++)) &amp; 0x1f] =3D<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0s-&gt;rx_fifo[(s-&gt;rx_start + (s-&gt;rx_len++)) &amp; 0x1f] =3D<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sdbus_read_by=
te(&amp;s-&gt;sdbus);<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;b=
ytesleft --;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;bytesleft-=
-;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;intreq |=3D INT=
_RXFIFO_REQ;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0<br>@@ -226,44=
 +228,50 @@ static void pxa2xx_mmci_wakequeues(PXA2xxMMCIState *s)<br>=C2=
=A0<br>=C2=A0 =C2=A0 =C2=A0request.cmd =3D s-&gt;cmd;<br>=C2=A0 =C2=A0 =C2=
=A0request.arg =3D s-&gt;arg;<br>- =C2=A0 =C2=A0request.crc =3D 0;	/* FIXME=
 */<br>+ =C2=A0 =C2=A0request.crc =3D 0; =C2=A0/* FIXME */<br>=C2=A0<br>=C2=
=A0 =C2=A0 =C2=A0rsplen =3D sdbus_do_command(&amp;s-&gt;sdbus, &amp;request=
, response);<br>=C2=A0 =C2=A0 =C2=A0s-&gt;intreq |=3D INT_END_CMD;<br>=C2=
=A0<br>=C2=A0 =C2=A0 =C2=A0memset(s-&gt;resp_fifo, 0, sizeof(s-&gt;resp_fif=
o));<br>=C2=A0 =C2=A0 =C2=A0switch (s-&gt;cmdat &amp; CMDAT_RES_TYPE) {<br>=
-#define PXAMMCI_RESP(wd, value0, value1)	\<br>- =C2=A0 =C2=A0 =C2=A0 =C2=
=A0s-&gt;resp_fifo[(wd) + 0] |=3D (value0);	\<br>- =C2=A0 =C2=A0 =C2=A0 =C2=
=A0s-&gt;resp_fifo[(wd) + 1] |=3D (value1) &lt;&lt; 8;<br>- =C2=A0 =C2=A0ca=
se 0:	/* No response */<br>+#define PXAMMCI_RESP(wd, value0, value1) =C2=A0=
 =C2=A0\<br>+ =C2=A0 =C2=A0do { =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0\<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;resp_fifo[(wd) + 0] =3D (=
value0); =C2=A0\<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;resp_fifo[(wd) + 1] =
=3D (value1); =C2=A0\<br>+ =C2=A0 =C2=A0} while (0)<br>+ =C2=A0 =C2=A0case =
0: /* No response */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto complete;<br=
>=C2=A0<br>- =C2=A0 =C2=A0case 1:	/* R1, R4, R5 or R6 */<br>- =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (rsplen &lt; 4)<br>+ =C2=A0 =C2=A0case 1: /* R1, R4, R5 or=
 R6 */<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rsplen &lt; 4) {<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto timeout;<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto complete;<br>=C2=A0<b=
r>- =C2=A0 =C2=A0case 2:	/* R2 */<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rsple=
n &lt; 16)<br>+ =C2=A0 =C2=A0case 2: /* R2 */<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0if (rsplen &lt; 16) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0goto timeout;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0goto complete;<br>=C2=A0<br>- =C2=A0 =C2=A0case 3:	/* R3 */<br=
>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rsplen &lt; 4)<br>+ =C2=A0 =C2=A0case 3: =
/* R3 */<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rsplen &lt; 4) {<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto timeout;<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto complete;<br>=C2=A0<b=
r>=C2=A0 =C2=A0 =C2=A0complete:<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D =
0; rsplen &gt; 0; i ++, rsplen -=3D 2) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0fo=
r (i =3D 0; rsplen &gt; 0; i++, rsplen -=3D 2) {<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0PXAMMCI_RESP(i, response[i * 2], response[i * 2 =
+ 1]);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0s-&gt;status |=3D STAT_END_CMDRES;<br>=C2=A0<br>- =C2=A0 =C2=A0 =
=C2=A0 =C2=A0if (!(s-&gt;cmdat &amp; CMDAT_DATA_EN))<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (!(s-&gt;cmdat &amp; CMDAT_DATA_EN)) {<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;active =3D 0;<br>- =C2=A0 =C2=A0 =C2=A0 =
=C2=A0else<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;bytesleft =3D s-&gt;numblk * s-&gt;blklen=
;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0s-&gt;resp_len =3D 0;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;=
<br>@@ -333,7 +341,7 @@ static uint64_t pxa2xx_mmci_read(void *opaque, hwad=
dr offset, unsigned size)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0while (size-=
- &amp;&amp; s-&gt;rx_len) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0ret |=3D s-&gt;rx_fifo[s-&gt;rx_start++] &lt;&lt; (size &lt;&lt; 3);<=
br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;rx_start &amp;=3D =
0x1f;<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;rx_len --;<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;rx_len--;<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;intreq &am=
p;=3D ~INT_RXFIFO_REQ;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pxa2xx_mmci_fif=
o_update(s);<br>@@ -399,8 +407,9 @@ static void pxa2xx_mmci_write(void *opa=
que,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(value &amp; CMDAT_STOP_TRAN=
)) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;status &amp;=
=3D STAT_CLK_EN;<br>=C2=A0<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if=
 (s-&gt;status &amp; STAT_CLK_EN)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0if (s-&gt;status &amp; STAT_CLK_EN) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pxa2xx_mmci_wakequeues(s);<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<=
br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pxa2xx_mmci_int_update(s);<b=
r>@@ -451,7 +460,7 @@ static void pxa2xx_mmci_write(void *opaque,<br>=C2=A0=
<br>=C2=A0 =C2=A0 =C2=A0case MMC_TXFIFO:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0while (size-- &amp;&amp; s-&gt;tx_len &lt; 0x20)<br>- =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;tx_fifo[(s-&gt;tx_start + (s-&gt;tx_len ++)) =
&amp; 0x1f] =3D<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;tx_fifo=
[(s-&gt;tx_start + (s-&gt;tx_len++)) &amp; 0x1f] =3D<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(value &gt;&gt; =
(size &lt;&lt; 3)) &amp; 0xff;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;i=
ntreq &amp;=3D ~INT_TXFIFO_REQ;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pxa2xx=
_mmci_fifo_update(s);<br>diff --git a/hw/timer/omap_gptimer.c b/hw/timer/om=
ap_gptimer.c<br>index 34e6af7aff..078ce294eb 100644<br>--- a/hw/timer/omap_=
gptimer.c<br>+++ b/hw/timer/omap_gptimer.c<br>@@ -69,27 +69,29 @@ struct om=
ap_gp_timer_s {<br>=C2=A0 =C2=A0 =C2=A0uint32_t match_val;<br>=C2=A0 =C2=A0=
 =C2=A0int capt_num;<br>=C2=A0<br>- =C2=A0 =C2=A0uint16_t writeh;	/* LSB */=
<br>- =C2=A0 =C2=A0uint16_t readh;	/* MSB */<br>+ =C2=A0 =C2=A0uint16_t wri=
teh; =C2=A0/* LSB */<br>+ =C2=A0 =C2=A0uint16_t readh; =C2=A0 /* MSB */<br>=
=C2=A0};<br>=C2=A0<br>-#define GPT_TCAR_IT	(1 &lt;&lt; 2)<br>-#define GPT_O=
VF_IT	(1 &lt;&lt; 1)<br>-#define GPT_MAT_IT	(1 &lt;&lt; 0)<br>+#define GPT_=
TCAR_IT (1 &lt;&lt; 2)<br>+#define GPT_OVF_IT =C2=A0(1 &lt;&lt; 1)<br>+#def=
ine GPT_MAT_IT =C2=A0(1 &lt;&lt; 0)<br>=C2=A0<br>=C2=A0static inline void o=
map_gp_timer_intr(struct omap_gp_timer_s *timer, int it)<br>=C2=A0{<br>=C2=
=A0 =C2=A0 =C2=A0if (timer-&gt;it_ena &amp; it) {<br>- =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (!timer-&gt;status)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!timer-&g=
t;status) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_irq_rai=
se(timer-&gt;irq);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0timer-&gt;status |=3D it;<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0/* Or are the status bits set even when masked?<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 * i.e. is masking applied before or after the s=
tatus register? =C2=A0*/<br>=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0<br>- =C2=A0 =C2=
=A0if (timer-&gt;wu_ena &amp; it)<br>+ =C2=A0 =C2=A0if (timer-&gt;wu_ena &a=
mp; it) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_irq_pulse(timer-&gt;wku=
p);<br>+ =C2=A0 =C2=A0}<br>=C2=A0}<br>=C2=A0<br>=C2=A0static inline void om=
ap_gp_timer_out(struct omap_gp_timer_s *timer, int level)<br>@@ -108,10 +11=
0,11 @@ static inline uint32_t omap_gp_timer_read(struct omap_gp_timer_s *t=
imer)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0distance =3D qemu_clock_get_ns(Q=
EMU_CLOCK_VIRTUAL) - timer-&gt;time;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0d=
istance =3D muldiv64(distance, timer-&gt;rate, timer-&gt;ticks_per_sec);<br=
>=C2=A0<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if (distance &gt;=3D 0xffffffff - t=
imer-&gt;val)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (distance &gt;=3D 0xffffff=
ff - timer-&gt;val) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0re=
turn 0xffffffff;<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0} else {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0re=
turn timer-&gt;val + distance;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =
=C2=A0 =C2=A0} else<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return timer-&gt;v=
al;<br>=C2=A0}<br>@@ -148,13 +151,14 @@ static inline void omap_gp_timer_up=
date(struct omap_gp_timer_s *timer)<br>=C2=A0<br>=C2=A0static inline void o=
map_gp_timer_trigger(struct omap_gp_timer_s *timer)<br>=C2=A0{<br>- =C2=A0 =
=C2=A0if (timer-&gt;pt)<br>+ =C2=A0 =C2=A0if (timer-&gt;pt) {<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0/* TODO in overflow-and-match mode if the first eve=
nt to<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * occur is the match, don&#39;t=
 toggle. =C2=A0*/<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0omap_gp_timer_out(ti=
mer, !timer-&gt;out_val);<br>- =C2=A0 =C2=A0else<br>+ =C2=A0 =C2=A0} else {=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* TODO inverted pulse on timer-&gt;o=
ut_val =3D=3D 1? =C2=A0*/<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_irq_pul=
se(timer-&gt;out);<br>+ =C2=A0 =C2=A0}<br>=C2=A0}<br>=C2=A0<br>=C2=A0static=
 void omap_gp_timer_tick(void *opaque)<br>@@ -181,8 +185,9 @@ static void o=
map_gp_timer_match(void *opaque)<br>=C2=A0{<br>=C2=A0 =C2=A0 =C2=A0struct o=
map_gp_timer_s *timer =3D opaque;<br>=C2=A0<br>- =C2=A0 =C2=A0if (timer-&gt=
;trigger =3D=3D gpt_trigger_both)<br>+ =C2=A0 =C2=A0if (timer-&gt;trigger =
=3D=3D gpt_trigger_both) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0omap_gp_tim=
er_trigger(timer);<br>+ =C2=A0 =C2=A0}<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0oma=
p_gp_timer_intr(timer, GPT_MAT_IT);<br>=C2=A0}<br>@@ -212,8 +217,9 @@ stati=
c void omap_gp_timer_input(void *opaque, int line, int on)<br>=C2=A0 =C2=A0=
 =C2=A0if (s-&gt;inout &amp;&amp; trigger &amp;&amp; s-&gt;capt_num &lt; 2)=
 {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;capture_val[s-&gt;capt_num] =
=3D omap_gp_timer_read(s);<br>=C2=A0<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-=
&gt;capt2 =3D=3D s-&gt;capt_num ++)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&=
gt;capt2 =3D=3D s-&gt;capt_num++) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0omap_gp_timer_intr(s, GPT_TCAR_IT);<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0}<br>=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0}<br>=C2=A0<br>@@ -265,26 +271,26=
 @@ static uint32_t omap_gp_timer_readw(void *opaque, hwaddr addr)<br>=C2=
=A0 =C2=A0 =C2=A0struct omap_gp_timer_s *s =3D opaque;<br>=C2=A0<br>=C2=A0 =
=C2=A0 =C2=A0switch (addr) {<br>- =C2=A0 =C2=A0case 0x00:	/* TIDR */<br>+ =
=C2=A0 =C2=A0case 0x00: =C2=A0/* TIDR */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0return 0x21;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x10:	/* TIOCP_CFG */<br>+=
 =C2=A0 =C2=A0case 0x10: =C2=A0/* TIOCP_CFG */<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return s-&gt;config;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x14:	/* TI=
STAT */<br>+ =C2=A0 =C2=A0case 0x14: =C2=A0/* TISTAT */<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0/* ??? When&#39;s this bit reset? */<br>- =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return 1;						/* RESETDONE */<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0return 1; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* RESETDONE */<br>=C2=A0<b=
r>- =C2=A0 =C2=A0case 0x18:	/* TISR */<br>+ =C2=A0 =C2=A0case 0x18: =C2=A0/=
* TISR */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return s-&gt;status;<br>=C2=
=A0<br>- =C2=A0 =C2=A0case 0x1c:	/* TIER */<br>+ =C2=A0 =C2=A0case 0x1c: =
=C2=A0/* TIER */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return s-&gt;it_ena;<=
br>=C2=A0<br>- =C2=A0 =C2=A0case 0x20:	/* TWER */<br>+ =C2=A0 =C2=A0case 0x=
20: =C2=A0/* TWER */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return s-&gt;wu_e=
na;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x24:	/* TCLR */<br>+ =C2=A0 =C2=A0cas=
e 0x24: =C2=A0/* TCLR */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return (s-&gt=
;inout &lt;&lt; 14) |<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(s-&gt;capt2 &lt;&lt; 13) |<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(s-&gt;pt &lt;&lt; 12) |<br>@@ -297,28 +303,=
28 @@ static uint32_t omap_gp_timer_readw(void *opaque, hwaddr addr)<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(s-&gt;ar &lt;&l=
t; 1) |<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(s=
-&gt;st &lt;&lt; 0);<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x28:	/* TCRR */<br>+=
 =C2=A0 =C2=A0case 0x28: =C2=A0/* TCRR */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0return omap_gp_timer_read(s);<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x2c:	=
/* TLDR */<br>+ =C2=A0 =C2=A0case 0x2c: =C2=A0/* TLDR */<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0return s-&gt;load_val;<br>=C2=A0<br>- =C2=A0 =C2=A0case=
 0x30:	/* TTGR */<br>+ =C2=A0 =C2=A0case 0x30: =C2=A0/* TTGR */<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0xffffffff;<br>=C2=A0<br>- =C2=A0 =C2=A0c=
ase 0x34:	/* TWPS */<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0x00000000;	/* =
No posted writes pending. =C2=A0*/<br>+ =C2=A0 =C2=A0case 0x34: =C2=A0/* TW=
PS */<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0x00000000; =C2=A0/* No posted=
 writes pending. =C2=A0*/<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x38:	/* TMAR */=
<br>+ =C2=A0 =C2=A0case 0x38: =C2=A0/* TMAR */<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return s-&gt;match_val;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x3c:	/*=
 TCAR1 */<br>+ =C2=A0 =C2=A0case 0x3c: =C2=A0/* TCAR1 */<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0return s-&gt;capture_val[0];<br>=C2=A0<br>- =C2=A0 =C2=
=A0case 0x40:	/* TSICR */<br>+ =C2=A0 =C2=A0case 0x40: =C2=A0/* TSICR */<br=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return s-&gt;posted &lt;&lt; 2;<br>=C2=
=A0<br>- =C2=A0 =C2=A0case 0x44:	/* TCAR2 */<br>+ =C2=A0 =C2=A0case 0x44: =
=C2=A0/* TCAR2 */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return s-&gt;capture=
_val[1];<br>=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0<br>@@ -345,47 +351,54 @@ static=
 void omap_gp_timer_write(void *opaque, hwaddr addr, uint32_t value)<br>=C2=
=A0 =C2=A0 =C2=A0struct omap_gp_timer_s *s =3D opaque;<br>=C2=A0<br>=C2=A0 =
=C2=A0 =C2=A0switch (addr) {<br>- =C2=A0 =C2=A0case 0x00:	/* TIDR */<br>- =
=C2=A0 =C2=A0case 0x14:	/* TISTAT */<br>- =C2=A0 =C2=A0case 0x34:	/* TWPS *=
/<br>- =C2=A0 =C2=A0case 0x3c:	/* TCAR1 */<br>- =C2=A0 =C2=A0case 0x44:	/* =
TCAR2 */<br>+ =C2=A0 =C2=A0case 0x00: =C2=A0/* TIDR */<br>+ =C2=A0 =C2=A0ca=
se 0x14: =C2=A0/* TISTAT */<br>+ =C2=A0 =C2=A0case 0x34: =C2=A0/* TWPS */<b=
r>+ =C2=A0 =C2=A0case 0x3c: =C2=A0/* TCAR1 */<br>+ =C2=A0 =C2=A0case 0x44: =
=C2=A0/* TCAR2 */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OMAP_RO_REG(addr);<b=
r>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>=C2=A0<br>- =C2=A0 =C2=A0case=
 0x10:	/* TIOCP_CFG */<br>+ =C2=A0 =C2=A0case 0x10: =C2=A0/* TIOCP_CFG */<b=
r>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;config =3D value &amp; 0x33d;<br>=
- =C2=A0 =C2=A0 =C2=A0 =C2=A0if (((value &gt;&gt; 3) &amp; 3) =3D=3D 3)				=
/* IDLEMODE */<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (((value &gt;&gt; 3) &amp=
; 3) =3D=3D 3) { =C2=A0 =C2=A0 =C2=A0/* IDLEMODE */<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &quot;%s: illegal IDLEMODE valu=
e in TIOCP_CFG\n&quot;,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__func__);<br>- =C2=
=A0 =C2=A0 =C2=A0 =C2=A0if (value &amp; 2)						/* SOFTRESET */<br>+ =C2=A0=
 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (value &amp; 2) =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* SOFTRESET */<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0omap_gp_timer_reset(s);<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0break;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x18:	/* TISR *=
/<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if (value &amp; GPT_TCAR_IT)<br>+ =C2=A0 =
=C2=A0case 0x18: =C2=A0/* TISR */<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (value=
 &amp; GPT_TCAR_IT) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-=
&gt;capt_num =3D 0;<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;status &amp;&=
amp; !(s-&gt;status &amp;=3D ~value))<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0qemu_irq_lower(s-&gt;irq);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;status) {<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0s-&gt;status &amp;=3D ~value;<br>+ =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0if (!s-&gt;status) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_irq_lower(s-&gt;irq);<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x1c:	/*=
 TIER */<br>+ =C2=A0 =C2=A0case 0x1c: =C2=A0/* TIER */<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0s-&gt;it_ena =3D value &amp; 7;<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0break;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x20:	/* TWER */<br>+ =
=C2=A0 =C2=A0case 0x20: =C2=A0/* TWER */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0s-&gt;wu_ena =3D value &amp; 7;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bre=
ak;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x24:	/* TCLR */<br>+ =C2=A0 =C2=A0cas=
e 0x24: =C2=A0/* TCLR */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0omap_gp_timer=
_sync(s);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;inout =3D (value &gt;&=
gt; 14) &amp; 1;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;capt2 =3D (valu=
e &gt;&gt; 13) &amp; 1;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;pt =3D (=
value &gt;&gt; 12) &amp; 1;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;trig=
ger =3D (value &gt;&gt; 10) &amp; 3;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i=
f (s-&gt;capture =3D=3D gpt_capture_none &amp;&amp;<br>- =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0((value &=
gt;&gt; 8) &amp; 3) !=3D gpt_capture_none)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0((value &gt;&gt; 8)=
 &amp; 3) !=3D gpt_capture_none) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0s-&gt;capt_num =3D 0;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;capture =3D (value &gt;&gt; 8) &amp; 3=
;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;scpwm =3D (value &gt;&gt; 7) &=
amp; 1;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;ce =3D (value &gt;&gt; 6=
) &amp; 1;<br>@@ -399,39 +412,41 @@ static void omap_gp_timer_write(void *o=
paque, hwaddr addr, uint32_t value)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if=
 (!s-&gt;inout &amp;&amp; s-&gt;capture !=3D gpt_capture_none)<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &quot;%s: GP timer=
 pin must be an input &quot;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;for thi=
s capture mode\n&quot;, __func__);<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&g=
t;trigger =3D=3D gpt_trigger_none)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&g=
t;trigger =3D=3D gpt_trigger_none) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0omap_gp_timer_out(s, s-&gt;scpwm);<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0}<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* TODO: make sure this doesn&=
#39;t overflow 32-bits */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;ticks_=
per_sec =3D NANOSECONDS_PER_SECOND &lt;&lt; (s-&gt;pre ? s-&gt;ptv + 1 : 0)=
;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0omap_gp_timer_update(s);<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x28:	/*=
 TCRR */<br>+ =C2=A0 =C2=A0case 0x28: =C2=A0/* TCRR */<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0s-&gt;time =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;val =3D value;<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0omap_gp_timer_update(s);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0break;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x2c:	/* TLDR */<br>+ =C2=A0 =
=C2=A0case 0x2c: =C2=A0/* TLDR */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&g=
t;load_val =3D value;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>=C2=A0=
<br>- =C2=A0 =C2=A0case 0x30:	/* TTGR */<br>+ =C2=A0 =C2=A0case 0x30: =C2=
=A0/* TTGR */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;time =3D qemu_cloc=
k_get_ns(QEMU_CLOCK_VIRTUAL);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;va=
l =3D s-&gt;load_val;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0omap_gp_timer_up=
date(s);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>=C2=A0<br>- =C2=A0 =
=C2=A0case 0x38:	/* TMAR */<br>+ =C2=A0 =C2=A0case 0x38: =C2=A0/* TMAR */<b=
r>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0omap_gp_timer_sync(s);<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0s-&gt;match_val =3D value;<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0omap_gp_timer_update(s);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bre=
ak;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x40:	/* TSICR */<br>+ =C2=A0 =C2=A0ca=
se 0x40: =C2=A0/* TSICR */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;poste=
d =3D (value &gt;&gt; 2) &amp; 1;<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if (value=
 &amp; 2)	/* How much exactly are we supposed to reset? */<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0if (value &amp; 2) { /* How much exactly are we supposed t=
o reset? */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0omap_gp_time=
r_reset(s);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break;<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0default:<br>@@ -443,10 +4=
58,11 @@ static void omap_gp_timer_writeh(void *opaque, hwaddr addr, uint32=
_t value)<br>=C2=A0{<br>=C2=A0 =C2=A0 =C2=A0struct omap_gp_timer_s *s =3D o=
paque;<br>=C2=A0<br>- =C2=A0 =C2=A0if (addr &amp; 2)<br>+ =C2=A0 =C2=A0if (=
addr &amp; 2) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0omap_gp_timer_write(op=
aque, addr, (value &lt;&lt; 16) | s-&gt;writeh);<br>- =C2=A0 =C2=A0else<br>=
+ =C2=A0 =C2=A0} else {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;writeh =
=3D (uint16_t) value;<br>+ =C2=A0 =C2=A0}<br>=C2=A0}<br>=C2=A0<br>=C2=A0sta=
tic uint64_t omap_gp_timer_readfn(void *opaque, hwaddr addr,<br>diff --git =
a/hw/timer/omap_synctimer.c b/hw/timer/omap_synctimer.c<br>index d93a9344ed=
..645170c015 100644<br>--- a/hw/timer/omap_synctimer.c<br>+++ b/hw/timer/om=
ap_synctimer.c<br>@@ -27,7 +27,8 @@ struct omap_synctimer_s {<br>=C2=A0};<b=
r>=C2=A0<br>=C2=A0/* 32-kHz Sync Timer of the OMAP2 */<br>-static uint32_t =
omap_synctimer_read(struct omap_synctimer_s *s) {<br>+static uint32_t omap_=
synctimer_read(struct omap_synctimer_s *s)<br>+{<br>=C2=A0 =C2=A0 =C2=A0ret=
urn muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), 0x8000,<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NANOSECON=
DS_PER_SECOND);<br>=C2=A0}<br>@@ -42,10 +43,10 @@ static uint32_t omap_sync=
timer_readw(void *opaque, hwaddr addr)<br>=C2=A0 =C2=A0 =C2=A0struct omap_s=
ynctimer_s *s =3D opaque;<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0switch (addr) {<=
br>- =C2=A0 =C2=A0case 0x00:	/* 32KSYNCNT_REV */<br>+ =C2=A0 =C2=A0case 0x0=
0: =C2=A0/* 32KSYNCNT_REV */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0x=
21;<br>=C2=A0<br>- =C2=A0 =C2=A0case 0x10:	/* CR */<br>+ =C2=A0 =C2=A0case =
0x10: =C2=A0/* CR */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return omap_synct=
imer_read(s) - s-&gt;val;<br>=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0<br>diff --git =
a/hw/timer/pxa2xx_timer.c b/hw/timer/pxa2xx_timer.c<br>index 6479ab1a8b..04=
0668631e 100644<br>--- a/hw/timer/pxa2xx_timer.c<br>+++ b/hw/timer/pxa2xx_t=
imer.c<br>@@ -20,42 +20,42 @@<br>=C2=A0#include &quot;qom/object.h&quot;<br=
>=C2=A0#include &quot;sysemu/watchdog.h&quot;<br>=C2=A0<br>-#define OSMR0	0=
x00<br>-#define OSMR1	0x04<br>-#define OSMR2	0x08<br>-#define OSMR3	0x0c<br=
>-#define OSMR4	0x80<br>-#define OSMR5	0x84<br>-#define OSMR6	0x88<br>-#def=
ine OSMR7	0x8c<br>-#define OSMR8	0x90<br>-#define OSMR9	0x94<br>-#define OS=
MR10	0x98<br>-#define OSMR11	0x9c<br>-#define OSCR	0x10	/* OS Timer Count *=
/<br>-#define OSCR4	0x40<br>-#define OSCR5	0x44<br>-#define OSCR6	0x48<br>-=
#define OSCR7	0x4c<br>-#define OSCR8	0x50<br>-#define OSCR9	0x54<br>-#defin=
e OSCR10	0x58<br>-#define OSCR11	0x5c<br>-#define OSSR	0x14	/* Timer status=
 register */<br>-#define OWER	0x18<br>-#define OIER	0x1c	/* Interrupt enabl=
e register =C2=A03-0 to E3-E0 */<br>-#define OMCR4	0xc0	/* OS Match Control=
 registers */<br>-#define OMCR5	0xc4<br>-#define OMCR6	0xc8<br>-#define OMC=
R7	0xcc<br>-#define OMCR8	0xd0<br>-#define OMCR9	0xd4<br>-#define OMCR10	0x=
d8<br>-#define OMCR11	0xdc<br>-#define OSNR	0x20<br>-<br>-#define PXA25X_FR=
EQ	3686400	/* 3.6864 MHz */<br>-#define PXA27X_FREQ	3250000	/* 3.25 MHz */<=
br>+#define OSMR0 =C2=A0 0x00<br>+#define OSMR1 =C2=A0 0x04<br>+#define OSM=
R2 =C2=A0 0x08<br>+#define OSMR3 =C2=A0 0x0c<br>+#define OSMR4 =C2=A0 0x80<=
br>+#define OSMR5 =C2=A0 0x84<br>+#define OSMR6 =C2=A0 0x88<br>+#define OSM=
R7 =C2=A0 0x8c<br>+#define OSMR8 =C2=A0 0x90<br>+#define OSMR9 =C2=A0 0x94<=
br>+#define OSMR10 =C2=A00x98<br>+#define OSMR11 =C2=A00x9c<br>+#define OSC=
R =C2=A0 =C2=A00x10 =C2=A0/* OS Timer Count */<br>+#define OSCR4 =C2=A0 0x4=
0<br>+#define OSCR5 =C2=A0 0x44<br>+#define OSCR6 =C2=A0 0x48<br>+#define O=
SCR7 =C2=A0 0x4c<br>+#define OSCR8 =C2=A0 0x50<br>+#define OSCR9 =C2=A0 0x5=
4<br>+#define OSCR10 =C2=A00x58<br>+#define OSCR11 =C2=A00x5c<br>+#define O=
SSR =C2=A0 =C2=A00x14 =C2=A0/* Timer status register */<br>+#define OWER =
=C2=A0 =C2=A00x18<br>+#define OIER =C2=A0 =C2=A00x1c =C2=A0/* Interrupt ena=
ble register =C2=A03-0 to E3-E0 */<br>+#define OMCR4 =C2=A0 0xc0 =C2=A0/* O=
S Match Control registers */<br>+#define OMCR5 =C2=A0 0xc4<br>+#define OMCR=
6 =C2=A0 0xc8<br>+#define OMCR7 =C2=A0 0xcc<br>+#define OMCR8 =C2=A0 0xd0<b=
r>+#define OMCR9 =C2=A0 0xd4<br>+#define OMCR10 =C2=A00xd8<br>+#define OMCR=
11 =C2=A00xdc<br>+#define OSNR =C2=A0 =C2=A00x20<br>+<br>+#define PXA25X_FR=
EQ 3686400 /* 3.6864 MHz */<br>+#define PXA27X_FREQ 3250000 /* 3.25 MHz */<=
br>=C2=A0<br>=C2=A0static int pxa2xx_timer4_freq[8] =3D {<br>=C2=A0 =C2=A0 =
=C2=A0[0] =3D 0,<br>@@ -108,7 +108,7 @@ struct PXA2xxTimerInfo {<br>=C2=A0 =
=C2=A0 =C2=A0PXA2xxTimer4 tm4[8];<br>=C2=A0};<br>=C2=A0<br>-#define PXA2XX_=
TIMER_HAVE_TM4	0<br>+#define PXA2XX_TIMER_HAVE_TM4 0<br>=C2=A0<br>=C2=A0sta=
tic inline int pxa2xx_timer_has_tm4(PXA2xxTimerInfo *s)<br>=C2=A0{<br>@@ -1=
25,7 +125,7 @@ static void pxa2xx_timer_update(void *opaque, uint64_t now_q=
emu)<br>=C2=A0 =C2=A0 =C2=A0now_vm =3D s-&gt;clock +<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0muldiv64(now_qemu - s-&gt;lastload, s-&gt;fr=
eq, NANOSECONDS_PER_SECOND);<br>=C2=A0<br>- =C2=A0 =C2=A0for (i =3D 0; i &l=
t; 4; i ++) {<br>+ =C2=A0 =C2=A0for (i =3D 0; i &lt; 4; i++) {<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0new_qemu =3D now_qemu + muldiv64((uint32_t) (s-&=
gt;timer[i].value - now_vm),<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NANOSECONDS_PER_SECOND, s-&=
gt;freq);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0timer_mod(s-&gt;timer[i].qti=
mer, new_qemu);<br>@@ -141,10 +141,11 @@ static void pxa2xx_timer_update4(v=
oid *opaque, uint64_t now_qemu, int n)<br>=C2=A0 =C2=A0 =C2=A0int counter;<=
br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0assert(n &lt; ARRAY_SIZE(counters));<br>- =
=C2=A0 =C2=A0if (s-&gt;tm4[n].control &amp; (1 &lt;&lt; 7))<br>+ =C2=A0 =C2=
=A0if (s-&gt;tm4[n].control &amp; (1 &lt;&lt; 7)) {<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0counter =3D n;<br>- =C2=A0 =C2=A0else<br>+ =C2=A0 =C2=A0} els=
e {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0counter =3D counters[n];<br>+ =C2=
=A0 =C2=A0}<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0if (!s-&gt;tm4[counter].freq) =
{<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0timer_del(s-&gt;tm4[n].tm.qtimer);<b=
r>@@ -167,52 +168,71 @@ static uint64_t pxa2xx_timer_read(void *opaque, hwa=
ddr offset,<br>=C2=A0 =C2=A0 =C2=A0int tm =3D 0;<br>=C2=A0<br>=C2=A0 =C2=A0=
 =C2=A0switch (offset) {<br>- =C2=A0 =C2=A0case OSMR3: =C2=A0tm ++;<br>+ =
=C2=A0 =C2=A0case OSMR3:<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0tm++;<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0/* fall through */<br>- =C2=A0 =C2=A0case OSMR2:=
 =C2=A0tm ++;<br>+ =C2=A0 =C2=A0case OSMR2:<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0tm++;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* fall through */<br>- =C2=
=A0 =C2=A0case OSMR1: =C2=A0tm ++;<br>+ =C2=A0 =C2=A0case OSMR1:<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0tm++;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* fall =
through */<br>=C2=A0 =C2=A0 =C2=A0case OSMR0:<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return s-&gt;timer[tm].value;<br>- =C2=A0 =C2=A0case OSMR11: tm +=
+;<br>+ =C2=A0 =C2=A0case OSMR11:<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0tm++;<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* fall through */<br>- =C2=A0 =C2=A0case=
 OSMR10: tm ++;<br>+ =C2=A0 =C2=A0case OSMR10:<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0tm++;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* fall through */<br>- =
=C2=A0 =C2=A0case OSMR9: =C2=A0tm ++;<br>+ =C2=A0 =C2=A0case OSMR9:<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0tm++;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* fa=
ll through */<br>- =C2=A0 =C2=A0case OSMR8: =C2=A0tm ++;<br>+ =C2=A0 =C2=A0=
case OSMR8:<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0tm++;<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0/* fall through */<br>- =C2=A0 =C2=A0case OSMR7: =C2=A0tm ++;<=
br>+ =C2=A0 =C2=A0case OSMR7:<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0tm++;<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* fall through */<br>- =C2=A0 =C2=A0case OS=
MR6: =C2=A0tm ++;<br>+ =C2=A0 =C2=A0case OSMR6:<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0tm++;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* fall through */<br>- =
=C2=A0 =C2=A0case OSMR5: =C2=A0tm ++;<br>+ =C2=A0 =C2=A0case OSMR5:<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0tm++;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* fa=
ll through */<br>=C2=A0 =C2=A0 =C2=A0case OSMR4:<br>- =C2=A0 =C2=A0 =C2=A0 =
=C2=A0if (!pxa2xx_timer_has_tm4(s))<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!px=
a2xx_timer_has_tm4(s)) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0goto badreg;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return s-&gt;tm4[tm].tm.value;<br>=C2=A0 =C2=A0 =C2=A0case OSC=
R:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return s-&gt;clock + muldiv64(qemu_=
clock_get_ns(QEMU_CLOCK_VIRTUAL) -<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;lastload, s-&g=
t;freq, NANOSECONDS_PER_SECOND);<br>- =C2=A0 =C2=A0case OSCR11: tm ++;<br>+=
 =C2=A0 =C2=A0case OSCR11:<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0tm++;<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0/* fall through */<br>- =C2=A0 =C2=A0case OSCR10=
: tm ++;<br>+ =C2=A0 =C2=A0case OSCR10:<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0tm+=
+;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* fall through */<br>- =C2=A0 =C2=
=A0case OSCR9: =C2=A0tm ++;<br>+ =C2=A0 =C2=A0case OSCR9:<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0tm++;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* fall through=
 */<br>- =C2=A0 =C2=A0case OSCR8: =C2=A0tm ++;<br>+ =C2=A0 =C2=A0case OSCR8=
:<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0tm++;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0/* fall through */<br>- =C2=A0 =C2=A0case OSCR7: =C2=A0tm ++;<br>+ =C2=
=A0 =C2=A0case OSCR7:<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0tm++;<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0/* fall through */<br>- =C2=A0 =C2=A0case OSCR6: =
=C2=A0tm ++;<br>+ =C2=A0 =C2=A0case OSCR6:<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0=
tm++;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* fall through */<br>- =C2=A0 =
=C2=A0case OSCR5: =C2=A0tm ++;<br>+ =C2=A0 =C2=A0case OSCR5:<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0tm++;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* fall thro=
ugh */<br>=C2=A0 =C2=A0 =C2=A0case OSCR4:<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0i=
f (!pxa2xx_timer_has_tm4(s))<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!pxa2xx_ti=
mer_has_tm4(s)) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto b=
adreg;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0if ((tm =3D=3D 9 - 4 || tm =3D=3D 11 - 4) &amp;&amp; (s-&gt;tm=
4[tm].control &amp; (1 &lt;&lt; 9))) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0if (s-&gt;tm4[tm - 1].freq)<br>@@ -224,35 +244,44 @@ stati=
c uint64_t pxa2xx_timer_read(void *opaque, hwaddr offset,<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;snapshot =3D s-&gt;tm=
4[tm - 1].clock;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0<br>- =C2=
=A0 =C2=A0 =C2=A0 =C2=A0if (!s-&gt;tm4[tm].freq)<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0if (!s-&gt;tm4[tm].freq) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return s-&gt;tm4[tm].clock;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return s-&gt;tm4[tm].clock +<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0muldiv64(qemu_clock_get_ns(QEMU_CL=
OCK_VIRTUAL) -<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 s-&gt;tm4[tm].lastload, s-&gt;tm4[tm].freq,<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NANOS=
ECONDS_PER_SECOND);<br>=C2=A0 =C2=A0 =C2=A0case OIER:<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0return s-&gt;irq_enabled;<br>- =C2=A0 =C2=A0case OSSR:	/* =
Status register */<br>+ =C2=A0 =C2=A0case OSSR: =C2=A0/* Status register */=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return s-&gt;events;<br>=C2=A0 =C2=A0=
 =C2=A0case OWER:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return s-&gt;reset3;=
<br>- =C2=A0 =C2=A0case OMCR11: tm ++;<br>+ =C2=A0 =C2=A0case OMCR11:<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0tm++;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* fa=
ll through */<br>- =C2=A0 =C2=A0case OMCR10: tm ++;<br>+ =C2=A0 =C2=A0case =
OMCR10:<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0tm++;<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* fall through */<br>- =C2=A0 =C2=A0case OMCR9: =C2=A0tm ++;<br>=
+ =C2=A0 =C2=A0case OMCR9:<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0tm++;<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0/* fall through */<br>- =C2=A0 =C2=A0case OMCR8:=
 =C2=A0tm ++;<br>+ =C2=A0 =C2=A0case OMCR8:<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0tm++;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* fall through */<br>- =C2=
=A0 =C2=A0case OMCR7: =C2=A0tm ++;<br>+ =C2=A0 =C2=A0case OMCR7:<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0tm++;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* fall =
through */<br>- =C2=A0 =C2=A0case OMCR6: =C2=A0tm ++;<br>+ =C2=A0 =C2=A0cas=
e OMCR6:<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0tm++;<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* fall through */<br>- =C2=A0 =C2=A0case OMCR5: =C2=A0tm ++;<br>=
+ =C2=A0 =C2=A0case OMCR5:<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0tm++;<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0/* fall through */<br>=C2=A0 =C2=A0 =C2=A0case O=
MCR4:<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!pxa2xx_timer_has_tm4(s))<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!pxa2xx_timer_has_tm4(s)) {<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto badreg;<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0}<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return s-&gt;tm4[tm].control;<=
br>=C2=A0 =C2=A0 =C2=A0case OSNR:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retu=
rn s-&gt;snapshot;<br>@@ -277,33 +306,44 @@ static void pxa2xx_timer_write(=
void *opaque, hwaddr offset,<br>=C2=A0 =C2=A0 =C2=A0PXA2xxTimerInfo *s =3D =
(PXA2xxTimerInfo *) opaque;<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0switch (offset=
) {<br>- =C2=A0 =C2=A0case OSMR3: =C2=A0tm ++;<br>+ =C2=A0 =C2=A0case OSMR3=
:<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0tm++;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0/* fall through */<br>- =C2=A0 =C2=A0case OSMR2: =C2=A0tm ++;<br>+ =C2=
=A0 =C2=A0case OSMR2:<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0tm++;<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0/* fall through */<br>- =C2=A0 =C2=A0case OSMR1: =
=C2=A0tm ++;<br>+ =C2=A0 =C2=A0case OSMR1:<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0=
tm++;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* fall through */<br>=C2=A0 =C2=
=A0 =C2=A0case OSMR0:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;timer[tm].=
value =3D value;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pxa2xx_timer_update(s=
, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0break;<br>- =C2=A0 =C2=A0case OSMR11: tm ++;<br>+ =C2=A0 =C2=A0case O=
SMR11:<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0tm++;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0/* fall through */<br>- =C2=A0 =C2=A0case OSMR10: tm ++;<br>+ =C2=A0=
 =C2=A0case OSMR10:<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0tm++;<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0/* fall through */<br>- =C2=A0 =C2=A0case OSMR9: =C2=A0=
tm ++;<br>+ =C2=A0 =C2=A0case OSMR9:<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0tm++;<=
br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* fall through */<br>- =C2=A0 =C2=A0c=
ase OSMR8: =C2=A0tm ++;<br>+ =C2=A0 =C2=A0case OSMR8:<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0tm++;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* fall through */<=
br>- =C2=A0 =C2=A0case OSMR7: =C2=A0tm ++;<br>+ =C2=A0 =C2=A0case OSMR7:<br=
>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0tm++;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*=
 fall through */<br>- =C2=A0 =C2=A0case OSMR6: =C2=A0tm ++;<br>+ =C2=A0 =C2=
=A0case OSMR6:<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0tm++;<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0/* fall through */<br>- =C2=A0 =C2=A0case OSMR5: =C2=A0tm =
++;<br>+ =C2=A0 =C2=A0case OSMR5:<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0tm++;<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* fall through */<br>=C2=A0 =C2=A0 =C2=
=A0case OSMR4:<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!pxa2xx_timer_has_tm4(s)=
)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!pxa2xx_timer_has_tm4(s)) {<br>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto badreg;<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;tm4[tm].tm.value =
=3D value;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pxa2xx_timer_update4(s, qem=
u_clock_get_ns(QEMU_CLOCK_VIRTUAL), tm);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0break;<br>@@ -313,23 +353,31 @@ static void pxa2xx_timer_write(void *opa=
que, hwaddr offset,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;clock =3D va=
lue;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pxa2xx_timer_update(s, s-&gt;last=
load);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>- =C2=A0 =C2=A0case O=
SCR11: tm ++;<br>+ =C2=A0 =C2=A0case OSCR11:<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0tm++;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* fall through */<br>- =C2=
=A0 =C2=A0case OSCR10: tm ++;<br>+ =C2=A0 =C2=A0case OSCR10:<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0tm++;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* fall thro=
ugh */<br>- =C2=A0 =C2=A0case OSCR9: =C2=A0tm ++;<br>+ =C2=A0 =C2=A0case OS=
CR9:<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0tm++;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0/* fall through */<br>- =C2=A0 =C2=A0case OSCR8: =C2=A0tm ++;<br>+ =
=C2=A0 =C2=A0case OSCR8:<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0tm++;<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0/* fall through */<br>- =C2=A0 =C2=A0case OSCR7:=
 =C2=A0tm ++;<br>+ =C2=A0 =C2=A0case OSCR7:<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0tm++;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* fall through */<br>- =C2=
=A0 =C2=A0case OSCR6: =C2=A0tm ++;<br>+ =C2=A0 =C2=A0case OSCR6:<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0tm++;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* fall =
through */<br>- =C2=A0 =C2=A0case OSCR5: =C2=A0tm ++;<br>+ =C2=A0 =C2=A0cas=
e OSCR5:<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0tm++;<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* fall through */<br>=C2=A0 =C2=A0 =C2=A0case OSCR4:<br>- =C2=A0=
 =C2=A0 =C2=A0 =C2=A0if (!pxa2xx_timer_has_tm4(s))<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (!pxa2xx_timer_has_tm4(s)) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0goto badreg;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;tm4[tm].oldclock =3D s-&gt;tm4[tm].clo=
ck;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;tm4[tm].lastload =3D qemu_cl=
ock_get_ns(QEMU_CLOCK_VIRTUAL);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;=
tm4[tm].clock =3D value;<br>@@ -338,27 +386,33 @@ static void pxa2xx_timer_=
write(void *opaque, hwaddr offset,<br>=C2=A0 =C2=A0 =C2=A0case OIER:<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;irq_enabled =3D value &amp; 0xfff;<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>- =C2=A0 =C2=A0case OSSR:	/* St=
atus register */<br>+ =C2=A0 =C2=A0case OSSR: =C2=A0/* Status register */<b=
r>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0value &amp;=3D s-&gt;events;<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;events &amp;=3D ~value;<br>- =C2=A0 =C2=A0=
 =C2=A0 =C2=A0for (i =3D 0; i &lt; 4; i ++, value &gt;&gt;=3D 1)<br>- =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (value &amp; 1)<br>+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0for (i =3D 0; i &lt; 4; i++, value &gt;&gt;=3D 1)<br>+ =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (value &amp; 1) {<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_irq_lower(s-&gt;timer[=
i].irq);<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if (pxa2xx_timer_has_tm4(s) &amp;&=
amp; !(s-&gt;events &amp; 0xff0) &amp;&amp; value)<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (pxa2xx_timer_=
has_tm4(s) &amp;&amp; !(s-&gt;events &amp; 0xff0) &amp;&amp; value) {<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_irq_lower(s-&gt;irq4);=
<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bre=
ak;<br>- =C2=A0 =C2=A0case OWER:	/* XXX: Reset on OSMR3 match? */<br>+ =C2=
=A0 =C2=A0case OWER: =C2=A0/* XXX: Reset on OSMR3 match? */<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;reset3 =3D value;<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break;<br>- =C2=A0 =C2=A0case OMCR7: =C2=A0tm ++;<br>+ =C2=A0 =C2=
=A0case OMCR7:<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0tm++;<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0/* fall through */<br>- =C2=A0 =C2=A0case OMCR6: =C2=A0tm =
++;<br>+ =C2=A0 =C2=A0case OMCR6:<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0tm++;<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* fall through */<br>- =C2=A0 =C2=A0case=
 OMCR5: =C2=A0tm ++;<br>+ =C2=A0 =C2=A0case OMCR5:<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0tm++;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* fall through */<br>=
=C2=A0 =C2=A0 =C2=A0case OMCR4:<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!pxa2xx=
_timer_has_tm4(s))<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!pxa2xx_timer_has_tm=
4(s)) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto badreg;<br>=
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;t=
m4[tm].control =3D value &amp; 0x0ff;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
/* XXX Stop if running (shouldn&#39;t happen) */<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0if ((value &amp; (1 &lt;&lt; 7)) || tm =3D=3D 0)<br>@@ -368,15=
 +422,20 @@ static void pxa2xx_timer_write(void *opaque, hwaddr offset,<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pxa2xx_timer_update4(s, qem=
u_clock_get_ns(QEMU_CLOCK_VIRTUAL), tm);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0}<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>- =C2=A0 =C2=A0case OMC=
R11: tm ++;<br>+ =C2=A0 =C2=A0case OMCR11:<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0=
tm++;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* fall through */<br>- =C2=A0 =
=C2=A0case OMCR10: tm ++;<br>+ =C2=A0 =C2=A0case OMCR10:<br>+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0tm++;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* fall through */=
<br>- =C2=A0 =C2=A0case OMCR9: =C2=A0tm ++;<br>+ =C2=A0 =C2=A0case OMCR9:<b=
r>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0tm++;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/=
* fall through */<br>- =C2=A0 =C2=A0case OMCR8: =C2=A0tm +=3D 4;<br>- =C2=
=A0 =C2=A0 =C2=A0 =C2=A0if (!pxa2xx_timer_has_tm4(s))<br>+ =C2=A0 =C2=A0cas=
e OMCR8:<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0tm +=3D 4;<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (!pxa2xx_timer_has_tm4(s)) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0goto badreg;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;tm4[tm].control =3D value &amp; 0x3ff;=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* XXX Stop if running (shouldn&#39;t=
 happen) */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((value &amp; (1 &lt;&l=
t; 7)) || !(tm &amp; 1))<br>@@ -428,12 +487,15 @@ static void pxa2xx_timer_=
tick4(void *opaque)<br>=C2=A0 =C2=A0 =C2=A0PXA2xxTimerInfo *i =3D (PXA2xxTi=
merInfo *) t-&gt;<a href=3D"http://tm.info">tm.info</a>;<br>=C2=A0<br>=C2=
=A0 =C2=A0 =C2=A0pxa2xx_timer_tick(&amp;t-&gt;tm);<br>- =C2=A0 =C2=A0if (t-=
&gt;control &amp; (1 &lt;&lt; 3))<br>+ =C2=A0 =C2=A0if (t-&gt;control &amp;=
 (1 &lt;&lt; 3)) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0t-&gt;clock =3D 0;<=
br>- =C2=A0 =C2=A0if (t-&gt;control &amp; (1 &lt;&lt; 6))<br>+ =C2=A0 =C2=
=A0}<br>+ =C2=A0 =C2=A0if (t-&gt;control &amp; (1 &lt;&lt; 6)) {<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0pxa2xx_timer_update4(i, qemu_clock_get_ns(QEMU_C=
LOCK_VIRTUAL), t-&gt;tm.num - 4);<br>- =C2=A0 =C2=A0if (i-&gt;events &amp; =
0xff0)<br>+ =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0if (i-&gt;events &amp; 0xff0) =
{<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_irq_raise(i-&gt;irq4);<br>+ =C2=
=A0 =C2=A0}<br>=C2=A0}<br>=C2=A0<br>=C2=A0static int pxa25x_timer_post_load=
(void *opaque, int version_id)<br>@@ -446,8 +508,9 @@ static int pxa25x_tim=
er_post_load(void *opaque, int version_id)<br>=C2=A0 =C2=A0 =C2=A0pxa2xx_ti=
mer_update(s, now);<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0if (pxa2xx_timer_has_t=
m4(s))<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; 8; i ++)<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; 8; i++) {<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pxa2xx_timer_update4(s, now, i);<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0return 0;<br>=C2=
=A0}<br>@@ -474,7 +537,7 @@ static void pxa2xx_timer_realize(DeviceState *d=
ev, Error **errp)<br>=C2=A0 =C2=A0 =C2=A0SysBusDevice *sbd =3D SYS_BUS_DEVI=
CE(dev);<br>=C2=A0 =C2=A0 =C2=A0int i;<br>=C2=A0<br>- =C2=A0 =C2=A0for (i =
=3D 0; i &lt; 4; i ++) {<br>+ =C2=A0 =C2=A0for (i =3D 0; i &lt; 4; i++) {<b=
r>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;timer[i].value =3D 0;<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_init_irq(sbd, &amp;s-&gt;timer[i].irq);<b=
r>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;timer[i].info =3D s;<br>@@ -486,7=
 +549,7 @@ static void pxa2xx_timer_realize(DeviceState *dev, Error **errp)=
<br>=C2=A0 =C2=A0 =C2=A0if (s-&gt;flags &amp; (1 &lt;&lt; PXA2XX_TIMER_HAVE=
_TM4)) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_init_irq(sbd, &amp;s-&=
gt;irq4);<br>=C2=A0<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; 8;=
 i ++) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; 8; i++) {<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;tm4[i].tm.value =3D 0=
;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;tm4[i].<a href=
=3D"http://tm.info">tm.info</a> =3D s;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0s-&gt;tm4[i].tm.num =3D i + 4;<br>diff --git a/include/hw/=
arm/pxa.h b/include/hw/arm/pxa.h<br>index 4c6caee113..9c6d434a4b 100644<br>=
--- a/include/hw/arm/pxa.h<br>+++ b/include/hw/arm/pxa.h<br>@@ -16,57 +16,5=
7 @@<br>=C2=A0#include &quot;qom/object.h&quot;<br>=C2=A0<br>=C2=A0/* Inter=
rupt numbers */<br>-# define PXA2XX_PIC_SSP3	0<br>-# define PXA2XX_PIC_USBH=
2	2<br>-# define PXA2XX_PIC_USBH1	3<br>-# define PXA2XX_PIC_KEYPAD	4<br>-# =
define PXA2XX_PIC_PWRI2C	6<br>-# define PXA25X_PIC_HWUART	7<br>-# define PX=
A27X_PIC_OST_4_11	7<br>-# define PXA2XX_PIC_GPIO_0	8<br>-# define PXA2XX_PI=
C_GPIO_1	9<br>-# define PXA2XX_PIC_GPIO_X	10<br>-# define PXA2XX_PIC_I2S 	1=
3<br>-# define PXA26X_PIC_ASSP	15<br>-# define PXA25X_PIC_NSSP	16<br>-# def=
ine PXA27X_PIC_SSP2	16<br>-# define PXA2XX_PIC_LCD		17<br>-# define PXA2XX_=
PIC_I2C		18<br>-# define PXA2XX_PIC_ICP		19<br>-# define PXA2XX_PIC_STUART	=
20<br>-# define PXA2XX_PIC_BTUART	21<br>-# define PXA2XX_PIC_FFUART	22<br>-=
# define PXA2XX_PIC_MMC		23<br>-# define PXA2XX_PIC_SSP		24<br>-# define PX=
A2XX_PIC_DMA		25<br>-# define PXA2XX_PIC_OST_0	26<br>-# define PXA2XX_PIC_R=
TC1HZ	30<br>-# define PXA2XX_PIC_RTCALARM	31<br>+# define PXA2XX_PIC_SSP3 =
=C2=A0 =C2=A0 =C2=A0 =C2=A00<br>+# define PXA2XX_PIC_USBH2 =C2=A0 =C2=A0 =
=C2=A0 2<br>+# define PXA2XX_PIC_USBH1 =C2=A0 =C2=A0 =C2=A0 3<br>+# define =
PXA2XX_PIC_KEYPAD =C2=A0 =C2=A0 =C2=A04<br>+# define PXA2XX_PIC_PWRI2C =C2=
=A0 =C2=A0 =C2=A06<br>+# define PXA25X_PIC_HWUART =C2=A0 =C2=A0 =C2=A07<br>=
+# define PXA27X_PIC_OST_4_11 =C2=A0 =C2=A07<br>+# define PXA2XX_PIC_GPIO_0=
 =C2=A0 =C2=A0 =C2=A08<br>+# define PXA2XX_PIC_GPIO_1 =C2=A0 =C2=A0 =C2=A09=
<br>+# define PXA2XX_PIC_GPIO_X =C2=A0 =C2=A0 =C2=A010<br>+# define PXA2XX_=
PIC_I2S =C2=A0 =C2=A0 =C2=A0 =C2=A0 13<br>+# define PXA26X_PIC_ASSP =C2=A0 =
=C2=A0 =C2=A0 =C2=A015<br>+# define PXA25X_PIC_NSSP =C2=A0 =C2=A0 =C2=A0 =
=C2=A016<br>+# define PXA27X_PIC_SSP2 =C2=A0 =C2=A0 =C2=A0 =C2=A016<br>+# d=
efine PXA2XX_PIC_LCD =C2=A0 =C2=A0 =C2=A0 =C2=A0 17<br>+# define PXA2XX_PIC=
_I2C =C2=A0 =C2=A0 =C2=A0 =C2=A0 18<br>+# define PXA2XX_PIC_ICP =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 19<br>+# define PXA2XX_PIC_STUART =C2=A0 =C2=A0 =C2=A020<=
br>+# define PXA2XX_PIC_BTUART =C2=A0 =C2=A0 =C2=A021<br>+# define PXA2XX_P=
IC_FFUART =C2=A0 =C2=A0 =C2=A022<br>+# define PXA2XX_PIC_MMC =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 23<br>+# define PXA2XX_PIC_SSP =C2=A0 =C2=A0 =C2=A0 =C2=A0 24=
<br>+# define PXA2XX_PIC_DMA =C2=A0 =C2=A0 =C2=A0 =C2=A0 25<br>+# define PX=
A2XX_PIC_OST_0 =C2=A0 =C2=A0 =C2=A0 26<br>+# define PXA2XX_PIC_RTC1HZ =C2=
=A0 =C2=A0 =C2=A030<br>+# define PXA2XX_PIC_RTCALARM =C2=A0 =C2=A031<br>=C2=
=A0<br>=C2=A0/* DMA requests */<br>-# define PXA2XX_RX_RQ_I2S	2<br>-# defin=
e PXA2XX_TX_RQ_I2S	3<br>-# define PXA2XX_RX_RQ_BTUART	4<br>-# define PXA2XX=
_TX_RQ_BTUART	5<br>-# define PXA2XX_RX_RQ_FFUART	6<br>-# define PXA2XX_TX_R=
Q_FFUART	7<br>-# define PXA2XX_RX_RQ_SSP1	13<br>-# define PXA2XX_TX_RQ_SSP1=
	14<br>-# define PXA2XX_RX_RQ_SSP2	15<br>-# define PXA2XX_TX_RQ_SSP2	16<br>=
-# define PXA2XX_RX_RQ_ICP	17<br>-# define PXA2XX_TX_RQ_ICP	18<br>-# define=
 PXA2XX_RX_RQ_STUART	19<br>-# define PXA2XX_TX_RQ_STUART	20<br>-# define PX=
A2XX_RX_RQ_MMCI	21<br>-# define PXA2XX_TX_RQ_MMCI	22<br>-# define PXA2XX_US=
B_RQ(x)	((x) + 24)<br>-# define PXA2XX_RX_RQ_SSP3	66<br>-# define PXA2XX_TX=
_RQ_SSP3	67<br>-<br>-# define PXA2XX_SDRAM_BASE	0xa0000000<br>-# define PXA=
2XX_INTERNAL_BASE	0x5c000000<br>-# define PXA2XX_INTERNAL_SIZE	0x40000<br>+=
# define PXA2XX_RX_RQ_I2S =C2=A0 =C2=A0 =C2=A0 2<br>+# define PXA2XX_TX_RQ_=
I2S =C2=A0 =C2=A0 =C2=A0 3<br>+# define PXA2XX_RX_RQ_BTUART =C2=A0 =C2=A04<=
br>+# define PXA2XX_TX_RQ_BTUART =C2=A0 =C2=A05<br>+# define PXA2XX_RX_RQ_F=
FUART =C2=A0 =C2=A06<br>+# define PXA2XX_TX_RQ_FFUART =C2=A0 =C2=A07<br>+# =
define PXA2XX_RX_RQ_SSP1 =C2=A0 =C2=A0 =C2=A013<br>+# define PXA2XX_TX_RQ_S=
SP1 =C2=A0 =C2=A0 =C2=A014<br>+# define PXA2XX_RX_RQ_SSP2 =C2=A0 =C2=A0 =C2=
=A015<br>+# define PXA2XX_TX_RQ_SSP2 =C2=A0 =C2=A0 =C2=A016<br>+# define PX=
A2XX_RX_RQ_ICP =C2=A0 =C2=A0 =C2=A0 17<br>+# define PXA2XX_TX_RQ_ICP =C2=A0=
 =C2=A0 =C2=A0 18<br>+# define PXA2XX_RX_RQ_STUART =C2=A0 =C2=A019<br>+# de=
fine PXA2XX_TX_RQ_STUART =C2=A0 =C2=A020<br>+# define PXA2XX_RX_RQ_MMCI =C2=
=A0 =C2=A0 =C2=A021<br>+# define PXA2XX_TX_RQ_MMCI =C2=A0 =C2=A0 =C2=A022<b=
r>+# define PXA2XX_USB_RQ(x) =C2=A0 =C2=A0 =C2=A0 ((x) + 24)<br>+# define P=
XA2XX_RX_RQ_SSP3 =C2=A0 =C2=A0 =C2=A066<br>+# define PXA2XX_TX_RQ_SSP3 =C2=
=A0 =C2=A0 =C2=A067<br>+<br>+# define PXA2XX_SDRAM_BASE =C2=A0 =C2=A0 =C2=
=A00xa0000000<br>+# define PXA2XX_INTERNAL_BASE =C2=A0 0x5c000000<br>+# def=
ine PXA2XX_INTERNAL_SIZE =C2=A0 0x40000<br>=C2=A0<br>=C2=A0/* pxa2xx_pic.c =
*/<br>=C2=A0DeviceState *pxa2xx_pic_init(hwaddr base, ARMCPU *cpu);<br>@@ -=
189,7 +189,7 @@ struct PXA2xxI2SState {<br>=C2=A0 =C2=A0 =C2=A0uint32_t fif=
o[16];<br>=C2=A0};<br>=C2=A0<br>-# define PA_FMT			&quot;0x%08lx&quot;<br>+=
# define PA_FMT =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &qu=
ot;0x%08lx&quot;<br>=C2=A0<br>=C2=A0PXA2xxState *pxa270_init(unsigned int s=
dram_size, const char *revision);<br>=C2=A0PXA2xxState *pxa255_init(unsigne=
d int sdram_size);<br>diff --git a/include/hw/arm/sharpsl.h b/include/hw/ar=
m/sharpsl.h<br>index e986b28c52..7e5e7ca60b 100644<br>--- a/include/hw/arm/=
sharpsl.h<br>+++ b/include/hw/arm/sharpsl.h<br>@@ -11,7 +11,7 @@<br>=C2=A0<=
br>=C2=A0/* zaurus.c */<br>=C2=A0<br>-#define SL_PXA_PARAM_BASE	0xa0000a00<=
br>+#define SL_PXA_PARAM_BASE =C2=A0 =C2=A0 =C2=A0 0xa0000a00<br>=C2=A0void=
 sl_bootparam_write(hwaddr ptr);<br>=C2=A0<br>=C2=A0#endif<br>diff --git a/=
include/hw/arm/soc_dma.h b/include/hw/arm/soc_dma.h<br>index e93a7499a8..bc=
db91425a 100644<br>--- a/include/hw/arm/soc_dma.h<br>+++ b/include/hw/arm/s=
oc_dma.h<br>@@ -54,7 +54,7 @@ struct soc_dma_ch_s {<br>=C2=A0 =C2=A0 =C2=A0=
int bytes;<br>=C2=A0 =C2=A0 =C2=A0/* Initialised by the DMA module, call so=
c_dma_ch_update after writing. =C2=A0*/<br>=C2=A0 =C2=A0 =C2=A0enum soc_dma=
_access_type type[2];<br>- =C2=A0 =C2=A0hwaddr vaddr[2];	/* Updated by .tra=
nsfer_fn(). =C2=A0*/<br>+ =C2=A0 =C2=A0hwaddr vaddr[2]; =C2=A0 =C2=A0/* Upd=
ated by .transfer_fn(). =C2=A0*/<br>=C2=A0 =C2=A0 =C2=A0/* Private */<br>=
=C2=A0 =C2=A0 =C2=A0void *paddr[2];<br>=C2=A0 =C2=A0 =C2=A0soc_dma_io_t io_=
fn[2];<br>@@ -70,7 +70,7 @@ struct soc_dma_ch_s {<br>=C2=A0struct soc_dma_s=
 {<br>=C2=A0 =C2=A0 =C2=A0/* Following fields are set by the SoC DMA module=
 and can be used<br>=C2=A0 =C2=A0 =C2=A0 * by anybody. =C2=A0*/<br>- =C2=A0=
 =C2=A0uint64_t drqbmp;	/* Is zeroed by soc_dma_reset() */<br>+ =C2=A0 =C2=
=A0uint64_t drqbmp; =C2=A0 =C2=A0/* Is zeroed by soc_dma_reset() */<br>=C2=
=A0 =C2=A0 =C2=A0qemu_irq *drq;<br>=C2=A0 =C2=A0 =C2=A0void *opaque;<br>=C2=
=A0 =C2=A0 =C2=A0int64_t freq;<br>diff --git a/tcg/arm/tcg-target.h b/tcg/a=
rm/tcg-target.h<br>index a43875cb09..9a07372fd9 100644<br>--- a/tcg/arm/tcg=
-target.h<br>+++ b/tcg/arm/tcg-target.h<br>@@ -86,8 +86,8 @@ extern bool us=
e_neon_instructions;<br>=C2=A0#endif<br>=C2=A0<br>=C2=A0/* used for functio=
n call generation */<br>-#define TCG_TARGET_STACK_ALIGN		8<br>-#define TCG_=
TARGET_CALL_STACK_OFFSET	0<br>+#define TCG_TARGET_STACK_ALIGN =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A08<br>+#define TCG_TARGET_CALL_STACK_OFFSET =C2=A0 =C2=
=A00<br>=C2=A0#define TCG_TARGET_CALL_ARG_I32 =C2=A0 =C2=A0 =C2=A0 =C2=A0 T=
CG_CALL_ARG_NORMAL<br>=C2=A0#define TCG_TARGET_CALL_ARG_I64 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 TCG_CALL_ARG_EVEN<br>=C2=A0#define TCG_TARGET_CALL_ARG_I128 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0TCG_CALL_ARG_EVEN<br>-- <br>2.43.0<br><br><br></=
div>

--000000000000c6e3b70617c3118c--

