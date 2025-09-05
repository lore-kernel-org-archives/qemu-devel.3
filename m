Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0062ECA0FED
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 12:25:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuVTt-00005S-DW; Fri, 05 Sep 2025 08:23:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uuVTq-000055-EK
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 08:23:51 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uuVTc-0004ur-It
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 08:23:47 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585BrplT002622;
 Fri, 5 Sep 2025 12:23:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=cBobeDEbIHSp1bRs+ZcvY7ptAf0TLYwRxu4iy0wVaIk=; b=
 aNfGR5hbLAywrsBM9xYVa+4aPO5qLq2Mel5BQLpxq1KdZGqdV5W165PACDp9pOCg
 mRLpjAKtTRyj1b1+Fnr91UShhmnnT2m5hM2z/gFj+SRgoCpp7T2viyZnIdc29xex
 3q98RppSQ4/yEMjxJgD/uxJNKLPw7ZHeQyWJhR12xgDfEPKtDGX99dYeKkkxwZLW
 0yZoOL8rScPzj4xDJym3Qwr4kK7+xPHVtURcENn35SY2jQsEhbtmk6EYWk+3wY8H
 qWOBMuBlN+cNLyePBo2dIqAuzPwehf7RslLsc9TDOykbAwHvIB4v0WKiCut96qsx
 1FIxtfMTvsWi+ySZdAjkaA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48yxpqg3bk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 05 Sep 2025 12:23:28 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 585BcomH019615; Fri, 5 Sep 2025 12:23:27 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 48uqrct7yf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 05 Sep 2025 12:23:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eP9B5PshjbQwWtPYEUla4qfxIbx2mAc6VgLxFQaE5r4xtI+yxD9+GmIlX2//nKbl3O/N+BoSDp7wAnW9ckD3mtuysqB+KlI93lXoJ6mIRtqhTjS/qS+PqO7xHucCIUInM5EaamM96ewAS4hB2jogPNt5cPXmBvXifzgEdmG3sH2A2H5fhl7NjGv47BfGQSbzJ0zk7oUY8j9+B8CkvzKGrdf0h5/Wc5KeQFW1vtg2yUUVLpkgDd2UAlOl5V2fNpwUNxLqDCIIeFF+qeIKMZ58UvIpigGt6ZHxVsfS62ttm8eBd+Bj8NfjXA4VbjBeldU3zXOZGaiTB0BqsbKCNLDugQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cBobeDEbIHSp1bRs+ZcvY7ptAf0TLYwRxu4iy0wVaIk=;
 b=D6UMz45TRulR1wrJt/bjaAI3MJtSGT5QnzobecYn++Jj4uK7Frgol7nsE766+PWdtMkumg3y4y/hBWZt3Qs4kwio71ZeQ+vUZPo2GRWTW0bGChjvWd3JUFdc7g7SVgsj1QUNZTDl8F1G/xqn6CYNJpu/kwkpfOemXXN2TFIEr/Qa9I1mxaqxiYrJqxqjI8sHyqRiQAwuza31DxpcPlNvH+B22jcUH4YYMTEzFtWQyKYjQ+BboHxVCgNFlLD2p/ge2+a2kc1yV1QvRD/iYExQWQxmmk/28wNc5KBW5lO9EP5Q196IG3pdWNBygcAEtIlbcXgVMFrRspcHIGQ2+k/AaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBobeDEbIHSp1bRs+ZcvY7ptAf0TLYwRxu4iy0wVaIk=;
 b=pX5nkA5yyvNZucnFnHVQJ2E0J/TDQ/qaIe38STphUvtg/1NRwJxMl6OIuurz8zq3FQBA0jomTxf0rrbz0EUTVf2qf5HRssRuX4M37RbakD1h+iDrnHDLq4ghsofx2ToR1fQsJlScYnlwI0WrAlS7wLZENfJ0Rmxo0cMwO3tSA0w=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CY8PR10MB6875.namprd10.prod.outlook.com (2603:10b6:930:86::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Fri, 5 Sep
 2025 12:23:19 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.9094.016; Fri, 5 Sep 2025
 12:23:19 +0000
Message-ID: <ebe9459e-741d-4f8c-b7d1-c5c5f3c013ea@oracle.com>
Date: Fri, 5 Sep 2025 08:23:13 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] net/tap: implement interfaces for local migration
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, leiyang@redhat.com,
 yc-core@yandex-team.ru, peterx@redhat.com, mst@redhat.com,
 farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, philmd@linaro.org
