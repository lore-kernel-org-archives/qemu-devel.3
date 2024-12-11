Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C02CE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 19:00:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLRvz-0000TX-FL; Wed, 11 Dec 2024 13:59:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tLRvw-0000TA-DG
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 13:59:40 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tLRvt-00037q-Jx
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 13:59:40 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBEMwXv024363;
 Wed, 11 Dec 2024 18:58:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=MWd7HFYd4AexFTr1Vp4ojmNJTCV/UL7PSlV+XnmIpM0=; b=
 NLDibeQXCLCAKP7btvY0HO8ULIlunHxK78coxhDW2qpi9HiX41hcuCpmSOEb8qk8
 MDjJz+0mS1sT60BYxiO5/1A6ZFwHSrYO6ds+spH6Esc7jaHz0a1cxn6KK06C4D0D
 RSRF2UdA7qcH2rFWTNwTFIcj7PgfBZgg3gX6ndXWpVf/78KbizGDkV57yYseuarE
 Cdo9eWl1yvQR48cFk8ocTuWh5xPry/Sq9bRqJ2T/FXCbUMhlr+JMmQ31RsLD0L6f
 gMfLeVP2PPS281/27wFaUHAIJGPu/7wdI65Aq3Ie89x3QgmMcM+65nGqLT0a0r0M
 GsSJS6J27d3j84fKYTOYiw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cd9asgsq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Dec 2024 18:58:47 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4BBIbwB2020720; Wed, 11 Dec 2024 18:58:46 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 43ccta3t4x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Dec 2024 18:58:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kbs6Np8WlXGiv8pUF4SgaszdU+UIBqiUfA+GOkkXXYM02mI4Z4yUC4CuZlfmtord/QhS0g1NFPxPIfK9p2rV4HFgIF3kb6O1cgbicCPTu/MjWB++2Zu4Ts/nVoS1GaP9RKr1PsoOXxSAfGzgyX5modR2pDjZaLw9fokA/I6p2FElxTwtPodaCRfqdAHB69aHfD7t3qMLoCRX3QBu26jqO5JlLm6fPQnQOdx+ibjyc5D/mLDQCA448oq2/UAtGLDWbSRQNWOmFZllcpWE3in5/I1woUrQW7GgybeGLEYnjkqNMB824/1/TCE00ZmFy0atEfjC4S+e9ecxeSlABCsrPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MWd7HFYd4AexFTr1Vp4ojmNJTCV/UL7PSlV+XnmIpM0=;
 b=JIgxEcYbLlfp60BYEIZBszdj9RIFkCMinkneh8IdQ0CK/MmdaGO7rCgoPYADrIBQIoyg/dVmTF/EzvjhZ/r1ZEZ+Kt/9cJ6p6sDpnBpeZV67I2D8Ti887sjidYmk5S2OvDKJiYNTflZXh2rjjPr0eLdQGMIeSMkMdOJSYMv5/JkSU15SwaKjIBn4VVMWO+1U1mBByUWmKwgHfnXOt3pAoP5BcRjGPFHApemoEoLOyr2EehtfTgpHuKL9SaP16f/q3xUHi8MGhSy9FxExr+rMq8VwnfdFhPbhcdKQjWe3LmnEehixvxWBYrfiisJ3ZqPlSignE0dazJjzO5ia7uyb6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MWd7HFYd4AexFTr1Vp4ojmNJTCV/UL7PSlV+XnmIpM0=;
 b=LJTWDFuIcixHXX97clWmyta0cwLFzvbLBiC54m2BjZntx6BiaFcxvKj8VDcoJH59IaqlafSH9ICsR4zOwUfqdeHhoMGcyv6KTNbRH3NGJQ2UAg2uHz+4Oya3vYV/WnR1fwH824bi4zme/7fyVYRFgPdkhNrAVBdt/T+ir3OBoz4=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by MW5PR10MB5807.namprd10.prod.outlook.com (2603:10b6:303:19a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.14; Wed, 11 Dec
 2024 18:58:42 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8230.016; Wed, 11 Dec 2024
 18:58:42 +0000
Message-ID: <57f43060-f9e6-4a74-9b79-feb9b5ae6535@oracle.com>
Date: Wed, 11 Dec 2024 13:58:36 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 09/19] migration: incoming channel
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
 <1733145611-62315-10-git-send-email-steven.sistare@oracle.com>
 <87ser2cfw6.fsf@pond.sub.org>
 <a7eaff5d-0030-445c-a31c-ce645666ecf3@oracle.com>
 <87seqxf42e.fsf@pond.sub.org>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <87seqxf42e.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0321.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::20) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|MW5PR10MB5807:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e14ffde-570a-42ca-915b-08dd1a15d4b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YmN5WUcwdWpHNk5NMERTUVpETndReHdFcmZ3QU9XRXhjNUgvaVpIdFJPSTZ1?=
 =?utf-8?B?RE5Ic2MzdFJsY0tBekVJUDRxQ0VCU2VmMFJ5K3RaT1NFMWx3QkxZek9xS29j?=
 =?utf-8?B?Yzg3N3dHakdGTloyNXlUL3dtbHVmWEZjZTA0ZFBEOXYwbE1nUVE4Q2V5R2dn?=
 =?utf-8?B?aHp3b25kaytpNkVka3lnUVZDMVdVUXFqQUQxb1JsYzMxdHFKc1lOY1NtUFIv?=
 =?utf-8?B?c0lKUHdoWkRXeCt1Y2FFd1dSS0VnWW1Rck9sUXQ5QldaQVdQaXRYYnV6TTVw?=
 =?utf-8?B?cytKWUlFMVZDOWNpZERRZE1rV0dpbTMyTlNYQWw1VTk0bWw4bXgxc0pvYzhV?=
 =?utf-8?B?SWxZVFhENWRxYjZEeGpST0FJaFZpVjkwQnZ6NzlJN1Bhd1J4MXN5VlVQOGxh?=
 =?utf-8?B?YjYvNW5YSWorTDYxV0ZmajRNQllhRjZCUnN3YTBPV2hFZ3dNdVlVVytrZSsz?=
 =?utf-8?B?b29tc2ZyTU1DTmhqTFg4aFBuYXMrbHYxeGp5eXNFVnVFVzZ6QnJYRnc3WmFj?=
 =?utf-8?B?enZPWThOQUxWajl4YU40dXNKWlF2ZnNUVU5uNjJ2ckhPZzJJRkQvdGlJaW9j?=
 =?utf-8?B?NS9xUWR6UXVpajROd3hlV3lPWWVCVkIvRzN1S2g2UGk1TGlNeVFHM3BGS0VK?=
 =?utf-8?B?dzZxK1JyMmZhTERORlBGSWhyeDRsZGVYQkpVODNVMWp6VW9Sakg1VTR6SWI1?=
 =?utf-8?B?M0RYem0rbkdzQVBPMnZEN1N3eHNCeFFUL3pib2tvSzEySkZkSUNlTzg0Y3FJ?=
 =?utf-8?B?d0tkc3lWM2M5VE1wT3VONTJCa2xCTWc5NUg0R0VnelBpMXpSZDRaWWpJb1ZB?=
 =?utf-8?B?dWdUVEdxa0pwQTAvQzE5QzRPUXVkelR3ckRIUTEvaUZnMklQL0Y4R1hvOGZ1?=
 =?utf-8?B?ZEFUemlMVCtQbWZmUXRyaS92d3IxdTc4VFFQRmhtR0Iya3BxSmpXVXJ6d0JX?=
 =?utf-8?B?dTRVSDJNcjduUlhUUHQ2RGd3bUhyMndTSTgweXpkN01sR2h2OFBGVjFTRDJL?=
 =?utf-8?B?NjR6VG85ZnRrVVBTSEQxUG40UzF0ZlVrNnRrYW1jWDh3eVpqT2wzaW1VU0Jx?=
 =?utf-8?B?T1VSd0lmUUtybVpPUVFOdFNsbllKWXg0SjFnTG1NQytrQ2FqYnJZd3lwL01G?=
 =?utf-8?B?TUlMTFc5UjJpQTFtOXZDOVVMYjlaMUNsVmk1SHBFTTVMb05OZHhDSDF1K0Uv?=
 =?utf-8?B?RkhmUUlsVllsYzl4ZjBxSDlvbXEvZCsrUTFaNmk3OG40Y2I4Rkp4V1lIeUVM?=
 =?utf-8?B?a09LcjJCZ2txeXRMcW5iS04rZjNvbWllVnhPWE5sdFdYbS9tQXFJV2UzMTdx?=
 =?utf-8?B?aGI2RXVzQUZSZ2FLMCtRNUhnajZtZzVaSHcrZmxjbHFJdEZxTkRzTFhycFBj?=
 =?utf-8?B?Mko1bjAvSUcvMW9NNmQ2V0pYSlpoOHBKY3dtczBubyt2TENxN1g1anBPMGg2?=
 =?utf-8?B?RTFRem15MC9JSnY0RVBvVTJPcUI2ZnpYaHpNMFVabkJFOVNqOWFQQ0toYmxu?=
 =?utf-8?B?cDRZWThkYUQ0Uk5Qd2g2YjYxNFR0NE4yZU0yVThNazkwSUlkQmhITzBDMHhz?=
 =?utf-8?B?eEZ5MFBFejVQUVczbmdiaHJld05YWFgrVUNHaXAzZmR2dXFRUDlhRmxpZnpZ?=
 =?utf-8?B?WmFGNUFHZnVxSDZObXRlRUlaNnFpQTVFenJmZFQ0RGs4eFFNbitwMk03dEUx?=
 =?utf-8?B?dElKMmwyQkorc1FzWGFoQStLV3ZxY1pBQnhJU1JoNXc2ZnBPbGhtVkRVVm5j?=
 =?utf-8?B?VStoZFhwc1VCYTBjVTBlWWdmbmdHSkJsaGRpdDdJcDhReWZucnNaR21KZDZF?=
 =?utf-8?B?QzM1ZElGUE1MS2R4YTNnQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVYyYndHZTNFbm5oR1JTREdtVnBIYXpaUVlXdEJGcEc2cXhzRlJwK2hlS3FC?=
 =?utf-8?B?Q1FkeE9KMWVjaEVJeFdxRFV2M1hoNkJyWkphSE1zMUxteUk3LytHOUlIWWVl?=
 =?utf-8?B?bkFHTWZPdGYxM0xiODVRTmFreDdKK0d6ak4yUFhIaDA5NXUrNUdrNjIyVmtP?=
 =?utf-8?B?SjRMWDdFNTRqMjlEVkRnOUFiR2x6Q2laUTlwVytLMXJZUDdycHBXMDhJeE5x?=
 =?utf-8?B?RjBLWHBkbXB0TzJ0V2pnT1ZSR21mckhWd1BsdjIwNUlld0NIdUszSVdPYkNM?=
 =?utf-8?B?eE9rd0wza09zTFRoZ0pxK2NxMm1Ed2JEeUluZU5TcFYva3VOV1pMQTRqcnBT?=
 =?utf-8?B?WkNnNEUzMFZXRDcvWWVzUUVFenZuM2QweUcweFBZS3o5NWk4OTluaHI4RXhE?=
 =?utf-8?B?UFNrUnBaaG1DVkZUckRFWUJVdmpadjVlaWJNa0hTQjZwRjhnYXZpY1BSbmRN?=
 =?utf-8?B?dzErK2ttTUk3R1hXSHFjOHJNQTdhUHlqTDh0bzIrZzRzNVNzMlU4Um4xd3U4?=
 =?utf-8?B?TG5mZWdvdm5xc2w3M0VJbitPN0dGaXpxMjlmY1oxVnFKdVdLdHBLaExKQ0V5?=
 =?utf-8?B?bnNhVldaK1FlVElvL1NwV21mZDU1eTg3aUM2ekdYY1BYMU5wNWpOTUM1WDhD?=
 =?utf-8?B?RGxFbmhyNGlWYmZ5eTU3bFM4Q1Q0RXpFbklnVkdZTHE5RlNqalVQNURuVVIw?=
 =?utf-8?B?RFIxV1hmSVI1Sk9uL2JLMmZ4VUpvSGo2eVBhYVVvK2RZSElRQ2hEa0ZKTlQ1?=
 =?utf-8?B?UllVS1NWOENXUlV3UHBwMDBVT3V1VEp6MU5qVDUwR3ozWmYwL1RScVdDNjlR?=
 =?utf-8?B?dVArMUpjUmRSV0RaVnQzQjAyY0hqRlBxejRTOXRYclZIdWZielNORUUxcVNV?=
 =?utf-8?B?KysvWnpUYzI4ZzNtWnZOUWJET1BnRXMxMUdzSm1aVjlHeVpZVDl1eW8ydlo3?=
 =?utf-8?B?YzRhUmRTd204Yy9LZWY0VHNGMUczS3BTdDlXMjJadzl4dGVjQ1ZEcnVONk8w?=
 =?utf-8?B?MG1xbk8wSHBtSjZMdG01TnpETkJSODBwZy9kQy90cGZvMVBkVGkzV29xRnhs?=
 =?utf-8?B?UWFzS0hDMkhoaCs0UUVod2E5Y1FGN2MxUS9xRmdKNWtwVnZnWTFWSlFwOW8x?=
 =?utf-8?B?U29aQjZBN01nb09RUkw2dml1MkU4cmdEVkxNRDE4bmw1WEpvaDMrUkV3NWR0?=
 =?utf-8?B?NkRSUGhrNG05N3g2ZDZZS0JBL0x4cHdOVEpRYTlOVTFWL2dVeDV4eDlaTkxo?=
 =?utf-8?B?YmlBOG5BMjJMQXZvMzRBcEROSlJkd0x5bE9LYlhvVURGMURiOWo3UmgvMUo3?=
 =?utf-8?B?TkdHM0I2djJGV2NHYytxdEF1aDIvRmpCWUFsOGs4QnFjaThJUlJFd1ZLT3pS?=
 =?utf-8?B?S2QwdnFQcDluMXllMkVnNUJoQnp2OXFjWnNRVFM1YlJUWXhaNG12b2Z4SUVE?=
 =?utf-8?B?NzdrVDE2NWI5MDZXVVdOUUJ1c1dKbE00ckJ5d2k5bHdpamREMnYxY3UvWjhM?=
 =?utf-8?B?Wms0azNDTmJxbG9PMERMeHpZdDQ3SmQ0Um1vUUh3a1FLK2tsRXorbWN5LzFt?=
 =?utf-8?B?RGdwR29nVXFraHJDdjJ6MEUvcG80RjgzRXhSYWtsc1Vrb0xRaEZ3UWJIRlVu?=
 =?utf-8?B?NzVIZFRwZDRmSUF4a3gvYjhrK0FWcWUxdDdULzF2QTlFKzVUZkZVQklEVTBJ?=
 =?utf-8?B?TlNYM0pSTkxEK1orNFNOL2dnWHZ5dkR2dGpLWVp1MXljOFkzWkVqUHpiMEtF?=
 =?utf-8?B?OENISndzdmdCTHRML1RPU3Q3aUd0UWd2VjZ2REpRSjFYRjk1aTNWTUtIdnd6?=
 =?utf-8?B?OFI5U1VwdnVydVhCVTdrODhSUlRtRndZN1hGRUtXaHFkZU9iZ3lhZ2tUS1ZH?=
 =?utf-8?B?Y251dzFLZHFreGtzZWx6YXA3MlZXUHpDK2VkUDVtQTJLb093M3FIRG5VenlR?=
 =?utf-8?B?ekJ0dDZIdXRJekdNUzhJcXQ1Qjd3Mm0wQy9Pd0drQmR3REhKcFo5STRCOVhH?=
 =?utf-8?B?VVZqSEMwUUVZTUJJd05POEhUcHZKdXZLTHFLZyt4cEtiKzRINU04UmtyK0JJ?=
 =?utf-8?B?aG5peU9WWGVuZTRyTUdmZGYrRkJ5QjBzeHZSVmh6bWdRRkNJeGpkNWpvak9V?=
 =?utf-8?B?Z3RZS2VkaHY2ZFdlZTFiY0RqNS9tR29mWXRsTmd6WmYyYU0zQ1UyWmhPcU1J?=
 =?utf-8?B?MWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0ygfjIbjcTEhv30Oa+pgE0HgCRUYfTk5+8ZdOC6Hg6/az2hHIBplZ2FfdLk+/Bd5zE9ho4kICyz2hpdzlzgwVKQRFel++x/104NmcMkYXYo9eEFpKGXYButlHkv0mgRZw1IiJPf4bFmuoqRJDT6528ELObpbBUgxsGHwSpnavA2f85A2z5euWxVQsV+FA6tRve3GuY9GzRu2BaClkkyKwdUyfl7EyXVpjVOluujcYpcYoQQbxcrQHMKdfN9hS8DPmIJW1YEMbFz1EHPD4tJ6HmuNZnWmzY1s/4bduUNMePUwekhTZlEjaBEGhDOQ00IdxJ53rOGl3KC4/3zgcQDC5kXxANeb0exRNpAcfvg+B18QfdMITOJig/zo10iETLcE8ZCHdsyvlLNX6BTAMEfzaZH49dtXoMv35dXIT4V6CEpEb34KQ5brnWbxs/aFd6SoexGvumccai7HBS0eyUxD6Nu7vTBHXobwgug7phjZ0VE3IwSAvPV3A7kyXF5byLDUzTRZbPiLKzgkHY69HEbZ7JlhNw0XyPwt3sKe1k7cjZvkzE/p4nplvrD8dDWmW2dMD4SV3N1YvuWnMQxhwTUwHKGoaMYraJq+ToKSyilGTlw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e14ffde-570a-42ca-915b-08dd1a15d4b4
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 18:58:42.4058 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZlwzY5MDh9etwG80CJat7rTebcs3LJWA/6GTwKKa7EJtMi9z/ewz3r4h6pqbYzmOfb8wU98jhlD5N4Wxm6YeUTzg3nfuhDm4BxfIPPbxWxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5807
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-11_11,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412110136
X-Proofpoint-GUID: Hwr5W3u7gEQtm_wHHvGz1RNuVWDFIeeq
X-Proofpoint-ORIG-GUID: Hwr5W3u7gEQtm_wHHvGz1RNuVWDFIeeq
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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

