Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85302D0C61D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 15:02:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Lox-0004u1-Ho; Fri, 25 Oct 2024 11:01:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t4Lor-0004sX-Jw
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 11:01:41 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t4Lom-0005lq-CE
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 11:01:40 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PEtgPa025111;
 Fri, 25 Oct 2024 15:01:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=corp-2023-11-20; bh=PHgvCfd8RIZxKZ0H
 aq1qNetEON+Lyk42SZCTFsEvEVM=; b=eTJkwGR6mPCC0XDgDxy+yKwyslrlaeuc
 sSBFqaeMisfqc6ZLt9dPBqsSPM3k4dv/q39Oobk3z3QiqhILdHKWOxq+SlwWDy+A
 08j4ddG2T0RK9EjkwTb0jVnt9j6aqhWwAtX72w5WzQSEpRH+KGfnKm4El+z47Jdv
 ayPNa+HuFTr672arsvyUt1bGbQCwzmqVm5OcydlJGY+b/p+z4p9mM/+83Fq0exf3
 DZF4tIMWT3zMCR6UXEFPg7ROFm+aGfDeoeGz7y4tIfFdVLPzQSz4JJ3CGJLnZnad
 ZZU2GmLBayF8b6sjwRltKl5fP2W46oeIwQv0HGrolDrjEDngBKbGKA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c55v55tr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Oct 2024 15:01:33 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 49PE6MqX036795; Fri, 25 Oct 2024 15:01:32 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2047.outbound.protection.outlook.com [104.47.73.47])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 42emh5duah-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Oct 2024 15:01:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kLD3dZ7tI+SIRAgWPjBszognOSZos2VpLV/OceDecj/FCubADwQYoCisGgh1vR1cnn4jLdsFAAPS0WfRyeLtdxGadDeoZsCs5b8edctBRFjgOkySy8d1+ryn61/jyJNt0NToi3pdS9IF2N5JTT2ShAwIPXS/o6Qoz8X0ooxLL4lH/EKiXcNlINpxb8t39f/mRDPFwH0LVywax0CZbD23Xrq1u66bgbfRxFHF6T6RSxq1RXIpx/VedtQnH5O2zPd+Z0fuTTdZfM0eTsz+yNqMdtxMUiaP7NG17tg/LCctLJQhaDcSukikHJM5cgw0Ps45kCFYimx3B2NT3E1DmlNPQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PHgvCfd8RIZxKZ0Haq1qNetEON+Lyk42SZCTFsEvEVM=;
 b=wmQM2iJ8S8TE153FG9di797DsDLQnOEDxODWmeVw6AbC6KlYW1/GtsPJQYEDINl7YMhI/wkGi3qBe13+h/h5iahSAPgVRSUNTzINpkLQ0q1UGGUakJbTg5i+02zBwkhXrDIvR3Oil6g6D1JWpj2cLXZLtNNpJyotPscDfQHA0oqSDM0FcdVLbVuIWwEddnn7Msikl5FiwYfH5RnBt0XMAbCgT/awag5fD89wZT+LurMTSVbMB9+AY+gTn/4wsWYms4pKRPuooM5BvOjjRyksPOZ9CTQB7r4gJboMXaFUoSr+OKwNBTdpx/VF2rQTh8M+9PYa0xqVbHQRawILJvFObg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PHgvCfd8RIZxKZ0Haq1qNetEON+Lyk42SZCTFsEvEVM=;
 b=Phl0EG+nW6EcH4leKPAY3EJ8o4jeLChHikUVtY6kvfKaHxzCGteOjHXaGtdCmC6DV2Imqefd2KrGR+gsp35gp+iMxg6aBV9N3bZKc1ZhJ/e2GqzApjvGUkfpyak+iGPlnCtDNWj/KSdPk71Tog+HpsQaqpAR2qBRHYQSvL1YA4M=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DM4PR10MB5919.namprd10.prod.outlook.com (2603:10b6:8:aa::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.18; Fri, 25 Oct 2024 15:01:29 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 15:01:29 +0000
Message-ID: <87b1beba-4e03-45c7-b6ce-2772dcb117d1@oracle.com>
Date: Fri, 25 Oct 2024 11:01:27 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
From: Steven Sistare <steven.sistare@oracle.com>
Subject: cpr-transfer with caveats
Organization: Oracle Corporation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR05CA0063.namprd05.prod.outlook.com
 (2603:10b6:208:236::32) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DM4PR10MB5919:EE_
X-MS-Office365-Filtering-Correlation-Id: e69a0048-d687-4dec-eca7-08dcf505e80f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WUQrSFVSQUd4cUhVM1llWVQ3NDU2U1h2Qmg5QjR5a2xXb3d2UkRSbjk0bGhk?=
 =?utf-8?B?SzA5VXc1dFg1cWd3VlhlRWNjbUkwRS81QWZvN0FtUThVTXdITklERkhmQ2Vj?=
 =?utf-8?B?QkpCNll1OHlzSnQydWt5ZHBIaUVmQ2wvODZwRU1xUFVFZkdGQUhrL3IyRmh6?=
 =?utf-8?B?TXVsSmRqKzZpa0lUNlU0dzhOditCVGMxNUZndm41YlJOUlVXUUtTZEFMb3lE?=
 =?utf-8?B?eVBiK29qeFU5aHo2Z2dkVS9iKzBESlhDV010UmI3U1VoSFZRTXkzb2NhVita?=
 =?utf-8?B?bm16dlVNcFJ0a0dHNlNIbEJUbERVcU55elZGTDl0Rml1L0tNRkZxY0NJQy83?=
 =?utf-8?B?cVNlbG1RM0hhSXUrRTlRa3N1QUFqTmphZ0dtbUN3TUpIUURIdnJLc0ZXaWNr?=
 =?utf-8?B?YlNrbGdaSElmeHRrTTdrNFdRRVRYbGNVanpBVW5RS2lqUHZ4VE9Jb3ZrOERW?=
 =?utf-8?B?ZG0rWWg5bCsxOGdUYUxuVEVhK25SZlBlcGtYRDI0U0l2Uk9OWUkza3RCYnAv?=
 =?utf-8?B?S0o2L1NXTFFycGZqK0prU1pZa0NmZWVrUk1HWVF3bXlOcG4vZHRBTkF6QWdY?=
 =?utf-8?B?cXpDQWJLa2tVVXB3N05kTDNIRkNpZVRZY0kxSktKTkYzd2hhYlovR1dUNHZ3?=
 =?utf-8?B?THh2TkkzSmZ2aGJTcGlSUEs5bDRDTGpBNUlhSUNheGxXaVVOK3h1UFZmemZQ?=
 =?utf-8?B?VXMwZGQ2ZEw4VFoyNjIyQncxRFBNOUFjS2U0RUYrM1pVa3ZpaXg1VHBqRmxo?=
 =?utf-8?B?SGpkRDg3N1g4YlZJWUVYR0tDajY2czlnbjJjTkdOYS9PUnNjcmlGVlpPNHU0?=
 =?utf-8?B?SlU5TXhkaWFKUm5SRGMyNEtCS1czUUorSW1BWS9FUmNMalFwRTdBU3pBWlBw?=
 =?utf-8?B?emNUYlFRSWVlMjhtQVBRcnFHb1ZLUFF4S3dWcVB1bGpDNERZNTJZT2UzRXhX?=
 =?utf-8?B?QThnZ2FZRmFMRWdCR3JyQ09kcmJWVjFRRm5tdGUwQkp5TlZOdFhmNWVBR0VI?=
 =?utf-8?B?dExFK0paUmdmdzFIVThUcWFrZ1NhZ3VPa1NHNEdCbTE3Y1JWSGNFeElKWXZW?=
 =?utf-8?B?Nks1aGpxei80ckYwWG1mUE1GQ1ZMaGdhSlRJUmlZM2x1OVVqM0pOaGRrdC9G?=
 =?utf-8?B?RlBXNXd2ck1qNk9mMEpKMlFSbytuaGJkWVYxMFEzdUloRUJwOHFEQit6WDBm?=
 =?utf-8?B?cnd6WVVUSzREMXp3VHZxSVk5OHdYMldrcHFUSUZQYVRPUGFHdWNaSjlVS0xY?=
 =?utf-8?B?L0UzalhUVE5CdXR5WWZ2VTZqNFhzbkhUU1dNWUJpL253czNwa2lZTEZ2SFpJ?=
 =?utf-8?B?SnBSdVdZVWYyNFF1ampRMmIwdnY2dlJZQ3VDbnVTRGY0dkNmcHVpWnBqUEd3?=
 =?utf-8?B?c3A3SW85ZC8velgrNXVLRUhzNmpMSVUyTENZd0QvTVN5b0xYaHJBbFgrSlFI?=
 =?utf-8?B?N2JzczJQN3hGOXBSeDlGREk3MUZWNy9nSlpIa1REa1hubXZzWXlFazRVUkhX?=
 =?utf-8?B?Y3hKNjVmMEtzM29keGlnY3pWL0xJVVBNOGhtVW5XQk1rT1E2MlJGeW5wN09I?=
 =?utf-8?B?cjVpcjdURm1xVlpOSDlFeHR5dStITldXOW9lTW9qUTkxMUN4ZXF3S3hqR1Uw?=
 =?utf-8?B?RlpESVdHSi83aHdmMFUyRUx1NFlnTm9xWHZ2NituanVNWmJPLzJ6SzdsVFhQ?=
 =?utf-8?B?aHdrWjN4Q0VzY1htV2V2ZTJ2enpVRElPcmcrR3BZSk9EVUtrQ1h3SnJwbEtK?=
 =?utf-8?Q?UF7S+jHKoGUlWJe3Mk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVFKUzl5VGpVdzZBSzA3OWZYMEFKS0lBdFVIckZrY2IwMmZUMGpGNUJrVkwz?=
 =?utf-8?B?R01kQUdGMEs0ZEljbkYvQ2RXRkk4ZTNzN2lmYVlKZU9venVRc3JOVUpFN25S?=
 =?utf-8?B?Z0dRMzlwNTRua0czUWd6bEhWSzlmOGhqay9rZVF2a0N1T1Q1RTlaNmw1Y29L?=
 =?utf-8?B?MTZ1MFZUUnRYZFNHNkg2eDBiNmlwQS9ZMFdXMmVJM2o3MjNYUmoyWjdNcG9H?=
 =?utf-8?B?MGNLOFBGRUYxYUc1SGZ6S2FUUUVYRDRqN01HM2M1NlpZK2Y5bDZXRDd5T0NM?=
 =?utf-8?B?RTVwa1FNM09NaTlGVndERGZ6R2ZYUDNDaXdzYnhDYTVpRzhLN0RaQWt2cnQy?=
 =?utf-8?B?M2NOOWxnQnh6VGpzd29ITFlnTlZyQXN2OHlnVUE4Q3Y0RWo0ajVjZ3EyYXVS?=
 =?utf-8?B?L2xNYzZpNmNEaGxtbkRVbG1mTVRmRVpyY0VyeHVwMFZGNFJBVkdmVWlqdE9I?=
 =?utf-8?B?ckx2ck5GUzI5WWNFalBIdkNTMGJiekFjMEZ4UnBuUXRyY1RwcmRJRFhIY1B5?=
 =?utf-8?B?VVRqcDlkQUFPbnEwM0xiaUthSENKY05XUTNCQisvcEpUZEs1bkNFZVE5aTRF?=
 =?utf-8?B?SnNMWFpJM2N6SjdwYkRQN1dXTjUzakI1UVNlVWcyVFhpVWN4OFJ3Mkw1cm9Z?=
 =?utf-8?B?RjRVVmp0aUlCRGZwdUhaWlErZVBCT0RDVFlxUXJVR1lUaTVVYlMySXppakZL?=
 =?utf-8?B?VkZ2eStnZk1pOWR4QS9FWmlTMS9zYkUrOUFMSDZ3U2VnWVh2bWRueSsrSEFw?=
 =?utf-8?B?UVRXcjd0dzQzN1k1bG56ZG1nRHAybFlGMjlnUHhZeWlZUVJyNmVYZ1JNcXps?=
 =?utf-8?B?ejVqMThvQjFNVGJIays5K1I5QkF1WFVkREZNbHoxOHlNRU5BWVlkdTY5NFVr?=
 =?utf-8?B?STJuZEVUV1RQM2lPaTM0SzByNDMwSHd4SUtpeXpTenBNcTJYNnhwV1NWb1Rm?=
 =?utf-8?B?TW16QzR6b1BNZStoWHpqS0tzL3RQNGJySlh3TmtSMnJ6L3dOVG5CdFptUTls?=
 =?utf-8?B?S3IwdzBKVWg3TngvNDQrSHVaSEZ4Yks4b3Z2WHNFQjN5Y2hmcjJBS0FkYllz?=
 =?utf-8?B?TGNnZ2YzV0ZtSzRJbFdMOC9hZGNpdFVWVzhZdDk0bmZqWlpWZi9PNkNnMHhz?=
 =?utf-8?B?UWgvOVNtWVEyZndUK0RQUUtDeTlMNWZRWXhlbi9ybGxKcUU4QjY0N3dpYVFx?=
 =?utf-8?B?NmVIWVozYnR1czBZZUNNZ2RUK2h0bmZpU0JWbHBnZzNHS2dVeXR2MzB4NGpB?=
 =?utf-8?B?c21pSGQwTU8wTWRrSzRQZDVQUG5ZV01KeFlxZER5UEQyK2tGc3p3N09MdENY?=
 =?utf-8?B?aU1qbUo1SkdiV3NXSDdqcUtqazR6aFpRdkY5Yyt4cEQ1Mm43ZGUyYklVbDhm?=
 =?utf-8?B?dTlhZkxzN3Mxd0Q3OHFmT2tOdE5iMkpRRGZVeGtqODNkdnVadHJtaDR6MEx6?=
 =?utf-8?B?dkhlTXRaSkdqdy8yVnZjRzg0VjI0TG9ibDlNb3pVUVhEKzZuMVgwOFlGK25J?=
 =?utf-8?B?MEJjNE01OWh3UFFaTStVWXpURHpjeW4xRktwWW9UN1NMRk43b0p5RTd2VDBM?=
 =?utf-8?B?aE5CRFlGcUxmTDJmK3Q1M3VKSG5yWlVGVUx0QWFoRzgxNjJXaVBQM2pkaUJa?=
 =?utf-8?B?TWREa1ZmRlUvazczcW1VQ1AxbW93bzY4RFh3cXgwQ3JnV2l3M3NMNmpsdUEy?=
 =?utf-8?B?ZG9GV3JlVklEVDhTM3Y0UEtCUGM1NVRmYXk5bDlsUE9hYVYySm1zdkhMY0R0?=
 =?utf-8?B?NmlnejkxYUs2M2xxeHNxUDc1RW13RTUxcnUrUlZ6VmNRRkFydElDVFNUblhw?=
 =?utf-8?B?cFFxUzZnV1NucGdFbGcwVTRYSk9yYWwyTG0xanZBNVAwZFJ2M2JJNDMxMkNX?=
 =?utf-8?B?MVlNaVFoS1VaUnFxMlZxK1RBeE1qM1VWSlJaODhRYzl2ZmhTZVd3dDhmNDU3?=
 =?utf-8?B?L0pzZnVRc1RCaG9IM29Dd3Y3N21PSXNwd1hRcWVvdytvMUU0N1paeWpYdmxD?=
 =?utf-8?B?YWtLMEI0Tmp0Nll1WEtRdWFQNG9jSzl5KzNxbTNyVDExSHd6bVJOcTRYRHhp?=
 =?utf-8?B?RGZxS2I4aHlMMXVDakZUbWNmVGQybG9mUXVCWENYZDVwMjl2aUxZblhvd1JG?=
 =?utf-8?B?amdzT3l0cGZzLzJOK3F6YjZlQjFvUU5Wc3NEVmpDR1I1ekE5d21KRE44eVlF?=
 =?utf-8?B?bWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7v7SLfSCBXiAMd15bgRmKSjEZnipthjRHHrLh21pydYK0pEn0gHle+vokUtQcaya5YSyh8Dk41x48rK77lZ4HizyTXkpdESbRanC4uRai9HvxtgFvNiMmFocycretyC9lhZ/Tl8+/anbgyemCgAtSn2Hw+RDuESjDzgCBghfFcDQhF+qXyARqlHHUeMKeFvjFydfdCkedfoZU2UPt8Oq6YkRT8FMf7VqT7V3gUuTPw+0SVzbKHlH//9q1RrIP69PBrSKLYv0yPUi5zwY+H6A44jrSfYxGXY+c+E66uXios/GVny81YFPS4QX5bPKhP5C22+9TIw/4dzRZAGt4FDsQ34Kavve4e4Zpo7XZkH3llBgrIKlwJ1C4PSLGlD22uhB1jIDjsTzMA0+EUOMGzWT4ymYTS45CPpt66BVgVfXVxQFRMjAZR/uGya1aPS3UaoLPvHI/VgJRMojsPQCztOPfhhVZm24TyQ0HB9lXdpi6OutQf8cUd7QSCIVaZkSnOWjt/6FpIn7JOzsPfbP7+hmyjDopeqZ3iiGAWdXc8VqHxZMQJsuaDIKY79hn+bxKGgRUuhYG6DSg5+J3wCnP3Si68yLpM7+GoeuQyE3xhaGclY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e69a0048-d687-4dec-eca7-08dcf505e80f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 15:01:29.7919 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PZDRfAlT7Lv0I0MYDVfVLlfTCIUTAK55N+/nOIEhUHcaEgfQv1V6vc1y42291sxPX7Sn06ngOSqPYYjX90WxcjwDHIUa9srurd/wws06Z2A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5919
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_13,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410250116
X-Proofpoint-GUID: FwZiBFh0-6kd81ld82QBN6dKYMaPITxE
X-Proofpoint-ORIG-GUID: FwZiBFh0-6kd81ld82QBN6dKYMaPITxE
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

Hi Peter, are you OK if we proceed with cpr-transfer as is, without the
precreate phase?  Here are the problems that motivated it:

* migration test wants to enable migration events on the dest.
   fix: enable on dest qemu using -global.  only for the test.

* migration test needs to fetch the dynamically assigned migration
     listen port number
   Fix: require unix domain socket for cpr-transfer, or a fixed port
   number. Document it.

* migration test hangs connecting to the qtest socket.
   fix: in the qtest code, defer connection.

Document that one cannot set migration caps or params on the dest
for cpr-transfer.

Document that for -incoming defer, mgmt must send the migrate command
to the src first (so dest reads cpr state and progresses to start the
monitor), then send the hotplug monitor commands to the dest.

Daniel, are you OK with that last bit?

- Steve

