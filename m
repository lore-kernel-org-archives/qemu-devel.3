Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0749BC9832A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 06:58:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBRmz-0005zP-Cf; Tue, 29 Sep 2026 02:58:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBRmo-0005yJ-OJ
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 02:58:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBRmm-0001cQ-Vw
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 02:57:58 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T470ab419560
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 06:57:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MbuXH0xr6u/Sl1O/jb1ZFJPYnF1pHVJte0RNDEonFdA=; b=lC0YpYAxjud7P4cg
 UVTM5I3L3De6deNNsIa2qBEelSnxijqVLreAVhUsYx6Ih3xK+LNbwqnFYzy6XIne
 UEqTk9dYg3aOW+xZOg+wjZSE8F8jPXtQEGz9v+8oT0x8r/JXZxdjAigw9c/2IQnM
 Q5rC5sDYHFTgc1+p4bIl4FYeZqfIKIwHGDQ9GkeyLOz1o0s2pzLdywcMPyvcZrkX
 PJtM4Vj001+dnkjkJck/pbjCK5MUZ4qGRS5FfKt21GSqJawK1lfEsEayy3JxNdnz
 Zm+tapXp+dcgWTpbNqVnV4ByLM+EUn+94WTbucJKbMoDMVG7xsUWEMJRVlPbbKiX
 Op1axQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyxmua46a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 06:57:54 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93c614646e9so417414885a.0
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 23:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790665073; x=1791269873; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MbuXH0xr6u/Sl1O/jb1ZFJPYnF1pHVJte0RNDEonFdA=;
 b=OzGD7JG1oXCa5sLmiPbSb3yMeknJqXk6iVCJq5LJ+6apXdVRbUBb4w9DL17Itl0GAN
 /uob4Yx4GEvYENp/3YYjsS9Cb5SUjmW6tAFc5SBUBjd70u5dMiGk9r7AAhclyDN5D3ZE
 B08P97s9snpQOkVEd2GUUSL9E8jgARFloq3INdG9r38843a2U6IZATE4mvFhIHHN/0Ns
 GDZrY2Kz/gq1tbcdzcr5kGiHuFeTVOfq0QTEyf/i7addNQkPouZDkuI8qjTHGowtXtjO
 svXzaO5h0oP/ANy30gbVuJtcA1IjypCgYOinknUMzTUkT0IQjNmbI8CHPSU+XfPk3UvH
 dTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790665073; x=1791269873;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MbuXH0xr6u/Sl1O/jb1ZFJPYnF1pHVJte0RNDEonFdA=;
 b=EPWZq7WzCYmKHSOGg8/qI9VxdcQ94bVw8Embf0M83y5Ko7h5bAttAC2Sdiu0jGAoxO
 LEBXYANBElNMWca6V2rJfBsi3P7Z1IWPefXik2muyTcXUJRS0JVzdxh9qRlx02n+q4WG
 rM2YY4lZZGCF2eRmyew4Cw+4I6zrYoWbmqcoKAmRLP9UrZUvULWHoEm0bWW66ysEMBUM
 9jpeiePR2rTPaEJM1foYX7RCR9ivLYNAGcDtbVVES7sajecKYk7x48PpZQ1AaUbXFxdN
 xgqkkWKRHQrsMIkLHOlJx7tENvnh6avLT2hwN5k3wq45dQ9NoyoAftVQSg/DqUULZ+mN
 LxFA==
X-Gm-Message-State: AFuF++myob6s3uA4zaPqLcn3EL6MjEZZT6meGQmBMQfF/Fn7bPLzDZN5
 4BCkGubLwrusGoqdJrvIqZqZhbEVjvUdww+i5x6xCIFlI+hNLjnq0klHFS7/aNRfbHCJ0zeLw+L
 r7xAWN+1YW/svC+/x0ahLPMpil7bZzZA7jp8p8yPHVybmtYGVm+Cr1SiuALLcBm1m2A==
X-Gm-Gg: AYBFou2Gq3e8dlwgH1sLQ4j9TZUI5C7SQ3KEWm0GgBj883EKQSMn5YBarQQVTfCdcGj
 Y54/go3oAAt8RNICnuOSp6Tw19mxB/cLdXJGoUmIuVvG6DsSzC2EIfm7kLZiSXrdpQCjLhf3jRk
 ydqB9eM+UxR3tvOg86LusS6MXBFbHGCUbatpGw15/UYL2ZZ70vTsP+KME+jEcfeJFqTK1tqNCbQ
 F1PcQHYn6ER+4JXoA0yJpmDEM5R6byP3Mo+F50lFZWNEGvMK8KOIh9Pux+02aJRsqAAu8/0rBEZ
 Bo+ep4YbAHqcigMas69hnoDPNiTmGuUT+dsubdMNWQbD3/qnpoJU8NnuvLkj+7AUk9ytsIFWBWX
 ueVj7B7ftFRa1ZhMO8gfi7m/essFO1k3GMboUTxfR
X-Received: by 2002:a05:620a:7014:b0:937:11c9:37f1 with SMTP id
 af79cd13be357-93c43bbcf96mr2511598785a.16.1790665073138; 
 Mon, 28 Sep 2026 23:57:53 -0700 (PDT)
X-Received: by 2002:a05:620a:7014:b0:937:11c9:37f1 with SMTP id
 af79cd13be357-93c43bbcf96mr2511595985a.16.1790665072618; 
 Mon, 28 Sep 2026 23:57:52 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af506fdc1sm1630954f8f.21.2026.09.28.23.57.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 28 Sep 2026 23:57:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 1/2] target/rx: Unify BRK and INT trap handling
