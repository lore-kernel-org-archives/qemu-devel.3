Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ADB8C87FCF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 13:34:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umBao-0006r4-Hf; Wed, 13 Aug 2025 09:32:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1umBal-0006qL-7R; Wed, 13 Aug 2025 09:32:35 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1umBae-0006r2-Bs; Wed, 13 Aug 2025 09:32:34 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DDNEH4027131;
 Wed, 13 Aug 2025 13:32:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=yw0YxDxqHbffLTae2GmZ2oRi2vP0VOgufsBNBWJgkFg=; b=
 hCfUEumiRXUmHRjk0MmTLZTpxQd9cY8pDpIbPOWSCUxQyJElRLrKzZv1eVH+kjH0
 7ETDWzuPWy9rg/YWh7mUAi8l3mHqltBq6xSs17QhCoPHP5uJq+kv1rvWkj2oW5L5
 tNPQ6QjVHnNxYKFZFfK2SrhSCB9SkDLBzcQbedbhQImKYytucpXXrh+BYNzgOhZt
 th1DjC+zSDM283HtNM8Bzfy5tatxZwIRigmRHKm8mN8ly0Bxk9MYyUY0C95ss9Ud
 jYx9Go2HVwXPFblI3fzoxwHoupX9ATcsCYFqiFqEwIGgTirAW8/tOMq7DYhrkst2
 rIcsibSQoNNmb7SdF8vEIQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dxcf7mrj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Aug 2025 13:32:15 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 57DCARYJ017410; Wed, 13 Aug 2025 13:32:14 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 48dvsbdjg0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Aug 2025 13:32:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vgk9osHylFeo/4ZEHynUmqki9F2fShXumDrQQHJkcdTRHyvEyL0igp9BGK1CSsCEa0YVaQuhKVZkG+QKK1jl4zMYROwcH1ZgkA/gNUS8/q5TlFjicr7CjUzggbH5ZayDS86Fc6/M0B3Z5gaYJAeql0MiCMLg1qN6zuf0nDV1QfIzScyIKYqov0WhiuZiKOdjAsUudb1e8VRr4HE6rouiVkAEsnJA7h+nLwGQXjU32281VtU189ZlKewc/PYfNTAGnSNHN5WZLmuytbfIkFPwhq/7VRD74sXo48v/EQ2bXaUEP6mqNIdpxjmhNGYvwN4jAeGCl2h77N9zBR36MLx4hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yw0YxDxqHbffLTae2GmZ2oRi2vP0VOgufsBNBWJgkFg=;
 b=nqutWxbbmOed5/jrwtCL+dmQri3BULy0NMxQSqH8FgEixIHrxsIwM+huN+qYmrzE4WkQnsESBUwDCVBYyvkREYIY+/8limsuMu0bH8oVCTAn2rEnyW2lg1PY6M8cyStVsDREDDP4qB20uGbKRprkXgGtv95BpHj7zsxWHIlNa7KlyuW+bLHjn/1dVs06Z2/pmmE3HGN4REtA+l6E2x4xxz5GTipq5i1ZQj+GW+KShmfu4Z5lbUm9fu48Robr5T+hNUOMfIUFtgpiJHssdiN/zveK89goz3bziArsQJ18WCRvBtjS35cnw70yuJCtbqzwyRxiyT9NOs0cyt0X6ZXgvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yw0YxDxqHbffLTae2GmZ2oRi2vP0VOgufsBNBWJgkFg=;
 b=hmU0o6rsU315s1+MFEo5Xk+tlUwzIxL10WqHYgve2VVYs+gbOkYHwdRwpYHKDYVvaIlJhrgiVOxelUpcuiT+WWwNUSinZy0r+kT6FPpwb1zxSwDr1RLXTaVcmny6uoMMhWMYDD5U/bVt+UhCfZl7R5TwwfG3ojhGoYxgZDrhHMk=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DS0PR10MB8101.namprd10.prod.outlook.com (2603:10b6:8:203::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 13:32:12 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 13:32:12 +0000
Message-ID: <ad82545e-702b-4127-a339-680d52065ae1@oracle.com>
Date: Wed, 13 Aug 2025 09:32:08 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/1] hw/intc/arm_gicv3_kvm: preserve pending interrupts
 during cpr
