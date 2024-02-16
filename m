Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C9AC48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 09:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rauP1-00019w-OP; Fri, 16 Feb 2024 04:21:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shiju.jose@huawei.com>)
 id 1rauOz-00019V-EO
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 04:21:01 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shiju.jose@huawei.com>)
 id 1rauOw-0006gy-1m
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 04:21:00 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbmXy48Dtz6K7G7;
 Fri, 16 Feb 2024 17:17:22 +0800 (CST)
Received: from lhrpeml500002.china.huawei.com (unknown [7.191.160.78])
 by mail.maildlp.com (Postfix) with ESMTPS id 70CA4140B63;
 Fri, 16 Feb 2024 17:20:51 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 lhrpeml500002.china.huawei.com (7.191.160.78) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 16 Feb 2024 09:20:51 +0000
Received: from lhrpeml500006.china.huawei.com ([7.191.161.198]) by
 lhrpeml500006.china.huawei.com ([7.191.161.198]) with mapi id 15.01.2507.035; 
 Fri, 16 Feb 2024 09:20:51 +0000
To: fan <nifan.cxl@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Jonathan Cameron
 <jonathan.cameron@huawei.com>, tanxiaofei <tanxiaofei@huawei.com>, "Zengtao
 (B)" <prime.zeng@hisilicon.com>, Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH v2 1/3] hw/cxl/cxl-mailbox-utils: Add support for feature
 commands (8.2.9.6)
Thread-Topic: [PATCH v2 1/3] hw/cxl/cxl-mailbox-utils: Add support for feature
 commands (8.2.9.6)
Thread-Index: AQHaHt2k9HtibX8fzEeC6ibsAHGqnrEMNWYAgAD/BkA=
Date: Fri, 16 Feb 2024 09:20:50 +0000
Message-ID: <e773c12ca6ca40a1aa582d3a8a4043d9@huawei.com>
References: <20231124135338.1191-1-shiju.jose@huawei.com>
 <20231124135338.1191-2-shiju.jose@huawei.com> <Zc5SbEn1J-Bk0tYg@debian>
In-Reply-To: <Zc5SbEn1J-Bk0tYg@debian>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.195.246.99]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=185.176.79.56; envelope-from=shiju.jose@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Shiju Jose <shiju.jose@huawei.com>
From:  Shiju Jose via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Fan,

Thanks for the feedbacks.

>-----Original Message-----
>From: fan <nifan.cxl@gmail.com>
>Sent: 15 February 2024 18:06
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: qemu-devel@nongnu.org; linux-cxl@vger.kernel.org; Jonathan Cameron
><jonathan.cameron@huawei.com>; tanxiaofei <tanxiaofei@huawei.com>;
>Zengtao (B) <prime.zeng@hisilicon.com>; Linuxarm <linuxarm@huawei.com>
>Subject: Re: [PATCH v2 1/3] hw/cxl/cxl-mailbox-utils: Add support for feat=
ure
>commands (8.2.9.6)
>
>On Fri, Nov 24, 2023 at 09:53:35PM +0800, shiju.jose@huawei.com wrote:
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> CXL spec 3.0 section 8.2.9.6 describes optional device specific features=
.
>> CXL devices supports features with changeable attributes.
>> Get Supported Features retrieves the list of supported device specific
>> features. The settings of a feature can be retrieved using Get Feature
>> and optionally modified using Set Feature.
>>
>> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>> ---
>
>Updated the references to align with cxl spec r3.1, other than that looks =
good to
>me.

I had posted v3 of this series updated for spec r3.1. Please find here,
https://lore.kernel.org/qemu-devel/20240215110146.1444-1-shiju.jose@huawei.=
com/T/#t

