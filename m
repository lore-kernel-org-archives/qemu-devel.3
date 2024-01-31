Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F7F7C47DB3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 17:39:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVEXd-000214-Oa; Wed, 31 Jan 2024 12:38:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1rVEXc-0001zM-BV
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 12:38:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1rVEXa-0005tv-15
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 12:38:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706722705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5VG77RDz0cW4LUAzq33da50yL9tzF0K638QOYN7jV7I=;
 b=IcBo+LY6NkXnlXUzS9D5EsQEKqyN62G8EuldzQJK9jP07ok8bHWvAf/FQlrdvbpJjNnMeS
 bK60WLsFTNM7lpW2tW0g/IIDxaAfjMXgSFnFSQgCQJWG0rmBq79l5N8CPmtCIJ23FAJBqo
 3xWB2KaRy/RDUUT5g/4eiuLxI8YzeAM=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-GDESXQEKP8m4XRHHfr4xdQ-1; Wed, 31 Jan 2024 12:38:22 -0500
X-MC-Unique: GDESXQEKP8m4XRHHfr4xdQ-1
Received: by mail-il1-f198.google.com with SMTP id
 e9e14a558f8ab-363887f15c1so279015ab.3
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 09:38:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706722702; x=1707327502;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5VG77RDz0cW4LUAzq33da50yL9tzF0K638QOYN7jV7I=;
 b=RrmdvdpR5FwVzX7PMyf6G/fUI+1zW2kB3GKFTxaVUwD+33qPelPj5a8K/+uv+cYlS9
 pWtT4vQEo9qkmlv/tI43eQMb1KaKqBNWqvyZxQl2j0ZUd9zyl7jfNfCl5byXLrJAoLmN
 7pi/K20vokoLRY7ACQCpiyYpe0a8dMSziRNrdr5uIQAkXHQqASU6/SXU2gVX/3tJSHma
 ThxBSMndszK9JSDzYNE7kArbt6Mtvj46RaPXEuTe9m5G6yY90QuXGpVHFVBL6J0eBDpH
 Vxw4X/GEZh1V3sGL/P1A7hnJ8OD21fe14wJ1mim/6L9cvIKdPDsTDfkiexk2m8XXICgg
 LW6Q==
X-Gm-Message-State: AOJu0Yxk/yIKkwYQ5qZVHyyqjfvOVCiWYdO9LW3EdvCR5og/bDBII/tt
 JpIqkgNnynMIrJFUQeAxSE8VjdBz/FFL9pYEOk0DuDpvnI1YASWE4BtkX/FO0J9FTeBDrznP5ry
 2YpiIafYVHiHks8+BqT6c/epf3n6u8j92DRU4MztQw2Y/5E+9b8Mw
X-Received: by 2002:a05:6e02:612:b0:363:821b:5096 with SMTP id
 t18-20020a056e02061200b00363821b5096mr2778825ils.6.1706722701881; 
 Wed, 31 Jan 2024 09:38:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGInXoFjcTs26NA5FNmNbnvXFTMuyEZk9AoZMklcz2dd+GQygSM2LkMPO8ij/2e8CS5omJpNg==
X-Received: by 2002:a05:6e02:612:b0:363:821b:5096 with SMTP id
 t18-20020a056e02061200b00363821b5096mr2778807ils.6.1706722701446; 
 Wed, 31 Jan 2024 09:38:21 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCV3zKBLFnhAin3guX/drPmFt3h46x4pzDnxaR6c4pySDz8bFRE+syb+WH9VQz7EYebdPa5Elm+oenMoAjT30xSEdcPoDWIsqHssShVynGgqrvqs2Ba3m3yA8wf3SD1xulsdhISpAUaSmlCFW64DhgMDdjD/ezyV2lVKnJIWLqqyrLFlpnl6eRELT35TM1V2GxhNgzikZpxtFHPTaQweQTcUb5gcOxoLCPDid9hk0HHiA6et/q2npAX1mA==
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 cr6-20020a056e023a8600b0036399332314sm487351ilb.76.2024.01.31.09.38.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jan 2024 09:38:20 -0800 (PST)
Date: Wed, 31 Jan 2024 10:38:17 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Vinayak Kale <vkale@nvidia.com>
Cc: qemu-devel@nongnu.org, targupta@nvidia.com, cjia@nvidia.com,
 acurrid@nvidia.com, zhiw@nvidia.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, avihaih@nvidia.com
