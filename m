Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BBA1EA8118
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 13:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpoAQ-0002H6-1B; Tue, 10 Feb 2026 08:52:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vpoAK-0002Di-HS
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:52:32 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vpoAI-0006O5-Tu
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:52:32 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4832701b9b7so22622265e9.2
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 05:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770731549; x=1771336349; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xY0d3NFt0HZPqHzHbAfTDIQcZriTqekzYmOm7UjWuJQ=;
 b=BGjGDjeOFP38E2tl/U/0Dt/li5VkbFvgnEOcRyiB6tyCRGQQpIwR0v1EOj9HzMmHwZ
 VWLLwpnQiMX6oVNhIP4W/SkcLCu0gpadGt8Tb+7eWuDy18yp0d3R7SOL9dvWpIJBZnGH
 t/VwVZ2xIj1Lk6McZsFeRM88im44ebDKr4L6K2ceVtwc4YhpZAzI2QG/WsN20R4uzeuD
 Ruto6qwug8wvkOLkvPnxnxRCswUXWqdEk50WTsINF8LPpKFunpeTNfd9++JatqUR1Xwf
 DBHf+37XLUdfKrSpTwgKGTyWTkzzqKESsHTMlUrhSHCqY5vNYamPfI+c7BuZaKTdf6Nz
 OroQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770731549; x=1771336349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xY0d3NFt0HZPqHzHbAfTDIQcZriTqekzYmOm7UjWuJQ=;
 b=pLcZ3Xloq/33N9zL7qkMz6EEBiCWWnMrjKyg3p3ZJsQv5r300cg4joygGCZT0Lhie1
 xc1rxxoujuRAo8eIrRIEgxSOrzo+dXsTXnvcGIpnhv2L1Fy9/DlUXp8t0v1fADslnJh4
 OHmog5nH8dP9ycpySdy+J/89SF/n5+cR5l8ve832n0syPJaTLoAeA0MffjdA4rn9g45b
 Rwe0B4G+YU4uhwyuiIj2ngsl5a4iKWXgflbCZgmB0qX2XvgnCMjrzdpjKS0kdGqUiej2
 Txt6BL0MINXCgIHstv3xWFI0Pb+aVkLOa7Ig/eVqCGOHtFnahHBPxCwmhhOc2ozcdihS
 8cEw==
X-Gm-Message-State: AOJu0YyjFhyFWqwf/0xMeBdUvRr7UeYg77s5aCuWZE9rfbvLFlpofma1
 MNoEdUB8+g24zKfW+8uR1SfEs8o6CdERphya43a8ZBZMYHAp2N4UVlRSPNNTrG/uH9tjx5aoPy9
 rAVtw
X-Gm-Gg: AZuq6aJT4KfhTtUtypigMfqcnqTQQqt1vTiWlFgm9kwektZZr+s2KGFyOEYLKTHwlpP
 JZPUW4mb7fjAtNDrd4ZqTUiqc5bcBpeBolpDCWRwEQFBOjteagjBAK69R6MNpXo5xqYyYceOU2l
 QDyHVW4Gb5Coy/gHQs/mwe2GGtTCCwAFbdyDusOxc5Gi+qFUUxPvvZssTfgyjcKD+cTn4Y11W30
 VvXY0p+M38W2hdYghWAc92UVHd937GTUnUCDWjUOmcXy2mrtM71w7BK6z3a9SXLIzxCXW2W6743
 U+WqSvjq7ZcswoynfN/pnChp1t2PL0wVlyr6uyq07iXqIHOS0omFLqMjiaDfsSWUX0tN+hfgfBl
 A9CzwC1aBuH1N3PUx5Q239893PzPm79NmDXeGwEen6XnHxa1RXi3kWbEbrI4HVuVl26v150Earw
 0E99d+gIkDGQQMyHoFtPEoXIvqrqqiGjinuB7w+GMwGl3uclVuctk7qg3Z3oOZ8XBaBh/g52SM9
 QRnclVqH4jIX1SCN1zsG9QzNzLPWN8=
X-Received: by 2002:a05:600c:4e0e:b0:47e:e71a:e13a with SMTP id
 5b1f17b1804b1-48320221645mr196110365e9.32.1770731549435; 
 Tue, 10 Feb 2026 05:52:29 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5d77f9sm64344875e9.3.2026.02.10.05.52.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 05:52:28 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/26] target/arm: Remove entry for "any" from cpu32
 arm_tcg_cpus[] list
Date: Tue, 10 Feb 2026 13:52:04 +0000
Message-ID: <20260210135206.229528-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210135206.229528-1-peter.maydell@linaro.org>
References: <20260210135206.229528-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Since commit a0032cc5427 ("target/arm: Make 'any' CPU just an alias
for 'max'") the 'any' CPU QOM type is never used, because we change
"any" to "max" before creating the object.  The array entry means we
have an unnecessary type in the system, and the only user-visible
effect is that "any" is listed in the "-cpu help" output for
qemu-arm.  (System emulation already doesn't include this array
entry.)

Since qemu-aarch64 already doesn't include "any" in its "-cpu help"
output, we can reasonably drop it for qemu-arm also; remove the
not-very-useful array entry.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20260202153618.78675-2-philmd@linaro.org
[PMM: update commit message to note effect on help output.]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/cpu32.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index 0b0bc96bac..2127d456ad 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -897,9 +897,6 @@ static const ARMCPUInfo arm_tcg_cpus[] = {
 #ifndef TARGET_AARCH64
     { .name = "max",         .initfn = arm_max_initfn },
 #endif
-#ifdef CONFIG_USER_ONLY
-    { .name = "any",         .initfn = arm_max_initfn },
-#endif
 };
 
 static const TypeInfo idau_interface_type_info = {
-- 
2.43.0


