Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5851FCE8349
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 14:02:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svGxd-0000NX-TB; Mon, 30 Sep 2024 10:01:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1svGxb-0000Mp-Qz
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 10:01:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1svGxW-00058w-81
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 10:01:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727704864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0R6TqmoLl9GfAyCYAem3TbQrqMPOA5hJYkONmcy3DD0=;
 b=PDBZ7IUpMtK89wAqDmwZN5rHxRqbYs0nSWO7u5fC2G3cb/h/X/Kngp0+lj3khyxaG7p4Mu
 YQqjwcQ0fzsyEPbtWQF61pLAfXYpZxEIZQlXnK36HqOs2BpyuYr0Pjmt7BsNBDz/iT70Bs
 ICgxJgT4VDaCggSmJY3DwZFJbC6loaE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-ZYED2lTWN1eITk7wGPscQw-1; Mon, 30 Sep 2024 10:01:02 -0400
X-MC-Unique: ZYED2lTWN1eITk7wGPscQw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37ccbace251so2268079f8f.3
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 07:01:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727704862; x=1728309662;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0R6TqmoLl9GfAyCYAem3TbQrqMPOA5hJYkONmcy3DD0=;
 b=Y7jwCkmEYHmavRwddAmLsMAW/OLfYREV/wlnDXKbixh+YEfHicPxr0S5jDXN4qmXS8
 lCSXIT2kbTxc35wtNpKRO5jurc7MjOAPvUOvNzeg3QLXtH/fwvwpMDujUn7bLrjcjGqH
 TftrLv0V/h6BRf2A6ktjdYbaODSMtsFfJcc+AFPIqv7EGn4YGCg915MfASoc40txbMO/
 9k/rmEhk4P9ezhAfSbG2bIz5Xbc7Ts/gKdsqHW9iC84c+t+DP2YFomuWkFi9zUSVv7KQ
 iRY8v2MmNuw8Ya7+GM+zxuK5QnUAo4wbrLnhthcxNplZnPjIj/5kVBUGeOuDo3AgGdYt
 JMJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+5yohU+pdPZ5AaGDtrCJmdE91Hycd/Xyd5d6mep7Xs3lMPUdk6K43XcgvE7z+CLUkJuBY5sIqymhB@nongnu.org
X-Gm-Message-State: AOJu0Yz0BthiijXkyNdus7SYzER5gsdpBJ6dYRoCrj0HCdyvJ3u8D0Rj
 AmOxvi5vAGyNQ/gjVQ6Ynx3xW9ZNA7Y1JU6k3wR+apaMgnT1riywDmJ/utREy4ShVLf2CaCBY32
 Ne5elNJtjueTav5IwufdsxGx+Yr2b3JPyZARfYm9dqCGlTfRDRmAf
X-Received: by 2002:a5d:6882:0:b0:371:8319:4dbd with SMTP id
 ffacd0b85a97d-37cd5a77b2emr7005781f8f.17.1727704861701; 
 Mon, 30 Sep 2024 07:01:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoWs4iiZQRBJa1T11d371vKpdehtim/qm/4bBWR8JTskGpEI8aUjN8wzvzibTOgbagTw6wbA==
X-Received: by 2002:a5d:6882:0:b0:371:8319:4dbd with SMTP id
 ffacd0b85a97d-37cd5a77b2emr7005751f8f.17.1727704861132; 
 Mon, 30 Sep 2024 07:01:01 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:55d:ca3b:807c:fdd2:f46d:60e7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd575de8fsm9042266f8f.116.2024.09.30.07.00.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2024 07:01:00 -0700 (PDT)
Date: Mon, 30 Sep 2024 10:00:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Gao Shiyuan <gaoshiyuan@baidu.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, zuoboqun@baidu.com,
 thuth@redhat.com, alxndr@bu.edu, peterx@redhat.com,
 qemu-devel@nongnu.org, imammedo@redhat.com
