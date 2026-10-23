Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC1C606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GASTqxY/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jZERmFfk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHyt-0005vu-Jl; Fri, 23 Oct 2026 12:18:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHyn-0005Sg-QC
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:18:54 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHyl-0002dO-Hq
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:18:53 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE5xlI2109294
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:18:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gmaXSipMzcOAho28yq0eKwdCXZAQ22Ci15FanxjsLr4=; b=GASTqxY/KeE7HsWz
 Xqc76MrE9Aec+JnD+wV1oyZKn/ZERv+Mw5qdyF/590cODgLeUR3YRFidjcKokci+
 6eABULvHT3KHrpunPbtgjRGYB2mz5QiztBSSWwSVtzejz5W3p/FswvNNGzP5AL5d
 JRtSIt5+RBjsEQVhZVk+B94FOJnEDSjbwAv1w2udRparIfIwPbSfYAr2KYkZYLfb
 dOcmAr4avfh9pougXkv/D0tt8yVHNxAEMFI0nwp12Wwr+z1+ndOJU+JaL8DvHJvL
 o5aJTtEwGMptnxagYDxYuRzW6z/LmKrE5RNV+JLH+rG7Qzw+OTaTu0PS3zEONaXh
 ug0T1g==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqms4gp3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:18:47 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91b7e7d5f56so26983496d6.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772327; x=1793377127; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gmaXSipMzcOAho28yq0eKwdCXZAQ22Ci15FanxjsLr4=;
 b=jZERmFfkG9QFwwUDMIGwIr4GMoJde9Xl8ClDetvdjraKalxTUq/qrEKCv08+kfgI0u
 lQ7rzfEa6bRP8xb3a1dLcS9yIP2dr6TmsCUTaT5Wy7VXiAQU5DyFrzC7CcOGaVnGoXtn
 Je2qD2LvWMq8F+FChZS1WzGCi+KzFOFkqjnZDFP4OuX9n7ZpvkjnNW07ge5nsquCuI9B
 rTiH/axfHYRgw2h/02auwRqRxfj9XZJKCtMhkspLkJdVN60j2kx8PQNcmEIhrIvCrao6
 DLvMfbq38nRtceDCqTtQZxLQuTV+ya7CGXY5CTG6mYMPat9a+HZROsnrdN0g6ixmX0gi
 q4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772327; x=1793377127;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gmaXSipMzcOAho28yq0eKwdCXZAQ22Ci15FanxjsLr4=;
 b=yDuYbXgjy61crli2gPbBog60qr3AXlb35B8FA3vSQL/IO24Q7KfssqmcOabO+ghUU+
 JtIPfKuCOjjmDzoSk0lUDH7ItwsbHzuNqwOlpgp5IqMqDOPXfvGMIWTgxSanjBdEGX9j
 TQ8lgRdoygqImOMN9LoL7vDLUslEOwb9ldKcsmwPY1CVMSb+VqSNeV837MDJHSqM+iSe
 TI7bPrAFr9il6q7tDPVciojmh6YKB99WEEbEZtwqQ56zvmdYqMs8Pyqr5h79JDSbUo9+
 VpUhdOPmCyc8WsRr3SYvUglGVdMIj3XCTH8uctaiMRnMlrvOkPP53HhNZsOMoJsEoyYA
 TfzA==
X-Gm-Message-State: AFq9FYLCgbJaoCNNdu1dZbGpCYEtb5KK0X57leZjY9hmsbgztf8asa8w
 bGuqmaI/iBc4HC6uMUwpcW6mD8pejLQ69fvLBEXQMFAmkzpUevNKXzFAujbgxJCx3WGUlQgrJXa
 qtY9eOs+BumgoXP3xLRvgV1tISgWyp7jzZoKqqzdR+9GnHxlFu/rPmitXKc8vjX++sMWi
X-Gm-Gg: AYBFou2AzN4qydnVhwywNngq+J5xfbTLaL9XtkHRbgsoGQU4dsTGb/8Qkl7NMADirR3
 7CWACZ8l+QcdJEvkyAD/WzwJfeG86r9+PqtMgWph6OuJYoVGRpyLIeo2zLo+M3BcLnPxPqK+2Yx
 TQvIYza6Oyf7oKPrh+Dy09FSmCROzEfJjCvs6AzapbGC8F1HZAPqKbq0dbvMtp7G4IGK6s1wWqu
 6XCNI2lklTnDjukD5fidoswDJrIhAC1xuzmcQtsJ4aJt8Xnd4oL9Es184Jfn9mxxpgRCyzpT1Ni
 2eHdLtB6L2zjFKVoK6yNHcBqoDqBDwt2X7/RLCTSQB33AwA0eQdusNdKEvwnjLm1Gqnx1rgto1R
 e9tMwZSxIlnnW0oBXrXaJs+xVVgzecCk58W94aiej
X-Received: by 2002:a05:620a:1d09:b0:93e:d364:ca10 with SMTP id
 af79cd13be357-93f6f570973mr497623985a.12.1792772326935; 
 Fri, 23 Oct 2026 09:18:46 -0700 (PDT)
X-Received: by 2002:a05:620a:1d09:b0:93e:d364:ca10 with SMTP id
 af79cd13be357-93f6f570973mr497619285a.12.1792772326323; 
 Fri, 23 Oct 2026 09:18:46 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d405cc0sm715933f8f.30.2026.10.23.09.18.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:18:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 43/83] target/rx: Unify BRK and INT trap handling
Date: Fri, 23 Oct 2026 18:12:51 +0200
Message-ID: <20261023161332.60153-44-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX9ig2jdGhzWFo
 4vg8+7B503pcCQxdGqjj+hMzbVY8WOhYqWCyHEa5BSPpDXi5XR4VCRvGI+2Qb0WFVp3CABqmrk3
 4pL7Mhmh4JomeoK4Wjg5NYDkWwxp/sIn/YzwMvuuhkD/FvieC+eRrzrQNa1C5zIJtFK2M2Qphqz
 xTidtBRtJrxbsjb+wmVFO4JZeI8Sw0qQCSQ2zYK0IM6/kxOEsgn3BqAz1GEmfMk+KfvSM5eSBJV
 t2S50vVmzXiT7iyJco1kIMmY2YHt89aUqXq0Z2lHQPJBqZxV6bvJEX1x7v5STDxyWVNq5wpkt+V
 S0SAoLobMz4Tk4KE7xfdxpIJmYhKU0lUX8mB3MfvP+94L+gTXAz977TOdTgqutdvlF53lwfzXZE
 O6OY6oV3H/REzBDcwu8pBUBd3TIHqjrH9cN+eJVd804zMlTP0PnMS9faCQQXr+kpKr5xCW052cG
 bPYMQhYvcKVTwG9XKVA==
X-Proofpoint-GUID: sxx9BgOjxG2WVYH-642YKKsS-Na5QkjG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX0oGnd2AvXGdK
 PyY4tUPXtw0Dvr/BM2NkyNIvfeN0FVfLKOjiuS+AzmaDJ1X0rQ4H3wuWroypXlmQLSQM1LxpCiF
 0D0SiH2C/uRpnblXA0yWTjJpqFAWQVk=
X-Authority-Analysis: v=2.4 cv=UdbE26SN c=1 sm=1 tr=0 ts=6adb88e8 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=YEB5RgzmAAAA:8 a=jDMzgGwzCE0q-kHIl9cA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: sxx9BgOjxG2WVYH-642YKKsS-Na5QkjG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230063
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
Message-ID: <20261022215115.19680-25-philmd@oss.qualcomm.com>
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


