Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3325BCD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 19:07:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbjyk-0000i1-Ug; Mon, 22 Jun 2026 15:06:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1wbjyh-0000cw-0q; Mon, 22 Jun 2026 15:06:39 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1wbjyd-00038p-VR; Mon, 22 Jun 2026 15:06:38 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MEKBoe1950322; Mon, 22 Jun 2026 19:06:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=jvCwTkv7jJNyukw9+D9YQIwXUfcQNXWaFrAW2RZ6zHc=; b=
 Y9jOtkxBf8dbKqIpFFnxAdjCXiWPiWYl4Hyeawgd1pHrDCvdzHHUb1QZubkxbOXb
 MFgxioJ5Ud8awCCUJdeEA7oZ1fDnLUXnVESEswezVC999sxSFxAzbv7z9J0FWuCy
 acxJ0/PcZYlV+t92ExAVRhkauFbXsbBWFPcBzl/kLHb/LQN408lCuLE9dXJIewYe
 9tvxZjwH62bS28PHTiWCIHt7ETCWXDLvWQag0or/0mQ9lH71BhXRVKuBN3TfaS/5
 fiEJ1tPjANRbsLS/QTiaxMcOsGdKs1oLruL9waMoVcyFdWt1HXfO12Be+FEY0Jq7
 oYfQbXkWkNXWNz8ZNVuNBQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ewhs92kcc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jun 2026 19:06:25 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 65MIwAYY010993; Mon, 22 Jun 2026 19:06:25 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11011020.outbound.protection.outlook.com [40.107.208.20])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4ewhab5vjb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jun 2026 19:06:25 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jHLT4uakVdN+E6EdquBcCRj1bV2YnFHQD3liuX29l4SryFR7YI7/EY2TdqUVneRSv0OISbUXelFcdmU3adE3qRSI6XTU+R9XPs91fmoG66pWug6VGYg/l+21pYIUs6u1lfqGRivPW51aFOurjTdJX1PCdP4YsKPX6Xr2dXzps/88E0LUvk7qVjr6Ipcy2NeDVTo04hNCp8HUWorOi37dsQ5v4sLrGTCcVbQPIJzkZRC3PZ6l+2w7z+EF2DNj2FDl9OJGkivOXqaa11uQ1YKw8XX5euxwvwy2w/cJLFFbW5byQcNonLkjUnv9l9UyvafXrIrYGPfYLTUIH9KrmkuZWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvCwTkv7jJNyukw9+D9YQIwXUfcQNXWaFrAW2RZ6zHc=;
 b=zNX0Z1Uvwgoe3TvczcvXgVUh8znTzDizOtB7QSxOXBdVbWOo+FV81hzISh3uSQurYWzZxlfnpu/dQ32WhZJUppK6D1QJvU/QaOs627wn/Lm+0hY1dv/vfuKeZIkeCZ4Zu8aMl9VS7dWmHOlsUdx7wpYBdATSeB2ltjL/J9gotwGalYqaXP+5LEaxgpn8e+YMklwSFut4xwXsdMybhdpHTgzYcJb2MDg5t9xUEUFA/uyveE9sbpM6jwIqIkKtomHPnujoezjULwhyCtoBbZo6yXXvDFAFz2RvbWAgQHJpdTn3OQeDDODw7RaaH8925jcMt6qZQW85whC/rHf/xCl05w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvCwTkv7jJNyukw9+D9YQIwXUfcQNXWaFrAW2RZ6zHc=;
 b=Fmv0jFYqlVpnQ9gC1pPRc+1Mg2uWml8Bu/iFnLmOqFWP/T1yxbJJZ0B/1XNmn7BNiOsw9ho40dNY0D5iyS/YOY35RJ61vP6napZ50hTqajA51y44BC46ip/QBlKUaPt4pQgiJRxgQjH9wkuzbr35OUthvttaJRtP1bR4myg5MrQ=
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by CO6PR10MB5620.namprd10.prod.outlook.com (2603:10b6:303:14b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Mon, 22 Jun
 2026 19:06:21 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%4]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 19:06:18 +0000
Message-ID: <e9a7ef01-f836-49d2-bec2-49992fa64d59@oracle.com>
Date: Mon, 22 Jun 2026 15:06:15 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 063/106] amd_iommu: Follow root pointer before page walk
 and use 1-based levels
