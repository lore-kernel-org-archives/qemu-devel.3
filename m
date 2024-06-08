Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B16DBC25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 08:38:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFrYO-0003Jb-N5; Sat, 08 Jun 2024 04:36:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrYL-000367-8j
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:35:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrYI-0000JQ-DA
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:35:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717835753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jKfBGH3wmrp1aUEk4x0YxyqjA7pI80vSZzG/Q9Zj3to=;
 b=UyFvUKwaLgq+qZikRvCQXf/IB9TXwoLHCqM2Kxf0xWL/K7KcSWn8vUMaDuV18QRrgoeDk0
 xnXlEydBVa64wYWAx5WZ6CVbSaHvG6dGEp8hWLd5Nl0FKj+ZaVhs7CMR5mlDZusYHFCLQ5
 Cv50WUeMKDoWuZ2Ae86i0NLKGHrkHR8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-FtUCOwslPkiWqLyTnd6BVQ-1; Sat, 08 Jun 2024 04:35:52 -0400
X-MC-Unique: FtUCOwslPkiWqLyTnd6BVQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a6c70438d0cso88927066b.1
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 01:35:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717835750; x=1718440550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jKfBGH3wmrp1aUEk4x0YxyqjA7pI80vSZzG/Q9Zj3to=;
 b=fjM/CJoAV3DYVDhY1BkTDdUS2FjaFTuAhPIh4MdpcSHgAVbhq7pru16Kytpr5haSyb
 nyPCLn1ezESGlJYvFu9vx4JBpLNaY6gzWU7+F38qBaJzzJAZtGfxe02jXZzjpYPVr67P
 AOZOjDZgUPx7AXM8ESwghddHKvStkhZQlP9vOuLYtA7IxzN8YvE7lyuhgje+si7Br3vi
 vFECQamNUI0w+n1I/KKjlPbcUXi7CU2ZrwtWOHH1+cyza58IOrnbqgJsGp1AKoTaGkxs
 Kj3pp39w9YWKosjTqi6P0zg7QC4c4jOkoGlaL35T+MGhMsjhOcIqY5jteFVj4PhSdWJX
 Od/g==
X-Gm-Message-State: AOJu0YwuknLL2xkVyDLytrRkpPTcoAaBPTf5MJmDsYUvm6ZMb1m0PvBy
 CQZYKoTv5SpYCQewbW/kV4A/+KH3XheMnZ+QVTSDOqvB7/jOPKy8cXHwmZ4MRtK/YgQvQOle6wW
 EpK996W+fU/7Zdc+jiwrtWlR7YlhyEgTA3k3nAtXTrFnvfc1xAZdLicrNsbs723ADJ6ejXtrcyp
 alL+BjnoCMeQZbPZ6z/Pk95HnQrgVODueS0nm7
X-Received: by 2002:a50:d7ca:0:b0:578:638e:3683 with SMTP id
 4fb4d7f45d1cf-57c50861ae8mr3501893a12.5.1717835749902; 
 Sat, 08 Jun 2024 01:35:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPpSNUH26R94kqjS+wvfDmQp9cEaWERwcVZXYjWFo6KM/3jUtYtIrJMoXWjkZE42ecv9wNMg==
X-Received: by 2002:a50:d7ca:0:b0:578:638e:3683 with SMTP id
 4fb4d7f45d1cf-57c50861ae8mr3501878a12.5.1717835749476; 
 Sat, 08 Jun 2024 01:35:49 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57aae2366a4sm3915477a12.92.2024.06.08.01.35.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 01:35:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xin Li <xin3.li@intel.com>,
	Shan Kang <shan.kang@intel.com>
Subject: [PULL 36/42] target/i386: Add get/set/migrate support for FRED MSRs
Date: Sat,  8 Jun 2024 10:34:09 +0200
Message-ID: <20240608083415.2769160-37-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240608083415.2769160-1-pbonzini@redhat.com>
References: <20240608083415.2769160-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

From: Xin Li <xin3.li@intel.com>

FRED CPU states are managed in 9 new FRED MSRs, in addtion to a few
existing CPU registers and MSRs, e.g., CR4.FRED and MSR_IA32_PL0_SSP.

Save/restore/migrate FRED MSRs if FRED is exposed to the guest.

