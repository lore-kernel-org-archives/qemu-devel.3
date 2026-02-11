Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98776ECD6C7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 17:18:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqDrF-0002tS-0l; Wed, 11 Feb 2026 12:18:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqDrD-0002tF-Rd
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 12:18:31 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqDrB-0007vN-BI
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 12:18:31 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-8230f8f27cfso3412407b3a.0
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 09:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770830307; x=1771435107; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C9wzLg3j9vDm84E/xB6HfGczLGCZB46y1PKYx4Uz5p0=;
 b=PistyEIrKqyawEK7RbKi0SGyaJMzxsxJr/5BYnjmibutxo+ZivsBu7ffng2ynNw40E
 Aadg95yL1pVWCIuVz7fWGJuoWBN8syEN9c7l2xC9pSuGuCMqUL56s89MMKlVy8rTLKvg
 +8lhFbrHNv4bWAzGm0SrfUriW7Pd0MYxW33ZM/2IP97nzWZYPEn7kGUYGTVzHZsrSEHA
 3mA8f1Ed/RXsXWoVl4zIqTnqaAyhSwZBNxICKFkW4KtV/a3oZyxJoAIZiMXUhpXBLZVW
 9G9yNKv69Vw8k/QBxIsUvGxcKGvLfWSPjryFAIvwP+RRLRraBJ5qhTQhAFr2CmwRfEl8
 bfBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770830307; x=1771435107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=C9wzLg3j9vDm84E/xB6HfGczLGCZB46y1PKYx4Uz5p0=;
 b=fUrqLDK0AsJpBkrA8ZKomXWR1Yp/4d1eeabiC2aDKapMS4IJ87HW1HW0kXTDDlPPPt
 GQAXfaGr/pbXTBvdbF7tFGHD3cZ/66w7RsU84dIQ64QzkptRfyRFEh2sfr0cVYnA3BuU
 R6otlYS1vhvrAy3RiQWZH3Lld1f6E1SYCqZ1bsISQfn6Cc9sE3cE4K5yYmZFgtNsVz4q
 RMmJ0NsNDSk/0Jlng0QwbtMJqKyf32LbbdIn2ZZYiDMMiZnBiPAzwX8ULotuJP+cmllU
 DrVT3NZe55oNMsU5xGso9HgsjM9wV4nbjHuDz188cyGE5rFOWPFn3V2IXRr0sAJWEFl2
 XhqA==
X-Gm-Message-State: AOJu0YzDvtt2PBLOHzRFVs30DAeaQAgi8SIb7ff9//v4MQe19fSG169n
 OlsErp2ovuTTaYpmDywJd7Slef63e7R5x5LYS2sqdLOPzrcvTb5uc3jsumGaIiPDBmdfqfdOBYF
 sZAwv
X-Gm-Gg: AZuq6aJr/KCgE9SzN+6epb5U6Ej1k9IjTovCEG4BrsPlrJBkQ09Sozhv9m5qfFgn5dC
 EcX8860MWNAIPuWu0M9eXtg09GEBQ0zyuuorU+gaV3WPRFy7/gWqSCqhZWdztjYRTWJI1IUZoqL
 xmDNNBL5SSyX8vUoYP71VOEA1mJBs5pJ35O6ORX6wx+v7uxDhemp7Ytm1AWuUAMaOdM5YsiO3IZ
 Q+C8Epqab8hfQvPTXjTT6lplFhGCV4XoGv7mlUXeC89JTNg3BsQPBfJaLaUK2yDEsOeH9UpSSPo
 DYlRgieK5By5uMUNaxwpIUeIJGAMvkJAD02Zhi2fSo+WGfZLbyPo9KghLAdwQc15ghOlIKy6wdT
 nHsw0K74Wzyx3yZEA9DByKjgsn6/VZfsoMi86mA7fjd9KwIPu4PeBrqi7c3stf/sMsbr0yXsCWd
 dCF/749npWWiMPat7LZnaSEeQW+Dj5kkbbaM/pyPQu1n5Rvv8CQef5VSDH+9tdYbxQW8/ZTQAQ4
 3kiCmUMF3LA+pA=
X-Received: by 2002:a05:6a20:914e:b0:38b:ecae:6718 with SMTP id
 adf61e73a8af0-39447b66f39mr52783637.0.1770830307436; 
 Wed, 11 Feb 2026 09:18:27 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6e197f5e17sm2730459a12.25.2026.02.11.09.18.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 09:18:27 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 2/2] docs/devel: fix bash-ism warning for configure
Date: Wed, 11 Feb 2026 09:18:17 -0800
Message-ID: <20260211171817.3089906-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260211171817.3089906-1-pierrick.bouvier@linaro.org>
References: <20260211171817.3089906-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
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

Hopefully this makes the meaning clearer.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260114101525.4039244-1-alex.bennee@linaro.org
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/devel/build-system.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
index e746bf81873..71331e64ac8 100644
--- a/docs/devel/build-system.rst
+++ b/docs/devel/build-system.rst
@@ -66,7 +66,7 @@ Modifying ``configure``
 ``configure`` is a shell script; it uses ``#!/bin/sh`` and therefore
 should be compatible with any POSIX shell. It is important to avoid
 using bash-isms to avoid breaking development platforms where bash is
-the primary host.
+not the default shell implementation.
 
 The configure script provides a variety of functions to help writing
 portable shell code and providing consistent behavior across architectures
-- 
2.47.3


