Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A77E0C3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 10:09:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBsl0-0005PZ-K3; Mon, 05 May 2025 06:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uBsky-0005NV-Md
 for qemu-devel@nongnu.org; Mon, 05 May 2025 06:09:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uBskw-0007Bn-S4
 for qemu-devel@nongnu.org; Mon, 05 May 2025 06:09:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746439742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CroMvl8kCwyNE0xpDuSk2NShdpGqc3f3DS0jey+inzY=;
 b=HA+MYEslRhbqCd36b3YleySSufqRvz9oSUNgN9/IUgzXYKU713KQNNYqSlFgYdeybLvuOO
 pL2AGvLNgNp2WQllZifR+ELrp7tHss7AjqAjdUwh+DOatrQrhv2Z1+2aTZlkNBooNambz7
 m9nYGSEMr9H4SnR+ZJ56+seRqL4wskg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-e4YWNcq-MYOhWL8JX7z69Q-1; Mon, 05 May 2025 06:09:00 -0400
X-MC-Unique: e4YWNcq-MYOhWL8JX7z69Q-1
X-Mimecast-MFC-AGG-ID: e4YWNcq-MYOhWL8JX7z69Q_1746439739
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43d5ca7c86aso24931025e9.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 03:09:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746439739; x=1747044539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CroMvl8kCwyNE0xpDuSk2NShdpGqc3f3DS0jey+inzY=;
 b=sH5UNDOhK2zezj3ivzxhpvqizb/Kp8SXdmtJZYULmC7mUOH5oFpqVNVfECDCQuGgKD
 69iGb5XDq0+NKeSnOCtSlKT/GJyHVKUbwiuND3PksmnTZnhMln/3vJqEKznOf/qG+gyq
 sbyGmfGCwAhyE9qwqiJ4VtvC0wt5VgHsL1A9alCrOsuUZnJCH6kqx3eyVeFpHnrQ8Dyc
 WlDgXQctAGSDqaFWbtSNRxnRxo0/7dtt06ZXcGN6/j7qa7w0yVH9S2ac7bo9bWGacr12
 MJoEHe2otu9Djg8up7Se1NDT2KoZPUKS4Ht+8TwnlAKMzxQYVzWwz71xe5LTUUiLOzVD
 Vy/A==
X-Gm-Message-State: AOJu0YwnbOt+wyN8zcDWMfX8XpTiCNvEXHuzUuYodCKNJjDeE7HpuSRv
 U/fD25nHzwh2VXsAa1eLCyxyj61eRXRNofEqASmgcAfig5W7rn5weLsdlGJbh1GN8ZE9KVawclm
 /4NHGtlbJEkuF0ht/9ccvv+dcF6aFwHnBfluOkbWewZuEFQbve2rf9LY8/sROo/rsCLwWPR8euN
 U1WYSjYl7MMsCjIsxk3jpWngZt4LAA7xUQDlQ7
X-Gm-Gg: ASbGnctbpV6obxcFWG0hUipeGtOZkRcO1ozmMmscriDw8nKBpGyTMIlhRa2a0EfmL4z
 /DmHp/KesYkLdz26fYN1fTQYZrH4D6RlxpOXdkH2hIIHXGpQrFUUf4oAu6VxpOe9adE3BIyWYJY
 CK0Y/hLeAqd+eyN+X3+lkMA5xkslc8zxdkyZClA6EKjCMBtn3ucn8nQn4TytmxuclRCxHrP4m8Q
 inmDcT/xCNz2nMRuScNIe44OS9ZwAKiO4SK9BKGlYop5jJnxTlsUr9R4V9zehJTlAVuwhAkB32k
 D5vDU2bIGuBbhH0=
X-Received: by 2002:a05:600c:5022:b0:43c:e6d1:efe7 with SMTP id
 5b1f17b1804b1-441bbf34052mr92335685e9.26.1746439738694; 
 Mon, 05 May 2025 03:08:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKJidQoTt4+ayt2dU/NIMwpYeHIty6OZncGOpBDDBs814dC8v7Vs0wTOPkWx99cFWBPV6ikw==