To: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 David Hoppenbrouwers <qemu@demindiro.com>, Sairaj Kodilkar
 <sarunkod@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <cover.1781463125.git.mst@redhat.com>
 <786550e2d38a92e90c13eb9d57e3a72d7ab38d51.1781463125.git.mst@redhat.com>
 <CAFEAcA9ykhWZWDhtAonpRnc=LYDwN5S-vqO4cUdtx8AemcPhfg@mail.gmail.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <CAFEAcA9ykhWZWDhtAonpRnc=LYDwN5S-vqO4cUdtx8AemcPhfg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS2PEPF00004557.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::511) To BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|CO6PR10MB5620:EE_
X-MS-Office365-Filtering-Correlation-Id: cdc37710-5643-4475-0690-08ded091571a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|22082099003|18002099003|3023799007|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: 9ziSAHyBcTvOYWjhuW6Mg45McIAdDn4HdWwx9QcyPYNZq8fpxUfNvGO+2Hjx913Qds4KeKklL7wlbNe5fl6bxKVpfM/NIZRRNqn1yzwDHPvA7M9njbQCyvXh9wi0iBB5jvqEm8InMF5idsGnfimiHu/U/S3lyP/cZQSE+ODCU/zBm2WZJW+Y59ZNds9FhkhnbF7XsplKjP/nwFGXAFanp5jQjo/dW/LM6aafj23y2pgT0ZkRk9m+98M5cnRKZcXGCkUp5CbnMxAn0yZyyAi+Cgy+/K/nfhNfV/98doQNbzcINNwsRivkv+aEJe01tVoogXOISoKMPM9uENhYErK1xDSrSawNiwzuUl5V4WUmlou4ekj25mUZxdPUZyz/7GABqYEL8JTSR1D8GZHuJVeRH92Lg/fITf6nrASX567spzSMvONDn/RQhQtSZGZOWN3FPqUlAPZXq2JsY9rSLlPRYfA4W5oZ5AUA6YAZ5y7wXX/oSrSiPZ3Blo3ckPA09csa8FWHezuWEL8uhlCaiDnxkwT941C54vrthlDLQPJ9PYch7tqsB8v6oFdTyCovOVrmI17jSynZtmXvzg5n/ElIfp5JrnkIFANZ+8w2jiZXhbCBEnNvfee9cDTqBWbfBMOakXup6ygYO5LdhqIH3ZvL8AhOWWHASIAfM0xuTyh76Pc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5041.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(3023799007)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ME8yQ0lCVHozNGxqcGQzSTNic1VFc1NPZWFDMi9WYXI3VEVCeDJ6UUliL0lQ?=
 =?utf-8?B?VWFWTUg5VFdFOG1KMVNwcDB1emkzWHRqNUtCRjhHVkRlZDg5UnBENU5SVHV2?=
 =?utf-8?B?dHBhVk1vdTN1Z0J3aGVLTFpPbTlGY2lUWDZadU0zR2RqUjJXNnBETHVnWHdN?=
 =?utf-8?B?Rlg5UTJad0psVHNML0xicVB5SXg5aVZPU1pqT0djZm1uMUluNTByMzAyZWNs?=
 =?utf-8?B?MW5nOHkxZjRFRXBpNGZsODVyMHZqTzE2TXBlVFVidHhHem9RWUE1U2dEaFFZ?=
 =?utf-8?B?Wk5veTRkVTJibEJQQkNnbzh3aFVjQXZUa0syNnVGRTcxMks0TUl1OWVzVm82?=
 =?utf-8?B?WFRWeHlUNXlCL0FyNkNNdlpHTEdFNm4yRzF5ZjE3bmhwUFNCWHVOa2REREpO?=
 =?utf-8?B?QlhSTkVZRUwvOU91OGZNYkdzblYrY0ZHK1hXaXEzZ0ZmN3dGSkg4OU5wWHRa?=
 =?utf-8?B?K0NsZUs1U1FabnRYdTBuVllyM2N2RWJGQzVEOHEyaHAzZHFDcFZianBqOFNU?=
 =?utf-8?B?d0JVZ25JbGRBUGxEbFlRVDdCZ3E3SDI5T2Evc0lLZnJkRHIyZnZGTjM1SnRM?=
 =?utf-8?B?Ym9mRzB6UjhzdUM2Q3ZPdGNMczlOdnAvbVd4TWlXVUp6SEJ1K3c2eHZtOU9o?=
 =?utf-8?B?eDAwK3NSSnhobDc1U3ljMElPQTFYZFFUcFNkUTVqY1dIMGh2cGVTRmZLWjRw?=
 =?utf-8?B?a2JQWWpMdXNzZzcreGpCek85RTNLV3UwbXdRNGlIYzZuSzV3R1luQkZtRjFY?=
 =?utf-8?B?ZzhFMVF2WTEyQU80MFJNa3VudDBuNXVEZ3d0NWE2L1VTc0dtN01rSEZtSWhO?=
 =?utf-8?B?Q3BRSVg0Q3lkcVd0Yi82WVErcXRzbWo0RmtHdCtpZFVwQndJMUY1cFFrb1FM?=
 =?utf-8?B?WEJvdnlxL3pQL0h5bEI0TitJNVdsSVJmZUhFeTZkeXRmYnRxZS9zUkRNeVhh?=
 =?utf-8?B?bmU5dVAwbUxWRkFlY0FCbEdyQ1JrVElyTTR4amhQNU42MW5vOVE1aUtBaVhQ?=
 =?utf-8?B?aXRxUjFRVHBsYmZTNk85WEJrKys0TWNobmY5TXBTVTFoNytqLzV6M0wwODJJ?=
 =?utf-8?B?dVZMbFgzMGVlSUs0cWtIaFBOSHRNWnhWVjJIc2J6bkpBMU1WcHR5dTUrS0RV?=
 =?utf-8?B?SXA2UFVpRWJuU2h4RytnVGhHMW5MZ2VKYWNqWWs3SUQ0bm8zRUVYcG40T0th?=
 =?utf-8?B?ZmZ4MHdUZ3owUTJzenRvM2p2dzB4T2Q4RkNFclFQcVB3QUZRZlp0YmFGNS9B?=
 =?utf-8?B?Z0ttUFBMYXlFbkNtQytCSlp1YUlMR3R4WisxL1lWazV1WkhVL0tXamlFdU5v?=
 =?utf-8?B?TGQzRThtV0l4c21XOVp6RW5Pbnc4Qittdll1Zi9GYSt1bDUrZ055V2xhZVF6?=
 =?utf-8?B?bmcyM0hoaGhmK29VKzdDQU05Zm1JY29WZHFtSVNINHo2RGFZa21sdkRqcXdq?=
 =?utf-8?B?Q3FJcU1zSlYxbE94b2trTWZjTk83VXAvWHR1YWc4bm1JaUowT2E5STNwaWdF?=
 =?utf-8?B?OVhEamI2OEZhTnNuUHp6SzBRQnRvRzlpVEx6OGtXUzNFL2V3RjA1R0pxeUY0?=
 =?utf-8?B?bHR4dWk4UitNL2JkNEl5Yk1sR3J4WXNpVlpXYkRxUUVubzUxMURjbkp0SEtm?=
 =?utf-8?B?TjlqMTRqRkE5ZDI2aFYzcW1mMGFOK3MxZUZIMCtuaXozYldvS29WVWJPaURF?=
 =?utf-8?B?WC9wTEhjR3VucWptYjlZNTVBKzdWcWI5WFRNRUpyS0FDWFJhN1hINm5KYUgw?=
 =?utf-8?B?TWpNdmNaRDl6aENnT1JVV2xKa1dJQjltSGV0SlI0Umc0bXd6TlVmZGh5VlB0?=
 =?utf-8?B?cGVoYXlJZS9TQ3hNU1c0TElFMDIvMmh5N3M4MkZqYnFKcW53bjlqcmdOaWcw?=
 =?utf-8?B?K2owci9NNDlJRE5aQ2l2dStwajA0YTNQYUJiTnJEZ0JkZEtlVGk3eWVqamJn?=
 =?utf-8?B?UC8wSDNEKyt1czdEKzhWaGp1MitCOWVHSzV4UUZwSGtaSksydExWRHcyV1hM?=
 =?utf-8?B?VExYVkZ6WUcxb3lZdzRUT2xFV0R6VUFGSk5YTDhWRnU2RU5aZThabWhSQnpE?=
 =?utf-8?B?Ly94YldFbCtyL1BOdVYvQnkrcmZOcDBJS2Z3aXphSnlpdHp2TS94OUhmNk0y?=
 =?utf-8?B?MHpaRmsxNnJtNFF6ZlZUYWI0aDlZV2s0dllqZFhwNURGclA0aVU0UnBEd0Vr?=
 =?utf-8?B?TUlkNXJMV1lVQ1Y1ZVJPY2FINUlMeThOc2VLVm11d1l5dE0wTWVFY1ZqcFdR?=
 =?utf-8?B?WTFBeFRzTC81SEZDZ0F3RzJ5SjZVTWVPa3BnNC9jL0JXcHM0ZDFQclprUWk0?=
 =?utf-8?B?amtFWjE5Z2lkQzdhV1RZU1c1YVY1UTRiVjVqS1VvSE9DbjBPNEJPYnlWQThW?=
 =?utf-8?Q?yKsdRTkIkSNhcX94=3D?=
