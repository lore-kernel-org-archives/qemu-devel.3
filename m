Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811EF606A319
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ShIMMF5O;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KKTtLN4d
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIunC-0001cd-IA; Mon, 19 Oct 2026 17:21:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIun9-0001bH-EF
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:21:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIun5-0005fv-CB
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:21:11 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJJuRG2604726
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:21:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=y1ihBXndHpO
 h5EYTYcAtUPJoNxmjQ+L7zGDQ/keBCQM=; b=ShIMMF5O7z7T5caTk6iE+3j9uc+
 96SomDD/v7E6hJxXjXIwj6dBxNWbvoLCSrRqd33XmNFGlQaQSw8ADKUgTmit6RrW
 tTjMoUONVnQh9DSwkUSJ5b2sx+QS8P+TJd0IFMJEceWvVHRjMt9ywGDrEpRKz23v
 Kh587bK72UF/0mDp5VSVNbNcHnz3R3NMq6oZMfCueyeFvXc+w40cZLXSDxRdkxgK
 u0TGCHhGEUfwhawdZIgr903KsxXyVsD7gM5+gayCEwCL7SxXD1Ucb7lsA0hUcy79
 dbHfplgJqp/kiK423h9kg9Pxc6NMbR4wabKOaU15P8yw02YlQpSnXxWI8qw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdr4a0ps8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:21:05 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ab1e771632so80046a91.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792444864; x=1793049664; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y1ihBXndHpOh5EYTYcAtUPJoNxmjQ+L7zGDQ/keBCQM=;
 b=KKTtLN4dnQz+w8xpJ0lqbPf16gplv3WVeXKEXu7IBRHvKnZBMrUSyH7EFRixOl3cW3
 16Ahjl7UojqzuT5Sgbwuvx5Hh2LFfZCAfjSCT8MVanjYbbP+OFEEq/g8rnIdU81a+P0j
 ruDLkcLI1lhuP2oBdKCDr0zDft18iwlpDNKkBj9wtgSicui8IiZeGmPlYxGDmZ8dnN0A
 Ed1XlumaQVd7eq9Pqf00eVel7dL3mPDn8Gi9EpUo1sOQRMHSeOamkHm8XVLGR9SR8eUP
 YSWgdRYgZQtOUco3OCQqefn/kjYMJOQqnpsD+RE3TpTsy5xHZ/gA5GMc16qi0vb6vXzr
 HFcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792444864; x=1793049664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=y1ihBXndHpOh5EYTYcAtUPJoNxmjQ+L7zGDQ/keBCQM=;
 b=1jL6cR565Ocq/1cUO42GbT+ZL78rqq82zSE5nT4rjzBsHPcNcZf2t7C99WDkxA98pi
 89L+it9uJZKGt0hwH7NW6BGXOGONe/S9ULqeIZRicWantToPVLJFEywB4wy+7GcR4BQ/
 l5dNPQ54XB9HYHk4thiMuJuk9tby37WsMhJTjWBEZNQ9BwdFT33CrC3KxqZcNQ0EsgX2
 LTQlX8GpYu0h59P+ZSIWmPSTKYaC0WcXgNKaUq19uDrudri0Xd1NsKbxKcvIZZs0ruhb
 AsUqwM5RQsBG2Q8MHBoEyuLMsIk0WQ7wZlOPcpwXf9jmb7IzHJIN6H10BdhjjlWX09MA
 bHew==
X-Gm-Message-State: AFq9FYI090ce7XaCSJ2XVHLfU63IeSdegHYEGzBjs7CpHG2qirzQeebd
 PDlnLcDGbYLGg2+3jPA58VpaMiqe+yQCs5kHHiAdgDTkTt11jf0tvuIKHWqF5hUOACzxyqrpC2h
 jtNqqkGvvnz058fl8pQZAPLPhFKc6E6iLcYsv41opxufJzLj//Irgj5yF23ECycZYJw==
X-Gm-Gg: AYBFou1m7OBGSHari8AUEaswWXUXRD0QvQWG/5PpDj2I/fS4+XgsMV4NSxH5xj9f4eN
 w5bjm2l2QnXIabqM3KxDDAUq6dW92lLQyd22wSqnn24n7buKGRAPlrcChdIumoVDj3tSWZRzGwG
 zv47LCkazNPPH1h+XrbcavXEMMTcdIujbJzHIgdRTa02UMclHi9ZC2cvboA8nE/7IxhMF9py6kf
 3gkpDAsFatDabfIw47LvhHRxz2IEISJiZjCfgj91G52gNftDUmp3wHLL2FWgG1sQmGfUgV4i4IX
 bTRubFYrszyLKCgL7yIFjswHXOiBFFBt00VJMjHCYx3DsGSIONjtY+MJhzptzZvNBQaO7WOK2l3
 ozZnAaHq22H5yiOpnt9UFVvwNMfHFjh/7JeVQAFZ4RvSuskKvZBXXFejmZJc2WvM=
X-Received: by 2002:a17:90a:ec88:b0:3a6:d850:bf16 with SMTP id
 98e67ed59e1d1-3ad64bb7a75mr179273a91.23.1792444863898; 
 Mon, 19 Oct 2026 14:21:03 -0700 (PDT)
X-Received: by 2002:a17:90a:ec88:b0:3a6:d850:bf16 with SMTP id
 98e67ed59e1d1-3ad64bb7a75mr179256a91.23.1792444863074; 
 Mon, 19 Oct 2026 14:21:03 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad60ec4457sm863243a91.6.2026.10.19.14.21.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 14:21:02 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 02/26] target/arm: define and call helpers using HELPER macro
Date: Mon, 19 Oct 2026 21:20:21 +0000
Message-ID: <20261019212046.149572-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX1iv8JgJQWcVL
 6a1iTPSVPUYA19i9W9N7L28QP3R4xTTgMeYhj75zcx5VgJ4vDPbTJKUdRB9pG63OxFGmhtSailw
 Ef1PFkcPbsmdJLk28tJrVJogJLUz68g=
X-Authority-Analysis: v=2.4 cv=Zt54uN7G c=1 sm=1 tr=0 ts=6ad689c1 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=UqKkN2FlH-C22XUL27IA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: Xs81vINeCnA7WITDDZOkxGu1GWaIwo_1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfXyjkkr1xWKSjI
 IVovmQJrWKKDmVslRe5ADnWFVCYwGleShBNQYxNVwEoe9WcGYlaPsBA1DaChbU4aYDMdezEbJzf
 BHJveJa0SZndoIx9aKQ3Du1tZH3l5CH+7NDKw9VN3s64QIB77Tk8qt5/qrxhPqsT4JAxLgbHLd1
 N0UZgc8FloW+S91UJN5YewbutebVC/zZPaNBWQBiMTP3R+QRyIlSkwUA7PZLigCfiop3V7sUWVv
 XmnfsqOFlPbVK5vE4z6y/snjrCA7usQ9hmyq089+pkfIAOytN/F/BvNhUKwOKP5tv7JCJwdIYim
 C/7ysbHYB6aPjwDFIKj3YPHK6x5Y6WOtWmslqfGWWJt1sR7/++RiRMR1EAOjnWot99UpQFjiP2W
 fcXil82uTBCSiYaBf8VNRR/2CjSuv7DR7hgY3wrcrFdIusEhv+s6sMrhbem8idCjxqy9tzBxJY4
 EamdT0Owq5diLaPBNgg==
