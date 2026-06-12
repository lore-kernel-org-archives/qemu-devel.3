Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19811CD98CE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 20:55:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY8ui-0003wy-PO; Fri, 12 Jun 2026 16:55:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wY8uh-0003wc-PF
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 16:55:39 -0400
Received: from mail-southcentralusazon11012039.outbound.protection.outlook.com
 ([40.93.195.39] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wY8ue-0004vD-6J
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 16:55:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KqAam8M4ptqetsApbH2BCy2NJYTiD0guKPHJN5MX0RvPKosu1wQQeiyHVefj2yO2h3s6xh3HQNl4UgzZP2cVrxMtlYEqkujAoEr8VmsBeezPm12lGU+LDhg0ro7S5p2u3F6cZV6Zu/P4Q15kJeTjeGpF4wLAkIfrl16CVl6QZgpj7GioqfV7wtuiTtSn3qW/fJ4p6I92GvVVULpobRJWbhpraRQHjdmKWM7vlVFs7zDD3OwBG81OybVkGTHM/k/CxFXCbs6atoZjHkqnd6RtD7JwbUKIhYE8aaE8xAN5Tzb7NRjRvMbk7a/uRn4e0RyuEGiAWwohbSxtR/WY0snsUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QzHlSIQIsD/dGu/hr7XkBhDFipLlNwojS3r4RO7knbE=;
 b=yLIJlpVdD+GA2cKJIEteGNLYJZ4GZDzjiOmdJBAkFSTvU70bDKTNoip4RVqZrY6zl0g+/yof9/2SOy/3VKxwz1o3zjYZXk/sYgMLuyBOjrWBO7Pja0cniMrc89gfiz4ddeXioAm2UELEofn+2hc4ZTZTHqk69QGdmoEvNNosnalMjEnR7ZUcJLv+NMhNgL5rLgZorbHfCDjZszIAQTkHFJ6g+ywWNAxI/cEZP2qIvOcc0NsLcTyjht2BXno+sSEJYlBOTDuKdq5EIzzGbC/0NXo+i3RkRNL9l2hribHemA7oLmzyDtaexCVQbn3Qk2f/2W7PK1o76X8WU5tqDv0P1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzHlSIQIsD/dGu/hr7XkBhDFipLlNwojS3r4RO7knbE=;
 b=rjYTKG2eOu7KuK/na81FkOiyTqq4ZIl8kee6zdwcxrY4cHprRxF4e+3wu+Ogb1lb0ehjFXidXkgFXhqtPw+HPSlzDEbFBxOsdov5+AmuTaSKSIR60udLOW59Y80+5fCfh89252xGXM6Nc5HpgHGwLKfoE3/TMAvwDmEMQY/caR6R2D3WnB/0y+K9V3/x/Z4Q9+gKh/zxST+/jMlxy01gL/W4C8g0SanwfdjAAy50rCHEXYt3AT1HbKWv1K5wgWi9KIfw+mwzi7alC5MoPBuiWq/XnYE2LmHaQvz7A/9U1SC0HIR5xntkgJRhTc2330Z/mQATBOlqkibgluAXKV05mQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5390.namprd12.prod.outlook.com (2603:10b6:5:389::15)
 by MW6PR12MB7070.namprd12.prod.outlook.com (2603:10b6:303:238::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 20:50:27 +0000
Received: from DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720]) by DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720%6]) with mapi id 15.21.0113.014; Fri, 12 Jun 2026
 20:50:27 +0000
Message-ID: <7825db6f-c999-430f-8829-57b36312ab2d@nvidia.com>
Date: Fri, 12 Jun 2026 13:50:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] vfio/pci: Add ats property
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Alex Williamson <alex@shazbot.org>,
 Matt Ochs <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>
