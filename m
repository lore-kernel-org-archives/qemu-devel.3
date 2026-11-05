Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD62606A330
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=selector2 header.b=nvdUfaA9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOzT1-0006bI-K8; Thu, 05 Nov 2026 10:33:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1xOzSx-0006Wv-Pe; Thu, 05 Nov 2026 10:33:27 -0500
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1xOzSv-0001TL-PD; Thu, 05 Nov 2026 10:33:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A1nVsaIbWON9uwkUp9eng0Q7Gh/vMvwTun31z1wUKGR7d77PISNpUuaizB3MzmSPM1HRhS1CDiWgWUN1UrhL+sUmy8DV9KklKd20z8BVi6CIsYb/rCAg5/YSuSr30qn2q/ad6ixwWj6n0Z1aapt5UgfFKd2H3NZnTBq4n5k3tHJSdN6q25aiE4mgvebFHxFD2UbodxtgwiTrLWpuVr+1BcmDsbsI7J6WlEM9aYDOFH1pnE0wZ7p+C9oPNrWN4uWyDZLtCktSRJf80qQIAoKAu8YGA8c3ClBjzaFDBFS1WG2e8MkRsS8Q9egSmAKOPl25sVycdGHkqhIuT6tYFTJp4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cy0BnIqnsHnV0nI9Bl1PRUBReiFuR0Sd35yZq2OoLgU=;
 b=qaxOVu41nA0+OvQd1zdJbM4ZtwxKfHzHLTWUJ5uYDSZ3tJ+p6cfhtuOQ+iqveU+4Ltp8Zw70oI9snrGJeigeFfLG1mkziKzLH20ekEwAiRshWm0QXNubhsxEP8hiuaRyKlN1fLjss/LmzExgWhoWyCHn27k8vE17J0orQ70FJCgPpZZhZjjyhc9Glb1l/OM1MuGk7SAhjsiWBEjqLfeE6nRALVt/4hFG8QuKDyKBY8QC1hSRIqd7DEd3Y8vXw2crKRppPqKMU28nQfgdpJyzfaBHKOGj9z00bruA0XfBCA6Jn59fxXtLas3Oi1WZ7hZ9XdQwpT/U+snCNIwsgUB0Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cy0BnIqnsHnV0nI9Bl1PRUBReiFuR0Sd35yZq2OoLgU=;
 b=nvdUfaA9rSlYfkGuXEsTM65TZLOYjv5PAxA6g2eLVbmuaaRgYAzxfWWmCGMNdzybI4DMwyj6CDPwaioAY6f3K/6TmLvxZKzgNMc0QglO+dLKM2DY9EEfdFelWWPejV4c3Mf4tFiFv/8Kzpm+69mfm0sOupUl40V/tewhuW/tpDC2RR76ZVNhqwrcCK+2v3/dFMITSbsdeLxqjsjrCK4sbB4o2mGmuw302arcnPSoowzSJw2Gnyd78TZD8CDjCYIBo+6ElFP/F6MePL1HqVOJdGHHX4yADasFH6yZuHFYLzzFk3wFSWjYCaN54Dq2SH4CKFEEWyVrH8Q9hIZ6hSS24g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by DU0PR08MB9485.eurprd08.prod.outlook.com (2603:10a6:10:42e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 15:33:10 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%5]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 15:33:10 +0000
Message-ID: <3ba00613-8be1-4c70-8175-34b8f35d1e22@virtuozzo.com>
Date: Thu, 5 Nov 2026 16:33:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/ide: add SPDM + IDE + TEE pci support to ICH9 SATA
 driver
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Jim MacArthur <jim.macarthur@linaro.org>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Tao Tang <tangtao1634@phytium.com.cn>,
 Jagannathan Raman <jag.raman@oracle.com>
References: <20261104-ich-driver-spdm-v1-0-60d361bc0417@linaro.org>
 <20261104-ich-driver-spdm-v1-2-60d361bc0417@linaro.org>
 <82fe2840-2775-47b3-b077-180fbd811b03@oss.qualcomm.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <82fe2840-2775-47b3-b077-180fbd811b03@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VIXP296CA0029.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:36e::10) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|DU0PR08MB9485:EE_
