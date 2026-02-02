Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2338E7FDF2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 22:27:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn2LR-0007zg-CK; Mon, 02 Feb 2026 17:24:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn2LP-0007yR-Lt
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 17:24:32 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn2LN-0005el-Ne
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 17:24:31 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4807068eacbso41600175e9.2
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 14:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770071068; x=1770675868; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uEwHj7cGBF710j93AX4dVUieGQt51AslYFDhNUlx8/I=;
 b=Ir+jlfXc+l5LHY8BOVhZmhYqlSPCtj71Z36DGRnDu8h0+M2Vr8RxdeogV/Z8OQs38r
 rRXwrupBzGI9nI2hdCJEzWALdFbPZajmJiG6hL0pRIbo5d+lE5iqmRORLThMPmLT1Dds
 vzAlO+PAGOii+bYhoTk6hldDl8JPPgVKlIb68eFX16KuPzyVXYTzoxJXqBdJc1ygmf1b
 1g4VpF1ykGtB1ldWaPdqG6S6B5L0xYeqEBgnRcWmYP4oDwCno5O6I6LZk9dUwtb6oYip
 HKSl3BAju6ujqtoggATYZ+qdO6X3ehjzLOnioWP/ILsYnT3zq2UP7bM/Lat4ujBG/vHE
 yB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770071068; x=1770675868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uEwHj7cGBF710j93AX4dVUieGQt51AslYFDhNUlx8/I=;
 b=Vw9NKO5OR65VmsXKj/S2C/D4m7oPMz9HkdBZzYQWo852OMFkll/QL4kYCkJfmgMKya
 Uw112LQvPPj6AWRPeyYjnV9OQSRdTSSCxAFVISHBJmI8mlYlXl5P5nsCP7t4BphOU5Ro
 0psDcnuTBmdSr0utISIyeMCJFVwUaMvArZZDoo1ZcqQ87t/G6sF78cMjtExLDLPSfbMr
 S7lE45oQvqUu+oDSvK0hj/Mi74QHfO7B8zsGd1e+/kFPsvr8R6aBvisFTOttcyRCX64T
 dL+btJ9OPtyluyKmn1yWz5Kpx4fXLW8KCNQrhLdT4m1x/bi/pxuAJWZneXjnNtBj2UVo
 PqTA==
X-Gm-Message-State: AOJu0YztBppVuHq5pgHtMfDjmzzsuWHkqBB2FDqn4QUBV7NUWd8CuSZO
 K660wM06w8dGqpxTu2Xsu0+GuNyLuq8h+8sDY9I5QbU2Xt3zIsC4HRG5bUMMSrrxV6seaZx+6iT
 MgLYHbrw=
X-Gm-Gg: AZuq6aLqt/E4pcrsuThQ2/EJU4t05PhtC2ba4dMXGVR1q3QzA3I0MHUZlkRMZJNYTXY
 TMT3e8fCGmwt0+ooXBVhHNoQH+lBMhhFTOuEYRBSxK8MVIDDEtHDKsTe4pWpi4INSWDXnq9OVXY
 30LXLCvj/Cct8Uec/a2eFuPMuC53rrW3C6EQZ+IvygZxP5rEj+pCvXwvK89RiZIhyxmQMljYK7F
 awPVy8VZUkVXOmgRb2WPVBTgCQMrsBPzrGsRGvqeYO5NG7nccUhsqa+9N+tdbydVP2zkLABFct8
 VIyHhm1jRN2vFMuCn2ZJ7bQxtg6zHnEVlb1WVIrQhjugcFfPhGcZZpL5pHlT5NSTEqWyxdLWRaO
 L2rRmmHvQbjJ8v0VQvvTeis3765y3HUMdBRW8wK9Rqoac7A9z24UWpONG9VawBzjtYEkeMFZh9N
 53zZnLHmNLVhL0RLVQpo0Fw0nPdLe9KjHca9v90BoVhCEgVGlEP0MLrmq9OFUy
X-Received: by 2002:a05:600c:8b65:b0:47e:e61d:b8d2 with SMTP id
 5b1f17b1804b1-482db486ee9mr189007215e9.27.1770071067947; 
 Mon, 02 Feb 2026 14:24:27 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483051539ddsm17525815e9.9.2026.02.02.14.24.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Feb 2026 14:24:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 2/7] target/arm: Have cpu_isar_feature() use a const ARMCPU
 object
Date: Mon,  2 Feb 2026 23:24:07 +0100
Message-ID: <20260202222412.24923-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202222412.24923-1-philmd@linaro.org>
References: <20260202222412.24923-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The @cpu_ variable is only accessed read-only, make it const.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpu-features.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index a7ca410dcb4..f7b14373407 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1643,6 +1643,6 @@ static inline uint64_t make_ccsidr(CCSIDRFormat format, unsigned assoc,
  * Forward to the above feature tests given an ARMCPU pointer.
  */
 #define cpu_isar_feature(name, cpu) \
-    ({ ARMCPU *cpu_ = (cpu); isar_feature_##name(&cpu_->isar); })
+    ({ const ARMCPU *cpu_ = (cpu); isar_feature_##name(&cpu_->isar); })
 
 #endif
-- 
2.52.0


