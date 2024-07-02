Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C33C0C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:19:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeET-0007jc-Gt; Tue, 02 Jul 2024 10:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeEF-000675-T5
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:11:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeED-0000V2-DG
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:11:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6T5wYohIMyfJ7zfD4BymibarRz8jk6tb2fFAczZH0qE=;
 b=Bpw8fRhBkNXXgd9AGyUyLhFfUCA2Lb1zj+O8C+NljigKhcT3fFiXnxzPkbe/NqV1Vtwymo
 sHNM9R1Q/gNmQD90y7h9efEG12xObTTwROBESK8g38QeW7881Ld064zF4MW3iiCNxcq5wR
 nFudDMQyMWte6PyvKANychAJpW3WwAQ=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-rukY6QQ2OqKRmKhWxvcrBw-1; Tue, 02 Jul 2024 10:11:27 -0400
X-MC-Unique: rukY6QQ2OqKRmKhWxvcrBw-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-52ce7a15a62so4647907e87.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:11:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929485; x=1720534285;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6T5wYohIMyfJ7zfD4BymibarRz8jk6tb2fFAczZH0qE=;
 b=Pp2O1hMawcPeMmrA6LaDxB2ivJJ3a8k1bYQtOZqseygtBlvzPOAEXYOGq1nK1myRsY
 ZX5AV8IICb31nPlQ5AsjE3jWb5qs0Wz0wfp/sTQaCXSZwNN+s2seOdmPcGiAdmkqZTbx
 l21SAVZ3+NHsMxqAOFZ6liUWxSpjI5zdTy8wDKewCQsjPXqtPo4QnDQsZokrSwnCLqPO
 2P41atPdyAjAxqUm9EQe7QZ8TdYRgn/WOwb9lVbBMt+ADoPh2ESBke3G9qFX6f8hQIyL
 dCXfd+E9asJShyZA1SJuTBdQa0yB1w40Jh7LJ16qDVsx9aMeCA3Luqs7JIhdf+l/n8wb
 qLNA==
X-Gm-Message-State: AOJu0Yx+WOAmnp8tFJaqakQVWpp3Rw/0K4SkDwNLaJEq9vPOw3eN7eBY
 FlGpf5a1mPVn1hev17MfwAsDxBMpyNWI8+R1K75J21cdKXb5NCX2ApubmmvISiFoN5dT2Sv3AWO
 fSapxk4A4xwCcYcEmqMspnJ/3uukJj6MgH+6y2t6vKYCS3ZMtx/IDxweT8Q8JqXhSeMb4rt8CMc
 iHUwuqu5ZFT20OotbV9KCW/u07JALaMA==
X-Received: by 2002:a05:6512:3b0d:b0:52e:73a2:4415 with SMTP id
 2adb3069b0e04-52e8270adecmr7084391e87.46.1719929485006; 
 Tue, 02 Jul 2024 07:11:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFM5HYxHFGNBmB92gJijyddIVKu4mN02lMpyH6Q+TbiBXWLbuPRpq6Dl+sLLM5e0ZQihkGSQg==
X-Received: by 2002:a05:6512:3b0d:b0:52e:73a2:4415 with SMTP id
 2adb3069b0e04-52e8270adecmr7084364e87.46.1719929484337; 
 Tue, 02 Jul 2024 07:11:24 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42588492b4fsm59555655e9.4.2024.07.02.07.11.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:11:23 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:11:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 85/91] pcie_sriov: Do not manually unrealize
Message-ID: <2f9bcba626116c645f51c91f3fd5d98fadcb8d0b.1719929191.git.mst@redhat.com>
References: <cover.1719929191.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719929191.git.mst@redhat.com>
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

A device gets automatically unrealized when being unparented.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240627-reuse-v10-4-7ca0b8ed3d9f@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pcie_sriov.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index e9b23221d7..499becd527 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -204,11 +204,7 @@ static void unregister_vfs(PCIDevice *dev)
     trace_sriov_unregister_vfs(dev->name, PCI_SLOT(dev->devfn),
                                PCI_FUNC(dev->devfn), num_vfs);
     for (i = 0; i < num_vfs; i++) {
-        Error *err = NULL;
         PCIDevice *vf = dev->exp.sriov_pf.vf[i];
-        if (!object_property_set_bool(OBJECT(vf), "realized", false, &err)) {
-            error_reportf_err(err, "Failed to unplug: ");
-        }
         object_unparent(OBJECT(vf));
         object_unref(OBJECT(vf));
     }
-- 
MST


