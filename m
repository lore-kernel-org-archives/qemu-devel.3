Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61EAEE7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 04:13:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOUMS-0008Ty-Hk; Thu, 19 Dec 2024 23:11:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUMF-0008Pa-9Z
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:24 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUMD-0006L1-99
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:23 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2ef6c56032eso980322a91.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 20:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734667880; x=1735272680; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c/ah1dWGqejqWrs6MT+NkiuxSvH28n+inVu2cC1XbF8=;
 b=pPFas3z2KDvEOYTzIqa/ZJyJkaSOJvyqDPmo8+7t1P9P+YjkGDJHVO7DeO7fA/qM+/
 VdgRKkZQIV0kqflrx/OVkmbPnzzXRwOTrUHNm5gOjXAPmTObE7IUz8OOXJNmdVEeOSEv
 FKTKHYoCR5Fw0zbC2No88L3SRMJTesVRMPxpSeTm2NfuSAGkw++zeo9rFaGx56mmR0Lg
 UCARvv13ZOf2vQd0H3Luij1ZQe+ZV2D5PyJeI8tLGLmQR9ZH9BmsT3rvWGYIE3ZCsDFh
 8VwTQMb2DAxnGNFPu9DKg20TyDpOwBNAS7qLaAkQb3ONgBy/Xi78wgM2n4UE6CoN4JDp
 pFEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667880; x=1735272680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c/ah1dWGqejqWrs6MT+NkiuxSvH28n+inVu2cC1XbF8=;
 b=ixPCbQKe+Lcn8+Q3l8KTr7p79udsthQUen8D6WjZaN/9FprrbA1fDIm5egxfrDRl+i
 hNZodKaYj8x6EANqgJNPsT7Fsfn1zBb/Dh0qIPFaDAt3rjyW9muLMJ3woIwSRBqvsJ/B
 4X086y8pxJvJhqd2Zr1WC4ANUs48HXgWZ4+zlon+ZbgaS78gh+3A+rCGDrHtbnwagYSo
 Otz15YjKeaCJ/z6Oyc1eGqEQ6+RI0OcPS57bpyv3OsDneXIQLlwJTT54nIPgCnV0Nokj
 G0nzwaVcVvLdvB0DGJ8N4vTrgZdXvn1SVz2Jlb32tX8S5UUpv8oByasTIzJRw1jPAfPd
 JIEg==
X-Gm-Message-State: AOJu0YzWBWm6inZX6LatpfcSA71t8InmIYQhuTD3xseKlVnd0+RFlVNS
 jvw0MTJfvQlUYwMhC0ah7z4wPB9TM16nzTm/UNHsU8EZ4TpvQhJfe3qMtOLHU2hYpvfkHB3H0/4
 e
X-Gm-Gg: ASbGncsC3pPj7Xyr0vAdej7Yw/q/HO4P2ktvK1+mk8Yk2Nwa8JJu/bChUFpWX03bshO
 z1fuPcpXKOZ9JEstDj8BbzDIt/GpkOHYj7gzqyQ6Ck2Nsc+eS2U5baRXe4BYLoNUFOp5klxmchk
 yYQZmdtEF09gQHcFYyzLL4Ibmrv98Otmcb/D0s4Oa8XdkH6BSRw3hMgILDbLG9eUmd5P3/N8YHJ
 medh3rdZfV1oWU4/YNqDFGfgAP5YiPbnc7VRBcNIWTbZF8IQGTKZDBtsnnkHJo=
X-Google-Smtp-Source: AGHT+IE7pDtLeLH7lEIFJbUq+uUHc4igYPb9+7PzmFyZm8bR4Xd+2ecCuHI5nqkKDva+oVQfcL9L3g==
X-Received: by 2002:a17:90b:518d:b0:2ee:c04a:4276 with SMTP id
 98e67ed59e1d1-2f452dfcd8amr2404191a91.5.1734667879863; 
 Thu, 19 Dec 2024 20:11:19 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ee26fc22sm4165260a91.51.2024.12.19.20.11.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 20:11:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 20/51] tcg/optimize: Use fold_masks_z in fold_extu
Date: Thu, 19 Dec 2024 20:10:32 -0800
Message-ID: <20241220041104.53105-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220041104.53105-1-richard.henderson@linaro.org>
References: <20241220041104.53105-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

Avoid the use of the OptContext slots.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 659190dcd8..85e6dcdb26 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1868,11 +1868,11 @@ static bool fold_extu(OptContext *ctx, TCGOp *op)
         g_assert_not_reached();
     }
 
-    ctx->z_mask = z_mask;
     if (!type_change && fold_affected_mask(ctx, op, z_mask_old ^ z_mask)) {
         return true;
     }
-    return fold_masks(ctx, op);
+
+    return fold_masks_z(ctx, op, z_mask);
 }
 
 static bool fold_mb(OptContext *ctx, TCGOp *op)
-- 
2.43.0


