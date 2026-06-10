Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77EAACD98CE
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:21:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLdJ-0002rZ-Oi; Wed, 10 Jun 2026 12:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wXLdG-0002kJ-1j
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:18:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wXLdD-0001rA-0k
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:18:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781108298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0SBcu3wlimQ0LEpRHsLRY/sDg60A4h458rzr7uhvnsk=;
 b=GhOwHel0NGrp8mecTyXOOQ0WCyr0tet6KFPHMtLctZyBzF88DviJchfC58loLhHRObgSTW
 UeIui3lc5fIsjzoncOdKyqRXRZVcMxI+SAoJ+EictcrOHz4H33RVyDRRd4wyWL05Gk/8bh
 3Tw8XbWX8C2zDDACNO+NPi1Qvndy6VY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-B_XAwPqAMQatIKmy8Drchw-1; Wed, 10 Jun 2026 12:18:16 -0400
X-MC-Unique: B_XAwPqAMQatIKmy8Drchw-1
X-Mimecast-MFC-AGG-ID: B_XAwPqAMQatIKmy8Drchw_1781108295
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-45eebc943bfso20085f8f.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781108295; x=1781713095; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0SBcu3wlimQ0LEpRHsLRY/sDg60A4h458rzr7uhvnsk=;
 b=ZZHsRmnvl+GdZd/hc7tl8NyThquHX13lvs5YODgxnpAXYYgWRofapyb0z3S4QmGZK6
 TM52KVn+taHqSa8FWahrmG9gFdNLRRbB4Ok0sUsmGxkHTWCxrmmGzIakuYw6w04uXezl
 Ez/99qltM1iEMwX8I+Joa/ISqfbyqJjvTjzKD6mR/ahJaKtRwLPA6z3CvvzdJyjGHxJb
 eNWnbkVGRC7Ek5LZC2UuX10I/Ker1c1jIxgNZzvZygb4d3FNuwNRKUhsNXqFVMIaW926
 xJXgHLAuvumnFD7LncTpviFH5pWZUtD7axdqvOCvLfpBPg5XOT1swNY0X0+dDerJL5Gm
 MYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781108295; x=1781713095;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0SBcu3wlimQ0LEpRHsLRY/sDg60A4h458rzr7uhvnsk=;
 b=Xh/0383uwEQCXR0zsHWPbSMpdaOYZ/GVHv7rPlIOfUWPYrVk7VkG+bpJ1+TiZ9z/vN
 kshkrVUUreKRVeANyPFPoENWE34/SoQ3VIwtqtE0hCgioGz+wtTaKpr6Mawf73yMx3nO
 Q4srqIiOuk54owhehk/UW9y5lSGwjozlsUFf0Tb9fU2D212qkjWyra0vTJ8FebFIJysZ
 +e4KOhXtYHxKQWOSTo25uWcB8C8j/cWeedvozaHHlCepgdHteai//Cc1FynWw2Cw0QBU
 gqHcsnX21DkVM9VxDi6FmYWVMzTlRCOJ1IFNfw6BVtvouxX1OqLBaKSEi/L9CMnWoeUY
 vFEA==
X-Forwarded-Encrypted: i=1;
 AFNElJ91TTqqD+4vbWOs1c0S74v82WlnzVYjNQQf9Kk/3v+8fH4vkrpDSnZMZbu/NvdYMQdui8l44L5owBcE@nongnu.org
X-Gm-Message-State: AOJu0YxXK8Yc2+hUdes/qnzlWf6yewCOOSJlhou1IvZluZYG0tKRTksr
 KLAdfRHmqXEOTOvPkqZYCd/dg4QOGtYw1Nu/9zCfJyXc2CSJdd+vyfEU2pg1vlztaPQhdBuMPia
 8jKkY0h4Sbvq6125One/CshZ99HECsNFB3t96SG8dwcaT7EUo9VQt4e4t
X-Gm-Gg: Acq92OEja/LZFniE8r/mTsHVMokAaV4qu7fdnhvll0RKI/3QhSZ0KZQpgiZO2L4dXmM
 bQL9BQ+px1uMI+N8l7fnnIp3DbR8xR8qRFUTvhoYKwkkyE/xbKkBWpGo05CsmAFLFC1KNX402zb
 Xg7Ec2mtpSVVr96M29KhyRs6AAgP//MdTPRdxFSzjJJfK5cfKCeraxw670BDffrZVO3+PN9lARg
 X9b2UA8G5es3Gy3iNIeEE5TZSGSQh1LkFS0caBrbLl6Q/epZZy8horbqDea+GAZSu0FyK/hPiuq
 MsNdID24XQnI8yrcZubJ1YP6ZBha6ExH7CU5BuWYVBiWh0IHknSmy+++ISzgTNLK1cRL92Wg3x2
 aGa6ziCrGJp3rR0vYHNYXDuAO0zqTDC5ZalC/kW7QYFQmR5X7NTrh+A==
