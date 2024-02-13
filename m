Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D88EC48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 13:05:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZsSI-0001iu-L2; Tue, 13 Feb 2024 08:04:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZsSD-0001d2-2P
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 08:04:05 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZsS9-00061X-0d
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 08:04:03 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-411c93e1cd8so2316685e9.0
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 05:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707829439; x=1708434239; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4qIxF6fCwa3/mbXSgbpVLHQdzzP18rWcIr6bIztAwaI=;
 b=Lu4+GA+3ASVC7t8KFAkw3D7JzHoRTl2653c2mtOHN0yYfDdNmYfUu7V789py2O0Xy3
 9dii2az7UQhtv9Fam7tyL3dKwXjPQq1WbdZeTtzj0nVvXWbzqHn+xLnVwAtvakrA3/lV
 wWYhJJf7/GPWIaL34ND6HfW7pFDPJtc5BeVHwZVKw4TLnTcDJE1s9UliyvthkF4VsSKK
 /hsj/2fFJX++reICJGFk3S4LzgePlVX+XLKD+5yzdKciUePlYh0biE3jvvRaWDvgk3up
 W5Dx+ljtJ8ZJiZsxZcfwct37jLXpmiDCKbAFKWwL4gHS8pSQ9iQ0dfVqmRo/39/kYbyx
 hvZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707829439; x=1708434239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4qIxF6fCwa3/mbXSgbpVLHQdzzP18rWcIr6bIztAwaI=;
 b=KvoNSQAvr5qOInOD44gF9eMQO9js/Calerfs7BdorWDZ1KItH7kKBIgXCU9o2S5Bvm
 1a09BVShQ7aW3E/y0KYUmXLn9dtKW9KsOH4FKF3JMDDeCc3YAox+3NrLcw7X5pkbWUKj
 8HfbW+wWST6odPXjaTCkMG/KiDsShqDK3EPtsA85mkPWr8/505S9N4h16Qc+FMNKn1dy
 R1JNlHQtLCvNXTJeN1zEk7hbqENV8cMRaA1jDrT2E78VvH9Wt2FctX6J7TpW0FVHwsVT
 78C+8OiG04kSkLmkcO3DdsW6HNJxvDZj+plCgYg11BHmkNn/C9b4vhv9E2LD+sAD+1L4
 /Dbg==
X-Gm-Message-State: AOJu0YzLCrwzpPDvwvymCA2Mg94cN4YWwM3hNIPRyQxRZYa3r45+x8ds
 Wr1nqDSSWnuS9w6WURQv7EDfohNSuiwLXEe36HS/igyQdBS/F8MiTFWygPw+0ExF1gHnt8yXylb
 k
X-Google-Smtp-Source: AGHT+IF6m0RzViKIjBAUFgJawuW5VXCPtTABNrKyxcHR/4Kx18SMzSxe1FEqkohr3dBv1nRvi4+yiQ==
X-Received: by 2002:a05:600c:190f:b0:40f:ba02:d172 with SMTP id
 j15-20020a05600c190f00b0040fba02d172mr2334739wmq.17.1707829438727; 
 Tue, 13 Feb 2024 05:03:58 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUQZTVhRPf9nMd2cUfZQ0L4uq8DAJV3coX+r83bxHjNbI60JM/eTSaxGCThbSwhTVJG/eJOlMii2utBLJzJ6ehwsJWyIt0ubsj2alxHqhH13qqg0yR652nxCERWCLEQBBUkLJ6+PS95Ff05OMb63evgO2xSOay4PUltXFT0xVynI/dBEvjUblxkeaqy5DhEMD8lX/tGkuqI/bkMA9IeWgqCSXlhyRS5hfPkrMMV16GzkoJQrqR3lQAbGguBSNAw/fu1N2XOT7HH94+MnPFBrc880OMrvGW1R230y/g5ZQhQ6Mkz2VtHj9C5xLUC7gfZYzonbVM1U8jYAuI/FrnJe1sp4TfwW8edMZ5b96QINpVkU8EZbALgytjZDL4G2VIFBoPKTJWRxXm8TSOXLKg=
Received: from m1x-phil.lan ([176.176.128.243])
 by smtp.gmail.com with ESMTPSA id
 ay20-20020a05600c1e1400b00411a6ce0f99sm3368269wmb.24.2024.02.13.05.03.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Feb 2024 05:03:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@linux.intel.com>, Bernhard Beschow <shentey@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v4 02/12] hw/rx/rx62n: Reduce inclusion of 'qemu/units.h'
Date: Tue, 13 Feb 2024 14:03:31 +0100
Message-ID: <20240213130341.1793-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240213130341.1793-1-philmd@linaro.org>
References: <20240213130341.1793-1-philmd@linaro.org>
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

"qemu/units.h" is not used in the "hw/rx/rx62n.h"
header, include it in the source where it is.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 include/hw/rx/rx62n.h | 1 -
 hw/rx/rx-gdbsim.c     | 1 +
 hw/rx/rx62n.c         | 1 +
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/rx/rx62n.h b/include/hw/rx/rx62n.h
index 73ceeb58e5..bcda583ab3 100644
--- a/include/hw/rx/rx62n.h
+++ b/include/hw/rx/rx62n.h
@@ -29,7 +29,6 @@
 #include "hw/timer/renesas_tmr.h"
 #include "hw/timer/renesas_cmt.h"
 #include "hw/char/renesas_sci.h"
-#include "qemu/units.h"
 #include "qom/object.h"
 
 #define TYPE_RX62N_MCU "rx62n-mcu"
diff --git a/hw/rx/rx-gdbsim.c b/hw/rx/rx-gdbsim.c
index 47c17026c7..bb4746c556 100644
--- a/hw/rx/rx-gdbsim.c
+++ b/hw/rx/rx-gdbsim.c
@@ -20,6 +20,7 @@
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "qemu/guest-random.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "hw/loader.h"
 #include "hw/rx/rx62n.h"
diff --git a/hw/rx/rx62n.c b/hw/rx/rx62n.c
index 4dc44afd9d..d3f61a6837 100644
--- a/hw/rx/rx62n.c
+++ b/hw/rx/rx62n.c
@@ -23,6 +23,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "qemu/units.h"
 #include "hw/rx/rx62n.h"
 #include "hw/loader.h"
 #include "hw/sysbus.h"
-- 
2.41.0


