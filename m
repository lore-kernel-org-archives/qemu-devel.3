Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 004A3CD98CF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 21:52:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY9m2-00021f-JW; Fri, 12 Jun 2026 17:50:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3MH8sagcKCjkemcdgfZbjjbgZ.XjhlZhp-YZqZgijibip.jmb@flex--jrhilke.bounces.google.com>)
 id 1wY9m0-00021B-MA
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 17:50:44 -0400
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3MH8sagcKCjkemcdgfZbjjbgZ.XjhlZhp-YZqZgijibip.jmb@flex--jrhilke.bounces.google.com>)
 id 1wY9ly-0005IH-P4
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 17:50:44 -0400
Received: by mail-pf1-x44a.google.com with SMTP id
 d2e1a72fcca58-8422382178bso939092b3a.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2026 14:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781301040; x=1781905840; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=t1e8IOkuBS5/he+neFGKbmceLimzQDRO25wGIWG4+aY=;
 b=amLAkO1+xDy3EH6r+MEJh8Ew/Z3qLY/mE88obxsWkqYj8TWCL8bW4sjL/tixB+NZ6b
 Ficy7FRi29AeELiYeJRflOpHtAbGCBGeBALTemd3sC2emFQHcrUAhmb97MmZ95eaRsgU
 ITesvjwAOUtjwXLojOs2OPFHcuSQ8BZCEG75bPYPRK2nSiyQO/gBG7Sn29z8+VPATlnZ
 ZJUn8TZkGiLMS4cSK+tmWfIO49GcY3NgwNIp/K8rW29km2dGZsljcdVn5BFdTBkx3GLJ
 bURGdoQIwu7LP8MXuxQXkO273oEgpI7kUaSno3ff8qkh1oDW2GYQpJilewfqjta+X+bz
 rq5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781301040; x=1781905840;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t1e8IOkuBS5/he+neFGKbmceLimzQDRO25wGIWG4+aY=;
 b=Ckffvr8A2oPmWPsnf98ROJImpRLS4BjFS9G+fx9gi74Ur8iF6J2fwk+qtn+t/LllIX
 Koo2z+Y3E5WcQ0A9yT44lwQFgwnGM5pslKT6vU/TfAxkYHVQDfh3Z6ht2uwa08jVShET
 AMSFOEEioijE7/K280zRtdScysd5NDZuUI7RuOd0dUCg6Ce5s2UD/g679zmiVNsEvRiP
 GknNfD2fQ3AbFckt3BeTJuVdRZjp2GddsUCkBHbPVp85HVRVG57KTOApNYG+UKSPI+EL
 afWYA4B4eIFbZi0n0KfX7CSOCdZQXTVXhCENAhCxlYhFsiH3B75HuQk1IZg12Q53SmUl
 +n+Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Ljw6huvonGV5q3S9MKWp64f8IX2g5dPCoPF/hQFsYFnCodQ9bhXccKxfFIzBHTtHitfRCHGpGkrLi@nongnu.org
X-Gm-Message-State: AOJu0Yy7k2OOGEyfcKjWxf7yvTSrgHvSdbVRG++LWBh/uzMq2jZrxs2b
 a50hcl/tscBSMwJYjEkTd07IWFCxTw9lZpOgq2zcRs4i/WbngVtKvuBxc7nKSWg9KjhUnPNKRAF
 pi10lWRks
X-Received: from pfbho5.prod.google.com ([2002:a05:6a00:8805:b0:835:2a09:221c])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:12d2:b0:842:8985:340
 with SMTP id d2e1a72fcca58-8434cf4ee62mr4965679b3a.35.1781301040293; Fri, 12
 Jun 2026 14:50:40 -0700 (PDT)
