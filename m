Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B46CDC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 10:06:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJViT-0004cW-1Y; Tue, 18 Jun 2024 06:05:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sJViQ-0004ah-Sd
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 06:05:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sJViP-0001RP-6M
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 06:05:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718705124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D23sE3AgRotCDX4TIxE04BnGZoCJyb8IC4yJhLAVexA=;
 b=ARRVy217AYEau2famaNWQ3OjVuDkRh1jNEyrshgkcqL/aVPJ89eOw0wkoaEAcvoJDrVHX9
 4m3BtCV1pzyrVWDlBgY4ygHZNRLF9J6yuBO7FI45BAt7KeU6Km7xs2VB03Brjm/QGQqaEf
 7n+O2r9Q+4RUT1XMunZj6q70pf2NKlk=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-9ap91TqdMBuQ1dNcNMXp4g-1; Tue, 18 Jun 2024 06:05:22 -0400
X-MC-Unique: 9ap91TqdMBuQ1dNcNMXp4g-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2ec1709d233so27777691fa.3
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 03:05:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718705117; x=1719309917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D23sE3AgRotCDX4TIxE04BnGZoCJyb8IC4yJhLAVexA=;
 b=cIZ/vIzVZCiws11MWfgzT45vDPoI1jTvI6NwHGKCE+062sw9yWah7P4igVnEhiSsZa
 RGzydoATP6TozUz3R+BD2he35vuXZG4XNoF4G5n2J7gzj9gASc7C31l5bZqpTYU1jrB+
 o9V3eQmFi5YqjZkr+TXQU5LYtJ1AGx4ik3xxsZRItGmX0iCr3mZDcg8Wd29WHWxYaVO8
 v0IVf/N+FAy5wLY3EM9fToqcL/o+QUDJXvf+jEYM1gnnfvAn0WlbD71q9LsZGxG4H5RX
 0/kCY7wSl/nj3IZfey/wUhnK6p2vkZ6VTk4kE5iZJNbgUjzGfN1ZJ3vkKN9wFvKWBf33
 PSBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzyr9+ggUTK1HCtalLUwlWOeEi4M/UA2/05nW2ZgfXDkbBJoWlfmg4eiHi8J0xfbruCrDzVB6xJOBf1OTl1bP+PUpW8MU=
X-Gm-Message-State: AOJu0Yyd54DMbK/LSwluBE26VILl1q4EOTu8zntmUhur8TTC1qKJxNis
 cRT6tugzFsw/sn+11Zv+KiAUnuTEM1nwhoqJaL/PcH8wAktKsvHInKfsJuHlzmt9+OeAFpWybNL
 fH1kx1/bGRYiSfZBdoLBrUoRHC47rBacZ1yzEaj4e8INQ1drjpvyD
X-Received: by 2002:ac2:560a:0:b0:52c:8abe:5204 with SMTP id
 2adb3069b0e04-52ca6e6d562mr7716698e87.32.1718705116894; 
 Tue, 18 Jun 2024 03:05:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpXUNx/dD3F/Us1LkHzStUGnStkp9sk6wwAk93rcdOInVCHJzv7ITZuPi4ie95N3HkJXSaAw==
X-Received: by 2002:ac2:560a:0:b0:52c:8abe:5204 with SMTP id
 2adb3069b0e04-52ca6e6d562mr7716688e87.32.1718705116624; 
 Tue, 18 Jun 2024 03:05:16 -0700 (PDT)
Received: from step1.redhat.com ([193.207.160.125])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-360751036c9sm13749648f8f.94.2024.06.18.03.05.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 03:05:14 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: mst@redhat.com,
	qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Brad Smith <brad@comstyle.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Laurent Vivier <lvivier@redhat.com>,
 Coiby Xu <Coiby.Xu@gmail.com>, slp@redhat.com, gmaglione@redhat.com,
 Igor Mammedov <imammedo@redhat.com>, stefanha@redhat.com,
 Raphael Norwitz <raphael@enfabrica.net>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v8 10/13] contrib/vhost-user-blk: enable it on any POSIX system
Date: Tue, 18 Jun 2024 12:05:11 +0200
Message-ID: <20240618100511.145789-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618100043.144657-1-sgarzare@redhat.com>
References: <20240618100043.144657-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
index 487153a431..f86ce92364 100644
--- a/meson.build
+++ b/meson.build
@@ -2001,8 +2001,6 @@ has_statx = cc.has_header_symbol('sys/stat.h', 'STATX_BASIC_STATS', prefix: gnu_
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


