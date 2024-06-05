Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D540BC25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 23:36:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF0AH-0002xs-5z; Wed, 05 Jun 2024 19:35:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sF0AF-0002xG-5s
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 19:35:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sF0AD-0005DI-9V
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 19:35:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717630528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bf3inGfH3C1OrX/KdJFaqQvDHDePnfUDWhDjBaZ52tk=;
 b=Q/5e2mmGQc8slo6iwP7eyjch3DOYqWmUBpJ0dzi8NhSBgM6wFUBX6lR+nCBM/aOFp++Mlb
 3McoXrQOTLZZ1WiqWMtG6YeW5stZLIl2MJHAr75Ns3eVN/lCmlTAVF+cktPQ3kMWCDiiJi
 iK1pt9rdlCQAIn+kUiHR960bahaNcoc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-pnp4JZEWPQuMVEuB5fIKww-1; Wed, 05 Jun 2024 19:35:26 -0400
X-MC-Unique: pnp4JZEWPQuMVEuB5fIKww-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a6861bb1c0bso15717766b.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 16:35:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717630524; x=1718235324;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bf3inGfH3C1OrX/KdJFaqQvDHDePnfUDWhDjBaZ52tk=;
 b=SaoCFzx1tBVYAIvS95oCeKotHd6NSIC2FHY7glZKaSLXXtUb3aa1Ye+ZvUpOW841HD
 U01HYrNivoCaxps59WfNcuMQlPdpfIWBHgBgW/mpEM2GzDY0V7VrQCC4s46qGJr5EBVN
 8Amygy6pOW3evcXOTPu6ex2jJup+W5s2qgmf/z9PVIKPreQwnOtJ1emxzFYLC5TeBewo
 SOcao1JNOFobn6zTFtBmg58vtYBKpkrWwl3pNT/5YM0/Vn777gu+EBn0N2v2tcKbXanj
 ufjLdQc24KMIWykPKHTdfz1tW1LNRgJ2AqoIfds2uZm5ivV5C1zaQ19Jgeo3zxOUh7m7
 JnXA==
X-Gm-Message-State: AOJu0YwNt0wkyzStOYizzgoU5PdkHtBCLkJ2DqpzomBjClnF0fYTmCS7
 oCrLouZ9TeY3t38ebHFDEX0NDJe4+EOUsqtDVk892Kn0iQbIrSG1eQ45sjc81nk0djq0z+MhF8t
 Jn4Mf8ydiQaya0NoBvNC7QMajBtAGlQOvaJ8QxDLVKc7lcpa/cKFpBaQau51H7C/TRgRdX9riuk
 ULUtpI7ppz23091BFgFuAdauK4OnseIQ==
X-Received: by 2002:a17:907:bb99:b0:a68:b089:e27 with SMTP id
 a640c23a62f3a-a699f681b5amr246320366b.44.1717630524540; 
 Wed, 05 Jun 2024 16:35:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+UsTvEZwZE0tcfwq8NLODBxUw9fNw/xSvLa6J+AHzduJeHN7HdkGiYjiFCtUQKXFBF/PfXg==
X-Received: by 2002:a17:907:bb99:b0:a68:b089:e27 with SMTP id
 a640c23a62f3a-a699f681b5amr246319366b.44.1717630524087; 
 Wed, 05 Jun 2024 16:35:24 -0700 (PDT)
Received: from redhat.com ([2.55.56.67]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c805d0af8sm6951866b.87.2024.06.05.16.35.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 16:35:23 -0700 (PDT)
Date: Wed, 5 Jun 2024 19:35:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Wafer <wafer@jaguarmicro.com>,
 Jason Wang <jasowang@redhat.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [PULL v3 11/41] hw/virtio: Fix obtain the buffer id from the last
 descriptor
Message-ID: <acfb5cd252a78beb119d18878be1279e580e710c.1717630437.git.mst@redhat.com>
References: <cover.1717630437.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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


