Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A5B8CD98F2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 20:16:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZwgF-0002af-M4; Wed, 17 Jun 2026 16:16:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3hQAzagcKCqoTbRSVUOQYYQVO.MYWaOWe-NOfOVXYXQXe.YbQ@flex--jrhilke.bounces.google.com>)
 id 1wZwgD-0002Zv-Jx
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 16:16:09 -0400
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3hQAzagcKCqoTbRSVUOQYYQVO.MYWaOWe-NOfOVXYXQXe.YbQ@flex--jrhilke.bounces.google.com>)
 id 1wZwgB-0002ol-VY
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 16:16:09 -0400
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-36bbcd40642so67739a91.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 13:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781727366; x=1782332166; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=FEvtWj3r4LW5e8S8uhN/YmsaM6S2vyKxTPj8HfvAaYg=;
 b=Ll4YZZ1/nIDj2d2RskMr+lU0DYVMEi/rurq4XnEEpZgbGLnQZerC2bxXrf/sc3eKTN
 97g9QrIc4MiFJL6wnWbP67CEPirK3ZlqciGudgA2d1cxlUiXH3ZOc4vmEOS+HRG07iIp
 9kRnufoLoV+rxLYhW+GyrGLyvE+9QiUPvoruqLpfA+ZbThoGx89NND//C6RcDccn527F
 cUBrQ6y8Ghapa3FwCiCl89538iMmI3xRWFRIcGpoRXGvp76VbW8KzGM+saxQ+nP6XeKM
 wjDpq8qNHo6GN8qd7Nax25yJ+X97o0l6Qefrz/+iClLYAi7n5nsH5E33iheW3f78kZEz
 8Oig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781727366; x=1782332166;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FEvtWj3r4LW5e8S8uhN/YmsaM6S2vyKxTPj8HfvAaYg=;
 b=NimRQh/1fcgADOd/41IzDw4eCfEpkXOoiuTOUeQJ/i4Iv9xJc7F68n8yAdRIWkFl/0
 k8wyB1vh5MQk1cppJ4a2Kja9qs3lNmb7pt/c48jYu1JQCFPu5YMyy63WbdzAT9Rsq8iC
 Q03QUuLOeT2iWq7LWGv6VWjqUcNXehFm90iTD6DOyAAcQM6Obvz7jN5On/4o50Fd+KX3
 C0BhlOh6FZDVr1irUigcDhgO5WHzZCxpedElynvp+v0IYxg8qzpFZjwa2y0mmsZHXB34
 RZhyJ66KxSfWkCACWwJ45liATcCkNsUo8/zTbFLIP4HZDdoFpvXrIkzeyYT52PM0AQZf
 RgqQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9aKzULkhLBBhw9tRF+KwRGvTrTWctcnfDqOUxfSpot6sLVyJy2SUH10uyK31PHsk4vlX+AgizavYJn@nongnu.org
X-Gm-Message-State: AOJu0Yw1kng8GTYu1GPt5yP5wHz3zI/+/yUr8Gos1OS2yXWj0OBAgQN/
 m/n8LooxyBKF0ZMrTx3uLPg7nlJudKY5LdQ+pZ1zO7vKjhbGZGyz9eft4Y+YqVI0SIUmnK86oGY
 9Y3dZtLC8
X-Received: from pjug23.prod.google.com ([2002:a17:90a:ce97:b0:365:d4d8:94c3])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:558c:b0:36d:81b3:61a1
 with SMTP id 98e67ed59e1d1-37c930d223cmr5343082a91.7.1781727365805; Wed, 17
 Jun 2026 13:16:05 -0700 (PDT)
