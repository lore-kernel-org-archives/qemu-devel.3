Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 027CDC021A1
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 13:56:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thqju-0005T0-0e; Tue, 11 Feb 2025 08:55:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1thqjj-0005Qq-1r
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 08:55:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1thqja-0004UX-JB
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 08:55:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739282129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jnQyqXlpQ9Ccs8q43DjOuigkRbdQriSFhsz142bXJ5A=;
 b=FjcGXzYXYUv0bXKpcoeL/eizd/rGee7uCMCfdeXAnNVIyigkRCxqG5ctgnIxPJOB3u9szo
 vX8CddwGfWIvDdJk/15Z9Z/TkzEgpEGwSfE2b3t8rmLyK9ZsucaGpc807Gtg0Z7Xv7NCYC
 4RJ2BmuFKrH++u89GYrg5+1wj0K+mIk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-58FN60RXPRiRpGLCva4hag-1; Tue, 11 Feb 2025 08:55:28 -0500
X-MC-Unique: 58FN60RXPRiRpGLCva4hag-1
X-Mimecast-MFC-AGG-ID: 58FN60RXPRiRpGLCva4hag
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43933b8d9b1so17078505e9.3
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 05:55:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739282127; x=1739886927;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jnQyqXlpQ9Ccs8q43DjOuigkRbdQriSFhsz142bXJ5A=;
 b=mVrzKzH5hXrcapBRvxKfykXm7VhIlYH+UrtvgTuhVlBl3PjknFgxqbyF3gs2cN6gh9
 qafKCQb80RZeceCChzmNnZnYT3JVymRVPM1ve85WmUgar+pyngMv3ntVF+WcU3ch6RMs
 aIp8JqR+0k0Ofx/XoUUKPTtKb1FfS51dVenS2cSKF9ZkOz8Rq7fw6YNjHfhAtouSQuMo
 Llkthh5IPsFvcG2fLz4AazIifPSRMxWZa4k+6OP303xQHPmiLq4FL3Rnyekph79zrTTl
 7BCe93w4adkZcXh9FLqgoG1cGTo/TPJTipSWvmer3r4EHqroZ8XNynEZXd7crrPG0WMo
 SIug==
X-Gm-Message-State: AOJu0YyZO+CzxkTQdeSxBzKt9LtlFqOUusw9X4nG8mCh4q/zlXsveYue
 sT0wGar8nZaMtlcT5XkT9KBG8HFgeCTEp52Km+rWZWBh+M6OckEQIrzVy07KBgRaJPAUFgguQB0
 A07IuY6607LWiKB0M/dt6D8dqBLQJhUAf6mQh6bEi2LpKbjsB4ZRKeUEE49KeMWsI2o+lH7kBOv
 nSYSicRn9jc0vb93Axd/vzZH0sTf1CYY9zyIxn
X-Gm-Gg: ASbGncsl1qVq5io2tomAvVqrkzXBy4ZaognrYRWWKmHyZwcs8a4/UXOSKe5lbT4pnO6
 MG5Tltrkewy7w4psM302AIX8mmqDUp0MduGWi+Z41Gg/kuUsxbzP8+J/CM5GJO7dahvDoza6Hzx
 7dz0i/BKxH0GcKpoDGCBm01tXyU0dOS9lrvsaNxUt/zbo2+1p1NVXVFNyD+if87A3XYQwAPFsgn
 3N62CkY4Yt8V2IZsxE8H3QWollNc5TpDKZ8FHLauyYWnZgKLY9i8PE3Q/9r4ybIxe81e9QCisHT
 c7Ixp6G7s4Y8VMfGLoKuvNMazNs+NrB7nqNIbSlc0PdqDctPBAM2sQM=
X-Received: by 2002:a05:600c:3496:b0:439:4b7d:72de with SMTP id
 5b1f17b1804b1-4394b7d7607mr51445025e9.15.1739282126905; 
 Tue, 11 Feb 2025 05:55:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFu8If4w3lnrCAyjPl8eeHNVOjrPYRVHgsq8K+JvIyExU1oSCpJqDdhWp/Hc1McI0KX2+GFFg==
X-Received: by 2002:a05:600c:3496:b0:439:4b7d:72de with SMTP id
 5b1f17b1804b1-4394b7d7607mr51444615e9.15.1739282126305; 
 Tue, 11 Feb 2025 05:55:26 -0800 (PST)
Received: from stex1.redhat.com (host-79-46-200-29.retail.telecomitalia.it.
 [79.46.200.29]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391da96502sm182060275e9.1.2025.02.11.05.55.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 05:55:25 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, qemu-stable@nongnu.org,
 myluo24@m.fudan.edu.cn
Subject: [PATCH] cryptodev/vhost: allocate CryptoDevBackendVhost using g_mem0()
Date: Tue, 11 Feb 2025 14:55:23 +0100
Message-ID: <20250211135523.101203-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The function `vhost_dev_init()` expects the `struct vhost_dev`
(passed as a parameter) to be fully initialized. This is important
because some parts of the code check whether `vhost_dev->config_ops`
is NULL to determine if it has been set (e.g. later via
`vhost_dev_set_config_notifier`).

To ensure this initialization, it’s better to allocate the entire
`CryptoDevBackendVhost` structure (which includes `vhost_dev`) using
`g_mem0()`, following the same approach used for other vhost devices,
such as in `vhost_net_init()`.

Fixes: 042cea274c ("cryptodev: add vhost-user as a new cryptodev backend")
Cc: qemu-stable@nongnu.org
Reported-by: myluo24@m.fudan.edu.cn
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 backends/cryptodev-vhost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/backends/cryptodev-vhost.c b/backends/cryptodev-vhost.c
index 8718c97326..943680a23a 100644
--- a/backends/cryptodev-vhost.c
+++ b/backends/cryptodev-vhost.c
@@ -53,7 +53,7 @@ cryptodev_vhost_init(
     CryptoDevBackendVhost *crypto;
     Error *local_err = NULL;
 
-    crypto = g_new(CryptoDevBackendVhost, 1);
+    crypto = g_new0(CryptoDevBackendVhost, 1);
     crypto->dev.max_queues = 1;
     crypto->dev.nvqs = 1;
     crypto->dev.vqs = crypto->vqs;
-- 
2.48.1


