Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8012CC5AD49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 14:27:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJYlo-00036N-Js; Mon, 26 May 2025 10:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uJYlH-0002st-UA
 for qemu-devel@nongnu.org; Mon, 26 May 2025 10:25:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uJYlF-0007eM-IR
 for qemu-devel@nongnu.org; Mon, 26 May 2025 10:25:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748269504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+T9glpjEX47g3WOojjbNPDPqDCh3tnGFrttxNbiujHQ=;
 b=IxDt0hHF1OXy5di6p/uflGEdKXynRJqorSY+GKHqS6B4UrNRZr2s9yesx3QQpRfXuBKnJ/
 VQfZzl/+DP24wHMfV50mhO43RCRa9M+VmH1mebZDOSXATNiFrlMKXEMSpklSffWLSx3nSV
 yKx/HK0QOMMMRL0jvvkVAR2KjNjXXE0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-ByKI_eBbNYKKQhXSmiPhqA-1; Mon, 26 May 2025 10:25:03 -0400
X-MC-Unique: ByKI_eBbNYKKQhXSmiPhqA-1
X-Mimecast-MFC-AGG-ID: ByKI_eBbNYKKQhXSmiPhqA_1748269502
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4dcfc375aso483287f8f.2
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 07:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748269501; x=1748874301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+T9glpjEX47g3WOojjbNPDPqDCh3tnGFrttxNbiujHQ=;
 b=eeiVHkSsXsyhyfWR4N6i1is85HNnfx3Q1FInSFClCNgJg9JUng2L5Onq6BHI8FX1hz
 PRq+s2VuIj2xx4p0nzUigJfz0hnal2147NxuoUCiym49O1J28qygONUh/Tj+bgE7IsgQ
 LHwkyEyRmSQ6cChDNLKop7tdI4LWcH4y19fK43hrnOtD3yTRRM7TAHWFyxDf1nyPzBHH
 k16eJ4zpcCLXI2IGKdJ+IAzSP3mNAlpRPdjoYI3Mks/2SlDvKlBCzlcQ2y8leFmw///K
 Zah56Coh/7052gm0vwt45DzLnvl3ZH7MLti+eyZ2KGlHCZzS1VLGCLr5vtaq+52eQR4k
 xHBg==
X-Gm-Message-State: AOJu0YwHnfGVm/F4h4e1b3L6nRrJHEmo0WXTfuUgl74yKSEizx1ieDKb
 VtmDqtO/T5tr3vRtLRk3jZ/5sDAZIIGwoF/CKcx4ms6zkFTvoOgC0HxtfhK9Wj56Q2PLhe6xC15
 bOhH8h3zDfmFtyay4unJDACVYRN4DQPl8dgIgdaXOF2JDOzSLoFYQcWZNvA/jKV2FMALf648JJC
 IymmROusj4HVD6HpcCp+1GrSZtOmpR9I6AFwvXHTVx
X-Gm-Gg: ASbGncvqP9ubQcC+7x5Rg+lntb7MRTshYs9jJJROTwxIv0OXMWttxkmSM6HYHk4LZdo
 ZNk4EQjQSqLdxCgp2doqEOZfQnYtmbCnt/fd8NeaPeyv3KydtEWA11G1Cv8OU7zQGTUuMHzy/C9
 QBbLfxfdy5cGvS70+Nme8ctxtquevc7YykzWee0CI+b7Hvis/bzQ/wVTTMGt6XXVRlgoRqwe9eF
 f/rGv+OU4eJDvey/8if18sSPdR0YjMJDE2IuNPQWe6rpKEFNgkxNYDLSYA/tQcAmoy0lFJbZtqt
 wd5FaaP9SHjLwA==
X-Received: by 2002:a05:6000:1acf:b0:3a4:d673:af99 with SMTP id
 ffacd0b85a97d-3a4d673b308mr4283106f8f.34.1748269500940; 
 Mon, 26 May 2025 07:25:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdsCsEnCabdybaCJBP9FTQqrtBIVUrIopHGY08La5svZwRuDtC7+BJvTHxPAMgeGSq9neeWg==
X-Received: by 2002:a05:6000:1acf:b0:3a4:d673:af99 with SMTP id
 ffacd0b85a97d-3a4d673b308mr4283078f8f.34.1748269500452; 
 Mon, 26 May 2025 07:25:00 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.46.79])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4cd0cf5c0sm7696043f8f.12.2025.05.26.07.24.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 07:24:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com,
	qemu-rust@nongnu.org
