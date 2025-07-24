Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58670C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 13:00:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uevYC-0006qG-GX; Thu, 24 Jul 2025 08:59:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uevY3-0006hX-O7
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 08:59:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uevY2-0005z0-8X
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 08:59:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753361985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IKMYVgbMM/INns6RRVnU6T93DRZMyNIk0sjsY4fUN4A=;
 b=ShxF7fZa9kIQD9mTILM9WJyQbXhhloWEvh8EJfzULVbvKJiOzGVDi8h/bVwvCivRvjdrZj
 0cmyrNI/GQ+TQYAXJdyKeM2Xunf8xkDOXKYXGe5oifl41BxycmnPxeQ5GdcZcYAniFEoiC
 DBnLg5lvQdCuOa0a3B6xu8oxDu6y8cg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-5z1bQZYANce444zwHs5azA-1; Thu, 24 Jul 2025 08:59:43 -0400
X-MC-Unique: 5z1bQZYANce444zwHs5azA-1
X-Mimecast-MFC-AGG-ID: 5z1bQZYANce444zwHs5azA_1753361983
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4f6ba526eso787493f8f.1
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 05:59:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753361981; x=1753966781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IKMYVgbMM/INns6RRVnU6T93DRZMyNIk0sjsY4fUN4A=;
 b=H7BHAApXxHqSYH4wCJaeLr+AP5/nspoNBdWolf06oKp7NwhqFybYawZkUGKdThK91c
 zghtW32TaIHns7YtHqsO/odwZ5+x14PPOzpHihDSv06E22Dm0FHSrOV2X1YC2K8C5exP
 Ecj6oyA9qTk1RxJFLjqqVB7OhA8gkEBEk/Wx3Zyox+GpHG5FcWZ6Wu6kHvo71LQIVOYJ
 G3VlvYHFXBjmFpEzW040hNB283qflt8YtRan750st93MRqL/VC3kQycD0+5uj9FzuamP
 IKfAUj6Ynri8ake4e/dFrA6czN72/yhxMtDbZCSTMmBuTSthugHXhUCT3JHzj2pQxugV
 WU8w==
X-Gm-Message-State: AOJu0YwsxJZ+Gb2Yvky3PJeMpi0ZXn0K3tNP1sJBvasitA5Fo5RgEDqw
 B3yXFcuaQXY/6vljdXEvu8ztBj7O9eLFplXe0+H8AP4u9DT3RZqGO7iaUWWg/btct1owsg6TsHS
 D9SbXwaZ6s2dGKyCS05wPyHq94N9Hr1drc60YBeiH8flXVSR6Od3Dq8/r9JBuORB0dgkNqc5eQr
 2WH/53kEzjyC27FjW/2DAa71XgZdwfLl/iKtUBPA==
X-Gm-Gg: ASbGncs8QeQgieu0GyX6GTHW24F6RuISZW4s8DvyKiXciGB0CoiHS+ESsao6OPxtMfP
 y3o6Q6OfdUn2jI9hMDkqRrlMBLf1Nk7lP7XO0zaHR0YjS1nUpYaZpD8r1zuvAgnU/JLQVCeC0kG
 N9mjv0wlF6hntu8w8z1L8eJ103y/nnAUltTAd0YLoH8fWnFH6oDn9hyw+L2a9MhNHHlSDVnJfGx
 waT//JWkwkBU25C3iQmDyO0AW0+ee26Q4bGAxGrJBs49KxO4YdpP9YFlXWd/kKvZtg7vZ5fRyhe
 v/V6uvaSsCOrvfFJ1Cp2sQc3boal31ZeLhNW09RS8uMlUfoypOw4XxvLKglN7+pt6hHe7ap5BoC
 dgMn9gtqKNpjumWiccwS6tQ==
X-Received: by 2002:a05:6000:2902:b0:3a4:e68e:d33c with SMTP id
 ffacd0b85a97d-3b768f078f4mr5465579f8f.47.1753361981356; 
 Thu, 24 Jul 2025 05:59:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5nm5U6RCUIZqblpUr2OHWLCcClaLAP17vkS8f4d/FMhrsZbc4cui5RFq4r8PRQnP/ZrFwCw==
X-Received: by 2002:a05:6000:2902:b0:3a4:e68e:d33c with SMTP id
 ffacd0b85a97d-3b768f078f4mr5465557f8f.47.1753361980905; 
 Thu, 24 Jul 2025 05:59:40 -0700 (PDT)
Received: from localhost
 (p200300cfd706376dff28b03aa15f3cdf.dip0.t-ipconnect.de.
 [2003:cf:d706:376d:ff28:b03a:a15f:3cdf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b76fc6050csm2110458f8f.3.2025.07.24.05.59.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 05:59:39 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Czenczek <hreitz@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH 2/2] vhost: Do not abort on log-stop error
Date: Thu, 24 Jul 2025 14:59:28 +0200
Message-ID: <20250724125928.61045-3-hreitz@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250724125928.61045-1-hreitz@redhat.com>
References: <20250724125928.61045-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.45,
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

Failing to stop logging in a vhost device is not exactly fatal.  We can
log such an error, but there is no need to abort the whole qemu process
because of it.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
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
2.50.1


