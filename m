Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC00A606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 21:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ZXIq2Mly
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMu1S-0003pm-TW; Fri, 30 Oct 2026 17:20:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1xMu1R-0003pN-2Z; Fri, 30 Oct 2026 17:20:25 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1xMu1P-0000Ae-Fh; Fri, 30 Oct 2026 17:20:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=en4eEsHMETP/LXilHQBebnV9oIRe6NCqe/kjXyHK+3RaS5cGqQTQEh0CW12EG+82rx0oZcNFvIp5fu7p2aPqTsUuqaLPHLjLiri2O3qEGTztLTiZOtRNS7L441iiUDwRwyvNRKhC5cweLdTe3qyrdsB+ypOjgB4MuQOktZGrl8f1ZjpsUN3+oRkIHe7NWvvMiYy4m5rTmf4hQeAiYJnhs+gmL69r2hY9aZLGsI2QE9g2i7uU6bYSvfzKqqL8zNeuSrX6krCDj+WuoEYa3RmUtCz13dTXLRs90X3XWdlHdAE4Sfwlk7+xQNvjfLxRIKlOzSrgprsj+2TKDqEv55N+hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7p/SNFLojXZ8PuVpxf8+RtfMyf6A6pjzfgGH8K1GT0=;
 b=Usuh/iwkYOvjAUWK4gv9SLmK8YGVIxXPxH5fSUiqzCVTfQdRUcicOCeNdbjpSwQQnOCw/sb4dEJZdt6NefAIPo7ajXuwP1I2T6SRNMn6BT3joiJRJPQUoJkKSFIg7cmpYX2W567PRwRW0T5J9IqrGowoEeRNjdturhWlH93zUE7fUMAehD7v75yZqqL7BEDCUsXJyNszhmUe47JtByFIqouCB2hudMiCl+izQtS/NA+xo3Mz6l64WjgFdDdHvGW4RgXpcaZP3JQc+wDsND5A17YatNEB3vKkzr0kkXfKLtowA1+y1xzSj8vmCKzLFVtaDeAPyWaa4sWvYv5h5UvgmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7p/SNFLojXZ8PuVpxf8+RtfMyf6A6pjzfgGH8K1GT0=;
 b=ZXIq2Mly4UakXaOy4ibyadkzaHzulvEH3xKUYmoneuQweM2fWyeyDc+QQzBnLDjrZTYxEHwILsra73o+WQjHes/+B4cqCJU+t1iTV3pYCjyeCzCtz6Yba4aIx8rg34JdPOqZDIEJO6VG4sLpVns6ySXtBEos1y8egAyQ3TDGB9k86JuPXMLqQOxryXeANwrjshgsHY5n46RKVieAfPAee/sWyJArXWrBlIS8upYHf5N1uoW2uGT3KAMEPl8eKEij288q0sp/1RTDg4QqM8I8zLyk6laRnEr/VIFfkTFmrI1qWy/bt2i900KT0KGU4cVwUkYcwAuYyFid04qlPz7VeA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17) by DS7PR12MB5816.namprd12.prod.outlook.com
 (2603:10b6:8:78::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 21:20:17 +0000
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1]) by IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1%5]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 21:20:17 +0000
Message-ID: <d1b6ff2d-e580-4490-a8c0-975394ecbe1a@nvidia.com>
Date: Fri, 30 Oct 2026 16:20:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] hw/arm/virt: export fixed BAR metadata via fw_cfg
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "mst@redhat.com" <mst@redhat.com>, "marcel@redhat.com" <marcel@redhat.com>,
 "devel@edk2.groups.io" <devel@edk2.groups.io>,
 Alex Williamson <alwilliamson@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <20260916185554.917526-1-tdave@nvidia.com>
 <20260916185554.917526-5-tdave@nvidia.com>
 <SJ0PR12MB86141EEA7C2A286558146732AB602@SJ0PR12MB8614.namprd12.prod.outlook.com>
