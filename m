Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38522FD45FA
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:23:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvOBh-0007oZ-1o; Wed, 25 Feb 2026 18:21:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvOBf-0007oJ-M2
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:20:59 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvOBd-0004D6-RN
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:20:59 -0500
Received: by mail-wr1-x444.google.com with SMTP id
 ffacd0b85a97d-4398913af88so195188f8f.2
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061656; x=1772666456; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KmA6moOts/y8W6VH8TAC8fzK0830HPzqB/hEf14q/kQ=;
 b=ZTnPxRvGTK/QeXd32WZqdWJ8rPo/E1H9zebRmufEKi8tQ/CaR1CujZrACO/0U0SQWc
 x1Byqz9twn9Gcpm/30MSvoYxypsOGPlCNnmfpJpQtL1VjVlzRdmq7NGui1OJ8tFihX9E
 BWWnuQ1VZWFKfg17CBjhwxpXNFUy+ApLu6X6/n+4spnyaA/77bmO/BYxJI8FFZXnDXsM
 M9z8mOtf1fHsj+BUm1V+30OcAWEua5YO9s8UtE8gB9xvEqq3P871878+gWPCXsbIKTOt
 zXoW8p0dKL5GAQaK6O0ruBKl6n48xzkZWByhwoLSI2t2ZgTH4al1ZdfdiZoZCdxbSnWQ
 2VaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061656; x=1772666456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KmA6moOts/y8W6VH8TAC8fzK0830HPzqB/hEf14q/kQ=;
 b=V5+JDBLIkzWxfJi8cwLGV5er+7VwLlOQrBz2Z61vzUSIpPiJBfwQijbUarjv5I3a+r
 NhEUT1XKA75d8HLOr2tAXI2krmwNmP4fJ62Mp8J6cBXVl7CFzHri2CwoeSHLGclQhPhA
 ouQkTvFrFGs1AYvxtHqaD3d688nfTuCpqoIEpyhm6paFHYj7vVUXWsI0mWhjak6qycnY
 viNb74Gcdt+KoiZPNWhN/u2lq+sXlVTv223oMjMSf+glImbU+and35cFHkdskcRWOIEH
 Ky5ixbdm8yWBm5TKXSnWNCB87PvsqtHY3NnDUl3ZdJ7hcxpyB+DZ9bAwWEvR3b3Vxj06
 TNOQ==
X-Gm-Message-State: AOJu0YyyIbJOR/wirqe56j516UVDV/e5K2kxE7s0Rgrd/WYS0BOaaKKD
 LEXZAzdrD+5kBklr0ZgUjdswGxp3TRQiTYoTouIlltHVO4g+xkYPt8YExm4aXfygywmH8S+hOrd
 yNZiDcXh3Jw==
X-Gm-Gg: ATEYQzwfMAlGfgMWQNMNgf1l8UnxLLAhyXqaMlGdX3pl1riey+Pf4RNz+X0zF1oCXWg
 vCAOzUArXJ1UpozISpbAXDW+Nc4h6eqnK6poTZ8saByRvoJ+7j7mIJ1uLLAoZolgV+xGwbNJm6p
 RKas5A59bpDOzfW99P3aKffSclQiF3IpA6qdxm7MvNXX5PA0DFyWysnBldqbPtHvkEr8I/o2oV2
 2rCuagykhtwscKNMO78+ieedt5e0Z0FM3IwHPrSI+oWQPhMKi+RN5R2IF9KJP9jr9yJmrTjhuxk
 RuXbkti+eajpdH1dt0g9Ef0Z2zEJv4gpX/VTCoSLSd9MMckzlEjpSAy/FacnD2DKkWWo2x1YA8w
 cND7uvNCrBGv4GtHnH1M195SHvM7YqkHwXxp2oxZBBjp76bubX+/i2bchB4GABRbcFtHHN2jxmw
 cROg7NEc0cseaYsqT4i0wb22e+EatAhTH0i+33anf7I2qDzgAFXSuMlq9onDEolbWgGlx6UOoYq
 FhOkA20Osc=
X-Received: by 2002:a05:6000:2510:b0:439:8e9c:35b4 with SMTP id
 ffacd0b85a97d-4399430574fmr4144144f8f.53.1772061655805; 
 Wed, 25 Feb 2026 15:20:55 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970d4cc81sm36373905f8f.26.2026.02.25.15.20.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:20:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 59/70] qemu: Document qemu_arch_available() method
Date: Thu, 26 Feb 2026 00:13:59 +0100
Message-ID: <20260225231411.96482-60-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x444.google.com
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

qemu_arch_available() is used to check if a broadly available
feature should be exposed to a particular set of target
architectures.

Since its argument is a mask of bits, rename it as @arch_bitmask.

We have less than 32 target architectures so far, so restrict it
to the uint32_t type.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20260213175032.32121-2-philmd@linaro.org>
---
 include/system/arch_init.h | 8 +++++++-
 system/arch_init.c         | 4 ++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/system/arch_init.h b/include/system/arch_init.h
index f2f909d5406..92d50ba8d63 100644
--- a/include/system/arch_init.h
+++ b/include/system/arch_init.h
@@ -25,6 +25,12 @@ enum {
     QEMU_ARCH_LOONGARCH = (1 << 23),
 };
 
-bool qemu_arch_available(unsigned qemu_arch_mask);
+/**
+ * qemu_arch_available:
+ * @arch_bitmask: bitmask of QEMU_ARCH_* constants
+ *
+ * Return whether the current target architecture is contained in @arch_bitmask
+ */
+bool qemu_arch_available(uint32_t arch_bitmask);
 
 #endif
diff --git a/system/arch_init.c b/system/arch_init.c
index e85736884c9..ec9e45a1a80 100644
--- a/system/arch_init.c
+++ b/system/arch_init.c
@@ -24,7 +24,7 @@
 #include "qemu/osdep.h"
 #include "system/arch_init.h"
 
-bool qemu_arch_available(unsigned qemu_arch_mask)
+bool qemu_arch_available(uint32_t arch_bitmask)
 {
-    return qemu_arch_mask & QEMU_ARCH;
+    return arch_bitmask & QEMU_ARCH;
 }
-- 
2.52.0


