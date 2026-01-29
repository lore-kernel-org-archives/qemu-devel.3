Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51350D73E81
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 17:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlVyQ-0004gR-6X; Thu, 29 Jan 2026 12:38:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlVyP-0004ba-1z
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 12:38:29 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlVyN-0000f7-4p
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 12:38:28 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-34c1d98ba11so955849a91.3
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 09:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769708305; x=1770313105; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GhrB+p6q5WdeFFrjMC0kuTkiUzANFpmBoSRwysaxsTI=;
 b=sG2WpZL4xrM7iFM3+Pxp17Ad3FRUTyH62YrNIpfHx89GspNUWFt8yLwrwOsjmh8O8Q
 MSc4bSsI3QCjA12l4iN4SxXmUS8Y3KO6w6DjRisF1O6PSNu0OEJdNoY7ukpsEYQ6fFju
 zMxlEPpXGBKX0SOL3UnrLdd2KZ9liCz4+uXCordewCc7jaDxiX671SeITQzLHpY6pEin
 v0FI985P7+fSke9wt6Gx8EcfAcszwuTFBNGTf0UufDWj1MFGf7CHK+Lrh1mcvvVIz8AK
 nuQEwXzYbIt3U7BTMYxx/qZI9Ig8MVcAGhW0Yrf4nergsMc5dnZBw5YR1G/pyOHM16pt
 JAiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769708305; x=1770313105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GhrB+p6q5WdeFFrjMC0kuTkiUzANFpmBoSRwysaxsTI=;
 b=gEaJh12vbjHOhY1X1eQjVA8KmMWF/QE0Q8ni2VgU7kTpoxkUesId7AzFC17ixsWFJx
 BrwcrYFeMQW1R+k72QEHJLFo03qt/NtvWA6ZRK9wq7FxLFOI6t+ov4/OTkvCzzqbUE/A
 kgOvHi0fhmxip4SRIXmGbWxag4KsKL5dL0MRB3R9CNPy+NQ8xd2kq7CO5G5X/G1yxyT+
 bpnmG1KadZIaPt2LWqzLmyye9KgOR0LlW16BpwKZ883C58a5Ib33YAUVWKW6i0NlvJ/6
 wdHiiMBUqhOZ4TniW7zRQBLMgClsNlz7vVd47ReHuLz258JviQYfQJtZJDgK0qFZSI6B
 IwIg==
X-Gm-Message-State: AOJu0YwNZYEG06OBz+2RAEwxX5jp9bUaZlwtDEYG+hUqhrSvecBf6mU9
 cb0PXqbVp4JNVxlSKTE0QXsY2PEFt9Z0By6aRoO1HlV4ClcTKJ/CfDgbu3s+5uxkG7WOh4BSTQu
 DrbCH
X-Gm-Gg: AZuq6aI0I8eSlQAlGa3BRAYuraKnw1/njZwsR7N2q9dugodK307Ux1t8Ry37dtQFj2f
 txwqAAR0FEryoTFZLV2mbuLmGR/5yRfxQAkaJsso1fbeOKRuwSQNq25Yx6LxirNYpH89dfMy42P
 55WvPqpo8MGTO97P9csB5EQW97FmGry4+ZzLO3bshtprf7QI9R39mqMZHKfvzckX5NC/GPSLpoN
 aLmVZV9sE/H2TqGvHRjBLqcPAoElYU2dIqSq/heycZU06K8jjtih2Nre16GK8R+fwUejIKqT1Ho
 +NxVPW1hpkjZOSiNIyLFqOx/S2uhZT8MQZBBEs7YcFpT9t/sv+wHpRoHsJCbmf8aPw2bb25ZTeT
 Npb1REiSwHF3QegrbN6vWy/OHofSODK/QS/MXwvw0bjxSMIMpSfh0foeU4dI7t7zORi+9B7Ek/7
 MO3Bu5RB7+DQbpzPCK+cXDDR/QKU979IRioRYJ5xHhK4lYtrYhhSmMwzN1KFyVZ5XM
X-Received: by 2002:a17:90b:2e8e:b0:330:6d5e:f174 with SMTP id
 98e67ed59e1d1-3543b3941aemr190651a91.20.1769708305378; 
 Thu, 29 Jan 2026 09:38:25 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379b222f1sm6706246b3a.7.2026.01.29.09.38.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 09:38:25 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 10/21] plugins: move win32_linker.c file to plugins directory
Date: Thu, 29 Jan 2026 09:37:56 -0800
Message-ID: <20260129173811.138036-11-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260129173811.138036-1-pierrick.bouvier@linaro.org>
References: <20260129173811.138036-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1035.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260124182921.531562-2-pierrick.bouvier@linaro.org
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 {contrib/plugins => plugins}/win32_linker.c | 0
 contrib/plugins/meson.build                 | 2 +-
 tests/tcg/plugins/meson.build               | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename {contrib/plugins => plugins}/win32_linker.c (100%)

diff --git a/contrib/plugins/win32_linker.c b/plugins/win32_linker.c
similarity index 100%
rename from contrib/plugins/win32_linker.c
rename to plugins/win32_linker.c
diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
index eb944b5159a..6f72b2ce0c9 100644
--- a/contrib/plugins/meson.build
+++ b/contrib/plugins/meson.build
@@ -10,7 +10,7 @@ t = []
 if get_option('plugins')
   foreach i : contrib_plugins
     if host_os == 'windows'
-      t += shared_module(i, files(i + '.c') + 'win32_linker.c',
+      t += shared_module(i, files(i + '.c') + '../../plugins/win32_linker.c',
                         include_directories: '../../include/qemu',
                         link_depends: [win32_qemu_plugin_api_lib],
                         link_args: win32_qemu_plugin_api_link_flags,
diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
index 561584159eb..a6e78438510 100644
--- a/tests/tcg/plugins/meson.build
+++ b/tests/tcg/plugins/meson.build
@@ -2,7 +2,7 @@ t = []
 if get_option('plugins')
   foreach i : ['bb', 'discons', 'empty', 'inline', 'insn', 'mem', 'reset', 'syscall', 'patch']
     if host_os == 'windows'
-      t += shared_module(i, files(i + '.c') + '../../../contrib/plugins/win32_linker.c',
+      t += shared_module(i, files(i + '.c') + '../../../plugins/win32_linker.c',
                         include_directories: '../../../include/qemu',
                         link_depends: [win32_qemu_plugin_api_lib],
                         link_args: win32_qemu_plugin_api_link_flags,
-- 
2.47.3


