Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F27B606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 16:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EvqXjpCh;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=axQc4zj+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKegQ-000111-Aa; Sat, 24 Oct 2026 12:33:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKegO-00010o-CC
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 12:33:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKegM-0002PU-Jc
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 12:33:24 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69OF01PA838863
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 16:33:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hCrtvzRK9YJRjPadXJD+oOEDKIv0UzUUZPsGo/LJDCQ=; b=EvqXjpCh7c7vr7SF
 fgqb3kirBj/ObP8z4w5X/qAcROlyLr7WO4YpdB8YZtY55XgDhtXIcrekOCKYRr6Q
 ETEy/aMqC+MIoiqoEz50lMx3dfEFyGlJTxqZ1xcSFrso9w1Nt26jF/QMC5FlA8af
 WnONSZZkhBjxikR7wMQlItxIaCBhVFOqPyUgn4+E4BPfgNbBxF2ijg99dvhu0j0L
 Aj1IlozRvmQGPhmTFEBr+vAAvthuccNLreQQ/wT6pMFN+kPx6YVeLITdJysYJqK6
 pjN4DhxPAjuEMU9F1KoY/9jI7Zlt3fyx/vMcQY2Ba5QjDSwFbCpZqU5sHHZAVlQd
 NwoJFw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgn27saj2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 16:33:21 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ab926c236aso1749059a91.0
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 09:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792859601; x=1793464401; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hCrtvzRK9YJRjPadXJD+oOEDKIv0UzUUZPsGo/LJDCQ=;
 b=axQc4zj+CW/QQ2xTm8h9xAviIwcyPDFJvlh1V3foDMGi886hBwR/Fwoh9yVTyPcQPy
 K8TtwqX9zFl2BgPXBeWfaNR941weZCzyypEQ+xnf8KYKwwLELn7jODHqSV7Y21Qtqskh
 3upL/pI/HaR/QsDceTUC9z+QWz8NQxnfcronad8g3vhH6vMbYCDPeqV9uHSGYCWK5043
 bB2DTHfFmzqH3nk4Cq4OSoPkyWPTRmkJ68BWF5B2sn7yLaem1V+pr/LJ28PrkOiBDkfh
 KfybS6XV9L0f1l2E01KLsESoG/K4jqGmdt6ohEweUKTQ2vI9RgE+q7bIjowxgtpysIkq
 ssMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792859601; x=1793464401;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hCrtvzRK9YJRjPadXJD+oOEDKIv0UzUUZPsGo/LJDCQ=;
 b=AJhrsGZXq9SInkixtO+4ytd2/FU7jGszRjEVl42kW48XBOyO0H2KjubFHjSJf49zF1
 4Z6SLcFVhvfWv6Y0xixXNAdC2V3cszP9HF2IpZVDUUsrJX2D3f2LcJh3ph8gWh4jymbT
 CcNhGc95PBDNLWUB5yiKQ3+fgKv9XegMKNaybNHJxDBlrf9iFlWdXYMw1A5Z7S9qZ5fF
 GJUIKkWj5DgV9gdCCY/cMDi+2tSJ+s8Pbtj32OtE+EYIgS0svlmxj92fnGSZcZVeL99O
 /hi1zc3tpIbwy80gpsBE0DjTBD5ZsTbJadqp5kYl4kzPrdur7uW57VTW/xllL8HO7NmV
 TOXw==
X-Gm-Message-State: AFq9FYJiLFjCBP1NYeqsvZAo5LtKU/tZG/BhytvfWOMnsINmQPCwoDY/
 mLCTzhAMzmFybq30nlEhimWYVr+gAXSxevb68oWsMGcqvHnH3yzeYg/AcTxpYcg8MH6f7dEnmtc
 +5yS3kKo9gTDbzOHPOWioF1bMnPclAicUSAay7UmF4TE5fK4fkFz1C1SyAPJ5WZvaOg==
X-Gm-Gg: AYBFou3+NGjTr1L+MgZjpmIx62RN3fa0ISok3rSl0g4KGVufUkEg34qDIVjpq8crDCP
 1cCsrRXzT/bkJEjAcU9zlQuF2P3ZLY9rgGGo9PTTof3Ui5yGv2BgCEd7D/mSjyGvZK5SWxOYmep
 jD6iM/lhDty3OenevF0SlN1GP0le1pfsp7ERQ4KIwceJq/mLv/GUCPc3WLIw2cvp7sh9Iah3k4G
 WDCbOoA/EUsekA0maWYwayuKWeWuMOFaaf76xrnnEZeskv5bob7ACj9+MqQdCgcgQWc8CuIX3rR
 kQu788WzW3eLhwY8kfBo4P08r/0kXoXmaAyER8CxrMcUQXNo9j4koBiNfgjYDgNROE4jCipgYSa
 MFcUaM8iTpHjqGuZ0JEbNhuBc+HadJxwYvhkLgQh3jycWTd/q+21tMrDMe5AHI8c=
