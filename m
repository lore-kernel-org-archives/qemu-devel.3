Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71A7606A31B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Xr5epOz0;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Q4cOVBl3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKI2B-0004nP-69; Fri, 23 Oct 2026 12:22:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKI26-0004MH-2J
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:22:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKI20-00035R-Fi
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:22:17 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NG6E4V2215919
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:22:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Zi3oI8o3UlmYUevR+k3hZ6BBbzMRY+nrFQXfBRfLDRs=; b=Xr5epOz0M9eVhok1
 UdQZOkJ9YV28S6bit+3hOLCHSUYznus6zKO24kJopSz2hmxFjJc2GcN0P1htX0Ct
 wB9OQRmC/HimluPSZUdNNrKQ0N885B8hGJSe1lSxfKnY5poBUcRZbtC+z07Qrjpy
 mIh4gzaHcG7lEe+VdkdgudDdGCMRdAR27UuRt1ThvKQ9nXGAhxDho5UZq506KuYr
 DEqgwwSV3SCuF92fZSE2JDXgH0V6YCoFyyJL1V1IdKW4q+ysbIQ7SkCWIqho91lF
 UeLxhO9PUcG6s5lTNr7mqFEQVvHOoCwidB4XgyK5OTkBaNGdWsZxXP2vGm7CDmWl
 rHSxQQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgatc81xd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:22:11 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e82060977so215959685a.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772531; x=1793377331; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Zi3oI8o3UlmYUevR+k3hZ6BBbzMRY+nrFQXfBRfLDRs=;
 b=Q4cOVBl3lCdtfLEIms1sSaV/aM9uwPgmHwfW7x6XmwKPqsJQaEZTkHTCmBVINwRbRD
 x2KokkGJYaiyUoiDyh/HJVFJToPZwSFJwsg7wyWjT5g1T4SjBs17mvl21RSaGExjlVFs
 ymncyqK9aTV4YoYT12QwtTXMJelIQ74emjSvchtPISu8PWSkv/pFUteu8csPukopdJ/P
 9DRECE/tLvMHtODcN4Z2KM44A2w8fD+PQHlpXZh/IaDX44BTjsnkMUFrUqIaJE8Kk/Li
 +oc0xD/lWNyGelmET3mpP3ymE6O33HDclaC/W2WUsrogV+RhSaRpOVctrKiK/Z3TA3Tr
 PhwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772531; x=1793377331;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Zi3oI8o3UlmYUevR+k3hZ6BBbzMRY+nrFQXfBRfLDRs=;
 b=nlA7xLlp8be5kwU2wwL0oyF26+9CGvUH8Oa1AHOx49GL+ERsc0amL3YtuNHdXl3F4x
 7x87u8ZZndOS+THVWc1514SzepXwpX78XxqfkJLvLztOX0hXECqkwYcn84P6FSDoAvdE
 lQ+cEUhbR7GGmxMkZiyr6zmK4qlXe0hiAzTk1zd04RaB6tL21JWMktv/6wVcnQN09sHn
 LeZsbR1GwGsTywnevgaE35RuefDZJXaLVngNk9BMGS4rPuRBGF4e3xYKHtFvgyEjbPGF
 gbArLSKGnC0PvRZRjirCOOR32y0TibMJ7FJ85kKUvSOrS2koo7qjxsVyxwAo2d47uUBg
 mnLA==
X-Gm-Message-State: AFq9FYI6S4dQKbJ89BpuBIrIqdbljUT54tdw8J1/QFMGuXFkimJVf6JS
 T90KOc4naIb3bJ/klHKrixQ304fhBGOlYVUbh2rSYWHM4SfCU312bKexJuS0xIKX2TD6rRlBsdb
 VUFE3FoCKcrlKyqC219L57xXwDgYwsduTNmZrEN8KJA4itWiwuTnTfFG5IQAKyB6QGUJ3
X-Gm-Gg: AYBFou3ny1PuAEhVDbkIeotIQfj4qA3q3WfJQbibCWBvzXL3OpQ3Beesh+7DVs14ysH
 E/xpWvhmEiB800WcdhCyUlIlz3tKZaDLsBHgkeGTtpBu614gGaOKR1q+Xji5ca3lil+xyGbDgi2
 kRWqvQH8BMfSe2DWGgDhlkaVjaavKITXjcE8H6MD73XsulC+Q41ngM73dmw6Q6WQ0IqavoZCn1E
 9orx3E/1H5ocrNqyKViL9Dq4+CEv5VJhCMA7VUqk8euf1vB6WvT/hf/UXby6HUSAzsFM0Kpe/s6
 T/+Md7jB8QaTCBBjlptpOCvRM1JYjCmVdAjZF4w9aILnxJZlnmobcQr8uvPxxZGFGh79pu3UauJ
 M/47c2CcqsoryWvNy8K6/v2/pV04GnCXIUEsvhwTa
X-Received: by 2002:a05:620a:2a01:b0:93a:1196:ce5 with SMTP id
 af79cd13be357-93f62798985mr901334885a.33.1792772530166; 
 Fri, 23 Oct 2026 09:22:10 -0700 (PDT)
X-Received: by 2002:a05:620a:2a01:b0:93a:1196:ce5 with SMTP id
 af79cd13be357-93f62798985mr901328585a.33.1792772529229; 
 Fri, 23 Oct 2026 09:22:09 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a312fc7012sm8739685e9.5.2026.10.23.09.22.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:22:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 71/83] target/riscv: define and call helpers using HELPER macro
Date: Fri, 23 Oct 2026 18:13:19 +0200
Message-ID: <20261023161332.60153-72-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2NCBTYWx0ZWRfX8vAKzRHiC0Qn
 75Rhf7Zbt4ggrHWuxm5K8DROOKLLKAvgA7IeosV9/Fo3ESYUbnCPvBWuS8gQzUzCwf9uFMQrkOb
 7Nr8lWi4GwkUlAsQ4WYTPxfDGEVaYUozuaIuh/P0z5vgfI31rocknC0OY8cPdd+IMNrdz6ELCCR
 TrdyR9TwKvbOCvNpmrcRSWZ9g+MvGSdrq0GHNmEUE69nF/OL4Q3NvOYHlFnasvcupmPM6FbzI9O
 X+XaIhYDh9RqziBcoa1H1MCakAhy+xab4/oy3y4a8bt/B7bi+kGqB3U979Aah9NnPG8YDsrQ7dN
 Dkl0UTMBdBF1agHaX2E4jSI+GPnlJfACum01p3I2J13bf8MQn3gKP1nBbDFQenXxJRETY+kADFY
 ZCTO3MPxMq8aoo/LsBxF7Ex5dcYioAUZkp373bMcwu6et9O+VIiQIGP/jU/u6ISBwUeNBI8mUNv
 ogb8WOl+ujuPnZkrlFA==
