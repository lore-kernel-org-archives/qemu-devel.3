Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A82AC0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 21:47:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thy5c-0001AI-UD; Tue, 11 Feb 2025 16:46:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1thy3Q-000818-RJ
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 16:44:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1thy3P-0005Gr-3W
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 16:44:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739310265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=51SymC/HU+zgawyXNtMurq2f2giRy+7dnTCif234KJc=;
 b=cppTBfq+0GZTSxZ5tWE8MfYQ2jvLIW3vV9g3JJ7SmbB9G2QsI9cG6WDKGUrErI5dO0UZUl
 rTwyZVYFZ7Y+9dTtMiVKB61Qsx9jz0Ido6vgIDQXBCE0xZBLBWVlXGUeYcZakcFDMwqpEG
 PQsY9840qbzxDgB3BXvbEtvGt2/pReI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-141-KFfcg90-NtaxrhZ6VhsdyQ-1; Tue,
 11 Feb 2025 16:44:21 -0500
X-MC-Unique: KFfcg90-NtaxrhZ6VhsdyQ-1
X-Mimecast-MFC-AGG-ID: KFfcg90-NtaxrhZ6VhsdyQ_1739310260
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C53E31800873; Tue, 11 Feb 2025 21:44:20 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.32.210])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 72B8B195608D; Tue, 11 Feb 2025 21:44:18 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, pbonzini@redhat.com,
 manos.pitsidianakis@linaro.org, qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: [PATCH 05/11] rust/block: Add empty crate
Date: Tue, 11 Feb 2025 22:43:22 +0100
Message-ID: <20250211214328.640374-6-kwolf@redhat.com>
In-Reply-To: <20250211214328.640374-1-kwolf@redhat.com>
References: <20250211214328.640374-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
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

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 rust/Cargo.lock        |  7 +++++++
 rust/Cargo.toml        |  1 +
 rust/block/Cargo.toml  | 15 +++++++++++++++
 rust/block/README.md   |  3 +++
 rust/block/meson.build | 19 +++++++++++++++++++
 rust/block/src/lib.rs  |  1 +
 rust/meson.build       |  1 +
 7 files changed, 47 insertions(+)
 create mode 100644 rust/block/Cargo.toml
 create mode 100644 rust/block/README.md
 create mode 100644 rust/block/meson.build
 create mode 100644 rust/block/src/lib.rs

diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index c0c6069247..b6af988a03 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -31,6 +31,13 @@ dependencies = [
  "syn",
 ]
 
+[[package]]
+name = "block"
+version = "0.1.0"
+dependencies = [
+ "qemu_api",
+]
+
 [[package]]
 name = "either"
 version = "1.12.0"
diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index 5b0cb55928..777a2e9157 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -3,6 +3,7 @@ resolver = "2"
 members = [
     "qemu-api-macros",
     "qemu-api",
+    "block",
     "hw/char/pl011",
 ]
 
diff --git a/rust/block/Cargo.toml b/rust/block/Cargo.toml
new file mode 100644
index 0000000000..70ee02f429
--- /dev/null
+++ b/rust/block/Cargo.toml
@@ -0,0 +1,15 @@
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
index 0000000000..b13c037b2f
--- /dev/null
+++ b/rust/block/meson.build
@@ -0,0 +1,19 @@
+_block_rs = static_library(
+  'block',
+  files('src/lib.rs'),
+  override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  rust_abi: 'rust',
+  dependencies: [
+    qemu_api_tools,
+    qemu_api_macros,
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


