Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB214CD98F6
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 03:38:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbVUT-0004Or-Ru; Sun, 21 Jun 2026 23:38:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wbVUM-0004OF-8z
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 23:38:23 -0400
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wbVUK-0002jP-Gs
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 23:38:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MHuGAi5LQos1ySYY95yYvW1rysCdVzL58ldTyQ+nBV6wfCHTs6iIhzJ8UZZ8B6d6Qqa9XGY9bNJPeR/QEFnCQBDBwhA93uilbjxn+TlHGK/OvMX9IiwdTz3fykbY9tk1fHn67x4dVUYyXouWgAUnV/RSuODi/3iRLd/pHxx559PbzGhBNimApgaqbVvPAGSNQ4r7wEcZALT6vlC43bDvN51Z029UxWeHqY7neHguarn3VCFvyIWSoAE7ScsD1ZT+/+0dqYiIp10MHQto49amgbkVuoqIweKuiZZuZAopxcGs6SNkjg7FtgBUichmGEoOCPpmkb8Q0xVJUfIWHBMOtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Do7w1fNo6ejt0l62G7UhcL+RFb8IJxivsStKEP3KP3w=;
 b=mAlM+LsiqE2qRP8q2+Aouy8OdjepRofh45/hZBFDxiynqy2EtpFDSCMmJy13n4Pn1ZYQWryZ1arF1NUrHgn5wyW1L9rjc2rIAxotTNkegV+2x8Mxaa9V4MTp/y++xRaLryPJOrANCM0flZy6zTp+tZ4oSnfch3lL3PyNhjWPk+Q7jx0C22wUZaXQ9KqFnVkKQONtM4BMCf3ApwwhAFrgpKKXcWeRLmMcFAQVwrTWJT8JNcmMux7IXlrQNleIP4xS2DwBsEQJ9alxfP3Rh50aeDLfqX+ax/skXp6pBX3p1mtxQyyAtKT0UCvN4kUbYQ7mKQgycUHwafmaAeojnbfPig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Do7w1fNo6ejt0l62G7UhcL+RFb8IJxivsStKEP3KP3w=;
 b=Y403F9rWAz9vSwd6MLZLw8lVqPKIu6iTZmBDZ5qo02XFSTzy1B/eSLXM9omYHBSfJQr3f7vbHKbdXPreT+eiv3IxGNW+5Q0m44UAGKtr14ueJV32PUKCkpFuvv3jB4iM9E3oeBOcP3pMIL+bWBmEA5vJ4L7CVfjyog5IYuZaOpeJylsN0R8FkvCoU+1cl11eyGEMtzdPgmYmYIrLzup0ybDro/REaoq77tuzMiOACawhufkld43Pyl9msUO10HGaXY2tzI+4EqZr0jVUFqAeIcIkUgV84vXK405moZ0+CcDG48ITj/v21lUioVG+YOfY1KkzEIGOCpayt1olycsJjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com (2603:10b6:a03:37f::19)
 by CH0PR18MB4258.namprd18.prod.outlook.com (2603:10b6:610:b9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 03:38:15 +0000
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba]) by SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba%3]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 03:38:15 +0000
Message-ID: <5446a46f-d0de-48c2-bb0f-7e5ae571b578@axiado.com>
Date: Mon, 22 Jun 2026 11:38:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/8] hw/misc: Add AX3000 clock control
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org, peter.maydell@linaro.org
References: <20260618101249.2926976-1-kchiu@axiado.com>
 <20260618101249.2926976-3-kchiu@axiado.com>
 <9af9e1b9-7489-4ef8-9a33-1d5171a8e9a9@oss.qualcomm.com>
