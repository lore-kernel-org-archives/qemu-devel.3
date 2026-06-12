Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03924CD98CE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 21:51:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY9m5-00023I-99; Fri, 12 Jun 2026 17:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3M38sagcKCjwhpfgjicemmejc.amkocks-bctcjlmlels.mpe@flex--jrhilke.bounces.google.com>)
 id 1wY9m3-00022P-8l
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 17:50:47 -0400
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3M38sagcKCjwhpfgjicemmejc.amkocks-bctcjlmlels.mpe@flex--jrhilke.bounces.google.com>)
 id 1wY9m1-0005Is-Jv
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 17:50:46 -0400
Received: by mail-pf1-x44a.google.com with SMTP id
 d2e1a72fcca58-8422f987f2eso2277705b3a.3
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2026 14:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781301043; x=1781905843; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=ntjSjI2BqxYqiuKjzx3ge/WeyMR3aXx4MfGrxwtztTo=;
 b=uHYHIOnbKSq0ikn0NUhAY9bWzhd3+QLvOMhZiIGbTF7wAww2ELj9oxfLnyY/Wd7aQH
 j6dChioqCtSKetjBz5fVeGzXT+ydTJDou/ApOJ89vV009QlyAZuYqmpuBIOWefhfbH4p
 09Uaz5mdBBp3W3RKjthkmGCGC7ObfwuBHP/PSBRQE/aSLO0AIVCH5+mcaG+qANDSwvMK
 TU4ynEA6QU76i1UeGBWKcjqFyhRgs91H/DI0qwLzdzywLjOnwkrQ/QZ1ddn/GlJKJF7z
 b+a/1238eDp6xD0WUTOgHSFjWjA1dZtdll0lv7KG0toJBDfdmE/Bra34+uA0D7/S52Kk
 qFwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781301043; x=1781905843;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ntjSjI2BqxYqiuKjzx3ge/WeyMR3aXx4MfGrxwtztTo=;
 b=cU8z07bNe9ih6Uq34tJz6B5Kmqnfqj9qu/lFZtqYUh5MYiZkzJCAhrUJHEZaZ8CPlH
 bzVa6tNQxTsAiislI7g/uttafnkihvoNKkmkwFYHlGR8YqFCJCxVF4E4Plqw3V5wQT+m
 f+a0LtQpWkYWjerBxE3RoZR+2ZsxcEtEWFmNa0I4hXTvQauudTS1yUlFJRZpOuIY8o4n
 i60BJaZ/mHBRS3G5sOVuraUNTK+/vzvhXlQ1L1h5l9V40ee5Vday5taJObi5jyVWlmeI
 kYUP7pkhPiExBT2Xf4kgQqFXokkPtfjZGkENmoPivySe8z4mJlHZ6euj5JWTMjn9UQwQ
 qy7Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+s2lMOSwu6cVBQ5G30Wwxf7qymN34ZZf8bDFgxr6PYd5IqV1u/E9M+gWHnBvSvTlOV6SY0piiAX4TC@nongnu.org
X-Gm-Message-State: AOJu0Yw/3XJLFUy3Nqx5sbh7YJGQDdliPkVFh1ecfwA2YBP+tAPsxW9C
 e4drHR6waoNdtinYDSy+pB995nN9g0vFwx4Cat1eGl5Q7oSr5CbZM+dSRisOtNWMYPaLJ+y4Y0z
 1ikCm5seJ
X-Received: from pfsy56.prod.google.com ([2002:a05:6a00:3b8:b0:843:49ef:6b1])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1943:b0:842:3c89:15de
 with SMTP id d2e1a72fcca58-8434ce48bffmr5007365b3a.25.1781301043245; Fri, 12
 Jun 2026 14:50:43 -0700 (PDT)
Date: Fri, 12 Jun 2026 21:50:14 +0000
In-Reply-To: <20260612-igb-trl-v3-0-19607f9a3dde@google.com>
Mime-Version: 1.0
References: <20260612-igb-trl-v3-0-19607f9a3dde@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260612-igb-trl-v3-3-19607f9a3dde@google.com>
Subject: [PATCH v3 3/7] igb: Implement TRL register write and configuration
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
 envelope-from=3M38sagcKCjwhpfgjicemmejc.amkocks-bctcjlmlels.mpe@flex--jrhilke.bounces.google.com;
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
 hw/net/igb_core.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 31f2644..3eddfbe 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -2136,11 +2136,27 @@ igb_set_phy_ctrl(IGBCore *core, uint16_t val)
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
@@ -2623,6 +2639,50 @@ static void igb_set_vtivar(IGBCore *core, int index, uint32_t val)
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
+    return;
+
+disable:
+    igb_trl_disable_queue(core, qidx);
+}
+
 static inline void
 igb_autoneg_timer(void *opaque)
 {
@@ -3678,6 +3738,7 @@ static const readops igb_macreg_readops[] = {
     [RQDPC15] = igb_mac_read_clr4,
     [VTIVAR ... VTIVAR + 7] = igb_mac_readreg,
     [VTIVAR_MISC ... VTIVAR_MISC + 7] = igb_mac_readreg,
+    [TRLRC] = igb_get_trlrc,
 };
 enum { IGB_NREADOPS = ARRAY_SIZE(igb_macreg_readops) };
 
@@ -4126,7 +4187,9 @@ static const writeops igb_macreg_writeops[] = {
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


