Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA229CD3436
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 02:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKoPV-00063V-8E; Wed, 06 May 2026 22:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoPT-000636-Q2
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:24:19 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoPR-0007aX-Vr
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:24:19 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7dbec19732eso267096a34.3
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 19:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778120656; x=1778725456;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JqvWmLbjmlBIF1ObHpc6uVNCAxesbDWMi6ixpyg9t3o=;
 b=GrvkQLG32Bq4GO7tUMdlbyC49hyGQoBEs/bV1v3nVhxavZTynVxqEgrseeW9tpjXSt
 9sc31FAb/le///Z1jW8DffeCvQgW7lxVI+39UgnAG77d4SHevp+TaU74ci5E41oBaGYD
 HzJnLEwAlhbrAOyYSCChsihCEhOE1xHRGUNwupOEkB15Str8a8iTMdevoEc+jzTH/vHz
 qEL7/492C0nO/Q3jLptzPAdPY7rwuaEhdGIKq1ez449BRAaosyOzSN9rCsLRdmAVHXy6
 o4w1PZnEsgHcGtRwvfSvYfWI14WL+s4L9bfBY4aRzoE4Sxk/GAQDaUZ4mR1OH+iofMSN
 fW7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778120656; x=1778725456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JqvWmLbjmlBIF1ObHpc6uVNCAxesbDWMi6ixpyg9t3o=;
 b=M1iteGee77ZCBFm5nAFu4pjSLnbGZpnO/2J0R8pYoWFXVti4Pxt5DR/fiwMm1/3zzY
 FaDRHYopzVR44/3rLsC3nlwk0dlvMS8RF2lOumyqhghMIB3K6HzlC6h8odGCpet0tC15
 kkuXhdsFLC3mM9VVfJPnwuRNVAMl8weE0dEMXCWn6Cpy3YA034PIqWt8U0Y8on0FAgvv
 OMJqBRNwQiyJpTiHVakglqyzrXfMymnvUseKhc5r0UddF9fsyAxZD6os12ltJCpnvKP2
 3NTp5AYqnfi++eJAItwzn7nUslOlfZZmoCIlKaQ4+kxDKbRcrUH9OiVtEOVPgoVfOmRr
 zjQA==
X-Gm-Message-State: AOJu0YxaS7zpeiJBzITHnoOuvvodpVlO99GwXPWXO7CxaLIYjOwb2VI4
 zu6PEA6INMZwwLcQ4++fVaCpxLTAso42nNvAam3bDadpUyNZxRBiLJSG9cuK0ZcdNn/vhf02mpy
 tJYO5lMQ=
X-Gm-Gg: AeBDievlAny3B12RTWs85pVG6QXCrFD6fDH0oK3Xlk2POqQpD75LJM12FXSsXUVKKpe
 Ek1vOYn3ewP1B7P1Bc4RwjDoKk592eD/r+4zTNuHPinn4PdQXIVXrSjLmsyk3lc3HfKeZzrh8GN
 bb0BrruGWLjPZnlkOFGE4/eZwf69sfgBdhSoK2TDbeEbV2YHRCT1QGocp2y4nqmwCEANY5H24iy
 GOMWTx4KLXU641gXhgJuohKShI/zrhro4CpeoMVRTTnokyyLGsa8U5MDz4jdHQCxaPMukpfduEn
 3GXMRjI39R0DNkG+y7RNsX41efFcQCMhi5PZn+GwHDXfx9C/FNcDE5tp/w5W8ji7zxy/5RQEfq/
 Ko5bvUDVUWKrJEDY8pXf2bVXaHnxv5wJ8cAdhjOmjLkRd0vEil+0n5f3FGao8/cxjOQJVClOJVH
 kWg3va/Ry+X06oEeROKA3s
X-Received: by 2002:a05:6820:c8c:b0:694:9d3d:e040 with SMTP id
 006d021491bc7-69998d0daafmr3414028eaf.31.1778120656431; 
 Wed, 06 May 2026 19:24:16 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-696896e72c4sm11088118eaf.9.2026.05.06.19.24.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 19:24:15 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 02/25] bsd-user: Add syscall header generator for FreeBSD
Date: Wed,  6 May 2026 20:21:56 -0600
Message-ID: <20260507022219.44171-3-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260507022219.44171-1-imp@bsdimp.com>
References: <20260507022219.44171-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::329;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x329.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Generate the syscall numbers from the installed header that has them.
Ideally, we'd use FreeBSD's lua infra for this, but that requires that
we have those files installed, and they aren't quite the same across
supported versions yet, so use this simple, but effective hack. Add to
meson build, but unused.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/meson.build           | 10 ++++++++--
 bsd-user/freebsd/scripts/syscallhdr.sh |  9 +++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)
 create mode 100644 bsd-user/freebsd/scripts/syscallhdr.sh

diff --git a/bsd-user/freebsd/meson.build b/bsd-user/freebsd/meson.build
index 8fd6c7cfb8..38f2debf7e 100644
--- a/bsd-user/freebsd/meson.build
+++ b/bsd-user/freebsd/meson.build
@@ -1,6 +1,12 @@
+bsd_syscall_nr = custom_target('bsd-syscall-h',
+    output: '@BASENAME@_nr.h',
+    input: ['/usr/include/sys/syscall.h'],
+    command: [sh, meson.current_source_dir() / 'scripts/syscallhdr.sh', '@INPUT@', '@OUTPUT@', 'FREEBSD'])
+
 bsd_user_ss.add(files(
   'os-stat.c',
   'os-proc.c',
   'os-sys.c',
-  'os-syscall.c',
-))
+  'os-syscall.c'),
+  bsd_syscall_nr
+)
diff --git a/bsd-user/freebsd/scripts/syscallhdr.sh b/bsd-user/freebsd/scripts/syscallhdr.sh
new file mode 100644
index 0000000000..fa38500775
--- /dev/null
+++ b/bsd-user/freebsd/scripts/syscallhdr.sh
@@ -0,0 +1,9 @@
+#!/bin/sh
+# Copyright (c) 2026 Warner Losh <imp@bsdimp.com>
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+in="$1"
+out="$2"
+bsd="$3"
+
+awk -v bsd="$3" '{sub("SYS_", "TARGET_" bsd "_NR_", $0); print;}' < $in > $out
-- 
2.52.0