X-Proofpoint-GUID: Xs81vINeCnA7WITDDZOkxGu1GWaIwo_1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
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

In a upcoming commit, we'll prefix all helpers and helper_info with target
prefix, to disambiguate symbols between targets. As a first step, we need to
make sure all usages are using the existing HELPER macro.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/arm/tcg/helper-a64.c   |   6 +-
 target/arm/tcg/mve_helper.c   |  28 +++----
 target/arm/tcg/psci.c         |   2 +-
 target/arm/tcg/sme_helper.c   |   4 +-
 target/arm/tcg/sve_helper.c   | 141 +++++++++++++++++-----------------
 target/arm/tcg/tlb_helper.c   |   2 +-
 target/arm/tcg/vec_helper.c   |  72 ++++++++---------
 target/arm/tcg/vec_helper64.c |  64 +++++++--------
 target/arm/tcg/vec_internal.h |   5 +-
 9 files changed, 163 insertions(+), 161 deletions(-)

diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index f76d89990c3..fdfa220574f 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -707,7 +707,7 @@ void HELPER(exception_return)(CPUARMState *env, uint64_t new_pc)
         } else {
             env->regs[15] = new_pc & ~0x3;
         }
-        helper_rebuild_hflags_a32(env, new_el);
+        HELPER(rebuild_hflags_a32)(env, new_el);
         qemu_log_mask(CPU_LOG_INT, "Exception return from AArch64 EL%d to "
                       "AArch32 EL%d PC 0x%" PRIx32 "\n",
                       cur_el, new_el, env->regs[15]);
@@ -721,7 +721,7 @@ void HELPER(exception_return)(CPUARMState *env, uint64_t new_pc)
             env->pstate &= ~PSTATE_SS;
         }
         aarch64_restore_sp(env, new_el);
-        helper_rebuild_hflags_a64(env, new_el);
+        HELPER(rebuild_hflags_a64)(env, new_el);
 
         /*
          * Apply TBI to the exception return address.  We had to delay this
@@ -777,7 +777,7 @@ illegal_return:
     if (!arm_singlestep_active(env)) {
         env->pstate &= ~PSTATE_SS;
     }
-    helper_rebuild_hflags_a64(env, cur_el);
+    HELPER(rebuild_hflags_a64)(env, cur_el);
     qemu_log_mask(LOG_GUEST_ERROR, "Illegal exception return at EL%d: "
                   "resuming execution at 0x%" PRIx64 "\n", cur_el, env->pc);
 }
diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index 09ae2334167..4a8e0b210e6 100644
--- a/target/arm/tcg/mve_helper.c
+++ b/target/arm/tcg/mve_helper.c
@@ -3310,14 +3310,14 @@ DO_VCMP_FP_BOTH(vfcmples, vfcmple_scalars, 4, float32, !DO_GT32)
         mve_advance_vpt(env);                                           \
     }
 
-DO_VCVT_FIXED(vcvt_sh, 2, int16_t, helper_vfp_shtoh)
-DO_VCVT_FIXED(vcvt_uh, 2, uint16_t, helper_vfp_uhtoh)
-DO_VCVT_FIXED(vcvt_hs, 2, int16_t, helper_vfp_toshh_round_to_zero)
-DO_VCVT_FIXED(vcvt_hu, 2, uint16_t, helper_vfp_touhh_round_to_zero)
-DO_VCVT_FIXED(vcvt_sf, 4, int32_t, helper_vfp_sltos)
-DO_VCVT_FIXED(vcvt_uf, 4, uint32_t, helper_vfp_ultos)
-DO_VCVT_FIXED(vcvt_fs, 4, int32_t, helper_vfp_tosls_round_to_zero)
-DO_VCVT_FIXED(vcvt_fu, 4, uint32_t, helper_vfp_touls_round_to_zero)
+DO_VCVT_FIXED(vcvt_sh, 2, int16_t, HELPER(vfp_shtoh))
+DO_VCVT_FIXED(vcvt_uh, 2, uint16_t, HELPER(vfp_uhtoh))
+DO_VCVT_FIXED(vcvt_hs, 2, int16_t, HELPER(vfp_toshh_round_to_zero))
+DO_VCVT_FIXED(vcvt_hu, 2, uint16_t, HELPER(vfp_touhh_round_to_zero))
+DO_VCVT_FIXED(vcvt_sf, 4, int32_t, HELPER(vfp_sltos))
+DO_VCVT_FIXED(vcvt_uf, 4, uint32_t, HELPER(vfp_ultos))
+DO_VCVT_FIXED(vcvt_fs, 4, int32_t, HELPER(vfp_tosls_round_to_zero))
+DO_VCVT_FIXED(vcvt_fu, 4, uint32_t, HELPER(vfp_touls_round_to_zero))
 
 /* VCVT with specified rmode */
 #define DO_VCVT_RMODE(OP, ESIZE, TYPE, FN)                              \
@@ -3351,13 +3351,13 @@ DO_VCVT_FIXED(vcvt_fu, 4, uint32_t, helper_vfp_touls_round_to_zero)
         mve_advance_vpt(env);                                           \
     }
 
-DO_VCVT_RMODE(vcvt_rm_sh, 2, uint16_t, helper_vfp_toshh)
-DO_VCVT_RMODE(vcvt_rm_uh, 2, uint16_t, helper_vfp_touhh)
-DO_VCVT_RMODE(vcvt_rm_ss, 4, uint32_t, helper_vfp_tosls)
-DO_VCVT_RMODE(vcvt_rm_us, 4, uint32_t, helper_vfp_touls)
+DO_VCVT_RMODE(vcvt_rm_sh, 2, uint16_t, HELPER(vfp_toshh))
+DO_VCVT_RMODE(vcvt_rm_uh, 2, uint16_t, HELPER(vfp_touhh))
+DO_VCVT_RMODE(vcvt_rm_ss, 4, uint32_t, HELPER(vfp_tosls))
+DO_VCVT_RMODE(vcvt_rm_us, 4, uint32_t, HELPER(vfp_touls))
 
-#define DO_VRINT_RM_H(M, F, S) helper_rinth(M, S)
-#define DO_VRINT_RM_S(M, F, S) helper_rints(M, S)
+#define DO_VRINT_RM_H(M, F, S) HELPER(rinth)(M, S)
+#define DO_VRINT_RM_S(M, F, S) HELPER(rints)(M, S)
 
 DO_VCVT_RMODE(vrint_rm_h, 2, uint16_t, DO_VRINT_RM_H)
 DO_VCVT_RMODE(vrint_rm_s, 4, uint32_t, DO_VRINT_RM_S)
diff --git a/target/arm/tcg/psci.c b/target/arm/tcg/psci.c
index 56754bde951..d8e01df7623 100644
--- a/target/arm/tcg/psci.c
+++ b/target/arm/tcg/psci.c
@@ -172,7 +172,7 @@ void arm_handle_psci_call(ARMCPU *cpu)
         } else {
             env->regs[0] = 0;
         }
