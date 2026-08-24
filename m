Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D1CC5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wySjn-0003NP-Me; Mon, 24 Aug 2026 07:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wySjl-0003Jh-Ly
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 07:21:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wySji-0006hZ-T1
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 07:21:09 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67O997Nj2081915
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 11:20:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 j1XOVSaLCGnAoH6ObhRaJLXXnPSTAlmpiy+W0QG8Az4=; b=JtwEtxsa5j1LCv96
 Rp9pVZFw1ZwqRMp/BQh2kUpV4/cr/yz+oSoTY7udqWSZh/s03K6xVOYWLaJu0RX2
 bFUTYNHg54dkGiY/sh6NZPpQwsI4pnod1f5YS/IUM+4nlgeCLIjE0v/AKXe4VclB
 l8I8zLY8/6OdOm9ZXdZKixDl44KaEM5wEDkzX6NHaarIdmntGzm44JNPyeyoqRr9
 2WTfEDef/NKW1H6fVjdNZFwbN4FBOXwwGWKkr3iFYoQtVJD++scLj68Xu12SCcgS
 Czlau+v9f4xBlwKMSaVQbuQ8PuzqsD+9q6rEsiXrq0xthWLp2kyCHFu0pQzFB62G
 88su6g==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8gdshasm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 11:20:55 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-52d9cef8d15so63159781cf.0
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 04:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787570455; x=1788175255; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=j1XOVSaLCGnAoH6ObhRaJLXXnPSTAlmpiy+W0QG8Az4=;
 b=ZNli0m7ta/CAexOSJxpUm1ZHRErYfU3oaEfcV6dwRhd6G0fAwtPfxODth95fno7P7K
 PhSA+01gL39kcAkBuwmgK0Jqj7RwPKOBghbgbIN+ER6nIgsuYShKNUUXXqraSUpOnOh3
 kftsov/UwsieOiduvk6/nuX3rMUc4ijL3TDtFBHiF3imZ6s9X9J0KRZ8t+N4g7nOhwZ0
 IrMYXVxmrkhEYd/avXXpdIg8ZQCDUKur1DSe1zB/SYkkaS08uv3gBxL2HsToYXn1aqf/
 h0DR8uYc82X/v5R/zrTnggdAAWnbGqjuD3oL+zfNhETsed62mQkg3u9lIwInnZHEfadE
 J7dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787570455; x=1788175255;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=j1XOVSaLCGnAoH6ObhRaJLXXnPSTAlmpiy+W0QG8Az4=;
 b=TJEPAOqMK0cK5PLenIw510XHb9HYfudBgMJsMDf7ZBgtUFlgQegjrsyWYqAK7QI1Q9
 Exrikbtpstz9YSwypt72yuarT25BVtNOGOVRTgLd8JZilAyDvBC+d3pcS1ionHItcHch
 eutDSMi05jrdUUNFZcQouqXETYF8RWyYwQma+HrH7EIFMSmSAYksSuFDofJfrgsAaNTl
 99w/te2q7KIC7KsmA5UT9XyKRivvaMQ0U3ecWiHqw5+7Hc272A53BzOaZxXvBrRjZNaq
 XSOb800/BiY9qSx7oi+cV1pnNKyO9kKcjujZIpZMUx2KKuWNy2fvSHqPJPkSbuum/eNh
 VR3Q==
X-Gm-Message-State: AFuF++lHKC81Rbi7LhYrzDTKrB2UOpc87GLFX2gbA5+pQ3/m7OBy1ruY
 Dk0+vqv6T8c5m2SEnj4+/FAAdOTEtJ6EDisZfqhE/tmwSghfLaFMv1InMR23O54sWdZL22CcXTC
 Y/IniZsmylO6gB5CpKi1hCtFCLYx+reGjtLU/i/+hra66BnAH96544hXQvEvFPf1Z5w==
