Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1241106FD87
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 06:24:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0vwX-0000ma-CM; Fri, 13 Mar 2026 02:24:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vwS-0000Ue-DH
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:24:14 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vwQ-0007GT-Tq
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:24:12 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-439bc14dcf4so2149857f8f.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 23:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773383049; x=1773987849; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=stChrtEuYE7rK1Pgfiihe+WTLBS5Q+FZKV/MIOJrgEM=;
 b=BBi7v1GCaIzTaxZVGbzqueJdpvsBPgzopazqNAOUukpVoNKFn24cn64n1O1oTVGV9u
 xZlLESvJJPljqx46PEw4RZ5U4lQ0PUKECyufrBF5mMmGR5qZiAmBFReJ7y60MOgX/Aaf
 JW1o29d7AjO5fuiH3fwdVXI8Kc8qqRAYWft7Pj0gpX4tOR5aZPhUUW2qWrMRbAkZ18Cf
 AldMl2jacLNLyGEVbDIZ+W4K+zaFgvRIkMZ4J2yjZHsVzaHH8W/QvBZT2NmxaRk39neD
 mOOgRsJC/hEu00wpmPMIguVCYcDrFXdna7L/V4egMxLwwmSntQr1TLUGc5VVpryMVG8P
 uO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773383049; x=1773987849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=stChrtEuYE7rK1Pgfiihe+WTLBS5Q+FZKV/MIOJrgEM=;
 b=Tf1BtaeE8IcWTx3QeOhfnQfWgCsIa29vXAJIhd1pkCl3pa2tZjzy+z3Fo5kU4B2vjA
 P89OjRwXIgMo7hVHY2Hucuv3N3ljGkKdzvVlSSNnGFUEG3g8UF7kriLQ892RnPCSVMms
 kW0eEg3NeyGiloInbtMmlZWdBaz9T7CsIpu5uH2ZMh3HwYdDVrlmEj1+AtwffyOj4VDg
 EvQlCZB6MMwbAlnuyC+QsoxRQ1UawUqsZnZVfJVXVA95c8/+zgWWQlh5KLjbCfBgaZuC
 QoxJwG3a5z45k74IMg/iolDy6XS0iUcyVPGcKIqvZqEKVthKCwRdFuloJrOB2706abRq
 oQRA==
X-Gm-Message-State: AOJu0YzeQzTTZ9+4jFWEQDTrsJ+j0A0jPdZg26F0EPjTo/T8JPKOZqov
 xgNcD9NPDhAsPyurG6ka/rLV3k7c+KWW5fvrEvfIs+w8rEpuF0+EzBM7SBzPBEEU9WnAuEsQpCJ
 x85o67s8=
X-Gm-Gg: ATEYQzyUhGkH/kE6Wm/EHLrjI3OwaNkvTzYlLrINQF/ArGJt1jKbD0LtbDlI/IjshXa
 EqJ8vPGU9n5ukjDAPiP6EVGiqEYHvAWl5wPHuOeEOmMmFEGf4ZKLjG0G6bSOtSR/eXt99KhbDtP
 s6HBNfpifQxeHTxkWEQCe2oCUSe/WxfGnW1lYDBpyiXrvd4BESEayzUPaQ0BJpehBBubKrrTFsG
 S2MtGWYb7i2vaPDmA7Yb5+fejALLSmRXeFAia8oLHx8zS0MAqgfhEW1mD9a5eLCJH7+LduntnRQ
 Rcxt/XVGdh/vPsbZYm/6Ki8xq9tIbe++RKw9Z3J0HZZGXtAUnOTMmsKFLY6IrYtgERQ1O7g8rc/
 Cs7KaxyidP3tKnfnVHOnrDM4h6+Sb43gCKP10J/HusyXFUCTXM6ApFyfslNUbxt0kcSDyTYXJSO
 tQIqvpgJ5Hbz1udCbvpRsxkht2g+NwZljwCDg0djfACvpFImZsksyie2IwUrrWt6l1SEHV6L0XJ
 N614w==
X-Received: by 2002:a05:6000:4011:b0:439:8d39:47c7 with SMTP id
 ffacd0b85a97d-43a04daf776mr3749644f8f.18.1773383049113; 
 Thu, 12 Mar 2026 23:24:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe2273d9sm16721945f8f.34.2026.03.12.23.24.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Mar 2026 23:24:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 28/38] hw/or1k: Include full path to target 'cpu.h' header
Date: Fri, 13 Mar 2026 07:20:44 +0100
Message-ID: <20260313062055.2188-29-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313062055.2188-1-philmd@linaro.org>
References: <20260313062055.2188-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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
 hw/or1k/boot.c     | 2 +-
 hw/or1k/cputimer.c | 2 +-
 hw/or1k/or1k-sim.c | 2 +-
 hw/or1k/virt.c     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/or1k/boot.c b/hw/or1k/boot.c
index c18f4a6a9fc..714634b5f3f 100644
--- a/hw/or1k/boot.c
+++ b/hw/or1k/boot.c
@@ -7,7 +7,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "cpu.h"
+#include "target/or1k/cpu.h"
 #include "exec/cpu-defs.h"
 #include "exec/target_page.h"
 #include "elf.h"
diff --git a/hw/or1k/cputimer.c b/hw/or1k/cputimer.c
index 51da226fcde..b35411aa1e1 100644
--- a/hw/or1k/cputimer.c
+++ b/hw/or1k/cputimer.c
@@ -19,7 +19,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "cpu.h"
+#include "target/or1k/cpu.h"
 #include "migration/vmstate.h"
 #include "qemu/timer.h"
 #include "system/reset.h"
diff --git a/hw/or1k/or1k-sim.c b/hw/or1k/or1k-sim.c
index f1b1f63274b..b55105cd148 100644
--- a/hw/or1k/or1k-sim.c
+++ b/hw/or1k/or1k-sim.c
@@ -21,7 +21,7 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
-#include "cpu.h"
+#include "target/or1k/cpu.h"
 #include "hw/core/irq.h"
 #include "hw/core/boards.h"
 #include "hw/char/serial-mm.h"
diff --git a/hw/or1k/virt.c b/hw/or1k/virt.c
index 39f54058ab3..2ff5c084a2b 100644
--- a/hw/or1k/virt.c
+++ b/hw/or1k/virt.c
@@ -10,7 +10,7 @@
 #include "qemu/error-report.h"
 #include "qemu/guest-random.h"
 #include "qapi/error.h"
-#include "cpu.h"
+#include "target/or1k/cpu.h"
 #include "system/address-spaces.h"
 #include "hw/core/irq.h"
 #include "hw/core/boards.h"
-- 
2.53.0


