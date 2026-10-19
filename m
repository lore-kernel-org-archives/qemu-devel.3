Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C78606A319
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LnJOnbvN;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PulEvbAy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIunn-0001md-2W; Mon, 19 Oct 2026 17:21:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIunf-0001jg-3Z
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:21:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIund-0005jg-EP
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:21:42 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJKApi3475832
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:21:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ipf+aq3F7C6
 N+LCBCaFvJBvcalsrKT5o5FtaKJXNHKA=; b=LnJOnbvNB35fOltVp6YioNPhlQV
 TAPBT1gdPheTW15UOxWBawS2fwWBA1pqBEtr0Kw+SyZAlR9pRZ/z1GIydZs7xPTA
 l0UWpvMxcHdvBgTxBWiYPmgDfmBMLVgcOLqjHXENlSFShZPuMeYX3nIjGVadZzLK
 DxJz2oUGN03ihq0p3l+UUvjkjQfQmh0LTOznQRwyr+bGlbPOSfpgUTQW6zpLwUaq
 g4X2I080DHCgL7F1Fw14XLYf4MvsocHR6VnOkOCA3mB3EmRzpW/oqVJHBVUPUVoo
 nG1hxQwo4Hk0odnR1hB2QyjSMHDTGuEQBgdSnvTbRudu/HUVQ0p/ZV5GVdA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdqtf8syu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:21:29 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3aaee1fc104so3911119a91.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792444889; x=1793049689; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ipf+aq3F7C6N+LCBCaFvJBvcalsrKT5o5FtaKJXNHKA=;
 b=PulEvbAyZms8ZFQnKWY+8OoSJeUL3G1bxTePN7jdSvd7DAvL77gCta95B32zwToJu+
 /7q0wd5ZN8qu3ITARqIXAm2DIEbfZL9S3G0fyB+vn08d7t0P7ubfOI6cjaLd+x1cSFVH
 t0mHZ3DnZFdf7hya7MAvD9CPAwx1ktJTmyhbGtptTbAETWuIldbi5SwpWI0r/ibqiAni
 edE6Ki3DnxedKHiykbKLyQzMUyyLK7WizALWLwQ7LxRNalCAECiVzNTgC5dRQu4aiobc
 LE5dLtNe9BmQT3s8CxoejubENSc4ioQlx6CmCaKTbuaN/TyDElW6VI0N9QhKTDr8rSdf
 iBQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792444889; x=1793049689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ipf+aq3F7C6N+LCBCaFvJBvcalsrKT5o5FtaKJXNHKA=;
 b=Nx1hRAn+VlQo13JJi0vA5qnREZwEgH0et460orwjfjeDs6tm4h+Ul0FboLuhdKuzCe
 yFzjERGh6Y4IUU3NNBglK5aIYFATqxJRtPW7isUqjpCDcyjloapCDu5pGi9jDrNHzV1g
 0zzR5liUeNSZnbvKlmfQti+Mjt+sjl71ABryEDa7uNgIvhxyOr+tD645PX2tskiS1FrE
 w8lbm5EVkjL4zDhx1KyQr4g7oJ1qrVFcqjpDUT6BdX0kRQHaU7NSnqEJa5SQrxPQedFH
 UsuFtYURq8x8PM3JcydaKvw7gajL1ATzuL/O8gHV7j6W/C1HErUeSGp0k8+yBSUQsmQt
 Hz4w==
X-Gm-Message-State: AFq9FYI5vVsJuYCrBDXfnYCNctAxkvwEwjCrp2ywmCek9cX87Nikzoju
 EiM9k/xATlmv2l55Ruc2RA4x0NHu+oV0ssLWC26COc/WGQp6Vrn+bmKAdVYQQpzzffHZlvFuivQ
 a2vZTkxg2YjZK72uS05Eqb+LIXyyprz2bKK9kdSGdwZDAQDJhXsSefbUOZUZJpwmvag==
X-Gm-Gg: AYBFou3OkADO29GGMkyC+mQ4WzkGnJJoaw0s1I9KdCIwzIc2efjOLSeNGdYS25elbgH
 7biB0REC6IQtNgSYPxCbRTU14TaYmSWbijOBEznIGhfy7mLP08CoKvtj1UaMYjPYrMtLhwDyAII
 k9usm8sDu58GlfrJrFR9DyKWOGNHNUerv9vt3fsnHpjFmbFz0/A16RGB7NK1mwA+UrS3XL3eAaC
 smKw1am9ISi9XTE8BOiPcOH1zBPqo0l5BakOVmhPGE5ZVrkGKytG91KOUyoo7lP0XnoEwP2/Wsw
 E6lpmXrD0b4WufjZKHHiX7tPc2ksJAVQvsrOxl4lfLoSHY0n7s2sRbV/0vfRiI4MOp3m4wJjsSC
 OKcaOA+B+hg2YnORLz/Kq1EOwYmW3jijUJwq768h7cQScFseotg8Y2IANwyRUEO0=