References: <20250903133706.1177633-1-vsementsov@yandex-team.ru>
 <20250903133706.1177633-6-vsementsov@yandex-team.ru>
 <aLhR2unpr2xg2MYl@redhat.com>
 <16e31f9b-49ef-44a4-b9ad-0668e3c2c530@yandex-team.ru>
 <12ec1ef1-9258-4ccb-9140-bbb6a2bd93af@oracle.com>
 <eeb8603e-f78b-48be-a2e7-0dd2e0e3c8e0@yandex-team.ru>
 <ba252b43-aaab-4a40-832f-3341875de17f@yandex-team.ru>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <ba252b43-aaab-4a40-832f-3341875de17f@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR21CA0018.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::8) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CY8PR10MB6875:EE_
X-MS-Office365-Filtering-Correlation-Id: f7a45fd0-cf17-4cd4-f3ed-08ddec76ff82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VXFMdDR3RkdnbS8zTmlHUmVYWnpOdlpLdllMa0pXQlZSUHdoTmt5OXh3Tm1E?=
 =?utf-8?B?amtGTkRTRDJvVUlLQ3pZVVBqZHhjNWtaMDBod0lKalQrdDlpN2JCc0dTZ2pv?=
 =?utf-8?B?NjB0Vm41NGFGK3gwQS9LZGt2OVdIcEdUVmVXcGQrNXdlMzgxSXlLdDc2cHNl?=
 =?utf-8?B?ck5MYXlCd282bG5hMHE2NUszUUh4SC9JUE8zbkozTURJK3JCajl0czJ5VUhB?=
 =?utf-8?B?b0FHLzJZWkQwWkYzYzlsMTBhdDBJa2J2TkdrMzduM2JhS1F4eHY5STRIZ08y?=
 =?utf-8?B?S05xVDBLQU1ZLzVrcjFZZVVGeGdDNnBXNHRYNHVBN0ZWY2Q1L1kwV1N1aWhJ?=
 =?utf-8?B?bUZHcS9SNTM2YWNBbWtGQ1FJak9mM2RSLzZ6eVdKVHVTdTlOWTNxdDVaMXFm?=
 =?utf-8?B?SjhkUEJ6bHJ3UHdYK2Rqa2RTNUlRd0VlUkcrRTVKRXYyamozeDN4R3l4TEtK?=
 =?utf-8?B?Z2VWTjIxbTQzOEZFYXoxa2VWN0V0bUZLaWxRS3RDNHRva21oTnlhVHRVSTU3?=
 =?utf-8?B?NjBVTEk2UFBRVmFOWUd5Q1RIbXVhaVlzemVRaWNUOFVWV3VsbE03b3djQktB?=
 =?utf-8?B?VGtWNXVORlJoZ0dORnNqUmR3TlM3TjR1Ry9xVlQ3ZEJ6a2hPVXZYcnljdEMr?=
 =?utf-8?B?SEZhWVdtbFViaEF1c0Y1dnN4UEVuWG1hNlFsZmR0aFVCdTVGM09nVng5NWdI?=
 =?utf-8?B?T3ZUOW9QUVZ1a0lxeUZaaFFSTlFSUjZzNk5HTjllVTJrWGpGc08yUWZzbUlO?=
 =?utf-8?B?a2tUMnczeWh0Q1ZZc0RLdFFGcURvR3JIOWpNVXlEYjJPN29yb3J1T1NjSUcx?=
 =?utf-8?B?QUVZcHFVZ1BYZ2xBL2NYSG0xSnZ4VWhUSHc4VE5ycnJZVmIxNnhJaTlnelNF?=
 =?utf-8?B?NnJRZ2ZCUTFHMEE4UGlIWHFvWFBoUFk0eVdNY2FMa3pvNlN2WUdsalJCb3BK?=
 =?utf-8?B?WTJZbjV3Z2psUk1UL3hST2o0N0kvSSt6RjEzUzg1MlQySzJFeXlPTXlheDY0?=
 =?utf-8?B?S3NsVHJQdkwxMWI4ZDgxa2c5aGQ1T21McU9pT1BwMWpIZ0VsQkZDdmtPQ0xH?=
 =?utf-8?B?T2RTa1JvZjIyOXV1emk3QmkveDJGRXZ0bzMraUgxeDJxUmdqZlg0RkI0Sk00?=
 =?utf-8?B?UnNIK3pnQXExKzRUUEZEa1g1Q3JwK3RmaEpmbE9oWk1EdGk1eDd3ZGllTmgr?=
 =?utf-8?B?NFFNU05NOXBCZkx0bGkzZ1pXYTFIdVJWODkxMXI5aVhkK2YrUXJZWkJtSmVu?=
 =?utf-8?B?TXRXZG9rNnpaYWdET1lkVTVmSHNvZm4vN3ZhTlU0RkYwU0FJK002SU8vQmZW?=
 =?utf-8?B?T2JLR2kxUmV0Z1pPR1FVUTJXY1Era3J2eXlPTFpaYVdMUVlLWDliQWI0Q2J5?=
 =?utf-8?B?K0R0WDl0anNPRW9YcU95eGY0eWFuUGlOMlorOEZkVG1NU01zcFp1V0lsbC9w?=
 =?utf-8?B?bHhBck9xYUZ1L3IzZU96Y0tncGVqNnhMTHQ5OGI0QThyckpiOHJ6LzZoM2ox?=
 =?utf-8?B?UkNOcjlnV0Z1NUtxbFl5aUJSU2dzdjVVM1R2c3crZmU0RWNZT0FZWnBWcVdp?=
 =?utf-8?B?aURPVkx4Y2xrQUErR3FIQURrZXlOOHF3Sm1NaldxSHZ3UmFhUUdWVzV2bUlF?=
 =?utf-8?B?UHE1K3BpcjJmK1Z5T2lkRjVRczRHOEVCUDZQcENpaTNJMVNiZXpNblR3ZGtO?=
 =?utf-8?B?bmJqcVVDS0xWVWdILzBaU0srbmNqbmtYUlpEUDAzaGJGOUJYVlQ4VEk4NFJY?=
 =?utf-8?B?cyt2TFpQeHhkUndha0hhV1h3T0FYa3MrUytsa25FWmd6U3VhZnh1bWE2YU9a?=
 =?utf-8?B?b1lRdkpjR2J2ZHN1cWFFdjRhcHYvZDBEOHdjTEVzRHpxTWpraTRUZThRNHNI?=
 =?utf-8?B?c2RPd0xYY1BuN2tZOE5wZ1ozQlY1bXptK1lHM011L0xvNTdQN1hzdkt3YXVn?=
 =?utf-8?Q?FhvUoNaguu8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3dxMm01L0dnUUR1ZHA2OUcwTFhUMGVxMXhORXRtNXRYSFgwMTlPTHlOQUlu?=
 =?utf-8?B?SDd2QnJ6RGJxU1BKdWc0UDZFYjB0VFhzSzBOcWdPSVc0UE83eVJLMkZudlpk?=
 =?utf-8?B?cTEzakg5a1puMnE5MThqeGxZc1krdXQ4NVZMK01RVXArUXU0QVgwbVRGQnNP?=
 =?utf-8?B?dGpQaDZBTUQxaUZHS1NxaTdVSXNVMktWcmpXNk1EVXc5bEN4YUNCZWxvVlVj?=
 =?utf-8?B?NWF6bTFUUi9rNFNPZXIzd2hXVnk3S1Y1VVRCQ0lyOGhHNVZRNnliaTZQOStK?=
 =?utf-8?B?UW1TZW83ZVR2Tm5ETzdHcDNDS2MrMlpJU2s5MGZUdEJmQWd0QTFoNWNlSXdo?=
 =?utf-8?B?UU9qazdWQnBrZ3gxOHMxNlFHTmJ2TXFsRW1HSTd5VG1lNkl0aVBDTUJmK29y?=
 =?utf-8?B?OVBnYnkzYlBMYkRQRWhUL2Z5NThlZE5Md2grNmthSk9qbWZ0dEVodmc5SjZu?=
 =?utf-8?B?YW14cEhaaDZDMVFPeTR5WmQ0UjBBcmNIUEFnODNYVHFockdHV1dVNmh2VXYr?=
 =?utf-8?B?UFY3dHAxLzNHbjZkSmNUL1VQZFdseU5xSUVzVG5kZkNjemtuYkhIeHpySG1l?=
 =?utf-8?B?NTFGWHE0NExyRjIrRlRNTzJoclRXaTlybnA5QWQzSmU2akxjQ2FaUzNRdlNq?=
 =?utf-8?B?d01PVFc1c3BZSVdQNWlKZmxDbWNObjJ2blE2YmM5NWE5OFN2TWY4clArZlZh?=
 =?utf-8?B?VnlXbGVGTVN5eXNhQzR0RWs1emFDYy94QnJyc0dEQWRTendySWYwSFdRTm90?=
 =?utf-8?B?d2dpdmtFM3M0M2VTbDIrSjh2anZiZFExSzAzWDF0aXk3ZmRjcVlPb2RxbFpP?=
 =?utf-8?B?dVRtN243MVFZY1RUN01ZUmdsblZGbUNveC9YRHRRWHIyS1puWnp1THgwNndE?=
 =?utf-8?B?U3VnRDhORnhYeEF3UFplZ0cwbFVFaTBUWEk3WkJHeERJdTU3L2t0QUpFVDFY?=
 =?utf-8?B?cjJQa1dFSWxWYmxSL09ETWlRMDRhbFZGRFltRkVZTDE0bHZydXJFUnBBMjBT?=
 =?utf-8?B?YktSbExqbUdSY3AyakgxRjF0cW5xL0k5M2xldmN4UG1tRzJJYThVSDI1UlEz?=
 =?utf-8?B?bWYwcUhkL3RTeDNadFI0NEtsVkxqNDJta2JQVjJKMTB4RU5KWkgxZEdSR1ZM?=
 =?utf-8?B?aUUxaVQyVXlSREFudXFOaXg4TzB3d1BRS2dwKzd1VEgxZnU5YjRLVEthTHBq?=
 =?utf-8?B?VlNqNkhrbW5kRGkvQmxPeDN0MzJlVVhZRjJ2c2J1Z3BFQ0lBM05FamRKU2p5?=
 =?utf-8?B?N29VMm56c3dnQllZazBjZXhFc241eEVmWjNYaFlNTVpwc1ZveFNmTWJicDRS?=
 =?utf-8?B?QWFULzNkOU9RZmRCVVdvdmQyS2NLSnJXU21MOTlsVFhTU1l1eTArMGFtcHha?=
 =?utf-8?B?cndKMnNoRzdZM2FNTm0rd291ZHVWZHZXN1AzWUVJWk01azhsU2xuUXlnN1Fp?=
 =?utf-8?B?VUVYa0tuSlRXcTNNZDJMREE4Wmlud3FaZVpEY1RtdzdWT3FMUHZVVGpGN3U1?=
 =?utf-8?B?VGluNGtMWFVGMjczTzJoQ1ZaMC9HVnRnSUFQcXU3OEc3NjY5bHFPZmJhZmJr?=
 =?utf-8?B?SjEvZGJBQXBPRVpLNitzY013dG1MYTd1ek9SaXhrWHF6dVBsM2lQK3ZsMmtP?=
 =?utf-8?B?SnBMNFkxNnRTTG5FaDYyeisySTBaUWhFenRVUmNpNjE3d2x1dlFuMFFwRERR?=
 =?utf-8?B?cVhvZ2JEYUs0b0c4TFRhcDhaUlhjRXBmUGdlR0R6R1JBT0RjaEdSYzJhTCs0?=
 =?utf-8?B?Sk1zZVQvYlFMYm8ySFpKMSszZzVXbkN2YlNrRC9YUFBVRDcxaDJ2WVIvZGpy?=
 =?utf-8?B?blZ3U0RYMmhoWHdxcmpPU21kNjQxNHByLy9Hbk5aOGhZYitHOTA3bWdhKzZ6?=
 =?utf-8?B?a2xEdkp4YzhlSmxqUVhvZ3hlRm04ZnFBeWYvd3pyNE9BUnd3TVVrL2FjTTEz?=
 =?utf-8?B?WDU2cGNHcnh4VWV3SG96cTRST2xYWjhUd3c1V2pDclhId0lSNmFYdXRzejVw?=
 =?utf-8?B?c1RaeG91VU1mcnlqcFY2MVV5cExURGJtZW9RcnZ5Rmx4Vkc2Wlg1Q2RpQVQ1?=
 =?utf-8?B?aUVPLzdKc3RmWFdlSVNIQVN4OTRWdndTbzQxRTVlM0hQRm1PM2FadTFvZU5H?=
 =?utf-8?B?Z2VtTzRIcW5SVEJ5azdzbnFybGJic3AvSTd3cVhSNnl0TEk3QWxXdzhFS3g0?=
 =?utf-8?B?eWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lJiv28O4JgeafeqOj3DhILPod6Gil8NjmqYjN+06uL+z6CiOcpvXSehqLyykBGQojEFMunACN3e3l5VIIFUxKimWRm64qPmvPqGhrTHGMLuxqYTZZP0JwzDdo4S8SqW2UXmGImIs8XBII4rFSwe6iFsc0afNJlr1c9uV3rcrYY4hoB5VA7QShM8wVk0PLcJ1IaNx6Nw/BXv1iqam0MybVU2SP35KVACRXHxg0hC16ZC0PG5lj9F36xX6BoNjF/f4xq6FJsQoV2ZV/myydmLI3k3tbonnybTgKMvonAcrc1WbJCAS42KR8H1wkdt6XnLcdKvqMn9a1/rrRGaTneDeZxoRoqgzoDZOHxdcUnkR9GI2Kqf5ay/XaNHuN+knPfiqZ1hLW8+XFqo1RlPhebH4ZqgNniYyLGUvR1NdJCCOQPTOmcFzldot4bNeNPkYOGTkRBb4N1C9GH9ptSyxx1pf5b0d9wPgb8wseMG5MBbkgvQNtwpIlUIAi8VdMdRpQ8LzqoR1CsMPHqeD8Kyq8oDUuDeT1t5ebrt8Tb8JRoCe0ScT0Gkar+NaiqXm19o2AMPyOLkQNJbM/T0RHvicH2DcAkQTOXy6wXbJZKrDhLQD16k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7a45fd0-cf17-4cd4-f3ed-08ddec76ff82
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 12:23:19.5826 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a2/4LafFdpwZFiMyqh53rqYfEI3cIUK8FhSJBMuU2sTJnuP1X4phhLiOrCeIbfjt5baUBd8uxqu1kpDVJXW5VbUfqBmAymhGByqT2im5bMg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6875
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_03,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509050121
X-Proofpoint-ORIG-GUID: xEjy4vSOfJEq0sgqvj7v0g3Zn4AyxEK8
X-Proofpoint-GUID: xEjy4vSOfJEq0sgqvj7v0g3Zn4AyxEK8
X-Authority-Analysis: v=2.4 cv=Xoj6OUF9 c=1 sm=1 tr=0 ts=68bad640 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=6R7veym_AAAA:8 a=nNDdWdcFsqZPKCS-h9MA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=ILCOIF4F_8SzUMnO7jNM:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA1MDEwOCBTYWx0ZWRfXxCyvGq1m1k3Y
 VZYXMy4hGdORFW6gBSmd/nFdgPdWc8BUAnx2V244FgCWBY3Gj7g/icDc2pO4XAMAE7BMfgA5Nbl
 JUo8jFyBEWSC+Ecgpe+pE8UhZrw1VgdeRYoSyLuXtnt9frzuFz5P3bKNpX1UlT/rH3as7JdeHrF
 enjEGHXnRzreivOdZVEOj1u5tmqh6d49LZDSeNNESQGuJKvs9v7bcu+750AnbcCyb3Mg37h2ffb
 95CxZl+aBGay14Nz/jJ5/ir3mmcNkZifMMnmxAQLSpad9dpI9b2a+wFUw4BCTqyZ9QzlvwsGPTk
 FuilHXyxgwyks2nSDwkEhOl/034i3Jajb7xW3OwEk5lkvzjitZDbB1vYdUk47SqmvxqWGw/djFa
 HMEh/M3Q
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 9/5/2025 6:14 AM, Vladimir Sementsov-Ogievskiy wrote:
> On 04.09.25 10:41, Vladimir Sementsov-Ogievskiy wrote:
>> On 03.09.25 19:09, Steven Sistare wrote:
>>> On 9/3/2025 11:31 AM, Vladimir Sementsov-Ogievskiy wrote:
>>>> On 03.09.25 17:34, Daniel P. Berrangé wrote:
>>>>> On Wed, Sep 03, 2025 at 04:37:02PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>>>>> Handle local-incoming option:
>>>>>>
>>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>>>>> ---
>>>>>>   include/net/tap.h |   4 ++
>>>>>>   net/tap.c         | 136 +++++++++++++++++++++++++++++++++++++++-------
>>>>>>   2 files changed, 119 insertions(+), 21 deletions(-)
>>>>>>
>>>>>> diff --git a/include/net/tap.h b/include/net/tap.h
>>>>>> index 6f34f13eae..3ef2e2dbae 100644
>>>>>> --- a/include/net/tap.h
>>>>>> +++ b/include/net/tap.h
>>>>>> @@ -30,7 +30,11 @@
>>>>>>   int tap_enable(NetClientState *nc);
>>>>>>   int tap_disable(NetClientState *nc);
>>>>>> +bool tap_local_incoming(NetClientState *nc);
>>>>>>   int tap_get_fd(NetClientState *nc);
>>>>>> +int tap_load(NetClientState *nc, QEMUFile *f);
>>>>>> +int tap_save(NetClientState *nc, QEMUFile *f);
>>>>>> +
>>>>>>   #endif /* QEMU_NET_TAP_H */
>>>>>> diff --git a/net/tap.c b/net/tap.c
>>>>>> index a9d955ac5f..499db756ea 100644
>>>>>> --- a/net/tap.c
>>>>>> +++ b/net/tap.c
>>>>>> @@ -35,6 +35,8 @@
>>>>>>   #include "net/eth.h"
>>>>>>   #include "net/net.h"
>>>>>>   #include "clients.h"
>>>>>> +#include "migration/migration.h"
>>>>>> +#include "migration/qemu-file.h"
>>>>>>   #include "monitor/monitor.h"
>>>>>>   #include "system/system.h"
>>>>>>   #include "qapi/error.h"
>>>>>> @@ -82,6 +84,7 @@ typedef struct TAPState {
>>>>>>       VHostNetState *vhost_net;
>>>>>>       unsigned host_vnet_hdr_len;
>>>>>>       Notifier exit;
>>>>>> +    bool local_incoming;
>>>>>>   } TAPState;
>>>>>>   static void launch_script(const char *setup_script, const char *ifname,
>>>>>> @@ -803,6 +806,40 @@ static int net_tap_init_vhost(TAPState *s, Error **errp) {
>>>>>>       return 0;
>>>>>>   }
>>>>>> +int tap_save(NetClientState *nc, QEMUFile *f)
>>>>>> +{
>>>>>> +    TAPState *s = DO_UPCAST(TAPState, nc, nc);
>>>>>> +
>>>>>> +    qemu_file_put_fd(f, s->fd);
>>>>>> +    qemu_put_byte(f, s->using_vnet_hdr);
>>>>>> +    qemu_put_byte(f, s->has_ufo);
>>>>>> +    qemu_put_byte(f, s->has_uso);
>>>>>> +    qemu_put_byte(f, s->enabled);
>>>>>> +    qemu_put_be32(f, s->host_vnet_hdr_len);
>>>>>
>>>>>
>>>>> Is it neccessary to transfer that metadata, or is there perhaps a way
>>>>> for the other side to query the TAP FD configuration from the kernel
>>>>> to detect this ?
>>>>
>>>> Oh, good question, thanks for it. I just added everything and then I was debugging other places.
>>>>
>>>> for hdr_len we have TUNGETVNETHDRSZ, so it's possible.
>>>>
>>>> using_vnet_hdr, seems is equal to initial vnet_hdr option (with default to 1 if not specified), will doublecheck
>>>>
>>>> for ufo/uso, which are set through TUNSETOFFLOAD, we don't have direct way to
>>>> get the state. But we can use the fact, that qemu tries to set them once,
>>>> and these variables are unchanged after initialization. So we can try set
>>>> same flags on target the same way, to understand what we have. Still,
>>>> this doesn't seem absolutely safe.. Kernel may behave differently than
>>>> for previous initialization, probably due to some changed settings.
>>>>
>>>> for enabled it seems not possible, but we handle it in virtio layer.. Oops,
>>>> probably I always migrate enabled=false with this code, will check.
>>>>
>>>> ---
>>>>
>>>> On the other hand, calling extra ioctls to learn something lead to extra downtime
>>>> (should be measured to be a good argument).
>>>>
>>>> Also, just architecturally: seems better not ask third agent about metadata that we already know.
>>>>
>>>> ---
>>>>
>>>> About forward-compatibility (if we add new fields here) - agree.
>>>>
>>>> Maybe turn several boolean fields into one flags field. This way we'll get several "reserved" bits for future changes.
>>>>
>>>>>
>>>>> I'm concerned that this code / wire format is not extensible if we ever
>>>>> add another similar field to TAPState in the future.
>>>
>>> tap_save and tap_load should be replaced with a VMStateDescription for future
>>> extensibility.  Use VMSTATE_FD for the fd.  Define a postload hook for
>>> tap_read_poll and net_tap_init_vhost.
>>
>> How it works? I thought, if I add new field to vmsd, destination will try to load it anyway (as it loads them in a loop in vmstate_load_state()).. So, we'll have to add same new capabilities anyway to "enable" new fields (with help of .field_exists)? Same way we can add new field to current realization, with new migration capability and "if" in _load() function..
>>
>> Still, seems using VMSD is better anyway, so I should do it.
> 
> answering myself: at least, fields has versioning feature, which is intended for future-compatibility.

Plus you can add new fields compatibly by adding a subsection.
See Subsections in docs/devel/migration/main.rst.

- steve


