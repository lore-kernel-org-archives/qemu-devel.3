Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B30C3C52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 18:20:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdZeH-0007CZ-Kp; Mon, 12 Aug 2024 14:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sdZeC-00078t-Ro
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 14:20:03 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sdZe9-0004sj-9G
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 14:19:59 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47CHXTTY024073;
 Mon, 12 Aug 2024 18:19:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=vZ9MhK41ycwCpARPpuwxidOQsONrhQ1JeHwLwDKh0XQ=; b=
 Q7UwkxXXG7uIehxKzXhTYV0dotGLSPUmsFRh9BseMshM5N7AQYziD2+yJY6wjdN8
 Xj37pbzwcLrcg36p0n0rL+N5TUfCOVhTW+3/re8tlat3UZdH7pUOL38XpYZq20qf
 BqQk3hLTf22fcgvFKQcuKEuUKZvnmmMTmlHpUmOYaiI7SfnOqaftL4T8cr0JuE3z
 1+5GvsH3+Eqywojs8Q5CKjn+wyZB4u6lPj6tYpDoxvS9qXV/dgg7O61OwhgM7Zru
 PY2WytK+h6yDGN0BclvJT0qONzBFEoJxQdJHQbfPohmwKqvAkpcXXUzlLv4j1AE8
 A+gI9shOVk5I3m+A/HzYxg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40x08ck9cu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Aug 2024 18:19:53 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 47CGj8c7017662; Mon, 12 Aug 2024 18:19:51 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 40wxn8bmv5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Aug 2024 18:19:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nSLWYb/nzmh/A+scmfbHPqaOlY5tUebbjlp2VgrAftUKCXGwK7vX1pCXhw89T2Trjp+SHdzwCv/eV6Vh/lPrrD5XhvhSqCeehz/I8Vw9h32o+91R2WLLdpwj9rBlzJbnKrdAVUT0c4RLQwOGOJn68vPR/1BcDfjEyjrwqTczbI5Yl7hCv5n8X8PE4deLDhjQT6F2nz9W8iQWhhTLW54+4MR3lBpBh6bGLIiHKr8ojX4e+HnkXjgHFPvsU1mO/p3qzYtrpsbS7ofZVvcJc/0IcXvg/VzK/7Y7Qihh9wXjhb5OhoytdrzlxlSf8QAQz9cL1uqEEc/zmn/IMHj6s4nM2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZ9MhK41ycwCpARPpuwxidOQsONrhQ1JeHwLwDKh0XQ=;
 b=aHdxhdodKsGcNTBHrwJOVOTkayvHfXoDr6bZ3R9JqwCHgrLk2b1jy1TWYc/t9F5xjxIk1EJjbm/nezXGdZ9FS/FV4Ln/0KYNnAjs3MAZcvC5e+a1W5ShN2lNC8hbXvZTUiRh3koeevhas9OpRvicrqIaRSuhctR6UUZmzr7kOxizroNan0/Lb+SrlkBXVsr8kJTz43m0rqTH3Wo2/Mp74v690vv6UABdznTHYwpXfnFXxr6QO7IqdNAtGeyCy7mnBTW9CGLI7MJW2fPn1H/54Vmhj8RSJxDiSg9OpKg9dvxgJpYqzpeVCLn5+dpyQXVnDaEWA02Ciz0cvr+tu+vspA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZ9MhK41ycwCpARPpuwxidOQsONrhQ1JeHwLwDKh0XQ=;
 b=mzaFBNaZSDa82WqPzNQS2WEhpZrMGyNBHdCgCqiNgnI3gz4LXA3YeMlCTuMm2rP/7yE5vH2AvfI2XIBcNCFdGJmHRmbohynOxq78k2FRSR7yzgYVKhr8S1LgXRwX6fWrDXR6euY7MuXvB25drWofeoGNAHg4ZSKoAIFYlsJMHMc=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by IA1PR10MB6217.namprd10.prod.outlook.com (2603:10b6:208:3a6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.15; Mon, 12 Aug
 2024 18:19:29 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.7875.012; Mon, 12 Aug 2024
 18:19:29 +0000
Message-ID: <4054526f-165a-4bc8-9c7b-2ef359e87e7c@oracle.com>
Date: Mon, 12 Aug 2024 14:19:26 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 0/8] Live update: vfio
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1720558737-451106-1-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1720558737-451106-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR13CA0033.namprd13.prod.outlook.com
 (2603:10b6:208:160::46) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|IA1PR10MB6217:EE_
