Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E818AE9129D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 04:23:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voDMA-0004MS-TD; Thu, 05 Feb 2026 23:22:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1voDM9-0004LR-QA
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 23:22:09 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1voDM6-0003Sd-Mn
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 23:22:09 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-352e2c59264so1076650a91.0
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 20:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770351725; x=1770956525; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H5cXOVfc0cfcELp2wbWGKaUPyMU0neuGXQOK5SCrE88=;
 b=InEQfkioflr2GLN65dhPQw/RRgMxa40wq2RO7Yf8xkxYgpt56ewyPCiLG0YQBEWKgS
 NMc0AkYjsnVhVPk+5Xd453jtS1epf8aRzGRBVj0YPJlyZbcq1M5I5vWG7Q+KcGVz3RxK
 QAQsimI7isCDg+kilv3TjzQcSCyUeuUhQBAEv0OhyV7dT99WMDVv1l02J21kgKj/j/0N
 Z7OHiEIc98VvVyCRfvRI47WmRYdZjF/elJfnBojGliFJ6pf/OyIikiyt4tlTNZTYgH9J
 I7I/P9Dl222JEcGu7ht1mHnlNrZEcC/7UJsSQ/r0zRti0rTNmWLP7GrnH9Xp7hK70bJd
 l9Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770351725; x=1770956525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H5cXOVfc0cfcELp2wbWGKaUPyMU0neuGXQOK5SCrE88=;
 b=Ub1xF51XpefWN0yqnpHE6M1ASfhPQ8K2eHZF/WYQnWuyAGzMrL2sr/uNDJThAQbnNj
 38QhpWQs5H6M5hn3GVpeaVJbMTFfDzAIVNDBLPpHSjORptc1CSHlOXm6f5McM40MeIW5
 Iqut97S4EvoPBV8Uf6isSIV0IpGUWRYKeqWUK1+LacEeXYSvBizLaNi+h6cZ3IxeO6Zt
 1f0qptq6cBHh+eGrbU7vBlbFQRBrfGzjzDx57W6O46gHzDCwvUDFEu4ELXYUe5VsbbHz
 35oGOaS1CfB5vCNzWpg22ExnoDJd/t0ck7uR7nyArhvJowPKLWK0GbcjVL9ejadGB3n3
 ECuQ==
X-Gm-Message-State: AOJu0YyTPo/+v8vYvVXomvfT9aaMwazKrWzED1RTc8AVVGIzvyfPdA7P
 6pzL1zB+Dt3zaSg0Gx6nft18ZdxE8sMKikJemZwdUOh9u0wPDVuLRnK+QfeDqsWU7X7DtekPurI
 792Da
X-Gm-Gg: AZuq6aLyTtznrGBBzUEhlxBJBOj7Q5/Zhxry03s84KpW2A/5xk/D7yMDEPRTQHwtS6w
 ugt9SjqGDwN/euLPA+9TEzl0MbO7B1uo3PoulKlWiCk81VWDD5la15kmkDXdAeeLzhInR7QKCZy
 a0eTf+E6YI1dTihgdvKj69sbOGJonR/edMxruntyenessDYIYEKCLFpKmoa1dKcdWOlF7u5Wpna
 Isy3PEEasULTvyRgP/yOXFuN0CnU0upAody7/A6JxE5n72UgyHu/FtXaANSWq3r1x+PhJ5BYdGx
 YQFBF3jhJ+Em1posHzYDtgYTuABCk7b1kQUn2tUHDph7l+qdNd0HU73qDYNFU0OEcmETkfqqSs9
 t05uDvXO6AbRq+tqaYyQ0YeQzqZYCmi7kgPq8EIysSHqFTQFC/A/KGD58hhH+OdxHDRlzkOEEYx
 abYz/3YIe8L7faUJjnhMZTQGQCaBz1wYTFnyx9jeOUFwscMBMhXrld53aiE/66LwYt
X-Received: by 2002:a17:90b:35c5:b0:34c:f92a:ad05 with SMTP id
 98e67ed59e1d1-354b3bc38ebmr1131436a91.11.1770351725298; 
 Thu, 05 Feb 2026 20:22:05 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8244168fdf5sm926914b3a.17.2026.02.05.20.22.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 20:22:04 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, Richard Henderson <richard.henderson@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 06/12] target/arm/tcg: duplicate tcg/arith_helper.c and
 tcg/crypto_helper.c between user/system
Date: Thu,  5 Feb 2026 20:21:44 -0800
Message-ID: <20260206042150.912578-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260206042150.912578-1-pierrick.bouvier@linaro.org>
References: <20260206042150.912578-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1036.google.com
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

In next commit, we'll apply same helper pattern for base helpers
remaining.

Our new helper pattern always include helper-*-common.h, which ends up
including include/tcg/tcg.h, which contains one occurrence of
CONFIG_USER_ONLY.
Thus, common files not being duplicated between system and target
relying on helpers will fail to compile. Existing occurrences are:
- target/arm/tcg/arith_helper.c
- target/arm/tcg/crypto_helper.c

There is a single occurrence of CONFIG_USER_ONLY, for defining variable
tcg_use_softmmu. The fix seemed simple, always define it.
However, it prevents some dead code elimination which ends up triggering:
include/qemu/osdep.h:283:35: error: call to 'qemu_build_not_reached_always' declared with attribute error: code path is reachable
  283 | #define qemu_build_not_reached()  qemu_build_not_reached_always()
      |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tcg/x86_64/tcg-target.c.inc:1907:45: note: in expansion of macro 'qemu_build_not_reached'
 1907 | # define x86_guest_base (*(HostAddress *)({ qemu_build_not_reached(); NULL; }))
      |                                             ^~~~~~~~~~~~~~~~~~~~~~
tcg/x86_64/tcg-target.c.inc:1934:14: note: in expansion of macro 'x86_guest_base'
 1934 |         *h = x86_guest_base;
      |              ^~~~~~~~~~~~~~

So, roll your eyes, then rollback code, and simply duplicate the two
files concerned. We could also do a "special include trick" to prevent
pulling helper-*-common.h but it would be sad since the whole point of
the series up to here is to have something coherent using the exact same
pattern.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/meson.build | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 1b115656c46..41cf9bad4f1 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -58,20 +58,20 @@ arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files('cpu-v7m.c'))
 
 arm_common_ss.add(zlib)
 
-arm_common_ss.add(files(
-  'arith_helper.c',
-  'crypto_helper.c',
-))
-
 arm_common_system_ss.add(files(
+  'arith_helper.c',
+  'crypto_helper.c',
   'cpregs-at.c',
   'hflags.c',
   'neon_helper.c',
   'tlb_helper.c',
   'tlb-insns.c',
   'vfp_helper.c',
+  'crypto_helper.c',
 ))
 arm_user_ss.add(files(
+  'arith_helper.c',
+  'crypto_helper.c',
   'hflags.c',
   'neon_helper.c',
   'tlb_helper.c',
-- 
2.47.3


