Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07526FA1FEF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 20:03:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFdjZ-0005Zf-50; Wed, 22 Apr 2026 15:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdj3-0005JB-50
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 15:59:11 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdit-0000Kt-Nf
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 15:59:02 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-43cfd832155so4275106f8f.1
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 12:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776887931; x=1777492731; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EabXV5bbbt9IOKKRaZXmzK/DuHJza8oKP7g2gWuQKNE=;
 b=udcDq54GOGXu4qb0UwBrQBZPdMuYwrlWM1VaoDFYnmimZtU3JFN7WgNeliAdoVLCXf
 vkJYov6oNh6Mfcj4C7jvjFyXcPKvDQpjtfHqOpguJ0K5q8szFqCNIg5tJ+jz5/5iWhS6
 NYuu79MFue5ewJnFmX/Z1S/MLY5Mt1q9Q0MoOMLefaKxfCcnq1fKVgaliFHCvFHwBWNX
 8Cad1jmamsxrQx5n5N9hR4fd0JQf8N5x47If+pPSQbXXxIrNrZUFlJ7BBjDUTRDsXRzD
 NlXoqpjnuprKsMRimmmTj/+xHtF1jFX7qwYwlgYmKONpkuFrhg2scy43hFnUdTyvtGqR
 bZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776887931; x=1777492731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EabXV5bbbt9IOKKRaZXmzK/DuHJza8oKP7g2gWuQKNE=;
 b=RDY2z8JtaPArr7vJX+uBE/zoloLznNyXfmI2ORAVi5a5MkkdcWp4IYCjDn9kXpBvxd
 rY1BqFaiEBvNHHvxCCJQx8Jjg00DZBVzs/vC+Xr1KI9clZ5hrqyMPnWIWQ+uuxAf51WF
 Fi3CwUc0V/or4mRofLSi5ziWwZR2pNbqLynHRlOBvvf9vi3kSAyiJuTicGCArOM2VBMo
 N/fxHb3B0+7Wj+/sUcd8A33ZcEK9W/MaSU0iQe0PTNPlrWoIPa1q6Tg8QVYPzSREeC4b
 OXBSPOj12CloY+0uUgijtBWmGBBDRZm8SIBU0Dmh/gQPv+NCBVOLnjdbcMSU6llHcDXu
 HcMw==
X-Gm-Message-State: AOJu0Ywtyc98uC4rBGONEDwFdaIocQ89+9kelHhGy62dYHt7BDmzXzTJ
 X1Fk5qrXQsUWeH1ecEzf0+/lx4tfs1SIFTRX+kWDyYKX7ai9kwH+7zFlD6xbsZ0/1rujTWcAHi8
 XM+A0pKg=
X-Gm-Gg: AeBDievA+0Ib4mVhYQWg5I8FrNgoyd2GsfI1PP54fCj652WCsLgdJX1KqQ9fqbFfpwE
 psv6OmrcpriH+3SGg11PxkkGVaoEDPKLTC9K0qrSGIPsghGZ/B3IxxTQyd7QGdhpO3cLyie4bdR
 M1sNj84e7xKhi6JedF3KVVbhzFkYIwxEvA9x7Su/mJIiAWb5afSn0V2DBcjpAGp+ZzyX3U7XIcw
 fkk991YDXdy6qqXptfDmfHpv67tUXpuU3Zzg9Q+uIgtMwVzBsdQvX9sSmQR22m4d4mOEH2rnB89
 M24Xzgj2OSey8H4Jfkfjmnx18kPkWNfATpN/ICookiNEXcBH4rcJneQ1+lOY26kF7/RPAA9Texk
 L+BP6R7ODTQkAQI/O0Z2xP92UaSX6S14PfbnEFwKksC2Vkrv8Tg/D9zLsMxFbZk7Bo0tAcoUAHg
 gAgfeFBHEtdGqDCkfMjnBZKTTZMTwWeRqIKCvHt+Vz8zlLwHW4zbTwVxEYCr7zhk5qkTXZrn7xg
 nmcdJ2mK1U=
X-Received: by 2002:adf:f148:0:b0:43f:e413:f6fe with SMTP id
 ffacd0b85a97d-43fe413f7b5mr25156496f8f.0.1776887931313; 
 Wed, 22 Apr 2026 12:58:51 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4633bsm47246188f8f.26.2026.04.22.12.58.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Apr 2026 12:58:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/48] hw/microblaze: Include full path to target 'cpu.h' header
Date: Wed, 22 Apr 2026 21:57:07 +0200
Message-ID: <20260422195746.88865-10-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422195746.88865-1-philmd@linaro.org>
References: <20260422195746.88865-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20260313062055.2188-27-philmd@linaro.org>
---
 hw/microblaze/boot.c                     | 2 +-
 hw/microblaze/petalogix_ml605_mmu.c      | 2 +-
 hw/microblaze/petalogix_s3adsp1800_mmu.c | 2 +-
 hw/microblaze/xlnx-zynqmp-pmu.c          | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/microblaze/boot.c b/hw/microblaze/boot.c
index 4ad5ffd34bd..a93b68e1e48 100644
--- a/hw/microblaze/boot.c
+++ b/hw/microblaze/boot.c
@@ -26,7 +26,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/datadir.h"
-#include "cpu.h"
+#include "target/microblaze/cpu.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index b3bdc4d65f2..8f9f54ff1e2 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -28,7 +28,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
-#include "cpu.h"
+#include "target/microblaze/cpu.h"
 #include "hw/core/sysbus.h"
 #include "net/net.h"
 #include "hw/block/flash.h"
diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index 0c9a6bf2529..c5f64319009 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -27,7 +27,7 @@
 #include "qemu/target-info.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
-#include "cpu.h"
+#include "target/microblaze/cpu.h"
 #include "hw/core/sysbus.h"
 #include "net/net.h"
 #include "hw/block/flash.h"
diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
index f4c55589b7f..00154236bf8 100644
--- a/hw/microblaze/xlnx-zynqmp-pmu.c
+++ b/hw/microblaze/xlnx-zynqmp-pmu.c
@@ -19,7 +19,7 @@
 #include "qapi/error.h"
 #include "system/address-spaces.h"
 #include "hw/core/boards.h"
-#include "cpu.h"
+#include "target/microblaze/cpu.h"
 #include "boot.h"
 
 #include "hw/intc/xlnx-zynqmp-ipi.h"
-- 
2.53.0


