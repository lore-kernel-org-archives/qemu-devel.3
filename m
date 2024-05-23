Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C274C25B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 14:57:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA9se-00045u-Kp; Thu, 23 May 2024 10:57:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sA9sN-0003oJ-Mb
 for qemu-devel@nongnu.org; Thu, 23 May 2024 10:57:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sA9sK-00045p-Ng
 for qemu-devel@nongnu.org; Thu, 23 May 2024 10:57:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716476219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zZczhXGl9TGqY4DRFWizTO3f/10y7CBxCovWDPv4GOo=;
 b=BPn0yU0LiPF6sQwwCC1WOYBzF8PCpRwxFLndPrTQ2yUaSedGQyj0DOBTGat9UYorQgAkWu
 JgGi9byFuHpyy+1diVEOplWo3PghBqbT0t9+KU6n2MUFQ1L89jz9MQAy897sN/JLDf1Gh1
 O8TXucjR5lz6Oaebj+Elzku22pxg+N8=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-LRgyzyCJNeabMvak--grIg-1; Thu, 23 May 2024 10:56:58 -0400
X-MC-Unique: LRgyzyCJNeabMvak--grIg-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3c9ac6d3bf6so1217006b6e.2
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 07:56:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716476216; x=1717081016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zZczhXGl9TGqY4DRFWizTO3f/10y7CBxCovWDPv4GOo=;
 b=NFFspqzUY4NAl5oTq6ajIs0Ot5d6BSCwKHrSrdg1YGj9WS5lHqkLp+MwI60d7ssZB4
 zDMppeU3MD3ZA+h6u37+7OnVseZ2cXDerMG2d7l7frIDtl3zdKdItinffgcNW5DtEBY3
 2y5KUWES4LLSgD+i6fClLfpq9jCUm3FYlSSjDQ8MpZTMTIXbZddH9X1IIbVkKq4LFR4W
 o86Vp3fCXXfoCmRkyjPEiky1rfiSYEvERAYTkGMuv97oQNGaApgo8PxEyvBzC2FaTGaW
 dmOlDD3hqrfqWZ+CqrlmDjdvBZC5nc61EQmDvyzZWYPq90MF8L+bGAFET4R0gGJKHfLO
 SRpg==
X-Gm-Message-State: AOJu0Yx6esA4SbiWEdsfvvqXgr9dC7Kq5CbAPKEQx5WGWU31OZzqI59k
 n04c8WINRLpC4Y2o3M359kyZTdWjHHBMkLQubtioBCo5ll5g+a6QTdI36kRk3gUVfeVyRsMeZnp
 bhKV3GqBXL865/mEGWtCR98Ug0KUM9L6EYlcbKukGvvfBDFfuqM+zvmxk1ZGHzFQk0KHbl1Lh+m
 sgFNEJJ+mSW/bilbKOae00gb6wkNU62mXdJJ68
X-Received: by 2002:a05:6359:5f06:b0:186:131e:822 with SMTP id
 e5c5f4694b2df-19791dded6cmr581440755d.3.1716476216058; 
 Thu, 23 May 2024 07:56:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExActTSjAj/wN/d05Xe/g/oADokunszHmJ6OxbWJtgD5bbKHoaoMylS4WESHfNPf1t0lqpZQ==
X-Received: by 2002:a05:6359:5f06:b0:186:131e:822 with SMTP id
 e5c5f4694b2df-19791dded6cmr581435255d.3.1716476215441; 
 Thu, 23 May 2024 07:56:55 -0700 (PDT)
Received: from step1.redhat.com (host-79-53-30-109.retail.telecomitalia.it.
 [79.53.30.109]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43e3a57b396sm101182851cf.24.2024.05.23.07.56.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 07:56:53 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brad Smith <brad@comstyle.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Coiby Xu <Coiby.Xu@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>, slp@redhat.com,
 Eduardo Habkost <eduardo@habkost.net>, stefanha@redhat.com,
 Hanna Reitz <hreitz@redhat.com>, Raphael Norwitz <raphael@enfabrica.net>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, gmaglione@redhat.com,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v5 10/13] contrib/vhost-user-blk: enable it on any POSIX system
Date: Thu, 23 May 2024 16:55:19 +0200
Message-ID: <20240523145522.313012-11-sgarzare@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523145522.313012-1-sgarzare@redhat.com>
References: <20240523145522.313012-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Previous patches made the vhost-user-blk application and the
vhost-user-server.c dependency buildable for any POSIX system.

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v5:
- O_DSYNC and O_DIRECT definition are now in osdep [Phil]
- commit updated since we moved out all code changes
v4:
- moved using of "qemu/bswap.h" API in a separate patch [Phil]
---
 meson.build      | 2 --
 util/meson.build | 4 +++-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/meson.build b/meson.build
index 543105af2a..06a1835a09 100644
--- a/meson.build
+++ b/meson.build
@@ -1974,8 +1974,6 @@ has_statx = cc.has_header_symbol('sys/stat.h', 'STATX_BASIC_STATS', prefix: gnu_
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
2.45.1


