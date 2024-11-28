Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B53DD70DE7
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 17:15:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGi6P-0007r8-7J; Thu, 28 Nov 2024 12:14:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tGi6L-0007mx-2R
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 12:14:51 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tGi6J-0004Eq-3R
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 12:14:48 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ASEb1ln009189;
 Thu, 28 Nov 2024 17:14:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=GJMRHWQv1JLlovizY9g1s+W9UGozQ8K6vjtNga5VhMI=; b=
 SCJyQgnijapfoQ6xdhYMItXycWsTabSK9yfW7o8I5hCwOw6OAoQt4tcFrQuUO2L9
 y7rkfhQntpael0XnQpIG4S9+Dq8ekDh5XvJpZ64thE2ej6dxHYFUbgt7BQifvKWh
 66ek0FpKmFf+Ll6a15+uVAHYtxM92+0Oefw1JyUkIgBq0S4BQsm+DNHwNxvzeoNo
 7V/jBi/mVUvWUg7CoKtU5RQwSFwe/4N9Twx4qleUyEzOe3HSHiZxufGlSZZ07BS+
 HbzllrOCyo0yt+11dYO7vUo6bHTdflxc5NLnWcAjRzDchtv2MDAvELR/WpI24e8V
 8B4GVwRLJUP2X8ROBuDghg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4366xya4qw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Nov 2024 17:14:41 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4ASF3ecI027601; Thu, 28 Nov 2024 17:14:40 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04lp2176.outbound.protection.outlook.com [104.47.73.176])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 436704ad1a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Nov 2024 17:14:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zB+v2U31XItqebgTRvnmnoJQbhHIyg2RqJKpvN/GVHp2/BV62dE3GN41n9Xm5zfZdA8FnynnT1NJtAuHSt3b+ulRLgq0ptlMWyOTsRFlieyXj4OeJ4sUlu+OA01dZ0we77Zh+Y0pLtCx8arNuDHbQS9kA6TdNjK4CgJMYNeKpHGyzsx74nlvIr9kbVDclUjNCcGAx76F/STiotvtef54dscINuAX7n9uwEKM+Nk/ZtccIH83p0thuOiyMYbCi97yTANp0ZoSTCsIoSxJbCnjT7LHiLP3z/pjWKIJUl4fN28jQCtALg9jfiZDrurYYA/ghstFHBtBo5FUmEOyG8/iRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJMRHWQv1JLlovizY9g1s+W9UGozQ8K6vjtNga5VhMI=;
 b=uSM1VaETpYPM8JLVcM0iRcQ7b5MEKQMA2hWv+UrLebHP1WeIUPr72WMt8rUblzjVli2e9eOMQnkwxer7TL9RgIEfOUoZ5NAlh5DcdnyfZzfVEIhk+l7ORax23bbOkqZK1NmCSfeDzFPpxhUYKdgiaQqGX9pBk4ApE3+7RYkWrOEPW4YehRw0O9aMcrdmGqBWRR30zDeYOCCPfYxQAglvUJme/0ga2jEKpogNs0SVOXY8wn0lY91N/PtlpXErHmZx71P5Ce1V++09TMT2AWWtzetBUFJM4IMIGFtHMeiYykxaW3cJKz1eX06Z0oQ4bmhHRzCz8I9yLkvln73oLL5PNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJMRHWQv1JLlovizY9g1s+W9UGozQ8K6vjtNga5VhMI=;
 b=KfJefnktehsjeGKnHUyjlS7UrcL9vZD/C5CELiwplZjxbDsPVikggd/729kPtyC2Roy8t46xmh9I/1na9mEMpxFPtb0QD3mc1cBLExi2WHC4MzQe3iaIWoNnOtXdGoqq4eet7yKUO8fDq7bmtaVaczb7EPbk29i7BEYSxK3Iutg=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Thu, 28 Nov
 2024 17:14:37 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%6]) with mapi id 15.20.8182.019; Thu, 28 Nov 2024
 17:14:36 +0000
