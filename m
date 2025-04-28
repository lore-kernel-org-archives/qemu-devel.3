Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD8B3C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 20:44:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9VKp-0003EA-7q; Mon, 28 Apr 2025 16:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1u9VKk-0003Cv-Uz
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 16:44:12 -0400
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1u9VKi-0006Vq-9o
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 16:44:09 -0400
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-4775ce8a4b0so108169541cf.1
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 13:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745873045; x=1746477845; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4zd0GN4l+W7tGH06TegEGwIQ2pHoD4ic50dAUxlBrg8=;
 b=fiKMiiYMWwh/X2CwGSWRIajVdx+2WFZhVwaDNebda15ArzDjTpdOGxXqAWR8eib/ur
 ipMJiSkIStikl2BtY9MePQaqhfCZQi83fCZFz5RxBZEU9Fg8/MLMvgal5xXa4RSRgovw
 I5zLxvL+owVHbeKzeozYO4snQnnH7qZ9S2/M0fPq4sud0whoHdFA8jCItFi6e9SQnb1L
 dSOCUuKzzs1wS1AexkFPe86Vep7rAlauMHl7mzVjWbiPoyFmZ6OuSchiWAp/h/9qCwdK
 dZL4ECo5+xH93K4sz7A5sID4uVIjilFtMgI3MZrj/Leazvdl8jgxURqiy/7P1lrKM0nd
 jOgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745873045; x=1746477845;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4zd0GN4l+W7tGH06TegEGwIQ2pHoD4ic50dAUxlBrg8=;
 b=Bv9PKaleet15RoHlemoAe53uuohW3xtT2jKdfMqgSE41K4L1geB7mlUz9dRCMbW/aV
 6X5vVWG0Zh/kEA13+RTallKmqDrePiOfAnP1i13ovwhdntYeafMiqpLhVjEMEM3m3pbG
 qarq24vHRn81+KMvUNImamlok+STesfockY9uN5CHih0koLwVKliJyfA6xR5nNVgsP8t
 zxFTMQZ84yHdzARn3ZFHRerEyeGh3Wb6a0hf4qpHzCpdh4YBeTxbyU3bGHATJ7xZ1e9e
 IuSwewL3m0MDTHtK3okwpZs39d1JM8NTC9Odxdk5jLDEDZYRGYAYE+ZlxX9jZwCs0R82
 6pfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMyQOffSPy/BO9gGE0vay7mMtc4fDCJ6rsi8Fi/tKVEUYqwChqNz6vOi5uN/pKCATatsviejBtmRoA@nongnu.org
X-Gm-Message-State: AOJu0YxXKtEHwXTxToWUfGJaY9K1XyB07afkpFKi1xoinao5fuX627gX
 uir9Af6bkAIwIm23Ew/ugzjcM/V5Hsfqm1eznX6mV8tOH91fknTg
X-Gm-Gg: ASbGncvq9KKNCPON1BsSH93Ti1y5sMQbov79CauSA2XtuffZgbQTF1pC1TCSR/LV55G
 qAFIOuN8eHdDRyDO9s/btNdV6GinfS1mYdX60WV3GNYNxrId0kMk5+dEYS1twwmcG1bZje5+Lp8
 sh1JvSBUwvH52UA58bX+Okjcuygk3eyjWdQHNizfVizfiwZJlG2U2dDRSE32sd8lpg0g5iXtImP
 5PZlI/1Ak0FqvHNm6MVqSkPCfpa622BIbGhC3ewLGSrskbgw/aeGrwJGHEkGovqJi4AZvf8qU44
 C4fJb6iK0t/y/M7Z9OXN/MmZpAJyy6AtJhWjS3cizNHKYBU=
X-Google-Smtp-Source: AGHT+IHdl3eLAzRBxdQFzr8/xHozPYez1pJyqoesPlbyf32cu4ZoDrFIaIRHBsD5NzMXUbsC5nXu2A==
X-Received: by 2002:a05:622a:1a9e:b0:476:7e72:3538 with SMTP id
 d75a77b69052e-48133752379mr169687231cf.50.1745873045428; 
 Mon, 28 Apr 2025 13:44:05 -0700 (PDT)
Received: from debian ([2607:fb90:37e2:c851:8e4d:2d6e:a358:8db0])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-47ea1692d85sm72220261cf.61.2025.04.28.13.44.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 13:44:04 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Mon, 28 Apr 2025 13:44:01 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: anisa.su887@gmail.com, qemu-devel@nongnu.org, nifan.cxl@gmail.com,
 dave@stgolabs.net, linux-cxl@vger.kernel.org,
 Anisa Su <anisa.su@samsung.com>
Subject: Re: [PATCH 9/9] cxl-mailbox-utils: 0x5605 - FMAPI Initiate DC Release
Message-ID: <aA_okWIcD3msM7y1@debian>
References: <20250317164204.2299371-1-anisa.su887@gmail.com>
 <20250317164204.2299371-10-anisa.su887@gmail.com>
 <20250424122308.00004e8e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424122308.00004e8e@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=nifan.cxl@gmail.com; helo=mail-qt1-x82b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu, Apr 24, 2025 at 12:23:08PM +0100, Jonathan Cameron wrote:
> On Mon, 17 Mar 2025 16:31:36 +0000
> anisa.su887@gmail.com wrote:
> 
> > From: Anisa Su <anisa.su@samsung.com>
> > 
> > FM DCD Managment command 0x5605 implemented per CXL r3.2 Spec Section 7.6.7.6.6
> > 
> > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> Similar comments to patch 8 around the double loop.
> 
> I'd also like Fan to take a look through these (v2 probably)
> as he's messed with DCD a lot more than me!

