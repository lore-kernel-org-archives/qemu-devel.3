Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B38EDF148
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 11:30:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqrMo-0001Tr-4T; Fri, 13 Feb 2026 06:29:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vqrMl-0001TU-8y; Fri, 13 Feb 2026 06:29:43 -0500
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vqrMj-0002Ac-3m; Fri, 13 Feb 2026 06:29:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LKxcdyZKg0Ynoeq6VdXJ54a1TyTDmPw9arwB3XZpoKKr0alRK0HVDw35KUWg4Ysw02vnkVFBDwR/AYdzorN4M0pLQeDnXpojY7xMEL7p8Ng8EVtMqR+b+++DNF5njwEv2SEFx6NoYvYxoDJXizUivYdcO5bJ5IkKyk4gyvRcXAOwvMrvGKxPwJN+4Cq4pJBHOyt2MUAqQq9CNvrM2eZ0hP4666gE90d6zRHQsoJe0Ecyd9WGojga9DYDuHKqs3Kl0R/mw0KmseGZvYhzpBUdxAEwyKtoNKpb+B2Zi7NZiiHmFkwQe1wsFfP9C+5ixjZt1VGcQ+J9NhEXnZr63r3EMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bjP0Gu7o0ZwCUhVnvau5RwuRfq/PwCNreUkr+93dDyU=;
 b=EiqDffLnDfuGnD2xtHlYsxJzpXIbaixqP/VftgI3FA8Rs/0oeNcoK+qfQh4VscBwGG4xZi9JpWhHD1EPXDSYnMkX3Y+wmk46mc81gGj31Xg2z28DCiKYl/X5emg/bzrYUbzH8UkcRG8nkF+suESrg69o9FOf6KmT5PNPEyWjXrVqvQLRtXYBDnTwUm7RGomL7msdXbwI0Ng7f55Hv2Y4oU2g5n1Zq4EDN739wn7gT2TAFDA9Qkkhul61pRx49wdmGHZSjv8QNt3TF135GLLfYdMjaRPYWcM4SATpARBdXCo5ajA/DaEoQcR2VjfBxJb/48mUAxlOhBCH74cUgYfT8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjP0Gu7o0ZwCUhVnvau5RwuRfq/PwCNreUkr+93dDyU=;
 b=Mg+Ligwf8MbzWNlvLsPVkOBAtyk5WNaz6eB0nFH98pffL/cwE4hlSUbO+3H7vzNPlQzHk6ZziqUygOYoVujVwizfuOP+ofmGW9KLZ0EZO0LstTrEuP4sW91GFZng18KImSqU2RjK8+8+eP+nTi0PXfhvfx+DnTe+BY+iZeN/IPi+49Kpf8ixoCMtPkXO6YPFHA1nCvzCWyf26tJmrQSncxrISJzGRvWWZVspDV+GrY6SmC4gp95DKnaJrYl7+nEA2xvH6IY1fGIGrQddeL2o4uxK0/XzhQeV8v2Y7MPOmCPdRVPqNG+uWGa/9WQd1OkBfkda/e3lN24cDC8HvlCVyQ==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by DS4PR12MB9659.namprd12.prod.outlook.com (2603:10b6:8:27f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 11:29:32 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 11:29:32 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v2 16/24] hw/arm/tegra241-cmdqv: Use VINTF page0 for
 mapped VCMDQ registers
Thread-Topic: [PATCH v2 16/24] hw/arm/tegra241-cmdqv: Use VINTF page0 for
 mapped VCMDQ registers
Thread-Index: AQHcl3f15nV0hNaiEEO8yx32I0+4qLWAeVIAgAAKYxA=
Date: Fri, 13 Feb 2026 11:29:32 +0000
Message-ID: <CH3PR12MB7548AB8F6EB3B66CEF49ECDCAB61A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260206144823.80655-1-skolothumtho@nvidia.com>
 <20260206144823.80655-17-skolothumtho@nvidia.com>
 <92832cfa-de59-49c0-8cf3-38cfa80d2c3b@redhat.com>
