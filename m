Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12630606A31D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JYlNOqZ3;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=f4btgV1M
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIuni-0001lZ-SH; Mon, 19 Oct 2026 17:21:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIunW-0001iJ-6X
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:21:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIunS-0005hx-9W
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:21:33 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJKCQ53329074
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:21:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=dxSKjXhMePq
 k/yVwgWq1O7IbK4rEHBrKtjiF3DnlB6w=; b=JYlNOqZ3eArKO3dgRr3+5qKixSm
 m1xioryjXMZNvUf+luz6f+8vCLCoINpd8WtdNVw5b+NZxT4Cu1rCMosIaX7uNDb1
 GNLq135N5qbgCjHguAQde9jZC6Qc5xWGq3wdJPN+aZPM5B39qXmR2wW8yueevkjp
 Tq9p2Ud300wBO5hf59aS7Y5JC3ZiPnQ81c1++UZ4Ny+lKm944zWeLEdNLSy1mtoD
 Ndmkb+prpG/5Lt8D3gu+c9PT8yeZ5/2va9SKVzt3UByS/KIFq4Agg+ZM8eNA3jnV
 Dz8dj1bDHVx8LKux/rn1KQT3j2qYuAXjUHvSf+HrTHMp+eiVfwedU6V13DQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdkmfj2jw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:21:18 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3a4a0017549so5509599a91.3
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792444878; x=1793049678; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dxSKjXhMePqk/yVwgWq1O7IbK4rEHBrKtjiF3DnlB6w=;
 b=f4btgV1MveTlJT9neufxxO+ynaeHo/KvxZoZhB2SG9MPayqYYLddfNKJmmGRbtza25
 OrsxioLNZG++eSAG7LbpQHPfZPe95yjq9ccabb/RMINw6eNcUKsFWzMxfjD8ZU4NQA+M
 z3jfA6dB6zJWEYIEg9oseoHBS5hzI5MIgsuwciJrX2Xv0kp90+bAQpSBiOiwX3oeioa0
 PHb2GUmWd9rg28JA7/2FhtyqKVfhIqvnfJOSul5ELVnh6kntG5/YIsqKCnnWGcCtr5Jm
 o1D2ULKH74Neip395Yzngk10j7PYpjtECADrzHzkc/5bBL+SxVr9437jHsNrcC5N/7/0
 QitA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792444878; x=1793049678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dxSKjXhMePqk/yVwgWq1O7IbK4rEHBrKtjiF3DnlB6w=;
 b=i6JXFkvUBrqLXsAqUP6PiqoQbaeqtsLmQS4h+gEInqau14RhHntVTN0bylJpUMdhSM
 bnVGg25c3YllX2pS6zZNV6y8+hCPKsagKvi9q+BFoHd5RNoBqq+/2RWojMyUbtyTWFS2
 EagCuuTGvTYKLMYBNxZtPW9Rp/jUFPMbBc1Rj3JgnFMszRbfmYzxsCKrGTOyk6GkuCo0
 VaRJuOhSyUBuaV+6Js2dGSv/UfRTdgQkCxGzexLjN2njNAkigLrheb0ON9F4P9LRY4dt
 E/gVxAJ7GZSnHFmpJDZ9vLgAYbJy27sAB51XlL9rWcvCfOwTNIKTN5y1HiiwehDiE4Tv
 Wuww==
X-Gm-Message-State: AFq9FYKm5S59WM88z99vSyO4ZvuWdFMonqmJKaFJjOO1rQOKFg4gSnI6
 4crWRmGlMeOh0VkzFy0Z6UJsxo7XlRD2w/h2l77FSChgWtit3Z2zittnQGlh3oN0E633cB2aVoE
 y+fJ5wYe4Xt1jHF9Axfg0RKMd54+y55utljLuolq3fq0G3aANH3Q/uOq+NkNMzlX80w==
X-Gm-Gg: AYBFou2ZzmHrmdC2TcxlgUAT28Q5BNXcKYGGuuO9yo/Ar2dXzsczRnHwUnyD5W7c7WT
 ZZaansY+qzqoBmc+ntxMDmF4y/lQavQJlgy2P8eYc+5wuMfJFledH9UEhMNdMBTO2wHXBi/RD7S
 +V8546h8nUS36rN6KFPZPdgEwYFBw4IQkO685zPXh2u38DGt+WNZDDfPN2qZ2IRxTNqK6RGsmfO
 SGisFMSpJiPlu788nAScFB4h7EEneqlBy2XuliqFDMS//RvPLpKOkezYHU46Adj7gz6qiCG2D8j
 YbOPHzuh7ANkNcj6nBIdHtr/NC5kNku36qRxP/yBBe1Vo86M/bMtchiRx2nk9gihXQz6e1Z5Pry
 pRm2uXz1vq5zGC2lyHdHTvpTwxip91ogxztu9HfsNO3hysxn8qYmZ0wTnkUHgP9Q=
