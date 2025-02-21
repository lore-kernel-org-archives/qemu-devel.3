Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 110A5C021B5
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 12:30:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlS56-0000Uc-46; Fri, 21 Feb 2025 07:24:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS4y-0008A9-Ca
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:24:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS4w-0007CO-FZ
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:24:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740140665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fb35RulI/+ttP697lcY0Hr/k4kUhvbmNTuRv5jMyS8s=;
 b=YVjggYvQByLww2fxQkfqwS22Sf0TjUyFwKglzf3nXAvbG50zeBglnJX/sfr79pWRxUsX0g
 7i1ym/PLCQxItL2v162fzrqLmrmPImK1u/XpQEvjLgOA7K3bKCYf8xyrJ3PnRTevb0F8ef
 os/hzgN72ygO6nbCoz6PKJsLOrxUAUw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-7ml3dXdWPbipH3ka4AJY0w-1; Fri, 21 Feb 2025 07:24:24 -0500
X-MC-Unique: 7ml3dXdWPbipH3ka4AJY0w-1
X-Mimecast-MFC-AGG-ID: 7ml3dXdWPbipH3ka4AJY0w_1740140663
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43998ec3733so10586265e9.2
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 04:24:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740140662; x=1740745462;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Fb35RulI/+ttP697lcY0Hr/k4kUhvbmNTuRv5jMyS8s=;
 b=i9/hKzv8v4hT0DvRG+b757jf5rOLmalH0O1oI7EhETVsxzsSjcvxqJaWN6DSNUVV2w
 uexAbXBmo5SzPJI+MqER6cNXGa103I1nblbfdI94Xn3VX6a5wdHS9IVXFalkOgR/IUeJ
 yp2gtaXtcY+YcaKF5mvdHio5PgvdNb0gGQ1+Hhs63GJlqW9G6GnXC71c2cfErr2a6Lc4
 LQZSZ+Op1ZsYiZXM90qaYTWr6a+1YHFGUQbPPosZI6g581E+Pmz+mxGx2dZI/GnGdDOY
 zkyO7oylJvpiiGjPPC8fCjPfaSTt4Wjo9Ha2O6eCOZ0tS2P3rTivB/25zMM9AEemi1+C
 K7iQ==
X-Gm-Message-State: AOJu0YxybnZZk9FEZW+1VUTLHxVCCVYgQriLhL0AMIc7mw1sT5718U2R
 9bdYXKC7OPXCaV+ICsw1Jit2TKrF1JKLXdKJdHlCklgWbEMf+mt4EsXi3N6lZUvq7Jaobhksjjg
 +K5UutUchno+UZtOKTbCYJZkPeIU7ns3Ud28mgxsFjsGx73hk+nQPnwZJmo7TGWIKXmN/q96tnf
 8G83nw6bHxCaagEwlio4W9P3ouVrCYkw==
X-Gm-Gg: ASbGncuz6kE2PVBvJYUQUy2yiOEEAheNz6kfeG6o4s8yjgc6roAJadv04Ak2q9S1mhB
 RfdcRkM8cfi2dQY/stIZlwWeat+RGXPbgQz6V2A7nFMbrGGb/qhwzuOS0QTVywSnMkvCDPeAksR
 xIaA2HPznS3+j/DyDP+vY0OGUNV6ScgeiqGXUQ/TfanKZ6ghF+lpQbM7AZn8RyWN6XCyeALnBAd
 YLy50/Y7d3C1N79fzDf1FhVckK/55xx3jePrcryGEY1YXQ7qL+uq0n+QCeKHYPgmdxDrFWJBN8U
 9zYyhw==
X-Received: by 2002:a05:600c:4ecc:b0:439:84d3:f7ee with SMTP id
 5b1f17b1804b1-439ae2189bemr19969465e9.24.1740140662672; 
 Fri, 21 Feb 2025 04:24:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6C38cxMb9hzBe8yIVY1QmJ5KuG0NeV8RdsIxgctExImapK4BqB1nnxj/lrUWzL3/D0wEekQ==
X-Received: by 2002:a05:600c:4ecc:b0:439:84d3:f7ee with SMTP id
 5b1f17b1804b1-439ae2189bemr19969225e9.24.1740140662269; 
 Fri, 21 Feb 2025 04:24:22 -0800 (PST)
Received: from redhat.com ([31.187.78.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b02e4245sm15665135e9.18.2025.02.21.04.24.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 04:24:21 -0800 (PST)
Date: Fri, 21 Feb 2025 07:24:19 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 32/41] MAINTAINERS: add more files to `vhost`
Message-ID: <590de17b829d2ccd8067f19c71a53e31bec7bf00.1740140520.git.mst@redhat.com>
References: <cover.1740140520.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1740140520.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

While sending a patch for backends/cryptodev-vhost.c I noticed that
Michael wasn`t in CC so I took a look at the files listed under `vhost`
and tried to fix it increasing the coverage by adding new files.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20250211144259.117910-1-sgarzare@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 MAINTAINERS | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 013a57d5bf..2d07d72933 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2212,12 +2212,16 @@ M: Michael S. Tsirkin <mst@redhat.com>
 R: Stefano Garzarella <sgarzare@redhat.com>
 S: Supported
 F: hw/*/*vhost*
-F: docs/interop/vhost-user.json
-F: docs/interop/vhost-user.rst
+F: docs/interop/vhost-user*
+F: docs/system/devices/vhost-user*
 F: contrib/vhost-user-*/
-F: backends/vhost-user.c
+F: backends/*vhost*
 F: include/system/vhost-user-backend.h
+F: include/hw/virtio/vhost*
+F: include/*/vhost*
 F: subprojects/libvhost-user/
+F: block/export/vhost-user*
+F: util/vhost-user-server.c
 
 vhost-shadow-virtqueue
 R: Eugenio Pérez <eperezma@redhat.com>
-- 
MST


