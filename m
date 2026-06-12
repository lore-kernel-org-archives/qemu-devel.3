Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8728FCD98D8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 21:51:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY9m4-000235-Uw; Fri, 12 Jun 2026 17:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3Mn8sagcKCjsgoefihbdlldib.Zljnbjr-absbiklkdkr.lod@flex--jrhilke.bounces.google.com>)
 id 1wY9m2-00021g-Hp
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 17:50:46 -0400
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3Mn8sagcKCjsgoefihbdlldib.Zljnbjr-absbiklkdkr.lod@flex--jrhilke.bounces.google.com>)
 id 1wY9m0-0005Id-VK
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 17:50:46 -0400
Received: by mail-pj1-x1049.google.com with SMTP id
 98e67ed59e1d1-36d97955899so1342620a91.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2026 14:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781301043; x=1781905843; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=378TvCYrv/dbLGwDHiAZNEpCCcD7o6IZyz+rEM3wMWw=;
 b=OZm84uhNtXBf4VBwuy60giaRR1383/ZC4MTnQn/mbPvMaKJBUN53TsfYa/HgUBo037
 itx6Hgrc/krbyE19jS5tAX09BpHc0Xvy1Nio7zlhX4eZioQbzki8d2ybU4xL8R057rn0
 5p1VMSGvFu0ZhZ49/eepg3w2recP23ZjgW6u5bulM+djild8PCSuXPVU69h2Ae4kIWeD
 4jr7ECWLjbHZXs9Niu/2Y/E11zOY5SfViPeuioJNpkb4o89MxBamThVW+AiMHOq8nJYE
 yY/cTF3uj+Pa+2ENXxmoyAEix4g9JbOQV+1oqCTRW0gIFyhc/BtzqC/hsF6Pri3G3tUO
 CFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781301043; x=1781905843;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=378TvCYrv/dbLGwDHiAZNEpCCcD7o6IZyz+rEM3wMWw=;
 b=osq6OYKVj3yzfF6LI8pNqs4lECZ3qWxo17KUc74NwPbGLn+QZVyypu24V4sLjjgSs8
 bkXlMPryOEErPRG+pPOb/XIR4WbosFZSpoVjXouFrD1FqI/nqny1LXDC3G2MmH4ihjZ1
 xD2qHGc38QrejAtD6iv+6mV2jzDy77TepFWA2oYHs4ZZSF9uhv9y7weCeemXlgC94t8F
 p6eOcMbiOEverywqusoeGhH2ULbjv8HsTsri7ikedp+e91kHNjV+N0IYEcsgB80fGDU5
 8u5YbIYfUnY56GYn//fWVYnbCrxCmLglIlPMYSyw15VR+TK3p1jQfsJI5VLYxC0babcs
 dX2A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/4bwmepJ9TwMUyrDpS4Warg3Yfmfe1wQQgnjrGDFsYfRqqBzpjRnK/iuufQBzIFLlJE77TQRZvk1iO@nongnu.org
X-Gm-Message-State: AOJu0Yw2SG+kamJHIE+mcZwMyCaq8XCIk2ce+bGVIwGUw35HBVU+pmCT
 0k/HBVfMhiq2jGkHZhOp1EVZRh8UEw1jjCAcvocqv/sMtRzfDLrlicwq8V9AZoUqWbh4Gvl5/qx
 j+Ulcd3cW
X-Received: from pgu23.prod.google.com ([2002:a63:1457:0:b0:c80:1fe6:ac57])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6300:2285:b0:3b4:813d:dc1
 with SMTP id adf61e73a8af0-3b783fc43c8mr4999653637.31.1781301042416; Fri, 12
 Jun 2026 14:50:42 -0700 (PDT)
Date: Fri, 12 Jun 2026 21:50:13 +0000
In-Reply-To: <20260612-igb-trl-v3-0-19607f9a3dde@google.com>
Mime-Version: 1.0
References: <20260612-igb-trl-v3-0-19607f9a3dde@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260612-igb-trl-v3-2-19607f9a3dde@google.com>
Subject: [PATCH v3 2/7] igb: Add VMState support for TRL state
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
 envelope-from=3Mn8sagcKCjsgoefihbdlldib.Zljnbjr-absbiklkdkr.lod@flex--jrhilke.bounces.google.com;
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

Add VMState representation for the Transmit Rate Limiter (TRL) state to
support migration. This includes the TRL timers and target rates per
queue.

Signed-off-by: Josh Hilke <jrhilke@google.com>
---
 hw/net/igb.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/hw/net/igb.c b/hw/net/igb.c
index c076807..09c0150 100644
--- a/hw/net/igb.c
+++ b/hw/net/igb.c
@@ -563,6 +563,45 @@ static const VMStateDescription igb_vmstate_intr_timer = {
     VMSTATE_STRUCT_ARRAY(_f, _s, _num, 0,                           \
                          igb_vmstate_intr_timer, IGBIntrDelayTimer)
 
+static bool igb_trl_needed(void *opaque)
+{
+    IGBState *s = opaque;
+
+    for (int i = 0; i < IGB_NUM_QUEUES; i++) {
+        if (igb_trl_get_target_rate(&s->core.trl[i]) > 0) {
+            return true;
+        }
+    }
+
+    return false;
+}
+
+static const VMStateDescription igb_vmstate_trl_queue = {
+    .name = "igb-trl-queue",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_TIMER_PTR(timer, IGBTrlQueue),
+        VMSTATE_UINT32(trlrc, IGBTrlQueue),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+#define VMSTATE_IGB_TRL_QUEUE_ARRAY(_f, _s, _num)                    \
+    VMSTATE_STRUCT_ARRAY(_f, _s, _num, 0,                            \
+                         igb_vmstate_trl_queue, IGBTrlQueue)
+
+static const VMStateDescription igb_vmstate_trl_state = {
+    .name = "igb/trl_state",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = igb_trl_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_IGB_TRL_QUEUE_ARRAY(core.trl, IGBState, IGB_NUM_QUEUES),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription igb_vmstate = {
     .name = "igb",
     .version_id = 1,
@@ -591,6 +630,10 @@ static const VMStateDescription igb_vmstate = {
         VMSTATE_INT64(core.timadj, IGBState),
 
         VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription * const []) {
+        &igb_vmstate_trl_state,
+        NULL
     }
 };
 

-- 
2.54.0.1136.gdb2ca164c4-goog


