Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6505DC54E55
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 08:45:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ret3F-0006OA-Ex; Tue, 27 Feb 2024 03:43:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ret3D-0006H0-HA
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:42:59 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ret3A-00005m-Np
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:42:59 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-412ae15b06fso1899165e9.1
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 00:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709023374; x=1709628174; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=scR0cVRlUQ+FFZFfcolEQrGBOQjFaxkZH3KxNR75t0E=;
 b=JfKiBKhvAIxJUB1Vl1vpD0KgcYBHw49OT6Q+K5+nfbK04tzUPHdqWYtPYAH9P+OPrA
 WfUAG4QYHaTpMia8IGl1ZGQt4c92+3o3getzEgmOVUJlB05ecvAzX5NwD4RN0JTBoFR6
 EBAmTXkxB/W7qEAXNn6k5EAtu/7e4whQDuvXLtgE+Ld3OEVVhlQX93ZLl7lYgf2hBO92
 9UeymH7HCQ9l59SnijxA9jQeVJqo9Drm8hZCsmabE5w2BcaWRsOJxpNJoDind5QCLlm7
 L5DIgbfyAI9V82hAnuLvgm3s3qD/T+foTmZsOc1kSvcHhsMDrdN/CLDaKBEFBFA52Zja
 Fwrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709023374; x=1709628174;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=scR0cVRlUQ+FFZFfcolEQrGBOQjFaxkZH3KxNR75t0E=;
 b=MixCeGccquBRxdXjtjL6igJAIB6YNgLAMrsWyBNjmROmttgAjWE+ukTOXLHvY47UVE
 QOBGRP2NG0wwMD4ZIpL+ScUjmL6Sa5z/UJhhNgMA+Ql6MRrIh16CYilB32xtZwrPfALj
 QfSNb0Tyy8ZtgzidDX7E9YcZKEjLVvlnaVGlnN6TMue8jZ6d1Qs6LjHyaYHojlQC1dbV
 WhKSEANc8g6FNb25hIqE4AOpMY5omaCGp3ZK6wpzMVhClfPDwXpprOne+n2oQ/8u37WV
 EG3lUDn/LJuwZyrnTfNQAE0qDn5atIpTlkTdAa45OxlgHxScU49WQKMVmn7MneuX1GEt
 mRuw==
X-Gm-Message-State: AOJu0YyHr5MudW6QRIX2KavZx8n/F48b04B2SZo/H27MQEGWDx3bkrSv
 R7oeb12RPHV3WODEh++BLw/U87Fm1t5HkwOSoHthDbxD3YqN8kQ0RGf5Y2raPNLcABE3C8zy+Tn
 I
X-Google-Smtp-Source: AGHT+IHKiSwpHMDm0QCksk1OSAVc8Wa5O5fe4dYvRzdN9IaQFzE8AXGmkVdhjJYJYqfyigWu81wlrg==
X-Received: by 2002:a05:600c:3490:b0:412:acf1:29a7 with SMTP id
 a16-20020a05600c349000b00412acf129a7mr726180wmq.20.1709023374029; 
 Tue, 27 Feb 2024 00:42:54 -0800 (PST)
Received: from m1x-phil.lan (mic92-h03-176-184-33-214.dsl.sta.abo.bbox.fr.
 [176.184.33.214]) by smtp.gmail.com with ESMTPSA id
 u16-20020a05600c211000b004126732390asm14316282wml.37.2024.02.27.00.42.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Feb 2024 00:42:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-arm@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 29/30] hw/ide: Remove last two uses of ide/internal.h outside
 of hw/ide/
Date: Tue, 27 Feb 2024 09:39:45 +0100
Message-ID: <20240227083948.5427-30-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240227083948.5427-1-philmd@linaro.org>
References: <20240227083948.5427-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Remove last two includes of hw/ide/intarnal.h outside of hw/ide and
replace them with newly added public header to allow moving internal.h
into hw/ide to really stop exposing it.

Fixes: a11f439a0e (hw/ide: Stop exposing internal.h to non-IDE files)
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20240223142633.933694E6004@zero.eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 {include/hw => hw}/ide/internal.h | 0
 include/hw/misc/macio/macio.h     | 2 +-
 hw/arm/sbsa-ref.c                 | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename {include/hw => hw}/ide/internal.h (100%)

diff --git a/include/hw/ide/internal.h b/hw/ide/internal.h
similarity index 100%
rename from include/hw/ide/internal.h
rename to hw/ide/internal.h
diff --git a/include/hw/misc/macio/macio.h b/include/hw/misc/macio/macio.h
index 86df2c2b60..2b54da6b31 100644
--- a/include/hw/misc/macio/macio.h
+++ b/include/hw/misc/macio/macio.h
@@ -28,7 +28,7 @@
 
 #include "hw/char/escc.h"
 #include "hw/pci/pci_device.h"
-#include "hw/ide/internal.h"
+#include "hw/ide/ide-bus.h"
 #include "hw/intc/heathrow_pic.h"
 #include "hw/misc/macio/cuda.h"
 #include "hw/misc/macio/gpio.h"
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 4a59e2fd37..13dde50cba 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -36,7 +36,7 @@
 #include "hw/arm/smmuv3.h"
 #include "hw/block/flash.h"
 #include "hw/boards.h"
-#include "hw/ide/internal.h"
+#include "hw/ide/ide-bus.h"
 #include "hw/ide/ahci-sysbus.h"
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/intc/arm_gicv3_its_common.h"
-- 
2.41.0


