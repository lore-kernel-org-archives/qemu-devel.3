Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317D6606A322
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=COX/9Hlo;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=cknEvA8q
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7G2-0008Cb-LG; Wed, 28 Oct 2026 13:16:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7FM-0006mz-RK
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:15:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7FJ-0003mH-IQ
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:15:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PuphjqTXxLF9tHOp+wHuhM9m7RgLOn8TLdgNZ8vE9Lw=;
 b=COX/9Hlo+WFCI2hwmG1tSCnT5+sOBTzzwJLgcvgkRbdm77zflmXh93c5kIEezTH3PaRp87
 9AJctZXnrjkc5unqpQczp8t1ZAE/+RI+FaVwSMwX938pdyFsNtl4plbbZpVKseej3TOCGZ
 zjYYn7p0buxwWypbfjIesnh9Hxy26wA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-gro-otqgMbyDZyH1ULritg-1; Wed, 28 Oct 2026 13:15:27 -0400
X-MC-Unique: gro-otqgMbyDZyH1ULritg-1
X-Mimecast-MFC-AGG-ID: gro-otqgMbyDZyH1ULritg_1793207726
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a1f03f2e8aso11099935e9.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207726; x=1793812526; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PuphjqTXxLF9tHOp+wHuhM9m7RgLOn8TLdgNZ8vE9Lw=;
 b=cknEvA8qedxTBA1DFSOksOdF3L/iNwdD6et1NJqRraEwEnKs5oSLvEDPhx9PCKhgO7
 MnDm2QnBZpKhx6UjqvoYD5Wep3IV1fHWk0C709zPEPgWrienls+sTYl22i+EwHNr1jwK
 oqwsxz2I5FjMenVeBlzElVC61Ogiw/M22xFv7PfK0rg3yWRIAHPROQv4n4myqsZJ4TMH
 Au5ohvoZTbMu1Ic4wfmp5LyTqAg8jZtu/8ksif+nMrMhk/0g4SNJadFaVc3xQJx0ys7U
 XZs1jD0Q07AojkT6iFbaFHTgHK/vWIhld2uAGSmP+g5Xna6ObmhMAXe6TVl/PicjVEgK
 N4xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207726; x=1793812526;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PuphjqTXxLF9tHOp+wHuhM9m7RgLOn8TLdgNZ8vE9Lw=;
 b=n5KtSNLCQwPpackn3woDy12G8JJrxodCWIoqhXlsBeNxxNjzfbnsKNVCRaXtvvH4yr
 75v/6VTQabKBZezeTDoutmPoTULYB9hDimNx2Huf7JL0EXHVypmHPPaigvfzlizPdg3r
 6xp0vW4pWlGUdYzAcyWh81D7rjhIYPIzHwQXR/8geAz+w0Qe6AZj4t/y7e/YaES27nEx
 VyQRJ8RKhyX3JLVdjHHE3EQ0kb7oT22cQ0+i7aMcYF6ckTbU6ehH+OyGOAJJcIXdh7Eb
 /QouNK0pqgGinfIMsEkmQufYXaFq/4xSTxOj0h7FW9itO6eEPolCRcXkvMn5AR44PEeu
 3OFA==
X-Gm-Message-State: AFq9FYIkuEJ17p5/02IJal9divVsDmPNzHzPu+hYPU7Ohm2LOn940vlc
 fkVlAAoAR87pKuL3HX/jHb6+vwnjEXTrfzFrCvd0R3ZeWnZ+xqo45Q+tTV0LDLjVPEK34p2aM7l
 AXSL9KYUe9NB7shod0mXxWlJ20h+bwCuybaWK3Zg68TCcz3amqSj++c/Ijnm4L0Guh+G39HfZW/
 SrB8535fOrSjckkaKFFOYBAr3PENynM/nzxQ==
X-Gm-Gg: AYBFou2rhGp4oYTxxwnYD4SXmG8GpeJPej2IjulWk7vIPXh36Di8OD1f0EXOkAl7Mr0
 se0iLjvqnrDd1wJ0cLnzHw4v4/+Z/wH9AAxTaZwNNzDrGr5ZBZdtH6z20MVXoyV4dchacmmT8Dp
 REcGOlWOvGnNXlvIYGpP6pmApQ6RZhUXv0dQ8js025wGPY1wNFfcVj/2949II5VGtIMJm1G0YWl
 dlyWQBi6D4oosI+1NnHvEAEBfrkxyyU/aKJCsKLF7dbyO9uCaMXHpCHf6kmekiQOUXsswOPcwGS
 W7+kKtPtgJTklIklLN8z0fy0SQRUrlz8TQkuCL7S8bMqIz/cbN1TyYK/e1dl9pT5Xg5KIXW4E59
 CVdkQjBlATFAJk6wyHP8ajposyLMAGwJ6XCj2Z4bI
X-Received: by 2002:a05:600c:3b1e:b0:4a2:10f9:37ce with SMTP id
 5b1f17b1804b1-4a9665870e9mr72387325e9.15.1793207726113; 
 Wed, 28 Oct 2026 10:15:26 -0700 (PDT)
X-Received: by 2002:a05:600c:3b1e:b0:4a2:10f9:37ce with SMTP id
 5b1f17b1804b1-4a9665870e9mr72386475e9.15.1793207725545; 
 Wed, 28 Oct 2026 10:15:25 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa80286fc6sm6257985e9.15.2026.10.28.10.15.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:15:24 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:15:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL 32/78] qapi/virtio: Restore backend features in
 x-query-virtio-status
Message-ID: <31afb9ef5e9c0589b880f3c6e90f67b8ee70bb7a.1793207602.git.mst@redhat.com>
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Commit 1ee0bc0c9bf0 removed vhost_dev.backend_features and its
representation in VhostStatus. It also removed the assignment to
VirtioStatus.backend_features, although both that field and its source,
VirtIODevice.backend_features_ex, still exist.

The resulting NULL pointer causes HMP info virtio-status and QMP
x-query-virtio-status to crash. This affects virtio devices even without
an active vhost backend.

Restore the assignment from VirtIODevice.backend_features_ex.

Fixes: 1ee0bc0c9bf0 ("vhost: drop backend_features field")
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260922213210.1429435-3-vsementsov@yandex-team.ru>
---
 hw/virtio/virtio-qmp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index 5aaeebdd96..8b7cd7a310 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -713,6 +713,8 @@ VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
                                                  vdev->guest_features_ex);
     status->host_features = qmp_decode_features(vdev->device_id,
                                                 vdev->host_features_ex);
+    status->backend_features = qmp_decode_features(vdev->device_id,
+                                                   vdev->backend_features_ex);
 
     switch (vdev->device_endian) {
     case VIRTIO_DEVICE_ENDIAN_LITTLE:
-- 
MST


