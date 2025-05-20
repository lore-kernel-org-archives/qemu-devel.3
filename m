Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F3E9C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 16:24:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHPki-0005JX-GW; Tue, 20 May 2025 12:23:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1uHPkf-0005JI-TE
 for qemu-devel@nongnu.org; Tue, 20 May 2025 12:23:38 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1uHPkc-00018B-Lo
 for qemu-devel@nongnu.org; Tue, 20 May 2025 12:23:37 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-231c86bffc1so59030115ad.0
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 09:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747758211; x=1748363011; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vlIS5XkEiQcfpB33GU5iY3RFpQbWgrVE/LiB3jjgNCk=;
 b=WA6d5wHXD8B099Mv/kJFvJoQAu+WK8/PLgQZZvmN7T/BtZKpmstOHp0JMrHJ3uARfn
 1/LOxRln7poZQmQIjN5NgZBS8b4vZe2ODkGH7sxnFHnMQufoOTimJRtWYj9u4tPJxRrg
 yEN17I9kTYMzqqsPp3r2gb9KuPnyoD+pSF124dpMRaKOW5DGpHmCDcrZhhJDzyHbDh9Q
 mI4FfcSvXFA/LXznDMRPWKBZ140c8RQKThpcqeAcADBKeigplMhWlLQPNQ1EtPt2SPf8
 pTtsP71Jj5fTTan208wrALRmX33CLy5TsdZ5vLhnTc1sKO1pZkbioElFe2CiHW6V714t
 D+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747758211; x=1748363011;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vlIS5XkEiQcfpB33GU5iY3RFpQbWgrVE/LiB3jjgNCk=;
 b=T0mdF8MUHDYdvbyrIdLoB2u956+5ZQfznUYvYqjRsVn/n9MrJJ6v/i1pCcMSgn3DwY
 Qix9jXG11f8N0nK/3kYd9bNCPH9Ftv8LgrBVIIqTO4P63ST0ZIDVrGE7z0R79flHx2ym
 cIsR1mm929AAhaXy89bqLkmUsr0wP7yxp+Zr8x4/oz5YOBnBujAEaGY3oTp++Q8P+l1V
 SfXFYqnbKGeoJnd9+VD16e3bKiLnPzKmfde7ftdGKHoRKcPEk1u8VQjIrJ7kxJ3NMrvw
 cdu9Ld1q3k2JfPqnGuI6SIpCyoQRQuO4X9ydpgDl2dH18CgV5U1VfRrc02BTquokxQJ1
 bqeg==
X-Gm-Message-State: AOJu0YwwKVP7iNNG6q/ffk7CracSCqCW4E6PrQJ1gjazQGWYdtKGfoeC
 4fl/bvVP/aUP23FPc38hWTwbCzr6Yc+CY4AMG9MrfcKytKhgygwlFLlL
X-Gm-Gg: ASbGncsOSLIq9NUUMIRBVpMfhrB6HIOhyLrm00DvfN8pG0vpBgnBOw4fdcBFvF6lC/t
 3ZhX/zPQ56mGWJYhFXE/q1f3wXAVRRH+/SmFgujRFK90DRiGH+pYwNNcPmxZ42EgvmsRdtjTW3O
 GvPyDZyzxLvgBypSnaAKB/7CLzZVrjJoVnY9Dmq1q0YMzFNEzTQ04bNCZzD554wOK2hsIIORhjq
 nHAMHsrEFyWLFK8IYK1ll8HYxqdyxYXJHbxxlr4LsTX+p1A62S5vhOHF5FaK0qLzWVEJ+qv7MvJ
 5jI0qlQU1Aw8i/V54Gwn5+hsD2+EUN/UKFwKdenq0g==
