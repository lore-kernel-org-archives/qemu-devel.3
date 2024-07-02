Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B80C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:11:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeCc-0000uA-2G; Tue, 02 Jul 2024 10:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeCV-0000Cf-3Z
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:09:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeCI-0008MY-2H
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:09:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Yh+r83dQTqjKVESuK/txPttml/pXNBlxCl8GGxw4h4=;
 b=StIVAVb6e95DBzsJ4iIYjxLmVKyxr74KtIsnebjGOIbjgoHSppoQ9xyGefJAa3o+iAHxjV
 /APMCmF/xCrVTMXPojlvjq3t7D7s3CSShyaeP+tVz8N06eV/JeWGL0ZEdW/v2m/SexDs7x
 EQIsj+F/MeFjs7JSXVIR7+mBgnXNayo=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-Nz5FI3E2OR-FESRZXlexiA-1; Tue, 02 Jul 2024 10:09:26 -0400
X-MC-Unique: Nz5FI3E2OR-FESRZXlexiA-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-52cda76173dso3718661e87.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:09:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929364; x=1720534164;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9Yh+r83dQTqjKVESuK/txPttml/pXNBlxCl8GGxw4h4=;
 b=tytyxJuIlQFPCzzY1t8rKdnhEOWTE5NatniYNizlEoUqjmzmFvtIYdlEiAQy67xxJv
 /pHsQ8VHJqOUZJ4Ux0MS1oYxHZ/+hF7XfRS1YcZUr+Gt9Pecw8RfBM7OHn76su9x16/h
 +FVZ0tfBw/2mQu72c535xdoAee3syIFTJs1k6apuTwnYDnY9W9NEvJAm6EEdV2WLn8lz
 FM9LcIWzg/1AQyM6ArctNd1FUPLhMfmacndCFnjSs8uW73EiyfrdNZu7lde8y+aZQyJJ
 sLSvSMgHBh2ACWWgPotaC6pCp9aVeCBz3c0xQb+IV4+C9Jtp+UudlXmw+Aool0Ak+dsX
 kgNw==
X-Gm-Message-State: AOJu0Yy+niL/zT1/s0yKQ2IZf1l3Cb1Ew6v4R1rtrHc8/Jdfr9cm+69y
 Ab66MXf/joOMKmVhudFcUKUwyIiaK6KbqDjrSORJDC3013NfWHSIvJGKla5VSDSOMAIeIdzEbWB
 9K0mcXw6gHwJgotQVYdAwIA/n7Pu6+HlVFtiAMbOXCBN+XkvSqmtkUH2H1SgRPJb8CfXDV2VF6v
 n294zz721FxRRl2i2MxCiUcSENvtMmRw==
X-Received: by 2002:ac2:5487:0:b0:52e:934f:bda5 with SMTP id
 2adb3069b0e04-52e934fbdf5mr295007e87.21.1719929364764; 
 Tue, 02 Jul 2024 07:09:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjLCZB0TTmwTxPaTT7oZELPvIz9ZnN4D8cv5pnsdsIn/4sJ4ao74zoCZstcalRZYnOT6lbnw==
X-Received: by 2002:ac2:5487:0:b0:52e:934f:bda5 with SMTP id
 2adb3069b0e04-52e934fbdf5mr294980e87.21.1719929364190; 
 Tue, 02 Jul 2024 07:09:24 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b09a2bcsm197928645e9.36.2024.07.02.07.09.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:09:23 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:09:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, Eric Blake <eblake@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 47/91] libvhost-user: set msg.msg_control to NULL when it is
 empty
Message-ID: <e4720435db1906258f9d18930fec05a900b008f2.1719929191.git.mst@redhat.com>
References: <cover.1719929191.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1719929191.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Stefano Garzarella <sgarzare@redhat.com>

On some OS (e.g. macOS) sendmsg() returns -1 (errno EINVAL) if
the `struct msghdr` has the field `msg_controllen` set to 0, but
`msg_control` is not NULL.

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20240618100043.144657-3-sgarzare@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index 8adb277d54..53bf1adda6 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -632,6 +632,7 @@ vu_message_write(VuDev *dev, int conn_fd, VhostUserMsg *vmsg)
         memcpy(CMSG_DATA(cmsg), vmsg->fds, fdsize);
     } else {
         msg.msg_controllen = 0;
+        msg.msg_control = NULL;
     }
 
     do {
-- 
MST


