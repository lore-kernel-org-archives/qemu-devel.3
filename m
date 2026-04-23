Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F96F9936A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:10:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFqyJ-00075S-Oz; Thu, 23 Apr 2026 06:07:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFqxw-0006w7-9O
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:07:27 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFqxr-0004Cz-SZ
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:07:24 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488ff90d6c7so52260335e9.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938838; x=1777543638; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pAUwrUFoNwCxotOSaRCj0lyhRhgtkP0+vfDbYmh5aNM=;
 b=osBPhgJ0jG3p6e1JDfL8P0oOziYLdt/z3qwpC+hWiccKt9c9fDBNcB5C2zIWEAWi/+
 kDKehO74LEM34v1dB52U0TeKqdax0xg9HNqWKd7L7/xDZ7y/AslU2/V3rwbC5PI8qX6U
 4A4laXJup5UkX92ezWjrvsG+MUZg9tkeqUaFh7Fk0mlkQ/TFz1LIx1ED/wunrliE6qZQ
 tIsTJuHw7+DRXrFCyoIRWlQJJOC8Yq9NqIu+S7+jg7VyfpCI6+I42GMnMrWh3wtfE6Jf
 IBmumqXWnvOYGtyJ3rRwNGb/ZjInPEeyYl6dp+vcQDhXxHieylPKvzhbLHPildzmQzNO
 RfSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938838; x=1777543638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pAUwrUFoNwCxotOSaRCj0lyhRhgtkP0+vfDbYmh5aNM=;
 b=FhBWYlhyPMC9l04MFe49jH77zu75EpyJX8yq92m/J/fGtDQu5nAmQDs2e54RWAfjKN
 RRUv6bjgMb2rdcAXZN+VlBosd6D+gdXrjUe7jr0IIEGoReAz6PibCtGyQEYKmIC7iYw6
 jb+YhXa5Nut+xLbhZ+UtRpVueExe7JbiUOKY4vjkDLP6HIEnntvKhE6c/hamMKUN6EIw
 Sh1yecjqYxvhsGdt4OiqaD9xa6nDzeIe66ckyHwFIsAkNXnaGjDY2sX/3ni32XPIQncl
 35CdA8oIc6dEvF5YhEuk6XpjfsF8Zxj3kKlqUtYAucnjzgtPd7m1PjRFG7ywC784y++j
 xfjw==
X-Gm-Message-State: AOJu0YwxDC+N/BYDw3DF0CF2kNIzOWIWkaj1t7rlPEtK/IraREN/8Ksy
 f5WvUDdrrBHxlIRe8h6rHCkOWzADxQeBMyXoJ/q4X4rTwYDcx3EuWrmo41lo2IHs0WQE+UeagDT
 MPhpR1Sk=
X-Gm-Gg: AeBDiesBtVIZ+EBM5hMxVb5V6ZDtbT4au7yClOSepUIMwwcIHs/ms/PY3b39Mp8COxG
 kgY25OvuvRmZq2w+wB0HXFl9NZAun9qiZpnAh0yQJtJAhtkdO5ErELdemWT/dNUJMu3yMMIcy4J
 TTZRhXBWHCl53WXEQ+/FuoUd0xgPl12b2AAEH8S9A7mb1ElTFnBIvb5iVHW/UvS49dFoAjGRIky
 Ws+bPYfxkPuQ+yDciu3DpHSbojQUh0EbSf4i6V7E58dGgkDpqzqINXDvFYl39880+mZmmg/ozzX
 nojmcGFoECh4FTjH0Z7l3m7RP2gsGN1AyAx75bhqdOrsF9rI/G7gf+8BX/QvSJFxGGpILs1uESB
 3B+BFwBSbizVfymJklxBxjGyagTP1CaXBaxYDNBJxWLK59GglKFkZZe9UNxukx0CVKspeCA/ZZO
 MuxYK+6nnmMrW2JmqS+V5i1GvA+S6o9Lq+YTeZlE6Z1GS8ElARt4qtK3QTPB0cod3XYqB3SnUK5
 CKZlz7j7nA=
X-Received: by 2002:a05:600c:3483:b0:488:af7f:775f with SMTP id
 5b1f17b1804b1-488fb77d343mr354888205e9.18.1776938837685; 
 Thu, 23 Apr 2026 03:07:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e3a18csm59413914f8f.20.2026.04.23.03.07.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Apr 2026 03:07:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 9/9] target/microblaze: Compile translate.c as common unit
Date: Thu, 23 Apr 2026 12:06:12 +0200
Message-ID: <20260423100612.27278-10-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423100612.27278-1-philmd@linaro.org>
References: <20260423100612.27278-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

In order do build translate.c as a common unit we need to
replace:

  "accel/tcg/cpu-ldst.h" -> "accel/tcg/cpu-ldst-common.h"

and:

  #include "tcg/tcg-op.h" -> #include "tcg/tcg-op-common.h"
                          -> #include "tcg/tcg-op-mem.h"

taking care to define TCG_ADDRESS_BITS, which is fixed
for these 32-bit targets.

Remove the now empty microblaze_ss[] source set.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/microblaze/translate.c | 6 ++++--
 target/microblaze/meson.build | 7 +------
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 6321b739ab4..f973c392aa2 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -20,9 +20,11 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/cpu-ldst-common.h"
 #include "accel/tcg/cpu-mmu-index.h"
-#include "tcg/tcg-op.h"
+#define TCG_ADDRESS_BITS 32
+#include "tcg/tcg-op-common.h"
+#include "tcg/tcg-op-mem.h"
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
 #include "exec/translator.h"
diff --git a/target/microblaze/meson.build b/target/microblaze/meson.build
index 2ce50f35397..9c1ecd1cf1c 100644
--- a/target/microblaze/meson.build
+++ b/target/microblaze/meson.build
@@ -1,16 +1,12 @@
 gen = decodetree.process('insns.decode')
 
 microblaze_common_ss = ss.source_set()
+microblaze_common_ss.add(gen)
 microblaze_common_ss.add(files(
   'cpu.c',
   'gdbstub.c',
   'helper.c',
   'op_helper.c',
-))
-
-microblaze_ss = ss.source_set()
-microblaze_ss.add(gen)
-microblaze_ss.add(files(
   'translate.c',
 ))
 
@@ -26,7 +22,6 @@ microblaze_system_ss.add(files(
   'machine.c',
 ))
 
-target_arch += {'microblaze': microblaze_ss}
 target_user_arch += {'microblaze': microblaze_user_ss}
 target_system_arch += {'microblaze': microblaze_system_ss}
 target_common_system_arch += {'microblaze': microblaze_common_system_ss}
-- 
2.53.0


