Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C368AC5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 23:16:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ri0U8-0007Uz-Dq; Wed, 06 Mar 2024 18:15:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1ri0U5-0007Uh-DL
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 18:15:38 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1ri0U3-0000bk-9Z
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 18:15:37 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1dc49b00bdbso2386885ad.3
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 15:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709766933; x=1710371733; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Id/V3NEpLU2tiqiNwwAXaXlUYzvDYW4eeAi92PZrxBg=;
 b=kNiFXCjeD7rKlicTbu+8OMqFeiNFN1b7KtKfRJkz3uLX1oUrR5GZ3XdFK4kvnuJgow
 juqCfOf2J5XHYjbhUV4OWIrS7SkEqgvi8F7nY0ruh7pFl8ulwLAf0atsdZn+ns8v9SPi
 tuf7btuq2LZIv144U/cds/Y07INsYMEr1XjTZR55T6l1OgBvy0/lzKlkLiq3OeunX4H0
 PFVdPUmTu4uOTH71ugJZj7CYk1zVSKfbUlGmcBhW3xtGrk0Fpsa2gRcsDFm/NKxHBBFd
 WPRr5CAxzUEyh3lcWX7MPhJntg/qXzt42NIa7LChVQpw7+q1sDtkHTlZNAbVUFdfxMRE
 TgjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709766933; x=1710371733;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Id/V3NEpLU2tiqiNwwAXaXlUYzvDYW4eeAi92PZrxBg=;
 b=mCCgD1UbbkBNxbBR/3aFqIfgXRlfwR7rtWks9+8g6hzcM9pYFqtG5wzusiY2jRgqIH
 cLNvuNYQAk4J8X+BdsZrhOWppZd6NRUdjeP3kG6D1cl2fb+9nNg9Qc7lCfphAVx9pHMD
 INHdKfuYC4xWPE/vBu+QcbqWeSHCGQqIjn6z+oHA5T6QzuPFBRs2HM+0yPZIspYGhPc+
 dQqw36Wvjowatzn27xR5W4y7FksZyRe0mTnqmOQjEfYHxyndLaX0KARGRoDxxVDnkOZm
 JluDIRiyaH5emiQTKrrGHX9A+kTio81Vvpeo3mZRxkRz10R03TmWkEy/JqjB2+0maHWz
 8ueA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRCFZXj1C3nsUy7RqFwMdTLulwGb5Gh2iyC6WzNMD/NbM4P2yZzUAIN2HhNT+/ne/eiQRLCjB/AyH7l6Y5tbnKxFAir+4=
X-Gm-Message-State: AOJu0YwX8mCjnaKm2rdKOllpPlYEygpyzwEGuHCs02HOH+XH8EgKrvLK
 yF1QNC8Hrpxx8/DZfc2CpmflCkmWRWl97LqtYnkzSstjRC6lMTF/
X-Google-Smtp-Source: AGHT+IHC4n6g6JZ8b8UX0f61GtFy2ythZAVB/WHpm1wDMOTMRWsUDf9ruwcnTgdITBdJGgTgiRZ+jw==
X-Received: by 2002:a17:902:bc86:b0:1dc:16:9000 with SMTP id
 bb6-20020a170902bc8600b001dc00169000mr6126594plb.16.1709766933398; 
 Wed, 06 Mar 2024 15:15:33 -0800 (PST)
Received: from debian ([2601:641:300:14de:57cf:345:75f0:2085])
 by smtp.gmail.com with ESMTPSA id
 kx3-20020a170902f94300b001dca40bb727sm13205906plb.88.2024.03.06.15.15.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 15:15:33 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Wed, 6 Mar 2024 15:15:30 -0800
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: nifan.cxl@gmail.com, qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 gregory.price@memverge.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, a.manzanares@samsung.com,
 dave@stgolabs.net, nmtadam.samsung@gmail.com,
 jim.harris@samsung.com, Jorgen.Hansen@wdc.com, wj28.lee@gmail.com,
 Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v5 09/13] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
Message-ID: <Zej5EuQXytgeWGfj@debian>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
 <20240304194331.1586191-10-nifan.cxl@gmail.com>
 <20240306174811.000029fd@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306174811.000029fd@Huawei.com>
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

