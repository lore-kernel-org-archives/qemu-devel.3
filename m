Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 269C4C5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 19:10:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMX0f-00076Y-Fe; Tue, 03 Jun 2025 15:09:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1uMX0d-00076I-MA
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 15:09:15 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1uMX0a-0000Zj-MR
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 15:09:15 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 553HY0iF029063;
 Tue, 3 Jun 2025 19:08:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=corp-2025-04-25; bh=vh8IVCLD8T2g2KIli9
 1F3OUaxwEeCLA73sfMgR5nuWI=; b=YsBaretjFTqqAb+vjUqwo/gcbMA6AwR6vC
 xmExDHForH4UehjcR1nECXMJy3GI6cf8kSOeoZVo9hvz3tWFCcihOXOtVzmGAnho
 m2rgvaiWI2hSD21KgRtAlSZO5xR0nDYxfdsPDOmtzvaCTdAQuI/R8O3RGJFbDY0D
 CsSeTCprgX45gzoMgubbztQS2Yjiv8adQSCKUWYAoKInLeOO0hc8NswHQJf8B+f5
 DD0YJ3YV2rVWxHm1a8xnuy2eyosh+VUNFthueAs7DMU38F5XMmtSjaLbHbk4lONY
 PPMVbHLgI9wB2tH+9csodyGcVM3CO+gqmWkS4jtw+JGwOIoQIrOw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471g8dtksc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Jun 2025 19:08:57 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 553J2ksL016360; Tue, 3 Jun 2025 19:08:56 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46yr79tv4h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Jun 2025 19:08:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PQui5Iu8koB9KnEWivt4ZU764pjyaHT9YyCQ9sSTDo92FRvUSTafllWncyvbd9mGRxzQs1CpCjsGo/+Iw89dVTd3Yuvg9xH8C7NbHX5b4ahtrRvFND/ntsVqd3vHhAhAz+kFca8kXYMb6fRR8NNBTSZkfwW0f3prvzVlFChGS51xyWh3jVyTgKvi8BonWyBjk8OQMktdKEzbK7sOl4vwt2cT46P3fjMjBHPJ3fk8vbyYKI04LXG66LeBxs6MHghRa7E2soXoLmMednBjxeIb0QsVs6R/BR1hFv+yF/HIOL55+tV9ypvf+yvnQsnZiXNrDOv341TIg7EvmaCFWsx3hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vh8IVCLD8T2g2KIli91F3OUaxwEeCLA73sfMgR5nuWI=;
 b=Qni5V8Uc9sYiTJ2ZTMV2QcxWbdCgO6OqV6ukIIVhG2cHFddxh9ovlm4/1CRooUpvNnn49PCd+A/b9ET3/FahSfZLCuevp79ElHq1KvzQjXfggXuNhqbSUMVnzpYqn2ip5LuyWCUnxzwRQGnXzdOLn4E0/0jM0YVpi7OrMvWL7uKXzOwQVQlK2iz53P7k+uJtOgzpr5IpR8w0cXfrSMSUPd3IB3HzyTaSPPDXND8gIvOgAVbO1TDcU3GBJGTEG761WChj7v3NcXvaJTy6inD+EIoxMB2H59cMTUv0FDlL4JXqrTIGDZwRFLsEAVXexM6NXc7l6FIs/3HDgxp6O7m4mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vh8IVCLD8T2g2KIli91F3OUaxwEeCLA73sfMgR5nuWI=;
 b=IT5rmYRfKwY1yMedSQzCXJ8/zMHDQg51m7dQPZh2I0RPtYpBuwP5PjP4k88/AYOLrEVnG5l+3jF2Ib1TiQvFZvHvpSuCodFwukHZ0YX+uXASsmlnEoZqJzaOIy3kskKrdGfzXP5Gz0qZ/bbP4FpxqxePC280udzmUwR/DpOJD8Y=
