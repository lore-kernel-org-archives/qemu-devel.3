Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DAC4CD8C9D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 04:28:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXX1m-0001ZF-K0; Thu, 11 Jun 2026 00:28:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <33x0qagcKChwBJ9ADC68GG8D6.4GEI6EM-56N6DFGF8FM.GJ8@flex--jrhilke.bounces.google.com>)
 id 1wXVC7-0002py-Kb
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 22:30:59 -0400
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <33x0qagcKChwBJ9ADC68GG8D6.4GEI6EM-56N6DFGF8FM.GJ8@flex--jrhilke.bounces.google.com>)
 id 1wXVC6-0005Kf-4t
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 22:30:59 -0400
Received: by mail-pg1-x549.google.com with SMTP id
 41be03b00d2f7-c8604fbe71eso9643955a12.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 19:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781145056; x=1781749856; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=DupDPf3zjnimHKk0qNnF/Yif/Q4lejob3y1l9qRuulE=;
 b=WNPk5PONAej11leaHAC7yf8lUzOI3thryqLDfqIUJ10qwVxZz0bKtCfDffAUMvoSm5
 RMeylxu5ZwGm0dNGD8ib2PY/j/u3bnq33qliulpQblEbZMVQFcfBZaqVlukWr/PZedWe
 GNdw+gXGqdtAGRJCYfHjeQh5NFtVSxluy5K0lRoz55ZO5r7txny60ZvxtJ2z6X5wEVjP
 rgGVqH1NcYPoyipObnN0HgnHGoSerrwyelQJ9C2o6lQd8NJ62hEyzP2KhBgd9qmSy2Tu
 /Hiep7wZT8gu1/lA6rSGDEDElJ8rAGLg9lCtbTcT16Ul5iD4J6uPEuEgrxee/nPd7TKz
 xt3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781145056; x=1781749856;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DupDPf3zjnimHKk0qNnF/Yif/Q4lejob3y1l9qRuulE=;
 b=pFDATXLj75d/HGnSS6PRBSXILEnt0CwVwkCo4vABr1OMiRgk+z67mVBc8G2CJuJbCi
 1GNUNvGe+R/WF/hLTpgjSh3/GTEieVzB76VQ/S/PQU6ribS8/8kbGHebPQB+DmGcoHRR
 bt283QsxePIurHSEqWoDurfBP67yrqzfr7F0KywXf43IWx4+EqRHZIjZ63q0ctsis8E/
 zsr2ftaVuqYz/yBrCqW5SfwA+C4Uokjj657Kw35VCYBx7HPifcCW/QaxAmJk08T1gTa/
 ucYSz582N0USB/xvCy4DWbI/MuCAMsChP6SfP5pv9UtwAf3UZChaHkDEKjIMOX2IIxFG
 VWtA==
X-Gm-Message-State: AOJu0Yw85cRltaR235fTLCP44I7VXrb2LJOUkskYbfQN4P3pJeDeowOf
 CZ/mk7bikbELdVkXIDH2NdwGQsMDhWqiB/3veiTK+poH2dORDnTHcFbpUPwQUC6BppfpetZtDeR
 jOUJXzX1+Bi574MUc+0Q0M4hkVRTCJxLuGIAmOoqT9A7R9y5vVaWu34/IgoppGh/O0HysWAe8Bv
 L0Nb9M0je7Xb6GJ6QxgwMZMGakkK2KHwxtdXwOmgQ=
X-Received: from pgww20.prod.google.com ([2002:a05:6a02:2c94:b0:c86:21eb:a0c2])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:cc8e:b0:3a0:b781:4c78
 with SMTP id adf61e73a8af0-3b5e31003f1mr708011637.15.1781145055663; Wed, 10
 Jun 2026 19:30:55 -0700 (PDT)
