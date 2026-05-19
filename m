Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA6F5CD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 16:25:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPNDf-0006gm-BU; Tue, 19 May 2026 12:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDX-0006d1-12
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:22:52 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDS-0000eI-R0
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:22:49 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-40946982a78so1162683fac.2
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 09:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779207762; x=1779812562; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RGGA0O2hVedaSvcxfeu4Aj34rW6xAzUt7vUilCpMyqI=;
 b=lJNO1aWLQiOm4Kac9oz8pUhGD76BjIyiw3bUYwBWRxVX/5EY9Zpfi8qVle2i4ekdGx
 oy0iZY8SXVOl8AZX1q6RaumYL8EhQPLMkV9i/HjsUFHUt3ywR7HeIwCr/ldCkm2OojjB
 rNCAtlroYYHN+nsZhPNPYbiwtZwAnSVIN7+1WWCnaAUR8z5f/fvjBcuWbZOivC3AKyGK
 dHumtuxcOwcUXJohPd/Ge3EkKE99qU7B6SFnArhxnlyWU7cEu7C2JPyD8dufncxlY6gx
 7A5wkqY4uhQF61nRqt9I1yyXJHYLTdPQvx0wgMLqdFM5l9xy3RzeWc3X+a3m2tHkr6u9
 kvCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779207762; x=1779812562;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RGGA0O2hVedaSvcxfeu4Aj34rW6xAzUt7vUilCpMyqI=;
 b=sum2hL6NT1oE2HXI/WbH5g2ItDXvsFfCVgrzLcHcpFpWmFsJsnW2jdqD1HyTe7jmJl
 6hezz4XZTkRtkXTg1YW8/335antrxRZF0fOQYmvUetYLbMF06qdUy1tYxLdZGwl+Qzcu
 nmXXm107Eml1qpaVjZtiwJZLzjCWLHJkVj57W9afZQsmcZzbaBfhQeEmkvQ3lPgxoty9
 TuyVHzZKHuBStIssntPw3g1jwh+S+7WdhJL58OKhBlCD4OSQ2fKHgjEI7p4NXl3E63C7
 Mxeri7tkoUzzZ1I1rDM7+PCoj7VRHFlbpASgbVaTZRwysjL2XBQz9Si8pnVV/Woqx4+g
 8vGw==
X-Gm-Message-State: AOJu0YzUj7HPuXt0ess4dR4Liroz56nKakaKstHT538S6oUfzavMWbNr
 T9MmTnjEbXcLowp+xJ/Mik8Pe9Th9J9J7NmnnsMjw4fCO8J6mE5xgr+o
X-Gm-Gg: Acq92OH0j6AQWABxYdPFypL0CKc5A3Se+ho/VxKR3dmvS1i48YDQkjGjH70ZzPWMWhi
 YX4bVam646D4lJ3eK74kKJnG6eqKuv4wVZ8eaUUf50nd6TrM6zWM5ltEhKA9ZQ4ETCmC9R1ZTqa
 AHOCsLY0yV3w/fHVqTnUk2lDGCH7y6x+dDWJDMlgg58oO7fXtIV13+9z8O/WfP4BpdLY01jda98
 Fp9jBBguz7nihR85vq84c5BNCcuuSBNcWQRzkMk4DLdPi043gDHS9qVIPiZHHEDHc69/IgKUVSC
 kXV/CMi8y1H33bJlb8GOAegRjSP/n4MHLVVlyg+zCKV8OEEHDT57eAxyyyDcKeGdlFRgDKEmfMa
 2YAv6IBEKcAVCGPaxhvqjksqhHw1Ilw8D0gPt3GstrPiRBQ7oK8w9afcl/XkhI40jC3l8nt/xNk
 8HeAhiCH6WexLgz1gVssXnybQomakN8bj0x5ttfM5M0fWUzZcYXGcSAdtFpE/SFb1BPPWAIDIxn
 KVpC2+L2GmfRYEW98Q7mRffi7oRgxYslB+Ws46sSdcuUwpkdGJYNGqVuIePxmVKhVim
X-Received: by 2002:a05:6870:3d9b:b0:439:fced:ed2 with SMTP id
 586e51a60fabf-43a2d96277dmr12641384fac.4.1779207762059; 
 Tue, 19 May 2026 09:22:42 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43a95762ceasm7056296fac.13.2026.05.19.09.22.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 09:22:41 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 10:22:09 -0600
Subject: [PATCH v9 07/40] target/mips: add Octeon LBX instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v9-7-d7dd735ecddd@gmail.com>
References: <20260519-mips-octeon-missing-insns-v2-v9-0-d7dd735ecddd@gmail.com>
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v9-0-d7dd735ecddd@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oa1-x33.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
index 5497ddfb10..451737cda1 100644
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


