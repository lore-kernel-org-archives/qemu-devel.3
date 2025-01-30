Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60395C0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 17:36:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdYRz-0002fR-U8; Thu, 30 Jan 2025 12:35:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tdYRt-0002ee-Bs
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 12:35:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tdYRp-0008Gp-LG
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 12:35:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738258523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WRr5QagJ64ftVTltATuDFqiNs3ixyBzQ0JbgKFTADYU=;
 b=gdF0F4IwN/C/7cONN/7gTRp6HLr6DvFwPPsLLbEID+TufiM3H2gHJ+RC2KaPo4ctUNH0pP
 e62B2EJBlWOIjPFlvFslZG8wKiEA0N8KF6DN6bAR7UqS0j3GGP6nP62wY0ds4eEHgOTqTn
 IdSfXz+XUE1ADaP+3bV35tPcWIqSUAI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-QzvVq3-eOoumAs8mP48r2A-1; Thu, 30 Jan 2025 12:35:22 -0500
X-MC-Unique: QzvVq3-eOoumAs8mP48r2A-1
X-Mimecast-MFC-AGG-ID: QzvVq3-eOoumAs8mP48r2A
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6d89154adabso18091026d6.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 09:35:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738258522; x=1738863322;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WRr5QagJ64ftVTltATuDFqiNs3ixyBzQ0JbgKFTADYU=;
 b=wrtxdpl6ul2YmZ763RSYa1S6vGv1ypPdq4xrbalc1JHJa26/5yzHCYAzwBybIVcmJK
 Zs/c1wxjogoE6/YH3cJygelrbFtXIfKotEzCljLN3/Fodj/FQfiCNxlJnRytaXEcgbvV
 n5onPlxMmm7vHRpoP/PT5ctED91G9HobN7P2EtWqY0lziTRY84CML51SbYbS8L9szSX0
 nugo12FtHbl8G6pkP2mCxPyjHCwAQ2k4EYkFloxelIQhcsliua1cZT2BaOEWkcmCuL0U
 gT5vmj6hfhoCB/SDvCkPu0bmjtnsZlVQDXg9LYiRWCqxXIjBYgvtsrCprKGa8qNCLtiP
 X8zQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfBZeRu+tZsHpkEZXk1rvGFnfkkpNuYluFl5Vj8qcix/B+C4kamUyWEgsQQ4AoaaYa6JtMQCuzEh09@nongnu.org
X-Gm-Message-State: AOJu0Yz+dTeMkyui/HkoM8yh3x96MDQnSH3AiYVI6Nm0tLTuMZQsXm+0
 eF7NkVH9Bq4ehsgXwKGmkfhTBdtr4mqY7FSpgSxtpyeTr6pbez+Mn94yCC7SHxSdH2B5VUlM5TT
 ttbU1sgyWFn7e2avwae2ky3hC9PmCRgeLiw1vH+yFNObbbesTZSMa
X-Gm-Gg: ASbGnctKkYNmcz66hPorfmbqZ5KZSz71U+9hfPokVHKzPZFkZxwrA598WFwO3Z1j0Na
 iyAX/M2ST9Gc+CRJMdOHTE71ErBVg3osrgQWjMJCDhiD4rEneY6LxYBrg9O2XRYJQssJ6FGXDRW
 JAThczcINV5zxlrkPXB0kmTNkWUXU14DZDaUsL7DnLSc2SN95hfKcBJ7AzX2QXeNXof6EQB6ZH8
 xWhZizpAwss0RBYMxN9+vji6lPrzSYXdOfpeBwkqf5kgkfxBLCwjp3NsB/0lumfedbwzCxHU/6I
 OGGt6V+c3qD3bQlxhjhde5IBTh0sk1pC7Gm4Cuz1Q0GtJoVe
X-Received: by 2002:ad4:5c63:0:b0:6d8:7ed4:3367 with SMTP id
 6a1803df08f44-6e243bfa9cbmr138613336d6.19.1738258521815; 
 Thu, 30 Jan 2025 09:35:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbD7G26IH9658gPVjvBCLjnypDsq+lkhCqtSXywzQnHsxtKAL9vc146G1bAhEMZnC653C1yA==
X-Received: by 2002:ad4:5c63:0:b0:6d8:7ed4:3367 with SMTP id
 6a1803df08f44-6e243bfa9cbmr138612966d6.19.1738258521430; 
 Thu, 30 Jan 2025 09:35:21 -0800 (PST)
