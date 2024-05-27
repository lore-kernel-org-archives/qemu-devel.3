Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1287CC25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 10:51:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBXvQ-0000w7-Kq; Mon, 27 May 2024 06:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sBXvM-0000uQ-QB
 for qemu-devel@nongnu.org; Mon, 27 May 2024 06:49:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sBXvK-0001DH-Dc
 for qemu-devel@nongnu.org; Mon, 27 May 2024 06:49:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716806989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=poEDuhWsyNychXfsoTvNKqqk+sy644eil+tuGdhQ4R0=;
 b=hn+wsWs4vJS53XolKZcbc994vIUTKXRL2r0Y9+uJ0An82d7nDdyoiikU35gEyPaFmWPgyp
 XzcBmdaVM5rAPSHhXt1tXV9jXcjK5owLnWeMpTLwZZ8zFg5klHvdJseBj9s46eg+Com85k
 zqy1VM0QEHLPf9yxfhGyKtjUdJbDYaM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-wYsmIE2WMjGiru8zIeXg7Q-1; Mon, 27 May 2024 06:49:47 -0400
X-MC-Unique: wYsmIE2WMjGiru8zIeXg7Q-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a626764169fso108159466b.2
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 03:49:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716806985; x=1717411785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=poEDuhWsyNychXfsoTvNKqqk+sy644eil+tuGdhQ4R0=;
 b=b6Z07B8HGPIWoGirVufHtQpQr4Qz/Fo9YNGNVFF+ulNVi1J66l1hDsdB+1QUUbbG7x
 c3UK3mQB66jK2Nq4mForWs69F1ZL9sSV2UGaq0irrshCkqvXK3SoYZNfrJc15rxLVvkF
 h5P5e0v49D9EW240gbzPCMml4AzhaSNUPO+gCke+8TTI5KaaY0CHT4BUXmQZYXhaHUum
 E75ZwokTwRzsh0xbINavGDBFcWnY23NMd/cO4gZz60XFiq+s4B3QIUix65OCGZnVPc7M
 SopZ9diYgI3RWDVkuXwl4AT4GPBd5IOyTUEgcfBH6urmBZAyXLFcrM60idnfHGOl3ZVR
 ef1g==
X-Gm-Message-State: AOJu0YzcJZgm5qWGrghR2bDORDSXilCAvGmkmaaHAr6FaVK/HbHaQlx/
 xdcCOzQwXshN8JBiyhKsyQ+iCjWlQYwOIHCmqJnuuE811xFufe2hHQcbO8x5/oz8+gCjHbCVAEq
 6SxhgB20gl58IQW+UTmUUNtcjTyBiEpiV0YcBRbjsikmGgaBcvapKZvPOHPEC9sSMeLf5p9l4O8
 cA7MpM6jMavBI9XJoYxOq3SFZrHVIUvM3dzfBA
X-Received: by 2002:a17:907:8323:b0:a59:b4e8:d91b with SMTP id
 a640c23a62f3a-a62641df602mr439508866b.23.1716806985371; 
 Mon, 27 May 2024 03:49:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/N8qR+VXkAEXOT6QLBRFqsjwpqScSjuH0SINyXQJyqho/EFIKETnWUEdfVZX0HMVrjNXiDg==
X-Received: by 2002:a17:907:8323:b0:a59:b4e8:d91b with SMTP id
 a640c23a62f3a-a62641df602mr439507466b.23.1716806985007; 
 Mon, 27 May 2024 03:49:45 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626c8176e1sm473343766b.8.2024.05.27.03.49.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 03:49:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: akihiko.odaki@daynix.com
Subject: [RFC PATCH v2 2/5] meson: move block.syms dependency out of libblock
Date: Mon, 27 May 2024 12:49:34 +0200
Message-ID: <20240527104937.30443-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527104937.30443-1-pbonzini@redhat.com>
References: <20240527104937.30443-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

In order to define libqemuutil symbols that are requested by block modules,
QEMU currently uses a combination of the "link_depends" argument of
libraries (which is propagated into dependencies, but not available in
dependencies) and the "link_args" argument of declare_dependency()
(which _is_ available in static_library, but probably not used for
historical reasons only).

Unfortunately the link_depends will not be propagated into the
"block" dependency if it is defined using
declare_dependency(objects: ...); and it is not possible to
add it directly to the dependency because the keyword argument
simply is not available.

The only solution, in order to switch to defining the dependency
without using "link_whole" (which has problems of its own, see
https://github.com/mesonbuild/meson/pull/8151#issuecomment-754796420),
is unfortunately to add the link_args and link_depends to the
executables directly; fortunately there is just four of them.

It is possible (and I will look into it) to add "link_depends"
to declare_dependency(), but it probably will be a while before
QEMU can use it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                | 5 +++--
 storage-daemon/meson.build | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index 92ddbd17c32..edaef6bca11 100644
--- a/meson.build
+++ b/meson.build
@@ -3719,12 +3719,10 @@ system_ss.add(migration)
 block_ss = block_ss.apply({})
 libblock = static_library('block', block_ss.sources() + genh,
                           dependencies: block_ss.dependencies(),
-                          link_depends: block_syms,
                           name_suffix: 'fa',
                           build_by_default: false)
 
 block = declare_dependency(link_whole: [libblock],
-                           link_args: '@block.syms',
                            dependencies: [crypto, io])
 
 blockdev_ss = blockdev_ss.apply({})
@@ -3993,10 +3991,13 @@ endif
 
 if have_tools
   qemu_img = executable('qemu-img', [files('qemu-img.c'), hxdep],
+             link_args: '@block.syms', link_depends: block_syms,
              dependencies: [authz, block, crypto, io, qom, qemuutil], install: true)
   qemu_io = executable('qemu-io', files('qemu-io.c'),
+             link_args: '@block.syms', link_depends: block_syms,
              dependencies: [block, qemuutil], install: true)
   qemu_nbd = executable('qemu-nbd', files('qemu-nbd.c'),
+               link_args: '@block.syms', link_depends: block_syms,
                dependencies: [blockdev, qemuutil, gnutls, selinux],
                install: true)
 
diff --git a/storage-daemon/meson.build b/storage-daemon/meson.build
index 46267b63e72..fd5e32f4b28 100644
--- a/storage-daemon/meson.build
+++ b/storage-daemon/meson.build
@@ -8,6 +8,7 @@ if have_tools
   qsd_ss = qsd_ss.apply({})
   qsd = executable('qemu-storage-daemon',
                    qsd_ss.sources(),
+                   link_args: '@block.syms', link_depends: block_syms,
                    dependencies: qsd_ss.dependencies(),
                    install: true)
 endif
-- 
2.45.1


