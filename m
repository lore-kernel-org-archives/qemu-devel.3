Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79090C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 18:23:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb2rK-0007fB-CX; Fri, 16 Feb 2024 13:22:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rb2rI-0007eu-VJ
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 13:22:48 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rb2rH-0007Xr-6n
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 13:22:48 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6e10e50179bso1761802b3a.1
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 10:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708107765; x=1708712565; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mA+oIB66oyv0PhDsgns6Ewek9FofOXKVahYSdpTmAD4=;
 b=nacuMwkZ5AiIPrWGbIgqmOxYDS5D6h5nFlCm12nhCKVxQe6KT4Aue+ihtJDOYZuF6x
 v+VJWprp5dG7opuQQ2pYnUOVhq/Kf3jsSxahBEcfevP92pXpnm/rt2dOL9/F1TDvl0xm
 YYDCLfgSDOod7kUz8FgcY3OTFSfxXL5hXN/6L8KG12AXxobdmtE6aypQ+3GtuigUiiPa
 pEnjklbhr3X6gZA8mc8dPBIdjuvYFWJK2d3OlPX/yzlaV/t9jW1LMOPda4x1Zx6timRl
 YUzXrv0nrxvaLOrXP7orV+kalfKkc/y+m2HtqrKXWn5Eld6iyIoXBKf+U0/VXDP/+TG2
 h8ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708107765; x=1708712565;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mA+oIB66oyv0PhDsgns6Ewek9FofOXKVahYSdpTmAD4=;
 b=hxq4l+Oi70e/d2dKI1HGIKNvYVLLr+VZNqr1IQse7VBndFJjcGIbe9gnIJXO0kHjwA
 qul/L+1ua9xP8tCwAt9TlHZI1inzr6mCu9CMzAeCYbiUldBzmc1wiiiyaXu8EOIeUAJR
 ij0+GYq0+KmIkXh9a4M7MaUdoAIqC1TQtAhQPtUUx67F8ipmrYlCEUqNW+UHwjV0EwhK
 HMd3oLwCkfBmxui33euGjqEppLQSuN4PKgotze37TCQtLgJ9Q8GLMV9M7KCDn5b0Gd7X
 Bgm9ab4YfpqW/P5HxSpKwwnfufKvJYMxvZMcJqkU7BDs5vtt7G37SvguKvbk5tPMi/js
 8BRA==
X-Gm-Message-State: AOJu0Yzc/2B1+576YlmuCNrb+eWgYDVxvyMji5j8diiWqWSXg7U6yYWR
 9YiTpU2EOOSxBaJ9ezzZp1QJiJl9L0/57asNkcOkDTIZoKaNY0br
X-Google-Smtp-Source: AGHT+IF7ItT+UiwAjNJo2gcUy85doJ0IrevLpgL3TAKMOoBw1svivBRBtexkTsAiJhBpIKEEV2kzZQ==
X-Received: by 2002:a05:6a20:9396:b0:19e:9f2d:9825 with SMTP id
 x22-20020a056a20939600b0019e9f2d9825mr7650393pzh.49.1708107765432; 
 Fri, 16 Feb 2024 10:22:45 -0800 (PST)
Received: from debian ([2601:641:300:14de:f1a:387c:5c5c:3099])
 by smtp.gmail.com with ESMTPSA id
 v17-20020aa799d1000000b006e09ec69d7dsm259455pfi.98.2024.02.16.10.22.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 10:22:45 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Fri, 16 Feb 2024 10:22:32 -0800
To: shiju.jose@huawei.com
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 jonathan.cameron@huawei.com, tanxiaofei@huawei.com,
 prime.zeng@hisilicon.com, linuxarm@huawei.com, fan.ni@samsung.com
Subject: Re: [PATCH v3 1/3] hw/cxl/cxl-mailbox-utils: Add support for feature
 commands (8.2.9.6)
Message-ID: <Zc-n6EBBPRaEFlDC@debian>
References: <20240215110146.1444-1-shiju.jose@huawei.com>
 <20240215110146.1444-2-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215110146.1444-2-shiju.jose@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pf1-x435.google.com
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

