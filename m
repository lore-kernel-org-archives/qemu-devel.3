Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BC3BD4A5F1
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 03:35:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgabw-00007h-2h; Thu, 15 Jan 2026 22:34:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgabs-00087J-Jv
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:34:52 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgabq-0005rd-RX
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:34:52 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-34c84ec3b6eso1345733a91.3
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 19:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768534489; x=1769139289; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U5sBU2zk1bX0ddl3O5KkamyL/V1clpqH1xPWvT/iVmQ=;
 b=mzerapluU1pkEfGURjdoGNGGck4Y5vIK1vpBVYvwkWRRKV3jFYgso4xh5+AtDBbkCd
 rVt3mbm+HW9U3XOA0SHlpnovTNokqPszjRSQdiOnkHGjmKsUrTgxNrElC13G6wGtQtjd
 wgCYCHjqtdNV0OCkcJYN0CKxY8uVp5eHKK+hA3hGTnihukzxkV00Zx00vm9akPnHh+yD
 kFOVobpssgI2aZEx5ilKIA7+j9sk21mEZ/VlYww3fH5ppZ6a61KeitmOZP6kGaU1CqCO
 2YGA6LT4LD3gJYifaX6UapaYQpW9XQoHnflZag2lkRJ5V/47OcMF/1vRhSNNrkwd41Xe
 YlJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768534489; x=1769139289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U5sBU2zk1bX0ddl3O5KkamyL/V1clpqH1xPWvT/iVmQ=;
 b=FQuQq5Ijaw2zZ2OkzwRCwAglgBsa2do/WubDWayXR/vmrx9+JJGQ+yoysioJEUzMb9
 ZrYWkHKVfhULqSJzZx3yHF0eOGjzAU7o2f1Swyjoss+RmKrLgfyS+NgVld2Ywo7h3xpw
 Al4mW7NNfy9qkwhNZvst5oXGcheTwGb3EB4CoIVrxv/xPExi6i+IKDvPEoW5D4+JZbMm
 fFOLTKes1iB1wcmScUb5yRzR87/G1JJUcPiNZx0VjLFV1hFXmQl5wlfWs6110LTmYmLI
 FRTAlMs9zQ9ehXDKj/zECuJHR7tvFJEu1UI2C0Yj5C1tauObXIFBgu7QBlPHHgkfjSOF
 D0Sw==
X-Gm-Message-State: AOJu0YwgG8lg5d5zZR7J+IRGthy77WnxeGU/KHEF7o4eI6jD4hYw4ZPA
 zPn+9u/vQ7QM5i1Y4Km0rnPJrEPEJVTDH7IShwgTf+wErpG3djDse1ydN6wZfjGeGmkGk44VTFl
 eit5dWJYpmA==
X-Gm-Gg: AY/fxX6uUnhiKRd5CZFIhJRrDN5VgPJE1KJBx0S2cjUrKr+8lMz/9kgN4zChZA9o3nx
 aIAVHp0zwpGCm2MfqUsTFvfxmL1ItebD9U/WV33bzv52YIgaj9G6iDZxyvKOgKpJOSjbMpjVG0x
 717U/xbOGg6dOhk7SJwDcoPJdo0/6QwL3irXAcs/j81XLWe+4YHl7DskbJugtFpVd9V9WcJC71C
 wb0JZIRTKo6Q632xrrvEx9vl28NuRxIZRznkzKaevQxGAt98wP6udzdCuBjngWFueZ5eyqBOon/
 U8ftYtXc5grz4z+CzLl0kkZ642WZ6CxTD3vtyvjmSj4J1l/0VzfshtpEIjiJSwuReFoDv7pJW11
 Y04m8Wz4vFByvf0/c407qg68CsWYREiWsBCwoxrDTfSqCvxCV1BYjuKsMH0jF/QxJBfYcrpEcSq
 ELegqtb3j3Aba31skwew==
X-Received: by 2002:a17:90b:58c4:b0:34c:9cf7:60a0 with SMTP id
 98e67ed59e1d1-35272ec5a42mr1176126a91.5.1768534489423; 
 Thu, 15 Jan 2026 19:34:49 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81fa12b5c67sm683372b3a.69.2026.01.15.19.34.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 19:34:49 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ktokunaga.mail@gmail.com, berrange@redhat.com, pierrick.bouvier@linaro.org,
 thuth@redhat.com, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v2 24/58] tcg: Replace TCG_TARGET_REG_BITS / 8
