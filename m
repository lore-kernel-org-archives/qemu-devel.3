Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 655D8C54FB3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 15:09:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKesS-0002o2-Kx; Thu, 29 May 2025 11:09:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uKesR-0002nq-DC
 for qemu-devel@nongnu.org; Thu, 29 May 2025 11:09:03 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uKesN-0003P9-40
 for qemu-devel@nongnu.org; Thu, 29 May 2025 11:09:02 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54T7tueu004055;
 Thu, 29 May 2025 15:08:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=w7r0uh7dL3zEmKSR3VqRGKQ/2t1whb32A95M+vATESQ=; b=
 A+nLWcYUocS9IfB9zgopGDc8j3c/thoJbQnq4ZbDh8yDVEtluQlBKCaY0BBXzT36
 +1TDVhQEQd/GzusubGEUHrrT/7/aiog1deRSquc+YRVCg5Wq2Ejfsjv78rZtW2Tb
 oNsJq+osBmY7+uSq5uMyzJuH8G2xPGynCVjLp4aFcx2cPVkcdOGrer5D+li//a8S
 SATvx1eraEwjZmYmNAXQCUsNuOt3G3RcA+T5MUoE6enfNcspEq+xBl+j7vi9yksS
 VuTSabr4R/aAUW0L5k8TlzoIOaipeBFMY2gOgm8OEdPUwBiNqtqs4DR3Ad4+m4Rg
 eu0RvVjqAt2yUT5BSxJ+kw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v2pf0551-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 15:08:54 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54TEGNUa008213; Thu, 29 May 2025 15:08:53 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4jcttww-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 15:08:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kt3AQ/mrHY6tIqIi/g7FRvn0drZ/gT2KohnbSA4Ha0I2vgRsS+73chCkNxj3Ap3o1GsCWUSv0ysu0W8oiH9NUNSVp0NX6YJze7UTcUrsv4+Y2ufgEjXfIXo7Fh3Ri5UWKJH9pKFfGed5hS69Rg0yh9o5TvRsHYHXsOoNmo2aBOt9gBGnhSEHbbrH4/JoOydd7HF+P5wwkY3LUP1QjywTzPSlrm7B1ghb1fNOUdfVhB3bI1LspfpExqe/yZVpF+jv60dHAT8Qz5Preffi2LIUPmWircruHx9p4dKMgagIFXnDhpFI8J78I3w7RY2yQdtniRV+XT8y2PWhE56KTZsHeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w7r0uh7dL3zEmKSR3VqRGKQ/2t1whb32A95M+vATESQ=;
 b=hYVkbpEUFSKGLuBCRZwzXhTRUUSDOyMznNavS39kKF7hKmEa1qAS6IezkFdrNZptJTWHAvTmphq11brkaOFjiB8q+E1MynYKvgeMPwTSZC3hR3T9/M5QwbDV2lr0x1vCskrIy1+wW26XkK4XXDsPzgXSkNwUS6a6VoT/l6qv2gPzk4VW06b2o3lGhM2xoo0ced6fc1vWqZMz/ShRam+rFdfjLJVTW5c56wpp7RG3Pc7jmqzLadfSuxWATJR/4sfrjE2Q902xuBOoCuZzgOF4CkwDrQyuXzbaO1zPt7E4YPtRmq1WuomAC8bDD3FIZCN0Qwa90s6ThR1f4FDP5NjDWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7r0uh7dL3zEmKSR3VqRGKQ/2t1whb32A95M+vATESQ=;
 b=n9w6NHJFYJA+3tO2gWmapWBIgPMwiuMkHSXcFc7xqd5Z+LYYs/ZdZHzZ1Ky6moT47rAselggd00OOT27PbC4JG/XK+E+H5lYSYixNAHsiCepW51gdohgzppw30q9Re1+8cInSNo98DnqjlumOm6S+gjov0I91/thknVQnjxjCGI=
