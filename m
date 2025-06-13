Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF42DC71135
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 13:04:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ44H-0000VY-Fe; Fri, 13 Jun 2025 09:03:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uQ43j-0000Ck-Tw
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 09:03:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uQ43h-0000Zj-Ss
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 09:03:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749819780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZA6ipBLWLrIC7AEh0eM3XoAiZ5TU/mlZesNKTaKlNBk=;
 b=bBrbh4u5jyBXcyzg5B4SaaLKla8vvUaPNt+N4lk476Hbkwjj2eomN3hngtqupHrQ0IrM+P
 lYnKKn+X8riNTvWfZK8tco7UvJ4WrDb+paRSQV7Rrc4iXNQW4XodC+oxKCeQSuHNH20aEG
 s9KSRs1GLaXYXG/ltwWokPrQxinigzc=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-iy-AY0OQOMq5sETjARkz7A-1; Fri, 13 Jun 2025 09:02:58 -0400
X-MC-Unique: iy-AY0OQOMq5sETjARkz7A-1
X-Mimecast-MFC-AGG-ID: iy-AY0OQOMq5sETjARkz7A_1749819777
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-553218c5adaso1042909e87.2
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 06:02:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749819776; x=1750424576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZA6ipBLWLrIC7AEh0eM3XoAiZ5TU/mlZesNKTaKlNBk=;
 b=RPqDvT34xp+7NF9Zle3qkD6T72W4C0UYheQ+Ktu/9zPKmkcR8DrSgwdcAQkIFGO7UG
 QP/wlymbcFXrVX3ZKnTG7NB5avw1pXU92OLVY0yLQGMh+nEtn0g2XFJh9vr6zooHCdrO
 6n//MuCT3btQhHl0grQAbjOfM4hQTurlLw2huF6Ns3CLOACzdRe/2dW5TvGLU1fW7JZi
 GAy1C3q2M86L6d96aHYdHdIuPjzt0WPcxfWbxci2/GE4XgSugPkZ0i2fUV4BUcq8BCGZ
 J0Gf57zOXJfv2k6tCi2RJ9h9AACD4+tLWxZdMbYhIS/jmC0DbMrfqRzF+9zjhVftzpH+
 ZGuw==
X-Gm-Message-State: AOJu0Yzku0n5Nbg7WRgZtgoJFBYtJAg4ZWxTTSSWjFx0puwbUKxPAuGR
 FO5LJdhRTh3UIR3FC6JP9LfzTXVZfA/rm4tzBm7s4hVn91/G8z0qgwLJnsLVcixNg1xw9fay4Vh
 yxbJharu3XuU/qc7SEWYvV2mooD0C8ixls257z6QsgqCEU5nLs5c8MQyhON3fiY6CqLt93Gk2mR
 0dJOYJtKjUMmXD8+sOy5ADs4GxHgv2MwtxQVZilole
X-Gm-Gg: ASbGncthovkWzCiKHBF9lCorx85eKqVac3s2YCTurdTXbHgta1ZY74W2rPU2LjI4CEI
 /ulhuUZ7l0Qy5LGb7ssUhasy7bB0K531LXUB9DCh9/AtkJfxyv77elclTHHWnPDx8tALGCH7krw
 RBqthkE8lNLhOzv/ZJ0nCULW+SkQ04u9j/c0qA4Ok5GtiaMssIMIM0mNUXgrSunUJuwOqcM2kv/
 gBgQhkoLr5ABxFrKI65f3Ieqcc6FMsdXsC9gxnD1ldQMG7q+WlkLXnQ7VR14jbt0aYFmlQcyA5y
 COb8TnsamfTaQloJ8JQD2DZO
X-Received: by 2002:a05:6512:3b9e:b0:54f:c10b:7290 with SMTP id
 2adb3069b0e04-553af990816mr679596e87.26.1749819775727; 
 Fri, 13 Jun 2025 06:02:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpxJCiCgPC3g4pQu6RDNC9AT9wGHHLwPvV6P5CoOXSlnAU3g8YNDPvSc6gcFc/570e3/30jg==
X-Received: by 2002:a05:6512:3b9e:b0:54f:c10b:7290 with SMTP id
 2adb3069b0e04-553af990816mr679467e87.26.1749819774315; 
 Fri, 13 Jun 2025 06:02:54 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e25e89fsm50539045e9.33.2025.06.13.06.02.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 06:02:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	tanishdesai37@gmail.com
Subject: [PATCH 2/2] rust: move rust.bindgen to qemu-api crate
Date: Fri, 13 Jun 2025 15:02:49 +0200
Message-ID: <20250613130249.1225545-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613130249.1225545-1-pbonzini@redhat.com>
References: <20250613130249.1225545-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Once qemu-api is split in multiple crates, each of which will have
its own invocation of bindgen.  There cannot be only one, because
there are occasional "impl" blocks for the bindgen-generated
structs (e.g. VMStateFlags or QOM classes) that have to
reside in the same crate as the bindgen-generated code.

