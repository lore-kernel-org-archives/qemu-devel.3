Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1931AC3DA63
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 19:48:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWhxp-0002rl-5K; Wed, 24 Jul 2024 15:47:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sWhxT-0002Mp-AK
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 15:47:32 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sWhxP-0006EN-Ro
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 15:47:30 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-75cda3719efso132798a12.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2024 12:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721850442; x=1722455242; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+j9sJHB0Lo/GF94SvaQm8cB9R2pRnCy0qVL4JtOTVWo=;
 b=nikXFVe9W6oYdB9Kh8hjGFMXPPRljFcR9tAIYbOhiN2WOiLV9GNzDREuCY/FceYJ8a
 BGvQ0bSRB3SlnEJLi/fii6DQ8TAhGXa1cinsy9h06hb3d/iBRstezz7AzDRvDsxoim8F
 NR5r7l9VsR4inxlCdFcVOr2kiwHVRR1HjB4ysxWAq1ju0C7HHCoSyfM0ozeyf9opdZ3s
 BBaCYEvOrHYtkNVxvezqiqH2mRj7W7YrrPVadqOY3j8bAxW2o6+ICfN+1eM2UJHwVH/f
 DxAAQKSUhBocnNwl9NXGlCWtRy83OhJr1mWJGyUKiqoFZpxm4hhvILc5tx/jJV8XnTPf
 Im2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721850442; x=1722455242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+j9sJHB0Lo/GF94SvaQm8cB9R2pRnCy0qVL4JtOTVWo=;
 b=PJi3qBHMhVHV/9hsKMMBMrYyYJq5Hc8boSuuHMHyx16WLdWralhheBdQzrPjTijaLV
 nyXhONOLlfWy5hcziciF/ZVKgWjPrZkO+iTv5nFukWUHNCKD2ysI0HjMIxEKmaJdHdI0
 3Gu1UwJdPUJeBKolFaxhQKPRtjcZMATP+gvTm7IjwY2cQ9AN3vGtsQrFTe/4U8MUFs5H
 VRHV6VcaR6ZOFIgnpojgnseO14g8C7wibQwz4HcgO5HjcKpu++d+aUI3Ra7P2t53iZZv
 RTlQ4a3jxPzwdbkKhCEG0V5a8/JFpWU7PLL+a5G1cMpTWT+M9nmU2b83JR308sHtd/f0
 xMKQ==
X-Gm-Message-State: AOJu0YzNNmsRbdxmMOvLddLrPWdLCCO5fime5E9GPX9L8r9YpFqTBYP6
 uVu2jh7NeMKK9VF0Z0drulvdU9DTPIs59qxLTPsoGuKXBT2BSQsU/lbzO8jyrp+Sc+KkmRY5X36
 8N9w=
X-Google-Smtp-Source: AGHT+IENGewlfhepymd6t1vKcorSqDDKoH3fliZ5uPrjaobpZyYHr8MF/zoyG3eHjmT4lfBest9Cmg==
X-Received: by 2002:a05:6a20:2584:b0:1c3:b231:33f3 with SMTP id
 adf61e73a8af0-1c472c8ddbfmr1051931637.38.1721850441960; 
 Wed, 24 Jul 2024 12:47:21 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::b861])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70d19c52a62sm6339116b3a.124.2024.07.24.12.47.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 12:47:21 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>, Zhao Liu <zhao1.liu@intel.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Xingtao Yao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH v7 4/6] tests/tcg: allow to check output of plugins
Date: Wed, 24 Jul 2024 12:47:06 -0700
Message-Id: <20240724194708.1843704-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240724194708.1843704-1-pierrick.bouvier@linaro.org>
References: <20240724194708.1843704-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x529.google.com
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

A specific plugin test can now read and check a plugin output, to ensure
it contains expected values.

Tested-by: Xingtao Yao <yaoxt.fnst@fujitsu.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/tcg/Makefile.target | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index 197d3de950b..7cfbdead0bb 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -90,6 +90,7 @@ CFLAGS=
 LDFLAGS=
 
 QEMU_OPTS=
+CHECK_PLUGIN_OUTPUT_COMMAND=
 
 
 # If TCG debugging, or TCI is enabled things are a lot slower
@@ -180,6 +181,10 @@ run-plugin-%:
 		-plugin $(PLUGIN_LIB)/$(call extract-plugin,$@)$(PLUGIN_ARGS) \
 		-d plugin -D $*.pout \
 		 $(call strip-plugin,$<))
+	$(if $(CHECK_PLUGIN_OUTPUT_COMMAND),				      \
+		$(call quiet-command, $(CHECK_PLUGIN_OUTPUT_COMMAND) $*.pout, \
+		       TEST, check plugin $(call extract-plugin,$@) output    \
+		       with $(call strip-plugin,$<)))
 else
 run-%: %
 	$(call run-test, $<, \
@@ -194,6 +199,10 @@ run-plugin-%:
 	   	  -plugin $(PLUGIN_LIB)/$(call extract-plugin,$@)$(PLUGIN_ARGS) \
 	    	  -d plugin -D $*.pout \
 		  $(QEMU_OPTS) $(call strip-plugin,$<))
+	$(if $(CHECK_PLUGIN_OUTPUT_COMMAND),				      \
+		$(call quiet-command, $(CHECK_PLUGIN_OUTPUT_COMMAND) $*.pout, \
+		       TEST, check plugin $(call extract-plugin,$@) output    \
+		       with $(call strip-plugin,$<)))
 endif
 
 gdb-%: %
-- 
2.39.2


