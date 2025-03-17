Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A001C35FF3
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 07:58:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tu5Lw-0006eH-2F; Mon, 17 Mar 2025 03:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tu5Ls-0006dk-M3
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 03:57:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tu5Lq-00016i-Nr
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 03:57:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742198252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=3s44sFY1Efk+8lNozx0h8JnazJ/0KVlKeenAWByG/QQ=;
 b=csCsr+60JMc+EdsdhHjD2LJVARLn4kaWjhCi0S9qliJl4gLtdSEQ3gIHNseKohqYCvnesK
 IMz5Zbc/KCd7+qwtM2O+UKhK3w0572zbWkAeqaEtlpqvCpyswtR3umjTRj9pv/U/EvmN31
 PbIfSt8xwrf1maFesNvM4XL25sCcDuk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-mA8tvHANMHSLXUnE4pkzDg-1; Mon, 17 Mar 2025 03:57:30 -0400
X-MC-Unique: mA8tvHANMHSLXUnE4pkzDg-1
X-Mimecast-MFC-AGG-ID: mA8tvHANMHSLXUnE4pkzDg_1742198249
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43d007b2c79so13917185e9.2
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 00:57:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742198248; x=1742803048;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3s44sFY1Efk+8lNozx0h8JnazJ/0KVlKeenAWByG/QQ=;
 b=TnxmzYewwC4+S28qgohtHYSr4Ey2vWK3AJfskq2OLb64EuU9cUE258yY2Ndlug4Mdl
 i5k2Qt7Q39njXSXR8Zj5bs9TLdmZN3x67VbHQo9SJF8Sf+vpfJa2YWqCPsO8mf0UezJg
 oBtcBBfhRZRkfatmCuPR7ix8bbRfs0+MnbNHA6vWjFAlegXAwqg4HWQ63BjXb0ieb/Mc
 iJsUN5rHYLm1KMwGtkPthOafo/gJuvhbYknHteAxNLHc2lE+0zzB4LlpS628LBqeAayf
 D8pS3eajLn9/+zRb3VvTEm6BrbvZpBLs8dm+cosEWk4Guac/Qdjjh1dhswu5XMSrJufQ
 RY0g==
X-Gm-Message-State: AOJu0YyP2pmGbZoFKF6xB7JlE8e+MhZVT5JhD2hPilKmUrJvtqk1KTIp
 sgwfZfStMAuC8Oc467L5wz/ScGxFbIa8mz2Gf6UNtNxbycoypYry6k+brhLm5RrJhycaSZK1PmV
 k/BmeM9GaTCACgXbd417ErYK8+S5/W9eQjEOt6ic7iFqmixX+Y5cFDZUAQ+7wVBwRJIvthYx8TH
 tbcYitSXHNUFKh4/nETSdXgbMrwWp9E+TgHYMx
X-Gm-Gg: ASbGncvkq4cskSnjqj1jZU86sPjc7G6eA+Xbj1QfKj5dKcLNxGlj25T1JwNZbREMj/Q
 FiMG9j8GrES8f4I9Drr4OAZ/j7IwVeji6JpQbeX4BFyQvYCxZKfqa6cDYD9ovDut7Xrd3eZpQsj
 UWkNSqDTm3hHA/LARFbkYXrtG6QJ2oexXVIxEaPuZLAItmISdsxMt9W7xfRkDfbmzYMxqgFoUhG
 VvlreWaJETIPjnjPipUu6HHyVKRE4P0IN/KdJnfh5VGp2O7oirJ1qCYSvYWks4SAtvO7GkiwRFy
 IDqaNPMakLVj2z/sdVt3
X-Received: by 2002:a05:6000:178f:b0:391:4c0c:c807 with SMTP id
 ffacd0b85a97d-3971f607ba3mr11959906f8f.53.1742198248434; 
 Mon, 17 Mar 2025 00:57:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEk733wTWjKjUzE2s+LLW2FnDf+GIXOLSf+bTIPz9FkEBVpPOyS+vlO1pikCYPESVIJqLVghw==
X-Received: by 2002:a05:6000:178f:b0:391:4c0c:c807 with SMTP id
 ffacd0b85a97d-3971f607ba3mr11959885f8f.53.1742198248027; 
 Mon, 17 Mar 2025 00:57:28 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.194.153])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe05ff4sm96769055e9.10.2025.03.17.00.57.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 00:57:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	Konstantin Kostiuk <kkostiuk@redhat.com>
Subject: [PATCH] Revert "meson.build: default to -gsplit-dwarf for debug info"
Date: Mon, 17 Mar 2025 08:57:26 +0100
Message-ID: <20250317075726.134657-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.333,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This reverts commit 563b1a35ed1f1151505d4fe5f723827d1b3fd4bc.

Split debug info support is broken when cross compiling
(https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99973).  People
that would like to use it can add it via --extra-cflags.

Reported-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                   | 6 ------
 meson_options.txt             | 2 --
 scripts/meson-buildoptions.sh | 2 --
 3 files changed, 10 deletions(-)

diff --git a/meson.build b/meson.build
index 7f75256acf9..41f68d38069 100644
--- a/meson.build
+++ b/meson.build
@@ -604,10 +604,6 @@ if get_option('tsan')
   qemu_ldflags = ['-fsanitize=thread'] + qemu_ldflags
 endif
 
-if get_option('debug') and get_option('split_debug')
-  qemu_cflags += '-gsplit-dwarf'
-endif
-
 # Detect support for PT_GNU_RELRO + DT_BIND_NOW.
 # The combination is known as "full relro", because .got.plt is read-only too.
 qemu_ldflags += cc.get_supported_link_arguments('-Wl,-z,relro', '-Wl,-z,now')
@@ -4599,8 +4595,6 @@ if have_rust
   summary_info += {'bindgen':         bindgen.full_path()}
   summary_info += {'bindgen version': bindgen.version()}
 endif
-# option_cflags is purely for the summary display, meson will pass
-# -g/-O options directly
 option_cflags = (get_option('debug') ? ['-g'] : [])
 if get_option('optimization') != 'plain'
   option_cflags += ['-O' + get_option('optimization')]
diff --git a/meson_options.txt b/meson_options.txt
index 3432123fee2..59d973bca00 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -362,8 +362,6 @@ option('debug_mutex', type: 'boolean', value: false,
        description: 'mutex debugging support')
 option('debug_stack_usage', type: 'boolean', value: false,
        description: 'measure coroutine stack usage')
-option('split_debug', type: 'boolean', value: true,
-       description: 'split debug info from object files')
 option('qom_cast_debug', type: 'boolean', value: true,
        description: 'cast debugging support')
 option('slirp_smbd', type : 'feature', value : 'auto',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index aca6e688302..3e8e00852b2 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -504,8 +504,6 @@ _meson_option_parse() {
     --disable-strict-rust-lints) printf "%s" -Dstrict_rust_lints=false ;;
     --enable-strip) printf "%s" -Dstrip=true ;;
     --disable-strip) printf "%s" -Dstrip=false ;;
-    --enable-split-debug) printf "%s" -Dsplit_debug=true ;;
-    --disable-split-debug) printf "%s" -Dsplit_debug=false ;;
     --sysconfdir=*) quote_sh "-Dsysconfdir=$2" ;;
     --enable-tcg) printf "%s" -Dtcg=enabled ;;
     --disable-tcg) printf "%s" -Dtcg=disabled ;;
-- 
2.48.1


