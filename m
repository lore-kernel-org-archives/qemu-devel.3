Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB1ABC369A1
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 10:07:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u10Pn-00075e-T4; Sat, 05 Apr 2025 06:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u10Pm-00075V-Pv
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 06:06:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u10Pl-0005rc-2G
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 06:06:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743847572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N+I/N/OFa/M4oooPCwQgNfIF7q6n2ZVwrbiN07nAWzU=;
 b=EzhgduZygnk5ilMVj8PlwLhsAsHlMsiDBM30JgbZBh5+0kRMvsZ2fsP4gO9wGcOfbxYY7/
 PQLD+48rles5oHWHsuYvsldikcNRkMB8QdvtT8+SVBS6tZQc+wO0N7cSnRrBTyQND3A23a
 uFAyZMfDaACfj2xAqWyYgJ7lysxHsfU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-AgvmXQnoMvKz3jrQGmO4Cg-1; Sat, 05 Apr 2025 06:06:10 -0400
X-MC-Unique: AgvmXQnoMvKz3jrQGmO4Cg-1
X-Mimecast-MFC-AGG-ID: AgvmXQnoMvKz3jrQGmO4Cg_1743847569
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43cf3168b87so15650745e9.2
 for <qemu-devel@nongnu.org>; Sat, 05 Apr 2025 03:06:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743847568; x=1744452368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N+I/N/OFa/M4oooPCwQgNfIF7q6n2ZVwrbiN07nAWzU=;
 b=f5TZvMYGzgJNBbIsC3C0Ng/Zr3yBocDncIlXGFUfcw15KLFiNsA0XkV52UiEhRtQgH
 f6zyxNI1PXsDTCNjl02yuWNi6lopVZJlVJH9C6j61QIR3XNE4dScIzRO9Qb6Um4bh07K
 clutDfc/9zNwBpdJbdZ7YAsKxTYsBa4geR78zNEHMaKlYZOXSpXAuGqMmoeW/72Tsc5T
 RB62bl5CGbnhdBsdLVOUIxt+5wr2IK5OtmFwdb2QiS7JDMSvTYBnUDbgxd6YetUFd0OJ
 OBPdA2Rn2GcxA7DJ0ogXIP6smlv/HZxC4A1UH7wgn/dSD7DJORSTGjdcbgxeVBALhK8A
 r1dA==
X-Gm-Message-State: AOJu0YzeSW6JCv23yEN++lDX5UAhgdoPO/3CtTYsk/98QniSwwfDA1fd
 mflWkGlAU4WGSMTkDseDlcBOCxQ4NBtJ5h9R/WM9bjTIsJc2DKsIksuk5GZh7dE5Rz1LOOfgvCI
 +Maxkkd7NdLbUyS3x84yhFWTMV3kzxNYaVm43O8P9bqBioqzF3tjN18EKTETCOXZfY7t7Crlnel
 YuihsCpsopYoEfXxsW9vl90LrnhE+7ZfpumKJI
X-Gm-Gg: ASbGncuiSzVEhz1MXtF0EA6sA+WGPQqBm6n4Q/rAtrED2pmHlDUctc57Kwduhc4N0bh
 Rb4BDuV+9N/eGT03UfybBkGD9Wz5qinyDCG2wrUAJxHA6u5r4IByrITWwbUho/vNMUTGCP+3o3I
 wvL2t0fRnZH7BhYZx+/eU9Wf/pbmM6kj5+7s7Aiym+6ScOpftcsg9G2cb+WnT6PYY9GcOipFSPV
 +8EzAfd10sZPIgQvtheBJ3EtLuJpyIKas8w6Ex1jmcWF6c4uQX6ssbmhKLMthgc7TAOXQ+gjWbO
 zdb3QgO742z1R4pKQA==
X-Received: by 2002:a05:6000:1a88:b0:391:47d8:de3a with SMTP id
 ffacd0b85a97d-39cba97f7d5mr4825689f8f.53.1743847568230; 
 Sat, 05 Apr 2025 03:06:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHCm7MXfcr3yOniTaQPTwQ9J+ba3OZYa5N8/P9p1ALElQ5MQSeGBgL/hWHUf+wR5hVYgK/fA==
X-Received: by 2002:a05:6000:1a88:b0:391:47d8:de3a with SMTP id
 ffacd0b85a97d-39cba97f7d5mr4825670f8f.53.1743847567777; 
 Sat, 05 Apr 2025 03:06:07 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.96.77])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c3020d5d1sm6554233f8f.77.2025.04.05.03.06.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Apr 2025 03:06:06 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 1/3] rust: use "objects" for Rust executables as well
Date: Sat,  5 Apr 2025 12:06:01 +0200
Message-ID: <20250405100603.253421-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250405100603.253421-1-pbonzini@redhat.com>
References: <20250405100603.253421-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.028,
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

libqemuutil is not meant be linked as a whole; if modules are enabled, doing
so results in undefined symbols (corresponding to QMP commands) in
rust/qemu-api/rust-qemu-api-integration.

Support for "objects" in Rust executables is available in Meson 1.8.0; use it
to switching to the same dependencies that C targets use: link_with for
libqemuutil, and objects for everything else.

Reported-by: Bernhard Beschow <shentey@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/rust.rst       |  2 --
 rust/qemu-api/meson.build | 26 +++++---------------------
 2 files changed, 5 insertions(+), 23 deletions(-)

diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index 88bdec1eb28..8030aa42d0c 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -66,8 +66,6 @@ be run via ``meson test`` or ``make``::
 
    make check-rust
 
-Building Rust code with ``--enable-modules`` is not supported yet.
-
 Supported tools
 '''''''''''''''
 
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 858685ddd4a..8fa41c0a95e 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -45,29 +45,13 @@ _qemu_api_rs = static_library(
   dependencies: [libc_dep, qemu_api_macros],
 )
 
+qemuutil_rs = qemuutil.partial_dependency(link_args: true, links: true)
+
 rust.test('rust-qemu-api-tests', _qemu_api_rs,
           suite: ['unit', 'rust'])
 
-qemu_api = declare_dependency(link_with: _qemu_api_rs)
-
-# Rust executables do not support objects, so add an intermediate step.
-rust_qemu_api_objs = static_library(
-    'rust_qemu_api_objs',
-    objects: [libqom.extract_all_objects(recursive: false),
-              libhwcore.extract_all_objects(recursive: false),
-              libchardev.extract_all_objects(recursive: false),
-              libcrypto.extract_all_objects(recursive: false),
-              libauthz.extract_all_objects(recursive: false),
-              libio.extract_all_objects(recursive: false),
-              libmigration.extract_all_objects(recursive: false)])
-rust_qemu_api_deps = declare_dependency(
-    dependencies: [
-      qom_ss.dependencies(),
-      chardev_ss.dependencies(),
-      crypto_ss.dependencies(),
-      authz_ss.dependencies(),
-      io_ss.dependencies()],
-    link_whole: [rust_qemu_api_objs, libqemuutil])
+qemu_api = declare_dependency(link_with: [_qemu_api_rs],
+  dependencies: [qemuutil_rs, qemu_api_macros, qom, hwcore, chardev, migration])
 
 test('rust-qemu-api-integration',
     executable(
@@ -76,7 +60,7 @@ test('rust-qemu-api-integration',
         override_options: ['rust_std=2021', 'build.rust_std=2021'],
         rust_args: ['--test'],
         install: false,
-        dependencies: [qemu_api, qemu_api_macros, rust_qemu_api_deps]),
+        dependencies: qemu_api),
     args: [
         '--test', '--test-threads', '1',
         '--format', 'pretty',
-- 
2.49.0


