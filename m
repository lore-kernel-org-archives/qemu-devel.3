Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 191CACD98CE
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 22:20:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZFeO-0004x5-9Z; Mon, 15 Jun 2026 18:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3WXowagcKCmgPXNORQKMUUMRK.IUSWKSa-JKbKRTUTMTa.UXM@flex--jrhilke.bounces.google.com>)
 id 1wZFeJ-0004vM-6F
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 18:19:20 -0400
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3WXowagcKCmgPXNORQKMUUMRK.IUSWKSa-JKbKRTUTMTa.UXM@flex--jrhilke.bounces.google.com>)
 id 1wZFeE-0008ME-CW
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 18:19:18 -0400
Received: by mail-pg1-x54a.google.com with SMTP id
 41be03b00d2f7-c85dc345ac8so2140102a12.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 15:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781561946; x=1782166746; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=yhfF4jlqwv2iVer4SiDpKpg+RBMlVSrisJluQj4yrtw=;
 b=pc7kAGVlhnrDkNLeSPnj+qAat334gnM8ru4QrDDKGJTvcj3FekZus3J1HPuHST6KIW
 t3j9YQifur+j1uczD80n5O/+xU/xJtJj7AVsUNR/uLBhLQ1Va1Npk1hbsKOtyr2F236r
 9+EZdbUX9JDApn2ll2ulp4cJSSwZ3t9bQyyjgQAHZN5H6TYyIi5gLNAmMypsOJT1c3G5
 5nrJa5wLgIknC9kv6T167RMT7lj01nYCu2FX2zeR8GmNZsa2J63srhsOBEnBsp77ZKiG
 lpzQfKrZZQOgapD8il+tnhXP33r1WBiRTqeaxJSgYVXtdnUd8e3ZO+MlMnJ/nHSF2u9w
 EYDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781561946; x=1782166746;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yhfF4jlqwv2iVer4SiDpKpg+RBMlVSrisJluQj4yrtw=;
 b=illnonz6NI8MzgIyfugnKZ8cDse3RC6JECaprpcV2frOZlplwGAdhbyfYgOVQ7Yd3/
 GJ4KDjUG+goJvx5bMEQML9xjYzjkgkn+XsPP93A7t8s3e6yy3nCfRrSSuJMRGQ1mV2Na
 ZBby21RyfT9OTMyh4vUiGrDBtB07Js8VH5UJH82WXgG9ecavU7IgEBYMLLh6mUlSjq6W
 3pWXvn8DCbRuQiOinuN1uW2Bq19ehYc6OTQFb4rokRa5LxCpDh0A6qc1pzvY3eQAj050
 S+2ssRiW82JHM6VENHPbkcnscsO4XN4LMvzE76b2uXhKxVL2uxUDdKNYiL/H5We3jJ/T
 glJQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9/2SgEW+AzLSD4WSVDl0MdSecYVvZBmmaXgX2mwaJq+KHSEZwkibji2/v0q548Xa4jjQBjBhMOVa2U@nongnu.org
X-Gm-Message-State: AOJu0Yxac8fzClNWRhwEkqq+92WIGDSmdSpK1FgdUS9dQsgaLTGgNL66
 +P0ylynF3mFVhW8Tz8LYdtNjLO2gecuUA9nrG3q7AGC8a/V/6CFSwQBWNU1zRxnzELPvSJMix5r
 jjZ65o81E
X-Received: from pgam22.prod.google.com ([2002:a05:6a02:2b56:b0:c82:7761:9941])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:8cca:b0:39b:d937:8020
 with SMTP id adf61e73a8af0-3b796445a27mr14534692637.42.1781561945942; Mon, 15
 Jun 2026 15:19:05 -0700 (PDT)
Date: Mon, 15 Jun 2026 22:18:03 +0000
In-Reply-To: <20260615-igb-trl-v4-0-cf5739bf529f@google.com>
Mime-Version: 1.0
References: <20260615-igb-trl-v4-0-cf5739bf529f@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260615-igb-trl-v4-1-cf5739bf529f@google.com>
Subject: [PATCH v4 1/7] igb: Define TRL registers and core state
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
 envelope-from=3WXowagcKCmgPXNORQKMUUMRK.IUSWKSa-JKbKRTUTMTa.UXM@flex--jrhilke.bounces.google.com;
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

Introduce register offsets and bitmask constants for the Transmit Rate
Limiter (TRL). Add the IGBTrlQueue structure and corresponding fields to
IGBCore to track TRL state (timers, throttling status, and target rates)
per queue. Initialize and free these timers during the device
realize/uninit lifecycle, and reset them on device reset.

Signed-off-by: Josh Hilke <jrhilke@google.com>
---
 hw/net/igb_common.h |  1 +
 hw/net/igb_core.c   | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/net/igb_core.h   | 13 ++++++++++++
 hw/net/igb_regs.h   |  6 ++++++
 4 files changed, 79 insertions(+)

diff --git a/hw/net/igb_common.h b/hw/net/igb_common.h
index b316a5b..8c0a0cf 100644
--- a/hw/net/igb_common.h
+++ b/hw/net/igb_common.h
@@ -148,6 +148,7 @@ enum {
     defreg(MTA_A),
 
     defreg(VTIVAR), defreg(VTIVAR_MISC),
+    defreg(TRLDQSEL), defreg(TRLRC),
 };
 
 uint64_t igb_mmio_read(void *opaque, hwaddr addr, unsigned size);
diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 45d8fd7..c94e8d3 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -96,6 +96,7 @@ igb_receive_internal(IGBCore *core, const struct iovec *iov, int iovcnt,
 
 static void igb_raise_interrupts(IGBCore *core, size_t index, uint32_t causes);
 static void igb_reset(IGBCore *core, bool sw);
+static uint32_t igb_trl_get_scaled_rate_factor(uint32_t trlrc);
 
 static inline void
 igb_raise_legacy_irq(IGBCore *core)
@@ -4282,6 +4283,53 @@ igb_autoneg_resume(IGBCore *core)
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
+    return trlrc & 0xFFFFFF;
+}
+
+bool igb_trl_enabled(uint32_t trlrc)
+{
+    return trlrc & E1000_TRLRC_RS_ENA;
+}
+
+uint64_t igb_trl_get_target_rate(const IGBTrlQueue *q)
+{
+    const uint64_t rf_scaled = igb_trl_get_scaled_rate_factor(q->trlrc);
+
+    if (!igb_trl_enabled(q->trlrc)) {
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
+static void igb_trl_timer_cb(void *opaque)
+{
+    /* Stub */
+}
+
 void
 igb_core_pci_realize(IGBCore        *core,
                      const uint16_t *eeprom_templ,
@@ -4296,6 +4344,11 @@ igb_core_pci_realize(IGBCore        *core,
 
     for (i = 0; i < IGB_NUM_QUEUES; i++) {
         net_tx_pkt_init(&core->tx[i].tx_pkt, E1000E_MAX_TX_FRAGS);
+        core->trl[i].timer =
+            timer_new_ns(QEMU_CLOCK_VIRTUAL, igb_trl_timer_cb,
+                         &core->trl[i]);
+        core->trl[i].core = core;
+        core->trl[i].queue_idx = i;
     }
 
     net_rx_pkt_init(&core->rx_pkt);
@@ -4319,6 +4372,7 @@ igb_core_pci_uninit(IGBCore *core)
 
     for (i = 0; i < IGB_NUM_QUEUES; i++) {
         net_tx_pkt_uninit(core->tx[i].tx_pkt);
+        timer_free(core->trl[i].timer);
     }
 
     net_rx_pkt_uninit(core->rx_pkt);
@@ -4469,6 +4523,11 @@ static void igb_reset(IGBCore *core, bool sw)
 
     igb_intrmgr_reset(core);
 
+    for (i = 0; i < IGB_NUM_QUEUES; i++) {
+        timer_del(core->trl[i].timer);
+        core->trl[i].trlrc = 0;
+    }
+
     memset(core->phy, 0, sizeof core->phy);
     memcpy(core->phy, igb_phy_reg_init, sizeof igb_phy_reg_init);
 
diff --git a/hw/net/igb_core.h b/hw/net/igb_core.h
index d70b54e..f3d50bc 100644
--- a/hw/net/igb_core.h
+++ b/hw/net/igb_core.h
@@ -63,6 +63,13 @@ typedef struct IGBIntrDelayTimer_st {
     IGBCore *core;
 } IGBIntrDelayTimer;
 
+typedef struct IGBTrlQueue_st {
+    QEMUTimer *timer;
+    IGBCore *core;
+    int queue_idx;
+    uint32_t trlrc;
+} IGBTrlQueue;
+
 struct IGBCore {
     uint32_t mac[E1000E_MAC_SIZE];
     uint16_t phy[MAX_PHY_REG_ADDRESS + 1];
@@ -99,6 +106,9 @@ struct IGBCore {
     void (*owner_start_recv)(PCIDevice *d);
 
     int64_t timadj;
+
+    /* Transmit Rate Limiting */
+    IGBTrlQueue trl[IGB_NUM_QUEUES];
 };
 
 void
@@ -143,4 +153,7 @@ igb_receive_iov(IGBCore *core, const struct iovec *iov, int iovcnt);
 void
 igb_start_recv(IGBCore *core);
 
+bool igb_trl_enabled(uint32_t trlrc);
+uint64_t igb_trl_get_target_rate(const IGBTrlQueue *q);
+
 #endif
diff --git a/hw/net/igb_regs.h b/hw/net/igb_regs.h
index 4dc4c31..9ef628b 100644
--- a/hw/net/igb_regs.h
+++ b/hw/net/igb_regs.h
@@ -718,4 +718,10 @@ static inline uint8_t igb_ivar_entry_tx(uint8_t i)
     return i < 8 ? i * 4 + 1 : (i - 8) * 4 + 3;
 }
 
+/* Transmit Rate Limiting */
+#define E1000_TRLDQSEL 0x03604
+#define E1000_TRLRC 0x036B0
+#define E1000_TRLRC_RS_ENA BIT(31)
+#define E1000_LINK_RATE_1GBPS (1000000000ULL / BITS_PER_BYTE)
+
 #endif

-- 
2.54.0.1136.gdb2ca164c4-goog


