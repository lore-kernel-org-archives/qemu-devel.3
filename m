Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9701D767F2
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 17:53:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6ZM5-0000eP-Ux; Thu, 31 Oct 2024 13:53:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZLx-0000JX-Lu
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:53:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZLu-0007Kg-R2
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:53:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730397177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uqyIiyvHys8KBfxqG7hcxcVVd+Iuu5RfsAP/eB34Hlo=;
 b=Rm6nlUH1aVdnL1eGDjDd+v3SvO49ckN3JefaAFKWM/QObbHmgjtnVHe8uDuWkbHCEBHgyh
 +yAYC4PjumcXtb269czgDe7hqktX28HTXv2lVoH3RZjTUJHe3HcxOWeoo9Rr7rtcIVKIoc
 qA7CeztvN4eeCsN+KWi1xWz4p8au71c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-IRPUpcGmN--xM1ZYMdsWMw-1; Thu, 31 Oct 2024 13:52:56 -0400
X-MC-Unique: IRPUpcGmN--xM1ZYMdsWMw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4315afcae6cso6907315e9.0
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 10:52:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397174; x=1731001974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uqyIiyvHys8KBfxqG7hcxcVVd+Iuu5RfsAP/eB34Hlo=;
 b=fYk2LtYOJGEOE6z2UU/d6YXryYFXIiW7t07zMdMVXBDePMgIwCAmw6PzYBQuItFtXy
 q0am7t1IVir9MH+ulBHHHYtFPHa/InEnW8dhyx2piTwdMdJUbBeDJjtZYBTma3s6mT/G
 /rc4LJjDWzf9vpaUEa/MSUyWTTCxx5fCiozb8wp60ZEze3wsCiGtzfNHlXKqeaW9/oPl
 /+GRNCe/A2zaA+gqrMiTohDEDo14REq/gmbpj0CpLTIhTXEfMQHAv5yr61fqxCRaqJXZ
 ZDoM5pSdtP1Z/8fPch/5pu6D6kk/q2omuXvgTaThhp3CoKzN6UCtL/tTu53TVV7Ye1Gr
 hg6Q==
X-Gm-Message-State: AOJu0Yz55mbu1oSfurHVSUL/mS7WLT9H8roa01OUoA3i2PjtGQGg72F+
 xdlQ0u97iRV6f7dAPnUl+/CbvlKF/kRNfRLI3S13UJIbmCpKFb9472jFNS6i0NGXMIqJX8aor4u
 j9g5fYjdLi4Aa5dfUwxM2xVIYa37x4p3uPr+D0bBF10htzUxxRZQbPJNUmrHgGFtxJmZYB99Onj
 JW2e2ayF6pQov8xF0tdeqVfrwCdmWS0VlJ3p+o1Zg=
X-Received: by 2002:a05:600c:4f54:b0:42c:b991:98bc with SMTP id
 5b1f17b1804b1-43282eb229fmr8789415e9.0.1730397174097; 
 Thu, 31 Oct 2024 10:52:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPNy5d4Hg1S5GDYkcw8uv0/7YOCwI88avT1ioNIoLjSMjaC2HxTBtJAafPXWsKzmRz09MFSQ==
X-Received: by 2002:a05:600c:4f54:b0:42c:b991:98bc with SMTP id
 5b1f17b1804b1-43282eb229fmr8789235e9.0.1730397173693; 
 Thu, 31 Oct 2024 10:52:53 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d6984e3sm35492885e9.48.2024.10.31.10.52.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 10:52:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Sandipan Das <sandipan.das@amd.com>, Babu Moger <babu.moger@amd.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 17/49] target/i386: Add PerfMonV2 feature bit
Date: Thu, 31 Oct 2024 18:51:41 +0100
Message-ID: <20241031175214.214455-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031175214.214455-1-pbonzini@redhat.com>
References: <20241031175214.214455-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Sandipan Das <sandipan.das@amd.com>

CPUID leaf 0x80000022, i.e. ExtPerfMonAndDbg, advertises new performance
monitoring features for AMD processors. Bit 0 of EAX indicates support
for Performance Monitoring Version 2 (PerfMonV2) features. If found to
be set during PMU initialization, the EBX bits can be used to determine
the number of available counters for different PMUs. It also denotes the
availability of global control and status registers.

Add the required CPUID feature word and feature bit to allow guests to
make use of the PerfMonV2 features.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/a96f00ee2637674c63c61e9fc4dee343ea818053.1729807947.git.babu.moger@amd.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h |  4 ++++
 target/i386/cpu.c | 26 ++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 9eb45faa654..e0dea1ba54a 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -634,6 +634,7 @@ typedef enum FeatureWord {
     FEAT_8000_0007_EDX, /* CPUID[8000_0007].EDX */
     FEAT_8000_0008_EBX, /* CPUID[8000_0008].EBX */
     FEAT_8000_0021_EAX, /* CPUID[8000_0021].EAX */
+    FEAT_8000_0022_EAX, /* CPUID[8000_0022].EAX */
     FEAT_C000_0001_EDX, /* CPUID[C000_0001].EDX */
     FEAT_KVM,           /* CPUID[4000_0001].EAX (KVM_CPUID_FEATURES) */
     FEAT_KVM_HINTS,     /* CPUID[4000_0001].EDX */
@@ -1022,6 +1023,9 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 /* Automatic IBRS */
 #define CPUID_8000_0021_EAX_AUTO_IBRS   (1U << 8)
 
+/* Performance Monitoring Version 2 */
+#define CPUID_8000_0022_EAX_PERFMON_V2  (1U << 0)
+
 #define CPUID_XSAVE_XSAVEOPT   (1U << 0)
 #define CPUID_XSAVE_XSAVEC     (1U << 1)
 #define CPUID_XSAVE_XGETBV1    (1U << 2)
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 94faff83cd8..846d3a9ef9c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1227,6 +1227,22 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .tcg_features = 0,
         .unmigratable_flags = 0,
     },
+    [FEAT_8000_0022_EAX] = {
+        .type = CPUID_FEATURE_WORD,
+        .feat_names = {
+            "perfmon-v2", NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+        },
+        .cpuid = { .eax = 0x80000022, .reg = R_EAX, },
+        .tcg_features = 0,
+        .unmigratable_flags = 0,
+    },
     [FEAT_XSAVE] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
@@ -7010,6 +7026,16 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *edx = 0;
         }
         break;
+    case 0x80000022:
+        *eax = *ebx = *ecx = *edx = 0;
+        /* AMD Extended Performance Monitoring and Debug */
+        if (kvm_enabled() && cpu->enable_pmu &&
+            (env->features[FEAT_8000_0022_EAX] & CPUID_8000_0022_EAX_PERFMON_V2)) {
+            *eax |= CPUID_8000_0022_EAX_PERFMON_V2;
+            *ebx |= kvm_arch_get_supported_cpuid(cs->kvm_state, index, count,
+                                                 R_EBX) & 0xf;
+        }
+        break;
     case 0xC0000000:
         *eax = env->cpuid_xlevel2;
         *ebx = 0;
-- 
2.47.0