On 12/9/2024 7:12 AM, Markus Armbruster wrote:
> Steven Sistare <steven.sistare@oracle.com> writes:
> 
>> On 12/5/2024 10:23 AM, Markus Armbruster wrote:
>>> Steve Sistare <steven.sistare@oracle.com> writes:
>>>
>>>> Extend the -incoming option to allow an @MigrationChannel to be specified.
>>>> This allows channels other than 'main' to be described on the command
>>>> line, which will be needed for CPR.
>>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>> [...]
>>>
>>>> diff --git a/qemu-options.hx b/qemu-options.hx
>>>> index 02b9118..fab50ce 100644
>>>> --- a/qemu-options.hx
>>>> +++ b/qemu-options.hx
>>>> @@ -4937,10 +4937,17 @@ DEF("incoming", HAS_ARG, QEMU_OPTION_incoming, \
>>>>       "-incoming exec:cmdline\n" \
>>>>       "                accept incoming migration on given file descriptor\n" \
>>>>       "                or from given external command\n" \
>>>> +    "-incoming @MigrationChannel\n" \
>>>> +    "                accept incoming migration on the channel\n" \
>>>>       "-incoming defer\n" \
>>>>       "                wait for the URI to be specified via migrate_incoming\n",
>>>>       QEMU_ARCH_ALL)
>>>>   SRST
>>>> +The -incoming option specifies the migration channel for an incoming
>>>> +migration.  It may be used multiple times to specify multiple
>>>> +migration channel types.
>>>
>>> Really?  If I understand the code below correctly, the last -incoming
>>> wins, and any previous ones are silently ignored.
>>
>> See patch "cpr-channel", where the cpr channel is saved separately.
>> Last wins, per channel type.
>> I did this to preserve the current behavior of -incoming in which last wins.
> 
> Documentation needs to be clarified then.

