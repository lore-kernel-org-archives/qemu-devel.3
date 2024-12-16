Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3232FE7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 12:55:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNAcV-0007Hx-0m; Mon, 16 Dec 2024 07:54:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tNAcS-00078o-U1
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 07:54:41 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tNAcQ-0004te-7K
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 07:54:40 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG9MrdG016580;
 Mon, 16 Dec 2024 12:54:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=7gbRkAGgo1rpAfBVN+vuVIiJSWtbWLuH7QabEX3ZHm0=; b=
 eWZI/PDcfx+8WBUagkJ/Gz8xTJBcCWEm3JaUYKELfe501XyBxxWVLEBl9CZlzLis
 WT6YcWlZIlbmhTspzF00ad+05X/iXF6kDZdiGg0NfvKvfGUq/uNSPuouHWq4+ZZ9
 /31HdiAxoqGLkXW75XmdTnsI+pH5Gw1S35emc+9FkaRLs+AqtruFPnQbYo1k1NRV
 z+XgFqdLTLn6/+u+NSgS4eXFZd3TMqP+49YjigJw30QgHuTqa0ylmv5eGjJN5K6R
 FnEQAjcJo6VW5vcMqUDvsdTvrCWfLeQATfp6uQSljUH24jWsh43j2i/zYnccjroF
 THkqLj2dTkcAAA0+lqcEYw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h0m036fc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Dec 2024 12:54:35 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4BGAokxT000995; Mon, 16 Dec 2024 12:54:34 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 43h0f77m9t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Dec 2024 12:54:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GNWIjMtr9BZk8mdBDLwTJpKDUiQ/0efA0wSMgaB6S+1HGKNPKcdcoDnGhfMLEvbwOjh8Ywxi7z8nZEd+wILevIi+3ozOCVJ+CIWeDP6sTU4nfqcud4015Bo4C0cqNDeHjGZvjLM42p0KQetAET3i/ZL2ERAixwHgrEBm5gPaa9PYqlqq2n4RcMQB0jSE71/KztHfcdk91vfEAXKjkV0TXf54quRe208DKyK4B5/orxo2xoESz8rQDjMgs2WsIiRe3fqyMrj+lY5q96BeuNKjSZneBAA9AeMzq0j/I2RgX4jTGvo6SVDbKo6rZvdxasyu5SMudmDU4Qbpi2MMSW+hgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7gbRkAGgo1rpAfBVN+vuVIiJSWtbWLuH7QabEX3ZHm0=;
 b=vcg7f9fmGFl4P7sZy1AEQswRnuWp/Uv8KRaU6D2HaIdoBcrw4qzX0/P64yyUHFSRoTMMyPmDtnpl4FbTSv8V5gVyXTYDUtPpXG4TLTuenKHTYX8ZGn/NoZmtHA8jkpbnkeaARYBJC4AHbL/zpYQlm8BsC+d+m/HVcZpgUfYMmFatt6vM0wBFnpwg2VC5qaDOsOmVqchi9y+0ystUsax5LR3n7sdOk4/V0p9kAx2DW2FY6/sFg2a1MeD2iWYHQprreS4mlB8HBJBMs0o9RgwpO/s+yIV4XCUtTwDiU6dwzqii9NrNofbGbAkd36xwYv64gySW6ABesRGOihZS+w7cuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gbRkAGgo1rpAfBVN+vuVIiJSWtbWLuH7QabEX3ZHm0=;
 b=J4DR9mG3CVSXwqpcO0zJjTOUiflc/dgXPeCR+R8lU8VAUsSbELc82Ix0efUSxyNa4XRj18C2JuJ5+CjpcUMXFmHvUN6ytwgAHfadJsoxdH/e1+B4r1VGE8h8Qy//t5air7hxJfe20Zm4yJ6FusUMeU8sgQT8Mes2WaGrHjPijiM=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by CY8PR10MB6827.namprd10.prod.outlook.com (2603:10b6:930:9e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Mon, 16 Dec
 2024 12:54:32 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%6]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 12:54:32 +0000
Message-ID: <44e89d2c-1549-4adf-aab2-1b212dda0530@oracle.com>
Date: Mon, 16 Dec 2024 12:54:18 +0000
Subject: Re: [PATCH 4/9] vfio/migration: Add
 vfio_devices_all_dirty_tracking_started() helper
