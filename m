Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F97FCD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 20:17:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZwgI-0002bu-A1; Wed, 17 Jun 2026 16:16:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3iQAzagcKCq4XfVWZYSUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--jrhilke.bounces.google.com>)
 id 1wZwgH-0002ba-9f
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 16:16:13 -0400
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3iQAzagcKCq4XfVWZYSUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--jrhilke.bounces.google.com>)
 id 1wZwgF-0002uE-Ko
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 16:16:13 -0400
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-2c0c36f1cc0so4247395ad.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 13:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781727370; x=1782332170; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=STdlkBnVdrSp/ZL+J3OhI5nHWCMdZdPkLWGxtoEsjFE=;
 b=Ip0qV67qItiBqNu1qk3pUmcevJCL0TrbRsQ6dmZ0se129giOrzA4rRYRpxiY3Gj+w+
 NE1zNCZMxchs8X4z+yVOz1stfBSlRDsEsPwoLRqP58YXBU1Keuabe2SVHvL/jyHYnyNo
 OdcIEXQo2RchZ/LQqRbfJDgGn2p52HYdfv5Vwe8Xws3I/Tnp/viC5u8KBF46oKp3lFV9
 4dr71avlFHtqfscufNLJQRLpq4oCCUzaembjoTnHUsyTj3qu26CDETCsG1F7GwlUxcvx
 /sEl9Ty4Fd3HFXpYD953yXmANM8OUJQF8Y+mtzXyTH7ICnMWJ7/peHqbYuK1BkD2X3Cl
 IwAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781727370; x=1782332170;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=STdlkBnVdrSp/ZL+J3OhI5nHWCMdZdPkLWGxtoEsjFE=;
 b=cGNslc4rmM/vYvomRyiy37tLKAJ4qFD9AUwt3pd84vTipcunSsTuRIbZ5LFK/PNWCo
 1/G/whd/iz9FgS3rl5Ub01l67EkzuoK5wdkX+liGvqg+5hDUGGhxW6P2g44Thvcw20Ej
 eLkU7OSKybPY0libQF5VgDNf1uDidTQ1VFbfDrzNO/LA8d76ClBkxXNZvTnK+3a5lwa2
 Z4QGOO7LKlNNfZeqtjTwqR4xa/bF+yqlD0htwkV98qfMUdAxI9BUsw562+EhOZBX2Is6
 dFT8TdsLW+l4b84MK5bJivIGIVz3s8lZmn4mmHqdxLdzUr30qaYSgEC2DMLOHV3co+xB
 vrqQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9N4kCZS/L3igOAfXfoLrns4Dhfq1C9epQ2l5yjrpzs8IXo5UU0TP9ab47yHMZK9Zi2EYs7RHio9EM/@nongnu.org
X-Gm-Message-State: AOJu0YwZ9r+deP/CtVBc8Z7V2z25Jhjn/qllZ8sqMC3o6qaMiCthFaDL
 c3OTlYy7uZq2iALH79VNQ48IaVZzgqkI/HGxSDKWLEaifWKfK6+5Mg6nFfAtdR85uGAKRCqx0zT
 LwxZvPD1r
X-Received: from plbmj15.prod.google.com ([2002:a17:903:2b8f:b0:2be:1727:6821])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:3dc4:b0:2c2:b173:dd9
 with SMTP id d9443c01a7336-2c6bc22589dmr35394295ad.25.1781727369490; Wed, 17
 Jun 2026 13:16:09 -0700 (PDT)