From: Tushar Dave <tdave@nvidia.com>
Content-Language: en-US
In-Reply-To: <SJ0PR12MB86141EEA7C2A286558146732AB602@SJ0PR12MB8614.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0213.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::8) To IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR12MB923065:EE_|DS7PR12MB5816:EE_
X-MS-Office365-Filtering-Correlation-Id: 92621b62-fa13-446a-317b-08df36cb98a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|11063799006|4143699003|56012099006|261009223027099003|261026121527099003|261026140227099003|261022075727099003|261022105027099003|261028144727099003|261021123027099003|261021121427099003|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: NtHwr6SAM5JyfHdCXLFcjACroKqt1JwcDQjKgSAdjMathqHgOtQNSPsWkEJYd4MrfePC5iDiVLxC2IeYKyTFDmEjPSTF4u+UCAWB43uIzdJW0GBkkARMFTxIBGQvaKhBWgckjzySp8Sp/mo6whGqRz5pOvCX/uF77oQ8rEFmOhb6tvWF7aDQsnGK1vYZRflM7fObVdfAk8irExDWmKa4roBbjTyxt5h5QDVkd5ce0lsCWAg4Z5X5gemRy0XAnW7ksmN4lR09wOkKIaq/QUWh2xmwflM5T9rAsHw9UZLf1kcVExB8NAHVncR2HmWL4OsNBKvsi1UajDqj0V0MBqEynqZkP017qedF5z9Rd5Zjkk6gtWucnm0trBZ3UbPste7KNmWuMUeqnbkjT3jb+nAU3XxTQ5Fled59V3k7u2czoRhPmt93vLEAPhPWB6v8kYxfQEEDhbhA/5v/36/O2S7SOv4pZCp4aXnXzMlHqE7yLiN9mJWCD5qcQGAgzTwVnA1TKFIL1ignILgctuKd+k04TYkKfuiT3oGWClxJTtyqpiP8acktrx75vDCmeNvqfli6sHFtBj0SU4UF9In57D7F9N8wlElSD8L75lRAqAW21ps0UMrcEPXWIyJK75lFxcwnl8Ymsu1B4ma7DQCvANIjV8Yeofe2PoZKLMkZti4RoNg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR12MB923065.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(11063799006)(4143699003)(56012099006)(261009223027099003)(261026121527099003)(261026140227099003)(261022075727099003)(261022105027099003)(261028144727099003)(261021123027099003)(261021121427099003)(10067099003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmtvWFpQRDVJeTJ4NmVENzV1UnhBWUZqVG1Iek5ENHQ1YlpTUnlnOFlXYW1k?=
 =?utf-8?B?YUJYNStmcnhEZzAzL2NRZE1XSTc1ZHRCUVNUYW1hK01SOHFGSUhOREFPaUM3?=
 =?utf-8?B?ZGpMM2VBUURFc0JFdFIzbkZJdTB6d1ZjZFhzZ2Z4WEU2ZEZKZzl6STNhOWdV?=
 =?utf-8?B?WEgrSFlqUnMzSkJtZ3lXZStzVXNmT25XVkcrejRiUUVQeExmbzhMVzc1ODRQ?=
 =?utf-8?B?RXBoQVlGNUcrYk9VZUxSM0N1SnpyTkJOOWFUMVpKRVdDTmRNYUMxTlRXM1g1?=
 =?utf-8?B?NDV0d25BOWFOTGZTV282TGlpSHZNUG9tNUxFUitCNUtjSldXcGNtSkF5bll2?=
 =?utf-8?B?aGlvN3J5bUgwaldhZ0VNamFDUEp6dEVFZGViWFhVQWNoU1lRYzJOdTNKVkds?=
 =?utf-8?B?Yk5qZERrT3NtdHJQMHNmQ2ZLMEkweHhVZ0JOZlhDci85NVVBbk5kdktMRFU5?=
 =?utf-8?B?bkQ3RWE3STU4ZkRmYTc0UVhkNHJJUEJqY2l0cjVWb3dGNmhyYlUrK0ppcnho?=
 =?utf-8?B?WGFKQkM0V2drdjNZTkd6Unp6cW9tNCtHQ2tldEhhTEpnck1tclYzcUNteWdh?=
 =?utf-8?B?MlJpcU9HbWVwZUE0Y1h4WVl0OVdNcm1WSjdZSndKWlk5dFRaWHlybDRRa2Rz?=
 =?utf-8?B?ajBSditVcnpRYU4xZVlQVTNOdStnZW1KdEFhWU0yOWl6QVhnczRTRFlsZm5X?=
 =?utf-8?B?UzJBZk9ZOUsvUWh3OC9mOUl4TkRvVGxIWGR3WHNLcXdIRGgyUitmamxMblhC?=
 =?utf-8?B?ZXdLOVA1KzF2dVFaTVFoenpLMHYrQWozcTEramVRSnBzdENhUnVrZ1NwT1Vi?=
 =?utf-8?B?NVpyVHlHb0FtRWpYU2QrWUJ6N2RiVlRKT1o5aisrKyt5U3Y5bitwK0ZWOXRP?=
 =?utf-8?B?M3hMeGFjeDMzd0ZoK1NiQ0t2amRnMGo5RVJaT1E2YUZRc3hDR21jbjRBZWF1?=
 =?utf-8?B?THNMeVB1TWM4SklSb3Z2bEpIWTZ0VDkyUWpWUHFLTUUwNDMvRFhUcHBuQm8w?=
 =?utf-8?B?Qlp6S2cwZ0dpNGhmTVhlTUE5RENMd0xJNlFuVXNxT2pFVDY4TzJuM29ET3lZ?=
 =?utf-8?B?ZE03L1llUFhZanNaenNoM0xHWUhyTThIeDhpcllDUGsvcm11aVBhcXpwc0Vh?=
 =?utf-8?B?MWpmT3huVTBlNU5idGZUNlIyK2JJeWlHd2VCcURzK05taHQydUM5OHhPb1la?=
 =?utf-8?B?VFhENXh1MzhDM2dxL1VzSU5oRi9rY3dDQW1ZcndsLytMdVFkWUo4K0dTdlE4?=
 =?utf-8?B?UFg4NWVpR0VVTUwraW1DeHg0YUtUUFBpWm9FRm1KNlc3dmQ1WTN6TWUrQW5M?=
 =?utf-8?B?dHZsYWxxcGNqYjdTeDRUOFF5cVVVTFc4SHBEWTlxTUsvRmlId1N1czFPSUpy?=
 =?utf-8?B?UDhMbStzSCs2eXB0ZTdUeEFYNkNaaFFlR0dkUldHNVZGZldRb2h3SE1Ndkg5?=
 =?utf-8?B?eTZYSE1NT3dxRGdvMXVWd29XamdWditjSUNHekFjOGJYYkVldFdmS055RGtQ?=
 =?utf-8?B?YjZSUWZTL21IMWM5YnB5ZUg1MXFvTWF1aXZ2Y2lYMmdMdTZrb3FxQVlsblBW?=
 =?utf-8?B?R2J6YUxZUU4zVlNmZnJhRnIvSW4xbDJzdklyNWw0V29PaVpjUDQwTUZpMjAy?=
 =?utf-8?B?TGtxckowd3J5SnpqbTUvckc5Y3FjV3RSTjQzMzFXNk52ZTRYWld1VEdOUGdx?=
 =?utf-8?B?bkJZSFJFVUxWUVBEWGVCdnNVYVVTa1ZtR01tVHpYdG9Hb25KamN6ZmZsUEx6?=
 =?utf-8?B?QklYNDVhdlNpSW9KODMvbTN4THp5Z2RMK2RrenBxYUVsMjV3TW1PVW9XODFi?=
 =?utf-8?B?TlFpRENzTXYwNmd1OVlKZlc0NmMyVW9QaU5WMm5JSXo2ZkdRZmhkM2QvMnA4?=
 =?utf-8?B?RkxBNzFJRlVWcVFRUGhGeWh1alBSM3JRL0ZtNDVOUkV6Rm5pNFc4bDE0Yi9z?=
 =?utf-8?B?MUNDMEluZmFBVENNWUgrOXk0c080OXozVWZSMU90VWtUMFp4bDRKb242cjVO?=
 =?utf-8?B?dVFkY3FiVHlScHo1TXFGRXZXZzJ6YzNHdlNPRHRxTnhobGh6QUVrYzNvRjV3?=
 =?utf-8?B?NEZCcVdGenlSK3ZjcmlvSkhjdzAzNnRldk5aSXVxNk5pcU84dmR5VzZGK1dI?=
 =?utf-8?B?ZnV4WnZsZ2gvaGI1VEUvejYyZE5zWWNFSklDYWF0WVczc1Q3ZTY0UFFZU2tX?=
 =?utf-8?B?T0dRQVJFQ0Y1S2VoT0hvZHpMTkVzcmhaMGxSKzVpQUNRNHRReThIMkNOWXRo?=
 =?utf-8?B?Lytna1Jqb0hWM0lXZTBMSWVwbnhPTW96eXVGQnAwYUF5OW5EOXl6WTdyTjFD?=
 =?utf-8?B?Q0xWcWlxa015aDZZeUN5Rm1UNFlDN3NzMWV2QnI4Y3M2Yll2S2F2Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92621b62-fa13-446a-317b-08df36cb98a0
X-MS-Exchange-CrossTenant-AuthSource: IA3PR12MB923065.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 21:20:17.7397 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dX2fG6e1oLkddJzf6LBwXCNV4M6Kcr9CDQs37XQdrbL5nYjnm+Q00iaRFyTHsOtf1nQ82s5dY/dB0CtDUSDAyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5816
Received-SPF: pass client-ip=2a01:111:f403:c107::9;
 envelope-from=tdave@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/27/2026 11:14 AM, Shameer Kolothum Thodi wrote:
> 
> 
>> -----Original Message-----
>> From: Tushar Dave <tdave@nvidia.com>
>> Sent: 16 September 2026 19:56
>> To: qemu-devel@nongnu.org
>> Cc: qemu-arm@nongnu.org; peter.maydell@linaro.org; mst@redhat.com;
>> marcel@redhat.com; devel@edk2.groups.io; Alex Williamson
>> <alwilliamson@nvidia.com>; Jason Gunthorpe <jgg@nvidia.com>; Shameer
>> Kolothum Thodi <skolothumtho@nvidia.com>
>> Subject: [PATCH 4/5] hw/arm/virt: export fixed BAR metadata via fw_cfg
>>
>> Export fixed BAR metadata from the virt machine through the
>> "etc/fixed-bars" fw_cfg file during machine initialization.
>>
>> Fixed BAR placement requires firmware to preserve the PCI resource
>> configuration established by QEMU. ACPI provides this via the PCI
>> boot configuration preservation mechanism, _DSM function 5.
>>
>> Reject fixed BAR configuration when ACPI is disabled, and request PCI
>> boot configuration preservation when ACPI is enabled.
>>
>> Signed-off-by: Tushar Dave <tdave@nvidia.com>
>> ---
>>  hw/arm/virt.c | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 3eecf094bc..c5db663858 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -95,6 +95,7 @@
>>  #include "hw/cxl/cxl_host.h"
>>  #include "qemu/guest-random.h"
>>  #include "hw/watchdog/sbsa_gwdt.h"
>> +#include "hw/pci/pci-fixed-bar.h"
>>
>>  static GlobalProperty arm_virt_compat_defaults[] = {
>>      { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "48" },
>> @@ -2438,6 +2439,21 @@ void virt_machine_done(Notifier *notifier, void
>> *data)
>>                                         vms->memmap[VIRT_PLATFORM_BUS].size,
>>                                         vms->irqmap[VIRT_PLATFORM_BUS]);
>>      }
>> +    if (fixed_bars_write_blob(vms->fw_cfg,
>> +                              vms->memmap[VIRT_PCIE_MMIO].base,
>> +                              vms->memmap[VIRT_PCIE_MMIO].size,
>> +                              vms->memmap[VIRT_HIGH_PCIE_MMIO].base,
>> +                              vms->memmap[VIRT_HIGH_PCIE_MMIO].size)) {
> 
> Should we check for vms->highmem_mmio here? The memmap entry still
> contains a base and size when highmem-mmio=off, but the aperture is
> not mapped or advertised in ACPI.

You are right, we should.
> 
>> +        if (!virt_is_acpi_enabled(vms)) {
> virt_is_acpi_enabled() merely checks that ACPI is not explicitly disabled. With the
> default acpi=auto, it returns true even for direct kernel boot without firmware.
> 
> Should check vms->bootinfo.firmware_loaded as well.

Okay. I will add the check in V2.

-Tushar

> 
> Thanks,
> Shameer