X-Proofpoint-GUID: pIgKAl49GlcIE5ShFM605W66fzPjPd4b
X-Authority-Analysis: v=2.4 cv=Scxi5fRu c=1 sm=1 tr=0 ts=6adb89b3 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=awbDs1vtfMtI2_SikkAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: pIgKAl49GlcIE5ShFM605W66fzPjPd4b
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2NCBTYWx0ZWRfX4QFd2wq23/Gw
 4LYjVTi7vWBXa9M0+Uaoia3X+ItrB5avw3rmcCCp/6HrhYzmBXNcvgT4h8ekms+JCJBg7XdIdLO
 EmR7I616QMjikIFhUl3vAM6v4BsnQeo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230064
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

In a upcoming commit, we'll prefix all helpers and helper_info with target
prefix, to disambiguate symbols between targets. As a first step, we need to
make sure all usages are using the existing HELPER macro.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Acked-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-ID: <20261019212046.149572-13-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/riscv/tcg/debug.c      |   2 +-
 target/riscv/tcg/fpu_helper.c | 196 +++++++++++++++++-----------------
 target/riscv/tcg/op_helper.c  |  74 ++++++-------
 3 files changed, 136 insertions(+), 136 deletions(-)

diff --git a/target/riscv/tcg/debug.c b/target/riscv/tcg/debug.c
index aaf2dca17e3..8b58cbd07ab 100644
--- a/target/riscv/tcg/debug.c
+++ b/target/riscv/tcg/debug.c
@@ -789,7 +789,7 @@ bool riscv_itrigger_enabled(CPURISCVState *env)
     return false;
 }
 
-void helper_itrigger_match(CPURISCVState *env)
+void HELPER(itrigger_match)(CPURISCVState *env)
 {
     int count;
     for (int i = 0; i < env->num_triggers; i++) {
diff --git a/target/riscv/tcg/fpu_helper.c b/target/riscv/tcg/fpu_helper.c
index db1475271b6..e755f8a0472 100644
--- a/target/riscv/tcg/fpu_helper.c
+++ b/target/riscv/tcg/fpu_helper.c
@@ -66,7 +66,7 @@ void riscv_cpu_check_fflags(CPURISCVState *env,
                             FloatExceptionFlags pre_fflag) {}
 #endif
 
-void helper_set_rounding_mode(CPURISCVState *env, uint32_t rm)
+void HELPER(set_rounding_mode)(CPURISCVState *env, uint32_t rm)
 {
     FloatRoundMode softrm;
 
@@ -96,7 +96,7 @@ void helper_set_rounding_mode(CPURISCVState *env, uint32_t rm)
     set_float_rounding_mode(softrm, &env->fp_status);
 }
 
-void helper_set_rounding_mode_chkfrm(CPURISCVState *env, uint32_t rm)
+void HELPER(set_rounding_mode_chkfrm)(CPURISCVState *env, uint32_t rm)
 {
     FloatRoundMode softrm;
 
@@ -153,112 +153,112 @@ static uint64_t do_fmadd_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2,
                                         &env->fp_status));
 }
 
-uint64_t helper_fmadd_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
+uint64_t HELPER(fmadd_s)(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
                         uint64_t frs3)
 {
     return do_fmadd_s(env, frs1, frs2, frs3, 0);
 }
 
-uint64_t helper_fmadd_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
+uint64_t HELPER(fmadd_d)(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
                         uint64_t frs3)
 {
     return float64_muladd(frs1, frs2, frs3, 0, &env->fp_status);
 }
 
-uint64_t helper_fmadd_h(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
+uint64_t HELPER(fmadd_h)(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
                         uint64_t frs3)
 {
     return do_fmadd_h(env, frs1, frs2, frs3, 0);
 }
 
-uint64_t helper_fmsub_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
+uint64_t HELPER(fmsub_s)(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
                         uint64_t frs3)
 {
     return do_fmadd_s(env, frs1, frs2, frs3, float_muladd_negate_c);
 }
 
-uint64_t helper_fmsub_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
+uint64_t HELPER(fmsub_d)(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
                         uint64_t frs3)
 {
     return float64_muladd(frs1, frs2, frs3, float_muladd_negate_c,
                           &env->fp_status);
 }
 
-uint64_t helper_fmsub_h(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
+uint64_t HELPER(fmsub_h)(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
                         uint64_t frs3)
 {
     return do_fmadd_h(env, frs1, frs2, frs3, float_muladd_negate_c);
 }
 
-uint64_t helper_fnmsub_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
+uint64_t HELPER(fnmsub_s)(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
                          uint64_t frs3)
 {
     return do_fmadd_s(env, frs1, frs2, frs3, float_muladd_negate_product);
 }
 
-uint64_t helper_fnmsub_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
+uint64_t HELPER(fnmsub_d)(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
                          uint64_t frs3)
 {
     return float64_muladd(frs1, frs2, frs3, float_muladd_negate_product,
                           &env->fp_status);
 }
 
-uint64_t helper_fnmsub_h(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
+uint64_t HELPER(fnmsub_h)(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
                          uint64_t frs3)
 {
     return do_fmadd_h(env, frs1, frs2, frs3, float_muladd_negate_product);
 }
 
-uint64_t helper_fnmadd_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
+uint64_t HELPER(fnmadd_s)(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
                          uint64_t frs3)
 {
     return do_fmadd_s(env, frs1, frs2, frs3,
                       float_muladd_negate_c | float_muladd_negate_product);
 }
 
-uint64_t helper_fnmadd_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
+uint64_t HELPER(fnmadd_d)(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
                          uint64_t frs3)
 {
     return float64_muladd(frs1, frs2, frs3, float_muladd_negate_c |
                           float_muladd_negate_product, &env->fp_status);
 }
 
-uint64_t helper_fnmadd_h(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
+uint64_t HELPER(fnmadd_h)(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
                          uint64_t frs3)
 {
     return do_fmadd_h(env, frs1, frs2, frs3,
                       float_muladd_negate_c | float_muladd_negate_product);
 }
 
-uint64_t helper_fadd_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+uint64_t HELPER(fadd_s)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
     float32 frs1 = check_nanbox_s(env, rs1);
     float32 frs2 = check_nanbox_s(env, rs2);
     return nanbox_s(env, float32_add(frs1, frs2, &env->fp_status));
 }
 
-uint64_t helper_fsub_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+uint64_t HELPER(fsub_s)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
     float32 frs1 = check_nanbox_s(env, rs1);
     float32 frs2 = check_nanbox_s(env, rs2);
     return nanbox_s(env, float32_sub(frs1, frs2, &env->fp_status));
 }
 
-uint64_t helper_fmul_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+uint64_t HELPER(fmul_s)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
     float32 frs1 = check_nanbox_s(env, rs1);
     float32 frs2 = check_nanbox_s(env, rs2);
     return nanbox_s(env, float32_mul(frs1, frs2, &env->fp_status));
 }
 
-uint64_t helper_fdiv_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+uint64_t HELPER(fdiv_s)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
     float32 frs1 = check_nanbox_s(env, rs1);
     float32 frs2 = check_nanbox_s(env, rs2);
     return nanbox_s(env, float32_div(frs1, frs2, &env->fp_status));
 }
 
-uint64_t helper_fmin_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+uint64_t HELPER(fmin_s)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
     float32 frs1 = check_nanbox_s(env, rs1);
     float32 frs2 = check_nanbox_s(env, rs2);
