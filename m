Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BDD5C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:56:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNZm-0002xm-MT; Mon, 24 Aug 2026 01:50:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNYk-0001SV-09
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:49:26 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNYg-0001x4-U4
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:49:25 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-38dc4553f62so4139016a91.0
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550559; x=1788155359; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f/u6W5uGxQ0lZiZRWiD37XIIJQNcqJvCdasbU0HSOvs=;
 b=AZxbL2WL9sQJHYGhmLaJqrfOmcTXOz67dESSA6icVE/Z4llJl8JzBof39klnmNf1Hz
 5MkHCyeoIWSWp79t+YT81+4a+VvqlBl/Sl9XC51Xio2iY0o2AyS8CyGpgW2okzETs121
 /5axF3XuINsTtJxzOmitGxjEw6lfezYUHKhC7Q1YkTsZKpILEeesdHTVHZ+5FWSb9Tu1
 /dBEGGc8NNYVn64mPsFNQ3V3TnTako7DNQTyJQE9hwFDpoZH4iy6dW3ti679YQ2Fc3hL
 B1dVzmrXCWaUEHd7aLVZoN/wZUH4jU98F4qPffNllxBgp+AawinnV+OX2GVsZyhaW1Xx
 5F4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550559; x=1788155359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=f/u6W5uGxQ0lZiZRWiD37XIIJQNcqJvCdasbU0HSOvs=;
 b=SecCvhUO7m28a6PvTB728Nj01JB/qZmokAsrR4zSUejrSb4yiD4jGmTcukcZE6tkw0
 nn5uD/gdWCK9wVk5vFps0J8qBso3KDazJxcTECARESr4d6hFNGh4smT/n2WvQXFnmHKm
 AA0G25JzJLt/HSgpfqPhIhIk/Fonc31hV3xSU9wkT+gNojdxWLoIOc6N4qVDmyOyGBAI
 Y+HrUVfjA+6rJNldbFvUJ4s06Rr/rtJWHiU0XIr6ZAM4CmGg3MYUK/kuHckpf1EqBScY
 rcEcJD4xqu6GbFtGVd05P6CndXRf3tamdz6MEU+mLd8Sqo9z4GlILR7whmzmITWEoukJ
 8Qvw==
X-Gm-Message-State: AFuF++kK9bjLt4L2qRHlKnpTw7iwqWziB3NfYYw6KcUdhTLUhJ9uwadw
 aV8T9gnysDd/mfSY+oc5rbs36ggTsKpzN5guECfVEjE5KS+J/sFSgAeB0rF8ow==
X-Gm-Gg: AR+sD12biOyVRxQMAy+qT16OY6I3U8ZHzmyXBtY4foQVHQ9zUFH+M3Rpfvh1/9EmtAL
 QfIDNgDbpjaIKP4ahzdI4xB5SW0HQblbq+6+Pwe5APUQc7jJvA9bWeAf3fAch8FhSIcbQfnIvZn
 kYKZDatMGrKnmdjR5RnR6Qeo5ge5suLNkaw1+K+Oe33F1rBsbnCj+hby+rFXGPE5nkEDDjC1LOG
 wfd32kh12Q1KsXJo0WiZqhf7Jm1nDHDDbMNsHuaeavJ0av8E/s43mioWSn4TNZ2U9H8Y3b60cPP
 QFxB/7+H7zF/HfCvCQ1WYiNLcYznIxY7SS18xj/hnC/5BErxTwW5XxNgZng8w/t0jfex7CKrgxP
 uPqyZMi2dum1ScOwEEcq1ZT37+142kw6uZC4a+eHSQJTkyvVDqkK+eKMOGu2P573/TBeb6q5kKf
 hoirTXtmAMMtH6DP24SEY8NAXGWpNeRrhCmlO44WHrM1/KIekt8RuQiwqZUjIztT1rA8pJ0sHDG
 kED0Q==
X-Received: by 2002:a17:90b:390f:b0:38e:4114:d8c7 with SMTP id
 98e67ed59e1d1-395c2f29705mr40198810a91.0.1787550559452; 
 Sun, 23 Aug 2026 22:49:19 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.49.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:49:18 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Frank Chang <frank.chang@sifive.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 19/96] target/riscv: Support raising misaligned exceptions
 for floating-point loads/stores
