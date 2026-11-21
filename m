Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E494F606A6A9
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Nov 2026 00:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=DKtnf0F6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUZJd-00020O-Mz; Fri, 20 Nov 2026 19:50:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1xUZJZ-000202-TY; Fri, 20 Nov 2026 19:50:49 -0500
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1xUZJX-0006Vv-Ew; Fri, 20 Nov 2026 19:50:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jj/5Hjq0RyZNKsLWr2C4ZF1mGnQ9SO8z/DH5f3FTILKkio2lJNTsDqJjHMD3fSI4LJjZr0pIaZw4sLMggXADPIxKLwotOiiIC4j3ud9MDAStPBlUOZ/dubZ4SyB8x19nW0/G48tleQuJZ0S7itGW+g97b+MITlF9xON5lmkKKjAssRuN+8rIFO250+7C2153zTTaVDrez0dZWmmZOezohap5HwuF+g/hk6DMTwp74R03Pj/Ufs76JPDy0ziYwVc4z2VJDMKivNP9tERniJYUGV7mIQezBI5bOfDCVB57etulA2hXxmCqYAA5badNLFrikiRthqgJXW0aa6kdeVLsjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+cVfHtu/hp7OKlFXQUpN33Nhlf5DjsbLbUEnHmFyy0g=;
 b=UG2osoXWwyEdLH2KNWxtIQXmgfGR+SW37Z2n39waCjzE+n1+6HMeigWVR7BehjmeafUdKePXXMC7zTUSDqceIRYeX4C+h/IiilNZRYeJn1tP2BYjYmvHf996kVWfTiPvPWSz4xD0ah2bio8n2kh8eMz4sFVQCK6jXDrTdhH/DDstBeIDnmECcZQGKo/L3nI4biOa3RxrU/7vb0V5Ae132aDolbGamDvuLViGNBsbUeyv7XOshMWUq6Is+aObgAuqVPoZyjTAiy8GsL7/DKvyhZnuCNRDiHb+nKBvrHz3uOy7EJqCxMaPXWbRmGMzx3msn0vAFxCT+tKarlNieCDs8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+cVfHtu/hp7OKlFXQUpN33Nhlf5DjsbLbUEnHmFyy0g=;
 b=DKtnf0F6aWv0/StAyNOeDuh8XQUJwAJ4kRZPk8W72pbtdBA8nqgl7Q/qX14xVXri1YYaMkWVdhB6r3jjbQImucZwGkKcR2h6a87Vj/i79eav4zFdW0Y6jnV5Wm+Evt/8HHr6drE6dbZZygOrhtEtsTLUYj33PF74GMT/Tb1pjrlGgyuJCiDzqnvAVb6N9PFvMbsImlhLQDYn7shWO4MoGzfD7sOvFPNhC3Ra5fOOZWFA5dKYAKf+HAGw/U97cA/0N7FKzArLCWIE0w8Sb16XJPpoI/Fc/GjzRo2WCZVz52PDtdDZiGU4h5DKumMIs0+jMf2PWP1jjpw1Al3ThE8lhQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17) by MW4PR12MB7466.namprd12.prod.outlook.com
 (2603:10b6:303:212::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Sat, 21 Nov
 2026 00:50:38 +0000
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1]) by IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1%5]) with mapi id 15.21.0639.011; Sat, 21 Nov 2026
 00:50:36 +0000
Message-ID: <84e57371-8446-434e-98a7-5ec87c9e30e8@nvidia.com>
Date: Fri, 20 Nov 2026 18:50:33 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] hw/pci, hw/arm/virt: fixed PCI BAR placement
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 marcel@redhat.com, devel@edk2.groups.io, alwilliamson@nvidia.com,
 jgg@nvidia.com, skolothumtho@nvidia.com, ardb@kernel.org, kraxel@redhat.com
References: <20261102181241.3077981-1-tdave@nvidia.com>
 <20261104071853-mutt-send-email-mst@kernel.org>
From: Tushar Dave <tdave@nvidia.com>
Content-Language: en-US
In-Reply-To: <20261104071853-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0015.namprd21.prod.outlook.com
 (2603:10b6:a03:114::25) To IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR12MB923065:EE_|MW4PR12MB7466:EE_
