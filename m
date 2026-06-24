Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38BC0CDE002
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 13:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcNns-0001mJ-8A; Wed, 24 Jun 2026 09:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wcNnS-0001cy-HT
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 09:37:44 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wcNnQ-000161-Vx
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 09:37:42 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-46caaa805b2so338300f8f.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 06:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782308259; x=1782913059; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KKSPSnAl7FDN6Zt0DqKlBArO4lCMgimmNAk89edFtyE=;
 b=Q5VWBu5CuR8JHUu4GqcoUsZj1zRU0EYPHEidA1qqU970o5mr5q2EQaDd0TdR7mrW7C
 5kCp3+q4bmSy+iwPintqKEQRkJsz7G9a86dWNE8FiJ9UZ9cIT5/Jr8N+eJmwUMgX6M+I
 7O6or87iNI/TuTzdbnW7hcgFBAnW39jOquWSc53GmVj8figv8BBk8lYjNDrwMmlZkrBF
 iqIFt7XGbLj5fSgD0HwyscDD58keLPSpbHo5UyFBsGmeJvvBSqm93hEBx4afIu7dhsn+
 mSaXivi2n5kevKO2EFzEEL8TVSd6Rcb7l8wCUnvQXv8ZLFo5dEYyTwrydYFhyi0ptVM3
 jmmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782308259; x=1782913059;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KKSPSnAl7FDN6Zt0DqKlBArO4lCMgimmNAk89edFtyE=;
 b=ZF2SrRKjrzs5TswvRZstvaa49N8UuQ5HW15pAqRjtiUN4UqfxJPC06vY7vyNiTnc/2
 yXrmfiRrMAQS789O55pHipw6qpJ0HBh/D+v0zXXZLnlcyed2ITuCPKiUD8AF8B+SkZ9M
 uDdzLlOXF47lnJh2i7shZPYm0Ej7kYxnJs2KenX7ZHGRL7CHErAd+rbTqC9F3rZpQGsQ
 OOpXTro8yWHuN8ERNLnJYHeHzQMxq52LpI2ls05FVXtXRInNAcd8xFJsZt2r8fPuiIQb
 b8o/px+Ump4N3RC01NaJ2iQWYfcFNqRgx2oe+yrI1uRG0cSliYUSHFA0eQAMGKBvCNyX
 cY+A==
X-Gm-Message-State: AOJu0YzfYWBg4CPL4DRXoDIa2grQ6cLIn2DkTONbKgpczOFzAjTllMQn
 FVxwjNZj2lVHLdQ7x6KJhWqC04eGK5q5d2LNdQsUlGLU7v0kema/ZciXWAc9nFfpzoTf0jWY83B
 5EgX7xmg=
X-Gm-Gg: AfdE7ckIAnlU5E/dBsSY+3Q03/zbqRXOJUptdGjLEyXpUVP9WturwVqvgkGWMeiTkYA
 R2x4zYvpcmHqJns7amU7WBANV1Bk9KSYgl73jUzjGBjPzv3lKpCoqKYbLNs5uIrU5UNhKAxaoPd
 /NizwH64Btmw320Ws2ZsecH0e+uwJv4+di/Qgpn6niLfxweouTMEPzq3yIp5p9wzPfjeoFGpxrW
 OXGag0cZ741TUwDEIoeX2V/UxNyoXJ6UExfO+0iJfGhkRaGCoPPUESg7jfBYZOtGWCHd7NonLY1
 FYku0jx7SWqykzSJ/8QnDDmx3OJkk3j3jO+/4m/HnqRl8fiRoalPJ1DlwHoeTR9lBaszxXEYl/c
 CFJVPb9iSYrYh7hVvjms/uh5pTwpjJ1cwsvbwryaXz0a3qZRBxlvh57+1BOUVOEzMTWL+48B7xY
 L4BvdKTyNinMXVH0g=
X-Received: by 2002:a05:6000:400e:b0:468:6ce0:ef1a with SMTP id
 ffacd0b85a97d-46c0a3936e3mr6136409f8f.11.1782308259573; 
 Wed, 24 Jun 2026 06:37:39 -0700 (PDT)
Received: from [127.0.1.1] ([2a10:d582:31e:0:2e21:1ee8:260f:9a76])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c1e840efdsm6646334f8f.5.2026.06.24.06.37.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 06:37:38 -0700 (PDT)
From: Jim MacArthur <jim.macarthur@linaro.org>
Date: Wed, 24 Jun 2026 14:37:27 +0100
Subject: [PATCH v2 3/6] target/arm/tcg/cpu64.c: Add FEAT_FPRCVT to cpu_max
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260624-jmac-fprcvt-v2-3-dc6cf8e512b6@linaro.org>
References: <20260624-jmac-fprcvt-v2-0-dc6cf8e512b6@linaro.org>
In-Reply-To: <20260624-jmac-fprcvt-v2-0-dc6cf8e512b6@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Alex Bennee <alex.bennee@linaro.org>, 
 Jim MacArthur <jim.macarthur@linaro.org>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wr1-x42c.google.com
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

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 target/arm/tcg/cpu64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index f7a920a202..f259e82dd3 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1269,6 +1269,7 @@ void aarch64_max_tcg_initfn(Object *obj)
 
     t = GET_IDREG(isar, ID_AA64ISAR3);
     t = FIELD_DP64(t, ID_AA64ISAR3, FAMINMAX, 1); /* FEAT_FAMINMAX */
+    t = FIELD_DP64(t, ID_AA64ISAR3, FPRCVT, 1);   /* FEAT_FPRCVT */
     SET_IDREG(isar, ID_AA64ISAR3, t);
 
     t = GET_IDREG(isar, ID_AA64PFR0);

-- 
2.43.0


