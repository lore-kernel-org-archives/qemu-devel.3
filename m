Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85067C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 14:35:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhqnt-0008Ma-Lr; Fri, 01 Aug 2025 10:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uhqh7-0005It-4T
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:25:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uhqh5-0002ce-Bz
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:25:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754058310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n9aTAKqxtf2LCN/h984DXmZDHWbf6WVTqmImDbPWZ5I=;
 b=dAQ9fqDWbMkmqvTGak6bzQeeIJIE0WeAge24AuCIvdOQfTu1qnRTTA3kJ0Tj/egBaISn4G
 PrHw1OzM74rpr2EU4zWzC5MlaFPXFJVTM2wBtK3mZTrr6jBwLZ/wi3fi3aA0Uz/OkG1GMl
 oMr/5UFVOgBPLQ5xgOVdm6kiS3hjgSo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-WD3fqu2fNfOJTjXT9zD0Hw-1; Fri, 01 Aug 2025 10:25:09 -0400
X-MC-Unique: WD3fqu2fNfOJTjXT9zD0Hw-1
X-Mimecast-MFC-AGG-ID: WD3fqu2fNfOJTjXT9zD0Hw_1754058308
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3b836f17b50so818582f8f.1
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 07:25:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754058308; x=1754663108;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n9aTAKqxtf2LCN/h984DXmZDHWbf6WVTqmImDbPWZ5I=;
 b=eAV8/s+Srf5pep80spqLVI6xvVKaoq6NDu7f8qK43U7tynbvEgamXA2C+BEgkpA4rT
 MMzV7Jf/KYxdWGLWd6fZxDq7Z5nevgi0M7gPx7LwRE+L22rAB72orZR9zCGr5OXPZ0TL
 RHii/k0WXbtaziBFGdyMkcWq8QybKIpQp/cpTG7uZkLXfYLnbdHB16VHrMUFCD+nH0rM
 IjVkDIxb/UvmMPuupgHDB9iWntUll2w2We5eeZm3/fcySV+RPVGiIZe8PrbFwgsXZUfB
 nSIp/XsEBdmKNKgtvpI8zq3lksv2el4Q9WBeKexAWgEO4V2cde0QcoF+kmL8ycpo17gP
 qkAQ==
X-Gm-Message-State: AOJu0YxhOkM3hG0WcZ0m8U6E1SobM2OrttgvWu1QnLY0r1uTWF8uyhfD
 S4dqncmUhXlf+jhhNbRtJW84DcCB6ypBm8J1K2DU9t4772ColipnJ1RGt3wYUmygUz+5FI9gpqF
 5nTITrX9ZQU1v0aDeHDHwAzmx/c06afDdcvuj8vNHjjNEU6Y/ffPDUJ3JpZqT69eNDd56xH/mhv
 O1Owe9rFLYAyFPMwIwZW3gpSQwriFwzSN4Bw==
X-Gm-Gg: ASbGnctEQAZXd82EfhtB6eyP0us8fkTmQd15fepwNw1aq4mhoWrTc1CtVao8M5InXWQ
 GGgTm3ktS1iC+feZIqcg6zX7Bz5pIHv/gKv5la0L9Br9k8ebjf1+eUSQAXxyPgF1g6o2+4oqzP1
 bVy89wlyeowacbBdCX2Wv8WLFQhGiitYU8jJXLG6w0k0zA0zMaS7FVshgfH3LkJu5FswWZbVoJ/
 ZlsllV38JVZrX5yaHiLYPq0D2oRCXEZ/fGKaJY6rndzRqoAyQ/Ik83lwAd/GdhmKldc9w7W2AGF
 B7h1Wkg3GkgNS8NnoXX0xjbeBK/Ut7/z
X-Received: by 2002:a05:6000:410a:b0:3b7:999b:1194 with SMTP id
 ffacd0b85a97d-3b7999b1552mr6748727f8f.50.1754058308017; 
 Fri, 01 Aug 2025 07:25:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkhnUrfb69HxGRtmi1oofHD0UWmChSkXqelfoMQEUfW3VJt1/0c5e5pFWlEuOEuktauPE/OQ==
X-Received: by 2002:a05:6000:410a:b0:3b7:999b:1194 with SMTP id
 ffacd0b85a97d-3b7999b1552mr6748701f8f.50.1754058307482; 
 Fri, 01 Aug 2025 07:25:07 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c453c75sm6126809f8f.41.2025.08.01.07.25.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 07:25:06 -0700 (PDT)
Date: Fri, 1 Aug 2025 10:25:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hanna Czenczek <hreitz@redhat.com>, Tingting Mao <timao@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, Lei Yang <leiyang@redhat.com>
Subject: [PULL 02/17] vhost: Do not abort on log-start error
Message-ID: <c1997099dc26d95eb9f2249f2894aabf4cf0bf8b.1754058276.git.mst@redhat.com>
References: <cover.1754058276.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1754058276.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Hanna Czenczek <hreitz@redhat.com>

Commit 3688fec8923 ("memory: Add Error** argument to .log_global_start()
handler") enabled vhost_log_global_start() to return a proper error, but
did not change it to do so; instead, it still aborts the whole process
on error.

This crash can be reproduced by e.g. killing a virtiofsd daemon before
initiating migration.  In such a case, qemu should not crash, but just
make the attempted migration fail.

Buglink: https://issues.redhat.com/browse/RHEL-94534
Reported-by: Tingting Mao <timao@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-Id: <20250724125928.61045-2-hreitz@redhat.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index c30ea1156e..05ad5de629 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1110,7 +1110,8 @@ static bool vhost_log_global_start(MemoryListener *listener, Error **errp)
 
     r = vhost_migration_log(listener, true);
     if (r < 0) {
-        abort();
+        error_setg_errno(errp, -r, "vhost: Failed to start logging");
+        return false;
     }
     return true;
 }
-- 
MST


