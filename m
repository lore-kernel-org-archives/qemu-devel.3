Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D035CD98DE
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 22:20:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZFeS-00050B-2c; Mon, 15 Jun 2026 18:19:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3XXowagcKCmwTbRSVUOQYYQVO.MYWaOWe-NOfOVXYXQXe.YbQ@flex--jrhilke.bounces.google.com>)
 id 1wZFeK-0004vr-GM
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 18:19:22 -0400
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3XXowagcKCmwTbRSVUOQYYQVO.MYWaOWe-NOfOVXYXQXe.YbQ@flex--jrhilke.bounces.google.com>)
 id 1wZFeI-0008Mp-9d
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 18:19:20 -0400
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-2c0b1bb53a8so24154195ad.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 15:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781561950; x=1782166750; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=c+Ut7VXMVVKOm7Ds5xHh28zb95dDYWMajWTQ/Qfkv1w=;
 b=jmtqNu8nHIxhTVUgHFSqErS5WjuJ2mupUYMBIkbvH4lbmi0qUDnODaRIHrjaSvd5jS
 dqN9bitckhZRNsbwZWQNQznRjdW/s7/9U8+cLLv0rqOleHKo1fnU9AdNoktmDlRzb7oY
 6hOQR17HO1Pe/tqPgJ/RJ3wfsNbpyyrmzCEy4XKVCclGqxD4DS4O9U5Zl6qZmlJeTSg4
 sqkCDidA5KyVQXIdzu9OOdLX8Gtq5D1LQ5A8/CwYNtpOQ8ZkC1h/1k13I7NOzF0eUsAL
 PSQodzldOw+jzyC/gQfzCAGWMuPBGQ3LjBFFxEIlDUt90GT+IkQ/cD4ejfyjJIeGqV1I
 /CSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781561950; x=1782166750;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c+Ut7VXMVVKOm7Ds5xHh28zb95dDYWMajWTQ/Qfkv1w=;
 b=AyRbYR+CaoBm3hNh6pjRMvHRZx4vwOtRslStMC8cm6F8+p/dWqTYJBVojFYhoqMe9s
 wGdRAH7RsekRpYJ/6yZXK/SwZl8C4RoGcR0pMDB503UEbeMwbF39451Zcm4ZnBknHPPt
 CwI26ND1RMiPgmAATkfvVeRWsUnBLOEHkimW4ePltOP9PLmCiYe8RYAyoaaKTSlQQ9WL
 XJvr2oPmDCLMco12ZoIp+melFnHXuZ6xwZRkouQCqg9KT9i8A5W/e8ptyaYFXeLYa+/r
 HkfYxQpjfNr4plGPKEbxT+IbB4bOqXqmE+ZQFn2S/pANSGaZd2+MtlH2s/pXDAl88qln
 S6kw==
X-Forwarded-Encrypted: i=1;
 AFNElJ81fnC7r6ErDw6kdSjwp52xKzvKTIX5li79UwZRnhVmefNIwP28AU3uY63GWCTbbDDdZcpcp8uQp+Ae@nongnu.org
X-Gm-Message-State: AOJu0Yys4pHz8hXaglN+2mo7r4lak5HQETGt6Y6gRuWj20kaYz/2Nrbm
 BUiGze7ofLz6h/qUqjY/oIlsbp9RaNcLhA2ApdUd5FP0ViA0fHHH6yE6zIKn/aRn6PX3uh/+y3H
 CmSHtXoWr
X-Received: from plbkk6.prod.google.com ([2002:a17:903:706:b0:2b0:46bd:4fe5])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:3885:b0:2bd:9b0e:b43a
 with SMTP id d9443c01a7336-2c699a91247mr10884615ad.7.1781561949482; Mon, 15
 Jun 2026 15:19:09 -0700 (PDT)
Date: Mon, 15 Jun 2026 22:18:05 +0000
In-Reply-To: <20260615-igb-trl-v4-0-cf5739bf529f@google.com>
Mime-Version: 1.0
References: <20260615-igb-trl-v4-0-cf5739bf529f@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260615-igb-trl-v4-3-cf5739bf529f@google.com>
Subject: [PATCH v4 3/7] igb: Implement TRL register write and configuration
From: Josh Hilke <jrhilke@google.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Josh Hilke <jrhilke@google.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::649;
 envelope-from=3XXowagcKCmwTbRSVUOQYYQVO.MYWaOWe-NOfOVXYXQXe.YbQ@flex--jrhilke.bounces.google.com;
 helo=mail-pl1-x649.google.com
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

