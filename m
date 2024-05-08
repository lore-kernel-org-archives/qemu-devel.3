Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E1FFC04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 07:46:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4c0O-0004Uz-DC; Wed, 08 May 2024 03:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1s4c0A-0004Mj-1f
 for qemu-devel@nongnu.org; Wed, 08 May 2024 03:46:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1s4c05-00014A-Sj
 for qemu-devel@nongnu.org; Wed, 08 May 2024 03:46:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715154364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pXltNfUgHXCTLeT3zt76n46oHy9O/2v0PFK5rixV6Jo=;
 b=fZaqCDdzVLqjj0IigU1ql2XytBu/RyKWmk3jqev2UpjiQoe93njcT3E52fkdk/bYNfN66O
 NoL3hcRnVi7p69ffXG0aX5mHC1U9NcBVspKM+a/alBHercKwULGt7+HY+vs1vRAVXqswDL
 6yqwHmvj7u3ROSjC+gi6miBoQLfCBWc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-kLukLsXVOtCOpxXDCOr_dQ-1; Wed, 08 May 2024 03:46:03 -0400
X-MC-Unique: kLukLsXVOtCOpxXDCOr_dQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a599dbd2b6aso238345166b.2
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 00:46:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715154357; x=1715759157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pXltNfUgHXCTLeT3zt76n46oHy9O/2v0PFK5rixV6Jo=;
 b=DQyiHLgNJ656V7g5sq0VARgCEIHM1Zr8NXwHzdJxCqCLxnFwV8Ax6FLS+MFdrN6YY5
 Dw3/cnYaMzWzgEOPBeihK/VBI47Bw+k0MQ8F7rqm+EkuV5YVnFHEuMaqxu4F443B0FRq
 b7qc85jssQsTyAghmpv9xaCYoeYfLPu8rsvEvK+DJneRdWnK4068vYnzwQvvPhzBesbT
 H9q2rcALm9LdmX3p048K8HMaOaHv6vu+qIqhy6nOBJXcepBqqdvIjWRrk4OKn/sVxWoC
 qsE/icVYo2loonpeqQys33doyOsiPWAf63QJF94Z0qwaqUn/F0CnjeWIS0PrzwMsYenl
 a87w==
X-Gm-Message-State: AOJu0YxskCZpkkC0RypJbRuoCryoN9zOGqafIMXf7dGHIgXMDrhunKAQ
 g9HbEpc4bOgwVO+rDnCnac7vngR9raRWEk7eeTiOBWUanLbgT+tJks4/OaurLAe2LVVSa0T9Cqc
 1+34xN2cvd5V4IIwwE7Xy3DbIZz4Bnff29SaKuNoKjTgUdL0HaltoRKGp81YOy87Xychma+ljQG
 0yaChkwoVw/GthkPZsiGCxe5hkGj5vjkXLGYo5
X-Received: by 2002:a17:907:170b:b0:a59:a0c1:b217 with SMTP id
 a640c23a62f3a-a59fb95a633mr115438266b.46.1715154357610; 
 Wed, 08 May 2024 00:45:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4yQEaQD/23q48AYVEgeyj5b9+UjZPeGSGGV11icHoY5oLwxFDOm2QCV39u+WWx3eAzg7mVw==
X-Received: by 2002:a17:907:170b:b0:a59:a0c1:b217 with SMTP id
 a640c23a62f3a-a59fb95a633mr115434666b.46.1715154357296; 
 Wed, 08 May 2024 00:45:57 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-12-25-56.business.telecomitalia.it. [87.12.25.56])
 by smtp.gmail.com with ESMTPSA id
 my9-20020a1709065a4900b00a59ba75059asm4431600ejc.153.2024.05.08.00.45.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 May 2024 00:45:55 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, slp@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brad Smith <brad@comstyle.com>, Eduardo Habkost <eduardo@habkost.net>,
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, gmaglione@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, stefanha@redhat.com,
 David Hildenbrand <david@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v4 09/12] contrib/vhost-user-blk: enable it on any POSIX system
Date: Wed,  8 May 2024 09:44:53 +0200
Message-ID: <20240508074457.12367-10-sgarzare@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240508074457.12367-1-sgarzare@redhat.com>
References: <20240508074457.12367-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

Let's make the code more portable by adding defines from
block/file-posix.c to support O_DIRECT in other systems (e.g. macOS).

vhost-user-server.c is a dependency, let's enable it for any POSIX
system.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v4:
- moved using of "qemu/bswap.h" API in a separate patch [Phil]
---
 meson.build                             |  2 --
 contrib/vhost-user-blk/vhost-user-blk.c | 14 ++++++++++++++
 util/meson.build                        |  4 +++-
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/meson.build b/meson.build
index 7954da5971..25047db3c1 100644
--- a/meson.build
+++ b/meson.build
@@ -1960,8 +1960,6 @@ has_statx = cc.has_header_symbol('sys/stat.h', 'STATX_BASIC_STATS', prefix: gnu_
 has_statx_mnt_id = cc.has_header_symbol('sys/stat.h', 'STATX_MNT_ID', prefix: gnu_source_prefix)
 
 have_vhost_user_blk_server = get_option('vhost_user_blk_server') \
-  .require(host_os == 'linux',
-           error_message: 'vhost_user_blk_server requires linux') \
   .require(have_vhost_user,
            error_message: 'vhost_user_blk_server requires vhost-user support') \
   .disable_auto_if(not have_tools and not have_system) \
diff --git a/contrib/vhost-user-blk/vhost-user-blk.c b/contrib/vhost-user-blk/vhost-user-blk.c
index 9492146855..a450337685 100644
--- a/contrib/vhost-user-blk/vhost-user-blk.c
+++ b/contrib/vhost-user-blk/vhost-user-blk.c
@@ -25,6 +25,20 @@
 #include <sys/ioctl.h>
 #endif
 
+/* OS X does not have O_DSYNC */
+#ifndef O_DSYNC
+#ifdef O_SYNC
+#define O_DSYNC O_SYNC
+#elif defined(O_FSYNC)
+#define O_DSYNC O_FSYNC
+#endif
+#endif
+
+/* Approximate O_DIRECT with O_DSYNC if O_DIRECT isn't available */
+#ifndef O_DIRECT
+#define O_DIRECT O_DSYNC
+#endif
+
 enum {
     VHOST_USER_BLK_MAX_QUEUES = 8,
 };
diff --git a/util/meson.build b/util/meson.build
index 2ad57b10ba..93054f2340 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -112,10 +112,12 @@ if have_block
     util_ss.add(files('filemonitor-stub.c'))
   endif
   if host_os == 'linux'
-    util_ss.add(files('vhost-user-server.c'), vhost_user)
     util_ss.add(files('vfio-helpers.c'))
     util_ss.add(files('chardev_open.c'))
   endif
+  if host_os != 'windows'
+    util_ss.add(files('vhost-user-server.c'), vhost_user)
+  endif
   util_ss.add(files('yank.c'))
 endif
 
-- 
2.45.0


