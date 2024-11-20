Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36509D711C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 16:31:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDnbY-0001MJ-Uq; Wed, 20 Nov 2024 11:31:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tDnbV-0001L2-9b
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 11:30:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tDnbS-0004tK-Cb
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 11:30:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732120251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=gKm8+ln1RsGHlHTYgXUJDSV+BABTA/Y+kP4x4SeT1DE=;
 b=J9LcKjxdHvdDFkPrQCbeqqIhWFjCdTGr6p0uzJoZ0sdHmAQbPIoFYJ747vMND1VozhGVO/
 ZJiDVOzKyr8rVu0DAUYeJFmXrVqECs/OSRommrS1mZvneGSECwrrYR6ZojGisFnCNvY1qu
 /kj8gYoq7SoOyR5Q7eA7g4/H4o8I6KA=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-7Gyf7cs1ObiTXuW9jcWX5Q-1; Wed, 20 Nov 2024 11:30:50 -0500
X-MC-Unique: 7Gyf7cs1ObiTXuW9jcWX5Q-1
X-Mimecast-MFC-AGG-ID: 7Gyf7cs1ObiTXuW9jcWX5Q
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-83ab1b39ab1so249478039f.1
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2024 08:30:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732120248; x=1732725048;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gKm8+ln1RsGHlHTYgXUJDSV+BABTA/Y+kP4x4SeT1DE=;
 b=AOnzlaZqnlC0j0836kgD+Xl0st/FsrsL+O/lDgfON5EK9q6i9mDTH8pfpqm+bM/BZF
 gWETAPaHO87BAqFPe12EJeDzZoVp8ir+OEISmpeBP751QHa7h3nGsZKV8mAxEc6ESviL
 Shxxhc+sQ67lVeF5NXHBmfZVEJl+V5N3qhjlI8q7o6LQ7CEm8Gpfy0E4bClBJWEFzBdK
 OAVf+PszV+k8RXgdw+PYNrhcCOub12htQwlq4/EwrfuGgSEPy+KTVqd9qnq99FtZEHWW
 HwQPYTX0zTtx/GLuu2LJQvbHuMPB+48UpHPcf5/klKLWjkNyqP93U1i7MiEwvmAdF+cs
 ulUg==
X-Gm-Message-State: AOJu0Yzg8EiAUVvMmjLatHWjPDfnECdXLnOmUqBqI0+6u85+BkK9LTLa
 Zp6Gxo/RImJ0PCk/QYkEBOcGVhmkVf1H2jaZruWwihWpdk66WoMoRMWGYtE99DTq550cQPgxHZ8
 DQsA74QoxjWzLK++ltYfnKh9F8kPZpV1ZiFZbHep80YUOhTbNcW+/wHzFmalgUN2doiOjrZJjBK
 z8JMgWvxIFNelj0keNUsD29er2DX4f6pEGiQ==
X-Received: by 2002:a05:6602:340e:b0:832:480d:6fe1 with SMTP id
 ca18e2360f4ac-83eb5e297a1mr396511939f.0.1732120248415; 
 Wed, 20 Nov 2024 08:30:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzckO8lXlyX+yVl4fXlllrMXFtYA/sha+j6kvaAUk4beAGumjyb9gOqNkcNLsWw0bD4dl+aQ==
X-Received: by 2002:a05:6602:340e:b0:832:480d:6fe1 with SMTP id
 ca18e2360f4ac-83eb5e297a1mr396505639f.0.1732120247853; 
 Wed, 20 Nov 2024 08:30:47 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e0756d648csm3217877173.116.2024.11.20.08.30.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2024 08:30:47 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] ahci: Add comment for possible slowness on ahci_irq_lower()
Date: Wed, 20 Nov 2024 11:30:46 -0500
Message-ID: <20241120163046.3661675-1-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

In some adhoc profiling, it's observed that ahci_irq_lower() can be a hot
path and the type cast might be slow and prone to optimizations.

Considering it's in ODD FIXES stage, we may not expect major time consumed
yet on this on either developing efforts, or reviewing efforts from
maintainers.  However still add a comment as suggested by Paolo so we keep
it a record for future reference.

Cc: John Snow <jsnow@redhat.com>
Link: https://lore.kernel.org/r/CABgObfbXuiqw01mzVLZEgw-o_tdbf83QzYugq7oL4g7TFVV_yg@mail.gmail.com
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/ide/ahci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 0eb24304ee..7ddcc4e37c 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -197,6 +197,11 @@ static void ahci_irq_raise(AHCIState *s)
 static void ahci_irq_lower(AHCIState *s)
 {
     DeviceState *dev_state = s->container;
+    /*
+     * NOTE: from some profiling on Linux VM boots, this can trigger quite
+     * frequently (10000+ when seeing the root prompt). It might be good to
+     * consider speeding this path up on the type cast.
+     */
     PCIDevice *pci_dev = (PCIDevice *) object_dynamic_cast(OBJECT(dev_state),
                                                            TYPE_PCI_DEVICE);
 
-- 
2.45.0


