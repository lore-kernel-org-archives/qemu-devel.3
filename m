Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C27CD98C6
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 06:36:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXZ0v-0002ME-1Y; Thu, 11 Jun 2026 02:35:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wXZ0L-0002CS-NC
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 02:35:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wXZ0G-00024T-KH
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 02:35:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781159699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IH7X/BsaoA0B6KFizfMoKkCEWocB8PozDwbY65oi35w=;
 b=gpgasKPQyISo+BrFI18cjlURe9UvnAr0HP5hMRPOamstHo5a+EG7Vzqo/GsHBYuCHlKCxH
 Fv7jc9rWxynWat/NtCPN3vpRvDz4cIQR0FZFMsmKYspQbY5LlmZPap4/iBoJteV+i6b6Wi
 tnOJkjYNJF/IBdK8eKRqpZqYXcBMJKU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-0g0Vo-TzNQG4ECGKdEf70g-1; Thu, 11 Jun 2026 02:34:57 -0400
X-MC-Unique: 0g0Vo-TzNQG4ECGKdEf70g-1
X-Mimecast-MFC-AGG-ID: 0g0Vo-TzNQG4ECGKdEf70g_1781159697
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-490b37e1f48so59671555e9.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 23:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781159697; x=1781764497; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IH7X/BsaoA0B6KFizfMoKkCEWocB8PozDwbY65oi35w=;
 b=Lfrp8PCLS5oXbI9Rfx9dO6pZGWMIechKNuf600SGVLGf/jMEn580VYu/EnFD47yFfb
 mhKfmBfMQH8D1buXzyt/713upfETDYoEEQYbEBEydn1W5AD532XUp8EqhWleesONtTFJ
 ggj8Y72KUGbSdzTSOkg0gWgJ2/PKgJkbIISMcAtyRKuaoyY6Q6T/X4EzjtdkhhQNvH8i
 t85a1jWxN8kf2z8ho5JE1CQ6k4EShKLGn+8BZ+bK/YkQGbGLuqInFxqE055bZWIZ1lJU
 1C7qE4uKWO4c94xrvP42YSk3T8NaW6XltIf/p7asgmthU/30e+wrSBimX00lzD2dL6Az
 aDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781159697; x=1781764497;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IH7X/BsaoA0B6KFizfMoKkCEWocB8PozDwbY65oi35w=;
 b=jtDEcIWsnbJe0l8C07cnzGn54DSBTpYWg1JztMpXQjeaXnE2/rSQjbp3l89vNtF6bN
 NwpDeW+lyNCBUPIYNkXHYTK8P0Qr67snjMb1daf4wZK7Ec3UxpLv9nW3iWfmMot4YnjL
 eXjjLhOFz8NSFoARFOi2ehNFB+rPftp/HH/WmIb+wwH3Y6HFR148kWPjz+vjnQ2l95vQ
 YK31PwqkCpda20IOgdVB27GzuSbwEpqWqyduAXfELuijY82XC+Zn5kSl1pRMr+oJoReX
 g5IvQzDNErsPCsjsPZDbbHEqWS9ro7f45JzSkNalCKoavOvRLNAPOGdANOLiDnpvNNdt
 +ZnA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8YGPJjjC0QqRycs/fGvfYhtc/PdlmL7tSTvVRtdlYiGgHLeA7zwi4Ly+V/TeN6EuzpivLYrbJI6YX/@nongnu.org
X-Gm-Message-State: AOJu0YylJz67lMRw8Xcmbss7+M5GEnxrVkU1uDtk+byhyD4ti4OH8wwn
 MvrFxUFN3JNgteI3cauG/LhowFdHgAeRZsnsjLJI6D3bCZ2l+oQWoFlhvBKU7xManKLT080pAX0
 ZupIDM8gSQrveYxei0ROLExH1QPVD1RE4ZE1rZs/VjveBGQAD4f3YfCVD
X-Gm-Gg: Acq92OFzauedyo9c+v6jiIXutk3sItoGf5b0mU651Zlu8sDjJTLKbgGBv13Nq5fItcH
 cZT0H32mhSZ1kT3md5/NUjEGTRWTfSWT6EvQckpy63XJ4jFjWbq8GvjoJWZT2jB9wy8m8kjM8cO
 kzZ9rsuEOcK3idjXGSFzLb/kVy8k0OE1vr29TsnmSkYEGsNuiUDwhG5i+od07m5an9LGFeNy+Ht
 9ZLEZa/E5Z3L+1JgQL3xOahIDT/caBNp57YAOizTNFwEJpdZu3AQ4ElBR4VHJTZJ+liu9Br/736
 E9DXqj1xVOcHzzCejE5+myjiUAIffK4VRuYqCRq7AzWiGbUAwADxFmTynceyBFtbMqGcjiZ0kBC
 QM+4oGWF7D0XzyDKxBHUZkBvck+CfaKtkl+75qOfNZk5emnvTMHCe7g==
X-Received: by 2002:a05:600c:41cc:b0:490:b0e0:3de2 with SMTP id
 5b1f17b1804b1-490e561c40emr7362155e9.33.1781159696493; 
 Wed, 10 Jun 2026 23:34:56 -0700 (PDT)
X-Received: by 2002:a05:600c:41cc:b0:490:b0e0:3de2 with SMTP id
 5b1f17b1804b1-490e561c40emr7361785e9.33.1781159695991; 
 Wed, 10 Jun 2026 23:34:55 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e531e6acsm24971195e9.12.2026.06.10.23.34.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 23:34:55 -0700 (PDT)
Date: Thu, 11 Jun 2026 02:34:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Pavel Hrdina <phrdina@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, jugraham@redhat.com,
 shan.gavin@gmail.com, Alex Williamson <alex@shazbot.org>,
 David Hildenbrand <david@kernel.org>
Subject: Re: [PATCH RFCv1] virtio: Inherit max bounce buffer size from bus
 parent if possible
Message-ID: <20260611023428-mutt-send-email-mst@kernel.org>
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
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


This is header copy why and how would we try to avoid that?

-- 
MST


