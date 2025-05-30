Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64452C5B549
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 08:04:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKui4-0002Ou-50; Fri, 30 May 2025 04:03:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKui0-0002NC-Np
 for qemu-devel@nongnu.org; Fri, 30 May 2025 04:03:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKuhy-0004Xy-9R
 for qemu-devel@nongnu.org; Fri, 30 May 2025 04:03:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748592197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UUj6q6B+e336ffq5s6Zk0rCKpR7Qm0AOx4IF/wqWtHg=;
 b=BuzoIo0GoYJ7OKAYRjooTYF579eNkmBPbdc524YVBxi5ZABfpfvpT9jKUdWRtKyWhcQqcf
 9Bf0ZEyPbINyNEPyJr++xpFiTfKRMOdPpdg+v2/h9ATOyZ8DfN8XGOCR3xHXxZsr/XXOBu
 Cg1gPA3DuKqGTu7tu/dRFSkkGI4zm5s=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-TjJSTUJPN-Kpf1L1BBwoZA-1; Fri, 30 May 2025 04:03:15 -0400
X-MC-Unique: TjJSTUJPN-Kpf1L1BBwoZA-1
X-Mimecast-MFC-AGG-ID: TjJSTUJPN-Kpf1L1BBwoZA_1748592195
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-adb32dbf60bso67157166b.1
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 01:03:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748592194; x=1749196994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UUj6q6B+e336ffq5s6Zk0rCKpR7Qm0AOx4IF/wqWtHg=;
 b=pGcYymaHyI1JusKvcYjLND3MmmqPXh58kAbNff/+aSgoj7VttwNUNK7AscaxV2btTA
 CyaP2JAUY+fHqxFZY7TRyWDhZQS1+xMyTqUbSWtOsRWcVOWNtohqLngM9fFSxSd7IFT9
 hk3e6QlF34SfQQo3eB37RleL9eWyG8vzpHe7k8LBpVu+7NUSgv7aKtgdApIwmis5edJi
 uL2a79q7PbataFmVMWFQiWpcXVuep7tD4Jfh74V5haFlXWNHq1RQJAJ5qIpYmYtFwFf1
 6WnPxNyHGAfn2AdjtUayFuolo054XRv1xidS8V3adhvXmwNO6Ggq/7h4iNfXGRm+GQCv
 6NaA==
X-Gm-Message-State: AOJu0YzQXXnIawZ0cGdiy+3ZYX8dqJ7M3AsY8xKCe+uAaV2e6SQq3r6g
 hKde6B3mghu1NHmhhq2cE1e9Yve+qou3acP5GcYOKOmJJUyS7LLGh1WTIkWn11jHF2vjVCJtkOS
 O5Pz5YWIXaHCXdjz9UJhEWc0wM1JckzXwzPLOYhTTa5aPGlR7cyuOSjm+XlpybuV0uHedScTbru
 WhDVSmbCAdN1w006n3Mdv+haxTXCkUnW8PzmVn+UBf
X-Gm-Gg: ASbGnctSkoMVFjXb9/DkEesHFPAc44NUNkxWD89Np8BawfUvdienhUFaCQHOk4/2ut4
 fTdPEkF3aT5eDKb3XSIQBpgo/kbZfvsET1xd5ZTS9eY40tob9yXfiadZqtgJjQGC9gpAPEKUq3R
 haWUT2BOVZd1EPWYSbSWo9iYAmtNScQsBNn4FgdTC2KSf9UmPATHJRDdLuwpiMWvlhMurwyaFTY
 qGbLF6nHFQwwqa6swBXou9FpcCEocjyvLYXaAPGFHYJ1o1fZClOobtsu+DHkGMYqeyWF5pYRzA7
 kBq3cysdGMqqsw==
X-Received: by 2002:a17:907:1ca3:b0:ad2:4b0c:ee8c with SMTP id
 a640c23a62f3a-adb322a519amr196938866b.35.1748592193817; 
 Fri, 30 May 2025 01:03:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEo1Hw4sjBjsj+Yc+BNtiU9OxmVUqqSMVhs3xXzI7t163AFUQEsY+/ECdsA3TBUxA2FYIjjnA==
X-Received: by 2002:a17:907:1ca3:b0:ad2:4b0c:ee8c with SMTP id
 a640c23a62f3a-adb322a519amr196935766b.35.1748592193362; 
 Fri, 30 May 2025 01:03:13 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada6ad3a6d7sm282708266b.155.2025.05.30.01.03.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 01:03:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 02/14] subprojects: add the foreign crate
Date: Fri, 30 May 2025 10:02:54 +0200
Message-ID: <20250530080307.2055502-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530080307.2055502-1-pbonzini@redhat.com>
References: <20250530080307.2055502-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This is a cleaned up and separated version of the patches at
https://lore.kernel.org/all/20240701145853.1394967-4-pbonzini@redhat.com/
https://lore.kernel.org/all/20240701145853.1394967-5-pbonzini@redhat.com/

Its first user will be the Error bindings; for example a QEMU Error ** can be
converted to a Rust Option using

     unsafe { Option::<Error>::from_foreign(c_error) }

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/meson.build                              |  2 ++
 rust/qemu-api/meson.build                     |  2 +-
 scripts/archive-source.sh                     |  3 ++-
 scripts/make-release                          |  3 ++-
 subprojects/.gitignore                        |  1 +
 subprojects/foreign-0.3-rs.wrap               |  7 +++++
 .../packagefiles/foreign-0.3-rs/meson.build   | 26 +++++++++++++++++++
 7 files changed, 41 insertions(+), 3 deletions(-)
 create mode 100644 subprojects/foreign-0.3-rs.wrap
 create mode 100644 subprojects/packagefiles/foreign-0.3-rs/meson.build