X-Exchange-RoutingPolicyChecked: aAUPTRN2TQpqGAIwBzSYp9A0QmwEZqNlzM4XOsdOrMrYwuFPCM5nYr5PMQqkqm0r5fWnyGFLCFt1gyYzBmgX7OW/qvXHgRdFNR9tciG21n7wWARtP0zL/5vZ7XLuNlUzvG/rB8IJ5YbsEXRnk+LxdZ9jijnZrpuG4fnSMC4M+H6yWFtc6h30wv+jRfHPTarl8tMY3lHG8ZKveLxdb8u8O9h9VgmcWl55cVp75eK8/ry+qrgaVu6sc2JKwxP5HmDTMI4fMIl3RI/oDzETb9PVbV5+BIto/blhhEkR+U3cgJZmJb2CMRUC1AcB1pl7Qlzmz/M0iocPDwJ7XaUfadQBtQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6TuilC4q41coxfh9hhXKP3gLHGpc+6bSudIoSlx3/rgiF4J36bjvdu/h45OUzv4tJTHWqZEpSC6d2q9bQ5oYQvNC4e8a7v7b4eqLcTzd08AthAMKQD9CjwriQdk25Kg/Rl5Ah5bZ7UEXzlTLWD+aw6DS6/bd3mdckRQ/3Dw7NRfh1SRiE0wZl0WlrSUY0ZDDrjYdSIe7tg3UK1xun9zvE6nRGddvmnljBo4m+oORQJArszihzba1LjGne4qwfaQrRDbaE1xLv01qTRb/D/HiCm1cWGtrbOvurgSIaGHFiknUIwdIS5muuWCdj7rhY7SqO345SEJQzRxBwLq3kUL1GzOeftp0xWUTjuOqJ4goEjNrxhCe3stERqklQYT5EfgSlfQNxWRXE8pY0dsXEjlcE7sE8d2yBxaEpYrv0VUjJmBcfPrQNEyjLIhEch79FqGXoyxdpQa7qyzrgWvQeI8TM9ex4soFeMHb6I4dyVzHkxuEqzixifeA6VqlzsqSlwsStrsSyYCinAXgI03vTkE97qa8JIckPmqDqEBRZTIXNgmoHhQslOIBkFSKMvAZIBg0wWoX7gAh1mlWCI50ZWRFWoLKHw9q5ZPDhbuRroY1iqY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdc37710-5643-4475-0690-08ded091571a
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 19:06:18.5280 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LY+zp/CEqJYjPj245G9RficmsHLGXBcAspcKxENSSjKd2T0DpXvt7zLteU2kNBumK1zzxG6Ud7w9jE6etSl8wW+RHA2/HE3eSTC9uAjjuds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5620
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_03,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2606220185
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE4NiBTYWx0ZWRfX276pqdSuFdjI
 P8tmsYZbyCmH5XPxvzv8PIK3UKoKZgWtEZTkjlrj/C3ywHDsQLq2z3IUJ+ZFMq+vE4iQrtHaDDo
 DZ1EaI5eyFcbbudBN7aca6+28pzkNZw9Mz3HCY6V/xeAybayuSpHXPiwtUykRnzAC2A95cT1F+/
 KYshCe4f0mSZS+8YCctv6PetKZmxCF03Fu/B9uskVEs5MXqvxX2HlwVptqWGTqk5KT42JvnR8QI
 Pcey9IVcgl5K0pxbhOpMKjpwzbV/aB+UB2oqtEoV/US1Iwd3H9Emrt/zO2zmUSfz2y1+IvTHIdh
 ek6F4c9WOk9eedAV7ypT4SQDVs8MF0RB76kP41thBNGW5bW3f9YjBo/zJi84HKOweA/9boaShBI
 8/z65tjGOLM2ptyuhTZhsA8NlPoP+iMS6fs4RvK7Tezl/esQ/rccLyV+nHRkvggdw3D0a9w9kVL
 0R4+ST1FVpH0T7XDq3Q==
