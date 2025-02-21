Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E98DEC021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 12:23:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlS3o-0004n3-Bw; Fri, 21 Feb 2025 07:23:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS3f-0004cO-K5
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:23:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS3e-00072Z-0i
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:23:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740140584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3ztxZYHC/wgNt/4DA2+N5Hjvx7lOPTBhePRhwRi2JF0=;
 b=IG20LH4VcfZT+MMehrnkFmcNUwaJ9WS8RDq36ioQLHIlEB3rPHHtAsO3fM0RAp7RDKHOrd
 ID4cJDS75HDhEnvVQBrhwsgWCgG9lSHrxlT3UwJLPe0A1AxqT9v6aYjrUKJwdErS53igFC
 tz7tdCnCncOTH8bYk0yIINCuHyV5Y/A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-dh5asD9iNnWS0b41WCtdSA-1; Fri, 21 Feb 2025 07:23:03 -0500
X-MC-Unique: dh5asD9iNnWS0b41WCtdSA-1
X-Mimecast-MFC-AGG-ID: dh5asD9iNnWS0b41WCtdSA_1740140582
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4399a5afc72so10241825e9.3
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 04:23:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740140581; x=1740745381;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3ztxZYHC/wgNt/4DA2+N5Hjvx7lOPTBhePRhwRi2JF0=;
 b=Kzsu/TqBidv8KsNuKxUZ8839O8vVp+gutpcd7E+DdAh+yVoscz9Sywz8Yu7hlhnjRv
 dKJ7XZh3IpKSSPXAKtDFVvm/hoL9d6wiGYCvEcNeCTkjNjRa37z2FB0QbyPccZiw+nVH
 gRM/Y05fOC34gaYIHvfRqQnArZHXVmFK5lMNyNWwdv8WiOncWaFoJ54Naq8Xvln7rkHl
 ly2WbNVAUpRSeshFgd0RiKjx2XGrUD/Hkp3FBr89QQ0C8rqiQ9uAbvkPbr3waZu4i5az
 Bcs+b+tp4N8so4GBrT2K60dlIrMFegW4F+UKLKzdHcBYlbrwFrhJo7FxBpITdn+b9n+r
 tymw==
X-Gm-Message-State: AOJu0Yz/EOwHIM4ChvdQb1mglNTLhpv0rwmd0t2ReR2Mqg9h2ygDHNe9
 NejHORqd3bsFN8UHap1lNe2p5WIkR30df01P6M0tHV3RzdJctnTVNH5saE0b8mOik0wSF4kqUwi
 89hDp8ErRXaCyBYoINCI//ACmWHz9vKCw0IaJ+LKyvWUhHe2R1ZShjkdmAygXlpqe1VSt/CfYPT
 SdWQD2l+D64mBThjR0fEj8STGSWqBGKA==
X-Gm-Gg: ASbGncvk6HemloYvmd+xF83ly3LuIiRZpmBcC4Kjv+fSfpu1znoYXeMD9MKOHD4C+bE
 5EEpf1gto0jL1b8yMgU4A3d/MZBxX4Sz5q6iuEGG23m8wp3hzAs7dVxqF+jvq6ot1V/9H0nCYif
 7N6P3aU8Kk5OVPVYxByXcnlyLIVE6tEcW8zP0R9k76n2OcP4F5CTLJjsnFU7JpDFkadsEZy7aZf
 EKxzXRrQhmO6rQ9G0hQcmU0wosjIQbbfWuDgLq30a7LvL32yFDcw6fqssNs5jxVqgl1xgxKoTvO
 +zzoUQ==
X-Received: by 2002:a05:600c:19ce:b0:439:94ef:3766 with SMTP id
 5b1f17b1804b1-439aebc3138mr20844155e9.19.1740140581474; 
 Fri, 21 Feb 2025 04:23:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGeT4HQFf67yVdc8AorOK+9fKjah8vcnrXEqsk8/ReKKkZjjU5gx/L3XBezBIzeHa5WUxGlVg==
X-Received: by 2002:a05:600c:19ce:b0:439:94ef:3766 with SMTP id
 5b1f17b1804b1-439aebc3138mr20843865e9.19.1740140581064; 
 Fri, 21 Feb 2025 04:23:01 -0800 (PST)
Received: from redhat.com ([31.187.78.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b030bd09sm15790615e9.29.2025.02.21.04.22.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 04:23:00 -0800 (PST)
Date: Fri, 21 Feb 2025 07:22:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 08/41] pcie_sriov: Do not manually unrealize
Message-ID: <e8b827ce7c4bf9a334c46282779f234d1a011cd1.1740140520.git.mst@redhat.com>
References: <cover.1740140520.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

A device gets automatically unrealized when being unparented.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20250116-reuse-v20-6-7cb370606368@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


