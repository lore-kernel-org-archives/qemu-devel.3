Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA2D8C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 11:46:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR9IT-00046K-OO; Tue, 09 Jul 2024 07:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sR9IS-00040E-3g
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 07:46:12 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sR9IO-0005bw-9W
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 07:46:11 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4697tUio017889;
 Tue, 9 Jul 2024 11:46:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:from:to:cc:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=WDGyhwKkbp/hzYZMfz+nqv2FOBwq0Qu4qFJ2ybfN368=; b=
 i98XtIZk5fZs76Pj2foa9HOoq1zQ0dr/Co3UUvFEdpEIVXQLWezBbD7I5G/Kl1XE
 VcA0yXAWG39lM8r76n6ENnJqJ2XQp9o0E4cvmXMVfLVR8N1ntnw1CL7lEKdfupWT
 qKcyfSQ6bOrvF4pDoTox5HqOJcm+4Xr5LYMHdlWvvg1A4JKeV0nSkcxuHrDU/UUs
 q5tVPox7uPQww0EYMED4Rs6nC9OLLtGXoKPl63mte3s7bHlShFKR8B2KOOr0ClU9
 LdXXoaLgBCbKNIiVi47CWOGnnc5gj5rIwqs30VdTzV/n7uPaNKSvinXjv+1DbTLi
 OkJOmnLFUR0nVza7VkOqoQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wgpvqkh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Jul 2024 11:46:05 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 469AmFQj005025; Tue, 9 Jul 2024 11:46:04 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 407tvdhphn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Jul 2024 11:46:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EiJ8ApS6/JGuV6t8b/eJhYQ5fF8lhZx6yl3mLAwoawoUE44JF4iYeQfQ+csnr1rcTtLwnP6KuY2W/kU0ZqPhRx07zr1ri4cKydSqcNoJah/SWfhFTegvg2aaqFXeexB9d1k+fOwMHedaxq9wkFJ1xfvkDXldHs/zVvQ/eMEUzsCTrnHVnwBY1Xl6zhNUZOjAhhip1iMiuKvMrk4VSrY4NXZVzs3W+WqFUm1qyk8tY/eM9PrfqENtTVz5kRL+6GLwi/Coex4JetNefDGZmdKkcP7awt3l4Ws2kM0ajdkJsyNTkNmNGnZeQGohNjglkXOi9EvCkw+1Dd5TaSJVWDmAXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDGyhwKkbp/hzYZMfz+nqv2FOBwq0Qu4qFJ2ybfN368=;
 b=ZOYBM08eJifyYludfj0XlUw4kOBkylfxld5SsCvu9TvwS+KhCO7NVwsUrPLYJc6dJsk+SdLHKnCAWTqLn7b8fXoRhbbDhaGnDdMlHewyBejCEt7HlJemqrlG4n33R6Y0IxC71MH1H3fayVWuOHOoU5R6+5G26Q9GGRzhw5YUqGIkoc4Pb2ARdDLIX/uK9k2kG72dYlT7KPToesnq8WbsRCmOR/5viDwMLAPUekalfyvyu7rKN8163emCNAPOb8rOf240XyR+NHE71GJZ38F3r4rrBnK6FRI2JoLkUISrOpL13k+0bDFqvTZpFCsWQ8OqLK96m9P+IDHkb60k+O4FhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDGyhwKkbp/hzYZMfz+nqv2FOBwq0Qu4qFJ2ybfN368=;
 b=Jb3KG+qtl0S1zJOq95epoDlliLkXrSnNYNzQT+PbMU3HGjAkqh57cm1UOf4X5D2nr6BfTHBhLrC+W8FnMftU9/sXL/aiu3Ea0vbWuJ9q3asHef/hprntLkeuAsZuAX31q+Ii9FDqkDjwGsXfGGzWSHsI1BqsdQaCVZXKg7C5WSw=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by PH0PR10MB5755.namprd10.prod.outlook.com (2603:10b6:510:149::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 11:46:02 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%6]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 11:46:02 +0000