Message-ID: <b2c19675-ba87-499b-aff6-f946d5d25eb8@oracle.com>
Date: Thu, 28 Nov 2024 17:14:27 +0000
From: Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [PATCH] hw/i386/amd_iommu: Allow migration
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 vasant.hegde@amd.com, Wei.Huang2@amd.com, Ruihui.Dian@amd.com,
 bsd@redhat.com, berrange@redhat.com
References: <20241120073114.20774-1-suravee.suthikulpanit@amd.com>
 <cae2e18a-a090-4bdc-b3b9-cf72393436b0@oracle.com>
Content-Language: en-US
In-Reply-To: <cae2e18a-a090-4bdc-b3b9-cf72393436b0@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0005.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::17) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|DM4PR10MB6229:EE_
X-MS-Office365-Filtering-Correlation-Id: ab366241-8361-472d-eb16-08dd0fd022af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q3BSR0dvbGNEZkZOU1hTRzYwTk1JWmhWMU8zV3VXSzBUWXovRXd4OHRvcEEy?=
 =?utf-8?B?R2pjM2xWazhFWDhDZUtJcStGQ3AxQThUeUxtWEhTYllXU3NvYi9od1QxOG13?=
 =?utf-8?B?Mi9VL0lUdFpOVEFaSnU2OXBncEhjam1DYUMzc3hzUitUeTJxUW1PUm05Z3BE?=
 =?utf-8?B?NEpYWFI2aStyRzhQblJaekh4ejkvWjVHdTYzdjJOam44OWpEeTI2L1I2cmNh?=
 =?utf-8?B?bWxBL3VyY0I2N1UwazhLM3pzVVdFZUFSZXVvcGl2VENUb09XNlFiZjVPTE5x?=
 =?utf-8?B?NTZ2d0I1VFFDZ0NVZWs3ekxXQlZSVGhQVHlZR01oUHhrNkJNRVRLMFcySEdY?=
 =?utf-8?B?ZXp3OVA5L3k3K0UzcmdiOWd2K1JWS1c2cHN4YVBzTmovWUJzV2c4WXRXYlZO?=
 =?utf-8?B?RCs1dVhNNnBiYThyL0hZZXUyYXFORVlXd1hZWjJBQTBrSEFVSVBPazQ1NUJU?=
 =?utf-8?B?c2lZUmRvVGk4amRWeXE5cDNNWkxIdUVOdHc4QjAwcFdMY004bjdTOStxYmdt?=
 =?utf-8?B?VkhCUzJqbXJja1BOUUZ2S2o3L2Q3ekZzREttNjhoL2p6OFg5Tk9GTU5SVHA5?=
 =?utf-8?B?Q05sWGlsem5NVmVzYS8zTVV0SVNDTjV5RVVma3VGNC9JcjdCWTBjS1dTRDVV?=
 =?utf-8?B?cVhrR1Q5LzlLN3cvQmRvNkJTbnVKQVdldWZ3Mm14SlNwMHBTNS9vc3VYdEs0?=
 =?utf-8?B?elp4L1BQZ21JbHFlc253UTE0Z0hyVXEwdEhySGlkdGoxbkRZbUEvS2l3VEpx?=
 =?utf-8?B?Znh0TTF6Vm4vWFpHcTJveVpOSkVlMnVDblp6Y3VzdUNRZm5NdXJlaUdleEpN?=
 =?utf-8?B?RFlRMXhkYzNxQlJpZGxNVEo5VWk5MXN0VmgwQ1QvOWtncnltTU0raWZEeWZK?=
 =?utf-8?B?RitNbTYxL2JXWC9MMjI3Wi9idCsrRFJTckRtdHoybnFyK2NNMGZsNlRtNFps?=
 =?utf-8?B?OXI5eG5MM3gzeWY0c0MxeTNMQUt5Szd5RlpyR0xmZ3ZUMDM4ZDJQZEtVamcr?=
 =?utf-8?B?NjlPT0JHUnZXakhVUFRIWDNkUEdvcm5QV3UyM0dGSGpXNENOeHhyZUN0a1JB?=
 =?utf-8?B?L0lEUDhJbit1VVgwVFVKQ0pWUlpWeEx4bStlN1ZtTXNwTlZ2TXhZNGt1U1Nr?=
 =?utf-8?B?TDl0QjQ2Z3kySlNLL1dyUllSUzFBM0xNQVJsdkNXSzFIdERHWklyd3NMSVhK?=
 =?utf-8?B?c1FlNFRuQzNKY1VSTWxQYU0xQStqTkN6bmJaU2NGc2ZzVzZxTWpCYmhDamN5?=
 =?utf-8?B?NEFlMUFXb2NCYkJGeUpFN014OXp0OUlQdHlIMjFRNFRzTEV3Y1g5aXR2YTMy?=
 =?utf-8?B?RHN2WFBjQm95Nk15QkxKTCtjR0xFeThwbXVMRFZjZEpYeXNzN2VlRW1nYUJ5?=
 =?utf-8?B?M2JxeTV3eXRmamxPK3hteC9yY01xMUoyMUd3U2VERUZCVk9Nelk2SkI1bDVU?=
 =?utf-8?B?WEZZaGFnOWk1R0l4eEtSaFZ1MkNkRDBBcmhTUGt3TlRCZDY0RnloVkxzMWFw?=
 =?utf-8?B?T0RLUTBONUkzZCswZ0huVW9PS0JtZklDM01JZG51aTZ2ZEROMlAyb1g0Y2hh?=
 =?utf-8?B?S3BrN0R1R0J6czVlQ3QvclhWQ2dyeVBhWThEYmwwYjd4Wmp0S1k3VDc2Y0pB?=
 =?utf-8?B?U05NczVRQWs1TGd3U01nZjJYTnBuUWR2d1lZQlIrMFEvS1A5eDRGSiszZXBQ?=
 =?utf-8?B?d1lWMmFnamJrR3IzWklOejQ5RFY0ZjUzVjJSV2krdHg2SGhPOERhdnhmK09K?=
 =?utf-8?B?bndrM0xjSEk5VmtpdW1iVFpoOTZkaUN4czZ4U0VjTUpqQ2lCckFlNkMyRy9Z?=
 =?utf-8?B?ZzZ6aDZYaWY1dkQ0TDNJUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVd0R0ZlRVpHSnhmWWNMUnZUUGRRVGdUZElGbkxTSi9HejM5d2pWVTZLYUFt?=
 =?utf-8?B?QW8zdlBnSU8rSG5Md20xV1pnTm9yaTBRYzZNSGcxSnZpOHJpdjV5NGtFRzRV?=
 =?utf-8?B?Ykd2YjYvR0xDTTJHbFkyY0hGd2pqTU9wczFQcS9tTk90Smp0OTJZckdDZHRn?=
 =?utf-8?B?VHFlc3NEVjNoUkRUVktjNzRqNGtWd3FaMlc1Um95bmxGalBqNTU4WEYwcVBt?=
 =?utf-8?B?TFlHOFJCK09BQit0RXdDV1dtQm5TUThuMjM0MmtKVms5ZFMvVTUrZGNZQk03?=
 =?utf-8?B?Y1lvTnVncmpwT2UzcDd5SDAxY0hBbExjNWRCWDJ6cmFBMlRpcXlnb1oxaEE0?=
 =?utf-8?B?QUYrWUU3djFjbmI4bm9rZjYwaEJMUHM3RUMzV1Y1RXRhdGQrRHhmMTRCVFRk?=
 =?utf-8?B?ZnZMQVJXV3NTV2NCTHByV29NeDUrT2FST0pIbnNvSGdNSit0VGtKTUdoRyt1?=
 =?utf-8?B?TTA2WU1GY1hoUEpGcU5xZWFkdnBJM3Y5YTlpSzliWGdDRGZ6L0pEU0FVUWI5?=
 =?utf-8?B?N2Zjem5IbklqYVFoZlBRN0F4NUNFZUE5Ukhyc3F0T2pibk1sajYwTWtKYnZ0?=
 =?utf-8?B?V3AvRVc2aGNCZC8rOHVBWno4aU5wcEwwaXhlR0VxV2h5MG44ZVdwL0xLRjhq?=
 =?utf-8?B?QVlJMjRSUDgyVFFZL2UrZHd6ZUw1NGI5N1VFYzloWVZjY0E4bkk0NnlMUi9T?=
 =?utf-8?B?L1IxWkcvSjZQamdGa3B6Ryt4b3c3RlpPYk1jU3hNOGx2WXdZZ0hvRWRpVUlq?=
 =?utf-8?B?Mk9CQXFER3hlMlV4YWIza1lxWEdpNUxIeDZNaDhoMlVPaFkwVXArN3ltK0VG?=
 =?utf-8?B?cUVGN1B1SW0zNjBXbHJnaGpYUlk3Y2V1UG4wSEtNeEg2WnRHSVhwWGt1MGxw?=
 =?utf-8?B?QjdXYlpKU0ljSGRGci8yN3FqQW9mZ0Y3bkJ1MGdzZ0RsUEkwVTdGaTJJOHNp?=
 =?utf-8?B?V1VzRFgzZWYwUytndWIyY1pzMi9pTUx5Y1gycmVuemZORnBYRVFDNVh3bHlo?=
 =?utf-8?B?SWQ3cXRJZkZ4U25GYWRRWjlMeCtDZ2p5UGUvNGx1V0t5b050ZjRPT1h5bDFL?=
 =?utf-8?B?TnlhaUFKTjFhRTQ5TElRVWtMYnNiS1ZuZFhENm1RdW1Lek55L1I1T0M3Ris1?=
 =?utf-8?B?clRCeVdKK3FOWHRLdk44VEJydFljbUtFWFFtRzJBNzRHWFpQdHJ0c2Q2SVZt?=
 =?utf-8?B?cWR4UDEybUdPakU2QXVMak5wNHMvVTFKb283cVI1eWpuM0dnNTRhdTUvR1ZF?=
 =?utf-8?B?WjZ5N3B0S2p0Mkk1YzRrOGZSY1hxN1diOGdkMFFpZWVyb1hMNE1teGtRUktX?=
 =?utf-8?B?Z0J2ekVvV3VmUUtZQ2h1YUVtclRlL0xYZ011UVhkWnhGekZJdWgzaHZCcloy?=
 =?utf-8?B?c2VRQjIxOHZiNDdEMnNCbSszanZaekZ5WGt6U1U5RXZpcXMxK0UvckhvU2Nl?=
 =?utf-8?B?dTM2MWdPb2NqVVNWVUJCTWo4M1NGc1pWekZFYVEvRHJYWWp5MnJTZlc2NVFP?=
 =?utf-8?B?b0tJUmZoZkh6ck9CczhoUjNmbC9wK1Y0ZVRhYk9tRGtGdXQxRU9FcUZUY3Zh?=
 =?utf-8?B?VUdmQWVEUG9DNGsxV1BoQmFsT1IremlNR2w3aTFMV29XbDgyWk9ZUzVJaG12?=
 =?utf-8?B?aklUZUdPMlk3dzBxekd3ZmhaT3puUkhrUFFCTHMzS2tza1NSVE9nZmRJb3Y1?=
 =?utf-8?B?U1NQZFlncllFbW1NWWZkeDJpc0llRmJJbW1tSXRIT210dGJNd3ZyMVplYlBT?=
 =?utf-8?B?Zkx0TnBNOHhHdTRlcFRQUkhsa0NvcVlpaHhYbDJQck9DaXdjdHZ2ZXNDMTZK?=
 =?utf-8?B?UzBYOUVDYmEyZWVneGwrMmFQanJvMk9VNjMvRVFKVHk0MTZleWlLQWV1ZjdK?=
 =?utf-8?B?NjhVSmFueDZRTTlKcHFmRWpTZTJlWS9IZ3NzVkhXWHhyUHZrckV1Njk5RlN5?=
 =?utf-8?B?ZzJ0THRGM1JXYlh1bWxnWlJJcUVkcGRzbG5RYjZrUGcxb0VQSHBNSUVMamtL?=
 =?utf-8?B?OFlZM3hGRzRjQXRIODRxUXJJNGtBNFR2dk82cnp3enNiU2c2VlAybUlZbm0z?=
 =?utf-8?B?cGl6bHJvVzdZd25XM0tDcVVaZjRRT0dndlgwbGdNenNySHE2SzBiLzJtM2NG?=
 =?utf-8?B?ZW9CK1BqZHJKNXJDMlNPWXFxMFMyUFJDL3JoS2FXL25ZdDF5NWRNWkdyU3hp?=
 =?utf-8?B?c2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: m7aowK3LnX0xvxOBR6xdLsS5ZwBwP28SdhJI+eKHL5YAPueecw4mC1iRYf0eyOa9DoFFyiaQlLkWceL8vjYVdDwRdco5BHCfmfXbf8LqIpl/XOWL/Q8dQKAreDngtkTU8Lrr7aEKDEy1NeqjZbFJ8K28zFdey+cr63I4cA9FT7lcwgb8xMj28lRVC/8f23pwgxMNAEe9I2gHK83H1H2RVMiNppvdStM+20L83tXcuDgM0bRwKym3dwNZRjE0MXf1f85cWwxZMwchYO8PI25qXyhprx6XK+EZhjWnJyKWudOpuFwvgXb4N7qVfPoPxwU/zZwVXAwYQ1EdJdIi5Mfq8QaAy+/R3mJgWXHITan4pUOzNSrdp974/LtH3SwWN75FF8G6GNSEoTLanWTvzhD8QIW+T/W2I4i6tPJEvmQdzJcn1x0S3St9BSvXB79ibWgknJ7gY7OBoXVjxu+z9ahrvHJW/HBnqwGHhtykNJir/G7QBdXd6l5GvDy2YG+j2AxaruEt1Vrc0ef6cYcd25VTWZY+nv3b4b8qOyN4vuLqGdgbwXbMTsa2Czv860RuJau/pmOmvenHX/KAQllGmu44gGHQ4EImlQtxF9yCNJVqEZ8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab366241-8361-472d-eb16-08dd0fd022af
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 17:14:36.8875 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YVH/D57RjIZLvSc275OjkFqohcnRH95uJmsY5QElFtThtrQBhKDmQ+rb4E9F1BV1GhMMKBeI3lwpffhIheyROxlPo7mpcUY3R4dzUQ+KPKA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6229
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-28_16,2024-11-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2411280136
X-Proofpoint-GUID: 35zeoL5jS1NkmFCf7uFO-PqcBAQ9b9sJ
X-Proofpoint-ORIG-GUID: 35zeoL5jS1NkmFCf7uFO-PqcBAQ9b9sJ
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 21/11/2024 11:42, Joao Martins wrote:> On 20/11/2024 07:31, Suravee
Suthikulpanit wrote:
>> Add migration support for AMD IOMMU model by saving necessary AMDVIState
>> parameters for MMIO registers, device table, command buffer, and event
>> buffers.
>>
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> ---
>>  hw/i386/amd_iommu.c | 36 +++++++++++++++++++++++++++++++++++-
>>  1 file changed, 35 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>> index 13af7211e1..3d2bb9d81e 100644
>> --- a/hw/i386/amd_iommu.c
>> +++ b/hw/i386/amd_iommu.c
>> @@ -1673,7 +1673,41 @@ static Property amdvi_properties[] = {
>>
>>  static const VMStateDescription vmstate_amdvi_sysbus = {
>>      .name = "amd-iommu",
>> -    .unmigratable = 1
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .priority = MIG_PRI_IOMMU,
>> +    .fields = (VMStateField[]) {
>> +      /* Updated in  amdvi_handle_control_write() */
>> +      VMSTATE_BOOL(enabled, AMDVIState),
>
> no xtsup ?  I guess you are relying on the dest command line having xtsup=on
> like intel-iommu
>

Having said, I think I found a flaw here that sort of "ignores" the default
command line param of 'device-iotlb' (broad x86-iommu param). By default it
seems we enable device-iotlb in amd-iommu regardless, even though it's disabled
by default in qemu command line params.

Should we enable migration I think stuff like that starts to be important to
honor given the compability issues we would have to deal apriori. See below on
how to fix, happy to formally send if what I explained makes sense to all

-------->8---------

Subject: i386/amd-iommu: Set IotblSup based on x86_iommu::dt_supported

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 9fcc2897b84a..f30e103d649b 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2310,7 +2310,8 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker,
const char *oem_id,
     /* virtualization flags */
     build_append_int_noprefix(table_data,
                              (1UL << 0) | /* HtTunEn      */
-                             (1UL << 4) | /* iotblSup     */
+                             (s->iommu.dt_supported ?
+                              (1UL << 4) : 0) |  /* iotblSup     */
                              (1UL << 6) | /* PrefSup      */
                              (1UL << 7),  /* PPRSup       */
                              1);
@@ -2347,7 +2348,8 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker,
const char *oem_id,
     /* virtualization flags */
     build_append_int_noprefix(table_data,
                              (1UL << 0) | /* HtTunEn      */
-                             (1UL << 4),  /* iotblSup     */
+                             (s->iommu.dt_supported ?
+                              (1UL << 4) : 0),  /* iotblSup     */
                              1);

     /* IVHD length */
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 13af7211e11d..7e6140b9a0a2 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -77,6 +77,18 @@ typedef struct AMDVIIOTLBEntry {
     uint64_t page_mask;         /* physical page size  */
 } AMDVIIOTLBEntry;

+static uint64_t amdvi_capab_feature_register(AMDVIState *s)
+{
+    uint64_t feature = AMDVI_CAPAB_FEATURES;
+    X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
+
+    if (x86_iommu->dt_supported) {
+        feature |= AMDVI_CAPAB_FLAG_IOTLBSUP;
+    }
+
+    return feature;
+}
+
 uint64_t amdvi_extended_feature_register(AMDVIState *s)
 {
     uint64_t feature = AMDVI_DEFAULT_EXT_FEATURES;
@@ -1563,6 +1575,7 @@ static void amdvi_init(AMDVIState *s)
 static void amdvi_pci_realize(PCIDevice *pdev, Error **errp)
 {
     AMDVIPCIState *s = AMD_IOMMU_PCI(pdev);
+    AMDVIState *amdvi = container_of(s, AMDVIState, pci);
     int ret;

     ret = pci_add_capability(pdev, AMDVI_CAPAB_ID_SEC, 0,
@@ -1591,7 +1604,7 @@ static void amdvi_pci_realize(PCIDevice *pdev, Error **errp)
     pci_config_set_prog_interface(pdev->config, 0);

     /* reset AMDVI specific capabilities, all r/o */
-    pci_set_long(pdev->config + s->capab_offset, AMDVI_CAPAB_FEATURES);
+    pci_set_long(pdev->config + s->capab_offset,
amdvi_capab_feature_register(amdvi));
     pci_set_long(pdev->config + s->capab_offset + AMDVI_CAPAB_BAR_LOW,
                  AMDVI_BASE_ADDR & ~(0xffff0000));
     pci_set_long(pdev->config + s->capab_offset + AMDVI_CAPAB_BAR_HIGH,
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index e0dac4d9a96c..98e155549532 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -182,7 +182,7 @@

 /* capabilities header */
 #define AMDVI_CAPAB_FEATURES (AMDVI_CAPAB_FLAT_EXT | \
-        AMDVI_CAPAB_FLAG_NPCACHE | AMDVI_CAPAB_FLAG_IOTLBSUP \
+        AMDVI_CAPAB_FLAG_NPCACHE \
         | AMDVI_CAPAB_ID_SEC | AMDVI_CAPAB_INIT_TYPE | \
         AMDVI_CAPAB_FLAG_HTTUNNEL |  AMDVI_CAPAB_EFR_SUP)

