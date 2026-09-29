Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C193CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 12:09:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBWdp-0004K1-Hl; Tue, 29 Sep 2026 08:09:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBWdj-0004Jm-1X
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:08:57 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBWdg-0002EG-Ti
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:08:54 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TAj8uE577106
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:08:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8QBLMbbyNu3Sv9NF4oWmxFtz810iWI9KV4fPOYUZEMI=; b=WaHHSryZOCy6ogwA
 ytg8upaqK7WyA1Yf7i3NElmTRE4i6xriVNbcc619r5KP9GFsDdq7JjzEORsck2Sg
 ES9/eM00KiflR4bJmKFDpaR6NOYrtTzh8TX8Wut/i+GiYpcrKeIBoCzRPGzPJCn1
 KNIcfmR9YBnTsQhEyc9+uvAeqKeLpHNKRfjRXZcVQRMJh1D9hWWFNPYzV2uvz50J
 r+nQ61XpDRqG8KbFPpEmVVFGvCJrdnOux/0fC1ipaRNHkSukA+IKAgUESiy2GQoT
 lKoBSwVNsN1d2BXYgpKNImWbpFGmZu1IqG9Myg+XAEmFGhqrdZPxYdfkPFq/AFxP
 Vst5MA==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h08e0h9tc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:08:51 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-988c9d1be19so78304241.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 05:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790683730; x=1791288530; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8QBLMbbyNu3Sv9NF4oWmxFtz810iWI9KV4fPOYUZEMI=;
 b=JJqxgU75F6sxoRPKPMpRxmr/AxJM1gZXsL9NOYNqZMe/9z0CN5KnFqR0zFSslKnqAU
 1t9zwPtW9T1cVaHTJ0f8xDbMJAbI8wIFpaVeZ7qRWmkAc+swJh/UcA32kOYs4G1R8r+d
 PQDgJ2jV4kSmgzwN8HS4Z7ub83kjkMX85+rA0+I1SicS24/YD2Z75kSXfQrvZ1C+izOS
 5q8j5D1zEh/MfZMPG2oLS229rTEZbCCQQWLWA8WwrNICL7OHd2QiihR6Vs5paHDBx+e3
 f4Vu8WrlJu4lC4nq5JM3uhq/JL88vyIW4TPgbNp9J/v0GOXAZYTwWj3OhDD6525RolNE
 9myw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790683730; x=1791288530;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8QBLMbbyNu3Sv9NF4oWmxFtz810iWI9KV4fPOYUZEMI=;
 b=jjSWsihb8iRQU6wVkje8aG5G61YThA0NVZdCXkG62Ubc/YB+zC37CZdEfSo/haoUE8
 rieVKPCsxR4UCypNDw/lVPXMVvXTDADM6hGu3XCUJSO87kaF0e2dMmYQ6kykY4IsM9mG
 fKV2sMSrcY3Wt32lNZhebyVtN5RnSlbB3W1cDZHTPBHhR5XO77Bw3gMdWWkC6RO0cOj7
 sDWIVreq8C0PilprVBc3CvP144sOdixquUCgq/iC3ZzXsZ4Qvj7s3Gft+EUhv8761rX7
 2/zSrudQLdJ+u8bgzhUfPInyWS7k4cMdjLVO9dGlzVr/Kq/ymaMD0z6hsC4vVgnXSujX
 yLVg==
X-Gm-Message-State: AFq9FYIOXfJ5a8Lsu3k/Yi24FL9DRcH6J0GcQVBYXJ4ASOQe3omat01N
 GUXZ9Moz7mnKi1HULdM9RMMoJgXY+0EA/ujaCiS7ej4KzPvbB2RFE6cg8DpjdN5ReFyiF3jMZ6c
 IYCBDodyWMDULxEfqoD6EmlPzgfnsWSkHwGC/r/OVkJL1bgveoY28I3I62VDGjuqtdQ==
