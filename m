Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2422EC5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:20:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wySiv-0008JV-Au; Mon, 24 Aug 2026 07:20:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wySis-0007uu-Bd
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 07:20:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wySio-0006F5-3p
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 07:20:14 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67O99vEq2573334
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 11:19:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yn9tfVl6mWyICfLH/wDJ4L2OJF6t/A2t+MMp7YKcLFQ=; b=fNfgMfmclXZ8g1JX
 zqwJpaNqNDsn/HGD6hQvB3VAwpDh3T3QUtnNqUeNozi6W1w4UrCByjQR3qMG7V6x
 b8nUJg+FIln+fAIJVEL4PBNp5ejvCKJatZ0k3K44yhfceKQ42H7R8kZTIyC6w+k9
 GNFbONrRbG4BxZ7a3kH5hLWH22Ls1ofwZr6EtNBvVk+jU97DbW/MawyPe1Fj29aV
 OL4EYCQRlc/7oijECQ9cC/IUfrnqO4+PJ+CE2yfXJTM0tw0cjw0UTYQo+/BMBE1n
 GMgpXYyYVtD68nrv/p0qYAUT1Fq99Le7tzd8NKK+Zv1oUCraWBO/iP+sPd79k4RS
 U/PyjQ==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8bdr25wp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 11:19:59 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-977fa96a0a6so266696241.3
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 04:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787570398; x=1788175198; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yn9tfVl6mWyICfLH/wDJ4L2OJF6t/A2t+MMp7YKcLFQ=;
 b=VdpgTikzlWLBXCen7jOL4ASjkPDZoZcObiDy2eGdNkcXI4qm/BMXtIcCV4SZt/XmTy
 pLPDrYMYnDxsNQXCcTWMGxgocMM0rqRidU7DfWdsdazmO6Y+/3tAydyjslNocwgYW1h3
 LKq8tpt2JqypbDVkOI+lx2ABOtlIJ7GNhiCgApzNJgUM8167j53nHUoR5kwcj1SD0IMP
 K+Kq/Mco5oxCmOKZUIcuFjR4oWc3rSOKVXWPAvcjGH2cZVhJsjneQMHars10YBy/tVcD
 CT5ILyKqMsHzorvwSnHINQoMt/KnD/8LnWY224w9V9WA9Y6Enq4nnXkllcO7bh7ilz+s
 7i0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787570398; x=1788175198;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yn9tfVl6mWyICfLH/wDJ4L2OJF6t/A2t+MMp7YKcLFQ=;
 b=NStiGX6Wkm8B9jtMgBLej7qRtgNP/ymy5snwrQBh7rfRQ8UoXBG2LI2LJdL/qfi6KH
 bVDUHIRRL4mtcBYapseB3l9Xz1YSAnqGoIq6CuGZhOsetPfOhgpPYSfY7cUP95VET9v+
 kEWozX2hZGGopPBwGnakU5wfh2/My9T1VZ7CzfN2/V0ug6P79HOT6/tb7TvMjcpFuGfB
 JOCwA7VxrKn5nMRomEGpRG6QJ+y9kZrk+SXO2jUOkXS+5/2IdbPY2k0guMnQ0gvUtUDJ
 0UF4SHiCqId8clyXTRiH2nFGygW2kBFEe4T+VmjIx3pRFCzOSBPZCd2INmMK3DEBHnzC
 JdTQ==
X-Gm-Message-State: AFuF++nuK8kzTVUX3UGw43i3z7C2+LF3Ic8paL76ACiax9Ys3fTxr4S4
 3hAJhkQwequZR5i1Sbx1Jpy93K9yf3714lXt6VfymEM3kgNWYKuWCAKjVBjKDWCF4LILeuaOEyT
 dCdZF2J4LLhZbB7eOCS+Id9t+LBjUHyVqmrqz2eXwtACRpUp+xs7TTfjwGMSMckhehg==
