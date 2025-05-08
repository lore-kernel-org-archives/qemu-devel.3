Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40418C3ABC5
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 09:51:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCxu2-00016m-W1; Thu, 08 May 2025 05:50:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCxu1-00016S-KY
 for qemu-devel@nongnu.org; Thu, 08 May 2025 05:50:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCxu0-0000rc-2D
 for qemu-devel@nongnu.org; Thu, 08 May 2025 05:50:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746697850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=li4m/JDAIzf4ljpLeQSBOMq1oMxYHdkOV5a9yMTKehU=;
 b=d1KmFvkG424Je3wDwDVaLWHwvmvpy7Uws44H+r96Paf5Y1E1ZBC3CIlcghUQlJ9h2aXfWO
 lSwf5+9BjFDhaQo5nsgoTxKBAk4NZ/0CNYFm6zycbN9yusA3JKD/sEmTOhHbbr4LpZFEsp
 YZX2Ewd8Ko3ZgMbwtK/ImcutnLv2+i8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-K8JXjX80Mmai58ltAot8Hg-1; Thu, 08 May 2025 05:50:48 -0400
X-MC-Unique: K8JXjX80Mmai58ltAot8Hg-1
X-Mimecast-MFC-AGG-ID: K8JXjX80Mmai58ltAot8Hg_1746697848
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-44059976a1fso2968175e9.1
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 02:50:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746697847; x=1747302647;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=li4m/JDAIzf4ljpLeQSBOMq1oMxYHdkOV5a9yMTKehU=;
 b=SAwhra4ejcpuWpW+TOXa8OkjsW3eX6WQJeUZ5BzyX0xoQ4hv00oIx5tEt0scstJMZm
 XAoltTxIMmtCkWOmu3kyOMI8S8YDVk/8pl32J6WYFfndDZrTJ6yWVHOj96N/m7CLgRry
 Xwyw3ZXrfDZS/lKuaGlILNVjpjR6SU/VvDyTTiWHSwcX3M/hKU88myW96DPt7MtYkRD9
 mTqp+DolTLNvqcTjvUcoO8FcIycfrhVFoowHqdgKI/Ju264snibSCfXKBlkig3Io3kEy
 cYUeN7HoEZ2FUD8COKx5wK3IJPIo/teGJaHb4Ea2oN5umb8Ho1aYXxV9+AAzZvO7Rb5S
 ZaUA==
X-Gm-Message-State: AOJu0YzsBa/yrPwj2iwTeFMitd1UQdOQife+H3e1AeHGXPyO4Q/xcEXl
 3lIaQg1ZQH3NbKWQK/DDnpOQqhtDy3Un0QXdgefF4aQdwYJ5Nd6MlxfnIbUa/Mo0ghaKQwiBTl7
 ktYsshSpfkexFb9fmoH699uDWJuw6mk56S06cbaj8wxDW7lTrS5XHqf1V9bbomGbxivP6PNHORa
 1JLSnBenZWIcrwvmFr47BZyVqOSvKls8vbekkK
X-Gm-Gg: ASbGncuPmki0bgVBt6uWjz3ZBMBSjjnlIo05a8nbiXXqY87B+W6MnzNLkxrNKXYJ1qN
 z83nV8X9RJOJhFSRqsDD9qOtQwtMzhh5m0PomKdRpYicQ7sGJWz2sW2Ze1G5Y0hmWOX2W22nYb/
 qxg1rmRX+qNWr/6O8LwjKJMZtdAOVm9TglwN5MEvDT/cNl4UoHQRo+LSgWGxF8i0C8xE3Sb1n94
 TIwlVkFsVjL53IpIgfFvt8Q+m2B7YVpdJvldfcwd22yzR1OBqf1kv+jtN4lOC7xS0GceYz0t1Rd
 duKUlw/k5u6a20c=
X-Received: by 2002:a5d:64ac:0:b0:3a0:880a:144f with SMTP id
 ffacd0b85a97d-3a0b4a0280cmr5155008f8f.6.1746697847132; 
 Thu, 08 May 2025 02:50:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcLqH5OYD+XOAypUYKt26pjJgtkGZTfilpGiALDnCO3gQvyrm5HJDEokslaGPNrF2/Q+wn8Q==
X-Received: by 2002:a5d:64ac:0:b0:3a0:880a:144f with SMTP id
 ffacd0b85a97d-3a0b4a0280cmr5154988f8f.6.1746697846691; 
 Thu, 08 May 2025 02:50:46 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099b1726bsm20002456f8f.94.2025.05.08.02.50.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 02:50:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] meson: do not check supported TCG architecture if no
 emulators built
Date: Thu,  8 May 2025 11:50:44 +0200
Message-ID: <20250508095044.468069-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

Errors about TCI are pointless if only tools are being built; suppress
them even if the user did not specify --disable-tcg.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/meson.build b/meson.build
index 6923f94b856..bfddcc07dfd 100644
--- a/meson.build
+++ b/meson.build
@@ -247,6 +247,8 @@ have_vhost_net_vdpa = have_vhost_vdpa and get_option('vhost_net').allowed()
 have_vhost_net_kernel = have_vhost_kernel and get_option('vhost_net').allowed()
 have_vhost_net = have_vhost_net_kernel or have_vhost_net_user or have_vhost_net_vdpa
 
+have_tcg = get_option('tcg').allowed() and (have_system or have_user)
+
 have_tools = get_option('tools') \
   .disable_auto_if(not have_system) \
   .allowed()
@@ -863,7 +865,7 @@ elif host_os == 'haiku'
             cc.find_library('network'),
             cc.find_library('bsd')]
 elif host_os == 'openbsd'
-  if get_option('tcg').allowed() and target_dirs.length() > 0
+  if have_tcg
     # Disable OpenBSD W^X if available
     emulator_link_args = cc.get_supported_link_arguments('-Wl,-z,wxneeded')
   endif
@@ -904,7 +906,7 @@ if host_os == 'netbsd'
 endif
 
 tcg_arch = host_arch
-if get_option('tcg').allowed()
+if have_tcg
   if host_arch == 'unknown'
     if not get_option('tcg_interpreter')
       error('Unsupported CPU @0@, try --enable-tcg-interpreter'.format(cpu))
@@ -2534,7 +2536,7 @@ config_host_data.set('CONFIG_PIXMAN', pixman.found())
 config_host_data.set('CONFIG_SLIRP', slirp.found())
 config_host_data.set('CONFIG_SNAPPY', snappy.found())
 config_host_data.set('CONFIG_SOLARIS', host_os == 'sunos')
-if get_option('tcg').allowed()
+if have_tcg
   config_host_data.set('CONFIG_TCG', 1)
   config_host_data.set('CONFIG_TCG_INTERPRETER', tcg_arch == 'tci')
 endif
@@ -4954,7 +4956,7 @@ if host_arch == 'unknown'
   message('compile or work on this host CPU. You can help by volunteering')
   message('to maintain it and providing a build host for our continuous')
   message('integration setup.')
-  if get_option('tcg').allowed() and target_dirs.length() > 0
+  if have_tcg
     message()
     message('configure has succeeded and you can continue to build, but')
     message('QEMU will use a slow interpreter to emulate the target CPU.')
-- 
2.49.0


