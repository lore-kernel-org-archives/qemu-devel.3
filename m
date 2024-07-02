Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BA69C3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 18:47:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOiV8-0005NS-W7; Tue, 02 Jul 2024 14:45:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sOiV7-0005Mv-EJ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 14:45:13 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sOiV5-0008Il-2e
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 14:45:13 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-656d8b346d2so2690117a12.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 11:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719945909; x=1720550709; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iz4DsSP3yw8VYMirhIY62MVce7Yg4FT9eLfXZZ6t1/g=;
 b=z1iYSk7csNIHp0dvFoNlqnPOPSqp8ol4HxcYrzXTSirPWjQOHioHj2yZJhELyh0O3a
 MozVbtXcPsqymJkuxoc82vbTgviaAq8SgUEJ/pnAFdoyM6NUplSNH0OKWWyf7XXAW86S
 t7Mz2bSEt7RqmDsbvvZiG1m9xFnnsVOkiqgSkywtRQJPmvvsVTaW6A3gKDS5A8XiqCM/
 4TrMzdMC5GESRLcnAu9NVi4Qf/wwT+uwKevu8znslBIvMeZfF8tNYrpsJ37vkVc61mx/
 w6wTAL556tclX7i3viGzSELDrRmkywY/PL9cm5jngn/EnGn7ALPE3DDrTU5Js5qfJQHT
 qGAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719945909; x=1720550709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iz4DsSP3yw8VYMirhIY62MVce7Yg4FT9eLfXZZ6t1/g=;
 b=ClMEQRDl4qPNIlEBozuE61zbvpUwekAj+K4Dr2kXRhkwC2XY6Bz5m0QI/b7qPxi8xA
 c7ya/4sC/4OdfSFU7eNhq8xtOtvE/ROaR/3gCHXUndpELPls2nNfAdaTJWsTLZXaaRX8
 jeec0Msek5KtlqSenZYfiRtM/RjGsgRve6dheZ5gyFfMKr1YBAO4jN11v6RGDiWjMFwE
 g59irMP1x6KoSW4eJ808eI+DDb8/jejyBQapNGEqAXMZ3Ngfv5QuylguoEOPMXqeyFMK
 suos7K0HDsbzJh6mLoC0wi/p2A2bJDi8hKipkZV24AypzF5LKA+WNr0fnSzULB5FyyaR
 zzug==
X-Gm-Message-State: AOJu0YyLYLWkyOxsk9vH52XGGvxXsGz1FT4xGv1eZEzYUc3SkALhE/jS
 q4rKfEDXL/xQN5XY9QphTnTsv7KYr2fSsI6a4wSnX7yNaca6qOGAoqkGrQ0jYsHWURY1VYUJb8p
 k
X-Google-Smtp-Source: AGHT+IGkAp1OjX22Sdgm1lxeHSGzm7/x0rKNl6fycwpp8soZxXPgNYFoS5u9nJAh1EX7FBNpNut+UQ==
X-Received: by 2002:a05:6a21:3418:b0:1be:c747:5925 with SMTP id
 adf61e73a8af0-1bef610e1b8mr7911444637.34.1719945909064; 
 Tue, 02 Jul 2024 11:45:09 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c91d3e8196sm9257394a91.49.2024.07.02.11.45.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 11:45:07 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v4 4/7] tests/tcg: add mechanism to run specific tests with
 plugins
Date: Tue,  2 Jul 2024 11:44:45 -0700
Message-Id: <20240702184448.551705-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240702184448.551705-1-pierrick.bouvier@linaro.org>
References: <20240702184448.551705-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x536.google.com
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


