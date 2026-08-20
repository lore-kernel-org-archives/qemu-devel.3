Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA618C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 20:17:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx9An-0006zx-3d; Thu, 20 Aug 2026 16:15:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wx9Al-0006vn-BG
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 16:15:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wx9Ah-0002hk-OE
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 16:15:35 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KK7q0l3941379
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 20:15:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LWQwdDV2fkgFjhmKLwyo93xfsCf8ZqnI4jIB05mjxx8=; b=QrFNjvV7I+dnZhZv
 RmFAmX0DwQdNmBnjYk89UzgbUIhSr0AKChxNrYs+qw/wHOM/7/Qi07lZzelwLuBu
 GW4olpPXV/M9txB8mmIb97Uw4LsgCduNYk/Mfosll6Fig4wny5ZZtqSE47X+r9pS
 sjrz3TOR2MIFJjKr47AWO5FjLFyQPnhYjmmRHaRjN5AkXDMAEDqkU1rNHcr1I1Ie
 HpD7ztS9gN4On3nxndNyBCHiIo/9D1XOMqToaEbgMBzrhWOINKPQS+XwFTIqWc81
 kWLna5qVQOw2/VIFEDfC8bHKLfgF+sPSuzE4zbbNUj4PUVEkcAA3pbo40JOanEg6
 voIz5Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5vh7ujmr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 20:15:20 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-52cd0374265so3862891cf.1
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 13:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787256919; x=1787861719; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LWQwdDV2fkgFjhmKLwyo93xfsCf8ZqnI4jIB05mjxx8=;
 b=cVpC5psV9K8l7uWbJxJnGaLmwfrsfBef8zCq++TkGzPM4ciRNIF/tiaIg3p5tm3s0T
 i2EbLO1+nUDWOLm1edaCJKdnKC6WcGgqTN2q9ZvAJBr4YNThzEjmxhc/lfIgNBoanhTH
 WyqLkxlXu/3yv54/f/gztobngAFBmwysqi7x+amhi4s4x9mKJZfSqqtucdfLqQ+85T0d
 1/+Titw4yrxCDpo5dDrcx3IpHL9xO/4BfmfQWFRoppnIkolotdpRZNTmsK/GIBe6aNcB
 9VpZaezvFLvjmeXqQIvZwYD6CXPMM08gkBcfV5kNYopFj7A5IyMFqzBsL2EzphKjYyT3
 CCoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787256919; x=1787861719;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LWQwdDV2fkgFjhmKLwyo93xfsCf8ZqnI4jIB05mjxx8=;
 b=I5HoiQbyEDiGvl9tylVhnD62/r6lLZUAry0EEsVGfBoH8DG6cubBvNQaQF+0bUa54Y
 Wq8CnStVpifHIES6ice8Zkki5m73nuE+dOdQx0ap7kEHFRkolsu0E4z4nO+gmmgCHRSK
 buWUkKU78EfgC4HEwM7gsH3XgaITvcDZarcyPds6IB4sYMpqv+YokS7rRPAkfd8A8CAy
 +XWzLdMjt9FUIF7+pKwwso/hOM0QpPo8Wz1ObnWeTwJ6kzmdMZ9bDNYcn3mEwKCgsnZ2
 1NvY0pXzJ8IfTo8LQrFYWAQki02NmPLQldbxaHRcIRwTHoMHFULSQFyFWHrjKBZIpgQu
 Xkvg==
X-Gm-Message-State: AOJu0YzJD84HP42slg0ozIo2YwqtLThDXg6HdEWSSPv7HqHSLDnYbQcx
 LHWn0EmoKCJ9lCBbJKssVc77VVC0CADVWeX7S+juHqNjaIDm73TNcAXylPWphdwcK2vslXFH8aZ
 pRUYSElIKjQKtFcMIjFUOeUstCzo1AgbM+bZHBGXmswkWXxFp0PBl8MdOSXMr1zUaBCS0
X-Gm-Gg: AR+sD13UOBIuIAc5iFSp2DSW45izBUuhtxRDBDvKJBZM46SqS4XdxGoYZaeWuwxXaW0
 qpR4g59oLCNAwkNQbDbx1/9FQUHLxEIPKVbAboHzvvD0ju5Lz3XXB3gRY8Hh+Hk0E2u0lVW3AE/
 Ylka4fc4u+rFqfjtnSyGPtslLrWsgUUnPobjRUSSoIRBBHT9OAC4zpEd9Ec9Q2wwDZr8uQ5q/y/
 mKDdijQVJo8P9IFP/XlVoNy2QfDV/U+dvfUkS8o/QyepVnhg6kqD2z5vvq5lfBfSwkLqU0WcLBY
 B8QLAytPrjlwai9Z6Ej/mjfC/8gIpLyDxdBIw4w1t2T/E4Ota0VikPoJpymE8AUN85Fu+mWU2Gx
 16G+l6Ze70H+yzrvKcpgUdBUMDjsF++gQm7l8n8EBDw==
X-Received: by 2002:a05:622a:144c:b0:517:a7ff:935f with SMTP id
 d75a77b69052e-52df565f835mr9789151cf.9.1787256918973; 
 Thu, 20 Aug 2026 13:15:18 -0700 (PDT)
X-Received: by 2002:a05:622a:144c:b0:517:a7ff:935f with SMTP id
 d75a77b69052e-52df565f835mr9788371cf.9.1787256918246; 
 Thu, 20 Aug 2026 13:15:18 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14b8022sm12321331f8f.18.2026.08.20.13.15.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 20 Aug 2026 13:15:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