X-MS-Office365-Filtering-Correlation-Id: 81ad7a29-f437-42c3-3632-08df3b5218f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|7416014|366016|10070799003|1800799024|18002099003|22082099003|6133799003|10067099003|3023799007|4143699003|56012099006|5023799004|261026121527099003|261028144727099003|261022105027099003|261009223027099003|261102123227099003|261021123027099003|261021121427099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: /GYTyyXL1C54knNj/O7o3DnBruhJBh4M4wMLbbrlSDDamOJc9NH13E6pFG3KoINPB0gSdVZtMBJkfDrcLN/Io/866gfj4GPQB5kNMdaa0tMpNsFTr12n1iAlfFfKsRt+swx8owwJqnHAaF7HRDiWUwUO17r5tuYjfjWDi7d70L0r8nAXakSMmFFfoe4FFiEFaBwUO5nyyEghO/nzT9J435tyCQjTR4CLwlgFhCF6lcc/hS09k5fFO7HpvmYGe9P2k2EeYzWor6aAqHw3oop+MdKagBDwvd5BJTdydi7VKWcjyZUfH70E/eLrGbCY48zLbnwcjf3CDzrwVqi3RszmHJJrM1sunyWPmJjjbe3Cna7wFi2aQbwWRxc6d4xF1mmq9Z1qgGgiTdFr/FIQwHEg6ucQie6dLAdUj1LzQkKxP7/MTpIP9gLPc4fEUvhWjojmdqn031Snm/pk31567QTQCegY7zLf/aNjpWosDxuXC7otAXvLJHJiJ+IfdLyh/n98taDChJCkYIr2biZxsWlQNFA1/Q9vkH+oiWvzzkUktvPbKNlFjv10HmfcKa52Iuq0VLVat3q7bHtQ45AAfsIwNeJwOjhAV0X1WmVOXJc3SAgwUiYsz/3zBJvkVUC4FLK6xpLgbANDx3OXuQ4J6tBRGB3eJOan2Ub0nd49zD/TJG4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(7416014)(366016)(10070799003)(1800799024)(18002099003)(22082099003)(6133799003)(10067099003)(3023799007)(4143699003)(56012099006)(5023799004)(261026121527099003)(261028144727099003)(261022105027099003)(261009223027099003)(261102123227099003)(261021123027099003)(261021121427099003)(261026140227099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEVabFp2VXNJZXpyVTNuaExqU2M3eGE2QXFnMWNlVE50MUxKRnFlOTFqVUd0?=
 =?utf-8?B?c2I1cFdDMkdNNHQxQXArd0ZJWVJpdDN3OXBndVg3ZzBNcjhkSDNLVmZIaE1u?=
 =?utf-8?B?bHJDV1lBYkV5MC81M1hXTDJTamRnNFR0ZExpeGJJV3hhei9SYkxkMWNITFlm?=
 =?utf-8?B?TWtZN2ZaQXp2TzdJclBSeEcrZDlaOHBQN0Z1b3lLRlY0SDdhWE5OR1o1TUtm?=
 =?utf-8?B?WVFBTzVINVZJUzhINmtGVDVXbXpRT2YvK0xyNmVUOG1ITFhGRWZONzBpNkNM?=
 =?utf-8?B?U1Y2K0t5SFRNalpPOHQwMzExRGR2RXVTc0tWd3JmM1dnN0JRNTdjcURxTzdT?=
 =?utf-8?B?cGxPdGZ4UWVQZE1KYmtaOVBLdGhDUkg3eFlkaVhWNWkyV0w3QzY2bUhkV3Ba?=
 =?utf-8?B?OElqc1N6bHhycFJKNU1YSEpGVFg2OWJmN0pqZkNVUFpxU0lGM29VM3ZKTkFp?=
 =?utf-8?B?K0VaZVJEaTRNNkwvTmdLS24va0VPenJEaHlhUGtFd1R2N0tNVlZQZE5WeHgv?=
 =?utf-8?B?Wm4ra2ZPL2ZOeGdURU81R3UzSG9MUEdENE9BcEZBL0pmSHFkbnZuZUlmdVBO?=
 =?utf-8?B?bTNsTTU0TVFwK1JsZE93OVhzQm05Y29RRm40UmdHNmhoajRGeXRkR3NhVE5S?=
 =?utf-8?B?cXpuSHJ3K2Jka1lNVGJUS09QV0tKRGNyTXhZWnpNZnR5UFc4QUM2Zmc5d2FO?=
 =?utf-8?B?ZFQ5a05FaG54WW5KSkM5RTkrRkxna2JuQUVsSVdYS1p2dWZPQkY2MEdIREJz?=
 =?utf-8?B?ZEM3clZvbjVWOFBFbkpvNjZOeUhRQUFUUXZlOTN2UFA4ZjlqK2tmK0xMVWRr?=
 =?utf-8?B?VDBXNC82Ri9CVUY0S3BKMGFhM281ZExPNzg2L0VjWFU3VmVtZDV0RkJmczVs?=
 =?utf-8?B?ZFJlTjVvOFlLUC9RbDBYUnZUWjhrVUVhczY3SXg0dUNzWXg2VmdOYkZBQ2Vm?=
 =?utf-8?B?dzZ5WjVyOTVqMmkzcG1heHpWRTBtVDBjRlRWcWdaOXBDcG1BVEZBSmVnbHFh?=
 =?utf-8?B?bmZXeWZXTWFzWFBKTVpqaEhZMUY5dWZxaHQyVkc1WWZnL0ZYZjhyMTVKd2JR?=
 =?utf-8?B?MFdLVDZ3eGE1QkJMbFlrdEs1S2tRODJ1TXBObGxianN1M2lmNUsrQURSOG9B?=
 =?utf-8?B?TkovU1NwbTk5ekNoS1JJZEswelBUd0xxaVBpR2FNMVlWZFdORHNCclIvN3pH?=
 =?utf-8?B?VllISmJ5RUp4NXRySXE4WUJneEJiaDVZRDNqLzcxVjNVM3g4V1JsSFN3cUp3?=
 =?utf-8?B?L2M1QXdDRVo5bzBDdWtKTEZaUjZwYnZyTVNJMEJ3SjBlRCtjelV3ZzhHUk1t?=
 =?utf-8?B?bUxoY3JDTFBxL1NNS05BWDJVR1VtbjZaTkJhTGE2bWFIWmRkdHBrU1hZc1pS?=
 =?utf-8?B?eDZZQ080OG1sMlJUYlY5MkUyR0hwSWc2QXNETWxqeld5RHdpbXF2a2d4bW5u?=
 =?utf-8?B?UEJlWGVWaG1RNmZ1WHp5U1YvU3hjMk9Dc1JoOWtINEVoUHdLSWxBVzIrN3o3?=
 =?utf-8?B?RHhOMWZ3N0JEVTRBQzhEazhGTFF6Q1A0cGlEQVdSYm5VR3VQWWRNSVcyNnRN?=
 =?utf-8?B?L0ZOV2Q2NEZudlBuUUIxeGl3KzM4cXZWcmxyMkIwV2tDREZYMUpWNlBYQUdP?=
 =?utf-8?B?cHRjY3NCTjQya0xYQm1JbFBOaERiWGFQSlBNUmRHQVpKRE9YbHNCYUQrTFZC?=
 =?utf-8?B?RW5JVFhZTFlUNU5sWG44K1RZdmlxbHZpQmsrWmxSREtWalhSanNFSjlEaFU1?=
 =?utf-8?B?V0swbWVFc2xZcGRhRkJ6cWZzV0k4eWVKT0lWQnJBZzZmWHdpL2w2Q3Qwc2t3?=
 =?utf-8?B?NUJFOXBNa1g4THZjQ0R4aC8xRjBvbFc1blJBTHBZdGF0SFNLMFVFYi9keTBV?=
 =?utf-8?B?VU5RRWh5cnNrNVhaUGNta0FqbzltZnVCZUlQVnJXUllQNHRQVWhJaWZkYVcw?=
 =?utf-8?B?eWt3T21BSk52RjZIV3h4OWRKVWJGVFpVRWgrKzM4RUdpZnNZdEJxeWFPY1Ur?=
 =?utf-8?B?c0FoRG5YMFNvTWRBWGhUNzJraWtDdXYzVm5sOVZ2N2krenFrUFA3VFBpQmNn?=
 =?utf-8?B?Y3NQZEYyMUovZXdCOUhJakRUL1F3VEoyYWYzWHJ0OEpwWEN6bG0zYXl3WlF3?=
 =?utf-8?B?K2dnYzRicTQwaUc3V3dmVzRCZUJrYzlwWDhRTnhvUW9tbjNidFU0MjB3Q25D?=
 =?utf-8?B?bko3MS9sTlkvdWVCd3U5MmlCSUFIKzJBTjhoeHJJaVVZMWxHaytKWjRZa0hT?=
 =?utf-8?B?c1ErRklaa2dNNDNLVS8wM2hhbWNNcW9rMDROYXVXT0U2S0dOSVBOMFJsNXlw?=
 =?utf-8?B?WG9pbGdwandXRGVWb2tWZG85ckFtNERya0FwK0sybkw3eVIwR3h4S2gra1lZ?=
 =?utf-8?Q?Hnzwr5SOM7Glh+mmRNnK2eqyCXUkWPZ5Opvu12byUJ/dI?=
X-MS-Exchange-AntiSpam-MessageData-1: rl8Yimirys7IEA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81ad7a29-f437-42c3-3632-08df3b5218f9
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 15:33:10.3549 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ceKZ73/ml/4VSsKTndlcvfJaai08xrHIRSgV+zJrHTkCHueleA8CD39rVQl2X4ea2UUoJ0kNNEEavMIjle0zRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9485
Received-SPF: pass client-ip=2a01:111:f403:c20f::7;
 envelope-from=den@virtuozzo.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/5/26 08:12, Philippe Mathieu-Daudé wrote:
> On 4/11/26 17:34, Jim MacArthur wrote:
>> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Rationale?
>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
>> ---
>>   hw/ide/ich.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 80 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/ide/ich.c b/hw/ide/ich.c
>> index b00987f08d..58e2d3b998 100644
>> --- a/hw/ide/ich.c
>> +++ b/hw/ide/ich.c
>> @@ -70,6 +70,7 @@
>>   #include "hw/ide/pci.h"
>>   #include "hw/ide/ahci-pci.h"
>>   #include "ahci-internal.h"
>> +#include "system/spdm-socket.h"
>>   
>>   #define ICH9_MSI_CAP_OFFSET     0x80
>>   #define ICH9_SATA_CAP_OFFSET    0xA8
>> @@ -90,6 +91,10 @@ static const VMStateDescription vmstate_ich9_ahci = {
>>       },
>>   };
>>   
>> +static const Property ich_props[] = {
>> +    DEFINE_PROP_UINT16("spdm_port", PCIDevice, spdm_port, 0),
>> +};
>> +
>>   static void pci_ich9_ahci_update_irq(void *opaque, int irq_num, int level)
>>   {
>>       PCIDevice *pci_dev = opaque;
>> @@ -120,13 +125,39 @@ static void pci_ich9_ahci_init(Object *obj)
>>       d->ahci.irq = &d->irq;
>>   }
>>   
>> +/* Sends an SPDM message and receives the response */
>> +static bool pcie_doe_spdm_rsp(DOECap *doe_cap)
>> +{
>> +    void *req = pcie_doe_get_write_mbox_ptr(doe_cap);
>> +    uint32_t req_len = pcie_doe_get_obj_len(req) * 4;
>> +    void *rsp = doe_cap->read_mbox;
>> +    uint32_t rsp_len = SPDM_SOCKET_MAX_MESSAGE_BUFFER_SIZE;
>> +
>> +    uint32_t recvd = spdm_socket_rsp(doe_cap->spdm_socket,
>> +                             SPDM_TRANSPORT_TYPE_DOE,
>> +                             req, req_len, rsp, rsp_len);
>> +    doe_cap->read_mbox_len += DIV_ROUND_UP(recvd, 4);
>> +
>> +    return recvd != 0;
>> +}
>> +
>> +/* SPDM protocols: plain and secured SPDM messages */
>> +static DOEProtocol doe_spdm_prot[] = {
>> +    { PCI_VENDOR_ID_PCI_SIG, PCI_SIG_DOE_CMA, pcie_doe_spdm_rsp },
>> +    { PCI_VENDOR_ID_PCI_SIG, PCI_SIG_DOE_SECURED_CMA, pcie_doe_spdm_rsp },
>> +    { }
>> +};
>> +
>>   static void pci_ich9_ahci_realize(PCIDevice *dev, Error **errp)
>>   {
>>       AHCIPCIState *d;
>>       int sata_cap_offset;
>>       uint8_t *sata_cap;
>> -    d = ICH9_AHCI(dev);
>>       int ret;
>> +    uint16_t cap_offset; /* Next offset for extended capabilities */
>> +
>> +    cap_offset = PCI_CONFIG_SPACE_SIZE;
>> +    d = ICH9_AHCI(dev);
>>   
>>       d->ahci.ports = 6;
>>       ahci_realize(&d->ahci, DEVICE(dev), pci_get_address_space(dev));
>> @@ -145,6 +176,7 @@ static void pci_ich9_ahci_realize(PCIDevice *dev, Error **errp)
>>       pci_register_bar(dev, ICH9_MEM_BAR, PCI_BASE_ADDRESS_SPACE_MEMORY,
>>                        &d->ahci.mem);
>>   
>> +    /* Legacy capability for ICH9_SATA_CAP */
>>       sata_cap_offset = pci_add_capability(dev, PCI_CAP_ID_SATA,
>>                                             ICH9_SATA_CAP_OFFSET, SATA_CAP_SIZE,
>>                                             errp);
>> @@ -165,6 +197,29 @@ static void pci_ich9_ahci_realize(PCIDevice *dev, Error **errp)
>>       /* Any error other than -ENOTSUP(board's MSI support is broken)
>>        * is a programming error.  Fall back to INTx silently on -ENOTSUP */
>>       assert(!ret || ret == -ENOTSUP);
>> +
>> +    /*
>> +     * Initialise a capability in the legacy space after the ICH9_SATA_CAP.
>> +     */
>> +    pcie_endpoint_cap_init(dev, ICH9_SATA_CAP_OFFSET + SATA_CAP_SIZE);
>> +
>> +    if (dev->spdm_port) {
>> +        /* Set up the DOE extended capability, mailboxes etc */
>> +        pcie_doe_init(dev, &dev->doe_spdm, cap_offset,
>> +                      doe_spdm_prot, true, 0);
>> +        cap_offset += PCI_DOE_SIZEOF;
>> +
>> +        dev->doe_spdm.spdm_socket = spdm_socket_connect(dev->spdm_port,
>> +                                                            errp);
>> +        assert(dev->doe_spdm.spdm_socket > 0);
>> +    }
>> +
>> +    /* IDE extended capability */
>> +    pcie_ide_init(dev, cap_offset);
>> +    cap_offset += PCI_IDE_SIZEOF;
>> +
>> +    /* TEE capability bit in legacy space*/
>> +    pcie_cap_tee_init(dev);
> Which section of the ICH9 spec describes that? AFAICT ICH9 predates
> DOE / IDE. Is there some amendment? Otherwise this might not be the
> correct place to add that capability. Either use a Frankenstein ICH9
> with a distinct model name, or add at the SATA layer, possibly like
> a class interface (we only need the SATA_CAP_OFFSET IIUC).
>
> Michael, Tao, what are your view on this?
I am not Michael, but here are my $0.02.

This feature has nothing in common with AHCI, so IMHO this code
should live in a separate device, kept away from our poor legacy
device emulation. As posted it also changes the ich9-ahci built
into q35: the device becomes PCIe with a different config space for
every guest, which breaks migration from older machine types.

Den

