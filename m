Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D2EDC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:53:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8lV-0006WC-UG; Wed, 03 Jul 2024 18:47:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8lT-0006QY-19
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:47:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8lR-0002GP-1I
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720046868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iKFeowSJAGhilDZfxfLdJ5fHZQGvWfI2BMoyWfTY0Wo=;
 b=bo7FKmbbc1G0KaxeCRlvOw9ACUdpeRXf2UsxsxjqY3a7cgSFCgbDDt7oNq9dp/KRzcVQsU
 bqNTn4J8uTnie/wdl+6cpBF71d6cjdLKsJ5eBBYFGIczg4ACLJmRkr0bfogYYjPdMbbueZ
 F1pZGg6Ox0YDRntKmTY2VxafBH5/h34=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-KmtqptZANoO0JclCX1T86g-1; Wed, 03 Jul 2024 18:47:47 -0400
X-MC-Unique: KmtqptZANoO0JclCX1T86g-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a72b3066669so9667266b.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:47:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720046865; x=1720651665;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iKFeowSJAGhilDZfxfLdJ5fHZQGvWfI2BMoyWfTY0Wo=;
 b=odMf74fbwOfTwWdcDcIpI9e/gameFjpZpa5bZO4az3hGg5U0aYDWOUv5ACT8O+bN/k
 yBrb4DDuj5agbETRzIZ4sW/sin3Br5c6td3xGIi+HJjTl4Vk2rx6pLcPDhVgd0fSFZB+
 L34/J4FkMw0pZ1RPRKDNuqSs82CFt0sr6GFkFAB3T4J01C2h0ZKSqzOQDBqitZ3omzlX
 pdpqFeFvHdOUkfwdHq32769Tr3UGxeu193d8EfDBp1Ne1X3E+xW/B5tkX/aslVnSWE8v
 5HNPXO+fKGMABtr/40DVhPt6SiIiXs/1PFDNNyBlFrLHA8xq95xKArR4MwmcH33PhoW0
 aHIg==
X-Gm-Message-State: AOJu0YwxOlxVPvnZpg7HnRKCPtnfvqZickd+qb2sdYQGa6s35XanjzW2
 Sb/Azk5n5twe48tvkDhlkpBzc9Dd4xeVvOSnKCq9AiIqISO2kyLj5QtIYaaaoMcnAmBe49WxK1/
 tF0hItq6xvSr0V/KNUZ1tK0s3n8UtvJ57f0cMSA/nRh4XAQR40zBZYwBHYFs4JMsj3drGKaP0RH
 fcfVIBAfzs7fUbZ9YnLAXr3KkwSJWHAA==
X-Received: by 2002:a17:906:f253:b0:a77:a1f1:cfa0 with SMTP id
 a640c23a62f3a-a77a24bf96bmr190866066b.36.1720046865683; 
 Wed, 03 Jul 2024 15:47:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFt2C9AeF7MAAHhDNoynI8ekEyZnCbl/v3ZvJszo1gwJJSLEtFbwPtTGbeBmVKxzpuRZbD0/A==
X-Received: by 2002:a17:906:f253:b0:a77:a1f1:cfa0 with SMTP id
 a640c23a62f3a-a77a24bf96bmr190864566b.36.1720046864904; 
 Wed, 03 Jul 2024 15:47:44 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72ab08d0dcsm542426866b.166.2024.07.03.15.47.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:47:44 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:47:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 BillXiang <xiangwencheng@dayudpu.com>
Subject: [PULL v3 44/85] vhost-user: Skip unnecessary duplicated
 VHOST_USER_SET_LOG_BASE requests
Message-ID: <7c211eb078c42146ee9a441cc028fbc4c378ef5a.1720046570.git.mst@redhat.com>
References: <cover.1720046570.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1720046570.git.mst@redhat.com>
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


