Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2DEDE83837
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 21:32:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs6Cv-0002gv-NW; Mon, 16 Feb 2026 16:32:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vs6Cg-0001D3-7u
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 16:32:31 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vs6Ce-00045M-LN
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 16:32:25 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48068127f00so38220145e9.3
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 13:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771277542; x=1771882342; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KmeaTgRcbtYXQZQ0cj05tFFPuUc/ARqWElo1Z0I+CbU=;
 b=NwwyBEwA0pJ8wtCJs45UKzlXPLuFQt33YFPsgu+wcv5wdtcJ5TKyJ2ASzZ3W5UiOWR
 +KzyyS0ozP8m8MsmaDucGQWR2aRQ8i6GrOjggQRE/fPVR45KYXs4n6xx0JcAgRR84dPx
 23lQ7SdI4LgwxaonXx9/9CfckJWdOu07xIXVbjslnBZwHRlzsDo92XVryGQkxVntdBkI
 9nwNjvmSyB3A5+CmuzwMATy/lpGukccHUoHtKAp0/7ZFpcCjS++cWDa0w7AwKWS/bWSi
 tnet6BtUxkyCArBem3ckJG+EvF7zA39NgKmH2+ea+Ho6nUzninw0989J/3VNP3LvNXoW
 pnDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771277542; x=1771882342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KmeaTgRcbtYXQZQ0cj05tFFPuUc/ARqWElo1Z0I+CbU=;
 b=NRsb4xKh/rsUTgwBYm8uunUV+dtdYkVdwXczr2AA3hT7hKJS6zRAqov1sNvDuKN0XV
 56rNA0EYwGsKTd8Nn+6wbDnqHyetm53FpvD26KJ5aFWT1jZJOjfZWbOmpoqSMI3JpJYZ
 ZzrJRhIJ9QGuxheJeXV4vfKrSna+kxA4pn5W69i9vwM5cxeOs/k/ZNXcBTN02G/2xwM2
 ZPMKGZJB++0ddZU/cWJ0L47/RkKbeDzTUjVQA+LSKAI0DMaTHHjQGRJ4Bgxb9kXcDkpY
 EPWUimpMjnZkkMShL0iVmF8cEwOpcCD4lHsF9BhIRBb8GKCilA0TktdPn7yluLbujZc0
 kPRQ==
X-Gm-Message-State: AOJu0YzE8BROovw/gsAkN0tPHmi7So1QNIsuj3AAtD6jkgcwfex2LTlu
 WfABFBcds2N9JfjhiMqAJ3WuAP1plKYlE4/6UGkp3/sUGHGeLOQyKZTpOhLWdKNEQp07vqFOJQ9
 eKLECzJc=
X-Gm-Gg: AZuq6aKapK0EAGl17Dc5SC037xQNnG6dnyKwxMjWdkatIMaeagPId2aW5F7ej3/mkkT
 JlBIjHcifEsxklklXltwnNYFACslxN24Odv2VkoVZbkplQDSsm6X3JY1CJkhEvAxm2yPq9C4ONr
 /OoXFpD/DrIX3fwrmG5RM2IPNDH1dS7Fd3BLLt79yovUpeXvKtPHePjhA4/hwYvXc7JaHvEy5Uf
 j9g0YlOnRs/lrLAGdmU48oTsRoThRxDF69/U3eRdYNDy75/jpM58yW8ccyacbFn/SRLwjaxgxnn
 GpPM0/Rz6+zdC/6d0a6cMysdgDP9iTSzK0fdqkaDSMjhgiTqXe5+NXb8xrsK4TPLJtL6Ujdx5Uu
 y3hRAF23jTRcDv47l2CK3g2gE3wikOXktBfoCJ/t4ynK+Hf+g2KS1DPzmOk54O/ozNsQq8OuvRE
 EYgv593VtYKl3bdNcy/IDI2vTN2m8vOGJLNrCfa+DycS9CTOWiltfmeQZYaWBiaTv+RAsS+/Gm
X-Received: by 2002:a05:600c:1d89:b0:477:5b0a:e616 with SMTP id
 5b1f17b1804b1-48373a085c8mr213514305e9.5.1771277542204; 
 Mon, 16 Feb 2026 13:32:22 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835dd0e327sm457917305e9.14.2026.02.16.13.32.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 16 Feb 2026 13:32:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 8/8] system/globals: Build as common code
Date: Mon, 16 Feb 2026 22:31:21 +0100
Message-ID: <20260216213121.47122-9-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260216213121.47122-1-philmd@linaro.org>
References: <20260216213121.47122-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Now that  all targets have the graphic dimension variables
initialized the same way, we can move them to the common
file unit, having them built once. Remove the now empty
globals-target.c file. The command line '-g WxH[xD]' option
is not changed and behaves the same.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 system/globals-target.c | 14 --------------
 system/globals.c        |  3 +++
 system/meson.build      |  4 ----
 3 files changed, 3 insertions(+), 18 deletions(-)
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
index d91703d3dcc..579e8353d53 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -1,7 +1,3 @@
-specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: [files(
-  'globals-target.c',
-)])
-
 system_ss.add(files(
   'vl.c',
 ), sdl, libpmem, libdaxctl)
-- 
2.52.0


