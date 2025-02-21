Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F10EC021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 12:26:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlS3O-0004Un-L2; Fri, 21 Feb 2025 07:22:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS3M-0004QQ-Hw
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:22:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS3K-0006zw-BN
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:22:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740140564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0bNjdF5JuUjHCo2SOdNSUp94YzkHH1wWG4NRbjF7uhw=;
 b=H9LMrr/JY4vNmuJB4PfzmbDNwIOsm18uRiduTagVAH0bb0YYroPRsTGAkHLnAXcIJ63TT8
 C5IQrt++0vs49JyixOktfPK8E+/rgMU4u8nFKa7qOFI41xoHy/XkHILWbTJ1kWWubWprEc
 ubp+8pkRCU2Olou3vYm6F6fonTah5S4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-kc2rI-o0M7WvCS0-w1JoyA-1; Fri, 21 Feb 2025 07:22:43 -0500
X-MC-Unique: kc2rI-o0M7WvCS0-w1JoyA-1
X-Mimecast-MFC-AGG-ID: kc2rI-o0M7WvCS0-w1JoyA_1740140562
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38f628ff78eso1073118f8f.1
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 04:22:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740140562; x=1740745362;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0bNjdF5JuUjHCo2SOdNSUp94YzkHH1wWG4NRbjF7uhw=;
 b=AK2Tkx+MFT9xZolQbj5PkRBRUUouwIHTadAYaDGqB7PImHlOrWH52URVlR//MNuZ+2
 LKay9mr6qbLx+W6u+WoSxgGudKXam5h4uRE648kPiUn9b0oqqXW5AVJ30y5F39prqbb2
 +ECzCHSq7lN2zsBbSL0PbXMFLiSa/SVuNqs8TmwzmL8O2VnilZT0VtcsONDwEnJoJGHD
 8AAVYQFDL96JN0xyCBSGMQKyM4DGqN7inR1SqvZr/jHfK4dQpX1wnNM1lsFSL65rECLp
 /a+LDtcMDBmRH/5Noe6HqV2+lnUeg3o5aqoKQRCGOt+I/DFn0U7Iy2Tttf/OYOKrr025
 i5Xg==
X-Gm-Message-State: AOJu0YzFBLu7pIfeZVGZA1mhCR54sy0UuWNdDL3EwLR7XxeunIZnuAh7
 k4jNeUe/nr86MNMfMlHeliDV8cya3FrIHhhHUrl7KGnG+ggcmyUcFFD++ys5L19aRzrjPyi1Dxm
 5OgfaETmvg+ER5e09Vdb+zXuqpRsObg4nPxmfzfpyTFrg9S9NQ+U7Y7V2+KAP+HRZhctF1LIGkm
 34/KkILJBhGbXCROSgU98Ow17oQQNkIg==
X-Gm-Gg: ASbGncvKxDzG2kCctOJQPbSg6FmVKJbqgdTyOxSNWJgEMWCKwMebG6pevyJ3oPGI9sK
 Vs3ebyxNQYfzRQlHRx6XCa7Y/hzb6/zNp/WrQ+kuvnHrgdRRBDk+CBIx6aM7wHwx9WOTzPaTjjo
 /q0QCs5Y/nCI9lfTkk19FXnvLdQYJfu4j+ViZygVuIbpsYS4XX0OG5zVdkxyCfMreCy4sMvshgJ
 TEMGn8ZCuVuK67PE1aPYYOiKPcG+50X94fJ9KGSWkNo8MGWCDTkD+MnSHYE8DkLLUsLdZbObH66
 2s2dpw==
X-Received: by 2002:a05:6000:1a87:b0:38f:3ec3:4801 with SMTP id
 ffacd0b85a97d-38f616323bamr6689937f8f.25.1740140561789; 
 Fri, 21 Feb 2025 04:22:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHP8Lu5T3G6KwX0s36LKuCZMOXl5Nr+A2vHjtWT0conKupsh+PZkNU9WdkcSKo3XX8Mqj+bOw==
X-Received: by 2002:a05:6000:1a87:b0:38f:3ec3:4801 with SMTP id
 ffacd0b85a97d-38f616323bamr6689914f8f.25.1740140561459; 
 Fri, 21 Feb 2025 04:22:41 -0800 (PST)
Received: from redhat.com ([31.187.78.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b02ce404sm15950885e9.7.2025.02.21.04.22.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 04:22:40 -0800 (PST)
Date: Fri, 21 Feb 2025 07:22:38 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org
Subject: [PULL 04/41] hw/ppc/spapr_pci: Do not reject VFs created after a PF
Message-ID: <3bc31441ba31c94f12b7b96b1960abb4c1f21ee8.1740140520.git.mst@redhat.com>
References: <cover.1740140520.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1740140520.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

A PF may automatically create VFs and the PF may be function 0.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Tested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Message-Id: <20250116-reuse-v20-2-7cb370606368@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/ppc/spapr_pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index b94e4ba131..e0a9d50edc 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1549,7 +1549,9 @@ static void spapr_pci_pre_plug(HotplugHandler *plug_handler,
      * hotplug, we do not allow functions to be hotplugged to a
      * slot that already has function 0 present
      */
-    if (plugged_dev->hotplugged && bus->devices[PCI_DEVFN(slotnr, 0)] &&
+    if (plugged_dev->hotplugged &&
+        !pci_is_vf(pdev) &&
+        bus->devices[PCI_DEVFN(slotnr, 0)] &&
         PCI_FUNC(pdev->devfn) != 0) {
         error_setg(errp, "PCI: slot %d function 0 already occupied by %s,"
                    " additional functions can no longer be exposed to guest.",
-- 
MST


