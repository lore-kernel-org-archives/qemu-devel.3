Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 079FCC54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 14:27:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJYlo-00036g-Px; Mon, 26 May 2025 10:25:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uJYlL-0002u7-9a
 for qemu-devel@nongnu.org; Mon, 26 May 2025 10:25:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uJYlI-0007pX-TL
 for qemu-devel@nongnu.org; Mon, 26 May 2025 10:25:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748269507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KlCPu9vrL2ikpJGmpcQeDNOSLxpS9BRUCw1rNrAFygE=;
 b=MMWomK+0QtdnPL1XjwYShB79j5Dl68dXZdb2B3Q5CiyFA8M0e5Erq0JlZcAJoHU781dXNb
 xXMHDnbMhUfHcoQuHahmW4wgzt8/gUkHkf4Z0hj7Hzds9vbgqU64/J1ym3Yx3xsboqhbkh
 14LbclYoHyUPdhN+ZCHQYHkQaqWyxY0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-Yo0ZvqRxPcynihROrzKY1A-1; Mon, 26 May 2025 10:25:06 -0400
X-MC-Unique: Yo0ZvqRxPcynihROrzKY1A-1
X-Mimecast-MFC-AGG-ID: Yo0ZvqRxPcynihROrzKY1A_1748269505
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43d5ca7c86aso14254435e9.0
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 07:25:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748269504; x=1748874304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KlCPu9vrL2ikpJGmpcQeDNOSLxpS9BRUCw1rNrAFygE=;
 b=TsyzR8jLuGJRblffGma8Pb5YGzgEXCHv9MhD2/KqUEyJocDphSbiFa53LnuvDWNh4p
 dTkaKeVJ1WhgMYiPlcwQ9q+4KQZNQBYzEnCFnSieqmlPD/glnD09mKHM9LnJ3zFn8PE9
 PqimmS4JHzNXnmvRWe47kRJxwHHKwvR3YOBTN2EaRgwSjz/CYRXH86e92lUOrPRVAXfv
 jw63VO6QbJDR8un1Ukz6lTd42wLfewnKdzrZ7GTG7GtOiwpombSmbK4NhW/AX4JYF1eu
 faBfVN5TToZ3Emr7WwjfuCL68ovTgD1hbqyQ3DtPL2akPDwyiSs1WIefFARRCKSMxwgv
 gjqQ==
X-Gm-Message-State: AOJu0YwP6l8Do/h64kff303hqGCbLQZ0TtMjeCZmzSgdpNWkibWJ4a/P
 wcjfF9LArf+OWufSil+QZ1toSUnjhjmlQ1Eqq7ye6tssD0PVElEXBQ9SLbiPmmi4q2F0Tw/ENfG
 bM/pmmQPIQ3Wf6bEvabCbmZ2Ygm4034Zj7Uj41hd/2LTiDWe5QsbTFhXpJG5/c0e2S6DUBYcfwx
 vvX+bYiF8t3Zb9MdRiSFeMN64NRCWMrU/5UuDZS9ci
X-Gm-Gg: ASbGnctY3+ccGYm0jwAl4LcM0/sFAlmfLeIeVvG6g11N9eSJwVD/Vfh8/J12m+b+XBx
 3Te7Vc58prXcckUH3r1Ff3iSMQyqDIHQKAiAC6Bmh4rEod0EVVQoR1WCtf1O20lBJAJauvY2b7O
 vqJj7mYsUDfMhD229MkLmPNohPKmPujJVOGRp8xel4H1WYP7uUv4f+0I/je2CCXzgXCS5xHXy9S
 x/Ao0or+pUkb6ATi/BdeOUGHH+/CmyKn4JD1oOSfwqFJxCT1PV6NTWGkYq5mBJoQCiz1ozF/JR4
 cV+p9oC129cMxg==
X-Received: by 2002:a05:600c:1388:b0:442:f4a3:b5f2 with SMTP id
 5b1f17b1804b1-44c916fc5efmr79230845e9.6.1748269503827; 
 Mon, 26 May 2025 07:25:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaP6wuLhtodH0ZREfjb81Kkt7FnQnrzkJlWD9VkcNaZufp6drsy9MAwkt5vJkaAXcevIcXYg==
X-Received: by 2002:a05:600c:1388:b0:442:f4a3:b5f2 with SMTP id
 5b1f17b1804b1-44c916fc5efmr79230565e9.6.1748269503357; 
 Mon, 26 May 2025 07:25:03 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.46.79])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f23c080asm246606405e9.22.2025.05.26.07.25.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 07:25:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com,
	qemu-rust@nongnu.org
Subject: [PATCH 03/12] subprojects: add the foreign crate
Date: Mon, 26 May 2025 16:24:46 +0200
Message-ID: <20250526142455.1061519-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250526142254.1061009-1-pbonzini@redhat.com>
References: <20250526142254.1061009-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
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

This is a cleaned up and separated version of the patches at
https://lore.kernel.org/all/20240701145853.1394967-4-pbonzini@redhat.com/
https://lore.kernel.org/all/20240701145853.1394967-5-pbonzini@redhat.com/

Its first user will be the Error bindings; for example a QEMU Error ** can be
converted to a Rust Option using

     unsafe { Option::<Error>::from_foreign(c_error) }

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 subprojects/.gitignore                        |  1 +
 subprojects/foreign-0.2-rs.wrap               |  7 +++++
 .../packagefiles/foreign-0.2-rs/meson.build   | 26 +++++++++++++++++++
 3 files changed, 34 insertions(+)
 create mode 100644 subprojects/foreign-0.2-rs.wrap
 create mode 100644 subprojects/packagefiles/foreign-0.2-rs/meson.build

diff --git a/subprojects/.gitignore b/subprojects/.gitignore
index b9ae507b85a..7b38c4f6281 100644
--- a/subprojects/.gitignore
+++ b/subprojects/.gitignore
@@ -11,6 +11,7 @@
 /bilge-0.2.0
 /bilge-impl-0.2.0
 /either-1.12.0
+/foreign-0.2.0
 /itertools-0.11.0
 /libc-0.2.162
 /proc-macro-error-1.0.4
diff --git a/subprojects/foreign-0.2-rs.wrap b/subprojects/foreign-0.2-rs.wrap
new file mode 100644
index 00000000000..bf3cab9407a
--- /dev/null
+++ b/subprojects/foreign-0.2-rs.wrap
@@ -0,0 +1,7 @@
+[wrap-file]
+directory = foreign-0.2.0
+source_url = https://crates.io/api/v1/crates/foreign/0.2.0/download
+source_filename = foreign-0.2.0.tar.gz
+source_hash = 37dd09e47ea8fd592a333f59fc52b894a97fe966ae9c6b7ef21ae38de6043462
+#method = cargo
+patch_directory = foreign-0.2-rs
diff --git a/subprojects/packagefiles/foreign-0.2-rs/meson.build b/subprojects/packagefiles/foreign-0.2-rs/meson.build
new file mode 100644
index 00000000000..56b835d3ba9
--- /dev/null
+++ b/subprojects/packagefiles/foreign-0.2-rs/meson.build
@@ -0,0 +1,26 @@
+project('foreign-0.2-rs', 'rust',
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
+meson.override_dependency('foreign-0.2-rs', foreign_dep)
-- 
2.49.0


