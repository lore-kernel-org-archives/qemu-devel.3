Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F98D6A228
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 18:32:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBedi-0004fC-CU; Thu, 14 Nov 2024 13:32:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tBedZ-0004eD-Bq
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:32:13 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tBedX-0001qJ-PE
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:32:13 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AED9QTg018726;
 Thu, 14 Nov 2024 18:32:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=JsZ38eP2BOaJwPJy+bqiXpg3CqW+Plgok9Ez0+9dozw=; b=
 Upzbi9Man8VmplcSXCdXsNbr+IeH0KVCC4aJWrhwdouX6RfCJ7yklOyN9jaHwb9v
 lYi+g8m1Au40vDDbtsFIgoAIPKjUmX+tqidEm/N6+JUabVqlGB4Nuksqtm0PaD6E
 kFGVSsvpQqbq4P/voVbnwk4VOiSEf+dWYis6kwr103RDEDyDS2pkh+m05vO8IcqZ
 f8mnzPLSkyrPbFh+jknPIO4UWlH4p3nQm7yCkEzmtIM0iWRs67UQqTmJT/dobcFa
 pxCuwmwSrPCoMiGzD/mrp/k2qcBzYro/obIy3i3S+M/mZJBpX7OiszDcqp4dAReA
 CelniN99I8hBDVQv/uML1A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0kc20ub-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Nov 2024 18:32:07 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4AEIVwY5005691; Thu, 14 Nov 2024 18:32:05 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 42sx6bk91s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Nov 2024 18:32:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j/GDHs5rxsKgR1f518jQn+8jFX3Yb2r3eCTTtATrLW0lXS/6h6g1uyuVKt+R9CJZvJwo/gEB/YmZEr1nX/F0Ys1POPY5+nxqr3LTPzhj/kWrBcblRpSTRvUhnf+QfOm/CYyDJn86b2cMFM5IaC2tBoDmNGfvKkz9b3Q3XVJLtyKNxk4udkh3AGwcP9nx0sTkiJOr+uAtPGA9j7Cl+rBQlO1HSTuc+GNBzkpGFlGV0fajcmNgEapJ4ZzViiu+RgkcpGl5+fnGb/2KPNVtlVFwhOgq9jdNSoKpghCZmoSvhSXlY79L2JC5m+2GdoRmiyHyLJFoc2CUe2xI1b2Xya8Qdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JsZ38eP2BOaJwPJy+bqiXpg3CqW+Plgok9Ez0+9dozw=;
 b=LbmAiATa9Pz8qi/oHJj2VdCOcYv7pKMClMAoScPmL/dPiUw6jKYjocvmQYWQdFPATlb/ckAFhXTtWLvUdXmU2Tlvw1DwqMVByNRd2Hxn2Cc4zP94C5xQ0juQYmFpB24TN73uAyByR1HsZ58enlUmc6F5jZuA9jCYXcYEN0OfsO8O7MWnsQ7u2ypSPFXBb/YRLgwbUGLtE9Bh9kRe7E3iKsxTPQKFPzjoblewEFsUzGSgIuhEhrJSOZ30fkrmXaomQ+I0EKbc/F9/ROSgxf3S9+WxgeNiMFD2T8C8BgIjbs31LZwF2l8moOf134NW3Nd3JWCpSwbw9s5ZvuSQ4lDiQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JsZ38eP2BOaJwPJy+bqiXpg3CqW+Plgok9Ez0+9dozw=;
 b=QATM6Mv4Y52YC5qQHITluC4eZkLrS+iL76fKKGUst0Y62v+P9tqzPFogxXLNcX41TR+5AK5YG4Ruk+aqJE/5diJc46aSPuPMl6eO5ukBa8Xec1bz0+MDyhWB1nkaVdrWoIh6fzxCTux4g3TIzVYQymvecHHsZOjeQ/VNnHYTJ5w=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SA1PR10MB6640.namprd10.prod.outlook.com (2603:10b6:806:2b6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Thu, 14 Nov
 2024 18:32:02 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 18:32:02 +0000
Message-ID: <9fd2ad89-763f-45dd-af8c-149cded3de0e@oracle.com>
Date: Thu, 14 Nov 2024 13:31:55 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 13/16] tests/qtest: defer connection
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1730468875-249970-1-git-send-email-steven.sistare@oracle.com>
 <1730468875-249970-14-git-send-email-steven.sistare@oracle.com>
 <ZzUuACXDVbhubRqo@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <ZzUuACXDVbhubRqo@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0309.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::8) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SA1PR10MB6640:EE_