Date: Wed, 17 Jun 2026 20:15:46 +0000
In-Reply-To: <20260617-igb-trl-v6-0-bbdfcadb81e2@google.com>
Mime-Version: 1.0
References: <20260617-igb-trl-v6-0-bbdfcadb81e2@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260617-igb-trl-v6-1-bbdfcadb81e2@google.com>
Subject: [PATCH v6 1/7] igb: Define TRL registers and core state
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
 envelope-from=3hQAzagcKCqoTbRSVUOQYYQVO.MYWaOWe-NOfOVXYXQXe.YbQ@flex--jrhilke.bounces.google.com;
 helo=mail-pj1-x104a.google.com
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
 hw/net/igb_core.c   | 41 +++++++++++++++++++++++++++++++++++++++++
 hw/net/igb_core.h   | 12 ++++++++++++
 hw/net/igb_regs.h   |  6 ++++++
 4 files changed, 60 insertions(+)

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
index 45d8fd7..44e8e58 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -2136,6 +2136,15 @@ igb_set_phy_ctrl(IGBCore *core, uint16_t val)
     }
 }
 
+
+static void igb_trl_reset(IGBCore *core)
+{
+    for (int i = 0; i < IGB_NUM_QUEUES; i++) {
+        core->trl[i].trlrc = 0;
+        timer_del(core->trl[i].timer);
+    }
+}
+
 void igb_core_set_link_status(IGBCore *core)
 {
     NetClientState *nc = qemu_get_queue(core->owner_nic);
@@ -4282,6 +4291,33 @@ igb_autoneg_resume(IGBCore *core)
     }
 }
 
+bool igb_trl_enabled(const IGBTrlQueue *q)
+{
+    return q->trlrc & E1000_TRLRC_RS_ENA;
+}
+
+static void igb_trl_timer_cb(void *opaque)
+{
+    /* Stub */
+}
+
+static void igb_trl_init(IGBCore *core)
+{
+    for (int i = 0; i < IGB_NUM_QUEUES; i++) {
+        IGBTrlQueue *q = &core->trl[i];
+        q->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, igb_trl_timer_cb, q);
+        q->core = core;
+        q->qidx = i;
+    }
+}
+
+static void igb_trl_uninit(IGBCore *core)
+{
+    for (int i = 0; i < IGB_NUM_QUEUES; i++) {
+        timer_free(core->trl[i].timer);
+    }
+}
+
 void
 igb_core_pci_realize(IGBCore        *core,
                      const uint16_t *eeprom_templ,
@@ -4297,6 +4333,7 @@ igb_core_pci_realize(IGBCore        *core,
     for (i = 0; i < IGB_NUM_QUEUES; i++) {
         net_tx_pkt_init(&core->tx[i].tx_pkt, E1000E_MAX_TX_FRAGS);
     }
+    igb_trl_init(core);
 
     net_rx_pkt_init(&core->rx_pkt);
 
@@ -4321,6 +4358,8 @@ igb_core_pci_uninit(IGBCore *core)
         net_tx_pkt_uninit(core->tx[i].tx_pkt);
     }
 
+    igb_trl_uninit(core);
+
     net_rx_pkt_uninit(core->rx_pkt);
 }
 
@@ -4469,6 +4508,8 @@ static void igb_reset(IGBCore *core, bool sw)
 
     igb_intrmgr_reset(core);
 
+    igb_trl_reset(core);
+
     memset(core->phy, 0, sizeof core->phy);
     memcpy(core->phy, igb_phy_reg_init, sizeof igb_phy_reg_init);
 
diff --git a/hw/net/igb_core.h b/hw/net/igb_core.h
index d70b54e..922d8cd 100644
--- a/hw/net/igb_core.h
+++ b/hw/net/igb_core.h
@@ -63,6 +63,13 @@ typedef struct IGBIntrDelayTimer_st {
     IGBCore *core;
 } IGBIntrDelayTimer;
 
+typedef struct IGBTrlQueue_st {
+    QEMUTimer *timer;
+    IGBCore *core;
+    uint32_t qidx;
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
 
+bool igb_trl_enabled(const IGBTrlQueue *q);
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
2.55.0.rc0.738.g0c8ab3ebcc-goog


