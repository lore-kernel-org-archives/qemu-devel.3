Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BDCDC55172
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 21:48:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpv4z-00049s-SO; Fri, 31 Jul 2026 17:47:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1wpv4q-00049c-Hh
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 17:47:38 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1wpv4n-00063d-V4
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 17:47:36 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66VJtYvG1420174; Fri, 31 Jul 2026 21:47:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=i0EvKsRHpI6dYkBaYajY597AA5js5FCJsq9eKrlK5c8=; b=
 FWkK6R2dHgFq3LZMTPx2e/3dt9t1RvNryuJseTLGuXUdqueXLaLouE0ruy7NQKzn
 5Cz7wqlKfV/GDqwAe8VoV8tqCbL++jsMOrD8RZkg+s+1uE5llZLpUfbS/OEZ3XVv
 u+O3N+NFDgddYQ66X/OL4ZP15XYrNTVX8RsnVYQA+MA85NBzskKlxwNQWMGU0UJ6
 9FdRXpUSaG5ZkQbyiKFO6ndgYs0LWB0b0A+i+tmxCyyxCX1dC9ORJIppHx58FP1P
 jqOjDsDV/mMv/Sl1JB7os4nfc9BwxNJtFYrhUzWBUQgDP5plnTXIlLg1aGWHPmj1
 Pw5u74BRb/4MZHkwJmIXmw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fmqyymg2s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 31 Jul 2026 21:47:27 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 66VLe7BA030821; Fri, 31 Jul 2026 21:47:25 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11011005.outbound.protection.outlook.com [52.101.57.5])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4fnheq7h1a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 31 Jul 2026 21:47:25 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tWMjgtldlb+92IcKGSDH8MgTn3Oa0stERe3iGRgypG1Ni5W1OTirDHblXrpB+r9NMWSRAzGI8T7T+SG75O2mM2diLElj8qtLbJa2VSswUQIW4RUCHIaFKdsjTuRRBA55fKSpyln33wdbxDlDY9WAFpYctgZWf5TiXBLpPTlY3gw1OSJQGGERLYEoGdiFgHmdT+gzdYIZhKOai3cHvpdhGUJyjrjA3uwsMcsNyN9uG+P/tpiJ2J1FpX/k+6JMNUIUKV5Di3Th7Z8JjM4+6p5rwp5Aleqh63aNbVfJqhzH9KwG37r7WEwobofirjYWfTs4yr4ASaA+ZSXlFMFrTOH36A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vj2bJwoGKA3zR2VJI6pQXrwvr1spOM9ydnUYngIQyys=;
 b=dg6aMT6RfStOsh5lCjyy9CqfPy/X4ZvIKkue9EhD1ZHybPtDxUoy+BwBqV9BcxrsZCg7d0EzVV7FgfWNHxk7Ee6CaB4YnaYrfKjqaojH6zxY1HuqTxPmKjN5izOSLosRLW+Lyqqe5vOJQDHvyronxnYzrlhUIiOUUL11PhLBBjOXS3BxEMhOtGGh08hAecRMjHy8uOy7dTkL1RmzL2B781IlZZtCpwcQbuIT7l4H8uEbCl2A1YwoVJzxuFxOALh/6Mz5twi7JnX24eNkJaWZ0lp/RPI0gie4U+ibD5Lzn8oA+o4rhHuaygKVqCOp/J7+ZeEQUSx5hqITPWWx6slj6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vj2bJwoGKA3zR2VJI6pQXrwvr1spOM9ydnUYngIQyys=;
 b=F2W5+M+cOfr8iE6INsLnEJv9dl9675meNQOU3325wS+CL/RLmXkin3qLrW22DiIqruQYjzR1fKM4RRa0fONMFEYSFw6gVbSiAl0kUqDwT30Z+rD6IOv9t3ancRcmCWH9Xuv5BqpjteNYPYGA6eFXe5jsKXP106WtWoHSyLZx8dc=
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by PH0PR10MB4758.namprd10.prod.outlook.com (2603:10b6:510:3c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 21:47:22 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%4]) with mapi id 15.21.0245.012; Fri, 31 Jul 2026
 21:47:22 +0000