X-MS-Office365-Filtering-Correlation-Id: e0901af4-69c8-4bc5-4e62-08dd04daa1d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a1NBdjNjNW5qTUp1a2ZMcVFOSjRmRVovR0VvRGlnSFJ1aUE0ME5sR3NpbTNE?=
 =?utf-8?B?V1I4M0hXVzAwTmswWFdyV2ZFdDM4T1FjNVRybGZNd1RuMmZZL3JBRlByeE9S?=
 =?utf-8?B?bHpLeWhyK3UveEdYWHl3NFJmczFieE1SZ0N1RUdJL1JTN0xmSlp6UWlnZllJ?=
 =?utf-8?B?MGZZbnFURy9lZE1PQWFCQWVWL2c0UUFZRk05b0U0Rk5xVHl0YlpjUXlmVkNy?=
 =?utf-8?B?UWxuYytrTlN6ZnViU2xoYTNqVW1CczlSK3F5TEQrU1VEbklFVXdEdHQ4ZW1r?=
 =?utf-8?B?VitKTHNLbkkraGFEWmY2ZElMQjhWazRiQXRyQnhaUXBsOXdpd3ZhdFpNdGx1?=
 =?utf-8?B?ang5bFQwRzhsbHdhY0dpclJVVk14cTU4bGhKUDZ2aGNnZTd5Mys5WTgzbEx4?=
 =?utf-8?B?Tk9oL1hOV0EyWHdFTTMzc2s0WXBzNzVUUlhFQ3NoK3pvNTV4bElrb1czS1pQ?=
 =?utf-8?B?NFIzb1ZBeXhPRElYbnVGUEZ4ZXJvRmF0Q25BM3ZHMTVIY3Y0WGJYeVJwc0th?=
 =?utf-8?B?WlUzSnlaZ1B1UkZRemNuZFlkd3RSSnQ5WDg2YzdDSjhrbytqaDZLTEVHQTYw?=
 =?utf-8?B?Y2FpR2hnTWJaMlpxT3JXWU1lTWE4ZDk3bWIxRXVQS3V4SDh5Vld1SnlrTVp3?=
 =?utf-8?B?aTcxMG1QM3grMjdCQkcyM00vVGpjMXgzTFJvTVJZNWN4QlpSSUdaQVh3czlF?=
 =?utf-8?B?QVZEWitGQnJsa3ZPbk5TQ05zbmdmSkQyd05OUUxyNW1tbk5VOTFiNzB4T1Fm?=
 =?utf-8?B?MUJHQUU1czU2MEdVeGZ6WjlQMFpUY3EvaXlPUG1vRFlDcWFIdDI4ZHE5ZFBI?=
 =?utf-8?B?bHFEL1pGWDRwdzA2MVg4Vk51bHpzVmNrZEZUL2d5K3pYRkp3K1ozTGVqOTJs?=
 =?utf-8?B?NmhGRkUrd05TTHJNalJmYWdkdkJZVVBJTjN3VnJVZU40Q3JsUW94Vk16N015?=
 =?utf-8?B?ekNNcXM0cStaQkcvQVVtdFRBS211bnhSRGI0TlJ3THJXNXd1TVFCQ2lEekNE?=
 =?utf-8?B?TmJWR05kbnROdXJUUitZLzBaZGoxdHFVTG1GcDNIN3d5Ukg1eHhRbi9JYXY4?=
 =?utf-8?B?ZE5ZWEdOU0tESFkrT3A5U1ljY1ZMU25iM2c5cktma0ozbnl1NXYvQmUwNWds?=
 =?utf-8?B?RlRUOWJzS2hIZjZTUjd2OUczSXFHSXp6anNCQUhQeVl3ajZJNGpnbTNYRUNP?=
 =?utf-8?B?aXRpdjNtR1pWdXVYbkR3cUxmRWttVGRGem9DbHhhbTRPYzE5c21wRFozb2ph?=
 =?utf-8?B?Ry9WVTlRU0JRV3AvZFVOcnNoSWdHbzYzUHNyZmw4Kzl1TFFDNFFIOFVCbWJt?=
 =?utf-8?B?Q0ZlZGx0YnBpR3VSckFXaGQzTEZ6MkdqL0U1d3VyOXFWb1Q4TFJDc3lGUmFy?=
 =?utf-8?B?N1grYnM1Y3FGbFk0ZGo3d1dmTDl5VnpMQ0lOS2s3TE82VWthUzlHLzErc1do?=
 =?utf-8?B?Q1ZBV1RmWStFMTBDQ2FEdGxTZ3RzeksyR0lrOHQwZ2h6NnplZzdNaGxOK1Ba?=
 =?utf-8?B?YjNpdnFOUjVWTDFVcjlrbjlHT3U1alIrS2szSXRZQ055VjUycVpEeThBdWMx?=
 =?utf-8?B?WlJPNnROck96dTdPMzhHczV5N3B5R3BqSUdjbzR4M2RHNjhYdEVWTllWekZ2?=
 =?utf-8?B?NjBwTWE4NHV3WEVEa1k4MC95cUlhTkkwSEh4Qk5CanpMa0VSODNCRFRxa2lX?=
 =?utf-8?B?RlpTMHJBNVZGK2J2YXQweHhPc00rMmxKTXJLVm1iZzdvSzJLVWkyV3VpZlVC?=
 =?utf-8?Q?1gT9I2EBwrTF66yWX8ebgmpnETecLk+2iZJwGJ4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUJjVXJTT082dlhEdDRlcWgveFlNWUprQWYxcnlPTFBXOFFuZmtqSVZuQmpW?=
 =?utf-8?B?VVNHTHFmaXNRaFhFeDY3Q29OYUh5RWNyR3BraUxqU2h5RzZKd1NFVGdNbmFK?=
 =?utf-8?B?MktIcmErYzJadkZTNERoVElDaUttR1EwWHJWSHRpY2hwSnpOaGRKaWZ3UFR6?=
 =?utf-8?B?Qlo3Nm0rVkUybjZUV0FORnBUbWVtNHBPN1FDRDZwa1BQZDlUSFc0dG1sZ1hh?=
 =?utf-8?B?TUxWd1UxTHlLSGhOUTFLSnZGV3RFL1pNMlpaWU1taDlnQmgwcU5nRDZNZTdj?=
 =?utf-8?B?eHY0SUx3dCtLUU5IRndGVUR0ajdJN201Y0l6SWJyeDlXbm0vSkxZS092WUI2?=
 =?utf-8?B?UDBxQzhrMG0ydmViQkVURTh1M3kxL25RRGUyNGpLeFFVem02cWY3Wlhxc2F4?=
 =?utf-8?B?ZTJVaWtMeElzZ3FnS01IeTVxMFBiUWJmelN5WHNaQzBXVHZweTJUTHU0T3BX?=
 =?utf-8?B?aXFaNnIrcWhTWkJUb213MzZGUUxURUdFQmVpUmJLc2tYdG0zVndGT3grNjlI?=
 =?utf-8?B?ZXZUaEk2dUdpSGtraFM2U05NRmVtaXZZdjhYY3RnYVhzNGpwaVVvSEVleXBG?=
 =?utf-8?B?U2hvaHcwUmJhaXBPSlJnMDI2YVl3YUNBeWNSNjNvc2d6MXg3YU5ZL3pZL1JG?=
 =?utf-8?B?OFZQQTdrNCt0RFRWTUNxdGJOL3RGNkFnTGZhWTRzZEx1NkZCS000S1hhYXc1?=
 =?utf-8?B?ZVhhWTJGYTk4YWFLSUJaZWEwRnIvSDBWWU9BOGtCOXErTnBDaEgwWFpBSXdY?=
 =?utf-8?B?d01BZjJJclQxSm5qZWdyS2hocmQ0Ni9rTnp1RkIzZmFsZVF2M1ZCdnFrT3N1?=
 =?utf-8?B?dlZPRWFqVjU3SVZMc01leG1TQUlwa0dHNUFkazJHRnk3YUlpTG9QTWJJa1pn?=
 =?utf-8?B?eXhFQVBWZzZuQndPTTN4N0dWWW1BKzFxUjZTNHdRUDZpT2hMWjRIK2VpZHc0?=
 =?utf-8?B?Z2g1UkZVd2l4TDNyYklRTzZpYkJ3cm54dVRxTFJXdXhCYlRCSGtaLzBQbGZD?=
 =?utf-8?B?U2ROVEZOdDFrVmxROHl3YVY4NmRKbmQzVnpIbE9HSWdLcENsYUFiNFpqQTFi?=
 =?utf-8?B?a1pEVEZlQXhCbElZbnE0R1A4QnRaUVR2QmJVSTBubmswUGVoV1ppRUptTmNu?=
 =?utf-8?B?bVVsMTZ1RXhDUys3NEpKSUpXYkhmdjNkVjM2ekQxanJjSmVrM0dUQnF3dDVk?=
 =?utf-8?B?ZmtnRlVKNzJkUFJOaVRpNzVvaUNwTVlLNUNhRkxRWGZKU0NtYzNmWlozZXM2?=
 =?utf-8?B?UFJJRFAwVkVUc0dVaVNMd2hEZ0hRL0tnS2wrSVRNbXd3ZVVRQXV1Q1JiRFFQ?=
 =?utf-8?B?bXVyd0NyT3l5QXVRc0dwZ2pWRnlrV0JZMDBRcWZUc2xvOGVMSXQvSWZLd3dD?=
 =?utf-8?B?azJncS8xcUhobmJEekFMNHUzZ1JPSE5FVlRaSHhQUHRpUVhWREIyYWJqeWx4?=
 =?utf-8?B?U2srZnpad3orOXlNUm1oaFBaaFpRaysybFRFNkwycE1BTjlwSkd3S3ppL1l2?=
 =?utf-8?B?MjJsOVJMaG5aaG8vZzVZdFU1WkMwUThpTFRlMENPcWtTYmZWemk1NGw1cmoz?=
 =?utf-8?B?ZHNUamdxSFIwSTVFVFh3WU13TVU2dUl6UzRvbHBIbEVua3NKSFVrNVJzR0M2?=
 =?utf-8?B?bGx5bG1qakFQZ0t0NlY0VGdEZ0FQZWt2UEE2dnNDZ2JMSGVlZ004LytMdUpr?=
 =?utf-8?B?NUNLeW0yd01ESXI0cWZBVmhOaGQzNUFNamIyQi9GNFJndHFvMDhvdmtyVzk4?=
 =?utf-8?B?RmdkQi9NUGFWVjVYcUczaForc0sxckxhcDd0YXpGNng0WlhCc1JEVVdpb2lo?=
 =?utf-8?B?a3owR0VBQktFMDM1elBJMDBCc2dDQkkvQVJ2YTN1N2VxMU5HcE9FTzJ6OVg0?=
 =?utf-8?B?MU95WFNRV3J3d2YzR3VUQWtOU0V0b3JYeFpISmlLYmZvZ040enVtNFRzSUM4?=
 =?utf-8?B?bFdlUExmOVlQU1pnaytGT1U4M283S1NYbGJPREVMV0F5ZHdnUlZjOU45WGZS?=
 =?utf-8?B?UHp4MG5TazNaTEt6Mzd0RUVXQUNRemNGNDhZWWZPL0hzR3pFM0tEVm4wRVdt?=
 =?utf-8?B?QzJTZXZnNktHUk9qMzNWMXBOZ0p4cExFWXZhNmg5ZitFVkVaU0tGazlZVjFO?=
 =?utf-8?B?SGFyMDhyN0ZaVkd0QkdKaGVKMlpGcURjSU13MDVoVW1oeXhETUQ1UEVmeXI3?=
 =?utf-8?B?QVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: h89nNBWX9XZiUy4PMlT3B0PdCvv//EZIcrfYZChHCUrdCxhqo/Im2vwygkXayusJRpTMsXNoPAoOaXMcXzBlXNboLeZWa1tA/T4d7e6UoSPJuXqV8u2F98qNpMAMXMyLTGvW4cRJBl/9wiJnpDF7R6RjQODBSBPKz6eeD/aewKc6Qigyy38IvQd0ZC9MkK/nolavpYsBvqlFMp1sN1z4YaXlx2q8n12Y+mTnTer/+n/FkV2yglHpZHu3mle58ryLVFwuTus8PJXrp7TcjxaVwDFo564Phl+yJJi7B41bPrHtKdE7OmEqK6AnLBbqpvydqRhzcrCpKBw73CV+D8D323wbdnROR7pMnMBYPlm2XwVp8xBhLuQ4e6NlWOuRp5QbOHzjyQpOSdMIqlEWVu+eg6sa3R6KD/ggAe0RZNvLNVo48utvuzHt9LljPTYTGOCBFQ8L6XMObPqBcm6qvuJDksVOqMmrMI2UQ8f0gB0uvcWG1gI0AP3oWn7FpGvZ6p17w9iVGnaDbLC42GBjEdutnnl4/6/HvGRe5LeSBFuj4bHt/jooWsCotQsHhBy7UDdR/94c73kGzjthEfyn/MukHrC+TH/LhUzgfhmJUv7pViY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0901af4-69c8-4bc5-4e62-08dd04daa1d8
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 18:32:02.3015 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nFg3qs9uQFHxX6LMi5o7919Navh2B89rGRA0La2ryXi3ngPz4t7Kobh3nAG3ui8yzXzxbBaNDfFRuWdQf3igOLISvU40rBDPHh7cG/RpwJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6640
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411140145
X-Proofpoint-GUID: RypEcHl7JIz0KneCCCDPh0NNAcrUyTVv
X-Proofpoint-ORIG-GUID: RypEcHl7JIz0KneCCCDPh0NNAcrUyTVv
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 11/13/2024 5:53 PM, Peter Xu wrote:
> On Fri, Nov 01, 2024 at 06:47:52AM -0700, Steve Sistare wrote:
>> +void qtest_connect_deferred(QTestState *s)
>> +{
>> +    g_autofree gchar *socket_path = NULL;
>> +    g_autofree gchar *qmp_socket_path = NULL;
>> +
>> +    socket_path = g_strdup_printf("%s/qtest-%d.sock",
>> +                                  g_get_tmp_dir(), getpid());
>> +    qmp_socket_path = g_strdup_printf("%s/qtest-%d.qmp",
>> +                                      g_get_tmp_dir(), getpid());
>> +
>> +    s->fd = socket_accept(s->sock);
>> +    if (s->fd >= 0) {
>> +        s->qmp_fd = socket_accept(s->qmpsock);
>> +    }
>> +    unlink(socket_path);
>> +    unlink(qmp_socket_path);
> 
> Why need to unlink again here if both sock/qmpsock are cached?  I assume we
> could remove these lines together with above g_strdup_printf()s.
> 
> Otherwise two paths are leaked anyway (and we may also want to have some
> macros to represent the paths used in two places).

The original code in qtest_init_internal unlinked before creating the socket, as
a precaution, and after accepting. I assume the latter for cleanliness.  I
carried that forward.

I'll define a helper function to eliminate the format string duplication, and
I'll fix the pre-existing leak.

static char *qtest_socket_path(const char *suffix)
{
     return g_strdup_printf("%s/qtest-%d.%s", g_get_tmp_dir(), getpid(), suffix)
}

qtest_init_internal()
     g_autofree gchar *socket_path = qtest_socket_path("sock");
     g_autofree gchar *qmp_socket_path = qtest_socket_path("qmp");

> Maybe we could also clear sock/qmpsock too after use, then check at the
> entrance to skip qtest_connect_deferred() if already connected.

Will do.

- Steve

>> +    g_assert(s->fd >= 0 && s->qmp_fd >= 0);
>>       /* ask endianness of the target */
>> -
>>       s->big_endian = qtest_query_target_endianness(s);
>> -
>> -   return s;
>>   }
> 


