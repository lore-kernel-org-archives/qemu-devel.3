Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2602CDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 19:36:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc6uh-0002BF-HV; Tue, 23 Jun 2026 15:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wc6uf-0002B5-VM
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 15:36:01 -0400
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wc6ud-0007Q8-Qj
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 15:36:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I6ExqAfnKuibTJ7IqFHsqHGuRiXi8i+CG/3f3L0biAWTvhKwZaA+2rMqt7/Ugj/zgDO446fOhK0F2p0L2lCcdOBmpH2PbRvopwfm3RlCanLOQ1BNV209AenUJ2SAq+2bS+t5FOqJBpfb5FRfhMEWyC1VNhBbLGR5irRkBIY0zN/Nm2+2pw/vhOLu2/l2rBYNuHlLGg6R9Ow2xeeRXk7g5COLZqHm0pRIBA8pgdS6rmxQa7OTOiZmMrGe3GmfL/HeB67qrJhj9xBAcB+K7qat88rGBBmUBbmzMcxQj93OZi6g1dvRwIc5yWQ1eHNHZiXoYn+sJa8jQxNbIQg0Vr0CRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=45h4k/9aWKhDVpCS/pTlXiHfTziDj/lIxA5Q8+FCaBg=;
 b=o1R8sxfE464ht1gbBwvDR7g/vJ4W9bEsfyiRTcWlD6wU87w58ljN8GdpIoBRlGPy47q83/G7JV5NoGHV/tJLe6k3PYecvk66q77M0y2Lccs/P2OOf0KrxjzgSogWkXeJkCaVveuHzS4EL4RzxhFwCqZ3NL4TZt1zQEeOMfy6K8Ocv8ayqIptA1LH/TrI84fDuskQaCbvC3cBq1sFPwYFQxzEcKRIacGuO9Yh+KNYinEABGW70FZLDEdkCftclh4I+O86uamdjYTYG5iA5xs01FQseh+bNfb3bIDbF8XdDhO/dyMTFGYWe1vaYzhqWun14GgtswoHGL+OcZrleXr3wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=45h4k/9aWKhDVpCS/pTlXiHfTziDj/lIxA5Q8+FCaBg=;
 b=Kt7QxyI+TYxcMiJWzHivXgAZhR+guRS/MLpsntuRpGwVlg7ZeP98V3zHqr4zodQAW6ZCXnfv7ZFwCmq6G0AFSjVlZX1sHiXy74DPDiI6QBcydlTPjJfsmd9/QIB6xamGYq1+hzR1T44jA31tmRaISgGHI68hX37RgJxfjaOCPLd/D7H53dza5TofxrY9PjQU2W7YJ85/Am5FZVPmXPvysCbveS5hd087aIVbEJp7F1Md0twAZkyI5N8k4G9gnwjYzitjwnX/7+MbSHlKw1ded12P6N1zRrjq01f9uzDvYSEhffot6IJAKBcm5WWi2yoUlbkYW2bRZEvSxZb2dwXcpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5390.namprd12.prod.outlook.com (2603:10b6:5:389::15)
 by EAYPR12MB999132.namprd12.prod.outlook.com (2603:10b6:303:2c2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Tue, 23 Jun
 2026 19:35:52 +0000
Received: from DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720]) by DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720%6]) with mapi id 15.21.0159.012; Tue, 23 Jun 2026
 19:35:52 +0000
Message-ID: <d85651aa-a0a2-4664-8bc9-c32253e2f752@nvidia.com>
Date: Tue, 23 Jun 2026 12:35:49 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] vfio/pci: Add ats property
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, Alex Williamson
 <alex@shazbot.org>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>
