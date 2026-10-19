Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A6B606A319
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dy5ZLp42;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HJjS8KYw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIunf-0001jd-23; Mon, 19 Oct 2026 17:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIunX-0001ir-RB
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:21:37 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIunV-0005iK-8h
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:21:35 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJK4Ee4106599
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:21:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=aIyw0npn8Fm
 o9DZWzTX9pphDUXr9yjx4PCtXUpvhyJA=; b=dy5ZLp425xqGSzrV/Oab7DC4pZw
 kVxRJOxXSKqAXEL04RCumD7NE8Sj8GFoUeHyeQtytbUFgSJEL+gVev544oFNt1sM
 3uNATxE78Tyn9jlCpbVJP2v8Jf6x4tLqyDy064NST1eknV3lKLd5LibIq/b8mN+Q
 Bc0hzAqNmcWDK4DYxeKzUapQZSrcVwkcEu93vInky0hrf7lyZ/AS/i2wPUnytNSv
 nXYSmtrfCBkYpWV8gtfr8FnRm3teoLkZClu/1Be6oqEC1dMA182XxQAE4Vbs/hGn
 jf288eGZP2vG+LnsdLdaIHdLLA9jZgi0Tu4iJ4l1kDZEZvcwKn3ot8qEDRg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdr780nud-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:21:22 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3a6d30f66c9so115790a91.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792444881; x=1793049681; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aIyw0npn8Fmo9DZWzTX9pphDUXr9yjx4PCtXUpvhyJA=;
 b=HJjS8KYwltRoMrDSQb0NA2LHV8QoSQypLWrg552vbCaCbncgXrapXbN/Gl0kmnI0X5
 oS3xVMATL6eEiW9vtJC3yizvpUOcvnZU78/kJezzdf8pG/EjxQwJXM1zqM5KMc/hQOIe
 o/UsAfuG1dnBTk9FIkzRoy1ZMcBi0tAT3H0OFmonmK6WihhEVnxhg3XCuSN2NW6Nw4pB
 NfFI6Sdf3Two7kFzz5vXgqGQdETg/kEbzUC/LaXqGlri1YAQwRijB/gOnKrNF/gbg8Wx
 5eBwCukx0YD3z4BATPKYU8QtQINxo06XoGz26jhJIzm8JE3dyl+GrfEZivFVN1/a20Ki
 iyzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792444881; x=1793049681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aIyw0npn8Fmo9DZWzTX9pphDUXr9yjx4PCtXUpvhyJA=;
 b=ZVXZ7HjFa5x2q6tF10nDZYQFHNtrvayBkp1rXiqUDaoq692E4bPsfO1l/oWiXH8yJi
 TT/OEGW3fmeSOpXbD1cCS3Z1+aO5g+WFjY4OBonY22FOsvsaZb1L97bDhZbwbqo/z49U
 jVe1YTIa5AWIUa5pMs8P9X3ag6RXWVaZ69TSHUCYjmwwq3oURJINmKCzjs0597sJEw5+
 vEqBo8q8uHAusgdwO9JL06fbyp++YRISYYJo7NsC2EOGJz46N79btFhyR+/Gh+jp5s4o
 TDs+voSWGfVaVRuSuQZ1KIos+X4yNX65RoYMkbTD0ebdcmidTZ3gojbN6sovJMm3ZMAG
 5K4g==
X-Gm-Message-State: AFq9FYIrrv+SVMaQwuUzvdzY0LihXYNAqo1esHZHnMwq1HhEaU+u+tSY
 83t5xidliFNbITEIO4MVMPOzQJV9qI0WUELhRKx0E0AG7U4ZfwqSViHKVOmIwzm+iGB+tez6BKe
 b+nHBP09T8WAGCfR2pr0Fj2LQ5YEd1GhmXNRGz8lIo7duavbN59afqb0q+oS6/jKsjw==