@@ -267,7 +267,7 @@ uint64_t helper_fmin_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
                          float32_minimum_number(frs1, frs2, &env->fp_status));
 }
 
-uint64_t helper_fminm_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+uint64_t HELPER(fminm_s)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
     float32 frs1 = check_nanbox_s(env, rs1);
     float32 frs2 = check_nanbox_s(env, rs2);
@@ -275,7 +275,7 @@ uint64_t helper_fminm_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
     return nanbox_s(env, ret);
 }
 
-uint64_t helper_fmax_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+uint64_t HELPER(fmax_s)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
     float32 frs1 = check_nanbox_s(env, rs1);
     float32 frs2 = check_nanbox_s(env, rs2);
@@ -284,7 +284,7 @@ uint64_t helper_fmax_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
                          float32_maximum_number(frs1, frs2, &env->fp_status));
 }
 
-uint64_t helper_fmaxm_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+uint64_t HELPER(fmaxm_s)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
     float32 frs1 = check_nanbox_s(env, rs1);
     float32 frs2 = check_nanbox_s(env, rs2);
@@ -292,13 +292,13 @@ uint64_t helper_fmaxm_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
     return nanbox_s(env, ret);
 }
 
-uint64_t helper_fsqrt_s(CPURISCVState *env, uint64_t rs1)
+uint64_t HELPER(fsqrt_s)(CPURISCVState *env, uint64_t rs1)
 {
     float32 frs1 = check_nanbox_s(env, rs1);
     return nanbox_s(env, float32_sqrt(frs1, &env->fp_status));
 }
 
-target_ulong helper_fle_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+target_ulong HELPER(fle_s)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
     float32 frs1 = check_nanbox_s(env, rs1);
     float32 frs2 = check_nanbox_s(env, rs2);
@@ -308,7 +308,7 @@ target_ulong helper_fle_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
     return ret;
 }
 
-target_ulong helper_fleq_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+target_ulong HELPER(fleq_s)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
     float32 frs1 = check_nanbox_s(env, rs1);
     float32 frs2 = check_nanbox_s(env, rs2);
@@ -318,7 +318,7 @@ target_ulong helper_fleq_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
     return ret;
 }
 
-target_ulong helper_flt_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+target_ulong HELPER(flt_s)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
     float32 frs1 = check_nanbox_s(env, rs1);
     float32 frs2 = check_nanbox_s(env, rs2);
@@ -328,7 +328,7 @@ target_ulong helper_flt_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
     return ret;
 }
 
-target_ulong helper_fltq_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+target_ulong HELPER(fltq_s)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
     float32 frs1 = check_nanbox_s(env, rs1);
     float32 frs2 = check_nanbox_s(env, rs2);
@@ -338,7 +338,7 @@ target_ulong helper_fltq_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
     return ret;
 }
 
-target_ulong helper_feq_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+target_ulong HELPER(feq_s)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
     float32 frs1 = check_nanbox_s(env, rs1);
     float32 frs2 = check_nanbox_s(env, rs2);
@@ -348,7 +348,7 @@ target_ulong helper_feq_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
     return ret;
 }
 
-target_ulong helper_fcvt_w_s(CPURISCVState *env, uint64_t rs1)
+target_ulong HELPER(fcvt_w_s)(CPURISCVState *env, uint64_t rs1)
 {
     float32 frs1 = check_nanbox_s(env, rs1);
     FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
@@ -357,7 +357,7 @@ target_ulong helper_fcvt_w_s(CPURISCVState *env, uint64_t rs1)
     return ret;
 }
 
-target_ulong helper_fcvt_wu_s(CPURISCVState *env, uint64_t rs1)
+target_ulong HELPER(fcvt_wu_s)(CPURISCVState *env, uint64_t rs1)
 {
     float32 frs1 = check_nanbox_s(env, rs1);
     FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
@@ -366,7 +366,7 @@ target_ulong helper_fcvt_wu_s(CPURISCVState *env, uint64_t rs1)
     return ret;
 }
 
-target_ulong helper_fcvt_l_s(CPURISCVState *env, uint64_t rs1)
+target_ulong HELPER(fcvt_l_s)(CPURISCVState *env, uint64_t rs1)
 {
     float32 frs1 = check_nanbox_s(env, rs1);
     FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
@@ -375,7 +375,7 @@ target_ulong helper_fcvt_l_s(CPURISCVState *env, uint64_t rs1)
     return ret;
 }
 
-target_ulong helper_fcvt_lu_s(CPURISCVState *env, uint64_t rs1)
+target_ulong HELPER(fcvt_lu_s)(CPURISCVState *env, uint64_t rs1)
 {
     float32 frs1 = check_nanbox_s(env, rs1);
     FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
@@ -384,33 +384,33 @@ target_ulong helper_fcvt_lu_s(CPURISCVState *env, uint64_t rs1)
     return ret;
 }
 
-uint64_t helper_fcvt_s_w(CPURISCVState *env, target_ulong rs1)
+uint64_t HELPER(fcvt_s_w)(CPURISCVState *env, target_ulong rs1)
 {
     return nanbox_s(env, int32_to_float32((int32_t)rs1, &env->fp_status));
 }
 
-uint64_t helper_fcvt_s_wu(CPURISCVState *env, target_ulong rs1)
+uint64_t HELPER(fcvt_s_wu)(CPURISCVState *env, target_ulong rs1)
 {
     return nanbox_s(env, uint32_to_float32((uint32_t)rs1, &env->fp_status));
 }
 
-uint64_t helper_fcvt_s_l(CPURISCVState *env, target_ulong rs1)
+uint64_t HELPER(fcvt_s_l)(CPURISCVState *env, target_ulong rs1)
 {
     return nanbox_s(env, int64_to_float32(rs1, &env->fp_status));
 }
 
-uint64_t helper_fcvt_s_lu(CPURISCVState *env, target_ulong rs1)
+uint64_t HELPER(fcvt_s_lu)(CPURISCVState *env, target_ulong rs1)
 {
     return nanbox_s(env, uint64_to_float32(rs1, &env->fp_status));
 }
 
-target_ulong helper_fclass_s(CPURISCVState *env, uint64_t rs1)
+target_ulong HELPER(fclass_s)(CPURISCVState *env, uint64_t rs1)
 {
     float32 frs1 = check_nanbox_s(env, rs1);
     return fclass_s(frs1);
 }
 
-uint64_t helper_fround_s(CPURISCVState *env, uint64_t rs1)
+uint64_t HELPER(fround_s)(CPURISCVState *env, uint64_t rs1)
 {
     float_status *fs = &env->fp_status;
     uint16_t nx_old = get_float_exception_flags(fs) & float_flag_inexact;
@@ -427,74 +427,74 @@ uint64_t helper_fround_s(CPURISCVState *env, uint64_t rs1)
     return nanbox_s(env, frs1);
 }
 
-uint64_t helper_froundnx_s(CPURISCVState *env, uint64_t rs1)
+uint64_t HELPER(froundnx_s)(CPURISCVState *env, uint64_t rs1)
 {
     float32 frs1 = check_nanbox_s(env, rs1);
     frs1 = float32_round_to_int(frs1, &env->fp_status);
     return nanbox_s(env, frs1);
 }
 