X-Gm-Gg: AR+sD10PBH7h893kbqfRZvJ4yPuju2igOFk0haykc8DJcpc12ryHBRc+ccUdy6U3CPv
 Q14AE75PhVMHEjOmDtQH4qgwJQ5X5PwfXcfl8bt6ea6Qwi0w9WW2ab83bB1y/pfnucilc8HbEi4
 GDHGQ8eQB8cr44HIGkxgmqfeO/7WUXmk762vHWHPtps+tFY6Dji3GFiTSjInEdBOrGcl82DHanv
 ZiKHoVlKtauOTAEshhhgM0U5LVKK8Muis5Yp5wAosQhHbvPlHWR3ex4Qk2gebvXeUCikhzociEX
 Mbv0m4zXaa//ievuKMAzCMG6l/y1zXZhlQa+fByjJ6PMECMFP6kIqJKjTSESsTWIPiTR+88V1Wz
 Kx9s9OpjfzuDklojZiRkCWrkvgF97ZFeBrVBv35WOTcpOuYWDcQ==
X-Received: by 2002:a05:6102:5812:b0:778:93f7:57e1 with SMTP id
 ada2fe7eead31-77a620270cbmr7561200137.3.1787570398186; 
 Mon, 24 Aug 2026 04:19:58 -0700 (PDT)
X-Received: by 2002:a05:6102:5812:b0:778:93f7:57e1 with SMTP id
 ada2fe7eead31-77a620270cbmr7561179137.3.1787570397631; 
 Mon, 24 Aug 2026 04:19:57 -0700 (PDT)
Received: from localhost.localdomain (44.170.88.92.rev.sfr.net. [92.88.170.44])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59dd550bcsm8905383a12.0.2026.08.24.04.19.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Aug 2026 04:19:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
Subject: [PATCH v4 15/20] target/riscv: Constify CPURISCVState for various
 cpu_*() getters
Date: Mon, 24 Aug 2026 13:17:04 +0200
Message-ID: <20260824111711.26297-16-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824111711.26297-1-philmd@oss.qualcomm.com>
References: <20260824111711.26297-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA5NCBTYWx0ZWRfX+Vy97bTMtzZl
 4fxy59ht+mPVeigaEedzDdqmYy18Q9kON8AY88a3vEp9mtHmn12XCUTrMshpJXAoeaWqSvme46W
 3cBGAvLB7UYi8up6F5ZRYrlWMslrnAiF+EzuKqlQKQI4y0tEmIWyyB8RQQ5jtwmYkDhu+0NGm0B
 Mfp9eOQPRT7ZDJwup0LVDWkr47ZjcxOcD9niROUFRLGu+CEucGu3FwIK5WzMaaFYUBhRx6Yv1+i
 d5Qt1qNOYYoXZ7WJ9/AUir6BrojfX767pJvSSqEkdzmpYLfFWq+iP9LJCS4QYZqtR8WxHQPVblk
 PF1T7jkA7F66Mg20NUsyc5J2fK2V3Oc0djNcb0Onerdx6a7ypmGHvYYXXjTHE/UsqvWGVCTEe53
 bR9bUPhbivvHyXdkk3MU/RT71M8gtyCMK90soTRFCcy+Xic92JOpMlzXYJsVjQXYrukWck1/KNy
 7V6N8Oq29Pn7TUbewXw==
X-Proofpoint-GUID: X72sPl2hioRWFMFgUPKkUZMvIrG45heV
X-Proofpoint-ORIG-GUID: X72sPl2hioRWFMFgUPKkUZMvIrG45heV
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA5NCBTYWx0ZWRfXy/gH/O1d1XqL
 DhC3OsXZbZh949b9bczgBEe5zsuVV4uwBtAI7laTO/+gUmIOQTTgcbb3NbIwJPjYqz4P9SRs5YS
 vNF6ih+uZbLMXx3yEqQnx5Juzrx4ISw=
