Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D321CD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:09:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcuv-0001AR-QP; Wed, 06 May 2026 10:08:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcuP-0008QH-Iw
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:07:30 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcuN-0001wR-Te
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:07:29 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso62762645e9.2
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076445; x=1778681245; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IMeAevOoDKyUqweCwVF9/LSzCdA8DeT8NRzvRdckXuo=;
 b=rpoAK0zeJqL/rEZdKVaTEUq7HZOY4UG9ZHwjmmpQT6S4hnWeDtbj6mNI+F1vHw0abw
 PwQoqlm2ah+RZ+9/PkBUEPyQauPxK1iE0SC4pbe4KMnndGsVEniKRRI6R6sqE8lHJGy0
 hGqveY7ZF0ZbUyfPZF1xrJF+U43xaoC1ApDXJJJdAtDEXEUS63qRItNGhPywKMX/DTWp
 eDMUkEv8xrD70I52D7w7yZtj0dzDemRwEQ2MPN/Y9qkRz9LRxsxyPl9lBjpnpvjCdu9s
 ym775lWqqZEITlH6gyNfKU8WDdG+rMke0MDem5kG6NyDBgcwFw5UnQYz0PPcdNhdcNIW
 /+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076445; x=1778681245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IMeAevOoDKyUqweCwVF9/LSzCdA8DeT8NRzvRdckXuo=;
 b=FrYrb+70e9jYbwZ1rFRh9DfTGVHdriocqd1YULuX7M+r6PFSKGCyhHW1Glw4uVhKk9
 mb8c8ezd1h8XtIa+aaKUY8e12miFIJQJVkh0t0SX0ovBNXUvBl3k5tBoVXe31syZp4En
 JxywRHHpxK4P5LqyammYan3Ez3E9SkZzDD1CrRQOoBI+rVaFRBzXQQ6wdCUSidAph65F
 W8uxzN7kOl8SINztnbhsH80GxhWZnVJbFJiVWxMCiJjb0QQivnteQfSLiUB1Xk6vUcJq
 R1FEozSgd62skGC3dGGoH0fH+t6hKpRuabqyhHbM6EYYl6i8H7JGiB4KQ2vun7I0AQgl
 1XBQ==
X-Gm-Message-State: AOJu0YyMeiIylq6AoWq1OoXBKCX0KXftZUWuFdsuHCk5dg+i8NEFBHhR
 bJul909sbykR4sWqsGJH6WfWJj78z/KsOdZAaGZf1Lg+s3dQj62uBS8/d6URCdPxqQjScBYlF1F
 u1tEVHI0=
X-Gm-Gg: AeBDievSzuI3epELLg3Go7LFDoimsDirpr8mmlVlJLJdjsbIbmZaa+II/lwypoPjz/Y
 FBMRxEV1wbc1LF3nG3coHTZyamwONsiB6q2OYmxTXM9SslU65mF8+uZjCw5QjutASyQNblazB6y
 996TMos0sEEj7Rgo4zxRRw5qZLN3/O7VwSUUOqa5TUNN7WZRelbQth2GlBuMjKmHlUpSvGZun6b
 9OC4W3J0Bfb3kG/Q74VOMkzKJv8fJv6Y6hrA4Od/ZA43H02tmmAJKd5flZVGfzhkY4pf7PMVzbQ
 p+A9WMgDBSbzTKz6zRbLIFFOyc6tA64crjfE1WA4LkNtrzLFGbGSxhqqOllSISi+z7/W+t61Ffj
 4EP6mIphZd8xsmVFslXCPOtJYz+3z+RUtQQbJXyO1mWltfJTtpGouovYtuyvogcx0F9IvP9ONQr
 1x0s3bbCUNDz/ywMDK5yGdvqUHUIOSYf3XvENpJPOUenC5FrC0dUANkLvAgF7xcG1+Bcc+FRFb8
 4cobw2G5HQ=
X-Received: by 2002:a05:600c:1d11:b0:48a:7f90:2231 with SMTP id
 5b1f17b1804b1-48e51f364f3mr65959075e9.19.1778076445385; 
 Wed, 06 May 2026 07:07:25 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e538a547bsm55005725e9.5.2026.05.06.07.07.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:07:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 091/110] target/s390x: Compile translate.c as common unit
Date: Wed,  6 May 2026 15:55:03 +0200
Message-ID: <20260506135524.20617-92-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
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

  #include "tcg/tcg-op.h" -> #include "tcg/tcg-op-common.h"
                          -> #include "tcg/tcg-op-mem.h"

and:

  "accel/tcg/tcg-op-gvec.h" -> "accel/tcg/tcg-op-gvec-common.h"

taking care to define TCG_ADDRESS_BITS, which is fixed
for this 64-bit target.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20260423135035.50126-6-philmd@linaro.org>
---
 target/s390x/tcg/translate.c | 6 ++++--
 target/s390x/tcg/meson.build | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 0f274621e5a..82165ac1ec0 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -31,8 +31,10 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "s390x-internal.h"
-#include "tcg/tcg-op.h"
-#include "tcg/tcg-op-gvec.h"
+#define TCG_ADDRESS_BITS 64
+#include "tcg/tcg-op-common.h"
+#include "tcg/tcg-op-mem.h"
+#include "tcg/tcg-op-gvec-common.h"
 #include "qemu/log.h"
 #include "qemu/host-utils.h"
 #include "exec/helper-proto.h"
diff --git a/target/s390x/tcg/meson.build b/target/s390x/tcg/meson.build
index 67f31bfddd4..d1c60135411 100644
--- a/target/s390x/tcg/meson.build
+++ b/target/s390x/tcg/meson.build
@@ -3,13 +3,13 @@ s390x_ss.add(when: 'CONFIG_TCG', if_true: files(
   'int_helper.c',
   'mem_helper.c',
   'misc_helper.c',
-  'translate.c',
   'vec_helper.c',
 ))
 s390x_common_ss.add(when: 'CONFIG_TCG', if_true: files(
   'cc_helper.c',
   'excp_helper.c',
   'fpu_helper.c',
+  'translate.c',
   'vec_fpu_helper.c',
   'vec_int_helper.c',
   'vec_string_helper.c',
-- 
2.53.0


