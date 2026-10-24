Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1DF606A31D
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 16:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=X3fLKY3E;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OPp0LGwE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKegE-0000xU-Mf; Sat, 24 Oct 2026 12:33:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKegD-0000xK-GU
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 12:33:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKegB-0002No-CB
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 12:33:13 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69OF011X1563213
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 16:33:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5I3o5Pu8a+t8jEYssK0U6F2MGK1j+wuhPW133OPdM3Q=; b=X3fLKY3EMtvwEqh/
 Za0II8llAhvhGTkiCow5ej5MMDF7RfTPLCzMJKL00fnPHuo8kY8hkcPaFF1RKkBH
 tmJgomo0fFfA3HPKzsqYcS02tXtBUqkzQu0/wQyzVoNZ5L3o5YoUGDJ9D/cC23lj
 b8xtHV5EUg2V6S4wiGz4e6naa3p0MJgRF+7sBIyyeDuO7L4bAeVUVQHnGstj+7BY
 msi4nJfM1PBoXgoCq3cfF9iVrJZg0ipcYNdd2/B+bBebhUEwbxkBlKKEIBUOUy6B
 BR5d5PvPT0igf+5J5D9il0aqSC6sT1V+rNJ08ttqhGS3YpigzBnn8bZ8yFnMKR//
 XG/QTQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgm0gheyk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 16:33:10 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ac6795617aso1617074a91.1
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 09:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792859589; x=1793464389; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5I3o5Pu8a+t8jEYssK0U6F2MGK1j+wuhPW133OPdM3Q=;
 b=OPp0LGwEl9M40s7MkAVp/wMCf6ktlOwio+Jt2nCGmrTYEnA4YfZtTCVOn2JDHt1RuD
 YRMQYTB+Q+Klje2NPAIKHMh+9bREtQQYKi7x12xZPptdo+dMk0par0/ybXl1DSVGjxNv
 3q+Yc6dhCvR3Nexqp/o/VS7SxC/BKEwFG9sR1GL+z/tpGLXINoPLtd+s947TEBe574w0
 +EU04iJnzboka1WUPPcm8/ZvadkaEXUvLRaIofQqrrSJhU4LueSjvsyGn1V+L+I7AFGQ
 4OH32546qNhvzQaI8+sglJwv1aG6n+FczrlqZRoe1KCrx2ZxDjsr+1MALVCGMTLHAAP4
 +M2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792859589; x=1793464389;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5I3o5Pu8a+t8jEYssK0U6F2MGK1j+wuhPW133OPdM3Q=;
 b=b5O7f8gHIkEWhSfpa0lQLKaaMyoCqnGTSsdYbu9vbVw3n+SR6122b/Zml55n75CsPQ
 UqaoMWOJOY6gxMEvnN2nXlnzFiku5DS0HewpULVrwPkFVjwJYaw3O+Js732r/HvLjpDq
 x8fnlo24W3jATl8npgi37uslLGA0wWgm0aG/n2hvPYRPODEHHx6oG0zBNHZh2yKR9dWn
 u30o1lJ0/uA7Ledv6vYJyHueVsDwOQxjoG/UFqBi9ZLEUTgk5X8mLVshSdJ0WGH1T2x2
 bSusgEq5ar2I9jpP1+x6Ju9WXhEUvpi/nV2C+kh+zzHDY1gJECSoFSSIXHa02Kd6T02j
 wL3g==
X-Gm-Message-State: AFq9FYKTUcbA3O037BhcZ2ldNaFW1NxYd6TGzgYNxq9vmQI/BhGlc5mq
 2hlnOzj3uavCuAgLSW51jOdjbFqg2hYgOypGpwlT89z8bsRn8/tWcew62Ln/Cz1AArjm04i5Q44
 cqGCdCoHoi98zUCb4fjFgdjFworHO0V3fsiNYxLRTHcqk9D7f2KxJN/MKWGNhZR5R9Q==
