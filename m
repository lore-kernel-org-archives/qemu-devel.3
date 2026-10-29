Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5063B606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 15:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Yxjif2tN;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cRCFfyjM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMRpG-0004yp-9E; Thu, 29 Oct 2026 11:13:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMRp0-0004wS-HE
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 11:13:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMRoy-0002yH-AG
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 11:13:41 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TCeWVL120287
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 15:13:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 10yc5qhRFxrDi8Aw6pkQwuyDjRz0WOyaTZSKASo9m3s=; b=Yxjif2tNZEDho0Bm
 ZwlR2P9be5gyLJqQ9Its/HG3+ne88ithkA3SYOmC2AFsYcwyQc7gpkTGBIR7PWdq
 sAl8kC4q2SaEGpolDnYRi3qkWdqd2KCpZMlgWE8cdFaWTv402pJSJXzbANzc8Ce+
 XT7vVfcIO7hedfJSyBfjcYzke4f16kuDtF8DZNlAgAsuMllkTJ1hcijM17pfgy9i
 L94qWdyM243auHS5lgTjoSh3EWt3HD0Gr1iUYVDZZbaJ7HKe8i4j4qg2hAiO4nNr
 fUOyTqjmXX8Jy7WgfbaH04UNtaH720vDsQBe9Mx72nEs1pK+28AdnCd7oqY5T7Gk
 rcfE1w==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkut3k017-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 15:13:38 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-98a829c43f3so520560241.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 08:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793286817; x=1793891617; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=10yc5qhRFxrDi8Aw6pkQwuyDjRz0WOyaTZSKASo9m3s=;
 b=cRCFfyjMvwX37wgzgUqlqRCniQaPSEP8rqWPG38aL7TakswLfmTQa4fna2YiQ7bUy8
 ienhXTj0o1bh3cqXpDhUL+2KoidjxQSVqQ9xMpVCKP2x/rOhNPzYtGhIUCpUk+UzsnOh
 8fmlNryhf6LReiiyYxRg2wcK7cG8mR7nnvgRJPlD29P1/ZMPtZoeGzFcjSySEFxuZACb
 tRkNFMN5FiaRHVZK6AA0XMC/T5l9IV+CYmPLLCzm5S0RTBQk4xRCQMy3rzZImt9A9G5T
 24h59LGRok7e6qBjE92IeBFQcTSt7M4VJVYQdZJdbbtrPdGsJYg5GsN26kh7JFf07L45
 YchQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793286817; x=1793891617;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=10yc5qhRFxrDi8Aw6pkQwuyDjRz0WOyaTZSKASo9m3s=;
 b=GFnRSlpWR8CYMgFB2E5aYe2+ZR/ymKV6DLCIRIJ6KV5B4Lsr5zOwcft0Hct5w0xwHb
 mJW+mXutd6yIX41UJbyM5fghMnPeb8xlok74k5B9p0O5H6HfMAqidVZiYdc6p+A0slMi
 R3vg2SkcWewsLdfJFb1qXpbSE3kQYAu7QdbmRqa99A41hKF+eZYEG3p0qiWHaNYVGtM8
 /RV2/zTJ6uSkttK5uwfIrGKl77cDJiVaTp1CbXZN+xKZF+FvFNjIJDUtIC5jabT/qYGl
 ok0hXQA4rQ3efPUbKfd9J0JqFuuJe0af37LQThbguW3vwe55wDRITyN+NDNRuido3Mfm
 S6vw==
X-Gm-Message-State: AFq9FYIZwTjlcSUOyP44NN11H3LfhAlsrHcLGKxjFTmZooivx8kHWCLA
 VUq2rw1ITcGEiGzaxhiEZEH7qT2AsmD/Wctpd+pUgWmyrsYq9ZzrowfvsdakP4Lyp5nmHSFAFMq
 P9+y9xR6mvO2zRLdRXA3LsVpc/RytRsUATHvGjD0jF3fBR6kBE6dnz3zjZMMALo+QG2og
