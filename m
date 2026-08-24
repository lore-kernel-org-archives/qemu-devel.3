Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D7DC5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:19:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyShy-0004DL-59; Mon, 24 Aug 2026 07:19:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wyShw-00049N-E5
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 07:19:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wySht-0005eb-LH
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 07:19:16 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67O99EUA2083041
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 11:19:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wR0QaQrDb7GuMtRSy5NqIH8YoOaer7cA+7FXtXgJvnE=; b=nEFyh0+rukjbFjsa
 Nh0hzSV9ZK1W2dQnIcmIL+9sWGqtl1809Kegs5tzPxTpl+IgIAVgyJkdIattVPYN
 SATjC1ugAnuRSJoigHbaQXiNzPHNdePLxGgICTvlsXHnaXlIaEx9WduQBmsNINCy
 xqJt2ScGzVE6elVgD9GPhLdu9CNXeq5tioiTzR5L0/fnFIdQHlYR7nkz/gAjBXE5
 +5FrXeOydQcH2MP33Oo8uKIbdSeSx5w3oJklGedS531ZtuAFNVRDblkQk1ix9set
 Xfe6M1a20LeVqKoDZzxNcc8fBy6F2XuWDivjGXDQRpKQAQBm99rbWDCzfw00ltIT
 I/8o7A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8hbth0cy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 11:19:02 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-52b4f6ac06aso62490661cf.1
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 04:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787570341; x=1788175141; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wR0QaQrDb7GuMtRSy5NqIH8YoOaer7cA+7FXtXgJvnE=;
 b=Y9Zid1Xhk+wQf6oButofO8tPOkF6Qe9JF9PtbiArkjGYjriIK9sOKHdOQbvtw7a4l2
 rh8NBL7Hf/4wlyeZ/GYLGDRsPWrpJCpiW+GWvgU7QkGxvPv9hoDDg7UhlIaEjohsc+o7
 jAjn8QOVafCV/wc6Yas7D1ViRahxNrDQMpRHx++mowhbvRAulmRj7hrojFTNTQnLZqwO
 /VQy9ORGrX1LCwX/X98mvEhYUUeYUUzmObq9rxck40yNKim7MM9crDx1t4PoffunvHkQ
 rNCoxLcKOcpaH+wjA87/JEnycCRXLRhGoZ1jP3mAsVvPJdYzEPm/z6scXUnjgC8RvGfq
 cPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787570341; x=1788175141;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wR0QaQrDb7GuMtRSy5NqIH8YoOaer7cA+7FXtXgJvnE=;
 b=X8XPKQWaE9zFRTiMlYpUuPRIxHEPXnk+YqGTGGnnR8NNp7+2AbkFGzgZ+Zyn5DY9G0
 wQNw1d1+ucELbSvA2KuNCAhATLlEFJdHK4hW5V3up0IzUKA3a+CBdXXP6wrvLUAjyL1k
 05ndoEIvaEBAr8v9yOlJT3O0xynbPtx8hpnKb1xP3P0Wm4dQNb8QoHn8+IY/aEKW7+DJ
 6kU9m/VvY1A6LWM6c+HOcpFl3WttehtVT/JOUwm4SS0F5nLwoafQm1Bous9xZpJ6D4jb
 fjMmmUKF/MSQc1DIZMXGRUSe2VBnX0hi0hhmzzalfAAGzO1mjp/6mklnIsDnJshAaRXL
 VWWw==
X-Gm-Message-State: AFuF++n3yOak/1AbW/mVygx0cala2lZ7GsZVonbVVUiDbDQEe3Oacyl0
 E/DWnCi4GUB4+5fGv7hl86LaWRLT94s3CfcldSDnzN2I7MG79Va2sGCmTusaaJz9QQ9/vlrupl0
 3uy5o01QmZxfsWaethr2XoYSgjy//JmLkDzLVg1lRwGN5mAnuYbWM4yfVrrzqjnJJdA==
X-Gm-Gg: AR+sD11aIxwUHx6Ou+6JvLUhZINMuWlbHC7YmPIutxoSnhSwuowy8Cm2kanmU58fvfg
 POB/G6c0AYqjrOXAP0CB4a/hTRMsoxduEnfD1yk96PeH8ExKebI/emeHtg8EzzvXefVNVHIRUHs
 gxi/8feNFD2lrVW7fQaRdtnlK64iSLuiaJ6QbsOUfJtqT0m1ucKAPHarcjZq93G9swPtf5ICcN7
 w5a1CQqI/YirE0M25uPCleICWSyDCMwbDbDQ/FGQnWLfxletzuX8DqOUTI8xXqffCiCvspZKh4s
 iTmw74bWxx3r2dn8Emzfj9pn29u2jnTVtHhCDYlNuLrAcRlE1F8ChM8kfkOWGwDQ+gHeMKt3144
 aJ5e0gktfDt0wxQ/fusl/qdgNHDYL61JsQR2KYutgkCTs28DTZA==
