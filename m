Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1ACEC5DF86
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 20:15:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx9AD-0005lM-Ct; Thu, 20 Aug 2026 16:15:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wx9AB-0005kw-Of
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 16:14:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wx9AA-0002JZ-69
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 16:14:59 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KK7Y353491355
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 20:14:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 omys+sjzsI02iJIWLB5L11LGUGEpkxHVCWBpSv/GVBA=; b=kxQDRD1qMWNa6Z8B
 sZ3H5DRpphqUCFfZTk74/sNHGAKo/Y480IMLt0W9628/DCs0GalMqi+D2yE1/MkR
 tsCk8kptRMnDzxL6MAZLeSCHOhy8LFaE/wdZyemF90+HtJ+LioEQEC0wgjFCahYu
 m4SQHuGzwzmcphYU4XxcKJqMkyW+Qyhj+rYf1AwIZiL/cSRemsXGEH11EwrDvHnQ
 taI+c+do3kpQNPw23b96OMOy1jAi84CYQD/6CJ9fFgwd/ybOwoSCZgcQlBkN70et
 OKcR6II1RIgm+M6aEovNFs01e3JKXKwhAaPrvEZPqmxP0Q9co0jsy53+Wh2HOlGi
 Uf1FSA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5ytcaqfw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 20:14:56 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-52ce3c7cb2eso3616271cf.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 13:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787256896; x=1787861696; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=omys+sjzsI02iJIWLB5L11LGUGEpkxHVCWBpSv/GVBA=;
 b=U4NpebAkjocFE5G/yF0PqBrGArVLPwRH1X40rFPjSU29UbEMoOLMOqhxSruQRVhHek
 EWEGvia3ufpRho+IkdOoZtd0Yx4k0q9tz5xQkprpVTSPVD7H3J6+Jr7GAO8Bcbpy+aDO
 +z5KFSSik5iu7p5OQwZz6fI1RipWlFZLTORkaQqgPZY4sym3XNrfbbwHslRjK0ohhrbx
 61bJPmRRXOFBOjX6XAK01uuQxlOsWuMNaXAOOgODOr4262jMx2LXvkWnfjg1XqC03E2D
 PTkKpvVgZ6j9zVm1dqbTFyP6y0KgzFgiHvCEU1d86B5KlbkCmh2qPAbOzPlq9SOG1yeu
 vQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787256896; x=1787861696;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=omys+sjzsI02iJIWLB5L11LGUGEpkxHVCWBpSv/GVBA=;
 b=DvtUY0eEu/bD0gACXtQJxlVmDJmistSjmlBx0F/c4ceq0EXkHFK1LDSrQIS6X5BfTj
 nHD/L6DsQTcJpLK8olgf0bSYRkNL9sXFL3oXh0/sWjcPgEGK3kmVE+SqxbCgC4TVvKhQ
 3todw5HwDr+4JuVNqh9wNNliimEHz88nF7gJhv5GEd9TmnWjXJKNoaJOa5TurCgRn/Ba
 jzg1yGw5eF12yXwxYMkfQh8x2S1JkOktSn3dfcnSLTID2PKESPB7PxgDy7fC/Qb04sEP
 NjAbr1t+9AITYoksuU1tY0MaBLynS8qWJJDHDmy7fAPGIPCVMEUK1Y0d+wNArgWx9/kK
 mmow==
X-Gm-Message-State: AOJu0YzMvC+WwyI27juxTky3HaCkcdtF+CSt7QflXg7kU55Nznn/3vb5
 DI7Ws8qmkkXosisb8iweRaPx8N/Fjbb+PX4uDhH3MV8B35b7Eu9sGC2BESdJRn4ZFhlvStCBvGA
 OyOjLOJ2yx038sPeUWzIlqFBQQK4lCR2klaKnAVMNljb9o1/diC5tGMNq0QbHoVtHQxKG
X-Gm-Gg: AR+sD10PqLl61M8x3vFnyEceRqcgtFcII3FOm9gkayY5GbMOyNtXs5zr6syd0urOrWn
 RlcPgf0yWKF+Sb/vBXoE68SjsjWrHCUq1izROryAIIGp1Rd6QsZ45AFizvnkc81IGHf0H4FgTxk
 gOy4UpHPzpgt2rLcx+DOR+lSnH6c40ZA1xx53sk8yp4jLccro9qUMNVOSH7R3j+PJIyVmAwVahU
 0glu3k+yKTr4phR+AWyAOPdX/1JiOfp4ZzWoDNJqasQgzQBQs+mnFf/9xut22iUdQMRXSy72Fjl
 UeFheyjOGQO+WMo5NiMaeU4Bsa20vGD9LyA5KpT/d8Tsxs5SpxOpV6hxRFmQnSb/MUQ5l84pxGj
 U9/RD2i1dsCIY/E0Rgm5jj0X/6RFN7wjO8SP4/dVJIw==
X-Received: by 2002:a05:622a:1353:b0:51c:1fa1:80da with SMTP id
 d75a77b69052e-52df5a100admr8563531cf.40.1787256889933; 
 Thu, 20 Aug 2026 13:14:49 -0700 (PDT)
