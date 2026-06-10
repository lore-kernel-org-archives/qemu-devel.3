Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77076CD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 14:07:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXJZl-0005EP-5U; Wed, 10 Jun 2026 10:06:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wXJZj-0005E9-Fb
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 10:06:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wXJZh-0007DY-Fn
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 10:06:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781100392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FbwRKzn7uLSkkNHVR5KkTPPSUG5KB+mOgYqM02d8XJs=;
 b=gY6+u2m7qVtee3RKZCQLY5tfF7kH60uO8pqTUTMYPkAmJjp3J2euD0oZamXXS3IdLeDCh7
 omnnxII4DEyVXeuiKaQHTO9OuVPV/N+qyXO9dP7q27U1w7xKTm+JlLxpsOe39jaW6+FEwJ
 WsAElq9ojD0mkrChMAf5Enlu1KFseJQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-r45coKD_MxSrlqdIPY5DBw-1; Wed, 10 Jun 2026 10:06:30 -0400
X-MC-Unique: r45coKD_MxSrlqdIPY5DBw-1
X-Mimecast-MFC-AGG-ID: r45coKD_MxSrlqdIPY5DBw_1781100389
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-bf0c312a0dfso654439166b.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 07:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781100389; x=1781705189; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FbwRKzn7uLSkkNHVR5KkTPPSUG5KB+mOgYqM02d8XJs=;
 b=YNkkNRSFTT3Ti6I10nanLFgLruSqgkw/+2DZfcldze2TcSUilvR4EPaSnBiq62Eupq
 MFSvmvq3wFbk4W8dhSDO/q0OXHgf7BhTB8lSxkEuCZ4xkVgPBCBM5yObxG1ArK7tzaNS
 lsbTeiv9YICgoVDv2ANlfs2bv1PnorSwNj2SJ8UQy4tzZdTwfGPJfywuyEGKePqy5oYr
 rf8ZtVRf/py476ixbYWGUmD2vxmqaoe5KMhjZ2WsQb0eldTwE1wtJ8CV77okJQ/TKyUj
 j+jSkt6v7N801AilinXcglL1xDvpkbopXbXZl3WnjiNQE5do7luKJG772pbFeWPtBBNB
 C/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781100389; x=1781705189;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FbwRKzn7uLSkkNHVR5KkTPPSUG5KB+mOgYqM02d8XJs=;
 b=JVT57arwh2pFVoA2NygP1apCpKqI3uCM3KSj0T/pV95MVh5JKZsvAJHz3xV8lvyNIW
 avu4WhTzXKK8qrtLWoe3TggtICqrMHHjZLgEJ+UI7YCJwfSnnK+OgHMKdpVFHRTfAqrW
 gpR5G+9p0Fn+iGUBrf/uxbPYpRPwfX55MDGkw5ANnvAnRt7NsHE/wamaP1qknPh9F/Qi
 ySzua3GyxrT0h3eLiuybI7dB0k/mRPbxVzkDPbHBLZHJ5cx/Vfg5yxduBYUlzAGmSY3S
 5c35aBde96UAyVpozvOizr8sCnGPJNHjNT23bqSBHs71bUdQoA/+DutlyZdg8kBttkdt
 K9QQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/fSn+SrJXqFBPiOKMGeZTAgBFRl8mHCXiz9J7A/5C2DqiVNaUAWF2WFUq+v4mSEVhhXxQbnPZtT0O4@nongnu.org
X-Gm-Message-State: AOJu0Yz1OyFwt8UbpfTmhsYEh2Kxs+VAFpZRShip2Gr7Su9e2Q8F/12I
 1WxzgdxIWF31H4PVWyl7Ev9xQyD9SO/CS7RW+7sIPX2VD3JvVfOjHTzfT65qgDmyvZ6+WppwM8e
 s3VOARXrqmp2hCeGcAlJeVCey1wZ9AhuOFv69xNqi/3MtVL61bI916YCC
X-Gm-Gg: Acq92OF6vVyF9+4wGp34wVQDOf0MHyBoCRJnJ73pfHgbFoWWqUkuXtFZZPI9kYSl62O
 JkxohLBk7iIKFue410Na2L+9bmRBhfpYQ3eEXIw4gHvPO0tWP6ivvIFmIZFNxBkGCoZChVK5Kak
 yMKN4VCEUYCys4Ej8Z4a0HMu4Y0Vqo9EjU6bXrrlhwluriyxfz+aN+vAb11wG9YZ+NX/OrFqDHe
 e9RpBTtIFwbQY09B3ufBTmv/+KI0kXtH0czS6/fMqOVY8ohQIbq4GC63fPO6Jyq0hLHqjztCvVN
 4JfInzhCdi+oKRdp7hH68LfqzvWI/Ce9WB263bsRDHUqHq7KyaI9dS3RZGqQSN9wiacZltkYdEJ
 ilPbQO4Wglc4gzutUmPwoP5Rz2+MksYWz7Sf0++TdfJRm+ey4m9xEMg==
