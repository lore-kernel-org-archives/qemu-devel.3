Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D34C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 16:00:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHPNz-0006Oj-SE; Tue, 20 May 2025 12:00:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1uHPNp-0006NU-Pf
 for qemu-devel@nongnu.org; Tue, 20 May 2025 12:00:04 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1uHPNk-0004lG-W0
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:59:59 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7398d65476eso4575473b3a.1
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 08:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747756795; x=1748361595; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dxkUkSoTkriwhtrET04LcZhmJfr7nP1NVw2CFVXLcZU=;
 b=EPb8VGyh6V7+bqUcxLP0m7rtfPU5W0Lv+gYslBhhsJjKSAjYa746lKRVcdcmCXhx0J
 V5qQuGRHb2mp7s7IvfSTJomHHMMsuAFKJMA5SIANZ7IWBYFQ5e/Rkz7NZly79kA0IjpA
 4kQ41O9qqXq0cJc2a1QvMOFYI/TtwBHr9PM8G7UUT1HGi+mSOuSrOkGM1Cr4ruQgjL9p
 0+Ws+IfJYkhKDCYbd60ASglvis2FR6xZcDxi/pNUbU6go8wDlCeKShGr0nHlMk6O6B/7
 JpG5PXHrFypig5sEmy8ndeEUPKq1zzUeHfxRwppvxcBvwcQubldRx6+NXiFopUHUUcEr
 /DgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747756795; x=1748361595;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dxkUkSoTkriwhtrET04LcZhmJfr7nP1NVw2CFVXLcZU=;
 b=ue11JPf8X/zJQgaUb4+SuyrmJF5iNcFHJwDFEJZVPMhHo6aWlfjAe8VdTU1hvlMeKm
 X2xSJGYfYbfdikYY2xqsjWLjHqtsFB1tt9DvfJyoqbuygyAmyRBH3TZzFhCe6+HV1Kew
 ggSOcgXux97+Gpk0kihOITr5GP2RXsvKZF9GigfyPGaOTOFGSLAdS4UFl2ViIcOPz3SY
 B/nzgAGXcxUUYce/DU+dhxbcc/5NMAJQBlUviiroxKXIvGjerrBulsUHkRSWq59MoeSp
 rVi8fCoAqG11VtCyOJFweLuEC58OQ7GaqoBuZvTYJj7Vje7Ynjch08w5ULefBsoR1Gl9
 TdSg==
X-Gm-Message-State: AOJu0Yz/iPjabCBciIjPBUJJN3a0vvgCWXFI1gtQ3mlucaP9k8tN+vwp
 i7SzGgnv+3g0HspeOVVD5jL+/aps0/ouDUhFsUO/KaU3RmS1qOalagjK
X-Gm-Gg: ASbGncsPgXCfT/RZGtKNZ/VszgRtqa7Owoq+ZFX1CafagOZlc3obhjL4kGq0aI2rJdX
 OfeeTnKpHvcFNfvOZPXA/e0ukU1hzDVtGrcfQMJmUJBudWyLtjdYtfH/kGCF453vDZY765xxAAs
 00yVRWsreyfW2UswYzp+SIA0s3Y/3TrnquRpz1khx4tzVDOguSBMv4S746HB4+fZ3rUE6LnM0X1
 0Zca1TExAy//Idwiw8t6yB4uze/H1mLGO1pRHzO8PheVwyb0lRppB1P4UbBjz6xSlkmr5jQ2roJ
 Wo4W0No5uwnCfb1Um5z1vEWfforLjuPHNveCCtd0xA==
X-Google-Smtp-Source: AGHT+IFhSKd7iF3ejVcnHITQ1SCG2P/RVTDXloMljVgV3hS2wwhTU8w7O1Ffa5vCZGp97tnR+U7Bmg==
X-Received: by 2002:a05:6a00:3d01:b0:740:58d3:71a8 with SMTP id
 d2e1a72fcca58-742a99fabb8mr21403693b3a.1.1747756795302; 
 Tue, 20 May 2025 08:59:55 -0700 (PDT)
Received: from lg ([2601:646:8f03:9fee:2c89:c0cf:1cbd:96d3])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a982b7ffsm8373038b3a.104.2025.05.20.08.59.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 08:59:54 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 20 May 2025 08:59:49 -0700
To: anisa.su887@gmail.com
Cc: qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com,
 dave@stgolabs.net, linux-cxl@vger.kernel.org,
 Anisa Su <anisa.su@samsung.com>