X-Gm-Gg: AYBFou3hrOQmoSeSqT2cTPWOTGeNwbIiSslfsd1iFitJRNFxTRxFN7fnOJBkUC9n1Q6
 mRJq4DvZC/67dARqD35xiwjT26xVybAP2IcrbPEfIqIGSWDCDaG4L+LnbagdtVDll0soPlCxVrw
 94lODohQ1Z8NvyR+oIYjOndaaz7DmhT9F80VqFtKC+gunQFqSB6eg54W2+lAcMsgTW8BtsfcC17
 GFBo3u3yTggqLZ5OSs7EcdNJnJhOBVSzUbrKGBpgVeTBCPTB/Ji3lau7W19lO0cSh+U36Ao4ZyM
 HWVhyZvHlInWed1gb7WLkzT4701wL+DExdklc0jMSd6FOmfb0iD4+NcG9YV9L/hls0gzfGr9E+g
 cSqbUNf5iuY7JrG1CGj21HTDlZwuSNStDwSQArF+pESbDal6w210UgtgUZn/fwUE=
X-Received: by 2002:a17:90b:52c4:b0:3ac:9176:e82b with SMTP id
 98e67ed59e1d1-3adeae778a9mr2030033a91.54.1792859589024; 
 Sat, 24 Oct 2026 09:33:09 -0700 (PDT)
X-Received: by 2002:a17:90b:52c4:b0:3ac:9176:e82b with SMTP id
 98e67ed59e1d1-3adeae778a9mr2030009a91.54.1792859588460; 
 Sat, 24 Oct 2026 09:33:08 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebad93c5sm1932270a91.2.2026.10.24.09.33.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 09:33:04 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yonggang Luo <luoyonggang@gmail.com>
Subject: [PATCH v2 02/11] tcg: introduce HELPER_INFO macro
Date: Sat, 24 Oct 2026 16:32:40 +0000
Message-ID: <20261024163249.77855-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024163249.77855-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261024163249.77855-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: mCg-8qdow_PCY_ipZUJUDmSXXpk5Ez80
X-Authority-Analysis: v=2.4 cv=UfTE26SN c=1 sm=1 tr=0 ts=6adcddc6 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=ighA3CKJURImTjC3cZkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: mCg-8qdow_PCY_ipZUJUDmSXXpk5Ez80
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA2NSBTYWx0ZWRfXxepRTaGiQSZi
 ACCtVeXY1tVtTa7oABU7GKmttwprVW7oZ/RssbtTb/Qnvsx3Z/fop4EO4lp568DJoUKq4Tc9Zhz
 7R2Gh6XQYBqK9aFx2o+/qV36tl2ojtrhsOXE3Zrl7a8H1YBEHjrBCdxGb8n+x/iBWNI3SEAmMUk
 6Ysv8mxEdz8WXEqQ3W+QG+U2YYmlqNCO5um/QOl9+3tB10F5WES3p3udQuHhdcR9cMRdiKITeze
 3uBsb+iSmcovCyA7PyuIM5TZIC9ZohZ9a5T1zk7dDdefWhSgtTNppecYgqEGRfAIXYunX6A5Afn
 GA6suhPq0xsQYZd2LunZvn4SXVKjvZiEJOxxnggIARPP6RYSYtYIYghM0LM73sRBGllSDSsLjzB
 y7KPx0nCPPjtZC2ItsYtkC0g0KJllvLhzjkvZB1D6S7yMRZVvNfCIpKMuNRbfu+nraXSjjP+GOa
 VlSp5r26EyAQmeb1hFA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA2NSBTYWx0ZWRfX2KXVuNL9smHs
 x/gj0qoN5Aj/HgapEsjwBoqk+yFmyu0SKazzX2TBtp5kLhUcKZyxKRgGbQZC2tiH7xxeqTtsmp9
 f9WNCwVPBRpPyJi1JmQ3seAoMQ3DGRg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240065
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

