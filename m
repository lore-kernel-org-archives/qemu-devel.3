Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30422C52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 18:50:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdwb2-00009u-Km; Tue, 13 Aug 2024 14:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sdwaz-000053-KD
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 14:50:13 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sdwav-0001EJ-3K
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 14:50:11 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47DGBUNB007407;
 Tue, 13 Aug 2024 18:50:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:from:to:cc:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=3BK6p7T36cnVRVytnIWDzp5oxGyVVDamOGDUszMi1cM=; b=
 kF2UaiSz+IsgwnNrCwT6WHeVGEJK4sEgDvbAPBRtXEVCXCDNqL0iHd5ZAIrYZcHP
 7fDU1ZnK+okjEBLknURXoQytsZ/Enz2cMAYo35V4Jb7mu/QtDbHBF1eY1rcQ/Zel
 wKNr8BxypNLCqBuQzCl1HMwQHaenNvpg5pS3vds21/d12WnN5utyvaG/nJbYPosF
 UpnUKwJiKFacVv32cQruFEgbw5v4/xADNBheCsO/zSNG09vMGsptLJqZpHmcPf2D
 O9fySeKxxL7hTBpR/h/yGUccyCapceUWy8q04hW9WOsk/mYk0Sx8d/HPGeo7tbWL
 Yp0HjSy3sq2WcoUPa4A83w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40wxt0xrms-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Aug 2024 18:50:04 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 47DHTlP5017681; Tue, 13 Aug 2024 18:50:03 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 40wxn9up19-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Aug 2024 18:50:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AZKVpPSxYDIJSVraX872uDoJew3xhlVcI1qZQAWojgtIgE+mkzxsa9J16juFVsVRFFfV23XhZiDDDhE6uYGm1aWtBCs7gp/gj/iZFd5d8VMUu5hvWLnRM+kLRekGgFEc9S6YDH9034njR8sy6nxcMGf7bCOllQPs5M03W58Zv/Dgl/nc4FQZIq6KA6UPY7QCNHaDtt+CQhnZSWY+5IUdT70eCi87ppXJG2Xcp1U6vDXW2XkAH1aqp64Tph8UdqDoS1fNJtKHALzrWDJj1xKkeVoZdW/20A0d+hICS2/uzvOrq/UaIozSZh888OCHgkBmW6qh5KEeW+7gDLkLPYjhBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3BK6p7T36cnVRVytnIWDzp5oxGyVVDamOGDUszMi1cM=;
 b=IbepcVwBEonBC/WGWQIcOOaeTqirr+GxTnNr6vEyGMX+bSk9vkbdW4HqVu6GInJVXMjJLY0FzvhFHqGNj1erOe9cU6YMjwQRt56lkC0H6I/xUeQYtoA9OUG88jD9lmLimwOosJgbRQ5ImY9QpVy3aqabsZ36IwdFTp8P2x4Bc5M34AYY7G2fk170dj+SZU0ql6Opz9HvRbDdsG7gQsxvGRSJVq54FFxg+nKfpBLSztq/v++RxHlvbQP5mSfkgd89bmHbYTxGjLYnrdGcIBYPBqUl9p466Ty7uHMUdzPhUnenFA21ficUEvCXP7W60KWS5mBiLTuAZy0P5ymhLtvqQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BK6p7T36cnVRVytnIWDzp5oxGyVVDamOGDUszMi1cM=;
 b=l+P+8ROe3TA7YR/f2rsU0OCpeVSUR/ORQZxzz9FzFzggPQEOkKtRwANHzTrUmHU1/Ur2FkacR1joq2YToG32wnBlcj+656V5bn1sF6cj/nZFlYcMTymmOeSQIRVpJQivFModcNmjsZEdlb53pNezjT3R7PWW1kN2zrz6q7uFdKo=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CYXPR10MB7975.namprd10.prod.outlook.com (2603:10b6:930:d7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.16; Tue, 13 Aug
 2024 18:49:59 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.7875.016; Tue, 13 Aug 2024
 18:49:59 +0000
Message-ID: <1f4338e3-595d-4fbf-81ea-56c109fe3c90@oracle.com>
Date: Tue, 13 Aug 2024 14:49:53 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 01/11] machine: alloc-anon option
From: Steven Sistare <steven.sistare@oracle.com>
To: Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>
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
 <20240813110037.6f04ffe9.alex.williamson@redhat.com>
 <8083e11a-365c-418e-9d5d-de4529c48c71@oracle.com>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <8083e11a-365c-418e-9d5d-de4529c48c71@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0130.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::15) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CYXPR10MB7975:EE_
