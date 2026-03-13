Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB38106FD8B
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 06:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0vu9-0001wo-Tv; Fri, 13 Mar 2026 02:21:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vu8-0001u5-L9
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:21:48 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vu6-0006vP-Uy
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:21:48 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-439cb5af25bso1906040f8f.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 23:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773382905; x=1773987705; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DL4KDNiZWKz37LUPD5n71bwyFUxo90hkjC+vZWlN9+4=;
 b=jXwU8MODwjBIOgcGOBR6Im7HCbQKKCY22KTj2hvFgoaMcDA1Cz2L30yWd9vPA/05ap
 D0lF8vU9L9BazuXaOJVekEYXqzqe2zBR5bBf+FjgMZZOAdj/n5HWWZbFwrTglwA4xzbe
 9HrJy3mqIHkiV6ydqj0cC5fy95tvbpjzL5fCjZWsm0I81xv9G7nwxkxMnSuScu5GZ1GA
 gBTfuIeB4AolhA5RNBOigjIt8qHYitrJPCZT+YymnIi9FRviSqA3VGvToeo2OQaJNoL6
 qB0pY8ixD+7icZolm2swVToaEGuz/O2AaZaMTqGB0HBvzbaGVudTQoDlDyYMg98BqFtt
 wQaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773382905; x=1773987705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DL4KDNiZWKz37LUPD5n71bwyFUxo90hkjC+vZWlN9+4=;
 b=N0SNBMZ0wOwwBsePBk5nJbQ01RwHI13AanIkN7nwdZXR6q7ReWwYCM2RwDsQLwsNTv
 IEMM5Ek05/A3jPDz3H36iCltRl9L3K8ofo0Sr4k6DMSBOHZr0rQv8w8ulyt0uLcIeLZy
 V/4WqCeOl4bIK4yu4jlakvxzpCUBTKZ48pmvPvGKDi68LzM2sJ5ex/qFzYZJDIkFWtUD
 wy9zOzKRbhp0GYc2RHGGWq7C4c/Ly41nHTpPu0yC+TXFzK6u7V7F3YkPhUQqwHBKnqEj
 ZJqqnQWNdeDrv8dCqyJAfX1xOvq/NN9+WOK+rO6ANaINTHSfgxb1P/bYxFdGFF9foaBO
 37Cw==
X-Gm-Message-State: AOJu0YxmH9aQ1DjuG0jrdV8aKCDwEkOBKe3jiKX7YrR/feGdYWrxRLEB
 99sbGXEGV6IxLXUHOghN9zobCQFUPfe79/I4ZvfViBtAwuZa1NIx4t9l9BUJq5Fsu3VJDLEYIll
 Kb6qAVxs=
X-Gm-Gg: ATEYQzz1wwEg1rw0c7viGm8WiHyatIz9YGBg23VAXo6H/u52yB8AM9zvFbBeAgoY4WA
 Ux7lkmsTCsd9EVNriym0aPT1bapJsXAbJrCr5H0X1lXNQUQRmD6LjGKIsLsUAsOPObsVYWd9Qs/
 9UMte5m6kNdxocy6bkmFtmV6r/k5YCBjrRv2AeOy6a97efHHt58Lbd0eBCO1HCqHNVHwbj7swjr
 IfNBomfI//Pb3pDw+PWpOlbweO09bWOt13vxs5Gvs+0jwBKuOceOZlSEVp3hTBSnymY9aZcFr1t
 g4K94Abpm/xlp6qxTwCAcsGlRSNeiVa/Z6gJ+vbXKflrMdOJ0J0+BhC+LsS3o/WnJeCGYIgfT0l
 15PPIY8VpdXEtwfV1SJWyuIjXzgW5Ed1hoVAYSiTvVnylq//jTxtXit3mJ89fE+fhse1rex3aYC
 oGN5j4M2T07v6psgn8FPAl8SvJgqOlV/3kwqeYzcXi+yxNTBBWkxyjPCGP+8TLkdxiogZsWIxzR
 D6zsQ==
X-Received: by 2002:a05:600c:1e8c:b0:485:3e00:9440 with SMTP id
 5b1f17b1804b1-4855670c296mr27215285e9.24.1773382905024; 
 Thu, 12 Mar 2026 23:21:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b66dedfsm187292095e9.12.2026.03.12.23.21.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Mar 2026 23:21:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 07/38] target/hexagon: Include missing 'exec/target_long.h'
 header
Date: Fri, 13 Mar 2026 07:20:23 +0100
Message-ID: <20260313062055.2188-8-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313062055.2188-1-philmd@linaro.org>
References: <20260313062055.2188-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

The "exec/target_long.h" header is indirectly included, pulled
via "exec/cpu-defs.h". Include it explicitly otherwise we'd get
when removing the latter:

  ../target/hexagon/cpu.h:76:5: error: unknown type name ‘target_ulong’
     76 |     target_ulong gpr[TOTAL_PER_THREAD_REGS];
        |     ^~~~~~~~~~~~
  ../target/hexagon/mmvec/mmvec.h:69:5: error: unknown type name ‘target_ulong’
     69 |     target_ulong va[MAX_VEC_SIZE_BYTES];
        |     ^~~~~~~~~~~~

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hexagon/cpu.h         | 2 ++
 target/hexagon/mmvec/mmvec.h | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index 85afd592778..7a91399fe02 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -23,9 +23,11 @@
 #include "cpu-qom.h"
 #include "exec/cpu-common.h"
 #include "exec/cpu-defs.h"
+#include "exec/target_long.h"
 #include "hex_regs.h"
 #include "mmvec/mmvec.h"
 #include "hw/core/registerfields.h"
+#include "qemu/bitmap.h"
 
 #ifndef CONFIG_USER_ONLY
 #error "Hexagon does not support system emulation"
diff --git a/target/hexagon/mmvec/mmvec.h b/target/hexagon/mmvec/mmvec.h
index 52d470709c0..4a4f6cc9805 100644
--- a/target/hexagon/mmvec/mmvec.h
+++ b/target/hexagon/mmvec/mmvec.h
@@ -18,6 +18,9 @@
 #ifndef HEXAGON_MMVEC_H
 #define HEXAGON_MMVEC_H
 
+#include "exec/target_long.h"
+#include "qemu/bitmap.h"
+
 #define MAX_VEC_SIZE_LOGBYTES 7
 #define MAX_VEC_SIZE_BYTES  (1 << MAX_VEC_SIZE_LOGBYTES)
 
-- 
2.53.0


