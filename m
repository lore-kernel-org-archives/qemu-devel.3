Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9761D59F56
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 18:04:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8kNX-0000hn-3C; Wed, 06 Nov 2024 13:03:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t8kNV-0000hT-JJ
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 13:03:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t8kNT-0004gw-Tb
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 13:03:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730916214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eQzwz0VQqbTllaUoC2jABc9VHmk6FSE8vpq4QKQeiLc=;
 b=P9Uh+QXYsIonZfzE0YS8SsUkYXiBX0FIJtT6ucdWdB9cnmSDngpqn9cIjBWT9MfhM/f2vM
 pXkiPJDS1MV/HKV4QkL9Q5WD+idnXRXna9ryNS7wzgJwsTbs5yJ25ZEhsGAFtfXOhHRbLa
 jCaxSV5NSF3SelPxUncDawguPkH2IQY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-1omml77-PuWEm_VbByOGZg-1; Wed, 06 Nov 2024 13:03:32 -0500
X-MC-Unique: 1omml77-PuWEm_VbByOGZg-1
X-Mimecast-MFC-AGG-ID: 1omml77-PuWEm_VbByOGZg
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-431518e6d8fso642645e9.0
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 10:03:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730916211; x=1731521011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eQzwz0VQqbTllaUoC2jABc9VHmk6FSE8vpq4QKQeiLc=;
 b=NTTdz9/pkn0pzqPNu7t96Dsf2pnCIglRsRl7f6JNZBYIKq5kRxnZnPTCSH9gI+BzUN
 +n/k/SOr8jorTyCscbrn/Cqn86xFLZh0T+ejzPVGxMZAW1EeoWGTH2W9krByGp0dac6u
 TpfMQmLe94b+G96FWrbAcs2d8D6cdiYoiJybMja8irPzseiS23a7q0Xil3f0uHJ5Yyny
 x0azREWs578U1oKTtrXbe8WuBGuIs0vWB5/iSL9p3ha/Q0/laTlAX8vx+9SnG8hfoM1s
 FWeqYtaglJ6Tjtpid8LO2PE5lNW0JPdxPSdjAnaJGinFuq7fGerdU4ceZwar9X1lwOK9
 xcZg==
X-Gm-Message-State: AOJu0Yx7dgPoVIaIJAfirKSpJVRJCkIBAKBR4RDiHWV3B7epQSgOKb8s
 ffIxjz49jWIQZ3kFxKoTzuc2dA7kn1OXSz2P2YTp343OaVUYCccfARCRfXvBLrHpiCcnIuaNuM7
 WecM1jsXrn20MTIcU/at+a8iVDm8sOU2kK8Jl/0bGgalg3dP1BRn/OfCK5Sg7BV3pAhMro9qsH3
 Dk8NJHP5y5NqYkRS+q5bnNX0T+vpF+bl3Ndtb+yJ4=
X-Received: by 2002:a05:600c:3b14:b0:431:612f:189b with SMTP id
 5b1f17b1804b1-43283246c05mr192990645e9.12.1730916210902; 
 Wed, 06 Nov 2024 10:03:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9pFLofLjubC5rvGejPB7PtkQlW/l8pZI+71vE0WdFK/torlJt2ccTz4fANJoS9d7sv7dAJg==
X-Received: by 2002:a05:600c:3b14:b0:431:612f:189b with SMTP id
 5b1f17b1804b1-43283246c05mr192990195e9.12.1730916210322; 
 Wed, 06 Nov 2024 10:03:30 -0800 (PST)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10b7b75sm19713141f8f.15.2024.11.06.10.03.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 10:03:29 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 37/39] rust: allow older version of bindgen
Date: Wed,  6 Nov 2024 19:03:25 +0100
Message-ID: <20241106180325.566170-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106180325.566170-1-pbonzini@redhat.com>
References: <20241106180325.566170-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
 meson.build                    | 31 +++++++++++++++++++++++++++----
 2 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/docs/about/build-platforms.rst b/docs/about/build-platforms.rst
index b779eb54934..6102f00aec0 100644
--- a/docs/about/build-platforms.rst
+++ b/docs/about/build-platforms.rst
@@ -107,6 +107,18 @@ Python build dependencies
   required, it may be necessary to fetch python modules from the Python
   Package Index (PyPI) via ``pip``, in order to build QEMU.
 
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
index 5b85d4275bb..11958c67b5f 100644
--- a/meson.build
+++ b/meson.build
@@ -100,6 +100,23 @@ if have_rust
   endif
 endif
 
+if have_rust
+  bindgen = find_program('bindgen', required: get_option('rust'))
+  if not bindgen.found() or bindgen.version().version_compare('<0.60.0')
+    if get_option('rust').enabled()
+      error('bindgen version ' + bindgen.version() + ' is unsupported. You can install a new version with "cargo install bindgen-cli"')
+    else
+      if bindgen.found()
+        warning('bindgen version ' + bindgen.version() + ' is unsupported, disabling Rust compilation.')
+      else
+        warning('bindgen not found, disabling Rust compilation.')
+      endif
+      message('To use Rust you can install a new version with "cargo install bindgen-cli"')
+      have_rust = false
+    endif
+  endif
+endif
+
 dtrace = not_found
 stap = not_found
 if 'dtrace' in get_option('trace_backends')
@@ -3963,15 +3980,13 @@ common_all = static_library('common',
 if have_rust
   # We would like to use --generate-cstr, but it is only available
   # starting with bindgen 0.66.0.  The oldest supported versions
-  # are in Ubuntu 22.04 (0.59.1) and Debian 12 (0.60.1).
+  # is 0.60.x (Debian 12 has 0.60.1) which introduces --allowlist-file.
   bindgen_args = [
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
@@ -3980,6 +3995,12 @@ if have_rust
     '--allowlist-file', meson.project_source_root() + '/.*',
     '--allowlist-file', meson.project_build_root() + '/.*'
     ]
+  if bindgen.version().version_compare('<0.61.0')
+    # default in 0.61+
+    bindgen_args += ['--size_t-is-usize']
+  else
+    bindgen_args += ['--merge-extern-blocks']
+  endif
   c_enums = [
     'DeviceCategory',
     'GpioPolarity',
@@ -4015,7 +4036,7 @@ if have_rust
     dependencies: common_ss.all_dependencies(),
     output: 'bindings.rs',
     include_directories: include_directories('.', 'include'),
-    bindgen_version: ['>=0.69.4'],
+    bindgen_version: ['>=0.60.0'],
     args: bindgen_args,
     )
   subdir('rust')
@@ -4481,6 +4502,8 @@ if have_rust
   summary_info += {'Rust target':     config_host['RUST_TARGET_TRIPLE']}
   summary_info += {'rustc':           ' '.join(rustc.cmd_array())}
   summary_info += {'rustc version':   rustc.version()}
+  summary_info += {'bindgen':         bindgen.full_path()}
+  summary_info += {'bindgen version': bindgen.version()}
 endif
 option_cflags = (get_option('debug') ? ['-g'] : [])
 if get_option('optimization') != 'plain'
-- 
2.47.0