Tested-by: Shan Kang <shan.kang@intel.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
Message-ID: <20231109072012.8078-7-xin3.li@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h     | 22 +++++++++++++++++++
 target/i386/kvm/kvm.c | 49 +++++++++++++++++++++++++++++++++++++++++++
 target/i386/machine.c | 28 +++++++++++++++++++++++++
 3 files changed, 99 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 8ff27e933de..29d799adfd6 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -538,6 +538,17 @@ typedef enum X86Seg {
 #define MSR_IA32_XFD                    0x000001c4
 #define MSR_IA32_XFD_ERR                0x000001c5
 
+/* FRED MSRs */
+#define MSR_IA32_FRED_RSP0              0x000001cc       /* Stack level 0 regular stack pointer */
+#define MSR_IA32_FRED_RSP1              0x000001cd       /* Stack level 1 regular stack pointer */
+#define MSR_IA32_FRED_RSP2              0x000001ce       /* Stack level 2 regular stack pointer */
+#define MSR_IA32_FRED_RSP3              0x000001cf       /* Stack level 3 regular stack pointer */
+#define MSR_IA32_FRED_STKLVLS           0x000001d0       /* FRED exception stack levels */
+#define MSR_IA32_FRED_SSP1              0x000001d1       /* Stack level 1 shadow stack pointer in ring 0 */
+#define MSR_IA32_FRED_SSP2              0x000001d2       /* Stack level 2 shadow stack pointer in ring 0 */
+#define MSR_IA32_FRED_SSP3              0x000001d3       /* Stack level 3 shadow stack pointer in ring 0 */
+#define MSR_IA32_FRED_CONFIG            0x000001d4       /* FRED Entrypoint and interrupt stack level */
+
 #define MSR_IA32_BNDCFGS                0x00000d90
 #define MSR_IA32_XSS                    0x00000da0
 #define MSR_IA32_UMWAIT_CONTROL         0xe1
@@ -1723,6 +1734,17 @@ typedef struct CPUArchState {
     target_ulong cstar;
     target_ulong fmask;
     target_ulong kernelgsbase;
+
+    /* FRED MSRs */
+    uint64_t fred_rsp0;
+    uint64_t fred_rsp1;
+    uint64_t fred_rsp2;
+    uint64_t fred_rsp3;
+    uint64_t fred_stklvls;
+    uint64_t fred_ssp1;
+    uint64_t fred_ssp2;
+    uint64_t fred_ssp3;
+    uint64_t fred_config;
 #endif
 
     uint64_t tsc_adjust;
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 0852ed077f0..b5635209812 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -3376,6 +3376,17 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
         kvm_msr_entry_add(cpu, MSR_KERNELGSBASE, env->kernelgsbase);
         kvm_msr_entry_add(cpu, MSR_FMASK, env->fmask);
         kvm_msr_entry_add(cpu, MSR_LSTAR, env->lstar);
+        if (env->features[FEAT_7_1_EAX] & CPUID_7_1_EAX_FRED) {
+            kvm_msr_entry_add(cpu, MSR_IA32_FRED_RSP0, env->fred_rsp0);
+            kvm_msr_entry_add(cpu, MSR_IA32_FRED_RSP1, env->fred_rsp1);
+            kvm_msr_entry_add(cpu, MSR_IA32_FRED_RSP2, env->fred_rsp2);
+            kvm_msr_entry_add(cpu, MSR_IA32_FRED_RSP3, env->fred_rsp3);
+            kvm_msr_entry_add(cpu, MSR_IA32_FRED_STKLVLS, env->fred_stklvls);
+            kvm_msr_entry_add(cpu, MSR_IA32_FRED_SSP1, env->fred_ssp1);
+            kvm_msr_entry_add(cpu, MSR_IA32_FRED_SSP2, env->fred_ssp2);
+            kvm_msr_entry_add(cpu, MSR_IA32_FRED_SSP3, env->fred_ssp3);
+            kvm_msr_entry_add(cpu, MSR_IA32_FRED_CONFIG, env->fred_config);
+        }
     }
 #endif
 
@@ -3848,6 +3859,17 @@ static int kvm_get_msrs(X86CPU *cpu)
         kvm_msr_entry_add(cpu, MSR_KERNELGSBASE, 0);
         kvm_msr_entry_add(cpu, MSR_FMASK, 0);
         kvm_msr_entry_add(cpu, MSR_LSTAR, 0);
+        if (env->features[FEAT_7_1_EAX] & CPUID_7_1_EAX_FRED) {
+            kvm_msr_entry_add(cpu, MSR_IA32_FRED_RSP0, 0);
+            kvm_msr_entry_add(cpu, MSR_IA32_FRED_RSP1, 0);
+            kvm_msr_entry_add(cpu, MSR_IA32_FRED_RSP2, 0);
+            kvm_msr_entry_add(cpu, MSR_IA32_FRED_RSP3, 0);
+            kvm_msr_entry_add(cpu, MSR_IA32_FRED_STKLVLS, 0);
+            kvm_msr_entry_add(cpu, MSR_IA32_FRED_SSP1, 0);
+            kvm_msr_entry_add(cpu, MSR_IA32_FRED_SSP2, 0);
+            kvm_msr_entry_add(cpu, MSR_IA32_FRED_SSP3, 0);
+            kvm_msr_entry_add(cpu, MSR_IA32_FRED_CONFIG, 0);
+        }
     }
 #endif
     kvm_msr_entry_add(cpu, MSR_KVM_SYSTEM_TIME, 0);
