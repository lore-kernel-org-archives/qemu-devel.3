Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E39B8E8783D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:07:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnHzY-00057G-Sw; Tue, 03 Feb 2026 10:07:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnHzH-0004kM-HW
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:06:45 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnHzD-0002KA-Io
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:06:40 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4806b43beb6so42127935e9.3
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 07:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770131197; x=1770735997; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZHLK9xF6FFZPJdae8zYkCIhr2oN3p3ZEyAeM2tfMACY=;
 b=fEbxIw7QvqaVtRWmzLE1TVXU4wUDJbLzw3jzdHiA566oCnHWB2XKRAnGotjLZKs9dO
 f7Bb253B1LSzGnzc5phgib/EEUwJeIJbQ4M/2NMEIPmjYnLLdk7X648NYWiEymuM4wI3
 mcCd/KYd55+elGShRXHoOsTjnyBlfCXtpnP6V7UKu+OitObe0IJOP32BLLN1RgDEaRsB
 1d2ECyuPJLlkAeaDOR2TbkJIa4/31a5lOr2q/HxWnwvC01UXySmImWHMLKltb12lJKxR
 B25+Nu/CWfeHrmU5ZKIBrsEc7VohOActqASThnEQs67xFS+H0CfPBlKdfal+3vFCb12R
 Hmsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770131197; x=1770735997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZHLK9xF6FFZPJdae8zYkCIhr2oN3p3ZEyAeM2tfMACY=;
 b=RIlTqIzm8oyxswFEDamAWbG5vG+/z2QXW99Sc96rk8qvao1O69WI+irMtZFPxOPVSx
 gJgX/uKPhUsfWEfzLB/t1uBmt2h7l66SiFUTlSx1klJtkFeayxEzx/UCP4Yl7J0TMrHL
 8QvY27xt7QiaAbMcxaJ5Tia8YuDQJkQkcDnxwSmTeN3MGuXUYDheyfvwlNE5wdzQrwtN
 WN2g9RtdKNYTtY8aa6Rfa8pJI525+qR/NhqE78rdmxXXn1qkPmIicStR/36W0IbOCOVX
 toPJ4a6A8tek++8lgLHxtv0Xjj1AjJUs/95Pzb9tavWlSkvEzF4VKkdzX96c6HSytlVU
 nIJw==
X-Gm-Message-State: AOJu0YyIDddiPouguHmoIvnjPDY3+A5oni4OaPxu+1dpcPw8HOy5dUpR
 QgYdQBvM2KrUQXu1DJssb46pgr/Q0Wd8he+ESuu6ht2XxMe1RbJVlypBK+Z8E7IA9gUvk0YbK8P
 RFN4bMw4=
X-Gm-Gg: AZuq6aJh8W/LsZO+yXtcqT/ahxfCS5QTowMEBcMGqnJdImQOO6OY4fK9GAx+T4dct6Y
 HnSw4bS8zXMP7ZAICIcYDjFzMkMAz3RtmYtinSHZ4Jd3T1RZIDM00iv+RIqe2TZIY0QU//3Jt53
 dKgHqFl0Hvq+ZFGWTn1e/X4LZEEFO1N1LHAOyWo9sU+kgiNgQ9r8dLgL7vxJUiuKfDygIiqbpUu
 lUbASfxCbTOK9RlYLp3EFqm3321QyUIhV9NbiFCoopuBp9BV7aJ1nVQzEQnIPpunTvntD+zD3an
 jXHrSqgg2KlsuX0XePA8LIldIoYegduQJG0nwCeMKVdMCQt8nhymrkRTCEJIuYIv2rJGlfhgD9Z
 Ov/wlFzWl6ufu+JumRZB43huRPaE4OvOGnCtyWA4MllrkwJbPzMF1zeyyWNukai4kZxJmWfKHRw
 coNjXx14pSjjZdaLE28LgX/D7xsA+KnxycxFD1dY0COKCwvGLRaDjIi/lDmmyrg/VQIMWZeX8=
X-Received: by 2002:a05:600c:6814:b0:477:9b4a:a82 with SMTP id
 5b1f17b1804b1-482db4af871mr207610945e9.35.1770131196956; 
 Tue, 03 Feb 2026 07:06:36 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436143d81desm4627556f8f.42.2026.02.03.07.06.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Feb 2026 07:06:36 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/30] target/alpha: Avoid target-specific migration headers in
 machine.c
Date: Tue,  3 Feb 2026 16:04:22 +0100
Message-ID: <20260203150436.71907-18-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203150436.71907-1-philmd@linaro.org>
References: <20260203150436.71907-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

machine.c doesn't use any target-specific macro defined by
the "migration/cpu.h" header. Use the minimum header required:
"migration/qemu-file-types.h" and "migration/vmstate.h", which
are not target-specific.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260202234550.34156-2-philmd@linaro.org>
---
 target/alpha/machine.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/alpha/machine.c b/target/alpha/machine.c
index 6828b123ca1..dcba5d441be 100644
--- a/target/alpha/machine.c
+++ b/target/alpha/machine.c
@@ -1,6 +1,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "migration/cpu.h"
+#include "migration/qemu-file-types.h"
+#include "migration/vmstate.h"
 
 static int get_fpcr(QEMUFile *f, void *opaque, size_t size,
                     const VMStateField *field)
-- 
2.52.0