X-Received: by 2002:a17:907:1c85:b0:bec:7066:8439 with SMTP id
 a640c23a62f3a-bf370a663d5mr1345059966b.18.1781100389132; 
 Wed, 10 Jun 2026 07:06:29 -0700 (PDT)
X-Received: by 2002:a17:907:1c85:b0:bec:7066:8439 with SMTP id
 a640c23a62f3a-bf370a663d5mr1345055266b.18.1781100388419; 
 Wed, 10 Jun 2026 07:06:28 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46028a6dcbdsm60231848f8f.7.2026.06.10.07.06.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 07:06:27 -0700 (PDT)
Date: Wed, 10 Jun 2026 10:06:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: Pavel Hrdina <phrdina@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, jugraham@redhat.com, shan.gavin@gmail.com,
 Alex Williamson <alex@shazbot.org>, David Hildenbrand <david@kernel.org>
Subject: Re: [PATCH RFCv1] virtio: Inherit max bounce buffer size from bus
 parent if possible
Message-ID: <20260610095712-mutt-send-email-mst@kernel.org>
References: <20260608001821.850921-1-gshan@redhat.com>
 <aiaDgG26a6TUrKuM@redhat.com>
 <07ca74b4-52a8-4187-a57c-7c3277e574d3@redhat.com>
 <aiky9d9IwACIyKEC@phrdina-thinkpadt14gen4.rmtcz.csb>
 <674d5e21-88fa-4a10-a83c-eb6f7ce7032f@redhat.com>
 <20260610080947-mutt-send-email-mst@kernel.org>
 <eb0f0da1-11dd-4437-94fd-a65af55851e1@redhat.com>
 <20260610082637-mutt-send-email-mst@kernel.org>
 <5d8cbd4b-3725-437e-88a3-e0af32164815@redhat.com>
 <e7cc9f2d-ccb4-442f-a1ed-7c5474395099@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e7cc9f2d-ccb4-442f-a1ed-7c5474395099@redhat.com>
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

On Wed, Jun 10, 2026 at 11:54:47PM +1000, Gavin Shan wrote:
> Hi Michael and Peter,
> 
> On 6/10/26 11:00 PM, Gavin Shan wrote:
> > On 6/10/26 10:27 PM, Michael S. Tsirkin wrote:
> > > On Wed, Jun 10, 2026 at 10:19:31PM +1000, Gavin Shan wrote:
> > > > On 6/10/26 10:12 PM, Michael S. Tsirkin wrote:
> > > > > On Wed, Jun 10, 2026 at 08:55:10PM +1000, Gavin Shan wrote:
> > > > > > On 6/10/26 7:54 PM, Pavel Hrdina wrote:
> > > > 
> > > > [...]
> > > > 
> > > > > > > 
> > > > > > > You did not answer the question that Daniel was asking, how will user
> > > > > > > know that max-bounce-buffer-size should be used if it's necessary to fix
> > > > > > > guest system hangs and how will user know what magic value should be set?
> > > > > > > 
> > > > > > 
> > > > > > Sorry that I missed to answer Daniel's questions. For this specific case,
> > > > > > user need to enlarge the bounce buffer size when seeing the following error
> > > > > > message. We can add an explicit one in address_space_map() if the existing
> > > > > > error message isn't obvious.
> > > > > > 
> > > > > >     qemu-system-aarch64: virtio: bogus descriptor or out of resources
> > > > > > 
> > > > > >     void *address_space_map(AddressSpace *as,
> > > > > >                           hwaddr addr,
> > > > > >                           hwaddr *plen,
> > > > > >                           bool is_write,
> > > > > >                           MemTxAttrs attrs)
> > > > > >     {
> > > > > >         if (!memory_access_is_direct(mr, is_write, attrs)) {
> > > > > >             if (l == 0) {
> > > > > >                 error_report("Running out of bounce buffer size , enlarge it with max-bounce-buffer-size");
> > > > > >                 *plen = 0;
> > > > > >                 return NULL;
> > > > > >             }
> > > > > >         }
> > > > > > 
> > > > > > As to the value user should take for max-bounce-buffer-size, it is really case by case
> > > > > > and decided by user. User needs to try 4096, 8192, ..., 0xFFFFFFFF to figure out the
> > > > > > smallest value works for them. The worst case is to set 0xFFFFFFFF.
> > > > > > 
> > > > > 
> > > > > 
> > > > > This is not at all reasonable. All kind of fixes are possible but
> > > > > fundamentally, bounce buffering data path is by itself already a
> > > > > bad idea.
> > > > > 
> > > > > I have no idea what does bounce buffering device ram accomplish.
> > > > > 
> > > > > In the end, qemu still simply reads the memory from/to the buffer.
> > > > > 
> > > > > My suggestion is to first of all look for ways to mark the
> > > > > memory as direct.
> > > > > 
> > > > 
> > > > As I explained to Peter Xu in another reply, we can't simply mark the (RAM
> > > > DEVICE) memory region is directly accessible. The memory region is initialized
> > > > by memory_region_init_ram_device_ptr() in hw/vfio/region.c::vfio_region_mmap().
> > > > 
> > > > The  accesses to the memory region is handled by 'ram_device_mem_ops' where
> > > > {ldn, stn}_he_p() are used in its read/write handler. They're different
> > > > from memcpy() since the data endianness is well handled in {ldn, stn}_he_p().
> > > > 
> > > > Thanks,
> > > > Gavin
> > > > 
> > > 
> > > What is endianness set to, for this region?
> > > 
> > 
> > The endianness of the memory region is set to that for the host.
> > 
> > static const MemoryRegionOps ram_device_mem_ops = {
> >      .read = memory_region_ram_device_read,
> >      .write = memory_region_ram_device_write,
> >      .endianness = HOST_BIG_ENDIAN ? DEVICE_BIG_ENDIAN : DEVICE_LITTLE_ENDIAN,
> > };
> > 