X-Google-Smtp-Source: AGHT+IFVODoKkrtzlHVLin29APQi6H8q8atRsS0CZxOLTYpE/uHpUCwmNttZM212tup3D2nEt5OI/Q==
X-Received: by 2002:a17:902:dac5:b0:231:d16c:7f55 with SMTP id
 d9443c01a7336-231de21d5f5mr230631165ad.0.1747758209687; 
 Tue, 20 May 2025 09:23:29 -0700 (PDT)
Received: from lg ([2601:646:8f03:9fee:2c89:c0cf:1cbd:96d3])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4e97161sm78487625ad.153.2025.05.20.09.23.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 09:23:29 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 20 May 2025 09:23:25 -0700
To: anisa.su887@gmail.com
Cc: qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com,
 dave@stgolabs.net, linux-cxl@vger.kernel.org,
 Anisa Su <anisa.su@samsung.com>
Subject: Re: [PATCH v2 04/10] cxl-mailbox-utils: 0x5601 - FMAPI Get Host
 Region Config
Message-ID: <aCysfUNYZ4K-kNpA@lg>
References: <20250508001754.122180-1-anisa.su887@gmail.com>
 <20250508001754.122180-5-anisa.su887@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508001754.122180-5-anisa.su887@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pl1-x632.google.com
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

On Thu, May 08, 2025 at 12:01:00AM +0000, anisa.su887@gmail.com wrote:
> From: Anisa Su <anisa.su@samsung.com>
> 
> FM DCD Management command 0x5601 implemented per CXL r3.2 Spec Section 7.6.7.6.2
> 
> Signed-off-by: Anisa Su <anisa.su@samsung.com>

