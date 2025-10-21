Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC45ECCD1AA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:50:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJJ0-0003Gd-6I; Tue, 21 Oct 2025 16:50:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJIa-0002e2-QL
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:49:44 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJIY-0001GX-LU
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:49:40 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-471193a9d9eso54889905e9.2
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 13:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761079776; x=1761684576; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=N7L/lYFt/nDTTsPo3GqiSv7jR/BNA6IJZczYTvOwlC8=;
 b=z5wZJoX/tQjsI7QbtODSU5qOqRq5LDHizMct6Xqp/tSu2/uFLQQAmfOJAGwZ0XR2Pu
 tnsYaV6wOp+6QNTeFmmJZ6OqTK7jY3ZafmtzlZskOZatXjEac5u7tvX/bFP/czDrnPd9
 3ya30Mc8qxm8mEe6QHo2vcJHnt2pHhNc4mW+uha+achxRVyfyhoAwyrvNORbt3VMnyML
 VytFOZnNgW/ANTE55EX9G6rinBT9JEgpHwDeKpankqKcZuGID9rqzFk9qNb9LPmQzwkE
 cikuzyMxaFBTke+xukPebkw61IFKNs/k8wDXPJsIhhFxxm5zZKoSTXPqQjCsV0EMUJr6
 d5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761079776; x=1761684576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N7L/lYFt/nDTTsPo3GqiSv7jR/BNA6IJZczYTvOwlC8=;
 b=vGeSuE+xxv93nILS0i5sPp/1KkNB9LPrTUq0dTDUHuq/QcRR+BSagprHyly4ZvVV46
 2D7z+8KwrF5JGSYtKOLlzPUoxOKYFoJTPSA+7sJWgHiW2DB0dupKdFk0IWE0ivsyDhA3
 Dxw8s8bka0bI4lpdntq4guO4Vcr7ZVo2u7/1X0EOxmSDcWzbBBpc9LYK4etLeVGXZ82N
 vIAPF5Zr/+MS4h3BqU87j3dmIllCjl0jPE6pHUo0iKzwZ2Xc7TFuAkKjjCDEQhqfZzqX
 4iGHvREfO1ArUDZ+IUfy0K3RB3MWtf0EbkRYKqklGeCATAzJcSE5Mezi217DtSvJyTOv
 Y36g==
X-Gm-Message-State: AOJu0YzaWsT1L9C8IzWfI62Uptmbyh7JfUHNejW8VRJTlgUN5nYxv7U8
 EkKycHFlABtXEjs03y8Ffp/fliQmDUth+yaVvy5FoCAOkHRW17pcg+xXD7vdgNPyofK5i/vYT3o
 rNwiAR6U=
X-Gm-Gg: ASbGncu15GJ5UOLElkMPFsffOqS57aE8M6FYea0ar6CCW52pEAeaTGkC52nTeSQGtmc
 e01r6PqajRxJAgSXGUzWhKRb9cDbNfEiQytpr91LXO4EOAQC9lLbyW9MPc/ayB0BcUsqqilXcFs
 cOzcJO6wN3lgm/c18ESOixdRyxIJL0vQkQCIKf0u3YBKX52R7Y8MCtghMCsgLDPJrB2/uvAgABj
 TLJbMqrwrUDrIK3I3zj221MOFA8PYhxhmvBergqiQGZhJa3dhBtKifzpNTN2XMv/W6we780ZT/K
 tRr2DEimRIpn/LnQx6Ynk2GrIaL097GK/TaavwzB/6UnArJ0xF55NA7HoHdlyCFMA2hRIPKWVx9
 VTKPCwZfrjrR0seGX9rqG99ZIaR3bY2sXbb4mQbHpxEky4uCpB8q420vXYnUylk0l8LysCusrpq
 A4n4HvU30tiyioKKCRq2NNiIzK1SBrc+eUM0b0BYm9cmSo+UvzYuEjD1sNws0s
X-Google-Smtp-Source: AGHT+IEYWu3ktheA4cIGy96ZsX6mSY8SBAFdwT+rcFRy9VhyaEO+tg//KaVCEuz9TMq0nkcaAXf7Hg==
X-Received: by 2002:a05:600c:4507:b0:46f:c55a:5a8d with SMTP id
 5b1f17b1804b1-4711787276dmr138730615e9.4.1761079775911; 
 Tue, 21 Oct 2025 13:49:35 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c4342946sm9447795e9.10.2025.10.21.13.49.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 13:49:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/45] tests/qtest/ds1338-test: Reuse from_bcd()
Date: Tue, 21 Oct 2025 22:46:47 +0200
Message-ID: <20251021204700.56072-34-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021204700.56072-1-philmd@linaro.org>
References: <20251021204700.56072-1-philmd@linaro.org>
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

From: Bernhard Beschow <shentey@gmail.com>

from_bcd() is a public API function which can be unit-tested. Reuse it to avoid
code duplication.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251019210303.104718-11-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/qtest/ds1338-test.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/tests/qtest/ds1338-test.c b/tests/qtest/ds1338-test.c
index d12424d27f6..b8d0e65ec44 100644
--- a/tests/qtest/ds1338-test.c
+++ b/tests/qtest/ds1338-test.c
@@ -18,16 +18,12 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/bcd.h"
 #include "libqtest.h"
 #include "libqos/i2c.h"
 
 #define DS1338_ADDR 0x68
 
-static inline uint8_t bcd2bin(uint8_t x)
-{
-    return ((x) & 0x0f) + ((x) >> 4) * 10;
-}
-
 static void send_and_receive(void *obj, void *data, QGuestAllocator *alloc)
 {
     QI2CDevice *i2cdev = (QI2CDevice *)obj;
@@ -39,9 +35,9 @@ static void send_and_receive(void *obj, void *data, QGuestAllocator *alloc)
     i2c_read_block(i2cdev, 0, resp, sizeof(resp));
 
     /* check retrieved time against local time */
-    g_assert_cmpuint(bcd2bin(resp[4]), == , tm_ptr->tm_mday);
-    g_assert_cmpuint(bcd2bin(resp[5]), == , 1 + tm_ptr->tm_mon);
-    g_assert_cmpuint(2000 + bcd2bin(resp[6]), == , 1900 + tm_ptr->tm_year);
+    g_assert_cmpuint(from_bcd(resp[4]), == , tm_ptr->tm_mday);
+    g_assert_cmpuint(from_bcd(resp[5]), == , 1 + tm_ptr->tm_mon);
+    g_assert_cmpuint(2000 + from_bcd(resp[6]), == , 1900 + tm_ptr->tm_year);
 }
 
 static void ds1338_register_nodes(void)
-- 
2.51.0


