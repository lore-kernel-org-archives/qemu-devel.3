Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1831B10F3DED
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2026 17:37:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6XbB-0002RS-0E; Sat, 28 Mar 2026 13:37:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanyaagarwal25699@gmail.com>)
 id 1w6XAc-0004Xi-Q7
 for qemu-devel@nongnu.org; Sat, 28 Mar 2026 13:09:58 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tanyaagarwal25699@gmail.com>)
 id 1w6XAZ-0000KM-5K
 for qemu-devel@nongnu.org; Sat, 28 Mar 2026 13:09:58 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2aaed195901so13666355ad.0
 for <qemu-devel@nongnu.org>; Sat, 28 Mar 2026 10:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774717792; x=1775322592; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=t69QDZrpauVjRBUE/DtMUJ/86uL6dJtOb4+etD8hPpQ=;
 b=iCFGtcAVQ49/AErhtpzm68tbcK/R8y/pzYFGMRs0UoWCveyr30C5hDgyMX+5wd4T90
 YVSdDfCUpIiG+6tvFfdIRHMOLyWxChztBEzZcRfghwQuaTPNcRzp94ulrTQEvYzpbVBI
 qCj47j5cp9Mo1206+56ymRCLvAFdjfE7bR5vQqhK8f5+C193F7eelyLdj7CXHHnQeAd7
 K3lERNlf/ax5u/5AyMqnqezCTtv+cW/h0Acbz5vcekbZoW+9rq0JFHpc8WJ06yh8z5RX
 Xg4BXvLDd0LzIMHma0J2P8Ft1WUkXTCC1xspNe4RUK+IR0iPmYhTGO4ufcJcHvtF+wmp
 SyPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774717792; x=1775322592;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t69QDZrpauVjRBUE/DtMUJ/86uL6dJtOb4+etD8hPpQ=;
 b=YOkMNf68KSHvowzfpoHnuUfZhpNasgXv2uY83zoBvjwMuj5ouOJrdTKFQtRGPbZUsC
 Th7caD7OsnBUcN1lxlZwyoPhQVaMKgGAOzP9V4rRqYfff1eYBhhs0DwCnyfkQNMZK/MH
 JSL25rBmJ9//UZG8A4PPL8gwtMAIIL6+TFjpY836tTTBKGMmCznsrJ6sfnm5slPgKNre
 DvZJdQIe1mYx0/PhPHFeH+Uj1dT2j5O/fCw/tqwHpiEz5eZHLrAJCzLdfknfx/EzTenL
 Qq5c5utqFCwt0/NCWwmrako3Z8DODOIkC4wR8rUXRICfvAXiyk5XvfQounTdQ1h8tiTw
 AnOA==
X-Gm-Message-State: AOJu0Yym7WenXITMgqVlQe7VTkQmlFMmJT1u9/y1a6LPpJqTLqy5gHA9
 fWr5f3m69jd8ddt1gnDJzihkah6O6nCI/0hMT7bgZux0cm1WBFalFEe1
X-Gm-Gg: ATEYQzy2BcPiT3U2XED2JArTGN5jpOUDYvNzJ1fyFze7V10er3Mxl0hU4Jd7Cy5eCaR
 +91tGMdeW6x7JdzUWwSbk5no7ks+ciEKvM0Iyx5awJq9KFafX1C5QDiEnnJo4Uxj9X6qt7i2a+W
 1hffnQvQuMwmYapStP6lJgJOQSmNcpY8ylDdCA2tbjEbRttx8Svbsd54y1JED9vW+g1nH1421c9
 Knxg4+D1ZsJOtEkNI8N6G2Y0UcAzLIv2++qZ9ct83WmzknSCw6xL/5S/KWsDLa2mcSvySsW+i22
 MUXk626PtDHPe98pXZKVQlfKBoRC9BO/KSjsM1dM8JHxnYbhDfui3+0NDyL+QliC+eWDzqoarfu
 cWXkplwg/vC6pQo2ToOT5JYOqduPsdozgawcE3SudtoAHdonik5A/xji5aCjJ3Lp4JQ/ssRGgUD
 Ml6vosEONaxb+ZgB21FdJvXtjzhQ/lotKayTImuM8oMjza9453or6KfHS8ifTZ6B8SzNzCldPV1
 nOX1CX/
X-Received: by 2002:a17:903:19d0:b0:2b0:afb4:7d41 with SMTP id
 d9443c01a7336-2b0cdc02e54mr73581625ad.10.1774717792102; 
 Sat, 28 Mar 2026 10:09:52 -0700 (PDT)
Received: from localhost.localdomain ([223.230.95.43])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2b242642956sm30427895ad.6.2026.03.28.10.09.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Mar 2026 10:09:51 -0700 (PDT)
From: Tanya Agarwal <tanyaagarwal25699@gmail.com>
X-Google-Original-From: Tanya Agarwal <tanyaagarwal25699@gmail.com
To: richard.henderson@linaro.org, pbonzini@redhat.com, zhao1.liu@intel.com,
 edgar.iglesias@gmail.com, mark.cave-ayland@ilande.co.uk,
 atar4qemu@gmail.com
Cc: qemu-devel@nongnu.org, thuth@redhat.com, peter.maydell@linaro.org,
 Tanya Agarwal <tanyaagarwal25699@gmail.com>
Subject: [PATCH] target: convert TABS indentation to spaces for consistency
Date: Sat, 28 Mar 2026 22:39:14 +0530
Message-Id: <20260328170913.3673-1-tanyaagarwal25699@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=tanyaagarwal25699@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 28 Mar 2026 13:37:22 -0400
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

From: Tanya Agarwal <tanyaagarwal25699@gmail.com>

To follow consistent coding style, convert TABS indentation to spaces
for consistency.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/372

Signed-off-by: Tanya Agarwal <tanyaagarwal25699@gmail.com>
---
 target/alpha/cpu.h      |   6 +-
 target/i386/cpu.h       |  40 ++---
 target/i386/svm.h       | 308 ++++++++++++++++++-------------------
 target/microblaze/cpu.h |  12 +-
 target/sparc/asi.h      | 328 ++++++++++++++++++++--------------------
 5 files changed, 347 insertions(+), 347 deletions(-)

diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index 45944e46b5..b530cd0088 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -311,9 +311,9 @@ enum {
 };
 
 /* Alpha-specific interrupt pending bits.  */
