Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A32C52D7D
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2024 10:29:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfGeB-0007Ni-VD; Sat, 17 Aug 2024 06:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3x3rAZgUKCvovcxkriqqing.eqosgow-fgxgnpqpipw.qti@flex--tavip.bounces.google.com>)
 id 1sfGdk-0006IV-2r
 for qemu-devel@nongnu.org; Sat, 17 Aug 2024 06:26:37 -0400
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3x3rAZgUKCvovcxkriqqing.eqosgow-fgxgnpqpipw.qti@flex--tavip.bounces.google.com>)
 id 1sfGdf-0003FI-Bz
 for qemu-devel@nongnu.org; Sat, 17 Aug 2024 06:26:31 -0400
Received: by mail-pg1-x549.google.com with SMTP id
 41be03b00d2f7-5e4df21f22dso2254001a12.0
 for <qemu-devel@nongnu.org>; Sat, 17 Aug 2024 03:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1723890377; x=1724495177; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=FVNYijpYFtbfaDyQGxsk5OhIQ8sQjh7sQW2Q7Qw6WEo=;
 b=gZHD/EwxQNautVvBImGMTPeDLU1v2UfY2rX0PhBDx1DYg0IUtQzUB19R9RmtbkhfQZ
 WFHDP2IJgqXk4pTQrG4pS+77yprLg0Up3nfAeSIbtZUALcFWJKx0/QtTvW/hPMlsKCQu
 48f/HIiYlqDwDdLozrBOKtZMu3qrZiCZqW0pDMXcjkWFVaQFwYKPk1W0XyxiyUU1mIW3
 M5yugEWOV1qTfoEGwEMCuVM0AzvvSGqCFLB3UE5gW5CfSvQqJK9Ncdg5/kBZgp2i8JDI
 b4rBLQacje5miy72cc2vQvlwc8uqSpYIzD1XA44Gf4MoK7/RZbWESc/s0lWBFhPbDqu2
 CM5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723890377; x=1724495177;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FVNYijpYFtbfaDyQGxsk5OhIQ8sQjh7sQW2Q7Qw6WEo=;
 b=NXjcO9sjgrEl556H0iLkpxjsEdObueHDEsu89ua/7cGjFIM0UCTJE6jT4uo/L2CwZF
 so5GY0kFoshQ9AIL4o1dt5cSB+Iqcv1mncoDYn1yTp6tdtXZ5sMHyLAOqGSn43YFYKYh
 hH7d+XsSKVotE8hZWlJFamsyCRcR24a4pdOU7zTIUe0x0WDyUeTQCR6eKyUJ+X8T7oLQ
 2mVGaFlnnce87n2gXD+aFYhdqfNrYSKvy1xTUR8QMGOcmeKP4f6GOfOGTd09Rjw9M2Ds
 6O5JB5SxSA0MIWIMhzzUUUaNKBGCA5y7ZvEe0NkEr7gBvJ7EprwwxjgasE96YOn4KERL
 b9ww==
X-Gm-Message-State: AOJu0YxcKetieGtpaVhurjQtWUTp6hbnu1qkAKpys429F5ht6y0L8nET
 WNPHa2fE5OLxQ7czOnGgTXUNI7WZm8443PfYG5aUtu4v4O3iOn8zPAgxIOZWZSbTWJiVbOKCjb8
 LBwxleP3kvGkqs47yaTht3p7bRxkmltPy+ZM6Byki/YNGgTG+8GfdU+6n52fJD1HhWPH+kFjrYU
 1SUVpHr1il6U8hWgt9hbvz7BY2dA==
X-Google-Smtp-Source: AGHT+IFuMo4GRP8A1pErMqDsDMGK0GSXNVR4IZPiVh6XRSK1ciwW7Ikz1en5Ytn2Jail2Gz0UZghsKhphA==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a05:6a02:590:b0:718:84ed:abe7
 with SMTP id
 41be03b00d2f7-7ca488fb5e5mr7695a12.4.1723890375445; Sat, 17 Aug 2024 03:26:15
 -0700 (PDT)
Date: Sat, 17 Aug 2024 03:25:47 -0700
In-Reply-To: <20240817102606.3996242-1-tavip@google.com>
Mime-Version: 1.0
References: <20240817102606.3996242-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240817102606.3996242-5-tavip@google.com>
Subject: [RFC PATCH v2 04/23] Add mcux-soc-svd subproject
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 thuth@redhat.com, peter.maydell@linaro.org, marcandre.lureau@redhat.com, 
 alistair@alistair23.me, berrange@redhat.com, philmd@linaro.org, 
 jsnow@redhat.com, crosa@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::549;
 envelope-from=3x3rAZgUKCvovcxkriqqing.eqosgow-fgxgnpqpipw.qti@flex--tavip.bounces.google.com;
 helo=mail-pg1-x549.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

Add mcux-soc-svd subproject that contains SVD files that are going to
be used to generate C header with register layout definitions and
other helpers to create device models.

