Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19813C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 23:39:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF0By-00045d-Fz; Wed, 05 Jun 2024 19:37:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sF0Bw-00042t-S0
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 19:37:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sF0Bu-0005zd-J4
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 19:37:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717630633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PMqT3UA862JsOGcigX9iEr1iG7UpaUmQpd1D/p7t/1Y=;
 b=QPDTphPx5tSPVQlK+rOKgqPz2OFCQLjGxUtb9YnLGUfu0SUyjq93/tKCEesLQhOGijz39N
 4UVubpW6appNrB4qUF2VUd2fJKL2bYk56ZROcYYJqRtQvsUIRPtqjmSvrDlE120PeH31CR
 pxFWDeGt7GD1DlJIo5gKEi8xVg7quos=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-QslGs5HEMLaROMgX6DBifA-1; Wed, 05 Jun 2024 19:37:12 -0400
X-MC-Unique: QslGs5HEMLaROMgX6DBifA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a6912c4ddb1so13149666b.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 16:37:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717630631; x=1718235431;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PMqT3UA862JsOGcigX9iEr1iG7UpaUmQpd1D/p7t/1Y=;
 b=YcvdIUtW5SGtNqGLLab53grbJ7VSYfMPdb0BN9NGyH6RM2FAOMGx9CGYVKMTepiDhe
 UvZLLc2X4+Wb8nYg589oMW0jz/qotBIGFnF6MAaH8+bccpyFmtjgd96MyWUICYDEg1C8
 Dy3DoBWtsdOB08gCQ5jyVG1EYNzffO9xag1V3CrLMKfLv8PWDvo+XHoUdJGs8KUr6jch
 a2U5Bb92B/FJVgf/MnX7NvEpQARqDXXs2Oi6k+Vjt8UTZ15ZgAMsiR2UQ2RKz/Rm1Viq
 AYLn/asQxsazzJXdgfqg6ltYUY1SIRolur0UL3EA7+N9xFtj8VbOKZAjM/tV7oI21nD2
 AmYA==
X-Gm-Message-State: AOJu0YyDpTFdhEJXMngvxRYV5JjIl/A2cCOXAE6xXCEjoZLTF5KKaGDG
 4HCJLLKHtD2xTEp0lDFz43FK/cQ4w+7sDvlbB//Jlrd6x+OdXCnXtQPim5sHkDzBaj0zINKoXiB
 EPxTgQZEuYoy+kA0nz62zW/xRfByvWmWZ6d8mZlxg+pGGqYqNUEv2AD0Ow5XDSJ6Tp7x8UZJhyO
 PI0fXqWsvd9lMjDMIT0HofI255ohtD0Q==
X-Received: by 2002:a17:906:d110:b0:a59:9c58:763a with SMTP id
 a640c23a62f3a-a699f88ad1bmr249822066b.46.1717630630905; 
 Wed, 05 Jun 2024 16:37:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzcKHMzicOsYtJEO7oAR4sTC6yaeh8nAVnUGNsazR6tS0Nqiq+vWPS/M5sOj/96dCNT2aZuw==
X-Received: by 2002:a17:906:d110:b0:a59:9c58:763a with SMTP id
 a640c23a62f3a-a699f88ad1bmr249821266b.46.1717630630310; 
 Wed, 05 Jun 2024 16:37:10 -0700 (PDT)
Received: from redhat.com ([2.55.56.67]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c8058272bsm7331466b.18.2024.06.05.16.37.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 16:37:09 -0700 (PDT)
Date: Wed, 5 Jun 2024 19:37:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Cindy Lu <lulu@redhat.com>,
 qemu-stable@nongnu.org
Subject: [PULL v3 40/41] virtio-pci: Fix the failure process in
 kvm_virtio_pci_vector_use_one()
Message-ID: <07f799c8136c57913223930aed41dc6bef1854a4.1717630437.git.mst@redhat.com>
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
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Cindy Lu <lulu@redhat.com>

In function kvm_virtio_pci_vector_use_one(), the function will only use
the irqfd/vector for itself. Therefore, in the undo label, the failing
process is incorrect.
To fix this, we can just remove this label.

Fixes: f9a09ca3ea ("vhost: add support for configure interrupt")
Cc: qemu-stable@nongnu.org
Signed-off-by: Cindy Lu <lulu@redhat.com>
Message-Id: <20240528084840.194538-1-lulu@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-pci.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 7d62e92365..5941f1a94d 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -898,7 +898,7 @@ static int kvm_virtio_pci_vector_use_one(VirtIOPCIProxy *proxy, int queue_no)
     }
     ret = kvm_virtio_pci_vq_vector_use(proxy, vector);
     if (ret < 0) {
-        goto undo;
+        return ret;
     }
     /*
      * If guest supports masking, set up irqfd now.
@@ -908,25 +908,11 @@ static int kvm_virtio_pci_vector_use_one(VirtIOPCIProxy *proxy, int queue_no)
         ret = kvm_virtio_pci_irqfd_use(proxy, n, vector);
         if (ret < 0) {
             kvm_virtio_pci_vq_vector_release(proxy, vector);
-            goto undo;
+            return ret;
         }
     }
 
     return 0;
-undo:
-
-    vector = virtio_queue_vector(vdev, queue_no);
-    if (vector >= msix_nr_vectors_allocated(dev)) {
-        return ret;
-    }
-    if (vdev->use_guest_notifier_mask && k->guest_notifier_mask) {
-        ret = virtio_pci_get_notifier(proxy, queue_no, &n, &vector);
-        if (ret < 0) {
-            return ret;
-        }
-        kvm_virtio_pci_irqfd_release(proxy, n, vector);
-    }
-    return ret;
 }
 static int kvm_virtio_pci_vector_vq_use(VirtIOPCIProxy *proxy, int nvqs)
 {
-- 
MST