X-Gm-Gg: AYBFou217sSlppNNnb7cgpM6BUZGDHDymyEjB/WqpbwvLzyiF0QqVEIitRgixoXPQgf
 6pChZo78mvKl5DIpS3fLW9UMDvArBxQD0w7X1WDofdICKPofXULTYPIDfzUx67POEj28tfCZLUH
 yuXG/tOZPKWLe8B7ShnVi53Uo5BSlRfZxaXEAiQpxAbDKPETV/JCVLF6TB1GSBGNjDnQac7ohc9
 qkaO8uAttcgaKq0awAt9yvSdgJr9Ci95hq62+bxrS7nAKK1eChjGXlpV+wElzMD7afIcYuCCMid
 PwvHMV1FotOJ1O2siyTfYmV5LiEgB2sqZK6j99x7pgZfOJIHuqZog+YJ43lor9H8Jp167QRhP5C
 NVVyCrdihzgXiqBv5S6YaTwopQZMPQRGcqb0WgC1CsRrbcvbo9C0TO7TTKPT59D0fMUa+tBmWk+
 Us+iYK9tw7XPLMKuSnG0p27A9qJ5yxtw==
X-Received: by 2002:a05:6102:5698:b0:7bd:732e:c615 with SMTP id
 ada2fe7eead31-7d03a5b4865mr2366358137.26.1793286817506; 
 Thu, 29 Oct 2026 08:13:37 -0700 (PDT)
X-Received: by 2002:a05:6102:5698:b0:7bd:732e:c615 with SMTP id
 ada2fe7eead31-7d03a5b4865mr2366344137.26.1793286817025; 
 Thu, 29 Oct 2026 08:13:37 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc3a1csm35345891f8f.16.2026.10.29.08.13.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 08:13:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 1/6] target/mips: Expand TRANS_DF_iv() macro for MSA
 Load/Store
Date: Thu, 29 Oct 2026 16:13:11 +0100
Message-ID: <20261029151317.19170-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029151317.19170-1-philmd@oss.qualcomm.com>
References: <20261029151317.19170-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA1OSBTYWx0ZWRfX789Wm06QbbAQ
 +4d6e1t+UADX2vNbqGhWoSkenwfpvTy3x+dA43r85XhxnE+Q2RRp+wY+FvvA95s9GhHkbRlUs5F
 9R4plCtZAoBTqp7R10Y+KHGeWfxOC/8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA1OSBTYWx0ZWRfX4prv7RMUTtZV
 d1fKAfbkSd/4Rp7nk5+kvMb0Wsd0CI0aJvMclhuJTyHdqNMThAIXrrFsGTN2IffVpac7p/EHxZ/
 HDAt7bL0WhFDxByzzrpPq70tecDS59r4/jLdqQQQcM7pVBi4nBAh4dGpg1r4gN4DThxBYoA0qoP
 xLIMVRXoj/h9cXUN2Ex4AHjL4XJjXgMUr8OaevRTR4ghsMGluSHbwlVeRYwfoqQGl8jF06wgkBX
 gTcns0zVzSzY6H+sYprZ1OmpdsjvOIPnwUKbSFMib99HaK2hvPO4s9ApnJDJI9Qug30yJzjtMEi
 I5UlE6yYmVj6fvn5v3IPLUArjEkJcHNgGXv9CxXUQ7jZ5ylaZmPJ/O8nQGxSyL4nBz21i97DdtN
 dNqajv397hpu4S3GTyQ15p2BAtfPfjtVEb+sBEjXsD3OoKSb4ci9QiNnFK/19eP9qwdS0+nhRCo
 XIqd0xOROKu0k01Oimg==
X-Proofpoint-ORIG-GUID: 6kek2ScbAb9XkM7BffNzuEcRmrqJG50A
X-Proofpoint-GUID: 6kek2ScbAb9XkM7BffNzuEcRmrqJG50A
X-Authority-Analysis: v=2.4 cv=HYSB3SE8 c=1 sm=1 tr=0 ts=6ae362a2 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=xxBBpw_d6xFnRPcyYRwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=TOPH6uDL9cOC6tEoww4z:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290059
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

In order to ease the conversion of MSA Load/Store runtime
helpers to translated code, expand the TRANS_DF_iv() macro.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/tcg/msa_translate.c | 59 ++++++++++++++++++++++++++-------
 1 file changed, 47 insertions(+), 12 deletions(-)

