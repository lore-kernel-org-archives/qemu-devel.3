Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6372CD98DE
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 22:20:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZFeS-00050r-Io; Mon, 15 Jun 2026 18:19:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3WnowagcKCmkQYOPSRLNVVNSL.JVTXLTb-KLcLSUVUNUb.VYN@flex--jrhilke.bounces.google.com>)
 id 1wZFeI-0004vH-Ty
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 18:19:20 -0400
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3WnowagcKCmkQYOPSRLNVVNSL.JVTXLTb-KLcLSUVUNUb.VYN@flex--jrhilke.bounces.google.com>)
 id 1wZFeE-0008MR-CZ
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 18:19:17 -0400
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-36bd4146cb2so4191898a91.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 15:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781561947; x=1782166747; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=pkJTE/KxfHicCR5p5+MPe5Kjlan0NoBf7pJvty3cI6Y=;
 b=dOGj61Mu6adKPVUQgv6XdH1+WHwd5CE+IiEzj3gxiUYC+y3L9rg3cxvQmj5T0dE5op
 rLGd1WsoEUqHz7f4HZQcI6qR+XkAdhyI+sodFDksMd5lmNTo+sTEai5PR6VCiUvYUFzX
 rAu6J89lp1n2vdg4xEW2A7OWPsRd+21ur/gfjvKt+/W8vhK96mHhKxDt5d6CsngKUhca
 9ZE1QeIVBkHBavkA5r7IwrOpQD1W9T5z/jk3xNcTClntW3Muzo10EqXWp8S06qnJDlcM
 p5317KZBnsQZrnvjuKBSVTOlsu9Hq+EzL5uyD+8K0m5JGmBVERmOvNySYIZm3cTkcxjx
 5x9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781561947; x=1782166747;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pkJTE/KxfHicCR5p5+MPe5Kjlan0NoBf7pJvty3cI6Y=;
 b=fbd2e35eKBYZh6daHvZtyVFYZzeelA+P0iKwqGwUOPA1WUTIuqM9kGg3wBLKMAzT7U
 EC43tfJDR4BxdO/EyKbifYYibvdlP6ovzrWai5H6jbquhBAvaZd4WwrblBHBSM7lFcc9
 4Lhvrri1BF5aKCeCgGVKjJ3qAKdmXFOYDxLmO95SHERqusm2XbVgmIi/s/ImdiYoOG+D
 g2JCJo1BJLJSPTPp3ovfv0e3BU0N0S7nRwEl6nDjRog8R9ldAtVwzckVfTJZQROVkSzY
 spT7/NsfVlcjY1N4RKC20DHe0lDHg4xjHar32o8wRwusbRZwGpa+G4VWVbilIzkyhD6+
 zZKA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8J6uTAnjEHsCeGTAGmDVWKkRWcFlfG0GHWpjutR2CCBgc9uB2uHg6DtyHuH7U23bmqM+/DuVkFHK//@nongnu.org
X-Gm-Message-State: AOJu0YwBR+/vynMtodUhxa9D2DXtkhzdeds8O4eV2Le8oWnZKpSzJF7/
 FNudtPSUzDvofyjRDJKci6Y6ZDTwMAe0M8VhFV+/QhDYbq2E6PLd71WdQkKwWH12GQjhIdbu5QA
 xOrxxIqWz
X-Received: from pjtk1.prod.google.com ([2002:a17:90a:c501:b0:369:4f69:1042])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2d08:b0:369:9469:aeba
 with SMTP id 98e67ed59e1d1-37c5234211bmr846714a91.1.1781561946801; Mon, 15
 Jun 2026 15:19:06 -0700 (PDT)
Date: Mon, 15 Jun 2026 22:18:04 +0000
In-Reply-To: <20260615-igb-trl-v4-0-cf5739bf529f@google.com>
Mime-Version: 1.0
References: <20260615-igb-trl-v4-0-cf5739bf529f@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260615-igb-trl-v4-2-cf5739bf529f@google.com>
Subject: [PATCH v4 2/7] igb: Add VMState support for TRL state
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
 envelope-from=3WnowagcKCmkQYOPSRLNVVNSL.JVTXLTb-KLcLSUVUNUb.VYN@flex--jrhilke.bounces.google.com;
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

Add VMState representation for the Transmit Rate Limiter (TRL) state to
support migration. This includes the TRL timers and target rates per
queue.

Signed-off-by: Josh Hilke <jrhilke@google.com>
---
 hw/net/igb.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/hw/net/igb.c b/hw/net/igb.c
index c076807..04c48f1 100644
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
+        if (igb_trl_enabled(s->core.trl[i].trlrc)) {
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


