Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7484C54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 13:38:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdVk5-0000U5-5O; Fri, 23 Feb 2024 08:37:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wj28.lee@gmail.com>)
 id 1rdPnl-0007zJ-WC
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 02:16:58 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wj28.lee@gmail.com>)
 id 1rdPnk-0000du-Gu
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 02:16:57 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1d911c2103aso4181985ad.0
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 23:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708672615; x=1709277415; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zt4y0iusXDXWfZiS3sX3qZDc0utPZM5TYOfbkIoo4AU=;
 b=PeFSJMJjRo75dRBBjp0ETj+diEjaQHP4Hq+aEREq3Gdy0obTf5vsn5XWqnxIyVfj1A
 qG0zRcsAEInK3BoLrJc2pLJzeX1052LcfsvNIIMoDZQl9jwS1peU/mvyhwxdctnAGtuc
 qTKAbHhKiZP7A+nTqgPM6y9beNMomT3fvQNlif2oqC9mWSndiu5FBPVihxYQXFVyFBCm
 1A7eM7U4Pu5c+uhQ1dScN61B/eSqWwss9hD2Y3nKN9dYeUVXyzXCLEpX3nK2Bho+kXTN
 EHc5Nyyivgqbzpn8cY5lCHkuODCqZxtTLQdsyzPplpeJq3LNgnvPG9/xW1cakV9kqDKY
 hUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708672615; x=1709277415;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zt4y0iusXDXWfZiS3sX3qZDc0utPZM5TYOfbkIoo4AU=;
 b=LvecLFx++4UKOFhMhZu7qKqf1+Fm/atJT+Ir1dMwz3fbW+uqeRFp6aFb0Q1emVw5Bn
 Xw+jDQbtgUn15pALpQZtohwhEnJ3BbioDC0H4dZn5vjARyS4KUQDr/XRWtrsj8Hc33yV
 TWs6n8BHDP88oAT8Yv+r9H2WMHRjDTVBahxMZcypGvXw2kpSNQldCpgDeMPRSmNYwCMV
 h1JJud7jhDqPe0px8dMH3wJ/Aim5G+tWSfk4x0Akjb+p+Ug/MHb7zry2czfxR70vs6d1
 IXo/DroKjbaaoi9pImtvPHnX/VF2EeOGAVLs45mMGxbcwmR1fRqCLJ2ACGkp5Z5qgX4b
 7v6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlBniHM+hU9OlnY10iy50DLjjCrtI+vwYmx0/qeVTzSSUhg7tOkpWXVjijMPVW3twzbFQi11N4b/Bj5zpu/XhCtMLpPcM=
X-Gm-Message-State: AOJu0YxRzinInBneP2huaUrS2GYtLpoMlvoIMCBveosv8Jlh27SYRptU
 knMkQpEUZpgT6ZoSFe700BnP5PwBDg2+dgcso2ObswYk2fDuCdAC
X-Google-Smtp-Source: AGHT+IEsD6/eqL694nm/5mE9RuBxkEC+4T3bbgV/cQIB7VosgKP0eDeGIiqYoJd0158WBuhZtW0qIw==
X-Received: by 2002:a17:902:930a:b0:1d9:3843:3f07 with SMTP id
 bc10-20020a170902930a00b001d938433f07mr1012172plb.61.1708672614581; 
 Thu, 22 Feb 2024 23:16:54 -0800 (PST)
Received: from [172.30.1.72] ([211.197.219.189])
 by smtp.gmail.com with ESMTPSA id
 r7-20020a170902be0700b001dc23e877bfsm4999873pls.268.2024.02.22.23.16.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Feb 2024 23:16:54 -0800 (PST)
Message-ID: <6fad2a96-aba6-46a1-a1ef-85be4faba59b@gmail.com>
Date: Fri, 23 Feb 2024 16:16:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/10] hw/mem/cxl_type3: Add DC extent list
 representative and get DC extent list mailbox support
Content-Language: en-US
To: nifan.cxl@gmail.com, qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 gregory.price@memverge.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net, nmtadam.samsung@gmail.com,
 jim.harris@samsung.com, Fan Ni <fan.ni@samsung.com>
References: <20240221182020.1086096-1-nifan.cxl@gmail.com>
 <20240221182020.1086096-8-nifan.cxl@gmail.com>
From: Wonjae Lee <wj28.lee@gmail.com>
In-Reply-To: <20240221182020.1086096-8-nifan.cxl@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=wj28.lee@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 23 Feb 2024 08:35:47 -0500
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

On 2024-02-22 오전 3:16, nifan.cxl@gmail.com wrote:
> From: Fan Ni <fan.ni@samsung.com>
> 
> Add dynamic capacity extent list representative to the definition of
> CXLType3Dev and add get DC extent list mailbox command per
> CXL.spec.3.1:.8.2.9.9.9.2.
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
> ---
>   hw/cxl/cxl-mailbox-utils.c  | 71 +++++++++++++++++++++++++++++++++++++
>   hw/mem/cxl_type3.c          |  1 +
>   include/hw/cxl/cxl_device.h | 23 ++++++++++++
>   3 files changed, 95 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index f95e417683..dae7fe00ed 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -83,6 +83,7 @@ enum {
>           #define CLEAR_POISON           0x2
>       DCD_CONFIG  = 0x48,
>           #define GET_DC_CONFIG          0x0
> +        #define GET_DYN_CAP_EXT_LIST   0x1
>       PHYSICAL_SWITCH = 0x51,
>           #define IDENTIFY_SWITCH_DEVICE      0x0
>           #define GET_PHYSICAL_PORT_STATE     0x1
> @@ -1344,6 +1345,73 @@ static CXLRetCode cmd_dcd_get_dyn_cap_config(const struct cxl_cmd *cmd,
>       return CXL_MBOX_SUCCESS;
>   }
>   
> +/*
> + * CXL r3.1 section 8.2.9.9.9.2:
> + * Get Dynamic Capacity Extent List (Opcode 4801h)
> + */
> +static CXLRetCode cmd_dcd_get_dyn_cap_ext_list(const struct cxl_cmd *cmd,
> +                                               uint8_t *payload_in,
> +                                               size_t len_in,
> +                                               uint8_t *payload_out,
> +                                               size_t *len_out,
> +                                               CXLCCI *cci)
> +{
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    struct get_dyn_cap_ext_list_in_pl {
> +        uint32_t extent_cnt;
> +        uint32_t start_extent_id;
> +    } QEMU_PACKED;
> +
> +    struct get_dyn_cap_ext_list_out_pl {
> +        uint32_t count;
> +        uint32_t total_extents;
> +        uint32_t generation_num;
> +        uint8_t rsvd[4];
> +        CXLDCExtentRaw records[];
> +    } QEMU_PACKED;
> +
> +    struct get_dyn_cap_ext_list_in_pl *in = (void *)payload_in;
> +    struct get_dyn_cap_ext_list_out_pl *out = (void *)payload_out;
> +    uint16_t record_count = 0, i = 0, record_done = 0;
> +    CXLDCExtentList *extent_list = &ct3d->dc.extents;
> +    CXLDCExtent *ent;
> +    uint16_t out_pl_len;
> +    uint32_t start_extent_id = in->start_extent_id;
> +
> +    if (start_extent_id > ct3d->dc.total_extent_count) {

Hello,

Shouldn't it be >= rather than >?

(I accidentally replied to v3 with the same comment above, so please 
ignore that.)

Thanks,
Wonjae