diff --git a/rust/meson.build b/rust/meson.build
index 6227e01f32a..59c7ed2736b 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -1,11 +1,13 @@
 subproject('anyhow-1-rs', required: true)
 subproject('bilge-0.2-rs', required: true)
 subproject('bilge-impl-0.2-rs', required: true)
+subproject('foreign-0.3-rs', required: true)
 subproject('libc-0.2-rs', required: true)
 
 anyhow_rs = dependency('anyhow-1-rs')
 bilge_rs = dependency('bilge-0.2-rs')
 bilge_impl_rs = dependency('bilge-impl-0.2-rs')
+foreign_rs = dependency('foreign-0.3-rs')
 libc_rs = dependency('libc-0.2-rs')
 
 subproject('proc-macro2-1-rs', required: true)
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 181ceca9536..aa22252866d 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -35,7 +35,7 @@ _qemu_api_rs = static_library(
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   rust_args: _qemu_api_cfg,
-  dependencies: [anyhow_rs, libc_rs, qemu_api_macros, qemuutil_rs,
+  dependencies: [anyhow_rs, foreign_rs, libc_rs, qemu_api_macros, qemuutil_rs,
                  qom, hwcore, chardev, migration],
 )
 
diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index 816062fee94..035828c532e 100755
--- a/scripts/archive-source.sh
+++ b/scripts/archive-source.sh
@@ -28,7 +28,8 @@ sub_file="${sub_tdir}/submodule.tar"
 # different to the host OS.
 subprojects="keycodemapdb libvfio-user berkeley-softfloat-3
   berkeley-testfloat-3 anyhow-1-rs arbitrary-int-1-rs bilge-0.2-rs
-  bilge-impl-0.2-rs either-1-rs itertools-0.11-rs libc-0.2-rs proc-macro2-1-rs
+  bilge-impl-0.2-rs either-1-rs foreign-0.3-rs itertools-0.11-rs
+  libc-0.2-rs proc-macro2-1-rs
   proc-macro-error-1-rs proc-macro-error-attr-1-rs quote-1-rs
   syn-2-rs unicode-ident-1-rs"
 sub_deinit=""
diff --git a/scripts/make-release b/scripts/make-release
index ea65bdcc0cf..4509a9fabf5 100755
--- a/scripts/make-release
+++ b/scripts/make-release
@@ -41,7 +41,8 @@ fi
 # Only include wraps that are invoked with subproject()
 SUBPROJECTS="libvfio-user keycodemapdb berkeley-softfloat-3
   berkeley-testfloat-3 anyhow-1-rs arbitrary-int-1-rs bilge-0.2-rs
-  bilge-impl-0.2-rs either-1-rs itertools-0.11-rs libc-0.2-rs proc-macro2-1-rs
+  bilge-impl-0.2-rs either-1-rs foreign-0.3-rs itertools-0.11-rs
+  libc-0.2-rs proc-macro2-1-rs
   proc-macro-error-1-rs proc-macro-error-attr-1-rs quote-1-rs
   syn-2-rs unicode-ident-1-rs"
 
diff --git a/subprojects/.gitignore b/subprojects/.gitignore
index b9ae507b85a..f4281934ce1 100644
--- a/subprojects/.gitignore
+++ b/subprojects/.gitignore
@@ -11,6 +11,7 @@
 /bilge-0.2.0
 /bilge-impl-0.2.0
 /either-1.12.0
+/foreign-0.3.1
 /itertools-0.11.0
 /libc-0.2.162
 /proc-macro-error-1.0.4
diff --git a/subprojects/foreign-0.3-rs.wrap b/subprojects/foreign-0.3-rs.wrap
new file mode 100644
index 00000000000..0d218ec2c25
--- /dev/null
+++ b/subprojects/foreign-0.3-rs.wrap
@@ -0,0 +1,7 @@
+[wrap-file]
+directory = foreign-0.3.1
+source_url = https://crates.io/api/v1/crates/foreign/0.3.1/download
+source_filename = foreign-0.3.1.tar.gz
+source_hash = 17ca1b5be8c9d320daf386f1809c7acc0cb09accbae795c2001953fa50585846
+#method = cargo
+patch_directory = foreign-0.3-rs
diff --git a/subprojects/packagefiles/foreign-0.3-rs/meson.build b/subprojects/packagefiles/foreign-0.3-rs/meson.build
new file mode 100644
index 00000000000..0901c02c527
--- /dev/null
+++ b/subprojects/packagefiles/foreign-0.3-rs/meson.build
@@ -0,0 +1,26 @@
+project('foreign-0.3-rs', 'rust',
+  meson_version: '>=1.5.0',
+  version: '0.2.0',
+  license: 'MIT OR Apache-2.0',
+  default_options: [])
+
+subproject('libc-0.2-rs', required: true)
+libc_rs = dependency('libc-0.2-rs')
+
+_foreign_rs = static_library(
+  'foreign',
+  files('src/lib.rs'),
+  gnu_symbol_visibility: 'hidden',
+  override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  rust_abi: 'rust',
+  rust_args: [
+    '--cap-lints', 'allow',
+  ],
+  dependencies: [libc_rs],
+)
+
+foreign_dep = declare_dependency(
+  link_with: _foreign_rs,
+)
+
+meson.override_dependency('foreign-0.3-rs', foreign_dep)
-- 
2.49.0


