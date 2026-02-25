Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D3FDFD45FA
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:24:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvOBZ-0007nE-Ev; Wed, 25 Feb 2026 18:20:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvOBX-0007mj-Rk
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:20:51 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvOBW-0004Cg-Bx
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:20:51 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-4398f8403edso181806f8f.1
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061649; x=1772666449; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tMA4cs9evprWNErV/UApWIVyy7rlCFYo2HAw8z1Xw3M=;
 b=ML7l7pHp+S4t93wF86XfHtPWdxGzS1jp9/xim6iq8eeXUB1Qb3v8eq9kulQSLmPAYR
 VWKrtuEBswIXfEYmRHvBWbEmTTTqdX0QZQSUD0PJdhr1Hva88fEt0iWUzYNBGHoHXgPu
 WKiizdEnHfKywxZPHZpafay3aq1osORrwEC45mBRydWh+ph8W1zE87WKSD8bDawEEgvZ
 MTXf2BMVxi0Z2FzhDDYOChA1Ri7ezt7s4BWYQXjQw8UcFCl2F5b9HZfR1pLhJxb6ZzSW
 aq9vWz9CH3wJ9uV4jgqLNpJiquSNlMv32aeOmNIvJJ3bAFh/cdg9RP8lza4O1SNjJYaI
 frFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061649; x=1772666449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tMA4cs9evprWNErV/UApWIVyy7rlCFYo2HAw8z1Xw3M=;
 b=O/f4hX4TqFhsz6m019hXJ7AHaSlZckLJ9fdJRHdPqhy/pSGfSwlIJLSt5LwDS4qLn1
 T9oUUE7frcOqPhho9GZUuprsOe0DPFa7HGTYdZTGggV4Uq1vbomUDYpD/TBNGWQXOcbC
 bf+4XCzZZP0kmvtI/1nkHcW8/jvQ+JKU/fEfUGZb+0Vcu02/A4vtLs8G8ItlA9Nv/5Pm
 CYU4NkNY6YG7IBrF1+PrGX54isYkJUyc3wdlQ/isdtu4r8zyiQpOqzEJHEpSZjF2K0SW
 sczXaeoeTJ2WAHJFKN8qfXMLXHQjmxYX90aCyM4wcWssu8MTb4c1WIVSXz8dfoYqPfRL
 xQrg==
X-Gm-Message-State: AOJu0Yzi8ec7C790dUGFygGWC1Q9myIyN5Fgs9QBxXEqbltftwqWad47
 DJOmKMLOtJQdi5LhMzfqpPOzlu7GI8iWuNho42TqFXR1aWfCDJ5qM0mny1HpmEM09FLFololjsz
 pBz/4CDU=
X-Gm-Gg: ATEYQzzqR0MF7NI0ZKCwMmPYlGV1RZDPfcW3tmbjdwXmdMrOBKcn6QYV9dxlBi1JZ7c
 km8nSoot3dlbo3BjASEzGsjKAObIMco81XkY/SNQ5acygEQr48z7nGjWVccnNvqonWkS53rhT0P
 l29UEVUXe/i2485XufEXeFHFYFNakngxvac3oO1YCOYoSyJZpQcfmn9kqOLdV1lbNa/JkkW1U5X
 kUaJrqWP4QXHx5Gz0fjOpYWcZBkJc3NqyphdS50c7ftqwuCxof1xwPG2Wet4MV1Ce4ZKshU4xC0
 NKQ6+BQfxs4BBJ0uYjIb1BrLih63Dw/kjhIqNUyBH16rdZKU+mzimrj1ykqs0IPoz00vVb4HQht
 MR0yf7I1qrwYCURZWz8oHtiSwO3zJHz0DP/3IkhEynEHP5zzbSgyOCzuYC1c+PGbRzb4dOp7KD+
 VOH6mR5ifaVDKZAUytUoyIyu0h/NBE5v6ythoeWJsb/FOisGjNs81Rrth7N9s75SBiLjyvbkRM
X-Received: by 2002:a05:6000:2c11:b0:435:ab90:6f34 with SMTP id
 ffacd0b85a97d-439942a83b8mr3948060f8f.16.1772061648524; 
 Wed, 25 Feb 2026 15:20:48 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4398bb96b90sm12900141f8f.9.2026.02.25.15.20.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:20:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 58/70] target/m68k: clean-up includes in cpu.c
Date: Thu, 26 Feb 2026 00:13:58 +0100
Message-ID: <20260225231411.96482-59-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

We don't need translation-block.h as the TB flags are local and the
only bits needed come from cpu-ops.h. The vmstate is a system only
concerns so we can guard against including it for linux-user.

Finally tidy up the order to keep things together with the local cpu.h
kept at the end.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20260219171810.602667-2-alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/m68k/cpu.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index c721a23b966..d849a4a90fc 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -19,12 +19,15 @@
  */
 
 #include "qemu/osdep.h"
-#include "qapi/error.h"
-#include "cpu.h"
-#include "migration/vmstate.h"
-#include "fpu/softfloat.h"
-#include "exec/translation-block.h"
 #include "accel/tcg/cpu-ops.h"
+#include "fpu/softfloat.h"
+#include "qapi/error.h"
+
+#ifndef CONFIG_USER_ONLY
+#include "migration/vmstate.h"
+#endif
+
+#include "cpu.h"
 
 static void m68k_cpu_set_pc(CPUState *cs, vaddr value)
 {
-- 
2.52.0


