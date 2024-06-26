Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9ED7C30653
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 23:39:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMcDa-0007TZ-Ql; Wed, 26 Jun 2024 19:38:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sMcDM-0007S3-Op
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 19:38:13 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sMcDK-0007Jv-Jh
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 19:38:11 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1f64ecb1766so55334935ad.1
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 16:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719445089; x=1720049889; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=doL4IgQgCF3HWgmN7iQLNBk72z9WitWnst2YOIXTsDc=;
 b=MY8de2nYos1QIr569wG+xLf04ni9RADvGBPqlY3ADy7ENP2Gqf2Oks1+GMNrTUqC/6
 NsoRBOkRWZJD6EuhLDAuFQ9XMLF+sEtm4pNifD20K4Of93/q0F3kAVQDj/d+4+2Pgz7j
 LO5hHfg+QyukHEwB7JQLrFasCmuf3LQnGJoT6QIpCpmbywm9EG2n4Ic8F2QWatm70386
 4T0NA2UqPnaJtbzqXnENLAd4z709hdozG5vz5KXICSfjaHQsHBhIZBduMb9laoM0utSS
 7iyFqBkFQcbind1cvwAOBWkvH4V9Vx3JMAE39y8/KOzR4K/mpKO1F4xkMyyAvdwjFa5n
 xnbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719445089; x=1720049889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=doL4IgQgCF3HWgmN7iQLNBk72z9WitWnst2YOIXTsDc=;
 b=Qb6GTOCFPvQ050CA8E7S29YO7j8MtKj0//uR8aZXowMKyOUTaWt1JXUmZAUz4+v5yr
 7U+83X+WIHuXaxF5OD05LGAYGSolXbqnZ/7dwUsbl1AprOhRXTK7xYF4AcbuZ8to+j2n
 1V7eI5qsdL+VPjSW6g2yxHMpLgFRPBgFHebRLmUBxZ54hxVKevLiRoxRuCJtBNRDvvHw
 2/SnjclyznIFJkxnlg/RzSHH/wzk1xzZln/l5SS4r1tlxwPJ+8w42Kwjj0gwvPdRL4Ul
 adO5xyvP6RdymUEuR0aXzm4YXsz7Xrc2Bupgie3yDz0U3frN6v/4GU6IULIQ5cGB6lGq
 b00Q==
X-Gm-Message-State: AOJu0YzlV7r52/dzEVzdBa+EF/xt9a+zaxO2VSLVqzE8NqRQKjyfrarP
 /w8Za6TyU4XuC8T4ZjTvkE3Uadxse9V5nF3K6EHTpNUE42HisUCk21V/A28ZaYCRGAxR+fA/nP3
 UBK4=
X-Google-Smtp-Source: AGHT+IGsHKiVNN57dWjw30MHDfKQdqI78yaR3Nqfogi7ww8lWOWpzeBEVFMpNv93T7tHbsj4lwBcnw==
X-Received: by 2002:a17:903:2446:b0:1fa:4a8:79e0 with SMTP id
 d9443c01a7336-1fa1d62b79amr137776115ad.39.1719445088715; 
 Wed, 26 Jun 2024 16:38:08 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1faac8df624sm563055ad.29.2024.06.26.16.38.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 16:38:08 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 5/7] tests/tcg: allow to check output of plugins
Date: Wed, 26 Jun 2024 16:37:55 -0700
Message-Id: <20240626233757.375083-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240626233757.375083-1-pierrick.bouvier@linaro.org>
References: <20240626233757.375083-1-pierrick.bouvier@linaro.org>
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/tcg/Makefile.target | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index dc5c8b7a3b4..55993611cae 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -90,6 +90,7 @@ CFLAGS=
 LDFLAGS=
 
 QEMU_OPTS=
+CHECK_PLUGIN_OUTPUT_COMMAND=true
 
 
 # If TCG debugging, or TCI is enabled things are a lot slower
@@ -180,6 +181,8 @@ run-plugin-%:
 		-plugin $(PLUGIN_LIB)/$(call extract-plugin,$@)$(PLUGIN_ARGS) \
 		-d plugin -D $*.pout \
 		 $(call strip-plugin,$<))
+	@$(CHECK_PLUGIN_OUTPUT_COMMAND) $*.pout || echo \
+	$(CHECK_PLUGIN_OUTPUT_COMMAND) $*.pout failed
 else
 run-%: %
 	$(call run-test, $<, \
@@ -194,6 +197,8 @@ run-plugin-%:
 	   	  -plugin $(PLUGIN_LIB)/$(call extract-plugin,$@)$(PLUGIN_ARGS) \
 	    	  -d plugin -D $*.pout \
 		  $(QEMU_OPTS) $(call strip-plugin,$<))
+	@$(CHECK_PLUGIN_OUTPUT_COMMAND) $*.pout || echo \
+	$(CHECK_PLUGIN_OUTPUT_COMMAND) $*.pout failed
 endif
 
 gdb-%: %
-- 
2.39.2


