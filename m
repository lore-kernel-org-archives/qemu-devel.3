Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34AC606A321
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=H8NRfUbf;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=S+AGoMMF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIuno-0001ms-9Y; Mon, 19 Oct 2026 17:21:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIunP-0001hA-G0
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:21:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIunL-0005iI-7B
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:21:27 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JK7vlt2274642
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:21:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=98MMfnkwjNE
 RiOTxawxE7YvY39AYlElafolHsh63FAI=; b=H8NRfUbfYiB598gX5i1WFoYbDJD
 Vvh7R3wi8b6D2Y8qBAGa3rfATckOmeAwrZcBxcaoBZx9O9+RCAhFpiVFvTgLmI4k
 UW2ZbkL3U7im/EAFGU/q9MURSzQ0/M1H2TFuVQ0sPU19tC+HxIjHibN11n+B/LPS
 7QS6R2xUKUOiEaVCv4S5nR30o5J/Barx+mpcaEUCb1jQa7//ncQPOuJlGzrq/QQe
 cwTqoP1r1TaUqwXSAtXUTbitlCxVzw/oSmp9hiBs1vTXPa9OoNIEM49Vz4LesBLM
 IljovG3ce932otNKrqXoJ6qmOv0seu01cpNJWu/Ma3pdCeBVhfm+5xngkRg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf65kaj5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:21:21 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3ab9850456aso4058754a91.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792444881; x=1793049681; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=98MMfnkwjNERiOTxawxE7YvY39AYlElafolHsh63FAI=;
 b=S+AGoMMFZzWkHm86QW5ZnJA7h6JXqgDHDRwfUgphFR7ZSPtQISAw1gDQjahMELahfv
 qDPIMG4Bq7J47DZWERPYlfibFNVhfB51I/36RJcZnrWIutrFMQYsoc9zeat+qiAFpr50
 n/RJmFb1NWa3tbGwXdYnfm0CzPdpkBTlVywbOwxGX5Q5omm/fdmfNhw0be5PMTJNv5Cw
 QGs0FW1PkDIp7qeW7cam+cHqXMmU92+TynU0as035sDjok3IAgTwPRGW2O3Eq1j1WWxu
 brpQKecO6roPOyhkTPwsx+PKaZYVrNwR/86awW+RqYyc96dSkjUUXwQOFoTgAUu10GRu
 tZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792444881; x=1793049681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=98MMfnkwjNERiOTxawxE7YvY39AYlElafolHsh63FAI=;
 b=bnB1I3iYr+9j4P3pTZLOEnmI8i5wWUipk4JnmwFzVmKFprLkgAhXuxCEvMXT1DlGF+
 g9gm3H5dHmhW1yc1HyjBlgg60OawVKOankxTTnHEdd0V4JAK40H+ZTW1Aw/e+gSi4GpV
 xGzOqNhIaiU3H8J6vowXsXOb+5SHOWj1qHzwGFhESJ0Si297pZ5RrA68TDD+L4pM4Khb
 xuuOJ39Xve4hGByKV83umH0TpcTRw5L5IP+5hlcvxiFJiUjOuBAFp7nkSC/dTiUDpRwZ
 XRv2xmKED+pmLckkFWbeqRVA0WTp2KBneqwRfCE1TOTMhubK72Wb1MnCQz+WsEwR1+8W
 rUog==
X-Gm-Message-State: AFq9FYLmpm0JB1nvMsaouJW1Ua0RV/m0qWtpKMuYNmKSGChTdurilfli
 EDyPZS5NqiWb68gSLRr4Ptvat4dsyurG4trgXeYNegiDPnL6N8yHruSDtR0+ruZc9yubHgdvbte
 Pv9Lj1CawWZvWoE7rahqmkVeNHvH9M7I6fyn/2GvXsAAbgBf1PAXO2c+XcV4VKtN4vA==
X-Gm-Gg: AYBFou3rD47LeH10ajvbmMNxTdbBOVn+J68ji3M4Aro0OqnaSFB07YpY7vJLKt5zChW
 B7xsLcM8vlbVSxOdn5STAXHkQl8ntUaH+Urlx112aqRpZyHeLolkvlEIJXXnvBPyDwLNoaibfqv
 WpuH0LYMq0XB5XBhTDm7iwbDy6ZplkfVqMgceabK2W3/CYawOoQS4pe+WkDiQbQjWCapfW9uk01
 GBycrBvP0pJvq89UxhCcVMcqvuy8ed9EJYW1zr69E7ASXn8mGll0KTBlR3LZGbcD52a8+JrDn6R
 LdZtCEFETCxsMownX2uSEJuCZk8xZqQKm6bIVmY8wb7Sn72IBLmVP0rMSQNvpjURx0yH8eJ8W5f
 HBvgWow4fjr0COnI9RT97SptjtVjZwGbuc88cBy+olCYj4XT4s/jK2YNbHcRnN8Y=
X-Received: by 2002:a17:90b:582e:b0:3a8:211b:6c8c with SMTP id
 98e67ed59e1d1-3aceec731f8mr8269358a91.22.1792444880687; 
 Mon, 19 Oct 2026 14:21:20 -0700 (PDT)
X-Received: by 2002:a17:90b:582e:b0:3a8:211b:6c8c with SMTP id
 98e67ed59e1d1-3aceec731f8mr8269332a91.22.1792444879704; 
 Mon, 19 Oct 2026 14:21:19 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad60ec4457sm863243a91.6.2026.10.19.14.21.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 14:21:19 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 17/26] target/tricore: define and call helpers using HELPER
 macro
Date: Mon, 19 Oct 2026 21:20:36 +0000
Message-ID: <20261019212046.149572-18-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX+rTk/oJ66nxV
 TDV2z0DhB/Urb1+y7vyvAuoX1l+WLa3ExlhnUoUd28r/Oh382U2DTXDw1u/zVzR5pJjGGP3ag3D
 Kpd0fLXkCt1+UnH6FflzgOYdnY7ZEHI=
X-Proofpoint-ORIG-GUID: ZXuBcn1ytGT3kzI5mudsYcuec25G4Hke
X-Authority-Analysis: v=2.4 cv=Y5ptIReN c=1 sm=1 tr=0 ts=6ad689d1 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=eO6AAlOi-fcJYYpl75MA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX2cXJjh+qisAT
 wirwCOEdrSWpAuarMy3cUg3NXLiRHn3UoNynLLhL3cjnQgfVzwxw1wcmbzqjZXQIRfcAuBPQ2uQ
 6hTSjghG5OBPHSDmPlUIQkO9q6uvmHuProG0EJvvXO7V9T+coP3zI0K90BuTN8TP2zfhC0/1JbA
 ihA+PAaev3rFk5M043vUhIWKOA4Aey08O838gOECvdRcQ9GUt1NfSjku3jP/e4e5637qEc/tSVn
 L8kWcbBMscWTj5oXiGOTH6QH6S4y8r5bEtCQaVzED1AuTYgdeTC7hhvboZO/M4e+N7PJXn7YAPG
 LnOZkgL3YDE6RmmZ3+hkgWhXRvCycRJpnI7a+0l5/VbY6ozhP7/7MVUBixjV0fraFV6qyU/hK7s
 5kqSolbzxWZ4MJgqcTe/R6NDaKquo9h+SmOHWiE/pJ/9YyOxNzWMsjDTQic+8dFgf6sG55oFw/F
 Sfdv4YsdJQpt9lztrTA==
