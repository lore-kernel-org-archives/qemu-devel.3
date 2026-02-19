Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8745E9A04F
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 19:21:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt9ZN-0007yb-MN; Thu, 19 Feb 2026 14:20:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9ZL-0007w6-OH
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:20:11 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9ZH-0007aH-Ak
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:20:09 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48373a4bca3so8454035e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 11:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771528805; x=1772133605; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0XHZSRtQ/KyxAgpwqAsXgA7Q2C+mS8LRyONd0pEWBn0=;
 b=c3VB1MXAZQ6qeuW3tNKK8bVt37aqY+rpgue8nqhXS75xU8VxIdDhPFG9mscJHzDzMw
 ClA0UU7tA842fem0FPrIaFfDQUl5DUi4lUL8utYXnU+pT8/4j8LkpnvlVyknthYd6BOG
 ZtE30dP0Iwa6h2XvzzSs6oURp6jc1K551KQ3b22H6REv0yso6gjacxP483uFlP8VPXLw
 PfqUxMIUXPJzUGnaSfgoVfKg/93CIXr5FkJ2eFddlEORHxz3cp1vPNwysmWUvsz2TXe7
 PrijeSQrZ7jIdiAmQU/u31bDg+MYjJ9+gYLynmKAKjiE3QX+tkslwKwndXql05zHt1E/
 akCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771528805; x=1772133605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0XHZSRtQ/KyxAgpwqAsXgA7Q2C+mS8LRyONd0pEWBn0=;
 b=hCrwqHHe3/W5yaCAgR8y9tUlqZ9J7QLiQyC1FLZv16jSK1Wfd5N91VUbkk7Ig/xCjU
 APoXm1gFNHrrf1872bkjMmDzz19VBvZoyGUE6acms8708YTCvZyKDY8x0PDN+AG98EKm
 2LB1o99BByGtqp3M2ijKVJkNlNLBxjP4Bq7nqius5dPFvcPCiEVuprA0nPDbuk3PzcZH
 NwLfSJQLWqcGVNunuRNHQmghXp5DhmdgAtL1tbDTlwxD4e8ATzLF/lFoM4nN/PGB5SzV
 4HJQ+oe5EqM0qtQoAPlMwCLMUuzDvCuDHiyLCthPSiog4rpbP1v+r5g66Wr5n/xovGGZ
 UdgQ==
X-Gm-Message-State: AOJu0YzapwbfxYt5lHTwIM1fC95gGgohnuyS6vtuVHdFPaDMSZwJBnaQ
 mBZ1LkPtIs+i1WPc5UgjBobYgN+v5nF+HMVPRqTG7d56wps3L1rYOk21oJgfgs7obF43ra7iDND
 iz6tqifw5bA==
X-Gm-Gg: AZuq6aI+iF7DFGIpOhyEQBlOh4dN4bzB/3z9zrGEwHcRiDheGh7Fg87Vu5/wJizsw1y
 6bxMeFiVQs6L38z51V7UKk8Y91QczZUdtvP7YFbOM0dasEUWNAUi/ah4B0llNjZ2m3vsP+eQEp7
 BnoURDbnhwW0xX6F2khZxGKfuKbl6mxJjppBjq4XHY+D6BG5EJVcz0MLxsSRUpB0SUf5oBO2WY2
 HkSA+0v6q5wAkUJLLjMoIZ/gx4IYs+ZS/6DXK0iAAa/ApA4+ccqCQqWRElbKR0Ik+BO+t0DO93b
 n8NPfLcIB9346+pbShrtlAWdWd7Gh+bmDcBmkEvEk11x0cg01LOXL+HErtzUXlDGxPakJOluNTr
 GlVFLCPYdGFTBHOOmuyHwj/1J/bPqDV/WZo1NJ267M6f25FqfhgDKbYda0PLrTzDAqnz//5DTOZ
 K2OgYyesjFTk52HVoN1voEJ29hGGeHLiPl5Pm3YEFE35frhOTNcv5YM1obzEzUlPXjnKOxScSP
X-Received: by 2002:a05:600c:444f:b0:471:1765:839c with SMTP id
 5b1f17b1804b1-48379bd7414mr298135575e9.20.1771528805077; 
 Thu, 19 Feb 2026 11:20:05 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-437969fd36dsm53538387f8f.0.2026.02.19.11.20.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Feb 2026 11:20:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH v2 01/50] target/ppc: Move user_only_helper.c to
 target_user_arch[] source set
Date: Thu, 19 Feb 2026 20:19:03 +0100
Message-ID: <20260219191955.83815-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260219191955.83815-1-philmd@linaro.org>
References: <20260219191955.83815-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Since commit 46369b50ee3 ("meson: Introduce meson_user_arch
source set for arch-specific user-mode") using target_user_arch[] is
preferred because clearer, and no need to filter on CONFIG_USER_ONLY.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/meson.build | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/ppc/meson.build b/target/ppc/meson.build
index 8eed1fa40ca..b0d708bb519 100644
--- a/target/ppc/meson.build
+++ b/target/ppc/meson.build
@@ -31,7 +31,10 @@ gen = [
 ]
 ppc_ss.add(when: 'CONFIG_TCG', if_true: gen)
 
-ppc_ss.add(when: 'CONFIG_USER_ONLY', if_true: files('user_only_helper.c'))
+ppc_user_ss = ss.source_set()
+ppc_user_ss.add(files(
+  'user_only_helper.c',
+))
 
 ppc_system_ss = ss.source_set()
 ppc_system_ss.add(files(
@@ -57,4 +60,5 @@ ppc_system_ss.add(when: 'TARGET_PPC64', if_true: files(
 ))
 
 target_arch += {'ppc': ppc_ss}
+target_user_arch += {'ppc': ppc_user_ss}
 target_system_arch += {'ppc': ppc_system_ss}
-- 
2.52.0


