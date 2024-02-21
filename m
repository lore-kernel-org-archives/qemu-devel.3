Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC99BC5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 21:25:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcu3j-0001HK-Pv; Wed, 21 Feb 2024 16:23:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rcu3f-0000xA-EA
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:23:15 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rcu3d-0002YU-CI
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:23:15 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41LJJ3KA021244; Wed, 21 Feb 2024 21:23:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=2ZT1Z4cLJIYuOmq745HqnymXm1T9ClOrNOZ/pCscVeA=;
 b=O1DZ3MsQKijTgcAey52IR9Y0DzA0lBDgmJCBc2M/r0Rq3fCkxD7DcgLd30NkgObRbqpw
 AMGZBD7zlullKLhpiWBiOy+X3K/6P/7JAwMrGTUPES54PV4cpF01ZFHT6zw3+9jEKwcJ
 zYnalTPSdKlxWd/d+w8MTGBTjhGVA+q+o1W7IF+Dl5HxTJha1mRyvsB5jYPacGi1bNMT
 sohkzvx+zDPerFweoYOmLAzLG8KEBdE0rQ5c+IgjTI20N/7JWw4p42LnJIRCfp5tREun
 FyRQ/eV3Mxp4rt+ZBKhFIrKP7nBBIALEEHOme/XJozp/+o4siytYIcJj/kVfBZZhPZXY YQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wamud31f0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Feb 2024 21:23:11 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41LJp0ML032725; Wed, 21 Feb 2024 21:23:11 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wak89nhu8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Feb 2024 21:23:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C2NwRPFmLAgTEFPRjU5eDITlJLE+Mxo5lfoODpKKK4qc0ANwtogeCb/Aw/3T14OphL5o2q5nwMpYoFF/stBco7UvLqKK8KFvfI1CKKF9M7r0SOI8eW3raBn0aPr88oV1bv76NkTMoD3uc2/T0VkebwwEZRa+jq7hAsItKZF1rdmxe5mne7GyAsNPAeolIpZdA7AWmx83pY0nZA2jmgPBw68qFPZe0EFa6rJgsC4AeE5cPpd7LayscPRAgZ0O2XPdn032Ris9/G5O0P7b3PGgVIkdDtJfzTlRHMThtpkGVAGp5tT5eArgwRYpn6FSGzWqqmseO5dbnh6nTzfG+CvyLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ZT1Z4cLJIYuOmq745HqnymXm1T9ClOrNOZ/pCscVeA=;
 b=hCX87THiIH6PCzuF+mPWcXPi3oM1CoETr9Eq8+HCbEiKCf4SeMj2yUEbJ5omBjXfDe4vO7OVDV9rNmY3v0Yvy2Oa4vkLB1eGfER91YHHVOuAGKdzslGWsy1bCdQmWEh45hMBK9fKaggpP/0PCgajf8X9up1Ly7IB32ian2sWvBtHJkpeyJAEUApbWGcts2FanjwkSOTHV5sQjVcTGJh0ZhkGjII6ZR8YizvLbFvpGjW/YTxDoKTmYNqrHMMTCzZ1SBHBfZAb0/sHBqeALFIYAv2KTRa13Qoi8pjt96n/eKJQCOZRMT6sJxDDXExM8qFkvZrxVYNQk5Txshp9hrQFJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ZT1Z4cLJIYuOmq745HqnymXm1T9ClOrNOZ/pCscVeA=;
 b=DyxFsVrEHCoFmVsfLUbq9duVqAAa/EDJaUxyuCNPW87neRTKuebHJ4UWFUfV0ZpQ7MRwYgqmxJxwDvu/IaJfMJW9Gcq9osk779h0Lt1qcJOTwlgBIO4h40KblIa1oR7t5wT2KrNa5eZxEE7+fh16/pd9q+VdAVQapdk/HblozBA=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by SN4PR10MB5560.namprd10.prod.outlook.com (2603:10b6:806:203::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 21:23:09 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%6]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 21:23:09 +0000
