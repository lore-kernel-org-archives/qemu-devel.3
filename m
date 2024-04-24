Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F38CC07E8E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 08:15:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzXmW-0006vE-9C; Wed, 24 Apr 2024 04:15:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzXmU-0006ug-4a
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 04:15:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzXmR-0005tW-Bp
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 04:15:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713946501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mo19ec2q064ZBEOrB4aGznr7sSRtuPTam2u6yRXNuzw=;
 b=fHm0Rytj8K/marxi0wvGUzzGm6vMT7jt6cNvZ5HICvWx5rVWLZXhicupBDY+J+Z10wbKlx
 X0+mVrBfbivreHqzegSAtUeFb0tRzGiwjooaHOXhrrRns7S20ESaxyHQ2sVV0dO5wZQKDR
 uOk6eSQlXMJngrrgNP7yqsFEs9bpUJQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-KO-pTPuPO_iK0LnbGE4x2g-1; Wed, 24 Apr 2024 04:14:55 -0400
X-MC-Unique: KO-pTPuPO_iK0LnbGE4x2g-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a5199cc13b2so61971266b.0
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 01:14:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713946489; x=1714551289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mo19ec2q064ZBEOrB4aGznr7sSRtuPTam2u6yRXNuzw=;
 b=exa8OZPToiIjtjOtvdsPcs8srX7kjlJPhs32B26L6VtrVIlF5iQoSnBrlrms2gRKsp
 y90ecJUH6EYxbndGoxUqV68uS/lBsrrb2/S/l2E/IvdFfGOx5pmDIZk3dcLANNrwUeKS
 X4OlhTz8TziceCRUOfV7tpTOa0QFWatGrUnr3bC4n3vDsf0U8jkkFI9Tl6V9zzzjnovw
 cC44a423kNLmTFF0jTepQ7sJdmbU2NdkZj0UfrFof18gqY5hXdb05nFa9Ca+CrAPM6R4
 hnvzyhpyNESHkhRc5RdRANzwALHXMFVJT6fpKJXuE5/Kt5518hA6MY3CFFm3wfiivm3n
 J8Rw==
X-Gm-Message-State: AOJu0YxjhQ2Slj6qSh6wP7t/+Z0I08vg97K9+7PQxZ0vRIzCdvUbDfk4
 UC+wDgNbvqpYjdxwcrXoEnts2qSqUQXOBHeON8V1tiAzxXAffvF7oWi94fPv3MMQj2jjCso2JU2
 MC2nhLieG+2qu8alyU8tSpYbktX4LAxHtK4EXle4C/RQIP+sSFKbhmAIwM8B+eEOViaOwLE2G0f
 VywvJo9b07ddkbN0cH30ODiyYofg/aYTk1O3KG
X-Received: by 2002:a17:906:2497:b0:a52:a25:2077 with SMTP id
 e23-20020a170906249700b00a520a252077mr4813064ejb.14.1713946488907; 
 Wed, 24 Apr 2024 01:14:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE88PrqzG/IxPymkDe8WS7NF7FZKOvnSLD8xnWrPUm/JGgXEuCEyK76VuYIsrIPkhm6t+ZCdw==
X-Received: by 2002:a17:906:2497:b0:a52:a25:2077 with SMTP id
 e23-20020a170906249700b00a520a252077mr4813043ejb.14.1713946488394; 
 Wed, 24 Apr 2024 01:14:48 -0700 (PDT)
Received: from avogadro.local ([151.81.119.75])
 by smtp.gmail.com with ESMTPSA id
 e7-20020a170906c00700b00a51bf97e63esm7981219ejz.190.2024.04.24.01.14.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 01:14:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Sean Christopherson <sean.j.christopherson@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL v2 25/63] i386/kvm: Move architectural CPUID leaf generation to
 separate helper
Date: Wed, 24 Apr 2024 10:14:43 +0200
Message-ID: <20240424081443.75869-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424081443.75869-1-pbonzini@redhat.com>
References: <20240424081443.75869-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Sean Christopherson <sean.j.christopherson@intel.com>

