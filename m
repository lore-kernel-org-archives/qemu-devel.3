Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32885D26D75
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 16:38:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veFUd-0001ZR-Uv; Fri, 09 Jan 2026 11:37:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veFUc-0001YU-9V
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:37:42 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veFUa-0005CA-Oz
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:37:42 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47d493a9b96so26582265e9.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 08:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767976659; x=1768581459; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RTAOH/xq/3mecKgOFQc299O+6eUqLk/ATHdhAOXEHr4=;
 b=CctMPBhtYjRCwN9Kr5EKxK+eQHboeohynCoMfWQf60pEPXe/i6YpOlyXMhrBXNtOob
 H5VLX6102X25h2b7HMVJbhGFJM3ws5wb3rLuUssnlm/qu8MOKUA2J+NAGPQN4UJ8W1Sk
 IPdnxyU6/HvkyVyQgiXe/5NiOWfDdR9uu5Ah1d+Lr5FhjrkKw8DWKrr/5YTwC6EEDK3z
 ScHe6VlWsJgwImvsznzjAuQfAyYNqCZhUR8Gc2uooPEUP5PoechLbRMj3nle3FW55dPp
 1XOFfZzV7h1oAnI00KekvnWogJZnuqrWMCXTDKxhlxCTr3MarQKFruN3+t2xabEIMo15
 GKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767976659; x=1768581459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RTAOH/xq/3mecKgOFQc299O+6eUqLk/ATHdhAOXEHr4=;
 b=hAW6NBmRnrdzbOMzP9PiEjtjWwqOg6uekzxj7LIDGZCPPBRQ+jZUgVKeeKQzVgRKRq
 6AzvJXQXtoQ+rtEvl9A3QUvyH1W3fqIO3yzHBttVK467IiLCxrTsfHwlFoXucLQz1TpX
 Q2xyR6MzZDEzix96UeaG6GEzPkjX75+JM6NcJmUGDIGUmSGr8jxsSOHHgFsN6Fnhth8F
 808P5Y4Mrk0pajBbGLbWsTgpqJtxRCcUlIRyMZ+VD3oqtBpmDWD8C1kCRL5j/YGdGv8W
 PI0fmhbivYXTZ5caDn/qE7bgCbe2aoSxCcyIcMylATWfajAuW4cw6w9pN3lzXMzOeGw4
 lqXA==
X-Gm-Message-State: AOJu0YwQlZNAEiGs7imODEYh6JL6Sm5RWqvIZfiVNeMMmng9vm2KIqnw
 Ce73+PFJXopkg6BGqocUN2vuR2ZcMMj96a4lq0PqHFBRTiTHRH/2uelSTbEl3tI9ypPxuNb4lVV
 qAUDGmOo=
X-Gm-Gg: AY/fxX4eN2vwG/76LIvzPbbpZ7N9kK0AHM1PchUTe3H2XBLj6nwPj32HPEfzQfe9g1w
 CkSlxSkJ64Si0sKf9I3stLJloEmi0t9yeQbsapgbscXCtghApLWtDRdE93rnAARmlg+evVcFmtp
 anhMIHbjxYxUs3mQyElIRXTuMh5cl3f+2ZHPC2CnjCNwhc4ViUY83L6WVtO2Zn3ZK0SKbbc9BCR
 QHiPCPOo/+kZGatBiicXoKqJ4MrT4TGDZOW8xPymwwvskUGwX9wbEFVpKgC666v/BdjhOLrZgrV
 IiGbjdkyYtfb9o3ThAXFgdxIOdw+WvTH7eCtD/0rEqACcVjVWf8pZRIC4amC+1mu+0f7CB4HX0I
 nGXfdXfb2GDVrRBM1ND/nzzSIsY1wxJBPvzREVzFnKrR/DPP0GzIdiw0SvJRqLlbv2ClhJLb6zD
 4FbXtqX3pWoiOSTDiWn8Kq2TsH/DOMov1+NhNO/U1aGmQbOM9W32cMDY2PZF3QRspywCAB6M4=
X-Google-Smtp-Source: AGHT+IE5cP4wnBd9LPgulSUJJsxRjTphjnG96PHMEZ6Bb70QYqFUNO60OQyKoF0lqqpm7fjdhibohQ==
X-Received: by 2002:a05:600c:6385:b0:477:632a:fd67 with SMTP id
 5b1f17b1804b1-47d84b1a166mr125617875e9.12.1767976658916; 
 Fri, 09 Jan 2026 08:37:38 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f68f686sm215346185e9.3.2026.01.09.08.37.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Jan 2026 08:37:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 1/3] bswap: Use 'qemu/bswap.h' instead of 'qemu/host-utils.h'
Date: Fri,  9 Jan 2026 17:37:28 +0100
Message-ID: <20260109163730.57087-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109163730.57087-1-philmd@linaro.org>
References: <20260109163730.57087-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

These files only require "qemu/bswap.h", not "qemu/host-utils.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/qtest/ahci-test.c              | 2 +-
 tests/qtest/libqos/ahci.c            | 2 +-
 tests/qtest/libqos/generic-pcihost.c | 2 +-
 tests/qtest/libqos/pci-spapr.c       | 2 +-
 util/hbitmap.c                       | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index e8aabfc13f5..5c32ff20029 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -31,7 +31,7 @@
 #include "libqos/pci-pc.h"
 
 #include "qobject/qdict.h"
-#include "qemu/host-utils.h"
+#include "qemu/bswap.h"
 
 #include "hw/pci/pci_ids.h"
 #include "hw/pci/pci_regs.h"
diff --git a/tests/qtest/libqos/ahci.c b/tests/qtest/libqos/ahci.c
index 34a75b7f43b..0621a6c4775 100644
--- a/tests/qtest/libqos/ahci.c
+++ b/tests/qtest/libqos/ahci.c
@@ -28,7 +28,7 @@
 #include "ahci.h"
 #include "pci-pc.h"
 
-#include "qemu/host-utils.h"
+#include "qemu/bswap.h"
 
 #include "hw/pci/pci_ids.h"
 #include "hw/pci/pci_regs.h"
diff --git a/tests/qtest/libqos/generic-pcihost.c b/tests/qtest/libqos/generic-pcihost.c
index 4bbeb5ff508..b77617524ca 100644
--- a/tests/qtest/libqos/generic-pcihost.c
+++ b/tests/qtest/libqos/generic-pcihost.c
@@ -15,7 +15,7 @@
 #include "generic-pcihost.h"
 #include "qobject/qdict.h"
 #include "hw/pci/pci_regs.h"
-#include "qemu/host-utils.h"
+#include "qemu/bswap.h"
 
 #include "qemu/module.h"
 
diff --git a/tests/qtest/libqos/pci-spapr.c b/tests/qtest/libqos/pci-spapr.c
index 0f1023e4a73..3723cbb38db 100644
--- a/tests/qtest/libqos/pci-spapr.c
+++ b/tests/qtest/libqos/pci-spapr.c
@@ -13,7 +13,7 @@
 
 #include "hw/pci/pci_regs.h"
 
-#include "qemu/host-utils.h"
+#include "qemu/bswap.h"
 #include "qemu/module.h"
 
 /*
diff --git a/util/hbitmap.c b/util/hbitmap.c
index d9a1dabc630..3525bf7751a 100644
--- a/util/hbitmap.c
+++ b/util/hbitmap.c
@@ -10,8 +10,8 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/bswap.h"
 #include "qemu/hbitmap.h"
-#include "qemu/host-utils.h"
 #include "trace.h"
 #include "crypto/hash.h"
 
-- 
2.52.0


