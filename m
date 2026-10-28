Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC40A606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 16:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=GJEeKmi5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM6aM-0006Xu-04; Wed, 28 Oct 2026 12:33:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM6aK-0006Wz-N1
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 12:33:08 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM6aJ-0007Yo-2o
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 12:33:08 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-846566246e8so1069709a34.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 09:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793205186; x=1793809986; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ib3WcmPpduqmQAQzGFLThrdz609C8UkaI8Pr5YC7zC8=;
 b=GJEeKmi5nvPs0ebdOPgu4uvcROE8Jrlwnk0k833KejcT0RrAIUoWH/K1uYdWuByz+8
 zC2wGwNWElHDmWTD0yoXb1+1EgHyrUxG2AADta0m/JffqnEN51cS+E9SkAGyT4KCHpVu
 apy23segBY1gqXGXdhqtO5lQ3fa4qFvx9V+wAv/uOk4dEadd10ZcVgDN2yZz0Gpzb4uF
 4e+I51z2fJJ4hZ2/+zCj3x0K2UtXeu597wDdwNLPQcHGUaj9ZDBAxCEBNPksNR9m6AtF
 Pm3y1LabGhY7FLsYPm7+HCLqO7xAiuNrqV68PDCxSm7uZCZspVscYB/m9+L+ZVQUBHyA
 d7CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793205186; x=1793809986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ib3WcmPpduqmQAQzGFLThrdz609C8UkaI8Pr5YC7zC8=;
 b=HXE0QY5GLofOS0YBRInbEtlC8sYT73WmW/eDii7eaYHSrOHYgHFAL7vX0qwU3gb8gw
 lfwT+u9LvheRxESK6Zq5FjQSNuBqXgpLOffy1Uy+gJMWLfPVXGyuRRHd5gevNLuNqqq1
 u7KfrO9ufHZInFwdNIOT/gsbcjJmlL4mWbE/ZxTfB5dbHaf57eq7rneMT8oXirCgsJYG
 9ZRXiAvtm4dnpoavbRGRVDleYv2pBn/Ge5fQ4hjoGlvMiusjWTqo/rm/zUsOE+2yUDC+
 Z52OeEfuVZgRUPCV0S3FwzLgMbN6ltQt5qSGMd0HC49mZjX1q+mRJkzTc7QjesFEZdBM
 R/og==
X-Gm-Message-State: AFq9FYLWd0sg1FWjxz+icbrn7fGEXLV21neVRdgIYTZ4F2FUWqc7e3rp
 JYNrgtD2zEiCYOxFosBijFQ2lFYFuyFf9P1n/vkJFRg8XQyVcO8wZkyDDBqL1IvTX6RdlumZmqk
 EK6D3
X-Gm-Gg: AYBFou1XkH2woH3j4CBMTOUMDg4nnFAHUcxg6juCiB7VEX8dKPrTx7od22j1dy/rtk8
 sjHTXSGVRqz20ulvnx/bHlDWBuo3WnmlVXLW8Z8c1wjRwD3gbtyI1A20GNz/HvhM+WNXG/0wN5J
 c8F551MwypQDzOfOw8oGkAzbMXW3IijUzrC1RWQT5i8/fv97skE1lUarCvwNbTYw9/ZLxAaou9S
 Hfp9sE6OEXmyLSo4NGv8ZSAYiYW86/JFHLIZSGCX9zOCC3tEP71u8eMqphueEn326tdakJUrLX9
 v7evyNYvgSYQ/hZGgGdNhTiNzU7kNymkmXPBRFhxLMbHlX6smWa+w8jb01fbdDEmZEXjcI9NVJh
 OMfG2lYXYke/Mm+qZqghNxhEdfO1kfjZx6PtRbE1ZtT+zAY7I1r3kbFLol6Y8w/aiPu3GMDg/EE
 qvY9eH+0hLZVTHYZrruvH4dQuyjVSKJ3vF9zi5SXuzIP+5E6cFzBLpk+wCfajH8MZbg+laDcxYy
 Yy+oaeVsXFw4Eh3lFHaZTdfIgAPPMQE/v1e5q36AJPw2UpIToOyoDrh3EFze/tx3s0JvvMDZhv5
 jvVgLtNIWQ6SnDqhnrX5JFjE85DrrRQj/Q==
X-Received: by 2002:a05:6830:3495:b0:846:9414:ded with SMTP id
 46e09a7af769-85c1e2b659fmr77449a34.5.1793205185542; 
 Wed, 28 Oct 2026 09:33:05 -0700 (PDT)
Received: from stoup ([2607:fb91:2c2e:8a8c:60fa:827:925e:3bb6])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85b1f4368f3sm2538965a34.7.2026.10.28.09.33.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 09:33:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PATCH v3 15/16] tcg/riscv64: Implement INDEX_op_lea
Date: Wed, 28 Oct 2026 11:32:44 -0500
Message-ID: <20261028163245.1031673-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028163245.1031673-1-richard.henderson@linaro.org>
References: <20261028163245.1031673-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x333.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv64/tcg-target-has.h | 12 ++++++++++--
 tcg/riscv64/tcg-target.c.inc | 16 +++++++++++++++-
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/tcg/riscv64/tcg-target-has.h b/tcg/riscv64/tcg-target-has.h
index 93f8baad09..3cdeb5c390 100644
--- a/tcg/riscv64/tcg-target-has.h
+++ b/tcg/riscv64/tcg-target-has.h
@@ -69,7 +69,15 @@ tcg_target_sextract_valid(TCGType type, unsigned ofs, unsigned len)
 
 #define TCG_TARGET_deposit_valid(type, ofs, len)  0
 
-#define TCG_TARGET_lea_sh_valid(type, sh)         0
-#define TCG_TARGET_lea_imm_valid(type, imm)       0
+/*
+ * The SH*ADD instructions only operate on full register width.
+ * To allow TCG_TYPE_I32, we'd need a subsequent extension,
+ * with the result no better than the separate shift+add insns.
+ */
+#define TCG_TARGET_lea_sh_valid(type, sh)         \
+    (cpuinfo & CPUINFO_ZBA &&                     \
+     (type) == TCG_TYPE_REG &&                    \
+     (sh) >= 1 && (sh) <= 3)
+#define TCG_TARGET_lea_imm_valid(type, imm)       ((imm) == 0)
 
 #endif
diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
index ec0c8e1af0..6da52929a4 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -224,6 +224,7 @@ typedef enum {
 
     /* Zba: Bit manipulation extension, address generation */
     OPC_ADD_UW = 0x0800003b,
+    OPC_SHxADD = 0x20000033,  /* plus sh << 13 */
 
     /* Zbb: Bit manipulation extension, basic bit manipulation */
     OPC_ANDN   = 0x40007033,
@@ -2740,8 +2741,21 @@ static const TCGOutOpStore outop_st = {
     .out_r = tcg_out_st,
 };
 
+static void tgen_lea(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
+                     TCGReg a2, unsigned sh, tcg_target_long imm)
+{
+    tcg_out32(s, encode_r(OPC_SHxADD, a0, a2, a1) | (sh << 13));
+}
+
+static TCGConstraintSetIndex cset_zba_rrr(TCGType type, unsigned flags)
+{
+    return cpuinfo & CPUINFO_ZBA ? C_O1_I2(r, r, r) : C_NotImplemented;
+}
+
 static const TCGOutOpLea outop_lea = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_zba_rrr,
+    .out = tgen_lea,
 };
 
 static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
-- 
2.53.0