>
>Fan
>
>>  hw/cxl/cxl-mailbox-utils.c | 167
>> +++++++++++++++++++++++++++++++++++++
>>  1 file changed, 167 insertions(+)
>>
>> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
>> index 6184f44339..1bbc9a48a6 100644
>> --- a/hw/cxl/cxl-mailbox-utils.c
>> +++ b/hw/cxl/cxl-mailbox-utils.c
>> @@ -66,6 +66,10 @@ enum {
>>      LOGS        =3D 0x04,
>>          #define GET_SUPPORTED 0x0
>>          #define GET_LOG       0x1
>> +    FEATURES    =3D 0x05,
>> +        #define GET_SUPPORTED 0x0
>> +        #define GET_FEATURE   0x1
>> +        #define SET_FEATURE   0x2
>>      IDENTIFY    =3D 0x40,
>>          #define MEMORY_DEVICE 0x0
>>      CCLS        =3D 0x41,
>> @@ -785,6 +789,157 @@ static CXLRetCode cmd_logs_get_log(const struct
>cxl_cmd *cmd,
>>      return CXL_MBOX_SUCCESS;
>>  }
>>
>> +/* CXL r3.0 section 8.2.9.6: Features */ typedef struct
>> +CXLSupportedFeatureHeader {
>> +    uint16_t entries;
>> +    uint16_t nsuppfeats_dev;
>> +    uint32_t reserved;
>> +} QEMU_PACKED CXLSupportedFeatureHeader;
>> +
>> +typedef struct CXLSupportedFeatureEntry {
>> +    QemuUUID uuid;
>> +    uint16_t feat_index;
>> +    uint16_t get_feat_size;
>> +    uint16_t set_feat_size;
>> +    uint32_t attrb_flags;
>> +    uint8_t get_feat_version;
>> +    uint8_t set_feat_version;
>> +    uint16_t set_feat_effects;
>> +    uint8_t rsvd[18];
>> +} QEMU_PACKED CXLSupportedFeatureEntry;
>> +
>> +enum CXL_SUPPORTED_FEATURES_LIST {
>> +    CXL_FEATURE_MAX
>> +};
>> +
>> +/* Get Feature CXL 3.0 Spec 8.2.9.6.2 */
>> +/*
>> + * Get Feature input payload
>> + * CXL rev 3.0 section 8.2.9.6.2; Table 8-79  */
>> +/* Get Feature : Payload in selection */ enum
>> +CXL_GET_FEATURE_SELECTION {
>> +    CXL_GET_FEATURE_SEL_CURRENT_VALUE =3D 0x0,
>> +    CXL_GET_FEATURE_SEL_DEFAULT_VALUE =3D 0x1,
>> +    CXL_GET_FEATURE_SEL_SAVED_VALUE =3D 0x2,
>> +    CXL_GET_FEATURE_SEL_MAX
>> +};
>> +
>> +/* Set Feature CXL 3.0 Spec 8.2.9.6.3 */
>> +/*
>> + * Set Feature input payload
>> + * CXL rev 3.0 section 8.2.9.6.3; Table 8-81  */ typedef struct
>> +CXLSetFeatureInHeader {
>> +        QemuUUID uuid;
>> +        uint32_t flags;
>> +        uint16_t offset;
>> +        uint8_t version;
>> +        uint8_t rsvd[9];
>> +} QEMU_PACKED QEMU_ALIGNED(16) CXLSetFeatureInHeader;
>> +
>> +/* Set Feature : Payload in flags */
>> +#define CXL_SET_FEATURE_FLAG_DATA_TRANSFER_MASK   0x7
>> +enum CXL_SET_FEATURE_FLAG_DATA_TRANSFER {
>> +    CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER =3D 0x0,
>> +    CXL_SET_FEATURE_FLAG_INITIATE_DATA_TRANSFER =3D 0x1,
>> +    CXL_SET_FEATURE_FLAG_CONTINUE_DATA_TRANSFER =3D 0x2,
>> +    CXL_SET_FEATURE_FLAG_FINISH_DATA_TRANSFER =3D 0x3,
>> +    CXL_SET_FEATURE_FLAG_ABORT_DATA_TRANSFER =3D 0x4,
>> +    CXL_SET_FEATURE_FLAG_DATA_TRANSFER_MAX
>> +};
>> +
>> +/* CXL r3.0 section 8.2.9.6.1: Get Supported Features (Opcode 0500h)
>> +*/ static CXLRetCode cmd_features_get_supported(const struct cxl_cmd
>*cmd,
>> +                                             uint8_t *payload_in,
>> +                                             size_t len_in,
>> +                                             uint8_t *payload_out,
>> +                                             size_t *len_out,
>> +                                             CXLCCI *cci) {
>> +    struct {
>> +        uint32_t count;
>> +        uint16_t start_index;
>> +        uint16_t reserved;
>> +    } QEMU_PACKED QEMU_ALIGNED(16) * get_feats_in =3D (void
>> +*)payload_in;
>> +
>> +    struct {
>> +        CXLSupportedFeatureHeader hdr;
>> +        CXLSupportedFeatureEntry feat_entries[];
>> +    } QEMU_PACKED QEMU_ALIGNED(16) * get_feats_out =3D (void
>*)payload_out;
>> +    uint16_t index;
>> +    uint16_t entry, req_entries;
>> +    uint16_t feat_entries =3D 0;
>> +
>> +    if (get_feats_in->count < sizeof(CXLSupportedFeatureHeader) ||
>> +        get_feats_in->start_index > CXL_FEATURE_MAX) {
>> +        return CXL_MBOX_INVALID_INPUT;
>> +    }
>> +    req_entries =3D (get_feats_in->count -
>> +                   sizeof(CXLSupportedFeatureHeader)) /
>> +                   sizeof(CXLSupportedFeatureEntry);
>> +    req_entries =3D MIN(req_entries, CXL_FEATURE_MAX);
>> +    index =3D get_feats_in->start_index;
>> +
>> +    entry =3D 0;
>> +    while (entry < req_entries) {
>> +        switch (index) {
>> +        default:
>> +            break;
>> +        }
>> +        index++;
>> +        entry++;
>> +    }
>> +
>> +    get_feats_out->hdr.nsuppfeats_dev =3D CXL_FEATURE_MAX;
>> +    get_feats_out->hdr.entries =3D feat_entries;
>> +    *len_out =3D sizeof(CXLSupportedFeatureHeader) +
>> +                      feat_entries *
>> + sizeof(CXLSupportedFeatureEntry);
>> +
>> +    return CXL_MBOX_SUCCESS;
>> +}
>> +
>> +/* CXL r3.0 section 8.2.9.6.2: Get Feature (Opcode 0501h) */ static
>> +CXLRetCode cmd_features_get_feature(const struct cxl_cmd *cmd,
>> +                                           uint8_t *payload_in,
>> +                                           size_t len_in,
>> +                                           uint8_t *payload_out,
>> +                                           size_t *len_out,
>> +                                           CXLCCI *cci) {
>> +    struct {
>> +        QemuUUID uuid;
>> +        uint16_t offset;
>> +        uint16_t count;
>> +        uint8_t selection;
>> +    } QEMU_PACKED QEMU_ALIGNED(16) * get_feature;
>> +    uint16_t bytes_to_copy =3D 0;
>> +
>> +    get_feature =3D (void *)payload_in;
>> +
>> +    if (get_feature->selection !=3D CXL_GET_FEATURE_SEL_CURRENT_VALUE) =
{
>> +        return CXL_MBOX_UNSUPPORTED;
>> +    }
>> +    if (get_feature->offset + get_feature->count > cci->payload_max) {
>> +        return CXL_MBOX_INVALID_INPUT;
>> +    }
>> +
>> +    *len_out =3D bytes_to_copy;
>> +
>> +    return CXL_MBOX_SUCCESS;
>> +}
>> +
>> +/* CXL r3.0 section 8.2.9.6.3: Set Feature (Opcode 0502h) */ static
>> +CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
>> +                                           uint8_t *payload_in,
>> +                                           size_t len_in,
>> +                                           uint8_t *payload_out,
>> +                                           size_t *len_out,
>> +                                           CXLCCI *cci) {
>> +    return CXL_MBOX_SUCCESS;
>> +}
>> +
>>  /* 8.2.9.5.1.1 */
>>  static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
>>                                               uint8_t *payload_in, @@
>> -1954,6 +2109,18 @@ static const struct cxl_cmd cxl_cmd_set[256][256] =
=3D {
>>      [LOGS][GET_SUPPORTED] =3D { "LOGS_GET_SUPPORTED",
>cmd_logs_get_supported,
>>                                0, 0 },
>>      [LOGS][GET_LOG] =3D { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
>> +    [FEATURES][GET_SUPPORTED] =3D { "FEATURES_GET_SUPPORTED",
>> +                                  cmd_features_get_supported, 0x8, 0 },
>> +    [FEATURES][GET_FEATURE] =3D { "FEATURES_GET_FEATURE",
>> +                                cmd_features_get_feature, 0x15, 0 },
>> +    [FEATURES][SET_FEATURE] =3D { "FEATURES_SET_FEATURE",
>> +                                cmd_features_set_feature,
>> +                                ~0,
>> +                                (CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
>> +                                 CXL_MBOX_IMMEDIATE_DATA_CHANGE |
>> +                                 CXL_MBOX_IMMEDIATE_POLICY_CHANGE |
>> +                                 CXL_MBOX_IMMEDIATE_LOG_CHANGE |
>> +                                 CXL_MBOX_SECURITY_STATE_CHANGE)},
>>      [IDENTIFY][MEMORY_DEVICE] =3D { "IDENTIFY_MEMORY_DEVICE",
>>          cmd_identify_memory_device, 0, 0 },
>>      [CCLS][GET_PARTITION_INFO] =3D { "CCLS_GET_PARTITION_INFO",
>> --
>> 2.34.1
>>

Thanks,
Shiju

