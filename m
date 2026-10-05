Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D4CCCA5FFC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 18:59:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDnst-0001dd-Oe; Mon, 05 Oct 2026 14:58:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDnqj-0007f3-4X
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 14:55:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDnqh-0005oE-AJ
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 14:55:44 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695HM0Ge2207613
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 18:55:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Uf8G6uwGQ4fFmX/bv9LjNkswZP3kZc7GD0RuFl8TYXA=; b=fhCOvD7MePLtgFXk
 fQj9At8GpLZ7gD1CJUTMhcoK2+xLbtQnWZE6gn20dUYlxLvTYRtosLjZCHiUIDOc
 7+9DiwBDZpCnH+915iegNFMZs+33x1x/rcVojZXgLAnpc7jHkLEvQlKlLt/B4RV9
 MjuKPWGI3wyCoTi+Ypt65ZFBCNtaNpITl2vfDMJ9r25xe+/y6PlKdTHHWgMG91Wy
 lDOL0aiFTSqvvOtbAbpM1+Cp2fSO7z7XTI1cbRiNmiMf+nkzs+nnfd4WC3KYKhIJ
 6O7VFN7wdRQmkhtrYAUoES11NtxxmbV+UPe5F7RPdxI06CM1avZ9xGyO+iCUYl2n
 Me4x9Q==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4a7dswwh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 18:55:32 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-34bbf2e3c5cso6198229eec.0
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 11:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791226531; x=1791831331; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Uf8G6uwGQ4fFmX/bv9LjNkswZP3kZc7GD0RuFl8TYXA=;
 b=TSsFIM8COJyfU1+OKu2dc+dd5sCM+h/ytM73i7+Rs2QAByW0sZhH2BpyyKr8gDJsac
 FMcLsXVBH8biCniAVp+c79rkovvw7JYPqx1w6TOMgW4dWxMetX07rOE0bhfY8rNBeECl
 LkO/R1HrQ4dV7DQKrn8M7vVRUHhKd0B+pKDhBUSO3/iCwt2KRnvcgtrwD8MYsPlanCzZ
 qfO/Z5sNEsUAOgpRzhvv+Tnw2Pj/uQIiedVdnvIwsa5TmTG3GqaK4BWCuVkazAVi4/fE
 3AAAA+rNVNGP3BI8KW3a3gIFUInu8qNv3VsqG1u/PXZxjCzDcQaON4QlJcfn6Go1KqZ7
 QEYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791226531; x=1791831331;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Uf8G6uwGQ4fFmX/bv9LjNkswZP3kZc7GD0RuFl8TYXA=;
 b=LoEBsIOJYi2y55BFyHgd6TgXCRbFGOvPKPY6DDOBA4zz4CWR0lF8KeaXHN26Az75io
 ae1POpVldjrfPXCkI0KltdbOCrb2I09Jpq+6kih9JfgO4VAizCAOI0/KgCPbWrWoInb9
 Cp7zTt9NzQBe1yTOUc9VImrCv4+/4EU5TQH6bXBwFZarVp4MowxgDD+5wZ7vR4OT8RoJ
 /f+PHG7Rpi1BQ3t9NCvnKXugQNX9s3NTLSqP73beXj1cIt/c75tsoWX+CbT0W8A0EAzB
 g9TUIuOvPNO/VQo96cQWQfeWAy/vWDOuZ6GvWL6NtEU37cpOegcPVz51zSRmaAzT+lte
 ZHzw==
X-Gm-Message-State: AFuF++l3bmTFswldoIylsR/yENahilKhPkUJRZOF7Ic8BxwOVywzprhT
 j63Ow7Nn9WlarQNBoPWFebjvLe2kuhJrz/HfBxx6G/LPLSHQ40sNfi51V74OTV9HZ6K5T++tknc
 p9hTM14Ch3i65R0J89+sG37wZDxgMEulr9R8h9UoRkvguIITN/M230WWJYthBgqONYA==
