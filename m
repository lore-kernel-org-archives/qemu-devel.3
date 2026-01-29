Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C37D46BF0
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 01:40:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlGtK-0000DU-Dg; Wed, 28 Jan 2026 20:32:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlGt8-0008Tr-Ja
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 20:32:04 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlGt6-00039k-Ci
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 20:32:01 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-353576abcfeso168012a91.0
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 17:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769650318; x=1770255118; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ErhJH+3L5kKgEL+bTAwKvHuiXtyYAOljdjanr4eRKa0=;
 b=DdOpzC8kc1XXjOEqoMkr0Mx7UnlsGcBhALfqGFwlUxw+JdLYPT8ptX0wDLg28GcQE7
 EuxELYyhU90hnvF/ZQtMjEYEojQaC1k2oZe+kg2oDHrr69rfqxB7dMUZaKJXaQHLE/A/
 6soKglU4N8/HXQGAj1w32vb+YgN0rG1eBkyR5F7NgDtZ5u9frb48hi1l9DheXr2sOUBP
 w2iT4S62Mwkr54Zok/iYglykTom9Ozx/w3RuBPVqOA0ih2HIwcfIKptjW0F4rOOkfRfg
 LSJnmIQyBW3JUIc/V2G/DnTBl7kfuqP9Hc94DDyxMy6OBR9jSoOaYmGt06aBEPJmAz+V
 8GEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769650318; x=1770255118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ErhJH+3L5kKgEL+bTAwKvHuiXtyYAOljdjanr4eRKa0=;
 b=IV0FzOBkwIx4WJq7kQQzVEysJ9VNg7OwHfMX+xgm+edJE19caMkefmWmEIyFR7laqP
 XrRuLLw3WNYxCrK2kBrscR8BAnHQVaT8itxUdOAspxW2/2glnlIBuClmjO+x31z9W/kK
 5I5Dvdjj9pTVhW/4XX4RQsBZ9Rq5vAYBEuEv+7Skhw3P8Hdf+L9HsNXWr2sOauMjHKoM
 umv30OO3YZZucyv46z6peEcAe/a4vb4b73A83USgNwjPQ7xQTxBfH7j+qqGmY717ogNM
 PwgvZl4uvqdNc29h3Zps+v7idz8oWaG60cfHiX80WHmNcALm1cGxiH5OhKkTlXOCIH0a
 Zvpw==
X-Gm-Message-State: AOJu0Yya5dLuylD9I1vIx1u+LujHSMAtMnMmVD+3idiUg+J1e3WtCucT
 Jpbf1iKmsSO4vDnW5bgdQAipUX9XrLr0DIaro+aS8pk7BIULpkIdswd3vtu/3OEAqyUcdTTGma4
 RcBL4
X-Gm-Gg: AZuq6aJ20CgJzMjvC43wRM/U3c3h6mooJ/27u5h5WPunCBkQDEUbPorWDgxphv+dyxf
 uOxdpYmfeJUzT2OPTwHOAInN0ziENQadxW4X/g224JVYdkKnrjxzxP19nR/2zMIb5kolg+MJVA9
 /hjBxjBaoXNfmeXcinWr+CROPEBHleUp0eWq0OeDA0BSEFISlD+ZF6lhjmDHy2bNf5HY4McMOTU
 IjOU/eUkeQ0udyxboJmqN3qsukRv1PnEVWgINPSU2q1PKR4W5EkiNc+OATq9+4MLrc1e54q2CA/
 9547m8wFKDeBeU28KFl0Nv8vnLrSuFpEmwgnamDvMQa14qMZgNJP2ngOIcF8BIUu+OCv+VGvR9+
 8s6p9M1n07UgOnk/tbuYTx3myxPSxoyzwV0Nz+jEzdC2dfqn7EZ/6RDDS7W+wAs48vqyV1RbkJP
 uGh5YX8OKMsICdhpwJsXb2F38PIXLLGpeNkNUBitCgrr7wJYocf9zaxsUBQKI/Ry+X
X-Received: by 2002:a17:90b:2d83:b0:34a:a1c1:90a0 with SMTP id
 98e67ed59e1d1-353fed87a85mr5797860a91.28.1769650318245; 
 Wed, 28 Jan 2026 17:31:58 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-353f61e0007sm6627143a91.12.2026.01.28.17.31.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 17:31:57 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 16/20] meson: enable cpp (optionally) for plugins
Date: Wed, 28 Jan 2026 17:31:30 -0800
Message-ID: <20260129013134.3956938-17-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260129013134.3956938-1-pierrick.bouvier@linaro.org>
References: <20260129013134.3956938-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1033.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 32bbd30bb9f..aa35b8273c9 100644
--- a/meson.build
+++ b/meson.build
@@ -77,7 +77,8 @@ python = import('python').find_installation()
 
 cc = meson.get_compiler('c')
 all_languages = ['c']
-if host_os == 'windows' and add_languages('cpp', required: false, native: false)
+enable_cpp = host_os == 'windows' or get_option('plugins')
+if enable_cpp and add_languages('cpp', required: false, native: false)
   all_languages += ['cpp']
   cxx = meson.get_compiler('cpp')
 endif
-- 
2.47.3


