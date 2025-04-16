Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C90C369C7
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 21:33:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5ANe-0004D9-5b; Wed, 16 Apr 2025 17:33:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1u5ANc-0004Ce-2o
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 17:33:12 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1u5ANZ-0001x7-Qq
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 17:33:11 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22928d629faso1354785ad.3
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 14:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744839188; x=1745443988; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=amn4jn7lQqQ0Q0RR/m3vaumX2/sKAJWhKEabhOf6ePw=;
 b=NW16y+lQ3IzVBUwD1moHhJLoaR7NDK+LbF8ITPEnphzNLNeUtf88GPHG/VGWL655ej
 yHTz7gEnF+v3y9Dk0roN4fiRWZDKOA9vAArrD4cF0qLSbY8VRDnYkX9wt9hxdmiUV0ov
 gM21CwJ/BgLRJ+YSPv6btIpgu4Ld5KPZ6fsC1xzHufQxPu1V+wjNnHdVtrpPwX6AblFs
 szRVGWvJNw3eh4RG7Wmp+WGd70oy2tvf52riTEgfoKvHrjet6aMSQeoo6qMkSkpe4Ikf
 KlCnIqD9X1a7TFLjjMJxmURYuu24pDs8xm56lSOjo/TAKi7gzP38kBVNUnr/iV/nvbBv
 QC3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744839188; x=1745443988;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=amn4jn7lQqQ0Q0RR/m3vaumX2/sKAJWhKEabhOf6ePw=;
 b=oTOgo4njm0Lxw+u7T3/IfhbSzkPO8tQScQpXOePYLmGxWgHphB6hyBP+pF1nEStova
 fif7ZFV4c15AfrbQviODnebFPZm5p17vkS+498jbYrK0WctIB/AaHHFoMEtZjDlaX26A
 8WCQwntPICUCCfpIu91Fz7aT+vQ9J+WYmC+VY5jP+C/VX0PCQOXCZ7WeNDDKxLjFGZae
 sGk39SwQ7jGef1pb72kVP3WKsAuB0nNoufea94fiWmC0/A21xhNaX1CFCEuM1cXvT8qf
 Oe6808qxwg54gMW3PnrNAK2zhva6nM/VgbyJ6V6JsC2Nz9JC5mRFbBeGIPsmGe4ebEKd
 oO2g==
X-Gm-Message-State: AOJu0YxN0O5lFlXobdumaSebZ7HT/QxG0Za3slczfXwme+3XZbJxjrTA
 Rd1vwRc0NPrnFYLPqMHLTsB6OK9OiQGNOzObws4Tu9FEAWpPc2pS
X-Gm-Gg: ASbGncsCRIO6eQKa4XOZ+WpOPHK6ZYL5Wf4BuNpLvvlkr9iUfDvHgVlnp+7To62XZ55
 XdPxrTCU30LSg+zTw3dAMLeyl/w47TLDKcTLdGOPR4SiRYq2KwVOAnP4Gy9MncgheWZZLp6s/me
 Tbmf2s1lw1Ty9361HDutHkIu+k1XEMSLjW4h43jeIrbaTXjOSL5YlHOZYctEGf98+cF0x6m6WRL
 38LjD9w9t+KoRm4T9bsBUIaPRgVb9OMy+MYjO4/JLgRdPA8C2oCJBf5yuZd/tO9hTtQJMMOhA7d
 3pVYg+y7mmrNHX7VbkMdJnalIeyzfcTcXAYju4u0hI9IrROBHwBkB0Sagg4X48zJme/Ct3zuXnv
 mAA==
X-Google-Smtp-Source: AGHT+IF8kXu3dAb1jHJKafOCkZeR/F2Da6MtK+i/e4pCN9Y2YKhk3P8lToDQV9T2JeDXdN26NJlEbA==
X-Received: by 2002:a17:902:e808:b0:223:2aab:462c with SMTP id
 d9443c01a7336-22c358d70femr51623255ad.15.1744839187726; 
 Wed, 16 Apr 2025 14:33:07 -0700 (PDT)
Received: from deb-101020-bm01.eng.stellus.in ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c33f1d07bsm19406045ad.94.2025.04.16.14.33.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 14:33:07 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Wed, 16 Apr 2025 21:33:05 +0000
To: anisa.su887@gmail.com
Cc: qemu-devel@nongnu.org, jonathan.cameron@huawei.com, nifan.cxl@gmail.com,
 dave@stgolabs.net, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 6/9] cxl-mailbox-utils: 0x5602 - FMAPI Set DC Region Config
