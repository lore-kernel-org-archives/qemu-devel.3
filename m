Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2833DCA5FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 18:59:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDnrz-0000W1-GT; Mon, 05 Oct 2026 14:57:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDnqm-0007gT-Dh
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 14:55:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDnqk-0005oQ-8a
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 14:55:48 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695HuJqq2484333
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 18:55:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MOB19GZeAPKcOBP6b3eSkByvzBF9/BNpqv7K9KBpBMM=; b=Mm9wEOOYmfuttXYI
 T9FglJE+MtFq0hHtzCzndUocGkab/3cxbluilXTupLgqAdSq29tL5NVPOjFuXcbW
 6ZUz6b3rV3x2NR6DrVaK1NSNZYSAWXTxp/L1wfFUrR1i5s7wQpZ7AfhenGpoVFeO
 iZwSXtVfLLk9RP05cJSQMxwiNM/+0ZDYcv/rs8Vo3hpO3rp3UU5Glm1a7onPi/KG
 5INw6Cr7ycYwAGqQNN1zMDNNa7xmKBb5lhLlwf/MTr1TJR6epWJpIuEaBnQm0PxR
 4S0X7kcRC5B5YGj45gUBaYzBJnNC5tx3jZGQBGbmj6eA8yyGjLfVGqDgrd91vvBf
 l0UBsw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4gr087q2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 18:55:35 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1438fef603cso4713487c88.0
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 11:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791226534; x=1791831334; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MOB19GZeAPKcOBP6b3eSkByvzBF9/BNpqv7K9KBpBMM=;
 b=Q5kZBG4y9N/7PwuY0vDrtUGrnMrVCgvWh6fWNZ4v/zZoustTMCwIA5Ot8LpI9Berd5
 DvzfBxCr0TvcqztAh2trADg5HsQDCrRR+pYW6WPwp/8x4cDEZZJeL5K11XT4rEPGoUca
 utZ01Pfap3Cpb+V3jvCTKey8vOl/eQSmFDWg/NjKt9AzE981+WJz0CLgJBWHujBtKcQc
 wXDV124HtpnCzwS/R8NDFUWQOJXqX4H+sKmzgwgobRvoJ9yIBor11sahOLvMrxv1lfc/
 EjZruOJMqx6Kcu+OMjBow8f0u68TuF4XkwNPmIDsFqYRK+tI9XiIGAmmFYrhnGHZZ4ri
 g2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791226534; x=1791831334;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MOB19GZeAPKcOBP6b3eSkByvzBF9/BNpqv7K9KBpBMM=;
 b=K0XmC8oBC8KWNVvDbL2SeY9blaN1dNqcEyCbzwq1s/WlXzuIRImjtKbwaXFzbiVgd9
 pAjrts1pV2cCw/Oo4SXjS3A4SWiO4ELorq0eYTyBdc/JgZiVgMFuWIP/ihl3HHhOr3qi
 COYjDYbzwYupUDPwfF1biFIHu+xOefSbrlXeXaJm11cNp0RFlB2UOqi0g7MmsmoQN9FB
 MNVDdHRRqSEENJdrMv9HIl7/PDrhEqyG2eubmrNBb2C0KVE7TdMjc2LVU4iob0Fkq4No
 PhqP4WfUJA//mAZqTMb5zyodGH+8tCteZvUeSNYcA7ek7zNA7RGdEKUrPMYPHaI0E5kG
 Bpkw==
X-Gm-Message-State: AFuF++l5KWveitezjLotNPl/bjO3aOa3lhqaGZXmq64wAjn6QDpmGgba
 PoAMflgoOgG3Xv4FMFgVh8vT40/1qovQpjKki6OiGWcy/aJJDIajza5rwjyhmy3sjTPPnZL6L5a
 wwQWSqQ5Y0S81mGDnacNunuTz4u1ndGf7/qY7YVyvI5ydrat9nclw1nW/KaCfSgZsqA==