Message-ID: <1df4e4b7-a89e-42c6-98d6-5631fdece7eb@oracle.com>
Date: Fri, 31 Jul 2026 17:47:18 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] acpi_build: Use IOMMU pci device to build IOMMU
 device ID
To: Sairaj Kodilkar <sarunkod@amd.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, vasant.hegde@amd.com, suravee.suthikulpanit@amd.com
References: <20260511123937.32743-1-sarunkod@amd.com>
 <20260511123937.32743-5-sarunkod@amd.com>
 <20260731054920-mutt-send-email-mst@kernel.org>
 <79db539c-a89c-411f-8a34-ab49ca6b4bf2@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <79db539c-a89c-411f-8a34-ab49ca6b4bf2@amd.com>
X-ClientProxiedBy: PH7PR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:510:174::8) To BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|PH0PR10MB4758:EE_
X-MS-Office365-Filtering-Correlation-Id: 05a356f2-593c-4e57-d6b3-08deef4d4d29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|23010399003|6133799003|4143699003|56012099006|3023799007|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: lTg+gkzs7di4fakxFIAi0HmwvqDAedn/9JZ9jMcsKfZF35UEvHgCfBoYXMdbYLC6Ytfm5Q/QR+6pTbI7jsy6USdGDeMhuW0hXmo9iPMSVEClMY+/oHPe3vdBx0kViICqK91OMPgaus9fmYLBNtGJAj4qR+sZ0VWEn01pLStvclVlaPlzUkgnmB4usmiKJ1lQbsSckKRKHTm/pVNy2gH6A9muFB3YXT+TdR5SnctzZ6+Kh99b/A9c01wM7y46XZzq3LTanDTNJcngDxVx6MjbPJNT0p1u7VbXo+8gFxCuR5MCQ2Wo7THRZJhMFm9VmuJMAn4ctwUcjL7rQTBPpR4I9GgIGBKsB5SzMxxrERxsU7uxd/E+FCmnkxLO47Hzu/b4jGuDh4AA3uCnKoHg3XH7SOLKLnc/Lq7+TTcQ5qNJjlUAFr/DRlB/N94/ekqDohzweSdOyb14Y8/DDskMqB0Vk0Fixqexi6DdB0UOub2dk+e5wAsjnvjafLTclb+lbeHuN42K/BRWkShAK7bcJQA/6jMFe1CDfGWIaGVF5VPeiAf8C1eEIu1Zty3R7JySQHFSFcPSrcaxnMcspZIXEPAhsbgYE+2B4g88Z2MyZlYX2AVR+2PVVz27S3I+QaBhPhcIrdsIWiEQ74hVzqMBYmHnWAZHF23gYcg15te4MBOrF5U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5041.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(6133799003)(4143699003)(56012099006)(3023799007)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3hhZkZoS0czTU5WaHVlejM1N2dmYjVrdml2NkZvZnlTZXhRNEtRTTQ0SDBR?=
 =?utf-8?B?NFBRb0szaEQ5UC90WkRua2V1dU81akNqUFV5WDlqWEs4bU9Ga2ZzamZQVGVv?=
 =?utf-8?B?QTcxZEFlelpUWTNRb3dtNG1Zd0RaUWtCMXZyMTVzY0lNU0xydG9adXV1NEFI?=
 =?utf-8?B?RjZETGVEdGJuMTBmWjRwREpGVThRdEY2RGR0YXo3WGRPTmVxNHdMc0psTjZC?=
 =?utf-8?B?S3luTHBseVMrRjdxWFg0V0x0Z3A3OXhXSmVmUFJtS1BTSVZGWjVaOHNMN2px?=
 =?utf-8?B?YnB5RG96SkZjMDlEd1RRZVlKb2hzQzdNRm9DTEM2TmVWaDBtNUVkVHNlWDBD?=
 =?utf-8?B?TkI0WWpOVlRzTytUUXNucW1mS2JSYTBLV0NGNm43c0dGUUdiY3hXR0FTTEF0?=
 =?utf-8?B?K3NoZFNqdVpRWWlPcnNWNUlwTXc0Vkk4ZkVEekV5WWdBNXdqR29NajRqVVoy?=
 =?utf-8?B?T2xFNzlDK1ZjTHl4ZHNnVWk1cWlIbklOYXdzREhtd1cvN2FJNFFLcmJhWFBM?=
 =?utf-8?B?TjBlM05TeFl0Qis3Y2xEbjdrNXZ2dUE1bTY4VHU0OGE4VXJRajQ5OXhibHpD?=
 =?utf-8?B?dnhQQVlURGVaUWQ1b3lVajVWbTZDbGNoQ210Mnc2RGVuVTJET2w0UFVYUGdv?=
 =?utf-8?B?bXlLRmFveHZEN3BMNVV6cGovU0RRZzlTOWRXQjNZN0dOMjI4OEc5OTg1R3J0?=
 =?utf-8?B?cnFZWS93OUYra0JnTDN6Mk1SNU9Yb2lYaEFYUWgrK3pDY2VXL0FOTWF5Z1BE?=
 =?utf-8?B?SXd6eU83Unc0VzIwNjRuQUJlZFJ1WVh2WTIwRjJkNFlSSWQvTzdnK3VpY1o1?=
 =?utf-8?B?cjhHNmhWWUZhQUlMU29hRVg5T2dVQW9LUlU5bmFUZHVEOEFPR2xJVU9jM1pN?=
 =?utf-8?B?M09CT1I1djlENXBKOW55Tm5DT3crN3VoOEpOeVhrYWhvL2FDOXNOVnhhOExp?=
 =?utf-8?B?SktKUU0zZDFZVXRrZnIvNXR3YXhZaTdyeXVvNTJWL3hnZXNzaEk2Tm5qdDQr?=
 =?utf-8?B?UHBPRHZoVzNOUUZlOC8wc2ZRMm9ZRmhPMHhwREZ0U3hkWkZPSUswblMyU0xj?=
 =?utf-8?B?N3piMXNLM1JITnF0UVEyT25ZSURrRTVCV082YkZXWXcvRy9vek93OW56Z2Rx?=
 =?utf-8?B?VUpCcEMrZFJEWEZ6QXRWUmVVcFB6TWQ5S0JTUnFrekdEbU5SZ09walZRQWJx?=
 =?utf-8?B?dlRjL2h2Y2R3Tlg3STBhdmsybWd5ZmlVYTRKOFdFQ0svS1VmY2pnYnFuNHFR?=
 =?utf-8?B?L2dIL3c1bzYwL0RhOTEvRVlUY2RYS0RHNG1KU3VLT2s0OGFiWHpoaVh0UVh6?=
 =?utf-8?B?NDc5d1JmOFBVQnJBK3IyNlgwZW5CamFXaWNPTG9HSW4wajY2eGNsdktsTE9u?=
 =?utf-8?B?WWwvTGRyd0ZNdkE2QWxNZld2a0JBaDJKdXFYbnIrblRLYlFFaXZ1Vk9FQ1RI?=
 =?utf-8?B?cnBvb0NVaVdtT0ZCRitadWRRLzN4cWl0OEhhNnJDa3RBdHVZaS9pM1N6aWsy?=
 =?utf-8?B?UXB5d1RBNE9tMnAxVDBBZWpOYXpENjlxSUtwNHMyMzV4YU1VN2VZN3dBMm95?=
 =?utf-8?B?c0cySHBLYVJWeis5Skc4NE1GUzZLMGI2c2lHU3JYNGpJdFp6MEoyVDhHOXQ3?=
 =?utf-8?B?WVhDVDlUS01KcFZuZHgrSERRZ0d5MUgzRFRLanE2cnkwRkNOMnVqOG51dWU3?=
 =?utf-8?B?YjFPWlprUy9aQlBPd2ppa0ZtY0lZY1drVG1WSVVYNUV3N0dyYzN0bjlkK2xu?=
 =?utf-8?B?WVZsdzZSRVNlYlB1ajBYYmVFRS8xVmxsVTZ5dTAvZHJUUUxXWUQzS1QyUFJZ?=
 =?utf-8?B?WHp4Wmd6RDNzczlrYmZHOCsyKzVadkMwUU9YVUc1dXNBYXBBNHJIb2lTbnBs?=
 =?utf-8?B?TCtoR0piSGw4UlUxc3ZTMk1iSGJtdm0xMGtWa05RWE9VN0NIYWp5MlhnNnVP?=
 =?utf-8?B?TFlaVGVVNVJNazRaendVbWcybUw2eExWblRzclJmU0FnbFVDUlBzMldoQ1lw?=
 =?utf-8?B?QTBVMlVaN2puN2QxZlZ2SkphOWRvdmFKZzYzVStIVUpGVWdlZnU3eWFQR0h2?=
 =?utf-8?B?ejFlaFRtL3RSczBZM3AvalZRY3E1cVAxb2JqUG1LZngrZlhhRDBrUlhIQ2FI?=
 =?utf-8?B?QmpKNFMvRUFCcHNOaStrcXJZVC82YnJ1NmdyblJTZUNrSGxrVmh6aUZQVEs4?=
 =?utf-8?B?OTdMNWs2ZENzZE51TXFDOVBrRm5DdUlNT2pSM0lRLzFORjQvdFdWenJJTUpm?=
 =?utf-8?B?dDRxRjNJUnh3ZkxsWjQ5TUUzYlYycXFFWkFVOXd5UUlkWmEza3lJV0tubkxh?=
 =?utf-8?B?NXBacWoweUp1RHRydlF3eVM1U3E2YzI2TW12ZklTZlQyOUVWM1JUL0hvVXB4?=
 =?utf-8?Q?j+XqT/Zefi7pHn30=3D?=