Date: Wed, 17 Jun 2026 20:15:50 +0000
In-Reply-To: <20260617-igb-trl-v6-0-bbdfcadb81e2@google.com>
Mime-Version: 1.0
References: <20260617-igb-trl-v6-0-bbdfcadb81e2@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260617-igb-trl-v6-5-bbdfcadb81e2@google.com>
Subject: [PATCH v6 5/7] igb: Implement TRL throttling and timer resumption
From: Josh Hilke <jrhilke@google.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Josh Hilke <jrhilke@google.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::649;
 envelope-from=3iQAzagcKCq4XfVWZYSUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--jrhilke.bounces.google.com;
 helo=mail-pl1-x649.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
 hw/net/igb_core.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 57 insertions(+), 3 deletions(-)

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 693353e..7d61d7d 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -97,6 +97,7 @@ igb_receive_internal(IGBCore *core, const struct iovec *iov, int iovcnt,
 static void igb_raise_interrupts(IGBCore *core, size_t index, uint32_t causes);
 static void igb_reset(IGBCore *core, bool sw);
 
+
 static inline void
 igb_raise_legacy_irq(IGBCore *core)
 {
@@ -875,6 +876,42 @@ igb_tx_enabled(IGBCore *core, const E1000ERingInfo *txi)
         (core->mac[TXDCTL0 + (qn * 16)] & E1000_TXDCTL_QUEUE_ENABLE);
 }
 
+static uint64_t igb_trl_calculate_delay(const IGBTrlQueue *q,
+                                        size_t bytes_sent)
+{
+    uint32_t target_rate;
+    uint32_t rf_scaled;
+
+    if (!igb_trl_enabled(q)) {
+        return 0;
+    }
+
+    /*
+     * The TRLRC register stores the Rate Factor in 10.14 fixed-point format:
+     * - Bits 13:0: Fractional part
+     * - Bits 23:14: Integer part
+     *
+     * Combined, the lower 24 bits of the register (23:0) represent the
+     * concatenated 24-bit scaled Rate Factor directly.
+     */
+    rf_scaled = extract32(q->trlrc, 0, 24);
+    if (rf_scaled == 0) {
+        return 0;
+    }
+
+    /*
+     * Rate Factor = rf_scaled / 2^14
+     * Target Rate = Link Rate / Rate Factor
+     *             = (Link Rate * 2^14) / rf_scaled
+     *
+     * Clamp target rate to link speed.
+     */
+    target_rate = MIN(E1000_LINK_RATE_1GBPS,
+                      (E1000_LINK_RATE_1GBPS << 14) / rf_scaled);
+
+    return muldiv64(bytes_sent, NANOSECONDS_PER_SECOND, target_rate);
+}
+
 static void
 igb_start_xmit(IGBCore *core, const IGB_TxRing *txr)
 {
@@ -883,12 +920,19 @@ igb_start_xmit(IGBCore *core, const IGB_TxRing *txr)
     union e1000_adv_tx_desc desc;
     const E1000ERingInfo *txi = txr->i;
     uint32_t eic = 0;
+    size_t bytes_sent = 0;
+    uint64_t delay_ns;
 
     if (!igb_tx_enabled(core, txi)) {
         trace_e1000e_tx_disabled();
         return;
     }
 
+    if (igb_trl_enabled(&core->trl[txi->idx]) &&
+        timer_pending(core->trl[txi->idx].timer)) {
+        return;
+    }
+
     d = pcie_sriov_get_vf_at_index(core->owner, txi->idx % 8);
     if (!d) {
         d = core->owner;
@@ -902,9 +946,16 @@ igb_start_xmit(IGBCore *core, const IGB_TxRing *txr)
         trace_e1000e_tx_descr((void *)(intptr_t)desc.read.buffer_addr,
                               desc.read.cmd_type_len, desc.wb.status);
 
-        igb_process_tx_desc(core, d, txr->tx, &desc, txi->idx);
+        bytes_sent += igb_process_tx_desc(core, d, txr->tx, &desc, txi->idx);
         igb_ring_advance(core, txi, 1);
         eic |= igb_txdesc_writeback(core, base, &desc, txi);
+
+        delay_ns = igb_trl_calculate_delay(&core->trl[txi->idx], bytes_sent);
+        if (delay_ns > 0) {
+            timer_mod(core->trl[txi->idx].timer,
+                      qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + delay_ns);
+            break;
+        }
     }
 
     if (eic) {
@@ -4329,7 +4380,6 @@ igb_autoneg_resume(IGBCore *core)
                   qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + 500);
     }
 }
-
 bool igb_trl_enabled(const IGBTrlQueue *q)
 {
     return q->trlrc & E1000_TRLRC_RS_ENA;
@@ -4337,7 +4387,11 @@ bool igb_trl_enabled(const IGBTrlQueue *q)
 
 static void igb_trl_timer_cb(void *opaque)
 {
-    /* Stub */
+    IGBTrlQueue *trl = opaque;
+    IGB_TxRing txr;
+
+    igb_tx_ring_init(trl->core, &txr, trl->qidx);
+    igb_start_xmit(trl->core, &txr);
 }
 
 static void igb_trl_init(IGBCore *core)

-- 
2.55.0.rc0.738.g0c8ab3ebcc-goog


