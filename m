Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E9A5CD98CE
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 22:19:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZFeW-00053K-Cv; Mon, 15 Jun 2026 18:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3YHowagcKCm8WeUVYXRTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--jrhilke.bounces.google.com>)
 id 1wZFeK-0004vs-GY
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 18:19:22 -0400
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3YHowagcKCm8WeUVYXRTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--jrhilke.bounces.google.com>)
 id 1wZFeI-0008NM-9e
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 18:19:20 -0400
Received: by mail-pf1-x449.google.com with SMTP id
 d2e1a72fcca58-842cb4c62f9so3056600b3a.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 15:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781561953; x=1782166753; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=x6v58NaQN72zsguJx34RQhgS6oikfMI+z+7mN01OJh8=;
 b=um5ferIkAppvQieL6D9rlT7WO6yU2DS57mYfZATqk6IXNaNFtd0/i7aA6GxYOygnAZ
 I5aLFC6vGezjXU1PLXhyYPNdcwwIew1RbHo0nqyr8klQImh7wUfoOSL5lyGxsgbkdMUi
 ss3WODeYVHMH5a494AmiC4hNBOG6zuk4JGKHYAtucidlpnQKIMbz3CrGoe02daWSNUsw
 NYo/HKLbPpH0vT4dYOdiY2HeXXw+mcTmFIiFD5C/K13GNS2OCKqigXoOMMxrQLtIvF2B
 dUB5Q/QLk+Oauf80w4PLrLmhB9puUOcnSeSoMHnAP+xASasVHpHxR6f0+KsQjODBo15D
 HC6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781561953; x=1782166753;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x6v58NaQN72zsguJx34RQhgS6oikfMI+z+7mN01OJh8=;
 b=TPQUmuN9H4KVOJDgac3nCaIJnq9bgeJdWWjMYdTngibKC85a7quEmtrHC/yJPXkeoH
 j8m6q8D0ELnSphlvOF2p2hoELbDze1wRXDGkUweKpWj5k7zT/wDj9PopL1e+bittbdYq
 oFQU0Zx8bwAA6Abi6nYMLAOgy+JoWBVNFsXDqVaFw1ZhX3YxQUtbXxgtVjDKMJMiNdAg
 AckRF8pYttXzoEbs2vl3y6jVr/4raLCrhpGQGA4P4kIrRU0ZQ3p7mI8PhOwX2IvtIbzO
 7nfP4lNfrCeUIb94COQiJVSs5EB1CYqjCmb4NsCAL7TzP3tSodvJ4NTgleToZH+xIj8Y
 bVPw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+xU+BsqGQgaj3s+JFhpKrGrXfQPx2vuv8x8YvGWWgYa0Cm56DaDq7eJeLL3SpZfuTlKP9skTT9tGUW@nongnu.org
X-Gm-Message-State: AOJu0YyIZEIfc/Xh90apB2sjlMXA5aHD3yjCMmSVf2Hkgb0KFF1o4qR5
 J/eWhnjhMq78QcGDcMft7zTImBaaR0GZ3GEV0ipqlUOKxJMgXu3mPKV4hBX5c59oKNpI7hgI0nK
 46FV0DqyS
X-Received: from pfblr42.prod.google.com
 ([2002:a05:6a00:73aa:b0:842:8522:9ada])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4c86:b0:842:3804:590d
 with SMTP id d2e1a72fcca58-84513e0d9f9mr1008216b3a.7.1781561952776; Mon, 15
 Jun 2026 15:19:12 -0700 (PDT)
Date: Mon, 15 Jun 2026 22:18:07 +0000
In-Reply-To: <20260615-igb-trl-v4-0-cf5739bf529f@google.com>
Mime-Version: 1.0
References: <20260615-igb-trl-v4-0-cf5739bf529f@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260615-igb-trl-v4-5-cf5739bf529f@google.com>
Subject: [PATCH v4 5/7] igb: Implement TRL throttling and timer resumption
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
 envelope-from=3YHowagcKCm8WeUVYXRTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--jrhilke.bounces.google.com;
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
 hw/net/igb_core.c | 42 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index fac4c44..17eeba4 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -876,6 +876,12 @@ igb_tx_enabled(IGBCore *core, const E1000ERingInfo *txi)
         (core->mac[TXDCTL0 + (qn * 16)] & E1000_TXDCTL_QUEUE_ENABLE);
 }
 
+static uint64_t igb_trl_calculate_delay(uint64_t target_rate,
+                                        size_t bytes_sent)
+{
+    return (uint64_t)bytes_sent * NANOSECONDS_PER_SECOND / target_rate;
+}
+
 static void
 igb_start_xmit(IGBCore *core, const IGB_TxRing *txr)
 {
@@ -884,12 +890,19 @@ igb_start_xmit(IGBCore *core, const IGB_TxRing *txr)
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
@@ -903,9 +916,19 @@ igb_start_xmit(IGBCore *core, const IGB_TxRing *txr)
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
@@ -2143,9 +2166,16 @@ igb_set_phy_ctrl(IGBCore *core, uint16_t val)
 
 static void igb_trl_disable_queue(IGBCore *core, int qidx)
 {
+    IGB_TxRing txr;
+
     core->trl[qidx].trlrc = 0;
 
-    timer_del(core->trl[qidx].timer);
+    if (timer_pending(core->trl[qidx].timer)) {
+        timer_del(core->trl[qidx].timer);
+        /* Flush the queue of any pending packets */
+        igb_tx_ring_init(core, &txr, qidx);
+        igb_start_xmit(core, &txr);
+    }
 }
 
 static void igb_trl_disable(IGBCore *core)
@@ -4386,7 +4416,13 @@ uint64_t igb_trl_get_target_rate(const IGBTrlQueue *q)
 
 static void igb_trl_timer_cb(void *opaque)
 {
-    /* Stub */
+    IGBTrlQueue *trl = opaque;
+    IGBCore *core = trl->core;
+    int qidx = trl->queue_idx;
+    IGB_TxRing txr;
+
+    igb_tx_ring_init(core, &txr, qidx);
+    igb_start_xmit(core, &txr);
 }
 
 void

-- 
2.54.0.1136.gdb2ca164c4-goog


