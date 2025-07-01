Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A68A5C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:28:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWbwN-0005Sh-VO; Tue, 01 Jul 2025 10:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uWbwL-0005Rv-RF
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:26:29 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uWbwE-000277-Hs
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:26:29 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 561D9FbH031009;
 Tue, 1 Jul 2025 14:26:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=seuVITICx440Fc0WtOIOQObWsLlIKhh1gWwbfMUTZ9E=; b=
 mY5kZNU83c6x0rdYpvYKvrxT433uD4yNdujY/L+ZRavFy6FIw7lNZvWoXh4KV8rZ
 aO9IZV/xNWn3WbImJQpAHxOJDPV9pN2JNRmM2PHMaIIgcmsoqOr2ZI032wuG7Mc3
 S4okFS/PTXZkvKKQ1a2wrXy9iOc+Q/MGLrO7oHUWym4Y0r9iI0w9CpLQvJSfglRk
 nD7LXto2daQ7YnLamzt8DbQXtcCurpMF70By2R4AXkrppHlpBq20N4KwAP7/myNn
 gXft/1gMzagzSJFaz0A12OTfzAHJRxydnfZFlIDv47LCnYx8fuSp5Lrk+YzbDxxK
 yE6pxvFLXbPARZsO1jOygQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j7af4w1e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 01 Jul 2025 14:26:18 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 561DWKRE030635; Tue, 1 Jul 2025 14:26:07 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 47j6u9vcmg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 01 Jul 2025 14:26:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HWP+69kTWrg6+jscfDl2yABTeL2Yz9p2S4eH9VPNqsXmTiXZ87F7j5KRsoQ7tdHWdJlB94Dysy60SUfQp/eTYN3W0s48PBtXoDGOM/MdiPWi9tBPD/2B24bIBjxtgj6GRPj0vlSaIaFFD/w4EroPlWJIKMdFgqhHHx4jiw2+2Wahp5gU8GMS5DxF5ivNf7D9Ekqj18oTMuDWynCqbnfxhKmX5ch5rNgutuh0VbJ/nSYpRVWY782VWiKi2hvXlS4XDu5GCls/5C6zafYeL8CNUIiY57lzP8RSpoUj+fsOHs6ZbECtLZxoGs1cTBxbU3MHAuyQBy7KfBmaMS+G24NwfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=seuVITICx440Fc0WtOIOQObWsLlIKhh1gWwbfMUTZ9E=;
 b=CA8ppYmtE9jYUfRT5+kCZ3ZEDa2gi9wXBGmRCtU8WBjIa7XaU8ZHLuecDitqXpkx71MlpHcPQBRRP8H3iwddDkY4ItVkooOs3pm5fbshjZH7SlhwTOjpZB0H0UYB8/+ATTePqltlfGBdTo/CFKW8gVlwt8uYkixfBJWmNJdzTlD/jh4887BysmVXCAa+sdbWSDMQfv/wr01m8AE694wgUc9qpR1Tv2ymHoBB8+zBtMmeIQviL0jD5pGMPODcuE5S/6xrP+gAmqD+dhc6JtOa0XHoumo5maYGnstGOO+zf8QA48K6ChUzHWB+qIG1NxJlPY8CdoIbKG3V7AxYptn5bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=seuVITICx440Fc0WtOIOQObWsLlIKhh1gWwbfMUTZ9E=;
 b=ME15nS6FpWTYQEDhO04PD1Yyu/NzPOHSL94rHdURP6OmEmLtisuFDwPcPZxceJoW7Vx76TnPrbpJS6zM+t1Cya3Pk7Lrh+EtyTkkM4f61Am2QopKeiBW7tvneQzaqfC95ZHBw9RD+oNLKxEgMoqXg1SlXrihFmWrvVO4zdXaZfw=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by MW4PR10MB5680.namprd10.prod.outlook.com (2603:10b6:303:18e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Tue, 1 Jul
 2025 14:26:05 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8880.027; Tue, 1 Jul 2025
 14:26:05 +0000
Message-ID: <9035951e-65af-472b-9120-9e7dee85eeed@oracle.com>
Date: Tue, 1 Jul 2025 10:26:01 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 35/38] vfio/iommufd: change process
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
 <1749569991-25171-36-git-send-email-steven.sistare@oracle.com>
 <IA3PR11MB91368C5C5D98CD165A9F53DE927BA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <IA3PR11MB91368C5C5D98CD165A9F53DE927BA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0131.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::16) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|MW4PR10MB5680:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f5bf06e-f4dc-4176-b8c5-08ddb8ab369f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TjNKMktJZENlWk5IMDRRNmo3T295YXpBTVZVTUhIM3pPcnRUbW15WXlqNUN0?=
 =?utf-8?B?cG5TeUpZUWo3V0dlZHo4UGVabC94c2t6Vmx2QUFNRllwZHhtOU41aEJaLytw?=
 =?utf-8?B?K0E0UjhLWlZzVmIvTjh4amZLQmdGVDR1dGU2Sk1tMENsSXpPUUM1Zy95WklL?=
 =?utf-8?B?aDhiNUhMb21DZXRnVGlRdHhRZTY0V3ltbGxpMGVoaE9QckpZWldCd3Y0L3hC?=
 =?utf-8?B?U3l1OUtXc3V3cjhaQXNOOXZPc0ZacGhEWktzNncxZHJZWHJkTWFCalpxblR2?=
 =?utf-8?B?eHF6UjdEZTZ4OURGbndWbnJPV1o2SXNDa0twV3BRTGlhRTF0RitlY1NnUEcz?=
 =?utf-8?B?L0JNTmwzLzFRTERETkJIcStjaEtQOU9STnFzTDZBS3hiQmxPc3BrWnpMNlI2?=
 =?utf-8?B?YWI3dWgzTGtXdHhOUDFMQ08rR0tRZUNXb2VoNWFtY1g2Zk1LaTJWTzlOYnNp?=
 =?utf-8?B?aFQ3Nk8zZm8wM0E0Tjc5TTJjVnEvT3ZmenA5L0gyQTd1bGFQS2d2Y2hXWm9u?=
 =?utf-8?B?eEdJRUQvamVRSHU5Q3BGbUJGU0FubmR1aEduZWNvMTBKcFVaUDh0VGFLNlBo?=
 =?utf-8?B?VVhMVFN3MlJmQktxU2hiUE9peUFpVFhtdlQzSXEwMkdnSllCandYeDdyQWxP?=
 =?utf-8?B?QW54UVNXak1Od3VQU1AvaEREc05ENDYveVArOFRsNnJVckZMSTRUZ3VEOE4w?=
 =?utf-8?B?ZGdTYW5Rald5MFZ5MEYxYUZpMHdYdEdhR05waEtzQ2RhVHpqZzR2cUp2NVBP?=
 =?utf-8?B?UU1lVjBrQzJadVNucmtjUGdEQytDSzc2MEZSNTU2VEJ1a2VJMDBTVHJGOEJE?=
 =?utf-8?B?b3dtUFRSWWtYemI2RzVScE9GekFlNVVvOFRGZGFJaWxMci93bWJPU1Yzc2Fl?=
 =?utf-8?B?VDJVWnhHVzNlT1JMOWdoVGdiOXBreTJuN1FkSW9oclBTUkZaNFYyRmlRRWNM?=
 =?utf-8?B?OE03Vy9va2MrcFhpRjdzejBPUkdScE1FOTZCOWpzSWQ3Wjh5UlNzR25QUVVO?=
 =?utf-8?B?bk8wSEpnMklUNWptT3hxTUI5V1AvSzR3NFlaYU9rcllpV1d2bUNMQkwzUzEz?=
 =?utf-8?B?REZweEFVeDNwU0ZFTFJ1bllTT01YUksyR1phZktrMFZ3bndzQXRPZ1Z2T2I3?=
 =?utf-8?B?dTg5R2VyUmppcDl1amt3OUN6eDIwQ3ZUd2ZJemg5dStua2llaTlrY2hiWDBw?=
 =?utf-8?B?U09lcnJyVkZ3WVMxTXdLa1p3dzhpZzd6MTg0cjI2dHpPdW96REE4UVZjZzZX?=
 =?utf-8?B?V0ROYVlRdjFwTmN1VXZDcU9IOThsRDhsVFhjYkJHNDFRY1JSc2pWVlVnZkhZ?=
 =?utf-8?B?Y1Z0bmI4dm40RXNBeEgzOVpDT0hKQ2tkNVBBekxVUXpSc092WEw5T0tSUUh1?=
 =?utf-8?B?SXltc1pwZGwyNmkvbnNDSnM1UlZyZkxld25USmc3anlZaWloZlVNR1JmRk9O?=
 =?utf-8?B?d0tyZW9hYzdsZFk0Si9EQzROT3B5WXBENnJCaGJ4L1JxaFFZQkJaR2tjdUYv?=
 =?utf-8?B?cXZ4aCs4cHRDL1cyRTdzNGIrM3A2d0p4cmt2WUV4dWNsYXBoRTUzL1JNY0dH?=
 =?utf-8?B?d3Y1YW5LVjJ4cTdmY01sdlU2NXY3UjZYL1lOUHF2ZFA5SHljM3lYazZSWlFC?=
 =?utf-8?B?aWoyUTJPQXVhRVJwbDhrUFg3K1liQkt1RmFYaFArL3h0VDRTNmVCc0Y2b3FK?=
 =?utf-8?B?U253VW1VVFFVWVVnNnJER2xpVHljanU5cmJGNFI4UkJhdTZNRmVLV1haTzRl?=
 =?utf-8?B?MlpCUkp2NnVQdVQveWl5YzEwU1JSVjZZNXYwVldqRysvUUVYWVJDczUvWGdV?=
 =?utf-8?B?cmlvVU02OVZIZkxpWjNWUFJPMmd5TWIyR1NvNmY5T1hkdk9scjl6RmthSG1p?=
 =?utf-8?B?akc3ODZYd2JRY3Mxcmo2VzBud0J2MktMU1FOM0pONGZWMzYwVEtYUStJeUdZ?=
 =?utf-8?Q?aHryS5g7dnY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTRBQm9BRHpzK2xIVTJSeHk0R2lJOHVYcy9wTDlPZ1R6OXppVlNwcXNQYjVB?=
 =?utf-8?B?VnZXc25WYVlVSGRUUUIzUnBEcVlzUTVKNGRDVDV0bXdVa0ZpUkFXdG9IWjZP?=
 =?utf-8?B?QWZVV0ZIR0JVKzl4U05vVTMyVmZJWmx0RmhKYWJsVVhpY2Y4UjRYRUI2RVF1?=
 =?utf-8?B?dTJxYS80TzZOcHp3dysrcTBpRFBESFZSV1B0and5TkpNS3kyZEg4bUxJWWVn?=
 =?utf-8?B?ZUJaYXJPa2hjeC9vMDEzbzRNSjg3ZzBjYTl6bXh3dzJ4MjMxVGdDVDFCZEZV?=
 =?utf-8?B?ZWZIQzVrcDIyREJWN0dhYlJ3ei8rcGFYQmpiSWNxN0p6d1I1K3lnY2dienRJ?=
 =?utf-8?B?OEZ2djlxQ25RbUg4YnU5MGRjU0k5UEJtQVV3Uk1acTJueXBOS2VZdzIrQk5F?=
 =?utf-8?B?K2xjNzVON3FrUmFsbFB2VEFKZTBDRXNaUDNOa01jUlVQN2ZaV3I1Z240TWRz?=
 =?utf-8?B?cGVVMGtQd2dNQXVvUExUVVpiUkZhQlVlQldIYit1NU5ld29qdWFGeEdrSFNQ?=
 =?utf-8?B?c3FjUnE5ZTl1MDUwYWp0NnJjLzUxa2F0cFlIcGZQVDhoU3ZkVFJzelZxcVpj?=
 =?utf-8?B?WFdoaHVkOEkrMVNtQ1d6aDF4SE1JSlE1VGlEMGdhWXArRjlxYng3c21WMXVG?=
 =?utf-8?B?cXNkQlJYWWw0WFpVR1hXUXJsUVNrN09mMVlhcGk3bU1tcjlxK2lrSTBKdmhZ?=
 =?utf-8?B?V0dmR1luNGxFalA2T2k3QXlPS3B2ek5CTW1sOFhsWjN6ZCtSM1RvV3JoNWk1?=
 =?utf-8?B?STh0RDdYNFdKWm1xcWljRU5wT1A1UTNSc1laUUZWWmxUNldNRUxmbHJGRXpv?=
 =?utf-8?B?VitKZEUvVjBzendyQkk3Z0l5eWNFTWpaY1RSTENMbnZaZTRRQjZtdk5WZ3dk?=
 =?utf-8?B?Uk5taUtBTSs0TkluZ0lOVTFqSW9ad2VrQjE4UVZSK1FHY2VVOENUK3dSVnpI?=
 =?utf-8?B?eXEyY29vYmIvMU44RDFSb2gza0RYcno2WWlrc0FuNTVIN2hybmNlT1JGWjc5?=
 =?utf-8?B?bGFwSzFwR0kxSzJlbUVrR0l5MStIdG5CWnMvUjdHemV4L3l1emtyT01jY2p0?=
 =?utf-8?B?Und2YVlWQ1ZoUStUb2JON3JhaUs4TTF1emY5SWpGMzZNUHBFNldmeXZtN0tS?=
 =?utf-8?B?UHNxY2ZXWkk1b0hqUVM3ZkJYTlJGL3VpRnN4b1FyZVRjRGJLQ1RxZkNadjBO?=
 =?utf-8?B?ZklRSkRIYXREbTZzVm5EL3J0Ym9DeWtqSWo5VFdhcUNJbTc2Y3pJcjRWSUVU?=
 =?utf-8?B?ak1sY0w1alR4WXk2aGlNcVB5MS8ycE83Y0EzTFVaSUxvTlV5bG9uME5aRmNr?=
 =?utf-8?B?WTRQMTBCOGl4M0xPanVCMk5SVUJBelFYakxacTA0UnE4THNzSHRIZE8rSFR3?=
 =?utf-8?B?d3M2SDRUcXFUaDc5TndjMzN0OWl4UC9kYVVrZDBKak1YR0ZZczVRSHpNOUVt?=
 =?utf-8?B?aExuNC9kL1dIU2VoQU9tV205OEhROFNEVDVrREhlU2pjQ0djMDJxNm8yYkJ5?=
 =?utf-8?B?a1BsdVJTdWg0VVpQYk84Q2RyUTJsdjUzU2xZUWNSRC90KzViT0NyV0NFaGRo?=
 =?utf-8?B?SW96NXlnUjI4SUFlUUI3LzNZWXFsOS84c0xYbXVvVEdqNm9Eb1ZRN0pSa1Fs?=
 =?utf-8?B?MWw3eTJXU0thMHdscE5tVGg4NWpyY1lEZTZ2cmZYSTRMMTF2bDF3b21GSE5w?=
 =?utf-8?B?ZlMrQUI0Z1J0aHJWbUl3R1ZIYTYzemZPUjlObjlSbWVJOGw4N1FVK0tXeUt3?=
 =?utf-8?B?YlpscklzOTFvaDFTdWhvR25qU3JENyt1UzVKc0g4QWFzbmZRK0xmL0prdGVW?=
 =?utf-8?B?cjY2dWtHMnNnbEsvQ2UvT3hEYXFzY0lOZWQwR2F4dy9GR1pzeXU0TythTU1t?=
 =?utf-8?B?QUJnUGQzZzJWRk1XTFEzRlNJOVp4RmhjU25VY3NTNElCRXgvN0pZWGZvdHM5?=
 =?utf-8?B?VHZKSGVVYkxwSVJSR29QaEVDV1NnZHkwUWwwWGRDQ0VyMnNWRTBONHY2MFds?=
 =?utf-8?B?UER1aUo1Qk5wdWJaM3hYM3FYeUlCYzU0SW8zQTNoWVN0T2F0R1RpNmJGcUR1?=
 =?utf-8?B?WTJLaGZ0UGw4anBqSFZUbmRWU0t0SnpUdDU4TDhOdEJmL1J5aThOVjdiRFI1?=
 =?utf-8?B?R2pCWVRYdGpOaWlKc3FTZXhPTWlHSHhxbjNzbGprWG9qbFFOZlZiRHBvSG15?=
 =?utf-8?B?UWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: m/XWnUFocCr+PB7h5b55GhC41Pz1mGOLx1ZldP1iUH5utlMOaX3AUV26WQGPuqlRABUCX5xJLPsRZZxxsNTE6dPwBXI0BPf0wPNOKdMwjW6PdzM6VZB0BcQiufdSYAnWH4rlvqDwoJ8V0/tMb612uqlY+vuqY73k26Of7vGCEozKecS7HM81CWgA4KKf8vkCPJL/hgbI4qhrlpFd9PyN9gmTqreHkMaeR5VH+WzKW0MiCjo+ZB/137qPgdVx9uyGXRpFWqhd5Gb1wvgnHgiVcqVMKomqBOse5E1ulZ6EbXFtl/dNTL8CXiRKtWKgg1NnR2nInj62ftc0qt7cn3ntB1IVDhiY57oTEzzZS16p4xSrPS9txfzcJvnSQ7VA2Iujqs2YXYC3HaOgBca/f1TLU0Y2sIduHqneMcABuJ0sxkmOfiqzbUWhq2q1erx9O9tnX99KVDltXkiMZyVpgnhn1UdQEBoSDPRdxDAcUDgBEHNmjohnSZz/jX/meFIXpRyUffZFtHwvJwyh/R7mL1ldpn2P3zEbPQk7A6qmHNsOh80agg77ZD6zUx91lPWd2D3afIylJZ4NSC6TUFc4cjEZbJ0J0CDI+ifRnDpKIvhfUyE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f5bf06e-f4dc-4176-b8c5-08ddb8ab369f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 14:26:05.3885 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OZx1a8iny0LVM3VxcQl6Rf/FtsJZ55F2yrqg2wsnA4odAkBedbouaQwGNigY2aBcZT74IuMiRAXBuHPI6CjhRqTpwVumiJE4WCIbQIDQ2VU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5680
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507010094
X-Proofpoint-ORIG-GUID: TOGxPcV47V6QUacjeXqjTMLspndaccE0
X-Proofpoint-GUID: TOGxPcV47V6QUacjeXqjTMLspndaccE0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA5NSBTYWx0ZWRfX5fBKH1uDFOHq
 aI0hASzrU5Mo52eeL4HNsO2FV6JWPYdfclTfnFrXgnSZi3tudmdcLIWklzZa6XDZwiZT7ZwaLxC
 /2TXLT+JAfDa5Y45TmE/L67pzTW6F+RhJNVSJP01xpBiU9iA/9urPFl3ICEGzvzCwA7jIqVUtqL
 g06lRX2AOTofVIpHucXLFWAkHLoIqKDsgW/GlmUBCJkbTuNaS/8wIMhzEiw0nDGbF0tGSfNGxll
 xu5nVuxR1BNOF/ADD+42oy5BSnALTebmZwUoKV0e3ysGmfzsS3i5vf7YDFg7+XkC1TES8DyWSvc
 DVVyc9+T91s2pXtgsEPeV4SXmtw6801aMnaHRx0eVsEWSVahKp48zRZuGmilonEjHsdiUeq/DTd
 En14pYNdYCk7A75SphMg5YHi3eCRt4I3oqbUfvntQak7EOmHu6RUe6e3UXp5l1CbFacJq4Gg
