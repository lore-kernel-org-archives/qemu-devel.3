Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE31DC48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 18:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb2vs-0000eg-Uh; Fri, 16 Feb 2024 13:27:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rb2vq-0000eH-5T
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 13:27:30 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rb2vo-00005L-8b
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 13:27:29 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6e08dd0c7eeso1524230b3a.1
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 10:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708108047; x=1708712847; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XZmwPG3PlOOCsVBQBG5AibLUXpR6Zlx7US+ZbDcfVX0=;
 b=jipy2D5a8ftq/Mhv6/AFEjKBgkjgXd3vyxW//YBchs2kMKkYDIYrzdbl4oABBabMbn
 kZbnCYDoC3Eaw1vWaBEkK4i5EoU+ANy2iT0Rlekmg2bzerIYY3hJr9HvsVfPS5ap7bcQ
 aCVlClFz5XBWNlj119CoKUf/ivsfl38/1Qjp6K2F2OwVRPOjwPnkRkPbOqHt2sY+gBpc
 59icm/n4ByiGU2SZTdEgUee06uYBD9JiP82bVsYpUWj4uM3GE7nFKDrSutaeJn1+wJh4
 bUHFXXQhyjmEyx/8foTkfL3kAp/h3m7fTvFVf0IJ0KXEDA6WCk9/J4nk5d1r96cONLap
 xBqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708108047; x=1708712847;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XZmwPG3PlOOCsVBQBG5AibLUXpR6Zlx7US+ZbDcfVX0=;
 b=taG3OEx7rjnqDOfgUCGAGNuyXXOQTuwe5IrZmcdIsEMIIWLbtM8rjv02sWMlg2ByDq
 cBMm6BBMyk2QfZ3lrcBFGLKUfDqsepkrmjZHq3In98T7zRkfztXcQFwqnwnmEtCuzAL7
 yrXkuiIF/DIAnYLWcCcl7Ji6dLcO/bB+7ry1GR4Qn5IHvzObLNkwpda5wJwF5MjDh+Tv
 693kEODTbZMUmjrlTsKev+jqMM2ajj1OPTZvozKJ7uyRsjZbRYzTcYQrOVWU0Om3rx0n
 o8tkS3TY9YMiguogTG+Pi04foiycMLV4v9Y37+5AuTaB2EFC10OC9f/7bGTas3LVHTLP
 +1mw==
X-Gm-Message-State: AOJu0YyijMzV+4AyIxNniJ8nT0gKJfqj+hTcjYazM9IBrVVysaAkaQM2
 3cNgbJro6/pxLxTQ2vv6IquP3G6fL36Xp3U5Ym14CSvKmENxft5t
X-Google-Smtp-Source: AGHT+IEbxYP76EHZurhcBbCCrjWqFT9GN22E5Zkp1OA1+ZH+dojBiDE8HubzYkn8Q8IJRCtnPsZLlQ==
X-Received: by 2002:a62:8182:0:b0:6e0:51a9:7c65 with SMTP id
 t124-20020a628182000000b006e051a97c65mr5171938pfd.21.1708108046585; 
 Fri, 16 Feb 2024 10:27:26 -0800 (PST)
Received: from debian ([2601:641:300:14de:f1a:387c:5c5c:3099])
 by smtp.gmail.com with ESMTPSA id
 f10-20020a056a001aca00b006e1377847bdsm259051pfv.50.2024.02.16.10.27.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 10:27:26 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Fri, 16 Feb 2024 10:27:24 -0800
To: shiju.jose@huawei.com
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 jonathan.cameron@huawei.com, tanxiaofei@huawei.com,
 prime.zeng@hisilicon.com, linuxarm@huawei.com, fan.ni@samsung.com
Subject: Re: [PATCH v3 2/3] hw/cxl/cxl-mailbox-utils: Add device patrol scrub
 control feature
Message-ID: <Zc-pDBKdWkkda04t@debian>
References: <20240215110146.1444-1-shiju.jose@huawei.com>
 <20240215110146.1444-3-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215110146.1444-3-shiju.jose@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pf1-x42d.google.com
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

