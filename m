Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3222AC83F03
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 16:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXMgw-0006Dd-IS; Thu, 03 Jul 2025 12:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1uXMgv-0006DF-5z
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 12:21:41 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1uXMgs-00062K-SX
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 12:21:40 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-748f5a4a423so123455b3a.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 09:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751559696; x=1752164496; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aZFeZiaK7j01bOKFMbxZm25zvRe4iY1lXYKU44Azw2Q=;
 b=TBrlkE1nOz5CJHmoqAvH1benYUhV6u49j7cC+qavrK74emTk+SRN9atVSSsqQ5E2Dc
 NWZbXbGCliYFiC1zFO0XN5u93jPR6mB+LM3/jVCvbI4B/TxWXy54oMTB3pDz3N/3Rszx
 /8JtQRbT7NbpQVukL1mtjf23uH0NZtXdw27y2+yrdm5+u5qdjan1hBDBFIpttaWrType
 WsqU8nshCWM+vvILtSHtAFzSkMMT2Ain5c4T7DWIc6Ttl5aXPWscsr5635/p5hhVh02H
 DfIcCF64sNYnwI7L7Brn2uQ2DZQLiIY8zOYUv1IaRNZ33MUL71XLhE/O8DnMjPlWRyi1
 EGrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751559696; x=1752164496;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aZFeZiaK7j01bOKFMbxZm25zvRe4iY1lXYKU44Azw2Q=;
 b=Fcs1YY+L89Sdsol0iKINiWAla4JMkWw848lJOGfh8aDKpnPDWgFi2jyv7qT5nuFhlZ
 3s4Ir6hzeo7HwgemOmsBQViXyDuW1fVBR7zosSgO49iA8bS24fWCMMjlFVaF3J5YrKFK
 16JJBqNxRZO6Y3HZGqCeKuy0M7L/+Dps2CUS/JxQK8l31SzYlBEFoilH2ucxaHUozX0Z
 h4lDRl9zCjL8HepKdp6TvutLjbd7pNDqmLwVSGu1tIPelt1mkCRrYWApzqXUCjrpQGFT
 oHKYZwvaUCGX2qTO+sIwNvOcZfuCsfDmcbfgpMp0+jb08C6iwJj2spx4TQhDmYooCb86
 /KBg==
X-Gm-Message-State: AOJu0YymXpBanq8zjSVJpzgVjW+dViLYUrX4zPDV8UQa5vgpV0+4MuMk
 EJPyI0KisXDCtPX782A4KPDapSRmUm/p2II6yBUpGPvFtIIVqAQNxu+U
X-Gm-Gg: ASbGncvPL8LttLSj4LL7lZIuGGV2pWMty8g13eoCBWz81i8La1ogqgbNukQh39wUF2O
 mGetO7u0Y+YZyw5zL6aJVV1SV5rRaEvG6TGPqp2/O5QXUNhYdQVY7FWItOJgZgelqe+5J9tSCIx
 qGGF8WxpLwr1dv5yllcIW4qbr4+lrWuf2LZRYUFv4qGQGv4LD7wYjznKFQs5S3eJcQk2jG5vucR
 rTq9DitOGka2qdAad1UqFYESFbKKz5IAsQLX/72uyRF+bRJFFe4+WtRgho7S9oTGxr53Flxtrri
 mBl5fWR4U6iKVlVD0niKOOF1x12DZcRGwLkbg0VGq7ZFJWdeDoy+y/gEl3IrouV0PQ==
X-Google-Smtp-Source: AGHT+IEywsg/XtG05fb3AGPsxsQcAMkuLAt7+/85wkPC54jqt0jKBL2TnqTBgDYXK2wUSU8PzvSZlw==
X-Received: by 2002:a05:6a00:848:b0:73e:10ea:b1e9 with SMTP id
 d2e1a72fcca58-74b5103e10amr9496914b3a.6.1751559695788; 
 Thu, 03 Jul 2025 09:21:35 -0700 (PDT)