References: <20260612014322.2918836-1-nathanc@nvidia.com>
 <20260612014322.2918836-3-nathanc@nvidia.com>
 <b2ab0072-c7de-45d4-920b-4fce5645f329@redhat.com>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <b2ab0072-c7de-45d4-920b-4fce5645f329@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0188.namprd05.prod.outlook.com
 (2603:10b6:a03:330::13) To DM4PR12MB5390.namprd12.prod.outlook.com
 (2603:10b6:5:389::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5390:EE_|MW6PR12MB7070:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bbd0318-cadb-481c-31f9-08dec8c43bb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|6133799003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: 4wcWC3xtMSzCY7179iN0cCI+0yuGAi/i5qo9dsyqBBlFYKi3oVHvPUlAni7xOQDiO9+JXTL78DyNscQTUtF4AE/83ZsIqp1wp6vfrJR4ekYWSXSJH5s5DHEpgPdT4k5qxajQP78tsQ5DmMjNeeBBaqvPSVMuT6aaKQnPwF0BebxIFLqZRpLr+lHr/3fRegq1wJAFj0P/5dKOm9vMFm0QR0ItLrWBeaj6AeakunfDz2PrX+GyOey9MC/3w8r/Zko2nXXodV3TkBoV0iP8+4QLHjDUK5o5Pu9fSmDX3WxH6sAXcG7B8brEo/iscoeomzHkH357Yp7SRc5dT1O324t3AWLSIB+Hes/VzKrCBKU2pMyMd603sg8seGuDLvWeRL+t1so/Jr9EXYGPnQJWR7xtEKIrCpltJvJSyPJWIeXqUvcXQWv1KR879YPwtoVdjlhq1RRJg6/106Yg42aMHmJpR1SDZ+e+UgnNApiGdo+enaM+Z88XwM2aFc4/wijp/ZG7aTlJ33W2esUHO/dhV8bod1n0s8IBgWVeysfWZpVd1xtzwjcEfM8rz1M9wlgTr5fnyuM8YBPh6bQFtxU0ee8ddyInTz+535Ri9TAey5K2t6IfFHpYsH5vubPV1GnuQ2BjQR0xmw63yalqvTetfvRjH5ZSwsR1ov4kRhVTjQnuClfYbORITBJo9tZpJ9kDQ7uk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5390.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWVoZ1JJcDF1U3ZiK0hZc2Y3Ui9kTEgyZjhJTlFtekJRSzBqSHNkRURYY05D?=
 =?utf-8?B?a3A4UzI3TFRuRHZqZzF0cFlNTXE1b21OYm5SdmN2YW43U0RSM2dPYlVhSDRp?=
 =?utf-8?B?V013WUlBQmR4Z0t4TjV0ZUY3TU5QR0VKWWRMSWEwTlVVQnpJclhzb1dwWS92?=
 =?utf-8?B?Vm9jdVRsUThzb0VqMXRXNVhnUzYvekhsWXNsSU1TUHgvWEhxTFV4M1JNVkFz?=
 =?utf-8?B?ZDYwRnd1dWNpZ0I0ZU9PazZtRzFlczYwNkNSVTZ3c1RrTkU2Z2xBNktmMk5V?=
 =?utf-8?B?ZEVGY2NicGNGZzlHZVc0Z2YxUEZkVUk4Snk4RFhycHlKTmlZS2tDMFZSSTEy?=
 =?utf-8?B?anlzZ1RFa0tDbXkyQ2pYRzJMTGtjRUo1NXNQR3lFaWd2dWltQzNVMWozdktK?=
 =?utf-8?B?MXpqNUUrak9Hdm1rbFRLUUtSakk0UGRQVmlWcDZNZVE3UlpEOXNTcEdFT0dr?=
 =?utf-8?B?VjVGdE5GaCtDTWtOTHBYbFJlYWlWcWplOTl0ZjRpdHZYUXRDQUExTXpsWTdm?=
 =?utf-8?B?THFHOVBUNFpjdi9jR1pLRGp6ZS93WnhYQ0F4ZXZ2YnhQT0JCS2piVlFpaDBF?=
 =?utf-8?B?TnNvaEwzT1dQNVY3VzMwQnhFcDFqVlVZYmFKdklKZitNbW52UEtuZjZxQlRz?=
 =?utf-8?B?bFMxRzNkVFVUWm1uT00rNm5SMXFkOVYyWmZsYzZRRzJwTkNkMFg5RUZxaTZ3?=
 =?utf-8?B?TGZpN0VRblhBa3JCVldYMDZ5blpZRnorTnZkVkFLdk9EcWJzcjREWXpqT3RF?=
 =?utf-8?B?MUdZMWJJblBBa21RK0IxYk5uNDB0ZCtuYWxBVjZOZHVWSytTSEEzQkNKQ1A2?=
 =?utf-8?B?SFBGNnFvUTFTVDc0L2NFcTRlaVBTOUxSZVQyR2lBTmhVeXhYb1NkMU0vYldt?=
 =?utf-8?B?WHdjdFhub3JtaUJuZk0rb3U2Qy9wcXZRNURLS2R5QWFJejMwZkpyMmtZQ3ox?=
 =?utf-8?B?RWF5TTJUZ3RLTkpPcHBqUElkOElpMDBicVRhZE85TmRYZnpqWFE1M3YrVXFY?=
 =?utf-8?B?aDRPZDViZUU5Z2dpZmhJOFlxLzBZd051WkdVblJLNVgxRU03ZDFzNDFFRllq?=
 =?utf-8?B?S0lSd0pXc2VlSGVUSURIc0dyT0hoUjdRYXV4SlJ3TU5rMTV5bEIxOERrbmg5?=
 =?utf-8?B?L0ptSXoxU2FZUnRJbWZvSFliTy90TlBKd0NTbER4VVR2MGwxVUJBWnpSMS9v?=
 =?utf-8?B?V0pGSk90eDZqQyt5U2U1V001OVcyTmw5S0Z1b25YNXhwVUZJOFBuWks0UnBS?=
 =?utf-8?B?aE5pNTVUellyMTg3dVZGVUVuUW0vWnJzbVN4OHdxWndBa1VHaWR0cWQ3RlBv?=
 =?utf-8?B?VVlhTVQ0R0JVaFltTjRUN0o0VlVtazhqVUhTS0hiZkJUcXY0ZUNsQVA1bkNX?=
 =?utf-8?B?SFhEa1h0T3pkOHhORUJHcyt0VUNXRHFqU0FieUk2TitJMjRqWmVNRDk5cmxI?=
 =?utf-8?B?T3g5N3IvV04vZ0hrOExwYk9EKy80cHRKbU5XMDV4cnBwWDhLdFRjRlRHN0Jl?=
 =?utf-8?B?Zk5yMWVEaGZ3THFGQVFUZFJrUTRZaGhaOGp4UFIzTEdqTm1wZGdSWUxQT0dJ?=
 =?utf-8?B?VUxNaDQyRjl3RHpiWmhWenA4Q0w2RlB3U0pLWHVaZlBnbklHU21EbDNZZ2hF?=
 =?utf-8?B?RmVPcXlHc1Y4NW1QaU5aMytEbGZ1RUpXL0txQmRyc2RBQmF1aDB3aDcwV0lM?=
 =?utf-8?B?RWdyVnBodkxSVHlXRzhEdTJqcHVnY0hoTU9xZzJGS3FmWXNFaytxNENPTndN?=
 =?utf-8?B?ZXhMd2MvN2l0Y1JNc3BXam5ySVFnaXMwd3ZyUHhBT003c0p3aS9mYUZPbnVM?=
 =?utf-8?B?ZjVDOU1ua2EyNUwzSVZadmVWZUNLbkkvelVQQ0ZMTGdFcVRCOElMa09vb3hK?=
 =?utf-8?B?cjlUcDJBVFlLdGNEQTU5eHBLOHV3VmJxL3lmeC9tQndFOVVnbUxnemFZSjhl?=
 =?utf-8?B?a1lFSGVDYVhiSG5wbk5XaXZtWWE2cDU2MEM3M3g5WjhRUW1XVk1pUWdVemxQ?=
 =?utf-8?B?SlF5TEJYVEZuR3VveEw4aS9RKzQ5UE5ScWNrQ2FRcFJCZzdKOXpDRHVsenR6?=
 =?utf-8?B?R0grWU5nQ29DZHpMOWFBek5XSWRjdTB0UDVTaVQ4MUxhRWNKUWpEZ1dOOTBq?=
 =?utf-8?B?QUoxQXhLN09LQ0tZZTBPemkxSXQ4RUpCemx6TmFNWk81WmYyZFNiSHc1c3Nn?=
 =?utf-8?B?bzc1TW1pVnRzY05CKzFwU2xIS0YrWDNON3F0LzAxWEhVLy9yMHZCc0xRT0JQ?=
 =?utf-8?B?NENzejQ5bDRnZTYvK2ZkNG1UWHA0VTJpYTFTMWdYZmZwdHNKT0xSbElUb3VO?=
 =?utf-8?B?ZjRmYWFWQ09VQWdZYTFWOGg5clNnVHFiY3R1Y1FYMGNZdHNOZ2lZUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bbd0318-cadb-481c-31f9-08dec8c43bb7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 20:50:27.5410 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SjdrSHCtN6yEE4hl1qs13LIA0qu3v5Pd24E/W2MwoSNC/D0Oww2R+22teYWKvZUCqoqG0ARa3SR3NIk2hRQU1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7070
Received-SPF: permerror client-ip=40.93.195.39;
 envelope-from=nathanc@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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



On 6/12/2026 1:02 AM, Cédric Le Goater wrote:
> On 6/12/26 03:43, Nathan Chen wrote:
>> From: Nathan Chen <nathanc@nvidia.com>
>>
>> Add an "ats" OnOffAuto property to vfio-pci. When the device has an ATS
>> extended capability in config space but we should not expose it (ats=off,
>> or ats=auto and kernel reports IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED), mask
>> the capability so the guest does not see it.
>>
>> If ATS is explicitly requested but not supported by the kernel, fail
>> device realize.
>>
>> This aligns with the kernel's per-device effective ATS reporting and 
>> allows
>> vfio-pci to mask ATS when the host kernel reports ATS as unsupported.
>>
>> Suggested-by: Shameer Kolothum <skolothumtho@nvidia.com>
>> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
>> ---
>>   hw/vfio/pci.h |  1 +
>>   hw/vfio/pci.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++---
>>   2 files changed, 72 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
>> index c3a1f53d35..b48138870e 100644
>> --- a/hw/vfio/pci.h
>> +++ b/hw/vfio/pci.h
>> @@ -191,6 +191,7 @@ struct VFIOPCIDevice {
>>       VFIODisplay *dpy;
>>       Notifier irqchip_change_notifier;
>>       VFIOPCICPR cpr;
>> +    OnOffAuto ats;
> 
> I would move this new property field close to the other property fields
> in VFIOPCIDevice.
> 
Ok, I will move this closer.

>>   };
>>   /* Use uin32_t for vendor & device so PCI_ANY_ID expands and cannot 
>> match hw */
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index 9c06b25e63..6edb3bf5db 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -2546,7 +2546,49 @@ static bool 
>> vfio_pci_synthesize_pasid_cap(VFIOPCIDevice *vdev, Error **errp)
>>       return true;
>>   }
>> -static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
>> +/*
>> + * Determine whether ATS capability should be advertised for @vdev, 
>> based on
>> + * whether it was enabled on the command line and whether it is 
>> supported
>> + * according to the kernel's IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED bit.
>> + *
>> + * Store whether ATS capability should be advertised in @ats_needed.
>> + *
>> + * Returns false only when ats=on is explicitly requested but the kernel
>> + * reports IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED. Returns true in all 
>> other cases.
>> + */
>> +static bool vfio_pci_ats_requested_and_supported(VFIOPCIDevice *vdev,
>> +                                                 bool *ats_needed, 
>> Error **errp)
>> +{
>> +    HostIOMMUDevice *hiod = vdev->vbasedev.hiod;
>> +    HostIOMMUDeviceClass *hiodc;
>> +    bool ats_supported;
>> +
>> +    if (vdev->ats == ON_OFF_AUTO_OFF) {
>> +        *ats_needed = false;
> 
> Why not set '*ats_needed' to false by default here too. I see it is done in
> vfio_pci_add_capabilities() but it looks safer.
> 
Right, I'll set it to false at the top of this function in case it is 
given a non-initialized ats_needed input.

> 
>> +        return true;
>> +    }
>> +
>> +    *ats_needed = true;
>> +    if (!hiod) {
>> +        return true;
>> +    }
>> +    hiodc = HOST_IOMMU_DEVICE_GET_CLASS(hiod);
>> +    if (!hiodc || !hiodc->support_ats) {
>> +        return true;
>> +    }
>> +
>> +    ats_supported = hiodc->support_ats(hiod);
>> +    if (vdev->ats == ON_OFF_AUTO_ON && !ats_supported) {
>> +        error_setg(errp, "vfio: ATS requested but not supported by 
>> kernel");
> 
>   "vfio-pci: ..."
Noted, I will update this in the next refresh.

> 
>> +        *ats_needed = false;
>> +        return false;
>> +    }
>> +
>> +    *ats_needed = ats_supported;
>> +    return true;
>> +}
>> +
>> +static void vfio_add_ext_cap(VFIOPCIDevice *vdev, bool ats_needed)
>>   {
>>       PCIDevice *pdev = PCI_DEVICE(vdev);
>>       bool pasid_cap_added = false;
>> @@ -2635,7 +2677,18 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
>>            */
>>           case PCI_EXT_CAP_ID_PASID:
>>               pasid_cap_added = true;
>> -            /* fallthrough */
>> +            pcie_add_capability(pdev, cap_id, cap_ver, next, size);
>> +            break;
>> +        case PCI_EXT_CAP_ID_ATS:
>> +            /*
>> +             * If ATS is requested and supported according to the 
>> kernel, add
>> +             * the ATS capability. If not supported according to the 
>> kernel or
>> +             * disabled on the qemu command line, omit the ATS cap.
>> +             */
>> +            if (ats_needed) {
>> +                pcie_add_capability(pdev, cap_id, cap_ver, next, size);
>> +            }
>> +            break;
>>           default:
>>               pcie_add_capability(pdev, cap_id, cap_ver, next, size);
>>           }
>> @@ -2657,6 +2710,7 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
>>   bool vfio_pci_add_capabilities(VFIOPCIDevice *vdev, Error **errp)
>>   {
>>       PCIDevice *pdev = PCI_DEVICE(vdev);
>> +    bool ats_needed = false;
>>       if (!(pdev->config[PCI_STATUS] & PCI_STATUS_CAP_LIST) ||
>>           !pdev->config[PCI_CAPABILITY_LIST]) {
>> @@ -2667,7 +2721,11 @@ bool vfio_pci_add_capabilities(VFIOPCIDevice 
>> *vdev, Error **errp)
>>           return false;
>>       }
>> -    vfio_add_ext_cap(vdev);
>> +    if (!vfio_pci_ats_requested_and_supported(vdev, &ats_needed, 
>> errp)) {
>> +        return false;
>> +    }
>> +
>> +    vfio_add_ext_cap(vdev, ats_needed);
>>       return true;
>>   }
>> @@ -3815,6 +3873,7 @@ static const Property vfio_pci_properties[] = {
>>       DEFINE_PROP_BOOL("skip-vsc-check", VFIOPCIDevice, 
>> skip_vsc_check, true),
>>       DEFINE_PROP_UINT16("x-vpasid-cap-offset", VFIOPCIDevice,
>>                          vpasid_cap_offset, 0),
>> +    DEFINE_PROP_ON_OFF_AUTO("ats", VFIOPCIDevice, ats, 
>> ON_OFF_AUTO_AUTO),
>>   };
>>   static void vfio_pci_set_fd(Object *obj, const char *str, Error **errp)
>> @@ -3973,6 +4032,15 @@ static void vfio_pci_class_init(ObjectClass 
>> *klass, const void *data)
>>                                             "a vIOMMU. A value of 0 
>> (default) places the capability at the "
>>                                             "end of the extended 
>> configuration space. The offset must be "
>>                                             "4-byte aligned and within 
>> the PCIe extended configuration space");
>> +   object_class_property_set_description(klass, /* 11.1 */
>> +                                          "ats",
>> +                                          "Control guest visibility 
>> of the ATS PCIe extended capability. "
>> +                                          "Valid values are on, off, 
>> and auto (default). "
>> +                                          "'off' always masks ATS. "
>> +                                          "'on' requires ATS support 
>> for the device and fails realize if the "
>> +                                          "host kernel reports 
>> IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED. "
> 
> Again, IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED is a kernel UAPI bit and it is
> a bit too low-level/internal a QEMU for property documentation.
> 
> What about :
> 
>    "'on' requires ATS support for the device and fails realize if the "
>    "host kernel reports ATS as unavailable for this device. "
>    "'auto' masks ATS only when the host kernel reports ATS as unavailable."
> 
> ?
Yes I agree, I will update the descriptions here accordingly.

Thanks,
Nathan


