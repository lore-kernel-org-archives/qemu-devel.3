Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A23FD108B91B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 12:44:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3ZDC-00035L-Pz; Fri, 20 Mar 2026 08:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <souravpoddar93042@gmail.com>)
 id 1w3XQa-0003NW-Pu
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 06:50:04 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <souravpoddar93042@gmail.com>)
 id 1w3XQZ-0007Rc-78
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 06:50:04 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2aaed195901so6918205ad.0
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 03:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774003801; x=1774608601; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IudP9wlwQWFWvGS2EM15AJMxoKy6dSNj075kgaYv/8s=;
 b=GYS9zN8/+eS33kN5vhtX2Y588GFUj+aqTwzrsRakXcHVUSNkJouIvVd/+is7ndc3BE
 tVZtbm+FonIDZLUoAKVk4/OkXIkENZBubGUs7v5HYW6kbWLvfBqLYgLS30OfjdUcY3hR
 BTiV1c8I8a/9E6mH4BHM0nq3jts3o+zMtepKKI29JsIZC/MaggRFDBcqne5NKdFS5D73
 fxQ4uNvmVpytJnpVg5Vac2Rb3bKB+LR7FEcqcxGYRQdcZ+Ry4+SUTfPHYZKNLFdg/Ti3
 1r+FneANbLaWXZwwWGu8sp+wKe3PXGBOvsPTdmt0fZgnaufvcQqAaEol58VHV7D+p4kl
 XSnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774003801; x=1774608601;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IudP9wlwQWFWvGS2EM15AJMxoKy6dSNj075kgaYv/8s=;
 b=QMHw+dAtfG4cG/AzYwAlDZ1P6qiRJ+1Il/3OqwuYuZ60G4f47eFFhE5CxYK9SALhA8
 CT17OHnWZKe/HuGvhEDpnXT1nZg7rAlpRurug7l7WH47g6V2BMu2eLexcmMNOTL9bLLu
 UG5zLaser8eHKhkdfxJH/ddND/4pJWNpVJrUBm4hSSdsl+0Z/diOkWBIHh0grlOyTD2u
 lgULa/exaXWIUAPCttt2v+LHeeJ7nPbH6rSxpVSS22eIIRrpcwsmQyMCMAefSheVcjDy
 rf0USQSa2WJYF9Q0xtfRv9ZgMGqQU2VCjkWy1/WIKAYbI14PfmASYCSutCCQJlpTj+V2
 bKBg==
X-Gm-Message-State: AOJu0Yxvh14zVAmqayImKnTukcRFEXxHtv/RDVtniOcs7ZAvU5M3ZS5V
 ZNUW+iUSUcnkyfr5QqOa/S+2GrBU1Mo4haJWhelTbXLQ9VSJqPm/bjG/zb16sZiV
X-Gm-Gg: ATEYQzz+plwD+fCzWr5b7s0v2PFQK93oJk0UluODckZlcID3GEClhbUOnwu5+GR5wba
 eDHg3XQqMUnT9SuU0A9C2SybZTTo4uDgbDV4HUoS/htpk3sElr7E1N7W3coxtpKOOpn3sR5PUc/
 2+3xmLUMugnfvCEJzoU6JN/fA6cjZY/TasTMO5zPKICylvM3Sk1MLnU3U/+26JBaPmiNsVaDBeF
 sRNz621zPhsZZbSrPODIrjzbKHiQX1+lrMsp0CKsnHk9m0cv0haqDAKADhoqoiSpF+2I0cWXwvh
 dWjVCHm8wOpdn1zixO12smu44LqdNshFLrYcWWA3fkllxeK6u5imMmu5NATpsdn6TbQTh4nXMY1
 RwGdeWpEpU6EDHaJvM23VwWyehd3y5CoT9C7OshbfLpPCqVMVX1kJ+zeOTm7eGwgnTLiaV08s3F
 eF5ehjMJ+ArqMbFKKRAVovykLSyERT1X24uWhN
X-Received: by 2002:a17:902:d506:b0:2b0:65e8:4041 with SMTP id
 d9443c01a7336-2b08279a40fmr25051715ad.36.1774003800835; 
 Fri, 20 Mar 2026 03:50:00 -0700 (PDT)
Received: from kishu ([49.249.103.234]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b08369617dsm25687295ad.71.2026.03.20.03.49.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 03:50:00 -0700 (PDT)
From: Sourav Poddar <souravpoddar93042@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, anisinha@redhat.com,
 Sourav Poddar <souravpoddar93042@gmail.com>
Subject: [PATCH] hw/hyperv: fix SynIC not initialized for CPUs after the first
Date: Fri, 20 Mar 2026 16:19:53 +0530
Message-ID: <20260320104953.67351-1-souravpoddar93042@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=souravpoddar93042@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 20 Mar 2026 08:44:21 -0400
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

hyperv_is_synic_enabled() is a global flag that returns true after the
first CPU initializes SynIC. With -smp N, all subsequent CPUs skip
hyperv_x86_synic_add(), leaving them without a synic object. This causes
get_synic() to return NULL, making hyperv_sint_route_new() fail and
triggering an assertion crash in hyperv_testdev.

Fix by introducing hyperv_is_synic_present() which checks per-CPU
whether a synic object is already attached instead of using the global
flag.

Fixes: c4cf32fc63f1 ("kvm/hyperv: add synic feature to CPU only if its not enabled")
Reported-by: Xudong Hao
Signed-off-by: Sourav Poddar <souravpoddar93042@gmail.com>
---
 hw/hyperv/hyperv.c         | 5 +++++
 include/hw/hyperv/hyperv.h | 1 +
 target/i386/kvm/kvm.c      | 2 +-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
index 27e323a819..ff53cbc699 100644
--- a/hw/hyperv/hyperv.c
+++ b/hw/hyperv/hyperv.c
@@ -60,6 +60,11 @@ static SynICState *get_synic(CPUState *cs)
     return SYNIC(object_resolve_path_component(OBJECT(cs), "synic"));
 }
 
+bool hyperv_is_synic_present(CPUState *cs)
+{
+    return get_synic(cs) != NULL;
+}
+
 static void synic_update(SynICState *synic, bool sctl_enable,
                          hwaddr msg_page_addr, hwaddr event_page_addr)
 {
diff --git a/include/hw/hyperv/hyperv.h b/include/hw/hyperv/hyperv.h
index 63a8b65278..23091301d0 100644
--- a/include/hw/hyperv/hyperv.h
+++ b/include/hw/hyperv/hyperv.h
@@ -81,6 +81,7 @@ void hyperv_synic_reset(CPUState *cs);
 void hyperv_synic_update(CPUState *cs, bool enable,
                          hwaddr msg_page_addr, hwaddr event_page_addr);
 bool hyperv_is_synic_enabled(void);
+bool hyperv_is_synic_present(CPUState *cs);
 
 /*
  * Process HVCALL_RESET_DEBUG_SESSION hypercall.
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index a29f757c16..f5faf32606 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -1754,7 +1754,7 @@ static int hyperv_init_vcpu(X86CPU *cpu)
             return ret;
         }
 
-        if (!hyperv_is_synic_enabled()) {
+        if (!hyperv_is_synic_present(CPU(cpu))) {
             ret = hyperv_x86_synic_add(cpu);
             if (ret < 0) {
                 error_report("failed to create HyperV SynIC: %s",
-- 
2.53.0


