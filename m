Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE04C5DF8C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:54:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNcA-0008OE-Fe; Mon, 24 Aug 2026 01:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNc2-0007Tc-Dl
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:52:50 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNc0-0003Bx-Le
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:52:50 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-38511175ad3so2886238a91.2
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550767; x=1788155567; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aHib+VBpVmiPANdQmekp+Cwzw4eMIzE03qptIJvCC3Q=;
 b=RX6b8RtEpwYVRvsJ49ZMPZfBW+lT5OEEGrbyI2RDPxEooGT8Yvn61K3D1/Ns4R4/dQ
 s8yp5Pchuot2p4v6N+m0fBU7u0H3ptGuCLhVy54WHgJtMIIxX7qPwwr6T7NhalmMEgYw
 GjG42taiCjmPAli97gGKlmG4tATyD28RfK7SUZF8TpCthJrsQfJqloR1uFBKc9wmLOuY
 O0EBgtLKDv5aSN+IxMe8scdKWbiKAALcexHv85mZL/7AcAIoycHzniZscnRLev8ISG82
 k0xgUz9P10xJF0R5mBfRsfhVYKKRoMH8OBSqyxBcSZpOrZZNT08FI13KOtGWTdiLZ5Dn
 vZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550767; x=1788155567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aHib+VBpVmiPANdQmekp+Cwzw4eMIzE03qptIJvCC3Q=;
 b=HPZjLqzMkIohg0y4J0E6ud2GeVxYuacj0OCFok4M/i78ZOitm8e75T8EWW0tFZA6uT
 QUh+DAaYwTjUOWM8P4lI4/sUO6yCN+QwIzHMTY/YfDYmDQiHuKmg3wV3Ar7KpUf8iPSF
 oPPVBwXd0qtB/X91VTjNr78KTfwQauQG8JVWMoxKAFPuQ5yYQxxPVSfKUo1i25b7w/5Y
 qpeW5iO+SqEHmX2j97pRA0U7OnVsX9kI0veWv3LHSZH3zAoTxpdodgTLCTksUAVqfjtA
 GrCeyxtzXSZNyUmFiPhxhqCrcuN7EmNFiaJrEgwIBVEAndus2krOKUbJwISZqy7YNQhY
 VYrA==
X-Gm-Message-State: AFuF++kWJjP4lxi9Pwnk+fVbCqwpoDnVMoIIHGUPhE1W793Yw/4t4FbI
 hKXrqh0B1dIvjwXXp/hcWEKwZFmhgfpOv+lvzqoDoYlufw6c+gngmZEbHJWJ9w==
X-Gm-Gg: AR+sD11FXSd3YyUQbqvXw7M2ENssw4vpP0nG5EseTpQjmzpIa6sbhH5AVrt0ZmGeD3s
 EFpsHu4koGynN6vxtp2JvlLaeiaMW7QfU0MSPICP/wxOTgPljwvTOTgkfK+RPJsxIGpRvphaT2G
 oZEoo1c9IJdht/NVteP5/P0as2xDowbrF+iKtiVQcoKOnyzprx2RLHAgcN4TVpih5EhCoEjy7uo
 hX3KNx0/pFAKim/9bmxBXo9QpCCebBSmYzUz30mBvC/X64CHUuMRcBGgDRQFqmsWbg6WfduD1Ez
 CysGH48Be7cWg7Ly21xxBFX1Aj2LLgItSBLnyg1i40q+bwW4vV1qqrUmyZwAd/QkJ4qPB2UFRvN
 3TteSVdTEukH1bYDhse9AQfCHRskJwbM0vJAYNYpAanXOzHWrU+pQ5dxBMngNEaiuQKzcnIgAp/
 GSfaSR9E87jwuXrfmkJPjFgdN3cMPi07Aek69byAgPLl0vEid8eIf4Y/3VxMPjHKqx+v0JUNTOJ
 /85pg==
X-Received: by 2002:a17:90b:1c90:b0:393:19a3:4f1 with SMTP id
 98e67ed59e1d1-395c351d788mr41514235a91.6.1787550767386; 
 Sun, 23 Aug 2026 22:52:47 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.52.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:52:46 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: wangyang <wangyang25@otcaix.iscas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 88/96] target/riscv: enforce even register constraints for
 Zdinx fcvt pairs
Date: Mon, 24 Aug 2026 15:47:58 +1000
Message-ID: <20260824054806.2790041-89-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1031.google.com
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

fcvt.d.h and fcvt.h.d access a 64-bit double held in a register
pair, so under Zdinx/Zhinxmin the odd-rd (fcvt.d.h) and odd-rs1
(fcvt.h.d) encodings are reserved.  Add the missing REQUIRE_EVEN
checks so those encodings raise an illegal-instruction exception
instead of retiring.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4109
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: wangyang <wangyang25@otcaix.iscas.ac.cn>
Message-ID: <ea287909fd6043e0bbcdbfdcb0cc8063@wangyang25.otcaix.iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/insn_trans/trans_rvzfh.c.inc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/tcg/insn_trans/trans_rvzfh.c.inc b/target/riscv/tcg/insn_trans/trans_rvzfh.c.inc
index 88711fb076..b17ef9541c 100644
--- a/target/riscv/tcg/insn_trans/trans_rvzfh.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvzfh.c.inc
@@ -419,6 +419,7 @@ static bool trans_fcvt_d_h(DisasContext *ctx, arg_fcvt_d_h *a)
     REQUIRE_FPU;
     REQUIRE_ZFHMIN_OR_ZHINXMIN(ctx);
     REQUIRE_ZDINX_OR_D(ctx);
+    REQUIRE_EVEN(ctx, a->rd);
 
     TCGv_i64 dest = dest_fpr(ctx, a->rd);
     TCGv_i64 src1 = get_fpr_hs(ctx, a->rs1);
@@ -453,6 +454,7 @@ static bool trans_fcvt_h_d(DisasContext *ctx, arg_fcvt_h_d *a)
     REQUIRE_FPU;
     REQUIRE_ZFHMIN_OR_ZHINXMIN(ctx);
     REQUIRE_ZDINX_OR_D(ctx);
+    REQUIRE_EVEN(ctx, a->rs1);
 
     TCGv_i64 dest = dest_fpr(ctx, a->rd);
     TCGv_i64 src1 = get_fpr_d(ctx, a->rs1);
-- 
2.54.0


