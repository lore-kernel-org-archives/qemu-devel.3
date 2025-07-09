Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35687C83F0A
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 15:18:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZWYw-0007Sq-MQ; Wed, 09 Jul 2025 11:18:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uZWYK-0006Fy-DA
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 11:17:58 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uZWYE-0000LY-2P
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 11:17:40 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569DZD4i029100;
 Wed, 9 Jul 2025 15:17:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=go71aybeQx2u88h/Oc6VkyCaXwckCw89osP67TlYslw=; b=
 CEQqdt+QVjBqPSz/zSf5E4wrqh3fepVCp3nP5G5PVSNU1Y6XLlj6r4dxa0w+ePC2
 gOP6ILkgFvnCTbE7Te6GHBOFyG5SWD4ggjsa0LBhtY2vs9ijFAf71iJ6jintasDU
 ddzgeSYguu6g7m/y4XOeLSLDtMf/WarjT24pIwGy26toYMuVqyAxP01xeus3AlLG
 UPc7bIqpxAsvnRQfwpuypy8WEuK26UD/Xi68D4HZ0/TCSY1/XDyuc1/TYrd2YC3w
 xNZaZiVB7qgJRszSN6g+FukNI0w4afjUp7q0tJeSBFqMg8iChFpCY0FmuWKWPOT/
 J66LHOaw1YrBlNMr3L1iFw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ss5wr9f7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 09 Jul 2025 15:17:33 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 569ENjvi027093; Wed, 9 Jul 2025 15:17:32 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 47ptgb3jc7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 09 Jul 2025 15:17:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UsklBagsEHCBG59PxtXeY62uD9e0Sc0JOWf2MVCqt2NMbQiCncbhm15UjKD9XMVEX3t3+6ClLtPzXk1hutpxEMZT35r7Ok9CCJ08Ne2ssgVUUiNpd4sDrQ/GbFaBpY6pOzUVFWGrw1Tu/5KeCsx9CsvobTCzznNrLwzRKzsOKpuTJl7knvY+nSDp6tC8SsTsBI5Dr2nq64qzUxeo1dLquQ6sP2tC1GAV/18/f0DE3Br2CCQ63W/u5yHHqMG5HkYl6WrmV8UbpOEAQxipACbGn17yvkTpWfapJf9yr2r9VbiBmIzKJuqng0v48N2jX4SWZwO3Dhgue799ncr5pptHeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=go71aybeQx2u88h/Oc6VkyCaXwckCw89osP67TlYslw=;
 b=p3n/TA6jSr33jEE8z4SG+ug6TR5BcbpBk+aI8Whuc0tGMzF2rwmPIoYozZmyewbwFf0mMaG4DSYx/BC5ohdRRGLcaSZlA0PTfGaUhYUezIC8Oz/RceRkBBUiicefrLOPuMqSnuldqPwrr3ozsTzk4703riqiU+ZsOpa80FkGf/oGfYFCLp/w82D3UPyPkxl2XcjJWEZsen6EGRhI8SRqdC+iMC7N7y+TKy9q5rfDN42rdDuucA5HMeIE+y7xWbXcEJfaBy99D7b3D+LbeYyZYNNsVIEz7334+gUjbUnks8/SnnjPFdF8GtWQSMvyMTRTajz2r54fbYnGQN/exa/DzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=go71aybeQx2u88h/Oc6VkyCaXwckCw89osP67TlYslw=;
 b=WXXyO8kyAuneGYrzDrvMHZiNWTvXSule1mYlpnXib7Da2eNeMGRNHIZeiZv0Ko4mkqRaJTN85VpAh/9luEyaW8XiuFNgZKhXDOQXSg5D+asjTzuh9JkmkL6I/BeneawTJ4D94xibAFNjUO9Tdcuy7Gxenrun8RPJ5wXKXW+PDsM=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DS0PR10MB7068.namprd10.prod.outlook.com (2603:10b6:8:144::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Wed, 9 Jul
 2025 15:17:29 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8901.028; Wed, 9 Jul 2025
 15:17:29 +0000
Message-ID: <337e2790-195c-4852-8904-d421601f9011@oracle.com>
Date: Wed, 9 Jul 2025 11:17:30 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 3/3] tests/qtest/qom-test: unit test for qom-list-getv
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
References: <1751995472-211897-1-git-send-email-steven.sistare@oracle.com>
 <1751995472-211897-4-git-send-email-steven.sistare@oracle.com>
 <bdb92ceb-59d3-4e82-83f7-d4bde9b96583@linaro.org>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <bdb92ceb-59d3-4e82-83f7-d4bde9b96583@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR01CA0066.prod.exchangelabs.com (2603:10b6:a03:94::43)
 To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DS0PR10MB7068:EE_
