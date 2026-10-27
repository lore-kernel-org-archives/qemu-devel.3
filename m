Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972AB606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 06:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bUWEc9Xl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLafv-0001qx-3P; Tue, 27 Oct 2026 02:28:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xLafm-0001q7-AT
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:28:38 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xLafk-00088f-Ix
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:28:38 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2ea0efd636dso30229395ad.0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 23:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793082514; x=1793687314; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NngKpkxaeD2mL/wDZLDaNL3adZQlLS+NdJA6Bfcn6ZE=;
 b=bUWEc9XlE0mWGeWVfgQCAemtWBb4RdktCsplYatZH9X/o+JQJd2h/YfXO5zlEgSJqr
 KNM+jLsaDPdeTF2e76Adx/kSBs3U/C9AlJoCdARq0SpW96zcW+51kuyhk8D2h3j3gBX/
 YSLSnR8Zuz9LKOixs3DCKYEnodyIkrqt3gViw51D8pdoSOsyEq8kMUYT82BMMs/L3fh7
 LStqpxraU1yiejzw175NoH+MROySZvGj3qdRsfkDLJ+0KJbYVyCuVnSbKN4Et/EkmMGA
 P0IvVMryC5uo0Dl4sylDb1IpJRnlEjDQvCq6QYdpkxre0ADONaLcRUZaPC0fgegs6fJa
 oj/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793082514; x=1793687314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NngKpkxaeD2mL/wDZLDaNL3adZQlLS+NdJA6Bfcn6ZE=;
 b=PMwtJ50FyuAx1+McTFi7xfdrHpnvj2a6u/yM8RRyy5zpxj+XpDq2F3WRZj52fYkwp5
 np3HTj4vCjdjLGZWstjw2OX2hm0iuBqjv/ubwe1ErYJ7+aYTfhWcmThV8VnKDiItHH+2
 LsT0mXm6gtVcuTosFreR/szmgeJEYLjSJQFKPAsoitSUari3CbJL1+3ocJszMC6qSqiP
 L4SmWgLoiKMAALpF2QPY9dmEI19F4GPfBCchG6Po6FT8VD3Obxta24FU1EqHWi5WNBU5
 RnQR9MEMobh4tq1aUrltG7Z92UTcX2UUBU+DAp0dC29ANUWfR0YGiZ++iFnp66+JFX3p
 saLg==
X-Gm-Message-State: AFq9FYIC+KWeQRhLYSVXcyCacCFWcxcM0EAASyDAkOJK9BoiYiVaC6kv
 os0mLf3+sIwyOBLP3xsAz12YgKI1uvd6kB+Bq7zylkWjTrVQxVUJNWnF8Ng1Jg==
X-Gm-Gg: AYBFou2KwL+2u4XB9+KdIku6NzU2OEnd/9zojFHc/TUtEhNcyqKdqxD8K7RrdbzENM8
 fvukTIkeQnvx+mI0H0rrcpriGnoDAV/l0f5FtE+/2Cj6ILXWMIsEukRy+3+Z4BH+woKVZN/JVPl
 Dl74oKUgnxRIkdO1wmMl0JwfeehsEXUYwsV7q52IM3n8mVvNtX2SkxiaXSVe6ZrcksFS6Pg1uwC
 6i6PKu/I6iFtX56jEnHs7/lm/L7YRJQjHXURli06NpB7SH5fm8PLNSaYm1hj72AyFx8k8Sf8y8I
 uAW2tgf2bdK4OXNYslgQOhoGAsX3/Z1imAnN37KJkrd/0+RpKmX2jPTTH7MlCWyRu63Uzn3F45p
 R2H8OdtAkMCCRfhAGOZLtRTZvpwF9uqEiJ+kABGkfemdN3s2Xhe/uigthndCWo4Js0ya3nGyKT4
 p18A6RYi/M9sbMVjySxjJTaC+XIVZBfF873guJshaT2wdhgOFeC80+2CHdXvBvaiaGVD8ajhOEI
 7NXuiuTlzRj56Or5qa+JfXbtD3ilDPTCdu3kGCiwZQguwt369GqQqdLklGKN0IHujL/HcMIKg==
X-Received: by 2002:a17:90b:3f4c:b0:3ac:95d7:2fa5 with SMTP id
 98e67ed59e1d1-3adeae7b904mr7550517a91.44.1793082514226; 
 Mon, 26 Oct 2026 23:28:34 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae401bf352sm2358541a91.0.2026.10.26.23.28.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 23:28:33 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Mingliang Liu <liumingliang.dev@bytedance.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 02/29] disas/riscv: Support vabs.v pseudo-instruction
Date: Tue, 27 Oct 2026 16:27:41 +1000
Message-ID: <20261027062808.1995205-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027062808.1995205-1-alistair.francis@wdc.com>
References: <20261027062808.1995205-1-alistair.francis@wdc.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mingliang Liu <liumingliang.dev@bytedance.com>

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Signed-off-by: Mingliang Liu <liumingliang.dev@bytedance.com>
Tested-by: Chao Liu <chao.liu@processmission.com>
Message-ID: <20261015134337.3354723-3-liumingliang.dev@bytedance.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c        | 6 ++++++
 disas/riscv-op.c.inc | 3 ++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index fd6e0bd61379..ca0d6e90b373 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -104,6 +104,7 @@ static const rvc_constraint rvcc_j[] = { rvc_rd_eq_x0, rvc_end };
 static const rvc_constraint rvcc_ret[] = { rvc_rs1_eq_ra, rvc_end };
 static const rvc_constraint rvcc_jr[] = { rvc_rd_eq_x0, rvc_imm_eq_zero,
                                           rvc_end };
+static const rvc_constraint rvcc_vabs_v[] = { rvc_rs1_eq_x0, rvc_end };
 static const rvc_constraint rvcc_true[] = { rvc_end };
 
 /* pseudo-instruction metadata */
@@ -243,6 +244,11 @@ static const rv_comp_data rvcp_fsgnjx_q[] = {
     { },
 };
 
+static const rv_comp_data rvcp_vabd_vx[] = {
+    { &op_vabs_v, rvcc_vabs_v },
+    { },
+};
+
 /* Convert compressed insns into normal insns via pseudo expansion. */
 #define DECOMP(X)  &(const rv_comp_data){ &X, rvcc_true }
 
diff --git a/disas/riscv-op.c.inc b/disas/riscv-op.c.inc
index 07b56f5d529d..425473ee61b5 100644
--- a/disas/riscv-op.c.inc
+++ b/disas/riscv-op.c.inc
@@ -491,9 +491,10 @@ OP(vaadd_vx, "vaadd.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
 OP(vaaddu_vv, "vaaddu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
 OP(vaaddu_vx, "vaaddu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
 OP(vabd_vv, "vabd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
-OP(vabd_vx, "vabd.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vabd_vx, "vabd.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm, rvcp_vabd_vx)
 OP(vabdu_vv, "vabdu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
 OP(vabdu_vx, "vabdu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vabs_v, "vabs.v", rv_codec_illegal, rv_fmt_vd_vs2_vm)
 OP(vadc_vim, "vadc.vim", rv_codec_v_i, rv_fmt_vd_vs2_imm_vl)
 OP(vadc_vvm, "vadc.vvm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vl)
 OP(vadc_vxm, "vadc.vxm", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vl)
-- 
2.55.0


