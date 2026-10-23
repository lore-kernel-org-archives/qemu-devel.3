Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83295606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WUuBDKH+;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iWpx+tq6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKI1f-0003CS-E4; Fri, 23 Oct 2026 12:21:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKI1b-0002wM-FW
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:21:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKI1Y-00033p-Oc
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:21:47 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE5s9O4072757
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:21:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sQldV44I73JjgmYjMVE1gQAFJC6jiANA6oobIf4NEx0=; b=WUuBDKH+z20ehp6S
 0be4Z7nhjzLrlRzmMdiOlAtdWFwR+Q/7SuZTP7nf1/UQWbBwP4SGFkncY2M5LWA9
 nfFpzGdAsEB5Hii8BUIwRi8st1EFhrco0TeSFgHLKoygg7mVtpLjBIj/K3qUq0Dc
 jkkKJFQE9mlyKvsChd7st47MIJYjEtQ7m3EvwPKa/XACDwEpw7ikOjvWgX8U2rQu
 w2E7cLzXBbqQatp8Pe3+55YlBDuftSG7sKaH0W2TwBm9ayN56u367gAeYvoQoVrg
 3IAcuEq8RojOim5kKbGa+ZN8e+89jR/QEQYPiMhJFFW3IlLZM+dHpCmJS1g5EKPH
 PUfqjg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hg7bw0xmu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:21:40 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93cbf2fd504so196625285a.2
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772500; x=1793377300; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sQldV44I73JjgmYjMVE1gQAFJC6jiANA6oobIf4NEx0=;
 b=iWpx+tq676dmK4d3IW7Odx9pICdEmu/9IvO6YvEPu2KeRgwKcgKZ6vMEuK6owOdZuM
 M+ON2Nukmbv35AiMT7iBQqB9IUKjPlPlSDOWWJ3QjvCGduBSlp/xmFnad1/MHUxR/rza
 Z9PYsY/tF0SSzJR+0ut6G0Gb2bXq+eipCnWzKunM8ARk7K8gHJjxZNr7prMG3Uw3tkg8
 ut10rhUx1obg4biSFrMQA5xE+Rtb9EWi/WMYWPENaJPUbC75PCKYrOtuxd7RVDoOkPc6
 NoxaAAOdwHpINeADSKLF8R1TRiPNI2aA+JHSSEk+O24WWsPBwIJcplUWHrxgBmWA1DtH
 9kRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772500; x=1793377300;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sQldV44I73JjgmYjMVE1gQAFJC6jiANA6oobIf4NEx0=;
 b=X6A2HnDSXhNjK00Kv6msMN3FIlv6yJpsY0FbCGqxmMy2oVlL/agjGB5QZAwjwchPOW
 Xkcde6RthKpZcLCa21Ml4+4+w8XK6XnAfea5RqYci9cfXtOJuo1jGG5meuVRfyJS435e
 EZG/dNC8ATa6kYuRI80KHd7/2V10hPVRovYt0k56ofM018Q2NqoaL/dhTywUMDc8eLch
 bM5Ih9prL07IoKH3Q/dPCD4M4juXIXdsjfvd4C+xJXDsvO0qkRy0FQ7Va1Zh/xChsBi2
 IN/qIzBoYbB0LR1nngD3uka7viQy7L2sf1EqqAWNczBjREXtCmmd8JqGuoI3uIscUFkn
 5ogw==
X-Gm-Message-State: AFq9FYJBvJXRgJ5Fg3JRqpQSj44Qp4q8JW7J96PTbEaKMxb26LCnIaAp
 YtBhbQFk9b9iNMA9GGFCQbK0bo1FZvjAVab3E/xPkIKS/WfgcBjlJaNdswmiHunmFoXsKbs1qEg
 8E9SeTf4I9hc05XcM2ik3crHp631PEjrrG43JQP6+HkHB2U/Ym9bzGhIaS3H6XV8JHYoG
X-Gm-Gg: AYBFou1BkQOnzxEuzJu73BkXGhkeCWhiwy7eK8yoctuiKOiIbWC4Myyucfy8D58M3UN
 Xneh4lc8dmg0Xa5Tf7J0DEtsuhOpJmyUxvdKU7cz3SDaPSIrzSQor/9AZvjvHqc5xoPXnXsAzGp
 yd14emU4pqQTCy6QQqv9D6JcfuTKmz9K8v01ZmdCs33p3JZL/X7ZkbZJTiTaGAmfncx8hnpLwOP
 uKG69qVgHV7BIv+rQcH8+nvaVMVjzStf6RIf5vvGKAAEKg6vFieM6SpcYtriKVz96D02ptYa7j9
 yJi1eb409IuyRFpOSf4dSsqfCTnUz4bYQr9fbeXIm0EyNiJ1tu3sliKoJvau4a6yg2vlgByXPXD
 G+fdOmfIUWre9cvnTxckCg5jE+NOcuIwykV2sed+y
