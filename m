Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B80F3CDB475
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 19:06:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbjyG-0000YS-M3; Mon, 22 Jun 2026 15:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3n4c5agcKCuwXfVWZYSUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--jrhilke.bounces.google.com>)
 id 1wbjyF-0000YG-CL
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 15:06:11 -0400
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3n4c5agcKCuwXfVWZYSUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--jrhilke.bounces.google.com>)
 id 1wbjyD-0002lO-Jz
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 15:06:11 -0400
Received: by mail-pg1-x54a.google.com with SMTP id
 41be03b00d2f7-c88fc985a65so2981608a12.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 12:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1782155167; x=1782759967; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=DGwnbL1mqMd4oPQ4Qoq/8lDTF7NGdi4gUHTkHub77bY=;
 b=wjgW3iT4b2+54A16VFG2UFtYchugPJuRJN/qdEnjUTCohUEW0/NpLAAM0MgtLZs0Lw
 niGN7Qcc9nRrJTKqiRFys+zWhE2M50K44OqsVkBKZQanKJom4BYea5C+cUBJEPGiiTK9
 NkCwCcu+tr62mn+GQVQlDvzqHhr7bzUWp1GRKQP9GxymZghKAqGmHLeOOTy0P9Tl9Fq3
 8ks/y9st/5JZda9oVPNvH5q+CKUaP8XItOWBB7RM85VarTetRYEhpkWXLX18+UExEtlM
 FcLGxJAs/U8pVCDUZPcluxuzC64/T3nRgBn77fc0saz1hnxV6j7xZuEYCJDtmo4gUUN9
 e8SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782155167; x=1782759967;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DGwnbL1mqMd4oPQ4Qoq/8lDTF7NGdi4gUHTkHub77bY=;
 b=ghnzfJ3Y+GH/+OG71zoi8KsSlgv+FlVkUNbJ5MyHPHoo0IJUOVpP/tW/Tl67KsDwri
 +so/hNFtTlI3elem9X7IkHN4Yh5AjoUZuEPzP9plYqe8Tc+a6md7xJQQ/XiGYKXGEuKM
 qbVIQX3uqfVQWa5dhebXJe0LZcnPGPiVdfBAYqNGU8Kvx3R73Xauw/Xj8bB35nVTM0W5
 LeasJYdh6OroD/k1XdsFpW8JROALy77XSKO7xkJ4gS8JJgTEy1S5c8GU9W03dH/PEwai
 iCkeLa1Y3qsYwI0KZ6kjeCKx0o/IPQI+c+eG8LJL2iPVN3mXtQdtlmWLwY8UsVftwcpB
 A9aA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+WYk+94gVlfzxcWIBsHpZ+Jlvqtk53nTwE6EqdyleyIBtMHzSuI9ZrwqK+WllMeNr5qg7V7OpDmjfj@nongnu.org
X-Gm-Message-State: AOJu0Yx5AvmTETTzkH+bX/CAByiFPq4HcFe1fc9A8LlAdQRhAXe0aJPQ
 dUfUxB86gYEDI499g/csWoBpibL0MTVGAaMHPmEx2AH8qwlRsevnBp5jvqCRRzfBfwWLvZC7rrz
 gAH/Dtjvi
X-Received: from pfbde4.prod.google.com ([2002:a05:6a00:4684:b0:845:4b17:ddc6])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1748:b0:82f:72e6:ed4
 with SMTP id d2e1a72fcca58-845505438f5mr17177315b3a.0.1782155167248; Mon, 22
 Jun 2026 12:06:07 -0700 (PDT)
Date: Mon, 22 Jun 2026 19:05:42 +0000
In-Reply-To: <20260622-igb-trl-v7-0-abb960e767ac@google.com>
Mime-Version: 1.0
References: <20260622-igb-trl-v7-0-abb960e767ac@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260622-igb-trl-v7-5-abb960e767ac@google.com>
Subject: [PATCH v7 5/7] igb: Implement TRL throttling and timer resumption
From: Josh Hilke <jrhilke@google.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Josh Hilke <jrhilke@google.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::54a;
 envelope-from=3n4c5agcKCuwXfVWZYSUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--jrhilke.bounces.google.com;
 helo=mail-pg1-x54a.google.com
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
 hw/net/igb_core.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 63 insertions(+), 3 deletions(-)

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 9a8ef15..e158837 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -97,6 +97,7 @@ igb_receive_internal(IGBCore *core, const struct iovec *iov, int iovcnt,
 static void igb_raise_interrupts(IGBCore *core, size_t index, uint32_t causes);
 static void igb_reset(IGBCore *core, bool sw);
 
+
 static inline void
 igb_raise_legacy_irq(IGBCore *core)
 {
@@ -875,6 +876,48 @@ igb_tx_enabled(IGBCore *core, const E1000ERingInfo *txi)
         (core->mac[TXDCTL0 + (qn * 16)] & E1000_TXDCTL_QUEUE_ENABLE);
 }
 
+static uint64_t igb_trl_calculate_delay(const IGBTrlQueue *q, size_t bytes_sent)
+{
+    uint32_t divisor;
+    uint32_t rf;
+
+    if (!igb_trl_enabled(q)) {
+        return 0;
+    }
+
+    /*
+     * 7.8 Transmit Rate Limiting (TRL)
+     *
+     * > RF = 1Gb/s / Target-Rate (Rate Factor) is the ratio between the
+     * > nominal link rate and the target maximum rate to achieve for
+     * > that rate controlled queue. It is a decimal number ranging from
+     * > 1 to 1,000 (1 Mb/s minimum target rate) at least 10-bits before
+     * > the hexadecimal point and 14-bits after, as required for the
+     * > maximum PL by which it is multiplied.
+     *
+     * The TRLRC register stores the RF in 10.14 fixed-point format:
+     * - Bits 13:0: Fractional part
+     * - Bits 23:14: Integer part
+     *
+     * Combined, the lower 24 bits of the register (23:0) represent the
+     * RF directly.
+     */
+    rf = MAX(extract32(q->trlrc, 0, 24), 1 << 14);
+
+    /*
+     * Delay = PL (Packet Length) / Target-Rate
+     *       = PL / (1Gb/s / RF)
+     *       = PL * RF / 1Gb/s
+     *       = PL * RF / (1G / b/B / ns/s) B/ns
+     *       = (bytes_sent * (RF_scaled / 2^14) / (1G / b/B / ns/s)) ns
+     *       = (bytes_sent * RF_scaled / (1G / b/B * 2^14 / ns/s)) ns
+     */
+    divisor = ((1000000000ULL / BITS_PER_BYTE) << 14) /
+              NANOSECONDS_PER_SECOND;
+
+    return (uint64_t)bytes_sent * rf / divisor;
+}
+
 static void
 igb_start_xmit(IGBCore *core, const IGB_TxRing *txr)
 {
@@ -883,12 +926,19 @@ igb_start_xmit(IGBCore *core, const IGB_TxRing *txr)
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
@@ -902,9 +952,16 @@ igb_start_xmit(IGBCore *core, const IGB_TxRing *txr)
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
@@ -4321,7 +4378,6 @@ igb_autoneg_resume(IGBCore *core)
                   qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + 500);
     }
 }
-
 bool igb_trl_enabled(const IGBTrlQueue *q)
 {
     return q->trlrc & E1000_TRLRC_RS_ENA;
@@ -4329,7 +4385,11 @@ bool igb_trl_enabled(const IGBTrlQueue *q)
 
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
2.55.0.rc0.786.g65d90a0328-goog


