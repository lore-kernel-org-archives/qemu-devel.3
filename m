Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D0D606A321
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 08:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=LBIEuiXK;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=H0SXEHio
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQLB8-0007wY-Rb; Mon, 09 Nov 2026 03:56:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xQLAz-0007q6-Md; Mon, 09 Nov 2026 03:56:31 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xQLAy-0001cZ-5V; Mon, 09 Nov 2026 03:56:29 -0500
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A96A80V653093; Mon, 9 Nov 2026 00:56:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=iWR3R6U82MieWXN4geR9NFCQCkLz4cxQTdxqz35q7
 I4=; b=LBIEuiXKEC11HnynxfTtA+vxOj9PKtPAxgm7j5+eGQt3sISyybHHPGjVS
 RxeM9rvU49qaYvjX9HUU8I6ZxjyWgoc4pOoP3He8Rdw+D0vd6rjIZf/O/7mVVj7h
 7f1EqOPBLdQ8G4dMB9iTLp8BjIDlpG2i6Om6HTMJuAyUXy/yq4lP2mzzYYzicr8Z
 vi2brhmaPkjAaUeaqwyq3tUi5sr5Ra8azRxy98sqjPWp00xg+efHFU8ZK1WOoCQz
 MkNe+my942w4fysvWq9ICzTX2n4ZwF2l1InV2uzkicgG2enI1ynj013eM/gp0g8C
 ufp2/tzPKepT5jMEsESgehebfeSpA==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021135.outbound.protection.outlook.com [40.107.208.135])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4ht2ymtdex-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 09 Nov 2026 00:56:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xQL6zOznKkhEBvzV8lSNC2sTCOsn/YUZT0lYxSn1/Lg9f8N1smT+SXGkiDlvbG6wje2HPRPupsv5UOOUH1sIr4ZyFZymM9DaL1sEUDmNW+w3LSccfwhwQWAe07EUvtSt3MxtaQAo694mxiv43E0XVlUQjjCmi8KX/WnvWqiA1w6KMzn1lpEcLlwT/MifVOXhmWKqzR28zJ9gsySaDUA/P351s+HjHs2Ne4QvGsHNeeRZ9WF9/Mx6L0wV8ayEKtJJXx45q4cR+jBClMZW411lWXGugcNxAwQ43c4+kPJieoZcclDX/+t2YLKr+jb3HuELhnfweDqjzNiWfKBGPxXq1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWR3R6U82MieWXN4geR9NFCQCkLz4cxQTdxqz35q7I4=;
 b=gz5eYqRNnW20iCj+Wr5Pe9bAHyL8REZiR7S91DlN5FSrz3CRLuMUCsulR6Fh0Avq78jCW+2zWC6Uqyg5/MbXMETHqyN5b5wn+JZK66jz+EL2lFUBvzlVX7t6we+mGxc9utFhaht3H7KwIsYpNzlK4zVOm2koEzHkUTYWJSZWr7M/obsKAX4XcZxbnAGDBO9aDf00SHXz/8kNQvx96p4JWgbJFLQmURIyQdqN10XeqwExuHTDPeQ1bQrSuSid02smHRLNw7zjvG39uvGYZwOzdOa4S+AIEsq5atsaP3eXXiUjuqr7mttdwcLXQOXCAioFo6pbQ+482uLQMacIcZrMuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWR3R6U82MieWXN4geR9NFCQCkLz4cxQTdxqz35q7I4=;
 b=H0SXEHioZhyLYOgerZfdeBsZ20SJ+SJozwkM1ZzfahBSPnG3YAILj9X5wtuuddL6kzATOUkwvA4f3pjFT5lp+pdPdTE6LqdYpfQuYrc9XX2kwEf9OQPmawelL0LRRtMuAghZNIRnyeql6zDi1SgeFP3qWnjAOYMZr58Bw4B+BS/A+PAnINM8tnLX+QvCQLTGSl+D4EIZsPUbyNcWL/PUraFhmvZTSiBaPQGA2PyC2EUCmCovJYGMzlH4w+T3Tp1V45+VA0OO4R5oIW2Z/Y6MqSaOuHYkdSedC5SgBdJlqQCc2Q96xowaQGiuvixgqhUww4koGqWpnmA5D8KdbpcZWg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from MW4PR02MB7153.namprd02.prod.outlook.com (2603:10b6:303:65::11)
 by DM6PR02MB6953.namprd02.prod.outlook.com (2603:10b6:5:253::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 08:56:22 +0000
Received: from MW4PR02MB7153.namprd02.prod.outlook.com
 ([fe80::2d8:c73a:b2f9:f1dd]) by MW4PR02MB7153.namprd02.prod.outlook.com
 ([fe80::2d8:c73a:b2f9:f1dd%2]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 08:56:22 +0000
Message-ID: <f617dcdc-0afe-4e22-8684-b6ece879e7f0@nutanix.com>
Date: Mon, 9 Nov 2026 08:56:17 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] hw/gpio/pca9554: Simplify QOM type creation
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, milesg@linux.ibm.com, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org
References: <20261106110440.3552588-1-armbru@redhat.com>
 <20261106110440.3552588-4-armbru@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20261106110440.3552588-4-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::11) To MW4PR02MB7153.namprd02.prod.outlook.com
 (2603:10b6:303:65::11)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR02MB7153:EE_|DM6PR02MB6953:EE_
