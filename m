Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C0FEC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 20:13:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpZdC-0002sH-WD; Wed, 27 Mar 2024 16:12:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rpZdB-0002rv-5f
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 16:12:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rpZd9-0005mw-DN
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 16:12:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711570333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6nBIaDcT7LUUT5QTvJ9cu4LaeUEx2trqi0MtGL39LRI=;
 b=Vy1LTToJ3ttu0YhS/EYzdo3nRdufow5ZnOmUFnnSVzqEAODjc+Azhni99bUr/GBbIF8y8c
 2H1tnEuF34hKbraFHtHObwLYJVGaOCINwCW013hKzGipCTVYu2oCzGBrLUnx7B6U15iow3
 0LKVR1XAKqu+X4GkLDwwPQjAR04uBCs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-4yK28twIPFKXWlKBjBs0mA-1; Wed, 27 Mar 2024 16:12:12 -0400
X-MC-Unique: 4yK28twIPFKXWlKBjBs0mA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-33ed489edcaso72266f8f.3
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 13:12:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711570330; x=1712175130;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6nBIaDcT7LUUT5QTvJ9cu4LaeUEx2trqi0MtGL39LRI=;
 b=H8C+uGjQg6UgyRo3tZtQHej2vjEG5bNzvpWdyGo6l7iN0sjQnP6Iqjn/arHeVaJeUq
 Dlq0IXxbkzb3PqF2GhihJUphLSMRjZgFghoEzmv4I5CRxPo/t8GZIpgvKUuLcvhRC4jr
 94irCf3uDQIMmBLV6eji5vXIyo2Y22QNuZrl2/IeNaHsZe3LGfp/jngdMmaYK0Oj3XF3
 lruSCNCnQlmUYw2ggi+SIj0eD9sEDJGkoJnSIe68F/YsGi6s0yW/Eic691Jdz/UdILJ5
 oAhxrHf1p5FTQgCOlym2Rby30CuxrkajP0S/fEoRk9DHvn6+oDDY5CHykGJB5YgywUr0
 Vh4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSAzz5S7pdEzpsCTh2tPoaCY8YGCuEnSn13H6HxKtC/XXP+nWcjkI3skWEeTaMlaVUxXT8R9lVJ7lNiObLhjDD640PnDM=
X-Gm-Message-State: AOJu0YzN4f0aZw+292VfUVBeZkW51WcjGuM64uTE0iHN75F3IpX5sg4s
 sifKmlyRxZMIT8xRPhjNHFDkHZL97dDreg7ItvkY5VQ6xROTS4mAep1jbNHVIMUZ2zXXCc5AKo4
 Fd+/KIM8aLLTmtEhNWZqzZ1cFjDhWHg7sPxmut5Cs4DzpAm4OIriJ
X-Received: by 2002:adf:e291:0:b0:341:7864:a6e3 with SMTP id
 v17-20020adfe291000000b003417864a6e3mr777060wri.2.1711570330554; 
 Wed, 27 Mar 2024 13:12:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqOS1B1IYng0wFCMRvLflHI1VywgJiHL9VKUdTX+xl14v3YTdbY3pG7wS/MfQqo6cdyUV+Dw==
X-Received: by 2002:adf:e291:0:b0:341:7864:a6e3 with SMTP id
 v17-20020adfe291000000b003417864a6e3mr777039wri.2.1711570329984; 
 Wed, 27 Mar 2024 13:12:09 -0700 (PDT)
Received: from redhat.com ([2.52.20.36]) by smtp.gmail.com with ESMTPSA id
 en9-20020a056000420900b00341b451a31asm9531152wrb.36.2024.03.27.13.12.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 13:12:09 -0700 (PDT)
Date: Wed, 27 Mar 2024 16:11:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Vinayak Kale <vkale@nvidia.com>, qemu-devel@nongnu.org,
 marcel.apfelbaum@gmail.com, avihaih@nvidia.com, acurrid@nvidia.com,
 cjia@nvidia.com, zhiw@nvidia.com, targupta@nvidia.com, kvm@vger.kernel.org
Subject: Re: [PATCH v3] vfio/pci: migration: Skip config space check for
 Vendor Specific Information in VSC during restore/load
