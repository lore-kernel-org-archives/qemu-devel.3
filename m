Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0213CC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 01:11:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHWQL-0007fn-It; Thu, 15 Oct 2026 21:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWN6-0001T5-7l
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:04:38 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWMs-0004Mn-JG
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:04:29 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2e942864693so10294155ad.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 18:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792112655; x=1792717455; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tuRxje2HcHZ4GN5v6rZcVWNAH/Q1DUuaARERIlZoXOs=;
 b=bLtq6EzdggTpdPzriozMlSC4hbOpaTwVDpZsN5X873cDLLqCG5iccK0zK8xE2AmBlN
 eal3jRAQ6qRIAvDLbbB58GwkmYAmtnxcGp3Rg7JQiWUXIdkhDXfV8k2467MwLsopvYE0
 yDDsgOpFawYL/y1sNm/5kStYNW/tIrlyObjRj7xQRFj4jXHKaCYQC3H391aqbFG82KjZ
 wnSdMvb9N2kTALIBAQBhV/ej9jZ/Rfzh3PyMdCHoJwV3DwZdN5Xwco4nOxkfKuIP1fAl
 Yv+RhmdBozNgkUouiYHSCGcJ2xSCWSm25WLRQ9VKNr47gSviFbFAjXkemr1vMbCwczBz
 my4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792112655; x=1792717455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tuRxje2HcHZ4GN5v6rZcVWNAH/Q1DUuaARERIlZoXOs=;
 b=COdrZs444IpOSM4hQabdAKiHErO/9uKO3DQAlQ+Hs86UEmyUSX3CTYYkXF8WCIr96U
 pZYYYooltyQosNULCTWuNqrRwFzte59h0N/xwNjsf6BHype1YVy+WnjNIK6xju9FP+ho
 ml9T/sOBeNyFd6kd3CKwr77w+UlAWjOUVzjQvf5hKNHJo1DP8d9y1OXh3y0AVJ0MkGqC
 55S00TNlVcVm8v2MY4A7w6EAe8vPxlbM5VkPOuDb6N4xQ2EezPoDdlF6bPu5eRsZhEEw
 UWDiYrHBUZ8hJx2NH7jZGdXLKtrLjY26GZHSdyl8254VbmeNxOIKfub/EfziKdY5eUgy
 s3SQ==
X-Gm-Message-State: AFq9FYK0vebFp22HzoQyU251044L4wUrykAPoCMYpcuP8iF34dsKd7li
 0bU8yBJ8FSWJ3bYPZlXRpBsuEwYA+vkUV9TOQU/9rDqt4fxTYa9LL73jUN6SGw==
X-Gm-Gg: AYBFou2e2grXG0V7EQARlxwrdM297nBpOlHG0xSuQqTAoj5Rh8B0H9JbZkaGpX3bEbi
 cjGlDTt9AGJ4VMCRPTa0d+UY7hGuilivNPbq5fW6g5PJjQQ8Y5eOzn5U2lwdlLjrZQPT6gOsJ5X
 GMantyxMpF8hLGRnwRP3/RjerR/BTavXcchHgPegepzTYQiYZzeF1tMhOrFHzuqb3x/Rw9DJxdu
 JudUKU9G8Jrm649fHKKGWo46RVKPD4vX9TGp2F1ZBun03Xj2f4wLmjejN/dsfGk71CEtSu4zXRb
 tq/IOglSBX0VHiyWQUMOkbyYYq0gxxJH1vdhtCCOeqmW+Y1Mt7znf1NpQFD3mziY2tP4Pp6gRbU
 2qVaRnuTzaDPfE/ej8AlObqXXaempJKYGh9WPLoEPA+5TUgj4AOlOh3y2aW1YIzdF6Wai+QOYpW
 Utxucdb4gXFM+ZLQUJumIyOf6Xg5I6ggcNyuesqwsU2RJhM7gzishgiMdIOyKmuCKhwNey7JOtr
 XARtVidh77DKiGs
X-Received: by 2002:a17:903:1ae3:b0:2e2:d77b:e587 with SMTP id
 d9443c01a7336-2e842cd4484mr211516035ad.18.1792112655033; 
 Thu, 15 Oct 2026 18:04:15 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e97e833f1asm2513995ad.43.2026.10.15.18.04.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 18:04:14 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Frank Chang <frank.chang@sifive.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Max Chou <max.chou@sifive.com>, Chao Liu <chao.liu@processmission.com>
Subject: [PULL v2 31/50] target/riscv/cpu: Add SiFive custom int8 matmul
 extension implied rules
Date: Fri, 16 Oct 2026 11:02:18 +1000
Message-ID: <20261016010237.1102834-32-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016010237.1102834-1-alistair.francis@wdc.com>
References: <20261016010237.1102834-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62f.google.com
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

Add SiFive custom int8 matmul extension implied rules to enable the
implied extensions of SiFive custom int8 matmul extension recursively.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Message-ID: <20260927082534.3228237-4-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f99698b83e..9e3d096802 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2920,6 +2920,24 @@ static RISCVCPUImpliedExtsRule ZVFBFA_IMPLIED = {
     },
 };
 
+static RISCVCPUImpliedExtsRule XSFVQMACCDOD_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_xsfvqmaccdod),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zve32x),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule XSFVQMACCQOQ_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_xsfvqmaccqoq),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zve32x),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
 RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] = {
     &RVA_IMPLIED, &RVD_IMPLIED, &RVF_IMPLIED,
     &RVM_IMPLIED, &RVV_IMPLIED, &RVG_IMPLIED,
@@ -2971,6 +2989,8 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
     &SMCTR_IMPLIED,
     &SSCTR_IMPLIED,
     &SSSTATEEN_IMPLIED,
+    &XSFVQMACCDOD_IMPLIED,
+    &XSFVQMACCQOQ_IMPLIED,
     NULL
 };
 
-- 
2.55.0


