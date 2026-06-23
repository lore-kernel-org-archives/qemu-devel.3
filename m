Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B105DCDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 19:30:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc6oY-0006rq-PR; Tue, 23 Jun 2026 15:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wc6oW-0006rb-Hr
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 15:29:40 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wc6oU-0006Ry-Be
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 15:29:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CCnOBT9s+GZTTfK4hVnGsRPcCKKNZ3wrwXX4tZTSoIc/b3cEmtJI0MfycrFteRYh5+PL5kd6kQc9Q2gIlbIGO0dm94lo+kSuO4R59Mo1wmX5aPrhnxbM3UJqwX99Hc+oswZfZWI0q+K68i3pAQk/cHFEdDHjmYZJYCwUy3viKMGLr6+CMltE6m8DRM49DwAuRr9DN+EUxeheQwWept8vEUrDwVftsuJHMHcFfeHtSnke7OZfzv0Rz84h6GfyHdPvI2ZUDHSHO61LYsERZPboDzmz8MxTzrc2lqXZ+7KOmBO9CAmkosT+UdIcfztGYE9EYgvX3l2j9Su5JMe8jThvbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5h2yDReW7EyxwT63MMG61jNUVtG58x10Pw9npHDBwo=;
 b=HkiRpIUqRj0m64WsoAViUxlQ0WuThZXSn0X0LaO8+6w0DkqkUP4mi8TDhHEAnGVFCaxSN3koW/pRQbg7f+0KA2TYeSAfkgZz+MUJ61+56ZZ4JkJWK1xmukD+T8iDidw0N8ZCFSeTwHTrNIHjU4VxWUv7XVL542azgricCNoI/5ArJ+gtZMJffWdK326OP6YZ5r5XSysQ3jYXPnJf7vpCkAXiCeXWU/Uq7KmW9nYb7bOsMEpi1xM5rIfq1uxk77WeaTU//ks2cGNppIAHbR2lg9dbG8SNRzJUhwdBuedrJpaBWUNUL0gtH+QXGK9to87/sb5F5d1+8SK+4yqgkaPKPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5h2yDReW7EyxwT63MMG61jNUVtG58x10Pw9npHDBwo=;
 b=ldRWUg+meuLCDc+qWUeem7eEwq5U9iD9VdBs5Hszq3ScYtFXMYVSq/2VnDwPKkNWvYpSG8ePk+ycw3Ig4avTLv4wWsv6XCi+s9cjZHlCzsGruuPxNFLrUbfe5fjgy73Idbj2Ma1qOCBMMsfrh4ZNY6Le+pI8F1JjrEiyJPIpR4j0kjyG+mk1AGrtCbu0fmLmdFeWVOKcCSGIvdlFq9XZlM+uGsxkLTiQvy69ZVp00cs5vZbYFjEqHG1YsTlYYFf6KUW/HyVWRSuSEbKvZUuOyMcm2dQ8cY7zVo8EB2hz9SVStbm+ayHYjR7uYdKeeSvxiCBmTwKw5OtipyNpRXxvOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5390.namprd12.prod.outlook.com (2603:10b6:5:389::15)
 by CH1PR12MB9717.namprd12.prod.outlook.com (2603:10b6:610:2b2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 19:29:32 +0000
Received: from DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720]) by DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720%6]) with mapi id 15.21.0159.012; Tue, 23 Jun 2026
 19:29:32 +0000
Message-ID: <e352eb01-caad-4725-8b14-710c8960fa82@nvidia.com>
Date: Tue, 23 Jun 2026 12:29:29 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] vfio/pci: Add ats property
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, Alex Williamson
 <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Matt Ochs <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
