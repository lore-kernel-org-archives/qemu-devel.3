Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD16FCAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 10:42:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v10T7-0004iz-So; Tue, 23 Sep 2025 06:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v10T6-0004hv-7D
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 06:41:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v10T0-0006DH-Sm
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 06:41:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758624107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a375QZbeNwmaWpIoRvdNLtIS+2HVCnHIvRjrNsLKivI=;
 b=cCIzNFDwN9ylseh4a4A5aDha7yogbsz/+S++GV2wzUgeLv2r2SRUg0OGqyeBhn0exd0Op1
 S7pqJSUN9XpVbh1dwChDhuy3sV7hqYLmTWeu5MzaUbdAaMIRYwuJ8sBjN7daINKHoJa5W8
 DOOUW3biH/6zRO1BsUS6yZsI5PgewmE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-2ffC2dplPtinRShS1E7X2g-1; Tue, 23 Sep 2025 06:41:46 -0400
X-MC-Unique: 2ffC2dplPtinRShS1E7X2g-1
X-Mimecast-MFC-AGG-ID: 2ffC2dplPtinRShS1E7X2g_1758624105
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b2ee3c13b3eso91697166b.2
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 03:41:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758624104; x=1759228904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a375QZbeNwmaWpIoRvdNLtIS+2HVCnHIvRjrNsLKivI=;
 b=ZJ52fnvYLxtNgHyouY3CpSokyELZCH7l7V79/oTtrkpHF/t0laspCWertPbgQmSCSs
 qHojtNvVVxTdh73mh56ciotp+Lmrmpwhw+Zs4E3vDssRltcQL25rga/DKsr3/lIhtB8f
 GxIse5FVeYfr9Uq4/UIJIVbSVXPls8Su5utu2Lg3gI5OF2g8CTwGZkGUeD/txfSMwHl4
 nzLBn3/N0sJayAmMbQNunWLenirZ1Y2d7xuRrnul3BJriqOzggb57KH3lQaan7qWsnNU
 yP5eM1zRdAhlN3qTOUrQmSP58FfUb/y0wzNUQ+fuYsvh+dN00Gg8PsoNHfS1FaJYfcPA
 2ALA==
X-Gm-Message-State: AOJu0YysiCgCnI20XH0bVnvTxYsSPibWVrWwc5HcSb8hqQHhRs4Vo0Eg
 AaEVmChnr6zj+wFMRstDYB3Eecme2cfJXmCgR6J/AMN+LsuuvcgyNaip90ZKj/lrIe6YQaBFADc
 Q02OYys/UrJVfF9iU1CPVB3RXV1gcOm1Q0cKM6v9SWjTpHs3G0SOSNMuJg2K7Tm8pyvUZWjcgsp
 Kv6tJow94FaqnjBNDbuJd6O8GLnIwxNQhGhWrrhdEv
X-Gm-Gg: ASbGncu179YEXMnTtujy0W+y0gjxuBNsOiINM6JWp+ZTgB226UJONqmyHOq+jUfjrg+
 fA1vAXqThv31y99Q9wQD7uohwCX/jxCxTGfgbN7qQny/j74oTAYgim02h13ju7zWqbXjLVCx2FG
 ipw4MKBjFehGdwRWqHu49H7btOrEKxXnwlHcIjR/CFyv33fKH0akp+Xwwr7467mmAdo3BQ+d50X
 fS1R9AihofS8JARe7TllEvXYwZ3g1jWiqXqLHYvnSjHl/BKj3jjqLTVU/VS7o7jDZeUjrfw4E6k
 dtS3m9yTmgaN7pl+f5Znsk4wqYDnOX+QR45D3TnmeDnhmWKSfuthWOFk//8OtXPlbVfi0ACD4yx
 jlpr6nlRfSVUBpsP9cdfrYj2GgKKqCq0L0ts+kbBQQNo5qw==
X-Received: by 2002:a17:907:7f13:b0:b07:88aa:255b with SMTP id
 a640c23a62f3a-b302689510bmr198565766b.11.1758624103997; 
 Tue, 23 Sep 2025 03:41:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaRQct4v6u6fwKFvJ5qxUMkG5X5B2BjOJRWuJk4kwB2ravZy8/qumoVfFXg4yw/aekmyIc+g==
