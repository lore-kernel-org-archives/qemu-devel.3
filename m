Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDCE3CD98F0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 20:16:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZwgG-0002b4-2W; Wed, 17 Jun 2026 16:16:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3hgAzagcKCqsUcSTWVPRZZRWP.NZXbPXf-OPgPWYZYRYf.ZcR@flex--jrhilke.bounces.google.com>)
 id 1wZwgE-0002aD-Pg
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 16:16:10 -0400
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3hgAzagcKCqsUcSTWVPRZZRWP.NZXbPXf-OPgPWYZYRYf.ZcR@flex--jrhilke.bounces.google.com>)
 id 1wZwgD-0002pv-7i
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 16:16:10 -0400
Received: by mail-pj1-x1049.google.com with SMTP id
 98e67ed59e1d1-36bbcd40642so67743a91.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 13:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781727367; x=1782332167; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=4N/NLcDxSLmLgmQhTUh2TcfoGa5fEXQ6KzP8wrpDFAc=;
 b=KYsG9srAiLaoY+Ehphx/usIacPWP/zkKZS6A+TISemt4bcBPj8WDAmN+lGqC0uhxui
 UDgsCD3M9X1Sitib/NGGKsGEQQ10gF53MuqYR5i3rvIpvcFcI+HrfeTDq+MLiGnmHVpK
 Bl1RHYYeCBBDGTY5ePCvqYVnd5QK/3ULam9LOePSpJ+8fokYOU1EEp2OMI3FCL0icZP3
 zUoEQuJ19qS3zqptwQj183SrQp+0uEPDnxSGwK+Ty0Fklk4OF8fggwAqj9codN1ayAsb
 2LKC40xcc8R7FEA/YZd3Xk2unAl/7hLSB6dIL68tNz5IVZShUPRVXagFTdazxXvk/2X/
 Y4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781727367; x=1782332167;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4N/NLcDxSLmLgmQhTUh2TcfoGa5fEXQ6KzP8wrpDFAc=;
 b=d62TOte7cNaBhN7SCc3598mFIkohukgWQjE31DuKtKpVbOpvoEfMZngrJy/F+qnv//
 dzTr8wVC1uRUv2bsrB9GcstUl7SpqdWodlTrzg+5WrTdp6sZwhcel40U/Ht/c11+oo+F
 HimKVdMU28cqVBNjzAsyh0Ag2l00XKLDNK6wVlwiB9+a5nishs20U0jAMXozUzOLmf3l
 4WhBWT0l1cUcgfiKX/82rsaDd6tqCYiU4VjhgJAxnzPjmUi4WbCGySgS/VeHtVrxhf4c
 2DZazZ9ew2MT+dVe9yD0GOU1oO9Nrt+vx/eYkM5vex0zSMujGQOP3JV1L6QLGdoEPSDA
 OwiQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+3YceosXLLs13Us/bbgGOSRbVZekdqh8cnv8xkvu3H9fslqqsggQoYphpnwhmL9ygnpJEYffHxOpsf@nongnu.org
X-Gm-Message-State: AOJu0YxWF2s0iKaIzIgnjagxRh344WPzzcPXzuaV7SexGBINZ3mta2a8
 3iDIvFMxXaarPfFeeC5QYpD7prB6zJXO1vpSluF3Luns5Roi6EAKQ4JOtYvePyFzQWXM7nyfRuA
 TAvQq57or
X-Received: from pjbiq16.prod.google.com ([2002:a17:90a:fb50:b0:37c:e597:c4a5])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3d4f:b0:368:b4a5:c4dd
 with SMTP id 98e67ed59e1d1-37c92fb817fmr5212641a91.2.1781727366962; Wed, 17
 Jun 2026 13:16:06 -0700 (PDT)
Date: Wed, 17 Jun 2026 20:15:47 +0000
In-Reply-To: <20260617-igb-trl-v6-0-bbdfcadb81e2@google.com>
Mime-Version: 1.0
References: <20260617-igb-trl-v6-0-bbdfcadb81e2@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260617-igb-trl-v6-2-bbdfcadb81e2@google.com>
Subject: [PATCH v6 2/7] igb: Add VMState support for TRL state
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
 envelope-from=3hgAzagcKCqsUcSTWVPRZZRWP.NZXbPXf-OPgPWYZYRYf.ZcR@flex--jrhilke.bounces.google.com;
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
index c076807..773da26 100644
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
+        if (s->core.trl[i].trlrc) {
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
2.55.0.rc0.738.g0c8ab3ebcc-goog


