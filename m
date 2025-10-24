Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B626CCF9E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 19:20:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCNKL-0001fK-1o; Fri, 24 Oct 2025 15:19:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCNKJ-0001eC-Tm
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 15:19:51 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCNKH-0007lr-Ef
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 15:19:51 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-475c1f433d8so20001745e9.3
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 12:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761333587; x=1761938387; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zleqKSDiqV6ouXCL2Ql1+wJ3D/HsznftIZvTGyjA1o8=;
 b=bCkDVJ8NBUT3ftNmyNT8gF+Koc9BRr3ZjuAY33QfEDq8jMkBJVvmnW7KbJaPUgTNME
 rzQajE5y49O7rOekZ6V93a0E/YcJMbzYyp69oFvcyylp3yNK9KmzU4Cwx9aXF9xjD/pZ
 zqaIp40OteLle1Wk/PkKMtplI4/DbviNfZj25Y2iiJI7mpgGKtt60DOLgHAuacjHM9Nz
 IRMfGSgZMiAd+fv/nonJIuIBie5RlVqRpL4MDXowNxW2F0RLDGUTdhXmPSf600EdDRLv
 nsTszaJkVPKvJgh9l7i8pC32SEIyBOUt8Sc9kS6nxZZCPLB4TMYuy98Gyauhj8CIkxeG
 wCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761333587; x=1761938387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zleqKSDiqV6ouXCL2Ql1+wJ3D/HsznftIZvTGyjA1o8=;
 b=SYwVa0u18XHuxVCyVcjfkg+kwJju6mXjAgM//HdnwzxMhfc4rVF2jivgDL6nOP7AF4
 PSLhXyBnbSOXf7PrUlxCG7Jb6CV7c250ncr1sVniwPW1a7vSpzeK4PcFxOMTFWumQgJB
 jiYrSFwNuC5x/EhOJucQC4xH5PS2mZ6pI76qasE6PGt6KkOxdKJo8dVKpgaEyhveU1vQ
 OCaC5INrOfhtYRxPCTAnah2XOXG0qDTXJjnr1Tpz0HJU/oV6Cj0eCpKf5jP70Kt8zWTY
 oUcagtxbGKlir+m2+Eoiafe/DhWfBGMZqQpbhhqfk14zjAwwN/bbHfmY0tLXJoM4lEdx
 +bSQ==
X-Gm-Message-State: AOJu0YyJ6KxwnY8/PjZWdq6OCk6WyGdFOps3KHQtsmYNzOnNVgN1lz+I
 /rmwVpwp5mfe48kH2GwMfuVqmHw86/08Yx6Oa0mpMVhqJsORADr8mLd4W+0I7Voif08OI+oIdL1
 LodXM0DU=
X-Gm-Gg: ASbGnctB0nJ4+KVfE35uZ1E0EyCPwuCxJTTWdVZ/j1hIiZg47nZ9P3y3rVhfjGDPiBt
 r/Jf5abtK2fBZJKfurxkboyHBGcd+a1dWAXZmZDIcXgMt6UqJOM3RUe7sotFIAEXuBq+kze18Id
 dIzmJnuPN4TQxfQKIpcBCGTvh60dzgkv3oZOYNZ39vmZvfZZwaeNqg785rYFLIaYLmQ8H9ZP0jr
 gs/pRIfoTfzBFdqbhTnG9Y3CIhCuT/RHol+MunCFzIIeWg37eAd7GUO1OhfcewzTZdGogme0yus
 f7aKSmi/yDQ+lEjdzVeYIfxxgQhpuDFkZRDbmHmX3nPlFKa75o1oIJX39G0U+Q2HJEUepvGhJex
 3Gn0/rMYKO20WWvxifB0rzd5bnvhdUMjFJADptZKxJMKiJrBh7Ak3z3h4p6aQ01MEY0GWujTpqI
 IRlm4zetJfc/6Snb6tvwto1tX1cQdY5N9IMazLo2D5hZEA6QBa2rj3AXVj6uIa
X-Google-Smtp-Source: AGHT+IHGwA1LU6+hLBZrPJrwX3FYLkn8oGJ8pXrlyqWkQmDZDbUjpAleQmiisYsyqpwE89HlnUBLcQ==
X-Received: by 2002:a05:600c:8214:b0:471:1306:aa14 with SMTP id
 5b1f17b1804b1-47117931e47mr214993075e9.40.1761333587126; 
 Fri, 24 Oct 2025 12:19:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475caf2ef9fsm105205925e9.13.2025.10.24.12.19.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Oct 2025 12:19:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH 10/27] hw/block/pflash: Include missing 'system/memory.h'
 header
Date: Fri, 24 Oct 2025 21:03:57 +0200
Message-ID: <20251024190416.8803-11-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024190416.8803-1-philmd@linaro.org>
References: <20251024190416.8803-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

"system/memory.h" header is indirectly pulled by "hw/sysbus.h".
Include it explicitly to avoid when refactoring the latter:

  hw/block/pflash_cfi01.c:83:18: error: field has incomplete type 'MemoryRegion' (aka 'struct MemoryRegion')
     83 |     MemoryRegion mem;
        |                  ^
  hw/block/pflash_cfi02.c:100:18: error: field has incomplete type 'MemoryRegion' (aka 'struct MemoryRegion')
    100 |     MemoryRegion mem;
        |                  ^
  include/qemu/typedefs.h:68:16: note: forward declaration of 'struct MemoryRegion'
     68 | typedef struct MemoryRegion MemoryRegion;
        |                ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/block/pflash_cfi01.c | 1 +
 hw/block/pflash_cfi02.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 168101d8dfe..04c30d17a99 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -51,6 +51,7 @@
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "system/blockdev.h"
+#include "system/memory.h"
 #include "system/runstate.h"
 #include "trace.h"
 
diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index 3244b699b98..a2106a7ed9b 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -42,6 +42,7 @@
 #include "qemu/bitmap.h"
 #include "qemu/timer.h"
 #include "system/block-backend.h"
+#include "system/memory.h"
 #include "qemu/host-utils.h"
 #include "qemu/module.h"
 #include "hw/sysbus.h"
-- 
2.51.0


