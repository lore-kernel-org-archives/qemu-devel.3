Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C520BC021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 12:29:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlS4y-00086W-Ai; Fri, 21 Feb 2025 07:24:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS4w-0007x6-MF
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:24:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS4t-0007C3-93
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:24:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740140662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u27NKlvtYL4RNuhqQv/c+tDTZMnad0qlqsDe9OD9/Lo=;
 b=VxZcGYT37CZAgHl0dcjh6ClMgtDQvOq+i8ZOBhXMDsoFrOgDcEbvmQznRUvEp2yJyzHzDJ
 XgMekagWX8sN2p2yvqMPzLDFVqUx2iDOtTjcweo+tUm07zalRSrL0Cp7oj7E89Bgg6kikp
 N3ITkfKEO8zF8kK5nmXNGZ9USEzVUe8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-sPKOyW18PGq8cIGO07cErQ-1; Fri, 21 Feb 2025 07:24:21 -0500
X-MC-Unique: sPKOyW18PGq8cIGO07cErQ-1
X-Mimecast-MFC-AGG-ID: sPKOyW18PGq8cIGO07cErQ_1740140660
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4393e8738b3so14979895e9.0
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 04:24:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740140659; x=1740745459;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u27NKlvtYL4RNuhqQv/c+tDTZMnad0qlqsDe9OD9/Lo=;
 b=JheR72ecmfoE7+2vCaYV83Ap8Vu1QRc7EouQ0y9VPShobXwabi+TxfZ9NZCvERa6qj
 ENPiu30robJvJ4Zxb4xaTuKtsnTbtLVXbgRviZd3JniY3BA2K/qe7DRLWgs6rwparZzR
 bj/Gwb5kRyCmA+fjuEk487P/EqSZg5ORUpAKn9AgZDrljaLN+FY2hn3whSgTx7OyqRcN
 GLHXnPMdioPbzMytDti661JzIVIuKzW9qJPm9sS1ztS6EUKbxT/MXnaoAIM7Q35sRVRj
 EJFGp36yaBrNe8jt6Xw+7idbJxLCcVBgIxdpqhz/NThAeAwD0/35W9dLiimdbXh03FuW
 fIFA==
X-Gm-Message-State: AOJu0YzpOU5JSo0FQHnTJfovrWdgsGvQ+dToidpsFc0SHQ24J9KF3dEk
 QG+xb9fyhh/h7Iw/D1c4Zt3xcvH0m4oCJcYxApHxOs1fJG9w7WAjcQVbDtJQyMOl+yYNazqVz6j
 ykHTQCwp28ql6BG+RECJCGuM2zFvo9K+Ja+BlYSCKWclXYAqBnI/tGupMkLZ96NDZuw5XLSuYHz
 dW8AlnTkgHSiQm2V8N8Mm3pzMKKp9lag==
X-Gm-Gg: ASbGnctMQZB0ZiAvSCKZ8d3ldpLaw9eua4A+F8acOfyBu3SqSRRYTFJUowHyZ2KCRfM
 v7/5DQsJ+UvM9JC9WSIoE2ADqoRRpc2L5yHBo/mfEStXRWwh04j5iOEUwLUpAZ25c00qLCMNAsI
 KURRB3SetSvEHSvTuXYEMlcpKAzZQH+BGmSUOziHx65tiKLEj4D7E3nxcOnQLEKPgU1UADHJWP1
 8M/zVLBDZHBkzHCm0xkfFDtRYdXmshZLB9ZaWAld1KRmyLw2e0LqAIZUw+fTRPVl0abLlDQ0Uaz
 1tUpcw==
X-Received: by 2002:a05:600c:5101:b0:439:65f0:c9ce with SMTP id
 5b1f17b1804b1-439ae220a84mr21414935e9.25.1740140659478; 
 Fri, 21 Feb 2025 04:24:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkanAFun3kgOrIGed7mKCligMYCtqpxaZuvTDrHUsPKhnQURrgk8syYfc4clZ/xQe1ug+xSg==
X-Received: by 2002:a05:600c:5101:b0:439:65f0:c9ce with SMTP id
 5b1f17b1804b1-439ae220a84mr21414675e9.25.1740140659021; 
 Fri, 21 Feb 2025 04:24:19 -0800 (PST)
Received: from redhat.com ([31.187.78.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b02ce735sm15866465e9.3.2025.02.21.04.24.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 04:24:18 -0800 (PST)
Date: Fri, 21 Feb 2025 07:24:16 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, qemu-stable@nongnu.org,
 myluo24@m.fudan.edu.cn, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>
Subject: [PULL 31/41] cryptodev/vhost: allocate CryptoDevBackendVhost using
 g_mem0()
Message-ID: <83cb18ac4500f3a14067b19408705068647cb0c5.1740140520.git.mst@redhat.com>
References: <cover.1740140520.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1740140520.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The function `vhost_dev_init()` expects the `struct vhost_dev`
(passed as a parameter) to be fully initialized. This is important
because some parts of the code check whether `vhost_dev->config_ops`
is NULL to determine if it has been set (e.g. later via
`vhost_dev_set_config_notifier`).

To ensure this initialization, it’s better to allocate the entire
`CryptoDevBackendVhost` structure (which includes `vhost_dev`) using
`g_mem0()`, following the same approach used for other vhost devices,
such as in `vhost_net_init()`.

Fixes: 042cea274c ("cryptodev: add vhost-user as a new cryptodev backend")
Cc: qemu-stable@nongnu.org
Reported-by: myluo24@m.fudan.edu.cn
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20250211135523.101203-1-sgarzare@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 backends/cryptodev-vhost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/backends/cryptodev-vhost.c b/backends/cryptodev-vhost.c
index 8718c97326..943680a23a 100644
--- a/backends/cryptodev-vhost.c
+++ b/backends/cryptodev-vhost.c
@@ -53,7 +53,7 @@ cryptodev_vhost_init(
     CryptoDevBackendVhost *crypto;
     Error *local_err = NULL;
 
-    crypto = g_new(CryptoDevBackendVhost, 1);
+    crypto = g_new0(CryptoDevBackendVhost, 1);
     crypto->dev.max_queues = 1;
     crypto->dev.nvqs = 1;
     crypto->dev.vqs = crypto->vqs;
-- 
MST


