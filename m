Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9562AC48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 11:14:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raDDB-0008TL-EN; Wed, 14 Feb 2024 06:13:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDD2-0008Ku-Cw
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:13:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDCz-0006jJ-Mg
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:13:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707909225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aMCWbZMbJsUeDBMcr0PznqZivp4BA1aEeZXrL0J0rpk=;
 b=fBDegLE/eGV3aZ0V0cur1zXSP5/yQmDzQ90OAI7Z8J11UrtQwRfvgNsC27IKSjm/bG2owI
 bhxH0cHhE6Fg4B+kE9z2WEV+k87G8wT+Hn49xL6KfkxQcFVE6PX34YKnheieFl4mnNXlKM
 jXoZXYJ1qd1oNpsEIPdPX8z+XShbj30=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-t9W0Ej0UNEq64xZ6IZ859g-1; Wed, 14 Feb 2024 06:13:43 -0500
X-MC-Unique: t9W0Ej0UNEq64xZ6IZ859g-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-51151b8de86so5087003e87.1
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 03:13:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707909220; x=1708514020;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aMCWbZMbJsUeDBMcr0PznqZivp4BA1aEeZXrL0J0rpk=;
 b=AePr8Z2BdROTfXxjen227ItDp/xskZZUdbzPVmJih4kID9gY7McbaSeockjPwuEKB1
 qlMNXjBu/3JQvsarWHPPKb4AzWZuRV7zMFQy0FEfiUgzaZQHa16Fmb/VCGr9fGYYf7j+
 n+3O+lfE/Y7P92ubAqLOt2w9c9PRcXj0MnkHVTB4O78leXbC8tN/iWgG4WefMGSv90Y4
 1EwogK/2pdavgFv7dJc2rvUaTuCIuwRkjIEFiPk4VnL0jYdwMd+T2FWnXhGP86B3mU0U
 xeM0JCKSsrQ7Uhz84isyXEXXeYC7L8f4Bxg1ksmO9jbbAw0FFbSQo+yyvrjC73ThAHp/
 JP0A==
X-Gm-Message-State: AOJu0YwLKo457HPbLNWncad4Hh2/EqJLfVglWcO81ukYqp0EuPlfXEtQ
 xnGBVfy6oXH52yJ+DXUTGsXulUfTmXp+k3PG6psXnPLgcPr35uUPGbZFp3+JgvFyOyDJUtZGymL
 hdWsa1RSkmGLISDvDy/cZIGkAIH5hRswS1wV5GJ4dodU8s8foDe9Hx1J5kXLWn7pcMu3JTEjGfd
 2+/Al8RzjqJRNVSUVF6pC8/i8+TBuB0g==
X-Received: by 2002:ac2:4c81:0:b0:511:8d37:4b60 with SMTP id
 d1-20020ac24c81000000b005118d374b60mr1591085lfl.6.1707909220703; 
 Wed, 14 Feb 2024 03:13:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcOoL9frDXTu3cZC84nECDCMtgnu8Wt+YvatVp4G7jnVQAfH/np6ZxHTMHajMMDE7K9yKHBw==
X-Received: by 2002:ac2:4c81:0:b0:511:8d37:4b60 with SMTP id
 d1-20020ac24c81000000b005118d374b60mr1591071lfl.6.1707909220438; 
 Wed, 14 Feb 2024 03:13:40 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCV5gMbGpldpCBiTkSEZMuJhDuOPsH0HWn0WWLfmTrIDv7zIfo6NQA9MCwvbYvGB7JneBEcVMYqvQSDz6GExaTDtotnNWDuCN1T0s4vAylyzt26YLyIUngJJyDKlNkN9ukEV8W7DvgQ+9gUj7w2nfngTEaksIRdxxQ==
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 y21-20020a170906559500b00a34d0a865ecsm2169280ejp.163.2024.02.14.03.13.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 03:13:39 -0800 (PST)
Date: Wed, 14 Feb 2024 06:13:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Leo Yan <leo.yan@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 08/60] hw/virtio: Support set_config() callback in
 vhost-user-base
Message-ID: <a26105dd56a11d5aec618fc5429ae7932d3221c5.1707909001.git.mst@redhat.com>
References: <cover.1707909001.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1707909001.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
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

From: Leo Yan <leo.yan@linaro.org>

The Virtio input device invokes set_config() callback for retrieving
the event configuration info, but the callback is not supported in
vhost-user-base.

This patch adds support set_config() callback in vhost-user-base.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20231120043721.50555-2-leo.yan@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240104210945.1223134-9-alex.bennee@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-user-base.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
index 78cfa9a5bb..a83167191e 100644
--- a/hw/virtio/vhost-user-base.c
+++ b/hw/virtio/vhost-user-base.c
@@ -140,6 +140,22 @@ static void vub_get_config(VirtIODevice *vdev, uint8_t *config)
     }
 }
 
+static void vub_set_config(VirtIODevice *vdev, const uint8_t *config_data)
+{
+    VHostUserBase *vub = VHOST_USER_BASE(vdev);
+    int ret;
+
+    g_assert(vub->config_size && vub->vhost_user.supports_config == true);
+
+    ret = vhost_dev_set_config(&vub->vhost_dev, config_data,
+                               0, vub->config_size,
+                               VHOST_SET_CONFIG_TYPE_FRONTEND);
+    if (ret) {
+        error_report("vhost guest set device config space failed: %d", ret);
+        return;
+    }
+}
+
 /*
  * When the daemon signals an update to the config we just need to
  * signal the guest as we re-read the config on demand above.
@@ -337,6 +353,7 @@ static void vub_class_init(ObjectClass *klass, void *data)
     vdc->unrealize = vub_device_unrealize;
     vdc->get_features = vub_get_features;
     vdc->get_config = vub_get_config;
+    vdc->set_config = vub_set_config;
     vdc->set_status = vub_set_status;
 }
 
-- 
MST


