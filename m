Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3875CDB466
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 19:07:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbjyA-0000Wr-Mv; Mon, 22 Jun 2026 15:06:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3l4c5agcKCuQPXNORQKMUUMRK.IUSWKSa-JKbKRTUTMTa.UXM@flex--jrhilke.bounces.google.com>)
 id 1wbjy8-0000VQ-C5
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 15:06:05 -0400
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3l4c5agcKCuQPXNORQKMUUMRK.IUSWKSa-JKbKRTUTMTa.UXM@flex--jrhilke.bounces.google.com>)
 id 1wbjy6-0002kc-L3
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 15:06:04 -0400
Received: by mail-pf1-x449.google.com with SMTP id
 d2e1a72fcca58-8421f5d76aaso3237255b3a.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 12:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1782155160; x=1782759960; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=0knJfWc2/EoxbOlmqi5tm+B31wbO8BiGu9Idv2u8VvU=;
 b=mFXxECr0cOL3oxDYBZSQOpduQYyl2YlhwCp6LvqH7hmq2eZwLpjuGDCutPE4oHj5nH
 4CvpMhVot9j6ZlG3zJZio99RTwxCo65gNPGmFnBXpAxqV7jAwKbYI4iE9RlW9wiSMHO0
 T77x79S5FPFlrhP+iZRQxGb9mTeTfXhw3LkEFVBr65UkUTxRQ1+th9SLhA7xhrwcDJte
 G9ecYfa7WEW7VOJHFNv7QWxnMunKDxj/oZ6DRMsoy8YZFmxjrEbxHnnc2ssYahkJVmll
 yUppJn0TvsxCun41nccsLu88pI7+2DNDjdJkmMcoSMpciV2WaYPJwi6XMF4mNREdiLvk
 9hmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782155160; x=1782759960;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0knJfWc2/EoxbOlmqi5tm+B31wbO8BiGu9Idv2u8VvU=;
 b=K9SiIBsTCk5zTTscPSImiErd1ftAAEXwzNUHE+cyU/ZfaI7IAdl7OUBF3ICgBlBoQR
 x4ftFXQSqx9AHUz12BRH3m33gH/+afBArWVA/llES+fy0ApmYVmrgXQRDQoSzThjbBKM
 JEeelmD1bn0hXWCslpuDh0dLhAOpbBBteb3oln2JuqglKthMvkSAUlf2/X3QyNTfNHdn
 qWsuuiktomUSwUYR0w2C85ZNf5jT6LHeH+BSI4HkF3qNq0T6+4xh4pkNzBoKSX3YaqEc
 q43/KeCv7RiNTcb+1HJUt9l04f0K+ObaGScmdKj6Bm01qWl3h/HH36DZkp1/dOcDJqRU
 tzqA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/CFpC7y5UHJilJMQ85Jo/YiUH8a0ZY+Fq33jP0QOUWuhgx0GMQqu1lQJFNmLQ4+6bEIWU74sO4KaRP@nongnu.org
X-Gm-Message-State: AOJu0YyQjjHTUEK7QplIpKXUmZJsgxUUW60EVtq4VdhxcJGWeneGZU6/
 iOhKxCYME8sYSPLpKlyPzvl4e9cebpBJpEHwBNuViHdNX9eTVW9813YanC8TubR7C3ce8S8OOsy
 0SD0h7Aln
X-Received: from pfbkm55.prod.google.com
 ([2002:a05:6a00:3c77:b0:842:3c77:598c])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1792:b0:842:6a3b:60c9
 with SMTP id d2e1a72fcca58-8455087226bmr16004423b3a.24.1782155159599; Mon, 22
 Jun 2026 12:05:59 -0700 (PDT)
Date: Mon, 22 Jun 2026 19:05:38 +0000
In-Reply-To: <20260622-igb-trl-v7-0-abb960e767ac@google.com>
Mime-Version: 1.0
References: <20260622-igb-trl-v7-0-abb960e767ac@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260622-igb-trl-v7-1-abb960e767ac@google.com>
Subject: [PATCH v7 1/7] igb: Define TRL registers and core state
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
 envelope-from=3l4c5agcKCuQPXNORQKMUUMRK.IUSWKSa-JKbKRTUTMTa.UXM@flex--jrhilke.bounces.google.com;
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
 hw/net/igb_regs.h   |  5 +++++
 4 files changed, 59 insertions(+)

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
index 4dc4c31..4c31e4b 100644
--- a/hw/net/igb_regs.h
+++ b/hw/net/igb_regs.h
@@ -718,4 +718,9 @@ static inline uint8_t igb_ivar_entry_tx(uint8_t i)
     return i < 8 ? i * 4 + 1 : (i - 8) * 4 + 3;
 }
 
+/* Transmit Rate Limiting */
+#define E1000_TRLDQSEL 0x03604
+#define E1000_TRLRC 0x036B0
+#define E1000_TRLRC_RS_ENA BIT(31)
+
 #endif

-- 
2.55.0.rc0.786.g65d90a0328-goog


