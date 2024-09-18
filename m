Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE4CCDD552
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 19:27:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr0Go-0004pY-8P; Wed, 18 Sep 2024 15:23:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3lyjrZgUKCtIHyJ6D4CC492.0CAE2AI-12J29BCB4BI.CF4@flex--tavip.bounces.google.com>)
 id 1sr0Ga-0004Um-JQ
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 15:23:10 -0400
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3lyjrZgUKCtIHyJ6D4CC492.0CAE2AI-12J29BCB4BI.CF4@flex--tavip.bounces.google.com>)
 id 1sr0GX-0007J6-Te
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 15:23:08 -0400
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-e02fff66a83so204340276.0
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 12:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1726687384; x=1727292184; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=qKA21Q/Mut9jISnah7mMJgm1CeAx6m6ER6bFWDsO26E=;
 b=rbGUao4W7W1o0kK76cEmUbbSF/Gm1mlPWmN4jpdH6sy72xNbd7lerqfvXuLIe4GhjY
 YNJCcH0lz1Duk90L3bfmE0mP9i5KJgVXmPKhrz75z/Pp1ZMA5aqHe8RQ54MWYdXiXuVn
 F9aHln6lpQnRg2YIsCdSjYasb2eYLyKu1qeIWgrleqLeYrME8psRiAnqibgiQphMSy5r
 0cpf05CU309kiznzGshYCPZF58z+OilUmr4ytDr+mtGL24ZaGmV8nTXmg4/Q9D5ChTU3
 +L3Qz5PsF64DI+ANjQgdAvfrJ41sr8JyGwxti06G5h3klhbnu4SJe8TQxeFX6OgAQnXX
 nZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726687384; x=1727292184;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qKA21Q/Mut9jISnah7mMJgm1CeAx6m6ER6bFWDsO26E=;
 b=K6EBHQnz5VE5cWDAvVv22ofBzYV0uGjdBDUXsNJ0iqUqDKE5UC8WkwFkOXDaccd94X
 TbpMB/PnomkAVFr9t4r6dQZxfuGEEQvpT50K2YI/83F5NHr6L9i/yioF/HKro7eNyt0V
 xHZjgkfkA03HsV3aNpJ+MhRHS4ZWfhZ8aE6Q5IelVt53GJjPskq4HPkrM18wwCTWB2Fk
 tJ6x+UDXRC5apE6syVsD9Q8KK0GdPILhTpUpmV23OqQDd/XUHYAwdgJCMf4iR4Rtj2Uk
 PPLeZ2l/9fqPibbFU/kbPu7yCdcdurJ6iv8jKpKF7260TJ578VmLjQl0O2XBVlvR/37n
 GEFg==
X-Gm-Message-State: AOJu0YyVYeiOqZdbAZeGuaprOQ+nztnCfeao62Kj1df3ctmrTyzbxKz4
 f0XRbXlfisOZyxxl5hJkF18QDoJ/RNjXSMg97T2dtcEADCDoTlR+FsFmrumkEWqUi2s1Mr9eAmA
 f3aWwp80zMxpxCX+zjD4b2no2nfH+lSBdj3iJtWi6ckFI9ZA07KqUV6DTTDJjWKrUkxsEZ/IAfN
 Id5FgAnWnwgPjGPe+UGTgmCZFy7Q==
X-Google-Smtp-Source: AGHT+IH4L2pe+i7jN1Pe/8DYC19Lp5kYQPEyWguMz4cZ7G+J2cnNsQtuNwZG9l0EnopINhsfp9AwIostGA==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a5b:704:0:b0:e0e:4350:d7de with
 SMTP id
 3f1490d57ef6-e1d9dc3da43mr29038276.9.1726687383260; Wed, 18 Sep 2024 12:23:03
 -0700 (PDT)
Date: Wed, 18 Sep 2024 12:22:32 -0700
In-Reply-To: <20240918192254.3136903-1-tavip@google.com>
Mime-Version: 1.0
References: <20240918192254.3136903-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Message-ID: <20240918192254.3136903-5-tavip@google.com>
Subject: [PATCH 04/25] Add mcux-soc-svd subproject
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 peter.maydell@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, luc@lmichel.fr, damien.hedde@dahe.fr, 
 alistair@alistair23.me, thuth@redhat.com, philmd@linaro.org, jsnow@redhat.com, 
 crosa@redhat.com, lvivier@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3lyjrZgUKCtIHyJ6D4CC492.0CAE2AI-12J29BCB4BI.CF4@flex--tavip.bounces.google.com;
 helo=mail-yb1-xb49.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
index 783b56bcb9..fb64db2d2a 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -375,3 +375,6 @@ option('hexagon_idef_parser', type : 'boolean', value : true,
 
 option('x86_version', type : 'combo', choices : ['0', '1', '2', '3', '4'], value: '1',
        description: 'tweak required x86_64 architecture version beyond compiler default')
+
+option('mcux-soc-svd', type : 'boolean', value : false,
+       description: 'enable targets to generate C headers from mcux-soc-svd')
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 107a8f69ce..0864952d80 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -41,6 +41,8 @@ meson_options_help() {
   printf "%s\n" '  --enable-lto             Use link time optimization'
   printf "%s\n" '  --enable-malloc=CHOICE   choose memory allocator to use [system] (choices:'
   printf "%s\n" '                           jemalloc/system/tcmalloc)'
+  printf "%s\n" '  --enable-mcux-soc-svd    enable targets to generate C headers from mcux-'
+  printf "%s\n" '                           soc-svd'
   printf "%s\n" '  --enable-module-upgrades try to load modules from alternate paths for'
   printf "%s\n" '                           upgrades'
   printf "%s\n" '  --enable-rng-none        dummy RNG, avoid using /dev/(u)random and'
@@ -395,6 +397,8 @@ _meson_option_parse() {
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
2.46.0.662.g92d0881bb0-goog


