Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF79606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jUW0bER7;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Lgcvay8R
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIunj-0001la-Ty; Mon, 19 Oct 2026 17:21:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIunX-0001is-Rm
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:21:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIunV-0005jl-89
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:21:35 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJKMdJ2158065
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:21:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=o6twrwWrCbt
 M6CHNdAoCxuG7GiYkEzntfJw6u+B2yOw=; b=jUW0bER7J6nZs2B+xFWzuAOGNMJ
 Ml8U1ltNGDMUr+DWrMA6r1cq8acPgc4yBI1uUIChzqnL+VJ54B4yIaAsxN+y4gp7
 xgSRC5k6AEEuIm+IU1yJflB5d8lVimir+SfghlW9uQRImcJDwKn7DYAQxgRzQAJ+
 6c+GVWoStSP2lqQmhX4BbRp5ikU+OYiog/PM8vLEFLI2wuPGCsEoSujL7EIroMkB
 /Qw3Vaw5SSVKtS0+e/GC7K/C8Yqj2PZLdWNHZ2G3JAmxW4XKtQaaiOqDODZ6ncux
 klLPuVXzlfDaCLhhgqTcBIEZh8ZkDtQI3ki61M0q49Lp1xAkdhVuO4bo96g==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf65kajp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:21:30 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3a46f0f158dso97911a91.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792444890; x=1793049690; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o6twrwWrCbtM6CHNdAoCxuG7GiYkEzntfJw6u+B2yOw=;
 b=Lgcvay8Rt/SExFfWhdv0bs2cjiYkCVxCCIxByJ7XsMHFC3/Br+9HNrWh7fQKhze3UM
 eH7qYtjJchwgmZeoCNkxxpYZSDSmU/yrc6+pDmxZDoiqa1+Zzd3b6JJ60mmdtjWPbG5o
 psxfLvclk5DQweo3kr6LhhGRlK/cEMrZiOtxpq56qmwxDCxOf3HKxfFW86MplQ2th8Dw
 FLlN+jyK10Yg7oDeP52Qco4hMdfv2LBxbDt47TGBxC3u+uFgAc39s19dOyZz62lI26zN
 XKwnXUJIsam4kn4Cr+M6DSZomT3Uy148ZF1Q3on1hfDNrdH7RxRd9fiud9J85FPWn5Em
 UQgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792444890; x=1793049690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=o6twrwWrCbtM6CHNdAoCxuG7GiYkEzntfJw6u+B2yOw=;
 b=BbEZIaWnyGPVgBd2NNeR/xiHIrSeEHTLAkD9MY8ygpcNHlWiEmPE8OQLe0k6HhvO8O
 sOujzDNk24kBNDTcqsvGxoVLFfPuCM24tt3sMCwoV1uPCm3GCVO46RKihGmVPp+SK8EC
 sDSu/8fTJRNnMVO88RMaGuV16Z2D9R1Ln6S90m29XOxne7hWXnE32zuBTuTISGcfjlC8
 Q2RPlk5KkGLLcMQLlik8g3EeWg6D3iHIfYXI75B1sSKB/xxFDEibA1ICdcRpDknQ06Wk
 f12qyy4sZ/GpCy38kPXjIId82QPhrepLoNM60dZE8Lh6I2LCTBvxY+NvI6KncDHQYBdx
 //vw==
X-Gm-Message-State: AFq9FYKEUKRyGqn7jwrExyH24gyO5F4QQPGmoQkhf6D00T51pvRv1kdG
 t4K78U33cQ4PAiZnavtChMgVgSZNfDiatSBxRPg6xPKmvngDasV+5QOmv74Ovl4LSyHxsa4vEiy
 e+ssJb+qDUiSMU/22DJU2FUOTPiVJreq6IG5GtFeMfyeFGRZlgkVBViWeHzU1utAn0w==
