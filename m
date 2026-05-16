Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA18DCD4F21
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2026 17:18:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOIdX-0004eg-G7; Sat, 16 May 2026 13:17:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOIdV-0004Ml-2y
 for qemu-devel@nongnu.org; Sat, 16 May 2026 13:17:13 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOIdT-0008Js-8W
 for qemu-devel@nongnu.org; Sat, 16 May 2026 13:17:12 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so12716335e9.2
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 10:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778951830; x=1779556630; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HVBWmui2gRqhhcBVAajrDH3fSaJghOrYunK4qpZkBCg=;
 b=PAalJzhY6kKgozaAaFt8d4/Z8h97vNJgrmDcJoCG9hMVfsq1gEiPa3BKNrBGyqoFFj
 UjKsRP6PJwwq46C3/ouW0KVuwiCZM3lHg/GxTXdPi1TsNYevo2wlY3OVexRF6xHiDpAr
 AoNJgo9zd52SMxU8jPqr9ykgOfenQJtE1PtVfwGnwfhsZn6mn5FCFs8pJtM3q/c0Vl6F
 Fj72Nn9Rwdt9Qmmj/dCXikq+3Xw1YpRQ04H+HX2fufdMOy+y0aYJsE6ioHxKlqkXklYV
 SQgeA+1Lcrx+foWWeRbbpGOLkXuAw18CPdACWW2I4Ft2QjojgblXKMmr4WhFg5JcG2ix
 7E/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778951830; x=1779556630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HVBWmui2gRqhhcBVAajrDH3fSaJghOrYunK4qpZkBCg=;
 b=Z15XL4AG3Ck5fwX3sOBIFsLr/MB7M+Ftu0bC6nHrzGCpzAgiqpICOFxUs3KSvsh5ke
 oXHF43YfsP/BByHh7CagvZU84mwlGGoGQU79PZYsCtDU99fkJcceSq5Fw/TqrF8b/u4P
 7uBohnei6yPyfZ7hZT1XLXkVMa1oVsTi5vCOcyNgNJ69Oq7drgx5IZTwZzNl2lFnfF7Q
 jlMvB71aEr+xU+WpWJHdscA5mVwPRmtjuGSEh4wVDaLAMDgbIlehA3MopTbmBJldJ2vZ
 xumQ0BK9CX/HQyxdRlaB3QIYqOeyvv1FAnsmK1tNRPsr5XVi6JV8i6rpm9cKlVGquffO
 adCw==
X-Gm-Message-State: AOJu0YzxEToZ5T+9wI6z+EZ3wDaXyeLwOwfM1bosraqqnUy8UIOMC2Z2
 5RdSIx7TYDIxmAm8kJ2wGqSQAtWEfh6aDYFESDRlHt+g47nC+QA7trXhF/d/r26Bvd0Sklf5a7o
 b/TcunjQ=
X-Gm-Gg: Acq92OGiYnuyWHnI1FpQ51IAMr6nN8xN6DZsdYPW+Hbx1bvMaeF7sI0IKXiyro4pIOi
 EXxBWulPZe0qdinGPvJV9kQyRa5TscNY+j1BAUmcQxQK/3nErh1YUybpXyWGlwtHqTONKBWNgMf
 MXPcS9qLisLHCYNZI6x2JSK5hSKvAn16GzrOlKKbDvwSXYScx8XUu/t0dsZdzX6jGOCmej9wrIo
 8Ff2d7PlL2dgXadQrAio4LHFm3ngh8vKpMx99pFc6WHCjKEXtGi36KGIGlP/nLTEzMZ0Mg8aD7B
 4W3ArE7ymIFvvaRy1XID69Ibu4GO+bENeLh87JOmcvkaIRQgNFqqGK3dd0hqdVceDq8MKkS+T50
 weJSOOtHUiS/h27WKeG1LApmBFj4XwryGLi2/Y/gYRdRR1U0YBsh5uOrtBNm9HoYA1BabXHDmve
 w8gmZIArhtbS1ZfjFSIqV69mCl+ZTjMAUAaJoULtRk3L/z4f89DIZ6fbLSl4kl+Q0Er/LKV1S6
X-Received: by 2002:a05:6000:4007:b0:441:1e8e:d8fd with SMTP id
 ffacd0b85a97d-45e5c5ccbebmr12960261f8f.29.1778951829790; 
 Sat, 16 May 2026 10:17:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a17ec2sm21342752f8f.24.2026.05.16.10.17.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 16 May 2026 10:17:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Steven Lee <steven_lee@aspeedtech.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Joel Stanley <joel@jms.id.au>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Troy Lee <leetroy@gmail.com>,
 qemu-arm@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v7 14/21] target/arm: Use make_ccsidr(LEGACY) in 32 bit 'max'
 CPU type
Date: Sat, 16 May 2026 19:15:16 +0200
Message-ID: <20260516171524.19184-15-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260516171524.19184-1-philmd@linaro.org>
References: <20260516171524.19184-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Commit 676624d757a ("target/arm/tcg: refine cache descriptions
with a wrapper") added the make_ccsidr() helper. Use it. Besides
being simpler to review, it also makes arm_max_initfn() more in
line which aarch64_a57_initfn(), which it almost duplicates.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/arm/tcg/cpu32.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index 919ed8a6cf8..cf643ce43b1 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -9,6 +9,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "cpu.h"
 #include "accel/tcg/cpu-ops.h"
 #include "internals.h"
@@ -756,9 +757,12 @@ static void arm_max_initfn(Object *obj)
     SET_IDREG(isar, ID_ISAR6, 0);
     cpu->isar.reset_pmcr_el0 = 0x41013000;
     SET_IDREG(isar, CLIDR, 0x0a200023);
-    cpu->ccsidr[0] = 0x701fe00a; /* 32KB L1 dcache */
-    cpu->ccsidr[1] = 0x201fe012; /* 48KB L1 icache */
-    cpu->ccsidr[2] = 0x70ffe07a; /* 2048KB L2 cache */
+    /* 32KB L1 dcache */
+    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 32 * KiB, 7);
+    /* 48KB L1 icache */
+    cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 3, 64, 48 * KiB, 2);
+    /* 2048KB L2 cache */
+    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 64, 2 * MiB, 7);
     define_cortex_a72_a57_a53_cp_reginfo(cpu);
 
     aa32_max_features(cpu);
-- 
2.53.0


