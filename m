Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0702CC02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 10:29:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgLaw-0005qO-IA; Fri, 07 Feb 2025 05:28:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tgLat-0005ph-AP
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 05:28:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tgLaq-0007om-Tu
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 05:28:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738924094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lf4c6h56xYCNge6XjLmVtzeXRglB5fuipR2Vwz8DQLs=;
 b=UaF5C6I1OMpY2EdWNQ/P4AFCDbk0rA/w/XN/akDsMPBzvd3si6Yje3tjvGodk3UZPGca8O
 rnuYgSxwiPBi53yPUpAWSyEt3WQ0Bi95GHwyLRN/Pf2Bv4zrWPXvDu2AAewGVd3rqaYtGM
 u4Rq+PGPxL4zq5ZZyWUKruQW4rMv/cY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-2R8v9AxBNwyYWeLFPyNtOA-1; Fri, 07 Feb 2025 05:28:11 -0500
X-MC-Unique: 2R8v9AxBNwyYWeLFPyNtOA-1
X-Mimecast-MFC-AGG-ID: 2R8v9AxBNwyYWeLFPyNtOA
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5de4c781e00so400265a12.1
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 02:28:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738924089; x=1739528889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lf4c6h56xYCNge6XjLmVtzeXRglB5fuipR2Vwz8DQLs=;
 b=ImNbCi68eXc0OiXxBbM8j28xYVnaxBj5TeHN34U2Ggn9LQMuhT5zGXOy1aqr1fZB1u
 2k6TGn0cE1DrQlsjOswndZ/wzmDsFBrmpwz3/o2nkjQByGERXh1nEC9XChnEVVAHuUsy
 udeFxRsSRZBptUsodtftXHNGst2e+sIfExZQJDo33+qC0PgTpJiy9zj/+mklYTjYGQb4
 jjGyvPKBFFvNd4hQ0fFkIyZ+Ot8hFpb0AEtMD50ld5LzliThxrZ7Kh8R8JZ+P1TlpnsY
 kh4bfyMaLmjoxjxeDRYoGxrfQmrA93WVh+WKCdHn2dxyBW03HbzCv+O8QMCkKtAgafWd
 F3xw==
X-Gm-Message-State: AOJu0Yye8mnQmnNLxu81jM06eVyrzd6J3Z1l6ogCgOwfj3t20hP+0BWr
 insrVufldd9mEq5IwMFjH33B9Oql3AwDYC52iT/7FQ0fCpa1w47AEjbwpMiTD6iZFI1iil4cqHX
 vX4v9CKJDNPlgdbR7gp763lsCMHFaO2gKa4rnEnmOEWZMb7FaQ8hdLAOZKLC8lkhO3o42F+zGyC
 vJIhEk/ozBxJobVb+CVpFZSlwTaX/g6hCl3CsM/o8=
X-Gm-Gg: ASbGncuBZ6PiFT9qNJLw0RZQmxjrYrMlvQutxQ4PNYA3yAnNRdAP7pK7hAjYXR7EtSA
 kVoL+i4ZXNGPtQiFX905KrZemNqPF9N/w5eKtZ8uX2951IRI4azHIfWXyGTT//GPYdXj+MR1pie
 HvoEnnEM4R5XOP1Y1LRHV+Ct+msmP0nGtV2S4Na4WgnKJhOvlYuxHc0SWHB8BySu6sF6RSwmgiq
 t9YsN/NGhIWNIuuZHHxwzfFeWdVeBklKlgmI8vin+05MX6D82KHsgufSJyr3PaLpEKYXAjG6wOe
 qEkcxg==
X-Received: by 2002:a05:6402:3903:b0:5dc:74f1:8a32 with SMTP id
 4fb4d7f45d1cf-5de458c49d5mr3183701a12.28.1738924088993; 
 Fri, 07 Feb 2025 02:28:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1GwlEav1p4C4wEo0UcNN/WiTcxY0WMXsyEHnHOjBC8HuvyBXp7SWOhJ4g2BICyB90ucsK2A==
X-Received: by 2002:a05:6402:3903:b0:5dc:74f1:8a32 with SMTP id
 4fb4d7f45d1cf-5de458c49d5mr3183668a12.28.1738924088363; 
 Fri, 07 Feb 2025 02:28:08 -0800 (PST)
