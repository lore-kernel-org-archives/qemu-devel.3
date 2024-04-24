Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED10C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 17:34:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzgV8-0005xH-H1; Wed, 24 Apr 2024 13:33:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzgV6-0005ww-SD
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 13:33:44 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzgV4-0002ze-L0
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 13:33:44 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-34a4772d5easo60859f8f.0
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 10:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713980021; x=1714584821; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TWf9rL1cSEDkz+YpJv977X8fZ+y5L+MRJ6Wf+vNPaVI=;
 b=dqQ2OXdELLoA8gpENqgom1k8NNHbgsNNuf2qNqX3qSXBTGEzCaxFSIVyqR+0+f9eyq
 fTsD9bjsdtBoDLJb2JFX0ETVfyuaOLwzyp873ZOaGlMMs1v0gU0FtyHrBINZ7Ivl07oN
 pGPRcde5MsjchrRzBVA3x5nsduhPKxgO1/ymjPlaJ4BCaXxq2qoJn7ocoW12IVAXCjPy
 BzYgGmJEvz1nsMweDfT5AexhAKi6Cy/rvpc7pyoYZvQ2tqTQ/pkgfmR6PXGDEA4wXypO
 CPCgA8UK4wIqrf/EZoCFh2itiSKtv/n9TR2W3cgdBDtm0wh146b3WCdGt1RlRdaDg0kc
 xG6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713980021; x=1714584821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TWf9rL1cSEDkz+YpJv977X8fZ+y5L+MRJ6Wf+vNPaVI=;
 b=M90gmOy+a9bslyJH8mkkonOoMvOg5M9+I3Tx8SkeZ3yCw75IEDp8s8U6sEU8ltfxFU
 OzI0BLnajzt/Z1j9kGuCoqjl0zB1zDmqRXEelOvuuoy+OrgBkqUj2smTFxEKx6GoOu2F
 kmk3gby0vTEnhLFJuUA/59s+5iveVdZCfjizmGJ9Eslw0HIH5g3+e3Ta3BG9uTSd/kkh
 BXEHkd7e+nRvTKz8l0ir6oJam/ECxHnB+ia3e4cktgR++wCeBpNG8GAgqLQ/XoL5/bgf
 5/pQTaNK3VLe4wjhclfKXHJZZ57JOnto16NWKNrGr0v/nIfGoCRNL6NBZCJ4RTai4q3C
 XLhQ==
X-Gm-Message-State: AOJu0YwjFpDYM4I2+JC5brJX2sgyM7ZTlTQhU8FP52FVsjT6fYfrrrZx
 0sreW1PzlC+oevCIpvtTdT4no5E3a3pfmS2YmrjhkjVpQgOSKr6AdePo7nJETsZYyLUTtWC+2Aj
 h
X-Google-Smtp-Source: AGHT+IFmijY3PGUk1FQ7+woY4H2mO5QfdlymbOCFfSZFJyrXItUPeEGRNZey0nv/HSywvqMAdcxeJA==
X-Received: by 2002:adf:f90e:0:b0:349:eeaf:3a01 with SMTP id
 b14-20020adff90e000000b00349eeaf3a01mr2325604wrr.22.1713980020828; 
 Wed, 24 Apr 2024 10:33:40 -0700 (PDT)
Received: from localhost.localdomain
 (mon75-h03-176-184-51-42.dsl.sta.abo.bbox.fr. [176.184.51.42])
 by smtp.gmail.com with ESMTPSA id
 b7-20020adff907000000b0034b3394f0e1sm7195874wrr.10.2024.04.24.10.33.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Apr 2024 10:33:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v2 1/3] hw/elf_ops: Rename elf_ops.h -> elf_ops.h.inc
Date: Wed, 24 Apr 2024 19:33:30 +0200
Message-ID: <20240424173333.96148-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240424173333.96148-1-philmd@linaro.org>
References: <20240424173333.96148-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Since commit 139c1837db ("meson: rename included C source files
to .c.inc"), QEMU standard procedure for included C files is to
use *.c.inc.

Besides, since commit 6a0057aa22 ("docs/devel: make a statement
about includes") this is documented in the Coding Style:

  If you do use template header files they should be named with
  the ``.c.inc`` or ``.h.inc`` suffix to make it clear they are
  being included for expansion.

Therefore rename "hw/elf_ops.h" as "hw/elf_ops.h.inc".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/{elf_ops.h => elf_ops.h.inc} | 0
 bsd-user/elfload.c                      | 2 +-
 hw/core/loader.c                        | 4 ++--
 linux-user/elfload.c                    | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)
 rename include/hw/{elf_ops.h => elf_ops.h.inc} (100%)

diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h.inc
similarity index 100%
rename from include/hw/elf_ops.h
rename to include/hw/elf_ops.h.inc
diff --git a/bsd-user/elfload.c b/bsd-user/elfload.c
index baf2f63d2f..833fa3bd05 100644
--- a/bsd-user/elfload.c
+++ b/bsd-user/elfload.c
@@ -383,7 +383,7 @@ static const char *lookup_symbolxx(struct syminfo *s, uint64_t orig_addr)
     return "";
 }
 
-/* FIXME: This should use elf_ops.h  */
+/* FIXME: This should use elf_ops.h.inc  */
 static int symcmp(const void *s0, const void *s1)
 {
     struct elf_sym *sym0 = (struct elf_sym *)s0;
diff --git a/hw/core/loader.c b/hw/core/loader.c
index b8e52f3fb0..2f8105d7de 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -305,7 +305,7 @@ static void *load_at(int fd, off_t offset, size_t size)
 #define elf_word        uint32_t
 #define elf_sword       int32_t
 #define bswapSZs        bswap32s
-#include "hw/elf_ops.h"
+#include "hw/elf_ops.h.inc"
 
 #undef elfhdr
 #undef elf_phdr
@@ -327,7 +327,7 @@ static void *load_at(int fd, off_t offset, size_t size)
 #define elf_sword       int64_t
 #define bswapSZs        bswap64s
 #define SZ              64
-#include "hw/elf_ops.h"
+#include "hw/elf_ops.h.inc"
 
 const char *load_elf_strerror(ssize_t error)
 {
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 60cf55b36c..0c3ddce971 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3671,7 +3671,7 @@ static const char *lookup_symbolxx(struct syminfo *s, uint64_t orig_addr)
     return "";
 }
 
-/* FIXME: This should use elf_ops.h  */
+/* FIXME: This should use elf_ops.h.inc  */
 static int symcmp(const void *s0, const void *s1)
 {
     struct elf_sym *sym0 = (struct elf_sym *)s0;
-- 
2.41.0


