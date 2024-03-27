Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE442C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 17:39:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpXFG-0007am-90; Wed, 27 Mar 2024 13:39:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1rpXFE-0007aP-PS
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 13:39:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1rpXFC-0003iC-Pq
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 13:39:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711561160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/+s/5bKOADtr4YhqJM2+cgt9HQcERQGr9y8REbauQW4=;
 b=JtEAQyHYBqKqwNKAK3mqCqPSBHX2wEkQD6H2ewbD4w9tSLxj+SI7MRrTF0kcll22bSyFNy
 6zpFUuDHI6pp3/Kl5YPw73SqEv4uKajMWteDdNjWamDkUf1jNSInkA2Pl4OfU0//nNAbwA
 dp+3+ro8o64ZeSiSiPwWgvBL3jsjFus=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-BCdtTphsMO-IJ54E8fp_iw-1; Wed, 27 Mar 2024 13:39:18 -0400
X-MC-Unique: BCdtTphsMO-IJ54E8fp_iw-1
Received: by mail-il1-f200.google.com with SMTP id
 e9e14a558f8ab-3665991058fso972075ab.1
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 10:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711561157; x=1712165957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/+s/5bKOADtr4YhqJM2+cgt9HQcERQGr9y8REbauQW4=;
 b=UnYGuE6zcCNu1q24hIG77IX2bT4rCeGaQWN1Q/Yp7GylrE51wcKJVPhsv9FmZdvfFE
 JrdwqaCW5xe59iAVajs9gaGgdN9OxsfDkKhiN3zgn3OAq9HRAhVm4xYts2C/yQJr7yLk
 DVRYf72iKl+gdx72bTn6WNQGTMa1Jwv6lBamXiaXUhaM7fALpQNKDD4qKjLuOVQSxBzB
 iL348VvjDFAKsDu/7uCUPLy9Fwx3xgUmu6uLZiIqGleisHhW0q5NV4Y6qcWZGnaA3OHB
 O9kQi45CNenmzRG9nTjw1nECjalB7DLP4zljTk83g2JtEcR3sBmcTT7hg6hvFQRKtF1r
 ZZ/w==
X-Gm-Message-State: AOJu0YyMq65MpRJ0CuhaY1BLm18oCyBPVYXT1ViIYMAVI6uVzrjY9MFX
 Nmh8OM4oTnWvzS5GDTTYGvZKl11TeoiwAypzrW66+P2y7f5q+kRDaO3bqFM0J2z6Bp7peW5UBtC
 7KjGzSjV3Toy3tbGReNdNnuoUv4K/00p8tmbCUYx0iezLwLso86Nv
X-Received: by 2002:a05:6e02:104a:b0:368:8ab5:5926 with SMTP id
 p10-20020a056e02104a00b003688ab55926mr249478ilj.14.1711561157279; 
 Wed, 27 Mar 2024 10:39:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKUe8mZYkM8M8mtPHG1OIyuyZQvi/BjfhDQc8fVeTIVtAc6K6DDfez/eDR3cYAn8ATfNHfWg==
X-Received: by 2002:a05:6e02:104a:b0:368:8ab5:5926 with SMTP id
 p10-20020a056e02104a00b003688ab55926mr249462ilj.14.1711561157035; 
 Wed, 27 Mar 2024 10:39:17 -0700 (PDT)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 b1-20020a92db01000000b0036699bc65aesm3683073iln.26.2024.03.27.10.39.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 10:39:16 -0700 (PDT)
Date: Wed, 27 Mar 2024 11:39:15 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Vinayak Kale <vkale@nvidia.com>
Cc: <qemu-devel@nongnu.org>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <avihaih@nvidia.com>, <acurrid@nvidia.com>, <cjia@nvidia.com>,
 <zhiw@nvidia.com>, <targupta@nvidia.com>, <kvm@vger.kernel.org>
