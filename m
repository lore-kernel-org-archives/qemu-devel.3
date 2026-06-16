Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73202CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 22:36:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZcO9-0007N8-QB; Tue, 16 Jun 2026 18:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <31M8xagcKCpM6E458713BB381.zB9D19H-01I18ABA3AH.BE3@flex--jrhilke.bounces.google.com>)
 id 1wZcO8-0007Mg-FQ
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 18:36:08 -0400
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <31M8xagcKCpM6E458713BB381.zB9D19H-01I18ABA3AH.BE3@flex--jrhilke.bounces.google.com>)
 id 1wZcO6-0001cU-QW
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 18:36:08 -0400
Received: by mail-pl1-x64a.google.com with SMTP id
 d9443c01a7336-2c6a9bbcc53so7708445ad.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 15:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781649364; x=1782254164; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=Uig/xRQ/8j7fiTHq08E30tu2sZHsBpLElMXuG3JygLg=;
 b=eT80CK7q2BKZ82LSaRjPwkPR4lFFPi7jflP6RIh283USaKKvZSn8aT3WLMEAe66aZz
 rAwt1BxTibK8c5oY9quqx26NlTrHAQHfXucSuV0ShUfOumhv2mnTK28AU1u1zR3ZVh76
 oGzFFYw9JfZ2nhgULYrMywm9xX1UTzjB9oTLI1kfG9Y/RcijSLYSQZVw7qijApj8YlT3
 yYloelitwcOr6XzfqozI6f8egtdYoo+ig9t32dC4njNvyjFyG52bpb14Sul0RxrXqLYQ
 GfVN2IsmZwSauelMRabUf9KdlsHaS8UlK4Rx/eShn9TK4CIga+xa2Y80wDDYjYeER+aU
 tWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781649364; x=1782254164;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Uig/xRQ/8j7fiTHq08E30tu2sZHsBpLElMXuG3JygLg=;
 b=GqRTmO9PLr55f4lFLt5isUwsS4F61aHDAVfqezsNqRI/LKdVYEFqnE7/WLX2xac+Wb
 9dgow7tQqTX2cCHVNNunPU2/UlRQs9CUCIfMLOu6dT6kq4wxNlrFJXq8GNhSnfDM+PVu
 05nKwsATfWG1wQIxTI4WbJOT/xlXPjEoUimMVXrzcx2TQYrSuIu1nQVsl1HxTWgnRY7A
 27vpPCKELvrqjM8JNt7Uf7N5KDE8CiXq+vYaThtUh1vMnvEqCz5Nlx0JkrViYQ2xWWo5
 EBc4Ilnb3fRfSDz5LA7SdmVJlqD/kumLLjJRIz4Le3ULOeLMfDxdZjFsPhyEJ1vSeJNx
 eUuQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9AKGD92NAlxtuoiOAMzz20mukvqb6+S+RS+2tYuSP8/qZTorvPdDTrVXZODF3r6OWe01b6DkBasB8C@nongnu.org
X-Gm-Message-State: AOJu0YySFhp6gQjjOrylnlKsueh+LOCiojxWQpH7E8+s8ixV63Ls9jG6
 X6zzNRZhSczqsLjWKn150ezgCgmNd17V/32Kd9hTY9kPxFg172AX7Kr8Hwtm4TR5WRpkn1r8HAP
 46kSrtAbq
X-Received: from plpn21.prod.google.com ([2002:a17:902:9695:b0:2c0:d4b7:5d29])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f546:b0:2c1:566b:f907
 with SMTP id d9443c01a7336-2c6bc223d48mr8707035ad.20.1781649364097; Tue, 16
 Jun 2026 15:36:04 -0700 (PDT)
Date: Tue, 16 Jun 2026 22:35:29 +0000
In-Reply-To: <20260616-igb-trl-v5-0-1183e3635e06@google.com>
Mime-Version: 1.0
References: <20260616-igb-trl-v5-0-1183e3635e06@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260616-igb-trl-v5-2-1183e3635e06@google.com>
Subject: [PATCH v5 2/7] igb: Add VMState support for TRL state
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
 envelope-from=31M8xagcKCpM6E458713BB381.zB9D19H-01I18ABA3AH.BE3@flex--jrhilke.bounces.google.com;
 helo=mail-pl1-x64a.google.com
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
2.54.0.1136.gdb2ca164c4-goog