Message-ID: <59a63429-831b-4bcd-b805-9fb83b8bcdd0@oracle.com>
Date: Tue, 9 Jul 2024 12:45:29 +0100
Subject: Re: [PATCH v3 01/10] vfio/iommufd: Don't fail to realize on
 IOMMU_GET_HW_INFO failure
From: Joao Martins <joao.m.martins@oracle.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20240708143420.16953-1-joao.m.martins@oracle.com>
 <20240708143420.16953-2-joao.m.martins@oracle.com>
 <SJ0PR11MB67440E96F272F5D349023AEB92DB2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <e822d50d-8147-4846-94bf-fd32cb1aff99@oracle.com>
Content-Language: en-US
In-Reply-To: <e822d50d-8147-4846-94bf-fd32cb1aff99@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR05CA0084.eurprd05.prod.outlook.com
 (2603:10a6:208:136::24) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|PH0PR10MB5755:EE_
X-MS-Office365-Filtering-Correlation-Id: f5fcba96-fac3-40e6-9819-08dca00cb52f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0ErOW1ZR3dRV2VYTUd0bEM2YVB3cEVCa2Z5ZVJzR1NTbXpHemd6dzdCSnVH?=
 =?utf-8?B?Mlg1aWZlT0xvb3VKMzJVS24rV0lpSjd2Um92TXNSdjFaT2FDendjM1M2NXAy?=
 =?utf-8?B?b2Q4ZDcyb2wzZ3NRZ2ZSQWpwRGFMUi8wQXVycmFqaHlIdGhQSU1iaCtmekdJ?=
 =?utf-8?B?cFBsYjQ5RUFDaDl3d0RyejlFVmxXTVp4S0xTRkJnN2p4TlJ4Y2dqRC9PQkR2?=
 =?utf-8?B?ejQvWVFqWGdoa2NudjNIaEpwcFJjM3dET3lpSVQ3Wmp1M0MrbWtYTElIVzZJ?=
 =?utf-8?B?NE92YjFoajRHaExmUko3K1JmY1pEVllLbHpmL3REQm14bW5xaVJkWWtFcUdt?=
 =?utf-8?B?RDU3QkxoSVRMQXg3STJ0akhvd2xwL1BNUkEzTGtMMFZCejk5VGcyVEh6QllJ?=
 =?utf-8?B?bjR6ZzZsM3g0UDhnWnZrbmFUVWU1Z1NLM3BCQ3JydlM2M0xuMkFPL005dFAv?=
 =?utf-8?B?Nml6d2RtUThvUW9odGU4Yk5aRlM0OTlCT0s3N3drT3VBRmZvRUtyZmFDS0Mr?=
 =?utf-8?B?QnIrcm5jQXgxUk50UGthbDBCNFVESGpBUWdGa0JZcVNQVUoyU0s0ellGQVh6?=
 =?utf-8?B?MnNsSktwekFDZUJvVkhCRmZ3NEltZ2pCNktkRW9yZ1U1aHZlUFhLVnFsdEhC?=
 =?utf-8?B?VHJzR3hPVUEzTEFFamNqdUw2ajBYbEt2VTJaVDVXQW5zNW1LMXUrbjdMVVdZ?=
 =?utf-8?B?eXQ0dXNEb0M2MldYQ0FQK3d5dDhwWE1uMk5DUnd1a29MVnVYUDFMREU4THpp?=
 =?utf-8?B?eE9DQWFZLy9UTUhaWm1EZzZhNm9LZU9LbkdycUtPbHVuaytUMWVYRDVmeGUw?=
 =?utf-8?B?ekRuMG54RGtES1J1Tm84WTY1RVZFek1GTGhSYVVObXJvTFFicWxCMnJteXJ0?=
 =?utf-8?B?TUNBZ2V2clB3NnB6VzZhZDdFZnN4NTFpdWkreEVBd0grcWxIOXBzNDlCM1dN?=
 =?utf-8?B?S253V1BCVG9scHcxUUJHUnBlRkoyT0NwczNsTTQrd0dDdUNsTVdMK1hYY2Vr?=
 =?utf-8?B?ZTAwYk56b2FrcmdrZGRaYjlqMWFjT3kyQU5ZYVI3NmVvQ2ZveWN3UUZEZ1pG?=
 =?utf-8?B?bE5oZTBaVE1PV1h6TVFaQklkUFEvRm1nWXkxVG44WTcrcHNSUktTSFRYd1lw?=
 =?utf-8?B?c1hodTZlN1U1Vk5NejhUd0ltSEYxaHZpY1JRWkVSOVF3TGtyamp4SUFnODJK?=
 =?utf-8?B?ekdmajM1RDV2a0ZRSFlyemV0VFJHbGFpcXc4N3FDUEhDZXRFOFo4akozWVF1?=
 =?utf-8?B?NnFpV3hXeVRvWUFzSkEzQnI2bkxsOEtyYkNPbGpqVTBoNmd4VTZ0NDZBNGVj?=
 =?utf-8?B?OUFhU2tQcnlEc2J5TFZwaHhiYzU2b1RQam1oQXNwTkdYSm5oY3pKUnlxZDNB?=
 =?utf-8?B?S2hUbXREcVUvT3k1WXRqK0l5aDJldXZob1Y1NTJaZ2VVY2NaK2FzNXlic3NQ?=
 =?utf-8?B?b05YRWJ0RmNVaXlwZFR5eEZHRi81YTQzRnVzanY2cTBuTW4xM1FOQ3RJQjJD?=
 =?utf-8?B?SklhTWRXcDhXVWlUd1FtSE44cW5lQnBndXVDSjBYeGo2NHFYelpyc0Fxejhq?=
 =?utf-8?B?dTh4V2dDTnZJOXJ4ajYyTTE0Q1NZdkxUOTlPOUNKbDNiNXN5TWZTclFMbUR2?=
 =?utf-8?B?OEVrbVdhWEpTampBc1BzZDUraVJRN2VOM1dEY3BXV1k1aURJcDNGSEo3NUpB?=
 =?utf-8?B?L3BvVDFjV3MySE9jblZmRS9kVHM0RFI0OXVKTlN3b01yZzhGUDV4bWEyM2FE?=
 =?utf-8?B?UndxeUtvT1hoSUQ1SHN5Kys0dmlMakZPMG4wMmpSY3FRWlVBZldtaEVUWmdJ?=
 =?utf-8?B?bkdCSVNjcXVOVVUxNldnQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0U1c0N2b3h4RjNQT2hhSEFlMFVDcHFabDR3M0o1QzM2WncyQmpkZTRscGF1?=
 =?utf-8?B?OURSSi9JK05RWFpuRHY4bm1SMTcycHVJS3J2NFhtc21MZmxPYnRSNDlOOUNI?=
 =?utf-8?B?M1lTeTh4amZ3K1hhdzZIZjNkenN5ZW5JTThVejcwbk1McStOZExOR2hSY1F0?=
 =?utf-8?B?NU5GRW9uTVo5b0pKWHM5bHBNSy8zUkpHQ2RPTXdadnNrbWQ2NmRKUkdwNlNt?=
 =?utf-8?B?cHhaRklVMlpYS2RTVnVaOGpFQUJ5ZEVqRkZlcmUzZzRGbVFhNkMzWmVFZmRQ?=
 =?utf-8?B?L1MvOGMxTlpmeDNpMnhLbDJzYzBQYk11ZEp0ZGtramNZWUlMMEswcy9Sc21Q?=
 =?utf-8?B?TkRYUWZJb3dqcG1WU2pFcVAwZ0c1Z2xwSHRXcXpmdUdJZzNYK0xkY1dBVlJz?=
 =?utf-8?B?UFJ1M0VoNExZbmp5cVg4bC83emg2QTZDc3FQVy92UDZtZ2NNSnAwUUJsK0w3?=
 =?utf-8?B?Q2ZQU0Q0Y0ZQS1MyTFVTMW8zOGhpRG1TaGY3OWtaRVp1UXJMb3IvbmpLYVpq?=
 =?utf-8?B?MlRmR1RMK0FiQkR2a1NXcExZOW84eUQ1UkVGZGN1RG83d0pzNDBrZmVBajdE?=
 =?utf-8?B?Q0pVZSs4L1g2Tnd0eFZkd0R6WVBUcytNRWhubFFwQlc2cDVjVmhZTDVieUxv?=
 =?utf-8?B?QmIxNEN6WXRBN05WaEUvaGRwMno0c0ZSdlF2OEhXajlZWjJLSk9RQ2dhTTNn?=
 =?utf-8?B?OFZDUW1OUThrdTcraTBuY1BNL2ZFSHlTMEkxSDQ1YndvN2JnMXRQak11dDZs?=
 =?utf-8?B?WVNEQ3hvM2V2ejVxM0xSOHNwdDdnWUZ5aFZsdU4yU2NlbUZmTzFONnRLTmFX?=
 =?utf-8?B?QnNmaWlXdGk5SXM3V0VlNHhVWmY0OFUrNVdEWFYwWS9FdTltQjQ3TEVMaDVv?=
 =?utf-8?B?aVdLYVoxYjU5d1NrYlM1VzJucXhlZXJTMzRCczJvRFVxY080T2lvajBZOTNT?=
 =?utf-8?B?OWtEcjVrSTAyNkJGRUxhTVpVc1JVWm1OcW5pNGlmR1dFUjBCMmV4b01lVVFI?=
 =?utf-8?B?NGw1Smt5cHRKNzMyS001SzViU21UU1VuQktDVWI5MXhEWlo2UjRyalF4Wjlu?=
 =?utf-8?B?Z1FieXo2REw0L2Q0cUxEd3U0YUk3Rm9VeDFNWnJ6M3JURGswbkY3SCtjQ3ph?=
 =?utf-8?B?Z2xaYUxIVnZ1OE1UVFdTQ1R6TnAxSHBFZ2VqTWtqZ1NsT2NFejE3K3hIK29E?=
 =?utf-8?B?c29kcGtuSENMYnRzMHRsb0drTmVLU2plSlVNOEpjQVVZUFZLeDcrbUlkRktX?=
 =?utf-8?B?SVJaMFM5S0gzYkpIRU15UGh2SFdHWUZsekZMK29IOUFIbXprcXMrOUd5T0FC?=
 =?utf-8?B?ak1GNzM4YitlaGQzeGx5aGlFMDZaUVYrd0lkS3R4U1V4ZW8vOWZLYzR5TGJZ?=
 =?utf-8?B?NEFSR3Jqck81bzl0Ylg2TVZZMzcrVEdVOUE3OVpnaGorSUc3T1BQK0tNUkFF?=
 =?utf-8?B?OEtQWTVkSVVQOElzbFVOTERncHRrTTdwdDNUWHpTV09nNWNSMUNUamppN3Iz?=
 =?utf-8?B?UzdPa0ZuOTd0dFFFTThXa3h0WXRhdkNFalhzbzJFQ1hqMmFtZ08zRi92S2NX?=
 =?utf-8?B?cVdFTkpMbjVwZE9PM3owaUdEdzJVcE9xeEtBaEF3V1Y3NGdHdGtrQWlNMU92?=
 =?utf-8?B?WFgyeDN1TWtXcmFiUS9qWHl2bG1GUmVWcys5QVBuUkJYc2NvNGNEWU9OWjMx?=
 =?utf-8?B?OFd2d3JhSkR4YzU0SjkwemRmbEFjQmRpeGVQTXU2ZGlMWVczNHczUW5LZ0NF?=
 =?utf-8?B?UzA3Unh2bWRDTGFYelBYNkoxRXk2R2kzSTliK1BseVdmVElTdFYrN3QyWHBo?=
 =?utf-8?B?djE3ZnRlNTZPNjQ0VGlyQ2c4QStlTENaMlF4bDA5S0JSUi9kN29INGF4MFZU?=
 =?utf-8?B?eC96cVRFSCtSN1VTOGJTU0k2Vk5NVlc3S2lvc3o5eDdVVWhpQ0FmL1ozN3Z2?=
 =?utf-8?B?ZmFPS3dRNGhIcnQyNklodkppNExiOTdhbSttNGtyRnpOK09oUStGRDdQaE5j?=
 =?utf-8?B?K0hTQUhGdHAzK1JZbHNsdE44aHRPY3REKzFobVhaWXZ0cGVQdmJsV3JacTRW?=
 =?utf-8?B?QUViU1dtR2c5WmNYcnpCRU9zOFBLNTlZRmxTSjQxNDNPWEd6Ly9yck1vVEZF?=
 =?utf-8?B?dFdYNlNWMG9ZRjFCOGVCNlpBODlwYnljT0RHM0lJaEw3NFYraGVXUXhJeFFx?=
 =?utf-8?B?SkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: G9FCt92JtXscGDEkJAcOTjbughVj7xh/LILK/iGlsbB3Cv9k659Xrc6sZ9G6rO5tzDWbZ3mcqF4k9KXE78FwmqMPGbMmKRY5Qq/CCzUovWhvE3wVjtz+UEGiDmollsKip8CAon4BkRog0UvWUy5TZ3RQOF4YJ4AuTu9Eje5QQ6AaR6bEkJjjEydqHD8ykCvbaYO9WEP8gKkUdj8ZTEK2QYSXCnaRSfJBVZ7ig1eKV4SdX+JAZH7pHaguq1SDrVg1Crha2P5L9eKyMWonvUf6B53o/2QEZ4SxO/GggBeiZBQ7yYJX9Q4Lg5yI5/56GbvyXrEm9BzL/RUjEpXmPA9gath2U7o5yUxXgut3YIbmG5MtOUw8czhPHQbI3Z994ThLvRE8lrj0+++rqBbjzsQV5EF3wR6+oCaFkCPo5vBnOEroepr3dx/zRg/PRk3NS41qSnLmrRrHL6TQPW/PnzBC0auFLSq+Tl+LvAkzo07W4EcBHboGh0PkX/lJQgP81YTjBdWXvoaWcGhyOj2lGTLsBbmmUKpvAjHC6CcXPRCet8ZrOZRYXI4ioTwR9r6qRtNwKccv/WgbEsAMT9rNlSroS5M+56G5HQ1Qxyt3epaa04U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5fcba96-fac3-40e6-9819-08dca00cb52f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 11:46:02.2110 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GJbdIcWnOxmjpT/J/2OO9bIkFSS+/o23Xj3GsNlIxL0L+MMYTpT749T+PWmzeOF26GR5leM3vNXKc/Lx7mJKwxF3KXdT+kAzm0K4789gqzA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5755
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_02,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407090079
X-Proofpoint-ORIG-GUID: r93TuoiqazNqOgz4Yx8dCKQqyFxa8qwC
X-Proofpoint-GUID: r93TuoiqazNqOgz4Yx8dCKQqyFxa8qwC
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