X-Received: by 2002:a17:90b:4e88:b0:3ac:6fca:f88a with SMTP id
 98e67ed59e1d1-3acee728a89mr8082893a91.3.1792444877586; 
 Mon, 19 Oct 2026 14:21:17 -0700 (PDT)
X-Received: by 2002:a17:90b:4e88:b0:3ac:6fca:f88a with SMTP id
 98e67ed59e1d1-3acee728a89mr8082878a91.3.1792444877042; 
 Mon, 19 Oct 2026 14:21:17 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad60ec4457sm863243a91.6.2026.10.19.14.21.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 14:21:15 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 15/26] target/sh4: define and call helpers using HELPER macro
Date: Mon, 19 Oct 2026 21:20:34 +0000
Message-ID: <20261019212046.149572-16-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: axSHkR5yb0QrwuEdwFEUjULwhzt265Sd
X-Authority-Analysis: v=2.4 cv=O+isLx9W c=1 sm=1 tr=0 ts=6ad689ce cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=s8CIgTy_PDT41ihXdFQA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX6/J0+vKY85GM
 aKVUw1pKXvxx03a5KsJNHAX8PH2ivzBnZBUb+2c4zY0QXsbvRG9gj61bAERgNrIzOKxFoC9Q8Qq
 BXy2QwyafiaQxDAMN6LGJPj34dsc/koTMTUMlzhN8Va6ilmCqjWZQfNwVZ8ijxishvrWXzeoJ6x
 a0xwxAa+iB3zq9LDxldge3AmNBSWXsWOQqHHdBbmFJIq+rJtenPjZ8CyDyUetfO0QVbTTrwYwbR
 GQ/KrDp3VFVUOnKXq+gvx4OgUMMhoTGmntIiL1fLKErJrSVRKO5Vsn841523eg7WE1lKI2fbO2s
 VRgkNzPE8z8OICbrsK/HsXvJqrXZilVJqV1ClYxAedS5yxEaPdwSibZqoWW82+rmQxGG6DtfTyE
 X8SXm3ZJKBONHF1hnVl7byjiy2996MJ2StwIAZn5K2lYViKaNkD++OSsH+4SU7r/XAM6bSWNcI5
 tgdNoTjLlvW5BXnNjLg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX0pD/Ht5lGolH
 cY4LEKgknLbRGuI0yLCJ+Us2nK9UPRzps7GQqF5uqNHtffQyF9brxBjB9e095O0JQ/vzjKzZnKZ
 VJkTYuamZ4rJ1u5VZIephNVvEIP55D8=
X-Proofpoint-ORIG-GUID: axSHkR5yb0QrwuEdwFEUjULwhzt265Sd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 spamscore=0 clxscore=1015 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190085
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
 target/sh4/op_helper.c | 76 +++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
index 777380f8e40..173ea35109a 100644
--- a/target/sh4/op_helper.c
+++ b/target/sh4/op_helper.c
@@ -46,7 +46,7 @@ void superh_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
 
 #endif
 