X-MS-Office365-Filtering-Correlation-Id: 4742ebdd-e3be-4b1c-d8fb-08ddbefbb854
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OVZGV2NYUk1mSmMxczJFMnVqZVZxUFJYY0RXTEI4SVcxSTJTcXloSnJjQll4?=
 =?utf-8?B?c2sydGZPdll4UkNuQzM1dTc3bkJXakhVcTNUWXlyZjA2a2FNYzd1S0RmMkI4?=
 =?utf-8?B?R0txbE5oWkNjZUcxdCtBNmNjMnZ1SENHZkhNUzh6ZEdhd2dSZ0dJdXZhQUZa?=
 =?utf-8?B?VXBrR254bXhDaTB3SG9kOFRSeXA4SXBsQUNIOCsyZ2ZNcWJqaC9vZnM3UFFh?=
 =?utf-8?B?ZU1LM01NUWpoY0dhYlljc0VJZ0R3WEpMNmxTVkpPLzJBbUdkdjBVb3JYc1ox?=
 =?utf-8?B?Y0VaZGJGbHp2aElKZE5tdVFZQi9VSWx0cW1ocUdybEQ2bUpTMVAzNDlDOEhm?=
 =?utf-8?B?Ty92KzFvWkxjaG1XR2dtM01XbzR1bldxSGxKZkZsc2dUaHdyRjhoQmdDaHla?=
 =?utf-8?B?Z203dzRxTjVDYjZPc09EaXVHczJLejNOWDFiY1JoL2VGVlNncWhwR21jRmMw?=
 =?utf-8?B?VDFlZmxGMWJtRmlTSzVmbllNMG1IbkFLZzBnc29pUjFncURSOVkrRENaOVhU?=
 =?utf-8?B?cGVtSFduOXVzMjM0OFpyR0U3N3NoVUdUNDk2TjAyOVUxbG1tZncvcTFpeVBZ?=
 =?utf-8?B?aU84bE13UWk0QVFmMkRIL2V5REFCR0kvOUFXYUtLRnBRb0tGNExWZ2JaR1Bx?=
 =?utf-8?B?REhVVmNsdU1vRzNrNWNxV0sxaEV6NUZiVE4zWjNvcHJWTDBRbTI3Z05VZDRy?=
 =?utf-8?B?cmtadEU5aEdmeWtYcVdqM1Q3ajB6WVI2c2ViMHVpek9LQTVVZ2dUS1d0bVZp?=
 =?utf-8?B?ckVPZHpqb3dKNnVVSXdCMURGY2pJTXh0b1puaXFOVkhTUElBZzlqbWx1Q09Z?=
 =?utf-8?B?SnZwNHFtNmFnYlltSnU4ajJCb0srMGNVT0hxT2FvaFNTYStOeWw4NnB6TThM?=
 =?utf-8?B?WlFob1YyZlFjQzdTUGlSYUZZNzVYZmc1ekdHNklvcWpQRE9WWWtnUVZMeXhM?=
 =?utf-8?B?VEZBQi9uOUJrcWFlaHFMSGxRNzlRdXNmZ2Y4cUp6K1JPNExEWm5naWNRVG1p?=
 =?utf-8?B?K0MyNlpZMWt6YVloaWdjNDRpUWpzYVF4MmtVTC9OYUpJWUh4b21WeFJURngy?=
 =?utf-8?B?TDU4UkJxVGh2NGt4S1oyaVNzSFFLckVjaUlvaFVSVWJ0NUc5RXVrZUlnRzdX?=
 =?utf-8?B?aGo1cldnZjN5NGlmV1JPaWpObUdNWk1TQm5pQVpURU0rTWVQWm8xL2tld00z?=
 =?utf-8?B?YmJIeXhGUDRrVVBYRFE3ejEwNHllZmNTNW5SdEFHZWsxOEhJN1RVeUdGT3I5?=
 =?utf-8?B?clo2c3ZFakFERmk1SXNTUGs0ME80T0MzWmhUdnNnUWtMQVRsZGZ1TFRNMTY2?=
 =?utf-8?B?QVZQazFydmVHNGVrd2syb1Z3RnF5V1ZjVmxpL2lXYk8yZkIzeUl6SkVtUGY4?=
 =?utf-8?B?VE5qM2JiR2Y5N0xOZ3dMaW5mTkZOVjRJZDR0aWI3cENpSHNrRGZDWTQzUStv?=
 =?utf-8?B?cTRPdGVIWUVmMnRaZDgyaExnOTlnMkRpWEZvd1pzRS9jREZqS1pWME00TnRs?=
 =?utf-8?B?N3FFNzZWOWFadkpVbG4zUUdGWFVsdDk2a2lSeGdUeWlRY3ZWb1ZVdHpUeFVY?=
 =?utf-8?B?OGtPODIxZmhsc3dkcmNTVUhaZEdxd0poYlhQd05zdUJUQ1JQS1pKOXlTNkpk?=
 =?utf-8?B?OUxCK1JyRzZRbm9MN0ZIMVN4aEN0d3QvWGI1YUZWSUlYWW90eGJsbGlZSnov?=
 =?utf-8?B?QlA1cDdKVUZXUFVhUnMrTTQvWk9yMDVyem1xQ0FEUUlKclFwRGVTNjF0bk01?=
 =?utf-8?B?RlNRclVkMENCRUwvbm1BNjFydzdCQ1JHRXhEeHZFTFVweUJ5NUVtOEsxc0pQ?=
 =?utf-8?B?ZVZCRGtoMzl0M1BocFlJUzM3eHRjTm1vWHhoellqMWdHa08yL3RQWEJVYW55?=
 =?utf-8?B?eXRIWTE5cU0xRThyQm5UQmhqQ3p4b3JmNzVhN3RxMTZzUTZZQWIrSUdHK1cz?=
 =?utf-8?Q?O7DHSPC1NoA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmNjNDJVc2szN3dySlFVdmFpNXVCT0J3Z1hwcE8zMDJQMHl0Ymt5SGNwcy85?=
 =?utf-8?B?eWN5c3A1K0oveWU5bnhxZkJsTnM3N0djK0w1SkpLa2V1T2RJWUxCdHZVd2pB?=
 =?utf-8?B?U3M0d1pWZ3h2VUt5WXRlVFREZjMxK2VIekdOVFRlVEg4U21ieVB5TmtHeEtV?=
 =?utf-8?B?eElIM2tMVithbCtSMTRiVlJrSDBZYk85dVJQb1VIVFA2NEtJTDFCTEttSVRM?=
 =?utf-8?B?RlEyMGE2aDhVbTJ5dkh3aEJUT1pPNjFkMktEVzZKdjM0VkhIejJYNnQ2cTBw?=
 =?utf-8?B?cEpJYk1hdkd5Qjg0NVUxL0c3UUcxTjlYTWRVOVU1cDd0UTM3SlEybjJ3amhh?=
 =?utf-8?B?RzhCNUg4aHJkMlltTWlTT09sL1lwQWxEbVdJc2NoMkltSUFtWDBtRm9zR3NX?=
 =?utf-8?B?aHIyTjM1cHlLWld2SFpzR2RRM1RIT1Qwa3BWUy9hL0d2UUhCSE8xaVg4OEZ0?=
 =?utf-8?B?c1A2cTRFQlNpbkFBQ0NEeXI5ZEM5SFdKK3JvUlA5cFRuOUcxblJmTzEyYVRQ?=
 =?utf-8?B?cU1OdWpVa1JtZTI0N3NNUmRJYUZKZlU3TnJlUXdxdWFuUTRVd2YwckRtanJC?=
 =?utf-8?B?QWhhVnRnbWlDbTJxNEpHUkNsbkE0cURuUXRFeXBEdWhOSEFHY1RRdWdhRy9R?=
 =?utf-8?B?SWJ0VndBOFRxclVmWjhvMXhIOG9oK0oySzhPWklsUldaRzc4d2Rocng0T0pI?=
 =?utf-8?B?MkJFeHg3ZFhVcklzbzRHWVF4ZEw5bkhMMmYxNjF4ZG85bWh0c0RSQ1RFUUtC?=
 =?utf-8?B?dTJGdytNUUpUT1ltSXFjNjBEVnpaYXJDaW5nTFBlTlJuL3NndDJyMDdWK3Fh?=
 =?utf-8?B?OG9yaS9ZWWJFaWlhazhvTmM1b3VDVlp4bXB2REp0enlkdkZzYlRYQnBTalIv?=
 =?utf-8?B?RnZLcFhBbUdYem1zVisvVU1NVE5ra2VlbEd0bzNaOWNDVU5FcWFvejRHSEhW?=
 =?utf-8?B?SjV5VTNaWDFvNk00UjBML0l2MkRtRW5LK1JiUWZCbjNoUlhUK25aNlVTNFVK?=
 =?utf-8?B?VzVvbmFJVjk4UzBDYmxPSnJJQkRSd3orUUI0SWhpRUloV3RvWTdIZjczUjRO?=
 =?utf-8?B?bHhTdGhjdkVwZ2tYRnNKelR0dEU4d0IySEsvTTFBbXFkYlc2Zyt3UFJmVzV6?=
 =?utf-8?B?c0lRcm8yTEhpZWtZS2tkWm1ZUGhMT24yVURCMGRKRHJJYjVrTzZtWmtYRWhK?=
 =?utf-8?B?LzRDRVVML0RHaVphY2RQU3c2cHphSDN4aW1ETVNJWm1GUUZRWjlPNVNBNFhV?=
 =?utf-8?B?VG9UK001ZWNJWXlXbkZJYkhHQXF2RGJqQWZBQW9NODdBRGltY2NFd1JHVmtL?=
 =?utf-8?B?RHZYM3ErUndJNjhMVEJHQUdLenpOOGhzL2VQWThOb1poOFNVU3FqWUN2SE5J?=
 =?utf-8?B?ZFhlaWJXYWQzY3Rsd21EVjltb2Fjc21JaUNjcjJoQjlaY0NDRFJEUDc0bTNQ?=
 =?utf-8?B?QzdaaFlMcXNsbjdaZlo3NzJJbHNqV0g0WUp1bnM1WnhkL1hhdVc2bzJidXVG?=
 =?utf-8?B?SnR6bTFSS2QvbVUrNk5nK2wxSUxnMUtkRldpK0lqZDZYMUh4YnBhOVlrcHR2?=
 =?utf-8?B?KzJuRThYV0FwYklNU3JCbHdvRW9Id2kxYTVVcDNvbU5RWFpCZGVHQkdJYVhz?=
 =?utf-8?B?dEo5d2I1V2FTcFhFanJEN2dvUEZrRml4SGFoTUQ1clVpa2JqYWtXZFdUMVhX?=
 =?utf-8?B?ajZqYkd1YzM2YmxtUUw5Mk5MU0lua1c5UXJJRnFOYlRiK2lFNG1iWkRrSWdv?=
 =?utf-8?B?RVFrYUdBNFNDMnhQM0hReWxjYmVlanpubExibytuZEJ0ZHlvcEc1elhWSEhq?=
 =?utf-8?B?NE04ZjV2UjdIY1VsYkVKdWsyU3ZjV05NOGJkZnQ5cFZWbmpMV25iS0hOM2Rq?=
 =?utf-8?B?NExLR09JV1dPTy9TdnBLa1BCTVdMSDFLdTRxK0RkeFFSNDZUbWRjNE5qN2Ja?=
 =?utf-8?B?ZTc4WHIzYTBZYVlZS3pqRW00MGJrcUJPU1JJcU8wQUcxN0lCd05vTVFVdjdT?=
 =?utf-8?B?VWVOVzRXVjBONks5b0JjNlVGY1V5bVgyZDZzenBlRTk1TVNCVkxiOGN4UDhV?=
 =?utf-8?B?N1JMa3V3UnFOSmFwUlRmUWRYM2xuMXp6M2dJQU1lQzdObHUvakpTVUVZVWdD?=
 =?utf-8?B?UC9FYmVqV1RWR3ZOc1R5WUhXYVpjVGVtVmlRQWRUazl6ZlorVXhVY1VTcWI1?=
 =?utf-8?B?M3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GYTdf24Ay2k7SoXXraQ/ir4WyAqf+AhNPtOQhGTYxq/cinkNK1OxwN5PvaEfG5IKCLoH7iGXdc7SHiGP5EZXmu10m/Ol6WqlhjEgcxOpCCWlrhQOAXqiLKYQUgb2f+qDbDQ0Ud4WcTqScUuM5a4pyF0bdJbbXJVVrKU1UBR9xc1RAuRQksmyEWt2oBUwUBsQdpGOZT47+5J7Slh3OdeyUlEZEcBkdcr86WcB8BYA+UacgD0zfrDcE1hFjypao4p268V+6hYi2uSDvauraTqVcqpfsml+NJ7i+Ao/7/uqWcCJ0G2A7FfbbD2rtQdH4FcXv8o7AG+j07Y4UMzdIyZ6ienXWRn/ovgL+6/2yx8wU/KJ7BS65KJ+jdPN8Zc+BEoEdHqP9kUH9wlc+ie2Bqfva5uFpJZ7nFkFYc0DMpyuAuhSG1qegTH4Mg4z6wNhsT99pKnTtO3iXoJjN8HO27ta+jKA5j/93d9gKkdabw7lqRskSXuN3X3HJ/m5l+GtrhgOVfC4jlcqyBcghxhgs+VDZWY0o7Wkdg4Y3rAI8UW4AKiTbbTdjC186ZZ7gaiWQFMo7SVrzucpFWuuwVHTUrJud5xwemhVCYR8owb0x0+VeCo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4742ebdd-e3be-4b1c-d8fb-08ddbefbb854
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 15:17:29.7126 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YXTZWlWtGRFFIUiJDG9HCYlVT97VDJH4WNcojtUDAkq+eAmbPjiE0UjX8d4dlWrzxszZ3kgFfw2yRMA2ZV7BQZv+hG32sdTq6wULLTkG9B0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7068
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_03,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507090137
X-Proofpoint-GUID: BMa3cbh3FHeKJdRApNsMgvC4kjEhCA25
X-Authority-Analysis: v=2.4 cv=Z4XsHGRA c=1 sm=1 tr=0 ts=686e880d b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=KKAkSRfTAAAA:8
 a=VCykG_fZx4xERZde7AEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22 cc=ntf awl=host:12057
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDEzOCBTYWx0ZWRfX8+zxLUNNFooN
 1hhm16ssZJ32b9uF8FJqVnpY6v4ILDEqprqZAZSmhcCIBJJCW8xf7UkMmBwtmW+5OG98p1CEk3F
 ieaXUnSgUo/tLMtAB642MdJfSIa6nAV5CTZXeNPXW/7sYJL+0u3kV3cl8rjF4SeGWXd2GJQ7BF2
 eAHMdBiIe7U7/wqGVdu2kFgi+xZLbcT0zuHlldNtwIS7oVqnKe97oXtIiAdW2gxLo7CeEJpviP2
 usuglBeryXqVCyCgpFbUC+XHPiP2jfDWCdAJsiSDwHUUQCcALwfibhFvox8ngbmTInp0Jbiuo3z
 cfNq171MVSbxCBHbP50YIYnqn9c+VPzMsLvUBoccvEEkk40vuKr+j4iGStIdeOZZgUSeKyZLm9h
 DKjcLQFS8Cb7ScaA4DKOjtCwrlIp8gn2Z81EtZl8KhLyNzGJpIH8/INpzFQN5lkA+1t6OGNL
