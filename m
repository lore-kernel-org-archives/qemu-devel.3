Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5344D606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 01:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=X+ATLZdX;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=HAJHUNB6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQDsj-0005LH-2V; Sun, 08 Nov 2026 20:09:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gromero@redhat.com>)
 id 1xQDsh-0005Kv-6S
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 20:09:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gromero@redhat.com>)
 id 1xQDsf-00007K-Cc
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 20:09:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794186543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ThnQ47uR9YP0Y8O59bWm70NHaWK3gKmlsrZiu8kOu7Y=;
 b=X+ATLZdXYZhEMDjejjeejJ4xuYWX18+Tx5oEy6ySvnvUL2aN+q8jZQVDMG2ueMux5ZQb/V
 277ahBsIzVI2ohMf8akveHv/ll1Fh+KEhoOuAF6IwcIpWpZoYCMD/lxTFfUifoOmuP6Kfe
 B33u98fK91+C70tQJUYkcMD0oEZOjng=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-DE3R0dCPPDG6-5bopSimrw-1; Sun, 08 Nov 2026 20:09:00 -0500
X-MC-Unique: DE3R0dCPPDG6-5bopSimrw-1
X-Mimecast-MFC-AGG-ID: DE3R0dCPPDG6-5bopSimrw_1794186539
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a1d1f26a63so2057405e9.1
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2026 17:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794186539; x=1794791339; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ThnQ47uR9YP0Y8O59bWm70NHaWK3gKmlsrZiu8kOu7Y=;
 b=HAJHUNB64gNEJhmg/GS0HQ2NZnWipWtWfbGG0ab2yijnys62I2sFjUV27qdEg72Lgo
 7d31pyY8XzUOiA1RV4paFcBBKJgS8wEEdhtHkK2Y6Hidlgaz/6LtifxRpReob40gM2mI
 Rt8mXTWbCkgvbmfLIXJxqbmOwct/KjTB7qZLnzg5ip7nTsHmmDlQpjpLYymuWoEqico9
 0d1Bx1J6Gb0eN8VEvV2sJ0yhpa46MJsLoooxr8pOWQj/GQjRT6HR//LlysctmQcWHF9F
 NDB5kdJYpLkOlk5OvADeRmss5mKvtClKe62VaPWlly48fYr8cmDqezCRqyY7X4/Rthaa
 tP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794186539; x=1794791339;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ThnQ47uR9YP0Y8O59bWm70NHaWK3gKmlsrZiu8kOu7Y=;
 b=YxvCHsY52+6+pT6acz7mPMNURlTeJCks7/E5jCnI4u4F76lVzgNa5tD4sTa8IHAtSx
 iXTkBcKBunnCwgerEWuHiXAov6g1HF/Nco+DJNayYOpMnXnOT/UT0AM56XfFo0sUpTco
 x//GqjSEuAwruyNiT88WuslfwPTGzQWWkkh74EDBrWmah1Nvz1H/HjZxwHeXyNyU8YPV
 N6j+H9M3aOgGQgakmocRzwyAuXmID9muDs2SZnZ4NIryDQtdTs+4EgTP9Nf8M2ZhPkuW
 8lAlKIhtKWmji6nX/Csk5xuAgq+rtJWsdytljgo8yGQ11CKjPU5O9LovjGAfCp0+u5ka
 MZyA==
X-Gm-Message-State: APuU4Z84DnhFr38HjETtWYEAcQN5lhrOxwkMfpEBis8X7J3sJgDLQVFy
 98fbwf+mcIb6ucBhJ39sJPNsw3U0c2Pk6ZOVd/xxJb0t5eCJ6Wr9dc5osml72rMHiFgTZ6XOZwz
 qS37KITTfHyF7hgZiyUhgJhTZOMU/+7M8vZOTf+J52/l6exF3D5tc69TVp2Ox1PIc
X-Gm-Gg: AYBFou0fjc3bkcFdzzWA7DkXwQRfgFsUpkH9kKpxNaY2zHNCVc9UIUBuhe9F9uJF+HW
 hQk4SguOkWxmL91mDhEN6K93RjhAb9aD/hi670N4GkI6KzmY5lLQy16m0TlF29kVkmGaVYx06fd
 XMAG1abJcVsad9Im2Ztpy4sidcmDjCaQksfXxeaThRYyTIO/CwoqNhA55Kz2SL04d4VRhYZ952c
 PLA3s/00gYTWeg1YkRolhAEPrNK5+kByk5efV7LuiBuym3xMJH9ajo/DeUQ7NDwAxcDJwX3QTYK
 Km0b2QXdUQxqv6/z3Wl3rze44QTRhXpOUCVQPdejG6pb+vF7xIPLaTLTagta7A8rj3SM06J4v4n
 AFyDFwH+tJ99fZLW/7peN9ZWQCUQxZm2c
X-Received: by 2002:a05:600c:83c8:b0:4a3:18ca:806 with SMTP id
 5b1f17b1804b1-4b963c6bc6amr46602935e9.20.1794186539273; 
 Sun, 08 Nov 2026 17:08:59 -0800 (PST)
