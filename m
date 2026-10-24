Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B947606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 17:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XU+F5Qs3;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SzCgGRj3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKfgL-00043w-Os; Sat, 24 Oct 2026 13:37:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKfg4-0003yT-Cq
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 13:37:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKfg2-0008HO-At
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 13:37:08 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69OExrP11353442
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 17:37:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lyad378P44CQNsM443IZSw9CkAhTNQJpeDIVE0Vs8QI=; b=XU+F5Qs3F3bTkHBD
 xeggNkLqBdLGgPq4Fvbqip1M8s0TeJzoOctPEBhuzDJkqA5Bp+incHmUujG5P6ks
 JBgVqouRFoBAAZ31M9+LFddAfuVMfvygZzzjh0/g8ZDzORuorqkRhemgwzn4sCOv
 4gOK9xHAcSaaOUeuquKHPlrdWErx1JQWhRb1d5P3fDWnHNqbyjbKbK5IZnSb3QAv
 OzSSF3GEghmqeETCmtfg2Yh1cbxpd9b1GFdQYi47yofhlqGaOueKXRJNI9DjTeHv
 vDNO3rqyTQLdjBY239Q4XK1UKiEJYl7znKTyj4maFibs+yl0yV+22VKAlClpDRWb
 aIT1jA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgnehhc7e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 17:37:03 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ac7a4ba546so2063017a91.0
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 10:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792863423; x=1793468223; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lyad378P44CQNsM443IZSw9CkAhTNQJpeDIVE0Vs8QI=;
 b=SzCgGRj3YpiEYVOAoF3cj5/OOyMasFWvE8sMJUglH0/NbP3VILeZ4k1RxG2+Hm51aD
 HfL7+pX0xjaHXzf/HpiNSDH45D34vkgtGkt9s6A5BEyyZ60Sp11W+ey8+FeAFUGpKcOf
 V59JSymFsSkd6mF2Ds0YaEukiDiNF7NDUdQf6mmIF7NpLMq4ITNPqED6W9gAd0LXIgYu
 0OfyMZqonWHbILhncXtgyqMRMiPa3muur3+gPdbozfvVMK3aAYVs0k4mKtKcUge3uy5I
 3caPm+s8DHIJWZKa1ZaFxeVTsB/e+RqY7aNNUZnKtlVIcuCBQA1NZyuYLVUjOtPIBShP
 G/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792863423; x=1793468223;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lyad378P44CQNsM443IZSw9CkAhTNQJpeDIVE0Vs8QI=;
 b=cHjqgZMTqWashoBKdbkSProKyWuVP4VbtJ4+6oT3GHzAqpnLpjvfoCgXMNhhailCS+
 wTpnDo1CTLSSoZEkwIW41oXeL4BHfFzcjwp913vPg/UYqwc0UR7nIQbTBotrxEXA23SG
 tCzQivJy1dTbz6IlBirzfD6Ym44/XRnnFXJ3kq4kQgfhnbAwBGEK/YqfaahHO7vxu1pV
 kKPMB+UFtCPur0eTAfpkK3JTyoH36A4Q8cqSV6lf9WvPCJFNAQmvfs4D49+oPaxnAGip
 jwtilfbzzrU7V9mfS2xoqESfdu4oc6nG55273A7s7mUow3kAUbj8gHtL9Kuv8QOIyDwo
 f7MQ==
X-Gm-Message-State: AFq9FYJHQKxbz13BwvBzKbidQvfKLDy9TpsTrODHXWkIRgl6W+sxGJlV
 xZGr1hdbUcsHmTjqKlbw3SiCzJ8IwcznQpHtKQlkBMPPjyigBZCqJ616Arkw+uYxqemqzaOHpRH
 UAUqazkDYzq6kCJwhCB12HcHzVEbHp66IDk4ECdxZB/jg5t7SZFxvq7N34VVN9M8gQg==
