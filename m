Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D072CC28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 11:01:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvDeK-0002Zg-F7; Thu, 20 Mar 2025 07:01:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tvDeD-0002T4-QE
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 07:01:16 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tvDe9-0007hv-MS
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 07:01:13 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52K8Bua4017499;
 Thu, 20 Mar 2025 11:01:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=rC7x3v/xGEsGLpOZGGKUCFCrDA+18WQrK5nRIhhra4c=; b=
 NBazJ3xR7Q4hdvN3eGwSMa3pb0wISNQqnn+gKGIoXINwtY2+/YOPOIBq8sTU/T7v
 bC6lXTDVXBM3ggdT8nyL7Wdf0mxmuN3KDrzqUcfWmOQdkTFHpYRUgYI8Bizwhm2I
 Zgc/MeWa308e9A8zn5QE375pLbx/RubpGdacfXOPvWHTeZzIpNuX53wzwRYcOrVc
 Y+2WweXHTyfQ8zxfjEZq6IiBwPw/UhWQOpAS8RZG4s+QPxJnowePYGraSFbW75Ue
 bmE2b2Vb67EjJO8zEfzTbjNoz6CMCbyJExi4fJztBQ/VZFMelo0VYZJTRs5hSf0G
 Ex/RmkGw1OZa1Z5P7dl14A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1n8ndk2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Mar 2025 11:01:05 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 52KAqUo8004511; Thu, 20 Mar 2025 11:01:04 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 45ftmwusqq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Mar 2025 11:01:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t5c0KhjLChCJ3H4N0bY1RKbYVm63BBEHYOb+8rfJu6OoDopDGmTyfR76NmOVCrq3SkYgn3pJxu63nQJ/PR3iPZNYWo2XHQdohVW0MdXtpeXvuXMLysxxMQhMGRMKB6DePTZ/o6KPXimuElEwWyNEU+GAEXRPKSa+A9lb0UUGvK4Jy1wUF1ovW51PAh/AbYqLyTAIxVlwlsU8iTczNOA7/SQAp+Ob4LxmI/wyG/T+BlO0uXj9Lb3aNcqkoXKZAx1mbSdRdtYkpydHUqjyvD6vjqL3n/m11HIo5XgLIO3y2RzQV6LaU1Oa2r6KcGor2NK35czMD/HIFhFYyV1eqitcWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rC7x3v/xGEsGLpOZGGKUCFCrDA+18WQrK5nRIhhra4c=;
 b=Q5WZuGPDcCtXJrcN8u6ndoaM6+wTAzlVY3hWSYbz8YzZx9wRR2bUrQ82nVQok+TqAzU3yGPtoLze8jA3WmAA+MeUIwS3y0tnX6OtcoFp89wJjR+ChIEX+cZ4Yl2rBGbc1NBEcgPevgDzZAiSXVC/+I+Jx5+0xFVBCtJiwWc8ED9Kaj2j5ODFFLjPq3+i8Dv+ZiROpKHEyB2e88bVB8jjHNr4AXJXUai9jYZkG+3xxrhiZLEOZbox7SSKIJDMG1GCQdNldWKPl5a1n1UePXKbMd4W8xhjKoUr0aprs0UmPnYdcwpcET49zBozH5mLWRvMmFnd4pA5qWiG/6X2Sz7Ndg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rC7x3v/xGEsGLpOZGGKUCFCrDA+18WQrK5nRIhhra4c=;
 b=aCN0ilINBZAhCRphEEqJF64o2ZuSFCrjhxWs+aaaS8XO2uPHHr/IRFW0sJCqu3UV98DwxBbjHa23kFMeIZLE4tfaRjouSKjNPZYnucfSromiAaGnYFLD7E1Ne2uFAkN4wAWi/s3X/wbhZT2QlAP1vfztzql8Z+tNfK4w+ZRMAvg=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by SJ0PR10MB4797.namprd10.prod.outlook.com (2603:10b6:a03:2d8::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Thu, 20 Mar
 2025 11:01:02 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%5]) with mapi id 15.20.8534.036; Thu, 20 Mar 2025
 11:01:02 +0000