X-Exchange-RoutingPolicyChecked: bIpZh/Ti806XAbtriOWSG2WvblErxKh1GJ2cTELE6iTp2IJmTYGwzqbwaGSbHTlRMmyATxePltFFWZeCrk6vMahB/FjzL/8qH/NfnOR1qfhEMmldnpzy3Vw0qks0xT1uCLCuj6t7TYikCPaQApX8U1X3REeHM73OvV/tkjuwrdx2AZbh0A69yWIc1RNYaUIW6Q3UfEAaJLYtY/PYPUWFRO0/siyO52uFGfUDuaTst63u8FF8adLZHKpwDsCid9ZPkFZPTPfSJta5qT/3KIYsyFGxdd+VTUTMAiDpSTJRKzFRclWkgAJdxRPRi7mO/JWUM3VmP10asylt5M0enpBQZg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Pp4ssVBMgu/CDNapx5d/zl/yOC0PXfB/zsaca0UsNK7i3ycgsivh2Uc1TQ5Q40j6yyGUktLWLFp/E1IqneMe0NCqJhHHSvUWgYQG4iyzLL5Lc+ImbxK6qkfkzrH26688Z/HGDsPwoU2ZL4qti9B+/C8eycxqtW7AqpROYG/MeukCL9JOkql7arGzr5SqA7JXFEDyabpO7Y5YuWAs9iEgzuYxANRnLKCGhEa3fKwi2C/c4tGSKRbJv0L/IPklc9x5u7OJYYazemh5eX/XKG/nTSHL1IDIVsRof3G7n79rES/fOFq0A2vtAFqz2EYnZrEAiCF+31SKmjk2iC0olJKxgxvGEoTfxZjH66EMYEfdswW8RK4msX/dA3Jex6WOraNbNiuiC6It7bEM0SmcCBYsq5oHWdGtZVTlFEjjJPnbHLrg/IVeBUkm8zy839silkaK1+FfngQ/JGNRFYMTSDsVr/d/UprYTiHQ0SgzeLvBQJWdzNRZfE5BKc+wNTPgEjo8jo0O7Etwbe+wRreGyi1GYLkBpZJocY46LafsfkR5aMB9CDIdlF73/ePGE7bNtxIEYLwmHf1r6W4lgJBzJFNbCJbVmc4eyXD9/S6Hl0gDFDQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05a356f2-593c-4e57-d6b3-08deef4d4d29
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 21:47:22.0662 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Es/ks+B2J7L/LMwAvsCbzKCZFNGj1vJE9TP4gyIjaqjTjvaxOIDxwCKPgLp+ZDitlMmMmMoHFmiRaqFdv/qxdRL3iZ/xhBMZUkAp99Eh0NI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4758
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999
 spamscore=0 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607310164
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDE2NCBTYWx0ZWRfX3dB0bBd/q9CM
 0lU1cgzmqQxjDyzM3cg0viuFa8jqocOn/Zp51iTIZKyQEzv3wwMtDAaYl/nfdpqKqMuWTAersCV
 sDNC6rMcSATNPu+nXv8Vp0fx0W7Et7MBQMXMyKEqiFQmfNJTonjq
