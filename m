Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B54EE57CE
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Jan 2026 03:58:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vb9of-0002Jx-Ew; Wed, 31 Dec 2025 22:57:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vb9ob-0002Ga-GM
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 22:57:33 -0500
Received: from fhigh-b3-smtp.messagingengine.com ([202.12.124.154])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vb9oZ-0003io-SX
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 22:57:33 -0500
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id F11A57A00A2;
 Wed, 31 Dec 2025 22:57:30 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Wed, 31 Dec 2025 22:57:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1767239850; x=
 1767326250; bh=yjXSxmtpN9TGkc9lFU0SWd9L+aID59ZDAA8OnbgXGpE=; b=b
 /W5lD8NTFTTPcTCpGUMqcz/BnVdUCowIE51L9NtXpisR09LFjLTZHyBkd3tOgZeG
 w20YMUK4TakeV1Lk4SdFAGQpuJYkze5lPphZewvMJvA9OOCcQeelMNZA0iWAxVY8
 iNVOGuJSiJtp0Pvqiyu/mSD1l4vHeaoJ7IWozc7OZH8b49NLXbax50LuRQyMaXhh
 QoFPZEQsS/gFJbeRfXhS5AUWKWja06u893lW3PmV0fBECqN46K8WsICoXIAlHVZW
 YLRxoW7EDRL0ak8bWnYkwJ1XTfohe6KP9438ksLHSXMHDIy0vGNuyrKFIME79E32
 srYqakMFv55xWPLyDOy1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1767239850; x=1767326250; bh=y
 jXSxmtpN9TGkc9lFU0SWd9L+aID59ZDAA8OnbgXGpE=; b=WZB52VEyFolwjkKS8
 7tZHVX3+WtmEDVv5nhPteXXq9oh/yu2nc1YmVXTwJt/c7F4XVZew0dzk4DSDpDQU
 hzlGAUWcM1bv/W0HQRurGLBp2na8Gy3as/sCMf0cjKokhW4wBuTduz6H16ATxzVs
 F1Zdl9a7J1e7e/LXdawNvPNPysnew8r2+H4sUh55mTx5jDrL8iW0ZoHk9Ir3hGUW
 Jri7KgpkljI6MV2a/EU1n1iO1Zhx8Ib+NPhugfuowjh7nMA02Q0xclExBSojfk0A
 QcvgUKnlJZIF+z48taHafvo0nhwWFnyDQY4M4GhSKZyZipeG28HtGnMXRwcMmS9v
 5mSHg==
X-ME-Sender: <xms:qvBVaf7XNM_iuhFiYbSLklbAl9b5dJEgx3dqM0q8R2_iDOkETTusVw>
 <xme:qvBVacUiiMdZV7Y4NlDXaAfWfj1jEb8z2znFZB7x54dYDx81x6fzZs29LN4Zl-MQF
 okRvy81b7gA0VHzMja8910RP0pXKs1mqVrSrxx2aFI2PdyFmw5Niw>
X-ME-Received: <xmr:qvBVaT3UTVyb_58GSzTWj-p-XLQLIbbCVX-coA8jHdu4nl0DNznxTEtwL49m>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekgeejiecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephffvvefuff
 fkofgjfhgggfestdekredtredttdenucfhrhhomhepvehhrgguucflrggslhhonhhskhhi
 uceotghhrggusehjrggslhhonhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpefgie
 etjefhleehfeeiteejgfeljeffhfeuffdvudeijefgueeuuedvvdekjefhleenucevlhhu
 shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsg
 hlohhnshhkihdrgiihiidpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhht
 pdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtth
 hopegsrghlrghtohhnsegvihhkrdgsmhgvrdhhuhdprhgtphhtthhopegthhgrugesjhgr
 sghlohhnshhkihdrgiihii
X-ME-Proxy: <xmx:qvBVaZ2v2LAW1SkUPpNyIiG7MMq5IMQOx8Wl23qzDDefe85yYLAtTw>
 <xmx:qvBVaW9PJ29CZa3CgAhWByRx8E7mLVIKZtWo4AbeTKzT15xsWngwgw>
 <xmx:qvBVaW0NACwtYgO1KWkydxXIq3TFrmbLvxFyde3Lg5DaA3LRPBSFSA>
 <xmx:qvBVaT-vZBz4yksNGOMJe3VvgCtVQ0axNtyf3AGtqM5UXFUxMjjWCQ>
 <xmx:qvBVadg2meNsxWL426CEHg2w3DmJRrZUQsOxWI8QAiNZx1onyKQAK9JN>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Dec 2025 22:57:30 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id ec59e503;
 Thu, 1 Jan 2026 03:57:26 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v2 7/7] ati-vga: Implement PM4_STAT register and common flags
Date: Wed, 31 Dec 2025 22:55:55 -0500
Message-ID: <20260101035555.1300511-8-chad@jablonski.xyz>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260101035555.1300511-1-chad@jablonski.xyz>
References: <20260101035555.1300511-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.154; envelope-from=chad@jablonski.xyz;
 helo=fhigh-b3-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.498, PDS_OTHER_BAD_TLD=1.997, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