Maybe.  Depends whether we want/need to take a stand on whether the current
behavior is an accident of the implementation, or part of the specification.
The current behavior is not documented.

>> qemu_start_incoming_migration will need modification if more types are added.
>>
>>>>                              The channel type is specified in @MigrationChannel,
>>>> +and is 'main' for all other forms of -incoming.
>>>> +
>>>>   ``-incoming tcp:[host]:port[,to=maxport][,ipv4=on|off][,ipv6=on|off]``
>>>>     \
>>>>   ``-incoming rdma:host:port[,ipv4=on|off][,ipv6=on|off]``
>>>> @@ -4960,6 +4967,16 @@ SRST
>>>>      Accept incoming migration as an output from specified external
>>>>      command.
>>>> +``-incoming @MigrationChannel``
>>>> +    Accept incoming migration on the channel.  See the QAPI documentation
>>>> +    for the syntax of the @MigrationChannel data element.  For example:
>>>> +    ::
>>>
>>> I get what you're trying to express, but there's no precedence for
>>> referring to QAPI types like @TypeName in option documentation.  But
>>> let's ignore this until after we nailed down the actual interface, on
>>> which I have questions below.
>>
>> Ack.
>>
>>>> +
>>>> +        -incoming '{"channel-type": "main",
>>>> +                    "addr": { "transport": "socket",
>>>> +                              "type": "unix",
>>>> +                              "path": "my.sock" }}'
>>>> +
>>>>   ``-incoming defer``
>>>>       Wait for the URI to be specified via migrate\_incoming. The monitor
>>>>       can be used to change settings (such as migration parameters) prior
>>>> diff --git a/system/vl.c b/system/vl.c
>>>> index 4151a79..2c24c60 100644
>>>> --- a/system/vl.c
>>>> +++ b/system/vl.c
>>>> @@ -123,6 +123,7 @@
>>>>   #include "qapi/qapi-visit-block-core.h"
>>>>   #include "qapi/qapi-visit-compat.h"
>>>>   #include "qapi/qapi-visit-machine.h"
>>>> +#include "qapi/qapi-visit-migration.h"
>>>>   #include "qapi/qapi-visit-ui.h"
>>>>   #include "qapi/qapi-commands-block-core.h"
>>>>   #include "qapi/qapi-commands-migration.h"
>>>> @@ -159,6 +160,7 @@ typedef struct DeviceOption {
>>>>   static const char *cpu_option;
>>>>   static const char *mem_path;
>>>>   static const char *incoming;
>>>> +static MigrationChannelList *incoming_channels;
>>>>   static const char *loadvm;
>>>>   static const char *accelerators;
>>>>   static bool have_custom_ram_size;
>>>> @@ -1821,6 +1823,35 @@ static void object_option_add_visitor(Visitor *v)
>>>>      QTAILQ_INSERT_TAIL(&object_opts, opt, next);
>>>> }
>>>> +static void incoming_option_parse(const char *str)
>>>> +{
>>>> +    MigrationChannel *channel;
>>>> +
>>>> +    if (str[0] == '{') {
>>>> +        QObject *obj = qobject_from_json(str, &error_fatal);
>>>> +        Visitor *v = qobject_input_visitor_new(obj);
>>>> +
>>>> +        qobject_unref(obj);
>>>> +        visit_type_MigrationChannel(v, "channel", &channel, &error_fatal);
>>>> +        visit_free(v);
>>>> +    } else if (!strcmp(str, "defer")) {
>>>> +        channel = NULL;
>>>> +    } else {
>>>> +        migrate_uri_parse(str, &channel, &error_fatal);
>>>> +    }
>>>> +
>>>> +    /* New incoming spec replaces the previous */
>>>> +
>>>> +    if (incoming_channels) {
>>>> +        qapi_free_MigrationChannelList(incoming_channels);
>>>> +    }
>>>> +    if (channel) {
>>>> +        incoming_channels = g_new0(MigrationChannelList, 1);
>>>> +        incoming_channels->value = channel;
>>>> +    }
>>>> +    incoming = str;
>>>> +}
>>>
>>> @incoming is set to @optarg.
>>>
>>> @incoming_channels is set to a MigrationChannelList of exactly one
>>> element, parsed from @incoming.  Except when @incoming is "defer", then
>>> @incoming_channels is set to null.
>>>
>>> @incoming is only ever used as a flag.  Turn it into a bool?
>>
>> The remembered incoming specifier is also used in an error message in
>> qmp_x_exit_preconfig:
>>      error_reportf_err(local_err, "-incoming %s: ", incoming);
>>
>>> Oh, wait...  see my comment on the next hunk.
>>>
>>> Option -incoming resembles QMP command migrate-incoming.  Differences:
>>>
>>> * migrate-incoming keeps legacy URI and modern argument separate: there
>>>    are two named arguments, and exactly one of them must be passed.
>>>    -incoming overloads them: if @optarg starts with '{', it's modern,
>>>    else legacy URI.
>>>
>>>    Because of that, -incoming *only* supports JSON syntax for modern, not
>>>    dotted keys.  Other JSON-capable arguments support both.
>>
>> Not sure I follow.
>> Could you give me a dotted key example for a JSON-capable argument?
>> Do we care about dotted key for incoming, given the user can specify
>> a simple legacy URI?
> 
> A quick grep for the usual parser qobject_input_visitor_new() finds
> -audiodev, -blockdev, -compat, -display, and -netdev.  Beware, the
> latter two come with backward compatibility gunk.  There's also -device
> and -object, also with backward compatibility gunk.
> 
> Simple example:
> 
>      JSON        -compat '{"deprecated-input": "reject", "deprecated-output": "hide"}
>      dotted keys -compat deprecated-input=reject,deprecated-output=hide
> 
> Slightly more interesting:
> 
>      JSON        -audiodev '{"id": "audiodev0", "driver": "wav", "in": {"voices": 4}}'
>      dotted keys -audiodev id=audiodev0,driver=wav,in.voices=4