diff --git a/target/mips/tcg/msa_translate.c b/target/mips/tcg/msa_translate.c
index 75cf80a20ed4..ab4b1998aa0b 100644
--- a/target/mips/tcg/msa_translate.c
+++ b/target/mips/tcg/msa_translate.c
@@ -164,7 +164,6 @@ static inline bool check_msa_enabled(DisasContext *ctx)
     return true;
 }
 
-typedef void gen_helper_piv(TCGv_ptr, TCGv_i32, TCGv);
 typedef void gen_helper_pii(TCGv_ptr, TCGv_i32, TCGv_i32);
 typedef void gen_helper_piii(TCGv_ptr, TCGv_i32, TCGv_i32, TCGv_i32);
 typedef void gen_helper_piiii(TCGv_ptr, TCGv_i32, TCGv_i32, TCGv_i32, TCGv_i32);
@@ -175,9 +174,6 @@ typedef void gen_helper_piiii(TCGv_ptr, TCGv_i32, TCGv_i32, TCGv_i32, TCGv_i32);
     }; \
     TRANS(NAME, trans_func, NAME##_tab[a->df])
 
-#define TRANS_DF_iv(NAME, trans_func, gen_func) \
-    TRANS_DF_x(iv, NAME, trans_func, gen_func)
-
 #define TRANS_DF_ii(NAME, trans_func, gen_func) \
     TRANS_DF_x(ii, NAME, trans_func, gen_func)
 
@@ -758,25 +754,64 @@ TRANS(FTINT_U,  trans_msa_2rf, gen_helper_msa_ftint_u_df);
 TRANS(FFINT_S,  trans_msa_2rf, gen_helper_msa_ffint_s_df);
 TRANS(FFINT_U,  trans_msa_2rf, gen_helper_msa_ffint_u_df);
 
-static bool trans_msa_ldst(DisasContext *ctx, arg_msa_i *a,
-                           gen_helper_piv *gen_msa_ldst)
+static bool trans_msa_ldst(DisasContext *ctx, arg_msa_i *a, bool is_load)
 {
-    TCGv taddr;
+    TCGv_i32 wd;
+    TCGv_va addr;
 
     if (!check_msa_enabled(ctx)) {
         return true;
     }
 
-    taddr = tcg_temp_new();
+    addr = tcgv_va_temp_new();
+    gen_base_offset_addr(ctx, addr, a->ws, a->sa << a->df);
 
-    gen_base_offset_addr(ctx, taddr, a->ws, a->sa << a->df);
-    gen_msa_ldst(tcg_env, tcg_constant_i32(a->wd), taddr);
+    wd = tcg_constant_i32(a->wd);
+
+    if (is_load) {
+        switch (a->df) {
+        case 0:
+            gen_helper_msa_ld_b(tcg_env, wd, addr);
+            return true;
+        case 1:
+            gen_helper_msa_ld_h(tcg_env, wd, addr);
+            return true;
+        case 2:
+            gen_helper_msa_ld_w(tcg_env, wd, addr);
+            return true;
+        case 3:
+            gen_helper_msa_ld_d(tcg_env, wd, addr);
+            return true;
+        }
+    } else {
+        switch (a->df) {
+        case 0:
+            gen_helper_msa_st_b(tcg_env, wd, addr);
+            return true;
+        case 1:
+            gen_helper_msa_st_h(tcg_env, wd, addr);
+            return true;
+        case 2:
+            gen_helper_msa_st_w(tcg_env, wd, addr);
+            return true;
+        case 3:
+            gen_helper_msa_st_d(tcg_env, wd, addr);
+            return true;
+        }
+    }
 
     return true;
 }
 
-TRANS_DF_iv(LD, trans_msa_ldst, gen_helper_msa_ld);
-TRANS_DF_iv(ST, trans_msa_ldst, gen_helper_msa_st);
+static bool trans_LD(DisasContext *ctx, arg_msa_i *a)
+{
+    return trans_msa_ldst(ctx, a, true);
+}
+
+static bool trans_ST(DisasContext *ctx, arg_msa_i *a)
+{
+    return trans_msa_ldst(ctx, a, false);
+}
 
 static bool trans_LSA(DisasContext *ctx, arg_r *a)
 {
-- 
2.55.0


