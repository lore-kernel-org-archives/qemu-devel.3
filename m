Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82ADCC79FBB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 22:45:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4nPS-0000X9-Fb; Thu, 10 Sep 2026 18:38:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lQ1-0004T4-Ps
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:31:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lPl-0001tX-0n
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:30:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789072143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=swaVK7hHvfhctLSwvjj1/ywE8ntA6Euz0DduNvrigAM=;
 b=Jq3ntEieeSye+JA8iH5wIMAxqaFULz+lfImFLyEx99ajK+uIqtWaI56DDpY5ZZEAvFrj0N
 wpslRFSUnfopSAo1OxKqpHv4JAAXEKiGlbbIw+JKk4zEqej14TUMbzfHLndU3HZ34rPKkH
 UIArdAdfKuc8ctfrytn230rS8sprVm8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-S1E6HD3INu6fmcFrn08U1w-1; Thu, 10 Sep 2026 16:14:27 -0400
X-MC-Unique: S1E6HD3INu6fmcFrn08U1w-1
X-Mimecast-MFC-AGG-ID: S1E6HD3INu6fmcFrn08U1w_1789071266
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49564d4b849so501405e9.3
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071266; x=1789676066; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=swaVK7hHvfhctLSwvjj1/ywE8ntA6Euz0DduNvrigAM=;
 b=fZR1zv1WH48dFQNtsRCEuIXcIGCE2FvwJvpPGiez6JYkltpvjIEl6+W/xvQS4jRkAT
 Pqr6Lye62LwsyViopaZ5PZoeuAmSWCm3F/vgYcjtOjWHrkEyxm1zkzNYNX1hLjCWAdIB
 ObIj5HMmraCSjdt8W+uyr3GlvXFzRK24kuY103QLpyRxEoWFKTp/NfcWkM1GNA3cp3aF
 7OnzLgfYCfeWrbmOTZ/CG/KbEaUkawl1cDgunOlgS7B8ohkh5N5u1Wna61GHnBBid5s7
 FnHBnB1DCmCVBlx9PssC2omrtPvBO7lRSPdicPvtWenIcJ2V5PWiea2lC9tv5imT2fsE
 tCWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071266; x=1789676066;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=swaVK7hHvfhctLSwvjj1/ywE8ntA6Euz0DduNvrigAM=;
 b=MI0tsK+ZlnUmahaoHuYvM9ZL01NArIBwJ+1zbW5X4ePFA9PuFkODIMuThO/sTfPymr
 1A5rMGSakedJ7o9LvI44jN4o6NEm7QjxgsDhQatEaHCU9HlZsRXS1xIQXi5tMEK94Loy
 5mpOx1I3qa8cj/p09qttu85M07+Jq2IpVvoer4bZ5Lj0YCYVH0nDBekjUAzE8xrRzKbA
 GY9MiKJ+rJYFKjR24iBwxg6yq0dmn4G4SsRnwB7mdDEvu0N0ZKlEfo+7snioW9EGqd1A
 gum4TH0Irg1U+ucpDlpNTHy1DkuzZHmrjuo6fsCH+DRdxwZ/46OlWrSM08PmrQfpWIuE
 IzeQ==
X-Gm-Message-State: AFuF++m3vu2sAgVBjd64JNs+HkkIkHqEZAShhRC1EeEEPGYDmZljOwi/
 ICjof9AY50wExDIm/6Vy8jTsIbJ/1Fihir8xFAHnTE8pWLgES7MD110HgZUwIURv6Wuz5/CoMBU
 76IQ7Dql+GEcPqwUC61DQ7rLPKnd0uI4ZJnpSxYnE5yt0lb7yJM83CUQcpR/Un17PB5qkw/N9K/
 1QsJN+6pwqaKi4+0qhsXHZn2B4C80IAu2/uQ==