X-Authority-Analysis: v=2.4 cv=b5Cy4sGx c=1 sm=1 tr=0 ts=6863f00a b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=YOmlLxx1Y4CTJCo73UMA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14723
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 6/25/2025 7:40 AM, Duan, Zhenzhong wrote:
>> -----Original Message-----
>> From: Steve Sistare <steven.sistare@oracle.com>
>> Subject: [PATCH V5 35/38] vfio/iommufd: change process
>>
>> Finish CPR by change the owning process of the iommufd device in
>> post load.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>> hw/vfio/cpr-iommufd.c | 30 ++++++++++++++++++++++++++++++
>> 1 file changed, 30 insertions(+)
>>
>> diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
>> index 152a661..a9e3f68 100644
>> --- a/hw/vfio/cpr-iommufd.c
>> +++ b/hw/vfio/cpr-iommufd.c
>> @@ -110,10 +110,40 @@ static bool vfio_cpr_supported(IOMMUFDBackend *be,
>> Error **errp)
>>      return true;
>> }
>>
>> +static int iommufd_cpr_pre_save(void *opaque)
>> +{
>> +    IOMMUFDBackend *be = opaque;
>> +    Error *local_err = NULL;
>> +
>> +    /*
>> +     * The process has not changed yet, but proactively call the ioctl,
>> +     * and it will fail if any DMA mappings are not supported.
>> +     */
>> +    if (!iommufd_change_process(be, &local_err)) {
> 
> I'm confused when to call iommufd_change_process_capable and when to call iommufd_change_process, could you clarify?

Strictly speaking, we do not need iommufd_change_process_capable, because we always
try iommufd_change_process and recover on failure.  But, iommufd_change_process_capable
allows us to install a migration blocker, and fail with a blocker error, which is considered
more user friendly for migration.

>> +        error_report_err(local_err);
>> +        return -1;
>> +    }
>> +    return 0;
>> +}
>> +
>> +static int iommufd_cpr_post_load(void *opaque, int version_id)
>> +{
>> +     IOMMUFDBackend *be = opaque;
>> +     Error *local_err = NULL;
>> +
>> +     if (!iommufd_change_process(be, &local_err)) {
>> +        error_report_err(local_err);
>> +        return -1;
>> +     }
>> +     return 0;
>> +}
>> +
>> static const VMStateDescription iommufd_cpr_vmstate = {
>>      .name = "iommufd",
>>      .version_id = 0,
>>      .minimum_version_id = 0,
>> +    .pre_save = iommufd_cpr_pre_save,
>> +    .post_load = iommufd_cpr_post_load,
> 
> Do we need LOW priority?

No.  iommufd_cpr_post_load only calls iommufd_change_process, which acts upon
mappings that are already known to the kernel, independently of vmstate.

- Steve

>>      .needed = cpr_incoming_needed,
>>      .fields = (VMStateField[]) {
>>          VMSTATE_END_OF_LIST()
>> --
>> 1.8.3.1
> 


