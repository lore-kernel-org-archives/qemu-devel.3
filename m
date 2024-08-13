Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C57EC52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 17:36:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdvQc-0002AQ-FP; Tue, 13 Aug 2024 13:35:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sdvQY-00029k-Jp
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 13:35:22 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sdvQW-0006sM-2s
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 13:35:22 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47DGBT16022175;
 Tue, 13 Aug 2024 17:35:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=AB9ftLsHb2bDnsoDqEbsllwLsmBTDRc79xAWmRvXWd0=; b=
 ofyHdDANt1a382x5w8nirhA1L3H6rReZGQrOl4nbmp2sY/l1x34H4sogTQtzTLnN
 sFex7mkMx6b0Z/QT1B2Do2A8ZpQnjRleP72hpAozUvHvn67Dbpu5+W1sv6x+Zxuz
 +fm1bTRe9IcteNbqyYsvWFM2yveXS2hV16sQcxO3dXtiVbLTPUDJxUeqz1eQ7IaE
 NM83tLNY68r8yx8ZdDL5IJdiZ5hbCI3H2Iq6TS+nxjcz/eLpa0wmJKnpauswclpe
 rgP95wory5sEoZ+ZP6ixfPOf6ZQ+JRM9cuJnWMNEM8kDYAcr9FjC5DHxM1L62MxG
 6f75df3UxTsIPqLVhTxEIQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40x0396ej7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Aug 2024 17:35:15 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 47DH5gtn003438; Tue, 13 Aug 2024 17:35:14 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 40wxn8scrv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Aug 2024 17:35:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mdRlDZ/GIBDujpEaIwvkZc60aGxOOs3n/hmu6FOT+kzXeGR3nEGwYLTvRVot314V1LuKC0YBDJRKp5fWVpgmtA/xENHjsFTjvDzJfNeH9X6rsNbmBuffR4SECHlAV5FOQJbxM3dtG2y0l8RVVYTAnXZoOFNUzxGtEH0zvaCS/Qi286IeOB1uKen6fBfhi/pogrjXNS+WeHXOjkAFR/VgfftMPSsOeD9g9KzhhBmIbbK6IZ4y4eaQwYDRh1au7wtofXMuc6zmmoQzYq2Ib5lBzqdx2SVU+UQn615cEXlf8lD9zuhqjrlveuNY8cDZE1/S9fUdy3w5dAavJvZuhrD2Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AB9ftLsHb2bDnsoDqEbsllwLsmBTDRc79xAWmRvXWd0=;
 b=X9i7tuMtGQ3nVbQfOZlmRon4ipi53FbdnfDklmpkKeBsIB/nzzRLYzDJfLAlMH1UzrD3FHWYHiJWjS5U50q9awLglpDxrue3bW2j6VEmzBbZEqWNvoLYSUJrbuy+NGDT5g86MwPSUCQe9WTp4re8xzlBTSo0J7ehQGZHlPHsdpGqma8Baw2JbsDX/befeBb825oAR1cNAiCRS6NwGB9O44J4e3CgRXMVDJMwqsTmLq+zn0XyKb9QfV4NuurjQGrKokobPX5jQG3Gcbzc1QG8vJlWVAQPUoNhObC3/aGxLBMZYVwdPNDSV9laLIDp1J9CR8Nx6tqg8P3XeNLMpuyvGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AB9ftLsHb2bDnsoDqEbsllwLsmBTDRc79xAWmRvXWd0=;
 b=OTmRH4xdb01R7hN4g1LybKqQNioCTVMAlxNvs+eYEUWQ7WlZSJ8V6567yJhNoBFKke0+um7zjO2D9G0hjP0jWiCv8jq2/Xs8PO0/5Q+0b6Ojjm2C+QbJoKiztBq/EDIsuzS86mmNoOHvTQaaWffFEmdzBWepnXAy+HNoyfS9lTI=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by BN0PR10MB4951.namprd10.prod.outlook.com (2603:10b6:408:117::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.16; Tue, 13 Aug
 2024 17:35:09 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.7875.016; Tue, 13 Aug 2024
 17:35:03 +0000
Message-ID: <7f7af1e5-f1b4-40bb-b114-45932d38b0db@oracle.com>
Date: Tue, 13 Aug 2024 13:34:42 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 01/11] machine: alloc-anon option
To: Peter Xu <peterx@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
 <1719776434-435013-2-git-send-email-steven.sistare@oracle.com>
 <20240716111955.01d1d2b9@imammedo.users.ipa.redhat.com>
 <88945053-6918-4096-ac55-0ef4b946b241@oracle.com>
 <20240729142932.6667c5b5@imammedo.users.ipa.redhat.com>
 <369f6786-1146-4d5e-a9a5-c0b0b5f45bf7@oracle.com>
 <64b8934e-2655-4224-aaf1-e125e6469f87@oracle.com> <Zrt9M00rDk3EUdNM@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Zrt9M00rDk3EUdNM@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0374.namprd03.prod.outlook.com
 (2603:10b6:408:f7::19) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|BN0PR10MB4951:EE_