On Wed, Mar 06, 2024 at 05:48:11PM +0000, Jonathan Cameron wrote:
> On Mon,  4 Mar 2024 11:34:04 -0800
> nifan.cxl@gmail.com wrote:
> 
> > From: Fan Ni <fan.ni@samsung.com>
> > 
> > Since fabric manager emulation is not supported yet, the change implements
> > the functions to add/release dynamic capacity extents as QMP interfaces.
> 
> We'll need them anyway, or to implement an fm interface via QMP which is
> going to be ugly and complex.
> 
> > 
> > Note: we skips any FM issued extent release request if the exact extent
> > does not exist in the extent list of the device. We will loose the
> > restriction later once we have partial release support in the kernel.
> 
> Maybe the kernel will treat it as a request to release the extent it
> is tracking that contains it.  So we may want to add a way to poke that.
> Not today though!
> 
> > 
> > 1. Add dynamic capacity extents:
> > 
> > For example, the command to add two continuous extents (each 128MiB long)
> > to region 0 (starting at DPA offset 0) looks like below:
> > 
> > { "execute": "qmp_capabilities" }
> > 
> > { "execute": "cxl-add-dynamic-capacity",
> >   "arguments": {
> >       "path": "/machine/peripheral/cxl-dcd0",
> >       "region-id": 0,
> >       "extents": [
> >       {
> >           "dpa": 0,
> >           "len": 134217728
> >       },
> >       {
> >           "dpa": 134217728,
> >           "len": 134217728
> >       }
> >       ]
> >   }
> > }
> > 
> > 2. Release dynamic capacity extents:
> > 
> > For example, the command to release an extent of size 128MiB from region 0
> > (DPA offset 128MiB) look like below:
> > 
> > { "execute": "cxl-release-dynamic-capacity",
> >   "arguments": {
> >       "path": "/machine/peripheral/cxl-dcd0",
> >       "region-id": 0,
> >       "extents": [
> >       {
> >           "dpa": 134217728,
> >           "len": 134217728
> >       }
> >       ]
> >   }
> > }
> > 
> > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> 
> ...
>   
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index dccfaaad3a..e9c8994cdb 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -674,6 +674,7 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
> >          ct3d->dc.total_capacity += region->len;
> >      }
> >      QTAILQ_INIT(&ct3d->dc.extents);
> > +    QTAILQ_INIT(&ct3d->dc.extents_pending_to_add);
> >  
> >      return true;
> >  }
> > @@ -686,6 +687,12 @@ static void cxl_destroy_dc_regions(CXLType3Dev *ct3d)
> >          ent = QTAILQ_FIRST(&ct3d->dc.extents);
> >          cxl_remove_extent_from_extent_list(&ct3d->dc.extents, ent);
> >      }
> > +
> > +    while (!QTAILQ_EMPTY(&ct3d->dc.extents_pending_to_add)) {
> 
> QTAILQ_FOR_EACHSAFE
> 
> > +        ent = QTAILQ_FIRST(&ct3d->dc.extents_pending_to_add);
> > +        cxl_remove_extent_from_extent_list(&ct3d->dc.extents_pending_to_add,
> > +                                           ent);
> > +    }
> >  }
> 
> > +/*
> > + * The main function to process dynamic capacity event. Currently DC extents
> > + * add/release requests are processed.
> > + */
> > +static void qmp_cxl_process_dynamic_capacity(const char *path, CxlEventLog log,
> > +                                             CXLDCEventType type, uint16_t hid,
> > +                                             uint8_t rid,
> > +                                             CXLDCExtentRecordList *records,
> > +                                             Error **errp)
> > +{
> > +    Object *obj;
> > +    CXLEventDynamicCapacity dCap = {};
> > +    CXLEventRecordHdr *hdr = &dCap.hdr;
> > +    CXLType3Dev *dcd;
> > +    uint8_t flags = 1 << CXL_EVENT_TYPE_INFO;
> > +    uint32_t num_extents = 0;
> > +    CXLDCExtentRecordList *list;
> > +    g_autofree CXLDCExtentRaw *extents = NULL;
> > +    uint8_t enc_log;
> > +    uint64_t offset, len, block_size;
> > +    int i;
> > +    int rc;
> 
> Combine the two lines above.
> 
> > +    g_autofree unsigned long *blk_bitmap = NULL;
> > +
> > +    obj = object_resolve_path(path, NULL);
> > +    if (!obj) {
> > +        error_setg(errp, "Unable to resolve path");
> > +        return;
> > +    }
> 
> object_resolve_path_type() and skip a step (should do this in various places
> in our existing code!)
> 
> > +    if (!object_dynamic_cast(obj, TYPE_CXL_TYPE3)) {
> > +        error_setg(errp, "Path not point to a valid CXL type3 device");
> > +        return;
> > +    }
> > +
> > +    dcd = CXL_TYPE3(obj);
> > +    if (!dcd->dc.num_regions) {
> > +        error_setg(errp, "No dynamic capacity support from the device");
> > +        return;
> > +    }
> > +
> > +    rc = ct3d_qmp_cxl_event_log_enc(log);
> > +    if (rc < 0) {
> > +        error_setg(errp, "Unhandled error log type");
> > +        return;
> > +    }
> > +    enc_log = rc;
> > +
> > +    if (rid >= dcd->dc.num_regions) {
> > +        error_setg(errp, "region id is too large");
> > +        return;
> > +    }
> > +    block_size = dcd->dc.regions[rid].block_size;
> > +
> > +    /* Sanity check and count the extents */
> > +    list = records;
> > +    while (list) {
> > +        offset = list->value->offset;
> > +        len = list->value->len;
> > +
> > +        if (len == 0) {
> > +            error_setg(errp, "extent with 0 length is not allowed");
> > +            return;
> > +        }
> > +
> > +        if (offset % block_size || len % block_size) {
> > +            error_setg(errp, "dpa or len is not aligned to region block size");
> > +            return;
> > +        }
> > +
> > +        if (offset + len > dcd->dc.regions[rid].len) {
> > +            error_setg(errp, "extent range is beyond the region end");
> > +            return;
> > +        }
> > +
> > +        num_extents++;
> > +        list = list->next;
> > +    }
> > +    if (num_extents == 0) {
> > +        error_setg(errp, "No extents found in the command");
> > +        return;
> > +    }
> > +
> > +    blk_bitmap = bitmap_new(dcd->dc.regions[rid].len / block_size);
> > +
> > +    /* Create Extent list for event being passed to host */
> > +    i = 0;
> > +    list = records;
> > +    extents = g_new0(CXLDCExtentRaw, num_extents);
> > +    while (list) {
> > +        CXLDCExtent *ent;
> > +        bool skip_extent = false;
> > +
> > +        offset = list->value->offset;
> > +        len = list->value->len;
> > +
> > +        extents[i].start_dpa = offset + dcd->dc.regions[rid].base;
> > +        extents[i].len = len;
> > +        memset(extents[i].tag, 0, 0x10);
> > +        extents[i].shared_seq = 0;
> > +
> > +        if (type == DC_EVENT_RELEASE_CAPACITY ||
> > +            type == DC_EVENT_FORCED_RELEASE_CAPACITY) {
> > +            /*
> > +             *  if the extent is still pending to be added to the host,
> 
> Odd spacing.
> 
> > +             * remove it from the pending extent list, so later when the add
> > +             * response for the extent arrives, the device can reject the
> > +             * extent as it is not in the pending list.
> > +             */
> > +            ent = cxl_dc_extent_exists(&dcd->dc.extents_pending_to_add,
> > +                        &extents[i]);
> > +            if (ent) {
> > +                QTAILQ_REMOVE(&dcd->dc.extents_pending_to_add, ent, node);
> > +                g_free(ent);
> > +                skip_extent = true;
> > +            } else if (!cxl_dc_extent_exists(&dcd->dc.extents, &extents[i])) {
> > +                /* If the exact extent is not in the accepted list, skip */
> > +                skip_extent = true;
> > +            }
> I think we need to reject case of some extents skipped and others not.
> That's not supported yet so we need to complain if we get it at least. Maybe we need
> to do two passes so we know this has happened early (or perhaps this is a later
> patch in which case a todo here would help).

Skip here does not mean the extent is invalid, it just means the extent
is still pending to add, so remove them from pending list would be
enough to reject the extent, no need to release further. That is based
on your feedback on v4.

The loop here is only to collect the extents to sent to the event log. 
But as you said, we need one pass before updating pending list.
Actually if we do not allow the above case where extents to release is
still in the pending to add list, we can just return here with error, no
extra dry run needed. 

What do you think?

> 
> > +        
> > +
> > +        /* No duplicate or overlapped extents are allowed */
> > +        if (test_any_bits_set(blk_bitmap, offset / block_size,
> > +                              len / block_size)) {
> > +            error_setg(errp, "duplicate or overlapped extents are detected");
> > +            return;
> > +        }
> > +        bitmap_set(blk_bitmap, offset / block_size, len / block_size);
> > +
> > +        list = list->next;
> > +        if (!skip_extent) {
> > +            i++;
> Problem is if we skip one in the middle the records will be wrong below.

Why? Only extents passed the check will be stored in variable extents and
processed further and i be updated. 
For skipped ones, since i is not updated, they will be
overwritten by following valid ones.

Fan

> > +        }
> > +    }
> > +    num_extents = i;
> > +
> > +    /*
> > +     * CXL r3.1 section 8.2.9.2.1.6: Dynamic Capacity Event Record
> > +     *
> > +     * All Dynamic Capacity event records shall set the Event Record Severity
> > +     * field in the Common Event Record Format to Informational Event. All
> > +     * Dynamic Capacity related events shall be logged in the Dynamic Capacity
> > +     * Event Log.
> > +     */
> > +    cxl_assign_event_header(hdr, &dynamic_capacity_uuid, flags, sizeof(dCap),
> > +                            cxl_device_get_timestamp(&dcd->cxl_dstate));
> > +
> > +    dCap.type = type;
> > +    /* FIXME: for now, validity flag is cleared */
> > +    dCap.validity_flags = 0;
> > +    stw_le_p(&dCap.host_id, hid);
> > +    /* only valid for DC_REGION_CONFIG_UPDATED event */
> > +    dCap.updated_region_id = 0;
> > +    /*
> > +     * FIXME: for now, the "More" flag is cleared as there is only one
> > +     * extent associating with each record and tag-based release is
> > +     * not supported.
> 
> Hmm. Seems like tag support would be easy.  Add an optional qmp parameter,
> if a tag is set, we set the more flag for all but the last entry in this
> loop.  I'm ok with that being a follow up patch though.
> 
> > +     */
> > +    dCap.flags = 0;
> > +    for (i = 0; i < num_extents; i++) {
> > +        memcpy(&dCap.dynamic_capacity_extent, &extents[i],
> > +               sizeof(CXLDCExtentRaw));
> > +
> > +        if (type == DC_EVENT_ADD_CAPACITY) {
> > +            cxl_insert_extent_to_extent_list(&dcd->dc.extents_pending_to_add,
> > +                                             extents[i].start_dpa,
> > +                                             extents[i].len,
> > +                                             extents[i].tag,
> > +                                             extents[i].shared_seq);
> > +        }
> > +
> > +        if (cxl_event_insert(&dcd->cxl_dstate, enc_log,
> > +                             (CXLEventRecordRaw *)&dCap)) {
> > +            cxl_event_irq_assert(dcd);
> > +        }
> > +    }
> > +}
> 
> 
> 
> 
> > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> > index 341260e6e4..b524c5e699 100644
> > --- a/include/hw/cxl/cxl_device.h
> > +++ b/include/hw/cxl/cxl_device.h
> > @@ -490,6 +490,7 @@ struct CXLType3Dev {
> >          AddressSpace host_dc_as;
> >          uint64_t total_capacity; /* 256M aligned */
> >          CXLDCExtentList extents;
> > +        CXLDCExtentList extents_pending_to_add;
> 
> Long name, extents_pending or just pending is plenty I think.
> 
> >          uint32_t total_extent_count;
> >          uint32_t ext_list_gen_seq;
> >  
> > @@ -551,4 +552,9 @@ CXLDCRegion *cxl_find_dc_region(CXLType3Dev *ct3d, uint64_t dpa, uint64_t len);
> >  
> >  void cxl_remove_extent_from_extent_list(CXLDCExtentList *list,
> >                                          CXLDCExtent *extent);
> > +void cxl_insert_extent_to_extent_list(CXLDCExtentList *list, uint64_t dpa,
> > +                                      uint64_t len, uint8_t *tag,
> > +                                      uint16_t shared_seq);
> > +bool test_any_bits_set(const unsigned long *addr, unsigned long nr,
> > +                       unsigned long size);
> >  #endif
> 
> 