Date: Tue, 29 Sep 2026 08:57:49 +0200
Message-ID: <20260929065750.9550-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAE2XoE9VC6YfqsOQBM_KLrdaKpU-=bD9CscCDGi63EsQt-EhFg@mail.gmail.com>
References: <CAE2XoE9VC6YfqsOQBM_KLrdaKpU-=bD9CscCDGi63EsQt-EhFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAyNyBTYWx0ZWRfX4OccyAKe/GEU
 o8oPuLiWfy7PDiXbOJlxpu2XCl9U0ttXUOqHK1MPcB8tZixcUqSoAHdpMjZ/YSikyOIDS95n/hq
 a8O12hjUmnOAnwIrgJ231WLb6VEXY4nJgVIIEW9eBNAOYsxayX+VM7ta2I3anD6JkwvuFxor2p4
 NKKgdiclWO3urquc8ZMShl/AD8W0Wj84oWPCHUkgj8wfI3i8wBfSraPbyNHEh+ROFCf6t1/+Eh2
 KzOw5gT8zJXU6pqG7nbKmVnDlzBiNb0gkY9HkrxYHy9elAdczIzu8ajgRonSwWqCjQiCXVgfAy8
 YiRpVmJ+U4rWrHkHfAtxjMzpF5NW3DZGXKzzN+H222FiO+AXqBvwfOeiHscbKQ/qmloFz85iiwE
 oQWCcuXAimiOlm++Wd0ub+DWaia6+3GDuBKmUPwbhUMVORl/9uiagiZ9YTufNqv+XTj0NShPrZ6
 1YGYSW1U+iLGcM3McdQ==
X-Proofpoint-GUID: Os_yH3Gc9VdXMkMWJgcn3noltYA_Ff-r
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAyNyBTYWx0ZWRfXxo9+24HEUIzM
 e5nka3cHbk7idChFaBazaq3yLG2liiur+HhlYDc1bs/DEPNdRpvtmXNSjZxZxrpJPpgDs7sGtdt
 VVz2EkT8aY5j914wTI9oAKbL9TGcx/s=
X-Proofpoint-ORIG-GUID: Os_yH3Gc9VdXMkMWJgcn3noltYA_Ff-r
X-Authority-Analysis: v=2.4 cv=c70+0h9l c=1 sm=1 tr=0 ts=6abb6172 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=hMD_izP3oHWVbQvYQc4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 malwarescore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290027
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

BRK is equivalent to INT #0, so route both instructions
through the same translation path and trap helper.

Remove the duplicate helper declarations and implementation
used by the two instructions.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/rx/helper.h    |  3 +--
 target/rx/op_helper.c |  7 +------
 target/rx/translate.c | 21 ++++++++++-----------
 3 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/target/rx/helper.h b/target/rx/helper.h
index 8cc38b0cb71..f3897ce7619 100644
--- a/target/rx/helper.h
+++ b/target/rx/helper.h
@@ -2,8 +2,7 @@ DEF_HELPER_1(raise_illegal_instruction, noreturn, env)
 DEF_HELPER_1(raise_access_fault, noreturn, env)
 DEF_HELPER_1(raise_privilege_violation, noreturn, env)
 DEF_HELPER_1(wait, noreturn, env)
-DEF_HELPER_2(rxint, noreturn, env, i32)
-DEF_HELPER_1(rxbrk, noreturn, env)
+DEF_HELPER_2(trap, noreturn, env, i32)
 DEF_HELPER_3(fadd, f32, env, f32, f32)
 DEF_HELPER_3(fsub, f32, env, f32, f32)
 DEF_HELPER_3(fmul, f32, env, f32, f32)
diff --git a/target/rx/op_helper.c b/target/rx/op_helper.c
index 36df7d377e5..6782912247e 100644
--- a/target/rx/op_helper.c
+++ b/target/rx/op_helper.c
@@ -455,12 +455,7 @@ G_NORETURN void helper_wait(CPURXState *env)
     raise_exception(env, EXCP_HLT, 0);
 }
 
-G_NORETURN void helper_rxint(CPURXState *env, uint32_t vec)
+G_NORETURN void helper_trap(CPURXState *env, uint32_t vec)
 {
     raise_exception(env, 0x100 + vec, 0);
 }
-
-G_NORETURN void helper_rxbrk(CPURXState *env)
-{
-    raise_exception(env, 0x100, 0);
-}
diff --git a/target/rx/translate.c b/target/rx/translate.c
index 132d495710c..d0910fbf8e7 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -2170,26 +2170,25 @@ static bool trans_RTE(DisasContext *ctx, arg_RTE *a)
     return true;
 }
 
+static bool do_trap(DisasContext *ctx, uint8_t vec)
+{
+    tcg_gen_movi_i32(cpu_pc, ctx->base.pc_next);
+    gen_helper_trap(tcg_env, tcg_constant_i32(vec));
+    ctx->base.is_jmp = DISAS_NORETURN;
+    return true;
+}
+
 /* brk */
 static bool trans_BRK(DisasContext *ctx, arg_BRK *a)
 {
-    tcg_gen_movi_i32(cpu_pc, ctx->base.pc_next);
-    gen_helper_rxbrk(tcg_env);
-    ctx->base.is_jmp = DISAS_NORETURN;
-    return true;
+    return do_trap(ctx, 0);
 }
 
 /* int #imm */
 static bool trans_INT(DisasContext *ctx, arg_INT *a)
 {
-    TCGv_i32 vec;
-
     tcg_debug_assert(a->imm < 0x100);
-    vec = tcg_constant_i32(a->imm);
-    tcg_gen_movi_i32(cpu_pc, ctx->base.pc_next);
-    gen_helper_rxint(tcg_env, vec);
-    ctx->base.is_jmp = DISAS_NORETURN;
-    return true;
+    return do_trap(ctx, a->imm);
 }
 
 /* wait */
-- 
2.53.0


