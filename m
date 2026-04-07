Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB95C10F9969
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:33:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYcC-0005Lf-Bz; Wed, 08 Apr 2026 15:31:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAYA6-0000pr-54
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:02:02 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wADtZ-0006cc-KL
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 17:23:38 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-483487335c2so57012975e9.2
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 14:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775597016; x=1776201816; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=52fny4xf/umuE1X09OYy8HjDidhbGmt3lpbRc93/+vg=;
 b=uUZc8UKMLtksu/hFr9hukCsrla4lhQOo024mEAL3j90/ap0xmdFHizQCWRGimymZbb
 RtMe4UqUr3TlK4K9QhU7S3gt60aJ3w3/gtA5uqJX9eZPUUKt4lOJCnkn2brneCJjqTQk
 wAdEOKVGzclkaks1QTSEwzG4BENnNZgUBqucOzHFgY+QBv3K3TgZF8nVxAOTSsK/+d92
 fnUB6MPGlPRFqTIGqqhL/ANxNFmA73XAp8Z7/g2rCudFTclCW1SzlEiCQ8R9o7/u6mmX
 +giAU1lUgSb8ZVTM8s9JeZSbz/WFtmwe1y/Pk3TzGW2NrR0fd7qd+v6tmGghcwnoxiWG
 SJjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775597016; x=1776201816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=52fny4xf/umuE1X09OYy8HjDidhbGmt3lpbRc93/+vg=;
 b=dEWN8Rnsy3TrIIqmBrs58VZKL/Iz3Y4I58EGrONYJau8Q+XY5gVhBmpybIOQxkE8xv
 hv7dibHiLdNjGvwSjyS97rrMpDs134bF+aHzOKFAD1e8PzCU1Sm0l1DHBCbT0UDtkhbE
 KsNGUXPlrJmI1CmZfaarPEtx07w966nTqfKZCNDQIFkirNl4FfwAQwyWmP99SNFwvJXU
 6mNb359KWRr70MT334dF4bWopMJBn9WDTNDmXAniSUofuLBn5uQPKZXgJrtMbMHM1Fwd
 mGFcdS5DwRMzFF7CrTwRTshxOD+NtbLQfLEvu2VMAoHIX9h5n7D8vlynsoovSwgSOV+Y
 jQtw==
X-Gm-Message-State: AOJu0YzqMXGvWJJ4QvbVDdhYaUAS5AQEOnfy2pYQsNNfI7m9jzUL+x29
 Lkk8UMIZ4OBPpoRM8z93AnHXZfqg6f6zPbuFjs67hkIiRkDRcHG/4AWKTt3ohNnXf5vwDk5bmMD
 8qHTniyI=
X-Gm-Gg: AeBDieuwy1eFXpDGy9sFel6kdvrHe3NV3fcPjCsvJTd0EZZnFm/eEjkptCdwaIfd5Go
 Ym4Zn6obVmjZH0olUlQ69bO4R53PV4iU+ld0zxL5O9eSR1TxcpP5i09DJhIfZHAM8CTTsGUZ3NO
 qrpoja6fDw6PPsajDctvL/OXZG8fC1hJq7AfDHuggR+ft0v4ef5K+WqALq4loRkHDNhJZ2y2IGM
 dx+vxbIJrEKqq5v+fv6kLRHdADOzQ5Y8KO8uPi2NY79QtwClIgINvJ0R/D5SEDcLIkQjKHfYL9u
 woq0ttm1UvfEymf4MaTsiCf4tmTsX3cMVXMDtpCIhID73aS7dR5STFOvvCFe3hmU7OFK4pVsTRT
 3ScXumaO77vjlAcF8VFpSbSODiO4TVaBHaBPMuvjr8rjvNw2NlcSaUotvN0twW+hJl64sK5D2y8
 cc06+ZJ8vFifbM6UKVQVcB9//ovPcjR/ru+L3MxKO2n6mi1FeyFp8zWvjVOGrSuxByoQQ0kngq
X-Received: by 2002:a05:600c:a413:b0:485:6bcc:87dc with SMTP id
 5b1f17b1804b1-488997b3a9amr195457605e9.14.1775597015603; 
 Tue, 07 Apr 2026 14:23:35 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488a8ddfde7sm460077915e9.5.2026.04.07.14.23.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Apr 2026 14:23:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v10 19.5/21] linux-user/arm: Inline bswap_code()
Date: Tue,  7 Apr 2026 23:23:33 +0200
Message-ID: <20260407212333.59260-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407195922.196410-1-pierrick.bouvier@linaro.org>
References: <20260407195922.196410-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

bswap_code() is now used once in get_user_code_u32(),
inline it and simplify removing dead system code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpu.h          | 16 ----------------
 linux-user/arm/cpu_loop.c | 10 ++++++++++
 2 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 657ff4ab20b..917e9919e8c 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2568,22 +2568,6 @@ static inline int sme_vq(CPUARMState *env)
     return EX_TBFLAG_A64(env->hflags, SVL) + 1;
 }
 
-static inline bool bswap_code(bool sctlr_b)
-{
-#ifdef CONFIG_USER_ONLY
-    /* BE8 (SCTLR.B = 0, TARGET_BIG_ENDIAN = 1) is mixed endian.
-     * The invalid combination SCTLR.B=1/CPSR.E=1/TARGET_BIG_ENDIAN=0
-     * would also end up as a mixed-endian mode with BE code, LE data.
-     */
-    return TARGET_BIG_ENDIAN ^ sctlr_b;
-#else
-    /* All code access in ARM is little endian, and there are no loaders
-     * doing swaps that need to be reversed
-     */
-    return 0;
-#endif
-}
-
 enum {
     QEMU_PSCI_CONDUIT_DISABLED = 0,
     QEMU_PSCI_CONDUIT_SMC = 1,
diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index 19874f4c727..24a66b52cee 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -29,6 +29,16 @@
 #include "user/page-protection.h"
 #include "target/arm/syndrome.h"
 
+static inline bool bswap_code(bool sctlr_b)
+{
+    /*
+     * BE8 (SCTLR.B = 0, TARGET_BIG_ENDIAN = 1) is mixed endian.
+     * The invalid combination SCTLR.B=1/CPSR.E=1/TARGET_BIG_ENDIAN=0
+     * would also end up as a mixed-endian mode with BE code, LE data.
+     */
+    return TARGET_BIG_ENDIAN ^ sctlr_b;
+}
+
 #define get_user_code_u32(x, gaddr, env)                \
     ({ abi_long __r = get_user_u32((x), (gaddr));       \
         if (!__r && bswap_code(arm_sctlr_b(env))) {     \
-- 
2.53.0


