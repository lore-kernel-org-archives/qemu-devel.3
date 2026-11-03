Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADE4606A324
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 11:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gzGA5yNV;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=jLIpiY8F
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOD2Q-0003gL-DU; Tue, 03 Nov 2026 06:50:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xOD2K-0003eP-Ti
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 06:50:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xOD2I-0000KQ-6b
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 06:50:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793706641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m0qbRXJbDPkLJdjaZclhzEufolZE690wiCirz9W/4hE=;
 b=gzGA5yNVaeTC/Z1l7Ax4IoH9GMPLyV89pa+YvNaNDoJN39bH6bxpXFyfOd1fSYIn7OkdVI
 2mYyPFZ+oqmQz39dKQ0v1adn3FemFXzQy8D0k88mPj618rTXvvW1p1LFhnxPfNhYj9ujQh
 qk1lRDZx4kIIeqWp9Y57moVzwNjItV8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-xXh6FCcSM9-j9rpL5IrK9Q-1; Tue, 03 Nov 2026 06:50:37 -0500
X-MC-Unique: xXh6FCcSM9-j9rpL5IrK9Q-1
X-Mimecast-MFC-AGG-ID: xXh6FCcSM9-j9rpL5IrK9Q_1793706637
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a2063be141so37295405e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 03:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793706636; x=1794311436; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=m0qbRXJbDPkLJdjaZclhzEufolZE690wiCirz9W/4hE=;
 b=jLIpiY8FtO0bViiOkAp112b0MddppKH1dkIiTiSB+1rQWy1+ixEEim2L+B7sHCJZ3d
 IcQnW3NJGkn2d6Ydp3y9f+yEC91fJO8RZ3p2Hq+NXdLSQ9qNDoYJDcwOWBe2eB4jzm6W
 5CvI6sboLFuSDxT5eDDCmaeFVon4Lder1O/pjCy0TxJm32UGmturifORLiXWGvPJY4Cn
 pmUIzBwkhZkrxrvt8Wo3mysdYpcwnt1rBhVfh9CyKowcg7/WHE/qoUVEGxkegFMnauM1
 i++NF118Xu2CGKTO8dD59zXxn35E0kLpfzpx/noGbzEP66IED/B9NIv/3480NiJVXCbk
 AKTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793706636; x=1794311436;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=m0qbRXJbDPkLJdjaZclhzEufolZE690wiCirz9W/4hE=;
 b=2ss+zyMkZ1vaGpTeGEvThXI9O3FJ2vk/KbaS3djqlyL/HjhMeXRhtNo/dn5dJ+UPtu
 1TlNX4amNNJxISePhGYlhERPRjNe/a4r+MN3Hb9qojfhznTI0x9pAZ6+3Yumo4ERR36N
 6VOQ3OG/q8tCFc3nARfNyTiAKCzbW59AUyTtxPLUoEHA9P03OkZAKfw8uNWLIGQixJsL
 WUc6/ezNFN6h06VmBpHU1XEluo++5RhKf0TzT027tg/tukSVQ56D+RSsltIWUzxsz/T/
 9b2HHPuMqs9XbMCAat1DvhYFH+boTigQkYOo7zJjgO81OTVmL6dmJKnd0JB64a8Uyvr0
 YK8A==
X-Gm-Message-State: APuU4Z9HJxkFSkRJUeE5srf3NKQ8NTBOR+njERdT4znYi8m5dVr5EbJ9
 QxWI78TQeHYy6Wf3QHDbIfkXMJLRa6nOeLoSAHY3efOZItb6c+DRcC7Md+o8s0tueMivKFxEv59
 D+jJVeFoBuuqffVa7bE4kqq38R812zoyKP5iCfDCCdfpseRYxhjUtLJ1TblOxrC6NofRCzTERZz
 tNM2QDcKDSgkUpNaFZMXphV/pnJNfycHZsMg==
X-Gm-Gg: AYBFou1h47+5P2R+tCVBApzI0A86rBz1IVxZE37KB+XD1+/jA2vR2xqju9XUWMPGios
 GNqqRrmB6gGa7Z+4HuYoe3qVAUZslYTZLh44OIATc9OwdBYYF1ZS1I84Jwob8z3Mp6EyBm6csHG
 OZXbteignHIY9pZVy2EmqHDTGQydORv6npjWjO0IrbXfbv4ylPbtk/9WJD191U/82M0LTpjhEiW
 VhdOAY1mVnJbXOqUEjgrPPJBXxOvS1cQWk8nAGYXYNgGZcpKpoJOxfWB2lVb/K0XfTbMK2Szd7k
 bOhV1e4c6XARUOxfgsU1FhD0Z3APyHo8SQnmzULqTZ8HSVTlSRaxlE2ELaMx9PbNQeT06Y+4fhy
 mkXsJLmQx789tGrIvJsVWgPiOsAfbg5KVat44eBZ/KA==
X-Received: by 2002:a05:600c:4e13:b0:49c:d019:70c5 with SMTP id
 5b1f17b1804b1-4ac1228978cmr270900365e9.0.1793706636590; 
 Tue, 03 Nov 2026 03:50:36 -0800 (PST)
X-Received: by 2002:a05:600c:4e13:b0:49c:d019:70c5 with SMTP id
 5b1f17b1804b1-4ac1228978cmr270899815e9.0.1793706636077; 
 Tue, 03 Nov 2026 03:50:36 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1506:fd00:9e19:9994:44b1:e6f2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71bab1a8sm24296457f8f.57.2026.11.03.03.50.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 03:50:34 -0800 (PST)
Date: Tue, 3 Nov 2026 06:50:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Daniel Paziyski <danielpaziyski@gmail.com>, qemu-stable@nongnu.org
Subject: [PULL 05/17] pci: fix null pointer dereference on pci device
 registration failure
Message-ID: <7ecad9ed2e1c7fc7076cb23186c0e3b3317b6c4e.1793706601.git.mst@redhat.com>
References: <cover.1793706601.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793706601.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Daniel Paziyski <danielpaziyski@gmail.com>

When a PCI device fails to be registered using do_pci_register_device, which
takes the PCI device as one of its arguments, and returns the PCI device itself
on success or null on failure, the acpi index is forcefully released using
pci_unregister_acpi_index.

However, this causes a null pointer to be passed always on failure to
pci_unregister_acpi_index. Instead, do not reassign pci_dev from the return
value of do_pci_register_device, just check it.

Cc: qemu-stable@nongnu.org
Resolves: Coverity CID 1689947
Fixes: 432ea8cc7d27 ("pcie_sriov: register user created virtual function before realizing it")
Signed-off-by: Daniel Paziyski <danielpaziyski@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261101162132.147838-2-danielpaziyski@gmail.com>
---
 hw/pci/pci.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 2d2fe02c68..1ea388be37 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2327,10 +2327,8 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
         pci_dev->cap_present |= QEMU_PCIE_CAP_CXL;
     }
 
-    pci_dev = do_pci_register_device(pci_dev,
-                                     object_get_typename(OBJECT(qdev)),
-                                     pci_dev->devfn, errp);
-    if (pci_dev == NULL) {
+    if (!do_pci_register_device(pci_dev, object_get_typename(OBJECT(qdev)),
+                                pci_dev->devfn, errp)) {
         pci_unregister_acpi_index(pci_dev);
         return;
     }
-- 
MST