X-Gm-Gg: AYBFou2Tkz7ZYOA5j27iVi03vUFc9mz6Lk/hbbG4+Fjjn2ebmLnfw3ZpxTK/sdSYGjF
 Zw6Mdjsuilvjxk1EeQahrT7hijWMP/GKH3KJ4/e60+kJxMywPEbEWgiv+6oB3GLabYeABW9anXg
 woXYAxZGiVDjyKmTqrikQoIQkEs2nRy3XlELiWNSRWNnfU1cddYp5ThISqrixCNfko5BcTm4FYV
 wC+n3CzpLpicEOLDg741z6aLaV3UtpiEuq7VdqF3BR5RQ42i9+g0Yar30bOeDszVEbZt1/ZSuJ1
 tEclhK7Mz28jNJUbiz+NVyBS2fX/KUTA+8x0LR9bMFtdljsjuy0VdTPx1Vb7kSJPS1CyHld0ruc
 cC2anJGke7C8S/Oa+1uQ9dr8IwyKcBUrvGU/pV3bGJmAfSjK3SZTMya46s0hz2eQ=
X-Received: by 2002:a17:90b:2b50:b0:3a6:f6b0:30ce with SMTP id
 98e67ed59e1d1-3adeb64cbd0mr1350776a91.36.1792863423065; 
 Sat, 24 Oct 2026 10:37:03 -0700 (PDT)
X-Received: by 2002:a17:90b:2b50:b0:3a6:f6b0:30ce with SMTP id
 98e67ed59e1d1-3adeb64cbd0mr1350762a91.36.1792863422522; 
 Sat, 24 Oct 2026 10:37:02 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebbb1a13sm3324093a91.2.2026.10.24.10.37.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 10:37:01 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 06/20] target/hexagon: remove explicit target specific prefix
Date: Sat, 24 Oct 2026 17:36:35 +0000
Message-ID: <20261024173649.7405-7-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024173649.7405-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261024173649.7405-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA3MCBTYWx0ZWRfX1PFR9f3V0e/7
 VXP1LeU+HGTZmczziAarrfVSFEGkYKTIuyGT4e7nBl+exAn2z97sZtQf57eBReOZSnshBlxV/Ex
 PseT6BpeyMDa9ZBVXq4wTYkJJukGbHs=
X-Proofpoint-ORIG-GUID: cnvRw5mjekeTMHWX7zg_8rmfsHFVZjDO
X-Authority-Analysis: v=2.4 cv=d5tgWhjE c=1 sm=1 tr=0 ts=6adcecbf cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=xJBkFjxltbiK57tzlAwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA3MCBTYWx0ZWRfX3I7WjKpSTR5C
 3SrZD6C37V84BHE6Q4k8+HmSecxQaGK2z1HuKA+sF2DZKKz4TaNT07QtXtKci17d3EDSwZRaaVi
 TjpJfjs0Jd4JE6KF74fNIcrhQshQxMlgtIvh2x+3rryU6ZHVcM/L4H2ZB5xohuaoetGeJz9OfDc
 WAKUMagdybCdfDG/fubvuiZkXIz3L53F9OQt7kQ0SoflVGNXZ3/pzxEPNojck0NjHWzEUHeE2Tj
 cOvZYGmdGNJzwXhnFwxeLlqMIkZS2tr70LQrWXlyorjNKYlc97TOYnRQb3yD10Wg7oZlt66gQe+
 58z9hUJBde2rKlsiYT0/RV/j9nx5bpwYen0U5R8qEg+TWCFFKK7CmHmLpf9+cUfDK8V+RBUgjk4
 Xn6NPBD8vBugx+8K1T5Db2SzBzNpPlV8M2oWgYucvJm1CVUagSVhqRj0HD7f0+kKEfODRVzum2P
 spRwXE310H59HBXaEXg==
X-Proofpoint-GUID: cnvRw5mjekeTMHWX7zg_8rmfsHFVZjDO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 adultscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240070
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

This reverts commit 086150a223a6dfeae85e8bb925c5df0ca3061ed5
"target/hexagon: prefix helpers conflicting with other arch"

