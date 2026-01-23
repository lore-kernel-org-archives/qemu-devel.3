Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E60D74EDB
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 14:59:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjIbo-00047o-JR; Fri, 23 Jan 2026 09:58:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vjIbm-00046B-NO
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 09:57:59 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vjIbl-0007kN-6w
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 09:57:58 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-435a517be33so1433260f8f.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 06:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769180276; x=1769785076; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fFWc0BA+SGP6weEcvHdRzs2ugznt6UDXvEIiUmjHIbs=;
 b=TCt0WIdZyaJgp4vPFxVAjgAqGO3FxUmWd+uiUp3kIpEBA/ZDgdYhiuw7lkpz6WuA4k
 2wt8tfjYJX+Jn6DG7wa2BKC295sYtdLTFVl4+FB90CcfHUDa2ecRyKoUoaUXIRUUTHck
 q4nY6pHMTe3MBZsoQR1GH4AZjXL48FI2NNAnrxC55EqUed/9sVJwYJA/zQGL3ctWHMal
 +N+vSeLjyGxhN/JGUuVZ6l4tzzzh3DuEqOXFUTgjqUzOMemrSlO4IzgbIvzD0MNeDKDW
 NGaxksKgdlj1DtbZ3ELCPkgMnXgSJRK2RlE1s2mQphD7lbejRBcw9rfy8M3E8vuo2+yK
 jfzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769180276; x=1769785076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fFWc0BA+SGP6weEcvHdRzs2ugznt6UDXvEIiUmjHIbs=;
 b=Nwmpraf38EHSBz+vF5XeDoY769Or8QRl0k8fvIxrkxzFqJj6br38f05bhtaqHxj5AG
 Yzz77dMc/c5Zyk3Zj0REYgND1dmIuyYBt/H1VohcMsMeETb7eFVu5cdC8UAGel/Mnw/1
 vWyssuNm2G0s3UI+92doujobwj3FIq9y7Vzo/HWFjqQ9uwfPcSzqPEw8jqgOU7jmQRWn
 39UyLJTn2ct6SRmh3QOcCXtJV/KFcGDsVtdfMz3adSiGQfcbMB09WUhe9rjqnqwgTKtQ
 zP9hZhdu1lZxcaX4+wEhjF95VABq7MZK+3SSz/UfAhehsPcoPgmPzEeo/M6tL4AYkG2C
 b9IA==
X-Gm-Message-State: AOJu0YwWAK3hWFGIP2QBT0Ei2ZDT2fDmzGaMwhbJ636Uyrx4LFDzbbTD
 zKHpnuOApWyQpVHux04tfxo6XKB283rRhfRGiUfl/Tvbtg+xPbYST5rNB0HWkpTsQpY=
X-Gm-Gg: AZuq6aKM1PSkt+KaENoltgWBlbq4gA63ONBb9Biy/5G6n88INtBOPlczzui6/7yHC8l
 MDAQn50eFafgfs1VOrRJ47+eZyD1wSrqrxzOFTFMEara36YQkupiGF8UkNuXh8lXppBy4BBqy3J
 mp8l2VbP2y0VPMskqNJLLuD66HyNtN+bLZwqmlOCOd5jZQ2uE7bKjLIKc4bwoRxo0dk2zG+zXKZ
 sRyQx0y/ixL91OObzyKQdRI48V5FLFGskiRyHRZ3TxgbuMbCptue+7rwTZ32KpX6279x4DiQOg6
 tIfn/3A3PWKMqRirdtiHwfBgz9OWpoMj5ZIJRUjqu9t057QDE/YJ1t1pF8Ef7QxFmnFO4wswv2h
 uy3EUuQPo9VuJsOR3KFrwpNGfoMlyBsRL6VR3cLhT5Uav5KvL/qDQDv59MMEgRRPOcNYbsXhGfE
 ByvIABMbTKqf1e
X-Received: by 2002:a05:6000:258a:b0:431:397:4c45 with SMTP id
 ffacd0b85a97d-435b16281c2mr4952785f8f.59.1769180275651; 
 Fri, 23 Jan 2026 06:57:55 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c02cd8sm6949873f8f.8.2026.01.23.06.57.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 06:57:51 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 959255F855;
 Fri, 23 Jan 2026 14:57:50 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Joe Perches <joe@perches.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?J=C3=A1n=20Tomko?= <jtomko@redhat.com>
Subject: [RFC PATCH v2 02/16] MAINTAINERS: fix libvirt entry
Date: Fri, 23 Jan 2026 14:57:35 +0000
Message-ID: <20260123145750.1200879-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260123145750.1200879-1-alex.bennee@linaro.org>
References: <20260123145750.1200879-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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

We have a particular tag for lists so lets use it.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Ján Tomko <jtomko@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 392100b213b..8b256835647 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4511,7 +4511,7 @@ F: gitdm.config
 F: contrib/gitdm/*
 
 Incompatible changes
-R: devel@lists.libvirt.org
+L: devel@lists.libvirt.org
 F: docs/about/deprecated.rst
 
 Build System
-- 
2.47.3