Implement write handlers for TLDQSEL and TRLRC registers to allow the
guest to configure Transmit Rate Limiting. Translate the register Rate
Factor into a physical target rate (bytes/sec) per queue.  Disable TRL
and clear timers when the link status changes or when TRL is disabled by
the guest.

Signed-off-by: Josh Hilke <jrhilke@google.com>
---
 hw/net/igb_core.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index c94e8d3..dea8136 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -2137,11 +2137,27 @@ igb_set_phy_ctrl(IGBCore *core, uint16_t val)
     }
 }
 
+static void igb_trl_disable_queue(IGBCore *core, int qidx)
+{
+    core->trl[qidx].trlrc = 0;
+
+    timer_del(core->trl[qidx].timer);
+}
+
+static void igb_trl_disable(IGBCore *core)
+{
+    for (int i = 0; i < IGB_NUM_QUEUES; i++) {
+        igb_trl_disable_queue(core, i);
+    }
+}
+
 void igb_core_set_link_status(IGBCore *core)
 {
     NetClientState *nc = qemu_get_queue(core->owner_nic);
     uint32_t old_status = core->mac[STATUS];
 
+    igb_trl_disable(core);
+
     trace_e1000e_link_status_changed(nc->link_down ? false : true);
 
     if (nc->link_down) {
@@ -2624,6 +2640,42 @@ static void igb_set_vtivar(IGBCore *core, int index, uint32_t val)
      */
 }
 
+static uint32_t igb_get_trlrc(IGBCore *core, int index)
+{
+    int qidx = core->mac[TRLDQSEL];
+
+    return core->trl[qidx].trlrc;
+}
+
+static void igb_set_trldqsel(IGBCore *core, int index, uint32_t val)
+{
+    core->mac[index] = val & 0xF;
+}
+
+static void igb_set_trlrc(IGBCore *core, int index, uint32_t val)
+{
+    uint64_t rf_scaled;
+    int qidx;
+
+    qidx = core->mac[TRLDQSEL];
+    core->trl[qidx].trlrc = val;
+
+    if (!igb_trl_enabled(val)) {
+        goto disable;
+    }
+
+    rf_scaled = igb_trl_get_scaled_rate_factor(val);
+
+    /* Zero is not a valid rate factor, treat as disabled */
+    if (rf_scaled == 0) {
+        goto disable;
+    }
+    return;
+
+disable:
+    igb_trl_disable_queue(core, qidx);
+}
+
 static inline void
 igb_autoneg_timer(void *opaque)
 {
@@ -3679,6 +3731,7 @@ static const readops igb_macreg_readops[] = {
     [RQDPC15] = igb_mac_read_clr4,
     [VTIVAR ... VTIVAR + 7] = igb_mac_readreg,
     [VTIVAR_MISC ... VTIVAR_MISC + 7] = igb_mac_readreg,
+    [TRLRC] = igb_get_trlrc,
 };
 enum { IGB_NREADOPS = ARRAY_SIZE(igb_macreg_readops) };
 
@@ -4127,7 +4180,9 @@ static const writeops igb_macreg_writeops[] = {
     [PVTEICR6] = igb_set_vteicr,
     [PVTEICR7] = igb_set_vteicr,
     [VTIVAR ... VTIVAR + 7] = igb_set_vtivar,
-    [VTIVAR_MISC ... VTIVAR_MISC + 7] = igb_mac_writereg
+    [VTIVAR_MISC ... VTIVAR_MISC + 7] = igb_mac_writereg,
+    [TRLDQSEL] = igb_set_trldqsel,
+    [TRLRC]    = igb_set_trlrc
 };
 enum { IGB_NWRITEOPS = ARRAY_SIZE(igb_macreg_writeops) };
 

-- 
2.54.0.1136.gdb2ca164c4-goog


