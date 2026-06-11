Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E418FCD8C9D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 04:28:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXX1j-0001Y9-R3; Thu, 11 Jun 2026 00:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <32B0qagcKChU4C2365z19916z.x97Bz7F-yzGz689818F.9C1@flex--jrhilke.bounces.google.com>)
 id 1wXVC1-0002pF-BM
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 22:30:53 -0400
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <32B0qagcKChU4C2365z19916z.x97Bz7F-yzGz689818F.9C1@flex--jrhilke.bounces.google.com>)
 id 1wXVBz-0005JK-OM
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 22:30:53 -0400
Received: by mail-pg1-x54a.google.com with SMTP id
 41be03b00d2f7-c85dcdbe502so4879999a12.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 19:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781145049; x=1781749849; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=IGrhZUbWDNxRNr/VmBkxGwYqAwdJjbdMEgKZGMTEtzo=;
 b=tcVmpiinfsGW6ElM4YKoraFmdKCBg7jJLAdnIEtivSISsKeXQCidHUGu5B+Y44cnqB
 7cf3igQsX/i4agy5fvs7QG8GfMi41pyHrS3CF6wUAy6nKbrofhBjC0NcVCnwt8MiVjeO
 89FYJPAh5Sq57fjbVPe64FrhBoV8nddB6ibpuX/67CBInftUc4sI9BGUF1nlg/2NgyJp
 svlzOKwOvDvDInGB16s2Y1tP8uvArXFs/4Lcm/8mjnOBKrXwZS0LKzKjdFQG6HGMjB0s
 j5ckToVS7KnInbQ+Q9AMGhUok7BxE4nwaI0VQuHxHEvo74iYvECe+ZgCi6AxdRQXHgjP
 CHUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781145049; x=1781749849;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IGrhZUbWDNxRNr/VmBkxGwYqAwdJjbdMEgKZGMTEtzo=;
 b=cIR6aUTRqg46OA8h7iXRHimvYpK0EntuEsNGQIaR4kq8eHzMQDCNclAC0cTTT2cd12
 bGCRRVKJRLADqGokZc6PzDZYCCMf0QjXjzATv3AploIRD49Ptms3CxLRdFhIjCO2X2db
 9JSGNHAH2aldwABxgimXCRu5G1DfjjPcA5kfgHTwQiQaQ6Yt+/g1zOIg8vYX6Ly7SJoQ
 oiwfeT9F7kRPgsYAKqjEL5VPtEtZFGlipH3j+QY39tch0/yIvNpviUcW/9L8oJ8Wh4Eg
 M4cuhn/GAKyFMsjB2s8rgQ5/QcBx5CodzeKCRf0m4UNP4L3SGnAFXHss5yL+VvVIBxnZ
 KRYw==
X-Gm-Message-State: AOJu0Yy6vk7HuA5Ka8aq2+7NoIfkqQqDpBXQO4J4DmcuS5JQam2+Gt8Z
 16QrQBS2WdzqkYeFIhrAJQBuIIJnMsdoJGxnvf8/fzwm47Vqb9Fr/3oELnIXiii1rHEVUmdpdkz
 FSrVV/anTW/3IU098+XhdT8+lDvH3hWRcThme3B62rjtE8gxwXH8eC6Bx2EGYOVo6zkdlk3bgoJ
 u4IWEkDkwvI6XSJS+nqMqvPGoz+fC2sndVAEIKQNk=
X-Received: from pfve14.prod.google.com ([2002:a05:6a00:1a8e:b0:839:372f:479c])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:181c:b0:82a:7893:e14b
 with SMTP id d2e1a72fcca58-84336aa0581mr788738b3a.38.1781145048278; Wed, 10
 Jun 2026 19:30:48 -0700 (PDT)
Date: Thu, 11 Jun 2026 02:30:24 +0000
In-Reply-To: <20260611023028.102071-1-jrhilke@google.com>
Mime-Version: 1.0
References: <20260611023028.102071-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260611023028.102071-2-jrhilke@google.com>
Subject: [PATCH 1/5] igb: Define TRL registers and core state
From: Josh Hilke <jrhilke@google.com>
To: qemu-devel@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Josh Hilke <jrhilke@google.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::54a;
 envelope-from=32B0qagcKChU4C2365z19916z.x97Bz7F-yzGz689818F.9C1@flex--jrhilke.bounces.google.com;
 helo=mail-pg1-x54a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 11 Jun 2026 00:28:21 -0400
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
Limiter (TRL). Add the IGBTrlTimer structure and corresponding fields to
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
index 45d8fd7..64f21c1 100644
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
+        core->trl_timer[i].timer =
+            timer_new_ns(QEMU_CLOCK_VIRTUAL, igb_trl_timer_cb,
+                         &core->trl_timer[i]);
+        core->trl_timer[i].core = core;
+        core->trl_timer[i].queue_idx = i;
     }
 
     net_rx_pkt_init(&core->rx_pkt);
@@ -4319,6 +4329,7 @@ igb_core_pci_uninit(IGBCore *core)
 
     for (i = 0; i < IGB_NUM_QUEUES; i++) {
         net_tx_pkt_uninit(core->tx[i].tx_pkt);
+        timer_free(core->trl_timer[i].timer);
     }
 
     net_rx_pkt_uninit(core->rx_pkt);
@@ -4469,6 +4480,12 @@ static void igb_reset(IGBCore *core, bool sw)
 
     igb_intrmgr_reset(core);
 
+    for (i = 0; i < IGB_NUM_QUEUES; i++) {
+        timer_del(core->trl_timer[i].timer);
+        core->trl_throttled[i] = false;
+        core->trl_target_rate[i] = 0;
+    }
+
     memset(core->phy, 0, sizeof core->phy);
     memcpy(core->phy, igb_phy_reg_init, sizeof igb_phy_reg_init);
 
diff --git a/hw/net/igb_core.h b/hw/net/igb_core.h
index d70b54e..ffd45ed 100644
--- a/hw/net/igb_core.h
+++ b/hw/net/igb_core.h
@@ -63,6 +63,12 @@ typedef struct IGBIntrDelayTimer_st {
     IGBCore *core;
 } IGBIntrDelayTimer;
 
+typedef struct IGBTrlTimer_st {
+    QEMUTimer *timer;
+    IGBCore *core;
+    int queue_idx;
+} IGBTrlTimer;
+
 struct IGBCore {
     uint32_t mac[E1000E_MAC_SIZE];
     uint16_t phy[MAX_PHY_REG_ADDRESS + 1];
@@ -99,6 +105,11 @@ struct IGBCore {
     void (*owner_start_recv)(PCIDevice *d);
 
     int64_t timadj;
+
+    /* Transmit Rate Limiting */
+    IGBTrlTimer trl_timer[IGB_NUM_QUEUES];
+    bool trl_throttled[IGB_NUM_QUEUES];
+    uint64_t trl_target_rate[IGB_NUM_QUEUES]; /* in bytes per second */
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