X-MS-Office365-Filtering-Correlation-Id: 48f7fb8a-9e3a-4c71-36c0-08dcbbc8bba7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N1pkK1gvdlowdFd6R3ZDWWczWE5NaTJBbGM0QmxGNzdvQ3lBZHRkUTZSdHJC?=
 =?utf-8?B?OW9mbnc0dXhuS1dicnd4eHpaSkVnbDZaRkdieFlmQlBwRklEM2twdVAyajVD?=
 =?utf-8?B?ZyttM3JiQ2ovWTFldXM5V2N3dkd6VXJCYXFtV2IyOWxmYnpkUTNBazhJMTZR?=
 =?utf-8?B?cFcrb0ZGSFU5Zy83aTB3UFpXM0FLVVFwK3pHTjBFamIvVHUxa0JBUEl3d2tF?=
 =?utf-8?B?MWFYTXZiNnNGdituUXNFZWl1VkhMQWE3VzVQSHRQVkl1ZHJOUVRHQXJLMzIr?=
 =?utf-8?B?WXNyMmcwa0NlWXE3bktKM212M1VUVWdNUUJXVXRrMHZBYVR5TEhkam5ERVFt?=
 =?utf-8?B?NHRTN3JTbkNhODFxT0hCNHBrWVU1ZW1Nd2FMeUJyb3BuZHhLVUM0eHVuR2Ru?=
 =?utf-8?B?OStPZllEWWUvdUNsUDY4Ym10Tm5LZWUzWFNENTUyck5sVmlQSm03SVRFS3Zz?=
 =?utf-8?B?MGtaVGdoWm9TK2p6TGMxakRPQ1U1OXIyd3ZZMmc4K1NVb0VSUDRaemdwOHJq?=
 =?utf-8?B?MXVBekJWTmRCbmdyMUN6dis2b1NWMnE1VTRBc05qS0R4Z2RrSW9ZUTdXYUVS?=
 =?utf-8?B?Mk11NkJSTzZGUDg2R1RyQVluUVdMSmxiR0hZYnI1VmpkMldrc1BHRCt4L2lL?=
 =?utf-8?B?bHQzMWYzL3U1YkN6dTF6SGdhdmFuMEhYck85MXI4WWFucWRNcTlhSnk5dW9n?=
 =?utf-8?B?MTBQWjBOVGZUWjRQRGlKcVFJVXpRYUdjdmcrb3NkK3JSbjk4cWhkRUhpUFVj?=
 =?utf-8?B?SGU1ZUNWNWJTUkEvMnIxME5UMnZ3SHVCR2xnY2hWUnVUTk9zWXV2MVB6WjRD?=
 =?utf-8?B?U1NOS3RhcFlsTUpZdEdSTnlCdEp4MVpGbHNwc3pDcFRaOUhVYnh0RWlzc2hz?=
 =?utf-8?B?OC9LblE4SVFZUnVJdWV1enMvZGJTS3RBVndhRTNzM3Z2L3pRaG9QZnhkdU01?=
 =?utf-8?B?YlhOY3lhVmdaUnVFK0hEcWxhRW9hUHRyZVNkNGhwY0dYa3pHWXlEZkxoMkUy?=
 =?utf-8?B?TzZzTitTblNaYS9sVVFjbGJ0K1BMbVNlQ1NIK0JDSjNHKzRESHplcE1GN09t?=
 =?utf-8?B?WnM5RUYrN1dteW0vVnNZU3dHeTVORnZhbjhOM2p5ZVllemVDZTJ3aXc0bnhS?=
 =?utf-8?B?ZXlSOTF3NE5hMzc4eHRrVFdxcUF0dmJjcW84cUdKRlp3aDhWM3FSWWtwVVpi?=
 =?utf-8?B?WkIzYk5kMExNYnVCOXRNUVcrUnNRSkw5ajhmeUZGdjNJRUJvdmRCSGxYYVY3?=
 =?utf-8?B?V256WmVRSGZQMHBnVGpUbG9TTTZLRk1RVWhvb0FxOGdhY2ZGMzdTcnBxd1JK?=
 =?utf-8?B?NFFHNEd1b1FwQUo4OVZvVnpERjVOSmlHWHpqUjZQaU5DbjBUZzg1UFVSdElG?=
 =?utf-8?B?VmpZZDUxd3pRVXpEMmYvYkVQdEhkMXFscHgyeXowaDRHU0JsL0FFTkt2ekJP?=
 =?utf-8?B?NXhsbnBiSW8rOUF0ajRGTU9EaDRyNUZ6TUt0c05mcStOeGIxV3ErWDFFRjlX?=
 =?utf-8?B?eS8vV0lwMkI3UFk4a2t2WGt6R3BDWG95M3RkTlM0V0MwNW5lVlRKV2MrK09Z?=
 =?utf-8?B?Q01zaFVlbXp5ejErZ1ZCd3VHSGpuL0twelBHS0N2ejlvVUQ5RDhGZnFmRDl0?=
 =?utf-8?B?WHdmRG5mVGYwblUzektjRFp4VERWR1Rpc1ZDcWNjUExGRXorRDk3QXEwdnEz?=
 =?utf-8?B?Tk5ER0YrY0Y4WXlDMndRVDlsQUZYNXRzR2hQQ0k0WllXQjZIZCtQWDk3Vmgv?=
 =?utf-8?Q?LK5MAWRd+vwAZrYhpg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzVqcTk2MnExTUVvOFg5Q1F2R2E5QmNWUkl6L1NQVm9haHUzNHBvWXRWUVJD?=
 =?utf-8?B?VysraXZUdnFzWS9NdFB5U0pBQzhSUFRncGNJb2gydzQxWVEwbWtyaERkRFNn?=
 =?utf-8?B?UHdhajEzeWlZVGk0azBQK3lIdUFNM3ladHhXNTYxdVlIVk9KT3ZBL1J4eDZv?=
 =?utf-8?B?SWhRNVJsVTExb0k5NUxpK3ZYTS9LbElxT0hDSTV0TEJKZnVDdzdPbjZ0UjRr?=
 =?utf-8?B?d0ZmWGNXa1Y3aEVEWFZaNnZVa3FZVmtCb0VwM25QSllrelk3ZUFIdnZ6eEw0?=
 =?utf-8?B?aTNYbDMxQ2ordFRUS1lramo0KytwRCs5T3lreHJKeUFIWkZRb2wzOHZianQ1?=
 =?utf-8?B?RUw1KzdhUiswZ0JFQ2Z1NUZUaVlFMlpYblJZVU1ZUlRIUmFld3diY25UZHVK?=
 =?utf-8?B?YURDdFdXdXhQVTkyMzdEc09YNVZuK01YeUUzSzY0TW8rQ0ROK0xYdnhTdTN0?=
 =?utf-8?B?aExmSjYwaHhkRmM3MkxtWHdENG1EV2FaczhBUUl0eHBheXZmM3NzbHFFc1E1?=
 =?utf-8?B?S21aN0tXWXhNcmpEUzNXeGtuaEVaWThOR2wwL0Uxc1p3d2NFdU9lWWt3TGdk?=
 =?utf-8?B?VHFZRHZoK0xHeU5CTW9KLzBreFhPSjEyVWpuNFBCdWcrRlRYWjRwZmZLR3Y2?=
 =?utf-8?B?Z3V0OE5JZEVac01uY0pzVXNMMS9mRDhJNUV5Y21GYnRyODdVSVZsRVZ0cGU5?=
 =?utf-8?B?d2VycFo5dkxLSU4xMWlkUy9IbGdBbkNKd0tWZVdxWEJxWjRlTXFUQVZYbE5G?=
 =?utf-8?B?aXV6SWtmU1NHSGpibWswTklIY0d1WmpQb2hIZTRXczBhSyt2c015OEtkb3I5?=
 =?utf-8?B?am9LNlkvbG1nOFE3NkV6QVhuZmVDazZrUWJDOUtJelprVElFU1dWYk54SVRu?=
 =?utf-8?B?QnlYT3FETHFSVE1kY0pYNElWM1oycHBrS2tvbnRrM3JUVjg4ZUVEY0hkdkM3?=
 =?utf-8?B?djIwZVFjaGdqcElMZGl1Qk1JYi8wODRiOVVTNnJ1bW8xOElESmNza0kzTlVU?=
 =?utf-8?B?ZnBEQzRlcUxkQ3IrZVZhcjduaEMwOEtubk1CT0hZMVl0V2V2a3pzSVdXOTQv?=
 =?utf-8?B?Q2Y5V0gwY25Ea0xOUmJIcDBQYUFnenRkeWREdU00TE5FakxLVnUyaC82SGpT?=
 =?utf-8?B?MklzNEZwN3hXZWdqMC9XSzlHVWJ3cWRGb0NXUWpCSlZ6bTJHbnRKMzVqemls?=
 =?utf-8?B?VHpwRU9xWFpRUktwRFlxeld3K3VGUVBuNmV3aEV5aXlXQlBNc0UvR1hVZjVv?=
 =?utf-8?B?YzlNY2ZUYXFkRlNQU2NQSEMvai9hSXFhYjA0c2kxWCtNZUtCUEQrbFBMTUk3?=
 =?utf-8?B?WGU1KzdBbVk1UERhTDBWYWVyZkJEY3hKNTQ5QUNIRDczN2tlYVV2Y2RDUlRo?=
 =?utf-8?B?dDVYZlczRURQZk1YbDZCTlNUS25hZTNnOWhZQ1BZeTdxc3lZSDFKYkVFT21W?=
 =?utf-8?B?czNvanE1dlFxTUFFUkpJL2hFMDJnbnhuNVB6ZjVVb3dVZ08vd3pzVGVXNnlB?=
 =?utf-8?B?V3BJdVBSVWJhYzM1cmZscElwcFJTTEY5Q05IamU3WU94a0FBMHUzQUhWK1ZC?=
 =?utf-8?B?SVoxUDhTdytVWDV3YTYyaVN6eUlyRm9rbkZWU1ZnM3hpSGRycHJCeU9QcDdE?=
 =?utf-8?B?UFJ5YjJFY2VhdmJ6dE5ramV6b293ZHNTWGkwL0FrQUNzQUVlMDE5dHExNkpK?=
 =?utf-8?B?MXNicmN5QjRCaXdBak93ajV0UWxWUWMvY3dPa0kybXVJMVpvUGh1VHRKNk9m?=
 =?utf-8?B?MEpSTnFQVGtTYUhXL1QwTklLaGwrM3Y1NkhFWVR0TGhMNU9rdWFsN0l2SkEr?=
 =?utf-8?B?ZkpudzBIc1VERWxSbUFKd1JjQ0tIdS8reWhvVGo5U2VDQ29YWmhsMHpXeFZX?=
 =?utf-8?B?U0V2NStLbjhIRFFqTWVLcFNGQzZkcWNITUFmeHA3bzdvUjEvWHJKWVBQR2ZB?=
 =?utf-8?B?WS9sdENVVXVuak5yeWhCUE1xTndva1RrUm92cVRnY1kyVXZtdjBHOEQ4Undp?=
 =?utf-8?B?V29zLy9rd0MrR3NWUkVkOXBLZDlTOWxFUDdRRlI2WFBmTytVbFJPTHNUS1p0?=
 =?utf-8?B?Rmx5TitXN1dheEFGTHE3Rkd3c0lKY29BN1dnaVNzY2U0eVE2SXdZY0dYNGR0?=
 =?utf-8?B?aTBWaHBKdWwwdEU3bkR6aFhxQk5QSmpoZ24wL1RRMzN5ZENLemoyZXp6dklN?=
 =?utf-8?B?V1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nRM3nPaPaxEiYSoaWlaDaqWQpQ4WT2lXKFz97MTSiwn64DjkCiP/vOphEgT5J7WYr4xPuFbXjhkUVnWJtqKUi0k0up7TKHUfzlNH5xJZrMhVE7Q31xnioQLNOi+wJrsKxwYoNSQgCRk2Qi0LPJowiE+IAowKMT2XlNieEQGEHpbiGqbGJOGVasHGJNFPF9Q9P75rXLZueNE9/ANpOzK3/bBmEpOHEz3cEk72HXe8X8wPTAHv+0hzVeRil+Rt/j8/E1sHm4s4tI3pqK0zwX8o8lscnLZ5BhZZ57mFb9XeYcLNhAk+6sOP7nKP4jkkaHBytRz1/5a41hReSdAu3fyfeZOiMifUEZGp/5Q1tJhC4/HnNQtv5+aDzFXmRmS6KqjaSxLSW5wO2tZ7rqzaz13Bz+CfVLBSFUfkGWqo4qxoIr4BAHyJPJLH15aWxj4WLpEW/94oO7SbhRAV201fmwrxmGar4xElpuy5pKcwfiAax1CAHWdZc1bAuutjJqmgvNJwuy+V12mXLFvxJ880plOur+35+aMPILjIkLSX+gPb2El+cH3dr75BrqqJo2GMhRKMlTTZgjIN/vsruqRwX5DF6vD1Wgv8kWMGb0zF4238PEk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48f7fb8a-9e3a-4c71-36c0-08dcbbc8bba7
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 18:49:59.7247 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eHcdjBBBRfhcYgUxJMBTZslav0f61HcGYnI14IWm34VNQB2CYmDl52klkHq85L70+XLCwbGkLzwgZrIIg8a9aiN62Vb4cfiRSoANGZI+gQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7975
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_09,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408130136
X-Proofpoint-GUID: sH_kuEIjKc55zD_ygPkjo5q6KMYkxmRx
X-Proofpoint-ORIG-GUID: sH_kuEIjKc55zD_ygPkjo5q6KMYkxmRx
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

