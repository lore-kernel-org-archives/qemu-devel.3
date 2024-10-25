Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B25D149C1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 16:07:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Moz-0005VZ-RP; Fri, 25 Oct 2024 12:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4Mo1-0004m7-Dl
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:04:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4Mnx-0004zI-Ii
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:04:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729872289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/EguPHGv0KZEAhhaXf9YkHmhUGaAAWJPIVBGnJxjKSo=;
 b=TwfHsQmAtDjT24z6sADfJlignqPRt5J5MS4qfLHP8F+/V0qltQNuuV4zbFIlxKxdBMwKT2
 7BirXEoEvV7tc8+X4Zd9ieulV28R8DUGqYV6spFQWwDBh9dVYxrkfeT/u08jvu18pjd+mr
 vhhEzLEfm32qBmp8egUnPvqJ/NQK2RQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-435eXTh2MO-wnfx90cnYUg-1; Fri, 25 Oct 2024 12:04:47 -0400
X-MC-Unique: 435eXTh2MO-wnfx90cnYUg-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5cbb0b2c6e8so684596a12.0
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 09:04:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729872284; x=1730477084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/EguPHGv0KZEAhhaXf9YkHmhUGaAAWJPIVBGnJxjKSo=;
 b=tKXJlamBh8JdetEQQ6jn79E519MSvfv/ZLIwBRpB6/svV8XK5s2ct5UrXqP6Jdec6E
 YfcLsKeCxWw5CYXXw6LBSUUyzs1hLZ1r+yyLDHW1QKSex9StfWwLKr4pj2gHwX4PtnVZ
 jWpPn+q2mlyKmBKTL63xPRPNp2Z/d5G7Ly8zh4m489bzOKi6vY+hTS8eOg/voc4mLdmn
 bM8NDvY6Q4QJnELDI3KVLn8i1m8GqsuGSItUnIlPFRoAeW13DVfiuUwvHrVoAm7qEi9d
 N+VBSxdQoAL8sle3ms9cm/nNTbuwar2doXLt+gZ4Pauzzl1+8rP0DbWBnIYdHtY1eker
 mb0Q==
X-Gm-Message-State: AOJu0YyfHPunv+IN11M2qs5ESF0rJ8xBZ4rG7qESHk+XI/rWvxgbFDP4
 qAlSO9tCkEbEv5yGkLuQ4mizc2CJ4fQ1Ei5Kw24TH8lS1cG2iCXN+ljPR0phX87dmOS0y3V57QY
 Rsybg/QtcBwLmAdWdtfBy95ckFFIcC7I9gyV5XbeFbg/6DJmYT+5MjxXueXpKmHsOQC0lLUpZlj
 ifVPniAsppeO5elcIB239v1FcWn9TgayOTKaPVuqE=
X-Received: by 2002:a05:6402:5cd:b0:5c9:3f2:15fb with SMTP id
 4fb4d7f45d1cf-5cb8af6bd46mr7487055a12.24.1729872284300; 
 Fri, 25 Oct 2024 09:04:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEePOJZE+dDS5HHVfR5s7/0uEOaVEoi7/ZkBunx1mnlqsYPoFgaqj3p2FLKX4M+xOA3GF+s+g==
X-Received: by 2002:a05:6402:5cd:b0:5c9:3f2:15fb with SMTP id
 4fb4d7f45d1cf-5cb8af6bd46mr7487024a12.24.1729872283776; 
 Fri, 25 Oct 2024 09:04:43 -0700 (PDT)
Received: from [192.168.10.47] ([151.81.112.43])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cbb62c3da7sm761499a12.55.2024.10.25.09.04.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 09:04:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, zhao1.liu@intel.com,
 junjie.mao@hotmail.com, berrange@redhat.com
Subject: [PATCH 20/23] rust: allow older version of bindgen
Date: Fri, 25 Oct 2024 18:02:05 +0200
Message-ID: <20241025160209.194307-21-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241025160209.194307-1-pbonzini@redhat.com>
References: <20241025160209.194307-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.454,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Cope with the old version that is provided in Debian 12.

--size_t-is-usize is needed on bindgen <0.61.0, and it was removed in
bindgen 0.65.0, so check for it in meson.build.

--merge-extern-blocks was added in 0.61.0.

--formatter rustfmt was added in 0.65.0 and is the default, so remove it.

Apart from Debian 12 and Ubuntu 22.04, all other supported distros have
version 0.66.x of bindgen or newer (or do not have bindgen at all).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/about/build-platforms.rst | 12 ++++++++++++
 meson.build                    | 29 +++++++++++++++++++++++++----
 2 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/docs/about/build-platforms.rst b/docs/about/build-platforms.rst
