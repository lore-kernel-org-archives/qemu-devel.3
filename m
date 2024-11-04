Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58030D1BDD2
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 17:32:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t80sb-0006f1-QY; Mon, 04 Nov 2024 12:28:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80sa-0006VD-51
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:28:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80sX-0000Q4-Tk
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:28:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730741316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i5EXyRcUQif7nOV98F3C2ZSKwIXfW163NZDTMaMuIdQ=;
 b=DxXLjt+BxnzWnrO4WBb6eAXn5R8ydT7hWe5b31/vMA7ABUAgov9qo+f2js9t1oyC2+ihug
 4bzIZmH7EV3fpZ2m60j5BP3jX0irCGTayfU0dsm47AXT8YS+f6gNY2Wfu0FnWEyZ8AHPDn
 heX0FEP2aIJ6/+YOOhxy76K7HEhpWME=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-geyZ2jz9N-G6LlupS4zAwg-1; Mon, 04 Nov 2024 12:28:35 -0500
X-MC-Unique: geyZ2jz9N-G6LlupS4zAwg-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-53a0b48e8d4so3103590e87.3
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 09:28:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730741313; x=1731346113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i5EXyRcUQif7nOV98F3C2ZSKwIXfW163NZDTMaMuIdQ=;
 b=LjwMMGYwRgk+CF2FW6u8Vg7PaJRRSdzFn3f1RnZgf92j8sOf8iXZik6fpd2qUUDI7N
 Nbtona75dvlf4OBcrY3I312TPTVMibnU5uQYhTtOgMnAVDhEcXrZp7OIrBP6AGlCc9fi
 a4YSMxwr0yXEzu6sl3Mm6iPKwiIxsF/X4frLzmG2aVPF4zvlXdvoWXLZFWSaHlCg6CJE
 48uG6/dCBwGOUZwgXdQtWeFceTibKCd3KhYkue6EWriMATj+yhXtXVKHb4TTNRgL9KTZ
 WIJTbnFmGEx8MmmeFoagIUH+eQnvk8GP+tgIJNh0aHMYCBnKDV5nM2JlV11LT3tUZrYa
 OkkQ==
X-Gm-Message-State: AOJu0YzOKtwBWYKqZp/lFjzGvTIedoZuvNcEyOR90CS6dnfL56iIwW0n
 6fzVIv/PUzwFoUcxdmMCO4LlsbXJYidM1aVf61cGRcHstt1ohvC1dwigYfyOnl/A1nZ8t25lhiJ
 3MY8yqccz0KxmRhE+cMoQ9wmhVv3188KQ1RErqzglTbahSB+z+e3j4YiYOJk4SyJovpBEtruKx7
 taFQitC5HEI5lu5+BxQ8hHAMF4hE5sPtplLu1K/xM=
X-Received: by 2002:a05:6512:3c90:b0:539:ea54:8d22 with SMTP id
 2adb3069b0e04-53b348d2696mr16218755e87.18.1730741313041; 
 Mon, 04 Nov 2024 09:28:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+4TF0klWwjC++tT5Q3AKWlPykLZMVYN8aV3eYhr2+pHl/8fFl3HU/EDRIG4tTCgJ1b4yTSQ==
X-Received: by 2002:a05:6512:3c90:b0:539:ea54:8d22 with SMTP id
 2adb3069b0e04-53b348d2696mr16218722e87.18.1730741312508; 
 Mon, 04 Nov 2024 09:28:32 -0800 (PST)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d5ab305sm160311675e9.7.2024.11.04.09.28.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 09:28:29 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 31/40] rust: create a cargo workspace
Date: Mon,  4 Nov 2024 18:27:10 +0100
Message-ID: <20241104172721.180255-32-pbonzini@redhat.com>
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

Workspaces allows tracking dependencies for multiple crates at once,
by having a single Cargo.lock file at the top of the rust/ tree.
Because QEMU's Cargo.lock files have to be synchronized with the versions
of crates in subprojects/, using a workspace avoids the need to copy
over the Cargo.lock file when adding a new device (and thus a new crate)
under rust/hw/.

In addition, workspaces let cargo download and build dependencies just
once.  While right now we have one leaf crate (hw/char/pl011), this
will not be the case once more devices are added.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/{hw/char/pl011 => }/Cargo.lock |  0
 rust/Cargo.toml                     |  7 ++++
 rust/hw/char/pl011/Cargo.toml       |  3 --
 rust/qemu-api-macros/Cargo.lock     | 47 -------------------------
 rust/qemu-api-macros/Cargo.toml     |  3 --
 rust/qemu-api/Cargo.lock            | 54 -----------------------------
 rust/qemu-api/Cargo.toml            |  3 --
 7 files changed, 7 insertions(+), 110 deletions(-)
 rename rust/{hw/char/pl011 => }/Cargo.lock (100%)
 create mode 100644 rust/Cargo.toml
 delete mode 100644 rust/qemu-api-macros/Cargo.lock
 delete mode 100644 rust/qemu-api/Cargo.lock

