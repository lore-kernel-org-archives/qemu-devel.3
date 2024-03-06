Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CEABC54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 23:37:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ri0ok-00048O-0O; Wed, 06 Mar 2024 18:36:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1ri0oi-00047x-7z
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 18:36:56 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1ri0of-0003WT-VS
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 18:36:55 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6e5d7f1f25fso232773b3a.0
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 15:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709768211; x=1710373011; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=G3NByaC7e2vU7KXkuTFn4jau+iZXlsPs1U5JLg/SDIM=;
 b=HIzUkWAzz73zImZo7PRNM7J5jTHsqXb+uboLNQVm0YwcofQzrYyVlUHI2VSX9SSHLM
 1hoEhN2ZxIIHg9Iz4Ud/BD6+biX1KX0CKahrnGyadpABVnTKFsKJNkNkL6gUlz5GSTYQ
 nL6ExCJemj9IN7CSobAVKBZajBAYLLnPatiUIt/Q2aLlcHLSzUekTuWFnZZSDslEc6l/
 rCGzoHRbCwZ4+p2yxwlhi0WQoMAcgRKPvg1543pHkr5MDVluwjL4opq/o9RnyvWxsxeH
 66Drk2HSP0Z/OphU+B14sLYZ2ti5aXMvLavxB0x9yJil41WeCjc2D8WQUQMX59TxRptJ
 Sz1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709768211; x=1710373011;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G3NByaC7e2vU7KXkuTFn4jau+iZXlsPs1U5JLg/SDIM=;
 b=HXQN30yb7TbRaNkmWkDwshKNhNaGTuSWxICRG3ocyKrnXkfpKnbtDyfq/d1WqUy9CH
 Ic3Blx9CpB97//On9s7BSsfbR9FWT95VYrImdSli29AKB3edIQet2Mf8b3ND2U1a+4Hf
 PpRi7PAV+i0WImiV2BZHHyQ27jwL+dsLn8aGtKZkCtCpK+CXlvTdN1vVLwyARDDKgpk9
 YwLslMdfuzTNp4R3yM7l05NEago865oFjbDfUuksFHPYn4fWlZGwg94+4cX5oMMG7zlU
 N4yL/oz3HFLbRerF9rBaSEXl+jN2OYOlSUZiRBvpmYDcTZI4zHrwh28Lta92Ho5ped4B
 rEBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUchdAW96IgSOWzWGm9qC7Sb5WNlYLf9mqxTX86N4tOAEWSpN6cOsY7+jhi+AavL0PZrMhCg2QofjVD+65sVQptLNCS/B4=
X-Gm-Message-State: AOJu0YwiwPo13bJ0Jkha8RGY/r+YEZM0AjfWhV8kjxYGK4PxhBM8/Ofh
 /KxxmXhY1Q0Zdnc+PRXaXz6qdrM5EaFlKpHhZhoTQgxJhWchzys+
X-Google-Smtp-Source: AGHT+IEwtRMhFbSxQb/KZXhLcR9EIwBKij6+ixLsZ46fWXDn9wg1tZGHwoGvcDjNQ8MYSr5vZ+jMkA==
X-Received: by 2002:a05:6a00:10ca:b0:6e6:3f05:74d8 with SMTP id
 d10-20020a056a0010ca00b006e63f0574d8mr6160393pfu.3.1709768211057; 
 Wed, 06 Mar 2024 15:36:51 -0800 (PST)
Received: from debian ([2601:641:300:14de:57cf:345:75f0:2085])
 by smtp.gmail.com with ESMTPSA id
 k19-20020a63ff13000000b005cfb6e7b0c7sm11710093pgi.39.2024.03.06.15.36.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 15:36:50 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Wed, 6 Mar 2024 15:36:38 -0800
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: nifan.cxl@gmail.com, qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 gregory.price@memverge.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, a.manzanares@samsung.com,
 dave@stgolabs.net, nmtadam.samsung@gmail.com,
 jim.harris@samsung.com, Jorgen.Hansen@wdc.com, wj28.lee@gmail.com,
 Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v5 09/13] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
Message-ID: <Zej-Bg7ooVyswHXZ@debian>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
 <20240304194331.1586191-10-nifan.cxl@gmail.com>
 <20240306174811.000029fd@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306174811.000029fd@Huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pf1-x42f.google.com
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

If the second skip_extent case, I will reject earlier instead of
skipping.

Fan

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

