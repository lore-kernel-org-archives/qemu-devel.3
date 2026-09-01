Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE9CC61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 09:56:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1LCV-00036V-5L; Tue, 01 Sep 2026 05:54:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1LCT-00031W-2M
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 05:54:41 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1LCP-0007jQ-DK
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 05:54:39 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68179HGU1975447
 for <qemu-devel@nongnu.org>; Tue, 1 Sep 2026 09:54:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LlN7DBlJH2rNs5BonSHdBtLWwwfelN+OMDpoUJfdbI4=; b=dt0CvFD/aSBwkw1d
 44ZVkVlwXKqCoMMl9vC8t8W0CVv4s2vJG3mOPrfp3TRX6/XN4OWNhpcmbOgOuDxA
 Nd5FMrOWTnjD5F9UQcwSNDcEgJ1pHWR9LE5HdDk9xdK4D+UdCmgO9Y4m6g7cct+5
 xOriXOqyDiKf8736XFXI2VxSLkqn5z+pK5UV7xbt2l4LHsKZtfgbHn7yw/hDI48D
 iLySUHLoSZyXsoLZENJuRObm/hv8QKTSF1F/STFAOhUDxjjr+FZab6dAk1oKnY8v
 WfyQBWpW6Bs/WIC8w1qJjAmPCpcx07eyyvlfO7QEnelYRmBXV5HSa4+jkENJ4lxY
 vfd7NA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdp7r1pcq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 09:54:36 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-934963b2bc0so711457185a.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 02:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788256476; x=1788861276; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LlN7DBlJH2rNs5BonSHdBtLWwwfelN+OMDpoUJfdbI4=;
 b=Smtb8kXZsD78pOhtBZj8alsZdAJVD87ybMRFqUP24CUycvziPtaaqmxGKVs0TvfK7J
 OlBSvuadkZCK7EIpboqw37zuawnIzpTsvK923Z0J/+ya495ayErsHco9w/2I2AzzJPm5
 Z4lS2Qml5gqpf9dYPHYAYiLqLoMhdBqU1pdlKoWkReJ2uU3hh9wj5UkGLDTvr7uhpD+t
 hHJhJXEJPTLt5uioC/AqxAPLkrnVln0ExnSolqp8xl8SkvrFIvYBV6NM+9P80Jkhz0Tw
 7PtzMQ94Zske6+FIEKxwZdX2MKFx0BPQVocrsDmRRZQZr7U+N13T9k66EHVEH/xrcWJX
 G0XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788256476; x=1788861276;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LlN7DBlJH2rNs5BonSHdBtLWwwfelN+OMDpoUJfdbI4=;
 b=MLPnxRZvtuAwha5tjFmfKm6i4BlDA/e4yYKzPUvWccrXCkHHarEcZjQYE7wArUudp9
 M0/Gsi++0j5pyJUqc90SiIUQzplJEwExx8LNvyfJfqQYhLZU9LdtI51ITY24jwi0IZI7
 vwAzTS4s6iuZpXsYa8u2+ii55bhlwOI5GnWigcFXbQU6YCjri2Hz2ONsqHvtXX3kpCgg
 88XXEgVtC/ElDJGEtVxgoeSR1HpZm352x5SkAxs63q7knnCPjDc57L4gpjbwfUlfBVeY
 EBKWWjRAKfJ1lBHLbvVYKr8Z0oI+I+LybhJc0cQdgipV8pYwnC58+6DPitT+36cE4JdH
 5AaQ==
X-Gm-Message-State: AFuF++lhjdx4uWrsVrNgpvUiYNA5OCEJPVR/2wi2MtwW7Bkt2vfOQxos
 PkaayISfVAU7cnWncOb78WXfMTZDTcBTKt0ijKM5mVSsgjhwqE2a01eum5A4FyKATLA2eYU3NCn
 vWiFAQDxQ6UISvhUJIKxPmmHH8gSs3nWd+UNQf0c4N2m7qXzHvpwtfB1cZ2cNAf0Vew==
X-Gm-Gg: AR+sD10YSr7yVfHM65Y3RyRcpT7lA7CQSLJb5tGD+kvFUZqNoFx4fj7oOMQiOuuRnst
 8BoN1Itn4LtxbFpgOJ7Wr/oltz6K4ePsySLVMen/LfYoJhEWAtahLJt9Obkq3+vYRR+/QBEXEL6
 Sn/sqxa7MuCNjEPCb/6NgIR1MpwfTzLgVJAALFvUMhq5fL9+2ZPrWTxZULZJaIKKS8TLxyAMx0y
 iNroCiwrHmkegEE8oKCWPZog/vLS+VlLx6uDph0rHSh0780j9ZkOxONBCu1WB04IVY85Z/09GJ0
 hRRmG+OcthNJ70jy6zQPmROt+1n1Jlu3aHZV1sxJWWwp9t2wGcpGHQSNOyBTtvaci7CA7Vu0HkO
 yOv7OTp2NpED6lg2kg2bZA+zvsWkrvJVAuZVCThT+
