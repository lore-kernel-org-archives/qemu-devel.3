Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75165C87FCB
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 17:33:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulsrw-0000Ds-F2; Tue, 12 Aug 2025 13:33:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulsrs-0000AT-Dn
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 13:33:00 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulsrg-00041z-Mx
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 13:32:59 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3b913a76ba9so764999f8f.3
 for <qemu-devel@nongnu.org>; Tue, 12 Aug 2025 10:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755019958; x=1755624758; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z5eXiZ5bUkWxn9g1iSl0pweK9buhzmmZuq6RlEEEEhs=;
 b=hv39cmQ3avRvn8j4Vltgvcr4U+Lu9MoLCuNX3JEIzcV74zWcQ5HFuDoADTMW08aIUa
 zJcTIVd9SS7Qhzw2qeid7my2ptOjSfEM7G08lOpNgjRX+OBoCXEq8wVXNqfqo3JK2N5s
 q00N4LKCe5T8KsD5hopHnZoMBCLZohiRFduDTHI9e1tS0xrLMG5mRbPhuHbTG8tHUM37
 bP5WkWIa3w9nXpXtyugEOsN08DxnDgZmBRPJ0lIWjXpVFiEJFVpNSIbGlb8Oq5ZExVnJ
 2VohEM+/yeI9WuyeOKFsLTwlLZ24ExDFjm4njLGDlxHhckWtFR5/8d0Ho3VArpewB1Cf
 NZ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755019958; x=1755624758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z5eXiZ5bUkWxn9g1iSl0pweK9buhzmmZuq6RlEEEEhs=;
 b=I/TjWQr7vHhm1ESX1E7UNo1pmtIUVmwkDutez0LNnqBLU6du4s/xMPjP0sDtTDtmXs
 Lo4bVGN5jX5tJO1G/h0qSMJlqEhA5hwPyDaMXc+fzt0FsXTuHk9YdpQVtMKIniwqBfDt
 BJg2e8ZJ2ICth7tp/VqCviu1wYecK2T+D8aEMPty6mv5nfO2GDhq8rN1vLhTa9ay+voD
 Chfc/OZvjUJ8UVVxyxk+QqYxzJcannSFW1hZ/7d9WLdnVD1F/aVQvXWaIGYaXSAUJoFT
 n/RceWHEyN2dAUg+UJWcRrTnPuM8YtOVyFe1ngNytigO407kw6CeLcbjVbOWeRxqJAM7
 PeUA==
X-Gm-Message-State: AOJu0YxYQXHuzUKoMA2VxTeowTHWO21cyAZ2JOIcUcmiQRwbfY6RI+0J
 QCDnM63aTyiND3cT3zb4+TRf8fhmWEb6LO4PWo+E7xDz5F37aFVkb6R94CCoOdDg6s66c3OieKN
 PE3yE
X-Gm-Gg: ASbGncvp9g4ZvKzYBnY5cfq6kqeUtpzj77Oq08LdiAWtMoGhSBWlZAhoNoUEMQf/k4M
 OCiVIF7CrruEcnwWhId0BWUBkETYV8Y59x5owloOvJpM3gi/b1QUWFRFvXxhdlynwSiYiFWuoDm
 Nm2FqisDaP2cBqRbzvRWrGvJDa2+1zZqtP2OWrcFHww3vEuZQONDXSfzMydN7Jlkl2i5bK/azdA
 SCjVOgkQvJYjirwmL8bziW8nQIwnrxm3yLBcZ/rK+DWWGfmazNDgeov9/nJu7W9P9hrrePUzpQG
 ZLoPzDVpgjWQfka1550JjW4ZjZOKu5jJ9UCnHAM6eu0vUR7RT/ERnTHBk0KC4eqj7kS1qWv5XZR
 lJBwBkd6rpMMNdEplIo9oFQk+cuecHce0eBhaIA8JRHfOYoyiYtN+tvkYML+8xvsLsMXW9lyv
X-Google-Smtp-Source: AGHT+IFGx5zQ625lglNAX3SUghhR3SCg/Q+RQ+KvhIEwPgE/2jGLjAJPz5he0g4tOaoPan89v16jiA==
X-Received: by 2002:a05:6000:24c4:b0:3b8:d4c5:686f with SMTP id
 ffacd0b85a97d-3b9173166b4mr195004f8f.39.1755019957996; 
 Tue, 12 Aug 2025 10:32:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3ac158sm45805210f8f.4.2025.08.12.10.32.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Aug 2025 10:32:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [RFC PATCH v2 10/10] target/arm/hvf: Allow EL2/EL3 emulation on
 Silicon M1 / M2
Date: Tue, 12 Aug 2025 19:32:34 +0200
Message-ID: <20250812173234.86970-1-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250812172823.86329-1-philmd@linaro.org>
References: <20250812172823.86329-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Another API PoC.
---
 target/arm/hvf/hvf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 84c0c0275d6..df63584f456 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -17,6 +17,7 @@
 #include "system/hvf.h"
 #include "system/hvf_int.h"
 #include "system/hw_accel.h"
+#include "system/tcg.h"
 #include "hvf_arm.h"
 #include "cpregs.h"
 #include "cpu-sysregs.h"
@@ -585,11 +586,14 @@ bool host_cpu_feature_supported(enum arm_features feature)
     case ARM_FEATURE_GENERIC_TIMER:
         return true;
     case ARM_FEATURE_EL2:
+        if (tcg_enabled()) {
+            return true;
+        }
         ret = hv_vm_config_get_el2_supported(&supported);
         assert_hvf_ok(ret);
         return supported;
     case ARM_FEATURE_EL3:
-        return false;
+        return tcg_enabled();
     default:
         g_assert_not_reached();
     }
-- 
2.49.0


