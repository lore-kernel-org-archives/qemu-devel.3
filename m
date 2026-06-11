Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADF87CD98CC
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 00:03:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXpLt-0002BQ-Qn; Thu, 11 Jun 2026 20:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3yCQragcKChc6E458713BB381.zB9D19H-01I18ABA3AH.BE3@flex--jrhilke.bounces.google.com>)
 id 1wXmhk-0000z9-8u
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 17:12:51 -0400
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3yCQragcKChc6E458713BB381.zB9D19H-01I18ABA3AH.BE3@flex--jrhilke.bounces.google.com>)
 id 1wXmhh-0003nH-6p
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 17:12:47 -0400
Received: by mail-pf1-x449.google.com with SMTP id
 d2e1a72fcca58-8422a0eee68so403782b3a.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 14:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781212361; x=1781817161; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=2xPO1Xzp02sOFKWBaAuURUpWcrRSzM55cLi6BAn4M9c=;
 b=H1fhxOF1kGcwLbtlhm8sKUoNKysfxUz0JapL4sLE0O1XeAv3cmVWhA2ooqvMWAEDFA
 5y96K3keVzt/vk0JaNOLnufFdkoramY/fC5xaN0p4xUzqOtEu/W+iyh1/tdxwXoLmjI2
 X3kVoMbfrs2iP+eJK9FRBB1FrxbzGBst7XxM/hNaXZDxmJ7n7s1hnaR8Jt9Xri38exL7
 ijIydbUN21ahTSyTAg9F7laeebna+3VzftM0KtmuF59VGu2IeZraYdK+cujWaGauQZRg
 m0YNcludvmHSEg7X6DAU/+9JxpvZ5oEE/ta6hOTmrfhDat0e7ObrUvXTdWP8+Mxsrzao
 Z2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781212361; x=1781817161;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2xPO1Xzp02sOFKWBaAuURUpWcrRSzM55cLi6BAn4M9c=;
 b=TccKs7Xp1w3t2G2dim51DiNnph5wNEYIaBxWPT1J8XmfUkWt0mVHkf0x0pwzZoTyIq
 iieCH61RMDNDSlzAtMZJ0474Pdzh1JftwrJ9pTU5O+0HrtOBJ0wyo/YJJEJAkHYgTxh9
 S5KcSovy2BWy1D7+QXHAxDY7qnEs1epnePoWHkRTIiP9n2wkuR1Z2oh9tsKXfVbyJ3t5
 CHydv3oUFVwxdizrYw9xY5Uzg/SoclE1DF4eAum3ocmzsSm3OSi7guN5mqT4dMDlC91c
 KOVYmnIYXiKeA7Ptk87EDmeH5svtgdl8Ey5/6FOusbAE1l+KR12OxKDZIA2/FDGQR99n
 ME8Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/xerzhWP/LHcJjVrQOhSQfIQ8t8SV1OXQMV2S3sKbkp/SNo9nRWMvOpOf/aE/Fy5QH6rExira4wx3c@nongnu.org
X-Gm-Message-State: AOJu0Yw6famDbmvXTTN5dK3lcuIAUYR4iw22C2PhXCHG8uEqG9ynaMpz
 /UY4PDS8AA4Cpg8asTTdSiWYZoH5agD0YMCdHQjQ4Gn7/sBiyx/rUaNPjx4a9748RVnmNYuEOpt
 ZLFQLsV1X
X-Received: from pfdj8.prod.google.com ([2002:a05:6a00:9508:b0:842:2674:ba4e])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1d90:b0:841:58b0:82bb
 with SMTP id d2e1a72fcca58-843367c711bmr4966176b3a.9.1781212360720; Thu, 11
 Jun 2026 14:12:40 -0700 (PDT)
Date: Thu, 11 Jun 2026 21:11:27 +0000
In-Reply-To: <20260611-igb-trl-v2-0-bd58de9eb0fa@google.com>
Mime-Version: 1.0
References: <20260611-igb-trl-v2-0-bd58de9eb0fa@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260611-igb-trl-v2-2-bd58de9eb0fa@google.com>
Subject: [PATCH v2 2/7] igb: Add VMState support for TRL state
From: Josh Hilke <jrhilke@google.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Josh Hilke <jrhilke@google.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::449;
 envelope-from=3yCQragcKChc6E458713BB381.zB9D19H-01I18ABA3AH.BE3@flex--jrhilke.bounces.google.com;
 helo=mail-pf1-x449.google.com
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

Add VMState representation for the Transmit Rate Limiter (TRL) state to
support migration. This includes the TRL timers and target rates per
queue.

Signed-off-by: Josh Hilke <jrhilke@google.com>
---
 hw/net/igb.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/hw/net/igb.c b/hw/net/igb.c
index c076807..edf021a 100644
--- a/hw/net/igb.c
+++ b/hw/net/igb.c
@@ -563,6 +563,46 @@ static const VMStateDescription igb_vmstate_intr_timer = {
     VMSTATE_STRUCT_ARRAY(_f, _s, _num, 0,                           \
                          igb_vmstate_intr_timer, IGBIntrDelayTimer)
 
+static bool igb_trl_needed(void *opaque)
+{
+    IGBState *s = opaque;
+
+    for (int i = 0; i < IGB_NUM_QUEUES; i++) {
+        if (s->core.trl[i].target_rate > 0) {
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
+        VMSTATE_UINT64(target_rate, IGBTrlQueue),
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
@@ -591,6 +631,10 @@ static const VMStateDescription igb_vmstate = {
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