-uint64_t helper_fadd_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
+uint64_t HELPER(fadd_d)(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
 {
     return float64_add(frs1, frs2, &env->fp_status);
 }
 
-uint64_t helper_fsub_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
+uint64_t HELPER(fsub_d)(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
 {
     return float64_sub(frs1, frs2, &env->fp_status);
 }
 
-uint64_t helper_fmul_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
+uint64_t HELPER(fmul_d)(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
 {
     return float64_mul(frs1, frs2, &env->fp_status);
 }
 
-uint64_t helper_fdiv_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
+uint64_t HELPER(fdiv_d)(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
 {
     return float64_div(frs1, frs2, &env->fp_status);
 }
 
-uint64_t helper_fmin_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
+uint64_t HELPER(fmin_d)(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
 {
     return env->priv_ver < PRIV_VERSION_1_11_0 ?
            float64_minnum(frs1, frs2, &env->fp_status) :
            float64_minimum_number(frs1, frs2, &env->fp_status);
 }
 
-uint64_t helper_fminm_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
+uint64_t HELPER(fminm_d)(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
 {
     return float64_min(frs1, frs2, &env->fp_status);
 }
 
-uint64_t helper_fmax_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
+uint64_t HELPER(fmax_d)(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
 {
     return env->priv_ver < PRIV_VERSION_1_11_0 ?
            float64_maxnum(frs1, frs2, &env->fp_status) :
            float64_maximum_number(frs1, frs2, &env->fp_status);
 }
 
-uint64_t helper_fmaxm_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
+uint64_t HELPER(fmaxm_d)(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
 {
     return float64_max(frs1, frs2, &env->fp_status);
 }
 
-uint64_t helper_fcvt_s_d(CPURISCVState *env, uint64_t rs1)
+uint64_t HELPER(fcvt_s_d)(CPURISCVState *env, uint64_t rs1)
 {
     return nanbox_s(env, float64_to_float32(rs1, &env->fp_status));
 }
 
-uint64_t helper_fcvt_d_s(CPURISCVState *env, uint64_t rs1)
+uint64_t HELPER(fcvt_d_s)(CPURISCVState *env, uint64_t rs1)
 {
     float32 frs1 = check_nanbox_s(env, rs1);
     return float32_to_float64(frs1, &env->fp_status);
 }
 
-uint64_t helper_fsqrt_d(CPURISCVState *env, uint64_t frs1)
+uint64_t HELPER(fsqrt_d)(CPURISCVState *env, uint64_t frs1)
 {
     return float64_sqrt(frs1, &env->fp_status);
 }
 
-target_ulong helper_fle_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
+target_ulong HELPER(fle_d)(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
 {
     FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
     target_ulong ret = float64_le(frs1, frs2, &env->fp_status);
@@ -502,7 +502,7 @@ target_ulong helper_fle_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
     return ret;
 }
 
-target_ulong helper_fleq_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
+target_ulong HELPER(fleq_d)(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
 {
     FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
     target_ulong ret = float64_le_quiet(frs1, frs2, &env->fp_status);
@@ -510,7 +510,7 @@ target_ulong helper_fleq_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
     return ret;
 }
 
-target_ulong helper_flt_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
+target_ulong HELPER(flt_d)(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
 {
     FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
     target_ulong ret = float64_lt(frs1, frs2, &env->fp_status);
@@ -518,7 +518,7 @@ target_ulong helper_flt_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
     return ret;
 }
 
-target_ulong helper_fltq_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
+target_ulong HELPER(fltq_d)(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
 {
     FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
     target_ulong ret = float64_lt_quiet(frs1, frs2, &env->fp_status);
@@ -526,7 +526,7 @@ target_ulong helper_fltq_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
     return ret;
 }
 
-target_ulong helper_feq_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
+target_ulong HELPER(feq_d)(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
 {
     FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
     target_ulong ret = float64_eq_quiet(frs1, frs2, &env->fp_status);
@@ -534,7 +534,7 @@ target_ulong helper_feq_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
     return ret;
 }
 
-target_ulong helper_fcvt_w_d(CPURISCVState *env, uint64_t frs1)
+target_ulong HELPER(fcvt_w_d)(CPURISCVState *env, uint64_t frs1)
 {
     FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
     target_ulong ret = float64_to_int32(frs1, &env->fp_status);
@@ -542,7 +542,7 @@ target_ulong helper_fcvt_w_d(CPURISCVState *env, uint64_t frs1)
     return ret;
 }
 
-uint64_t helper_fcvtmod_w_d(CPURISCVState *env, uint64_t value)
+uint64_t HELPER(fcvtmod_w_d)(CPURISCVState *env, uint64_t value)
 {
     FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
     uint64_t ret = float64_to_int32_modulo(value, float_round_to_zero,
@@ -551,7 +551,7 @@ uint64_t helper_fcvtmod_w_d(CPURISCVState *env, uint64_t value)
     return ret;
 }
 
-target_ulong helper_fcvt_wu_d(CPURISCVState *env, uint64_t frs1)
+target_ulong HELPER(fcvt_wu_d)(CPURISCVState *env, uint64_t frs1)
 {
     FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
     target_ulong ret = (int32_t)float64_to_uint32(frs1, &env->fp_status);
@@ -559,7 +559,7 @@ target_ulong helper_fcvt_wu_d(CPURISCVState *env, uint64_t frs1)
     return ret;
 }
 
-target_ulong helper_fcvt_l_d(CPURISCVState *env, uint64_t frs1)
+target_ulong HELPER(fcvt_l_d)(CPURISCVState *env, uint64_t frs1)
 {
     FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
     target_ulong ret = float64_to_int64(frs1, &env->fp_status);
@@ -567,7 +567,7 @@ target_ulong helper_fcvt_l_d(CPURISCVState *env, uint64_t frs1)
     return ret;
 }
 
-target_ulong helper_fcvt_lu_d(CPURISCVState *env, uint64_t frs1)
+target_ulong HELPER(fcvt_lu_d)(CPURISCVState *env, uint64_t frs1)
 {
     FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
     target_ulong ret = float64_to_uint64(frs1, &env->fp_status);
@@ -575,32 +575,32 @@ target_ulong helper_fcvt_lu_d(CPURISCVState *env, uint64_t frs1)
     return ret;
 }
 
-uint64_t helper_fcvt_d_w(CPURISCVState *env, target_ulong rs1)
+uint64_t HELPER(fcvt_d_w)(CPURISCVState *env, target_ulong rs1)
 {
     return int32_to_float64((int32_t)rs1, &env->fp_status);
 }
 
-uint64_t helper_fcvt_d_wu(CPURISCVState *env, target_ulong rs1)
+uint64_t HELPER(fcvt_d_wu)(CPURISCVState *env, target_ulong rs1)
 {
     return uint32_to_float64((uint32_t)rs1, &env->fp_status);
 }
 
-uint64_t helper_fcvt_d_l(CPURISCVState *env, target_ulong rs1)
+uint64_t HELPER(fcvt_d_l)(CPURISCVState *env, target_ulong rs1)
 {
     return int64_to_float64(rs1, &env->fp_status);
 }
 
-uint64_t helper_fcvt_d_lu(CPURISCVState *env, target_ulong rs1)
+uint64_t HELPER(fcvt_d_lu)(CPURISCVState *env, target_ulong rs1)
 {
     return uint64_to_float64(rs1, &env->fp_status);
 }
 
-target_ulong helper_fclass_d(uint64_t frs1)
+target_ulong HELPER(fclass_d)(uint64_t frs1)
 {
     return fclass_d(frs1);
 }
 
-uint64_t helper_fround_d(CPURISCVState *env, uint64_t frs1)
+uint64_t HELPER(fround_d)(CPURISCVState *env, uint64_t frs1)
 {
     float_status *fs = &env->fp_status;
     uint16_t nx_old = get_float_exception_flags(fs) & float_flag_inexact;
@@ -616,40 +616,40 @@ uint64_t helper_fround_d(CPURISCVState *env, uint64_t frs1)
     return frs1;
 }
 
-uint64_t helper_froundnx_d(CPURISCVState *env, uint64_t frs1)
+uint64_t HELPER(froundnx_d)(CPURISCVState *env, uint64_t frs1)
 {
     return float64_round_to_int(frs1, &env->fp_status);
 }
 
-uint64_t helper_fadd_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+uint64_t HELPER(fadd_h)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
     float16 frs1 = check_nanbox_h(env, rs1);
     float16 frs2 = check_nanbox_h(env, rs2);
     return nanbox_h(env, float16_add(frs1, frs2, &env->fp_status));
 }
 
-uint64_t helper_fsub_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+uint64_t HELPER(fsub_h)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
     float16 frs1 = check_nanbox_h(env, rs1);
     float16 frs2 = check_nanbox_h(env, rs2);
     return nanbox_h(env, float16_sub(frs1, frs2, &env->fp_status));
 }
 
-uint64_t helper_fmul_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+uint64_t HELPER(fmul_h)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
     float16 frs1 = check_nanbox_h(env, rs1);
     float16 frs2 = check_nanbox_h(env, rs2);
     return nanbox_h(env, float16_mul(frs1, frs2, &env->fp_status));
 }
 
-uint64_t helper_fdiv_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+uint64_t HELPER(fdiv_h)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
     float16 frs1 = check_nanbox_h(env, rs1);
     float16 frs2 = check_nanbox_h(env, rs2);
     return nanbox_h(env, float16_div(frs1, frs2, &env->fp_status));
 }
 
-uint64_t helper_fmin_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+uint64_t HELPER(fmin_h)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
     float16 frs1 = check_nanbox_h(env, rs1);
     float16 frs2 = check_nanbox_h(env, rs2);
@@ -658,7 +658,7 @@ uint64_t helper_fmin_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
                          float16_minimum_number(frs1, frs2, &env->fp_status));
 }
 
-uint64_t helper_fminm_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+uint64_t HELPER(fminm_h)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
     float16 frs1 = check_nanbox_h(env, rs1);
     float16 frs2 = check_nanbox_h(env, rs2);
@@ -666,7 +666,7 @@ uint64_t helper_fminm_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
     return nanbox_h(env, ret);
 }
 
-uint64_t helper_fmax_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+uint64_t HELPER(fmax_h)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
     float16 frs1 = check_nanbox_h(env, rs1);
     float16 frs2 = check_nanbox_h(env, rs2);
@@ -675,7 +675,7 @@ uint64_t helper_fmax_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
                          float16_maximum_number(frs1, frs2, &env->fp_status));
 }
 
-uint64_t helper_fmaxm_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+uint64_t HELPER(fmaxm_h)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
     float16 frs1 = check_nanbox_h(env, rs1);
     float16 frs2 = check_nanbox_h(env, rs2);
@@ -683,13 +683,13 @@ uint64_t helper_fmaxm_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
     return nanbox_h(env, ret);
 }
 
-uint64_t helper_fsqrt_h(CPURISCVState *env, uint64_t rs1)
+uint64_t HELPER(fsqrt_h)(CPURISCVState *env, uint64_t rs1)
 {
     float16 frs1 = check_nanbox_h(env, rs1);
     return nanbox_h(env, float16_sqrt(frs1, &env->fp_status));
 }
 
-target_ulong helper_fle_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+target_ulong HELPER(fle_h)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
     float16 frs1 = check_nanbox_h(env, rs1);
     float16 frs2 = check_nanbox_h(env, rs2);
@@ -699,7 +699,7 @@ target_ulong helper_fle_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
     return ret;
 }
 
-target_ulong helper_fleq_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+target_ulong HELPER(fleq_h)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
     float16 frs1 = check_nanbox_h(env, rs1);
     float16 frs2 = check_nanbox_h(env, rs2);
@@ -709,7 +709,7 @@ target_ulong helper_fleq_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
     return ret;
 }
 
-target_ulong helper_flt_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+target_ulong HELPER(flt_h)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
     float16 frs1 = check_nanbox_h(env, rs1);
     float16 frs2 = check_nanbox_h(env, rs2);
@@ -719,7 +719,7 @@ target_ulong helper_flt_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
     return ret;
 }
 
-target_ulong helper_fltq_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+target_ulong HELPER(fltq_h)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
     float16 frs1 = check_nanbox_h(env, rs1);
     float16 frs2 = check_nanbox_h(env, rs2);
@@ -729,7 +729,7 @@ target_ulong helper_fltq_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
     return ret;
 }
 
