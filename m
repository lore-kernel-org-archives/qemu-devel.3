Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D77C5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:48:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx0JZ-0008ME-C7; Thu, 20 Aug 2026 06:48:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wx0JS-0008Hf-80
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:47:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wx0JQ-0005kI-Le
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:47:57 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67K8jfMQ2529525
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 10:47:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vPkYOzjCZEx4JelHAd8fdNs4FoNuCoY284i0qko/5Zs=; b=KB9Z/65yGP+p8+tz
 CqJEB/KIqGyW8nELYe9ROEmSDRt04+Wr7cX4YONnglW5bwXmGeV0rhFp77dfpTth
 Dc6PkEtTrD1/C7P+LFJ/gyuxZ4sUkCpaKS+CShHoUh2i2fOZ0JHjkJ69nFYkRKF6
 W6TanPR6vGPcj3YFA5y7x6CpmboaKkMcHW6FsvGPEd3pOjGLSoivDx8te7DP236N
 f++ehJ7NJdt8sP6RHfp5NgkfFx0BUyUeTAHxlzi3QRFyEARZSFEGoe3c3mY/ATnd
 2+HFsJU+4y8AkP5I2Th6+Wtf+Z29zkbLVLkRnJiRLICOrxjm74nJKy4kssvU1Hbf
 xCj96A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5xbv8fhm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 10:47:55 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-52dd69b00cfso20188751cf.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 03:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787222875; x=1787827675; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vPkYOzjCZEx4JelHAd8fdNs4FoNuCoY284i0qko/5Zs=;
 b=L9YjbjyrfypRuIFkBLUyC1gu/+EXnMw4yyJfmdm0Hx0UeFiq6ezw0XO62qWr2FMkh+
 5viS2rImJMf46fOL/xa3KGBQ9SPCkECcdu5iZu+Mx0gsF933CFT9Gmb7viy9bV6HtpSZ
 Jsv5xKF1Q/IlHPo7nGcJk9kwSVc2cRIZNd2tcgIBqbsCfqKKzZIbrC+Ya7dxkz12Yn2t
 IB+HYX0igIigeyxLiF4W4nwBgoKokakbE86+Yu9ITQb944NUXUt2KL6nqbFpuLh2Ppia
 6wyaK/WdaF0v+N7DlD79XesAig6wijfxBmVhL8PuB4pFahd2zi2oo3LqPblRT9i89AFu
 YwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787222875; x=1787827675;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vPkYOzjCZEx4JelHAd8fdNs4FoNuCoY284i0qko/5Zs=;
 b=IjJhDXbDJfoeqit9xqPHVHqVYLgY2sylvvP4gBUffJJHXjSrFHxHGpePAk5i9VFW6B
 6K4Wu5zaE7d252MeVWQrFvysvQv7ziNhrdK8ge2HKty/28Az8aSQPCpCkptjFxeoYk2m
 kW/8CJyjDsUOAWig7aSWnCX19QXMLImQrcBZKFSvLhoJ2xV8dJP4hnsHdfvi8HIRi+Wm
 dURlSXAJbww4XjXLR/OZZYFFYKDdEfDUAdVTPollQzlFFqhLSh1N9S41yMVYo+jyzY3w
 XEkpJb3/L0wXtRnyKWb1GNWfBNaud5Q6ykuTHfN6Q46V7ZDsm9wwElwBS0AzixAsoKax
 33CA==
X-Gm-Message-State: AOJu0Ywt+OE+Z4rHSPNch4DcbfDdzaO2NjIJswpYjnUUebaoj3nkjSUs
 s9HibP5LUFFgxV5kbGAgtB/GQ193Vg2GKiL9bcUudw9ERgbweje2LB10sMlGuxlVvZh3Vvloioe
 nf/Wr8eE3C/effC/ntqQMnndGNKUOM3sJ7PQ476ru2XIJ8Zvw02JUe5SxWCIzrwIuTos7
X-Gm-Gg: AR+sD120RT24o5rJQRnWEaICCBQoxVhscIVAv7pDXROB/afID9VJjgJ1msV25GCK1pK
 sx2tH0DtnbQ2AP6QbHNnKph/pfieoHdZPKFkIfTm+gIGxZkOBVmxOHR+8DgDh5SAZ/+6WlPvQTK
 WTkv/WvqmR/jHZdd9wi7mz/xWuW7wJCUcBkTw2hUp1oWgnbPVA944TC9qANpM1rppZxxlzNTX2a
 mB8Z/tTvdKTTi6OJGuptVenGvlrL813SX/vZoLe72Gn39ZPK+JOUNEn1WKajoZrrLKrhloRwSuw
 bOgd/C5bNJzwQ1bz0ybPfFZFD9iwWaA4Vmm8keFJx73vsj5c3NpaMGUYdIlLoWrOapKcJ9DtoSV
 YInVB36eHd0DFOlpttzbnxtK8VrHBbGJ5HFiVLTTzXA==
