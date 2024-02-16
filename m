Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3B55C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 09:22:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rauQ5-0001oc-Or; Fri, 16 Feb 2024 04:22:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shiju.jose@huawei.com>)
 id 1rauQ3-0001o8-U6
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 04:22:07 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shiju.jose@huawei.com>)
 id 1rauQ2-0006tx-4B
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 04:22:07 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbmZM0Cw3z6D8Wh;
 Fri, 16 Feb 2024 17:18:35 +0800 (CST)
Received: from lhrpeml500002.china.huawei.com (unknown [7.191.160.78])
 by mail.maildlp.com (Postfix) with ESMTPS id D130E140519;
 Fri, 16 Feb 2024 17:22:03 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 lhrpeml500002.china.huawei.com (7.191.160.78) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 16 Feb 2024 09:22:03 +0000
Received: from lhrpeml500006.china.huawei.com ([7.191.161.198]) by
 lhrpeml500006.china.huawei.com ([7.191.161.198]) with mapi id 15.01.2507.035; 
 Fri, 16 Feb 2024 09:22:03 +0000
To: fan <nifan.cxl@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Jonathan Cameron
 <jonathan.cameron@huawei.com>, tanxiaofei <tanxiaofei@huawei.com>, "Zengtao
 (B)" <prime.zeng@hisilicon.com>, Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH v2 0/3] hw/cxl/cxl-mailbox-utils: Add feature commands,
 device patrol scrub control and DDR5 ECS control features
Thread-Topic: [PATCH v2 0/3] hw/cxl/cxl-mailbox-utils: Add feature commands,
 device patrol scrub control and DDR5 ECS control features
Thread-Index: AQHaHt2kJ4PdrZ71Z0aqfP094Oyp27EMNj6AgAD+9mA=
Date: Fri, 16 Feb 2024 09:22:03 +0000
Message-ID: <1171bf05d6e34c57b3a6ae9bfdfe607e@huawei.com>
References: <20231124135338.1191-1-shiju.jose@huawei.com>
 <Zc5TId-xVNl82xbJ@debian>
In-Reply-To: <Zc5TId-xVNl82xbJ@debian>
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

>-----Original Message-----
>From: fan <nifan.cxl@gmail.com>
>Sent: 15 February 2024 18:09
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: qemu-devel@nongnu.org; linux-cxl@vger.kernel.org; Jonathan Cameron
><jonathan.cameron@huawei.com>; tanxiaofei <tanxiaofei@huawei.com>;
>Zengtao (B) <prime.zeng@hisilicon.com>; Linuxarm <linuxarm@huawei.com>
>Subject: Re: [PATCH v2 0/3] hw/cxl/cxl-mailbox-utils: Add feature commands=
,
>device patrol scrub control and DDR5 ECS control features
>
>On Fri, Nov 24, 2023 at 09:53:34PM +0800, shiju.jose@huawei.com wrote:
>> From: Shiju Jose <shiju.jose@huawei.com>
>>
>> Add support for the feature commands, device patrol scrub control and
>> DDR5 ECS control features.
>>
>> CXL spec 3.0 section 8.2.9.6 describes optional device specific features=
.
>> CXL spec 3.1 section 8.2.9.9.11.1 describes the device patrol scrub
>> control feature.
>> CXL spec 3.1 section 8.2.9.9.11.2 describes the DDR5 Error Check Scrub
>> (ECS) control feature.
>>
>> The patches are available here,
>> https://gitlab.com/shiju.jose/qemu/-/tree/cxl-scrub-2023-11-14
>> and is based on Jonathan's branch
>> https://gitlab.com/jic23/qemu/-/tree/cxl-2023-10-16
>>
>> Changes
>> v1 -> v2
>> 1. Changes for Davidlohr comments. Thanks.
>>  - Changed CXL SET feature data transfer flags as enum.
>>  - Modified pointer supported_feats to get_feats_out.
>>  - Removed an unnecessary branch.
>>  - Use MIN().
>>  - Move setting of hdr.nsuppfeats further down.
>>  - Return CXL_MBOX_UNSUPPORTED if non-zero selection flag is passed.
>>  - Add more IMMEDIATE_*.* flags set_feature.
>>  - Corrected a spelling error.
>>
>> Shiju Jose (3):
>>   hw/cxl/cxl-mailbox-utils: Add support for feature commands (8.2.9.6)
>>   hw/cxl/cxl-mailbox-utils: Add device patrol scrub control feature
>>   hw/cxl/cxl-mailbox-utils: Add device DDR5 ECS control feature
>>
>>  hw/cxl/cxl-mailbox-utils.c | 360
>> +++++++++++++++++++++++++++++++++++++
>>  1 file changed, 360 insertions(+)
>>
>> --
>> 2.34.1
>>
>
>Recently, Jonathan has updated all the specification references to align
>with cxl spec r3.1, so for the next version, we may want to also do
>that.

I had posted recently v3 of this series updated for spec r3.1. Please find,
https://lore.kernel.org/qemu-devel/20240215110146.1444-1-shiju.jose@huawei.=
com/T/#t

>
>Fan

Thanks,
Shiju

