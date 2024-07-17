Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A56C3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 15:35:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU6h3-00070i-41; Wed, 17 Jul 2024 11:35:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sU6gr-0006cq-TD
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 11:35:39 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sU6gp-0005DP-As
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 11:35:37 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HFUoBE010027;
 Wed, 17 Jul 2024 15:35:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:from:to:cc:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=gsnKGU/Oxoqut2DF/NC5RgOCdMhsNMg5xJ++vxfRO/Q=; b=
 n2FPhLc0v/vE3OmnJUpNAtsVfgQ+hRgELigq12aMM2WWPv+N9WAHD2agCYmz4qmW
 RuBdEYpnVzP2WNlq5v4GHyuq+K1h0USJMMjz5nQflufWSfpIZASXodaVXWxqBOm8
 BCkG9uw3+u5rpC443QDv074KPu/UHfkDY7NqagowaL5yL6iITYasflc8rN7AVReb
 azPNDWhwpIkn2DoINk2cmerzjQYK1c/iCjHuG5Htyuq3AX9wp0MvNi9hnkr9Y/G3
 GssZPEIYe8ezBokR1EMtEruXGgX5K8qARCF4MYg261vfJyiZfmE6Oq6Qo7pb3QaH
 cKUENa8fUnv2s/z+5ZQ26A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40egnfr0d4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jul 2024 15:35:32 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46HEDk6J006877; Wed, 17 Jul 2024 15:35:31 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40dwexqp2v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jul 2024 15:35:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TZf94sWQWB4cgoMRkqzq9spJ6RflQqrDZdw1TFv2DyXMYgtgrjILlxCnFZLVIfpK82TcPvTvG0YwgpuOjaMHxsvipKBZoOA3Z4E0l6ZJpHU5ETbj6fsc39cRartub7Jw2goO0pKjTCsSaikVqIcXx4GiqTGXX4mGRMKiVEdJl6tTCdTVhKAg/7ZQ1Y0AlwPfw4BGzy7gzLgMpAJwN/jHmJUgo5gLF47QkaD8v1P+kAuPcXzZqxFWBj5s2XRg7H/i3Xe+Ama1lKUGslNrYgVGOb3BrsI3h6cEVDMrKvgNjZasbk6H4IEa7JAgrMTW1HzmvU/lNyvN8PjthLRlW84BSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsnKGU/Oxoqut2DF/NC5RgOCdMhsNMg5xJ++vxfRO/Q=;
 b=zKPVhAoNxViBrYCZXqtPmNW5CKSRY/xH8xNQGEJ2kxPbxlQvRv+KJOJX4oQy6FZnaUjWwa2oUPpbDJQLafVA5bS0OtwY6kiIeLuXoJmSiBpMlauNgfYVbfI7Rr3jyaVz4mD+yZbG32O98htJkw8RI92Rt7GwX8IbtAGd9JU+w0n5+ONbwc9s1IHa6J/B+1Sw/FazRqdghzsyQO5ZcTNlpPtkP4+AKpvwSCoRSdCpDYDtQZmKMhekJSBw1wXLJT81ybEmmPDXqcYZ93lHA/kXen9sBF4j2Z7qMX4FvGuStOFuD/WVs04WC35704WhkfX/Zje09HI/eSNPZ6HHmgb6Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsnKGU/Oxoqut2DF/NC5RgOCdMhsNMg5xJ++vxfRO/Q=;
 b=V1QeiOtuLBDEbhrm7IMcfMqAutbltftEVLx6szPfBfjQpgXmamJ/leuVTbTjiNuHwyhymeJ8skBgKF1+n7NP9qVKz1azwtiGa6jnB/p60XXTHaoJdamBHlX4JwtQrt8x7s6L673jarYbXa+VxSHGbIhhpTncMLYH6gNHu4M0mIo=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by CYYPR10MB7627.namprd10.prod.outlook.com (2603:10b6:930:be::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Wed, 17 Jul
 2024 15:35:28 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%3]) with mapi id 15.20.7762.025; Wed, 17 Jul 2024
 15:35:28 +0000
Message-ID: <4e69e717-04a6-482e-9cf6-da23a9dc80a4@oracle.com>
Date: Wed, 17 Jul 2024 16:35:15 +0100
Subject: Re: [PATCH v4 11/12] vfio/migration: Don't block migration device
 dirty tracking is unsupported
