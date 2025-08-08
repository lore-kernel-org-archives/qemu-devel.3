Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 176CFC87FDA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 12:39:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukMN4-00054k-7o; Fri, 08 Aug 2025 08:38:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ukMMw-0004qN-N8
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 08:38:48 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ukMMu-0004gc-2k
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 08:38:46 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578COlpq005847;
 Fri, 8 Aug 2025 12:38:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=zyAntusnvMH+f7M2P+VeQLMYK7Q6lxeVLddlsi4762c=; b=
 NKj/o/sVEqkky4A5WZtRRIKFWr+Y3XnnlHR3w64ehouOJqy5XA1eiW++XkWOz4OG
 NmXJwIOFx0OtXEicu3eRBwoPNoWvW7Zn0LcrCn3Z3GIkYbiLINYOkI2EPcsGxl0D
 qvZDGVphCNZJWx6Zh8Vzz+WLN9L4UlGIqw63l8C0vipXoLar3pl0hH5jmWrCl07F
 aiVKIUI2bW1M4ri8w1snDQDHb3zBDK+m1Tq9weQh//9YJBUA5M3xXYs9D2xVWC/e
 u/vh4BoJJ3OnTQeJFXDAk/KExVHxZAibkUBeiomtRzUsaqn0z2ftRwUVOb0eB8y3
 1n/wVMaAo7AzVTIOsXAUFw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpxy6be6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 08 Aug 2025 12:38:38 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 578CP1bj027144; Fri, 8 Aug 2025 12:38:37 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 48bpwqpk9k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 08 Aug 2025 12:38:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p0cLrI7+grf3S54eeBOoknRa7syFx2upeaUrUwWHh3KtSj5SEY4z8JPTBCjKNagMmjWmi/kZMkdxQiCGcfyBcPrzr56nKpl9NF8v4qKIsuZ7+HB/g63GyGHbwzhZCretGi1orlaLQIPK00I+dRDfS8OPd+L7Nw/aFzZcg/r7kkQQoibSmynBA7NTeczeW0o0i4n1Q3OhbZW6GzxYYFeCYJffiyoxJW5fO5eC1pDN78GppIe4XiYdS2xBCBlLBb0KKM7ky2wBJzPBXeVqbCWjB2NkWD2ZajyheFHBVu7pzzL/IM4lnRcfnNAhX5r7389uW49/vyAaRYZyJ5lZ/aRH2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zyAntusnvMH+f7M2P+VeQLMYK7Q6lxeVLddlsi4762c=;
 b=CWzOQH/AU+Cc0NNowS/XpvlJR/l1zphHsQ/uD6veXfFZa0u290fxiVwCwxT6vNq8n9cM/znFtAxcE10RBMvRKVhyPfQLT8yT+D/0nAryAVleTabtODjEeqWDdiNKo8NyOtKcm3bqhDjopbNNKURUshsBQIXxIg0ZMIjADI4EJOqt3kBlL+LhjsoKbcxCp5D+UUAPBdsCpQYTKj7GqNB16eWlqIXoCZv5yjmmAcccS7IcgK4GCCuyhhm5KfAH3kwRARiHGQMV3NT8yoIJ5HRtC4THcUZr4iHgRBqOuteAucb579R2nY2VwnJqsaCONyUMt6K+K4cG53IP1a43XJtu+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zyAntusnvMH+f7M2P+VeQLMYK7Q6lxeVLddlsi4762c=;
 b=O3/I9oIA0XKmPZOxrrs6d65F3AnLWL5gMBmpkgWoKh3XHHoIzEhTDof0D+LqDurft9AJ7AUyZAy0q4iezgHkvy377KgmKnkkpivytljy+SwdU+IA5TshLxzIXiJ0UuuRLjEY+V5N5fV8jNzNGtsKm65ib7xS+dRpe56w1l7OuLw=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by LV3PR10MB8178.namprd10.prod.outlook.com (2603:10b6:408:28c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 12:38:28 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.9009.016; Fri, 8 Aug 2025
 12:38:28 +0000
Message-ID: <5a495fa3-5617-455b-a2e0-eb8796b7ad3d@oracle.com>
Date: Fri, 8 Aug 2025 08:38:24 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/12] migration/cpr: Clean up error reporting in
 cpr_resave_fd()
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: odaki@rsg.ci.i.u-tokyo.ac.jp, marcandre.lureau@redhat.com
References: <20250808080823.2638861-1-armbru@redhat.com>
 <20250808080823.2638861-5-armbru@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <20250808080823.2638861-5-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0PR07CA0001.namprd07.prod.outlook.com
 (2603:10b6:510:5::6) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|LV3PR10MB8178:EE_
