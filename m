Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5160BC0219E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 10:24:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thQxf-0003e2-SJ; Mon, 10 Feb 2025 05:24:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1thQxd-0003WP-3s
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 05:24:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1thQxa-0000eR-Uv
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 05:24:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739183054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lf4c6h56xYCNge6XjLmVtzeXRglB5fuipR2Vwz8DQLs=;
 b=AE9LbxqAVMMKRvuOuXWU2YSR8rxoljDx1t1cG/a3xFbp362zk/iNAzlf5udfuUnuZk9id0
 TPc+u9JqKQ3hG3P3uvZNiDow/6cMLjL+xQY5cVwojyfOX6dUpOG+59zKg5+JViUkwWGxd5
 v7qaMA3iM3ixKIh1kvdkdO8tHU8E+Fc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-HqWenfjxNEayASUbtnJhuw-1; Mon, 10 Feb 2025 05:23:02 -0500
X-MC-Unique: HqWenfjxNEayASUbtnJhuw-1
X-Mimecast-MFC-AGG-ID: HqWenfjxNEayASUbtnJhuw
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5de363763ddso2504501a12.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 02:23:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739182980; x=1739787780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lf4c6h56xYCNge6XjLmVtzeXRglB5fuipR2Vwz8DQLs=;
 b=DL1YFZJ/J2y+2+wPY878wBH06/kJL5WU5DzV0q9P5FgDXSYfhA23cMh/grYz2ri2Pg
 JURX2RZKNXdgZ/NZ/0w1G9aJAl0EE6BKzFao/WDUTQ+Zs4umwfCfYSxW+92rAl1Ef4L2
 c54N2T2FkF+1/zbNRTBegDujaOtpfXOWa+6A3/cCdoCVq5yoReH3TL49CoVcZR/QMFbX
 Mqww+yQNKE7ijEp+sRXAXAucFBfmf+K4LIWHsDTxCKTqOi3vOnVcS/pYf4DA1z7vJ9Mi
 TSbd/vv5yTul7agP+7jIxV9oe2Y4Hp9rlEVcqmTZk1RayONu8Pcaqa4HyuDJhuYevt+J
 ckkw==
X-Gm-Message-State: AOJu0Ywb6LCMbQXs3/SVNF4HEo8+MqNitewOUQBePRwlkQ3abI2OPUjE
 mSv/qKuxlOf7C6aziZ/9hwB50xd2vZ1pgis/ZnICi8pC+A8OOXa1HrsSBEGT7MuvHihnPhViPlH
 zodfbdqKRtmYyhN/L66aG2o/w1oVY/EetNz/fFQkWdGcmfYfuA9ubP9qLH7BKaV1APh+jlAtNNn
 LT2Dy6nnTrg4gASbvTBOx2FVrrM3y2Qq/gg7VdJRs=
X-Gm-Gg: ASbGncssxkllZvDHqHYv2RDR9PeVKV+KdTRUDPQvA6CK+VyOW+Tpf3E/L3BnSqUTYnt
 MQOiDwMqIIc//l6sQkXlsZmDp25maf8x8jwmC733zJh3Sv80v/qVVxWM4007Dvo4hTbz2Futcra
 TxHSgg9hln+AwVpuBQpHOBmkXF+eXjZ136w4b9bwODv9GWh/5ms3iGpTWfgfwn8NceHZL6aJzSC
 O1NRoo7Eg4F2qMjuBDZyC+fW+NSXDeVzby/fMHhNknMSnxGY2IiuFANGele8+UDN63gh79a+p6K
 KGwUZA==
X-Received: by 2002:a05:6402:321d:b0:5dc:cfc5:9324 with SMTP id
 4fb4d7f45d1cf-5de4508084amr40832484a12.30.1739182980180; 
 Mon, 10 Feb 2025 02:23:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5zeQOjjAbeKNV++dYtQL0f8cINJzeWMgP5UImuqSnOVc43RuRy/2ph7ghH1CLKIaPgPjmrw==
X-Received: by 2002:a05:6402:321d:b0:5dc:cfc5:9324 with SMTP id
 4fb4d7f45d1cf-5de4508084amr40832421a12.30.1739182979520; 
 Mon, 10 Feb 2025 02:22:59 -0800 (PST)
Received: from [192.168.10.3] ([151.62.97.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab7ced6fe0dsm61951166b.179.2025.02.10.02.22.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 02:22:58 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/9] rust: remove unnecessary Cargo.toml metadata
Date: Mon, 10 Feb 2025 11:22:46 +0100
Message-ID: <20250210102255.2555097-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210102255.2555097-1-pbonzini@redhat.com>
References: <20250210102255.2555097-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.405,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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