X-Received: by 2002:a17:90b:2646:b0:3ac:9d14:fe9f with SMTP id
 98e67ed59e1d1-3acef29e804mr7216151a91.31.1792444888611; 
 Mon, 19 Oct 2026 14:21:28 -0700 (PDT)
X-Received: by 2002:a17:90b:2646:b0:3ac:9d14:fe9f with SMTP id
 98e67ed59e1d1-3acef29e804mr7216138a91.31.1792444888102; 
 Mon, 19 Oct 2026 14:21:28 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad60ec4457sm863243a91.6.2026.10.19.14.21.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 14:21:27 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 25/26] target/rx: remove explicit target specific prefix
Date: Mon, 19 Oct 2026 21:20:44 +0000
Message-ID: <20261019212046.149572-26-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=SpEFe/O0 c=1 sm=1 tr=0 ts=6ad689d9 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=xJBkFjxltbiK57tzlAwA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX5B1bqWChZzvO
 9bALFRzP9mq9XM6E/ON8jxxLXcVg5nLE+iEB0+cCDn0CmSu0ummEAeIumB4npEg6q0q6Hje8gmJ
 Wd27sFAH2VhuJzCq4zPAfUH3FbQWmikS6DpQ24kEpoK/Z5h2iIpk8YXyPK3ARqFKReTw/EfOZau
 dFrBtYat0Mjlsiof0kfqML24EhJudFMFSLRtNmWWLC3UHhLdy9s37prImBRC3KFf+Ul5FXUbumL
 y1Zfj4O96w+hpjaGVthxJtJZeRsP+DRct9WNxb83I0o3VoQ9YD9EoM5GtQnMhcRTUhEgNoSp4si
 9uRdPYXAcMz9Ysm+FAhjUbhehz8rEwda1w0OSy4xJgb+ULZrmQjwY91fSXDEdYuN5spU5rYnwd/
 ivXuueT1LatHQjVlgYf5s3ib0zOsH3spD+QVgs1sJOM2fgiwoL7DYm6Hz66O1tXM4s1jUKsOPuq
 poK0kxoewF28zuTU/Cg==
X-Proofpoint-GUID: C9gPmV_kLgaaxpqzk1atnTLiJw54M9Xa
X-Proofpoint-ORIG-GUID: C9gPmV_kLgaaxpqzk1atnTLiJw54M9Xa
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX6RRQfs5u7f06
 PSf6NbsSynvsf7xCaxNap+syGyDhJ+IJ80IQoob8Lqrc+QmOghZr3vDBJp003j6Tnl+bpv1+OnX
 kDsjlv52tHwFW4hxj+pHGIa1twCSVRI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190085
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

Now that we have a generic mechanism to prefix all helpers, we can undo the
recent changes that fixed conflicts between targets in multi-target set.

This reverts commit 5490e0e4a5dcada1aabfc7df772ddee54f9022c5
"target/rx: prefix helpers conflicting with other arch"

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/rx/helper.h    | 12 ++++++------
 target/rx/op_helper.c | 12 ++++++------
 target/rx/translate.c | 14 +++++++-------
 3 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/target/rx/helper.h b/target/rx/helper.h
index b1ef843be1e..8cc38b0cb71 100644
--- a/target/rx/helper.h
+++ b/target/rx/helper.h
@@ -4,11 +4,11 @@ DEF_HELPER_1(raise_privilege_violation, noreturn, env)
 DEF_HELPER_1(wait, noreturn, env)
 DEF_HELPER_2(rxint, noreturn, env, i32)
 DEF_HELPER_1(rxbrk, noreturn, env)
