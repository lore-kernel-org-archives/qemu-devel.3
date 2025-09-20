Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 731CBCAC5A8
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Sep 2025 14:31:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzybN-0007Gq-PN; Sat, 20 Sep 2025 10:30:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uzybM-0007GR-Fy
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 10:30:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uzybK-0005Ri-O9
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 10:30:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758378609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hD5c5Jjgf0+adbTjKcRhlLqzouuGQG7/y7gKp/DqW8w=;
 b=D0VG1UpRmXkmtKiXuYBDx3+S3RogdD7J+DWuXzASNyPAMP9i9Pj3D6x0WUrDiB2PLuWoME
 qoP/hLomj0PGzpDowvZ+husM1fdTenGHmp6qBgF3HWi3fSzk3XzPaWvlxRNJhAZ9Cve1FG
 XiLJ0uEJ1tsm0RMYcW8McnaNjsxYuZc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589--fAR6aSJM3SsLPLmCkbukQ-1; Sat, 20 Sep 2025 10:30:08 -0400
X-MC-Unique: -fAR6aSJM3SsLPLmCkbukQ-1
X-Mimecast-MFC-AGG-ID: -fAR6aSJM3SsLPLmCkbukQ_1758378607
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3ecdd61b798so1590190f8f.1
 for <qemu-devel@nongnu.org>; Sat, 20 Sep 2025 07:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758378606; x=1758983406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hD5c5Jjgf0+adbTjKcRhlLqzouuGQG7/y7gKp/DqW8w=;
 b=COgxUC6LjxAd+zZL8YcqchKnVODowHzuC7SuDspJXqe37701gtk7sURXMBD6lB2q4D
 5GRYMsFQwOuUt4gZhYCNaSABlStI6et30DCP/5OtAGInn+2nc0vySkfz6hpqGYixxg1y
 oq6mpQaolGVh14mxdYzW5B9W4z/c8teRdrXtidw+F8027ZEiyWzJD5tohey1pgIuWh57
 zsjOKfScVUEYED6lBa2nHCUskwMjwyZF7VDE9RKwAjqb/QMvR3mJa20IpueUtCQL8I3W
 WBDIBZDXxZm2FzCKhq5dY0BtdrMKDPhPhX2qp2H0RI+2ugj2zTzgQe/0BYW6tNl1UTOA
 XmOg==
X-Gm-Message-State: AOJu0YwXr/+ypBY9nl9X8BEI9VGWaZszpCLuQWTbsqcn76bL5b+6avnA
 GaVZkOY4/rC0hE0ULxwk3my11TyETJEiYC+rB2xDXnF6jRyVxF/onVpgN3dCAQmd+X3gxteZl8i
 /0NPcmLe3bue/L7w55aKKwDKSeyEm3Sk8kJOKuTncC4su7DXiA5NB+4O8G8TSPKc1QM++jTrx/q
 lY6j9wCf9Xjz2i9FjikrecfebRNlI+65i5PiK7vtKX
X-Gm-Gg: ASbGncuAsbejqUuWXh8ssdhoWT5HvSv7wxD6O6L+S6UqcuAQrRBQXhtELcHr16ggoE4
 KUHlt2prQax/kNIM/bl2oCJQGHINv00ZB3ifvGqzqXS7oPsw3nHn1asADonvxDofPOfNoCjUqEw
 EK58HV1TLW3gQuwY8AHwARn5bi6zGeZLm7cJMGrFlQn8TrsP54WY6qPa7muwvsHI4XGGRH9CllT
 wMy4OA1xh/VDelv0b+5EZqYmL5dN7XWtnEoKGrw7bkYMOeOPpFiewioth4p7nFH+TDLxHmU4K2q
 +RfbOjWN5T/9R2Htai0Zq+vdeg8fk979WD7Ltm8YXC6/ejSBqm/DehxXAnfYctXHQcxLbDP/3wE
 XVkWc4D705ihnrUlUsGkcOozE7WDKN2P0Nht71CLjaNM=
X-Received: by 2002:a05:6000:144f:b0:3ea:e0fd:290a with SMTP id
 ffacd0b85a97d-3ee7ca198bcmr5626470f8f.12.1758378605818; 
 Sat, 20 Sep 2025 07:30:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEY2uIvO2v6ndyjsXpxAwwKXgH8Vk5vjX+Z7eR7PXHaulZbV6aLztuwVb3IsPXrIt3KaIJ9CA==
X-Received: by 2002:a05:6000:144f:b0:3ea:e0fd:290a with SMTP id
 ffacd0b85a97d-3ee7ca198bcmr5626454f8f.12.1758378605369; 
 Sat, 20 Sep 2025 07:30:05 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.47.123])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee0fbc7478sm12161228f8f.38.2025.09.20.07.30.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Sep 2025 07:30:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, zhao1.liu@intel.com, manos.pitsidianakis@linaro.org
Subject: [PATCH 2/7] rust: move VMState from bql to migration
Date: Sat, 20 Sep 2025 16:29:53 +0200
Message-ID: <20250920142958.181910-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250920142958.181910-1-pbonzini@redhat.com>
References: <20250920142958.181910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.045,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=unavailable autolearn_force=no
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

