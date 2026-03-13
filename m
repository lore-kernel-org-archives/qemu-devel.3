Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF9B7106FD89
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 06:24:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0vwX-0000kn-2u; Fri, 13 Mar 2026 02:24:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vw7-000067-Qe
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:23:54 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vw6-0007EW-8X
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:23:51 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-439bc14dcf4so2149663f8f.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 23:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773383027; x=1773987827; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M7EacptWhdcRfod/J6LdY/xRrZqq+dBBFNvD4rEGcOc=;
 b=OK1TcM0d/czLSdIYJDcf96hR1XCBnarMRIIzQgxFkV9QJAbwavyNFvm72UBjD0g2el
 R3dakccWqNyngihjVEf7ha+lABNUFO4F1RpzNKcRjhA5WEO10P5cflyG9TVnoYLzCnxy
 Q3bB3s5/d5aLH3aQwmgjzk7X6By+S+/Zoyp2xFWeU7tG2gKWbM9m7UNLdt/Oqwss5ILo
 MjnY2kDmPmbmyUK89CdKyfTSp3vWMXIiK5OpvvhAetK7DRxGHFALiOKrRC3/NihfjqbX
 HyqDRxX4y/Hyx6gAtO960K8MNL2MJTJNdZLJiMiOQ2mqreG9UyiHErsikvQSiGJS4VXM
 j+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773383027; x=1773987827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=M7EacptWhdcRfod/J6LdY/xRrZqq+dBBFNvD4rEGcOc=;
 b=anjPj11dJdoCI3q+2tQl4QAjK2HOvkhmtMlrbs98CTgytOg2UzIX7PtwcEQQcsw+j6
 sFouxqGnPKvILLgy0o9etG7ES8LNnZkGjOLAoFvL8+KZqV6fv12tki2lbWGNpQRxuqrN
 f9Qlg4IuqZYECtsiETx8+kSX0tfURoRjdY8QCLb39dfBu+5AhR2UsBQUf0DODin9Nsk6
 MJxMzRI4aMBTpFqTgUhc01FbeRxJEEVOc94T877iicjYB5fkPNvHFj+cMxdz4eL5717q
 tkGuHFNSoiFcPGILy2M9W1X/dcXQx2A5k1Cw0nlh3ck3m69Stnk2om9lf8HZzeON6gMu
 h8JA==
X-Gm-Message-State: AOJu0Yw/6zby3+WZwDJ58zCesejZ+2cgq6sBmu5YHbwj8S8DiqMVaA37
 C9S/XfY8lVoVOX2wo6C8Ls0ecYUA0cId6gJKay0NzlI+kKQ/m0RejbWqecedAW+L0fSrmRZTMgc
 DRqd1sU0=
X-Gm-Gg: ATEYQzyJVDg7jPfYrPZo8xemRboYjZ7FlApaNzPu79s8unrjXXCJ8t+S9GRDjDwjgjX
 uQLKauthNBTowKEF1HlTGDn7ePceyq3iSEROJdKOwgqtoad9K5lUfnWrSzbWotVPdmiZFu3zxci
 PPhtiw1CEZPspPzzIlDxZ4d7GAu33QHmopJT+DpTdKWypUeKwL9EFLb7OHwIQT+h3umHOYzP510
 lD5XT9Z1nXXdnCn0k33waEE02EkdC9CkT9pJrNuDVwRq1UkDgpjYlGzzU2Oxx8Y5uI70E8xJj2P
 pVyNVQvWfoySWCakMKvo/eLDgHcXAilknBUKYE6iKZEdCSgRGlM8bbcqcEnEnIzkFT7D86GWKl4
 lY+gulIRpgwuFjteJMigxhcTw2EUuJYdjBE1LLyKVDAVi92YypAkTm2jfmeN09kltUf+SIPn1G/
 s+7HnhVspr22GPA2QHCn0/TpLYkIno9ydiwJV1PzLnah1UaoCLnU7EbuWo5DZWvHR5ZK4Sx46Cp
 loaDw==
X-Received: by 2002:a05:6000:2893:b0:439:c560:bb79 with SMTP id
 ffacd0b85a97d-439fe195f05mr11345506f8f.17.1773383027579; 
 Thu, 12 Mar 2026 23:23:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe19aec5sm14534897f8f.4.2026.03.12.23.23.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Mar 2026 23:23:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 25/38] hw/m68k: Include full path to target 'cpu.h' header