X-Received: by 2002:a05:620a:19a5:b0:93e:f5bd:7e13 with SMTP id
 af79cd13be357-93f6f8a3dfamr528181885a.64.1792772499712; 
 Fri, 23 Oct 2026 09:21:39 -0700 (PDT)
X-Received: by 2002:a05:620a:19a5:b0:93e:f5bd:7e13 with SMTP id
 af79cd13be357-93f6f8a3dfamr528175185a.64.1792772498948; 
 Fri, 23 Oct 2026 09:21:38 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d4104b5sm805362f8f.36.2026.10.23.09.21.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:21:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 67/83] target/microblaze: define and call helpers using HELPER
 macro
Date: Fri, 23 Oct 2026 18:13:15 +0200
Message-ID: <20261023161332.60153-68-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: rz5hjO73yBWvEief0U_NyvGgQ26O09I_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2NCBTYWx0ZWRfX5zoFu/PtPTE1
 qtdTPiwW9XNeNOWW2CJwe8vmWRi0r/9Ad1B6TydvrRss8xAnlD4bBMRLVxtrTTq80MJmgqsUQm1
 XG9GYG37wXnm838OdxuBENU9uvM1E6s=
X-Authority-Analysis: v=2.4 cv=QdTzLcbv c=1 sm=1 tr=0 ts=6adb8994 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=itqY9gs7vbMVEQc_hZoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: rz5hjO73yBWvEief0U_NyvGgQ26O09I_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2NCBTYWx0ZWRfXxpbOhD/+DmFd
 Eu88HLAEEa//S6gxdbchOI4XPWGo/cmuldoF88XAq8NQyHFhRu4g0yaTcBd+rXuIe5xHTcQWCxl
 w+RXpB6Yk53ewBjVL6G1p6VjIr3Ac2uyOvL4LB7kdKOSKkdmKNq4I3WQgucSV7JgOiUuYWJv6dP
 PLi4ScAE8m5RJPRgQdsu3i/jDOKyT+aTxp3RTD7H0d+xiTfAyuThZjUVghzEN04eLEZWQ6B2SuC
 NQfX4HUQ/yM/fNr9ZTd5sn3bS+3KGiiIwp0ITX03GH43IR7thqOt0EdtPlzjokHs4fxlrrDwKxd
 khGehnT1f95w7peh0TpBHiD0uV30ucfnAv1CAuOzmswM2JiAWg8i8ADeAj32oArMnJWJpa2bACs
 M9ATgFxoczaW5X14MCbuBMo/oAItYURQ8swUPxLvwMlcXlsllM+otgxSpBahJEO4Hx3RYh67P6N
 QACTUHMuxCwUi5MPJFg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230064
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
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

In a upcoming commit, we'll prefix all helpers and helper_info with target
prefix, to disambiguate symbols between targets. As a first step, we need to
make sure all usages are using the existing HELPER macro.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Acked-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-ID: <20261019212046.149572-9-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/microblaze/op_helper.c | 46 +++++++++++++++++------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index c169312e954..c53103ecd79 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -27,7 +27,7 @@
 #include "accel/tcg/cpu-loop.h"
 #include "fpu/softfloat.h"
 
-void helper_put(uint32_t id, uint32_t ctrl, uint32_t data)
+void HELPER(put)(uint32_t id, uint32_t ctrl, uint32_t data)
 {
     int test = ctrl & STREAM_TEST;
     int atomic = ctrl & STREAM_ATOMIC;
@@ -44,7 +44,7 @@ void helper_put(uint32_t id, uint32_t ctrl, uint32_t data)
              atomic ? "a" : "");
 }
 
-uint32_t helper_get(uint32_t id, uint32_t ctrl)
+uint32_t HELPER(get)(uint32_t id, uint32_t ctrl)
 {
     int test = ctrl & STREAM_TEST;
     int atomic = ctrl & STREAM_ATOMIC;
@@ -62,7 +62,7 @@ uint32_t helper_get(uint32_t id, uint32_t ctrl)
     return 0xdead0000 | id;
 }
 
