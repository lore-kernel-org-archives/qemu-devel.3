Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F77C5DF90
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 20:16:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx99z-0005fT-PH; Thu, 20 Aug 2026 16:14:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wx99y-0005dY-19
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 16:14:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wx99w-00028J-4C
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 16:14:45 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KK8ace160944
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 20:14:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uHmqw3PgQrwhWNplvoktCYvtMz6v2lpYN+dpIY29gRk=; b=PK9hYCGXk8Ma+e+D
 7Uj/LPuExCNCb4yHn0KrSrOvSaCfC2hb4fo9R7tzlk/iH+pL+7sj8hGjBKflbhPs
 Z6+yoaXO/CiOEosHhMfZlNdLFA+nVRFfSRNDLbA1i8kaD9E6R8aGfOFwI3658pbV
 JrNS0RnZ0moncsc2+5LOG43YhSmAwnzg1oAYzI59VlhaRncMT/bErtBKBZko8hiR
 rWM/jMrccNRKRyr/VEaGydCRMWKQW5dZhTKHw1XBD0QPM9ybVrlPXZJWbm8eG8D5
 p7YqkvUgfJ4VGK+7hg1QlQSq2uutwaHlRjFbAf/lCHAdxjPNuilNmoUJBbJHosR2
 yCmCUA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5xuk2ya8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 20:14:33 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5276aa86d00so2407511cf.2
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 13:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787256872; x=1787861672; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uHmqw3PgQrwhWNplvoktCYvtMz6v2lpYN+dpIY29gRk=;
 b=Lmhu1/gKwafLWl2TTjauYqMfzkmc7SGnpWZcUQW30cccW37nyQQ9mBaWnHVrUxK9P7
 NkJn9VpY6b514Hm1FNpHcjr76b/MmiOOwJDu/R+s8G3W/4m2oiUhVJGOoMFyt/Y7XOBH
 FDwb7to+Hr6JgGIZckJlt0vQpBCedPJbCEf/J/pCNc2s6CmPUrZpUeoVoe6S98gAnCUV
 bDheXekMAutmN6n81xt42pvZCdot+lZL0/hu4Eo5D9WkDRk4QHNQycOKnR2zcUAgCC+a
 Kv7IzCid9YU8QhdjZXxqmTxc0T3ht4xqG7upb6eKCCP5wIOvcVMciCrUL2CBpsDcQKN9
 i61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787256872; x=1787861672;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uHmqw3PgQrwhWNplvoktCYvtMz6v2lpYN+dpIY29gRk=;
 b=c8khMww6eKofasgBt4ZN4rH0CTmiv+FIy36NtvgbFBkVHelob/GALf+D6HcLwWfM5U
 TTYnCoo52UbwvB7Xno3Nr6Q5lST+rFewRYLlhX59L8P95fKcnALxxbMZfX0PPfhdq8sx
 ChCfLAtf+/79Cg2cp4b82WCp5Fer/2s3ZmmU/AVPZ/mhOnQpaYjbFUEQPCksGak/CXSb
 RccCIWWvY169jJPdBfuiWQ1cswaQFLVUIAN/3o0ihEpms+AI3vsz9RWrCNmI5rfuvcoS
 BsCuAm0ub+rV9U3rBMpyYNUzn38UIikpVn+A8e960wwnDxtdqsBmCNaxhDNZaO+FKCXU
 1XGA==
X-Gm-Message-State: AOJu0YxuosRHkuEVB4UggrxsepxBqE5fKRkb2iGdX9M+Mr0BbARhreMd
 Dw7Oyw/7i93gAStb+t1e+ByJcvXJxHS6UgTwG5Q9MyhpxXRhFTRE9V6Jmhh/EFMexvBhOiaMsYD
 CBFsUld6J57+Jn2inTF6eHeVkDcqRt+5/0j+UiCxbwU27cUHykTy+vJSZ+rpxXxBPgub5
X-Gm-Gg: AR+sD12ZDlire8cpsDSFAf2S2TTuRTBTNowGWQBGQphg8vd3OZeX0zKxvRs7UaOzEnL
 uJshbpCa8EOEVioQaAzT1Z41GyeganOcCfqAaduLySrzLnC4++dDCCjpNS0UJirvZsVVtYIZ8Yc
 f0X7tK+jcPSUmnS0h6Qkr+CF4CpnLeIznrMJAu2mk1sKRQryOcaEisl6htcGwN2uH4XUsKgBjw6
 5ypi5LodvFLzu26mrJQVRoVZhUV9keBetFKspsoXmCE2628MRWzKnAIh9pX2UoosouJbXfeqYfX
 6mj2g/iPvXZBdbf7Eu05N5i9lbQPox/QSsgzwX8j6X0eI3UykzcQQOfL+pfbLRqMuqqhK4nKAo8
 mwe6WvPsNWkHVg+jYvsRLJBpj/AevUzAAmaQMzvtKSg==
