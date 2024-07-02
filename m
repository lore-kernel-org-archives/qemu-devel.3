Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACEB2C31D97
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:33:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjyE-0008Ka-CF; Tue, 02 Jul 2024 16:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjxx-0006Yo-66
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:19:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjxr-0001DA-FB
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:19:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Eny4dc4u4alXpsHdU13CSR0Mm+jD6T0BjGB+X7tlZ0=;
 b=GABe7M/8fL2Y0PixuhryR5sLMPyHjr380SquBEOunQ3sOvIAQ743ugC7x9d4zkcYhJjfJK
 5XlBcyA9XdO28CGmXrtqRSEw/4RtQxUFw/eGI/TroUULXZCq2sW/+jrtsisw5D9UcvxJMg
 zMOSf77MuZw26Qo4oAkY+kBMthEi6Sk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-GuReS-DXM-WHsepmW9cUjA-1; Tue, 02 Jul 2024 16:18:57 -0400
X-MC-Unique: GuReS-DXM-WHsepmW9cUjA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3678fd1edf8so209374f8f.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:18:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951533; x=1720556333;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8Eny4dc4u4alXpsHdU13CSR0Mm+jD6T0BjGB+X7tlZ0=;
 b=d2vEFDqRESoz3vvFLleVBa+vFXEbaG2f5J6yi7W2/Ai31BVTYSi9j7uiWp58gYA/ef
 AlNif7HbxWC345japcKlEi665KTbaDmb7fp+dMnthSsD6+fYKreos1gZhXNX6EMnbyCO
 gFTTqtSOwluq1PK6qottjXwDjErnY9vCCIyCkA3F530Q2ywQzPD0k3dIh2fgXwHlYPyR
 7ZKAm1DxoTi1mZMog1oebFZjCmpaaxLMImVswNwY6FxJxlebJMkStzfBekKhFZvsHeoT
 5UCLp5y0uIlQABbgIo/3sA/7QIkoebhQi28OO3/Klw0Bov4kPMQBKsRh5Y41iN+JvPvX
 5odg==
X-Gm-Message-State: AOJu0YwjDDOGffgOtU9483uoJYqJ97Tja7MGhCDp/cgOUd/qgxJEYUlC
 5B877ly0vl2zJkz8zpMpPmRzuaea9UjeVtWqPun9b41+xVHKZhF3xt9gh+P5rMBdP4BgeZSfK8u
 63CVHCzszwxT/UWh+hi0oa55MB7k7g0CuPIkIGvfeUZBaxu/Pdiekd0unXJcEYMyBfOgdWari2U
 sJXHm2dGHOcSThZ/6RwWlk9zRn1IFj0Q==
X-Received: by 2002:a5d:64ca:0:b0:362:ff95:5697 with SMTP id
 ffacd0b85a97d-36760aa2b8cmr14059566f8f.28.1719951532887; 
 Tue, 02 Jul 2024 13:18:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBQkU8GqFnvPWymycASQkkBf2P9Q5u0ww2Qi9YkMZGwHddPO3Q/ng7vH9kkJcpB9lvccYw1Q==
X-Received: by 2002:a5d:64ca:0:b0:362:ff95:5697 with SMTP id
 ffacd0b85a97d-36760aa2b8cmr14059531f8f.28.1719951532334; 
 Tue, 02 Jul 2024 13:18:52 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af55aeasm207553605e9.17.2024.07.02.13.18.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:18:51 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:18:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Raphael Norwitz <raphael@enfabrica.net>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL v2 55/88] contrib/vhost-user-blk: enable it on any POSIX system
Message-ID: <ff2c62ac7dd6a8f3a7a6d4d4edf1668d67e545b8.1719951168.git.mst@redhat.com>
References: <cover.1719951168.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1719951168.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

From: Stefano Garzarella <sgarzare@redhat.com>

Let's make the code more portable by adding defines from
block/file-posix.c to support O_DIRECT in other systems (e.g. macOS).

vhost-user-server.c is a dependency, let's enable it for any POSIX
system.

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20240618100511.145789-1-sgarzare@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 contrib/vhost-user-blk/vhost-user-blk.c | 14 ++++++++++++++
 meson.build                             |  2 --
 util/meson.build                        |  4 +++-
 3 files changed, 17 insertions(+), 3 deletions(-)

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
diff --git a/meson.build b/meson.build
index 6c1a489cc0..a947b83c3f 100644
--- a/meson.build
+++ b/meson.build
@@ -2026,8 +2026,6 @@ has_statx = cc.has_header_symbol('sys/stat.h', 'STATX_BASIC_STATS', prefix: gnu_
 has_statx_mnt_id = cc.has_header_symbol('sys/stat.h', 'STATX_MNT_ID', prefix: gnu_source_prefix)
 
 have_vhost_user_blk_server = get_option('vhost_user_blk_server') \
-  .require(host_os == 'linux',
-           error_message: 'vhost_user_blk_server requires linux') \
   .require(have_vhost_user,
            error_message: 'vhost_user_blk_server requires vhost-user support') \
   .disable_auto_if(not have_tools and not have_system) \
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
MST


