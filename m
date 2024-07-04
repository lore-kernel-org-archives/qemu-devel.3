Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42680C3271F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 09:59:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPJEN-0006Ss-Cj; Thu, 04 Jul 2024 05:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sPJEL-0006Rv-Hp
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 05:58:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sPJEK-000862-2Y
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 05:58:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720087099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9uBM6zOrx7yDYGJWdOhsTzSy8zkX7WCI0/bOpt/gBDI=;
 b=N54DaLRo8GwTie4r06K/V6fSoxbfBW50Y55Aq5dsQvbemoIReLIcl1GZzT01FJczQ2vBvQ
 y3lzVbmW6Ptf2uw6ArgQ7RfMFsFlvCdKNbsaHxJETk65cRBn3iDyW1kaPETACk70yD9G6o
 U3Cm8V+LYmy+WIeuh3imXo8uHGVNUPY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-d-X-BlUhN4OxwCKPJ9ZdYQ-1; Thu, 04 Jul 2024 05:58:15 -0400
X-MC-Unique: d-X-BlUhN4OxwCKPJ9ZdYQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4264dc624a5so4755e9.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 02:58:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720087094; x=1720691894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9uBM6zOrx7yDYGJWdOhsTzSy8zkX7WCI0/bOpt/gBDI=;
 b=UpGHjrZoEueH8WW3npTAGcwr8xp+p/G4B4QdBq8vJVrRi/MJIzZHcCbQEHGlGmhLU6
 5sQwAPMAC77RaWblWzmXrvWkKzlHQ9GMR8YSBHI8jc7pYNLkAY6/wmIkQa5fqtWP9YbT
 Ccjry6HnZhRHL4+I36WRb0P9ZzaTM4o2MgpqmyvkYBG0/Kj8cnz1bCvJfPlBPh9099ml
 8u9kNwtXpkgBC3Q+jZlXTG/RdQfhtSOF5QtE/45OH5gpPZK4jtwDOTvzDdaW8s3E/efc
 Bb18jwMBbiZ8YVK9kgacZsksW5VmC5UN8oizVrSHgDDBSQqR/ITBGRxXRWY3aZ9pzj/m
 zpgA==
X-Gm-Message-State: AOJu0YwkNfzY84YaTNwD4sGcZf/xmLEoppCszOQV4cIf9JiRkp/+kV9X
 lOz9DFBdRtIztKh3gpH9w4xi7SN3xh6/G1hukGhf//7PFfXiTt2Imlr+gNtbPNyjwUOoh3LMz6D
 gU/tsexyY1sAHjRPUl/mlywIMpsl0g9OOGKXDecbH7pEFRqqVvhMZ2EVj6PycPTnvZVjy67Qz2M
 7mKpVPzXmj6RFBGH+dYoVhbDBDGlJi5QwPghS8
X-Received: by 2002:a05:600c:158b:b0:424:9516:bfcf with SMTP id
 5b1f17b1804b1-4264a3d9797mr10500105e9.3.1720087093913; 
 Thu, 04 Jul 2024 02:58:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwKwidJzwFP7lDG5Ogpeeg14lsONhrthR+MaZ6GLfCWJuMS0kC/msSL5PxG7TpcGoIE7E/8w==
X-Received: by 2002:a05:600c:158b:b0:424:9516:bfcf with SMTP id
 5b1f17b1804b1-4264a3d9797mr10500005e9.3.1720087093561; 
 Thu, 04 Jul 2024 02:58:13 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a2ca618sm17245125e9.29.2024.07.04.02.58.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 02:58:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/16] meson: merge plugin_ldflags into emulator_link_args
Date: Thu,  4 Jul 2024 11:57:53 +0200
Message-ID: <20240704095806.1780273-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704095806.1780273-1-pbonzini@redhat.com>
References: <20240704095806.1780273-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

These serve the same purpose, except plugin_ldflags ends up in the linker
command line in a more roundabout way (through specific_ss).  Simplify.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 plugins/meson.build | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/plugins/meson.build b/plugins/meson.build
index 51b4350c2a0..18a0303bff9 100644
--- a/plugins/meson.build
+++ b/plugins/meson.build
@@ -1,4 +1,3 @@
-plugin_ldflags = []
 # Modules need more symbols than just those in plugins/qemu-plugins.symbols
 if not enable_modules
   if host_os == 'darwin'
@@ -7,9 +6,9 @@ if not enable_modules
       output: 'qemu-plugins-ld64.symbols',
       capture: true,
       command: ['sed', '-ne', 's/^[[:space:]]*\\(qemu_.*\\);/_\\1/p', '@INPUT@'])
-    plugin_ldflags = ['-Wl,-exported_symbols_list,plugins/qemu-plugins-ld64.symbols']
+    emulator_link_args += ['-Wl,-exported_symbols_list,plugins/qemu-plugins-ld64.symbols']
   else
-    plugin_ldflags = ['-Xlinker', '--dynamic-list=' + (meson.project_source_root() / 'plugins/qemu-plugins.symbols')]
+    emulator_link_args += ['-Xlinker', '--dynamic-list=' + (meson.project_source_root() / 'plugins/qemu-plugins.symbols')]
   endif
 endif
 
@@ -37,5 +36,5 @@ if get_option('plugins')
     'loader.c',
     'core.c',
     'api.c',
-  ), declare_dependency(link_args: plugin_ldflags))
+  ))
 endif
-- 
2.45.2


