Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CDD8C83F17
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 00:12:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua1N1-0001JZ-1w; Thu, 10 Jul 2025 20:12:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ua1LO-0000Pd-1B
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 20:10:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ua1LK-0008Nl-RM
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 20:10:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752192621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QhFZBsq2mcH705rIdIS5JbUfLJNtJ82JTmEQMfOv02Y=;
 b=ZDHcEuWEPlXXbPaFsY5KUqudQpiEnLZV8wem34HSTNFtGDAWLy9n12TH5GtH5k9TyNANCo
 X/tzxhMF5ez0dELGDTk4dvvk8eaK4tiJag5D1RyvJzYEG2AMCSUS7dtKuVPMd4i+/b3pmG
 m7WJad6id5V2AZN72GIHoiG4CwbKAao=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-icg-pWw4NGKNTz8RPaoFgQ-1; Thu, 10 Jul 2025 20:06:35 -0400
X-MC-Unique: icg-pWw4NGKNTz8RPaoFgQ-1
X-Mimecast-MFC-AGG-ID: icg-pWw4NGKNTz8RPaoFgQ_1752192395
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-450de98b28eso12200195e9.0
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 17:06:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752192393; x=1752797193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QhFZBsq2mcH705rIdIS5JbUfLJNtJ82JTmEQMfOv02Y=;
 b=iVLR+GrWYMBoQwKBumWtYmLpmdJIVzmT8fF65YOWufjrPRps4KSLsyMq3kY6mGyWg6
 isp3m+XaOnPMgXCFhbAUwVFXoecOCLrarctGb+nItzuN8+0B1X8bsOKIvlU+WNeE7VQa
 pf+FhCgQ7aV4DBqNC5xgScM0/g7rQbP60p801Cura1axnCJRK2/B65fVkrcDs0WveYlU
 UxzPGpI8SSE9hJwp/o802v1LcjHrtHn0jUlUx3iSkKjgwQdjpQEIget7igphmPKfVO9x
 mVUzc5t6hxsHSQM1BUp9LYJTrWmqA6w+Fq8kuFHAYMaMRZjfmyY2FVemGjIoEXrzoWj4
 FzGA==
X-Gm-Message-State: AOJu0YxpWV0l9904NADRYUIn1AOPaE1i2p46D9T9F/MDznE/d6w5oNh0
 aHCQfCBvWN6hYWRRYddaTMP6bK+5bclXJcegXWkehZkPzHdGaLKYKb43XuFwo7vlbxiVc2WjjG8
 BFtaKRfNbMasIesLGJEl7d9ZBh9YFKJSH43sPAaXt8AXbl6LLDjNguu99ut7ZH0ZkGyCs+5fbF7
 3/2/sNLWQ8oVCpF812hNVLf5Qxii7n+LUsZimjV3sv
X-Gm-Gg: ASbGncvPVusS2SWD5UB6wU0DiwpxKCGw1YYkBJklTecmqstMaSe2F1EMJWyHm0pvFR9
 wDsHI/3XrZiQQkb/NVcoYIJwgzCFI5/3R92yS4ZfjtIRXerhhudT1Obz//q3AXus3Q/1P7r/X0a
 a6doOiH69QiqDAB9FA4zavhIWFjzJ/KXuGBlyS2YI4HT7BRYPxh85QyTaqzB8iXkL3cZhUVFzFI
 AaejYPRQEPQWQXA0l3uzMcr5fZxCzkkmprMJNBFf3rT81iXJ891sKmTCH/TmuKYeuIktHR9uqza
 rhK5a48rCm+pmoOUP4/6rLnFZfyzySlqaYICDbquILkk
X-Received: by 2002:a05:600c:4ab0:b0:453:79e8:e92d with SMTP id
 5b1f17b1804b1-454db88fe12mr37626315e9.5.1752192392859; 
 Thu, 10 Jul 2025 17:06:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiq+8PT+39k8woi1szLsWTlwjyxZzgWbWPZ2b4aKH1GJ2nz38LYvfle0ZMuKv/W5NgZ+/FiQ==
X-Received: by 2002:a05:600c:4ab0:b0:453:79e8:e92d with SMTP id
 5b1f17b1804b1-454db88fe12mr37626145e9.5.1752192392211; 
 Thu, 10 Jul 2025 17:06:32 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.202.169])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454dd43915dsm32117665e9.7.2025.07.10.17.06.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 17:06:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: xiaoyao.li@intel.com,
	zhao1.liu@intel.com
Subject: [PATCH 4/4] target/i386: move accel_cpu_instance_init to
 .instance_init
Date: Fri, 11 Jul 2025 02:06:03 +0200
Message-ID: <20250711000603.438312-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250711000603.438312-1-pbonzini@redhat.com>
References: <20250711000603.438312-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

With the reordering of instance_post_init callbacks that is new in 10.1
accel_cpu_instance_init must execute in .instance_init as is already
the case for RISC-V.  Otherwise, for example, setting the vendor
property is broken when using KVM or Hypervisor.framework, because
KVM sets it *after* the user's value is set by DeviceState's
intance_post_init callback.

Reported-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 46d59229200..5f95bb97b82 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6207,8 +6207,8 @@ static void max_x86_cpu_initfn(Object *obj)
     CPUX86State *env = &cpu->env;
 
     /*
-     * these defaults are used for TCG, other accelerators overwrite these
-     * values
+     * these defaults are used for TCG, other accelerators have overwritten
+     * these values
      */
     if (!env->cpuid_vendor1) {
         object_property_set_str(OBJECT(cpu), "vendor", CPUID_VENDOR_AMD,
@@ -9043,8 +9043,6 @@ static void x86_cpu_post_initfn(Object *obj)
         }
     }
 
-    accel_cpu_instance_init(CPU(obj));
-
 #ifndef CONFIG_USER_ONLY
     if (current_machine && current_machine->cgs) {
         x86_confidential_guest_cpu_instance_init(
@@ -9119,6 +9117,8 @@ static void x86_cpu_initfn(Object *obj)
     if (xcc->model) {
         x86_cpu_load_model(cpu, xcc->model);
     }
+
+    accel_cpu_instance_init(CPU(obj));
 }
 
 static int64_t x86_cpu_get_arch_id(CPUState *cs)
-- 
2.50.0