X-MS-Office365-Filtering-Correlation-Id: 1490784b-7a48-4215-a2e5-08df47697445
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|10067099003|4143699003|11063799006|5023799004|260925022911599003|260925021911599003|260925021311599003|56012099006|261022075727099003|261022105027099003|261021135927099003|261021123027099003|261021121427099003|261009223027099003|261102130727099003|261102123227099003|261026121527099003|261026140227099003|261028144727099003|18002099003|22082099003|6133799003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info: klRh4vHkPqXejxxy4rtokrWM3YT1tWwda+2wQQ9KGJ88ppuAPQlNKxnbPI3LYjPvecXTMFRgcyPKwhk9NoS3lFJWv/H5ZP4GyHKmEw222z34t4MCM3Xd4wkJYMBNdAI9lgPuiofnDPjGfkwqkZChKXbbLiQOyt9UArYT2SrpopbJ/55+8igLsflX+M4JibYEbsm6rgHrdNqAVdcHxIsh4WV5scRS3uqh/M3WTR5dm9pM0EkzM/P5JkjVzCK4urIMrPE8IUaOHWisjWzz2VqwJI94XBFzt5H6WKbCe0ShN08AD9sgj0ghQUbqWpcIjbtTBNsKFCzi/1KavVLI2F6xvA8ThgZz0dTfLlvbvIpzVqIfH/eCWJmfxdb+B6dg1umX4xw7rrc7Do7qHBP7w+tjtXdY/A1eHfIvF5WMLWxQsIPPQ+l8pFYUc+8RPHPOEjFuv1cZHGcpn+PCoIj4x2DxPu8JLOHNPGwezFrilZCTMGJHLr1cSsv4GaeY7FthupKKKVfEzA2oR46HoLTToyF5T6QBd0ud1AE9Dte3PclUKIjpguVieOIMGC81l5qW1C5vqTtcOyeGXXSitu3miDQ4ketvcMigUQ58Xb1iSGV6djGD1XMOFbSkLOtjDZeENjY1uPICMMUeTsOC7Al/OCna08652jjAdHh/1AihVu0XrjY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR12MB923065.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(4143699003)(11063799006)(5023799004)(260925022911599003)(260925021911599003)(260925021311599003)(56012099006)(261022075727099003)(261022105027099003)(261021135927099003)(261021123027099003)(261021121427099003)(261009223027099003)(261102130727099003)(261102123227099003)(261026121527099003)(261026140227099003)(261028144727099003)(18002099003)(22082099003)(6133799003)(13003099007)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjcxZGZHbHJMZ2pXa0o0d0FDeDM1azVwSUtMNm9HZVZOanhZN2NuRzBUZjM2?=
 =?utf-8?B?cjN5NEtNLzJDY1JqR3FLdjVSV2tDV0pGamJNV1hlSTlCZndOS0ZSUml2bGk4?=
 =?utf-8?B?MlFYaFU3UVpTWmM4bTU0bS96aE4yakZtNnhKenFxLzQvTTFoZi93WHU2QWd6?=
 =?utf-8?B?UHlVdUhmbVV1V3FMakFkcWJhRjFEdTZOZnNYeHBpOEt1TktpV1dsejE2NllV?=
 =?utf-8?B?OGNFUW1wTTUrRldGWHoyVVAzSTFzZWtWdFdFaG1jNGU4VzBNQzFYYWMzbFJw?=
 =?utf-8?B?NmZMRDNNTWt3NFUzcXNEYy8vQTcrdE1jMkZMY3RlcStIaVJOU1VnZUJjNTgy?=
 =?utf-8?B?bGpEU2hCQnZmRG9vOGY2VURyVDRLeFhLZTd0TVF4bXI3V3Nta1BpaCs2WXFW?=
 =?utf-8?B?aWcxUVZGelBaVFNxVldRdnYzRDFtVTdFaDhwT3dzdm1YQVpFQytOVFlvZ05B?=
 =?utf-8?B?MHRCVDd1S1kwK3lqN0VuVTJUMm1tbGhDVGgzV0Q4RDFTUWJSZlpXRXk1Unlx?=
 =?utf-8?B?NW45aDNsaHBoZEJ1cVpPdDdvMzVmSElKM1BDbkU1eFJWdEhjWisrYkNLb0p4?=
 =?utf-8?B?bzlWS2ZUWmdHaW5aSDZBbWZha0dRVkJDOTB2dWF0dGk3djllVjNabUlmSEFB?=
 =?utf-8?B?SVYyd0RnVmpjUHR6NzZ2anVxMGF4S0w5ZFdYaHFPZXArM2s1alNZRTFtNUg2?=
 =?utf-8?B?eE1kZmZYUU80WXdlUGpwdnNiT1pkbEF4RUFvTVg2Z1NIWkpNRldzRTRuamlT?=
 =?utf-8?B?TFZPdGtoeWdOa25lVkxrS0JkWHNKN1lzaWVtbEVFU0loTXBsdW5vVk5YWFhw?=
 =?utf-8?B?eEJJRmJlS3JvZjRYSThpb2M3aExtbGxpWTBROVFGT3FoV2llNDd1WkdMTFk2?=
 =?utf-8?B?L3JGSnJtOU94UmpRMVFCOSt3MTFLbCs3QWdNRlpjaFlqSFdsUXJ3dUNzMmhr?=
 =?utf-8?B?UFRRVjBZTi8zZ2FNR2wyWSs0eHptcVFaS1JJUW9GajhBVnA2WXdmNHY5Mm53?=
 =?utf-8?B?K1dkTHZLV1c1S05qMHBhVlVpRjNRUkxwR2VLR0JUWG04Y0YxNVBCbG44c09o?=
 =?utf-8?B?WlZuV0ltSmFRek40b0hqdTlUbStTZ1lqWkl1U0Y2a3hycFkrSXk1WWhEU0F5?=
 =?utf-8?B?SFU0WEdNVXh5SFpBa3ZadEVPZTRwVHhxSWpObnQ1WmZuMkNSTDRQL3A3bk4v?=
 =?utf-8?B?Zm1MWGRpQUJLSXFJSHlLcys4OXAwb1UvTXlOMWhPbWtZNkE3c1FxbWJqdjYw?=
 =?utf-8?B?UFZCSXpzSTlQblBnUGVoS1VMcmtJRWlMS1NnRDJVSEpSa1BBTzdWUHVzTjhZ?=
 =?utf-8?B?VXNwU0NpdTlMTkhYa1IrQzhjSDZTYkNwSXU0V0U3QTFvZ3Y3Q1NtYy94SWsy?=
 =?utf-8?B?SFNLRmloTnppOVJpNE93cDl3Ums2ZnpSblN4U1FSTE5IbmUyd1VSTzdsazdv?=
 =?utf-8?B?SGxHSkpibUloSzd6b2FPQk4wekdpWnhkeGJRK1lKTi9ibGpob0xoZW53ZWYx?=
 =?utf-8?B?Uk5BUlAyc3N6ZFNlZ1VTbFZBSXJ2ekpwVHNhSjk1a0dMSVZhTmtkSlhEZllH?=
 =?utf-8?B?TGxWaUk4bHQvN0VXc0g1MFFOWnZ4eGd4R2pNWjF3aVdzZVIramRUV3RzSDZs?=
 =?utf-8?B?M1Z1TzAzYjN3Qm1GUHpVMzFsanBKcCtQb1lxSlpsUlNQU2ZKYW9KazIzaTA2?=
 =?utf-8?B?dVlxak1CZ1QxdXRES1JkZTNya1h2MmZWN1FURXZpeURHRmZTdnhoTDZRQ1hU?=
 =?utf-8?B?VnRrQlZqTFMzU0NndVo1WXY5Q2wxVy96Ym5QMlVEdzNlTWI0UFd5VFhtOUtH?=
 =?utf-8?B?ZS8vTEVSSkZyeDluakR0Vi9xS2NnejJZUENtT3doeUY5dzRZK04xNGpLaFlj?=
 =?utf-8?B?MUJhZ0l4WFErTkRGOGdyRW95elFTL0loRStsT3lpcnVJTUhjQkNhaVd0VExP?=
 =?utf-8?B?a0ZHM254SUdqNzE2cjhiMkRYdE5VRFlveWZBNjNyVWtFV2E0eWQ1SFlBMHhU?=
 =?utf-8?B?eG1jV21FRm81QmY0N1FpV3J1c0V5NFNhQmZXU0RCZ0FIU3VhcmRHcGV3RHNC?=
 =?utf-8?B?U1ZJZzUwYnQ2cjNMUlJ6Q1o3QzQyWG9Qem5WZUZ5VHFEL1ZJV3ZvSXNIdlVh?=
 =?utf-8?B?YjE1OGIwWmc2VmNKOHA1QjZjS3JBMDhaOEQ4anA3aGJpOG5ma0w5bHFVWEhE?=
 =?utf-8?B?YTZmUm1RWkd6QTdOeHFzcDBzUEF3M2ovRjg0Z21yNUE0U25UQ01IQXJYaHRk?=
 =?utf-8?B?VG5jeXQrYUtKelVoZ2grSlBNM0ZTdjBPeU54OVh3Qk4vOGhiQU5ZYWJJY3pq?=
 =?utf-8?Q?J5NzB79sVtVJgfxcnk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1490784b-7a48-4215-a2e5-08df47697445