Subject: Re: [PATCH] hw/pci: migration: Skip config space check for vendor
 specific capability during restore/load
Message-ID: <20240131103817.50389f39.alex.williamson@redhat.com>
In-Reply-To: <f6586fc8-d64c-4ff0-80ac-1eb18b5f486b@nvidia.com>
References: <20240130095617.31661-1-vkale@nvidia.com>
 <4d6a45ed-ca8d-4e41-b536-c2502ff1ce8b@nvidia.com>
 <20240130115832.462e76b7.alex.williamson@redhat.com>
 <f6586fc8-d64c-4ff0-80ac-1eb18b5f486b@nvidia.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
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

On Wed, 31 Jan 2024 15:22:59 +0530
Vinayak Kale <vkale@nvidia.com> wrote:

> On 31/01/24 12:28 am, Alex Williamson wrote:
> > 
> > On Tue, 30 Jan 2024 23:32:26 +0530
> > Vinayak Kale <vkale@nvidia.com> wrote:
> >   
> >> Missed adding Michael, Marcel, Alex and Avihai earlier, apologies.
> >>
> >> Regards,
> >> Vinayak
> >>
> >> On 30/01/24 3:26 pm, Vinayak Kale wrote:  
> >>> In case of migration, during restore operation, qemu checks the config space of the pci device with the config space
> >>> in the migration stream captured during save operation. In case of config space data mismatch, restore operation is failed.
> >>>
> >>> config space check is done in function get_pci_config_device(). By default VSC (vendor-specific-capability) in config space is checked.
> >>>
> >>> Ideally qemu should not check VSC during restore/load. This patch skips the check by not setting pdev->cmask[] for VSC offsets in pci_add_capability().
> >>> If cmask[] is not set for an offset, then qemu skips config space check for that offset.
> >>>
> >>> Signed-off-by: Vinayak Kale <vkale@nvidia.com>
> >>> ---
> >>>    hw/pci/pci.c | 7 +++++--
> >>>    1 file changed, 5 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> >>> index 76080af580..32429109df 100644
> >>> --- a/hw/pci/pci.c
> >>> +++ b/hw/pci/pci.c
> >>> @@ -2485,8 +2485,11 @@ int pci_add_capability(PCIDevice *pdev, uint8_t cap_id,
> >>>        memset(pdev->used + offset, 0xFF, QEMU_ALIGN_UP(size, 4));
> >>>        /* Make capability read-only by default */
> >>>        memset(pdev->wmask + offset, 0, size);
> >>> -    /* Check capability by default */
> >>> -    memset(pdev->cmask + offset, 0xFF, size);
> >>> +
> >>> +    if (cap_id != PCI_CAP_ID_VNDR) {
> >>> +        /* Check non-vendor specific capability by default */
> >>> +        memset(pdev->cmask + offset, 0xFF, size);
> >>> +    }
> >>>        return offset;
> >>>    }
> >>>  
> >>  
> > 
> > If there is a possibility that the data within the vendor specific cap
> > can be consumed by the driver or diagnostic tools, then it's part of
> > the device ABI and should be consistent across migration.  A mismatch
> > can certainly cause a migration failure, but why shouldn't it?  
> 
> Sure, the device ABI should be consistent across migration. In case of 
> VSC, it should represent same format on source and destination. But 
> shouldn't VSC content check or its interpretation be left to vendor 
> driver instead of qemu?

By "vendor driver" here, are you suggesting that QEMU device models (ex.
hw/net/{e1000*,igb*,rtl8139*}) should perform that validation?  If so,
where's the patch that introduces any sort of validation hooks for
vendors to provide?  Where is this validation going to happen in the
case of a migratable vfio-pci variant devices?  Nothing about this
patch suggests that it's deferring responsibility to some other code
entity, it only indicates "checking this breaks, let's not do it".

It's possible that the device you care about only reports volatile
diagnostic information through the vendor specific capability, but
another device might use it to report information relative to the
internal hardware configuration.  Without knowing what the vendor
specific capability contains, QEMU needs to take the most conservative
approach by default.  Thanks,

Alex


