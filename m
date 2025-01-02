Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B3E6E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:36:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTQ3f-0002ub-LK; Thu, 02 Jan 2025 13:36:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tTQ3e-0002pH-1v
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:36:34 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tTQ3c-0001PH-BS
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:36:33 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 502HXoPI014715;
 Thu, 2 Jan 2025 18:36:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=n+VVrn76nBYtJ0IOxx7KDt3qaiR39/bFgCq1GpwBNUQ=; b=
 jw5Pjo83FxjFDb/BwunyHMe5UVPxUmQxqdF4GBmgBjmbEJyClvQoFTx6udAe2rZ6
 4RftMJ87gza19SRhs/YxertCec+Y/vWbGnL5Q+reCYHVAApb74XAYZ1DzzpEMKGp
 e4VK1Ywz7qE+Vp7xaCdZiwYvfMFDSSO7lC1WB04u+lWWRdxtuuVQDQuoXcl50nh0
 WAX+c5g4PZu1TCxPndZUy79p0neKNwLIkNHkZD1sOhShDJ+9BGL2NpYQC+aTXM9n
 8bJ02uRquWHu7QO9yn1FMfQg+7YR0b+8NXILdABWwsavg57fbCO0tUWLos0PFGIC
 WTEPaYU9G0bYSy7fIloqeA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t8xs6d3m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 02 Jan 2025 18:36:29 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 502HjRNN011782; Thu, 2 Jan 2025 18:36:28 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 43t7s8x8ej-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 02 Jan 2025 18:36:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TismzApP+XKj8GzSH1dKWBeP6jTLK2QqJLxsnliAn0BLn+Q94UwFj1y6qv+/TaoUwfWdQ47Lh/rIPJ8uQO93ISqnCd3b7xaM+LcS54Y2Im58gb1cLsn2JzxbNIpxms6708475ao8rkT9wcnzyo2GMqvcJr8Q3LoAdYlxt8nxaT0xiKsz9fcNdV5RILLFu4D4/enBLh7qIYxoXvavpzWq72oqBRO/udMTdwQigramtRmSakijDXfNDM7ICEcA+tRqo4wgOPABRBP0QrevRoHGipDPgN9A69YHYKYnnFwaVtuvm5EnBW1hY+RtuX5pGOKP0+nFHjsB0G6hje7xiGakxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+VVrn76nBYtJ0IOxx7KDt3qaiR39/bFgCq1GpwBNUQ=;
 b=dND5Lr1wfvjlXFGV2mSl2sJ9A4bKsYPZ+tI1eP6ItntY/Uw0ixOBKZrIOSOcTa7O/1NUHGjVkYASeGQ/JkZkYkPBF0LAxY4qnOFlcOOnIaEtfdATCBKKHV7/0lF8x3KAhOX7l25F4AnGz1hifNoHKL/J4/xIN45GxzGE38QbPDmSe35f7tzjM/huXteWN4S7wPq72k6jfOGf9hSjZt7XG6Pje7ytJfs/r2L2XQQ47ABD9yDlujYa+/Wi/8PTKptkg6+ogZhl+gxmwh4uwj5sdm+jRC9yINfFer1qkK53Sl01HiDh0fVsZgm7R6h/POImH/xxq8EwhiLOrOALi+e46w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+VVrn76nBYtJ0IOxx7KDt3qaiR39/bFgCq1GpwBNUQ=;
 b=GJBtcJ2hm8QNtkG3zz4gO/94UKbcmuGDx4vv+DLWZ2+IVJlPi3ijtT8LpjFpZWmGNgUQU+KTrMVoi6zL+KiSjHPw8eqky85TNPVc0fCxoOqN6X3zwOnwuWSwz4+VzQCzjxWTYOUsHIaiHI3igjc8wAcu6U05ovBjXpTj6P7B5Mc=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SJ0PR10MB6301.namprd10.prod.outlook.com (2603:10b6:a03:44d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Thu, 2 Jan
 2025 18:36:22 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8314.012; Thu, 2 Jan 2025
 18:36:22 +0000
Message-ID: <e5011bc9-9ba9-4978-be02-a26a6e4ce65c@oracle.com>
Date: Thu, 2 Jan 2025 13:36:20 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 21/23] tests/qtest: assert qmp_ready
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1735057028-308595-1-git-send-email-steven.sistare@oracle.com>
 <1735057028-308595-22-git-send-email-steven.sistare@oracle.com>
 <Z2sRb-6ziWJ-FU6u@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <Z2sRb-6ziWJ-FU6u@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0842.namprd03.prod.outlook.com
 (2603:10b6:408:13d::7) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SJ0PR10MB6301:EE_
