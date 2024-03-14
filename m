Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 117BAC54E5D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 20:44:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkrvd-0000nk-FT; Thu, 14 Mar 2024 16:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rkrvb-0000nK-JS
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 16:43:51 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rkrvZ-0003YT-Co
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 16:43:51 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-5a1d1a28da2so667866eaf.1
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 13:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710449027; x=1711053827; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hWd8oI3ruJ/SwaDYtCbFIZWKWHZ8FtZ+k+TBoesWmzw=;
 b=Yy+spOXtiWcV63izJEVAajDi6j0IvFqVI3MKegCs4l9+l7X35+aHNVBQlfRQVVCWkO
 rgBO78DvemhaUBTwVNVZIMWgaD59THSfWtvdm3tscq0/PPMz9Yg6tYC2+UgX94WBE3q0
 rt7PM8VZmkOfHsTVsn+SbWmjnthHchjJx2JFlvN3UpQaWbm3EvOfs/HWj3GisPghFi+w
 oQR0C/01YSTjvyF0+Znq0dNREy1fibDnM3EN8ILAvpNbCarUDMyh5gpX/4i384LSgC0b
 k9cBNlvJfMetpdR9lr8fsODBt44/s20hZx7TyeNT3km1et4mnPQOTSChjZqrdcNvOAsI
 bl5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710449027; x=1711053827;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hWd8oI3ruJ/SwaDYtCbFIZWKWHZ8FtZ+k+TBoesWmzw=;
 b=t6D5NlFWgVLFAYTpgxSpUhRYYs2vrLOySEdDAsYOyM83fAOPvXsSY9M017iB0NQjjF
 cBHVKba/ENViLPVqZh/RYt6T9smGDQNAFBTAR+ku+Rhx4S+G/9GrxD3NWV0DRR2/LY2y
 2A6WwECegtowUuv3jWsENsv8UXc8mk3fb4bBBoTrEWanz1EglzXBo7bwwWl8aUJKFCyG
 DdM6fnDYEsMmIn3jSnWolNvoMr/Pn5k8gGVfg45iUBVdbe31iKRhywu+qtztyJh4Ak/5
 WQJmNHuV5xwPY1/2r8BUY5STgDGPgtG0Y2ecJz5756WOtCdIA1+R80ZgzOnLkPoBpnSU
 CcHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIrtwh82fvC9S4hZ6rzZkzi0PP4hecrMjChws2zR9oeYKn4zUClINviVYIKiWNbsULy8zIAzAQEjHGx0XXTbjcgS392u0=
X-Gm-Message-State: AOJu0Yyh7Yx5JrHHPNjW0F5e0xirOqqn1wOeAqYdPDsHXXXmeX6Pe6Ya
 BNV5SXKAytg3qjOCWPcHFbTuEIVc6bS8CHtVkC53VFOwx0Z3NWXX
X-Google-Smtp-Source: AGHT+IGLC4ii6d9/X/S+f1aZQgquO/OeR/z7YgHXMeqbzzxL78V9dRn9ImHT9QmYfrJSPrLru3TU9g==
X-Received: by 2002:a05:6359:4c85:b0:17c:23c2:98e4 with SMTP id
 kk5-20020a0563594c8500b0017c23c298e4mr372941rwc.3.1710449027158; 
 Thu, 14 Mar 2024 13:43:47 -0700 (PDT)
Received: from debian ([2601:641:300:14de:1741:531a:c8b2:ee1e])
 by smtp.gmail.com with ESMTPSA id
 b3-20020a631b03000000b005c6617b52e6sm1131298pgb.5.2024.03.14.13.43.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Mar 2024 13:43:46 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Thu, 14 Mar 2024 13:43:26 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: nifan.cxl@gmail.com, qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 gregory.price@memverge.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, a.manzanares@samsung.com,
 dave@stgolabs.net, nmtadam.samsung@gmail.com,
 jim.harris@samsung.com, Jorgen.Hansen@wdc.com, wj28.lee@gmail.com,
 Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v5 06/13] hw/mem/cxl_type3: Add host backend and address
 space handling for DC regions
Message-ID: <ZfNhbtT3Eld6WIU7@debian>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
 <20240304194331.1586191-7-nifan.cxl@gmail.com>
 <20240306162816.00002e0e@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306162816.00002e0e@Huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=nifan.cxl@gmail.com; helo=mail-oo1-xc2d.google.com
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

Hi Jonathan,
I have noticed in the current kernel code, when checking whether the
media is ready (in cxl_await_media_ready), we need to check the devsec
range registers, for dcd device, if we leave dvsec range registers
unset, the device cannot put into "ready" state, which will cause the
device inactive. 

https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/tree/drivers/cxl/core/pci.c?h=fixes&id=d206a76d7d2726f3b096037f2079ce0bd3ba329b#n195

So we need to set it as above?? DO I miss anything?

Fan 

> 
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
> 
> 
> > +        dc_size = ct3d->dc.total_capacity;
> >      }
> 

