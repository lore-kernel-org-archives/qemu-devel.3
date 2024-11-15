Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D85D68BC8
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 16:04:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBynR-00049S-Vk; Fri, 15 Nov 2024 11:03:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <32nA3ZwYKCtkMJLP9CBJJBG9.7JHL9HP-89Q9GIJIBIP.JMB@flex--roqueh.bounces.google.com>)
 id 1tBynO-000498-Px
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 11:03:42 -0500
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <32nA3ZwYKCtkMJLP9CBJJBG9.7JHL9HP-89Q9GIJIBIP.JMB@flex--roqueh.bounces.google.com>)
 id 1tBynM-0003ud-Ux
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 11:03:42 -0500
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-e2e3321aae0so1184380276.1
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 08:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1731686619; x=1732291419; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=CaMy4sZhLruE2/rOqIYreQpf3lX4IZAEpEV0rXHSsk0=;
 b=MpcRTnCe9iD4bRLSAgtIRtwoJAJJVxyfUkvfTYUOwrTUM0Kz9IwJZKQ8AR98Ui9doD
 hCc6XbFI7hMQnVPzkaKPNAyBwwuU1MqxBu2jLNd8ko0RA55T+E6J2lcnBkR2gM8gJ4bf
 YYAIWxfGVWUAKQAG/QoWpx7iWY8uWvRrkuTEBvfgfrzIavNkuQ1w9ZpkHQcMjy2+UBYy
 y+iTKJUhyW1d85aEPaVWza+aUJpTamrTDhId4PK4SVsFrPNeAHNK+zIHeelqnx0PhiNq
 ZnkxBatE5idJtbsO5XgXDWPO+22PwU7317gDbSY/hVx4dJGMCtP+woIf14XOLuOfAGLP
 nqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731686619; x=1732291419;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CaMy4sZhLruE2/rOqIYreQpf3lX4IZAEpEV0rXHSsk0=;
 b=CdfYr03Qj/wWGFpX+gUPCxEOs/k1IEL1Bh18A4S1+vCV/0DpsmCl/5CUXsrKWMY+u4
 MkaGl030VslgnniwrF1a8UfLNp/gPa2VQbWxotlPbiRdZPka5s0Od0zOqnbGUoYV/RQa
 qYqfJNytdClGSvZIyC4SJbZGet9TlrVdv0JwToOWV0p2zYsUS2NGEJIO63SVv2Q6dx5y
 yKomnqGoB62/2ZlCCbnv59+kGUI4F+c0oWWx9otAru6RJHk13wz8JK+yeuwPlEdM/23N
 amTJU3aPulaNdaLnzbVT4At6JggsfFlCAVDJqwYh0Mt6Sjavebgt6xqM9mWMSj6YjQnd
 6nCg==
X-Gm-Message-State: AOJu0YzkNf142VNC4UKymBsXKZsHnmb5GuOGamt5Rjxr/Tfy6dp23CRU
 J60/25wcaEoldYeXTbE+Aa3hd7ThDquuIqYzgR47u7w9OO7qeO5bwPWGiUkCdag7Qc4nDc6+w/9
 AZQ==
X-Google-Smtp-Source: AGHT+IErCkrS90fiHcGg+bwh6if6MtWNQjcvKN88eUJllOzKl1qmgvM2bJOUghRpSURGzaL2Lj2LKc+SzJ0=
X-Received: from roqueh.c.googlers.com ([fda3:e722:ac3:cc00:4e:3bc9:ac1c:1ab])
 (user=roqueh job=sendgmr) by 2002:a05:6902:72f:b0:e2b:da82:f695
 with SMTP id
 3f1490d57ef6-e3826394879mr3594276.6.1731686618635; Fri, 15 Nov 2024 08:03:38
 -0800 (PST)
Date: Fri, 15 Nov 2024 16:03:24 +0000
In-Reply-To: <20241115160328.1650269-1-roqueh@google.com>
Mime-Version: 1.0
References: <20241115160328.1650269-1-roqueh@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241115160328.1650269-2-roqueh@google.com>
Subject: [PATCH 1/5] hw/watchdog/cmsdk_apb_watchdog: Fix broken link
From: Roque Arcudia Hernandez <roqueh@google.com>
To: peter.maydell@linaro.org, farosas@suse.de, lvivier@redhat.com, 
 slongfield@google.com, komlodi@google.com, pbonzini@redhat.com, 
 venture@google.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Roque Arcudia Hernandez <roqueh@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=32nA3ZwYKCtkMJLP9CBJJBG9.7JHL9HP-89Q9GIJIBIP.JMB@flex--roqueh.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

The patch changes the comments to point to the latest Design Kit
Technical Reference Manual.

Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
---
 hw/watchdog/cmsdk-apb-watchdog.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/watchdog/cmsdk-apb-watchdog.c b/hw/watchdog/cmsdk-apb-watchdog.c
index 7ad46f9410..e4d25a25f7 100644
--- a/hw/watchdog/cmsdk-apb-watchdog.c
+++ b/hw/watchdog/cmsdk-apb-watchdog.c
@@ -12,8 +12,8 @@
 /*
  * This is a model of the "APB watchdog" which is part of the Cortex-M
  * System Design Kit (CMSDK) and documented in the Cortex-M System
- * Design Kit Technical Reference Manual (ARM DDI0479C):
- * https://developer.arm.com/products/system-design/system-design-kits/cortex-m-system-design-kit
+ * Design Kit Technical Reference Manual (ARM DDI0479):
+ * https://developer.arm.com/documentation/ddi0479/
  *
  * We also support the variant of this device found in the TI
  * Stellaris/Luminary boards and documented in:
-- 
2.47.0.338.g60cca15819-goog