Received: from CY8PR10MB6851.namprd10.prod.outlook.com (2603:10b6:930:9f::11)
 by SA1PR10MB6589.namprd10.prod.outlook.com (2603:10b6:806:2bf::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Tue, 3 Jun
 2025 19:08:53 +0000
Received: from CY8PR10MB6851.namprd10.prod.outlook.com
 ([fe80::a218:72a4:83b2:56dc]) by CY8PR10MB6851.namprd10.prod.outlook.com
 ([fe80::a218:72a4:83b2:56dc%4]) with mapi id 15.20.8792.034; Tue, 3 Jun 2025
 19:08:52 +0000
Content-Type: multipart/alternative;
 boundary="------------sCROkt1SD0IwNt0onKk1D0FK"
Message-ID: <4d7cfdea-34a4-40b3-a81e-560a3a58b194@oracle.com>
Date: Tue, 3 Jun 2025 15:08:49 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] acpi: Implement control method sleep button
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, dave@treblig.org, mst@redhat.com,
 anisinha@redhat.com, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, zhao1.liu@intel.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, slp@redhat.com,
 eblake@redhat.com, armbru@redhat.com, miguel.luis@oracle.com
References: <20250528163545.2143-1-annie.li@oracle.com>
 <20250528163835.2151-1-annie.li@oracle.com>
 <20250603143110.2cd22790@imammedo.users.ipa.redhat.com>