To: Avihai Horon <avihaih@nvidia.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hyman Huang <yong.huang@smartx.com>, Maor Gottlieb <maorg@nvidia.com>,
 qemu-devel@nongnu.org
References: <20241216094638.26406-1-avihaih@nvidia.com>
 <20241216094638.26406-5-avihaih@nvidia.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20241216094638.26406-5-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0193.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::18) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|CY8PR10MB6827:EE_
X-MS-Office365-Filtering-Correlation-Id: 48076a3d-bded-4391-cc14-08dd1dd0c8ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YTBHQkFucTNGQTgzM3VLRUIrWVRxZGx0RmI4RlZyMGVIejRlbU42aWhIQlU0?=
 =?utf-8?B?MnZwV01zMU5wdVFDWEg3eXlYWDFtbTV5Y01BS2Z4ZkgyV3RsU1dld2dKWWo0?=
 =?utf-8?B?amI5S0VxclRUNjFtYmNGT1J6UnBCb3FsZWZJNTkxVVdCK1JCNlJXSGx6bDdX?=
 =?utf-8?B?T2xkZ2VSUVBRSFhINVJ4dVJCelVHbHBwRjQ2T1paRWJFWXVqM3JXdHB5Z1pn?=
 =?utf-8?B?RVcrNm5ZMXZHS0ZhZ2NHQ1ZOeVNPY2hkWFloMEUxeUFLYkZzYTBxN2gzMGI3?=
 =?utf-8?B?eEVjS1o1bmhic2QzYzNXeEFNT0xwM1ZoT3dGWDNWckpkMVBNRXJUZDI0YWg2?=
 =?utf-8?B?dTFhMk1EeWdsVW5YSFE3alhwaE02TUFzeitvZm9FbVNGb3V5QmIrKzdDeEdx?=
 =?utf-8?B?d0gwRXdMTFhNUHhQM2lJeFRZZ2daclJxZ1ZOQmN4Y2p1dGlIL21OQjRYQ2x1?=
 =?utf-8?B?QS9XTkJoS0lvZUJ4RVEzR2pIVUx6ZjRKU0haTG1FQ2NERTlJSE1zZ2UzT3VC?=
 =?utf-8?B?UWtuU2ZmeFZVa2JTYUt1ZlBrdFNvbExiQmhMTTRTc2UydGdjS2Nrc2FYdml2?=
 =?utf-8?B?b1J6Mmk1Rmc4VUEyM1FoOGdMemMrTjRNbXp1bzQ5RG9MZi9QcFUydFlPdmVw?=
 =?utf-8?B?RDFSMXhYa2dubFNrQnprZXRpYXloZVJ4RTdITjNhRS9nY25RZ0tJLzkra2Vu?=
 =?utf-8?B?TDdMTE1KMTdDUTZ2bXFzWHBZNmdsSmMrS21hdUNObkttYm9QbVJkWHArYmlY?=
 =?utf-8?B?Mi83MG9rcGdOcTRsYndjWW94NnloVUVyMkM5RUJXbGlUWXoxNksrM3NUR055?=
 =?utf-8?B?Wi9sUDZWYWMvdXgyQ3FRdXp0c2V0NzBOSGhCUzdoK1dqQWhBbXZCbmZLSTVm?=
 =?utf-8?B?VnQ4SFBUbEQwQW04Vzd6U1pzcFZtT3V5WFJ6Z2JPcjFJTXlpYnE5ZmZ3bWls?=
 =?utf-8?B?cFZPaCt5V1hxTTFqb2xEZXY2clFPT0FsODJZUUxldlY0bnhHeUNLaHBtK0d0?=
 =?utf-8?B?QUUrYmx6MEhjbWIyQzd0L0hTbEpBeE5jaXhzdFZzd2FFZlZGK1hBQ3RhSVBQ?=
 =?utf-8?B?V3NFekR0S3VuZUFxejdEQ1Q2Yi84WmNWbjl4OHNXTk5KYmtreTV1U09QMGln?=
 =?utf-8?B?YloyQXFib2tka0ZCUDdNSUMzc0RHZllnZUw2U2NxQytJK2txMUcyV2RGM0dn?=
 =?utf-8?B?eUJQT0Q4RURDUjB3UVd5cDZzTlNUdyttaWFDTDhOUHV3T2NQYm9qYmpwOEY0?=
 =?utf-8?B?OTd2aGRHK0lYbmo0NnMwdjRtWXJRNXBnSVIxWmhDWk56NVVNUjVMcUpjSXJK?=
 =?utf-8?B?aEJyZFlxU2Evc1hYUTlzaGhKQTBNN1JoK1JsT0IwbnFMbVhubDZUWFlFdzFp?=
 =?utf-8?B?dHlxMFJUVEx1dHdiTGRNOEJacllJTU43V1JxVHZpeEZ1bFhFV1hYbUVsb0hi?=
 =?utf-8?B?dENkZUZsT0c4QS9zTVFMenBNL2pnaGY5WEVqV2FVc2d6SXp5OGRYY0pFRnBN?=
 =?utf-8?B?aDhoTkJ6bzlySUh5QUFWRmI0cGtOYUxXTVo0Rkx0R01GT0plZklUWmJQeTl2?=
 =?utf-8?B?a2FRV0hYdHpOYW1mNGtlRkJDK09BZXBkTUNWRkN1UzBPT3ZuNFRHT2tSOXJk?=
 =?utf-8?B?SkViWmppYVlYRW5INS8rWjZsQW5TOWMxVEFmUGVQbjNjekIwWmZwUEF2Wllw?=
 =?utf-8?B?UkJ0USt2eWhFai9UWU1idDZ0VTV4QlBmVTE1b3pzQUVhU3BUN3RxT0NRVVVk?=
 =?utf-8?B?bTVLSUliUFNjSTV2OHFESGtsT25TZXlvQS90VEg2SGVIand5cU1iaTdZMmxN?=
 =?utf-8?B?U0RETXIzMWxKcHFzZzZzcnZ2Qm1qNzVFU3NiYno4L3UxR2pwMFo3WmNFZ0Jj?=
 =?utf-8?Q?K3/YMCkxfibvF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZE9KQ0lDU2pzMzc4YnJMTXo1Mm4zck90YUorQ3FIOFpBZUlLQy9JenpjS29U?=
 =?utf-8?B?Q1kwWlJnV3Z5SkwyTUpSL2RSbFJTUmtkMS9KaUFzU2IyOFpRdXg5amdWMzlV?=
 =?utf-8?B?YU81SjFLZGx3TlFURkNzMlltOHlTODVaOXVHUDBhek5sWjRuaGVmVGFKRGFY?=
 =?utf-8?B?S0JiSUs3ZnFzSHIvZjRKMFdhT3oyYlc5a09BSkdEWDBFL1VraCtKQ29kRWZW?=
 =?utf-8?B?UDVyRHlvYSttWFRacGEycUlxMXMrYkk5OTV0VzMxak9IQUVsVlhuNDhlU203?=
 =?utf-8?B?S0dUMHE0OWtPRjJuSml4RUs4OHZlS3FVYy91NFh6R29CeVdaVG54RklwRUd4?=
 =?utf-8?B?ZldVMHlQcys4L1JHbnJMTGYvUzQrNkFFUVFDNy9ncW44QmxkTXBBV0pZMWVX?=
 =?utf-8?B?VkJ5eWhCQ2gvc2p4ekdSOExBUGplN1ZoYnZrVTl1Q0pSTW9oTGcvRTJEREZ4?=
 =?utf-8?B?Z2gvNVFIbFFWZXI3TWM0Mi9EWlNla2ZqTHZndVhTb0hnNkIxVjVZNk84WkhH?=
 =?utf-8?B?OU5Rc0tIRitQLzNoOGtMUk9EcWxTQkQ5WDF4dFV5TjJrTzQ2bVFTOEM0cEcw?=
 =?utf-8?B?MjAvTFcvUmNlTWlGRzdBMlo1azBsSlpVWXFkVG5pU0NTeVB5Nm91dk9VOGFq?=
 =?utf-8?B?MGtlaHlOMlVucy9PbmV2WkJZSlF0aTBWWEZjRnYrVUtmNHZuOCtvK1NtRmNL?=
 =?utf-8?B?bXdRYmsrY0FMdlF2ZlIyQUsyVi8xZ3oyNDgvcHhSeGxqUTJOdi8ybjRoa3lw?=
 =?utf-8?B?a2xKV0pMeldDVEtzNWZGS2xoMzcxdkxBWTJjVU5YTkV1Nnk4THkvWmd6dG9D?=
 =?utf-8?B?ZExhUVZiSHdiY2kwZ1B0bzJFaW1uSFpUQ0w1VWVWUmJRUnVoek94THMzbXNQ?=
 =?utf-8?B?VGhOdmZCeHYrNGNRNUFIU3ZuYXpDMHJwNXZvcVJUYUxGL2JFN1BLdldubU1L?=
 =?utf-8?B?VzM3Zmx2ODgvWFBFcWtQVExKYm52QmhqVlJWOS9PaW1yVDNOQ2JVOFNWdjFu?=
 =?utf-8?B?TW9ZTGEzS05LaUU2Tm9Mcy8wRVo2NFRlc2J2Rk5maFNFSWhyNmExQTVxOWxX?=
 =?utf-8?B?bExsOXJyYXlDb3JCQVhoTWcwV3ovTWdnMmdBRnQrN1NnMS9hL3dPb0NSd01T?=
 =?utf-8?B?NjcwYWVkVHFIVElGMGlJWjloVkNkZkhCaVdCMEZLbjFQdGR2SURnTDc2V2NI?=
 =?utf-8?B?STc3eUF4TFU1b2k4V1lTenhDMjQ2VEE4c0cxUkxCK1lvcjcrWitPTmNIcjdl?=
 =?utf-8?B?b3NzSzQrVmF1T3BscnlZNWxXL0pDaUdUS2tuM3lvdVQ0UTRwSUN1ZFcwUUFI?=
 =?utf-8?B?c2g2bjUrSGdsM3lmUEpSVE8xeUQyUzNMSi9qbThjdm40cXErUFA5MDQra0lz?=
 =?utf-8?B?Wmw0RDRuTXJWVmtEcCtWc0dtRm52b3RLYlFkcU5MSkpwV2JZRHhQMTE5OEtK?=
 =?utf-8?B?RXpialZVcWJvZm9WRUxsWFVpd2NNQzZhc2lSTDRPUW9jSDBJbmVwMVJYckpX?=
 =?utf-8?B?RytVeEtVY2t2OS9BK0RnREU0WE45aTd0clRDM2tGTE5neG9GaHRZRllNeWph?=
 =?utf-8?B?Rk9TTWU3Mk9nNVp1Sk9DWjdOSVF0SGttZXBlOUJINlNKSmh4R1Rhb0ttaHJB?=
 =?utf-8?B?RmRQSXh6V0oyZmwvakdKSWkvL0FvMW5xdWpwZkRkZkVrS3UvUmVIZG03UEs1?=
 =?utf-8?B?aUhmMG91cE5CUHZ5aGhRODU2ckN6cGhMMCtBeEVKRnNGNlZ6ZWl1ZytDVk5F?=
 =?utf-8?B?S3hEeWNKenM2MGowdTM2RlUzWHBrM2RtSll6c05SSFRHTHpvamdncFBuWmVj?=
 =?utf-8?B?NUdLWDNyQUhYUHprSTF0Z2Rsd09uRVNvZzlGUUFoUDNDVWhWNkZWM0JvdTZB?=
 =?utf-8?B?VGV3N3N0L21RVGlLMFVGaTZZZm5tcmptY1JRdVQ2UFhsMkJtSnpYbUJlbUVy?=
 =?utf-8?B?NWZvQzdXRnJta2JtaFM0dlcwdzhPbGlkTGFPNUlMUmVMdGhoNkFQcjFRM0xp?=
 =?utf-8?B?ZDVwK1BiMmtLUE5kRVlQL0c1OGl1WTNwbFlQRHZUTVhaYU5sT2p3WFFZaUZj?=
 =?utf-8?B?akpwOStaeHpBWCsxRmtic1BXcGFRM3RRZnpyald4Z0tDc29nT0lLRjQ2MnRL?=
 =?utf-8?B?dEhwVXNKK2RaTXhCOHZXQlErUXBmRVpNNGg1SVpsOW9rclFpcDhwSmx4TWc3?=
 =?utf-8?B?Tmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dtEffiP01tX/v2ZjmQ/hWjKJpmdRwViYoMYFW4nkALMWsee86A3AS/JUcR00wqHG7JfxL3yIFnlaqO8ZrH8QRUn5yGkug7B/kfrjIZJc154Mz3raes2qDTOE+o6fgkwuEvjih/SDL2u6P2n7Ljd6q8kzPgpSwvnRpNy070OIsP6tGVmtPInj6iv7whShtUG76o8u0x5FNXX26TRWyXMttx4yr1qS0UhwE3ewBI9xv9j+Lbu+t8dZll1R96hZ0CnAlDhdMQ8RFK5S7gVVzyZ3JGUs3mbWpJWawvULn/NgZ31G8M67VBKOmCJ6vaHkZYN2ccFyCED9toRtryk0ec1ct9y9cHjWhLVa57qinBQE9CzQxtFynQyZsNkvR8NpGdmo5kqWmbSm+rQ1Kv567/eLAE7gPH6trxA6FW/dSk1EYhxubwEgcPprXVtQW2dMiDX+LrBc92mGudZe4GjTns0bDN8HiIj+t5Rubx7quO6W2rUTUrhU5yqtbx9OBfc3jpwY5+p9aYWIEjgArWIPVmwFLRLHDNh2JmVuPUDMnIRIRRHtaMiABVR3qYwKbni4+GK/EzWl8Co5hL2+ioz31Af+EmbFMDEQI45jbzwO2dVES94=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48076a3d-bded-4391-cc14-08dd1dd0c8ef
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 12:54:32.0815 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VmSxmuhUrufNDx8ElzmNOLixkiLGF+q6S68f1sadIpVzq/+6GXMiQ19O5EcOxL7GCsZ/zpw3Tw8hEx9LmzImxU37/njtfC+DGAnxIdL4LHQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6827
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-16_04,2024-12-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412160109
X-Proofpoint-GUID: lyjkp3_91wEBfJTZ-AA7MkHJP5sifrxw
X-Proofpoint-ORIG-GUID: lyjkp3_91wEBfJTZ-AA7MkHJP5sifrxw
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1.13,
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