The PM4_STAT register largely mirrors the flags of the GUI_STAT
register. The exception is that the low bits of PM4_STAT reflect the
remaining slots in the CCE FIFO instead of the GUI FIFO.

This implements a very incomplete set of common flags
(MICRO_BUSY and GUI_ACTIVE) and the PM4_STAT register.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati.c      | 16 +++++++++++++++-
 hw/display/ati_cce.c  | 38 ++++++++++++++++++++++++++++++++++++++
 hw/display/ati_cce.h  |  3 +++
 hw/display/ati_regs.h |  1 +
 4 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 9edde2b0bc..3f31a76b72 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -276,6 +276,16 @@ static inline uint64_t ati_reg_read_offs(uint32_t reg, int offs,
     }
 }
 
+static uint32_t ati_common_stat(ATIVGAState *s)
+{
+    /* TODO: This is _very_ naive. It will evolve. */
+    uint32_t micro_busy = ati_cce_micro_busy(&s->cce.cur_packet) ?
+                          MICRO_BUSY : 0;
+    /* GUI_ACTIVE is the OR of all other status flags */
+    uint32_t gui_active = micro_busy ? GUI_ACTIVE : 0;
+    return gui_active | micro_busy;
+}
+
 static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
 {
     ATIVGAState *s = opaque;
@@ -383,7 +393,7 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
         break;
     case RBBM_STATUS:
     case GUI_STAT:
-        val = 64; /* free CMDFIFO entries */
+        val = ati_common_stat(s) | 64; /* free CMDFIFO entries */
         break;
     case CRTC_H_TOTAL_DISP:
         val = s->regs.crtc_h_total_disp;
@@ -543,6 +553,10 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
     case PM4_MICRO_CNTL:
         val = s->cce.freerun ? PM4_MICRO_FREERUN : 0;
         break;
+    case PM4_STAT: {
+        val = ati_common_stat(s) | ati_cce_fifo_cnt(&s->cce);
+        break;
+    }
     default:
         break;
     }
diff --git a/hw/display/ati_cce.c b/hw/display/ati_cce.c
index 62a88a54df..3d35b0e857 100644
--- a/hw/display/ati_cce.c
+++ b/hw/display/ati_cce.c
@@ -11,6 +11,24 @@
 #include "ati_int.h"
 #include "trace.h"
 
+static uint32_t
+ati_cce_fifo_max(uint8_t mode)
+{
+    switch (mode) {
+    case PM4_BUFFER_CNTL_NONPM4...PM4_BUFFER_CNTL_192BM:
+        return 192;
+    case PM4_BUFFER_CNTL_128PIO_64INDBM...PM4_BUFFER_CNTL_128BM_64INDBM:
+        return 128;
+    case PM4_BUFFER_CNTL_64PIO_128INDBM...PM4_BUFFER_CNTL_64PIO_64VCBM_64INDBM:
+        /* fall through */
+    case PM4_BUFFER_CNTL_64PIO_64VCPIO_64INPIO:
+        return 64;
+    default:
+        /* Undocumented but testing shows this returns 192 otherwise */
+        return 192;
+    }
+}
+
 static inline uint32_t
 ati_cce_data_packets_remaining(const ATIPM4PacketState *p)
 {
@@ -154,3 +172,23 @@ ati_cce_receive_data(ATIVGAState *s, uint32_t data)
     }
     ati_cce_process_packet_data(s, data);
 }
+
+bool
+ati_cce_micro_busy(const ATIPM4PacketState *p)
+{
+    uint32_t remaining = ati_cce_data_packets_remaining(p);
+    if (remaining > 0) {
+        return true;
+    }
+    return false;
+}
+
+uint32_t
+ati_cce_fifo_cnt(const ATICCEState *c)
+{
+    /*
+     * This should return the available slots. Given that commands are
+     * processed immediately this returns the fifo max for now.
+     */
+    return ati_cce_fifo_max(c->buffer_mode);
+}
diff --git a/hw/display/ati_cce.h b/hw/display/ati_cce.h
index b6ad21f47e..12aede6ecc 100644
--- a/hw/display/ati_cce.h
+++ b/hw/display/ati_cce.h
@@ -85,4 +85,7 @@ typedef struct ATICCEState {
 } ATICCEState;
 
 void ati_cce_receive_data(ATIVGAState *s, uint32_t data);
+bool ati_cce_micro_busy(const ATIPM4PacketState *p);
+uint32_t ati_cce_fifo_cnt(const ATICCEState *c);
+
 #endif /* ATI_CCE_H */
diff --git a/hw/display/ati_regs.h b/hw/display/ati_regs.h
index d7118449f5..841019ac7b 100644
--- a/hw/display/ati_regs.h
+++ b/hw/display/ati_regs.h
@@ -280,6 +280,7 @@
 
 /* CONSTANTS */
 #define GUI_ACTIVE                              0x80000000
+#define MICRO_BUSY                              0x00020000
 #define ENGINE_IDLE                             0x0
 
 #define PLL_WR_EN                               0x00000080
-- 
2.51.2