For now, prepare for this new organization by invoking bindgen
within the qemu-api crate's build definitions.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                   | 41 -----------------------------------
 rust/{ => qemu-api}/wrapper.h |  0
 rust/meson.build              |  4 +++-
 rust/qemu-api/meson.build     | 41 +++++++++++++++++++++++++++++++++++
 4 files changed, 44 insertions(+), 42 deletions(-)
 rename rust/{ => qemu-api}/wrapper.h (100%)

diff --git a/meson.build b/meson.build
index d9838319dae..4676908dbb2 100644
--- a/meson.build
+++ b/meson.build
@@ -4234,47 +4234,6 @@ if have_rust
   else
     bindgen_args_common += ['--merge-extern-blocks']
   endif
-
-  bindgen_args = []
-  c_enums = [
-    'DeviceCategory',
-    'GpioPolarity',
-    'MachineInitPhase',
-    'MemoryDeviceInfoKind',
-    'MigrationPolicy',
-    'MigrationPriority',
-    'QEMUChrEvent',
-    'QEMUClockType',
-    'ResetType',
-    'device_endian',
-    'module_init_type',
-  ]
-  foreach enum : c_enums
-    bindgen_args += ['--rustified-enum', enum]
-  endforeach
-  c_bitfields = [
-    'ClockEvent',
-    'VMStateFlags',
-  ]
-  foreach enum : c_bitfields
-    bindgen_args += ['--bitfield-enum', enum]
-  endforeach
-
-  # TODO: Remove this comment when the clang/libclang mismatch issue is solved.
-  #
-  # Rust bindings generation with `bindgen` might fail in some cases where the
-  # detected `libclang` does not match the expected `clang` version/target. In
-  # this case you must pass the path to `clang` and `libclang` to your build
-  # command invocation using the environment variables CLANG_PATH and
-  # LIBCLANG_PATH
-  _qemu_api_bindings_inc_rs = rust.bindgen(
-    input: 'rust/wrapper.h',
-    dependencies: common_ss.all_dependencies(),
-    output: 'bindings.inc.rs',
-    include_directories: bindings_incdir,
-    bindgen_version: ['>=0.60.0'],
-    args: bindgen_args_common + bindgen_args,
-    )
   subdir('rust')
 endif
 
diff --git a/rust/wrapper.h b/rust/qemu-api/wrapper.h
similarity index 100%
rename from rust/wrapper.h
rename to rust/qemu-api/wrapper.h
diff --git a/rust/meson.build b/rust/meson.build
index e9f0879e296..331f11b7e72 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -20,6 +20,8 @@ proc_macro2_rs_native = dependency('proc-macro2-1-rs', native: true)
 
 qemuutil_rs = qemuutil.partial_dependency(link_args: true, links: true)
 
+genrs = []
+
 subdir('qemu-api-macros')
 subdir('bits')
 subdir('qemu-api')
@@ -33,5 +35,5 @@ if cargo.found()
     command: [config_host['MESON'], 'devenv',
               '--workdir', '@CURRENT_SOURCE_DIR@',
               cargo, 'fmt'],
-    depends: _qemu_api_bindings_inc_rs)
+    depends: genrs)
 endif
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 64c04dfd74b..05d010e094f 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -7,6 +7,47 @@ if get_option('debug_mutex')
   _qemu_api_cfg += ['--cfg', 'feature="debug_cell"']
 endif
 
+c_enums = [
+  'DeviceCategory',
+  'GpioPolarity',
+  'MachineInitPhase',
+  'MemoryDeviceInfoKind',
+  'MigrationPolicy',
+  'MigrationPriority',
+  'QEMUChrEvent',
+  'QEMUClockType',
+  'ResetType',
+  'device_endian',
+  'module_init_type',
+]
+_qemu_api_bindgen_args = []
+foreach enum : c_enums
+  _qemu_api_bindgen_args += ['--rustified-enum', enum]
+endforeach
+c_bitfields = [
+  'ClockEvent',
+  'VMStateFlags',
+]
+foreach enum : c_bitfields
+  _qemu_api_bindgen_args += ['--bitfield-enum', enum]
+endforeach
+
+# TODO: Remove this comment when the clang/libclang mismatch issue is solved.
+#
+# Rust bindings generation with `bindgen` might fail in some cases where the
+# detected `libclang` does not match the expected `clang` version/target. In
+# this case you must pass the path to `clang` and `libclang` to your build
+# command invocation using the environment variables CLANG_PATH and
+# LIBCLANG_PATH
+_qemu_api_bindings_inc_rs = rust.bindgen(
+  input: 'wrapper.h',
+  dependencies: common_ss.all_dependencies(),
+  output: 'bindings.inc.rs',
+  include_directories: bindings_incdir,
+  bindgen_version: ['>=0.60.0'],
+  args: bindgen_args_common + _qemu_api_bindgen_args,
+  )
+
 _qemu_api_rs = static_library(
   'qemu_api',
   structured_sources(
-- 
2.49.0


