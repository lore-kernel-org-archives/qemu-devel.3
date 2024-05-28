Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D6F5C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 10:38:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBuDz-0001aZ-Ib; Tue, 28 May 2024 06:38:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sBuDv-0001K8-AF
 for qemu-devel@nongnu.org; Tue, 28 May 2024 06:38:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sBuDs-0000El-9T
 for qemu-devel@nongnu.org; Tue, 28 May 2024 06:38:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716892707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZtdNE96DR7TVj2y2oELNu+a95VAeTxLMI49tULfbBf4=;
 b=HZmkWvP9EFAWRhEayRnTt3fePnxaAjmCFkuu9goD14b1cQbIkSh0/kKRCOoYw/ZRM4MpMM
 G28x/8J62TrObiyZlAW45mlwm82l3iIwECQ1YxlCNtUXzm5lt7OYOTPpr3pwamP4KfQ/nz
 CHp7MjQgA8ot7HUGKwSb8A7XYMFF9b0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-uOqV8CLFPC6emb5gwXXMrw-1; Tue, 28 May 2024 06:38:26 -0400
X-MC-Unique: uOqV8CLFPC6emb5gwXXMrw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-35559d30617so521216f8f.2
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 03:38:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716892701; x=1717497501;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZtdNE96DR7TVj2y2oELNu+a95VAeTxLMI49tULfbBf4=;
 b=g+MSC/cakS46DAqggsVTgbyv8faepSd0fJ17nJ4cvqfp/wCTr9SiLWsMID2tsWOAf7
 dnAr1DDSiMZZeXImn4oeJyfjBG3KCavMTnyrY6sFMyqG4qtTZdmrVtw14gppn5YrJ5ud
 e01i/QdcxcQfvxehkQTtL+rF9UQ+XS/L1WnJw8wQC7bZcqoofDpgVaYlKWAtItV2TTyU
 MfXbMa+IqkZ116j+dYR8BvUZKKFTzDFzCUtHsPwexrsT7Un6wCTqNAcxh4uZCnQEk2EE
 lnbTSbaCEkUiy+/lHgOKbGwGX/ag4LTQjCVMPSO2ASP1OFxDRAeHyrzHmVTlCUOxlbmP
 uQtw==
X-Gm-Message-State: AOJu0YwIqEwp3pMULga00HfVic1N4yM/vbRnYKTAUI6r/0Ao1LVnEDsR
 XMct+MNvfSJyyp5RlfXws8zgmTU3tE9epcUh35MMiTVLmJnMSxpZqIBIsaMfNDBZMb1I5mgq3kp
 FTHdsNoQJj91oPYC5yn1EZ7axSKZ6Le2+uq0MlZ57MLBrok5mkhJSlqHH5HATrj0DMqGLirETX3
 mN1LUbTyAeT0cJW6F2kd0rllp9l1ueaBCGvab1
X-Received: by 2002:adf:ce06:0:b0:354:f2b0:ebda with SMTP id
 ffacd0b85a97d-35527056594mr11106686f8f.10.1716892701669; 
 Tue, 28 May 2024 03:38:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFF9z00vDduVMqpdXX+QLot3fUWnGz08uB1xoHWS2G0TYc6fHz9aV7b7T31eO2g+zmBYfhZag==
X-Received: by 2002:adf:ce06:0:b0:354:f2b0:ebda with SMTP id
 ffacd0b85a97d-35527056594mr11106645f8f.10.1716892701215; 
 Tue, 28 May 2024 03:38:21 -0700 (PDT)
Received: from step1.redhat.com (host-79-53-30-109.retail.telecomitalia.it.
 [79.53.30.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-359b3675c6csm4310736f8f.71.2024.05.28.03.38.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 03:38:19 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, gmaglione@redhat.com,
 Raphael Norwitz <raphael@enfabrica.net>,
 Laurent Vivier <lvivier@redhat.com>, Brad Smith <brad@comstyle.com>,
 slp@redhat.com, stefanha@redhat.com, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 David Hildenbrand <david@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Coiby Xu <Coiby.Xu@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v6 09/12] contrib/vhost-user-blk: enable it on any POSIX system
Date: Tue, 28 May 2024 12:38:17 +0200
Message-ID: <20240528103817.146211-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240528103543.145412-1-sgarzare@redhat.com>
References: <20240528103543.145412-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
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
index 48e476b237..c89ee7b578 100644
--- a/meson.build
+++ b/meson.build
@@ -1981,8 +1981,6 @@ has_statx = cc.has_header_symbol('sys/stat.h', 'STATX_BASIC_STATS', prefix: gnu_
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
2.45.1