X-Gm-Gg: AYBFou0eSXxAMqRmddpdRCwGLvicg8QrGSxhYjAM1GaCqrisZfJr57IS+cbuXN1F4ag
 ioPurV8UMHiGdTC6ZTOVw0VJPAOSMSmT85s2x3tPhsHkL8FW8nd1WXmkbtEbMv5P+Plg+In+Rfu
 kl1UGYwk9sf8v3SzWnLLAaSh5hpaDvLgA/tbdT2RFBSYUuOOT/skB071i6f+PgjldPO8UqRw++w
 f8Jp8fSlO/cWanuM3u7C2N1mWALnk0UcqJBo8QBTzYPc6FKK+FZi0dppk+LZ9Zohi1YSzC0ACSo
 3ucMuzxE7wFByUenW2T7jj28UudHudZhKQAMvwfthTbeHPPd46AsNSMuSoFHr2Pib1HxL26UU7/
 QOOyRwESUSPVvjmV5S6dnL/rN5sPOj5EFqB/6r1m4CqxPMladf9XoQ0L0lHm2
X-Received: by 2002:a05:701b:450b:10b0:145:287:ce91 with SMTP id
 a92af1059eb24-14f5bbfa54cmr15425430c88.14.1791226531305; 
 Mon, 05 Oct 2026 11:55:31 -0700 (PDT)
X-Received: by 2002:a05:701b:450b:10b0:145:287:ce91 with SMTP id
 a92af1059eb24-14f5bbfa54cmr15425406c88.14.1791226530703; 
 Mon, 05 Oct 2026 11:55:30 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-15d7234c2a2sm602092c88.0.2026.10.05.11.55.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 11:55:30 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 14/22] target/rx: prefix helpers conflicting with other arch
Date: Mon,  5 Oct 2026 11:54:50 -0700
Message-ID: <20261005185458.405929-15-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261005185458.405929-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261005185458.405929-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA3NCBTYWx0ZWRfXz6XL1sGoOs9O
 SbIn/hlDutQmKtO4/9Y9xp1hQ3XZ1ne62YVDFU+EgaEbApK8nY/NgGCySghVqP4UTvoztRzjfnQ
 yKKB8PdcGIaflmG2Afw2tPQ0tGyDfls=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA3NCBTYWx0ZWRfXwqzo9Tp6cPcS
 tNA+lqYCVSyrCbNXRQbwtGlYtOR+E81oi/hHcBuLbDhfFJ4TggvXmvNCZLROXzEVnd03qtwO+Fq
 xFC9sHB1KoXYC4agKQbKu118XGZ3FH+Vfoc/yv614scYSw4wyAtdt7btnniJ++MSMshXvipFjNf
 14ApoPEf+wPlpOQNmQtIblMdqAIMinGNnH3NMcWHub/aab4gYPrMZlgrLjLjzvLRadIWDEEWmUD
 PDU6+HwrXTWKyJgCG4AO01rN6lUGwvpiuixH2ISyWYXpUBmsLJlRyywIoPHxaA6pGl5Qw08XsFg
 yW+0SxMSzMdY+c8ke5gWFXABrsHeve4Z7AO8yxSiEM5vjtf5feoI47HkdoZ1fBtoaNpyQxfepGy
 WMTJuxJNG6RTsa7MwJ8Fn5TfHV2DWGvK931ykhA5TUI/KaiGd1P3GjV5uGojSTG7v82vnZlvIfd
 kcCmdwHkWsblJf4DnDw==
X-Proofpoint-GUID: XuxJi9GqQJMDlNy1mhLcH2b_hneMcqcK
X-Authority-Analysis: v=2.4 cv=SvwFe/O0 c=1 sm=1 tr=0 ts=6ac3f2a4 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=6grbfbtxqwKGXmKduJgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: XuxJi9GqQJMDlNy1mhLcH2b_hneMcqcK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0 priorityscore=1501
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
Link: https://lore.kernel.org/qemu-devel/20260930020108.217892-15-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/rx/helper.h    | 12 ++++++------
 target/rx/op_helper.c | 12 ++++++------
 target/rx/translate.c | 14 +++++++-------
 3 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/target/rx/helper.h b/target/rx/helper.h
index 8cc38b0cb71..b1ef843be1e 100644
--- a/target/rx/helper.h
+++ b/target/rx/helper.h
@@ -4,11 +4,11 @@ DEF_HELPER_1(raise_privilege_violation, noreturn, env)
 DEF_HELPER_1(wait, noreturn, env)
 DEF_HELPER_2(rxint, noreturn, env, i32)
 DEF_HELPER_1(rxbrk, noreturn, env)