Thank you (and for the correction to qobject_input_visitor_new_str).  I did not
grok that this visitor handles both json and dotted keys, as so far I had only
seen examples with keys but not dotted keys.   I can easily support those as well
as the legacy uri, by returning a new parameter from migrate_uri_parse indicating
that no uri is recognized (as opposed to recognized, but with some other error):

     if (!strcmp(str, "defer")) {
         channel = NULL;
     } else if (!migrate_uri_parse(str, &channel, &no_uri, &err)) {
         if (no_uri) {
             qobject_input_visitor_new_str()
             visit_type_MigrationChannel()
         } else {
             report error
         }
     }

I implemented this and tested for all formats.

>>>    How can a management application detect that -incoming supports
>>>    modern?
>>
>> How does mgmt detect when other arguments support JSON?
> 
> Easy when an option supports it from the start: -audiodev, -blockdev,
> -compat.  Awkward when we extend an existing option to support it:
> -display, -netdev, -device, -object.
> 
> As far as I can tell at a glance, libvirt
> 
> * Remains unaware of -display JSON arguments
> 
> * Assumes -netdev accepts JSON when QMP netdev-add supports backend type
>    "dgram", see commit 697e26fac66 (qemu: capabilities: Detect support
>    for JSON args for -netdev) v8.10.0
> 
> * Assumes -device accepts JSON when QMP device_add has feature
>    json-cli-hotplug, see commit 1a691fe1c84 (qemu: capabilities:
>    Re-enable JSON syntax for -device) v8.1.0
> 
> * Assumes -object accepts JSON when object-add supports object type
>    "secret", see commit f763b6e4390 (qemu: capabilities: Enable detection
>    of QEMU_CAPS_OBJECT_QAPIFIED) v7.2.0
> 
> In theory, such indirect probing can fall apart when somebody backports
> JSON syntax *without* the thing libvirt probes for.  They then get to
> adjust libvirt's detection logic, too.  Hasn't been an issue in practice
> as far as I know.
> 
>> The presence of cpr-transfer mode implies -incoming JSON support, though
>> that is indirect.
> 
> Might be good enough.