Message-ID: <fbc6f226-b4be-4f99-aea3-8a8342f6ee4a@oracle.com>
Date: Thu, 20 Mar 2025 11:00:57 +0000
Subject: Re: [PATCH for-10.1 24/32] vfio: Introduce new files for dirty
 tracking definitions and declarations
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20250318095415.670319-1-clg@redhat.com>
 <20250318095415.670319-25-clg@redhat.com>
 <SJ0PR11MB6744B94364FA17801C4C451592D82@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <SJ0PR11MB6744B94364FA17801C4C451592D82@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR03CA0028.eurprd03.prod.outlook.com
 (2603:10a6:208:14::41) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|SJ0PR10MB4797:EE_
X-MS-Office365-Filtering-Correlation-Id: 143c7375-8a16-4a23-33ca-08dd679e80f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S21yV2YyMit1ZWhFRHl4MDErbHh3eTh4TG9ic2F2R3Z1YTVRL2h0OUYxR3Ux?=
 =?utf-8?B?a0poQkZvaktGZHVqZFJpejJkUVNGbUwyS09vTzAvSHhxbUpvNkVGR3huNEU5?=
 =?utf-8?B?UVQxL3p4WDBXUFllMkZZNGVBUTZrRzQ0OUErSVhpUytDL25ob0c1Sm9BZlUx?=
 =?utf-8?B?Y3BNZkhxcCtRSTY5WnoyaXh3UWhCZDZnVlk5RmxsVWZFQmFralppOVlkcDJX?=
 =?utf-8?B?R2dleHI1VnIzOFVXd1QrMnRVVjV5bE1jRS95T3lTb2Y5QmlGaHNaYVBkSFNt?=
 =?utf-8?B?QzJ5eWQ4V3ZPTk1YWUxHYlorV2ZCNzlrRjBVRzR4TkQxSXlVL0xYWVNPZG4y?=
 =?utf-8?B?QWVuZ2VGV0M3TDRRRjhpOFh5UU85WnZXNW1LQkpwL254eTBKKzBONmV2WTZJ?=
 =?utf-8?B?TU1jYjI0c3ZmK1p6WHFnbXFzZGtReFpIcjE5U0x1dW9QanZvOWhlS2xnRlVJ?=
 =?utf-8?B?blVkS1N2cGJOaXBQSldRUG5WYkZZRjkyKzFPNEdYdzlJZDNBWjk1Vk5zM0VK?=
 =?utf-8?B?eUFRQ3Z4UlR1c1NmdE84UnZTRlI5ckFmOGNMOFpROVV4QUd3a3J2MFlkME5Z?=
 =?utf-8?B?UzBMMmc3bEM3SE1ZWFg1aXNrNlcyTi8zOHp3bzZ1dHJPYVY3WmFER0FVQmlQ?=
 =?utf-8?B?cDk3TmQ3dHd4TXRjU1ZrRnRqam1ZQjN6ZFRodmM0Y1FaVVZwb0xobU40UlMy?=
 =?utf-8?B?YTgrTGdFamxLb3g3MjlNOVVmVVplRzZqS0lsRGthT1BDSHlLLzNLSjg2dmZl?=
 =?utf-8?B?WGxxMVhvbXJIVXNtMGMrditoU2k1UHE5c1dLOXhFMGh0aDgzZGxodHZaZkZ2?=
 =?utf-8?B?ZkxTNTJVUmxSSDMxMFJZSzZGWVdCNkp5czd5Uzhac1FRVS9MajhFSm03NHVD?=
 =?utf-8?B?SFhEa3ZnYnF6N1dibnIzUDdjdTkrNTN0L1IyUEpGZEtHT1RyOXZPSWhiZGNu?=
 =?utf-8?B?WE14NE5PSndmLytJRi9FWUtEVUVlSEsrTUhnMGRCR3ptbHFsNnNSZ0syTVlQ?=
 =?utf-8?B?ZEJ1WGJ0L1MzNmJjejBBL3lYU2NhM1E4L21IcGxkZkViVjJ1SGttU3U1eEto?=
 =?utf-8?B?SmFUVm1EUU9tMjNCN0VwMzYrNDAvQmx5SUhlRDN1bWQrb1Jsa1oyN0dQSkdW?=
 =?utf-8?B?S1VwS2dNbk54VDNOcmorWUFmVXpKWnZFKzEvZGJFMFZhMUQ0MU9Ec3hLUE9Q?=
 =?utf-8?B?SEUyWW13Sk9nU0d6NjFMT203Y1BtSStCU2RUK1BIQnlwa2VSRk1TRUFFaGU4?=
 =?utf-8?B?bUVyaEV2UDhXUkdPSVRvNUQwN1VnSmxXSW9ONVBIVmJCNno3MGNKZ3daZTFR?=
 =?utf-8?B?VG9aK3kwZzZwT3FiTE81MVdScGYydFM3dUZPajJiZVlEV05ZakY2VnBxM0Fx?=
 =?utf-8?B?dGI3L0kwc3U1VDFqejZCR0RkMlplTVcybXlYc0dMY2Zia0tNeVdmejlwZnVI?=
 =?utf-8?B?RWp4SXRLZVZYa3kza2NRdWU2cGEwZGxHWS9Zdk5EWElmQkg1RHA3aTNGM0FI?=
 =?utf-8?B?ZnpQdko3blBSS3Z6QTZuSzBHTTAyNENaQzI1WjE2ZHdtVXF5T3lGNjRWMjM3?=
 =?utf-8?B?aGltdG9mbzlHMFhrSDNTcmdCdmY3aUszQjZBWHRRaklXRGdpOWw3ZFBFSmdi?=
 =?utf-8?B?WHlsY0gzOVVObzBMQ2dmM2lnQkNZd0NTd28zZ0o1aE9OSjgzWEhLaWZBaVlV?=
 =?utf-8?B?Z3BYSnhKUjVvU1o4NGlmT1A0ZkU0WCtRV1JIVWZQdHJnbTVtTzkvQ1M4T1c2?=
 =?utf-8?B?dWJVb2ljbXMyemZkU29wWjh5c2lndkpCdTBhOTRlOWp4Uk5iaGltSUlWNTFz?=
 =?utf-8?B?RDFIZGVGZ1R3Z3YyVUMwTDJLVzBEbDdzMlhrTExxS01jbHVzUTVraE10ZVA0?=
 =?utf-8?Q?AbkhjtCWQrJWf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkxYUG1sRTZhd211dUlQZjQzc1FRdEhuVzk5Y3h2TDg0ek9hYVFRSE1YYnk5?=
 =?utf-8?B?VzJiK3dBQ2puNXF2SGZYb2NFOFhOcUxHODdORldOMU9ETEZnQnNwcnhpSmd4?=
 =?utf-8?B?L0RmQWhGVy9KT1U0N0pucEFwVUptSEdldGZIUUFtRE1WNk44MklYM3VBOXVh?=
 =?utf-8?B?ZEFQclp0em9wdGg3YUJhTU1DT1p2bTVtVVhieFl6aURnT1VJWVpBcmtZMklZ?=
 =?utf-8?B?SmxmZ3BNSWFHSXBZbnU0RHUxRElHZ3BSYmtnYkFjMDlJNkJEY1dkYnFCZW9M?=
 =?utf-8?B?dTlIaGhBSHgrV1oxZXRaMzhjKzhoWThWWDZDc0NaTVFVajVXR2lhN1J2dDNJ?=
 =?utf-8?B?N2ROUTFJeUpjYzI5ZzhaQ21kTWU1QVVoTHhSUFIyYkZ3UWJROVN3OXo4Q005?=
 =?utf-8?B?dFU3Q0U4TkJEakFwOTBuRy8waTZROERydXROWmJUMzJNb2FTb1RzU1BCMHJw?=
 =?utf-8?B?elEvNWdSV0IzTHlibEVIRmJWdGdQMWJtUVFOcUpQY0xnUmlEWVU1M0dycmdM?=
 =?utf-8?B?OTBtdEY5ZTRwNTVMRXBRSEZ4WFNZVVlxdVE1cnFiTzlKT1RBRkd5YURzTmZs?=
 =?utf-8?B?SG5LU3F3NHByc0x6R1pVSERoMGpmY3A4UWxWbkYvc0pZNWUvc0IvY2hmU1RV?=
 =?utf-8?B?SGJKWjBwa3ZXbGVpR0JWWEhnUkVHS1JRRjN6c3ZTc0pXVmhST1BDM0g4REN6?=
 =?utf-8?B?R1VIbmJ5QUp4YTBadEdVallIcEdRTjFBYzErUy9RcklHVks0QzRkRHBxbVNp?=
 =?utf-8?B?eityd09RSzA0a3FYY2prNmZtWG50cTYrUlg3ZHZ2QytKM2kxYUo4ZWRYeVdZ?=
 =?utf-8?B?eGR1WHRSSytMZnpBVTBjYnFxMHVIVnZHTmxRVVRjVVVJam9iZzg1bHpkVUlP?=
 =?utf-8?B?a251c1kxZ29FOGZla0tCS3Z5SGIzY2p5RXRobnZFd3NPYjM4Mmt5SHlPQXBr?=
 =?utf-8?B?OEFTQStyRHF2dVpXY3ZvQlgySGNsOEliV0c1UkxQVHYwS2xuT1FLSGdUMG1W?=
 =?utf-8?B?OXROWHRlKzVJdXNzNmU1Wm5jcHpsZ1JMVFkzVi9nekRYTWZaQlJXbmFEUE5E?=
 =?utf-8?B?dTk5dVFuTDluUnQ1OHBjYjg2SWJjOTAzVm1mdWlCK254dHZPcndJVlRkTE1y?=
 =?utf-8?B?d1YrS0JIdDRsTHVKdTFFUXBzNWtQSkZ1aE1ySUpjZUF2VTRhbThidGh4STJC?=
 =?utf-8?B?QUp0aG01eHdQTDFiQytVaU51MlpHQ3p5QzNFbkFIUXU4eCtrRkF6V0VmS294?=
 =?utf-8?B?ZjhJVkVTOTh5Zm5FZkRKbVBLaUpZdlRwZnRQc21TNGxkbXpjbVN2NFBXWStr?=
 =?utf-8?B?UWVhMFpoSnZNQkx3QllJQTlFMFN6a1dIVEdFMzY2T2dlMjlxNk4vZUVjRFNW?=
 =?utf-8?B?alBGc0tXTjFkL05qTUo4KzZTMGw0UktUL1NEUmtvL2ExWjhub3l1cnFoa0hW?=
 =?utf-8?B?OTRmQ294UGJZZFZEK3V0ZmtSVE9VZDIzU1NDTkM2WjFoOVFyOVFnelF2SXRJ?=
 =?utf-8?B?ZHZpU3JTVGkrYkV0bGRvR0ZrL3laNk1NUkVvSGNiOUk1TzIxaitnRzN3emVr?=
 =?utf-8?B?STk5N2VsWUtZNDkvNm52V0NiQ1Y1TUh2SXhBZlVlWlBjVy9wWXhIbkJleEhm?=
 =?utf-8?B?dlI5bmQvWWNDZGFTWThwUk9MazM0Y3M0RE1lVGRyeml5blREcjlXbCtwc01P?=
 =?utf-8?B?VlVkbzc3aHMvZisyZmwzNTMwazhiLzJ3Y09Xd1FhaTJFZ0src3V2OXF4QXFH?=
 =?utf-8?B?dndYdGt1RU01ZHVsc2QrSVBCNjl0WDJEVGpUaDlXL2oyMWI4TU9HUzl3MklE?=
 =?utf-8?B?UVoxaHFWVkdiUlFlODJEOWtHUWZpc1NzZVp1TGg4dlhLeStxdjJMZ1BoT05a?=
 =?utf-8?B?UVBBdW1rQUNrdXVnNncwSjVxd0x0SUhsOTRTbVZFcnhCSDBOYXBjMnFVc0FE?=
 =?utf-8?B?MGt3UGlhN3RQU0trcWZJd09LcmJpU3JDeklOL2hxMWtxMlhvWWhoZFB4QnRz?=
 =?utf-8?B?VXo2STBEWUVMYlJjdmlYbThMTDFoYzUvMThLVmp3V0FwcFlrbm95M0FvdVdv?=
 =?utf-8?B?bVVvMGtNS0x3d3p6b1pNSzQvaU5lbHpiY1NLdHNhcjFqaW9YVXpRWTFjTyt5?=
 =?utf-8?B?bVBpODk5Tkh5VldtYkE4OUhxa0ZzWHFWOTFqak1TNUtDS0toUlIrbkRPblpZ?=
 =?utf-8?B?cUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wYVMk6y13A2LksUmPIgJpNMuqmmMg2ln4opzcdP+/aTcMzSqnwRNNbqg+fqHNafYGoAIluAecgELumhSRqzwT06gAjEoI7x5Q6MNbN81Ma1U3H8phK6h3+VhWDPqb/J/CQDz9c+1BOA4P/Kdx5AdTzlL1Ha8UY6HOySSUHxwnvB1vPqRqXPP1vg6h0Hmia5yKEiRl7RA2Dq+jeixtN/r1657j2WVImYVc6i50swJm9jJLIGutKg4uPCmZbBNQfR0uJFNVq6cG+HtIdC/2bkzWLDqP2+sO7FuJ/hgPfpj28m2E6L51X2FGhoM2PvMadZj4P6OYQU1+o+hX2dDEmkQpT8/7UpPCWQhM7jincNYnh1BrIYdQ9e2QyOOOl38GAthFdRVfggzdJ5QnroduJ83D4y9R0qfBVZPz8yG7FzKSBu+TlQ4FghIGrEMsquF7I+0KMoZ0S3Gf/EItfMhwm8LTXQIC9ekrBQEOMOZwSSIVZ5AQ3xoWLX2e7ITIGzsslAxpYQv7VvH0kkqsN4rDoALx3EfuiF1GFTvh04D3ckG4NkKMwf5UmVF+f/jFIuJkbSTGhapgUb3cC1oi72NgqvuONbrXLC5yHdLrjaiZU8YOhU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 143c7375-8a16-4a23-33ca-08dd679e80f7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 11:01:02.5771 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1nmoXPN9RRjzrHgQRO/7dMO43L3OSIYW/FYOPdyAlvhk//Ftr8x3wr5t9pdfMQrICkLqn/b5DelrhzR+Z6E4ycYIb8CtRHfF2XGsrteCsP0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4797
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_03,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0
 mlxlogscore=795 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503200067
