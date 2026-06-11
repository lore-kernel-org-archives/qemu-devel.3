Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EF13CD98D5
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 00:03:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXpLt-0002B2-70; Thu, 11 Jun 2026 20:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3yyQragcKCho9H78BA46EE6B4.2ECG4CK-34L4BDED6DK.EH6@flex--jrhilke.bounces.google.com>)
 id 1wXmhm-0000zP-NP
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 17:12:52 -0400
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3yyQragcKCho9H78BA46EE6B4.2ECG4CK-34L4BDED6DK.EH6@flex--jrhilke.bounces.google.com>)
 id 1wXmhk-0003ni-1F
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 17:12:50 -0400
Received: by mail-pl1-x64a.google.com with SMTP id
 d9443c01a7336-2bf1dece2ecso2668065ad.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 14:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781212363; x=1781817163; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=qwrI4yZGfFqiYcIJOH0iEIRHDylxXXDO0YZSjYsed6w=;
 b=Tv29Iv9TIAdj30bO1SCIDd6yFOIg5zEp4ALQje/FucMDkDHQd7jEXBmGPMx1/e4e+C
 wfU+JzjNc3gl0bZY/CbJ2wwOPDqub10lo1Iga9OIVRRCWLE/oUTzE8eKWsERc7lUZu3+
 49p/9s+BU6prRuYJPxWLFxTB9D2m4IbCnab2xINj39iAtTo/QsE89Y/8olwCjpc3qp3n
 kXQuwcjeAhdLLE0maEfVzuLShJ6i6W0GtkZy6rKgU3HeOXBFnAHVCAZMuPIvK+nxE3ws
 Fl90FArQLJjb5P26xRPtK23g9FUjvgxRDO85o+NwPqV8rTo5jTGTdKX6HC79pJoZBd88
 NIzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781212363; x=1781817163;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qwrI4yZGfFqiYcIJOH0iEIRHDylxXXDO0YZSjYsed6w=;
 b=e8c1rbxaEq4yyIa9sC1rqJ2TpB0nqj4EWEORQ+uGUIksw3KKtFpN9AAod8CxeqQYi/
 6+3dz/lWM9dV1l4jNvjhNgVWJw1bEgLoZAReAWF5V6CIVfDHBlNi1udSOBlozgavpuqT
 QEiFEdBaeU05IiSf9A8faPm6Y244cERv46YrerZBsJ6r1p5P8LEtqD/qTCXT+axmP5Gt
 Sl6rH/bNlPCvhn+sgW45S22acstf0BFBGBsiFpowgarfq7OzNqX7kRDsSZZw9DZ4ONA0
 9wBJeZDgjTlpMzfIhTWnkwc2raFuq7BIeENQbmHdb4PyXYSBA/2suHQBufmoVHf13y59
 4VPg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9eRgVRhe+6satsY6lFhWno6gXx5HwDVInhw+YeI+1w/BVbJHicdKGggMkIEIGLdZH9NLmuMC/8dY/B@nongnu.org
X-Gm-Message-State: AOJu0YxT0CActgHRfbtHoU76nZ1+/G6oz2DQA6S919lhVEURhKWv1PBZ
 a3D4Og9H9YEdVor75RL/YCHbHjkiw4e0pp8cPSLCHJqpVLF40jZzLmVPyWv9MN+NQaTbHVA9vVD
 MVQR68sQv
X-Received: from plzv4.prod.google.com ([2002:a17:902:b7c4:b0:2bd:40d4:e407])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:943:b0:2c1:f29a:b554
 with SMTP id d9443c01a7336-2c41255da68mr1004775ad.21.1781212363098; Thu, 11
 Jun 2026 14:12:43 -0700 (PDT)
Date: Thu, 11 Jun 2026 21:11:28 +0000
In-Reply-To: <20260611-igb-trl-v2-0-bd58de9eb0fa@google.com>
Mime-Version: 1.0
References: <20260611-igb-trl-v2-0-bd58de9eb0fa@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260611-igb-trl-v2-3-bd58de9eb0fa@google.com>
Subject: [PATCH v2 3/7] igb: Implement TRL register write and configuration
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
 envelope-from=3yyQragcKCho9H78BA46EE6B4.2ECG4CK-34L4BDED6DK.EH6@flex--jrhilke.bounces.google.com;
 helo=mail-pl1-x64a.google.com
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

Implement write handlers for TLDQSEL and TRLRC registers to allow the
guest to configure Transmit Rate Limiting. Translate the register Rate
Factor into a physical target rate (bytes/sec) per queue.  Disable TRL
and clear timers when the link status changes or when TRL is disabled by
the guest.

Signed-off-by: Josh Hilke <jrhilke@google.com>
---
 hw/net/igb_core.c | 79 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 78 insertions(+), 1 deletion(-)

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 05d8241..90d94d4 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -2136,11 +2136,29 @@ igb_set_phy_ctrl(IGBCore *core, uint16_t val)
     }
 }
 
+static void igb_trl_disable_queue(IGBCore *core, int qidx)
+{
+    core->trl[qidx].target_rate = 0;
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
+    core->mac[TRLRC] &= ~E1000_TRLRC_RS_ENA;
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
@@ -2623,6 +2641,62 @@ static void igb_set_vtivar(IGBCore *core, int index, uint32_t val)
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
+    core->mac[index] = val;
+
+    qidx = core->mac[TRLDQSEL];
+    core->trl[qidx].trlrc = val;
+
+    if (!(val & E1000_TRLRC_RS_ENA)) {
+        goto disable;
+    }
+
+    /*
+     * The TRLRC register stores the Rate Factor in 10.14 fixed-point format:
+     * - Bits 13:0: Fractional part
+     * - Bits 23:14: Integer part
+     *
+     * Combined, the lower 24 bits of the register (23:0) represent the
+     * concatenated 24-bit scaled Rate Factor directly.
+     */
+    rf_scaled = val & 0xFFFFFF;
+
+    /* Zero is not a valid rate factor, treat as disabled */
+    if (rf_scaled == 0) {
+        goto disable;
+    }
+    /*
+     * The rate factor is a fixed-point number with a 14-bit fractional part:
+     * Rate Factor = rf_scaled / 2^14
+     *
+     * The target rate is:
+     * Target Rate = Link Rate / Rate Factor
+     *             = Link Rate / (rf_scaled / 2^14)
+     *             = (Link Rate * 2^14) / rf_scaled
+     */
+    core->trl[qidx].target_rate = (E1000_LINK_RATE_1GBPS << 14) / rf_scaled;
+    return;
+
+disable:
+    igb_trl_disable_queue(core, qidx);
+}
+
 static inline void
 igb_autoneg_timer(void *opaque)
 {
@@ -3678,6 +3752,7 @@ static const readops igb_macreg_readops[] = {
     [RQDPC15] = igb_mac_read_clr4,
     [VTIVAR ... VTIVAR + 7] = igb_mac_readreg,
     [VTIVAR_MISC ... VTIVAR_MISC + 7] = igb_mac_readreg,
+    [TRLRC] = igb_get_trlrc,
 };
 enum { IGB_NREADOPS = ARRAY_SIZE(igb_macreg_readops) };
 
@@ -4126,7 +4201,9 @@ static const writeops igb_macreg_writeops[] = {
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