I'll keep it simple and go with that unless someone objects.

>> We could add a feature to the migrate-incoming command, like json-cli
>> for device_add.  Seems like overkill though.  'feature' is little used,
>> except for unstable and deprecated.
> 
> 'feature' is best used sparingly.  But when it's needed, using it is
> *fine*.
> 
>>>    Sure overloading -incoming this way is a good idea?
>>>
>>> * migrate-incoming takes a list of channels, currently restricted to a
>>>    single channel.  -incoming takes a channel.  If we lift the
>>>    restriction, -incoming syntax will become even messier: we'll have to
>>>    additionally overload list of channel.
>>>
>>>    Should -incoming take a list from the start, like migrate-incoming
>>>    does?
>>
>> That was my first try.  However, to support the equivalent of '-incoming deferred',
>> we need to add an 'defer' key to the channel, and when defer is true, the other
>> keys that are currently mandatory must be omitted.  The tweaks to the implementation
>> and specification seemed not worth worth it.
>>
>> If we want -incoming to also support a channel list in the future, we can simply
>> check for an initial '[' token.
> 
> Yes, but it'll then have to support single channels both as list of one
> channel object, and channel object, unlike migrate-incoming.
> 
> Syntactical differences between CLI and QMP for things that are
> semantically identical add unnecessary complexity, don't you think?