X-Proofpoint-GUID: XUtFZ3vib06Wwy8yq2rijAF7-N1ETs29
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDE2NCBTYWx0ZWRfX+ZAkHjLCPi15
 doRl+S4klj2CMrAX4BGLe8alPwgYet4YlwSG9Iw60xTdsQa3Qkd4EqV4Ma1YRYWbvualllLlP7q
 H7kyiHXkvOX6YaiP9lr7fw9aDVJdgJCh3u+XdnM+kvacwPwNqNZdE0P90bHgr5kRcJJ/bpjwY2X
 Fe12G5suklXcCycQJTnAe39m6jTeBEIqKCYhsOTIpawQVu2x3x7KUoJxuLXv1u6e4KsTg+5egWy
 2NgjhVCHF72+0/aYnhHM1ODf+Hr2QE+02ci8DX4sngh7m8Y3fRs5WdweV3igRwbQTFyqIpI9NCx
 hhO5N8I0HCMcFb8wzMbEmYAJRyTS90pMZleZR0CKPaM6WBvJOi4jBdP2UbFJoXBmUhyjMahvg84
 uaHVzGJjIhCHDYfkxbGylgZ6bCSXBa8DUVnNBCaAh0TsJlOEpLc+tj69dBfIorr5kFqoXZvTMG0
 5wpi1Vv8drG89QFLklg==
