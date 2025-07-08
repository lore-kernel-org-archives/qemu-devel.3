Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7090C83F0F
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:50:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFAk-00041P-2x; Tue, 08 Jul 2025 16:44:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZDmy-0003zz-Jq
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:15:40 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZDmq-00075R-Hz
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:15:35 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ae361e8ec32so947455666b.3
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 12:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752002126; x=1752606926; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0gtjLUYRZC3tiIyt5N+e81IMf+FihJ1F/GhQqo/oKqE=;
 b=OGOZXvGNEbc1ashzdGKC4Y15AeQTHRERF43o3jrG7Q4fUs/grfoHx59CgwDVovm+Ca
 YI0t8UCHFXtzrOTm8o4S1zISnRErx8VBQbPqdlhI16cZ5VDna2/vK1aSYQJ4j/k4rFFc
 I87a/BN7dx6IKhWq9oFtDieXLjwVp7rshjCC9rjWWhSWvUHqKcxd2wKOPYT27drEumDx
 qEosaWpop/fSBUgcGONEt5MeJx777Uq6hEgk4DpkFMTlW8UFRYbOCZ1JC2bOuJOwx1jT
 pW+EzLNrlM71ipG/vb9E8+KMqGl47U4LU+IyMB9BLxjD0XxzCrrd+G1F8ZWI9kmuDcJo
 lIaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752002126; x=1752606926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0gtjLUYRZC3tiIyt5N+e81IMf+FihJ1F/GhQqo/oKqE=;
 b=sNSIwVd6Tmsmk3zbJmstUVGPrdU7bwLxiw7cXaD/Y6OuY1tkJF5uYy0lIDJyBO5hNa
 8834x7ARnnY8ZUsYGChJHOmSIoFQ4HBnfw+pDCbD6XNGifiYNEM8MILbWmoqmqe43joT
 SwcXHXHDwMwGBTZh09B6Vz/Pg0EHjH/LxBiof6LPtuddAl6+TaG9H69zM1yaJ0cxGq0I
 c4NINGdoNiYczfSw+HXblf6LvUNM5FV+STUh8iC/9y61rwU9e5xMMVhZUyypWM2lRcuU
 OjBW8kxTiwBzinUbu4dgtQu/mC5+bOQNlddtUVOmG9pD8/26eiNQWzpHJ0eF84CxZ2PY
 TlcA==
X-Gm-Message-State: AOJu0YwKjuqRZDVSFNX1n5yWMwgl7a1w7Whs0zukXXgTe+cYtkv4/P+g
 i5lWQ9yrFgHPcS2fJetSeY1sN9H4jHlsXWd0iz7mvztsgjLXe/r++TpOl1aP99dTHZ2yp3IM3Tf
 XZUGZfpA=
X-Gm-Gg: ASbGncu9pu7yZGKc2b79htoZYTTivm0rHdZUcij/BQgmYR7TYOuJ0CNAB6jyiVGkaNR
 i0gq0/9TBiVu0hZkKJx4eTVzhYX8rwlPXwgVxaHKh4GKDfj0Ix94gXkDztnQRCqrpF99xi2HyCJ
 zFnUKdeIREFgFQrkJcF9C5x/lPm51kY5iGpnp1+6x8wDLjlXRYku3HoCFxh5cRz3wYwVUEZLQFk
 ezKIRdNd+sKr0HfvB/gHfjoGkxsaQzInhN44n62XrlKxwEFWSQJ8XK0klGGwQqZKEv5BHKwZrp6
 lgv+Dk/QtCUy8/w/kARkMbOK215R6NFXi6v1IF2/HUlSGgWrL/omXB07kfytSouaV2Ili0rIqAI
 me0ptNDMKqdv4AdN2XElufihkjH7GWMJU1RiZF1OzM4VeG+k=
