Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BEBDCD4F4A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 17:49:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP24v-0005Xo-My; Mon, 18 May 2026 13:48:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wP24X-0005SH-D1
 for qemu-devel@nongnu.org; Mon, 18 May 2026 13:48:10 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wP24S-0003mH-IM
 for qemu-devel@nongnu.org; Mon, 18 May 2026 13:48:07 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-3660ab73adbso1815782a91.1
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 10:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779126474; x=1779731274; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rploCqtm6vwFDDVNHGChrFcyZYIAeak0Auxi0lz+BRY=;
 b=dapBc2FRs9bjWpE2YSeE0q26ReYohfBftcYoYCscS87hzprSmrBlZg2wCdw4J+CT2W
 I64ge2t/C3BF4WaXik0Bi4EzpSDr1BSxCjoVDPlwOctfhqnV4Pp/hgiHMpCagokF1kYM
 nYIab6t4Zz4ke/3xfxo0X5d2NiYrkVqxDaYlBBcUISB6z03se6AaBDx0FEKlHpMAsM2W
 Dz0bnMhh4yLUxisuOnSh9V4zNPzgT9QkWMcCG/D7Mr65zhRT8MgtGI5lmYvSukMQVWc6
 o3m9T6nJtfPHUTxayOyOSzKWnhJTWHcJgXQkZeNTzBM6UqhSRnNHlsEo6+xr3kDJ5Qke
 UNQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779126474; x=1779731274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rploCqtm6vwFDDVNHGChrFcyZYIAeak0Auxi0lz+BRY=;
 b=tIkDics9RtcUbm25E9iPKht7f1JDbsj9SsPmBqTBee8EKs++KgTBLL9u15jULbqHHZ
 IBTT5C8x+Ay9yp5pVVeGG6yFet913y6ubRPk550BPXRRirp4iitIwlp01bJhcteGZ3Ki
 hMINSi3BU1YgLTd/30GNdroMC4ktNlWc1yPmnQ0NvYBSzwZ206oCbMeUZDEVFvnS1pw8
 FV81A26ol1AreO1FPbCQLuTrPZEqVn1uVYYEo02ieXv2mvetoER9rKXRs1OS5onBwc1i
 PgM48AbhHimPGHT8r2DJtjFTYD8PFKHp0/GWnFdppQBAOhypmdu+J7rQLsgKIKkfGl/5
 ZleA==
X-Gm-Message-State: AOJu0YxPkAvwIGWEDxsduxRHmy6dw1kOPqhRyEAKxI+A0/hX1uYrcN8V
 j7c4HmWSJZ0mxgC89QRY3dQMEaC0FnePUZ6BfsdKEMeyR/6rdZgQrQjJ+xh1XTzkX17mzGfqBO4
 cqyejiJE=
X-Gm-Gg: Acq92OE3lGdQOtxtsWVguT9UU6vOebYS3EWBXEEVUeinYYiNZwqluxfeC4FCkKu4T0q
 oZ789bfno2Ftn+pE+c7htyjqWBW/QAvvehDcKtyLlYHfemqzJ/Q39a6UGU4R+7ytwJ/rVFem56+
 f12kLJR5mxp4wYPigYw+msV/Lxw7tDW3Rp+Xiswd+BM00auri62qKbU7VbyM9d2wpYziRhuwtpj
 24NZhz1PP9K+Y6lEucz83bPfUk5WVzb0lxlZTkOpc04ypB+I5nV4F+SJgKjChc7N62iE8Tmqz7f
 zXCTk5ms4jG8kX0fDyjwUvytYYbSc+5lERkbb9/2aL3Pk8lGjo9sSXW5k02f+JLikMBtbuPyOH0
 lCPbMlatI2GVqB1b1B+fkSkwtZq8SJRqptH5a6707soMyhQa9WmRKRzRID3mxCL8n1AV4PDI0+0
 QX+iO4iQ7CM72tmcv4Gt/HQfvUERA5
X-Received: by 2002:a17:90b:4b0a:b0:368:b92d:df93 with SMTP id
 98e67ed59e1d1-36923604ec3mr17560409a91.9.1779126473668; 
 Mon, 18 May 2026 10:47:53 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5d12e38dsm157334905ad.77.2026.05.18.10.47.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 10:47:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 3/4] target/arm: Implement CB (immediate)
Date: Mon, 18 May 2026 10:47:49 -0700
Message-ID: <20260518174750.660258-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518174750.660258-1-richard.henderson@linaro.org>
References: <20260518174750.660258-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 41 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/a64.decode      |  2 ++
 2 files changed, 43 insertions(+)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 293aa43cc9..c4a016f36c 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1816,6 +1816,47 @@ static bool trans_CB_cond(DisasContext *s, arg_CB_cond *a)
     return true;
 }
 
+static bool trans_CB_cond_imm(DisasContext *s, arg_CB_cond_imm *a)
+{
+    static const TCGCond cb_cond[8] = {
+        [0] = TCG_COND_GT,
+        [1] = TCG_COND_LT,
+        [2] = TCG_COND_GTU,
+        [3] = TCG_COND_LTU,
+        [4] = TCG_COND_NEVER,  /* reserved */
+        [5] = TCG_COND_NEVER,  /* reserved */
+        [6] = TCG_COND_EQ,
+        [7] = TCG_COND_NE,
+    };
+    TCGCond cond = cb_cond[a->cc];
+    TCGv_i64 t;
+
+    if (!dc_isar_feature(aa64_cmpbr, s) || cond == TCG_COND_NEVER) {
+        return false;
+    }
+
+    t = cpu_reg(s, a->rt);
+    if (!a->sf) {
+        TCGv_i64 tt = tcg_temp_new_i64();
+
+        if (is_signed_cond(cond)) {
+            tcg_gen_ext32s_i64(tt, t);
+        } else {
+            tcg_gen_ext32u_i64(tt, t);
+        }
+        t = tt;
+    }
+
+    reset_btype(s);
+    DisasLabel match = gen_disas_label(s);
+
+    tcg_gen_brcondi_i64(cond, t, a->imm6, match.label);
+    gen_goto_tb(s, 0, 4);
+    set_disas_label(s, match);
+    gen_goto_tb(s, 1, a->imm9);
+    return true;
+}
+
 static void set_btype_for_br(DisasContext *s, int rn)
 {
     if (dc_isar_feature(aa64_bti, s)) {
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 8fb1314bfc..1f114443c4 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -217,6 +217,8 @@ CB_cond         1 1110100 ... ..... 00 ......... .....      @cb esz=3
 CB_cond         0 1110100 ... ..... 10 ......... .....      @cb esz=0  # CBB
 CB_cond         0 1110100 ... ..... 11 ......... .....      @cb esz=1  # CBH
 
+CB_cond_imm     sf:1 1110101 cc:3 imm6:6 0 ......... rt:5   %imm9
+
 BR              1101011 0000 11111 000000 rn:5 00000 &r
 BLR             1101011 0001 11111 000000 rn:5 00000 &r
 RET             1101011 0010 11111 000000 rn:5 00000 &r
-- 
2.43.0