diff --git a/rust/hw/char/pl011/Cargo.lock b/rust/Cargo.lock
similarity index 100%
rename from rust/hw/char/pl011/Cargo.lock
rename to rust/Cargo.lock
diff --git a/rust/Cargo.toml b/rust/Cargo.toml
new file mode 100644
index 00000000000..0c94d5037da
--- /dev/null
+++ b/rust/Cargo.toml
@@ -0,0 +1,7 @@
+[workspace]
+resolver = "2"
+members = [
+    "qemu-api-macros",
+    "qemu-api",
+    "hw/char/pl011",
+]
diff --git a/rust/hw/char/pl011/Cargo.toml b/rust/hw/char/pl011/Cargo.toml
index b089e3dded6..a373906b9fb 100644
--- a/rust/hw/char/pl011/Cargo.toml
+++ b/rust/hw/char/pl011/Cargo.toml
@@ -21,6 +21,3 @@ bilge = { version = "0.2.0" }
 bilge-impl = { version = "0.2.0" }
 qemu_api = { path = "../../../qemu-api" }
 qemu_api_macros = { path = "../../../qemu-api-macros" }
-
-# Do not include in any global workspace
-[workspace]
diff --git a/rust/qemu-api-macros/Cargo.lock b/rust/qemu-api-macros/Cargo.lock
deleted file mode 100644
index 73c334e7ce9..00000000000
--- a/rust/qemu-api-macros/Cargo.lock
+++ /dev/null
@@ -1,47 +0,0 @@
-# This file is automatically @generated by Cargo.
-# It is not intended for manual editing.
-version = 3
-
-[[package]]
-name = "proc-macro2"
-version = "1.0.84"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "ec96c6a92621310b51366f1e28d05ef11489516e93be030060e5fc12024a49d6"
-dependencies = [
- "unicode-ident",
-]
-
-[[package]]
-name = "qemu_api_macros"
-version = "0.1.0"
-dependencies = [
- "proc-macro2",
- "quote",
- "syn",
-]
-
-[[package]]
-name = "quote"
-version = "1.0.36"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "0fa76aaf39101c457836aec0ce2316dbdc3ab723cdda1c6bd4e6ad4208acaca7"
-dependencies = [
- "proc-macro2",
-]
-
-[[package]]
-name = "syn"
-version = "2.0.66"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "c42f3f41a2de00b01c0aaad383c5a45241efc8b2d1eda5661812fda5f3cdcff5"
-dependencies = [
- "proc-macro2",
- "quote",
- "unicode-ident",
-]
-
-[[package]]
-name = "unicode-ident"
-version = "1.0.12"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "3354b9ac3fae1ff6755cb6db53683adb661634f67557942dea4facebec0fee4b"
diff --git a/rust/qemu-api-macros/Cargo.toml b/rust/qemu-api-macros/Cargo.toml
index 144cc3650fa..f8d6d03609f 100644
--- a/rust/qemu-api-macros/Cargo.toml
+++ b/rust/qemu-api-macros/Cargo.toml
@@ -20,6 +20,3 @@ proc-macro = true
 proc-macro2 = "1"
 quote = "1"
 syn = "2"
-
-# Do not include in any global workspace
-[workspace]
diff --git a/rust/qemu-api/Cargo.lock b/rust/qemu-api/Cargo.lock
deleted file mode 100644
index e407911cdd1..00000000000
--- a/rust/qemu-api/Cargo.lock
+++ /dev/null
@@ -1,54 +0,0 @@
-# This file is automatically @generated by Cargo.
-# It is not intended for manual editing.
-version = 3
-
-[[package]]
-name = "proc-macro2"
-version = "1.0.84"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "ec96c6a92621310b51366f1e28d05ef11489516e93be030060e5fc12024a49d6"
-dependencies = [
- "unicode-ident",
-]
-
-[[package]]
-name = "qemu_api"
-version = "0.1.0"
-dependencies = [
- "qemu_api_macros",
-]
-
-[[package]]
-name = "qemu_api_macros"
-version = "0.1.0"
-dependencies = [
- "proc-macro2",
- "quote",
- "syn",
-]
-
-[[package]]
-name = "quote"
-version = "1.0.36"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "0fa76aaf39101c457836aec0ce2316dbdc3ab723cdda1c6bd4e6ad4208acaca7"
-dependencies = [
- "proc-macro2",
-]
-
-[[package]]
-name = "syn"
-version = "2.0.66"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "c42f3f41a2de00b01c0aaad383c5a45241efc8b2d1eda5661812fda5f3cdcff5"
-dependencies = [
- "proc-macro2",
- "quote",
- "unicode-ident",
-]
-
-[[package]]
-name = "unicode-ident"
-version = "1.0.12"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "3354b9ac3fae1ff6755cb6db53683adb661634f67557942dea4facebec0fee4b"
diff --git a/rust/qemu-api/Cargo.toml b/rust/qemu-api/Cargo.toml
index db594c64083..e092f61e8f3 100644
--- a/rust/qemu-api/Cargo.toml
+++ b/rust/qemu-api/Cargo.toml
@@ -20,8 +20,5 @@ qemu_api_macros = { path = "../qemu-api-macros" }
 default = []
 allocator = []
 
-# Do not include in any global workspace
-[workspace]
-
 [lints.rust]
 unexpected_cfgs = { level = "warn", check-cfg = ['cfg(MESON)', 'cfg(HAVE_GLIB_WITH_ALIGNED_ALLOC)'] }
-- 
2.47.0


