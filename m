Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BBDEF45A0E
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:55:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHx1-000410-Ve; Fri, 10 Apr 2026 15:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBHwz-0003sF-IM
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:55:33 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBHww-0002RN-4t
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:55:32 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488afb0427eso30801095e9.1
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 12:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775850928; x=1776455728; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TCjDcmgJjEnwXjW08r4omEzNwMlkd/NuRbLQA1eGzug=;
 b=tMzF32Bba2ULpYnt/xAt3Or/AkyzDRYSM4PM5HmYVRQ2O05NbEG9I1Ezi0pO/M5WsH
 8H74neGEuTcYCkRA+lkD/WFnvo3nQUMo/xrlWTeDWDAwJUTj2ExpVAz4nRwZGsyVK7wA
 vLDfNrZzcGlna15dg8ZNWVVyuiKTjJze/Wwnm2LPIkFyJBqHu5Gawoozp7mYGI6BRhjd
 k88T/CdBGcHo5J6RvIf8rDjiG4lF3JUQm0lqgqABQHjwMDiLWLv/7CNmlDmmjIyD1Djl
 5zRkPT6itzgN1g2+mFwUPYZf3cYMaBZLcMHzcZs0QXEbK7JxBSEBaB8L7+DJrx3SqlUs
 r5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775850928; x=1776455728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TCjDcmgJjEnwXjW08r4omEzNwMlkd/NuRbLQA1eGzug=;
 b=Qk9xaobLlKc8Z7opXDogsz+J1wa4CGxXCiS4Nw7qQ6poYnuGAIenphuxdQwxbt+4XQ
 PgnTFqZItEdvzzdPqmIVCIMZ4ZTyL1/jkM47duWmQWfHpFCSd/CMx7r80lKXZtAo5aYx
 7qhuqVAHyiLpVyqiyha4Fd+Jn/ICRGBKujxQ/XWedkWjXq/y6mZ5XJ8hFSCV8KjPhwFM
 Z3YSonyzQFbRZczen1VR1N3itAdz1f2u8Jfq2dPqy2k5iQu70/OnkJvIFvD6sA76EcAp
 Kxhc9sUD8QgHr84MuDP3UdzqL4BqGTclPxdI+6+50IpRlzFUVVVUpoV6RSXtXNFoI6Aw
 ZFUg==
X-Gm-Message-State: AOJu0YxB1WFadf54g9DwhQMs2OI3s8xEtV+cuTmEceNoU709VrpTZkVZ
 lGUBvLmD6ZmHtVekJLZe/Sm+q/rXnznrUQEBfH0+cdsUmZmWeXMRQ/RVAjkLlk88ju5mGfwdMZD
 wVdbOeZw=
X-Gm-Gg: AeBDievET2At5/FpzIysY9yHyWXhlMbx3LqfZWGOgNMArzxY3ZwvT9e21uZfkFaw9Vd
 9UassQjwy449/cldjMLathQVQ2U4dgY4HutuZyXK5l9ATz93av9EDjieMMvPHixywbJZw4Vl+EH
 hPiIt/1ypc6pxTpPd8nCdoww0N8n3hrlTl83rw6pSRh99D0MPCRSfpLU1pMp/Y2p0O4inHVdmoN
 hY2/yB9+myRVkM7lQThhdi2APl+kDRuiq9W4IIklibz33u6u9PQjWU2KCKQfO1GLToj5ciphf2p
 EvLIu5In6kYc0+0sTE/rGZxRT+Z2HGJjO0QIx8TTLIPhABwwAC5XvS4y4ene4IGIXGsu94CryA+
 U2B59TsQk+K9foDEhEWtv8LJbD9NmGicdP8Mr1Yc0EdBPP355Zbb6yWoHpF9ijmKdODSRJgcP+y
 WlXR8wdoIJvIBP7zLuyImUVoiLU9fi/hat+TMX/rS2pImIGn073GMiqoL1E4xIGRByBddtCrwU
X-Received: by 2002:a05:600c:c088:b0:488:a639:b772 with SMTP id
 5b1f17b1804b1-488d67dbd80mr44469335e9.7.1775850928231; 
 Fri, 10 Apr 2026 12:55:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d5888c12sm109907875e9.3.2026.04.10.12.55.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Apr 2026 12:55:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v2 17/27] monitor: Make Xen emulation commands generic ones
Date: Fri, 10 Apr 2026 21:53:11 +0200
Message-ID: <20260410195323.17937-18-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410195323.17937-1-philmd@linaro.org>
References: <20260410195323.17937-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

In order to build hmp-commands.hx once we need to stop using
device target-specific check. Use the generic pattern to make
the command available on all targets, providing a stub with
kind error message when the feature is not available.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/kvm/xen-stubs.c | 12 ++++++++++++
 hmp-commands.hx         |  2 --
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/hw/i386/kvm/xen-stubs.c b/hw/i386/kvm/xen-stubs.c
index ce73119ee7a..bf6ac28bef4 100644
--- a/hw/i386/kvm/xen-stubs.c
+++ b/hw/i386/kvm/xen-stubs.c
@@ -12,6 +12,8 @@
 #include "qemu/osdep.h"
 
 #include "qapi/error.h"
+#include "monitor/monitor.h"
+#include "monitor/hmp.h"
 
 #include "xen_evtchn.h"
 #include "xen_primary_console.h"
@@ -37,3 +39,13 @@ void xen_primary_console_create(void)
 void xen_primary_console_set_be_port(uint16_t port)
 {
 }
+
+void hmp_xen_event_list(Monitor *mon, const QDict *qdict)
+{
+    monitor_printf(mon, "XEN emulation is not available in this QEMU\n");
+}
+
+void hmp_xen_event_inject(Monitor *mon, const QDict *qdict)
+{
+    monitor_printf(mon, "XEN emulation is not available in this QEMU\n");
+}
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 5cc4788f12d..06d7b17bf25 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1839,7 +1839,6 @@ SRST
 ERST
 #endif
 
-#if defined(CONFIG_XEN_EMU)
     {
         .name       = "xen-event-inject",
         .args_type  = "port:i",
@@ -1866,4 +1865,3 @@ SRST
 ``xen-event-list``
   List event channels in the guest
 ERST
-#endif
-- 
2.53.0


