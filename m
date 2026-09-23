Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A625C98310
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 13:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9MuS-0002Ld-Bm; Wed, 23 Sep 2026 09:21:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x9MrC-00009Z-Tt
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 09:18:02 -0400
Received: from mail-dy2-x0f.google.com ([2607:f8b0:4864:36::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x9Mr8-0006pk-UK
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 09:17:54 -0400
Received: by mail-dy2-x0f.google.com with SMTP id
 5a478bee46e88-33c3735125bso408264eec.3
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 06:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790169465; x=1790774265; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VyGOeMM6N9WmW/Btrmx0VVv+jU00kmaZZ+J9OFmIWlc=;
 b=LV7OtYWRiNVOYlPfqVBK/+vv95RO+/04Pk6IokeqHkkO7WX+umH42XHB8/31nd9wfQ
 Tac7Egu6E228kWQd9SS4AP86dTYw0Vc3mkh7ZmM12wQvDm07H8DflBwG4h9+AqkVCjJL
 YFYa34CVWDokDn3Zz0M68qBtfgpirHxy4lh9DXyL09hnbquJJZFPYvsNgAEEAFDrHIb1
 jjS/dnNHpgwbVLsswbaCQwrxuEuRieHNqHBWyq1EIIGKL6O7ksc2INgHvhq4qlK9U6yn
 nKalxWqm102ep7rKE0VZJFpGgmjNfD6EUwiM+70P646+s/JKVRqMAGTKwWMBvVK4NyBU
 DjLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790169465; x=1790774265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VyGOeMM6N9WmW/Btrmx0VVv+jU00kmaZZ+J9OFmIWlc=;
 b=uy3e9mxnaz3Fuu5gI6Mkh6KgKwLUlSeK0upw6QSWEPbxBEyX8M2vp2+901bds2I8RU
 CmjEW7YsDPfK7GAF03NwZRuwpDsFaZlja3D+rIr9hnIzhyoFXw1Z5fAJsb90QZLlOCgJ
 ZCGqRLTe4PfQLlC1zbwV89BJ5hlC69L5qtq02dPJ9m6AAo930E6N0vxa0pfhkj3kjwhx
 AGkbrBdOCkm20WZIsynAvjspq2u9+a4Gk9wQ/I9CLeuAUpTl6W4ZDlYKou6GSS7K+qoE
 j2zkhXWkYn4FoHVnnJxcKMmZKCTw5Y52ng/AFFNyBMNHeTSjFSxeHW2YiBWHaTrHYXne
 5BKA==
X-Gm-Message-State: AFuF++lbWxBUyoSIoFi7Sqj4HxQ7w0tTPxRAsRTyzBSzYQuVlYRI38Qf
 nqwArv1PlZyu1S4m2aYfi1QPW4Ho3FU1fvu1y6wGVn3vGp2KNIc93hsHV8EZCwiBlGk=
X-Gm-Gg: AYBFou3k8mosTKFLyLlN8sDkOouDAOsH4WAIg9stHEmbAjg9tT/06DzSU7ONBLjrxII
 4mQD3z4RbB78FGt6M/STQSbqoa1b8KOqS79orZy99+uMFAOkn4x692+G2FEhze9WrKbZ2usd5nO
 TKFkvrQ1mcBgtXKmWAp24Yl3or8l3Kr8bzLFKvd4Da+DWA7v7INPKKODbIovOOB/3nXgMTmE3BE
 j/5zTjYYLL6QEqTVHLtFuo0xjQMrGs5ALPAG3KZob5yDBxf+WnAqs6TOl9i+YoWwc0qJrH+XoOm
 qb83j3lplg3rlU8ZdRkR6nubknXpFGqqTArEW4mvxNbzdWPlO0tYmoDtbVkkc9atUlp3BYUnZMM
 vNxm/YHfaQHeq7g1lJx7lpoKcRXgaiofldNLdfqsPPeqfmalQn6Ue2cuW2Izw3mypTcuqmrAKRZ
 Sq8LXup7bQSMyKI/qxPZtJ0MfCFAWjsU/R4w3dECS1Ulfpnki0qeAv3AjV+JsHW88rGvr4sbgTc
 QSroNqCsOcRB3ZUVFLtL6kHkAKQGB8=
X-Received: by 2002:a05:693c:6394:20b0:339:8343:a1a with SMTP id
 5a478bee46e88-33e8e1b7329mr2469431eec.41.1790169464712; 
 Wed, 23 Sep 2026 06:17:44 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-33e97236754sm5553695eec.29.2026.09.23.06.17.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 06:17:42 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, xen-devel@lists.xenproject.org,
 Chao Liu <chao.liu@processmission.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Fabiano Rosas <farosas@suse.de>, Xianglai Li <lixianglai@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bibo Mao <maobibo@loongson.cn>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-riscv@nongnu.org,
 kvm@vger.kernel.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Song Gao <17746591750@163.com>, qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v3 006/114] target: remove CPU_RESOLVING_TYPE
Date: Wed, 23 Sep 2026 21:14:40 +0800
Message-ID: <20260923131635.1894-7-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260923131635.1894-1-luoyonggang@gmail.com>
References: <20260923131635.1894-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::f;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

cpu_type is TYPE_${TARGET_BASE_ARCH}_CPU, so the per-target
CPU_RESOLVING_TYPE macros are unused. Drop them from every
target cpu.h.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/alpha/cpu.h      | 2 --
 target/arm/cpu.h        | 2 --
 target/avr/cpu.h        | 2 --
 target/hexagon/cpu.h    | 1 -
 target/hppa/cpu.h       | 2 --
 target/i386/cpu.h       | 2 --
 target/loongarch/cpu.h  | 2 --
 target/m68k/cpu.h       | 2 --
 target/microblaze/cpu.h | 2 --
 target/mips/cpu.h       | 2 --
 target/or1k/cpu.h       | 2 --
 target/ppc/cpu.h        | 2 --
 target/riscv/cpu.h      | 2 --
 target/rx/cpu.h         | 2 --
 target/s390x/cpu.h      | 3 ---
 target/sh4/cpu.h        | 2 --
 target/sparc/cpu.h      | 2 --
 target/tricore/cpu.h    | 2 --
 target/xtensa/cpu.h     | 2 --
 19 files changed, 38 deletions(-)

diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index 378bd96d941..a6ffe7eec29 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -433,8 +433,6 @@ void alpha_translate_init(void);
 void alpha_translate_code(CPUState *cs, TranslationBlock *tb,
                           int *max_insns, vaddr pc, void *host_pc);
 
-#define CPU_RESOLVING_TYPE TYPE_ALPHA_CPU
-
 G_NORETURN void dynamic_excp(CPUAlphaState *, uintptr_t, int, int);
 G_NORETURN void arith_excp(CPUAlphaState *, uintptr_t, int, uint64_t);
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index e3f931dba26..359d86e2c37 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2395,8 +2395,6 @@ bool write_cpustate_to_list(ARMCPU *cpu, bool kvm_sync);
 #define ARM_CPUID_TI915T      0x54029152
 #define ARM_CPUID_TI925T      0x54029252
 
-#define CPU_RESOLVING_TYPE TYPE_ARM_CPU
-
 #define TYPE_ARM_HOST_CPU "host-" TYPE_ARM_CPU
 
 /* Indexes used when registering address spaces with cpu_address_space_init */
diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index 1e4e839bd83..747655543d4 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -30,8 +30,6 @@
 #error "AVR 8-bit does not support user mode"
 #endif
 
-#define CPU_RESOLVING_TYPE TYPE_AVR_CPU
-
 /*
  * AVR has two memory spaces, data & code.
  * e.g. both have 0 address
diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index e79d8000304..54b0d69a827 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -52,7 +52,6 @@ typedef struct HexagonGlobalRegState HexagonGlobalRegState;
 #define MAX_TLB_ENTRIES 1024
 #define THREADS_MAX 16
 
-#define CPU_RESOLVING_TYPE TYPE_HEXAGON_CPU
 #ifndef CONFIG_USER_ONLY
 #define CPU_INTERRUPT_SWI      CPU_INTERRUPT_TGT_INT_0
 #define CPU_INTERRUPT_K0_UNLOCK CPU_INTERRUPT_TGT_INT_1
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index f453444d7f9..35b6b8af82a 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -339,8 +339,6 @@ void hppa_translate_init(void);
 void hppa_translate_code(CPUState *cs, TranslationBlock *tb,
                          int *max_insns, vaddr pc, void *host_pc);
 
-#define CPU_RESOLVING_TYPE TYPE_HPPA_CPU
-
 static inline vaddr hppa_form_gva_mask(uint64_t gva_offset_mask,
                                        uint64_t spc, target_ulong off)
 {
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 786957fadd0..eba184035d4 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2813,8 +2813,6 @@ void cpu_x86_update_dr7(CPUX86State *env, uint32_t new_dr7);
 /* hw/pc.c */
 uint64_t cpu_get_tsc(CPUX86State *env);
 
-#define CPU_RESOLVING_TYPE TYPE_X86_CPU
-
 #ifdef TARGET_X86_64
 #define TARGET_DEFAULT_CPU_TYPE X86_CPU_TYPE_NAME("qemu64")
 #else
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index c592f698853..5d79ea836bf 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -553,6 +553,4 @@ static inline void set_pc(CPULoongArchState *env, uint64_t value)
 #define HW_FLAGS_VA32       0x20
 #define HW_FLAGS_EUEN_ASXE  0x40
 
-#define CPU_RESOLVING_TYPE TYPE_LOONGARCH_CPU
-
 #endif /* LOONGARCH_CPU_H */
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 7cf3791108c..b3962910ad1 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -579,8 +579,6 @@ enum {
     ACCESS_DATA  = 0x20, /* Data load/store access        */
 };
 
-#define CPU_RESOLVING_TYPE TYPE_M68K_CPU
-
 /* MMU modes definitions */
 #define MMU_KERNEL_IDX 0
 #define MMU_USER_IDX 1
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index b9602f72b94..00ceaf1acf7 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -401,8 +401,6 @@ void mb_tcg_init(void);
 void mb_translate_code(CPUState *cs, TranslationBlock *tb,
                        int *max_insns, vaddr pc, void *host_pc);
 
-#define CPU_RESOLVING_TYPE TYPE_MICROBLAZE_CPU
-
 /* MMU modes definitions */
 #define MMU_NOMMU_IDX   0
 #define MMU_KERNEL_IDX  1
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 32549791a18..0d2846eaf58 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1359,8 +1359,6 @@ enum {
  */
 #define CPU_INTERRUPT_WAKE CPU_INTERRUPT_TGT_INT_0
 
-#define CPU_RESOLVING_TYPE TYPE_MIPS_CPU
-
 bool cpu_type_supports_cps_smp(const char *cpu_type);
 bool cpu_supports_isa(const CPUMIPSState *env, uint64_t isa_mask);
 bool cpu_type_supports_isa(const char *cpu_type, uint64_t isa);
diff --git a/target/or1k/cpu.h b/target/or1k/cpu.h
index fc4387ce7ae..34586755baf 100644
--- a/target/or1k/cpu.h
+++ b/target/or1k/cpu.h
@@ -320,8 +320,6 @@ void cpu_openrisc_count_start(OpenRISCCPU *cpu);
 void cpu_openrisc_count_stop(OpenRISCCPU *cpu);
 #endif
 
-#define CPU_RESOLVING_TYPE TYPE_OPENRISC_CPU
-
 #define TB_FLAGS_SM    SR_SM
 #define TB_FLAGS_DME   SR_DME
 #define TB_FLAGS_IME   SR_IME
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 217b4f334e5..c11d64677df 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -29,8 +29,6 @@
 #include "qom/object.h"
 #include "hw/core/registerfields.h"
 
-#define CPU_RESOLVING_TYPE TYPE_POWERPC_CPU
-
 #define TARGET_PAGE_BITS_64K 16
 #define TARGET_PAGE_BITS_16M 24
 
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index a97f30793b9..034d7e96c49 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -36,8 +36,6 @@
 
 typedef struct CPUArchState CPURISCVState;
 
-#define CPU_RESOLVING_TYPE TYPE_RISCV_CPU
-
 /*
  * b0: Whether a instruction always raise a store AMO or not.
  */
diff --git a/target/rx/cpu.h b/target/rx/cpu.h
index 233615c32dc..49188c36c57 100644
--- a/target/rx/cpu.h
+++ b/target/rx/cpu.h
@@ -144,8 +144,6 @@ struct RXCPUClass {
     ResettablePhases parent_phases;
 };
 
-#define CPU_RESOLVING_TYPE TYPE_RX_CPU
-
 const char *rx_crname(uint8_t cr);
 void rx_cpu_do_interrupt(CPUState *cpu);
 bool rx_cpu_exec_interrupt(CPUState *cpu, int int_req);
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 998bbb0d7ff..c77b297a26a 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -860,9 +860,6 @@ static inline uint8_t s390_cpu_get_state(const S390CPU *cpu)
 }
 
 
-/* helper.c */
-#define CPU_RESOLVING_TYPE TYPE_S390_CPU
-
 /* interrupt.c */
 #define RA_IGNORED                  0
 void s390_program_interrupt(CPUS390XState *env, uint32_t code, uintptr_t ra);
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index d440aa6dbe7..eaf67fe8e6a 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -304,8 +304,6 @@ int cpu_sh4_is_cached(CPUSH4State *env, uint32_t addr);
 
 void cpu_load_tlb(CPUSH4State * env);
 
-#define CPU_RESOLVING_TYPE TYPE_SUPERH_CPU
-
 /* MMU modes definitions */
 #define MMU_USER_IDX 1
 
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 31a16c2af03..fd409e74948 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -663,8 +663,6 @@ hwaddr cpu_get_phys_page_nofault(CPUSPARCState *env, target_ulong addr,
 #endif
 #endif
 
-#define CPU_RESOLVING_TYPE TYPE_SPARC_CPU
-
 /* MMU modes definitions */
 #if defined (TARGET_SPARC64)
 #define MMU_USER_IDX   0
diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index 12e497d2a7a..346b0e1f3f3 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -257,8 +257,6 @@ void tricore_tcg_init(void);
 void tricore_translate_code(CPUState *cs, TranslationBlock *tb,
                             int *max_insns, vaddr pc, void *host_pc);
 
-#define CPU_RESOLVING_TYPE TYPE_TRICORE_CPU
-
 /* helpers.c */
 bool tricore_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                           MMUAccessType access_type, int mmu_idx,
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 0b2cb5a250d..ee8d9c10b16 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -603,8 +603,6 @@ G_NORETURN void xtensa_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
                                                uintptr_t retaddr);
 G_NORETURN void xtensa_exception(CPUXtensaState *env, uint32_t excp);
 
-#define CPU_RESOLVING_TYPE TYPE_XTENSA_CPU
-
 #if TARGET_BIG_ENDIAN
 #define XTENSA_DEFAULT_CPU_MODEL "fsf"
 #define XTENSA_DEFAULT_CPU_NOMMU_MODEL "fsf"
-- 
2.52.0.windows.1