index 8fd7da140a3..ff56091078e 100644
--- a/docs/about/build-platforms.rst
+++ b/docs/about/build-platforms.rst
@@ -107,6 +107,18 @@ Python build dependencies
   required, it may be necessary to fetch python modules from the Python
   Package Index (PyPI) via ``pip``, in order to build QEMU.
=20
+Rust build dependencies
+  QEMU is generally conservative in adding new Rust dependencies, and all
+  of them are included in the distributed tarballs.  One exception is the
+  bindgen tool, which is too big to package and distribute.  The minimum
+  supported version of bindgen is 0.60.x.  For distributions that do not
+  include bindgen or have an older version, it is recommended to install
+  a newer version using ``cargo install bindgen-cli``.
+
+  Developers may want to use Cargo-based tools in the QEMU source tree;
+  this requires Cargo 1.74.0.  Note that Cargo is not required in order
+  to build QEMU.
+
 Optional build dependencies
   Build components whose absence does not affect the ability to build
   QEMU may not be available in distros, or may be too old for QEMU's
diff --git a/meson.build b/meson.build
index bfd04294850..fb0295b312c 100644
--- a/meson.build
+++ b/meson.build
@@ -100,6 +100,21 @@ if have_rust
   endif
 endif
=20
+bindgen =3D find_program('bindgen', required: get_option('rust').disable_a=
uto_if(not have_rust))
+if not bindgen.found() or bindgen.version().version_compare('<0.60.0')
+  if get_option('rust').enabled()
+    error('bindgen version ' + bindgen.version() + ' is unsupported. You c=
an install a new version with "cargo install bindgen-cli"')
+  else
+    if bindgen.found()
+      warning('bindgen version ' + bindgen.version() + ' is unsupported, d=
isabling Rust compilation.')
+    else
+      warning('bindgen not found, disabling Rust compilation.')
+    endif
+    message('To use Rust you can install a new version with "cargo install=
 bindgen-cli"')
+    have_rust =3D false
+  endif
+endif
+
 dtrace =3D not_found
 stap =3D not_found
 if 'dtrace' in get_option('trace_backends')
@@ -3943,15 +3958,13 @@ common_all =3D static_library('common',
 if have_rust
   # We would like to use --generate-cstr, but it is only available
   # starting with bindgen 0.66.0.  The oldest supported versions
-  # are in Ubuntu 22.04 (0.59.1) and Debian 12 (0.60.1).
+  # is 0.60.x (Debian 12 has 0.60.1) which introduces --allowlist-file.
   bindgen_args =3D [
     '--disable-header-comment',
     '--raw-line', '// @generated',
     '--ctypes-prefix', 'std::os::raw',
-    '--formatter', 'rustfmt',
     '--generate-block',
     '--impl-debug',
-    '--merge-extern-blocks',
     '--no-doc-comments',
     '--with-derive-default',
     '--no-layout-tests',
@@ -3960,6 +3973,12 @@ if have_rust
     '--allowlist-file', meson.project_source_root() + '/.*',
     '--allowlist-file', meson.project_build_root() + '/.*'
     ]
+  if bindgen.version().version_compare('<0.61.0')
+    # default in 0.61+
+    bindgen_args +=3D ['--size_t-is-usize']
+  else
+    bindgen_args +=3D ['--merge-extern-blocks']
+  endif
   c_enums =3D [
     'DeviceCategory',
     'GpioPolarity',
@@ -3995,7 +4014,7 @@ if have_rust
     dependencies: common_ss.all_dependencies(),
     output: 'bindings.rs',
     include_directories: include_directories('.', 'include'),
-    bindgen_version: ['>=3D0.69.4'],
+    bindgen_version: ['>=3D0.60.0'],
     args: bindgen_args,
     )
   subdir('rust')
@@ -4461,6 +4480,8 @@ if have_rust
   summary_info +=3D {'Rust target':     config_host['RUST_TARGET_TRIPLE']}
   summary_info +=3D {'rustc':           ' '.join(rustc.cmd_array())}
   summary_info +=3D {'rustc version':   rustc.version()}
+  summary_info +=3D {'bindgen':         bindgen.full_path()}
+  summary_info +=3D {'bindgen version': bindgen.version()}
 endif
 option_cflags =3D (get_option('debug') ? ['-g'] : [])
 if get_option('optimization') !=3D 'plain'
--=20
2.47.0