-        helper_wfi(env, 4);
+        HELPER(wfi)(env, 4);
         break;
     case QEMU_PSCI_1_0_FN_PSCI_FEATURES:
         switch (param[1]) {
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 9de95428d2a..5fb629362b9 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -34,12 +34,12 @@
 #define HELPER_H "tcg/helper-sme-defs.h"
 #include "exec/helper-info.c.inc"
 
-void helper_set_svcr(CPUARMState *env, uint32_t val, uint32_t mask)
+void HELPER(set_svcr)(CPUARMState *env, uint32_t val, uint32_t mask)
 {
     aarch64_set_svcr(env, val, mask);
 }
 
-void helper_sme_zero(CPUARMState *env, uint32_t imm, uint32_t svl)
+void HELPER(sme_zero)(CPUARMState *env, uint32_t imm, uint32_t svl)
 {
     uint32_t i;
 
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 8389dce6299..c296fc8c08f 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -778,13 +778,13 @@ DO_ZPZZ_PAIR_FP(sve2_fminp_zpzz_h, float16, H1_2, float16_min)
 DO_ZPZZ_PAIR_FP(sve2_fminp_zpzz_s, float32, H1_4, float32_min)
 DO_ZPZZ_PAIR_FP(sve2_fminp_zpzz_d, float64, H1_8, float64_min)
 
-DO_ZPZZ_PAIR_FP(sve2_ah_fmaxp_zpzz_h, float16, H1_2, helper_vfp_ah_maxh)
-DO_ZPZZ_PAIR_FP(sve2_ah_fmaxp_zpzz_s, float32, H1_4, helper_vfp_ah_maxs)
-DO_ZPZZ_PAIR_FP(sve2_ah_fmaxp_zpzz_d, float64, H1_8, helper_vfp_ah_maxd)
+DO_ZPZZ_PAIR_FP(sve2_ah_fmaxp_zpzz_h, float16, H1_2, HELPER(vfp_ah_maxh))
+DO_ZPZZ_PAIR_FP(sve2_ah_fmaxp_zpzz_s, float32, H1_4, HELPER(vfp_ah_maxs))
+DO_ZPZZ_PAIR_FP(sve2_ah_fmaxp_zpzz_d, float64, H1_8, HELPER(vfp_ah_maxd))
 
-DO_ZPZZ_PAIR_FP(sve2_ah_fminp_zpzz_h, float16, H1_2, helper_vfp_ah_minh)
-DO_ZPZZ_PAIR_FP(sve2_ah_fminp_zpzz_s, float32, H1_4, helper_vfp_ah_mins)
-DO_ZPZZ_PAIR_FP(sve2_ah_fminp_zpzz_d, float64, H1_8, helper_vfp_ah_mind)
+DO_ZPZZ_PAIR_FP(sve2_ah_fminp_zpzz_h, float16, H1_2, HELPER(vfp_ah_minh))
+DO_ZPZZ_PAIR_FP(sve2_ah_fminp_zpzz_s, float32, H1_4, HELPER(vfp_ah_mins))
+DO_ZPZZ_PAIR_FP(sve2_ah_fminp_zpzz_d, float64, H1_8, HELPER(vfp_ah_mind))
 
 #undef DO_ZPZZ_PAIR_FP
 
@@ -1044,8 +1044,8 @@ DO_ZPZ(sve2_sqneg_h, uint16_t, H1_2, DO_SQNEG)
 DO_ZPZ(sve2_sqneg_s, uint32_t, H1_4, DO_SQNEG)
 DO_ZPZ_D(sve2_sqneg_d, uint64_t, DO_SQNEG)
 
-DO_ZPZ(sve2_urecpe_s, uint32_t, H1_4, helper_recpe_u32)
-DO_ZPZ(sve2_ursqrte_s, uint32_t, H1_4, helper_rsqrte_u32)
+DO_ZPZ(sve2_urecpe_s, uint32_t, H1_4, HELPER(recpe_u32))
+DO_ZPZ(sve2_ursqrte_s, uint32_t, H1_4, HELPER(rsqrte_u32))
 
 /* Three-operand expander, unpredicated, in which the third operand is "wide".
  */
@@ -3621,25 +3621,25 @@ static void do_perseg_zzz(void *vd, void *vn, void *vm,
     void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc) \
     { do_perseg_zzz(vd, vn, vm, desc, FUNC); }
 
-DO_PERSEG_ZZZ(sve2p1_uzpq_b, helper_sve_uzp_b)
-DO_PERSEG_ZZZ(sve2p1_uzpq_h, helper_sve_uzp_h)
-DO_PERSEG_ZZZ(sve2p1_uzpq_s, helper_sve_uzp_s)
-DO_PERSEG_ZZZ(sve2p1_uzpq_d, helper_sve_uzp_d)
+DO_PERSEG_ZZZ(sve2p1_uzpq_b, HELPER(sve_uzp_b))
+DO_PERSEG_ZZZ(sve2p1_uzpq_h, HELPER(sve_uzp_h))
+DO_PERSEG_ZZZ(sve2p1_uzpq_s, HELPER(sve_uzp_s))
+DO_PERSEG_ZZZ(sve2p1_uzpq_d, HELPER(sve_uzp_d))
 
-DO_PERSEG_ZZZ(sve2p1_zipq_b, helper_sve_zip_b)
-DO_PERSEG_ZZZ(sve2p1_zipq_h, helper_sve_zip_h)
-DO_PERSEG_ZZZ(sve2p1_zipq_s, helper_sve_zip_s)
-DO_PERSEG_ZZZ(sve2p1_zipq_d, helper_sve_zip_d)
+DO_PERSEG_ZZZ(sve2p1_zipq_b, HELPER(sve_zip_b))
+DO_PERSEG_ZZZ(sve2p1_zipq_h, HELPER(sve_zip_h))
+DO_PERSEG_ZZZ(sve2p1_zipq_s, HELPER(sve_zip_s))
+DO_PERSEG_ZZZ(sve2p1_zipq_d, HELPER(sve_zip_d))
 
-DO_PERSEG_ZZZ(sve2p1_tblq_b, helper_sve_tbl_b)
-DO_PERSEG_ZZZ(sve2p1_tblq_h, helper_sve_tbl_h)
-DO_PERSEG_ZZZ(sve2p1_tblq_s, helper_sve_tbl_s)
-DO_PERSEG_ZZZ(sve2p1_tblq_d, helper_sve_tbl_d)
+DO_PERSEG_ZZZ(sve2p1_tblq_b, HELPER(sve_tbl_b))
+DO_PERSEG_ZZZ(sve2p1_tblq_h, HELPER(sve_tbl_h))
+DO_PERSEG_ZZZ(sve2p1_tblq_s, HELPER(sve_tbl_s))
+DO_PERSEG_ZZZ(sve2p1_tblq_d, HELPER(sve_tbl_d))
 
-DO_PERSEG_ZZZ(sve2p1_tbxq_b, helper_sve2_tbx_b)
-DO_PERSEG_ZZZ(sve2p1_tbxq_h, helper_sve2_tbx_h)
-DO_PERSEG_ZZZ(sve2p1_tbxq_s, helper_sve2_tbx_s)
-DO_PERSEG_ZZZ(sve2p1_tbxq_d, helper_sve2_tbx_d)
+DO_PERSEG_ZZZ(sve2p1_tbxq_b, HELPER(sve2_tbx_b))
+DO_PERSEG_ZZZ(sve2p1_tbxq_h, HELPER(sve2_tbx_h))
+DO_PERSEG_ZZZ(sve2p1_tbxq_s, HELPER(sve2_tbx_s))
+DO_PERSEG_ZZZ(sve2p1_tbxq_d, HELPER(sve2_tbx_d))
 
 #undef DO_PERSEG_ZZZ
 
@@ -4575,18 +4575,19 @@ uint32_t HELPER(sve_whilecg)(void *vd, uint32_t count, uint32_t pred_desc)
  * little to gain with a more complex non-recursive form.
  */
 #define DO_REDUCE(NAME, SUF, TYPE, H, FUNC, IDENT)                      \
-static TYPE FUNC##_reduce(TYPE *data, float_status *status, uintptr_t n) \
+static TYPE NAME##_##SUF##_reduce(TYPE *data, float_status *status,   \
+                                  uintptr_t n)                        \
 {                                                                     \
     if (n == 1) {                                                     \
         return *data;                                                 \
     } else {                                                          \
         uintptr_t half = n / 2;                                       \
-        TYPE lo = FUNC##_reduce(data, status, half);                  \
-        TYPE hi = FUNC##_reduce(data + half, status, half);           \
+        TYPE lo = NAME##_##SUF##_reduce(data, status, half);          \
+        TYPE hi = NAME##_##SUF##_reduce(data + half, status, half);   \
         return FUNC(lo, hi, status);                                  \
     }                                                                 \
 }                                                                     \
-uint64_t helper_sve_##NAME##v_##SUF(void *vn, void *vg,               \
+uint64_t HELPER(sve_##NAME##v_##SUF)(void *vn, void *vg,              \
                                     float_status *status, uint32_t desc) \
 {                                                                     \
     uintptr_t i, oprsz = simd_oprsz(desc), maxsz = simd_data(desc);   \
@@ -4603,9 +4604,9 @@ uint64_t helper_sve_##NAME##v_##SUF(void *vn, void *vg,               \
     for (; i < maxsz; i += sizeof(TYPE)) {                            \
         *(TYPE *)((void *)data + i) = ident;                          \
     }                                                                 \
-    return FUNC##_reduce(data, status, maxsz / sizeof(TYPE));         \
+    return NAME##_##SUF##_reduce(data, status, maxsz / sizeof(TYPE)); \
 }                                                                     \
-void helper_sve2p1_##NAME##qv_##SUF(void *vd, void *vn, void *vg,     \
+void HELPER(sve2p1_##NAME##qv_##SUF)(void *vd, void *vn, void *vg,    \
                                     float_status *status, uint32_t desc) \
 {                                                                     \
     unsigned oprsz = simd_oprsz(desc), segments = oprsz / 16;         \
@@ -4617,7 +4618,7 @@ void helper_sve2p1_##NAME##qv_##SUF(void *vd, void *vn, void *vg,     \
             TYPE nn = *(TYPE *)(vn + (s * 16 + H(e)));                \
             data[s] = (pg >> e) & 1 ? nn : ident;                     \
         }                                                             \
-        *(TYPE *)(vd + H(e)) = FUNC##_reduce(data, status, segments); \
+        *(TYPE *)(vd + H(e)) = NAME##_##SUF##_reduce(data, status, segments); \
     }                                                                 \
     clear_tail(vd, 16, simd_maxsz(desc));                             \
 }
