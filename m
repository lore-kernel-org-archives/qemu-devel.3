Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C50CD98D2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 22:37:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZcOE-0007OH-1d; Tue, 16 Jun 2026 18:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <31s8xagcKCpU8G67A935DD5A3.1DBF3BJ-23K3ACDC5CJ.DG5@flex--jrhilke.bounces.google.com>)
 id 1wZcOC-0007Nj-Cv
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 18:36:12 -0400
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <31s8xagcKCpU8G67A935DD5A3.1DBF3BJ-23K3ACDC5CJ.DG5@flex--jrhilke.bounces.google.com>)
 id 1wZcOA-0001d4-7J
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 18:36:11 -0400
Received: by mail-pf1-x449.google.com with SMTP id
 d2e1a72fcca58-8423f24dcedso6143841b3a.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 15:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781649367; x=1782254167; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=PsAgANYNyUBwQx2gOQDlGSUWKb9RLynfIzMCyqMvy4Q=;
 b=VD1sEXwSOLQa+zkhCWzV1WGifAmyTAe3QI4wqBOZN59I8+ALl4h6ZK93VyX+fHIjcH
 ncZbMBqxkbDA7gdoN4Bt8RGr2pipAttn0LPWk9Z7BmboDeNm8NP4Eah/A+6IG/P3Nh+m
 0QalevOo5aqvISWLH+qZhKASEKsLmIe5EUNgWvM8gm6l6TNOIm6sujbzDMt0M0sjV7hh
 FRK9naq68dFNnUoUP45Lok1nnJu9FnhfC2COw66eZAYX5fUKORgJngrpEcPIk32Kzbl8
 V6KG5eTJAAyvYkIyHGKWxunqvqw3N3QmX+6bIFNqUSEhdyfPgoitfEfLE1zz7EL64REo
 eRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781649367; x=1782254167;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PsAgANYNyUBwQx2gOQDlGSUWKb9RLynfIzMCyqMvy4Q=;
 b=TOymIDvXRIiAv4TTNa3MyW2KVzXbfsdwqLaa+8yprcDsocEV9KprpxO3SUJayW4GwB
 H562pcGcueS+dbVVdRXGYmGZW9j8QEgjxtOQhnMPFmRPcq+PfP/tTTRxuIAWS4qS98uo
 eYhR+n/dIkB6LtYsleMrJq6qCXKyj75+hp9Nh+oAbBy/s41YkR0Z9k5CbvfyPxGkvwqW
 JQHDougRklFXrMgkh7+OPcsAC8I3nkXXP4bllSd8FcKN4ldqhqjPSMovMbGpBvr1ztfp
 oCOpSnC2XoHjwnZCwnrEdHfJg/Npb41hg0ilIR8UDCn84qTHO3d7EwieoK10VJsveozT
 YtoA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/pr7vAxYI6Sh2M3rSLZ+yVnSszLVN09ZWIMzh7vOgPJkZkTlb0Bc9cSUtM2FTC9rr+Rii3K5zIc075@nongnu.org
X-Gm-Message-State: AOJu0YyushYA/+2OLany9NIj3lOkVE4ZH9YHTWPx5tuMDXTDuW+6jycQ
 SJRX/lyVT+sWX7Ck5EL4Hbyz+02XJiWMygM7gyznbAoa7OO1wtZdcj2+IvY99qsgeBU0HWSHvVF
 s2OPgujdY
X-Received: from pfbha13.prod.google.com
 ([2002:a05:6a00:850d:b0:83e:e011:246b])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2e0d:b0:841:dc8d:8066
 with SMTP id d2e1a72fcca58-845245ba4eamr963529b3a.39.1781649366472; Tue, 16
 Jun 2026 15:36:06 -0700 (PDT)
Date: Tue, 16 Jun 2026 22:35:32 +0000
In-Reply-To: <20260616-igb-trl-v5-0-1183e3635e06@google.com>
Mime-Version: 1.0
References: <20260616-igb-trl-v5-0-1183e3635e06@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260616-igb-trl-v5-5-1183e3635e06@google.com>
Subject: [PATCH v5 5/7] igb: Implement TRL throttling and timer resumption
From: Josh Hilke <jrhilke@google.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Josh Hilke <jrhilke@google.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::449;
 envelope-from=31s8xagcKCpU8G67A935DD5A3.1DBF3BJ-23K3ACDC5CJ.DG5@flex--jrhilke.bounces.google.com;
 helo=mail-pf1-x449.google.com
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
 hw/net/igb_core.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 71 insertions(+), 2 deletions(-)

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index b7f880e..7f14564 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -96,6 +96,8 @@ igb_receive_internal(IGBCore *core, const struct iovec *iov, int iovcnt,
 
 static void igb_raise_interrupts(IGBCore *core, size_t index, uint32_t causes);
 static void igb_reset(IGBCore *core, bool sw);
+static uint64_t igb_trl_get_target_rate(const IGBTrlQueue *q);
+
 
 static inline void
 igb_raise_legacy_irq(IGBCore *core)
@@ -875,6 +877,16 @@ igb_tx_enabled(IGBCore *core, const E1000ERingInfo *txi)
         (core->mac[TXDCTL0 + (qn * 16)] & E1000_TXDCTL_QUEUE_ENABLE);
 }
 