Subject: [PATCH v2 10/15] target/riscv: Constify CPURISCVState for various
 cpu_*() getters
Date: Thu, 20 Aug 2026 22:13:50 +0200
Message-ID: <20260820201356.29775-11-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820201356.29775-1-philmd@oss.qualcomm.com>
References: <20260820201356.29775-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE1MiBTYWx0ZWRfX7VfzT2/kl7Mv
 JsuVyXz92XqJqOS9fgy8KjXqIKLz1HE2d/R7Td4MboRtVVKEPaTqdF7Ot0aypaBqmNP3h2vQgqQ
 pjGgejAmO3V/HRfypfSaIRzN6C8LFNSiZyeAWSafE6j/qVxYUmajLckWbnentHM8EJL8JEOMOML
 UChBqVuKr4I/7AhofPnsdhDtynlb8Tv3t0CO+8MxF5xCLj/BsapaIhsk5+bEfZNeUyYkhj0sKvY
 R+nZJXh4DDbgK5f7440WphkqS0lf4xljz7Pb3HezrEebjgwaECM4t2uvg6/O3BdbLU36aawa0NC
 21MbEMNGDdtlh0hJtr2pw6jEM+5lHtvf06T8fRai9yujZkhNgjD5KxRvcvLirS+YQbgvA2LJ07N
 8VZw0bcjICCTL0dbrPVF/bAlj05ay6d8xaJjCnfByzo2EP7jAjRDdXTXzURUBELQEQWiUmkdH0C
 8UZMkglr2QN0C8zmFEw==
X-Proofpoint-ORIG-GUID: AlN0pHgt2KoRrvns_Dii1LLdpFFokvrq
X-Authority-Analysis: v=2.4 cv=Y7fIdBeN c=1 sm=1 tr=0 ts=6a876058 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=T9gU_B0lrst8XM-M1voA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE1MiBTYWx0ZWRfXxYpM9cnK64jt
 ZekOiIFZcZXZlNq58pjv+o9uHRn24OFqFp8hxloiXIntwEvPR3dXEqDVysdtT1IrZlPCKQylPfK
 /oOiGoyDRsKD+j/MscofwkBjUroBtlo=
X-Proofpoint-GUID: AlN0pHgt2KoRrvns_Dii1LLdpFFokvrq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_02,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200152
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
 target/riscv/cpu.h | 27 ++++++++++++++-------------
 target/riscv/cpu.c | 13 ++++++-------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index bb4c8563554..c51e0d5f919 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -636,11 +636,11 @@ int riscv_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
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
 
@@ -746,20 +746,20 @@ FIELD(EXT_TB_FLAGS, BIG_ENDIAN, 33, 1)
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
 
@@ -769,7 +769,8 @@ static inline privilege_mode_t cpu_address_mode(CPURISCVState *env)
     return mode;
 }
 
-static inline RISCVMXL cpu_get_xl(CPURISCVState *env, privilege_mode_t mode)
+static inline RISCVMXL cpu_get_xl(const CPURISCVState *env,
+                                  privilege_mode_t mode)
 {
     RISCVMXL xl = env->misa_mxl;
     /*
@@ -797,7 +798,7 @@ static inline RISCVMXL cpu_get_xl(CPURISCVState *env, privilege_mode_t mode)
 #if defined(TARGET_RISCV32)
 #define cpu_recompute_xl(env)  ((void)(env), MXL_RV32)
 #else
-static inline RISCVMXL cpu_recompute_xl(CPURISCVState *env)
+static inline RISCVMXL cpu_recompute_xl(const CPURISCVState *env)
 {
 #if !defined(CONFIG_USER_ONLY)
     return cpu_get_xl(env, env->priv);
@@ -810,7 +811,7 @@ static inline RISCVMXL cpu_recompute_xl(CPURISCVState *env)
 #if defined(TARGET_RISCV32)
 #define cpu_address_xl(env)  ((void)(env), MXL_RV32)
 #else
-static inline RISCVMXL cpu_address_xl(CPURISCVState *env)
+static inline RISCVMXL cpu_address_xl(const CPURISCVState *env)
 {
 #ifdef CONFIG_USER_ONLY
     return env->xl;
@@ -822,7 +823,7 @@ static inline RISCVMXL cpu_address_xl(CPURISCVState *env)
 }
 #endif
 
-static inline uint16_t riscv_cpu_xlen(CPURISCVState *env)
+static inline uint16_t riscv_cpu_xlen(const CPURISCVState *env)
 {
     return 16 << env->xl;
 }
@@ -830,7 +831,7 @@ static inline uint16_t riscv_cpu_xlen(CPURISCVState *env)
 #ifdef TARGET_RISCV32
 #define riscv_cpu_sxl(env)  ((void)(env), MXL_RV32)
 #else
-static inline RISCVMXL riscv_cpu_sxl(CPURISCVState *env)
+static inline RISCVMXL riscv_cpu_sxl(const CPURISCVState *env)
 {
 #ifdef CONFIG_USER_ONLY
     return env->misa_mxl;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 858fbf865fd..4abf20d057a 100644
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
@@ -952,8 +952,7 @@ int riscv_cpu_vsirq_pending(CPURISCVState *env)
 
 static bool riscv_cpu_has_work(CPUState *cs)
 {
-    RISCVCPU *cpu = RISCV_CPU(cs);
-    CPURISCVState *env = &cpu->env;
+    CPURISCVState *env = cpu_env(cs);
     /*
      * Definition of the WFI instruction requires it to ignore the privilege
      * mode and delegation registers, but respect individual enables
-- 
2.53.0