From: Joao Martins <joao.m.martins@oracle.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
 <20240712114704.8708-12-joao.m.martins@oracle.com>
 <SJ0PR11MB674456F8871EAC781732D0CD92A32@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <da65c43a-ddca-4d47-bfbf-274e8062c56b@oracle.com>
Content-Language: en-US
In-Reply-To: <da65c43a-ddca-4d47-bfbf-274e8062c56b@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0209.apcprd06.prod.outlook.com
 (2603:1096:4:68::17) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|CYYPR10MB7627:EE_
X-MS-Office365-Filtering-Correlation-Id: f9a4d92d-ff12-4b77-3b36-08dca67615db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SGF3SEZrUHE3UjFIMlZCYUNNZ1RYeDZjVzF0ZFVNNUdYRUxQYUtqODhTMlBj?=
 =?utf-8?B?SlpoZ2o3QmdETm9zOHlWaG5qS0hHcnpOc21zS3YwR0VUZVJMMjlCemkzMkRY?=
 =?utf-8?B?MHZOZTJkaWlNMnV1MVJVMUQ4YjdyaE5VVEJyc1JBTkhocDFlN0l4T1U5OHky?=
 =?utf-8?B?V0dlVjBYenRyMUxJdFI1d0lEaEtDOS93SlRBSEl0dCtUU1pJL05PVGNMUG0y?=
 =?utf-8?B?Qjk4M3RXelVnN3pXejlTU2tiMHVqMllHdXkxanUyTHZDTk9SL0Y4b004cW9P?=
 =?utf-8?B?anJlWXlXNmtBK1dSMmN2TW12ZSt4UXRvTWFPRllHLzBLT2h4ZTBIQWlxRHY3?=
 =?utf-8?B?cUJUajVoWFN3M0N0aFMxeW1GOG00TkhnaDFNa1lnUVVvRXgxSDRGSVcyVklh?=
 =?utf-8?B?UERrUFRwZEI2MEhaUnYrR1RvMDJaSENhWDZsSEpuYmZ2ZzJBYWhTeVN5eDBm?=
 =?utf-8?B?VE5vRHcxaE5VWTRvU0huTk5mQXlEbEJTREovT0VzVXlJcThBM0dsZE9reG45?=
 =?utf-8?B?dFFVZjY3SGpYTWxFclFmTEVOQllNTWNhTXBEbDZsQWVFTGVrK3Q4WGllaklZ?=
 =?utf-8?B?Ty85c1Q4WnJ2WDB4ZkZaYjRsRHF3L1RsdDZDU1pTWUZrWTBMd0RxOXIxWjQ5?=
 =?utf-8?B?VmRYLzFEa1BZSzlISEcyenQ1eDBXck82MVI4aG5WR2NWNGsrTWlwcW5BcHBB?=
 =?utf-8?B?aFpURVA0dHN4T2Ftd3JjdE4wV1c1OEZ0TDA1MzVKQW5ObnJhYzZ4cXQ2cVhl?=
 =?utf-8?B?N1BiUDQ1NjdzTFMxUml4a0o5bml0dFJqVHAwQVlMWW5ranVDMWZtbmlieFAv?=
 =?utf-8?B?RmFrQmlWQ1FPd29YQzB1UytMOXVDbWZ1K253SmgrNlgxNE5ZNUFlRFA1Nmdr?=
 =?utf-8?B?eUd4bmZVdTFHcGpqTEU3a2pPN0ZZSHBoT2x5dCtMWTgwWW10clEra0xDbDlQ?=
 =?utf-8?B?aldka1NBREt2eFJyTDdxZnVIejdLSnAwWUVmcDMxYXNrc09ycUdwbWo5MHRm?=
 =?utf-8?B?N3R4NGFueFhCSTkxNkRXa1F6bHJBbmIwQWh0WThFeFY5SlBlS0xJS2hFcXR2?=
 =?utf-8?B?R1pCZzRvS0g5aEI1bjluQnRHUXg4Sk1sQzM5RkVJeHB5R2YvN2tQMW80ZXdz?=
 =?utf-8?B?TDlPMjRqcUpOYkY0QWJPbXBkeHdtdFp3RGRYenNxU2xmazczcHQwNzdHU3Bo?=
 =?utf-8?B?MllPdlBWNi9MemxwUThBQmFzWWlqWVV3UE9saHNSNXlrQjdGNkpmbUtXVWF4?=
 =?utf-8?B?M0gzU3NiaUs4WUx0bTRRZC9LRGwrS0Y5NU9WZVEwU090OUxyZFNYV29QcTVw?=
 =?utf-8?B?dDRTNUVheFpNbTN2WHpSWXlwNGRETjdsZEFRZ0oxK0krR0ZqZVllVERKSGV3?=
 =?utf-8?B?QWQvUjNtcGtjRGY0SVdzYUVqeUQyZkNXai9NeHgvcU84Umw0MklEY3g5ZUZq?=
 =?utf-8?B?cVI5SG52Y0hlWTFLRjFhRldpZ2V4YzVCRDE5cFJuZ0FsRi8yaC9Za3c5Vndi?=
 =?utf-8?B?dXJoUHVqOCtsaGlBUGR3VU9Yb2l4WWhSQXpncFBCSnFWQmk0VldnZURjR2xN?=
 =?utf-8?B?YnZYR0RTZmNKMUFFZ3V0MlVwNE5Hak9NK0N0TWk3VldBVVJ5RXhISzQwYWZV?=
 =?utf-8?B?VWtreXNxNjdlSkwvblp1Y1E4VWljRExMd091SklEV3FTbkN6Z0cxaWpLUmtm?=
 =?utf-8?B?L0ltby9sdEcvOUdtQWIxa3pzMXRqU2FQWnNMQXd3R2lxUVRWOUxjcDRmejBj?=
 =?utf-8?B?UVdzUlJSY2ExS1YwOHRCWExzbHpJYXl5WU04aXdrb2N4YzV0ejZnSWRVNHE5?=
 =?utf-8?B?TnFwTlBzTDFnY3ZNK21TZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajg4VU0yd3RGSW5Odzd4ZWRMU3BJNkRUU0xwRXFLSVQramxRek5UaTY2VFBC?=
 =?utf-8?B?SnNkeks0aVhhM05LY0wzRzNqZWhZU1pxbXF1U05aSVlDVnFISlBzK2FFdnU0?=
 =?utf-8?B?RWwrYm1uYkhPdy93SVZ2YldVMWZRVmpkc3R5eTRFOHYrRDcvNW5uWlV2TWY3?=
 =?utf-8?B?bHVqakM0c0lRekVBSmVDZjh0YXpXb0x4U0ZOSEo2T05rM0tGOHJEYWFJYVly?=
 =?utf-8?B?eWJQbFBQY3JOSWNybFlkSW43WHh1TWcraHNpRlc1WFREMDRHcDdpc0dBQWlm?=
 =?utf-8?B?M1I4ZFBJWGtKZldOQytPQ3lNcFRHU2djdWN3UnNieFVtWVlXbTRvbmpxbUg4?=
 =?utf-8?B?NC9SckxTSVR2ZXlvRU5ha2tSeEJQT3FTYmNtRFRDOG1pT1F1VFJyaG1OUURw?=
 =?utf-8?B?NkJ1eTd3SlJhVm85NlEyS1dEcHFHa01oNzBnQ0VwWmpiTmMvd0hiNTZtY0VH?=
 =?utf-8?B?SFlyQ0thdmdRekNsL0M5UWhPK2JBdm1CUlNGcGlWV3dkMit3ck5IUmhoVWw3?=
 =?utf-8?B?Q0R3M1dMak14MXBneHc0ZTZhY3phamFGWUJKTmJlZm5MRlNHMkRGQmZUZ2s0?=
 =?utf-8?B?Y2QyVHU5aW5xcUpPRFZBTWxKRXF2T2FZc3lkTFV4cmxSdTRtR2NiTDF6QlhH?=
 =?utf-8?B?Tmc5SWVLYmJWMjBoeC83MEhuZFo2OFFPRkNaY21EV0Q2TjRyak1YbisxdEdr?=
 =?utf-8?B?enYzcHV6QnMxdTR6c3NVVkQ5YVNIbm05WmhSVXQ0SHF5S1JsbmFKSUtPeGZH?=
 =?utf-8?B?MjZYQ21yMGEyQ3plNGd5VTNOV0VHZ3o2WnVjL1NvK3ZBY0Q3K2xZemxqak9D?=
 =?utf-8?B?c0pOK1kyQ2lUNVRuYk9ielVUVW83Vm9QWlJEMUdtQjY2RFlROURnYVFMZGxx?=
 =?utf-8?B?K1Q5cThMVnJ6WERYYnJyeU1OVXdWMFVXTGsvY3pjZGc5dmRqMXUrUThhUDZK?=
 =?utf-8?B?RzBzUk1TZml0L3lhdGxvVEZoN2tRYlZNMDRrM1NsNElsWWo4QXQyUGtIZnUx?=
 =?utf-8?B?aDBFZWhJTFdTYXZtYTZweWdUdW1GaG96eXh1VndwRG1DUzlpQTZDeW5qa00v?=
 =?utf-8?B?eWFqVWdIQVVoenBuYjBna2lONlJUTDZPdUxWSEI2OHh0NWxQTDZvMmgxSzdN?=
 =?utf-8?B?bWhDamZaOWh6UzlYNjR5ZU1tNS82aGNIbnEzYXdydGtJaG9GaWdQZlBnMWhh?=
 =?utf-8?B?MXlsVTJJK1RyOVhOUEt5d1ptdkZPc3Q3UlgyUjd4Mk4zbVcxZnR2L28xdG9m?=
 =?utf-8?B?T0tjL1BvZFJQSGdRQVVqUzlabUE4WVpjY0dWbkhkTnpnYXpDWDJUK1RNSzdE?=
 =?utf-8?B?cmRNZzlTemxPTGFVcktnL0xwYUZDcGp2ZFkzdm52bForWGR4bnhsZ21lVEx4?=
 =?utf-8?B?ZWptUkQyQ05Da3FOVjVyencvZnJucWlZZXB2NDFIZFFpVDZyM2JUeE5pN3ly?=
 =?utf-8?B?cm84TVc1ME16dGNxa3ZZdExYSmpEYzAwb0hrWHJ0YXRuM1pKRzZlSzFNUXJ6?=
 =?utf-8?B?aHdEMFhSQ3RjSmlza25QTi9DVkVvUkRaZjlDUXROMGVZVXh1Y1RGcVFUeVdO?=
 =?utf-8?B?eVZWR01LUlptcXZid29HYVNtckVONnMyUXhxNC9KOENaL0lyS2ovOGZIbFBS?=
 =?utf-8?B?QTVSWDJidnVzN1NhZkVVTWJmQUFzL0ltU1FkSXVET0VtSFVUV1R3c0VvNEtW?=
 =?utf-8?B?QlYxWTJYSXcxS2NCZk00bk8wbSt5OXlxVGlzakNYd083TlJGVVAyQXAzNHNZ?=
 =?utf-8?B?Vk5QYnJ5clpsMWtwYW1uK1F0VXdmUzYweVVsMkxaaWN0bjZWWVREVlo3cFVS?=
 =?utf-8?B?R1ZzTlU1a21aVWxUMFFVY2J0S0dyWk4vTklYa2NRQ3Y5WWxtRFk4L1pkWG5M?=
 =?utf-8?B?YytBSVpMS3FvOHp0UlIyT3lWTG4zZk9YS1pBSFgwaDBGK2I3VWFwUTU3czF4?=
 =?utf-8?B?Y3RnUGx5aEI1d1l1eWpvY3RINnVmWEhHWFl6aHlYV1ptcnhIWmZaTkhYQ0h2?=
 =?utf-8?B?ZWhNTzE0S21EbFhDL3NHMFlPUFVYNTFSTUE3c1pIOXovY0orL3JyZzJWbjZX?=
 =?utf-8?B?K3FMellmNy9YZkJQR2M5Y0ZqNVAzRmtjMVpzTkZTeXhiMi92SGMrdG5ZdmNY?=
 =?utf-8?B?dGVpNzdDaHNGczVVVDVtUEpsL2VEZGExWWtNQndaRWNsUkJqbGxCMTNDdUJn?=
 =?utf-8?B?QWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LKlt11tJZyg+C2IexNeQ5L5LhGCqA7upk/4Rnhcu3nJ9t/jB+VlPfzx0U8fdlz7NJ/Q8hOghs/6oYS16lep5zbnAbUyWG7tOsNsou6fQB+igFzndXb3Ej+LoCzZteQDym5tKkbXdnUo8KGpqOJQHnCD7trsOK4K8KpHbqAChaorwn1grk8RctNAJr/P/uF+Wa2+byLRIZVULu4vonelo0aLDofhlow9rLZSk3qaHHapuyRzkNA61vT0hdyfR89Y2QhyUA/Ry30LF3c8jK4lVVsQfxcUO6M4+RWcSvp9iw4VX3rtFTPL/56yiDViZxjShu9CiBTKHMeLjhZXW3UMkFB5bgN8i7ysBHGr+0Gd4hfDd5nK9DNcRNkIB5Us96LrnHPYHgXGmPxYfuZlcDGMPI95h5qv/BHkmS/MByxEuwXa+iZsp0WtJvtFPfK9zSmzj12VDKMDJlx5TJrRACNU4DtmGbaE8U+9plnTMD4bL+Ga45a5PWBoqJnNSX50Mdv/iqa2UjiuhIQCMeKQ1CyI4+WdslMJez+D0DKeIjasne6AIlJe6qAAtUI0Di/rHqR90CpMudczG4em4Ry8KBQRoidNgx4cTNgRAikRzT0RdifU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9a4d92d-ff12-4b77-3b36-08dca67615db
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 15:35:28.5901 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BzdM/KflBj6mGXq9kuZIfMLkwzci1+S5Y4oMjNl82/N7eoFsvuQd9uFpWUUKaLSlXiNfWvmh5Oyd0RTWUd2km3BKUn3FeJAygQF0tNcOIeU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7627
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_11,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0 mlxscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407170119
X-Proofpoint-GUID: EWHiNjLwbxvhxHD0pfHEE0H29GUCXVZJ
X-Proofpoint-ORIG-GUID: EWHiNjLwbxvhxHD0pfHEE0H29GUCXVZJ
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 17/07/2024 10:20, Joao Martins wrote:
> On 17/07/2024 03:38, Duan, Zhenzhong wrote:
>>
>>
>>> -----Original Message-----
>>> From: Joao Martins <joao.m.martins@oracle.com>
>>> Subject: [PATCH v4 11/12] vfio/migration: Don't block migration device dirty
>>> tracking is unsupported
>>>
>>> By default VFIO migration is set to auto, which will support live
>>> migration if the migration capability is set *and* also dirty page
>>> tracking is supported.
>>>
>>> For testing purposes one can force enable without dirty page tracking
>>> via enable-migration=on, but that option is generally left for testing
>>> purposes.
>>>
>>> So starting with IOMMU dirty tracking it can use to acomodate the lack of
>>> VF dirty page tracking allowing us to minimize the VF requirements for
>>> migration and thus enabling migration by default for those too.
>>>
>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>> ---
>>> hw/vfio/migration.c | 3 ++-
>>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>> index 34d4be2ce1b1..ce3d1b6e9a25 100644
>>> --- a/hw/vfio/migration.c
>>> +++ b/hw/vfio/migration.c
>>> @@ -1036,7 +1036,8 @@ bool vfio_migration_realize(VFIODevice
>>> *vbasedev, Error **errp)
>>>         return !vfio_block_migration(vbasedev, err, errp);
>>>     }
>>>
>>> -    if (!vbasedev->dirty_pages_supported) {
>>> +    if (!vbasedev->dirty_pages_supported &&
>>> +        !vbasedev->bcontainer->dirty_pages_supported) {
>>>         if (vbasedev->enable_migration == ON_OFF_AUTO_AUTO) {
>>>             error_setg(&err,
>>>                        "%s: VFIO device doesn't support device dirty tracking",
>>
>> I'm not sure if this message needs to be updated, " VFIO device doesn't support device and IOMMU dirty tracking"
>>
>> Same for the below:
>>
>> warn_report("%s: VFIO device doesn't support device dirty tracking"
> 
> 
> Ah yes, good catch. Additionally I think I should check device hwpt rather than
> container::dirty_pages_supported i.e.
> 
> if (!vbasedev->dirty_pages_supported &&
>     (vbasedev->hwpt && !iommufd_hwpt_dirty_tracking(vbasedev->hwpt)))
> 
> This makes sure that migration is blocked with more accuracy

I retract this comment as I think it can all be easily detected by not OR-ing
the setting of vbasedev->bcontainer->dirty_pages_supported. I should put a
warn_report_once() there.

	Joao