In-Reply-To: <92832cfa-de59-49c0-8cf3-38cfa80d2c3b@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|DS4PR12MB9659:EE_
x-ms-office365-filtering-correlation-id: c7ce2177-281b-4256-24f0-08de6af32875
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?d3NtUmwyRXVtd3ozeHFqV3hTRHhsTW9LaXc3a3RJNUxJVExDNFcvTXJGTUFQ?=
 =?utf-8?B?anlHUnpMTHhwRU12OXFjT0hkVUk0SlViQ09tUWRWZ2EzdEprMHNDS3hvTFpa?=
 =?utf-8?B?cE9EMnRxUkZnZDg2SFZzR3o1eWxYOFQ3RmxqWFZHa1ZqbDZYMUt5YzhReTZT?=
 =?utf-8?B?anhoWkVyUEkxR3RwUzAvTy9mZnhaMWt6bG5pQUVRdHhaamFZcXZDMENSbnZm?=
 =?utf-8?B?MGtsc1BmSmtBN1RCUUhadDdDcEFscDViZEhPUCs0azdpeEpMSEU1Y2NtWHdr?=
 =?utf-8?B?UkpkUEJhc1c3Yk9hMjcvUUJyM2w4QWhRell3RkpTMitjRlUzRS9ESXdyOGJB?=
 =?utf-8?B?dUFYdzR6Z2FPaFFaTFAxN3cvOU5Vd3JPYzJOZmdLcnhBWmtaUjhpdllsWDNu?=
 =?utf-8?B?ajVFYU1mNURGalZLTXZwVFUrMUEybzNvNjJLS2JtcmFOdUZoQjdrbVpXc2xm?=
 =?utf-8?B?SVRnTW1kNFF3YmNSMndPTWJCMGNuOG1SNmhWM0JOK3NsbEhTWU1YRWl4ODhw?=
 =?utf-8?B?VDZzK3ZheHJPRzFHaVlzM2pvajc2NC9rVmtib3JXN1VGVVpaOHN5NEF5L0Zv?=
 =?utf-8?B?U3ZlVWJnNEFQM3ZxMjhERVQzWVA2bmp2QVF3R3BPc3hPb3pzUVNzTDhTVGFK?=
 =?utf-8?B?R3ZGS1J5bnZLblRCcjFVbzk4OHVRQ0RnSTM4YThNRER4Yk5aQXVCeWpVZWE4?=
 =?utf-8?B?TFExWXNlalpsWXVXb2Y5NVRGbDdhSjJDK2MzdTZ2S3JaTm1SWi9sbUNCSUhm?=
 =?utf-8?B?Y3FHS3RXMGVCOVl2bUFPRm9VeXJ4R2JqZFd1bWUwMnAycTlwejRrSnBIQWFl?=
 =?utf-8?B?cStqTWlrbjBBSXdEczhwaVlraXlLTVpGY21OTHJhbUt3Zi90NEFBZTVFZ1Q4?=
 =?utf-8?B?OUZYZk1oclFWTUs0Y1dERHdYa2RzQ05aN1phV3NJMlUyNitVSW9wTHdkTDBu?=
 =?utf-8?B?bXpFRk1EVUZaMjM4Nlg5Y0VGUW9wMmNLWDNaVERFeHhuemlGRThiOXExR253?=
 =?utf-8?B?dkRlTnhjYlJzWkhZc3VnUnc1WFFTb29DUDRGemJQWWVGYTl6a09sSWxpRzNC?=
 =?utf-8?B?Mlh0ZHQxeTZsRG9IdUZ1dkNFUm0zWGNUSjdENkwzWnJ6RHJCZHFRMXo1VW44?=
 =?utf-8?B?TVlTSEZTck9KWG1GU2FCQSt0R0JoT3A1cjZDaythSjNUSzkxak5Jb2JNS0ZG?=
 =?utf-8?B?bGx2SFVPRGcwMDB1bzU1eUlDZEUrbVJVbUlzcWdmcmgrNjYySzNualVrZzBr?=
 =?utf-8?B?aGkwVEdEZ0NuSkZobkJjTXpKb0I5M0QwZlM0Mk1BeDB0R0NlK3dwRnZOYXBi?=
 =?utf-8?B?YmNCT0tSd1c1cFNVZ3dBMFVHTHB1a1BDU0FSU3JGNytvUnJ4cEVtZ2NDL2p0?=
 =?utf-8?B?QTg1eG9kRlZrakEzV1dmeUg2cllLQ200L1QzYXFyczgraHA0anIxcUs5akZj?=
 =?utf-8?B?NjFmM05UUjhKYzVyY2hxbk5xU08xU3hkNk9wRDNQVDRWdWNiMmRlOE00MTNp?=
 =?utf-8?B?YlpDQm5iVzZCWnBjQ1d1bCtiTlNnQXpsRUo4Y2JDbUZ1U3JvR1hRdDRpb1RI?=
 =?utf-8?B?R2J5Zmh1NS9NNEVSbDhReDU2MVU2aXdQaFgwa3IrVXBqb21mQ0x2YSsvRDFL?=
 =?utf-8?B?ZGJHVnBzelVRQXpBZXB5Yld3WVQwZHhlQXpMcnR1L3lrcWJwWU1pKzFMSU93?=
 =?utf-8?B?VVdGV282UnJXeGFkcDNKTkRReG1wV2dpWEcrcVU4SHp1U2hVZmFoV045ZXE0?=
 =?utf-8?B?WFpHNzE5SEQvQm90NGw1WkE3dWxUaVM0RFJFeWdpTGdib0ZZVGhTd1ZWbHJN?=
 =?utf-8?B?cndMVE1CcnYrbmJheTVScjZueU9iaG5ia3hDM1dqdTNKa1JxclhoWjM0M1FK?=
 =?utf-8?B?b1FWZGM2ZHFGMFZLQm9HS3dYdE8xN2g0OTBMTDhXRE1nZDFFb0lOSXZCdTJC?=
 =?utf-8?B?UFNmdHhyRldSYmFPM3FFNXNJcytPY0F5NUpHa1V4emlod3BnSWVMcmsxckhF?=
 =?utf-8?B?WlpsY0VjVU9uR3lNV3ZycVFkNm1WbmNoeU9SZHFqalFaa3hDVjU1YVBnTCtD?=
 =?utf-8?B?aSs3N0F0Y25sN2xPNXBWVmdPRWM5Y3Q3b253VktOQUI4TEdmUzFucnZZazQw?=
 =?utf-8?B?WnNpRzNGa2hNWGR3dWpweFVEdkZGYmRhZ3RXMi9SR0pkRGJuTTZOL09zRDNz?=
 =?utf-8?Q?vg52ceDdPBCIijBepqAlG0o=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UnY2a1RydFVkUFNQenRDNC83WnRaWSswaHUxWk45N0p2bnlvSDFmbXlVTUxQ?=
 =?utf-8?B?WmYxTlBYNTFFajNXSExDTjFzQ1E5dmkzdktuNHM2eUtlTC85WkgyWit0dlFv?=
 =?utf-8?B?bFc4TVgwK0g3QTAvWTM4NXRmbzFSMmhCZ3R4RmxOWGVDdnRKY1BNU3FSV1Zy?=
 =?utf-8?B?eFdXMTJyQ00xQlZBZ1RtOVVBdzhOQ3JTTnh4bzFSbDdDdXI5SldpM1pjVGd0?=
 =?utf-8?B?UlBRTUhKTEJjTW9GUk1mdkdFVDAvWC83QVBKWk5pS29jeXhHQXNQYXZnTnEr?=
 =?utf-8?B?SStSVEZLYVQ2ZEd1c2RlcmZ2WkFwc3orOU1Ebkg1UmlPOVBlcUpQNVdPYVRp?=
 =?utf-8?B?Uyt2dmdnaDZlVElFeVdQMlF6cVg3dDBhcUREeDZvRzdNVnAwNFRwU21Ea3Zi?=
 =?utf-8?B?MjQxd1RKaW0wcXlSNWw0QU9KVC9VeERRb0lMc2dnc29oM3pXZC9uZ1crenFF?=
 =?utf-8?B?Y0UzN01kVkI1ZXAwQmV6cmROME1PTjhGUUQ5T1drVGFiRGJlTkVIc3VNN2xj?=
 =?utf-8?B?S3hzdXVVMzZ0MzRxNDR6TnEyQkRkRkw3bXcyL1hWUFlxTVEyaHp4WEFPSlY5?=
 =?utf-8?B?bkI4TGlEQ0x3RkFndGZVU2ZxaUJYd0RBbHRtTytYU25QN3RVNUh4emdHeGtr?=
 =?utf-8?B?Zm9oVlFac0VXeEE5YWdMYWpVRzRkRktDYVM0SENvVjd0eHcvRmhxME94RTla?=
 =?utf-8?B?NVFZa09rN1k4MmNZNThuei9UcEsydVRCUWg4SDBGUkNjV1dMM21RdUJOeWkz?=
 =?utf-8?B?cUF6dTFoME9DdHZZNHhPWTBlU2R6MUFPQWNDRldnWHRPd056aGRiTGxLQnRx?=
 =?utf-8?B?SXNVcDdIYzNKTkFTb1J6cm9EYitsVmVnbStERHRxaWUxQVEvV2tnMWp1SWxh?=
 =?utf-8?B?cUI5Vm5FbGs4bnVQamx5Yk5rSXE3dHB1U1FpUitNc2ZOcGdTbGxJL3ZRbmt5?=
 =?utf-8?B?RGMxc095TUU2cGRQZVBLU0pQOUFyTEtxai83MmR3aDQ4L0puSi9aV2RrM2Ra?=
 =?utf-8?B?LzBnSng1Y25tZXRCVW5TeENXQnFzd1NxUE1Od0ErN1JlNk9TT3VoM1RyYjhv?=
 =?utf-8?B?UldXcGNvWTdGQ2d0Vjl5SXNQMFkvbEd5ZWo1Vjc5bDVkaEU0TU9pUWpmQkRa?=
 =?utf-8?B?eVdUaFR4aHRQUFg4N3JVNkhzVmpyeThvMWNnaFgvVmpXZVFZc21qYkNtQkdG?=
 =?utf-8?B?dWpaZ3ZnNWt5UjZqaW8xRzNRRnBYYWt0a0ZSZzdJd1FIdnNyRVpPWTVIS3Zj?=
 =?utf-8?B?WERlY3BrakZ0Vy9CMGhzMmRaYWExZVJ1aDVldVdSRFNYUjFVTWRlRlFEakls?=
 =?utf-8?B?dm8yOGZZSW9RS2pzZmU2anFNS1hZVVJYVDMzcFFLbCt0RWVha3U0ZVh1V3Y3?=
 =?utf-8?B?Q0c4Q3k0SnJVZ3FqdlQ4QVJMNXYyTU5nYzdtbThwM0FLd0lyMjg5ODdaMnN5?=
 =?utf-8?B?MUZRcHhoUmVHcU9VRHhtdG5Tc1pnUTl5TEJNZ1JVRGJVWEtCSnQxM0kyTXZy?=
 =?utf-8?B?dTdPWkk2Nmora3FLeEJoWm4wNFlUaUVaSy9NWitkUk5ERzRqaE5UbStiL0xV?=
 =?utf-8?B?ZHhzVlBiV2RMSnNtUnZRZEJLeG5uTExib0lKOGRkcDVINU5lNlBSaXl6TXhI?=
 =?utf-8?B?M2pXaHJNZld5REExbGtua2VGWnNqN1ZnQ0tScksycllNSUtCOVNZaElvMXhz?=
 =?utf-8?B?dVFKMEs2U3ZWazAycjNYaGRJYTVzOFhMVi9Sem9UWEJGVFhuZmVXUWlLUkZE?=
 =?utf-8?B?eXdRK0NmQnoxMGRwdG5SZWxORU5PcG5iWmxYRkU1cXpLRzBrYlRqYVpyZlVE?=
 =?utf-8?B?em1qL1dRd3Y4VFI1eHc4OHpmVlhxRmNLL2FWVldERkRSdllDaHlpN0I4WklI?=
 =?utf-8?B?OXNUd3lrRE1UWWlQcHZqaExSN3ZGcTBSc2xoamJ1QU8ybk5wZU1aSjhjTS9O?=
 =?utf-8?B?a1hxbGswVnh2OWZvdFdMZnhBTHRtYUdFU3pEM0w4bUJoUDhSNU5oMHh5akVk?=
 =?utf-8?B?dUZLeldXMlVObFBVMDdaYXhxaFZWK0pUNG5UZlF2alhta2IvTzdsdm0wS0pH?=
 =?utf-8?B?UXhVVHlYQitkYVZtZmk3RzlUcTJGUURsaXJPQXdkY1E5M0VFK0JkNld4UWFk?=
 =?utf-8?B?ODF0ZlJGWFZuVkdTaXlrUWdPSjJvbXgvU1M3bEtCLzR5TlBGVkQ2VERySlZo?=
 =?utf-8?B?KzVpcTZXMjNlY29XZEthckdhWmVVRzVyZUpUQnIwNzF1S1lXSFlieXlsakhs?=
 =?utf-8?B?ZTBPRnFqdDBUVG9hL045MzFXV1RlS3VaUFR6RXFJOEJKNWQ3eisxajFhQlAv?=
 =?utf-8?B?OHdRTG5oNUVhK3RTWXc2Tlk3VDZPb0gvZFU1OENZeEhiKzMvbmJtZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7ce2177-281b-4256-24f0-08de6af32875
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2026 11:29:32.0975 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B2/dzC1kP749rMqD2ylx2VqKOLjlZJP/xI16Sw3uwX671A+jWzDgVx+VcbD8oPJPFi6zdthwMxxRnD2Z2DLr+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9659
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=skolothumtho@nvidia.com;
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAxMyBGZWJydWFyeSAyMDI2IDEwOjMzDQo+IFRv
OiBTaGFtZWVyIEtvbG90aHVtIFRob2RpIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT47IHFlbXUt
DQo+IGFybUBub25nbnUub3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IHBldGVyLm1h
eWRlbGxAbGluYXJvLm9yZzsgY2xnQHJlZGhhdC5jb207IGFsZXhAc2hhemJvdC5vcmc7IE5pY29s
aW4NCj4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT47IE5hdGhhbiBDaGVuIDxuYXRoYW5jQG52
aWRpYS5jb20+OyBNYXR0DQo+IE9jaHMgPG1vY2hzQG52aWRpYS5jb20+OyBKaWFuZGkgQW4gPGph
bkBudmlkaWEuY29tPjsgSmFzb24gR3VudGhvcnBlDQo+IDxqZ2dAbnZpZGlhLmNvbT47IGpvbmF0
aGFuLmNhbWVyb25AaHVhd2VpLmNvbTsNCj4gemhhbmdmZWkuZ2FvQGxpbmFyby5vcmc7IHpoZW56
aG9uZy5kdWFuQGludGVsLmNvbTsgS3Jpc2huYWthbnQgSmFqdQ0KPiA8a2phanVAbnZpZGlhLmNv
bT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAxNi8yNF0gaHcvYXJtL3RlZ3JhMjQxLWNtZHF2
OiBVc2UgVklOVEYgcGFnZTANCj4gZm9yIG1hcHBlZCBWQ01EUSByZWdpc3RlcnMNCj4gDQo+IEV4
dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+
IA0KPiANCj4gSGkgU2hhbWVlciwNCj4gDQo+IE9uIDIvNi8yNiAzOjQ4IFBNLCBTaGFtZWVyIEtv
bG90aHVtIHdyb3RlOg0KPiA+IFdoZW4gYSBWQ01EUSBpcyBtYXBwZWQgYW5kIFZJTlRGIHBhZ2Uw
IGlzIGF2YWlsYWJsZSwgcmVhZCBhbmQgd3JpdGUNCj4gPiBWQ01EUSByZWdpc3RlcnMgZGlyZWN0
bHkgdmlhIHRoZSBWSU5URiBwYWdlMCBiYWNraW5nIGluc3RlYWQgb2YgdXNpbmcNCj4gPiBjYWNo
ZWQgcmVnaXN0ZXIgdmFsdWVzLg0KPiANCj4gQXQgdGhpcyBzdGFnZSBvZiB0aGUgcmVhZGluZyBJ
IGRvIG5vdCByZWFsbHkgdW5kZXJzdGFuZCB0aGUgZGFuY2UNCj4gYmV0d2VlbiBtbWFwIGFuZCBu
b3QgbW1hcHBlZC4gUGxlYXNlIGNvdWxkIHlvdSBlbGFib3JhdGU/DQoNClRoYXTigJlzIGZhaXIu
IEl0IGlzIGEgYml0IGFtYmlndW91cywgYW5kIEkgd2lsbCBpbXByb3ZlIGl0IG5leHQgdGltZS4N
Cg0KVGhpcyBwYXRjaCBpcyBiYXNpY2FsbHkgdHJ5aW5nIHRvIGFkZHJlc3Mgd2hhdCBOaWNvbGlu
IGV4cGxhaW5lZCBhbmQgc3VnZ2VzdGVkDQpoZXJlOg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
cWVtdS1kZXZlbC9hWGtUelJNNjk1b1RXRmFEQEFzdXJhZGEtTnZpZGlhLw0KDQpJbiBzaG9ydDoN
CiAgIGEpIGlmIHZjbWRxIGlzIGluZGV4ZWQgdG8gYSBtYXBwZWQgZ2xvYmFsIHZjbWRxLCByZWFk
L3dyaXRlDQogICAgICAgbW1pb192aW50Zl9wYWdlMC4NCiAgICBiKSBpZiB2Y21kcSBpcyBpbmRl
eGVkIHRvIGFuIHVubWFwcGVkIGdsb2JhbCB2Y21kcSwgcmVhZC93cml0ZQ0KICAgICAgIHRoZSB2
YWx1ZSBpbiB0aGUgcmVnaXN0ZXIgYXJyYXkgY2FjaGVkIGJ5IFFFTVUuDQoNCj4gPiBTaWduZWQt
b2ZmLWJ5OiBTaGFtZWVyIEtvbG90aHVtIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT4NCj4gPiAt
LS0NCj4gPiAgaHcvYXJtL3RlZ3JhMjQxLWNtZHF2LmMgfCA0NA0KPiArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKystLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNDIgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9ody9hcm0vdGVn
cmEyNDEtY21kcXYuYyBiL2h3L2FybS90ZWdyYTI0MS1jbWRxdi5jDQo+ID4gaW5kZXggMTUzZmQ3
MGVkYi4uYzdlNzBkOGUxZCAxMDA2NDQNCj4gPiAtLS0gYS9ody9hcm0vdGVncmEyNDEtY21kcXYu
Yw0KPiA+ICsrKyBiL2h3L2FybS90ZWdyYTI0MS1jbWRxdi5jDQo+ID4gQEAgLTM4LDEyICszOCwz
MiBAQCBzdGF0aWMgYm9vbA0KPiB0ZWdyYTI0MV9jbWRxdl9tbWFwX3ZpbnRmX3BhZ2UwKFRlZ3Jh
MjQxQ01EUVYgKmNtZHF2LCBFcnJvcg0KPiAqKmVycnApDQo+ID4gICAqDQo+ID4gICAqIFRoZSBj
YWxsZXIgbm9ybWFsaXplcyB0aGUgTU1JTyBvZmZzZXQgc3VjaCB0aGF0IEBvZmZzZXQwIGFsd2F5
cyByZWZlcnMNCj4gPiAgICogdG8gYSBWQ01EUTBfKiByZWdpc3Rlciwgd2hpbGUgQGluZGV4IHNl
bGVjdHMgdGhlIFZDTURRIGluc3RhbmNlLg0KPiA+IC0gKg0KPiA+IC0gKiBBbGwgVkNNRFEgYWNj
ZXNzZXMgYXJlIGN1cnJlbnRseSB0cmFwcGVkLiBVc2UgY2FjaGVkIHJlZ2lzdGVycw0KPiA+ICAg
Ki8NCj4gPiAgc3RhdGljIHVpbnQ2NF90IHRlZ3JhMjQxX2NtZHF2X3JlYWRfdmNtZHEoVGVncmEy
NDFDTURRViAqY21kcXYsDQo+IGh3YWRkciBvZmZzZXQwLA0KPiBzL29mZnNldDAvb2Zmc2V0Pw0K
DQpIbW0uLiBJIGRpZCB0aGlzIGJlY2F1c2UgaW4gcHJldmlvdXMgcmV2aWV3IHRoZXJlIHdhcyBz
b21lIGNvbmZ1c2lvbg0Kdy5yLnQgdGhpcy4gVGhlcmUgd2FzIGEgc3VnZ2VzdGlvbiB0byBkaWZm
ZXJlbnRpYXRlIHRoaXMgbm9ybWFsaXplZA0KVkNNRFEwXyogb2Zmc2V0IGZyb20gdGhlIHRvcCBs
ZXZlbCBNTUlPIG9mZnNldCB1c2VkIGluDQp0ZWdyYTI0MV9jbWRxdl9yZWFkKCkvd3JpdGUoKS4g
DQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvYVhlOFFndGR5Qm1YbTVpU0BB
c3VyYWRhLU52aWRpYS8NCg0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBpbnQgaW5kZXgpDQo+ID4gIHsNCj4gPiArDQo+ID4gKyAgICAvKg0KPiA+ICsgICAg
ICogSWYgdGhpcyBWQ01EUSBpcyBtYXBwZWQgYW5kIFZJTlRGIHBhZ2UwIGlzIGF2YWlsYWJsZSwg
cmVhZCBkaXJlY3RseQ0KPiA+ICsgICAgICogZnJvbSB0aGUgVklOVEYgcGFnZTAgYmFja2luZy4g
T3RoZXJ3aXNlLCBmYWxsIGJhY2sgdG8gY2FjaGVkIHN0YXRlLg0KPiA+ICsgICAgICovDQo+ID4g
KyAgICBpZiAoY21kcXYtPnZjbWRxW2luZGV4XSAmJiBjbWRxdi0+dmludGZfcGFnZTBfbWFwcGVk
KSB7DQo+ID4gKyAgICAgICAgdWludDY0X3Qgb2ZmID0gKGluZGV4ICogMHg4MCkgKyAob2Zmc2V0
MCAtIDB4MTAwMDApOw0KPiA+ICsgICAgICAgIHVpbnQzMl90ICpwdHIgPSAodWludDMyX3QgKiko
Y21kcXYtPnZpbnRmX3BhZ2UwICsgb2ZmKTsNCj4gbml0OiB5b3UgY291bGQgaW50cm9kdWNlIGEg
c3RhdGljIGhlbHBlciB0aGF0IHJldHVybiBwdHIgZnJvbSBjbWRxdiwNCj4gaW5kZXgsIG9mZnNl
dDAgb3IgcmV0dXJucyBOVUxMIGlmIHRoZSBWSU5URiBpcyBub3QgbWFwcGVkLiByZXN1YWJsZSBp
bg0KPiB3cml0ZSgpLg0KDQpPay4NCg0KVGhhbmtzLA0KU2hhbWVlcg0K

