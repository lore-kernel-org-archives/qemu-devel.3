Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE19F99368
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:08:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFqxC-0003dK-TG; Thu, 23 Apr 2026 06:06:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFqwz-0003Pi-M7
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:06:27 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFqwx-0003od-Kb
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:06:25 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-43d70b3e159so3276283f8f.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938782; x=1777543582; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HZkYQx3viFK4Zwt+Z+/jMviqVF5Tb2F+0CaOgixxDFM=;
 b=Dbr+iDBRSKsrXqvuN1r7pa9oAHfpaVTfU0IcpEapMZK8Nbc2FdnGnru4TMhfMAI5NZ
 C4Jg8ZIBXLJm6twcEh9+cgdV12JiOI7K5gdNQU4gPCxg0ssOOSRJsPaXJ8/L54pHonT9
 ATUBhsg1hLd7e9bgnCOitLmN3pBs855BlOBL2MkB6362LqwookqPtHJF2RtjGd1kKs8+
 Jj6BFs6MwQpU1pyBePeFA4qJeM9glI0WsJiJ8HXUmurDfaqixTMOvn9EBXxzgvtvrSWb
 zIQ6p6PNFuM96ziEpbNCSEFpJ+YbataCjSU1irwtH7XT+bQtM7l1EzqmF3qam71Pzb9q
 vjTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938782; x=1777543582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HZkYQx3viFK4Zwt+Z+/jMviqVF5Tb2F+0CaOgixxDFM=;
 b=Mqudm9yKQRIPzG7DuzmypWE7UVYGnZMgORvsDgDwR5R7Cu6MJlxgreFdNBmQgXjvyH
 mDOLAJATzx7gMn/cLtbk8satEjLP9U4ufGoJ97jR6sXpLBdJSND7yMWycbKQ+C/ZyFgS
 FsWf8hVVtKMjHn01aEUDlU20pqr7DHGJBZHtzIySbC4EejtdzH8OecqQtF/eVEjHWoMn
 CBkUIqFZWyYk3/IscSt1vL2zqWgem62UbeBxq9wOzpeQCAC3U7AOUGKbfqbZckYOvRlo
 Fa8KPe6wp3JrCCaxjPI4Sf3fkfU0QFbJ/ged0nzg2Rs3230M+ZA0TsiKD6+OLJ1RzQFa
 x6TQ==
X-Gm-Message-State: AOJu0YydsrAylh40yXaH6CeeTpjhLRWlWuyx2Yl4pfFbPgf7HhxR5+C9
 z+fOgAkX767wEpdE8z7Nk+6zl7OrYtjCBUz2ji7CEhG5vSTBvMAS2+7BdLKKJ0ducx881L+fn1E
 QPIKaMn8=
X-Gm-Gg: AeBDievWPShqYBjB58FXQ4BHwW9OHOvZihNAE1hOQQJamzOA2FWj7eGCAhp6R3Ca78V
 4z1ypeKouMx3dlh6J0pezWtWJ0K7LJ1vxGybzQN513scV7o2Rop3e34CnjMxJzMPrPms00oxXvV
 lfdZywPEqZUHTAKFPK2NDfgaEGkqPIrmpNwff6I41NmIYkRXDLnY3Zc8lMRtD2O9hYUnCD+uIe3
 EtQb3z/R5Q1+8OAqLYGzh9wbXvupefeWcaI9xRuSVM7ydI0hWVoNMkRNphiaNVxgeEyLNNRO1la
 4bd+2u4zudkPWzlOyKt0/DepHPVG6OwFKxjnQn1HUBU6fG2BEz5IEZ7PI5VJq8D+hluoya0DJ9R
 vr9WrEnT9YtA2O2jk2QQqZtL5eCZobhVwuSzY0fAt/86kiAkN+J41U6D3AobSQZSAypYU/SHI5K
 M+JgZ8bbKsfpj/PolhtrtH0QZpKW/ECKg+wj5HVYLQyjmer9NV0L5q1VEireJOoKxC/OV8Js53e
 mgOxidJVv761//zn1z0WQ==
X-Received: by 2002:a5d:46ce:0:b0:43f:dd40:bbc8 with SMTP id
 ffacd0b85a97d-43fe3dfbd25mr28647202f8f.24.1776938781667; 
 Thu, 23 Apr 2026 03:06:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cc375dsm47162106f8f.14.2026.04.23.03.06.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Apr 2026 03:06:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 1/9] tcg: Include missing 'tcg/tcg-op-common.h' header in
 'tcg-op-mem.h'
Date: Thu, 23 Apr 2026 12:06:04 +0200
Message-ID: <20260423100612.27278-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423100612.27278-1-philmd@linaro.org>
References: <20260423100612.27278-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

"tcg-op-mem.h" uses methods declared in "tcg/tcg-op-common.h".
Include the latter to avoid when including the former:

  include/tcg/tcg-op-mem.h:34:5: error: call to undeclared function 'tcg_gen_qemu_ld_i32_chk'
   34 |     tcg_gen_qemu_ld_i32_chk(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
      |     ^

  $ git grep -w tcg_gen_qemu_ld_i32_chk
  include/tcg/tcg-op-common.h:328:void tcg_gen_qemu_ld_i32_chk(TCGv_i32, TCGTemp *, TCGArg, MemOp, TCGType);
  include/tcg/tcg-op-mem.h:35:    tcg_gen_qemu_ld_i32_chk(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
  tcg/tcg-op-ldst.c:286:void tcg_gen_qemu_ld_i32_chk(TCGv_i32 val, TCGTemp *addr, TCGArg idx,

Cc: qemu-stable@nongnu.org
Fixes: 69cdc5babf9 ("include/tcg/tcg-op: extract memory operations to tcg-op-mem.h")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/tcg/tcg-op-mem.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/tcg/tcg-op-mem.h b/include/tcg/tcg-op-mem.h
index 36931d1dd57..ea35a02fb40 100644
--- a/include/tcg/tcg-op-mem.h
+++ b/include/tcg/tcg-op-mem.h
@@ -12,6 +12,8 @@
 #error TCG_ADDRESS_BITS must be defined
 #endif
 
+#include "tcg/tcg-op-common.h"
+
 #if TCG_ADDRESS_BITS == 32
 typedef TCGv_i32 TCGv_va;
 #define TCG_TYPE_VA TCG_TYPE_I32
-- 
2.53.0


