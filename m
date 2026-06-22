Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF41CDB475
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 19:07:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbjyB-0000X7-5a; Mon, 22 Jun 2026 15:06:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3mYc5agcKCuYRZPQTSMOWWOTM.KWUYMUc-LMdMTVWVOVc.WZO@flex--jrhilke.bounces.google.com>)
 id 1wbjy9-0000W3-Fj
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 15:06:05 -0400
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3mYc5agcKCuYRZPQTSMOWWOTM.KWUYMUc-LMdMTVWVOVc.WZO@flex--jrhilke.bounces.google.com>)
 id 1wbjy7-0002km-Vs
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 15:06:05 -0400
Received: by mail-pf1-x44a.google.com with SMTP id
 d2e1a72fcca58-84540c1fff4so6781317b3a.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 12:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1782155162; x=1782759962; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=Zk7AZQi/DcslPBQn4Y+CFUCxhv8E8y9BafSKtq6CD7k=;
 b=rCLRA3EEL27vJfA6Mur2hrSJHRkfSwGy3J/QxVVSl0drToNXfuzYCXDCrdpb64BMjB
 lfEzdgeli3iYqBGf7tP8BoE+TmYwWNSyqZVH3VxXRlszPJWWvBmxg0M57k6dWltK4IB/
 W0XlpnJvNULN0q/4+pEpc/PGUletVUUIg91RL1/rOwAqTeBD8iliESB2C0D1YTZ6PypU
 7noVHZK5g8rqeub3Quyd5a18cqhEhqZm7LGhV4lK7T2fIXmnGXy72levrQC2Wr38bOpt
 sjejBw5Re5ei7oACuJ6HqtUX0vn0gZjHZl+N6rXGVv07a5az2fWWdvKOFiQTNB1D1sT5
 HOug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782155162; x=1782759962;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Zk7AZQi/DcslPBQn4Y+CFUCxhv8E8y9BafSKtq6CD7k=;
 b=Kuz5KofzhAP2JQPYy4XBzujVHvjb0M5zloBP4McuWflwWWTpsitbHQ6mlwk3vxxKGN
 ZDdw8w7N+jflNvNTAPQGb4QFSXgDgk0WcLiXswMd43ToqRQPU1VIR41FNX0C5YaC2Z4v
 iRFkqXgS9OZt1YSD+CNEWo8SdW/kl+MYwARRDXsUvXvA+bjQBSyrfnrjyZnT6W2oGQct
 xLkpsdJk4pQwKgz1I74HE0ycKz2Tq1fE3LjRAM0I9OYaFe8i++mCFsytXWHH9unA0I3o
 qG82+o74PFIgbAAwcY/o0DR7A/SkWR8KVns/qsuvY5ab96857guem4/EIpNzeNYOpdEx
 pJiA==
X-Forwarded-Encrypted: i=1;
 AFNElJ99QXcN9DUwicUyP/f+Tq2QtfVKO6dr/0mOSOEJRYII7XtEcZiMjU9FSnpXeNc/Ynl6mADEM4yRHP2Q@nongnu.org
X-Gm-Message-State: AOJu0YyfKw8li5oZN41FGk87DtUc3O3dedbCmqGdjhKD3cPlhuV31U+o
 FSNMAxHq7fbNcQfBMJKV4PRZLNia/B/D60F/82Dkx3sUc+u5WHfikPhJhI9hDQdz4RK7ENMfCa9
 KLPJ9yOH2
X-Received: from pfak18.prod.google.com ([2002:aa7:92d2:0:b0:842:54be:af3e])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3cd4:b0:842:5564:2e2c
 with SMTP id d2e1a72fcca58-8455604e44dmr15693741b3a.5.1782155161532; Mon, 22
 Jun 2026 12:06:01 -0700 (PDT)
Date: Mon, 22 Jun 2026 19:05:39 +0000
In-Reply-To: <20260622-igb-trl-v7-0-abb960e767ac@google.com>
Mime-Version: 1.0
References: <20260622-igb-trl-v7-0-abb960e767ac@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260622-igb-trl-v7-2-abb960e767ac@google.com>
Subject: [PATCH v7 2/7] igb: Add VMState support for TRL state
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
 envelope-from=3mYc5agcKCuYRZPQTSMOWWOTM.KWUYMUc-LMdMTVWVOVc.WZO@flex--jrhilke.bounces.google.com;
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
2.55.0.rc0.786.g65d90a0328-goog


