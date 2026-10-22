Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BA3606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=M9tcIWuO;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ahlk9cbs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0jy-0003eV-MY; Thu, 22 Oct 2026 17:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0js-0003Xl-Nx
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:54:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0jr-0007kq-2X
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:54:20 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MIH1Yq1509611
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:54:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WS9GBvpAE5aOkQ0P64201/OvgyT38KpzzMk50TKNYI0=; b=M9tcIWuOtmrvPN4J
 gYIi7gxcm8YQgLdMVHR7v8g7FEOMn6brbA3mU32tfNDUzG8fvxmWbOLPRZ2LTNcu
 rVupUOtUpgYj2/crdQPn1BbK3NR6trJSm990bXRko1DmLimmRRfqONA76OuKVWkg
 EXoK/ZPebn1sDB/NJANnvlsCvFmmune6/kEzz7onrh6APQc2zpqqd75J3mzrwL0Z
 h8JCA6JxILXqQTZ8YFXPQU7DHjuhhqMbdPfYL2+DUKJ+Ptu1rdCk38KvO5GYbpqe
 U5gkLOc3HFXAsOnWJ3faRE42rENpR+OxhGMf7Qdjin0ZbtLyiHtpLogY5K23E+aj
 s6jbJw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmp8qp9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:54:17 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5364f562140so5250101cf.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792706056; x=1793310856; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WS9GBvpAE5aOkQ0P64201/OvgyT38KpzzMk50TKNYI0=;
 b=ahlk9cbsFEMJr91pGzs3r+Uelo9oFYHxN98Kz7p99Edw0gwwtfRCuPQ3Cml07xcjds
 eMh7MV98ueEL+CXIBG+IaXqfpBpHmkHOLHOf6KQ49Qec5TtcqJXphQ/5dTN2IT7CdN44
 1VAq46lGs3T7NPoCs7guOgPApJGBQpvQ2NnECJzf0/AF0dBxmw2/kA4O0woltJrsmkDt
 2BioE6GR0q/qtVfWSv1aP6XLehmdObCoXo8lkfbisB0zqg9CkQ+3jemeP8nemv7hhzQj
 N+euV4nCydGZSRdwl5XDzZfwvWkRTzEdbZrzaDJQPspbiVv7iqyniu/gl/Nre9GST9MP
 m7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792706056; x=1793310856;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WS9GBvpAE5aOkQ0P64201/OvgyT38KpzzMk50TKNYI0=;
 b=fvvm7EDlmrge8YT16Q4NjSXZlswXwIhhQ/SPtwFxU5kALVcqgMKOpLe8jd++2Ht3Mf
 jkIfSQQ7Eyx/f1g5I6No55+Mn6S/05rXRp25TCR4a5iPVrG1+N4zgicQveKDvdZan9h/
 1dgSsCl/j7kwY6ieAWoCl8aAkX84kcSvg1MIxIqCbUfIbUK12eb6UL6T6+5O6p8X/E4w
 Rsn5Blq1uVEANZhnkGYhgm7/r3+NRahVPwyKB77pmZayVWiuzQOs/Gk11SGgJXPOm/SK
 mHpOrAcqSIzz1Yg1Ue3fZ613UV2aj1SkQ831fi3VbCto5SAinmah9aYofdDFVQ2ziWZp
 XQsw==
X-Gm-Message-State: AFq9FYLEBVnihTiqgzqsar25kMKHCN1CsQsBeyOWLf8kq8KfVHIW0GpE
 yDC9ABnuGQTFdapdUqWpuWCYf5xMmFwz5/PQeOFflHxnTkL54zbd4K9kk/bLcZ8j5HbqSO35BIF
 zZymj8aILVyYzXOg5RpvTzH7m7dv2PlZ2a+BKbPV9nxnnQ4R9kKTd2c461Rg7y6SD1g==
X-Gm-Gg: AYBFou1uqK62GNJ2PfoDWmtDh3ISVu7fgulDa54MXJP4P9+wkLBOB6m8ymZKkACSpvp
 kvnSbwS/BsJ8pwwG4sGLuQO7+3gjXU6+SUe3cTSCDfYDuM53KIAuDL02PFLRsOFw6LhA1sbjezj
 TZ/LVw3JvkM7hakK2V2h+3AwA9GTtVQhil5AadfvEyX3Ui6KRtwZYW2CxctFf25A4osNM3hNX3F
 qsD0vvI5cUBG86a7/1m90IiKSeTPS4DZH79ZMAByKMBExXw0huaAr8gD/e4URNB5YhtuobSDpma
 EyaJc4TmA1hblWtpw0SmDG19yZfytQ4uAMn4sPVZ5cT9nPePTbykOMNX6jV+KAny1SVW1Muus+0
 mfgQNtttsbZpsVRaBMMZrE+ON/uD//tqU4kS0/VMG
X-Received: by 2002:a05:622a:509:b0:536:48e4:680f with SMTP id
 d75a77b69052e-536c2952d99mr2573111cf.30.1792706056421; 
 Thu, 22 Oct 2026 14:54:16 -0700 (PDT)
X-Received: by 2002:a05:622a:509:b0:536:48e4:680f with SMTP id
 d75a77b69052e-536c2952d99mr2572801cf.30.1792706055876; 
 Thu, 22 Oct 2026 14:54:15 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a211f83dd5sm4691965e9.0.2026.10.22.14.54.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Oct 2026 14:54:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>