The high-level wrapper Migratable<T> will contain a BqlCell,
which would introduce a circular dependency betwen the bql and
migration crates.  Move the implementation of VMState for cells
to "migration", together with the implementation for std types.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/Cargo.lock               | 4 +---
 rust/bql/Cargo.toml           | 3 ---
 rust/bql/meson.build          | 1 -
 rust/bql/src/cell.rs          | 6 ------
 rust/meson.build              | 2 +-
 rust/migration/Cargo.toml     | 1 +
 rust/migration/meson.build    | 4 ++--
 rust/migration/src/vmstate.rs | 2 ++
 8 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index 2826c4d027b..960f603cedb 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -57,9 +57,6 @@ dependencies = [
 [[package]]
 name = "bql"
 version = "0.1.0"
-dependencies = [
- "migration",
-]
 
 [[package]]
 name = "chardev"
@@ -141,6 +138,7 @@ checksum = "18d287de67fe55fd7e1581fe933d965a5a9477b38e949cfa9f8574ef01506398"
 name = "migration"
 version = "0.1.0"
 dependencies = [
+ "bql",
  "common",
  "util",
 ]
diff --git a/rust/bql/Cargo.toml b/rust/bql/Cargo.toml
index 1041bd4ea93..d87edf4c302 100644
--- a/rust/bql/Cargo.toml
+++ b/rust/bql/Cargo.toml
@@ -12,9 +12,6 @@ license.workspace = true
 repository.workspace = true
 rust-version.workspace = true
 
-[dependencies]
-migration = { path = "../migration" }
-
 [features]
 default = ["debug_cell"]
 debug_cell = []
diff --git a/rust/bql/meson.build b/rust/bql/meson.build
index 7214d944089..305d7111897 100644
--- a/rust/bql/meson.build
+++ b/rust/bql/meson.build
@@ -36,7 +36,6 @@ _bql_rs = static_library(
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   rust_args: _bql_cfg,
-  link_with: [_migration_rs],
 )
 
 bql_rs = declare_dependency(link_with: [_bql_rs],
diff --git a/rust/bql/src/cell.rs b/rust/bql/src/cell.rs
index 8a0c8c14ad4..defa45a3294 100644
--- a/rust/bql/src/cell.rs
+++ b/rust/bql/src/cell.rs
@@ -151,8 +151,6 @@
     ptr::NonNull,
 };
 
-use migration::impl_vmstate_transparent;
-
 /// A mutable memory location that is protected by the Big QEMU Lock.
 ///
 /// # Memory layout
@@ -364,8 +362,6 @@ pub fn take(&self) -> T {
     }
 }
 
-impl_vmstate_transparent!(crate::cell::BqlCell<T> where T: VMState);
-
 /// A mutable memory location with dynamically checked borrow rules,
 /// protected by the Big QEMU Lock.
 ///
@@ -693,8 +689,6 @@ fn from(t: T) -> BqlRefCell<T> {
     }
 }
 
-impl_vmstate_transparent!(crate::cell::BqlRefCell<T> where T: VMState);
-
 struct BorrowRef<'b> {
     borrow: &'b Cell<BorrowFlag>,
 }
diff --git a/rust/meson.build b/rust/meson.build
index 0bb2a9630a1..f4fb7daf05a 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -29,8 +29,8 @@ subdir('qemu-macros')
 subdir('common')
 subdir('bits')
 subdir('util')
-subdir('migration')
 subdir('bql')
+subdir('migration')
 subdir('qom')
 subdir('system')
 subdir('chardev')
diff --git a/rust/migration/Cargo.toml b/rust/migration/Cargo.toml
index 708bfaaa682..f4a86275152 100644
--- a/rust/migration/Cargo.toml
+++ b/rust/migration/Cargo.toml
@@ -13,6 +13,7 @@ repository.workspace = true
 rust-version.workspace = true
 
 [dependencies]
+bql = { path = "../bql" }
 common = { path = "../common" }
 util = { path = "../util" }
 
diff --git a/rust/migration/meson.build b/rust/migration/meson.build
index 2a49bd1633e..2f38da9220f 100644
--- a/rust/migration/meson.build
+++ b/rust/migration/meson.build
@@ -36,12 +36,12 @@ _migration_rs = static_library(
   ),
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
-  link_with: [_util_rs],
+  link_with: [_util_rs, _bql_rs],
   dependencies: [common_rs],
 )
 
 migration_rs = declare_dependency(link_with: [_migration_rs],
-  dependencies: [migration, qemuutil])
+  dependencies: [bql_rs, migration, qemuutil])
 
 # Doctests are essentially integration tests, so they need the same dependencies.
 # Note that running them requires the object files for C code, so place them
diff --git a/rust/migration/src/vmstate.rs b/rust/migration/src/vmstate.rs
index e04b19b3c9f..05a833a8b7d 100644
--- a/rust/migration/src/vmstate.rs
+++ b/rust/migration/src/vmstate.rs
@@ -275,6 +275,8 @@ unsafe impl<$base> $crate::vmstate::VMState for $type where $base: $crate::vmsta
     };
 }
 
+impl_vmstate_transparent!(bql::BqlCell<T> where T: VMState);
+impl_vmstate_transparent!(bql::BqlRefCell<T> where T: VMState);
 impl_vmstate_transparent!(std::cell::Cell<T> where T: VMState);
 impl_vmstate_transparent!(std::cell::UnsafeCell<T> where T: VMState);
 impl_vmstate_transparent!(std::pin::Pin<T> where T: VMState);
-- 
2.51.0


