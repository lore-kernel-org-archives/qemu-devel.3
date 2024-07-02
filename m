Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A9C8C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 18:47:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOiVM-0005PI-Er; Tue, 02 Jul 2024 14:45:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sOiVK-0005Ot-GF
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 14:45:27 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sOiV6-0008J4-1o
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 14:45:26 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2c967e21888so531644a91.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 11:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719945910; x=1720550710; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tJdBX9SfhlJKk9rWv11IMwaEBO+AoHCZIGuGx9ia+J0=;
 b=yTbia0WxbRRxv42sLPJVzB23n027oiiCBauISbr1HA3zh04r3WllNyyhDQ/EK5XzLr
 4+5M79k8VUsqXScCQ8yvpfbL5RBNZFF55f11dsVjGM9N6qxQcBhgQKqSLBPoW3DRLItQ
 QgDqWkoVgcpze6sz7GeqTMPfhqRp0n0l0sdLwLRvR90oEn1j2Yz7lpvJL5wraLCEov2a
 Ox+6hI5jux75v2Yw2BDiN6H+pKzc/ZV0a4o8PO/HMOWycpMXiij6NGy5LHeSfuY3ttme
 w65+O3ine+mbsuplE9aUH/YvR3bfyV937qCsq6gOGaYJg0y4/a/Gb4441V3tD4cAcD31
 z0ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719945910; x=1720550710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tJdBX9SfhlJKk9rWv11IMwaEBO+AoHCZIGuGx9ia+J0=;
 b=nVKBPHNyVHM7b/tOkb1qLuF5Pr7iEIjCZZLtJgGFuGjHqLEEaAtarA5bxwrNu2a5Oh
 rsq98GR7j9CBCN8blg9OD7ntHzfaa+738EAQKZiAkA631KCacssO5300Lq5wUAAZMFA3
 IFuvYCPFKQAEo7yXdjFZCVHvSV2/nZEiJOUQ0F+NJX7F0CXI9ljsk3aG188GbJoiTtgL
 wxVt3JSmiXKQJ9hzAtjv0Lg5YO/u17Eg1JTn7HfRYyL+06wF1xrPCGHxCiVh1WrgVqGZ
 cgcXeg9Jl2uBgHSkFiK1bfhoeJEP0dB+12dSkXN2s8LwqvxpQniAm6gLvd++DHcmh8fP
 5GxA==
X-Gm-Message-State: AOJu0Yxf0Z18TMyAiC5zMnooYJCWUuddqF3CndSq1q2AT12uyZUCzJTS
 tiv0MnBZqNwTRe2HhTKRDEZ9YOtq3HzlB5ld8EtA/AdP0BbvO7Pz6vXRM0k3mSmmabOiQS8n2rG
 M
X-Google-Smtp-Source: AGHT+IEEQZ3/fLu8wcrstlNBq7+7mxdVT8GAMKS3fDARa2oadCzW03qx25WL8ZAylEF1dwI5Vsq2JA==
X-Received: by 2002:a17:90b:1807:b0:2c8:5129:417b with SMTP id
 98e67ed59e1d1-2c93d77600cmr8339040a91.31.1719945910184; 
 Tue, 02 Jul 2024 11:45:10 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c91d3e8196sm9257394a91.49.2024.07.02.11.45.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 11:45:09 -0700 (PDT)
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
Subject: [PATCH v4 5/7] tests/tcg: allow to check output of plugins
Date: Tue,  2 Jul 2024 11:44:46 -0700
Message-Id: <20240702184448.551705-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240702184448.551705-1-pierrick.bouvier@linaro.org>
References: <20240702184448.551705-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

A specific plugin test can now read and check a plugin output, to ensure
it contains expected values.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/tcg/Makefile.target | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index dc5c8b7a3b4..b78fd99c337 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -90,6 +90,7 @@ CFLAGS=
 LDFLAGS=
 
 QEMU_OPTS=
+CHECK_PLUGIN_OUTPUT_COMMAND=true
 
 
 # If TCG debugging, or TCI is enabled things are a lot slower
@@ -180,6 +181,9 @@ run-plugin-%:
 		-plugin $(PLUGIN_LIB)/$(call extract-plugin,$@)$(PLUGIN_ARGS) \
 		-d plugin -D $*.pout \
 		 $(call strip-plugin,$<))
+	$(call quiet-command, $(CHECK_PLUGIN_OUTPUT_COMMAND) $*.pout, \
+	       TEST, check plugin $(call extract-plugin,$@) output \
+	       with $(call strip-plugin,$<))
 else
 run-%: %
 	$(call run-test, $<, \
@@ -194,6 +198,9 @@ run-plugin-%:
 	   	  -plugin $(PLUGIN_LIB)/$(call extract-plugin,$@)$(PLUGIN_ARGS) \
 	    	  -d plugin -D $*.pout \
 		  $(QEMU_OPTS) $(call strip-plugin,$<))
+	$(call quiet-command, $(CHECK_PLUGIN_OUTPUT_COMMAND) $*.pout, \
+	       TEST, check plugin $(call extract-plugin,$@) output \
+	       with $(call strip-plugin,$<))
 endif
 
 gdb-%: %
-- 
2.39.2