-void helper_ldtlb(CPUSH4State *env)
+void HELPER(ldtlb)(CPUSH4State *env)
 {
 #ifdef CONFIG_USER_ONLY
     cpu_abort(env_cpu(env), "Unhandled ldtlb");
@@ -65,27 +65,27 @@ void raise_exception(CPUSH4State *env, int index,
     cpu_loop_exit_restore(cs, retaddr);
 }
 
-void helper_raise_illegal_instruction(CPUSH4State *env)
+void HELPER(raise_illegal_instruction)(CPUSH4State *env)
 {
     raise_exception(env, 0x180, 0);
 }
 
-void helper_raise_slot_illegal_instruction(CPUSH4State *env)
+void HELPER(raise_slot_illegal_instruction)(CPUSH4State *env)
 {
     raise_exception(env, 0x1a0, 0);
 }
 
-void helper_raise_fpu_disable(CPUSH4State *env)
+void HELPER(raise_fpu_disable)(CPUSH4State *env)
 {
     raise_exception(env, 0x800, 0);
 }
 
-void helper_raise_slot_fpu_disable(CPUSH4State *env)
+void HELPER(raise_slot_fpu_disable)(CPUSH4State *env)
 {
     raise_exception(env, 0x820, 0);
 }
 
-void helper_sleep(CPUSH4State *env)
+void HELPER(sleep)(CPUSH4State *env)
 {
     CPUState *cs = env_cpu(env);
 
@@ -94,19 +94,19 @@ void helper_sleep(CPUSH4State *env)
     raise_exception(env, EXCP_HLT, 0);
 }
 
-void helper_trapa(CPUSH4State *env, uint32_t tra)
+void HELPER(trapa)(CPUSH4State *env, uint32_t tra)
 {
     env->tra = tra << 2;
     raise_exception(env, 0x160, 0);
 }
 
-void helper_exclusive(CPUSH4State *env)
+void HELPER(exclusive)(CPUSH4State *env)
 {
     /* We do not want cpu_restore_state to run.  */
     cpu_loop_exit_atomic(env_cpu(env), 0);
 }
 
-void helper_movcal(CPUSH4State *env, uint32_t address, uint32_t value)
+void HELPER(movcal)(CPUSH4State *env, uint32_t address, uint32_t value)
 {
     if (cpu_sh4_is_cached (env, address))
     {
@@ -121,7 +121,7 @@ void helper_movcal(CPUSH4State *env, uint32_t address, uint32_t value)
     }
 }
 
-void helper_discard_movcal_backup(CPUSH4State *env)
+void HELPER(discard_movcal_backup)(CPUSH4State *env)
 {
     memory_content *current = env->movcal_backup;
 
@@ -135,7 +135,7 @@ void helper_discard_movcal_backup(CPUSH4State *env)
     }
 }
 
-void helper_ocbi(CPUSH4State *env, uint32_t address)
+void HELPER(ocbi)(CPUSH4State *env, uint32_t address)
 {
     unsigned mmu_idx = cpu_mmu_index(env_cpu(env), false);
     MemOpIdx oi = make_memop_idx(MO_TE | MO_UL | MO_UNALN, mmu_idx);
@@ -161,7 +161,7 @@ void helper_ocbi(CPUSH4State *env, uint32_t address)
     }
 }
 
-void helper_macl(CPUSH4State *env, int32_t arg0, int32_t arg1)
+void HELPER(macl)(CPUSH4State *env, int32_t arg0, int32_t arg1)
 {
     const int64_t min = -(1ll << 47);
     const int64_t max = (1ll << 47) - 1;
@@ -180,7 +180,7 @@ void helper_macl(CPUSH4State *env, int32_t arg0, int32_t arg1)
     env->mac = res;
 }
 
-void helper_macw(CPUSH4State *env, int32_t arg0, int32_t arg1)
+void HELPER(macw)(CPUSH4State *env, int32_t arg0, int32_t arg1)
 {
     /* Inputs are already sign-extended from 16 bits. */
     int32_t mul = arg0 * arg1;
@@ -216,7 +216,7 @@ void cpu_load_fpscr(CPUSH4State *env, uint32_t val)
     set_flush_to_zero((val & FPSCR_DN) != 0, &env->fp_status);
 }
 
-void helper_ld_fpscr(CPUSH4State *env, uint32_t val)
+void HELPER(ld_fpscr)(CPUSH4State *env, uint32_t val)
 {
     cpu_load_fpscr(env, val);
 }
@@ -260,7 +260,7 @@ static void update_fpscr(CPUSH4State *env, uintptr_t retaddr)
     }
 }
 
-float32 helper_fadd_FT(CPUSH4State *env, float32 t0, float32 t1)
+float32 HELPER(fadd_FT)(CPUSH4State *env, float32 t0, float32 t1)
 {
     set_float_exception_flags(0, &env->fp_status);
     t0 = float32_add(t0, t1, &env->fp_status);
@@ -268,7 +268,7 @@ float32 helper_fadd_FT(CPUSH4State *env, float32 t0, float32 t1)
     return t0;
 }
 
-float64 helper_fadd_DT(CPUSH4State *env, float64 t0, float64 t1)
+float64 HELPER(fadd_DT)(CPUSH4State *env, float64 t0, float64 t1)
 {
     set_float_exception_flags(0, &env->fp_status);
     t0 = float64_add(t0, t1, &env->fp_status);
@@ -276,7 +276,7 @@ float64 helper_fadd_DT(CPUSH4State *env, float64 t0, float64 t1)
     return t0;
 }
 
-uint32_t helper_fcmp_eq_FT(CPUSH4State *env, float32 t0, float32 t1)
+uint32_t HELPER(fcmp_eq_FT)(CPUSH4State *env, float32 t0, float32 t1)
 {
     int relation;
 
@@ -286,7 +286,7 @@ uint32_t helper_fcmp_eq_FT(CPUSH4State *env, float32 t0, float32 t1)
     return relation == float_relation_equal;
 }
 