Received: from [192.168.10.3] ([151.62.97.55])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dcf1b7b089sm2251420a12.29.2025.02.07.02.28.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 02:28:05 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/7] rust: remove unnecessary Cargo.toml metadata
Date: Fri,  7 Feb 2025 11:27:55 +0100
Message-ID: <20250207102802.2445596-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250207102802.2445596-1-pbonzini@redhat.com>
References: <20250207102802.2445596-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Some items of Cargo.toml (readme, homepage, repository) are
only present because of clippy::cargo warnings being enabled in
rust/hw/char/pl011/src/lib.rs.  But these items are not
particularly useful and would be all the same for all Cargo.toml
files in the QEMU workspace.  Clean them up.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/Cargo.toml   |  3 ---
 rust/hw/char/pl011/README.md    | 31 -------------------------------
 rust/hw/char/pl011/src/lib.rs   | 14 ++++++--------
 rust/qemu-api-macros/Cargo.toml |  3 ---
 rust/qemu-api-macros/README.md  |  1 -
 5 files changed, 6 insertions(+), 46 deletions(-)
 delete mode 100644 rust/hw/char/pl011/README.md
 delete mode 100644 rust/qemu-api-macros/README.md

diff --git a/rust/hw/char/pl011/Cargo.toml b/rust/hw/char/pl011/Cargo.toml
index 58f3e859f7e..2b4097864df 100644
--- a/rust/hw/char/pl011/Cargo.toml
+++ b/rust/hw/char/pl011/Cargo.toml
@@ -4,10 +4,7 @@ version = "0.1.0"
 edition = "2021"
 authors = ["Manos Pitsidianakis <manos.pitsidianakis@linaro.org>"]
 license = "GPL-2.0-or-later"
-readme = "README.md"
-homepage = "https://www.qemu.org"
 description = "pl011 device model for QEMU"
-repository = "https://gitlab.com/epilys/rust-for-qemu"
 resolver = "2"
 publish = false
 keywords = []
diff --git a/rust/hw/char/pl011/README.md b/rust/hw/char/pl011/README.md
deleted file mode 100644
index cd7dea31634..00000000000
--- a/rust/hw/char/pl011/README.md
+++ /dev/null
@@ -1,31 +0,0 @@
-# PL011 QEMU Device Model
-
-This library implements a device model for the PrimeCell® UART (PL011)
-device in QEMU.
-
-## Build static lib
-
-Host build target must be explicitly specified:
-
-```sh
-cargo build --target x86_64-unknown-linux-gnu
-```
-
-Replace host target triplet if necessary.
-
-## Generate Rust documentation
-
-To generate docs for this crate, including private items:
-
-```sh
-cargo doc --no-deps --document-private-items --target x86_64-unknown-linux-gnu
-```
-
-To include direct dependencies like `bilge` (bitmaps for register types):
-
-```sh
-cargo tree --depth 1 -e normal --prefix none \
- | cut -d' ' -f1 \
- | xargs printf -- '-p %s\n' \
- | xargs cargo doc --no-deps --document-private-items --target x86_64-unknown-linux-gnu
-```
diff --git a/rust/hw/char/pl011/src/lib.rs b/rust/hw/char/pl011/src/lib.rs
index e2df4586bcc..e704daf6e3e 100644
--- a/rust/hw/char/pl011/src/lib.rs
+++ b/rust/hw/char/pl011/src/lib.rs
@@ -1,13 +1,12 @@
 // Copyright 2024, Linaro Limited
 // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 // SPDX-License-Identifier: GPL-2.0-or-later
-//
-// PL011 QEMU Device Model
-//
-// This library implements a device model for the PrimeCell® UART (PL011)
-// device in QEMU.
-//
-#![doc = include_str!("../README.md")]
+
+//! PL011 QEMU Device Model
+//!
+//! This library implements a device model for the PrimeCell® UART (PL011)
+//! device in QEMU.
+//!
 //! # Library crate
 //!
 //! See [`PL011State`](crate::device::PL011State) for the device model type and
@@ -18,7 +17,6 @@
     clippy::suspicious,
     clippy::complexity,
     clippy::perf,
-    clippy::cargo,
     clippy::nursery,
     clippy::style
 )]
diff --git a/rust/qemu-api-macros/Cargo.toml b/rust/qemu-api-macros/Cargo.toml
index 5a27b52ee6e..b9b4baecddb 100644
--- a/rust/qemu-api-macros/Cargo.toml
+++ b/rust/qemu-api-macros/Cargo.toml
@@ -4,10 +4,7 @@ version = "0.1.0"
 edition = "2021"
 authors = ["Manos Pitsidianakis <manos.pitsidianakis@linaro.org>"]
 license = "GPL-2.0-or-later"
-readme = "README.md"
-homepage = "https://www.qemu.org"
 description = "Rust bindings for QEMU - Utility macros"
-repository = "https://gitlab.com/qemu-project/qemu/"
 resolver = "2"
 publish = false
 keywords = []
diff --git a/rust/qemu-api-macros/README.md b/rust/qemu-api-macros/README.md
deleted file mode 100644
index f60f54ac4be..00000000000
--- a/rust/qemu-api-macros/README.md
+++ /dev/null
@@ -1 +0,0 @@
-# `qemu-api-macros` - Utility macros for defining QEMU devices
-- 
2.48.1