Content-Language: en-US
From: Kuan-Jui Chiu <kchiu@axiado.com>
In-Reply-To: <9af9e1b9-7489-4ef8-9a33-1d5171a8e9a9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0033.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::17) To SJ0PR18MB4479.namprd18.prod.outlook.com
 (2603:10b6:a03:37f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR18MB4479:EE_|CH0PR18MB4258:EE_
X-MS-Office365-Filtering-Correlation-Id: 21f1b008-0561-4afd-49e9-08ded00fb192
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|22082099003|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: ga9HVIwj9tClt+YbPykp3AVp6GQYMDuZxW8+7OfZk/CXepA5aQumq52oM7wwPxQHVorwyezZTq4qyr57wtLnh5a7icJ/ucVdgzx7vaZpKLldrxMT6OntAINuCa1Ry4MsvP3WEZO5xLGAbpn6TRbD2Sm+QhL4ZrB+osnDRFVIwpHT8fW16tzGQfVfQSH7NVIHnY3Pnq7wp78nEnf0aSJHVAUC8A72sRBcjgvNcEquvyq1/JfscL2F9R9pflsczO69A2okf2ow9UTyOUZAYBIqA5CVytzND1BfrHVIAWRJogYLlGEBgyMYhr6nN/teHAW5QEmdXe9UornlkQ+e6kbqIZn5shDdSlcNUHZH/p6tk4N73uxL9PQyM8uR48jBfhOs1KiyykyRXDOb665RyXgKJLUiJlcHJPqzLX/bBqv63qpWvCyh9Q7rezd3y/XZLJs/JVadu3ZQXQ5nKYM9PX+v4zigBHY1gpgai1RQBqHvQhUbRbDwPNtKYMIw1WYOxj0+WLBaSRNU1e44gCkbvmyJWDjlfciuqmm01NmK21AK3/k2xcsrlQV2ReFrRbuj9y7sWKT74CtHyJqJZukDwQ9d/T1lOZOsf7gDDSk2603iUSLZY4Uuxeu3qmLbDjkjOqIjy0GoKVYnmnrGwzx7O+RmutBD0+/8inj9rOQuwRd0YRQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR18MB4479.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1MrTWFVODh2aGdZNEZreWlqblFLay9CLzNWS0hra1hVWUE0VlVKckoxS1Bn?=
 =?utf-8?B?RURQNU4yMjdHUThjTUdySGRMU09Lc01UemlTNU9KL1M0YnFRRG1sYk5VUzRk?=
 =?utf-8?B?cTRUWEtxSDQzV1JNSmtlRzlYL3VyZWdBQ0JPMm04NUhzUEVjNHFMTjdJbHdu?=
 =?utf-8?B?WndpeWMrUk1KMDU1dkZtZVdkVXJOZHVEUkdYenVsOHMxUVRDUzM1S0xhZVM0?=
 =?utf-8?B?S3ZoalMrUXppSDJsT29kWWgyK0RqRklDUGlHbWRyZy9WMmxySFU1V3VxZGpL?=
 =?utf-8?B?TDdrTjhXaFFKMWxXajhqQmQ4OFRMVGlSR2tnZXc0NTVuamtTS0VJRDJLcnRk?=
 =?utf-8?B?YkZjakt3U0pMYU5RN1gzNCtXaE13bmxTZERyYldXZGRFTTVxQ3RoYkpVTmhJ?=
 =?utf-8?B?WDkzbkREMVkzUWVIYTZvNHFXYWNiaSt0cmJJYmQ0SFBwdG92L0RQcjZlZWta?=
 =?utf-8?B?bnJjRW5EQTd5dXZGWUxsRDNrSFNYcHl5VWtJMlBzUVBZS1Rpb1FodG5Pc1N0?=
 =?utf-8?B?M2Z3ZStrcmRXV2F6T3g4ZE9tQzFTSW9qVGtpZHFCaFpTV0hmMGNnWFg5L2F3?=
 =?utf-8?B?cjZ1NkYyTUJQVTcrSzFZN1pmbGNsWklHYWM2ajVVd0R3Y3RlK3BGMWZxYTR3?=
 =?utf-8?B?dWlmNTNlWVlGTFIyZ1dkNzNJbUpDQnM1NXpFczZRMGZ3bGJYT3kzelkyVW52?=
 =?utf-8?B?ZDVjS1BFa2lnaThzRkc4QVVyUUJINjVNdHAxZXE3TE84VUpJdUhSeXdzOUlK?=
 =?utf-8?B?dUVuRGtkRmtpL2t1Mk5sOStRNG5OYjJwR2Z2RUM1aHJsOUJVRmRVTXRhTzNp?=
 =?utf-8?B?M1JlRERPZzVJeUZVUURKV0dURThTMVBzN1VEVmptQmErdzNNV3Z4NUFBcTZm?=
 =?utf-8?B?L3JUUmU1azQzKzJ0ZldSVWREMU9IaWlRendwbkVDaFhLUURiSzNhSzBJV2p0?=
 =?utf-8?B?NHhuUE5iRTNFanFsSFBETlZmVU1jbVBVR1BIM3RqL3A4eW1Yc0VYRkNnS2Yr?=
 =?utf-8?B?OFdTbTR5bG1VL2xYMDBPaEJqb1dvbWtsYzRXNFVUK2ZNS2FEYThsWSt3amVF?=
 =?utf-8?B?aGo0dUR4YjBXQ25GZjZBT1JHMzk2VEJ6dGxyYk5DVk1WamJDdWlPNGs5ajZu?=
 =?utf-8?B?d0NOZnZSQ0h5QUI2ZmczWmJGQ3lGZmlrQlAzcW5Lc1ljc0xEY2ZaNXhwVzFS?=
 =?utf-8?B?MXg4T2lYWEpNNFBIVDhOWk1abTZwUmNESm9YU0xHTlRKeUR2TlZ4aGtUWmRE?=
 =?utf-8?B?NWNoTkUzcUY2Sy8vNjlEM21YSkdrTWhEUWhNQ1B5eTZoWjZ2cFp3SzdtelZZ?=
 =?utf-8?B?dVZxajlxeFByY3lkSk1vYlRSSDVZb0pKUEF0bHFSd256ajdEWmdYMnRQZzFx?=
 =?utf-8?B?d0NCTDAxY3hyUkErRjhpUG5KNkMzbFRMNlpJWTFJWk1nSnpLSU1MMnVrRFBv?=
 =?utf-8?B?ZVRnZDg0Ymw1TmJpYm1TQ3JkNy9oNm0rN3lCSWhmbTZscHJVblhSM3VlSXQ1?=
 =?utf-8?B?NE0wakZzV3NuUTErVk9sV3g4STBCOHFEdDdZSU8xZ0lOa0pBNEdwT3JDbGlm?=
 =?utf-8?B?TkFoY0VtWUZKM3Y1RlRZVWN1Ny9aWERPdGlHRklUd2tGT3p1NGM2QjVuZmtL?=
 =?utf-8?B?WTN4bHMxeWdkeEhTNW8velVOZkdjVDVWOUxNckI5ci9WZGdjNGFpOVI0Q243?=
 =?utf-8?B?d0FiSjFqL20zKy92WkNmclFnSGNJTkV2QndLSkl6ZThQOUtqVmRqcHhqRlds?=
 =?utf-8?B?YW5jbldyV0R5ZTlVNDZUMkV2Z1p5aXVFeFdnbW9pYWQwTGRHMHpaWERUcXRu?=
 =?utf-8?B?YjB2Mk5JaFYzTG1OaWNaeTc5biswQW5NOUlKTHRwWHIyVmZsYnMxUC9ta2tO?=
 =?utf-8?B?TzVuNFVCOG1OQ0c3RC96NVhyeFhCR0s0ckZKZTRDNGdWaWREOVRNT09PanJZ?=
 =?utf-8?B?b3Avd2k3bzhQc3BZdG90MDNaZlpZT2prSmZjcm5WS0NLZWdBM2JOWGlmMVdW?=
 =?utf-8?B?cWVQRnpxdGNXTHZHNVdsTmlsWFBBNWxTejlHb3hlYjUyZ0lSYVpYTnluTDJx?=
 =?utf-8?B?Y2grNzdxVnhmVnkvUm1ENVNhMDMxdytFb1dtZ2FjZ0pML01DMjBRMHlqcG5h?=
 =?utf-8?B?VU9TSG1pZC9seDZYOGlKYWMxa0l4Zk10d0pGWERXMHNEam5hVlNDUUJNbjJ2?=
 =?utf-8?B?ZE9hS3N6Q2J1OWpLc2RURjUzS3VDZ0NrZ2c5WWJGaHVCbG9UTkkwMXhqdERH?=
 =?utf-8?B?YlpCSTZzMEEzT0liaG1tSmtJUGdmYmJQcEJWbThzM0REUUNNWWlkaVBlT2tC?=
 =?utf-8?B?TGRVVUZHS0lRUll4NVV3L3hZSGJaaUNNOTA3dVpJQXFHUk1tSkdZQT09?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21f1b008-0561-4afd-49e9-08ded00fb192
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB4479.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 03:38:15.6395 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T0g1ggFXwA4v21Noa4I0Dn/oFDbwQjgsocyohef9p1Ychjuc0gn9EMkX4Moqd4t80ehv5GHJrNiBIfk7te6Phw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR18MB4258
Received-SPF: pass client-ip=2a01:111:f403:c107::1;
 envelope-from=kchiu@axiado.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


Philippe Mathieu-Daudé 於 2026/6/18 下午 11:23 寫道:
> CAUTION: This email originated from outside of the organization. Do 
> not click links or open attachments unless you recognize the sender 
> and know the content is safe.
>
>
> On 18/6/26 12:12, Kuan-Jui Chiu wrote:
>> This patch adds a new model for Axiado AX3000 clock control which 
>> supports
>> to read ID and status
>>
>> Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
>> ---
>>   hw/misc/Kconfig              |  3 ++
>>   hw/misc/axiado_clk.c         | 73 ++++++++++++++++++++++++++++++++++++
>>   hw/misc/meson.build          |  3 ++
>>   include/hw/misc/axiado_clk.h | 26 +++++++++++++
>>   4 files changed, 105 insertions(+)
>>   create mode 100644 hw/misc/axiado_clk.c
>>   create mode 100644 include/hw/misc/axiado_clk.h
>
>
>> diff --git a/hw/misc/axiado_clk.c b/hw/misc/axiado_clk.c
>> new file mode 100644
>> index 00000000000..6967a5995c5
>> --- /dev/null
>> +++ b/hw/misc/axiado_clk.c
>> @@ -0,0 +1,73 @@
>> +/*
>> + * Axiado Clock Control
>> + *
>> + * Author: Kuan-Jui Chiu <kchiu@axiado.com>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "hw/misc/axiado_clk.h"
>> +
>> +#define CLKRST_CPU_PLL_POSTDIV_OFFSET   0x0C
>> +#define CLKRST_CPU_PLL_STS_OFFSET       0x14
>> +
>> +static uint64_t pll_read(void *opaque, hwaddr offset, unsigned size)
>> +{
>> +    switch (offset) {
>> +    case CLKRST_CPU_PLL_POSTDIV_OFFSET:
>> +        return 0x20891b;
>> +    case CLKRST_CPU_PLL_STS_OFFSET:
>> +        return 0x01;
>> +    default:
>> +        return 0x00;
>> +    }
>> +}
>> +
>> +static void pll_write(void *opaque, hwaddr offset, uint64_t val, 
>> unsigned size)
>> +{
>
> Again, is this allowed? Could we log unexpected accesses?
It is allowed
Sure, we can have LOG_UNIMP here
>
>> +}
>> +
>> +static const MemoryRegionOps pll_ops = {
>> +    .read = pll_read,
>> +    .write = pll_write,
>> +    .endianness = DEVICE_LITTLE_ENDIAN,
>> +    .impl = {
>> +        .min_access_size = 4,
>> +        .max_access_size = 4,
>> +    },
>> +    .valid = {
>> +        .min_access_size = 4,
>> +        .max_access_size = 4,
>> +    }
>> +};