Subject: Re: [PATCH 1/1] virtio-pci: fix memory_region_find for
 VirtIOPCIRegion's MR
Message-ID: <20240930100043-mutt-send-email-mst@kernel.org>
References: <20240924011156.48252-1-gaoshiyuan@baidu.com>
 <8d7b35ba-f9fa-446f-ac8b-471587c7666e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d7b35ba-f9fa-446f-ac8b-471587c7666e@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Sep 24, 2024 at 02:31:20PM +0200, David Hildenbrand wrote:
> On 24.09.24 03:11, Gao Shiyuan wrote:
> 
> Make sure to version your patch series. For example, via
> 	$ git format-patch -v1 ...
> 
> > As shown below, if a virtio PCI device is attached under a pci-bridge, the MR
> > of VirtIOPCIRegion does not belong to any address space. So memory_region_find
> > cannot be used to search for this MR.
> 
> I'm starting to wonder if memory_region_find() is really the right fun
> 
> > 
> > Introduce the virtio-pci and pci_bridge_pci address spaces to solve this problem.
> > 
> > Before:
> > memory-region: pci_bridge_pci
> >    0000000000000000-ffffffffffffffff (prio 0, i/o): pci_bridge_pci
> >      00000000fe200000-00000000fe200fff (prio 1, i/o): virtio-blk-pci-msix
> >        00000000fe200000-00000000fe20016f (prio 0, i/o): msix-table
> >        00000000fe200800-00000000fe200807 (prio 0, i/o): msix-pba
> >      000000a000400000-000000a000403fff (prio 1, i/o): virtio-pci
> >        000000a000400000-000000a000400fff (prio 0, i/o): virtio-pci-common-virtio-blk
> >        000000a000401000-000000a000401fff (prio 0, i/o): virtio-pci-isr-virtio-blk
> >        000000a000402000-000000a000402fff (prio 0, i/o): virtio-pci-device-virtio-blk
> >        000000a000403000-000000a000403fff (prio 0, i/o): virtio-pci-notify-virtio-blk
> > 
> > After:
> > address-space: pci_bridge_pci
> >    0000000000000000-ffffffffffffffff (prio 0, i/o): pci_bridge_pci
> >      00000000fe200000-00000000fe200fff (prio 1, i/o): virtio-blk-pci-msix
> >        00000000fe200000-00000000fe20016f (prio 0, i/o): msix-table
> >        00000000fe200800-00000000fe200807 (prio 0, i/o): msix-pba
> >      000000a000400000-000000a000403fff (prio 1, i/o): virtio-pci
> >        000000a000400000-000000a000400fff (prio 0, i/o): virtio-pci-common-virtio-blk
> >        000000a000401000-000000a000401fff (prio 0, i/o): virtio-pci-isr-virtio-blk
> >        000000a000402000-000000a000402fff (prio 0, i/o): virtio-pci-device-virtio-blk
> >        000000a000403000-000000a000403fff (prio 0, i/o): virtio-pci-notify-virtio-blk
> > 
> > address-space: virtio-pci
> >    000000a000400000-000000a000403fff (prio 1, i/o): virtio-pci
> >      000000a000400000-000000a000400fff (prio 0, i/o): virtio-pci-common-virtio-blk
> >      000000a000401000-000000a000401fff (prio 0, i/o): virtio-pci-isr-virtio-blk
> >      000000a000402000-000000a000402fff (prio 0, i/o): virtio-pci-device-virtio-blk
> >      000000a000403000-000000a000403fff (prio 0, i/o): virtio-pci-notify-virtio-blk
> > 
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2576
> > Fixes: ffa8a3e ("virtio-pci: Add lookup subregion of VirtIOPCIRegion MR")
> 
> Commit id is not unique. Use 12 digits please.
> 
> I'm still not quite sure if memory_region_find() is really the right thing
> to use here, but I'm no expert on that so I'm hoping virtio/PCI people can
> review.

I donnu, what would you use?


> -- 
> Cheers,
> 
> David / dhildenb


