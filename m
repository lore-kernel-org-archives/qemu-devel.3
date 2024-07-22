Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F6AC3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 00:31:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVgkT-0005dE-47; Sun, 21 Jul 2024 20:17:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgkJ-0004vr-Fc
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:17:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgkH-0005my-VU
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:17:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721607461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hq4UcO9VA6wUCWPh+nsmUKYS4qa8nT+9OsSYlXgNtFk=;
 b=Y2EJ3wE5QTXmE7bOcNRJuAhkWQg1+FclH4U6pKH42BousPCXhZ9iWFvhiKBxPDgvQvCLnW
 70YIpOnuG3N/YD02TBzwd0Z4ciHPBaYrygu4qfpnsGwcD2gtEIzsrfW8+mDIwuw6ampiqA
 Et8RPtbBvU1tNseIRXwX9QUsyZVxa/M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-OeoBagRXP3i6ylR6C7YQhw-1; Sun, 21 Jul 2024 20:17:40 -0400
X-MC-Unique: OeoBagRXP3i6ylR6C7YQhw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42794cb8251so27668055e9.2
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2024 17:17:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721607458; x=1722212258;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Hq4UcO9VA6wUCWPh+nsmUKYS4qa8nT+9OsSYlXgNtFk=;
 b=BZVxI+O1XbNiZKhGYtfUPFyQVbY08gx7/Z4sS/chuJid5XQZhYzypZPBXEjAOGIo9j
 1KWoV9y5nMnSdEZ3sJOZQ+roSU0OcMwQruSewARPVZQJ6sxTk/BxQK65kOpaWKHhpoyl
 pD+Kyfe0V8REp2CNlBKN+BJKKHJrd2Pr7TLdvDk3lknPJarywfx4UUkvTL8Y7EbX4SEA
 ZgWT/HXTdwgmWY65bf0tgat92NbMTaQV3aK8mL7bWoC7T+tpS+VX0eDQ28LprQAODWwD
 00Sl4MKUlfl5dpmjIqmh2gXAPb5aZXZNKFV+RjExHlXSIapDmBJANEm0/Aqs3Eni9gTp
 OVlw==
X-Gm-Message-State: AOJu0YxFg55EAI266JMHFQG3XPaFRiwSIlBZVxonXr/haytFy9UEIKDG
 2tZZJwa4HVpFL51Vb7oSTnYqxrYMnzq4Am23HKA4QVhhZ9AyB9+6F3dMdqQR4pT22X1/xIIVB7N
 RFmUEUJgPo275zgqLiecyM2bv8Mi4OmZgBvsVjV1X4kWGLmAo2/WubrqWq2mP1NGsxE8Bh+mD8Q
 lG4djSGSJJdwuibjsqC+fVC+8wV24Y4w==
X-Received: by 2002:a05:600c:1382:b0:426:59fe:ac2d with SMTP id
 5b1f17b1804b1-427daa67bf1mr45721625e9.32.1721607458350; 
 Sun, 21 Jul 2024 17:17:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwvFge4rwZI56iLkZl/PCaNan9herVq7KHSmll6AqeFAkQ5nA2CQV89md2XvnhlGsw9BpX+Q==
X-Received: by 2002:a05:600c:1382:b0:426:59fe:ac2d with SMTP id
 5b1f17b1804b1-427daa67bf1mr45721465e9.32.1721607457770; 
 Sun, 21 Jul 2024 17:17:37 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3687868b7d9sm7024234f8f.42.2024.07.21.17.17.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 17:17:37 -0700 (PDT)
Date: Sun, 21 Jul 2024 20:17:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonah Palmer <jonah.palmer@oracle.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [PULL 22/63] virtio: Add bool to VirtQueueElement
Message-ID: <c303aa0942589427b42192ef7cff75a79ef8646b.1721607331.git.mst@redhat.com>
References: <cover.1721607331.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1721607331.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Jonah Palmer <jonah.palmer@oracle.com>

Add the boolean 'in_order_filled' member to the VirtQueueElement structure.
The use of this boolean will signify whether the element has been processed
and is ready to be flushed (so long as the element is in-order). This
boolean is used to support the VIRTIO_F_IN_ORDER feature.

Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
Message-Id: <20240710125522.4168043-2-jonah.palmer@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 7512afbc84..fdc827f82e 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -69,6 +69,8 @@ typedef struct VirtQueueElement
     unsigned int ndescs;
     unsigned int out_num;
     unsigned int in_num;
+    /* Element has been processed (VIRTIO_F_IN_ORDER) */
+    bool in_order_filled;
     hwaddr *in_addr;
     hwaddr *out_addr;
     struct iovec *in_sg;
-- 
MST