-target_ulong helper_feq_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
+target_ulong HELPER(feq_h)(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
     float16 frs1 = check_nanbox_h(env, rs1);
     float16 frs2 = check_nanbox_h(env, rs2);
@@ -739,13 +739,13 @@ target_ulong helper_feq_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
     return ret;
 }
 
-target_ulong helper_fclass_h(CPURISCVState *env, uint64_t rs1)
+target_ulong HELPER(fclass_h)(CPURISCVState *env, uint64_t rs1)
 {
     float16 frs1 = check_nanbox_h(env, rs1);
     return fclass_h(frs1);
 }
 
-uint64_t helper_fround_h(CPURISCVState *env, uint64_t rs1)
+uint64_t HELPER(fround_h)(CPURISCVState *env, uint64_t rs1)
 {
     float_status *fs = &env->fp_status;
     uint16_t nx_old = get_float_exception_flags(fs) & float_flag_inexact;
@@ -762,14 +762,14 @@ uint64_t helper_fround_h(CPURISCVState *env, uint64_t rs1)
     return nanbox_h(env, frs1);
 }
 
-uint64_t helper_froundnx_h(CPURISCVState *env, uint64_t rs1)
+uint64_t HELPER(froundnx_h)(CPURISCVState *env, uint64_t rs1)
 {
     float16 frs1 = check_nanbox_h(env, rs1);
     frs1 = float16_round_to_int(frs1, &env->fp_status);
     return nanbox_h(env, frs1);
 }
 
