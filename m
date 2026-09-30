Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC5CCA5FA5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 02:03:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBjde-0007Rq-Vl; Tue, 29 Sep 2026 22:01:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBjdc-0007Qh-IT
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 22:01:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBjda-00034Y-RD
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 22:01:40 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68U1ANOR1264007
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 02:01:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=c1f3WjK+TCH
 79vpGD0ASgo614Wt31axztWU+EVmj9yg=; b=hNyPlFIkCq+4t73m3Df0IbRnBkt
 TtHDaYxgUpG8I0wR+Mtruty3TwhK7eldKHdGhOTtm8AQScvW6lrVVG5O/ctkJKOb
 I/AHab5L5S4A9fJBgrDqU7sCoz43T2epNLy4WHDAcJspFxO8TheKv1xz062w/E9C
 b/sPMmqgepctGHJJL77sc0YlEV6TjzRzeWntOeHzpOEXM8bFQlK1aV0Kx2wyLTa0
 UlSttxzGzjnPu17YPGAThc3zHqro4F4Tf0AkYqlTathcZEmOT9i6g42ZC6glUHg5
 p9az3wQEXTytGim3qUmzHJKJ3U0WMVmETJzZFg0XksmbvAdW0E32hdLgv5g==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0rheg51h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 02:01:37 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-342b66c0b06so1664766eec.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 19:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790733697; x=1791338497; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=c1f3WjK+TCH79vpGD0ASgo614Wt31axztWU+EVmj9yg=;
 b=Z+xXVBPt52uFBK1F+lgPDgioqxDf5M08tJLNu+fxq1xXxBDWNj+RoBGvxNgG1khRlQ
 5nDwrcQ8AC9HRlcoYPF30p7iosjT8Q5U6dZfrT76XgXfHk/aO0UEX7s4Vn5p4ckhSpXV
 qwfpXNqL89JlLs7IecTsFA23tqqxzbNlp7BV5dBL9NvhZ5E9HFJ1zT6pyb47cbNFSw/K
 KuORVN2YdcjyiT6VOHoyod0rRKShTGBIjj+X5LtIQap1rLxLek7K0paTrX6zfCtJVWAK
 PJurnSn1yFNI1TWj62pALeYfaIidhiEdJNBQWEtif6uhYnQg+ojR5kZz/BMmvOTfEB/3
 FVUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790733697; x=1791338497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=c1f3WjK+TCH79vpGD0ASgo614Wt31axztWU+EVmj9yg=;
 b=bJTNGkertHs8P2kzxLmfsREsDNsA+37HaSmu025L2WoqzVmfToR8G//pbO3e1XZWue
 H95wtrSVSFMPNkwrw9qRq389sF2YUvN12jqF4eZ4xFj5J+/mYybTXfE7Kiqkf+YMNZC+
 aZCJ9BxKSnvMDBXrFYTL87LAw/ZdoWK8c0tt8FPMCje8kiBXY+Xv7WO8Ao9DXJL0rHm3
 4Hx/0ITcv4y1xz/VTIdWUuJva/c1FThbGwFdcHzkTkxVtpRcXzE7hPAIoe1wn+TAjjs3
 9DpjAxsSm1wtCBoVq6udvWI3DASWQVsET/DkRACTVLSEiTVBqF1GkqJmv4AiWNBhLSns
 Batg==
X-Gm-Message-State: AFuF++nIVCC2pcup3SRzvg6Gfw5vDe5PIOIgdsc2HEj1F3ItLCdfdkv7
 ormiZHMMwXDwC59j6p4y10/gQEWh2Mhuy2N7B7loxZIXpjj7mC3sh4hUVJSdxUvg4EZpGlpMQxm
 +uyFNzf81bRprX+4DAMuPK5/ZAR1LMdLYyfU+ZgQ7rV9TThrgYoOIlfLzToMg/2ocKw==
X-Gm-Gg: AYBFou34Atkxxi5uGMIQABIMtBphnrh6FkXTGgPNPu0CuYSonuVHb4Bm93jhERZqENH
 sYeqouquBSLyI7IitbrCcFQP4r7RVbObZqI7+7YYUT98R+CaBm2Pf540k7kblYt3t8Hn9xSPvbD
 DNrTeJuKokMc9PcKXikHpZG26AVWepcri3iW7J6UDMnymeG61d/hiVguBaj/yx5TAzE+nYnf3rS
 c54u55X0jEOBUb6LeBTcFrsj1+8piy/HlAH46kWqB+BqKECUm8M/YZfWCULVKIer58HbCiZzhp8
 lDhLpusVCinjcsf9uTLH2SXBzH/lgLUruGtSeMiYgxX0LzezcgPtoJHsAGcrBwDmPnXk+h1BaAI
 IzH5kmMrkkOttaIUayEpD1LgWXbdbg9zHgJP/fKJFo6bk0YYFNnVN1k27FFqg
