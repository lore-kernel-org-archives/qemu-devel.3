Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21510F8E499
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 03:58:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDaLK-0000E0-9l; Thu, 16 Apr 2026 23:58:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDaLI-0000DT-Qd
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 23:58:08 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDaLH-0001Fy-F9
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 23:58:08 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-488b8bc6bc9so1137385e9.3
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 20:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776398285; x=1777003085; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KYn7MiYiIimHUCCwf9g8QaU0c9vwpWnSWkhJsSMHx20=;
 b=rJ1/gILGLn+h6MFLok7Yx+dO0D5EVsViemqhRsLbk3w/OV/uWQhWlCfpNFTvtm8K/b
 zlKgsKMVjwXnGuWcBqvEzIDMw5EI0VWB9zCIObFZ7J1oJcYqf76dLP3uZ9IWEjcuCtvk
 olIfOFWAdEaCgjXiTqxTHLcoxNUVSa6GYo96+8isxz615w4mOx2t7QQnz2ZChAcZ4EcK
 FjKpLt8RijzPMM95u0oL4dyojVRKyU9LAnL0yUPpTFSPR2WtvHrebrGuT4MRVmxqa8cr
 ZWnnLSPDoTW50o1VZmguVNfUTbO/0edmXwSd28J74qkJmiM70GfQaJsmF4gre2+WYuko
 Bjwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776398285; x=1777003085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KYn7MiYiIimHUCCwf9g8QaU0c9vwpWnSWkhJsSMHx20=;
 b=Jff0eXxM5h/HtJdz4g582Rw72XXY8sbn8UUVYnoWx8gYe0opBoO47uOySfIA31r/dV
 iAVQOOXn3m1+4lntmjxIwqVWwL5BkDfRyZ254bMgCCGxDKpV4Fe4zVPxZEIav7pKoJ1E
 2GqneABBh70vAvo2UpqpArc1U+MbfElsa71r1RPFh5kIgIx/bewkwLTfqYJOLPTUWPCr
 j3C4HamZHAJEGap7bSrvLjjKBn6BHE5uaYzyTlKOTmI9qjWQ//r3XXiFZ8OmB+GJWKNc
 MbGwGxVQz0R7sMVoaNQRNgYxz3tm93OuQ9+Jjjew8VpzsSangGAxnoQVBUk774kDDz7c
 yJ+A==
X-Gm-Message-State: AOJu0YwJvKLoNAlcCoajC2a8w2FLA21N6DOAUervSjX5U6k/Dc+Ucb1m
 J7nQBLhqhzeFilUSSHEG0n8zjmPxWNCsR+to+VcvqHKI6RBl2eSPpxBHIHxVNn6bjVkvX+5g1Q3
 LRlgWQQI=
X-Gm-Gg: AeBDieu8jyCS2yVu3w+ywZW1aYVexkeihdtV6ZRElft4BZTB9UeTpJM8NlDIqdeFNiI
 rcim1Mdogg50JThEPHcyhwv/QD81Jv5LEb9/AjMmoogABSTJzLDgNL7OOCYKAIBPaU79+AVy55X
 dO5fnjAqulW5+gV99dj1nHz2xGDv/CdRIJ8icHiQN1YIEP2hiabNqss2JotIU7OlhLaM+2o4s/b
 EZV01D1cC4jBW+e1GxGvYjcUbAXaGMsCqWobDq0lLap9Gsdcrw/QN7e+TEgN0GYWsR+Y5C36FVy
 87k597iCtea+DPtuZvUuUIUo9QPvy/7Ke0IxVNuvA1vi2zd0ljoifS2d8xCN8SpzhddIOdV49E1
 1Eb4Cm94szYF/B0yN2xonvXs3Ta556YpH0CJ9Zw1f/Yi1bL6CbGCF+nWsdsTCAZEWS9uPpj0Aao
 VUa96D7VAjACJGNke6m1CrONGYbSLwLP5p/imI252Fw79LCNX+2xwVTBpaJBQmjX5V8s4RDZoXb
 X5Upk0342Q=
X-Received: by 2002:a05:600c:8183:b0:486:fd5c:2b35 with SMTP id
 5b1f17b1804b1-488fb750809mr13146045e9.13.1776398285585; 
 Thu, 16 Apr 2026 20:58:05 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc0f8188sm10761015e9.2.2026.04.16.20.58.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Apr 2026 20:58:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v5 4/4] target/mips: Check alignment for microMIPS pre-R6
 LD/ST multiple
Date: Fri, 17 Apr 2026 05:57:34 +0200
Message-ID: <20260417035734.32334-5-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417035734.32334-1-philmd@linaro.org>
References: <20260417035734.32334-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Pre-REL6 microMIPS requires alignment while REL6 microMIPS does not.
Use @default_tcg_memop_mask in gen_ldst_multiple(), it is set to
MO_UNALN for REL6 but MO_ALIGN for pre-REL6.

Fixes: 3c824109da0 ("target-mips: microMIPS ASE support")
Reported-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Good enough until making it explicit in a decodetree conversion.
---
 target/mips/tcg/micromips_translate.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/mips/tcg/micromips_translate.c.inc b/target/mips/tcg/micromips_translate.c.inc
index fb107eb91fe..da2419792eb 100644
--- a/target/mips/tcg/micromips_translate.c.inc
+++ b/target/mips/tcg/micromips_translate.c.inc
@@ -693,7 +693,7 @@ static void gen_ldst_multiple(DisasContext *ctx, uint32_t opc, int reglist,
                               int base, int16_t offset)
 {
     TCGv t0, t1;
-    MemOp mop = MO_UNALN;
+    MemOp mop = ctx->default_tcg_memop_mask;
     MemOpIdx oi;
 
     if (ctx->hflags & MIPS_HFLAG_BMASK) {
-- 
2.53.0