X-MS-Office365-Filtering-Correlation-Id: f54b3523-7f5b-4d31-e4a5-08dcbafb4e79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U1p4dm44a25xOVNKWUtDSG93UjUyZzlRZVdXak9xTWJDdzhTL2VRR1cyNFU0?=
 =?utf-8?B?M2V1WUhYbUE2bWRxMHNKUmUzREdHb0lFcFFpTEkwdzRSRDVRdUMzY3RXS0pV?=
 =?utf-8?B?cVdxdllmV1hBeFpUQlJTWnZXK3Q2am8rRmtFWW5tajJpWnJueHVRVnhqTmJO?=
 =?utf-8?B?TUZ2amFJTlM0R2NyWGFKQ0tVeWw0aGxDOHhhYVBGcWZpajR6UWlUTHAvR2pO?=
 =?utf-8?B?OXpLRzM1Vkp0bDNzRXdPUUJRcGRKNkFrTjB4MTBXbXdOQnZQQitoVERac21l?=
 =?utf-8?B?dE1wVDF5c0tVR1preEhsMUlnVGh0b3ZlRTNxOUVKTXRiWms5Nzd6OEg0Yjh1?=
 =?utf-8?B?bDZtcWkweGs0dFZpUGdROVhYelhDTkVqTS9ZMVJmQ1dJQXNUditEaXlnbDhF?=
 =?utf-8?B?MEhmV09pMS9RUzNibFpYQjBWTCsyUHFpWXU0Z0dWa29DVjM5RXFjUjVhV2xF?=
 =?utf-8?B?M3pCSjh6dHhoMytFdVIzSkVXR2hka1lmTXlsYXlBMEwydjVGVW9EVWNwMkJM?=
 =?utf-8?B?VmNyak16YjNBOVJQUnMxa3N2V2FjRnJteGZtbjhVaUNQUGdnZG13N1JJdTFV?=
 =?utf-8?B?SmhqTHBpY1dHdE1URmkzeDBCQmNkTG1RcVJMdHZnalZQd1owcVZReUdlM1Zr?=
 =?utf-8?B?N3d1RXo2RDhtc3RvZWpuU1lDMUpmWnUrSDY1VDN4WXRoa1YzQ2Vyb21rTWRV?=
 =?utf-8?B?dDJBSVpHZzVxWGp4VnhRQnBhNDRWeFNqWXpmU25HV24vSXIvM3RzUUNFMmww?=
 =?utf-8?B?dkpOcWx6OUFaNzhVU2o0NUs2dnlHL3ZNZXdJOGJ2SStFNit2WklmR0lUZG1H?=
 =?utf-8?B?U0JTZ052eHIzaFpqckNzaHEvR1hzUTFWdFVZcmYyZmxPL2tJc2NkRkllYnRm?=
 =?utf-8?B?V2Z2SXc3TUg2NHJBbE1QTkExeUtXdXhFdTZTTWlVMjVveXRlQTZRUC9IWisy?=
 =?utf-8?B?Tmd3ZTJhYUtyN1JnZldWUXM3TDV2L1B1MkNjd0g5NnFpbDJMbzhqdjNkMXJR?=
 =?utf-8?B?QkRqeUZkZXd2TlhtVkZ1SmFNS0p1SktKeXVETXh5NUFNVitpRGdDNEdVZ2Ir?=
 =?utf-8?B?c3J2UEY2SEpTeG05L2tsK3pBSldGUU83eDlpY1pVb1NsUkJqRktxODgySHlw?=
 =?utf-8?B?QjZjNFZKcTZvdXd4QWh6Nk0wNER1dW1HTlI4dklLSDMwbUI0dlAwNjBObU5Y?=
 =?utf-8?B?Ky9NdDQ2eitWeDBiUTRDbFJmYTEzdGFVRm5qRlRmcGs1aENKMWZFcWNuWFh5?=
 =?utf-8?B?cTIzcVM5a1M1Vy9nOTdUU2tNVm40dWRwUVFMczRSS2ZDSTV2VzhlMVRKcDhx?=
 =?utf-8?B?OFBSc2JlTzF1UHQ4YWFqSWVSaXgrUnNPZE1NRGVBbFBSQWtyRFdmd3FrUHMy?=
 =?utf-8?B?YTdrTkJyRUQxUVAxNEU4akNmQUhSQU1KZDZVaElaOFBLaWp1QWMrUUgvSmtx?=
 =?utf-8?B?V2RKUVhRY1AxcWt1a2NNRlFSUC9QdVBPMlc4TXNnSFdVaW0ydVBSUzNDNDhq?=
 =?utf-8?B?Sk1uTzhNOTRRSkhoZFpCTlBsZHR5SDlQTXBrd2VkWnYyellzbVgyRzRhZWVj?=
 =?utf-8?B?MVRaNUdYWHRWeU9ucEtvMGxXWlRjQU56U2VmRVFoSmhqaXU2bnQybnArUVcr?=
 =?utf-8?B?S1hJZ2JyOUkwZERYdDIrN28vOUl5YW92YVBLRjVCUmYwS0QzVXBYQktXWjVR?=
 =?utf-8?B?ekVhQ0FwQnlHVFhLUDJlQVkxOCsrL2JRRWhXVjBlckdZSTRyZ0hVSlllWXFm?=
 =?utf-8?Q?ZaEIa46uIWaNBfk/nQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NU1OL0l4SjV5eUpEcGc1Qyt1K2UzNk05RGhmSVNoWC9zTU9OVTN2VU9lNmxa?=
 =?utf-8?B?R3dOM3FWUE0rL0VvSGpnWmxMTk11S3Nrd1FhRC80NWl5cndCYUxDRTV6RWs1?=
 =?utf-8?B?cVFodE1VRGJJM1I1QzBPdnc0SHI0cUt2OStiNW1VK2ZrUXZQZW5QN3o3VDky?=
 =?utf-8?B?UmtrclVVZzMwdFlxQjBKcVZMM0hoN09tTTFvYk5DVEVuVTVDS1FTMDVIN0I2?=
 =?utf-8?B?ZWJrSFpTTXM1VmsxRXRaUmtZc2dTYnZnR3FwTytDUkdRMFVZdC9oYkZwMXgx?=
 =?utf-8?B?eW5YV3hySVhUazY1ZDZQS0F2VnY1Vlg5L09xdnJiRzE4UkFVbHk0VnRkeHk4?=
 =?utf-8?B?Ym1WRW56eHFKL1Y3L0VXOFpFcmM2TWV4QXlyZlRGbURvbXk3TVlwZVZtQkkz?=
 =?utf-8?B?amp2VEZBZ0VTVlFaOWJtbkRqSnJoQzhFRnBldGkzUGRLZmVmTmZkR1BtcFIy?=
 =?utf-8?B?a3k4UUo3WGhaTm5FVGpaS1FOaUNhQWRscTJnZlplcTZYLzNwN2FLL2d3OHEz?=
 =?utf-8?B?Q1g0MkdVL00xOTM3ZnN6V1c2TXl2bS9tNGc5cElFM1BjNm1TT2NONzRrcGhx?=
 =?utf-8?B?ZS9MRU1xYmZSc1FsQ1pIbGUvbDdYZ01xZWFhWW9QL0lVR3VraGRnTDFjV3M3?=
 =?utf-8?B?MEdpWWVWZWpYTzFpRmZKUWMyNndTdlBZMGxFYjN0RnhrVWkweE5FOUlYSGkr?=
 =?utf-8?B?MExvdEVITFZpeVp0RExNTGRPaWJjR0xrcGNUa3pqVmZMMnNKRGJoL0E0WGRP?=
 =?utf-8?B?WHZsb1VhM3F4SEY3OVcwaWI0U3Q2dTIzeEZzLzBZdzNLcGZ0SXVmMkZaRkJ2?=
 =?utf-8?B?MUEwYmRVdlM0WWIrblZmRll3Y0c0MFF3OG9jcVdPMkRXbS8zNVNmTlNSZ1pi?=
 =?utf-8?B?ZlppbDNoR1B5dmxXU25PSEZ2N2k4MG1tV2VTb3l4VXRQanlrTExVdkt0TEhh?=
 =?utf-8?B?czg3QldmUjF5Uk9IVk5Ia0NiNWpiTjdBQlV0OS9KTnRBUGFlODZUaEI0blhi?=
 =?utf-8?B?WVJQbVhvMHp0K0pBaGp4RElKaW50UVBQQzJRcXJVbGphcnBnNUNRbFYwOWpC?=
 =?utf-8?B?b3dDczU1SExqbmRuRDhySDMxU2NRSmhRUFZnMk1SZk9oZng2TFRNNXUralVh?=
 =?utf-8?B?dmhKbGgwMEdxMHBXNHdITWNlMEtvWkxLdUlxdzVjSTRHNHdXZzZFVXhOaDhJ?=
 =?utf-8?B?Q1RPdHZwMTY3UXJobkRNMWFvWXRUVndwVkN2REM1aWRnblFRREgwbXkxQjBy?=
 =?utf-8?B?dWFWOVJGc0xKVzVydmJSVzVYMTd0NENIdk5WZFpobXZOZExWZjhuTjVrQWRh?=
 =?utf-8?B?Z2RNeWNDNFRoaGNERDlIdnJlaWIzQlVMMXZzdDZOM09ZWGpWdDIzeExYR01q?=
 =?utf-8?B?T2VVWFJLdFlZcFhhbFFiem5NVVVvUlJESTdxK1FxL09tVURUTTJ3NE9Pa0Ey?=
 =?utf-8?B?VjdwWkFrSitkOWl4QkxaZEVqMGFKRnhpQkpTWFBQV0ovdENod05jNXdoZmpO?=
 =?utf-8?B?Q0RjVWZvS2tPVFU2OHNVYUMxWnVibmZRSlprT09yNTQwM1Ewa2pzWHJJLyt2?=
 =?utf-8?B?SUFDdlBsTzc0bXVJdkNhNWJPY01kaDUwckNxNHVtTXRqYXR2L1ZLY1JPcVd1?=
 =?utf-8?B?YytuV0lhQzJReFRXUG9FOGJkemM3YjA5WnJNWUJQdUw5djBoRmt6dkFCL3Rq?=
 =?utf-8?B?d1dhYW8vWFg2Y3lxNkdIMlM4cVVhdU9HWUhkdG5LZ0F5UWNObUdLYnR3U3dT?=
 =?utf-8?B?Zldob3dxdnFOUkZKRmZXTExNWW9udElnakVWWmhTWTF5ZU1ZR2M2R2U1RTE4?=
 =?utf-8?B?RjR2RndCU0NYU1F6WEdUVUs3UFBCSHhLLzF3ekc3MS9JWHJCblBTbGNUdmtI?=
 =?utf-8?B?cVo3RmZENkJZYkxYMUI3bEIreHA0M3dqa1ZUUG5KeFB6bU0zcEhqZ2pPdVRL?=
 =?utf-8?B?L1FHUEw4YkhldlQzRkMwL25oWElGcnk5Si9DUVlubjZKanpyZDdidVRDV2Vq?=
 =?utf-8?B?dklhUUxmMS9Ta3FSbGRBSEhFbGloWkpFMEJYOEcrbWFub1dPelhWVkRFenBi?=
 =?utf-8?B?YXB6STltWUZjd3VsLzVpbVhDeEpNZVRUSFpwWTd0WmZXb21zckw1dEJmK0Ir?=
 =?utf-8?B?dllnYnQ4WlpUdWhIdHUvRXE3VzA2ejJuWGd6TFNRTzBPOHVXRnJ3M3BSR1Jw?=
 =?utf-8?B?MlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YrIuOl+ZOdn1mKLMvPspgHCOYXMijk+lE2eQpk0qu5rCrnvQz6b5J5A3pJhZ2Zo4isTfhKaC7YpJ6+xXnfDaBCtX3keUDlrqaya9PATiqJRRSF5RsO5oj/Uw62AtkDjc1odl3gs989dlGGGPPl+9FI8rTAz+X6mrDRQxbNM7p4knfnFyvF6Qjuq75rJyr2+nzgJdxbicmm5DYmjfWhhDbsKlb8DaSm4mAhMs6Pq0B6Lyak/Z4xDzn/yBPrYtnXTYsmpWcEwA7FVv7I7n7bSTzaO05ZBSDklkDqUFg+R1EFyn3pI8Ghnhr6iJCb93gsDI9HqKrftyXLrBP3l9X+iuECyRsjrS69Smj5RbAzhrJIcCU8TRtCmT0xLRR7aMZm02y6ADQYFhn4l7I/CF9iXpIFwUpdkRiP9qCDsBCy7K4tSIO97ajRb4B4GuC/ckBRgnKLfaHNA44QA2cYhJFpJFIdaxuv5fcrwzyNAoi6UmCB2Jy0bjEwOUZJM7XXwCUMSCO/5IhUdMWkklJ7LatLXdEy6mzVpE7Y8hgUmsjyYp5wg4efAhUKfwbmqVnBjmNdLfKNk5Oo1GuxYClXVxC3uwOarFzJezIC7W54u9bCcojkI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f54b3523-7f5b-4d31-e4a5-08dcbafb4e79
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 18:19:29.7101 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nNbPeihpjocgp1C3KaAjIZowVsCZZPy2+A6wkalyITclFnjC3mau24NlDafgqomWnM3PdUuv9s4868jAhufNwMugKhARZUAUnRwnV9QPvok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6217
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-12_12,2024-08-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408120136
X-Proofpoint-ORIG-GUID: ftqWq70pGnHXu0MaaXsPZAbeRvObbPNf
X-Proofpoint-GUID: ftqWq70pGnHXu0MaaXsPZAbeRvObbPNf
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi all, any comments or RBs?  This should be a slam dunk.  Alex reviewed
9 versions of this code and all feedback has been incorporated.  The only
significant change in this version is the addition of support for the
two container types: legacy and iommufd.

