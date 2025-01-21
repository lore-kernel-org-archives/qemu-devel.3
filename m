Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94621C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 18:39:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taJ9O-00057V-Ct; Tue, 21 Jan 2025 13:38:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1taJ9I-00056y-Mg
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 13:38:54 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1taJ9D-00036J-Uw
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 13:38:51 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50LFE1kX024270;
 Tue, 21 Jan 2025 18:38:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=orBTqL76Xz8hN7QdFGAy7EwJz5hEVywXYdAAMe9kWxI=; b=
 Q9SE6qRbqO4eIUckL1jBHg1zr22Sh/Y2+WOU1dfC+WFuszgn0Wkn8K4L2bWNP90e
 FIW1FOgpr/QdcVxUMz6qNamDuAdejIApGO8cH1GyBu1raDjRgcDrjBE90iu//VAE
 hixgbA1W11nZjN5CGdjWFxIl8+IKRgCr7Anty/Rwyp3mNH8Ch9QAMhxcibS970O4
 hHdweptougGHWrpTv+9mZJMmFoOhozI+mHdnMixxIbeadXnj/NegIu9Lmvf9aAaD
 /RbUyfV3aNe7OWL9cc3RfkWLcmiQb8DXCWmHOipHC0ptd+HT+DyfxrstJyC7Oy4W
 Q6W8XoWY+/PuvRl9yCLLCw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4485tm67qp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Jan 2025 18:38:43 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50LHUUol038119; Tue, 21 Jan 2025 18:38:43 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4491a0ct66-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Jan 2025 18:38:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cv29Qvr4eaHlPYvvAoOZZDDNahxzU5vrQFAGJlWUS02tOUKVIXo/Gk2khek5rrF6m4T0mjIiFiQUTXchjSmLDqOK6pwS/5bJ120jaYYCBtXb5q2yDh8PXhPGR6EYnQIwuS5o5wJJ8A4K3W122/PRIxq70UJQG+jJMekHCCcmUL6Vk6WTLaOxsajp5aDpxfZEiCykVcGRZCSrdJTbeYDJe6bOeBXd52oOkU0covMrRjPG9HPGq7l8MjCVUnKZq/UTlkGNIvwVLlBmrcLu0RAFlkmULEbDiSZHxvDo9V4ELpnNK5B6SQKp1erbVL10aVf7P4iraP+73cCPB8pJ+VpBZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=orBTqL76Xz8hN7QdFGAy7EwJz5hEVywXYdAAMe9kWxI=;
 b=Z56BZ1sZ0rASMOapqeYME+aW9qJcMkG1S5KULwTLXvphnV5k0q+ECkU4O8Nz1qAn81/G+zdlogsacKeoKVOV7X5ip4PR44lwBykxBqVdh+2lzw6p6Ou6BaE7qWPjz8OXr+GmfpawW5I2gsWTtDkh1ehGTNIteTgVsvFEKpB43J/a3ZErYFedX3QK+CHBLu78rEajG0DuNuGiiM3onCy0WjjqJaMmMM+vlZTYzyghr52fpKKxf0uAvpwBLoa1FQIk9HPcLnYyP/BxqTKZ9wDSy2wYJnqVyRI+5G2lPlpkW7RESyAr63mBirlHDtkB39WjbRnlaWQln5w/R02SPzC2Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orBTqL76Xz8hN7QdFGAy7EwJz5hEVywXYdAAMe9kWxI=;
 b=UnWNbbMmdQ2g/uW13SQT+22cHgRJoItuKWX7MtMyCtVsKOWbrvxZRo5Rxukfl4Qlmfj0yowhdIoe+8WadASVkKnGCLY6RXoKS47+3XognUVHjmlfSUXKOse81DucZzQo07wutXTfd7d/lnL3AJhDc0ay2TI0m5EO+MS8LLP+E9Q=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DM4PR10MB6110.namprd10.prod.outlook.com (2603:10b6:8:8b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Tue, 21 Jan
 2025 18:38:40 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 18:38:40 +0000
Message-ID: <d9e069d7-ae18-4184-a1df-ac1dcb98bbb0@oracle.com>
Date: Tue, 21 Jan 2025 19:38:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] system/physmem: take into account fd_offset for file
 fallocate