Date: Mon, 24 Aug 2026 15:46:49 +1000
Message-ID: <20260824054806.2790041-20-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102c.google.com
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
exceptions for misaligned accesses from floating-point load/store
instructions (RVF, RVD, Zfh).

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260810055618.1175500-5-frank.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/insn_trans/trans_rvd.c.inc   | 6 ++++++
 target/riscv/tcg/insn_trans/trans_rvf.c.inc   | 6 ++++++
 target/riscv/tcg/insn_trans/trans_rvzfh.c.inc | 6 ++++++
 3 files changed, 18 insertions(+)

diff --git a/target/riscv/tcg/insn_trans/trans_rvd.c.inc b/target/riscv/tcg/insn_trans/trans_rvd.c.inc
index 3b9a745520..1be2bee946 100644
--- a/target/riscv/tcg/insn_trans/trans_rvd.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvd.c.inc
@@ -61,6 +61,9 @@ static bool trans_fld(DisasContext *ctx, arg_fld *a)
         memop |= MO_ATOM_IFALIGN;
     }
     memop |= ctx->mo_endianness;
+    if (!ctx->cfg_ptr->ext_zicclsm) {
+        memop |= MO_ALIGN;
+    }
 
     decode_save_opc(ctx, 0);
     addr = get_address(ctx, a->rs1, a->imm);
@@ -86,6 +89,9 @@ static bool trans_fsd(DisasContext *ctx, arg_fsd *a)
         memop |= MO_ATOM_IFALIGN;
     }
     memop |= ctx->mo_endianness;
+    if (!ctx->cfg_ptr->ext_zicclsm) {
+        memop |= MO_ALIGN;
+    }
 
     decode_save_opc(ctx, 0);
     addr = get_address(ctx, a->rs1, a->imm);
diff --git a/target/riscv/tcg/insn_trans/trans_rvf.c.inc b/target/riscv/tcg/insn_trans/trans_rvf.c.inc
index e935523c93..481f7282da 100644
--- a/target/riscv/tcg/insn_trans/trans_rvf.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvf.c.inc
@@ -52,6 +52,9 @@ static bool trans_flw(DisasContext *ctx, arg_flw *a)
     if (ctx->cfg_ptr->ext_zama16b) {
         memop |= MO_ATOM_WITHIN16;
     }
+    if (!ctx->cfg_ptr->ext_zicclsm) {
+        memop |= MO_ALIGN;
+    }
 
     decode_save_opc(ctx, 0);
     addr = get_address(ctx, a->rs1, a->imm);
@@ -75,6 +78,9 @@ static bool trans_fsw(DisasContext *ctx, arg_fsw *a)
     if (ctx->cfg_ptr->ext_zama16b) {
         memop |= MO_ATOM_WITHIN16;
     }
+    if (!ctx->cfg_ptr->ext_zicclsm) {
+        memop |= MO_ALIGN;
+    }
 
     decode_save_opc(ctx, 0);
     addr = get_address(ctx, a->rs1, a->imm);
diff --git a/target/riscv/tcg/insn_trans/trans_rvzfh.c.inc b/target/riscv/tcg/insn_trans/trans_rvzfh.c.inc
index f36b46c211..88711fb076 100644
--- a/target/riscv/tcg/insn_trans/trans_rvzfh.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvzfh.c.inc
@@ -50,6 +50,9 @@ static bool trans_flh(DisasContext *ctx, arg_flh *a)
     REQUIRE_ZFHMIN_OR_ZFBFMIN(ctx);
 
     memop |= ctx->mo_endianness;
+    if (!ctx->cfg_ptr->ext_zicclsm) {
+        memop |= MO_ALIGN;
+    }
     decode_save_opc(ctx, 0);
     t0 = get_gpr(ctx, a->rs1, EXT_NONE);
     if (a->imm) {
@@ -75,6 +78,9 @@ static bool trans_fsh(DisasContext *ctx, arg_fsh *a)
     REQUIRE_ZFHMIN_OR_ZFBFMIN(ctx);
 
     memop |= ctx->mo_endianness;
+    if (!ctx->cfg_ptr->ext_zicclsm) {
+        memop |= MO_ALIGN;
+    }
     decode_save_opc(ctx, 0);
     t0 = get_gpr(ctx, a->rs1, EXT_NONE);
     if (a->imm) {
-- 
2.54.0