X-Gm-Gg: AR+sD12D613353sNMLfdkcgHZa9knCcQy1oOlP22kDka7SQYVgOkhyWVjf9D9MhwHOi
 pcBXhI43LCuN2RKXLslwU3YGtxuo10ZV/qxR/78ZdEkbaS3J7ZjPbLBvQ0biVb2YHrvoaVLkWbw
 bREcVAxlD9sewS0fKA5sqMCxpViLhTWneqnt3tmIjSKWHZ8Ru6dLv5xDKp6C+j94gl8SBiDwMrH
 JjpYfXk9AldxVAHso2L9WtYcwYjyNua1uEgkb8LH2tSeW6XjSu8uIIIGDmn2zeRi7QNHHYYl74E
 rPVuTEJO3NDC2QsIaDWF71PuVJ5Aw+QsNrjlxKG8MIuLZvN5dC/dGc4kd68wtUTVlNv+lv6qDaK
 Xu1tX0iTN7gpT0vzixFkZu2KvFVi3sbwsqTg3N5lmLBjsJmpyrg==
X-Received: by 2002:a05:622a:4d03:b0:517:2c1e:8b6 with SMTP id
 d75a77b69052e-52e09d0619bmr189224571cf.38.1787570455003; 
 Mon, 24 Aug 2026 04:20:55 -0700 (PDT)
X-Received: by 2002:a05:622a:4d03:b0:517:2c1e:8b6 with SMTP id
 d75a77b69052e-52e09d0619bmr189223771cf.38.1787570454489; 
 Mon, 24 Aug 2026 04:20:54 -0700 (PDT)
Received: from localhost.localdomain (44.170.88.92.rev.sfr.net. [92.88.170.44])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24968a2183sm1179731666b.58.2026.08.24.04.20.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Aug 2026 04:20:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Song Gao <17746591750@163.com>,
 Bibo Mao <maobibo@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>,
 Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Stafford Horne <shorne@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v4 20/20] accel/tcg: Constify @cpu in cpu_mmu_index() and
 TCGCPUOps handlers
Date: Mon, 24 Aug 2026 13:17:09 +0200
Message-ID: <20260824111711.26297-21-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824111711.26297-1-philmd@oss.qualcomm.com>
References: <20260824111711.26297-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: yz5qJB8CwYVdlEQfkw3uOkAsRdSdAoMP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA5NCBTYWx0ZWRfX7p3ABCZBdDFR
 PcM4B6d3CPd51uhYFDvTv8241zgt8DyaPc3VGsocvLvdRdD31Qq7nRiSrMib/otO6n5uglZh1ti
 j3cp/TNFuhhYIwT8NDX+nWbkMOxOMcVOFFIeG+afYL1/6wcryQzWL5zw+Y8P1cGM3hvIivPVHf6
 UpEyw9ZdL3GXYje/igMHuTGK3Qu++ClE2kXoBFtxh5x8VTqXMy42XhbvP/IW0cxOFlIDaF95Ukt
 2q7y1+nO8u4MqGVwTzgrRF+/Wf63gBXDDzRu/+Q3IIoTogxedjNWaM1GsfgcCp7ze7CUUwYmCuU
 pOKl0ht10zSqZKVfRz9bbCUcFd91L62ZdVu4W1QBsMoyLEF0+Jc6DuobleVpm+yYWBbhRNWL2er
 OBqCykHiJUZk6UhsEkVTzuh6ugdsCTyeGu844+vBhDm/99saJXIUbB2lBSQsBoW+eloCjlklmqP
 46JKUYo2gZqOeyWhXAw==
X-Authority-Analysis: v=2.4 cv=Fqo1OWrq c=1 sm=1 tr=0 ts=6a8c2917 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=s1NLoHz9uzatdv2VNqxUSg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=g_x95mRnQQNavG41apYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: yz5qJB8CwYVdlEQfkw3uOkAsRdSdAoMP
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA5NCBTYWx0ZWRfX/Pm+VDDJYFDY
 Yx7AuVrfSNLXOJen5Y+ovuc9v97tQBcvYC0GrHtl5u7ILoujP6dH7IVFZsEBRruxwyvu8SWsxjR
 nkcrvTaLfvBc9JiOqhHjbxn7hEB+j6E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240094
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

