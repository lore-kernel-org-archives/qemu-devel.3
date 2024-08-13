Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A39FEC52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 21:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdyg2-0006x9-P9; Tue, 13 Aug 2024 17:03:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1sdyg1-0006w3-Cz
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 17:03:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1sdyfz-0004F9-LJ
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 17:03:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723583008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1UOf/e3HcQ+l94OWXrCwdSK3TbHtvFPHwqfrVahjAnI=;
 b=SJ7NNWGg9r61R9FrHICQCRxiywHL5iF6bsL3ISE6YmGZOR1UwVKsd9l2K+PuabKc+p0ldM
 qonZGyXx9qYu4NQAWuzaXs+VIVB1IFyDfG6ea0RKlM4U9eC/2OHktOUqTb/BT+Xk+z+TMS
 xzQ/M1VUtS1qMiZ4/qZt5DrlnwlkuVk=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-YNr-UckqNCiM6l3rzqK1FQ-1; Tue, 13 Aug 2024 17:03:24 -0400
X-MC-Unique: YNr-UckqNCiM6l3rzqK1FQ-1
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-81f87635cc1so738340839f.0
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 14:03:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723583004; x=1724187804;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1UOf/e3HcQ+l94OWXrCwdSK3TbHtvFPHwqfrVahjAnI=;
 b=DIu8iEvWUsgWUzXppPDMFI93HFKU8BpYs7PYRKXVNYYUuBL8t/86kU+fO9Txfnh2RQ
 ozawbwQFeS5pD5UDuk3LYVDNCu0MSLkmyEfhuPEzvFf6HhEbEbjSH2DYj+8BHhn+dLf8
 PBxHfmENbKzcBLie1mSxhNvFNHPua/l1h5NdyeWf+mUzmBjvq9q30YeqmMAa0tjhSajN
 59mlksSHmXxrgxn/xLvVbfGwc/DdrRexIShRatCNVbCAsESMh8Gm7Nh4gNezbFxvilKh
 P01/SlzhbUHpHrQgThsyD75Zp/FYxzcGx96NLEVY6PnA8xrerpoDTirUHQiuUCAOTDNJ
 StUw==
X-Gm-Message-State: AOJu0YyHfg4Z2satueb1G2W9yZ2KrH04fgtI0K7MNMaeP1zGq86iuDVo
 uRfiTUCXRX3ucj5/LKSLYTIcfi+JF4PbTmFcyBikSSbb92ZQU5bjlNnDNqrX/vjw4U4vnW1FYgv
 FzsEUs0rInVijrcOOolIccZcy8QFQFzm2j4SgXmR/u0haNDhzUxqW
X-Received: by 2002:a05:6602:14d2:b0:804:9972:2f8c with SMTP id
 ca18e2360f4ac-824dad04265mr122543339f.8.1723583003652; 
 Tue, 13 Aug 2024 14:03:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUG+Ra/4MLDKrpbcdWTsiFMgCKM25UlSCbFVfALG5nTggblaB3Mjb05rv1rYcf1nGj/+3LVA==
X-Received: by 2002:a05:6602:14d2:b0:804:9972:2f8c with SMTP id
 ca18e2360f4ac-824dad04265mr122539339f.8.1723583003274; 
 Tue, 13 Aug 2024 14:03:23 -0700 (PDT)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ca76910393sm2733107173.7.2024.08.13.14.03.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 14:03:22 -0700 (PDT)
Date: Tue, 13 Aug 2024 15:03:20 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, quic_bqiang@quicinc.com,
 kvalo@kernel.org, prestwoj@gmail.com, linux-wireless@vger.kernel.org,
 ath11k@lists.infradead.org, dwmw2@infradead.org, iommu@lists.linux.dev,
 kernel@quicinc.com, johannes@sipsolutions.net, jtornosm@redhat.com
Subject: Re: [PATCH RFC/RFT] vfio/pci-quirks: Quirk for ath wireless
Message-ID: <20240813150320.73df43d7.alex.williamson@redhat.com>
In-Reply-To: <20240813164341.GL1985367@ziepe.ca>
References: <adcb785e-4dc7-4c4a-b341-d53b72e13467@gmail.com>
 <20240812170045.1584000-1-alex.williamson@redhat.com>
 <20240813164341.GL1985367@ziepe.ca>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
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

On Tue, 13 Aug 2024 13:43:41 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Mon, Aug 12, 2024 at 11:00:40AM -0600, Alex Williamson wrote:
> > These devices have an embedded interrupt controller which is programmed
> > with guest physical MSI address/data, which doesn't work.  We need
> > vfio-pci kernel support to provide a device feature which disables
> > virtualization of the MSI capability registers.  Then we can do brute
> > force testing for writes matching the MSI address, from which we can
> > infer writes of the MSI data, replacing each with host physical values.
> > 
> > This has only been tested on ath11k (0x1103), ath12k support is
> > speculative and requires testing.  Note that Windows guest drivers make
> > use of multi-vector MSI which requires interrupt remapping support in
> > the host.  
> 
> The way it is really supposed to work, is that the guest itself
> controls/knows the MSI addr/data pairs and the interrupt remapping HW
> makes that delegation safe since all the interrupt processing will be
> qualified by the RID.
> 
> Then the guest can make up the unique interrupts for MSI and any
> internal "IMS" sources and we just let the guest directly write the
> MSI/MSI-X and any IMS values however it wants.
> 
> This hackery to capture and substitute the IMS programming is neat and
> will solve this one device, but there are more IMS style devices in
> the pipeline than will really need a full solution.

How does the guest know to write a remappable vector format?  How does
the guest know the host interrupt architecture?  For example why would
an aarch64 guest program an MSI vector of 0xfee... if the host is x86?

The idea of guest owning the physical MSI address space sounds great,
but is it practical?  Is it something that would be accomplished while
this device is still relevant?

> > + * The Windows driver makes use of multi-vector MSI, where our sanity test
> > + * of the MSI data value must then mask off the vector offset for comparison
> > + * and add it back to the host base data value on write.  
> 
> But is that really enough? If the vector offset is newly created then
> that means the VM built a new interrupt that needs setup to be routed
> into the VM?? Is that why you say it "requires interrupt remapping
> support" because that setup is happening implicitly on x86?
> 
> It looks like Windows is acting as I said Linux should, with a
> "irq_chip" and so on to get the unique interrupt source a proper
> unique addr/data pair...

The Windows driver is just programming the MSI capability to use 16
vectors.  We configure those vectors on the host at the time the
capability is written.  Whereas the Linux driver is only using a single
vector and therefore writing the same MSI address and data at the
locations noted in the trace, the Windows driver is writing different
data values at different locations to make use of those vectors.  This
note is simply describing that we can't directly write the physical
data value into the device, we need to determine which vector offset
the guest is using and provide the same offset from the host data
register value.

I don't know that interrupt remapping is specifically required, but the
MSI domain needs to support MSI_FLAG_MULTI_PCI_MSI and AFAIK that's
only available with interrupt remapping on x86, ie.
pci_alloc_irq_vectors() with max_vecs >1 and PCI_IRQ_MSI flags needs to
work on the host to mirror the guest MSI configuration.  Thanks,

Alex