Date: Fri, 12 Jun 2026 21:50:12 +0000
In-Reply-To: <20260612-igb-trl-v3-0-19607f9a3dde@google.com>
Mime-Version: 1.0
References: <20260612-igb-trl-v3-0-19607f9a3dde@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260612-igb-trl-v3-1-19607f9a3dde@google.com>
Subject: [PATCH v3 1/7] igb: Define TRL registers and core state
From: Josh Hilke <jrhilke@google.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Josh Hilke <jrhilke@google.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::44a;
 envelope-from=3MH8sagcKCjkemcdgfZbjjbgZ.XjhlZhp-YZqZgijibip.jmb@flex--jrhilke.bounces.google.com;
 helo=mail-pf1-x44a.google.com
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
 hw/net/igb_core.c   | 40 ++++++++++++++++++++++++++++++++++++++++
 hw/net/igb_core.h   | 12 ++++++++++++
 hw/net/igb_regs.h   | 11 +++++++++++
 4 files changed, 64 insertions(+)

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
index 45d8fd7..31f2644 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -4282,6 +4282,35 @@ igb_autoneg_resume(IGBCore *core)
     }
 }
 
+uint64_t igb_trl_get_target_rate(const IGBTrlQueue *q)
+{
+    const uint64_t rf_scaled = q->trlrc & 0xFFFFFF;
+
+    if (!(q->trlrc & E1000_TRLRC_RS_ENA)) {
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
@@ -4296,6 +4325,11 @@ igb_core_pci_realize(IGBCore        *core,
 
     for (i = 0; i < IGB_NUM_QUEUES; i++) {
         net_tx_pkt_init(&core->tx[i].tx_pkt, E1000E_MAX_TX_FRAGS);
+        core->trl[i].timer =
+            timer_new_ns(QEMU_CLOCK_VIRTUAL, igb_trl_timer_cb,
+                         &core->trl[i]);
+        core->trl[i].core = core;
+        core->trl[i].queue_idx = i;
     }
 
     net_rx_pkt_init(&core->rx_pkt);
@@ -4319,6 +4353,7 @@ igb_core_pci_uninit(IGBCore *core)
 
     for (i = 0; i < IGB_NUM_QUEUES; i++) {
         net_tx_pkt_uninit(core->tx[i].tx_pkt);
+        timer_free(core->trl[i].timer);
     }
 
     net_rx_pkt_uninit(core->rx_pkt);
@@ -4469,6 +4504,11 @@ static void igb_reset(IGBCore *core, bool sw)
 
     igb_intrmgr_reset(core);
 
+    for (i = 0; i < IGB_NUM_QUEUES; i++) {
+        timer_del(core->trl[i].timer);
+        core->trl[i].trlrc = 0;
+    }
+
     memset(core->phy, 0, sizeof core->phy);
     memcpy(core->phy, igb_phy_reg_init, sizeof igb_phy_reg_init);
 
diff --git a/hw/net/igb_core.h b/hw/net/igb_core.h
index d70b54e..ec83e4f 100644
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
@@ -143,4 +153,6 @@ igb_receive_iov(IGBCore *core, const struct iovec *iov, int iovcnt);
 void
 igb_start_recv(IGBCore *core);
 
+uint64_t igb_trl_get_target_rate(const IGBTrlQueue *q);
+
 #endif
diff --git a/hw/net/igb_regs.h b/hw/net/igb_regs.h
index 4dc4c31..f7895ef 100644
--- a/hw/net/igb_regs.h
+++ b/hw/net/igb_regs.h
@@ -718,4 +718,15 @@ static inline uint8_t igb_ivar_entry_tx(uint8_t i)
     return i < 8 ? i * 4 + 1 : (i - 8) * 4 + 3;
 }
 
+/* Transmit Rate Limiting */
+#define E1000_TRLDQSEL 0x03604
+#define E1000_TRLRC    0x036B0
+
+#define E1000_TRLRC_RS_ENA      BIT(31)
+#define E1000_TRLRC_RF_DEC_MASK 0x3FFF
+#define E1000_TRLRC_RF_INT_MASK 0x3FF
+
+/* 1 Gbps link rate in bytes per second (1,000,000,000 bits/s / 8) */
+#define E1000_LINK_RATE_1GBPS 125000000ULL
+
 #endif

-- 
2.54.0.1136.gdb2ca164c4-goog