X-Authority-Analysis: v=2.4 cv=HNnz0Itv c=1 sm=1 tr=0 ts=6a6d17ef cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22 a=RpNjiQI2AAAA:8
 a=zd2uoN0lAAAA:8 a=2WNzM_x_xaSZlkApHXoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: XUtFZ3vib06Wwy8yq2rijAF7-N1ETs29
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 7/31/26 8:32 AM, Sairaj Kodilkar wrote:
> On 7/31/2026 3:=E2=80=8A20 PM, Michael S. Tsirkin wrote: > On Mon, May 11=
, 2026 at
> 06:=E2=80=8A09:=E2=80=8A33PM +0530, Sairaj Kodilkar wrote: >> Currently, =
build_amd_iommu()
> uses "addr" property to build the device ID for >> IOMMU device and
> advertise it
>=20
>=20
> On 7/31/2026 3:20 PM, Michael S. Tsirkin wrote:
>> On Mon, May 11, 2026 at 06:09:33PM +0530, Sairaj Kodilkar wrote:
>>> Currently, build_amd_iommu() uses "addr" property to build the device I=
D for
>>> IOMMU device and advertise it throught IVRS. But this property does not=
 encode
>>> IOMMU bus. This will be a problem if IOMMU is attached to different bus.
>>> Hence use iommu pci device which provides bus, to build the IOMMU devic=
e ID.
>>>
>>> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
>>> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
>>=20
>> But is this called after firmware has enumerated the pci bus?
>> And I guess OS better not change that bus number eh?

The above line sounds fairly threatening :) so I dug a bit more into the
details.
Short story: I tested placing the IOMMU behind a PCI bridge, which the
implementation currently allows, and the guest can (easily) change the bus
number. That changes the IOMMU BDF, so the DeviceID encoded in IVRS becomes
incorrect.

The spec doesn't forbid the above scenario, but "strongly recommends":

