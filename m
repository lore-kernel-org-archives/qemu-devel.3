Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5C31CA0ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 21:28:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ula2P-0004yG-EH; Mon, 11 Aug 2025 17:26:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1ula2M-0004x6-G3
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 17:26:35 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1ula27-0008JZ-Kr
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 17:26:32 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BKu1qZ005742;
 Mon, 11 Aug 2025 21:26:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=7p1ZnEtEKGx43un7XufBkoznlYwiLsRUw9aS8XumzDc=; b=
 ddXot+TSPihSOFtIJnKfJWFrQk2Y0bQkIVAePYngA9XfO2EfI3iEuNh/q2Im9oL4
 N62sdprqTWFXpD1buDxGkZ4jaPDXSGiU5lVhGF5IufTEmWfBYhA6+pYcVztUmDer
 B+JjACO0RSLd7cTZ8Q9wQ0Yp0OygpFEv6xUPIzV3zjAvFsCi7gMPt5P3SA3LQiQr
 tFdnT26mg5ZKIJuouyDIr2ncloyC1DwswSS2N6nrRv15MPSGihTzv3yKYhwTtxgz
 wVC511kCRsCF6m/zQDFNlnXNFFcxFMpAsvntZ2/TrGjWMezkfcywfzPZiRkUHWwc
 yFiLMmmhXJdegnNFvL7KGQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dw44uhc9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Aug 2025 21:26:12 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 57BKpRc9038569; Mon, 11 Aug 2025 21:26:11 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2042.outbound.protection.outlook.com [40.107.100.42])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 48dvsfq05n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Aug 2025 21:26:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YzhMdidBLTtUlwcNDW8jrvu3/fvxTvExpzEzohb9Fxe6LGcARP2UBn37SwHDxyfdcY5sNprfo9GusrPnztkB7A19L2rXzqUkXg+1ZvhCWQZP/nfInsyScwJ1Ph59dzBlmrFdkRzJ9cqMtDgvvYWM1QdaAYzFGbd+L6mpvib3j0G/st7+4VOWBHjaGMWEWeHi+2ahQYMJYpCNT0sBRNa1xrOJfVCZpv7hgcnQ/qTWccL8szzLXq5rnzxqYkXA9NxvZRc4zv3Vq3Lb4J1GhICmPKv61jPaaehkkw7RUR4bEnRdAwWDRTlb0wOoLlP0CRRlWYSRbhreZfAc9fj2jzBTmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7p1ZnEtEKGx43un7XufBkoznlYwiLsRUw9aS8XumzDc=;
 b=FkSETuRoa6MuNZkEvwdOPVZQVFvC8xkuAdCXXKjSWJFMo6/9EJ6R0yEhxj1P0IcJII6NSKyAxWzJ9ueMmrXbhr5Ze6XQFFegpAit8/xN2eGvyNo5ylkobjdNqa4F2W5xkRG354nMZOaFt1MPmKuz8t2kKEoiELwLibVL5pB/BaqZ7ah5qyfsWUGzbNmvd6WcCRNctFMUAji7Yaan1aLCoRb9o+c0PblIFfQdsgN7eW6mNQfoihRVmCiphNpuGmG8YhYSgvpnkxKROwgLECeO+ndoZd2UxrwwU4mweDvMmVWlMUnxqWm9NP1jD1acjQ5LeJDHKWQoCilAElzxVSkWQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7p1ZnEtEKGx43un7XufBkoznlYwiLsRUw9aS8XumzDc=;
 b=rAz/zHAR9F3QUO6NFqlreGtU7jTfYBHzEcqpyTPn2gZxzoVjxuV1uO82Ssq34rmsrHjKoy/TtdXvlSdwLOykRCmjI5qe1fxDkpJOU4BzXAWfoWGqvoYsQ7dY/XUGg9W4zX4UjwQBNCJp+bbuj+o3re5tci5Gxzhr3a6MnALlWNo=
