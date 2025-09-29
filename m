Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66912CAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 15:56:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3G9h-0001Vd-Bv; Mon, 29 Sep 2025 11:51:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3G8z-0000yc-Qz
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:50:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3G8i-0000aE-Hw
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:50:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759161009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IbFiXIH/TncCeyWIaeOv4wWWiHN6wH4wF+ui7m2Sv3c=;
 b=Sl6HnoyyZuBJyz2ZCFhbMA0+Fa6Uws8ETtiCnbmmK3Xy7YixN8S8Ay1StWEH/kytibKLOF
 igngfr2+dbYoukzV7RC9Df5P25Ou/6OO8yq06dyjaHTILl6apGJyhKW29kdMvpZpFBdZQv
 oDGv0qqm8oHnEO67pCG7QK4n8Muo3UE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-dW1V3gpTPc-3uOfbnSzM9A-1; Mon, 29 Sep 2025 11:50:06 -0400
X-MC-Unique: dW1V3gpTPc-3uOfbnSzM9A-1
X-Mimecast-MFC-AGG-ID: dW1V3gpTPc-3uOfbnSzM9A_1759161006
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b3afaf5defdso180328666b.0
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 08:50:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759161005; x=1759765805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IbFiXIH/TncCeyWIaeOv4wWWiHN6wH4wF+ui7m2Sv3c=;
 b=B5L1sb5cvW3a0BLnx0X6pW81Iz4INGPcCq6Yh+AQe4ayizvCd7ozBod7Xe+UflJVLp
 gpGKk1T8vhUNto3JXewU/N/90KJpd50JzR911ukGx3Qwll/jxcB/ScB+XgNQZ/de4gDo
 qVuDlcqz75cy1aIyOoU3RHekikz+FQMV2taWrzuX099jRubKaw0jmyBcLW4q9DeQA9Jn
 JcnFHk/hwZQBd8hZqPich2ckJ5xGXyvT7l1WBCpK5vKEvVQGEAuzD7uBftAopdZ7q9es
 edL7TYdlLn+Bm+EzDhm6e/NTW95JJgcl9HdtBGlXkCfe1RzufG97c4rC3hxKMKXIZPfD
 X3hg==
X-Gm-Message-State: AOJu0Yzvg5IrH9A3AB1ToI33DtLaL190Ymz5H9BqLqsgKgP8tONhPfhj
 CLnfnAz4LmRqM5gMgwbMkIroZ/1WiuCf47MuqhqLnVVg0l6PnbuVGbKX6Gn0tm9dlBXrcySThJt
 1GheisqmFJ1t8vIOQolba2rvrtCN0F1VR+Kemi2J8TRV9n1WrXI4nrZ5IQlSWvqCm+NJ3wkFmM9
 t2VfiJOqFWpzdXKLAsDnVfH6l7BY8lJ+Yn6tXLkYH2
X-Gm-Gg: ASbGncvaqUBU392gdguKetfHoFUMsnEEswkP6LSk3Cwn1EnwwhQaEHOui7jFpcYf13H
 7m8+dwZ56LiFxzjyqnuKbd7Elwf3hMYPkbT0p+2srw5ZBECqcQZ3JvB3gVwFO2TW0KIMo4f1QFt
 gNpmuMCdsmZbP1UbopAadt9pbNlOgeXXkXMeOyN/kyqiUK7ThfPZkDebtGmSmTRuMpoYKIKzqjc
 rmB/hsw5bzKqQ1UeOalgKDLTii9VIelLJXrz9CKEx4fhCYxB/9b/hzEtK3RKsBLdSyomzdcwb95
 vL5Dsq3wtXrEvEWsDUn9CvzjIx47L1WBnfvEweprjWH+NZZg+ukHFJusp0rsIjMY0AoTVB+E2LZ
 Z8WYgM3fxTMj9QVykQG1KdE4qesO9Jb/mnj+bVj4nk7O1jQ==
X-Received: by 2002:a17:906:f584:b0:b3f:a960:e057 with SMTP id
 a640c23a62f3a-b3fa960e50amr376782066b.31.1759161004769; 
 Mon, 29 Sep 2025 08:50:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRoaXuYL4gcyhKRHpI3i0qEJMtO/jk05ODIibiVsx+0CR4Oz5jXPNGxLhRR9GcKEGfVJ+8Xg==
X-Received: by 2002:a17:906:f584:b0:b3f:a960:e057 with SMTP id
 a640c23a62f3a-b3fa960e50amr376778566b.31.1759161004297; 
 Mon, 29 Sep 2025 08:50:04 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b353f87511dsm958113866b.43.2025.09.29.08.50.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 08:50:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Tanish Desai <tanishdesai37@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-rust@nongnu.org
Subject: [PATCH 09/16] rust: add trace crate
Date: Mon, 29 Sep 2025 17:49:31 +0200
Message-ID: <20250929154938.594389-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929154938.594389-1-pbonzini@redhat.com>
References: <20250929154938.594389-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Tanish Desai <tanishdesai37@gmail.com>

