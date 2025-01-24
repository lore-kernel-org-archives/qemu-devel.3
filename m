Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D26C0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 10:00:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbGTi-0004X2-Fr; Fri, 24 Jan 2025 04:59:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tbGTe-0004ST-Cn
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:59:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tbGTb-0005d5-KN
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:59:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737712786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fLyi288OFVCUry8y2K0wbWCsYK43wUIB0XTCIHFOqk8=;
 b=XQldqotZgh1IgQ3jmrszYUmfXNsrNX1CS18CoDRByP37doEjxaCEYfHrUSQnkACjQC7/+g
 8PRAMJ82Z1e8zp1/Hi0ssvK2OyEwGEBX0AVoC2xNj04fN2HhvxNRoeWn9zO9zeXxj5GJEo
 e2Vyoattud69mX7SCqpk3hy6S0KXfwc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-dNqQzfotN-yGvWbODEDSIQ-1; Fri, 24 Jan 2025 04:59:44 -0500
X-MC-Unique: dNqQzfotN-yGvWbODEDSIQ-1
X-Mimecast-MFC-AGG-ID: dNqQzfotN-yGvWbODEDSIQ
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43619b135bcso8860265e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 01:59:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737712783; x=1738317583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fLyi288OFVCUry8y2K0wbWCsYK43wUIB0XTCIHFOqk8=;
 b=GteETFHs1CDfEc/XMXinKopJF8dLRmheRiVGpGt80KJ7eHaY+dfptkhlGDekWw8lsW
 rJgU2jIzTKs3hF9R/BX0BP7zuVRbe/mnrl6Yc8AqcpNbwe2uK9kw1i86K+OEkP580S0/
 H4C6DHNgIwLw/pfO3nq8W+2NGlXKx6qadT77+wv060qSPI3Ag5gRc8QD9tdEtZzwFPrQ
 6QpLy9cpiv0PS0bKiRV0ViUfvwgNb9g3/10IFfS12Bs4Ic3OS+jM7OMNzhbdJDMnKDmR
 GlKgm2CjdZpNH5a60B4pUoDRuRZNC2bBumnX10SKrdTD03R6vxJsK6tjUQg4T14bVVIb
 cWIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUijpPF6uPp5Xl0XuFT6H93BvHsIvwmvxKXPyG0jj/DornC6BqhDCoi/AX0AMh4PytuBkXTsKY8JsDr@nongnu.org
X-Gm-Message-State: AOJu0YzS39ABG3YK3ojAnSFvBUuAFhtHD1QZcXPQELiBwy+steeAQ6kM
 3aadNgJgbcU4fb6YHDOKL53C6ziwhG+x1j95ljq4O1duHGv2oR7Zk4J3xddFwT+kO13pTKK1K6Z
 Wz9MbkkkKc75Pizet65QyIV0r09wi0zici0d1bgLL52zYIW4uCvZM
X-Gm-Gg: ASbGncts/X5wvbthW6og+uMwqozEcxS6fGEtJgqYE4U88HhDi0Hi+Qc0Kykk9vzNyI1
 t4DCZ74DMTZM2gR2V1oiwaxxEao0G4BUKiuiaKvD5MU2oBq3mhlrA704D4l1LBy5AxAUNkozAaN
 OfkYP2fq7FzxHGeNXP1zb39wwxyOvFZA+r2sY07ks07c9krVMBwrahcobhkSNpSsnSLKF/DT67h
 yWWFv36bWXZcYrLqMK2k9aaY3o9bO/j5akNNzcrqeSlwuuq1KdxOppwlt1upLm7AY9yIMR+h9Vp
 E4ePNcwDhSwULOD04Wusq41uA7PUfGojlyJp9e4P3A==
X-Received: by 2002:a5d:4303:0:b0:385:f892:c8fe with SMTP id
 ffacd0b85a97d-38bf566b62dmr22843916f8f.21.1737712782964; 
 Fri, 24 Jan 2025 01:59:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKKig4caM90iVjZ3o3M3QNMdPDL6memJZMfCmIgK86INHvR9CvR00aqMbkrq5OClKi6jZltA==
