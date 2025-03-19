Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 946D7C35FFB
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 12:15:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tusJs-0003tZ-8M; Wed, 19 Mar 2025 08:14:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tusJe-0003sf-Dq
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 08:14:37 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tusJb-0007im-Dg
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 08:14:33 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52J8fru2029210;
 Wed, 19 Mar 2025 12:14:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=CL22qUStrE2X10YQAxWUUG+Neh0rKEm1vSWRNchQMKc=; b=
 YYFQ8nzGIrI6/m0XDi3NN5G0JuxQzPVMXMKQ8KUBv66Hu7ZoIZzAubgIP2Gj7iDs
 PtN/UQMStiQZ5cSIftddIoU0ENDGuMDOxTYbSJyjFQ7Rv/YG6vtInmAOuK3HVO9w
 sK2ls68EWWJSKTAuFD8IKTYZhs51c7VlOlq03b4oORtfatv3juHtNmt8S448KV63
 0SwuPwxsrCcn2ZGX+SgQo0EVKrjLzrkVYRkroRz2mGrzydsDVJzzZKbEHpmBoleK
 8NK2BNNC7eZMmuqRWywfMusRwRQQvQe1HuI62Wh/1iQfCOBUQluoyQYo/hm88MWo
 dRGFfOsPiJOVTtYAl7kkQA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1kbb7ku-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Mar 2025 12:14:26 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 52JASKI7018488; Wed, 19 Mar 2025 12:14:25 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 45dxdmhn6j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Mar 2025 12:14:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l8GAAWAN65fgSI8n7PViWILvtgI0DceTXGAfdpYaiYvDKqRDJqPp4BA5UB+kpFAcaSR3kIFMgwIu7JvuoipewjOZHR06kMiXldRbGsQzKtuNViTMaT0TrcxhmECRTjRLsyHoxj749MFFeUCAHbzhce1+iWL/i6iARuFsG96gCLsjmHEN+G13S5ZULG9D/JB34lO//a13BM7LVuYNHUyIzLSN7En1I3p6eUg7zzq5IwXs+J961H4bEox86jc+BESj28xmJvMMzQ1ZRyzF6Nt6tH8gMcBNibyFQuSqRMf68cgkYaxXDeqigY3fRfEWwU/8I7ojDSdEMMgxRG72rL6TWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CL22qUStrE2X10YQAxWUUG+Neh0rKEm1vSWRNchQMKc=;
 b=IMnyRFaEKfxlIiGMdtmlLIi1XROpK3Tb5zPqyPMHjHtEL7fZZ7PHMWr98KKdG7bYfGs3TXHVs0j389Hl8ukgcuHvFdelCGdUogk1VD3g+nvoV12BXFZhv+if+QcWJtQQo98piv2VKdtVzIkVNw8pknA7N4s0rusTtuE/YkTA3N1DrCIDo3XEqx38b6c+obFvUmFnwQbQ1/sY1b6a5/XL8qi425hlPBQRZVGIOfgeuAqzTFOWiRolCEbxlF0NZnz8B4pe3qxLlW7IWeXq9OX33X+7HUbZiJWKEwC4ZYvKsyte0sicetD2L6bEitPPuWAPuXS6eobQfT1Yahirm2z9dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CL22qUStrE2X10YQAxWUUG+Neh0rKEm1vSWRNchQMKc=;
 b=XHOsk6B7OuCaHCBTcuo8gcdicSLUFte/AbgF8TrRXxgbINbtloS04SG+HNmhYhg22oIRu9nhlK5UFExETfV4l/JmcCNoiAoTDRV+4ldL93EIpuWR3Kz3jCKBeaHent8tpwvQAu/z3xHPY9ay4T3UxFfoYvTwYN/vt0CDpTcu3iI=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by CO6PR10MB5618.namprd10.prod.outlook.com (2603:10b6:303:149::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 12:14:22 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%5]) with mapi id 15.20.8534.031; Wed, 19 Mar 2025
 12:14:22 +0000