One minor comment inline. Otherwise,

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> ---
>  hw/cxl/cxl-mailbox-utils.c   | 102 +++++++++++++++++++++++++++++++++++
>  include/hw/cxl/cxl_opcodes.h |   1 +
>  2 files changed, 103 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index d3c69233b8..6afc45833d 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -3326,6 +3326,106 @@ static CXLRetCode cmd_fm_get_dcd_info(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +static void build_dsmas_flags(uint8_t *flags, CXLDCRegion *region)
> +{
> +    *flags = 0;
> +
> +    if (region->nonvolatile) {
> +        *flags |= BIT(CXL_DSMAS_FLAGS_NONVOLATILE);
> +    }
> +    if (region->sharable) {
> +        *flags |= BIT(CXL_DSMAS_FLAGS_SHARABLE);
> +    }
> +    if (region->hw_managed_coherency) {
> +        *flags |= BIT(CXL_DSMAS_FLAGS_HW_MANAGED_COHERENCY);
> +    }
> +    if (region->ic_specific_dc_management) {
> +        *flags |= BIT(CXL_DSMAS_FLAGS_IC_SPECIFIC_DC_MANAGEMENT);
> +    }
> +    if (region->rdonly) {
> +        *flags |= BIT(CXL_DSMAS_FLAGS_RDONLY);
> +    }
> +}
> +
> +/* CXL r3.2 section 7.6.7.6.2: Get Host DC Region Configuration (Opcode 5601h) */
> +static CXLRetCode cmd_fm_get_host_dc_region_config(const struct cxl_cmd *cmd,
> +                                                   uint8_t *payload_in,
> +                                                   size_t len_in,
> +                                                   uint8_t *payload_out,
> +                                                   size_t *len_out,
> +                                                   CXLCCI *cci)
> +{
> +    struct {
> +        uint16_t host_id;
> +        uint8_t region_cnt;
> +        uint8_t start_rid;
> +    } QEMU_PACKED *in = (void *)payload_in;
> +    struct {
> +        uint16_t host_id;
> +        uint8_t num_regions;
> +        uint8_t regions_returned;
> +        struct {
> +            uint64_t base;
> +            uint64_t decode_len;
> +            uint64_t region_len;
> +            uint64_t block_size;
> +            uint8_t dsmas_flags;
> +            uint8_t rsvd1[3];
> +            uint8_t sanitize;

We may have other flags in the future, maybe we want to generalize the
name of the field.  Maybe "flags"?

Fan
> +            uint8_t rsvd2[3];
> +        } QEMU_PACKED records[];
> +    } QEMU_PACKED *out = (void *)payload_out;
> +    struct {
> +        uint32_t num_extents_supported;
> +        uint32_t num_extents_available;
> +        uint32_t num_tags_supported;
> +        uint32_t num_tags_available;
> +    } QEMU_PACKED *extra_out;
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    uint16_t record_count, out_pl_len, i;
> +
> +    if (in->start_rid >= ct3d->dc.num_regions) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +    record_count = MIN(ct3d->dc.num_regions - in->start_rid, in->region_cnt);
> +
> +    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
> +    extra_out = (void *)out + out_pl_len;
> +    out_pl_len += sizeof(*extra_out);
> +
> +    assert(out_pl_len <= CXL_MAILBOX_MAX_PAYLOAD_SIZE);
> +
> +    stw_le_p(&out->host_id, 0);
> +    out->num_regions = ct3d->dc.num_regions;
> +    out->regions_returned = record_count;
> +
> +    for (i = 0; i < record_count; i++) {
> +        stq_le_p(&out->records[i].base,
> +                 ct3d->dc.regions[in->start_rid + i].base);
> +        stq_le_p(&out->records[i].decode_len,
> +                 ct3d->dc.regions[in->start_rid + i].decode_len /
> +                 CXL_CAPACITY_MULTIPLIER);
> +        stq_le_p(&out->records[i].region_len,
> +                 ct3d->dc.regions[in->start_rid + i].len);
> +        stq_le_p(&out->records[i].block_size,
> +                 ct3d->dc.regions[in->start_rid + i].block_size);
> +        build_dsmas_flags(&out->records[i].dsmas_flags,
> +                          &ct3d->dc.regions[in->start_rid + i]);
> +        /* Sanitize is bit 0 of flags. */
> +        out->records[i].sanitize =
> +            ct3d->dc.regions[in->start_rid + i].flags & BIT(0);
> +    }
> +
> +    stl_le_p(&extra_out->num_extents_supported, CXL_NUM_EXTENTS_SUPPORTED);
> +    stl_le_p(&extra_out->num_extents_available, CXL_NUM_EXTENTS_SUPPORTED -
> +             ct3d->dc.total_extent_count);
> +    stl_le_p(&extra_out->num_tags_supported, CXL_NUM_TAGS_SUPPORTED);
> +    stl_le_p(&extra_out->num_tags_available, CXL_NUM_TAGS_SUPPORTED);
> +
> +    *len_out = out_pl_len;
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  static const struct cxl_cmd cxl_cmd_set[256][256] = {
>      [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
>          cmd_infostat_bg_op_abort, 0, 0 },
> @@ -3450,6 +3550,8 @@ static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
>  static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
>      [FMAPI_DCD_MGMT][GET_DCD_INFO] = { "GET_DCD_INFO",
>          cmd_fm_get_dcd_info, 0, 0 },
> +    [FMAPI_DCD_MGMT][GET_HOST_DC_REGION_CONFIG] = { "GET_HOST_DC_REGION_CONFIG",
> +        cmd_fm_get_host_dc_region_config, 4, 0 },
>  };
>  
>  /*
> diff --git a/include/hw/cxl/cxl_opcodes.h b/include/hw/cxl/cxl_opcodes.h
> index c4c233665e..68ad68291c 100644
> --- a/include/hw/cxl/cxl_opcodes.h
> +++ b/include/hw/cxl/cxl_opcodes.h
> @@ -63,5 +63,6 @@ enum {
>          #define GET_MHD_INFO 0x0
>      FMAPI_DCD_MGMT = 0x56,
>          #define GET_DCD_INFO 0x0
> +        #define GET_HOST_DC_REGION_CONFIG 0x1
>      GLOBAL_MEMORY_ACCESS_EP_MGMT = 0X59
>  };
> -- 
> 2.47.2
> 

-- 
Fan Ni

