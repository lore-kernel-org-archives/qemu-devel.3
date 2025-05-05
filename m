Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE92C3ABB0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 16:41:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBysB-0001HV-JG; Mon, 05 May 2025 12:40:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uByrj-0001Ab-ML
 for qemu-devel@nongnu.org; Mon, 05 May 2025 12:40:28 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uByre-0000k4-O5
 for qemu-devel@nongnu.org; Mon, 05 May 2025 12:40:25 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-224171d6826so68618665ad.3
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 09:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746463221; x=1747068021; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NjbPqPRRREtgZGw2PEbR9P44++hXXtzZ6VSCMtAfXpk=;
 b=FkF/i+r9zuXkg4/tiRGwnjcelJQQq5h7Gou/zD7f2ar6BIURQ4S5XV748BsifzThe+
 V9wR8y/XT1P6so1dYKR4Nm2ocRWKiZrzB/nP99A5z8W2io2gzd5xCNfj9XX8zpIH3afy
 jBDmQgZRETUPUJHSZMauomu/KNNuZn3qtUBAf9x6OKvzj/T8zuqwaVdU2+TtCAEBDeiJ
 t+OZ+RqjoK0qCxrWHBR8vvcxY70DxZKP6q0eApevkjjJDuvQvEIhN43TT/V4L0b07p6L
 h++SuLmiuJMx17jEdPc0VH9zL4nJUxj8UPgAH8ZMbVtPEzmHZ2VkJ8KvvrJ5OD8N/gXz
 jCsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746463221; x=1747068021;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NjbPqPRRREtgZGw2PEbR9P44++hXXtzZ6VSCMtAfXpk=;
 b=sJxWbCYWIW/yfNE//TRtXoDHnDU05VbGP0C2HnbeIBFRblKCiy2x46PdgE/BIA4md2
 jNg5Kko2pqqJIx3k2xs2YqECaSnmsUGDuKBNvpv7pXpMvNhkc4/EEbTbrKM9RlyT8rs7
 qjXKxMiltVOft8FCAcqszraivisCGl4MOkTj5RGq1RSZreQHITmLdgMN3raOM+ASlocV
 mdM1FFpx/Ts61dxskXU92f8XHkIZgzrwEBTD5HCwhmvPbfD4i+sHSJLdcq+/tQuqH59F
 sJQaawyyj+eeJQoBcikkkL/Ma6Y8bZA+9hRu//d+HglKnRpNairO3HY0z32Zbz944Agq
 E7TA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVK2oeCafgs5KVshfrbdMk5DAzFhni9+khGh1fdHBxOHPw97TjmTmnIxBSOi4PGLWc7JdXLtnWYH6Du@nongnu.org
X-Gm-Message-State: AOJu0YxXEoj4zxrrzPQ5I3DDVKTAMt3PA4O7GR+is4F2/PKVkX92N6KI
 DsPXaHPu0nIgGp9ZTVGetlti5TMw17xZdtjIcezH5TnmVGtIcyFm
X-Gm-Gg: ASbGncuWiTdw/33Cmeh6SnbKiqop+WWxwTtIqUqZKnwDGeSL0pbto8L9eISWp6QhM9R
 RDkLG1lagmNRqQi3IKD7dICNT8fvKuLY2gpI8ekH3gxdTXH0Jqq6wbsvK1a3VqI5o3DYqDHYvV0
 cKbXSNM47Gc57/R5W62FNWIS4iM5EPMfpXUXBkSMpCbcgPYRpsQIscqIwPDC8hCNhEPsduHLCEl
 pwxr9R3xoeuFFBzjNWwRtAgSGP38q7AvdCHkK1JXkKz0GpvPR4GZx/Y/i1Fr+Ej0/V3z+V7sGMh
 BKduA7C+YhnRRF+PoyY/Wzd8RSw9DT5MVFR5u1nw4Ajk9ggvwmsZBblMn9RPJq/2u3I=
X-Google-Smtp-Source: AGHT+IFX+GkhdGN3ALtOcUgWKi2+CFDkTtzRi2oLKu2RTRWqF+s/bhhQYZZTj2P6nbS4nOc2cUhhVw==
X-Received: by 2002:a17:903:244e:b0:227:e6fe:2908 with SMTP id
 d9443c01a7336-22e3311e625mr683035ad.48.1746463220803; 
 Mon, 05 May 2025 09:40:20 -0700 (PDT)
Received: from deb-101020-bm01.eng.stellus.in ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e1522948csm56957295ad.159.2025.05.05.09.40.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 09:40:20 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Mon, 5 May 2025 16:40:18 +0000
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: anisa.su887@gmail.com, qemu-devel@nongnu.org, nifan.cxl@gmail.com,
 dave@stgolabs.net, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 8/9] cxl-mailbox-utils: 0x5604 -  FMAPI Initiate DC Add
Message-ID: <aBjp8kvUDfwF-ksg@deb-101020-bm01.eng.stellus.in>
References: <20250317164204.2299371-1-anisa.su887@gmail.com>
 <20250317164204.2299371-9-anisa.su887@gmail.com>
 <20250424121959.0000042d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424121959.0000042d@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=anisa.su887@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Apr 24, 2025 at 12:19:59PM +0100, Jonathan Cameron wrote:
> On Mon, 17 Mar 2025 16:31:35 +0000
> anisa.su887@gmail.com wrote:
> 
> > From: Anisa Su <anisa.su@samsung.com>
> > 
> > FM DCD Management command 0x5604 implemented per CXL r3.2 Spec Section 7.6.7.6.5
> > 
> > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > ---
...
> > +        /* Create event record and insert to event log */
> > +        cxl_mbox_dc_event_create_record_hdr(ct3d, &event_rec.hdr);
> > +        event_rec.type = DC_EVENT_ADD_CAPACITY;
> > +        /* FIXME: for now, validity flag is cleared */
> 
> This stuff is probably all valid.  If we can return remaining extents though we might
> as well.
> 
> > +        event_rec.validity_flags = 0;
> > +        /* FIXME: Currently only support 1 host */
> > +        event_rec.host_id = 0;
> > +        /* updated_region_id only valid for DC_EVENT_REGION_CONFIG_UPDATED */
> > +        event_rec.updated_region_id = 0;
> 
> The event_rec is zeroed anyway so probably just don't set this at all
> and no need for the comment.
> 
> > +        for (i = 0; i < in->ext_count; i++) {
> 
> Why can't we combine this with the earlier loop and avoid the
> need for separate storage of extents in event_rec_exts?
> 
I discussed with Fan and for add specifically, we will need 2 loops
because the pending list is of type CXLDCExtentGroupList. We must use the
first loop to create a CXLDCExtentGroup from all of the extents and
append the entire thing to the pending list before triggering any interrupts for
event records.
This is necessary to preserve the ordering/grouping in order for the
memdev_add_rsp command to know what to remove from the pending list if
no extents were accepted.
But the storage of extents in event_rec_exts is unnecessary and for
release, we only need 1 loop.

Thanks,
Anisa
> > +            memcpy(&event_rec.dynamic_capacity_extent,
> > +                   &event_rec_exts[i],
> > +                   sizeof(CXLDCExtentRaw));
> > +
> > +            event_rec.flags = 0;
> > +            if (i < in->ext_count - 1) {
> > +                /* Set "More" flag */
> > +                event_rec.flags |= BIT(0);
> > +            }
> > +
> > +            if (cxl_event_insert(&ct3d->cxl_dstate,
> > +                                 CXL_EVENT_TYPE_DYNAMIC_CAP,
> > +                                 (CXLEventRecordRaw *)&event_rec)) {
> > +                cxl_event_irq_assert(ct3d);
> > +            }
> > +        }
> > +
> > +        return CXL_MBOX_SUCCESS;
> > +    default:
> > +        qemu_log_mask(LOG_UNIMP,
> > +                      "CXL extent selection policy not supported.\n");
> > +        return CXL_MBOX_INVALID_INPUT;
> > +    }
> > +
> > +    return CXL_MBOX_SUCCESS;
> > +}
> > +
> >  static const struct cxl_cmd cxl_cmd_set[256][256] = {
> >      [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
> >          cmd_infostat_bg_op_abort, 0, 0 },
> > @@ -3804,6 +3970,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
> >           CXL_MBOX_IMMEDIATE_DATA_CHANGE)},
> >      [FMAPI_DCD_MGMT][GET_DC_REGION_EXTENT_LIST] = { "GET_DC_REGION_EXTENT_LIST",
> >          cmd_fm_get_dc_region_extent_list, 12, 0},
> > +    [FMAPI_DCD_MGMT][INITIATE_DC_ADD] = { "INIT_DC_ADD",
> > +        cmd_fm_initiate_dc_add, ~0,
> > +        (CXL_MBOX_CONFIG_CHANGE_COLD_RESET |
> > +        CXL_MBOX_CONFIG_CHANGE_CONV_RESET |
> > +        CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
> > +        CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
> > +        CXL_MBOX_IMMEDIATE_DATA_CHANGE)},
> >  };
> >  
> >  /*
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index b742b2bb8d..ccc619fe10 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -1982,8 +1982,8 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
> >   * the list.
> >   * Return value: return true if has overlaps; otherwise, return false
> >   */
> > -static bool cxl_extents_overlaps_dpa_range(CXLDCExtentList *list,
> > -                                           uint64_t dpa, uint64_t len)
> > +bool cxl_extents_overlaps_dpa_range(CXLDCExtentList *list,
> > +                                    uint64_t dpa, uint64_t len)
> >  {
> >      CXLDCExtent *ent;
> >      Range range1, range2;
> > @@ -2028,8 +2028,8 @@ bool cxl_extents_contains_dpa_range(CXLDCExtentList *list,
> >      return false;
> >  }
> >  
> > -static bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
> > -                                                 uint64_t dpa, uint64_t len)
> > +bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
> > +                                          uint64_t dpa, uint64_t len)
> >  {
> >      CXLDCExtentGroup *group;
> >  
> > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> > index 217003a29d..1d5831a0b6 100644
> > --- a/include/hw/cxl/cxl_device.h
> > +++ b/include/hw/cxl/cxl_device.h
> > @@ -809,4 +809,8 @@ bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
> >  void cxl_assign_event_header(CXLEventRecordHdr *hdr,
> >                               const QemuUUID *uuid, uint32_t flags,
> >                               uint8_t length, uint64_t timestamp);
> > +bool cxl_extents_overlaps_dpa_range(CXLDCExtentList *list,
> > +                                    uint64_t dpa, uint64_t len);
> > +bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
> > +                                          uint64_t dpa, uint64_t len);
> >  #endif
> 