X-MS-Office365-Filtering-Correlation-Id: 201d0526-04e9-40c6-e773-08ddd67879cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dkIvNGExNFRrcElnRVRiOURaT25LNnJRcDN2N1h5T0p4dW9LYzBoY1UrWW8z?=
 =?utf-8?B?UXBmTDBrLzFLaXBTNW1CNFhZRGgrVjVlYTVxb2MrWkI1UFo4aEdOL3FONnox?=
 =?utf-8?B?bnlwcmJBNEJPaHZNdS9icVRrQU9Dd3BZYmZlMU9LMEwzd0dNcDJJajA2VG4x?=
 =?utf-8?B?WXBra2htKysxb2VvMWtSblpiYkUydzBGY28vY2l4REJsZzFwcE1SYjdCaWlw?=
 =?utf-8?B?SktxYi9BTlY5MHVScmZUK3dQME1sL2FRMjlNTXhRcTJ6UXVFa01qcGsvWGNp?=
 =?utf-8?B?TVhvV1BBME53cWpTaW5NaW96ai9VeG9YQVdZcVJWMlFweVpubUMwQVNZZnNI?=
 =?utf-8?B?eEtuc2FxcllmdEFCUWM4YzRzT2IxN3NhOVN4em80Y0xLRW1pcVRVSzcvc3dO?=
 =?utf-8?B?S1dPT2xPQ2dhU01DdUlHZ2VKb3N3VnppYXRUdXVFeEk1R3J6ZkdhMUhCUU02?=
 =?utf-8?B?ZkdhSXRrVjJxTWNUWitMdlloUjFuVHNhaGVMMy9ia29RYW44WG8yUDVRd3lR?=
 =?utf-8?B?ZUJSYjMrSVZsYmphSHQ5NlQ0VzRZMmFRM0xzVTZRYUZ6VTJmQUU5eFBWckhF?=
 =?utf-8?B?ZjlESWhjYS9uejJtM3FEOVRGWStwRWxvd0cvdytxOC9VSDljSnNZMVNLNjhC?=
 =?utf-8?B?YjFaZWY3OWw4djFRMlFhZDFTWTRENURjaDBaR1E0bUltc243U3hteW5LWkVi?=
 =?utf-8?B?aGwwVkdjYXlmU2VYZ3VSMENQZFcrTWRwQmRjUFBmNG1KemhZSjRtUXg1NGZ2?=
 =?utf-8?B?QmFhcTBuZEJHMUdzYjFQaWZNR2lDc3pTL3UvdkprR2hDTkd2elg5aFd3emUv?=
 =?utf-8?B?M283d2ZqcWJHOGpGWHVkMVdRSlBDQjZlbXpDbU5hTmF4NXIwUXV1UVh6bnNW?=
 =?utf-8?B?a1JWM0FPLzZuVENVMnJSS3JRN0h3S3FzYzlmV0xTQjVMRXJ5QjJ6T1MrSkN4?=
 =?utf-8?B?MDhXM0w1SXMzUFVPYXJRM0RkM2ViWnpPeWZoTXRTMzJxS2Z1Zm95QlREcnpm?=
 =?utf-8?B?aWJiVk5aYnVhL05BWlZmcWdRY1ljckRjbDRZVTFNQTVuZTVwY3B6Wis2ZTFh?=
 =?utf-8?B?d1lsLzNoNUs3MnNaM20yeW81U21BTlBOK3NNeUg4MG1sOEJZR3JGTW05MUZu?=
 =?utf-8?B?ayt1YVY3Ykd1NzJEK2Y5NFVBQzI4Q0xkR1J0dlB2NER3T2RqamxlOEF4L1dX?=
 =?utf-8?B?c091ajJxcit0UjRuS0RVdHA4UUdQTmdhOWMxQ2Y2QWFzRkpaaUk5MHpVWVhW?=
 =?utf-8?B?eW8vL0hsdHBjNHZhYm1PemhWWi83TEdOcHl5b1c0R01QTXZyZ3VybnpHMndQ?=
 =?utf-8?B?aFBRUlZ5UVk4YmQyN0VYL2NLVVQxWUVJclVUeEpTSWs4czFPUXN4RWJUd3A0?=
 =?utf-8?B?SDZ5Z1ZLZEFSQXlSZ1pRNkdxVHF0Y1BYZEFBbGwvbUNtbUdxZkVRem9SMVFF?=
 =?utf-8?B?RkJyS0t5WDlsQTFMNmRNL1g4R3FvdVQ1WDVGVWprZDgxSkVMY1J3OFNmR1Y4?=
 =?utf-8?B?YXF4YXZCdXgyQno3SFArRGVVd1VuMDhaa0pFSWYzTlp5VWw3NjFVZWZJNVIz?=
 =?utf-8?B?SGdYVGxndTdVRldjWVhybjk4L2QvSDgyTkZCenhkbHY2di8vbE1UT2NodytC?=
 =?utf-8?B?QUJ6R05pOEV1ODhZU2NiRmFaa3BSNFNScm9KYzJGQzRpRS9McnAxYXl4MjNY?=
 =?utf-8?B?K3JqWFBncDBQYzcwU0NodmVwMFNYbklGekYyVVFveWlDVDBDeUxTQnVzQ1gz?=
 =?utf-8?B?dkJoWTZ2SE96TTlZY3JXQjFpNlkxZi96bHhudWtXS01aQ0ZXVGdFZzZYTk9l?=
 =?utf-8?B?TjlVK3BwYkNWZGxOT05RVlVkY1hocFR0MHVKYlFoUTh6SEgzYTczSGVRb0xi?=
 =?utf-8?B?dStja3lhazY4TW1RcHVvTHcrQTNKR2hUUnc1RG54L2EwV0JvSC9SNTJjQ0pD?=
 =?utf-8?Q?jxaxeBQxsDI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzZ5VWNlbjJZaUNHVk9RNEd0S0NMd1B1a0V1ZnBmdjlRWDg3Q2YwRndTcEx2?=
 =?utf-8?B?UEJvaVMreG5XNGhVUG5FdlRTZGhYUkFpZE1Zb29xNUtucVlmdndGcWYzRFJm?=
 =?utf-8?B?UVhVVm9QYldmQVBZUXB5RFowNHpTT0NtQjQwY2kvUEprbThOOXB0UFZnVzgz?=
 =?utf-8?B?alhKQUpyWjdXQ3RMNmJIRzQxcTJxMDRLQVFwUkNUbEFwL0NCU0dCejNYRU82?=
 =?utf-8?B?L3pYa3prY1FlV00rUWkzNUpPQlRnZzRqK3hJNnNmZDlKdW83U0V4RHRuQ1Mw?=
 =?utf-8?B?RnU4a3VzWmp6OTU2V2JFZURyL2ZDTW5iYVRtYnZYTTV1SnB2akpORmZaNllj?=
 =?utf-8?B?a21GZ0VPT0RxbFBTTVEwcCtBbTI5SHlFYlZPM1hPU1NuOXVtM2dmcmVsMkNz?=
 =?utf-8?B?Yk12eG1hVHJ4dGx3UWw5MFh3ekJhZzFidUp5Zm1XVXNBRXFKS0RRbjdwOUEv?=
 =?utf-8?B?cndreGJVVmJ0VDNpT0pMV1pPcUtKK3dRalBZS2dzTERZUUJ4ZkpBend5MDlB?=
 =?utf-8?B?R210R01Ud0tGZHVNZ1BlQUtpcW05cEZWWHVWa0xNMmlJMCtpRFdoTkRFMlJ5?=
 =?utf-8?B?REVUeFVqSzNLOUl2UFh3M3hMTWtjSDVYSjdYYWNaOE8yZUdBM0cvenltQlho?=
 =?utf-8?B?ZCsvMWZhSVJhSHB2YTVHRXFBcTdZeHc2eWpMeVBKQ0VJcnlSdlRRWVhVbDl2?=
 =?utf-8?B?cEpkd2UvRFd4TWwvN0ZoVEFHMWlTTi9uY3lRdmdBRkZFc1pPREMvRmw5NXRw?=
 =?utf-8?B?L0xLYlMrczh4VWNVQklYT2lyS2MvMkRmenJJQ0I0bk5rNkZKajZzRXBIZnNY?=
 =?utf-8?B?MW02Nko0TVI1OUwvbHJEazI3S21jTm5teEwyZDY2aXJrRzdlZkk2QlJwcWFn?=
 =?utf-8?B?VkdUNVd0OUN3RjFaSzFseTl4aXJOV2VwdlFyRk9STCt6MklzRkh5OTlJS1dL?=
 =?utf-8?B?Rm1ZZTJseGowZkZQbHVJZ2sxS3d1cGhic3ZlZjE0UzBnQUdmQThQc0dmMjRI?=
 =?utf-8?B?RHNNS2hlc1lNSEVVWVhGOXNoSDBnN1o1R3pwemtVZ0F3ajFRblJ3MVQrd1pO?=
 =?utf-8?B?T3JlU2VsWXVtZVFRdjFTOEw5Z2ZaTzVvSTVTcEowbHd5YVM3cFVqNjdOYmFt?=
 =?utf-8?B?dDdLOGNrREZCMmdTbURtclJiT3JwUU5WR3Jkd1ozd1VZaDlXdDhGcmVtTm5J?=
 =?utf-8?B?U2VTL2JyZjJYTEpWWHVHdmdVNzlvdE4yWnpmSFBTb0hNZHpIa3FiZ0xJS3Rs?=
 =?utf-8?B?cnJsSW1GUkt2dWEycEJYSUV2QTErMHNsNXBpNDljSm1UakY4VWlwcjBPRmg4?=
 =?utf-8?B?bHhMbjRSRjBrQlBFdDQ0UFdCUUtPaUEvMGEzSTdaV25RYVZ0Mi9XOVBiZjdO?=
 =?utf-8?B?Qy9UWExnSkI4dk5KdThHK0pUZUZCdEZiQStIRkpySGsrTm15ekFENjN1aTJZ?=
 =?utf-8?B?SzB5TER4U3VpaVZEM3J6MzI1U3gvdVpJTmJtNFZHM08zcHMyS09oK1BzK2Q4?=
 =?utf-8?B?c2xNbXUzQ3JrS0d5ZVkrVDJGblhneFU2a3IydmM1YWU2bW5UWFJ4RkhhczFJ?=
 =?utf-8?B?c243bGN4MmptU01zMjJsY0cxeWY0Z09UdjhnVys3TlBtajVGaVBOM2l6bUtt?=
 =?utf-8?B?enJ0eWN6N2s0VFNJbVNYK2RiSms4Uk1qK2pyUVJqQnNsYUtXLy9GaXludXZy?=
 =?utf-8?B?a3I2RUJLNnVqZHVnWHJLV1JQT3p2REc0UUlLT3M5VHNEWlV0L1JIRXVrbDJ0?=
 =?utf-8?B?K0pJeGE0V2EwSHRtcVF4WmE1ckIva2FxYXBPVHJYUGZUK1JUOXo3dzFnN2k2?=
 =?utf-8?B?WXd2MzdtVE53YkYxeG9WSkJZTWE0N09xUWlqL1Q4a0IrMTlLSDM0SUg1WktC?=
 =?utf-8?B?U0gwQXFhaVdJN1NVRHMrNFR6N1BsSXBCRmphWDhKTDhkWFpXOUdyM0FXWTcr?=
 =?utf-8?B?L0lGTnA2cEYzL0l1S2R3MVAvOXpZZEppMlBnM0JPZEZSd1lwenlNamhEbysx?=
 =?utf-8?B?c0FUTGMyWVk2RXZpVVlOaXZGV2NoUzB4dTVPcGZiaU4yS2ZiaktoZDg0cGZC?=
 =?utf-8?B?Wk9acWtUU0N5dzI4UW1VU3RKckxRWHhSNXRFSTlEZkxYcFgvNXRtclhUZ25x?=
 =?utf-8?B?R1pOMTVmbkZWN2VDQi9SRE9SeUgvWWVHVFpKMzhsanpzSVNQbU5KT3ltRFhh?=
 =?utf-8?B?Mmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9+LpYj6Px/afyRh/9eG66nI9bdsEaubWRMWnkLimfqSHrMBPbp8xVekRkR+7RDbonyYAsii4Z5iGj5EMjn9wQIPbQlpcGHUPdMEIZuK0ol2q01iLA8qgTaJQ7OtuMx669h0X8ffsNDUyHiYnAQ58n0Pwi7sWxJB/Z2zCU8SgNbyGyAIYO4ilF8lhvsVciIGjT0oXUqZm/9eF8Tz5RGqJgia9HabJe1FDhrv2GxTOX9AS1YCys5MIOhycVergeeNEN2sUJpzKgQ7oiZIyPORTYRGmv+WWfjoDxnUr3ojKKFVuBBm8cb7wh96VlH/4tXbVdjfmQHD6zkWyn2nZkdBk+JDdWySxvACdnw6mS/LrtNcMH/yuFibWHw41xV19uQKrjJaU3isr2EmLL0DDy7lw7SnmRoPeTiOZviRUx0kLVChVx2O9hIblLc/WIdOfBY5XmsEQVc+zGmwViU6dHnbcNLpxVbZIbHlVjhS8GUSMadJQPvpEQFo82bLlgxnlBuDdFU4PxzOKGe/izL5vaY80yDw8hKg8CXbBL8k4skxp5LVRXuBsTExLRYmzhznv1Qm8xf8RVvzoq/ZXA4GwDhQa3CAWmt+mCKWrLlO0X4sxNkE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 201d0526-04e9-40c6-e773-08ddd67879cd
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 12:38:28.6633 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 41oHmhngt2dW5zDs66qsiC8QrrH/m4NOEBIJzlStAkrxoqRs/6/G/n0OhY7WXe8LRngqj3eIqSsuq8C7p0Yonu5Ea8NvDv9WI/8ESoquKTE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8178
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508080103
X-Proofpoint-GUID: f7doZFKkbkSQnaUxCXZ-GrdfIiX21EkR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDEwMyBTYWx0ZWRfX5QBsAV1BpO7f
 79UoybhOOwj/nORvSmRN/XlOL/JJJsE9qeYRsI+gI/LtmqyDRXM0alG9f7UTeiVSQYdGyfNYT/7
 JDLWy4nzFAuDxGxsoq/8CVGel1ZAsDZmJpQcsyQnL02B9dCgeYBZBUNLqk+xFypcXZWSNeZKfnO
 BnvJ85WVkkjdBXHTLRVRGxLFu8w+FJbmLX3sd68Xjc5/sdeY4QjRFWTXC3evWHUmybcpRm4XCWB
 3N42aLwxN4fsjMEpIqyNccDWkfnVvYGb0EPuBgJE6UwY6UpY9Ebsk8x5fWAvkKjSJZ7hcZLCVkv
 EEGET+bl/keuXFQwlLU0VbXXgXwWAIHYcqaEYu9hv1QCJYIW5GgZ0GpXkEMFJMiQhfOdjCTJ87R
 DQCcXZQzzM5p8+fqcJr0GbTFl475AT06v1SNDoEUzLvsOm+PsRtdWbmXEG5X24cCFH6gUgbH