Message-ID: <7418bd41-44a1-4643-85bf-6a2dbe7975a6@oracle.com>
Date: Wed, 19 Mar 2025 12:14:17 +0000
Subject: Re: [PATCH for-10.1 28/32] vfio: Make
 vfio_devices_query_dirty_bitmap() static
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org, 
 Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
References: <20250318095415.670319-1-clg@redhat.com>
 <20250318095415.670319-29-clg@redhat.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20250318095415.670319-29-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0005.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19e::10) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|CO6PR10MB5618:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e25ac8d-1ed6-4c6e-7a59-08dd66df9520
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V3E1c1pRRUEvcWRnaHdrVlN0YlNlOGxsY2hsV1BFem5MNGxFWGwxem9Db3pF?=
 =?utf-8?B?cnozODVscFVkVm13Yis1ck56andNaG1hRFRGTGhMTFY5QnVrZGFmSGVlaTJt?=
 =?utf-8?B?R1ErLzZsTEU4VkhzOTd5OFdIaXU2TjNOc2YrdVZYVVN0YkI2TDg5bGV3UHBq?=
 =?utf-8?B?R3kxaE1mOUNxL0VWaXYxQjlxT3QvV2grZk5KK012dFBwWnhrTU9UYW94dFJF?=
 =?utf-8?B?bWNVVisrbUVBby9DSkxIS2dmNmhOeWZPSkhDeGUvTXI0c2xndUZFcUJrVW9D?=
 =?utf-8?B?QlRIam5OWGc1bG1MZWp4bkZLTDdWVHM0MktSQlYxU3ZUZUlHRkhUaVdOWGZK?=
 =?utf-8?B?RVQ5NjY5VWVvKzVzWUNLa21uYU5oZDI3QXNySWNKTmhpazV3M1o2enNzMHVN?=
 =?utf-8?B?NUZHVk9iT0xDOEM4Wm10eWdLeTR1L09VcHRpcUV1ZzkrSHJBL2p0NkxJTldV?=
 =?utf-8?B?NHIyVDZMTGlJV2dWSkI1dGViS2M0TEVhZVFJVlpNazc1WGVsS0dNa2NUN0xv?=
 =?utf-8?B?Y0p0eFdacXh1YXcyWjFHVnQvVmN3Q3MzTkhaTlNhVFNSRmJ2Tk9EU2c2UlBn?=
 =?utf-8?B?ZUxGT2x4dnNXTW1uYkpxajdZWE42WjZzUWtFU0xGdWptU05OUGZsQ2VkRHNL?=
 =?utf-8?B?Z01vWlR1eTk1RklCTEdnWVJGanFPdGtvZVZteVVmbDNGWXlURUVoaTdJaDR0?=
 =?utf-8?B?R0F4M0FFVkcwamZqZWxyR2pSZEFwalRzY1dlTmtsSlFZb1JmMFBEV1NGYVN3?=
 =?utf-8?B?OUpvT1VKQXMxMHdiNDdOcllMMm16SVlKUGxJbDFaWDhPQ1NVK3FKUVZTT3F5?=
 =?utf-8?B?YVlCSmdCSEZYMkxvOWhxck51R1lnWk1UdndrdHVhN2N1c3lFdW9lQXNoeFdr?=
 =?utf-8?B?QjVOcm9zR2tpUlNTdlRMeCswcXRJWXh1d204c1poVkV4Mkw0ZDBBRlZOSTU1?=
 =?utf-8?B?WFMyRm0wSFFSYTAyVGp2WW9TWHVscHdRSkQyQnYrNGJzSkMrZUlQUE0zRVlL?=
 =?utf-8?B?aG9obzI3SFM3UTRXNFYwamtPcGd0djJ4UTY4TTIzSEo2K1MrclExYmR2U0dL?=
 =?utf-8?B?RWdMLzZTaXRycDhLT3h3cjZrMzllNmo5NDZmbFlhK2dpQXB4TklERVJBdE1Y?=
 =?utf-8?B?blNUSE5lU0toL2tka1dLVWZuSmlvKzNJbWJmVjQ3Qng4NEFsRlFwV0U0MjRv?=
 =?utf-8?B?MXB6OWdNenZ4SG9lSE5GcXRYRmNINXNMN1UrN0ZWNGxDRDBZM1NwRHB0VERr?=
 =?utf-8?B?TDJYblZIZDZKR3lDMmxRRWorZThZUFpJeHZINnRNM0xWdlB6U2Z2dU1qYlps?=
 =?utf-8?B?MzlsQkFXQjQ0Q1BLTExkeEVadFA1WEthcmlQTmFNdHJQMWczYVpqVVN3WDhj?=
 =?utf-8?B?Sk5nY2NEa3pJdXczempReTZJSksvR2NRdk5LV08vL2xSOUdhaE9lc1Mxek1j?=
 =?utf-8?B?TVZnaVBwNlpxL3RBZW1vTGhEaWhEZHJBcXNhRVpwRllVODgxMXRzNnNodTBv?=
 =?utf-8?B?Y0YwV3lRakR3eHFmVFRkbHhxUTQxSUdkcEcvK25rN2s0aSt2ZlQ3dUN2N0lY?=
 =?utf-8?B?TEZTYURoQVJmUWZMbGhzNjJSOHdmbHBSOGZFQjR0KysvTnBpRzFUQ2wwMnZn?=
 =?utf-8?B?ZU5XckRqOWY3RloyTGtQTlN3a2psR2U0Z1BDR1FTODVLVW1VeVp0SUIrRS9r?=
 =?utf-8?B?TXpPZDdWenFwVTFCYjE5M2lUaGNoRi83VFdUeEcvaVZBVkJ6NzNQMUtOdXhx?=
 =?utf-8?B?QkkzVzBWT1lKeGxZTmNBbzNnQUIwNlNVZFBWMCtmWlBKdVYwQnVSMHRtam9o?=
 =?utf-8?B?anF0eE5hRlFFaXZxc1ArVHBsdXVtVU5NalBEd1NsZm80bGd2UUczQm1QdFE5?=
 =?utf-8?Q?EvpAPFRSkfJar?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2ZydmZYS3BLZFhDcWFQSEMyaGVLVmpncXAwNGJNdVllVFlFdTNhdTZuSVNl?=
 =?utf-8?B?ekFTTUN5Q2lnbmVVWFFWbVVMUTFJVU1MQ3l3Vlg1QlhlVlJTR01CUEs3VWgz?=
 =?utf-8?B?TU9ZVHpEaUVMRDEzM3V0NDVnVjFaTUx1RFJzdmRjZHlQYThiNFRJcEd6UVpM?=
 =?utf-8?B?Y2R1aXJBR242MmZyYWNIYk9yclNEM3M4dENVN0QzNEg5QzBtcGgzaXFhNDd5?=
 =?utf-8?B?clBjcmoyaFJoSGlqZTQxdWQ5aTN5d3cwK0FWYzdtMTJyaGZBZ1p2MWw0MHlR?=
 =?utf-8?B?TzdnSExiRHVzOVJqRVFjS0NxcXkxQ2F0SDRNQ0Q4bTVXZ1pxOWZpZ2pTN1dN?=
 =?utf-8?B?cWlsc2p5VWFnMmNzTnJWUWV2YnRHMitHeTZFT1JEUUxYRzNXaFIrQjVVM1ZW?=
 =?utf-8?B?Qy9qRllQWXB4UUYvK3pQdlVNQ2N6Ly8rTTdUZjh4YW9CdXJpclU4OWc0b1Qv?=
 =?utf-8?B?RUpERU1uUmh4MmE0dDlYdjdHK3lCVUNmNFlWVjYwTk5NaFRzYzZraWVKT0RR?=
 =?utf-8?B?TTVNZ3RncysyaDlCc3V5MEF3OGVEQ0F5Q2Y5WWd2NUplV0x1WmM2L045ZjV5?=
 =?utf-8?B?Y25sMlpHV1dkcEV6R3JCenhSL1J6cmQ1M2Z3bGtNZjhuMTVNRjFXSmtkMTdh?=
 =?utf-8?B?cVFVVVplR095N3FkcDMxVDVWcWw2blBlZERyU2s0VlpLTEFXOWFDRFhtU3E4?=
 =?utf-8?B?aCtwT3VhLyt6RGMvbUtFT2U4RlhYMnFnRFFOYmFjT1A1Qks1THNWOW5ZWmxW?=
 =?utf-8?B?S09qSnJ2WTRUUE5UVU1sS05UYnZkZ1NBTFRRZFBqbVExMjVxSFM5a2VUM3Ru?=
 =?utf-8?B?ZWxHbWlVb1kreS9YYjAzR3NidVVNWWRUNVlRMWpqTTRza1doVFNxQWkyeUJ5?=
 =?utf-8?B?UVZqS094YnJHSnVBU1U3ejRocWh1eHBXakVtQUViWTlSeDVpdDZLSUVKWEpy?=
 =?utf-8?B?bXVqQXBtbWRBeUdvUk5ZdEI2Q3ZwVVdPQU5RcldGTUVXR2htQTl4UWZmbUVl?=
 =?utf-8?B?RW1qdnNZbmhRKzhLcXlZSldONlY0dFJFSGhra2R4RXlhVjhrVDloOHgyUnNy?=
 =?utf-8?B?OWlqdzBOaktkRStKVjNrMWlBdjFxUlBKMk5FaHNxYXpxeUZscGdWbUdSVmJ3?=
 =?utf-8?B?SmlZYWEwZ1REbnMzMStQeVAyUEN4VUZ2RVlZTEFPclB5OXV3SGN3SEVjUTQ1?=
 =?utf-8?B?R2RLTmhsaGVwRVIzRFI1WkNEdDkxTW4yWURGSzMrbE5yRklId3B2anZkZG1P?=
 =?utf-8?B?MlhjZlBhNzU3NXpTWmNQekZFQTJ4MmRXWCszNEdTWXR5RlVIWnJEZExVMGtS?=
 =?utf-8?B?dmNmdjdRM0hlcVVhRXg1TUJRSG85c3NTWlFVMnZKeUorOVdzc0lQMEl2YTdH?=
 =?utf-8?B?Z3o2LzQxVVNNOENRWGhPNmd4S1NVbjNheGN4aGl4clQvazlFK29DNnpYOS85?=
 =?utf-8?B?S2dkMGRpeGJKclNlYmpBbmR5aEQ0RWkvMW1hUVJpMndZM28yNjBWd25oQkE5?=
 =?utf-8?B?MzZ1dWpzQzJVa0puRXJQSXU0MnFUYU1kNDQwSC9ycUJJZXBLRk9DamtrQkdW?=
 =?utf-8?B?NUc5SW9NNXh4ZTk4b0JSeGlOcjJCRFN4UmxIZzBYUnI2LzJFZVVIOEdpTjcy?=
 =?utf-8?B?MjV0Qlc0bHlKd0VKTG5IQTFHTjdKOUdwU2REanJBazl3YkZoWEpRdlNUMS9o?=
 =?utf-8?B?cmx5a0JXSjFmZTEzMzZVTjdvYi9KUEVicE1vRTdmZ1RweTA2eDNZVVNZdkJj?=
 =?utf-8?B?NFJ1azJCOW9hTC95MVpxVnFwekVBakwxV3kxNmJieEprN3lEbHdXVWRxcWpo?=
 =?utf-8?B?TEhncHkrOXZPamUycnlvZFdmN3h3UDk3YkErMTNENUxZRVN5RzdveS9yRHl0?=
 =?utf-8?B?dTVMbGhFaHA5UzVhUTNhT2JrQ0VmcFh0S0MzWm92SzVZVE1XeEN4OHNGTGp5?=
 =?utf-8?B?eGd2bmJCU0tpWDVzMWdmaFVkaHpvTXkzRi9VdU1XY3psVVZGSG5SNTRtdHU4?=
 =?utf-8?B?Rytic0FsVTBKQ1lGbGtFaGpPT0VVQjQxdDhDSjVpUDF2dWpDWE5uYjVpWjVR?=
 =?utf-8?B?NWlHeWIvcjFqM0hoblE0SVdqWG9lL1Bxb1BQckQ2eUpsY0tFTlIxaTFsd3ZR?=
 =?utf-8?B?cVNmWk5IUm1kSHg5TlFIU3I4NDVmWExTSjNsalVKSjAwK1J1TkQwTHY0WDdB?=
 =?utf-8?B?a3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Tt375oXW3HNiQwx9E73poCRV1AvszMkw9fGDwM5HjDcderyDzZ6gzgaSnA1mwBfD1nyptAoIKL5T8pdkLiSnrNlYbV8UJB15vu3osp/zcL5QL5aJLyfvBDHnDDbXqJ2419BYwSk3wSfR1oNIGdDHTRh/Aer07GTXa3vdD3k64cxeP1lA08zP/Rrkjk4hbVvH1Ipld/PMr7U/vb5sATSZ6tLC/6CSxM+ipAkdl6BNLBat96H3zboFTWJGucgyg1BD8K9RXXyqa8pRFkDm4klyhkj4DtWsUBNTK8FTptYrEr3BG0LNcqX2XnUVmZ5i+ixWvUmnyrds05pvzw1YgO8uSse6IlV+jaaUIhwu/t5qH+kufZq3138wqq1TQBRDeAdVVorA+gp7CE5LFm1zYhOusNci07uhfp+FJUZEmZoVVv/igwVfgTylVPjBsrFWXga3Qm57ej1tftfNeyiG43U6c3XCl5IaOkSSSt4AF+0k39Qkz3p0nmTFmGe6t1YIQqLcA/vcV8XRnJULOfjFDPQuAak/b5Iq/bdGS1E1tBmQmk1tgJngSz9Lrze+q/QLJ7X+P1noRf9Zrejkm4cp1UnTx/BVyhAOm7ZdUXFXV5QqNLY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e25ac8d-1ed6-4c6e-7a59-08dd66df9520
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 12:14:22.4923 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Br09r/FLmdwZBdGzOsW8J10sDpHzdZ6U/gH+vQhwmzAFo1pLCi+K+hFMYEmR5xklgtvGqyA499+HuZuhtdCvnlsonRra0FQgSYlzvVfjXy4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5618
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_04,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503190084
X-Proofpoint-GUID: OBWxm0T9xo_2vXm7Inq7QEiMQOqFwje-
X-Proofpoint-ORIG-GUID: OBWxm0T9xo_2vXm7Inq7QEiMQOqFwje-
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 18/03/2025 09:54, Cédric Le Goater wrote:
> vfio_devices_query_dirty_bitmap() is only used in "dirty-tracking.c".
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>