To: Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>
Cc: Cedric Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Zhenzhong Duan <zhenzhong.duan@intel.com>
References: <1754936384-278328-1-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <1754936384-278328-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH3PEPF0000409A.namprd05.prod.outlook.com
 (2603:10b6:518:1::46) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DS0PR10MB8101:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dd9cce2-09d0-4463-393c-08ddda6dcf11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L1lZc0poTFFYTnZ6WGE5MFM1eVhySzdZUHVVa2ZGWFh0VTRLaVdpRnRKd2l4?=
 =?utf-8?B?RnBpZEFaK0xWM3F6bkt3cTVOUXJoRU10cVB4d3p2Wk45aXdGUEpRcStEWk1k?=
 =?utf-8?B?TTFINktBOGo1Y3hDdnkwSncvOG45K0orNmxlUWxBdHY2S1o3T1lTTnU5cHls?=
 =?utf-8?B?VUQwT0ZsaTdZVlBqWlhja2xsbjlRU1NkUC9wU1FkeldEZ3lucVRWSEhmc2tj?=
 =?utf-8?B?WUpHMHlrd29vVDNCdmMrZGlvL1FOVVQ0RCs4dGQ4T2JWaGZqcjl5MkZDc3Vn?=
 =?utf-8?B?OVhyc0NLaUJkWm9YZFRkYzJEWS9oUHFrOTVGQkI5ZUN6cGEzK3NVRWtFcFlU?=
 =?utf-8?B?N2JReU1KbnZxQTdkODVHLzh2VExJeVduNEhDOVlQYXhKY3F2MG00V1NxNVZY?=
 =?utf-8?B?eHJxVG96RXhhdHRrQkZXUituck8yYWN0eDhDMHNFQndZbWI2bjJUbHI1aElS?=
 =?utf-8?B?Q3YyYnpkUElGY2Z1ZVEyUDAwQW5aSEw2RURVQmpkeXhsVlcyNUM0Q2xCVngv?=
 =?utf-8?B?WUxXSW5LNmNFT2ZOblpWQ3pTRTRCZVRkczFtUFhlYmw5ZWdDU0NpNzh6NE9y?=
 =?utf-8?B?RnYyS21COGdEYlhKZmZjdll4V09oNVdmMDZic0hXY3BCNlMyWE9FeFEvaDBi?=
 =?utf-8?B?UzBvT2ZiUjN1KzV3RVZCMFBCeGxVRWFvZTBhcnVRcHh6cGpHazlYZ3M5RjVj?=
 =?utf-8?B?RUxUS3owL2grdU9GVGcybXpXRTdnZlQrUWpSRGN5VVR3WjFSelkyL3FlUG5X?=
 =?utf-8?B?NXdxWFIwdGVyQ0JCb3VNQ2dMQXg0c2FBYTdTZHpleDVDV2F5b2RjdXQ0R1dK?=
 =?utf-8?B?Y01XdGJKWTY2RFhxVXVXdUJjWFpQVjQzUzlMOEdlYVB5ZE84amRLQTNsN3VF?=
 =?utf-8?B?QnEvemFncjFkenhjNkh4UnEvdEplWXBlY1U3blA2UHFQcG9rcTlnQmp1VEhJ?=
 =?utf-8?B?MEtObmFpK3JEZDIraGFGejdLa0puM0NNUEY4UGttbUF0RTgyWUtaMkJTU2Vu?=
 =?utf-8?B?OEJGa256bFhYTmI3czJ0WEhjaWVjSkxoTVdwZlJ3NzlTVjYrT01tRTM0ZkJv?=
 =?utf-8?B?RXNLQk44K25PcGhvWWFpMlNFY1JjNEtxNXhBUkNKMHpPeWlpTXRCOSs0Nndt?=
 =?utf-8?B?NXBBUW5ETHJsZEtqRTBTUGJsKzBPZm1LMkV5TDVRL2x6SEJ1Mzl5S3pVazNH?=
 =?utf-8?B?UXQvS0hMcWhjZXQxRXB0YzBTTzgwWHUvM2ZmWXR5U0hvWlJxenUwTDRWL0JR?=
 =?utf-8?B?b0Rwc21IemQ2cjgxZTJ3cWNaOHViT05pZWFRdys2V053elp6SDd2cXl3MFVq?=
 =?utf-8?B?Q2lERnBRUDBoYktIZVNWNUEwc3NlUnY3NzNCd0p2M3UxSENSeThqRFk1Y0E0?=
 =?utf-8?B?TGNyNW42Smoxc3FOOVFMOENQd2dnS2xUSERKd2hoWXlwNHRIdEQrS25KUTZm?=
 =?utf-8?B?TXhVNnpDcStGZlRqYXZhbUs0YW1JK1pMZ2pGaXZDSzdBWE42Q3UyWnVHUUJ6?=
 =?utf-8?B?SWdpTXIxSWpoVEprdWR6akE4b3Y3Q2x0VWpGQk1hVm4wcjMrZ3ovNlBLclp6?=
 =?utf-8?B?RTAzVlVNRVBDVlNCVklIQ085ZFUxOXdVTWlKaWRvNlRYMzNaeFJPeGlYbUI1?=
 =?utf-8?B?L1VmRW1XUVYzakZJdjRBaWx5MXc0ck1rSG5yZ0tJOVo4djN5Y3B5bXJ6VGhy?=
 =?utf-8?B?YVc2SWpzUzVIMWFWT29hSnZXdC9YanBTdWY0Wk9GS2gvY3J1UlVUbVE3YW5B?=
 =?utf-8?B?NDMzT0h1TzJmYjBoUmhyMjlHZ0NTMDlvUXdCSmxTRGZ1TzVWQXdKWkVyTVJV?=
 =?utf-8?B?YmVDVUx6UHN6Y05RdHBJUGI2aDc3Z3FlOXBLRVlHekp5UHhmYVJ5U21MYmFY?=
 =?utf-8?B?alJwSG03TGNveVNtbFdCeVdySEdZQ1BNQUJQMjZMOGZjV2FpbmZwZTc3a1Nj?=
 =?utf-8?Q?dbdPAJxQcIA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eE44WTZUaTVVOVYvaUNvZDI5b1FMV1BibTE2anpSRUR5emszRWM5Q3ZVNWc3?=
 =?utf-8?B?QmxOVW56N1pQci9td291VjQxbVN5dStpb2twVG9lZE9FcEkwdm1iS0dPSkd0?=
 =?utf-8?B?K2srbnRhcTgvTklOQkdPSmJqUGNGalVQclh1TU5QV0RzelEyUzg5V3RLVGN0?=
 =?utf-8?B?Y2JwUWJCRHhMSmUwQzRtNitCazNhTS92ZS95dnZDd2YwUkZRWG5xNDJaM3pJ?=
 =?utf-8?B?WWFiUWN4K09kd0JEOXFYbEVDS0N0SVp4RGJFRy8ybFhpeU9LL0hqTy9NbkdO?=
 =?utf-8?B?UnlnNDYzRzliN2NvMitSdW1mMTA4WGFSTjB2SU52R0doQ0VzSklMNndKcitN?=
 =?utf-8?B?aE9tMTl4RENYQWtEU2tYaUVaOTlXRDdtQkVoMDFCM3NKcitqd3d4REdqOEZ4?=
 =?utf-8?B?NFVidWZncjQ5c045cEhpY0wrQmFqUU9pdFowTkc3R3kzODdmTGJoRk12UTVs?=
 =?utf-8?B?Uks2d2FGVlJPSjMxc2lsZTlvWlNzbzMzOGNxaUFyTXFHWFk4RXY2Vmdockll?=
 =?utf-8?B?RzhmRXFyeXhoYi9hN1A0NVdiZTY5RHFaY0FlbVVwZllFeGh5RWVubUNVMkZ1?=
 =?utf-8?B?aUpFelhybjBtcldpTHFqYkNMUXE3MUtNYkJrRGJUQkhTS243aUY2b1RzZzMw?=
 =?utf-8?B?S0YvMHhMc0FWYTZsMzRGbGJJc0Jud2t5UFUwdU4zMTE5eU5tVzNxN3lkVU9R?=
 =?utf-8?B?VEZBQWFnYjNSYUd0QmtmREc1WUZTMHlYd0RKV2FxRit0K2Z1NVA0RzJGY0Mz?=
 =?utf-8?B?c1lKbU8ybG1QVlFDZEZhd0R3cUREQmZLNjFGUXkrM3NObFZIanc5bWFZenZy?=
 =?utf-8?B?a1FCK0l1ZVA4ODdEYXpPYTlpNkdiTWlRdW02SlI0ejVPZWROVWFKVFpqT1pK?=
 =?utf-8?B?aU5sRUFIbUVlK2lDMmdHdXBnK0NEM2d3b1ZKYXNqMldPTzlIclpqKzdEUHBk?=
 =?utf-8?B?ZHBrcXFrU3M3UzFZMjBLV3BuQ2E1eGxlQTIrUjc5S0luYVh2OHJZaEc4Ny9l?=
 =?utf-8?B?cEp2MU9VeWkxKzAzNkZ6WXhHUXg5cStUTkJNNk00VjM1RFk5cG9kQXh3VjhV?=
 =?utf-8?B?bG9OVk8zTFZINW1HY0hnY04wWnEvcWxsQmtBNHRyUkpZSnRKR1BmM0NoTHZY?=
 =?utf-8?B?WldhTko0amlwOEVkVUlIS3ZzWFZNUUdBbE8zZ3JFRG9BdE8xeWx0UWN1YU1t?=
 =?utf-8?B?WUlqNlMwTVNXc0puNnp5TjBScWZ5VGdGU3pTR2xIVExpN2VqUTJjKzlOdXpY?=
 =?utf-8?B?UGhINlQ3MGRkTHlOSDc4c3c1VEd1bkNkSzJhYWlmbDVUOTg2aXhzTThqRkEx?=
 =?utf-8?B?bHpONGNhcEhyOEZGdXlLWCtaZ3RnZjJHY0JoU3hLRXZHOVV2R1ZSTU12K0RP?=
 =?utf-8?B?OW16ZUdwRndRaHJLZHl3bjVUZ0ptY2FqQ29pSHJxTTR1YUFCYUVWMGlwM3Bm?=
 =?utf-8?B?Tyt5NkcrZnRQL3hoUnZPRkZRVjY1MGJCb3A4SVFuV2IzdTBQZ2t5MVNoTHVO?=
 =?utf-8?B?TE5Jb0JsVXd3UGkxZklHRjhSMm54VGQ0Z3dIbm9MeXVOZ01hOTdURmM1dWRm?=
 =?utf-8?B?N0MxZTZzZWJXVElyaVYrUnZnWlJITFJ6VFlnUVNZcWsyNW1wZGRCN2FlL2J3?=
 =?utf-8?B?cldyUVJJZTdydXFSYW8vb2Rva3R2MGtrUmU4VUxncmRtUThQWkRtdGszNnIv?=
 =?utf-8?B?Uk9GaVk3SWYvMHNVTnFPZFc5QktpcDdZVTM3UnNFS0JtNU84eDVnVHBuN1E0?=
 =?utf-8?B?eUFZY09iMzJsaFgzWmJwZGhYYzVuSWNBckNvRDBqK28rcXMzWWhGeExUWUF6?=
 =?utf-8?B?Ym1lR2E4OHJPc0ExMFFQUGR5R0I0R0RFT29EZHczNVJPUi91WXQzRjNZMG5p?=
 =?utf-8?B?ZCtJZGh6OVJ0R1pwcWROY1h1NE9HWlp5dGJxckx5K2drMERsaTc1dENwWVIw?=
 =?utf-8?B?aGk4b2ZiRFg5ZkpUMDVkY1FFcEREYlkyeFJNQStSVGJ1V2ZUeFFuejVXRTly?=
 =?utf-8?B?MVBZYUVwSWhnSi96M3poOG5PWkRHVHBCTUcwdnhXZFhqOWlnajZjb09rcGJv?=
 =?utf-8?B?eWRna2Y2Y2IzN1pDc1V0YmtzVHJHZE5IVUN0U1I5R2dHTzdKS3JwT2llTzgx?=
 =?utf-8?B?Vmw3eGQ2WWRrRVlCdUo1OHFCVWpNZFBsMjBvbElOcW5XcHgxeHR3SXhNVTky?=
 =?utf-8?B?Nnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WqCNUQHo83yW8OsWFCrFrngP78daQHFFCicXvjVfaRedRB09qmy3cfe6wY/5vfIh3fpvte49q8bPp/3xH2prm7T401axX2zIzg4RWketU6G37vquIQCR1OXNmh1PgZoJQLGbFgsaK+wUAccXT1YqiBoZFPWOyhPwFq3kn7m8bh9Hajsf4FlEumOBjoNQUmZ88y+vYi0Zaxn8hCJchfxGfG+XGZNUatuzbCz64/5xiJIAoqchauNvODsS6iybYS+FY1sepxADaHuGBFK2ChuiPNeE9LvGC1UIgQJpi8uyFX9ZqmqGpiIKH0c97CwYDnSenD7fzOHX0Q12PAX0VL3qXvB2+lxuQz0klwCimaxXcbW/PGJfhOGqNW7w32ZUrXG9XmCD5CS42e9m9/l0ObCSheJSb3N2iaP7ongxLERIWCPsJ2xWnkvOLog3/Zq36d+9BL8pjrcq8TD2H2bM5E6P4nVwNuUpFWFF+SmwxWXRtx8U6Utwbm9JVqlb9CSqHrAjZ951vnJRqys82IlTXtYjm2eOF0RmY0pJ2SfTDNdT06hA+WfqB809aD/9HQ3KhkLCaOjbfR/6KPVZ1ILIzPHK60/kHrm7XPhvQqD2+EZoNcA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dd9cce2-09d0-4463-393c-08ddda6dcf11
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 13:32:11.9506 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qpZg/lwoZlr/HuLjvDE/IAosRwrA692/3vuO5hauiKKOM7859WK4uTTpXhZma9ObZa3ZU0pyyOoqP/8R7qNu6ArKGaPgh6tDL9McbC1j4XQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8101
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 bulkscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508130127
X-Proofpoint-GUID: qZBsTkuu9shnUfw5Uy2mFrvJsS72zBuS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDEyNyBTYWx0ZWRfX9D5+qqptBhm1
 kcQYLIVAZtWGn7UFN++7/GvnYTG2N+qLCUHaR5bnBZDfZwlmTqIA8BFw4HB+GGWSF7NXB7LtYuD
 gfF36bGTMkQ1is9ndgiJadTe3e/35lg0nyDCsO6nmotyngGjQ72nAifE7fLeLWK37agJfTkKzCq
 4646Jmp3bSulMBVsp8sI0Raw2rr0Iq1jZGg18VcM7855vz9WoGr1G2hdIsyucuTEKlQP/LfWemb
 gtgZSn9B01pYW6FH3S2CmRcpqV3LfAF0WGgxDbiDrhEGuPirCNNgCw428fa+0ORf+K2otXhqzpK
 YMry+HVLM4uGgtgjke66uq9ONtX/2jjYSkpLMZkrlt0hbj7+RFqw0/ExA3qYUtJTdY+pGEv+a5v
 yRRiEL/Qh9IZ0pu/NJMBOLfHvGeF+1trC6kdtPDx2sc6YqAztcuKjEX3B+zB1DPIWbtidxLX