X-Received: by 2002:a17:90b:5647:b0:3a5:1b:34a5 with SMTP id
 98e67ed59e1d1-3adeafcf067mr2365825a91.49.1792859600489; 
 Sat, 24 Oct 2026 09:33:20 -0700 (PDT)
X-Received: by 2002:a17:90b:5647:b0:3a5:1b:34a5 with SMTP id
 98e67ed59e1d1-3adeafcf067mr2365811a91.49.1792859600039; 
 Sat, 24 Oct 2026 09:33:20 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebad93c5sm1932270a91.2.2026.10.24.09.33.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 09:33:19 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yonggang Luo <luoyonggang@gmail.com>
Subject: [PATCH v2 10/11] target/rx: remove explicit target specific prefix
Date: Sat, 24 Oct 2026 16:32:48 +0000
Message-ID: <20261024163249.77855-11-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024163249.77855-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261024163249.77855-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=G7GJgNk5 c=1 sm=1 tr=0 ts=6adcddd1 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=xJBkFjxltbiK57tzlAwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: GCx8OaGXH3GIyPF7IxY8hvfZl4_XspNx
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA2NSBTYWx0ZWRfX4DweGhVhbvz3
 y3opars0kvBraNiX1i9F5ih8IhUYbDXgI25HrHmelEkSMryhBtuB5est9fZmrosX/Qc7jtWDsAS
 NW3c7eS4Q7Cf4mr77NIeTchdLSQTqEI=
X-Proofpoint-GUID: GCx8OaGXH3GIyPF7IxY8hvfZl4_XspNx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA2NSBTYWx0ZWRfX9tg2+k06yO5i
 QiTbjS3zRCKETzmUVLAegM37VD3XXtdiLDak4GHXWKOZW2XMoZyoK7QQzxlh3RMuobzdiXUqPdr
 UmeN7ecNk3N370H1r7TMOMttjE5P2oTRtVJiJoMlgji8v97AorrtoW+EjZEuqgw10IFcq9R+YR8
 uMJmS/+KRcmv0xYFWnhdcnUkzdk6vVFQuyANxmTfUrKAiSTCk5GBITT1pxwOMQpJqXz3AqhBmjk
 EtiaY8yRxRTgY5K8NHAP2YvZq1Mv9Xs5zUB+2ncyFw05iX6uVxVpP/WyuhUKkO3A4sLbmLRNlLK
 SVGMNekh3RemjW2Cwmq8gn3VGZRA1dA/fqHvgN95SIl2oLOYPs3ZVbGPQyqCeruwFfHqRLQGnp/
 wIEfqF5IeKV26tbTcLu6akXqf6vX7UQUYDrBS9V+BjEZFojrMdR1rfrRkpkQ0SVg57b0UugINw7
 3jlHIisEoHxYqUwNVxg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610240065
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

Acked-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/rx/helper.h    | 12 ++++++------
 target/rx/op_helper.c | 12 ++++++------
 target/rx/translate.c | 14 +++++++-------
 3 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/target/rx/helper.h b/target/rx/helper.h
index 13f019ff81a..f3897ce7619 100644
--- a/target/rx/helper.h
+++ b/target/rx/helper.h
@@ -3,11 +3,11 @@ DEF_HELPER_1(raise_access_fault, noreturn, env)
 DEF_HELPER_1(raise_privilege_violation, noreturn, env)
 DEF_HELPER_1(wait, noreturn, env)
 DEF_HELPER_2(trap, noreturn, env, i32)
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
@@ -17,7 +17,7 @@ DEF_HELPER_2(set_psw_rte, void, env, i32)
 DEF_HELPER_2(set_psw, void, env, i32)
 DEF_HELPER_1(pack_psw, i32, env)
 DEF_HELPER_3(div, i32, env, i32, i32)
-DEF_HELPER_3(rx_divu, i32, env, i32, i32)
+DEF_HELPER_3(divu, i32, env, i32, i32)
 DEF_HELPER_1(scmpu, void, env)
 DEF_HELPER_1(smovu, void, env)
 DEF_HELPER_1(smovf, void, env)
diff --git a/target/rx/op_helper.c b/target/rx/op_helper.c
index 5f4f0a14027..1281d69c461 100644
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
index a350f6b4d26..1bacc7adf92 100644
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


