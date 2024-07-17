Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65301C3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 15:35:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU6g3-0004kQ-8f; Wed, 17 Jul 2024 11:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sU6ft-0004es-No
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 11:34:39 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sU6fq-0004pZ-Mc
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 11:34:37 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HFK23K032586;
 Wed, 17 Jul 2024 15:34:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=tqo9nybfiRFPO3YwFkuKP/3cCh/mIern1KSw/Wld0Kw=; b=
 Im7SM4MpZ1hF90DnZyeDI8THhzPpcbVbuyP5KqYEwvTv4izhV43S764Wb6xb+YHw
 YQcBLpydtsB9xmaLVa/wgc3PTET2oEHW+w7Fii6KI6wfX4Yqzj/2bwzH4rcDwWno
 ChJpp67oOgLuU7wEIVY/qSQYaBs1Sevxb8zOhydG5QlCXsyNN2oFSb7smE8lJBXa
 FCpsiQfL61IBhJmdyRxWHIKGJoMAVqaCyxJPZfIV8517uMmd2U4B/q402P3i5jWg
 S0HifCAXUtfnYPnhb8annsQPxJvYP+a28yb6XrSE32+AaEQE/Rl0cA53kvPubrC8
 wUKydG/Dcj2vDBitmKIbbA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40eggqg1jx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jul 2024 15:34:29 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46HEC9XH003738; Wed, 17 Jul 2024 15:34:29 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40dwey7qse-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jul 2024 15:34:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f+cWHL2AzN91v1vHsBycl5PnClQvEca2cDRRw9SdUS2N5LvS9JD5Ii+43XXr0UXstPLX51uAUxFHEn8MFtmTqKHYzn6dps2bEqn0GwXXs0VUAOcan15AQ9kvPrdVZxbg1CCZ/kIVt2solzPhddxgkXx0hfMpMyW5E+gVsZbONT3++yytvhjzyyu0IUaOJAPVZsi/CsqnE7hpAoe2yF1S1/4yNcVIvEaFVx5y5VVl+Ns1UIf6a8dXD11oSanVuVw7/gh77aLBvL9nvFGbuvpuk2g16yy2deFi4cln7zpKL6vgCgI/a04DSmPlFfr4pYkZM7o/r0R2pgWGd+v75f+R0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tqo9nybfiRFPO3YwFkuKP/3cCh/mIern1KSw/Wld0Kw=;
 b=NRU5k0eLKdJ6bsXyIX7fScZusKWZiqlP7lmPlLdiKZVwrEqNe/o52N6BKpfxUBZ5ji7woXP3dgo6E0loNk+wOzMIpoKc6qCmka8wzwH5A50jPISaRMNkyMEHyc9WgFKv/ROMplQXHV3zTogCIVyQQgNgnaeB6G/JOnfXvAb6vWwKfc1PTLBV6aV/cFweOe1jHve+dO4GJv/P2nWLjK9zS0N70lq3UYvhEGAemb+N5BOgzVebqNsgZbDBvjSDH40ONkgrs5zBgBKeJXykG/7kFadJ4vllVUzDM6y0dh6b5P2/eLW04HKeNdiZW3ZH6OzrNxDu4xXWS4wUahW/59y3pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqo9nybfiRFPO3YwFkuKP/3cCh/mIern1KSw/Wld0Kw=;
 b=l6xsOZ8jmtGl+XXyKF4Ns0Xj5sasdK1xdjAIPdA3YJX1XORupcnwZigFlVd09WTFvEyMBNkUoeklvwmzQFGkduwZycpSVIrjzeFE9cqtu2MF2/3jmAVEOOmDkgP9dzFb9P6RofLBAYqoHSE8zKkcKPNZDetwOQms3yFJsDM6TlI=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by PH0PR10MB5612.namprd10.prod.outlook.com (2603:10b6:510:fa::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 17 Jul
 2024 15:34:25 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%3]) with mapi id 15.20.7762.025; Wed, 17 Jul 2024
 15:34:25 +0000
Message-ID: <8fd5c94b-d2c9-41e4-b753-34f1f5e3a991@oracle.com>
Date: Wed, 17 Jul 2024 16:34:12 +0100
Subject: Re: [PATCH v4 07/12] vfio/{iommufd,container}: Initialize
 HostIOMMUDeviceCaps during attach_device()
To: eric.auger@redhat.com, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
 <20240712114704.8708-8-joao.m.martins@oracle.com>
 <6b67c303-774a-44cb-bbe0-24df973ab889@redhat.com>
 <5be3fb70-e4bd-420b-b229-d8f8356cc2cd@oracle.com>
 <61849951-cc63-4ea3-8934-100e13964419@redhat.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <61849951-cc63-4ea3-8934-100e13964419@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0213.apcprd06.prod.outlook.com
 (2603:1096:4:68::21) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|PH0PR10MB5612:EE_