Move the architectural (for lack of a better term) CPUID leaf generation
to a separate helper so that the generation code can be reused by TDX,
which needs to generate a canonical VM-scoped configuration.

For now this is just a cleanup, so keep the function static.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <20240229063726.610065-23-xiaoyao.li@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm.c | 449 +++++++++++++++++++++---------------------
 1 file changed, 227 insertions(+), 222 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index e68cbe92930..f1b59011d1e 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -1706,6 +1706,231 @@ static void kvm_init_nested_state(CPUX86State *env)
     }
 }
 
+static uint32_t kvm_x86_build_cpuid(CPUX86State *env,
+                                    struct kvm_cpuid_entry2 *entries,
+                                    uint32_t cpuid_i)
+{
+    uint32_t limit, i, j;
+    uint32_t unused;
+    struct kvm_cpuid_entry2 *c;
+
+    cpu_x86_cpuid(env, 0, 0, &limit, &unused, &unused, &unused);
+
+    for (i = 0; i <= limit; i++) {
+        j = 0;
+        if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
+            goto full;
+        }
+        c = &entries[cpuid_i++];
+        switch (i) {
+        case 2: {
+            /* Keep reading function 2 till all the input is received */
+            int times;
+
+            c->function = i;
+            c->flags = KVM_CPUID_FLAG_STATEFUL_FUNC |
+                       KVM_CPUID_FLAG_STATE_READ_NEXT;
+            cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->edx);
+            times = c->eax & 0xff;
+
+            for (j = 1; j < times; ++j) {
+                if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
+                    goto full;
+                }
+                c = &entries[cpuid_i++];
+                c->function = i;
+                c->flags = KVM_CPUID_FLAG_STATEFUL_FUNC;
+                cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->edx);
+            }
+            break;
+        }
+        case 0x1f:
+            if (env->nr_dies < 2) {
+                cpuid_i--;
+                break;
+            }
+            /* fallthrough */
+        case 4:
+        case 0xb:
+        case 0xd:
+            for (j = 0; ; j++) {
+                if (i == 0xd && j == 64) {
+                    break;
+                }
+
+                c->function = i;
+                c->flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
+                c->index = j;
+                cpu_x86_cpuid(env, i, j, &c->eax, &c->ebx, &c->ecx, &c->edx);
+
+                if (i == 4 && c->eax == 0) {
+                    break;
+                }
+                if (i == 0xb && !(c->ecx & 0xff00)) {
+                    break;
+                }
+                if (i == 0x1f && !(c->ecx & 0xff00)) {
+                    break;
+                }
+                if (i == 0xd && c->eax == 0) {
+                    continue;
+                }
+                if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
+                    goto full;
+                }
+                c = &entries[cpuid_i++];
+            }
+            break;
+        case 0x12:
+            for (j = 0; ; j++) {
+                c->function = i;
+                c->flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
+                c->index = j;
+                cpu_x86_cpuid(env, i, j, &c->eax, &c->ebx, &c->ecx, &c->edx);
+
+                if (j > 1 && (c->eax & 0xf) != 1) {
+                    break;
+                }
+
+                if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
+                    goto full;
+                }
+                c = &entries[cpuid_i++];
+            }
+            break;
+        case 0x7:
+        case 0x14:
+        case 0x1d:
+        case 0x1e: {
+            uint32_t times;
+
+            c->function = i;
+            c->index = 0;
+            c->flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
+            cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->edx);
+            times = c->eax;
+
+            for (j = 1; j <= times; ++j) {
+                if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
+                    goto full;
+                }
+                c = &entries[cpuid_i++];
+                c->function = i;
+                c->index = j;
+                c->flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
+                cpu_x86_cpuid(env, i, j, &c->eax, &c->ebx, &c->ecx, &c->edx);
+            }
+            break;
+        }
+        default:
+            c->function = i;
+            c->flags = 0;
+            cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->edx);
+            if (!c->eax && !c->ebx && !c->ecx && !c->edx) {
+                /*
+                 * KVM already returns all zeroes if a CPUID entry is missing,
+                 * so we can omit it and avoid hitting KVM's 80-entry limit.
+                 */
+                cpuid_i--;
+            }
+            break;
+        }
+    }
+
+    if (limit >= 0x0a) {
+        uint32_t eax, edx;
+
+        cpu_x86_cpuid(env, 0x0a, 0, &eax, &unused, &unused, &edx);
+
+        has_architectural_pmu_version = eax & 0xff;
+        if (has_architectural_pmu_version > 0) {
+            num_architectural_pmu_gp_counters = (eax & 0xff00) >> 8;
+
+            /* Shouldn't be more than 32, since that's the number of bits
+             * available in EBX to tell us _which_ counters are available.
+             * Play it safe.
+             */
+            if (num_architectural_pmu_gp_counters > MAX_GP_COUNTERS) {
+                num_architectural_pmu_gp_counters = MAX_GP_COUNTERS;
+            }
+
+            if (has_architectural_pmu_version > 1) {
+                num_architectural_pmu_fixed_counters = edx & 0x1f;
+
+                if (num_architectural_pmu_fixed_counters > MAX_FIXED_COUNTERS) {
+                    num_architectural_pmu_fixed_counters = MAX_FIXED_COUNTERS;
+                }
+            }
+        }
+    }
+
+    cpu_x86_cpuid(env, 0x80000000, 0, &limit, &unused, &unused, &unused);
+
+    for (i = 0x80000000; i <= limit; i++) {
+        j = 0;
+        if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
+            goto full;
+        }
+        c = &entries[cpuid_i++];
+
+        switch (i) {
+        case 0x8000001d:
+            /* Query for all AMD cache information leaves */
+            for (j = 0; ; j++) {
+                c->function = i;
+                c->flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
+                c->index = j;
+                cpu_x86_cpuid(env, i, j, &c->eax, &c->ebx, &c->ecx, &c->edx);
+
+                if (c->eax == 0) {
+                    break;
+                }
+                if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
+                    goto full;
+                }
+                c = &entries[cpuid_i++];
+            }
+            break;
+        default:
+            c->function = i;
+            c->flags = 0;
+            cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->edx);
+            if (!c->eax && !c->ebx && !c->ecx && !c->edx) {
+                /*
+                 * KVM already returns all zeroes if a CPUID entry is missing,
+                 * so we can omit it and avoid hitting KVM's 80-entry limit.
+                 */
+                cpuid_i--;
+            }
+            break;
+        }
+    }
+
+    /* Call Centaur's CPUID instructions they are supported. */
+    if (env->cpuid_xlevel2 > 0) {
+        cpu_x86_cpuid(env, 0xC0000000, 0, &limit, &unused, &unused, &unused);
+
+        for (i = 0xC0000000; i <= limit; i++) {
+            j = 0;
+            if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
+                goto full;
+            }
+            c = &entries[cpuid_i++];
+
+            c->function = i;
+            c->flags = 0;
+            cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->edx);
+        }
+    }
+
+    return cpuid_i;
+
+full:
+    fprintf(stderr, "cpuid_data is full, no space for "
+            "cpuid(eax:0x%x,ecx:0x%x)\n", i, j);
+    abort();
+}
+
 int kvm_arch_init_vcpu(CPUState *cs)
 {
     struct {
@@ -1722,8 +1947,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
 
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
-    uint32_t limit, i, j, cpuid_i;
-    uint32_t unused;
+    uint32_t cpuid_i;
     struct kvm_cpuid_entry2 *c;
     uint32_t signature[3];
     int kvm_base = KVM_CPUID_SIGNATURE;
@@ -1876,8 +2100,6 @@ int kvm_arch_init_vcpu(CPUState *cs)
         c->edx = env->features[FEAT_KVM_HINTS];
     }
 
-    cpu_x86_cpuid(env, 0, 0, &limit, &unused, &unused, &unused);
-
     if (cpu->kvm_pv_enforce_cpuid) {
         r = kvm_vcpu_enable_cap(cs, KVM_CAP_ENFORCE_PV_FEATURE_CPUID, 0, 1);
         if (r < 0) {
@@ -1888,224 +2110,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
         }
     }
 
-    for (i = 0; i <= limit; i++) {
-        if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
-            fprintf(stderr, "unsupported level value: 0x%x\n", limit);
-            abort();
-        }
-        c = &cpuid_data.entries[cpuid_i++];
-
-        switch (i) {
-        case 2: {
-            /* Keep reading function 2 till all the input is received */
-            int times;
-
-            c->function = i;
-            c->flags = KVM_CPUID_FLAG_STATEFUL_FUNC |
-                       KVM_CPUID_FLAG_STATE_READ_NEXT;
-            cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->edx);
-            times = c->eax & 0xff;
-
-            for (j = 1; j < times; ++j) {
-                if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
-                    fprintf(stderr, "cpuid_data is full, no space for "
-                            "cpuid(eax:2):eax & 0xf = 0x%x\n", times);
-                    abort();
-                }
-                c = &cpuid_data.entries[cpuid_i++];
-                c->function = i;
-                c->flags = KVM_CPUID_FLAG_STATEFUL_FUNC;
-                cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->edx);
-            }
-            break;
-        }
-        case 0x1f:
-            if (env->nr_dies < 2) {
-                cpuid_i--;
-                break;
-            }
-            /* fallthrough */
-        case 4:
-        case 0xb:
-        case 0xd:
-            for (j = 0; ; j++) {
-                if (i == 0xd && j == 64) {
-                    break;
-                }
-
-                c->function = i;
-                c->flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
-                c->index = j;
-                cpu_x86_cpuid(env, i, j, &c->eax, &c->ebx, &c->ecx, &c->edx);
-
-                if (i == 4 && c->eax == 0) {
-                    break;
-                }
-                if (i == 0xb && !(c->ecx & 0xff00)) {
-                    break;
-                }
-                if (i == 0x1f && !(c->ecx & 0xff00)) {
-                    break;
-                }
-                if (i == 0xd && c->eax == 0) {
-                    continue;
-                }
-                if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
-                    fprintf(stderr, "cpuid_data is full, no space for "
-                            "cpuid(eax:0x%x,ecx:0x%x)\n", i, j);
-                    abort();
-                }
-                c = &cpuid_data.entries[cpuid_i++];
-            }
-            break;
-        case 0x12:
-            for (j = 0; ; j++) {
-                c->function = i;
-                c->flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
-                c->index = j;
-                cpu_x86_cpuid(env, i, j, &c->eax, &c->ebx, &c->ecx, &c->edx);
-
-                if (j > 1 && (c->eax & 0xf) != 1) {
-                    break;
-                }
-
-                if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
-                    fprintf(stderr, "cpuid_data is full, no space for "
-                                "cpuid(eax:0x12,ecx:0x%x)\n", j);
-                    abort();
-                }
-                c = &cpuid_data.entries[cpuid_i++];
-            }
-            break;
-        case 0x7:
-        case 0x14:
-        case 0x1d:
-        case 0x1e: {
-            uint32_t times;
-
-            c->function = i;
-            c->index = 0;
-            c->flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
-            cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->edx);
-            times = c->eax;
-
-            for (j = 1; j <= times; ++j) {
-                if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
-                    fprintf(stderr, "cpuid_data is full, no space for "
-                                "cpuid(eax:0x%x,ecx:0x%x)\n", i, j);
-                    abort();
-                }
-                c = &cpuid_data.entries[cpuid_i++];
-                c->function = i;
-                c->index = j;
-                c->flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
-                cpu_x86_cpuid(env, i, j, &c->eax, &c->ebx, &c->ecx, &c->edx);
-            }
-            break;
-        }
-        default:
-            c->function = i;
-            c->flags = 0;
-            cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->edx);
-            if (!c->eax && !c->ebx && !c->ecx && !c->edx) {
-                /*
-                 * KVM already returns all zeroes if a CPUID entry is missing,
-                 * so we can omit it and avoid hitting KVM's 80-entry limit.
-                 */
-                cpuid_i--;
-            }
-            break;
-        }
-    }
-
-    if (limit >= 0x0a) {
-        uint32_t eax, edx;
-
-        cpu_x86_cpuid(env, 0x0a, 0, &eax, &unused, &unused, &edx);
-
-        has_architectural_pmu_version = eax & 0xff;
-        if (has_architectural_pmu_version > 0) {
-            num_architectural_pmu_gp_counters = (eax & 0xff00) >> 8;
-
-            /* Shouldn't be more than 32, since that's the number of bits
-             * available in EBX to tell us _which_ counters are available.
-             * Play it safe.
-             */
-            if (num_architectural_pmu_gp_counters > MAX_GP_COUNTERS) {
-                num_architectural_pmu_gp_counters = MAX_GP_COUNTERS;
-            }
-
-            if (has_architectural_pmu_version > 1) {
-                num_architectural_pmu_fixed_counters = edx & 0x1f;
-
-                if (num_architectural_pmu_fixed_counters > MAX_FIXED_COUNTERS) {
-                    num_architectural_pmu_fixed_counters = MAX_FIXED_COUNTERS;
-                }
-            }
-        }
-    }
-
-    cpu_x86_cpuid(env, 0x80000000, 0, &limit, &unused, &unused, &unused);
-
-    for (i = 0x80000000; i <= limit; i++) {
-        if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
-            fprintf(stderr, "unsupported xlevel value: 0x%x\n", limit);
-            abort();
-        }
-        c = &cpuid_data.entries[cpuid_i++];
-
-        switch (i) {
-        case 0x8000001d:
-            /* Query for all AMD cache information leaves */
-            for (j = 0; ; j++) {
-                c->function = i;
-                c->flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
-                c->index = j;
-                cpu_x86_cpuid(env, i, j, &c->eax, &c->ebx, &c->ecx, &c->edx);
-
-                if (c->eax == 0) {
-                    break;
-                }
-                if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
-                    fprintf(stderr, "cpuid_data is full, no space for "
-                            "cpuid(eax:0x%x,ecx:0x%x)\n", i, j);
-                    abort();
-                }
-                c = &cpuid_data.entries[cpuid_i++];
-            }
-            break;
-        default:
-            c->function = i;
-            c->flags = 0;
-            cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->edx);
-            if (!c->eax && !c->ebx && !c->ecx && !c->edx) {
-                /*
-                 * KVM already returns all zeroes if a CPUID entry is missing,
-                 * so we can omit it and avoid hitting KVM's 80-entry limit.
-                 */
-                cpuid_i--;
-            }
-            break;
-        }
-    }
-
-    /* Call Centaur's CPUID instructions they are supported. */
-    if (env->cpuid_xlevel2 > 0) {
-        cpu_x86_cpuid(env, 0xC0000000, 0, &limit, &unused, &unused, &unused);
-
-        for (i = 0xC0000000; i <= limit; i++) {
-            if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
-                fprintf(stderr, "unsupported xlevel2 value: 0x%x\n", limit);
-                abort();
-            }
-            c = &cpuid_data.entries[cpuid_i++];
-
-            c->function = i;
-            c->flags = 0;
-            cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->edx);
-        }
-    }
-
+    cpuid_i = kvm_x86_build_cpuid(env, cpuid_data.entries, cpuid_i);
     cpuid_data.cpuid.nent = cpuid_i;
 
     if (((env->cpuid_version >> 8)&0xF) >= 6
-- 
2.44.0