On Thu, Feb 15, 2024 at 07:01:45PM +0800, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> CXL spec 3.1 section 8.2.9.9.11.1 describes the device patrol scrub control
> feature. The device patrol scrub proactively locates and makes corrections
> to errors in regular cycle. The patrol scrub control allows the request to
> configure patrol scrub input configurations.
> 
> The patrol scrub control allows the requester to specify the number of
> hours for which the patrol scrub cycles must be completed, provided that
> the requested number is not less than the minimum number of hours for the
> patrol scrub cycle that the device is capable of. In addition, the patrol
> scrub controls allow the host to disable and enable the feature in case
> disabling of the feature is needed for other purposes such as
> performance-aware operations which require the background operations to be
> turned off.
> 
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  hw/cxl/cxl-mailbox-utils.c | 97 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 96 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index f761ac49b5..9557c38dd9 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -997,6 +997,7 @@ typedef struct CXLSupportedFeatureEntry {
>  } QEMU_PACKED CXLSupportedFeatureEntry;
>  
>  enum CXL_SUPPORTED_FEATURES_LIST {
> +    CXL_FEATURE_PATROL_SCRUB = 0,
>      CXL_FEATURE_MAX
>  };
>  
> @@ -1037,6 +1038,37 @@ enum CXL_SET_FEATURE_FLAG_DATA_TRANSFER {
>      CXL_SET_FEATURE_FLAG_DATA_TRANSFER_MAX
>  };
>  
> +/* CXL r3.1 section 8.2.9.9.11.1: Device Patrol Scrub Control Feature */
> +static const QemuUUID patrol_scrub_uuid = {
> +    .data = UUID(0x96dad7d6, 0xfde8, 0x482b, 0xa7, 0x33,
> +                 0x75, 0x77, 0x4e, 0x06, 0xdb, 0x8a)
> +};
> +
> +#define CXL_MEMDEV_PS_GET_FEATURE_VERSION    0x01
> +#define CXL_MEMDEV_PS_SET_FEATURE_VERSION    0x01
> +#define CXL_MEMDEV_PS_SCRUB_CYCLE_CHANGE_CAP_DEFAULT    BIT(0)
> +#define CXL_MEMDEV_PS_SCRUB_REALTIME_REPORT_CAP_DEFAULT    BIT(1)
> +#define CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_DEFAULT    12
> +#define CXL_MEMDEV_PS_MIN_SCRUB_CYCLE_DEFAULT    1
> +#define CXL_MEMDEV_PS_ENABLE_DEFAULT    0
> +
> +/* CXL memdev patrol scrub control attributes */
> +struct CXLMemPatrolScrubReadAttrbs {
> +        uint8_t scrub_cycle_cap;
> +        uint16_t scrub_cycle;
> +        uint8_t scrub_flags;
> +} QEMU_PACKED cxl_memdev_ps_feat_read_attrbs;
> +
> +typedef struct CXLMemPatrolScrubWriteAttrbs {
> +    uint8_t scrub_cycle_hr;
> +    uint8_t scrub_flags;
> +} QEMU_PACKED CXLMemPatrolScrubWriteAttrbs;
> +
> +typedef struct CXLMemPatrolScrubSetFeature {
> +        CXLSetFeatureInHeader hdr;
> +        CXLMemPatrolScrubWriteAttrbs feat_data;
> +} QEMU_PACKED QEMU_ALIGNED(16) CXLMemPatrolScrubSetFeature;
> +
>  /* CXL r3.1 section 8.2.9.6.1: Get Supported Features (Opcode 0500h) */
>  static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
>                                               uint8_t *payload_in,
> @@ -1060,7 +1092,7 @@ static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
>      uint16_t feat_entries = 0;
>  
>      if (get_feats_in->count < sizeof(CXLSupportedFeatureHeader) ||
> -        get_feats_in->start_index > CXL_FEATURE_MAX) {
> +        get_feats_in->start_index >= CXL_FEATURE_MAX) {
>          return CXL_MBOX_INVALID_INPUT;
>      }
>      req_entries = (get_feats_in->count -
> @@ -1072,6 +1104,31 @@ static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
>      entry = 0;
>      while (entry < req_entries) {
>          switch (index) {
> +        case  CXL_FEATURE_PATROL_SCRUB:
> +            /* Fill supported feature entry for device patrol scrub control */
> +            get_feats_out->feat_entries[entry] =
> +                           (struct CXLSupportedFeatureEntry) {
> +                .uuid = patrol_scrub_uuid,
> +                .feat_index = index,
> +                .get_feat_size = sizeof(cxl_memdev_ps_feat_read_attrbs),
> +                .set_feat_size = sizeof(CXLMemPatrolScrubWriteAttrbs),
> +                /* Bit[0] : 1, feature attributes changeable */
> +                .attrb_flags = 0x1,
> +                .get_feat_version = CXL_MEMDEV_PS_GET_FEATURE_VERSION,
> +                .set_feat_version = CXL_MEMDEV_PS_SET_FEATURE_VERSION,
> +                .set_feat_effects = 0,
> +            };
> +            feat_entries++;
> +            /* Set default value for device patrol scrub read attributes */
> +            cxl_memdev_ps_feat_read_attrbs.scrub_cycle_cap =
> +                                CXL_MEMDEV_PS_SCRUB_CYCLE_CHANGE_CAP_DEFAULT |
> +                                CXL_MEMDEV_PS_SCRUB_REALTIME_REPORT_CAP_DEFAULT;
> +            cxl_memdev_ps_feat_read_attrbs.scrub_cycle =
> +                                CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_DEFAULT |
> +                                (CXL_MEMDEV_PS_MIN_SCRUB_CYCLE_DEFAULT << 8);
> +            cxl_memdev_ps_feat_read_attrbs.scrub_flags =
> +                                CXL_MEMDEV_PS_ENABLE_DEFAULT;
> +            break;
>          default:
>              break;
>          }
> @@ -1112,6 +1169,21 @@ static CXLRetCode cmd_features_get_feature(const struct cxl_cmd *cmd,
>          return CXL_MBOX_INVALID_INPUT;
>      }
>  
> +    if (qemu_uuid_is_equal(&get_feature->uuid, &patrol_scrub_uuid)) {
> +        if (get_feature->offset >= sizeof(cxl_memdev_ps_feat_read_attrbs)) {
> +            return CXL_MBOX_INVALID_INPUT;
> +        }
> +        bytes_to_copy = sizeof(cxl_memdev_ps_feat_read_attrbs) -
> +                                             get_feature->offset;
> +        bytes_to_copy = (bytes_to_copy > get_feature->count) ?
> +                               get_feature->count : bytes_to_copy;
> +        memcpy(payload_out,
> +               &cxl_memdev_ps_feat_read_attrbs + get_feature->offset,
> +               bytes_to_copy);
> +    } else {
> +        return CXL_MBOX_UNSUPPORTED;
> +    }
> +
>      *len_out = bytes_to_copy;
>  
>      return CXL_MBOX_SUCCESS;
> @@ -1125,6 +1197,29 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
>                                             size_t *len_out,
>                                             CXLCCI *cci)
>  {
> +    CXLMemPatrolScrubWriteAttrbs *ps_write_attrbs;
> +    CXLMemPatrolScrubSetFeature *ps_set_feature;
> +    CXLSetFeatureInHeader *hdr = (void *)payload_in;
> +
> +    if (qemu_uuid_is_equal(&hdr->uuid, &patrol_scrub_uuid)) {
> +        if (hdr->version != CXL_MEMDEV_PS_SET_FEATURE_VERSION ||
> +            (hdr->flags & CXL_SET_FEATURE_FLAG_DATA_TRANSFER_MASK) !=
> +                               CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER) {
> +            return CXL_MBOX_UNSUPPORTED;
> +        }
> +
> +        ps_set_feature = (void *)payload_in;
> +        ps_write_attrbs = &ps_set_feature->feat_data;
> +        cxl_memdev_ps_feat_read_attrbs.scrub_cycle &= ~0xFF;
> +        cxl_memdev_ps_feat_read_attrbs.scrub_cycle |=
> +                          ps_write_attrbs->scrub_cycle_hr & 0xFF;
> +        cxl_memdev_ps_feat_read_attrbs.scrub_flags &= ~0x1;
> +        cxl_memdev_ps_feat_read_attrbs.scrub_flags |=
> +                          ps_write_attrbs->scrub_flags & 0x1;
> +    } else {
> +        return CXL_MBOX_UNSUPPORTED;
> +    }
> +
>      return CXL_MBOX_SUCCESS;
>  }
>  
> -- 
> 2.34.1
> 

