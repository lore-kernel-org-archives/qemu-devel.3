Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA53ED1627C
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 14:37:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0MBr-0007pK-R9; Mon, 14 Oct 2024 10:36:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0MBp-0007o5-1I
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 10:36:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0MBm-000374-NU
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 10:36:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728916609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=UQed6wZr/5uUYxXbfe6GI/W0N+zNRwKCRN0TJ1osWQA=;
 b=Hi2kCVHYUdXxyeIdq+PK24ppCsvjBjXFfdX5JtniTkCrGdKUFbceSN4yWuPuuR4IAMmzCX
 FKhDv55Led9q5nUBNGVZXVK30N5zWzebpZgBSIpFPj0Ayr7rIdNL5qXxjVTxb25cexvT4c
 WRS/3k4pcufO/5Wnh/HyVJZV0uPRD7g=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-Pqvt5bwNOWWekGmBOi0x8w-1; Mon, 14 Oct 2024 10:36:45 -0400
X-MC-Unique: Pqvt5bwNOWWekGmBOi0x8w-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a99345b8a29so305112966b.3
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 07:36:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728916604; x=1729521404;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UQed6wZr/5uUYxXbfe6GI/W0N+zNRwKCRN0TJ1osWQA=;
 b=svTf7DmGRmmc8Wq3U6AXGthBtSV3LyBJjfYKnQ6oOKbzn6bCQQbxc41Kvg+DSqNB9l
 wEZuP1EVmBfKYhrjXQgQwi5NLfr5kwUWUEGCf9ReHWSxZ1glaik0PZmtKhyaZ36hnI5Z
 zzg6sfUuQUdAXs+w3otumllaCt6Kbg2IYEMDTjUSzJ97JwA8Tn8IqoA3gZpfdZwiY6rr
 RzCGznk8O1RUhGQANSfK2DlIlPyRauAZsrWIPRt9vu28D5K/yilzmwu0U+gf7FrEN4TE
 WX/GrZaJzcPFvhPm7TtBteFh5np5jjnVWFb8KNa2l7knMez45EVLBnV4p7A0HSeeGlbD
 umqg==
X-Gm-Message-State: AOJu0Yxrk+4FOHDX+3GNgUA0w4HrfCZcNsytNAm3wDz7CA0JCUvLU5Uh
 x1P2r3nm8YVsLHzbtDPUFGfdG8OYZ4xNo+S/O7rOIyhPS0/iNX2xhum22sBnooO2G6WdI5dDlsh
 gSzsHK7mVpFwRhxxVfpI18E/PFY84xEVpqF2LmCUIh6+SzZGm40STnNroh8juCdVzLOZnrBMcRV
 RGN++Y5fZ0BgM3LmICea9YKdiDsA83Tk09SShmBJY=
X-Received: by 2002:a17:906:dc91:b0:a9a:1253:4d81 with SMTP id
 a640c23a62f3a-a9a125350e2mr292501866b.47.1728916603963; 
 Mon, 14 Oct 2024 07:36:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtnFkAp7XXmeRzi5CB5/O8BVDAkW9C6mxrnNIfPCtR3V9zki1QwfPBDOgVc1XoWdHu0bvw5w==
X-Received: by 2002:a17:906:dc91:b0:a9a:1253:4d81 with SMTP id
 a640c23a62f3a-a9a125350e2mr292498966b.47.1728916603473; 
 Mon, 14 Oct 2024 07:36:43 -0700 (PDT)
Received: from avogadro.local ([151.81.124.37])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a0d9de967sm176176366b.139.2024.10.14.07.36.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 07:36:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] meson: check in main meson.build for native Rust compiler
Date: Mon, 14 Oct 2024 16:36:40 +0200
Message-ID: <20241014143640.196735-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.076,
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

A working native Rust compiler is always needed in order to compile Rust
code, even when cross compiling, in order to build the procedural macros
that QEMU uses.

Right now, the check is done in rust/qemu-api-macros/meson.build, but this
has two disadvantages.  First, it makes the build fail when the Meson "rust"
option is set to "auto" (instead, Rust support should be disabled).  Second,
add_languages() is one of the few functions that are executed even by
"meson introspect", except that "meson introspect" executes both branches
of "if" statements!  Therefore, "meson introspect" tries to look for a
Rust compiler even if the option is disabled---and then fails because
the compiler is required by rust/qemu-api-macros/meson.build.  This is
visible for example if the compilation host has a stale
scripts/meson-buildoptions.sh and no rustc installed.

Both issues can be fixed by moving the check to the main meson.build,
together with the check for the cross compiler.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
---
 meson.build                      | 3 ++-
 rust/qemu-api-macros/meson.build | 2 --
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/meson.build b/meson.build
index aecc381932d..c85f964bed4 100644
--- a/meson.build
+++ b/meson.build
@@ -71,7 +71,8 @@ if host_os == 'darwin' and \
   objc = meson.get_compiler('objc')
 endif
 have_rust = false
-if not get_option('rust').disabled() and add_languages('rust', required: get_option('rust'), native: false)
+if not get_option('rust').disabled() and add_languages('rust', required: get_option('rust'), native: false) \
+    and add_languages('rust', required: get_option('rust'), native: true)
   rustc = meson.get_compiler('rust')
   have_rust = true
   if rustc.version().version_compare('<1.80.0')
diff --git a/rust/qemu-api-macros/meson.build b/rust/qemu-api-macros/meson.build
index 48af91ed389..517b9a4d2d5 100644
--- a/rust/qemu-api-macros/meson.build
+++ b/rust/qemu-api-macros/meson.build
@@ -1,5 +1,3 @@
-add_languages('rust', required: true, native: true)
-
 quote_dep = dependency('quote-1-rs', native: true)
 syn_dep = dependency('syn-2-rs', native: true)
 proc_macro2_dep = dependency('proc-macro2-1-rs', native: true)
-- 
2.46.2