- Steve

On 7/9/2024 4:58 PM, Steve Sistare wrote:
> Support vfio devices with the cpr-exec live migration mode.
> See the commit messages of the individual patches for details.
> No user-visible interfaces are added.
> 
> This series is extracted from the following and updated for the latest QEMU:
>    [PATCH V9 00/46] Live Update
>    https://lore.kernel.org/qemu-devel/1658851843-236870-1-git-send-email-steven.sistare@oracle.com/
> 
> This series depends on the following, which is based on commit 44b7329de469:
>    [PATCH V2 00/11] Live update: cpr-exec
>    https://lore.kernel.org/qemu-devel/1719776434-435013-1-git-send-email-steven.sistare@oracle.com/
> 
> Steve Sistare (8):
>    migration: cpr_needed_for_reuse
>    pci: export msix_is_pending
>    vfio-pci: refactor for cpr
>    vfio-pci: cpr part 1 (fd and dma)
>    vfio-pci: cpr part 2 (msi)
>    vfio-pci: cpr part 3 (intx)
>    vfio: vfio_find_ram_discard_listener
>    vfio-pci: recover from unmap-all-vaddr failure
> 
>   hw/pci/msix.c                         |   2 +-
>   hw/pci/pci.c                          |  13 ++
>   hw/vfio/common.c                      |  88 ++++++++--
>   hw/vfio/container.c                   | 139 ++++++++++++---
>   hw/vfio/cpr-legacy.c                  | 162 ++++++++++++++++++
>   hw/vfio/cpr.c                         |  24 ++-
>   hw/vfio/meson.build                   |   3 +-
>   hw/vfio/pci.c                         | 308 +++++++++++++++++++++++++++++-----
>   include/hw/pci/msix.h                 |   1 +
>   include/hw/vfio/vfio-common.h         |  10 ++
>   include/hw/vfio/vfio-container-base.h |   7 +
>   include/migration/cpr.h               |   1 +
>   include/migration/vmstate.h           |   2 +
>   migration/cpr.c                       |   5 +
>   14 files changed, 682 insertions(+), 83 deletions(-)
>   create mode 100644 hw/vfio/cpr-legacy.c
> 