X-Gm-Gg: AYBFou3Lyc/fBi3ENooo3n2m9bTHF2DguJrnQ+n1ccOia6WoUbjVvx9tAwEf1eJ2OoQ
 XIMBXadRgvkiesh4fhvIzHZ2tfvXfzXkAl7Mrjr5NLffx3Euy77HWWN88IgoYvXVampvWLZNh9B
 OxTQFb8eKBf/XUq1f6sraw0I6+qDIXmhPlfgG33vkOXI40EAxFHaZCGBYu7XRvrnuuUjj3kReto
 sWyOoOAYmTt6+0Jn/gjZSTFtftORtz02w2E/U8VYOcsYQpL0uNwaUBOAcAnej8iiCjP6HqzAlxi
 kfzXiwzpG8Ov80MEKyaiIuBt9IbT6AeVUxuPhLYS8fquBRYkJnxT/wzZccdoRKSBWPc91IZvU5l
 Cw8U7VqdFgL51ay1pwZmyYGDHkukqXfUAA9efckYYNUsbvUq6rGbAtJdKaBQCLdI=
X-Received: by 2002:a17:90b:560d:b0:3ab:b39f:41ca with SMTP id
 98e67ed59e1d1-3ad64bd2235mr173633a91.31.1792444889965; 
 Mon, 19 Oct 2026 14:21:29 -0700 (PDT)
X-Received: by 2002:a17:90b:560d:b0:3ab:b39f:41ca with SMTP id
 98e67ed59e1d1-3ad64bd2235mr173624a91.31.1792444889439; 
 Mon, 19 Oct 2026 14:21:29 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad60ec4457sm863243a91.6.2026.10.19.14.21.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 14:21:28 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 26/26] target/tricore: remove explicit target specific prefix
Date: Mon, 19 Oct 2026 21:20:45 +0000
Message-ID: <20261019212046.149572-27-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX/AOFEPlqfTHH
 keEKspMiVQhZmREAM7T77MwsUPK/NPOg/3AtMNWpPvTZX9O545WH03LNLUirwRxsIEt57NFl34I
 DuYfDDKT8iFm2xvK6lUJ5K5X7RqFNwo=
X-Proofpoint-ORIG-GUID: dRHSduy0EFsiq711LOfMNacaTzmOlvk9
X-Authority-Analysis: v=2.4 cv=Y5ptIReN c=1 sm=1 tr=0 ts=6ad689da cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=jgB6yt7H7Q370FkDtF8A:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfXy2vYft9wOFg/
 p8ujI5CPV0xFECRqTGBtoTMlHheIm66MVzEMN/uVD4oXcJLCV7xHdIibHjT2+ymdWzbPBn+XATV
 ZYQ0MRrcUunijTsvOVwvIwJrHnKZBFic2iC2nfpMGQvq/rrHVXb/nw7QMkA0nlvHHzzaCSRky3D
 d7wcNdu5Iysy99zCjymxMOumokXl6IWZMg3fCt5IP9RedmNVlCCQQPX+mcE6FipxlV9+8M8G+PP
 MqZoTuCNbuRdVNADYmr23QEOej0sxBUwDGFJ5+iA2ozDc39uGvAFJpaccf6HAPJuh54o1ezuteU
 6jpXm0sU6fx9FzQTtm4EhdI19bwb78AqvgfbB42t7qz03ZqXln+XxhGiKAzAhuxSiMKsxjcIDox
 q2bYUPxJhCeb+kntCSTKjj02cBWjj10lzg3MZocBmCXeb6Bs+sghjFyjcVWWYuRIaLmy+GQjlr0
 tde0Uc41Fu+jkjxMYXw==
X-Proofpoint-GUID: dRHSduy0EFsiq711LOfMNacaTzmOlvk9
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

Now that we have a generic mechanism to prefix all helpers, we can undo the
recent changes that fixed conflicts between targets in multi-target set.