X-Received: by 2002:a5d:4303:0:b0:385:f892:c8fe with SMTP id
 ffacd0b85a97d-38bf566b62dmr22843891f8f.21.1737712782527; 
 Fri, 24 Jan 2025 01:59:42 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a17d6besm2201954f8f.27.2025.01.24.01.59.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 01:59:41 -0800 (PST)
Date: Fri, 24 Jan 2025 10:59:40 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/11] acpi/ghes: Use HEST table offsets when preparing
 GHES records
Message-ID: <20250124105940.6d2a3460@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250123192350.6db42016@foz.lan>
References: <cover.1737560101.git.mchehab+huawei@kernel.org>
 <10a8a913862c9cc894235d32b10bbf2f992340ff.1737560101.git.mchehab+huawei@kernel.org>
 <20250123102919.000044c9@huawei.com>
 <20250123192350.6db42016@foz.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, 23 Jan 2025 19:23:50 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Thu, 23 Jan 2025 10:29:19 +0000
> Jonathan Cameron <Jonathan.Cameron@huawei.com> escreveu:
> 
> > On Wed, 22 Jan 2025 16:46:20 +0100
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> >   
> > > There are two pointers that are needed during error injection:
> > > 
> > > 1. The start address of the CPER block to be stored;
> > > 2. The address of the ack, which needs a reset before next error.

drop sentence after comma as it's not necessary (and confusing detail)

> > > 
> > > It is preferable to calculate them from the HEST table.  This allows
> > > checking the source ID, the size of the table and the type of the
> > > HEST error block structures.
> > > 
> > > Yet, keep the old code, as this is needed for migration purposes.
> > > 
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>    
> > Generally looks good.  A few bits that I think could be made
> > easier to follow for anyone with the spec open in front of them.
> > 
> > Thanks,
> > 
> > Jonathan
> >   
> > > ---
> > >  hw/acpi/ghes.c | 98 ++++++++++++++++++++++++++++++++++++++++++++------
> > >  1 file changed, 88 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> > > index 34e3364d3fd8..b46b563bcaf8 100644
> > > --- a/hw/acpi/ghes.c
> > > +++ b/hw/acpi/ghes.c
> > > @@ -61,6 +61,23 @@
> > >   */
> > >  #define ACPI_GHES_GESB_SIZE                 20
> > >  
> > > +/*
> > > + * Offsets with regards to the start of the HEST table stored at
> > > + * ags->hest_addr_le, according with the memory layout map at
> > > + * docs/specs/acpi_hest_ghes.rst.
> > > + */
> > > +
> > > +/* ACPI 6.2: 18.3.2.8 Generic Hardware Error Source version 2    
> > 
> > Local multiline comment style seems to be always
> > /*
> >  * ACPI 6.2:...
> > 
> > So perhaps good to copy that.
> >   
> > > + * Table 18-382 Generic Hardware Error Source version 2 (GHESv2) Structure
> > > + */
> > > +#define HEST_GHES_V2_TABLE_SIZE  92
> > > +#define GHES_ACK_OFFSET          (64 +   
> )  
> > 
> > Using a GAS offset here to me obscures what is going on.  I'd
> > explicitly handle the GAS where you are reading this.
> > We probably should sanity check the type as there are
> > some crazy options that might turn up one day.  
> 
> See below.
> 
> > Maybe worth using spec term of
> > GHES_READ_ACK_...
> > 
> > Obviously it's a question of who you are for whether it is read or
> > write, but maybe still worth using that term for easy checking
> > against the specification.
> >   
> > > +
> > > +/* ACPI 6.2: 18.3.2.7: Generic Hardware Error Source    
> > same on comment format.
> >   
> > > + * Table 18-380: 'Error Status Address' field
> > > + */
> > > +#define GHES_ERR_ST_ADDR_OFFSET  (20 + GAS_ADDR_OFFSET)    
> > Maybe STS or spell out status? I found ST a bit confusing below.  
> 
> Giving names is not an easy task... Removing _ST doesn't sound
> right, as everything is GHES_ERR. STS sounds weird to me as well.
> Maybe we could name them both as something like:
> 
> 	GHES_ERR_STATUS_ADDR_OFF
> 	GHES_READ_ACK_ADDR_OFF