X-Received: by 2002:a05:701b:42c5:20b0:148:bce6:429b with SMTP id
 a92af1059eb24-14b2d993e52mr5255051c88.8.1790733696180; 
 Tue, 29 Sep 2026 19:01:36 -0700 (PDT)
X-Received: by 2002:a05:701b:42c5:20b0:148:bce6:429b with SMTP id
 a92af1059eb24-14b2d993e52mr5254922c88.8.1790733693368; 
 Tue, 29 Sep 2026 19:01:33 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34c388cc02esm3174803eec.21.2026.09.29.19.01.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 19:01:31 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 04/21] target/microblaze: prefix helper conflicting with
 other arch
Date: Wed, 30 Sep 2026 02:00:51 +0000
Message-ID: <20260930020108.217892-5-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260930020108.217892-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260930020108.217892-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: LPoHSY7pRP9wlVThST5DrbX4yi2snsa6
X-Proofpoint-ORIG-GUID: LPoHSY7pRP9wlVThST5DrbX4yi2snsa6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAwNyBTYWx0ZWRfXwiix97Bq3KO9
 TQgYd1YPw0rq5TAybiTRfsqjN4sVyUc+3UeblwfufaPWyzRmN++a9AwPVqUFSVkD4YybSTuZIMK
 hwAm6L5ZS8GymedHJfODRUXY0aWyXYGsZ2xfmSr+/SEkba2MfwOrxatCL05ReW20wjAKCVJAQOf
 9jnqjYm06fE/J4O6GoTCDMg5g0Ikt19OkwYP/lpas6Qai2m6pw35YKM/Dmi+i/puub7u2CCsOzR
 jOuy8jACm6eWAln86W1JbD0vlpSKsr92S5hS3mtLbh0xcgFhPCfEcW/HJsTW9JKvZ88aJ/zwBBp
 QFcRzW/eGr013uwm+w4m7N4iZsF+cNxjOOSVj2Gw3pYMZreRLV327ZVRLED7uAPB6IrdcxXBXBF
 9Hf4aR0NiQBbHW0HTKLm2Rxua7vLWNZKRUM2fxrCfBOGEGWhV6D6t4Uwn1feliC2UqLXvSj6wAj
 UShN8a3qHl+PvQ8iGoA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAwNyBTYWx0ZWRfX6cU83L9rbixg
 f151XdQqtL/fECuU6Q8wN6pDty3Cn8S3D/Jd3rQg6pDOTsXYSsRFMYV9jZPFZKQCmUH5RYcSEKj
 l9Gowp3NwHwVq/73wnF7CdlSGxIbOdc=
X-Authority-Analysis: v=2.4 cv=Tu1zFzXh c=1 sm=1 tr=0 ts=6abc6d81 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=WCYGlPGn4HfFrzm5WJIA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300007
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/microblaze/helper.h    | 10 +++++-----
 target/microblaze/op_helper.c | 10 +++++-----
 target/microblaze/translate.c | 10 +++++-----
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/target/microblaze/helper.h b/target/microblaze/helper.h
index 1429c1727ef..63a94ac4bbc 100644
--- a/target/microblaze/helper.h
+++ b/target/microblaze/helper.h
@@ -1,15 +1,15 @@
-DEF_HELPER_FLAGS_2(raise_exception, TCG_CALL_NO_WG, noreturn, env, i32)
+DEF_HELPER_FLAGS_2(microblaze_raise_exception, TCG_CALL_NO_WG, noreturn, env, i32)
 
 DEF_HELPER_FLAGS_3(divs, TCG_CALL_NO_WG, i32, env, i32, i32)
 DEF_HELPER_FLAGS_3(divu, TCG_CALL_NO_WG, i32, env, i32, i32)
 
-DEF_HELPER_FLAGS_3(fadd, TCG_CALL_NO_WG, i32, env, i32, i32)
+DEF_HELPER_FLAGS_3(microblaze_fadd, TCG_CALL_NO_WG, i32, env, i32, i32)
 DEF_HELPER_FLAGS_3(frsub, TCG_CALL_NO_WG, i32, env, i32, i32)
-DEF_HELPER_FLAGS_3(fmul, TCG_CALL_NO_WG, i32, env, i32, i32)
-DEF_HELPER_FLAGS_3(fdiv, TCG_CALL_NO_WG, i32, env, i32, i32)
+DEF_HELPER_FLAGS_3(microblaze_fmul, TCG_CALL_NO_WG, i32, env, i32, i32)
+DEF_HELPER_FLAGS_3(microblaze_fdiv, TCG_CALL_NO_WG, i32, env, i32, i32)
 DEF_HELPER_FLAGS_2(flt, TCG_CALL_NO_WG, i32, env, i32)
 DEF_HELPER_FLAGS_2(fint, TCG_CALL_NO_WG, i32, env, i32)