@@ -4069,6 +4091,33 @@ static int kvm_get_msrs(X86CPU *cpu)
         case MSR_LSTAR:
             env->lstar = msrs[i].data;
             break;
+        case MSR_IA32_FRED_RSP0:
+            env->fred_rsp0 = msrs[i].data;
+            break;
+        case MSR_IA32_FRED_RSP1:
+            env->fred_rsp1 = msrs[i].data;
+            break;
+        case MSR_IA32_FRED_RSP2:
+            env->fred_rsp2 = msrs[i].data;
+            break;
+        case MSR_IA32_FRED_RSP3:
+            env->fred_rsp3 = msrs[i].data;
+            break;
+        case MSR_IA32_FRED_STKLVLS:
+            env->fred_stklvls = msrs[i].data;
+            break;
+        case MSR_IA32_FRED_SSP1:
+            env->fred_ssp1 = msrs[i].data;
+            break;
+        case MSR_IA32_FRED_SSP2:
+            env->fred_ssp2 = msrs[i].data;
+            break;
+        case MSR_IA32_FRED_SSP3:
+            env->fred_ssp3 = msrs[i].data;
+            break;
+        case MSR_IA32_FRED_CONFIG:
+            env->fred_config = msrs[i].data;
+            break;
 #endif
         case MSR_IA32_TSC:
             env->tsc = msrs[i].data;
diff --git a/target/i386/machine.c b/target/i386/machine.c
index c3ae3208147..39f8294f279 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -1544,6 +1544,33 @@ static const VMStateDescription vmstate_msr_xfd = {
 };
 
 #ifdef TARGET_X86_64
+static bool intel_fred_msrs_needed(void *opaque)
+{
+    X86CPU *cpu = opaque;
+    CPUX86State *env = &cpu->env;
+
+    return !!(env->features[FEAT_7_1_EAX] & CPUID_7_1_EAX_FRED);
+}
+
+static const VMStateDescription vmstate_msr_fred = {
+    .name = "cpu/fred",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = intel_fred_msrs_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(env.fred_rsp0, X86CPU),
+        VMSTATE_UINT64(env.fred_rsp1, X86CPU),
+        VMSTATE_UINT64(env.fred_rsp2, X86CPU),
+        VMSTATE_UINT64(env.fred_rsp3, X86CPU),
+        VMSTATE_UINT64(env.fred_stklvls, X86CPU),
+        VMSTATE_UINT64(env.fred_ssp1, X86CPU),
+        VMSTATE_UINT64(env.fred_ssp2, X86CPU),
+        VMSTATE_UINT64(env.fred_ssp3, X86CPU),
+        VMSTATE_UINT64(env.fred_config, X86CPU),
+        VMSTATE_END_OF_LIST()
+            }
+        };
+
 static bool amx_xtile_needed(void *opaque)
 {
     X86CPU *cpu = opaque;
@@ -1747,6 +1774,7 @@ const VMStateDescription vmstate_x86_cpu = {
         &vmstate_pdptrs,
         &vmstate_msr_xfd,
 #ifdef TARGET_X86_64
+        &vmstate_msr_fred,
         &vmstate_amx_xtile,
 #endif
         &vmstate_arch_lbr,
-- 
2.45.1