X-Proofpoint-ORIG-GUID: 8ULT7YZ69cm2P_eOn5ee9SJ24B7Rzclg
X-Proofpoint-GUID: 8ULT7YZ69cm2P_eOn5ee9SJ24B7Rzclg
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

On 20/03/2025 09:52, Duan, Zhenzhong wrote:
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Subject: [PATCH for-10.1 24/32] vfio: Introduce new files for dirty tracking
>> definitions and declarations
>>
>> File "common.c" has been emptied of most of its definitions by the
>> previous changes and the only definitions left are related to dirty
>> tracking. Rename it to "dirty-tracking.c" and introduce its associated
>> "dirty-tracking.h" header file for the declarations.
>>
>> Cleanup a little the includes while at it.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/dirty-tracking.c
>> @@ -20,14 +20,10 @@
>>
>> #include "qemu/osdep.h"
>> #include <sys/ioctl.h>
>> -#ifdef CONFIG_KVM
>> -#include <linux/kvm.h>
>> -#endif
> 
> It looks this change unrelated to this patch?
> 
>> #include <linux/vfio.h>
>>
>> #include "hw/vfio/vfio-common.h"
>> #include "hw/vfio/pci.h"
>> -#include "exec/address-spaces.h"
> 
> Same here.
> 

It's written in the commit message:

	"Cleanup a little the includes while at it."

