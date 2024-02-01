Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3B7CC48286
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 18:11:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVbWu-0007wy-NS; Thu, 01 Feb 2024 13:11:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rVbWd-0007jw-RT
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 13:11:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rVbWc-0004ib-6G
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 13:10:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706811056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QBtsNxfjToCJgku9M0o1CZBRph+k70QzJazi1d9g63E=;
 b=eopvCC7yzWsJ0FTXo8z6/bvfMHLkBkGZuEcIJf91aLJMhB0syPPR0NAi6tMcOTBopEgpra
 R8rX2PFPOsnMOIjexGIOV5/bFTu14ADQVExurSyD8voY0jEGWK8GXAekdwdK7GNFX0qi8i
 V3VEFJq1oQb5jTQMplEUaaddAZr1edY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-xBboTEuDOWq5RzdsuCU7Fw-1; Thu, 01 Feb 2024 13:10:54 -0500
X-MC-Unique: xBboTEuDOWq5RzdsuCU7Fw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40fa6610ddfso7170225e9.3
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 10:10:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706811053; x=1707415853;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QBtsNxfjToCJgku9M0o1CZBRph+k70QzJazi1d9g63E=;
 b=L6MdGYmeRIPk5/KSlgUBKcVk+kkdGl3T2kuSnYzUY92+rn8On1Y9vJNzaiqEedWKmJ
 jCpqXrzVoMBHihfudI/ituqnyEowpGGDO7/RmIFwjcsTDp7KCFKuofpe7kccMdq8FKY5
 Mdi6ckaX6aikuG7bHjRCT7Y351/hROYL/PusrSeQN3upeLNbSYF1FKsTt+4cDIWV07ZY
 /5GNHdJ2KaCMzya+JIj6PmWs6erQwhHGNcy59cIwqCj0GbB7HvMyklJAIADVU/VWVNNi
 RfnnsF1hZ3wHgvC5BlXYB4oj7EQmRAJWiolr5AxWXC7GbT+IooK0QAV1Gge76n4tVKIL
 pBtg==
X-Gm-Message-State: AOJu0YwUes3UQ373mbQKlemOF09XycTRYNZYqIyPaKPZdX+fut1kz/su
 ZQCiCDvXfuIuLRcgOgZsvcHQwqxFo7ZqIordxbK6plzu5fFgQp/tjflWVldG/NiuPjxYOAf+x+8
 uRAwrnBGkG+6tTxpe3t7iilOTnblZaY5Pt63n88jv1xWQr2z9eoJX
X-Received: by 2002:a05:600c:1c86:b0:40f:aff2:7e49 with SMTP id
 k6-20020a05600c1c8600b0040faff27e49mr4047226wms.33.1706811053526; 
 Thu, 01 Feb 2024 10:10:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGavA2yzL3ahg2yRsgf+LjSB4VhXhm/l2zWvQHjzyeHhn+YEMEPhyU5JxoCSkhrOttAD35xvQ==
X-Received: by 2002:a05:600c:1c86:b0:40f:aff2:7e49 with SMTP id
 k6-20020a05600c1c8600b0040faff27e49mr4047210wms.33.1706811053091; 
 Thu, 01 Feb 2024 10:10:53 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUUO25MilArYtNCRhD3dj3qZKsFCHKjPO92Yp8+rg2XXW2kvpgpQIdRPTTJLViPiMQjQ3E4q+xbZjNU5T5w45G4cscpytsGeG6te0VLhN+rqLuc3NzIyQJ34k0AHFtgP7Dl426bIlqVig2JXX27G8EyHUdPz2tucepraf0zjL5NM0Nni9bGrjbyDcFaL1WdUWTvTZyYM7wq1/Sf5ihn3ndktj4Uh9r8XN12GU43CNHvJviUsnX0Fz+JgmdhxsXO448=
Received: from redhat.com ([2a02:14f:177:e335:fd41:fb43:f004:3de8])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a05600c19d200b0040fbc9a3405sm2340989wmq.0.2024.02.01.10.10.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 10:10:52 -0800 (PST)
Date: Thu, 1 Feb 2024 13:10:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vinayak Kale <vkale@nvidia.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org,
 targupta@nvidia.com, cjia@nvidia.com, acurrid@nvidia.com,
 zhiw@nvidia.com, marcel.apfelbaum@gmail.com, avihaih@nvidia.com
Subject: Re: [PATCH] hw/pci: migration: Skip config space check for vendor
 specific capability during restore/load
Message-ID: <20240201130440-mutt-send-email-mst@kernel.org>
References: <20240130095617.31661-1-vkale@nvidia.com>
 <4d6a45ed-ca8d-4e41-b536-c2502ff1ce8b@nvidia.com>
 <20240130115832.462e76b7.alex.williamson@redhat.com>
 <f6586fc8-d64c-4ff0-80ac-1eb18b5f486b@nvidia.com>
 <20240131103817.50389f39.alex.williamson@redhat.com>
 <b83a9452-cbcc-4f4d-b0f7-b4957029e755@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b83a9452-cbcc-4f4d-b0f7-b4957029e755@nvidia.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Feb 01, 2024 at 11:08:58PM +0530, Vinayak Kale wrote:
> 
> On 31/01/24 11:08 pm, Alex Williamson wrote:
> > 
> > On Wed, 31 Jan 2024 15:22:59 +0530
> > Vinayak Kale <vkale@nvidia.com> wrote:
> > 
> > > On 31/01/24 12:28 am, Alex Williamson wrote:
> > > > 
> > > > On Tue, 30 Jan 2024 23:32:26 +0530
> > > > Vinayak Kale <vkale@nvidia.com> wrote:
> > > > 
> > > > > Missed adding Michael, Marcel, Alex and Avihai earlier, apologies.
> > > > > 
> > > > > Regards,
> > > > > Vinayak
> > > > > 
> > > > > On 30/01/24 3:26 pm, Vinayak Kale wrote:
> > > > > > In case of migration, during restore operation, qemu checks the config space of the pci device with the config space
> > > > > > in the migration stream captured during save operation. In case of config space data mismatch, restore operation is failed.
> > > > > > 
> > > > > > config space check is done in function get_pci_config_device(). By default VSC (vendor-specific-capability) in config space is checked.
> > > > > > 
> > > > > > Ideally qemu should not check VSC during restore/load. This patch skips the check by not setting pdev->cmask[] for VSC offsets in pci_add_capability().
> > > > > > If cmask[] is not set for an offset, then qemu skips config space check for that offset.
> > > > > > 
> > > > > > Signed-off-by: Vinayak Kale <vkale@nvidia.com>
> > > > > > ---
> > > > > >     hw/pci/pci.c | 7 +++++--
> > > > > >     1 file changed, 5 insertions(+), 2 deletions(-)
> > > > > > 
> > > > > > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > > > > > index 76080af580..32429109df 100644
> > > > > > --- a/hw/pci/pci.c
> > > > > > +++ b/hw/pci/pci.c
> > > > > > @@ -2485,8 +2485,11 @@ int pci_add_capability(PCIDevice *pdev, uint8_t cap_id,
> > > > > >         memset(pdev->used + offset, 0xFF, QEMU_ALIGN_UP(size, 4));
> > > > > >         /* Make capability read-only by default */
> > > > > >         memset(pdev->wmask + offset, 0, size);
> > > > > > -    /* Check capability by default */
> > > > > > -    memset(pdev->cmask + offset, 0xFF, size);
> > > > > > +
> > > > > > +    if (cap_id != PCI_CAP_ID_VNDR) {
> > > > > > +        /* Check non-vendor specific capability by default */
> > > > > > +        memset(pdev->cmask + offset, 0xFF, size);
> > > > > > +    }
> > > > > >         return offset;
> > > > > >     }
> > > > > > 
> > > > > 
> > > > 
> > > > If there is a possibility that the data within the vendor specific cap
> > > > can be consumed by the driver or diagnostic tools, then it's part of
> > > > the device ABI and should be consistent across migration.  A mismatch
> > > > can certainly cause a migration failure, but why shouldn't it?
> > > 
> > > Sure, the device ABI should be consistent across migration. In case of
> > > VSC, it should represent same format on source and destination. But
> > > shouldn't VSC content check or its interpretation be left to vendor
> > > driver instead of qemu?
> > 
> > By "vendor driver" here, are you suggesting that QEMU device models (ex.
> > hw/net/{e1000*,igb*,rtl8139*}) should perform that validation?  If so,
> > where's the patch that introduces any sort of validation hooks for
> > vendors to provide?  Where is this validation going to happen in the
> > case of a migratable vfio-pci variant devices?  Nothing about this
> > patch suggests that it's deferring responsibility to some other code
> > entity, it only indicates "checking this breaks, let's not do it".
> > 
> > It's possible that the device you care about only reports volatile
> > diagnostic information through the vendor specific capability, but
> > another device might use it to report information relative to the
> > internal hardware configuration.  Without knowing what the vendor
> > specific capability contains, QEMU needs to take the most conservative
> > approach by default.  Thanks,
> 
> PCI/PCIe spec doesn’t define ABI for VSC/VSEC contents. Any other code
> entity except vendor driver should ignore VSC contents. QEMU’s expectation
> of VSC contents to be equal on source and destination seems incorrect given
> that QEMU has no control over ABI for VSC contents.
> 
> > 
> > Alex
> > 

I don't get why this matters though. This is no different from any other
device specific register. If a register is visible to guest it generally
should not change across migration. If you are migrating a VFIO device and
you are making a vsc visible to guest then your migration routine must
make sure to migrate the contents of vsc.

Maybe there's a good reason to have a register which actually does
change. Then, please document the actual reason. When you say:

	 Ideally qemu should not check VSC during restore/load.

then that is clearly wrong in most cases.


-- 
MST