The trace crate is a minimal container for dependencies of tracepoints
(so that they do not have to be imported in all the crates that use
tracepoints); it also contains a macro called "include_trace!" that is
able to find the right include file from the trace/ directory.

Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
[Write commit message, add #[allow()]. - Paolo]
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/Cargo.lock        |  4 ++++
 rust/Cargo.toml        |  1 +
 rust/meson.build       |  2 +-
 rust/trace/Cargo.toml  | 16 ++++++++++++++++
 rust/trace/meson.build | 19 +++++++++++++++++++
 rust/trace/src/lib.rs  | 35 +++++++++++++++++++++++++++++++++++
 trace/meson.build      |  8 +++++++-
 7 files changed, 83 insertions(+), 2 deletions(-)
 create mode 100644 rust/trace/Cargo.toml
 create mode 100644 rust/trace/meson.build
 create mode 100644 rust/trace/src/lib.rs

diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index 8315f98c46f..3428dbaf0b3 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -258,6 +258,10 @@ dependencies = [
  "util",
 ]
 
+[[package]]
+name = "trace"
+version = "0.1.0"
+
 [[package]]
 name = "unicode-ident"
 version = "1.0.12"
diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index d8183c614d4..f372d7dbf70 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -11,6 +11,7 @@ members = [
     "hw/core",
     "hw/char/pl011",
     "hw/timer/hpet",
+    "trace",
     "util",
     "tests",
 ]
diff --git a/rust/meson.build b/rust/meson.build
index b3ac3a71970..695d5a62de9 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -34,7 +34,7 @@ subdir('system')
 subdir('chardev')
 subdir('hw/core')
 subdir('tests')
-
+subdir('trace')
 subdir('hw')
 
 cargo = find_program('cargo', required: false)
diff --git a/rust/trace/Cargo.toml b/rust/trace/Cargo.toml
new file mode 100644
index 00000000000..13ac0b33d6f
--- /dev/null
+++ b/rust/trace/Cargo.toml
@@ -0,0 +1,16 @@
+[package]
+name = "trace"
+version = "0.1.0"
+authors = ["Tanish Desai <tanishdesai37@gmail.com>"]
+description = "QEMU tracing infrastructure support"
+resolver = "2"
+publish = false
+
+edition.workspace = true
+homepage.workspace = true
+license.workspace = true
+repository.workspace = true
+rust-version.workspace = true
+
+[lints]
+workspace = true
diff --git a/rust/trace/meson.build b/rust/trace/meson.build
new file mode 100644
index 00000000000..adca57e5507
--- /dev/null
+++ b/rust/trace/meson.build
@@ -0,0 +1,19 @@
+rust = import('rust')
+
+lib_rs = configure_file(
+  input: 'src/lib.rs',
+  output: 'lib.rs',
+  configuration: {
+    'MESON_BUILD_ROOT': meson.project_build_root(),
+  })
+
+_trace_rs = static_library(
+  'trace',             # Library name,
+  lib_rs,
+  trace_rs_targets,         # List of generated `.rs` custom targets
+  override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  dependencies: [libc_rs],
+  rust_abi: 'rust',
+)
+
+trace_rs = declare_dependency(link_with: _trace_rs)
diff --git a/rust/trace/src/lib.rs b/rust/trace/src/lib.rs
new file mode 100644
index 00000000000..0955461573d
--- /dev/null
+++ b/rust/trace/src/lib.rs
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+//! This crate provides macros that aid in using QEMU's tracepoint
+//! functionality.
+
+#[macro_export]
+/// Define the trace-points from the named directory (which should have slashes
+/// replaced by underscore characters) as functions in a module called `trace`.
+///
+/// ```ignore
+/// ::trace::include_trace!("hw_char");
+/// // ...
+/// trace::trace_pl011_read_fifo_rx_full();
+/// ```
+macro_rules! include_trace {
+    ($name:literal) => {
+        #[allow(
+            clippy::ptr_as_ptr,
+            clippy::cast_lossless,
+            clippy::used_underscore_binding
+        )]
+        mod trace {
+            #[cfg(not(MESON))]
+            include!(concat!(
+                env!("MESON_BUILD_ROOT"),
+                "/trace/trace-",
+                $name,
+                ".rs"
+            ));
+
+            #[cfg(MESON)]
+            include!(concat!("@MESON_BUILD_ROOT@/trace/trace-", $name, ".rs"));
+        }
+    };
+}
diff --git a/trace/meson.build b/trace/meson.build
index 9c42a57a053..d89a0db82a1 100644
--- a/trace/meson.build
+++ b/trace/meson.build
@@ -1,5 +1,5 @@
 system_ss.add(files('control-target.c', 'trace-hmp-cmds.c'))
-
+trace_rs_targets = []
 trace_events_files = []
 foreach item : [ '.' ] + trace_events_subdirs + qapi_trace_events
   if item in qapi_trace_events
@@ -24,6 +24,11 @@ foreach item : [ '.' ] + trace_events_subdirs + qapi_trace_events
                           input: trace_events_file,
                           command: [ tracetool, group, '--format=c', '@INPUT@', '@OUTPUT@' ],
                           depend_files: tracetool_depends)
+  trace_rs = custom_target(fmt.format('trace', 'rs'),
+                          output: fmt.format('trace', 'rs'),
+                          input: trace_events_file,
+                          command: [ tracetool, group, '--format=rs', '@INPUT@', '@OUTPUT@' ],
+                          depend_files: tracetool_depends)
   if 'ust' in get_option('trace_backends')
     trace_ust_h = custom_target(fmt.format('trace-ust', 'h'),
                                 output: fmt.format('trace-ust', 'h'),
@@ -34,6 +39,7 @@ foreach item : [ '.' ] + trace_events_subdirs + qapi_trace_events
     genh += trace_ust_h
   endif
   trace_ss.add(trace_h, trace_c)
+  trace_rs_targets += trace_rs
   if 'dtrace' in get_option('trace_backends')
     trace_dtrace = custom_target(fmt.format('trace-dtrace', 'dtrace'),
                                  output: fmt.format('trace-dtrace', 'dtrace'),
-- 
2.51.0


