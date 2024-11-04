Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD86D1BDD0
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 17:29:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t80su-0008Bj-Un; Mon, 04 Nov 2024 12:29:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80sr-000869-Bi
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:28:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80so-0000TH-I2
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:28:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730741333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d0Yrz32tZ191PDxJl2kf+DfSdg5bbOVpXeDrYos7+QE=;
 b=FFIQU4UaqsEneX7oDan8T3fAjfNp/iFmMQJPwetwVVyXQz1PF9suQqFJ3bvpqyWvboqNSW
 jSm6wLWoaU8CcrL86rX4D1v4FzAbHWWIMfd0k/E27tbsUOaHVJXZkMuEQQyg7MQ/W3dCDh
 LunKzjW0ExD4ljj3eptP6ctTqXf2zss=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-Dp9oAbddMCaOFRDtnQ4k5w-1; Mon, 04 Nov 2024 12:28:47 -0500
X-MC-Unique: Dp9oAbddMCaOFRDtnQ4k5w-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4316ac69e6dso30915705e9.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 09:28:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730741325; x=1731346125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d0Yrz32tZ191PDxJl2kf+DfSdg5bbOVpXeDrYos7+QE=;
 b=gbZlip/oyhGiLFhot98tdpJs+0PPwa7yROEftc9jrAe8g1KOlM30uEHrR5eLJWKozO
 LwDdVOhjVqccrPEyQ5a3/BUFoe6dYBCdgy4SCQJaX1ht91BHo2PS6TGydI+XnHD6TP4V
 d99DhhXx+i2aunl+aGPE2lz55dDMc9aibQWue1dNRyEEdqXrNptH0Q6g5Y5U15DHznJc
 GlYwNg8H69J9L3+2C8VdntaUe4WO6GLB8AMR+itT1xNDFCg6MQBFeDwixKxh2v4L03K0
 XF+kGAwsVbZzVMHRFjAG3U/zBHPgu8AR1WfZR9iOx1aV/H2jY7BkPt8sUotkEWFu+HOY
 QKOQ==
X-Gm-Message-State: AOJu0Yw6nIeeNPQLhGdROZyjQme0J5cyNUdXUvoguzRaEv8KWzF+YtMi
 Rm0WaFfi0axFgGb+PeY69p4zSX8Yu8ta3XrNjazbsdMD3WJGB1LvEOJuFPi+VbdSINtD4pb9eNy
 whGz1rkksa44Tn9EXOFrggOnzSLwIsu/kEdrnNnZvbfKYyFtiNetK9/nyPidRX5lbB+lYC0/KK6
 wjmBy/etciMqihStPWpc0d3Q+njgMjcptzTW6KAk8=
X-Received: by 2002:adf:a353:0:b0:37d:5113:cdef with SMTP id
 ffacd0b85a97d-380611e4e39mr23027189f8f.43.1730741325100; 
 Mon, 04 Nov 2024 09:28:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF2S7aoGcikVlYGzL1mWNK5adpZ+cnW6jlzmaEwlXRLnJXwvLcCBut6nBHOmaPtoisplFZPtw==
X-Received: by 2002:adf:a353:0:b0:37d:5113:cdef with SMTP id
 ffacd0b85a97d-380611e4e39mr23027156f8f.43.1730741324541; 
 Mon, 04 Nov 2024 09:28:44 -0800 (PST)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10e747csm13743212f8f.64.2024.11.04.09.28.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 09:28:43 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 37/40] rust: allow older version of bindgen
Date: Mon,  4 Nov 2024 18:27:16 +0100
Message-ID: <20241104172721.180255-38-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104172721.180255-1-pbonzini@redhat.com>
References: <20241104172721.180255-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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
index 07f7e5f8f64..fffdeef8c80 100644
--- a/meson.build
+++ b/meson.build
@@ -100,6 +100,21 @@ if have_rust
   endif
 endif
 
+bindgen = find_program('bindgen', required: get_option('rust').disable_auto_if(not have_rust))
+if not bindgen.found() or bindgen.version().version_compare('<0.60.0')
+  if get_option('rust').enabled()
+    error('bindgen version ' + bindgen.version() + ' is unsupported. You can install a new version with "cargo install bindgen-cli"')
+  else
+    if bindgen.found()
+      warning('bindgen version ' + bindgen.version() + ' is unsupported, disabling Rust compilation.')
+    else
+      warning('bindgen not found, disabling Rust compilation.')
+    endif
+    message('To use Rust you can install a new version with "cargo install bindgen-cli"')
+    have_rust = false
+  endif
+endif
+
 dtrace = not_found
 stap = not_found
 if 'dtrace' in get_option('trace_backends')
@@ -3957,15 +3972,13 @@ common_all = static_library('common',
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
@@ -3974,6 +3987,12 @@ if have_rust
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
@@ -4009,7 +4028,7 @@ if have_rust
     dependencies: common_ss.all_dependencies(),
     output: 'bindings.rs',
     include_directories: include_directories('.', 'include'),
-    bindgen_version: ['>=0.69.4'],
+    bindgen_version: ['>=0.60.0'],
     args: bindgen_args,
     )
   subdir('rust')
@@ -4475,6 +4494,8 @@ if have_rust
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


