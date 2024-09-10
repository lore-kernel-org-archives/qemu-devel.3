Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA2DEDE9AB
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 17:21:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so4Xv-0003J7-EA; Tue, 10 Sep 2024 13:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1so4Xs-000381-Ix
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:20:52 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1so4Xq-0002mt-S0
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:20:52 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2da4e84c198so3918050a91.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 10:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725988849; x=1726593649; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZdzqnkrHvupdQDomTwNQx1ejBlR6veO+3YPCqZfdKWo=;
 b=bqZi9HZGNZ4hijKZCvyC2vaOrnFkx3KTMpliQCUqDruuzoBZgNmpqHXpQuPFFtBOV7
 CRpgd/oi+3KW1HybucZLZrRiSfMRPxHJk6aN4v/w/H5jwcJNIHUZflrWDTWYYODsUPvS
 0/heaLaQdCguTq4/MzQtTtJLq0sx2sgpHUM6lzhLhxM4AVT9njFlAUc8csUBk8yFWd0i
 /lScU9KBeVOtpqJp2j0/mlEX/20vFe/jmJz9Fn6IURHnAIh6KJ+Mb12CWdRtbkp1noVg
 Ff8V+/cN2C11N+iXp2ky/ny7YDlvDayaLNOT9SE00jBNMQh/pkRw7/zRU7xEf2uqyZPy
 8Vyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725988849; x=1726593649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZdzqnkrHvupdQDomTwNQx1ejBlR6veO+3YPCqZfdKWo=;
 b=nvgzP6Oe2WBwxxm8j7MSzds+yf+aMo9dc4XBa/TTPjpHFqHWcMWgzAos2xmOquh4Id
 7iZh4uov29DOW6hzE/ng5ZkSf7it4EnxWaInknnEdN4d01vjzXfV/XVA2SCf/rQxZpWx
 4F2jOm+aPHlBJDVF7FEm1Gr92S92AdRAQswtspP1Nn4foXZvkxA9p47C1VfWKot6sQrs
 pvLzeDnGKEfbGNEKuptpwIz8hdmNNleu0DfPW6bJ2hHGKThNd0aPXzOXZA00e4g6k0EM
 CHs4WfoxskzuRNcBF4OjFBknLXpzLY/qWb9yLK+taFrIzuIFAmitj0S2OAvyXsJvEUOQ
 BvWw==
X-Gm-Message-State: AOJu0Yw0CryNkxJZ/GM8wuVi0eWiH14XZ8codfR1l0/twR1kKQwt+BEO
 nHUNcxtIfE0lQs4ZY2KWgJ1S8zFXciDfOaAq+AM0bqCcD5QRDGfjeBZiqJxajcgKY6mFTRiiKFD
 7ZP1b5Q==
X-Google-Smtp-Source: AGHT+IF4rlCYDS5RuBM3ACzm7dzmL3YNkQWf0NsFoygzA6vAQf+d03B2fSuhGDXB/Pqrc5dc9gVwCQ==
X-Received: by 2002:a17:90b:2644:b0:2da:8730:5683 with SMTP id
 98e67ed59e1d1-2daffe292a1mr12681232a91.39.1725988848970; 
 Tue, 10 Sep 2024 10:20:48 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::9633])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2db049883e5sm6685310a91.50.2024.09.10.10.20.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 10:20:48 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-ppc@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Xingtao Yao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH v8 3/6] tests/tcg: add mechanism to run specific tests with
 plugins
Date: Tue, 10 Sep 2024 10:20:30 -0700
Message-Id: <20240910172033.1427812-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240910172033.1427812-1-pierrick.bouvier@linaro.org>
References: <20240910172033.1427812-1-pierrick.bouvier@linaro.org>
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

Only multiarch tests are run with plugins, and we want to be able to run
per-arch test with plugins too.

Tested-by: Xingtao Yao <yaoxt.fnst@fujitsu.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/tcg/Makefile.target | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index 452a2cde65e..c5b1c7a786f 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -152,10 +152,11 @@ PLUGINS=$(patsubst %.c, lib%.so, $(notdir $(wildcard $(PLUGIN_SRC)/*.c)))
 # only expand MULTIARCH_TESTS which are common on most of our targets
 # to avoid an exponential explosion as new tests are added. We also
 # add some special helpers the run-plugin- rules can use below.
+# In more, extra tests can be added using ADDITIONAL_PLUGINS_TESTS variable.
 
 ifneq ($(MULTIARCH_TESTS),)
 $(foreach p,$(PLUGINS), \
-	$(foreach t,$(MULTIARCH_TESTS),\
+	$(foreach t,$(MULTIARCH_TESTS) $(ADDITIONAL_PLUGINS_TESTS),\
 		$(eval run-plugin-$(t)-with-$(p): $t $p) \
 		$(eval RUN_TESTS+=run-plugin-$(t)-with-$(p))))
 endif # MULTIARCH_TESTS
-- 
2.39.2