References: <20260623023540.836825-1-nathanc@nvidia.com>
 <20260623023540.836825-3-nathanc@nvidia.com>
 <SJ0PR12MB8614F88365BE0F4362ECBF84ABEE2@SJ0PR12MB8614.namprd12.prod.outlook.com>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <SJ0PR12MB8614F88365BE0F4362ECBF84ABEE2@SJ0PR12MB8614.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0149.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::34) To DM4PR12MB5390.namprd12.prod.outlook.com
 (2603:10b6:5:389::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5390:EE_|CH1PR12MB9717:EE_
X-MS-Office365-Filtering-Correlation-Id: 10fdc545-fccd-4b98-a05f-08ded15dc03d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|56012099006|11063799006|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 6uVvTz0z3aeTxJ5m8/DGx0p8g6lIIpvOXGNCt58mb02p5puXcFhIQxv99Sg2n2DjBHKLTx8DalZIg48/1h/bi0pypucFO8WL7EMndMxYSETvnVG5PD7hGoi9QyxAxY5krbesQM2hkF+HCCTkwSICaJqtcORPW04oj0TRU/WetCwKdQ8i7VcdN8JUpvm6zenA8K06DIXtzhjdx6uF39iyy35QsV3R+b5f/IyZMf0eD+dp/M6D2TM//HBxeA9QZSAz/n0Ita1j43uUnU9Ceg4H1y9dYYyDd1WQaY4o1bBDaI8390H6QPtUYnI221QIpIjOAPUUR6e1I1d9prNUEYDqJD2B2itWxMh8xaYL1OnfrwEDp13mPeHL8fLyGxx+elpl3krqwx9ODPnL+3c3yMKQAaB4XPw1hwTjjD+/MtHtSdtJq0xzuSOXszHDLTXlURzaCLxyzAy7n0gcTeSZE0dNuB479jAlRYXdCxQ1JcOr6cGMiNeKrax8ihWzeLILHttwgQkmFs7RmEv2o4NKehdSQ4p7nVJqiiHNWReVX0rfvE4TVnXp7kyCW7GuZaYslqeXNPMjfea0lwgyUS+KxIwdETkJwFP3kTJ0PbgeYR97mxFYOpcIQV6gERza/1JKnBzV8Aoj37A+cvij6u4EK6rrspuoK6XmFQNhlRMaxo8gc0k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5390.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(4143699003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ni9rdnN6dXc1Zkc4VnUzclhyVzZiYUhtM0Q4UFB4bUtJK2kvRzZ0dGdyby91?=
 =?utf-8?B?ZkkxWEFkdyswYnFHeEl5a3lld1Z6YldYcVdvN3pCQmRiR240OU9NU2FoWXZO?=
 =?utf-8?B?RkZEVnJmdWtFUEJERSs2cldaRjB1azJMdlFrWGZjakRYM0Ura2UycjR3c3F2?=
 =?utf-8?B?WkpZbXhVK3E2K2wwQWErOW5LQUZQWkpCV1R3ZHh2RGxvRTVZd1BhYkx4cWRP?=
 =?utf-8?B?OXYrNHZ0MHJIc2NtWm9ocUNRdGwvaDhLRk9hTThWUGFYRVF5TG9vRGIyYnhL?=
 =?utf-8?B?bWlVa01JS1NWa29IVVZXaXF1dkJDL2NGcUJtcnNISGcxQjNQd1pscGh3VkFl?=
 =?utf-8?B?RzR1Qkh5Q2M5V0s5VVdZTE5GaHdSVUJEY2FMYlFIVnFobE9kemx6T2xUalQx?=
 =?utf-8?B?RzVQRzYrMW1QNjhzQTg4NVpkNUxUL0VlSGJ6bDlUOFdJVTNBaTFQNzloUGZQ?=
 =?utf-8?B?eGJOdFZwb0QwMUptL0o3aXVjRElpNndGaDlndzdZOVVsSE1Pby9NZ1BkTmVO?=
 =?utf-8?B?blpUQ1daeWVhVHNBTk90VkZOQ0RwMFFaYXZsUUIrZTRLaDNETU5XL1IyK0hz?=
 =?utf-8?B?aHlEMlVKVjhGdTJDVGtTM29iOXN0ZDIzOWhsZm5GYmxlTi9YMkdSeTJUdG45?=
 =?utf-8?B?NkxBUU4xR25Na2IwREo0dUIyRERMSzNnWTNraEd0bE9Vck9qYVRrQTdUVmR4?=
 =?utf-8?B?dHIyR080YVVmcE9DVUI0M0VCeExvWHdzYVZ5YkVVSmZNWGtLenNYYmxlRTRk?=
 =?utf-8?B?ZWR5Rk50eEpvN1BuT0gwUHBFakJCd2RROWcvUUFZRDBOODNoTlVCakQ2Q0Vu?=
 =?utf-8?B?bGF5aDdHQ1lqdjI2OEZTSnN4QkgvRlhCQkRnZHZFSWxHbnZQa3hYYjVvZU5C?=
 =?utf-8?B?Q1NSVjNSSkVxR1c1Q3ZoUHRKMERGRVM3alFkT2M4K0tINW1MekJGZUdZVkhP?=
 =?utf-8?B?SHdiMTFyaXJGckJjVkZUN1p3UHAyaXJWYnlPR1JyS04rSUNzS0I0SDYrNFVh?=
 =?utf-8?B?cFJhbEFnTTJJOHQwbzM0aU9MMGNyc3QvVXZHQ1RCZHVvOHhwLzFra2hNN21P?=
 =?utf-8?B?emozd1ZXdmFaVWR5RzdWMVFzcTd4ckYzc1ZnTEVES3I0VG9JcEJvWXNwZTBS?=
 =?utf-8?B?MkVtK2k2M3NsQzZIWlpERW5FT043RnI4ZHRDd1ZuU2FMbTdycm9idVpUMm54?=
 =?utf-8?B?MUc0Y0pqL3hSajAyaFB0bVp1Zytwd01NYURtSE5KRGNPYTU4L1NyZzE3OFB5?=
 =?utf-8?B?dTJSK3MzbWpkaGNoQnJRVld1WjEyUnlQKzlCVnYwWFlCdFYrQ1Bsc25JSS80?=
 =?utf-8?B?R3VVL0w5OGU5bXdIUmxld2xwMGYyNUJpbkNQNnZMZlE4VWF4b29QNHB5ME9L?=
 =?utf-8?B?bVpHT2ZRZjc4bDNBbzZNVmZSZGdTa1BQampTQU1aUjhlU25GOVlLUlp6Nnpm?=
 =?utf-8?B?d0kwYkFxRlpIQ0NtZEVEcmpPM2tBUnhLVFlzcmZJQTBRUjNXNXlycGI0QVJP?=
 =?utf-8?B?VHZrUkRLM1BqZFVkSEJITGNvZ2c1c2hDd3V5dVNTbGcxOUxIRy8zRjVzTndx?=
 =?utf-8?B?cE5nTXlHMmJnZFp3eGthdUcvSnBSZytKd3pxWlpnTGFGbkNqUWxPOWJqOU1M?=
 =?utf-8?B?TGRNZEVJQUs1SEduQjdnanlQYjNEa2h5eEEwaVJNeFZvcTQwMGFLV21IUWRC?=
 =?utf-8?B?RVppbFBSOGkyTkszbzdWK2pUVFVTbHJOZTVRYUtiUUlLSFN1L0RIL2J0TVd4?=
 =?utf-8?B?V2dTTWRTNnFOUklMUE1rMDBGbHVBdUJUNGxZanVFUG5uQ045R1N5MVA4R2NZ?=
 =?utf-8?B?cTBnRGlMZ25URFhVRmozRkdGU3NFRGdKZWQ2M0xTZC9DOUc1MXdVREpZSVhO?=
 =?utf-8?B?bFFHZkpFc3U4Si9ZSDF2MzZIbzZCVERya29FUXlQMTZiQUZiTUl3eHJGTlBz?=
 =?utf-8?B?cStpVkY5K1crKzRnVElwVzZjaDd6STZ5aG5PR200ZUtZN0V4eUhEK0VhUExT?=
 =?utf-8?B?TVRBTzdkd2UvQWlrRUVuUDQwNElmVXl0WlY4TlRDLzdwbnBBelc4Qkw2MVUy?=
 =?utf-8?B?UWpldGtkc3ZBcm1tbjRXK3NtcGltbmpjR0p4c0pTNU1oRHlySWFwdkJJOVkr?=
 =?utf-8?B?NnNXdDdGeEFwZXY1YjAwUjJ1ZzA2bUdEMGlxZGtLSTZZeWZFSHBQNk1jUW1F?=
 =?utf-8?B?UE8waHNBZXdpVzhtYUVNSnNDK1ppa1J4dmpHYmltS2oyK3VScmw1eU53aU9M?=
 =?utf-8?B?YjJVUmNDeVJnbU16dmNCK0VXOGRLMXZWaUZDNTgydjRNZXJVYUxrTXMwR2t4?=
 =?utf-8?B?dkxISjBCSWszMStUNzl0VkVsNVl3UGFzRDlkbGN4T2F2ZXJldUdudz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10fdc545-fccd-4b98-a05f-08ded15dc03d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 19:29:32.2476 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EfNDBnNA3/03ZNG30eUqVXbpzWlRChsNG5xjVtIGpQ+CWaj0vvR6pKjlm5Df4BDev8Jwji2zfYIf7ndKJfJZgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9717
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=nathanc@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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



On 6/23/2026 10:01 AM, Shameer Kolothum Thodi wrote:
> 
>> -----Original Message-----
>> From: Nathan Chen<nathanc@nvidia.com>
>> Sent: 23 June 2026 03:36
>> To:qemu-devel@nongnu.org
>> Cc: Yi Liu<yi.l.liu@intel.com>; Eric Auger<eric.auger@redhat.com>;
>> Zhenzhong Duan<zhenzhong.duan@intel.com>; Alex Williamson
>> <alex@shazbot.org>; Cédric Le Goater<clg@redhat.com>; Matt Ochs
>> <mochs@nvidia.com>; Nicolin Chen<nicolinc@nvidia.com>; Shameer
>> Kolothum Thodi<skolothumtho@nvidia.com>; Nathan Chen
>> <nathanc@nvidia.com>
>> Subject: [PATCH v3 2/2] vfio/pci: Add ats property
>>
>> From: Nathan Chen<nathanc@nvidia.com>
>>
>> Add an "ats" OnOffAuto property to vfio-pci. When the device has an ATS
>> extended capability in config space but we should not expose it (ats=off,
>> or ats=auto and kernel reports
>> IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED), mask
>> the capability so the guest does not see it.
>>
>> If ATS is explicitly requested but not supported by the kernel, fail
>> device realize.
>>
>> This aligns with the kernel's per-device effective ATS reporting and allows
>> vfio-pci to mask ATS when the host kernel reports ATS as unsupported.
>>
>> Emit a warning when ats=on is requested but the physical device does not
>> advertise ATS, since ATS cannot be exposed to the guest in this case.
>>
>> Suggested-by: Shameer Kolothum<skolothumtho@nvidia.com>
>> Signed-off-by: Nathan Chen<nathanc@nvidia.com>
>> ---
>>   hw/vfio/pci.h |  1 +
>>   hw/vfio/pci.c | 88
>> ++++++++++++++++++++++++++++++++++++++++++++++++---
>>   2 files changed, 85 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
>> index c3a1f53d35..f2934f2d84 100644
>> --- a/hw/vfio/pci.h
>> +++ b/hw/vfio/pci.h
>> @@ -188,6 +188,7 @@ struct VFIOPCIDevice {
>>       bool clear_parent_atomics_on_exit;
>>       bool skip_vsc_check;
>>       uint16_t vpasid_cap_offset;
>> +    OnOffAuto ats;
>>       VFIODisplay *dpy;
>>       Notifier irqchip_change_notifier;
>>       VFIOPCICPR cpr;
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index 9c06b25e63..c0436b4c04 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -2546,10 +2546,58 @@ static bool
>> vfio_pci_synthesize_pasid_cap(VFIOPCIDevice *vdev, Error **errp)
>>       return true;
>>   }
>>
>> -static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
>> +/*
>> + * Determine whether ATS capability should be advertised for @vdev, based
>> on
>> + * whether it was enabled on the command line and whether it is supported
>> + * according to the kernel.
>> + *
>> + * Store whether ATS capability should be advertised in @ats_needed.
>> + *
>> + * Returns false only when ats=on is explicitly requested but the kernel
>> + * reports it is not supported. Returns true in all other cases.
>> + */
>> +static bool vfio_pci_ats_requested_and_supported(VFIOPCIDevice *vdev,
>> +                                                 bool *ats_needed, Error **errp)
>> +{
>> +    HostIOMMUDevice *hiod = vdev->vbasedev.hiod;
>> +    HostIOMMUDeviceClass *hiodc;
>> +    bool ats_supported;
>> +    *ats_needed = false;
>> +
>> +    if (vdev->ats == ON_OFF_AUTO_OFF) {
>> +        return true;
>> +    }
>> +
>> +    *ats_needed = true;
>> +    if (!hiod) {
>> +        return true;
>> +    }
>> +    hiodc = HOST_IOMMU_DEVICE_GET_CLASS(hiod);
>> +    if (!hiodc || !hiodc->support_ats) {
>> +        return true;
>> +    }
>> +
>> +    ats_supported = hiodc->support_ats(hiod);
>> +    if (vdev->ats == ON_OFF_AUTO_ON && !ats_supported) {
>> +        error_setg(errp, "vfio-pci: ATS requested but not supported by kernel");
>> +        *ats_needed = false;
>> +        return false;
>> +    }
>> +
>> +    if (vdev->ats == ON_OFF_AUTO_AUTO && !ats_supported) {
>> +        warn_report("vfio-pci: host kernel reports ATS unsupported; "
>> +                    "ATS capability will be masked");
>> +    }
> This will be slightly misleading if dev doesn't have the ATS CAP at all.
> Isn't it?  I think, the best place to do this warning is below where we know
> ats_cap_present is set or not.
> 
> Thanks,
> Shameer
> 
Yes, I agree it would be better to put this in an else statement after 
it is verified that ats cap is present.

Thanks,
Nathan>> +
>> +    *ats_needed = ats_supported;
>> +    return true;
>> +}
>> +
>> +static void vfio_add_ext_cap(VFIOPCIDevice *vdev, bool ats_needed)
>>   {
>>       PCIDevice *pdev = PCI_DEVICE(vdev);
>>       bool pasid_cap_added = false;
>> +    bool ats_cap_present = false;
>>       Error *err = NULL;
>>       uint32_t header;
>>       uint16_t cap_id, next, size;
>> @@ -2635,7 +2683,19 @@ static void vfio_add_ext_cap(VFIOPCIDevice
>> *vdev)
>>            */
>>           case PCI_EXT_CAP_ID_PASID:
>>               pasid_cap_added = true;
>> -            /* fallthrough */
>> +            pcie_add_capability(pdev, cap_id, cap_ver, next, size);
>> +            break;
>> +        case PCI_EXT_CAP_ID_ATS:
>> +            ats_cap_present = true;
>> +            /*
>> +             * If ATS is requested and supported according to the kernel, add
>> +             * the ATS capability. If not supported according to the kernel or
>> +             * disabled on the qemu command line, omit the ATS cap.
>> +             */
>> +            if (ats_needed) {
>> +                pcie_add_capability(pdev, cap_id, cap_ver, next, size);
>> +            }
>> +            break;
>>           default:
>>               pcie_add_capability(pdev, cap_id, cap_ver, next, size);
>>           }
>> @@ -2646,6 +2706,11 @@ static void vfio_add_ext_cap(VFIOPCIDevice
>> *vdev)
>>           error_report_err(err);
>>       }
>>
>> +    if (ats_needed && !ats_cap_present) {
>> +        warn_report("vfio-pci: ats=on requested, but host device has no "
>> +                    "ATS extended capability");
>> +    }
>> +
>>       /* Cleanup chain head ID if necessary */
>>       if (pci_get_word(pdev->config + PCI_CONFIG_SPACE_SIZE) == 0xFFFF) {
>>           pci_set_word(pdev->config + PCI_CONFIG_SPACE_SIZE, 0);
>> @@ -2657,6 +2722,7 @@ static void vfio_add_ext_cap(VFIOPCIDevice
>> *vdev)
>>   bool vfio_pci_add_capabilities(VFIOPCIDevice *vdev, Error **errp)
>>   {
>>       PCIDevice *pdev = PCI_DEVICE(vdev);
>> +    bool ats_needed = false;
>>
>>       if (!(pdev->config[PCI_STATUS] & PCI_STATUS_CAP_LIST) ||
>>           !pdev->config[PCI_CAPABILITY_LIST]) {
>> @@ -2667,7 +2733,11 @@ bool vfio_pci_add_capabilities(VFIOPCIDevice
>> *vdev, Error **errp)
>>           return false;
>>       }
>>
>> -    vfio_add_ext_cap(vdev);
>> +    if (!vfio_pci_ats_requested_and_supported(vdev, &ats_needed, errp)) {
>> +        return false;
>> +    }
>> +
>> +    vfio_add_ext_cap(vdev, ats_needed);
>>       return true;
>>   }
>>
>> @@ -3815,6 +3885,7 @@ static const Property vfio_pci_properties[] = {
>>       DEFINE_PROP_BOOL("skip-vsc-check", VFIOPCIDevice, skip_vsc_check,
>> true),
>>       DEFINE_PROP_UINT16("x-vpasid-cap-offset", VFIOPCIDevice,
>>                          vpasid_cap_offset, 0),
>> +    DEFINE_PROP_ON_OFF_AUTO("ats", VFIOPCIDevice, ats,
>> ON_OFF_AUTO_AUTO),
>>   };
>>
>>   static void vfio_pci_set_fd(Object *obj, const char *str, Error **errp)
>> @@ -3966,13 +4037,22 @@ static void vfio_pci_class_init(ObjectClass *klass,
>> const void *data)
>>                                             "destination when doing live "
>>                                             "migration of device state via "
>>                                             "multifd channels");
>> -   object_class_property_set_description(klass, /* 11.0 */
>> +    object_class_property_set_description(klass, /* 11.0 */
>>                                             "x-vpasid-cap-offset",
>>                                             "PCIe extended configuration space offset at which to
>> place a "
>>                                             "synthetic PASID extended capability when PASID is
>> enabled via "
>>                                             "a vIOMMU. A value of 0 (default) places the capability
>> at the "
>>                                             "end of the extended configuration space. The offset
>> must be "
>>                                             "4-byte aligned and within the PCIe extended
>> configuration space");
>> +    object_class_property_set_description(klass, /* 11.1 */
>> +                                          "ats",
>> +                                          "Control guest visibility of the ATS PCIe extended
>> capability. "
>> +                                          "Valid values are on, off, and auto (default). "
>> +                                          "'off' always masks ATS. "
>> +                                          "'on' requires ATS support for the device and fails realize
>> if the "
>> +                                          "host kernel reports ATS as unavailable for this device. "
>> +                                          "'auto' masks ATS only when the host kernel reports "
>> +                                          "ATS as unavailable");
>>   }
>>
>>   static const TypeInfo vfio_pci_info = {
>> --
>> 2.43.0


