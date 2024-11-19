Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A70F3D6C2AF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 21:52:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDW8f-0005Mx-6Z; Tue, 19 Nov 2024 16:52:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tDW8d-0005Mp-7g
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 16:51:59 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tDW8b-0000WM-65
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 16:51:59 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJLYkJk026186;
 Tue, 19 Nov 2024 21:51:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=iKgIudXCW+35GOF4xHzAB8/PubSVQe8T9vQsIN56yS4=; b=
 REXQ0Pr72/0Zu+7I8U1/Sg6E6yWRUbGyj23NwgafZg16xm6GS2FYt+iU4cb4lHmC
 6VQk1iGXH+WzSd/AzPGsu3wPRp4rQkP3XQuy+v5EXWUkvzrRUFZO2bh9i6+3CSJk
 xXk3lXbjHLZZqz61JmGVzSrIa8HnVuqUeyyzZwmUzuey7bMVeu+jAibUp7siiGp0
 uMvCpi7NAMqPPeFXFmGG/o8TfufqtWRXP4oAGCe3wggmCwuiij+x2JtVXHfs03/R
 v6VKPJVb3NsiEbhMnAvoSW0DtTfpSMjZT7b0Y//Fdov9xkyOErU6aTB6d4NosOzc
 ewUDAQLaaQWGGwFyITxYyg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xk0sp43u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 Nov 2024 21:51:53 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4AJKxd5E009019; Tue, 19 Nov 2024 21:51:51 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2045.outbound.protection.outlook.com [104.47.57.45])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 42xhu9cmd2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 Nov 2024 21:51:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mv9t/xgDjLC0SUs972aOKg+vguUqM2f9rrje8GiQPft0Yx4RA/7O2uLWs3W6vhVtTVNPa75+nz/pQd0pVe9lXzkcMpe/pNmCeQumzBGr+QMyaBKRCr76xtwkLxN03Ao3RIq8uWtZ3nEs3BZAejpVBOeQIDggtD2+f5BMY0TnB/jayD7JB2qnpo8T5nznqeniK6pHB4a8oUQ00FZKy7Rsk/Ll/hj2f8NzqnSI46LDolyvWINApZJCnfOndC/bKEXTfyeSuHkJx8ZZS3yn8Lqh903eRBjV5Xhi59B8DBbrsAp+ZNrepTa3BGRAbbyWmY/L24pLKb1gBNy2vw98dxKmEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iKgIudXCW+35GOF4xHzAB8/PubSVQe8T9vQsIN56yS4=;
 b=wg09Mo5i9d8A1Es4sHSV4XYANZ6y9T7la2KXpXmnv5Jzfph3o0JmKZdfJEKKLD2D678TzHwjmHJkFNUlvZbr+ta+bM8Ej+1ARrA2yQIx96EmLNpC0eT9/Fqrjz93c243ozcBFsoPg/aG+ezgms97rsPe16TZgzfim0jJn+2k+neSqjATjGO85zli4W7LKQvR25KI03HtLy5hXqZZzUqcHfJlJgOIiVGD060398ToJle4DT8YrFWzaaHgjiJn/gzCcc7T8KkkVqzhAm2uuU1fovrVX1kzKgmtiRd4N47lQ1ySE4fi60bRPNNmxtrieVYRn3FKIx6g8DRaJ/Pxp/3RxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iKgIudXCW+35GOF4xHzAB8/PubSVQe8T9vQsIN56yS4=;
 b=kpmwSrkTpJQtLrAlrMrLRQVMGLXrgvPAqOAx4Pfs0Tj+NALg2sAxRwfVeFe04MdwHcpfMpvldwTN5he7BkVd5+YU94bq5me/jomY20ibKRhdiNPAXtNePTXaBQaFpbr8HC8KLNHkXdtjiCvEW5DesfExutmSjo4fqjnDdZIZTEI=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by MW4PR10MB6463.namprd10.prod.outlook.com (2603:10b6:303:220::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 21:51:45 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 21:51:45 +0000
Message-ID: <710bf14b-6344-476f-a15f-97cfc138eaeb@oracle.com>
Date: Tue, 19 Nov 2024 16:51:36 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 11/16] migration: cpr-transfer mode
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <ZzUg9w0Kvfuleuxk@x1n>
 <51967cb2-05ec-485b-a639-8ff58d565604@oracle.com> <ZzZJvTldpe3D4EO5@x1n>
 <c53feba3-d448-4494-8dbf-0725a2dd8dba@oracle.com> <ZzzyOJT_mDh37_Py@x1n>
 <c56ffc81-b065-4dd0-ab06-eb79912dcaf7@oracle.com> <Zzz6NVoJss4JdEHh@x1n>
 <8c56ac9c-c86a-48c1-9172-8f014220c37d@oracle.com> <Zz0DJ3RB-bVofkmo@x1n>
 <5860c0d6-98d2-4f52-8a0a-e161a6205ba7@oracle.com> <Zz0HwfIDucF7yssl@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <Zz0HwfIDucF7yssl@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0023.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::36) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|MW4PR10MB6463:EE_