X-Received: by 2002:a05:600c:5022:b0:43c:e6d1:efe7 with SMTP id
 5b1f17b1804b1-441bbf34052mr92335485e9.26.1746439738288; 
 Mon, 05 May 2025 03:08:58 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b2ad7ab1sm175087465e9.4.2025.05.05.03.08.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 03:08:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 1/5] meson, cargo: require Rust 1.83.0
Date: Mon,  5 May 2025 12:08:50 +0200
Message-ID: <20250505100854.73936-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250505100854.73936-1-pbonzini@redhat.com>
References: <20250505100854.73936-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/rust.rst | 14 +++++---------
 meson.build         |  6 +++---
 rust/Cargo.toml     |  2 +-
 rust/clippy.toml    |  2 +-
 4 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index 4de86375021..139c298d462 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -71,21 +71,17 @@ Building Rust code with ``--enable-modules`` is not supported yet.
 Supported tools
 '''''''''''''''
 
-QEMU supports rustc version 1.77.0 and newer.  Notably, the following features
-are missing:
+QEMU supports rustc version 1.83.0 and newer.  The following features
+from relatively new versions of Rust are not used for historical reasons;
+patches are welcome:
 
 * inline const expression (stable in 1.79.0), currently worked around with
   associated constants in the ``FnCall`` trait.
 
-* associated constants have to be explicitly marked ``'static`` (`changed in
+* associated constants are still explicitly marked ``'static`` (`changed in
   1.81.0`__)
 
-* ``&raw`` (stable in 1.82.0).  Use ``addr_of!`` and ``addr_of_mut!`` instead,
-  though hopefully the need for raw pointers will go down over time.
-
-* ``new_uninit`` (stable in 1.82.0).  This is used internally by the ``pinned_init``
-  crate, which is planned for inclusion in QEMU, but it can be easily patched
-  out.
+* ``&raw`` (stable in 1.82.0).
 
 * referencing statics in constants (stable in 1.83.0).  For now use a const
   function; this is an important limitation for QEMU's migration stream
diff --git a/meson.build b/meson.build
index e77da3f9b75..7afdae0ce90 100644
--- a/meson.build
+++ b/meson.build
@@ -94,12 +94,12 @@ have_rust = have_rust and add_languages('rust', native: true,
     required: get_option('rust').disable_auto_if(not have_system))
 if have_rust
   rustc = meson.get_compiler('rust')
-  if rustc.version().version_compare('<1.77.0')
+  if rustc.version().version_compare('<1.83.0')
     if get_option('rust').enabled()
-      error('rustc version ' + rustc.version() + ' is unsupported. Please upgrade to at least 1.77.0')
+      error('rustc version ' + rustc.version() + ' is unsupported. Please upgrade to at least 1.83.0')
     else
       warning('rustc version ' + rustc.version() + ' is unsupported, disabling Rust compilation.')
-      message('Please upgrade to at least 1.77.0 to use Rust.')
+      message('Please upgrade to at least 1.83.0 to use Rust.')
       have_rust = false
     endif
   endif
diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index 4f6fe17b50f..b0f779986ab 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -12,7 +12,7 @@ edition = "2021"
 homepage = "https://www.qemu.org"
 license = "GPL-2.0-or-later"
 repository = "https://gitlab.com/qemu-project/qemu/"
-rust-version = "1.77.0"
+rust-version = "1.83.0"
 
 [workspace.lints.rust]
 unexpected_cfgs = { level = "deny", check-cfg = [
diff --git a/rust/clippy.toml b/rust/clippy.toml
index 933e46a2ffb..2fae76fb3f6 100644
--- a/rust/clippy.toml
+++ b/rust/clippy.toml
@@ -1,2 +1,2 @@
 doc-valid-idents = ["PrimeCell", ".."]
-msrv = "1.77.0"
+msrv = "1.83.0"
-- 
2.49.0