It is true we can avoid the double loop here. 
Since the input payload is already CXLDCExtentRaw. 
Previous in QMP implementation, we need it as the input is different, we did
not have start_dpa directly, but an offset to the start of a region.

Fan
> 
> Thanks,
> 
> Jonathan
> 
> > ---
> >  hw/cxl/cxl-mailbox-utils.c | 94 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 94 insertions(+)
> > 
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index 5bcbd434b7..37810d892f 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -128,6 +128,7 @@ enum {
> >          #define SET_DC_REGION_CONFIG 0x2
> >          #define GET_DC_REGION_EXTENT_LIST 0x3
> >          #define INITIATE_DC_ADD           0x4
> > +        #define INITIATE_DC_RELEASE       0x5
> >  
> >  };
> >  
> > @@ -3722,6 +3723,10 @@ static CXLRetCode cxl_mbox_dc_prescriptive_sanity_check(CXLType3Dev *dcd,
> >                                                 ext.start_dpa, ext.len)) {
> >                  return CXL_MBOX_INVALID_EXTENT_LIST;
> >              }
> > +        } else if (type == DC_EVENT_RELEASE_CAPACITY) {
> > +            if (!ct3_test_region_block_backed(dcd, ext.start_dpa, ext.len)) {
> > +                return CXL_MBOX_INVALID_PA;
> > +            }
> >          }
> >      }
> >  
> > @@ -3835,6 +3840,88 @@ static CXLRetCode cmd_fm_initiate_dc_add(const struct cxl_cmd *cmd,
> >      return CXL_MBOX_SUCCESS;
> >  }
> >  
> > +/*
> > + * CXL r3.2 Section 7.6.7.6.6 Initiate Dynamic Capacity Release (Opcode 5605h)
> > + */
> > +static CXLRetCode cmd_fm_initiate_dc_release(const struct cxl_cmd *cmd,
> > +                                             uint8_t *payload_in,
> > +                                             size_t len_in,
> > +                                             uint8_t *payload_out,
> > +                                             size_t *len_out,
> > +                                             CXLCCI *cci)
> > +{
> > +    struct {
> > +        uint16_t host_id;
> > +        uint8_t flags;
> > +        uint8_t reg_num;
> > +        uint64_t length;
> > +        uint8_t tag[0x10];
> > +        uint32_t ext_count;
> > +        CXLDCExtentRaw extents[];
> > +    } QEMU_PACKED *in = (void *)payload_in;
> > +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> > +    g_autofree CXLDCExtentRaw *event_rec_exts = NULL;
> > +    CXLEventDynamicCapacity event_rec = {};
> > +    CXLDCExtentRaw ext;
> > +    int i, rc = 0;
> 
> Prefer not to combine cases where you init and ones where you don't.
> Just use 2 lines instead.
> 
> > +
> > +    switch (in->flags & 0x7) {
> 
> That 7 needs a define.
> 
> > +    case CXL_EXTENT_REMOVAL_POLICY_PRESCRIPTIVE:
> > +        rc = cxl_mbox_dc_prescriptive_sanity_check(ct3d,
> > +                                                   in->host_id,
> > +                                                   in->ext_count,
> > +                                                   in->extents,
> > +                                                   DC_EVENT_RELEASE_CAPACITY);
> > +        if (rc) {
> > +            return rc;
> > +        }
> > +
> > +        /* Create extents for Event Record */
> > +        event_rec_exts = g_new0(CXLDCExtentRaw, in->ext_count);
> > +        for (i = 0; i < in->ext_count; i++) {
> > +            ext = in->extents[i];
> > +            event_rec_exts[i].start_dpa = ext.start_dpa;
> > +            event_rec_exts[i].len = ext.len;
> > +            memset(event_rec_exts[i].tag, 0, 0x10);
> > +            event_rec_exts[i].shared_seq = 0;
> > +        }
> 
> Similar to before. I'm not currently following the reason for the local
> storage.
> 
> > +
> > +        /* Create event record and insert to event log */
> > +        cxl_mbox_dc_event_create_record_hdr(ct3d, &event_rec.hdr);
> > +        event_rec.type = DC_EVENT_RELEASE_CAPACITY;
> > +        /* FIXME: for now, validity flag is cleared */
> > +        event_rec.validity_flags = 0;
> > +        /* FIXME: Currently only support 1 host */
> > +        event_rec.host_id = 0;
> > +        /* updated_region_id only valid for DC_EVENT_REGION_CONFIG_UPDATED */
> > +        event_rec.updated_region_id = 0;
> > +        for (i = 0; i < in->ext_count; i++) {
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
> > +        return CXL_MBOX_SUCCESS;
> > +    default:
> > +        qemu_log_mask(LOG_UNIMP,
> > +            "CXL extent selection policy not supported.\n");
> > +        return CXL_MBOX_INVALID_INPUT;
> > +    }
> > +
> > +    return CXL_MBOX_SUCCESS;
> > +}
> > +
> >  static const struct cxl_cmd cxl_cmd_set[256][256] = {
> >      [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
> >          cmd_infostat_bg_op_abort, 0, 0 },
> > @@ -3977,6 +4064,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
> >          CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
> >          CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
> >          CXL_MBOX_IMMEDIATE_DATA_CHANGE)},
> > +    [FMAPI_DCD_MGMT][INITIATE_DC_RELEASE] = { "INIT_DC_RELEASE",
> > +        cmd_fm_initiate_dc_release, ~0,
> > +        (CXL_MBOX_CONFIG_CHANGE_COLD_RESET |
> > +         CXL_MBOX_CONFIG_CHANGE_CONV_RESET |
> > +         CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
> > +         CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
> > +         CXL_MBOX_IMMEDIATE_DATA_CHANGE)},
> >  };
> >  
> >  /*
> 