Acked-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Link: https://lore.kernel.org/qemu-devel/20261024163249.77855-7-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/hexagon/gen_tcg.h     | 2 +-
 target/hexagon/gen_tcg_sys.h | 2 +-
 target/hexagon/helper.h      | 4 ++--
 target/hexagon/op_helper.c   | 4 ++--
 target/hexagon/translate.c   | 4 ++--
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/hexagon/gen_tcg.h b/target/hexagon/gen_tcg.h
index ed05f97efed..80d8a7b6bac 100644
--- a/target/hexagon/gen_tcg.h
+++ b/target/hexagon/gen_tcg.h
@@ -1135,7 +1135,7 @@
 #define fGEN_TCG_J2_pause(SHORTCODE) \
     do { \
         uiV = uiV; \
-        gen_helper_hexagon_raise_exception(tcg_env, \
+        gen_helper_raise_exception(tcg_env, \
             tcg_constant_i32(EXCP_YIELD), \
             tcg_constant_i32(ctx->next_PC)); \
     } while (0)
diff --git a/target/hexagon/gen_tcg_sys.h b/target/hexagon/gen_tcg_sys.h
index 3760b671adf..413ccc97f7b 100644
--- a/target/hexagon/gen_tcg_sys.h
+++ b/target/hexagon/gen_tcg_sys.h
@@ -80,7 +80,7 @@
 #define fGEN_TCG_Y2_wait(SHORTCODE) \
     do { \
         RsV = RsV; \
-        gen_helper_hexagon_wait(tcg_env); \
+        gen_helper_wait(tcg_env); \
     } while (0)
 
 #define fGEN_TCG_Y2_resume(SHORTCODE) \
diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h
index 28591417040..47958c48ea9 100644
--- a/target/hexagon/helper.h
+++ b/target/hexagon/helper.h
@@ -18,7 +18,7 @@
 #include "internal.h"
 #include "helper_protos_generated.h.inc"
 
-DEF_HELPER_FLAGS_3(hexagon_raise_exception, TCG_CALL_NO_RETURN, noreturn, env, i32, i32)
+DEF_HELPER_FLAGS_3(raise_exception, TCG_CALL_NO_RETURN, noreturn, env, i32, i32)
 DEF_HELPER_2(commit_store, void, env, int)
 DEF_HELPER_3(gather_store, void, env, i32, int)
 DEF_HELPER_1(commit_hvx_stores, void, env)
@@ -138,7 +138,7 @@ DEF_HELPER_3(sreg_write_masked, void, env, i32, i32)
 DEF_HELPER_3(setprio, void, env, i32, i32)
 DEF_HELPER_2(start, void, env, i32)
 DEF_HELPER_1(stop, void, env)
-DEF_HELPER_1(hexagon_wait, void, env)
+DEF_HELPER_1(wait, void, env)
 DEF_HELPER_2(resume, void, env, i32)
 DEF_HELPER_1(resched, void, env)
 DEF_HELPER_3(modify_ssr, void, env, i32, i32)
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index 9850dc07289..82d38dc0b08 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -93,7 +93,7 @@ G_NORETURN void hexagon_raise_exception_err(CPUHexagonState *env,
     do_raise_exception(env, exception, pc, 0);
 }
 
-G_NORETURN void HELPER(hexagon_raise_exception)(CPUHexagonState *env, uint32_t excp,
+G_NORETURN void HELPER(raise_exception)(CPUHexagonState *env, uint32_t excp,
                                         uint32_t PC)
 {
     hexagon_raise_exception_err(env, excp, PC);
@@ -1839,7 +1839,7 @@ void HELPER(resched)(CPUHexagonState *env)
     resched(env);
 }
 
-void HELPER(hexagon_wait)(CPUHexagonState *env)
+void HELPER(wait)(CPUHexagonState *env)
 {
     BQL_LOCK_GUARD();
 
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 2c18f5eebff..e2a5038a1a5 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -139,7 +139,7 @@ intptr_t ctx_tmp_vreg_off(DisasContext *ctx, int regnum,
 static void gen_precise_exception(int cause, uint32_t PC)
 {
     tcg_gen_movi_i32(hex_cause_code, cause);
-    gen_helper_hexagon_raise_exception(tcg_env, tcg_constant_i32(HEX_EVENT_PRECISE),
+    gen_helper_raise_exception(tcg_env, tcg_constant_i32(HEX_EVENT_PRECISE),
                                tcg_constant_i32(PC));
 }
 
@@ -1146,7 +1146,7 @@ static void check_imprecise_exception(DisasContext *ctx)
     TCGLabel *label = gen_new_label();
 
     tcg_gen_brcondi_tl(TCG_COND_EQ, hex_imprecise_exception, 0, label);
-    gen_helper_hexagon_raise_exception(tcg_env, hex_imprecise_exception, PC);
+    gen_helper_raise_exception(tcg_env, hex_imprecise_exception, PC);
     gen_set_label(label);
 }
 #endif
-- 
2.43.0