X-Gm-Gg: AYBFou3z3G5M883evknJ+ICZGLxmrpH7p9soMO4+pVsusiFoZTJX4Tbp12SlfuGTriy
 V58ZUtBhJPK46tIC6gLRhuzD7vPQeZzwTWROL69t7Wmc7vyhMGVuU4PhcivPl9fRFE/Ksm5QDwG
 S+Y2mzhzMrHxN/no3L/vW1pI40YoUaJjlQ/xvc0mR/w6NGUyOrI5pqJkP8Oi8/u7vZLD/FhLSCn
 CFtjVflL1D1JcKoGh+LJZ4YCBvq8hY/2YDHkS5Ywteds6T2w6qW0pAxDcprw7j0ZI1WVemXja70
 c1HZY2eHUg/5JbpUZcj+GpnW2ogO+F1+EmASMZWH8Ag4/JpkUwwT7tXknUkxXYbm0z72mGriL6z
 KnDqspxP5A6t7MrDBcKUf/HJiS9ziEAHBTHxGQV4+fT1HntbVPsbY1xwGpdYUxLo=
X-Received: by 2002:a17:90b:448e:b0:3a8:337d:228a with SMTP id
 98e67ed59e1d1-3ad64b90a7fmr168560a91.6.1792444881131; 
 Mon, 19 Oct 2026 14:21:21 -0700 (PDT)
X-Received: by 2002:a17:90b:448e:b0:3a8:337d:228a with SMTP id
 98e67ed59e1d1-3ad64b90a7fmr168547a91.6.1792444880583; 
 Mon, 19 Oct 2026 14:21:20 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad60ec4457sm863243a91.6.2026.10.19.14.21.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 14:21:19 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 18/26] tcg: introduce HELPER_INFO macro
Date: Mon, 19 Oct 2026 21:20:37 +0000
Message-ID: <20261019212046.149572-19-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfXyohym+KEPwJb
 WfSLuO2/vgC6WllMkhGvBT5plrSLslomx92MDgQmDTpSWXiMsw3AFjBvKyotqmReh7iylW7EJRX
 wFO6TC1bMcVhNoFxWVjEcwMLVun8R3D0Re5c2jZMj5tqNDv8eYwyNbVT0qVjZ0ntK1hc7H1AS8I
 DOU/my01ltWsiNYqRlzFEJ0Fh4fH981RHNHpYTBDniqYmcvjz4fKNCD9baZkfBFrs9IXM3rlG7i
 iuF6bi4Iyhe9Be3XMJUFRxMyQTPH9u98N/c8DQ9/YdvQuSxueTrgnZ8RYsw6OUcN4R61qIRj0Yt
 gYPgi2vMhN19gPJhSxxtMILqhlmn6LFQIW9dBiPRXSkBSJ+VsgTOSL0xDaxCFQ9jji5HsZSwYmf
 B9wBuPEyspqWCthq3mSIwelD4g8Mk1IQ5bzvLoN9ENu3RGz+MCbQzD9k/iIk34VDHmtFDTZb8/2
 VKSzNOWsECS4t4qSwXA==
X-Proofpoint-GUID: eMrfEDXTVmeW22laGjzDDj1mvyc5uk5M
X-Authority-Analysis: v=2.4 cv=LKnz05W9 c=1 sm=1 tr=0 ts=6ad689d2 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=ighA3CKJURImTjC3cZkA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfXz5qG4XnALf/w
 OEJtJXTIpoH9eu4Sr0/N6V3NKp3Ewq+Bnw7E6O0ZPHR63Kre7qNX1QAHysWiVJ8JGflWVeTQMqO
 aUBnntjbtm9qx6kHfUXc+jIc8xPQsaE=
X-Proofpoint-ORIG-GUID: eMrfEDXTVmeW22laGjzDDj1mvyc5uk5M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
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

In next commit, we'll prefix all helpers and helper_info with target
base architecture. Make sure helper_info symbol name is defined in a
single place before that.

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