Subject: [PATCH 02/12] subprojects: add the anyhow crate
Date: Mon, 26 May 2025 16:24:45 +0200
Message-ID: <20250526142455.1061519-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250526142254.1061009-1-pbonzini@redhat.com>
References: <20250526142254.1061009-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
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

This is a standard replacement for Box<dyn Error> which is more efficient (it only
occcupies one word) and provides a backtrace of the error.  This could be plumbed
into &error_abort in the future.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/meson.build                              |  2 ++
 subprojects/.gitignore                        |  1 +
 subprojects/anyhow-1.0-rs.wrap                |  7 ++++
 .../packagefiles/anyhow-1.0-rs/meson.build    | 33 +++++++++++++++++++
 4 files changed, 43 insertions(+)
 create mode 100644 subprojects/anyhow-1.0-rs.wrap
 create mode 100644 subprojects/packagefiles/anyhow-1.0-rs/meson.build

diff --git a/rust/meson.build b/rust/meson.build
index 1f0dcce7d04..3e0b6ed4afa 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -1,7 +1,9 @@
+subproject('anyhow-1.0-rs', required: true)
 subproject('bilge-0.2-rs', required: true)
 subproject('bilge-impl-0.2-rs', required: true)
 subproject('libc-0.2-rs', required: true)
 
+anyhow_rs = dependency('anyhow-1.0-rs')
 bilge_rs = dependency('bilge-0.2-rs')
 bilge_impl_rs = dependency('bilge-impl-0.2-rs')
 libc_rs = dependency('libc-0.2-rs')
diff --git a/subprojects/.gitignore b/subprojects/.gitignore
index d12d34618cc..b9ae507b85a 100644
--- a/subprojects/.gitignore
+++ b/subprojects/.gitignore
@@ -6,6 +6,7 @@
 /keycodemapdb
 /libvfio-user
 /slirp
+/anyhow-1.0.98
 /arbitrary-int-1.2.7
 /bilge-0.2.0
 /bilge-impl-0.2.0
diff --git a/subprojects/anyhow-1.0-rs.wrap b/subprojects/anyhow-1.0-rs.wrap
new file mode 100644
index 00000000000..53f20b2a315
--- /dev/null
+++ b/subprojects/anyhow-1.0-rs.wrap
@@ -0,0 +1,7 @@
+[wrap-file]
+directory = anyhow-1.0.98
+source_url = https://crates.io/api/v1/crates/anyhow/1.0.98/download
+source_filename = anyhow-1.0.98.tar.gz
+source_hash = e16d2d3311acee920a9eb8d33b8cbc1787ce4a264e85f964c2404b969bdcd487
+#method = cargo
+patch_directory = anyhow-1.0-rs
diff --git a/subprojects/packagefiles/anyhow-1.0-rs/meson.build b/subprojects/packagefiles/anyhow-1.0-rs/meson.build
new file mode 100644
index 00000000000..67278c25af9
--- /dev/null
+++ b/subprojects/packagefiles/anyhow-1.0-rs/meson.build
@@ -0,0 +1,33 @@
+project('anyhow-1.0-rs', 'rust',
+  meson_version: '>=1.5.0',
+  version: '1.0.98',
+  license: 'MIT OR Apache-2.0',
+  default_options: [])
+
+rustc = meson.get_compiler('rust')
+
+rust_args = ['--cap-lints', 'allow']
+rust_args += ['--cfg', 'feature="std"']
+if rustc.version().version_compare('<1.65.0')
+  error('rustc version ' + rustc.version() + ' is unsupported. Please upgrade to at least 1.65.0')
+endif
+rust_args += [ '--cfg', 'std_backtrace' ] # >= 1.65.0
+if rustc.version().version_compare('<1.81.0')
+  rust_args += [ '--cfg', 'anyhow_no_core_error' ]
+endif
+
+_anyhow_rs = static_library(
+  'anyhow',
+  files('src/lib.rs'),
+  gnu_symbol_visibility: 'hidden',
+  override_options: ['rust_std=2018', 'build.rust_std=2018'],
+  rust_abi: 'rust',
+  rust_args: rust_args,
+  dependencies: [],
+)
+
+anyhow_dep = declare_dependency(
+  link_with: _anyhow_rs,
+)
+
+meson.override_dependency('anyhow-1.0-rs', anyhow_dep)
-- 
2.49.0