On 8/13/2024 2:46 PM, Steven Sistare wrote:
> On 8/13/2024 1:00 PM, Alex Williamson wrote:
>> On Tue, 13 Aug 2024 11:35:15 -0400
>> Peter Xu <peterx@redhat.com> wrote:
>>
>>> On Mon, Aug 12, 2024 at 02:37:59PM -0400, Steven Sistare wrote:
>>>> On 8/8/2024 2:32 PM, Steven Sistare wrote:
>>>>> On 7/29/2024 8:29 AM, Igor Mammedov wrote:
>>>>>> On Sat, 20 Jul 2024 16:28:25 -0400
>>>>>> Steven Sistare <steven.sistare@oracle.com> wrote:
>>>>>>> On 7/16/2024 5:19 AM, Igor Mammedov wrote:
>>>>>>>> On Sun, 30 Jun 2024 12:40:24 -0700
>>>>>>>> Steve Sistare <steven.sistare@oracle.com> wrote:
>>>>>>>>> Allocate anonymous memory using mmap MAP_ANON or memfd_create depending
>>>>>>>>> on the value of the anon-alloc machine property.  This affects
>>>>>>>>> memory-backend-ram objects, guest RAM created with the global -m option
>>>>>>>>> but without an associated memory-backend object and without the -mem-path
>>>>>>>>> option
>>>>>>>> nowadays, all machines were converted to use memory backend for VM RAM.
>>>>>>>> so -m option implicitly creates memory-backend object,
>>>>>>>> which will be either MEMORY_BACKEND_FILE if -mem-path present
>>>>>>>> or MEMORY_BACKEND_RAM otherwise.
>>>>>>>
>>>>>>> Yes.  I dropped an an important adjective, "implicit".
>>>>>>>
>>>>>>>      "guest RAM created with the global -m option but without an explicit associated
>>>>>>>      memory-backend object and without the -mem-path option"
>>>>>>>>> To access the same memory in the old and new QEMU processes, the memory
>>>>>>>>> must be mapped shared.  Therefore, the implementation always sets
>>>>>>>>> RAM_SHARED if alloc-anon=memfd, except for memory-backend-ram, where the
>>>>>>>>> user must explicitly specify the share option.  In lieu of defining a new
>>>>>>>> so statement at the top that memory-backend-ram is affected is not
>>>>>>>> really valid?
>>>>>>>
>>>>>>> memory-backend-ram is affected by alloc-anon.  But in addition, the user must
>>>>>>> explicitly add the "share" option.  I don't implicitly set share in this case,
>>>>>>> because I would be overriding the user's specification of the memory object's property,
>>>>>>> which would be private if omitted.
>>>>>>
>>>>>> instead of touching implicit RAM (-m), it would be better to error out
>>>>>> and ask user to provide properly configured memory-backend explicitly.
>>>>>>>>> RAM flag, at the lowest level the implementation uses RAM_SHARED with fd=-1
>>>>>>>>> as the condition for calling memfd_create.
>>>>>>>>
>>>>>>>> In general I do dislike adding yet another option that will affect
>>>>>>>> guest RAM allocation (memory-backends  should be sufficient).
>>>>>>>>
>>>>>>>> However I do see that you need memfd for device memory (vram, roms, ...).
>>>>>>>> Can we just use memfd/shared unconditionally for those and
>>>>>>>> avoid introducing a new confusing option?
>>>>>>>
>>>>>>> The Linux kernel has different tunables for backing memfd's with huge pages, so we
>>>>>>> could hurt performance if we unconditionally change to memfd.  The user should have
>>>>>>> a choice for any segment that is large enough for huge pages to improve performance,
>>>>>>> which potentially is any memory-backend-object.  The non memory-backend objects are
>>>>>>> small, and it would be OK to use memfd unconditionally for them.
>>>>>
>>>>> Thanks everyone for your feedback.  The common theme is that you dislike that the
>>>>> new option modifies the allocation of memory-backend-objects.  OK, accepted.  I propose
>>>>> to remove that interaction, and document in the QAPI which backends work for CPR.
>>>>> Specifically, memory-backend-memfd or memory-backend-file object is required,
>>>>> with share=on (which is the default for memory-backend-memfd).  CPR will be blocked
>>>>> otherwise.  The legacy -m option without an explicit memory-backend-object will not
>>>>> support CPR.
>>>>>
>>>>> Non memory-backend-objects (ramblocks not described on the qemu command line) will always
>>>>> be allocated using memfd_create (on Linux only).  The alloc-anon option is deleted.
>>>>> The logic in ram_block_add becomes:
>>>>>
>>>>>       if (!new_block->host) {
>>>>>           if (xen_enabled()) {
>>>>>               ...
>>>>>           } else if (!object_dynamic_cast(new_block->mr->parent_obj.parent,
>>>>>                                           TYPE_MEMORY_BACKEND)) {
>>>>>               qemu_memfd_create()
>>>>>           } else {
>>>>>               qemu_anon_ram_alloc()
>>>>>           }
>>>>>
>>>>> Is that acceptable to everyone?  Igor, Peter, Daniel?
>>>
>>> Sorry for a late reply.
>>>
>>> I think this may not work as David pointed out? Where AFAIU it will switch
>>> many old anon use cases to use memfd, aka, shmem, and it might be
>>> problematic when share=off: we have double memory consumption issue with
>>> shmem with private mapping.
>>>
>>> I assume that includes things like "-m", "memory-backend-ram", and maybe
>>> more.  IIUC memory consumption of the VM will double with them.
>>>
>>>>
>>>> In a simple test here are the NON-memory-backend-object ramblocks which
>>>> are allocated with memfd_create in my new proposal:
>>>>
>>>>    memfd_create system.flash0 3653632 @ 0x7fffe1000000 2 rw
>>>>    memfd_create system.flash1 540672 @ 0x7fffe0c00000 2 rw
>>>>    memfd_create pc.rom 131072 @ 0x7fffe0800000 2 rw
>>>>    memfd_create vga.vram 16777216 @ 0x7fffcac00000 2 rw
>>>>    memfd_create vga.rom 65536 @ 0x7fffe0400000 2 rw
>>>>    memfd_create /rom@etc/acpi/tables 2097152 @ 0x7fffca400000 6 rw
>>>>    memfd_create /rom@etc/table-loader 65536 @ 0x7fffca000000 6 rw
>>>>    memfd_create /rom@etc/acpi/rsdp 4096 @ 0x7fffc9c00000 6 rw
>>>>
>>>> Of those, only a subset are mapped for DMA, per the existing QEMU logic,
>>>> no changes from me:
>>>>
>>>>    dma_map: pc.rom 131072 @ 0x7fffe0800000 ro
>>>>    dma_map: vga.vram 16777216 @ 0x7fffcac00000 rw
>>>>    dma_map: vga.rom 65536 @ 0x7fffe0400000 ro
>>>
>>> I wonder whether there's any case that the "rom"s can be DMA target at
>>> all..  I understand it's logically possible to be READ from as ROMs, but I
>>> am curious what happens if we don't map them at all when they're ROMs, or
>>> whether there's any device that can (in real life) DMA from device ROMs,
>>> and for what use.
>>>
>>>>    dma_map: 0000:3a:10.0 BAR 0 mmaps[0] 16384 @ 0x7ffff7fef000 rw
>>>>    dma_map: 0000:3a:10.0 BAR 3 mmaps[0] 12288 @ 0x7ffff7fec000 rw
>>>>
>>>> system.flash0 is excluded by the vfio listener because it is a rom_device.
>>>> The rom@etc blocks are excluded because their MemoryRegions are not added to
>>>> any container region, so the flatmem traversal of the AS used by the listener
>>>> does not see them.
>>>>
>>>> The BARs should not be mapped IMO, and I propose excluding them in the
>>>> iommufd series:
>>>>    https://lore.kernel.org/qemu-devel/1721502937-87102-3-git-send-email-steven.sistare@oracle.com/
>>>
>>> Looks like this is clear now that they should be there.
>>>
>>>>
>>>> Note that the old-QEMU contents of all ramblocks must be preserved, just like
>>>> in live migration.  Live migration copies the contents in the stream.  Live update
>>>> preserves the contents in place by preserving the memfd.  Thus memfd serves
>>>> two purposes: preserving old contents, and preserving DMA mapped pinned pages.
>>>
>>> IMHO the 1st purpose is a fake one.  IOW:
>>>
>>>    - Preserving content will be important on large RAM/ROM regions.  When
>>>      it's small, it shouldn't matter a huge deal, IMHO, because this is
>>>      about "how fast we can migrate / live upgrade'.  IOW, this is not a
>>>      functional requirement.
>>
>> Regardless of the size of a ROM region, how would it ever be faster to
>> migrate ROMs rather that reload them from stable media on the target?
>> Furthermore, what mechanism other than migrating the ROM do we have to
>> guarantee the contents of the ROM are identical?
>>
>> I have a hard time accepting that ROMs are only migrated for
>> performance and there isn't some aspect of migrating them to ensure the
>> contents remain identical, and by that token CPR would also need to
>> preserve the contents to provide the same guarantee.  Thanks,
> 
> I agree.  Any ramblock may change if the contents are read from a file in
> the QEMU distribution, or if the contents are composed by QEMU code.  Live
> migration guards against this by sending the old ramblock contents in the
> migration stream.

Our emails just crossed.  I will repost this to your new reply so keep a single
conversation thread.

- Steve

> 
>>>    - DMA mapped pinned pages: instead this is a hard requirement that we
>>>      must make sure these pages are fd-based, because only a fd-based
>>>      mapping can persist the pages (via page cache).
>>>
>>> IMHO we shouldn't mangle them, and we should start with sticking with the
>>> 2nd goal here.  To be explicit, if we can find a good replacement for
>>> -alloc-anon, IMHO we could still migrate the ramblocks only fall into the
>>> 1st purpose category, e.g. device ROMs, hopefully even if they're pinned,
>>> they should never be DMAed to/from.
>>>
>>> Thanks,
>>>
>>

