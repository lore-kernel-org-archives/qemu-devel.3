Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A261C83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:56:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubzo2-0002mY-TH; Wed, 16 Jul 2025 06:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ubzmI-0007lB-1R
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:54:22 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ubzmF-0002TM-EC
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:54:21 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-ae0dffaa8b2so1273597066b.0
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 03:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752663257; x=1753268057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BuB1ZMI7kjoW2hcwIFccTZ9+4H8jt6BsHwQwTfInE6Y=;
 b=FLFnKh6qc6xc0oOV0500zR7md7JpVDD6gDsaaDbFleaZfA93OdqsRMJ+mUu6OOynZx
 u80G0zQmJx0IKYODe6ysBTaI8ee65E19J0dyNYM7GXgHPyROrN2soPUp7JyDF89qdihI
 tFFnVV5S6uiM5T1m1UpRVxhFBPnJAPPs75mqQK47KUKy0ItbuqyFZ9yDxofg9nFZIyQY
 +oGTtOPao8hFzKwRxoOteIbXEfAQ34RUWgHLMcst+02xQ5xRZ33Hep9EEzqWgYGHvXMM
 8xw5JuxsGRPLQecftNnXFEFivNWmP+XwShA7SNdOeN1TcQLauqjvjXg0F3/Ck+ESSjWj
 G3qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752663257; x=1753268057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BuB1ZMI7kjoW2hcwIFccTZ9+4H8jt6BsHwQwTfInE6Y=;
 b=u5anriYFQnOrfz4ho5/ofCQwg+3hd3kBa4t7nKYsd7E3Cq0J1PQ61AmNRdzKfSXSr+
 csdKQY0C48X0pGEIhz9ZOUe5q1Nfw8kT2kuhnT4Srn3fAHXbfZXha1goT3WUw5x2cKvx
 fPqHiggCBKZBr8WteFUMzbDbJ3W2/OPRfEkwKOhcwpebCG7FN8IKu+i8p4gfPA85I8A7
 RDwAC467f5clFEQYVaAWdiPcf2Ioc9gq9jM3fnhjjtxJT5S53qTHRlG8vg+3JFPTTL2d
 Lle8I91gtLX5gtLrZet8iEbOQYtdYXrfygTdYlxa76e4uVbnoiKr7laKa2+b1hqc7csb
 b+Og==
X-Gm-Message-State: AOJu0Yzj0h9z/PbCdYyf+n6EMw+A5SXygSLfnS8t2sjJz6a2oTmP7GZ7
 cA8H2vLmVQj89d6nINnUZIhimHVTQi/nS8n9QGxqA0sXOF7d/YSizZJuQHTOcNtbhDU=
X-Gm-Gg: ASbGncvz8Xs2EV8f8AtI3G1A/l4njY5vY/oz8hKabemm/vgI3DEakYf5TaaPms3KnDO
 2w4vVTEGGiX/WvhG58fGOPV5H0K/ucKmHOAG5GbTyyo8Nb5Ct6xFwVafOtQcQzuaM12sJ+zVKNd
 M8as5h3dUqZsdULLYxemoK9K7w1AUgzkItBE4TM0Bb40Ql4IBhPda8gLZUgyM5Hg+hnJ9QUTeQd
 AyUf51zLev3DnoxkUOn1JUmf2bQPT2EH0AiY9agG902O5J/0484bT2awPvm/kIiVzpIbxATOY5+
 vfQCnj+NSCv0CNmmXIKywca//+RnvWcik+Yfgu+7yGx5u+I9rKv8IITa/7GTuI4ETA1Wvair1p7
 uQ9D1kh/xUf/sSgxeUSqRHn8e0IUwz1DKxw==
X-Google-Smtp-Source: AGHT+IEZZN002AZsx8/RaE2WlnZo8/860ASRVez3aQMFeEK9zWni+S6tEaCFJXuHih0Ej9lo2qVidw==
X-Received: by 2002:a17:906:cad5:b0:ae9:c47f:1bda with SMTP id
 a640c23a62f3a-ae9c9b908demr270950666b.59.1752663257522; 
 Wed, 16 Jul 2025 03:54:17 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae6e829d061sm1180627366b.142.2025.07.16.03.54.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 03:54:15 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 006D65F88F;
 Wed, 16 Jul 2025 11:54:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 devel@lists.libvirt.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [RFC PATCH 1/6] tests/tcg: special case sparc test cases
