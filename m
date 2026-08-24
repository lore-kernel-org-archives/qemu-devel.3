Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA49AC5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:54:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNcA-0008Nv-Fj; Mon, 24 Aug 2026 01:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNbz-0007Jz-Dp
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:52:47 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNbx-0003BP-NO
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:52:47 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-38e347638adso2732199a91.0
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550764; x=1788155564; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=v1HHSGb013dDgNPZxkNVb6ZLlCJeWWRoZwdE2wte10s=;
 b=piarGNHjD1sQK6CB9Oa8u293NR9PkC/RSu/jrq4rEg0ASObRGxtIBIxiuJKNquRX3K
 H0vkrEeaVD4VLXobj8rJynJT2iy6eXkO8+tREG0TbJiq8alm5PzNTg3TR25ZJJ7joAtA
 3DgZ5lilXv5zePQ2dYcqNaRTqldtdTOCnt0qBVhHpH5XuhmDzbBg8sIhNsw6oR3xyYDt
 YN3UctFRtMj+bkC+537R8+i5w8C7AAttDbGcVZuMglWgVVXo71WXZztpbppqZYc5mytg
 pexdv2v1q0jorFFFFE/2mmOL/ohiS5ywY1xbQ8ocvgFaNEsw1GBSPPxFT3xcOunS70wa
 YGyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550764; x=1788155564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=v1HHSGb013dDgNPZxkNVb6ZLlCJeWWRoZwdE2wte10s=;
 b=ai6Bgpfs8+V1HneWrC5KOe0Kd1rysgI4toiggjd8ymhaM7Q2+udUAvRZ8C3KcQVjaf
 3rTr0dBLpEe4gZ7z830vjla3mmIq0/Q5LfX4N3JKE6/mXE1UGy0L1GEgWwb1K1d5eOdK
 DzpZB+eYWWG7UzfW4TxWvcJVeXM1W9IfKwuKeKyP8MG/Xr1sA9QpF0fUSMvP30ZGwct8
 fZ2ElwLCzqtqCsg2LQWKER9D2dgXR9f+epXVyfBqTG1s4IYCMU6uzqOePK2sZdP0ikM1
 9Rf5AY95fK8h+Eh/N5QfVueSd7h7eJ8inin4jPWA9sEdEoSUcMMObLpXo1onp4Xz+y4/
 FSsQ==
X-Gm-Message-State: AFuF++nheSH9VD8m1SrkvQAFvqlED7cQhNgj7eyWSKaiXFpV1+753PDy
 W7dcfPuTIcH+8pslU5ZU/mIapOQ2BCuflNeeK4O/+/j0FFy2ySzTjfkGCXoxTg==
X-Gm-Gg: AR+sD11O7IjnMI9uT2c0ebac7tiTA+jGTzEOxk9jg5nv5WnxEsSD6V/6ofQzye91H7U
 bFDvzs2+2j/7b1SyrPNvdOOpZ/J8m46/uIRi2YIUdMw/qdTadixiVEXjrtUn+6qEL78wq+iQIb5
 Lvu4DsuQZ37vgKBhHcaG/ZlC/zNx3RHccPNfVyAyw2MvIZD3jna85qyg9jG2SsV5riLZuAGvB0x
 N5D/gJYPiXSMcl1LJN/2PUwr8oL5FV4DtHsMNsQQmlDtmY8BrRQJ7gbcrrC774rZiI5uzfkJTK0
 qq1YjkSCvmp71NAfD/j9ZLE9amjUDlbyOYP75Gtf3HAo2Z6od2XFTVRstmspJNaslZrsxJSUF8J
 v+VEH9bumbck4OSazAjennGuH6ozbbWbChR/+ykVKfgJHDDdePj2vwbAp3z93tucH9z3/by2niK
 5x0f88X+AECbXtw2GUetnXTavlWxvTpAt1ZPTfTGFgLwm2lUW9oTGOzd+8DBp/7kTJ67pvdwoR+
 jLQLw==
X-Received: by 2002:a17:90b:538f:b0:38e:b400:a860 with SMTP id
 98e67ed59e1d1-395df29e128mr30347283a91.13.1787550764470; 
 Sun, 23 Aug 2026 22:52:44 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.52.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:52:43 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: wangyang <wangyang25@otcaix.iscas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 87/96] target/riscv: reject FMV.X.W/FMV.W.X under Zfinx
Date: Mon, 24 Aug 2026 15:47:57 +1000
Message-ID: <20260824054806.2790041-88-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102a.google.com
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

From: wangyang <wangyang25@otcaix.iscas.ac.cn>

Zfinx explicitly excludes the FMV transfer instructions, but
trans_fmv_x_w/trans_fmv_w_x used REQUIRE_ZFINX_OR_F so a Zfinx-only
CPU accepted them.  Require RVF instead so the transfers trap with
an illegal instruction when only Zfinx is present.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4108
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: wangyang <wangyang25@otcaix.iscas.ac.cn>
Message-ID: <36c7cfebd27b4b6e8bcdd00e09e9dda0@wangyang25.otcaix.iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/insn_trans/trans_rvf.c.inc | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/riscv/tcg/insn_trans/trans_rvf.c.inc b/target/riscv/tcg/insn_trans/trans_rvf.c.inc
index 481f7282da..636dec1664 100644
--- a/target/riscv/tcg/insn_trans/trans_rvf.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvf.c.inc
@@ -434,7 +434,8 @@ static bool trans_fmv_x_w(DisasContext *ctx, arg_fmv_x_w *a)
 {
     /* NOTE: This was FMV.X.S in an earlier version of the ISA spec! */
     REQUIRE_FPU;
-    REQUIRE_ZFINX_OR_F(ctx);
+    /* Zfinx explicitly excludes the FMV transfer instructions. */
+    REQUIRE_EXT(ctx, RVF);
 
     TCGv dest = dest_gpr(ctx, a->rd);
     TCGv_i64 src1 = get_fpr_hs(ctx, a->rs1);
@@ -537,7 +538,8 @@ static bool trans_fmv_w_x(DisasContext *ctx, arg_fmv_w_x *a)
 {
     /* NOTE: This was FMV.S.X in an earlier version of the ISA spec! */
     REQUIRE_FPU;
-    REQUIRE_ZFINX_OR_F(ctx);
+    /* Zfinx explicitly excludes the FMV transfer instructions. */
+    REQUIRE_EXT(ctx, RVF);
 
     TCGv_i64 dest = dest_fpr(ctx, a->rd);
     TCGv src = get_gpr(ctx, a->rs1, EXT_ZERO);
-- 
2.54.0


