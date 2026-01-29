Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D01D73E80
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 17:40:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlVyV-0004tf-MF; Thu, 29 Jan 2026 12:38:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlVyU-0004sl-Ao
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 12:38:34 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlVyS-0000gR-NW
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 12:38:34 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-81e9d0cd082so1020373b3a.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 09:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769708311; x=1770313111; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OEbiu3ITH77U1iqg2asi27fIJJqEuaVmbpyfWlkTbSg=;
 b=NE5K/Kgfsrxg3o9DmgJ6MRWZtIEzSZGJ7MdtI7whf9zidu2WMnW8PGQd//s5K8GZGA
 De4wOM6QrWSWFtTKDN606ncBBKf+nrE6AfcX/ivTKPyPe/hc71oLarc73g7sGpQWsj67
 04/1xj1SNZSI+W98L1+q6dEuRep0URvATIM8sEUB03VlS5y0vK86VyJIyh3gXWP+dKwB
 nEK6Yo4MP0vkKRbc+vwdmm/nxEKdEg978TSDjhdSZ7R/39RRrDVrgSZqxNX6biCSsnh+
 JvhSpzAjano5i1EKarXGvfzmGU+vJHiZ/uFshhrF+xN1+F3rlIcVURATAFMqs1RJrKhy
 qYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769708311; x=1770313111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OEbiu3ITH77U1iqg2asi27fIJJqEuaVmbpyfWlkTbSg=;
 b=kpHWWGXMzKtUo0Lq2yYyjzipBkoBZTVaHrX31Rvz7CEDI/eKEtMPkpZx4YHOWtwFvE
 e3u0g3XH3cOHy2lXrz34YtkQM4s85UrtpYYFxIEBTHyoDuqj29trLnQSWJHyiHk/m7VC
 ACktsoZftnCqnKtfTzosEz3aQbRS1tgzDfHBGnvse8cvlxoIimi4x1I9BrPHLZVlMoqH
 DEaimOxwdDXbe9lFE8fHh54MjP9RWapz2fzeVaOwt7SMi91iCnxVYElJKneZghRiAhLS
 AIVbUXbEcKuPBneWmYciTJKUWtoBSpMu8bNhEL3jG73mjODsgDumuIx32vd5VolLmtgx
 cuZQ==
X-Gm-Message-State: AOJu0YwxTE4wqioNK+iZIs9McnbFAICwOQLmMvB2ASCFtePnWtPGhrjE
 +bd+xwMcioNObkjKfWkfvGqpkm+bLBYhYG7zMjLnLSkSej6t1VuTdqW3K+NY/tpLuAInfFNSSsN
 5y1Ab
X-Gm-Gg: AZuq6aKXIhAM3/ffIhf6DYwqet+n1NOC5F3VPAg24Zj1s3y51tJ1UPG82amKP+taxIK
 HgV61gxL+BBakoti32JRl7qAnqK+u9LApkKL/61ATU0o5P4cg8XDXcoRvjEQfnjSQyOdymLJq4o
 Btra2yXRYlDRFHUQVip9iY8kbZuOO2h8vH0/hfVcKHY0WvUr0lW4TYXfbYnKASGU6jYQXjIVrGZ
 DTyrx6IaLM+uVXMTQAB+PLiU2c869tsfIWaPbmTIrVwPv2OxZbp+0cDgkd/BRYE4HExBTmYRIzd
 XcZ1qTbmMMdkgwd+D2pZ6VJlZ8+P6ccSoxYyikB4AUqt4VWZgnapTLMduCpJT5T/uiI8fbnb3P3
 6iPW04icHxd4DzTtBDG3yNHTq6ZAtq9QrHHFNt6SKzm7mWVUUkh/boWNevOC6OFe9urdo6+KjlF
 qdkBgp44Yb6p/UnOGa2ftUW3bGKkRRV8Dsd1awaXptnTQ8ZXNpUl+lnZcIANQGLuT+
X-Received: by 2002:a05:6a00:17a0:b0:823:1580:7914 with SMTP id
 d2e1a72fcca58-823692d2efdmr7982192b3a.50.1769708311053; 
 Thu, 29 Jan 2026 09:38:31 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379b222f1sm6706246b3a.7.2026.01.29.09.38.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 09:38:30 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 17/21] meson: enable cpp (optionally) for plugins
Date: Thu, 29 Jan 2026 09:38:03 -0800
Message-ID: <20260129173811.138036-18-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260129173811.138036-1-pierrick.bouvier@linaro.org>
References: <20260129173811.138036-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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
Link: https://lore.kernel.org/qemu-devel/20260124182921.531562-9-pierrick.bouvier@linaro.org
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index ad8550d9e97..149655058a9 100644
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


