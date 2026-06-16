Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 284ECCD98D2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 22:37:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZcOD-0007OG-HR; Tue, 16 Jun 2026 18:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <31M8xagcKCpM6E458713BB381.zB9D19H-01I18ABA3AH.BE3@flex--jrhilke.bounces.google.com>)
 id 1wZcOA-0007ND-CD
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 18:36:10 -0400
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <31M8xagcKCpM6E458713BB381.zB9D19H-01I18ABA3AH.BE3@flex--jrhilke.bounces.google.com>)
 id 1wZcO7-0001ce-Ap
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 18:36:08 -0400
Received: by mail-pj1-x1049.google.com with SMTP id
 98e67ed59e1d1-37c89e480easo465135a91.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 15:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781649365; x=1782254165; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=xxGWVuKk5mGVqI71iHwXumugKQPkymM1Pn0ftLDkvAk=;
 b=wmbzyh8qBFM57VLDzmihRBFGFXCbZVesAF8SPQRPgtwTTnbcNMbn+y6ozpk9yzqZ6q
 AWfixD3L39P6KjDd6KokvpMLRHVSs4nCZ4ay4vTBB4KZylU4ncjncRIzBF9oiAnde5hC
 9N7vFHIOvQZEztx+kXT37y1L5RrwU5vjxgGWdb7tJ9/D9FPd82MHLNxWdIq0EgKpD2C2
 CmxsEWN1cRGTPUQvX1oauGkHY/180alGTz3CwnTggeznJ1R6pJQ6kv0zZ71W+CXd4LBJ
 79GpuJ5plgP0+qyirAlvMzNx/0rIxJFoYbaDNn9JLnxXz05i2carFnVSRiaXYXtrQAYe
 E1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781649365; x=1782254165;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xxGWVuKk5mGVqI71iHwXumugKQPkymM1Pn0ftLDkvAk=;
 b=UDI279iKdsOP7AY2nEBMcqM0+IOyTBZizjSeSg0l4LfIhPkQAPoqEv2KrudJZM9Gyw
 dFry82EVngPN/VgnvsrZmeqoZK8waxFZ3bgQzK1wldOk3La+HwcUCmwAbNli/880tIRV
 EX4uVRlr8s5HF8LacjkYspUIHX5H1VlNjzhsKwzJNZwy5vKIM8wQEtzhs7DYvQ5BRbLc
 jGghKx15mBJPLoMZgoGutcVsowwlQFaBZfRDRQrju99JEr+LzAdaGgrhDJcf6YcReV59
 b/lUzgvrifcIEZWGUWoiK2/75LMgjiQq3S1X+P+bNF1w62bUYwje7EiPHnJaQ4NmeDRr
 mykw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8mjrQDxs74oTLHS/cmwwgkZpDMe5029eqHtSS1dDASFTAvWGR4s1v268W2/j2syEQHBmCWSjDGy0Os@nongnu.org
X-Gm-Message-State: AOJu0Yzw7xS2JqM0aUVVrzxPtdwAk7pznW4AXb3g+Wy97O6ILbQV7GmV
 lOFiB2Brx5u3Svj8SxIapk8mAty/ddgm9sJ0ZM9IbdNTcA1ghVSyNC33rn75mR3aNUDvhF5g5eo
 1BBUA7Yl8
X-Received: from pgbl26.prod.google.com ([2002:a63:571a:0:b0:c85:a528:228f])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:47:b0:36d:bc0d:f789
 with SMTP id 98e67ed59e1d1-37c937144f8mr1360518a91.22.1781649364866; Tue, 16
 Jun 2026 15:36:04 -0700 (PDT)
Date: Tue, 16 Jun 2026 22:35:30 +0000
In-Reply-To: <20260616-igb-trl-v5-0-1183e3635e06@google.com>
Mime-Version: 1.0
References: <20260616-igb-trl-v5-0-1183e3635e06@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260616-igb-trl-v5-3-1183e3635e06@google.com>
Subject: [PATCH v5 3/7] igb: Implement TRL register write and configuration
From: Josh Hilke <jrhilke@google.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Josh Hilke <jrhilke@google.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1049;
 envelope-from=31M8xagcKCpM6E458713BB381.zB9D19H-01I18ABA3AH.BE3@flex--jrhilke.bounces.google.com;
 helo=mail-pj1-x1049.google.com
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
 hw/net/igb_core.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 44e8e58..fb31e37 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -2145,11 +2145,21 @@ static void igb_trl_reset(IGBCore *core)
     }
 }
 
+static void igb_trl_disable(IGBTrlQueue *q)
+{
+    q->trlrc &= ~E1000_TRLRC_RS_ENA;
+    timer_del(q->timer);
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
@@ -2632,6 +2642,29 @@ static void igb_set_vtivar(IGBCore *core, int index, uint32_t val)
      */
 }
 
+static uint32_t igb_get_trlrc(IGBCore *core, int index)
+{
+    const unsigned int qidx = core->mac[TRLDQSEL];
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
+    const unsigned int qidx = core->mac[TRLDQSEL];
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
@@ -3687,6 +3720,7 @@ static const readops igb_macreg_readops[] = {
     [RQDPC15] = igb_mac_read_clr4,
     [VTIVAR ... VTIVAR + 7] = igb_mac_readreg,
     [VTIVAR_MISC ... VTIVAR_MISC + 7] = igb_mac_readreg,
+    [TRLRC] = igb_get_trlrc,
 };
 enum { IGB_NREADOPS = ARRAY_SIZE(igb_macreg_readops) };
 
@@ -4135,7 +4169,9 @@ static const writeops igb_macreg_writeops[] = {
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
2.54.0.1136.gdb2ca164c4-goog


