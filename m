Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E36AE77182
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 15:31:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL26a-0004ey-MS; Tue, 10 Dec 2024 10:24:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL26W-0004YF-Jc
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:52 -0500
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL26V-0008PL-6Z
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:52 -0500
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3eb494c23e8so595304b6e.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 07:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733844289; x=1734449089; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UbTYBT6M4AjLujOKc33PQnRp59jWU9i7YG2GCTYtKsU=;
 b=GBfrUCusP+CUbTqs96Cc8iylmVwZZAXt9vTaPZJXXdilZULRqeN2cur4mpdkxXh1bm
 YODE8qUOGjxuoJbOSyfMuSBbyzbKfDWEQuaSKAGpukvdLZBHUJt84xCFBwSQsPlM1Jxe
 Q+IlQFae3vCAMxYse6o3VxvDBIyI26X2kas2j1DIWPu8/WUIPJFEA8GKoiuAejTl7BKM
 n34T9XAJe6H3G6726vRaLdtv7ZfSuWQQPPsqLOb6VrYWwIjcqLKQ/z9KTFTeAxYgijyJ
 ej1Bo+hkXDgC7jR3BUdsx38ybyJp3yeIHqcqYg15r7XVS08zALDI85kZLj5p8xluC/+d
 2V1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733844289; x=1734449089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UbTYBT6M4AjLujOKc33PQnRp59jWU9i7YG2GCTYtKsU=;
 b=Bh57SFPo/4zOxV0LfaA7kxrIVVXomptj8aW0fHTnfgmxghn1sk80wtxnzrfkUMpK8Z
 sfIKQ0im4NgkY/TPL5IVjIuXxz0jpSfAE32UyceNleigiWiMx7QBDFWOVakGo38JYHXD
 5K9zd2piumZ+gH5q0GqaT8DvWooXTRjlgrqaB3qkLQKYQhN1bl5RTXWT5550Hscsevc2
 OOZwzPjOMJil/G44QTlfSxmbrGA1crpyqZOvxBqkLuCwRGcgxVb1oBTczCHq4WxwHrqH
 YdIlLN6DevHJ3MyFzOFsVooRFtANLvE1Nq9jZ84J9MswU0Y8g0rn3nLldj6RvKElcLPl
 qU+w==
X-Gm-Message-State: AOJu0YyOo1dPt4ohefBsSJYFXD5DGH7pyRxzm/AjdiO0/ISdcTA1Z1Yk
 hMt4/vgKTEIemNKABMYvu44Er8PGtgNNo+vuPi4/fOkBr7DMg5H6Ea5Cl+ij7FLkuhqbAiSzypP
 aSt3nO4F1
X-Gm-Gg: ASbGncu1hQGpg1jhfi3Zm2zrQaKkDBzhV0HIowXuPZ7rENeUidUbZhtIR4QTXhyJ6Ir
 26sf8h2v1aD+w0P7MQs5XKATcpndpYfuiuSNb0QVLNzPNCVIWRQvtRJc5nsji06HqWZwLRVGCz+
 3TfDo6mRZayz4iCTBMtVHYGlMIOq4evNuHjZVSh2GA6pPuAL+6GTeG4n6D1Sonrlc900sSE3KnV
 nw67Arhf8GnpoRi1zya3g4EeEM8P7/1N70jGVQKTz5keF6djcWhZ/nL2+FQAg==
X-Google-Smtp-Source: AGHT+IHA8IILujYAHrFkNW2RHQrWAPIcgj3Q9nAZyXRmz3ugpx+nG00K0xsekWMcHwHV2/fRLLpKiw==
X-Received: by 2002:a05:6808:144a:b0:3eb:4681:a892 with SMTP id
 5614622812f47-3eb66dd6250mr3460550b6e.5.1733844289657; 
 Tue, 10 Dec 2024 07:24:49 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eb076b9168sm2776435b6e.14.2024.12.10.07.24.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 07:24:49 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 33/46] tcg/optimize: Use fold_masks_z in fold_setcond2
Date: Tue, 10 Dec 2024 09:23:48 -0600
Message-ID: <20241210152401.1823648-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210152401.1823648-1-richard.henderson@linaro.org>
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22c.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 0097502425..dd6ef3d831 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2450,9 +2450,7 @@ static bool fold_setcond2(OptContext *ctx, TCGOp *op)
         return fold_setcond(ctx, op);
     }
 
-    ctx->z_mask = 1;
-    ctx->s_mask = smask_from_zmask(1);
-    return false;
+    return fold_masks_z(ctx, op, 1);
 
  do_setcond_const:
     return tcg_opt_gen_movi(ctx, op, op->args[0], i);
-- 
2.43.0