X-Authority-Analysis: v=2.4 cv=W8cIkxWk c=1 sm=1 tr=0 ts=6a8c28df cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=s1NLoHz9uzatdv2VNqxUSg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=5sohHe0BYKnhtT-QaPIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240094
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add the const qualifier to CPURISCVState when the
argument is accessed without modification.
Simplify directly using cpu_env() in riscv_cpu_has_work().

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 target/riscv/cpu.h            | 51 ++++++++++++++++++-----------------
 target/riscv/internals.h      |  2 +-
 target/riscv/cpu.c            | 10 +++----
 target/riscv/tcg/cpu_helper.c | 18 ++++++-------
 target/riscv/tcg/csr.c        |  3 ++-
 5 files changed, 44 insertions(+), 40 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index bb4c8563554..61d987f4ac7 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -636,22 +636,22 @@ int riscv_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int riscv_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 int riscv_cpu_hviprio_index2irq(int index, int *out_irq, int *out_rdzero);
 uint8_t riscv_cpu_default_priority(int irq);
-uint64_t riscv_cpu_all_pending(CPURISCVState *env);
-int riscv_cpu_mirq_pending(CPURISCVState *env);
-int riscv_cpu_sirq_pending(CPURISCVState *env);
-int riscv_cpu_vsirq_pending(CPURISCVState *env);
-int riscv_cpu_pending_to_irq(CPURISCVState *env,
+uint64_t riscv_cpu_all_pending(const CPURISCVState *env);
+int riscv_cpu_mirq_pending(const CPURISCVState *env);
+int riscv_cpu_sirq_pending(const CPURISCVState *env);
+int riscv_cpu_vsirq_pending(const CPURISCVState *env);
+int riscv_cpu_pending_to_irq(const CPURISCVState *env,
                              int extirq, unsigned int extirq_def_prio,
                              uint64_t pending, const uint8_t *iprio);
 
 
-bool riscv_cpu_fp_enabled(CPURISCVState *env);
-bool riscv_cpu_vector_enabled(CPURISCVState *env);
+bool riscv_cpu_fp_enabled(const CPURISCVState *env);
+bool riscv_cpu_vector_enabled(const CPURISCVState *env);
 void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
-int riscv_env_mmu_index(CPURISCVState *env, bool ifetch);
-bool cpu_get_fcfien(CPURISCVState *env);
-bool cpu_get_bcfien(CPURISCVState *env);
-bool riscv_env_smode_dbltrp_enabled(CPURISCVState *env, bool virt);
+int riscv_env_mmu_index(const CPURISCVState *env, bool ifetch);
+bool cpu_get_fcfien(const CPURISCVState *env);
+bool cpu_get_bcfien(const CPURISCVState *env);
+bool riscv_env_smode_dbltrp_enabled(const CPURISCVState *env, bool virt);
 G_NORETURN void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
                                                MMUAccessType access_type,
                                                int mmu_idx, uintptr_t retaddr);
@@ -681,7 +681,8 @@ void riscv_cpu_set_rnmi(RISCVCPU *cpu, uint32_t irq, bool level);
 void riscv_cpu_interrupt(CPURISCVState *env);
 #define BOOL_TO_MASK(x) (-!!(x)) /* helper for riscv_cpu_update_mip value */
 