Received: from smc-140338-bm01 ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74ce35d0014sm20436b3a.67.2025.07.03.09.21.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jul 2025 09:21:35 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Thu, 3 Jul 2025 16:21:33 +0000
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>,
 linux-cxl@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH qemu 09/11] hw/cxl: Create helper function to create DC
 Event Records from extents
Message-ID: <aGauDb295pVVBWiv@smc-140338-bm01>
References: <20250702160219.989731-1-Jonathan.Cameron@huawei.com>
 <20250702160219.989731-10-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702160219.989731-10-Jonathan.Cameron@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pf1-x433.google.com
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

On Wed, Jul 02, 2025 at 05:02:15PM +0100, Jonathan Cameron wrote:
> From: Anisa Su <anisa.su@samsung.com>
> 
> Prepatory patch for following FMAPI Add/Release Patches. Refactors part
> of qmp_cxl_process_dynamic_capacity_prescriptive() into a helper
> function to create DC Event Records and insert in the event log.
> 
> Moves definition for CXL_NUM_EXTENTS_SUPPORTED to cxl.h so it can be
> accessed by cxl-mailbox-utils.c and cxl-events.c, where the helper
> function is defined.
> 
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  include/hw/cxl/cxl.h        |  1 +
>  include/hw/cxl/cxl_device.h |  4 ++++
>  hw/cxl/cxl-events.c         | 38 +++++++++++++++++++++++++++++++++++++
>  hw/cxl/cxl-mailbox-utils.c  |  1 -
>  hw/mem/cxl_type3.c          | 37 +-----------------------------------
>  5 files changed, 44 insertions(+), 37 deletions(-)
> 
> diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
> index 75e47b6864..3ae4303383 100644
> --- a/include/hw/cxl/cxl.h
> +++ b/include/hw/cxl/cxl.h
> @@ -23,6 +23,7 @@
>  #define CXL_DEVICE_REG_BAR_IDX 2
>  
>  #define CXL_WINDOW_MAX 10
> +#define CXL_NUM_EXTENTS_SUPPORTED 512
>  
>  typedef struct PXBCXLDev PXBCXLDev;
>  
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 76af75d2d0..ed91e5387e 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -724,4 +724,8 @@ bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
>  void cxl_assign_event_header(CXLEventRecordHdr *hdr,
>                               const QemuUUID *uuid, uint32_t flags,
>                               uint8_t length, uint64_t timestamp);
> +void cxl_create_dc_event_records_for_extents(CXLType3Dev *ct3d,
> +                                             CXLDCEventType type,
> +                                             CXLDCExtentRaw extents[],
> +                                             uint32_t ext_count);
>  #endif
> diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
> index 12dee2e467..724055f2cf 100644
> --- a/hw/cxl/cxl-events.c
> +++ b/hw/cxl/cxl-events.c
> @@ -260,3 +260,41 @@ void cxl_event_irq_assert(CXLType3Dev *ct3d)
>          }
>      }
>  }
> +
> +void cxl_create_dc_event_records_for_extents(CXLType3Dev *ct3d,
> +                                             CXLDCEventType type,
> +                                             CXLDCExtentRaw extents[],
> +                                             uint32_t ext_count)
> +{
> +    CXLEventDynamicCapacity event_rec = {};
> +    int i;
> +
> +    cxl_assign_event_header(&event_rec.hdr,
> +                            &dynamic_capacity_uuid,
> +                            (1 << CXL_EVENT_TYPE_INFO),
> +                            sizeof(event_rec),
> +                            cxl_device_get_timestamp(&ct3d->cxl_dstate));
> +    event_rec.type = type;
> +    event_rec.validity_flags = 1;
> +    event_rec.host_id = 0;
> +    event_rec.updated_region_id = 0;
> +    event_rec.extents_avail = CXL_NUM_EXTENTS_SUPPORTED -
> +                              ct3d->dc.total_extent_count;
> +
> +    for (i = 0; i < ext_count; i++) {
> +        memcpy(&event_rec.dynamic_capacity_extent,
> +               &extents[i],
> +               sizeof(CXLDCExtentRaw));
> +        event_rec.flags = 0;
> +        if (i < ext_count - 1) {
> +            /* Set "More" flag */
> +            event_rec.flags |= BIT(0);
> +        }
> +
> +        if (cxl_event_insert(&ct3d->cxl_dstate,
> +                             CXL_EVENT_TYPE_DYNAMIC_CAP,
> +                             (CXLEventRecordRaw *)&event_rec)) {
> +            cxl_event_irq_assert(ct3d);
> +        }
> +    }
> +}
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 24e4ba0200..d0a1d63582 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -27,7 +27,6 @@
>  
>  #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
>  #define CXL_DC_EVENT_LOG_SIZE 8
> -#define CXL_NUM_EXTENTS_SUPPORTED 512
>  #define CXL_NUM_TAGS_SUPPORTED 0
>  #define CXL_ALERTS_LIFE_USED_WARN_THRESH (1 << 0)
>  #define CXL_ALERTS_OVER_TEMP_WARN_THRESH (1 << 1)
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index ee554a77be..9c2b9d197b 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1957,15 +1957,11 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
>          CxlDynamicCapacityExtentList *records, Error **errp)
>  {
>      Object *obj;
> -    CXLEventDynamicCapacity dCap = {};
> -    CXLEventRecordHdr *hdr = &dCap.hdr;
>      CXLType3Dev *dcd;
> -    uint8_t flags = 1 << CXL_EVENT_TYPE_INFO;
>      uint32_t num_extents = 0;
>      CxlDynamicCapacityExtentList *list;
>      CXLDCExtentGroup *group = NULL;
>      g_autofree CXLDCExtentRaw *extents = NULL;
> -    uint8_t enc_log = CXL_EVENT_TYPE_DYNAMIC_CAP;
>      uint64_t dpa, offset, len, block_size;
>      g_autofree unsigned long *blk_bitmap = NULL;
>      int i;
> @@ -2078,38 +2074,7 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
>          dcd->dc.total_extent_count += num_extents;
>      }
>  
> -    /*
> -     * CXL r3.1 section 8.2.9.2.1.6: Dynamic Capacity Event Record
> -     *
> -     * All Dynamic Capacity event records shall set the Event Record Severity
> -     * field in the Common Event Record Format to Informational Event. All
> -     * Dynamic Capacity related events shall be logged in the Dynamic Capacity
> -     * Event Log.
> -     */
> -    cxl_assign_event_header(hdr, &dynamic_capacity_uuid, flags, sizeof(dCap),
> -                            cxl_device_get_timestamp(&dcd->cxl_dstate));
> -
> -    dCap.type = type;
> -    /* FIXME: for now, validity flag is cleared */
> -    dCap.validity_flags = 0;
> -    stw_le_p(&dCap.host_id, hid);
> -    /* only valid for DC_REGION_CONFIG_UPDATED event */
> -    dCap.updated_region_id = 0;
> -    for (i = 0; i < num_extents; i++) {
> -        memcpy(&dCap.dynamic_capacity_extent, &extents[i],
> -               sizeof(CXLDCExtentRaw));
> -
> -        dCap.flags = 0;
> -        if (i < num_extents - 1) {
> -            /* Set "More" flag */
> -            dCap.flags |= BIT(0);
> -        }
> -
> -        if (cxl_event_insert(&dcd->cxl_dstate, enc_log,
> -                             (CXLEventRecordRaw *)&dCap)) {
> -            cxl_event_irq_assert(dcd);
> -        }
> -    }
> +    cxl_create_dc_event_records_for_extents(dcd, type, extents, num_extents);
>  }
>  
>  void qmp_cxl_add_dynamic_capacity(const char *path, uint16_t host_id,
> -- 
> 2.48.1
> 

-- 
Fan Ni (From gmail)

