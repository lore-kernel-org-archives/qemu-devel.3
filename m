Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A598C5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 08:10:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMMiw-0001BE-HW; Tue, 03 Jun 2025 04:10:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uMMiu-00014B-6l
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 04:10:16 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uMMis-0005is-Jd
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 04:10:15 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-450ce671a08so33347685e9.3
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 01:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748938213; x=1749543013; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K1bQaAugGeMJSCKz4R3NKt0GivJQ1nRUOrHwJAgAoZY=;
 b=NyhrpzxgrKry6GTKYR7Zv2BiXBAluqP/aovN7JJ5yz0V61RXpAfrSSrNo2IONj6tQ0
 DN2joN+lx0cX7dHpK7glPiRgbNzlFd05bv914gncthnPNOTrJ/dHhs1HBB8W4GBZoby9
 AXRFmHbM8offISkKnmtRcukfiyFyVKblOGQC3o2lVGH8Uimt+7koBOZBOcwb6dTDkFUo
 JWbhrNaYt2FIQk4sAB6xctJucEHY0c1qjKPZnkfrhSRBiP+gApFBY9Ao2VGwsCll/MZi
 I89cM+c3lu0SmvVgnQtdP2feftv7MSb9AAUKMnVH1MP70Ld10kjEBZ1ai4k6Q/slojFM
 dA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748938213; x=1749543013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K1bQaAugGeMJSCKz4R3NKt0GivJQ1nRUOrHwJAgAoZY=;
 b=cETvwcqUsb0UpIdOznmH494RY0GDjudSIh6z6p+4O3tuPPgn8rO10YGVfDX4ExpHER
 QCLjbouz0eoptPRWq2r5aEPYzESQa6gRRKggvi8KcAa2Pd6s+5SrXDFCThnB/LfubwF3
 Tyth5R7bNKSTo+rBF75/9xCBX21U8xTccKpdwgIdF1oC0Zf/fNiIOFUZF8xLiVUx+6Sl
 DjvK8PnifzA2f702135Ss02kkoJgN7vkgEPrsy+y08JJ2vjbkbozz8U5S623N1As/sOs
 BvnPXEUjsRWXQ33VRzpK6wKhwxZtXtMKMKZfi6N1bjEPmBCb4Tcq4ELYA3Msj4fCs8mT
 j2eA==
X-Gm-Message-State: AOJu0YwngHWvmo5WPVwa0eJLiazo1jDSMzbKU/T6pTPPtx0xt3kM6QLC
 cWEYoH1CIEsYOkAN6r+VyjAf0TdlAG+v5RfKa9WYoo7OnLZioi0t0aL4ExRnLAlqjIRAgR7j6zA
 05V6Ucuw=
X-Gm-Gg: ASbGncstpD5vIFWG+fHKxMfqepe9tCzSGARpHcSroEfkJqH/mMjWSr3GRqZsWC+VG/a
 Fba4EpmW89SFU6qVI8yPfnohAUMJOxu0WcljAnikWHHWaYUzUePCw8+vbkXplstFjIcRsucCnCz
 11KkchZLwCAhW0THJgdLN8qUcP5BXx6STFmaQJ3hCx1B8Gmt2Y2AcypcDzo4R72UWp0DlD3HWD5
 TNVb5/+c8v8AiXCWlag2GC1QLdq17RwfJjsmSQV/Uy+SkFxT8zknEdMVlRlcX/12nss/qHP/Io0
 BBrzH4xVYDxiBFc6h601cEHxeeVRw/uppICmvg5oorrNMslcPpFYMemBUuAnfMFEZSFij0vopOa
 W55friMKQnoW1
X-Google-Smtp-Source: AGHT+IEfiFzGSLHD01azY+JHCmIUvtpltMzuglMAnlAU0yRCQgUaYY5dn1ISvQgUx6O/aTrZDe8rjA==
X-Received: by 2002:a05:6000:18ad:b0:3a4:f7db:6ff7 with SMTP id
 ffacd0b85a97d-3a4fe3a7c8bmr8244935f8f.52.1748938212873; 
 Tue, 03 Jun 2025 01:10:12 -0700 (PDT)
Received: from stoup.lan (host-80-41-64-133.as13285.net. [80.41.64.133])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f009ff7asm17668852f8f.90.2025.06.03.01.10.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 01:10:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v2 08/27] tcg/optimize: Build and use z_bits and o_bits in
 fold_nor
Date: Tue,  3 Jun 2025 09:08:49 +0100
Message-ID: <20250603080908.559594-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603080908.559594-1-richard.henderson@linaro.org>
References: <20250603080908.559594-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x329.google.com
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
 tcg/optimize.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 758f7b142e..29d1f29124 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2231,16 +2231,22 @@ static bool fold_neg(OptContext *ctx, TCGOp *op)
 
 static bool fold_nor(OptContext *ctx, TCGOp *op)
 {
-    uint64_t s_mask;
+    uint64_t z_mask, o_mask, s_mask;
+    TempOptInfo *t1, *t2;
 
     if (fold_const2_commutative(ctx, op) ||
         fold_xi_to_not(ctx, op, 0)) {
         return true;
     }
 
-    s_mask = arg_info(op->args[1])->s_mask
-           & arg_info(op->args[2])->s_mask;
-    return fold_masks_s(ctx, op, s_mask);
+    t1 = arg_info(op->args[1]);
+    t2 = arg_info(op->args[2]);
+
+    z_mask = ~(t1->o_mask | t2->o_mask);
+    o_mask = ~(t1->z_mask | t2->z_mask);
+    s_mask = t1->s_mask & t2->s_mask;
+
+    return fold_masks_zos(ctx, op, z_mask, o_mask, s_mask);
 }
 
 static bool fold_not(OptContext *ctx, TCGOp *op)
-- 
2.43.0