To: David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, philmd@linaro.org
References: <20250121175956.3030149-1-william.roche@oracle.com>
 <20250121175956.3030149-2-william.roche@oracle.com> <Z4_k0u7Gdv5OKa3S@x1n>
 <a01b7a88-6d20-47cc-9631-85d9fdd48a87@redhat.com>
Content-Language: en-US, fr
From: William Roche <william.roche@oracle.com>
In-Reply-To: <a01b7a88-6d20-47cc-9631-85d9fdd48a87@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR10CA0127.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::44) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DM4PR10MB6110:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e58dacf-ba9f-4c15-dce6-08dd3a4ad32a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bEp0aU9MazE2NGEzVnZJYlR5VnlzbzNjOWVIT2hVeU9UNWtnTmNlSmhNdjMx?=
 =?utf-8?B?dE92MU5wVUZwOVZHb2NGd3B3cUsxYVJCbU9PM0VJMXB4YzFBK1RUeXpTK1do?=
 =?utf-8?B?dGJQWEdqY3Nvd21NMW9ZZndJN2dQWm05MlZvZkYxdEpKaXM1RzlrczhWTU9K?=
 =?utf-8?B?cDZnbWJkNjd1cjYwTlZqN1Yxa25DOEVGUVlpMTJmUllaUkYxZW9yVkpWdzZl?=
 =?utf-8?B?U2NzbjB4UXlmbmNGTTg4bU5QcEdoT1BJM1F2dytrMEw1eEN6V2dEd2FlSG56?=
 =?utf-8?B?T0M3ZXdzekQ2WVpESTc2Mk9iWnVZSzh2K2xIRldwSGtHQ0p3dG54cHI2SlY2?=
 =?utf-8?B?QlZvZ2ZZY3ZMOVhKQnRRNVRGTHJ1RnJsbktGWlhGZUZNaDduanJDUDdlWmlq?=
 =?utf-8?B?UHNINDRSMW5mWXVMa3dhcXA4SElzR2YrSzhkYTZOcU1MdjV0d2MweUQ2cDcv?=
 =?utf-8?B?emltWjdEdTVaYVZPc1Z3UjVkWGFsUjNOb3JhZW82V0Nydk5ZMWpsYnFiMnY2?=
 =?utf-8?B?S1JrdTlpbnM4SXBhejhQcHd5cDNOY25jc3FMc3o4d0xnTGhKVTZUL3FYbFNV?=
 =?utf-8?B?NERJSHFqc3dzK25NdlQ1aG96b0VFL3FxY3E2QllQN0hlYnl0TVZZU0Z6cCtS?=
 =?utf-8?B?dGR6emE2U3p0RW5Fb1NnZDgwaEJPRklCTzhnQWtJQkVITGtCNENIaFRqVEk0?=
 =?utf-8?B?d0pKUDZWTGNEa2JQbno2MXBlbUt2V1Q1cnlyTTI4VzcybVN3Y1ZVSSt3U2VG?=
 =?utf-8?B?K056Sno1ejg4WlVidmJGN3FVMjQ5WmM5OXk3ZitIcS9LSTBPNEN2ZXR3bXhm?=
 =?utf-8?B?K1BBeVkydVAxVituRnRtMHZTUHNscUgvQmlrYWJGZHVvSi92MkMxM043WXRu?=
 =?utf-8?B?ZW5keE5EWUdTSllhdUZHRmFSUWYrSlU3SE92MFZCcmU2eVlkL3FSQkJMWDBu?=
 =?utf-8?B?b0xSZk1UYTFjekhZSHNTRXRwUkU4RGlDTDVVOVg1SFFmMUpZVzdNZ1RzOFY0?=
 =?utf-8?B?VVVEOEU0amR1VU9TZlIvVUU5QURiMDVLV0xXQ0NEMStOLzFZdzFESnltRGJQ?=
 =?utf-8?B?YlNYTDNrbTNsVUlvYk4zakdxUmYzTEVzM3FoZ0R2UkZZMFFLNW9uTnpQR3FO?=
 =?utf-8?B?UDZTQWdxcEZ3YXM2QnkyLzR1ZEVzaWhnSDhOQmUvSGtjSFlId1FiQXF1cjRL?=
 =?utf-8?B?bFdBRC9zN09wREhFS0lrVFNuclV6TnRtS2dzdTBwVnAvenJCNVp2NTlxNHJW?=
 =?utf-8?B?cjJBdDJrUWVDSzQrZ21DVGJHTEhDTHRpd25UNGlXc0VBWDFCQkN5cERKS3ZL?=
 =?utf-8?B?U3JqaXMzaTFPaFIwa2tMbFVka0xJc3diQVlGS0dDYTRHaTd3b05MS1hWY1VB?=
 =?utf-8?B?Zi9CSHJHSWVDSFBwb3lSSlZwMlNsMWd0ZUtsaEJXdTB3aUJFc3RNVXNUNzhq?=
 =?utf-8?B?K285aUo2VU1hNU5tK3FyRDhJT2hoczN6V0JGRkZzOXpUWXNvK2hTTmdNTDl2?=
 =?utf-8?B?T2kyTUpreFZpdlpaUDRQKzdUYzNIdTkzTmhkZFlOVGk0aHk3SnlFZTJ6WFBw?=
 =?utf-8?B?blRjK0pCWWp3OHdlaE5vZnhrNXAyYmxSQzluWjB0WWM4NURMU3NYN3V3elRT?=
 =?utf-8?B?SjB0K0dvbGVHeDdiTVM3cmMzcENkWUQvL3Z0a2pXLy9XclduTzJxZ012VUJZ?=
 =?utf-8?B?Nmh0ZTB3cDlSSU03MGhOeXliKzRpVGcvU015TTVZUldXLzZsbTlkZC81UU9p?=
 =?utf-8?B?c3BTSXZJWW9lanBOWG5xcnRaa0phZnlqVW9JN0pHWFpJbVVsZGFjRWFEVlU1?=
 =?utf-8?B?d20zb0dVZW9zWnhVQ3V2ZXlRRWJJT2JqZEZURVd4aUI1S0FKVHFLQ3RvVU1I?=
 =?utf-8?Q?CiHBHhG3V0KRM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR10MB7329.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGppVTNnTm8veERRSHFmZ25kOTZ0dmQzZ3RramtuTUp2WmhhZmdPdGpZY01x?=
 =?utf-8?B?WnY4T0VaVE5sRDJlK1Y4WTUwQmhWeVZDM1dRbFFYbnR6b1FnUXRuZERwem0v?=
 =?utf-8?B?cWUwRHRRZkxUVWt4dDQzVDRmK3FoblI3b3ZzWVQ3UTNGR0h4Z2FONXR6S2sx?=
 =?utf-8?B?N0dQRCtab2lKclRxWjhpc1B6cm00N3Z0eEF4RGQ4Q3JlalhVWHFZZ2NOcFNv?=
 =?utf-8?B?ZTVlNWxkVW5wbmNDYkFnVXRRUEMwb3pMOU1qRk9qS0dIRkxiZHpmdzhkNjdH?=
 =?utf-8?B?WGpXUnRjTzZUY1BSSXA5ZWZjWmRuNjljUnNMSkllcHg4YnJRenlSQzdITzlm?=
 =?utf-8?B?Sk1Ya0txMUN6L0tLQm91WFJOQ0RpcW52ZmVWeUJ3K1JPTnFCTjVIR0VMaUNJ?=
 =?utf-8?B?YlNaUlA3bXhvTlRQdHdoL1g2MWFUUG54bGdrOGpJS3FBOEhTbUo4THJWdUU0?=
 =?utf-8?B?M3p2d2dxdTA1ZFdUMXVEdVZtOXkwZWFPQ3dkR2xRRzBudHgxQnZOUDZ1Wk5K?=
 =?utf-8?B?VnFyTmYxdmxXZXUxRjYvOExSZ1pWMUpEc3Q4aWpscVhTVFhDdWJMeHh1UFhT?=
 =?utf-8?B?c2ZNK3dWRndjRDJCU1M1YnEwRVBvUTVBeFZybzZ3UXkxT1JKb3FhcHl4SkYw?=
 =?utf-8?B?RlRja2VIdVhMSE1UODZJd0RSeFR1bi9hQ2lIZDVjY21vWDR4V2ZHcTZtUlUv?=
 =?utf-8?B?bmRla3h4OHF0WkFPdDFkVEp1MlJyV0tMT0NPZGFqWkcybVZaWUkxV1N6cTBD?=
 =?utf-8?B?M3FwQU1May9FNThrR2lZUDVDTVFPRkpOTWJFanZiTUpYeTc0SWg2ZVNsNUYz?=
 =?utf-8?B?bXUxQm1waDh5ZDVxamNHV1k3SWZ2QmRGWFh6cXQ1RTVjTkZvUDZXSFd6a1Qr?=
 =?utf-8?B?T2F3ejhFRGQwSFpBdS93SmQzTFlVOEl2ckJxeWZCaURmc3JsK1NoNDZGUUxQ?=
 =?utf-8?B?OGc3a1BBUEthU1JSRXNseGcxZU5ObjNlOE11RmJISTl5UVNzb1E1bERzV29p?=
 =?utf-8?B?RWUyMlZUZXNHVVI2TWxOSTlYMGlwY2NvQjg1ZEpndUJpa2NVVlBSWkY4T3JZ?=
 =?utf-8?B?a0NMTmc3TmQzTnZLeW15WGxSK0d2RXhPQkdncXNSbjhCNzdiSmZqNVNLa0FQ?=
 =?utf-8?B?bHVGbk0yeThUYkR1cXljZzVzaXFRdzRtdVk2K2UyWUEyVStya21jQ2xyYUI2?=
 =?utf-8?B?L2lUd01iaDVXeEZvYzd0dld0OERnWFU0cUhLNHJLS2FyQXV3MkZFNU9hZ2pm?=
 =?utf-8?B?ZUdOT2hlUHgvMEd2b0xSUHVHVnRTU0JCQkhZLzQ4NkQ3RU8xOE5vTGR4QStz?=
 =?utf-8?B?WnBXTGFiQnhkNDdTSzhpUCs1cWx5aHZBd0kyQ0dZL2JDVDIrdm1lQTZHN3dq?=
 =?utf-8?B?dFQvM3lkVisrZkdRcDVZTDZsUmh2TGtZYzlIdUdIdXRLMkhzM3VtbTI2QjdZ?=
 =?utf-8?B?SFMxaHlZNmwvSmVCbnR1dVhrS2ZFSFBiMDRUSHdrdTFxUGtMNzJqOGJTQk52?=
 =?utf-8?B?eitzeVZOMzhqbStuWmlCQmVscnVQTFQrNWVSOEpKWE5zTXg5ek5qejBsUExz?=
 =?utf-8?B?ZzRpL1VhQ3RXRTZLTTdSalZVMU9VeXNhcnJpemdIRmVuNHNZc3BTYVZlR2pP?=
 =?utf-8?B?Q1BtL1hIRUdLNDA2RFhobitISEUvWnN1bU1pejBvT08wdkZoMXpXVmp3RXhT?=
 =?utf-8?B?RTNiK0dYc3JLaEcrNzlTVmVTUWdINktRTHpPUzcvdmZlNWZHRnVORUlDRHdN?=
 =?utf-8?B?bUVhSFU1RnVNUWxlb0ZKbWdTRysydEliTHRqSTBaeXE5a3hsdElrdFdxcGh3?=
 =?utf-8?B?dHM0QnBNbjQ4UzZ5SzlqYTh2cGJMRmdxTWJHNDlEM0c0bWxtMUZVSGg5WnJO?=
 =?utf-8?B?MlVJLzdDNjZ3dWl6dTdtaFZoYlVVTC91b3ppU2hMRCtMcktOZTR4VkZldS9x?=
 =?utf-8?B?NTN4Zk9DcjBxdXVqRk1kWGIvdkRaeEI0SDZoOG1uVFUrdU1oU0R5c0MwUUli?=
 =?utf-8?B?VGxNUURpSldNa2dMZ3JrNHVwZXBsT3R6SzZKdzRHYmdydSt5L3ppS2kzOWlX?=
 =?utf-8?B?dGFXUXl4QXVScVYxVHB1YnRyUFd0NFcxdERwSzl3dlhSWGxXU0NQdHorTWwy?=
 =?utf-8?B?WENrVWdsZWtGSFJiTm9TQmZNUG91RG9La0dpNFE2UTU5bUZycHV2K0RIY1kx?=
 =?utf-8?B?ZWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: a1xyvfb8v013pJmATm94AHTrRPWaMVu24sY17CG/Cthuq+QuMHhCprK3TLIntaG7h6/nHtS1ioLEpfGKIMFTTvjVslyXYP5ammB9jWnn+2bELqTHu2cmde5Yoz1utifJQ7CAqq3cddT3lrOq79xQYXxCr6d7Pfkg+1dA0LbGfxpDBpvQKbjBZ89R35nDxnBQlmSUGefHBWlCdadhUiqsuagL1dJc+0Mf40J/NCv3+SLABm0Fo5Np0jCxmX26xqT65F8dg+dpj+/cewspeRpaspRirNwqDUl717sCbrTMmGsZn0kbrT8xCGYgujIQV/VxS+hzJXE9raxrWYwhevaBt9c+IqMMAEpIwdOuuiL71iGr19KaNOg4TqBfjaQaaZi4rNfMFeuTJI/BHai9sCrgygKWq49Lu1ZZYMxUdB9N6FNE2eP4yC4HGosmO3w5SmI5snA2bJlEyuT7x3WkPDFGKk2LgajohHbRQuXo9ZLXfdIS5V/+3ehcyGIMTd+SYpuL/KAgjCiRpRSoSLRrf1zkU1aY0YMnWJvDN6SVUK6JyCL67Mj+qtdEVGgvVY7cz2zZEXW4DnUuiTYLxF7A3xvpkwScOZc/TgVsnRHmPyHIeIQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e58dacf-ba9f-4c15-dce6-08dd3a4ad32a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 18:38:40.3764 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JY6YYwrgmPVicDysLtnqo/v1GFR8JY2ArzIi2Lp8WGS1bSFvQe8Y5pIyvPyP0d02ERo5BVblZoyl79lQxno9uOFoyWH6aMTSQorRjBwd3ys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6110
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-21_07,2025-01-21_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501210149
X-Proofpoint-ORIG-GUID: pnD5yF8mLtD9iI5jSbKkSzqSUbpsC1Pc
X-Proofpoint-GUID: pnD5yF8mLtD9iI5jSbKkSzqSUbpsC1Pc
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=william.roche@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.086,
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