-RISCVException smstateen_acc_ok(CPURISCVState *env, int index, uint64_t bit);
+RISCVException smstateen_acc_ok(const CPURISCVState *env,
+                                int index, uint64_t bit);
 #endif /* !CONFIG_USER_ONLY */
 
 void riscv_cpu_set_mode(CPURISCVState *env, privilege_mode_t newpriv,
@@ -746,20 +747,20 @@ FIELD(EXT_TB_FLAGS, BIG_ENDIAN, 33, 1)
 #ifdef TARGET_RISCV32
 #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
 #else
-static inline RISCVMXL riscv_cpu_mxl(CPURISCVState *env)
+static inline RISCVMXL riscv_cpu_mxl(const CPURISCVState *env)
 {
     return env->misa_mxl;
 }
 #endif
 #define riscv_cpu_mxl_bits(env) (1UL << (4 + riscv_cpu_mxl(env)))
 
-static inline const RISCVCPUConfig *riscv_cpu_cfg(CPURISCVState *env)
+static inline const RISCVCPUConfig *riscv_cpu_cfg(const CPURISCVState *env)
 {
     return &env_archcpu(env)->cfg;
 }
 
 #if !defined(CONFIG_USER_ONLY)
-static inline privilege_mode_t cpu_address_mode(CPURISCVState *env)
+static inline privilege_mode_t cpu_address_mode(const CPURISCVState *env)
 {
     privilege_mode_t mode = env->priv;
 
@@ -769,7 +770,8 @@ static inline privilege_mode_t cpu_address_mode(CPURISCVState *env)
     return mode;
 }
 
-static inline RISCVMXL cpu_get_xl(CPURISCVState *env, privilege_mode_t mode)
+static inline RISCVMXL cpu_get_xl(const CPURISCVState *env,
+                                  privilege_mode_t mode)
 {
     RISCVMXL xl = env->misa_mxl;
     /*
@@ -797,7 +799,7 @@ static inline RISCVMXL cpu_get_xl(CPURISCVState *env, privilege_mode_t mode)
 #if defined(TARGET_RISCV32)
 #define cpu_recompute_xl(env)  ((void)(env), MXL_RV32)
 #else
-static inline RISCVMXL cpu_recompute_xl(CPURISCVState *env)
+static inline RISCVMXL cpu_recompute_xl(const CPURISCVState *env)
 {
 #if !defined(CONFIG_USER_ONLY)
     return cpu_get_xl(env, env->priv);
@@ -810,7 +812,7 @@ static inline RISCVMXL cpu_recompute_xl(CPURISCVState *env)
 #if defined(TARGET_RISCV32)
 #define cpu_address_xl(env)  ((void)(env), MXL_RV32)
 #else
-static inline RISCVMXL cpu_address_xl(CPURISCVState *env)
+static inline RISCVMXL cpu_address_xl(const CPURISCVState *env)
 {
 #ifdef CONFIG_USER_ONLY
     return env->xl;
@@ -822,7 +824,7 @@ static inline RISCVMXL cpu_address_xl(CPURISCVState *env)
 }
 #endif
 
-static inline uint16_t riscv_cpu_xlen(CPURISCVState *env)
+static inline uint16_t riscv_cpu_xlen(const CPURISCVState *env)
 {
     return 16 << env->xl;
 }
@@ -830,7 +832,7 @@ static inline uint16_t riscv_cpu_xlen(CPURISCVState *env)
 #ifdef TARGET_RISCV32
 #define riscv_cpu_sxl(env)  ((void)(env), MXL_RV32)
 #else
-static inline RISCVMXL riscv_cpu_sxl(CPURISCVState *env)
+static inline RISCVMXL riscv_cpu_sxl(const CPURISCVState *env)
 {
 #ifdef CONFIG_USER_ONLY
     return env->misa_mxl;
@@ -853,7 +855,8 @@ static inline RISCVMXL riscv_cpu_sxl(CPURISCVState *env)
  * Returns true if the effective privilege mode is modified.
  */
 static inline QEMU_ALWAYS_INLINE
-bool riscv_cpu_eff_priv(CPURISCVState *env, privilege_mode_t *priv, bool *virt)
+bool riscv_cpu_eff_priv(const CPURISCVState *env,
+                        privilege_mode_t *priv, bool *virt)
 {
     privilege_mode_t mode = env->priv;
     bool virt_enabled = false;
@@ -925,9 +928,9 @@ static inline uint32_t vext_get_vlmax(uint32_t vlenb, uint32_t vsew,
 
 bool riscv_cpu_is_32bit(RISCVCPU *cpu);
 
-bool riscv_cpu_virt_mem_enabled(CPURISCVState *env, bool is_vm_ldst);
-RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env);
-RISCVPmPmm riscv_pm_get_vm_ldst_pmm(CPURISCVState *env);
+bool riscv_cpu_virt_mem_enabled(const CPURISCVState *env, bool is_vm_ldst);
+RISCVPmPmm riscv_pm_get_pmm(const CPURISCVState *env);
+RISCVPmPmm riscv_pm_get_vm_ldst_pmm(const CPURISCVState *env);
 uint32_t riscv_pm_get_pmlen(RISCVPmPmm pmm);
 
 /*
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index fb2d8b3e17a..b9528209deb 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -66,7 +66,7 @@ static inline bool mmuidx_2stage(int mmu_idx)
  * Return the endianness for the current privilege
  * level, based on the MSTATUS MBE/SBE/UBE bits.
  */
-static inline MemOp mo_endian_env(CPURISCVState *env)
+static inline MemOp mo_endian_env(const CPURISCVState *env)
 {
     bool be = false;
 #if !defined(CONFIG_USER_ONLY)
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 858fbf865fd..278e00d260c 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -864,7 +864,7 @@ uint8_t riscv_cpu_default_priority(int irq)
     return default_iprio[irq] ? default_iprio[irq] : IPRIO_MMAXIPRIO;
 };
 
-int riscv_cpu_pending_to_irq(CPURISCVState *env,
+int riscv_cpu_pending_to_irq(const CPURISCVState *env,
                              int extirq, unsigned int extirq_def_prio,
                              uint64_t pending, const uint8_t *iprio)
 {
@@ -908,7 +908,7 @@ int riscv_cpu_pending_to_irq(CPURISCVState *env,
  * using hvip bits 13:63 from HS-mode. Those are returned in
  * riscv_cpu_sirq_pending() and riscv_cpu_vsirq_pending().
  */
-uint64_t riscv_cpu_all_pending(CPURISCVState *env)
+uint64_t riscv_cpu_all_pending(const CPURISCVState *env)
 {
     uint32_t gein = get_field(env->hstatus, HSTATUS_VGEIN);
     uint64_t vsgein = (env->hgeip & (1ULL << gein)) ? MIP_VSEIP : 0;
@@ -917,7 +917,7 @@ uint64_t riscv_cpu_all_pending(CPURISCVState *env)
     return (env->mip | vsgein | vstip) & env->mie;
 }
 
-int riscv_cpu_mirq_pending(CPURISCVState *env)
+int riscv_cpu_mirq_pending(const CPURISCVState *env)
 {
     uint64_t irqs = riscv_cpu_all_pending(env) & ~env->mideleg &
                     ~(MIP_SGEIP | MIP_VSSIP | MIP_VSTIP | MIP_VSEIP);
@@ -926,7 +926,7 @@ int riscv_cpu_mirq_pending(CPURISCVState *env)
                                     irqs, env->miprio);
 }
 
-int riscv_cpu_sirq_pending(CPURISCVState *env)
+int riscv_cpu_sirq_pending(const CPURISCVState *env)
 {
     uint64_t irqs = riscv_cpu_all_pending(env) & env->mideleg & ~env->hideleg;
     uint64_t irqs_f = env->mvip & env->mvien & ~env->mideleg & env->sie;
@@ -935,7 +935,7 @@ int riscv_cpu_sirq_pending(CPURISCVState *env)
                                     irqs | irqs_f, env->siprio);
 }
 
-int riscv_cpu_vsirq_pending(CPURISCVState *env)
+int riscv_cpu_vsirq_pending(const CPURISCVState *env)
 {
     uint64_t irqs = riscv_cpu_all_pending(env) & env->mideleg & env->hideleg;
     uint64_t irqs_f_vs = env->hvip & env->hvien & ~env->hideleg & env->vsie;
diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index 07d92226527..397beb356a9 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -39,7 +39,7 @@
 #include "pmp.h"
 #include "qemu/plugin.h"
 
-int riscv_env_mmu_index(CPURISCVState *env, bool ifetch)
+int riscv_env_mmu_index(const CPURISCVState *env, bool ifetch)
 {
 #ifdef CONFIG_USER_ONLY
     return 0;
@@ -63,7 +63,7 @@ int riscv_env_mmu_index(CPURISCVState *env, bool ifetch)
 #endif
 }
 
-bool cpu_get_fcfien(CPURISCVState *env)
+bool cpu_get_fcfien(const CPURISCVState *env)
 {
     /* no cfi extension, return false */
     if (!env_archcpu(env)->cfg.ext_zicfilp) {
@@ -90,7 +90,7 @@ bool cpu_get_fcfien(CPURISCVState *env)
     }
 }
 
-bool cpu_get_bcfien(CPURISCVState *env)
+bool cpu_get_bcfien(const CPURISCVState *env)
 {
     /* no cfi extension, return false */
     if (!env_archcpu(env)->cfg.ext_zicfiss) {
@@ -119,7 +119,7 @@ bool cpu_get_bcfien(CPURISCVState *env)
     }
 }
 
-bool riscv_env_smode_dbltrp_enabled(CPURISCVState *env, bool virt)
+bool riscv_env_smode_dbltrp_enabled(const CPURISCVState *env, bool virt)
 {
 #ifdef CONFIG_USER_ONLY
     return false;
@@ -163,7 +163,7 @@ bool riscv_env_smode_dbltrp_enabled(CPURISCVState *env, bool virt)
  *     M-mode:  mseccfg.PMM
  *     Other existing modes: disabled
  */
-RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)
+RISCVPmPmm riscv_pm_get_pmm(const CPURISCVState *env)
 {
 #ifndef CONFIG_USER_ONLY
     privilege_mode_t priv_mode;
@@ -215,7 +215,7 @@ RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)
 #endif
 }
 
-RISCVPmPmm riscv_pm_get_vm_ldst_pmm(CPURISCVState *env)
+RISCVPmPmm riscv_pm_get_vm_ldst_pmm(const CPURISCVState *env)
 {
 #ifndef CONFIG_USER_ONLY
     privilege_mode_t priv_mode;
@@ -241,7 +241,7 @@ RISCVPmPmm riscv_pm_get_vm_ldst_pmm(CPURISCVState *env)
 #endif
 }
 
-bool riscv_cpu_virt_mem_enabled(CPURISCVState *env, bool is_vm_ldst)
+bool riscv_cpu_virt_mem_enabled(const CPURISCVState *env, bool is_vm_ldst)
 {
 #ifndef CONFIG_USER_ONLY
     int satp_mode = 0;
@@ -426,7 +426,7 @@ bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 }
 
 /* Return true is floating point support is currently enabled */
-bool riscv_cpu_fp_enabled(CPURISCVState *env)
+bool riscv_cpu_fp_enabled(const CPURISCVState *env)
 {
     if (env->mstatus & MSTATUS_FS) {
         if (env->virt_enabled && !(env->mstatus_hs & MSTATUS_FS)) {
@@ -439,7 +439,7 @@ bool riscv_cpu_fp_enabled(CPURISCVState *env)
 }
 
 /* Return true is vector support is currently enabled */
-bool riscv_cpu_vector_enabled(CPURISCVState *env)
+bool riscv_cpu_vector_enabled(const CPURISCVState *env)
 {
     if (env->mstatus & MSTATUS_VS) {
         if (env->virt_enabled && !(env->mstatus_hs & MSTATUS_VS)) {
diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index 36f2004bc56..95e0aca313c 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -49,7 +49,8 @@ void riscv_set_csr_ops(int csrno, const riscv_csr_operations *ops)
 
 /* Predicates */
 #if !defined(CONFIG_USER_ONLY)
-RISCVException smstateen_acc_ok(CPURISCVState *env, int index, uint64_t bit)
+RISCVException smstateen_acc_ok(const CPURISCVState *env,
+                                int index, uint64_t bit)
 {
     bool virt = env->virt_enabled;
 
-- 
2.53.0


