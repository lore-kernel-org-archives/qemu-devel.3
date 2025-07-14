Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28728C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:44:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubHLK-0005YU-7H; Mon, 14 Jul 2025 07:27:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH0R-0001Nt-3r
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:06:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH0O-0001zO-Ia
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:05:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H++7bFZZz0BdH8FF5Yhc/WS1RX64LTDufArp4gDgK4o=;
 b=dJCmbhBi932eyQ87b/IQ8hx1UhTgA8byC+A94PFArFhBpwVbUDoawfmCQXK+lDU2DZY8fd
 MYvqnSJZrSI5nwQL4v+4NckVyIalPEZfav7N0/5ZDdt+oNZJ5Awjp3XtC92UBvWxZhLwBC
 xhQhDDl8oCSfZyAavqAxq6VnZvGGGv8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-QCEMveEvOlWWZL5H0ZwIVw-1; Mon, 14 Jul 2025 07:05:54 -0400
X-MC-Unique: QCEMveEvOlWWZL5H0ZwIVw-1
X-Mimecast-MFC-AGG-ID: QCEMveEvOlWWZL5H0ZwIVw_1752491153
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-451ecc3be97so22101655e9.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:05:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491153; x=1753095953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H++7bFZZz0BdH8FF5Yhc/WS1RX64LTDufArp4gDgK4o=;
 b=vRo1my5gf/Vt1nV5+8GiWsrIxS5MU2TRAXo72hd+0SWuXMQLKDlcxXFJ+LlkqTy0sn
 hTDytZLTuReGiqWAPlxTVYMLYLAMtgz9T2XxMVNgi65w3PreKDDbJ8qEF9KwBgADXQ7j
 uABxUzGafFz1ryttoBb701Sjd7D9y/ok4dK0TZGbY56joEv558J7CbRMWt+mufR+jV2P
 wIYT2WQLNY4afWkJajQsFdFaIgHEQmwzfpUAyRXWCgnut529PKxlS9qIm1+vD7++x748
 adkTavQoSQSUCZu68ecD4uPjgQptO5J6KSSng24933XOhvegq5faSy7NVDCqm+9LyMcU
 8jTQ==
X-Gm-Message-State: AOJu0YxU53iv48niSVtPcyIyZ7U9NIRzDSz6KbdGjp6DaRwUOVteH+5v
 2NTvebA6TZgdvUil9eWLfp05eUUxl08OmKuMQ5zKbwvLM6rze5hNadttVnGcB5LAQnLaX0hvy23
 zEwHuMXUPzBRHkdZ8sYgizqSyfJJ+7Kqu+CbV4RCYLlk/YytuJhKfipYPyAlQuNPMah80hCqufT
 HUrbfe3ydWQggJ5G5/Z9K5WYSSCPuF2w2MHFjkLWdl
X-Gm-Gg: ASbGnctsP1E8iiSaXRs062j9kYkSNaGNRvxNYRDGYyqn+qmTzS76Lhu9t8W1WJmoL6a
 OSWcEj4w3UhxnjPy3QtDBgdfXkZWONnuHtIauKPkfW+kjwZpNwIIogvs8HWp3iDsImc+xvSYX4d
 BmQuZGElf/hd2gwUDWmbIy53C6sZhNvM2rDtri0RJQOIzIO/jzi/TsjN8BE3g1U8OonHUdbw8OF
 /dG6RrvNp3jm4iNn1cQzOVP6gDd7p/kFXv1NK1V07rX8tkSw8ytkXgr1e4nUEu4aphgAmbndAaI
 zrOmvyFqXdO4b1b6UDEN+4uQtRTAqVZ6hpFq8lB+JpA=
X-Received: by 2002:a05:600c:34c5:b0:43c:fe5e:f040 with SMTP id
 5b1f17b1804b1-45565edc8f4mr99187415e9.23.1752491152433; 
 Mon, 14 Jul 2025 04:05:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEVLM3vTpeynBS77usHfWMNhE2tboZqaO3bZMr/ImTuMBrQQ7nqF9KAqtYPV/W60Pzy1FexQ==
X-Received: by 2002:a05:600c:34c5:b0:43c:fe5e:f040 with SMTP id
 5b1f17b1804b1-45565edc8f4mr99187165e9.23.1752491151874; 
 Mon, 14 Jul 2025 04:05:51 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d50ded8csm166809555e9.20.2025.07.14.04.05.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:05:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 39/77] i386/tdx: Don't mask off CPUID_EXT_PDCM
Date: Mon, 14 Jul 2025 13:03:28 +0200
Message-ID: <20250714110406.117772-40-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

It gets below warning when booting TDX VMs:

  warning: TDX forcibly sets the feature: CPUID[eax=01h].ECX.pdcm [bit 15]

Because CPUID_EXT_PDCM is fixed1 for TDX, and MSR_IA32_PERF_CAPABILITIES is
supported for TDX guest unconditioanlly.

Don't mask off CPUID_EXT_PDCM for TDX.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250625035710.2770679-1-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b768838b100..f9e6bc8d0e6 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -28,6 +28,7 @@
 #include "system/hvf.h"
 #include "hvf/hvf-i386.h"
 #include "kvm/kvm_i386.h"
+#include "kvm/tdx.h"
 #include "sev.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
@@ -8336,7 +8337,8 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
         }
     }
 
-    if (!cpu->enable_pmu) {
+    /* PDCM is fixed1 bit for TDX */
+    if (!cpu->enable_pmu && !is_tdx_vm()) {
         mark_unavailable_features(cpu, FEAT_1_ECX,
                                   env->user_features[FEAT_1_ECX] & CPUID_EXT_PDCM,
                                   "This feature is not available due to PMU being disabled");
-- 
2.50.0