All functions called by cpu_mmu_index() take a const
@cpu argument. Propagate the constness to the caller
(CPU state should not mutate when resolving the MMU
index of the current translation regime).

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/accel/tcg/cpu-mmu-index.h | 2 +-
 include/accel/tcg/cpu-ops.h       | 2 +-
 target/alpha/cpu.h                | 2 +-
 target/arm/internals.h            | 4 ++--
 target/i386/tcg/tcg-cpu.h         | 2 +-
 target/ppc/cpu.h                  | 2 +-
 target/s390x/cpu.h                | 2 +-
 target/alpha/cpu.c                | 2 +-
 target/arm/cpu.c                  | 2 +-
 target/avr/cpu.c                  | 2 +-
 target/hexagon/cpu.c              | 6 +++---
 target/hppa/cpu.c                 | 4 ++--
 target/i386/tcg/tcg-cpu.c         | 6 +++---
 target/loongarch/tcg/tcg_cpu.c    | 4 ++--
 target/m68k/cpu.c                 | 2 +-
 target/microblaze/cpu.c           | 6 +++---
 target/mips/cpu.c                 | 2 +-
 target/or1k/cpu.c                 | 4 ++--
 target/ppc/cpu_init.c             | 2 +-
 target/riscv/tcg/tcg-cpu.c        | 2 +-
 target/rx/cpu.c                   | 2 +-
 target/s390x/cpu.c                | 2 +-
 target/sh4/cpu.c                  | 4 ++--
 target/sparc/cpu.c                | 4 ++--
 target/tricore/cpu.c              | 2 +-
 target/xtensa/cpu.c               | 2 +-
 26 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/include/accel/tcg/cpu-mmu-index.h b/include/accel/tcg/cpu-mmu-index.h
index e0fb6ef91c8..01152075372 100644
--- a/include/accel/tcg/cpu-mmu-index.h
+++ b/include/accel/tcg/cpu-mmu-index.h
@@ -30,7 +30,7 @@
  * Return the core mmu index for the current translation regime.
  * This function is used by generic TCG code paths.
  */
