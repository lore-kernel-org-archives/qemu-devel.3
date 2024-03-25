Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E554AC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 23:21:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rotcm-0006Xh-2v; Mon, 25 Mar 2024 19:21:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rotcj-0006Wb-E8
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 19:21:02 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rotcg-0007pg-FW
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 19:21:01 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42PLG4WU012112; Mon, 25 Mar 2024 23:20:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=SBSdv6FdRHmilfGEVIDlyp8lPJNwR7EQ90hH5GoDeWs=;
 b=cZCDO+kor06Vp7pzFDj9F/A7VPlBIfBlbPcEAzGVxPFuZibmF7JeDlXRSnTdnNkodPQS
 tBwtRwUqyxOEIhaIKsMiF48btnjoxof3Rt6ZnOrSYKbdhG0sUBGYQdC4qSuSc4V8ivin
 W7HYxXAclXnl/BJwyvlauLK2F21higBvluh9j1YYEyHvEauLnap86trP8TZ+mmcst7ZY
 brCyL12Vnl3Qh5K/1wvn3VIIeJZm4XdcVPrrMVfjsDI2BJ38uaWvQBhR2uhHLpbBiDrY
 rY93d+nLJuhhXSLzXHPr33Xvta4juVjKcOOyA4QELuuvj6dgYP1TOVRXiQmBbOW1orYS dw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x1q4duv03-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 25 Mar 2024 23:20:53 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 42PLZ0rE010629; Mon, 25 Mar 2024 23:20:52 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3x1nh6bg7c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 25 Mar 2024 23:20:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KduuBIRXt7sDi0hZ6nPMLOcXcRBbJhXEMlT5QqELjJBl6HI5QKs/LRhEdZCrKA/2xSetP1hwcnWFbkIIgSSnXhjAZssFV0nivFEAGcvUHInxDnKAKw8BUH53DFwURO2WVKYaKf3I5EpfEDv7BGEZO0OSi84X+ysQhXjMYvLs97DkT2W/jv64x4PjS0gLh9Hm0ynaqjQMelOyCGNgjzxrjltWU4Az99KVUCbX3tBiONnVR6wK2Tpk8dePHBis3iz7jkHwsUPtGfY+MS1gaQhRZP5c5szp6XV6J6SUVI7YkRUighpDI87paTxMjmmWqxRufFFtLEh7BUmc8z4XR99ccw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SBSdv6FdRHmilfGEVIDlyp8lPJNwR7EQ90hH5GoDeWs=;
 b=mgkXyypi45r3CZEUxMn4cft/kSN2rbEIs1mDto3tpyohiNeqCwd5Dftk/2qxlFE7bWZStSyknaIih73hay32AS1GpVyauLGzpTQXMxS8wAyX4KriKWOjqet5zPYQkGn03MHc+D0CNJVGlg1aOBsECFEtlz20cpi11cYyJFTGmZJcI7vjV25D7LHuSx6P0czPyMz6Gg51aUZgHFd/AS81TAeJPw2tmI7MWtMb4752bg7TiMZTVz+DXrMVeDveupqPLokxrf9Dhr641jt5dHR3WBHIJKZncvQUZTNuRWTC0o6t9mjGLMcwVzzKS0GuF3OKKLtJKe4r6PQwI9Nx7PA6BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SBSdv6FdRHmilfGEVIDlyp8lPJNwR7EQ90hH5GoDeWs=;
 b=uOolx2QZc+6RO3y24sfn3k6zr+nraKHbCTB10f/2R7MZ6xHWmgZFYVEdhPAuVtnGcqh0aA8IGLyGymY+05Sv1ZME+K9flJ2SU/M/lkWiKG27xrwKMr2wBkbXJ2ItAFqQdPskguQ+u9B/+uXvuQvXAHR1SOzkTlfe0BUoX9PLNek=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by CY8PR10MB6514.namprd10.prod.outlook.com (2603:10b6:930:5e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 23:20:50 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::bf6e:420b:90be:3cff]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::bf6e:420b:90be:3cff%4]) with mapi id 15.20.7409.031; Mon, 25 Mar 2024
 23:20:49 +0000