X-Authority-Analysis: v=2.4 cv=W8M4VQWk c=1 sm=1 tr=0 ts=689c93df b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=SnNqIvHbI4iWGIU94QAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: qZBsTkuu9shnUfw5Uy2mFrvJsS72zBuS
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Peter previously said "looks good" but wanted a sanity check from a
live update maintainer, which Fabiano provided.

So, which maintainer will pull this for 10.1?

- Steve

On 8/11/2025 2:19 PM, Steve Sistare wrote:
> Close a race condition that causes cpr-transfer to lose VFIO
> interrupts on ARM.
> 
> CPR stops VCPUs but does not disable VFIO interrupts, which may continue
> to arrive throughout the transition to new QEMU.
> 
> CPR calls kvm_irqchip_remove_irqfd_notifier_gsi in old QEMU to force
> future interrupts to the producer eventfd, where they are preserved.
> Old QEMU then destroys the old KVM instance.  However, interrupts may
> already be pending in KVM state.  To preserve them, call ioctl
> KVM_DEV_ARM_VGIC_SAVE_PENDING_TABLES to flush them to guest RAM, where
> they will be picked up when the new KVM+VCPU instance is created.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> ---
>   hw/intc/arm_gicv3_kvm.c            | 15 +++++++++++++++
>   include/hw/intc/arm_gicv3_common.h |  3 +++
>   2 files changed, 18 insertions(+)
> 
> diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
> index 3be3bf6c28..5e63e69e14 100644
> --- a/hw/intc/arm_gicv3_kvm.c
> +++ b/hw/intc/arm_gicv3_kvm.c
> @@ -30,6 +30,7 @@
>   #include "gicv3_internal.h"
>   #include "vgic_common.h"
>   #include "migration/blocker.h"
> +#include "migration/misc.h"
>   #include "qom/object.h"
>   #include "target/arm/cpregs.h"
>   
> @@ -777,6 +778,17 @@ static void vm_change_state_handler(void *opaque, bool running,
>       }
>   }
>   
> +static int kvm_arm_gicv3_notifier(NotifierWithReturn *notifier,
> +                                  MigrationEvent *e, Error **errp)
> +{
> +    if (e->type == MIG_EVENT_PRECOPY_DONE) {
> +        GICv3State *s = container_of(notifier, GICv3State, cpr_notifier);
> +        return kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
> +                                 KVM_DEV_ARM_VGIC_SAVE_PENDING_TABLES,
> +                                 NULL, true, errp);
> +    }
> +    return 0;
> +}
>   
>   static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
>   {
> @@ -890,6 +902,9 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
>       if (kvm_device_check_attr(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
>                                 KVM_DEV_ARM_VGIC_SAVE_PENDING_TABLES)) {
>           qemu_add_vm_change_state_handler(vm_change_state_handler, s);
> +        migration_add_notifier_mode(&s->cpr_notifier,
> +                                    kvm_arm_gicv3_notifier,
> +                                    MIG_MODE_CPR_TRANSFER);
>       }
>   }
>   
> diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
> index a3d6a0e507..75bbc403c7 100644
> --- a/include/hw/intc/arm_gicv3_common.h
> +++ b/include/hw/intc/arm_gicv3_common.h
> @@ -27,6 +27,7 @@
>   #include "hw/sysbus.h"
>   #include "hw/intc/arm_gic_common.h"
>   #include "qom/object.h"
> +#include "qemu/notify.h"
>   
>   /*
>    * Maximum number of possible interrupts, determined by the GIC architecture.
> @@ -270,6 +271,8 @@ struct GICv3State {
>       GICv3CPUState *cpu;
>       /* List of all ITSes connected to this GIC */
>       GPtrArray *itslist;
> +
> +    NotifierWithReturn cpr_notifier;
>   };
>   
>   #define GICV3_BITMAP_ACCESSORS(BMP)                                     \


