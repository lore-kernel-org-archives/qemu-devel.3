Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 766C8C369D1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 20:03:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JQo-0000rT-O5; Tue, 22 Apr 2025 15:37:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JP9-0005bw-3j
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:41 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JP6-00077i-O6
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:38 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22c33677183so65837385ad.2
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350535; x=1745955335; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e/M+JJq6ZWP2W3rE9cY5JRLQzGEcLqDNY6NmbDaK7f0=;
 b=ifF3VsRg9o4JZn1AvHwmciwP1+jhSFbPrUOqhiOv4u4DGIGOPJSzaLd909DI9KLwsZ
 NIn1mOgqLY1r8uWpiAb9FEYLeyY/GnIUiBtifsSvoieBMj6U+rPfAMSsBwaCiInrApp5
 Vc17Li7QB760gnIR5vo6cZLFdBNOLV8H/z3G5rt6H7FUrpwUkuJ1jXPe01UKGkOU3pxj
 22KfzR2SuHDIw9dgIoxuLiD8442ZxByxLsgpnLd54yEJKdIR7aTu6mqwxAbXqf94e+SS
 mjvl2KNSkczBFDvRxi2Ls9HnSQ6b4AiH57vG03qP1oBIz0dAeqNw1X1TWSJlfa5Rjfme
 KqGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350535; x=1745955335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e/M+JJq6ZWP2W3rE9cY5JRLQzGEcLqDNY6NmbDaK7f0=;
 b=E0pma3OPrUNW7s7xcSpN5obM7uzLhJhswOdcgeQ6RlvAfptgzjU10LpdAqPM5lxbFo
 pdoYJWFicjx9HIdVD4Mf89RlMtBxn9pZjR9IwTwzEJEqnYsVCKRJEndXdM9tSTTPBrqf
 rKbAq+ZhHwdyVH6PlobpHXmtjeP/TtABjUYamDdL+Uj8JSZL//bhs0oXrelOl/BBSS+B
 rG5rt4LjVNByyNuGMnPUCGOZog/hz0s2vyzGmhW40gmFePfgkVq22EKRaV2ZZTGBu17H
 XeLHl3T9XlOYt1mn69NcqoYLHdkpiagOMNaSw0acFDKln2slqGr0PVg3sAoepPyjk21x
 cpFQ==
X-Gm-Message-State: AOJu0YwD2pbHWwEyprnmMoqp+AhqCpnJ6xh8+F6u7ptmq21+1mfLrtYB
 Y78SNTXM0ggRbVH3PzAV5RAWGTv4be75SKTzFlyPGIiAFK/1Y9ufuDWGEAjc1+kHz8dc2qeLfgp
 X
X-Gm-Gg: ASbGncuVNf8NAHxCbkgoWCAFxqcDR0PMLidbaFfR6i6B22vJl8KeXIv4IaA2lqvBJwi
 +srjb89qFY256dAmonD8EEYo+UBIOW6KvXa4LyKKipfIm6FPCAvvzfolcGB9xfT5HidngJCNPVA
 ARj0j23rTkQ4pQc5IW2UMV49IFJP+J5D82e7bG3DpZyyLSiNyzOEYOQW8kRaQxqRA3YswwYA63c
 SORng1q5umyFx9xdMzHcnIJNsTuASKqVEl8oXhvA+GiU65AB72FIvedDNKA5Y39CNenu59g4z/z
 uVU2l5X/Z8lqVr4tH6jXDaPmCoGOHLxKJK3b6Px6WVXQV6uKDhzXFx/zNq73FxQiOE6b9OVxlEQ
 =
X-Google-Smtp-Source: AGHT+IEPu4jJP6fIwNDnMXwqqy6Vlj3JPtM0CeUjHQWSMdg0R8uDfezC/UQ1plwTM9S+fgpl3EW8EA==
X-Received: by 2002:a17:903:2c9:b0:224:2717:7992 with SMTP id
 d9443c01a7336-22c5360deb2mr247730255ad.33.1745350535233; 
 Tue, 22 Apr 2025 12:35:35 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50fdf1f1sm88996795ad.237.2025.04.22.12.35.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:35:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 114/147] exec/poison: KVM_HAVE_MCE_INJECTION can now be
 poisoned
Date: Tue, 22 Apr 2025 12:27:43 -0700
Message-ID: <20250422192819.302784-115-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

We prevent common code to use this define by mistake.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250325045915.994760-19-pierrick.bouvier@linaro.org>
---
 include/exec/poison.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/exec/poison.h b/include/exec/poison.h
index f267da6083..a09e0c1263 100644
--- a/include/exec/poison.h
+++ b/include/exec/poison.h
@@ -73,4 +73,6 @@
 #pragma GCC poison CONFIG_SOFTMMU
 #endif
 
+#pragma GCC poison KVM_HAVE_MCE_INJECTION
+
 #endif
-- 
2.43.0