Message-ID: <9f0b255d-c841-4155-af9c-8a73c9adf182@oracle.com>
Date: Mon, 25 Mar 2024 16:20:47 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : Re: [PATCH v4 2/2] vhost: Perform memory section
 dirty scans once per iteration
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, eperezma@redhat.com,
 joao.m.martins@oracle.com
References: <1710448055-11709-1-git-send-email-si-wei.liu@oracle.com>
 <1710448055-11709-2-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEukLmTSfuXxSMsZuO_B7o7623x=gmLD5s-xoinEq=dWYQ@mail.gmail.com>
 <d6c1769c-049e-47a3-8705-bdfe1b2a6fd8@oracle.com>
 <CACGkMEtEtmOZB53xibp5G7ZeVdKpZogEnetfnfj1QCSX-RWY8w@mail.gmail.com>
 <0dec84ec-289b-4026-8098-010ec4c5c315@oracle.com>
 <CACGkMEtWe59mNWORwS=OMg3MXFRdkPwmjJu8wR2rTXBr4w2_MQ@mail.gmail.com>
 <35fc446d-61e3-49a3-b79d-c44aa2e65fea@oracle.com>
 <CACGkMEsbsqpw4NLJkkoNh8xfbpKgz9Usm5YO_qjF3JyB2K0frw@mail.gmail.com>
 <99ac7902-57ba-41b2-9f1b-368f4563fbc2@oracle.com>
 <CACGkMEus=LsocdQPR6UE4HrXyCJFyGQRcpHKBYX89VKOckwW7g@mail.gmail.com>
 <fbda06f9-59d2-4d39-bf56-bf8242b4768b@oracle.com>
 <CACGkMEvk0=BDgfobDo9KfDPo2XWmEiwZZ1i5H6psmX_KZZeQCQ@mail.gmail.com>