X-Google-Smtp-Source: AGHT+IHNet9Gcr6aA+JnHGX1DVui8k6E4JrZ3kOWqRaqFuiKkhvvSKgOm1PU0Mo9hm/eR2iCKKudUg==
X-Received: by 2002:a05:600c:64ca:b0:43d:fa58:81d3 with SMTP id
 5b1f17b1804b1-454cd5461a7mr18264785e9.32.1751968687334; 
 Tue, 08 Jul 2025 02:58:07 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454cd49398csm17085535e9.22.2025.07.08.02.58.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 08 Jul 2025 02:58:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/4] target/s390x: Extract system internal declarations to
 s390x-internal.h
Date: Tue,  8 Jul 2025 11:57:46 +0200
Message-ID: <20250708095746.12697-5-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250708095746.12697-1-philmd@linaro.org>
References: <20250708095746.12697-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Simplify a bit the big "s390x-internal.h" header by extracting
system-specific declarations to "s390x-system.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/s390x-internal.h | 222 +---------------------------------
 target/s390x/s390x-system.h   | 215 ++++++++++++++++++++++++++++++++
 2 files changed, 217 insertions(+), 220 deletions(-)
 create mode 100644 target/s390x/s390x-system.h

diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.h
index 56cce2e7f50..dddd4460400 100644
--- a/target/s390x/s390x-internal.h
+++ b/target/s390x/s390x-internal.h
@@ -14,89 +14,8 @@
 #include "fpu/softfloat.h"
 
 #ifndef CONFIG_USER_ONLY
