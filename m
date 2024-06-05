Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E05AC25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 11:28:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEomu-0005SN-Nh; Wed, 05 Jun 2024 07:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sEomj-0005NF-9i
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 07:26:34 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sEomg-00037I-QK
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 07:26:28 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a68a288b8a4so247084766b.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 04:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1717586784; x=1718191584;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vyDhWiLePoGq4AfWFWJeqV8roAH5mNHGKlDLBH2osgY=;
 b=3Z8CET9pUBOUap+aFB/mH5TFdsssBWbKJ4suoAF9GulYBzyena9QPUYq+Fwv005h/8
 LJW5uzRI/gmkkLTpZddK1F94/Ex1cggVgQ6sqjhhjH27+pNLLOlGDy9dat96UupXfHqM
 VEc15Hw9f0xUpy2SVOxLWWbdPyB2hslU8Vc54uTOaMfuUCf4DEp5VF+bBBqywOXTlQ+H
 3UAtzVV6LVzEc57Jfif4at2E8HcqDTIfCUCmVgflS2wUlIo8H3zSBNa19mztvRpwmobk
 /wqLthEjhWL+oYvsqcDfL3t7Rq7oz5rLpjA+YiRB8wnKQET3qOecLycOeW6fObkW+v+T
 1Utg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717586784; x=1718191584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vyDhWiLePoGq4AfWFWJeqV8roAH5mNHGKlDLBH2osgY=;
 b=auT4ycXgZVnq8N0rk9O2vM3ISgRaU6wR2ENyG4y/2ftkp1GgB0oFIV8cbIR0jvM8lk
 lwXCumhr7pDSd/AjR+NkU3mR6PphZnS3Le0wdUqRwCMoVx3VVMuScb6nN0hK79Mosecc
 Xqk5BqlSTTrPNVWGfaJe2vgjpDpU5B+63tbbzdfkgDf0/ymZNoLDuPtxtABsXO+g8mN7
 AOG85XmDN3VpovjEWcOHrTVygLsv8H/tWVGzSNE9NJFsRLecCNu77+A95kYcDzq5YacV
 3Cdb4UosFllSbtd2XKpRFAYt8hOF57nzKgS54YdHjj40eCsjy/6TZI0BGqdlKOwSjFSA
 4jWw==
X-Gm-Message-State: AOJu0Yxyxy4epsW+PINRnsLklqjBKykaEaYKUA3DVnKn16nxqQM4oE/6
 vrVofusxgU1N6wlCboK/QwfMTEYTjRx8iCzkJZRRyTLtwvoHuDNZufo614IQ0nbxXIrAhV4ecUU
 =
X-Google-Smtp-Source: AGHT+IHXCCwvT2GAm9AVbE8F50YCR9Oy5xtPzt827/YfYl8DFe+hwOsbaiDvVfWSPaEBykjKyJfj+w==
X-Received: by 2002:a50:cac7:0:b0:57a:7490:a872 with SMTP id
 4fb4d7f45d1cf-57a8b6a9f9fmr1953528a12.10.1717586783841; 
 Wed, 05 Jun 2024 04:26:23 -0700 (PDT)
Received: from localhost.localdomain (89-104-8-249.customer.bnet.at.
 [89.104.8.249]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57a51023af4sm7111335a12.29.2024.06.05.04.26.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 04:26:23 -0700 (PDT)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: dirty@apple.com, rbolshakov@ddn.com, lists@philjordan.eu,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <roman@roolebo.dev>
Subject: [PATCH v3 1/7] i386/hvf: Adds support for INVTSC cpuid bit
Date: Wed,  5 Jun 2024 13:25:50 +0200
Message-Id: <20240605112556.43193-2-phil@philjordan.eu>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20240605112556.43193-1-phil@philjordan.eu>
References: <20240605112556.43193-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::632;
 envelope-from=phil@philjordan.eu; helo=mail-ej1-x632.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

This patch adds the INVTSC bit to the Hypervisor.framework accelerator's
CPUID bit passthrough allow-list. Previously, specifying +invtsc in the CPU
configuration would fail with the following warning despite the host CPU
advertising the feature:

qemu-system-x86_64: warning: host doesn't support requested feature:
CPUID.80000007H:EDX.invtsc [bit 8]

x86 macOS itself relies on a fixed rate TSC for its own Mach absolute time
timestamp mechanism, so there's no reason we can't enable this bit for guests.
When the feature is enabled, a migration blocker is installed.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
Reviewed-by: Roman Bolshakov <roman@roolebo.dev>
Tested-by: Roman Bolshakov <roman@roolebo.dev>
---
 target/i386/hvf/hvf.c       | 18 ++++++++++++++++++
 target/i386/hvf/x86_cpuid.c |  4 ++++
 2 files changed, 22 insertions(+)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index e493452acb..e6e916225b 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -49,6 +49,8 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qemu/memalign.h"
+#include "qapi/error.h"
+#include "migration/blocker.h"
 
 #include "sysemu/hvf.h"
 #include "sysemu/hvf_int.h"
@@ -74,6 +76,8 @@
 #include "qemu/accel.h"
 #include "target/i386/cpu.h"
 
+static Error *invtsc_mig_blocker;
+
 void vmx_update_tpr(CPUState *cpu)
 {
     /* TODO: need integrate APIC handling */
@@ -221,6 +225,8 @@ int hvf_arch_init_vcpu(CPUState *cpu)
 {
     X86CPU *x86cpu = X86_CPU(cpu);
     CPUX86State *env = &x86cpu->env;
+    Error *local_err = NULL;
+    int r;
     uint64_t reqCap;
 
     init_emu();
@@ -238,6 +244,18 @@ int hvf_arch_init_vcpu(CPUState *cpu)
         }
     }
 
+    if ((env->features[FEAT_8000_0007_EDX] & CPUID_APM_INVTSC) &&
+        invtsc_mig_blocker == NULL) {
+        error_setg(&invtsc_mig_blocker,
+                   "State blocked by non-migratable CPU device (invtsc flag)");
+        r = migrate_add_blocker(&invtsc_mig_blocker, &local_err);
+        if (r < 0) {
+            error_report_err(local_err);
+            return r;
+        }
+    }
+
+
     if (hv_vmx_read_capability(HV_VMX_CAP_PINBASED,
         &hvf_state->hvf_caps->vmx_cap_pinbased)) {
         abort();
diff --git a/target/i386/hvf/x86_cpuid.c b/target/i386/hvf/x86_cpuid.c
index 9380b90496..e56cd8411b 100644
--- a/target/i386/hvf/x86_cpuid.c
+++ b/target/i386/hvf/x86_cpuid.c
@@ -146,6 +146,10 @@ uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t idx,
                 CPUID_EXT3_3DNOWPREFETCH | CPUID_EXT3_OSVW | CPUID_EXT3_XOP |
                 CPUID_EXT3_FMA4 | CPUID_EXT3_TBM;
         break;
+    case 0x80000007:
+        edx &= CPUID_APM_INVTSC;
+        eax = ebx = ecx = 0;
+        break;
     default:
         return 0;
     }
-- 
2.36.1