-void helper_microblaze_raise_exception(CPUMBState *env, uint32_t index)
+void HELPER(microblaze_raise_exception)(CPUMBState *env, uint32_t index)
 {
     CPUState *cs = env_cpu(env);
 
@@ -84,7 +84,7 @@ static void raise_divzero(CPUMBState *env, uint32_t esr, uintptr_t unwind_pc)
     }
 }
 
-uint32_t helper_divs(CPUMBState *env, uint32_t ra, uint32_t rb)
+uint32_t HELPER(divs)(CPUMBState *env, uint32_t ra, uint32_t rb)
 {
     if (!ra) {
         raise_divzero(env, ESR_EC_DIVZERO, GETPC());
@@ -108,7 +108,7 @@ uint32_t helper_divs(CPUMBState *env, uint32_t ra, uint32_t rb)
     return (int32_t)rb / (int32_t)ra;
 }
 
-uint32_t helper_divu(CPUMBState *env, uint32_t ra, uint32_t rb)
+uint32_t HELPER(divu)(CPUMBState *env, uint32_t ra, uint32_t rb)
 {
     if (!ra) {
         raise_divzero(env, ESR_EC_DIVZERO, GETPC());
@@ -154,7 +154,7 @@ static void update_fpu_flags(CPUMBState *env, int flags, uintptr_t ra)
     }
 }
 
-uint32_t helper_microblaze_fadd(CPUMBState *env, uint32_t a, uint32_t b)
+uint32_t HELPER(microblaze_fadd)(CPUMBState *env, uint32_t a, uint32_t b)
 {
     CPU_FloatU fd, fa, fb;
     int flags;
@@ -169,7 +169,7 @@ uint32_t helper_microblaze_fadd(CPUMBState *env, uint32_t a, uint32_t b)
     return fd.l;
 }
 
-uint32_t helper_frsub(CPUMBState *env, uint32_t a, uint32_t b)
+uint32_t HELPER(frsub)(CPUMBState *env, uint32_t a, uint32_t b)
 {
     CPU_FloatU fd, fa, fb;
     int flags;
@@ -183,7 +183,7 @@ uint32_t helper_frsub(CPUMBState *env, uint32_t a, uint32_t b)
     return fd.l;
 }
 
-uint32_t helper_microblaze_fmul(CPUMBState *env, uint32_t a, uint32_t b)
+uint32_t HELPER(microblaze_fmul)(CPUMBState *env, uint32_t a, uint32_t b)
 {
     CPU_FloatU fd, fa, fb;
     int flags;
@@ -198,7 +198,7 @@ uint32_t helper_microblaze_fmul(CPUMBState *env, uint32_t a, uint32_t b)
     return fd.l;
 }
 
-uint32_t helper_microblaze_fdiv(CPUMBState *env, uint32_t a, uint32_t b)
+uint32_t HELPER(microblaze_fdiv)(CPUMBState *env, uint32_t a, uint32_t b)
 {
     CPU_FloatU fd, fa, fb;
     int flags;
@@ -213,7 +213,7 @@ uint32_t helper_microblaze_fdiv(CPUMBState *env, uint32_t a, uint32_t b)
     return fd.l;
 }
 
-uint32_t helper_fcmp_un(CPUMBState *env, uint32_t a, uint32_t b)
+uint32_t HELPER(fcmp_un)(CPUMBState *env, uint32_t a, uint32_t b)
 {
     CPU_FloatU fa, fb;
     uint32_t r = 0;
@@ -235,7 +235,7 @@ uint32_t helper_fcmp_un(CPUMBState *env, uint32_t a, uint32_t b)
     return r;
 }
 
-uint32_t helper_fcmp_lt(CPUMBState *env, uint32_t a, uint32_t b)
+uint32_t HELPER(fcmp_lt)(CPUMBState *env, uint32_t a, uint32_t b)
 {
     CPU_FloatU fa, fb;
     int r;
@@ -251,7 +251,7 @@ uint32_t helper_fcmp_lt(CPUMBState *env, uint32_t a, uint32_t b)
     return r;
 }
 
-uint32_t helper_fcmp_eq(CPUMBState *env, uint32_t a, uint32_t b)
+uint32_t HELPER(fcmp_eq)(CPUMBState *env, uint32_t a, uint32_t b)
 {
     CPU_FloatU fa, fb;
     int flags;
@@ -267,7 +267,7 @@ uint32_t helper_fcmp_eq(CPUMBState *env, uint32_t a, uint32_t b)
     return r;
 }
 
-uint32_t helper_fcmp_le(CPUMBState *env, uint32_t a, uint32_t b)
+uint32_t HELPER(fcmp_le)(CPUMBState *env, uint32_t a, uint32_t b)
 {
     CPU_FloatU fa, fb;
     int flags;
@@ -284,7 +284,7 @@ uint32_t helper_fcmp_le(CPUMBState *env, uint32_t a, uint32_t b)
     return r;
 }
 
-uint32_t helper_fcmp_gt(CPUMBState *env, uint32_t a, uint32_t b)
+uint32_t HELPER(fcmp_gt)(CPUMBState *env, uint32_t a, uint32_t b)
 {
     CPU_FloatU fa, fb;
     int flags, r;
@@ -298,7 +298,7 @@ uint32_t helper_fcmp_gt(CPUMBState *env, uint32_t a, uint32_t b)
     return r;
 }
 
-uint32_t helper_fcmp_ne(CPUMBState *env, uint32_t a, uint32_t b)
+uint32_t HELPER(fcmp_ne)(CPUMBState *env, uint32_t a, uint32_t b)
 {
     CPU_FloatU fa, fb;
     int flags, r;
@@ -313,7 +313,7 @@ uint32_t helper_fcmp_ne(CPUMBState *env, uint32_t a, uint32_t b)
     return r;
 }
 
-uint32_t helper_fcmp_ge(CPUMBState *env, uint32_t a, uint32_t b)
+uint32_t HELPER(fcmp_ge)(CPUMBState *env, uint32_t a, uint32_t b)
 {
     CPU_FloatU fa, fb;
     int flags, r;
@@ -328,7 +328,7 @@ uint32_t helper_fcmp_ge(CPUMBState *env, uint32_t a, uint32_t b)
     return r;
 }
 
-uint32_t helper_flt(CPUMBState *env, uint32_t a)
+uint32_t HELPER(flt)(CPUMBState *env, uint32_t a)
 {
     CPU_FloatU fd, fa;
 
@@ -337,7 +337,7 @@ uint32_t helper_flt(CPUMBState *env, uint32_t a)
     return fd.l;
 }
 
-uint32_t helper_fint(CPUMBState *env, uint32_t a)
+uint32_t HELPER(fint)(CPUMBState *env, uint32_t a)
 {
     CPU_FloatU fa;
     uint32_t r;
@@ -352,7 +352,7 @@ uint32_t helper_fint(CPUMBState *env, uint32_t a)
     return r;
 }
 
-uint32_t helper_microblaze_fsqrt(CPUMBState *env, uint32_t a)
+uint32_t HELPER(microblaze_fsqrt)(CPUMBState *env, uint32_t a)
 {
     CPU_FloatU fd, fa;
     int flags;
@@ -366,7 +366,7 @@ uint32_t helper_microblaze_fsqrt(CPUMBState *env, uint32_t a)
     return fd.l;
 }
 
-uint32_t helper_pcmpbf(uint32_t a, uint32_t b)
+uint32_t HELPER(pcmpbf)(uint32_t a, uint32_t b)
 {
     unsigned int i;
     uint32_t mask = 0xff000000;
@@ -379,7 +379,7 @@ uint32_t helper_pcmpbf(uint32_t a, uint32_t b)
     return 0;
 }
 
-void helper_stackprot(CPUMBState *env, uint32_t addr)
+void HELPER(stackprot)(CPUMBState *env, uint32_t addr)
 {
     if (addr < env->slr || addr > env->shr) {
         CPUState *cs = env_cpu(env);
@@ -399,12 +399,12 @@ void helper_stackprot(CPUMBState *env, uint32_t addr)
 #include "system/memory.h"
 
 /* Writes/reads to the MMU's special regs end up here.  */
-uint32_t helper_mmu_read(CPUMBState *env, uint32_t ext, uint32_t rn)
+uint32_t HELPER(mmu_read)(CPUMBState *env, uint32_t ext, uint32_t rn)
 {
     return mmu_read(env, ext, rn);
 }
 
-void helper_mmu_write(CPUMBState *env, uint32_t ext, uint32_t rn, uint32_t v)
+void HELPER(mmu_write)(CPUMBState *env, uint32_t ext, uint32_t rn, uint32_t v)
 {
     mmu_write(env, ext, rn, v);
 }
-- 
2.55.0


