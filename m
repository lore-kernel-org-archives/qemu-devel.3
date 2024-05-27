Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF37C25B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 10:51:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBXvW-0000zf-Ah; Mon, 27 May 2024 06:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sBXvR-0000yG-Rw
 for qemu-devel@nongnu.org; Mon, 27 May 2024 06:49:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sBXvQ-0001Dk-8t
 for qemu-devel@nongnu.org; Mon, 27 May 2024 06:49:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716806995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cNfG29dFiWjygipiND/GaClbapPaSgn6l+G860HZBP0=;
 b=SjbmpsjSn/fj++KfDWFcCIi5W+RoAZSUmJx1G9wc5TFOgNG/xJwcchsoixgq9TYBsPBNDC
 E4aV+q1lygeuGsNigob0ASzFjalCzXGOXbr6+p89YgKNR0BsUvB1bkDtwNsKDV3pWNRWvM
 C36dHc6dmx0ps4ZSWdfX+iajpjqv5HM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-qWT_Z4AdOgGME7c0XHImMw-1; Mon, 27 May 2024 06:49:54 -0400
X-MC-Unique: qWT_Z4AdOgGME7c0XHImMw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a5a84e7c884so290570066b.3
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 03:49:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716806992; x=1717411792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cNfG29dFiWjygipiND/GaClbapPaSgn6l+G860HZBP0=;
 b=crvYXuaOph67ywL7xS8PwrEUQolFz+qTzfKU7878Sdo7a94XY8F68pwSTluKFYwEog
 Gkm14giGqPPS/HBRU/LrBaN9M1IPXEDaB5OoXSIdgBDID6WrEXCjSfyvH70r3T6wgXim
 n7sJK1jlZaieoo0H5EiAc12zmICHFbBwrdx6IdFzMVwR5ugoP0DvWNzUxw8sNpB859Jo
 svQUQhAf81RihhxLZJWUiRQEQDTjw/7k4R5JZ5dnLYTkxaNcK2jwZiP2OYnWG3dusJWA
 I32gU1KeW9axQyzwFprF8DHrTZepVh3lFJTxQLi8JFPeLEvXFb7T4zxJutwP79/geyc8
 u/GA==
X-Gm-Message-State: AOJu0YxCoAQqryuHFbaBP/aKnU1kb0bQGiFJnxWqJXIRPYWyoaaHlNrS
 oXsdQ+Y+JQd3xXVv8emXdRS1jCZ8/sPnKazvln512/UHXJdq7VO2FOgFh4NplLXAho2OKu5RKX+
 nniFLjlKqdAyuoM1uXFATqq+joVcByYGmHlqIfA2T6EaPHFwBzmvcvdmTqngUr0X/Y2fDWPQRDu
 e9LMa5/yv2s6p6b5PqpXiIgvPhKmCI7rXzMnas
X-Received: by 2002:a50:a687:0:b0:578:61c7:2806 with SMTP id
 4fb4d7f45d1cf-57861c72831mr5290488a12.14.1716806992061; 
 Mon, 27 May 2024 03:49:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzCOhrCb8QpWDUtxwoeWJTZeR9bfA/F6Ufk7etDVmb7wa9F4EJ8UdpeNFOiTd4ecU2oL5bTQ==
X-Received: by 2002:a50:a687:0:b0:578:61c7:2806 with SMTP id
 4fb4d7f45d1cf-57861c72831mr5290471a12.14.1716806991544; 
 Mon, 27 May 2024 03:49:51 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-579da710ef2sm643879a12.44.2024.05.27.03.49.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 03:49:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: akihiko.odaki@daynix.com
Subject: [RFC PATCH v2 4/5] Revert "meson: Propagate gnutls dependency"
Date: Mon, 27 May 2024 12:49:36 +0200
Message-ID: <20240527104937.30443-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527104937.30443-1-pbonzini@redhat.com>
References: <20240527104937.30443-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
index 9772c145bdb..84dbd7fb371 100644
--- a/meson.build
+++ b/meson.build
@@ -3486,7 +3486,7 @@ if have_block
     'blockdev-nbd.c',
     'iothread.c',
     'job-qmp.c',
-  ), gnutls)
+  ))
 
   # os-posix.c contains POSIX-specific functions used by qemu-storage-daemon,
   # os-win32.c does not
@@ -4004,7 +4004,7 @@ if have_tools
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
2.45.1


