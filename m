Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 882A9CCA474
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 07:51:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3rb5-0003bR-MN; Wed, 01 Oct 2025 03:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3rb0-0003a1-UD
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:49:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3rah-00022C-9o
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:49:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759304968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a+a3SkOF45yE4vyVlAzQd9o/NhWWYLj+iXonbBYLEkA=;
 b=Dm46dqWp7mENNdidn5DxpYzrgk86SXWRj/wEz6jxZX5ZLIRKxtjZt3x9AWPmDwPOas3aWr
 wk/odEmzJMrRXAM6YRUfFpnB0XiGiS2YdjlRQTd7lTqm3Sr0F6u4KWvfBwkqhhhhc73oMP
 ll4BQ1xmJBPOt3n4Ews1bZ9k7D9hfxU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-lp1_MfxeOVCwczWgnCbwtw-1; Wed, 01 Oct 2025 03:49:27 -0400
X-MC-Unique: lp1_MfxeOVCwczWgnCbwtw-1
X-Mimecast-MFC-AGG-ID: lp1_MfxeOVCwczWgnCbwtw_1759304966
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b3a879bd254so66414766b.0
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 00:49:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759304965; x=1759909765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a+a3SkOF45yE4vyVlAzQd9o/NhWWYLj+iXonbBYLEkA=;
 b=YD4UxR0HLtVT6DAHWtIH5OoJfcEZFJMl0pbScz+2OTrWgh0D0/3R4xkIKhVJuxMsYt
 jP08KaJf0H/GxYlm7FJyS2nGOeuYpLrh8icI0Ea3SvyWrsDIuntplw2YpgFec9hsyFEz
 fo2eoWKDnA7eNnPrB4NAeFUbNUdTGJ0ERb2U5L4UlK+vfdJP2OY9PChdvHI6FtVjsURw
 0ItTMdioW4EDP93QcGRRV7qlmqfRr2/K5DnYUWm8ZiLK3njPJBZSstlIcXbKveNRldyH
 jUYFA4AIljrwlnOSHJQwp0NkMOK/3wCpYmr0DFYA/kYV6qPCaKOkS6yFYyxijnNJIrDA
 MBQg==
X-Gm-Message-State: AOJu0YxK8jeijeksQ4UxA5KGT7PutJCz0kLve2O6jXxFYEWB+5zUcleB
 F6VcP6JZtVAq1V0lzb5B7U3W5mgwk6PYrGmvQ59E2J+LIbJH/CPoqAmdZVm6UZMnHmcDD7nP1g9
 nNEMykuo/VjP0KlNnnKCVnzHqGv2388jSm1rnOdvyo1K8fBV7b7urK82oZM3RBjg0mWLUIy9peR
 RoTvEbBO3IGhHYb60PdXewUhrMu+fAUYCs8SHwBI36
X-Gm-Gg: ASbGncuxmndBf3lVCLGTtb4OTpN0NG4f3dIh4DAYy6R+0WOf1f/dbckIz37Mifl6LNY
 HY7ODnWo348Ho8UXLd7M5a+kflxsLZu0yYNsJqZvrYHRsGkadhfsfH+zijnG26tGIFNnpO5SdRw
 Ejmpgl7k+NyjB1mfajGPHtK3hZGiXQQhfTnOl1Gqgk06ItH2HXjVeYsKoUa6D99zVZuLthMEEN7
 iF0AS/MDk/Sb2PTbI1Sk2GXtqzFrfAA5GCC5obhHE3cqojDonEsP7xIvbCmUvAR1mq29V+VLBnb
 pi6tJS+IK1tOBCGyL3gQ6L7emGcLr3AxBpeKQJ/TbEiQzpd3LiJHktYB5HaaZAunMXScY+TThBM
 VEXzic26XHAoGRzGO8kwFuGrgMfKXPd3EdwvIb7fGnJ7BYSeTNF4=
X-Received: by 2002:a17:907:948a:b0:b41:297c:f7bb with SMTP id
 a640c23a62f3a-b46e5d3b644mr280968366b.26.1759304965269; 
 Wed, 01 Oct 2025 00:49:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9eh0Y9KEwi+78oQ6L4wKLXfLinoboNrDsysQ8eu2Vb/VARWmjefkGL9XfDfMLcZ5zCaJjqA==
X-Received: by 2002:a17:907:948a:b0:b41:297c:f7bb with SMTP id
 a640c23a62f3a-b46e5d3b644mr280965166b.26.1759304964716; 
 Wed, 01 Oct 2025 00:49:24 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-634a3629badsm10969666a12.9.2025.10.01.00.49.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 00:49:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 1/2] subprojects: add glib-sys-rs