Message-ID: <aAAiERk2XSs7xALX@deb-101020-bm01.eng.stellus.in>
References: <20250317164204.2299371-1-anisa.su887@gmail.com>
 <20250317164204.2299371-7-anisa.su887@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317164204.2299371-7-anisa.su887@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=anisa.su887@gmail.com; helo=mail-pl1-x630.google.com
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

On Mon, Mar 17, 2025 at 04:31:33PM +0000, anisa.su887@gmail.com wrote:
> From: Anisa Su <anisa.su@samsung.com>
> 
> FM DCD Management command 0x5602 implemented per CXL r3.2 Spec Section 7.6.7.6.3
> 
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c   | 100 +++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3.c           |   2 +-
>  include/hw/cxl/cxl_device.h  |   3 ++
>  include/hw/cxl/cxl_mailbox.h |   6 +++
>  4 files changed, 110 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 4bb51bf3e8..51ead2b152 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -125,6 +125,7 @@ enum {
>      FMAPI_DCD_MGMT = 0x56,
>          #define GET_DCD_INFO 0x0
>          #define GET_HOST_DC_REGION_CONFIG 0x1
> +        #define SET_DC_REGION_CONFIG 0x2
>  };
>  
>  /* CCI Message Format CXL r3.1 Figure 7-19 */
> @@ -3494,6 +3495,98 @@ static CXLRetCode cmd_fm_get_host_dc_region_config(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +static void cxl_mbox_dc_event_create_record_hdr(CXLType3Dev *ct3d,
> +                                                CXLEventRecordHdr *hdr)
> +{
> +    /*
> +     * CXL r3.1 section 8.2.9.2.1.6: Dynamic Capacity Event Record
> +     *
> +     * All Dynamic Capacity event records shall set the Event Record Severity
> +     * field in the Common Event Record Format to Informational Event. All
> +     * Dynamic Capacity related events shall be logged in the Dynamic Capacity
> +     * Event Log.
> +     */
> +    uint8_t flags = 1 << CXL_EVENT_TYPE_INFO;
> +
> +    st24_le_p(&hdr->flags, flags);
> +    hdr->length = sizeof(struct CXLEventDynamicCapacity);
> +    memcpy(&hdr->id, &dynamic_capacity_uuid, sizeof(hdr->id));
> +    stq_le_p(&hdr->timestamp, cxl_device_get_timestamp(&ct3d->cxl_dstate));
> +}
> +
> +/*
> + * CXL r3.2 section 7.6.7.6.3: Set Host DC Region Configuration (Opcode 5602)
> + */
> +static CXLRetCode cmd_fm_set_dc_region_config(const struct cxl_cmd *cmd,
> +                                              uint8_t *payload_in,
> +                                              size_t len_in,
> +                                              uint8_t *payload_out,
> +                                              size_t *len_out,
> +                                              CXLCCI *cci)
> +{
> +    struct {
> +        uint8_t reg_id;
> +        uint8_t rsvd[3];
> +        uint64_t block_sz;
> +        uint8_t flags;
> +        uint8_t rsvd2[3];
> +    } QEMU_PACKED *in;
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    CXLEventDynamicCapacity dcEvent = {};
> +    CXLDCRegion *region;
> +
> +    if (ct3d->dc.num_regions == 0) {
> +        return CXL_MBOX_UNSUPPORTED;
> +    }
> +
> +    /*
> +     * TODO: Fail with CXL_MBOX_INVALID_SECURITY_STATE if
> +     * device has been locked
> +     */
> +
> +    in = (void *)payload_in;
> +    region = &ct3d->dc.regions[in->reg_id];
> +
> +    /*
> +     * TODO: Fail if sanitize bit doesn't match current config and "the device
> +     * does not support reconfiguration of the Sanitize on Release setting."
> +     * Currently not reconfigurable, so always fail if sanitize bit
> +     * doesn't match.
> +     */
> +    if ((in->flags & 1) != (region->flags & 1)) {
> +        return CXL_MBOX_UNSUPPORTED;
> +    }
> +
> +    if (in->reg_id >= DCD_MAX_NUM_REGION) {
> +        return CXL_MBOX_UNSUPPORTED;
> +    }
> +
> +    /* Check that no extents are in the region being reconfigured */
> +    if (!bitmap_empty(region->blk_bitmap, region->len / region->block_size)) {
> +        return CXL_MBOX_UNSUPPORTED;
> +    }
> +
> +    /* Free bitmap and create new one for new block size. */
> +    g_free(region->blk_bitmap);
> +    region->blk_bitmap = bitmap_new(region->len / in->block_sz);
> +
forgot to update region blk_size
region->block_size = in->block_sz;

- Anisa
> +    /* Create event record and insert into event log */
> +    cxl_mbox_dc_event_create_record_hdr(ct3d, &dcEvent.hdr);
> +    dcEvent.type = DC_EVENT_REGION_CONFIG_UPDATED;
> +    /* FIXME: for now, validity flag is cleared */
> +    dcEvent.validity_flags = 0;
> +    /* FIXME: Currently only support 1 host */
> +    dcEvent.host_id = 0;
> +    dcEvent.updated_region_id = in->reg_id;
> +
> +    if (cxl_event_insert(&ct3d->cxl_dstate,
> +                        CXL_EVENT_TYPE_DYNAMIC_CAP,
> +                        (CXLEventRecordRaw *)&dcEvent)) {
> +        cxl_event_irq_assert(ct3d);
> +    }
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  static const struct cxl_cmd cxl_cmd_set[256][256] = {
>      [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
>          cmd_infostat_bg_op_abort, 0, 0 },
> @@ -3620,6 +3713,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
>          cmd_fm_get_dcd_info, 0, 0},
>      [FMAPI_DCD_MGMT][GET_HOST_DC_REGION_CONFIG] = { "GET_HOST_DC_REGION_CONFIG",
>          cmd_fm_get_host_dc_region_config, 4, 0},
> +    [FMAPI_DCD_MGMT][SET_DC_REGION_CONFIG] = { "SET_DC_REGION_CONFIG",
> +        cmd_fm_set_dc_region_config, 16,
> +        (CXL_MBOX_CONFIG_CHANGE_COLD_RESET |
> +         CXL_MBOX_CONFIG_CHANGE_CONV_RESET |
> +         CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
> +         CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
> +         CXL_MBOX_IMMEDIATE_DATA_CHANGE)},
>  };
>  
>  /*
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index ac74e62875..b742b2bb8d 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1686,7 +1686,7 @@ void qmp_cxl_inject_correctable_error(const char *path, CxlCorErrorType type,
>      pcie_aer_inject_error(PCI_DEVICE(obj), &err);
>  }
>  
> -static void cxl_assign_event_header(CXLEventRecordHdr *hdr,
> +void cxl_assign_event_header(CXLEventRecordHdr *hdr,
>                                      const QemuUUID *uuid, uint32_t flags,
>                                      uint8_t length, uint64_t timestamp)
>  {
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 81b826f570..217003a29d 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -806,4 +806,7 @@ void ct3_clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
>                                     uint64_t len);
>  bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
>                                    uint64_t len);
> +void cxl_assign_event_header(CXLEventRecordHdr *hdr,
> +                             const QemuUUID *uuid, uint32_t flags,
> +                             uint8_t length, uint64_t timestamp);
>  #endif
> diff --git a/include/hw/cxl/cxl_mailbox.h b/include/hw/cxl/cxl_mailbox.h
> index 8e1c7c5f15..820c411cbb 100644
> --- a/include/hw/cxl/cxl_mailbox.h
> +++ b/include/hw/cxl/cxl_mailbox.h
> @@ -8,6 +8,7 @@
>  #ifndef CXL_MAILBOX_H
>  #define CXL_MAILBOX_H
>  
> +#define CXL_MBOX_CONFIG_CHANGE_COLD_RESET (1)
>  #define CXL_MBOX_IMMEDIATE_CONFIG_CHANGE (1 << 1)
>  #define CXL_MBOX_IMMEDIATE_DATA_CHANGE (1 << 2)
>  #define CXL_MBOX_IMMEDIATE_POLICY_CHANGE (1 << 3)
> @@ -15,6 +16,11 @@
>  #define CXL_MBOX_SECURITY_STATE_CHANGE (1 << 5)
>  #define CXL_MBOX_BACKGROUND_OPERATION (1 << 6)
>  #define CXL_MBOX_BACKGROUND_OPERATION_ABORT (1 << 7)
> +#define CXL_MBOX_SECONDARY_MBOX_SUPPORTED (1 << 8)
> +#define CXL_MBOX_REQUEST_ABORT_BACKGROUND_OP_SUPPORTED (1 << 9)
> +#define CXL_MBOX_CEL_10_TO_11_VALID (1 << 10)
> +#define CXL_MBOX_CONFIG_CHANGE_CONV_RESET (1 << 11)
> +#define CXL_MBOX_CONFIG_CHANGE_CXL_RESET (1 << 12)
>  
>  #define CXL_LOG_CAP_CLEAR_SUPPORTED (1 << 0)
>  #define CXL_LOG_CAP_POPULATE_SUPPORTED (1 << 1)
> -- 
> 2.47.2
> 

