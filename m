Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F37CC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 14:59:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmESA-0005aY-7x; Mon, 18 Mar 2024 10:59:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1rmES8-0005SU-5X
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 10:59:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1rmES0-0007ji-EY
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 10:59:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710773933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S5rXb9xskSAldFvBiaq7cgnCXNtAJE0ee8Udzzx+frU=;
 b=UQNFWBC5MSFk9HKIPyj83Xi+w6bOk/n1ngEhLvbzsj9P2WZJSLGEqg/mcif5qkg7LzhsEF
 OXvA42cDeWtfVdU/iH06ajgsZBQdVCw/M3bVkPYi4Ml05FUhp+AgwZOs7YN3qpUHfZj5oj
 y02KKwlv0l0eTzecbMEjiHDBxvOhe9g=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-sWOExKjoOYuNKD8zC9wRzg-1; Mon, 18 Mar 2024 10:58:51 -0400
X-MC-Unique: sWOExKjoOYuNKD8zC9wRzg-1
Received: by mail-il1-f198.google.com with SMTP id
 e9e14a558f8ab-3663022a5bdso50996165ab.3
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 07:58:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710773931; x=1711378731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S5rXb9xskSAldFvBiaq7cgnCXNtAJE0ee8Udzzx+frU=;
 b=aMAgwltecetYjQK4YXqRkN8JRwtHNajkIVdd3MQYT54XdkbZhugdx8P8bAVovZpMck
 1GGDEPNJkytL+KnkUyKbPsBzBTDsuo3zAjAhd2Y5r8UKTWdmag644Z/XwfgBGO/8blMx
 BGhHfCRGhbmfeFsTCSpkjRaVBOAEsBHCOx4qCdxlOpbJk6VRrkNvyXbMaSXZSHVav3zw
 jxhHlzhG4PAM/TJ6+2yowGlzOWFXgfjpDlve4CDJ9oM1wGkBDPGzhI/ZkaluQ+k+ECk2
 lBCckps/aPpGybBg6AvuO1nb7ujoTLTk7o6pHgwQJ6OaWpCuzNtajzj8hW6qYfZcCSxh
 Ndpg==
X-Gm-Message-State: AOJu0YxUmfuu4+RN/gZmTitQJD3bRvPml1Z8JQxsWoYNQ/2lFCh17tAm
 lqj9C6NWcAxyTQduNTQTgpXf9AMFLJQiZcz5tq+QpNCfpfqJSZxEWgPWbgt418mL59LIBLeifDb
 aXcTTkhTTxsBmWKDqXjOoSuf0qiUjX73t7Me0ygDdX7MHScFfPWtv
X-Received: by 2002:a92:d14c:0:b0:366:8ce0:6db with SMTP id
 t12-20020a92d14c000000b003668ce006dbmr10139628ilg.32.1710773931072; 
 Mon, 18 Mar 2024 07:58:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeJFZUt/ODouk/j4XHwc1OHH4vDt8B5VkLETdQd2fGKfXHAvefPy2DYLdrQT0ZUXWN0EnZeA==
X-Received: by 2002:a92:d14c:0:b0:366:8ce0:6db with SMTP id
 t12-20020a92d14c000000b003668ce006dbmr10139611ilg.32.1710773930732; 
 Mon, 18 Mar 2024 07:58:50 -0700 (PDT)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 s4-20020a02ad04000000b00476df803a46sm2354740jan.21.2024.03.18.07.58.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 07:58:50 -0700 (PDT)
Date: Mon, 18 Mar 2024 08:58:48 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Vinayak Kale <vkale@nvidia.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, marcel.apfelbaum@gmail.com,
 avihaih@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, zhiw@nvidia.com,
 targupta@nvidia.com, kvm@vger.kernel.org
Subject: Re: [PATCH v2] vfio/pci: migration: Skip config space check for
 vendor specific capability during restore/load
Message-ID: <20240318085848.32b34594.alex.williamson@redhat.com>
In-Reply-To: <7cab7d27-0ad2-4cb5-9757-a837a6fd13a9@nvidia.com>
References: <20240311121519.1481732-1-vkale@nvidia.com>
 <20240311090242.229b80ec.alex.williamson@redhat.com>
 <7cab7d27-0ad2-4cb5-9757-a837a6fd13a9@nvidia.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, 15 Mar 2024 23:22:22 +0530
Vinayak Kale <vkale@nvidia.com> wrote:

> On 11/03/24 8:32 pm, Alex Williamson wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Mon, 11 Mar 2024 17:45:19 +0530
> > Vinayak Kale <vkale@nvidia.com> wrote:
> >   
> >> In case of migration, during restore operation, qemu checks config space of the
> >> pci device with the config space in the migration stream captured during save
> >> operation. In case of config space data mismatch, restore operation is failed.
> >>
> >> config space check is done in function get_pci_config_device(). By default VSC
> >> (vendor-specific-capability) in config space is checked.
> >>
> >> Ideally qemu should not check VSC for VFIO-PCI device during restore/load as
> >> qemu is not aware of VSC ABI.  
> > 
> > It's disappointing that we can't seem to have a discussion about why
> > it's not the responsibility of the underlying migration support in the
> > vfio-pci variant driver to make the vendor specific capability
> > consistent across migration.  
> 
> I think it is device vendor driver's responsibility to ensure that VSC 
> is consistent across migration. Here consistency could mean that VSC 
> format should be same on source and destination, however actual VSC 
> contents may not be byte-to-byte identical.
> 
> If a vfio-pci device is migration capable and if vfio-pci vendor driver 
> is OK with volatile VSC contents as long as consistency is maintained 
> for VSC format then QEMU should exempt config space check for VSC contents.

I tend to agree that ultimately the variant driver is responsible for
making the device consistent during migration and QEMU's policy that
even vendor defined ABI needs to be byte for byte identical is somewhat
arbitrary.

> > Also, for future maintenance, specifically what device is currently
> > broken by this and under what conditions?  
> 
> Under certain conditions VSC contents vary for NVIDIA vGPU devices in 
> case of live migration. Due to QEMU's current config space check for 
> VSC, live migration is broken across NVIDIA vGPU devices.

This is incredibly vague.  We've been testing NVIDIA vGPU migration and
have not experienced a migration failure due to VSC mismatch.  Does this
require a specific device?  A specific workload?  What specific
conditions trigger this problem?

While as above, I agree in theory that the responsibility lies on the
migration support in the variant driver, there are risks involved,
particularly if new dependencies on the VSC contents are developed in
the guest.  For future maintenance and development in this space, the
commit log should describe exactly the scenario that requires this
policy change.  Thanks,

Alex

> >> This patch skips the check for VFIO-PCI device by clearing pdev->cmask[] for VSC
> >> offsets. If cmask[] is not set for an offset, then qemu skips config space check
> >> for that offset.
> >>
> >> Signed-off-by: Vinayak Kale <vkale@nvidia.com>
> >> ---
> >> Version History
> >> v1->v2:
> >>      - Limited scope of change to vfio-pci devices instead of all pci devices.
> >>
> >>   hw/vfio/pci.c | 19 +++++++++++++++++++
> >>   1 file changed, 19 insertions(+)
> >>
> >> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> >> index d7fe06715c..9edaff4b37 100644
> >> --- a/hw/vfio/pci.c
> >> +++ b/hw/vfio/pci.c
> >> @@ -2132,6 +2132,22 @@ static void vfio_check_af_flr(VFIOPCIDevice *vdev, uint8_t pos)
> >>       }
> >>   }
> >>
> >> +static int vfio_add_vendor_specific_cap(VFIOPCIDevice *vdev, int pos,
> >> +                                        uint8_t size, Error **errp)
> >> +{
> >> +    PCIDevice *pdev = &vdev->pdev;
> >> +
> >> +    pos = pci_add_capability(pdev, PCI_CAP_ID_VNDR, pos, size, errp);
> >> +    if (pos < 0) {
> >> +        return pos;
> >> +    }
> >> +
> >> +    /* Exempt config space check for VSC during restore/load  */
> >> +    memset(pdev->cmask + pos, 0, size);  
> > 
> > This excludes the entire capability from comparison, including the
> > capability ID, next pointer, and capability length.  Even if the
> > contents of the capability are considered volatile vendor information,
> > the header is spec defined ABI which must be consistent.  Thanks,  
> 
> This makes sense, I'll address this in V3. Thanks.
> 
> > 
> > Alex
> >   
> >> +
> >> +    return pos;
> >> +}
> >> +
> >>   static int vfio_add_std_cap(VFIOPCIDevice *vdev, uint8_t pos, Error **errp)
> >>   {
> >>       PCIDevice *pdev = &vdev->pdev;
> >> @@ -2199,6 +2215,9 @@ static int vfio_add_std_cap(VFIOPCIDevice *vdev, uint8_t pos, Error **errp)
> >>           vfio_check_af_flr(vdev, pos);
> >>           ret = pci_add_capability(pdev, cap_id, pos, size, errp);
> >>           break;
> >> +    case PCI_CAP_ID_VNDR:
> >> +        ret = vfio_add_vendor_specific_cap(vdev, pos, size, errp);
> >> +        break;
> >>       default:
> >>           ret = pci_add_capability(pdev, cap_id, pos, size, errp);
> >>           break;  
> >   
> 