Thank you Peter and David for your feedback.


On 1/21/25 19:25, David Hildenbrand wrote:
> On 21.01.25 19:17, Peter Xu wrote:
>> On Tue, Jan 21, 2025 at 05:59:56PM +0000, “William Roche wrote:
>>> From: William Roche <william.roche@oracle.com>
>>>
>>> Punching a hole in a file with fallocate needs to take into account the
>>> fd_offset value for a correct file location.
>>>
>>> Fixes: 4b870dc4d0c0 ("hostmem-file: add offset option")
>>>
>>> Signed-off-by: William Roche <william.roche@oracle.com>
[...]
>>
>> We do have plenty of fd_offset bugs then.. this makes sense to me. 
>> Nitpick
>> is we could use a var to cache the total offset.

Ok.

> 
> Agreed that makes sense.
> 
>>
>>> @@ -3748,17 +3750,17 @@ int 
>>> ram_block_discard_guest_memfd_range(RAMBlock *rb, uint64_t start,
>>>   #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
>>>       ret = fallocate(rb->guest_memfd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
>>> -                    start, length);
>>> +                    start + rb->offset, length);

I also had this nit - as I should have used rb->fd_offset.

>>>       if (ret) {
>>>           ret = -errno;
>>>           error_report("%s: Failed to fallocate %s:%" PRIx64 " +%zx (%d)",
>>> -                     __func__, rb->idstr, start, length, ret);
>>> +                     __func__, rb->idstr, start + rb->fd_offset, length, ret);
>>>       }
>>>   #else
>>>       ret = -ENOSYS;
>>>       error_report("%s: fallocate not available %s:%" PRIx64 " +%zx 
>>> (%d)",
>>> -                 __func__, rb->idstr, start, length, ret);
>>> +                 __func__, rb->idstr, start + rb->fd_offset, length, 
>>> ret);
>>>   #endif
>>
>> IIUC the offset doesn't apply to gmemfd, see:
>>
>>          new_block->guest_memfd = kvm_create_guest_memfd(new_block- 
>> >max_length,
>>                                                          0, errp);
>>
>> So my understanding is no matter how the host offset was specified, it
>> ignores it at least in the qemu gmemfd code to always offset from 0, 
>> which
>> makes sense to me, as gmemfd is anonymous anyway, and can be created more
>> than one for each VM, so I don't yet see why a gmemfd needs an offset 
>> indeed.

Ok I'll remove the ram_block_discard_guest_memfd_range() modifications 
but include a small comment indicating that we ignore fd_offset in this 
case.

> 
> Right.
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>

I'm preparing a v2 that I'll send in a few hours.

William.



