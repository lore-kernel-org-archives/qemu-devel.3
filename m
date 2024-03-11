Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4396C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 15:03:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjhBG-0004WM-WB; Mon, 11 Mar 2024 11:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1rjhB6-0004Vt-0c
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 11:03:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1rjhB4-0007xK-Bi
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 11:02:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710169376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P3k4Q7Tm466fEItdGrwmYPATdJiQXiuGrp52WUVmVRY=;
 b=HwAZp7SWdcfWEq7xMw5/ZwMlIltJm4dJdULGaMXC1hSyZdv8xZSHgEfo2uzvPZ7P93jYzm
 ep6vGpYRk9jISdu4gU478NMIoQHlKR5Rw0i2vJVILE7nyExGLwTLBL30jqBzWO4qpxP0tF
 rrnxceJRJtS0/vA6bXIuWbtCVmm46TY=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-IwT7PyYHMcqg9znhkYOHrw-1; Mon, 11 Mar 2024 11:02:44 -0400
X-MC-Unique: IwT7PyYHMcqg9znhkYOHrw-1
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-7c8ab56c88cso135659339f.1
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 08:02:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710169364; x=1710774164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P3k4Q7Tm466fEItdGrwmYPATdJiQXiuGrp52WUVmVRY=;
 b=o7BM/svzOlDDBwMXGeOcfbdZ4d8vREj9zLtJ3jgHArJpK5/JfuS3dXZy3N6HGPLFaB
 gSS6HCIEn6AuGV9HWgI0j3JE9DJzJgCtqwz1DABzpkF1xmlhslCZ+MFgRSqQe34oDbpV
 y3ow2ZXIotl1XkPEYHmgfG3X21+GeAKMh8yfEuwQsAQViAb6MNooHWv8tloKOyhC7e82
 /SuUtf+HDuv5ndhZVqPvq1GOLGfZpdV3iPrwW4cHNANNJmDqE+ervoKC7D05dwAr3rZG
 aESSeUQdHFulm00FWTuIm5j+e5Si3YPx+MuHTXllMo6zAUOAWUyONa5/Wg43DxWbBjy7
 0W4w==
X-Gm-Message-State: AOJu0YwS5bOnZcN4NbYhuyx2rE24Ikz9yyt6TzwGIEVe+2XlJSFQMUiU
 M4z1CErdGdVimmJPqDMFyHoZSfE1dmxQjpjhQ529Z7im0sB6FBIKF7+6G74MW7eXKFsaei3FoiW
 lV53oMe/e3mfJGQ6uIAqwPPPyFEiLAPChcs9WGyIkeV9hTm5CTDva
X-Received: by 2002:a05:6e02:1808:b0:366:3686:5356 with SMTP id
 a8-20020a056e02180800b0036636865356mr9315833ilv.5.1710169364056; 
 Mon, 11 Mar 2024 08:02:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFinSAzKcScCZNQtVdABTq4pR7MYQjZQekD0tQNEa3ddytF0vBXhjuvG3HxHH4HlCFQNBYCKQ==
X-Received: by 2002:a05:6e02:1808:b0:366:3686:5356 with SMTP id
 a8-20020a056e02180800b0036636865356mr9315785ilv.5.1710169363628; 
 Mon, 11 Mar 2024 08:02:43 -0700 (PDT)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 b22-20020a026f56000000b00474782f85d3sm1756018jae.94.2024.03.11.08.02.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 08:02:43 -0700 (PDT)
Date: Mon, 11 Mar 2024 09:02:42 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Vinayak Kale <vkale@nvidia.com>
Cc: <qemu-devel@nongnu.org>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <avihaih@nvidia.com>, <acurrid@nvidia.com>, <cjia@nvidia.com>,
 <zhiw@nvidia.com>, <targupta@nvidia.com>, <kvm@vger.kernel.org>
Subject: Re: [PATCH v2] vfio/pci: migration: Skip config space check for
 vendor specific capability during restore/load
Message-ID: <20240311090242.229b80ec.alex.williamson@redhat.com>
In-Reply-To: <20240311121519.1481732-1-vkale@nvidia.com>
References: <20240311121519.1481732-1-vkale@nvidia.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
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

On Mon, 11 Mar 2024 17:45:19 +0530
Vinayak Kale <vkale@nvidia.com> wrote:

> In case of migration, during restore operation, qemu checks config space of the
> pci device with the config space in the migration stream captured during save
> operation. In case of config space data mismatch, restore operation is failed.
> 
> config space check is done in function get_pci_config_device(). By default VSC
> (vendor-specific-capability) in config space is checked.
> 
> Ideally qemu should not check VSC for VFIO-PCI device during restore/load as
> qemu is not aware of VSC ABI.

It's disappointing that we can't seem to have a discussion about why
it's not the responsibility of the underlying migration support in the
vfio-pci variant driver to make the vendor specific capability
consistent across migration.

Also, for future maintenance, specifically what device is currently
broken by this and under what conditions?

> 
> This patch skips the check for VFIO-PCI device by clearing pdev->cmask[] for VSC
> offsets. If cmask[] is not set for an offset, then qemu skips config space check
> for that offset.
> 
> Signed-off-by: Vinayak Kale <vkale@nvidia.com>
> ---
> Version History
> v1->v2:
>     - Limited scope of change to vfio-pci devices instead of all pci devices.
> 
>  hw/vfio/pci.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index d7fe06715c..9edaff4b37 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2132,6 +2132,22 @@ static void vfio_check_af_flr(VFIOPCIDevice *vdev, uint8_t pos)
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
> +    /* Exempt config space check for VSC during restore/load  */
> +    memset(pdev->cmask + pos, 0, size);

This excludes the entire capability from comparison, including the
capability ID, next pointer, and capability length.  Even if the
contents of the capability are considered volatile vendor information,
the header is spec defined ABI which must be consistent.  Thanks,

Alex

> +
> +    return pos;
> +}
> +
>  static int vfio_add_std_cap(VFIOPCIDevice *vdev, uint8_t pos, Error **errp)
>  {
>      PCIDevice *pdev = &vdev->pdev;
> @@ -2199,6 +2215,9 @@ static int vfio_add_std_cap(VFIOPCIDevice *vdev, uint8_t pos, Error **errp)
>          vfio_check_af_flr(vdev, pos);
>          ret = pci_add_capability(pdev, cap_id, pos, size, errp);
>          break;
> +    case PCI_CAP_ID_VNDR:
> +        ret = vfio_add_vendor_specific_cap(vdev, pos, size, errp);
> +        break;
>      default:
>          ret = pci_add_capability(pdev, cap_id, pos, size, errp);
>          break;