Message-ID: <b573d625-154c-4df6-9e86-2b1bbff38ac0@oracle.com>
Date: Wed, 21 Feb 2024 16:23:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 10/13] migration: stop vm for cpr
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <1707418446-134863-1-git-send-email-steven.sistare@oracle.com>
 <1707418446-134863-11-git-send-email-steven.sistare@oracle.com>
 <ZdRVz7gvh-qGNxXZ@x1n>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZdRVz7gvh-qGNxXZ@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR22CA0001.namprd22.prod.outlook.com
 (2603:10b6:208:238::6) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|SN4PR10MB5560:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a02b6c2-4467-4c31-59e0-08dc33234d46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uodw3Hkqh1bT0oNJ0bSU0x2Emd/XoZChc1VQdIpjGlEOjSY+RU7nIY2tjXjYVBQSQjOpZbbi7VLZTjeF1nPUinLouDLD0Hh5Nlmdfhkb5qPHYpz2btcJ7N3Nhf20W47e04ny317DA2eIjad2/dY8a4A3HiRacIAsTS0wNEy63LQ0fQ3rbboOobyiN/ib7jmzBWp2q/MGwH1Ro9MwBsZNeo61GU8pm6mwnvBT47rB5x9N5c8IgFPgH19YFaVVxDgSZ6NTfcRMz742DxWB4svBrG1TmNGO8PAacQAhfz1pX31LAitLp9khIJJBHiSwmT9RNKnpXEyNr6AV9kwmXH7dih2CuXaOjw0G+3qRAWRRVwnNc/ZMcTHGwmVaFR9a7GIEqhvUDLtFbhJqxaRR5YwEZVx+wpwGtoUCku+1SW34WvGTrhuV/f3GJOtk+E+Fw3v3ZVU9RlkHp8ny0yGzTK+0klawnMZg5X5fV27eSVMahjMnnwPeIhO34fO4T8PY7XW0VstM5PL72+NL0AiSGy+DRfRwTvIz8lGiAFgu6QSNbCk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0tSSjdkZUl3RTNmNGdCWVR5dEtqUWVTckpucWxaTE5zNVBJZndJSVB5U2lG?=
 =?utf-8?B?bWp5MUlwOHgvZHF2MU0rb3lBSTYxZTMrNjJvNjVvSWR2L09kQXhwMmhuV2cz?=
 =?utf-8?B?aFhNUGVoM3A5ZDgvZktPVUlvcDlWbUxZMVY5R05EN080Sk9pRHdIQ2M0SlBI?=
 =?utf-8?B?NXUvYkdXSDJaT2V2cGszZitObEJ4d09vYmN3MEM1UkN5Zi91T0VockVndnFv?=
 =?utf-8?B?N05abTV4SnpzaFQ1SVI0UjVQeHRFamNSMzlFOW9waUZ2eGZqQ2Y0akdPTHdu?=
 =?utf-8?B?WGI4YzdDTUxRUjVKYXpuU3gyMGVhcmtTNzFJbnhVYy9sNHJBSi9WZllKMVhS?=
 =?utf-8?B?WTJZTmFleEoxWlA3SVAwTitaMU10Nk5VR3RNQkFjelNIelpwUWMwWjdGYnNa?=
 =?utf-8?B?MVdpYW1LQUdCQURtWFNvamRjaUdUU24wanJzaEpKb21sN0RMTGRtRnlCUFgz?=
 =?utf-8?B?bkF6eWFZSTh5NXRwZHJFSkJsc1NkNSttMmR5RE5BeEtGOVpOOTlSbFhSYyt5?=
 =?utf-8?B?cXdLVTRQL253QkNTVXdTMjhUMVFvdk1TckczdkNGODJneG93TENWQ0JTbDN2?=
 =?utf-8?B?ajYwWStBN0gzZEFxSWRBOHN6Q296enM5VXBjamRuWVdTTEJzZVBCVVI0UE0y?=
 =?utf-8?B?Yk05Kzd1RmczNFgxMHE1eG52RzhPMnRBQW40WFdxb1FqQ2NmNTI5cnlFdjFo?=
 =?utf-8?B?MW1WRU1LZUZaUXZFUzZUQ0dIWnZLSEVMb0JDaXQ2RlBQZktXRk9XUEJoY01a?=
 =?utf-8?B?TWJYUTdHczUzdkppOGJXanBmRDNqbkNOVzdHUnBLQjVtQzJ1RHZvNWt6WW0r?=
 =?utf-8?B?dkNUbnRZWjZTS08rcEZnRGlxU1ltd016Y1F3dFg5YTBPQTNBdEg4dHBqeG1U?=
 =?utf-8?B?bjJQREZ0UzdBc0FzRzhKQXZtbmtMZDcwTWsyckJKdWIzWUNMd0dMQ2p6bjhV?=
 =?utf-8?B?TE81NFNQczF3YUY5OUcwNWE5b2U2ZkluUFI3ajdteHlzektqU3Q2elNwT0xw?=
 =?utf-8?B?MFAwcG5hbE5Oc05uanFNdE1heUpEZGhPWEJJT3FGNmdRSGhvTXdVSnkzcTRv?=
 =?utf-8?B?bGtOSEtIUDZPdUo1Z2hJNFBHUEM4WDBEYVBKSUNZcEl3V2kwRVNSdjZ3d09h?=
 =?utf-8?B?SklnaHh1bW5KMGJLcGZlVFR6TzI0eE9vTHB2K2s0QVdtUlY3QXNIMnFiQ1ll?=
 =?utf-8?B?anYzS1YvdFVleHhmcmx0bTZSaEU5Z3BSRUZnUmh1bHdJdElmS2pPQ0RBOW1C?=
 =?utf-8?B?UEx4VXQ2T2lySHpVUThWU0wzdUdCUi9wZjJOWDJJQTJqM01tWm5ISGJOZmZP?=
 =?utf-8?B?T1Q5ck9EZGp6OGxXRk51WlRCODJoOXVmSU9PY0UxQnZ6MGQvRVl3MEk1NWZp?=
 =?utf-8?B?STBQQzFuVFVjZG1za0RGRmZUK1dsQUd5K3hLaVF4bldCR2hBMXVtVktOenRV?=
 =?utf-8?B?alUrNHM3ODNlVTdZTXp3cGlrbUxmK3dERUJqQnpPZmR5SWp6K3M0blYvYTJQ?=
 =?utf-8?B?OXp3MW9wakU1eU5KZUZPc2U1TDlWOS9uYm80UmpzekJTc2J4Vm16WEFsVmli?=
 =?utf-8?B?TUExb21MQVgyeUMrTElWUmJ1VFUwSTVwMkpqVHJncjJmby9lTjFvRlFvNmov?=
 =?utf-8?B?clRUM096c0NNaURlUGFNME9vNkpGejI4VjJnTVRrQmFBM1hlU1BvOTBIYllJ?=
 =?utf-8?B?L3lhWEJWKzZ6Y1QxMUVyMWZ4NmdLZW95OTFHRnFDS3R5STB4YVlKNFVVai9z?=
 =?utf-8?B?Zk1vRVBkNS85V2doMGdEYkt2K2hhMEJVdDJYalRHRmFnWmtDRjBUUFNwME11?=
 =?utf-8?B?ZVZqQndTZWNDQ2hEUHVxWXY4cmMvVllTS0NmZFArR0YybWlSSjVRWjd0M1J1?=
 =?utf-8?B?QkRuNjZta3MrNTFGLzVORnhNZnZGQ3c1c3VpWUtHa2d6bktaVEozbXZCRFhZ?=
 =?utf-8?B?ZWpvbHNCdEU4UTZmRzAzcVNTeVk2NnZtUTNkR2Q4VDNKaEhXbDhtT0ZiNGRG?=
 =?utf-8?B?bDlQTG9WSVlzMDlTdW9VOU1YT1FwV3lPTHVQNUp4Wk11QUtWbS94SEh2eUVu?=
 =?utf-8?B?cjBlRC81WFdrQjY4WjFFOHRlblNreUpuRU1acmYzazJoMXBEU1FiMUZiNVdH?=
 =?utf-8?B?T3Vlbm1XZTFRaCtZQVJJdjZpMDMyLzlVa1NSRWxDQTVCTUFGWDV1eEpuNnN2?=
 =?utf-8?B?OVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XNCqMYCqSbcOM1k3MUZbTlHeg3jRaMx00mbzciIW7krw/voo50jui3rThM3r6OuTtBCckoEr2tBSIr8dko+RhZ2mVoitC42h6hwHdcaJBt3h4L4d2cMMgkLIoAglf5YIlQwusLEWcKXDFiCNxZWbrhxXqxducU+4O6DvCimGAs+WnCfddkbVi7xXPQLvq7sttSoTfycnwdIghV7McpJNQ1ZHesvWtxeNgS8lizYeshY3dWTPLwzL5jHmjae2OFRa91xOQ385PyVkPYtG343Ji1zosZ8d8sQrUciULjeJFiptrHxyxeLCLm+qzf0H9gtfBkxJ1V1RRKhgu9iuUJXV8k4sdpmRTXmxVcypMDxYq9YlcPiZQGNiEaE7sSK/wfy4kuuc7ZuavtFaoPOqOYUoSMXT7Q9m4ZyXIwd1y4RDkA8LryZWRfyti13aIJLOhuaDbbT+iHhIinhvMVn+1NC674l7hUuBUkGjcIAu52p8AjyhENbKzUmqlA3NNz5pwprb+EQ/mD5I/9uMTFnzpycegW8gaIp+vzdTz1VA2RfXhkgM2Sf3jBC4K/f5BNflA7V/w/u0JGwsKsouEmkQwd/Fsn36tu4izbAYmMOnSkv6jxE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a02b6c2-4467-4c31-59e0-08dc33234d46
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 21:23:09.4645 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0et19g99RUbPQtDsVPndGDvKe9txNgh4YrNJBlo6TlzHH42E0EtuxpwxXctGX6GiBnSQPQ/3GLhe+UG8J9RHOPpcY++DRjdZeHKYv8UQWvE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5560
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_09,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402210167
X-Proofpoint-GUID: EEpoXvXPZRraGpUG4Auxp2Ib_wGIvPas
X-Proofpoint-ORIG-GUID: EEpoXvXPZRraGpUG4Auxp2Ib_wGIvPas
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2/20/2024 2:33 AM, Peter Xu wrote:
> On Thu, Feb 08, 2024 at 10:54:03AM -0800, Steve Sistare wrote:
>> When migration for cpr is initiated, stop the vm and set state
>> RUN_STATE_FINISH_MIGRATE before ram is saved.  This eliminates the
>> possibility of ram and device state being out of sync, and guarantees
>> that a guest in the suspended state remains suspended, because qmp_cont
>> rejects a cont command in the RUN_STATE_FINISH_MIGRATE state.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>  include/migration/misc.h |  1 +
>>  migration/migration.c    | 32 +++++++++++++++++++++++++-------
>>  2 files changed, 26 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/migration/misc.h b/include/migration/misc.h
>> index 6dc234b..54c99a3 100644
>> --- a/include/migration/misc.h
>> +++ b/include/migration/misc.h
>> @@ -60,6 +60,7 @@ void migration_object_init(void);
>>  void migration_shutdown(void);
>>  bool migration_is_idle(void);
>>  bool migration_is_active(MigrationState *);
>> +bool migrate_mode_is_cpr(MigrationState *);
>>  
>>  typedef enum MigrationEventType {
>>      MIG_EVENT_PRECOPY_SETUP,
>> diff --git a/migration/migration.c b/migration/migration.c
>> index d1fce9e..fc5c587 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -1603,6 +1603,11 @@ bool migration_is_active(MigrationState *s)
>>              s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
>>  }
>>  
>> +bool migrate_mode_is_cpr(MigrationState *s)
>> +{
>> +    return s->parameters.mode == MIG_MODE_CPR_REBOOT;
>> +}
>> +
>>  int migrate_init(MigrationState *s, Error **errp)
>>  {
>>      int ret;
>> @@ -2651,13 +2656,14 @@ static int migration_completion_precopy(MigrationState *s,
>>      bql_lock();
>>      migration_downtime_start(s);
>>  
>> -    s->vm_old_state = runstate_get();
>> -    global_state_store();
>> -
>> -    ret = migration_stop_vm(RUN_STATE_FINISH_MIGRATE);
>> -    trace_migration_completion_vm_stop(ret);
>> -    if (ret < 0) {
>> -        goto out_unlock;
>> +    if (!migrate_mode_is_cpr(s)) {
>> +        s->vm_old_state = runstate_get();
>> +        global_state_store();
>> +        ret = migration_stop_vm(RUN_STATE_FINISH_MIGRATE);
>> +        trace_migration_completion_vm_stop(ret);
>> +        if (ret < 0) {
>> +            goto out_unlock;
>> +        }
>>      }
>>  
>>      ret = migration_maybe_pause(s, current_active_state,
>> @@ -3576,6 +3582,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>>      Error *local_err = NULL;
>>      uint64_t rate_limit;
>>      bool resume = s->state == MIGRATION_STATUS_POSTCOPY_PAUSED;
>> +    int ret;
>>  
>>      /*
>>       * If there's a previous error, free it and prepare for another one.
>> @@ -3651,6 +3658,17 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>>          goto fail;
>>      }
>>  
>> +    if (migrate_mode_is_cpr(s)) {
>> +        s->vm_old_state = runstate_get();
>> +        global_state_store();
>> +        ret = migration_stop_vm(RUN_STATE_FINISH_MIGRATE);
>> +        trace_migration_completion_vm_stop(ret);
>> +        if (ret < 0) {
>> +            error_setg(&local_err, "migration_stop_vm failed, error %d", -ret);
>> +            goto fail;
>> +        }
>> +    }
> 
> Could we have a helper function for the shared codes?
> 
> How about postcopy?  I know it's nonsense to enable postcopy for cpr.. but
> iiuc we don't yet forbid an user doing so.  Maybe we should?

How about this?

-------------------------------------------
@@ -3600,6 +3600,11 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
         return;
     }

+    if (migrate_mode_is_cpr(s) && migrate_postcopy()) {
+        error_setg(&local_err, "cannot mix postcopy and cpr");
+        goto fail;
+    }
+
     if (resume) {
         /* This is a resumed migration */
         rate_limit = migrate_max_postcopy_bandwidth();
------------------------------------------------

- Steve