X-MS-Office365-Filtering-Correlation-Id: 6708d292-cb3e-4783-83ce-08dca675f04d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TXU4YUxndzFWNFc1eGFRZko2QW5tTlpFVFpSclBxUTk4RytxcSt6RG1hSmk3?=
 =?utf-8?B?dGV3T3pyY0lQY0pOMjBlTFhWYWZiZHd3MldNMTMzdGNISm50VnJIbkJXQmpH?=
 =?utf-8?B?UlJ1SjF2RFd5L0tDV0VSRDkrRWFZTmFrOUc1ZzYrZnhldmNvd21PK3ZQY1U4?=
 =?utf-8?B?M1QrVTd4eWpOaU0zQmtiV2IvZDNLcytOQ0JyNE9wMlByaUJqSk1kSkdYYkk1?=
 =?utf-8?B?NjU3Z2xsRm93dFZGeXl4NTVpSTMxcEp5dDk2TzlyZHhEdnc4My9MTXErdVZN?=
 =?utf-8?B?QTlIc2xyVWlSRjRQSUJiaGxERDlQTUpUd1VhVmtQdlVYVkpyem5TQ2JtQnFT?=
 =?utf-8?B?UkNCQmgwRFFlZ3o3aG5Xd2dnblUzeVJPZ2JhRFZMazRGZ0F6TWhPUzQzZ29w?=
 =?utf-8?B?Yk9mS0JBbGlMMjNLUVNhaitUWkFOQXFjMFNTOGFERWpXUno0c2tBNklUTmJl?=
 =?utf-8?B?Mmp5c1BPbWcwYzN5T04zYkdyUkFyOXJhNFRNN0VESmQvUko0czBKM3hPcXRm?=
 =?utf-8?B?ZGN1UWRzQWFhQWFBdXJnVVoxMmxkSnpPN2NuVnlUczVPbDE5allWREZ1cUJK?=
 =?utf-8?B?NitWWWE0U3Z3UkF2QVhHd3BRcWpRYm5ESmQzRkhpcVRsRVZzZVBVQ1c1cFN0?=
 =?utf-8?B?Z1FROXBneFZLTGwxRS9GenBmbGlCRk5CM1dRWSs2RW55dEhLWlBhbExLZHlZ?=
 =?utf-8?B?azFmM0llTTlpT0NSc0JpajVuRUNVQU5WYmU5RGlWbWpJSjZUYUF0bmJHOS91?=
 =?utf-8?B?YzZNRkJ3a1pCZGh3NEFzbTMwZFBZL25hZ1FnelB1TnQrRnZKL0lUYjZGa2Vn?=
 =?utf-8?B?RzZ1MkcwMDhsUGdQbkRibi9XcTh0Um9mY01Wei9XL2Q2bnpnWDUrZHlLTWZ1?=
 =?utf-8?B?STBEYzZCblFuMi9Gc1pDRmVrTDR6UlBNTTh5ZjhGRkRwZVlYcy9DMVFiUFpu?=
 =?utf-8?B?QlF5UFBIbUpFMkxMb0RYaERSN2lnMGREMHJHZGVsaUI3MllGNythRkxMMVMx?=
 =?utf-8?B?TTRodUFkcncrUFhDREJ1a2o2bUpIQ3RGbFJHSlJ2MVEvMGhSb0Nzek80SE9O?=
 =?utf-8?B?b3JnazIwalNaeDZyR3U4WVBTbVNCTDBQUVg0YU95d2hqbmsyaVJmODRjK1J6?=
 =?utf-8?B?UWVGRjFKRmxNT1ZWK0NOSHBCY3RQeEo5b3RsclJHRkF5cWpvSnFEbXdJWC95?=
 =?utf-8?B?UllueWpYKzArUUMrdlBOc29KMkg3MzVLdFNkQUQ1SWtHeE81b0ZZaDNBa0tj?=
 =?utf-8?B?V2F5Q0lCYVUrbHEycHY5UWttcmFtTHFEYWxNR3k1T1MwQkpJYkk5V2RwMVZz?=
 =?utf-8?B?M0VjV2M1cVAvcHNMZkptN01TSEdxNlFQSy9QTkNFSlRERklIZFhsZkRtblpS?=
 =?utf-8?B?ZXROUURlTDdsTzdXRG9mT1FvNUpaVzV4MVZMR2IzN213NE9COXlSM043R1BC?=
 =?utf-8?B?eUdKLy9xWFVjaFNlZmwvRVNXT25XL0pia1h6UnRxUTJCWlZsTzBVRUNBcWRY?=
 =?utf-8?B?eDlLUnJvaVhMMHpSNXBFNUpYbHFOUWdDNmtkZW9odVZTUU5qUHNaUllncFJu?=
 =?utf-8?B?NlA2b3dpeWhsWVRHdHdpcjhMYk9MRkl4c0owa1U5RjVCNEZtdm84OVVJd0Ji?=
 =?utf-8?B?bFJ0RjZNUXlrWTd6bHMwanNGTDJucVBPcUNNbDEyYktPS2kyK3poTjgxZS83?=
 =?utf-8?B?MnQyZndnZmFkZjRTczFPSzd2WGpUWG5teHh1dkNiQjNoQ29pdTJIOXcvVzNL?=
 =?utf-8?B?ck5FVWFBaTBZZUNtb0JacndVSkZtUG1uanVOMTR4YTV2elo2RERDTWRYZ2xa?=
 =?utf-8?B?dUZGK1RQaVd5T05JNXBhdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUJsYnB3NW1lMFg0KzNNZFcrdmtJblpQMjZjMDdaZTM1SUROangyci9VcW9K?=
 =?utf-8?B?NVIyZHUvU0w3T0JOcFlOSTdPSFZpTEkzWFNZTnZIZVp3RWt6VWJkZG10Wml1?=
 =?utf-8?B?VGxwcVhlZjNkdDA2ajVKRDU1SjVqYmkycFlYcG5VUkhoc3N2K1RPVE9hK3Np?=
 =?utf-8?B?SmtDNkltMWtEU1BKUHJMVGpDQUlxUHlrd2w3aEN3UkZNSHdQYnZRbXMyNTdm?=
 =?utf-8?B?dzV3ZzNhalcvTEhwalJ6eGx4QStRSFRkMklqbHZ2bUtybnVQS3dTVXF1WnBz?=
 =?utf-8?B?Wmt3UFM4b1h6OGIyNkgwTWNpYTk4S3Q2bHJQUFJaOGlWendkNk1JaDN4ZzAw?=
 =?utf-8?B?WXJ0OHJobk9zanFpa0tyRkE4L2hHeUdRTllEL2ExM2d1Z2EwWUEyRnplSlRv?=
 =?utf-8?B?RmxRZ0lJNUZlUkNIUzd0NkljRldBdlhqU2ZDMlllVFFka0lzQlF5UndJcEtz?=
 =?utf-8?B?d2RGeFhtditud3hOTHdLdUZCMG5tOU1ZSHJNVFZLSzFRK3BpUEgvZndoeERM?=
 =?utf-8?B?dzByNTduMTEzUDMzNXk3aWptcE1oZld2SVU2S01WY1o1S2lwWmYydUh3NXkz?=
 =?utf-8?B?ekk5WXREN1VmL205STZ1a0hSaFdGdFU0NnRnYkpFV2NnZjdNcmhUL01JUkZR?=
 =?utf-8?B?STZ4SXdZdGdoaEJ4dURIdy9Ba1NzTTl4eGcyRkhLd2RPSlRjL1I4b2UzWW1D?=
 =?utf-8?B?Y21HMVFRcnY4cGNSdGhXZTRZekI4cnljYlJBSU9zQWJPbHRNL0VFVjIvSE53?=
 =?utf-8?B?ajJzTkR0SkNFaXBmUEZMeG1Xam9XeTNWTVhIWnN1OXZZOGJiVzFHRGFQZ1Ey?=
 =?utf-8?B?RXJxRmFiU2Q2dkxGczF6NWVTQUpDTVpDVlZDMDl1YzRZK2NTYW1qc25XVDVU?=
 =?utf-8?B?OG8yMHlPR2c4ZU5FOVJ3MmRvR3QxRXBqdkMydUF4RjI1WjhNTmhyV0VEeVNE?=
 =?utf-8?B?MWllanJaL0RRUld3TWpPQ2NCcFhGcnA3WEhzY21vUlBvRU5lWGZXaUNDM1Ur?=
 =?utf-8?B?TGhKZHl1anl3ZER3aGluS2owMzF6ZDlJV2wzdjRUNkRxd2pCOEZlSTVSS0RV?=
 =?utf-8?B?UXpLUHFXWW1sbWVjU0o1N1l6Ym5rNkc2TEYxOEVzaWhlY3NKbHZVKzE0dG9t?=
 =?utf-8?B?TklSeDY3MkRUVlh1RllYTHlkMUdlRFA0YVJBVXFEbzhhM3NPYzh4MWlJb08z?=
 =?utf-8?B?N0d1MExFbUc4dDFZM25Dak1WSEl4QWxmOHZhdFFQNmxYR2RKTEFNcS8yMzVT?=
 =?utf-8?B?MWRrSGdKcEdEWk51SmJmei9qQjNTNXdTbEcxTzRIRnRTY3BBZ2FBdUZzR0RF?=
 =?utf-8?B?ZThtYjUvemkzWG1lNjRZelVUdHV3N3dMbFNrZFBhTFc4YlBOSm9VakFic2FX?=
 =?utf-8?B?WlBqaUoveUEvV0JJRnVIMXRudjhwNjdkS3Q3RllLUDZQLzlZcGhndHVKaWpJ?=
 =?utf-8?B?VFpCeVBQQ1pYQjBpMDQ1QUlrVlJjUEQxcUNBcFFYNldYWGRac1c3VFNEb2ps?=
 =?utf-8?B?WWM4eW9TWUQrOC9qM3FYVkZ3azRYWmRrSnVRL1E3UlExZUVXbC96M2QrbkpO?=
 =?utf-8?B?Yit6ZElEd1BxYWVZQjVLSnNmVHFzRXNjWUJCTUxkWUcweTBzS0NZMmwwVGZB?=
 =?utf-8?B?NUxzTmRoaGxaUmJua3pOdlJiOXo3WjlsZFhZNWpITVE5c1pJMXVOWXQ0MDI5?=
 =?utf-8?B?eHRTTnYyQVVHdlRaMEE3TW9PVXFDR1B5US85Z2ovY0VNTURieTZmUGRkUWNZ?=
 =?utf-8?B?Y0U2WlhrYmg0L3dpS1NTT1JFMGJjSkgyTnJtaEZDTkVHMFhYOFVnVk1mVUFC?=
 =?utf-8?B?cjloVVhoUnV3VCs0bXVpVWFleUIralJSYnZTWng3MFVFakN2RVFhWVFnbUVY?=
 =?utf-8?B?ZnN3Y2xJV3ozblB1QzBvcjFRdjR1dEFpQWVrMnA2ODZ0SVJEN0QvUTZBNlV2?=
 =?utf-8?B?WFhhbisrUForNE9qejFvbkYzYUhYS2xIUG9DQlgwTkh6WUtpcEpPZ2x3ZzR5?=
 =?utf-8?B?ZEVPUlJhSUM3cFFOcUJINTJySVM3T3RuL0N3cE5GQkNUVlBjRWNzYWRZVElp?=
 =?utf-8?B?UzRMT2FsSFFjaVd0K2JXVGN1VTJ2V2M3MTF5aTRnb3kvNi9icmVFb3UvOFRK?=
 =?utf-8?B?Mm9iRzZ5ZHVnb0k0SUM1aWtuMzF2YXRsZXoydG1XdUc3WnFiSWNrR0JhdkZk?=
 =?utf-8?B?SXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Q1KBrlpPJs8bol4BL84IABEKJvbtBrxhVKm9xNGLIRHi136PnQv2zEp+GsSfwISAf3hZK3FPElxtwDlkqiVprDv00LDS2PWwhvZwCv4U+j3K7OWVr0axplUpZ+dStJWGBzcZ+CEWJ+CbxL/ZFXpqptNhEGEWikk2AiLK5O+J7/1CjTBKbNW2nyKAeUD3yApZmXLAJYP0cwvnVnVZVT/zFBEz4qlj2zQIELOpi23fhqJSLYYm/fNKDLn57rBBfzNda7u3+VKuyxFGlhj3ghJUIHu3oBvvUaJPVhpyEny/pYmQRs12SfVAYW3BbpitSYXoRH/IdmwqWuSP6DNhEsQkjbNXxyFFjRRb6ksd5etIXJuFD55dZ5yyXrI8HGvXAWHL4xnHzHCjlcdfnVOrdnJx9Kn+daXM07P0WHRylRLGBhrismgX7o28OAE8kAuQPmhnwJcG190lCEKrtNROb/olN1Wyeux0xymMmHJqxf7GIPyd3A8lGnhFDoZrdpyr2AKCCn7inxaR4xEogUkZ66rCIdK4pJJASE2U1ncIrQ/eYg1ZCmgtK+NL/2O+5WaGwkS3VCGAzEpsamMoTLchNQj7fuOxguziMNDHOWmi1raAW94=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6708d292-cb3e-4783-83ce-08dca675f04d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 15:34:25.5446 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hg+c+PAwCWd0wCr/xgwO7TapvoRACf8Ze+1GJ6KZeX9N+ESjCGznkUruNUs8swFFgbByQ8/Y0lC7nx4DyWOjkPAy414HWMti3GNvqc2Ro0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5612
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_11,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407170119
X-Proofpoint-GUID: Kxf-SV91_2aCXCYStGVJ_IHGZ6f3uPew
X-Proofpoint-ORIG-GUID: Kxf-SV91_2aCXCYStGVJ_IHGZ6f3uPew
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 17/07/2024 14:41, Eric Auger wrote:
> On 7/17/24 14:33, Joao Martins wrote:
>> On 17/07/2024 13:19, Eric Auger wrote:
>>> Hi Joao,
>>>
>>> On 7/12/24 13:46, Joao Martins wrote:
>>>> Fetch IOMMU hw raw caps behind the device and thus move the
>>> what does mean "Fetch IOMMU hw raw caps behind the device'"
>> Fetching the out_capabilities field from GET_HW_INFO which essentially tell us
>> if the IOMMU behind the device supports dirty tracking.
> that's much clearer than the 1st sentence
>>
>>>> HostIOMMUDevice::realize() to be done during the attach of the device. It
>>>> allows it to cache the information obtained from IOMMU_GET_HW_INFO from
>>> what do you mean by " It allows it to cache the information obtained
>>> from IOMMU_GET_HW_INFO from iommufd early on"
>> /me nods
> ?

