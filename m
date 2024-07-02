Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA2EC30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:41:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjxr-0005hT-Rx; Tue, 02 Jul 2024 16:19:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjxD-0004w5-Uu
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:18:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjx8-00009f-CU
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:18:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iKFeowSJAGhilDZfxfLdJ5fHZQGvWfI2BMoyWfTY0Wo=;
 b=cmFRM+aEm+p7hnM2QQUI7+TqSiLXTJjEpk6Dc/9QzryU/DeqVnM2QyzB1MiFS2Zu8OLxLO
 wK1bZy9Qkeg3yuEk/LXIVw37GfdWtu5aia/7hJQIZcCtxiLqireYiO6Q3Dn8NVB4u0AF49
 5L39WuhhPiNGvm2hN9TU4D+bWlBk5Xg=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-_F-bNjI6MY-6t6BP1u_J5w-1; Tue, 02 Jul 2024 16:18:11 -0400
X-MC-Unique: _F-bNjI6MY-6t6BP1u_J5w-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2ec617f8b6fso41921531fa.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:18:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951489; x=1720556289;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iKFeowSJAGhilDZfxfLdJ5fHZQGvWfI2BMoyWfTY0Wo=;
 b=RH5hGKRvx6vhuFMOCWZ4qPhgJw5fu8IFPtcYphXFu+mKPOqh91gd7PuLsHTgSI+w06
 0NK28bwihiY39NdSqcBvtoJnzMOoJDgou9anGUH2yez8yOFaR4jOLostAapsk3qbWotO
 IsYob/VWP8dR5OuwMb0xWx55UeBP++SUaEdckwi1RGbcEdKfxDiw0V6wNmJ7oFeuR+eB
 hECj5mMbMIRz169CSC6gQuDzSCHB7RPeVoCakEDad47JS6V/is4u9pSamfUIO7p1iV7O
 8vp+bfwMePl8Btr2/rHZYW7Khuy1I7R+Q9T++xp0hUFE/6yTH4tq+1QV6zbFh2o6UkBg
 xGEA==
X-Gm-Message-State: AOJu0YzLWMk4+WoGKQ/2QvB9iji9DdnFcXdkAzGhGq9XvKHFvoDoTG2I
 Fg/VVhulylcCOzIYzGAgCqe+rgUpGKhexQ1wZUcwwAqLoGJjk3hm/Z58RRD3aprxL7Cz2/Q43hE
 8qhxgtqlWBeklLp3KF1DpfgXSKXbQIKbS69q63sZjlEFnMOnOESQZN69/zkfrhsFQuTeGvSJprq
 2+Go2rnO0q5a2rF1vLKvOXpOXxTxaPkQ==
X-Received: by 2002:a2e:9e98:0:b0:2eb:eb7c:ec1b with SMTP id
 38308e7fff4ca-2ee5e4c3824mr58295621fa.25.1719951489151; 
 Tue, 02 Jul 2024 13:18:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtLMbCQtzpcnUvy4pCVc3jirrVzBvjUNxySLJkVco5w4j6MVxcFHJpugV5ehT/3qyTLIVWVg==
X-Received: by 2002:a2e:9e98:0:b0:2eb:eb7c:ec1b with SMTP id
 38308e7fff4ca-2ee5e4c3824mr58295451fa.25.1719951488503; 
 Tue, 02 Jul 2024 13:18:08 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0cd687sm14181249f8f.14.2024.07.02.13.18.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:18:08 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:18:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 BillXiang <xiangwencheng@dayudpu.com>
Subject: [PULL v2 44/88] vhost-user: Skip unnecessary duplicated
 VHOST_USER_SET_LOG_BASE requests
Message-ID: <7c211eb078c42146ee9a441cc028fbc4c378ef5a.1719951168.git.mst@redhat.com>
References: <cover.1719951168.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719951168.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

From: BillXiang <xiangwencheng@dayudpu.com>

The VHOST_USER_SET_LOG_BASE requests should be categorized into
non-vring specific messages, and should be sent only once.
If send more than once, dpdk will munmap old log_addr which may has been used and cause segmentation fault.

Signed-off-by: BillXiang <xiangwencheng@dayudpu.com>
Message-Id: <20240613065150.3100-1-xiangwencheng@dayudpu.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-user.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index c407ea8939..00561daa06 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -371,6 +371,7 @@ static bool vhost_user_per_device_request(VhostUserRequest request)
     case VHOST_USER_RESET_DEVICE:
     case VHOST_USER_ADD_MEM_REG:
     case VHOST_USER_REM_MEM_REG:
+    case VHOST_USER_SET_LOG_BASE:
         return true;
     default:
         return false;
-- 
MST