-target_ulong helper_fcvt_w_h(CPURISCVState *env, uint64_t rs1)
+target_ulong HELPER(fcvt_w_h)(CPURISCVState *env, uint64_t rs1)
 {
     float16 frs1 = check_nanbox_h(env, rs1);
     FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
@@ -778,7 +778,7 @@ target_ulong helper_fcvt_w_h(CPURISCVState *env, uint64_t rs1)
     return ret;
 }
 
-target_ulong helper_fcvt_wu_h(CPURISCVState *env, uint64_t rs1)
+target_ulong HELPER(fcvt_wu_h)(CPURISCVState *env, uint64_t rs1)
 {
     float16 frs1 = check_nanbox_h(env, rs1);
     FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
@@ -787,7 +787,7 @@ target_ulong helper_fcvt_wu_h(CPURISCVState *env, uint64_t rs1)
     return ret;
 }
 
-target_ulong helper_fcvt_l_h(CPURISCVState *env, uint64_t rs1)
+target_ulong HELPER(fcvt_l_h)(CPURISCVState *env, uint64_t rs1)
 {
     float16 frs1 = check_nanbox_h(env, rs1);
     FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
@@ -796,7 +796,7 @@ target_ulong helper_fcvt_l_h(CPURISCVState *env, uint64_t rs1)
     return ret;
 }
 
-target_ulong helper_fcvt_lu_h(CPURISCVState *env, uint64_t rs1)
+target_ulong HELPER(fcvt_lu_h)(CPURISCVState *env, uint64_t rs1)
 {
     float16 frs1 = check_nanbox_h(env, rs1);
     FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
@@ -805,56 +805,56 @@ target_ulong helper_fcvt_lu_h(CPURISCVState *env, uint64_t rs1)
     return ret;
 }
 
-uint64_t helper_fcvt_h_w(CPURISCVState *env, target_ulong rs1)
+uint64_t HELPER(fcvt_h_w)(CPURISCVState *env, target_ulong rs1)
 {
     return nanbox_h(env, int32_to_float16((int32_t)rs1, &env->fp_status));
 }
 
-uint64_t helper_fcvt_h_wu(CPURISCVState *env, target_ulong rs1)
+uint64_t HELPER(fcvt_h_wu)(CPURISCVState *env, target_ulong rs1)
 {
     return nanbox_h(env, uint32_to_float16((uint32_t)rs1, &env->fp_status));
 }
 
-uint64_t helper_fcvt_h_l(CPURISCVState *env, target_ulong rs1)
+uint64_t HELPER(fcvt_h_l)(CPURISCVState *env, target_ulong rs1)
 {
     return nanbox_h(env, int64_to_float16(rs1, &env->fp_status));
 }
 
-uint64_t helper_fcvt_h_lu(CPURISCVState *env, target_ulong rs1)
+uint64_t HELPER(fcvt_h_lu)(CPURISCVState *env, target_ulong rs1)
 {
     return nanbox_h(env, uint64_to_float16(rs1, &env->fp_status));
 }
 
-uint64_t helper_fcvt_h_s(CPURISCVState *env, uint64_t rs1)
+uint64_t HELPER(fcvt_h_s)(CPURISCVState *env, uint64_t rs1)
 {
     float32 frs1 = check_nanbox_s(env, rs1);
     return nanbox_h(env, float32_to_float16(frs1, true, &env->fp_status));
 }
 
-uint64_t helper_fcvt_s_h(CPURISCVState *env, uint64_t rs1)
+uint64_t HELPER(fcvt_s_h)(CPURISCVState *env, uint64_t rs1)
 {
     float16 frs1 = check_nanbox_h(env, rs1);
     return nanbox_s(env, float16_to_float32(frs1, true, &env->fp_status));
 }
 
-uint64_t helper_fcvt_h_d(CPURISCVState *env, uint64_t rs1)
+uint64_t HELPER(fcvt_h_d)(CPURISCVState *env, uint64_t rs1)
 {
     return nanbox_h(env, float64_to_float16(rs1, true, &env->fp_status));
 }
 
-uint64_t helper_fcvt_d_h(CPURISCVState *env, uint64_t rs1)
+uint64_t HELPER(fcvt_d_h)(CPURISCVState *env, uint64_t rs1)
 {
     float16 frs1 = check_nanbox_h(env, rs1);
     return float16_to_float64(frs1, true, &env->fp_status);
 }
 
-uint64_t helper_fcvt_bf16_s(CPURISCVState *env, uint64_t rs1)
+uint64_t HELPER(fcvt_bf16_s)(CPURISCVState *env, uint64_t rs1)
 {
     float32 frs1 = check_nanbox_s(env, rs1);
     return nanbox_h(env, float32_to_bfloat16(frs1, &env->fp_status));
 }
 