Received: from DS7PR10MB5280.namprd10.prod.outlook.com (2603:10b6:5:3a7::5) by
 SA2PR10MB4522.namprd10.prod.outlook.com (2603:10b6:806:11b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.40; Thu, 29 May
 2025 15:08:50 +0000
Received: from DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da]) by DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da%3]) with mapi id 15.20.8746.035; Thu, 29 May 2025
 15:08:50 +0000
Message-ID: <c57b0348-9989-484b-8577-389d2994bc3e@oracle.com>
Date: Thu, 29 May 2025 11:08:46 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] amd_iommu: Fixes to align with AMDVi specification
To: Vasant Hegde <vasant.hegde@amd.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, mjt@tls.msk.ru,
 marcel.apfelbaum@gmail.com, richard.henderson@linaro.org,
 eduardo@habkost.net, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, sarunkod@amd.com, joao.m.martins@oracle.com,
 boris.ostrovsky@oracle.com
References: <20250528221725.3554040-1-alejandro.j.jimenez@oracle.com>
 <573444be-8ca2-43b4-b732-dc35648a5940@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <573444be-8ca2-43b4-b732-dc35648a5940@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0139.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::24) To DS7PR10MB5280.namprd10.prod.outlook.com
 (2603:10b6:5:3a7::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5280:EE_|SA2PR10MB4522:EE_
X-MS-Office365-Filtering-Correlation-Id: bfb8f8e8-d888-41c8-4953-08dd9ec2b7d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WlltdlBjNFJWREpaeGZpdG9KN1RIYnlpWlBGQyt3am9TSjRKU2VLM2pnc1dy?=
 =?utf-8?B?dXRGQ2ppQ3oxVXc4ZmRTb2YzeDJ4TUFYeFZWaDRQT2gxM0ZFWlluckFvSWpC?=
 =?utf-8?B?bHo5SEpUeGlVMzZ5ZVhSMG9QaFZYb1FkbTJIbHdUVm5xWThtbldBRCtnNVZi?=
 =?utf-8?B?VXZoU2R1OHJaMTQwT2R6OVpvUVFmMytrZ0RVQVlIamJDTEg2ZHVUNjBxWGVI?=
 =?utf-8?B?OFQwbHNDNm1lbDh1M1lLaEkxNjA3cFF5UVZuR3JsNVZqNGNCSVhKM0dzRXVB?=
 =?utf-8?B?bEI3dHdONzZVN1pYb0NxWXNwU2RGbHc5dzhpaWpZajZvWE9Rd25WTENndWQw?=
 =?utf-8?B?NUZKdnJlWi93czZKaHJjSVhMZERNMSt6Vy9sSk1ORldhSXpiaEJNQ2dTenJ4?=
 =?utf-8?B?bHB0Qk1pRThkVVdYclYvWVhlczl4Unp6NzFFa1VGekc2emhJSlEwR05Ed3hk?=
 =?utf-8?B?c1dBcDFuaXZ6bUYrSnJFQ3U0NTJpMHdZS1hJS095SE1oUHFyT2Jja2FYUC9i?=
 =?utf-8?B?MklRUEVaTGpNRG5nK1ZkeXdpZlhZTXE1MVBZTnBFWjlXLzllWUNMSmxJdVlF?=
 =?utf-8?B?NGk4d1JYWlZvM0xQcnV6eml6S3VhN3R3UjdsQnN4QjBmVm1qMDN2ZWxUUDJW?=
 =?utf-8?B?SEI2bGg2aE1jVVRWcVovaml3eE91ZUkxYjdHNHBBNVFmb21Ed1pybnJmRmwy?=
 =?utf-8?B?WmpRUUZnUGJyUm1tSmtmbU14ZnArb2J4Z0hMeTNJeHY0NDVLNHgrMmhGZXI1?=
 =?utf-8?B?aHpBeWF1V1k0OEdtTXVBa0JaaG8vMjViaGVWRXpTZHFvaTVGUU51UkRIUEVa?=
 =?utf-8?B?RlhiUHlaTDdKTFlkZFFtNCtjS1lqWDNZZ0ZZemh2WkF3dnZiOW1hTEYzbGhK?=
 =?utf-8?B?TkFpdHM0QnY0OENldDNPa1cyb3ROYWJGM01hYW5SYzA1aWJQMStzZk9BZ3Ur?=
 =?utf-8?B?dm1lemFLU05CUmpaYVB6ZTJYcFN0Q285RTV4UlR4L2NUZ3NMSGRUTjB0VzAw?=
 =?utf-8?B?RTFHb0c2L2p5SXR0NzRIdDR0emQ1ZlZNMnNHdkl0c0d6WmVocE5wbTJrMStO?=
 =?utf-8?B?bjc1UTBXWWYyNnRiSjdhOXZ3Yms0N0N3bXdnSGIvaXJGSmNldFlHR3lmSGdT?=
 =?utf-8?B?TklCOVVtSmJRS1FpTXlBSlFPVWplMnZNYlE2dlU5VHIwZjQzV3VDMEQ1N3Fl?=
 =?utf-8?B?T3B5eGJnRjFjUmdmcHltbDkzWXRmOEdUT2hqTERpczZHdHBEUmxMWm1Wd0dK?=
 =?utf-8?B?cUVtYVJrRzRsMFJzUEcyZUhwUk5VeXliVzlIbFdVVWN3UGUvaHBmYW5ZWGVw?=
 =?utf-8?B?bmlxclVsdzQ2RkFPd3B0cEdXNmJTK05UZFFtTWtJNDY4NU84YWd5ZWtBbHdS?=
 =?utf-8?B?d1BFdjdtVzdWVm5xZHVoaGVYc0hOeGZBeTRvR212YW5XbmFQUzh0Unhza0VE?=
 =?utf-8?B?b3RsM2Ywa2swazdiODRDM0Q4MXZlU1hIMDF3REhkWkhhdU9rWWxzbnRqcjVT?=
 =?utf-8?B?T25rVUdKRExiZ2QwM0JBWTVSYlRRUlRadHUvSzVhKzlSK25nakI5dmxwOUZk?=
 =?utf-8?B?T0pFTHpvUVZhN1R2N2RXeHU0VXIyZkdZVzc3S1F1b1EvQkVvd0VGejU2UHdC?=
 =?utf-8?B?MUE0UFAyMXpNQWdjeDJLQTRYR1BtTFNMazAwTkh0azlyVGd3aWsvNGdWcmo2?=
 =?utf-8?B?R2huS2phbjRLRUhpVThvVWVJREhrbWQwcnZEQUNrV0ltb25hM3ZNVjVUa3J3?=
 =?utf-8?B?QVdGSHpBaGVZNnJ2MFhuWVB4cHJJRXdpOENrdDVuRDFkdTgwcWFZOEdaT2Z5?=
 =?utf-8?B?SlNCd0lkTTlsbnU2SG5HV0NSeUVvbTBuaXJNbUc3YjZHa2NyS3pGSVpxZlh0?=
 =?utf-8?B?WSsrUzZxYmkrd1FZaUcvVS8zeEpQWmFwd1Z0RGprTlljN0JZSVFDcmRacVRw?=
 =?utf-8?Q?2ufhalDFHHnwjGkq4rgzJZKIqaJ5/yNV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB5280.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dW5oWGo2RS9ITm1tOWVFTXZERzNpZmU0S0M5SlkxdXd2b2tLZ3lqT1ZZMExq?=
 =?utf-8?B?VlNzUEFjSlRVRUhTQXFidE5Obm4vdjJRbG9LR1ErRFc3SWRVUkIxbFJHWmU5?=
 =?utf-8?B?TFA3U3JhcU9tNHRJTGpuK3dwSWp0V05CU0Vtd051ZGRyNWpJM3lSc3grZmpT?=
 =?utf-8?B?K3liUGhOb2plUDdzNHlCTVRZUUV2RlUxajRsSVR1ZWZpRVRsVThMMWZyUFNa?=
 =?utf-8?B?eXFKU283aHNBUk5maklBSTMrcFd4Slo4SUVNMWh1OFRCLzBITFlYekh4MzRq?=
 =?utf-8?B?L0tJbVRKcWhMcURCWFNJeXZSL1kzTDl3RHoyUGdkMFFDTkxyRkp6WDU4SFky?=
 =?utf-8?B?U1RYK0p5S2hWZzNWYlE1ZjFWaDZYRitVTlRDR3NPeWpPWVplZEVPTHZjS3dL?=
 =?utf-8?B?S0ZRSjVMdlFZNVRpeVYyaHV6UkFZRmpXVE1sLy9jc0MybHR1WUd1QVZITGt4?=
 =?utf-8?B?bjIxbXVIMUFaMDNRblY0ek02UTN2TnViWjlwZ0MzaHUrY00rc0RxVXluYjhx?=
 =?utf-8?B?UmxkOXJnUE1WVWxHcHpiQkFJZ3c0VHVBcVJ1dllvbVpRdmdDQjQ2UThaSDht?=
 =?utf-8?B?dXF4OWRRQUV5TTBaNXlJMzR1elZqaDFXRVhraG9XdmZ2RFJ6YUdKTnZNRHU4?=
 =?utf-8?B?Y01vc1FUQXRxQW1QeEhYTDRjV01nd0RoRUpueHJJSFdxRnRpMVhGSlpQUEtP?=
 =?utf-8?B?YUlnSVJSbzVyN24xSGxrNk0yZUQ3TisrdHJRdVJ4ZXZEdjcxQis0QjVMdmwz?=
 =?utf-8?B?aHd5eXgrZWR5RHRZZnlYUC9qMzdUMnY0YlBLMFFGbFEwUXA2dmlWSzZDb2F0?=
 =?utf-8?B?eEl6K0xHVFZMeXRsUThZWW9DbHZ5dm1BWDNHWm5MYndhaDNONnVvc05TNU8z?=
 =?utf-8?B?RG03MG03NllvbVFsQ0szM09SSVVwMjBLaGJJU29KNWMvM00rZC9zUmV2ZU8y?=
 =?utf-8?B?eGg3c1BDT2JUUXR6V1dBNTluSC9wdDBOWUs0S2ZvWkFwSEtRdWg5ZTFtQm5X?=
 =?utf-8?B?V2x2UkI2K0dsZXgvZ29obVZrbk4wRHZuZEZwcGtlZHpqc1dWa1pMQ0NCMDRx?=
 =?utf-8?B?azRBMDBvbW1PUEJxaVFkcmR5SzBEWld4WGt0QWkrUHJ1Z3JBVXdsMDhoTUtU?=
 =?utf-8?B?RG13ZUJGSER6cUh1MmVPZ1Nhc0QxNEpHZWQvQWlQN1g4NHlBNEx5Y2xHZkVE?=
 =?utf-8?B?QmVFV2lLQWRQZFpmb2doSUc4VU1XZnl0N0RnOEtiNlVFdFNuZEN6cVdBUVdK?=
 =?utf-8?B?T2dHclR3WnordUZidHZxWlVUdms1VWdDcWxXV2d4bEJtTGhmeVRSZ3A4ZVNk?=
 =?utf-8?B?cGV3LzVpN1RwOVZiUGdlQ1dGcXBUMWhQeiswUHU0YWpwMXVhcXZiZW13czJL?=
 =?utf-8?B?djJCby9pWFhldWg4STBpQUQrdW4yaUlJMmZ5cm93QWR0aFRWTG43T2t0ZWtC?=
 =?utf-8?B?ek9vazVrSEUvTElBUFcwZi9qQkpSVDhxMjlyUTlpR1cyUUM5QkpEUTRqWkh3?=
 =?utf-8?B?YnlOV1o3YkNpQ0UrQ0lqYzVTaXorbDd4R0xKMmJ4QzhaY01BMytkTzN5UHpN?=
 =?utf-8?B?bXEwMXpaTUhKODBBdEFaSzA4ZFV4YmNaWDlUUVRwSU03bWZGd1JFRHNiMDl1?=
 =?utf-8?B?WlNCeVcrRllHSHU4YXpwM2hyVmFIRDdQQ1czL0xWbXozelcvWVNoUm9UbDhW?=
 =?utf-8?B?UGs2c2hqTHpHYUlKMDR0MGtUMHFVMTNmeFgxdTM1YUtuRVU5THFhNVF5alFl?=
 =?utf-8?B?aXZxa0pKcFhBZHJ0RUdmbG9DUjhCTjNQd0s4SGJMS2lZSmF6dGRpSjNXemly?=
 =?utf-8?B?SVJoMm1BUXl6d016TWdmQktidHdOUmRQYnlzNmF1NkFUQWVsWlkxNjFzSy9l?=
 =?utf-8?B?MXRVZldPcFkxUnVCQXVHZFQwZFZtZzh5L1BZT2FBZ1FNTnpxeFRicXVmWjI0?=
 =?utf-8?B?SVk2WEwvdENQcWJjOENZU2xTUG5vclJ3OURHQ0dIdWJWYXF0RFBwejRwemRz?=
 =?utf-8?B?OFZJR1pYSWtFS0F3YnIxRm95SGRQa1pVVklHMWpDZjVJS280TmEwUkVtWlJk?=
 =?utf-8?B?cFE5T1lHWGw4aFBoRjV5V1pwSk5yQjNPOHBubVhQdEM1OVl3VFVxNFlIK0Iz?=
 =?utf-8?B?OXlDVjF0ajFJTmdQRGhldzhXZldQUzJWSzdncWhpVU5SSzFtTklFOXhzRmZZ?=
 =?utf-8?B?R0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7qfsGbIphRaq1gYNi7kQ/d85izcpnFUhupBkHLebjr0xmV4rXJ/JYa43Pm09IAP+ggCq6PzxeYjL0R1WCedb6n8GAI65pzgs8gcN7m+lYFBhLfYw+leOh0RlVmUZ+XHmb1n0y5f4LHCtzItSXP8qcYQMVmQwr5mMxbMtdzCcouPW/nrNbkoypO+obwy5Bnqr99i4K07zuqU3WARTyGh647GnrjI4z4gnEAUnUDBu4Kqed3IEofC2ggGFbnQooIaVpxzLejA0PufkGsYm2cwIRdLqqeB7Nc7DIAjRHpM23KA3GXMzkB6mzzvQ0I/TwDy5AygXEmHVBszFkLOSZgr/g3tKDouvXRExuhbtB7JObltVL69xksYGlP/guE7+Xq9n6Mv9dfzeFdq3whTodRYCNomQ5eBORoCKVlGlUk8XbmUDzTwb9S8u/hSS8/R4QX7Cb0WJvp/P5x2PLi0B6xEwCyVzaQ9wYZpM4vh//LRsV1Y42HRew81BfSxaW2J+QkGTZFV4P+IAAHxgbkvNVRqv6oEuobBF7ATiBtdbB1Pqc6sOcvgpZdfRWlkJK4h5b9TKcOxpZ3Pi6MEjTauTIspFf1FeqDDrWLvbzo9WEJi/LTA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfb8f8e8-d888-41c8-4953-08dd9ec2b7d9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5280.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 15:08:50.3275 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5SgT06i+fjox4U3c5PQvGhu9VQ39/jh+iOGcOeB2ddIkThICzSJdoghh60+ZWU32zA1tfjrbn/DrGT7chvtIoW/9Bqx8PzCu8+cETW1Cxg4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4522
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_08,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999
 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505290147
X-Proofpoint-ORIG-GUID: qWLN8V-YRKqtUM7ZT-qvK399YUazzOBz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE0NyBTYWx0ZWRfXw15C+Mif2dbJ
 VsKwhZutW89hKtwKmB/M141bby4Xp4DvDRzSFy3e65WXf8nwQt/xcaQXajlw9zNaODI66nsd5lo
 Ur9afrtLw3M5Sj6GTW7OjLvHefoeIkFE0zqpbNnNFT0spKoW0nQFrjZuzKYX5rNdFqxgH2ev9z/
 EpoNxxnb5za3FKwYyKXDc1ZpBRky5GmC0pnDwQCWaPth0UGmSuivmrdVe46JjbkfTJhxeIUS9Sa
 3ZGcz5PRRqdaaaXaR0k/U05D0yyqQwMpvCabWLa7268cNCVdffVAKUbn5G7hGB3IjdmRnpVNkL4
 qoljqL3gFKX+0Up0YpOTGn82JzPxeAKEs17VkWIjy1sICdc31R/v0npiPzhW3hC7RKzLFtt1BJ6
 DpAWCrpnvMqjNjzBgo8kQuTii5XUJiJSqUtgrUPBcIXWkIztzkCuEgTl3OVMNYgydda0NCYN
X-Proofpoint-GUID: qWLN8V-YRKqtUM7ZT-qvK399YUazzOBz
X-Authority-Analysis: v=2.4 cv=TdeWtQQh c=1 sm=1 tr=0 ts=68387886 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=FlJsjfKt5K_40mCTd7UA:9 a=QEXdDO2ut3YA:10
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



On 5/29/25 1:26 AM, Vasant Hegde wrote:
> Hi,
> 
> On 5/29/2025 3:47 AM, Alejandro Jimenez wrote:
>> Correct mistakes in bitmasks, offsets, decoding of fields, and behavior that
>> do not match the latest AMD I/O Virtualization Technology (IOMMU)
>> Specification. These bugs do not trigger problems today in the limited mode
>> of operation supported by the AMD vIOMMU (passthrough), but upcoming
>> functionality and tests will require them (and additional fixes).
>>
>> These are all minor and hopefully not controversial fixes, so I am sending
>> them separately rather than including them on the DMA remap support
>> series[0].
> 
> Thanks a lot Alejandro. These are very useful/important cleanup/fixes.
> We have some more cleanup/fixes. We will base it on top of this series.
> 

Great, thank you for the quick reviews! Looking forward to your changes. 
I'll be out on vacation next week, but will try to review as soon as I 
am back online.

Alejandro
> -Vasant
> 
> 
> 
>>
>> It is unclear how relevant these changes will be to stable releases
>> considering the state of the AMD vIOMMU, but the fixes on this series should
>> be simple enough to apply, so I Cc'd stable for consideration.
>>
>> Changes since v1[1]:
>> - Added R-b's from Vasant on PATCH 1-3, 5.
>> - P3: Match the spec, although vIOMMU case does not use DTE[3] (Vasant)
>> - P4: Fix more definitions using GENMASK64 for consistency. (Sairaj, Vasant)
>> - Dropped PATCH 6 from v1 and included it in DMA remap series[0] (Vasant: I
>> didn't want to assume approval so I dropped your R-b for this patch when
>> moving it to the other series).
>> - Fix issue with mask that retrieves the IRT pointer from DTE.
>> - Remove duplicated code. Although trivial, I didn't want to sneak this into
>> other unrelated commits.
>>
>> Tested booting guest with AMD vIOMMU and guest kernel in passthrough mode.
>>
>> Thank you,
>> Alejandro
>>
>> [0] https://lore.kernel.org/qemu-devel/20250502021605.1795985-20-alejandro.j.jimenez@oracle.com/
>> [1] https://lore.kernel.org/all/20250311152446.45086-1-alejandro.j.jimenez@oracle.com/
>>
>> Alejandro Jimenez (7):
>>    amd_iommu: Fix Miscellanous Information Register 0 offsets
>>    amd_iommu: Fix Device ID decoding for INVALIDATE_IOTLB_PAGES command
>>    amd_iommu: Update bitmasks representing DTE reserved fields
>>    amd_iommu: Fix masks for various IOMMU MMIO Registers
>>    amd_iommu: Fix mask to retrieve Interrupt Table Root Pointer from DTE
>>    amd_iommu: Fix the calculation for Device Table size
>>    amd_iommu: Remove duplicated definitions
>>
>>   hw/i386/amd_iommu.c | 15 ++++++------
>>   hw/i386/amd_iommu.h | 59 ++++++++++++++++++++++-----------------------
>>   2 files changed, 37 insertions(+), 37 deletions(-)
>>
>>
>> base-commit: 80db93b2b88f9b3ed8927ae7ac74ca30e643a83e
> 