X-Received: by 2002:a05:622a:1206:b0:52d:94c5:2212 with SMTP id
 d75a77b69052e-52dd5733782mr87611011cf.3.1787222875215; 
 Thu, 20 Aug 2026 03:47:55 -0700 (PDT)
X-Received: by 2002:a05:622a:1206:b0:52d:94c5:2212 with SMTP id
 d75a77b69052e-52dd5733782mr87610791cf.3.1787222874820; 
 Thu, 20 Aug 2026 03:47:54 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499a9e784b3sm117761165e9.3.2026.08.20.03.47.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 20 Aug 2026 03:47:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Song Gao <17746591750@163.com>, Bibo Mao <maobibo@loongson.cn>,
 Xianglai Li <lixianglai@loongson.cn>
Subject: [PATCH 03/13] target/loongarch: Constify CPULoongArchState for
 various cpu_*() getters
Date: Thu, 20 Aug 2026 12:47:19 +0200
Message-ID: <20260820104730.25462-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820104730.25462-1-philmd@oss.qualcomm.com>
References: <20260820104730.25462-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=AMKAkK6n c=1 sm=1 tr=0 ts=6a86db5b cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=cEYDorbIuKFc_Ye4BekA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA3OSBTYWx0ZWRfXxU+l56W3Or4L
 9oe0RmxCZQlSNMre2jGVbe0Xi5AwiyGnVC//IxvrtvnvpBY+gQmDUPrCo4i6DL89UtthCwDQb32
 tBUGal8HSQuWcNW2jCG86RmN+YXEfTwGr+U0GQIoTQ5Mhdrs2JEuaore5tinLHzmKTsMd2Hn5bh
 ildOwv1GGIg4hi+WHXW0tk50fzIfPwQHErDYWQAnfI1UGg0VMJ/MUW5gHkp0a7yBuWCWOYerX5g
 pjTZbVhyKpMjI7bfrpjEvcaVq2svKHTOEpzqvFt6Kj4Xh4VwbWqtjMnx4Ibi6FDGurb6ogNzx2Z
 vUkT6S+71gkr3HkVs9JOxiX3FUGg/u2o/4eWUUfuW0BJTqTZrjwT8STgDAng6YyI7Swvh54xkH7
 cjr4Y1qzoJHRzCFStqI/a50O/eKf3NsgkXu7WtSB1sZn7pcXRFnee8mqcmFWsSy+6S2nLahHayR
 1Gl3KN8ZnEyrzw//7Zw==
X-Proofpoint-GUID: SQ5PXE3kTnOOD7o0i_F0J_liPCIpoDCQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA3OSBTYWx0ZWRfX2iDDdQ6mQ9rG
 NnQGK4TLXCWnCmD5fl/9lh2UuTHASC5vvhyg73GACkPXX2AZDYK9ZJVY2mNWY4sCjgqmGLTQSuq
 tdS/StAzgWdl8oVQNCREe7ZJgEdszbE=
X-Proofpoint-ORIG-GUID: SQ5PXE3kTnOOD7o0i_F0J_liPCIpoDCQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 suspectscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200079
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

Add the const qualifier to CPULoongArchStatCPUMIPSStatee when
the argument is accessed without modification.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
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
index e01dbed40f6..6a733e6c3a5 100644
--- a/target/loongarch/internals.h
+++ b/target/loongarch/internals.h
@@ -39,7 +39,7 @@ uint64_t cpu_loongarch_get_constant_timer_ticks(LoongArchCPU *cpu);
 void cpu_loongarch_store_constant_timer_config(LoongArchCPU *cpu,
                                                uint64_t value);
 bool loongarch_cpu_has_work(CPUState *cs);
-bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env);
+bool cpu_loongarch_hw_interrupts_pending(const CPULoongArchState *env);
 #endif /* !CONFIG_USER_ONLY */
 
 uint64_t read_fcc(CPULoongArchState *env);
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 8cd5bc18a3c..82ec35e081f 100644
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


