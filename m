Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E70BC0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 15:19:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbLSd-0005Cq-CO; Fri, 24 Jan 2025 10:19:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tbLSb-0005CZ-9z
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 10:19:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tbLSY-0001le-AN
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 10:19:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737731939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OsMQPL/gWkWPciz0VlEFqI7jRtb8Lvnrd2rOeY9ldYs=;
 b=ghBRo30Ss+RhB3WfLid5+sGeSX2/9+xeEbj4JcCrS1if+LT3h1gWoPg9Xjl4+b/6O8HhxY
 TetWsYW6oy3cpQXDeAynwSjgugJft61rGKVJS6UzMdP3TPVsF8UHzeabS8Xv9AOX7AUtK1
 7+dr78rKF7EogwR+c1k0+LKzTBbidF0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-sCiAa79hNpaRSmn30ERrVA-1; Fri, 24 Jan 2025 10:18:58 -0500
X-MC-Unique: sCiAa79hNpaRSmn30ERrVA-1
X-Mimecast-MFC-AGG-ID: sCiAa79hNpaRSmn30ERrVA
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7b6eabd51cfso335546085a.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 07:18:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737731937; x=1738336737;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OsMQPL/gWkWPciz0VlEFqI7jRtb8Lvnrd2rOeY9ldYs=;
 b=tAhc00ZvJ+2H8AGuJ9U4f/URO1FPNATgpBHY1hEm3bWPsGYSBCWgSVFVlaupF2q1sp
 a08irUanF2M9i8YCHRMuTOqCw2sn+tNS6WV9JUc/Rmi24BdErXIuVmkMqZJuB+Y5/DK+
 U1gUnV/v68Q0mU4cpUKgS35O8FX1nqQNBG8s7xMZ1zX8yBJM7DvAJ+6cJEFacBX28hd8
 6yANvtwdnHhPwJp6fuBX2+jgNjLbaW6kdJQDRQf8F6mz7MYrBQMg5q+blc4BVyschG4m
 ZPHnjrFBW4RaVbYRfOJCWAq2ULie/7fXcF4CXipwCApFdRM2yrcEvesUdPocLMBuEMas
 ZXGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGo2vqHhbMefN8wfkRa8HhJucsaNvRZxkQSCnHvtndCbyjeBMp0VKanaaF0jgEjwR0S+uyqt0UoEBp@nongnu.org
X-Gm-Message-State: AOJu0YzE/L2xv8YOm4QXp6MiEWKWmu8jR1qyqvcdtNcd/ldPMHWI+ZpJ
 +KdcSwQyz4lxWcmswlRSXjHDjGCRJT7znQXsJ3jeZnckDbGoTd1F4jPZDI5xcnZuuV9Fwgw0GUZ
 6Cs1nBvd+icukl1EoiyCZ5qr4ZcvZ/1oIcD+hcnJQMOHMRiJ5Ts7l
X-Gm-Gg: ASbGncv0LaJuNFjs3L+qhF98J1EE3C9A1oZNcPdr1Wl97rG56SbGl8JGgNJG47tQm5M
 QfdWKRM//ZdI0llriqSW2i+ALghrZELQzvDdB1LXfSJAy5gewhTw20Whzw5Y1kMaQjONMIu/QCA
 edASkIPG06jM+2ljWCX3V1XrnDlZkh5r5st8Lf0i2TsARwJ7sZsIW3E/N83SzMrrz7Alr9LlWT5
 QEteMe9ECL0qM+opt7q+9lFlzz6elobEHmXCkbP0j4tDgq0baOxKrSI2IF/Akuys8FCRXj4Bsgt
 r/pEdbo3O/O7PrRGjkEANAz8jQUJ8y8=
X-Received: by 2002:a05:6214:19cb:b0:6d4:211c:dff0 with SMTP id
 6a1803df08f44-6e1b220c97fmr419119856d6.29.1737731937509; 
 Fri, 24 Jan 2025 07:18:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmdodP9saJvQdN4XJbukcfBpsYckUx/xNNr4XSDEY4Nv9TvyMQ6F6ncaYoMjiqwLaqpGM4SA==
X-Received: by 2002:a05:6214:19cb:b0:6d4:211c:dff0 with SMTP id
 6a1803df08f44-6e1b220c97fmr419119596d6.29.1737731937112; 
 Fri, 24 Jan 2025 07:18:57 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e2057a94dcsm9380206d6.86.2025.01.24.07.18.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 07:18:56 -0800 (PST)
Date: Fri, 24 Jan 2025 10:18:53 -0500
From: Peter Xu <peterx@redhat.com>
To: Jason Wang <jasowang@redhat.com>, Eric Auger <eric.auger@redhat.com>
Cc: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>,
 "sgarzare@redhat.com" <sgarzare@redhat.com>,
 "lvivier@redhat.com" <lvivier@redhat.com>