In next commit, we'll prefix all helpers and helper_info with target
base architecture. Make sure helper_info symbol name is defined in a
single place before that.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Acked-by: Yonggang Luo <luoyonggang@gmail.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/exec/helper-gen.h.inc  | 48 +++++++++++++++++-----------------
 include/exec/helper-head.h.inc |  1 +
 include/exec/helper-info.c.inc | 16 ++++++------
 3 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/include/exec/helper-gen.h.inc b/include/exec/helper-gen.h.inc
index dabe138e205..95715bde1ef 100644
--- a/include/exec/helper-gen.h.inc
+++ b/include/exec/helper-gen.h.inc
@@ -11,88 +11,88 @@
 #include "exec/helper-head.h.inc"
 
 #define DEF_HELPER_FLAGS_0(name, flags, ret)                            \
-extern TCGHelperInfo glue(helper_info_, name);                          \
+extern TCGHelperInfo HELPER_INFO(name);                                 \
 static inline void glue(gen_helper_, name)(dh_retvar_decl0(ret))        \
 {                                                                       \
-    tcg_gen_call0(glue(helper_info_,name).func,                         \
-                  &glue(helper_info_,name), dh_retvar(ret));            \
+    tcg_gen_call0(HELPER_INFO(name).func,                               \
+                  &HELPER_INFO(name), dh_retvar(ret));                  \
 }
 
 #define DEF_HELPER_FLAGS_1(name, flags, ret, t1)                        \
-extern TCGHelperInfo glue(helper_info_, name);                          \
+extern TCGHelperInfo HELPER_INFO(name);                                 \
 static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1))                                                 \
 {                                                                       \
-    tcg_gen_call1(glue(helper_info_,name).func,                         \
-                  &glue(helper_info_,name), dh_retvar(ret),             \
+    tcg_gen_call1(HELPER_INFO(name).func,                               \
+                  &HELPER_INFO(name), dh_retvar(ret),                   \
                   dh_arg(t1, 1));                                       \
 }
 
 #define DEF_HELPER_FLAGS_2(name, flags, ret, t1, t2)                    \
-extern TCGHelperInfo glue(helper_info_, name);                          \
+extern TCGHelperInfo HELPER_INFO(name);                                 \
 static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1), dh_arg_decl(t2, 2))                             \
 {                                                                       \
-    tcg_gen_call2(glue(helper_info_,name).func,                         \
-                  &glue(helper_info_,name), dh_retvar(ret),             \
+    tcg_gen_call2(HELPER_INFO(name).func,                               \
+                  &HELPER_INFO(name), dh_retvar(ret),                   \
                   dh_arg(t1, 1), dh_arg(t2, 2));                        \
 }
 
 #define DEF_HELPER_FLAGS_3(name, flags, ret, t1, t2, t3)                \
-extern TCGHelperInfo glue(helper_info_, name);                          \
+extern TCGHelperInfo HELPER_INFO(name);                                 \
 static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1), dh_arg_decl(t2, 2), dh_arg_decl(t3, 3))         \
 {                                                                       \
-    tcg_gen_call3(glue(helper_info_,name).func,                         \
-                  &glue(helper_info_,name), dh_retvar(ret),             \
+    tcg_gen_call3(HELPER_INFO(name).func,                               \
+                  &HELPER_INFO(name), dh_retvar(ret),                   \
                   dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3));         \
 }
 
 #define DEF_HELPER_FLAGS_4(name, flags, ret, t1, t2, t3, t4)            \