X-Received: by 2002:a05:622a:1353:b0:51c:1fa1:80da with SMTP id
 d75a77b69052e-52df5a100admr8561141cf.40.1787256887630; 
 Thu, 20 Aug 2026 13:14:47 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14b7d3asm14211152f8f.23.2026.08.20.13.14.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 20 Aug 2026 13:14:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Song Gao <17746591750@163.com>, Bibo Mao <maobibo@loongson.cn>,
 Xianglai Li <lixianglai@loongson.cn>
Subject: [PATCH v2 06/15] target/loongarch: Constify CPULoongArchState for
 various cpu_*() getters
Date: Thu, 20 Aug 2026 22:13:46 +0200
Message-ID: <20260820201356.29775-7-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820201356.29775-1-philmd@oss.qualcomm.com>
References: <20260820201356.29775-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OqZ/DS/t c=1 sm=1 tr=0 ts=6a876040 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=WMCVsHtyMyZApbVNAjAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE1MiBTYWx0ZWRfX2Ior8h2sTq5V
 K3Q/K6VJsM8gscf+4jFIMZFB8LXJ3dmoBi/6m4dU8KZvfsemNTkC/fybFXPGCwjQ0OqGvV13w/k
 hRoengfcKn+xCuGsTYrnyEFXZbe6kzDMiHBdNfBSTIeVMoEm+cEXwmK1Uk8TtXzWjDJN9d0l1iV
 qomsZJ50mRGWqK1bnJILJwaRZTGGQBXjrPFKDzjgga6RXzv1GYMrRjrpCmuq7ZtAWdyd5fBVtJr
 0coK4hxJNhJR4XRjALdKu2YXPZYCNP6FiycFefb16uVfmkGuDVeJ22NXgBefWA1I1ZYv/KLkqNN
 CII4Jmyoszwfju9X1pKnvKrzUj9/02kzKGACI0pgP+Cxa8OSEqc0GXdAuwDE+s5ckL+XcS1XMiv
 XnJq7Goo/ZdTmyvfe0ccf1161OsfiomS3//pvoGWqrdFV+ZvOk95weHcRT+3ApqD+kc6Razf8pE
 A1zORM86/L/iD6Fbpsw==
X-Proofpoint-ORIG-GUID: zfxpq3CG_JCFyy4D9Ca7qxb1c812G8uZ
X-Proofpoint-GUID: zfxpq3CG_JCFyy4D9Ca7qxb1c812G8uZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE1MiBTYWx0ZWRfX54jmsv7MyFmG
 b+0LNm2bXwpbcvCcjKu5c784KroLmL5G58CVskdvVeGLHV6rD4/ANCRbvQSkP8UkUaD9+bCLVsX
 b6hq2FXGzhERVVN7oEcRiP+SIeUkaGY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_02,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 malwarescore=0 clxscore=1015 adultscore=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200152
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

Add the const qualifier to CPULoongArchStatCPUMIPSStatee when
the argument is accessed without modification.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 target/loongarch/cpu.h       | 6 +++---
 target/loongarch/internals.h | 2 +-
 target/loongarch/cpu.c       | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index ad30c73167e..494744788b8 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -485,7 +485,7 @@ struct LoongArchCPUClass {
 #define MMU_USER_IDX     MMU_PLV_USER
 #define MMU_DA_IDX       4
 
-static inline CPUSysState *env_sys(CPULoongArchState *env)
+static inline CPUSysState *env_sys(const CPULoongArchState *env)
 {
     return env->sys_state;
 }
@@ -495,12 +495,12 @@ static inline void set_sys_state(CPULoongArchState *env, CPUSysState *sys)
     env->sys_state = sys;
 }
 
-static inline bool is_la64(CPULoongArchState *env)
+static inline bool is_la64(const CPULoongArchState *env)
 {
     return FIELD_EX32(env->cpucfg[1], CPUCFG1, ARCH) == CPUCFG1_ARCH_LA64;
 }
 
-static inline bool is_va32(CPULoongArchState *env)
+static inline bool is_va32(const CPULoongArchState *env)
 {
     /* VA32 if !LA64 or VA32L[1-3] */
     bool va32 = !is_la64(env);
diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
index 50f0fe2e9be..d6f31161e85 100644
--- a/target/loongarch/internals.h
+++ b/target/loongarch/internals.h
@@ -38,7 +38,7 @@ uint64_t cpu_loongarch_get_constant_timer_counter(LoongArchCPU *cpu);
 uint64_t cpu_loongarch_get_constant_timer_ticks(LoongArchCPU *cpu);
 void cpu_loongarch_store_constant_timer_config(LoongArchCPU *cpu,
                                                uint64_t value);
-bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env);
+bool cpu_loongarch_hw_interrupts_pending(const CPULoongArchState *env);
 #endif /* !CONFIG_USER_ONLY */
 
 uint64_t read_fcc(CPULoongArchState *env);
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 2e938d7880f..b638ac25040 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -82,7 +82,7 @@ void loongarch_cpu_set_irq(void *opaque, int irq, int level)
 }
 
 /* Check if there is pending and not masked out interrupt */
-bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env)
+bool cpu_loongarch_hw_interrupts_pending(const CPULoongArchState *env)
 {
     uint32_t pending;
     uint32_t status;
-- 
2.53.0


