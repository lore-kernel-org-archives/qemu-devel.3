Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AAA8C54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 19:15:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhwiu-0005BL-2r; Wed, 06 Mar 2024 14:14:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rhwir-0005Ao-JA
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 14:14:37 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rhwip-0004cS-DH
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 14:14:37 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1dd2c8f1204so565735ad.1
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 11:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709752473; x=1710357273; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pUBbRs3TXEfAU+RwrY6+j24ynxgaMBaWx4dLjG+FWMQ=;
 b=OhslYxKdHLZoMoyylsqkfqvC+KM6hNugmaspF+DkRROpXWL85Quw1UtxSKOapWAzDc
 fvfNyWE/gEj5pYvYY2DeAD+J+sabyB2j1T4ig5Xjrvclewe+mDJbaehDe71HD3eIbreu
 3SOh0dZDZlY702oTKGsef2RgQeT5PVdoDCD92EdiUj8UBhav1OMNTNC+5nw4WQAgl4XZ
 vmHmdFElBY2LSLRaxBNu9/V6AI2XXcy0CrOMeBOJsC9Worcvai+p9kbuRBxPY8uU5yc+
 oeCWI1q0PLNadUr1i2ZHsVv+uRf+PI7WqvsZToDNk7lOmcZ6WV6mRx/CaYpKIUjccguV
 poEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709752473; x=1710357273;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pUBbRs3TXEfAU+RwrY6+j24ynxgaMBaWx4dLjG+FWMQ=;
 b=q1YFxnJW+qA8liTrVuKW9+j5m1kLG7sH/hnSzZrvcTAygtq9jN+6OpzOHJ1OUigMNL
 uEDFOuKjihU9Za4WVLyQwgH0MWtVAuW48g1UUKfImT66XGx9Wimua0L87v7vQZYoda2o
 2BRpqHBisOXkOA2s0Nsx4iWbD4iyNTxKdBMjWwx7WWlPpUo/XUsLIy2L7g5AAvunco1n
 +Sto0w3MuQ/gyWMZwVDClrTOHcC6n8VwtnczaHT+zTphWqRtML6UY28nVFcozudY1sRr
 oqr7g5uEvIanvw1WFhROYbTW8X07Hi8Ia8v2FXppoMeQDO/3RaPx9Pu5tW4xAdYzMwpP
 8axw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZh2uv4iH1AFBSzRChivaHlsEQGE93Jydrtq4i2G/N4Bh3rXo44VRdoegOEVoNuMI2usisKMh32NcX+e5qIGXtaOJ8Rbw=
X-Gm-Message-State: AOJu0YwsQruMmHU251cYNTeRzYbLSH+KgNYl7E6UuzsfnGQ6rYlB+v9m
 6ZDRqppV2OhuPEDFxGMUnMA5hmRy+Bw0DyqVWITXRn5xlrAWra4I
X-Google-Smtp-Source: AGHT+IFdb6YKNEHWAW2buOd891AuhG0NeRVZKROWRhp6MkYOE6yvNsbqmlcyFtznC5qNQwm+MK+j5Q==
X-Received: by 2002:a17:903:22c6:b0:1db:fc05:9596 with SMTP id
 y6-20020a17090322c600b001dbfc059596mr6913125plg.67.1709752473276; 
 Wed, 06 Mar 2024 11:14:33 -0800 (PST)
Received: from debian ([2601:641:300:14de:57cf:345:75f0:2085])
 by smtp.gmail.com with ESMTPSA id
 u5-20020a170902e5c500b001db33112225sm13004469plf.9.2024.03.06.11.14.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 11:14:32 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Wed, 6 Mar 2024 11:14:15 -0800
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: nifan.cxl@gmail.com, qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 gregory.price@memverge.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, a.manzanares@samsung.com,
 dave@stgolabs.net, nmtadam.samsung@gmail.com,
 jim.harris@samsung.com, Jorgen.Hansen@wdc.com, wj28.lee@gmail.com,
 Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v5 06/13] hw/mem/cxl_type3: Add host backend and address
 space handling for DC regions
Message-ID: <ZejAh2O7fDBCcG-N@debian>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
 <20240304194331.1586191-7-nifan.cxl@gmail.com>
 <20240306162816.00002e0e@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306162816.00002e0e@Huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Mar 06, 2024 at 04:28:16PM +0000, Jonathan Cameron wrote:
> On Mon,  4 Mar 2024 11:34:01 -0800
> nifan.cxl@gmail.com wrote:
> 
> > From: Fan Ni <fan.ni@samsung.com>
> > 
> > Add (file/memory backed) host backend, all the dynamic capacity regions
> > will share a single, large enough host backend. Set up address space for
> > DC regions to support read/write operations to dynamic capacity for DCD.
> > 
> > With the change, following supports are added:
> > 1. Add a new property to type3 device "volatile-dc-memdev" to point to host
> >    memory backend for dynamic capacity. Currently, all dc regions share one
> >    host backend.
> > 2. Add namespace for dynamic capacity for read/write support;
> > 3. Create cdat entries for each dynamic capacity region;
> > 4. Fix dvsec range registers to include DC regions.
> > 
> > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> Hi Fan, 
> 
> This one has a few more significant comments inline.
> 
> thanks,
> 
> Jonathan
> 
> > ---
Hi Jonathan,

Thanks for the review. See below,

> 
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index c045fee32d..2b380a260b 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -45,7 +45,8 @@ enum {
> >  
> >  static void ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
> >                                            int dsmad_handle, uint64_t size,
> > -                                          bool is_pmem, uint64_t dpa_base)
> > +                                          bool is_pmem, bool is_dynamic,
> > +                                          uint64_t dpa_base)
> >  {
> >      g_autofree CDATDsmas *dsmas = NULL;
> >      g_autofree CDATDslbis *dslbis0 = NULL;
> 
> There is a fixlet going through for these as the autofree doesn't do anything.
> Will require a rebase.  I'll do it on my tree, but might not push that out for a
> few days so this is just a heads up for anyone using these.
> 
> https://lore.kernel.org/qemu-devel/20240304104406.59855-1-thuth@redhat.com/
> 
> It went in clean for me, so may not even be something anyone notices!
> 

OK. So I will not rebase for v6 until there is a break.

> > @@ -61,7 +62,8 @@ static void ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
> >              .length = sizeof(*dsmas),
> >          },
> >          .DSMADhandle = dsmad_handle,
> > -        .flags = is_pmem ? CDAT_DSMAS_FLAG_NV : 0,
> > +        .flags = (is_pmem ? CDAT_DSMAS_FLAG_NV : 0) |
> > +                 (is_dynamic ? CDAT_DSMAS_FLAG_DYNAMIC_CAP : 0),
> >          .DPA_base = dpa_base,
> >          .DPA_length = size,
> >      };
> > @@ -149,12 +151,13 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
> >      g_autofree CDATSubHeader **table = NULL;
> >  
> >  
> > @@ -176,21 +179,55 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
> >          pmr_size = memory_region_size(nonvolatile_mr);
> >      }
> >  
> > +    if (ct3d->dc.num_regions) {
> > +        if (ct3d->dc.host_dc) {
> > +            dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
> > +            if (!dc_mr) {
> > +                return -EINVAL;
> > +            }
> > +            len += CT3_CDAT_NUM_ENTRIES * ct3d->dc.num_regions;
> > +        } else {
> > +            return -EINVAL;
> 
> Flip logic to get the error out the way first and reduce indent.
> 
>      if (ct3d->dc.num_regions) {
>         if (!ct3d->dc.host_dc) {
>             return -EINVAL;
>         }
>         dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
>         if (!dc_mr) {
>             return -EINVAL;
>         }
>         len += CT3...
>      }
Will do.
> 
> > +        }
> > +    }
> > +
> 
> >  
> >      *cdat_table = g_steal_pointer(&table);
> > @@ -300,11 +337,24 @@ static void build_dvsecs(CXLType3Dev *ct3d)
> >              range2_size_hi = ct3d->hostpmem->size >> 32;
> >              range2_size_lo = (2 << 5) | (2 << 2) | 0x3 |
> >                               (ct3d->hostpmem->size & 0xF0000000);
> > +        } else if (ct3d->dc.host_dc) {
> > +            range2_size_hi = ct3d->dc.host_dc->size >> 32;
> > +            range2_size_lo = (2 << 5) | (2 << 2) | 0x3 |
> > +                             (ct3d->dc.host_dc->size & 0xF0000000);
> >          }
> > -    } else {
> > +    } else if (ct3d->hostpmem) {
> >          range1_size_hi = ct3d->hostpmem->size >> 32;
> >          range1_size_lo = (2 << 5) | (2 << 2) | 0x3 |
> >                           (ct3d->hostpmem->size & 0xF0000000);
> > +        if (ct3d->dc.host_dc) {
> > +            range2_size_hi = ct3d->dc.host_dc->size >> 32;
> > +            range2_size_lo = (2 << 5) | (2 << 2) | 0x3 |
> > +                             (ct3d->dc.host_dc->size & 0xF0000000);
> > +        }
> > +    } else {
> > +        range1_size_hi = ct3d->dc.host_dc->size >> 32;
> > +        range1_size_lo = (2 << 5) | (2 << 2) | 0x3 |
> > +                         (ct3d->dc.host_dc->size & 0xF0000000);
> 
> I've forgotten if we ever closed out on the right thing to do
> with the legacy range registers.   Maybe, just ignoring DC is the
> right option for now?  So I'd drop this block of changes.
> Maybe Linux will do the wrong thing if we do, but then we should
> make Linux more flexible on this.
> 
> If we did get a clarification that this is the right way to go
> then add a note here.
> 
OK. Will drop the changes here.
> 
> >      }
> >  
> >      dvsec = (uint8_t *)&(CXLDVSECDevice){
> > @@ -579,11 +629,27 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
> >  {
> >      int i;
> >      uint64_t region_base = 0;
> > -    uint64_t region_len =  2 * GiB;
> > -    uint64_t decode_len = 2 * GiB;
> > +    uint64_t region_len;
> > +    uint64_t decode_len;
> >      uint64_t blk_size = 2 * MiB;
> >      CXLDCRegion *region;
> >      MemoryRegion *mr;
> > +    uint64_t dc_size;
> > +
> > +    mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
> > +    dc_size = memory_region_size(mr);
> > +    region_len = DIV_ROUND_UP(dc_size, ct3d->dc.num_regions);
> > +
> > +    if (region_len * ct3d->dc.num_regions > dc_size) {
> This check had me scratching my head for a minute.
> Why not just check
> 
> 	if (dc_size % (ct3d->dc.num_regions * CXL_CAPACITY_MULTIPLER) != 0) {
> 		error_setg(errp, "host backend must by a multiple of 256MiB and region len);
> 		return false;

Your way is more straightforward, will follow your suggestion.

> 	}
> > +        error_setg(errp, "host backend size must be multiples of region len");
> > +        return false;
> > +    }
> > +    if (region_len % CXL_CAPACITY_MULTIPLIER != 0) {
> > +        error_setg(errp, "DC region size is unaligned to %lx",
> > +                   CXL_CAPACITY_MULTIPLIER);
> > +        return false;
> > +    }
> > +    decode_len = region_len;
> 
> 
> 
> 
> > @@ -868,16 +974,24 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
> >                                         AddressSpace **as,
> >                                         uint64_t *dpa_offset)
> >  {
> > -    MemoryRegion *vmr = NULL, *pmr = NULL;
> > +    MemoryRegion *vmr = NULL, *pmr = NULL, *dc_mr = NULL;
> > +    uint64_t vmr_size = 0, pmr_size = 0, dc_size = 0;
> >  
> >      if (ct3d->hostvmem) {
> >          vmr = host_memory_backend_get_memory(ct3d->hostvmem);
> > +        vmr_size = memory_region_size(vmr);
> >      }
> >      if (ct3d->hostpmem) {
> >          pmr = host_memory_backend_get_memory(ct3d->hostpmem);
> > +        pmr_size = memory_region_size(pmr);
> > +    }
> > +    if (ct3d->dc.host_dc) {
> > +        dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
> > +        /* Do we want dc_size to be dc_mr->size or not?? */
> 
> Maybe - definitely don't want to leave this comment here
> unanswered and I think you enforce it above anyway.
> 
> So if we get here ct3d->dc.total_capacity == memory_region_size(ct3d->dc.host_dc);
> As such we could just not stash total_capacity at all?

I cannot identify a case where these two will be different. But
total_capacity is referenced at quite some places, it may be nice to have
it so we do not need to call the function to get the value every time?

Fan

> 
> 
> > +        dc_size = ct3d->dc.total_capacity;
> >      }
> 

