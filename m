Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B28CD98C6
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 06:52:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXZGI-0007rk-IP; Thu, 11 Jun 2026 02:51:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wXZGH-0007rL-3x
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 02:51:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wXZGF-00078s-BM
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 02:51:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781160689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c8ah96WPgdtbvq1PyE+wkIRcfiH+NS+6EfcqQ46lry4=;
 b=Q9Q+V2smvEvIS82hmWE00izkpjK1P9Yoq5ABpUl1sTstd6t+Jc7X4AdLm7AZUvPwv7+rWt
 /+AecmoDT661/YhrWHxuripAD6kUvzq+9wRBcdbM6jQJR8L154e62PNwjWX3gucHbrxncs
 wetnySobONNBHTex+/Wm77c6yt+T+zg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-wFyCliPMOu27hiBuf3Rn7g-1; Thu, 11 Jun 2026 02:51:28 -0400
X-MC-Unique: wFyCliPMOu27hiBuf3Rn7g-1
X-Mimecast-MFC-AGG-ID: wFyCliPMOu27hiBuf3Rn7g_1781160687
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490c840efe6so4682515e9.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 23:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781160687; x=1781765487; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=c8ah96WPgdtbvq1PyE+wkIRcfiH+NS+6EfcqQ46lry4=;
 b=P8oG5bZUU6WqgbPp9CdVFqACYKsirA+c5jdCW5l9i3suoYf2zkjfB5dqjxwqJniM6Y
 kVmz6sYhkkXaP8dw6YH08MxjEt7LKEyqCNL68QNKC5yVSHQnyjc9SecOQrwTnq6+FiLa
 qo2OQxrE2InRzZsuVwxDv0uRiG4GpjmO6XWBvWHLRjOfSTsZvcaX77QZolFhBsW8Ckt2
 KJ8SvUWMhE/c98W3a6swZnhrmFP1Tw5j0CyQU4hNBgpQhpfOr0ReRsrCM5yjaWK7Pt5y
 uEgx/cmVTL9iUXc88+MVnv4g8PXGZ6F3I4wR1S3CXkHTEJth6qenWkO4DvThIRs9kBkE
 AMHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781160687; x=1781765487;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c8ah96WPgdtbvq1PyE+wkIRcfiH+NS+6EfcqQ46lry4=;
 b=n4RXHBUKroI7J5iN/DDSeQDv7HBpJ/yOhuIpnHFUlts+soWHTiMsnN5nHUbQg9ttil
 8YxlGVVT0w4apbQqRMHHH8vdiJT3L9CsYl1cxL4DMfkWcD6PJ0dOCyW3QEyMoszWmyAN
 IdfHeW+h8THY5eeq03zL7h8BnRfVbygvVZekDINStA0U4xKxJoCJ2le1avPFFdzUT2UJ
 c/W7eo1NB00B8D6ZEfsfsmI/YB0VTJ9WuaoJxRPS2XZqD26IxhVw8yUk2Xr7OmaKxwxO
 PXT7tNO46vlU4D54p4XChloJFAh+ZUBTBhXdsdWwufaXIs3aofXIZw3uYDUWuGrXPWCt
 opjg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+AN06jywE9TMrGbvNVyhZsnDWY2F2UcIpCGUnArGHpRbnKKqLc/3W8tP5Rwn4o+KkKJpdczG19+xV3@nongnu.org
X-Gm-Message-State: AOJu0YxCEhtq4mPkjF+NTyIk1w3Dv3Lomn33SuecM+Y6RduB21sXkK1x
 ELZ8s0FIV8lhrqbalJHbC9qw48P9lFc7V5GMdu9V+4CZOzEhvOKbBwf9lMw7M5fFCAILa1Q6r7B
 Dg3DY6OcPdYg6cYJoDDHSY1HvRg3rMVnzJLcslrGWf1jQgH5CBUaun3va
X-Gm-Gg: Acq92OGs9pxtuznpHFuVrAwy1HTPySonbLjQIQ0JILlJoTdBuhLYE1IcpPFtzL0xkR3
 6SGsEXo740p6yKfreX9nWe3KiiMJtVS2D7JHJJb38KABrD1eILJIlesfZJNT8+rGjdRHKcpoB5t
 4ur+Yn/3iTzO5fxXcrgcUEFV9mdpA2gtSIQKfKYvayL26yHIZ5yj4jiCk3StGAJbHIFbduKPgZR
 YUT2kRUn97PkFBGhhrcGXtktG4c1cdEQVAg2lrU1OYFgowJdkbEdGrzxUTvBPyeC8fL5O6DwGmC
 t+nKY4rd84DQ7deOGRSZzeUbzi6akyGNM4NDlVwSabVLvbeal+CfWB+YY1yj630LcNRcLlAIsnH
 zHDgQoFkY1byPjfRcYEMz3hXikYy53jMuDBF9d16iJtSanfEyt4lKVQ==
X-Received: by 2002:a05:600c:a41a:b0:490:af46:5c68 with SMTP id
 5b1f17b1804b1-490e510f954mr7800425e9.7.1781160686767; 
 Wed, 10 Jun 2026 23:51:26 -0700 (PDT)
X-Received: by 2002:a05:600c:a41a:b0:490:af46:5c68 with SMTP id
 5b1f17b1804b1-490e510f954mr7800085e9.7.1781160686266; 
 Wed, 10 Jun 2026 23:51:26 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f3444fesm78129019f8f.20.2026.06.10.23.51.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 23:51:25 -0700 (PDT)
Date: Thu, 11 Jun 2026 02:51:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Pavel Hrdina <phrdina@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, jugraham@redhat.com,
 shan.gavin@gmail.com, Alex Williamson <alex@shazbot.org>,
 David Hildenbrand <david@kernel.org>