-uint32_t helper_fcmp_eq_DT(CPUSH4State *env, float64 t0, float64 t1)
+uint32_t HELPER(fcmp_eq_DT)(CPUSH4State *env, float64 t0, float64 t1)
 {
     int relation;
 
@@ -296,7 +296,7 @@ uint32_t helper_fcmp_eq_DT(CPUSH4State *env, float64 t0, float64 t1)
     return relation == float_relation_equal;
 }
 
-uint32_t helper_fcmp_gt_FT(CPUSH4State *env, float32 t0, float32 t1)
+uint32_t HELPER(fcmp_gt_FT)(CPUSH4State *env, float32 t0, float32 t1)
 {
     int relation;
 
@@ -306,7 +306,7 @@ uint32_t helper_fcmp_gt_FT(CPUSH4State *env, float32 t0, float32 t1)
     return relation == float_relation_greater;
 }
 
-uint32_t helper_fcmp_gt_DT(CPUSH4State *env, float64 t0, float64 t1)
+uint32_t HELPER(fcmp_gt_DT)(CPUSH4State *env, float64 t0, float64 t1)
 {
     int relation;
 
@@ -316,7 +316,7 @@ uint32_t helper_fcmp_gt_DT(CPUSH4State *env, float64 t0, float64 t1)
     return relation == float_relation_greater;
 }
 
-float64 helper_fcnvsd_FT_DT(CPUSH4State *env, float32 t0)
+float64 HELPER(fcnvsd_FT_DT)(CPUSH4State *env, float32 t0)
 {
     float64 ret;
     set_float_exception_flags(0, &env->fp_status);
@@ -325,7 +325,7 @@ float64 helper_fcnvsd_FT_DT(CPUSH4State *env, float32 t0)
     return ret;
 }
 
-float32 helper_fcnvds_DT_FT(CPUSH4State *env, float64 t0)
+float32 HELPER(fcnvds_DT_FT)(CPUSH4State *env, float64 t0)
 {
     float32 ret;
     set_float_exception_flags(0, &env->fp_status);
@@ -334,7 +334,7 @@ float32 helper_fcnvds_DT_FT(CPUSH4State *env, float64 t0)
     return ret;
 }
 
-float32 helper_fdiv_FT(CPUSH4State *env, float32 t0, float32 t1)
+float32 HELPER(fdiv_FT)(CPUSH4State *env, float32 t0, float32 t1)
 {
     set_float_exception_flags(0, &env->fp_status);
     t0 = float32_div(t0, t1, &env->fp_status);
@@ -342,7 +342,7 @@ float32 helper_fdiv_FT(CPUSH4State *env, float32 t0, float32 t1)
     return t0;
 }
 
-float64 helper_fdiv_DT(CPUSH4State *env, float64 t0, float64 t1)
+float64 HELPER(fdiv_DT)(CPUSH4State *env, float64 t0, float64 t1)
 {
     set_float_exception_flags(0, &env->fp_status);
     t0 = float64_div(t0, t1, &env->fp_status);
@@ -350,7 +350,7 @@ float64 helper_fdiv_DT(CPUSH4State *env, float64 t0, float64 t1)
     return t0;
 }
 
-float32 helper_float_FT(CPUSH4State *env, uint32_t t0)
+float32 HELPER(float_FT)(CPUSH4State *env, uint32_t t0)
 {
     float32 ret;
     set_float_exception_flags(0, &env->fp_status);
@@ -359,7 +359,7 @@ float32 helper_float_FT(CPUSH4State *env, uint32_t t0)
     return ret;
 }
 
-float64 helper_float_DT(CPUSH4State *env, uint32_t t0)
+float64 HELPER(float_DT)(CPUSH4State *env, uint32_t t0)
 {
     float64 ret;
     set_float_exception_flags(0, &env->fp_status);
@@ -368,7 +368,7 @@ float64 helper_float_DT(CPUSH4State *env, uint32_t t0)
     return ret;
 }
 
-float32 helper_fmac_FT(CPUSH4State *env, float32 t0, float32 t1, float32 t2)
+float32 HELPER(fmac_FT)(CPUSH4State *env, float32 t0, float32 t1, float32 t2)
 {
     set_float_exception_flags(0, &env->fp_status);
     t0 = float32_muladd(t0, t1, t2, 0, &env->fp_status);
@@ -376,7 +376,7 @@ float32 helper_fmac_FT(CPUSH4State *env, float32 t0, float32 t1, float32 t2)
     return t0;
 }
 