X-MS-Office365-Filtering-Correlation-Id: 124496ec-ffe1-4b6c-2e58-08dd08e45c4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QTlORHA4MWtHOUpkVTNobWNwUFM3VE1rVjJNaldudUlzMXhPTG1pODZpRkFG?=
 =?utf-8?B?aUVHUmxuYWZ3L29GR24wVDVlQmdUWVRPalRDUENFWmIxN2p6WitWeFprM2E3?=
 =?utf-8?B?cHdLZFV6OXl5eGN6bHp6QTZBK3MvSnJtSjk5RFdjNWpHalVwOVA2R08xeVlN?=
 =?utf-8?B?bzhxZTBUK1RkTlF0dm9udlh2UkJNakFqZjVWVkhpQ0ZwU2tZZkxnSDZmTVdS?=
 =?utf-8?B?UHI0cTB0cmVsU1MyNFY2VWhSZlJjcDVLMUwyWjJYVkV2alhVN1U5TkROMU1R?=
 =?utf-8?B?dzlTL1JFRUt4QVJSck03dHM2SEJxU1V0eVRWV0NkY2VWQjN3cVdQcG9yeWh6?=
 =?utf-8?B?YXlad05obERka1FRMjVjUXViRUozVmRWRzg5RldLZk1qVFNseGVkVXZzUko0?=
 =?utf-8?B?ZnpHMzdkZVMyUXpRNENnUHFzYW10MisyNFg2MW5ndzBoNWdDbzZ5RVRhRSt1?=
 =?utf-8?B?T3RQemNVY3hkZHdUSmxzd1BqLzZkYXF2Vm1lWkg3RG1SZ0ZWc2I1TVpkQTJF?=
 =?utf-8?B?cHNlVUpkNzZtWjA2MWNyanFUWld1My8xQ0N2M2IvaXZRbFBEWlhUYjdyWG81?=
 =?utf-8?B?UDUrNWo0TXl1elZBWUdtRE13d1Z0Y3BIb0pZay9wbEk1YWdsekVXNXU1UDdZ?=
 =?utf-8?B?cUlxZDlQdjRXTTV6MHZxUTRMVEw1MW9KeG5WbFVxc0NlTGs2dnprNGVOWWx4?=
 =?utf-8?B?WlBiMEFGRTFOd1dDRytISEN6QXArMjZBTmxabTR0eUsxNUZJMk9qOGJlRmQw?=
 =?utf-8?B?ZnJKczlOenhTQk43d0ZEV21DQWw2TEUvM0p5YW9rZjE2dnErWWxod0ZUR2Iw?=
 =?utf-8?B?UitlYytrUWpxUXB1NEJvYXVoQTdBUDd3MlFqYUlPNUtQNFJDcEc5SzhyUGg3?=
 =?utf-8?B?OWp0R3VvSXlJbmRPajE0QXRDNEVFZUVzaGI2TGlINTgwYzVaczR5M0R1UWhn?=
 =?utf-8?B?SElibERUbjI5ZDdmbWlEZTVBRnFiWTB0VGRYMDJUOWl2N09nS3VvUWZReGg5?=
 =?utf-8?B?YkpCUEE3SE56UGZEa0taTkZpb1pXeSt6QW9kcjlMQTRzWE9kY2xFemNFRlYy?=
 =?utf-8?B?WTVGeW55Rkc3V0Z2czRobnJjSDVNYXhHMlp1dGpGVFZacXREYi9mZzN3d1Fw?=
 =?utf-8?B?K0FJb1ZOcGwzTE1sMUQvVVNwZ3JYTG04N0R3NDJwc0ZpdThBTnMyOWF4UVBS?=
 =?utf-8?B?a1ppSHQvYjliWnZ0N08xM0lpMEFGS3Y5aTZrZ09palZHUXJJTHJBcHJqOEZE?=
 =?utf-8?B?cWQwZEFySE1FbkI1VFNTZDVQcGp6MjkxMzBqakdHQ1FSbXMwdDIrR3pCWXpF?=
 =?utf-8?B?NSs2WWtGMDh6UUc4NlNYRDNES3hzdzRoVFc1U0tReGRvSGFPQlpLWjlUZDdy?=
 =?utf-8?B?NE1IUUkwUXFMS1E1YWEzbzZ1ZG1zc0FXeW9pWmxiaWNQRW14RGhzWFpnVVI0?=
 =?utf-8?B?TFNKU1pkYUZXa0RGbHBXNk5Tc3ROeTduSFFxTHRDcHlKYkFyR2dzSlN6RkVx?=
 =?utf-8?B?a2NwZ0FDM3ZjSFpwTU5kVnRYRUFaVW02eklvNzNtMlZ0K2x4OThRWmp3bFVH?=
 =?utf-8?B?bjY2TWltVmJpRzk1ZGJ5MVBZKyt2QWYrU3JiMWpSV1lTS2QxQkNLSTN2T1dy?=
 =?utf-8?B?SVRsamExMTlEbWtpdnRsRE9pTlhsZmNmOVBtVWIrZHp5WklTamxZT2QxWHA5?=
 =?utf-8?B?RDlYQVVpWUw5Wk93NnQzVGkxcjVleFlyY3NPRlpkSys0Rnl3eDdQQm8wRitB?=
 =?utf-8?Q?TKyYdW1cz80DrF0tYMCX6aEi8tmvtzhE+ShYvz4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zkp0NnU4NW5lVTJnUGp2ejBqM091OVBKc2lFRHRoNmZXMmoyRktrOTFSTDlX?=
 =?utf-8?B?bTN1YWEvVXFFMHB5SENlaGZVWWMvSHl0WXVtbkhUeDMrY09LSnVwM1hsUU1H?=
 =?utf-8?B?dUlLUkhDVW5QWXBBY2JKcXlJTE5IUjhETStUOEZnVEJPTEtOWEsvZ3dkUERD?=
 =?utf-8?B?bzZtMkdKK3lLYXQ2SVBQemxqaTVyR0lReHRUdnBYYmhHU21ZV3pPWHJBTFp3?=
 =?utf-8?B?QnNpM0kycWh4cGFTd0NzRWZYWE1hamp0b0Y5VmJSSWMrNGN2bHMyZThDMm5o?=
 =?utf-8?B?WnZzQ29rT25JNGQ4NEhJeGRCTGJ3SUxrSmFjNkdUQkZXKzVXU2hqR1BIc21C?=
 =?utf-8?B?a3lKdktxOTBEVHo5akJ3cUJ4d0JVWDVZUjdzVEtLR0xUUFpaeHpjaWNTSDZl?=
 =?utf-8?B?VW1MK3FtZ1Z1b2x2WFBqaWxNMTlTY3JsakdXUHphZ21YS3lySDVqVmFvZGNi?=
 =?utf-8?B?UFZPWWg4dHJvdHoyR3QvT0V4dFpRRVAyWXYzMjRCZFNzbUxydlcybituZko0?=
 =?utf-8?B?SFRyZ3RaTGlWTjUvaWQyd2RNVWlYcXNLeXFzekdCa0YvekdjZ25CTkpTZ2s3?=
 =?utf-8?B?SjhqcklCWFY3Y3YxNnEyNHJzTDFYK0ZNc1NTSFFwbEZXSS8zT3NHd1h1Wjhm?=
 =?utf-8?B?bFVQYXROWkkvZlUxVDZ5alQzRGY3UWlXcTlrOUplazZPTFhCTTU1cE9lTWd1?=
 =?utf-8?B?ZnY4NnE5VVVLbmVCOC8vM0RJa0Z3amNta2VQSTFWWHJXVDg5Qm5FN2FWOXZ3?=
 =?utf-8?B?SkJMODkwM0Q3UERwQmVPQURxa3p2NzBoajhYMFRwdC9EVkYwb2ZvMHNpZFFQ?=
 =?utf-8?B?bXpVOEtuVENqd1hSYlhIcHZObFQ2OTh1YVVMS2dzeTBwQWdHb0YwekdMRnB3?=
 =?utf-8?B?d0Y3S2dYTjgvUlBFd0gxTk1YVHJrSkRvVkpqUDRCc0h6QmdOdE5ERmtWZnZW?=
 =?utf-8?B?ZTJJYjBTNW45TmpBWjh4VmVuYjBSNUlhV2V0SGNKeWdJb0dKTXIvU0Q3aXFE?=
 =?utf-8?B?WStuV0VOaUJ2QUNtM3dJT29nT0FMV3hiUS92c0VMR3dFREtySCtTbU0xOXFZ?=
 =?utf-8?B?M3FmanBHelpaRjdvcy9aZm1CMW42cWU4WDdsYUJ5QzhWWHlVWHBZdXFjWGxz?=
 =?utf-8?B?c1IvREZodEJKMCtoK1dBL3pBM2VZWWx0Ujh5OUU0WjJIMS9IQVdrUEF5ZGFo?=
 =?utf-8?B?UThaY2c0NUVHNXBDbnVOUXBxKyt3Nm5ZNGpCU1RtTTUwRGtmZHR6ZDhDZHNV?=
 =?utf-8?B?Z2plQ0ZxeEN0c2U3b1lqSjg2K3cySGdMVnBJRTEwZXN1bnd0R0RMVG02ekcw?=
 =?utf-8?B?ZklEZm9OTHpIN1F1V0hjRUVoZEUvTWVrOHlWY2FGNERNdkE3ODhmVVhzT3Ji?=
 =?utf-8?B?MXdRYTlMSmJzb2lLeGdwLzk2R2lDMG1SaHBNVnJJdENraDh0VG05VFc5YW5u?=
 =?utf-8?B?Wndady9DRm0vQ1JCUExJWDU2N0FyaDhURTJOK1FYKzZSTG53QXRIYVpQUEZR?=
 =?utf-8?B?M1M0WGp3RVdma20rQzVuRXVKYWNoNHh2NXAvN2s4VFpJN0Z3Tm1OQTgvWVRT?=
 =?utf-8?B?bzBRSzR4MVJSRlVkaHpESndEeHJ2SCtHWENMZkt2cnBLNUgvZmRuaVJ0NVBQ?=
 =?utf-8?B?SHFGU3dtVWhtZ00wOW9UQkU0SXZROXByKzAvUkhRWmZJSmtkRjlUb0VDUURt?=
 =?utf-8?B?aEFsWDBRb0ZiYWQ2KzRuazRweVFlTlRpSVBRNU4wZmUwM0tPVzZuY0lNaEdv?=
 =?utf-8?B?VmdTZk5VWDNZc3pYWGZJS1dWVmh1a0pXaElqUHEyUmdneGRCYUhQSkkxS0RT?=
 =?utf-8?B?MXdSOGdBeWcrZFFtVm9MaE11ZFRjdHlMYy9UQ1RoS3NCdHZSMW45cDE4bTZR?=
 =?utf-8?B?a3VWSDZ3dnNGejJlT3VONFFZYWdwaUQvT0NUUTQrZmV5OUovTUVyMElKd1o1?=
 =?utf-8?B?ckVhdXhEcjlaZVFJZFFTenlDTGNQU0UySVNHNFV6ZWdjazlBUkhBcWtTK2dn?=
 =?utf-8?B?NFVBTVBQT2EydU5MUU1Id0N4U1ZZR0xIMTM4MndZRC9uamJxdmxleVhTbU1T?=
 =?utf-8?B?ZVVUMWpyUDdqR1ZyMkhCWndCU2d1c3NBYjZzQ1NZM0xldzY4WkdFVzJ4ZlFz?=
 =?utf-8?B?NTd5Z3ZHSENYZVZpTXhqc0pzVCtpRkhZVGwvcFZYYll3ZHcvcGFYQzBGczZ4?=
 =?utf-8?B?WFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WAYwrV1CmqG8t5iLoCr9YWcuQwqZTpUwrunzIvDczDNU1RhlM0OaIvbAGSK67mcCvusWVfu7trinr1Ywy1fQXzpoEDyf6czQ5s38Wq0XCpCdeOVPlpkWH4NJv1CmfC+m+Ir23kaMVFpmHIyM8gXUu3MixLNoMQydNN7DsmJ+qq0Y43fOvn6Jd+iO5X8Egx1rTMuXtXF0v47bg63wr8PPisCNDUD/MMvfSCAvCrKH+f5EXXUKILHIvLlK4Ii38S0A27CpTffslIrfCyApDLqumPeaKF+NBH3dL63ar3JHylrDiA0pz2juPcWi7ea9c6BqDiKG/9H7+lq7obtf2XR/gut6lpD4ElbxNEFVbvLwszSSjy0bQ0O16RdjW01HHr+QDawwj77p2qvb0PO7StTpRhptu21ksJSlbB5nM9q9WJDYPNAS1eFTPj8NSwbzMU7aj+xml+VcWNi7eOcvrj1SXZ7RFfK9iDufTZ7KK/CzvoXjnsUCvWFds5uFA2JcT9/ulIuXOrmq11eLB6VQOCxCSKlXKZT/xMKpFavcBTHX1U0NTml9IShQYVXnBmlCOaRrOvxvh3xqwz87IsXmz8S9qSxI3M6ti/0Ujjk+IjIC27M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 124496ec-ffe1-4b6c-2e58-08dd08e45c4d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 21:51:45.2671 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uq1WugI2B3RfOGzEpLt1f1C21DrkvM5zNHKNtwcngC/mbwcsKIFL3UtVWME7F5nom9BlOJm3uAoh7a5/2rLdveGUwMTVyPLwR5Mmjx0sorg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6463
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-19_13,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411190158
X-Proofpoint-ORIG-GUID: 1uhcYh6Dz_HIqEccuwUnpluyrWUktga_
X-Proofpoint-GUID: 1uhcYh6Dz_HIqEccuwUnpluyrWUktga_
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 11/19/2024 4:48 PM, Peter Xu wrote:
> On Tue, Nov 19, 2024 at 04:41:07PM -0500, Steven Sistare wrote:
>> On 11/19/2024 4:29 PM, Peter Xu wrote:
>>> On Tue, Nov 19, 2024 at 04:03:08PM -0500, Steven Sistare wrote:
>>>> On 11/19/2024 3:51 PM, Peter Xu wrote:
>>>>> On Tue, Nov 19, 2024 at 03:32:55PM -0500, Steven Sistare wrote:
>>>>>> This begs the question, should we allow channels to be specified in hmp migrate
>>>>>> commands and for -incoming, in a very simple way?  Like with a prefix naming
>>>>>> the channel.  And eliminate the -cpr-uri argument. Examples:
>>>>>>
>>>>>> (qemu) migrate -d main:tcp:0:44444,cpr:unix:cpr.sock
>>>>>>
>>>>>> qemu -incoming main:tcp:0:44444,cpr:unix:cpr.sock
>>>>>> qemu -incoming main:defer,cpr:unix:cpr.sock
>>>>>
>>>>> IMHO keeping the old syntax working would still be nice to not break
>>>>> scripts.
>>>>
>>>> The channel tag would be optional, so backwards compatible.  Its unambiguous
>>>> as long as the channel names are not also protocol names.
>>>
>>> Ah that's ok then.  Or maybe use "="?
>>>
>>>     "main=XXX,cpr=XXX"
>>>
>>> Then if no "=" it's the old?
>>
>> Sure, that works.
>>
>>>>> I was thinking we could simply add one more parameter for taking
>>>>> cpr uri, like:
>>>>>
>>>>>        {
>>>>>            .name       = "migrate",
>>>>>            .args_type  = "detach:-d,resume:-r,uri:s,cpr:s?",
>>>>>            .params     = "[-d] [-r] uri [cpr_uri]",
>>>>>            .help       = "migrate to URI (using -d to not wait for completion)"
>>>>> 		      "\n\t\t\t -r to resume a paused postcopy migration",
>>>>> 		      "\n\t\t\t Setup cpr_uri to migrate with cpr-transfer",
>>>>>            .cmd        = hmp_migrate,
>>>>>        },
>>>>
>>>> That's fine.
>>>>
>>>> I do like the incoming syntax, though, instead of -cpr-uri.  What do you think?
>>>
>>> That'll definitely be lovely if possible, though would any monitor be alive
>>> at all before taking a cpr stream, with this series alone?  I thought you
>>> dropped the precreate, then QEMU isn't able to run the monitor loop until
>>> cpr-uri is loaded.
>>
>> No monitor or precreate changes.  I would parse -incoming, extract and use the cpr
>> channel early, and use the main channel later as usual.  It's just a different way of
>> specifying cpr-uri.  I like it because the specification language is more consistent,
>> referring to a "cpr channel" both on the outgoing and incoming side:
>>
>>    This mode requires a second migration channel named "cpr", included in
>>    the channel arguments of the migrate command on the outgoing side, and
>>    in the QEMU -incoming parameter on the incoming side.  The channel must
>>    be a type, such as unix socket, that supports SCM_RIGHTS.
> 
> Ah, that's ok at least to me.  I hope defer could still work (for Libvirt),
> though.  Probably something like main=defer,cpr=XXX.

Exactly.  defer is in my examples above.

- Steve