-DEF_HELPER_FLAGS_2(fsqrt, TCG_CALL_NO_WG, i32, env, i32)
+DEF_HELPER_FLAGS_2(microblaze_fsqrt, TCG_CALL_NO_WG, i32, env, i32)
 
 DEF_HELPER_FLAGS_3(fcmp_un, TCG_CALL_NO_WG, i32, env, i32, i32)
 DEF_HELPER_FLAGS_3(fcmp_lt, TCG_CALL_NO_WG, i32, env, i32, i32)
diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index 3da0c68da39..c169312e954 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -62,7 +62,7 @@ uint32_t helper_get(uint32_t id, uint32_t ctrl)
     return 0xdead0000 | id;
 }
 
-void helper_raise_exception(CPUMBState *env, uint32_t index)
+void helper_microblaze_raise_exception(CPUMBState *env, uint32_t index)
 {
     CPUState *cs = env_cpu(env);
 
@@ -154,7 +154,7 @@ static void update_fpu_flags(CPUMBState *env, int flags, uintptr_t ra)
     }
 }
 
-uint32_t helper_fadd(CPUMBState *env, uint32_t a, uint32_t b)
+uint32_t helper_microblaze_fadd(CPUMBState *env, uint32_t a, uint32_t b)
 {
     CPU_FloatU fd, fa, fb;
     int flags;
@@ -183,7 +183,7 @@ uint32_t helper_frsub(CPUMBState *env, uint32_t a, uint32_t b)
     return fd.l;
 }
 
-uint32_t helper_fmul(CPUMBState *env, uint32_t a, uint32_t b)
+uint32_t helper_microblaze_fmul(CPUMBState *env, uint32_t a, uint32_t b)
 {
     CPU_FloatU fd, fa, fb;
     int flags;
@@ -198,7 +198,7 @@ uint32_t helper_fmul(CPUMBState *env, uint32_t a, uint32_t b)
     return fd.l;
 }
 
-uint32_t helper_fdiv(CPUMBState *env, uint32_t a, uint32_t b)
+uint32_t helper_microblaze_fdiv(CPUMBState *env, uint32_t a, uint32_t b)
 {
     CPU_FloatU fd, fa, fb;
     int flags;
@@ -352,7 +352,7 @@ uint32_t helper_fint(CPUMBState *env, uint32_t a)
     return r;
 }
 
-uint32_t helper_fsqrt(CPUMBState *env, uint32_t a)
+uint32_t helper_microblaze_fsqrt(CPUMBState *env, uint32_t a)
 {
     CPU_FloatU fd, fa;
     int flags;
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 8b219afb5dd..16794059a22 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -100,7 +100,7 @@ static void t_sync_flags(DisasContext *dc)
 
 static void gen_raise_exception(DisasContext *dc, uint32_t index)
 {
-    gen_helper_raise_exception(tcg_env, tcg_constant_i32(index));
+    gen_helper_microblaze_raise_exception(tcg_env, tcg_constant_i32(index));
     dc->base.is_jmp = DISAS_NORETURN;
 }
 
@@ -421,10 +421,10 @@ static void gen_cmpu(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
 DO_TYPEA(cmp, false, gen_cmp)
 DO_TYPEA(cmpu, false, gen_cmpu)
 
-ENV_WRAPPER3(gen_fadd, gen_helper_fadd)
+ENV_WRAPPER3(gen_fadd, gen_helper_microblaze_fadd)
 ENV_WRAPPER3(gen_frsub, gen_helper_frsub)
-ENV_WRAPPER3(gen_fmul, gen_helper_fmul)
-ENV_WRAPPER3(gen_fdiv, gen_helper_fdiv)
+ENV_WRAPPER3(gen_fmul, gen_helper_microblaze_fmul)
+ENV_WRAPPER3(gen_fdiv, gen_helper_microblaze_fdiv)
 ENV_WRAPPER3(gen_fcmp_un, gen_helper_fcmp_un)
 ENV_WRAPPER3(gen_fcmp_lt, gen_helper_fcmp_lt)
 ENV_WRAPPER3(gen_fcmp_eq, gen_helper_fcmp_eq)
@@ -447,7 +447,7 @@ DO_TYPEA_CFG(fcmp_ge, use_fpu, true, gen_fcmp_ge)
 
 ENV_WRAPPER2(gen_flt, gen_helper_flt)
 ENV_WRAPPER2(gen_fint, gen_helper_fint)
-ENV_WRAPPER2(gen_fsqrt, gen_helper_fsqrt)
+ENV_WRAPPER2(gen_fsqrt, gen_helper_microblaze_fsqrt)
 
 DO_TYPEA0_CFG(flt, use_fpu >= 2, true, gen_flt)
 DO_TYPEA0_CFG(fint, use_fpu >= 2, true, gen_fint)
-- 
2.43.0