-uint64_t helper_fcvt_s_bf16(CPURISCVState *env, uint64_t rs1)
+uint64_t HELPER(fcvt_s_bf16)(CPURISCVState *env, uint64_t rs1)
 {
     float16 frs1 = check_nanbox_bf16(env, rs1);
     return nanbox_s(env, bfloat16_to_float32(frs1, &env->fp_status));
diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.c
index f85f5cd83c9..f9c79fe6b90 100644
--- a/target/riscv/tcg/op_helper.c
+++ b/target/riscv/tcg/op_helper.c
@@ -48,7 +48,7 @@ G_NORETURN void riscv_raise_exception(CPURISCVState *env,
     cpu_loop_exit_restore(cs, pc);
 }
 
-void helper_raise_exception(CPURISCVState *env, uint32_t exception)
+void HELPER(raise_exception)(CPURISCVState *env, uint32_t exception)
 {
 #ifndef CONFIG_USER_ONLY
     riscv_pmu_decr_instret(env);
@@ -56,7 +56,7 @@ void helper_raise_exception(CPURISCVState *env, uint32_t exception)
     riscv_raise_exception(env, exception, 0);
 }
 
-target_ulong helper_csrr(CPURISCVState *env, int csr)
+target_ulong HELPER(csrr)(CPURISCVState *env, int csr)
 {
     /*
      * The seed CSR must be accessed with a read-write instruction. A
@@ -76,7 +76,7 @@ target_ulong helper_csrr(CPURISCVState *env, int csr)
     return val;
 }
 
-void helper_csrw(CPURISCVState *env, int csr, target_ulong src)
+void HELPER(csrw)(CPURISCVState *env, int csr, target_ulong src)
 {
     target_ulong mask = env->xl == MXL_RV32 ? UINT32_MAX : (target_ulong)-1;
     RISCVException ret = riscv_csrrw(env, csr, NULL, src, mask, GETPC());
@@ -86,7 +86,7 @@ void helper_csrw(CPURISCVState *env, int csr, target_ulong src)
     }
 }
 
-target_ulong helper_csrrw(CPURISCVState *env, int csr,
+target_ulong HELPER(csrrw)(CPURISCVState *env, int csr,
                           target_ulong src, target_ulong write_mask)
 {
     target_ulong val = 0;
@@ -98,7 +98,7 @@ target_ulong helper_csrrw(CPURISCVState *env, int csr,
     return val;
 }
 
-target_ulong helper_csrr_i128(CPURISCVState *env, int csr)
+target_ulong HELPER(csrr_i128)(CPURISCVState *env, int csr)
 {
     Int128 rv = int128_zero();
     RISCVException ret = riscv_csrr_i128(env, csr, &rv);
@@ -111,7 +111,7 @@ target_ulong helper_csrr_i128(CPURISCVState *env, int csr)
     return int128_getlo(rv);
 }
 
-void helper_csrw_i128(CPURISCVState *env, int csr,
+void HELPER(csrw_i128)(CPURISCVState *env, int csr,
                       target_ulong srcl, target_ulong srch)
 {
     RISCVException ret = riscv_csrrw_i128(env, csr, NULL,
@@ -123,7 +123,7 @@ void helper_csrw_i128(CPURISCVState *env, int csr,
     }
 }
 
-target_ulong helper_csrrw_i128(CPURISCVState *env, int csr,
+target_ulong HELPER(csrrw_i128)(CPURISCVState *env, int csr,
                                target_ulong srcl, target_ulong srch,
                                target_ulong maskl, target_ulong maskh)
 {
@@ -178,7 +178,7 @@ static void check_zicbo_envcfg(CPURISCVState *env, target_ulong envbits,
 #endif
 }
 
-void helper_cbo_zero(CPURISCVState *env, target_ulong address)
+void HELPER(cbo_zero)(CPURISCVState *env, target_ulong address)
 {
     RISCVCPU *cpu = env_archcpu(env);
     uint16_t cbozlen = cpu->cfg.cboz_blocksize;
@@ -266,7 +266,7 @@ static void check_zicbom_access(CPURISCVState *env,
     probe_write(env, address, cbomlen, mmu_idx, ra);
 }
 
-void helper_cbo_clean_flush(CPURISCVState *env, target_ulong address)
+void HELPER(cbo_clean_flush)(CPURISCVState *env, target_ulong address)
 {
     uintptr_t ra = GETPC();
     check_zicbo_envcfg(env, MENVCFG_CBCFE, ra);
@@ -275,7 +275,7 @@ void helper_cbo_clean_flush(CPURISCVState *env, target_ulong address)
     /* We don't emulate the cache-hierarchy, so we're done. */
 }
 
-void helper_cbo_inval(CPURISCVState *env, target_ulong address)
+void HELPER(cbo_inval)(CPURISCVState *env, target_ulong address)
 {
     uintptr_t ra = GETPC();
     check_zicbo_envcfg(env, MENVCFG_CBIE, ra);
@@ -284,7 +284,7 @@ void helper_cbo_inval(CPURISCVState *env, target_ulong address)
     /* We don't emulate the cache-hierarchy, so we're done. */
 }
 
-void helper_sc_probe_write(CPURISCVState *env, target_ulong addr,
+void HELPER(sc_probe_write)(CPURISCVState *env, target_ulong addr,
                            target_ulong size)
 {
     uintptr_t ra = GETPC();
@@ -300,7 +300,7 @@ void helper_sc_probe_write(CPURISCVState *env, target_ulong addr,
 
 #ifndef CONFIG_USER_ONLY
 
-target_ulong helper_sret(CPURISCVState *env)
+target_ulong HELPER(sret)(CPURISCVState *env)
 {
     uint64_t mstatus;
     privilege_mode_t prev_priv;
@@ -423,7 +423,7 @@ static target_ulong ssdbltrp_mxret(CPURISCVState *env, target_ulong mstatus,
     return mstatus;
 }
 
-target_ulong helper_mret(CPURISCVState *env)
+target_ulong HELPER(mret)(CPURISCVState *env)
 {
     target_ulong retpc = env->mepc & get_xepc_mask(env);
     uint64_t mstatus = env->mstatus;
@@ -473,7 +473,7 @@ target_ulong helper_mret(CPURISCVState *env)
     return retpc;
 }
 
-target_ulong helper_dret(CPURISCVState *env)
+target_ulong HELPER(dret)(CPURISCVState *env)
 {
 #ifdef CONFIG_USER_ONLY
     riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
@@ -491,7 +491,7 @@ target_ulong helper_dret(CPURISCVState *env)
 #endif
 }
 
-void helper_sdext_step(CPURISCVState *env)
+void HELPER(sdext_step)(CPURISCVState *env)
 {
 #ifndef CONFIG_USER_ONLY
     CPUState *cs = env_cpu(env);
@@ -507,7 +507,7 @@ void helper_sdext_step(CPURISCVState *env)
 #endif
 }
 
-void helper_sdext_ebreak(CPURISCVState *env, target_ulong pc)
+void HELPER(sdext_ebreak)(CPURISCVState *env, target_ulong pc)
 {
     CPUState *cs = env_cpu(env);
     bool enter_debug = false;
@@ -541,7 +541,7 @@ void helper_sdext_ebreak(CPURISCVState *env, target_ulong pc)
     riscv_raise_exception(env, RISCV_EXCP_BREAKPOINT, GETPC());
 }
 
-target_ulong helper_mnret(CPURISCVState *env)
+target_ulong HELPER(mnret)(CPURISCVState *env)
 {
     target_ulong retpc = env->mnepc;
     privilege_mode_t prev_priv = get_field(env->mnstatus, MNSTATUS_MNPP);
@@ -589,14 +589,14 @@ target_ulong helper_mnret(CPURISCVState *env)
     return retpc;
 }
 
-void helper_ctr_add_entry(CPURISCVState *env, target_ulong src,
+void HELPER(ctr_add_entry)(CPURISCVState *env, target_ulong src,
                           target_ulong dest, target_ulong type)
 {
     riscv_ctr_add_entry(env, src, dest, (enum CTRType)type,
                         env->priv, env->virt_enabled);
 }
 
-void helper_ctr_clear(CPURISCVState *env)
+void HELPER(ctr_clear)(CPURISCVState *env)
 {
     /*
      * It's safe to call smstateen_acc_ok() for umode access regardless of the
@@ -625,7 +625,7 @@ void helper_ctr_clear(CPURISCVState *env)
     riscv_ctr_clear(env);
 }
 
-void helper_wfi(CPURISCVState *env)
+void HELPER(wfi)(CPURISCVState *env)
 {
     CPUState *cs = env_cpu(env);
     bool rvs = riscv_has_ext(env, RVS);
@@ -649,7 +649,7 @@ void helper_wfi(CPURISCVState *env)
     }
 }
 
-void helper_wrs_nto(CPURISCVState *env)
+void HELPER(wrs_nto)(CPURISCVState *env)
 {
     if (env->virt_enabled && (env->priv == PRV_S || env->priv == PRV_U) &&
         get_field(env->hstatus, HSTATUS_VTW) &&
@@ -660,7 +660,7 @@ void helper_wrs_nto(CPURISCVState *env)
     }
 }
 
-void helper_tlb_flush(CPURISCVState *env)
+void HELPER(tlb_flush)(CPURISCVState *env)
 {
     CPUState *cs = env_cpu(env);
     if (!env->virt_enabled &&
@@ -675,13 +675,13 @@ void helper_tlb_flush(CPURISCVState *env)
     }
 }
 
-void helper_tlb_flush_all(CPURISCVState *env)
+void HELPER(tlb_flush_all)(CPURISCVState *env)
 {
     CPUState *cs = env_cpu(env);
     tlb_flush_all_cpus_synced(cs);
 }
 
-void helper_hyp_tlb_flush(CPURISCVState *env)
+void HELPER(hyp_tlb_flush)(CPURISCVState *env)
 {
     CPUState *cs = env_cpu(env);
 
@@ -698,14 +698,14 @@ void helper_hyp_tlb_flush(CPURISCVState *env)
     riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
 }
 
-void helper_hyp_gvma_tlb_flush(CPURISCVState *env)
+void HELPER(hyp_gvma_tlb_flush)(CPURISCVState *env)
 {
     if (env->priv == PRV_S && !env->virt_enabled &&
         get_field(env->mstatus, MSTATUS_TVM)) {
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     }
 
-    helper_hyp_tlb_flush(env);
+    HELPER(hyp_tlb_flush)(env);
 }
 
 static int check_access_hlsv(CPURISCVState *env, bool x, uintptr_t ra)
@@ -725,7 +725,7 @@ static int check_access_hlsv(CPURISCVState *env, bool x, uintptr_t ra)
     return mode | MMU_2STAGE_BIT;
 }
 
-target_ulong helper_hyp_hlv_bu(CPURISCVState *env, target_ulong addr)
+target_ulong HELPER(hyp_hlv_bu)(CPURISCVState *env, target_ulong addr)
 {
     uintptr_t ra = GETPC();
     int mmu_idx = check_access_hlsv(env, false, ra);
@@ -734,7 +734,7 @@ target_ulong helper_hyp_hlv_bu(CPURISCVState *env, target_ulong addr)
     return cpu_ldb_mmu(env, adjust_addr_virt(env, addr), oi, ra);
 }
 
-target_ulong helper_hyp_hlv_hu(CPURISCVState *env, target_ulong addr)
+target_ulong HELPER(hyp_hlv_hu)(CPURISCVState *env, target_ulong addr)
 {
     uintptr_t ra = GETPC();
     int mmu_idx = check_access_hlsv(env, false, ra);
@@ -743,7 +743,7 @@ target_ulong helper_hyp_hlv_hu(CPURISCVState *env, target_ulong addr)
     return cpu_ldw_mmu(env, adjust_addr_virt(env, addr), oi, ra);
 }
 
-target_ulong helper_hyp_hlv_wu(CPURISCVState *env, target_ulong addr)
+target_ulong HELPER(hyp_hlv_wu)(CPURISCVState *env, target_ulong addr)
 {
     uintptr_t ra = GETPC();
     int mmu_idx = check_access_hlsv(env, false, ra);
@@ -752,7 +752,7 @@ target_ulong helper_hyp_hlv_wu(CPURISCVState *env, target_ulong addr)
     return cpu_ldl_mmu(env, adjust_addr_virt(env, addr), oi, ra);
 }
 
-target_ulong helper_hyp_hlv_d(CPURISCVState *env, target_ulong addr)
+target_ulong HELPER(hyp_hlv_d)(CPURISCVState *env, target_ulong addr)
 {
     uintptr_t ra = GETPC();
     int mmu_idx = check_access_hlsv(env, false, ra);
@@ -761,7 +761,7 @@ target_ulong helper_hyp_hlv_d(CPURISCVState *env, target_ulong addr)
     return cpu_ldq_mmu(env, adjust_addr_virt(env, addr), oi, ra);
 }
 
-void helper_hyp_hsv_b(CPURISCVState *env, target_ulong addr, target_ulong val)
+void HELPER(hyp_hsv_b)(CPURISCVState *env, target_ulong addr, target_ulong val)
 {
     uintptr_t ra = GETPC();
     int mmu_idx = check_access_hlsv(env, false, ra);
@@ -770,7 +770,7 @@ void helper_hyp_hsv_b(CPURISCVState *env, target_ulong addr, target_ulong val)
     cpu_stb_mmu(env, adjust_addr_virt(env, addr), val, oi, ra);
 }
 
-void helper_hyp_hsv_h(CPURISCVState *env, target_ulong addr, target_ulong val)
+void HELPER(hyp_hsv_h)(CPURISCVState *env, target_ulong addr, target_ulong val)
 {
     uintptr_t ra = GETPC();
     int mmu_idx = check_access_hlsv(env, false, ra);
@@ -779,7 +779,7 @@ void helper_hyp_hsv_h(CPURISCVState *env, target_ulong addr, target_ulong val)
     cpu_stw_mmu(env, adjust_addr_virt(env, addr), val, oi, ra);
 }
 
-void helper_hyp_hsv_w(CPURISCVState *env, target_ulong addr, target_ulong val)
+void HELPER(hyp_hsv_w)(CPURISCVState *env, target_ulong addr, target_ulong val)
 {
     uintptr_t ra = GETPC();
     int mmu_idx = check_access_hlsv(env, false, ra);
@@ -788,7 +788,7 @@ void helper_hyp_hsv_w(CPURISCVState *env, target_ulong addr, target_ulong val)
     cpu_stl_mmu(env, adjust_addr_virt(env, addr), val, oi, ra);
 }
 
-void helper_hyp_hsv_d(CPURISCVState *env, target_ulong addr, target_ulong val)
+void HELPER(hyp_hsv_d)(CPURISCVState *env, target_ulong addr, target_ulong val)
 {
     uintptr_t ra = GETPC();
     int mmu_idx = check_access_hlsv(env, false, ra);
@@ -804,7 +804,7 @@ void helper_hyp_hsv_d(CPURISCVState *env, target_ulong addr, target_ulong val)
  * a fair fraction of cputlb.c, fixing this requires adding new mmu_idx
  * which would imply that exact check in tlb_fill.
  */
-target_ulong helper_hyp_hlvx_hu(CPURISCVState *env, target_ulong addr)
+target_ulong HELPER(hyp_hlvx_hu)(CPURISCVState *env, target_ulong addr)
 {
     uintptr_t ra = GETPC();
     int mmu_idx = check_access_hlsv(env, true, ra);
@@ -813,7 +813,7 @@ target_ulong helper_hyp_hlvx_hu(CPURISCVState *env, target_ulong addr)
     return cpu_ldw_code_mmu(env, addr, oi, GETPC());
 }
 
-target_ulong helper_hyp_hlvx_wu(CPURISCVState *env, target_ulong addr)
+target_ulong HELPER(hyp_hlvx_wu)(CPURISCVState *env, target_ulong addr)
 {
     uintptr_t ra = GETPC();
     int mmu_idx = check_access_hlsv(env, true, ra);
@@ -822,7 +822,7 @@ target_ulong helper_hyp_hlvx_wu(CPURISCVState *env, target_ulong addr)
     return cpu_ldl_code_mmu(env, addr, oi, ra);
 }
 
-void helper_ssamoswap_disabled(CPURISCVState *env)
+void HELPER(ssamoswap_disabled)(CPURISCVState *env)
 {
     int exception = RISCV_EXCP_ILLEGAL_INST;
 
-- 
2.55.0


