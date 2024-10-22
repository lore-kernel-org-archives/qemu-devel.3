Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 234D9D1CDCF
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 10:11:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Bqn-00056h-7O; Tue, 22 Oct 2024 06:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3Bql-00056J-5I
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:10:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3Bqj-0004Q1-3B
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:10:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729591848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sqZKZs4ctIO+XwCEz08VcQx7mTvLUzVoJpL0KkC+cT8=;
 b=DnATGNaNzIHWQoPmOJDYoxzCj3ryKKaY1e5rwywUaDhkfpJ9Tf/StwGBpdnrCLFf51Orf8
 oiyYEj0TR+KNX+Nrz2e8FK7XghfsS6CiT2MG9PrOGBp8OiuNcwUxAiseB1Ta6RLIBZwYDi
 +Xgsh5FubltZjjP/SNn2gY18ZHWAw1o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-sZ24dXJhPJqJpGn-HtrDRQ-1; Tue, 22 Oct 2024 06:10:46 -0400
X-MC-Unique: sZ24dXJhPJqJpGn-HtrDRQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4314c6ca114so43647315e9.1
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 03:10:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729591844; x=1730196644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sqZKZs4ctIO+XwCEz08VcQx7mTvLUzVoJpL0KkC+cT8=;
 b=Qwvb+Qay0Z2neZtEYrsF3U6PLQP2L/TSBFWMKGLXDZX9smYCrHXEwCi6SjX/ChQ+4o
 POFYHO+jfbwgsxhGybsPNxgYTNKLIyYsD4QS2gNSl/mrGrfbxaVbdsLpfHp1Ivc9v/J1
 wPezmd91OK/SClqoxcw4HLpNRViU3KTM9ZgO4r36bsxBRgLHPRzGKdFRPLJ13/Mp0fji
 0QOfHHZtimfE+cjTPlZHYxzxVMvjhnqVg5rEFPMmKAFvqfWbUEy6nOfMXRa2gPrcbbVp
 BY4mPwM7cGdUcdBGCEDtTXj1f1CRi9DYBr9vWrtUh2CcRkl2qDxAd/SQxtlvDCZ5SB5p
 l5Pg==
X-Gm-Message-State: AOJu0YyqoF6BFydnOM7pgmI1XdcLGfB81j02Haz+txcz8S7Ak3VUeQHy
 MSXyEgNlWL/Re1fuceP3KVY4kdd0B5+r6N5QwRwb7oVK7mcqEJl61KXwpnMLiWJn/P3UZaZQN+E
 HBU4I9idvy1IiAc3e9l5YPHfMfcl6IfcsBZ8fQjYVthaT+8IFxdwQmzKl7pfWn0UqsZrLgEqJJK
 kS1whgfdLisz+QC0NZWrc5NgIM1Lk7aG4N/IhCoOs=
X-Received: by 2002:a05:600c:4687:b0:42c:b220:4778 with SMTP id
 5b1f17b1804b1-4317cb0acd5mr15758815e9.33.1729591843911; 
 Tue, 22 Oct 2024 03:10:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHQXFBOMtcFlMJKbKgMFyEMN/5s07ayLP0urv3U5os3KfbvukbP9P0rEK2yQX+0m9oNq4BEg==
X-Received: by 2002:a05:600c:4687:b0:42c:b220:4778 with SMTP id
 5b1f17b1804b1-4317cb0acd5mr15758585e9.33.1729591843395; 
 Tue, 22 Oct 2024 03:10:43 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316f5c314bsm83516045e9.32.2024.10.22.03.10.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 03:10:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, kwolf@redhat.com, junjie.mao@hotmail.com,
 manos.pitsidianakis@linaro.org
Subject: [PATCH v2 12/14] rust: allow older version of bindgen
Date: Tue, 22 Oct 2024 12:09:53 +0200
Message-ID: <20241022100956.196657-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241022100956.196657-1-pbonzini@redhat.com>
References: <20241022100956.196657-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
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
 docs/about/build-platforms.rst |  8 ++++++++
 meson.build                    | 29 +++++++++++++++++++++++++----
 2 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/docs/about/build-platforms.rst b/docs/about/build-platforms.rst
index 8fd7da140a3..8173830c17a 100644
--- a/docs/about/build-platforms.rst
+++ b/docs/about/build-platforms.rst
@@ -107,6 +107,14 @@ Python build dependencies
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
 Optional build dependencies
   Build components whose absence does not affect the ability to build
   QEMU may not be available in distros, or may be too old for QEMU's
diff --git a/meson.build b/meson.build
index a083e3434b3..d78afb79d67 100644
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
2.46.2


