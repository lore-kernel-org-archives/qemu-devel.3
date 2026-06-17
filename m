Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3150CD98F0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 20:17:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZwgH-0002bg-Gd; Wed, 17 Jun 2026 16:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3hwAzagcKCqwVdTUXWQSaaSXQ.OaYcQYg-PQhQXZaZSZg.adS@flex--jrhilke.bounces.google.com>)
 id 1wZwgF-0002ab-Eh
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 16:16:11 -0400
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3hwAzagcKCqwVdTUXWQSaaSXQ.OaYcQYg-PQhQXZaZSZg.adS@flex--jrhilke.bounces.google.com>)
 id 1wZwgD-0002rw-Vg
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 16:16:11 -0400
Received: by mail-pl1-x64a.google.com with SMTP id
 d9443c01a7336-2c6a997c400so10592425ad.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 13:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781727368; x=1782332168; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=zr5cAgisuTTwj1uLp4YSvgrOqin2FJi9yi3VNvJGcqA=;
 b=XrJaAAiW1B5gKIoT7+H0U5zqHv2iRWuOTDjSFn3ja64QVjSp8zxPu6LD9xONR4jL8Q
 OwxwLz29e2aKZdP3JQE9JRxCYiqbF0PbaoE7HLOvWv7DdzByLQAQk8hfJnR7J/OuI9iE
 sp0Y8DeUuHB29kb9ukB8hqMTTReUdd8nHN4sVNHogwyAg00c9g/l4whaaEUwI1eRy2Mw
 ONEjKhJGSroht/LFp7aUr15e4F3FpkZln2gARIFP01hhBr4vNLmC4dvWP49BLme7N6sA
 7Xap1tyIDa7Pu9fZPJ3x4t3HzByORgIhNkkBgEiT+LSZ1lOTfqsaEWE1sT3pMzyuwduF
 IE2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781727368; x=1782332168;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zr5cAgisuTTwj1uLp4YSvgrOqin2FJi9yi3VNvJGcqA=;
 b=VdAd+HCBYb86Rl4shI2d7Zxb56EMNiiZDBtWi7MafqKzHBB2Jc6OZMK++jvT/tBCRH
 Bas7+/Dl/rSpWavNZUSPIxo8dj2OoVlN6lLcAXxDHv1g7J3SkMOc1Bf4r++onIfC2d1e
 fjij6Ihk2gi0bMTsMFxawd+PweWyV5ffzX35Dxw2CweJAe1+bAD5clWXaPuL1nNwG9yM
 32mfOHrzsjQc42kK4OM0Uz6F4Drj/C0vWU41sCI7RTucf7oKS9iOuvRXIbKOXCHNdWKg
 V0kaFp9pvW7/KpDMra7qtai2MHDcPkwSR9y4OiRHcdbeCxTRuIfO/3y0tdYFqQwXansf
 mNaw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9aDShjfMohXySIZnE54ePl1IT+te7P1A2ixN0CcSCgHfe7kudqoXTPgvDWKoyAPVm/QRNh5ridfsF6@nongnu.org
X-Gm-Message-State: AOJu0YwhkymSm97QRuw4aiTt+Vf9PlNbSVlID2mHMa/Lz/5bZ5RgzMWd
 KQZuYyn9ktd9MCeIpsD6+tK7g/TE8NBUQhYx+8Msdd0S0OUSdt3u2N9xPLo6zUBd+XjSln6MHQ5
 RL6wih47S
X-Received: from plgv5.prod.google.com ([2002:a17:902:e8c5:b0:2c6:a183:90e6])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2b06:b0:2bc:e299:4b3f
 with SMTP id d9443c01a7336-2c6de418458mr6859965ad.10.1781727367829; Wed, 17
 Jun 2026 13:16:07 -0700 (PDT)
Date: Wed, 17 Jun 2026 20:15:48 +0000
In-Reply-To: <20260617-igb-trl-v6-0-bbdfcadb81e2@google.com>
Mime-Version: 1.0
References: <20260617-igb-trl-v6-0-bbdfcadb81e2@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260617-igb-trl-v6-3-bbdfcadb81e2@google.com>
Subject: [PATCH v6 3/7] igb: Implement TRL register write and configuration
From: Josh Hilke <jrhilke@google.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Josh Hilke <jrhilke@google.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::64a;
 envelope-from=3hwAzagcKCqwVdTUXWQSaaSXQ.OaYcQYg-PQhQXZaZSZg.adS@flex--jrhilke.bounces.google.com;
 helo=mail-pl1-x64a.google.com
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
 hw/net/igb_core.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 44e8e58..65403f9 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -2145,11 +2145,20 @@ static void igb_trl_reset(IGBCore *core)
     }
 }
 
+static void igb_trl_disable(IGBTrlQueue *q)
+{
+    q->trlrc &= ~E1000_TRLRC_RS_ENA;
+}
+
 void igb_core_set_link_status(IGBCore *core)
 {
     NetClientState *nc = qemu_get_queue(core->owner_nic);
     uint32_t old_status = core->mac[STATUS];
 
+    for (int i = 0; i < IGB_NUM_QUEUES; i++) {
+        igb_trl_disable(&core->trl[i]);
+    }
+
     trace_e1000e_link_status_changed(nc->link_down ? false : true);
 
     if (nc->link_down) {
@@ -2632,6 +2641,29 @@ static void igb_set_vtivar(IGBCore *core, int index, uint32_t val)
      */
 }
 
+static uint32_t igb_get_trlrc(IGBCore *core, int index)
+{
+    const uint32_t qidx = core->mac[TRLDQSEL];
+
+    return core->trl[qidx].trlrc;
+}
+
+static void igb_set_trldqsel(IGBCore *core, int index, uint32_t val)
+{
+    core->mac[index] = extract32(val, 0, 4);
+}
+
+static void igb_set_trlrc(IGBCore *core, int index, uint32_t val)
+{
+    const uint32_t qidx = core->mac[TRLDQSEL];
+
+    core->trl[qidx].trlrc = val;
+
+    if (!igb_trl_enabled(&core->trl[qidx])) {
+        igb_trl_disable(&core->trl[qidx]);
+    }
+}
+
 static inline void
 igb_autoneg_timer(void *opaque)
 {
@@ -3687,6 +3719,7 @@ static const readops igb_macreg_readops[] = {
     [RQDPC15] = igb_mac_read_clr4,
     [VTIVAR ... VTIVAR + 7] = igb_mac_readreg,
     [VTIVAR_MISC ... VTIVAR_MISC + 7] = igb_mac_readreg,
+    [TRLRC] = igb_get_trlrc,
 };
 enum { IGB_NREADOPS = ARRAY_SIZE(igb_macreg_readops) };
 
@@ -4135,7 +4168,9 @@ static const writeops igb_macreg_writeops[] = {
     [PVTEICR6] = igb_set_vteicr,
     [PVTEICR7] = igb_set_vteicr,
     [VTIVAR ... VTIVAR + 7] = igb_set_vtivar,
-    [VTIVAR_MISC ... VTIVAR_MISC + 7] = igb_mac_writereg
+    [VTIVAR_MISC ... VTIVAR_MISC + 7] = igb_mac_writereg,
+    [TRLDQSEL] = igb_set_trldqsel,
+    [TRLRC]    = igb_set_trlrc,
 };
 enum { IGB_NWRITEOPS = ARRAY_SIZE(igb_macreg_writeops) };
 

-- 
2.55.0.rc0.738.g0c8ab3ebcc-goog