X-MS-Office365-Filtering-Correlation-Id: f63e7836-d7fe-429d-dbaf-08dd2b5c5af9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|1800799024|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q3VoQVhZUy9hWWZBRFBjOVN3d2ljeXNBVVI2bTNvN01SUjYwVXA2NUNzWlNO?=
 =?utf-8?B?bmxvNjJRZmZ3cm8xcEw5Yjhoa0FXNmRNSU94Q1Njd2RrMUduR0thWityMDJR?=
 =?utf-8?B?VEpjMHFGRXZXQnYyN2pTcmJ1dXJybDVSOUQrYnltWUNicXJzYis5YXdjRHpX?=
 =?utf-8?B?MjlDbWVOQndQUWNBVTNBR3E2SSsxWmFJbjB6cllzMDZXaElTTnJKM3VxTG1j?=
 =?utf-8?B?QnBNcjNXVEw0VHkwU3lmMExWU1FsN1oxZ2pvdFpTTnB4NFFkdW9GTVNXNi9H?=
 =?utf-8?B?OXE0SHlKMS9jN2dXeTNqdkV3aGFYM3BQZDBwV2YzOGNJUHN6Z0Fpc3RqdzhM?=
 =?utf-8?B?MUx6bFJNeHVYeG55YXhSQzNHV1RjSlo5ZXVWTWRHZXcyWE0waXl0OWlpWSsz?=
 =?utf-8?B?elBWR0p4SUhpeEJPZXVSenpQUmE5c0lKUkN1UzZHb3k1U2ZVVnBXT1dEREdo?=
 =?utf-8?B?emFkalNCM3N3alBudzVNWGUxNjZSd0RQcmdlY0VlbG1JRDRzcmVLekhjSktG?=
 =?utf-8?B?SGNvN1pOcE5OLzIzYW0wZ0hkMFNYUTJrNEJyWC9hNzlKQkY0YjUrdWdScjc3?=
 =?utf-8?B?ZHRodjhQdmNSbjRRY2VhME95a09iQkpGcWlLdmJnKzVaaXBNdTdCWWZiN0Jq?=
 =?utf-8?B?M0xxc1NRM25YUFZLTTRkWGpOU3p6REdGc1A5d0pqc0V4SFh3VnRMMDlEd2ow?=
 =?utf-8?B?T0hIbUQ4cVpNMHgybmovTTUxMXRnL25pbzYrQk9ObFViV0hjK3EreUI0SG5J?=
 =?utf-8?B?b0NsbmxiNCs3aU13VE5OeVcxRG9QYlJ1R3Q5MGhublFDdmZCaG91TVNJRVZO?=
 =?utf-8?B?eXIrUE9wQVczVEE4SVF1aXBxeFRXVVVVdHJ2R2RJQVRMajcxSmxuYWVaVDgv?=
 =?utf-8?B?cERKenl6NFZyOVl5T2dlZHc1ZVZ1U0h2Yk1FRDVMY0pmZHJhVFRFcFVYVTZP?=
 =?utf-8?B?T0xRUHNTeDlKNFZiN1pkZ1YzK3AvMnVSWjhWRUNWRjQ2cjY1a2RPeitURFlV?=
 =?utf-8?B?NXhWVlJLR2tHclI5V1drVzkzejI5c0ZFSEZUOFJWMmlVdXZkZFlpUWpzM2dV?=
 =?utf-8?B?R0ZmaGdOak9qWUVuZWJuZUI1YjhDNFlTWXk0S29lYTN1Q1g3V1FLMWVzMjk3?=
 =?utf-8?B?ZloyZnBmZHRGZ2M4NDVJUldrc2d6VnE5SzZDUVFQdjNwRjBuQ0pGSFU5TERy?=
 =?utf-8?B?NUVhUnc0STVoVHRBdW8yQ3dTUVp4Y1RoeG9RdnArMjBHaGJtRUxqNjl3cUgw?=
 =?utf-8?B?MitaUVpYVm40anY0TjRsdkF5Y2JkVnIwaWJoRTVUeTBacU4xaFBtVU92TTAv?=
 =?utf-8?B?UnpRWm0zdVVyVVNEMXFSZ0F1RU4vWHBwWnNOVzBoSThwaFpPTEd3Wkc3dzVK?=
 =?utf-8?B?Q0xJQitrRlRORWxRelJxRTFKTUcxY3ZEc0l4R2IvTCsrWTM1Y0RvTG5OU3ll?=
 =?utf-8?B?aW95aDVxNDVFclV1aEV6ZWpxbVp2ZGdWRlFwQnFWUTFyQllqQ2YyL3dUSmlO?=
 =?utf-8?B?cTBsRWo0QnAybkt2ZGc5NkpnbDc0cHdadE5GcUFhRUdvc3ZHZFVUaHZ6YVNE?=
 =?utf-8?B?ZmRUcGhSQTArYmJpOXZ1TjEwMFlqRzVjMkJNUm9ZVjBQR0RQSndhc0FPSlp4?=
 =?utf-8?B?Um04U01sbldoeVFZRkpKWXVEalh0bVZ0MFExVmYzcW95bml3ZjJpV0FreE1l?=
 =?utf-8?B?V3M5TE9iUnBCOTlJRTZqdU9pRGNIZ0orWkdya2k4S053Y2M2M1ZLMkd6bUYr?=
 =?utf-8?B?bGI1TEd1Umw4NHdNb2pHSU9nQ0xhQUUrR2pNV0pWOW5xK3hLZ1FkY0tlZkRT?=
 =?utf-8?B?Q2Z4SUptWlFZZWZZKzVlSXNzMllXVFlWNG9uL0FGcDk2THZKdFNNMWxYb1lT?=
 =?utf-8?Q?Asxly709tvsz5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(1800799024)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFd5OGRzVXU1NmdTM0tDNE1HZ1dyNFFKMnlnVUMrNXMrdllrYWI5RExoWWpL?=
 =?utf-8?B?T0UycEhzc001QjJ2RlpOSWZZcGU5TFFhc2FEU2JaNWx3TUp3LzFxMjJoTmRm?=
 =?utf-8?B?MFBiTXZlUkdCOHZxcjhCMzZMUC9XKzFkbHJXQkU3NXBuMWdkd01vT2h1LzAw?=
 =?utf-8?B?SEhtVGNMc0w0MFNZaEMyalUxaHN4N0FtbzNJUGFwZ1lRMCtZRHpXVVltcWN4?=
 =?utf-8?B?aDN6djZscTZUdkNnOFo4dUV1RE5pSGJRNUdscGpTQTVyNlRzeW9nK3BjenEx?=
 =?utf-8?B?M1U1bnpBdHQvT1U1bHpoUEFQWkFKUnUvQ0svZnRtQS9xUFZVMjN1bkp2YzVn?=
 =?utf-8?B?b1dQY3NRRUdDbEg0THBvNnVlMjEwZkRnWGJsU3BZQ2p2SXh6bS9mYXNCcVpT?=
 =?utf-8?B?TUtSamJvZlJycm9objYrWXpHQ3lkOExXTmNoSmpCS051eHZsb1JMalZmSG1v?=
 =?utf-8?B?N3FLNzFIWVVLTnFWcW83Qzg4ekhCRkh1alNBT0pucExoYlZRUjVsc2lLemJa?=
 =?utf-8?B?TUl5dXRidkcrTUJLWFVtNDNvU05RUnlhUmJQOUg0UHZ3Z0hyNEduWjkrZkFU?=
 =?utf-8?B?SGRHZEo2ajFHOVh0RlVnOUMwc0JIbEhyYTJwT2dLenArcG1oR0ZJU3YwdzNO?=
 =?utf-8?B?VVFJNjNyKzVpMmVOd1BSejJHRGs0cTdSTmloQVY2cDF0dGR5aUtQMTRuZlMx?=
 =?utf-8?B?d0ZrTVZwakp5VHpVa1FIVFZsaUNKaWhFcEVJaDJENTZmQ2orN2czNWpxdG55?=
 =?utf-8?B?SGZoSTVIMUFrbnMzQU5Qa1dsWUJhZHcxYjBNMlphOUNxZks2K3VwVmdwbFZq?=
 =?utf-8?B?SGJYalN2dkZkTER5ZTUvRGFqUldOZkhaVXF3akFQSEVTaURrd2ZlR2J1d3pK?=
 =?utf-8?B?OExlaVhFMm93Vi9nbmxoVU5meHlkTlhGZnd0UElZMFBRUCtRL0R3V3BmRzRR?=
 =?utf-8?B?Q1JOUzlrOGo0Z2hSVXVmU0djZWt3QVduaGRvWVJzR0RDRlZYYlN1VXBnVCtl?=
 =?utf-8?B?cTd4S1hmTENQUVBZQWhFS2htckRjMFEwN2NjMFVNVnBPZkhDQXREbkpKNEVF?=
 =?utf-8?B?YlU4a3RDcVpJM2VKb1dKYW5BdUVybnc3NlV2d2NpUEpsVmtrdDNNb2FxM1lk?=
 =?utf-8?B?a2swS0wySHNzRjRsMmV4UnFMUlkvelcyenUxS2p1aFdHRjV1YWY1d1diOHFn?=
 =?utf-8?B?Y01OS3BnRUxzdFc5OXdZS05CWi8yUkE1U3RZRXFUZFV1SUxlVEpRMVF1MGdT?=
 =?utf-8?B?c1VNTEFpWVpWSnBsQTR1dWRlNjVXZE1ERm0vbmw1by9QS2xBY0cyZTlJdlRy?=
 =?utf-8?B?S2ZxMWYxUjdFcnJiSWFsMzl4cVhacHRzZHJqN0dhbERPUG9qcHhaMVlQTjVF?=
 =?utf-8?B?S1d3WVdOSGRzVHk1WVVKZVZVWkFENVQ4TS96OVNhbDNYcTBlUzNuY1dPNDlv?=
 =?utf-8?B?SHhPUkNFaGhkRUg0bk9pOFB3MnFiRWIzNS83L04yNG52RTRGd1JVV0NxazRx?=
 =?utf-8?B?N25VdXFlMFRUTkZuUDg3V3ZIUGQrMVN4cnFhVTVCSElQUmJWV2Jpck1CRC94?=
 =?utf-8?B?ODhZa3djSFUzYzR0Z1liOEMya3lCZlNxdzdTZldmWE9zZnBURHVGYk5vS1VY?=
 =?utf-8?B?ZUtLRGJWZWx1STdoY3ZaN2IvU05rWWplRFdJZE5NOHBkNnZPOVNsRDNyV2FK?=
 =?utf-8?B?VGhZZHdpTUx5QnhJaWhGZWVtMEdVU0VsRFRqNzVFeTZ5alZTUUJRcDBtends?=
 =?utf-8?B?UFcvRVFIZkFaV3lvM3U0UHF5a3FuQmZkMUp2dlM1UU9HQlE2a0ZvdlQ4cGYy?=
 =?utf-8?B?R1FPVnJtWDNwMkhuRmprUlpHL2N1dlBiVkxVaFBoSGV6ejRiVUhxWXlVTGRY?=
 =?utf-8?B?UnB3YVFtRUE1RS83VlgycVVPTmgrYXdqems4MC95SFZlMnV1eHRJNHZxNkQw?=
 =?utf-8?B?c2x3WWM2dXdzaVNheGkzbWVtY2l0akdDcGc4WGgwUU9ONGRId0tmRjNWbmtn?=
 =?utf-8?B?ZUFpNnRrU0h0MnF3MnJZSE8xRmlkTTMzQ3NmaWh3QUNxTXpCQmFMMEtrWmQ1?=
 =?utf-8?B?RDBJdWZHY3FmVW95TlIxdW1xREdEUjVYZkdhTVZTNU0zcDREYUpxemZJOEUy?=
 =?utf-8?B?UnYvK1AvMkUySGFMVmpXeVhRMk92K2NGbmhseTJaRkVrbVkvemNZbG9oeTVU?=
 =?utf-8?B?emc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oJNRGsEi4EBW4SKWCh9h07xlYdRP5HRz9W6+GpO7lTivNjqPcslBlt0GbgPdMDf+eoLxVDtXlzo5ThLaaNhrzgzjsHHte8Oi5We2ZIbCkjtPnrCgGVNLidQ3BOcS51mDSgO7CMB7UUf/6mM8yC5sBSvqYkZ1B+Osy1XKBDTfCtS5ynpXQGo3I0U4EyKwbGJmwbZtYlEl2OT7yv2ELuNSCmH7M8/g1xGbyXi+U1O4Xq/lFaiVDRvC4BMcXH1emxQ34vzzAQxd+N06ZZykfJwO6Hz1ad14FMWivGHzwLSdIxOmr1RrF0I2h+l85O2R2n5ibM8wAxO6P8xdoNTkx1MxQ8xYWwjomWWn/3WYNrNBbfaV0hlMEu4jPo1sou05KvAkSw6Z1c8EJuwOET8ZkK88qZRE/014tAafjvYp1b8B4GqrEE1o1OGwlgiGm8KylSd3OybNbPN3YayiHwPgFgg9p4//nTNZhec5ZHzgZF7j9gURbvpWJTe64Bbgr2Xu4EwetR3Ibn0gwVfTL5HwM2VJFl8WJG11Q/LuJqiZxNfxI4qZS/yaTc7qVODajxGADbjZG3G/UlYAoauthQhftuCfFAdZZixo1yXP6F8bWEgk7T4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f63e7836-d7fe-429d-dbaf-08dd2b5c5af9
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 18:36:22.1093 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5TZCZo+Ojcopi2c2SYkPWk+AEaaGgCV1y8bBOJjmEjPlVLG2vLQGrnfYEWz8TL4sRxEo4mF24LXhtHtxwbipq0ejDYdaRvO7jPOeKYpGIAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6301
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501020163
X-Proofpoint-GUID: yq4wbsk6dili5uZA2ptB1ddbRgfOvofP
X-Proofpoint-ORIG-GUID: yq4wbsk6dili5uZA2ptB1ddbRgfOvofP
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 12/24/2024 2:54 PM, Peter Xu wrote:
> On Tue, Dec 24, 2024 at 08:17:06AM -0800, Steve Sistare wrote:
>> Set qmp_ready when the handshake is complete, and assert it when we
>> communicate with the monitor.
>>
>> Suggested-by: Peter Xu <peterx@redhat.com>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   tests/qtest/libqtest.c | 20 +++++++++++++++++---
>>   1 file changed, 17 insertions(+), 3 deletions(-)
>>
>> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
>> index 2f44d3c..43ee92f 100644
>> --- a/tests/qtest/libqtest.c
>> +++ b/tests/qtest/libqtest.c
>> @@ -77,6 +77,7 @@ struct QTestState
>>       int qmp_fd;
>>       int sock;
>>       int qmpsock;
>> +    bool qmp_ready;
>>       pid_t qemu_pid;  /* our child QEMU process */
>>       int wstatus;
>>   #ifdef _WIN32
>> @@ -552,14 +553,23 @@ void qtest_connect(QTestState *s)
>>   
>>   QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
>>   {
>> -    return qtest_init_internal(qtest_qemu_binary(NULL), extra_args, true);
>> +    QTestState *s = qtest_init_internal(qtest_qemu_binary(NULL), extra_args,
>> +                                        true);
>> +
>> +    /* Not really ready, but callers need it to test handshakes */
>> +    s->qmp_ready = true;
> 
> This is a bit ugly.  The patch defined qmp_ready to be "after qmp
> handshake" so here it needs to be ugly.  However IIUC what we want to
> protect against is trying to read() the qmp before connection (while
> handshake may or may not happen).
> 
> So I suppose if we use that definition instead (could rename it to
> qmp_connected if that's clearer), then set it to TRUE in qtest_connect()
> should work for all cases, meanwhile provide the same guard for things like
> cpr tests.

OK.  No need for a new state variable, then.  I can just assert qmp_fd >= 0.

- Steve

>> +    return s;
>>   }
>>   
>>   void qtest_qmp_handshake(QTestState *s)
>>   {
>> +    g_autoptr(QDict) greeting = NULL;
>> +
>> +    /* Set ready first because functions called below assert it */
>> +    s->qmp_ready = true;
>> +
>>       /* Read the QMP greeting and then do the handshake */
>> -    QDict *greeting = qtest_qmp_receive(s);
>> -    qobject_unref(greeting);
>> +    greeting = qtest_qmp_receive(s);
>>       qobject_unref(qtest_qmp(s, "{ 'execute': 'qmp_capabilities' }"));
>>   }
>>   
>> @@ -786,6 +796,7 @@ QDict *qtest_qmp_receive(QTestState *s)
>>   
>>   QDict *qtest_qmp_receive_dict(QTestState *s)
>>   {
>> +    g_assert(s->qmp_ready);
>>       return qmp_fd_receive(s->qmp_fd);
>>   }
>>   
>> @@ -813,12 +824,14 @@ int qtest_socket_server(const char *socket_path)
>>   void qtest_qmp_vsend_fds(QTestState *s, int *fds, size_t fds_num,
>>                            const char *fmt, va_list ap)
>>   {
>> +    g_assert(s->qmp_ready);
>>       qmp_fd_vsend_fds(s->qmp_fd, fds, fds_num, fmt, ap);
>>   }
>>   #endif
>>   
>>   void qtest_qmp_vsend(QTestState *s, const char *fmt, va_list ap)
>>   {
>> +    g_assert(s->qmp_ready);
>>       qmp_fd_vsend(s->qmp_fd, fmt, ap);
>>   }
>>   
>> @@ -879,6 +892,7 @@ void qtest_qmp_send_raw(QTestState *s, const char *fmt, ...)
>>   {
>>       va_list ap;
>>   
>> +    g_assert(s->qmp_ready);
>>       va_start(ap, fmt);
>>       qmp_fd_vsend_raw(s->qmp_fd, fmt, ap);
>>       va_end(ap);
>> -- 
>> 1.8.3.1
>>
> 


