Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06628C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 19:11:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEZUh-0006HG-Bl; Tue, 04 Jun 2024 15:06:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZUf-0006Dr-93
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:06:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZUd-0000p7-HK
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:06:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717528006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bf3inGfH3C1OrX/KdJFaqQvDHDePnfUDWhDjBaZ52tk=;
 b=DxqnpCEAEevLaf/7ZC7vn17oMrWrpvCeqQEjdNk5ce4qUUtbo7dEEibyMTm08vdmeZvITJ
 ogbkkQuv6SVrDx/H9EwaAtaLrTjf8x2FqyODUj6jd/743UUqq/HczmNsibSWAYcbaehIQo
 1pwZYvHbRHr4KvEhINEvdG8mNfMOmx4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-nrqKrTdsMeCBJZoDVB2wrg-1; Tue, 04 Jun 2024 15:06:45 -0400
X-MC-Unique: nrqKrTdsMeCBJZoDVB2wrg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4212e3418b1so28889845e9.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 12:06:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717528004; x=1718132804;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bf3inGfH3C1OrX/KdJFaqQvDHDePnfUDWhDjBaZ52tk=;
 b=MgyOBsiaO1zRY1bJrr3VDHMUNUEsQ5DsxgJ4jFWkGInbKjO2AShLUujhUzTB7rX6lq
 LuqYh9KKNZfYCDsubwooHgjt0nllDeNiVnTRlzZqqrtbmsLJ0PGtqz1aiHskS0GiuEPO
 E8S8UdwI6eadIVgCLHp9wGWgAK7W8gJRG5th2pkIw99nMqZM7qJcaJsiLg9ladiPIwX+
 Usutn4aspzvgdxes+mvQqndoFlud1dqecbVy636qBNNL5Gzb5/SucjR94oQXaczkLTO5
 rwX3ojq9DbP6f0/4wpVEjDrb2fE2SIa6fazmIhqGBEczCd3reW8vtVrJNQ6Zj4dnrj5r
 Hibg==
X-Gm-Message-State: AOJu0YwKiIy2HIvm/6UNnr58GxUhDNc0PhI1KVJsyu+wOO7bucTAkYR9
 8gtAfS79+/D3FPZPupAdxgFaMMNChx6T1oX0hXR1z1Q+A/3tSOK9RqiCXMTXiFMUS69zHgJo1de
 e03YZjedsJFa8qbf75Qx8HfePPjk2ifoa1gvR8yB5sTlGekG6Tjv2MhBhukKqh1whp5FXu8JGtv
 X2wZBS3LF9is/bKfJklP1YtdIZTpdhmA==
X-Received: by 2002:a05:600c:1c19:b0:41f:d662:65f6 with SMTP id
 5b1f17b1804b1-421562c7dbfmr3541075e9.3.1717528003714; 
 Tue, 04 Jun 2024 12:06:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZ9jZmy9OLGmUYGznVib+WruK8PBTrf1O0BMMFqznZ0E/BV8ifX9qRFLVgzLQDelOh0lPmhg==
X-Received: by 2002:a05:600c:1c19:b0:41f:d662:65f6 with SMTP id
 5b1f17b1804b1-421562c7dbfmr3540955e9.3.1717528003261; 
 Tue, 04 Jun 2024 12:06:43 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:552:cf5c:2b13:215c:b9df:f231])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42156176a06sm6881265e9.3.2024.06.04.12.06.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 12:06:42 -0700 (PDT)
Date: Tue, 4 Jun 2024 15:06:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Wafer <wafer@jaguarmicro.com>,
 Jason Wang <jasowang@redhat.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [PULL 12/46] hw/virtio: Fix obtain the buffer id from the last
 descriptor
Message-ID: <3fc9184844ddb9af89f6916a204df888d37565c1.1717527933.git.mst@redhat.com>
References: <cover.1717527933.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1717527933.git.mst@redhat.com>
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

From: Wafer <wafer@jaguarmicro.com>

The virtio-1.3 specification
<https://docs.oasis-open.org/virtio/virtio/v1.3/virtio-v1.3.html> writes:
2.8.6 Next Flag: Descriptor Chaining
      Buffer ID is included in the last descriptor in the list.

If the feature (_F_INDIRECT_DESC) has been negotiated, install only
one descriptor in the virtqueue.
Therefor the buffer id should be obtained from the first descriptor.

In descriptor chaining scenarios, the buffer id should be obtained
from the last descriptor.

Fixes: 86044b24e8 ("virtio: basic packed virtqueue support")

Signed-off-by: Wafer <wafer@jaguarmicro.com>
Reviewed-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Message-Id: <20240510072753.26158-2-wafer@jaguarmicro.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 28cd406e16..3678ec2f88 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1745,6 +1745,11 @@ static void *virtqueue_packed_pop(VirtQueue *vq, size_t sz)
                                              &indirect_desc_cache);
     } while (rc == VIRTQUEUE_READ_DESC_MORE);
 
+    if (desc_cache != &indirect_desc_cache) {
+        /* Buffer ID is included in the last descriptor in the list. */
+        id = desc.id;
+    }
+
     /* Now copy what we have collected and mapped */
     elem = virtqueue_alloc_element(sz, out_num, in_num);
     for (i = 0; i < out_num; i++) {
-- 
MST


