Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45D0606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CTcZfOO4;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=lZCo/CKi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7FE-0006Ma-3I; Wed, 28 Oct 2026 13:15:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7Eg-00055U-7E
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:14:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7Ee-0003VG-HB
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:14:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bbUceoQZ1O//ngot+5pqF7/YK3XY7d9HXvofIJ4XA1U=;
 b=CTcZfOO4o5h+zJh7HnxXrLKd0Npqy5iCQD+iO7Se03jDowaBLTe0ncj17RDRBzg6+49wMS
 X3AqKopZ6VYM5n1ggBB1W6WMLlzaDhf/5XiaD8A6Pdu3sKVM+Ki/pNEXaIRRYA1/YN+OMd
 pB54Lg7Au6WqY/mYdjHjhgAFUBwua2g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-dGEWCgYLPT63kMv1l2z6Fg-1; Wed, 28 Oct 2026 13:14:42 -0400
X-MC-Unique: dGEWCgYLPT63kMv1l2z6Fg-1
X-Mimecast-MFC-AGG-ID: dGEWCgYLPT63kMv1l2z6Fg_1793207681
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-48e29c25101so711219f8f.3
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207681; x=1793812481; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bbUceoQZ1O//ngot+5pqF7/YK3XY7d9HXvofIJ4XA1U=;
 b=lZCo/CKiRyju5947tMLAbpuYZdBdRGb2mt3RtE3Pz6dVFZt/KY/xxedq+C8eDIwh9m
 OEdWh5SUpKPo19JvNV9Z9/Z5yEm6h8GgdZsgzRWQKGtWc71RLmLReHbsOAbvyxEf3dZz
 KWZ46dy/iVrOiDrcDx85AaCWev6+SvVjEFGvn4j2o1622zqpAp+mgnE06L+NVn/2Z7+A
 fI7eIHJApjrk1kFxlYPDoEwNWweyOnil9mYnZzKL2Apj82cnbSyU41XxcVl086iYDQ1I
 B3ZMgk616raNdqfUxpVz2mVetp0YBoIaA9GUUsV4OCXrJe2dCPLuV8MHmHPo9cBuFT2Q
 Cu2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207681; x=1793812481;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bbUceoQZ1O//ngot+5pqF7/YK3XY7d9HXvofIJ4XA1U=;
 b=YWIvpOaWy0y03GNAW9h0rP32eeSdUDZ9voBx2/F7cV1feozRrznN/vzEvH2u3yL4ay
 e0iYj9JohvCCkGmDQqay6JTkb39GPQ/5BxUv/nppxBRZ2a+ChNTJH1Yc76dKCMaer47X
 0mvuPM6lGpiaFRbanGFPv1tC+JHOgr0CdCduZb/WAKxsEOSVgo5Gj4liSnauSig5g/1p
 F0jYwUZ2jIXLeA2dZGyckoWA0dadF5Cr3Vam0uWtxPiuFhRUHyxpr+WxEtQVU0UR+xwS
 yMTcwVK3TRxfHKyARt7DO8aarbzhKZ9oOxBIXFYB+kSuQQOG4RQwr6loZrjw4XnPsUaC
 BHsg==
X-Gm-Message-State: AFq9FYK5Up4CCr7S4TZRIWJM7v641b/9nmwd1q4Bu/lNmn7TY3PUNfJN
 CQjpqIh2ja+wu7gMQlAVaJRKJcpO16Xq2y50A0PTATs+93TslFFJTrARdUT118opADbd8JXk6vm
 OYTFTImQYE7i1/BYd0X9RUkPGz8+KU9RWMU7VgetakVDVNbmCN27d7XnN8VvWtowsEKbe/qSFu3
 FxzKh5UFkuRBioakUvMvN4yKfQ//lk9chGGA==
X-Gm-Gg: AYBFou2hmHyTPyG/+S5rcGC7Z0P5Gpg8rhZNaxmtFnKV+lFbHtSI9F7CGhUozZuURwU
 YcoxK/c2DP81CWaDuivftvL1RqHbmqg6nOpnPzXUPeIduK8N+aMlpOgiheEUUUqXP3JhxnERux6
 ANJ724jnzgEu1JB7JPXzEr5s8M/aF5Rk7w44CY293PMQ9LwTwGbR8Og68ziRqKl+QGx7Ce4HN/2
 JxVf6JYyv2wrT1wLiH5RD+3BldpYI+enSTFRetbHn8jQtzhVeTzPdw6uHt8py/nH+Hu8g006Hgt
 SeHqHKNGCXvsHip0MNqo2JQ+Wgs9yMIZbZfIu0MroUS/uN6YEO2VyZCbG8v4nH54ks5cjfIyUT0
 hH0LR9ZDts8FDo4HdbxKqIeeiTsTmQJ+kjs7OQYbT
X-Received: by 2002:a5d:5f88:0:b0:48d:eb44:650c with SMTP id
 ffacd0b85a97d-48e5d5d13cfmr7657740f8f.40.1793207680981; 
 Wed, 28 Oct 2026 10:14:40 -0700 (PDT)
X-Received: by 2002:a5d:5f88:0:b0:48d:eb44:650c with SMTP id
 ffacd0b85a97d-48e5d5d13cfmr7657559f8f.40.1793207679750; 
 Wed, 28 Oct 2026 10:14:39 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd3c32sm30643224f8f.47.2026.10.28.10.14.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:14:39 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:14:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL 17/78] vhost-vsock: don't reset connections during CPR
Message-ID: <4d206dd0ff6e949cedde265bc487e0e350edd1a2.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

Migration target with a vhost-vsock device in the .post_load() hook issues
VIRTIO_VSOCK_EVENT_TRANSPORT_RESET event to the guest.  This results into
the guest tearing down all its vsock connections.  That reset exists
because after a normal migration the cid may change.

However it's not true for CPR-style migration.  In this case cid remains
the same, and we want the connections to persist.  Thus, let's customize
the .post_load() hook to skip the common transport reset part in this case.

Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261012-up-vsock-vhost-v5-v16-8-36c38bd15ffc@virtuozzo.com>
---
 hw/virtio/vhost-vsock.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index 503d248a61..c582ac9fcc 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -20,6 +20,7 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/virtio/vhost-vsock.h"
 #include "monitor/monitor.h"
+#include "migration/cpr.h"
 #include "migration/blocker.h"
 #include "migration/misc.h"
 
@@ -110,6 +111,20 @@ static uint64_t vhost_vsock_get_features(VirtIODevice *vdev,
     return vhost_vsock_common_get_features(vdev, requested_features, errp);
 }
 
+static int vhost_vsock_post_load(void *opaque, int version_id)
+{
+    /*
+     * Only reset vsock connections for non-CPR migration.  For CPR the
+     * guest cid is unchanged, and the cid-change reset would otherwise
+     * tear the vsock connections down.
+     */
+    if (!cpr_is_incoming()) {
+        return vhost_vsock_common_post_load(opaque, version_id);
+    }
+
+    return 0;
+}
+
 static const VMStateDescription vmstate_virtio_vhost_vsock = {
     .name = "virtio-vhost_vsock",
     .minimum_version_id = VHOST_VSOCK_SAVEVM_VERSION,
@@ -119,7 +134,7 @@ static const VMStateDescription vmstate_virtio_vhost_vsock = {
         VMSTATE_END_OF_LIST()
     },
     .pre_save = vhost_vsock_common_pre_save,
-    .post_load = vhost_vsock_common_post_load,
+    .post_load = vhost_vsock_post_load,
 };
 
 static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
-- 
MST


