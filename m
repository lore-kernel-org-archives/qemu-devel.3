Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5840BC3271E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 00:35:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPWug-0002t7-19; Thu, 04 Jul 2024 20:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sPWue-0002rs-23
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 20:34:56 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sPWuc-00006p-Gk
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 20:34:55 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1fafb9a33b3so6132245ad.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 17:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720139692; x=1720744492; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XfhwC1XNHeRrJpRL3CXnBSOq4oYvCsk8gfHdkEU9ETU=;
 b=LKHsSmpVGqQmb7c5a62/3YCI/2vCLcWGmCuUmOOodrUs8fVj9i4Rnw0ty00UmbHG29
 T5R05bYmahvxHdXpEfQnHf/oCvOywUCKZnj7B8HrJxNJjIR/r7ugzqfXwjLWxW+7Bp0p
 AXvDt1T/sf3OrIHNvsgbgMb+winczjXXJUutK6TD5EsQd0HBJGzg/jWrse8Pyupu7AXi
 HIyJBEbXQnwv5Pn3Jc6XzBJyzwzhI/G1M1PNIqLhz4BKB2+cTNHk1aAHk0YfumHTL1jO
 lygKNdylwdUZ9XmYAlwHri4VBzNMrtdbugZQQ3XwC7lS1sVL2AuvOGk48TYL9B7VyOVe
 onvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720139692; x=1720744492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XfhwC1XNHeRrJpRL3CXnBSOq4oYvCsk8gfHdkEU9ETU=;
 b=nm8rvXlrBVVdgiLsKaWFh80b5eKYsIFtrysLD1yv/nSvxsrIvgFoKJGIR1lGNvGmZU
 xbcPG1usL4t04TezuCI68pVEGsuFmU8w6cd7cp/6Oqd5g3Bs9GXbisCwzvvo+ViViIHu
 YCvPtoy22nq7nq9oNLESmvI7/Ul9fdmfgAK4D8R98BwlRTg3xbcaLOJlN0LEJZdAEyU6
 +0MAlxfIdkzbBd/sppDdaKKbE92CHjz6g5VMAYFox4yXDpzzInl6mfUsj0lEXT83DqsO
 cZuPOiBMW1B54KvaiaTGqGUDBMxd0VFAYB0AVzN2skomzWyTXQffPMxW80IGmFjqxTdr
 AW/Q==
X-Gm-Message-State: AOJu0Yys5VOtNeu0HIjrWEWyqQUXFFlDzPBqBsJVE3dgySWe72coXGdp
 v4l7Z4/jtoq6NehcA8LX19EzuaaL8aN6fomZN2Kl1IFm7EIkSCqMOl5Myflv6njB6VWlYSvn/tS
 oGNE=
X-Google-Smtp-Source: AGHT+IHVLAmMO92y4lMsZPKjEm6oGwYVZP1Bz/w0L5xy9NvsS4mvxgZ+yM1oihFWK+WLSPaDI/DLug==
X-Received: by 2002:a17:903:2349:b0:1fa:8f64:8afd with SMTP id
 d9443c01a7336-1fb33df595dmr21259635ad.11.1720139692552; 
 Thu, 04 Jul 2024 17:34:52 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fb1a075616sm39008595ad.15.2024.07.04.17.34.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 17:34:52 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xingtao Yao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH v5 4/7] tests/tcg: add mechanism to run specific tests with
 plugins
Date: Thu,  4 Jul 2024 17:34:18 -0700
Message-Id: <20240705003421.750895-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705003421.750895-1-pierrick.bouvier@linaro.org>
References: <20240705003421.750895-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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
index f21be50d3b2..dc5c8b7a3b4 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -152,10 +152,11 @@ PLUGINS=$(patsubst %.c, lib%.so, $(notdir $(wildcard $(PLUGIN_SRC)/*.c)))
 # only expand MULTIARCH_TESTS which are common on most of our targets
 # to avoid an exponential explosion as new tests are added. We also
 # add some special helpers the run-plugin- rules can use below.
+# In more, extra tests can be added using PLUGINS_TESTS variable.
 
 ifneq ($(MULTIARCH_TESTS),)
 $(foreach p,$(PLUGINS), \
-	$(foreach t,$(MULTIARCH_TESTS),\
+	$(foreach t,$(MULTIARCH_TESTS) $(PLUGINS_TESTS),\
 		$(eval run-plugin-$(t)-with-$(p): $t $p) \
 		$(eval RUN_TESTS+=run-plugin-$(t)-with-$(p))))
 endif # MULTIARCH_TESTS
-- 
2.39.2


