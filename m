Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CBA0C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 19:28:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb3sH-0000IH-Fm; Fri, 16 Feb 2024 14:27:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atp.exp@gmail.com>) id 1rb3sF-0000Hz-D8
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 14:27:51 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atp.exp@gmail.com>) id 1rb3s5-0003YC-4V
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 14:27:50 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1db5212e2f6so18006655ad.1
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 11:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708111658; x=1708716458; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1gX9IUPWPcBf9gAlly0i+hCoY3fDrVJRBiGPX7Qe8RY=;
 b=RAskZREu1NRrNS1fHUTyg+kIli7wJqXSK2iSBQ7Wc9f2P68admjt/qXoTWpNt4ZjTL
 7+TGNcXOAILYEsKuvRnwTU9NRFARJJTe3Z2DzuytwRw9OPx52p4n1FUOnAsrwtTRuZ+L
 pV8zFChwyuuqG0252lHM5W3yiyHOJkW8odrMkFsAHWhyZiDRrbI9C7hKmt63hSYKLaB9
 Qfi4/i0M/7sMpRkfDtO3U+XU2+xuyTTFc/+42qRLyrUJ4tVHWflj+1u3uww+hJrVTpZC
 kzVC/dphxbfVbZDzYNcgphNl4KxAx6MQ8GmCcYTmVEGqA2Dk1w6cvOIMMUk88+56TwaS
 qXeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708111658; x=1708716458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1gX9IUPWPcBf9gAlly0i+hCoY3fDrVJRBiGPX7Qe8RY=;
 b=EZE5++xDjusRmnTlpYkuFj8PbXHU2h4zwxssvVZh2WcMYEONsQWkSX6v2cLQLxm4SO
 jMpykMBreXDOJh7oZdyJ11sEfENtvKjE2UHAuiRK530u18ci2Ej0B18HaqOTIegbcu3l
 sB1WQVl2X57suLltEe2BIxlqXWRD2gJteCzArb/+8cRkSyqE2qnCrRoXlh23zU8BFnGQ
 WWs55W0h1YFi9KXV4TK/Q75DJonPV3qO2bGsDg6WTA158TCLmwBayCxNjJUhx6eKQnc6
 9VGAc1TQPJozMsc6v6Py7DZ30my1f5xXjjUuITY9Mj82ljLUvVj3ZNnUXujrpbmGGj3m
 YWGA==
X-Gm-Message-State: AOJu0Yy2CBIHtONK8zBh+rCALYnezxfNjIZriguR4qzgj+Ni84iAyyfB
 1GZTZnPnEns+fiFFUutt96+MYRdA/DkagxqRpGpljjmpJvNMe1b5YhMXRTosnGA=
X-Google-Smtp-Source: AGHT+IFXh5WBATjg2/fYYDVPF0j+RM9HtndyjpIkEJA6pI+JfHCVczmzemxvB2izKVBYqv3DbOlbww==
X-Received: by 2002:a17:902:bb16:b0:1d9:ef4f:376b with SMTP id
 im22-20020a170902bb1600b001d9ef4f376bmr6760884plb.8.1708111658053; 
 Fri, 16 Feb 2024 11:27:38 -0800 (PST)
Received: from iuseotherswifi.notpua
 ([2401:4900:60d1:9963:e637:dcdd:1fbd:732a])
 by smtp.gmail.com with ESMTPSA id
 v9-20020a170902b7c900b001db7709b322sm202579plz.298.2024.02.16.11.27.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 11:27:37 -0800 (PST)
From: Abhiram Tilak <atp.exp@gmail.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@kaod.org, david@gibson.dropbear.id.au,
 harshpb@linux.ibm.com, Abhiram Tilak <atp.exp@gmail.com>
Subject: [PATCH v2 2/2] misc: pxa2xx_timer: replace
 qemu_system_reset_request() call with watchdog_perform_action()
Date: Sat, 17 Feb 2024 00:56:14 +0530
Message-ID: <20240216192612.30838-5-atp.exp@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240216192612.30838-2-atp.exp@gmail.com>
References: <20240216192612.30838-2-atp.exp@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=atp.exp@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

A few watchdog devices use qemu_system_reset_request(). This is not ideal since
behaviour of watchdog-expiry can't be changed by QMP using `watchdog_action`.
As stated in BiteSizedTasks wiki page, instead of using qemu_system_reset_request()
to reset when a watchdog timer expires, let watchdog_perform_action() decide
what to do.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2124
Signed-off-by: Abhiram Tilak <atp.exp@gmail.com>
---
 hw/timer/pxa2xx_timer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/timer/pxa2xx_timer.c b/hw/timer/pxa2xx_timer.c
index 6a7d5551f4..6479ab1a8b 100644
--- a/hw/timer/pxa2xx_timer.c
+++ b/hw/timer/pxa2xx_timer.c
@@ -18,6 +18,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qom/object.h"
+#include "sysemu/watchdog.h"
 
 #define OSMR0	0x00
 #define OSMR1	0x04
@@ -417,7 +418,7 @@ static void pxa2xx_timer_tick(void *opaque)
     if (t->num == 3)
         if (i->reset3 & 1) {
             i->reset3 = 0;
-            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+            watchdog_perform_action();
         }
 }
 
-- 
2.42.1