X-MS-Office365-Filtering-Correlation-Id: d811813d-01f1-4cd0-21fd-08dcbbbe3a90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NTd2OFRMNVRHV2RqOFRYeTdrWlJ6UGtGU3lRbTZBRjAzbkQwem9hK1pzbkkz?=
 =?utf-8?B?OVlqUkRSUFVhME90bEFuOUhDck8xc0E0am9TbU51Z09QOWs2RFdCLzN1a0NN?=
 =?utf-8?B?TnQ1eGMxNnk5RFRuQ09wb2FWTFB1cXRLS3VocmgwbCsvUFQxWTZDYjZKWGVi?=
 =?utf-8?B?ZWtCNkZSZFJUN0NpUlpmZmd0K2htZWxRZ1dsRUxUT09tYWt0bDkyNGFMV29B?=
 =?utf-8?B?QitEVXY4RnlFR0tTOVJjOXFvUDZIbkcxMEdIQ2FnWUdYSzZML05WbHQvbk9l?=
 =?utf-8?B?VVRBeFB1dXh4YXFLYWVjWS9lL0J2T2NmbXBMNXFSSFZQbTRRQkpxdnF0UXlI?=
 =?utf-8?B?THNTMSs0TWttZEhvamQ1UFVGZ0t3MHEzZHFhN0dRQ3pVNXFvUUtTY2JtaE9j?=
 =?utf-8?B?d3B3Q0k2NlhYRzFJSDgwR0F1akY3UUx1enR6WCttTnZpa0RGUll2SThQWDRr?=
 =?utf-8?B?REhLRlFSWVNyVTlpeExCeFdRUDFhZGlGdVE1a2Z1SWd5NkpyTVFvRmxTN25R?=
 =?utf-8?B?cVF6LzlIZ21JZUpHL2d5YnlSUURZU1d2VEg3MERYZitKRU9TVmJiWldRc1Nh?=
 =?utf-8?B?dStSSmtadGZaZXFpMUQ0UTBuZkN3ZG1uZkhFTFNtRzNnNTI5dGFSeE5FcGNE?=
 =?utf-8?B?WERzc0ZGdG82dGlDb3RERFI5bDdsb2xmV1cxTm5qKzBGLzNJdmh1VFVydlJy?=
 =?utf-8?B?NXZCUTJucFBiWmVzRVp5aG1aTlhjdkZMdEpteWlNR05ETzlWZGJ0TENaeGt0?=
 =?utf-8?B?cXhpc2xhQWhXcEJuU2EwRlh6MlE5U3MxR2w5bWNtdGY3OS9MdFdRcGQ0dE45?=
 =?utf-8?B?M0t2R25NeC9MclFXK00vUldxYXVSdmRsQUR3M1U3c2R3Y29JOEM2Y3NuS01E?=
 =?utf-8?B?L2FSaEpPSldNaHprNm1oeHlRVDA0YjBBZk9pY0pnVXFoZWErRGVTNkdkUU1h?=
 =?utf-8?B?Qmh5bHYySnVVN3dlODh3OVdKWGc0Qkh0SFprR3J1bW9PWVczOW5RUSs0NkNI?=
 =?utf-8?B?dE4zUjNsWkdQcDZQeWFnRmJ0NXQwODNFZWp1NklsbnRPd0hmSUNGUzZVRysx?=
 =?utf-8?B?dzlkQkhwN3JSd0h3SmExZFdXOURBVUVlTjRnZHUrZkQ1Rms3eWtwK3lWOVhy?=
 =?utf-8?B?Yms1ZHEwYytrdGJ0a2xBa2owUjdENmR4dTFoYjFNREFoWUozcEJIRXkyeHp3?=
 =?utf-8?B?OXNVZlp6SkttRGQ0aXYxUVh2QzZieHZzMUJDNjdjckZlRjVnYXlrUnhPSmh6?=
 =?utf-8?B?dXlrZ1pNQUVwMlR0Z3BkcnFvNVRYT3hmOHpPdUp4MlRaWWEyUllEWDRwdWVC?=
 =?utf-8?B?NUJJVkpCQXRkTzE5bTBtclQxMCtnVVdBY3FhUUR2Rm40djVPR1ZXOWlKdUNK?=
 =?utf-8?B?OU03TmdDMm5kYVpveUUrR1lnc3owcTRQckZKeDcyVHFiQUdJQ0dzcjFNUlBO?=
 =?utf-8?B?V1o0bWVOVk96R1NteFZtM3ZJMVJlbCsyd1ZxNkxSVjRVWUJRcEp3RHJxbVdi?=
 =?utf-8?B?eERGb1lSRXlucXNGN1ZjWDFZcVAwWHduMnhrcXZaTEdMNDlPcXp0TFZhL1Br?=
 =?utf-8?B?eVAwdjA1ZFAzdFQyVk4vQ01xNS9LZWM2OUV2eTNsSDh4b0dsWW5ZZDRuN09J?=
 =?utf-8?B?dG5CeHRGMkxXb09QenpjeWlMRVdiREducytmSnFmOFcrRjNEcERiOU9iQjNm?=
 =?utf-8?B?aEk3eDU2endNNDBsc29aekZSNUFsdHZnMEMvRDUyNURuSUtUNDBsb25DK1hI?=
 =?utf-8?B?ejFBUWtBS01yY016K20vNTJHZ2Vwei9lTFp4V2FHSjlvakE3Vk9LOFgvNVJp?=
 =?utf-8?B?ejV3anJva2pUeVUzc3pMZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEV3Y0hqNDg1MWtGKzlJbXM0TlZNeGJDYVg2UjBVNHYzWWQ1WVBTVURLWi9q?=
 =?utf-8?B?RzA3clJodkhOengxNzRONkFzVFZEWnlWSXFxM2p1RWRHQWhzZXpnOFkraVJ1?=
 =?utf-8?B?cysvMXFFc1NUQmlkUk1lQW1INVEraStxSnRoN3FuZk1ZYW82R0Fib2FjOEQ3?=
 =?utf-8?B?eHExQTIyYytneFluM09xNk1hZjlZQlJ1YW1BNzNEOS9ibndGUkhkNTFzZzhw?=
 =?utf-8?B?WGl4LytsRkpNdSs1Nm1JOUtqZFlYcHViUmQvZzJrL2dxVDZBL092c0JWMTUv?=
 =?utf-8?B?WW9TSjNRaEI2OW94WW1EK2tvYi9xSUlNS2h2NEFNekZYdjhBZFF0TlNMdjhJ?=
 =?utf-8?B?cGhVQ3Q0L2p0RkRXUHhudkVRbkQ1RkRFWjR5RUZCd0RuS1dtWTVQVkZKV0pp?=
 =?utf-8?B?T3NrUmI4YkdhM3g5TTF4V2cvbThtODRsY245SDJZUDVaWmI5Tk9jOWhQTFdJ?=
 =?utf-8?B?aWxMQ2haSFlUemd1S0VkaXM2dlovYUJsVzRmd0IrakkrN2ZjT0hXSUI4NVc0?=
 =?utf-8?B?Ujdxb3NoZUtzdmUzMTEwUkIyQngwaUhkYnB1TzFnQUU4TFhqelh0ZEdIOElm?=
 =?utf-8?B?RDZjQnFvTFhlb0ZZR3BDSWY4cUlPSmhldXpmUjIxbW9HRkNjREF4ZUlYWENq?=
 =?utf-8?B?SkdQL0ZUSVRlZDI0ZHVHdEtBeW1KOFVnUmhFVStQN2tadUNlRlZTanNSelRW?=
 =?utf-8?B?cTcrRnBoTDdxby9YUHhQMVhiTWZtZkhoRG9UbVcxYzRZMm9NR3hBM1YxVTND?=
 =?utf-8?B?VjNULzJhQUY1MDVOQWMwVVh3QU5uWDdYTlNyNWQrSDBpaFJnbkxXTFZXZFdz?=
 =?utf-8?B?aEkrMVFVUTlCV0Zqb1VYOGpFc1phTlEyT1l0a1ZtdERBNXIxN3Rod3FpUFF0?=
 =?utf-8?B?WGVCOWZBNHVnaVJxRTV3RjIwakpIdjZIbHBOYnpVMEZVaDE1eVROb0VzWG5G?=
 =?utf-8?B?eXFSNUwva2JPcy9aUzRFZ3k3YUp0U3M1Myt1S1phc3VKVnhGQ0JINFo5WGRZ?=
 =?utf-8?B?Nk0zZE5qeEJ6akVlaDkyc2ZFTW9MbFBRUVB3ZFY3MStkSkllRXZrTTlteFAy?=
 =?utf-8?B?Zmt5MS90bVhtckhCdDkzZlhhQ2dTY0hNRS81SUFabW1aRVpoUlJ1TURUSERn?=
 =?utf-8?B?UDNhNXZ4UVhoQzQ5R01ubjRBamZLczVpQ1R1d1pxMkRkNzA5YnlDcExzdTVN?=
 =?utf-8?B?aTJRcUQweUQ4RTlWeEt6YXE2c0lXM0NpOHRtYWtrSG04Qmk0NlMrMkR1b1FN?=
 =?utf-8?B?WnBLYVV1czBYaHpaYjlWNGxJb2JOTFVabndoVnQ5MGFXT2NLdkI3QW9ha3hs?=
 =?utf-8?B?UGEwUkVUS2tFZmo5a09zMXJjdWtkbzYzK04xcU1VbVg3LzNsSG1YTkxjVlA3?=
 =?utf-8?B?M1BWZ2ZObWQ4WXZYZ0N6WVVvMnBqcC96ZHNGbnNXZ2JZWkFQMGNzSm03clcw?=
 =?utf-8?B?enZFYmNKTTdmWXJ0anVYMWIxQlEvTG5ONWVQSGUxWFh2ZS93dnhubVN4c1I0?=
 =?utf-8?B?SkhEbTBtL21Dak1qaDFUb0JzS3FTd2NUMXI2Z0ErbzJqeGEvU0NDaExRMXdh?=
 =?utf-8?B?dnp1Zi8vRFkyb1lMVWN4UVV5QlA3NzFGelJDM1ZtUi82eGx3Zll2enlaQUI3?=
 =?utf-8?B?cmpnNTloQzMxY0RDYlVFZG5hSGJvdUdaNW5FdDhGK2REMUJBck1EdFU2ZkpF?=
 =?utf-8?B?SFRzOUZ5SDZ0NExDbVBXKzZOS0p0OU9ZK2tUS0g1bEl4eGhCcEtzOFF5REx1?=
 =?utf-8?B?VldONWplM3k0cVAzYzBVTlNxOWswaFBKUGtsYjVTYUl6elAxNGFiOFE5Z3JW?=
 =?utf-8?B?WStRUTZRcHlLVlVyR3Vsem5Tamh1Q3FOSlpUOUQvNC9TelRZZVFxdWVYM0NQ?=
 =?utf-8?B?MzhaTURVZm1DdnAvTGFkaXVISGtDWHRDVDBZbXJ0MmN0Snh4Qnd1b2ozTnov?=
 =?utf-8?B?ZVh3akZ3NGF3VFh2S3ZoS1V6TytuOENIbkczYzc2OEp3d1k5aEhTcEV6c0pE?=
 =?utf-8?B?ZXlVaWtBdjN2aU5LR1RURmZkOWJsNXRpNkIxTmVxdU9uQ2R5SXQxZnhPQ1Rv?=
 =?utf-8?B?TEpabGxBVlFNYVVwUWdtTmM4VCs5VzRqQitkZ0x5R1lzMW40TjR5M3hDOGh2?=
 =?utf-8?B?RlBNZzQrcUVQaUZ5U0JXdU9veUlvdUIybldxQk5rdVBLUlE1Mk5TYXMyL0hz?=
 =?utf-8?B?VGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KmFSjBjJPvF0cv0+gyvVnjftvwzqB5T7F8NZ51Irex2zbQmuEL4KdpgzMVOIxpfYd4rnFGb4lbg0MQNOE5GtSQdATyRUK3V2oWRXpndigvx9xPnn8+z2S+DEBgN1prdBrfmUbwi+PO23OLfZMcAF7A3ump7az8TRbaf4CEwZPUegUidGTqw/mUrcw3QJuzz2CsBZuZ1ZAMD0YCOzq9kofW7uWEJebMBxR9ENmgTFm+aMIaHt9J6fGMZrCaq3b7G5rxqeAqXfdO+CXoYbJVgtmOr3nG5PwVzk2FANjF0D61yA53c3T7jkkovm6Unf012C0vmV8G33oM/Msq09pAarDOqX2DDn7WBKfvxCUGhPNDslGFXQeu9EwC7KCRmqhanEnmJ1ia10/OCaxsuLWPK4WGsUvHbHcru5DUzmzpXuXtYME/j+f2mWTXiornByvxtYwaS1dalB1kqkwQwq4Oe/oPVlYEgj5OORzFGf1zoyCYBEMP3h+KShRlXSXygUkLYD4puik6M/FcB+muYzipVO0pRUcxfXhBMsn5vNJfV68vCUEpBE/wKXlN9r2sOwCAZaa0EF8x5zFSTXHmiFqLkBYjgfjlf7Eyj1C/jO+PLHSYE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d811813d-01f1-4cd0-21fd-08dcbbbe3a90
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 17:34:58.9585 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mSGEs07CBSFfbNWKsn0Ofzq9KM5H1oQfbKdFtoT6bZ4vYpzGwM28q/Ua1dxopXnau4Ru+Mpml9H4/tJu7L1UDfBnha23DdFBQDsvikvPFaE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4951
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_08,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408130128
X-Proofpoint-ORIG-GUID: ujYiYi69VOVZA4PPYGjlHM1f-hs9bPYJ
X-Proofpoint-GUID: ujYiYi69VOVZA4PPYGjlHM1f-hs9bPYJ
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/13/2024 11:35 AM, Peter Xu wrote:
> On Mon, Aug 12, 2024 at 02:37:59PM -0400, Steven Sistare wrote:
>> On 8/8/2024 2:32 PM, Steven Sistare wrote:
>>> On 7/29/2024 8:29 AM, Igor Mammedov wrote:
>>>> On Sat, 20 Jul 2024 16:28:25 -0400
>>>> Steven Sistare <steven.sistare@oracle.com> wrote:
>>>>
>>>>> On 7/16/2024 5:19 AM, Igor Mammedov wrote:
>>>>>> On Sun, 30 Jun 2024 12:40:24 -0700
>>>>>> Steve Sistare <steven.sistare@oracle.com> wrote:
>>>>>>> Allocate anonymous memory using mmap MAP_ANON or memfd_create depending
>>>>>>> on the value of the anon-alloc machine property.  This affects
>>>>>>> memory-backend-ram objects, guest RAM created with the global -m option
>>>>>>> but without an associated memory-backend object and without the -mem-path
>>>>>>> option
>>>>>> nowadays, all machines were converted to use memory backend for VM RAM.
>>>>>> so -m option implicitly creates memory-backend object,
>>>>>> which will be either MEMORY_BACKEND_FILE if -mem-path present
>>>>>> or MEMORY_BACKEND_RAM otherwise.
>>>>>
>>>>> Yes.  I dropped an an important adjective, "implicit".
>>>>>
>>>>>      "guest RAM created with the global -m option but without an explicit associated
>>>>>      memory-backend object and without the -mem-path option"
>>>>>
>>>>>>> To access the same memory in the old and new QEMU processes, the memory
>>>>>>> must be mapped shared.  Therefore, the implementation always sets
>>>>>>> RAM_SHARED if alloc-anon=memfd, except for memory-backend-ram, where the
>>>>>>> user must explicitly specify the share option.  In lieu of defining a new
>>>>>> so statement at the top that memory-backend-ram is affected is not
>>>>>> really valid?
>>>>>
>>>>> memory-backend-ram is affected by alloc-anon.  But in addition, the user must
>>>>> explicitly add the "share" option.  I don't implicitly set share in this case,
>>>>> because I would be overriding the user's specification of the memory object's property,
>>>>> which would be private if omitted.
>>>>
>>>> instead of touching implicit RAM (-m), it would be better to error out
>>>> and ask user to provide properly configured memory-backend explicitly.
>>>>
>>>>>
>>>>>>> RAM flag, at the lowest level the implementation uses RAM_SHARED with fd=-1
>>>>>>> as the condition for calling memfd_create.
>>>>>>
>>>>>> In general I do dislike adding yet another option that will affect
>>>>>> guest RAM allocation (memory-backends  should be sufficient).
>>>>>>
>>>>>> However I do see that you need memfd for device memory (vram, roms, ...).
>>>>>> Can we just use memfd/shared unconditionally for those and
>>>>>> avoid introducing a new confusing option?
>>>>>
>>>>> The Linux kernel has different tunables for backing memfd's with huge pages, so we
>>>>> could hurt performance if we unconditionally change to memfd.  The user should have
>>>>> a choice for any segment that is large enough for huge pages to improve performance,
>>>>> which potentially is any memory-backend-object.  The non memory-backend objects are
>>>>> small, and it would be OK to use memfd unconditionally for them.
>>>
>>> Thanks everyone for your feedback.  The common theme is that you dislike that the
>>> new option modifies the allocation of memory-backend-objects.  OK, accepted.  I propose
>>> to remove that interaction, and document in the QAPI which backends work for CPR.
>>> Specifically, memory-backend-memfd or memory-backend-file object is required,
>>> with share=on (which is the default for memory-backend-memfd).  CPR will be blocked
>>> otherwise.  The legacy -m option without an explicit memory-backend-object will not
>>> support CPR.
>>>
>>> Non memory-backend-objects (ramblocks not described on the qemu command line) will always
>>> be allocated using memfd_create (on Linux only).  The alloc-anon option is deleted.
>>> The logic in ram_block_add becomes:
>>>
>>>       if (!new_block->host) {
>>>           if (xen_enabled()) {
>>>               ...
>>>           } else if (!object_dynamic_cast(new_block->mr->parent_obj.parent,
>>>                                           TYPE_MEMORY_BACKEND)) {
>>>               qemu_memfd_create()
>>>           } else {
>>>               qemu_anon_ram_alloc()
>>>           }
>>>
>>> Is that acceptable to everyone?  Igor, Peter, Daniel?
> 
> Sorry for a late reply.
> 
> I think this may not work as David pointed out? Where AFAIU it will switch
> many old anon use cases to use memfd, aka, shmem, and it might be
> problematic when share=off: we have double memory consumption issue with
> shmem with private mapping.
> 
> I assume that includes things like "-m", "memory-backend-ram", and maybe
> more.  IIUC memory consumption of the VM will double with them.

The new proposal only affects anon allocations that are not described on
the command line, and their memfd will be shared.  There is no
command line option which would set share=off for these blocks.

"-m" and "memory-backend-ram" are not affected.
They will not work with CPR.

I will respond to your other comments separately.

- Steve

