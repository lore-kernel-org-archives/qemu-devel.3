Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC91C5AD55
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 04:56:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wteXJ-0005Vd-Bg; Tue, 11 Aug 2026 00:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wteXG-0005RY-9f
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 00:56:22 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wteXE-0002nq-MY
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 00:56:22 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-3811f512167so3695981a91.3
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 21:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786424179; x=1787028979; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Cc1RC4WfWTjVgunvR82BNYQc1BHHqprNxL8r/tyP2lo=;
 b=xOLDM64dv0AMlQ7FPMrNnb4wc4lWgVMp8lgKBaAXKmkdOj7U0RUlONSP5vCorwBMym
 euggP7+oq6irv4CPzvcp2q5cz4xxmAXyBGc1bny7xlPl8gdDghQDipztGvwbeBlLfeTo
 cEDHb2fI9irnMK0L+9KJnBB4jiUa+uFsXlyw287Z0jpJi0ukzN79//bLVVJyBfR7RimR
 VH+gVTlRfLjFpKBP4wvikssfkRUSd1pdptn3V0qu3X75I9mL082uttRoE4oQjVRkkczj
 uRVO/Tgcxj1FNBkgOuoUzaPEXIf6VCrRYNB0h2VyZD0fvsBbfptJ3ZfP6qEGZz5aKj/Z
 FIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786424179; x=1787028979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Cc1RC4WfWTjVgunvR82BNYQc1BHHqprNxL8r/tyP2lo=;
 b=IkR6wW70m7UxbU3dW1UndM4DCzDMShC+j2XtX8dkuP0nMe0IX2x1gTWPsZqOYPkuhw
 ANEHmBUdCJ9yYrnd1BXnthXD/XxwLPhxgQSpoxX/4oVVHC4q5O4NZWnILIuvx5ozx+Ws
 ozNkSDXdybtW4P8D5TY9l4853FDFf4/hUUCyIU0BGNrcKqvB88qH5XIwPqbWiRpvHy9v
 BzFOVHBGEmHcdiH7ZhPuddzX7qtNtxrPr05rwAenkH5Rerdcjy5Ld5MCf+zCbettZ9D0
 +W5ksZErSVOg+duBhCXsy9ND/BlFnhJPfbdE6Dx9lR6QmbiOFIpsrOSckEnns2itwk/t
 1ueQ==
X-Gm-Message-State: AOJu0Yyk+OFJUIfWW02MuLC+CFRDzghm4uTsPokmCgpRf+ZzR2qMr/1Z
 fXi5K9Js4U2Q7g82zxrUVGU5Cof1JuaMGq5oBmdBqoMEiDgWuAv2uJe9va8xrBbgMU7xn2oVA1L
 EXv59
X-Gm-Gg: AR+sD12ZrIRxVqcrg0jmrfenmQQ0ZU0bouXqh0VkBhvcwp+pEZL2sO8Tw2fUxvqdNvc
 g5Vfq7+L9TAcCwXuIT3u9FjjacO7cogXMZRS+R6wbi7YHAkXKrHw3+sISTTR0hPBps124JMEgiN
 0dY2ZWT85OmLuGaAz7O0EBNFpIwcpS3ySnwEkdviDxcHr15b7IIqlOf8KnS78xYPZvsIswND6Y4
 Ne0YtQHAI6+Js/8VyXgsMo59Q8Iot5pUlyNQDe0hhkmMKc4uPfMxmxZTMaUiDKgHG7z0nQlWvLv
 0Cl5Y2Z2FHvup5Uz7ZASAU7T9Ln+kmTS5JF9KBPKT3iTdjId1JtQFLHGzZ0I5MjeksdlJ8fCJVi
 X1aUkA4cYK/V1BsXCPtYssMj0wA0VzdZXehL05odOViY2CYPZFNZzvyewT8rEMAOCGKCfPU2Qw5
 bWkB1Ce7I2xw8FvlzgMwuDXZGfttHXOlMXSs2MRx6HFcu1uPlkO8fHjhKZjSw4aNqIQnzoB/8xF
 gXpUua/hGb5E8UNftnb
X-Received: by 2002:a17:90b:3d8d:b0:381:152b:d596 with SMTP id
 98e67ed59e1d1-392ec52f32emr733910a91.11.1786424179379; 
 Mon, 10 Aug 2026 21:56:19 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-392ee3084d0sm156818a91.8.2026.08.10.21.56.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 21:56:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 14/16] tcg/riscv64: Implement revbit8
Date: Mon, 10 Aug 2026 21:56:03 -0700
Message-ID: <20260811045605.1246543-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260811045605.1246543-1-richard.henderson@linaro.org>
References: <20260811045605.1246543-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv64/tcg-target.c.inc | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
index 687146e0b0..8fd32644fe 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -246,6 +246,9 @@ typedef enum {
     OPC_XNOR   = 0x40004033,
     OPC_ZEXT_H = 0x0800403b,
 
+    /* Zbkb: Bit Manipulation for Cryptography */
+    OPC_BREV8  = 0x68705013,
+
     /* Zicond: integer conditional operations */
     OPC_CZERO_EQZ = 0x0e005033,
     OPC_CZERO_NEZ = 0x0e007033,
@@ -2469,8 +2472,20 @@ static const TCGOutOpUnary outop_bswap64 = {
     .out_rr = tgen_bswap64,
 };
 
+static TCGConstraintSetIndex cset_revbit8(TCGType type, unsigned flags)
+{
+    return cpuinfo & CPUINFO_ZBKB ? C_O1_I1(r, r) : C_NotImplemented;
+}
+
+static void tgen_revbit8(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    tcg_out_opc_imm(s, OPC_BREV8, a0, a1, 0);
+}
+
 static const TCGOutOpUnary outop_revbit8 = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_revbit8,
+    .out_rr = tgen_revbit8,
 };
 
 static const TCGOutOpBswap outop_revbit32 = {
-- 
2.43.0