X-Received: by 2002:a05:600c:83c8:b0:4a3:18ca:806 with SMTP id
 5b1f17b1804b1-4b963c6bc6amr46602765e9.20.1794186538901; 
 Sun, 08 Nov 2026 17:08:58 -0800 (PST)
Received: from x1 ([151.41.153.165]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b7d54d6f93sm316433515e9.0.2026.11.08.17.08.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 17:08:58 -0800 (PST)
Date: Mon, 9 Nov 2026 02:08:55 +0100
From: Gustavo Romero <gromero@redhat.com>
To: Jim MacArthur <jim.macarthur@linaro.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/4] hw/pci-bridge: Add pcie_add_dvsec_capability helper
Message-ID: <5ypckdele5g7ttn4bojpgipyriirbch2ngoq5bhbafrtfv6ohl@kda4ym255hhq>
References: <20261029-jmac-pcie-rme-extensions-v1-0-212d2409563e@linaro.org>
 <20261029-jmac-pcie-rme-extensions-v1-1-212d2409563e@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029-jmac-pcie-rme-extensions-v1-1-212d2409563e@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gromero@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jim,

On Thu, Oct 29, 2026 at 03:05:10PM +0000, Jim MacArthur wrote:

Please add a commit message to this patch. Even for small changes, a few lines
of context help reviewers now and anyone reading the history later. For example:
why a DVSEC helper is needed, what this capability allows, which upcoming patch
uses it, DVSEC meaning, PCIe spec reference, etc.


> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
> ---
>  hw/pci/pcie.c         | 16 ++++++++++++++++
>  include/hw/pci/pcie.h |  4 ++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index 42bcb9206d..42c4997b42 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -1157,6 +1157,22 @@ void pcie_add_capability(PCIDevice *dev,
>      memset(dev->cmask + offset, 0xFF, size);
>  }
>  
> +/*
> + * Add a DVSEC capability. As per pcie_add_capability, the caller must
> + * ensure (offset, size) does not overlap any other capability or extend
> + * past the extended configuration space.
> + */
> +void pcie_add_dvsec_capability(PCIDevice *device, uint16_t capability_id,
> +                               uint8_t version, uint32_t offset,
> +                               uint16_t size_bytes, uint16_t vendor_id,
> +                               uint8_t dvsec_version, uint16_t dvsec_id)
> +{
> +    const uint32_t header1 = size_bytes << 20 | version << 16 | vendor_id;

Header 1 should have 'dvsec_version' in it, not 'version'. As a side effect
'dvsec_version' is left unused here. Also I think it should be 'dvsec_revision',
not 'dvsec_version'.

I also think it's better s/size_bytes/dvsec_length/ and
s/vendor_id/dvsec_vendor_id for consistence.

It's also better to add range checks for 'dvsec_length' and 'dvsec_revision'
since their size don't match, respectively, size 16b and 8b, like:

      assert((dvsec_length & ~0xfff) == 0); 
      assert((dvsec_revision & ~0xf) == 0);


> +    pcie_add_capability(device, capability_id, version, offset, size_bytes);

To me, capability_id and version should actually be hardecoded because a DVSEC
is by definition PCI_EXT_CAP_ID_DVSEC with Capability Version 1, so:

pcie_add_capability(dev, PCI_EXT_CAP_ID_DVSEC, 1, offset, dvsec_length);

I'm looking at PCIe spec rev. 7.0.


> +    pci_set_long(device->config + offset + 0x4, header1);

Could we use PCI_DVSEC_HEADER1 here instead of 0x4?


> +    pci_set_word(device->config + offset + 0x8, dvsec_id);

Could we use PCI_DVSEC_HEADER2 here instead of 0x8?


Cheers,
Gustavo

> +}
> +
>  /*
>   * Sync the PCIe Link Status negotiated speed and width of a bridge with the
>   * downstream device.  If downstream device is not present, re-write with the
> diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
> index ec25e7a7de..86c29f7d8b 100644
> --- a/include/hw/pci/pcie.h
> +++ b/include/hw/pci/pcie.h
> @@ -133,6 +133,10 @@ uint16_t pcie_find_capability(PCIDevice *dev, uint16_t cap_id);
>  void pcie_add_capability(PCIDevice *dev,
>                           uint16_t cap_id, uint8_t cap_ver,
>                           uint16_t offset, uint16_t size);
> +void pcie_add_dvsec_capability(PCIDevice *device, uint16_t capability_id,
> +                               uint8_t version, uint32_t offset,
> +                               uint16_t size_bytes, uint16_t vendor_id,
> +                               uint8_t dvsec_version, uint16_t dvsec_id);
>  bool pcie_insert_capability(PCIDevice *dev, uint16_t cap_id, uint8_t cap_ver,
>                              uint16_t offset, uint16_t size);
>  void pcie_sync_bridge_lnk(PCIDevice *dev);
> 
> -- 
> 2.43.0
> 
> 


