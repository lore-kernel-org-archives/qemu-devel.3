Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 422F8C5DF9D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 06:01:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNbO-0005Ep-TJ; Mon, 24 Aug 2026 01:52:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNar-0004Xv-A4
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:51:37 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNah-0002iN-TF
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:51:37 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-38dcbade417so3536427a91.1
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550686; x=1788155486; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=msTYxKrfEGozy/cQf2TaV3I4p9p1A05eh8KT3o9m9rM=;
 b=CEPTsFhGEppk16B4QPjEguA6jNDDQQ2EgBdyGv4MN/RYBD1AzYm28UJZQ3giLlF1+A
 IeD3CENF+FuIRNd9RYzgssdgfYr1Lzwoy5ruvgo8ZHindU3Aniy/hkWNqEsZvPDWKU2y
 YIsTKIY1XoavS2KWb76R6EWeI+ACUcfgZ8Tw+pIMcPnDladNroSpsfPoPoEhyiCZvpin
 TG637TrZ9GxfFzZmK4SL6QA55Z0O4lF7CRgVlzyP0yK9UnEfUcbuXdzHOHCZcDC/lAXL
 zRTOMcS5JGZodcb71LVd13934ga+IHecQPW7fwXFYt8Y65dK7KDYeiPht2JcdmwFxJB7
 3C1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550686; x=1788155486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=msTYxKrfEGozy/cQf2TaV3I4p9p1A05eh8KT3o9m9rM=;
 b=IczGXWmHhxFVasWYAwC1fW9h5Ixxs3PI30W9NvnbREgv2x79T32mg9XnAmlGq0Dkpw
 z4hBIih+e8myjvjo0Ewy3jBBsdAdhoU6UYQX4zfNg1mS2xXhjzSVqVhxNQBOfL64X/V8
 AT41l+UT0vIEqoiVaI/abRw8ohy4OrNyz1Ci7rtlEcussESrtP8D5kOVFgGDDyHFHw+8
 vUhqHoWUUP1ZcYJvwIv/AkqMOKZMeO/AIMHZhQU/KJRCAecPExg8t0n7XzgC/LlTktPm
 3RyrPiJ4cKnK5YwNynJ06mO1XF8rUUAM6hTs3wqcQnKYgLjkIVnmlLvA99Q5KYWLpNEw
 cHmw==
X-Gm-Message-State: AFuF++nH7thvGvTkwdxZQ75L29eJLOq1HD+Hm1TH6d94bKVRPhT6yqCG
 DIT2SuSLC7Vkg9AkQBCiVgsUgAXJqU0hT5iyrJQ5QyBPWf/MYg/H4KMew5OTEA==
X-Gm-Gg: AR+sD13SwSXg0a8uosEEnrTPx1hvLpLvpKOIcfq8nlqn8BffEfyX2RfwzMaGTCxJiDC
 C4Sdfao0VchqkMe9TmNXVYKJ52fDVnJHje13SxhFrcautZaI0dGPUF8hAIVXp6VREbJI8qUcICR
 kFTBB3COK0B37e+uxmGGvbdbDd02Zge770/mSV7XvC1ZtUtNtqdoQfrggqQhSoiOHAhkONqeFUW
 2AtWoXw41SD2RteAEYBlftFUr4ieHzGpb0soi/9SHpMKY+QrPplkopj/F907WZ422jF2EiyRM6P
 h5l9UC1PP682oawxsTVYyNcflcyHxnc+YdHmsuuYQYTRRYPyfh4emiBh5iQ2LrbNsh7HvlveHNx
 fe1ZG2LbB+zQ3lEqox/NgmF9gRmDOq/cSBf6FFoOyquoolMLFNBME+taTtnjyn+aXs9LUCScive
 pVhIFQINDSQuFzFN/ZD8TiGzUNa0mInDyiwyT1JEBYQ4LP4BmzU+WcOzmLdq1/1ExVbVFPTaSdS
 27+qfFWp594Ntsb
X-Received: by 2002:a17:90b:1b04:b0:38d:dfd1:7c1 with SMTP id
 98e67ed59e1d1-395c33406e0mr40085082a91.2.1787550686434; 
 Sun, 23 Aug 2026 22:51:26 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.51.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:51:25 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 62/96] disas/riscv: Tidy rv_comp_data terminators
Date: Mon, 24 Aug 2026 15:47:32 +1000
Message-ID: <20260824054806.2790041-63-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102e.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

Use { } instead of two zeros.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-30-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index e0b3d22031..f3c9213fd1 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -1072,123 +1072,123 @@ static const rvc_constraint rvcc_true[] = { rvc_end };
 static const rv_comp_data rvcp_jal[] = {
     { rv_op_j, rvcc_j },
     { rv_op_jal_ra, rvcc_jal_ra },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_jalr[] = {
     { rv_op_ret, rvcc_ret },
     { rv_op_jr, rvcc_jr },
     { rv_op_jalr_ra, rvcc_jalr_ra },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_beq[] = {
     { rv_op_beqz, rvcc_beqz },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_bne[] = {
     { rv_op_bnez, rvcc_bnez },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_blt[] = {
     { rv_op_bltz, rvcc_bltz },
     { rv_op_bgtz, rvcc_bgtz },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_bge[] = {
     { rv_op_blez, rvcc_blez },
     { rv_op_bgez, rvcc_bgez },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_addi[] = {
     { rv_op_nop, rvcc_nop },
     { rv_op_mv, rvcc_mv },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_sltiu[] = {
     { rv_op_seqz, rvcc_seqz },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_xori[] = {
     { rv_op_not, rvcc_not },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_sub[] = {
     { rv_op_neg, rvcc_neg },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_slt[] = {
     { rv_op_sltz, rvcc_sltz },
     { rv_op_sgtz, rvcc_sgtz },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_sltu[] = {
     { rv_op_snez, rvcc_snez },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_addiw[] = {
     { rv_op_sext_w, rvcc_sext_w },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_subw[] = {
     { rv_op_negw, rvcc_negw },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_fsgnj_s[] = {
     { rv_op_fmv_s, rvcc_fmv_s },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_fsgnjn_s[] = {
     { rv_op_fneg_s, rvcc_fneg_s },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_fsgnjx_s[] = {
     { rv_op_fabs_s, rvcc_fabs_s },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_fsgnj_d[] = {
     { rv_op_fmv_d, rvcc_fmv_d },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_fsgnjn_d[] = {
     { rv_op_fneg_d, rvcc_fneg_d },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_fsgnjx_d[] = {
     { rv_op_fabs_d, rvcc_fabs_d },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_fsgnj_q[] = {
     { rv_op_fmv_q, rvcc_fmv_q },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_fsgnjn_q[] = {
     { rv_op_fneg_q, rvcc_fneg_q },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 static const rv_comp_data rvcp_fsgnjx_q[] = {
     { rv_op_fabs_q, rvcc_fabs_q },
-    { rv_op_illegal, NULL }
+    { },
 };
 
 /* Convert compressed insns into normal insns via pseudo expansion. */
-- 
2.54.0