X-Proofpoint-ORIG-GUID: BMa3cbh3FHeKJdRApNsMgvC4kjEhCA25
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/8/2025 6:02 PM, Philippe Mathieu-Daudé wrote:
> Hi Steve,
> 
> On 8/7/25 19:24, Steve Sistare wrote:
>> Add a unit test for qom-list-getv.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   tests/qtest/qom-test.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 64 insertions(+)
>>
>> diff --git a/tests/qtest/qom-test.c b/tests/qtest/qom-test.c
>> index 27d70bc..4defff1 100644
>> --- a/tests/qtest/qom-test.c
>> +++ b/tests/qtest/qom-test.c
>> @@ -11,11 +11,72 @@
>>   #include "qobject/qdict.h"
>>   #include "qobject/qlist.h"
>> +#include "qobject/qstring.h"
>>   #include "qemu/cutils.h"
>>   #include "libqtest.h"
>>   static int verbosity_level;
>> +static void test_getv(QTestState *qts, QList *paths)
>> +{
>> +    QListEntry *entry, *prop_entry, *path_entry;
>> +    g_autoptr(QDict) response = NULL;
>> +    QDict *args = qdict_new();
>> +    QDict *prop;
>> +    QList *return_list;
>> +
>> +    if (verbosity_level >= 2) {
> 
> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> But I note this doesn't assert anything except if you use V=3 and
> look at the output.

I don't follow.  It unconditionally traverses the whole tree and asserts
that properties are present.  Plus, for V >= 2, it prints paths.
It is patterned after test_properties() in the same file.

- Steve

> Maybe stick it to a particular machine and check for a particular
> path and its properties?
> 
>> +        g_test_message("Obtaining properties for paths:");
>> +        QLIST_FOREACH_ENTRY(paths, path_entry) {
>> +            QString *qstr = qobject_to(QString, qlist_entry_obj(path_entry));
>> +            g_test_message("  %s", qstring_get_str(qstr));
>> +        }
>> +    }
>> +
>> +    qdict_put_obj(args, "paths", QOBJECT(qlist_copy(paths)));
>> +    response = qtest_qmp(qts, "{ 'execute': 'qom-list-getv',"
>> +                              "  'arguments': %p }", args);
>> +    g_assert(response);
>> +    g_assert(qdict_haskey(response, "return"));
>> +    return_list = qobject_to(QList, qdict_get(response, "return"));
>> +
>> +    path_entry = QTAILQ_FIRST(&paths->head);
>> +    QLIST_FOREACH_ENTRY(return_list, entry) {
>> +        QDict *obj = qobject_to(QDict, qlist_entry_obj(entry));
>> +        g_assert(qdict_haskey(obj, "properties"));
>> +        QList *properties = qobject_to(QList, qdict_get(obj, "properties"));
>> +        bool has_child = false;
>> +
>> +        QLIST_FOREACH_ENTRY(properties, prop_entry) {
>> +            prop = qobject_to(QDict, qlist_entry_obj(prop_entry));
>> +            g_assert(qdict_haskey(prop, "name"));
>> +            g_assert(qdict_haskey(prop, "type"));
>> +            has_child |= strstart(qdict_get_str(prop, "type"), "child<", NULL);
>> +        }
>> +
>> +        if (has_child) {
>> +            /* build a list of child paths */
>> +            QString *qstr = qobject_to(QString, qlist_entry_obj(path_entry));
>> +            const char *path = qstring_get_str(qstr);
>> +            g_autoptr(QList) child_paths = qlist_new();
>> +
>> +            QLIST_FOREACH_ENTRY(properties, prop_entry) {
>> +                prop = qobject_to(QDict, qlist_entry_obj(prop_entry));
>> +                if (strstart(qdict_get_str(prop, "type"), "child<", NULL)) {
>> +                    g_autofree char *child_path = g_strdup_printf(
>> +                        "%s/%s", path, qdict_get_str(prop, "name"));
>> +                    qlist_append_str(child_paths, child_path);
>> +                }
>> +            }
>> +
>> +            /* fetch props for all children with one qom-list-getv call */
>> +            test_getv(qts, child_paths);
>> +        }
>> +
>> +        path_entry = QTAILQ_NEXT(path_entry, next);
>> +    }
>> +}


