Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D911C48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 18:05:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rag5S-0002Bb-8Q; Thu, 15 Feb 2024 13:03:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag4m-0008Vs-6B
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:03:15 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag4V-0002z2-IQ
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:03:08 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a2f79e79f0cso172781766b.2
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 10:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708020174; x=1708624974; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h+kbuqXqvCRZ8Tf5uJ9Kz/BLctdAvrq0mkkiLJY8x1o=;
 b=Eb5EVRfwirJsqN2qdxvNVvbAz1i7or3FXgf0OyxyKWYbwWmYniT8yjptiaG95F9XJ8
 bFPIM6AS7K5UbW4gOtUXkWC9FtCfH/gYQo/TriClBLOgG+qtd4/eeRYwHVMrJH0U0W0W
 flT1ZP0kseRkZjzL19IL4xhoUigbcCueAQVBO3ET3UDAusrqZiMHNE1Bd6Huu1mjdk/a
 PXB33oAYCLrZILzTWc7FV8Hg3bbjAP7gpNbCzwuyG2t7GrK/fX5GOEXYGjR/2RJdRdMc
 BFIM2HQARFFn3HxlYBhyt5m3kxE/AdZMpD2EHFfZJDhTLcA7L9gE3xtxWmSFVNKp2ZW3
 Q+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708020174; x=1708624974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h+kbuqXqvCRZ8Tf5uJ9Kz/BLctdAvrq0mkkiLJY8x1o=;
 b=FdanApLWH49scpojgBlyKMVTGPROp4MUKiaZr00jFbVNnCVZ8BUBqiXy+X0C9py4HS
 nXiWNKHf3VKUIhhtg1HoLI1Q+h6cz80Ji84yRkGSBQ25rlqVMUOUrA6Om2LPksV6kVF4
 6IagB4sfWBsuV5bSigrXVxAGwoirScfFlOL/U4A9rfYb62spcAYrKaPwtX1G7h5jvJHG
 ddHY8gfx3NpUjGt/AACsQ1TLvyGkCDVDyqXxMR8O+vcrbshlKXFjV5+Yb/OQ4qZGexfW
 E/eBQGk6P0zpR9jpyBVVU2BrHVGXgEuqFaRhvWsv8TR5LEfv++8ct9K66M/m/R0Hx1+r
 HH5g==
X-Gm-Message-State: AOJu0Yy4XKK4i8+/LkxCV3G0jdQrLVBGlUnjTm2/xJnJYoLtP0X+COws
 +Cd2pPgk20+BopR5V/+ZQ1m344xjkvZ6Ynkn5rVHFnIJQCLnJeWR/eg0DwAlG74Lo6MDVunS6Em
 6sog=
X-Google-Smtp-Source: AGHT+IFG+6sDytZLaAs6wavZDs3EaRjSLqakN6vXUmittJ4L5nqFn7wIBfZBkOSA258KnlUmOX4bwg==
X-Received: by 2002:a17:906:c44a:b0:a38:40fc:2bcf with SMTP id
 ck10-20020a170906c44a00b00a3840fc2bcfmr1876968ejb.60.1708020173711; 
 Thu, 15 Feb 2024 10:02:53 -0800 (PST)
Received: from m1x-phil.lan ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 uz16-20020a170907119000b00a3d2ccea999sm788056ejb.35.2024.02.15.10.02.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 10:02:52 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Fabien Chouteau <chouteau@adacore.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 44/56] MAINTAINERS: replace Fabien by myself as Leon3 maintainer
Date: Thu, 15 Feb 2024 18:57:38 +0100
Message-ID: <20240215175752.82828-45-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240215175752.82828-1-philmd@linaro.org>
References: <20240215175752.82828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

From: Clément Chigot <chigot@adacore.com>

CC: Fabien Chouteau <chouteau@adacore.com>
Signed-off-by: Clément Chigot <chigot@adacore.com>
Reviewed-by: Fabien Chouteau <chouteau@adacore.com>
Message-ID: <20240131085047.18458-10-chigot@adacore.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8920ba403d..0ab73b265a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1709,7 +1709,7 @@ F: hw/rtc/sun4v-rtc.c
 F: include/hw/rtc/sun4v-rtc.h
 
 Leon3
-M: Fabien Chouteau <chouteau@adacore.com>
+M: Clément Chigot <chigot@adacore.com>
 M: Frederic Konrad <konrad.frederic@yahoo.fr>
 S: Maintained
 F: hw/sparc/leon3.c
-- 
2.41.0