=E2=80=A2 An IOMMU should be a root-complex device (i.e., appear directly o=
n the
bus at the top of the PCI tree hierarchy).
=E2=80=A2 Some system software may prohibit an IOMMU from appearing under a
PCI-to-PCI bridge.

(from Section 4.5 Software and Platform Firmware Implementation Issues)

While I don't know if that is the case in all HW implementations, my
Genoa/Zen4 system does follow the recommended topology i.e. it exposes all
of its 8 IOMMU functions directly on a PCI root bus, with no bridges.

So I think a reasonable choice is to enforce that an AMDVI-PCI device must
always be directly attached to a PCI root bus. There is precedent for this
in the virtio-iommu implementation already, the code change would be
basically the same in amdvi_pci_realize(), see:

e72cfabf4ef2 ("hw/virtio/virtio-iommu-pci: Enforce the device is plugged on
the root bus")

MST: does this address your concern?

Sairaj: Am I missing anything, perhaps from your unpublished patches, that
makes this approach non-viable?

Thank you,
Alejandro

>=20
> Hi Michael
>=20
> Yes, the ACPI function is called two times -- during qemu initialization
> and firmware writes. During first call, bus numbers are 0 and during
> second call, IVRS is created with bus number. This second IVRS
> overwrites the first one.
>=20
> Thanks
> Sairaj
>=20
>>> ---
>>>  hw/i386/acpi-build.c | 12 ++++++------
>>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>>> index e4ad01eec037..718e3f546b18 100644
>>> --- a/hw/i386/acpi-build.c
>>> +++ b/hw/i386/acpi-build.c
>>> @@ -1752,10 +1752,13 @@ build_amd_iommu(GArray *table_data, BIOSLinker =
*linker, const char *oem_id,
>>>                  const char *oem_table_id)
>>>  {
>>>      AMDVIState *s =3D AMD_IOMMU_DEVICE(x86_iommu_get_default());
>>> +    PCIDevice *iommu_dev =3D &(s->pci->dev);
>>>      GArray *ivhd_blob =3D g_array_new(false, true, 1);
>>>      AcpiTable table =3D { .sig =3D "IVRS", .rev =3D 1, .oem_id =3D oem=
_id,
>>>                          .oem_table_id =3D oem_table_id };
>>>      uint64_t feature_report;
>>> +    int iommu_bus =3D pci_bus_num(pci_get_bus(iommu_dev));
>>> +    uint16_t iommu_devid =3D PCI_BUILD_BDF(iommu_bus, iommu_dev->devfn=
);
>>> =20
>>>      acpi_table_begin(&table, table_data);
>>>      /* IVinfo - IO virtualization information common to all
>>> @@ -1816,9 +1819,7 @@ build_amd_iommu(GArray *table_data, BIOSLinker *l=
inker, const char *oem_id,
>>>      /* IVHD length */
>>>      build_append_int_noprefix(table_data, ivhd_blob->len + 24, 2);
>>>      /* DeviceID */
>>> -    build_append_int_noprefix(table_data,
>>> -                              object_property_get_int(OBJECT(s->pci), =
"addr",
>>> -                                                      &error_abort), 2=
);
>>> +    build_append_int_noprefix(table_data, iommu_devid, 2);
>>>      /* Capability offset */
>>>      build_append_int_noprefix(table_data, s->pci->capab_offset, 2);
>>>      /* IOMMU base address */
>>> @@ -1850,10 +1851,9 @@ build_amd_iommu(GArray *table_data, BIOSLinker *=
linker, const char *oem_id,
>>> =20
>>>      /* IVHD length */
>>>      build_append_int_noprefix(table_data, ivhd_blob->len + 40, 2);
>>> +
>>>      /* DeviceID */
>>> -    build_append_int_noprefix(table_data,
>>> -                              object_property_get_int(OBJECT(s->pci), =
"addr",
>>> -                                                      &error_abort), 2=
);
>>> +    build_append_int_noprefix(table_data, iommu_devid, 2);
>>>      /* Capability offset */
>>>      build_append_int_noprefix(table_data, s->pci->capab_offset, 2);
>>>      /* IOMMU base address */
>>> --=20
>>> 2.34.1
>>=20
>=20


