Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08760C3814E
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2024 19:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQAr4-0002Da-LX; Sat, 06 Jul 2024 15:13:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sQAr3-0002DC-1K
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 15:13:53 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sQAr1-00045K-GB
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 15:13:52 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1fb70169c23so1703325ad.1
 for <qemu-devel@nongnu.org>; Sat, 06 Jul 2024 12:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720293229; x=1720898029; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t4bNu6CI6omvOt9CPXqjom5ah5T2zFduQZDfzw7pbQM=;
 b=JEinJQdaGKvBpFxnYUO3y66s4dl2SiY7N/3ShcSEh3qU/+Zw2vkoM6JO/Js2Qlv5DX
 arGbN6hu739fmrblTMJpdfGLQE0AyVZUoU4tthpMyZNZ/eSdH/2kFxqzMoB2mhBPqdmB
 wIO+TP9LP4Y9dM2CFkdIawTBik0EnFIwYYTwPgut10e1Kyj8FgOdJaMqvWD9pz7OtCXe
 VpWg4X0MXrGoBZJxwhiFqeaMBV6ZpXkk8b2DzzYkpv0yG/c001ZKhPiR/ugRLYHexLdC
 Tppn4KrHndGwZ2uHxV54PWRmCyYafikorsyiuU/uOO5myqChUK/VattBGoH+WUHIcffC
 Ntkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720293229; x=1720898029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t4bNu6CI6omvOt9CPXqjom5ah5T2zFduQZDfzw7pbQM=;
 b=Fu8zDZROxl4krvLAwrRdL7eYjfqeuLQbnr0EcxfbidrsxkQjdnwnvXlrfLMl4aDBD2
 vgYIJvvAmpnq/ksph2FwEqWaL8mY0Nj8i/PTO+qg2lhwU2OOQlLYoszxBw9c33ljugUM
 OyvHhDuAsmmRLDvDzW+RKfzB4dcU2C7TVqdOFsMOXdYQJEMB0h+5Rv74gegwfgaGhXPU
 71YxCaim/GY3H4d2AHPWoU9WLEcgEw/E6/LjNT6iAitQ2a6qVRwOKRGCdOmoSayZFMKw
 cBVQSUPJ57ntXg1YROSxogblYzJU1CcE08H0lsMn1vieJaLjDIBREjF6rGzjHXRibKNy
 ilcQ==
X-Gm-Message-State: AOJu0YwB7KDtE/OVszj+vLllan2sDNwd57fXLEbXYV22Vvll3+zxj3El
 2Si6f+imhI7eIvCHD8xJpgJV9DTZ+FM41NMDj4atuG7Za4aOK4sOk9WrcE1JkNGZs+ne9jwYivM
 4pMA=
X-Google-Smtp-Source: AGHT+IFZCHK2O1EIiWQwWBAhjnSm3AjaBNheqhWLqOcYl7No9gcv6sWAdQOAu+rx6+OPAYpv3iAanQ==
X-Received: by 2002:a17:902:e9c6:b0:1f6:89b1:a419 with SMTP id
 d9443c01a7336-1fb33e15326mr45465225ad.17.1720293229102; 
 Sat, 06 Jul 2024 12:13:49 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fb6153cb3bsm17304305ad.129.2024.07.06.12.13.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jul 2024 12:13:48 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Xingtao Yao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH v6 5/7] tests/tcg: allow to check output of plugins
Date: Sat,  6 Jul 2024 12:13:33 -0700
Message-Id: <20240706191335.878142-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240706191335.878142-1-pierrick.bouvier@linaro.org>
References: <20240706191335.878142-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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
 tests/tcg/Makefile.target | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index 52616544d52..6f50b0176ea 100644
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