X-Received: by 2002:a17:907:7f13:b0:b07:88aa:255b with SMTP id
 a640c23a62f3a-b302689510bmr198563366b.11.1758624103507; 
 Tue, 23 Sep 2025 03:41:43 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-62fa5f287d9sm10683105a12.44.2025.09.23.03.41.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Sep 2025 03:41:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: hector.cao@canonical.com,
	lk@c--e.de,
	berrange@redhat.com
Subject: [RFT PATCH v2 2/2] target/i386: add compatibility property for pdcm
 feature
Date: Tue, 23 Sep 2025 12:41:36 +0200
Message-ID: <20250923104136.133875-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250923104136.133875-1-pbonzini@redhat.com>
References: <20250923104136.133875-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Hector Cao <hector.cao@canonical.com>

The pdcm feature is supposed to be disabled when PMU is not
available. Up until v10.1, pdcm feature is enabled even when PMU
is off. This behavior has been fixed but this change breaks the
migration of VMs that are run with QEMU < 10.0 and expect the pdcm
feature to be enabled on the destination host.

This commit restores the legacy behavior for machines with version
prior to 10.1 to allow the migration from older QEMU to QEMU 10.1.

Signed-off-by: Hector Cao <hector.cao@canonical.com>
Link: https://lore.kernel.org/r/20250910115733.21149-3-hector.cao@canonical.com
Fixes: e68ec298090 ("i386/cpu: Move adjustment of CPUID_EXT_PDCM before feature_dependencies[] check", 2025-06-20)
[Move property from migration object to CPU. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h |  6 ++++++
 hw/i386/pc.c      |  1 +
 target/i386/cpu.c | 15 ++++++++++++---
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 414ca968e84..42168f1d6d8 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2320,6 +2320,12 @@ struct ArchCPU {
      */
     bool arch_cap_always_on;
 
+    /*
+     * Backwards compatibility with QEMU <10.1. The PDCM feature is now disabled when
+     * PMU is not available, but prior to 10.1 it was enabled even if PMU is off.
+     */
+    bool pdcm_on_even_without_pmu;
+
     /* Number of physical address bits supported */
     uint32_t phys_bits;
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index d7f48150fdd..4668918746e 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -88,6 +88,7 @@ GlobalProperty pc_compat_10_0[] = {
     { TYPE_X86_CPU, "x-consistent-cache", "false" },
     { TYPE_X86_CPU, "x-vendor-cpuid-only-v2", "false" },
     { TYPE_X86_CPU, "x-arch-cap-always-on", "true" },
+    { TYPE_X86_CPU, "x-pdcm-on-even-without-pmu", "true" },
 };
 const size_t pc_compat_10_0_len = G_N_ELEMENTS(pc_compat_10_0);
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index fe369bb1284..ab18de894e4 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7908,6 +7908,11 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             /* Fixup overflow: max value for bits 23-16 is 255. */
             *ebx |= MIN(num, 255) << 16;
         }
+        if (cpu->pdcm_on_even_without_pmu) {
+            if (!cpu->enable_pmu) {
+                *ecx &= ~CPUID_EXT_PDCM;
+            }
+        }
         break;
     case 2: { /* cache info: needed for Pentium Pro compatibility */
         const CPUCaches *caches;
@@ -8958,9 +8963,11 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
         }
     }
 
-    /* PDCM is fixed1 bit for TDX */
-    if (!cpu->enable_pmu && !is_tdx_vm()) {
-        env->features[FEAT_1_ECX] &= ~CPUID_EXT_PDCM;
+    if (!cpu->pdcm_on_even_without_pmu) {
+        /* PDCM is fixed1 bit for TDX */
+        if (!cpu->enable_pmu && !is_tdx_vm()) {
+            env->features[FEAT_1_ECX] &= ~CPUID_EXT_PDCM;
+        }
     }
 
     for (i = 0; i < ARRAY_SIZE(feature_dependencies); i++) {
@@ -10021,6 +10028,8 @@ static const Property x86_cpu_properties[] = {
 
     DEFINE_PROP_BOOL("x-arch-cap-always-on", X86CPU,
                      arch_cap_always_on, false),
+    DEFINE_PROP_BOOL("x-pdcm-on-even-without-pmu", X86CPU,
+                     pdcm_on_even_without_pmu, false),
 };
 
 #ifndef CONFIG_USER_ONLY
-- 
2.51.0