Date: Thu, 11 Jun 2026 02:30:27 +0000
In-Reply-To: <20260611023028.102071-1-jrhilke@google.com>
Mime-Version: 1.0
References: <20260611023028.102071-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260611023028.102071-5-jrhilke@google.com>
Subject: [PATCH 4/5] igb: Implement TRL throttling and timer resumption
From: Josh Hilke <jrhilke@google.com>
To: qemu-devel@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Josh Hilke <jrhilke@google.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::549;
 envelope-from=33x0qagcKChwBJ9ADC68GG8D6.4GEI6EM-56N6DFGF8FM.GJ8@flex--jrhilke.bounces.google.com;
 helo=mail-pg1-x549.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 11 Jun 2026 00:28:25 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Integrate throttling logic into the transmission path. In
`igb_start_xmit`, check if the queue is currently throttled.  Accumulate
bytes sent, calculate the transmission delay based on the configured
target rate, and if a throttle is triggered, set the virtual timer, mark
the queue as throttled, and defer remaining packets.  Implement the
timer callback to clear the throttled state and resume transmission when
the timer expires.

Signed-off-by: Josh Hilke <jrhilke@google.com>
---
 hw/net/igb_core.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 9ed0e78..b8c0500 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -875,6 +875,14 @@ igb_tx_enabled(IGBCore *core, const E1000ERingInfo *txi)
         (core->mac[TXDCTL0 + (qn * 16)] & E1000_TXDCTL_QUEUE_ENABLE);
 }
 
+static uint64_t igb_trl_calculate_delay(IGBCore *core, int qidx,
+                                        size_t bytes_sent)
+{
+    uint64_t ns_per_sec = 1000000000ULL;
+
+    return (uint64_t)bytes_sent * ns_per_sec / core->trl_target_rate[qidx];
+}
+
 static void
 igb_start_xmit(IGBCore *core, const IGB_TxRing *txr)
 {
@@ -883,17 +891,23 @@ igb_start_xmit(IGBCore *core, const IGB_TxRing *txr)
     union e1000_adv_tx_desc desc;
     const E1000ERingInfo *txi = txr->i;
     uint32_t eic = 0;
+    size_t bytes_sent;
 
     if (!igb_tx_enabled(core, txi)) {
         trace_e1000e_tx_disabled();
         return;
     }
 
+    if (core->trl_throttled[txi->idx]) {
+        return;
+    }
+
     d = pcie_sriov_get_vf_at_index(core->owner, txi->idx % 8);
     if (!d) {
         d = core->owner;
     }
 
+    bytes_sent = 0;
     while (!igb_ring_empty(core, txi)) {
         base = igb_ring_head_descr(core, txi);
 
@@ -902,9 +916,20 @@ igb_start_xmit(IGBCore *core, const IGB_TxRing *txr)
         trace_e1000e_tx_descr((void *)(intptr_t)desc.read.buffer_addr,
                               desc.read.cmd_type_len, desc.wb.status);
 
-        igb_process_tx_desc(core, d, txr->tx, &desc, txi->idx);
+        bytes_sent += igb_process_tx_desc(core, d, txr->tx, &desc, txi->idx);
         igb_ring_advance(core, txi, 1);
         eic |= igb_txdesc_writeback(core, base, &desc, txi);
+
+        if (core->trl_target_rate[txi->idx] > 0) {
+            uint64_t delay_ns =
+                igb_trl_calculate_delay(core, txi->idx, bytes_sent);
+            if (delay_ns > 0) {
+                core->trl_throttled[txi->idx] = true;
+                timer_mod(core->trl_timer[txi->idx].timer,
+                          qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + delay_ns);
+                break;
+            }
+        }
     }
 
     if (eic) {
@@ -4358,7 +4383,15 @@ igb_autoneg_resume(IGBCore *core)
 
 static void igb_trl_timer_cb(void *opaque)
 {
-    /* Stub */
+    IGBTrlTimer *trl_timer = opaque;
+    IGBCore *core = trl_timer->core;
+    int qidx = trl_timer->queue_idx;
+    IGB_TxRing txr;
+
+    core->trl_throttled[qidx] = false;
+
+    igb_tx_ring_init(core, &txr, qidx);
+    igb_start_xmit(core, &txr);
 }
 
 void
-- 
2.54.0.1136.gdb2ca164c4-goog