Subject: Re: [PATCH RFCv1] virtio: Inherit max bounce buffer size from bus
 parent if possible
Message-ID: <20260611024203-mutt-send-email-mst@kernel.org>
References: <eb0f0da1-11dd-4437-94fd-a65af55851e1@redhat.com>
 <20260610082637-mutt-send-email-mst@kernel.org>
 <5d8cbd4b-3725-437e-88a3-e0af32164815@redhat.com>
 <e7cc9f2d-ccb4-442f-a1ed-7c5474395099@redhat.com>
 <20260610095712-mutt-send-email-mst@kernel.org>
 <aimEl9QQ_LTRPLtd@x1.local>
 <20260610121026-mutt-send-email-mst@kernel.org>
 <1e9515c9-7e32-4d95-9b73-aab8bf10bddc@redhat.com>
 <20260611012217-mutt-send-email-mst@kernel.org>
 <3726a607-6cac-41f1-b402-0eed7c4e3fe3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3726a607-6cac-41f1-b402-0eed7c4e3fe3@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jun 11, 2026 at 04:28:20PM +1000, Gavin Shan wrote:
> Hi Michael,
> 
> On 6/11/26 3:31 PM, Michael S. Tsirkin wrote:
> > On Thu, Jun 11, 2026 at 02:33:05PM +1000, Gavin Shan wrote:
> > > On 6/11/26 2:18 AM, Michael S. Tsirkin wrote:
> > > > On Wed, Jun 10, 2026 at 11:36:55AM -0400, Peter Xu wrote:
> > > > > On Wed, Jun 10, 2026 at 10:06:24AM -0400, Michael S. Tsirkin wrote:
> > > > > > On Wed, Jun 10, 2026 at 11:54:47PM +1000, Gavin Shan wrote:
> 
> [...]
> 
> > > > > > 
> > > > > > I do not think it has anything to do with host endian-ness.
> > > > > > 
> > > > > > 
> > > > > > This is the change that broke it I think?
> > > > > > 
> > > > > > 
> > > > > > commit 4a2e242bbb306ef5c16ce9e7bb2da3bd8a4eb098
> > > > > > Author: Alex Williamson <alex@shazbot.org>
> > > > > > Date:   Mon Oct 31 09:53:03 2016 -0600
> > > > > > 
> > > > > >       memory: Don't use memcpy for ram_device regions
> > > > > > 
> > > > > > Maybe Alex has an opinion on what to do.
> > > > > 
> > > > > I can offer one idea here..
> > > > > 
> > > > > IIUC the major issue was vector ops but the mr ops might be too heavy, then
> > > > > another way to fix it is in memory API instead of using memcpy()/memmove(),
> > > > > we always use a helper (say, memmove_no_vector()) to do the split and
> > > > > properly aligned IOs as what ram_device_mem_ops does right now, this should
> > > > > only applies to ram_device.
> > > > > 
> > > > > With that, IIUC we can remove the current ram_device_mem_ops, then in
> > > > > Gavin's case mmap() will go through and guest will not need to vmexit at
> > > > > all.  Best perf, issue solve.
> > > > > 
> > > > > We just need to be careful to trap all possible memcpy()/memmove() used in
> > > > > memory core.. if I didn't miss any, IMO below four should needs to be
> > > > > replaced by memmove_no_vector():
> > > > > 
> > > > >     flatview_write_continue_step()
> > > > >     flatview_read_continue_step()
> > > > >     address_space_read()
> > > > >     address_space_write_rom()
> > > > > 
> > > > > Thanks,
> > > > > 
> > > > > -- 
> > > > > Peter Xu
> > > > 
> > > > First, this is a nice idea.
> > > > Second, the ideal thing is still just allowing direct access.
> > > > And I think VFIO actually knows it's regular RAM.
> > > > So something like the following small patch in linux, maybe?
> > > > 
> > > 
> > > If I understood everything, Peter's proposal seems to move the logics covered
> > > by ram_device_mem_ops to the upper layer.
> > 
> > 
> > I think the basics of Peter's idea are really simple: if guest is doing
> > DMA into a region then that access is treating that region as RAM and so
> > any vectored etc instructions into it are fine.
> > 
> > So we can fix specifically DMA into RAM DEVICE to bypass bounce buffering.
> > 
> > It's at the low memory level, not the upper layer.
> > 
> > He also apparently feels bounce buffering isn't needed
> > generally and can be replaced with memmove_no_vector? And
> > somehow virtio DMA can be done without kicking host? I'm not
> > sure I understand these parts.
> > 
> 
> For Peter's idea, I believe there is something I missed. Lets take our specific
> case as an example where the DMA request is handled as the following calltrace
> indicates.
> 
>     virtio_blk_handle_output
>       virtio_blk_handle_vq
>         virtio_blk_get_request
>           virtqueue_pop
>             virtqueue_split_pop
>               virtqueue_map_desc
>                 address_space_map
>         virtio_blk_handle_request
>           iov_to_buf
>             memcpy
> 
> In address_space_map(), all RAM DEVICE regions treated as directly accessible
> and the buffer (RAMBlock::host + offset) is returned. The buffer is passed on
> to virtio_blk_handle_request() and iov_to_buf(), the data is then copied over
> using memcpy(), which we're trying to avoid.
> 
> Thanks,
> Gavin
> 


The original bug was QEMU doing MMIO on behalf of guest right?

So maybe there's an even simpler thing: I think that if the BAR is
mapped directly into guest we do not need a bounce buffer in qemu.

Alex could you give your opinion on this?

-- 
MST


