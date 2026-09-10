Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EADCC88E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 00:25:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4owe-0002Xt-M7; Thu, 10 Sep 2026 20:16:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4ljL-0001bP-RZ
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:51:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4liz-0006Nt-D5
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:50:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789073418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YJvWkUnb4lzQW4cMMtlq1toGA8UHfGJGyMh5sRRga0g=;
 b=br9+eI4RkW+9CLer6Z7cRtkDp2/4NkLAh0hB/6WNf+l9OGBfJnkY+ECWeRPWIHRmLT+eWs
 vli6uViDVNqEOcO8DZc0LWrKnGUqrtiWuEJdHhRq1TzAon+3pxtiqf1Zy1aHnsKjKFUDf8
 XFxLfaCtC6q2wdM4SfFWgweb+ovX/lo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-HORBhjSrN1Ob8gv5N1uWIA-1; Thu, 10 Sep 2026 16:11:42 -0400
X-MC-Unique: HORBhjSrN1Ob8gv5N1uWIA-1
X-Mimecast-MFC-AGG-ID: HORBhjSrN1Ob8gv5N1uWIA_1789071101
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49d2951089fso1540855e9.2
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071101; x=1789675901; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YJvWkUnb4lzQW4cMMtlq1toGA8UHfGJGyMh5sRRga0g=;
 b=sLAc4pRwhlOOkauIbEHcruimtkVejRcVZumYJa5brS0xS2dhMgus6tUQCergItlvFC
 ytSrJSVRcSG0chIN+A2Vm2nSK3kDdEkrAVqe1FfckNiozdgAnXeN+90EuL7V3b+LBehk
 7/a4GoDaJpUOtRMPLiy61afZjC4SMJdfl9AdoBUwlny8VOuDWA4uxs+9f6BwSVBRp8Lp
 pYFzZrKyi79w9+ZkvE2ULx2ZXZe3gqH6113LAmiduhAYNdh8XZftDmPAr5VP2roih61B
 eLwdTl9RlOLtCajplLeb+biLIPtj6v7w08Tm0E5OUJ+R+/nJBdJyhtjH6m+NWkzmKO1h
 7LJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071101; x=1789675901;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YJvWkUnb4lzQW4cMMtlq1toGA8UHfGJGyMh5sRRga0g=;
 b=AaD7AT7Qn76nBzgxmPjku/KHyTItpo8uRNNHQhExw65GM97du0o3EAOHG9i0CJpmTb
 RmDsoG3VK4FvZ50u52cOIuQBimV+SeSwASZdlLSC6BfHbdAsl86uEj12vX/JIvAWSALT
 cKZIg0gHaJiZPjBQB18ukHm96FhvhTei9uqyZGeIhvhy8DzfseI3JT6aLxYBfAh7O2bc
 R5NFPgSXwJugMFjZQnufHu1aYcrAP2CtdX2mg1wuGKUER9EZ+34XoNuk6iDiUN0SbYWb
 F0V+9ZpAc97aQWinCY0sWxstZ1+rvZj1+QHFLN1ohW5rk4EekNiQa0Ubi+Nj1PmzzZmq
 b0mw==
X-Gm-Message-State: AFuF++nQfotso/3NEYqfbmOoMjKHjVLoMvP18oThan8N18wzPrdM/t9+
 6foNUS1YR8Kvw05UTL7X/8S9MDpyvk0Md6MojAHx55ruIyNBuXiWXON0umav2yJOxGTRhA9tZ8V
 3xt4erOJGYBVGmupgB/2HO0EANdhar7hHOZHB5kHYt0WBG3Pce3U9Sq7lE7XXTsDQA+z/A5ERaP
 9LlTrIt6faR+oL9ZEJJPheBD0pwBphyupYAg==
X-Gm-Gg: AYBFou0UqgiDeBJ11gglcJkspThlSoMPYfsmlQZUzolI7weZ69UuwwJf/PDTgawCf88
 j1DiUx8D2NVZcxOOKviwpHdboNyJ5fzjS6aK5KBb3CuDTIs+ZJY6AZaUHg4DODp6O5gyRvFVgug
 Q2r+JQuGiNxbQgB0ESOsbStGV34Imr9VB0l0tjSRP4E4MPw7RE5CdvV4Hm6YhSVkqL2kMJhgYCN
 YqWHJ5RboCv4BX5CC9kgerI9Dmsxggqo1DtssN4LTCOvrcuJ/mFu4pNjSc3WGm2My3YbI35ARqD
 CSCnAtvDl6dOOowJ9SewQ2Tjf82f8nM3HY/Q+AzepAT1YexYmMHxiTN2cSe5gr/L9DNbdYaZXRl
 bu2agG61v70OD7JRZv7KGYoc=
X-Received: by 2002:a05:600c:3104:b0:499:621a:2ec2 with SMTP id
 5b1f17b1804b1-49e6188899fmr8133935e9.3.1789071101023; 
 Thu, 10 Sep 2026 13:11:41 -0700 (PDT)
X-Received: by 2002:a05:600c:3104:b0:499:621a:2ec2 with SMTP id
 5b1f17b1804b1-49e6188899fmr8133655e9.3.1789071100400; 
 Thu, 10 Sep 2026 13:11:40 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26c2985dsm162559465e9.6.2026.09.10.13.11.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:11:39 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:11:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 07/90] vhost-vsock: don't reset connections during CPR
Message-ID: <ed7128713ea04b1684705069dab8c8c5f2ad365d.1789071042.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

Migration target with a vhost-vsock device in the .post_load() hook issues
VIRTIO_VSOCK_EVENT_TRANSPORT_RESET event to the guest.  This results into
the guest tearing down all its vsock connections.  That reset exists
because after a normal migration the cid may change.

However it's not true for CPR-style migration.  In this case cid remains
the same, and we want the connections to persist.  Thus, let's customize
the .post_load() hook to skip the common transport reset part in this case.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260820113955.509478-4-andrey.drobyshev@virtuozzo.com>
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


