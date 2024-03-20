Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACBCAC54E71
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 00:33:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmjsn-00007D-OJ; Tue, 19 Mar 2024 20:32:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmjsm-000075-VD
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 20:32:40 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmjsk-0005YD-HT
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 20:32:39 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6e6cb0f782bso5317820b3a.1
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 17:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710894757; x=1711499557; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cO2X5S7tqJGiWrlcfntAVFYIYWCP/fDIWBwAR5uSNVs=;
 b=ogt6z+as5yO6mstuX90JGCEYjaqbCktLMtFl7yKSA6HrawJRWKJRdf+721vP0R7mMI
 cYwd8TejwbOg7E3uYY01cpv6CLvkHU1XeEzs5OQcBqDo+yFkTjL1EcfJNOAyT21ZL07u
 GDt0YNsLUHzcG40eVMe9JWLx6Wkr/GDekiJj7j85tOpgC0Tk6DK6MHbJOwA6PDIT5+uC
 eggiXFdqzUW4IoMl5oHrIgnjBJ94HA7+Y7V8pP+5DMG/LX0JJSuHmrZ5+9ZPECyozXAP
 vTW7NxCpF0DD6n8RDJawEH3owwHOb9V3mlDJaR4Z1QZqwleG2+O7R4MbZ+B/gzOYK9tu
 y1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710894757; x=1711499557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cO2X5S7tqJGiWrlcfntAVFYIYWCP/fDIWBwAR5uSNVs=;
 b=B0V5uDI1llO6zhY09UI5A64SUUk1J39+WSV62yRozt5/ipdUjqX30mYaQGgHkJdtxH
 Co6AW93ia2Zq52X7GSWJReGJl8eTJ9BnZkogCGqfwMeQRMo49EPoukqAM9ME6JmP2NS6
 olAxRUpcUD6u6VZnGkbsbuQOIEjKCeDn2MemJmGDXT8EkVhlWVyZTo9PamwieBioAySN
 Lb6alDMdhdaGJKrmECiRkm2XGN+8z8aiEDdMaJsmJWW+ZyArVboYDA1WyY7RQP8edRXn
 qoVvs1BzI7CjiZFN6DQrvpXK0Yod9PlFRu6bTvrJOjI1mK7s5PewDDh+OY6D5pUwnGC2
 pmrA==
X-Gm-Message-State: AOJu0YxM91ARbf7uRXj4aIzyotwa9AzqphC+O5ITeM5gaHFPvmVj3b98
 ao0M3L+mq6QH9NQXZKK/j9dDbFsg+Rz5ZVR5ewCtKhHMs4cDIgbI7hrzePSC08PNQrq1eS87iJ8
 L
X-Google-Smtp-Source: AGHT+IHyc8ap3rwGtbsNcmselb1ASo2is238oSP5Giz4iOGR8502IiASq8nllAcK6HLCS/mdqeLrAQ==
X-Received: by 2002:a05:6a20:9f4d:b0:1a3:5991:4845 with SMTP id
 ml13-20020a056a209f4d00b001a359914845mr798239pzb.38.1710894757118; 
 Tue, 19 Mar 2024 17:32:37 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 d19-20020a63d653000000b005d553239b16sm8475645pgj.20.2024.03.19.17.32.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 17:32:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Sven Schnelle <svens@stackframe.org>,
	Helge Deller <deller@gmx.de>
Subject: [PULL 8/9] target/hppa: mask privilege bits in mfia
Date: Tue, 19 Mar 2024 14:32:22 -1000
Message-Id: <20240320003223.554145-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320003223.554145-1-richard.henderson@linaro.org>
References: <20240320003223.554145-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

From: Sven Schnelle <svens@stackframe.org>

mfia should return only the iaoq bits without privilege
bits.

Fixes: 98a9cb792c8 ("target-hppa: Implement system and memory-management insns")
Signed-off-by: Sven Schnelle <svens@stackframe.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Helge Deller <deller@gmx.de>
Message-Id: <20240319161921.487080-6-svens@stackframe.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 107d7f1a85..19594f917e 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2011,7 +2011,7 @@ static bool trans_mfia(DisasContext *ctx, arg_mfia *a)
 {
     unsigned rt = a->t;
     TCGv_i64 tmp = dest_gpr(ctx, rt);
-    tcg_gen_movi_i64(tmp, ctx->iaoq_f);
+    tcg_gen_movi_i64(tmp, ctx->iaoq_f & ~3ULL);
     save_gpr(ctx, rt, tmp);
 
     cond_free(&ctx->null_cond);
-- 
2.34.1


