Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 566D3CCD18E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 09:03:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8avU-0007xW-Bl; Tue, 14 Oct 2025 05:02:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v8avT-0007xO-LD
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 05:02:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v8avQ-0008OA-W7
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 05:02:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760432548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LiLslDLnwEu51BlYuIo+vS5jwZcTrDngM+zyGz6eAx0=;
 b=ctRbE5knnTR3EgYRHsLM5d0S35BbVPJ7nxa0uEwaY8BChkxoQcYXhkWZoBUr5eNDYeQ19U
 AEAghVbgIcgjJjCt0KjUAPgYdOq9pRfiiVKr9/0C6LpfoDj87QSme39+qjdOWNbmWqMsBh
 hLUUi8jd1dcpP2DbzK64nIbPvU1VvLk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-7lNohgqOM1SPduj2OxnUOA-1; Tue, 14 Oct 2025 05:02:26 -0400
X-MC-Unique: 7lNohgqOM1SPduj2OxnUOA-1
X-Mimecast-MFC-AGG-ID: 7lNohgqOM1SPduj2OxnUOA_1760432545
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-46e39567579so25863675e9.0
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 02:02:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760432545; x=1761037345;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LiLslDLnwEu51BlYuIo+vS5jwZcTrDngM+zyGz6eAx0=;
 b=UeNvUmgxooP8bBkCXSPZkwubtSvaKhjljgKGE4ZYurhYe1Cor1LFPzlGFrwvEIGYO0
 7onL7kuJ8ieloxMbYT77UJyqmhZnE0HMithldyqz1KCrpDJgMm131W+CUs0/1yMeq2s0
 gPPZuzpwN47qLocWKSjOnle4KeV3BWdcqRE0rte8jmA/gmhJRRaHhzpnpHPsS5R/dU+u
 HHeV7ceBStckkFTaSLClgzGRMdtlS6K/c9Dmi34tlljk+2I20tGUDQTHsvjaK5p4ouOR
 yi5S/YtZdkgSbMb6EqPtr/Wn+k6muayr57NxokZRGqBxD9ZMSkvJedBhXWhmTD2sUIb9
 FCTg==
X-Gm-Message-State: AOJu0YzAZ4I3u5xTlE2SDLaMnbIKH5d20GCEJ3FECDk7bYVy3YxeQNUT
 PSBrHycJ/EYtPDEDVNmtdL7B6LOXi63svXf8cLep036wh4H4Cr7AJChCgf/TbU6R02/7UwzSHyW
 wwUN8tIe4ZdLjGEOhJ2DMG9bN+ZXjzI8OTrFk223Ilq9H3ACuLGBZlEY+
X-Gm-Gg: ASbGnctmGxzYbZvvpIAD+doL+OGz/PmBS0hyUni3rFB1aarubf59ABFKAhV/ycc0IA9
 FuC/JEf/4+8RyVZeefauLOp7UGoAVm1QY1hqo7na6TDw65KobpNQuXuCk0BF+exyQ9+PW7Ha+9b
 CAw69ELZBRvaLJGUhY8LdOaVL/iJCN5NlwptR3gRvLB08Fv325hxYTzu43/Hl7wh374S0HNtFXz
 z8eylYp9hzXpZOewEzrm1y0I+I0B6D4I65KFthMj/+eCujbSNWOF43PcqBR5c/yO6ZcsxC/81Gg
 fubpkMaKcGrc98YhjfEWuYeATbJOoSCZPg==
X-Received: by 2002:a05:600d:14:b0:46e:74cc:42b8 with SMTP id
 5b1f17b1804b1-46fa9af831cmr124462605e9.17.1760432545200; 
 Tue, 14 Oct 2025 02:02:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzaGP2aI/g2tib/Cc2qc/D8OSIuZMahe7v9u8fSLDNBh8lTJgJ8TuYgr/K/wVe28KAWwpKRA==
X-Received: by 2002:a05:600d:14:b0:46e:74cc:42b8 with SMTP id
 5b1f17b1804b1-46fa9af831cmr124462355e9.17.1760432544700; 
 Tue, 14 Oct 2025 02:02:24 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fab633cdasm146476365e9.9.2025.10.14.02.02.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 02:02:24 -0700 (PDT)
Date: Tue, 14 Oct 2025 05:02:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sairaj Kodilkar <sarunkod@amd.com>
Cc: qemu-devel@nongnu.org, alejandro.j.jimenez@oracle.com,
 pbonzini@redhat.com, richard.henderson@linaro.org,
 philmd@linaro.org, suravee.suthikulpanit@amd.com,
 vasant.hegde@amd.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, aik@amd.com
Subject: Re: [PATCH v2 1/2] amd_iommu: Fix handling device on buses != 0
Message-ID: <20251014050023-mutt-send-email-mst@kernel.org>
References: <20251013050046.393-1-sarunkod@amd.com>
 <20251013050046.393-2-sarunkod@amd.com>
 <20251013041059-mutt-send-email-mst@kernel.org>
 <6fa9b33c-31ff-43f6-8ab1-8d200c832c94@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fa9b33c-31ff-43f6-8ab1-8d200c832c94@amd.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Oct 14, 2025 at 11:13:51AM +0530, Sairaj Kodilkar wrote:
> 
> 
> On 10/13/2025 1:45 PM, Michael S. Tsirkin wrote:
> > On Mon, Oct 13, 2025 at 10:30:45AM +0530, Sairaj Kodilkar wrote:
> > > The AMD IOMMU is set up at boot time and uses PCI bus numbers + devfn
> > > for indexing into DTE. The problem is that before the guest started,
> > > all PCI bus numbers are 0 as no PCI discovery happened yet (BIOS or/and
> > > kernel will do that later) so relying on the bus number is wrong.
> > > The immediate effect is emulated devices cannot do DMA when places on
> > > a bus other that 0.
> > > 
> > > Replace static array of address_space with hash table which uses devfn and
> > > PCIBus* for key as it is not going to change after the guest is booted.
> > I am curious whether this has any measureable impact on
> > performance.
> 
> I dont think it should have much performance impact, as guest usually has
> small number of devices attached to it and hash has O(1) average search cost
> when hash key function is good.
> 
> > 
> > > Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
> > > Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> > > Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
> > 
> > love the patch! yet something to improve:
> > 
> > > ---
> > >   hw/i386/amd_iommu.c | 134 ++++++++++++++++++++++++++------------------
> > >   hw/i386/amd_iommu.h |   2 +-
> > >   2 files changed, 79 insertions(+), 57 deletions(-)
> > > 
> > > diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> > > index 378e0cb55eab..b194e3294dd7 100644
> > > --- a/hw/i386/amd_iommu.c
> > > +++ b/hw/i386/amd_iommu.c
> > > @@ -59,7 +59,7 @@ const char *amdvi_mmio_high[] = {
> > >   };
> > >   struct AMDVIAddressSpace {
> > > -    uint8_t bus_num;            /* bus number                           */
> > > +    PCIBus *bus;                /* PCIBus (for bus number)              */
> > >       uint8_t devfn;              /* device function                      */
> > >       AMDVIState *iommu_state;    /* AMDVI - one per machine              */
> > >       MemoryRegion root;          /* AMDVI Root memory map region         */
> > > @@ -101,6 +101,11 @@ typedef enum AMDVIFaultReason {
> > >       AMDVI_FR_PT_ENTRY_INV,      /* Failure to read PTE from guest memory */
> > >   } AMDVIFaultReason;
> > > +typedef struct amdvi_as_key {
> > > +    PCIBus *bus;
> > > +    uint8_t devfn;
> > > +} amdvi_as_key;
> > > +
> > >   uint64_t amdvi_extended_feature_register(AMDVIState *s)
> > >   {
> > >       uint64_t feature = AMDVI_DEFAULT_EXT_FEATURES;
> > 
> > Pls fix structure and typedef names according to the QEMU
> > coding style. Thanks!
> > 
> 
> This is something I am struggling with, because the name
> `AMDVIASKey` does not offer readability.

AMDVIAsKey


Or you can update all code to use AmdVi and get AmdViAsKey if you prefer.


> Maybe we can come
> up with an alternate style which is readable and does not
> differ much from the current style.
> 
> @alejandro any suggestions ?
> 
> > > @@ -382,6 +387,44 @@ static guint amdvi_uint64_hash(gconstpointer v)
> > >       return (guint)*(const uint64_t *)v;
> > >   }
> > > +static gboolean amdvi_as_equal(gconstpointer v1, gconstpointer v2)
> > > +{
> > > +    const struct amdvi_as_key *key1 = v1;
> > > +    const struct amdvi_as_key *key2 = v2;
> > > +
> > > +    return key1->bus == key2->bus && key1->devfn == key2->devfn;
> > > +}
> > > +
> > > +static guint amdvi_as_hash(gconstpointer v)
> > > +{
> > > +    const struct amdvi_as_key *key = v;
> > > +    guint bus = (guint)(uintptr_t)key->bus;
> > > +
> > > +    return (guint)(bus << 8 | (uint)key->devfn);
> > > +}
> > > +
> > > +static AMDVIAddressSpace *amdvi_as_lookup(AMDVIState *s, PCIBus *bus,
> > > +                                          uint8_t devfn)
> > > +{
> > > +    amdvi_as_key key = { .bus = bus, .devfn = devfn };
> > > +    return g_hash_table_lookup(s->address_spaces, &key);
> > > +}
> > > +
> > > +gboolean amdvi_find_as_by_devid(gpointer key, gpointer value,
> > > +                                  gpointer user_data)
> > > +{
> > > +    amdvi_as_key *as = (struct amdvi_as_key *)key;
> > this assignment does not need a cast I think.
> > 
> > > +    uint16_t devid = *((uint16_t *)user_data);
> > would be better like this:
> > 	    uint16_t * devidp = user_data;
> > then just use *devidp instead of devid.
> 
> sure
> 
> Thanks
> Sairaj


