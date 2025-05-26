Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3239C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 11:24:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJVw9-0006Nt-CG; Mon, 26 May 2025 07:24:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJVw6-0006HN-Ay
 for qemu-devel@nongnu.org; Mon, 26 May 2025 07:24:06 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJVw4-0001qZ-JI
 for qemu-devel@nongnu.org; Mon, 26 May 2025 07:24:06 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a4d877dfb3so1008403f8f.1
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 04:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748258642; x=1748863442; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ELCLDmiYgPuDHAGlIm5WFjN8VBeP03kfHU9C8of95Hc=;
 b=Nfsl29ia8jPOzsHMHnTwNY2JbyR0wHDCdPoW0MpXUhu1oPCffLBdh8A6MjfxGuk/db
 ja062goDkLmUjiO82hMB84nhfGaAevnQ15+DjeA3GoualCvZ8MKlXCakEd03RIImLkmB
 ehaR9DDRvV4D+DiHpx4CohbQ80tIckE0mh0z3Wr9+oO+EQg8jr51ZzmyYPt2UNXnHvv0
 +FS1Veux8MqOBAikV+xWx28q90Bj6JmuuaTV5pCwkHcXdNB06kT7wCfJ5VX/IjWTDGBN
 Fql8oPlYPFyYuhwVfFmHPkU6UqLA0L011Z9GmcL4N4rbj+NPpB/jN8ccpVzCeHKco16b
 MYHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748258642; x=1748863442;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ELCLDmiYgPuDHAGlIm5WFjN8VBeP03kfHU9C8of95Hc=;
 b=r3aHBZYrDf36uPg+tzvzeQyZZxY91sST+cymSuCsEpRJenKF51Dsp7nzevF8Klf/5M
 9QwVey3HSZ0HymXO3FmzxMgi1TQqkBhPbn3YePLiQtqoXKNx1qeJOIgWEYuFWyo50Wgo
 fe7zMgWxLeG7iEWweEhMLd/lmlxUuu/ZdDOC8EQ3WXtOXS+/hTiNg6GCmouJ+NY5eWoZ
 xmiO3EnNBNVzDr1k99X+tyV58FB4F9UPN0+w6KFLXkHbgNLvfpskakwpsbO8oGb3smxF
 RWZyoLm09LJIybvKPMFjYMfS/sfZIbnTGYkX5T91QDATfsdoePzq8qVsuA5fng6omxEt
 uJuQ==
X-Gm-Message-State: AOJu0YznkqYfL3BpYJ3urYuvkY0Mt9an2qER0gDjqn8FP7WChfW2MgS3
 Vs7hHGT5wXpqVs+1BgtUjajKxvnXN9Qe/OTp/Tq+lylXyBSIqeataq2EAwIV1AjCC9yYDhyzrMm
 spvZTEr8fhQ==
X-Gm-Gg: ASbGncv51IVU8vF7wzQ5EEw3jzDAZrnG9QHWKh0v9kf/0OqjqRUf438NNd+sT7lQbJw
 XbnI8kGzsduxf/y3fL7pdsTQ4FG7xLMxGn59aDrIoJskMvoz/o6xg7aSaO73S8gGsiyKSOkvMOf
 iegPJ4DkdaDsD/fy+UcsvHBZ4TSrcUtOb8J3cLMvCOvLEFQDC5nxaevT8RT8Wbi88qhsXkAd9aU
 DlzOQRE7P7tljDGlIGSpVw4k0bUl7P3I+r+oa1YM94cL31KcZQpp2qUrfvHCIJBPlLge3Ytgmxq
 gVR0RZjuasAou/5rvgUNgXtBfAsVfizbbRud1f9oIXMOdk67DS48VB8C88NN8jrZG39YP0V3kI6
 TXxqkFjrAd9x88TN9cgt1PshGf9As3Wc=
X-Google-Smtp-Source: AGHT+IHk6BXJp9xgqQztiA3nhi4npvFes8NekY1N1GE1nODKEDT0H0V1NojsYSYhAU9rM40r88+fpg==
X-Received: by 2002:a5d:64cb:0:b0:3a1:fa6c:4735 with SMTP id
 ffacd0b85a97d-3a4cb474157mr7616249f8f.35.1748258642576; 
 Mon, 26 May 2025 04:24:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4d8ea9520sm2841634f8f.70.2025.05.26.04.24.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 May 2025 04:24:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 3/3] hw/ppc: Add stub for pnv_chip_find_core()
Date: Mon, 26 May 2025 13:23:46 +0200
Message-ID: <20250526112346.48744-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250526112346.48744-1-philmd@linaro.org>
References: <20250526112346.48744-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Since commit 9808ce6d5cb, building QEMU configured with
'--without-default-devices' fails:

  Undefined symbols for architecture arm64:
    "_pnv_chip_find_core", referenced from:
        _helper_load_sprd in target_ppc_misc_helper.c.o
        _helper_store_sprd in target_ppc_misc_helper.c.o
  ld: symbol(s) not found for architecture arm64
  clang: error: linker command failed with exit code 1

Fix by adding a stub when CONFIG_POWERNV is not available.

Reported-by: Thomas Huth <thuth@redhat.com>
Fixes: 9808ce6d5cb ("target/ppc: Big-core scratch register fix")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/pnv_stub.c  | 15 +++++++++++++++
 hw/ppc/meson.build |  3 ++-
 2 files changed, 17 insertions(+), 1 deletion(-)
 create mode 100644 hw/ppc/pnv_stub.c

diff --git a/hw/ppc/pnv_stub.c b/hw/ppc/pnv_stub.c
new file mode 100644
index 00000000000..8d11c8b65bb
--- /dev/null
+++ b/hw/ppc/pnv_stub.c
@@ -0,0 +1,15 @@
+/*
+ * QEMU PowerPC PowerNV stubs
+ *
+ *  Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/ppc/pnv.h"
+
+PnvCore *pnv_chip_find_core(PnvChip *chip, uint32_t core_id)
+{
+    g_assert_not_reached();
+}
diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
index 9893f8adebb..02f248f5f46 100644
--- a/hw/ppc/meson.build
+++ b/hw/ppc/meson.build
@@ -55,7 +55,8 @@ ppc_ss.add(when: 'CONFIG_POWERNV', if_true: files(
   'pnv_pnor.c',
   'pnv_nest_pervasive.c',
   'pnv_n1_chiplet.c',
-))
+), if_false: files('pnv_stub.c'))
+
 # PowerPC 4xx boards
 ppc_ss.add(when: 'CONFIG_PPC440', if_true: files(
   'ppc440_bamboo.c',
-- 
2.47.1


