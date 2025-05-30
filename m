Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D83C5B549
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 12:51:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKzBg-00023k-2M; Fri, 30 May 2025 08:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uKzBd-00021x-Dq
 for qemu-devel@nongnu.org; Fri, 30 May 2025 08:50:13 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uKzBb-0001qZ-Cz
 for qemu-devel@nongnu.org; Fri, 30 May 2025 08:50:13 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-450cfb79177so9562405e9.0
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 05:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748609409; x=1749214209; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ufSxfyWU+LrfgqrHz6bvb5S7aMECLhYEgaqEeRsPhLc=;
 b=zQk8jDd0b9V7vwfqinG5f/I7QrLESAteT9L4+TQrVc40CtcuxdMVCHIXMjOWwmrC6W
 FhFM3MFWwoMfsNJ8Wdfy90UeRQr9lwTTi54GsH7e0ZdosuhhOx8uWSLKcVjUr6FsBl25
 bxippwTBosU88Wj8NAsme1nI7+/kyJ4a2p5gbBFExViRxdQABowW/gRAmmp7/ry/7RZC
 5pwigQb+7jFud4KXXQzE6RKjzuAEEGcE5uGSmlf0ya5jDZDsatgCqNABUliHb/JJ61xm
 NW1mJf7a16v0IrL4Aikrx2UmkeHmBE7iQjHHRe0qccGvobp3uOrg4dc/xBfIpgcBRNyi
 UGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748609409; x=1749214209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ufSxfyWU+LrfgqrHz6bvb5S7aMECLhYEgaqEeRsPhLc=;
 b=gSctjHNqUeXPUnGkzH7dQ6ihoYLGceXu28OPd0EurZX5muLNxfmgzEuNovXl5Czt8u
 4gZB2DIxvfscMk+TwCBZNyjWq4s45cxvyeuq1g9xMi4QCb7WCxACc73k0xrcmMQ4Y8NV
 LI62tRn8tpb6WTBDm50ePRQ+k4v2lcp1PPXrzhq3GKmb4FkbZR+aq8O8wJ/+B3C0Xlus
 M/SaKyVNxc5k3DPpFguKs6/FnlWhuT9yCoonFzitePOlgbGq9B3GedME0OnqpqRulcWq
 DngGF2LrMGQzDMC0819DQ0b3psHectPiJ0oLVSL4I/rkVIseh6LJj2rPgPwzFSzhO84l
 Acrg==
X-Gm-Message-State: AOJu0YxaDAGwxjZnu/sc97MKoBnoArCxhKj220itxtaO9LcidCqe8Feo
 NwXiKfNoAoAlRra066S2znoZHNABhQUR6mri+LR2jHinhQ8Uzwv9B/qkW4g8ywEW1YNWIvw+2Xz
 fQfJz
X-Gm-Gg: ASbGnctn+7omUMQEVEU0T5bP6zMPIQEHuaIhUm1eSploAJFwha5uByTmB4lluggD2c9
 r29KoCIrMhX+xBVnwxMJTmCSTZZKDkLX4/ZwRCkxBpEaZSEDM2WToFhWbymhpSPz8BO3EKCBfcN
 DiH0ZlmoyTkC+mDhzFMO0/imTSDjmyQVj4OITzKychfXXlJFjpNIb3Z4pIAlWoLqDsYCYhQtmF4
 B0U4/atNR58QLBDjkQRcegvK0aqw6OmsCGmjWn1pe5p7EqPx93Irsf47o4BQFiUo7ak2aV3+7py
 NuaVrET2iEwyVyq/h3EUkiStC0jk1Hk8ziw2Q8sxYgTGNMUpO+cqRFmmVpQu9GPaB++h
X-Google-Smtp-Source: AGHT+IFfRr/1fstjQWxQEZ9GNQTX271FYuegLxMDTpqlUm/rdMYYv+h4gRNAWYXUidHzMkuQrIwdnw==
X-Received: by 2002:a05:600c:6207:b0:445:49e:796b with SMTP id
 5b1f17b1804b1-450d886f1f3mr21403915e9.17.1748609409411; 
 Fri, 30 May 2025 05:50:09 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fb7dafsm17235195e9.25.2025.05.30.05.50.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 05:50:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/15] hw/arm/boot: Include missing 'system/memory.h' header
Date: Fri, 30 May 2025 13:49:46 +0100
Message-ID: <20250530124953.383687-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250530124953.383687-1-peter.maydell@linaro.org>
References: <20250530124953.383687-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

default_reset_secondary() uses address_space_stl_notdirty(),
itself declared in "system/memory.h". Include this header in
order to avoid when refactoring headers:

  ../hw/arm/boot.c:281:5: error: implicit declaration of function 'address_space_stl_notdirty' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
    address_space_stl_notdirty(as, info->smp_bootreg_addr,
    ^

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250513173928.77376-6-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/boot.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index f94b940bc31..79afb51b8a5 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -19,6 +19,7 @@
 #include "system/kvm.h"
 #include "system/tcg.h"
 #include "system/system.h"
+#include "system/memory.h"
 #include "system/numa.h"
 #include "hw/boards.h"
 #include "system/reset.h"
-- 
2.43.0