Agreed on both.  I am just pointing out that if we implement '-incoming uri|channel'
now, but in the future want to add '-incoming channel-list', then we can parse it
unambiguously and be backwards compatible.  I don't foresee ever needing the latter,
as multiple '-incoming uri|channel' arguments are logically equivalent to a list.

To reiterate, I prefer '-incoming uri|channel' because it avoids the need
to add a 'defer' property to the channel specification and implementation.

>>>> +
>>>>    static void object_option_parse(const char *str)
>>>>    {
>>>>        QemuOpts *opts;
>>>> @@ -2730,7 +2761,7 @@ void qmp_x_exit_preconfig(Error **errp)
>>>>        if (incoming) {
>>>>            Error *local_err = NULL;
>>>>            if (strcmp(incoming, "defer") != 0) {
>>>> -            qmp_migrate_incoming(incoming, false, NULL, true, true,
>>>> +            qmp_migrate_incoming(NULL, true, incoming_channels, true, true,
>>>>                                     &local_err);
>>>
>>> You move the parsing of legacy URI from within qmp_migrate_incoming()
>>> into incoming_option_parse().
>>>
>>> The alternative is not to parse it in incoming_option_parse(), but pass
>>> it to qmp_migrate_incoming() like this:
>>>
>>>                  qmp_migrate_incoming(incoming, !incoming, incoming_channels,
>>>                                       true, true, &local_err);
>>
>> Sure, I can tweak that, but I need to define an additional incoming_uri variable:
>>      qmp_migrate_incoming(incoming_uri, !!incoming_channels, incoming_channels, ...
>>
>> Only one of incoming_uri and incoming_channels can be non-NULL (checked in
>> qemu_start_incoming_migration).
>>
>> Would you prefer I continue down this path, or revert to the previous -cpr-uri
>> option?  I made this change to make the incoming interface look more like the
>> V4 outgoing interface, in which the user adds a cpr channel to the migrate command
>> channels.
> 
> I'm not sure.  Peter, what do you think?

Peter likes -incoming, so I will continue with it.

- Steve


