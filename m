Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CFCBCDB47F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 15:07:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc2iI-0006nN-RK; Tue, 23 Jun 2026 11:07:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3_KA6agcKCoEowmnqpjlttlqj.htrvjrz-ij0jqstslsz.twl@flex--jrhilke.bounces.google.com>)
 id 1wc2hz-0006j6-VE
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 11:06:40 -0400
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3_KA6agcKCoEowmnqpjlttlqj.htrvjrz-ij0jqstslsz.twl@flex--jrhilke.bounces.google.com>)
 id 1wc2hy-0006oc-GS
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 11:06:39 -0400
Received: by mail-pf1-x44a.google.com with SMTP id
 d2e1a72fcca58-84238e83851so18862b3a.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 08:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1782227197; x=1782831997; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=29vAj9EnEPfhnl5PfImVwUUiMUlcltE8sGk+mLO5PFw=;
 b=keoHfw93ll0h5fRoxi0wMDqkZOlQliG42XKbTO+Wnr7Ktfk0Zo+QW3udLjaJlmB9jp
 JvTvKVXYTp9MuORT58taN9pL12LP+XWL5ujbzqpKUCFMbeZC+nUE/ST27khRpbUULxyC
 P20jT3i4OZRfDkAp6hKq5VkJ2z0wKhdk80SUbJr9zyz/3T9SEnxkQlYaTBJTqq070V8n
 lFpbHLZX2a86VjqCJtn/9Fh6wY+DjuN9METHOvymf2tfaxiNbqk39cvRs5pjyO9Vkisl
 6mvi+VnEKfx8NsloDdvpHNCX3dIjP7P3E8gSPNpE7a5Mbc642GBL4DlMiL/j8xQOZVIg
 275g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782227197; x=1782831997;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=29vAj9EnEPfhnl5PfImVwUUiMUlcltE8sGk+mLO5PFw=;
 b=APCW61fJeBQpKONXzZWHhXo+QEjs9k537PVt3eom4QkniHinvHcQQgiSuI/QyWOWUm
 5vORwQ1H2CAgxaQRTbJKAE5qGtzjs46BXXihPeNuhEgtASKOnV8qr3FASC9p2OUVlhpd
 RuYmHKfk1bfuFP3t/+kbZfoKDkaYl+lrjFCGhCPJb5ImEFBTV3T4nH/z6GFt7ErgbfML
 ZBdk1VQgR2IYthUbwkfZkKMz8F7l+8kDfn7/HjMHx2nCX8SfJFLe5HLW8YYpErHZXnmL
 BqZNisg0KBnL0jbvY8s4N93wbGHhQFDlVDHX8nGbAutuf0w/i07nqIAKuCdHxuuIOq+m
 wVog==
X-Forwarded-Encrypted: i=1;
 AFNElJ/LZXwtYiGz64mvVMnnkFf1FPFkbAxA/SZtffjONt5u9cOz21PoWo9NPPsBcxLHcrJ3O4alBAghEIc9@nongnu.org
X-Gm-Message-State: AOJu0YyIPOsw4CROB9HkkzPSQKUTzBveIVp7ySOguAeh7Hz3YePRS9yi
 lrjj2VTi8mdWZWZjqowky5LJvdYOqWEN/4I+KvSHAHC3tEc4bREUeuXWJEHOZISE6SaAFiL6Dnr
 p5p7HDy1/
X-Received: from pfms25.prod.google.com ([2002:aa7:8299:0:b0:82c:90c5:5e0d])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2d88:b0:837:f79d:909
 with SMTP id d2e1a72fcca58-8459714309fmr3497263b3a.39.1782227196286; Tue, 23
 Jun 2026 08:06:36 -0700 (PDT)
Date: Tue, 23 Jun 2026 15:06:01 +0000
In-Reply-To: <20260623-igb-trl-v8-0-c9b1fc6c3304@google.com>
Mime-Version: 1.0
References: <20260623-igb-trl-v8-0-c9b1fc6c3304@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260623-igb-trl-v8-3-c9b1fc6c3304@google.com>
Subject: [PATCH v8 3/7] igb: Implement TRL register write and configuration
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
 envelope-from=3_KA6agcKCoEowmnqpjlttlqj.htrvjrz-ij0jqstslsz.twl@flex--jrhilke.bounces.google.com;
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

Implement write handlers for TLDQSEL and TRLRC registers to allow the
guest to configure Transmit Rate Limiting. Translate the register Rate
Factor into a physical target rate (bytes/sec) per queue.  Disable TRL
and clear timers when the link status changes or when TRL is disabled by
the guest.

Signed-off-by: Josh Hilke <jrhilke@google.com>
---
 hw/net/igb_core.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 44e8e58..ca427d7 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -2150,6 +2150,11 @@ void igb_core_set_link_status(IGBCore *core)
     NetClientState *nc = qemu_get_queue(core->owner_nic);
     uint32_t old_status = core->mac[STATUS];
 
+    /* Disable TRL for all queues (section 4.5.12.1) */
+    for (int i = 0; i < IGB_NUM_QUEUES; i++) {
+        core->trl[i].trlrc &= ~E1000_TRLRC_RS_ENA;
+    }
+
     trace_e1000e_link_status_changed(nc->link_down ? false : true);
 
     if (nc->link_down) {
@@ -2632,6 +2637,25 @@ static void igb_set_vtivar(IGBCore *core, int index, uint32_t val)
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
+}
+
 static inline void
 igb_autoneg_timer(void *opaque)
 {
@@ -3687,6 +3711,7 @@ static const readops igb_macreg_readops[] = {
     [RQDPC15] = igb_mac_read_clr4,
     [VTIVAR ... VTIVAR + 7] = igb_mac_readreg,
     [VTIVAR_MISC ... VTIVAR_MISC + 7] = igb_mac_readreg,
+    [TRLRC] = igb_get_trlrc,
 };
 enum { IGB_NREADOPS = ARRAY_SIZE(igb_macreg_readops) };
 
@@ -4135,7 +4160,9 @@ static const writeops igb_macreg_writeops[] = {
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
2.55.0.rc0.786.g65d90a0328-goog


