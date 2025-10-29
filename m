Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A93CCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 21:44:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEDwA-0005lb-Bp; Wed, 29 Oct 2025 17:42:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEDw6-0005k5-Dm
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 17:42:30 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEDvt-0005oh-Mv
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 17:42:29 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-426fc536b5dso202275f8f.3
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 14:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761774126; x=1762378926; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2EB/+K+U50LOMq4VatDY59V/9bRPr5YkwDU8U96E3AE=;
 b=GGg64D5+sN98dXSmJVCWZwKILv7Im/MUjjsK9lulwSqP1yafWQYOFwfqpGDsp3V95h
 +v2Mon38suxs5U5QeWlqjtZX9WkHe3B51yetUtldp5+VHvwC36cChCNksth3vWEb6HhV
 LuJD9YZUHEV/pTzr8AZSu2B+/UvGAOG6ensPIJ6kI6tDRMFFd4Y0YkfABJcBCwMWBhpH
 NxePnjZ+y7qW+stNlZJo1lKOP3BBhhgvLInjLHADfB67g0Dd7E58aKwqWjwaycOIT17d
 Zc7SuVTmejFL2y+1pCzmJg8+Hsiad4lEl615QdgEW2SSgMx23TnaEuCgju57ROKrdtk9
 6NrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761774126; x=1762378926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2EB/+K+U50LOMq4VatDY59V/9bRPr5YkwDU8U96E3AE=;
 b=XKpOlvi+QDMRqPv3hcNm6NHnTV6xNO304rNUuBmcdgeQnWnI03j9Y1KgBsD3sHOEJx
 MMVhpwfi4bFvNqcClh28dFYqcBygJp5YJ1kCcOLr2krdn8ctw83YE7PCGpNSWY+mo9QC
 I0R0z85DWmeVpeIdQKvtJrHHS/NQnIEH3+DB+HD9lPzCBxH8G0+B688Jcpk53PbdMZNU
 vx5ubgdPDTMal7x3XIH7h41qWIfkrbQVdme90g3oAp6fupzg5ESXkrDFueONEzrfvU88
 +1U5VE2JShbW2EIqVJ+fE4Bf/HjOw3rXq7s+SGTj5JaZBCMxc/D9PuCcF+g6HhqblgY3
 N6Ng==
X-Gm-Message-State: AOJu0YxRvg92sOzXmBu2q49BJlw4aR4MI5Cj+B6gpHqKJsT+n96hMvx6
 zYmI31RJ1hInNZLQoSVU6nvpTmcwg11EAwCGWwkNRRPaYqB9nmqj0UhaAIfgkU5+8pFqhyao6sS
 n82D5VEE=
X-Gm-Gg: ASbGncvfiplve+g9zEaXvFN97O4x591V/S6bbqp80tFOLmzhCw0JX7F7PjmNUl4OUhT
 YunKIBb4TBL2e/Sl261BVb/7nVF0qmIt4t2irQcdjf7ftOLUYQkR++KfD8GS+iXOzj0SmS3wqgs
 jTdTYrPkoBk7zuj3n/mbbDrxAbxMn3cuzYlnfJML/RKRdufRut9bGwWTEmN0SkkL2EWjNRg3oe7
 j22K91DVDvGlhCItekFTen2Teh/C0f4YR0M1UuwIj0sxUzrj8OW54GcV6Y+At7T00q/O9zHQyfX
 zgdO5RE7z2IX+//EQbBZtpsn2+No2vdIRB7s93C3Fw5P21AhMKEa+Anomh9B4tdbcL4mjE8FiA7
 OFcZU2owJ6Fs0LkL1utUYiQEzUmF3b95KMmbuxb3HcmFkmIf5vuZ5hd7q31xk9RLEzBbUzXeunJ
 uTQqv2qkwnI8m5a4nOacbVJUA9oIqrLcig22LwJVk9hgs1GRe2dg==
X-Google-Smtp-Source: AGHT+IFgdRC+dWjPAYj7IlPWt837fcvkUI8b6+SA4PZQBAwhyXnhAYEqH7ph7TKI5k6QGpOx2FC2tQ==
X-Received: by 2002:a05:6000:4211:b0:429:8c31:84b7 with SMTP id
 ffacd0b85a97d-429aefd6aa2mr3655666f8f.39.1761774126313; 
 Wed, 29 Oct 2025 14:42:06 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4772899fdfbsm4216885e9.4.2025.10.29.14.42.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Oct 2025 14:42:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PULL 02/23] hw/core: Allow ARM/Aarch64 binaries to use the 'none'
 machine
Date: Wed, 29 Oct 2025 22:39:39 +0100
Message-ID: <20251029214001.99824-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029214001.99824-1-philmd@linaro.org>
References: <20251029214001.99824-1-philmd@linaro.org>
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

When we'll start to use target_machine_typename() to filter
machines for the ARM/Aarch64 binaries, the 'none' machine
would be filtered. Register the proper interfaces to keep
it available.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20251021205741.57109-3-philmd@linaro.org>
---
 hw/core/null-machine.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
index a6e477a2d88..67b769bd3e0 100644
--- a/hw/core/null-machine.c
+++ b/hw/core/null-machine.c
@@ -16,6 +16,7 @@
 #include "hw/boards.h"
 #include "system/address-spaces.h"
 #include "hw/core/cpu.h"
+#include "hw/arm/machines-qom.h"
 
 static void machine_none_init(MachineState *mch)
 {
@@ -55,4 +56,7 @@ static void machine_none_machine_init(MachineClass *mc)
     mc->no_cdrom = 1;
 }
 
-DEFINE_MACHINE("none", machine_none_machine_init)
+DEFINE_MACHINE_WITH_INTERFACES("none", machine_none_machine_init,
+                               { TYPE_TARGET_AARCH64_MACHINE },
+                               { TYPE_TARGET_ARM_MACHINE },
+                               { })
-- 
2.51.0


