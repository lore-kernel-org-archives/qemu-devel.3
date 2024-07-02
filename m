Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF79C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:18:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeCs-0002XR-PY; Tue, 02 Jul 2024 10:10:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeCh-0001gR-CN
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:09:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeCf-0008Sd-91
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:09:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Eny4dc4u4alXpsHdU13CSR0Mm+jD6T0BjGB+X7tlZ0=;
 b=fQWRZXcZnva2L+oPQ8pjleSn7hBOy+yT0DVKS0i0lf9Iuibo1B1VelgQSJywB2tm2mOBaP
 +JZ8wXu973wTbk++fJfztre2Z1Jlx0ZL88Q1W1TCcKxsUq7086Sf0A5pQNPLtFcDGVVQVx
 OyJoW97WkizEC2V+uhSS4EpzG4CoNW8=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-bNzlGk0fOpKInVAYEdFiYA-1; Tue, 02 Jul 2024 10:09:51 -0400
X-MC-Unique: bNzlGk0fOpKInVAYEdFiYA-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-52ce42bb0efso5111878e87.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:09:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929388; x=1720534188;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8Eny4dc4u4alXpsHdU13CSR0Mm+jD6T0BjGB+X7tlZ0=;
 b=Eoo/MPnBkUTg2ysn7Pp1U2o4mIKO9VoX0Dhx8kezKjXZSiCc3mR02Acjs6g0T8gB9R
 oourAjML7v7PBOqrIXN2cF35mw0In53z63MzlIzIbbncZREermYH6qAHVkYDRbzSJPKd
 Hy0WAKwx3Exw6HDlcnvAQUYJHo8VIeccnrlicyOCkeMIXoofdJLQwsmiUzCh85S6VZyK
 h5ORvOk1fCMA2RiqACh0/pszCTj/Jm4nPp+wtYqABqfNZWYZgGCWZZaV5R8yWs9xGKIt
 1Di/qganw5uD6lwU0RWdvmQQ2LHoo9YbNvUfojVTTOp6X/3YebDHOGaZr0irQPZ3zMJF
 a9Cg==
X-Gm-Message-State: AOJu0YyjHHiQ4lUSPjApNkTWrkDcVL8zIhJ6mDBtOleajYenGbsTKdfc
 wJ48/t/Mc77Ousb2JCBwQPO71wIisX3ZCjOzr5WSQG0szOqPuFAa+AWAjr7RtMC4jrt0d6TRXsB
 4ZBdPoPwNmDDSqllkEObgRQKhiJ2aL20Xrj0TEeEUCAp4kHFGkz+IRx7sk56jEPeDf1sJs8KMNK
 VjfhaiUSsZFq4oabNvMI0NeIDNInLleQ==
X-Received: by 2002:a05:6512:3da5:b0:52c:df90:203b with SMTP id
 2adb3069b0e04-52e8273e669mr5852531e87.56.1719929388425; 
 Tue, 02 Jul 2024 07:09:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXONuDfLUANbrzzfsYmYnA+QeWn/WMW01jd7UcA5zugQxaKon72Ntzb1J0LNZRUJYROTI4hQ==
X-Received: by 2002:a05:6512:3da5:b0:52c:df90:203b with SMTP id
 2adb3069b0e04-52e8273e669mr5852500e87.56.1719929387720; 
 Tue, 02 Jul 2024 07:09:47 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3678eb6593bsm618931f8f.93.2024.07.02.07.09.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:09:47 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:09:44 -0400
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
Subject: [PULL 55/91] contrib/vhost-user-blk: enable it on any POSIX system
Message-ID: <9c85f39cc547441c38f58469f9a4579ba131e348.1719929191.git.mst@redhat.com>
References: <cover.1719929191.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1719929191.git.mst@redhat.com>
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