X-Received: by 2002:a05:620a:25ca:b0:936:b923:4832 with SMTP id
 af79cd13be357-93948132b78mr906567285a.28.1788256475332; 
 Tue, 01 Sep 2026 02:54:35 -0700 (PDT)
X-Received: by 2002:a05:620a:25ca:b0:936:b923:4832 with SMTP id
 af79cd13be357-93948132b78mr906532185a.28.1788256469831; 
 Tue, 01 Sep 2026 02:54:29 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48442d3b4f1sm3409552f8f.9.2026.09.01.02.54.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Sep 2026 02:54:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org
Subject: [PATCH v5 16/21] target/riscv: Constify CPURISCVState for various
 cpu_*() getters
Date: Tue,  1 Sep 2026 11:52:22 +0200
Message-ID: <20260901095229.72018-17-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901095229.72018-1-philmd@oss.qualcomm.com>
References: <20260901095229.72018-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=beZbluPB c=1 sm=1 tr=0 ts=6a96a0dc cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=5sohHe0BYKnhtT-QaPIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA4NyBTYWx0ZWRfXzLQgtGGLgqzd
 mr8IQ59niRXypMYK0bWjue9Wf1gUbeYLuAGei6hnruCyOF2fzeEOrXs5C5NHI439MInNjnDPuFZ
 TSlPpki8m8twUJtFdX4R4Z5YofP3QRD3r/9m7xtUSh7hIe1GtG7n6T08nhGrurZ3ex/FVRSs/Qg
 62+lOwazVfFfFmp6GMXLpz+zmVkTp9UWdYjP3NDFL5CzPLHUHZPYRGrKkS9oCMqwySIOjO5jZke
 t6B87IaxHmYX7dm9wTPuV6wy4ijXT44BtKWFXwFfF2kjJeeA9wk5sHqjaLA/wmN1uZ32IZ0LamX
 6lsHsiYng8HOUXyh7fq7qzZxN78tqbVjxZfMSApW5hZJgOgnmQlvnouFASmAYxI/nn76ancIKea
 FQY0hBdVGHzR5eqPElWpaHJwN2Yl6dTNaVUo+0fHPDNdAxyKRraJeWdh+AKR080lZLyYbTlko6T
 sMQqSyPDm9O7iaAJfJA==
X-Proofpoint-GUID: kKE5lacH1_KwLcGJLCrRnjcT47LybIzi
X-Proofpoint-ORIG-GUID: kKE5lacH1_KwLcGJLCrRnjcT47LybIzi
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA4NyBTYWx0ZWRfX27Ii34LB1oet
 +McTGRqwx4KbS/LIPLcd4zDi160V/nVlkUPbPGViePCTNemUAwnLDOwMvu1jiENIhX8gxHZte++
 62FB7XJK47bIQCxsj6rMlTzy0u+tZF4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_02,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010087
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
index b974c2f4b4f..eb40526f99e 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -640,22 +640,22 @@ int riscv_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
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
@@ -685,7 +685,8 @@ void riscv_cpu_set_rnmi(RISCVCPU *cpu, uint32_t irq, bool level);
 void riscv_cpu_interrupt(CPURISCVState *env);
 #define BOOL_TO_MASK(x) (-!!(x)) /* helper for riscv_cpu_update_mip value */
 
-RISCVException smstateen_acc_ok(CPURISCVState *env, int index, uint64_t bit);
+RISCVException smstateen_acc_ok(const CPURISCVState *env,
+                                int index, uint64_t bit);
 #endif /* !CONFIG_USER_ONLY */
 
 void riscv_cpu_set_mode(CPURISCVState *env, privilege_mode_t newpriv,
@@ -750,20 +751,20 @@ FIELD(EXT_TB_FLAGS, BIG_ENDIAN, 33, 1)
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
 
@@ -773,7 +774,8 @@ static inline privilege_mode_t cpu_address_mode(CPURISCVState *env)
     return mode;
 }
 