@@ -4646,15 +4647,15 @@ DO_REDUCE(fmax,h, float16, H1_2, float16_max, float16_chs(float16_infinity))
 DO_REDUCE(fmax,s, float32, H1_4, float32_max, float32_chs(float32_infinity))
 DO_REDUCE(fmax,d, float64, H1_8, float64_max, float64_chs(float64_infinity))
 
-DO_REDUCE(ah_fmin,h, float16, H1_2, helper_vfp_ah_minh, float16_infinity)
-DO_REDUCE(ah_fmin,s, float32, H1_4, helper_vfp_ah_mins, float32_infinity)
-DO_REDUCE(ah_fmin,d, float64, H1_8, helper_vfp_ah_mind, float64_infinity)
+DO_REDUCE(ah_fmin, h, float16, H1_2, HELPER(vfp_ah_minh), float16_infinity)
+DO_REDUCE(ah_fmin, s, float32, H1_4, HELPER(vfp_ah_mins), float32_infinity)
+DO_REDUCE(ah_fmin, d, float64, H1_8, HELPER(vfp_ah_mind), float64_infinity)
 
-DO_REDUCE(ah_fmax,h, float16, H1_2, helper_vfp_ah_maxh,
+DO_REDUCE(ah_fmax, h, float16, H1_2, HELPER(vfp_ah_maxh),
           float16_chs(float16_infinity))
-DO_REDUCE(ah_fmax,s, float32, H1_4, helper_vfp_ah_maxs,
+DO_REDUCE(ah_fmax, s, float32, H1_4, HELPER(vfp_ah_maxs),
           float32_chs(float32_infinity))
-DO_REDUCE(ah_fmax,d, float64, H1_8, helper_vfp_ah_maxd,
+DO_REDUCE(ah_fmax, d, float64, H1_8, HELPER(vfp_ah_maxd),
           float64_chs(float64_infinity))
 
 #undef DO_REDUCE
@@ -4766,15 +4767,15 @@ DO_ZPZZ_FP(sve_fmax_h, uint16_t, H1_2, float16_max)
 DO_ZPZZ_FP(sve_fmax_s, uint32_t, H1_4, float32_max)
 DO_ZPZZ_FP(sve_fmax_d, uint64_t, H1_8, float64_max)
 
-DO_ZPZZ_FP(sve_ah_fmin_b16, uint16_t, H1_2, helper_sme2_ah_fmin_b16)
-DO_ZPZZ_FP(sve_ah_fmin_h, uint16_t, H1_2, helper_vfp_ah_minh)
-DO_ZPZZ_FP(sve_ah_fmin_s, uint32_t, H1_4, helper_vfp_ah_mins)
-DO_ZPZZ_FP(sve_ah_fmin_d, uint64_t, H1_8, helper_vfp_ah_mind)
+DO_ZPZZ_FP(sve_ah_fmin_b16, uint16_t, H1_2, HELPER(sme2_ah_fmin_b16))
+DO_ZPZZ_FP(sve_ah_fmin_h, uint16_t, H1_2, HELPER(vfp_ah_minh))
+DO_ZPZZ_FP(sve_ah_fmin_s, uint32_t, H1_4, HELPER(vfp_ah_mins))
+DO_ZPZZ_FP(sve_ah_fmin_d, uint64_t, H1_8, HELPER(vfp_ah_mind))
 
-DO_ZPZZ_FP(sve_ah_fmax_b16, uint16_t, H1_2, helper_sme2_ah_fmax_b16)
-DO_ZPZZ_FP(sve_ah_fmax_h, uint16_t, H1_2, helper_vfp_ah_maxh)
-DO_ZPZZ_FP(sve_ah_fmax_s, uint32_t, H1_4, helper_vfp_ah_maxs)
-DO_ZPZZ_FP(sve_ah_fmax_d, uint64_t, H1_8, helper_vfp_ah_maxd)
+DO_ZPZZ_FP(sve_ah_fmax_b16, uint16_t, H1_2, HELPER(sme2_ah_fmax_b16))
+DO_ZPZZ_FP(sve_ah_fmax_h, uint16_t, H1_2, HELPER(vfp_ah_maxh))
+DO_ZPZZ_FP(sve_ah_fmax_s, uint32_t, H1_4, HELPER(vfp_ah_maxs))
+DO_ZPZZ_FP(sve_ah_fmax_d, uint64_t, H1_8, HELPER(vfp_ah_maxd))
 
 DO_ZPZZ_FP(sve_fminnum_b16, uint16_t, H1_2, bfloat16_minnum)
 DO_ZPZZ_FP(sve_fminnum_h, uint16_t, H1_2, float16_minnum)
@@ -4832,9 +4833,9 @@ DO_ZPZZ_FP(sve_fscalbn_h, int16_t, H1_2, float16_scalbn)
 DO_ZPZZ_FP(sve_fscalbn_s, int32_t, H1_4, float32_scalbn)
 DO_ZPZZ_FP(sve_fscalbn_d, int64_t, H1_8, scalbn_d)
 
-DO_ZPZZ_FP(sve_fmulx_h, uint16_t, H1_2, helper_advsimd_mulxh)
-DO_ZPZZ_FP(sve_fmulx_s, uint32_t, H1_4, helper_vfp_mulxs)
-DO_ZPZZ_FP(sve_fmulx_d, uint64_t, H1_8, helper_vfp_mulxd)
+DO_ZPZZ_FP(sve_fmulx_h, uint16_t, H1_2, HELPER(advsimd_mulxh))
+DO_ZPZZ_FP(sve_fmulx_s, uint32_t, H1_4, HELPER(vfp_mulxs))
+DO_ZPZZ_FP(sve_fmulx_d, uint64_t, H1_8, HELPER(vfp_mulxd))
 
 DO_ZPZZ_FP(sve2_famax_h, uint16_t, H1_2, float16_famax)
 DO_ZPZZ_FP(sve2_famax_s, uint32_t, H1_4, float32_famax)
@@ -4915,13 +4916,13 @@ DO_ZPZS_FP(sve_fmins_h, float16, H1_2, float16_min)
 DO_ZPZS_FP(sve_fmins_s, float32, H1_4, float32_min)
 DO_ZPZS_FP(sve_fmins_d, float64, H1_8, float64_min)
 
-DO_ZPZS_FP(sve_ah_fmaxs_h, float16, H1_2, helper_vfp_ah_maxh)
-DO_ZPZS_FP(sve_ah_fmaxs_s, float32, H1_4, helper_vfp_ah_maxs)
-DO_ZPZS_FP(sve_ah_fmaxs_d, float64, H1_8, helper_vfp_ah_maxd)
+DO_ZPZS_FP(sve_ah_fmaxs_h, float16, H1_2, HELPER(vfp_ah_maxh))
+DO_ZPZS_FP(sve_ah_fmaxs_s, float32, H1_4, HELPER(vfp_ah_maxs))
+DO_ZPZS_FP(sve_ah_fmaxs_d, float64, H1_8, HELPER(vfp_ah_maxd))
 
-DO_ZPZS_FP(sve_ah_fmins_h, float16, H1_2, helper_vfp_ah_minh)
-DO_ZPZS_FP(sve_ah_fmins_s, float32, H1_4, helper_vfp_ah_mins)
-DO_ZPZS_FP(sve_ah_fmins_d, float64, H1_8, helper_vfp_ah_mind)
+DO_ZPZS_FP(sve_ah_fmins_h, float16, H1_2, HELPER(vfp_ah_minh))
+DO_ZPZS_FP(sve_ah_fmins_s, float32, H1_4, HELPER(vfp_ah_mins))
+DO_ZPZS_FP(sve_ah_fmins_d, float64, H1_8, HELPER(vfp_ah_mind))
 
 /*
  * Fully general two-operand expander, controlled by a predicate,
@@ -5077,37 +5078,37 @@ DO_ZPZ_FP(sve_fcvt_ds, uint64_t, H1_8, float64_to_float32)
 DO_ZPZ_FP(sve_fcvt_sd, uint64_t, H1_8, float32_to_float64)
 
 DO_ZPZ_FP(sve_fcvtzs_hh, uint16_t, H1_2, vfp_float16_to_int16_rtz)
-DO_ZPZ_FP(sve_fcvtzs_hs, uint32_t, H1_4, helper_vfp_tosizh)
-DO_ZPZ_FP(sve_fcvtzs_ss, uint32_t, H1_4, helper_vfp_tosizs)
+DO_ZPZ_FP(sve_fcvtzs_hs, uint32_t, H1_4, HELPER(vfp_tosizh))
+DO_ZPZ_FP(sve_fcvtzs_ss, uint32_t, H1_4, HELPER(vfp_tosizs))
 DO_ZPZ_FP(sve_fcvtzs_hd, uint64_t, H1_8, vfp_float16_to_int64_rtz)
 DO_ZPZ_FP(sve_fcvtzs_sd, uint64_t, H1_8, vfp_float32_to_int64_rtz)
-DO_ZPZ_FP(sve_fcvtzs_ds, uint64_t, H1_8, helper_vfp_tosizd)
+DO_ZPZ_FP(sve_fcvtzs_ds, uint64_t, H1_8, HELPER(vfp_tosizd))
 DO_ZPZ_FP(sve_fcvtzs_dd, uint64_t, H1_8, vfp_float64_to_int64_rtz)
 
 DO_ZPZ_FP(sve_fcvtzu_hh, uint16_t, H1_2, vfp_float16_to_uint16_rtz)
-DO_ZPZ_FP(sve_fcvtzu_hs, uint32_t, H1_4, helper_vfp_touizh)
-DO_ZPZ_FP(sve_fcvtzu_ss, uint32_t, H1_4, helper_vfp_touizs)
+DO_ZPZ_FP(sve_fcvtzu_hs, uint32_t, H1_4, HELPER(vfp_touizh))
+DO_ZPZ_FP(sve_fcvtzu_ss, uint32_t, H1_4, HELPER(vfp_touizs))
 DO_ZPZ_FP(sve_fcvtzu_hd, uint64_t, H1_8, vfp_float16_to_uint64_rtz)
 DO_ZPZ_FP(sve_fcvtzu_sd, uint64_t, H1_8, vfp_float32_to_uint64_rtz)
-DO_ZPZ_FP(sve_fcvtzu_ds, uint64_t, H1_8, helper_vfp_touizd)
+DO_ZPZ_FP(sve_fcvtzu_ds, uint64_t, H1_8, HELPER(vfp_touizd))
 DO_ZPZ_FP(sve_fcvtzu_dd, uint64_t, H1_8, vfp_float64_to_uint64_rtz)
 
-DO_ZPZ_FP(sve_frint_h, uint16_t, H1_2, helper_advsimd_rinth)
-DO_ZPZ_FP(sve_frint_s, uint32_t, H1_4, helper_rints)
-DO_ZPZ_FP(sve_frint_d, uint64_t, H1_8, helper_rintd)
+DO_ZPZ_FP(sve_frint_h, uint16_t, H1_2, HELPER(advsimd_rinth))
+DO_ZPZ_FP(sve_frint_s, uint32_t, H1_4, HELPER(rints))
+DO_ZPZ_FP(sve_frint_d, uint64_t, H1_8, HELPER(rintd))
 
 DO_ZPZ_FP(sve_frintx_h, uint16_t, H1_2, float16_round_to_int)
 DO_ZPZ_FP(sve_frintx_s, uint32_t, H1_4, float32_round_to_int)
 DO_ZPZ_FP(sve_frintx_d, uint64_t, H1_8, float64_round_to_int)
 
-DO_ZPZ_FP(sve2p2_frint32_s, uint32_t, H1_4, helper_frint32_s)
-DO_ZPZ_FP(sve2p2_frint64_s, uint32_t, H1_4, helper_frint64_s)
-DO_ZPZ_FP(sve2p2_frint32_d, uint64_t, H1_8, helper_frint32_d)
-DO_ZPZ_FP(sve2p2_frint64_d, uint64_t, H1_8, helper_frint64_d)
+DO_ZPZ_FP(sve2p2_frint32_s, uint32_t, H1_4, HELPER(frint32_s))
+DO_ZPZ_FP(sve2p2_frint64_s, uint32_t, H1_4, HELPER(frint64_s))
+DO_ZPZ_FP(sve2p2_frint32_d, uint64_t, H1_8, HELPER(frint32_d))
+DO_ZPZ_FP(sve2p2_frint64_d, uint64_t, H1_8, HELPER(frint64_d))
 
-DO_ZPZ_FP(sve_frecpx_h, uint16_t, H1_2, helper_frecpx_f16)
-DO_ZPZ_FP(sve_frecpx_s, uint32_t, H1_4, helper_frecpx_f32)
-DO_ZPZ_FP(sve_frecpx_d, uint64_t, H1_8, helper_frecpx_f64)
+DO_ZPZ_FP(sve_frecpx_h, uint16_t, H1_2, HELPER(frecpx_f16))
+DO_ZPZ_FP(sve_frecpx_s, uint32_t, H1_4, HELPER(frecpx_f32))
+DO_ZPZ_FP(sve_frecpx_d, uint64_t, H1_8, HELPER(frecpx_f64))
 
 DO_ZPZ_FP(sve_fsqrt_h, uint16_t, H1_2, float16_sqrt)
 DO_ZPZ_FP(sve_fsqrt_s, uint32_t, H1_4, float32_sqrt)
diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index 4c3f16dc2aa..4a1611f23f5 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -289,7 +289,7 @@ void arm_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
     arm_deliver_fault(cpu, vaddr, access_type, mmu_idx, &fi);
 }
 
-void helper_exception_pc_alignment(CPUARMState *env, vaddr pc)
+void HELPER(exception_pc_alignment)(CPUARMState *env, vaddr pc)
 {
     ARMMMUFaultInfo fi = { .type = ARMFault_Alignment };
     int target_el = exception_target_el(env);
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 3c06e93e02d..8dd840e8291 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -1286,23 +1286,23 @@ void HELPER(NAME)(void *vd, void *vn, float_status *stat, uint32_t desc)  \
     clear_tail(d, oprsz, simd_maxsz(desc));                       \
 }
 
-DO_2OP(gvec_frecpe_h, helper_recpe_f16, float16)
-DO_2OP(gvec_frecpe_s, helper_recpe_f32, float32)
-DO_2OP(gvec_frecpe_rpres_s, helper_recpe_rpres_f32, float32)
-DO_2OP(gvec_frecpe_d, helper_recpe_f64, float64)
+DO_2OP(gvec_frecpe_h, HELPER(recpe_f16), float16)
+DO_2OP(gvec_frecpe_s, HELPER(recpe_f32), float32)
+DO_2OP(gvec_frecpe_rpres_s, HELPER(recpe_rpres_f32), float32)
+DO_2OP(gvec_frecpe_d, HELPER(recpe_f64), float64)
 
-DO_2OP(gvec_frsqrte_h, helper_rsqrte_f16, float16)
-DO_2OP(gvec_frsqrte_s, helper_rsqrte_f32, float32)
-DO_2OP(gvec_frsqrte_rpres_s, helper_rsqrte_rpres_f32, float32)
-DO_2OP(gvec_frsqrte_d, helper_rsqrte_f64, float64)
+DO_2OP(gvec_frsqrte_h, HELPER(rsqrte_f16), float16)
+DO_2OP(gvec_frsqrte_s, HELPER(rsqrte_f32), float32)
+DO_2OP(gvec_frsqrte_rpres_s, HELPER(rsqrte_rpres_f32), float32)
+DO_2OP(gvec_frsqrte_d, HELPER(rsqrte_f64), float64)
 
 DO_2OP(gvec_vrintx_h, float16_round_to_int, float16)
 DO_2OP(gvec_vrintx_s, float32_round_to_int, float32)
 
-DO_2OP(gvec_sitos, helper_vfp_sitos, int32_t)
-DO_2OP(gvec_uitos, helper_vfp_uitos, uint32_t)
-DO_2OP(gvec_tosizs, helper_vfp_tosizs, float32)
-DO_2OP(gvec_touizs, helper_vfp_touizs, float32)
+DO_2OP(gvec_sitos, HELPER(vfp_sitos), int32_t)
+DO_2OP(gvec_uitos, HELPER(vfp_uitos), uint32_t)
+DO_2OP(gvec_tosizs, HELPER(vfp_tosizs), float32)
+DO_2OP(gvec_touizs, HELPER(vfp_touizs), float32)
 DO_2OP(gvec_sstoh, int16_to_float16, int16_t)
 DO_2OP(gvec_ustoh, uint16_to_float16, uint16_t)
 DO_2OP(gvec_tosszh, vfp_tosszh, float16)
@@ -2596,19 +2596,19 @@ DO_3OP_PAIR_NO_STATUS(gvec_uminp_s, MIN, uint32_t, H4)
         clear_tail(d, oprsz, simd_maxsz(desc));                         \
     }
 
-DO_VCVT_FIXED(gvec_vcvt_sd, helper_vfp_sqtod, uint64_t)
-DO_VCVT_FIXED(gvec_vcvt_ud, helper_vfp_uqtod, uint64_t)
-DO_VCVT_FIXED(gvec_vcvt_sf, helper_vfp_sltos, uint32_t)
-DO_VCVT_FIXED(gvec_vcvt_uf, helper_vfp_ultos, uint32_t)
-DO_VCVT_FIXED(gvec_vcvt_sh, helper_vfp_shtoh, uint16_t)
-DO_VCVT_FIXED(gvec_vcvt_uh, helper_vfp_uhtoh, uint16_t)
+DO_VCVT_FIXED(gvec_vcvt_sd, HELPER(vfp_sqtod), uint64_t)
+DO_VCVT_FIXED(gvec_vcvt_ud, HELPER(vfp_uqtod), uint64_t)
+DO_VCVT_FIXED(gvec_vcvt_sf, HELPER(vfp_sltos), uint32_t)
+DO_VCVT_FIXED(gvec_vcvt_uf, HELPER(vfp_ultos), uint32_t)
+DO_VCVT_FIXED(gvec_vcvt_sh, HELPER(vfp_shtoh), uint16_t)
+DO_VCVT_FIXED(gvec_vcvt_uh, HELPER(vfp_uhtoh), uint16_t)
 
-DO_VCVT_FIXED(gvec_vcvt_rz_ds, helper_vfp_tosqd_round_to_zero, uint64_t)
-DO_VCVT_FIXED(gvec_vcvt_rz_du, helper_vfp_touqd_round_to_zero, uint64_t)
-DO_VCVT_FIXED(gvec_vcvt_rz_fs, helper_vfp_tosls_round_to_zero, uint32_t)
-DO_VCVT_FIXED(gvec_vcvt_rz_fu, helper_vfp_touls_round_to_zero, uint32_t)
-DO_VCVT_FIXED(gvec_vcvt_rz_hs, helper_vfp_toshh_round_to_zero, uint16_t)
-DO_VCVT_FIXED(gvec_vcvt_rz_hu, helper_vfp_touhh_round_to_zero, uint16_t)
+DO_VCVT_FIXED(gvec_vcvt_rz_ds, HELPER(vfp_tosqd_round_to_zero), uint64_t)
+DO_VCVT_FIXED(gvec_vcvt_rz_du, HELPER(vfp_touqd_round_to_zero), uint64_t)
+DO_VCVT_FIXED(gvec_vcvt_rz_fs, HELPER(vfp_tosls_round_to_zero), uint32_t)
+DO_VCVT_FIXED(gvec_vcvt_rz_fu, HELPER(vfp_touls_round_to_zero), uint32_t)
+DO_VCVT_FIXED(gvec_vcvt_rz_hs, HELPER(vfp_toshh_round_to_zero), uint16_t)
+DO_VCVT_FIXED(gvec_vcvt_rz_hu, HELPER(vfp_touhh_round_to_zero), uint16_t)
 
 #undef DO_VCVT_FIXED
 
@@ -2627,12 +2627,12 @@ DO_VCVT_FIXED(gvec_vcvt_rz_hu, helper_vfp_touhh_round_to_zero, uint16_t)
         clear_tail(d, oprsz, simd_maxsz(desc));                         \
     }
 
-DO_VCVT_RMODE(gvec_vcvt_rm_sd, helper_vfp_tosqd, uint64_t)
-DO_VCVT_RMODE(gvec_vcvt_rm_ud, helper_vfp_touqd, uint64_t)
-DO_VCVT_RMODE(gvec_vcvt_rm_ss, helper_vfp_tosls, uint32_t)
-DO_VCVT_RMODE(gvec_vcvt_rm_us, helper_vfp_touls, uint32_t)
-DO_VCVT_RMODE(gvec_vcvt_rm_sh, helper_vfp_toshh, uint16_t)
-DO_VCVT_RMODE(gvec_vcvt_rm_uh, helper_vfp_touhh, uint16_t)
+DO_VCVT_RMODE(gvec_vcvt_rm_sd, HELPER(vfp_tosqd), uint64_t)
+DO_VCVT_RMODE(gvec_vcvt_rm_ud, HELPER(vfp_touqd), uint64_t)
+DO_VCVT_RMODE(gvec_vcvt_rm_ss, HELPER(vfp_tosls), uint32_t)
+DO_VCVT_RMODE(gvec_vcvt_rm_us, HELPER(vfp_touls), uint32_t)
+DO_VCVT_RMODE(gvec_vcvt_rm_sh, HELPER(vfp_toshh), uint16_t)
+DO_VCVT_RMODE(gvec_vcvt_rm_uh, HELPER(vfp_touhh), uint16_t)
 
 #undef DO_VCVT_RMODE
 
@@ -2651,8 +2651,8 @@ DO_VCVT_RMODE(gvec_vcvt_rm_uh, helper_vfp_touhh, uint16_t)
         clear_tail(d, oprsz, simd_maxsz(desc));                         \
     }
 
-DO_VRINT_RMODE(gvec_vrint_rm_h, helper_rinth, uint16_t)
-DO_VRINT_RMODE(gvec_vrint_rm_s, helper_rints, uint32_t)
+DO_VRINT_RMODE(gvec_vrint_rm_h, HELPER(rinth), uint16_t)
+DO_VRINT_RMODE(gvec_vrint_rm_s, HELPER(rints), uint32_t)
 
 #undef DO_VRINT_RMODE
 
@@ -3242,7 +3242,7 @@ void HELPER(gvec_urecpe_s)(void *vd, void *vn, uint32_t desc)
     uint32_t *d = vd, *n = vn;
 
     for (i = 0; i < opr_sz / 4; ++i) {
-        d[i] = helper_recpe_u32(n[i]);
+        d[i] = HELPER(recpe_u32)(n[i]);
     }
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
@@ -3253,7 +3253,7 @@ void HELPER(gvec_ursqrte_s)(void *vd, void *vn, uint32_t desc)
     uint32_t *d = vd, *n = vn;
 
     for (i = 0; i < opr_sz / 4; ++i) {
-        d[i] = helper_rsqrte_u32(n[i]);
+        d[i] = HELPER(rsqrte_u32)(n[i]);
     }
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
@@ -3307,7 +3307,7 @@ static inline void do_lut_s(void *zd, uint64_t *indexes, uint32_t *table,
 }
 
 #define DO_SME2_LUT(ISIZE, NREG, SUFF, ESIZE) \
-void helper_sme2_luti##ISIZE##_##NREG##SUFF                             \
+void HELPER(sme2_luti##ISIZE##_##NREG##SUFF)                            \
     (void *zd, void *zn, CPUARMState *env, uint32_t desc)               \
 {                                                                       \
     unsigned vl = simd_oprsz(desc);                                     \
@@ -3345,7 +3345,7 @@ DO_SME2_LUT(4,4,s, 4)
 
 #undef DO_SME2_LUT
 
-void helper_sme2_luti4_4b(void *zd, void *zn, CPUARMState *env, uint32_t desc)
+void HELPER(sme2_luti4_4b)(void *zd, void *zn, CPUARMState *env, uint32_t desc)
 {
     unsigned vl = simd_oprsz(desc);
     unsigned strided = extract32(desc, SIMD_DATA_SHIFT, 1);
diff --git a/target/arm/tcg/vec_helper64.c b/target/arm/tcg/vec_helper64.c
index 4f43869d9e9..53723fa40b9 100644
--- a/target/arm/tcg/vec_helper64.c
+++ b/target/arm/tcg/vec_helper64.c
@@ -23,46 +23,46 @@ DO_3OP(gvec_fdiv_h, float16_div, float16)
 DO_3OP(gvec_fdiv_s, float32_div, float32)
 DO_3OP(gvec_fdiv_d, float64_div, float64)
 
-DO_3OP(gvec_fmulx_h, helper_advsimd_mulxh, float16)
-DO_3OP(gvec_fmulx_s, helper_vfp_mulxs, float32)
-DO_3OP(gvec_fmulx_d, helper_vfp_mulxd, float64)
+DO_3OP(gvec_fmulx_h, HELPER(advsimd_mulxh), float16)
+DO_3OP(gvec_fmulx_s, HELPER(vfp_mulxs), float32)
+DO_3OP(gvec_fmulx_d, HELPER(vfp_mulxd), float64)
 
-DO_3OP(gvec_recps_h, helper_recpsf_f16, float16)
-DO_3OP(gvec_recps_s, helper_recpsf_f32, float32)
-DO_3OP(gvec_recps_d, helper_recpsf_f64, float64)
+DO_3OP(gvec_recps_h, HELPER(recpsf_f16), float16)
+DO_3OP(gvec_recps_s, HELPER(recpsf_f32), float32)
+DO_3OP(gvec_recps_d, HELPER(recpsf_f64), float64)
 
-DO_3OP(gvec_rsqrts_h, helper_rsqrtsf_f16, float16)
-DO_3OP(gvec_rsqrts_s, helper_rsqrtsf_f32, float32)
-DO_3OP(gvec_rsqrts_d, helper_rsqrtsf_f64, float64)
+DO_3OP(gvec_rsqrts_h, HELPER(rsqrtsf_f16), float16)
+DO_3OP(gvec_rsqrts_s, HELPER(rsqrtsf_f32), float32)
+DO_3OP(gvec_rsqrts_d, HELPER(rsqrtsf_f64), float64)
 
-DO_3OP(gvec_ah_recps_h, helper_recpsf_ah_f16, float16)
-DO_3OP(gvec_ah_recps_s, helper_recpsf_ah_f32, float32)
-DO_3OP(gvec_ah_recps_d, helper_recpsf_ah_f64, float64)
+DO_3OP(gvec_ah_recps_h, HELPER(recpsf_ah_f16), float16)
+DO_3OP(gvec_ah_recps_s, HELPER(recpsf_ah_f32), float32)
+DO_3OP(gvec_ah_recps_d, HELPER(recpsf_ah_f64), float64)
 
-DO_3OP(gvec_ah_rsqrts_h, helper_rsqrtsf_ah_f16, float16)
-DO_3OP(gvec_ah_rsqrts_s, helper_rsqrtsf_ah_f32, float32)
-DO_3OP(gvec_ah_rsqrts_d, helper_rsqrtsf_ah_f64, float64)
+DO_3OP(gvec_ah_rsqrts_h, HELPER(rsqrtsf_ah_f16), float16)
+DO_3OP(gvec_ah_rsqrts_s, HELPER(rsqrtsf_ah_f32), float32)
+DO_3OP(gvec_ah_rsqrts_d, HELPER(rsqrtsf_ah_f64), float64)
 
-DO_3OP(gvec_ah_fmax_h, helper_vfp_ah_maxh, float16)
-DO_3OP(gvec_ah_fmax_s, helper_vfp_ah_maxs, float32)
-DO_3OP(gvec_ah_fmax_d, helper_vfp_ah_maxd, float64)
+DO_3OP(gvec_ah_fmax_h, HELPER(vfp_ah_maxh), float16)
+DO_3OP(gvec_ah_fmax_s, HELPER(vfp_ah_maxs), float32)
+DO_3OP(gvec_ah_fmax_d, HELPER(vfp_ah_maxd), float64)
 
-DO_3OP(gvec_ah_fmin_h, helper_vfp_ah_minh, float16)
-DO_3OP(gvec_ah_fmin_s, helper_vfp_ah_mins, float32)
-DO_3OP(gvec_ah_fmin_d, helper_vfp_ah_mind, float64)
+DO_3OP(gvec_ah_fmin_h, HELPER(vfp_ah_minh), float16)
+DO_3OP(gvec_ah_fmin_s, HELPER(vfp_ah_mins), float32)
+DO_3OP(gvec_ah_fmin_d, HELPER(vfp_ah_mind), float64)
 
 DO_3OP(gvec_fmax_b16, bfloat16_max, bfloat16)
 DO_3OP(gvec_fmin_b16, bfloat16_min, bfloat16)
 DO_3OP(gvec_fmaxnum_b16, bfloat16_maxnum, bfloat16)
 DO_3OP(gvec_fminnum_b16, bfloat16_minnum, bfloat16)
-DO_3OP(gvec_ah_fmax_b16, helper_sme2_ah_fmax_b16, bfloat16)
-DO_3OP(gvec_ah_fmin_b16, helper_sme2_ah_fmin_b16, bfloat16)
+DO_3OP(gvec_ah_fmax_b16, HELPER(sme2_ah_fmax_b16), bfloat16)
+DO_3OP(gvec_ah_fmin_b16, HELPER(sme2_ah_fmin_b16), bfloat16)
 
 #define nop(N, M, S) (M)
 
-DO_FMUL_IDX(gvec_fmulx_idx_h, nop, helper_advsimd_mulxh, float16, H2)
-DO_FMUL_IDX(gvec_fmulx_idx_s, nop, helper_vfp_mulxs, float32, H4)
-DO_FMUL_IDX(gvec_fmulx_idx_d, nop, helper_vfp_mulxd, float64, H8)
+DO_FMUL_IDX(gvec_fmulx_idx_h, nop, HELPER(advsimd_mulxh), float16, H2)
+DO_FMUL_IDX(gvec_fmulx_idx_s, nop, HELPER(vfp_mulxs), float32, H4)
+DO_FMUL_IDX(gvec_fmulx_idx_d, nop, HELPER(vfp_mulxd), float64, H8)
 
 #undef nop
 
@@ -123,13 +123,13 @@ void HELPER(sve_pmlal_q)(void *vd, void *vn, void *vm, uint32_t desc)
     }
 }
 
-DO_3OP_PAIR(gvec_ah_fmaxp_h, helper_vfp_ah_maxh, float16, H2)
-DO_3OP_PAIR(gvec_ah_fmaxp_s, helper_vfp_ah_maxs, float32, H4)
-DO_3OP_PAIR(gvec_ah_fmaxp_d, helper_vfp_ah_maxd, float64, /**/)
+DO_3OP_PAIR(gvec_ah_fmaxp_h, HELPER(vfp_ah_maxh), float16, H2)
+DO_3OP_PAIR(gvec_ah_fmaxp_s, HELPER(vfp_ah_maxs), float32, H4)
+DO_3OP_PAIR(gvec_ah_fmaxp_d, HELPER(vfp_ah_maxd), float64, /**/)
 
-DO_3OP_PAIR(gvec_ah_fminp_h, helper_vfp_ah_minh, float16, H2)
-DO_3OP_PAIR(gvec_ah_fminp_s, helper_vfp_ah_mins, float32, H4)
-DO_3OP_PAIR(gvec_ah_fminp_d, helper_vfp_ah_mind, float64, /**/)
+DO_3OP_PAIR(gvec_ah_fminp_h, HELPER(vfp_ah_minh), float16, H2)
+DO_3OP_PAIR(gvec_ah_fminp_s, HELPER(vfp_ah_mins), float32, H4)
+DO_3OP_PAIR(gvec_ah_fminp_d, HELPER(vfp_ah_mind), float64, /**/)
 
 void HELPER(simd_tblx)(void *vd, void *vm, CPUARMState *env, uint32_t desc)
 {
diff --git a/target/arm/tcg/vec_internal.h b/target/arm/tcg/vec_internal.h
index 8f6d8a984b3..6d9d7c35efa 100644
--- a/target/arm/tcg/vec_internal.h
+++ b/target/arm/tcg/vec_internal.h
@@ -22,6 +22,7 @@
 
 #include "fpu/softfloat.h"
 #include "vector-type.h"
+#include "exec/helper-head.h.inc"
 
 typedef struct CPUArchState CPUARMState;
 
@@ -364,8 +365,8 @@ static inline float64 float64_maybe_ah_chs(float64 a, bool fpcr_ah)
 }
 
 /* Not actually called directly as a helper, but uses similar machinery. */
-bfloat16 helper_sme2_ah_fmax_b16(bfloat16 a, bfloat16 b, float_status *fpst);
-bfloat16 helper_sme2_ah_fmin_b16(bfloat16 a, bfloat16 b, float_status *fpst);
+bfloat16 HELPER(sme2_ah_fmax_b16)(bfloat16 a, bfloat16 b, float_status *fpst);
+bfloat16 HELPER(sme2_ah_fmin_b16)(bfloat16 a, bfloat16 b, float_status *fpst);
 
 float32 sve_f16_to_f32(float16 f, float_status *fpst);
 float16 sve_f32_to_f16(float32 f, float_status *fpst);
-- 
2.43.0


