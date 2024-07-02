Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CFF9C30653
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 01:11:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOS2h-0005TC-2b; Mon, 01 Jul 2024 21:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sOS2Y-0005Re-I0
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 21:10:39 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sOS2X-0002Aq-0H
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 21:10:38 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7066cba4ebbso2416252b3a.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 18:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719882629; x=1720487429; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tJdBX9SfhlJKk9rWv11IMwaEBO+AoHCZIGuGx9ia+J0=;
 b=FsSPEXY2foY0iZHcV/z7Tl+PGbKeYp1jhYzGjBwagT9MkGVskczTi9imLlpVCVR9fT
 1ZXWsmPdpgj4NCfi3sirhL1g/MOSFxjvmSvm2SsDgLW1kWr2T8sM8k7SPln309X61YXi
 bDwc71371+noup7KkzYMTZoG2V4Ww6DfTY21jfFBtint0gr2ONeBNgGPFOnWtXVuXMt8
 sTJaAWEbOV0KXNZIZHgggcHVVwADJPCR7y/UBn8eeqX6MpWNAzTsY+H2lNB5QwfAj3DS
 pm8KX7hwsGzPd2eMGMphkwF/8iDJrzs4HMvabFP68B7X+VLQVeo77bdYDLiS/6PDak9y
 aYvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719882629; x=1720487429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tJdBX9SfhlJKk9rWv11IMwaEBO+AoHCZIGuGx9ia+J0=;
 b=j6Wg/7pe7W9rrCsxQFw0qsHdLjbtigULgQ/b1O8fixXmy/VmNXO/SWm+ndXafKFdXO
 I3D5p5X9l0diQpzi95ZtDfe5So4Q7bZh4uNHP06+OG1AqcaJ1W3FRxGJafxiSMuadZX+
 njtIkJ2koWMtisXSEmHnK+IFiXCbSy+ApQnbtnQcRSYK4+OSijSrPnWGNFjVOXaGqKb1
 oBjsHSCtt8iTGLrvURuyL+JsDmRYBe5s5hK0iPU3zFPFSl+hnTLiQKwmBL9PjuHHPk9X
 QU57OL17iQL7EIYIlVll+pNTl6jzbrC0l6cNW0V85dDvj+0ptcYLM9dBS+lOCrXph4nJ
 r1kw==
X-Gm-Message-State: AOJu0Yw72G/E4mwPZ8WqLa7UDDJ/4jOqq2TY0NZCyo8zupgQw5PsHPWE
 RGMz8VjPBmh73Ey0x8chixoLTwTsp0cbDXJ0MRgi2aNsoNJPOm1hKrXAR3W5/ivoF9P/vViP7r9
 s
X-Google-Smtp-Source: AGHT+IH3Fd8oL851i3xomsBwZBGopwGn7N8Jqq6PG12il1I+23OVpW7EwKYdTyZYCLoDOcTfEqCt3g==
X-Received: by 2002:a05:6a20:3ca3:b0:1bf:594:ea91 with SMTP id
 adf61e73a8af0-1bf0594eef1mr4633315637.42.1719882629321; 
 Mon, 01 Jul 2024 18:10:29 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c91ce1f198sm7480317a91.2.2024.07.01.18.10.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 18:10:28 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v3 5/7] tests/tcg: allow to check output of plugins
Date: Mon,  1 Jul 2024 18:10:13 -0700
Message-Id: <20240702011015.325609-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240702011015.325609-1-pierrick.bouvier@linaro.org>
References: <20240702011015.325609-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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


