Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C0BCD98C7
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 00:03:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXpLw-0002Ci-CP; Thu, 11 Jun 2026 20:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3xiQragcKChU4C2365z19916z.x97Bz7F-yzGz689818F.9C1@flex--jrhilke.bounces.google.com>)
 id 1wXmhi-0000yw-DJ
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 17:12:48 -0400
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3xiQragcKChU4C2365z19916z.x97Bz7F-yzGz689818F.9C1@flex--jrhilke.bounces.google.com>)
 id 1wXmhe-0003n9-5o
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 17:12:43 -0400
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-36bc5e97950so346626a91.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 14:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781212359; x=1781817159; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=zsmQrxXQS0GZSlMoFbsnEtj40NovT50DHi4yNaZAVWU=;
 b=ggeFGIZ1Bbxatdn5mUnu2voJGYgshxIv0yEx8owQpMLb8QprTL2nbOgVrO5CitSQcg
 WYEN0FYw3YLu+dLmqufJ87ZT94e7R2gwBCs8t2c+iku3OkchHJ9ZfGgRH/BklkgrpDTp
 /ga9pxDh+PWh6BXdzsZ43GFFEkNlBInEu9LF0aa0nJBISYhm0zgh9DYkLu0hWcG/LQvo
 0SvlVkUOtukNMUMbvDPm1gXDPc2kkGEVrZMSYgYx9yjz3KDlAy8kqVCSn1Gl5OWA5wze
 MqNbUBRjHrAbscGVW3FKLlYrdDDqe+rgrSe7M7PbWEMMOeiP124rVYAxdZY1QleRi4vi
 PMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781212359; x=1781817159;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zsmQrxXQS0GZSlMoFbsnEtj40NovT50DHi4yNaZAVWU=;
 b=ZF0no7JvroVRfKQv2y5jw2hdfuCLJr3gpo8oNDYA+KpVCl9rKwajYbASt9MG9mt+fb
 LAyrgGceeeDJuKHVsNhK8VrLL42MiWRf42vfkxQZpRVSV8tQgmQTVS3VzxvhYD6SFuGK
 ng0IFXWgMrPOUSVA+ng78XJQ4zyAx82NwIh6qPk1bIbSkDlAjZuP2ZjAYg6TNvbI+tCS
 IKXSvMYATuCIgGnUcwKNse0SGzIqNky9P0q8ot2pOPyuBY5m7h9oUukEXvYcEdU9CXZd
 4gDXmwIjoEQbPNN6mdu/nG9L7OO/tRqIn6II/uzna8I03JYTwy3P//KF8QxvOlSKcb1m
 2ZdQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/9Hj0ee4TCZpJ5fMlULeMamlwz/XHO/3Y7AOZDZZfhwFRkZmhr9IiHMxe4W06fv1U6HXuOh6tuSwtW@nongnu.org
X-Gm-Message-State: AOJu0Yy25WAVkF+uDyK5etM3hmXaiujkdM1j3Cx6VEF5tL2gAYycx1/3
 iFxOT/U59S9m2xRZqMOC2hqFwFzqg078FaWD303KViaGLrybq3jyr2k2XSSzChwpZr8uv17lZUG
 jPme10bdt
X-Received: from pjbfv16.prod.google.com ([2002:a17:90b:e90:b0:36b:2665:a2a3])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:e7ce:b0:36d:ae6a:22ed
 with SMTP id 98e67ed59e1d1-37a041afaa2mr113350a91.22.1781212358685; Thu, 11
 Jun 2026 14:12:38 -0700 (PDT)
Date: Thu, 11 Jun 2026 21:11:26 +0000
In-Reply-To: <20260611-igb-trl-v2-0-bd58de9eb0fa@google.com>
Mime-Version: 1.0
References: <20260611-igb-trl-v2-0-bd58de9eb0fa@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260611-igb-trl-v2-1-bd58de9eb0fa@google.com>
Subject: [PATCH v2 1/7] igb: Define TRL registers and core state
From: Josh Hilke <jrhilke@google.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Josh Hilke <jrhilke@google.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::104a;
 envelope-from=3xiQragcKChU4C2365z19916z.x97Bz7F-yzGz689818F.9C1@flex--jrhilke.bounces.google.com;
 helo=mail-pj1-x104a.google.com
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

