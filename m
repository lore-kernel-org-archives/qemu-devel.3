Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 036CCCD98C7
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 00:03:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXpLt-0002Ba-RJ; Thu, 11 Jun 2026 20:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3zyQragcKCh4DLBCFE8AIIAF8.6IGK8GO-78P8FHIHAHO.ILA@flex--jrhilke.bounces.google.com>)
 id 1wXmho-0000zg-RI
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 17:12:53 -0400
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3zyQragcKCh4DLBCFE8AIIAF8.6IGK8GO-78P8FHIHAHO.ILA@flex--jrhilke.bounces.google.com>)
 id 1wXmhn-0003oc-50
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 17:12:52 -0400
Received: by mail-pf1-x449.google.com with SMTP id
 d2e1a72fcca58-842692bf60aso369220b3a.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 14:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781212368; x=1781817168; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=i0jE0keB8XW4szM5K0FFyAJRk1NjD4A7UVCq1UseOTs=;
 b=jOuGvqYxjyFnKnopWBDwX9ZlkBpU9E869/V/sOxJ66MM3Tpq030HEc8hDtmVNhrgih
 rBCnksd4QvBUK/jYjzZTka61RozM6zItnWzZTJy+S9RKSiGOObLiT5mRm1Ugb5QANr9L
 PURGbh6SSHKoNEGdm/LkzCx+8A4HEmJv9P27Bk8D4NzDP5cUiB5MFYhyZUXyg5stR5D1
 CldavtgS2FxUyuGmVAMQw4edOuwOh8Adhsz/lEyHgq+An5muDbOsL4bm5pPB4z0/Tbho
 Rx0iBpyqDad2jsslHpbRk8zsgaK8bt8bOvOvdmr/7NnZYq9LJSoAPoFhCRPwHQo3EH7F
 YW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781212368; x=1781817168;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i0jE0keB8XW4szM5K0FFyAJRk1NjD4A7UVCq1UseOTs=;
 b=fRo58bIL0olE4zB/VleE3ivl5Xa2FdlLm7wgyGoLwE2EcV0NBiNJKpnZSRHwOW8kS4
 /D230WIIsva53AP/DY1KNj78FtohyI422msuEs4arLC2QK7vTKc6dgitVdZwEkHD2CjV
 K6mKtDubY6bSBLDY0HBIkJqmsHiz4zJ5I3W0uZXWZbUfdAqu/ow3nlkzFGsPBphnhrx5
 skLZzx2nrjGM0rbrd8qKO2Ot/PD/tMG8QgO0f9n9YnDPYbK6vUl03XWSvYrOmnxQzx5G
 PgAk+h+MxuVmuK/q8sdpy8RfHoqqMeFXVZTHU2gDYYLnHBSHZMjBX3r2kUVjn5c5rmHA
 tDUg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Ot1Dox67SUXxgLsNoVWDoUeVyBa0+mSJ84SGRLPsUQKPKbxzgi/kZ8F6BLEuN3oQX/peJ7G/FzATN@nongnu.org
X-Gm-Message-State: AOJu0Yzk45Dv12MvouUmUtG2WDlFh3/sdj7X63YgWcuaPW6/1CqJOyVZ
 CrZlkeYRKpNArFIwWfTMUp9e5MB6c1dXpWcQEdWvKfpFxaCrfO+hLOSbtOsVKiNM6rtp4YflPxi
 wqM/6r8Ph
X-Received: from pfbem2.prod.google.com ([2002:a05:6a00:3742:b0:842:1c68:3772])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2d17:b0:842:5a8d:303a
 with SMTP id d2e1a72fcca58-84336bb517fmr4844323b3a.37.1781212367843; Thu, 11
 Jun 2026 14:12:47 -0700 (PDT)
Date: Thu, 11 Jun 2026 21:11:30 +0000
In-Reply-To: <20260611-igb-trl-v2-0-bd58de9eb0fa@google.com>
Mime-Version: 1.0
References: <20260611-igb-trl-v2-0-bd58de9eb0fa@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260611-igb-trl-v2-5-bd58de9eb0fa@google.com>
Subject: [PATCH v2 5/7] igb: Implement TRL throttling and timer resumption
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
 envelope-from=3zyQragcKCh4DLBCFE8AIIAF8.6IGK8GO-78P8FHIHAHO.ILA@flex--jrhilke.bounces.google.com;
 helo=mail-pf1-x449.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 11 Jun 2026 20:02:23 -0400
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
 hw/net/igb_core.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 1c05276..c8e8e2d 100644
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
+    return (uint64_t)bytes_sent * ns_per_sec / core->trl[qidx].target_rate;
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
 
+    if (timer_pending(core->trl[txi->idx].timer)) {
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
 
@@ -902,9 +916,19 @@ igb_start_xmit(IGBCore *core, const IGB_TxRing *txr)
         trace_e1000e_tx_descr((void *)(intptr_t)desc.read.buffer_addr,
                               desc.read.cmd_type_len, desc.wb.status);
 
-        igb_process_tx_desc(core, d, txr->tx, &desc, txi->idx);
+        bytes_sent += igb_process_tx_desc(core, d, txr->tx, &desc, txi->idx);
         igb_ring_advance(core, txi, 1);
         eic |= igb_txdesc_writeback(core, base, &desc, txi);
+
+        if (core->trl[txi->idx].target_rate > 0) {
+            uint64_t delay_ns =
+                igb_trl_calculate_delay(core, txi->idx, bytes_sent);
+            if (delay_ns > 0) {
+                timer_mod(core->trl[txi->idx].timer,
+                          qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + delay_ns);
+                break;
+            }
+        }
     }
 
     if (eic) {
@@ -4365,7 +4389,13 @@ igb_autoneg_resume(IGBCore *core)
 
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