X-Received: by 2002:a05:6000:2083:b0:460:11bd:3fde with SMTP id
 ffacd0b85a97d-46032da2286mr30480778f8f.13.1781108295076; 
 Wed, 10 Jun 2026 09:18:15 -0700 (PDT)
X-Received: by 2002:a05:6000:2083:b0:460:11bd:3fde with SMTP id
 ffacd0b85a97d-46032da2286mr30480726f8f.13.1781108294484; 
 Wed, 10 Jun 2026 09:18:14 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dc412sm75691339f8f.4.2026.06.10.09.18.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:18:13 -0700 (PDT)
Date: Wed, 10 Jun 2026 12:18:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Gavin Shan <gshan@redhat.com>, Pavel Hrdina <phrdina@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, jugraham@redhat.com,
 shan.gavin@gmail.com, Alex Williamson <alex@shazbot.org>,
 David Hildenbrand <david@kernel.org>
Subject: Re: [PATCH RFCv1] virtio: Inherit max bounce buffer size from bus
 parent if possible
Message-ID: <20260610121026-mutt-send-email-mst@kernel.org>
References: <07ca74b4-52a8-4187-a57c-7c3277e574d3@redhat.com>
 <aiky9d9IwACIyKEC@phrdina-thinkpadt14gen4.rmtcz.csb>
 <674d5e21-88fa-4a10-a83c-eb6f7ce7032f@redhat.com>
 <20260610080947-mutt-send-email-mst@kernel.org>
 <eb0f0da1-11dd-4437-94fd-a65af55851e1@redhat.com>
 <20260610082637-mutt-send-email-mst@kernel.org>
 <5d8cbd4b-3725-437e-88a3-e0af32164815@redhat.com>
 <e7cc9f2d-ccb4-442f-a1ed-7c5474395099@redhat.com>
 <20260610095712-mutt-send-email-mst@kernel.org>
 <aimEl9QQ_LTRPLtd@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aimEl9QQ_LTRPLtd@x1.local>
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