-static inline RISCVMXL cpu_get_xl(CPURISCVState *env, privilege_mode_t mode)
+static inline RISCVMXL cpu_get_xl(const CPURISCVState *env,
+                                  privilege_mode_t mode)
 {
     RISCVMXL xl = env->misa_mxl;
     /*
@@ -801,7 +803,7 @@ static inline RISCVMXL cpu_get_xl(CPURISCVState *env, privilege_mode_t mode)
 #if defined(TARGET_RISCV32)
 #define cpu_recompute_xl(env)  ((void)(env), MXL_RV32)
 #else
-static inline RISCVMXL cpu_recompute_xl(CPURISCVState *env)
+static inline RISCVMXL cpu_recompute_xl(const CPURISCVState *env)
 {
 #if !defined(CONFIG_USER_ONLY)
     return cpu_get_xl(env, env->priv);
@@ -814,7 +816,7 @@ static inline RISCVMXL cpu_recompute_xl(CPURISCVState *env)
 #if defined(TARGET_RISCV32)
 #define cpu_address_xl(env)  ((void)(env), MXL_RV32)
 #else
-static inline RISCVMXL cpu_address_xl(CPURISCVState *env)
+static inline RISCVMXL cpu_address_xl(const CPURISCVState *env)
 {
 #ifdef CONFIG_USER_ONLY
     return env->xl;
@@ -826,7 +828,7 @@ static inline RISCVMXL cpu_address_xl(CPURISCVState *env)
 }
 #endif
 
-static inline uint16_t riscv_cpu_xlen(CPURISCVState *env)
+static inline uint16_t riscv_cpu_xlen(const CPURISCVState *env)
 {
     return 16 << env->xl;
 }
@@ -834,7 +836,7 @@ static inline uint16_t riscv_cpu_xlen(CPURISCVState *env)
 #ifdef TARGET_RISCV32
 #define riscv_cpu_sxl(env)  ((void)(env), MXL_RV32)
 #else
-static inline RISCVMXL riscv_cpu_sxl(CPURISCVState *env)
+static inline RISCVMXL riscv_cpu_sxl(const CPURISCVState *env)
 {
 #ifdef CONFIG_USER_ONLY
     return env->misa_mxl;
@@ -857,7 +859,8 @@ static inline RISCVMXL riscv_cpu_sxl(CPURISCVState *env)
  * Returns true if the effective privilege mode is modified.
  */
 static inline QEMU_ALWAYS_INLINE
-bool riscv_cpu_eff_priv(CPURISCVState *env, privilege_mode_t *priv, bool *virt)
+bool riscv_cpu_eff_priv(const CPURISCVState *env,
+                        privilege_mode_t *priv, bool *virt)
 {
     privilege_mode_t mode = env->priv;
     bool virt_enabled = false;
@@ -929,9 +932,9 @@ static inline uint32_t vext_get_vlmax(uint32_t vlenb, uint32_t vsew,
 
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
index 953e598babb..6004da4ac33 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -867,7 +867,7 @@ uint8_t riscv_cpu_default_priority(int irq)
     return default_iprio[irq] ? default_iprio[irq] : IPRIO_MMAXIPRIO;
 };
 
-int riscv_cpu_pending_to_irq(CPURISCVState *env,
+int riscv_cpu_pending_to_irq(const CPURISCVState *env,
                              int extirq, unsigned int extirq_def_prio,
                              uint64_t pending, const uint8_t *iprio)
 {
@@ -911,7 +911,7 @@ int riscv_cpu_pending_to_irq(CPURISCVState *env,
  * using hvip bits 13:63 from HS-mode. Those are returned in
  * riscv_cpu_sirq_pending() and riscv_cpu_vsirq_pending().
  */
-uint64_t riscv_cpu_all_pending(CPURISCVState *env)
+uint64_t riscv_cpu_all_pending(const CPURISCVState *env)
 {
     uint32_t gein = get_field(env->hstatus, HSTATUS_VGEIN);
     uint64_t vsgein = (env->hgeip & (1ULL << gein)) ? MIP_VSEIP : 0;
@@ -920,7 +920,7 @@ uint64_t riscv_cpu_all_pending(CPURISCVState *env)
     return (env->mip | vsgein | vstip) & env->mie;
 }
 
-int riscv_cpu_mirq_pending(CPURISCVState *env)
+int riscv_cpu_mirq_pending(const CPURISCVState *env)
 {
     uint64_t irqs = riscv_cpu_all_pending(env) & ~env->mideleg &
                     ~(MIP_SGEIP | MIP_VSSIP | MIP_VSTIP | MIP_VSEIP);
@@ -929,7 +929,7 @@ int riscv_cpu_mirq_pending(CPURISCVState *env)
                                     irqs, env->miprio);
 }
 
-int riscv_cpu_sirq_pending(CPURISCVState *env)
+int riscv_cpu_sirq_pending(const CPURISCVState *env)
 {
     uint64_t irqs = riscv_cpu_all_pending(env) & env->mideleg & ~env->hideleg;
     uint64_t irqs_f = env->mvip & env->mvien & ~env->mideleg & env->sie;
@@ -938,7 +938,7 @@ int riscv_cpu_sirq_pending(CPURISCVState *env)
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
index 002f7e69c1f..f341865fb81 100644
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


