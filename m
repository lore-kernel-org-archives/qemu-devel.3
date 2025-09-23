Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52499CAC5AC
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 02:23:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0sfR-0006vA-8Z; Mon, 22 Sep 2025 22:22:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1v0sfO-0006u0-GC
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 22:22:06 -0400
Received: from mx1.zhaoxin.com ([210.0.225.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1v0sfG-0001Nd-AP
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 22:22:06 -0400
X-ASG-Debug-ID: 1758594100-086e236d0e00350003-jgbH7p
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by
 mx1.zhaoxin.com with ESMTP id 1u5Ka2mXseYtRjpN (version=TLSv1.2
 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Tue, 23 Sep 2025 10:21:41 +0800 (CST)
X-Barracuda-Envelope-From: EwanHai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXSHMBX3.zhaoxin.com (10.28.252.165) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Tue, 23 Sep
 2025 10:21:41 +0800
Received: from ZXSHMBX3.zhaoxin.com ([fe80::a428:faf0:c549:abe6]) by
 ZXSHMBX3.zhaoxin.com ([fe80::a428:faf0:c549:abe6%6]) with mapi id
 15.01.2507.044; Tue, 23 Sep 2025 10:21:41 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ewan-server.lan (10.28.24.128) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Tue, 23 Sep
 2025 10:11:34 +0800
From: Ewan Hai <ewanhai-oc@zhaoxin.com>
To: <pbonzini@redhat.com>, <zhao1.liu@intel.com>
CC: <qemu-devel@nongnu.org>
Subject: [PATCH 2/3] target/i386: Introduce Zhaoxin Shijidadao-Client CPU model
Date: Mon, 22 Sep 2025 22:11:32 -0400
X-ASG-Orig-Subj: [PATCH 2/3] target/i386: Introduce Zhaoxin Shijidadao-Client
 CPU model
Message-ID: <20250923021133.190725-3-ewanhai-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250923021133.190725-1-ewanhai-oc@zhaoxin.com>
References: <20250923021133.190725-1-ewanhai-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [10.28.24.128]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Moderation-Data: 9/23/2025 10:21:39 AM
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1758594101
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 8752
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -1.53
X-Barracuda-Spam-Status: No,
 SCORE=-1.53 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=UPPERCASE_50_75,
 UPPERCASE_50_75_2
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.147541
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
 0.00 UPPERCASE_50_75        message body is 50-75% uppercase
 0.49 UPPERCASE_50_75_2      message body is 50-75% uppercase
Received-SPF: pass client-ip=210.0.225.12; envelope-from=EwanHai-oc@zhaoxin.com;
 helo=mx1.zhaoxin.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

Zhaoxin "Shijidadao-Client" hardware has two revisions:

* v1 supports SMAP but lacks XSAVEC, XGETBV1, XSAVES, and VMX-XSAVES
* v2 provides XSAVEC/XGETBV1/XSAVES/VMX-XSAVES but does not support SMAP

Since QEMU CPU models default to '.version =3D 1', this patch keeps the sam=
e
definition for v1 and adds the "x-force-cpuid-0x1f" property, while
introducing 'version=3D2' to reflect the differences in v2. This allows bot=
h
hardware revisions to be covered by a single CPU model while preserving
the existing versioning logic.

Signed-off-by: Ewan Hai <ewanhai-oc@zhaoxin.com>
---
 target/i386/cpu.c | 147 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 147 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 679f9d3970..d17284e300 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6747,6 +6747,153 @@ static const X86CPUDefinition builtin_x86_defs[] =
=3D {
         .model_id =3D "AMD EPYC-Turin Processor",
         .cache_info =3D &epyc_turin_cache_info,
     },
+    {
+        .name =3D "Shijidadao-Client",
+        .level =3D 0x1f,
+        .vendor =3D CPUID_VENDOR_ZHAOXIN1,
+        .family =3D 7,
+        .model =3D 0x6b,
+        .stepping =3D 1,
+        /* missing: CPUID_HT, CPUID_TM, CPUID_PBE */
+        .features[FEAT_1_EDX] =3D
+            CPUID_SS | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX |
+            CPUID_ACPI | CPUID_CLFLUSH | CPUID_PSE36 | CPUID_PAT | CPUID_C=
MOV |
+            CPUID_MCA | CPUID_PGE | CPUID_MTRR | CPUID_SEP | CPUID_APIC |
+            CPUID_CX8 | CPUID_MCE | CPUID_PAE | CPUID_MSR | CPUID_TSC |
+            CPUID_PSE | CPUID_DE | CPUID_VME | CPUID_FP87,
+        /*
+         * missing: CPUID_EXT_OSXSAVE, CPUID_EXT_XTPR, CPUID_EXT_TM2,
+         * CPUID_EXT_EST, CPUID_EXT_SMX, CPUID_EXT_VMX
+         */
+        .features[FEAT_1_ECX] =3D
+            CPUID_EXT_RDRAND | CPUID_EXT_F16C | CPUID_EXT_AVX |
+            CPUID_EXT_XSAVE | CPUID_EXT_AES | CPUID_EXT_TSC_DEADLINE_TIMER=
 |
+            CPUID_EXT_POPCNT | CPUID_EXT_MOVBE | CPUID_EXT_X2APIC |
+            CPUID_EXT_SSE42 | CPUID_EXT_SSE41 | CPUID_EXT_PCID |
+            CPUID_EXT_CX16 | CPUID_EXT_FMA | CPUID_EXT_SSSE3 |
+            CPUID_EXT_MONITOR | CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSE3,
+        .features[FEAT_7_0_EBX] =3D
+            CPUID_7_0_EBX_SHA_NI | CPUID_7_0_EBX_ADX | CPUID_7_0_EBX_RDSEE=
D |
+            CPUID_7_0_EBX_INVPCID | CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_SME=
P |
+            CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_BMI1 | CPUID_7_0_EBX_FSGSBA=
SE,
+        /* missing: CPUID_7_0_ECX_OSPKE */
+        .features[FEAT_7_0_ECX] =3D
+            CPUID_7_0_ECX_RDPID | CPUID_7_0_ECX_PKU | CPUID_7_0_ECX_UMIP,
+        .features[FEAT_7_0_EDX] =3D
+            CPUID_7_0_EDX_ARCH_CAPABILITIES | CPUID_7_0_EDX_SPEC_CTRL,
+        .features[FEAT_8000_0001_EDX] =3D
+            CPUID_EXT2_LM | CPUID_EXT2_RDTSCP | CPUID_EXT2_PDPE1GB |
+            CPUID_EXT2_NX | CPUID_EXT2_SYSCALL,
+        .features[FEAT_8000_0001_ECX] =3D
+            CPUID_EXT3_3DNOWPREFETCH | CPUID_EXT3_ABM | CPUID_EXT3_LAHF_LM=
,
+        .features[FEAT_8000_0007_EDX] =3D CPUID_APM_INVTSC,
+        /*
+         * TODO: When the Linux kernel introduces other existing definitio=
ns
+         * for this leaf, remember to update the definitions here.
+         */
+        .features[FEAT_C000_0001_EDX] =3D
+            CPUID_C000_0001_EDX_PMM_EN | CPUID_C000_0001_EDX_PMM |
+            CPUID_C000_0001_EDX_PHE_EN | CPUID_C000_0001_EDX_PHE |
+            CPUID_C000_0001_EDX_ACE2 |
+            CPUID_C000_0001_EDX_XCRYPT_EN | CPUID_C000_0001_EDX_XCRYPT |
+            CPUID_C000_0001_EDX_XSTORE_EN | CPUID_C000_0001_EDX_XSTORE,
+        .features[FEAT_XSAVE] =3D
+            CPUID_XSAVE_XSAVEOPT,
+        .features[FEAT_ARCH_CAPABILITIES] =3D
+            MSR_ARCH_CAP_RDCL_NO | MSR_ARCH_CAP_SKIP_L1DFL_VMENTRY |
+            MSR_ARCH_CAP_MDS_NO | MSR_ARCH_CAP_PSCHANGE_MC_NO |
+            MSR_ARCH_CAP_SSB_NO,
+        .features[FEAT_VMX_PROCBASED_CTLS] =3D
+            VMX_CPU_BASED_VIRTUAL_INTR_PENDING | VMX_CPU_BASED_HLT_EXITING=
 |
+            VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_INVLPG_EXITING=
 |
+            VMX_CPU_BASED_MWAIT_EXITING | VMX_CPU_BASED_RDPMC_EXITING |
+            VMX_CPU_BASED_RDTSC_EXITING | VMX_CPU_BASED_CR3_LOAD_EXITING |
+            VMX_CPU_BASED_CR3_STORE_EXITING | VMX_CPU_BASED_CR8_LOAD_EXITI=
NG |
+            VMX_CPU_BASED_CR8_STORE_EXITING | VMX_CPU_BASED_TPR_SHADOW |
+            VMX_CPU_BASED_VIRTUAL_NMI_PENDING | VMX_CPU_BASED_MOV_DR_EXITI=
NG |
+            VMX_CPU_BASED_UNCOND_IO_EXITING | VMX_CPU_BASED_USE_IO_BITMAPS=
 |
+            VMX_CPU_BASED_MONITOR_TRAP_FLAG | VMX_CPU_BASED_USE_MSR_BITMAP=
S |
+            VMX_CPU_BASED_MONITOR_EXITING | VMX_CPU_BASED_PAUSE_EXITING |
+            VMX_CPU_BASED_ACTIVATE_SECONDARY_CONTROLS,
+        /*
+         * missing: VMX_SECONDARY_EXEC_PAUSE_LOOP_EXITING,
+         * VMX_SECONDARY_EXEC_TSC_SCALING
+         */
+        .features[FEAT_VMX_SECONDARY_CTLS] =3D
+            VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
+            VMX_SECONDARY_EXEC_ENABLE_EPT | VMX_SECONDARY_EXEC_DESC |
+            VMX_SECONDARY_EXEC_RDTSCP | VMX_SECONDARY_EXEC_ENABLE_VPID |
+            VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
+            VMX_SECONDARY_EXEC_WBINVD_EXITING |
+            VMX_SECONDARY_EXEC_UNRESTRICTED_GUEST |
+            VMX_SECONDARY_EXEC_APIC_REGISTER_VIRT |
+            VMX_SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |
+            VMX_SECONDARY_EXEC_RDRAND_EXITING |
+            VMX_SECONDARY_EXEC_ENABLE_INVPCID |
+            VMX_SECONDARY_EXEC_ENABLE_VMFUNC |
+            VMX_SECONDARY_EXEC_SHADOW_VMCS |
+            VMX_SECONDARY_EXEC_ENABLE_PML,
+        .features[FEAT_VMX_PINBASED_CTLS] =3D
+            VMX_PIN_BASED_EXT_INTR_MASK | VMX_PIN_BASED_NMI_EXITING |
+            VMX_PIN_BASED_VIRTUAL_NMIS | VMX_PIN_BASED_VMX_PREEMPTION_TIME=
R |
+            VMX_PIN_BASED_POSTED_INTR,
+        .features[FEAT_VMX_EXIT_CTLS] =3D
+            VMX_VM_EXIT_SAVE_DEBUG_CONTROLS | VMX_VM_EXIT_HOST_ADDR_SPACE_=
SIZE |
+            VMX_VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
+            VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_IA32_PAT |
+            VMX_VM_EXIT_LOAD_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
+            VMX_VM_EXIT_LOAD_IA32_EFER | VMX_VM_EXIT_SAVE_VMX_PREEMPTION_T=
IMER,
+        /* missing: VMX_VM_ENTRY_SMM, VMX_VM_ENTRY_DEACT_DUAL_MONITOR */
+        .features[FEAT_VMX_ENTRY_CTLS] =3D
+            VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS | VMX_VM_ENTRY_IA32E_MODE |
+            VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL |
+            VMX_VM_ENTRY_LOAD_IA32_PAT | VMX_VM_ENTRY_LOAD_IA32_EFER,
+        /*
+         * missing: MSR_VMX_MISC_ACTIVITY_SHUTDOWN,
+         * MSR_VMX_MISC_ACTIVITY_WAIT_SIPI
+         */
+        .features[FEAT_VMX_MISC] =3D
+            MSR_VMX_MISC_STORE_LMA | MSR_VMX_MISC_ACTIVITY_HLT |
+            MSR_VMX_MISC_VMWRITE_VMEXIT,
+        /* missing: MSR_VMX_EPT_UC */
+        .features[FEAT_VMX_EPT_VPID_CAPS] =3D
+            MSR_VMX_EPT_EXECONLY | MSR_VMX_EPT_PAGE_WALK_LENGTH_4 |
+            MSR_VMX_EPT_WB | MSR_VMX_EPT_2MB | MSR_VMX_EPT_1GB |
+            MSR_VMX_EPT_INVEPT | MSR_VMX_EPT_AD_BITS |
+            MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_CON=
TEXT |
+            MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT | MSR_VMX_EPT_INVVPID |
+            MSR_VMX_EPT_INVVPID_ALL_CONTEXT | MSR_VMX_EPT_INVVPID_SINGLE_A=
DDR |
+            MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS,
+        .features[FEAT_VMX_BASIC] =3D
+            MSR_VMX_BASIC_INS_OUTS | MSR_VMX_BASIC_TRUE_CTLS,
+        .features[FEAT_VMX_VMFUNC] =3D MSR_VMX_VMFUNC_EPT_SWITCHING,
+        .xlevel =3D 0x80000008,
+        .model_id =3D "Zhaoxin Shijidadao-Client Processor",
+        .cache_info =3D &shijidadao_cache_info,
+        .versions =3D (X86CPUVersionDefinition[]) {
+            {
+                .version =3D 1,
+                .props =3D (PropValue[]) {
+                    { "x-force-cpuid-0x1f", "on" },
+                    { "smap", "on" },
+                    { /* end of list */ }
+                },
+            },
+            {
+                .version =3D 2,
+                .note =3D "with more XSAVE features",
+                .props =3D (PropValue[]) {
+                    { "xsavec", "on" },
+                    { "xgetbv1", "on" },
+                    { "xsaves", "on"},
+                    { "vmx-xsaves", "on"},
+                    { "smap", "off" },
+                    { /* end of list */ }
+                },
+            },
+            { /* end of list */ }
+        }
+    },
 };
=20
 /*
--=20
2.34.1


