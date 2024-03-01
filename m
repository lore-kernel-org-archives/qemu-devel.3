Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BFABC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 23:20:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgC2d-0005fq-7V; Fri, 01 Mar 2024 18:11:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgC1h-0003xC-Dd
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:10:54 -0500
Received: from mail-il1-x129.google.com ([2607:f8b0:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgC1f-0005tx-Pp
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:10:49 -0500
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-365c9d37995so8900715ab.0
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 15:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709334644; x=1709939444; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mnZ6WGfrFw+xqlID/o+DhOWiMwOEcHx/bjX2Yi5iHU4=;
 b=Fcp1o/8eEYU+rAHbsGUFfNVqvaSxMiVYRpVqnpudw/WTgNzqt4niI7u4bxZRaDqMab
 kKsdjabPM2PK5vWHCMeTj/3z/tkPWipIKfPEJHT2qMx3E5S3HPqlo3ciRnmgqoZj4LPB
 LSz+UB5vINbNq3/VEh2xn428nlWmWOm5Wc8xYmWXGhULsovBhjHEeUnq8j6c50BfV8if
 U5HHzkG0s/kaxz9XFlDcasdIs4jiNvLDyMGRbFyUKeo19JIBAPF5lXGVrCKbVNhU9foB
 9GQq55k4ArmR9BTzD0qBgss+Y7VxLt2U7kcqPCCF5JXFopzr9q+nBHTkBTPY7M0VOqzp
 j2yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709334644; x=1709939444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mnZ6WGfrFw+xqlID/o+DhOWiMwOEcHx/bjX2Yi5iHU4=;
 b=bBbkX+sepe6tajrrhCi6Vew7PUfPoZL7pO+9Dt/+hEbfoU+XzQCtOJyFduGiFdR1zd
 epe3YMdKSfhPaDld9DZr2mUYZfLVxZZAWRkzyofLiADmYIQQK3epwkkgzQBXATOwozW/
 vh3Etd+yH6RBQdgnvlR9FrhQLVY0QdnsiuDII0q1J6pNBp/Ssc1zNmE2Z+bvvnYqTnmQ
 4eZiSzd54UFziUAjQXi7So+WoTI/hSjwSxk591knvQpZK1Igenxp2Ea9pzmJ666aW3Do
 CXgi1hkKAOB+e901wF5oxSGG2P03+allQeaugx0pYGcIY5w3/wtwUTqTQcbsUJrB1RiM
 xegg==
X-Gm-Message-State: AOJu0Yyzlfvl3iHoqhBYj/FUxFz2l0+Y7xQMZFAxGl3Vf9aqCyXxv1Yf
 8fxYDar70mcxxzfjvhxlSu43Xo9a5x1Q2n8iLYf+I6YxsuEJjIOqwAy5pWjKCdX1zdmensZRqnS
 D
X-Google-Smtp-Source: AGHT+IGZOFWZ+KOoQQ0ys4Mu0J69poau1G6EUdBz3ea/KJr4jAItk2B/aMtL0xJI85+zF5MSApmIrA==
X-Received: by 2002:a05:6e02:2196:b0:363:c576:d6d5 with SMTP id
 j22-20020a056e02219600b00363c576d6d5mr3651397ila.4.1709334644356; 
 Fri, 01 Mar 2024 15:10:44 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 c2-20020a634e02000000b005e438fe702dsm3449407pgb.65.2024.03.01.15.10.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 15:10:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 55/60] tcg/optimize: fix uninitialized variable
Date: Fri,  1 Mar 2024 13:06:14 -1000
Message-Id: <20240301230619.661008-56-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301230619.661008-1-richard.henderson@linaro.org>
References: <20240301230619.661008-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::129;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Paolo Bonzini <pbonzini@redhat.com>

The variables uext_opc and sext_opc are used without initialization if
TCG_TARGET_extract_i{32,64}_valid returns false.  The result, depending
on the compiler, might be the generation of extract and sextract opcodes
with invalid offset and count, or just random data in the TCG opcode
stream.

Fixes: ceb9ee06b71 ("tcg/optimize: Handle TCG_COND_TST{EQ,NE}", 2024-02-03)
Cc: Richard Henderson <pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240228110641.287205-1-pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 79e701652b..752cc5c56b 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2102,7 +2102,8 @@ static bool fold_remainder(OptContext *ctx, TCGOp *op)
 
 static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
 {
-    TCGOpcode and_opc, sub_opc, xor_opc, neg_opc, shr_opc, uext_opc, sext_opc;
+    TCGOpcode and_opc, sub_opc, xor_opc, neg_opc, shr_opc;
+    TCGOpcode uext_opc = 0, sext_opc = 0;
     TCGCond cond = op->args[3];
     TCGArg ret, src1, src2;
     TCGOp *op2;
-- 
2.34.1