X-Gm-Gg: AYBFou0Yl9/wn6yfhgiMQM6uVXTjgWRYs7eh5PelqhzPSZXnZzfPDCXHR6elcRf5LVr
 Bd5gYN8RxKaJHbQ3s1mKu6fAPw5zWd5Vm82mmU/YmfA9+gfH2wk/hho1BdyiHZydTCrwNCFX9sI
 Uo+CZlEgSTRyGr2Jiy6lCYN0TqCRDdrRRw6Xb6YSVNKhezXZ1zSDPwAnf+jiy/cXir+bIPc8glP
 QSBvhVaAsPSPeiIxxE2zPN9ICpFkSeDK2B6nzscETfGe83nlwbcwqYtAdKX+VLj09KcWrI1nkvV
 ZARZCBNiy+yKqId/NUSye29jybnLEDVL6Z5//4UjPEJqppUZQvEt6vBRMMh4X8d4O4KrISAgnmn
 OL/KkZr+ShSUMG8Dnl1gy97KyK6rARMJNlAo0kYCZ
X-Received: by 2002:a05:6102:a186:20b0:7af:dc0d:7578 with SMTP id
 ada2fe7eead31-7b94edb181amr402279137.8.1790683730506; 
 Tue, 29 Sep 2026 05:08:50 -0700 (PDT)
X-Received: by 2002:a05:6102:a186:20b0:7af:dc0d:7578 with SMTP id
 ada2fe7eead31-7b94edb181amr402267137.8.1790683729941; 
 Tue, 29 Sep 2026 05:08:49 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00d0f66cfsm85295515e9.14.2026.09.29.05.08.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 29 Sep 2026 05:08:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 1/2] target/rx: Unify BRK and INT trap handling
Date: Tue, 29 Sep 2026 14:08:37 +0200
Message-ID: <20260929120838.13583-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929120838.13583-1-philmd@oss.qualcomm.com>
References: <20260929120838.13583-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA0OCBTYWx0ZWRfX3pKMRl/JR77/
 h8bDj1sXU11vu9efjOdRJ4wUgnJPlnYhe0pwojQvQTE8QYQAjeQbyuMg0np1mxedUEJ50ff8LZw
 wM7DkeAHuf6zaZlQp2znybA+tcQvbaA=
X-Proofpoint-ORIG-GUID: Pn_QlGlJ1rIAvRPjiW6Kck5H3WRfXcA5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA0OCBTYWx0ZWRfXx4zp0aREuglM
 XfQVsKtXVnNjWojl7Nf6YoMh0hXnBJixWOmK2ateaDSRfSpuqqvey7FYFhvoUs4HqcCn6D2v2/6
 CkH6SQdC2ubkFNMBro/0BkBkb5w0vKmAxV8n0/QwxJ/BRZQiD/UId2gOt9S2Kw8G3tXjGJT4Med
 xbtI8W/9uvczQvyTvwBszsOO/xZsSWLogEHNzVl4k4gZSnJxS84HCCvNfS9WsSrWzp1urxRuLEz
 8yvKruIcw+lY1LA6IJNLW+HxxVjLAG2LHIiULQXN4znAVHdtK1obwH+16pJH94i9wV7y4hxt8BQ
 j0PPY4yvCLkh1/ZMM+Lc96V7D6cELU6h8M+/g3gLhITSzyovyp1s11WY2DF5QrG1SnvNl/ge3lt
 offtU8QeOY7qbx/EMQGFwO8z1y6+Igy0SpgfJMMJCSAEBuWLRixBxYyjcMDdQzY0CZQTq42eLAZ
 CoNGURevyu+DmvArR3Q==
X-Authority-Analysis: v=2.4 cv=WJ7qzXsR c=1 sm=1 tr=0 ts=6abbaa53 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=jDMzgGwzCE0q-kHIl9cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-GUID: Pn_QlGlJ1rIAvRPjiW6Kck5H3WRfXcA5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 adultscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290048
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
through the same trap helper.

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