Date: Fri, 16 Jan 2026 14:32:30 +1100
Message-ID: <20260116033305.51162-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116033305.51162-1-richard.henderson@linaro.org>
References: <20260116033305.51162-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

Use sizeof(tcg_target_long) instead of division.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-gvec.c                | 2 +-
 tcg/loongarch64/tcg-target.c.inc | 4 ++--
 tcg/ppc64/tcg-target.c.inc       | 2 +-
 tcg/riscv64/tcg-target.c.inc     | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 2d184547ba..9c33430638 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -607,7 +607,7 @@ static void do_dup(unsigned vece, TCGv_ptr dbase, uint32_t dofs,
     }
 
     /* Otherwise, inline with an integer type, unless "large".  */
-    if (check_size_impl(oprsz, TCG_TARGET_REG_BITS / 8)) {
+    if (check_size_impl(oprsz, sizeof(tcg_target_long))) {
         t_64 = NULL;
         t_32 = NULL;
 
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 10c69211ac..c3350c90fc 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -2604,7 +2604,7 @@ static const int tcg_target_callee_save_regs[] = {
 };
 
 /* Stack frame parameters.  */
-#define REG_SIZE   (TCG_TARGET_REG_BITS / 8)
+#define REG_SIZE   ((int)sizeof(tcg_target_long))
 #define SAVE_SIZE  ((int)ARRAY_SIZE(tcg_target_callee_save_regs) * REG_SIZE)
 #define TEMP_SIZE  (CPU_TEMP_BUF_NLONGS * (int)sizeof(long))
 #define FRAME_SIZE ((TCG_STATIC_CALL_ARGS_SIZE + TEMP_SIZE + SAVE_SIZE \
@@ -2731,7 +2731,7 @@ static const DebugFrame debug_frame = {
     .h.cie.id = -1,
     .h.cie.version = 1,
     .h.cie.code_align = 1,
-    .h.cie.data_align = -(TCG_TARGET_REG_BITS / 8) & 0x7f, /* sleb128 */
+    .h.cie.data_align = -sizeof(tcg_target_long) & 0x7f, /* sleb128 */
     .h.cie.return_column = TCG_REG_RA,
 
     /* Total FDE size does not include the "len" member.  */
diff --git a/tcg/ppc64/tcg-target.c.inc b/tcg/ppc64/tcg-target.c.inc
index 3c36b26f25..b54afa0b6d 100644
--- a/tcg/ppc64/tcg-target.c.inc
+++ b/tcg/ppc64/tcg-target.c.inc
@@ -70,7 +70,7 @@
 #define SZP  ((int)sizeof(void *))
 
 /* Shorthand for size of a register.  */
-#define SZR  (TCG_TARGET_REG_BITS / 8)
+#define SZR  ((int)sizeof(tcg_target_long))
 
 #define TCG_CT_CONST_S16     0x00100
 #define TCG_CT_CONST_U16     0x00200
diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
index 0967a445a3..76dd4fca97 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -2934,7 +2934,7 @@ static const int tcg_target_callee_save_regs[] = {
 };
 
 /* Stack frame parameters.  */
-#define REG_SIZE   (TCG_TARGET_REG_BITS / 8)
+#define REG_SIZE   ((int)sizeof(tcg_target_long))
 #define SAVE_SIZE  ((int)ARRAY_SIZE(tcg_target_callee_save_regs) * REG_SIZE)
 #define TEMP_SIZE  (CPU_TEMP_BUF_NLONGS * (int)sizeof(long))
 #define FRAME_SIZE ((TCG_STATIC_CALL_ARGS_SIZE + TEMP_SIZE + SAVE_SIZE \
@@ -3114,7 +3114,7 @@ static const DebugFrame debug_frame = {
     .h.cie.id = -1,
     .h.cie.version = 1,
     .h.cie.code_align = 1,
-    .h.cie.data_align = -(TCG_TARGET_REG_BITS / 8) & 0x7f, /* sleb128 */
+    .h.cie.data_align = -sizeof(tcg_target_long) & 0x7f, /* sleb128 */
     .h.cie.return_column = TCG_REG_RA,
 
     /* Total FDE size does not include the "len" member.  */
-- 
2.43.0