Introduce register offsets and bitmask constants for the Transmit Rate
Limiter (TRL). Add the IGBTrlQueue structure and corresponding fields to
IGBCore to track TRL state (timers, throttling status, and target rates)
per queue. Initialize and free these timers during the device
realize/uninit lifecycle, and reset them on device reset.

Signed-off-by: Josh Hilke <jrhilke@google.com>
---
 hw/net/igb_common.h |  1 +
 hw/net/igb_core.c   | 17 +++++++++++++++++
 hw/net/igb_core.h   | 11 +++++++++++
 hw/net/igb_regs.h   | 11 +++++++++++
 4 files changed, 40 insertions(+)

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
index 45d8fd7..05d8241 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -4282,6 +4282,11 @@ igb_autoneg_resume(IGBCore *core)
     }
 }
 
+static void igb_trl_timer_cb(void *opaque)
+{
+    /* Stub */
+}
+
 void
 igb_core_pci_realize(IGBCore        *core,
                      const uint16_t *eeprom_templ,
@@ -4296,6 +4301,11 @@ igb_core_pci_realize(IGBCore        *core,
 
     for (i = 0; i < IGB_NUM_QUEUES; i++) {
         net_tx_pkt_init(&core->tx[i].tx_pkt, E1000E_MAX_TX_FRAGS);
+        core->trl[i].timer =
+            timer_new_ns(QEMU_CLOCK_VIRTUAL, igb_trl_timer_cb,
+                         &core->trl[i]);
+        core->trl[i].core = core;
+        core->trl[i].queue_idx = i;
     }
 
     net_rx_pkt_init(&core->rx_pkt);
@@ -4319,6 +4329,7 @@ igb_core_pci_uninit(IGBCore *core)
 
     for (i = 0; i < IGB_NUM_QUEUES; i++) {
         net_tx_pkt_uninit(core->tx[i].tx_pkt);
+        timer_free(core->trl[i].timer);
     }
 
     net_rx_pkt_uninit(core->rx_pkt);
@@ -4469,6 +4480,12 @@ static void igb_reset(IGBCore *core, bool sw)
 
     igb_intrmgr_reset(core);
 
+    for (i = 0; i < IGB_NUM_QUEUES; i++) {
+        timer_del(core->trl[i].timer);
+        core->trl[i].trlrc = 0;
+        core->trl[i].target_rate = 0;
+    }
+
     memset(core->phy, 0, sizeof core->phy);
     memcpy(core->phy, igb_phy_reg_init, sizeof igb_phy_reg_init);
 
diff --git a/hw/net/igb_core.h b/hw/net/igb_core.h
index d70b54e..49733b1 100644
--- a/hw/net/igb_core.h
+++ b/hw/net/igb_core.h
@@ -63,6 +63,14 @@ typedef struct IGBIntrDelayTimer_st {
     IGBCore *core;
 } IGBIntrDelayTimer;
 
+typedef struct IGBTrlQueue_st {
+    QEMUTimer *timer;
+    IGBCore *core;
+    int queue_idx;
+    uint32_t trlrc;
+    uint64_t target_rate;
+} IGBTrlQueue;
+
 struct IGBCore {
     uint32_t mac[E1000E_MAC_SIZE];
     uint16_t phy[MAX_PHY_REG_ADDRESS + 1];
@@ -99,6 +107,9 @@ struct IGBCore {
     void (*owner_start_recv)(PCIDevice *d);
 
     int64_t timadj;
+
+    /* Transmit Rate Limiting */
+    IGBTrlQueue trl[IGB_NUM_QUEUES];
 };
 
 void
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


