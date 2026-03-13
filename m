Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF692106FD87
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 06:24:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0vwr-0002Jd-9J; Fri, 13 Mar 2026 02:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vwh-0001yc-Ud
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:24:28 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vwg-0007I6-Ej
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:24:27 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-48529c325f0so12606595e9.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 23:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773383063; x=1773987863; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lFHXTlSV8hP8Jb3Ix8sRO2Zn3ptIwRuIXyR8rVDaiBQ=;
 b=Hn0hLX6PSKPN5Yq/g3/hoaG/+qqiAz1xqGfw7PvGMKA7wGPCjEFX0YY4k9OBn+lZe0
 wvqlfGxCwjA3z8gnoBLZXl8EWwVQLVfodr8hXz/R+KiGOjicbiItTb4mvPf6kjctBjRw
 pjYxvtAUrYOpYZOD5lBrHMiCV7E1hvpXYeZ5tN37b2h07T6MlzNj/K3y2PrKT5nhiTZZ
 980RB/lW7Fm9YeehAG+3Cso2/wJbZU0F6Le7j6Di8HzA/Zerd4x+gKU/h5YVDNtVb+zF
 jIrrCW6vdR8Hj5cIlFKJtbCGY0L+mHlYf6lqAXz9dXc+xW0/0R0XUiBHy5yAbj29rjzm
 r6+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773383063; x=1773987863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lFHXTlSV8hP8Jb3Ix8sRO2Zn3ptIwRuIXyR8rVDaiBQ=;
 b=WgMI9K8OMJJqZ888W15kqiC1fuSP/ZXMdP6uufIOCIgekt7IUoFMUuC6nkfBC0Zmyt
 htE53DLfHgk0Z55cSlguoqCPJszYwvx/Oxpopw26tnYgP8Mkd5P3f7Rzxs8c0B2K4h0/
 rwHp+5uL2RNosPDvINAzGYF6R13DE8sbllNAjgvqlQepxhLpXVdHeA9mrGsBiZUcs8xr
 SIWPkyDVIyTVOYTYrdp4yJ6VeiM2lp//mNRMJ9z+oal4YidIkxn6aERLDkf1l/zI661g
 JRqKM/cDi38E0+ODcDxZmqRbr9FBPcl3Z2LRpo06AlxPESsuzTVoPz6Kv0gScfoIxhwk
 LXwA==
X-Gm-Message-State: AOJu0YwflY3lpuEnJ8Vangaa2z1MogxH8V89GTNr5xz2nhyFTQVG6TUA
 vFfuAG7Lg6jqxe/7JJcEfcr8Il87LCiugTnNfUEhzrUtp/NEhq7f1TSb45B3nrcvwJ2XUAAiX/I
 wgTKga60=
X-Gm-Gg: ATEYQzyyXJuAUiH9Ha44pnt2Yosxz+W9wTGewNVHVT1HfxA5BbTsTLlAedw4T6n92cD
 SH/jDRVYvpDoReOMePmSafGJLqQj/9t0RsXkiYeAve7uN/o/0P+Rxa22IfoL60oSAVpkTPBTIrJ
 IHEubGwUdLuTiIidraqswXW0jya0y8y3DPiBwo8+FgvoMrvaox47a0TEGA0EJC4NtZN0tQRm94L
 BTCFar1kz5PSXPB3zpe8kZGLlHxuhKgWfptSg3UOd1ZPbqDFIDSx5par7g8Mw4hV0HhrnZ3T1FN
 xTecEDYfN7Yn9mLoy2rLXvtBXEEToyzDQOu/bPwLoI+rahLb6ArW9n+9X4U4zDIKmUaMxtRcjQq
 wgcie1XCKbhlMUX+cOGQMFt5oDGx2eR5skVb3m1hpBo8qvvHKkY5XESMFFIlD6V+6w+NXRa9BdP
 71EBQq0Jr651uWswFvG3zRD/tvly+jKth1zg2dq1EdA1Xw1bIWYBUaqUN0Y05k6qihA5xTiV879
 60V0g==
X-Received: by 2002:a05:600c:64ce:b0:485:3b34:2f62 with SMTP id
 5b1f17b1804b1-485566d0c13mr30772735e9.14.1773383063224; 
 Thu, 12 Mar 2026 23:24:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b6756e4sm214389495e9.15.2026.03.12.23.24.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Mar 2026 23:24:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 30/38] hw/riscv: Include full path to target 'cpu.h' header
Date: Fri, 13 Mar 2026 07:20:46 +0100
Message-ID: <20260313062055.2188-31-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313062055.2188-1-philmd@linaro.org>
References: <20260313062055.2188-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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
---
 hw/misc/riscv_cmgcr.c           | 2 +-
 hw/misc/riscv_cpc.c             | 2 +-
 hw/riscv/microblaze-v-generic.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/misc/riscv_cmgcr.c b/hw/misc/riscv_cmgcr.c
index a4d56e3b308..0390996f78b 100644
--- a/hw/misc/riscv_cmgcr.c
+++ b/hw/misc/riscv_cmgcr.c
@@ -21,7 +21,7 @@
 #include "hw/core/qdev-properties.h"
 #include "exec/target_page.h"
 
-#include "cpu.h"
+#include "target/riscv/cpu.h"
 
 #define CM_RESET_VEC 0x1FC00000
 #define GCR_ADDRSPACE_SZ        0x8000
diff --git a/hw/misc/riscv_cpc.c b/hw/misc/riscv_cpc.c
index e04ccdf54fa..37fdd0b39ba 100644
--- a/hw/misc/riscv_cpc.c
+++ b/hw/misc/riscv_cpc.c
@@ -13,7 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "cpu.h"
+#include "target/riscv/cpu.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
diff --git a/hw/riscv/microblaze-v-generic.c b/hw/riscv/microblaze-v-generic.c
index d56b64792d7..b0494b1ac50 100644
--- a/hw/riscv/microblaze-v-generic.c
+++ b/hw/riscv/microblaze-v-generic.c
@@ -16,7 +16,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
-#include "cpu.h"
+#include "target/riscv/cpu.h"
 #include "hw/core/sysbus.h"
 #include "system/system.h"
 #include "net/net.h"
-- 
2.53.0