X-Received: by 2002:ac8:59d2:0:b0:51b:eb55:2916 with SMTP id
 d75a77b69052e-52df59b3b8cmr262380711cf.34.1787570340776; 
 Mon, 24 Aug 2026 04:19:00 -0700 (PDT)
X-Received: by 2002:ac8:59d2:0:b0:51b:eb55:2916 with SMTP id
 d75a77b69052e-52df59b3b8cmr262380141cf.34.1787570340266; 
 Mon, 24 Aug 2026 04:19:00 -0700 (PDT)
Received: from localhost.localdomain (44.170.88.92.rev.sfr.net. [92.88.170.44])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2496296cafsm1248768066b.14.2026.08.24.04.18.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Aug 2026 04:18:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Song Gao <17746591750@163.com>, Bibo Mao <maobibo@loongson.cn>,
 Xianglai Li <lixianglai@loongson.cn>
Subject: [PATCH v4 10/20] target/loongarch: Constify CPULoongArchState for
 various cpu_*() getters
Date: Mon, 24 Aug 2026 13:16:59 +0200
Message-ID: <20260824111711.26297-11-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824111711.26297-1-philmd@oss.qualcomm.com>
References: <20260824111711.26297-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA5NCBTYWx0ZWRfX4+NJLs3lhm6C
 XBOs90AMiGXNvzGLkDp0fw2rcaL9wShgmmU6suIYyZm0Raw/l++Ky6+P8KwGhZsqs10rrUcxgQi
 kxE7AKa2C2MT8ECk9qQiLLCS6edMMwKiQ9O9zpzn2qelY7vo3RwOfn/XEjdPoWl3I4EliLKx94r
 56J223b92aI0uTYjkYewzRkUSWvLNtV+/+aEPYzo+/eKUzQxAG1K6DzQgGI9ls+uPm4/4lh191E
 j3MreVhpfg33KkswQG4eeIHAQT3UCsIELy0IA33s3SAu3uMBsk6o1CvUIPqqkqjQX/eUtBFTb2R
 WJoxQRdanMDWRLJjNHO6iMctsVoNVEL4kYdWKDrI0gWTbnNMKPLHPyJPO+XdXa+nwpqEkGvQnFF
 5jmN3UXvzs0xVw6nh1AZkX3T7Qj3ZOJM5k2zmsgRhnxFaFLkhZMFESxLQOIjogTPdJgbCbRNPxi
 HdS2Czazqip71pSZ1tA==
X-Authority-Analysis: v=2.4 cv=JL0LdcKb c=1 sm=1 tr=0 ts=6a8c28a6 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=s1NLoHz9uzatdv2VNqxUSg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=WMCVsHtyMyZApbVNAjAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA5NCBTYWx0ZWRfXzCOMvaaHQgxA
 nj3A7APCkW4nrV5huB7uUzaZsRao4ZDJSqHU1DG1BdKmkrLbQjE1Rj/JWxTicgV6e1A9vfhLNb2
 3VH6Xj7T749x0WI47aK0T8palW7qqRg=
X-Proofpoint-GUID: RWyW3OEHzZ-2F0sGbYL4enTt_abrlkVp
X-Proofpoint-ORIG-GUID: RWyW3OEHzZ-2F0sGbYL4enTt_abrlkVp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240094
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

Add the const qualifier to CPULoongArchState when
the argument is accessed without modification.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 target/loongarch/cpu.h       | 6 +++---
 target/loongarch/internals.h | 2 +-
 target/loongarch/cpu.c       | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 97db3b453fe..ad8e7497279 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -486,7 +486,7 @@ struct LoongArchCPUClass {
 #define MMU_USER_IDX     MMU_PLV_USER
 #define MMU_DA_IDX       4
 
-static inline CPUSysState *env_sys(CPULoongArchState *env)
+static inline CPUSysState *env_sys(const CPULoongArchState *env)
 {
     return env->sys_state;
 }
@@ -496,12 +496,12 @@ static inline void set_sys_state(CPULoongArchState *env, CPUSysState *sys)
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
index d9c1e871027..2dbe2203b20 100644
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