Date: Fri, 13 Mar 2026 07:20:41 +0100
Message-ID: <20260313062055.2188-26-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313062055.2188-1-philmd@linaro.org>
References: <20260313062055.2188-1-philmd@linaro.org>
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
 hw/intc/m68k_irqc.c | 2 +-
 hw/m68k/an5206.c    | 2 +-
 hw/m68k/mcf5206.c   | 2 +-
 hw/m68k/mcf5208.c   | 2 +-
 hw/m68k/mcf_intc.c  | 2 +-
 hw/m68k/q800-glue.c | 2 +-
 hw/m68k/q800.c      | 2 +-
 hw/m68k/virt.c      | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/intc/m68k_irqc.c b/hw/intc/m68k_irqc.c
index c652bf143f0..68ddb5351be 100644
--- a/hw/intc/m68k_irqc.c
+++ b/hw/intc/m68k_irqc.c
@@ -8,7 +8,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "cpu.h"
+#include "target/m68k/cpu.h"
 #include "migration/vmstate.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/nmi.h"
diff --git a/hw/m68k/an5206.c b/hw/m68k/an5206.c
index f92a5d6a339..1acd2fbdfb3 100644
--- a/hw/m68k/an5206.c
+++ b/hw/m68k/an5206.c
@@ -8,7 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "cpu.h"
+#include "target/m68k/cpu.h"
 #include "hw/m68k/mcf.h"
 #include "hw/core/boards.h"
 #include "hw/core/loader.h"
diff --git a/hw/m68k/mcf5206.c b/hw/m68k/mcf5206.c
index c5befa02eb5..9f373b99b12 100644
--- a/hw/m68k/mcf5206.c
+++ b/hw/m68k/mcf5206.c
@@ -9,7 +9,7 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
-#include "cpu.h"
+#include "target/m68k/cpu.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/boards.h"
 #include "hw/core/irq.h"
diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index 0e07aa45e9d..a8068c91f24 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -20,7 +20,7 @@
 #include "qemu/log.h"
 #include "qapi/error.h"
 #include "qemu/datadir.h"
-#include "cpu.h"
+#include "target/m68k/cpu.h"
 #include "hw/core/irq.h"
 #include "hw/m68k/mcf.h"
 #include "hw/m68k/mcf_fec.h"
diff --git a/hw/m68k/mcf_intc.c b/hw/m68k/mcf_intc.c
index 1014fe6fa57..e8d3bd937de 100644
--- a/hw/m68k/mcf_intc.c
+++ b/hw/m68k/mcf_intc.c
@@ -10,7 +10,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "qemu/log.h"
-#include "cpu.h"
+#include "target/m68k/cpu.h"
 #include "hw/core/irq.h"
 #include "hw/core/sysbus.h"
 #include "hw/m68k/mcf.h"
diff --git a/hw/m68k/q800-glue.c b/hw/m68k/q800-glue.c
index 24fccab9666..ac9062c6488 100644
--- a/hw/m68k/q800-glue.c
+++ b/hw/m68k/q800-glue.c
@@ -21,7 +21,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "cpu.h"
+#include "target/m68k/cpu.h"
 #include "hw/m68k/q800-glue.h"
 #include "hw/core/boards.h"
 #include "hw/core/irq.h"
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index ded531394e6..bcd1f99df81 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -26,7 +26,7 @@
 #include "qemu/guest-random.h"
 #include "exec/target_page.h"
 #include "system/system.h"
-#include "cpu.h"
+#include "target/m68k/cpu.h"
 #include "hw/core/boards.h"
 #include "hw/core/or-irq.h"
 #include "elf.h"
diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index e67900c727d..f25ba64d835 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -12,7 +12,7 @@
 #include "qemu/guest-random.h"
 #include "exec/target_page.h"
 #include "system/system.h"
-#include "cpu.h"
+#include "target/m68k/cpu.h"
 #include "hw/core/boards.h"
 #include "hw/core/qdev-properties.h"
 #include "elf.h"
-- 
2.53.0