-static inline int cpu_mmu_index(CPUState *cs, bool ifetch)
+static inline int cpu_mmu_index(const CPUState *cs, bool ifetch)
 {
 #ifdef COMPILING_PER_TARGET
 # ifdef CONFIG_USER_ONLY
diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index a88cc4dc572..69d7ec29115 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -102,7 +102,7 @@ struct TCGCPUOps {
     void (*debug_excp_handler)(CPUState *cpu);
 
     /** @mmu_index: Callback for choosing softmmu mmu index */
-    int (*mmu_index)(CPUState *cpu, bool ifetch);
+    int (*mmu_index)(const CPUState *cpu, bool ifetch);
 
 #ifdef CONFIG_USER_ONLY
     /**
diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index 378bd96d941..1c9f9fce20b 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -383,7 +383,7 @@ enum {
 
 #define TB_FLAG_UNALIGN       (1u << 1)
 
-static inline int alpha_env_mmu_index(CPUAlphaState *env)
+static inline int alpha_env_mmu_index(const CPUAlphaState *env)
 {
     int ret = env->flags & ENV_FLAG_PS_USER ? MMU_USER_IDX : MMU_KERNEL_IDX;
     if (env->flags & ENV_FLAG_PAL_MODE) {
diff --git a/target/arm/internals.h b/target/arm/internals.h
index f1a80c890ee..d582cefcfa4 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -55,7 +55,7 @@ static inline MemOp mo_endian(const CPUARMState *env)
     return EX_TBFLAG_ANY(env->hflags, BE_DATA) ? MO_BE : MO_LE;
 }
 
-static inline int arm_env_mmu_index(CPUARMState *env)
+static inline int arm_env_mmu_index(const CPUARMState *env)
 {
     return EX_TBFLAG_ANY(env->hflags, MMUIDX);
 }
@@ -431,7 +431,7 @@ void arm_restore_state_to_opc(CPUState *cs,
 #ifdef CONFIG_TCG
 TCGTBCPUState arm_get_tb_cpu_state(CPUState *cs);
 void arm_cpu_synchronize_from_tb(CPUState *cs, const TranslationBlock *tb);
-int arm_cpu_mmu_index(CPUState *cs, bool ifetch);
+int arm_cpu_mmu_index(const CPUState *cs, bool ifetch);
 #endif /* CONFIG_TCG */
 
 typedef enum ARMFPRounding {
diff --git a/target/i386/tcg/tcg-cpu.h b/target/i386/tcg/tcg-cpu.h
index 85bcd61678f..1127861e337 100644
--- a/target/i386/tcg/tcg-cpu.h
+++ b/target/i386/tcg/tcg-cpu.h
@@ -82,6 +82,6 @@ extern const TCGCPUOps x86_tcg_ops;
 
 bool tcg_cpu_realizefn(CPUState *cs, Error **errp);
 
-int x86_mmu_index_pl(CPUX86State *env, unsigned pl);
+int x86_mmu_index_pl(const CPUX86State *env, unsigned pl);
 
 #endif /* TCG_CPU_H */
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index cbd5964b1ac..0da472f3c05 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1736,7 +1736,7 @@ int ppc_dcr_write(ppc_dcr_t *dcr_env, int dcrn, uint32_t val);
 
 /* MMU modes definitions */
 #define MMU_USER_IDX 0
-static inline int ppc_env_mmu_index(CPUPPCState *env, bool ifetch)
+static inline int ppc_env_mmu_index(const CPUPPCState *env, bool ifetch)
 {
 #ifdef CONFIG_USER_ONLY
     return MMU_USER_IDX;
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 998bbb0d7ff..cd5f9256b24 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -373,7 +373,7 @@ QEMU_BUILD_BUG_ON(FLAG_MASK_DAT != PSW_MASK_DAT >> FLAG_MASK_PSW_SHIFT);
 #define MMU_HOME_IDX            2
 #define MMU_REAL_IDX            3
 
-static inline int s390x_env_mmu_index(CPUS390XState *env, bool ifetch)
+static inline int s390x_env_mmu_index(const CPUS390XState *env, bool ifetch)
 {
 #ifdef CONFIG_USER_ONLY
     return MMU_USER_IDX;
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 21d4f8ac23b..3bf88702dc1 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -93,7 +93,7 @@ static bool alpha_cpu_has_work(const CPUState *cs)
 }
 #endif /* !CONFIG_USER_ONLY */
 
-static int alpha_cpu_mmu_index(CPUState *cs, bool ifetch)
+static int alpha_cpu_mmu_index(const CPUState *cs, bool ifetch)
 {
     return alpha_env_mmu_index(cpu_env(cs));
 }
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index ba66359d410..63ef00735ca 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -126,7 +126,7 @@ void arm_restore_state_to_opc(CPUState *cs,
     }
 }
 
-int arm_cpu_mmu_index(CPUState *cs, bool ifetch)
+int arm_cpu_mmu_index(const CPUState *cs, bool ifetch)
 {
     return arm_env_mmu_index(cpu_env(cs));
 }
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index a96bef46ff1..24a5a9debc9 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -50,7 +50,7 @@ static bool avr_cpu_has_work(const CPUState *cs)
             && cpu_interrupts_enabled(cpu_env(cs));
 }
 
-static int avr_cpu_mmu_index(CPUState *cs, bool ifetch)
+static int avr_cpu_mmu_index(const CPUState *cs, bool ifetch)
 {
     return ifetch ? MMU_CODE_IDX : MMU_DATA_IDX;
 }
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 868aef0cde4..2bc58fc6305 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -482,11 +482,11 @@ static void hexagon_cpu_realize(DeviceState *dev, Error **errp)
     mcc->parent_realize(dev, errp);
 }
 
-static int hexagon_cpu_mmu_index(CPUState *cs, bool ifetch)
+static int hexagon_cpu_mmu_index(const CPUState *cs, bool ifetch)
 {
 #ifndef CONFIG_USER_ONLY
-    CPUHexagonState *env = cpu_env(cs);
-    HexagonCPU *cpu = HEXAGON_CPU(cs);
+    const CPUHexagonState *env = cpu_env(cs);
+    const HexagonCPU *cpu = HEXAGON_CPU(cs);
     int cpu_mode;
 
     BQL_LOCK_GUARD();
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index dbf58466c24..ec351302406 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -140,9 +140,9 @@ static bool hppa_cpu_has_work(const CPUState *cs)
 }
 #endif /* !CONFIG_USER_ONLY */
 
-static int hppa_cpu_mmu_index(CPUState *cs, bool ifetch)
+static int hppa_cpu_mmu_index(const CPUState *cs, bool ifetch)
 {
-    CPUHPPAState *env = cpu_env(cs);
+    const CPUHPPAState *env = cpu_env(cs);
 
     if (env->psw & (ifetch ? PSW_C : PSW_D)) {
         return PRIV_P_TO_MMU_IDX(env->iaoq_f & 3, env->psw & PSW_P);
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index e4fc212aca5..da1498ee45d 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -114,7 +114,7 @@ static void x86_restore_state_to_opc(CPUState *cs,
     }
 }
 
-int x86_mmu_index_pl(CPUX86State *env, unsigned pl)
+int x86_mmu_index_pl(const CPUX86State *env, unsigned pl)
 {
     int mmu_index_32 = (env->hflags & HF_CS64_MASK) ? 0 : 1;
     int mmu_index_base =
@@ -125,9 +125,9 @@ int x86_mmu_index_pl(CPUX86State *env, unsigned pl)
     return mmu_index_base + mmu_index_32;
 }
 
-static int x86_cpu_mmu_index(CPUState *cs, bool ifetch)
+static int x86_cpu_mmu_index(const CPUState *cs, bool ifetch)
 {
-    CPUX86State *env = cpu_env(cs);
+    const CPUX86State *env = cpu_env(cs);
     return x86_mmu_index_pl(env, env->hflags & HF_CPL_MASK);
 }
 
diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
index 7ea2a1eb933..a26233d5eed 100644
--- a/target/loongarch/tcg/tcg_cpu.c
+++ b/target/loongarch/tcg/tcg_cpu.c
@@ -301,9 +301,9 @@ static void loongarch_restore_state_to_opc(CPUState *cs,
     set_pc(cpu_env(cs), data[0]);
 }
 
-static int loongarch_cpu_mmu_index(CPUState *cs, bool ifetch)
+static int loongarch_cpu_mmu_index(const CPUState *cs, bool ifetch)
 {
-    CPULoongArchState *env = cpu_env(cs);
+    const CPULoongArchState *env = cpu_env(cs);
     CPUSysState *sys = env_sys(env);
 
     if (FIELD_EX64(sys->CSR_CRMD, CSR_CRMD, PG)) {
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index da3681fab1f..f1fd2e6f14d 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -82,7 +82,7 @@ static bool m68k_cpu_has_work(const CPUState *cs)
 }
 #endif /* !CONFIG_USER_ONLY */
 
-static int m68k_cpu_mmu_index(CPUState *cs, bool ifetch)
+static int m68k_cpu_mmu_index(const CPUState *cs, bool ifetch)
 {
     return cpu_env(cs)->sr & SR_S ? MMU_KERNEL_IDX : MMU_USER_IDX;
 }
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index d1d2f0ec7e3..524175d2236 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -133,10 +133,10 @@ static bool mb_cpu_has_work(const CPUState *cs)
 }
 #endif /* !CONFIG_USER_ONLY */
 
-static int mb_cpu_mmu_index(CPUState *cs, bool ifetch)
+static int mb_cpu_mmu_index(const CPUState *cs, bool ifetch)
 {
-    CPUMBState *env = cpu_env(cs);
-    MicroBlazeCPU *cpu = env_archcpu(env);
+    const CPUMBState *env = cpu_env(cs);
+    const MicroBlazeCPU *cpu = env_archcpu(env);
 
     /* Are we in nommu mode?.  */
     if (!(env->msr & MSR_VM) || !cpu->cfg.use_mmu) {
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 0f39f8fe0a5..a428176d9e8 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -671,7 +671,7 @@ static const Property mips_cpu_properties[] = {
 #ifdef CONFIG_TCG
 #include "accel/tcg/cpu-ops.h"
 
-static int mips_cpu_mmu_index(CPUState *cs, bool ifunc)
+static int mips_cpu_mmu_index(const CPUState *cs, bool ifunc)
 {
     return mips_env_mmu_index(cpu_env(cs));
 }
diff --git a/target/or1k/cpu.c b/target/or1k/cpu.c
index 10b13ae69cd..c9ab5c0f1c1 100644
--- a/target/or1k/cpu.c
+++ b/target/or1k/cpu.c
@@ -82,9 +82,9 @@ static bool openrisc_cpu_has_work(const CPUState *cs)
 }
 #endif /* !CONFIG_USER_ONLY */
 
-static int openrisc_cpu_mmu_index(CPUState *cs, bool ifetch)
+static int openrisc_cpu_mmu_index(const CPUState *cs, bool ifetch)
 {
-    CPUOpenRISCState *env = cpu_env(cs);
+    const CPUOpenRISCState *env = cpu_env(cs);
 
     if (env->sr & (ifetch ? SR_IME : SR_DME)) {
         /* The mmu is enabled; test supervisor state.  */
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index fd63cd6ab09..da9d60d260b 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7217,7 +7217,7 @@ static void ppc_restore_state_to_opc(CPUState *cs,
     cpu->env.nip = data[0];
 }
 
-static int ppc_cpu_mmu_index(CPUState *cs, bool ifetch)
+static int ppc_cpu_mmu_index(const CPUState *cs, bool ifetch)
 {
     return ppc_env_mmu_index(cpu_env(cs), ifetch);
 }
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index cd303660f1f..a0210ca50e3 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -95,7 +95,7 @@ static const char *cpu_priv_ver_to_str(int priv_ver)
     return priv_spec_str;
 }
 
-static int riscv_cpu_mmu_index(CPUState *cs, bool ifetch)
+static int riscv_cpu_mmu_index(const CPUState *cs, bool ifetch)
 {
     return riscv_env_mmu_index(cpu_env(cs), ifetch);
 }
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index dfa09a85bce..c5dfba8976a 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -78,7 +78,7 @@ static bool rx_cpu_has_work(const CPUState *cs)
     return cpu_test_interrupt(cs, CPU_INTERRUPT_HARD | CPU_INTERRUPT_FIR);
 }
 
-static int rx_cpu_mmu_index(CPUState *cs, bool ifunc)
+static int rx_cpu_mmu_index(const CPUState *cs, bool ifunc)
 {
     return 0;
 }
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index c34f4b23472..a043f1e7920 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -311,7 +311,7 @@ static const Property s390x_cpu_properties[] = {
 #include "accel/tcg/cpu-ops.h"
 #include "tcg/tcg_s390x.h"
 
-static int s390x_cpu_mmu_index(CPUState *cs, bool ifetch)
+static int s390x_cpu_mmu_index(const CPUState *cs, bool ifetch)
 {
     return s390x_env_mmu_index(cpu_env(cs), ifetch);
 }
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index b0ed356d0f7..f8b33844d2a 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -113,9 +113,9 @@ static bool superh_cpu_has_work(const CPUState *cs)
 }
 #endif /* !CONFIG_USER_ONLY */
 
-static int sh4_cpu_mmu_index(CPUState *cs, bool ifetch)
+static int sh4_cpu_mmu_index(const CPUState *cs, bool ifetch)
 {
-    CPUSH4State *env = cpu_env(cs);
+    const CPUSH4State *env = cpu_env(cs);
 
     /*
      * The instruction in a RTE delay slot is fetched in privileged mode,
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 8dd9b0d5ee3..f1ae16c91e9 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -790,9 +790,9 @@ static bool sparc_cpu_has_work(const CPUState *cs)
 }
 #endif /* !CONFIG_USER_ONLY */
 
-static int sparc_cpu_mmu_index(CPUState *cs, bool ifetch)
+static int sparc_cpu_mmu_index(const CPUState *cs, bool ifetch)
 {
-    CPUSPARCState *env = cpu_env(cs);
+    const CPUSPARCState *env = cpu_env(cs);
 
 #ifndef TARGET_SPARC64
     if ((env->mmuregs[0] & MMU_E) == 0) { /* MMU disabled */
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 357f3737053..09d4270df60 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -117,7 +117,7 @@ static bool tricore_cpu_has_work(const CPUState *cs)
     return true;
 }
 
-static int tricore_cpu_mmu_index(CPUState *cs, bool ifetch)
+static int tricore_cpu_mmu_index(const CPUState *cs, bool ifetch)
 {
     return 0;
 }
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 1b299568776..8cf973632e7 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -148,7 +148,7 @@ static bool xtensa_cpu_has_work(const CPUState *cs)
 }
 #endif /* !CONFIG_USER_ONLY */
 
-static int xtensa_cpu_mmu_index(CPUState *cs, bool ifetch)
+static int xtensa_cpu_mmu_index(const CPUState *cs, bool ifetch)
 {
     return xtensa_get_cring(cpu_env(cs));
 }
-- 
2.53.0