-float32 helper_fmul_FT(CPUSH4State *env, float32 t0, float32 t1)
+float32 HELPER(fmul_FT)(CPUSH4State *env, float32 t0, float32 t1)
 {
     set_float_exception_flags(0, &env->fp_status);
     t0 = float32_mul(t0, t1, &env->fp_status);
@@ -384,7 +384,7 @@ float32 helper_fmul_FT(CPUSH4State *env, float32 t0, float32 t1)
     return t0;
 }
 
-float64 helper_fmul_DT(CPUSH4State *env, float64 t0, float64 t1)
+float64 HELPER(fmul_DT)(CPUSH4State *env, float64 t0, float64 t1)
 {
     set_float_exception_flags(0, &env->fp_status);
     t0 = float64_mul(t0, t1, &env->fp_status);
@@ -392,7 +392,7 @@ float64 helper_fmul_DT(CPUSH4State *env, float64 t0, float64 t1)
     return t0;
 }
 
-float32 helper_fsqrt_FT(CPUSH4State *env, float32 t0)
+float32 HELPER(fsqrt_FT)(CPUSH4State *env, float32 t0)
 {
     set_float_exception_flags(0, &env->fp_status);
     t0 = float32_sqrt(t0, &env->fp_status);
@@ -400,7 +400,7 @@ float32 helper_fsqrt_FT(CPUSH4State *env, float32 t0)
     return t0;
 }
 
-float64 helper_fsqrt_DT(CPUSH4State *env, float64 t0)
+float64 HELPER(fsqrt_DT)(CPUSH4State *env, float64 t0)
 {
     set_float_exception_flags(0, &env->fp_status);
     t0 = float64_sqrt(t0, &env->fp_status);
@@ -408,7 +408,7 @@ float64 helper_fsqrt_DT(CPUSH4State *env, float64 t0)
     return t0;
 }
 
-float32 helper_fsrra_FT(CPUSH4State *env, float32 t0)
+float32 HELPER(fsrra_FT)(CPUSH4State *env, float32 t0)
 {
     set_float_exception_flags(0, &env->fp_status);
     /* "Approximate" 1/sqrt(x) via actual computation.  */
@@ -426,7 +426,7 @@ float32 helper_fsrra_FT(CPUSH4State *env, float32 t0)
     return t0;
 }
 
-float32 helper_fsub_FT(CPUSH4State *env, float32 t0, float32 t1)
+float32 HELPER(fsub_FT)(CPUSH4State *env, float32 t0, float32 t1)
 {
     set_float_exception_flags(0, &env->fp_status);
     t0 = float32_sub(t0, t1, &env->fp_status);
@@ -434,7 +434,7 @@ float32 helper_fsub_FT(CPUSH4State *env, float32 t0, float32 t1)
     return t0;
 }
 
-float64 helper_fsub_DT(CPUSH4State *env, float64 t0, float64 t1)
+float64 HELPER(fsub_DT)(CPUSH4State *env, float64 t0, float64 t1)
 {
     set_float_exception_flags(0, &env->fp_status);
     t0 = float64_sub(t0, t1, &env->fp_status);
@@ -442,7 +442,7 @@ float64 helper_fsub_DT(CPUSH4State *env, float64 t0, float64 t1)
     return t0;
 }
 
-uint32_t helper_ftrc_FT(CPUSH4State *env, float32 t0)
+uint32_t HELPER(ftrc_FT)(CPUSH4State *env, float32 t0)
 {
     uint32_t ret;
     set_float_exception_flags(0, &env->fp_status);
@@ -451,7 +451,7 @@ uint32_t helper_ftrc_FT(CPUSH4State *env, float32 t0)
     return ret;
 }
 
-uint32_t helper_ftrc_DT(CPUSH4State *env, float64 t0)
+uint32_t HELPER(ftrc_DT)(CPUSH4State *env, float64 t0)
 {
     uint32_t ret;
     set_float_exception_flags(0, &env->fp_status);
@@ -460,7 +460,7 @@ uint32_t helper_ftrc_DT(CPUSH4State *env, float64 t0)
     return ret;
 }
 
-void helper_fipr(CPUSH4State *env, uint32_t m, uint32_t n)
+void HELPER(fipr)(CPUSH4State *env, uint32_t m, uint32_t n)
 {
     int bank, i;
     float32 r, p;
@@ -480,7 +480,7 @@ void helper_fipr(CPUSH4State *env, uint32_t m, uint32_t n)
     env->fregs[bank + n + 3] = r;
 }
 
-void helper_ftrv(CPUSH4State *env, uint32_t n)
+void HELPER(ftrv)(CPUSH4State *env, uint32_t n)
 {
     int bank_matrix, bank_vector;
     int i, j;
-- 
2.43.0