Subject: Re: [PATCH v3] vfio/pci: migration: Skip config space check for
 Vendor Specific Information in VSC during restore/load
Message-ID: <20240327113915.19f6256c.alex.williamson@redhat.com>
In-Reply-To: <20240322064210.1520394-1-vkale@nvidia.com>
References: <20240322064210.1520394-1-vkale@nvidia.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
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

On Fri, 22 Mar 2024 12:12:10 +0530
Vinayak Kale <vkale@nvidia.com> wrote:

> In case of migration, during restore operation, qemu checks config space of the
> pci device with the config space in the migration stream captured during save
> operation. In case of config space data mismatch, restore operation is failed.
> 
> config space check is done in function get_pci_config_device(). By default VSC
> (vendor-specific-capability) in config space is checked.
> 
> Due to qemu's config space check for VSC, live migration is broken across NVIDIA
> vGPU devices in situation where source and destination host driver is different.
> In this situation, Vendor Specific Information in VSC varies on the destination
> to ensure vGPU feature capabilities exposed to the guest driver are compatible
> with destination host.
> 
> If a vfio-pci device is migration capable and vfio-pci vendor driver is OK with
> volatile Vendor Specific Info in VSC then qemu should exempt config space check
> for Vendor Specific Info. It is vendor driver's responsibility to ensure that
> VSC is consistent across migration. Here consistency could mean that VSC format
> should be same on source and destination, however actual Vendor Specific Info
> may not be byte-to-byte identical.
> 
> This patch skips the check for Vendor Specific Information in VSC for VFIO-PCI
> device by clearing pdev->cmask[] offsets. Config space check is still enforced
> for 3 byte VSC header. If cmask[] is not set for an offset, then qemu skips
> config space check for that offset.
> 
> Signed-off-by: Vinayak Kale <vkale@nvidia.com>
> ---
> Version History
> v2->v3:
>     - Config space check skipped only for Vendor Specific Info in VSC, check is
>       still enforced for 3 byte VSC header.
>     - Updated commit description with live migration failure scenario.
> v1->v2:
>     - Limited scope of change to vfio-pci devices instead of all pci devices.
> 
>  hw/vfio/pci.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)


Acked-by: Alex Williamson <alex.williamson@redhat.com>

 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index d7fe06715c..1026cdba18 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2132,6 +2132,27 @@ static void vfio_check_af_flr(VFIOPCIDevice *vdev, uint8_t pos)
>      }
>  }
>  
> +static int vfio_add_vendor_specific_cap(VFIOPCIDevice *vdev, int pos,
> +                                        uint8_t size, Error **errp)
> +{
> +    PCIDevice *pdev = &vdev->pdev;
> +
> +    pos = pci_add_capability(pdev, PCI_CAP_ID_VNDR, pos, size, errp);
> +    if (pos < 0) {
> +        return pos;
> +    }
> +
> +    /*
> +     * Exempt config space check for Vendor Specific Information during restore/load.
> +     * Config space check is still enforced for 3 byte VSC header.
> +     */
> +    if (size > 3) {
> +        memset(pdev->cmask + pos + 3, 0, size - 3);
> +    }
> +
> +    return pos;
> +}
> +
>  static int vfio_add_std_cap(VFIOPCIDevice *vdev, uint8_t pos, Error **errp)
>  {
>      PCIDevice *pdev = &vdev->pdev;
> @@ -2199,6 +2220,9 @@ static int vfio_add_std_cap(VFIOPCIDevice *vdev, uint8_t pos, Error **errp)
>          vfio_check_af_flr(vdev, pos);
>          ret = pci_add_capability(pdev, cap_id, pos, size, errp);
>          break;
> +    case PCI_CAP_ID_VNDR:
> +        ret = vfio_add_vendor_specific_cap(vdev, pos, size, errp);
> +        break;
>      default:
>          ret = pci_add_capability(pdev, cap_id, pos, size, errp);
>          break;


