Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 136B0C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:48:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtkz-0005is-KV; Wed, 19 Aug 2026 23:47:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtky-0005e9-LF
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:47:56 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtkx-0004KJ-19
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:47:56 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2caea3f742bso25331655ad.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197674; x=1787802474; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1FqkdWKLgfc+vRbBEL6zlKNDsJP//dgcnuZl45GUXZM=;
 b=lDlj3GUMxUguDuFTqOjWn27IIIqWN/b683XHGK5x1qx/jgdL/5Xn4lM8UwsZRB0FMS
 WXKkIw48zlhitthyEbsYZFe+K5ygdZiiPsBtvaV/UnmoaPKqHSviDE370ONIGmdsep9k
 LKqNS0JR1wF/s6maWR7wETvIccsweicrf6kf0vW8htFmxQoQn5k7bbzZHNhAt0XkNxmq
 WhEH2DyBbWLC4YfaZ9g861mwmqZsqC3DUKRmKvxf6/TZfoF4cJXeh6EBl8bhxG8jiCrJ
 BWbsc9WkOrGcji4qfpoZWQjcjzQQhyoC5vWUG3fH//8aw13SC3Ls6mvokiQiaOYRCEqR
 Ew9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197674; x=1787802474;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1FqkdWKLgfc+vRbBEL6zlKNDsJP//dgcnuZl45GUXZM=;
 b=HrlwiZROIKAKb0Ro8RPTDHitvCgdWs9HpTXcFgaszu6nDay/rBZhgr+zqO1Uy5AZGl
 0YGr0Zm6/ln7jbjeRV78IfTzfqRSz/bCny4bnMpDMCLbsSHcQmsYMm3T4saVy2vMJVpS
 xHChdk8GsOq89K1fJ/KgYLkphwdp0WWgCT9xaeQTjeBLRhmu+Kt9+8ctgGfGixKaY+U9
 MpvLSqzipHp730H9owni4fDw17kJFpwLvwuBzHAKTFrHrgD6HT7OVnnCZyAfkgIWYONC
 Iw/7ZQtaN+VCWFRBrcgyZWOajXXl6qAlsT1rCiGjmqH5zflo0gOnE7sR0C3HCg8uuTwD
 DPNQ==
X-Gm-Message-State: AFuF++n2VPJcWjzkPcwoy/IS6OrWOUJJ/ZX6IzDMwCy9S8DSqtzmZAik
 1IqHkMAruq72O8T5gzWz4jXwYTi7ZUauyNIXjASW2lMy5B+mFIB0Xh4vjPisVg==
X-Gm-Gg: AR+sD12ubjoVKTMlcwXHxIiAX3E/xH0yqE1qKXYJTYABRDt50SztT9YVHHnYrrs51V3
 8S+tz7OikQO8gx9Xs24BYZSJDXBMFIJwEKnFxfXct0RGG+W5iEPHFRpIBv/K9siBb3SGlliBsa1
 BsTBB3Kx2cMtzwYs2icjPJPBclX0KD3AnuXn0XQdZO2OUXhLFOb7wMsAZhhxcaOE3VdQ8FEIAqs
 uDexLe5EOQyhI5RH/JSD/9m3Fta0sqMMWHKtM/la+ktXZ5m8Oaka/rIZhwIzEO2miVEyLLfgZ3J
 Xuk0+BHtR1ngdG0SY17RTu0BjJqie7cxD9p8sn+VwAbvGGHgkX8oYpaP3zoRnrWiB4cw5d+Shp+
 TcVvpZWGs6xo+CisTkTfkiq6PpyE5aFjO1LW7V/bbuVtu6CqjVp8YvK9cimOf+wTbQmgIoNg17W
 ZlmKDgAwJMUL0XKEPwaebo5c835N1Fg7vPE64Nvsknhos0nosHXt8nLo4Mzu4pnG+nJgpzgB6sG
 VxcNQ==
X-Received: by 2002:a17:90b:2f8b:b0:38f:57f0:1f5d with SMTP id
 98e67ed59e1d1-395810d73e6mr18347587a91.15.1787197673755; 
 Wed, 19 Aug 2026 20:47:53 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.47.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:47:53 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 66/93] disas/riscv: Chain "ret" pseudo off "jr" pseudo
Date: Thu, 20 Aug 2026 13:44:03 +1000
Message-ID: <20260820034430.1186695-67-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x632.google.com
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

"jr" has already checked two conditions that apply to "ret".

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-31-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index f3c9213fd1..91f6d9e4af 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -1061,8 +1061,7 @@ static const rvc_constraint rvcc_bgez[] = { rvc_rs2_eq_x0, rvc_end };
 static const rvc_constraint rvcc_bltz[] = { rvc_rs2_eq_x0, rvc_end };
 static const rvc_constraint rvcc_bgtz[] = { rvc_rs1_eq_x0, rvc_end };
 static const rvc_constraint rvcc_j[] = { rvc_rd_eq_x0, rvc_end };
-static const rvc_constraint rvcc_ret[] = { rvc_rd_eq_x0, rvc_rs1_eq_ra,
-                                           rvc_end };
+static const rvc_constraint rvcc_ret[] = { rvc_rs1_eq_ra, rvc_end };
 static const rvc_constraint rvcc_jr[] = { rvc_rd_eq_x0, rvc_imm_eq_zero,
                                           rvc_end };
 static const rvc_constraint rvcc_true[] = { rvc_end };
@@ -1076,12 +1075,16 @@ static const rv_comp_data rvcp_jal[] = {
 };
 
 static const rv_comp_data rvcp_jalr[] = {
-    { rv_op_ret, rvcc_ret },
     { rv_op_jr, rvcc_jr },
     { rv_op_jalr_ra, rvcc_jalr_ra },
     { },
 };
 
+static const rv_comp_data rvcp_jr[] = {
+    { rv_op_ret, rvcc_ret },
+    { },
+};
+
 static const rv_comp_data rvcp_beq[] = {
     { rv_op_beqz, rvcc_beqz },
     { },
@@ -1896,7 +1899,7 @@ static const rv_opcode_data rvi_opcode_data[] = {
     { },
     { "j", rv_codec_uj, rv_fmt_offset },
     { "ret", rv_codec_i, rv_fmt_none },
-    { "jr", rv_codec_i, rv_fmt_rs1 },
+    { "jr", rv_codec_i, rv_fmt_rs1, rvcp_jr },
     { "rdcycle", rv_codec_i_csr, rv_fmt_rd },
     { "rdtime", rv_codec_i_csr, rv_fmt_rd },
     { "rdinstret", rv_codec_i_csr, rv_fmt_rd },
-- 
2.54.0


