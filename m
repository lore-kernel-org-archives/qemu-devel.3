Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34E2606A324
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XNXmj8n4;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=iu1cBFY/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7FB-0006C1-G2; Wed, 28 Oct 2026 13:15:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7Ef-00055S-Lu
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:14:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7Ed-0003V4-EH
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:14:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TP4xbYwqONGRKPugCPm5MGThHIyQAlbYnSnrbWAdh8s=;
 b=XNXmj8n4cqH3Ry3FU2SvRhaopEJLujp8CooDe6VTic5yX6rFJuwYlYbaKE9hkZVmHf16HT
 jIkrfcHd787CDLCLOmwVN45AkJIVfBDtt1bNCv82n1wzjQSJyYI/BVJKdmPIU719vYy8sH
 tnRIaexIgVPt0B7RmRh+NCXzEd2Jj5E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-7X4zmzlxMq2V2d9etN0tWA-1; Wed, 28 Oct 2026 13:14:44 -0400
X-MC-Unique: 7X4zmzlxMq2V2d9etN0tWA-1
X-Mimecast-MFC-AGG-ID: 7X4zmzlxMq2V2d9etN0tWA_1793207684
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48c6a1d4034so1064397f8f.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207683; x=1793812483; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TP4xbYwqONGRKPugCPm5MGThHIyQAlbYnSnrbWAdh8s=;
 b=iu1cBFY/EfFZEUOD2m3uipf3Rk7BsxNXJhq8HwExZiV+6oohl79jqfM1Kut+tcLvhg
 xCUSzvB4lYSLzE1l3p90Q4RbJ4dHXiKbKjdpLYSVk9Y5WBStI+i2WoVmBOTlSleNZdTC
 Xfsyp86/9gO3/djM7inP4yYE1Gnv7BnfR9gXXS5wHjMpuzM7TzvZ3IUQ7tuMFXkY8r4o
 E64a6Lu95ihs8xJDuGD8u4a9vEvh5OQLYFVAJo4/ls8E+DNwbmnPCkPIixYst6kLlZO1
 xe5cW9n/kq2Ld9jaaC5ZY3zj3WXdBUUsuZEQSEKylvo5U+HRKHW1ctd5208T0fcp0C2n
 O/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207683; x=1793812483;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TP4xbYwqONGRKPugCPm5MGThHIyQAlbYnSnrbWAdh8s=;
 b=ynjAQWm9tj96Xp/NhpBaKQD3bt1KXtJOEzqMUHUbvqPY2Zay1eYneuHIxi0ntxm39j
 isgOOb563GeCNtWzz5pHVewnookFwwKA9mEeiBSMfwFTMk+2JToEbltD0/EaL6wMkAu8
 Pk2VkxT10h6PRh7VGY2SNUP5C1eKlJZPxJHQhbml9+g9azQbDQ7yMrz86Gbsn7I10oS1
 wrrLMeeOM49qdqEI3Zj8OaXz1quPzuJaj8JTi+xPctSEBUuyqil0IR3hktdeJVLd42kj
 k4NK02huOOYMsDv0u1Glt7Tjggc5YILq+jymo7BB6lEbxBMTKtUycEU8QPWqTUnj4yjf
 gepA==
X-Gm-Message-State: AFq9FYJ1v2KqOWcLR+AJpDd3lkDlNF69lr7ceNZaPQBXSnn/uZCQhZ4K
 3mNEWOaQ3RJwKb821tL4uHSKax+3CH1nmMVQ9bM4MYN3mfurwqff/Hu7fluonDqpUD52uk+tvzs
 18TtfBL8J7+TyPu9pZzJKhs8RXRbO6+HjqH9+prFDXsAgGmNiqIqCuwnTBHUXebfEElwcHpdTJ4
 G37xlHA6ER/CCjVVMvmAkfsrpzyMrlv81V5A==
X-Gm-Gg: AYBFou00yGuvw5QohetEHlKaKRVxvcyfiw8T4T8HwruSlh7wu43MLoJHjglxJ5te5e7
 aFuEG9XMVqs2Db0J2AlOZmMHXlJXm0B240D7OtMGhqVTYNo5kHAQZwVW4zKPcH0zz7qv4bxPmwD
 PK+dYnU30fnzLlGlFY2OuLJYYfsj4G69Snfz1y6U2iVRWOytn0SqGDXoRcAz6WVw3Sas9gwAoOM
 D+pd27e84VsUB8qy9P1X6x/DoWI5jTXZqBjlMr17uvF9eqvMby2eUQ3OLfa01EqJhyAFztaDvdS
 eevZ0VQYRYygHsIFfVScJyW/0cWjPzfUZUPkrBGO2PXG0xNeFqbqii4Hg0JtSCdBQtRE2wRT/X/
 4IvGNGLeee68zmYcHSiKBZKS5uuk5vBI5GIy0FSbm
X-Received: by 2002:a05:600c:3c98:b0:4a1:f9e6:f418 with SMTP id
 5b1f17b1804b1-4a967ba6b5amr65641845e9.34.1793207683287; 
 Wed, 28 Oct 2026 10:14:43 -0700 (PDT)
X-Received: by 2002:a05:600c:3c98:b0:4a1:f9e6:f418 with SMTP id
 5b1f17b1804b1-4a967ba6b5amr65640925e9.34.1793207682663; 
 Wed, 28 Oct 2026 10:14:42 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3eb8f36asm29526121f8f.1.2026.10.28.10.14.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:14:41 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:14:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL 18/78] vhost-vsock: fix FD leak in realize()
Message-ID: <8aca0dd40310650960b28143657ac75b4685514c.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

In vhost_vsock_device_realize(), after unsuccessful call to
qemu_set_blocking(vhostfd, false), vhostfd gets leaked.  Let's close it
explicitly in this case.  CPR-saved FDs don't get automatically closed,
thus it is safe both for vhostfd obtained from cpr_find_fd() and from
open(/dev/vhost-vsock).

Fixes: 384c2561bddf ("vhost-vsock: set vhostfd to non-blocking mode")
Fixes: 701544cfaf46 ("hw: replace qemu_set_nonblock()")
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261012-up-vsock-vhost-v5-v16-9-36c38bd15ffc@virtuozzo.com>
---
 hw/virtio/vhost-vsock.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index c582ac9fcc..3ec20d8760 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -176,20 +176,17 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
             error_prepend(errp, "vhost-vsock: unable to parse vhostfd: ");
             goto err_blocker;
         }
-
-        if (!qemu_set_blocking(vhostfd, false, errp)) {
-            goto err_blocker;
-        }
     } else {
         vhostfd = open("/dev/vhost-vsock", O_RDWR);
         if (vhostfd < 0) {
             error_setg_file_open(errp, errno, "/dev/vhost-vsock");
             goto err_blocker;
         }
+    }
 
-        if (!qemu_set_blocking(vhostfd, false, errp)) {
-            goto err_blocker;
-        }
+    if (!qemu_set_blocking(vhostfd, false, errp)) {
+        close(vhostfd);
+        goto err_blocker;
     }
 
     vhost_vsock_common_realize(vdev);
-- 
MST