Content-Language: en-US
From: Annie Li <annie.li@oracle.com>
In-Reply-To: <20250603143110.2cd22790@imammedo.users.ipa.redhat.com>
X-ClientProxiedBy: BL0PR02CA0129.namprd02.prod.outlook.com
 (2603:10b6:208:35::34) To CY8PR10MB6851.namprd10.prod.outlook.com
 (2603:10b6:930:9f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB6851:EE_|SA1PR10MB6589:EE_
X-MS-Office365-Filtering-Correlation-Id: acd25fde-ad87-4886-c138-08dda2d21429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L1NMMzkwVE5ValJGNGNxQ3N3cGE5emxYNzdzWW5uOHJUU1Z0RkZJSEdtRXk5?=
 =?utf-8?B?UTZZelZGSndFejlabGxUQTc0WW5UOEUweExUdkVzM1hFejRkUm8zRWhVQWlQ?=
 =?utf-8?B?T2ptSXVmc2ZETDl4OGgvQ3lQbVV4enY5OUk0d1RHMkEvbVBkeVNIb1FHUnR6?=
 =?utf-8?B?UTN5Zk90YkJ2ODBjUWRtWXZOVitVUUxMbFFlUDAvcUZJYkIxdHJNeXdjcmQz?=
 =?utf-8?B?c2hTSElzWlkwcUpFMUJ2MGRDbmUwcE9qdFlVUUpYNDR1YXJscFZ0dVZxN25T?=
 =?utf-8?B?eHZOSFgxMkkxVlBvWXE1M2V0cFFnbmJxUDdKOVlRVHRqVDlaWWc1WHZHdHBj?=
 =?utf-8?B?eDBGaVI1UWNPek1sZktxVzVZb2FCOElaMFEyZUE5dG9nenlSa05QNUtZb2V2?=
 =?utf-8?B?NUdna3BkRU1NY1RnYkhESVo1MEZMMlRvNG55bXZ2WEpPNi9lTGJGM00vcHJP?=
 =?utf-8?B?eHZ4KzJzd3dwUGdRQnNZdXlkN0NQbUdzbnNieFlPUVV0TWdNaDhDSmdXb2x5?=
 =?utf-8?B?bVlzTjJZTk4xVW1iOWtmZ0RsUkR6Yno1Ykh4cHAvL3BCK3l0QVpodWRnYURE?=
 =?utf-8?B?bElXbDJBWUdLSmwyUXIvT214SUFPbE95cldGbklwckM4L2UwR2NJWHpxb1Ay?=
 =?utf-8?B?UytXRGtoZ0RmUHVpTHpEOE9QeXdLWitzSTZXODQxUSs3Umc0R3FLM1RGZ2My?=
 =?utf-8?B?em1EMHdNelJrZXgwdUVzMCt1TXRIVVdlck4yTW5wNnNVa0tianZQUjd0R1BY?=
 =?utf-8?B?WlRWMlFLN0FNZUFreTdOeHJlSkVleUVaK2JobSs5b1hrd2ovblhFWkJ1bzJ2?=
 =?utf-8?B?ZXBwNjZPVk1XZDBSczNGQnI3UzlFQWNnSW1SK0s2QzFQZU9rSzJNSmwrY2hI?=
 =?utf-8?B?TFdaaUNsOUkxZ3FlYlhvVEVSQU1NcWdwZVg0dUdseGJBN1h6dXRPODBRTnV1?=
 =?utf-8?B?ajZxSnR2NElGYStxNzZKMC8vcUw3QVgrWWVGdlVzWmtLcXhVUW4wRXlGeFNK?=
 =?utf-8?B?WkVHUGZjNU4vQnAyQ2VSVEtYY24xcnZNMG8rYzJIM0JMcG1vZGo3MlFGa1dW?=
 =?utf-8?B?ZTBkWm9jTHhoaDBmSk9DT1NyWUo4UVpqVjNVWEdCbjdydEdiNG5Ua29zNnNz?=
 =?utf-8?B?RVFlVHRmelBmblRDN2o4U0RxQkJ5UGNhbm9iUDBQaG1JdmxtSWRzOWdlaUhr?=
 =?utf-8?B?U2E0NkxYYUcrcjVXTVhrZWs4YXlBTjEvNk0rbUFTT3pYNnlGV3hCd3d0Njl4?=
 =?utf-8?B?bnpwRzJXZzdMNk5lOFgzQ0tJOHZFaEJSYjNYdGZGczNMZEwxYm5SZWFSSVFP?=
 =?utf-8?B?UUJqem00dzFGZkt4c1Nmd1BuUFB6ajN6OFBPRG01Y0d4aFUyeFFXak1KNFAv?=
 =?utf-8?B?eWNLREtxY1B2UDNXZ0oranVIdmdrN01DYmhYd0J4ZGcrNUVtcFAzWUtOYnE5?=
 =?utf-8?B?Vitza3dlZnYvRG1uamZwY1JnbWVmeUpoK2xmWWhwRm5lRng4RjB0Z1RvWVVE?=
 =?utf-8?B?MTFSdnl6dU9xWWFEdDZDdEZibCtzRjVrTGJGcVFZUUZkVk5JcFpEV3dkeEdj?=
 =?utf-8?B?bFR2K25RWCtONHFnZ1pabTZEbVh6TzNMZFpaR2RBNDRkQ1d1N1RjbHRsSTdw?=
 =?utf-8?B?NWtoUnRvQ29SdHoxOGcxNlVvVW1JNnk1WXFjbjJXSm5TWnppMlk0MDNvelpY?=
 =?utf-8?B?dmc4Rm5wcGhsbG5HMWZZZHVZVm9FQUNvV0g4c1dyeXZlSmVrQ3R6MUFBbDBw?=
 =?utf-8?B?MzdsSDhhK2phZkN2OTlpbFJZblUwbjJGeU1FenBZZHJIUUpDblRCNEZXb3NT?=
 =?utf-8?B?SmxiM0crVi9WZjgvVWVaM2FvS21XaSt1SzVBU1pYZ1Q4aHhjeS8xa2lxY1JM?=
 =?utf-8?B?ZnlzVUFiMUdqS1h5a2laenhXTzVrcjZrMmMvMmdwUUdyaHptaDBVL05WelM0?=
 =?utf-8?Q?ieN6OEhOblI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB6851.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(8096899003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aU45UWo1eDVtNWRZaFVvRjBpR2tYTTN5VCtWSEJJbzV2bWtCY2NCOGQ4V0dL?=
 =?utf-8?B?WGsvMDFLZVAzSGlwdlV1cndyb0pwQTNDMlNXU0x3N1A3M0hNbSsvRUJBaS9D?=
 =?utf-8?B?S0ZoZVdMQlhyN25aNVFpT2doVFRVZENMZ2UyUEtkaU5IdFZuSjA2SzNsdUE1?=
 =?utf-8?B?TW9GZVpUeWNjWXBrT1RkN0NCekRieXI1ajhMbUl0UCs4ZnBLSmR5TEV2UDZ5?=
 =?utf-8?B?c0ZHWTNsSUdHK2VycU9PTVAvVi8xMnIzWkQ5SVJBamt3RG5EbTEzeW1tMWlo?=
 =?utf-8?B?UGJZR2tXSmY0QlljbDNvczBZenhRZnFMTk44Z2JnWE9qNU10RkdUR1VzdVdF?=
 =?utf-8?B?U01ObmdSTmtZYW9OTXlMQjFleEdPbk5BWGlPM2taMTlsYkprT3NOLzc5cU5u?=
 =?utf-8?B?Nm1TczJ6RUxhbXJjZThGYWZqMnk4R1c4cE1WSWF4bWFDUFVKbU1yTzF2bk8x?=
 =?utf-8?B?YUVhRmFCQTQrdnNNRkkzcGZRODAzU0t3bVZJM0tTbHduYzN0QndKc29Xb3hl?=
 =?utf-8?B?ajFlZ2xvdFRPNmVCUXZtV3U2d1pjVk1iL0FoOXlXaU0vMlFDSGp6aWFFRkRi?=
 =?utf-8?B?aW1kZmpoYnVsZlp5Mm1kNlpwdFd0bGhMQUU2a2RQK2V1cVJOTnB2NmNUTjR2?=
 =?utf-8?B?ejRHZWhVOVhoeG1qK05JVWFuZ1dTblFuY0VOVkdOenFJWDFzR2tSTjVxK2Yr?=
 =?utf-8?B?eXRXUmdnc3E1ejVLVmEyZ3ExZXo3RjBITFMzcW1MZW94T2QzNGJDa2pjRHV1?=
 =?utf-8?B?d2M0K1VxUnk1VGJwdVdqTHVzK1VMR0FiK0dVMDFhQlFkcjUzVDdPVzRrd3Y0?=
 =?utf-8?B?SW9jRnVvSjEvLy9WTjArL0Z2SVorZlM5N3ZIWEFtZ1cvamRONklra2g5SW1r?=
 =?utf-8?B?SXg3ZFZFd0hpc2g2a1lRYlNubXEwSHVxQWxKUmJBMXgvYnl1dFVUanFvWUw1?=
 =?utf-8?B?RVRJQlFIOFFZYnIvRTF5QnVicStEa01qdWJydG1GRlpTeEV4dXNUYXJkMUxr?=
 =?utf-8?B?VWQwaVFLcEtZVGRUK0hBbllWcjNGSTBrWXIwd001SURjV2FJclpKbzNMZjBx?=
 =?utf-8?B?a3J5dVJjR1NKSy9KNVZvU01xYzZCSkVUNzAzWVRzblJWY0FUa0dQZHBWb3hL?=
 =?utf-8?B?QjN5eFB2K2Nzc1RNaWFKYzQvTTJ2QjFaYjRVcW85d2NMWDVMVzlZSU0xUFNo?=
 =?utf-8?B?UjloSXlOcUx6KzdDc1k0NFJhMFJ6Ti9mZDYreFRpQVVOZmRIZmhmQnpkVGow?=
 =?utf-8?B?UVlpelFOemJQNWlOcGs1TDlvektmQ09idiszZ0lZRHFHYkJqbk0rNkJKRnk2?=
 =?utf-8?B?eFJwYVNoTmZoakpMVGxBSHVnYkNZV2RlUUFSTXBDYngvMlk0UVBZTHUxcll3?=
 =?utf-8?B?Ukh3OU1jcm4vYllRVHJMLzlWVSsvYnU5MjJSOG50c1lpL05XZ1NiL0FxZUJV?=
 =?utf-8?B?VkJtS3pta1BzS25DNktzV2xxRm0xNjF3M1BEZXR1eDE4bWtZR2paL2dVbU5S?=
 =?utf-8?B?UFlWVkpmNzhRTmQ3MnVoWWpkL3UvTFJVMTBrMmd0LzF5em14YVVBcldLQnNL?=
 =?utf-8?B?cm50M0pPb2Z6Y1FSeGlzUmI3dWVpVmZjT3ljMjY4SlRmQW5zWEhpcHlndGdR?=
 =?utf-8?B?bTF2eEoxTTVMY3dSSGM3YlVGTGdpQ2tCU2FsSkJwdlF0akhDVW1RamtrYWQ5?=
 =?utf-8?B?L2xPeXo3Uk5VMlBRQ0JPM1VHaTV4Q1R3MEY1QzJrWmcrcUwyTmY0bG1ILzF5?=
 =?utf-8?B?ZFRkb1BDTGxxcHI1OWVEcTE3TUUxQ0gzZ2t0Qk1kWlgyczVOaHBjeWV6TGNJ?=
 =?utf-8?B?dDBST3V5N042Uyt6dkQ0K2RCMmU0QXZJWU42bzArU1ArbEo5ZThtY3pCSFNm?=
 =?utf-8?B?SlN3UGF5dE01ZkhtU1RUZytMU2tKTVBoUXdObjZQeWc0UmZSaWptQVY3S3g0?=
 =?utf-8?B?YnJuWjkzd0pYR2NTQnFnUGVLakxWM2tKaHMxaldwVVhWQW5MVEQ0bEZjQlY0?=
 =?utf-8?B?aDZ6K0NtcnpsZU42Y28vR0U1WExpbGVGTkhPMy9DMmV0SFZpMCticUJRS1Er?=
 =?utf-8?B?ZnRaMXJpeUh6Q2dsd0RkU1NTdmZyN25mdDFiSVlpQllCQ2RkN2NzSTdjV1hh?=
 =?utf-8?Q?fahVWoERHQh0ucUhTt152qZH4?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: g4P/cExi325GCq7Co8qHkc1osfKL/gtnfXOya5Fqb9ew7JU8W3SEoPCiM6ozlNxby6+vMTopmCSFBVbwAZZo8+9rNXxwSBUDJppkGPDgxEOf/XK/FaQMYZ1/f8FkRAP0KMQ+9q6XjR2SRf2HD2/DEcCTEehh5OnPViwV9qacjQHi3alM2kW1/ePBEUHvVaxChwgkD5KgWbnIrY4VdgYk7bovZA6zIdjhs69165UDSyx7cug7zo1CDTligrVZR3m9YzDD//dC4kWheeR82cqGdtNVQ+7Evo+kasI8pbCji2CN46rWTSjuvCNWbLq0Up87mZDZcS1ktSpk+mPrkTIavVRnHyZItKVcP5wNOApaOo+IqlAoot18HlznAMlOl3irmo8cgEyaucq/r1s+t1XoiRSsfw0TJFy5qYaUP2wrcwPaXTJ5V6uZOfIwyu5uDpglrGg7URWdHa8y6gzRGxkFRK+3IVaucsu59I5yHBkIuQRbjL1gtU0aqpZx7muY10Ko7xWAyTx29HTX7dxpCVMwr0iymu4Jcmp4P77ZM2hmKnYxUgRamPBMHdpEkLTG8N1NF11LbSI3kCfhoU9jSyrdm7HtA2WwNEYenjVt1KNympo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acd25fde-ad87-4886-c138-08dda2d21429
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6851.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 19:08:52.5742 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NU3Yq4RzOzQtouaGnAR7al62IYH7B1iziI9y9mzUGPl4TsM3o7wIyMBhBZFPFnvsPx6eZ8/koUUCoJXWsmS2hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6589
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_02,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 adultscore=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506030167
X-Authority-Analysis: v=2.4 cv=Va/3PEp9 c=1 sm=1 tr=0 ts=683f4849 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=-NK6Wzx0QidlBfevpBIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=20KFwNOVAAAA:8 a=d3K14h0pm6EeRdOHl-4A:9
 a=AsyMVSZrrDYFJfiD:21 a=_W_S_7VecoQA:10 a=lqcHg5cX4UMA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDE2NyBTYWx0ZWRfX216aghQnmaW7
 SU8qsdvgLdP1eBPnTYU4/UPfif+PgANE3L4/6yeVn/FkUZGqZ5xJQLKUBRC/A9zdrgTDtASVhc7
 KCbE04QGiuyHnK0oRS8RDPqtBrW4UKimoKkoofIEsuwvUFASZJPLBL016zObgLI5rBQ4OeEu15M
 gyYJy99zrok2pXYJRcEUcDHqlKJ3b4HHUamfcXqb5gh4HxRyAYZswFCZ5WDP2ht67afAVbehCAq
 xCiA8muem5aLH3orIiuCcTdmwT+DorNMSG36kOZZHAtvNONF4WeoxjoWTk3F5HX+kCyc/SziIg6
 LQvTRydhvKnZGyI0SluIZ1l8bEC5YBzODu6lsjTET9to9vWqgE68h89Zr1dzYUcFGdVLFoNCWHs
 HTromna9cS9rhc7W43XH4AtkafpZI33yzVhJHx/+U/nhYPo0EX7SZpdRtf+/BIpTjIWhuMmS
X-Proofpoint-ORIG-GUID: Zxg9HGUfyiD69LbaDpxPeb1eptDhqMol
X-Proofpoint-GUID: Zxg9HGUfyiD69LbaDpxPeb1eptDhqMol
Received-SPF: pass client-ip=205.220.177.32; envelope-from=annie.li@oracle.com;
 helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

--------------sCROkt1SD0IwNt0onKk1D0FK
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Igor,

On 6/3/2025 8:31 AM, Igor Mammedov wrote:
> On Wed, 28 May 2025 12:38:34 -0400
> Annie Li<annie.li@oracle.com> wrote:
>
>> The fixed hardware sleep button isn't appropriate for hardware
>> reduced platform. This patch implements the control method sleep
>> button in a separate source file so that the button can be added
>> for various platforms.
>>
>> Co-developed-by: Miguel Luis<miguel.luis@oracle.com>
>> Signed-off-by: Annie Li<annie.li@oracle.com>
>> ---
>>   hw/acpi/control_method_device.c         | 38 +++++++++++++++++++++++++
>>   hw/acpi/meson.build                     |  1 +
>>   include/hw/acpi/control_method_device.h | 21 ++++++++++++++
>>   3 files changed, 60 insertions(+)
>>
>> diff --git a/hw/acpi/control_method_device.c b/hw/acpi/control_method_device.c
> sleep_button would be more to the point
Was thinking of more control method devices may be added in future, so
choose this general name(control_method_device) just in case.
I'll rename it to control_method_sleep_button then.
>
>> new file mode 100644
>> index 0000000000..f8d691ee04
>> --- /dev/null
>> +++ b/hw/acpi/control_method_device.c
>> @@ -0,0 +1,38 @@
>> +/*
>> + * Control Method Device
>> + *
>> + * Copyright (c) 2023 Oracle and/or its affiliates.
>> + *
>> + *
>> + * Authors:
>> + *     Annie Li<annie.li@oracle.com>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "hw/acpi/control_method_device.h"
>> +#include "hw/acpi/aml-build.h"
>> +
>> +/*
>> + * The control method sleep button[ACPI v6.5 Section 4.8.2.2.2.2]
>> + * resides in generic hardware address spaces. The sleep button
>> + * is defined as _HID("PNP0C0E") that associates with device "SLPB".
>> + */
>> +void acpi_dsdt_add_sleep_button(Aml *scope)
>> +{
>> +    Aml *dev = aml_device(ACPI_SLEEP_BUTTON_DEVICE);
>> +    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0C0E")));
>> +    /*
>> +     * No _PRW, the sleep button device is always tied to GPE L07
>> +     * event handler for x86 platform, or a GED event for other
>> +     * platforms such as virt, ARM, microvm, etc.
>> +     */
>> +    aml_append(dev, aml_operation_region("\\SLP", AML_SYSTEM_IO,
>> +                                         aml_int(0x201), 0x1));
>                                                      ^^^^^^
>                                              where does this come from?
Got it from an example in ACPI spec[ACPI v6.5 Section 4.8.2.2.2.2]. "• 
Creates an operational region for the control method sleep button’s 
programming model: System I/O space at 0x201." Any suggestions are welcome.
>
>
>> +    Aml *field = aml_field("\\SLP", AML_BYTE_ACC, AML_NOLOCK,
>> +                           AML_WRITE_AS_ZEROS);
>> +    aml_append(field, aml_named_field("SBP", 1));
>> +    aml_append(dev, field);
>> +    aml_append(scope, dev);
>> +}
>> diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
>> index 73f02b9691..a62e625cef 100644
>> --- a/hw/acpi/meson.build
>> +++ b/hw/acpi/meson.build
>> @@ -17,6 +17,7 @@ acpi_ss.add(when: 'CONFIG_ACPI_CXL', if_true: files('cxl.c'), if_false: files('c
>>   acpi_ss.add(when: 'CONFIG_ACPI_VMGENID', if_true: files('vmgenid.c'))
>>   acpi_ss.add(when: 'CONFIG_ACPI_VMCLOCK', if_true: files('vmclock.c'))
>>   acpi_ss.add(when: 'CONFIG_ACPI_HW_REDUCED', if_true: files('generic_event_device.c'))
>> +acpi_ss.add(when: 'CONFIG_ACPI_HW_REDUCED', if_true: files('control_method_device.c'))
> that would build only for microvm + arm, and pc/q35 wouldn't get it
> if microvm were disabled.
True.
How about the following?
acpi_ss.add(files(
   'acpi_interface.c',
   'aml-build.c',
   'bios-linker-loader.c',
   'core.c',
   'utils.c',
+'control_method_device.c',
))

Thanks

Annie


>
>>   acpi_ss.add(when: 'CONFIG_ACPI_HMAT', if_true: files('hmat.c'))
>>   acpi_ss.add(when: 'CONFIG_ACPI_APEI', if_true: files('ghes.c'), if_false: files('ghes-stub.c'))
>>   acpi_ss.add(when: 'CONFIG_ACPI_PIIX4', if_true: files('piix4.c'))
>> diff --git a/include/hw/acpi/control_method_device.h b/include/hw/acpi/control_method_device.h
>> new file mode 100644
>> index 0000000000..079f1a74dd
>> --- /dev/null
>> +++ b/include/hw/acpi/control_method_device.h
>> @@ -0,0 +1,21 @@
>> +/*
>> + * Control Method Device
>> + *
>> + * Copyright (c) 2023 Oracle and/or its affiliates.
>> + *
>> + *
>> + * Authors:
>> + *     Annie Li<annie.li@oracle.com>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +
>> +#ifndef HW_ACPI_CONTROL_METHOD_DEVICE_H
>> +#define HW_ACPI_CONTROL_NETHOD_DEVICE_H
>> +
>> +#define ACPI_SLEEP_BUTTON_DEVICE "SLPB"
>> +
>> +void acpi_dsdt_add_sleep_button(Aml *scope);
>> +
>> +#endif
--------------sCROkt1SD0IwNt0onKk1D0FK
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Hello Igor,<br>
    </p>
    <div class="moz-cite-prefix">On 6/3/2025 8:31 AM, Igor Mammedov
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250603143110.2cd22790@imammedo.users.ipa.redhat.com">
      <pre wrap="" class="moz-quote-pre">On Wed, 28 May 2025 12:38:34 -0400
Annie Li <a class="moz-txt-link-rfc2396E" href="mailto:annie.li@oracle.com">&lt;annie.li@oracle.com&gt;</a> wrote:

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">The fixed hardware sleep button isn't appropriate for hardware
reduced platform. This patch implements the control method sleep
button in a separate source file so that the button can be added
for various platforms.

Co-developed-by: Miguel Luis <a class="moz-txt-link-rfc2396E" href="mailto:miguel.luis@oracle.com">&lt;miguel.luis@oracle.com&gt;</a>
Signed-off-by: Annie Li <a class="moz-txt-link-rfc2396E" href="mailto:annie.li@oracle.com">&lt;annie.li@oracle.com&gt;</a>
---
 hw/acpi/control_method_device.c         | 38 +++++++++++++++++++++++++
 hw/acpi/meson.build                     |  1 +
 include/hw/acpi/control_method_device.h | 21 ++++++++++++++
 3 files changed, 60 insertions(+)

diff --git a/hw/acpi/control_method_device.c b/hw/acpi/control_method_device.c
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
sleep_button would be more to the point</pre>
    </blockquote>
    Was thinking of more control method devices may be added in future,
    so<br>
    choose this general name(<span style="white-space: pre-wrap">control_method_device</span>)
    just in case.<br>
    I'll rename it to <span style="white-space: pre-wrap">control_method_sleep_button then.</span>
    <blockquote type="cite" cite="mid:20250603143110.2cd22790@imammedo.users.ipa.redhat.com">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">new file mode 100644
index 0000000000..f8d691ee04
--- /dev/null
+++ b/hw/acpi/control_method_device.c
@@ -0,0 +1,38 @@
+/*
+ * Control Method Device
+ *
+ * Copyright (c) 2023 Oracle and/or its affiliates.
+ *
+ *
+ * Authors:
+ *     Annie Li <a class="moz-txt-link-rfc2396E" href="mailto:annie.li@oracle.com">&lt;annie.li@oracle.com&gt;</a>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include &quot;qemu/osdep.h&quot;
+#include &quot;hw/acpi/control_method_device.h&quot;
+#include &quot;hw/acpi/aml-build.h&quot;
+
+/*
+ * The control method sleep button[ACPI v6.5 Section 4.8.2.2.2.2]
+ * resides in generic hardware address spaces. The sleep button
+ * is defined as _HID(&quot;PNP0C0E&quot;) that associates with device &quot;SLPB&quot;.
+ */
+void acpi_dsdt_add_sleep_button(Aml *scope)
+{
+    Aml *dev = aml_device(ACPI_SLEEP_BUTTON_DEVICE);
+    aml_append(dev, aml_name_decl(&quot;_HID&quot;, aml_eisaid(&quot;PNP0C0E&quot;)));
+    /*
+     * No _PRW, the sleep button device is always tied to GPE L07
+     * event handler for x86 platform, or a GED event for other
+     * platforms such as virt, ARM, microvm, etc.
+     */
+    aml_append(dev, aml_operation_region(&quot;\\SLP&quot;, AML_SYSTEM_IO,
+                                         aml_int(0x201), 0x1));
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">                                                    ^^^^^^
                                            where does this come from?</pre>
    </blockquote>
    Got it from an example in ACPI spec<span style="white-space: pre-wrap"> [ACPI v6.5 Section 4.8.2.2.2.2].
&quot;• Creates an operational region for the control method sleep button’s programming model: System I/O space at
0x201.&quot;
Any suggestions are welcome.
</span>
    <blockquote type="cite" cite="mid:20250603143110.2cd22790@imammedo.users.ipa.redhat.com">
      <pre wrap="" class="moz-quote-pre">


</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+    Aml *field = aml_field(&quot;\\SLP&quot;, AML_BYTE_ACC, AML_NOLOCK,
+                           AML_WRITE_AS_ZEROS);
+    aml_append(field, aml_named_field(&quot;SBP&quot;, 1));
+    aml_append(dev, field);
+    aml_append(scope, dev);
+}
diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
index 73f02b9691..a62e625cef 100644
--- a/hw/acpi/meson.build
+++ b/hw/acpi/meson.build
@@ -17,6 +17,7 @@ acpi_ss.add(when: 'CONFIG_ACPI_CXL', if_true: files('cxl.c'), if_false: files('c
 acpi_ss.add(when: 'CONFIG_ACPI_VMGENID', if_true: files('vmgenid.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_VMCLOCK', if_true: files('vmclock.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_HW_REDUCED', if_true: files('generic_event_device.c'))
+acpi_ss.add(when: 'CONFIG_ACPI_HW_REDUCED', if_true: files('control_method_device.c'))
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
that would build only for microvm + arm, and pc/q35 wouldn't get it
if microvm were disabled. </pre>
    </blockquote>
    True.<br>
    How about the following?<br>
    acpi_ss.add(files(<br>
    &nbsp; 'acpi_interface.c',<br>
    &nbsp; 'aml-build.c',<br>
    &nbsp; 'bios-linker-loader.c',<br>
    &nbsp; 'core.c',<br>
    &nbsp; 'utils.c',<br>
    +'control_method_device.c',<br>
    ))<br>
    <br>
    <p>Thanks</p>
    <p>Annie<br>
    </p>
    <br>
    <blockquote type="cite" cite="mid:20250603143110.2cd22790@imammedo.users.ipa.redhat.com">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre"> acpi_ss.add(when: 'CONFIG_ACPI_HMAT', if_true: files('hmat.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_APEI', if_true: files('ghes.c'), if_false: files('ghes-stub.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_PIIX4', if_true: files('piix4.c'))
diff --git a/include/hw/acpi/control_method_device.h b/include/hw/acpi/control_method_device.h
new file mode 100644
index 0000000000..079f1a74dd
--- /dev/null
+++ b/include/hw/acpi/control_method_device.h
@@ -0,0 +1,21 @@
+/*
+ * Control Method Device
+ *
+ * Copyright (c) 2023 Oracle and/or its affiliates.
+ *
+ *
+ * Authors:
+ *     Annie Li <a class="moz-txt-link-rfc2396E" href="mailto:annie.li@oracle.com">&lt;annie.li@oracle.com&gt;</a>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+
+#ifndef HW_ACPI_CONTROL_METHOD_DEVICE_H
+#define HW_ACPI_CONTROL_NETHOD_DEVICE_H
+
+#define ACPI_SLEEP_BUTTON_DEVICE &quot;SLPB&quot;
+
+void acpi_dsdt_add_sleep_button(Aml *scope);
+
+#endif
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------sCROkt1SD0IwNt0onKk1D0FK--

