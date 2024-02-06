Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F1E8C48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 22:25:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXTsC-0001oy-1d; Tue, 06 Feb 2024 17:25:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rXTsA-0001oo-92
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 17:24:58 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rXTs7-0005E7-Pu
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 17:24:58 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-290b37bb7deso5064521a91.0
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 14:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707258294; x=1707863094; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ujU6Xvgn4msf0EVunaJoGf/DzUI2iXLT9/Gk4cE/ZgU=;
 b=HTXwz46cQPx0Mz2shidOhWm4wsopvEjfPa9EP7/zCpWdjdYax0NI9faYXiEn+OtcNZ
 31Xsp46VM+HdS7hV0QdJSdYW3oZydg1juAiHx6+F6gN2C0ve+dYLHUur6Jz32BA/elE7
 4UKjOtVg+mFWjFYJuuK9p58NCP6VmWP8hXD8xxkQfSDRWVhCHVEPFbxjfyDbH3NyZ0WI
 FoMhZ2hESdvL/P89KkDAr6Rfgl6T0tuUAZ2mW+rWxTWyMt+zSNPWYy4gWLjQPlOExkA4
 suIPqjCnKO+Lx9loRrK6KcikHNbcBy+eAEo+u4ZHuesXws0yvaHear+HvowW4V0mYqkp
 ezDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707258294; x=1707863094;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ujU6Xvgn4msf0EVunaJoGf/DzUI2iXLT9/Gk4cE/ZgU=;
 b=CwP2DB2jNJtBcH6QJdmtZKRZB89Jdj4clZxSRIV1S+pifDDQvOT1u8i890Be0OtZ8L
 mmKQJIZAp2CG4Q/XDUJixrgvdgGAw1mOlP+wqYeDjlxvKsgkxd5BFjnIlHPG6RzXsAXG
 s473wh49werNsrcYlJHd+/+rd5/fvcBrhDcbbJKRXAMs9djrorONqQiRMWndoL5isfe4
 DJEtPRqIea50iNtOejdPJVvYLwCCguMzmdgzCH54LWEUUie9PzHpE/jyEV0YcfZGLFqE
 EmE0VwmOP+DZADTX3ZpXi4nJyiavBInRvVHb2hxowm2bpxMXI1hFZwQXZX2jOLTeFtMi
 Zb9w==
X-Gm-Message-State: AOJu0YzrHW/pBUZRrzIgRUKAME2ZrRzXbWokjb5/r4OlMntOqRweDQYO
 reQXyksPxwz1UUxDt0qpg4eV/kfxqL2AftVJ9mvchJVvUqJJFEYN
X-Google-Smtp-Source: AGHT+IEl5D6vRVTWg0bT/rlJcntiDUKOUTKlMokvgwW2uAKP51vz9/TezQ0da4AN75M5eETAKEb4Hw==
X-Received: by 2002:a17:90a:9a7:b0:296:15e7:8f33 with SMTP id
 36-20020a17090a09a700b0029615e78f33mr825861pjo.3.1707258293741; 
 Tue, 06 Feb 2024 14:24:53 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUB2OIMjd3OeVHyNV2uD2JMoEmmqfvfAPYwqSGnlNzF+SnuMA0XYRGsmS4K+MGtb/cjKSpRIhJ9JPYrPN1MAMd8V/TrmrPJIF0/pxnZS2NCIaoZJoEt3WS39G1/zclYym5p/5MiguZ/VEbLl4ubthUH5jQwnVNmk3z0sMGbedJ5w7dW/PLDDLRJxldljK4KA5kgPdZZyHjoj202wEynkyAB5EszgPbSr3BDnr2M7RA0bMGZNGIVPeyn19adRn1y7GqmGoM9G67lwFGxyAZF29xRgSnqp4Gi/l+ZLs8XU6QL1rZ879bJ8rTeb2gJPNBIwlxZa9EXdff0gquWIqvD0h+m8rh/1D73AZUEidDhQPTXTwhgym0Qiw==