By caching I mean that invoking realize() earlier allow us to store the value of
@out_capabilities in HostIOMMUDevice::caps for later use and avoid having to
call GET_HW_INFO Again. 'Early on' refers to me doing this at the beginning of
attach_device().

>>
>>>> iommufd early on. However, while legacy HostIOMMUDevice caps
>>> what does mean "legacy HostIOMMUDevice caps always return true"?
>> That means that it can't fail, and the data in there is synthetic:
>>
>>     VFIODevice *vdev = opaque;
>>
>>     hiod->name = g_strdup(vdev->name);
>>     hiod->agent = opaque;
>>
>>     return true;
>>
>> The IOMMUFD one might fail if GET_HW_INFO fails.
> so you talk about hiod_legacy_vfio_realize() and not "
> 
> legacy HostIOMMUDevice caps"!
> 
It's both. Legacy doesn't need to initialize @caps. Whereby in IOMMUFD we do and
with actual info (the capabilities) and in order to do that, we need the backend
initialized. And *that* ioctl() may fail.

>>
>>>> always return true and doesn't have dependency on other things, the IOMMUFD
>>>> backend requires the iommufd FD to be connected and having a devid to be
>>>> able to query capabilities. Hence when exactly is HostIOMMUDevice
>>>> initialized inside backend ::attach_device() implementation is backend
>>>> specific.
>>>>
>>>> This is in preparation to fetch parse hw capabilities and understand if
>>> fetch parse?
>>>> dirty tracking is supported by device backing IOMMU without necessarily
>>>> duplicating the amount of calls we do to IOMMU_GET_HW_INFO.
>>> But we move code from generic place to BE specific place?
>>>
>> No because in IOMMUFD needs the backend connected, while the legacy backend
>> doesn't. Otherwise this patch wouldn't be needed to be backend specific.
>>
>>> Sorry I feel really hard to understand the commit msg in general
>>>
>> How about this:
>>
>>     Fetch IOMMU hw raw caps behind the device and thus move the
> You need to tell what the patch does and why.
> 

IMHO, I already do that -- what we are having here is a parsing issue on my
english (likely because it's a bit convoluted).

Me asking you how it sounds is for me to calibrate against how you understand it
or literality of the text (or lack of thereof).

> "Fetch IOMMU hw raw caps behind the device" sentence does not clearly fit in any.
> 
>>     HostIOMMUDevice::realize() to be done during the attach of the device.
>>
>>     This is in preparation to fetch parse hw capabilities and understand if
>>     dirty tracking is supported by device backing IOMMU without necessarily
>>     duplicating the amount of calls we do to IOMMU_GET_HW_INFO.
>>
>>     Note that the HostIOMMUDevice data with legacy backend is synthetic
>>     and doesn't need any information from the (type1-iommu) backend. While the
>>     IOMMUFD backend requires the iommufd FD to be connected and having a devid
>>     to be able to query device capabilities seeded in HostIOMMUDevice. This
>>     means that HostIOMMUDevice initialization (i.e. ::realized() is invoked) is
>>     container backend specific.
>>
>>
>>