Message-ID: <20240327161108-mutt-send-email-mst@kernel.org>
References: <20240322064210.1520394-1-vkale@nvidia.com>
 <20240327113915.19f6256c.alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327113915.19f6256c.alex.williamson@redhat.com>
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

On Wed, Mar 27, 2024 at 11:39:15AM -0600, Alex Williamson wrote:
> On Fri, 22 Mar 2024 12:12:10 +0530
> Vinayak Kale <vkale@nvidia.com> wrote:
> 
> > In case of migration, during restore operation, qemu checks config space of the
> > pci device with the config space in the migration stream captured during save
> > operation. In case of config space data mismatch, restore operation is failed.
> > 
> > config space check is done in function get_pci_config_device(). By default VSC
> > (vendor-specific-capability) in config space is checked.
> > 
> > Due to qemu's config space check for VSC, live migration is broken across NVIDIA
> > vGPU devices in situation where source and destination host driver is different.
> > In this situation, Vendor Specific Information in VSC varies on the destination
> > to ensure vGPU feature capabilities exposed to the guest driver are compatible
> > with destination host.
> > 
> > If a vfio-pci device is migration capable and vfio-pci vendor driver is OK with
> > volatile Vendor Specific Info in VSC then qemu should exempt config space check
> > for Vendor Specific Info. It is vendor driver's responsibility to ensure that
> > VSC is consistent across migration. Here consistency could mean that VSC format
> > should be same on source and destination, however actual Vendor Specific Info
> > may not be byte-to-byte identical.
> > 
> > This patch skips the check for Vendor Specific Information in VSC for VFIO-PCI
> > device by clearing pdev->cmask[] offsets. Config space check is still enforced
> > for 3 byte VSC header. If cmask[] is not set for an offset, then qemu skips
> > config space check for that offset.
> > 
> > Signed-off-by: Vinayak Kale <vkale@nvidia.com>
> > ---
> > Version History
> > v2->v3:
> >     - Config space check skipped only for Vendor Specific Info in VSC, check is
> >       still enforced for 3 byte VSC header.
> >     - Updated commit description with live migration failure scenario.
> > v1->v2:
> >     - Limited scope of change to vfio-pci devices instead of all pci devices.
> > 
> >  hw/vfio/pci.c | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> 
> 
> Acked-by: Alex Williamson <alex.williamson@redhat.com>


A very reasonable way to do it.

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Merge through the VFIO tree I presume?


>  
> > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> > index d7fe06715c..1026cdba18 100644
> > --- a/hw/vfio/pci.c
> > +++ b/hw/vfio/pci.c
> > @@ -2132,6 +2132,27 @@ static void vfio_check_af_flr(VFIOPCIDevice *vdev, uint8_t pos)
> >      }
> >  }
> >  
> > +static int vfio_add_vendor_specific_cap(VFIOPCIDevice *vdev, int pos,
> > +                                        uint8_t size, Error **errp)
> > +{
> > +    PCIDevice *pdev = &vdev->pdev;
> > +
> > +    pos = pci_add_capability(pdev, PCI_CAP_ID_VNDR, pos, size, errp);
> > +    if (pos < 0) {
> > +        return pos;
> > +    }
> > +
> > +    /*
> > +     * Exempt config space check for Vendor Specific Information during restore/load.
> > +     * Config space check is still enforced for 3 byte VSC header.
> > +     */
> > +    if (size > 3) {
> > +        memset(pdev->cmask + pos + 3, 0, size - 3);
> > +    }
> > +
> > +    return pos;
> > +}
> > +
> >  static int vfio_add_std_cap(VFIOPCIDevice *vdev, uint8_t pos, Error **errp)
> >  {
> >      PCIDevice *pdev = &vdev->pdev;
> > @@ -2199,6 +2220,9 @@ static int vfio_add_std_cap(VFIOPCIDevice *vdev, uint8_t pos, Error **errp)
> >          vfio_check_af_flr(vdev, pos);
> >          ret = pci_add_capability(pdev, cap_id, pos, size, errp);
> >          break;
> > +    case PCI_CAP_ID_VNDR:
> > +        ret = vfio_add_vendor_specific_cap(vdev, pos, size, errp);
> > +        break;
> >      default:
> >          ret = pci_add_capability(pdev, cap_id, pos, size, errp);
> >          break;


