Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3533C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 11:49:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfIQX-00031E-Eq; Wed, 28 Feb 2024 06:48:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rfIQV-0002v5-Ol
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:48:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rfIQI-0003Iv-Gj
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:48:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709120909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HcqLXsmQSW+XhXUFfJdTCoScF/qNMU2I0anlwbmVxFw=;
 b=YJhGWHCpajDD8bBR6W2hYU+nIFp2L/zhdc5IizcLz/jmckeR7E//iEpABIA9T0YOtmb3gx
 aJXmdmBL7ogowCqWCcSPeLZQkhR0QXwNu4gUDdk2UZ6KHGGEzWV8MLFfMmjBD9+JyA6I2g
 Xuae0eECPax8eKcO3ImGfOpihCxqwWc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-TiHA3CcIMt2NwpSmUDCt4w-1; Wed, 28 Feb 2024 06:48:28 -0500
X-MC-Unique: TiHA3CcIMt2NwpSmUDCt4w-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-68f740ea9a8so11727186d6.0
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 03:48:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709120908; x=1709725708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HcqLXsmQSW+XhXUFfJdTCoScF/qNMU2I0anlwbmVxFw=;
 b=rXPknTO+V5Js2ync1nT//bwb498eiPU+5vnWW5BD9BfbKvkdILVXmj/5dL6eaIbYow
 eFDEHfk85rbLEp0ZmHR8sNrS9bUn9l6WMy09JfOubZo3ve9nw91lzR6z2zH3R58QjJbj
 X6JQ34LUbA3ttdvM1/9RspVEVEFTcatVuBG7NjyOJKmre0RvMdn8jJpXLMsygBcBmSTM
 zRz+4w3LI45mgGGNwhKvrIJkOxS3tOrvscL1K1hKZJR3YhCZ/T3h8whfiX4IW2XItGMq
 7nJlssit2pY5dISwT5nZCTupxjncOVZbkNn+EDOVz72CiuMYWlFlOTCZv9C49rTFBDEp
 JGsA==
X-Gm-Message-State: AOJu0YwULBGrHGxzXoDEo9ua65LKP0GR8eOzk5PHRMQqOcdCumP4ONNg
 7l8sm1jq6GfpmITBwgafeX/7V5kPcq22/HcovSTrbUXkRBdimpAkCoI1XSxSgpLj4oX1F9JfwhA
 pmg5AjCCuMPDGyd3N8ha6qMbac8RSTHajDy9K7Cti2nsuq9OQMHjtNKOjFXonVztR2OQDOm7fap
 gHm9+NA55CH4kqUq0ZI1pdtYjR44DY7ZYkxCJq
X-Received: by 2002:ad4:5a41:0:b0:690:2eed:46ae with SMTP id
 ej1-20020ad45a41000000b006902eed46aemr2309886qvb.14.1709120907922; 
 Wed, 28 Feb 2024 03:48:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbh77SomaA0xNQxroyCaIwf9dvwgV7Y8SHz6KMLB/UZiYo4s+G+gKY2WUkhagLIeUQAiIA2Q==
X-Received: by 2002:ad4:5a41:0:b0:690:2eed:46ae with SMTP id
 ej1-20020ad45a41000000b006902eed46aemr2309856qvb.14.1709120907628; 
 Wed, 28 Feb 2024 03:48:27 -0800 (PST)
Received: from step1.redhat.com (host-82-57-51-64.retail.telecomitalia.it.
 [82.57.51.64]) by smtp.gmail.com with ESMTPSA id
 mw6-20020a05621433c600b0068ffde5efb0sm3957832qvb.49.2024.02.28.03.48.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 03:48:26 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Coiby Xu <Coiby.Xu@gmail.com>, slp@redhat.com,
 Eduardo Habkost <eduardo@habkost.net>, Hanna Reitz <hreitz@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, Kevin Wolf <kwolf@redhat.com>,
 David Hildenbrand <david@redhat.com>, stefanha@redhat.com,
 gmaglione@redhat.com, Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 3/9] libvhost-user: mask F_INFLIGHT_SHMFD if memfd is not
 supported
Date: Wed, 28 Feb 2024 12:47:53 +0100
Message-ID: <20240228114759.44758-4-sgarzare@redhat.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240228114759.44758-1-sgarzare@redhat.com>
References: <20240228114759.44758-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

libvhost-user will panic when receiving VHOST_USER_GET_INFLIGHT_FD
message if MFD_ALLOW_SEALING is not defined, since it's not able
to create a memfd.

VHOST_USER_GET_INFLIGHT_FD is used only if
VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD is negotiated. So, let's mask
that feature if the backend is not able to properly handle these
messages.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index 527a550345..5da8de838b 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -1610,6 +1610,16 @@ vu_get_protocol_features_exec(VuDev *dev, VhostUserMsg *vmsg)
         features |= dev->iface->get_protocol_features(dev);
     }
 
+    /*
+     * If MFD_ALLOW_SEALING is not defined, we are not able to handle
+     * VHOST_USER_GET_INFLIGHT_FD messages, since we can't create a memfd.
+     * Those messages are used only if VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD
+     * is negotiated. A device implementation can enable it, so let's mask
+     * it to avoid a runtime panic.
+     */
+#ifndef MFD_ALLOW_SEALING
+    features &= ~(1ULL << VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD);
+#endif
     vmsg_set_reply_u64(vmsg, features);
     return true;
 }
-- 
2.43.2