Subject: Re: [PATCH v2 02/10] cxl-mailbox-utils: 0x5600 - FMAPI Get DCD Info
Message-ID: <aCym9X9jfqlVi1V4@lg>
References: <20250508001754.122180-1-anisa.su887@gmail.com>
 <20250508001754.122180-3-anisa.su887@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508001754.122180-3-anisa.su887@gmail.com>
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

On Thu, May 08, 2025 at 12:00:58AM +0000, anisa.su887@gmail.com wrote:
> From: Anisa Su <anisa.su@samsung.com>
> 
> FM DCD Management command 0x5600 implemented per CXL 3.2 Spec Section 7.6.7.6.1.
> 
> Signed-off-by: Anisa Su <anisa.su@samsung.com>

LGTM. minor comments inline.

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> ---
>  hw/cxl/cxl-mailbox-utils.c   | 56 ++++++++++++++++++++++++++++++++++++
>  hw/cxl/i2c_mctp_cxl.c        |  6 ++--
>  hw/mem/cxl_type3.c           |  4 +++
>  include/hw/cxl/cxl_device.h  |  1 +
>  include/hw/cxl/cxl_opcodes.h |  3 ++
>  5 files changed, 68 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index ed3294530f..d3c69233b8 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -3280,6 +3280,52 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +/* CXL r3.2 section 7.6.7.6.1: Get DCD Info (Opcode 5600h) */
> +static CXLRetCode cmd_fm_get_dcd_info(const struct cxl_cmd *cmd,
> +                                      uint8_t *payload_in,
> +                                      size_t len_in,
> +                                      uint8_t *payload_out,
> +                                      size_t *len_out,
> +                                      CXLCCI *cci)
> +{
> +    struct {
> +        uint8_t num_hosts;
> +        uint8_t num_regions_supported;
> +        uint8_t rsvd1[2];
> +        uint16_t add_select_policy_bitmask;

           uint16_t supported_add_sel_policy_bitmask;

> +        uint8_t rsvd2[2];
> +        uint16_t release_select_policy_bitmask;

           uint16_t supported_removal_policy_bitmask;

Fan
> +        uint8_t sanitize_on_release_bitmask;
> +        uint8_t rsvd3;
> +        uint64_t total_dynamic_capacity;
> +        uint64_t region_blk_size_bitmasks[8];
> +    } QEMU_PACKED *out = (void *)payload_out;
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    CXLDCRegion *region;
> +    int i;
> +
> +    out->num_hosts = 1;
> +    out->num_regions_supported = ct3d->dc.num_regions;
> +    stw_le_p(&out->add_select_policy_bitmask,
> +             BIT(CXL_EXTENT_SELECTION_POLICY_PRESCRIPTIVE));
> +    stw_le_p(&out->release_select_policy_bitmask,
> +             BIT(CXL_EXTENT_REMOVAL_POLICY_PRESCRIPTIVE));
> +    out->sanitize_on_release_bitmask = 0;
> +
> +    stq_le_p(&out->total_dynamic_capacity,
> +             ct3d->dc.total_capacity / CXL_CAPACITY_MULTIPLIER);
> +
> +    for (i = 0; i < ct3d->dc.num_regions; i++) {
> +        region = &ct3d->dc.regions[i];
> +        memcpy(&out->region_blk_size_bitmasks[i],
> +               &region->supported_blk_size_bitmask,
> +               sizeof(out->region_blk_size_bitmasks[i]));
> +    }
> +
> +    *len_out = sizeof(*out);
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  static const struct cxl_cmd cxl_cmd_set[256][256] = {
>      [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
>          cmd_infostat_bg_op_abort, 0, 0 },
> @@ -3401,6 +3447,11 @@ static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
>                                       cmd_tunnel_management_cmd, ~0, 0 },
>  };
>  
> +static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
> +    [FMAPI_DCD_MGMT][GET_DCD_INFO] = { "GET_DCD_INFO",
> +        cmd_fm_get_dcd_info, 0, 0 },
> +};
> +
>  /*
>   * While the command is executing in the background, the device should
>   * update the percentage complete in the Background Command Status Register
> @@ -3703,7 +3754,12 @@ void cxl_initialize_t3_fm_owned_ld_mctpcci(CXLCCI *cci, DeviceState *d,
>                                             DeviceState *intf,
>                                             size_t payload_max)
>  {
> +    CXLType3Dev *ct3d = CXL_TYPE3(d);
> +
>      cxl_copy_cci_commands(cci, cxl_cmd_set_t3_fm_owned_ld_mctp);
> +    if (ct3d->dc.num_regions) {
> +        cxl_copy_cci_commands(cci, cxl_cmd_set_fm_dcd);
> +    }
>      cci->d = d;
>      cci->intf = intf;
>      cxl_init_cci(cci, payload_max);
> diff --git a/hw/cxl/i2c_mctp_cxl.c b/hw/cxl/i2c_mctp_cxl.c
> index 7d2cbc3b75..dd5fc4f393 100644
> --- a/hw/cxl/i2c_mctp_cxl.c
> +++ b/hw/cxl/i2c_mctp_cxl.c
> @@ -29,6 +29,7 @@
>  #include "hw/pci/pcie_port.h"
>  #include "hw/qdev-properties.h"
>  #include "hw/registerfields.h"
> +#include "hw/cxl/cxl_opcodes.h"
>  
>  #define TYPE_I2C_MCTP_CXL "i2c_mctp_cxl"
>  
> @@ -198,9 +199,10 @@ static void i2c_mctp_cxl_handle_message(MCTPI2CEndpoint *mctp)
>           */
>  
>          if (!(msg->message_type == MCTP_MT_CXL_TYPE3 &&
> -              msg->command_set < 0x51) &&
> +              msg->command_set < PHYSICAL_SWITCH) &&
>              !(msg->message_type == MCTP_MT_CXL_FMAPI &&
> -              msg->command_set >= 0x51 && msg->command_set < 0x56)) {
> +              msg->command_set >= PHYSICAL_SWITCH &&
> +              msg->command_set < GLOBAL_MEMORY_ACCESS_EP_MGMT)) {
>              buf->rc = CXL_MBOX_UNSUPPORTED;
>              st24_le_p(buf->pl_length, len_out);
>              s->len = s->pos;
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 11c38a9292..7129da0940 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -8,6 +8,7 @@
>   *
>   * SPDX-License-Identifier: GPL-v2-only
>   */
> +#include <math.h>
>  
>  #include "qemu/osdep.h"
>  #include "qemu/units.h"
> @@ -766,6 +767,8 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
>      uint64_t region_len;
>      uint64_t decode_len;
>      uint64_t blk_size = 2 * MiB;
> +    /* Only 1 block size is supported for now. */
> +    uint64_t supported_blk_size_bitmask = BIT((int) log2(blk_size));
>      CXLDCRegion *region;
>      MemoryRegion *mr;
>      uint64_t dc_size;
> @@ -811,6 +814,7 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
>              .block_size = blk_size,
>              /* dsmad_handle set when creating CDAT table entries */
>              .flags = 0,
> +            .supported_blk_size_bitmask = supported_blk_size_bitmask,
>          };
>          ct3d->dc.total_capacity += region->len;
>          region->blk_bitmap = bitmap_new(region->len / region->block_size);
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index ca515cab13..bebed04085 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -608,6 +608,7 @@ typedef struct CXLDCRegion {
>      uint32_t dsmadhandle;
>      uint8_t flags;
>      unsigned long *blk_bitmap;
> +    uint64_t supported_blk_size_bitmask;
>  } CXLDCRegion;
>  
>  typedef struct CXLSetFeatureInfo {
> diff --git a/include/hw/cxl/cxl_opcodes.h b/include/hw/cxl/cxl_opcodes.h
> index 26d3a99e8a..c4c233665e 100644
> --- a/include/hw/cxl/cxl_opcodes.h
> +++ b/include/hw/cxl/cxl_opcodes.h
> @@ -61,4 +61,7 @@ enum {
>          #define MANAGEMENT_COMMAND     0x0
>      MHD = 0x55,
>          #define GET_MHD_INFO 0x0
> +    FMAPI_DCD_MGMT = 0x56,
> +        #define GET_DCD_INFO 0x0
> +    GLOBAL_MEMORY_ACCESS_EP_MGMT = 0X59
>  };
> -- 
> 2.47.2
> 

-- 
Fan Ni