On Thu, Feb 15, 2024 at 07:01:44PM +0800, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> CXL spec 3.1 section 8.2.9.6 describes optional device specific features.
> CXL devices supports features with changeable attributes.
> Get Supported Features retrieves the list of supported device specific
> features. The settings of a feature can be retrieved using Get Feature and
> optionally modified using Set Feature.
> 
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> ---
>  hw/cxl/cxl-mailbox-utils.c | 175 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 175 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 80a80f1ec2..f761ac49b5 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -66,6 +66,10 @@ enum {
>      LOGS        = 0x04,
>          #define GET_SUPPORTED 0x0
>          #define GET_LOG       0x1
> +    FEATURES    = 0x05,
> +        #define GET_SUPPORTED 0x0
> +        #define GET_FEATURE   0x1
> +        #define SET_FEATURE   0x2
>      IDENTIFY    = 0x40,
>          #define MEMORY_DEVICE 0x0
>      CCLS        = 0x41,
> @@ -965,6 +969,165 @@ static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +/* CXL r3.1 section 8.2.9.6: Features */
> +/*
> + * Get Supported Features output payload
> + * CXL r3.1 section 8.2.9.6.1 Table 8-96
> + */
> +typedef struct CXLSupportedFeatureHeader {
> +    uint16_t entries;
> +    uint16_t nsuppfeats_dev;
> +    uint32_t reserved;
> +} QEMU_PACKED CXLSupportedFeatureHeader;
> +
> +/*
> + * Get Supported Features Supported Feature Entry
> + * CXL r3.1 section 8.2.9.6.1 Table 8-97
> + */
> +typedef struct CXLSupportedFeatureEntry {
> +    QemuUUID uuid;
> +    uint16_t feat_index;
> +    uint16_t get_feat_size;
> +    uint16_t set_feat_size;
> +    uint32_t attrb_flags;
> +    uint8_t get_feat_version;
> +    uint8_t set_feat_version;
> +    uint16_t set_feat_effects;
> +    uint8_t rsvd[18];
> +} QEMU_PACKED CXLSupportedFeatureEntry;
> +
> +enum CXL_SUPPORTED_FEATURES_LIST {
> +    CXL_FEATURE_MAX
> +};
> +
> +/* Get Feature CXL 3.1 Spec 8.2.9.6.2 */
> +/*
> + * Get Feature input payload
> + * CXL r3.1 section 8.2.9.6.2 Table 8-99
> + */
> +/* Get Feature : Payload in selection */
> +enum CXL_GET_FEATURE_SELECTION {
> +    CXL_GET_FEATURE_SEL_CURRENT_VALUE,
> +    CXL_GET_FEATURE_SEL_DEFAULT_VALUE,
> +    CXL_GET_FEATURE_SEL_SAVED_VALUE,
> +    CXL_GET_FEATURE_SEL_MAX
> +};
> +
> +/* Set Feature CXL 3.1 Spec 8.2.9.6.3 */
> +/*
> + * Set Feature input payload
> + * CXL r3.1 section 8.2.9.6.3 Table 8-101
> + */
> +typedef struct CXLSetFeatureInHeader {
> +        QemuUUID uuid;
> +        uint32_t flags;
> +        uint16_t offset;
> +        uint8_t version;
> +        uint8_t rsvd[9];
> +} QEMU_PACKED QEMU_ALIGNED(16) CXLSetFeatureInHeader;
> +
> +/* Set Feature : Payload in flags */
> +#define CXL_SET_FEATURE_FLAG_DATA_TRANSFER_MASK   0x7
> +enum CXL_SET_FEATURE_FLAG_DATA_TRANSFER {
> +    CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER,
> +    CXL_SET_FEATURE_FLAG_INITIATE_DATA_TRANSFER,
> +    CXL_SET_FEATURE_FLAG_CONTINUE_DATA_TRANSFER,
> +    CXL_SET_FEATURE_FLAG_FINISH_DATA_TRANSFER,
> +    CXL_SET_FEATURE_FLAG_ABORT_DATA_TRANSFER,
> +    CXL_SET_FEATURE_FLAG_DATA_TRANSFER_MAX
> +};
> +
> +/* CXL r3.1 section 8.2.9.6.1: Get Supported Features (Opcode 0500h) */
> +static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
> +                                             uint8_t *payload_in,
> +                                             size_t len_in,
> +                                             uint8_t *payload_out,
> +                                             size_t *len_out,
> +                                             CXLCCI *cci)
> +{
> +    struct {
> +        uint32_t count;
> +        uint16_t start_index;
> +        uint16_t reserved;
> +    } QEMU_PACKED QEMU_ALIGNED(16) * get_feats_in = (void *)payload_in;
> +
> +    struct {
> +        CXLSupportedFeatureHeader hdr;
> +        CXLSupportedFeatureEntry feat_entries[];
> +    } QEMU_PACKED QEMU_ALIGNED(16) * get_feats_out = (void *)payload_out;
> +    uint16_t index;
> +    uint16_t entry, req_entries;
> +    uint16_t feat_entries = 0;
> +
> +    if (get_feats_in->count < sizeof(CXLSupportedFeatureHeader) ||
> +        get_feats_in->start_index > CXL_FEATURE_MAX) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +    req_entries = (get_feats_in->count -
> +                   sizeof(CXLSupportedFeatureHeader)) /
> +                   sizeof(CXLSupportedFeatureEntry);
> +    req_entries = MIN(req_entries, CXL_FEATURE_MAX);
> +    index = get_feats_in->start_index;
> +
> +    entry = 0;
> +    while (entry < req_entries) {
> +        switch (index) {
> +        default:
> +            break;
> +        }
> +        index++;
> +        entry++;
> +    }
> +
> +    get_feats_out->hdr.nsuppfeats_dev = CXL_FEATURE_MAX;
> +    get_feats_out->hdr.entries = feat_entries;
> +    *len_out = sizeof(CXLSupportedFeatureHeader) +
> +                      feat_entries * sizeof(CXLSupportedFeatureEntry);
> +
> +    return CXL_MBOX_SUCCESS;
> +}
> +
> +/* CXL r3.1 section 8.2.9.6.2: Get Feature (Opcode 0501h) */
> +static CXLRetCode cmd_features_get_feature(const struct cxl_cmd *cmd,
> +                                           uint8_t *payload_in,
> +                                           size_t len_in,
> +                                           uint8_t *payload_out,
> +                                           size_t *len_out,
> +                                           CXLCCI *cci)
> +{
> +    struct {
> +        QemuUUID uuid;
> +        uint16_t offset;
> +        uint16_t count;
> +        uint8_t selection;
> +    } QEMU_PACKED QEMU_ALIGNED(16) * get_feature;
> +    uint16_t bytes_to_copy = 0;
> +
> +    get_feature = (void *)payload_in;
> +
> +    if (get_feature->selection != CXL_GET_FEATURE_SEL_CURRENT_VALUE) {
> +        return CXL_MBOX_UNSUPPORTED;
> +    }
> +    if (get_feature->offset + get_feature->count > cci->payload_max) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    *len_out = bytes_to_copy;
> +
> +    return CXL_MBOX_SUCCESS;
> +}
> +
> +/* CXL r3.1 section 8.2.9.6.3: Set Feature (Opcode 0502h) */
> +static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
> +                                           uint8_t *payload_in,
> +                                           size_t len_in,
> +                                           uint8_t *payload_out,
> +                                           size_t *len_out,
> +                                           CXLCCI *cci)
> +{
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  /* CXL r3.1 Section 8.2.9.9.1.1: Identify Memory Device (Opcode 4000h) */
>  static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
>                                               uint8_t *payload_in,
> @@ -2166,6 +2329,18 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
>      [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported,
>                                0, 0 },
>      [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
> +    [FEATURES][GET_SUPPORTED] = { "FEATURES_GET_SUPPORTED",
> +                                  cmd_features_get_supported, 0x8, 0 },
> +    [FEATURES][GET_FEATURE] = { "FEATURES_GET_FEATURE",
> +                                cmd_features_get_feature, 0x15, 0 },
> +    [FEATURES][SET_FEATURE] = { "FEATURES_SET_FEATURE",
> +                                cmd_features_set_feature,
> +                                ~0,
> +                                (CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
> +                                 CXL_MBOX_IMMEDIATE_DATA_CHANGE |
> +                                 CXL_MBOX_IMMEDIATE_POLICY_CHANGE |
> +                                 CXL_MBOX_IMMEDIATE_LOG_CHANGE |
> +                                 CXL_MBOX_SECURITY_STATE_CHANGE)},
>      [IDENTIFY][MEMORY_DEVICE] = { "IDENTIFY_MEMORY_DEVICE",
>          cmd_identify_memory_device, 0, 0 },
>      [CCLS][GET_PARTITION_INFO] = { "CCLS_GET_PARTITION_INFO",
> -- 
> 2.34.1
> 