-DEF_HELPER_3(rx_fadd, f32, env, f32, f32)
-DEF_HELPER_3(rx_fsub, f32, env, f32, f32)
-DEF_HELPER_3(rx_fmul, f32, env, f32, f32)
-DEF_HELPER_3(rx_fdiv, f32, env, f32, f32)
-DEF_HELPER_3(rx_fcmp, void, env, f32, f32)
+DEF_HELPER_3(fadd, f32, env, f32, f32)
+DEF_HELPER_3(fsub, f32, env, f32, f32)
+DEF_HELPER_3(fmul, f32, env, f32, f32)
+DEF_HELPER_3(fdiv, f32, env, f32, f32)
+DEF_HELPER_3(fcmp, void, env, f32, f32)
 DEF_HELPER_2(ftoi, i32, env, f32)
 DEF_HELPER_2(round, i32, env, f32)
 DEF_HELPER_2(itof, f32, env, i32)
@@ -18,7 +18,7 @@ DEF_HELPER_2(set_psw_rte, void, env, i32)
 DEF_HELPER_2(set_psw, void, env, i32)
 DEF_HELPER_1(pack_psw, i32, env)
 DEF_HELPER_3(div, i32, env, i32, i32)
-DEF_HELPER_3(rx_divu, i32, env, i32, i32)
+DEF_HELPER_3(divu, i32, env, i32, i32)
 DEF_HELPER_1(scmpu, void, env)
 DEF_HELPER_1(smovu, void, env)
 DEF_HELPER_1(smovf, void, env)
diff --git a/target/rx/op_helper.c b/target/rx/op_helper.c
index 3c64014db6d..60976aa965e 100644
--- a/target/rx/op_helper.c
+++ b/target/rx/op_helper.c
@@ -147,12 +147,12 @@ void HELPER(set_fpsw)(CPURXState *env, uint32_t val)
         return ret;                                                 \
     }
 
-FLOATOP(rx_fadd, float32_add)
-FLOATOP(rx_fsub, float32_sub)
-FLOATOP(rx_fmul, float32_mul)
-FLOATOP(rx_fdiv, float32_div)
+FLOATOP(fadd, float32_add)
+FLOATOP(fsub, float32_sub)
+FLOATOP(fmul, float32_mul)
+FLOATOP(fdiv, float32_div)
 
-void HELPER(rx_fcmp)(CPURXState *env, float32 t0, float32 t1)
+void HELPER(fcmp)(CPURXState *env, float32 t0, float32 t1)
 {
     int st;
     st = float32_compare(t0, t1, &env->fp_status);
@@ -407,7 +407,7 @@ uint32_t HELPER(div)(CPURXState *env, uint32_t num, uint32_t den)
     return ret;
 }
 
-uint32_t HELPER(rx_divu)(CPURXState *env, uint32_t num, uint32_t den)
+uint32_t HELPER(divu)(CPURXState *env, uint32_t num, uint32_t den)
 {
     uint32_t ret = num;
     if (den != 0) {
diff --git a/target/rx/translate.c b/target/rx/translate.c
index bd445bc0634..132d495710c 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -1252,7 +1252,7 @@ static void rx_div(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 
 static void rx_divu(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    gen_helper_rx_divu(ret, tcg_env, arg1, arg2);
+    gen_helper_divu(ret, tcg_env, arg1, arg2);
 }
 
 /* div #imm, rd */
@@ -1864,16 +1864,16 @@ static bool trans_SATR(DisasContext *ctx, arg_SATR *a)
         return true;                                            \
     }
 
-FOP(FADD, rx_fadd)
-FOP(FSUB, rx_fsub)
-FOP(FMUL, rx_fmul)
-FOP(FDIV, rx_fdiv)
+FOP(FADD, fadd)
+FOP(FSUB, fsub)
+FOP(FMUL, fmul)
+FOP(FDIV, fdiv)
 
 /* fcmp #imm, rd */
 static bool trans_FCMP_ir(DisasContext *ctx, arg_FCMP_ir * a)
 {
     TCGv_i32 imm = tcg_constant_i32(li(ctx, 0));
-    gen_helper_rx_fcmp(tcg_env, cpu_regs[a->rd], imm);
+    gen_helper_fcmp(tcg_env, cpu_regs[a->rd], imm);
     return true;
 }
 
@@ -1884,7 +1884,7 @@ static bool trans_FCMP_mr(DisasContext *ctx, arg_FCMP_mr *a)
     TCGv_i32 val, mem;
     mem = tcg_temp_new_i32();
     val = rx_load_source(ctx, mem, a->ld, MO_32, a->rs);
-    gen_helper_rx_fcmp(tcg_env, cpu_regs[a->rd], val);
+    gen_helper_fcmp(tcg_env, cpu_regs[a->rd], val);
     return true;
 }
 
-- 
2.43.0


