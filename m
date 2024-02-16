Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB459C48BF3
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 19:28:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb3s7-0000FL-Qy; Fri, 16 Feb 2024 14:27:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atp.exp@gmail.com>) id 1rb3s6-0000Ez-1R
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 14:27:42 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atp.exp@gmail.com>) id 1rb3rz-0003Xi-4S
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 14:27:39 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6e0fc87fc2dso1547146b3a.3
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 11:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708111653; x=1708716453; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HoLGVZQMG5dnIrL9uihad3ei/oBXV58HVjKGJG/GFFs=;
 b=D/Zb22olOVF92qg6KV/uAAfnFFoB3ZcFLub5iVdaMHC97z5gkc9fe3KDzbT4FhhuY9
 4Y9UWf8hcNZD84l8KXTnrQ9NdE2+EaGW5hmsiGmGv6E/mz99eG1PxRJ0aHClAMgdXmCw
 odDCuH8IsbKxWmB0FpYkKG1BcNL8izyYW2YUoQswsf0jXiBtC9i3cXXHoOzS7652/fet
 /PpNQOvNB9jbkuBdQ8VTrJbXokj3Z74UFacVGnK3SlYJHGVCtAUN/ctX9JUIiPZPzHR+
 UlSHXYZvLlXM7HDqbfQt30B++xwVDuTZnpwI8zJ5C0gzdzcUj71xXHmNfeF8iSi8JM4/
 mStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708111653; x=1708716453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HoLGVZQMG5dnIrL9uihad3ei/oBXV58HVjKGJG/GFFs=;
 b=AtQOv2Yw7cKWBE0ExOE5L3PBNxNa4ol20aGhSPVo5VkwsdNuG4GWP5vGdiYDhL6t0A
 4MqgN/+3FWoqdYJmClN6T54b+k2SDh3XU0TAhB47zbHnwMEGwSIb+d7HwJKidLtbrUY1
 +/Jw0Rkbc9CYl4hqy/UOVj+AxJ7s2c6NwEPvH4M4NvH3GwooyHuSr3+yxF6JbfhpdQ0L
 WXhGpScWiCQcI32FPuxtawHUBsIZ0/jurIWVnwQhy0DlgHnkGk3oD4Y6szvrW5H2B4eq
 HauEzsaCl8X+RBTgZLsIvMUcpBtBpXjUfaHG7XV4DFJTQwCz33kiCdHewGgddaglvn4Q
 nwSA==
X-Gm-Message-State: AOJu0YwH1htxy51FqfrNf49yqOBGjc8LAP3Rj1qaq1cPXYlqxfY1SG8h
 TvNn0M5Diac/e0Nb+XAkM2vQrElFYf795V+b2/E0PpQUio0lSdAvhtWvavwq3JU=
X-Google-Smtp-Source: AGHT+IFk3tv/krZsh8dZs5+K815g/3f94O8ssPZ4BFxqxj2HVvIwyl9I9OUJGkeJF118MuWE+CJ9Yw==
X-Received: by 2002:a17:902:a381:b0:1db:2d8d:914 with SMTP id
 x1-20020a170902a38100b001db2d8d0914mr5649107pla.53.1708111653027; 
 Fri, 16 Feb 2024 11:27:33 -0800 (PST)
Received: from iuseotherswifi.notpua
 ([2401:4900:60d1:9963:e637:dcdd:1fbd:732a])
 by smtp.gmail.com with ESMTPSA id
 v9-20020a170902b7c900b001db7709b322sm202579plz.298.2024.02.16.11.27.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 11:27:32 -0800 (PST)
From: Abhiram Tilak <atp.exp@gmail.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@kaod.org, david@gibson.dropbear.id.au,
 harshpb@linux.ibm.com, Abhiram Tilak <atp.exp@gmail.com>
Subject: [PATCH v2 1/2] misc: m48t59: replace qemu_system_reset_request() call
 with watchdog_perform_action()
Date: Sat, 17 Feb 2024 00:56:13 +0530
Message-ID: <20240216192612.30838-4-atp.exp@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240216192612.30838-2-atp.exp@gmail.com>
References: <20240216192612.30838-2-atp.exp@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=atp.exp@gmail.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
 hw/rtc/m48t59.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/rtc/m48t59.c b/hw/rtc/m48t59.c
index aa44c4b20c..1585a2d399 100644
--- a/hw/rtc/m48t59.c
+++ b/hw/rtc/m48t59.c
@@ -36,6 +36,7 @@
 #include "qemu/bcd.h"
 #include "qemu/module.h"
 #include "trace.h"
+#include "sysemu/watchdog.h"
 
 #include "m48t59-internal.h"
 #include "migration/vmstate.h"
@@ -163,8 +164,7 @@ static void watchdog_cb (void *opaque)
     if (NVRAM->buffer[0x1FF7] & 0x80) {
         NVRAM->buffer[0x1FF7] = 0x00;
         NVRAM->buffer[0x1FFC] &= ~0x40;
-        /* May it be a hw CPU Reset instead ? */
-        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+        watchdog_perform_action();
     } else {
         qemu_set_irq(NVRAM->IRQ, 1);
         qemu_set_irq(NVRAM->IRQ, 0);
-- 
2.42.1


