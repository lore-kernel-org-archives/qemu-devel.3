Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 903A8CD3427
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 20:43:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMAwh-00052X-8n; Sun, 10 May 2026 16:40:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMAwf-00051k-53
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:40:13 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMAwd-0003yN-OW
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:40:12 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-479d9b155deso1272102b6e.3
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778445610; x=1779050410; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2j5j3CKwrC1uq2XYExCREmc3wheKAhETnxpkRXYUz2I=;
 b=dCOtmUrXYAlSdxeSxcEuH0nYO+Qea+wIF9cwlSfnUtJ7f1qu4FpRD9dVspEvlZkGWA
 BdwKDvwGmMbe7xg4Vo8jwe5uKnvOASsnGx2K1InIXA+4dUVagVXRXsMHNq7j+9Mqm7qN
 vCPGL923vM3Mkv7U6sUxaA3ZcREYKkC4sl+z1f1WDqbKUQ3eQt7nrEQRv/IY6n8erXjx
 LamwyI+QGywvjf3+U6QetRPg0TZ4M+lF3wzLOlF/juIm9RYTHP2Q+gAoGd78QuzR6DoI
 LWi2sZiK6ONtD85ODOQe64gb1h/UTbHrW+YSUciGNz6A6+h2ipZgOGOgjh3OLMgpFHyT
 09wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778445610; x=1779050410;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2j5j3CKwrC1uq2XYExCREmc3wheKAhETnxpkRXYUz2I=;
 b=f22otqmdH0YpzI9KWH9Mg7TkVCUMHCXZVk75eFIIe2oWrF2tTJKtuk4ckLub1+iTjt
 lA4qSfZFb9ZRLXRRQbvfUbtL+MqDsYBr7BOGJ42TuO62XuY8wp5V4hPQ6+hJmcK44FGy
 ykRvvScPh1SGfgUNdHbtqT2Zv0GNgqkFQ4si8jFibyV3b2Z6BOsiNV4MVkwqXNke2tWa
 ttSLmH1ekWeBq97zbBWnPSN7IKffKEImTBM5vb842mFTsHx6LwmzMkxBqJfHJm1RAi2O
 jgAtav45+4XucjCdD3a0DUvBfwLA93ioo6Tt/BB6GzWnSVwHdutgW+MF/FNFCygAQVFp
 PvJA==
X-Gm-Message-State: AOJu0YzyvhwDUf8kBeeG5MfdrNTumtsXxWsFOedkz1jg8N6sl+NGzTyU
 q5aPzW4k1DzQuItxe48m7wI3IC34TmlTJGVsMtFVHhQWafPbB6te2nQg
X-Gm-Gg: Acq92OEAKAVXS3DxDkGK5VMu7MyPGpwTEx0ByPrshiYpBZ7WXnDEC5jBAq6oOltq5l6
 gA0qgRjdNNVZ0o95nS9dOoSzOLsTr3KRfBdXBcikGwI6hsSlgX+mfXItoiMlzBhDcektge4R3PH
 4PkNFNzBhu+VYlQTSU4ycSUDiFFKBDfBTCDp73mWHOijm9YdmCNpWYb897yUaE7zZ6Cyp6ZYHQb
 qCTW8oZ+73WeJzivaUR+C46yKtKBKTNouzx8o2G1I0T070WtpUI7hnvW+1NKLSZTjjoQQ9VkEg/
 F0Gn3v2v1z5/8P3PwGMflwg6I5JAVA9CV2BO0bqyXXGwCbJHq0EjjPIIiPOiNIy26EGBJDb1wO1
 PDkChvSIMAr8NOIRWKQ3Q49R9S4J7+mWl/Q+XZ2AdGEJ3LWvPy45bEI5euaNu1l//+uTb1w3Mdy
 yeFMkP23b+vF1peYNDbXzwKyDt3XNW+jT7ZMTOjK4kvQ8Si9YDC9R4QuwxBMMAVgKPA2rALGbSk
 Cse9wUyAC4i0HFqw04y+JwFfpoPXSTKkhBNwNwevKcwpuIwbpNO1g==
X-Received: by 2002:a05:6808:1a02:b0:467:16e4:d276 with SMTP id
 5614622812f47-480420d67c3mr12236655b6e.3.1778445610278; 
 Sun, 10 May 2026 13:40:10 -0700 (PDT)
Received: from MacBook-Pro.local ([209.245.15.183])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c76935637sm18908207b6e.12.2026.05.10.13.40.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2026 13:40:09 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 10 May 2026 14:39:38 -0600
Subject: [PATCH v5 08/32] target/mips: add Octeon LBX instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-mips-octeon-missing-insns-v2-v5-8-d5d2668d15ab@gmail.com>
References: <20260510-mips-octeon-missing-insns-v2-v5-0-d5d2668d15ab@gmail.com>
In-Reply-To: <20260510-mips-octeon-missing-insns-v2-v5-0-d5d2668d15ab@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x22b.google.com
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

LBX performs an indexed signed byte load from base + index and writes the
sign-extended result to rd.

Wire the existing indexed-load helper to MO_SB so Octeon user-mode
binaries can use the signed byte variant alongside the existing LBUX
path.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split LBX out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)
---
 target/mips/tcg/octeon.decode      | 1 +
 target/mips/tcg/octeon_translate.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index a2bfd0751d..efb1a48b38 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -49,4 +49,5 @@ SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
 LWX          011111 ..... ..... ..... 00000 001010 @lx
 LHX          011111 ..... ..... ..... 00100 001010 @lx
 LBUX         011111 ..... ..... ..... 00110 001010 @lx
+LBX          011111 ..... ..... ..... 10110 001010 @lx
 LDX          011111 ..... ..... ..... 01000 001010 @lx
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 1893bf359f..ecdce6ab9b 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -161,6 +161,7 @@ static bool trans_lx(DisasContext *ctx, arg_lx *a, MemOp mop)
     return true;
 }
 
+TRANS(LBX,  trans_lx, MO_SB);
 TRANS(LBUX, trans_lx, MO_UB);
 TRANS(LHX,  trans_lx, MO_SW);
 TRANS(LWX,  trans_lx, MO_SL);

-- 
2.54.0