On 16/12/2024 09:46, Avihai Horon wrote:
> vfio_devices_all_dirty_tracking() and vfio_dma_unmap_dirty_sync_needed()
> share the same code that checks if dirty page tracking has been started.
> 
> Extract it to a common helper vfio_devices_all_dirty_tracking_started().
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>

Reviewed-by: Joao Martins <joao.m.martins@oracle.com>

> ---
>  hw/vfio/common.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 81fba81a6f..45783982c9 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -184,16 +184,22 @@ static bool vfio_devices_all_device_dirty_tracking_started(
>      return true;
>  }
>  
> +static bool
> +vfio_devices_all_dirty_tracking_started(const VFIOContainerBase *bcontainer)
> +{
> +    if (!migration_is_running()) {
> +        return false;
> +    }
> +
> +    return vfio_devices_all_device_dirty_tracking_started(bcontainer) ||
> +           bcontainer->dirty_pages_started;
> +}
> +
>  static bool vfio_devices_all_dirty_tracking(VFIOContainerBase *bcontainer)
>  {
>      VFIODevice *vbasedev;
>  
> -    if (!migration_is_running()) {
> -        return false;
> -    }
> -
> -    if (!(vfio_devices_all_device_dirty_tracking_started(bcontainer) ||
> -          bcontainer->dirty_pages_started)) {
> +    if (!vfio_devices_all_dirty_tracking_started(bcontainer)) {
>          return false;
>      }
>  
> @@ -231,12 +237,7 @@ bool vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer)
>  
>  bool vfio_dma_unmap_dirty_sync_needed(const VFIOContainerBase *bcontainer)
>  {
> -    if (!migration_is_running()) {
> -        return false;
> -    }
> -
> -    return vfio_devices_all_device_dirty_tracking_started(bcontainer) ||
> -           bcontainer->dirty_pages_started;
> +    return vfio_devices_all_dirty_tracking_started(bcontainer);
>  }
>  
>  static bool vfio_listener_skipped_section(MemoryRegionSection *section)