Content-Language: en-US
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEvk0=BDgfobDo9KfDPo2XWmEiwZZ1i5H6psmX_KZZeQCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::37) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|CY8PR10MB6514:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rZUeX1P1kFYOFbPrOtYpoI59av8nFemMwM+8EenBShsRkm6kggB4lmE5rQ+PHlie5R8PpHT32dVaLe8ctfX3psOc+ZOWIwOyiELRus3KE199i/S4Npi8Nuae9zrvn+2Li4D95slYJAlDVOI/tWf+LSuAlt/MF8dEAwzYgdqvD8f+gaokPe0jxR6GUwlcidtgvZah5VpI/JzpWzIfkKTo3EFk+u+GDu43Gx335m/Bo1wL4QW72kWgTduu0RQ7QT+aSjsY7Xx0pBj5Wpq5CcjgiO1RUoBeZXChjIThEwMAfR4me7stBWXee56NZ8ZHzpsIodR1NyiTFIzXLmXB+hNThSi4nSGArdvDZLt2fRQGOsa9Zfuk6WzT7toS18QoPnI8LrHRWVRP7fnvx19137P6fiX4McV0NdkihN2a2y84fpA9iyS7izechxV9FBjDsq9k6PYhtOHd0wNORyL+Xlxu9kIlevb5nMMWmOvh6ChWp15ALgsx7GqHTnxQBJ+gS0G5F9AOQYYdn6Eg6kLDeLwVwxMeR09FjLMJhK3IgzLiIt2krihEmRRCssoaQr8OzuH19jaC90NHJ6Tp6OO0qTYzbiba3WDaEcSstNmGFNRjYyoKV5q4SkrqOoqRulqJd0m/BVxgrK9KbCwoFhk3S4q5/1f7C0IOp5hxST94JVq42uU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGJTVlpTZUlpUkpmYm5UM2d3VDdmN3pGb3JqQjBrVVg3R3hDb0VVOGZTdUJw?=
 =?utf-8?B?c0kvV0JtUFFGVVBrNmJIdHJYdGh5YkRwbHRNVGtQVitiY0pSc2Zzd25Ia3R3?=
 =?utf-8?B?UUdYcWU0eWphNGQrazUzSHhxeVBpc0hqS1FubU5KdExkR2pRaFUrcGpqUzho?=
 =?utf-8?B?NE9nUEZQWkE5Nlp0STBucnJQZTJrSUtod0ZTVkFjUzV3eHlPcHdvbXRvdXFK?=
 =?utf-8?B?a2g0Sm9Hd1hmNXpuWDFBRHlnL1N2Y3o2LzFzeUJQdmVKVmV5V1BTL3BZd3Nx?=
 =?utf-8?B?akZUTllYbVF1bmpRdGF2N0JrN0oxYW4zSDZqYnZ2V3VDTENBQlppZGljT3Zk?=
 =?utf-8?B?UXE4cnBGN3BaRW5STytia2w0RE1rTFRpZ0J1NjEyWmk5VTBud3RZU211WWVs?=
 =?utf-8?B?ZGtsTHpKaXNBMVNKYmdHMTVnaVV0Q2R0c0RVbWp5bFNZY3Z1VzZMNEptdm9R?=
 =?utf-8?B?YUdqQTZWMDU0d0dCalllU3BvdmNuSW5rMjZLS0FjNk5JMFBWQVMrQXNISjhV?=
 =?utf-8?B?VXdxMXBMWHpPbktOTEJSZUNSRURBa0pEQ0NwQmVLU3JZek0rWmlUdXJINGtY?=
 =?utf-8?B?cWxpQlBjWmo4emhra2hYVkh2aDh0K3VvZzVZRkV0clNNV3JzMlY2eVZCbGtl?=
 =?utf-8?B?ZGRXMndUWFprclQrRFEzSDc5NzRBcVBVYUZUYXRyZGNRSWVHT1p3dkRzTmFy?=
 =?utf-8?B?Qk95T2dRaVFWTElqU0w2S1FFaVNXZ2o3ZkJxYTZVakRUaHUxd0Vsc2xOaW4r?=
 =?utf-8?B?aFVRYjNVMmt1SzJnbWt1U2x1U21HZ3BHbHhVSkg1Qk0wSzRtdm5MelJvb2Zk?=
 =?utf-8?B?dnlCU1EvY2JKN1ZFVDNRZmhWa0wwMVYyam9uNU5xVGdIV1lDaVRWV210a0pH?=
 =?utf-8?B?YVRnNDBrd2RYMDZXTE1HY2tyMFJxWmJ3dGZ1TS9Rc3I2bUsyNmRzb1J6N0NR?=
 =?utf-8?B?SEl0S1FRNzhKbDI2SjQxak1FRmo2RFYydlU3QU5NTlVOcitSNUxKTGtVSXRP?=
 =?utf-8?B?MEFCUklZMDRuQXVuTHo2YXJZT29sYmMwS21PNUgyL01IQVMvWjBMeHMyZlJk?=
 =?utf-8?B?bWRONSs1Wk5uc3hRRWJrVlVrM0lpamVmR1MxeUdNNHU2RFVxb3oyVGQxSXRa?=
 =?utf-8?B?WFJ3dmhHYzI0NTVtUkhRQklkSXZWU1pidXJmKzdxcXhEUEdkQ1UxdHF1RXp3?=
 =?utf-8?B?YUgySVU4STg3RXRnV3hZK2ExSURmSEtxWDdmeW9vYk5xVjF5TFowTCtjVnZt?=
 =?utf-8?B?UGFmVzk3M3FxdWJGaXp2L0dJVG4yTkU2aHNZODNLZ1Y2Vko4eWp3YlV5Rzlj?=
 =?utf-8?B?d01sekhyV0ZqT3Yyem9CMW01c0NGQSt4azBLSGxSeWlEUDlVZnBCYXB6TmtI?=
 =?utf-8?B?RGpSOWpWdmRmRktYVzdUMFRuNzhiOE9mdlQyeEtjKzd4cFEwaWxrS2JVVk9x?=
 =?utf-8?B?THR2dnJIalFlcnZCdkF4aE1hUUY2UGdodzM1RWhRclNjeUxtV0dKOHBjckJu?=
 =?utf-8?B?SUE4WlhKWC9zVWliU3NvZ2FsV0ppaVZTMnpNMWYzQ3lPakxqb3FGVkdMZ3hS?=
 =?utf-8?B?VXREWC9BMmxON1pmc1NhcTd6MEhsNHc5WDNybTIrVTVMTHJ4anZBbW5ackM2?=
 =?utf-8?B?SnFoRm5Gbk9jMGVQZlNyRTQvY0x6MTg5REJKUzZycHNxOCsxT05NcnVzT3lK?=
 =?utf-8?B?OE5MdFRJdHIxWEJMR3ZjemRrMWloNWlnaTlFczVlZmVWREZCZy92OHprOXRU?=
 =?utf-8?B?bisrMW9oUjN0WkJkREQzK292dm5MTXFHaWNIdSs0QzJ4V1ZVQkJ1anQ5Y2Fs?=
 =?utf-8?B?VUUwNjI4TTFoOTVGR24xMlI1OTdGcDU1cnkvS0JLeWFxNzU0ZzY1d1Rwd2NZ?=
 =?utf-8?B?cFNJN1E1Tkg5elpTdG9EWGNZTndHUVlkTkFOcWhXTWpRbnNKNE1OUjJwYWlV?=
 =?utf-8?B?T2xTSW1vWXJBb050YTl4bFdmTzdJaTAxWTUrQTgyb2NPWUNxU3JSZHJKbkhU?=
 =?utf-8?B?d05OcHFKellwNysrLzhGaDVnRFBTeDIxNkJhaE5YalN2andmeWE5WkI0THVC?=
 =?utf-8?B?SW1OMGtDNkpnTEdoK3VsaFltbG11Uk1TL3U4ZTVuaUJsbmxETVJmbkQ3Y0VZ?=
 =?utf-8?Q?KC9KZL/NfQnLE8fzVje00e1aY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OqMnJ9gF0ewfdAXZ6kzoEOPjWXEO9oeL5JF0DZFFxl2eJp5sSqV1CwRD0LX2FGZM6hH8odQ+PjBV8PZZd+WkT5kLzMY6OmIbxYi9Ltp8c4+xTcNoz1eDhpTw1OldKF6r5nJhTmnUrrztgZsUD6RoZJYlnuz5bNVRGmcBwodG8/U3RP1VVyX/R4WVdAj4r3XY9h2xUCK7I3LcPQssie7uhKPAhUQKpSQqgAwBF4rBhnTCQd7yj3QvdrmW16NXBs6yD1VnQeik+XDFio3VixuhMvbs8eN3umzZvzkDwLJ85eEe4a2FMMmY1Qku1YJLP6zXtms3E0kDPphzonm99aZOJET8CVDADKbSMocgEcoth9fxGhyIE58+WFGb8YYCi38pZq7P4yWABx3I10sqai0bMfzVwXygs3kIaSgV6g/bfrkMFKJsCDgYqBSeecaCGSfGacklgVWw2rrey3Qob1iXx7KiCAhaLV2fXpZLG3S3jORbYWmlcmcRn/tyZgxNS7IzwciFrA4jwwaaiYDTmfHkqBIOPGirr4uflicS7I/JykFJAf7QILeOHkHFhZBTuEbFiFEo8Fqb6x+akeFYwFTXVcpLQkJXieYyGqiH9jKVDh8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d431052-cea5-443d-33b6-08dc4d223540
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 23:20:49.8508 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J9ovNlntlZsfOHDeoLvFo+TZerxWjEa/DWjV/1ubbalIhCTBK7xEBqbmA/SWxj0yEE6cGGgNxyr+YbU2uLHMOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6514
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_24,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0
 bulkscore=0 spamscore=0 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403250146
