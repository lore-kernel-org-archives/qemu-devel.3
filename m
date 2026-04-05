Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B96E64013
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2026 12:47:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9MsY-0007G0-W2; Sun, 05 Apr 2026 08:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w9LaX-0007cX-Sr
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 07:24:21 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w9LaV-0007Ne-Ha
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 07:24:21 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-66a33f61d80so5720742a12.0
 for <qemu-devel@nongnu.org>; Sun, 05 Apr 2026 04:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775388258; x=1775993058; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1v7R1AtFco+NkGTWs9tgqAhidfQ0/xG2e+uidBNqPEI=;
 b=tgcu1MsxMunqG9VImot8u8ZZIqTRh2ggU5d3q+Slek0ji9lIMwGHhdgDXLTTYw5nW/
 fCGSuSlisGRZfOA1aaYoeM+tmllLT5OvskjxF0mQGNfCoudYj+YmruAVUR3iB37SMlGI
 yPJ9w7xq2GoaPjxHXGfRO90aYzs0Q526n+ZQ/u9uHgkhtXIuFnCMlMV4TRFniI0ehd9L
 IuzD5rtu3vLwSYoVjWXssc3nUHgz6EOW5sltvHRi6DuTR69UeVH9MNOeBkyQMZWkU2zf
 TpouJNuefsvkUTAN7P7aDuvXc6LjY57IQRxHkqtYJ+LEcxKQTZobzTe53CMd4xx+aSX3
 5Ufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775388258; x=1775993058;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1v7R1AtFco+NkGTWs9tgqAhidfQ0/xG2e+uidBNqPEI=;
 b=nyIG13w0TakXvL1dMmEd7LZBl7Cr4b/PwdCKxhpnzFeLyIoNySeK8bx0AqP8UnohCW
 0GoXJyMIOANral5fmqNJ53Y8ZrWOO3HL6u7kSq20stLUSR8/XYFoOTzq3GsW47qM12OH
 PDchzD9GuYlyhi6PbfhGY4ysWlZ4X/xibx/k1Z13Bjy10ymbSMpsw0XxznLkf/hkjX3s
 5KgjeHWp9lXjFBBsXjvsG3Qxpzz+ZBxHeNSdL0qNvSiCS5E0MnwwrL1C1ULGgHqxseqY
 qyL4iWFOOSkLq07q+IXOwz9xtv7RFigfOR38T22u9WwRm6mgYcVp2lO7Tuj2xv3J3lXl
 kQvg==
X-Gm-Message-State: AOJu0YzNbGaDyrCEFAHUu3d2dDFJc4nfo4GGmK+US8Crl25C2Mt1jsyw
 UgM1jjCn1yXPBUex4ZdWN8XeOeBSriNEkWtknuow1wAZIExQi6KHZEJoYfIY56xFescfK1qlM/W
 u3ZuD15A=
X-Gm-Gg: AeBDiesgjttZP3Vy0nDyN4v4Zoe/DlGb/hC5XliyqBpsVVWy7ga77my1E9MCg/5DZAY
 Y4sq5fmrMcJmBmozkr9VXjKv3rkW2av0UrZgxbOSxTZNj47bUTwCuQ9vAJOZypGfcGSUOoT6uAL
 oSepLU2QsRp2byswN3iLH5QdJ+TEw8Us9wy2wKaBmbmByTNGv20NaRD1g7n5kOIHmsPuopLkwFv
 jhNa+jVudpHsSYMFShMygykQ49VRPTPPtV+rpYMtnK9oKVlcR72mR5dmDSX7ww2mc50Nx3tNk+M
 kJLodIsPEly/r8o7bGUt57Js5sYQwEcZdQlmIpYNnR88a30sgNCO4JLblH/sORxj/sNmC+gAfHY
 a/u/R0BksYGes5Nfniuz+9m55R7PaHz3uTBM1AzsM0EQibirwDgXV8IvK9z/qAFfgGXupDslvMg
 w6cH9RD2NRS6TtDtQfrYqgTCc=
X-Received: by 2002:a05:6402:5256:b0:66b:aa56:ee5b with SMTP id
 4fb4d7f45d1cf-66e3f85414amr4403852a12.28.1775388257695; 
 Sun, 05 Apr 2026 04:24:17 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-66e034c63ebsm2884164a12.26.2026.04.05.04.24.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Apr 2026 04:24:16 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 370175F79F;
 Sun, 05 Apr 2026 12:24:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PATCH v2] target/arm: fix fault_s1ns for stage 2 faults
Date: Sun,  5 Apr 2026 12:24:10 +0100
Message-ID: <20260405112410.603223-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
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

The computation of s1ns was simply wrong. For Stage 2 faults, it
should indicate whether the faulting IPA is in the Non-Secure IPA
space. Correct the logic to check for ARMSS_NonSecure and drop the
extraneous s2_mmu_idx test. The actual writing of HPFAR_EL2.NS is
already gated by arm_is_secure_below_el3(env).

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2568
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

---
v2
  - simplified commit message
  - added r-b
---
 target/arm/ptw.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index d5b2ed6c99c..57a413b468e 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -631,12 +631,11 @@ static ARMSecuritySpace S2_security_space(ARMSecuritySpace s1_space,
 static bool fault_s1ns(ARMSecuritySpace space, ARMMMUIdx s2_mmu_idx)
 {
     /*
-     * For stage 2 faults in Secure EL22, S1NS indicates
-     * whether the faulting IPA is in the Secure or NonSecure
-     * IPA space. For all other kinds of fault, it is false.
+     * For stage 2 faults, S1NS indicates whether the faulting IPA is
+     * in the Non-Secure (true) or Secure (false) IPA space. For all
+     * other kinds of fault, it is false.
      */
-    return space == ARMSS_Secure && regime_is_stage2(s2_mmu_idx)
-        && s2_mmu_idx == ARMMMUIdx_Stage2_S;
+    return space == ARMSS_NonSecure && regime_is_stage2(s2_mmu_idx);
 }
 
 /* Translate a S1 pagetable walk through S2 if needed.  */
-- 
2.47.3


