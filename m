Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60E2BC021AD
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 18:22:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkSEy-0007mJ-AT; Tue, 18 Feb 2025 13:22:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tkSDG-0005yC-53
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 13:20:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tkSDA-0007Zp-Jl
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 13:20:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739902848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jMQenbHLn/1pZniLXOVbC7HAYOgpvtVLQZY6e2XjTLM=;
 b=JOojkbg99d5EoLMDsEhLQ4eeww6/Sj9OXl/60ztJeiavKEkG9tLGR7nna2Eo/x1Kf9+Y2e
 F+Do7NZBwdIff0+XnCq/X4Ek2E4rzGkCVapqWX2eEiS0Fq5fGt4niUBhGN9erQcMBBE1Fg
 iLIMqGIP96VQHlXcXKvogKecwflboe4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-224-TnjzJrzRNm6PKoSkgdXdEA-1; Tue,
 18 Feb 2025 13:20:45 -0500
X-MC-Unique: TnjzJrzRNm6PKoSkgdXdEA-1
X-Mimecast-MFC-AGG-ID: TnjzJrzRNm6PKoSkgdXdEA_1739902843
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D23C6190F9CB; Tue, 18 Feb 2025 18:20:43 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.45.226.66])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4CD0C1800358; Tue, 18 Feb 2025 18:20:41 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, pbonzini@redhat.com,
 manos.pitsidianakis@linaro.org, philmd@linaro.org, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org
Subject: [PATCH v2 05/11] rust/block: Add empty crate
Date: Tue, 18 Feb 2025 19:20:13 +0100
Message-ID: <20250218182019.111467-6-kwolf@redhat.com>
In-Reply-To: <20250218182019.111467-1-kwolf@redhat.com>
References: <20250218182019.111467-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 MAINTAINERS            |  1 +
 rust/Cargo.lock        |  8 ++++++++
 rust/Cargo.toml        |  1 +
 rust/block/Cargo.toml  | 16 ++++++++++++++++
 rust/block/README.md   |  3 +++
 rust/block/meson.build | 20 ++++++++++++++++++++
 rust/block/src/lib.rs  |  1 +
 rust/meson.build       |  1 +
 8 files changed, 51 insertions(+)
 create mode 100644 rust/block/Cargo.toml
 create mode 100644 rust/block/README.md
 create mode 100644 rust/block/meson.build
 create mode 100644 rust/block/src/lib.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 3848d37a38..97cc04ae32 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2874,6 +2874,7 @@ S: Supported
 F: block*
 F: block/
 F: hw/block/
+F: rust/block/
 F: qapi/block*.json
 F: qapi/transaction.json
 F: include/block/
diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index 2ebf0a11ea..a2525052dd 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -31,6 +31,14 @@ dependencies = [
  "syn",
 ]
 
+[[package]]
+name = "block"
+version = "0.1.0"
+dependencies = [
+ "libc",
+ "qemu_api",
+]
+
 [[package]]
 name = "either"
 version = "1.12.0"
diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index 5041d6291f..2135273dfb 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -3,6 +3,7 @@ resolver = "2"
 members = [
     "qemu-api-macros",
     "qemu-api",
+    "block",
     "hw/char/pl011",
     "hw/timer/hpet",
 ]
diff --git a/rust/block/Cargo.toml b/rust/block/Cargo.toml
new file mode 100644
index 0000000000..fbc2f2d6ef
--- /dev/null
+++ b/rust/block/Cargo.toml
@@ -0,0 +1,16 @@
+[package]
+name = "block"
+version = "0.1.0"
+edition = "2021"
+authors = ["Kevin Wolf <kwolf@redhat.com>"]
+license = "GPL-2.0-or-later"
+readme = "README.md"
+description = "Block backends for QEMU"
+repository = "https://gitlab.com/qemu-project/qemu/"
+publish = false
+keywords = []
+categories = []
+
+[dependencies]
+qemu_api = { path = "../qemu-api" }
+libc = "0.2.162"
diff --git a/rust/block/README.md b/rust/block/README.md
new file mode 100644
index 0000000000..debcc9d815
--- /dev/null
+++ b/rust/block/README.md
@@ -0,0 +1,3 @@
+# QEMU block backends
+
+This library implements block drivers for QEMU.
diff --git a/rust/block/meson.build b/rust/block/meson.build
new file mode 100644
index 0000000000..ca93afd939
--- /dev/null
+++ b/rust/block/meson.build
@@ -0,0 +1,20 @@
+_block_rs = static_library(
+  'block',
+  files('src/lib.rs'),
+  override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  rust_abi: 'rust',
+  dependencies: [
+    qemu_api_tools,
+    qemu_api_macros,
+    libc_dep,
+  ],
+  rust_dependency_map: {'qemu_api_tools': 'qemu_api'},
+)
+
+rust_block_ss.add(if_true: [declare_dependency(
+  link_whole: [_block_rs],
+  # Putting proc macro crates in `dependencies` is necessary for Meson to find
+  # them when compiling the root per-target static rust lib.
+  dependencies: [qemu_api_macros],
+  variables: {'crate': 'block'},
+)])
diff --git a/rust/block/src/lib.rs b/rust/block/src/lib.rs
new file mode 100644
index 0000000000..8b13789179
--- /dev/null
+++ b/rust/block/src/lib.rs
@@ -0,0 +1 @@
+
diff --git a/rust/meson.build b/rust/meson.build
index 50eb23b072..d959809fda 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -1,6 +1,7 @@
 subdir('qemu-api-macros')
 subdir('qemu-api')
 
+subdir('block')
 subdir('hw')
 
 cargo = find_program('cargo', required: false)
-- 
2.48.1


