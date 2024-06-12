Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C41BC27C77
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 13:07:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHNdt-0007Z5-Nd; Wed, 12 Jun 2024 09:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sHNdp-0007Rn-R8
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:03:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sHNdo-0008Hz-1E
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:03:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718197431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/P3j+V5YbDeu0o1n73tFmGj5F2fn9U/2HDvEhcAiiyg=;
 b=h0GKmY3d98bvTNKrFqpokFBFSZCPv26+/WYjhyOYZIhWjyVR7JoOl+omcqCqR1dSKJd1V0
 NFx3nZftw5lOxbR8Bt3sgqDp3+PksDHgC69DVioJEX5HiQ3kn0lT+YRHOkQJYx6cu8JlFF
 ikLAYI4DehQk1FwncX5h4yIniTNO37E=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-sSLlmqxiMnaKxUSqaD9MOQ-1; Wed, 12 Jun 2024 09:03:50 -0400
X-MC-Unique: sSLlmqxiMnaKxUSqaD9MOQ-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4405784484eso46245351cf.3
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 06:03:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718197426; x=1718802226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/P3j+V5YbDeu0o1n73tFmGj5F2fn9U/2HDvEhcAiiyg=;
 b=aJoRuzXEnnLiAkY06ZuDnrIV1zKFYgjabrK8CnkT6pBTANgroJ8P7j3YSXCQWBWlNB
 kxp7oJ3lDPI8yUbQ9kaV2Z6k5f4XkUlAtJUmzYmnn8RNfTJuoh7Ti1qPMG/JBmO+U3XZ
 JVRKUyzWCZ6BzEukjMbIROCHYluyuIuEzLZOCWjRXkeMW/M2YP3e423WEuAFPPeDC0Lb
 FBKO3twtFliPXWhLymzJ9T7FM6MjCUqMkmzDA9O4vhT0fibSzgD+Dn7IzA9qJLf0xHjq
 PoIci1UxvbW1aeDLuTO1STLujG72+OwwMNEn9CVgxXDLq0PFfTdcWvVCJ2NLfrV89eBF
 xiyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUX3ujjYzx4goXR/KL+RHs78b92dC42oOAx95rY9m2s1WQaCckiQImJBS8Hczw5RmEbpixvp/Gc/PPo9O+IfZRMeqlHmUk=
X-Gm-Message-State: AOJu0Yzw2gdj/whtjTjUun5mRxVRJj3FMnefnl79s22fP+uAGvQtFubq
 6rew52KrLHAjlGOuBE5s234Ss51DkAA555CpJ6ebNwoLeJMII867a6ZWU7OXxhVA/PWF6ZaIuoi
 mpt5C39BYIZ2uLA8cYL0qmIu7wdyb9mSQVWcMnr6vUmKKJSiTBmkB
X-Received: by 2002:a05:6214:498c:b0:6b0:6d7c:da02 with SMTP id
 6a1803df08f44-6b19158d45amr19617216d6.11.1718197426329; 
 Wed, 12 Jun 2024 06:03:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEicCYzJOU6VP1vjIhb7Vn0kPFI8CMTuJW5Z/I6H4tPfdnlJRidFjhjohpLb3SkReX3sv/Qag==
X-Received: by 2002:a05:6214:498c:b0:6b0:6d7c:da02 with SMTP id
 6a1803df08f44-6b19158d45amr19616666d6.11.1718197425953; 
 Wed, 12 Jun 2024 06:03:45 -0700 (PDT)
Received: from step1.redhat.com ([193.207.132.52])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b0928c508dsm10616236d6.78.2024.06.12.06.03.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 06:03:44 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: mst@redhat.com,
	qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Brad Smith <brad@comstyle.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, gmaglione@redhat.com,
 stefanha@redhat.com, Coiby Xu <Coiby.Xu@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, slp@redhat.com,
 Igor Mammedov <imammedo@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 David Hildenbrand <david@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH RESEND v7 09/12] contrib/vhost-user-blk: enable it on any
 POSIX system
Date: Wed, 12 Jun 2024 15:01:37 +0200
Message-ID: <20240612130140.63004-10-sgarzare@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240612130140.63004-1-sgarzare@redhat.com>
References: <20240612130140.63004-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Let's make the code more portable by adding defines from
block/file-posix.c to support O_DIRECT in other systems (e.g. macOS).

vhost-user-server.c is a dependency, let's enable it for any POSIX
system.

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v6:
- reverted v5 changes since we can't move O_DSYNC and O_DIRECT in osdep
  [Daniel, failing tests on Windows]
v5:
- O_DSYNC and O_DIRECT definition are now in osdep [Phil]
- commit updated since we moved out all code changes
v4:
- moved using of "qemu/bswap.h" API in a separate patch [Phil]
---
 meson.build                             |  2 --
 contrib/vhost-user-blk/vhost-user-blk.c | 14 ++++++++++++++
 util/meson.build                        |  4 +++-
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/meson.build b/meson.build
index 6413e858ea..8436e0c3d6 100644
--- a/meson.build
+++ b/meson.build
@@ -1985,8 +1985,6 @@ has_statx = cc.has_header_symbol('sys/stat.h', 'STATX_BASIC_STATS', prefix: gnu_
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
index 72b505df11..c414178ace 100644
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
2.45.2