X-MS-Office365-Filtering-Correlation-Id: e6a84dfb-e0e4-45bb-e32f-08df3e3f53c9
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|10067099003|4143699003|5023799004|261102123227099003|56012099006|261021121427099003|261021123027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: mJibkkpnYI988TbCzyOy7O0K6GKA2MxBQIyhaRGvDeVsknyGlsTh/Tu8VMTUem0AibvUQ6eDMp2oMy0aSBnQ7AcYSszJO3AzW2otIT3eUo7qCK/PSeQDniMZsy2W8LWpilhCxvtfs5vQ1wlNQ2BtXD27zVL3u7RQxfGx9QtqdeRjACPHl/Z8ujVvtet3XaaMSjzPtYcHJJ5Tlj7fVR8PgyckewnyvkttBBfLmHM6UPWU6F1uroQDrfgidUbQ4qwrB0SagRnSErBR+p9g2xp0C28XMpiQGDUze4RLCi7m7IyKoKnjPdau00MhISbS8/MZN9vlwN+LmbpdTnNG5vi8fgZN6TbmCugJI8WzP1wCkpTFhfnzyEJzdcbKf/RzGGKt9TSoZGf5DpwaiF849HtMk4JJXVjsNf9tmSU1rzjq4vkUq3M1bjmV518hWAkSXzPNAaHhjIrZLEDCIFpyphuL6EWHMmPXM3GIeC0pVqlQXV02bly7yiOn2nWA/Yh7ED/9db2VswZ7FK0c5iuh5ua2Kzaj+PwgBiezdA40sn4NLYHLAZ/FN5isPj6+L8VG1DRM6j6xsCzCG7Kv80GOK/T0oIFRREsGGIBCd7Z0W2Z7GO9eqK1enyXT5QX4JBsNW7mzkVUy8/I4jMdhLeQKSI4HDpRkhB0lQovy/dPaSUPqotM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR02MB7153.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(10067099003)(4143699003)(5023799004)(261102123227099003)(56012099006)(261021121427099003)(261021123027099003)(261009223027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blpsQWNOb2lZcHBEYjFRZ2RUR29kOStXeGpuZWRjcGpkYjFoS0dlYUZRWEF1?=
 =?utf-8?B?bFk5dmZXb3BJMXlLU3RaN2ltVWpFNXAvZDYrSlRqWmxjdURkNS9mM3dac20v?=
 =?utf-8?B?cGx1Nm5QaENoK1lDY1lGbTNOK1VSck1KWHlDbE1DdzNNOGw1TDc4VjNwaE5k?=
 =?utf-8?B?VHJLdXhsRUZieUN3bU1BSUo1ZWRJbzR2ZkErN0NzNWJHY09Kb08vMmt3bW03?=
 =?utf-8?B?NzdhNnk0UlZBS0wrV2RYOGNWY29LejNBNUVnYWlNclEzdXRrRXMzYXJHWGdL?=
 =?utf-8?B?UExsZys3MVRLaEF2SjI4bTg1YmtublBWUFZTd3lQcFVSdm1rYlpLMlptVjhp?=
 =?utf-8?B?U21DdFZzSnFPL09CMFhxTHF1emlDdDJubUZBbUIwUU1lNEFrOHpWT1VSVk8y?=
 =?utf-8?B?VmhPVjZqWDVMbG03czF2cFNNMHhEaXBFdzdyQ3JZNHYxYmFSQ2EwM0h6WXV6?=
 =?utf-8?B?ZEduWThucncxdUlYM0l0S0dsclZGZ21aMTJUME5PTWdaMUgzbEFNZHg0bDNy?=
 =?utf-8?B?aXBnM0UyWTZwVHVHY0NjcVQ4TVM4b0dSVGVKbXNwMFlTcmxGZkxhM2phWTNV?=
 =?utf-8?B?ZXlNR2g0ZUdnYTVoWTEzVzVMdHZSZlBMSzl3eCtTMjJkSmUvWUJFWSt5dW1l?=
 =?utf-8?B?Q1BBOTBZSStaR3ZaTnFSMmVUc01SM3lCN2w3TXpqL1hHM2JHakN1MStwWmFn?=
 =?utf-8?B?MUFKK3N6UzNLTVJBZnRuK2M3cDlURHhoaUlKR2sweDhmTHpnMkE5R2JrNXFV?=
 =?utf-8?B?UHBBcng4K3FNWjZrU1EzcVBTb0pKaXI1TU9hcy9TbmNFZm9VdEc1V3VjeHl6?=
 =?utf-8?B?VU9ZLzV6VStqUUQ3R3hPNXA1KytsMCtkUTM4OEsxWno1ZXRQSEc3OURiSDBN?=
 =?utf-8?B?T1pEeElzMXUxakNVVVdjdnU1QlY3d2pWaHlTTU4wVSs0U1puYnM1d3NZWVA3?=
 =?utf-8?B?WWFUc1o0WHRjTkVmb2I1SytWZ1AwWmtDNE1iYU5ZSzQwNWxTTGYrcndEaWRC?=
 =?utf-8?B?SXl1ZXMyUWF2NlBqeERNZGsrSUdudUtLc2JnNit3MUtKN2QwZVBEUnQvbEdt?=
 =?utf-8?B?cnRGWkdTNjdzQUQ3eWN5M1pFdU1VNUFramMyQTVMYVRKeHZQbnc2Y0tFRG9K?=
 =?utf-8?B?Uy95WXFQTERNVDlSNkFYZEc1NUo1Snl2L0JIbDZpdXJvckVmR1pMZGZ0aWVm?=
 =?utf-8?B?VEFtWUYyVWlwZ3ZLNStjMTZaVUowcklCZE93QTJQZWpnNzdyYmJNM01HdzRm?=
 =?utf-8?B?WVF4b2FzQ091RWo1bzJEUWZSVDNLWFp0dWNFcDZRSk1xZjRLOFh3SHhhS2p3?=
 =?utf-8?B?ZUM5V3M1amNZQlRMTlpDc2VEemJ6dWVUTHRpSU12YTZJWDBVWnJqc0U1dlIz?=
 =?utf-8?B?dzBteVllNmY1K3FSTkxoUW8xOXVyY1R2aUZRRFA2aUVEZlRHTTVwOVJlaUhu?=
 =?utf-8?B?QU10M21HYkVlT3hYT3J4VTEzZmhlOWljN0J3NUZxQ3V5UUVRcSt0dlJaWk9Y?=
 =?utf-8?B?cTBXZDFxSzhWNE9YMHlYcERCc3l3MXRGQU5RTng3WjUwbzhRNTRWYVRkbGJ6?=
 =?utf-8?B?U1M2cnBBQUF6a1dhN2tHSENNZUxPY1h0NWdsTXpsbUQzYm5YTE55SFFWV3Jh?=
 =?utf-8?B?OCtJcmJMd3Q1N3FkNUtVM1JzK1QvVkNDK1VJQ1JxVmpjaWYxYm4yK0I4QnI5?=
 =?utf-8?B?TDFzdFVuRDFRUnBqQmtIYnZWYTA2R1U2SWJKZks2LzNGY05PTGh3aEJLSW9E?=
 =?utf-8?B?cGNqOFQ2NWpPN0FiVTd3UFE5dUh3b1ZhVll2a0dQMFg3eHBRaFNWY3hsclU3?=
 =?utf-8?B?T0R4TlJKcStvTkVGQTYyK2FRR2M0UDNodXhpUmFjVjFYMGR6aUxQMDFNU1BJ?=
 =?utf-8?B?K05nemhJU1A5Vk5ocDlta2J4K0FBZG5vcmhDNlkvZ0hBK1llUHZRams1VExm?=
 =?utf-8?B?TDVZK3JWa1ZkSE5ObWxweFozS3E4cXBSVGErbFBVclJNZWF3bjB5V2Q2Y1pa?=
 =?utf-8?B?U3VDTTFoNmpQSHJHa2UzU2ZFU2o0UHRaZ3JSaHp4N0ZoU1ZPN2VGeENxeDJP?=
 =?utf-8?B?cTRsSTRyR3M0bTVJbnRqdVNpa3VyZVVCUjAxUW1JUFVaSVVFOG9nUWxXWGNJ?=
 =?utf-8?B?dDR2c2F0RGZZdlA4cWRCT1JpVHVHQ1VvdGtRUlR6OGh4RGEwbGh4aUtCV1B0?=
 =?utf-8?B?TElFcUswQXg1ckNpNlRDNGFqUlJURURhTGgxUlV6c3ZEMHgvMU5kWUJiQ2dp?=
 =?utf-8?B?dytCVFcyYURtYnY1elRFUGtHVkI5UVhXRWZLeG1KL3ROMk9xRUVkTWV4Kyto?=
 =?utf-8?B?bXZNRlcxU1BmSnk1c3hPQVIzODFxZUxWVVVwTFRCN3F5MDN6RVVaVXFYTytI?=
 =?utf-8?Q?PgmjCILxcCTlYGzI=3D?=
X-Exchange-RoutingPolicyChecked: SQTBUZaQQ1duJ4KkO/Urjv+aJ8Al0zSDCWYhQ7/8VKSEs7cnFAi+79+ovmeh0R04mpwzWbS5gDPof+ZDyI/UfSQtPP6Y3YY3s/4wR3p9XsGPYZkybGloI0a6u4qQGNHG4FU/1yQLyK3k6in0YgUoFH+dJyt2EFh8UDelww6NPCt6G7oLqYdsbWEBf/xZBPV4W7hNKIcqOrhLcWTj0WHtg1XbdYNdBANNfJz2BhbIM2oneXlj9uBsL+h2b+2hpvRc9ANx+lT/dhy9QR+9T+ZOL1TawZ6vEpD1kni1D7L6YoMhUXeE6GEulGjbI+5DemEDYWo2uISwTzCjdBa+IFa0jQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6a84dfb-e0e4-45bb-e32f-08df3e3f53c9
X-MS-Exchange-CrossTenant-AuthSource: MW4PR02MB7153.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 08:56:22.0603 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cH01gGnTNEPtsglAmT2f4t7MQJF8e7h5uVDp386TIR6DK+Gjp13w/iHY1xXxMFndo+jy/9eU9GqUAX4JRsG2xZgEduSNPSuQT/6mgvl6mGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6953
X-Authority-Analysis: v=2.4 cv=HORWhYtv c=1 sm=1 tr=0 ts=6af18ab8 cx=c_pps
 a=49tiPNKudA41XY8u0CHlaQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=dEe9Ve2bX-KnNSUMM2s9:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=-7gIxdPHnDxpSC36y9IA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAzNSBTYWx0ZWRfXwH2W3/lVWlbq
 le6i4DeaI/or1azA+Yke0e2j8nDIrXVy71qopSsJ093O259MfnW/OwYrYXjnwJbmQqR49lF68A9
 8VGYcx3f1R/TodVsNvx3JgEODM/VS2qwxltNg5k8nifEMP8aIeAW072A/pl4VtLJonF1JzfFIrT
 m6ml7n4g1v+NV5PGwwWjLZ8LO3LGLP3nWA2sHPrxxUX0xp0gxUxmkXRmfLMpex/azlYWIi9m5R7
 fpxG0YaciPDmsySSX5auRohkWu/jROY4yOQBKCySjP4GxIUGJMtQbOInH1B/RBLD+mBVG7wPRB7
 DO8iQ3QE8GM0s0m0oM+XRnkzPphGZaNVS0vurvpydlQFjLEJg/BShvD+Td+1Rm51JJHQjr/5389
 N9QYGQ9zPAh0QYmYy2FcmvWBCJQdiIyjwPi4QfuBJU2TpuwR1CRYox+NfYK32+DJHxsPy2nQ5Qi
 /VcxNDdVanrC8b5lZag==
X-Proofpoint-ORIG-GUID: nDjgVTdTp66xvl_L4HsF0N8sSfROujc_
X-Proofpoint-GUID: nDjgVTdTp66xvl_L4HsF0N8sSfROujc_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAzNSBTYWx0ZWRfX3N+P4ZGFIKIB
 dB07DNRwMjJHYQOk9ySEJpSQv9JK0Idpth+Ht8Tul7ITgKIp0PuvMCK/6kDYY52ueTvreN0qp/l
 aFYGQ/cK2Xy5GdhhEvXAtQZvUKQ7Xgw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 06/11/2026 11:04, Markus Armbruster wrote:

> According to object.h, direct usage of DECLARE_INSTANCE_CHECKERS()
> should be avoided, and the complete OBJECT_DECLARE_TYPE macro is
> recommended instead.  So use that.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   hw/gpio/pca9554.c | 10 ++--------
>   1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/gpio/pca9554.c b/hw/gpio/pca9554.c
> index e5a1932c89..caa73f63c9 100644
> --- a/hw/gpio/pca9554.c
> +++ b/hw/gpio/pca9554.c
> @@ -22,14 +22,12 @@
>   #include "trace.h"
>   #include "qom/object.h"
>   
> -typedef struct PCA9554State PCA9554State;
> -DECLARE_INSTANCE_CHECKER(PCA9554State, PCA9554,
> -                         TYPE_PCA9554)
> -
>   #define PCA9554_NR_REGS 4
>   #define PCA9554_PIN_COUNT 8
>   #define PCA9536_PIN_COUNT 4
>   
> +OBJECT_DECLARE_TYPE(PCA9554State, PCA9554Class, PCA9554)
> +
>   struct PCA9554State {
>       /*< private >*/
>       I2CSlave i2c;
> @@ -52,10 +50,6 @@ struct PCA9554Class {
>   
>       uint8_t pin_count;
>   };
> -typedef struct PCA9554Class PCA9554Class;
> -
> -DECLARE_CLASS_CHECKERS(PCA9554Class, PCA9554,
> -                       TYPE_PCA9554)
>   
>   #define PCA9554_PIN_LOW  0x0
>   #define PCA9554_PIN_HIZ  0x1

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