Received: from DM6PR10MB4363.namprd10.prod.outlook.com (2603:10b6:5:21e::21)
 by CO6PR10MB5540.namprd10.prod.outlook.com (2603:10b6:303:137::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Mon, 11 Aug
 2025 21:26:09 +0000
Received: from DM6PR10MB4363.namprd10.prod.outlook.com
 ([fe80::999b:18e4:cc6a:7cc6]) by DM6PR10MB4363.namprd10.prod.outlook.com
 ([fe80::999b:18e4:cc6a:7cc6%7]) with mapi id 15.20.8989.018; Mon, 11 Aug 2025
 21:26:08 +0000
Message-ID: <eafcf9ca-f23f-42d5-b8c2-69f81a395d11@oracle.com>
Date: Mon, 11 Aug 2025 17:26:05 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 5/6] virtio,virtio-net: skip consistency check in
 virtio_load for iterative migration
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, eblake@redhat.com,
 armbru@redhat.com, jasowang@redhat.com, mst@redhat.com,
 si-wei.liu@oracle.com, eperezma@redhat.com, boris.ostrovsky@oracle.com
References: <20250722124127.2497406-1-jonah.palmer@oracle.com>
 <20250722124127.2497406-6-jonah.palmer@oracle.com>
 <aJOCiUPp0dckmgAn@x1.local> <5e276607-cd86-4a1d-99f3-47dd2f0f3bc0@oracle.com>
 <aJTU641465aGKWRU@x1.local> <0cf99747-443e-4a29-a0da-64012548a994@oracle.com>
 <aJnydjxFzKwVzi7Y@x1.local>
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <aJnydjxFzKwVzi7Y@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR17CA0013.namprd17.prod.outlook.com
 (2603:10b6:510:324::6) To DM6PR10MB4363.namprd10.prod.outlook.com
 (2603:10b6:5:21e::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4363:EE_|CO6PR10MB5540:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cc930e0-d815-4fc0-570b-08ddd91dafe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RUVaZGRqVVY0RlVWSTZwbytkYXNGWGFMeFdKcWQyUlVpN3czb2M5Rk5OSklN?=
 =?utf-8?B?MTlYUm8reG83OU9zYmhUTlRPSm0wdzE5NkE2MTRvRExjamx3dVZBWkNFVVE1?=
 =?utf-8?B?ZS9YVjRRNFRlazBpSUNrbm4yVVgxbysvZUIwODY1MTFoL3ErT2xxeG9ZaXhj?=
 =?utf-8?B?RFU1VC9aWEkrNFpqVkU5RkgwbGZaZVpPdSs2MjI4SFlVU21Zc0Q1cHJEOVJj?=
 =?utf-8?B?VWgwaXVHZGQ1U1pvY3Z6S0RFemlZc2xLdzVsMkxnbytsTXY0RVZ3RXJSMkVP?=
 =?utf-8?B?ajZYNkd2Vk9mNWdDWGtPRjJZNFJGYlBSVVp2Sm9icGFOaENQRFZYTThueUNZ?=
 =?utf-8?B?R1VCWEpXbHFUWDl3aXp4bXFtOVNkUGdiQ2dkdDdEZGJhc0dsQ0dGNTNYRnNE?=
 =?utf-8?B?M3A5YkFOSkI2S1ZUbDdTdW1DVWFPSER2YUdoTFFwZVNaZmdLcnU1VCs5c0ZE?=
 =?utf-8?B?aXpteFB6L3BlOUtWMFhGL1lMbWx5RlluTjhFWVhUN0VMbDR3WEJ6ekpjdEIy?=
 =?utf-8?B?M0RQUzhoOW16V0F2UURaVlBRSzhTRkpPa2lISXRQL0xEWnk2L1lsWW5WdE5s?=
 =?utf-8?B?MU5GcWVwUDBzSWZWU2k0M2Z2dXhLZ2JlRlpWeUFMa1pCY2o2UGYrVHJsTlFx?=
 =?utf-8?B?dGdRbDNuNHhxTlA0VG54dXdSbkg4a2U5U3RPdXZRTXJuRlY0b3lvRE96RlN1?=
 =?utf-8?B?MmpiV3BiNnpWQTZRVTBUMlNKQmZjZnFiQnhkQktHdUw1bWhQRTl2SkJTOThF?=
 =?utf-8?B?SDd1SlljSWJEdzl3UzdTMG04Sm1VTXA4eHJlcHUxdG1WcHE4RytYckhjRVFu?=
 =?utf-8?B?WTJWa0gxRE56Z2RRa0EzZkt3MjBWYXFFei8yYmE4bGx5d3RtQ1Jxa3BRV0FB?=
 =?utf-8?B?b0ZFdWo3bkxabkVIUWVHcDhQRE9DYXNvT1l0MmltV0VmU3cwM1lPQnFiUk4x?=
 =?utf-8?B?NmpqQXpWK3V0WnI1UnNIa25VTjhJSUlWSXhuM2Q0VTh4RXMyZ3BIT1VmQjh3?=
 =?utf-8?B?RUpDaHlGdlozT0NTd1kvMStxT3lLYlByNWt3ajVtMnltVGQzdDFTY0JXWGxn?=
 =?utf-8?B?eDJRNWF2MXpNRnVoQm9icTd4WmVSdEkwR0NEVG5kWkFSR2hGVG5uZmpUTS9Z?=
 =?utf-8?B?VFNTSXp5bVRydFJvWnRwT1kvSmhyRkhqRHhRQm5PbkE1MElpVW9zR3dkSTRZ?=
 =?utf-8?B?OFlRU2twZk5xaURLZStnNDNucjV5RGRRdEI3dS9LdUY1RCtCRUhiSEJ5ZVlJ?=
 =?utf-8?B?QkltL0NVQ2Foa2Rmcm5ndFFzMFdHM0Uzb0F3TXQrV3E5dEo2M0NURHk1cFJp?=
 =?utf-8?B?YzY0MG9pa0VGNmVFQ2FiOC9XdkpFUGpaT2o3WGlIVldjcHZNRFRXT2ZMeWt2?=
 =?utf-8?B?djQrYXNzemh4WmZVSGhTNXFkbWxqbEE5Qnd6Sm1VT0JOSHhsR2NTMnBGVnpl?=
 =?utf-8?B?dFpqcFViV2U5U3hBMnV1cTNGck11eGFSVmtFdEMwbTcrREt2NkxCRVF6b2Ew?=
 =?utf-8?B?N2pkaHNnT0JTM3VoSDRYRWpsOUs2ZFlTMmJYQyt0czB3SjMvRlRUaDFoL21M?=
 =?utf-8?B?S3lRdlRiZGROOGlZUXVWVFRqYzdhNXVXekZVUnNHN3l5aTBLQnl2SlNUc21Q?=
 =?utf-8?B?cFZ0cThaWXhMYnRWYkN3TjNWa3RJWTBZQmJQNm96elhoN05acDBPVVpQNW1V?=
 =?utf-8?B?TU1lTFpzbmNINVoyTVZvRWtkNVd5cmRRZnYwRW5DRmdqMFltd0dKN3JnQVVI?=
 =?utf-8?B?Z3l0ZkRNbEVSY2ZKV1RKRWpVRkVVRUtRWkxGb21zZDJvNlBHV016MDdKZ05p?=
 =?utf-8?B?cGp5QnFyWlZhOUdsTWxFRlBsMmRTcGFkM0tjSmwyZUpEcklsS2JOT0c3TW1E?=
 =?utf-8?B?OWUrNHI1azFuUktnZWJxWjRQRWlqckdGMmF1QU1ydTNaajEya3lkN3RhNlZ6?=
 =?utf-8?Q?7ALEwUe+f0w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR10MB4363.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjMyMVNBaC9MMkZwYUZwK3NmWVVXZUpaODRWbXdIUEsrdHFqeWxYSzBCcC9I?=
 =?utf-8?B?TzJnOWllRDNhQmR5RDF0MTl6TGg4NjlSNlhqZUhIckJNTWNCTWxWaENERFo5?=
 =?utf-8?B?U3NJMng5WE1RK1ZPSlI4ZjRsYVp0RjR1SlNlc2V1dm9iVFp1K2dnK2tpOTZj?=
 =?utf-8?B?c2RsM1NHdlRLVkpxNVRrOHRHYWhDaUk1S29MU0t4Z1lQNHJ0bVlWMWpFcDFj?=
 =?utf-8?B?RllEMEZjNG1CZzM4NW84MWV5Y2ZJbVMvTnV1d3hpTitSc0FSUWZiN0czczJh?=
 =?utf-8?B?K3B1RTVQTTcwQ25HUk56bnd5d2VjL0lZRXZtTFR6MjB0V0djMnRtTHB2UWNi?=
 =?utf-8?B?RG1aSzloemV5dXFVcWZvcWJGYzRrYUdIVTMzU284c2ZOUVRVYlVZMFV2d25K?=
 =?utf-8?B?YXU5VlB5VjVOZXIzampJaGl4cXFpZXA4VGR2SnlDZ1B5NFVvN2FsRzVSTUhi?=
 =?utf-8?B?VnFCVWJ4RTh5eDNTcUZaUVZ1dlFRejRQZTdIcG5hNm1lbC9keVdWVVFxN0Zt?=
 =?utf-8?B?YjZZVmVoZUMzdGpVVHcwa05udnVtQ2EyTE9rM09PWHlyZENIdkVFcTFPWWVp?=
 =?utf-8?B?Y2tidTdmOUQ3K2JWVHpkM3g4MmZmcDVYUm1LZFN0WHJGeGFyNmR5OTdEUVdx?=
 =?utf-8?B?ZUs1aHJFb3huSmNpTStyU1p3dDRpWHFjTXlKUldqZmd4NHMxK3IydDdVTHpH?=
 =?utf-8?B?VXZpUUxJeDhKQzZYWHhNcW83Mi8yREdiRVZlenJGSGthOVhESWxKZUlRZTdL?=
 =?utf-8?B?eWpqbS8ySVRQZ0lySEZMY0dZQUt4dzJoYW9DL3ZiV0NvNFRzM0k1enIwUG0w?=
 =?utf-8?B?Y1ZOZElWc3B2c2I4Tkc2RW1XcHlGM0F4ekRSY0RMMlhUSXRWbTNNZUd1TmZw?=
 =?utf-8?B?YUwzTUFPN0JXb1NZQzc3bjBiT3lQRm1hY0xUSFZCZWNjOWJCbllNeWMvQVl3?=
 =?utf-8?B?ZUxWWGRiZDQ2L0k2ZEV1Uzlza05JYXp5eG5oYjZHYjhVTGVlS2NmekJCR0tx?=
 =?utf-8?B?UGtabGNhUWlTY3c1WmYxSVV0ZkIxazQ5OERLOGV6bCtLVDQ2eUl1UHFXSG8r?=
 =?utf-8?B?R0xMOGprdUJ6NEdXdmNFTWIrbGl3Q2JJYnJHYWlMNzRXL1ExTzZjN3lwTkNP?=
 =?utf-8?B?NE5KRTVzWXNQV29ORzF6STlwQ3A5MmNvOEF5MnBJOThQWDg3K3gzdHo5bmYy?=
 =?utf-8?B?ZFFjdHJob09KZDhDb1gxd3FTTlJlMWY2VFFQaXJWR3BkclBJd3dOU0VYTG9J?=
 =?utf-8?B?aHd5bnFrYTI4S0hIZktlMnczcmNERHJFS3NZR3RLNVNPSXN6WXR3WERTWnY0?=
 =?utf-8?B?OTdTNXRxdGhiOGxmWEo1SkZPK1NxSFBMc1dQOUdjRWZSdVpBa2hOSk5NdjZP?=
 =?utf-8?B?R2dIMyt2aVFXcldTbEdqV3VJQzBBcmhkTUxQeituVGVwbnlUNy9kMVpJQXNZ?=
 =?utf-8?B?NUFsWkpNb3lUMUExOERSbEd3TkQ5Wjd4REpqckpFdlJ6VTg0WjJhekV1Q3ps?=
 =?utf-8?B?MWVZMmxMQ2NZdGFza3g1cHpUdWZza3JTM2dBNFZ6UGNPaFVhRHN1bExEb3ZM?=
 =?utf-8?B?RGV0ZjZXOExEaGlNZTRrZEN6QS9zRXpKTnFXY1pmditlSUpIK2lEbklsVGF5?=
 =?utf-8?B?QnhQVEZFM2t4SnMrY2JWN3hrd3B5NjRPYzd6Z1FraE9wcFdJcUY1NWhaWkR4?=
 =?utf-8?B?a1F4M21UbzY2ckZQV0Q5ci9OdEV5YVRDd1dkTmdlNitka0VrNm5XaU8wM0NE?=
 =?utf-8?B?VG0yNzBjSUkzL2t5VzE0RUkwMG1Vdyt3UHFGMVRTYnFmRFQ2ckpOczUvand1?=
 =?utf-8?B?QWtDQVdiV3FJQ0dCTHo0d29oM2Roazk1UVowbnpaVkt4WUdjMUYyZThiUkI4?=
 =?utf-8?B?Q3c2QVdmWUlQQjZMMHJUVEdmcXR6ckYvdityOFh0ZCt1NUNIdFlzQTIrODFv?=
 =?utf-8?B?R1B2d1dNRFBiYjFLZDNFczhwREhVT2hnRTNEbzVoVjhPbmg0U0o5UjN5RVRp?=
 =?utf-8?B?S0hGWEw5aWMvT054bGplWVN5ODdXdGZ0S2wrNGx0S1NEbXNETVZMcU9ydEp6?=
 =?utf-8?B?aVBqdml5aE9sSnEvWk9UaVdETnV2MFVZdlZUa1dDb25UZGRPU2lraTEzWTdl?=
 =?utf-8?B?bEN3VHhmeVllaDJTNUJuQXlZQlowL0NyaEZnQkdLenlkOEw2QUhxYklmOUtX?=
 =?utf-8?B?UGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NVbWdOo5xN0yDhz2ed7T+75LYrv0Y0i1+FYUJtPlyBeKqXB/vl3uczv+hjzObDT+EO+TmocjGQ+pMDBvJNoWCD6CRKzEbcMnNVFnqPp0KxixUo4PtD6oB1fV6ryXtC25OvtKs3DPSECqk8QCfsMt4tON1VJenAfXzeENLUVsP3/Kuq2sCNq654SpJLJH4EjI92M4lBcxMABl7lt4ns2VCJrWsvwW9VakhLZPhTowu4L72cNyC/lfRBKzQWhZcHJeQLgmZCKGOahG2k0Vy8WtKlLNcTFK8qlA153rSk2u/Q/+A1fjGPh0D05e5ZCo3nV8uVky6q8Vs55OAGtOvrjsKX8hoRelopTi0D3clUrkgdP2hm/e4VaTGFnQFSywN/nKlP8Adjkbz4kOniK7BftzXU1S3FflcRkIXBa3BL+mnBi5cetfk9r1ZF2KaXDgxMMAaqRSoqW5kEh+zDOs7YQb6FSUORTWEJzd7rsnL199/doh7Q2H87JLj3mDufsKTunaHlmJSDO9yVBWtgNz728dcqueOisD00Zi8q3P9hksqYMS2+RZsutLjs3wNQVfHcVb4CyXVww39JUxIBO/h1wbJ5/n7xPrvamLs4BycBitHZ0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cc930e0-d815-4fc0-570b-08ddd91dafe1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4363.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 21:26:08.6675 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nZ5nhkFFwonQp0uzz/7YCca44mOZwm2VK3rZQyoxqfJrqeOGVviHXNABjp8ITM/eQd8+nqGDzGXVoLVYwaT3oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5540
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_04,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 phishscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508110150
X-Proofpoint-ORIG-GUID: AEy6FhcdsWIsmR-lG5cflEBSb44Laell
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDE1MCBTYWx0ZWRfX6gpZ+MH4M6Cb
 o6qErLGiCH+hhh5MyKbWIe6VVe/EJZXUIa3nOaCZ47k+VDBVfxX+pi1izdFJRFy/CipdFu8lkT5
 q7Zb4FzVqNiPG5qprXrcjz4cn5UWwaul1uJHTuMT1/4mKIMDQ+tX7L6BwUQVxx0zmuGHdLaDfNI
 qbcIUS1AxxmQ6H9mBeDo+yqHi+jj50BjFg67uitIUb7JqXIj8QpKTy/O9WflIt5eFuzfLukzoX8
 fefA4FrJmrr4dQi/6CawSoXeqGOly6Pr+0wK6i2qBtVk1V9kqkRyCl6Ig0Oj9I+fnoUtaMLjXMS
 RP1TQP/jLdCoKXTCDGKG8nzslhm8yevXZI4/1D6lbY8e3zkltegvxMOyB1+OxYIvhsca8rc2PBh
 +pcupZj/5ThAx10WTsJ/1qTeXhyPKvRJtRMfifP8vqgXDYXDUkg+/eaa2MFGp0K+fchvBv88
X-Authority-Analysis: v=2.4 cv=X9FSKHTe c=1 sm=1 tr=0 ts=689a5ff4 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117
 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=968KyxNXAAAA:8 a=-GmJJvWcPqPIpoM5UFsA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12070
X-Proofpoint-GUID: AEy6FhcdsWIsmR-lG5cflEBSb44Laell
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.299,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



On 8/11/25 9:39 AM, Peter Xu wrote:
> On Mon, Aug 11, 2025 at 08:30:19AM -0400, Jonah Palmer wrote:
>>
>>
>> On 8/7/25 12:31 PM, Peter Xu wrote:
>>> On Thu, Aug 07, 2025 at 10:18:38AM -0400, Jonah Palmer wrote:
>>>>
>>>>
>>>> On 8/6/25 12:27 PM, Peter Xu wrote:
>>>>> On Tue, Jul 22, 2025 at 12:41:26PM +0000, Jonah Palmer wrote:
>>>>>> Iterative live migration for virtio-net sends an initial
>>>>>> VMStateDescription while the source is still active. Because data
>>>>>> continues to flow for virtio-net, the guest's avail index continues to
>>>>>> increment after last_avail_idx had already been sent. This causes the
>>>>>> destination to often see something like this from virtio_error():
>>>>>>
>>>>>> VQ 0 size 0x100 Guest index 0x0 inconsistent with Host index 0xc: delta 0xfff4
>>>>>
>>>>> This is pretty much understanable, as vmstate_save() / vmstate_load() are,
>>>>> IMHO, not designed to be used while VM is running.
>>>>>
>>>>> To me, it's still illegal (per previous patch) to use vmstate_save_state()
>>>>> while VM is running, in a save_setup() phase.
>>>>
>>>> Yea I understand where you're coming from. It just seemed too good to pass
>>>> up on as a way to send and receive the entire state of a device.
>>>>
>>>> I felt that if I were to implement something similar for iterative migration
>>>> only that I'd, more or less, be duplicating a lot of already existing code
>>>> or vmstate logic.
>>>>
>>>>>
>>>>> Some very high level questions from migration POV:
>>>>>
>>>>> - Have we figured out why the downtime can be shrinked just by sending the
>>>>>      vmstate twice?
>>>>>
>>>>>      If we suspect it's memory got preheated, have we tried other ways to
>>>>>      simply heat the memory up on dest side?  For example, some form of
>>>>>      mlock[all]()?  IMHO it's pretty important we figure out the root of why
>>>>>      such optimization came from.
>>>>>
>>>>>      I do remember we have downtime issue with number of max_vqueues that may
>>>>>      cause post_load() to be slow, I wonder there're other ways to improve it
>>>>>      instead of vmstate_save(), especially in setup phase.
>>>>>
>>>>
>>>> Yea I believe that the downtime shrinks on the second vmstate_load_state due
>>>> to preheated memory. But I'd like to stress that it's not my intention to
>>>> resend the entire vmstate again during the stop-and-copy phase if iterative
>>>> migration was used. A future iteration of this series will eventually
>>>> include a more efficient approach to update the destination with any deltas
>>>> since the vmstate was sent during the iterative portion (instead of just
>>>> resending the entire vmstate again).
>>>>
>>>> And yea there is an inefficiency regarding walking through VIRTIO_QUEUE_MAX
>>>> (1024) VQs (twice with PCI) that I mentioned here in another comment: https://urldefense.com/v3/__https://lore.kernel.org/qemu-devel/0f5b804d-3852-4159-b151-308a57f1ec74@oracle.com/__;!!ACWV5N9M2RV99hQ!Oyhh-o4V5gzcWsbmSxAkonhYn3xcLBF50-h-a9-D5MiKgbiHvkaAqdu1VZP5SVmuCk5GQu-sjFhL0IUC$
>>>>
>>>> This might be better handled in a separate series though rather than as part
>>>> of this one.
>>>
>>> One thing to mention is I recall some other developer was trying to
>>> optimize device load from memory side:
>>>
>>> https://urldefense.com/v3/__https://lore.kernel.org/all/20230317081904.24389-1-xuchuangxclwt@bytedance.com/__;!!ACWV5N9M2RV99hQ!Oyhh-o4V5gzcWsbmSxAkonhYn3xcLBF50-h-a9-D5MiKgbiHvkaAqdu1VZP5SVmuCk5GQu-sjBifRrAz$
>>>
>>> So maybe there're more than one way of doing this, and I'm not sure which
>>> way is better, or both.
>>>
>>
>> Ack. I'll take a look at this.
>>
>>>>
>>>>> - Normally devices need iterative phase because:
>>>>>
>>>>>      (a) the device may contain huge amount of data to transfer
>>>>>
>>>>>          E.g. RAM and VFIO are good examples and fall into this category.
>>>>>
>>>>>      (b) the device states are "iterable" from concept
>>>>>
>>>>>          RAM is definitely true.  VFIO somehow mimiced that even though it was
>>>>>          a streamed binary protocol..
>>>>>
>>>>>      What's the answer for virtio-net here?  How large is the device state?
>>>>>      Is this relevant to vDPA and real hardware (so virtio-net can look
>>>>>      similar to VFIO at some point)?
>>>>
>>>>
>>>> The main motivation behind implementing iterative migration for virtio-net
>>>> is really to improve the guest visible downtime seen when migrating a vDPA
>>>> device.
>>>>
>>>> That is, by implementing iterative migration for virtio-net, we can see the
>>>> state of the device early on and get a head start on work that's currently
>>>> being done during the stop-and-copy phase. If we do this work before the
>>>> stop-and-copy phase, we can further decrease the time spent in this window.
>>>>
>>>> This would include work such as sending down the CVQ commands for queue-pair
>>>> creation (even more beneficial for multiqueue), RSS, filters, etc.
>>>>
>>>> I'm hoping to show this more explicitly in the next version of this RFC
>>>> series that I'm working on now.
>>>
>>> OK, thanks for the context. I can wait and read the new version.
>>>
>>> In all cases, please be noted that since migration thread does not take
>>> BQL, it means either the setup or iterable phase may happen concurrently
>>> with any of the vCPU threads.  I think it means maybe it's not wise to try
>>> to iterate everything: please be ready to see e.g. 64bits MMIO register
>>> being partially updated when dumping it to the wire, for example.
>>>
>>
>> Gotcha. Some of the iterative hooks though like .save_setup, .load_state,
>> etc. do hold the BQL though, right?
> 
> load_state() definitely needs the lock.
> 
> save_setup(), yes we have bql, but I really wish we don't depend on it, and
> I don't know whether it'll keep holding true - AFAIU, the majority of it
> really doesn't need the lock..  and I always wanted to see whether I can
> remove it.
> 
> Normal iterations definitely runs without the lock.
> 

Gotcha. Shouldn't be an issue for my implementation (for .save_setup 
anyway).

