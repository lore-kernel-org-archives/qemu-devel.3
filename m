Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57FA4C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 14:34:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhqnK-000665-Ak; Fri, 01 Aug 2025 10:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uhqhK-0005Q1-8n
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:25:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uhqhA-0002eR-UD
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:25:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754058312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CmCUy7VMYdhhfAJ9rVBdHUNMEi7jQwBEVAggBejnK4M=;
 b=M4Qv0lKZqDTSfSyrHNbvGkDb7rIuczoN9K4AJs5WEOAnnV31825B9atyfxRAPoMoooOEqy
 5VQrhOrLfPzQ0QE0ORAy+0r7J61W+nq10jE3KPviakhuEz9uApOX6D7WQF8zMLTDSA45rk
 AQyB3smuqP/mWjGMKHv6Ix9Qu0ODS2k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-tyaQVJzoPuKyW8rDQYRP0g-1; Fri, 01 Aug 2025 10:25:11 -0400
X-MC-Unique: tyaQVJzoPuKyW8rDQYRP0g-1
X-Mimecast-MFC-AGG-ID: tyaQVJzoPuKyW8rDQYRP0g_1754058310
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3b79629bd88so823750f8f.0
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 07:25:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754058310; x=1754663110;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CmCUy7VMYdhhfAJ9rVBdHUNMEi7jQwBEVAggBejnK4M=;
 b=vtuLo7Uw1Nrqt4Bd1X53+CADQ7II1mV5XShD98FxJ4wm7ltgozX4fMlfiNd4c69iJR
 hfyVW1Tc4cIgOkXvon9seYDi+/8KpCK8BX9GiLJA1z/sBC71+uXRDYTdXlihAkZ708EP
 uhGVvZ+33mkbAO80lv0Uy3UKSxdDzZtAnU899icFCrjfqwjFwkcBqJnx0HBcsqU5tEqu
 K60lKfDdDwGrMJ9bAlW+ElptZJ1idboA3HeQI9LlVUVhaQZ13MuVnDSySnGdVjPm3noj
 8krAfxTzd4JMOpLl/osE2xZ7c5hxcy5FVwEilJQZt17uXtZRoovKVe+FVfMWvcycu7er
 AdHQ==
X-Gm-Message-State: AOJu0YzlQ0tzbybfvnehuJcxNI9YptffY6Gqg6Gi+IuOZxMwDt1fDyVJ
 V36p+7bEhQUG4IY1cV1Yzru26RzT8/zZCtwaie+JveMGP/QtXplzTnHm+ZV8NUKAHLbDE2zSPRf
 M0+wdHOWQ99LdHVLRq9nGGdrwBOIyTJBYtvAepA+rzLXBcKsSEFr4zzfYHN9A2r3Sm273DBMaDz
 LACbrypPQ3O6QmZ61lt7vKRdqroJHbYx48Ng==
X-Gm-Gg: ASbGncum2GQx8avW/LXykB3pBt6DY0rbDTd/qC0GL+t4JqXFiIVl9DmRJ8Bi4O9oYBW
 DYPEhQ7ZjDitToYIb2z5zQ43ldAnOTUYHmLS0aOszDBcdum/jRHGK7fA8+1KcJNW9auDpAhL1RQ
 4dIe0hYMgf7ca1W2O9/p8ja2dHEKGIiuAxo3BkyRx/FL4zWp5j+L+8XoJ2KPAj2fQOsKa/Sf3ws
 vBZnBhOkTP8MZBN+VVTfgEs5VhHoxJq50QOcS/riYUyJaNRLARsHVeld/isM6o8b7A2CHfSToV9
 /lXBu1kcsvbBeSWS589KkWySdhpyVvxA
X-Received: by 2002:a5d:64c4:0:b0:3b7:9af4:9c75 with SMTP id
 ffacd0b85a97d-3b8d348e398mr2227507f8f.30.1754058310223; 
 Fri, 01 Aug 2025 07:25:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDYhSYUP2yuvx0PWjg60xUssHxKkda4QqYk9jHuLD8qTU5IhqQAzK+PmAxA6f2Ek1FmQdFXQ==
X-Received: by 2002:a5d:64c4:0:b0:3b7:9af4:9c75 with SMTP id
 ffacd0b85a97d-3b8d348e398mr2227477f8f.30.1754058309663; 
 Fri, 01 Aug 2025 07:25:09 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c475067sm5997972f8f.58.2025.08.01.07.25.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 07:25:09 -0700 (PDT)
Date: Fri, 1 Aug 2025 10:25:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hanna Czenczek <hreitz@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, Lei Yang <leiyang@redhat.com>
Subject: [PULL 03/17] vhost: Do not abort on log-stop error
Message-ID: <d63c388dadb7717f6391e1bb7f11728c0c1a3e36.1754058276.git.mst@redhat.com>
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

Failing to stop logging in a vhost device is not exactly fatal.  We can
log such an error, but there is no need to abort the whole qemu process
because of it.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-Id: <20250724125928.61045-3-hreitz@redhat.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 05ad5de629..6557c58d12 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1122,7 +1122,8 @@ static void vhost_log_global_stop(MemoryListener *listener)
 
     r = vhost_migration_log(listener, false);
     if (r < 0) {
-        abort();
+        /* Not fatal, so report it, but take no further action */
+        warn_report("vhost: Failed to stop logging");
     }
 }
 
-- 
MST


