Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C155CD98CE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 21:51:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY9m6-00023s-IQ; Fri, 12 Jun 2026 17:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3NX8sagcKCj4owmnqpjlttlqj.htrvjrz-ij0jqstslsz.twl@flex--jrhilke.bounces.google.com>)
 id 1wY9m5-00023L-CZ
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 17:50:49 -0400
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3NX8sagcKCj4owmnqpjlttlqj.htrvjrz-ij0jqstslsz.twl@flex--jrhilke.bounces.google.com>)
 id 1wY9m3-0005JW-PP
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 17:50:49 -0400
Received: by mail-pf1-x449.google.com with SMTP id
 d2e1a72fcca58-84235f9b91fso1123291b3a.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2026 14:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781301046; x=1781905846; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=37AAcHyUthm/V/Cnn3W8lCG2TLEalp2rg5HyJIMTxkA=;
 b=s76sgPyViDWvHPcUmrNxzd/leOKrC3oobnXbIFhJEWHPHmkw4nrv+fNsuzJZiqphZN
 Ed4SqxcmHaDU5V9n3vtG1rEiOAmbyvU+vOVAzs1b9UuadZCEEHK3b66vl96foB/MabqP
 ip2TubiNQRoXNOYFv3KHUPfQ1dsjA80slE4slCB3TXYaG3ZsRgYT8oQ6mCfnJeBbDlC8
 JotEorwCD3IUGDcSYzRSx4vcV2I9b0s3R0MAn4uKoEHxlZfz39GBpI3eVNtLBoGjVnmn
 EBnNzfhCQy7U413GabeIUYj82rOxui30YuZZ2l62bKS1Kjs+VdIB+Keq93ra0bbe+DJy
 5Yhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781301046; x=1781905846;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=37AAcHyUthm/V/Cnn3W8lCG2TLEalp2rg5HyJIMTxkA=;
 b=WT4nqdoYEPATsE60nHxCAJ+rTXFwNd7aKya3wYNv44VYTUm72KX8KD/sJDKT2D2YBr
 CfQ42qDwaEiOnO+n56qbhhuouugjDGwqNq/+fK2wK4899hRBHpLgqfTU9gEnc1ymxoSA
 TznmF16ZJir/V1B2tMmTRwbgQKYPQZ2VXSh2Yzs19I89u+5ZL2tJY4PyLiHxW+Shqgcj
 1qf0MV8C1KZMERui4VOwVGSvSubj+FczO4Cp3pmpWjPD3kthH2Z8qKHE3GZF6721S3mI
 S4rGOI0Rw0wagfiVoWIEFwQur+G3K4hY/0heHXHApkT+nLdKThorlkpcy5FM1cQKP6+h
 UfbQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/aRMshstM42t9BtKq1D1uvXEo10tLxWsqnrd28VrDcnKIIL15mqyD/mIFCkjnS8rBLWE+6itbBRi5y@nongnu.org
X-Gm-Message-State: AOJu0YzgM1dBgO28n5X8u5jKQir4TnNtgfD0lgd0VcNSBS3PTpQfdSxO
 /1smWqR2A0e+4yvKcRe0yVLfqeCQjTFLlW3jp4s4cFtCvaW3cIkKgRHn0xplT8LqP2Em+wYQ+et
 HMGnN+Oqd
X-Received: from pfbfa25.prod.google.com
 ([2002:a05:6a00:2d19:b0:83f:2c4a:9b48])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1a87:b0:842:5719:455b
 with SMTP id d2e1a72fcca58-8434cec46e7mr5092054b3a.42.1781301045442; Fri, 12
 Jun 2026 14:50:45 -0700 (PDT)
Date: Fri, 12 Jun 2026 21:50:16 +0000
In-Reply-To: <20260612-igb-trl-v3-0-19607f9a3dde@google.com>
Mime-Version: 1.0
References: <20260612-igb-trl-v3-0-19607f9a3dde@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260612-igb-trl-v3-5-19607f9a3dde@google.com>
Subject: [PATCH v3 5/7] igb: Implement TRL throttling and timer resumption
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
 envelope-from=3NX8sagcKCj4owmnqpjlttlqj.htrvjrz-ij0jqstslsz.twl@flex--jrhilke.bounces.google.com;
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
 hw/net/igb_core.c | 44 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 4670c1e..c323a40 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -875,6 +875,14 @@ igb_tx_enabled(IGBCore *core, const E1000ERingInfo *txi)
         (core->mac[TXDCTL0 + (qn * 16)] & E1000_TXDCTL_QUEUE_ENABLE);
 }
 
+static uint64_t igb_trl_calculate_delay(uint64_t target_rate,
+                                        size_t bytes_sent)
+{
+    uint64_t ns_per_sec = 1000000000ULL;
+
+    return (uint64_t)bytes_sent * ns_per_sec / target_rate;
+}
+
 static void
 igb_start_xmit(IGBCore *core, const IGB_TxRing *txr)
 {
@@ -883,12 +891,19 @@ igb_start_xmit(IGBCore *core, const IGB_TxRing *txr)
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
@@ -902,9 +917,19 @@ igb_start_xmit(IGBCore *core, const IGB_TxRing *txr)
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
@@ -2142,9 +2167,16 @@ igb_set_phy_ctrl(IGBCore *core, uint16_t val)
 
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
@@ -4375,7 +4407,13 @@ uint64_t igb_trl_get_target_rate(const IGBTrlQueue *q)
 
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