X-Received: by 2002:a05:622a:4c0c:b0:51a:8c79:a2d with SMTP id
 d75a77b69052e-52df56e5052mr10337101cf.1.1787256871327; 
 Thu, 20 Aug 2026 13:14:31 -0700 (PDT)
X-Received: by 2002:a05:622a:4c0c:b0:51a:8c79:a2d with SMTP id
 d75a77b69052e-52df56e5052mr10336351cf.1.1787256870664; 
 Thu, 20 Aug 2026 13:14:30 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b8ecef78sm3973845e9.0.2026.08.20.13.14.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 20 Aug 2026 13:14:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v2 04/15] target/hexagon: Constify CPUHexagonState in
 hexagon_thread_is_enabled()
Date: Thu, 20 Aug 2026 22:13:44 +0200
Message-ID: <20260820201356.29775-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820201356.29775-1-philmd@oss.qualcomm.com>
References: <20260820201356.29775-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: WfAyfneMiIbdHL9ROonGxZRIw8ey4hjJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE1MiBTYWx0ZWRfXyPnBH7Tq1EhJ
 sREo4V4jOkvBz2uszQzj13xXr80fLAR6R7uDIUqaadSJm2GEq8M/wyKiXACrGZMVhX5RzSw+ROR
 YPf4KpZiWcUvgH1r4wJoQLmZfcrAOKE=
X-Authority-Analysis: v=2.4 cv=T/O8ifKQ c=1 sm=1 tr=0 ts=6a876029 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=8cuzm4DnCyvNWT4wVyEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE1MiBTYWx0ZWRfX+41TJChKjaSw
 2IZuqz07frivFXMpfDj/vcD1qUQchjGhSHwzwILlQm3MZ73iR/NFolWZsqlqz6j64HufCQc9t19
 nxCvqsb9PItd19APdSIROA4gl48c4buJfN6lIL4MIXxPR1uR3/KJeXfOUc9BmmxjAsOLT4c1o3a
 aWo3gDg8yheSwbFAifYPTHVf/AZgoXIhIO2XJOYK45Ls8iJlSP6xn4OTAEmT9oDaME9v6/NElc+
 FFEL+R/u8XOPnRj0pvHqZFNVfFk0aX3Su7We3dZCwJ37bxkppsw4WscpS2sWC+7Ph1YX4XRWTiT
 3rBBc88kzy4n43E6kLtfozqsx+rus25lfO/PRPxwn8c+hrg6bVwOCwiS6eEP+Zq6gL465Htl1oM
 alIOs1PsY8+JRGPtDI0sFmaq91JC7vol6kg1rNfbXX21sR9LwprdaX0YHIbr5wNQ4bpMK3Y5axG
 qIH19lAP6oa7fq6Qs/A==
X-Proofpoint-ORIG-GUID: WfAyfneMiIbdHL9ROonGxZRIw8ey4hjJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_02,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 bulkscore=0
 spamscore=0 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200152
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

@env argument is accessed without modification in
hexagon_thread_is_enabled(), qualify it as const.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/cpu.h | 2 +-
 target/hexagon/cpu.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index c50fbb3f72a..e4f120eda17 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -216,7 +216,7 @@ G_NORETURN void hexagon_raise_exception_err(CPUHexagonState *env,
  * @return true if the @a thread_env hardware thread is
  * not stopped.
  */
-bool hexagon_thread_is_enabled(CPUHexagonState *thread_env);
+bool hexagon_thread_is_enabled(const CPUHexagonState *thread_env);
 uint32_t hexagon_greg_read(CPUHexagonState *env, uint32_t reg);
 void hexagon_cpu_soft_reset(CPUHexagonState *env);
 #endif
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 9765716b516..4cc6bd67c28 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -345,9 +345,9 @@ static void hexagon_cpu_synchronize_from_tb(CPUState *cs,
 }
 
 #ifndef CONFIG_USER_ONLY
-bool hexagon_thread_is_enabled(CPUHexagonState *env)
+bool hexagon_thread_is_enabled(const CPUHexagonState *env)
 {
-    HexagonCPU *cpu = env_archcpu(env);
+    const HexagonCPU *cpu = env_archcpu(env);
     uint32_t modectl;
     uint32_t thread_enabled_mask;
     bool E_bit;
-- 
2.53.0