-typedef struct LowCore {
-    /* prefix area: defined by architecture */
-    uint32_t        ccw1[2];                  /* 0x000 */
-    uint32_t        ccw2[4];                  /* 0x008 */
-    uint8_t         pad1[0x80 - 0x18];        /* 0x018 */
-    uint32_t        ext_params;               /* 0x080 */
-    uint16_t        cpu_addr;                 /* 0x084 */
-    uint16_t        ext_int_code;             /* 0x086 */
-    uint16_t        svc_ilen;                 /* 0x088 */
-    uint16_t        svc_code;                 /* 0x08a */
-    uint16_t        pgm_ilen;                 /* 0x08c */
-    uint16_t        pgm_code;                 /* 0x08e */
-    uint32_t        data_exc_code;            /* 0x090 */
-    uint16_t        mon_class_num;            /* 0x094 */
-    uint16_t        per_perc_atmid;           /* 0x096 */
-    uint64_t        per_address;              /* 0x098 */
-    uint8_t         exc_access_id;            /* 0x0a0 */
-    uint8_t         per_access_id;            /* 0x0a1 */
-    uint8_t         op_access_id;             /* 0x0a2 */
-    uint8_t         ar_access_id;             /* 0x0a3 */
-    uint8_t         pad2[0xA8 - 0xA4];        /* 0x0a4 */
-    uint64_t        trans_exc_code;           /* 0x0a8 */
-    uint64_t        monitor_code;             /* 0x0b0 */
-    uint16_t        subchannel_id;            /* 0x0b8 */
-    uint16_t        subchannel_nr;            /* 0x0ba */
-    uint32_t        io_int_parm;              /* 0x0bc */
-    uint32_t        io_int_word;              /* 0x0c0 */
-    uint8_t         pad3[0xc8 - 0xc4];        /* 0x0c4 */
-    uint32_t        stfl_fac_list;            /* 0x0c8 */
-    uint8_t         pad4[0xe8 - 0xcc];        /* 0x0cc */
-    uint64_t        mcic;                     /* 0x0e8 */
-    uint8_t         pad5[0xf4 - 0xf0];        /* 0x0f0 */
-    uint32_t        external_damage_code;     /* 0x0f4 */
-    uint64_t        failing_storage_address;  /* 0x0f8 */
-    uint8_t         pad6[0x110 - 0x100];      /* 0x100 */
-    uint64_t        per_breaking_event_addr;  /* 0x110 */
-    uint8_t         pad7[0x120 - 0x118];      /* 0x118 */
-    PSW             restart_old_psw;          /* 0x120 */
-    PSW             external_old_psw;         /* 0x130 */
-    PSW             svc_old_psw;              /* 0x140 */
-    PSW             program_old_psw;          /* 0x150 */
-    PSW             mcck_old_psw;             /* 0x160 */
-    PSW             io_old_psw;               /* 0x170 */
-    uint8_t         pad8[0x1a0 - 0x180];      /* 0x180 */
-    PSW             restart_new_psw;          /* 0x1a0 */
-    PSW             external_new_psw;         /* 0x1b0 */
-    PSW             svc_new_psw;              /* 0x1c0 */
-    PSW             program_new_psw;          /* 0x1d0 */
-    PSW             mcck_new_psw;             /* 0x1e0 */
-    PSW             io_new_psw;               /* 0x1f0 */
-    uint8_t         pad13[0x11b0 - 0x200];    /* 0x200 */
-
-    uint64_t        mcesad;                    /* 0x11B0 */
-
-    /* 64 bit extparam used for pfault, diag 250 etc  */
-    uint64_t        ext_params2;               /* 0x11B8 */
-
-    uint8_t         pad14[0x1200 - 0x11C0];    /* 0x11C0 */
-
-    /* System info area */
-
-    uint64_t        floating_pt_save_area[16]; /* 0x1200 */
-    uint64_t        gpregs_save_area[16];      /* 0x1280 */
-    uint32_t        st_status_fixed_logout[4]; /* 0x1300 */
-    uint8_t         pad15[0x1318 - 0x1310];    /* 0x1310 */
-    uint32_t        prefixreg_save_area;       /* 0x1318 */
-    uint32_t        fpt_creg_save_area;        /* 0x131c */
-    uint8_t         pad16[0x1324 - 0x1320];    /* 0x1320 */
-    uint32_t        tod_progreg_save_area;     /* 0x1324 */
-    uint64_t        cpu_timer_save_area;       /* 0x1328 */
-    uint64_t        clock_comp_save_area;      /* 0x1330 */
-    uint8_t         pad17[0x1340 - 0x1338];    /* 0x1338 */
-    uint32_t        access_regs_save_area[16]; /* 0x1340 */
-    uint64_t        cregs_save_area[16];       /* 0x1380 */
-
-    /* align to the top of the prefix area */
-
-    uint8_t         pad18[0x2000 - 0x1400];    /* 0x1400 */
-} QEMU_PACKED LowCore;
-QEMU_BUILD_BUG_ON(sizeof(LowCore) != 8192);
-#endif /* CONFIG_USER_ONLY */
-
-#define MAX_ILEN 6
+#include "s390x-system.h"
+#endif
 
 /* While the PoO talks about ILC (a number between 1-3) what is actually
    stored in LowCore is shifted left one bit (an even between 2-6).  As
@@ -116,18 +35,6 @@ static inline int get_ilen(uint8_t opc)
     }
 }
 
-/* Compute the ATMID field that is stored in the per_perc_atmid lowcore
-   entry when a PER exception is triggered.  */
-static inline uint8_t get_per_atmid(CPUS390XState *env)
-{
-    return ((env->psw.mask & PSW_MASK_64) ?       (1 << 7) : 0) |
-                                                  (1 << 6)      |
-           ((env->psw.mask & PSW_MASK_32) ?       (1 << 5) : 0) |
-           ((env->psw.mask & PSW_MASK_DAT) ?      (1 << 4) : 0) |
-           ((env->psw.mask & PSW_ASC_SECONDARY) ? (1 << 3) : 0) |
-           ((env->psw.mask & PSW_ASC_ACCREG) ?    (1 << 2) : 0);
-}
-
 static inline uint64_t wrap_address(CPUS390XState *env, uint64_t a)
 {
     if (!(env->psw.mask & PSW_MASK_64)) {
@@ -201,55 +108,11 @@ enum cc_op {
     CC_OP_MAX
 };
 
-#ifndef CONFIG_USER_ONLY
-
-static inline hwaddr decode_basedisp_s(CPUS390XState *env, uint32_t ipb,
-                                       uint8_t *ar)
-{
-    hwaddr addr = 0;
-    uint8_t reg;
-
-    reg = ipb >> 28;
-    if (reg > 0) {
-        addr = env->regs[reg];
-    }
-    addr += (ipb >> 16) & 0xfff;
-    if (ar) {
-        *ar = reg;
-    }
-
-    return addr;
-}
-
-/* Base/displacement are at the same locations. */
-#define decode_basedisp_rs decode_basedisp_s
-
-#endif /* CONFIG_USER_ONLY */
-
-/* arch_dump.c */
-int s390_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
-                              int cpuid, DumpState *s);
-
-
 /* cc_helper.c */
 const char *cc_name(enum cc_op cc_op);
 uint32_t calc_cc(CPUS390XState *env, uint32_t cc_op, uint64_t src, uint64_t dst,
                  uint64_t vr);
 
-/* cpu.c */
-#ifndef CONFIG_USER_ONLY
-unsigned int s390_count_running_cpus(void);
-void s390_cpu_halt(S390CPU *cpu);
-void s390_cpu_unhalt(S390CPU *cpu);
-void s390_cpu_system_init(Object *obj);
-bool s390_cpu_system_realize(DeviceState *dev, Error **errp);
-void s390_cpu_finalize(Object *obj);
-void s390_cpu_system_class_init(CPUClass *cc);
-void s390_cpu_machine_reset_cb(void *opaque);
-bool s390_cpu_has_work(CPUState *cs);
-#endif /* CONFIG_USER_ONLY */
-
-
 /* cpu_models.c */
 void s390_cpu_model_class_register_props(ObjectClass *oc);
 void s390_realize_cpu_model(CPUState *cs, Error **errp);
@@ -257,11 +120,7 @@ S390CPUModel *get_max_cpu_model(Error **errp);
 void apply_cpu_model(const S390CPUModel *model, Error **errp);
 ObjectClass *s390_cpu_class_by_name(const char *name);
 
-
-/* excp_helper.c */
-void s390x_cpu_debug_excp_handler(CPUState *cs);
 void s390_cpu_do_interrupt(CPUState *cpu);
-bool s390_cpu_exec_interrupt(CPUState *cpu, int int_req);
 
 #ifdef CONFIG_USER_ONLY
 void s390_cpu_record_sigsegv(CPUState *cs, vaddr address,
@@ -312,87 +171,14 @@ int s390_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int s390_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void s390_cpu_gdb_init(CPUState *cs);
 
-
-/* helper.c */
 void s390_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
-void do_restart_interrupt(CPUS390XState *env);
-#ifndef CONFIG_USER_ONLY
-void s390_cpu_recompute_watchpoints(CPUState *cs);
-void s390x_tod_timer(void *opaque);
-void s390x_cpu_timer(void *opaque);
-void s390_handle_wait(S390CPU *cpu);
-hwaddr s390_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
-hwaddr s390_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
-#define S390_STORE_STATUS_DEF_ADDR offsetof(LowCore, floating_pt_save_area)
-int s390_store_status(S390CPU *cpu, hwaddr addr, bool store_arch);
-int s390_store_adtl_status(S390CPU *cpu, hwaddr addr, hwaddr len);
-LowCore *cpu_map_lowcore(CPUS390XState *env);
-void cpu_unmap_lowcore(LowCore *lowcore);
-#endif /* CONFIG_USER_ONLY */
-
 
 /* interrupt.c */
 void trigger_pgm_exception(CPUS390XState *env, uint32_t code);
-#ifndef CONFIG_USER_ONLY
-void cpu_inject_clock_comparator(S390CPU *cpu);
-void cpu_inject_cpu_timer(S390CPU *cpu);
-void cpu_inject_emergency_signal(S390CPU *cpu, uint16_t src_cpu_addr);
-int cpu_inject_external_call(S390CPU *cpu, uint16_t src_cpu_addr);
-bool s390_cpu_has_io_int(S390CPU *cpu);
-bool s390_cpu_has_ext_int(S390CPU *cpu);
-bool s390_cpu_has_mcck_int(S390CPU *cpu);
-bool s390_cpu_has_int(S390CPU *cpu);
-bool s390_cpu_has_restart_int(S390CPU *cpu);
-bool s390_cpu_has_stop_int(S390CPU *cpu);
-void cpu_inject_restart(S390CPU *cpu);
-void cpu_inject_stop(S390CPU *cpu);
-#endif /* CONFIG_USER_ONLY */
 
-
-/* ioinst.c */
-#ifndef CONFIG_USER_ONLY
-void ioinst_handle_xsch(S390CPU *cpu, uint64_t reg1, uintptr_t ra);
-void ioinst_handle_csch(S390CPU *cpu, uint64_t reg1, uintptr_t ra);
-void ioinst_handle_hsch(S390CPU *cpu, uint64_t reg1, uintptr_t ra);
-void ioinst_handle_msch(S390CPU *cpu, uint64_t reg1, uint32_t ipb,
-                        uintptr_t ra);
-void ioinst_handle_ssch(S390CPU *cpu, uint64_t reg1, uint32_t ipb,
-                        uintptr_t ra);
-void ioinst_handle_stcrw(S390CPU *cpu, uint32_t ipb, uintptr_t ra);
-void ioinst_handle_stsch(S390CPU *cpu, uint64_t reg1, uint32_t ipb,
-                         uintptr_t ra);
-int ioinst_handle_tsch(S390CPU *cpu, uint64_t reg1, uint32_t ipb, uintptr_t ra);
-void ioinst_handle_chsc(S390CPU *cpu, uint32_t ipb, uintptr_t ra);
-void ioinst_handle_schm(S390CPU *cpu, uint64_t reg1, uint64_t reg2,
-                        uint32_t ipb, uintptr_t ra);
-void ioinst_handle_rsch(S390CPU *cpu, uint64_t reg1, uintptr_t ra);
-void ioinst_handle_rchp(S390CPU *cpu, uint64_t reg1, uintptr_t ra);
-void ioinst_handle_sal(S390CPU *cpu, uint64_t reg1, uintptr_t ra);
-#endif /* CONFIG_USER_ONLY */
-
-
-/* mem_helper.c */
-target_ulong mmu_real2abs(CPUS390XState *env, target_ulong raddr);
 void probe_write_access(CPUS390XState *env, uint64_t addr, uint64_t len,
                         uintptr_t ra);
 
-
-/* mmu_helper.c */
-bool mmu_absolute_addr_valid(target_ulong addr, bool is_write);
-/* Special access mode only valid for mmu_translate() */
-#define MMU_S390_LRA        -1
-int mmu_translate(CPUS390XState *env, target_ulong vaddr, int rw, uint64_t asc,
-                  target_ulong *raddr, int *flags, uint64_t *tec);
-int mmu_translate_real(CPUS390XState *env, target_ulong raddr, int rw,
-                       target_ulong *addr, int *flags, uint64_t *tec);
-
-
-/* misc_helper.c */
-int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3);
-void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3,
-                     uintptr_t ra);
-
-
 /* translate.c */
 void s390x_translate_init(void);
 void s390x_translate_code(CPUState *cs, TranslationBlock *tb,
@@ -401,8 +187,4 @@ void s390x_restore_state_to_opc(CPUState *cs,
                                 const TranslationBlock *tb,
                                 const uint64_t *data);
 
-/* sigp.c */
-int handle_sigp(CPUS390XState *env, uint8_t order, uint64_t r1, uint64_t r3);
-void do_stop_interrupt(CPUS390XState *env);
-
 #endif /* S390X_INTERNAL_H */
diff --git a/target/s390x/s390x-system.h b/target/s390x/s390x-system.h
new file mode 100644
index 00000000000..9c7958742d3
--- /dev/null
+++ b/target/s390x/s390x-system.h
@@ -0,0 +1,215 @@
+/*
+ * s390x system internal definitions and helpers
+ *
+ * Copyright (c) 2009 Ulrich Hecht
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef S390X_SYSTEM_H
+#define S390X_SYSTEM_H
+
+typedef struct LowCore {
+    /* prefix area: defined by architecture */
+    uint32_t        ccw1[2];                  /* 0x000 */
+    uint32_t        ccw2[4];                  /* 0x008 */
+    uint8_t         pad1[0x80 - 0x18];        /* 0x018 */
+    uint32_t        ext_params;               /* 0x080 */
+    uint16_t        cpu_addr;                 /* 0x084 */
+    uint16_t        ext_int_code;             /* 0x086 */
+    uint16_t        svc_ilen;                 /* 0x088 */
+    uint16_t        svc_code;                 /* 0x08a */
+    uint16_t        pgm_ilen;                 /* 0x08c */
+    uint16_t        pgm_code;                 /* 0x08e */
+    uint32_t        data_exc_code;            /* 0x090 */
+    uint16_t        mon_class_num;            /* 0x094 */
+    uint16_t        per_perc_atmid;           /* 0x096 */
+    uint64_t        per_address;              /* 0x098 */
+    uint8_t         exc_access_id;            /* 0x0a0 */
+    uint8_t         per_access_id;            /* 0x0a1 */
+    uint8_t         op_access_id;             /* 0x0a2 */
+    uint8_t         ar_access_id;             /* 0x0a3 */
+    uint8_t         pad2[0xA8 - 0xA4];        /* 0x0a4 */
+    uint64_t        trans_exc_code;           /* 0x0a8 */
+    uint64_t        monitor_code;             /* 0x0b0 */
+    uint16_t        subchannel_id;            /* 0x0b8 */
+    uint16_t        subchannel_nr;            /* 0x0ba */
+    uint32_t        io_int_parm;              /* 0x0bc */
+    uint32_t        io_int_word;              /* 0x0c0 */
+    uint8_t         pad3[0xc8 - 0xc4];        /* 0x0c4 */
+    uint32_t        stfl_fac_list;            /* 0x0c8 */
+    uint8_t         pad4[0xe8 - 0xcc];        /* 0x0cc */
+    uint64_t        mcic;                     /* 0x0e8 */
+    uint8_t         pad5[0xf4 - 0xf0];        /* 0x0f0 */
+    uint32_t        external_damage_code;     /* 0x0f4 */
+    uint64_t        failing_storage_address;  /* 0x0f8 */
+    uint8_t         pad6[0x110 - 0x100];      /* 0x100 */
+    uint64_t        per_breaking_event_addr;  /* 0x110 */
+    uint8_t         pad7[0x120 - 0x118];      /* 0x118 */
+    PSW             restart_old_psw;          /* 0x120 */
+    PSW             external_old_psw;         /* 0x130 */
+    PSW             svc_old_psw;              /* 0x140 */
+    PSW             program_old_psw;          /* 0x150 */
+    PSW             mcck_old_psw;             /* 0x160 */
+    PSW             io_old_psw;               /* 0x170 */
+    uint8_t         pad8[0x1a0 - 0x180];      /* 0x180 */
+    PSW             restart_new_psw;          /* 0x1a0 */
+    PSW             external_new_psw;         /* 0x1b0 */
+    PSW             svc_new_psw;              /* 0x1c0 */
+    PSW             program_new_psw;          /* 0x1d0 */
+    PSW             mcck_new_psw;             /* 0x1e0 */
+    PSW             io_new_psw;               /* 0x1f0 */
+    uint8_t         pad13[0x11b0 - 0x200];    /* 0x200 */
+
+    uint64_t        mcesad;                    /* 0x11B0 */
+
+    /* 64 bit extparam used for pfault, diag 250 etc  */
+    uint64_t        ext_params2;               /* 0x11B8 */
+
+    uint8_t         pad14[0x1200 - 0x11C0];    /* 0x11C0 */
+
+    /* System info area */
+
+    uint64_t        floating_pt_save_area[16]; /* 0x1200 */
+    uint64_t        gpregs_save_area[16];      /* 0x1280 */
+    uint32_t        st_status_fixed_logout[4]; /* 0x1300 */
+    uint8_t         pad15[0x1318 - 0x1310];    /* 0x1310 */
+    uint32_t        prefixreg_save_area;       /* 0x1318 */
+    uint32_t        fpt_creg_save_area;        /* 0x131c */
+    uint8_t         pad16[0x1324 - 0x1320];    /* 0x1320 */
+    uint32_t        tod_progreg_save_area;     /* 0x1324 */
+    uint64_t        cpu_timer_save_area;       /* 0x1328 */
+    uint64_t        clock_comp_save_area;      /* 0x1330 */
+    uint8_t         pad17[0x1340 - 0x1338];    /* 0x1338 */
+    uint32_t        access_regs_save_area[16]; /* 0x1340 */
+    uint64_t        cregs_save_area[16];       /* 0x1380 */
+
+    /* align to the top of the prefix area */
+
+    uint8_t         pad18[0x2000 - 0x1400];    /* 0x1400 */
+} QEMU_PACKED LowCore;
+QEMU_BUILD_BUG_ON(sizeof(LowCore) != 8192);
+
+#define MAX_ILEN 6
+
+/* Compute the ATMID field that is stored in the per_perc_atmid lowcore
+   entry when a PER exception is triggered.  */
+static inline uint8_t get_per_atmid(CPUS390XState *env)
+{
+    return ((env->psw.mask & PSW_MASK_64) ?       (1 << 7) : 0) |
+                                                  (1 << 6)      |
+           ((env->psw.mask & PSW_MASK_32) ?       (1 << 5) : 0) |
+           ((env->psw.mask & PSW_MASK_DAT) ?      (1 << 4) : 0) |
+           ((env->psw.mask & PSW_ASC_SECONDARY) ? (1 << 3) : 0) |
+           ((env->psw.mask & PSW_ASC_ACCREG) ?    (1 << 2) : 0);
+}
+
+static inline hwaddr decode_basedisp_s(CPUS390XState *env, uint32_t ipb,
+                                       uint8_t *ar)
+{
+    hwaddr addr = 0;
+    uint8_t reg;
+
+    reg = ipb >> 28;
+    if (reg > 0) {
+        addr = env->regs[reg];
+    }
+    addr += (ipb >> 16) & 0xfff;
+    if (ar) {
+        *ar = reg;
+    }
+
+    return addr;
+}
+
+/* Base/displacement are at the same locations. */
+#define decode_basedisp_rs decode_basedisp_s
+
+/* arch_dump.c */
+int s390_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
+                              int cpuid, DumpState *s);
+
+/* cpu.c */
+unsigned int s390_count_running_cpus(void);
+void s390_cpu_halt(S390CPU *cpu);
+void s390_cpu_unhalt(S390CPU *cpu);
+void s390_cpu_system_init(Object *obj);
+bool s390_cpu_system_realize(DeviceState *dev, Error **errp);
+void s390_cpu_finalize(Object *obj);
+void s390_cpu_system_class_init(CPUClass *cc);
+void s390_cpu_machine_reset_cb(void *opaque);
+bool s390_cpu_has_work(CPUState *cs);
+
+/* excp_helper.c */
+void s390x_cpu_debug_excp_handler(CPUState *cs);
+bool s390_cpu_exec_interrupt(CPUState *cpu, int int_req);
+
+/* helper.c */
+void do_restart_interrupt(CPUS390XState *env);
+void s390_cpu_recompute_watchpoints(CPUState *cs);
+void s390x_tod_timer(void *opaque);
+void s390x_cpu_timer(void *opaque);
+void s390_handle_wait(S390CPU *cpu);
+hwaddr s390_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
+hwaddr s390_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
+#define S390_STORE_STATUS_DEF_ADDR offsetof(LowCore, floating_pt_save_area)
+int s390_store_status(S390CPU *cpu, hwaddr addr, bool store_arch);
+int s390_store_adtl_status(S390CPU *cpu, hwaddr addr, hwaddr len);
+LowCore *cpu_map_lowcore(CPUS390XState *env);
+void cpu_unmap_lowcore(LowCore *lowcore);
+
+void cpu_inject_clock_comparator(S390CPU *cpu);
+void cpu_inject_cpu_timer(S390CPU *cpu);
+void cpu_inject_emergency_signal(S390CPU *cpu, uint16_t src_cpu_addr);
+int cpu_inject_external_call(S390CPU *cpu, uint16_t src_cpu_addr);
+bool s390_cpu_has_io_int(S390CPU *cpu);
+bool s390_cpu_has_ext_int(S390CPU *cpu);
+bool s390_cpu_has_mcck_int(S390CPU *cpu);
+bool s390_cpu_has_int(S390CPU *cpu);
+bool s390_cpu_has_restart_int(S390CPU *cpu);
+bool s390_cpu_has_stop_int(S390CPU *cpu);
+void cpu_inject_restart(S390CPU *cpu);
+void cpu_inject_stop(S390CPU *cpu);
+
+/* ioinst.c */
+void ioinst_handle_xsch(S390CPU *cpu, uint64_t reg1, uintptr_t ra);
+void ioinst_handle_csch(S390CPU *cpu, uint64_t reg1, uintptr_t ra);
+void ioinst_handle_hsch(S390CPU *cpu, uint64_t reg1, uintptr_t ra);
+void ioinst_handle_msch(S390CPU *cpu, uint64_t reg1, uint32_t ipb,
+                        uintptr_t ra);
+void ioinst_handle_ssch(S390CPU *cpu, uint64_t reg1, uint32_t ipb,
+                        uintptr_t ra);
+void ioinst_handle_stcrw(S390CPU *cpu, uint32_t ipb, uintptr_t ra);
+void ioinst_handle_stsch(S390CPU *cpu, uint64_t reg1, uint32_t ipb,
+                         uintptr_t ra);
+int ioinst_handle_tsch(S390CPU *cpu, uint64_t reg1, uint32_t ipb, uintptr_t ra);
+void ioinst_handle_chsc(S390CPU *cpu, uint32_t ipb, uintptr_t ra);
+void ioinst_handle_schm(S390CPU *cpu, uint64_t reg1, uint64_t reg2,
+                        uint32_t ipb, uintptr_t ra);
+void ioinst_handle_rsch(S390CPU *cpu, uint64_t reg1, uintptr_t ra);
+void ioinst_handle_rchp(S390CPU *cpu, uint64_t reg1, uintptr_t ra);
+void ioinst_handle_sal(S390CPU *cpu, uint64_t reg1, uintptr_t ra);
+
+/* mem_helper.c */
+target_ulong mmu_real2abs(CPUS390XState *env, target_ulong raddr);
+
+/* mmu_helper.c */
+bool mmu_absolute_addr_valid(target_ulong addr, bool is_write);
+/* Special access mode only valid for mmu_translate() */
+#define MMU_S390_LRA        -1
+int mmu_translate(CPUS390XState *env, target_ulong vaddr, int rw, uint64_t asc,
+                  target_ulong *raddr, int *flags, uint64_t *tec);
+int mmu_translate_real(CPUS390XState *env, target_ulong raddr, int rw,
+                       target_ulong *addr, int *flags, uint64_t *tec);
+
+/* misc_helper.c */
+int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3);
+void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3,
+                     uintptr_t ra);
+
+/* sigp.c */
+int handle_sigp(CPUS390XState *env, uint8_t order, uint64_t r1, uint64_t r3);
+void do_stop_interrupt(CPUS390XState *env);
+
+#endif
-- 
2.49.0