-extern TCGHelperInfo glue(helper_info_, name);                          \
+extern TCGHelperInfo HELPER_INFO(name);                                 \
 static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1), dh_arg_decl(t2, 2),                             \
     dh_arg_decl(t3, 3), dh_arg_decl(t4, 4))                             \
 {                                                                       \
-    tcg_gen_call4(glue(helper_info_,name).func,                         \
-                  &glue(helper_info_,name), dh_retvar(ret),             \
+    tcg_gen_call4(HELPER_INFO(name).func,                               \
+                  &HELPER_INFO(name), dh_retvar(ret),                   \
                   dh_arg(t1, 1), dh_arg(t2, 2),                         \
                   dh_arg(t3, 3), dh_arg(t4, 4));                        \
 }
 
 #define DEF_HELPER_FLAGS_5(name, flags, ret, t1, t2, t3, t4, t5)        \
-extern TCGHelperInfo glue(helper_info_, name);                          \
+extern TCGHelperInfo HELPER_INFO(name);                                 \
 static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1), dh_arg_decl(t2, 2), dh_arg_decl(t3, 3),         \
     dh_arg_decl(t4, 4), dh_arg_decl(t5, 5))                             \
 {                                                                       \
-    tcg_gen_call5(glue(helper_info_,name).func,                         \
-                  &glue(helper_info_,name), dh_retvar(ret),             \
+    tcg_gen_call5(HELPER_INFO(name).func,                               \
+                  &HELPER_INFO(name), dh_retvar(ret),                   \
                   dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3),          \
                   dh_arg(t4, 4), dh_arg(t5, 5));                        \
 }
 
 #define DEF_HELPER_FLAGS_6(name, flags, ret, t1, t2, t3, t4, t5, t6)    \
-extern TCGHelperInfo glue(helper_info_, name);                          \
+extern TCGHelperInfo HELPER_INFO(name);                                 \
 static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1), dh_arg_decl(t2, 2), dh_arg_decl(t3, 3),         \
     dh_arg_decl(t4, 4), dh_arg_decl(t5, 5), dh_arg_decl(t6, 6))         \
 {                                                                       \
-    tcg_gen_call6(glue(helper_info_,name).func,                         \
-                  &glue(helper_info_,name), dh_retvar(ret),             \
+    tcg_gen_call6(HELPER_INFO(name).func,                               \
+                  &HELPER_INFO(name), dh_retvar(ret),                   \
                   dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3),          \
                   dh_arg(t4, 4), dh_arg(t5, 5), dh_arg(t6, 6));         \
 }
 
 #define DEF_HELPER_FLAGS_7(name, flags, ret, t1, t2, t3, t4, t5, t6, t7)\
