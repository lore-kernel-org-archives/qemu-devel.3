Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E21EC30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 09:58:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPJET-0006U8-UF; Thu, 04 Jul 2024 05:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sPJER-0006TZ-TQ
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 05:58:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sPJEO-00086Q-Fz
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 05:58:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720087102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ftuQ4unRB23Fci4M9jLES3wu11vR3TI62r9geNdaT0Q=;
 b=ODpy22afaifsnuRK+cSw4VT/5DjoBpZFVOeWLn8rO0nJr5Unk84Z5nQ4nuseHrtzJL0p1o
 88dxZakWa98p006J8blGqt7/beuLP10BnjhRkezWcsftpfBKUAbCniBDrGNveskGx5S8zf
 3KU8UAVf0smFwtUzkoVo+eq4BbNIxbg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-Q2HOxy_cMq64Dz4KrlPQFA-1; Thu, 04 Jul 2024 05:58:21 -0400
X-MC-Unique: Q2HOxy_cMq64Dz4KrlPQFA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42648daf064so2825065e9.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 02:58:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720087099; x=1720691899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ftuQ4unRB23Fci4M9jLES3wu11vR3TI62r9geNdaT0Q=;
 b=ioyX3VT2xr/xj52W3c7HkMW6NvsKrnETSyo3tnm1Gxny7DayfsxeN7VNElHo28mAIb
 tqqK5VB22OIyhONUQlEC4GW7MVcuCF6qSiZ5UIS7C63+afQjEjY/6kXm9pw5Ik2b7U4j
 USs+XSEY6ObYRN5X5PfFD/9c99WnXwf+AuMQc2orWdILAQ+p1sVemLnPvRgv9hmvQ2LM
 AMxN/Us1D6DVDO6TLGTdXLeVc9cxmYqZDNBP1FLDvWpzgz2xnaqA9fFGSQByo+9sZXPk
 mvtXnm+WjVUVd4A7WX4AwEDMbs3eCYaICoPb3VBP+bL7mgBrtV1ZPorIIJ99zWzXWGaT
 cOeA==
X-Gm-Message-State: AOJu0YydFb4LWFyxdb+75O56XVxyi7o/z1xNfXKnxkb7jEuVCdDFqEHu
 /EaxjjcI0yF44P5Djxms2wEUhi5CyF6zZqcrN3o1sRlqvgBQX5UPde7+x8g11+GBNzCEdPka5tI
 3Lq0668MnhRWCdc/t8cSYzyhPScMX0zVzKDeTd0Ilv2YcjXR3kY8ocF7FoLujaYcvAA+4U8UedV
 8nqLnxHZQebz2nRUDaTFs0zvn089Uu65qTiUEE
X-Received: by 2002:a05:600c:5247:b0:424:8836:310c with SMTP id
 5b1f17b1804b1-4264b120ba7mr10008105e9.5.1720087099417; 
 Thu, 04 Jul 2024 02:58:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9qfNF44ZlrM3VfYBFZarx8FgymTNGZ6IsRHabL3NC7htXnb/mhYKDgA0JId0K25faBGPldg==
X-Received: by 2002:a05:600c:5247:b0:424:8836:310c with SMTP id
 5b1f17b1804b1-4264b120ba7mr10007965e9.5.1720087099081; 
 Thu, 04 Jul 2024 02:58:19 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a21cbb7sm17814915e9.26.2024.07.04.02.58.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 02:58:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PULL 05/16] Revert "meson: Propagate gnutls dependency"
Date: Thu,  4 Jul 2024 11:57:55 +0200
Message-ID: <20240704095806.1780273-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704095806.1780273-1-pbonzini@redhat.com>
References: <20240704095806.1780273-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

This reverts commit 3eacf70bb5a83e4775ad8003cbca63a40f70c8c2.

It was only needed because of duplicate objects caused by
declare_dependency(link_whole: ...), and can be dropped now
that meson.build specifies objects and dependencies separately
for the internal dependencies.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <20240524-objects-v1-2-07cbbe96166b@daynix.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                | 4 ++--
 block/meson.build          | 2 +-
 io/meson.build             | 2 +-
 storage-daemon/meson.build | 2 +-
 ui/meson.build             | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/meson.build b/meson.build
index 0c314ae5701..429899d8603 100644
--- a/meson.build
+++ b/meson.build
@@ -3526,7 +3526,7 @@ if have_block
     'blockdev-nbd.c',
     'iothread.c',
     'job-qmp.c',
-  ), gnutls)
+  ))
 
   # os-posix.c contains POSIX-specific functions used by qemu-storage-daemon,
   # os-win32.c does not
@@ -4044,7 +4044,7 @@ if have_tools
              dependencies: [block, qemuutil], install: true)
   qemu_nbd = executable('qemu-nbd', files('qemu-nbd.c'),
                link_args: '@block.syms', link_depends: block_syms,
-               dependencies: [blockdev, qemuutil, gnutls, selinux],
+               dependencies: [blockdev, qemuutil, selinux],
                install: true)
 
   subdir('storage-daemon')
diff --git a/block/meson.build b/block/meson.build
index 158dc3b89db..f1262ec2ba8 100644
--- a/block/meson.build
+++ b/block/meson.build
@@ -39,7 +39,7 @@ block_ss.add(files(
   'throttle.c',
   'throttle-groups.c',
   'write-threshold.c',
-), zstd, zlib, gnutls)
+), zstd, zlib)
 
 system_ss.add(when: 'CONFIG_TCG', if_true: files('blkreplay.c'))
 system_ss.add(files('block-ram-registrar.c'))
diff --git a/io/meson.build b/io/meson.build
index 283b9b2bdbd..1164812f912 100644
--- a/io/meson.build
+++ b/io/meson.build
@@ -13,4 +13,4 @@ io_ss.add(files(
   'dns-resolver.c',
   'net-listener.c',
   'task.c',
-), gnutls)
+))
diff --git a/storage-daemon/meson.build b/storage-daemon/meson.build
index fd5e32f4b28..5e61a9d1bdf 100644
--- a/storage-daemon/meson.build
+++ b/storage-daemon/meson.build
@@ -1,6 +1,6 @@
 qsd_ss = ss.source_set()
 qsd_ss.add(files('qemu-storage-daemon.c'))
-qsd_ss.add(blockdev, chardev, qmp, qom, qemuutil, gnutls)
+qsd_ss.add(blockdev, chardev, qmp, qom, qemuutil)
 
 subdir('qapi')
 
diff --git a/ui/meson.build b/ui/meson.build
index cfbf29428df..28c7381dd10 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -44,7 +44,7 @@ vnc_ss.add(files(
   'vnc-jobs.c',
   'vnc-clipboard.c',
 ))
-vnc_ss.add(zlib, jpeg, gnutls)
+vnc_ss.add(zlib, jpeg)
 vnc_ss.add(when: sasl, if_true: files('vnc-auth-sasl.c'))
 system_ss.add_all(when: [vnc, pixman], if_true: vnc_ss)
 system_ss.add(when: vnc, if_false: files('vnc-stubs.c'))
-- 
2.45.2


