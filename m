Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51598C36014
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 14:44:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzcq6-00063b-E8; Tue, 01 Apr 2025 10:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzcq2-00062l-Jn
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 10:43:38 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzcq0-0007JR-TM
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 10:43:38 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cfdc2c8c9so32157225e9.2
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 07:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743518614; x=1744123414; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=S8mflKXKpWk8z4I1ix0nqw4ZYOxugViLuZPJy2kngHM=;
 b=fp+DxSAb+Y+wDj8JuryQzaLxl5REy2cnUolY93sV5ecfqLNihHe5ym9gauJt4DqRHn
 LmED9hEEg3fHJCaGdUCaqNgB2ZNiq42Svdxj4Vi/o5mBvxrq6Pa4GkxsKxtPZ4I0IlnL
 t/dPD90QPQejBrR/7kmDD7WDYTZ4Qr27bUFMXLzM09vumKabJb8VLuN9A3tUtUxgUblC
 rDfwjxEDX435NncFn7wcXFHaIrYzEVLw+It9cO3On3SOaHLy0SLBqUzcfzp7QtJUOLZO
 5+mrTkg4tiywA1vnKAiLgYqmPKpPpXL96Ljo7RT1S29aGGSd0WlTJNlCqPtVosTbSwLf
 A7mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743518614; x=1744123414;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S8mflKXKpWk8z4I1ix0nqw4ZYOxugViLuZPJy2kngHM=;
 b=h10VXB4np9j1MaCx+lnxc/es0x2OVJ4Xrxo3y13JO4dcPLOVUnxul5lFFoLd9RR5Zs
 Sx7ltUXQ98W0S2ob1wrpHGHQ8dt0QLyZeFj9s2GH59GogPnSOuGYx0KZimovOFhkgq5U
 6ap4RiEb1rqPT72QXmLNcc0urREujRXPNAyD8gxX7eLtztX+Xu6Aia5IKCQLxoFUo1Yz
 lpvfXZwJo2OB/5vFbMJLuSTUxI+N7ObPEakhst/71SMPkN9D/CBF6eoWXaGzuKZQ1j2l
 /zCpcTV7pS3q6HfO3xbzGXksvgJdpEZ+NwkUljWsILboXjBsN3xCQFvJWP9owMRFUf9Z
 FUrA==
X-Gm-Message-State: AOJu0YwrtOASDd4hjDHjyzTj/vObPvmKIOjB+4MoHkEisWNl02OaUaYO
 BE6zRjDfIc0YKJAdY5zEmFW1v9mHWRqX/HOitr/rMOwVlZ//JLXwkdc3CU3XxVMgZVVA9ROrY8d
 e
X-Gm-Gg: ASbGncsESRQyXJ832bllnuqHQnTp3TOvDmxj/1YjDsXQf+Z86RUV/xpKja/LsAU8Wyn
 mnH1dbRMUD2CwWsXcZXKa2/cqobjTz+Ct9zZcC+Jzy3Y1kfY58ay5/O1gh30v3IfuyYUgNJebLr
 F7AdoXEMP1+aYUoIjFRU9UuNBsrGJaw91XF4kbYoHmzcmI5J5XHeiw407z8zVWNSk3dn6G06ogO
 jqV0ALkOlwhOjlVmJhbqUZSB5DB3yEXuA6Z1iLdctCFA2IXrSqfdbqQUCWVhcFT+72EvA4anFnp
 wzyfmFI8sg7ds+GCEiGvZSDOjotlffbU/6wrfMd2cptnmoUymCGdljj63yJj1jQY/sOpYBdJ+nG
 gpXd/1MK/o6b84gJvFVU=
X-Google-Smtp-Source: AGHT+IFTb4/cPwJxF9myit659O0dSPOvY4ecQuy9BoOLJwcIXnEScRFZFdBAmBIhuuY0gD52iZHLpw==
X-Received: by 2002:a05:600c:154a:b0:43c:e467:d6ce with SMTP id
 5b1f17b1804b1-43db61d75b1mr121470845e9.4.1743518614336; 
 Tue, 01 Apr 2025 07:43:34 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b7a4294sm14004763f8f.89.2025.04.01.07.43.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Apr 2025 07:43:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Emilio G . Cota" <cota@braap.org>, Stefan Weil <sw@weilnetz.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Helge Konetzka <hk@zapateado.de>
Subject: [PATCH-for-10.0] tcg: Allocate TEMP_VAL_MEM frame in temp_load()
Date: Tue,  1 Apr 2025 16:43:32 +0200
Message-ID: <20250401144332.41615-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
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

Be sure to allocate the temp frame if it wasn't.

Fixes: c896fe29d6c ("TCG code generator")
Reported-by: Michael Tokarev <mjt@tls.msk.ru>
Reported-by: Helge Konetzka <hk@zapateado.de>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2891
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2899
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tcg/tcg.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index e8950df2ad3..dfd48b82642 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -4671,6 +4671,9 @@ static void temp_load(TCGContext *s, TCGTemp *ts, TCGRegSet desired_regs,
         ts->mem_coherent = 0;
         break;
     case TEMP_VAL_MEM:
+        if (!ts->mem_allocated) {
+            temp_allocate_frame(s, ts);
+        }
         reg = tcg_reg_alloc(s, desired_regs, allocated_regs,
                             preferred_regs, ts->indirect_base);
         tcg_out_ld(s, ts->type, reg, ts->mem_base->reg, ts->mem_offset);
-- 
2.47.1


