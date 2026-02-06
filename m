Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F77EE6B43
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 18:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voQCq-0007wr-Oo; Fri, 06 Feb 2026 13:05:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1voQCp-0007wA-GB
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 13:05:23 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1voQCn-0001Qc-Ld
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 13:05:23 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b883c8dfb00so406095766b.1
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 10:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770401120; x=1771005920; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/u2G7YhxydUQhovvt9K1SlozqbVhhSVq7MznkHBatLo=;
 b=FYu3+p46WflAUVJS0yv7ME2wuUt/hTvUlq3TDFOltq/GyA/G1tbXRt7RAInseHsWIZ
 BpiIIfq3Wf5NKo8MAtUekEkGVLdlb23LgNT3gNsvGK/2aG8CJPeBBzBAwAxDv7QlxOdO
 oyL0wWzGnwJLONC9P9Rg8j9IAmueMCp6k3+Jll0IutMtgEZ75uQfpc/UACDYBlHXbCTo
 yYBAVLSuefmx1pTjW8LPcp5rejfGd71Jhyllc1UhGtxQh6pjVqVwZZqeUw5ymfbd3yst
 7db4FvRIZYlvU12gJ1nIdLpXT8TZS3x2JYHrVxJJ8ysWKpGhfsBQiJSF5x+dkx1iEdEv
 aqww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770401120; x=1771005920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/u2G7YhxydUQhovvt9K1SlozqbVhhSVq7MznkHBatLo=;
 b=Aj6BV3jTcBiF0cwXvNzLguijySlZbfhXXPYKkLoppbvSQXGjKbxiOyHCpwQtX5FQbO
 NphZao+85vZ4g5qTkkg40j3yd45R5M38gMY1fuHFp9jMF0iZkGfkedLqtXYu/jpO1SZH
 H/gmiB7qBUz1oQomwRs74cuJwc/ypDvn4QRUaYxxy2ZA1a7OT/ynOUsqpnJjVsUfWyPC
 cdpY2ZHf7KLSphKIADr7SCFlSGI9MHM/LszW1c4tn4U8hjvIBxYh1S7ghODFvBxNaErk
 kkoXZZrhLVvI6w26cFKP7S3/Uu6FQttlVxUqJ7N5Vx1yT3zJ8isTHqsH9qVQcMxpVbin
 lElw==
X-Gm-Message-State: AOJu0Yz//xzanCR4iWHThyLNNaZkZrdxnxliZyHpfA4R6hSVdWBXkgH/
 uLNhlkoYhijeozxqGQQS8ynJDFlmA8EZwdzcgSe9LU2Gh7j54if/jHiPNIBaRTPVMY0=
X-Gm-Gg: AZuq6aKVnz/bmRrLSvvq8wMcEmSERDYTO+tL4C0OGJ3ciYoea6XIDqir5rRtpJ66fuj
 Dt2Is26fSzagOdHzoFaZIKgYcx1CQGK198HjZZOhp5vxuKd2vIbTsroOMYd5B8jDs2+TlKA+Nrx
 wNFRromuv1ddKvTChm8lhK/4cp6ckZNJHPUY31X/KLOpV+nFq2/k8tk8e33J4CyclPmWCFQgssJ
 eezTezRFouQ9JXTapZ/NHm/GK2znnLlBeo8psmADGZjXoNdhWbuRiT2mo/9aj6ZXfnZLAVsxv4m
 uZEH+Q3M+fR5un4fL6ik/jUSIQqZE3GaKVfsWzhKyyEeOzMptwxaFmUnd/j8NimGTMOVcWNhSRX
 KKHWI+HmcKU3/KReYf4FSkTx5SWxJFR+3E+jnb5WL81e/kS32zaKbKQFthBC+nFZ1BnMCymjmWT
 VOut5djjKwPxs=
X-Received: by 2002:a17:907:980f:b0:b8e:12fa:ff2b with SMTP id
 a640c23a62f3a-b8edf37871dmr224047466b.37.1770401119589; 
 Fri, 06 Feb 2026 10:05:19 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8edacb18aesm100055166b.41.2026.02.06.10.05.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 10:05:18 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EBA2D6077D;
 Fri, 06 Feb 2026 18:05:17 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PULL 02/10] Makefile: add python script dependency for
 meson-buildoptions.sh
Date: Fri,  6 Feb 2026 18:05:09 +0000
Message-ID: <20260206180517.1335861-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260206180517.1335861-1-alex.bennee@linaro.org>
References: <20260206180517.1335861-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
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

If we update the script we should also make sure we regenerate the
help text.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20260203115201.2387721-3-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/Makefile b/Makefile
index 9fb55dcf330..54547a37b1a 100644
--- a/Makefile
+++ b/Makefile
@@ -130,7 +130,7 @@ Makefile.mtest: build.ninja scripts/mtest2make.py
 
 .PHONY: update-buildoptions
 all update-buildoptions: $(SRC_PATH)/scripts/meson-buildoptions.sh
-$(SRC_PATH)/scripts/meson-buildoptions.sh: $(SRC_PATH)/meson_options.txt
+$(SRC_PATH)/scripts/meson-buildoptions.sh: $(SRC_PATH)/meson_options.txt $(SRC_PATH)/scripts/meson-buildoptions.py
 	$(MESON) introspect --buildoptions $(SRC_PATH)/meson.build | $(PYTHON) \
 	  scripts/meson-buildoptions.py > $@.tmp && mv $@.tmp $@
 endif
-- 
2.47.3


