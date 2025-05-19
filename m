Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7659C3ABD8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 13:21:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH0Qj-0006Ow-7V; Mon, 19 May 2025 09:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uH0Qg-0006OV-4c
 for qemu-devel@nongnu.org; Mon, 19 May 2025 09:21:18 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uH0Qc-0005PC-Tq
 for qemu-devel@nongnu.org; Mon, 19 May 2025 09:21:17 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54J6ijXV014381;
 Mon, 19 May 2025 13:21:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=/r0hPCuTIs7nQnCEhqyM2qHE6vaJpz9c5xoCYwnYQpQ=; b=
 L3QmNp4nOUaILKS4dQsjY3ifBJxeI5jheE34za69U6+vQ9YIsnnbyFTHDIzyEhoD
 UfeonKZ2SYn5jStQLESvZitq/RQmvdonk7kXcQifiFWtqTQeA8vYMYN2HkNndYxy
 wfiljwlx7kkKn28W7BVUl7UHK298LiOM8BYwvbBiT5xgbJ6tk7loLn8jiV/eac2n
 HdIFu17OHTKCIWqjpmq/YvSSb5d18zJbLkHnPaqKSrVYdWej13HeS3YGHyeG4v/c
 e8wqCkfuo6V4RUaIpRJgH8f4ZApl9EICV/D9JU2mH7LnUK69DDpTDdxtCWOuNPpE
 WoXHjgdYdpyBDDm2LKFwhw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ph84jyte-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 May 2025 13:21:10 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54JBiKiq002310; Mon, 19 May 2025 13:21:09 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46pgw6ejvx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 May 2025 13:21:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hcFcGe5BJzBnEmImhXsuJEU3JwopOV7EseBsfiMibhSEB7acoT6uuZ1H53MSlA8VcKsxmtssUU661NVj9Lu4COBvYp5zsuxMvAYWBIM8thgR+8KsoeQ7cAUAwbz4TgryLzU03iFDOe1smajcztUHfJt4MX9Ik3E3ZSSMRDtZh+k+hzpdI9Vrm9dAQX+3QUgnHvd/RzgXPLyCqPHZnJ6yPWcc3cjpo56ReUHT5jxPTGbvb3SONy98PAZFoVjHsUMhykFoRALmIdmNVOTFw9XgHJBVjVOFwHZ2n86oRL1pEU66V9Tzw2IKBlbKzVI05Cs4POMl2wFrBJn/J+hGQUQKmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/r0hPCuTIs7nQnCEhqyM2qHE6vaJpz9c5xoCYwnYQpQ=;
 b=AtSXJGyqz5yztt0Kr5u9tKPu6rAm/si/VONRzqBGC8wCn8+Sz7mlfHa/zJzh64LDO2HEwZ+v3AslVK0hKxzXDEQyihK5pDOu2HDvqNd+z+uVVGh2K2WhwHzVwu4Aij86FpqReFBKxQdNWJ134sqCjo1YvcPjJ3r8kMzRxekvogqZBmEa3LBhhHzwAzh9taJm+g7LP9AwD/r+0sg228lCu8F9avDdkZ3Xzw/WhofEGnRDA0qZCETovJVN41bRBO/GWJ+bFN8kxi0iphzwk3BacEFnWSs8bDpgjsz6EyTJ2IXSO94jBggIxjIGhIhtrUf6G56OP+sTG7ep7QlxRPyqrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/r0hPCuTIs7nQnCEhqyM2qHE6vaJpz9c5xoCYwnYQpQ=;
 b=yEHPLCOQ/kYwJFAXAOzjqm1jcbs634kt39S2sxnYqjlyD9oXc1VXO2tXvolXuq6e33BraiKcCGL9HxXEJCYQSzBdziPhYpYQ2oeSFsaq2cGg3FM/KRMIdu6Gq+7J77ZbE3Wb+EK4vC1anZYc3qEyoq4PlQSeC5dtq5kJAmSVVLM=
