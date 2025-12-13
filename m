Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDEEED59F53
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Dec 2025 00:15:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vUDHl-0006en-Ud; Fri, 12 Dec 2025 19:14:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3_K88aQoKCp8L9QBLNQBNRFNNFKD.BNLPDLT-CDUDKMNMFMT.NQF@flex--marcmorcos.bounces.google.com>)
 id 1vUDHk-0006bz-8A
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 19:14:56 -0500
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3_K88aQoKCp8L9QBLNQBNRFNNFKD.BNLPDLT-CDUDKMNMFMT.NQF@flex--marcmorcos.bounces.google.com>)
 id 1vUDHi-00078Y-Q8
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 19:14:55 -0500
Received: by mail-pg1-x549.google.com with SMTP id
 41be03b00d2f7-bc0de474d4eso3042414a12.0
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 16:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1765584892; x=1766189692; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=a9byHUhq171lB8iBLQB0kPeEXv2KRtdFiOEay6iUm0M=;
 b=VUGXfSMSpigtY9Ezy0Ze5tK8mpeLn49RAuyWaha4hhqJ01nKS3wMIiWhDQ2fn9zQMi
 UahaTIUAEsoy4oZlYviAYf9mpHP594an33wGt3LVbrMHyu/bcuYIcE05UAHmiENuxcD+
 yCf2JXT9WFVPWjngiSEN1NqEKiAWXti97AIv3FdrlqV9ovG3hVKIy6ZdAmQfSCJuFpQb
 6e1XZQd2nPAGgPY383OOVu9rPb8EU2vlFkyrTALy0P8R6fvYEdKjsqWmBaonDfRDzXQA
 bkoEBjuuZHGBO64/z7cq0b8TbECbHcSjE8VBjrYLnKw3TUXg7mG+I5YNZZ3a2XRC/EXm
 BxFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765584892; x=1766189692;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a9byHUhq171lB8iBLQB0kPeEXv2KRtdFiOEay6iUm0M=;
 b=W1sllXKUGthDKuP7JWh8MVKawO/QPJeEwMvDV+/VThBXy1xdBhda9rYKv+aoLFZqkL
 +2RMP2f7XlkQOd4Y3TBdgTSCjDlnL4eE7GY7T7jVL7CDB5bAEQtScnoYodRzw7bNDbLO
 DgCdQzU9mPsHhfV0y7qUArZrvRv4u7hVuqwgs1DWfWOpU1QNvxtX8+wNmOMiJN+CVo1I
 EIp30gyziMXFbJ43ofksnUQ4MtLuNS++JuSj4gOogROUu55R2RdPasczTxIyFr0v72/V
 4pp1+nj3dtO4WxJJGpm8tjr+hbEA34T/B+6Hv0gAv+2khv9ytAElYbOCmjGarKRjt3Vz
 EOXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQW++pV/Bl5eC1HKvYaGQvJmBvfnnoy5wzwkWAyd3xZwERC4ZYs1GGQKEE6K5JWPzU3+PxabOWy43Z@nongnu.org
X-Gm-Message-State: AOJu0YxY7r4l9MN8HIGpwGLxuB5meq+yAmG1CmWLk1HQSqF6QmlZFnse
 8mrGEJhomgocRwxhA88J4vrDLkxBq+dwnVt+xvWJPMrkwvvr4ftV6XTnIzj+ohcTQepj5k16fot
 6LUhUXWMZnu+utdr95SLhgA==
X-Google-Smtp-Source: AGHT+IGcin5hyq+n2qr2rmLGMVgo9UOC9nitcjENNrPSfYURQhY4WzARb8mesPEMZ3bMottnA8mjRAjvdj3DTytt
X-Received: from dyx19.prod.google.com ([2002:a05:693c:8213:b0:2a4:6ffc:87c9])
 (user=marcmorcos job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:8283:b0:2a4:4bce:309c with SMTP id
 5a478bee46e88-2ac3025c82emr2257346eec.22.1765584892396; 
 Fri, 12 Dec 2025 16:14:52 -0800 (PST)
Date: Sat, 13 Dec 2025 00:14:40 +0000
In-Reply-To: <20251213001443.2041258-1-marcmorcos@google.com>
Mime-Version: 1.0
References: <20251213001443.2041258-1-marcmorcos@google.com>
X-Mailer: git-send-email 2.52.0.239.gd5f0c6e74e-goog
Message-ID: <20251213001443.2041258-2-marcmorcos@google.com>
Subject: [PATCH 1/4] apic: Resize APICBASE
From: Marc Morcos <marcmorcos@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Markus Armbruster <armbru@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, 
 kvm@vger.kernel.org, Marc Morcos <marcmorcos@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::549;
 envelope-from=3_K88aQoKCp8L9QBLNQBNRFNNFKD.BNLPDLT-CDUDKMNMFMT.NQF@flex--marcmorcos.bounces.google.com;
 helo=mail-pg1-x549.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

 APICBASE is 36-bits wide, so this commit resizes it to hold the full data.

Signed-off-by: Marc Morcos <marcmorcos@google.com>
---
 hw/intc/apic_common.c           | 4 ++--
 include/hw/i386/apic_internal.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index ec9e978b0b..1e9aba2e48 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -233,7 +233,7 @@ static void apic_reset_common(DeviceState *dev)
 {
     APICCommonState *s = APIC_COMMON(dev);
     APICCommonClass *info = APIC_COMMON_GET_CLASS(s);
-    uint32_t bsp;
+    uint64_t bsp;
 
     bsp = s->apicbase & MSR_IA32_APICBASE_BSP;
     s->apicbase = APIC_DEFAULT_ADDRESS | bsp | MSR_IA32_APICBASE_ENABLE;
@@ -363,7 +363,7 @@ static const VMStateDescription vmstate_apic_common = {
     .post_load = apic_dispatch_post_load,
     .priority = MIG_PRI_APIC,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINT32(apicbase, APICCommonState),
+        VMSTATE_UINT64(apicbase, APICCommonState),
         VMSTATE_UINT8(id, APICCommonState),
         VMSTATE_UINT8(arb_id, APICCommonState),
         VMSTATE_UINT8(tpr, APICCommonState),
diff --git a/include/hw/i386/apic_internal.h b/include/hw/i386/apic_internal.h
index 4a62fdceb4..c7ee65ce1d 100644
--- a/include/hw/i386/apic_internal.h
+++ b/include/hw/i386/apic_internal.h
@@ -158,7 +158,7 @@ struct APICCommonState {
 
     MemoryRegion io_memory;
     X86CPU *cpu;
-    uint32_t apicbase;
+    uint64_t apicbase;
     uint8_t id; /* legacy APIC ID */
     uint32_t initial_apic_id;
     uint8_t version;
-- 
2.52.0.239.gd5f0c6e74e-goog


