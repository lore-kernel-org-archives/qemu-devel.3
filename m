Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15EEAC71130
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 19:31:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYrYM-0005aZ-Fd; Mon, 07 Jul 2025 15:31:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1uYrXe-0005OH-SX
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 15:30:20 -0400
Received: from mailout04.t-online.de ([194.25.134.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1uYrXd-0005Pe-3l
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 15:30:18 -0400
Received: from fwd82.aul.t-online.de (fwd82.aul.t-online.de [10.223.144.108])
 by mailout04.t-online.de (Postfix) with SMTP id C7431ECBA;
 Mon,  7 Jul 2025 21:30:14 +0200 (CEST)
Received: from linpower.localnet ([93.236.150.188]) by fwd82.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1uYrXa-0vf2qP0; Mon, 7 Jul 2025 21:30:14 +0200
Received: by linpower.localnet (Postfix, from userid 1000)
 id 82BBD200533; Mon,  7 Jul 2025 21:30:09 +0200 (CEST)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 3/3] hw/audio/sb16: block structure coding style fixes
Date: Mon,  7 Jul 2025 21:30:09 +0200
Message-ID: <20250707193009.12901-3-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <48576e83-54ba-4ebd-8a3e-6b8306655483@t-online.de>
References: <48576e83-54ba-4ebd-8a3e-6b8306655483@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1751916614-20FF74EA-E0FE7B8F/0/0 CLEAN NORMAL
X-TOI-MSGID: 94f399f1-db02-4b3f-873e-4b2af447559a
Received-SPF: pass client-ip=194.25.134.18;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout04.t-online.de
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Change the block structure according to the QEMU Coding Style
documentation.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
 hw/audio/sb16.c | 57 +++++++++++++++++--------------------------------
 1 file changed, 20 insertions(+), 37 deletions(-)

diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
index 714144eb61..e23d86674e 100644
--- a/hw/audio/sb16.c
+++ b/hw/audio/sb16.c
@@ -204,8 +204,7 @@ static void control (SB16State *s, int hold)
             hold_DREQ(s, nchan);
         }
         AUD_set_active_out (s->voice, 1);
-    }
-    else {
+    } else {
         release_DREQ(s, nchan);
         AUD_set_active_out (s->voice, 0);
     }
@@ -271,10 +270,10 @@ static void dma_cmd8 (SB16State *s, int mask, int dma_len)
     s->fmt_signed = 0;
     s->fmt_stereo = (s->mixer_regs[0x0e] & 2) != 0;
     if (-1 == s->time_const) {
-        if (s->freq <= 0)
+        if (s->freq <= 0) {
             s->freq = 11025;
-    }
-    else {
+        }
+    } else {
         int tmp = (256 - s->time_const);
         s->freq = (1000000 + (tmp / 2)) / tmp;
     }
@@ -282,8 +281,7 @@ static void dma_cmd8 (SB16State *s, int mask, int dma_len)
 
     if (dma_len != -1) {
         s->block_size = dma_len << s->fmt_stereo;
-    }
-    else {
+    } else {
         /* This is apparently the only way to make both Act1/PL
            and SecondReality/FC work
 
@@ -362,16 +360,13 @@ static void dma_cmd (SB16State *s, uint8_t cmd, uint8_t d0, int dma_len)
     if (16 == s->fmt_bits) {
         if (s->fmt_signed) {
             s->fmt = AUDIO_FORMAT_S16;
-        }
-        else {
+        } else {
             s->fmt = AUDIO_FORMAT_U16;
         }
-    }
-    else {
+    } else {
         if (s->fmt_signed) {
             s->fmt = AUDIO_FORMAT_S8;
-        }
-        else {
+        } else {
             s->fmt = AUDIO_FORMAT_U8;
         }
     }
@@ -422,8 +417,7 @@ static inline uint8_t dsp_get_data (SB16State *s)
 {
     if (s->in_index) {
         return s->in2_data[--s->in_index];
-    }
-    else {
+    } else {
         dolog ("buffer underflow\n");
         return 0;
     }
@@ -447,8 +441,7 @@ static void command (SB16State *s, uint8_t cmd)
             qemu_log_mask(LOG_GUEST_ERROR, "%#x wrong bits\n", cmd);
         }
         s->needed_bytes = 3;
-    }
-    else {
+    } else {
         s->needed_bytes = 0;
 
         switch (cmd) {
@@ -674,8 +667,7 @@ static void command (SB16State *s, uint8_t cmd)
  exit:
     if (!s->needed_bytes) {
         s->cmd = -1;
-    }
-    else {
+    } else {
         s->cmd = cmd;
     }
     return;
@@ -715,14 +707,12 @@ static void complete (SB16State *s)
         if (s->cmd & 8) {
             dolog ("ADC params cmd = %#x d0 = %d, d1 = %d, d2 = %d\n",
                    s->cmd, d0, d1, d2);
-        }
-        else {
+        } else {
             ldebug ("cmd = %#x d0 = %d, d1 = %d, d2 = %d\n",
                     s->cmd, d0, d1, d2);
             dma_cmd (s, s->cmd, d0, d1 + (d2 << 8));
         }
-    }
-    else {
+    } else {
         switch (s->cmd) {
         case 0x04:
             s->csp_mode = dsp_get_data (s);
@@ -747,8 +737,7 @@ static void complete (SB16State *s)
                 ldebug ("0x83[%d] <- %#x\n", s->csp_reg83r, d0);
                 s->csp_reg83[s->csp_reg83r % 4] = d0;
                 s->csp_reg83r += 1;
-            }
-            else {
+            } else {
                 s->csp_regs[d1] = d0;
             }
             break;
@@ -763,8 +752,7 @@ static void complete (SB16State *s)
                         s->csp_reg83[s->csp_reg83w % 4]);
                 dsp_out_data (s, s->csp_reg83[s->csp_reg83w % 4]);
                 s->csp_reg83w += 1;
-            }
-            else {
+            } else {
                 dsp_out_data (s, s->csp_regs[d0]);
             }
             break;
@@ -819,8 +807,7 @@ static void complete (SB16State *s)
                 ticks = muldiv64(bytes, NANOSECONDS_PER_SECOND, freq);
                 if (ticks < NANOSECONDS_PER_SECOND / 1024) {
                     qemu_irq_raise (s->pic);
-                }
-                else {
+                } else {
                     if (s->aux_ts) {
                         timer_mod (
                             s->aux_ts,
@@ -992,12 +979,10 @@ static void dsp_write(void *opaque, uint32_t nport, uint32_t val)
                 log_dsp (s);
             }
 #endif
-        }
-        else {
+        } else {
             if (s->in_index == sizeof (s->in2_data)) {
                 dolog ("in data overrun\n");
-            }
-            else {
+            } else {
                 s->in2_data[s->in_index++] = val;
                 if (s->in_index == s->needed_bytes) {
                     s->needed_bytes = 0;
@@ -1032,8 +1017,7 @@ static uint32_t dsp_read(void *opaque, uint32_t nport)
         if (s->out_data_len) {
             retval = s->out_data[--s->out_data_len];
             s->last_read_byte = retval;
-        }
-        else {
+        } else {
             if (s->cmd != -1) {
                 dolog ("empty output buffer for command %#x\n",
                        s->cmd);
@@ -1255,8 +1239,7 @@ static int SB_read_DMA (void *opaque, int nchan, int dma_pos, int dma_len)
             release_DREQ(s, nchan);
             return dma_pos;
         }
-    }
-    else {
+    } else {
         free = dma_len;
     }
 
-- 
2.43.0


