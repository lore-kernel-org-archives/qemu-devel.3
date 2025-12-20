Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FDD3E668B4
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Dec 2025 18:33:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vX1l3-0000BG-Jj; Sat, 20 Dec 2025 13:32:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1vX1l2-0000An-An
 for qemu-devel@nongnu.org; Sat, 20 Dec 2025 13:32:48 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1vX1l0-0004rJ-81
 for qemu-devel@nongnu.org; Sat, 20 Dec 2025 13:32:47 -0500
Received: by mail-pf1-x443.google.com with SMTP id
 d2e1a72fcca58-7b8bbf16b71so2833671b3a.2
 for <qemu-devel@nongnu.org>; Sat, 20 Dec 2025 10:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766255564; x=1766860364; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=J+n2ZughT0zSXLJwccGy2g9RlwSfQF3EDe+y7l4Pz2g=;
 b=bJK4G38fOen80XqCWBaqoPEZKxvJZxYmk0JRVs89tkwkxxIHkDroVLfD2YfAA9l+Op
 NKThgkH4zkeuw/7p5h9LXPb38mBJBi2VIhYlIziofTa9ulajEug2rF29qeP684QAkUdO
 IUmjl7zsyvhlvTvYpYhKyMZRxx3oY9AXPtRz7vmnER7lUJfWd/J4fBWpWacQDSQJyW2H
 MYTX4EcRRG5soPilYyX/wsCpIBHZAUmWpWNZ38qBSDocjyM7qu1X0WcMb3ZDMf8xqiDW
 3fIOSTWgiZ6GTR9s2QWydNK+lNnvvd0p/9eokD8iwzhAKlKo1s+LiQQelTPGDTbKqqwi
 mG6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766255564; x=1766860364;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J+n2ZughT0zSXLJwccGy2g9RlwSfQF3EDe+y7l4Pz2g=;
 b=GU+vzXVKoQNIJLhaQ0N10Pm5fkmf4kt2+X04XHlgsR7Xkals7jOv5BajyG3mM2Oy7l
 7Dd2pyu38TVLx9LuNMoSn7iwHqM1QdD68JxbhDTIyKLNlvuFfYn36kQCPKj2eQR2xHp4
 8+8nbePWR9GCjuqbR6eN73MxiOcI7jYJTayP+B+cqdHvQlAIo2oYfy4VVCKiKlbUdHGh
 G0xwcCD4beUmMxNHl1O5WLowGgONUWh7kFAeAYXhfFPSnoumsJxp9Ywbes8w6hRcAtOw
 ubu+62rvQnkXoTxHICuL21gwTT/815JOklKWlhB6w5OkgrF/AcLlZ6sWx4RNFQlrm6zH
 TlfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnQyhmga62KpdjfIWdyLSBh87D2KDTNOXuSDXA/9BzdxfQzZhTJS6iqtwZR2DPFyGg4NHGs4TrLWav@nongnu.org
X-Gm-Message-State: AOJu0Yz18Wn5+HsDvHxFObWRf/v2QcOcGCpHd7fnU2IdK2yta1l3krpo
 LB7DN1sffQ3tx0cnXsUDPYufVpY2TDxEeDV7ZBT9eNdXDjXAQknOtm+2
X-Gm-Gg: AY/fxX67GmlXwPEy9H7K6joOgftUaktALLD8IiwUIaqizfMz7Bkfub1YI27Mk3R7Noi
 wIQrF+IKehUpeYI9+gZsIvUl2HOOrSMTTg83G4k1z2PC2ABEO5SliWhIm4i2sLrB/Rc0E469psP
 I2l6Z/M931W9fRvH/0CZK6EiNHMdI+Y7Juz4j6HfsQIZrH2cOiA11uXxfE/OKX/qWqL9igdv2XQ
 +ufYbxyocCeTudLt8025NZ4hS2QbMdMErMAU/ZchcebjVfE0Y/Es/zfCVrO+OEk3F2kpAFUi9bc
 ZQnJtGtjlbJwAMtcJXl6VqOxgeWM+7s+Sp8PZFIyuftnAKoBlvACIr8IScQEEvyB6lu7Twq7mCU
 Kc6VcxJkVOi11QokY+/O3nzsmRX34CqlHmM+En+53ve9ARD9JyYOP9LW/xtw90jd+OO6/Aem755
 Tjouo4kFp4KAj9lbTRAzGcxOLMQArD5g==
