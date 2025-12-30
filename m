Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF569EE0203
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 21:10:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vagzR-00026B-2m; Tue, 30 Dec 2025 16:10:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagz7-0001cp-AP
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:10:30 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagz4-0002hM-NA
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:10:29 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47796a837c7so66515935e9.0
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 13:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767129024; x=1767733824; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7QqNj0FBvOTWsnndVorR5mnhPv6tLS9zBqtC1X1aBEI=;
 b=SOwMinm+qUGxS3mtqNxfwcGnKNrxC9uqLo/yQCbdtKBXXJ2rHKM+6ltN9RFUvknav5
 ncdkjQWCvYu09AQXt7F4wtqMRTkUoo6xUZOKg+Qxy/Hpt1L6rzxEGWIr+tDy+f97To3O
 bz27VtyFO2o7BM2k+ROwD7P35s6uxQCzboXwVxB86XmyQTw742ENLHcCookMfHXvHxWB
 xZ+tI6eQkIgSU6j6I9yrVzpW9+CrYjTu27D+CA+ZAlKDfUGTlGLb/TfHiGl9bH4kWCj5
 /exoR147+MV4B7cnAZro+KdBmORAIJLL2T5u/uig80Q245FV7gVr/tqWVzoKgONzbLYg
 IXKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767129024; x=1767733824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7QqNj0FBvOTWsnndVorR5mnhPv6tLS9zBqtC1X1aBEI=;
 b=R8XeAVlQ+z9vMFxaTdHuUBtkhqOmmAi41/1l2KTIyh4f3bAgE5r9tdYXswEyvZGNfi
 GVLAafcGHAhJogNXNMBOpbBK9FQUeHWgnpukxGJUZDca0SoMpzVZ7zApT7dhFRuD5FMj
 N706Uj8H90dYBAXKS0O+LyFNI6gBBqv5sTwPc4OjSgfdA+FHl2wSrdYW31wLJeEwvb/v
 mgCLPlAQ1JwJAjwuNb6WvUrzYoMLSqWNMXj3ZncEVaMdaQ3t3P6s/TWl4iJwiH0J1c2Z
 X4ZRfm5qhZTnX2KOuJSR0u2leeCfazaYrw5yGlOWsKDfQrSc0Vm9zaebbiEX8RAuuypF
 eqFw==
X-Gm-Message-State: AOJu0YxMEMxeWNNyE0CEodoI+XZAbm5K9X5WeDY5oKZv+fg0zAgnUlO2
 HWiiQMEih4tGX565DMYqUQKwlmw0m5+tGCT7JQCrqvehoJh8yhK9EEtdIx8qp+SkA8hUvB2ekDj
 kof/oZaQ=
X-Gm-Gg: AY/fxX6dQCHeyNJPrJ1prxvL+c8ioLv5Vxpe7buqAyGT1AVqGAQJ9rgD2hYBGMPC/mT
 UU0m1kqtcQoQP5jcOior5MvLjEYLOWZwzhu0QNnDSIGrraSfASjB7KBghC8Lj5UzcmOOjckpYiO
 Sb1QiE6SGIHu1ChhuRSlt4KyVPap+J7oXaizz9EsGdQZXElI/5zmvSrd9S/OsCrl2SzT+zSh4w2
 yjF1vV9ue/kr144HPAvMmmb8j6/1eaz/sKnGDYDw4kBzJXKwwIQpZ/9PwywNvl766U/lp2Ki3BH
 YK3Zm+An70nmSIWWV4m5hn2QLUEUpq4QAWqSS4wO5hsEEivsTfC1ZQp2nEhpBdfM0o4yTHqyiCi
 QAb1S1WGqf1o3cWvhdeTu12JO5miJu03YUM5gyNA4F6blh3icntvX2hc/MZ0TpSg7u8pP9hL7T+
 ICMDlZB+yL9OJnwGWptL+cnqKGjkzaBQ2HNsOUEbyk7TqRu5+aqVr+F1Y1A57q
X-Google-Smtp-Source: AGHT+IFr/niFut1s17jRdePbRyq9OXZJN+YbQbMECXCIGdLdNyF7JGjmpTFgN/H8HXeUvkKeQlVnjA==
X-Received: by 2002:a05:600c:8b70:b0:477:a02d:397a with SMTP id
 5b1f17b1804b1-47d1953b94cmr311783385e9.2.1767129024310; 
 Tue, 30 Dec 2025 13:10:24 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa08d9sm70773584f8f.30.2025.12.30.13.10.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Dec 2025 13:10:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/34] hw/arm: Avoid address_space_stl_notdirty() when
 generating bootloader
Date: Tue, 30 Dec 2025 22:07:44 +0100
Message-ID: <20251230210757.13803-23-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251230210757.13803-1-philmd@linaro.org>
References: <20251230210757.13803-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

When using the '-kernel' command line option, a bootloader is
emitted, calling address_space_stl_notdirty().

The _notdirty() variant is supposed to /not/ mark the updated
CODE page as dirty, to not re-translate it. However this code
is only used with the '-kernel' CLI option after the machine
is created and /before/ the vCPUs run, and *only* during the
first (cold) reset; not during following (hot) resets. The
optimisation is totally not justified, since we haven't
translated any guest code yet.
Replace by the normal address_space_stl() helper.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251224151351.86733-4-philmd@linaro.org>
---
 hw/arm/aspeed.c | 4 ++--
 hw/arm/boot.c   | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 6199d2d2d7c..a3db3406c5f 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -77,8 +77,8 @@ static void aspeed_reset_secondary(ARMCPU *cpu,
     CPUState *cs = CPU(cpu);
 
     /* info->smp_bootreg_addr */
-    address_space_stl_notdirty(as, AST_SMP_MBOX_FIELD_GOSIGN, 0,
-                               MEMTXATTRS_UNSPECIFIED, NULL);
+    address_space_stl(as, AST_SMP_MBOX_FIELD_GOSIGN, 0,
+                         MEMTXATTRS_UNSPECIFIED, NULL);
     cpu_set_pc(cs, info->smp_loader_start);
 }
 
diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index d87bcb5b88a..0ba3adaf81a 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -266,8 +266,8 @@ static void default_reset_secondary(ARMCPU *cpu,
     AddressSpace *as = arm_boot_address_space(cpu, info);
     CPUState *cs = CPU(cpu);
 
-    address_space_stl_notdirty(as, info->smp_bootreg_addr,
-                               0, MEMTXATTRS_UNSPECIFIED, NULL);
+    address_space_stl(as, info->smp_bootreg_addr,
+                         0, MEMTXATTRS_UNSPECIFIED, NULL);
     cpu_set_pc(cs, info->smp_loader_start);
 }
 
@@ -277,8 +277,8 @@ static inline bool have_dtb(const struct arm_boot_info *info)
 }
 
 #define WRITE_WORD(p, value) do { \
-    address_space_stl_notdirty(as, p, value, \
-                               MEMTXATTRS_UNSPECIFIED, NULL);  \
+    address_space_stl(as, p, value, \
+                         MEMTXATTRS_UNSPECIFIED, NULL);  \
     p += 4;                       \
 } while (0)
 
-- 
2.52.0


