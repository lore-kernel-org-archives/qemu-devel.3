Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B179C48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 18:07:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rag7N-0003uj-6D; Thu, 15 Feb 2024 13:05:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rag7L-0003hd-Dr
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:05:51 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rag7J-0003l5-F0
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:05:51 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-517ab9a4a13so996633a12.1
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 10:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708020347; x=1708625147; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eIgUnvQyGxrS7Bai+vA7mlTK92iHDoU7YFwg30PgKhI=;
 b=QE3KwbsZJGSAuhqUOGV9675cQr9hi8q8q4xyQsyazcKoStav04uFUFHgsUNVmW32sl
 k6JsfocDBLIMvuVigbghu6C3HwLbIZVrY0ItXy/KspYWhVRbNP5kcacgoTG9IP1FY894
 Opu6dD7mklUhUuMD7+m0mtPR9K2yZm1sSFwojT/lUNppAR60trHPVNgE1P5nDEm0aibs
 5fbp1KrOJu5RNsutkP2/XMfE9+Pm8rxqTrSxfEDDs2KwuRJwZDFv529XxsBT45WpGGRG
 u5CmOUX6w/zmqO8PgXsJFhppQo1E2rQJn87GdMep8JRSvWhsrHjCKpEupbQHj9ooXPZP
 r+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708020347; x=1708625147;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eIgUnvQyGxrS7Bai+vA7mlTK92iHDoU7YFwg30PgKhI=;
 b=Uvj4cYT6i2UJEH+prvwvofPPrn3bWHzrP9Pzp+7X/zwOrNsrxSHjHE6Bb2OjEKahGx
 F8bFewiJWSGegXUlLsScPwfknqraVuxQoJTm/HCg8khh2Y/D73pwL1OhOV50jmzXOqW+
 OWBk2vUlQ84pIXBNcsCKfQxAL8ITd12rtnFevRdjpU7H/9vent5+crzamVybmtaApQ1F
 ONDw3XW8hL5ffKq0dLaoNDNVHzs/I4+1NIph6cNcI8uoAO1pbprj99GkOkrgVSB28EUf
 0/tgNhUrebDPBNbUXlMDyVPsD8wKaJlFkNN8FPqur6DaRpAI/8THiTpf2GYOI6Q3IwlA
 qLxw==
X-Gm-Message-State: AOJu0YzDH0iwH588RZemmTNYlhZfjuFDTMFUrHCH8v7WWMsHLhZpBKmG
 miv7fqPzuL1oyzH4LwmLPUknxnyN1bvyorKwOvkEgzRb1gnU7aCd
X-Google-Smtp-Source: AGHT+IECJE3MLz7w7Lyqv6ZiFWFbf+iqHiChmFFdGq8n9fm5kb5aS+J3p74oZjP4nk9Kk8cbj2lDKQ==
X-Received: by 2002:a17:90a:b011:b0:298:c236:10c5 with SMTP id
 x17-20020a17090ab01100b00298c23610c5mr2448098pjq.10.1708020347414; 
 Thu, 15 Feb 2024 10:05:47 -0800 (PST)
Received: from debian ([2601:641:300:14de:5279:cdf6:aaf1:e09c])
 by smtp.gmail.com with ESMTPSA id
 b3-20020a17090a800300b00298985d0147sm1747230pjn.7.2024.02.15.10.05.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 10:05:47 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Thu, 15 Feb 2024 10:05:32 -0800
To: shiju.jose@huawei.com
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 jonathan.cameron@huawei.com, tanxiaofei@huawei.com,
 prime.zeng@hisilicon.com, linuxarm@huawei.com
Subject: Re: [PATCH v2 1/3] hw/cxl/cxl-mailbox-utils: Add support for feature
 commands (8.2.9.6)
Message-ID: <Zc5SbEn1J-Bk0tYg@debian>
References: <20231124135338.1191-1-shiju.jose@huawei.com>
 <20231124135338.1191-2-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124135338.1191-2-shiju.jose@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pg1-x536.google.com
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

On Fri, Nov 24, 2023 at 09:53:35PM +0800, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> CXL spec 3.0 section 8.2.9.6 describes optional device specific features.
> CXL devices supports features with changeable attributes.
> Get Supported Features retrieves the list of supported device specific
> features. The settings of a feature can be retrieved using Get Feature and
> optionally modified using Set Feature.
> 
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---

Updated the references to align with cxl spec r3.1, other than that looks
good to me.

Fan

>  hw/cxl/cxl-mailbox-utils.c | 167 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 167 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 6184f44339..1bbc9a48a6 100644
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
> @@ -785,6 +789,157 @@ static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +/* CXL r3.0 section 8.2.9.6: Features */
> +typedef struct CXLSupportedFeatureHeader {
> +    uint16_t entries;
> +    uint16_t nsuppfeats_dev;
> +    uint32_t reserved;
> +} QEMU_PACKED CXLSupportedFeatureHeader;
> +
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
> +/* Get Feature CXL 3.0 Spec 8.2.9.6.2 */
> +/*
> + * Get Feature input payload
> + * CXL rev 3.0 section 8.2.9.6.2; Table 8-79
> + */
> +/* Get Feature : Payload in selection */
> +enum CXL_GET_FEATURE_SELECTION {
> +    CXL_GET_FEATURE_SEL_CURRENT_VALUE = 0x0,
> +    CXL_GET_FEATURE_SEL_DEFAULT_VALUE = 0x1,
> +    CXL_GET_FEATURE_SEL_SAVED_VALUE = 0x2,
> +    CXL_GET_FEATURE_SEL_MAX
> +};
> +
> +/* Set Feature CXL 3.0 Spec 8.2.9.6.3 */
> +/*
> + * Set Feature input payload
> + * CXL rev 3.0 section 8.2.9.6.3; Table 8-81
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
> +    CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER = 0x0,
> +    CXL_SET_FEATURE_FLAG_INITIATE_DATA_TRANSFER = 0x1,
> +    CXL_SET_FEATURE_FLAG_CONTINUE_DATA_TRANSFER = 0x2,
> +    CXL_SET_FEATURE_FLAG_FINISH_DATA_TRANSFER = 0x3,
> +    CXL_SET_FEATURE_FLAG_ABORT_DATA_TRANSFER = 0x4,
> +    CXL_SET_FEATURE_FLAG_DATA_TRANSFER_MAX
> +};
> +
> +/* CXL r3.0 section 8.2.9.6.1: Get Supported Features (Opcode 0500h) */
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
> +/* CXL r3.0 section 8.2.9.6.2: Get Feature (Opcode 0501h) */
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
> +/* CXL r3.0 section 8.2.9.6.3: Set Feature (Opcode 0502h) */
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
>  /* 8.2.9.5.1.1 */
>  static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
>                                               uint8_t *payload_in,
> @@ -1954,6 +2109,18 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
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