X-Gm-Gg: AYBFou1ncK14wqeY7hmjNRl7LT03+92WWHqoeyJrkfwEP1meCHTDNtWmX6lKm2gt5l9
 pHAbLi0m+HsrRWx+2sZaAMsqjR8sf9DFvftEbLtOVExCwgnceFGd+mJn6xClwaxqF6vdz6Ia/hG
 UfgFI+3UAyNiKUhu6Mt4Zj87CLA2Lc3PvURjDfugu9OoaqqxVjI/mBLD+bzAhJPdllj4dKmAeWn
 ku3/F8AkXPI90aOzXrI9AjnhSYkvSKRa28ZQQ6IOSXyGGx9m1SrllN4bijSEqqWkY+vrSQuXhCT
 5Y70bW1L2+A+VsVksvv7ftEuekFU4/SglLbFrcbZbTjHRUaI958OGQwpJ5ymSaFlZjSgffnUv8F
 2fgOJC6FYzAQ1aPTQFDlb8AdMPKrh/xrKIalvLqHnrabaxCLktfoGxhBabgCW
X-Received: by 2002:a05:701b:458e:10b0:15d:63db:9426 with SMTP id
 a92af1059eb24-15d63dba6e8mr335296c88.5.1791226533956; 
 Mon, 05 Oct 2026 11:55:33 -0700 (PDT)
X-Received: by 2002:a05:701b:458e:10b0:15d:63db:9426 with SMTP id
 a92af1059eb24-15d63dba6e8mr335255c88.5.1791226533283; 
 Mon, 05 Oct 2026 11:55:33 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-15d7234c2a2sm602092c88.0.2026.10.05.11.55.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 11:55:32 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 16/22] target/tricore: prefix helpers conflicting with other
 arch
Date: Mon,  5 Oct 2026 11:54:52 -0700
Message-ID: <20261005185458.405929-17-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261005185458.405929-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261005185458.405929-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA3NCBTYWx0ZWRfXwKM+fz/Nf1y0
 6eo6SNNYwquAip5dsoSDtgjnmNyIbUSaWmijgZrjwFo8d8BDOzAgg+EWOE4IzX9pEhTZeoNcToI
 W6KluxG+uyNEftviGohPij+kUgi7/CfW4SltdXxrX96Qah3y8TOTNZ5atF4DWPAAROxFi39bR0q
 MzVMC+MS8Vx78dnlT7mjbsyK/LXKosQGWXi5vA6LpinHbcvDReSU0hfcQ3PIjxO5LAl1isd/X65
 /4rZEdaBTL3ntg2BYc4rPXEau+AJSxBo+W3FinfXbU2kCIPZDniRgC1eTkfmPQRQEHBxDejdTNE
 nWKHlheX7jT4AUTwC86awNDHkRO15ROkMS4eQN0jLpKe72/VP1mavOngMvraj0ChKyYqaiE8pyb
 YbW6qzC9iyR3VeMwltWu7JebY7zCflIuSToiADBpO4JILLlPgw3QMzrlD2r8HG0UyQVTeRwAKLg
 w++Kj6BvcEG1je0OI7Q==
X-Proofpoint-GUID: _dNWq7CbDtYQQ3n4Qdh6Du_Hz6iTBlkq
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA3NCBTYWx0ZWRfXzY27mVwZJ+O7
 xv1gakVwZFcWuNBJflTzp8ir4P0XnfEIO2tHbZxPgya0ykQIquJAXG/wgTKwdod6yLddio6jhpu
 jbMGjjneAr9Mr0lN1lD853Aid/ZReNc=
