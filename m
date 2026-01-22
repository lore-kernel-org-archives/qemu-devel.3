Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E409C44500
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 08:53:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viqRb-0004hd-82; Thu, 22 Jan 2026 03:53:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viqRQ-0004dk-OI
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 03:53:26 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viqRM-0005pl-Bf
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 03:53:23 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4801d24d91bso7404915e9.2
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 00:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769071997; x=1769676797; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=S6Q4N8pgL/r8PL8EYgfB+22RaEEU0dVwVDGEGQYw+j0=;
 b=CRKV4Pmjfge0Ztme49GBNeDnTqL8OV0YAuZodzex004diSoDk+P61obzKwql5xNvTU
 sFQcbAg9vLEfQ8xvan/MPxFH+p9Gp4NJ6KrCq+HCvw86U/7x7J8WWvVAd5ld1SnXJLuR
 MVOl5l6xhQhKnQc5xiTjoPlBQ+Vn1vgCNJx+GuuPd6AWMj/RDqL9hQ+Klqsz/6egkohv
 UvdcM7fYWdrf2jSSybxmwhbglftGy+Q4NjsFYvhhZ2UiljBeUp5Zvt+u5pnLYAI6WicV
 9KaPpz+GZrB+F7JefvmYu1tVndi/3C4p08gHqV+4sZhOQuVBNcFjZ8wGtLrIuaXeLoMj
 vxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769071997; x=1769676797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=S6Q4N8pgL/r8PL8EYgfB+22RaEEU0dVwVDGEGQYw+j0=;
 b=dn8pwtLYtiPlhk3M3kxUvEWOp3+TyvG53sZJ0HGVs1v8idmYUFIDC1vCGGKdI4mkPd
 riB4Pk8uxmGO8LF0fT1LuaPyun7WuqTfpASTYtwhIUyn79CTRXgUx67YV7RngEyAomGS
 wkEu5u4jsvI8RsGbA4Uav9PntjwVU8nh/IAhpQMoZyYj1y36J//xIK5l/tZXDfcH47f8
 CK53uD+0ivBTGHmH1XmxNlbmmtNRXzkCLI/6I+fBaFAOjJWlPmtG+ZuJmM4x4882EMOT
 xKhketl4sfAsrgdZm/o2KoIaEs1zFWQ+liG9NE9celvBCpPgJ/pe/PGzSP9TBhpP3jZj
 k6qw==
X-Gm-Message-State: AOJu0YxtWfUml+Vx1Vq3hiU/ajf7yEZ29hZAUc+6Kw0ZUa7CBjCbVIIU
 odWRTUYZunSXnMvBNC/gLPbmXOsTJb9vEmUZM8x/r5ZnctoKmtJ7lRecif+AHHJGJ8FgBe50l4s
 4x0ru5Y0=
X-Gm-Gg: AZuq6aJtl9wmqR9/oL/OFfOogI6nlCk03xlApTgD9myuALW2r7nwkVA+NbmCGnXFEPf
 6g/IfbaUbAo0Ms7/UNgWJX0kO/3392eB8qUq9ptOqIb4ZQs0c7rctjbDc6trrOWn/Mq9NCo8X9D
 mZEU6jnUCd3OgHS2WH2sEdNbhfs0wYog9eo2YvQWJO40fEZFnFgq4kVeLq009CbmghBcvq3AcSs
 KN7cmtHyjqQ27pSYXPL0o9/pTSikQiKTO9eiNrzR1cImv5vUAxuyJ2zeWJCbsyXBJM3s000m6LD
 gjEWif43yZ9TPzpsxabsDZbm1merhY9H3qIFxq1u/hDsQsI4SYx/7ACL1m84vOSm6yILQpCIt8l
 8sZ/kT5q3+p/DNb4yNIsyi5HDw1r+vbvCrh6N/Hul1oMlSUza+VD5edkA2To/zpqqrOM96ZP+ck
 1yOdhp2Dmt4Vx51HUG6IGpjgByzfAey+2WqLHwRt8nL8LROeSCOwaCshbP7oB+
X-Received: by 2002:a05:600c:608b:b0:479:1b0f:dfff with SMTP id
 5b1f17b1804b1-4803e7a2cc0mr135787615e9.10.1769071996945; 
 Thu, 22 Jan 2026 00:53:16 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-480424b64a8sm50291845e9.3.2026.01.22.00.53.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jan 2026 00:53:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/31] bswap: Remove unnecessary 'qemu/bswap.h'
Date: Thu, 22 Jan 2026 09:52:26 +0100
Message-ID: <20260122085255.95035-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122085255.95035-1-philmd@linaro.org>
References: <20260122085255.95035-1-philmd@linaro.org>
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

"qemu/host-utils.h" and "qemu/int128.h" are included a lot in
the tree, and don't use any definition from "qemu/bswap.h"...
Since it contains a lot of inlined functions, remove it to
reduce pointless compilation cycles.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260118193509.42923-4-philmd@linaro.org>
---
 include/qemu/host-utils.h | 1 -
 include/qemu/int128.h     | 2 --
 2 files changed, 3 deletions(-)

diff --git a/include/qemu/host-utils.h b/include/qemu/host-utils.h
index 0777a2bb60e..181d026b6c7 100644
--- a/include/qemu/host-utils.h
+++ b/include/qemu/host-utils.h
@@ -30,7 +30,6 @@
 #ifndef HOST_UTILS_H
 #define HOST_UTILS_H
 
-#include "qemu/bswap.h"
 #include "qemu/int128.h"
 
 #ifdef CONFIG_INT128
diff --git a/include/qemu/int128.h b/include/qemu/int128.h
index 2b8dd4dec9f..7b3b071c512 100644
--- a/include/qemu/int128.h
+++ b/include/qemu/int128.h
@@ -1,8 +1,6 @@
 #ifndef INT128_H
 #define INT128_H
 
-#include "qemu/bswap.h"
-
 /*
  * With TCI, we need to use libffi for interfacing with TCG helpers.
  * But libffi does not support __int128_t, and therefore cannot pass
-- 
2.52.0