Guard the subproject by a configuration option since it is rarely
going to be used - whenever new headers will be generated. It is
unlikely that already generated headers will be updated, with the
exception of minor hardware revisions.

Also export the rt595 SVD file which is going to be used by subsequent
patches.

TBD: switch to a qemu gitlab fork before merge

Signed-off-by: Octavian Purdila <tavip@google.com>
---
 hw/arm/svd/meson.build                            | 4 ++++
 meson_options.txt                                 | 3 +++
 scripts/meson-buildoptions.sh                     | 4 ++++
 subprojects/.gitignore                            | 1 +
 subprojects/mcux-soc-svd.wrap                     | 5 +++++
 subprojects/packagefiles/mcux-soc-svd/meson.build | 5 +++++
 6 files changed, 22 insertions(+)
 create mode 100644 hw/arm/svd/meson.build
 create mode 100644 subprojects/mcux-soc-svd.wrap
 create mode 100644 subprojects/packagefiles/mcux-soc-svd/meson.build

diff --git a/hw/arm/svd/meson.build b/hw/arm/svd/meson.build
new file mode 100644
index 0000000000..7d83d2ccbc
--- /dev/null
+++ b/hw/arm/svd/meson.build
@@ -0,0 +1,4 @@
+if get_option('mcux-soc-svd')
+  mcux_soc_svd = subproject('mcux-soc-svd')
+  rt595 = mcux_soc_svd.get_variable('rt595')
+endif
diff --git a/meson_options.txt b/meson_options.txt
index 4c1583eb40..25f827078a 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -366,3 +366,6 @@ option('qemu_ga_version', type: 'string', value: '',
 
 option('hexagon_idef_parser', type : 'boolean', value : true,
        description: 'use idef-parser to automatically generate TCG code for the Hexagon frontend')
+
+option('mcux-soc-svd', type : 'boolean', value : false,
+       description: 'enable targets to generate C headers from mcux-soc-svd')
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 6ce5a8b72a..2c1e501806 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -40,6 +40,8 @@ meson_options_help() {
   printf "%s\n" '  --enable-lto             Use link time optimization'
   printf "%s\n" '  --enable-malloc=CHOICE   choose memory allocator to use [system] (choices:'
   printf "%s\n" '                           jemalloc/system/tcmalloc)'
+  printf "%s\n" '  --enable-mcux-soc-svd    enable targets to generate C headers from mcux-'
+  printf "%s\n" '                           soc-svd'
   printf "%s\n" '  --enable-module-upgrades try to load modules from alternate paths for'
   printf "%s\n" '                           upgrades'
   printf "%s\n" '  --enable-rng-none        dummy RNG, avoid using /dev/(u)random and'
@@ -390,6 +392,8 @@ _meson_option_parse() {
     --enable-malloc-trim) printf "%s" -Dmalloc_trim=enabled ;;
     --disable-malloc-trim) printf "%s" -Dmalloc_trim=disabled ;;
     --mandir=*) quote_sh "-Dmandir=$2" ;;
+    --enable-mcux-soc-svd) printf "%s" -Dmcux-soc-svd=true ;;
+    --disable-mcux-soc-svd) printf "%s" -Dmcux-soc-svd=false ;;
     --enable-membarrier) printf "%s" -Dmembarrier=enabled ;;
     --disable-membarrier) printf "%s" -Dmembarrier=disabled ;;
     --enable-module-upgrades) printf "%s" -Dmodule_upgrades=true ;;
diff --git a/subprojects/.gitignore b/subprojects/.gitignore
index adca0266be..bca8693ef4 100644
--- a/subprojects/.gitignore
+++ b/subprojects/.gitignore
@@ -6,3 +6,4 @@
 /keycodemapdb
 /libvfio-user
 /slirp
+/mcux-soc-svd
diff --git a/subprojects/mcux-soc-svd.wrap b/subprojects/mcux-soc-svd.wrap
new file mode 100644
index 0000000000..80d18e8561
--- /dev/null
+++ b/subprojects/mcux-soc-svd.wrap
@@ -0,0 +1,5 @@
+[wrap-git]
+url = https://github.com/nxp-mcuxpresso/mcux-soc-svd/
+revision = 7f6f9ef7420144fe14cd9bc4d8e0e3523232da04
+patch_directory = mcux-soc-svd
+depth = 1
diff --git a/subprojects/packagefiles/mcux-soc-svd/meson.build b/subprojects/packagefiles/mcux-soc-svd/meson.build
new file mode 100644
index 0000000000..37c537d040
--- /dev/null
+++ b/subprojects/packagefiles/mcux-soc-svd/meson.build
@@ -0,0 +1,5 @@
+project('mcux-soc-svd')
+
+fs = import('fs')
+
+rt595 = fs.copyfile('MIMXRT595S/MIMXRT595S_cm33.xml')
-- 
2.46.0.184.g6999bdac58-goog