X-Proofpoint-ORIG-GUID: _dNWq7CbDtYQQ3n4Qdh6Du_Hz6iTBlkq
X-Authority-Analysis: v=2.4 cv=BrQIUoX5 c=1 sm=1 tr=0 ts=6ac3f2a7 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=JOp_Co3xa00q_CoykhsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050074
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260930020108.217892-17-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/tricore/fpu_helper.c | 12 ++++++------
 target/tricore/helper.h     | 14 +++++++-------
 target/tricore/translate.c  | 14 +++++++-------
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/target/tricore/fpu_helper.c b/target/tricore/fpu_helper.c
index 1b72dcc5f5c..fa268a8a6bc 100644
--- a/target/tricore/fpu_helper.c
+++ b/target/tricore/fpu_helper.c
@@ -118,7 +118,7 @@ static void f_update_psw_flags(CPUTriCoreState *env, uint8_t flags)
 }
 
 #define FADD_SUB(op)                                                           \
-uint32_t helper_f##op(CPUTriCoreState *env, uint32_t r1, uint32_t r2)          \
+uint32_t helper_tricore_f##op(CPUTriCoreState *env, uint32_t r1, uint32_t r2)  \
 {                                                                              \
     float32 arg1 = make_float32(r1);                                           \
     float32 arg2 = make_float32(r2);                                           \
@@ -144,7 +144,7 @@ uint32_t helper_f##op(CPUTriCoreState *env, uint32_t r1, uint32_t r2)          \
 FADD_SUB(add)
 FADD_SUB(sub)
 
-uint32_t helper_fmul(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint32_t helper_tricore_fmul(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     uint32_t flags;
     float32 arg1 = make_float32(r1);
@@ -251,7 +251,7 @@ uint32_t helper_qseed(CPUTriCoreState *env, uint32_t r1)
     return (uint32_t) result;
 }
 
-uint32_t helper_fdiv(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint32_t helper_tricore_fdiv(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     uint32_t flags;
     float32 arg1 = make_float32(r1);
@@ -331,7 +331,7 @@ uint32_t helper_fmsub(CPUTriCoreState *env, uint32_t r1,
     return (uint32_t)f_result;
 }
 
-uint32_t helper_fcmp(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
+uint32_t helper_tricore_fcmp(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     uint32_t result, flags;
     float32 arg1 = make_float32(r1);
@@ -354,7 +354,7 @@ uint32_t helper_fcmp(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     return result;
 }
 
-uint32_t helper_ftoi(CPUTriCoreState *env, uint32_t arg)
+uint32_t helper_tricore_ftoi(CPUTriCoreState *env, uint32_t arg)
 {
     float32 f_arg = make_float32(arg);
     int32_t result, flags;
@@ -447,7 +447,7 @@ uint32_t helper_ftohp(CPUTriCoreState *env, uint32_t arg)
     return result;
 }
 
-uint32_t helper_itof(CPUTriCoreState *env, uint32_t arg)
+uint32_t helper_tricore_itof(CPUTriCoreState *env, uint32_t arg)
 {
     float32 f_result;
     uint32_t flags;
diff --git a/target/tricore/helper.h b/target/tricore/helper.h
index 1d97d078b00..6073fd70379 100644
--- a/target/tricore/helper.h
+++ b/target/tricore/helper.h
@@ -102,18 +102,18 @@ DEF_HELPER_FLAGS_1(parity, TCG_CALL_NO_RWG_SE, i32, i32)
 /* float */
 DEF_HELPER_FLAGS_4(pack, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32, i32)
 DEF_HELPER_1(unpack, i64, i32)
-DEF_HELPER_3(fadd, i32, env, i32, i32)
-DEF_HELPER_3(fsub, i32, env, i32, i32)
-DEF_HELPER_3(fmul, i32, env, i32, i32)
-DEF_HELPER_3(fdiv, i32, env, i32, i32)
+DEF_HELPER_3(tricore_fadd, i32, env, i32, i32)
+DEF_HELPER_3(tricore_fsub, i32, env, i32, i32)
+DEF_HELPER_3(tricore_fmul, i32, env, i32, i32)
+DEF_HELPER_3(tricore_fdiv, i32, env, i32, i32)
 DEF_HELPER_4(fmadd, i32, env, i32, i32, i32)
 DEF_HELPER_4(fmsub, i32, env, i32, i32, i32)
-DEF_HELPER_3(fcmp, i32, env, i32, i32)
+DEF_HELPER_3(tricore_fcmp, i32, env, i32, i32)
 DEF_HELPER_2(qseed, i32, env, i32)
-DEF_HELPER_2(ftoi, i32, env, i32)
+DEF_HELPER_2(tricore_ftoi, i32, env, i32)
 DEF_HELPER_2(ftohp, i32, env, i32)
 DEF_HELPER_2(hptof, i32, env, i32)
-DEF_HELPER_2(itof, i32, env, i32)
+DEF_HELPER_2(tricore_itof, i32, env, i32)
 DEF_HELPER_2(utof, i32, env, i32)
 DEF_HELPER_2(ftoiz, i32, env, i32)
 DEF_HELPER_2(ftou, i32, env, i32)
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 8cd6b58f66b..81db388e5ee 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -6290,10 +6290,10 @@ static void decode_rr_divide(DisasContext *ctx)
         }
         break;
     case OPC2_32_RR_MUL_F:
-        gen_helper_fmul(cpu_gpr_d[r3], tcg_env, cpu_gpr_d[r1], cpu_gpr_d[r2]);
+        gen_helper_tricore_fmul(cpu_gpr_d[r3], tcg_env, cpu_gpr_d[r1], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RR_DIV_F:
-        gen_helper_fdiv(cpu_gpr_d[r3], tcg_env, cpu_gpr_d[r1], cpu_gpr_d[r2]);
+        gen_helper_tricore_fdiv(cpu_gpr_d[r3], tcg_env, cpu_gpr_d[r1], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RR_FTOHP:
         if (has_feature(ctx, TRICORE_FEATURE_162)) {
@@ -6310,13 +6310,13 @@ static void decode_rr_divide(DisasContext *ctx)
         }
         break;
     case OPC2_32_RR_CMP_F:
-        gen_helper_fcmp(cpu_gpr_d[r3], tcg_env, cpu_gpr_d[r1], cpu_gpr_d[r2]);
+        gen_helper_tricore_fcmp(cpu_gpr_d[r3], tcg_env, cpu_gpr_d[r1], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RR_FTOI:
-        gen_helper_ftoi(cpu_gpr_d[r3], tcg_env, cpu_gpr_d[r1]);
+        gen_helper_tricore_ftoi(cpu_gpr_d[r3], tcg_env, cpu_gpr_d[r1]);
         break;
     case OPC2_32_RR_ITOF:
-        gen_helper_itof(cpu_gpr_d[r3], tcg_env, cpu_gpr_d[r1]);
+        gen_helper_tricore_itof(cpu_gpr_d[r3], tcg_env, cpu_gpr_d[r1]);
         break;
     case OPC2_32_RR_FTOU:
         gen_helper_ftou(cpu_gpr_d[r3], tcg_env, cpu_gpr_d[r1]);
@@ -6725,10 +6725,10 @@ static void decode_rrr_divide(DisasContext *ctx)
         }
         break;
     case OPC2_32_RRR_ADD_F:
-        gen_helper_fadd(cpu_gpr_d[r4], tcg_env, cpu_gpr_d[r1], cpu_gpr_d[r3]);
+        gen_helper_tricore_fadd(cpu_gpr_d[r4], tcg_env, cpu_gpr_d[r1], cpu_gpr_d[r3]);
         break;
     case OPC2_32_RRR_SUB_F:
-        gen_helper_fsub(cpu_gpr_d[r4], tcg_env, cpu_gpr_d[r1], cpu_gpr_d[r3]);
+        gen_helper_tricore_fsub(cpu_gpr_d[r4], tcg_env, cpu_gpr_d[r1], cpu_gpr_d[r3]);
         break;
     case OPC2_32_RRR_MADD_F:
         gen_helper_fmadd(cpu_gpr_d[r4], tcg_env, cpu_gpr_d[r1],
-- 
2.47.3


