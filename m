Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61969CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 12:56:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwKLl-00079g-Ld; Wed, 10 Sep 2025 08:55:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshinimageswari@gmail.com>)
 id 1uwIN7-0006jN-Ta; Wed, 10 Sep 2025 06:48:18 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <harshinimageswari@gmail.com>)
 id 1uwIN2-0008TO-Tz; Wed, 10 Sep 2025 06:48:17 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-76e4f2e4c40so5299376b3a.2; 
 Wed, 10 Sep 2025 03:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757501289; x=1758106089; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FLa4MwxaILfd+tde1elZfYPMZl+/whcm16ArGGz7r6c=;
 b=g/uOC7Jylu48Ci1fio2f+pdFuNFJ9KvQuKUwegYnQebCLu1wrgs8wGBGqVkVlNvBLZ
 1TjumYu6gh/WFzV62LNrj36Nvt72iGQv2d+t7pe8Xi9yG5lU65RpheLPKVZJo/R34e18
 MQt7dWHENrUgJ2CjmJ1NUswpOkimpsikzhWWsEJ0/Y+Vgn/cTcEBvsIuc93MVxNUhLpm
 rO5LycYqV1YQ9nT4JlSOVJKpWm17LDdBp0q367nFdfFG6HxSNq7nFsghT38ZyivxzEs6
 y0tvVipmZo+InwGZ7FmjapVDcyxioqMfjpsnNAycRevplHH6p88JeVpp5Z2BdCLOhTSc
 sVng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757501289; x=1758106089;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FLa4MwxaILfd+tde1elZfYPMZl+/whcm16ArGGz7r6c=;
 b=Hn8BE0kUfGWht58+HpLvoQ9ngLJi7BhUqe14E2Hjz4elmjVoFK1M90CEgBjyPCCmoN
 1p8V9UF7fUuN/g9NFCua9wle3kaNTylMmrsGuDNd4R84h1FSl9ORQ5voE02pH9/KFiGL
 E2Tw1KVk9d7ufSI1OAdTZBpQqnBDFSuBxb4+2E7LyNIBDNlUQBLHi1eSy0mPmOrpKfCq
 EImV9BNCCqQ+S7SlnDjJ8kxg1PtUqxKx07PTA39ee1YG8p8WHd85oC1wvMnHibwu11N8
 evyTD4nKaVyVy++iNBh7FA6TWfPCSWdCqdWOltk4gmiFAQTNU2INGNbxmcfiUkBE8WE6
 edpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1MrbZ4i7qW02CyqUTPE+3vwB+X3YCzgS8Cd8ENAWP18rxZ9Q1iLif4yDvs0I8LuGOWxF9f3ud9g==@nongnu.org
X-Gm-Message-State: AOJu0YyGfZ3PoAjzJYUJCdCgkgmSRWYRBHqhaXe7BIgSADXeKN4CujnJ
 tMmK4nt9k/7QkIsRCSA1383dd1W77+QAp0h1QId+WHbavt42+jLzCTJjbV2sZLS8uOE=
X-Gm-Gg: ASbGnctW5l9gbwVclJJypgDAKIFPxUw6DHgELT21fXAeVrw52PxAMpQi1WMLzPulUIV
 0okh65lzP9fccdpZoaEx2WZjpXV1Mt+/YiR65CUnhR9Zf9SK4dru4CaTkFRM3MAk433OS3lu1jB
 8eP1a3DnV9lFkVRFTWywzeJk+iM0iOJHhNPhUZLaon3+1TsxB+zX7e7FqPsy8OemZU5DZwUdDSV
 gD4xTUSx7kF32FyXPsiqvgB0ecN6c2JZMWT4g9Wsjz5Zdvpa5QTxaOX6bEZ3woVlKp+bhJ6jhjv
 lAZyha4xgeq2nV+1/0rDVsZjWF0Vl95pIy0Tg/F3albFkZq/qNeUNNCOOk6VG7EtSvOLNWG9iue
 iyJqEaW31VT92CaCB86NGJSmn23sr0DqM/Yb3JA==
X-Google-Smtp-Source: AGHT+IGSvkZ5vBB9zpdfWlqt0Yxv5aARSZwnrfCG8sqCXQKtIGI586ZpMqL6Szez/GmdnZh+8ZWR0w==
X-Received: by 2002:a05:6a00:3c90:b0:772:f23:f9f with SMTP id
 d2e1a72fcca58-7742ded55a4mr18161703b3a.29.1757501287650; 
 Wed, 10 Sep 2025 03:48:07 -0700 (PDT)
Received: from LX-PG021SM7.. ([2402:3a80:41c:a3e0:f860:979b:5342:a805])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-774660eab98sm4694106b3a.5.2025.09.10.03.48.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 03:48:07 -0700 (PDT)
From: Harshini <harshinimageswari@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, qemu-arm@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Harshini <harshinimageswari@gmail.com>
Subject: [PATCH v2] tree-wide: replace tabs with sapce and align code This
 patch updates by replacing the tabs with spaces and fixing alignment issues
 Signed-off-by: Harshini <harshinimageswari@gmail.com> Signed-off-by: Akshaya
 S <akshayasankarr@gmail.com> Signed-off-by: Sri Vishnu
 <108srivishnu1008@gmail.com>
Date: Wed, 10 Sep 2025 16:18:36 +0530
Message-ID: <20250910104836.449429-1-harshinimageswari@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=harshinimageswari@gmail.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 10 Sep 2025 08:54:57 -0400
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

Signed-off-by: Harshini <harshinimageswari@gmail.com>
---
 target/alpha/cpu.h               |   6 +-
 target/i386/cpu.h                | 330 +++++++++----------
 target/i386/svm.h                | 334 +++++++++----------
 target/microblaze/cpu.h          |  20 +-
 tests/tcg/alpha/test-cond.c      |  36 +-
 tests/tcg/arm/hello-arm.c        | 160 ++++-----
 tests/tcg/i386/test-i386-ssse3.c |  92 +++---
 tests/tcg/i386/test-i386.c       |  52 +--
 tests/tcg/mips/hello-mips.c      |  28 +-
 tests/tcg/multiarch/sha1.c       |   5 +-
 tests/tcg/multiarch/test-mmap.c  | 547 ++++++++++++++++---------------
 11 files changed, 805 insertions(+), 805 deletions(-)

diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index 45944e46b5..a037ee9091 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -311,9 +311,9 @@ enum {
 };
 
 /* Alpha-specific interrupt pending bits.  */