On 09/07/2024 09:56, Joao Martins wrote:
> On 09/07/2024 04:43, Duan, Zhenzhong wrote:
>> Hi Joao,
>>
>>> -----Original Message-----
>>> From: Joao Martins <joao.m.martins@oracle.com>
>>> Subject: [PATCH v3 01/10] vfio/iommufd: Don't fail to realize on
>>> IOMMU_GET_HW_INFO failure
>>>
>>> mdevs aren't "physical" devices and when asking for backing IOMMU info, it
>>> fails the entire provisioning of the guest. Fix that by filling caps info
>>> when IOMMU_GET_HW_INFO succeeds plus discarding the error we would
>>> get into
>>> iommufd_backend_get_device_info().
>>>
>>> Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> Fixes: 930589520128 ("vfio/iommufd: Implement
>>> HostIOMMUDeviceClass::realize() handler")
>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>> ---
>>> hw/vfio/iommufd.c | 12 +++++-------
>>> 1 file changed, 5 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>> index c2f158e60386..a4d23f488b01 100644
>>> --- a/hw/vfio/iommufd.c
>>> +++ b/hw/vfio/iommufd.c
>>> @@ -631,15 +631,13 @@ static bool
>>> hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>>>
>>>     hiod->agent = opaque;
>>>
>>> -    if (!iommufd_backend_get_device_info(vdev->iommufd, vdev->devid,
>>> -                                         &type, &data, sizeof(data), errp)) {
>>> -        return false;
>>> +    if (iommufd_backend_get_device_info(vdev->iommufd, vdev->devid,
>>> +                                         &type, &data, sizeof(data), NULL)) {
>>
>> This will make us miss the real error. What about bypassing host IOMMU device
>> creation for mdev as it's not "physical device", passing corresponding host IOMMU
>> device to vIOMMU make no sense.
> 
> Yeap -- This was my second alternative.
> 
> I can add an helper for vfio_is_mdev()) and just call
> iommufd_backend_get_device_info() if !vfio_is_mdev().  I am assuming you meant
> to skip the initialization of HostIOMMUDeviceCaps::caps as I think that
> initializing hiod still makes sense as we are still using a
> TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO somewhat?
> 
Something like this is what I've done with this patch, see below. I think it
matches what you suggested? Naturally there's a precedent patch that introduces
vfio_is_mdev().

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index a4d23f488b01..c0a019dffdb6 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -631,8 +631,9 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod,
void *opaque,

     hiod->agent = opaque;

-    if (iommufd_backend_get_device_info(vdev->iommufd, vdev->devid,
-                                         &type, &data, sizeof(data), NULL)) {
+    if (!vfio_is_mdev(vdev) &&
+        iommufd_backend_get_device_info(vdev->iommufd, vdev->devid,
+                                        &type, &data, sizeof(data), errp)) {
         hiod->name = g_strdup(vdev->name);
         caps->type = type;
         caps->aw_bits = vfio_device_get_aw_bits(vdev);
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index d95aa6b65788..f092c1537999 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3115,7 +3115,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)

     vfio_bars_register(vdev);

-    if (!pci_device_set_iommu_device(pdev, vbasedev->hiod, errp)) {
+    if (!is_mdev && !pci_device_set_iommu_device(pdev, vbasedev->hiod, errp)) {
         error_prepend(errp, "Failed to set iommu_device: ");
         goto out_teardown;
     }
@@ -3238,7 +3238,9 @@ out_deregister:
         timer_free(vdev->intx.mmap_timer);
     }
 out_unset_idev:
-    pci_device_unset_iommu_device(pdev);
+    if (!is_mdev) {
+        pci_device_unset_iommu_device(pdev);
+    }
 out_teardown:
     vfio_teardown_msi(vdev);
     vfio_bars_exit(vdev);
@@ -3268,6 +3270,7 @@ static void vfio_exitfn(PCIDevice *pdev)
 {
     VFIOPCIDevice *vdev = VFIO_PCI(pdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
+    bool is_mdev = vfio_is_mdev(vbasedev);

     vfio_unregister_req_notifier(vdev);
     vfio_unregister_err_notifier(vdev);
@@ -3283,7 +3286,9 @@ static void vfio_exitfn(PCIDevice *pdev)
     vfio_pci_disable_rp_atomics(vdev);
     vfio_bars_exit(vdev);
     vfio_migration_exit(vbasedev);
-    pci_device_unset_iommu_device(pdev);
+    if (!is_mdev) {
+        pci_device_unset_iommu_device(pdev);
+    }
 }

