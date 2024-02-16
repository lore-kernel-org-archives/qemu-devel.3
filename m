Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBFEAC48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 12:12:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rax4S-0006g1-Fj; Fri, 16 Feb 2024 07:12:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shiju.jose@huawei.com>)
 id 1rax4Q-0006fV-8d
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 07:11:58 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shiju.jose@huawei.com>)
 id 1rax4M-0006M3-OQ
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 07:11:58 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbrL54JZ3z6K7Ft;
 Fri, 16 Feb 2024 20:08:13 +0800 (CST)
Received: from lhrpeml100001.china.huawei.com (unknown [7.191.160.183])
 by mail.maildlp.com (Postfix) with ESMTPS id A850E140519;
 Fri, 16 Feb 2024 20:11:42 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 lhrpeml100001.china.huawei.com (7.191.160.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 16 Feb 2024 12:11:42 +0000
Received: from lhrpeml500006.china.huawei.com ([7.191.161.198]) by
 lhrpeml500006.china.huawei.com ([7.191.161.198]) with mapi id 15.01.2507.035; 
 Fri, 16 Feb 2024 12:11:42 +0000
To: Davidlohr Bueso <dave@stgolabs.net>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Jonathan Cameron
 <jonathan.cameron@huawei.com>, tanxiaofei <tanxiaofei@huawei.com>, "Zengtao
 (B)" <prime.zeng@hisilicon.com>, Linuxarm <linuxarm@huawei.com>,
 "fan.ni@samsung.com" <fan.ni@samsung.com>
Subject: RE: [PATCH v2 2/3] hw/cxl/cxl-mailbox-utils: Add device patrol scrub
 control feature
Thread-Topic: [PATCH v2 2/3] hw/cxl/cxl-mailbox-utils: Add device patrol scrub
 control feature
Thread-Index: AQHaHt2kLuqmPTjFUU+KA5oR6u/MrLEMZOaAgADy+gA=
Date: Fri, 16 Feb 2024 12:11:42 +0000
Message-ID: <9b92b57df8ce434a9acdb17dbf078577@huawei.com>
References: <20231124135338.1191-1-shiju.jose@huawei.com>
 <20231124135338.1191-3-shiju.jose@huawei.com>
 <id5xykna7khba7erp24q6mm2jog4rm6dadlf3hovtckiujvm5w@n76nnywnjf75>
In-Reply-To: <id5xykna7khba7erp24q6mm2jog4rm6dadlf3hovtckiujvm5w@n76nnywnjf75>
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

Hi Davidlohr,

Thanks for the feedback.
Please find reply inline.

>-----Original Message-----
>From: Davidlohr Bueso <dave@stgolabs.net>
>Sent: 15 February 2024 20:56
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: qemu-devel@nongnu.org; linux-cxl@vger.kernel.org; Jonathan Cameron
><jonathan.cameron@huawei.com>; tanxiaofei <tanxiaofei@huawei.com>;
>Zengtao (B) <prime.zeng@hisilicon.com>; Linuxarm <linuxarm@huawei.com>;
>fan.ni@samsung.com
>Subject: Re: [PATCH v2 2/3] hw/cxl/cxl-mailbox-utils: Add device patrol sc=
rub
>control feature
>
>On Fri, 24 Nov 2023, shiju.jose@huawei.com wrote:
>
>>From: Shiju Jose <shiju.jose@huawei.com>
>>
>>CXL spec 3.1 section 8.2.9.9.11.1 describes the device patrol scrub
>>control feature. The device patrol scrub proactively locates and makes
>>corrections to errors in regular cycle. The patrol scrub control allows
>>the request to configure patrol scrub input configurations.
>>
>>The patrol scrub control allows the requester to specify the number of
>>hours for which the patrol scrub cycles must be completed, provided
>>that the requested number is not less than the minimum number of hours
>>for the patrol scrub cycle that the device is capable of. In addition,
>>the patrol scrub controls allow the host to disable and enable the
>>feature in case disabling of the feature is needed for other purposes
>>such as performance-aware operations which require the background
>>operations to be turned off.
>>
>>Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
>>Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>>---
>> hw/cxl/cxl-mailbox-utils.c | 97 +++++++++++++++++++++++++++++++++++++-
>> 1 file changed, 96 insertions(+), 1 deletion(-)
>>
>>diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
>>index 1bbc9a48a6..5a6f4e4029 100644
>>--- a/hw/cxl/cxl-mailbox-utils.c
>>+++ b/hw/cxl/cxl-mailbox-utils.c
>>@@ -809,6 +809,7 @@ typedef struct CXLSupportedFeatureEntry {  }
>>QEMU_PACKED CXLSupportedFeatureEntry;
>>
>> enum CXL_SUPPORTED_FEATURES_LIST {
>>+    CXL_FEATURE_PATROL_SCRUB =3D 0,
>>     CXL_FEATURE_MAX
>> };
>>
>>@@ -849,6 +850,37 @@ enum CXL_SET_FEATURE_FLAG_DATA_TRANSFER {
>>     CXL_SET_FEATURE_FLAG_DATA_TRANSFER_MAX
>> };
>>
>>+/* CXL r3.1 section 8.2.9.9.11.1: Device Patrol Scrub Control Feature
>>+*/ static const QemuUUID patrol_scrub_uuid =3D {
>>+    .data =3D UUID(0x96dad7d6, 0xfde8, 0x482b, 0xa7, 0x33,
>>+                 0x75, 0x77, 0x4e, 0x06, 0xdb, 0x8a) };
>>+
>>+#define CXL_MEMDEV_PS_GET_FEATURE_VERSION    0x01
>>+#define CXL_MEMDEV_PS_SET_FEATURE_VERSION    0x01
>>+#define CXL_MEMDEV_PS_SCRUB_CYCLE_CHANGE_CAP_DEFAULT    BIT(0)
>>+#define CXL_MEMDEV_PS_SCRUB_REALTIME_REPORT_CAP_DEFAULT
>BIT(1)
>>+#define CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_DEFAULT    12
>>+#define CXL_MEMDEV_PS_MIN_SCRUB_CYCLE_DEFAULT    1
>>+#define CXL_MEMDEV_PS_ENABLE_DEFAULT    0
>>+
>>+/* CXL memdev patrol scrub control attributes */ struct
>>+CXLMemPatrolScrubReadAttrbs {
>>+        uint8_t scrub_cycle_cap;
>>+        uint16_t scrub_cycle;
>>+        uint8_t scrub_flags;
>>+} QEMU_PACKED cxl_memdev_ps_feat_read_attrbs;
>>+
>>+typedef struct CXLMemPatrolScrubWriteAttrbs {
>>+    uint8_t scrub_cycle_hr;
>>+    uint8_t scrub_flags;
>>+} QEMU_PACKED CXLMemPatrolScrubWriteAttrbs;
>
>fyi there is an ask, which I certainly agree with, to make these static he=
re
>instead of at runtime.
I will make cxl_memdev_ps_feat_read_attrbs static, however can't make const=
 because=20
cxl_memdev_ps_feat_read_attrbs use to store the attributes  in the set_feat=
ure.
May be rename cxl_memdev_ps_feat_read_attrbs to cxl_memdev_ps_feat_ attrbs =
to avoid confusion?
 =20
>
>https://lore.kernel.org/linux-cxl/20240119175006.00007f74@Huawei.com/
>
>Also, this series probably needs rebasing per Jonathan's latest branch wit=
h lots of
>updates.

The v3 posted recently was rebased to=20
Jonathan's recent branch
https://gitlab.com/jic23/qemu/-/tree/cxl-2024-02-05-draft

Looks like latest branch is cxl-2024-02-14. I will rebase.
=20
https://lore.kernel.org/qemu-devel/20240215110146.1444-1-shiju.jose@huawei.=
com/T/#t
=20
>
>>+
>>+typedef struct CXLMemPatrolScrubSetFeature {
>>+        CXLSetFeatureInHeader hdr;
>>+        CXLMemPatrolScrubWriteAttrbs feat_data; } QEMU_PACKED
>>+QEMU_ALIGNED(16) CXLMemPatrolScrubSetFeature;
>>+
>> /* CXL r3.0 section 8.2.9.6.1: Get Supported Features (Opcode 0500h)
>>*/  static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cm=
d,
>>                                              uint8_t *payload_in, @@
>>-872,7 +904,7 @@ static CXLRetCode cmd_features_get_supported(const
>struct cxl_cmd *cmd,
>>     uint16_t feat_entries =3D 0;
>>
>>     if (get_feats_in->count < sizeof(CXLSupportedFeatureHeader) ||
>>-        get_feats_in->start_index > CXL_FEATURE_MAX) {
>>+        get_feats_in->start_index >=3D CXL_FEATURE_MAX) {
>>         return CXL_MBOX_INVALID_INPUT;
>>     }
>>     req_entries =3D (get_feats_in->count - @@ -884,6 +916,31 @@ static
>>CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
>>     entry =3D 0;
>>     while (entry < req_entries) {
>>         switch (index) {
>>+        case  CXL_FEATURE_PATROL_SCRUB:
>>+            /* Fill supported feature entry for device patrol scrub cont=
rol */
>>+            get_feats_out->feat_entries[entry] =3D
>>+                           (struct CXLSupportedFeatureEntry) {
>>+                .uuid =3D patrol_scrub_uuid,
>>+                .feat_index =3D index,
>>+                .get_feat_size =3D sizeof(cxl_memdev_ps_feat_read_attrbs=
),
>>+                .set_feat_size =3D sizeof(CXLMemPatrolScrubWriteAttrbs),
>>+                /* Bit[0] : 1, feature attributes changeable */
>>+                .attrb_flags =3D 0x1,
>>+                .get_feat_version =3D CXL_MEMDEV_PS_GET_FEATURE_VERSION,
>>+                .set_feat_version =3D CXL_MEMDEV_PS_SET_FEATURE_VERSION,
>>+                .set_feat_effects =3D 0,
>>+            };
>>+            feat_entries++;
>>+            /* Set default value for device patrol scrub read attributes=
 */
>>+            cxl_memdev_ps_feat_read_attrbs.scrub_cycle_cap =3D
>>+
>CXL_MEMDEV_PS_SCRUB_CYCLE_CHANGE_CAP_DEFAULT |
>>+
>CXL_MEMDEV_PS_SCRUB_REALTIME_REPORT_CAP_DEFAULT;
>>+            cxl_memdev_ps_feat_read_attrbs.scrub_cycle =3D
>>+                                CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_DEFAULT |
>>+                                (CXL_MEMDEV_PS_MIN_SCRUB_CYCLE_DEFAULT <=
< 8);
>>+            cxl_memdev_ps_feat_read_attrbs.scrub_flags =3D
>>+                                CXL_MEMDEV_PS_ENABLE_DEFAULT;
>>+            break;
>>         default:
>>             break;
>>         }
>>@@ -924,6 +981,21 @@ static CXLRetCode cmd_features_get_feature(const
>struct cxl_cmd *cmd,
>>         return CXL_MBOX_INVALID_INPUT;
>>     }
>>
>>+    if (qemu_uuid_is_equal(&get_feature->uuid, &patrol_scrub_uuid)) {
>>+        if (get_feature->offset >=3D sizeof(cxl_memdev_ps_feat_read_attr=
bs)) {
>>+            return CXL_MBOX_INVALID_INPUT;
>>+        }
>>+        bytes_to_copy =3D sizeof(cxl_memdev_ps_feat_read_attrbs) -
>>+                                             get_feature->offset;
>>+        bytes_to_copy =3D (bytes_to_copy > get_feature->count) ?
>>+                               get_feature->count : bytes_to_copy;
>
>min()?
>
>>+        memcpy(payload_out,
>>+               &cxl_memdev_ps_feat_read_attrbs + get_feature->offset,
>>+               bytes_to_copy);
>>+    } else {
>>+        return CXL_MBOX_UNSUPPORTED;
>>+    }
>>+
>>     *len_out =3D bytes_to_copy;
>>
>>     return CXL_MBOX_SUCCESS;
>>@@ -937,6 +1009,29 @@ static CXLRetCode cmd_features_set_feature(const
>struct cxl_cmd *cmd,
>>                                            size_t *len_out,
>>                                            CXLCCI *cci)  {
>>+    CXLMemPatrolScrubWriteAttrbs *ps_write_attrbs;
>>+    CXLMemPatrolScrubSetFeature *ps_set_feature;
>>+    CXLSetFeatureInHeader *hdr =3D (void *)payload_in;
>>+
>>+    if (qemu_uuid_is_equal(&hdr->uuid, &patrol_scrub_uuid)) {
>>+        if (hdr->version !=3D CXL_MEMDEV_PS_SET_FEATURE_VERSION ||
>>+            (hdr->flags & CXL_SET_FEATURE_FLAG_DATA_TRANSFER_MASK) !=3D
>>+                               CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER) =
{
>>+            return CXL_MBOX_UNSUPPORTED;
>>+        }
>>+
>>+        ps_set_feature =3D (void *)payload_in;
>>+        ps_write_attrbs =3D &ps_set_feature->feat_data;
>>+        cxl_memdev_ps_feat_read_attrbs.scrub_cycle &=3D ~0xFF;
>>+        cxl_memdev_ps_feat_read_attrbs.scrub_cycle |=3D
>>+                          ps_write_attrbs->scrub_cycle_hr & 0xFF;
>>+        cxl_memdev_ps_feat_read_attrbs.scrub_flags &=3D ~0x1;
>>+        cxl_memdev_ps_feat_read_attrbs.scrub_flags |=3D
>>+                          ps_write_attrbs->scrub_flags & 0x1;
>>+    } else {
>>+        return CXL_MBOX_UNSUPPORTED;
>>+    }
>>+
>>     return CXL_MBOX_SUCCESS;
>> }
>>
>>--
>>2.34.1
>>

Thanks,
Shiju

