Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F10A1ECE582
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 17:21:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so4Y0-0003fd-SQ; Tue, 10 Sep 2024 13:21:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1so4Xv-0003JH-CB
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:20:55 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1so4Xs-0002nK-5T
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:20:53 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1fee6435a34so9639405ad.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 10:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725988850; x=1726593650; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8J65jia4UycAJFoDQeTPh+ZznoVYWGR7xablNp0yP3U=;
 b=FkPvzWMJQyIuTGKWPijthzEWzhv4UnTYVfdprwOOPZ09CmdF+Enqiv9K1to6yeb55D
 aTcC046i/SMFKb9DDo25CPE4a9Ch9DEq6STneAE6P76Vd8lkXwHZBVRwWRXNG5SpxGCX
 wYR2v32l82RK/tsTdWbWoi00ktlH0N/w8KhK4N3R9Xwr16T7caZx4p8Ns2SFNRTL1+P+
 GGpw3m59Axu/y/sV/NbEbaiP6mi7cdtpluiB+p147XztGlIIVZg9LgpA9k63PAboLaWs
 LvtNIVdg2/+xKE85Vnd55hg996ppaFZyLv+TPQz6/ggxNZnYf/8EoD+QMj4xupqzCqXP
 l4wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725988850; x=1726593650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8J65jia4UycAJFoDQeTPh+ZznoVYWGR7xablNp0yP3U=;
 b=tNE6hqbBi0jtAM4lGUkUmTz5IOAdUt5xgIGOvx3xl2D4bsxk8PSARPxKVtZtZoEpqT
 SVTWvEFv/KsD4Zs/+q3HCydEOOgrs7HvGhj7T9lulRrQX9Asp/i7vVjjFlZtDdrVmrNO
 Pjv6M+zxONJS831mZ30300BXPqpbpcghNvrZ4yXzFV4f1E/je9ss7iKBvjAA8GhwzVtY
 OUDvuQsYLJ1TPdpXlW0/0C4+U3EFvTGMKBMf0AMUFK013jpVfjyHXtOq0Ag9r+QsMvAI
 QB5EHVEAx39JjJ6jT9rKqPXTRzemfaPQpGeCGpDQPxP27TQDlwSZYAS+OhgX0coY8JZz
 2glw==
X-Gm-Message-State: AOJu0YwCdRY3evqAjs5Ql9vARYMkgk7GH0KrHNKR/LGGLags0TdTnAke
 /ZOuG69jSigd9u/7eQ6b8bqfkHzy1Qz72UrX50aNGugL+eb9efEZUwOmpJMegmCmwdk1LwTGDv4
 otlT8WQ==
X-Google-Smtp-Source: AGHT+IGzybNxmvJSui3nrMVcNqCe2/AccbeuCGN1vtbZ8sHE9GXKENg4nNBmWFndWRTjzfXXkURNXg==
X-Received: by 2002:a05:6a21:a342:b0:1cf:2f11:63f with SMTP id
 adf61e73a8af0-1cf62cdf83bmr551595637.30.1725988850271; 
 Tue, 10 Sep 2024 10:20:50 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::9633])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2db049883e5sm6685310a91.50.2024.09.10.10.20.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 10:20:49 -0700 (PDT)
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
Subject: [PATCH v8 4/6] tests/tcg: allow to check output of plugins
Date: Tue, 10 Sep 2024 10:20:31 -0700
Message-Id: <20240910172033.1427812-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240910172033.1427812-1-pierrick.bouvier@linaro.org>
References: <20240910172033.1427812-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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
index c5b1c7a786f..2da70b2fcfa 100644
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