X-Authority-Analysis: v=2.4 cv=Y9/4sgeN c=1 sm=1 tr=0 ts=6895efce cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=jVlXeOt57ODvga4GqqoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: f7doZFKkbkSQnaUxCXZ-GrdfIiX21EkR
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 8/8/2025 4:08 AM, Markus Armbruster wrote:
> qapi/error.h advises:
> 
>   * Please don't error_setg(&error_fatal, ...), use error_report() and
>   * exit(), because that's more obvious.
> 
> Do that.
> 
> The error message starts with "internal error: ", so maybe this should
> assert() instead.
> 
> Cc: Steve Sistare <steven.sistare@oracle.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Steve Sistare <steven.sistare@oracle.com>

> ---
>   migration/cpr.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/migration/cpr.c b/migration/cpr.c
> index 42ad0b0d50..908bcf83b2 100644
> --- a/migration/cpr.c
> +++ b/migration/cpr.c
> @@ -7,6 +7,7 @@
>   
>   #include "qemu/osdep.h"
>   #include "qapi/error.h"
> +#include "qemu/error-report.h"
>   #include "hw/vfio/vfio-device.h"
>   #include "migration/cpr.h"
>   #include "migration/misc.h"
> @@ -100,10 +101,10 @@ void cpr_resave_fd(const char *name, int id, int fd)
>       if (old_fd < 0) {
>           cpr_save_fd(name, id, fd);
>       } else if (old_fd != fd) {
> -        error_setg(&error_fatal,
> -                   "internal error: cpr fd '%s' id %d value %d "
> -                   "already saved with a different value %d",
> -                   name, id, fd, old_fd);
> +        error_report("internal error: cpr fd '%s' id %d value %d "
> +                     "already saved with a different value %d",
> +                     name, id, fd, old_fd);
> +        exit(1);
>       }
>   }
>   