On Wed, Jun 10, 2026 at 11:36:55AM -0400, Peter Xu wrote:
> On Wed, Jun 10, 2026 at 10:06:24AM -0400, Michael S. Tsirkin wrote:
> > On Wed, Jun 10, 2026 at 11:54:47PM +1000, Gavin Shan wrote:
> > > Hi Michael and Peter,
> > > 
> > > On 6/10/26 11:00 PM, Gavin Shan wrote:
> > > > On 6/10/26 10:27 PM, Michael S. Tsirkin wrote:
> > > > > On Wed, Jun 10, 2026 at 10:19:31PM +1000, Gavin Shan wrote:
> > > > > > On 6/10/26 10:12 PM, Michael S. Tsirkin wrote:
> > > > > > > On Wed, Jun 10, 2026 at 08:55:10PM +1000, Gavin Shan wrote:
> > > > > > > > On 6/10/26 7:54 PM, Pavel Hrdina wrote:
> > > > > > 
> > > > > > [...]
> > > > > > 
> > > > > > > > > 
> > > > > > > > > You did not answer the question that Daniel was asking, how will user
> > > > > > > > > know that max-bounce-buffer-size should be used if it's necessary to fix
> > > > > > > > > guest system hangs and how will user know what magic value should be set?
> > > > > > > > > 
> > > > > > > > 
> > > > > > > > Sorry that I missed to answer Daniel's questions. For this specific case,
> > > > > > > > user need to enlarge the bounce buffer size when seeing the following error
> > > > > > > > message. We can add an explicit one in address_space_map() if the existing
> > > > > > > > error message isn't obvious.
> > > > > > > > 
> > > > > > > >     qemu-system-aarch64: virtio: bogus descriptor or out of resources
> > > > > > > > 
> > > > > > > >     void *address_space_map(AddressSpace *as,
> > > > > > > >                           hwaddr addr,
> > > > > > > >                           hwaddr *plen,
> > > > > > > >                           bool is_write,
> > > > > > > >                           MemTxAttrs attrs)
> > > > > > > >     {
> > > > > > > >         if (!memory_access_is_direct(mr, is_write, attrs)) {
> > > > > > > >             if (l == 0) {
> > > > > > > >                 error_report("Running out of bounce buffer size , enlarge it with max-bounce-buffer-size");
> > > > > > > >                 *plen = 0;
> > > > > > > >                 return NULL;
> > > > > > > >             }
> > > > > > > >         }
> > > > > > > > 
> > > > > > > > As to the value user should take for max-bounce-buffer-size, it is really case by case
> > > > > > > > and decided by user. User needs to try 4096, 8192, ..., 0xFFFFFFFF to figure out the
> > > > > > > > smallest value works for them. The worst case is to set 0xFFFFFFFF.
> > > > > > > > 
> > > > > > > 
> > > > > > > 
> > > > > > > This is not at all reasonable. All kind of fixes are possible but
> > > > > > > fundamentally, bounce buffering data path is by itself already a
> > > > > > > bad idea.
> > > > > > > 
> > > > > > > I have no idea what does bounce buffering device ram accomplish.
> > > > > > > 
> > > > > > > In the end, qemu still simply reads the memory from/to the buffer.
> > > > > > > 
> > > > > > > My suggestion is to first of all look for ways to mark the
> > > > > > > memory as direct.
> > > > > > > 
> > > > > > 
> > > > > > As I explained to Peter Xu in another reply, we can't simply mark the (RAM
> > > > > > DEVICE) memory region is directly accessible. The memory region is initialized
> > > > > > by memory_region_init_ram_device_ptr() in hw/vfio/region.c::vfio_region_mmap().
> > > > > > 
> > > > > > The  accesses to the memory region is handled by 'ram_device_mem_ops' where
> > > > > > {ldn, stn}_he_p() are used in its read/write handler. They're different
> > > > > > from memcpy() since the data endianness is well handled in {ldn, stn}_he_p().
> > > > > > 
> > > > > > Thanks,
> > > > > > Gavin
> > > > > > 
> > > > > 
> > > > > What is endianness set to, for this region?
> > > > > 
> > > > 
> > > > The endianness of the memory region is set to that for the host.
> > > > 
> > > > static const MemoryRegionOps ram_device_mem_ops = {
> > > >      .read = memory_region_ram_device_read,
> > > >      .write = memory_region_ram_device_write,
> > > >      .endianness = HOST_BIG_ENDIAN ? DEVICE_BIG_ENDIAN : DEVICE_LITTLE_ENDIAN,
> > > > };
> > > > 
> > 
> > So there is never any endianness translation.
> > I think the reason qemu does the bounce buffer is more
> > to prevent things like vector access from MMIO.
> > 
> > 
> > > How about to treat the RAM DEVICE memory region directly accessible in
> > > address_space_map() only when HOST_BIG_ENDIAN is false,
> > > something like
> > > below and I don't hit the guest hang issue with the changes.
> > > 
> > > diff --git a/include/system/memory.h b/include/system/memory.h
> > > index 1417132f6d..9daca55251 100644
> > > --- a/include/system/memory.h
> > > +++ b/include/system/memory.h
> > > @@ -2908,7 +2908,8 @@ void *qemu_map_ram_ptr(RAMBlock *ram_block, ram_addr_t addr);
> > >  int memory_access_size(MemoryRegion *mr, unsigned l, hwaddr addr);
> > >  bool prepare_mmio_access(MemoryRegion *mr);
> > > -static inline bool memory_region_supports_direct_access(const MemoryRegion *mr)
> > > +static inline bool memory_region_supports_direct_access(const MemoryRegion *mr,
> > > +                                                        bool check_ram_device)
> > >  {
> > >      /* ROM DEVICE regions only allow direct access if in ROMD mode. */
> > >      if (memory_region_is_romd(mr)) {
> > > @@ -2922,13 +2923,14 @@ static inline bool memory_region_supports_direct_access(const MemoryRegion *mr)
> > >       * be MMIO and access using mempy can be wrong (e.g., using instructions not
> > >       * intended for MMIO access). So we treat this as IO.
> > >       */
> > > -    return !memory_region_is_ram_device(mr);
> > > +    return (!check_ram_device || !memory_region_is_ram_device(mr));
> > >  }
> > >  static inline bool memory_access_is_direct(const MemoryRegion *mr,
> > > +                                           bool check_ram_device,
> > >                                             bool is_write, MemTxAttrs attrs)
> > >  {
> > > -    if (!memory_region_supports_direct_access(mr)) {
> > > +    if (!memory_region_supports_direct_access(mr, check_ram_device)) {
> > >          return false;
> > >      }
> > > diff --git a/system/physmem.c b/system/physmem.c
> > > index 7bcbf87573..2e6b72b124 100644
> > > --- a/system/physmem.c
> > > +++ b/system/physmem.c
> > > @@ -3724,7 +3724,7 @@ void *address_space_map(AddressSpace *as,
> > >      fv = address_space_to_flatview(as);
> > >      mr = flatview_translate(fv, addr, &xlat, &l, is_write, attrs);
> > > -    if (!memory_access_is_direct(mr, is_write, attrs)) {
> > > +    if (!memory_access_is_direct(mr, HOST_BIG_ENDIAN, is_write, attrs)) {
> > >          size_t used = qatomic_read(&as->bounce_buffer_size);
> > >          for (;;) {
> > >              hwaddr alloc = MIN(as->max_bounce_buffer_size - used, l);
> > > 
> > > Thanks,
> > > Gavin
> > > 
> > 
> > I do not think it has anything to do with host endian-ness.
> > 
> > 
> > This is the change that broke it I think?
> > 
> > 
> > commit 4a2e242bbb306ef5c16ce9e7bb2da3bd8a4eb098
> > Author: Alex Williamson <alex@shazbot.org>
> > Date:   Mon Oct 31 09:53:03 2016 -0600
> > 
> >     memory: Don't use memcpy for ram_device regions
> >     
> > 
> > Maybe Alex has an opinion on what to do.
> 
> I can offer one idea here..
> 
> IIUC the major issue was vector ops but the mr ops might be too heavy, then
> another way to fix it is in memory API instead of using memcpy()/memmove(),
> we always use a helper (say, memmove_no_vector()) to do the split and
> properly aligned IOs as what ram_device_mem_ops does right now, this should
> only applies to ram_device.
> 
> With that, IIUC we can remove the current ram_device_mem_ops, then in
> Gavin's case mmap() will go through and guest will not need to vmexit at
> all.  Best perf, issue solve.
> 
> We just need to be careful to trap all possible memcpy()/memmove() used in
> memory core.. if I didn't miss any, IMO below four should needs to be
> replaced by memmove_no_vector():
> 
>   flatview_write_continue_step()
>   flatview_read_continue_step()
>   address_space_read()
>   address_space_write_rom()
> 
> Thanks,
> 
> -- 
> Peter Xu

First, this is a nice idea.
Second, the ideal thing is still just allowing direct access.
And I think VFIO actually knows it's regular RAM.
So something like the following small patch in linux, maybe?


diff --git a/drivers/vfio/pci/nvgrace-gpu/main.c b/drivers/vfio/pci/nvgrace-gpu/main.c
index fa056b69f899..a4ca2d01272c 100644
--- a/drivers/vfio/pci/nvgrace-gpu/main.c
+++ b/drivers/vfio/pci/nvgrace-gpu/main.c
@@ -418,6 +418,10 @@ static int nvgrace_gpu_ioctl_get_region_info(struct vfio_device *core_vdev,
 	struct nvgrace_gpu_pci_core_device *nvdev =
 		container_of(core_vdev, struct nvgrace_gpu_pci_core_device,
 			     core_device.vdev);
+	struct vfio_region_info_cap_direct_access direct_access = {
+		.header.id = VFIO_REGION_INFO_CAP_DIRECT_ACCESS,
+		.header.version = 1,
+	};
 	struct vfio_region_info_cap_sparse_mmap *sparse;
 	struct mem_region *memregion;
 	u32 size;
@@ -453,6 +457,13 @@ static int nvgrace_gpu_ioctl_get_region_info(struct vfio_device *core_vdev,
 	if (ret)
 		return ret;
 
+	if (info->index == USEMEM_REGION_INDEX) {
+		ret = vfio_info_add_capability(caps, &direct_access.header,
+					       sizeof(direct_access));
+		if (ret)
+			return ret;
+	}
+
 	info->offset = VFIO_PCI_INDEX_TO_OFFSET(info->index);
 	/*
 	 * The region memory size may not be power-of-2 aligned.
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 5de618a3a5ee..f475f4920b52 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -466,6 +466,16 @@ struct vfio_device_migration_info {
  */
 #define VFIO_REGION_INFO_CAP_MSIX_MAPPABLE	3
 
+/*
+ * The direct access capability informs that a mmappable region may be
+ * accessed by userspace using any CPU load/store operations.
+ */
+#define VFIO_REGION_INFO_CAP_DIRECT_ACCESS	6
+
+struct vfio_region_info_cap_direct_access {
+	struct vfio_info_cap_header header;
+};
+
 /*
  * Capability with compressed real address (aka SSA - small system address)
  * where GPU RAM is mapped on a system bus. Used by a GPU for DMA routing


