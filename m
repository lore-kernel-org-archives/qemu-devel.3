Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D239C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 08:14:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPHbC-00030u-HH; Thu, 04 Jul 2024 04:13:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sPHbB-00030e-2U
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 04:13:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sPHb9-0001uQ-E1
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 04:13:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720080823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=0Uo9ByMszePi8w1SCN8bp6Plsfpl8+p/Q8/LA+YXJdY=;
 b=fXd1imIt0LU8c/ZAmj6P/97P2enYc0ou0CURu71+5+RdVfadO49dyUgvp1baHZ5SiM74Jy
 Gavuq1f1553s3Yxril2iAIKYIQDXD8jqXglgtEb5QpohjLqiaDvY6oCxicvZeHozkg26W+
 yGI1Jl8fJ2mmPI7TMrWBY6iXZgkWquM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-UlpLvaHcMtasuAIe_zZLpA-1; Thu, 04 Jul 2024 04:13:42 -0400
X-MC-Unique: UlpLvaHcMtasuAIe_zZLpA-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-79d588000e4so59412485a.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 01:13:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720080822; x=1720685622;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0Uo9ByMszePi8w1SCN8bp6Plsfpl8+p/Q8/LA+YXJdY=;
 b=TTtdXffDTe0VeEkvRvbR54zHzkaHCMhkIvChU2dFDSOqnSDjzx9qQzWtQabVZ5cMua
 aKGaPSxrAGCfGooYXKzpMmBrV+P4/6+rrNzFHr8Sy1IoIjg2gkzoE9Z4aGmONMTZWz5R
 PrE1VM5SpEXFSjbk6AeTJlIVRfb+GthYybXab/QdQupdJGp8gEr233kRmlzk9n4arzUM
 1/bxNz7XtD3DfjprEu01oQRUL3hfFEhr7oRCy97cif3D9yzo0jSzDH65p2CEzHA2qL0q
 py9rH15HI+OI8PheJbDbtXE4lzzYeVE8tv+SrpxZ7ULuNNyiOWCtFkR7JnWdOkOqe4Es
 hb5w==
X-Gm-Message-State: AOJu0YydzRmVCj696ENPhMPO0mOBdZRxZUI0n2390UX9r14BHVYP9R88
 SFo02plInOAToZUf2Fl86MR8IaD2xoGVbZqNGi7fiYQsxU62rUW6+OCW22JBhjLv6PlDsDdoR4f
 +nNQd9vaUMKsBdhFC3w0y+8icUCdLQtZhd3ZV8bCcg2xWeqC6d2xlUTbe14QteIWYPOs4YVfIsA
 jQJsx9lLLsa4uX3uEKpHn1KdB+TOGhvcV7MTUD
X-Received: by 2002:a05:620a:849:b0:79d:61bb:78d2 with SMTP id
 af79cd13be357-79eee20d40cmr99820485a.1.1720080821837; 
 Thu, 04 Jul 2024 01:13:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBCtj6jHHICyfG+UTMp+/Cq+W77aiuTWghbfzv6jsMS7VCMPdMH/euOhumPWZ/7+2xfnJ07g==
X-Received: by 2002:a05:620a:849:b0:79d:61bb:78d2 with SMTP id
 af79cd13be357-79eee20d40cmr99818285a.1.1720080821332; 
 Thu, 04 Jul 2024 01:13:41 -0700 (PDT)
Received: from step1.redhat.com ([193.207.147.116])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-79d6929be9esm652654585a.60.2024.07.04.01.13.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 01:13:40 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH] MAINTAINERS: add Stefano Garzarella as vhost/vhost-user
 reviewer
Date: Thu,  4 Jul 2024 10:13:36 +0200
Message-ID: <20240704081336.21208-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
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

I have recently been working on supporting vhost-user on any POSIX,
so I want to help maintain it.

Cc: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6725913c8b..47493f19d9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2207,6 +2207,7 @@ F: docs/devel/vfio-iommufd.rst
 
 vhost
 M: Michael S. Tsirkin <mst@redhat.com>
+R: Stefano Garzarella <sgarzare@redhat.com>
 S: Supported
 F: hw/*/*vhost*
 F: docs/interop/vhost-user.json
-- 
2.45.2