Received: from debian ([2601:641:300:14de:973b:c99b:bb3e:abab])
 by smtp.gmail.com with ESMTPSA id
 z6-20020a17090a468600b002961ccd55e4sm2214935pjf.31.2024.02.06.14.24.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 14:24:53 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Tue, 6 Feb 2024 14:24:36 -0800
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: nifan.cxl@gmail.com, qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net,
 nmtadam.samsung@gmail.com, nifan@outlook.com,
 jim.harris@samsung.com, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v3 5/9] hw/mem/cxl_type3: Add host backend and address
 space handling for DC regions
Message-ID: <ZcKxpFWe5v5YkJqb@debian>
References: <20231107180907.553451-1-nifan.cxl@gmail.com>
 <20231107180907.553451-6-nifan.cxl@gmail.com>
 <20240124154721.0000451d@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124154721.0000451d@Huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pj1-x1036.google.com
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

On Wed, Jan 24, 2024 at 03:47:21PM +0000, Jonathan Cameron wrote:
> On Tue,  7 Nov 2023 10:07:09 -0800
> nifan.cxl@gmail.com wrote:
> 
> > From: Fan Ni <fan.ni@samsung.com>
> > 
> > Add (file/memory backed) host backend, all the dynamic capacity regions
> > will share a single, large enough host backend. Set up address space for
> > DC regions to support read/write operations to dynamic capacity for DCD.
> > 
> > With the change, following supports are added:
> > 1. Add a new property to type3 device "nonvolatile-dc-memdev" to point to host
> >    memory backend for dynamic capacity. Currently, all dc regions share one
> >    one host backend.
> > 2. Add namespace for dynamic capacity for read/write support;
> > 3. Create cdat entries for each dynamic capacity region;
> > 4. Fix dvsec range registers to include DC regions.
> > 
> > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> Some minor comments inline, mostly suggesting pulling refactors out before
> you do the new stuff.
> 
> Thanks,
> 
> Jonathan

Hi Jonathan,
   One question about DVSEC setting inline.
   Please search ""QUESTION:"