Received: from x1.local (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e254819f92sm8270896d6.48.2025.01.30.09.35.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2025 09:35:20 -0800 (PST)
Date: Thu, 30 Jan 2025 12:35:18 -0500
From: Peter Xu <peterx@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>,
 "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>,
 "sgarzare@redhat.com" <sgarzare@redhat.com>,
 "lvivier@redhat.com" <lvivier@redhat.com>
Subject: Re: [PATCH] hw/virtio/vhost: Disable IOTLB callbacks when IOMMU gets
 disabled
Message-ID: <Z5u4VmyEohMUmCPM@x1.local>
References: <5a55011a-af8f-483a-99fa-5cb2cdf3841f@redhat.com>
 <CACGkMEv6ec3JLZg6ZedSHdNS5_McX7_xoV4d2MG05x_Y5t=uEA@mail.gmail.com>
 <678babb6-f64a-4db5-ad60-494214a4e673@redhat.com>
 <CACGkMEvyYT7-PTOwO-Jg9a8AHA0AJHoV2BY2RBrJTGKEFYL6QA@mail.gmail.com>
 <25b5bb73-abd8-4008-905d-6c2e9e1330e2@redhat.com>
 <SJ0PR11MB6744EBC0BB7C8CD5F33D0A4E92E32@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <CACGkMEtQT2yZf93+a3LxSCyfBEXbEDu5S2cFXuAhprDYd2-vhw@mail.gmail.com>
 <Z5OvXaUF6sdEQLgW@x1n>
 <CACGkMEtPvUZh-seF1oDLMOOSiJhdHZeywvk6vKZy+jhEY4AjCA@mail.gmail.com>
 <CACGkMEsJXaPgHU0+YB+NKnDPoOg25RMNiWf-LCOqX1jP9REE8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEsJXaPgHU0+YB+NKnDPoOg25RMNiWf-LCOqX1jP9REE8w@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jan 27, 2025 at 08:44:50AM +0800, Jason Wang wrote:
> On Sun, Jan 26, 2025 at 3:56 PM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Sat, Jan 25, 2025 at 12:42 AM Peter Xu <peterx@redhat.com> wrote:
> > >
> > > Hello, Jason, Eric,
> > >
> > > On Fri, Jan 24, 2025 at 11:30:56AM +0800, Jason Wang wrote:
> > > > It might be because neither virtio bus nor virtio-net provides a
> > > > shutdown method.
> > > >
> > > > There used to be requests to provide those to unbreak the kexec.
> > > >
> > > > A quick try might be to provide a .driver.shutdown to
> > > > virtio_net_driver structure and reset the device there as a start.
> > >
> > > I didn't check virtio driver path, but if that's missing it's reasonable to
> > > support it indeed.
> > >
> > > OTOH, even with that, vhost can still hit such DMA issue if it's a
> > > hard-reset, am I right?  IOW, when using QMP command "system-reset".  If my
> > > memory is correct, that's the problem I was working on the VFIO series,
> > > rather than a clean reboot.  And that won't give guest driver chance to run
> > > anything, IIUC.
> >
> > Yes.
> >
> > >
> > > I am wildly suspecting a VT-d write to GCMD to disable it can also appear
> > > if there's a hard reset, then when bootloading the VM the bios (or whatever
> > > firmware at early stage) may want to make sure the VT-d device is
> > > completely off by writting to GCMD. But that's a pure guess.. and that may
> > > or may not matter much on how we fix this problem.
> > >
> > > IOW, I suspect we need to fix both of them,
> > >
> > >   (a) for soft-reset, by making sure drivers properly quiesce DMAs
> > >   proactively when VM gracefully shuts down.
> > >
> > >   (b) for hard-reset, by making sure QEMU reset in proper order.
> > >
> > > One thing to mention is for problem (b) VFIO used to have an extra
> > > challenge on !FLR devices, I discussed it in patch 4's comment there.
> > > Quotting from patch 4 of series:
> > >
> > > https://lore.kernel.org/all/20240117091559.144730-1-peterx@redhat.com
> > >
> > >      * (1) Device depth-first reset hierachy doesn't yet work for vIOMMUs
> > >      *     (reference: resettable_cold_reset_fn())
> > >      *
> > >      *     Currently, vIOMMU devices are created as normal '-device'
> > >      *     cmdlines.  It means in many ways it has the same attributes with
> > >      *     most of the rest devices, even if the rest devices should
> > >      *     logically be under control of the vIOMMU unit.
> > >      *
> > >      *     One side effect of it is vIOMMU devices will be currently put
> > >      *     randomly under qdev tree hierarchy, which is the source of
> > >      *     device reset ordering in current QEMU (depth-first traversal).
> > >      *     It means vIOMMU now can be reset before some devices.  For fully
> > >      *     emulated devices that's not a problem, because the traversal
> > >      *     holds BQL for the whole process.  However it is a problem if DMA
> > >      *     can happen without BQL, like VFIO, vDPA or remote device process.
> > >      *
> > >      *     TODO: one ideal solution can be that we make vIOMMU the parent
> > >      *     of the whole pci host bridge.  Hence vIOMMU can be reset after
> > >      *     all the devices are reset and quiesced.
> > >      *
> > >      * (2) Some devices register its own reset functions
> > >      *
> > >      *     Even if above issue solved, if devices register its own reset
> > >      *     functions for some reason via QEMU reset hooks, vIOMMU can still
> > >      *     be reset before the device. One example is vfio_reset_handler()
> > >      *     where FLR is not supported on the device.
> > >      *
> > >      *     TODO: merge relevant reset functions into the device tree reset
> > >      *     framework.
> > >
> > > So maybe vhost doesn't have problem (2) listed above, and maybe it means
> > > it's still worthwhile thinking more about problem (1), which is to change
> > > the QOM tree to provide a correct topology representation when vIOMMU is
> > > present: so far it should be still a pretty much orphaned object there.. if
> > > QEMU relies on QOM tree topology for reset order, we may need to move it to
> > > the right place sooner or later.
> >
> > Sounds like a non-trivial task, so for a hard reset, maybe we can
> > proceed with Eric's proposal to deal with the reset before the device
> > stops.

The major challenge when I was working on that (as far as I can still
remember..): some devices are created at early stage of QEMU startup, which
can happen before the vIOMMU is created and realized.  Then it can be
challenging to re-parent those devices to be childrens of the vIOMMU, or we
may need a way to create vIOMMU always earlier than those..

> 
> Btw, I actually meant to break the assumption that vhost needs to be
> enabled/disabled after/before vIOMMU. This only works for virtio-net /
> vhost. From the view of vhost, it would work similar to _F_LOG_ALL
> (where there's no assumption on the order of enabling/disabling dirty
> page tracking and device start/stop).

Yes, we can go for a lightweight solution.

Thanks,

-- 
Peter Xu