References: <20260623023540.836825-1-nathanc@nvidia.com>
 <20260623023540.836825-3-nathanc@nvidia.com>
 <SJ0PR12MB8614F88365BE0F4362ECBF84ABEE2@SJ0PR12MB8614.namprd12.prod.outlook.com>
 <d31857d4-961f-4456-9f88-ed7e9a4a990b@redhat.com>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <d31857d4-961f-4456-9f88-ed7e9a4a990b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0137.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::22) To DM4PR12MB5390.namprd12.prod.outlook.com
 (2603:10b6:5:389::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5390:EE_|EAYPR12MB999132:EE_
X-MS-Office365-Filtering-Correlation-Id: fef40e5f-6c64-4760-34f3-08ded15ea315
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|18002099003|22082099003|6133799003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 9v/mm4XBx/tbOJoJ6LDHurmQvvKKC/uyXUVCQQqN39UfcfxuLs29D0gJXZaTRBy+p7Rq0cXL1D3bfNAJ9tDoyRIDX0FRAVBryFJB7iHqpTi8jOmgSZeDLFNa40GE4IlAvWAHyoA+kDn2rmoUgo+kvgzB1unQaRydY7wf4PGVWp5Cw6HIFdWxq307YmEiRfrpZeA832FC3CGe3u4c2u4HVaCmAqH3NCw6BODKrcn0LE1DGsQmYXmV//lwR1n5llmBUQSjOQ2wWW97iUzZC57pxWchJ0habkVokmIj1eu2kwi3Oln4sXd85V94VzbzdEF5xRrjFGQZ5wucllc4+uo/KyLiJtxWR2ID/VvORDK7PlKG1ZTKPD9PkPL5i7eMD8/bjT2bUFSekR3deQd9dznqmhkiHpO4VWaCBaY6bQ40w+ic0mi12Own7f88QqjCeLIQ0yeR1xBAd5fGRcDT/LOU9rJ75WEeZbxNWqRjlZr48BPrYc7VW9+XsKFFkiZ02BmFzizyUaTSH1dzSfG0RVMriffBkdYBdZJTk9u4wrRSdzOaaCSoI1P0xcFZDtfFtbF+NLXwfhSGWpuVqhvZZ842dAKRU6zRGr3yCZFNT8NCa5g5sLFcwU9FN1dpi5jqmn8yMKWDXgDNkeTpqWyF+kneSdA6GsoZdp5d4nH+Uh10Fqo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5390.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(6133799003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWNJVUVaWU5oeEFsVlZxVlJwaFhkb0krcGlsNS8wZTNQcVlQQWtsL0dJN2tv?=
 =?utf-8?B?Q1NnN1Y0RUZSa0c1N3lYT0dvbDFTNU5KVzIvWXdweFU5RnIrUGdPbTFKeDZj?=
 =?utf-8?B?NGp5RVBxSi9NTlRsVVN0b3I2YVlGRmVnVlVVd2hsejgvakdqcGYxYk1zYmc0?=
 =?utf-8?B?NVV6QlNCUnl1Yk1FMmlvLzRyN2ZESHg0VmlhdGQxL0JxdCs0VUQ1OU1rZnp1?=
 =?utf-8?B?eDNLWnkydW92anVzS0sybXdhZWtlVXJjcGY1UEp5RmIwTEphWDU5U1NjWTlS?=
 =?utf-8?B?M3E0dmJ6TlZYdFBhQXpndU15cElZdjBpWVhxZmQ3c05jSHV6T3ZSaDQ2SXlq?=
 =?utf-8?B?OWYvWjZZc1NkeVpCT2tmZEtVVW5wV21OazF6c3JJZXZyTkQweHh0NHh4eXdY?=
 =?utf-8?B?akY2SDlyLzJEN0ZRMXEzRHI5clp6MGc1VnhLc2tPaHhsYlA0TXhzdVEyQWFX?=
 =?utf-8?B?c0JQRWE1NjFyN3ZKaTFVdmlPT21zZEp2cDJBS2dnYitaY29ZeXpHUndldTFa?=
 =?utf-8?B?M05FT3RhQnlVRkNqdERRVmVwKy9yL3pxaHBQSFFkV3hod1o5NW9rd3o5ZTN2?=
 =?utf-8?B?QkNTQ2NTVFlpeXM5dXE2YVJaaHRzOThEb0Iya1hHR1lvVWxPMkYwcUJlSFpW?=
 =?utf-8?B?dUxsQ2RQS2xOWUY0TnhQeGtvclRFNXJWcFcwK0gxL3NGS3cxdWl4VnZYVUp0?=
 =?utf-8?B?ZXR1RkJuaVdxYlZJU2N4azlFTGVaUWMvTTZDTVpWUFhTRFQxSmp1SGJVK3Vo?=
 =?utf-8?B?OUgzT2xiZC9JaWFOM1BuQ0liSjU0eHIwcm5mY2FSaUUxMmhGMFUwbnk4eXVX?=
 =?utf-8?B?R01SelpNMlg4QUlLQ2VrRllYRFMybksyeHJJdDBXeUp1UWRUZ1ZldDJtRVZX?=
 =?utf-8?B?K2dPRWFnanF1c0M2M0FkWDBENUI5MU9xZU5FN3RIL1g5NjlveTAwdjJRelQx?=
 =?utf-8?B?bXVsNmlaVVhrdzB6UXFPUFpJclZYYTB0UGdpcUhvaWc3L05lWjN3dE54MjM4?=
 =?utf-8?B?c3lPcDR6djhScVhIT2M5NUZsRm5hYU4xMEM3dDlheDBCRzlBeW1Xa1V1ZmRJ?=
 =?utf-8?B?TXdTWnZTVEtCb2R0ZmJJeFhIYUVEMTlKVklPdTVxUHlUZ21ZZnVnYUYwdmlw?=
 =?utf-8?B?blVxQlJSTHpyb2N0M0MzVmNua2lvT1ZsREpGY0o2Q0pVZWFOQVhGcGhZNi9r?=
 =?utf-8?B?ZGVKQ05ib1Q3RlhRaks3d1o4dFBLQ2dkUEJrcWl4d0VyMjB4bWpIMXRXSXk1?=
 =?utf-8?B?TWNYbG50Q3pjcHNuanAxbWJmYnpmbE1VTFppVXJNM1ZpWEY0NUxiMG5ldklM?=
 =?utf-8?B?QUpUajVJeEg3RHJGZ1JSazREaGV4ZmQxWnF6MVh1ZkRrZGRWZ0lsRUdoU0Zx?=
 =?utf-8?B?R0JUVSsxenlweXBUZi95VkFRZGhKaG1UdnhNSmJaeXMxSmNCdEp6NHV4bXdr?=
 =?utf-8?B?blp5M0J2YXZOTW1QVGJXbW9WcmJCNjNGOWMxSFBpNitNamMxWjRES1U4aEx3?=
 =?utf-8?B?ZFAvWDNWWXV3ejdaanVzSXJLcU81Um5Vd0k2SGk0NWV5STFNdnpVaHJPZi9B?=
 =?utf-8?B?cFZpdlFHVnRyNmRKYm8wU09YMzI3aW94TWdQK2R3TW13ckhUWlViM0JtMjha?=
 =?utf-8?B?cVgwWjdvdTRCbWhzTnU3clBQOU1KRXBleXI3SnFnL0RpeWRUNUxsc0cxZjlF?=
 =?utf-8?B?WTBZUHNla0hSeU1CUUZmaVl5SU5XSWFEVVJFOFljRU5EdlNxRlhRbkNqS3Az?=
 =?utf-8?B?RWRtSlhsV0J6cEpUZHhpRDVySEVkV3d3WG4rSjV1ZFpvc2lzZVJQZjNIRWhI?=
 =?utf-8?B?Mkg2bTBaYnRsUjJ0T1VadXNjdHhOMUtIZjNIckNkMjFDaUdkZWNweXFuTVFk?=
 =?utf-8?B?aWdpcHpVbk9MZXVYUE1LS1ZoditheHdNM2UwWVE5bDY5bU1vY2ZPdFVpeXNi?=
 =?utf-8?B?RUxFZkwrdk9WVDdTM29CeUluV0RnbURUK0RWNm9GSzQxUUYveC92Nk00VkYw?=
 =?utf-8?B?ZjFBeG9RQ0wwRVQzUm1hWlJnVXBRMGs3aGN1WERXdmV3dnhaY1V1Q0cxdzZy?=
 =?utf-8?B?Q2pRT0hwL2dsTnZ0N3JuMndqT0FLbzVGZzRMMGl0bjlSdkdaVy91T0txV09E?=
 =?utf-8?B?eFhnbllGTExBZ2UvNmF5c242S3RIbE1nWHFXZUdlNEp1L0NqSzRJbjRvSmJz?=
 =?utf-8?B?T1pmTTNhdFZtQzlwanEyRk9YVk55Z25ETUxVdUFFYS9USEUySkM3dnZiVjVG?=
 =?utf-8?B?bVdLcEU1MlF5TVFQRjM0dFB3ekhHR0t3RFh3cjJYMFpWUFVxeXJZcG1DMENp?=
 =?utf-8?B?VGxGM085VDlqTHpGbEdEbk50UVpJZFhFcUhFeTZxWVdIR2xIUk5XQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fef40e5f-6c64-4760-34f3-08ded15ea315
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 19:35:52.8311 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QLDrlFhKFJzqiw8eMwioW5ErTUAod1ljtXmmrb2+KF+yo3sQrSRpeBFYCzXihi3WVeUfgRka8YUIsOSqn16yHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB999132
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=nathanc@nvidia.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
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



On 6/23/2026 10:46 AM, Cédric Le Goater wrote:
> On 6/23/26 19:01, Shameer Kolothum Thodi wrote:
>>
>>
>>> -----Original Message-----
>>> From: Nathan Chen <nathanc@nvidia.com>
>>> Sent: 23 June 2026 03:36
>>> To: qemu-devel@nongnu.org
>>> Cc: Yi Liu <yi.l.liu@intel.com>; Eric Auger <eric.auger@redhat.com>;
>>> Zhenzhong Duan <zhenzhong.duan@intel.com>; Alex Williamson
>>> <alex@shazbot.org>; Cédric Le Goater <clg@redhat.com>; Matt Ochs
>>> <mochs@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>; Shameer
>>> Kolothum Thodi <skolothumtho@nvidia.com>; Nathan Chen
>>> <nathanc@nvidia.com>
>>> Subject: [PATCH v3 2/2] vfio/pci: Add ats property
>>>
>>> From: Nathan Chen <nathanc@nvidia.com>
>>>
>>> Add an "ats" OnOffAuto property to vfio-pci. When the device has an ATS
>>> extended capability in config space but we should not expose it 
>>> (ats=off,
>>> or ats=auto and kernel reports
>>> IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED), mask
>>> the capability so the guest does not see it.
>>>
>>> If ATS is explicitly requested but not supported by the kernel, fail
>>> device realize.
>>>
>>> This aligns with the kernel's per-device effective ATS reporting and 
>>> allows
>>> vfio-pci to mask ATS when the host kernel reports ATS as unsupported.
>>>
>>> Emit a warning when ats=on is requested but the physical device does not
>>> advertise ATS, since ATS cannot be exposed to the guest in this case.
>>>
>>> Suggested-by: Shameer Kolothum <skolothumtho@nvidia.com>
>>> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
>>> ---
>>>   hw/vfio/pci.h |  1 +
>>>   hw/vfio/pci.c | 88
>>> ++++++++++++++++++++++++++++++++++++++++++++++++---
>>>   2 files changed, 85 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
>>> index c3a1f53d35..f2934f2d84 100644
>>> --- a/hw/vfio/pci.h
>>> +++ b/hw/vfio/pci.h
>>> @@ -188,6 +188,7 @@ struct VFIOPCIDevice {
>>>       bool clear_parent_atomics_on_exit;
>>>       bool skip_vsc_check;
>>>       uint16_t vpasid_cap_offset;
>>> +    OnOffAuto ats;
>>>       VFIODisplay *dpy;
>>>       Notifier irqchip_change_notifier;
>>>       VFIOPCICPR cpr;
>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>> index 9c06b25e63..c0436b4c04 100644
>>> --- a/hw/vfio/pci.c
>>> +++ b/hw/vfio/pci.c
>>> @@ -2546,10 +2546,58 @@ static bool
>>> vfio_pci_synthesize_pasid_cap(VFIOPCIDevice *vdev, Error **errp)
>>>       return true;
>>>   }
>>>
>>> -static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
>>> +/*
>>> + * Determine whether ATS capability should be advertised for @vdev, 
>>> based
>>> on
>>> + * whether it was enabled on the command line and whether it is 
>>> supported
>>> + * according to the kernel.
>>> + *
>>> + * Store whether ATS capability should be advertised in @ats_needed.
>>> + *
>>> + * Returns false only when ats=on is explicitly requested but the 
>>> kernel
>>> + * reports it is not supported. Returns true in all other cases.
>>> + */
>>> +static bool vfio_pci_ats_requested_and_supported(VFIOPCIDevice *vdev,
>>> +                                                 bool *ats_needed, 
>>> Error **errp)
>>> +{
>>> +    HostIOMMUDevice *hiod = vdev->vbasedev.hiod;
>>> +    HostIOMMUDeviceClass *hiodc;
>>> +    bool ats_supported;
>>> +    *ats_needed = false;
>>> +
>>> +    if (vdev->ats == ON_OFF_AUTO_OFF) {
>>> +        return true;
>>> +    }
>>> +
>>> +    *ats_needed = true;
>>> +    if (!hiod) {
>>> +        return true;
>>> +    }
>>> +    hiodc = HOST_IOMMU_DEVICE_GET_CLASS(hiod);
>>> +    if (!hiodc || !hiodc->support_ats) {
>>> +        return true;
>>> +    }
>>> +
>>> +    ats_supported = hiodc->support_ats(hiod);
>>> +    if (vdev->ats == ON_OFF_AUTO_ON && !ats_supported) {
>>> +        error_setg(errp, "vfio-pci: ATS requested but not supported 
>>> by kernel");
>>> +        *ats_needed = false;
>>> +        return false;
>>> +    }
>>> +
>>> +    if (vdev->ats == ON_OFF_AUTO_AUTO && !ats_supported) {
>>> +        warn_report("vfio-pci: host kernel reports ATS unsupported; "
>>> +                    "ATS capability will be masked");
>>> +    }
>>
>> This will be slightly misleading if dev doesn't have the ATS CAP at all.
>> Isn't it?  I think, the best place to do this warning is below where 
>> we know
>> ats_cap_present is set or not.
>>
>> Thanks,
>> Shameer
>>
>>> +
>>> +    *ats_needed = ats_supported;
>>> +    return true;
>>> +}
>>> +
>>> +static void vfio_add_ext_cap(VFIOPCIDevice *vdev, bool ats_needed)
>>>   {
>>>       PCIDevice *pdev = PCI_DEVICE(vdev);
>>>       bool pasid_cap_added = false;
>>> +    bool ats_cap_present = false;
>>>       Error *err = NULL;
>>>       uint32_t header;
>>>       uint16_t cap_id, next, size;
>>> @@ -2635,7 +2683,19 @@ static void vfio_add_ext_cap(VFIOPCIDevice
>>> *vdev)
>>>            */
>>>           case PCI_EXT_CAP_ID_PASID:
>>>               pasid_cap_added = true;
>>> -            /* fallthrough */
>>> +            pcie_add_capability(pdev, cap_id, cap_ver, next, size);
>>> +            break;
>>> +        case PCI_EXT_CAP_ID_ATS:
>>> +            ats_cap_present = true;
>>> +            /*
>>> +             * If ATS is requested and supported according to the 
>>> kernel, add
>>> +             * the ATS capability. If not supported according to the 
>>> kernel or
>>> +             * disabled on the qemu command line, omit the ATS cap.
>>> +             */
>>> +            if (ats_needed) {
>>> +                pcie_add_capability(pdev, cap_id, cap_ver, next, size);
>>> +            }
>>> +            break;
>>>           default:
>>>               pcie_add_capability(pdev, cap_id, cap_ver, next, size);
>>>           }
>>> @@ -2646,6 +2706,11 @@ static void vfio_add_ext_cap(VFIOPCIDevice
>>> *vdev)
>>>           error_report_err(err);
>>>       }
>>>
>>> +    if (ats_needed && !ats_cap_present) {
>>> +        warn_report("vfio-pci: ats=on requested, but host device has 
>>> no "
>>> +                    "ATS extended capability");
>>> +    }
> 
> "ats=on requested" is wrong here. OnOffAuto_str() could be used instead.
> 
> Also, ats_needed is true for "ats=auto" too, and since it's the default
> setting, and most devices lack ATS and any modern host kernel support it,
> this warning will be emitted for nearly all devices.
> 
> How about :
> 
>    if (vdev->ats == ON_OFF_AUTO_ON && !ats_cap_present) {
>        warn_report("vfio-pci: ats=on requested, but host device has no "
>                    "ATS extended capability");
>    }
Yes that is a good point about the warning being emitted for many other 
devices that lack ATS. I will revert this back to checking vdev->ats == 
ON_OFF_AUTO_ON. Originally I was thinking it may be useful to emit a 
warning for the auto case as well when host device has no ATS. But I 
think that is outweighed by your point about most devices lacking ATS, 
and users can just check the ATS cap's presence directly from the host 
beforehand.

Thanks,
Nathan

