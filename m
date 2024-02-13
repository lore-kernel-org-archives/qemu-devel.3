Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D4F4C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 12:03:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZrV9-0005dJ-4h; Tue, 13 Feb 2024 07:03:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZrUL-0005Qx-UI
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 07:02:24 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZrUC-00016Y-4n
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 07:02:06 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-33cd57b7eabso351909f8f.2
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 04:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707825722; x=1708430522; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=URWCcZelwghQnfWxClC3fdOHYZqhuz4D09m5EBaU2Y0=;
 b=nvkG3L+QIISU3vsWPbtSiUZY1QS1tgQIL4B+kQZJcuzci5bMsL4lLLTkg4nyXvoV6x
 QYwBmTWHqwkBc9ckeAF9p2qVkjRSvRJgHgN0SQPurBTK73TrzJA3xUmP0uzBTxvR6Ax8
 gFi7Dh/2i7VNLIR8+isRWdpEUJtF1/w3oXAFvqUQE5toHV/pVdeQ2a8tYgOfihbsGFaM
 z2tXCJpl316ztukpnGzE9ZgtGTDlt3wJkvugZKxk/jZl4z3USz5klJOiWwjUB/F6oIUd
 6AxZZpX4PRHzEKRxC03O7LXwOcUuMcZ00knUx6Nh79S1YE2XA0kHFfbbFTm6NaqCXmAp
 XULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707825722; x=1708430522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=URWCcZelwghQnfWxClC3fdOHYZqhuz4D09m5EBaU2Y0=;
 b=YN14susGcH+J5HSrUCff95JrNGSNiTZhSf1dcwOsi4vj2W0V0CApt680qfNcoqzSOb
 4nTMMJuKoK7oX4Ni8THUaZov4gqVaLCEkdvF8hz98hgE3U2NF3OpuchsjmiUTHE88mlm
 mUiR0LmTG9fRtjaKFHcIEd3cKPEjVS+Jt8NAv43/DCeHEMmdhxZejnfMpwyJgRWYNEwP
 N76AGUd6qFqCRCZXnLez/9HrFGtYmEP8ypZQ9G6JNG3obxuJBQq7iG+xBOkfIVy4mzgE
 jwzWkxsU1BB5vlzY/ouzFYDdSt2u0QjfFX/NqkVR6907VoFVaGIWtcx/LgC1Or3QkwJH
 kiXQ==
X-Gm-Message-State: AOJu0YxOqmaF5/x5JggbL0hRm9CMT621Pek+HKGZU32pqiMG2v3bkquL
 K/jJ85qPFDVDjz9QNYyfjvMnG6YTXqKZV1gBcuZHgSVJapMo/b9fAQAQDfd4kbvfVRODXf3YcsH
 w
X-Google-Smtp-Source: AGHT+IFBcIQsCryECxDeQiGV9eyJexKjlZYijw8go/anuC35ucjcIWQtOlbMH7CWAwWkkNcHNV3ZKw==
X-Received: by 2002:adf:e6c9:0:b0:33b:136a:95a3 with SMTP id
 y9-20020adfe6c9000000b0033b136a95a3mr5609270wrm.28.1707825722071; 
 Tue, 13 Feb 2024 04:02:02 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXbkIZh6v+HCmpi5EqEkJ4qcPlvBQ+Rs3VISy+9MCtlJcac5fq/U7utL/DUwjfg88aCf2IvuKpveB1wwHbWjR1bHsv1aQ09lKlY7tc3z1XTKUFjiwK6/WUFXCwb669LCmDAVPgX8hd8JW0EnVSzh/YiNzQxZWK2Y3llzfyvEkPsyjJkxDpj4DPJsaAvMrSFAg79Uo0kpypaPjYIAHV5W+AcuWsPyvHMgU+g5S0Vpwf5HS+vytXbqiAaAoIog1aRqOdUA3FGDcRcHlybMiSwPd9oXCOb+meozxMwfe81AhtHOCAjNJwenx7RKXaXEFw64VA16ZkHxXI=
Received: from m1x-phil.lan ([176.176.128.243])
 by smtp.gmail.com with ESMTPSA id
 bs25-20020a056000071900b0033b45bdb2a1sm9556186wrb.4.2024.02.13.04.02.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Feb 2024 04:02:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/7] target/i386/monitor: Remove unused 'hw/i386/pc.h' header
Date: Tue, 13 Feb 2024 13:01:46 +0100
Message-ID: <20240213120153.90930-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240213120153.90930-1-philmd@linaro.org>
References: <20240213120153.90930-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/monitor.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 950ff9ccbc..3a281dab02 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -33,7 +33,6 @@
 #include "qapi/error.h"
 #include "qapi/qapi-commands-misc-target.h"
 #include "qapi/qapi-commands-misc.h"
-#include "hw/i386/pc.h"
 
 /* Perform linear address sign extension */
 static hwaddr addr_canonical(CPUArchState *env, hwaddr addr)
-- 
2.41.0


