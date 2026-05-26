Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 444B5CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 20:41:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRyYY-00026t-E6; Tue, 26 May 2026 16:39:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRyY4-0001K8-8t
 for qemu-devel@nongnu.org; Tue, 26 May 2026 16:38:55 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRyY1-0007Ud-Se
 for qemu-devel@nongnu.org; Tue, 26 May 2026 16:38:47 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4903974854dso47685065e9.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 13:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779827915; x=1780432715; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7mHdUlQXGaWyFWOgTCnLIZVkxyrdDDV5OFAs1hIZcGQ=;
 b=ylPUVU2QURMgd9Xx699Hqwga+3w3XW6AqV6ahLgpUthSanMNh35NCLujT8VP4WaJOB
 TzfiKMOsI+FNVVec43BAoXs4695uWuEcX8wL8xc+H5ON1I+5RoSxVrVVjJ0345/6yvrz
 qHeTZHlUur7hBezWFcyMTsPmZyWq0hpgZMkCjLA23VMne/NSvgER3gQfV1FVj19WPTa+
 JJnFjvncRwesbfe05C4/pD+T7KT8dcCudlXcz0lNbAA5FNQw8L3XNsH1mQzfufW57XUJ
 Qlemk7vs4+It4xeEKvd6Z8hJbutJQ/lFW9LaQXLaj+xaYHPC4w+LLimJXICFn3MylJza
 Peag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779827915; x=1780432715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7mHdUlQXGaWyFWOgTCnLIZVkxyrdDDV5OFAs1hIZcGQ=;
 b=d4GrlgWvLQUnSXW0+aOIi7MzfQgSSXJotgAEGxIH6Ruw15KSNloq3kffd9vLbENNKL
 IJllEuaFJLqRa799rvm6uqFsgH/Mezjhq/VVb3m/cdt5s1atlgHmFXRvBUrL5UlfTSZv
 PkcG6DA+dxGHJDg/3ex8Jf99H+h1aiR4J1EKTKoJcUvZLh02y9FJpREpHG3LhyX6ckMv
 ktap8CGV1MNcjx063P8GUpUgTHyOVdMZ3Dne/5RzxUa41pUOCa1By9HMQoSROYj/nZm/
 1iA9JpZRbJrhqyF0Iia0c4baBaI16djFTkp9g2ZIpb4u4YjxQUeaYjl8Q/uo68r0Ej53
 D9lg==
X-Gm-Message-State: AOJu0YztlaB+oDaVtK7js8fWZu3WSJQQXXaL4fkPv5CjHljwbZg8ldww
 n38Gje+FzOwIz9mGefrAMlc+ObKUmy/EJWxiuqdtn4FpoQl9fx/gX3KZiRpCukXFotz+TmRDgPq
 WVJp1r3TqjQ==
X-Gm-Gg: Acq92OGrHpIntJyFhwHCMmABI1i7VfvuJXIjU1S0JkRkrQ2fTT7noZ3GnWwr1VYCGmb
 c0xpSbepM07ihkFjz7qwPfGoXHxKno6nYUp/qQIDEJlruDec35po/zXwJAHVBSnDLhYyy8qH7pz
 enh6Naq9QViTVAtFJUU4fmrNIDl2HCk6V3zsm3/Kk/zHsd3IGa6wXX5ewQtWhYp4ayQAGY5OUI+
 njrrgWxPo5SlfIcncE9wqwWXxZjd+sJnVgG3EGGjIPjU4T/xOGYVTYUtzwq68J85/UBidg0TAKe
 khTgjKjMVcFBBkrRuhLut+RbhFeS7sFz61ZVVAHpc76C71NK1G03zEfW1lVyirXk06UibxoTdXW
 j26whNJKlM6T97jgudksMaGjAdjkjvQuk12wCGeEUWL3wDGfh3RBrQSWD0+gzcJSBdsNGSSsLJY
 4p5n5UFcTIRbwU+PVG1iA3IJgrDhLn77hxiTJQFZVRUbI2/L4WCyPYJFbY8fIfD8mDmg==
X-Received: by 2002:a05:600c:8b77:b0:490:5368:743 with SMTP id
 5b1f17b1804b1-49053680a94mr284980435e9.32.1779827915418; 
 Tue, 26 May 2026 13:38:35 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49045282201sm389760375e9.8.2026.05.26.13.38.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 May 2026 13:38:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v9 10/17] target/arm: Use make_ccsidr(LEGACY) in 32 bit 'max'
 CPU type
Date: Tue, 26 May 2026 22:37:15 +0200
Message-ID: <20260526203722.79463-11-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526203722.79463-1-philmd@linaro.org>
References: <20260526203722.79463-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Commit 676624d757a ("target/arm/tcg: refine cache descriptions
with a wrapper") added the make_ccsidr() helper. Use it. Besides
being simpler to review, it also makes arm_max_initfn() more in
line which aarch64_a57_initfn(), which it almost duplicates.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
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


