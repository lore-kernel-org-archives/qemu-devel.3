Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B77CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 16:06:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL1ER-0004aL-UB; Thu, 07 May 2026 12:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1EP-0004YT-38
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:05:45 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1EJ-0006s9-Ky
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:05:44 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7dcdaf06498so777696a34.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 09:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169938; x=1778774738; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e3qnQOdZ0UPdC22hHI8i/828Xzt2oEbdua+qwD0EsnY=;
 b=YwY3aXLWgcKaVgbbdkNhAzJgLBQW4gRvfRBg5I19lNabZJ9/yjIwOxNTj4fN82b9R8
 7B30/gBbzB7mFourQth2qhWL+P/5X2RsD64q+UdfD1L+Azj5eJo7Aj5tFdRvM7wzZgg6
 UHTjNSInEfIOCpxigMaujlQAuL2yyn9hs3LHngKZO0ONm0Xs8cBF1QrmYmjJy+FK0ndG
 +7z1j/Jj5lvvRD5ddbeoqU1SFtwUEmA4zOwbU4ASkHTfs67hx4hmQFlKVly+j2CsxQyY
 Lniw+o55tDIBNhepoihtNQ3c3o083tvzcjbHiHQxhBkELFYyzShSYPp4z4QL2bPSoxn1
 JSFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169938; x=1778774738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e3qnQOdZ0UPdC22hHI8i/828Xzt2oEbdua+qwD0EsnY=;
 b=cI9MDhDmgy+Gyf3H0tn5LoYJr8QtGmPcJeREzzKuT8E1ufFjbWyEMPIt4q5yi2b0j7
 W59xU9IsTJ83y0sutSO1PE/4gjNhGsvW6leDfprR1ZbjnlizOjXbo+obsE9Vdmf9imR6
 EsaKoP5a/ZpzIBKO1iWK9xjx32O1V5ueZykxZfbDsDvFDYepsbTF/SoeG+Y18zk7C2mO
 y7xA0scBy8tx5mb+1ofzCVZVRNs+q1p8FICLGKLhjHRG0iGu40A5mUDiyDoQO3ydCbP4
 qoSAE3RG5W7rDnQGEqHF/U+FwqrS88p1SXOZXliY/0GW1wxKvZsGX/gAyLTBPczsbbLe
 g9qQ==
X-Gm-Message-State: AOJu0YwDw1KAXQCPCK+46BUyuPicky/QJi75l1lwMcMklWPTdqUNl9c7
 Zf1DkzmyZrBq1N4qTgAnxTCeeDiO17PUoofj9/K5yrrUxdAM0V4b4M+xyXz6vYajTObL3JUStEC
 9GYU/
X-Gm-Gg: AeBDieuaJ0i1RTKow06eq2WLriZrZN1FxskeWIS3yZiJGI1ZF1gHRh/JGbRYsbPegFi
 E2UwLy7bFn4j1YUqe1je5qEZqao5vjMLCTaM7VWa9qLVnaMoWigAtqKOyvcjGFBSSLrIG/xximy
 j3JfPjACSNNoUyQ6xmzy7V7qa689/5CJBV/rjDjTHo8ZV91khr0p5JVL4LeLrz0ET1U9wp2uu44
 gM3lls/5Gqy2/UFvp8NeURh8OecTOvh5wkKGxjxrfz0DEgpfTXwWzrppYrG5slZRv4HNvPcRKPN
 HR/0MaHlcY62lw2nH2l1Os1XbC/KI8C9v2Ca/q7KXUctVpj3tSQ2uQT5nAggGrCVI8tCt7Qejo4
 IZzrlU1gILi8h7pB00wIpKqnM3MoSDLkfWcm5zJIkGGrCDxiVY7TNz1plicRuxRmBFQoczaaM9G
 U+lRPLShbnnsRjKU2eLIcCmG8zUbPgWhAshLDuLWGmYNPV1dPMxPfx4Gwt
X-Received: by 2002:a05:6830:3785:b0:7de:a330:ecb8 with SMTP id
 46e09a7af769-7e1defe86f3mr5129448a34.16.1778169938335; 
 Thu, 07 May 2026 09:05:38 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7decae680bdsm14647398a34.27.2026.05.07.09.05.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 09:05:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 15/29] fpu: Sink exp_bias adjustment in float64r32_pack_raw
Date: Thu,  7 May 2026 11:05:03 -0500
Message-ID: <20260507160518.444797-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507160518.444797-1-richard.henderson@linaro.org>
References: <20260507160518.444797-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32f.google.com
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

Share the float32->float64 bias adjustment from both
the normal and denormal paths.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 7d67e25c17..b7d461bca4 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1412,14 +1412,12 @@ static float64 float64r32_pack_raw(FloatParts64 *p)
              * in normalized form for float64.  Adjust, per canonicalize.
              */
             int shift = frac64_normalize(p);
-            p->exp = (float32_params.frac_shift -
-                      float32_params.exp_bias - shift + 1 +
-                      float64_params.exp_bias);
             frac64_shr(p, float64_params.frac_shift);
+            p->exp = float32_params.frac_shift - shift + 1;
         } else {
             frac64_shl(p, float32_params.frac_shift - float64_params.frac_shift);
-            p->exp += float64_params.exp_bias - float32_params.exp_bias;
         }
+        p->exp += float64_params.exp_bias - float32_params.exp_bias;
         break;
     case float_class_snan:
     case float_class_qnan:
-- 
2.43.0


