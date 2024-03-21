Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D5FC54E58
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 19:29:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnO5S-0005Ju-Pt; Thu, 21 Mar 2024 15:28:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rnO5P-0005HW-Ql
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 15:28:23 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rnO5N-0006nW-HE
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 15:28:23 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1dee27acf7aso9459245ad.2
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 12:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711049299; x=1711654099; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j3kLKwxrLH+M2Nw+NGqU18RKQy972773C7GhxsV0pgI=;
 b=kkk33ffqZjGF2lcP5G4BmL3AA8FcUaA3gEo5s1MgV02acoVDTZfeEsJi9/4hOuUlqK
 iFYL7rUdXcfem43U8CatSdna2OWMbkFdIqKoXHHSa/yNVDF64dD6H8NrzHkiJo/Rd1te
 Te0s34qHY5gy+HzBkwvEsMt5u1/bOLJzaR3Dm9dLj6StQYcbp8XGJp6Rot9mJ2J4uBRa
 K4bLUi8Mr/FuIXgcf/tQvNVZ+wX4xtqcMmueyis6t+YRLlvIk8Adc6NwM18CGun7nYv4
 CAFIRVKrgjfbWnhsMRF3gq7Pef0cl+o43aG3UxMuTv+5v2D/MlUxc1cfCdPk5Fc/BkkP
 7L0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711049299; x=1711654099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j3kLKwxrLH+M2Nw+NGqU18RKQy972773C7GhxsV0pgI=;
 b=scB6JP7I/1QPu42o7TYVdVzBPxc2vI9KYZh9h44O12tB7ANqoIxYjB9+q9+Clx6usA
 ZjuIXBfSMLxFkhDsYPLBqgT7zwwsp5fvvvjisf+kXmhzAZ3v6iD7LrUl27eZIS5TkDJJ
 +lOf6PgVR2Og455mgd9PQvD10+REGLETiDExoSgm2NTQp9EC7k0xpmt3u/GRiCN86rDP
 HkR70UYLBbXe36YvrIplbIJ3XL6qWRNuZljJk7cAsFrUkW3PAy5NM2GTJeikC+80Oq0+
 /rDc1K8/Jqbtz5t0Ile8MDqJKUi5f+6+LSvcS/goqfDLy1akgKVuauCPHI123cin+H5x
 uKRQ==
X-Gm-Message-State: AOJu0Yw+4h9b2tHSLnwZOVT1TnBrJq+1uSLprKWZ2HgWSwxPgqVTaws1
 /1RhDQxRegv+az5n33IVVuk3R2ntvfRWeQxJeQ+UasGPR8uBBTxw2yQVUgkEROueQQqmu08xWJ8
 I
X-Google-Smtp-Source: AGHT+IENh3S9HBZYRL2Lcr4bx3d6dNsM9FEsfKCO5tgT7LECF809rHrn+Ul4QBLtbOU2wQS+54NRyQ==
X-Received: by 2002:a17:902:7248:b0:1de:e5aa:5ce with SMTP id
 c8-20020a170902724800b001dee5aa05cemr337569pll.41.1711049299140; 
 Thu, 21 Mar 2024 12:28:19 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 p8-20020a1709027ec800b001e06c1eed85sm207303plb.141.2024.03.21.12.28.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Mar 2024 12:28:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de,
	svens@stackframe.org
Subject: [PATCH 2/2] target/hppa: Fix B,GATE for wide mode
Date: Thu, 21 Mar 2024 09:28:13 -1000
Message-Id: <20240321192813.371526-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240321192813.371526-1-richard.henderson@linaro.org>
References: <20240321192813.371526-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Do not clobber the high bits of the address by using a 32-bit deposit.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 1766a63001..f875d76a23 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3880,7 +3880,7 @@ static bool trans_b_gate(DisasContext *ctx, arg_b_gate *a)
         }
         /* No change for non-gateway pages or for priv decrease.  */
         if (type >= 4 && type - 4 < ctx->privilege) {
-            dest = deposit32(dest, 0, 2, type - 4);
+            dest = deposit64(dest, 0, 2, type - 4);
         }
     } else {
         dest &= -4;  /* priv = 0 */
-- 
2.34.1