X-Proofpoint-GUID: ZXuBcn1ytGT3kzI5mudsYcuec25G4Hke
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190085
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

In a upcoming commit, we'll prefix all helpers and helper_info with target
prefix, to disambiguate symbols between targets. As a first step, we need to
make sure all usages are using the existing HELPER macro.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/tricore/fpu_helper.c |  32 +++---
 target/tricore/op_helper.c  | 220 ++++++++++++++++++------------------
 2 files changed, 126 insertions(+), 126 deletions(-)

diff --git a/target/tricore/fpu_helper.c b/target/tricore/fpu_helper.c
index fa268a8a6bc..9d323a9b664 100644
--- a/target/tricore/fpu_helper.c
+++ b/target/tricore/fpu_helper.c
@@ -118,7 +118,7 @@ static void f_update_psw_flags(CPUTriCoreState *env, uint8_t flags)
 }
 
 #define FADD_SUB(op)                                                           \
-uint32_t helper_tricore_f##op(CPUTriCoreState *env, uint32_t r1, uint32_t r2)  \
+uint32_t HELPER(tricore_f##op)(CPUTriCoreState *env, uint32_t r1, uint32_t r2) \
 {                                                                              \
     float32 arg1 = make_float32(r1);                                           \
     float32 arg2 = make_float32(r2);                                           \
@@ -144,7 +144,7 @@ uint32_t helper_tricore_f##op(CPUTriCoreState *env, uint32_t r1, uint32_t r2)  \
 FADD_SUB(add)
 FADD_SUB(sub)
 
-uint32_t helper_tricore_fmul(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint32_t HELPER(tricore_fmul)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     uint32_t flags;
     float32 arg1 = make_float32(r1);
@@ -203,7 +203,7 @@ static const uint8_t target_qseed_significand_table[128] = {
     14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2
 };
 
-uint32_t helper_qseed(CPUTriCoreState *env, uint32_t r1)
+uint32_t HELPER(qseed)(CPUTriCoreState *env, uint32_t r1)
 {
     uint32_t arg1, S, E, M, E_minus_one, m_idx;
     uint32_t new_E, new_M, new_S, result;
@@ -251,7 +251,7 @@ uint32_t helper_qseed(CPUTriCoreState *env, uint32_t r1)
     return (uint32_t) result;
 }
 
-uint32_t helper_tricore_fdiv(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint32_t HELPER(tricore_fdiv)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     uint32_t flags;
     float32 arg1 = make_float32(r1);
@@ -277,7 +277,7 @@ uint32_t helper_tricore_fdiv(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     return (uint32_t)f_result;
 }
 
-uint32_t helper_fmadd(CPUTriCoreState *env, uint32_t r1,
+uint32_t HELPER(fmadd)(CPUTriCoreState *env, uint32_t r1,
                       uint32_t r2, uint32_t r3)
 {
     uint32_t flags;
@@ -303,7 +303,7 @@ uint32_t helper_fmadd(CPUTriCoreState *env, uint32_t r1,
     return (uint32_t)f_result;
 }
 
-uint32_t helper_fmsub(CPUTriCoreState *env, uint32_t r1,
+uint32_t HELPER(fmsub)(CPUTriCoreState *env, uint32_t r1,
                       uint32_t r2, uint32_t r3)
 {
     uint32_t flags;
@@ -331,7 +331,7 @@ uint32_t helper_fmsub(CPUTriCoreState *env, uint32_t r1,
     return (uint32_t)f_result;
 }
 
-uint32_t helper_tricore_fcmp(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint32_t HELPER(tricore_fcmp)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     uint32_t result, flags;
     float32 arg1 = make_float32(r1);
@@ -354,7 +354,7 @@ uint32_t helper_tricore_fcmp(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     return result;
 }
 
-uint32_t helper_tricore_ftoi(CPUTriCoreState *env, uint32_t arg)
+uint32_t HELPER(tricore_ftoi)(CPUTriCoreState *env, uint32_t arg)
 {
     float32 f_arg = make_float32(arg);
     int32_t result, flags;
@@ -373,7 +373,7 @@ uint32_t helper_tricore_ftoi(CPUTriCoreState *env, uint32_t arg)
     return (uint32_t)result;
 }
 
-uint32_t helper_hptof(CPUTriCoreState *env, uint32_t arg)
+uint32_t HELPER(hptof)(CPUTriCoreState *env, uint32_t arg)
 {
     float16 f_arg = make_float16(arg);
     uint32_t result = 0;
@@ -409,7 +409,7 @@ uint32_t helper_hptof(CPUTriCoreState *env, uint32_t arg)
     return result;
 }
 
-uint32_t helper_ftohp(CPUTriCoreState *env, uint32_t arg)
+uint32_t HELPER(ftohp)(CPUTriCoreState *env, uint32_t arg)
 {
     float32 f_arg = make_float32(arg);
     uint32_t result = 0;
@@ -447,7 +447,7 @@ uint32_t helper_ftohp(CPUTriCoreState *env, uint32_t arg)
     return result;
 }
 
-uint32_t helper_tricore_itof(CPUTriCoreState *env, uint32_t arg)
+uint32_t HELPER(tricore_itof)(CPUTriCoreState *env, uint32_t arg)
 {
     float32 f_result;
     uint32_t flags;
@@ -462,7 +462,7 @@ uint32_t helper_tricore_itof(CPUTriCoreState *env, uint32_t arg)
     return (uint32_t)f_result;
 }
 
-uint32_t helper_utof(CPUTriCoreState *env, uint32_t arg)
+uint32_t HELPER(utof)(CPUTriCoreState *env, uint32_t arg)
 {
     float32 f_result;
     uint32_t flags;
@@ -478,7 +478,7 @@ uint32_t helper_utof(CPUTriCoreState *env, uint32_t arg)
     return (uint32_t)f_result;
 }
 
-uint32_t helper_ftoiz(CPUTriCoreState *env, uint32_t arg)
+uint32_t HELPER(ftoiz)(CPUTriCoreState *env, uint32_t arg)
 {
     float32 f_arg = make_float32(arg);
     uint32_t result;
@@ -503,7 +503,7 @@ uint32_t helper_ftoiz(CPUTriCoreState *env, uint32_t arg)
     return result;
 }
 
-uint32_t helper_ftou(CPUTriCoreState *env, uint32_t arg)
+uint32_t HELPER(ftou)(CPUTriCoreState *env, uint32_t arg)
 {
     float32 f_arg = make_float32(arg);
     uint32_t result;
@@ -535,7 +535,7 @@ uint32_t helper_ftou(CPUTriCoreState *env, uint32_t arg)
     return result;
 }
 
-uint32_t helper_ftouz(CPUTriCoreState *env, uint32_t arg)
+uint32_t HELPER(ftouz)(CPUTriCoreState *env, uint32_t arg)
 {
     float32 f_arg = make_float32(arg);
     uint32_t result;
@@ -567,7 +567,7 @@ uint32_t helper_ftouz(CPUTriCoreState *env, uint32_t arg)
     return result;
 }
 
-void helper_updfl(CPUTriCoreState *env, uint32_t arg)
+void HELPER(updfl)(CPUTriCoreState *env, uint32_t arg)
 {
     env->FPU_FS =  extract32(arg, 7, 1) & extract32(arg, 15, 1);
     env->FPU_FI = (extract32(arg, 6, 1) & extract32(arg, 14, 1)) << 31;
diff --git a/target/tricore/op_helper.c b/target/tricore/op_helper.c
index 46b17da2bc6..53837ed351f 100644
--- a/target/tricore/op_helper.c
+++ b/target/tricore/op_helper.c
@@ -43,7 +43,7 @@ void raise_exception_sync_internal(CPUTriCoreState *env, uint32_t class, int tin
     if (class == TRAPC_CTX_MNG && tin == TIN3_FCU) {
         /* upper context cannot be saved, if the context list is empty */
     } else {
-        helper_svucx(env);
+        HELPER(svucx)(env);
     }
 
     /* The return address in a[11] is updated */
@@ -99,7 +99,7 @@ void raise_exception_sync_internal(CPUTriCoreState *env, uint32_t class, int tin
     cpu_loop_exit(cs);
 }
 
-void helper_raise_exception_sync(CPUTriCoreState *env, uint32_t class,
+void HELPER(raise_exception_sync)(CPUTriCoreState *env, uint32_t class,
                                  uint32_t tin)
 {
     raise_exception_sync_internal(env, class, tin, 0, 0);
@@ -126,7 +126,7 @@ static uint16_t reverse16(uint16_t val)
     return (rh << 8) | rl;
 }
 
-uint32_t helper_br_update(uint32_t reg)
+uint32_t HELPER(br_update)(uint32_t reg)
 {
     uint32_t index = reg & 0xffff;
     uint32_t incr  = reg >> 16;
@@ -134,7 +134,7 @@ uint32_t helper_br_update(uint32_t reg)
     return reg - index + new_index;
 }
 
-uint32_t helper_circ_update(uint32_t reg, uint32_t off)
+uint32_t HELPER(circ_update)(uint32_t reg, uint32_t off)
 {
     uint32_t index = reg & 0xffff;
     uint32_t length = reg >> 16;
@@ -266,7 +266,7 @@ static uint32_t suov16(CPUTriCoreState *env, int32_t hw0, int32_t hw1)
     return (hw0 & 0xffff) | (hw1 << 16);
 }
 
-uint32_t helper_add_ssov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint32_t HELPER(add_ssov)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     int64_t t1 = sextract64(r1, 0, 32);
     int64_t t2 = sextract64(r2, 0, 32);
@@ -274,7 +274,7 @@ uint32_t helper_add_ssov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     return ssov32(env, result);
 }
 
-uint64_t helper_add64_ssov(CPUTriCoreState *env, uint64_t r1, uint64_t r2)
+uint64_t HELPER(add64_ssov)(CPUTriCoreState *env, uint64_t r1, uint64_t r2)
 {
     uint64_t result;
     int64_t ovf;
@@ -299,7 +299,7 @@ uint64_t helper_add64_ssov(CPUTriCoreState *env, uint64_t r1, uint64_t r2)
     return result;
 }
 
-uint32_t helper_add_h_ssov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint32_t HELPER(add_h_ssov)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     int32_t ret_hw0, ret_hw1;
 
@@ -308,7 +308,7 @@ uint32_t helper_add_h_ssov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     return ssov16(env, ret_hw0, ret_hw1);
 }
 
-uint32_t helper_addr_h_ssov(CPUTriCoreState *env, uint64_t r1, uint32_t r2_l,
+uint32_t HELPER(addr_h_ssov)(CPUTriCoreState *env, uint64_t r1, uint32_t r2_l,
                             uint32_t r2_h)
 {
     int64_t mul_res0 = sextract64(r1, 0, 32);
@@ -354,7 +354,7 @@ uint32_t helper_addr_h_ssov(CPUTriCoreState *env, uint64_t r1, uint32_t r2_l,
     return (result1 & 0xffff0000ULL) | ((result0 >> 16) & 0xffffULL);
 }
 
-uint32_t helper_addsur_h_ssov(CPUTriCoreState *env, uint64_t r1, uint32_t r2_l,
+uint32_t HELPER(addsur_h_ssov)(CPUTriCoreState *env, uint64_t r1, uint32_t r2_l,
                               uint32_t r2_h)
 {
     int64_t mul_res0 = sextract64(r1, 0, 32);
@@ -401,7 +401,7 @@ uint32_t helper_addsur_h_ssov(CPUTriCoreState *env, uint64_t r1, uint32_t r2_l,
 }
 
 
-uint32_t helper_add_suov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint32_t HELPER(add_suov)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     int64_t t1 = extract64(r1, 0, 32);
     int64_t t2 = extract64(r2, 0, 32);
@@ -409,7 +409,7 @@ uint32_t helper_add_suov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     return suov32_pos(env, result);
 }
 
-uint32_t helper_add_h_suov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint32_t HELPER(add_h_suov)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     int32_t ret_hw0, ret_hw1;
 
@@ -418,7 +418,7 @@ uint32_t helper_add_h_suov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     return suov16(env, ret_hw0, ret_hw1);
 }
 
-uint32_t helper_sub_ssov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint32_t HELPER(sub_ssov)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     int64_t t1 = sextract64(r1, 0, 32);
     int64_t t2 = sextract64(r2, 0, 32);
@@ -426,7 +426,7 @@ uint32_t helper_sub_ssov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     return ssov32(env, result);
 }
 
-uint64_t helper_sub64_ssov(CPUTriCoreState *env, uint64_t r1, uint64_t r2)
+uint64_t HELPER(sub64_ssov)(CPUTriCoreState *env, uint64_t r1, uint64_t r2)
 {
     uint64_t result;
     int64_t ovf;
@@ -451,7 +451,7 @@ uint64_t helper_sub64_ssov(CPUTriCoreState *env, uint64_t r1, uint64_t r2)
     return result;
 }
 
-uint32_t helper_sub_h_ssov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint32_t HELPER(sub_h_ssov)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     int32_t ret_hw0, ret_hw1;
 
@@ -460,7 +460,7 @@ uint32_t helper_sub_h_ssov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     return ssov16(env, ret_hw0, ret_hw1);
 }
 
-uint32_t helper_subr_h_ssov(CPUTriCoreState *env, uint64_t r1, uint32_t r2_l,
+uint32_t HELPER(subr_h_ssov)(CPUTriCoreState *env, uint64_t r1, uint32_t r2_l,
                             uint32_t r2_h)
 {
     int64_t mul_res0 = sextract64(r1, 0, 32);
@@ -506,7 +506,7 @@ uint32_t helper_subr_h_ssov(CPUTriCoreState *env, uint64_t r1, uint32_t r2_l,
     return (result1 & 0xffff0000ULL) | ((result0 >> 16) & 0xffffULL);
 }
 
-uint32_t helper_subadr_h_ssov(CPUTriCoreState *env, uint64_t r1, uint32_t r2_l,
+uint32_t HELPER(subadr_h_ssov)(CPUTriCoreState *env, uint64_t r1, uint32_t r2_l,
                               uint32_t r2_h)
 {
     int64_t mul_res0 = sextract64(r1, 0, 32);
@@ -552,7 +552,7 @@ uint32_t helper_subadr_h_ssov(CPUTriCoreState *env, uint64_t r1, uint32_t r2_l,
     return (result1 & 0xffff0000ULL) | ((result0 >> 16) & 0xffffULL);
 }
 
-uint32_t helper_sub_suov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint32_t HELPER(sub_suov)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     int64_t t1 = extract64(r1, 0, 32);
     int64_t t2 = extract64(r2, 0, 32);
@@ -560,7 +560,7 @@ uint32_t helper_sub_suov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     return suov32_neg(env, result);
 }
 
-uint32_t helper_sub_h_suov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint32_t HELPER(sub_h_suov)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     int32_t ret_hw0, ret_hw1;
 
@@ -569,7 +569,7 @@ uint32_t helper_sub_h_suov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     return suov16(env, ret_hw0, ret_hw1);
 }
 
-uint32_t helper_mul_ssov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint32_t HELPER(mul_ssov)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     int64_t t1 = sextract64(r1, 0, 32);
     int64_t t2 = sextract64(r2, 0, 32);
@@ -577,7 +577,7 @@ uint32_t helper_mul_ssov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     return ssov32(env, result);
 }
 
-uint32_t helper_mul_suov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint32_t HELPER(mul_suov)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     int64_t t1 = extract64(r1, 0, 32);
     int64_t t2 = extract64(r2, 0, 32);
@@ -586,7 +586,7 @@ uint32_t helper_mul_suov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     return suov32_pos(env, result);
 }
 
-uint32_t helper_sha_ssov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint32_t HELPER(sha_ssov)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     int64_t t1 = sextract64(r1, 0, 32);
     int32_t t2 = sextract64(r2, 0, 6);
@@ -601,14 +601,14 @@ uint32_t helper_sha_ssov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     return ssov32(env, result);
 }
 
-uint32_t helper_abs_ssov(CPUTriCoreState *env, uint32_t r1)
+uint32_t HELPER(abs_ssov)(CPUTriCoreState *env, uint32_t r1)
 {
     uint32_t result;
     result = ((int32_t)r1 >= 0) ? r1 : (0 - r1);
     return ssov32(env, result);
 }
 
-uint32_t helper_abs_h_ssov(CPUTriCoreState *env, uint32_t r1)
+uint32_t HELPER(abs_h_ssov)(CPUTriCoreState *env, uint32_t r1)
 {
     int32_t ret_h0, ret_h1;
 
@@ -621,7 +621,7 @@ uint32_t helper_abs_h_ssov(CPUTriCoreState *env, uint32_t r1)
     return ssov16(env, ret_h0, ret_h1);
 }
 
-uint32_t helper_absdif_ssov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint32_t HELPER(absdif_ssov)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     int64_t t1 = sextract64(r1, 0, 32);
     int64_t t2 = sextract64(r2, 0, 32);
@@ -635,7 +635,7 @@ uint32_t helper_absdif_ssov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     return ssov32(env, result);
 }
 
-uint32_t helper_absdif_h_ssov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint32_t HELPER(absdif_h_ssov)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     int32_t t1, t2;
     int32_t ret_h0, ret_h1;
@@ -659,7 +659,7 @@ uint32_t helper_absdif_h_ssov(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     return ssov16(env, ret_h0, ret_h1);
 }
 
-uint32_t helper_madd32_ssov(CPUTriCoreState *env, uint32_t r1,
+uint32_t HELPER(madd32_ssov)(CPUTriCoreState *env, uint32_t r1,
                             uint32_t r2, uint32_t r3)
 {
     int64_t t1 = sextract64(r1, 0, 32);
@@ -671,7 +671,7 @@ uint32_t helper_madd32_ssov(CPUTriCoreState *env, uint32_t r1,
     return ssov32(env, result);
 }
 
-uint32_t helper_madd32_suov(CPUTriCoreState *env, uint32_t r1,
+uint32_t HELPER(madd32_suov)(CPUTriCoreState *env, uint32_t r1,
                             uint32_t r2, uint32_t r3)
 {
     uint64_t t1 = extract64(r1, 0, 32);
@@ -683,7 +683,7 @@ uint32_t helper_madd32_suov(CPUTriCoreState *env, uint32_t r1,
     return suov32_pos(env, result);
 }
 
-uint64_t helper_madd64_ssov(CPUTriCoreState *env, uint32_t r1,
+uint64_t HELPER(madd64_ssov)(CPUTriCoreState *env, uint32_t r1,
                             uint64_t r2, uint32_t r3)
 {
     uint64_t ret, ovf;
@@ -717,7 +717,7 @@ uint64_t helper_madd64_ssov(CPUTriCoreState *env, uint32_t r1,
 }
 
 uint32_t
-helper_madd32_q_add_ssov(CPUTriCoreState *env, uint64_t r1, uint64_t r2)
+HELPER(madd32_q_add_ssov)(CPUTriCoreState *env, uint64_t r1, uint64_t r2)
 {
     int64_t result;
 
@@ -757,7 +757,7 @@ helper_madd32_q_add_ssov(CPUTriCoreState *env, uint64_t r1, uint64_t r2)
     return (uint32_t)result;
 }
 
-uint64_t helper_madd64_q_ssov(CPUTriCoreState *env, uint64_t r1, uint32_t r2,
+uint64_t HELPER(madd64_q_ssov)(CPUTriCoreState *env, uint64_t r1, uint32_t r2,
                               uint32_t r3, uint32_t n)
 {
     int64_t t1 = (int64_t)r1;
@@ -808,7 +808,7 @@ uint64_t helper_madd64_q_ssov(CPUTriCoreState *env, uint64_t r1, uint32_t r2,
     return (uint64_t)result;
 }
 
-uint32_t helper_maddr_q_ssov(CPUTriCoreState *env, uint32_t r1, uint32_t r2,
+uint32_t HELPER(maddr_q_ssov)(CPUTriCoreState *env, uint32_t r1, uint32_t r2,
                              uint32_t r3, uint32_t n)
 {
     int64_t t1 = sextract64(r1, 0, 32);
@@ -841,7 +841,7 @@ uint32_t helper_maddr_q_ssov(CPUTriCoreState *env, uint32_t r1, uint32_t r2,
     return ret & 0xffff0000ll;
 }
 
-uint64_t helper_madd64_suov(CPUTriCoreState *env, uint32_t r1,
+uint64_t HELPER(madd64_suov)(CPUTriCoreState *env, uint32_t r1,
                             uint64_t r2, uint32_t r3)
 {
     uint64_t ret, mul;
@@ -866,7 +866,7 @@ uint64_t helper_madd64_suov(CPUTriCoreState *env, uint32_t r1,
     return ret;
 }
 
-uint32_t helper_msub32_ssov(CPUTriCoreState *env, uint32_t r1,
+uint32_t HELPER(msub32_ssov)(CPUTriCoreState *env, uint32_t r1,
                             uint32_t r2, uint32_t r3)
 {
     int64_t t1 = sextract64(r1, 0, 32);
@@ -878,7 +878,7 @@ uint32_t helper_msub32_ssov(CPUTriCoreState *env, uint32_t r1,
     return ssov32(env, result);
 }
 
-uint32_t helper_msub32_suov(CPUTriCoreState *env, uint32_t r1,
+uint32_t HELPER(msub32_suov)(CPUTriCoreState *env, uint32_t r1,
                             uint32_t r2, uint32_t r3)
 {
     uint64_t t1 = extract64(r1, 0, 32);
@@ -905,7 +905,7 @@ uint32_t helper_msub32_suov(CPUTriCoreState *env, uint32_t r1,
     return result;
 }
 
-uint64_t helper_msub64_ssov(CPUTriCoreState *env, uint32_t r1,
+uint64_t HELPER(msub64_ssov)(CPUTriCoreState *env, uint32_t r1,
                             uint64_t r2, uint32_t r3)
 {
     uint64_t ret, ovf;
@@ -937,7 +937,7 @@ uint64_t helper_msub64_ssov(CPUTriCoreState *env, uint32_t r1,
     return ret;
 }
 
-uint64_t helper_msub64_suov(CPUTriCoreState *env, uint32_t r1,
+uint64_t HELPER(msub64_suov)(CPUTriCoreState *env, uint32_t r1,
                             uint64_t r2, uint32_t r3)
 {
     uint64_t ret, mul;
@@ -963,7 +963,7 @@ uint64_t helper_msub64_suov(CPUTriCoreState *env, uint32_t r1,
 }
 
 uint32_t
-helper_msub32_q_sub_ssov(CPUTriCoreState *env, uint64_t r1, uint64_t r2)
+HELPER(msub32_q_sub_ssov)(CPUTriCoreState *env, uint64_t r1, uint64_t r2)
 {
     int64_t result;
     int64_t t1 = (int64_t)r1;
@@ -1005,7 +1005,7 @@ helper_msub32_q_sub_ssov(CPUTriCoreState *env, uint64_t r1, uint64_t r2)
     return (uint32_t)result;
 }
 
-uint64_t helper_msub64_q_ssov(CPUTriCoreState *env, uint64_t r1, uint32_t r2,
+uint64_t HELPER(msub64_q_ssov)(CPUTriCoreState *env, uint64_t r1, uint32_t r2,
                               uint32_t r3, uint32_t n)
 {
     int64_t t1 = (int64_t)r1;
@@ -1057,7 +1057,7 @@ uint64_t helper_msub64_q_ssov(CPUTriCoreState *env, uint64_t r1, uint32_t r2,
     return (uint64_t)result;
 }
 
-uint32_t helper_msubr_q_ssov(CPUTriCoreState *env, uint32_t r1, uint32_t r2,
+uint32_t HELPER(msubr_q_ssov)(CPUTriCoreState *env, uint32_t r1, uint32_t r2,
                              uint32_t r3, uint32_t n)
 {
     int64_t t1 = sextract64(r1, 0, 32);
@@ -1090,7 +1090,7 @@ uint32_t helper_msubr_q_ssov(CPUTriCoreState *env, uint32_t r1, uint32_t r2,
     return ret & 0xffff0000ll;
 }
 
-uint32_t helper_abs_b(CPUTriCoreState *env, uint32_t arg)
+uint32_t HELPER(abs_b)(CPUTriCoreState *env, uint32_t arg)
 {
     int32_t b, i;
     int32_t ovf = 0;
@@ -1113,7 +1113,7 @@ uint32_t helper_abs_b(CPUTriCoreState *env, uint32_t arg)
     return ret;
 }
 
-uint32_t helper_abs_h(CPUTriCoreState *env, uint32_t arg)
+uint32_t HELPER(abs_h)(CPUTriCoreState *env, uint32_t arg)
 {
     int32_t h, i;
     int32_t ovf = 0;
@@ -1136,7 +1136,7 @@ uint32_t helper_abs_h(CPUTriCoreState *env, uint32_t arg)
     return ret;
 }
 
-uint32_t helper_absdif_b(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint32_t HELPER(absdif_b)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     int32_t b, i;
     int32_t extr_r2;
@@ -1160,7 +1160,7 @@ uint32_t helper_absdif_b(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     return ret;
 }
 
-uint32_t helper_absdif_h(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint32_t HELPER(absdif_h)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     int32_t h, i;
     int32_t extr_r2;
@@ -1185,7 +1185,7 @@ uint32_t helper_absdif_h(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     return ret;
 }
 
-uint32_t helper_addr_h(CPUTriCoreState *env, uint64_t r1, uint32_t r2_l,
+uint32_t HELPER(addr_h)(CPUTriCoreState *env, uint64_t r1, uint32_t r2_l,
                        uint32_t r2_h)
 {
     int64_t mul_res0 = sextract64(r1, 0, 32);
@@ -1223,7 +1223,7 @@ uint32_t helper_addr_h(CPUTriCoreState *env, uint64_t r1, uint32_t r2_l,
     return (result1 & 0xffff0000ULL) | ((result0 >> 16) & 0xffffULL);
 }
 
-uint32_t helper_addsur_h(CPUTriCoreState *env, uint64_t r1, uint32_t r2_l,
+uint32_t HELPER(addsur_h)(CPUTriCoreState *env, uint64_t r1, uint32_t r2_l,
                          uint32_t r2_h)
 {
     int64_t mul_res0 = sextract64(r1, 0, 32);
@@ -1261,7 +1261,7 @@ uint32_t helper_addsur_h(CPUTriCoreState *env, uint64_t r1, uint32_t r2_l,
     return (result1 & 0xffff0000ULL) | ((result0 >> 16) & 0xffffULL);
 }
 
-uint32_t helper_maddr_q(CPUTriCoreState *env, uint32_t r1, uint32_t r2,
+uint32_t HELPER(maddr_q)(CPUTriCoreState *env, uint32_t r1, uint32_t r2,
                         uint32_t r3, uint32_t n)
 {
     int64_t t1 = sextract64(r1, 0, 32);
@@ -1289,7 +1289,7 @@ uint32_t helper_maddr_q(CPUTriCoreState *env, uint32_t r1, uint32_t r2,
     return ret & 0xffff0000ll;
 }
 
-uint32_t helper_add_b(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint32_t HELPER(add_b)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     int32_t b, i;
     int32_t extr_r1, extr_r2;
@@ -1315,7 +1315,7 @@ uint32_t helper_add_b(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     return ret;
 }
 
-uint32_t helper_add_h(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint32_t HELPER(add_h)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     int32_t h, i;
     int32_t extr_r1, extr_r2;
@@ -1340,7 +1340,7 @@ uint32_t helper_add_h(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     return ret;
 }
 
-uint32_t helper_subr_h(CPUTriCoreState *env, uint64_t r1, uint32_t r2_l,
+uint32_t HELPER(subr_h)(CPUTriCoreState *env, uint64_t r1, uint32_t r2_l,
                        uint32_t r2_h)
 {
     int64_t mul_res0 = sextract64(r1, 0, 32);
@@ -1378,7 +1378,7 @@ uint32_t helper_subr_h(CPUTriCoreState *env, uint64_t r1, uint32_t r2_l,
     return (result1 & 0xffff0000ULL) | ((result0 >> 16) & 0xffffULL);
 }
 
-uint32_t helper_subadr_h(CPUTriCoreState *env, uint64_t r1, uint32_t r2_l,
+uint32_t HELPER(subadr_h)(CPUTriCoreState *env, uint64_t r1, uint32_t r2_l,
                          uint32_t r2_h)
 {
     int64_t mul_res0 = sextract64(r1, 0, 32);
@@ -1416,7 +1416,7 @@ uint32_t helper_subadr_h(CPUTriCoreState *env, uint64_t r1, uint32_t r2_l,
     return (result1 & 0xffff0000ULL) | ((result0 >> 16) & 0xffffULL);
 }
 
-uint32_t helper_msubr_q(CPUTriCoreState *env, uint32_t r1, uint32_t r2,
+uint32_t HELPER(msubr_q)(CPUTriCoreState *env, uint32_t r1, uint32_t r2,
                         uint32_t r3, uint32_t n)
 {
     int64_t t1 = sextract64(r1, 0, 32);
@@ -1444,7 +1444,7 @@ uint32_t helper_msubr_q(CPUTriCoreState *env, uint32_t r1, uint32_t r2,
     return ret & 0xffff0000ll;
 }
 
-uint32_t helper_sub_b(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint32_t HELPER(sub_b)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     int32_t b, i;
     int32_t extr_r1, extr_r2;
@@ -1470,7 +1470,7 @@ uint32_t helper_sub_b(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     return ret;
 }
 
-uint32_t helper_sub_h(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint32_t HELPER(sub_h)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     int32_t h, i;
     int32_t extr_r1, extr_r2;
@@ -1495,7 +1495,7 @@ uint32_t helper_sub_h(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     return ret;
 }
 
-uint32_t helper_eq_b(uint32_t r1, uint32_t r2)
+uint32_t HELPER(eq_b)(uint32_t r1, uint32_t r2)
 {
     uint32_t ret, msk;
     int32_t i;
@@ -1512,7 +1512,7 @@ uint32_t helper_eq_b(uint32_t r1, uint32_t r2)
     return ret;
 }
 
-uint32_t helper_eq_h(uint32_t r1, uint32_t r2)
+uint32_t HELPER(eq_h)(uint32_t r1, uint32_t r2)
 {
     int32_t ret = 0;
 
@@ -1527,7 +1527,7 @@ uint32_t helper_eq_h(uint32_t r1, uint32_t r2)
     return ret;
 }
 
-uint32_t helper_eqany_b(uint32_t r1, uint32_t r2)
+uint32_t HELPER(eqany_b)(uint32_t r1, uint32_t r2)
 {
     int32_t i;
     uint32_t ret = 0;
@@ -1539,7 +1539,7 @@ uint32_t helper_eqany_b(uint32_t r1, uint32_t r2)
     return ret;
 }
 
-uint32_t helper_eqany_h(uint32_t r1, uint32_t r2)
+uint32_t HELPER(eqany_h)(uint32_t r1, uint32_t r2)
 {
     uint32_t ret;
 
@@ -1549,7 +1549,7 @@ uint32_t helper_eqany_h(uint32_t r1, uint32_t r2)
     return ret;
 }
 
-uint32_t helper_lt_b(uint32_t r1, uint32_t r2)
+uint32_t HELPER(lt_b)(uint32_t r1, uint32_t r2)
 {
     int32_t i;
     uint32_t ret = 0;
@@ -1563,7 +1563,7 @@ uint32_t helper_lt_b(uint32_t r1, uint32_t r2)
     return ret;
 }
 
-uint32_t helper_lt_bu(uint32_t r1, uint32_t r2)
+uint32_t HELPER(lt_bu)(uint32_t r1, uint32_t r2)
 {
     int32_t i;
     uint32_t ret = 0;
@@ -1577,7 +1577,7 @@ uint32_t helper_lt_bu(uint32_t r1, uint32_t r2)
     return ret;
 }
 
-uint32_t helper_lt_h(uint32_t r1, uint32_t r2)
+uint32_t HELPER(lt_h)(uint32_t r1, uint32_t r2)
 {
     uint32_t ret = 0;
 
@@ -1592,7 +1592,7 @@ uint32_t helper_lt_h(uint32_t r1, uint32_t r2)
     return ret;
 }
 
-uint32_t helper_lt_hu(uint32_t r1, uint32_t r2)
+uint32_t HELPER(lt_hu)(uint32_t r1, uint32_t r2)
 {
     uint32_t ret = 0;
 
@@ -1608,7 +1608,7 @@ uint32_t helper_lt_hu(uint32_t r1, uint32_t r2)
 }
 
 #define EXTREMA_H_B(name, op)                                 \
-uint32_t helper_##name ##_b(uint32_t r1, uint32_t r2)         \
+uint32_t HELPER(name ##_b)(uint32_t r1, uint32_t r2)          \
 {                                                             \
     int32_t i, extr_r1, extr_r2;                              \
     uint32_t ret = 0;                                         \
@@ -1622,7 +1622,7 @@ uint32_t helper_##name ##_b(uint32_t r1, uint32_t r2)         \
     return ret;                                               \
 }                                                             \
                                                               \
-uint32_t helper_##name ##_bu(uint32_t r1, uint32_t r2)        \
+uint32_t HELPER(name ##_bu)(uint32_t r1, uint32_t r2)         \
 {                                                             \
     int32_t i;                                                \
     uint32_t extr_r1, extr_r2;                                \
@@ -1637,7 +1637,7 @@ uint32_t helper_##name ##_bu(uint32_t r1, uint32_t r2)        \
     return ret;                                               \
 }                                                             \
                                                               \
-uint32_t helper_##name ##_h(uint32_t r1, uint32_t r2)         \
+uint32_t HELPER(name ##_h)(uint32_t r1, uint32_t r2)          \
 {                                                             \
     int32_t extr_r1, extr_r2;                                 \
     uint32_t ret = 0;                                         \
@@ -1655,7 +1655,7 @@ uint32_t helper_##name ##_h(uint32_t r1, uint32_t r2)         \
     return ret;                                               \
 }                                                             \
                                                               \
-uint32_t helper_##name ##_hu(uint32_t r1, uint32_t r2)        \
+uint32_t HELPER(name ##_hu)(uint32_t r1, uint32_t r2)         \
 {                                                             \
     uint32_t extr_r1, extr_r2;                                \
     uint32_t ret = 0;                                         \
@@ -1673,7 +1673,7 @@ uint32_t helper_##name ##_hu(uint32_t r1, uint32_t r2)        \
     return ret;                                               \
 }                                                             \
                                                               \
-uint64_t helper_ix##name(uint64_t r1, uint32_t r2)            \
+uint64_t HELPER(ix##name)(uint64_t r1, uint32_t r2)           \
 {                                                             \
     int64_t r2l, r2h, r1hl;                                   \
     uint64_t ret = 0;                                         \
@@ -1695,7 +1695,7 @@ uint64_t helper_ix##name(uint64_t r1, uint32_t r2)            \
     return ret;                                               \
 }                                                             \
                                                               \
-uint64_t helper_ix##name ##_u(uint64_t r1, uint32_t r2)       \
+uint64_t HELPER(ix##name ##_u)(uint64_t r1, uint32_t r2)      \
 {                                                             \
     int64_t r2l, r2h, r1hl;                                   \
     uint64_t ret = 0;                                         \
@@ -1722,7 +1722,7 @@ EXTREMA_H_B(min, <)
 
 #undef EXTREMA_H_B
 
-uint32_t helper_clo_h(uint32_t r1)
+uint32_t HELPER(clo_h)(uint32_t r1)
 {
     uint32_t ret_hw0 = extract32(r1, 0, 16);
     uint32_t ret_hw1 = extract32(r1, 16, 16);
@@ -1740,7 +1740,7 @@ uint32_t helper_clo_h(uint32_t r1)
     return ret_hw0 | (ret_hw1 << 16);
 }
 
-uint32_t helper_clz_h(uint32_t r1)
+uint32_t HELPER(clz_h)(uint32_t r1)
 {
     uint32_t ret_hw0 = extract32(r1, 0, 16);
     uint32_t ret_hw1 = extract32(r1, 16, 16);
@@ -1758,7 +1758,7 @@ uint32_t helper_clz_h(uint32_t r1)
     return ret_hw0 | (ret_hw1 << 16);
 }
 
-uint32_t helper_cls_h(uint32_t r1)
+uint32_t HELPER(cls_h)(uint32_t r1)
 {
     uint32_t ret_hw0 = extract32(r1, 0, 16);
     uint32_t ret_hw1 = extract32(r1, 16, 16);
@@ -1776,7 +1776,7 @@ uint32_t helper_cls_h(uint32_t r1)
     return ret_hw0 | (ret_hw1 << 16);
 }
 
-uint32_t helper_sh(uint32_t r1, uint32_t r2)
+uint32_t HELPER(sh)(uint32_t r1, uint32_t r2)
 {
     int32_t shift_count = sextract32(r2, 0, 6);
 
@@ -1789,7 +1789,7 @@ uint32_t helper_sh(uint32_t r1, uint32_t r2)
     }
 }
 
-uint32_t helper_sh_h(uint32_t r1, uint32_t r2)
+uint32_t HELPER(sh_h)(uint32_t r1, uint32_t r2)
 {
     int32_t ret_hw0, ret_hw1;
     int32_t shift_count;
@@ -1809,7 +1809,7 @@ uint32_t helper_sh_h(uint32_t r1, uint32_t r2)
     }
 }
 
-uint32_t helper_sha(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint32_t HELPER(sha)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     int32_t shift_count;
     int64_t result, t1;
@@ -1847,7 +1847,7 @@ uint32_t helper_sha(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     return ret;
 }
 
-uint32_t helper_sha_h(uint32_t r1, uint32_t r2)
+uint32_t HELPER(sha_h)(uint32_t r1, uint32_t r2)
 {
     int32_t shift_count;
     int32_t ret_hw0, ret_hw1;
@@ -1867,7 +1867,7 @@ uint32_t helper_sha_h(uint32_t r1, uint32_t r2)
     }
 }
 
-uint32_t helper_bmerge(uint32_t r1, uint32_t r2)
+uint32_t HELPER(bmerge)(uint32_t r1, uint32_t r2)
 {
     uint32_t i, ret;
 
@@ -1881,7 +1881,7 @@ uint32_t helper_bmerge(uint32_t r1, uint32_t r2)
     return ret;
 }
 
-uint64_t helper_bsplit(uint32_t r1)
+uint64_t HELPER(bsplit)(uint32_t r1)
 {
     int32_t i;
     uint64_t ret;
@@ -1898,7 +1898,7 @@ uint64_t helper_bsplit(uint32_t r1)
     return ret;
 }
 
-uint32_t helper_parity(uint32_t r1)
+uint32_t HELPER(parity)(uint32_t r1)
 {
     uint32_t ret;
     uint32_t nOnes, i;
@@ -1934,7 +1934,7 @@ uint32_t helper_parity(uint32_t r1)
     return ret;
 }
 
-uint32_t helper_pack(uint32_t carry, uint32_t r1_low, uint32_t r1_high,
+uint32_t HELPER(pack)(uint32_t carry, uint32_t r1_low, uint32_t r1_high,
                      uint32_t r2)
 {
     uint32_t ret;
@@ -1976,7 +1976,7 @@ uint32_t helper_pack(uint32_t carry, uint32_t r1_low, uint32_t r1_high,
     return ret;
 }
 
-uint64_t helper_unpack(uint32_t arg1)
+uint64_t HELPER(unpack)(uint32_t arg1)
 {
     int32_t fp_exp  = extract32(arg1, 23, 8);
     int32_t fp_frac = extract32(arg1, 0, 23);
@@ -2004,7 +2004,7 @@ uint64_t helper_unpack(uint32_t arg1)
     return ret;
 }
 
-uint64_t helper_dvinit_b_13(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint64_t HELPER(dvinit_b_13)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     uint64_t ret;
     int32_t abs_sig_dividend, abs_divisor;
@@ -2027,7 +2027,7 @@ uint64_t helper_dvinit_b_13(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     return ret;
 }
 
-uint64_t helper_dvinit_b_131(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint64_t HELPER(dvinit_b_131)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     uint64_t ret = sextract32(r1, 0, 32);
 
@@ -2044,7 +2044,7 @@ uint64_t helper_dvinit_b_131(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     return ret;
 }
 
-uint64_t helper_dvinit_h_13(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint64_t HELPER(dvinit_h_13)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     uint64_t ret;
     int32_t abs_sig_dividend, abs_divisor;
@@ -2067,7 +2067,7 @@ uint64_t helper_dvinit_h_13(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     return ret;
 }
 
-uint64_t helper_dvinit_h_131(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint64_t HELPER(dvinit_h_131)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     uint64_t ret = sextract32(r1, 0, 32);
 
@@ -2084,7 +2084,7 @@ uint64_t helper_dvinit_h_131(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     return ret;
 }
 
-uint64_t helper_dvadj(uint64_t r1, uint32_t r2)
+uint64_t HELPER(dvadj)(uint64_t r1, uint32_t r2)
 {
     int32_t x_sign = (r1 >> 63);
     int32_t q_sign = x_sign ^ (r2 >> 31);
@@ -2107,7 +2107,7 @@ uint64_t helper_dvadj(uint64_t r1, uint32_t r2)
     return remainder | quotient;
 }
 
-uint64_t helper_dvstep(uint64_t r1, uint32_t r2)
+uint64_t HELPER(dvstep)(uint64_t r1, uint32_t r2)
 {
     int32_t dividend_sign = extract64(r1, 63, 1);
     int32_t divisor_sign = extract32(r2, 31, 1);
@@ -2139,7 +2139,7 @@ uint64_t helper_dvstep(uint64_t r1, uint32_t r2)
     return ((uint64_t)remainder << 32) | (uint32_t)dividend_quotient;
 }
 
-uint64_t helper_dvstep_u(uint64_t r1, uint32_t r2)
+uint64_t HELPER(dvstep_u)(uint64_t r1, uint32_t r2)
 {
     int32_t dividend_quotient = extract64(r1, 0, 32);
     int64_t remainder = extract64(r1, 32, 32);
@@ -2157,7 +2157,7 @@ uint64_t helper_dvstep_u(uint64_t r1, uint32_t r2)
     return ((uint64_t)remainder << 32) | (uint32_t)dividend_quotient;
 }
 
-uint64_t helper_divide(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint64_t HELPER(divide)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     int32_t quotient, remainder;
     int32_t dividend = (int32_t)r1;
@@ -2186,7 +2186,7 @@ uint64_t helper_divide(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     return ((uint64_t)remainder << 32) | (uint32_t)quotient;
 }
 
-uint64_t helper_divide_u(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint64_t HELPER(divide_u)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     uint32_t quotient, remainder;
     uint32_t dividend = r1;
@@ -2206,7 +2206,7 @@ uint64_t helper_divide_u(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     return ((uint64_t)remainder << 32) | quotient;
 }
 
-uint64_t helper_mul_h(uint32_t arg00, uint32_t arg01,
+uint64_t HELPER(mul_h)(uint32_t arg00, uint32_t arg01,
                       uint32_t arg10, uint32_t arg11, uint32_t n)
 {
     uint32_t result0, result1;
@@ -2228,7 +2228,7 @@ uint64_t helper_mul_h(uint32_t arg00, uint32_t arg01,
     return (((uint64_t)result1 << 32)) | result0;
 }
 
-uint64_t helper_mulm_h(uint32_t arg00, uint32_t arg01,
+uint64_t HELPER(mulm_h)(uint32_t arg00, uint32_t arg01,
                        uint32_t arg10, uint32_t arg11, uint32_t n)
 {
     uint64_t ret;
@@ -2253,7 +2253,7 @@ uint64_t helper_mulm_h(uint32_t arg00, uint32_t arg01,
     ret = ret << 16;
     return ret;
 }
-uint32_t helper_mulr_h(uint32_t arg00, uint32_t arg01,
+uint32_t HELPER(mulr_h)(uint32_t arg00, uint32_t arg01,
                        uint32_t arg10, uint32_t arg11, uint32_t n)
 {
     uint32_t result0, result1;
@@ -2276,7 +2276,7 @@ uint32_t helper_mulr_h(uint32_t arg00, uint32_t arg01,
     return (result1 & 0xffff0000) | (result0 >> 16);
 }
 
-uint32_t helper_crc32b(uint32_t arg0, uint32_t arg1)
+uint32_t HELPER(crc32b)(uint32_t arg0, uint32_t arg1)
 {
     uint8_t buf[1] = { arg0 & 0xff };
 
@@ -2284,7 +2284,7 @@ uint32_t helper_crc32b(uint32_t arg0, uint32_t arg1)
 }
 
 
-uint32_t helper_crc32_be(uint32_t arg0, uint32_t arg1)
+uint32_t HELPER(crc32_be)(uint32_t arg0, uint32_t arg1)
 {
     uint8_t buf[4];
     stl_be_p(buf, arg0);
@@ -2292,7 +2292,7 @@ uint32_t helper_crc32_be(uint32_t arg0, uint32_t arg1)
     return crc32(arg1, buf, 4);
 }
 
-uint32_t helper_crc32_le(uint32_t arg0, uint32_t arg1)
+uint32_t HELPER(crc32_le)(uint32_t arg0, uint32_t arg1)
 {
     uint8_t buf[4];
     stl_le_p(buf, arg0);
@@ -2325,7 +2325,7 @@ static uint32_t crc_div(uint32_t crc_in, uint32_t data, uint32_t gen,
     return crc_in;
 }
 
-uint32_t helper_crcn(uint32_t arg0, uint32_t arg1, uint32_t arg2)
+uint32_t HELPER(crcn)(uint32_t arg0, uint32_t arg1, uint32_t arg2)
 {
     uint32_t crc_out, crc_in;
     uint32_t n = extract32(arg0, 12, 4) + 1;
@@ -2363,7 +2363,7 @@ uint32_t helper_crcn(uint32_t arg0, uint32_t arg1, uint32_t arg2)
     return extract32(crc_out, 0, n);
 }
 
-uint32_t helper_shuffle(uint32_t arg0, uint32_t arg1)
+uint32_t HELPER(shuffle)(uint32_t arg0, uint32_t arg1)
 {
     uint32_t resb;
     uint32_t byte_select;
@@ -2532,7 +2532,7 @@ static void restore_context_lower(CPUTriCoreState *env, uint32_t ea,
     env->gpr_d[7] = cpu_ldl_le_data(env, ea + 60);
 }
 
-void helper_call(CPUTriCoreState *env, uint32_t next_pc)
+void HELPER(call)(CPUTriCoreState *env, uint32_t next_pc)
 {
     uint32_t tmp_FCX;
     uint32_t ea;
@@ -2595,7 +2595,7 @@ void helper_call(CPUTriCoreState *env, uint32_t next_pc)
     psw_write(env, psw);
 }
 
-void helper_ret(CPUTriCoreState *env)
+void HELPER(ret)(CPUTriCoreState *env)
 {
     uint32_t ea;
     uint32_t new_PCXI;
@@ -2648,7 +2648,7 @@ void helper_ret(CPUTriCoreState *env)
     }
 }
 
-void helper_bisr(CPUTriCoreState *env, uint32_t const9)
+void HELPER(bisr)(CPUTriCoreState *env, uint32_t const9)
 {
     uint32_t tmp_FCX;
     uint32_t ea;
@@ -2692,7 +2692,7 @@ void helper_bisr(CPUTriCoreState *env, uint32_t const9)
     }
 }
 
-void helper_rfe(CPUTriCoreState *env)
+void HELPER(rfe)(CPUTriCoreState *env)
 {
     uint32_t ea;
     uint32_t new_PCXI;
@@ -2736,7 +2736,7 @@ void helper_rfe(CPUTriCoreState *env)
     psw_write(env, new_PSW);
 }
 
-void helper_rfm(CPUTriCoreState *env)
+void HELPER(rfm)(CPUTriCoreState *env)
 {
     env->PC = (env->gpr_a[11] & ~0x1);
     /* ICR.IE = PCXI.PIE; */
@@ -2755,31 +2755,31 @@ void helper_rfm(CPUTriCoreState *env)
     }
 }
 
-void helper_ldlcx(CPUTriCoreState *env, uint32_t ea)
+void HELPER(ldlcx)(CPUTriCoreState *env, uint32_t ea)
 {
     uint32_t dummy;
     /* insn doesn't load PCXI and RA */
     restore_context_lower(env, ea, &dummy, &dummy);
 }
 
-void helper_lducx(CPUTriCoreState *env, uint32_t ea)
+void HELPER(lducx)(CPUTriCoreState *env, uint32_t ea)
 {
     uint32_t dummy;
     /* insn doesn't load PCXI and PSW */
     restore_context_upper(env, ea, &dummy, &dummy);
 }
 
-void helper_stlcx(CPUTriCoreState *env, uint32_t ea)
+void HELPER(stlcx)(CPUTriCoreState *env, uint32_t ea)
 {
     save_context_lower(env, ea);
 }
 
-void helper_stucx(CPUTriCoreState *env, uint32_t ea)
+void HELPER(stucx)(CPUTriCoreState *env, uint32_t ea)
 {
     save_context_upper(env, ea);
 }
 
-void helper_svlcx(CPUTriCoreState *env)
+void HELPER(svlcx)(CPUTriCoreState *env)
 {
     uint32_t tmp_FCX;
     uint32_t ea;
@@ -2822,7 +2822,7 @@ void helper_svlcx(CPUTriCoreState *env)
     }
 }
 
-void helper_svucx(CPUTriCoreState *env)
+void HELPER(svucx)(CPUTriCoreState *env)
 {
     uint32_t tmp_FCX;
     uint32_t ea;
@@ -2865,7 +2865,7 @@ void helper_svucx(CPUTriCoreState *env)
     }
 }
 
-void helper_rslcx(CPUTriCoreState *env)
+void HELPER(rslcx)(CPUTriCoreState *env)
 {
     uint32_t ea;
     uint32_t new_PCXI;
@@ -2897,12 +2897,12 @@ void helper_rslcx(CPUTriCoreState *env)
     env->PCXI = new_PCXI;
 }
 
-void helper_psw_write(CPUTriCoreState *env, uint32_t arg)
+void HELPER(psw_write)(CPUTriCoreState *env, uint32_t arg)
 {
     psw_write(env, arg);
 }
 
-uint32_t helper_psw_read(CPUTriCoreState *env)
+uint32_t HELPER(psw_read)(CPUTriCoreState *env)
 {
     return psw_read(env);
 }
-- 
2.43.0