+static uint64_t igb_trl_calculate_delay(uint64_t target_rate,
+                                        size_t bytes_sent)
+{
+    uint64_t low, high;
+
+    mulu64(&low, &high, bytes_sent, NANOSECONDS_PER_SECOND);
+    divu128(&low, &high, target_rate);
+    return low;
+}
+
 static void
 igb_start_xmit(IGBCore *core, const IGB_TxRing *txr)
 {
@@ -883,12 +895,19 @@ igb_start_xmit(IGBCore *core, const IGB_TxRing *txr)
     union e1000_adv_tx_desc desc;
     const E1000ERingInfo *txi = txr->i;
     uint32_t eic = 0;
+    size_t bytes_sent = 0;
+    uint64_t target_rate;
+    uint64_t delay_ns;
 
     if (!igb_tx_enabled(core, txi)) {
         trace_e1000e_tx_disabled();
         return;
     }
 
+    if (timer_pending(core->trl[txi->idx].timer)) {
+        return;
+    }
+
     d = pcie_sriov_get_vf_at_index(core->owner, txi->idx % 8);
     if (!d) {
         d = core->owner;
@@ -902,9 +921,19 @@ igb_start_xmit(IGBCore *core, const IGB_TxRing *txr)
         trace_e1000e_tx_descr((void *)(intptr_t)desc.read.buffer_addr,
                               desc.read.cmd_type_len, desc.wb.status);
 
-        igb_process_tx_desc(core, d, txr->tx, &desc, txi->idx);
+        bytes_sent += igb_process_tx_desc(core, d, txr->tx, &desc, txi->idx);
         igb_ring_advance(core, txi, 1);
         eic |= igb_txdesc_writeback(core, base, &desc, txi);
+
+        target_rate = igb_trl_get_target_rate(&core->trl[txi->idx]);
+        if (target_rate > 0) {
+            delay_ns = igb_trl_calculate_delay(target_rate, bytes_sent);
+            if (delay_ns > 0) {
+                timer_mod(core->trl[txi->idx].timer,
+                          qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + delay_ns);
+                break;
+            }
+        }
     }
 
     if (eic) {
@@ -4330,15 +4359,55 @@ igb_autoneg_resume(IGBCore *core)
                   qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + 500);
     }
 }
+static uint32_t igb_trl_get_scaled_rate_factor(uint32_t trlrc)
+{
+    /*
+     * The TRLRC register stores the Rate Factor in 10.14 fixed-point format:
+     * - Bits 13:0: Fractional part
+     * - Bits 23:14: Integer part
+     *
+     * Combined, the lower 24 bits of the register (23:0) represent the
+     * concatenated 24-bit scaled Rate Factor directly.
+     */
+    return extract32(trlrc, 0, 24);
+}
 
 bool igb_trl_enabled(const IGBTrlQueue *q)
 {
     return q->trlrc & E1000_TRLRC_RS_ENA;
 }
 
+static uint64_t igb_trl_get_target_rate(const IGBTrlQueue *q)
+{
+    const uint32_t rf_scaled = igb_trl_get_scaled_rate_factor(q->trlrc);
+
+    if (!igb_trl_enabled(q)) {
+        return 0;
+    }
+
+    if (rf_scaled == 0) {
+        return 0;
+    }
+
+    /*
+     * The rate factor is a fixed-point number with a 14-bit fractional part:
+     * Rate Factor = rf_scaled / 2^14
+     *
+     * The target rate is:
+     * Target Rate = Link Rate / Rate Factor
+     *             = Link Rate / (rf_scaled / 2^14)
+     *             = (Link Rate * 2^14) / rf_scaled
+     */
+    return (E1000_LINK_RATE_1GBPS << 14) / rf_scaled;
+}
+
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
2.54.0.1136.gdb2ca164c4-goog