-#define CPU_INTERRUPT_TIMER	CPU_INTERRUPT_TGT_EXT_0
-#define CPU_INTERRUPT_SMP	CPU_INTERRUPT_TGT_EXT_1
-#define CPU_INTERRUPT_MCHK	CPU_INTERRUPT_TGT_EXT_2
+#define CPU_INTERRUPT_TIMER    CPU_INTERRUPT_TGT_EXT_0
+#define CPU_INTERRUPT_SMP      CPU_INTERRUPT_TGT_EXT_1
+#define CPU_INTERRUPT_MCHK     CPU_INTERRUPT_TGT_EXT_2
 
 /* OSF/1 Page table bits.  */
 enum {
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index f977fc49a7..368e0a342c 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -52,8 +52,8 @@ enum {
     R_EBP = 5,
     R_ESI = 6,
     R_EDI = 7,
-    R_R8 = 8,
-    R_R9 = 9,
+    R_R8 =  8,
+    R_R9 =  9,
     R_R10 = 10,
     R_R11 = 11,
     R_R12 = 12,
@@ -72,14 +72,14 @@ enum {
 };
 
 typedef enum X86Seg {
-    R_ES = 0,
-    R_CS = 1,
-    R_SS = 2,
-    R_DS = 3,
-    R_FS = 4,
-    R_GS = 5,
+    R_ES =   0,
+    R_CS =   1,
+    R_SS =   2,
+    R_DS =   3,
+    R_FS =   4,
+    R_GS =   5,
     R_LDTR = 6,
-    R_TR = 7,
+    R_TR =   7,
 } X86Seg;
 
 /* segment descriptor fields */
@@ -246,18 +246,18 @@ typedef enum X86Seg {
 #define CR4_OSFXSR_SHIFT 9
 #define CR4_OSFXSR_MASK (1U << CR4_OSFXSR_SHIFT)
 #define CR4_OSXMMEXCPT_MASK  (1U << 10)
-#define CR4_UMIP_MASK   (1U << 11)
-#define CR4_LA57_MASK   (1U << 12)
-#define CR4_VMXE_MASK   (1U << 13)
-#define CR4_SMXE_MASK   (1U << 14)
+#define CR4_UMIP_MASK     (1U << 11)
+#define CR4_LA57_MASK     (1U << 12)
+#define CR4_VMXE_MASK     (1U << 13)
+#define CR4_SMXE_MASK     (1U << 14)
 #define CR4_FSGSBASE_MASK (1U << 16)
-#define CR4_PCIDE_MASK  (1U << 17)
-#define CR4_OSXSAVE_MASK (1U << 18)
-#define CR4_SMEP_MASK   (1U << 20)
-#define CR4_SMAP_MASK   (1U << 21)
-#define CR4_PKE_MASK   (1U << 22)
-#define CR4_PKS_MASK   (1U << 24)
-#define CR4_LAM_SUP_MASK (1U << 28)
+#define CR4_PCIDE_MASK    (1U << 17)
+#define CR4_OSXSAVE_MASK  (1U << 18) target/i386/cpu.h
+#define CR4_SMEP_MASK     (1U << 20)
+#define CR4_SMAP_MASK     (1U << 21)
+#define CR4_PKE_MASK      (1U << 22)
+#define CR4_PKS_MASK      (1U << 24)
+#define CR4_LAM_SUP_MASK  (1U << 28)
 
 #ifdef TARGET_X86_64
 #define CR4_FRED_MASK   (1ULL << 32)
@@ -280,15 +280,15 @@ typedef enum X86Seg {
 #define DR6_BT          (1 << 15)
 #define DR6_FIXED_1     0xffff0ff0
 
-#define DR7_GD          (1 << 13)
-#define DR7_TYPE_SHIFT  16
-#define DR7_LEN_SHIFT   18
-#define DR7_FIXED_1     0x00000400
+#define DR7_GD               (1 << 13)
+#define DR7_TYPE_SHIFT       16
+#define DR7_LEN_SHIFT        18
+#define DR7_FIXED_1          0x00000400
 #define DR7_GLOBAL_BP_MASK   0xaa
 #define DR7_LOCAL_BP_MASK    0x55
 #define DR7_MAX_BP           4
 #define DR7_TYPE_BP_INST     0x0
-#define DR7_TYPE_DATA_WR     0x1
+#define DR7_TYPE_D target/i386/cpu.hATA_WR     0x1
 #define DR7_TYPE_IO_RW       0x2
 #define DR7_TYPE_DATA_RW     0x3
 
@@ -399,12 +399,12 @@ typedef enum X86Seg {
 #define MSR_IA32_CORE_CAPABILITY        0xcf
 
 #define MSR_IA32_ARCH_CAPABILITIES      0x10a
-#define ARCH_CAP_TSX_CTRL_MSR		(1<<7)
-
+#define ARCH_CAP_TSX_CTRL_MSR           (1<<7)
+ target/i386/cpu.h
 #define MSR_IA32_PERF_CAPABILITIES      0x345
 #define PERF_CAP_LBR_FMT                0x3f
 
-#define MSR_IA32_TSX_CTRL		0x122
+#define MSR_IA32_TSX_CTRL               0x122
 #define MSR_IA32_TSCDEADLINE            0x6e0
 #define MSR_IA32_PKRS                   0x6e1
 #define MSR_RAPL_POWER_UNIT             0x00000606
@@ -554,24 +554,24 @@ typedef enum X86Seg {
 #define MSR_IA32_XSS                    0x00000da0
 #define MSR_IA32_UMWAIT_CONTROL         0xe1
 
-#define MSR_IA32_VMX_BASIC              0x00000480
-#define MSR_IA32_VMX_PINBASED_CTLS      0x00000481
-#define MSR_IA32_VMX_PROCBASED_CTLS     0x00000482
-#define MSR_IA32_VMX_EXIT_CTLS          0x00000483
-#define MSR_IA32_VMX_ENTRY_CTLS         0x00000484
-#define MSR_IA32_VMX_MISC               0x00000485
-#define MSR_IA32_VMX_CR0_FIXED0         0x00000486
-#define MSR_IA32_VMX_CR0_FIXED1         0x00000487
-#define MSR_IA32_VMX_CR4_FIXED0         0x00000488
-#define MSR_IA32_VMX_CR4_FIXED1         0x00000489
-#define MSR_IA32_VMX_VMCS_ENUM          0x0000048a
-#define MSR_IA32_VMX_PROCBASED_CTLS2    0x0000048b
-#define MSR_IA32_VMX_EPT_VPID_CAP       0x0000048c
+#define MSR_IA32_VMX_BASIC               0x00000480
+#define MSR_IA32_VMX_PINBASED_CTLS       0x00000481
+#define MSR_IA32_VMX_PROCBASED_CTLS      0x00000482
+#define MSR_IA32_VMX_EXIT_CTLS           0x00000483
+#define MSR_IA32_VMX_ENTRY_CTLS          0x00000484
+#define MSR_IA32_VMX_MISC                0x00000485
+#define MSR_IA32_VMX_CR0_FIXED0          0x00000486
+#define MSR_IA32_VMX_CR0_FIXED1          0x00000487
+#define MSR_IA32_VMX_CR4_FIXED0          0x00000488
+#define MSR_IA32_VMX_CR4_FIXED1          0x00000489
+#define MSR_IA32_VMX_VMCS_ENUM           0x0000048a
+#define MSR_IA32_VMX_PROCBASED_CTLS2     0x0000048b
+#define MSR_IA32_VMX_EPT_VPID_CAP        0x0000048c
 #define MSR_IA32_VMX_TRUE_PINBASED_CTLS  0x0000048d
 #define MSR_IA32_VMX_TRUE_PROCBASED_CTLS 0x0000048e
 #define MSR_IA32_VMX_TRUE_EXIT_CTLS      0x0000048f
 #define MSR_IA32_VMX_TRUE_ENTRY_CTLS     0x00000490
-#define MSR_IA32_VMX_VMFUNC             0x00000491
+#define MSR_IA32_VMX_VMFUNC              0x00000491
 
 #define MSR_APIC_START                  0x00000800
 #define MSR_APIC_END                    0x000008ff
@@ -666,8 +666,8 @@ typedef enum FeatureWord {
     FEAT_SGX_12_0_EAX,  /* CPUID[EAX=0x12,ECX=0].EAX (SGX) */
     FEAT_SGX_12_0_EBX,  /* CPUID[EAX=0x12,ECX=0].EBX (SGX MISCSELECT[31:0]) */
     FEAT_SGX_12_1_EAX,  /* CPUID[EAX=0x12,ECX=1].EAX (SGX ATTRIBUTES[31:0]) */
-    FEAT_XSAVE_XSS_LO,     /* CPUID[EAX=0xd,ECX=1].ECX */
-    FEAT_XSAVE_XSS_HI,     /* CPUID[EAX=0xd,ECX=1].EDX */
+    FEAT_XSAVE_XSS_LO,  /* CPUID[EAX=0xd,ECX=1].ECX */
+    FEAT_XSAVE_XSS_HI,  /* CPUID[EAX=0xd,ECX=1].EDX */
     FEAT_7_1_ECX,       /* CPUID[EAX=7,ECX=1].ECX */
     FEAT_7_1_EDX,       /* CPUID[EAX=7,ECX=1].EDX */
     FEAT_7_2_EDX,       /* CPUID[EAX=7,ECX=2].EDX */
@@ -688,59 +688,59 @@ typedef uint64_t FeatureWordArray[FEATURE_WORDS];
 uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 
 /* cpuid_features bits */
-#define CPUID_FP87 (1U << 0)
-#define CPUID_VME  (1U << 1)
-#define CPUID_DE   (1U << 2)
-#define CPUID_PSE  (1U << 3)
-#define CPUID_TSC  (1U << 4)
-#define CPUID_MSR  (1U << 5)
-#define CPUID_PAE  (1U << 6)
-#define CPUID_MCE  (1U << 7)
-#define CPUID_CX8  (1U << 8)
-#define CPUID_APIC (1U << 9)
-#define CPUID_SEP  (1U << 11) /* sysenter/sysexit */
-#define CPUID_MTRR (1U << 12)
-#define CPUID_PGE  (1U << 13)
-#define CPUID_MCA  (1U << 14)
-#define CPUID_CMOV (1U << 15)
-#define CPUID_PAT  (1U << 16)
+#define CPUID_FP87    (1U << 0)
+#define CPUID_VME     (1U << 1)
+#define CPUID_DE      (1U << 2)
+#define CPUID_PSE     (1U << 3)
+#define CPUID_TSC     (1U << 4)
+#define CPUID_MSR     (1U << 5)
+#define CPUID_PAE     (1U << 6)
+#define CPUID_MCE     (1U << 7)
+#define CPUID_CX8     (1U << 8)
+#define CPUID_APIC    (1U << 9)
+#define CPUID_SEP     (1U << 11) /* sysenter/sysexit */
+#define CPUID_MTRR    (1U << 12)
+#define CPUID_PGE     (1U << 13)
+#define CPUID_MCA     (1U << 14)
+#define CPUID_CMOV    (1U << 15)
+#define CPUID_PAT     (1U << 16)
 #define CPUID_PSE36   (1U << 17)
-#define CPUID_PN   (1U << 18)
+#define CPUID_PN      (1U << 18)
 #define CPUID_CLFLUSH (1U << 19)
-#define CPUID_DTS (1U << 21)
-#define CPUID_ACPI (1U << 22)
-#define CPUID_MMX  (1U << 23)
-#define CPUID_FXSR (1U << 24)
-#define CPUID_SSE  (1U << 25)
-#define CPUID_SSE2 (1U << 26)
-#define CPUID_SS (1U << 27)
-#define CPUID_HT (1U << 28)
-#define CPUID_TM (1U << 29)
-#define CPUID_IA64 (1U << 30)
-#define CPUID_PBE (1U << 31)
-
-#define CPUID_EXT_SSE3     (1U << 0)
+#define CPUID_DTS     (1U << 21)
+#define CPUID_ACPI    (1U << 22)
+#define CPUID_MMX     (1U << 23)
+#define CPUID_FXSR    (1U << 24)
+#define CPUID_SSE     (1U << 25)
+#define CPUID_SSE2    (1U << 26)
+#define CPUID_SS      (1U << 27)
+#define CPUID_HT      (1U << 28)
+#define CPUID_TM      (1U << 29)
+#define CPUID_IA64    (1U << 30)
+#define CPUID_PBE     (1U << 31)
+
+#define CPUID_EXT_SSE3      (1U << 0)
 #define CPUID_EXT_PCLMULQDQ (1U << 1)
-#define CPUID_EXT_DTES64   (1U << 2)
-#define CPUID_EXT_MONITOR  (1U << 3)
-#define CPUID_EXT_DSCPL    (1U << 4)
-#define CPUID_EXT_VMX      (1U << 5)
-#define CPUID_EXT_SMX      (1U << 6)
-#define CPUID_EXT_EST      (1U << 7)
-#define CPUID_EXT_TM2      (1U << 8)
-#define CPUID_EXT_SSSE3    (1U << 9)
-#define CPUID_EXT_CID      (1U << 10)
-#define CPUID_EXT_FMA      (1U << 12)
-#define CPUID_EXT_CX16     (1U << 13)
-#define CPUID_EXT_XTPR     (1U << 14)
-#define CPUID_EXT_PDCM     (1U << 15)
-#define CPUID_EXT_PCID     (1U << 17)
-#define CPUID_EXT_DCA      (1U << 18)
-#define CPUID_EXT_SSE41    (1U << 19)
-#define CPUID_EXT_SSE42    (1U << 20)
-#define CPUID_EXT_X2APIC   (1U << 21)
-#define CPUID_EXT_MOVBE    (1U << 22)
-#define CPUID_EXT_POPCNT   (1U << 23)
+#define CPUID_EXT_DTES64    (1U << 2)
+#define CPUID_EXT_MONITOR   (1U << 3)
+#define CPUID_EXT_DSCPL     (1U << 4)
+#define CPUID_EXT_VMX       (1U << 5)
+#define CPUID_EXT_SMX       (1U << 6)
+#define CPUID_EXT_EST       (1U << 7)
+#define CPUID_EXT_TM2       (1U << 8)
+#define CPUID_EXT_SSSE3     (1U << 9)
+#define CPUID_EXT_CID       (1U << 10)
+#define CPUID_EXT_FMA       (1U << 12)
+#define CPUID_EXT_CX16      (1U << 13)
+#define CPUID_EXT_XTPR      (1U << 14)
+#define CPUID_EXT_PDCM      (1U << 15)
+#define CPUID_EXT_PCID      (1U << 17)
+#define CPUID_EXT_DCA       (1U << 18)
+#define CPUID_EXT_SSE41     (1U << 19)
+#define CPUID_EXT_SSE42     (1U << 20)
+#define CPUID_EXT_X2APIC    (1U << 21)
+#define CPUID_EXT_MOVBE     (1U << 22)
+#define CPUID_EXT_POPCNT    (1U << 23)
 #define CPUID_EXT_TSC_DEADLINE_TIMER (1U << 24)
 #define CPUID_EXT_AES      (1U << 25)
 #define CPUID_EXT_XSAVE    (1U << 26)
@@ -750,34 +750,34 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define CPUID_EXT_RDRAND   (1U << 30)
 #define CPUID_EXT_HYPERVISOR  (1U << 31)
 
-#define CPUID_EXT2_FPU     (1U << 0)
-#define CPUID_EXT2_VME     (1U << 1)
-#define CPUID_EXT2_DE      (1U << 2)
-#define CPUID_EXT2_PSE     (1U << 3)
-#define CPUID_EXT2_TSC     (1U << 4)
-#define CPUID_EXT2_MSR     (1U << 5)
-#define CPUID_EXT2_PAE     (1U << 6)
-#define CPUID_EXT2_MCE     (1U << 7)
-#define CPUID_EXT2_CX8     (1U << 8)
-#define CPUID_EXT2_APIC    (1U << 9)
-#define CPUID_EXT2_SYSCALL (1U << 11)
-#define CPUID_EXT2_MTRR    (1U << 12)
-#define CPUID_EXT2_PGE     (1U << 13)
-#define CPUID_EXT2_MCA     (1U << 14)
-#define CPUID_EXT2_CMOV    (1U << 15)
-#define CPUID_EXT2_PAT     (1U << 16)
-#define CPUID_EXT2_PSE36   (1U << 17)
-#define CPUID_EXT2_MP      (1U << 19)
-#define CPUID_EXT2_NX      (1U << 20)
-#define CPUID_EXT2_MMXEXT  (1U << 22)
-#define CPUID_EXT2_MMX     (1U << 23)
-#define CPUID_EXT2_FXSR    (1U << 24)
-#define CPUID_EXT2_FFXSR   (1U << 25)
-#define CPUID_EXT2_PDPE1GB (1U << 26)
-#define CPUID_EXT2_RDTSCP  (1U << 27)
-#define CPUID_EXT2_LM      (1U << 29)
+#define CPUID_EXT2_FPU      (1U << 0)
+#define CPUID_EXT2_VME      (1U << 1)
+#define CPUID_EXT2_DE       (1U << 2)
+#define CPUID_EXT2_PSE      (1U << 3)
+#define CPUID_EXT2_TSC      (1U << 4)
+#define CPUID_EXT2_MSR      (1U << 5)
+#define CPUID_EXT2_PAE      (1U << 6)
+#define CPUID_EXT2_MCE      (1U << 7)
+#define CPUID_EXT2_CX8      (1U << 8)
+#define CPUID_EXT2_APIC     (1U << 9)
+#define CPUID_EXT2_SYSCALL  (1U << 11)
+#define CPUID_EXT2_MTRR     (1U << 12)
+#define CPUID_EXT2_PGE      (1U << 13)
+#define CPUID_EXT2_MCA      (1U << 14)
+#define CPUID_EXT2_CMOV     (1U << 15)
+#define CPUID_EXT2_PAT      (1U << 16)
+#define CPUID_EXT2_PSE36    (1U << 17)
+#define CPUID_EXT2_MP       (1U << 19)
+#define CPUID_EXT2_NX       (1U << 20)
+#define CPUID_EXT2_MMXEXT   (1U << 22)
+#define CPUID_EXT2_MMX      (1U << 23)
+#define CPUID_EXT2_FXSR     (1U << 24)
+#define CPUID_EXT2_FFXSR    (1U << 25)
+#define CPUID_EXT2_PDPE1GB  (1U << 26)
+#define CPUID_EXT2_RDTSCP   (1U << 27)
+#define CPUID_EXT2_LM       (1U << 29)
 #define CPUID_EXT2_3DNOWEXT (1U << 30)
-#define CPUID_EXT2_3DNOW   (1U << 31)
+#define CPUID_EXT2_3DNOW    (1U << 31)
 
 /* CPUID[8000_0001].EDX bits that are aliases of CPUID[1].EDX bits on AMD CPUs */
 #define CPUID_EXT2_AMD_ALIASES (CPUID_EXT2_FPU | CPUID_EXT2_VME | \
@@ -790,28 +790,28 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
                                 CPUID_EXT2_PAT | CPUID_EXT2_PSE36 | \
                                 CPUID_EXT2_MMX | CPUID_EXT2_FXSR)
 
-#define CPUID_EXT3_LAHF_LM (1U << 0)
-#define CPUID_EXT3_CMP_LEG (1U << 1)
-#define CPUID_EXT3_SVM     (1U << 2)
-#define CPUID_EXT3_EXTAPIC (1U << 3)
-#define CPUID_EXT3_CR8LEG  (1U << 4)
-#define CPUID_EXT3_ABM     (1U << 5)
-#define CPUID_EXT3_SSE4A   (1U << 6)
+#define CPUID_EXT3_LAHF_LM  (1U << 0)
+#define CPUID_EXT3_CMP_LEG  (1U << 1)
+#define CPUID_EXT3_SVM      (1U << 2)
+#define CPUID_EXT3_EXTAPIC  (1U << 3)
+#define CPUID_EXT3_CR8LEG   (1U << 4)
+#define CPUID_EXT3_ABM      (1U << 5)
+#define CPUID_EXT3_SSE4A    (1U << 6)
 #define CPUID_EXT3_MISALIGNSSE (1U << 7)
 #define CPUID_EXT3_3DNOWPREFETCH (1U << 8)
-#define CPUID_EXT3_OSVW    (1U << 9)
-#define CPUID_EXT3_IBS     (1U << 10)
-#define CPUID_EXT3_XOP     (1U << 11)
-#define CPUID_EXT3_SKINIT  (1U << 12)
-#define CPUID_EXT3_WDT     (1U << 13)
-#define CPUID_EXT3_LWP     (1U << 15)
-#define CPUID_EXT3_FMA4    (1U << 16)
-#define CPUID_EXT3_TCE     (1U << 17)
-#define CPUID_EXT3_NODEID  (1U << 19)
-#define CPUID_EXT3_TBM     (1U << 21)
-#define CPUID_EXT3_TOPOEXT (1U << 22)
+#define CPUID_EXT3_OSVW     (1U << 9)
+#define CPUID_EXT3_IBS      (1U << 10)
+#define CPUID_EXT3_XOP      (1U << 11)
+#define CPUID_EXT3_SKINIT   (1U << 12)
+#define CPUID_EXT3_WDT      (1U << 13)
+#define CPUID_EXT3_LWP      (1U << 15)
+#define CPUID_EXT3_FMA4     (1U << 16)
+#define CPUID_EXT3_TCE      (1U << 17)
+#define CPUID_EXT3_NODEID   (1U << 19)
+#define CPUID_EXT3_TBM      (1U << 21)
+#define CPUID_EXT3_TOPOEXT  (1U << 22)
 #define CPUID_EXT3_PERFCORE (1U << 23)
-#define CPUID_EXT3_PERFNB  (1U << 24)
+#define CPUID_EXT3_PERFNB   (1U << 24)
 
 #define CPUID_SVM_NPT             (1U << 0)
 #define CPUID_SVM_LBRV            (1U << 1)
@@ -1050,7 +1050,7 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 
 /* RAS Features */
 #define CPUID_8000_0007_EBX_OVERFLOW_RECOV    (1U << 0)
-#define CPUID_8000_0007_EBX_SUCCOR      (1U << 1)
+#define CPUID_8000_0007_EBX_SUCCOR            (1U << 1)
 
 /* (Old) KVM paravirtualized clocksource */
 #define CPUID_KVM_CLOCK            (1U << KVM_FEATURE_CLOCKSOURCE)
@@ -1072,7 +1072,7 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define CPUID_KVM_MSI_EXT_DEST_ID  (1U << KVM_FEATURE_MSI_EXT_DEST_ID)
 
 /* Hint to KVM that vCPUs expect never preempted for an unlimited time */
-#define CPUID_KVM_HINTS_REALTIME    (1U << KVM_HINTS_REALTIME)
+#define CPUID_KVM_HINTS_REALTIME   (1U << KVM_HINTS_REALTIME)
 
 /* CLZERO instruction */
 #define CPUID_8000_0008_EBX_CLZERO      (1U << 0)
@@ -1379,27 +1379,27 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define HYPERV_FEAT_TLBFLUSH_DIRECT     20
 
 #ifndef HYPERV_SPINLOCK_NEVER_NOTIFY
-#define HYPERV_SPINLOCK_NEVER_NOTIFY             0xFFFFFFFF
+#define HYPERV_SPINLOCK_NEVER_NOTIFY     0xFFFFFFFF
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
+#define EXCP00_DIVZ    0
+#define EXCP01_DB      1
+#define EXCP02_NMI     2
+#define EXCP03_INT3    3
+#define EXCP04_INTO    4
+#define EXCP05_BOUND   5
+#define EXCP06_ILLOP   6
+#define EXCP07_PREX    7
+#define EXCP08_DBLE    8
+#define EXCP09_XERR    9
+#define EXCP0A_TSS     10
+#define EXCP0B_NOSEG   11
+#define EXCP0C_STACK   12
+#define EXCP0D_GPF     13
+#define EXCP0E_PAGE    14
+#define EXCP10_COPR    16
+#define EXCP11_ALGN    17
+#define EXCP12_MCHK    18
 
 #define EXCP_VMEXIT     0x100 /* only for system emulation */
 #define EXCP_SYSCALL    0x101 /* only for user emulation */
@@ -1428,9 +1428,9 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
  */
 typedef enum {
     CC_OP_EFLAGS = 0,  /* all cc are explicitly computed, CC_SRC = flags */
-    CC_OP_ADCX = 1,    /* CC_DST = C, CC_SRC = rest.  */
-    CC_OP_ADOX = 2,    /* CC_SRC2 = O, CC_SRC = rest.  */
-    CC_OP_ADCOX = 3,   /* CC_DST = C, CC_SRC2 = O, CC_SRC = rest.  */
+    CC_OP_ADCX =   1,    /* CC_DST = C, CC_SRC = rest.  */
+    CC_OP_ADOX =   2,    /* CC_SRC2 = O, CC_SRC = rest.  */
+    CC_OP_ADCOX =  3,   /* CC_DST = C, CC_SRC2 = O, CC_SRC = rest.  */
 
     /* Low 2 bits = MemOp constant for the size */
 #define CC_OP_FIRST_BWLQ CC_OP_MULB
@@ -2590,7 +2590,7 @@ static inline AddressSpace *cpu_addressspace(CPUState *cs, MemTxAttrs attrs)
  * checks with cpuid bits?
  */
 void cpu_load_efer(CPUX86State *env, uint64_t val);
-uint8_t x86_ldub_phys(CPUState *cs, hwaddr addr);
+uint8_t  x86_ldub_phys(CPUState *cs, hwaddr addr);
 uint32_t x86_lduw_phys(CPUState *cs, hwaddr addr);
 uint32_t x86_ldl_phys(CPUState *cs, hwaddr addr);
 uint64_t x86_ldq_phys(CPUState *cs, hwaddr addr);
diff --git a/target/i386/svm.h b/target/i386/svm.h
index 1bd7844730..fcf04ce78c 100644
--- a/target/i386/svm.h
+++ b/target/i386/svm.h
@@ -1,7 +1,7 @@
 #ifndef SVM_H
 #define SVM_H
 
-#define TLB_CONTROL_DO_NOTHING 0
+#define TLB_CONTROL_DO_NOTHING     0
 #define TLB_CONTROL_FLUSH_ALL_ASID 1
 
 #define V_TPR_MASK 0x0f
@@ -16,28 +16,28 @@
 #define V_GIF_MASK (1 << V_GIF_SHIFT)
 
 #define V_INTR_PRIO_SHIFT 16
-#define V_INTR_PRIO_MASK (0x0f << V_INTR_PRIO_SHIFT)
+#define V_INTR_PRIO_MASK  (0x0f << V_INTR_PRIO_SHIFT)
 
 #define V_IGN_TPR_SHIFT 20
-#define V_IGN_TPR_MASK (1 << V_IGN_TPR_SHIFT)
+#define V_IGN_TPR_MASK  (1 << V_IGN_TPR_SHIFT)
 
 #define V_INTR_MASKING_SHIFT 24
-#define V_INTR_MASKING_MASK (1 << V_INTR_MASKING_SHIFT)
+#define V_INTR_MASKING_MASK  (1 << V_INTR_MASKING_SHIFT)
 
 #define V_VMLOAD_VMSAVE_ENABLED_MASK (1 << 1)
 
 #define SVM_INTERRUPT_SHADOW_MASK 1
 
-#define SVM_IOIO_STR_SHIFT 2
-#define SVM_IOIO_REP_SHIFT 3
-#define SVM_IOIO_SIZE_SHIFT 4
+#define SVM_IOIO_STR_SHIFT   2
+#define SVM_IOIO_REP_SHIFT   3
+#define SVM_IOIO_SIZE_SHIFT  4
 #define SVM_IOIO_ASIZE_SHIFT 7
 
 #define SVM_IOIO_TYPE_MASK 1
 #define SVM_IOIO_STR_MASK (1 << SVM_IOIO_STR_SHIFT)
 #define SVM_IOIO_REP_MASK (1 << SVM_IOIO_REP_SHIFT)
-#define SVM_IOIO_SIZE_MASK (7 << SVM_IOIO_SIZE_SHIFT)
-#define SVM_IOIO_ASIZE_MASK (7 << SVM_IOIO_ASIZE_SHIFT)
+#define SVM_IOIO_SIZE_MASK(7 << SVM_IOIO_SIZE_SHIFT)
+#define SVM_IOIO_ASIZE_MASK(7 << SVM_IOIO_ASIZE_SHIFT)
 
 #define SVM_EVTINJ_VEC_MASK 0xff
 
@@ -45,97 +45,97 @@
 #define SVM_EVTINJ_TYPE_MASK (7 << SVM_EVTINJ_TYPE_SHIFT)
 
 #define SVM_EVTINJ_TYPE_INTR (0 << SVM_EVTINJ_TYPE_SHIFT)
-#define SVM_EVTINJ_TYPE_NMI (2 << SVM_EVTINJ_TYPE_SHIFT)
-#define SVM_EVTINJ_TYPE_EXEPT (3 << SVM_EVTINJ_TYPE_SHIFT)
+#define SVM_EVTINJ_TYPE_NMI  (2 << SVM_EVTINJ_TYPE_SHIFT)
+#define SVM_EVTINJ_TYPE_EXEP (3 << SVM_EVTINJ_TYPE_SHIFT)
 #define SVM_EVTINJ_TYPE_SOFT (4 << SVM_EVTINJ_TYPE_SHIFT)
 
-#define SVM_EVTINJ_VALID (1 << 31)
+#define SVM_EVTINJ_VALID     (1 << 31)
 #define SVM_EVTINJ_VALID_ERR (1 << 11)
 
 #define SVM_EXITINTINFO_VEC_MASK SVM_EVTINJ_VEC_MASK
 
-#define	SVM_EXITINTINFO_TYPE_INTR SVM_EVTINJ_TYPE_INTR
-#define	SVM_EXITINTINFO_TYPE_NMI SVM_EVTINJ_TYPE_NMI
-#define	SVM_EXITINTINFO_TYPE_EXEPT SVM_EVTINJ_TYPE_EXEPT
-#define	SVM_EXITINTINFO_TYPE_SOFT SVM_EVTINJ_TYPE_SOFT
+#define   SVM_EXITINTINFO_TYPE_INTR SVM_EVTINJ_TYPE_INTR
+#define   SVM_EXITINTINFO_TYPE_NMI SVM_EVTINJ_TYPE_NMI
+#define   SVM_EXITINTINFO_TYPE_EXEPT SVM_EVTINJ_TYPE_EXEPT
+#define   SVM_EXITINTINFO_TYPE_SOFT SVM_EVTINJ_TYPE_SOFT
 
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
-#define SVM_EXIT_EXCP_BASE      0x040
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
+#define   SVM_EXIT_READ_CR0       0x000
+#define   SVM_EXIT_READ_CR3       0x003
+#define   SVM_EXIT_READ_CR4       0x004
+#define   SVM_EXIT_READ_CR8       0x008
+#define   SVM_EXIT_WRITE_CR0      0x010
+#define   SVM_EXIT_WRITE_CR3      0x013
+#define   SVM_EXIT_WRITE_CR4      0x014
+#define   SVM_EXIT_WRITE_CR8      0x018
+#define   SVM_EXIT_READ_DR0       0x020
+#define   SVM_EXIT_READ_DR1       0x021
+#define   SVM_EXIT_READ_DR2       0x022
+#define   SVM_EXIT_READ_DR3       0x023
+#define   SVM_EXIT_READ_DR4       0x024
+#define   SVM_EXIT_READ_DR5       0x025
+#define   SVM_EXIT_READ_DR6       0x026
+#define   SVM_EXIT_READ_DR7       0x027
+#define   SVM_EXIT_WRITE_DR0      0x030
+#define   SVM_EXIT_WRITE_DR1      0x031
+#define   SVM_EXIT_WRITE_DR2      0x032
+#define   SVM_EXIT_WRITE_DR3      0x033
+#define   SVM_EXIT_WRITE_DR4      0x034
+#define   SVM_EXIT_WRITE_DR5      0x035
+#define   SVM_EXIT_WRITE_DR       0x036
+#define   SVM_EXIT_WRITE_D7       0x037
+#define   SVM_EXIT_EXCP_BASE      0x040
+#define   SVM_EXIT_INTR           0x060
+#define   SVM_EXIT_NMI            0x061
+#define   SVM_EXIT_SMI            0x062
+#define   SVM_EXIT_INIT           0x063
+#define   SVM_EXIT_VINTR          0x064
+#define   SVM_EXIT_CR0_SEL_WRITE  0x065
+#define   SVM_EXIT_IDTR_READ      0x066
+#define   SVM_EXIT_GDTR_READ      0x067
+#define   SVM_EXIT_LDTR_READ      0x068
+#define   SVM_EXIT_TR_READ        0x069
+#define   SVM_EXIT_IDTR_WRITE     0x06a
+#define   SVM_EXIT_GDTR_WRITE     0x06b
+#define   SVM_EXIT_LDTR_WRITE     0x06c
+#define   SVM_EXIT_TR_WRITE       0x06d
+#define   SVM_EXIT_RDTSC          0x06e
+#define   SVM_EXIT_RDPMC          0x06f
+#define   SVM_EXIT_PUSHF          0x070
+#define   SVM_EXIT_POPF           0x071
+#define   SVM_EXIT_CPUID          0x072
+#define   SVM_EXIT_RSM            0x073
+#define   SVM_EXIT_IRET           0x074
+#define   SVM_EXIT_SWINT          0x075
+#define   SVM_EXIT_INVD           0x076
+#define   SVM_EXIT_PAUSE          0x077
+#define   SVM_EXIT_HLT            0x078
+#define   SVM_EXIT_INVLPG         0x079
+#define   SVM_EXIT_INVLPGA        0x07a
+#define   SVM_EXIT_IOIO           0x07b
+#define   SVM_EXIT_MSR            0x07c
+#define   SVM_EXIT_TASK_SWITCH    0x07d
+#define   SVM_EXIT_FERR_FREEZE    0x07e
+#define   SVM_EXIT_SHUTDOWN       0x07f
+#define   SVM_EXIT_VMRUN          0x080
+#define   SVM_EXIT_VMMCALL        0x081
+#define   SVM_EXIT_VMLOAD         0x082
+#define   SVM_EXIT_VMSAVE         0x083
+#define   SVM_EXIT_STGI           0x084
+#define   SVM_EXIT_CLGI           0x085
+#define   SVM_EXIT_SKINIT         0x086
+#define   SVM_EXIT_RDTSCP         0x087
+#define   SVM_EXIT_ICEBP          0x088
+#define   SVM_EXIT_WBINVD         0x089
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
+#define SVM_EXIT_ERR       -1
 
 #define SVM_CR0_SELECTIVE_MASK (1 << 3 | 1) /* TS and MP */
 
@@ -146,96 +146,96 @@
 
 #define SVM_CR0_RESERVED_MASK 0xffffffff00000000U
 
-#define SVM_MSRPM_SIZE		(1ULL << 13)
-#define SVM_IOPM_SIZE		((1ULL << 13) + 1)
+#define SVM_MSRPM_SIZE      (1ULL << 13)
+#define SVM_IOPM_SIZE       ((1ULL << 13) + 1)
 
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
+   uint16_t intercept_cr_read;
+   uint16_t intercept_cr_write;
+   uint16_t intercept_dr_read;
+   uint16_t intercept_dr_write;
+   uint32_t intercept_exceptions;
+   uint64_t intercept;
+   uint8_t  reserved_1[44];
+   uint64_t iopm_base_pa;
+   uint64_t msrpm_base_pa;
+   uint64_t tsc_offset;
+   uint32_t asid;
+   uint8_t  tlb_ctl;
+   uint8_t  reserved_2[3];
+   uint32_t int_ctl;
+   uint32_t int_vector;
+   uint32_t int_state;
+   uint8_t  reserved_3[4];
+   uint64_t exit_code;
+   uint64_t exit_info_1;
+   uint64_t exit_info_2;
+   uint32_t exit_int_info;
+   uint32_t exit_int_info_err;
+   uint64_t nested_ctl;
+   uint8_t  reserved_4[16];
+   uint32_t event_inj;
+   uint32_t event_inj_err;
+   uint64_t nested_cr3;
+   uint64_t lbr_ctl;
+   uint8_t  reserved_5[832];
 };
 
 struct QEMU_PACKED vmcb_seg {
-	uint16_t selector;
-	uint16_t attrib;
-	uint32_t limit;
-	uint64_t base;
+   uint16_t selector;
+   uint16_t attrib;
+   uint32_t limit;
+   uint64_t base;
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
+   struct vmcb_seg es;
+   struct vmcb_seg cs;
+   struct vmcb_seg ss;
+   struct vmcb_seg ds;
+   struct vmcb_seg fs;
+   struct vmcb_seg gs;
+   struct vmcb_seg gdtr;
+   struct vmcb_seg ldtr;
+   struct vmcb_seg idtr;
+   struct vmcb_seg tr;
+   uint8_t  reserved_1[43];
+   uint8_t  cpl;
+   uint8_t  reserved_2[4];
+   uint64_t efer;
+   uint8_t  reserved_3[112];
+   uint64_t cr4;
+   uint64_t cr3;
+   uint64_t cr0;
+   uint64_t dr7;
+   uint64_t dr6;
+   uint64_t rflags;
+   uint64_t rip;
+   uint8_t  reserved_4[88];
+   uint64_t rsp;
+   uint8_t  reserved_5[24];
+   uint64_t rax;
+   uint64_t star;
+   uint64_t lstar;
+   uint64_t cstar;
+   uint64_t sfmask;
+   uint64_t kernel_gs_base;
+   uint64_t sysenter_cs;
+   uint64_t sysenter_esp;
+   uint64_t sysenter_eip;
+   uint64_t cr2;
+   uint8_t  reserved_6[32];
+   uint64_t g_pat;
+   uint64_t dbgctl;
+   uint64_t br_from;
+   uint64_t br_to;
+   uint64_t last_excp_from;
+   uint64_t last_excp_to;
 };
 
 struct QEMU_PACKED vmcb {
-	struct vmcb_control_area control;
-	struct vmcb_save_area save;
+   struct vmcb_control_area control;
+   struct vmcb_save_area save;
 };
 
 #endif
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 3ce28b302f..54047de1e9 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -69,15 +69,15 @@ typedef struct CPUArchState CPUMBState;
 #define MSR_CC  (1<<31)
 
 /* Machine State Register (MSR) Fields */
-#define MSR_UM (1<<11) /* User Mode */
+#define MSR_UM         (1<<11) /* User Mode */
 #define MSR_UMS        (1<<12) /* User Mode Save */
-#define MSR_VM (1<<13) /* Virtual Mode */
+#define MSR_VM         (1<<13) /* Virtual Mode */
 #define MSR_VMS        (1<<14) /* Virtual Mode Save */
 
 #define MSR_KERNEL      MSR_EE|MSR_VM
-//#define MSR_USER     MSR_KERNEL|MSR_UM|MSR_IE
+//#define MSR_USER      MSR_KERNEL|MSR_UM|MSR_IE
 #define MSR_KERNEL_VMS  MSR_EE|MSR_VMS
-//#define MSR_USER_VMS MSR_KERNEL_VMS|MSR_UMS|MSR_IE
+//#define MSR_USER_VMS  MSR_KERNEL_VMS|MSR_UMS|MSR_IE
 
 /* Exception State Register (ESR) Fields */
 #define          ESR_DIZ       (1<<11) /* Zone Protection */
@@ -121,9 +121,9 @@ typedef struct CPUArchState CPUMBState;
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
@@ -270,10 +270,10 @@ struct CPUArchState {
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
diff --git a/tests/tcg/alpha/test-cond.c b/tests/tcg/alpha/test-cond.c
index 3e11c4c105..27be6ac4f9 100644
--- a/tests/tcg/alpha/test-cond.c
+++ b/tests/tcg/alpha/test-cond.c
@@ -2,28 +2,28 @@
 
 #ifdef TEST_CMOV
 
-#define TEST_COND(N) 				\
-int test_##N (long a)				\
-{						\
-  int res = 1;					\
-                                                \
-  asm ("cmov"#N" %1,$31,%0"			\
-       : "+r" (res) : "r" (a));			\
-  return !res;					\
+#define TEST_COND(N)                 \
+int test_##N (long a)                \
+{                                    \
+  int res = 1;                       \
+                                     \
+  asm ("cmov"#N" %1,$31,%0"          \
+       : "+r" (res) : "r" (a));      \
+  return !res;                       \
 }
 
 #else
 
-#define TEST_COND(N) 				\
-int test_##N (long a)				\
-{						\
-  int res = 1;					\
-                                                \
-  asm ("b"#N" %1,1f\n\t"			\
-       "addq $31,$31,%0\n\t"			\
-       "1: unop\n"				\
-       : "+r" (res) : "r" (a));			\
-  return res;					\
+#define TEST_COND(N)                 \
+int test_##N (long a)                \
+{                                    \
+  int res = 1;                       \
+                                     \
+  asm ("b"#N" %1,1f\n\t"             \
+       "addq $31,$31,%0\n\t"         \
+       "1: unop\n"                   \
+       : "+r" (res) : "r" (a));      \
+  return res;                        \
 }
 
 #endif
diff --git a/tests/tcg/arm/hello-arm.c b/tests/tcg/arm/hello-arm.c
index e33edf949f..16534060c3 100644
--- a/tests/tcg/arm/hello-arm.c
+++ b/tests/tcg/arm/hello-arm.c
@@ -1,6 +1,6 @@
-#define __NR_SYSCALL_BASE	0x900000
-#define __NR_exit1			(__NR_SYSCALL_BASE+  1)
-#define __NR_write			(__NR_SYSCALL_BASE+  4)
+#define __NR_SYSCALL_BASE     0x900000
+#define __NR_exit1            (__NR_SYSCALL_BASE+  1)
+#define __NR_write            (__NR_SYSCALL_BASE+  4)
 
 #define __sys2(x) #x
 #define __sys1(x) __sys2(x)
@@ -9,98 +9,98 @@
 #define __syscall(name) "swi\t" __sys1(__NR_##name) "\n\t"
 #endif
 
-#define __syscall_return(type, res)					\
-do {									\
-        return (type) (res);						\
+#define __syscall_return(type, res)            \
+do {                                           \
+        return (type) (res);                   \
 } while (0)
 
-#define _syscall0(type,name)						\
-type name(void) {							\
-  long __res;								\
-  __asm__ __volatile__ (						\
-  __syscall(name)							\
-  "mov %0,r0"								\
-  :"=r" (__res) : : "r0","lr");						\
-  __syscall_return(type,__res);						\
+#define _syscall0(type,name)                   \
+type name(void) {                              \ 
+  long __res;                                  \
+  __asm__ __volatile__ (                       \
+  __syscall(name)                              \
+  "mov %0,r0"                                  \ 
+  :"=r" (__res) : : "r0","lr");                \
+  __syscall_return(type,__res);                \
 }
 
-#define _syscall1(type,name,type1,arg1)					\
-type name(type1 arg1) {							\
-  long __res;								\
-  __asm__ __volatile__ (						\
-  "mov\tr0,%1\n\t"							\
-  __syscall(name)							\
-  "mov %0,r0"								\
-        : "=r" (__res)							\
-        : "r" ((long)(arg1))						\
-        : "r0","lr");							\
-  __syscall_return(type,__res);						\
+#define _syscall1(type,name,type1,arg1)        \
+type name(type1 arg1) {                        \
+  long __res;                                  \ 
+  __asm__ __volatile__ (                       \
+  "mov\tr0,%1\n\t"                             \
+  __syscall(name)                              \ 
+  "mov %0,r0"                                  \
+        : "=r" (__res)                         \
+        : "r" ((long)(arg1))                   \
+        : "r0","lr");                          \
+  __syscall_return(type,__res);                \
 }
 
-#define _syscall2(type,name,type1,arg1,type2,arg2)			\
-type name(type1 arg1,type2 arg2) {					\
-  long __res;								\
-  __asm__ __volatile__ (						\
-  "mov\tr0,%1\n\t"							\
-  "mov\tr1,%2\n\t"							\
-  __syscall(name)							\
-  "mov\t%0,r0"								\
-        : "=r" (__res)							\
-        : "r" ((long)(arg1)),"r" ((long)(arg2))				\
-        : "r0","r1","lr");						\
-  __syscall_return(type,__res);						\
+#define _syscall2(type,name,type1,arg1,type2,arg2)    \
+type name(type1 arg1,type2 arg2) {                    \
+  long __res;                                         \
+  __asm__ __volatile__ (                              \
+  "mov\tr0,%1\n\t"                                    \
+  "mov\tr1,%2\n\t"                                    \ 
+  __syscall(name)                                     \ 
+  "mov\t%0,r0"                                        \
+        : "=r" (__res)                                \
+        : "r" ((long)(arg1)),"r" ((long)(arg2))       \
+        : "r0","r1","lr");                            \
+  __syscall_return(type,__res);                       \
 }
 
 
-#define _syscall3(type,name,type1,arg1,type2,arg2,type3,arg3)		\
-type name(type1 arg1,type2 arg2,type3 arg3) {				\
-  long __res;								\
-  __asm__ __volatile__ (						\
-  "mov\tr0,%1\n\t"							\
-  "mov\tr1,%2\n\t"							\
-  "mov\tr2,%3\n\t"							\
-  __syscall(name)							\
-  "mov\t%0,r0"								\
-        : "=r" (__res)							\
-        : "r" ((long)(arg1)),"r" ((long)(arg2)),"r" ((long)(arg3))	\
-        : "r0","r1","r2","lr");						\
-  __syscall_return(type,__res);						\
+#define _syscall3(type,name,type1,arg1,type2,arg2,type3,arg3)        \
+type name(type1 arg1,type2 arg2,type3 arg3) {                        \
+  long __res;                                                        \
+  __asm__ __volatile__ (                                             \
+  "mov\tr0,%1\n\t"                                                   \
+  "mov\tr1,%2\n\t"                                                   \ 
+  "mov\tr2,%3\n\t"                                                   \
+  __syscall(name)                                                    \
+  "mov\t%0,r0"                                                       \
+        : "=r" (__res)                                               \
+        : "r" ((long)(arg1)),"r" ((long)(arg2)),"r" ((long)(arg3))   \
+        : "r0","r1","r2","lr");                                      \
+  __syscall_return(type,__res);                                      \
 }
 
 
-#define _syscall4(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4)		\
-type name(type1 arg1, type2 arg2, type3 arg3, type4 arg4) {				\
-  long __res;										\
-  __asm__ __volatile__ (								\
-  "mov\tr0,%1\n\t"									\
-  "mov\tr1,%2\n\t"									\
-  "mov\tr2,%3\n\t"									\
-  "mov\tr3,%4\n\t"									\
-  __syscall(name)									\
-  "mov\t%0,r0"										\
-        : "=r" (__res)									\
-        : "r" ((long)(arg1)),"r" ((long)(arg2)),"r" ((long)(arg3)),"r" ((long)(arg4))	\
-        : "r0","r1","r2","r3","lr");							\
-  __syscall_return(type,__res);								\
+#define _syscall4(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4)        \
+type name(type1 arg1, type2 arg2, type3 arg3, type4 arg4) {                     \
+  long __res;                                                                   \
+  __asm__ __volatile__ (                                                        \
+  "mov\tr0,%1\n\t"                                                              \
+  "mov\tr1,%2\n\t"                                                              \ 
+  "mov\tr2,%3\n\t"                                                              \
+  "mov\tr3,%4\n\t"                                                              \
+  __syscall(name)                                                               \
+  "mov\t%0,r0"                                                                  \
+        : "=r" (__res)                                                          \
+        : "r" ((long)(arg1)),"r" ((long)(arg2)),"r" ((long)(arg3)),"r" ((long)(arg4))    \
+        : "r0","r1","r2","r3","lr");                                                     \
+  __syscall_return(type,__res);                                                          \
 }
 
 
-#define _syscall5(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4,type5,arg5)	\
-type name(type1 arg1, type2 arg2, type3 arg3, type4 arg4, type5 arg5) {			\
-  long __res;										\
-  __asm__ __volatile__ (								\
-  "mov\tr0,%1\n\t"									\
-  "mov\tr1,%2\n\t"									\
-  "mov\tr2,%3\n\t"									\
-  "mov\tr3,%4\n\t"									\
-  "mov\tr4,%5\n\t"									\
-  __syscall(name)									\
-  "mov\t%0,r0"										\
-        : "=r" (__res)									\
-        : "r" ((long)(arg1)),"r" ((long)(arg2)),"r" ((long)(arg3)),"r" ((long)(arg4)),	\
-          "r" ((long)(arg5))								\
-        : "r0","r1","r2","r3","r4","lr");						\
-  __syscall_return(type,__res);								\
+#define _syscall5(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4,type5,arg5)    \
+type name(type1 arg1, type2 arg2, type3 arg3, type4 arg4, type5 arg5) {                \
+  long __res;                                         \
+  __asm__ __volatile__ (                              \
+  "mov\tr0,%1\n\t"                                    \
+  "mov\tr1,%2\n\t"                                    \
+  "mov\tr2,%3\n\t"                                    \
+  "mov\tr3,%4\n\t"                                    \
+  "mov\tr4,%5\n\t"                                    \
+  __syscall(name)                                     \
+  "mov\t%0,r0"                                        \
+        : "=r" (__res)                                \
+        : "r" ((long)(arg1)),"r" ((long)(arg2)),"r" ((long)(arg3)),"r" ((long)(arg4)),    \
+          "r" ((long)(arg5))                                                              \
+        : "r0","r1","r2","r3","r4","lr");                                                 \ 
+  __syscall_return(type,__res);                                                           \
 }
 
 _syscall1(int,exit1,int,status);
diff --git a/tests/tcg/i386/test-i386-ssse3.c b/tests/tcg/i386/test-i386-ssse3.c
index 0a42bd03e2..8a9a8ba8fa 100644
--- a/tests/tcg/i386/test-i386-ssse3.c
+++ b/tests/tcg/i386/test-i386-ssse3.c
@@ -4,54 +4,54 @@
 #include <stdint.h>
 
 int main(int argc, char *argv[]) {
-	char hello[16];
-	const char ehlo[8] = "EHLO    ";
-	uint64_t mask = 0x8080800302020001;
-
-	uint64_t a = 0x0000000000090007;
-	uint64_t b = 0x0000000000000000;
-	uint32_t c;
-	uint16_t d;
-
-	const char e[16] = "LLOaaaaaaaaaaaaa";
-	const char f[16] = "aaaaaaaaaaaaaaHE";
-
-	/* pshufb mm1/xmm1, mm2/xmm2 */
-	asm volatile ("movq    (%0), %%mm0" : : "r" (ehlo) : "mm0", "mm1");
-	asm volatile ("movq    %0, %%mm1" : : "m" (mask));
-	asm volatile ("pshufb  %mm1, %mm0");
-	asm volatile ("movq    %%mm0, %0" : "=m" (hello));
-	printf("%s\n", hello);
-
-	/* pshufb mm1/xmm1, m64/m128 */
-	asm volatile ("movq    (%0), %%mm0" : : "r" (ehlo) : "mm0");
-	asm volatile ("pshufb  %0, %%mm0" : : "m" (mask));
-	asm volatile ("movq    %%mm0, %0" : "=m" (hello));
-	printf("%s\n", hello);
-
-	/* psubsw mm1/xmm1, m64/m128 */
-	asm volatile ("movq    %0, %%mm0" : : "r" (a) : "mm0");
-	asm volatile ("phsubsw %0, %%mm0" : : "m" (b));
-	asm volatile ("movq    %%mm0, %0" : "=m" (a));
-	printf("%i - %i = %i\n", 9, 7, -(int16_t) a);
-
-	/* palignr mm1/xmm1, m64/m128, imm8 */
-	asm volatile ("movdqa  (%0), %%xmm0" : : "r" (e) : "xmm0");
-	asm volatile ("palignr $14, (%0), %%xmm0" : : "r" (f));
-	asm volatile ("movdqa  %%xmm0, (%0)" : : "r" (hello));
-	printf("%5.5s\n", hello);
+    char hello[16];
+    const char ehlo[8] = "EHLO    ";
+    uint64_t mask = 0x8080800302020001;
+
+    uint64_t a = 0x0000000000090007;
+    uint64_t b = 0x0000000000000000;
+    uint32_t c;
+    uint16_t d;
+
+    const char e[16] = "LLOaaaaaaaaaaaaa";
+    const char f[16] = "aaaaaaaaaaaaaaHE";
+
+    /* pshufb mm1/xmm1, mm2/xmm2 */
+    asm volatile ("movq    (%0), %%mm0" : : "r" (ehlo) : "mm0", "mm1");
+    asm volatile ("movq    %0, %%mm1" : : "m" (mask));
+    asm volatile ("pshufb  %mm1, %mm0");
+    asm volatile ("movq    %%mm0, %0" : "=m" (hello));
+    printf("%s\n", hello);
+
+    /* pshufb mm1/xmm1, m64/m128 */
+    asm volatile ("movq    (%0), %%mm0" : : "r" (ehlo) : "mm0");
+    asm volatile ("pshufb  %0, %%mm0" : : "m" (mask));
+    asm volatile ("movq    %%mm0, %0" : "=m" (hello));
+    printf("%s\n", hello);
+
+    /* psubsw mm1/xmm1, m64/m128 */
+    asm volatile ("movq    %0, %%mm0" : : "r" (a) : "mm0");
+    asm volatile ("phsubsw %0, %%mm0" : : "m" (b));
+    asm volatile ("movq    %%mm0, %0" : "=m" (a));
+    printf("%i - %i = %i\n", 9, 7, -(int16_t) a);
+
+    /* palignr mm1/xmm1, m64/m128, imm8 */
+    asm volatile ("movdqa  (%0), %%xmm0" : : "r" (e) : "xmm0");
+    asm volatile ("palignr $14, (%0), %%xmm0" : : "r" (f));
+    asm volatile ("movdqa  %%xmm0, (%0)" : : "r" (hello));
+    printf("%5.5s\n", hello);
 
 #if 1 /* SSE4 */
-	/* popcnt r64, r/m64 */
-	asm volatile ("movq    $0x8421000010009c63, %%rax" : : : "rax");
-	asm volatile ("popcnt  %%ax, %%dx" : : : "dx");
-	asm volatile ("popcnt  %%eax, %%ecx" : : : "ecx");
-	asm volatile ("popcnt  %rax, %rax");
-	asm volatile ("movq    %%rax, %0" : "=m" (a));
-	asm volatile ("movl    %%ecx, %0" : "=m" (c));
-	asm volatile ("movw    %%dx, %0" : "=m" (d));
-	printf("%i = %i\n%i = %i = %i\n", 13, (int) a, 9, c, d + 1);
+    /* popcnt r64, r/m64 */
+    asm volatile ("movq    $0x8421000010009c63, %%rax" : : : "rax");
+    asm volatile ("popcnt  %%ax, %%dx" : : : "dx");
+    asm volatile ("popcnt  %%eax, %%ecx" : : : "ecx");
+    asm volatile ("popcnt  %rax, %rax");
+    asm volatile ("movq    %%rax, %0" : "=m" (a));
+    asm volatile ("movl    %%ecx, %0" : "=m" (c));
+    asm volatile ("movw    %%dx, %0" : "=m" (d));
+    printf("%i = %i\n%i = %i = %i\n", 13, (int) a, 9, c, d + 1);
 #endif
 
-	return 0;
+    return 0;
 }
diff --git a/tests/tcg/i386/test-i386.c b/tests/tcg/i386/test-i386.c
index ce3bf74b5a..3542c98c02 100644
--- a/tests/tcg/i386/test-i386.c
+++ b/tests/tcg/i386/test-i386.c
@@ -51,19 +51,19 @@
 #include <asm/vm86.h>
 #endif
 
-#define xglue(x, y) x ## y
-#define glue(x, y) xglue(x, y)
-#define stringify(s)	tostring(s)
-#define tostring(s)	#s
-
-#define CC_C   	0x0001
-#define CC_P 	0x0004
-#define CC_A	0x0010
-#define CC_Z	0x0040
+#define xglue(x, y)    x ## y
+#define glue(x, y)     xglue(x, y)
+#define stringify(s)   tostring(s)
+#define tostring(s)    #s
+
+#define CC_C    0x0001
+#define CC_P    0x0004
+#define CC_A    0x0010
+#define CC_Z    0x0040
 #define CC_S    0x0080
 #define CC_O    0x0800
 
-#define __init_call	__attribute__ ((unused,__section__ ("initcall")))
+#define __init_call    __attribute__ ((unused,__section__ ("initcall")))
 
 #define CC_MASK (CC_C | CC_P | CC_Z | CC_S | CC_O | CC_A)
 
@@ -125,7 +125,7 @@ static inline long i2l(long v)
 #define OP1
 #include "test-i386.h"
 
-#undef CC_MASK
+#undef  CC_MASK
 #define CC_MASK (CC_C | CC_P | CC_Z | CC_S | CC_O)
 
 #define OP shl
@@ -494,8 +494,8 @@ void test_loop(void)
     TEST_LOOP("loopnzl");
 }
 
-#undef CC_MASK
-#ifdef TEST_P4_FLAGS
+#undef  CC_MASK
+#ifdef  TEST_P4_FLAGS
 #define CC_MASK (CC_C | CC_P | CC_Z | CC_S | CC_O | CC_A)
 #else
 #define CC_MASK (CC_O | CC_C)
@@ -581,7 +581,7 @@ void test_imulq2(long op0, long op1)
 }
 
 
-#undef CC_MASK
+#undef  CC_MASK
 #define CC_MASK (0)
 
 #define OP div
@@ -717,23 +717,23 @@ void test_mul(void)
 
 void test_xcnt(void)
 {
-    TEST_BSX(tzcntw, "w", 0);
-    TEST_BSX(tzcntw, "w", 0x12340128);
-    TEST_BSX(lzcntw, "w", 0);
-    TEST_BSX(lzcntw, "w", 0x12340128);
+    TEST_BSX(tzcntw,  "w", 0);
+    TEST_BSX(tzcntw,  "w", 0x12340128);
+    TEST_BSX(lzcntw,  "w", 0);
+    TEST_BSX(lzcntw,  "w", 0x12340128);
     TEST_BSX(popcntw, "w", 0);
     TEST_BSX(popcntw, "w", 0x12340128);
-    TEST_BSX(tzcntl, "k", 0);
-    TEST_BSX(tzcntl, "k", 0x00340128);
-    TEST_BSX(lzcntl, "k", 0);
-    TEST_BSX(lzcntl, "k", 0x00340128);
+    TEST_BSX(tzcntl,  "k", 0);
+    TEST_BSX(tzcntl,  "k", 0x00340128);
+    TEST_BSX(lzcntl,  "k", 0);
+    TEST_BSX(lzcntl,  "k", 0x00340128);
     TEST_BSX(popcntl, "k", 0);
     TEST_BSX(popcntl, "k", 0x00340128);
 #if defined(__x86_64__)
-    TEST_BSX(tzcntq, "", 0);
-    TEST_BSX(tzcntq, "", 0x003401281234);
-    TEST_BSX(lzcntq, "", 0);
-    TEST_BSX(lzcntq, "", 0x003401281234);
+    TEST_BSX(tzcntq,  "", 0);
+    TEST_BSX(tzcntq,  "", 0x003401281234);
+    TEST_BSX(lzcntq,  "", 0);
+    TEST_BSX(lzcntq,  "", 0x003401281234);
     TEST_BSX(popcntq, "", 0);
     TEST_BSX(popcntq, "", 0x003401281234);
 #endif
diff --git a/tests/tcg/mips/hello-mips.c b/tests/tcg/mips/hello-mips.c
index 38e22d00e3..6aa5e07b8a 100644
--- a/tests/tcg/mips/hello-mips.c
+++ b/tests/tcg/mips/hello-mips.c
@@ -9,20 +9,20 @@
 *                  -mabi=32 -O2 -static -o hello-mips hello-mips.c
 *
 */
-#define __NR_SYSCALL_BASE	4000
-#define __NR_exit			(__NR_SYSCALL_BASE+  1)
-#define __NR_write			(__NR_SYSCALL_BASE+  4)
+#define __NR_SYSCALL_BASE    4000
+#define __NR_exit            (__NR_SYSCALL_BASE+  1)
+#define __NR_write           (__NR_SYSCALL_BASE+  4)
 
 static inline void exit1(int status)
 {
     register unsigned long __a0 asm("$4") = (unsigned long) status;
 
     __asm__ __volatile__ (
-        "	.set push	\n"
-        "	.set noreorder	\n"
-        "	li	$2, %0	\n"
-        "	syscall		\n"
-        "	.set pop	"
+        "    .set push      \n"
+        "    .set noreorder \n"
+        "    li    $2, %0   \n"
+        "    syscall        \n"
+        "    .set pop    "
         :
         : "i" (__NR_exit), "r" (__a0)
         : "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24",
@@ -38,12 +38,12 @@ static inline int write(int fd, const char *buf, int len)
     unsigned long __v0;
 
     __asm__ __volatile__ (
-        "	.set push	\n"
-        "	.set noreorder	\n"
-        "	li	$2, %2	\n"
-        "	syscall		\n"
-        "	move	%0, $2	\n"
-        "	.set pop	"
+        "    .set push      \n"
+        "    .set noreorder \n"
+        "    li    $2, %2   \n"
+        "    syscall        \n"
+        "    move    %0, $2 \n"
+        "    .set pop    "
         : "=r" (__v0), "=r" (__a3)
         : "i" (__NR_write), "r" (__a0), "r" (__a1), "r" (__a2)
         : "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24",
diff --git a/tests/tcg/multiarch/sha1.c b/tests/tcg/multiarch/sha1.c
index 0081bd7657..7d22423b7e 100644
--- a/tests/tcg/multiarch/sha1.c
+++ b/tests/tcg/multiarch/sha1.c
@@ -175,7 +175,7 @@ unsigned i;
 unsigned char finalcount[8];
 unsigned char c;
 
-#if 0	/* untested "improvement" by DHR */
+#if 0    /* untested "improvement" by DHR */
     /* Convert context->count to a sequence of bytes
      * in finalcount.  Second element first, but
      * big-endian order within element.
@@ -216,8 +216,7 @@ unsigned char c;
 
 #define BUFSIZE 4096
 
-int
-main(int argc, char **argv)
+int main(int argc, char **argv)
 {
     SHA1_CTX ctx;
     unsigned char hash[20], buf[BUFSIZE];
diff --git a/tests/tcg/multiarch/test-mmap.c b/tests/tcg/multiarch/test-mmap.c
index 96257f8ebe..bb1eb66d37 100644
--- a/tests/tcg/multiarch/test-mmap.c
+++ b/tests/tcg/multiarch/test-mmap.c
@@ -36,7 +36,7 @@
 do                                                             \
 {                                                              \
   if (!(x)) {                                                  \
-    fprintf(stderr, "FAILED at %s:%d\n", __FILE__, __LINE__); \
+    fprintf(stderr, "FAILED at %s:%d\n", __FILE__, __LINE__);  \
     exit (EXIT_FAILURE);                                       \
   }                                                            \
 } while (0)
@@ -109,26 +109,26 @@ void check_aligned_anonymous_unfixed_mmaps(void)
 
 void check_large_anonymous_unfixed_mmap(void)
 {
-	void *p1;
-	uintptr_t p;
-	size_t len;
-
-	fprintf(stdout, "%s", __func__);
-
-	len = 0x02000000;
-	p1 = mmap(NULL, len, PROT_READ, 
-		  MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
-
-	/* Make sure we get pages aligned with the pagesize. The
-	   target expects this.  */
-	fail_unless (p1 != MAP_FAILED);
-	p = (uintptr_t) p1;
-	fail_unless ((p & pagemask) == 0);
-	
-	/* Make sure we can read from the entire area.  */
-	memcpy (dummybuf, p1, pagesize);
-	munmap (p1, len);
-	fprintf(stdout, " passed\n");
+    void *p1;
+    uintptr_t p;
+    size_t len;
+
+    fprintf(stdout, "%s", __func__);
+
+    len = 0x02000000;
+    p1 = mmap(NULL, len, PROT_READ, 
+          MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+
+    /* Make sure we get pages aligned with the pagesize. The
+       target expects this.  */
+    fail_unless (p1 != MAP_FAILED);
+    p = (uintptr_t) p1;
+    fail_unless ((p & pagemask) == 0);
+    
+    /* Make sure we can read from the entire area.  */
+    memcpy (dummybuf, p1, pagesize);
+    munmap (p1, len);
+    fprintf(stdout, " passed\n");
 }
 
 void check_aligned_anonymous_unfixed_colliding_mmaps(void)
@@ -185,248 +185,248 @@ void check_aligned_anonymous_unfixed_colliding_mmaps(void)
 
 void check_aligned_anonymous_fixed_mmaps(void)
 {
-	char *addr;
-	void *p1;
-	uintptr_t p;
-	int i;
-
-	/* Find a suitable address to start with.  */
-	addr = mmap(NULL, pagesize * 40, PROT_READ | PROT_WRITE, 
-		    MAP_PRIVATE | MAP_ANONYMOUS,
-		    -1, 0);
-	fprintf(stdout, "%s addr=%p", __func__, addr);
-	fail_unless (addr != MAP_FAILED);
-
-	for (i = 0; i < 40; i++)
-	{
-		/* Create submaps within our unfixed map.  */
-		p1 = mmap(addr, pagesize, PROT_READ, 
-			  MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED,
-			  -1, 0);
-		/* Make sure we get pages aligned with the pagesize. 
-		   The target expects this.  */
-		p = (uintptr_t) p1;
-		fail_unless (p1 == addr);
-		fail_unless ((p & pagemask) == 0);		
-		memcpy (dummybuf, p1, pagesize);
-		munmap (p1, pagesize);
-		addr += pagesize;
-	}
-	fprintf(stdout, " passed\n");
+    char *addr;
+    void *p1;
+    uintptr_t p;
+    int i;
+
+    /* Find a suitable address to start with.  */
+    addr = mmap(NULL, pagesize * 40, PROT_READ | PROT_WRITE, 
+            MAP_PRIVATE | MAP_ANONYMOUS,
+            -1, 0);
+    fprintf(stdout, "%s addr=%p", __func__, addr);
+    fail_unless (addr != MAP_FAILED);
+
+    for (i = 0; i < 40; i++)
+    {
+        /* Create submaps within our unfixed map.  */
+        p1 = mmap(addr, pagesize, PROT_READ, 
+              MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED,
+              -1, 0);
+        /* Make sure we get pages aligned with the pagesize. 
+           The target expects this.  */
+        p = (uintptr_t) p1;
+        fail_unless (p1 == addr);
+        fail_unless ((p & pagemask) == 0);        
+        memcpy (dummybuf, p1, pagesize);
+        munmap (p1, pagesize);
+        addr += pagesize;
+    }
+    fprintf(stdout, " passed\n");
 }
 
 void check_aligned_anonymous_fixed_mmaps_collide_with_host(void)
 {
-	char *addr;
-	void *p1;
-	uintptr_t p;
-	int i;
-
-	/* Find a suitable address to start with.  Right were the x86 hosts
-	 stack is.  */
-	addr = ((void *)0x80000000);
-	fprintf(stdout, "%s addr=%p", __func__, addr);
-	fprintf(stdout, "FIXME: QEMU fails to track pages used by the host.");
-
-	for (i = 0; i < 20; i++)
-	{
-		/* Create submaps within our unfixed map.  */
-		p1 = mmap(addr, pagesize, PROT_READ | PROT_WRITE, 
-			  MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED,
-			  -1, 0);
-		/* Make sure we get pages aligned with the pagesize. 
-		   The target expects this.  */
-		p = (uintptr_t) p1;
-		fail_unless (p1 == addr);
-		fail_unless ((p & pagemask) == 0);		
-		memcpy (p1, dummybuf, pagesize);
-		munmap (p1, pagesize);
-		addr += pagesize;
-	}
-	fprintf(stdout, " passed\n");
+    char *addr;
+    void *p1;
+    uintptr_t p;
+    int i;
+
+    /* Find a suitable address to start with.  Right were the x86 hosts
+     stack is.  */
+    addr = ((void *)0x80000000);
+    fprintf(stdout, "%s addr=%p", __func__, addr);
+    fprintf(stdout, "FIXME: QEMU fails to track pages used by the host.");
+
+    for (i = 0; i < 20; i++)
+    {
+        /* Create submaps within our unfixed map.  */
+        p1 = mmap(addr, pagesize, PROT_READ | PROT_WRITE, 
+              MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED,
+              -1, 0);
+        /* Make sure we get pages aligned with the pagesize. 
+           The target expects this.  */
+        p = (uintptr_t) p1;
+        fail_unless (p1 == addr);
+        fail_unless ((p & pagemask) == 0);        
+        memcpy (p1, dummybuf, pagesize);
+        munmap (p1, pagesize);
+        addr += pagesize;
+    }
+    fprintf(stdout, " passed\n");
 }
 
 void check_file_unfixed_mmaps(void)
 {
-	unsigned int *p1, *p2, *p3;
-	uintptr_t p;
-	int i;
-
-	fprintf(stdout, "%s", __func__);
-	for (i = 0; i < 0x10; i++)
-	{
-		size_t len;
-
-		len = pagesize;
-		p1 = mmap(NULL, len, PROT_READ, 
-			  MAP_PRIVATE, 
-			  test_fd, 0);
-		p2 = mmap(NULL, len, PROT_READ, 
-			  MAP_PRIVATE, 
-			  test_fd, pagesize);
-		p3 = mmap(NULL, len, PROT_READ, 
-			  MAP_PRIVATE, 
-			  test_fd, pagesize * 2);
-
-		fail_unless (p1 != MAP_FAILED);
-		fail_unless (p2 != MAP_FAILED);
-		fail_unless (p3 != MAP_FAILED);
-
-		/* Make sure we get pages aligned with the pagesize. The
-		   target expects this.  */
-		p = (uintptr_t) p1;
-		fail_unless ((p & pagemask) == 0);
-		p = (uintptr_t) p2;
-		fail_unless ((p & pagemask) == 0);
-		p = (uintptr_t) p3;
-		fail_unless ((p & pagemask) == 0);
-
-		/* Verify that the file maps was made correctly.  */
-		D(printf ("p1=%d p2=%d p3=%d\n", *p1, *p2, *p3));
-		fail_unless (*p1 == 0);
-		fail_unless (*p2 == (pagesize / sizeof *p2));
-		fail_unless (*p3 == ((pagesize * 2) / sizeof *p3));
-
-		memcpy (dummybuf, p1, pagesize);
-		memcpy (dummybuf, p2, pagesize);
-		memcpy (dummybuf, p3, pagesize);
-		munmap (p1, len);
-		munmap (p2, len);
-		munmap (p3, len);
-	}
-	fprintf(stdout, " passed\n");
+    unsigned int *p1, *p2, *p3;
+    uintptr_t p;
+    int i;
+
+    fprintf(stdout, "%s", __func__);
+    for (i = 0; i < 0x10; i++)
+    {
+        size_t len;
+
+        len = pagesize;
+        p1 = mmap(NULL, len, PROT_READ, 
+              MAP_PRIVATE, 
+              test_fd, 0);
+        p2 = mmap(NULL, len, PROT_READ, 
+              MAP_PRIVATE, 
+              test_fd, pagesize);
+        p3 = mmap(NULL, len, PROT_READ, 
+              MAP_PRIVATE, 
+              test_fd, pagesize * 2);
+
+        fail_unless (p1 != MAP_FAILED);
+        fail_unless (p2 != MAP_FAILED);
+        fail_unless (p3 != MAP_FAILED);
+
+        /* Make sure we get pages aligned with the pagesize. The
+           target expects this.  */
+        p = (uintptr_t) p1;
+        fail_unless ((p & pagemask) == 0);
+        p = (uintptr_t) p2;
+        fail_unless ((p & pagemask) == 0);
+        p = (uintptr_t) p3;
+        fail_unless ((p & pagemask) == 0);
+
+        /* Verify that the file maps was made correctly.  */
+        D(printf ("p1=%d p2=%d p3=%d\n", *p1, *p2, *p3));
+        fail_unless (*p1 == 0);
+        fail_unless (*p2 == (pagesize / sizeof *p2));
+        fail_unless (*p3 == ((pagesize * 2) / sizeof *p3));
+
+        memcpy (dummybuf, p1, pagesize);
+        memcpy (dummybuf, p2, pagesize);
+        memcpy (dummybuf, p3, pagesize);
+        munmap (p1, len);
+        munmap (p2, len);
+        munmap (p3, len);
+    }
+    fprintf(stdout, " passed\n");
 }
 
 void check_file_unfixed_eof_mmaps(void)
 {
-	char *cp;
-	unsigned int *p1;
-	uintptr_t p;
-	int i;
-
-	fprintf(stdout, "%s", __func__);
-	for (i = 0; i < 0x10; i++)
-	{
-		p1 = mmap(NULL, pagesize, PROT_READ, 
-			  MAP_PRIVATE, 
-			  test_fd, 
-			  (test_fsize - sizeof *p1) & ~pagemask);
-
-		fail_unless (p1 != MAP_FAILED);
-
-		/* Make sure we get pages aligned with the pagesize. The
-		   target expects this.  */
-		p = (uintptr_t) p1;
-		fail_unless ((p & pagemask) == 0);
-		/* Verify that the file maps was made correctly.  */
-		fail_unless (p1[(test_fsize & pagemask) / sizeof *p1 - 1]
-			     == ((test_fsize - sizeof *p1) / sizeof *p1));
-
-		/* Verify that the end of page is accessible and zeroed.  */
-		cp = (void *) p1;
-		fail_unless (cp[pagesize - 4] == 0);
-		munmap (p1, pagesize);
-	}
-	fprintf(stdout, " passed\n");
+    char *cp;
+    unsigned int *p1;
+    uintptr_t p;
+    int i;
+
+    fprintf(stdout, "%s", __func__);
+    for (i = 0; i < 0x10; i++)
+    {
+        p1 = mmap(NULL, pagesize, PROT_READ, 
+              MAP_PRIVATE, 
+              test_fd, 
+              (test_fsize - sizeof *p1) & ~pagemask);
+
+        fail_unless (p1 != MAP_FAILED);
+
+        /* Make sure we get pages aligned with the pagesize. The
+           target expects this.  */
+        p = (uintptr_t) p1;
+        fail_unless ((p & pagemask) == 0);
+        /* Verify that the file maps was made correctly.  */
+        fail_unless (p1[(test_fsize & pagemask) / sizeof *p1 - 1]
+                 == ((test_fsize - sizeof *p1) / sizeof *p1));
+
+        /* Verify that the end of page is accessible and zeroed.  */
+        cp = (void *) p1;
+        fail_unless (cp[pagesize - 4] == 0);
+        munmap (p1, pagesize);
+    }
+    fprintf(stdout, " passed\n");
 }
 
 void check_file_fixed_eof_mmaps(void)
 {
-	char *addr;
-	char *cp;
-	unsigned int *p1;
-	uintptr_t p;
-	int i;
-
-	/* Find a suitable address to start with.  */
-	addr = mmap(NULL, pagesize * 44, PROT_READ, 
-		    MAP_PRIVATE | MAP_ANONYMOUS,
-		    -1, 0);
-
-	fprintf(stdout, "%s addr=%p", __func__, (void *)addr);
-	fail_unless (addr != MAP_FAILED);
-
-	for (i = 0; i < 0x10; i++)
-	{
-		/* Create submaps within our unfixed map.  */
-		p1 = mmap(addr, pagesize, PROT_READ, 
-			  MAP_PRIVATE | MAP_FIXED, 
-			  test_fd, 
-			  (test_fsize - sizeof *p1) & ~pagemask);
-
-		fail_unless (p1 != MAP_FAILED);
-
-		/* Make sure we get pages aligned with the pagesize. The
-		   target expects this.  */
-		p = (uintptr_t) p1;
-		fail_unless ((p & pagemask) == 0);
-
-		/* Verify that the file maps was made correctly.  */
-		fail_unless (p1[(test_fsize & pagemask) / sizeof *p1 - 1]
-			     == ((test_fsize - sizeof *p1) / sizeof *p1));
-
-		/* Verify that the end of page is accessible and zeroed.  */
-		cp = (void *)p1;
-		fail_unless (cp[pagesize - 4] == 0);
-		munmap (p1, pagesize);
-		addr += pagesize;
-	}
-	fprintf(stdout, " passed\n");
+    char *addr;
+    char *cp;
+    unsigned int *p1;
+    uintptr_t p;
+    int i;
+
+    /* Find a suitable address to start with.  */
+    addr = mmap(NULL, pagesize * 44, PROT_READ, 
+            MAP_PRIVATE | MAP_ANONYMOUS,
+            -1, 0);
+
+    fprintf(stdout, "%s addr=%p", __func__, (void *)addr);
+    fail_unless (addr != MAP_FAILED);
+
+    for (i = 0; i < 0x10; i++)
+    {
+        /* Create submaps within our unfixed map.  */
+        p1 = mmap(addr, pagesize, PROT_READ, 
+              MAP_PRIVATE | MAP_FIXED, 
+              test_fd, 
+              (test_fsize - sizeof *p1) & ~pagemask);
+
+        fail_unless (p1 != MAP_FAILED);
+
+        /* Make sure we get pages aligned with the pagesize. The
+           target expects this.  */
+        p = (uintptr_t) p1;
+        fail_unless ((p & pagemask) == 0);
+
+        /* Verify that the file maps was made correctly.  */
+        fail_unless (p1[(test_fsize & pagemask) / sizeof *p1 - 1]
+                 == ((test_fsize - sizeof *p1) / sizeof *p1));
+
+        /* Verify that the end of page is accessible and zeroed.  */
+        cp = (void *)p1;
+        fail_unless (cp[pagesize - 4] == 0);
+        munmap (p1, pagesize);
+        addr += pagesize;
+    }
+    fprintf(stdout, " passed\n");
 }
 
 void check_file_fixed_mmaps(void)
 {
-	unsigned char *addr;
-	unsigned int *p1, *p2, *p3, *p4;
-	int i;
-
-	/* Find a suitable address to start with.  */
-	addr = mmap(NULL, pagesize * 40 * 4, PROT_READ, 
-		    MAP_PRIVATE | MAP_ANONYMOUS,
-		    -1, 0);
-	fprintf(stdout, "%s addr=%p", __func__, (void *)addr);
-	fail_unless (addr != MAP_FAILED);
-
-	for (i = 0; i < 40; i++)
-	{
-		p1 = mmap(addr, pagesize, PROT_READ, 
-			  MAP_PRIVATE | MAP_FIXED,
-			  test_fd, 0);
-		p2 = mmap(addr + pagesize, pagesize, PROT_READ, 
-			  MAP_PRIVATE | MAP_FIXED,
-			  test_fd, pagesize);
-		p3 = mmap(addr + pagesize * 2, pagesize, PROT_READ, 
-			  MAP_PRIVATE | MAP_FIXED,
-			  test_fd, pagesize * 2);
-		p4 = mmap(addr + pagesize * 3, pagesize, PROT_READ, 
-			  MAP_PRIVATE | MAP_FIXED,
-			  test_fd, pagesize * 3);
-
-		/* Make sure we get pages aligned with the pagesize. 
-		   The target expects this.  */
-		fail_unless (p1 == (void *)addr);
-		fail_unless (p2 == (void *)addr + pagesize);
-		fail_unless (p3 == (void *)addr + pagesize * 2);
-		fail_unless (p4 == (void *)addr + pagesize * 3);
-
-		/* Verify that the file maps was made correctly.  */
-		fail_unless (*p1 == 0);
-		fail_unless (*p2 == (pagesize / sizeof *p2));
-		fail_unless (*p3 == ((pagesize * 2) / sizeof *p3));
-		fail_unless (*p4 == ((pagesize * 3) / sizeof *p4));
-
-		memcpy (dummybuf, p1, pagesize);
-		memcpy (dummybuf, p2, pagesize);
-		memcpy (dummybuf, p3, pagesize);
-		memcpy (dummybuf, p4, pagesize);
-
-		munmap (p1, pagesize);
-		munmap (p2, pagesize);
-		munmap (p3, pagesize);
-		munmap (p4, pagesize);
-		addr += pagesize * 4;
-	}
-	fprintf(stdout, " passed\n");
+    unsigned char *addr;
+    unsigned int *p1, *p2, *p3, *p4;
+    int i;
+
+    /* Find a suitable address to start with.  */
+    addr = mmap(NULL, pagesize * 40 * 4, PROT_READ, 
+            MAP_PRIVATE | MAP_ANONYMOUS,
+            -1, 0);
+    fprintf(stdout, "%s addr=%p", __func__, (void *)addr);
+    fail_unless (addr != MAP_FAILED);
+
+    for (i = 0; i < 40; i++)
+    {
+        p1 = mmap(addr, pagesize, PROT_READ, 
+              MAP_PRIVATE | MAP_FIXED,
+              test_fd, 0);
+        p2 = mmap(addr + pagesize, pagesize, PROT_READ, 
+              MAP_PRIVATE | MAP_FIXED,
+              test_fd, pagesize);
+        p3 = mmap(addr + pagesize * 2, pagesize, PROT_READ, 
+              MAP_PRIVATE | MAP_FIXED,
+              test_fd, pagesize * 2);
+        p4 = mmap(addr + pagesize * 3, pagesize, PROT_READ, 
+              MAP_PRIVATE | MAP_FIXED,
+              test_fd, pagesize * 3);
+
+        /* Make sure we get pages aligned with the pagesize. 
+           The target expects this.  */
+        fail_unless (p1 == (void *)addr);
+        fail_unless (p2 == (void *)addr + pagesize);
+        fail_unless (p3 == (void *)addr + pagesize * 2);
+        fail_unless (p4 == (void *)addr + pagesize * 3);
+
+        /* Verify that the file maps was made correctly.  */
+        fail_unless (*p1 == 0);
+        fail_unless (*p2 == (pagesize / sizeof *p2));
+        fail_unless (*p3 == ((pagesize * 2) / sizeof *p3));
+        fail_unless (*p4 == ((pagesize * 3) / sizeof *p4));
+
+        memcpy (dummybuf, p1, pagesize);
+        memcpy (dummybuf, p2, pagesize);
+        memcpy (dummybuf, p3, pagesize);
+        memcpy (dummybuf, p4, pagesize);
+
+        munmap (p1, pagesize);
+        munmap (p2, pagesize);
+        munmap (p3, pagesize);
+        munmap (p4, pagesize);
+        addr += pagesize * 4;
+    }
+    fprintf(stdout, " passed\n");
 }
 
 void checked_write(int fd, const void *buf, size_t count)
@@ -456,49 +456,50 @@ void check_invalid_mmaps(void)
 
 int main(int argc, char **argv)
 {
-	char tempname[] = "/tmp/.cmmapXXXXXX";
-	unsigned int i;
+    char tempname[] = "/tmp/.cmmapXXXXXX";
+    unsigned int i;
 
-	/* Trust the first argument, otherwise probe the system for our
-	   pagesize.  */
-	if (argc > 1)
-		pagesize = strtoul(argv[1], NULL, 0);
-	else
-		pagesize = sysconf(_SC_PAGESIZE);
+    /* Trust the first argument, otherwise probe the system for our
+       pagesize.  */
+    if (argc > 1)
+        pagesize = strtoul(argv[1], NULL, 0);
+    else
+        pagesize = sysconf(_SC_PAGESIZE);
 
-	/* Assume pagesize is a power of two.  */
-	pagemask = pagesize - 1;
-	dummybuf = malloc (pagesize);
-	printf ("pagesize=%u pagemask=%x\n", pagesize, pagemask);
+    /* Assume pagesize is a power of two.  */
+    pagemask = pagesize - 1;
+    dummybuf = malloc (pagesize);
+    printf ("pagesize=%u pagemask=%x\n", pagesize, pagemask);
 
-	test_fd = mkstemp(tempname);
-	unlink(tempname);
+    test_fd = mkstemp(tempname);
+    unlink(tempname);
 
-	/* Fill the file with int's counting from zero and up.  */
+    /* Fill the file with int's counting from zero and up.  */
     for (i = 0; i < (pagesize * 4) / sizeof i; i++) {
         checked_write(test_fd, &i, sizeof i);
     }
 
-	/* Append a few extra writes to make the file end at non 
-	   page boundary.  */
+    /* Append a few extra writes to make the file end at non 
+       page boundary.  */
     checked_write(test_fd, &i, sizeof i); i++;
     checked_write(test_fd, &i, sizeof i); i++;
     checked_write(test_fd, &i, sizeof i); i++;
 
-	test_fsize = lseek(test_fd, 0, SEEK_CUR);
+    test_fsize = lseek(test_fd, 0, SEEK_CUR);
 
-	/* Run the tests.  */
-	check_aligned_anonymous_unfixed_mmaps();
-	check_aligned_anonymous_unfixed_colliding_mmaps();
-	check_aligned_anonymous_fixed_mmaps();
-	check_file_unfixed_mmaps();
-	check_file_fixed_mmaps();
-	check_file_fixed_eof_mmaps();
-	check_file_unfixed_eof_mmaps();
-	check_invalid_mmaps();
+    /* Run the tests.  */
+    check_aligned_anonymous_unfixed_mmaps();
+    check_aligned_anonymous_unfixed_colliding_mmaps();
+    check_aligned_anonymous_fixed_mmaps();
+    check_file_unfixed_mmaps();
+    check_file_fixed_mmaps();
+    check_file_fixed_eof_mmaps();
+    check_file_unfixed_eof_mmaps();
+    check_invalid_mmaps();
 
-	/* Fails at the moment.  */
-	/* check_aligned_anonymous_fixed_mmaps_collide_with_host(); */
+    /* Fails at the moment.  */
+    /* check_aligned_anonymous_fixed_mmaps_collide_with_host(); */
 
-	return EXIT_SUCCESS;
+    return EXIT_SUCCESS;
 }
+
-- 
2.43.0


