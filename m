Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E61C27C55
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 08:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFrXy-000168-87; Sat, 08 Jun 2024 04:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrXw-0000zx-Gr
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:35:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrXu-0000Co-1i
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:35:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717835729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rZe7m0sNl8cnSTMcFIO8cbNkZImcjv4/nnfXwPS5Fc8=;
 b=F+LouFVw9MyWWzRemwkLGQTiqnb2s52+Un5HHZAvV2wCEX87nmBD4Ii9czCV2GQoIFiwye
 bjvMXQQ49MlqJ6UEDWgp0S/rNpC5deFksNEU6zP4xX5t3yuCKb01DcGIMbn9VX7OrMduiZ
 mnIN64buPaaDKdAKFQAt1kg443g+BsA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-UCtxJmbDPKq8WIxtHSS67w-1; Sat, 08 Jun 2024 04:35:26 -0400
X-MC-Unique: UCtxJmbDPKq8WIxtHSS67w-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a6ef729b8a7so44967966b.1
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 01:35:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717835725; x=1718440525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rZe7m0sNl8cnSTMcFIO8cbNkZImcjv4/nnfXwPS5Fc8=;
 b=FzqcT5r4hMgSkqAU8VuxGACX1j9P1rlHD3XFilcm1u32UiY7FCdGK7tFwrEZIrb7s+
 thJULM1ZZtzbOJkGj1goPSurIt7a1vxwwq+46tmNLpF3uqg8W+u2rrsKSMqQFFFQliRq
 AkhjZRtbXuuqQPbdZ1sABacW+h2sfgLZ0DTnTqngwK8EjNevmZ8OHZQxKRIc0jMx9FBe
 k1/1OJLSMNi99HVLROMQcD1TYIQBA8FnNWkhqQzwOhwLhOW0ULFAabYl8iEGM2p8wPoc
 pVeJuOQMJOhwcHsWrnNW9OfkP/3/vT7tcWYa7La7cf3aCLZp4pFFuV+fvDU/tfcqy7Wj
 rouw==
X-Gm-Message-State: AOJu0Yx5uiGbGrH3jap+q5x5GL2OE7Mg0iVQyORV6DNJAh4auYu7PeTF
 GO/PJqg7X5fHtz/F1Li7TAoXDnfUHNQJXONIus9W6zZAMqBzcmy4liAY8c9IO8G2P6+Rf5gOWRV
 MT9zVrMXjHPRP24s1yBrn5pX6Do83FD/Wokev9M+hqfOsYshz70DE3b4HEeapwels9ijAYVba2I
 YrNDQmA0H9ze23Jsd2lm/aVIcRrY/AS3W97/jJ
X-Received: by 2002:a50:8d01:0:b0:57c:61a3:54c with SMTP id
 4fb4d7f45d1cf-57c61a30661mr1605705a12.0.1717835725120; 
 Sat, 08 Jun 2024 01:35:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2ZuUZX650Pn7jZKBJkQKcfPQ3FPeDPLEc7r9MB9xc2eYJkLVqjR9uplLvNwr8xAiMv9FfWg==
X-Received: by 2002:a50:8d01:0:b0:57c:61a3:54c with SMTP id
 4fb4d7f45d1cf-57c61a30661mr1605684a12.0.1717835724650; 
 Sat, 08 Jun 2024 01:35:24 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57aae201a79sm3949782a12.59.2024.06.08.01.35.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 01:35:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <roman@roolebo.dev>
Subject: [PULL 25/42] i386/hvf: Adds support for INVTSC cpuid bit
Date: Sat,  8 Jun 2024 10:33:58 +0200
Message-ID: <20240608083415.2769160-26-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240608083415.2769160-1-pbonzini@redhat.com>
References: <20240608083415.2769160-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Phil Dennis-Jordan <phil@philjordan.eu>

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
Message-ID: <20240605112556.43193-2-phil@philjordan.eu>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/hvf.c       | 18 ++++++++++++++++++
 target/i386/hvf/x86_cpuid.c |  4 ++++
 2 files changed, 22 insertions(+)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index e493452acb9..e6e916225bf 100644
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
index 9380b90496e..e56cd8411ba 100644
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
2.45.1