Date: Wed, 16 Jul 2025 11:54:09 +0100
Message-ID: <20250716105414.2330204-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250716105414.2330204-1-alex.bennee@linaro.org>
References: <20250716105414.2330204-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Due to an existing bug #1771 we can't run anything we build so we have
to suppress the normal multiarch build. As we can't have duplicate
build rules we need to copy the bits we need from the normal multiarch
Makefile so we can redefine all the run-% rules.

For signals and vma-pthread they also need slightly different LDFLAGS
to link to the atomic support library.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/Makefile.target       |  9 ++++---
 tests/tcg/sparc/Makefile.target | 45 +++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 4 deletions(-)
 create mode 100644 tests/tcg/sparc/Makefile.target

diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index af68f11664..8bcafaaf7b 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -103,9 +103,10 @@ ifeq ($(filter %-softmmu, $(TARGET)),)
 # then the target. If there are common tests shared between
 # sub-targets (e.g. ARM & AArch64) then it is up to
 # $(TARGET_NAME)/Makefile.target to include the common parent
-# architecture in its VPATH. However some targets are so minimal we
-# can't even build the multiarch tests.
-ifneq ($(filter $(TARGET_NAME),aarch64_be),)
+# architecture in its VPATH. However some targets are so
+# minimal/broken just include directly and skip the common multiarch
+# tests Makefile.
+ifeq ($(filter $(TARGET_NAME),aarch64_be sparc),$(TARGET_NAME))
 -include $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.target
 else
 -include $(SRC_PATH)/tests/tcg/multiarch/Makefile.target
@@ -147,7 +148,7 @@ all: $(TESTS) $(EXTRA_TESTS)
 RUN_TESTS=$(patsubst %,run-%, $(TESTS))
 
 # If plugins exist also include those in the tests
-ifeq ($(CONFIG_PLUGIN),y)
+ifeq ($(CONFIG_PLUGIN)$(SKIP_PLUGIN_TESTS),y)
 PLUGIN_SRC=$(SRC_PATH)/tests/tcg/plugins
 PLUGIN_LIB=../plugins
 VPATH+=$(PLUGIN_LIB)
diff --git a/tests/tcg/sparc/Makefile.target b/tests/tcg/sparc/Makefile.target
new file mode 100644
index 0000000000..0b5f9e8b2d
--- /dev/null
+++ b/tests/tcg/sparc/Makefile.target
@@ -0,0 +1,45 @@
+# -*- Mode: makefile -*-
+#
+# For Sparc we only have multiarch tests - however as everything is
+# currently broken we have to duplicate the bits needed from the
+# multiarch makefile. This can be removed if we ever get running again
+# (or we deprecate the target).
+#
+
+# Compressed copy of tests/tcg/multiarch/Makefile.target
+MULTIARCH_SRC=$(SRC_PATH)/tests/tcg/multiarch
+VPATH 	       += $(MULTIARCH_SRC)
+MULTIARCH_SRCS =  $(notdir $(wildcard $(MULTIARCH_SRC)/*.c))
+ifeq ($(filter %-linux-user, $(TARGET)),$(TARGET))
+VPATH 	       += $(MULTIARCH_SRC)/linux
+MULTIARCH_SRCS += $(notdir $(wildcard $(MULTIARCH_SRC)/linux/*.c))
+endif
+MULTIARCH_TESTS = $(MULTIARCH_SRCS:.c=)
+
+float_%: LDFLAGS+=-lm
+float_%: float_%.c libs/float_helpers.c
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< $(MULTIARCH_SRC)/libs/float_helpers.c -o $@ $(LDFLAGS)
+
+fnmsub: LDFLAGS+=-lm
+testthread: LDFLAGS+=-lpthread
+threadcount: LDFLAGS+=-lpthread
+munmap-pthread: CFLAGS+=-pthread
+munmap-pthread: LDFLAGS+=-pthread
+sigreturn-sigmask: CFLAGS+=-pthread
+sigreturn-sigmask: LDFLAGS+=-pthread
+sha1: CFLAGS+=-Wno-stringop-overread -Wno-unknown-warning-option
+
+TESTS += $(MULTIARCH_TESTS)
+# End of copy of multiarch/Makefile.target
+
+# atomic primitives used by these tests need -latomic
+signals: LDFLAGS+=-lrt -lpthread -latomic
+vma-pthread: CFLAGS+=-pthread
+vma-pthread: LDFLAGS+=-pthread -latomic
+
+# all tests currently broken due to broken CASA
+run-%:
+	$(call skip-test, $*, "CASA is broken (see bug #1771)")
+
+# we can't even think about plugin tests yet
+SKIP_PLUGIN_TESTS=y
-- 
2.47.2