X-Proofpoint-ORIG-GUID: rYCfD0lhcfzPeXmFT-ZHAhvX_0oSkIIp
X-Proofpoint-GUID: rYCfD0lhcfzPeXmFT-ZHAhvX_0oSkIIp
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0b-00069f02.pphosted.com
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



On 3/24/2024 11:13 PM, Jason Wang wrote:
> On Sat, Mar 23, 2024 at 5:14 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>
>>
>> On 3/21/2024 10:08 PM, Jason Wang wrote:
>>> On Fri, Mar 22, 2024 at 5:43 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>
>>>> On 3/20/2024 8:56 PM, Jason Wang wrote:
>>>>> On Thu, Mar 21, 2024 at 5:03 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>>> On 3/19/2024 8:27 PM, Jason Wang wrote:
>>>>>>> On Tue, Mar 19, 2024 at 6:16 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>>>>> On 3/17/2024 8:22 PM, Jason Wang wrote:
>>>>>>>>> On Sat, Mar 16, 2024 at 2:45 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>>>>>>> On 3/14/2024 9:03 PM, Jason Wang wrote:
>>>>>>>>>>> On Fri, Mar 15, 2024 at 5:39 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>>>>>>>>> On setups with one or more virtio-net devices with vhost on,
>>>>>>>>>>>> dirty tracking iteration increases cost the bigger the number
>>>>>>>>>>>> amount of queues are set up e.g. on idle guests migration the
>>>>>>>>>>>> following is observed with virtio-net with vhost=on:
>>>>>>>>>>>>
>>>>>>>>>>>> 48 queues -> 78.11%  [.] vhost_dev_sync_region.isra.13
>>>>>>>>>>>> 8 queues -> 40.50%   [.] vhost_dev_sync_region.isra.13
>>>>>>>>>>>> 1 queue -> 6.89%     [.] vhost_dev_sync_region.isra.13
>>>>>>>>>>>> 2 devices, 1 queue -> 18.60%  [.] vhost_dev_sync_region.isra.14
>>>>>>>>>>>>
>>>>>>>>>>>> With high memory rates the symptom is lack of convergence as soon
>>>>>>>>>>>> as it has a vhost device with a sufficiently high number of queues,
>>>>>>>>>>>> the sufficient number of vhost devices.
>>>>>>>>>>>>
>>>>>>>>>>>> On every migration iteration (every 100msecs) it will redundantly
>>>>>>>>>>>> query the *shared log* the number of queues configured with vhost
>>>>>>>>>>>> that exist in the guest. For the virtqueue data, this is necessary,
>>>>>>>>>>>> but not for the memory sections which are the same. So essentially
>>>>>>>>>>>> we end up scanning the dirty log too often.
>>>>>>>>>>>>
>>>>>>>>>>>> To fix that, select a vhost device responsible for scanning the
>>>>>>>>>>>> log with regards to memory sections dirty tracking. It is selected
>>>>>>>>>>>> when we enable the logger (during migration) and cleared when we
>>>>>>>>>>>> disable the logger. If the vhost logger device goes away for some
>>>>>>>>>>>> reason, the logger will be re-selected from the rest of vhost
>>>>>>>>>>>> devices.
>>>>>>>>>>>>
>>>>>>>>>>>> After making mem-section logger a singleton instance, constant cost
>>>>>>>>>>>> of 7%-9% (like the 1 queue report) will be seen, no matter how many
>>>>>>>>>>>> queues or how many vhost devices are configured:
>>>>>>>>>>>>
>>>>>>>>>>>> 48 queues -> 8.71%    [.] vhost_dev_sync_region.isra.13
>>>>>>>>>>>> 2 devices, 8 queues -> 7.97%   [.] vhost_dev_sync_region.isra.14
>>>>>>>>>>>>
>>>>>>>>>>>> Co-developed-by: Joao Martins <joao.m.martins@oracle.com>
>>>>>>>>>>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>>>>>>>>>>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>>>>>>>>>>>>
>>>>>>>>>>>> ---
>>>>>>>>>>>> v3 -> v4:
>>>>>>>>>>>>         - add comment to clarify effect on cache locality and
>>>>>>>>>>>>           performance
>>>>>>>>>>>>
>>>>>>>>>>>> v2 -> v3:
>>>>>>>>>>>>         - add after-fix benchmark to commit log
>>>>>>>>>>>>         - rename vhost_log_dev_enabled to vhost_dev_should_log
>>>>>>>>>>>>         - remove unneeded comparisons for backend_type
>>>>>>>>>>>>         - use QLIST array instead of single flat list to store vhost
>>>>>>>>>>>>           logger devices
>>>>>>>>>>>>         - simplify logger election logic
>>>>>>>>>>>> ---
>>>>>>>>>>>>        hw/virtio/vhost.c         | 67 ++++++++++++++++++++++++++++++++++++++++++-----
>>>>>>>>>>>>        include/hw/virtio/vhost.h |  1 +
>>>>>>>>>>>>        2 files changed, 62 insertions(+), 6 deletions(-)
>>>>>>>>>>>>
>>>>>>>>>>>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>>>>>>>>>>>> index 612f4db..58522f1 100644
>>>>>>>>>>>> --- a/hw/virtio/vhost.c
>>>>>>>>>>>> +++ b/hw/virtio/vhost.c
>>>>>>>>>>>> @@ -45,6 +45,7 @@
>>>>>>>>>>>>
>>>>>>>>>>>>        static struct vhost_log *vhost_log[VHOST_BACKEND_TYPE_MAX];
>>>>>>>>>>>>        static struct vhost_log *vhost_log_shm[VHOST_BACKEND_TYPE_MAX];
>>>>>>>>>>>> +static QLIST_HEAD(, vhost_dev) vhost_log_devs[VHOST_BACKEND_TYPE_MAX];
>>>>>>>>>>>>
>>>>>>>>>>>>        /* Memslots used by backends that support private memslots (without an fd). */
>>>>>>>>>>>>        static unsigned int used_memslots;
>>>>>>>>>>>> @@ -149,6 +150,47 @@ bool vhost_dev_has_iommu(struct vhost_dev *dev)
>>>>>>>>>>>>            }
>>>>>>>>>>>>        }
>>>>>>>>>>>>
>>>>>>>>>>>> +static inline bool vhost_dev_should_log(struct vhost_dev *dev)
>>>>>>>>>>>> +{
>>>>>>>>>>>> +    assert(dev->vhost_ops);
>>>>>>>>>>>> +    assert(dev->vhost_ops->backend_type > VHOST_BACKEND_TYPE_NONE);
>>>>>>>>>>>> +    assert(dev->vhost_ops->backend_type < VHOST_BACKEND_TYPE_MAX);
>>>>>>>>>>>> +
>>>>>>>>>>>> +    return dev == QLIST_FIRST(&vhost_log_devs[dev->vhost_ops->backend_type]);
>>>>>>>>>>> A dumb question, why not simple check
>>>>>>>>>>>
>>>>>>>>>>> dev->log == vhost_log_shm[dev->vhost_ops->backend_type]
>>>>>>>>>> Because we are not sure if the logger comes from vhost_log_shm[] or
>>>>>>>>>> vhost_log[]. Don't want to complicate the check here by calling into
>>>>>>>>>> vhost_dev_log_is_shared() everytime when the .log_sync() is called.
>>>>>>>>> It has very low overhead, isn't it?
>>>>>>>> Whether this has low overhead will have to depend on the specific
>>>>>>>> backend's implementation for .vhost_requires_shm_log(), which the common
>>>>>>>> vhost layer should not assume upon or rely on the current implementation.
>>>>>>>>
>>>>>>>>> static bool vhost_dev_log_is_shared(struct vhost_dev *dev)
>>>>>>>>> {
>>>>>>>>>          return dev->vhost_ops->vhost_requires_shm_log &&
>>>>>>>>>                 dev->vhost_ops->vhost_requires_shm_log(dev);
>>>>>>>>> }
>>>>>>> For example, if I understand the code correctly, the log type won't be
>>>>>>> changed during runtime, so we can endup with a boolean to record that
>>>>>>> instead of a query ops?
>>>>>> Right now the log type won't change during runtime, but I am not sure if
>>>>>> this may prohibit future revisit to allow change at the runtime,
>>>>> We can be bothered when we have such a request then.
>>>>>
>>>>>> then
>>>>>> there'll be complex code involvled to maintain the state.
>>>>>>
>>>>>> Other than this, I think it's insufficient to just check the shm log
>>>>>> v.s. normal log. The logger device requires to identify a leading logger
>>>>>> device that gets elected in vhost_dev_elect_mem_logger(), as all the
>>>>>> dev->log points to the same logger that is refenerce counted, that we
>>>>>> have to add extra field and complex logic to maintain the election
>>>>>> status.
>>>>> One thing I don't understand here (and in the changelog) is why do we
>>>>> need an election here?
>>>> vhost_sync_dirty_bitmap() not just scans the guest memory sections but
>>>> the specific one for virtqueues (used rings) also. To save more CPU
>>>> cycles to the best extend, the guest memory must be scanned only once in
>>>> each log iteration, though the logging for used rings would still have
>>>> to use the specific vhost instance, so all vhost_device instance still
>>>> keeps the dev->log pointer to the shared log as-is. Generally the shared
>>>> memory logger can be picked from an arbitrary vhost_device instance, but
>>>> to keep the code simple, performant and predictable
>>> This is the point, I don't see why election is simpler than picking an
>>> arbitrary shared log in this case.
>> Maybe I missed your point, but I am confused and fail to understand why
>> electing a fixed vhost_dev is not as simple? Regardless of the
>> specifics, I think the point is one _fixed_ vhost_dev has to be picked
>> amongst all the instances per backend type in charge of logging guest
>> memory, no matter if it's at the start on the list or not.
> See below.
>
>>>> , logger selection is
>>>> made on the control path at the vhost add/remove time rather than be
>>>> determined at the dirty log collection runtime, the latter of which is
>>>> in the hotpath.
>>>>
>>>>>> I thought that Eugenio's previous suggestion tried to simplify
>>>>>> the logic in vhost_dev_elect_mem_logger(), as the QLIST_FIRST macro that
>>>>>> gets expanded to use the lh_first field for the QLIST would simply
>>>>>> satisfy the basic need. Why extra logic to make the check ever more
>>>>>> complex, is there any benefit by adding more fields to the vhost_dev?
>>>>> I don't get here, the idea is to just pick one shared log which should
>>>>> be much more simpler than what is proposed here.
>>>> The code you showed earlier won't work as all vhost_device instance
>>>> points to the same dev->log device...
>>> This part I don't understand.
>> vhost_log_get() has the following:
>>
>>       log = share ? vhost_log_shm[backend_type] : vhost_log[backend_type];
>>
>>       if (!log || log->size != size) {
>>           log = vhost_log_alloc(size, share);
>>           if (share) {
>>               vhost_log_shm[backend_type] = log;
>>           } else {
>>               vhost_log[backend_type] = log;
>>           }
>>       } else {
>>           ++log->refcnt;
>>       }
>>
>> So for a specific backend type, vhost_log_get() would return the same
>> logger device (stored at either vhost_log_shm[] or vhost_log[]) to all
>> vhost_dev instances, and the check you suggested earlier:
>>
>> dev->log == vhost_log_shm[dev->vhost_ops->backend_type]
>>
>> will always hold true if the vhost_dev instance (representing the
>> specific virtqueue) is active.
> Right, so the point is see if we can find something simpler to avoid
> the QLIST as it involves vhost_dev which seems unnecessary.
To make it independent of the specific vhost_dev, it would require the 
framework (migration dirty logger) to pass down "dirty_sync_count" like 
information to the vhost layer through memory listener .log_sync 
interface. I'm not sure if this change is worth the effort, as this 
patch is meant to fix a long standing bug I suppose we need to find out 
a way that is applicable to back-port to past -stable's.

>
> Does something like a counter work?
It won't. It seems the "rounds" counter is still per vhost_dev instance, 
but we need it per migration log_sync iteration across all vhost_dev 
instance of same backend type. Maybe I miss something, but I don't see 
how easily it would be to come up with proper accounting for "rounds", 
if not going through the list of vhost_dev instances at the run time 
(which is what I tried to avoid).


Thanks,
-Siwei
>
> vhost_sync_dirty_bitmap() {
>        rounds ++;
>        vhost_dev_sync_region(rounds);
> }
>
> vhost_dev_sync_region(rounds) {
>        if (dev->log->rounds == rounds)
>             return;
>        else
>             dev->log->rounds;
> }
>
> (pseudo codes, just used to demonstrate the idea).
>
> Thanks
>
>> Regards,
>> -Siwei
>>> Thanks
>>>
>>>> Regards,
>>>> -Siwei
>>>>> Thanks
>>>>>
>>>>>> Thanks,
>>>>>> -Siwei
>>>>>>
>>>>>>>>> And it helps to simplify the logic.
>>>>>>>> Generally yes, but when it comes to hot path operations the performance
>>>>>>>> consideration could override this principle. I think there's no harm to
>>>>>>>> check against logger device cached in vhost layer itself, and the
>>>>>>>> current patch does not create a lot of complexity or performance side
>>>>>>>> effect (actually I think the conditional should be very straightforward
>>>>>>>> to turn into just a couple of assembly compare and branch instructions
>>>>>>>> rather than indirection through another jmp call).
>>>>>>> Thanks
>>>>>>>
>>>>>>>> -Siwei
>>>>>>>>
>>>>>>>>> Thanks
>>>>>>>>>
>>>>>>>>>> -Siwei
>>>>>>>>>>> ?
>>>>>>>>>>>
>>>>>>>>>>> Thanks
>>>>>>>>>>>