-extern TCGHelperInfo glue(helper_info_, name);                          \
+extern TCGHelperInfo HELPER_INFO(name);                                 \
 static inline void glue(gen_helper_, name)(dh_retvar_decl(ret)          \
     dh_arg_decl(t1, 1), dh_arg_decl(t2, 2), dh_arg_decl(t3, 3),         \
     dh_arg_decl(t4, 4), dh_arg_decl(t5, 5), dh_arg_decl(t6, 6),         \
     dh_arg_decl(t7, 7))                                                 \
 {                                                                       \
-    tcg_gen_call7(glue(helper_info_,name).func,                         \
-                  &glue(helper_info_,name), dh_retvar(ret),             \
+    tcg_gen_call7(HELPER_INFO(name).func,                               \
+                  &HELPER_INFO(name), dh_retvar(ret),                   \
                   dh_arg(t1, 1), dh_arg(t2, 2), dh_arg(t3, 3),          \
                   dh_arg(t4, 4), dh_arg(t5, 5), dh_arg(t6, 6),          \
                   dh_arg(t7, 7));                                       \
diff --git a/include/exec/helper-head.h.inc b/include/exec/helper-head.h.inc
index 7dec5f5b067..be1d79cf017 100644
--- a/include/exec/helper-head.h.inc
+++ b/include/exec/helper-head.h.inc
@@ -9,6 +9,7 @@
 #include "fpu/softfloat-types.h"
 
 #define HELPER(name) glue(helper_, name)
+#define HELPER_INFO(name) glue(helper_info_, name)
 
 /* Some types that make sense in C, but not for TCG.  */
 #define dh_alias_i32 i32
diff --git a/include/exec/helper-info.c.inc b/include/exec/helper-info.c.inc
index c551736d49f..4e1ab61e5ce 100644
--- a/include/exec/helper-info.c.inc
+++ b/include/exec/helper-info.c.inc
@@ -16,21 +16,21 @@
 #define str(s) #s
 
 #define DEF_HELPER_FLAGS_0(NAME, FLAGS, RET)                            \
-    TCGHelperInfo glue(helper_info_, NAME) = {                          \
+    TCGHelperInfo HELPER_INFO(NAME) = {                                 \
         .func = HELPER(NAME), .name = str(NAME),                        \
         .flags = FLAGS | dh_callflag(RET),                              \
         .typemask = dh_typemask(RET, 0)                                 \
     };
 
 #define DEF_HELPER_FLAGS_1(NAME, FLAGS, RET, T1)                        \
-    TCGHelperInfo glue(helper_info_, NAME) = {                          \
+    TCGHelperInfo HELPER_INFO(NAME) = {                                 \
         .func = HELPER(NAME), .name = str(NAME),                        \
         .flags = FLAGS | dh_callflag(RET),                              \
         .typemask = dh_typemask(RET, 0) | dh_typemask(T1, 1)            \
     };
 
 #define DEF_HELPER_FLAGS_2(NAME, FLAGS, RET, T1, T2)                    \
-    TCGHelperInfo glue(helper_info_, NAME) = {                          \
+    TCGHelperInfo HELPER_INFO(NAME) = {                                 \
         .func = HELPER(NAME), .name = str(NAME),                        \
         .flags = FLAGS | dh_callflag(RET),                              \
         .typemask = dh_typemask(RET, 0) | dh_typemask(T1, 1)            \
@@ -38,7 +38,7 @@
     };
 
 #define DEF_HELPER_FLAGS_3(NAME, FLAGS, RET, T1, T2, T3)                \
-    TCGHelperInfo glue(helper_info_, NAME) = {                          \
+    TCGHelperInfo HELPER_INFO(NAME) = {                                 \
         .func = HELPER(NAME), .name = str(NAME),                        \
         .flags = FLAGS | dh_callflag(RET),                              \
         .typemask = dh_typemask(RET, 0) | dh_typemask(T1, 1)            \
@@ -46,7 +46,7 @@
     };
 
 #define DEF_HELPER_FLAGS_4(NAME, FLAGS, RET, T1, T2, T3, T4)            \
-    TCGHelperInfo glue(helper_info_, NAME) = {                          \
+    TCGHelperInfo HELPER_INFO(NAME) = {                                 \
         .func = HELPER(NAME), .name = str(NAME),                        \
         .flags = FLAGS | dh_callflag(RET),                              \
         .typemask = dh_typemask(RET, 0) | dh_typemask(T1, 1)            \
@@ -55,7 +55,7 @@
     };
 
 #define DEF_HELPER_FLAGS_5(NAME, FLAGS, RET, T1, T2, T3, T4, T5)        \
-    TCGHelperInfo glue(helper_info_, NAME) = {                          \
+    TCGHelperInfo HELPER_INFO(NAME) = {                                 \
         .func = HELPER(NAME), .name = str(NAME),                        \
         .flags = FLAGS | dh_callflag(RET),                              \
         .typemask = dh_typemask(RET, 0) | dh_typemask(T1, 1)            \
@@ -64,7 +64,7 @@
     };
 
 #define DEF_HELPER_FLAGS_6(NAME, FLAGS, RET, T1, T2, T3, T4, T5, T6)    \
-    TCGHelperInfo glue(helper_info_, NAME) = {                          \
+    TCGHelperInfo HELPER_INFO(NAME) = {                                 \
         .func = HELPER(NAME), .name = str(NAME),                        \
         .flags = FLAGS | dh_callflag(RET),                              \
         .typemask = dh_typemask(RET, 0) | dh_typemask(T1, 1)            \
@@ -74,7 +74,7 @@
     };
 
 #define DEF_HELPER_FLAGS_7(NAME, FLAGS, RET, T1, T2, T3, T4, T5, T6, T7) \
-    TCGHelperInfo glue(helper_info_, NAME) = {                          \
+    TCGHelperInfo HELPER_INFO(NAME) = {                                 \
         .func = HELPER(NAME), .name = str(NAME),                        \
         .flags = FLAGS | dh_callflag(RET),                              \
         .typemask = dh_typemask(RET, 0) | dh_typemask(T1, 1)            \
-- 
2.43.0