Reviewed-by: Joao Martins <joao.m.martins@oracle.com>

> ---
>  hw/vfio/dirty-tracking.h | 3 ---
>  hw/vfio/dirty-tracking.c | 2 +-
>  2 files changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/hw/vfio/dirty-tracking.h b/hw/vfio/dirty-tracking.h
> index 4b83dc54ab50dabfff040d7cc3db27b80bfe2d3a..322af30b0d5370600719594d4aed4c407f7d2295 100644
> --- a/hw/vfio/dirty-tracking.h
> +++ b/hw/vfio/dirty-tracking.h
> @@ -13,9 +13,6 @@ extern const MemoryListener vfio_memory_listener;
>  
>  bool vfio_devices_all_dirty_tracking_started(const VFIOContainerBase *bcontainer);
>  bool vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer);
> -int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
> -                                    VFIOBitmap *vbmap, hwaddr iova, hwaddr size,
> -                                    Error **errp);
>  int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
>                            uint64_t size, ram_addr_t ram_addr, Error **errp);
>  
> diff --git a/hw/vfio/dirty-tracking.c b/hw/vfio/dirty-tracking.c
> index 143cc5cf62b0165565e91f8a2ca166026f16b1eb..9b20668a6d0df93a2cfde12d9a5cd7c223ae3ca1 100644
> --- a/hw/vfio/dirty-tracking.c
> +++ b/hw/vfio/dirty-tracking.c
> @@ -1016,7 +1016,7 @@ static int vfio_device_dma_logging_report(VFIODevice *vbasedev, hwaddr iova,
>      return 0;
>  }
>  
> -int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
> +static int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>                   VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp)
>  {
>      VFIODevice *vbasedev;


