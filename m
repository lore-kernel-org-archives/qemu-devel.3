Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73683CD8C9D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 04:28:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXX1l-0001Yn-7t; Thu, 11 Jun 2026 00:28:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <32h0qagcKChc6E458713BB381.zB9D19H-01I18ABA3AH.BE3@flex--jrhilke.bounces.google.com>)
 id 1wXVC2-0002pN-7x
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 22:30:54 -0400
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <32h0qagcKChc6E458713BB381.zB9D19H-01I18ABA3AH.BE3@flex--jrhilke.bounces.google.com>)
 id 1wXVC0-0005JR-NG
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 22:30:53 -0400
Received: by mail-pf1-x449.google.com with SMTP id
 d2e1a72fcca58-842211d6e48so8389687b3a.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 19:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781145051; x=1781749851; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=oQQf8N0xWDI7K2CKUjtEwRPQUQC6/7gubuy68bn+B1Q=;
 b=se7T2RGyLsiUh9K3QmdVWpLf2XjFoz7flx635JUxvChNTU+UHEv6696/c57VtJv2c5
 sTbdeziFkxVVLDj5tM8IRxpCPnmvfZIBU3DWAf7rGhHIf7aJlDiqGTLYJtJ7P0vG1Enw
 lr87Wbn4oyNouTE1awqrQuXMh25RXnpOfpGQwLc1efZMs7x4XQZNVL270ymPvMNsbdfk
 vUZ7jxBLOu/iZyS8+ZSkimUgQG/6Q4rmrHuHG/bGUkeH80vrdWiHL3oJobHmKnhdVZtv
 6MNVASlk6dsAYZChX+9vqiFXcE35sK1oeA8ZHN55f+hxIPS7dbv59X1JfqrynvkPxxsE
 /0zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781145051; x=1781749851;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oQQf8N0xWDI7K2CKUjtEwRPQUQC6/7gubuy68bn+B1Q=;
 b=Qx9UR0mTum/edPnLk1aWHI+YsnXE2Jat7qEcajL0Vc/O/eQj/x6nZlsvLsiHfHWgUe
 gCjQMDiSn62Uek8+pAJNZU4iYbrh9AVUcTunmmxIskTTLebeeEZmXUpwTs6VG5wZ9kCU
 HIosIIuKF1TN7qvwOwDIi2SaFH+S129p4c7d9TtVRBrxa4NmwAeWFqBL9jjfx8vNqc7v
 9sZ+7UDX9dHUNm2bJKpapDXWg2WPzS3kjlJWcycvTQ3nxeepFyThhThJiQG0YMrLELFq
 F1ESVGPvaaJaj5K/0c0f+utH0VG3TssE81MJHt0tpmS4N3jDg1jm/BIuTR4RSXJeGWc4
 J+lw==
X-Gm-Message-State: AOJu0YzkjXZNv3Itc5WkmpdYbeYdoyCCejsGjkmq+W2oARTxtVFGK1nY
 VMiUEAyjG3OFrIXpIKjwA+VOuxyJ5daZ08ixbkGoLQomA41eZ9la8jCqZaRvoiIuJ5lhqiwmSiF
 NszfgqibtfhQ6OsnkUWcivbRktDtBys5cMhpwA8fbLaesybnWEOWHuJgcpjxjwxAEnMDIb/JYCO
 uaNvZd04CRa8xL295jc7RTyu2Ah1KeDAczRtpVVLM=
X-Received: from pfiu15.prod.google.com ([2002:a05:6a00:124f:b0:842:3a6c:99f5])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:8d82:b0:83e:f75d:828d
 with SMTP id d2e1a72fcca58-84336909a34mr847354b3a.16.1781145050627; Wed, 10
 Jun 2026 19:30:50 -0700 (PDT)
Date: Thu, 11 Jun 2026 02:30:25 +0000
In-Reply-To: <20260611023028.102071-1-jrhilke@google.com>
Mime-Version: 1.0
References: <20260611023028.102071-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260611023028.102071-3-jrhilke@google.com>
Subject: [PATCH 2/5] igb: Implement TRL register write and configuration
From: Josh Hilke <jrhilke@google.com>
To: qemu-devel@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Josh Hilke <jrhilke@google.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::449;
 envelope-from=32h0qagcKChc6E458713BB381.zB9D19H-01I18ABA3AH.BE3@flex--jrhilke.bounces.google.com;
 helo=mail-pf1-x449.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 11 Jun 2026 00:28:23 -0400
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
 hw/net/igb_core.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 1 deletion(-)

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 64f21c1..3bb4649 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -2136,11 +2136,31 @@ igb_set_phy_ctrl(IGBCore *core, uint16_t val)
     }
 }
 
+static void igb_trl_disable_queue(IGBCore *core, int qidx)
+{
+    core->trl_target_rate[qidx] = 0;
+
+    if (core->trl_throttled[qidx]) {
+        timer_del(core->trl_timer[qidx].timer);
+        core->trl_throttled[qidx] = false;
+    }
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
@@ -2623,6 +2643,54 @@ static void igb_set_vtivar(IGBCore *core, int index, uint32_t val)
      */
 }
 
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
+    core->trl_target_rate[qidx] = (E1000_LINK_RATE_1GBPS << 14) / rf_scaled;
+    return;
+
+disable:
+    igb_trl_disable_queue(core, qidx);
+}
+
 static inline void
 igb_autoneg_timer(void *opaque)
 {
@@ -4126,7 +4194,9 @@ static const writeops igb_macreg_writeops[] = {
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