lgtm

>  
> > > +
> > >  /*
> > >   * Values for error_severity field
> > >   */
> > > @@ -212,14 +229,6 @@ static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker,
> > >  {
> > >      int i, error_status_block_offset;
> > >  
> > > -    /*
> > > -     * TODO: Current version supports only one source.
> > > -     * A further patch will drop this check, after adding a proper migration
> > > -     * code, as, for the code to work, we need to store a bios pointer to the
> > > -     * HEST table.
> > > -     */
> > > -    assert(num_sources == 1);
> > > -
> > >      /* Build error_block_address */
> > >      for (i = 0; i < num_sources; i++) {
> > >          build_append_int_noprefix(hardware_errors, 0, sizeof(uint64_t));
> > > @@ -419,6 +428,70 @@ static void get_hw_error_offsets(uint64_t ghes_addr,
> > >      *read_ack_register_addr = ghes_addr + sizeof(uint64_t);
> > >  }
> > >  
> > > +static void get_ghes_source_offsets(uint16_t source_id, uint64_t hest_addr,
> > > +                                    uint64_t *cper_addr,
> > > +                                    uint64_t *read_ack_start_addr,
> > > +                                    Error **errp)
> > > +{
> > > +    uint64_t hest_err_block_addr, hest_read_ack_addr;
> > > +    uint64_t err_source_struct, error_block_addr;
> > > +    uint32_t num_sources, i;
> > > +
> > > +    if (!hest_addr) {    
> > I guess it is a question of matching local code, but I'd be tempted
> > to name this hest_body_addr as it isn't the start of the table but
> > rather the bit after the header.  
> 
> This is named after hest_addr_le, which in turn was named after ghes_hw_le.
> 
> Besides, I guess such name was suggested on a past review. From my side, 
> I'm OK with any name you/Igor pick.
> 
> >   
> > > +        return;
> > > +    }
> > > +
> > > +    cpu_physical_memory_read(hest_addr, &num_sources, sizeof(num_sources)); 


if it were the HEST table addr, then hest_addr name is ok
however in that case you are reading value of "Header Signature" into num_sources.
Which makes me think there is a bug here as one should read hest_addr + num_src_off

   
> > 
> > The hest_addr naming thing confused me a tiny bit here because obviously num_sources
> > isn't the first thing in the table in the spec!
> >   
> > > +    num_sources = le32_to_cpu(num_sources);
> > > +
> > > +    err_source_struct = hest_addr + sizeof(num_sources);
the same issue wrt correct offset

> > > +
> > > +    /*
> > > +     * Currently, HEST Error source navigates only for GHESv2 tables
> > > +     */
> > > +
> > > +    for (i = 0; i < num_sources; i++) {
> > > +        uint64_t addr = err_source_struct;
> > > +        uint16_t type, src_id;
> > > +
> > > +        cpu_physical_memory_read(addr, &type, sizeof(type));
> > > +        type = le16_to_cpu(type);
> > > +
> > > +        /* For now, we only know the size of GHESv2 table */
> > > +        if (type != ACPI_GHES_SOURCE_GENERIC_ERROR_V2) {
> > > +            error_setg(errp, "HEST: type %d not supported.", type);
> > > +            return;    
> > 
> > It's a pity we can't just skip them, but absence of a size field
> > makes that tricky...  Can add that later I guess along with sizes
> > for each defined type including figuring out the variable length
> > ones like IA-32 machine check.  I guess this is why the whole ordering
> > constraint for new types was added. Can't find the old ones if
> > we don't know the size of the new ones, hence need new definitions
> > at the end.

this error out may cause parsing issues in the future when migrating from
new to old QEMU (but at least it's not fatal),
So I've given up on pushing for graceful 'skip' of not handled entries.
(considering backward migration is not hard req for upstream qemu)

Though, tt's would be nice to have it in the same merge cycle as patch on top
if possible.

> Yes. The variable sizes makes it harder to parse with current GHES
> types. It sounds they'll fix it for the next types, as the size of
> the record will be stored for types above 11.
> 
> So, at the end, we'll need to add a much more complex logic if/when
> we add non-GHES records.
> 
> > 
> > Anyhow, I'm fine with this but maybe a little more description in the comment
> > would avoid someone going down same rat hole I just did.
> > 
> >   
> > > +        }
> > > +
> > > +        /* Compare CPER source address at the GHESv2 structure */
> > > +        addr += sizeof(type);
> > > +        cpu_physical_memory_read(addr, &src_id, sizeof(src_id));
> > > +
> > > +        if (src_id == source_id) {

missing le2cpu(src_id) here ???

> > > +            break;
> > > +        }
> > > +
> > > +        err_source_struct += HEST_GHES_V2_TABLE_SIZE;
> > > +    }
> > > +    if (i == num_sources) {
> > > +        error_setg(errp, "HEST: Source %d not found.", source_id);
> > > +        return;
> > > +    }
> > > +
> > > +    /* Navigate though table address pointers */
> > > +    hest_err_block_addr = err_source_struct + GHES_ERR_ST_ADDR_OFFSET;    
> > 
> > So this is a bit confusing. I'd pull the GAS offset down here rather
> > than putting it in the define. That way we can clearly see you
> > are grabbing the address field.  As above, should we check the type
> > is 0x00?  There are many fun things it could be but here I think
> > we just want it to be memory space.  
> 
> In short:
> 
> The type was already ensured when HEST table is built. I can't see
> any need to add extra checks. If you want this to be better documented,
> we could just do:
> 

1)
> 	hest_err_block_addr = err_source_struct + GHES_ERR_STATUS_ADDR_OFF + GAS_OFFSET;
I'd prefer this, _ST_ part in GHES_ERR_ST_ADDR_OFFSET also reads to me a bit confusing.


> It follows a longer rationale:
> 
> If I understood well, and after some discussions we had today via chat,
> you basically want to add an additional check logic during error inject
> to check if the memory type filled at build_ghes_v2() here:
> 
> 	/* Build Generic Hardware Error Source version 2 (GHESv2) */
> 	static void build_ghes_v2(GArray *table_data,
> 	                          BIOSLinker *linker,
>        		                  const AcpiNotificationSourceId *notif_src,
>                 	          uint16_t index, int num_sources)
> 	{
> ...
> 	    /* Error Status Address */
> 	    build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 0x40, 0,
> ...
> 	    /*
> 	     * Read Ack Register 
> 	     * ACPI 6.1: 18.3.2.8 Generic Hardware Error Source
> 	     * version 2 (GHESv2 - Type 10)
> 	     */
> 	   build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 0x40, 0,
>                      4 /* QWord access */, 0);
> ...
> 	}
> 
> was not modified and still remains AML_AS_SYSTEM_MEMORY, as otherwise the
> code at get_ghes_source_offsets() won't be able to use 
> cpu_physical_memory_read/cpu_physical_memory_write. To make it right,
> IMO we would need to add something like this to aml-build.c:
> 
> 	int verify_gas_addr_space(uint64_t addr, AmlAddressSpace as)
> 	{
> 		uint64_t gas_header;
> 
> 		cpu_physical_memory_read(addr, &gas_header, 4);
> 		gas_header = cpu_to_le64(0);
> 
> 		if ((gas_header & 0xff) != as)
> 			return 1;
> 
> 		return 0;
> 	}
> 
> and at ghes.c do something like:
> 
> 	// Using current names just to better illustrate the changes
> 	#define GHES_ACK_OFFSET          64 // don't add GAS_ADDR_OFFSET here
> 	#define GHES_ERR_ST_ADDR_OFFSET  20 // don't add GAS_ADDR_OFFSET here
> 
> 	static void get_ghes_source_offsets(uint16_t source_id, uint64_t hest_addr,
> 	                                    uint64_t *cper_addr,
> 	       	                            uint64_t *read_ack_start_addr,
> 	                                    Error **errp)
> 	{
>  
> 	    /* Navigate though table address pointers */
> 	    hest_err_block_addr = err_source_struct + GHES_ERR_ST_ADDR_OFFSET;
> 
> 	    /* EXTRA CHECK LOGIC: Verify if build_ghes_v2() did his job */
> 	    if (verify_gas_addr_space(hest_err_block_addr, AML_AS_SYSTEM_MEMORY)} {
> 		error_setg(errp, "HEST firmware is not using system memory!!!");
> 		return;
> 	    }
> 	    hest_err_block_addr += GAS_ADDR_OFFSET;
> 
> 	    hest_read_ack_addr = err_source_struct + GHES_ACK_OFFSET;
> 
> 	    /* EXTRA CHECK LOGIC: Verify if build_ghes_v2() did his job */
> 	    if (verify_gas_addr_space(hest_read_ack_addr, AML_AS_SYSTEM_MEMORY)} {
> 		error_setg(errp, "HEST firmware is not using system memory!!!");
> 		return;
> 	    }
> 	    hest_read_ack_addr += GAS_ADDR_OFFSET;
> 
> 	    cpu_physical_memory_read(hest_err_block_addr, &error_block_addr,
> 	                             sizeof(error_block_addr));
> 
> 	    cpu_physical_memory_read(error_block_addr, cper_addr,
> 	                             sizeof(*cper_addr));
> 
> 	    cpu_physical_memory_read(hest_read_ack_addr, read_ack_start_addr,
> 	                             sizeof(*read_ack_start_addr));
> 	}
> 
> IMO, this is overkill:
> - I can't see how such check will ever be triggered in practice;
> - I can't see any reason why the HEST firmware would ever be stored
>   on a non-system memory: firmware should always be at 
>   AML_AS_SYSTEM_MEMORY;
> - As those offsets are related to fw_cfg, any change there would
>   require changing the firmware binding logic. Plus, they'll very
>   likely also require changes at BIOS code itself, as it would need
>   to know how to store firmware files on some other memory type;
> - Any change like that will certainly require adding backport support,
>   as QEMU would need to check if BIOS would support different types
>   of memory to store firmware instead of system memory. Also, QEMU 9.1
>   is only compatible with firmware stored on system's memory. 
> 
> So, I don't see any benefit of doing that.

+1

> 
> > > +    hest_read_ack_addr = err_source_struct + GHES_ACK_OFFSET;    
> > 
> > Perhaps move this down to above where it is used?
> > Same thing about GAS address offset being better found down here
> > rather than hidden in GHES_ACK_OFFSET.

I'd treat it the same as [1]

> >   
> > > +
> > > +    cpu_physical_memory_read(hest_err_block_addr, &error_block_addr,
> > > +                             sizeof(error_block_addr));
> > > +
> > > +    cpu_physical_memory_read(error_block_addr, cper_addr,
> > > +                             sizeof(*cper_addr));
> > > +
> > > +    cpu_physical_memory_read(hest_read_ack_addr, read_ack_start_addr,
> > > +                             sizeof(*read_ack_start_addr));
> > > +}
> > > +
> > >  void ghes_record_cper_errors(const void *cper, size_t len,
> > >                               uint16_t source_id, Error **errp)
> > >  {
> > > @@ -439,8 +512,13 @@ void ghes_record_cper_errors(const void *cper, size_t len,
> > >      }
> > >      ags = &acpi_ged_state->ghes_state;
> > >  
> > > -    get_hw_error_offsets(le64_to_cpu(ags->hw_error_le),
> > > -                         &cper_addr, &read_ack_register_addr);

> > > +    if (!ags->hest_addr_le) {
> > > +        get_hw_error_offsets(le64_to_cpu(ags->hw_error_le),
> > > +                             &cper_addr, &read_ack_register_addr);
> > > +    } else {
> > > +        get_ghes_source_offsets(source_id, le64_to_cpu(ags->hest_addr_le),
> > > +                                &cper_addr, &read_ack_register_addr, errp);
> > > +    }
> > >  

it looks like returned addresses in le byteorder, and then caller uses
them as is to access memory, where as it should use le2cpu on them 1st.
I'd add here conversion so the caller would deal only with host byteorder
(i.e. the same way as get_hw_error_offsets())

> > >      if (!cper_addr) {
> > >          error_setg(errp, "can not find Generic Error Status Block");    
> >   
> 
> 
> 
> Thanks,
> Mauro
> 