Date: Wed,  1 Oct 2025 09:49:19 +0200
Message-ID: <20251001074920.1041619-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001074920.1041619-1-pbonzini@redhat.com>
References: <20251001074920.1041619-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/meson.build                              |  2 ++
 scripts/archive-source.sh                     |  1 +
 subprojects/.gitignore                        |  1 +
 subprojects/glib-sys-0.21-rs.wrap             |  7 ++++
 .../packagefiles/glib-sys-0.21-rs/meson.build | 33 +++++++++++++++++++
 5 files changed, 44 insertions(+)
 create mode 100644 subprojects/glib-sys-0.21-rs.wrap
 create mode 100644 subprojects/packagefiles/glib-sys-0.21-rs/meson.build

diff --git a/rust/meson.build b/rust/meson.build
index 7fd857215b0..76e10699b37 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -2,12 +2,14 @@ subproject('anyhow-1-rs', required: true)
 subproject('bilge-0.2-rs', required: true)
 subproject('bilge-impl-0.2-rs', required: true)
 subproject('foreign-0.3-rs', required: true)
+subproject('glib-sys-0.21-rs', required: true)
 subproject('libc-0.2-rs', required: true)
 
 anyhow_rs = dependency('anyhow-1-rs')
 bilge_rs = dependency('bilge-0.2-rs')
 bilge_impl_rs = dependency('bilge-impl-0.2-rs')
 foreign_rs = dependency('foreign-0.3-rs')
+glib_sys_rs = dependency('glib-sys-0.21-rs')
 libc_rs = dependency('libc-0.2-rs')
 
 subproject('proc-macro2-1-rs', required: true)
diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index a725dd923dc..8f97b19a088 100755
--- a/scripts/archive-source.sh
+++ b/scripts/archive-source.sh
@@ -36,6 +36,7 @@ subprojects=(
   bilge-impl-0.2-rs
   either-1-rs
   foreign-0.3-rs
+  glib-sys-0.21-rs
   itertools-0.11-rs
   keycodemapdb
   libc-0.2-rs
diff --git a/subprojects/.gitignore b/subprojects/.gitignore
index 0b5d9634094..c00c8478372 100644
--- a/subprojects/.gitignore
+++ b/subprojects/.gitignore
@@ -13,6 +13,7 @@
 /bilge-impl-*
 /either-*
 /foreign-*
+/glib-sys-*
 /itertools-*
 /libc-*
 /proc-macro-error-*
diff --git a/subprojects/glib-sys-0.21-rs.wrap b/subprojects/glib-sys-0.21-rs.wrap
new file mode 100644
index 00000000000..313ced731ac
--- /dev/null
+++ b/subprojects/glib-sys-0.21-rs.wrap
@@ -0,0 +1,7 @@
+[wrap-file]
+directory = glib-sys-0.21.2
+source_url = https://crates.io/api/v1/crates/glib-sys/0.21.2/download
+source_filename = glib-sys-0.21.2.tar.gz
+source_hash = d09d3d0fddf7239521674e57b0465dfbd844632fec54f059f7f56112e3f927e1
+#method = cargo
+patch_directory = glib-sys-0.21-rs
diff --git a/subprojects/packagefiles/glib-sys-0.21-rs/meson.build b/subprojects/packagefiles/glib-sys-0.21-rs/meson.build
new file mode 100644
index 00000000000..8c5483311ed
--- /dev/null
+++ b/subprojects/packagefiles/glib-sys-0.21-rs/meson.build
@@ -0,0 +1,33 @@
+project('glib-sys-0.21-rs', 'rust',
+  meson_version: '>=1.5.0',
+  version: '0.21.2',
+  license: 'MIT',
+  default_options: [])
+
+subproject('libc-0.2-rs', required: true)
+libc_rs = dependency('libc-0.2-rs')
+
+_glib_sys_rs = static_library(
+  'glib_sys',
+  files('src/lib.rs'),
+  gnu_symbol_visibility: 'hidden',
+  override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  rust_abi: 'rust',
+  rust_args: [
+    '--cap-lints', 'allow',
+    '--cfg', 'feature="v2_66"',
+    '--cfg', 'feature="v2_64"',
+    '--cfg', 'feature="v2_62"',
+    '--cfg', 'feature="v2_60"',
+    '--cfg', 'feature="v2_58"',
+  ],
+  # should also link with glib; don't bother doing it here since all
+  # QEMU targets have it
+  dependencies: [libc_rs],
+)
+
+glib_sys_dep = declare_dependency(
+  link_with: _glib_sys_rs,
+)
+
+meson.override_dependency('glib-sys-0.21-rs', glib_sys_dep)
-- 
2.51.0