>>
>>> Do you have a rough estimation of the size of the device states to migrate?
>>>
>>
>> Do you have a method at how I might be able to estimate this? I've been
>> trying to get some kind of rough estimation but failing to do so.
> 
> Could I ask why you started this "migrate virtio-net in iteration phase"
> effort?
> 
> I thought it was because there're a lot of data to migrate, and there
> should be a way to estimate the minumum.  So is it not the case?
> 
> How about vDPA devices?  Do those devices have a lot of data to migrate?
> 
> We really need a good enough reason to have a device provide
> save_iterate().  If it's only about "preheat some MMIO registers", we
> should, IMHO, look at more generic ways first.
> 

This effort was started to reduce the guest visible downtime by 
virtio-net/vhost-net/vhost-vDPA during live migration, especially 
vhost-vDPA.

The downtime contributed by vhost-vDPA, for example, is not from having 
to migrate a lot of state but rather expensive backend control-plane 
latency like CVQ configurations (e.g. MQ queue pairs, RSS, MAC/VLAN 
filters, offload settings, MTU, etc.). Doing this requires kernel/HW NIC 
operations which dominates its downtime.

In other words, by migrating the state of virtio-net early (before the 
stop-and-copy phase), we can also start staging backend configurations, 
which is the main contributor of downtime when migrating a vhost-vDPA 
device.

I apologize if this series gives the impression that we're migrating a 
lot of data here. It's more along the lines of moving control-plane 
latency out of the stop-and-copy phase.

> Thanks,
> 