Received: from CH3PR10MB7436.namprd10.prod.outlook.com (2603:10b6:610:158::7)
 by SJ5PPF5B5767B72.namprd10.prod.outlook.com
 (2603:10b6:a0f:fc02::7a1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.24; Mon, 19 May
 2025 13:21:05 +0000
Received: from CH3PR10MB7436.namprd10.prod.outlook.com
 ([fe80::dfba:d89:d13d:cd54]) by CH3PR10MB7436.namprd10.prod.outlook.com
 ([fe80::dfba:d89:d13d:cd54%5]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 13:21:05 +0000
Message-ID: <76e8477b-b5ef-42b6-a2c9-4524165aad02@oracle.com>
Date: Mon, 19 May 2025 09:21:02 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4] vfio: return mr from vfio_get_xlat_addr
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Cedric Le Goater <clg@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>
References: <1747415599-131553-1-git-send-email-steven.sistare@oracle.com>
 <e6b1e5ee-f8d3-40b5-a608-67469a8b599b@redhat.com>
 <717acf0a-bdeb-45ed-bd44-7c054247836e@oracle.com>
 <31cf87f6-94a4-4801-bbe9-882043cd88f2@redhat.com>
 <5a2a1347-5a98-49fb-8416-4f8d43250491@oracle.com>
 <d901a598-26cb-4f55-8019-b6966e96200a@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <d901a598-26cb-4f55-8019-b6966e96200a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR13CA0013.namprd13.prod.outlook.com
 (2603:10b6:208:160::26) To CH3PR10MB7436.namprd10.prod.outlook.com
 (2603:10b6:610:158::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7436:EE_|SJ5PPF5B5767B72:EE_
X-MS-Office365-Filtering-Correlation-Id: da68806b-bca3-4046-b635-08dd96d80233
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NndKdWt2RFVOOUIwb2liRUJ4WDF3UXRUQnp6UzcxaVVQSXFqalB2QlU5TXpr?=
 =?utf-8?B?UmZXS2ZnZnNyN0I5YkpnTCtQZnY1Wng1LzI5Rmg5eTJVM1RxRGc0QTU5V2Nz?=
 =?utf-8?B?Q2NUTDBUSjBPOUFRQlNuem5GVExLYWRFV00wOFhqSW15VDRhUFJvMmtBSENK?=
 =?utf-8?B?R1lmUWFwN1dJZk5RT0NYQ1VOTWZrOFVsQy9iM3V2NWVENDZoODhxOGJkYnJ4?=
 =?utf-8?B?UDlWOWU3TkN1WmdiUEFLODB3am1oMWtTVUxSaVdXWDk4Rzh5WTFpWlRmekx6?=
 =?utf-8?B?aG5zMmI0bnFZaWlLbmhianNQSUd0RHIzVCtkRjV2VlZwSEkvTXcyTFBWYUtR?=
 =?utf-8?B?cUlzZkg2SjhKV3dZSlZ4Rk1hVXVJY3JQTE5LVFNpRjhac2FubkpFNVdlaXIv?=
 =?utf-8?B?YjFLMFE5NUhDZzQ3N3gyN0VXTnNhWU1FR1E1QzVkQ2lRUXJnV2JPd01iZjFT?=
 =?utf-8?B?R0NOblZHWTAyZEVuYk1FVVBFU1d1ZjRWMzlsb01iMGFOVGJXbG44SEhva1JB?=
 =?utf-8?B?d2Rzd01lOW5COTZzdk4xdHdra1RETVhFUys0a3dralI5QzZYZDlqdU1oZGJI?=
 =?utf-8?B?bGhuYkh2N1JZTE1TQlVIeW15WkZuQXBqOE5vdXZNYlp6Yk4vK0ppc1JiR0ZL?=
 =?utf-8?B?Q2JYSkd3V3JvYnZPbnN5NitwVWx2YzMwTmFzbWtidk5tOWdvQVNTeFlxYzds?=
 =?utf-8?B?djNQV2xnNjAxZk05MEs4a3lFTTQ2dEhTc1ptU2RSQytuTnQ3Vks5VlIzWXRz?=
 =?utf-8?B?Y2ZjTm1JdU1xRmptRGZPMnd3RklDSWNaK0ZmSStUTmh3a3BLOEVqaTlKMERP?=
 =?utf-8?B?T3J6eGZoOTFOSkg4ZCtaWUxWRGJ0SHprbHdDcGxUSzVJNGNpVFNjWUlML21s?=
 =?utf-8?B?TXMrT3daaDFzQmt6eVR6RU4zR1M2Z2pDR01zYnNna2NtYStTdWdDQk9jYnB5?=
 =?utf-8?B?SjJERExmU0N0Y3lSNFBCQjBoYzBTNVJWN1dHb2gyc1RsUEZCQVlNc0lrMGk4?=
 =?utf-8?B?T3YyQnVtdU1uSzJlRXUzVUNVRkhYbFRMUDdNVGRwcTlvNHh6SHRHNnp4SWxh?=
 =?utf-8?B?bUZpK1N5eGRGdmRPR1MvM0tRUFJoTlJMbDVKYlU5WXl6ZW85aHlQR01TSmRL?=
 =?utf-8?B?czNqWHlmbzZwZ2hPUVVOOU11cUExY1pmSncwUzRHdFhOVGkzVjllZzBHdVNL?=
 =?utf-8?B?aFhoRFBYVTkyR1EyL1loQ0NWSTNuZ0N2NktxOEU4OEFyS1RpSVEzYWUvRkVE?=
 =?utf-8?B?MUIwd0tnKzVHMU5veXllMXBFYk9RU0UyQW5lYjlnS1NOS2VMeFFFOHFLdEtx?=
 =?utf-8?B?SUp0QTFsaUY5b3JFSVdoQTJmeTd0UUdUdVlNNk5EQ1UwZGpkTHhMT2JNdHpp?=
 =?utf-8?B?Z0VtS3pNVE9XTjVENlc5WkpDcXdyWTZlNm02ekJUcFBpOWxFaXNFT0JpMDJC?=
 =?utf-8?B?a05GVHpJQUkyVStLNnFzYmlTK3hHWVQwVUxKVm1NSDQyZ1JCZ3FzTzBrYThK?=
 =?utf-8?B?Sk0yK0toNDFBM3djcFgyamZKbWtzY2lDRkkxQ3pnTUp6YWpYUmdhTVp1VTRk?=
 =?utf-8?B?eFp3TGtmUGZJbmlNbXNHd2JxazR2UlNPQjU1aENKUFlvSlNDRXlLTDl6MS8w?=
 =?utf-8?B?MDVkUFNvVUhzNXNIbnpHYWVlUWo2M1dTU1p1ZnNnU2hRM1JxWThJQmNOZklq?=
 =?utf-8?B?TVk3K29IWDVFWncwWmQzQVU2RTI4OWhXUjR6bnZRU1d4ckpMYXFtM3hQQjdW?=
 =?utf-8?B?b2svTm9mUUFWMVR6dnpMb0tBUHg1bUpqY2ptOTFRSHAyazdQT2F3RFRaaGg1?=
 =?utf-8?B?UlB5N3ZUK28rZm1JOCtZaG9yTEZTNFJYYUF0QVBTQ3F6MWNNeW9mWFB6bDhB?=
 =?utf-8?B?ZlVOZkNQL005TUFUeVdqVlQwQldWM084RUxaTmtVUWpPM3hLdU9MVk9KN0w3?=
 =?utf-8?Q?xg78NzahtJo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR10MB7436.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEdxSjhmbkw0R2RaZnBBQ3c1Qm9SOW1rbWE1dFN6UXNlK0t3ZFNNTndhWmlu?=
 =?utf-8?B?NHlRMEdNVnA0cnVIL2tvWGZtMUNOQkduZlBNYnZ6bWZ3NVZNSHZ5aGNwaEk5?=
 =?utf-8?B?NXg3V0JXZEI3T0Q1dU5SZ0NtVU1HS2F5dHcva0JVR2FWRHhyUE5GM2xuS0l4?=
 =?utf-8?B?by9JMHNKK294cFB3WUNJYjczblIrS0JFYkFTNGZkUEtPT1Jpc281N2lHb256?=
 =?utf-8?B?VVU1ZnkwaUM1Q2hwa0dhcnB4VTBDOHJIYXlDY2picDVBWjUrU0tBQXV4aW1l?=
 =?utf-8?B?TXZzdUtSM2lSYWJqdG9MYVFOR3JEZytZM3crY1c2WHNCNm0wTyswWVhKK21R?=
 =?utf-8?B?dHM3S3FYcnhiVWI2MVdwWUNpN043cTNSSkord0Rma1JqZEV2bmVsNk5aQnZt?=
 =?utf-8?B?bnl5dTJIU0w1ODZmcnVNZ1BHN3BhTjJVRE4vRnphLzB2TmtINW8zb1ZnRlBT?=
 =?utf-8?B?bWJwcWM5RFROcXpzbisvWkcyQlJwWXIyVnNhbGV0eGMzcTJHY0thTGd3M1pF?=
 =?utf-8?B?d2hKUGJDcjU5L3FqZERRT0JhZ3hqd01NcU1uODZGM1NOc3JxSVF2Q3RsNVdS?=
 =?utf-8?B?TjBvS3A0TldtcHIrTzdIWEFqbG9vWENSQ0xaRGNxWjc2WW9UQURsWWkwRytJ?=
 =?utf-8?B?cnY5TnFxL2JzaFRqOElDZGtTRU9POUpNVFpTeVVLRjg1bm94aDh6QWZmYzA5?=
 =?utf-8?B?UUZSSWIyc1BDeXoxN3RLUU1xdnRxUFIzMTVyOUVQc0tkaG0zU2ZrNHJxU3F3?=
 =?utf-8?B?RnpENWcrVHJVU3hLZ1RFK1o3OW5wQzcwUHlJdFBBenBWdlJDN1RXOGtKdkph?=
 =?utf-8?B?c0pXZERFY1JiT0NqM09Wbkh2NUJPUDhxcDBKaVlqQnQ3SVlBQzZFU0E0cWx0?=
 =?utf-8?B?N09TcnorbnBPVFhZa0h0SnYvWjhHSlN2d0Q1cGt0OTBpRVZtNmFIdHlYNnhl?=
 =?utf-8?B?MzJUY204UFp3MWcyVlMyT0FrcklqUVUydU1tMDUyS21KWmdkT0pJUm5PYm9k?=
 =?utf-8?B?QTh3aWo2eDZmanU0K21GZVZYVUl5KzQ2Ym92UVEzcnBFM1puTkxZZTIzMUJx?=
 =?utf-8?B?WGF5M2N5bVBFS2ozcE5HS0crU0gyYTBGeUVhOE9zVTZWcTRXbk5zOExpZnRU?=
 =?utf-8?B?OFhaOGtQaDdiZG9lUFN2RkZrMzJyV0I0Y3FWcVNGSW9tSTUyYWdtL2ZtUERG?=
 =?utf-8?B?ZHAwRFdNd0JwV1J4U2ZlSkowcS9DL3JKL09PUjdIRmxaL0J1TVpwdWdBWk4x?=
 =?utf-8?B?OUlpVVF0RnppWSt3enhzQnNmMW4xVldWdHBEMlB0bHpGdmFMb3ptcDhyMkFm?=
 =?utf-8?B?TjVVN2FOdms1RmpjbUlEdndNQ3h5d0wzb3Z1MDJXbWl1S0pBSWE5dFpqVmx2?=
 =?utf-8?B?UmFVS1N5NWdTVG95cFZNMG1LNGZKcHBQQ3VqOVdyMjJJai9sMC9aWWg1NEda?=
 =?utf-8?B?Wk0yYStEQUMrOVhOUGVyZEMvRW92VjBVSFY3OUQ1NjQ4SFlYVzg4RWlOVnpt?=
 =?utf-8?B?UDRaaldob2VoMGJwcGt2cHNmejVCaENBUUZ3L2UwVC91d2VwRnpMcTdPMFlx?=
 =?utf-8?B?R0RmSENVSVc0dkRFdmpobjJoKzBybmFIYXVMUTVuTHRjNXpwSVVkYmNWUU1t?=
 =?utf-8?B?bDAyYW5HTEVHWnJ5UWJFa0draG91bVozZnJPVFpGVXN6Zksrb3p5dGhtL290?=
 =?utf-8?B?UVgwV2o2ZHU1eDd3NnFtUDlqaFowS3FNMkFrZkk5V0UzV0JEeXYvWEcvWlV0?=
 =?utf-8?B?WXIzM0p2bjBRRDd1V200V09QY1pVcTNCYllGUWpLRC9rT1hrYjhTa2VQZWxn?=
 =?utf-8?B?OVFVZjBDemxUcXRtNGpsZGpBa0hxU2tqVStsdEpLUWFLN0xBZTNlUTlIRVNt?=
 =?utf-8?B?UDNXVDhzcGllWHRDSzVtK3lXQk1wTWhiQWJpdUpWcXplb2lpN1VuSXlrZkZK?=
 =?utf-8?B?MmppcFhwZWFKajJkQVJvV0tZWC9XdU16RW4ybm1CYkhBMlNCRW1jT2ZtT1pw?=
 =?utf-8?B?N0tZSUpRc2pycThYcGxlcXI0NE91c1pjRGQ3RkxQS29MdGFrY2lDRnRUdkxt?=
 =?utf-8?B?c3NyK0k4NXZCTnNzV1VVRXRHR2k1MlZXd2FINmkyc1FEdit1Rk02aG56NWYy?=
 =?utf-8?B?c0xBOUZrZGlqMjlOUFpySGV4Tm9BNGM4ZXJFOEFYOGhyMHhTS3JTc3gwbEtu?=
 =?utf-8?B?L1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: i6EMzlmOT1bNOJ99uR0j9n+6f21LZbn2ntFguIy5WEsQDK+YH8YHQXSYNkaOuyVfFIQhzCYsPeaVbBe9DeTrOstedq6mhfPQEbdAH6/O/YIYbLsKLgAlnZWBol5/NZrTohS7t/2wyF/nJzmrJyLOXPvVkb7u8DkTICcqrDikSnTaaZedkLkVK2Giq6nLyYru/hcK6pOUPSjkuSzk5DVO90EvzD6NsthmXwX30la5/xI3wDNLCGjqkk87NV4u1isox1UUQWDWQBtIR3KmR7BRCfQXqbPOKNBNW4+1hAqCH3BrYSi9hPSPdtr0YWrkAEAiVZTVc2DzQMWeyS0YVboP1Tdh0XJjB5Xddfmf1Z6vnj4qTfyB9H0rj/QWvZu+tlILRWXmMe1JwUkD79K/IWt+dQ2cixgfljUd2sZaYKFh1LTqrvvb2nP7wPN1zL7MFgllawqot7aaC8s83w3yr53K2+N6xV9hXRgz9VzLc6Pqougc3FzPJFzCdSw0UJPerl2T47aEof0yf3LK2HukmUrSH0lZR1InWftgd0c5WNcts0ZrzxJPv1eI7hqpQ9VoZySsJAVLDZo7dxMptkX3dnSAFInAYHHgVa9MdZDu//SIzaM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da68806b-bca3-4046-b635-08dd96d80233
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7436.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 13:21:05.2465 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uZ8TFnlNEbok37Y8VEpBGaZknBs7Mmq31G954kG5UzORGhqZptq+HZ3pc99oKsQgv8MIlW5bNo5NwccDWoAKnY+/LZuMPRTousKrNDgZpFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF5B5767B72
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_05,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505190124
X-Proofpoint-GUID: vpJ0m8sA4s0zb755TPEKQVnPPQr3-Yx0
X-Authority-Analysis: v=2.4 cv=YPSfyQGx c=1 sm=1 tr=0 ts=682b3046 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8
 a=HC3HRbVI8y7vNLR8aE0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: vpJ0m8sA4s0zb755TPEKQVnPPQr3-Yx0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDEyNCBTYWx0ZWRfX57ch8Ih+rlXO
 FaFYxyLDc5hbh1JZ2vecLxBDDV8x9PF/2YJq2Mj2jLOSU0I6P+LcFwRlFlrMEnwMCehKZJ/UvWQ
 MmCwvNVH8C5XiP14+mNzQnz/2SvyG5ymwBWQ13y34hspZ6Ny7lIqtpY/YDUrxtM/GAjwk63AFdf
 EOEeF+Dx3wvUhYqZwo316kB7ShNWYjqYbfuiRiwuts7qYonI5/8HzAIiLC/NJ7B9TjywKhl93KT
 AqpwGuJfKyORrPkhHbXYyjjzbulZMUN/GLOuhXzQp/WR/5OJVGixIbgRMeKrAhcc1sXZdRbVzaw
 bVmXeQccMslZ7LInHchzwtGWcIGXMxEzgqkm8K/1Pzn492v/TAGWRPTiVDaFZvoXJMcIuAoD3gw
 tcJOzOnPPbygEjNOW3Bys96pwEwBCWGNF8he0Ul15bbt9GO5ndYHP2xPJTdLSGJf5riJsJIg
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 5/19/2025 4:28 AM, David Hildenbrand wrote:
> On 17.05.25 15:55, Steven Sistare wrote:
>> On 5/16/2025 4:50 PM, David Hildenbrand wrote:
>>> On 16.05.25 21:26, Steven Sistare wrote:
>>>> On 5/16/2025 2:58 PM, David Hildenbrand wrote:
>>>>> On 16.05.25 19:13, Steve Sistare wrote:
>>>>>> Modify memory_get_xlat_addr and vfio_get_xlat_addr to return the memory
>>>>>> region that the translated address is found in.  This will be needed by
>>>>>> CPR in a subsequent patch to map blocks using IOMMU_IOAS_MAP_FILE.
>>>>>>
>>>>>> Also return the xlat offset, so we can simplify the interface by removing
>>>>>> the out parameters that can be trivially derived from mr and xlat.
>>>>>>
>>>>>> Lastly, rename the functions to  to memory_translate_iotlb() and
>>>>>> vfio_translate_iotlb().
>>>>>>
>>>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>>>> ---
>>>>>>     hw/vfio/listener.c      | 33 ++++++++++++++++++++++-----------
>>>>>>     hw/virtio/vhost-vdpa.c  |  9 +++++++--
>>>>>>     include/system/memory.h | 19 +++++++++----------
>>>>>>     system/memory.c         | 32 +++++++-------------------------
>>>>>>     4 files changed, 45 insertions(+), 48 deletions(-)
>>>>>>
>>>>>> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
>>>>>> index bfacb3d..a4931f1 100644
>>>>>> --- a/hw/vfio/listener.c
>>>>>> +++ b/hw/vfio/listener.c
>>>>>> @@ -90,16 +90,17 @@ static bool vfio_listener_skipped_section(MemoryRegionSection *section)
>>>>>>                section->offset_within_address_space & (1ULL << 63);
>>>>>>     }
>>>>>> -/* Called with rcu_read_lock held.  */
>>>>>> -static bool vfio_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>>>>>> -                               ram_addr_t *ram_addr, bool *read_only,
>>>>>> -                               Error **errp)
>>>>>> +/*
>>>>>> + * Called with rcu_read_lock held.
>>>>>> + * The returned MemoryRegion must not be accessed after calling rcu_read_unlock.
>>>>>> + */
>>>>>> +static MemoryRegion *vfio_translate_iotlb(IOMMUTLBEntry *iotlb, hwaddr *xlat_p,
>>>>>> +                                          Error **errp)
>>>>>>     {
>>>>>> -    bool ret, mr_has_discard_manager;
>>>>>> +    MemoryRegion *mr;
>>>>>> -    ret = memory_get_xlat_addr(iotlb, vaddr, ram_addr, read_only,
>>>>>> -                               &mr_has_discard_manager, errp);
>>>>>> -    if (ret && mr_has_discard_manager) {
>>>>>> +    mr = memory_translate_iotlb(iotlb, xlat_p, errp);
>>>>>> +    if (!mr && memory_region_has_ram_discard_manager(mr)) {
>>>>>
>>>>> Pretty sue this should be if (mr && ...)
>>>>>
>>>>> otherwise we'd be dereferencing NULL :)
>>>>
>>>> Hmmmm.
>>>> That is why we cannot return mr as the function return value.
>>>> There are cases where the function can return error, but the mr is
>>>> valid.  We want to take the branch in that case.  From the original
>>>> code:
>>>>        if (ret && mr_has_discard_manager) {
>>>
>>> It's late in Germany, but didn't we return "ret = true" when we would now return mr != NULL?
>>>
>>> I mean, there is no reason to warn about mr_has_discard_manager if ... there is nothing to translate to?
>>
>> The issue is that mr_has_discard_manager has been replaced by
>> memory_region_has_ram_discard_manager(mr), hence mr must be returned to
>> evaluate memory_region_has_ram_discard_manager(), hence we cannot return
>> mr == NULL as the error indication.
> 
> Let's try to understand what the code wants to achieve.
> 
> If *our translation was successful* and we have a RAMDiscardManager, we want to print a warning, stating that this *successful* translation is problematic.
> 
> memory_get_xlat_addr() currently returns true *if the translation was successful*. Now we return "mr" when the translation is successful.
> 
> if (mr && memory_region_has_ram_discard_manager(mr))
> 
> Checks the exact same thing? I really don't see the problem you see.

Ah yes, "ret != 0" now means success.  I've been slow to adjust to the change.

I'll submit a V5 with your ack and the corrected line:

   if (mr && memory_region_has_ram_discard_manager(mr)) {

- Steve


