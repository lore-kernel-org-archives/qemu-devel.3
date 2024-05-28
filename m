Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11AA9C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 10:37:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBuBu-0004RU-9N; Tue, 28 May 2024 06:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sBuBb-0004Hj-OZ
 for qemu-devel@nongnu.org; Tue, 28 May 2024 06:36:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sBuBZ-0008Bk-0i
 for qemu-devel@nongnu.org; Tue, 28 May 2024 06:36:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716892564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1S2/FREUTloncOeuDDrajxRNh9S3+Gj4t6YZDhkj1gc=;
 b=XdJ9IfzdSiPo6JAI3hPN0bDMcDdKxk4Epx9hxpNrAl59bztjPKc88vDxVukfubO+jj7/W+
 BxUXBw9mRKM8wEvwPG17zLwVCgdnryIbZyVx+BrLVETToPp1JEkUNJtSPde8t8mKkXRokc
 b99RrEVMcysdGJmS4JJArykfEdwwVB0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-AbgRrUeLP3egJT5C4pfgyA-1; Tue, 28 May 2024 06:36:03 -0400
X-MC-Unique: AbgRrUeLP3egJT5C4pfgyA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42109a85f5cso4638865e9.2
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 03:36:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716892561; x=1717497361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1S2/FREUTloncOeuDDrajxRNh9S3+Gj4t6YZDhkj1gc=;
 b=CPtuFxytrijp8joprFPvbRntR1DbISliBDT+vMUtRNrvNqRuY9C3mIvDJU5JUgPFaC
 Q+DK0oUhVb1n1n/78Ggm9eQmR9U1nnwyx6sGLkXjd69q5IngZQkBDUYlNwZT55wfw4Gl
 Dmvd51foP3lOP1yrQzB5QUtgVMCd5ioKDudxisHE9Ec46sfsEo28HEHtJEuR/e6d/ceH
 UiXfhGxhxYS4iqvRFJUxd4CySh3l73tQU1B8csLQyZa2HqT6jgK0H1gibH7i4nEHUaUB
 ljDMYVqT5RR6BxEtNWEOIpJk+e6PXUiulcxO2wT9HPDf8QhFB16dho/xTTFSCFjoLWrW
 Yd0w==
X-Gm-Message-State: AOJu0YyWc2VY7Sw+uFzHZ3BxLKRcvRhYWp4kePJ/X8O+IwBYk/0w6V9J
 AHh8DufPnnVD354ehfXvaKxwBVozncGz8IX5iFst+evToggCWEKtSmWSQ0nCU8UrBbZs+16SkTO
 us0G/XKghPvOnyrizzysOdFYJtJGWeo82X1ily8Xteqo/B5jmU1TamoEgzML6u4w5V1PmTevCYg
 xF1rZ9TbR9ZR40wFX52Gvvl0a1uIh+1g8WUI22
X-Received: by 2002:a7b:ce8c:0:b0:41b:edf4:4071 with SMTP id
 5b1f17b1804b1-42108aa6fc3mr136175265e9.35.1716892561665; 
 Tue, 28 May 2024 03:36:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAHjoS3mWbS3S5UrzxHwxs2o/RE6gwgI0Ih4ab6GDi4TNszd+g85Axky2YD+4HZL6p13/6FA==
X-Received: by 2002:a7b:ce8c:0:b0:41b:edf4:4071 with SMTP id
 5b1f17b1804b1-42108aa6fc3mr136174815e9.35.1716892561256; 
 Tue, 28 May 2024 03:36:01 -0700 (PDT)
Received: from step1.redhat.com (host-79-53-30-109.retail.telecomitalia.it.
 [79.53.30.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35579d7dba2sm11244776f8f.17.2024.05.28.03.35.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 03:36:00 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: slp@redhat.com, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Igor Mammedov <imammedo@redhat.com>, Brad Smith <brad@comstyle.com>,
 gmaglione@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Coiby Xu <Coiby.Xu@gmail.com>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, Thomas Huth <thuth@redhat.com>,
 stefanha@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v6 03/12] libvhost-user: mask F_INFLIGHT_SHMFD if memfd is not
 supported
Date: Tue, 28 May 2024 12:35:34 +0200
Message-ID: <20240528103543.145412-4-sgarzare@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240528103543.145412-1-sgarzare@redhat.com>
References: <20240528103543.145412-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
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

libvhost-user will panic when receiving VHOST_USER_GET_INFLIGHT_FD
message if MFD_ALLOW_SEALING is not defined, since it's not able
to create a memfd.

VHOST_USER_GET_INFLIGHT_FD is used only if
VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD is negotiated. So, let's mask
that feature if the backend is not able to properly handle these
messages.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index a11afd1960..2c20cdc16e 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -1674,6 +1674,17 @@ vu_get_protocol_features_exec(VuDev *dev, VhostUserMsg *vmsg)
         features |= dev->iface->get_protocol_features(dev);
     }
 
+#ifndef MFD_ALLOW_SEALING
+    /*
+     * If MFD_ALLOW_SEALING is not defined, we are not able to handle
+     * VHOST_USER_GET_INFLIGHT_FD messages, since we can't create a memfd.
+     * Those messages are used only if VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD
+     * is negotiated. A device implementation can enable it, so let's mask
+     * it to avoid a runtime panic.
+     */
+    features &= ~(1ULL << VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD);
+#endif
+
     vmsg_set_reply_u64(vmsg, features);
     return true;
 }
-- 
2.45.1


