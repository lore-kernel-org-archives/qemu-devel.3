Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB2FC3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 20:41:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWMJJ-0001C9-Ph; Tue, 23 Jul 2024 16:40:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMJE-0000be-TZ
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:40:33 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMJC-0004M5-EA
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:40:32 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4266eda81c5so52350225e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 13:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721767228; x=1722372028; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bELfHk4oMv9ib41OJIdVRWkzH2ywz3o3d2vSZHxMu3U=;
 b=RK+UIhVtK8hxHlkoBAmgJcTms9ifmyMR+w1i3VlRsCkDVAOB7vVQ9BPe8Q4wHxMBVE
 pmlHZk6MHoob8y21NL3t+bxkIEjXsXg03qn8RvXI5mh9Ih4PejDFJ1gtqYTu18dGsXE8
 cBx5HDwyEm7NtCKPAZSWw3S7pcRM/jbn13xdlDfeBKiuPE7JNe1F+r0PyeXaILhZQ56X
 oRmfCsMyL0ZYVm27R0yTozYFxlwRO8bh33gSym+X/Z+yiiTfLkHdnXNGXZpHwX+OXATm
 biMpin/xjzsAD+2q3hD5fxx9BBXDvYmTV0e0l+MYPRWKbqGOIihB/xMyx17qAyNdKSWL
 zXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721767228; x=1722372028;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bELfHk4oMv9ib41OJIdVRWkzH2ywz3o3d2vSZHxMu3U=;
 b=Wjr9tpxKa54/eJCVOdbqZ/EEhRxwoD+pokqZ8rYBu1hU9Yw1qCK+nyaVgXGJQ+vkPo
 6TbHc1P2qZOAejQTSBVwMXXfXhJd48ldkzSnOmlDQK5mqavzRM7eSMBnvCkJuTBfQpeK
 jYIcQDQsA10WurXDGnQShu0OydH1+7hZ9fw6sSaI23bT57K8pRRCb33Jgl6Atm4ztTMH
 1g6tAffrK7s/8floQrT8qZUXhABeETG72IANZJEgPt4EhPNaBceU6P6bRlFyFXs/RYwm
 bec9b8xzWJxsYbv1e74Ft6QKnIPsV58wx1D/u8IbFNdAtUCxVW0PIKDH+5bYKIUs4u4J
 jO/A==
X-Gm-Message-State: AOJu0YyiTohyy98aeSGjhPAZ/LK4KyUWfmjhcQfQJA4t8cnFlHzTYmFr
 wLX4izZyRvD0IpsFk8X7W4EQZ13TMxEHIHF1c1+qkIv9BEB5BELtBCcKrDcecnid8WN3f3xAw0D
 h0yo=
X-Google-Smtp-Source: AGHT+IEXQVGc+DMr9iNCRoC3AXhORrn+nS/1uuISM9fIH4K/vryx23FDxBGUNc+zAQMZWl+nrA1PLw==
X-Received: by 2002:a05:600c:1d24:b0:426:6416:aa83 with SMTP id
 5b1f17b1804b1-427f7ab6468mr4940655e9.6.1721767228163; 
 Tue, 23 Jul 2024 13:40:28 -0700 (PDT)
Received: from localhost.localdomain
 (vbo91-h01-176-184-50-4.dsl.sta.abo.bbox.fr. [176.184.50.4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427f93e5eeasm362685e9.38.2024.07.23.13.40.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jul 2024 13:40:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yao Xingtao <yaoxt.fnst@fujitsu.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 16/28] crypto/block-luks: make range overlap check more readable
Date: Tue, 23 Jul 2024 22:38:43 +0200
Message-ID: <20240723203855.65033-17-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240723203855.65033-1-philmd@linaro.org>
References: <20240723203855.65033-1-philmd@linaro.org>
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

From: Yao Xingtao <yaoxt.fnst@fujitsu.com>

use ranges_overlap() instead of open-coding the overlap check to improve
the readability of the code.

Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20240722040742.11513-12-yaoxt.fnst@fujitsu.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 crypto/block-luks.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index 5b777c15d3c..45347adeeb7 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -33,6 +33,7 @@
 #include "qemu/uuid.h"
 
 #include "qemu/bitmap.h"
+#include "qemu/range.h"
 
 /*
  * Reference for the LUKS format implemented here is
@@ -572,7 +573,7 @@ qcrypto_block_luks_check_header(const QCryptoBlockLUKS *luks,
                                                        header_sectors,
                                                        slot2->stripes);
 
-            if (start1 + len1 > start2 && start2 + len2 > start1) {
+            if (ranges_overlap(start1, len1, start2, len2)) {
                 error_setg(errp,
                            "Keyslots %zu and %zu are overlapping in the header",
                            i, j);
-- 
2.41.0