X-Google-Smtp-Source: AGHT+IGQ9GgmxoVGLLOoDPyrfxrtrFd/ajR4Lt78VvCwvf/69zzktUQQOEXqObPmHC/D6J0tVZwiew==
X-Received: by 2002:a05:6a21:99a2:b0:350:26ed:769b with SMTP id
 adf61e73a8af0-376a9de5688mr6799461637.44.1766255563984; 
 Sat, 20 Dec 2025 10:32:43 -0800 (PST)
Received: from fedora.. ([118.151.210.82]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c1e7ca0baf3sm5366268a12.34.2025.12.20.10.32.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Dec 2025 10:32:42 -0800 (PST)
From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
To: deller@gmx.de, richard.henderson@linaro.org, qemu-devel@nongnu.org,
 mark.cave-ayland@ilande.co.uk, sarkarsoumyajyoti23@gmail.com
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Ryo ONODERA <ryoon@netbsd.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Subject: [PATCH] [hw/scsi] Adding NetBSD Support for NCR710 SCSI Controller
Date: Sun, 21 Dec 2025 00:02:35 +0530
Message-ID: <20251220183235.186628-1-soumyajyotisarkar23@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=soumyajyotisarkar23@gmail.com; helo=mail-pf1-x443.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Before when NetBSD was booting it hanged in the device initialization
due to memory corruption, check below for error:

[   1.0000000] lpt1 at gsc0 hpa 0xf0102000 path 2/0/6 irq 7
SeaBIOS: Start PDC32 proc PDC_SOFT_POWER(23) option 1 result=0xfcc600 ARG3=0x1  ARG4=0xa63790 ARG5=0x1004280 ARG6=0x73cf48 ARG7=0x0
[   1.0000080] scsibus0: waiting 2 seconds for devices to settle...
(hanged here).

Fixed applied in this patch:
- Fixed use after free in ncr710_command_complete() done by clearning
  hba_private.
- Added null checks in ncr710_request_free() &
  ncr710_request_cancelled().
- Corrected scripts endianess handling
- Improved device selection and lun scanning
- Fix interrupt and register handling

Finally NetBSD now successfully boots with NCR710 SCSI Controller.

Reported-by: Helge Deller<deller@gmx.de>
Signed-off-by: Soumyajyotii Ssarkar<soumyajyotisarkar23@gmail.com>
---
 hw/scsi/ncr53c710.c | 94 +++++++++++++++++++++++++++++++++------------
 1 file changed, 70 insertions(+), 24 deletions(-)

diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index 47a6983491..808b4ebd53 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -593,7 +593,7 @@ static void ncr710_update_irq(NCR710State *s)
 {
     int level = 0;
 
-    if (s->dstat) {
+    if (s->dstat & ~NCR710_DSTAT_DFE) {
         if (s->dstat & s->dien) {
             level = 1;
         }
@@ -718,7 +718,9 @@ static void ncr710_do_dma(NCR710State *s, int out)
     if (s->current->dma_len == 0) {
         s->current->dma_buf = NULL;
         s->current->pending = 0;
+        s->waiting = NCR710_WAIT_DMA;
         scsi_req_continue(s->current->req);
+        return;
     } else {
         s->current->dma_buf += count;
         s->waiting = NCR710_WAIT_NONE;
@@ -737,6 +739,12 @@ static void ncr710_add_msg_byte(NCR710State *s, uint8_t data)
 
 static void ncr710_request_free(NCR710State *s, NCR710Request *p)
 {
+    if (!p) {
+        return;
+    }
+    if (p->req && p->req->hba_private == p) {
+        p->req->hba_private = NULL;
+    }
     if (p == s->current) {
         s->current = NULL;
     }
@@ -747,8 +755,11 @@ void ncr710_request_cancelled(SCSIRequest *req)
 {
     NCR710State *s = ncr710_from_scsi_bus(req->bus);
     NCR710Request *p = (NCR710Request *)req->hba_private;
-    req->hba_private = NULL;
-    ncr710_request_free(s, p);
+    if (p) {
+        req->hba_private = NULL;
+        p->req = NULL;
+        ncr710_request_free(s, p);
+    }
     scsi_req_unref(req);
 }
 
@@ -789,7 +800,14 @@ void ncr710_command_complete(SCSIRequest *req, size_t resid)
 
     ncr710_set_phase(s, PHASE_ST);
 
-    if (req->hba_private == s->current) {
+    if (p) {
+        if (p == s->current) {
+            req->hba_private = NULL;
+            p->req = NULL;
+        } else {
+            req->hba_private = NULL;
+            ncr710_request_free(s, p);
+        }
         scsi_req_unref(req);
     }
 
@@ -980,6 +998,7 @@ static void ncr710_do_status(NCR710State *s)
     ncr710_set_phase(s, PHASE_MI);
     s->msg_action = NCR710_MSG_ACTION_DISCONNECT;
     ncr710_add_msg_byte(s, 0); /* COMMAND COMPLETE */
+    s->command_complete = NCR710_CMD_COMPLETE;
 }
 
 static void ncr710_do_msgin(NCR710State *s)
@@ -1024,7 +1043,7 @@ static void ncr710_do_msgin(NCR710State *s)
         ncr710_set_phase(s, PHASE_CO);
         break;
     case NCR710_MSG_ACTION_DISCONNECT:
-        ncr710_disconnect(s);
+        s->sstat2 &= ~PHASE_MASK;
         break;
     case NCR710_MSG_ACTION_DATA_OUT:
         ncr710_set_phase(s, PHASE_DO);
@@ -1338,8 +1357,8 @@ again:
             offset = sextract32(addr, 0, 24);
             ncr710_dma_read(s, s->dsa + offset, buf, 8);
             /* byte count is stored in bits 0:23 only */
-            s->dbc = cpu_to_le32(buf[0]) & 0xffffff;
-            addr = cpu_to_le32(buf[1]);
+            s->dbc = be32_to_cpu(buf[0]) & 0xffffff;
+            addr = be32_to_cpu(buf[1]);
         }
         /* Check phase match for block move instructions */
         if ((s->sstat2 & PHASE_MASK) != ((insn >> 24) & 7)) {
@@ -1404,8 +1423,29 @@ again:
                         s->dsp = s->dnad;
                         break;
                     }
-                } else if (!scsi_device_find(&s->bus, 0, idbitstonum(id), 0)) {
+                }
+                bool device_exists = false;
+                if (insn & (1 << 24)) {
+                    for (int lun = 0; lun < 8; lun++) {
+                        SCSIDevice *dev = scsi_device_find(&s->bus, 0,
+                                                           idbitstonum(id),
+                                                           lun);
+                        if (dev) {
+                            device_exists = true;
+                            break;
+                        }
+                    }
+                } else {
+                    SCSIDevice *dev = scsi_device_find(&s->bus, 0,
+                                                       idbitstonum(id), 0);
+                    device_exists = dev != NULL;
+                }
+
+                if (!device_exists) {
                     ncr710_bad_selection(s, id);
+                    if (!(insn & (1 << 24)) && addr != 0) {
+                        s->dsp = addr;
+                    }
                     break;
                 } else {
                     /*
@@ -1425,13 +1465,10 @@ again:
                 }
                 break;
             case 1: /* Disconnect */
-
                 if (s->command_complete != NCR710_CMD_PENDING) {
                     s->scntl1 &= ~NCR710_SCNTL1_CON;
                     s->istat &= ~NCR710_ISTAT_CON;
-                    if (s->waiting == NCR710_WAIT_RESELECT) {
-                        s->waiting = NCR710_WAIT_NONE;
-                    }
+                    s->waiting = NCR710_WAIT_NONE;
                 } else {
                     if (s->current) {
                         s->current->resume_offset = s->dsp;
@@ -1770,7 +1807,6 @@ static uint8_t ncr710_reg_readb(NCR710State *s, int offset)
         }
         s->dstat = 0;  /* Clear all DMA interrupt status bits */
         s->dstat |= NCR710_DSTAT_DFE;
-        s->istat &= ~NCR710_ISTAT_DIP;
         ncr710_update_irq(s);
 
         if (s->waiting == NCR710_WAIT_RESELECT && s->current &&
@@ -1796,7 +1832,7 @@ static uint8_t ncr710_reg_readb(NCR710State *s, int offset)
         return ret;
     case NCR710_SSTAT0_REG: /* SSTAT0 */
         ret = s->sstat0;
-        if (s->sstat0 != 0 && !(s->sstat0 & NCR710_SSTAT0_STO)) {
+        if (s->sstat0 != 0) {
             s->sstat0 = 0;
             s->istat &= ~NCR710_ISTAT_SIP;
             ncr710_update_irq(s);
@@ -1809,14 +1845,7 @@ static uint8_t ncr710_reg_readb(NCR710State *s, int offset)
         ret = s->sstat0;
         break;
     case NCR710_SSTAT2_REG: /* SSTAT2 */
-        ret = s->dstat;
-
-        if (s->dstat & NCR710_DSTAT_SIR) {
-            /* SIR bit processing */
-        }
-        s->dstat = 0;
-        s->istat &= ~NCR710_ISTAT_DIP;
-        ncr710_update_irq(s);
+        ret = s->sstat2;
         break;
         CASE_GET_REG32(dsa, NCR710_DSA_REG)
         break;
@@ -1887,7 +1916,6 @@ static uint8_t ncr710_reg_readb(NCR710State *s, int offset)
         if (s->dsps == GOOD_STATUS_AFTER_STATUS &&
             (s->dstat & NCR710_DSTAT_SIR)) {
             s->dstat &= ~NCR710_DSTAT_SIR;
-            s->istat &= ~NCR710_ISTAT_DIP;
             ncr710_update_irq(s);
         }
         break;
@@ -2049,7 +2077,21 @@ static void ncr710_reg_writeb(NCR710State *s, int offset, uint8_t val)
         /* Linux writes to these readonly registers on startup */
         return;
 
-    CASE_SET_REG32(dsa, NCR710_DSA_REG)
+    case NCR710_DSA_REG:
+        s->dsa &= 0xffffff00;
+        s->dsa |= val;
+        break;
+    case NCR710_DSA_REG + 1:
+        s->dsa &= 0xffff00ff;
+        s->dsa |= val << 8;
+        break;
+    case NCR710_DSA_REG + 2:
+        s->dsa &= 0xff00ffff;
+        s->dsa |= val << 16;
+        break;
+    case NCR710_DSA_REG + 3:
+        s->dsa &= 0x00ffffff;
+        s->dsa |= val << 24;
         break;
 
     case NCR710_CTEST0_REG: /* CTEST0 */
@@ -2118,7 +2160,11 @@ static void ncr710_reg_writeb(NCR710State *s, int offset, uint8_t val)
         if (val & 0x04) {
             ncr710_scsi_fifo_init(&s->scsi_fifo);
             s->dstat |= NCR710_DSTAT_DFE;
+            s->ctest1 = 0xFF; /* FMT - FIFO empty, all status bits set */
+        } else if (s->ctest8 & 0x04) {
+            s->ctest1 = 0x00;
         }
+        s->ctest8 = val;
         break;
     case NCR710_LCRC_REG: /* LCRC */
         s->lcrc = val;
-- 
2.49.0


