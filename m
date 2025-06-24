Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5365BC77B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 17:54:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU7qb-00034k-9b; Tue, 24 Jun 2025 13:54:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uU7qM-0002xO-Ct
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 13:54:03 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uU7qJ-0002mP-OS
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 13:54:01 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-234bfe37cccso11197785ad.0
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 10:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750787638; x=1751392438; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bgnfCU/cr4K0NH5U9mJ9R96Apm9sPszlIy7NNSUL0Bw=;
 b=nAvnkZNcf/8RmUvgfcUjEQwvEVM3OeeCOC7aYLIXc5CMOgR+ZEmkDWvUL6SmKmr1as
 ezQGSxZLSV2YeVQpxkt9/7Fil3lNTs4bPx+2OlUqWJBMrBsm/11MAArsc12v/KFjxu4l
 ac8Vm3X7R+YDhPA+c1g0WUu6RLzQGEmRF/bptkZRLd4FNAixMtQVBzTj8zSZ6Q6YYnhu
 yBHY4jOW+u27kCmuIEOGpfO2IfnEUgo0DeYCmEB6SQ8J964CQzL7His+gwsFLOSvuT43
 lWZ3ELJgJ2ZZH7gsI+6vES+o7N0aihSQNMVGkROJNdwc/RcaJezw7FxNtxl9FEk91SsN
 Z9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750787638; x=1751392438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bgnfCU/cr4K0NH5U9mJ9R96Apm9sPszlIy7NNSUL0Bw=;
 b=s62u9kU4UfW39kWC58hxEFv9QlOk1aCiYq7qX+uQfydJMbl2aeWhE6Vqz0aa+I9EP5
 gkKyOq+QK8JuuDPHRAm1x6+TBJZpw09qY88yatnzZ33+cJSVDwUQTTfFveQ2Af2dmHZ3
 39dacMUfUjcIzgbYHgCDlY27y+4CUJQTDcaTWcwa5ZXAplC8Do1DLrxzAHJnIOxaHPow
 dfN8dOAyZ3TDco7tawxP4+yYE5LvMz3+G+wT5mXlPz6+Gepr4jTc8mRMBM7YE0/7Iuub
 lGgL90YncYcqh/A4tb7NtIh1uvV6CApnTh1s6fDzFuC37aFv+b2Pz5EqbWmYc+BvOaZp
 Fg7Q==
X-Gm-Message-State: AOJu0YyMq2eM5LbYrYie8mgU/02+/I8YwCeCJN8CmbblTfyfHP4x+HLe
 luDirP3mnTzDo1F0nb9BEGhvu2qXkkYQUv6eUhP7xA4fUCL5St7cXPsPqwzR0bVX8I4=
X-Gm-Gg: ASbGnctQ7cr88pw8SpD6NciwD7Ua4toscheLp9OmsUaky81ar4oZIlZcssu7ucewHoI
 6T3/zElnrbFsIxK+qnwr7sfJgAjdvPm52KnKllMsr+SiWSkB2bSFaTdtjNORrixYuCHrzmUXRQ+
 0/JLvm+ID+SbUtMID/k00N9Q3jLhJQu6DwEnmwo3elj3rm1IdC5dEvjPa9T6tKjTuu9jNM6Vw+z
 GhnWl4ZQysGYKqfSv9YVFAsgzFALBM56Pn9K3weMhM/9oJHyqOeZh5ysatHIVGbO2slY+0jhiCL
 oXq/qAyyczj+CIgUTr3lZubx1fzJkA8iv3bJBmnGGCzmItTSZcb9sy//eMwFiw==
X-Google-Smtp-Source: AGHT+IE7Tq1UhNsdomTEAsnLHhXDAJZcYnLJEfezoQP82WjOqwfquQpG/ww+NZLqNVQuA7t/P5URzA==
X-Received: by 2002:a17:902:d492:b0:234:8c64:7878 with SMTP id
 d9443c01a7336-2382409e007mr3077785ad.11.1750787638073; 
 Tue, 24 Jun 2025 10:53:58 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b31f12427b7sm9318153a12.40.2025.06.24.10.53.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Jun 2025 10:53:57 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rowan Hart <rowanbhart@gmail.com>
Subject: [PATCH v14 6/8] tests/tcg: Remove copy-pasted notes and from i386 and
 add x86_64 system tests to tests
Date: Tue, 24 Jun 2025 10:53:49 -0700
Message-ID: <20250624175351.440780-7-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250624175351.440780-1-rowanbhart@gmail.com>
References: <20250624175351.440780-1-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=rowanbhart@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The x86_64-softmmu Makefile seems to have been copy-pasted from the i386
Makefile at some point in the past. Cleaning up a vestigial unused
variable and removing some outdated comments.

Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
---
 tests/tcg/x86_64/Makefile.softmmu-target | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/tests/tcg/x86_64/Makefile.softmmu-target b/tests/tcg/x86_64/Makefile.softmmu-target
index ef6bcb4dc7..d3e09708a5 100644
--- a/tests/tcg/x86_64/Makefile.softmmu-target
+++ b/tests/tcg/x86_64/Makefile.softmmu-target
@@ -1,13 +1,11 @@
 #
-# x86 system tests
-#
-# This currently builds only for i386. The common C code is built
-# with standard compiler flags however so we can support both by
-# adding additional boot files for x86_64.
+# x86_64 system tests
 #
 
-I386_SYSTEM_SRC=$(SRC_PATH)/tests/tcg/i386/system
 X64_SYSTEM_SRC=$(SRC_PATH)/tests/tcg/x86_64/system
+X64_SYSTEM_TESTS=$(patsubst $(X64_SYSTEM_SRC)/%.c, %, $(wildcard $(X64_SYSTEM_SRC)/*.c))
+
+VPATH+=$(X64_SYSTEM_SRC)
 
 # These objects provide the basic boot code and helper functions for all tests
 CRT_OBJS=boot.o
@@ -18,7 +16,7 @@ LDFLAGS=-Wl,-T$(LINK_SCRIPT) -Wl,-melf_x86_64
 CFLAGS+=-nostdlib -ggdb -O0 $(MINILIB_INC)
 LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
 
-TESTS+=$(MULTIARCH_TESTS)
+TESTS+=$(MULTIARCH_TESTS) $(X64_SYSTEM_TESTS)
 EXTRA_RUNS+=$(MULTIARCH_RUNS)
 
 # building head blobs
-- 
2.49.0


