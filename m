Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E51C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 19:07:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEZUk-0006Qs-IH; Tue, 04 Jun 2024 15:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZUi-0006II-5U
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:06:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZUg-0000po-Be
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:06:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717528009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3zfn4VTIDgsQPaDvqyKjQZ05mAdVtKBkByPV13wMR/U=;
 b=f1DGPsbXxGxqe9X0e4/zY1RwBFBKhQA647yMbhZDzdiTaqPtReHvXiJ/DbLMBrbxkCdY+S
 5/NhMeD+k+Or29VGIubkcRkJivrbqlELuRan3nu0wXGV/Lnjyf78abyCqbof6JGPoHsBuZ
 usnv9OF9a8p0dOOFG3jQiKNs+tq40As=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-fKVyAzdJMdaeZAIGEenNbw-1; Tue, 04 Jun 2024 15:06:48 -0400
X-MC-Unique: fKVyAzdJMdaeZAIGEenNbw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4212b505781so736115e9.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 12:06:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717528006; x=1718132806;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3zfn4VTIDgsQPaDvqyKjQZ05mAdVtKBkByPV13wMR/U=;
 b=UXN5ypeuKZ7/SYizAiyTNDe6HAKVbRARWie0AM+5hDKbiZBQKFkTcFk3JbZHZgbtJp
 816ZwRw+015IUIojOayKpVbdRSjvjWYNM+PT/9UMI4Uccq65pzpQVIk06bfUWPjavAyL
 IeDqS9mk5gFbIEabwGsmqaymnfq53VIQRLhcN2a0hRzkdtpE7bR1XY9u89aeouQH8Spo
 K/0uPGJTDfqCZagQR7aYfe9/UcKQ5BfTgQV2eSP6l3CCzxgR3lYzKzFkpfcZ3cgp2fBD
 BNcDVojqM0hThHTVJ2IXwa3O/Dyh9HX+ExmJ6AgTYETypUo2ETkMDulHUy3PcXqT0HTm
 MenQ==
X-Gm-Message-State: AOJu0YyBHrFbAC2W8XEQghrBEImQ7+WlXCSVFAZBUksx5BYAWBs55E/8
 2PRey5xMZtpC/f4+9bQ0nNPo7cZs7jjEEccQXIzeLpXkRRy7ueEzsdf4WoUCEOSvLfKWJqXlawm
 +Xdf28EZP+ncvoTvn4XKRkwjeR2DVxCVwkZX2KGXgr7LU7PgoazftdZm2Cq2i8Oh7ZMKblxSZjK
 pgtm10vDxQ1/WTXcUTVHaIPJvE7I4L4w==
X-Received: by 2002:a05:600c:3589:b0:41f:dc27:a7c1 with SMTP id
 5b1f17b1804b1-421562da803mr4711065e9.5.1717528006474; 
 Tue, 04 Jun 2024 12:06:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGChT8wJEL0oJPEJPXgKNHKA5dfs1OeutnYx8rHSVaYpYP7psNMEDgfuC0sKJxUrGUDTfcuEg==
X-Received: by 2002:a05:600c:3589:b0:41f:dc27:a7c1 with SMTP id
 5b1f17b1804b1-421562da803mr4710885e9.5.1717528005929; 
 Tue, 04 Jun 2024 12:06:45 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:552:cf5c:2b13:215c:b9df:f231])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-421381c650csm122214995e9.27.2024.06.04.12.06.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 12:06:45 -0700 (PDT)
Date: Tue, 4 Jun 2024 15:06:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jiqian Chen <Jiqian.Chen@amd.com>
Subject: [PULL 13/46] virtio-pci: only reset pm state during resetting
Message-ID: <272efd85b86b2c37ebb89a517d5ed30ee7695dbe.1717527933.git.mst@redhat.com>
References: <cover.1717527933.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1717527933.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

From: Jiqian Chen <Jiqian.Chen@amd.com>

Fix bug imported by 27ce0f3afc9dd ("fix Power Management Control Register for PCI Express virtio devices"
After this change, observe that QEMU may erroneously clear the power status of the device,
or may erroneously clear non writable registers, such as NO_SOFT_RESET, etc.

Only state of PM_CTRL is writable.
Only when flag VIRTIO_PCI_FLAG_INIT_PM is set, need to reset state.

Fixes: 27ce0f3afc9dd ("fix Power Management Control Register for PCI Express virtio devices"
Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
Message-Id: <20240515073526.17297-2-Jiqian.Chen@amd.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-pci.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index ad0035952f..b6757ffce2 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2309,10 +2309,16 @@ static void virtio_pci_bus_reset_hold(Object *obj, ResetType type)
     virtio_pci_reset(qdev);
 
     if (pci_is_express(dev)) {
+        VirtIOPCIProxy *proxy = VIRTIO_PCI(dev);
+
         pcie_cap_deverr_reset(dev);
         pcie_cap_lnkctl_reset(dev);
 
-        pci_set_word(dev->config + dev->exp.pm_cap + PCI_PM_CTRL, 0);
+        if (proxy->flags & VIRTIO_PCI_FLAG_INIT_PM) {
+            pci_word_test_and_clear_mask(
+                dev->config + dev->exp.pm_cap + PCI_PM_CTRL,
+                PCI_PM_CTRL_STATE_MASK);
+        }
     }
 }
 
-- 
MST