Subject: Re: [PATCH] hw/virtio/vhost: Disable IOTLB callbacks when IOMMU gets
 disabled
Message-ID: <Z5OvXaUF6sdEQLgW@x1n>
References: <20250120173339.865681-1-eric.auger@redhat.com>
 <CACGkMEu4oMa8Sf9QXtszeoSMj_67Csr0s7kHdYfbNnJWibu2dA@mail.gmail.com>
 <5a55011a-af8f-483a-99fa-5cb2cdf3841f@redhat.com>
 <CACGkMEv6ec3JLZg6ZedSHdNS5_McX7_xoV4d2MG05x_Y5t=uEA@mail.gmail.com>
 <678babb6-f64a-4db5-ad60-494214a4e673@redhat.com>
 <CACGkMEvyYT7-PTOwO-Jg9a8AHA0AJHoV2BY2RBrJTGKEFYL6QA@mail.gmail.com>
 <25b5bb73-abd8-4008-905d-6c2e9e1330e2@redhat.com>
 <SJ0PR11MB6744EBC0BB7C8CD5F33D0A4E92E32@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <CACGkMEtQT2yZf93+a3LxSCyfBEXbEDu5S2cFXuAhprDYd2-vhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACGkMEtQT2yZf93+a3LxSCyfBEXbEDu5S2cFXuAhprDYd2-vhw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hello, Jason, Eric,

On Fri, Jan 24, 2025 at 11:30:56AM +0800, Jason Wang wrote:
> It might be because neither virtio bus nor virtio-net provides a
> shutdown method.
> 
> There used to be requests to provide those to unbreak the kexec.
> 
> A quick try might be to provide a .driver.shutdown to
> virtio_net_driver structure and reset the device there as a start.

I didn't check virtio driver path, but if that's missing it's reasonable to
support it indeed.

OTOH, even with that, vhost can still hit such DMA issue if it's a
hard-reset, am I right?  IOW, when using QMP command "system-reset".  If my
memory is correct, that's the problem I was working on the VFIO series,
rather than a clean reboot.  And that won't give guest driver chance to run
anything, IIUC.

I am wildly suspecting a VT-d write to GCMD to disable it can also appear
if there's a hard reset, then when bootloading the VM the bios (or whatever
firmware at early stage) may want to make sure the VT-d device is
completely off by writting to GCMD. But that's a pure guess.. and that may
or may not matter much on how we fix this problem.

IOW, I suspect we need to fix both of them,

  (a) for soft-reset, by making sure drivers properly quiesce DMAs
  proactively when VM gracefully shuts down.

  (b) for hard-reset, by making sure QEMU reset in proper order.

One thing to mention is for problem (b) VFIO used to have an extra
challenge on !FLR devices, I discussed it in patch 4's comment there.
Quotting from patch 4 of series:

https://lore.kernel.org/all/20240117091559.144730-1-peterx@redhat.com

     * (1) Device depth-first reset hierachy doesn't yet work for vIOMMUs
     *     (reference: resettable_cold_reset_fn())
     *
     *     Currently, vIOMMU devices are created as normal '-device'
     *     cmdlines.  It means in many ways it has the same attributes with
     *     most of the rest devices, even if the rest devices should
     *     logically be under control of the vIOMMU unit.
     *
     *     One side effect of it is vIOMMU devices will be currently put
     *     randomly under qdev tree hierarchy, which is the source of
     *     device reset ordering in current QEMU (depth-first traversal).
     *     It means vIOMMU now can be reset before some devices.  For fully
     *     emulated devices that's not a problem, because the traversal
     *     holds BQL for the whole process.  However it is a problem if DMA
     *     can happen without BQL, like VFIO, vDPA or remote device process.
     *
     *     TODO: one ideal solution can be that we make vIOMMU the parent
     *     of the whole pci host bridge.  Hence vIOMMU can be reset after
     *     all the devices are reset and quiesced.
     *
     * (2) Some devices register its own reset functions
     *
     *     Even if above issue solved, if devices register its own reset
     *     functions for some reason via QEMU reset hooks, vIOMMU can still
     *     be reset before the device. One example is vfio_reset_handler()
     *     where FLR is not supported on the device.
     *
     *     TODO: merge relevant reset functions into the device tree reset
     *     framework.

So maybe vhost doesn't have problem (2) listed above, and maybe it means
it's still worthwhile thinking more about problem (1), which is to change
the QOM tree to provide a correct topology representation when vIOMMU is
present: so far it should be still a pretty much orphaned object there.. if
QEMU relies on QOM tree topology for reset order, we may need to move it to
the right place sooner or later.

Thanks,

-- 
Peter Xu