> 
> > ---
> >  hw/cxl/cxl-mailbox-utils.c  |  16 ++-
> >  hw/mem/cxl_type3.c          | 198 +++++++++++++++++++++++++++++-------
> >  include/hw/cxl/cxl_device.h |   4 +
> >  3 files changed, 179 insertions(+), 39 deletions(-)
> > 
> 
> 
> 
> >  
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index 2d67d2015c..152a51306d 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -31,6 +31,7 @@
> >  #include "hw/pci/spdm.h"
> >  
> >  #define DWORD_BYTE 4
> > +#define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
> >  
> >  /* Default CDAT entries for a memory region */
> >  enum {
> > @@ -44,8 +45,9 @@ enum {
> >  };
> >  
> >  static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
> > -                                         int dsmad_handle, MemoryRegion *mr,
> > -                                         bool is_pmem, uint64_t dpa_base)
> > +                                         int dsmad_handle, uint64_t size,
> > +                                         bool is_pmem, bool is_dynamic,
> > +                                         uint64_t dpa_base)
> >  {
> >      g_autofree CDATDsmas *dsmas = NULL;
> >      g_autofree CDATDslbis *dslbis0 = NULL;
> > @@ -64,9 +66,10 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
> >              .length = sizeof(*dsmas),
> >          },
> >          .DSMADhandle = dsmad_handle,
> > -        .flags = is_pmem ? CDAT_DSMAS_FLAG_NV : 0,
> > +        .flags = (is_pmem ? CDAT_DSMAS_FLAG_NV : 0) |
> > +            (is_dynamic ? CDAT_DSMAS_FLAG_DYNAMIC_CAP : 0),
> >          .DPA_base = dpa_base,
> > -        .DPA_length = memory_region_size(mr),
> > +        .DPA_length = size,
> >      };
> >  
> >      /* For now, no memory side cache, plausiblish numbers */
> > @@ -150,7 +153,7 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
> >           */
> >          .EFI_memory_type_attr = is_pmem ? 2 : 1,
> >          .DPA_offset = 0,
> > -        .DPA_length = memory_region_size(mr),
> > +        .DPA_length = size,
> >      };
> 
> Might be better to make the change to this function as a precursor patch before
> you introduce the new users.  Will separate the DC bits out from the rest.
> 
> >  
> >      /* Header always at start of structure */
> > @@ -169,21 +172,28 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
> >      g_autofree CDATSubHeader **table = NULL;
> >      CXLType3Dev *ct3d = priv;
> >      MemoryRegion *volatile_mr = NULL, *nonvolatile_mr = NULL;
> > +    MemoryRegion *dc_mr = NULL;
> >      int dsmad_handle = 0;
> >      int cur_ent = 0;
> >      int len = 0;
> >      int rc, i;
> > +    uint64_t vmr_size = 0, pmr_size = 0;
> 
> Put these next to the memory region definitions above given they are referring to the
> same regions.
> 
> >  
> > -    if (!ct3d->hostpmem && !ct3d->hostvmem) {
> > +    if (!ct3d->hostpmem && !ct3d->hostvmem && !ct3d->dc.num_regions) {
> >          return 0;
> >      }
> >  
> > +    if (ct3d->hostpmem && ct3d->hostvmem && ct3d->dc.host_dc) {
> > +        warn_report("The device has static ram and pmem and dynamic capacity");
> 
> This is the whole how many DVSEC ranges question? 
> I hope we resolved that so we don't care about this...
> 
> > +    }
> > +
> >      if (ct3d->hostvmem) {
> >          volatile_mr = host_memory_backend_get_memory(ct3d->hostvmem);
> >          if (!volatile_mr) {
> >              return -EINVAL;
> >          }
> >          len += CT3_CDAT_NUM_ENTRIES;
> > +        vmr_size = memory_region_size(volatile_mr);
> >      }
> >  
> >      if (ct3d->hostpmem) {
> 
> ....
> 
> > @@ -210,14 +233,38 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
> >      }
> >  
> >      if (nonvolatile_mr) {
> > -        uint64_t base = volatile_mr ? memory_region_size(volatile_mr) : 0;
> >          rc = ct3_build_cdat_entries_for_mr(&(table[cur_ent]), dsmad_handle++,
> > -                                           nonvolatile_mr, true, base);
> > +                                           pmr_size, true, false, vmr_size);
> >          if (rc < 0) {
> >              goto error_cleanup;
> >          }
> >          cur_ent += CT3_CDAT_NUM_ENTRIES;
> >      }
> > +
> > +    if (dc_mr) {
> > +        uint64_t region_base = vmr_size + pmr_size;
> > +
> > +        /*
> > +         * Currently we create cdat entries for each region, should we only
> > +         * create dsmas table instead??
> 
> We want the whole set.  Need multiple DSMAS for the flags.
> SLBIS refer to DSMAS to identify which memory they cover + they may well be
> different for different regions (could be different types of memory).
> DSEMTS also by DSMAS handle so we need those as well
> 
> 
> > +         * We assume all dc regions are non-volatile for now.
> 
> As expressed below. I'd really prefer them to start as volatile and we can
> consider non volatile later.
> 
> > +         *
> > +         */
> > +        for (i = 0; i < ct3d->dc.num_regions; i++) {
> > +            rc = ct3_build_cdat_entries_for_mr(&(table[cur_ent]),
> > +                                               dsmad_handle++,
> > +                                               ct3d->dc.regions[i].len,
> > +                                               true, true, region_base);
> > +            if (rc < 0) {
> > +                goto error_cleanup;
> > +            }
> > +            ct3d->dc.regions[i].dsmadhandle = dsmad_handle - 1;
> > +
> > +            cur_ent += CT3_CDAT_NUM_ENTRIES;
> > +            region_base += ct3d->dc.regions[i].len;
> > +        }
> > +    }
> > +
> >      assert(len == cur_ent);
> >  
> >      *cdat_table = g_steal_pointer(&table);
> > @@ -445,11 +492,24 @@ static void build_dvsecs(CXLType3Dev *ct3d)
> >              range2_size_hi = ct3d->hostpmem->size >> 32;
> >              range2_size_lo = (2 << 5) | (2 << 2) | 0x3 |
> >                               (ct3d->hostpmem->size & 0xF0000000);
> > +        } else if (ct3d->dc.host_dc) {
> > +            range2_size_hi = ct3d->dc.host_dc->size >> 32;
> > +            range2_size_lo = (2 << 5) | (2 << 2) | 0x3 |
> > +                             (ct3d->dc.host_dc->size & 0xF0000000);
> 
> I've forgotten if we came to a conclusion on whether these should include
> DC or not...  My gut feeling is no because we don't know what to do
> if they are both already in use.
> 

QUESTION:

If we do not include DC, and there is no static ram/pmem capacity and
only dynamic capacity, then the range registers will not be set, is that
what we want?

Fan

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
> > +            (ct3d->dc.host_dc->size & 0xF0000000);
> >      }
> >  
> >      dvsec = (uint8_t *)&(CXLDVSECDevice){
> > @@ -721,6 +781,9 @@ static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t value,
> >      }
> >  }
> >  
> > +/*
> > + * TODO: region parameters are hard coded, may need to change in the future.
> 
> Agreed :)  We should look at this fairly soon I think, though as
> long as we keep option of defaults that fall back to what we have here
> we can do most of it later. However I would like the defaults to be derived
> from the memory backend size.
> 
> > + */
> >  static int cxl_create_dc_regions(CXLType3Dev *ct3d)
> >  {
> >      int i;
> > @@ -736,6 +799,7 @@ static int cxl_create_dc_regions(CXLType3Dev *ct3d)
> >      if (ct3d->hostpmem) {
> >          region_base += ct3d->hostpmem->size;
> >      }
> > +
> 
> Should be pushed back to the original patch.
> 
> >      for (i = 0; i < ct3d->dc.num_regions; i++) {
> >          region = &ct3d->dc.regions[i];
> >          region->base = region_base;
> 
> > @@ -823,6 +888,50 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
> >          return false;
> >      }
> >  
> > +    ct3d->dc.total_capacity = 0;
> > +    if (ct3d->dc.host_dc) {
> 
> This confuses me a little. Can we create DC regions without a memory backend?
> I don't think we should allow that - in which case the earlier
> cxl_create_dc_regions() can move under this check.
> 
> > +        MemoryRegion *dc_mr;
> > +        char *dc_name;
> > +        uint64_t total_region_size = 0;
> > +        int i;
> > +
> > +        dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
> > +        if (!dc_mr) {
> > +            error_setg(errp, "dynamic capacity must have backing device");
> > +            return false;
> > +        }
> > +        /* FIXME: set dc as nonvolatile for now */
> 
> As that's less likely to occur than volatile I'd prefer a default of volatile.
> 
> > +        memory_region_set_nonvolatile(dc_mr, true);
> > +        memory_region_set_enabled(dc_mr, true);
> > +        host_memory_backend_set_mapped(ct3d->dc.host_dc, true);
> > +        if (ds->id) {
> > +            dc_name = g_strdup_printf("cxl-dcd-dpa-dc-space:%s", ds->id);
> > +        } else {
> > +            dc_name = g_strdup("cxl-dcd-dpa-dc-space");
> > +        }
> > +        address_space_init(&ct3d->dc.host_dc_as, dc_mr, dc_name);
> > +        g_free(dc_name);
> > +
> > +        for (i = 0; i < ct3d->dc.num_regions; i++) {
> > +            total_region_size += ct3d->dc.regions[i].len;
> > +        }
> > +        /* Make sure the host backend is large enough to cover all dc range */
> 
> I suppose this is another reasonable way of doing region defaults. Just refuse
> them if your defaults don't fit in the provided memory backend.
> We can work with that as long as we cycle back around to regions we can
> configure from the command line fairly soon. 
> 
> > +        if (total_region_size > memory_region_size(dc_mr)) {
> > +            error_setg(errp,
> > +                "too small host backend size, increase to %lu MiB or more",
> > +                total_region_size / MiB);
> > +            return false;
> > +        }
> > +
> > +        if (dc_mr->size % CXL_CAPACITY_MULTIPLIER != 0) {
> > +            error_setg(errp, "DC region size is unaligned to %lx",
> > +                    CXL_CAPACITY_MULTIPLIER);
> > +            return false;
> > +        }
> > +
> > +        ct3d->dc.total_capacity = total_region_size;
> > +    }
> > +
> >      return true;
> >  }
> 
> 
> > @@ -1025,16 +1140,24 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
> >                                         AddressSpace **as,
> >                                         uint64_t *dpa_offset)
> >  {
> 
> >  
> > @@ -1042,19 +1165,18 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
> >          return -EINVAL;
> >      }
> >  
> > -    if (*dpa_offset > ct3d->cxl_dstate.static_mem_size) {
> > +    if (*dpa_offset >= vmr_size + pmr_size + dc_size) {
> >          return -EINVAL;
> >      }
> >  
> > -    if (vmr) {
> > -        if (*dpa_offset < memory_region_size(vmr)) {
> > -            *as = &ct3d->hostvmem_as;
> > -        } else {
> > -            *as = &ct3d->hostpmem_as;
> > -            *dpa_offset -= memory_region_size(vmr);
> > -        }
> > -    } else {
> > +    if (*dpa_offset < vmr_size) {
> > +        *as = &ct3d->hostvmem_as;
> > +    } else if (*dpa_offset < vmr_size + pmr_size) {
> >          *as = &ct3d->hostpmem_as;
> > +        *dpa_offset -= vmr_size;
> > +    } else {
> > +        *as = &ct3d->dc.host_dc_as;
> > +        *dpa_offset -= (vmr_size + pmr_size);
> >      }
> 
> This code is duplicated below.  As a follow up perhaps we should
> add a utility function to get the as and offset within that space.
>   
> >      return 0;
> > @@ -1143,6 +1265,8 @@ static Property ct3_props[] = {
> >      DEFINE_PROP_STRING("cdat", CXLType3Dev, cxl_cstate.cdat.filename),
> >      DEFINE_PROP_UINT16("spdm", CXLType3Dev, spdm_port, 0),
> >      DEFINE_PROP_UINT8("num-dc-regions", CXLType3Dev, dc.num_regions, 0),
> > +    DEFINE_PROP_LINK("nonvolatile-dc-memdev", CXLType3Dev, dc.host_dc,
> > +                    TYPE_MEMORY_BACKEND, HostMemoryBackend *),
> >      DEFINE_PROP_END_OF_LIST(),
> >  };
> >  
> > @@ -1209,33 +1333,39 @@ static void set_lsa(CXLType3Dev *ct3d, const void *buf, uint64_t size,
> >  
> >  static bool set_cacheline(CXLType3Dev *ct3d, uint64_t dpa_offset, uint8_t *data)
> >  {
> > -    MemoryRegion *vmr = NULL, *pmr = NULL;
> > +    MemoryRegion *vmr = NULL, *pmr = NULL, *dc_mr = NULL;
> >      AddressSpace *as;
> > +    uint64_t vmr_size = 0, pmr_size = 0, dc_size = 0;
> >  
> >      if (ct3d->hostvmem) {
> >          vmr = host_memory_backend_get_memory(ct3d->hostvmem);
> > +        vmr_size = memory_region_size(vmr);
> >      }
> >      if (ct3d->hostpmem) {
> >          pmr = host_memory_backend_get_memory(ct3d->hostpmem);
> > +        pmr_size = memory_region_size(pmr);
> >      }
> > +    if (ct3d->dc.host_dc) {
> > +        dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
> > +        dc_size = ct3d->dc.total_capacity;
> > +     }
> >  
> > -    if (!vmr && !pmr) {
> > +    if (!vmr && !pmr && !dc_mr) {
> >          return false;
> >      }
> >  
> > -    if (dpa_offset + CXL_CACHE_LINE_SIZE > ct3d->cxl_dstate.static_mem_size) {
> > +    if (dpa_offset + CXL_CACHE_LINE_SIZE > vmr_size + pmr_size + dc_size) {
> >          return false;
> >      }
> >  
> > -    if (vmr) {
> > -        if (dpa_offset < memory_region_size(vmr)) {
> > -            as = &ct3d->hostvmem_as;
> > -        } else {
> > -            as = &ct3d->hostpmem_as;
> > -            dpa_offset -= memory_region_size(vmr);
> > -        }
> > -    } else {
> > +    if (dpa_offset < vmr_size) {
> > +        as = &ct3d->hostvmem_as;
> > +    } else if (dpa_offset < vmr_size + pmr_size) {
> >          as = &ct3d->hostpmem_as;
> > +        dpa_offset -= vmr_size;
> > +    } else {	
> > +        as = &ct3d->dc.host_dc_as;
> > +        dpa_offset -= (vmr_size + pmr_size);
> >      }
> >  
> >      address_space_write(as, dpa_offset, MEMTXATTRS_UNSPECIFIED, &data,
> 
> 

