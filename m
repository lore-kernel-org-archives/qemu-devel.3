Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA11106FD89
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 06:25:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0vxK-0003I7-Nl; Fri, 13 Mar 2026 02:25:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vx2-00033O-Ms
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:24:49 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vwy-0007KZ-U2
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:24:47 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-439bcec8613so1415311f8f.3
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 23:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773383083; x=1773987883; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rvwuNK1HNpURpRjKH5UGgP2sTiJOZts3dEHrxjH12MU=;
 b=tvcoQKeqLdryZC6C6Yt6TzQLBUKXlJgfIjEjang/p7awrq6WyWlo0VqbdhwZOBflR+
 4WThEMVl74Jz+O2brxrDLWHZoVArysNgMQ0KsvLaYmSRjepspVbvdTumF22MKF0XQkOc
 F5uUmnNRAbsifHwC5pBfoFzKKYITSnn4EekNOVRVLohuuE/BrA4MCv6rmXRYxf7yax/A
 0Vwoi4tmaRdpDLxN7YK1FilI2X6XhR7P8+Jr3FPV4iMxFO8SqNMfcTfmtHqUlOBujiQw
 TZE5Pg62w8xHxSBqY2EFN5NTL0mFmnGDOAjo8OahUlGLRma3fSEq2Zx8qt1EuLp2U7vI
 GPMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773383083; x=1773987883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rvwuNK1HNpURpRjKH5UGgP2sTiJOZts3dEHrxjH12MU=;
 b=lS5GvBSAmqeZ0+xtk0WaGzbx8CiTO2rw8Hb1y+AaJOcC1KjeiHrW3Jo/9jWyHl49mu
 BpLPENwvbsB2IQLawqrAq4CtuCRBVWv4/xcAvy7sBbaEJz7XM2KX7skBfdcTFsW9vzla
 /m5tsyRaJpuaDwLva++Jrfu0sPSrHW/sLzkJeeVR8O5IBLL5koZDNhr33nuiS4f02mUV
 AhyKxtM6jfVtcElaewapfi6zWHLAnv1H4fyQg6Ucfb8ansPn3TresIuWymneoD9gkr/1
 NqGatG2H26L9nRSbldaJNpJdKqH0rHIsb0cIbRQ3i8RpzMlOoq06DtI8GYsL7CmwSRsR
 1dmg==
X-Gm-Message-State: AOJu0Yyi7KxGVJ4KvvI9iTal+k2Kj7ruLUuxxt6H0uyaDGdV9nJn6NI4
 /LQYq8CZlBsTHEAJFJ/Lh2dK5wm7LmCfNXORrPIVDwHyYRnZOwZGpABe3VCJ+AKgqHQegFFYFDS
 hU3sW1Q4=
X-Gm-Gg: ATEYQzwxP4Q9Z/86LawUsoUoDFeib4rctwn1k4lFZg08sEnKRogJ193LEO0aSEbCQMA
 i5UD3ueLdr+PPsexSYB62CGcKsvpenmouYaHVHZkykAqBIx2bel0lSpN4/40tIvj61G1WgQ1Q3E
 lI6rQk+R39eAbovoqiAoEOWIuL6HSJSu3iAtMGNMxOwfQpjEZr98XqXhSUhHU7fqj8T49ebtd/W
 gE6ZNaZ7W3ES0wdeGrnffK8RNVegW90WjPIaK4Neobc2WTPZ4q94ZLQZiqmiksFKJvLDw6ISp/m
 tDDfC8Yw1ez8Exap3HQQqi8r88w7jTEPYMLI97FB4bH4L5IjFS8XTns4k+2pgGgqGaiivr8LLd+
 MsirIThhdvy2oRzCyx+vmLyhB5gre1ld0XXkk9YRWqyOg4SEj44jMa6+Bh5b4RJQh3KmoiSaZOP
 3jiRpbMLkJztpP+R9cjAVgD9/11E13tsFTm86O1wXbrHig9Lh071Ys9LVJ7QK2um4vfu0WVK+Bd
 dcFvQ==
X-Received: by 2002:a5d:5e01:0:b0:439:ad2d:99f7 with SMTP id
 ffacd0b85a97d-43a04db7ceemr3850616f8f.28.1773383083029; 
 Thu, 12 Mar 2026 23:24:43 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe1b22e7sm15158835f8f.16.2026.03.12.23.24.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Mar 2026 23:24:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 33/38] hw/sparc: Include full path to target 'cpu.h' header
Date: Fri, 13 Mar 2026 07:20:49 +0100
Message-ID: <20260313062055.2188-34-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313062055.2188-1-philmd@linaro.org>
References: <20260313062055.2188-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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
 hw/sparc/leon3.c     | 2 +-
 hw/sparc/sun4m.c     | 2 +-
 hw/sparc64/niagara.c | 2 +-
 hw/sparc64/sparc64.c | 2 +-
 hw/sparc64/sun4u.c   | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 9147d56bd4e..d4a6e917598 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -30,7 +30,7 @@
 #include "qapi/error.h"
 #include "qemu/datadir.h"
 #include "exec/cpu-common.h"
-#include "cpu.h"
+#include "target/sparc/cpu.h"
 #include "hw/core/irq.h"
 #include "qemu/timer.h"
 #include "hw/core/ptimer.h"
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 46fcbdda97e..550acdff6d4 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -26,7 +26,7 @@
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu/datadir.h"
-#include "cpu.h"
+#include "target/sparc/cpu.h"
 #include "exec/target_page.h"
 #include "hw/core/sysbus.h"
 #include "qemu/error-report.h"
diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
index 209be380473..1211ecb82d4 100644
--- a/hw/sparc64/niagara.c
+++ b/hw/sparc64/niagara.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "block/block_int-common.h"
 #include "qemu/units.h"
-#include "cpu.h"
+#include "target/sparc/cpu.h"
 #include "hw/core/boards.h"
 #include "hw/char/serial-mm.h"
 #include "hw/misc/unimp.h"
diff --git a/hw/sparc64/sparc64.c b/hw/sparc64/sparc64.c
index ce7eded143b..16f4aa052bc 100644
--- a/hw/sparc64/sparc64.c
+++ b/hw/sparc64/sparc64.c
@@ -25,7 +25,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "cpu.h"
+#include "target/sparc/cpu.h"
 #include "hw/core/boards.h"
 #include "hw/sparc/sparc64.h"
 #include "qemu/timer.h"
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 2e41785b783..d69ed9a81ac 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -27,7 +27,7 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qemu/datadir.h"
-#include "cpu.h"
+#include "target/sparc/cpu.h"
 #include "exec/target_page.h"
 #include "hw/core/irq.h"
 #include "hw/pci/pci.h"
-- 
2.53.0