-#define CPU_INTERRUPT_TIMER	CPU_INTERRUPT_TGT_EXT_0
-#define CPU_INTERRUPT_SMP	CPU_INTERRUPT_TGT_EXT_1
-#define CPU_INTERRUPT_MCHK	CPU_INTERRUPT_TGT_EXT_2
+#define CPU_INTERRUPT_TIMER     CPU_INTERRUPT_TGT_EXT_0
+#define CPU_INTERRUPT_SMP       CPU_INTERRUPT_TGT_EXT_1
+#define CPU_INTERRUPT_MCHK      CPU_INTERRUPT_TGT_EXT_2
 
 /* OSF/1 Page table bits.  */
 enum {
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 0b539155c4..a09d5de121 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -417,12 +417,12 @@ typedef enum X86Seg {
 #define MSR_IA32_CORE_CAPABILITY        0xcf
 
 #define MSR_IA32_ARCH_CAPABILITIES      0x10a
-#define ARCH_CAP_TSX_CTRL_MSR		(1<<7)
+#define ARCH_CAP_TSX_CTRL_MSR           (1 << 7)
 
 #define MSR_IA32_PERF_CAPABILITIES      0x345
 #define PERF_CAP_LBR_FMT                0x3f
 
-#define MSR_IA32_TSX_CTRL		0x122
+#define MSR_IA32_TSX_CTRL               0x122
 #define MSR_IA32_TSCDEADLINE            0x6e0
 #define MSR_IA32_PKRS                   0x6e1
 #define MSR_RAPL_POWER_UNIT             0x00000606
@@ -1482,24 +1482,24 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define HYPERV_SPINLOCK_NEVER_NOTIFY             0xFFFFFFFF
 #endif
 
-#define EXCP00_DIVZ	0
-#define EXCP01_DB	1
-#define EXCP02_NMI	2
-#define EXCP03_INT3	3
-#define EXCP04_INTO	4
-#define EXCP05_BOUND	5
-#define EXCP06_ILLOP	6
-#define EXCP07_PREX	7
-#define EXCP08_DBLE	8
-#define EXCP09_XERR	9
-#define EXCP0A_TSS	10
-#define EXCP0B_NOSEG	11
-#define EXCP0C_STACK	12
-#define EXCP0D_GPF	13
-#define EXCP0E_PAGE	14
-#define EXCP10_COPR	16
-#define EXCP11_ALGN	17
-#define EXCP12_MCHK	18
+#define EXCP00_DIVZ     0
+#define EXCP01_DB       1
+#define EXCP02_NMI      2
+#define EXCP03_INT3     3
+#define EXCP04_INTO     4
+#define EXCP05_BOUND    5
+#define EXCP06_ILLOP    6
+#define EXCP07_PREX     7
+#define EXCP08_DBLE     8
+#define EXCP09_XERR     9
+#define EXCP0A_TSS      10
+#define EXCP0B_NOSEG    11
+#define EXCP0C_STACK    12
+#define EXCP0D_GPF      13
+#define EXCP0E_PAGE     14
+#define EXCP10_COPR     16
+#define EXCP11_ALGN     17
+#define EXCP12_MCHK     18
 
 #define EXCP_VMEXIT     0x100 /* only for system emulation */
 #define EXCP_SYSCALL    0x101 /* only for user emulation */
diff --git a/target/i386/svm.h b/target/i386/svm.h
index 1bd7844730..23c36637d4 100644
--- a/target/i386/svm.h
+++ b/target/i386/svm.h
@@ -54,88 +54,88 @@
 
 #define SVM_EXITINTINFO_VEC_MASK SVM_EVTINJ_VEC_MASK
 
-#define	SVM_EXITINTINFO_TYPE_INTR SVM_EVTINJ_TYPE_INTR
-#define	SVM_EXITINTINFO_TYPE_NMI SVM_EVTINJ_TYPE_NMI
-#define	SVM_EXITINTINFO_TYPE_EXEPT SVM_EVTINJ_TYPE_EXEPT
-#define	SVM_EXITINTINFO_TYPE_SOFT SVM_EVTINJ_TYPE_SOFT
+#define SVM_EXITINTINFO_TYPE_INTR SVM_EVTINJ_TYPE_INTR
+#define SVM_EXITINTINFO_TYPE_NMI SVM_EVTINJ_TYPE_NMI
+#define SVM_EXITINTINFO_TYPE_EXEPT SVM_EVTINJ_TYPE_EXEPT
+#define SVM_EXITINTINFO_TYPE_SOFT SVM_EVTINJ_TYPE_SOFT
 
 #define SVM_EXITINTINFO_VALID SVM_EVTINJ_VALID
 #define SVM_EXITINTINFO_VALID_ERR SVM_EVTINJ_VALID_ERR
 
-#define	SVM_EXIT_READ_CR0 	0x000
-#define	SVM_EXIT_READ_CR3 	0x003
-#define	SVM_EXIT_READ_CR4 	0x004
-#define	SVM_EXIT_READ_CR8 	0x008
-#define	SVM_EXIT_WRITE_CR0 	0x010
-#define	SVM_EXIT_WRITE_CR3 	0x013
-#define	SVM_EXIT_WRITE_CR4 	0x014
-#define	SVM_EXIT_WRITE_CR8 	0x018
-#define	SVM_EXIT_READ_DR0 	0x020
-#define	SVM_EXIT_READ_DR1 	0x021
-#define	SVM_EXIT_READ_DR2 	0x022
-#define	SVM_EXIT_READ_DR3 	0x023
-#define	SVM_EXIT_READ_DR4 	0x024
-#define	SVM_EXIT_READ_DR5 	0x025
-#define	SVM_EXIT_READ_DR6 	0x026
-#define	SVM_EXIT_READ_DR7 	0x027
-#define	SVM_EXIT_WRITE_DR0 	0x030
-#define	SVM_EXIT_WRITE_DR1 	0x031
-#define	SVM_EXIT_WRITE_DR2 	0x032
-#define	SVM_EXIT_WRITE_DR3 	0x033
-#define	SVM_EXIT_WRITE_DR4 	0x034
-#define	SVM_EXIT_WRITE_DR5 	0x035
-#define	SVM_EXIT_WRITE_DR6 	0x036
-#define	SVM_EXIT_WRITE_DR7 	0x037
+#define SVM_EXIT_READ_CR0       0x000
+#define SVM_EXIT_READ_CR3       0x003
+#define SVM_EXIT_READ_CR4       0x004
+#define SVM_EXIT_READ_CR8       0x008
+#define SVM_EXIT_WRITE_CR0      0x010
+#define SVM_EXIT_WRITE_CR3      0x013
+#define SVM_EXIT_WRITE_CR4      0x014
+#define SVM_EXIT_WRITE_CR8      0x018
+#define SVM_EXIT_READ_DR0       0x020
+#define SVM_EXIT_READ_DR1       0x021
+#define SVM_EXIT_READ_DR2       0x022
+#define SVM_EXIT_READ_DR3       0x023
+#define SVM_EXIT_READ_DR4       0x024
+#define SVM_EXIT_READ_DR5       0x025
+#define SVM_EXIT_READ_DR6       0x026
+#define SVM_EXIT_READ_DR7       0x027
+#define SVM_EXIT_WRITE_DR0      0x030
+#define SVM_EXIT_WRITE_DR1      0x031
+#define SVM_EXIT_WRITE_DR2      0x032
+#define SVM_EXIT_WRITE_DR3      0x033
+#define SVM_EXIT_WRITE_DR4      0x034
+#define SVM_EXIT_WRITE_DR5      0x035
+#define SVM_EXIT_WRITE_DR6      0x036
+#define SVM_EXIT_WRITE_DR7      0x037
 #define SVM_EXIT_EXCP_BASE      0x040
-#define SVM_EXIT_INTR		0x060
-#define SVM_EXIT_NMI		0x061
-#define SVM_EXIT_SMI		0x062
-#define SVM_EXIT_INIT		0x063
-#define SVM_EXIT_VINTR		0x064
-#define SVM_EXIT_CR0_SEL_WRITE	0x065
-#define SVM_EXIT_IDTR_READ	0x066
-#define SVM_EXIT_GDTR_READ	0x067
-#define SVM_EXIT_LDTR_READ	0x068
-#define SVM_EXIT_TR_READ	0x069
-#define SVM_EXIT_IDTR_WRITE	0x06a
-#define SVM_EXIT_GDTR_WRITE	0x06b
-#define SVM_EXIT_LDTR_WRITE	0x06c
-#define SVM_EXIT_TR_WRITE	0x06d
-#define SVM_EXIT_RDTSC		0x06e
-#define SVM_EXIT_RDPMC		0x06f
-#define SVM_EXIT_PUSHF		0x070
-#define SVM_EXIT_POPF		0x071
-#define SVM_EXIT_CPUID		0x072
-#define SVM_EXIT_RSM		0x073
-#define SVM_EXIT_IRET		0x074
-#define SVM_EXIT_SWINT		0x075
-#define SVM_EXIT_INVD		0x076
-#define SVM_EXIT_PAUSE		0x077
-#define SVM_EXIT_HLT		0x078
-#define SVM_EXIT_INVLPG		0x079
-#define SVM_EXIT_INVLPGA	0x07a
-#define SVM_EXIT_IOIO		0x07b
-#define SVM_EXIT_MSR		0x07c
-#define SVM_EXIT_TASK_SWITCH	0x07d
-#define SVM_EXIT_FERR_FREEZE	0x07e
-#define SVM_EXIT_SHUTDOWN	0x07f
-#define SVM_EXIT_VMRUN		0x080
-#define SVM_EXIT_VMMCALL	0x081
-#define SVM_EXIT_VMLOAD		0x082
-#define SVM_EXIT_VMSAVE		0x083
-#define SVM_EXIT_STGI		0x084
-#define SVM_EXIT_CLGI		0x085
-#define SVM_EXIT_SKINIT		0x086
-#define SVM_EXIT_RDTSCP		0x087
-#define SVM_EXIT_ICEBP		0x088
-#define SVM_EXIT_WBINVD		0x089
+#define SVM_EXIT_INTR           0x060
+#define SVM_EXIT_NMI            0x061
+#define SVM_EXIT_SMI            0x062
+#define SVM_EXIT_INIT           0x063
+#define SVM_EXIT_VINTR          0x064
+#define SVM_EXIT_CR0_SEL_WRITE  0x065
+#define SVM_EXIT_IDTR_READ      0x066
+#define SVM_EXIT_GDTR_READ      0x067
+#define SVM_EXIT_LDTR_READ      0x068
+#define SVM_EXIT_TR_READ        0x069
+#define SVM_EXIT_IDTR_WRITE     0x06a
+#define SVM_EXIT_GDTR_WRITE     0x06b
+#define SVM_EXIT_LDTR_WRITE     0x06c
+#define SVM_EXIT_TR_WRITE       0x06d
+#define SVM_EXIT_RDTSC          0x06e
+#define SVM_EXIT_RDPMC          0x06f
+#define SVM_EXIT_PUSHF          0x070
+#define SVM_EXIT_POPF           0x071
+#define SVM_EXIT_CPUID          0x072
+#define SVM_EXIT_RSM            0x073
+#define SVM_EXIT_IRET           0x074
+#define SVM_EXIT_SWINT          0x075
+#define SVM_EXIT_INVD           0x076
+#define SVM_EXIT_PAUSE          0x077
+#define SVM_EXIT_HLT            0x078
+#define SVM_EXIT_INVLPG         0x079
+#define SVM_EXIT_INVLPGA        0x07a
+#define SVM_EXIT_IOIO           0x07b
+#define SVM_EXIT_MSR            0x07c
+#define SVM_EXIT_TASK_SWITCH    0x07d
+#define SVM_EXIT_FERR_FREEZE    0x07e
+#define SVM_EXIT_SHUTDOWN       0x07f
+#define SVM_EXIT_VMRUN          0x080
+#define SVM_EXIT_VMMCALL        0x081
+#define SVM_EXIT_VMLOAD         0x082
+#define SVM_EXIT_VMSAVE         0x083
+#define SVM_EXIT_STGI           0x084
+#define SVM_EXIT_CLGI           0x085
+#define SVM_EXIT_SKINIT         0x086
+#define SVM_EXIT_RDTSCP         0x087
+#define SVM_EXIT_ICEBP          0x088
+#define SVM_EXIT_WBINVD         0x089
 /* only included in documentation, maybe wrong */
-#define SVM_EXIT_MONITOR	0x08a
-#define SVM_EXIT_MWAIT		0x08b
-#define SVM_EXIT_XSETBV		0x08d
-#define SVM_EXIT_NPF  		0x400
+#define SVM_EXIT_MONITOR        0x08a
+#define SVM_EXIT_MWAIT          0x08b
+#define SVM_EXIT_XSETBV         0x08d
+#define SVM_EXIT_NPF            0x400
 
-#define SVM_EXIT_ERR		-1
+#define SVM_EXIT_ERR            -1
 
 #define SVM_CR0_SELECTIVE_MASK (1 << 3 | 1) /* TS and MP */
 
@@ -146,96 +146,96 @@
 
 #define SVM_CR0_RESERVED_MASK 0xffffffff00000000U
 
-#define SVM_MSRPM_SIZE		(1ULL << 13)
-#define SVM_IOPM_SIZE		((1ULL << 13) + 1)
+#define SVM_MSRPM_SIZE          (1ULL << 13)
+#define SVM_IOPM_SIZE           ((1ULL << 13) + 1)
 
 struct QEMU_PACKED vmcb_control_area {
-	uint16_t intercept_cr_read;
-	uint16_t intercept_cr_write;
-	uint16_t intercept_dr_read;
-	uint16_t intercept_dr_write;
-	uint32_t intercept_exceptions;
-	uint64_t intercept;
-	uint8_t reserved_1[44];
-	uint64_t iopm_base_pa;
-	uint64_t msrpm_base_pa;
-	uint64_t tsc_offset;
-	uint32_t asid;
-	uint8_t tlb_ctl;
-	uint8_t reserved_2[3];
-	uint32_t int_ctl;
-	uint32_t int_vector;
-	uint32_t int_state;
-	uint8_t reserved_3[4];
-	uint64_t exit_code;
-	uint64_t exit_info_1;
-	uint64_t exit_info_2;
-	uint32_t exit_int_info;
-	uint32_t exit_int_info_err;
-	uint64_t nested_ctl;
-	uint8_t reserved_4[16];
-	uint32_t event_inj;
-	uint32_t event_inj_err;
-	uint64_t nested_cr3;
-	uint64_t lbr_ctl;
-	uint8_t reserved_5[832];
+    uint16_t intercept_cr_read;
+    uint16_t intercept_cr_write;
+    uint16_t intercept_dr_read;
+    uint16_t intercept_dr_write;
+    uint32_t intercept_exceptions;
+    uint64_t intercept;
+    uint8_t reserved_1[44];
+    uint64_t iopm_base_pa;
+    uint64_t msrpm_base_pa;
+    uint64_t tsc_offset;
+    uint32_t asid;
+    uint8_t tlb_ctl;
+    uint8_t reserved_2[3];
+    uint32_t int_ctl;
+    uint32_t int_vector;
+    uint32_t int_state;
+    uint8_t reserved_3[4];
+    uint64_t exit_code;
+    uint64_t exit_info_1;
+    uint64_t exit_info_2;
+    uint32_t exit_int_info;
+    uint32_t exit_int_info_err;
+    uint64_t nested_ctl;
+    uint8_t reserved_4[16];
+    uint32_t event_inj;
+    uint32_t event_inj_err;
+    uint64_t nested_cr3;
+    uint64_t lbr_ctl;
+    uint8_t reserved_5[832];
 };
 
 struct QEMU_PACKED vmcb_seg {
-	uint16_t selector;
-	uint16_t attrib;
-	uint32_t limit;
-	uint64_t base;
+    uint16_t selector;
+    uint16_t attrib;
+    uint32_t limit;
+    uint64_t base;
 };
 
 struct QEMU_PACKED vmcb_save_area {
-	struct vmcb_seg es;
-	struct vmcb_seg cs;
-	struct vmcb_seg ss;
-	struct vmcb_seg ds;
-	struct vmcb_seg fs;
-	struct vmcb_seg gs;
-	struct vmcb_seg gdtr;
-	struct vmcb_seg ldtr;
-	struct vmcb_seg idtr;
-	struct vmcb_seg tr;
-	uint8_t reserved_1[43];
-	uint8_t cpl;
-	uint8_t reserved_2[4];
-	uint64_t efer;
-	uint8_t reserved_3[112];
-	uint64_t cr4;
-	uint64_t cr3;
-	uint64_t cr0;
-	uint64_t dr7;
-	uint64_t dr6;
-	uint64_t rflags;
-	uint64_t rip;
-	uint8_t reserved_4[88];
-	uint64_t rsp;
-	uint8_t reserved_5[24];
-	uint64_t rax;
-	uint64_t star;
-	uint64_t lstar;
-	uint64_t cstar;
-	uint64_t sfmask;
-	uint64_t kernel_gs_base;
-	uint64_t sysenter_cs;
-	uint64_t sysenter_esp;
-	uint64_t sysenter_eip;
-	uint64_t cr2;
-	uint8_t reserved_6[32];
-	uint64_t g_pat;
-	uint64_t dbgctl;
-	uint64_t br_from;
-	uint64_t br_to;
-	uint64_t last_excp_from;
-	uint64_t last_excp_to;
+    struct vmcb_seg es;
+    struct vmcb_seg cs;
+    struct vmcb_seg ss;
+    struct vmcb_seg ds;
+    struct vmcb_seg fs;
+    struct vmcb_seg gs;
+    struct vmcb_seg gdtr;
+    struct vmcb_seg ldtr;
+    struct vmcb_seg idtr;
+    struct vmcb_seg tr;
+    uint8_t reserved_1[43];
+    uint8_t cpl;
+    uint8_t reserved_2[4];
+    uint64_t efer;
+    uint8_t reserved_3[112];
+    uint64_t cr4;
+    uint64_t cr3;
+    uint64_t cr0;
+    uint64_t dr7;
+    uint64_t dr6;
+    uint64_t rflags;
+    uint64_t rip;
+    uint8_t reserved_4[88];
+    uint64_t rsp;
+    uint8_t reserved_5[24];
+    uint64_t rax;
+    uint64_t star;
+    uint64_t lstar;
+    uint64_t cstar;
+    uint64_t sfmask;
+    uint64_t kernel_gs_base;
+    uint64_t sysenter_cs;
+    uint64_t sysenter_esp;
+    uint64_t sysenter_eip;
+    uint64_t cr2;
+    uint8_t reserved_6[32];
+    uint64_t g_pat;
+    uint64_t dbgctl;
+    uint64_t br_from;
+    uint64_t br_to;
+    uint64_t last_excp_from;
+    uint64_t last_excp_to;
 };
 
 struct QEMU_PACKED vmcb {
-	struct vmcb_control_area control;
-	struct vmcb_save_area save;
+    struct vmcb_control_area control;
+    struct vmcb_save_area save;
 };
 
 #endif
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index d26b933b6d..5a856edaaa 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -122,9 +122,9 @@ typedef struct CPUArchState CPUMBState;
 #define PVR0_USE_ICACHE_MASK            0x02000000
 #define PVR0_USE_DCACHE_MASK            0x01000000
 #define PVR0_USE_MMU_MASK               0x00800000
-#define PVR0_USE_BTC			0x00400000
+#define PVR0_USE_BTC                    0x00400000
 #define PVR0_ENDI_MASK                  0x00200000
-#define PVR0_FAULT			0x00100000
+#define PVR0_FAULT                      0x00100000
 #define PVR0_VERSION_MASK               0x0000FF00
 #define PVR0_USER1_MASK                 0x000000FF
 #define PVR0_SPROT_MASK                 0x00000001
@@ -271,10 +271,10 @@ struct CPUArchState {
 /* MSR_UM               (1 << 11) */
 /* MSR_VM               (1 << 13) */
 /* ESR_ESS_MASK         [11:5]    -- unwind into iflags for unaligned excp */
-#define D_FLAG		(1 << 12)  /* Bit in ESR.  */
-#define DRTI_FLAG	(1 << 16)
-#define DRTE_FLAG	(1 << 17)
-#define DRTB_FLAG	(1 << 18)
+#define D_FLAG          (1 << 12)  /* Bit in ESR.  */
+#define DRTI_FLAG       (1 << 16)
+#define DRTE_FLAG       (1 << 17)
+#define DRTB_FLAG       (1 << 18)
 
 /* TB dependent CPUMBState.  */
 #define IFLAGS_TB_MASK  (D_FLAG | BIMM_FLAG | IMM_FLAG | \
diff --git a/target/sparc/asi.h b/target/sparc/asi.h
index 14ffaa3842..7d6dae6d61 100644
--- a/target/sparc/asi.h
+++ b/target/sparc/asi.h
@@ -102,7 +102,7 @@
 
 #define ASI_M_DCDR         0x39   /* Data Cache Diagnostics Register rw, ss */
 
-#define ASI_M_VIKING_TMP1  0x40	  /* Emulation temporary 1 on Viking */
+#define ASI_M_VIKING_TMP1  0x40   /* Emulation temporary 1 on Viking */
 /* only available on SuperSparc I */
 /* #define ASI_M_VIKING_TMP2  0x41 */  /* Emulation temporary 2 on Viking */
 
@@ -123,20 +123,20 @@
 #define ASI_LEON_FLUSH_PAGE     0x10
 
 /* V9 Architecture mandary ASIs. */
-#define ASI_N			0x04 /* Nucleus				*/
-#define ASI_NL			0x0c /* Nucleus, little endian		*/
-#define ASI_AIUP		0x10 /* Primary, user			*/
-#define ASI_AIUS		0x11 /* Secondary, user			*/
-#define ASI_AIUPL		0x18 /* Primary, user, little endian	*/
-#define ASI_AIUSL		0x19 /* Secondary, user, little endian	*/
-#define ASI_P			0x80 /* Primary, implicit		*/
-#define ASI_S			0x81 /* Secondary, implicit		*/
-#define ASI_PNF			0x82 /* Primary, no fault		*/
-#define ASI_SNF			0x83 /* Secondary, no fault		*/
-#define ASI_PL			0x88 /* Primary, implicit, l-endian	*/
-#define ASI_SL			0x89 /* Secondary, implicit, l-endian	*/
-#define ASI_PNFL		0x8a /* Primary, no fault, l-endian	*/
-#define ASI_SNFL		0x8b /* Secondary, no fault, l-endian	*/
+#define ASI_N                   0x04 /* Nucleus                         */
+#define ASI_NL                  0x0c /* Nucleus, little endian          */
+#define ASI_AIUP                0x10 /* Primary, user                   */
+#define ASI_AIUS                0x11 /* Secondary, user                 */
+#define ASI_AIUPL               0x18 /* Primary, user, little endian    */
+#define ASI_AIUSL               0x19 /* Secondary, user, little endian  */
+#define ASI_P                   0x80 /* Primary, implicit               */
+#define ASI_S                   0x81 /* Secondary, implicit             */
+#define ASI_PNF                 0x82 /* Primary, no fault               */
+#define ASI_SNF                 0x83 /* Secondary, no fault             */
+#define ASI_PL                  0x88 /* Primary, implicit, l-endian     */
+#define ASI_SL                  0x89 /* Secondary, implicit, l-endian   */
+#define ASI_PNFL                0x8a /* Primary, no fault, l-endian     */
+#define ASI_SNFL                0x8b /* Secondary, no fault, l-endian   */
 
 /* SpitFire and later extended ASIs.  The "(III)" marker designates
  * UltraSparc-III and later specific ASIs.  The "(CMT)" marker designates
@@ -147,170 +147,170 @@
 #define ASI_MON_AIUP            0x12 /* (VIS4) Primary, user, monitor   */
 #define ASI_MON_AIUS            0x13 /* (VIS4) Secondary, user, monitor */
 #define ASI_REAL                0x14 /* Real address, cacheable          */
-#define ASI_PHYS_USE_EC		0x14 /* PADDR, E-cacheable		*/
+#define ASI_PHYS_USE_EC         0x14 /* PADDR, E-cacheable              */
 #define ASI_REAL_IO             0x15 /* Real address, non-cacheable      */
-#define ASI_PHYS_BYPASS_EC_E	0x15 /* PADDR, E-bit			*/
-#define ASI_BLK_AIUP_4V		0x16 /* (4V) Prim, user, block ld/st	*/
-#define ASI_BLK_AIUS_4V		0x17 /* (4V) Sec, user, block ld/st	*/
+#define ASI_PHYS_BYPASS_EC_E    0x15 /* PADDR, E-bit                    */
+#define ASI_BLK_AIUP_4V         0x16 /* (4V) Prim, user, block ld/st    */
+#define ASI_BLK_AIUS_4V         0x17 /* (4V) Sec, user, block ld/st     */
 #define ASI_REAL_L              0x1c /* Real address, cacheable, LE      */
-#define ASI_PHYS_USE_EC_L	0x1c /* PADDR, E-cacheable, little endian*/
+#define ASI_PHYS_USE_EC_L       0x1c /* PADDR, E-cacheable, little endian*/
 #define ASI_REAL_IO_L           0x1d /* Real address, non-cacheable, LE  */
-#define ASI_PHYS_BYPASS_EC_E_L	0x1d /* PADDR, E-bit, little endian	*/
-#define ASI_BLK_AIUP_L_4V	0x1e /* (4V) Prim, user, block, l-endian*/
-#define ASI_BLK_AIUS_L_4V	0x1f /* (4V) Sec, user, block, l-endian	*/
-#define ASI_SCRATCHPAD		0x20 /* (4V) Scratch Pad Registers	*/
-#define ASI_MMU			0x21 /* (4V) MMU Context Registers	*/
+#define ASI_PHYS_BYPASS_EC_E_L  0x1d /* PADDR, E-bit, little endian     */
+#define ASI_BLK_AIUP_L_4V       0x1e /* (4V) Prim, user, block, l-endian*/
+#define ASI_BLK_AIUS_L_4V       0x1f /* (4V) Sec, user, block, l-endian */
+#define ASI_SCRATCHPAD          0x20 /* (4V) Scratch Pad Registers      */
+#define ASI_MMU                 0x21 /* (4V) MMU Context Registers      */
 #define ASI_TWINX_AIUP          0x22 /* twin load, primary user         */
 #define ASI_TWINX_AIUS          0x23 /* twin load, secondary user       */
 #define ASI_BLK_INIT_QUAD_LDD_AIUS 0x23 /* (NG) init-store, twin load,
-					 * secondary, user
-					 */
-#define ASI_NUCLEUS_QUAD_LDD	0x24 /* Cacheable, qword load		*/
-#define ASI_QUEUE		0x25 /* (4V) Interrupt Queue Registers	*/
-#define ASI_TWINX_REAL          0x26 /* twin load, real, cacheable	*/
-#define ASI_QUAD_LDD_PHYS_4V	0x26 /* (4V) Physical, qword load	*/
+                     * secondary, user
+                     */
+#define ASI_NUCLEUS_QUAD_LDD    0x24 /* Cacheable, qword load           */
+#define ASI_QUEUE               0x25 /* (4V) Interrupt Queue Registers  */
+#define ASI_TWINX_REAL          0x26 /* twin load, real, cacheable      */
+#define ASI_QUAD_LDD_PHYS_4V    0x26 /* (4V) Physical, qword load       */
 #define ASI_TWINX_N             0x27 /* twin load, nucleus              */
 #define ASI_TWINX_AIUP_L        0x2a /* twin load, primary user, LE     */
 #define ASI_TWINX_AIUS_L        0x2b /* twin load, secondary user, LE   */
-#define ASI_NUCLEUS_QUAD_LDD_L	0x2c /* Cacheable, qword load, l-endian */
-#define ASI_TWINX_REAL_L        0x2e /* twin load, real, cacheable, LE	*/
-#define ASI_QUAD_LDD_PHYS_L_4V	0x2e /* (4V) Phys, qword load, l-endian	*/
+#define ASI_NUCLEUS_QUAD_LDD_L  0x2c /* Cacheable, qword load, l-endian */
+#define ASI_TWINX_REAL_L        0x2e /* twin load, real, cacheable, LE  */
+#define ASI_QUAD_LDD_PHYS_L_4V  0x2e /* (4V) Phys, qword load, l-endian */
 #define ASI_TWINX_NL            0x2f /* twin load, nucleus, LE          */
-#define ASI_PCACHE_DATA_STATUS	0x30 /* (III) PCache data stat RAM diag	*/
-#define ASI_PCACHE_DATA		0x31 /* (III) PCache data RAM diag	*/
-#define ASI_PCACHE_TAG		0x32 /* (III) PCache tag RAM diag	*/
-#define ASI_PCACHE_SNOOP_TAG	0x33 /* (III) PCache snoop tag RAM diag	*/
-#define ASI_QUAD_LDD_PHYS	0x34 /* (III+) PADDR, qword load	*/
-#define ASI_WCACHE_VALID_BITS	0x38 /* (III) WCache Valid Bits diag	*/
-#define ASI_WCACHE_DATA		0x39 /* (III) WCache data RAM diag	*/
-#define ASI_WCACHE_TAG		0x3a /* (III) WCache tag RAM diag	*/
-#define ASI_WCACHE_SNOOP_TAG	0x3b /* (III) WCache snoop tag RAM diag	*/
-#define ASI_QUAD_LDD_PHYS_L	0x3c /* (III+) PADDR, qw-load, l-endian	*/
-#define ASI_SRAM_FAST_INIT	0x40 /* (III+) Fast SRAM init		*/
-#define ASI_CORE_AVAILABLE	0x41 /* (CMT) LP Available		*/
-#define ASI_CORE_ENABLE_STAT	0x41 /* (CMT) LP Enable Status		*/
-#define ASI_CORE_ENABLE		0x41 /* (CMT) LP Enable RW		*/
-#define ASI_XIR_STEERING	0x41 /* (CMT) XIR Steering RW		*/
-#define ASI_CORE_RUNNING_RW	0x41 /* (CMT) LP Running RW		*/
-#define ASI_CORE_RUNNING_W1S	0x41 /* (CMT) LP Running Write-One Set	*/
-#define ASI_CORE_RUNNING_W1C	0x41 /* (CMT) LP Running Write-One Clr	*/
-#define ASI_CORE_RUNNING_STAT	0x41 /* (CMT) LP Running Status		*/
-#define ASI_CMT_ERROR_STEERING	0x41 /* (CMT) Error Steering RW		*/
-#define ASI_DCACHE_INVALIDATE	0x42 /* (III) DCache Invalidate diag	*/
-#define ASI_DCACHE_UTAG		0x43 /* (III) DCache uTag diag		*/
-#define ASI_DCACHE_SNOOP_TAG	0x44 /* (III) DCache snoop tag RAM diag	*/
-#define ASI_LSU_CONTROL		0x45 /* Load-store control unit		*/
-#define ASI_DCU_CONTROL_REG	0x45 /* (III) DCache Unit Control reg	*/
-#define ASI_DCACHE_DATA		0x46 /* DCache data-ram diag access	*/
-#define ASI_DCACHE_TAG		0x47 /* Dcache tag/valid ram diag access*/
-#define ASI_INTR_DISPATCH_STAT	0x48 /* IRQ vector dispatch status	*/
-#define ASI_INTR_RECEIVE	0x49 /* IRQ vector receive status	*/
-#define ASI_UPA_CONFIG		0x4a /* UPA config space		*/
-#define ASI_JBUS_CONFIG		0x4a /* (IIIi) JBUS Config Register	*/
-#define ASI_SAFARI_CONFIG	0x4a /* (III) Safari Config Register	*/
-#define ASI_SAFARI_ADDRESS	0x4a /* (III) Safari Address Register	*/
-#define ASI_ESTATE_ERROR_EN	0x4b /* E-cache error enable space	*/
-#define ASI_AFSR		0x4c /* Async fault status register	*/
-#define ASI_AFAR		0x4d /* Async fault address register	*/
-#define ASI_EC_TAG_DATA		0x4e /* E-cache tag/valid ram diag acc	*/
-#define ASI_HYP_SCRATCHPAD	0x4f /* (4V) Hypervisor scratchpad	*/
-#define ASI_IMMU		0x50 /* Insn-MMU main register space	*/
-#define ASI_IMMU_TSB_8KB_PTR	0x51 /* Insn-MMU 8KB TSB pointer reg	*/
-#define ASI_IMMU_TSB_64KB_PTR	0x52 /* Insn-MMU 64KB TSB pointer reg	*/
-#define ASI_ITLB_DATA_IN	0x54 /* Insn-MMU TLB data in reg	*/
-#define ASI_ITLB_DATA_ACCESS	0x55 /* Insn-MMU TLB data access reg	*/
-#define ASI_ITLB_TAG_READ	0x56 /* Insn-MMU TLB tag read reg	*/
-#define ASI_IMMU_DEMAP		0x57 /* Insn-MMU TLB demap		*/
-#define ASI_DMMU		0x58 /* Data-MMU main register space	*/
-#define ASI_DMMU_TSB_8KB_PTR	0x59 /* Data-MMU 8KB TSB pointer reg	*/
-#define ASI_DMMU_TSB_64KB_PTR	0x5a /* Data-MMU 16KB TSB pointer reg	*/
-#define ASI_DMMU_TSB_DIRECT_PTR	0x5b /* Data-MMU TSB direct pointer reg	*/
-#define ASI_DTLB_DATA_IN	0x5c /* Data-MMU TLB data in reg	*/
-#define ASI_DTLB_DATA_ACCESS	0x5d /* Data-MMU TLB data access reg	*/
-#define ASI_DTLB_TAG_READ	0x5e /* Data-MMU TLB tag read reg	*/
-#define ASI_DMMU_DEMAP		0x5f /* Data-MMU TLB demap		*/
-#define ASI_IIU_INST_TRAP	0x60 /* (III) Instruction Breakpoint	*/
-#define ASI_INTR_ID		0x63 /* (CMT) Interrupt ID register	*/
-#define ASI_CORE_ID		0x63 /* (CMT) LP ID register		*/
-#define ASI_CESR_ID		0x63 /* (CMT) CESR ID register		*/
-#define ASI_IC_INSTR		0x66 /* Insn cache instruction ram diag	*/
-#define ASI_IC_TAG		0x67 /* Insn cache tag/valid ram diag 	*/
-#define ASI_IC_STAG		0x68 /* (III) Insn cache snoop tag ram	*/
-#define ASI_IC_PRE_DECODE	0x6e /* Insn cache pre-decode ram diag	*/
-#define ASI_IC_NEXT_FIELD	0x6f /* Insn cache next-field ram diag	*/
-#define ASI_BRPRED_ARRAY	0x6f /* (III) Branch Prediction RAM diag*/
-#define ASI_BLK_AIUP		0x70 /* Primary, user, block load/store	*/
-#define ASI_BLK_AIUS		0x71 /* Secondary, user, block ld/st	*/
-#define ASI_MCU_CTRL_REG	0x72 /* (III) Memory controller regs	*/
-#define ASI_EC_DATA		0x74 /* (III) E-cache data staging reg	*/
-#define ASI_EC_CTRL		0x75 /* (III) E-cache control reg	*/
-#define ASI_EC_W		0x76 /* E-cache diag write access	*/
-#define ASI_UDB_ERROR_W		0x77 /* External UDB error regs W	*/
-#define ASI_UDB_CONTROL_W	0x77 /* External UDB control regs W	*/
-#define ASI_INTR_W		0x77 /* IRQ vector dispatch write	*/
-#define ASI_INTR_DATAN_W	0x77 /* (III) Out irq vector data reg N	*/
-#define ASI_INTR_DISPATCH_W	0x77 /* (III) Interrupt vector dispatch	*/
-#define ASI_BLK_AIUPL		0x78 /* Primary, user, little, blk ld/st*/
-#define ASI_BLK_AIUSL		0x79 /* Secondary, user, little, blk ld/st*/
-#define ASI_EC_R		0x7e /* E-cache diag read access	*/
-#define ASI_UDBH_ERROR_R	0x7f /* External UDB error regs rd hi	*/
-#define ASI_UDBL_ERROR_R	0x7f /* External UDB error regs rd low	*/
-#define ASI_UDBH_CONTROL_R	0x7f /* External UDB control regs rd hi	*/
-#define ASI_UDBL_CONTROL_R	0x7f /* External UDB control regs rd low*/
-#define ASI_INTR_R		0x7f /* IRQ vector dispatch read	*/
-#define ASI_INTR_DATAN_R	0x7f /* (III) In irq vector data reg N	*/
+#define ASI_PCACHE_DATA_STATUS  0x30 /* (III) PCache data stat RAM diag */
+#define ASI_PCACHE_DATA         0x31 /* (III) PCache data RAM diag      */
+#define ASI_PCACHE_TAG          0x32 /* (III) PCache tag RAM diag       */
+#define ASI_PCACHE_SNOOP_TAG    0x33 /* (III) PCache snoop tag RAM diag */
+#define ASI_QUAD_LDD_PHYS       0x34 /* (III+) PADDR, qword load        */
+#define ASI_WCACHE_VALID_BITS   0x38 /* (III) WCache Valid Bits diag    */
+#define ASI_WCACHE_DATA         0x39 /* (III) WCache data RAM diag      */
+#define ASI_WCACHE_TAG          0x3a /* (III) WCache tag RAM diag       */
+#define ASI_WCACHE_SNOOP_TAG    0x3b /* (III) WCache snoop tag RAM diag */
+#define ASI_QUAD_LDD_PHYS_L     0x3c /* (III+) PADDR, qw-load, l-endian */
+#define ASI_SRAM_FAST_INIT      0x40 /* (III+) Fast SRAM init           */
+#define ASI_CORE_AVAILABLE      0x41 /* (CMT) LP Available              */
+#define ASI_CORE_ENABLE_STAT    0x41 /* (CMT) LP Enable Status          */
+#define ASI_CORE_ENABLE         0x41 /* (CMT) LP Enable RW              */
+#define ASI_XIR_STEERING        0x41 /* (CMT) XIR Steering RW           */
+#define ASI_CORE_RUNNING_RW     0x41 /* (CMT) LP Running RW             */
+#define ASI_CORE_RUNNING_W1S    0x41 /* (CMT) LP Running Write-One Set  */
+#define ASI_CORE_RUNNING_W1C    0x41 /* (CMT) LP Running Write-One Clr  */
+#define ASI_CORE_RUNNING_STAT   0x41 /* (CMT) LP Running Status         */
+#define ASI_CMT_ERROR_STEERING  0x41 /* (CMT) Error Steering RW         */
+#define ASI_DCACHE_INVALIDATE   0x42 /* (III) DCache Invalidate diag    */
+#define ASI_DCACHE_UTAG         0x43 /* (III) DCache uTag diag          */
+#define ASI_DCACHE_SNOOP_TAG    0x44 /* (III) DCache snoop tag RAM diag */
+#define ASI_LSU_CONTROL         0x45 /* Load-store control unit         */
+#define ASI_DCU_CONTROL_REG     0x45 /* (III) DCache Unit Control reg   */
+#define ASI_DCACHE_DATA         0x46 /* DCache data-ram diag access     */
+#define ASI_DCACHE_TAG          0x47 /* Dcache tag/valid ram diag access*/
+#define ASI_INTR_DISPATCH_STAT  0x48 /* IRQ vector dispatch status      */
+#define ASI_INTR_RECEIVE        0x49 /* IRQ vector receive status       */
+#define ASI_UPA_CONFIG          0x4a /* UPA config space                */
+#define ASI_JBUS_CONFIG         0x4a /* (IIIi) JBUS Config Register     */
+#define ASI_SAFARI_CONFIG       0x4a /* (III) Safari Config Register    */
+#define ASI_SAFARI_ADDRESS      0x4a /* (III) Safari Address Register   */
+#define ASI_ESTATE_ERROR_EN     0x4b /* E-cache error enable space      */
+#define ASI_AFSR                0x4c /* Async fault status register     */
+#define ASI_AFAR                0x4d /* Async fault address register    */
+#define ASI_EC_TAG_DATA         0x4e /* E-cache tag/valid ram diag acc  */
+#define ASI_HYP_SCRATCHPAD      0x4f /* (4V) Hypervisor scratchpad      */
+#define ASI_IMMU                0x50 /* Insn-MMU main register space    */
+#define ASI_IMMU_TSB_8KB_PTR    0x51 /* Insn-MMU 8KB TSB pointer reg    */
+#define ASI_IMMU_TSB_64KB_PTR   0x52 /* Insn-MMU 64KB TSB pointer reg   */
+#define ASI_ITLB_DATA_IN        0x54 /* Insn-MMU TLB data in reg        */
+#define ASI_ITLB_DATA_ACCESS    0x55 /* Insn-MMU TLB data access reg    */
+#define ASI_ITLB_TAG_READ       0x56 /* Insn-MMU TLB tag read reg       */
+#define ASI_IMMU_DEMAP          0x57 /* Insn-MMU TLB demap              */
+#define ASI_DMMU                0x58 /* Data-MMU main register space    */
+#define ASI_DMMU_TSB_8KB_PTR    0x59 /* Data-MMU 8KB TSB pointer reg    */
+#define ASI_DMMU_TSB_64KB_PTR   0x5a /* Data-MMU 16KB TSB pointer reg   */
+#define ASI_DMMU_TSB_DIRECT_PTR 0x5b /* Data-MMU TSB direct pointer reg */
+#define ASI_DTLB_DATA_IN        0x5c /* Data-MMU TLB data in reg        */
+#define ASI_DTLB_DATA_ACCESS    0x5d /* Data-MMU TLB data access reg    */
+#define ASI_DTLB_TAG_READ       0x5e /* Data-MMU TLB tag read reg       */
+#define ASI_DMMU_DEMAP          0x5f /* Data-MMU TLB demap              */
+#define ASI_IIU_INST_TRAP       0x60 /* (III) Instruction Breakpoint    */
+#define ASI_INTR_ID             0x63 /* (CMT) Interrupt ID register     */
+#define ASI_CORE_ID             0x63 /* (CMT) LP ID register            */
+#define ASI_CESR_ID             0x63 /* (CMT) CESR ID register          */
+#define ASI_IC_INSTR            0x66 /* Insn cache instruction ram diag */
+#define ASI_IC_TAG              0x67 /* Insn cache tag/valid ram diag   */
+#define ASI_IC_STAG             0x68 /* (III) Insn cache snoop tag ram  */
+#define ASI_IC_PRE_DECODE       0x6e /* Insn cache pre-decode ram diag  */
+#define ASI_IC_NEXT_FIELD       0x6f /* Insn cache next-field ram diag  */
+#define ASI_BRPRED_ARRAY        0x6f /* (III) Branch Prediction RAM diag*/
+#define ASI_BLK_AIUP            0x70 /* Primary, user, block load/store */
+#define ASI_BLK_AIUS            0x71 /* Secondary, user, block ld/st    */
+#define ASI_MCU_CTRL_REG        0x72 /* (III) Memory controller regs    */
+#define ASI_EC_DATA             0x74 /* (III) E-cache data staging reg  */
+#define ASI_EC_CTRL             0x75 /* (III) E-cache control reg       */
+#define ASI_EC_W                0x76 /* E-cache diag write access       */
+#define ASI_UDB_ERROR_W         0x77 /* External UDB error regs W       */
+#define ASI_UDB_CONTROL_W       0x77 /* External UDB control regs W     */
+#define ASI_INTR_W              0x77 /* IRQ vector dispatch write       */
+#define ASI_INTR_DATAN_W        0x77 /* (III) Out irq vector data reg N */
+#define ASI_INTR_DISPATCH_W     0x77 /* (III) Interrupt vector dispatch */
+#define ASI_BLK_AIUPL           0x78 /* Primary, user, little, blk ld/st*/
+#define ASI_BLK_AIUSL           0x79 /* Secondary, user, little, blk ld/st*/
+#define ASI_EC_R                0x7e /* E-cache diag read access        */
+#define ASI_UDBH_ERROR_R        0x7f /* External UDB error regs rd hi   */
+#define ASI_UDBL_ERROR_R        0x7f /* External UDB error regs rd low  */
+#define ASI_UDBH_CONTROL_R      0x7f /* External UDB control regs rd hi */
+#define ASI_UDBL_CONTROL_R      0x7f /* External UDB control regs rd low*/
+#define ASI_INTR_R              0x7f /* IRQ vector dispatch read        */
+#define ASI_INTR_DATAN_R        0x7f /* (III) In irq vector data reg N  */
 #define ASI_MON_P               0x84 /* (VIS4) Primary, monitor         */
 #define ASI_MON_S               0x85 /* (VIS4) Secondary, monitor       */
-#define ASI_PIC			0xb0 /* (NG4) PIC registers		*/
-#define ASI_PST8_P		0xc0 /* Primary, 8 8-bit, partial	*/
-#define ASI_PST8_S		0xc1 /* Secondary, 8 8-bit, partial	*/
-#define ASI_PST16_P		0xc2 /* Primary, 4 16-bit, partial	*/
-#define ASI_PST16_S		0xc3 /* Secondary, 4 16-bit, partial	*/
-#define ASI_PST32_P		0xc4 /* Primary, 2 32-bit, partial	*/
-#define ASI_PST32_S		0xc5 /* Secondary, 2 32-bit, partial	*/
-#define ASI_PST8_PL		0xc8 /* Primary, 8 8-bit, partial, L	*/
-#define ASI_PST8_SL		0xc9 /* Secondary, 8 8-bit, partial, L	*/
-#define ASI_PST16_PL		0xca /* Primary, 4 16-bit, partial, L	*/
-#define ASI_PST16_SL		0xcb /* Secondary, 4 16-bit, partial, L	*/
-#define ASI_PST32_PL		0xcc /* Primary, 2 32-bit, partial, L	*/
-#define ASI_PST32_SL		0xcd /* Secondary, 2 32-bit, partial, L	*/
-#define ASI_FL8_P		0xd0 /* Primary, 1 8-bit, fpu ld/st	*/
-#define ASI_FL8_S		0xd1 /* Secondary, 1 8-bit, fpu ld/st	*/
-#define ASI_FL16_P		0xd2 /* Primary, 1 16-bit, fpu ld/st	*/
-#define ASI_FL16_S		0xd3 /* Secondary, 1 16-bit, fpu ld/st	*/
-#define ASI_FL8_PL		0xd8 /* Primary, 1 8-bit, fpu ld/st, L	*/
-#define ASI_FL8_SL		0xd9 /* Secondary, 1 8-bit, fpu ld/st, L*/
-#define ASI_FL16_PL		0xda /* Primary, 1 16-bit, fpu ld/st, L	*/
-#define ASI_FL16_SL		0xdb /* Secondary, 1 16-bit, fpu ld/st,L*/
-#define ASI_BLK_COMMIT_P	0xe0 /* Primary, blk store commit	*/
-#define ASI_BLK_COMMIT_S	0xe1 /* Secondary, blk store commit	*/
+#define ASI_PIC                 0xb0 /* (NG4) PIC registers             */
+#define ASI_PST8_P              0xc0 /* Primary, 8 8-bit, partial       */
+#define ASI_PST8_S              0xc1 /* Secondary, 8 8-bit, partial     */
+#define ASI_PST16_P             0xc2 /* Primary, 4 16-bit, partial      */
+#define ASI_PST16_S             0xc3 /* Secondary, 4 16-bit, partial    */
+#define ASI_PST32_P             0xc4 /* Primary, 2 32-bit, partial      */
+#define ASI_PST32_S             0xc5 /* Secondary, 2 32-bit, partial    */
+#define ASI_PST8_PL             0xc8 /* Primary, 8 8-bit, partial, L    */
+#define ASI_PST8_SL             0xc9 /* Secondary, 8 8-bit, partial, L  */
+#define ASI_PST16_PL            0xca /* Primary, 4 16-bit, partial, L   */
+#define ASI_PST16_SL            0xcb /* Secondary, 4 16-bit, partial, L */
+#define ASI_PST32_PL            0xcc /* Primary, 2 32-bit, partial, L   */
+#define ASI_PST32_SL            0xcd /* Secondary, 2 32-bit, partial, L */
+#define ASI_FL8_P               0xd0 /* Primary, 1 8-bit, fpu ld/st     */
+#define ASI_FL8_S               0xd1 /* Secondary, 1 8-bit, fpu ld/st   */
+#define ASI_FL16_P              0xd2 /* Primary, 1 16-bit, fpu ld/st    */
+#define ASI_FL16_S              0xd3 /* Secondary, 1 16-bit, fpu ld/st  */
+#define ASI_FL8_PL              0xd8 /* Primary, 1 8-bit, fpu ld/st, L  */
+#define ASI_FL8_SL              0xd9 /* Secondary, 1 8-bit, fpu ld/st, L*/
+#define ASI_FL16_PL             0xda /* Primary, 1 16-bit, fpu ld/st, L */
+#define ASI_FL16_SL             0xdb /* Secondary, 1 16-bit, fpu ld/st,L*/
+#define ASI_BLK_COMMIT_P        0xe0 /* Primary, blk store commit       */
+#define ASI_BLK_COMMIT_S        0xe1 /* Secondary, blk store commit     */
 #define ASI_TWINX_P             0xe2 /* twin load, primary implicit     */
-#define ASI_BLK_INIT_QUAD_LDD_P	0xe2 /* (NG) init-store, twin load,
-				      * primary, implicit */
+#define ASI_BLK_INIT_QUAD_LDD_P 0xe2 /* (NG) init-store, twin load,
+                                      * primary, implicit               */
 #define ASI_TWINX_S             0xe3 /* twin load, secondary implicit   */
-#define ASI_BLK_INIT_QUAD_LDD_S	0xe3 /* (NG) init-store, twin load,
-				      * secondary, implicit */
+#define ASI_BLK_INIT_QUAD_LDD_S 0xe3 /* (NG) init-store, twin load,
+                                      * secondary, implicit             */
 #define ASI_TWINX_PL            0xea /* twin load, primary implicit, LE */
 #define ASI_TWINX_SL            0xeb /* twin load, secondary implicit, LE */
-#define ASI_BLK_P		0xf0 /* Primary, blk ld/st		*/
-#define ASI_BLK_S		0xf1 /* Secondary, blk ld/st		*/
-#define ASI_ST_BLKINIT_MRU_P	0xf2 /* (NG4) init-store, twin load,
-				      * Most-Recently-Used, primary,
-				      * implicit
-				      */
-#define ASI_ST_BLKINIT_MRU_S	0xf2 /* (NG4) init-store, twin load,
-				      * Most-Recently-Used, secondary,
-				      * implicit
-				      */
-#define ASI_BLK_PL		0xf8 /* Primary, blk ld/st, little	*/
-#define ASI_BLK_SL		0xf9 /* Secondary, blk ld/st, little	*/
-#define ASI_ST_BLKINIT_MRU_PL	0xfa /* (NG4) init-store, twin load,
-				      * Most-Recently-Used, primary,
-				      * implicit, little-endian
-				      */
-#define ASI_ST_BLKINIT_MRU_SL	0xfb /* (NG4) init-store, twin load,
-				      * Most-Recently-Used, secondary,
-				      * implicit, little-endian
-				      */
+#define ASI_BLK_P               0xf0 /* Primary, blk ld/st              */
+#define ASI_BLK_S               0xf1 /* Secondary, blk ld/st            */
+#define ASI_ST_BLKINIT_MRU_P    0xf2 /* (NG4) init-store, twin load,
+                                      * Most-Recently-Used, primary,
+                                      * implicit
+                                      */
+#define ASI_ST_BLKINIT_MRU_S    0xf2 /* (NG4) init-store, twin load,
+                                      * Most-Recently-Used, secondary,
+                                      * implicit
+                                      */
+#define ASI_BLK_PL              0xf8 /* Primary, blk ld/st, little      */
+#define ASI_BLK_SL              0xf9 /* Secondary, blk ld/st, little    */
+#define ASI_ST_BLKINIT_MRU_PL   0xfa /* (NG4) init-store, twin load,
+                                      * Most-Recently-Used, primary,
+                                      * implicit, little-endian
+                                      */
+#define ASI_ST_BLKINIT_MRU_SL   0xfb /* (NG4) init-store, twin load,
+                                      * Most-Recently-Used, secondary,
+                                      * implicit, little-endian
+                                      */
 
 #endif /* SPARC_ASI_H */
-- 
2.39.5