This reverts commit 7858012634be7b987d9cb4c4520e55ccffedb2db
"target/tricore: prefix helpers conflicting with other arch"

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/tricore/fpu_helper.c | 12 ++++++------
 target/tricore/helper.h     | 14 +++++++-------
 target/tricore/translate.c  | 14 +++++++-------
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/target/tricore/fpu_helper.c b/target/tricore/fpu_helper.c
index 9d323a9b664..81fec300ff9 100644
--- a/target/tricore/fpu_helper.c
+++ b/target/tricore/fpu_helper.c
@@ -118,7 +118,7 @@ static void f_update_psw_flags(CPUTriCoreState *env, uint8_t flags)
 }
 
 #define FADD_SUB(op)                                                           \
-uint32_t HELPER(tricore_f##op)(CPUTriCoreState *env, uint32_t r1, uint32_t r2) \
+uint32_t HELPER(f##op)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)         \
 {                                                                              \
     float32 arg1 = make_float32(r1);                                           \
     float32 arg2 = make_float32(r2);                                           \
@@ -144,7 +144,7 @@ uint32_t HELPER(tricore_f##op)(CPUTriCoreState *env, uint32_t r1, uint32_t r2) \
 FADD_SUB(add)
 FADD_SUB(sub)
 
-uint32_t HELPER(tricore_fmul)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint32_t HELPER(fmul)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     uint32_t flags;
     float32 arg1 = make_float32(r1);
@@ -251,7 +251,7 @@ uint32_t HELPER(qseed)(CPUTriCoreState *env, uint32_t r1)
     return (uint32_t) result;
 }
 
-uint32_t HELPER(tricore_fdiv)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint32_t HELPER(fdiv)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     uint32_t flags;
     float32 arg1 = make_float32(r1);
@@ -331,7 +331,7 @@ uint32_t HELPER(fmsub)(CPUTriCoreState *env, uint32_t r1,
     return (uint32_t)f_result;
 }
 
-uint32_t HELPER(tricore_fcmp)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint32_t HELPER(fcmp)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     uint32_t result, flags;
     float32 arg1 = make_float32(r1);
@@ -354,7 +354,7 @@ uint32_t HELPER(tricore_fcmp)(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     return result;
 }
 
-uint32_t HELPER(tricore_ftoi)(CPUTriCoreState *env, uint32_t arg)
+uint32_t HELPER(ftoi)(CPUTriCoreState *env, uint32_t arg)
 {
     float32 f_arg = make_float32(arg);
     int32_t result, flags;
@@ -447,7 +447,7 @@ uint32_t HELPER(ftohp)(CPUTriCoreState *env, uint32_t arg)
     return result;
 }
 
-uint32_t HELPER(tricore_itof)(CPUTriCoreState *env, uint32_t arg)
+uint32_t HELPER(itof)(CPUTriCoreState *env, uint32_t arg)
 {
     float32 f_result;
     uint32_t flags;
diff --git a/target/tricore/helper.h b/target/tricore/helper.h
index 6073fd70379..1d97d078b00 100644
--- a/target/tricore/helper.h
+++ b/target/tricore/helper.h
@@ -102,18 +102,18 @@ DEF_HELPER_FLAGS_1(parity, TCG_CALL_NO_RWG_SE, i32, i32)
 /* float */
 DEF_HELPER_FLAGS_4(pack, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32, i32)
 DEF_HELPER_1(unpack, i64, i32)
-DEF_HELPER_3(tricore_fadd, i32, env, i32, i32)
-DEF_HELPER_3(tricore_fsub, i32, env, i32, i32)
-DEF_HELPER_3(tricore_fmul, i32, env, i32, i32)
-DEF_HELPER_3(tricore_fdiv, i32, env, i32, i32)
+DEF_HELPER_3(fadd, i32, env, i32, i32)
+DEF_HELPER_3(fsub, i32, env, i32, i32)
+DEF_HELPER_3(fmul, i32, env, i32, i32)
+DEF_HELPER_3(fdiv, i32, env, i32, i32)
 DEF_HELPER_4(fmadd, i32, env, i32, i32, i32)
 DEF_HELPER_4(fmsub, i32, env, i32, i32, i32)
-DEF_HELPER_3(tricore_fcmp, i32, env, i32, i32)
+DEF_HELPER_3(fcmp, i32, env, i32, i32)
 DEF_HELPER_2(qseed, i32, env, i32)
-DEF_HELPER_2(tricore_ftoi, i32, env, i32)
+DEF_HELPER_2(ftoi, i32, env, i32)
 DEF_HELPER_2(ftohp, i32, env, i32)
 DEF_HELPER_2(hptof, i32, env, i32)
-DEF_HELPER_2(tricore_itof, i32, env, i32)
+DEF_HELPER_2(itof, i32, env, i32)
 DEF_HELPER_2(utof, i32, env, i32)
 DEF_HELPER_2(ftoiz, i32, env, i32)
 DEF_HELPER_2(ftou, i32, env, i32)
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 81db388e5ee..8cd6b58f66b 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -6290,10 +6290,10 @@ static void decode_rr_divide(DisasContext *ctx)
         }
         break;
     case OPC2_32_RR_MUL_F:
-        gen_helper_tricore_fmul(cpu_gpr_d[r3], tcg_env, cpu_gpr_d[r1], cpu_gpr_d[r2]);
+        gen_helper_fmul(cpu_gpr_d[r3], tcg_env, cpu_gpr_d[r1], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RR_DIV_F:
-        gen_helper_tricore_fdiv(cpu_gpr_d[r3], tcg_env, cpu_gpr_d[r1], cpu_gpr_d[r2]);
+        gen_helper_fdiv(cpu_gpr_d[r3], tcg_env, cpu_gpr_d[r1], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RR_FTOHP:
         if (has_feature(ctx, TRICORE_FEATURE_162)) {
@@ -6310,13 +6310,13 @@ static void decode_rr_divide(DisasContext *ctx)
         }
         break;
     case OPC2_32_RR_CMP_F:
-        gen_helper_tricore_fcmp(cpu_gpr_d[r3], tcg_env, cpu_gpr_d[r1], cpu_gpr_d[r2]);
+        gen_helper_fcmp(cpu_gpr_d[r3], tcg_env, cpu_gpr_d[r1], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RR_FTOI:
-        gen_helper_tricore_ftoi(cpu_gpr_d[r3], tcg_env, cpu_gpr_d[r1]);
+        gen_helper_ftoi(cpu_gpr_d[r3], tcg_env, cpu_gpr_d[r1]);
         break;
     case OPC2_32_RR_ITOF:
-        gen_helper_tricore_itof(cpu_gpr_d[r3], tcg_env, cpu_gpr_d[r1]);
+        gen_helper_itof(cpu_gpr_d[r3], tcg_env, cpu_gpr_d[r1]);
         break;
     case OPC2_32_RR_FTOU:
         gen_helper_ftou(cpu_gpr_d[r3], tcg_env, cpu_gpr_d[r1]);
@@ -6725,10 +6725,10 @@ static void decode_rrr_divide(DisasContext *ctx)
         }
         break;
     case OPC2_32_RRR_ADD_F:
-        gen_helper_tricore_fadd(cpu_gpr_d[r4], tcg_env, cpu_gpr_d[r1], cpu_gpr_d[r3]);
+        gen_helper_fadd(cpu_gpr_d[r4], tcg_env, cpu_gpr_d[r1], cpu_gpr_d[r3]);
         break;
     case OPC2_32_RRR_SUB_F:
-        gen_helper_tricore_fsub(cpu_gpr_d[r4], tcg_env, cpu_gpr_d[r1], cpu_gpr_d[r3]);
+        gen_helper_fsub(cpu_gpr_d[r4], tcg_env, cpu_gpr_d[r1], cpu_gpr_d[r3]);
         break;
     case OPC2_32_RRR_MADD_F:
         gen_helper_fmadd(cpu_gpr_d[r4], tcg_env, cpu_gpr_d[r1],
-- 
2.43.0


