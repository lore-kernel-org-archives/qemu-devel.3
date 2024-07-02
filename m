Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E66DC3271E
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:34:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOk0J-0005kS-QR; Tue, 02 Jul 2024 16:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjzU-0004oH-3j
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:20:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjzS-0001fD-Eb
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=actUboiQ+IrTgCsdz18KhXUIoDAvYkrEhXUsAIxh/Nc=;
 b=jMxqsST9afUvCKLr5XrAqdOjjwsEZidyIxye4ZipJR1JtyiAVLJFmITez1WYPK0sYOvMwN
 D/Xzyz1yODVTrk2SQcBzgsE0CFCrg24KfDh4I/RIo1X6SeoPVgqI7n56GQEP7GICXb0vlI
 4XhNKT2ujetEvCQ9jsaSwcIaRqF7dho=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-w2XAogIFOaKG95DIwplffg-1; Tue, 02 Jul 2024 16:20:35 -0400
X-MC-Unique: w2XAogIFOaKG95DIwplffg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42566e8a9efso42185895e9.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:20:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951634; x=1720556434;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=actUboiQ+IrTgCsdz18KhXUIoDAvYkrEhXUsAIxh/Nc=;
 b=Xr5gm+BFXrM+vK1ZPhXQUGaXOhP+b0XcdMfw8CwbDhH9Dh33nBeYaay0ZryuI0AfPS
 hQcki9QH+rPG+brGG1Ue3iAboqWwEDOs4Arf4P6VwKW1+VoxrEYhpVEA5cCVTYN1qmUr
 +a9iGfLNjjesoRAQyKwUXcDEbaEsuFJHN6MOsmjyYB54b+GyS9V/jFz4yFq1LAezsOxo
 F7gbM1u5DcTlvjeLc2Kt4u54T13eYyKVfd+t86m7lQUo/5lmdrmJWQdBUtg82YuHszOe
 CEuFVWE/7/P817B6jWM5JS8v6ZYpKHpsRfsJsTwIdvdY+f135EXk9a3ibyW/b1RRATXC
 SisQ==
X-Gm-Message-State: AOJu0YzzHo5nf2xBqUE01jH7o3z05Xq87tZejMB86b2Y83n0KPdObFHQ
 A9JrLgUjSue4iegJ+fNq73a2M1xLMlXhpFFo2MnH3J93t51ap9TInetJRhB7AK2S3hJNUJodg/e
 Km9uop9y1YYI7C1aZJFDWovy7F8D2DPAm7wXSt6s0rV3dXMnlnA35wBabFAXhC3P48d75uvWkPy
 Dnxckz65TvJ9ItF6cVqyvpVa7emxJSyQ==
X-Received: by 2002:adf:f18b:0:b0:361:dd0c:678 with SMTP id
 ffacd0b85a97d-367756bc471mr7294514f8f.36.1719951633881; 
 Tue, 02 Jul 2024 13:20:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElwaApP0XIJ4pjyGb7BSj59w+Y8v1dEKdAKZhiQ4vH4/PKwktwFYx+c/wz1REhd0gpEnEjUQ==
X-Received: by 2002:adf:f18b:0:b0:361:dd0c:678 with SMTP id
 ffacd0b85a97d-367756bc471mr7294488f8f.36.1719951633340; 
 Tue, 02 Jul 2024 13:20:33 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0e1412sm14091632f8f.53.2024.07.02.13.20.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:20:32 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:20:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org
Subject: [PULL v2 80/88] hw/ppc/spapr_pci: Do not create DT for disabled PCI
 device
Message-ID: <1367c24db02afde209d307d653313351bf774b07.1719951168.git.mst@redhat.com>
References: <cover.1719951168.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719951168.git.mst@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Disabled means it is a disabled SR-IOV VF or it is powered off, and
hidden from the guest.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240627-reuse-v10-2-7ca0b8ed3d9f@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/ppc/spapr_pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 7cf9904c35..f63182a03c 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1296,6 +1296,10 @@ static void spapr_dt_pci_device_cb(PCIBus *bus, PCIDevice *pdev,
         return;
     }
 
+    if (!pdev->enabled) {
+        return;
+    }
+
     err = spapr_dt_pci_device(p->sphb, pdev, p->fdt, p->offset);
     if (err < 0) {
         p->err = err;
-- 
MST