X-Gm-Gg: AYBFou35N+C7YOrWWcIjTqxF86i7BARxHFoJiCCGcTCj8OTq2/plkLst/m4wJ2JwPAh
 fAaZAA9iuvM90yecNzCtjMl+HNiEflj1bH/RFooBSsMr4SQPK9qa/MaBnXR35BjwiQWvCFB0/Sb
 9ml1tlVd43G+gI8V7cJDnMMtFkDAy13x3Pu2eaeBv3ZKi7ymV0Z40tUbt0+WBsACFTDpHxYs6fB
 Dbxk/fUKRansE9QYhgwbfIewl2jFth9Dfx5D6+s92S3Wr/VqBGkN3Ik6B+WqVW5K+MqI0ImiGgR
 YcaLmWNT+6jnApdYrP9bb2QRn4/zIKcR6BHecYagc+xxVb7it8QvzghPZeo0JBLJjZH9yX2K3y8
 iSIf4Unm3U4tr4p7LqK/xcEc=
X-Received: by 2002:a05:600c:8a1a:10b0:49c:ee22:364c with SMTP id
 5b1f17b1804b1-49e6198d0a6mr6071305e9.9.1789071265730; 
 Thu, 10 Sep 2026 13:14:25 -0700 (PDT)
X-Received: by 2002:a05:600c:8a1a:10b0:49c:ee22:364c with SMTP id
 5b1f17b1804b1-49e6198d0a6mr6070975e9.9.1789071265196; 
 Thu, 10 Sep 2026 13:14:25 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26d4e3f3sm104182515e9.15.2026.09.10.13.14.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:14:24 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:14:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Junjie Cao <junjie.cao@intel.com>,
 Jonathan Cameron <jic23@kernel.org>, linux-cxl@vger.kernel.org
Subject: [PULL 70/90] hw/cxl: fix the CDAT DOE overlapping the Flex Bus DVSEC
 when sn= is set
Message-ID: <aec100794247860605cf259effc085eac43d0e8e.1789071043.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Junjie Cao <junjie.cao@intel.com>

ct3_realize() adds the CDAT DOE at a fixed 0x190.  Since 8700ee15de the
four DVSECs take 0x90 bytes, which from 0x100 ends exactly at 0x190.
With sn= the Device Serial Number capability pushes the block to
0x10c..0x19c, and the DOE, added later, overwrites the last 12 bytes of
the Flex Bus Port DVSEC: Capability2, Control2 and Status2.  Nothing
catches this -- pcie_add_capability() checks bounds, not overlap, and
the chain still walks because the DVSEC's next pointer becomes 0x190,
inside its own body.  Most cxl-type3 examples in
docs/system/devices/cxl.rst set sn=.

Derive the offset from the DVSEC block instead, as cxl_upstream.c
already does.  Without sn= the layout is unchanged byte for byte; with
sn= the DOE moves to 0x19c, below the AER capability at 0x200.  The
type 3 device has no VMStateDescription, so its config space never
reaches the migration stream.

Fixes: 8700ee15de ("hw/cxl: Standardize all references on CXL r3.1 and minor updates")
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260831022302.406740-1-junjie.cao@intel.com>
---
 hw/mem/cxl_type3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 6f44770db6..a04dc74ecc 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -936,8 +936,8 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
     }
 
     /* DOE Initialization */
-    pcie_doe_init(pci_dev, &ct3d->doe_cdat, 0x190, doe_cdat_prot, true,
-                  CXL_T3_MSIX_PCIE_DOE_TABLE_ACCESS);
+    pcie_doe_init(pci_dev, &ct3d->doe_cdat, cxl_cstate->dvsec_offset,
+                  doe_cdat_prot, true, CXL_T3_MSIX_PCIE_DOE_TABLE_ACCESS);
 
     cxl_cstate->cdat.build_cdat_table = ct3_build_cdat_table;
     cxl_cstate->cdat.free_cdat_table = ct3_free_cdat_table;
-- 
MST