-DEF_HELPER_3(fadd, f32, env, f32, f32)
-DEF_HELPER_3(fsub, f32, env, f32, f32)
-DEF_HELPER_3(fmul, f32, env, f32, f32)
-DEF_HELPER_3(fdiv, f32, env, f32, f32)
-DEF_HELPER_3(fcmp, void, env, f32, f32)
+DEF_HELPER_3(rx_fadd, f32, env, f32, f32)
+DEF_HELPER_3(rx_fsub, f32, env, f32, f32)
+DEF_HELPER_3(rx_fmul, f32, env, f32, f32)
+DEF_HELPER_3(rx_fdiv, f32, env, f32, f32)
+DEF_HELPER_3(rx_fcmp, void, env, f32, f32)
 DEF_HELPER_2(ftoi, i32, env, f32)
 DEF_HELPER_2(round, i32, env, f32)
 DEF_HELPER_2(itof, f32, env, i32)
@@ -18,7 +18,7 @@ DEF_HELPER_2(set_psw_rte, void, env, i32)
 DEF_HELPER_2(set_psw, void, env, i32)
 DEF_HELPER_1(pack_psw, i32, env)
 DEF_HELPER_3(div, i32, env, i32, i32)
-DEF_HELPER_3(divu, i32, env, i32, i32)
+DEF_HELPER_3(rx_divu, i32, env, i32, i32)
 DEF_HELPER_1(scmpu, void, env)
 DEF_HELPER_1(smovu, void, env)
 DEF_HELPER_1(smovf, void, env)
diff --git a/target/rx/op_helper.c b/target/rx/op_helper.c
index 36df7d377e5..5a7a87943fe 100644
--- a/target/rx/op_helper.c
+++ b/target/rx/op_helper.c
@@ -147,12 +147,12 @@ void helper_set_fpsw(CPURXState *env, uint32_t val)
         return ret;                                                 \
     }
 
-FLOATOP(fadd, float32_add)
-FLOATOP(fsub, float32_sub)
-FLOATOP(fmul, float32_mul)
-FLOATOP(fdiv, float32_div)
+FLOATOP(rx_fadd, float32_add)
+FLOATOP(rx_fsub, float32_sub)
+FLOATOP(rx_fmul, float32_mul)
+FLOATOP(rx_fdiv, float32_div)
 
-void helper_fcmp(CPURXState *env, float32 t0, float32 t1)
+void helper_rx_fcmp(CPURXState *env, float32 t0, float32 t1)
 {
     int st;
     st = float32_compare(t0, t1, &env->fp_status);
@@ -407,7 +407,7 @@ uint32_t helper_div(CPURXState *env, uint32_t num, uint32_t den)
     return ret;
 }
 
-uint32_t helper_divu(CPURXState *env, uint32_t num, uint32_t den)
+uint32_t helper_rx_divu(CPURXState *env, uint32_t num, uint32_t den)
 {
     uint32_t ret = num;
     if (den != 0) {
diff --git a/target/rx/translate.c b/target/rx/translate.c
index 132d495710c..bd445bc0634 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -1252,7 +1252,7 @@ static void rx_div(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 
 static void rx_divu(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    gen_helper_divu(ret, tcg_env, arg1, arg2);
+    gen_helper_rx_divu(ret, tcg_env, arg1, arg2);
 }
 
 /* div #imm, rd */
@@ -1864,16 +1864,16 @@ static bool trans_SATR(DisasContext *ctx, arg_SATR *a)
         return true;                                            \
     }
 
-FOP(FADD, fadd)
-FOP(FSUB, fsub)
-FOP(FMUL, fmul)
-FOP(FDIV, fdiv)
+FOP(FADD, rx_fadd)
+FOP(FSUB, rx_fsub)
+FOP(FMUL, rx_fmul)
+FOP(FDIV, rx_fdiv)
 
 /* fcmp #imm, rd */
 static bool trans_FCMP_ir(DisasContext *ctx, arg_FCMP_ir * a)
 {
     TCGv_i32 imm = tcg_constant_i32(li(ctx, 0));
-    gen_helper_fcmp(tcg_env, cpu_regs[a->rd], imm);
+    gen_helper_rx_fcmp(tcg_env, cpu_regs[a->rd], imm);
     return true;
 }
 
@@ -1884,7 +1884,7 @@ static bool trans_FCMP_mr(DisasContext *ctx, arg_FCMP_mr *a)
     TCGv_i32 val, mem;
     mem = tcg_temp_new_i32();
     val = rx_load_source(ctx, mem, a->ld, MO_32, a->rs);
-    gen_helper_fcmp(tcg_env, cpu_regs[a->rd], val);
+    gen_helper_rx_fcmp(tcg_env, cpu_regs[a->rd], val);
     return true;
 }
 
-- 
2.47.3