X-Proofpoint-ORIG-GUID: 4SoNJVVPnNxurZl7DK0QG-RlvNNLLdAU
X-Authority-Analysis: v=2.4 cv=Wokb99fv c=1 sm=1 tr=0 ts=6a3987b1 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=20KFwNOVAAAA:8
 a=yPCof4ZbAAAA:8 a=kfyqPqQUNe4R-XWZ4nIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 4SoNJVVPnNxurZl7DK0QG-RlvNNLLdAU
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE4NiBTYWx0ZWRfX5HA21yfQHxSM
 lx6UYgebxKNpVcdL2JyAbhgpY0rzeSkuBqFaTDMBbfpDJ1A5Z8B6jfr/FnjAI63uo44h+mVcLSJ
 b1VgQNVowFkOVdevThGnISdS8/iaCZynL+D38X3zyMyT1xA7zJxb
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 6/22/26 11:03 AM, Peter Maydell wrote:
> On Sun, 14 Jun 2026 at 20:08, Michael S. Tsirkin <mst@redhat.com> wrote:
>>
>> From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
>>
>> DTE[Mode] and PTE NextLevel encode page table levels as 1-based values, but
>> fetch_pte() currently uses a 0-based level counter, making the logic
>> harder to follow and requiring conversions between DTE mode and level.
>>
>> Switch the page table walk logic to use 1-based level accounting in
>> fetch_pte() and the relevant macro helpers. To further simplify the page
>> walking loop, split the root page table access from the walk i.e. rework
>> fetch_pte() to follow the DTE Page Table Root Pointer and retrieve the top
>> level pagetable entry before entering the loop, then iterate only over the
>> PDE/PTE entries.
>>
>> The reworked algorithm fixes a page walk bug where the page size was
>> calculated for the next level before checking if the current PTE was already
>> a leaf/hugepage. That caused hugepage mappings to be reported as 4K pages,
>> leading to performance degradation and failures in some setups.
> 
> Hi; Coverity flags up an issue with this commit. It won't have any
> practical consequences, but it does show that there's something we
> could clean up.
> 
>> +/*
>> + * Validate DTE fields and extract permissions and top level data required to
>> + * initiate the page table walk.
>> + *
>> + * On success, returns 0 and stores:
>> + *   - top_level: highest page-table level encoded in DTE[Mode]
>> + *   - dte_perms: effective permissions from the DTE
>> + *
>> + * On failure, returns -AMDVI_FR_PT_ROOT_INV. This includes cases where:
>> + *   - DTE permissions disallow read AND write
>> + *   - DTE[Mode] is invalid for translation
>> + *   - IOVA exceeds the address width supported by DTE[Mode]
>> + * In all such cases a page walk must be aborted.
>> + */
>> +static uint64_t amdvi_get_top_pt_level_and_perms(hwaddr address, uint64_t dte,
>> +                                                 uint8_t *top_level,
>> +                                                 IOMMUAccessFlags *dte_perms)
> 
> This function returns 0 on success, or a small negative number on
> failure. But we have typed it as returning uint64_t.
> 
>> @@ -662,40 +708,49 @@ static uint64_t large_pte_page_size(uint64_t pte)
>>  static uint64_t fetch_pte(AMDVIAddressSpace *as, hwaddr address, uint64_t dte,
>>                            uint64_t *pte, hwaddr *page_size)
>>  {
>> -    IOMMUAccessFlags perms = amdvi_get_perms(dte);
>> -
>> -    uint8_t level, mode;
>>      uint64_t pte_addr;
>> +    uint8_t pt_level, next_pt_level;
>> +    IOMMUAccessFlags perms;
>> +    int ret;
>>
>> -    *pte = dte;
>>      *page_size = 0;
>>
>> -    if (perms == IOMMU_NONE) {
>> +    /*
>> +     * Verify the DTE is properly configured before page walk, and extract
>> +     * top pagetable level and permissions.
>> +     */
>> +    ret = amdvi_get_top_pt_level_and_perms(address, dte, &pt_level, &perms);
> 
> At the callsite we take that uint64_t return value and put it into
> an "int" local variable. That potentially overflows. (In practice
> none of the values actually returned will overflow.)
> 
>> +    if (ret < 0) {
>> +        return ret;
> 
> Then we return that 'int' value from this function, which extends
> it back out to uint64_t again.
> 
>> +    }
> 
> Since all of fetch_pte()'s callers put its return value into an 'int'
> local variable, and fetch_pte() is the only function that calls
> amdvi_get_top_pt_level_and_perms(), I think the right fix here is
> to make both amdvi_get_top_pt_level_and_perms() and fetch_pte()
> return "int" instead of "uint64_t". Then the type matches what the
> return variable is (0 on success, small negative on failure) and
> also the type of the variable that all the callers put it into.
> 

Thank you for pointing this out.

This started when I initially introduced fetch_pte() as an unused helper,
returning the PTE value directly. After feedback, I changed it to return an
"int", but a later patch in the series accidentally reverted back to
"uint64_t". Then I repeated the same wrong pattern in
amdvi_get_top_pt_level_and_perms().

I'll send a patch making both amdvi_get_top_pt_level_and_perms() and
fetch_pte() return "int".

Thank you,
Alejandro


> thanks
> -- PMM


