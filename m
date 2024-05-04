Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3074C4345F
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2024 15:41:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3HU7-00022R-N2; Sat, 04 May 2024 11:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3HU5-00021J-KQ
 for qemu-devel@nongnu.org; Sat, 04 May 2024 11:39:33 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3HU4-0006EC-4l
 for qemu-devel@nongnu.org; Sat, 04 May 2024 11:39:33 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1ecd9a81966so18850285ad.0
 for <qemu-devel@nongnu.org>; Sat, 04 May 2024 08:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714837170; x=1715441970; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p/6g7IPHM26fk2SatJJUV9sUQh1e0SSWEbxZZLoVbHA=;
 b=F1sIB0CNuDpGOPLpd19Zc97N4nLD594fe8PbPGvT44rk6PVG2BerYQ2q/+p1R0QLHh
 iZ1jkoFNIGeqqBP91+KU2VxJG1ddcXGKPXFGCUA/zGJdTH3m2N2W5xP81dnNkZ05lzra
 J2zuBNOW+HhXfpd6rucpXWO6y6s46rJ+IU9cbWypBxfvEMb69CSKjEcl0qNy6m9LA05n
 QS/ONzJ/rs3aTVDHfI0C6jnJZ+8FMgrO9ChOh3XzA/F5DE8L/b5G10Oa4rI95rdmkT9n
 l3S+xC6V2I3Vrwk8G8+szA5y8P0SX9Q7tzJXYyLmBRGMGkDJoZvajUJTzbdB3DngKtax
 yRjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714837170; x=1715441970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p/6g7IPHM26fk2SatJJUV9sUQh1e0SSWEbxZZLoVbHA=;
 b=Tr0YOu7uNoVUU2P55k6bCE6oSZNXX8n+Vt0zBxv5atzLMkGeEfgzTjw8/y3nZEt9vf
 hXPPKxF2V7wma4MKKVMigxE9GgXSCbTaScAqJ7vM4hwAvtPv097baJWutDNVIb+xhfxQ
 ULtazMwsZGBma4Ja8NEuvnwPImILqmWZnzXVSYZA7+AXoQMFh9xzd9MA68+AmiUbjZai
 74qWklds2flXUVZ1SBYVNoRlG6DijvrrlOi7UeULXcL9ygMsVFVodVJ0QKTKKtFY/zeC
 U1jgNIye96fIl6ygzwLcsLL0royJmcC8RcQUB4e5dctraJDTPgXD35HQfNzwWgOgmHtf
 56HA==
X-Gm-Message-State: AOJu0Yx0LRyosWkxJgp8YrlZ13hZbQiuUuoarEOf+MQfuCjV2/nNeoCY
 EVeJ4SgwFm4EF7B2BnRHzul2NdEaWQGQRfAVY7FauReWoZp04efqmih7tcbOQQhCYk/qNQ3MoUh
 4
X-Google-Smtp-Source: AGHT+IHlSBk2718oh16x7sxkqipeOzJ0wd5gKWFo5XPRWOmKYFDIKbXAYb07p/scMSXWGvGVP0JgRQ==
X-Received: by 2002:a17:902:e752:b0:1e3:ce12:ef77 with SMTP id
 p18-20020a170902e75200b001e3ce12ef77mr8437938plf.11.1714837170177; 
 Sat, 04 May 2024 08:39:30 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 n15-20020a170902e54f00b001e4d22f828fsm5197859plf.33.2024.05.04.08.39.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 May 2024 08:39:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 2/9] target/alpha: Hoist branch shift to initial decode
Date: Sat,  4 May 2024 08:39:19 -0700
Message-Id: <20240504153926.357845-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240504153926.357845-1-richard.henderson@linaro.org>
References: <20240504153926.357845-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240503072014.24751-3-philmd@linaro.org>
---
 target/alpha/translate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index a97cd54f0c..52c2e6248b 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -432,7 +432,7 @@ static bool use_goto_tb(DisasContext *ctx, uint64_t dest)
 
 static DisasJumpType gen_bdirect(DisasContext *ctx, int ra, int32_t disp)
 {
-    uint64_t dest = ctx->base.pc_next + (disp << 2);
+    uint64_t dest = ctx->base.pc_next + disp;
 
     if (ra != 31) {
         tcg_gen_movi_i64(ctx->ir[ra], ctx->base.pc_next);
@@ -455,7 +455,7 @@ static DisasJumpType gen_bdirect(DisasContext *ctx, int ra, int32_t disp)
 static DisasJumpType gen_bcond_internal(DisasContext *ctx, TCGCond cond,
                                         TCGv cmp, uint64_t imm, int32_t disp)
 {
-    uint64_t dest = ctx->base.pc_next + (disp << 2);
+    uint64_t dest = ctx->base.pc_next + disp;
     TCGLabel *lab_true = gen_new_label();
 
     if (use_goto_tb(ctx, dest)) {
@@ -1382,7 +1382,7 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
     real_islit = islit = extract32(insn, 12, 1);
     lit = extract32(insn, 13, 8);
 
-    disp21 = sextract32(insn, 0, 21);
+    disp21 = sextract32(insn, 0, 21) * 4;
     disp16 = sextract32(insn, 0, 16);
     disp12 = sextract32(insn, 0, 12);
 
-- 
2.34.1