X-MS-Exchange-CrossTenant-AuthSource: IA3PR12MB923065.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2026 00:50:35.9560 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HUz5dThhiPqbiB76uGwTsB1nld4W0JIf6781WEwDuVvvwcv17qmIcJN3m60bFXI6PzOwzNWPxZzHUqlWkQjTBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7466
Received-SPF: pass client-ip=2a01:111:f403:c105::7;
 envelope-from=tdave@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/4/2026 7:11 AM, Michael S. Tsirkin wrote:
> On Mon, Nov 02, 2026 at 12:12:36PM -0600, Tushar Dave wrote:
>> This patch series introduces a mechanism to specify Guest Physical Addresses
>> (GPAs) for PCI BARs, allowing explicit placement of guest MMIO BAR addresses
>> to match host physical addresses for assigned devices.
> 
> 
> My understanding is that all this does it pass a property to
> the firmware asking it to set the bar to a given value?
> 
> There are two standard ways to do this:
> - EA capability in pci config space

EA came up earlier in the discussions as well, but we set it aside
because we thought it might need guest kernel changes, and besides, EDK2
had no EA support at the time.

I revisited EA now that EDK2 supports it (Ard's PR, merged
https://github.com/tianocore/edk2/pull/13186). With that in place, a
Linux guest reports the BARs as "from Enhanced Allocation" without any
kernel changes. (I have not tested older distro kernels though.)

The main change is in patch 3; no need for fw_cfg blob, each fixed BAR
instead described by an EA capability in the device's PCI configuration
space.

One limitation inherent to EA is that it is a conventional capability
and must fit within the first 256 bytes of PCI configuration space. It
requires 4 bytes for the capability header, plus 20 bytes for each
64-bit BAR and 12 bytes for each 32-bit BAR. A device that does not have
sufficient space, or already has an EA capability, we cannot use EA for
that device.

For a vfio-pci device, the EA capability is added after building the
host device's capability chain, since it must fit within the available
configuration space. vfio-pci gives a host capability whose size it does
not know all the space up to the next one, so a last capability of that
kind holds the rest of the standard configuration space. If the last
capability is vendor-specific, its real length is known, so the unused
tail can be reclaimed for the EA capability. If no free space is left,
the device is rejected with an error.

No EDK2 changes are needed for this approach, so I can drop my EDK2 PR
that extended the IncompatiblePciDeviceSupport protocol:
https://github.com/tianocore/edk2/pull/13183.

I will send QEMU fixed BAR v3 that uses EA.


> - fixed BAR _DSM in ACPI

I am also not sure which fixed BAR _DSM in ACPI you meant. If you meant
_DSM function 5, which tells the OS to preserve the PCI configuration,
my series already uses it.

-Tushar


> 
> 
> If none of these are appropriate, pls document why.
> 
> 
> 
>> On some platforms, P2P DMA between devices in the same IOMMU group is required
>> for the desired data path and performance. The PCI fabric ACS is configured
>> to permit direct P2P without routing traffic through the host bridge.
>>
>> To support this multi-device IOMMU group P2P scenario in virtualization, the
>> VM may need to preserve the host PCI BAR addresses in the guest.
>>
>> A new fixed-bar-N property on a PCI endpoint device specifies the required
>> guest address for BAR N (N = 0 through 5):
>>
>>     -device some-device,fixed-bar-0=<addr>[,fixed-bar-1=<addr>]...
>>
>> Once any fixed-bar-N property is set on a device, every memory BAR on that
>> device must have a fixed address. Under a PCIe root port, fixed BAR placement
>> is all-or-nothing within that root port's subtree. If one endpoint below the
>> root port has a fixed BAR, every other endpoint with a memory BAR below that
>> same root port must also have all of its memory BARs fixed.
>>
>> QEMU validates the configuration when the machine is done initializing. Each
>> address must be aligned to its BAR size, fall within the appropriate PCIe MMIO
>> aperture, and not overlap any other fixed BAR. QEMU aborts on any validation
>> failure. QEMU performs neither PCI enumeration nor BAR allocation; the
>> validated configuration is exported to firmware through the "etc/fixed-bars"
>> fw_cfg blob, which carries each PCI function's vendor/device identification,
>> firmware device path, and, for fixed devices, the configured address, size,
>> and type of each BAR. The blob format is documented in
>> docs/specs/pci-fixed-bars.rst.
>>
>> The fixed-bar-N property and its validation are generic and apply to any PCI
>> device. A machine type opts in by setting the new pci_fixed_bar_supported
>> MachineClass flag. Machine types that leave it unset reject fixed-bar-N. This
>> series enables it on the virt machine only, by setting the flag and wiring up
>> the fw_cfg export. Other machine types would need equivalent wiring to expose
>> the same mechanism to firmware.
>>
>> On the firmware side, the existing IncompatiblePciDeviceSupportDxe driver is
>> extended to consume this blob. During device discovery, its CheckDevice()
>> implementation returns ACPI address descriptors with _MIF|_MAF set for the
>> fixed BARs found in the blob. PciBusDxe's resource allocator already supports
>> fixed BARs, including sizing and pinning the bridge windows above them. It now
>> treats a BAR as fixed when the descriptor carries _MIF|_MAF, and programs the
>> fixed address into the BAR register.
>>
>> Fixed BAR placement requires the guest to preserve the PCI resource
>> configuration established by firmware. This is requested through the PCI boot
>> configuration preservation mechanism using ACPI _DSM function 5. Fixed BAR
>> configuration is rejected when firmware is not loaded or ACPI is disabled.
>>
>> Example 1: VFIO passthrough device with fixed BARs and the PCIe MMIO
>> aperture adjusted to accommodate the fixed addresses.
>>
>>     -machine virt,...,highmem-mmio-base=4T,highmem-mmio-size=4T
>>     -device pcie-root-port,id=pcie.port1,bus=pcie.1,chassis=1,io-reserve=0
>>     -device x3130-upstream,id=upstream1,bus=pcie.port1
>>     -device xio3130-downstream,id=downstream1_1,bus=upstream1,chassis=1,slot=2
>>     -device vfio-pci-nohotplug,host=0018:06:00.0,bus=downstream1_1,id=dev0,\
>>             fixed-bar-0=0x48000000000,fixed-bar-2=0x50000000000,fixed-bar-4=0x58000000000
>>
>> Example 2: VFIO and emulated devices under the same root port with fixed BARs
>> and the PCIe MMIO aperture adjusted using highmem-mmio-base.
>>
>>     -machine virt,...,highmem-mmio-base=64T,highmem-mmio-size=64T
>>     -device pxb-pcie,id=pcie.1,bus_nr=1,bus=pcie.0
>>     -device pcie-root-port,id=pcie.port1,bus=pcie.1,chassis=1,io-reserve=0
>>     -device x3130-upstream,id=upstream1,bus=pcie.port1
>>     -device xio3130-downstream,id=downstream1_1,bus=upstream1,chassis=1,slot=1
>>     -device vfio-pci-nohotplug,host=0018:06:00.0,bus=downstream1_1,rombar=0,id=dev0,iommufd=iommufd0,\
>>             fixed-bar-0=0x6b4000000000,fixed-bar-2=0x6b8000000000,fixed-bar-4=0x6c0000000000
>>     -device xio3130-downstream,id=downstream1_2,bus=upstream1,chassis=1,slot=2
>>     -device vfio-pci,host=0012:03:00.1,bus=downstream1_2,id=nic1,iommufd=iommufd0,fixed-bar-0=0x6c8000000000
>>     -device xio3130-downstream,id=downstream1_3,bus=upstream1,chassis=1,slot=3
>>     -device e1000,netdev=net0,bus=downstream1_3,id=nic_emu,fixed-bar-0=0x20000000
>>
>> Limitations:
>>
>> * I/O BARs and the expansion ROM BAR are not covered by fixed-bar-N.
>> * SR-IOV VF BARs are not covered.
>>
>> Testing:
>>
>> The series was tested on the AArch64 virt machine with a range of PCIe
>> configurations, including emulated and VFIO passthrough devices, PCIe
>> switches, single and multiple fixed-BAR endpoints behind a shared root port,
>> devices attached directly to the host bridge, and endpoints behind nested
>> bridges. All rejection paths were also exercised, with the corresponding
>> error messages verified. These included unsupported machine types,
>> hot-plugged devices, non-existent BARs, I/O BARs, unaligned, overlapping, or
>> out-of-aperture BARs, incomplete BAR configurations, highmem-mmio=off,
>> missing firmware, and highmem-mmio-base values that cause address-space
>> overflow.
>>
>> Changes since v1:
>>
>> * Add a pci_fixed_bar_supported MachineClass flag; fixed-bar-N is rejected
>>   on machine types that do not set it. virt sets it.
>> * Keep the fixed BAR claims in FixedBarsInfo instead of a static array, and
>>   report validation failures through Error ** to the machine code instead of
>>   calling exit(1).
>> * Allow a 64-bit non-prefetchable BAR in either aperture when the device is
>>   attached to the host bridge; behind a PCI bridge it must lie below 4 GiB.
>>   A 64-bit prefetchable BAR must still lie in the 64-bit aperture.
>> * Treat the high PCIe MMIO aperture as absent with highmem-mmio=off, and
>>   reject fixed BAR configuration unless firmware is loaded and ACPI is
>>   enabled.
>> * Check highmem-mmio-base + highmem-mmio-size against the PA space without
>>   overflow, and document highmem-mmio-base in docs/system/arm/virt.rst.
>> * Document the etc/fixed-bars format in docs/specs/pci-fixed-bars.rst, and
>>   note that the firmware device path is carried for future matching.
>> * Move pci-fixed-bar.h to include/hw/pci/.
>>
>> v1:
>> https://lore.kernel.org/qemu-arm/20260916185554.917526-1-tdave@nvidia.com/
>>
>> A git branch with this series applied is available at:
>> https://github.com/tdavenvidia/upstream-qemu/tree/Upstream-fixed-bar-Oct-29-V2
>>
>> The related EDK2 change is available at:
>> https://github.com/tianocore/edk2/pull/13183
>>
>> Tushar Dave (5):
>>   hw/pci: introduce PCI fixed BAR properties
>>   hw/pci: add validation for fixed BAR configuration
>>   hw/pci: add fixed BAR fw_cfg blob export
>>   hw/arm/virt: export fixed BAR metadata via fw_cfg
>>   hw/arm/virt: add highmem-mmio-base property
>>
>>  docs/specs/index.rst            |   1 +
>>  docs/specs/pci-fixed-bars.rst   |  75 +++++++
>>  docs/system/arm/virt.rst        |   4 +
>>  hw/arm/virt.c                   |  82 ++++++-
>>  hw/pci/meson.build              |   2 +
>>  hw/pci/pci-fixed-bar-blob.c     | 308 +++++++++++++++++++++++++++
>>  hw/pci/pci-fixed-bar-validate.c | 365 ++++++++++++++++++++++++++++++++
>>  hw/pci/pci-fixed-bar-validate.h |  22 ++
>>  hw/pci/pci.c                    |  71 +++++++
>>  include/hw/core/boards.h        |   3 +
>>  include/hw/pci/pci-fixed-bar.h  |  63 ++++++
>>  include/hw/pci/pci_device.h     |   7 +
>>  12 files changed, 1002 insertions(+), 1 deletion(-)
>>  create mode 100644 docs/specs/pci-fixed-bars.rst
>>  create mode 100644 hw/pci/pci-fixed-bar-blob.c
>>  create mode 100644 hw/pci/pci-fixed-bar-validate.c
>>  create mode 100644 hw/pci/pci-fixed-bar-validate.h
>>  create mode 100644 include/hw/pci/pci-fixed-bar.h
>>
>> -- 
>> 2.34.1
> 


