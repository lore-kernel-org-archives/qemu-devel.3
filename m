Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F35C636C5
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 23:23:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuIn5-0003g6-1d; Sun, 22 Feb 2026 18:23:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuIn4-0003fs-4G
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 18:23:06 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuIn2-00015z-L9
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 18:23:05 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-48069a48629so38419555e9.0
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 15:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771802583; x=1772407383; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mbYRL6ABvOtU3lbcSyBnxWPzihf6NMuNWsP1RdoVYmE=;
 b=vOSZW3ELPkU2z3uJTjT6PLY1IvE7qSsV1BW6CZvnyViuoAXCS8v0LZ9JUbNfBpe9Cv
 jH7gwFnerBS5ERCrFYvMyh8NdIYxjdN+lVbt5d2eM0eoBVkikqGGj0o912audAnF34g0
 bGyUrhWVNXQwNdsYQLnEwlwc5zzdyA3y2yljB3WLktICWBWnk1DdR9Hg4NaoOzR9175/
 EYQjiO+SzrR9nVTEx9jPauyETRRu6sd2hBaFKMQdbaMMmIO5oJUT7t5vQMVPfZCI2BXi
 vjsuenl/RXBukISiKrb85yQFPwGiDJoLwgNPJpjE5NKsflqeBdLQHD0ouLhPuxKlXVaM
 dOJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771802583; x=1772407383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mbYRL6ABvOtU3lbcSyBnxWPzihf6NMuNWsP1RdoVYmE=;
 b=aISkXy+fy6gPy5Xfp0yGfZqlEdP8URjCQQwqMfsch163mpJuEsThD8YsVCHoEJ67wg
 u3+E7nFl1Y05y1eXtpS1d2rG38s6+0ldaH+nBbVBAaFZ0t6SU0iCv9TrM2EuZ8YLjgCU
 WiF4vECDO1zFDxysq4HIhP/VwOBqp3lEl2wzjy0ZMibPJOS0Y1m/QPf/MrxOrRZ+TRWj
 9ClwqEUkry1dKfzEXl5oeEb6EKRXFvhV8V//CmvHqlQO6pDUhs28TO5nVn+uLndGnhgZ
 c0f3nQLpj1LomtzKHrIRAVPFYtA3kql4h+uLg/Xje4jzE++mTIKa/rXzJNss/FITuLPI
 vfww==
X-Gm-Message-State: AOJu0Yz1KellTr7DcMeK3S+q5f5FTGDxGTIw7mSTT5yW0wRqJilV+fB4
 LrdGwrp0OFgo5MJaVCr4zXlIsOmwnTUMQgPRoKlUMXHv3TuNsmJNKRzrtxejmXJCDTlXmh/z9Aw
 tYyTO5mE=
X-Gm-Gg: AZuq6aIb29ixWojsd4uGnZwvO87xj4lEicA/xvoJhvbdlC0+Vf5IZqguhT1rqY2Hjm0
 O7h7+cLPQ+sQDrpzaWG78RLU/knOXpHtFJRGjhMxmdE/po/Mbl/f0gDC70kyIRsoJYGWD+w9r1M
 hVU3F5dX0A9G8iHgoTCpZpQXWYPaFZOMIl1AmqUe90eYXyPD9tpT7eIOUh+3r96Vx1KCvtYLN5U
 sjdbePc86KFQrfQPYm+W1nRQT1VpITfrTEyFq8OHHTXpdnFlNY64Epkl3lIIX/78y6d/V2Q0ylH
 pHEa7YIgP7GGVe0+DjwqUSYaUcxBn3fMBPj+NQqIbTHDTyJJ1dGci9p/X2naqXuEkV07yMo13mx
 8BRHctkSK3eXtdEc1bQ+pFyWVM803Mzv9ng0ezPgwW9rRzPaROuJCL16LxqgWRUR+/sB98Dylfi
 tHdT262ecP0phP55pjIVO4AbMumTUwmwX8bXEMNAs0xQfR+GAabLvY+ENTjJw8AuAhZicFSjKV
X-Received: by 2002:a05:600c:45cc:b0:483:6f37:1b33 with SMTP id
 5b1f17b1804b1-483a95f5892mr107569195e9.30.1771802582733; 
 Sun, 22 Feb 2026 15:23:02 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a8df83bcsm170863235e9.13.2026.02.22.15.23.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 22 Feb 2026 15:23:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 12/21] system/globals: Build as common code
Date: Mon, 23 Feb 2026 00:22:22 +0100
Message-ID: <20260222232222.7183-7-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260222232222.7183-1-philmd@linaro.org>
References: <20260222232222.7183-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Now that all targets have the graphic dimension variables
initialized the same way, we can move them to the common
file unit, having them built once. Remove the now empty
globals-target.c file. The command line '-g WxH[xD]' option
is not changed and behaves the same.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260216213121.47122-9-philmd@linaro.org>
---
 system/globals-target.c | 14 --------------
 system/globals.c        |  3 +++
 system/meson.build      |  1 -
 3 files changed, 3 insertions(+), 15 deletions(-)
 delete mode 100644 system/globals-target.c

diff --git a/system/globals-target.c b/system/globals-target.c
deleted file mode 100644
index ffa6c308b59..00000000000
--- a/system/globals-target.c
+++ /dev/null
@@ -1,14 +0,0 @@
-/*
- * Global variables that should not exist (target specific)
- *
- * Copyright (c) 2003-2008 Fabrice Bellard
- *
- * SPDX-License-Identifier: MIT
- */
-
-#include "qemu/osdep.h"
-#include "system/system.h"
-
-int graphic_width;
-int graphic_height;
-int graphic_depth;
diff --git a/system/globals.c b/system/globals.c
index c33f6ed3902..34fd3ce9c72 100644
--- a/system/globals.c
+++ b/system/globals.c
@@ -49,6 +49,9 @@ bool enable_cpu_pm;
 int autostart = 1;
 int vga_interface_type = VGA_NONE;
 bool vga_interface_created;
+int graphic_width;
+int graphic_height;
+int graphic_depth;
 Chardev *parallel_hds[MAX_PARALLEL_PORTS];
 QEMUOptionRom option_rom[MAX_OPTION_ROMS];
 int nb_option_roms;
diff --git a/system/meson.build b/system/meson.build
index 4b69ef0f5fb..035f0ae7de4 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -1,6 +1,5 @@
 specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: [files(
   'arch_init.c',
-  'globals-target.c',
 )])
 
 system_ss.add(files(
-- 
2.52.0


