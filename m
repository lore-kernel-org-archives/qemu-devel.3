Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9580E108E1DF
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 10:45:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3ArX-0006tH-IL; Thu, 19 Mar 2026 06:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3ArV-0006sc-Ci
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 06:44:21 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3ArS-000784-H8
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 06:44:20 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-439c6fc2910so510434f8f.0
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 03:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773917056; x=1774521856; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BvThwtiwpUjEJkcRvRsNM7vqsy4xO9B9B27tJho3O28=;
 b=sMo0whNok3Tqte2vKOf6F7I6wUr1G3xaIVQZDVLnbP0Wad3uj7VeNPYmvNzi8tdOO8
 HXwetD5mJyc2mmStUr5NIwZNzrBcDY/nP494d89dJp2KDQxTlnjqacGjY84ymP75+eEb
 xLwrL6WIAfcop/2sichpz3TgnKuIn4p7nY3ruPCPfsu8kSC+NS9xUVNXyhOsUEsF1E84
 bc8kuxiCP120fjZKIVpKS3B72ar1cjUZ/zd1nQkbALrlN+ydTF5Dfn78grY2MjIh7ISp
 LWXF0Ugc4zhjNM1XEhKlevTRwoL9bpGqjldj56JqaMTjXpKK6MYvKdoBjkOaM93tbPt+
 +06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773917056; x=1774521856;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BvThwtiwpUjEJkcRvRsNM7vqsy4xO9B9B27tJho3O28=;
 b=k8H+LPjIWGmR5Fp0zZtzP0ycR0ZPOpjandJ1me68ysy5xdFSsB0Vpf/KiyrSzmuzNk
 KQeK0TAafuz+W+DqIjMMM8OyXsLIuHxw4pNcNnfuKqSt4lZbTGnLD5h1JY7Ggux9HYif
 5r9zc/uJUsnzyxZvImqs1XUCLHBe/JJ4FNj5CUMuJQ9gWBNkMqKfW7vzpxAerDSp78+Q
 rtlDs92V6SOh6SWeek4xWW2wziBxzYwVWRaHzNk/VLB0Du+4aeJA4AUynoGuJxfCB7yY
 4j2krUHkn7nXgWsapoP6/zlabY9t9u4u6K2zh7Pmy9+kZUcdxE+0PC91kINqkUIra+zt
 15Gg==
X-Gm-Message-State: AOJu0YyqCVkToCfuSBCDLBuS34ZdqDQU6byl9BIDG9UZCyLiaSMxz14a
 /+2dFi10Q6p9Ga6NBvQkgxXLMk5qaixlmR1rYwgZePztxKkr9vHX7DlEfs3hoKlw661J1vmJOAA
 ClJ/qRHw=
X-Gm-Gg: ATEYQzyih011NBXiWPZnt9UGSn/PW9Y7kTuUojcjEExqULFnFFALIe22/cbpk+K7Axr
 d9BTVd6rYlbmGcQTK1qRUcNQYcx4RpRUleRXrsa/z9pGjeDhxZXBsS9EnQBGpkesl8NpLf6qv10
 7AJe7WPHzBeoLavIgIy3+UDejzMuMpXZDLgFSxOKn1Te+S44IH94PPj2sH1Tc4LMAmHasmlza3m
 atHJS+taKMD/gvW8SE5+44EvgHrD+PM7gmL99xL4Bv5VVwX4GYx+mFEnv4F6PpNpXVU8AK3lVf8
 ja6fC/L5Gfs8U4RQPKxxqXBXnSu8YOhn93xmH7SlFlFqvl8Gx19RrlYATLuinCdeEKTwpXiZ6bx
 xa/0XjqQHMBzy6v6wZOzn/x6xvzOUXy0+2KWGKJgJj6468SsZGeSc5fMxNnbKisbSVUmJ74tk9a
 jVadngooJdWQKqAu7MsFA6DaRsmODdVU5vjQXMWHIhLBesVVx1sWBIozk1FnhCXEfLbFnebErnQ
 5oGPwUwZdU=
X-Received: by 2002:a05:6000:2dc3:b0:43b:4aba:8f35 with SMTP id
 ffacd0b85a97d-43b527a8e1bmr12171396f8f.12.1773917056376; 
 Thu, 19 Mar 2026 03:44:16 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b5184962bsm15303184f8f.7.2026.03.19.03.44.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Mar 2026 03:44:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.0?] configs/targets: Restrict the legacy ldst_phys()
 API on ARM / Aarch64
Date: Thu, 19 Mar 2026 11:44:14 +0100
Message-ID: <20260319104414.66367-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Commit d751921cffd ("hw/arm/omap1: Remove omap_badwidth_*
implementations") removed the last use of the legacy ldst_phys()
API. Set the TARGET_NOT_USING_LEGACY_LDST_PHYS_API variable to
hide the legacy API to the ARM / Aarch64 binaries, avoiding further
API uses to creep in.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 configs/targets/aarch64-softmmu.mak | 1 +
 configs/targets/arm-softmmu.mak     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/targets/aarch64-softmmu.mak b/configs/targets/aarch64-softmmu.mak
index 9a20187e2c1..d34aead41c4 100644
--- a/configs/targets/aarch64-softmmu.mak
+++ b/configs/targets/aarch64-softmmu.mak
@@ -5,3 +5,4 @@ TARGET_XML_FILES= aarch64-core.xml aarch64-fpu.xml arm-core.xml arm-vfp.xml arm-
 # needed by boot.c
 TARGET_NEED_FDT=y
 TARGET_LONG_BITS=64
+TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
diff --git a/configs/targets/arm-softmmu.mak b/configs/targets/arm-softmmu.mak
index 35af7da79f2..b235e34a380 100644
--- a/configs/targets/arm-softmmu.mak
+++ b/configs/targets/arm-softmmu.mak
@@ -3,3 +3,4 @@ TARGET_XML_FILES= arm-core.xml arm-vfp.xml arm-vfp3.xml arm-vfp-sysregs.xml arm-
 # needed by boot.c
 TARGET_NEED_FDT=y
 TARGET_LONG_BITS=32
+TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
-- 
2.53.0


