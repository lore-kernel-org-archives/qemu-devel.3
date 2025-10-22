Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70065CCD1BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 14:02:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBZPd-0007O8-3N; Wed, 22 Oct 2025 10:02:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBZPK-0007LK-58
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 10:01:48 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBZPD-0001dz-Ko
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 10:01:38 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4711b95226dso58329285e9.0
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 07:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761141694; x=1761746494; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4HjNE4Xkg6Ebkq5X/NZT8seGp5EoTUwdTjpH6KQ8QUA=;
 b=JcLcM1Tgs3kZGEhB6WTnuLbQB4DRoXejf9dDH1Q7Ihrb7ggxYcu+UTpKPHBfnNdlBQ
 Ee/M9OA9Vmwd/zkS7CUHkkoZ47fbTgGLn/+FHiNWuFXuJvkryoaJg58DSN3l00kqH5SR
 7SpAckAPyCbr0RuvWKM/PWloatScKS2m6vzk7ObofGj4oCkTwrCPzd5h8vBhyXmObfYr
 zQblPoWFAMLeOv3JCcI0OfJusfk5Cc9BL0uPPB3r2XcjaC9Cw+7I+kXlw1Cy9KKwEawy
 Rxd7BjCeIPn4xgZ5wxO9pb8zekzBRMJHLSU6XE9EqddQw6KnFMeTVDtbMHSHZgzDd7km
 GS/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761141694; x=1761746494;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4HjNE4Xkg6Ebkq5X/NZT8seGp5EoTUwdTjpH6KQ8QUA=;
 b=PzN65sigDkNuxJD3gJgNYpg5/T+fVVM2n4eQfmqtj9flOd4zcsm+rPyj9b8kmBIHZx
 tvgIT2lvqufL7fLyT1x/OGQpTb/72wqHKlj78ZpHUKtmMHClS8tCYyJhbgyDvJNhASJU
 IJvXfuJlUfgEYaCr5NlzjxYdtsx6yXq4s3zeh6S6FXKOtQp370snV07A7Wv6K6o2N/8+
 Awit3qiF0+uLr01ZnItxCkXTVTJzeSTWMJO9T8b9bnWAwyGTd1lNSpouYMg5iGyMSNuv
 OTwVMsFWhnqUtcirRAgVfwnRwjKJPSuO6jl4ccZe3A3irhouOmp3gnkMogJOOAP+zXsm
 a0RA==
X-Gm-Message-State: AOJu0Yz4u2GhZzii+xPLLjBjp6Y7XvCsUD4bY7J5am9VMZmPO0PXo8iI
 MquA9S5T2AVbjdkfxI2rlQjZQueSx4nwBcuVlsP9D2Qxh1b0RhZf978DjMhcZtO+zubRL+zMEu2
 rvuSnPX8=
X-Gm-Gg: ASbGncuCX1ccgyMepulOYJKqLK/oPMp2EZJ6Wda8ApioxEI132kqu6M6l5cGtXceiQY
 nVJyX2KytK5vmkFKYNRTrvrJnNj+pLL0Em93Gu+kKzquXvx0v09aZruBwJ58+NXr1jF8KC3Tqw5
 1a8hM5Olz8xS8cJa3uXNmrZyDGb1TOwZ+JghHXmmg9kmEju58Pwr5l1Zv79vqPwCnl/yUAFzec+
 JzKvtLA1Sq3ewcATulZHTwJjYJHFG2fh4dGM2ygHdIB1GE+dD6EC8ZeXeNbMbfcb/rnnuOKFi3l
 YsaupwHEvES0/RKAo6ZftOfh5jXl0loPPJ6AnLDHoHY8KyzkoQJSKKWMFt/Bugon+quLxspSaAe
 c2Sf3FNdMQFVd+WYm692/nIQPoYfTRyrUVcF26ivXvtmtR6adJ5mgcpPWL30jnLgel+zEEnHOtG
 AGbM1h7heKyG8fsI3WilW/15lILUzV/A==
X-Google-Smtp-Source: AGHT+IFQ7L4fBGIJoJXHNjn08SD4wzUmt9U1mWP674dDSbDfSAlvpQwuJQwgI77QmiqDAnGzdB8FEQ==
X-Received: by 2002:a05:600c:4511:b0:46e:1a5e:211 with SMTP id
 5b1f17b1804b1-47117907a5dmr135379745e9.21.1761141692085; 
 Wed, 22 Oct 2025 07:01:32 -0700 (PDT)
Received: from localhost.localdomain ([88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47496cf3b51sm37114995e9.9.2025.10.22.07.01.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Oct 2025 07:01:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anthony PERARD <anthony@xenproject.org>, xen-devel@lists.xenproject.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paul Durrant <paul@xen.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Anton Johansson <anjo@rev.ng>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/3] hw/xen: Use BITS_PER_BYTE & MAKE_64BIT_MASK() in
 req_size_bits()
Date: Wed, 22 Oct 2025 16:01:11 +0200
Message-ID: <20251022140114.72372-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022140114.72372-1-philmd@linaro.org>
References: <20251022140114.72372-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Replace magic 8 by BITS_PER_BYTE, use MAKE_64BIT_MASK()
instead of open coding it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/xen/xen-hvm-common.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
index 52e2cce397a..258014370e1 100644
--- a/hw/xen/xen-hvm-common.c
+++ b/hw/xen/xen-hvm-common.c
@@ -1,5 +1,6 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "qemu/bitops.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "exec/target_long.h"
@@ -448,12 +449,14 @@ static void cpu_ioreq_config(XenIOState *state, ioreq_t *req)
 
 static void handle_ioreq(XenIOState *state, ioreq_t *req)
 {
+    size_t req_size_bits = req->size * BITS_PER_BYTE;
+
     trace_handle_ioreq(req, req->type, req->dir, req->df, req->data_is_ptr,
                        req->addr, req->data, req->count, req->size);
 
     if (!req->data_is_ptr && (req->dir == IOREQ_WRITE) &&
             (req->size < sizeof (target_ulong))) {
-        req->data &= ((target_ulong) 1 << (8 * req->size)) - 1;
+        req->data &= MAKE_64BIT_MASK(0, req_size_bits);
     }
 
     if (req->dir == IOREQ_WRITE)
-- 
2.51.0


