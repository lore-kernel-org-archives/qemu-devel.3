Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E8B9C5DF9D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:52:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNZG-0001yh-DY; Mon, 24 Aug 2026 01:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNYi-0001RL-Kw
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:49:24 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNYc-0001vq-Ma
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:49:21 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-c96c92c0980so1744228a12.3
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550556; x=1788155356; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dpctRoR5ytohYBbHmTxahKvAOMfFUypV6/ZUeeRK850=;
 b=FzWp54Ifqwn6KojhndYT7cGwCctWMAVaBnEnMGNHQbs0AhrNzA39PCuPUD+wBOaoY9
 X2zyS5S/HPabSyOKHkW2yKJrFguPK9HeiLHwOHsn8V0iuF+iop++YZ2tQ4gIm6KKLv30
 75r3XWVghpllQsVqG4sGYzMCAV8n1sdfH+YiaccqLTBuH7L8e/TwzGprIb1C64yZeKvy
 jgQH2PjtrwPi1oHfU2TDZFvuRGCSe7q/LZD64+34aENZgTilNp+l8QcKtcLWRQWRfP17
 1fA3GVdd740ftqBV5PJdWRb8aZE3q2gWUlObGyQuVWd9vfWdgf//Km5jXlnFNV+WOxpw
 zcFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550556; x=1788155356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dpctRoR5ytohYBbHmTxahKvAOMfFUypV6/ZUeeRK850=;
 b=pwkK1qAc5phpFcG+Hn3f1D6ago3+Am/LN1YP0KlFm+HLbKGeFigYVVW4DeWfkhXcvx
 HBJp9GAgqgnIcx0jyHdJ3k+Hg1wmTadGFg+FIJk3c2W/TdDhAnJgqbUD8AQ5G+V/5eU8
 VhSPKcO0U561+E+vaU/YiyC57mtTP7LNyHKzHSOASvgePBLZ8Ol9LPErgwFcBF1A77FL
 TcDU3gLD9mTqyLM1zYJn8JqoNuuKzSZ/9Aa89IPqzb2Kn2QcaHOE4H9SRxrJmd87azas
 L5sRNWVtCgqGW9lQISsUVN5wE6Sy3JiJAG5dIJ/GrXqTKBTlyC0w33GxWzVT46YXQ/Bp
 QYWw==
X-Gm-Message-State: AFuF++nPUqWzQMY4nBnnLp9rBHTC//itVNO5di8FxIbo1cJmp6FlBrQw
 EIvApWBG63hgvWXGt8n+bqIJf5R3yeO1G1x3buL5L7eFFrP85+Xo8exIA7QxrQ==
X-Gm-Gg: AR+sD11QZg62rq3NAWdAXLdm9T1ye6LEUDWmH8CmrptpscKDfxephJd+uWtR+yBcr4W
 r94H+6GOZ2aAj+/nhibUPT7CCfA9XkCxPvoD3/Fk9cBDmtU0Y9aPM8Llep5zwWPloH0Fy0KGkmw
 5Y20BoZz4GgfKgUN1J27g5D3+IMxJrKvdBdASwQBWuxmS3iziUXStz6QW016kPzt79uZZT9M+9R
 CEYKWE7Msf+Or6yxEFO/RHrAEpti6FYR+3DGVCEXKFMEYrjG7SEdPrRKDfkyoXmzbPf6Zp6J+KW
 zGmBaQmkSi4Lw143iTqyk1xoCuPkvFoVlGfu53aTVPh6P4aGvU+GxYiMwuA5Co5TM9TsY3lTZVg
 8OoKtXZ41x2ubZJ4gZ/TyOJ0XNKLdTd7fqII/5jl9v3IllExk3cVtsQ48Jgw/9t5Pve1Opm9w0q
 dq60eGs8EUSSGdgH79oo+7R1qVBBynFkdLoE44wbjid7b6uzdEEB9imzBx69irH46XRGAewOfhO
 C53p7HDgluLyOohIw==
X-Received: by 2002:a17:90b:2c87:b0:392:7f74:58c9 with SMTP id
 98e67ed59e1d1-395c3a43766mr48550963a91.15.1787550556389; 
 Sun, 23 Aug 2026 22:49:16 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.49.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:49:15 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Frank Chang <frank.chang@sifive.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 18/96] target/riscv: Support raising misaligned exceptions
 for scalar loads/stores
Date: Mon, 24 Aug 2026 15:46:48 +1000
Message-ID: <20260824054806.2790041-19-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x535.google.com
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

From: Frank Chang <frank.chang@sifive.com>

When the Zicclsm extension is not enabled, raise misaligned load/store
exceptions for misaligned accesses from scalar load/store instructions.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260810055618.1175500-4-frank.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/insn_trans/trans_rvi.c.inc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/riscv/tcg/insn_trans/trans_rvi.c.inc b/target/riscv/tcg/insn_trans/trans_rvi.c.inc
index e47b16a7fa..cc1b5dbbad 100644
--- a/target/riscv/tcg/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvi.c.inc
@@ -413,6 +413,9 @@ static bool gen_load(DisasContext *ctx, arg_lb *a, MemOp memop)
     if (ctx->cfg_ptr->ext_zama16b) {
         memop |= MO_ATOM_WITHIN16;
     }
+    if (!ctx->cfg_ptr->ext_zicclsm) {
+        memop |= MO_ALIGN;
+    }
     decode_save_opc(ctx, 0);
     if (get_xl(ctx) == MXL_RV128) {
         out = gen_load_i128(ctx, a, memop);
@@ -524,6 +527,9 @@ static bool gen_store(DisasContext *ctx, arg_sb *a, MemOp memop)
     if (ctx->cfg_ptr->ext_zama16b) {
         memop |= MO_ATOM_WITHIN16;
     }
+    if (!ctx->cfg_ptr->ext_zicclsm) {
+        memop |= MO_ALIGN;
+    }
     decode_save_opc(ctx, 0);
     if (get_xl(ctx) == MXL_RV128) {
         return gen_store_i128(ctx, a, memop);
-- 
2.54.0