So there is never any endianness translation.
I think the reason qemu does the bounce buffer is more
to prevent things like vector access from MMIO.


> How about to treat the RAM DEVICE memory region directly accessible in
> address_space_map() only when HOST_BIG_ENDIAN is false,
> something like
> below and I don't hit the guest hang issue with the changes.
> 
> diff --git a/include/system/memory.h b/include/system/memory.h
> index 1417132f6d..9daca55251 100644
> --- a/include/system/memory.h
> +++ b/include/system/memory.h
> @@ -2908,7 +2908,8 @@ void *qemu_map_ram_ptr(RAMBlock *ram_block, ram_addr_t addr);
>  int memory_access_size(MemoryRegion *mr, unsigned l, hwaddr addr);
>  bool prepare_mmio_access(MemoryRegion *mr);
> -static inline bool memory_region_supports_direct_access(const MemoryRegion *mr)
> +static inline bool memory_region_supports_direct_access(const MemoryRegion *mr,
> +                                                        bool check_ram_device)
>  {
>      /* ROM DEVICE regions only allow direct access if in ROMD mode. */
>      if (memory_region_is_romd(mr)) {
> @@ -2922,13 +2923,14 @@ static inline bool memory_region_supports_direct_access(const MemoryRegion *mr)
>       * be MMIO and access using mempy can be wrong (e.g., using instructions not
>       * intended for MMIO access). So we treat this as IO.
>       */
> -    return !memory_region_is_ram_device(mr);
> +    return (!check_ram_device || !memory_region_is_ram_device(mr));
>  }
>  static inline bool memory_access_is_direct(const MemoryRegion *mr,
> +                                           bool check_ram_device,
>                                             bool is_write, MemTxAttrs attrs)
>  {
> -    if (!memory_region_supports_direct_access(mr)) {
> +    if (!memory_region_supports_direct_access(mr, check_ram_device)) {
>          return false;
>      }
> diff --git a/system/physmem.c b/system/physmem.c
> index 7bcbf87573..2e6b72b124 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -3724,7 +3724,7 @@ void *address_space_map(AddressSpace *as,
>      fv = address_space_to_flatview(as);
>      mr = flatview_translate(fv, addr, &xlat, &l, is_write, attrs);
> -    if (!memory_access_is_direct(mr, is_write, attrs)) {
> +    if (!memory_access_is_direct(mr, HOST_BIG_ENDIAN, is_write, attrs)) {
>          size_t used = qatomic_read(&as->bounce_buffer_size);
>          for (;;) {
>              hwaddr alloc = MIN(as->max_bounce_buffer_size - used, l);
> 
> Thanks,
> Gavin
> 

I do not think it has anything to do with host endian-ness.


This is the change that broke it I think?


commit 4a2e242bbb306ef5c16ce9e7bb2da3bd8a4eb098
Author: Alex Williamson <alex@shazbot.org>
Date:   Mon Oct 31 09:53:03 2016 -0600

    memory: Don't use memcpy for ram_device regions
    

Maybe Alex has an opinion on what to do.


-- 
MST