Subject: [PATCH v3 24/33] target/rx: Unify BRK and INT trap handling
Date: Thu, 22 Oct 2026 23:51:04 +0200
Message-ID: <20261022215115.19680-25-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022215115.19680-1-philmd@oss.qualcomm.com>
References: <20261022215115.19680-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX788m2SiUKlht
 urNunTf3V+cHpKj/fu3Qif5lCi3npsHD3gcdF63qGnTuxg/iSx6x7VPfCxc3jTN3ZPB8v63zViO
 Sx2c4ldKZWe2U1dx4KfLnYZcSvFNbTQ=
X-Proofpoint-GUID: l_MJWy3pWpBSdqz7RoeXify6MKZ6csnW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfXz73vuCt3pqob
 b0YPLz3XPWqiKesotWU/AgXuVJykGh68F71i9HkLcpu6+ZCt+SED6gA63fae8PV1oCYOix75bbp
 rmBkJJVTj+GLWix4xnVbm0cR6wkHyrT3D7kUiDH99iGh0tELo+aPvC82vfF+MdrqeOo4M876/sZ
 oqznpAdPdYdIHbvasYWz9WMXNKyDhemOd6RNzk3tkUhuGOighLGcfKHYjqz54lfLOIrH5wQl4MF
 ODUPGYfgQPIxZt9mNigyNiY8W8+yCb+rOCz9BK/evh05qSn3hnMk7PbVTBbbt7gMv3VHpABphwl
 p+vtfqYpwEJVnnxBPvyVNU7Ph9OlRP3aUEznS6H5fstA1aP4m9WoLmmfJWdmjt9653UVTgXjAzT
 PsA1z+ag6AlW8FaDwOU4jx1yeSiU8cPr6Lyk8vbyEcOoOpr+ruNJgYLMefvarkckeiJf9QQfgez
 l6XCj300J3hDsGhl6sQ==
X-Proofpoint-ORIG-GUID: l_MJWy3pWpBSdqz7RoeXify6MKZ6csnW
X-Authority-Analysis: v=2.4 cv=BdBNQbt2 c=1 sm=1 tr=0 ts=6ada8609 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=YEB5RgzmAAAA:8 a=jDMzgGwzCE0q-kHIl9cA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220087
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

BRK is equivalent to INT #0, so route both instructions
through the same trap helper.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Yoshinori Sato <yoshinori.sato@nifty.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/rx/helper.h    |  3 +--
 target/rx/op_helper.c |  7 +------
 target/rx/translate.c | 21 ++++++++++-----------
 3 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/target/rx/helper.h b/target/rx/helper.h
index b1ef843be1e..13f019ff81a 100644
--- a/target/rx/helper.h
+++ b/target/rx/helper.h
@@ -2,8 +2,7 @@ DEF_HELPER_1(raise_illegal_instruction, noreturn, env)
 DEF_HELPER_1(raise_access_fault, noreturn, env)
 DEF_HELPER_1(raise_privilege_violation, noreturn, env)
 DEF_HELPER_1(wait, noreturn, env)
-DEF_HELPER_2(rxint, noreturn, env, i32)
-DEF_HELPER_1(rxbrk, noreturn, env)
+DEF_HELPER_2(trap, noreturn, env, i32)
 DEF_HELPER_3(rx_fadd, f32, env, f32, f32)
 DEF_HELPER_3(rx_fsub, f32, env, f32, f32)
 DEF_HELPER_3(rx_fmul, f32, env, f32, f32)
diff --git a/target/rx/op_helper.c b/target/rx/op_helper.c
index 5a7a87943fe..fb1fa4ffa69 100644
--- a/target/rx/op_helper.c
+++ b/target/rx/op_helper.c
@@ -455,12 +455,7 @@ G_NORETURN void helper_wait(CPURXState *env)
     raise_exception(env, EXCP_HLT, 0);
 }
 
-G_NORETURN void helper_rxint(CPURXState *env, uint32_t vec)
+G_NORETURN void helper_trap(CPURXState *env, uint32_t vec)
 {
     raise_exception(env, 0x100 + vec, 0);
 }
-
-G_NORETURN void helper_rxbrk(CPURXState *env)
-{
-    raise_exception(env, 0x100, 0);
-}
diff --git a/target/rx/translate.c b/target/rx/translate.c
index bd445bc0634..0672c5c5653 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -2170,26 +2170,25 @@ static bool trans_RTE(DisasContext *ctx, arg_RTE *a)
     return true;
 }
 
+static bool do_trap(DisasContext *ctx, uint8_t vec)
+{
+    tcg_gen_movi_i32(cpu_pc, ctx->base.pc_next);
+    gen_helper_trap(tcg_env, tcg_constant_i32(vec));
+    ctx->base.is_jmp = DISAS_NORETURN;
+    return true;
+}
+
 /* brk */
 static bool trans_BRK(DisasContext *ctx, arg_BRK *a)
 {
-    tcg_gen_movi_i32(cpu_pc, ctx->base.pc_next);
-    gen_helper_rxbrk(tcg_env);
-    ctx->base.is_jmp = DISAS_NORETURN;
-    return true;
+    return do_trap(ctx, 0);
 }
 
 /* int #imm */
 static bool trans_INT(DisasContext *ctx, arg_INT *a)
 {
-    TCGv_i32 vec;
-
     tcg_debug_assert(a->imm < 0x100);
-    vec = tcg_constant_i32(a->imm);
-    tcg_gen_movi_i32(cpu_pc, ctx->base.pc_next);
-    gen_helper_rxint(tcg_env, vec);
-    ctx->base.is_jmp = DISAS_NORETURN;
-    return true;
+    return do_trap(ctx, a->imm);
 }
 
 /* wait */
-- 
2.55.0


