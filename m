Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 509F1C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 23:38:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF0BO-0007wY-7O; Wed, 05 Jun 2024 19:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sF0BL-0007j9-Pk
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 19:36:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sF0BH-0005sw-CQ
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 19:36:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717630594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WFUPapk07PnJ8CLhVhbjjsuC+NoP2UxN6SJb+Hfxl60=;
 b=Ft46ietRFaHn9v2FBrBYdj5mCl+VSZdd/vxRJwrWbB33HOfqJCRNGfGdA/0DrSf1LCGc7s
 X7ANIHlnivaAMEFZSd5BjkoDhYtYI8ufsTT0IzAqLDu0wY7xUbddo/NcxpN/JTxXlWMqeb
 d20Wct+gnrQ+/8UaPLjIzq8sqzeWYdI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-DC4zDshaPK-9K2eY8xNbtQ-1; Wed, 05 Jun 2024 19:36:32 -0400
X-MC-Unique: DC4zDshaPK-9K2eY8xNbtQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a6c72164f46so14653866b.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 16:36:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717630590; x=1718235390;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WFUPapk07PnJ8CLhVhbjjsuC+NoP2UxN6SJb+Hfxl60=;
 b=YsRogNU6OjJP82wHYkwiojP4JQWiPcSO6DrrLhPZeG30VvwOot10NuZ/FbAI5WDqy/
 L8mYVd9KRIBXiWYCRiXMvUvEK7bY3TYeJWe+OpCi59O4wD8MTj4tgNt76DTRMPLVNJut
 8HflEdek9v3eg/4UVvT4qHSjCsqMUgVNhzIZeXrR1fSXr9WPdXRlLchV3sXfeHYfUE68
 /fmTijOQX1p40zluSdpQ/XCh3HaGxon107YFZdo3MPdLWbhuj9bnNtBgvhrIm37ec+Wd
 ruEQpOVSRXxzSmtDDSCywwUJrgPRwpE+7TaFk/LXzaDT0eQqQdVAswSBQTWI5ex/dVw1
 qgDA==
X-Gm-Message-State: AOJu0YxOjPwTo/jMXX6qhOnF2QT9pLljgywFCBq75uowJF8itR8QWLj1
 j8EKJ6nQXr4Osg5GnNqbIyKaEvUweljOUFHTJxXaDdu5BxhiZqzG+fDzY1LsB0G6GyFHJVJPSV9
 aKoKTc1rpcTaBmtVGV+MUF5cHEctUwE2p14ryha3IchS623p5ZxFVkdMcbcgTIt193MUbO1PcwZ
 IwflTi3QwMxn2R8xnLeJh4EvX9EQzU0Q==
X-Received: by 2002:a17:906:fc01:b0:a68:f6b7:1fe3 with SMTP id
 a640c23a62f3a-a699fcf3563mr260036466b.43.1717630590395; 
 Wed, 05 Jun 2024 16:36:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+UdcTmmXiKcFmzjKBFsEzkh6+bdd4qVh6x5/J7GAk1xNI240aTztcOcdEzm5PVvASfMYPdQ==
X-Received: by 2002:a17:906:fc01:b0:a68:f6b7:1fe3 with SMTP id
 a640c23a62f3a-a699fcf3563mr260035666b.43.1717630589890; 
 Wed, 05 Jun 2024 16:36:29 -0700 (PDT)
Received: from redhat.com ([2.55.56.67]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c805d2882sm7047266b.90.2024.06.05.16.36.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 16:36:29 -0700 (PDT)
Date: Wed, 5 Jun 2024 19:36:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fan Ni <fan.ni@samsung.com>,
 Svetly Todorov <svetly.todorov@memverge.com>,
 Gregory Price <gregory.price@memverge.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PULL v3 29/41] hw/mem/cxl_type3: Allow to release extent superset
 in QMP interface
Message-ID: <80ac9548a10f6fb3b9dcbc941e77bf1ca0616e7e.1717630437.git.mst@redhat.com>
References: <cover.1717630437.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1717630437.git.mst@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Fan Ni <fan.ni@samsung.com>

Before the change, the QMP interface used for add/release DC extents
only allows to release an extent whose DPA range is contained by a single
accepted extent in the device.

With the change, we relax the constraints.  As long as the DPA range of
the extent is covered by accepted extents, we allow the release.

Tested-by: Svetly Todorov <svetly.todorov@memverge.com>
Reviewed-by: Gregory Price <gregory.price@memverge.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Fan Ni <fan.ni@samsung.com>
Message-Id: <20240523174651.1089554-15-nifan.cxl@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/mem/cxl_type3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 0d18259ec0..5d4a1276be 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1947,7 +1947,7 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
                            "cannot release extent with pending DPA range");
                 return;
             }
-            if (!cxl_extents_contains_dpa_range(&dcd->dc.extents, dpa, len)) {
+            if (!ct3_test_region_block_backed(dcd, dpa, len)) {
                 error_setg(errp,
                            "cannot release extent with non-existing DPA range");
                 return;
-- 
MST


