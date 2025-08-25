Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA16CCA0FE1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 12:18:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqW8Z-0007Sj-4J; Mon, 25 Aug 2025 08:17:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1uqW8L-0007Oe-1x
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 08:17:19 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1uqW89-00025L-2n
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 08:17:07 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57PBEQSl029301;
 Mon, 25 Aug 2025 12:16:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=8yPumbyHzL43vC7pcRMP5sv5dypf/qebnDRJIENZHQ4=; b=
 TTT5nHFtVWrCB3zni+tSLeR5ErsXspx6nswcicpW//y4LuyGTrxKCAgr7E/5DHii
 Y/B7FrNyaNBU2cLBVEeoQs5RUF6ZROh28T5luHIi75DXaBL+ehT6CgFNGeDD9Wkb
 yZxvqPxB2OgYrSTqCWUY1hutHfc32G0l/5lsFEfWjDWs+BLGM+zzhSpdcYtM0Mnx
 Z17NwjDOz5sEHYFN3s/xgaBEAlw6JdBbbWBvMYijD9brSKaaQCi5mA7R3DlYj1mN
 E9QQXQK3TJ5ICoUHX21Hhnp1nJu94y+kTvpGAOHqzDMQlN8z3RswsuQf8cxCwpqn
 EwNesyHHAaazYokoC+skbA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48r8tw8vyy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 25 Aug 2025 12:16:42 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 57PAWEEt005946; Mon, 25 Aug 2025 12:16:40 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 48qj88d7th-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 25 Aug 2025 12:16:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZ1RIpYcmvwD/id8x3C38pl99Nz8tDVLDuDGHtkloUWZwNKynHfjNaqGlJj6Zy9wEUCIstkkI6yQynq1a76yj0pEBLYMJ6Au2OVBOf9SAtww6Vc9gKYZUZo9yaz2N4zHuutZgk3mncdgaDlqvsm3HAqsG6bD/tF8Of/Pf5DGeqJAIPPsySjiPScSZAhfbmKCojQBeBH5X4h3xYoRpLr835CYAyg1443JZhy1Ud6cVhZul9EDSF7s9ehC17HY8RW2TKRFCmqmvwhaakGs5XtLBwjiJSQAFGNbNGH/TnwvleVEsfDABLao+qIyu0veyzcVvtn8AxwGLyauPGRWKqxECg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8yPumbyHzL43vC7pcRMP5sv5dypf/qebnDRJIENZHQ4=;
 b=IKPFuQz/4qngzFar5NKHvjTq0ymtw0MBdcmphwU2DyaKxKxd/c90PpUv01Ppw3uoahfh38ULMn3J15qO7RaX5azoScVQQRyDjh9K3N0C+Ck1ogyhmIHC64YaAAL1fABaLa1dbhz2RMQKnj9UvlTh6CHnDTxrceEMWe73HNKjlQY66P8RxF0tPkal1UonGiZpobLrukkN3yeQvw4i7NQf2uvFdhFSizxMKSP6Gu2DhJ3Jj+hHujvfCNRPShXUc5LmV+QG+yUyYBPogExJ7URtwgwQV+a8Qnm6nqyN1fMBZE/4Flbg9T2x1d2YSz8FRUk4I8E4bb87IFPEtXKeH0bXtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8yPumbyHzL43vC7pcRMP5sv5dypf/qebnDRJIENZHQ4=;
 b=lzqp8a25FeQ/y9ngt+KKfzLs+NPDU3uS7McvW+msvb9Gsk+wZqP5gp1GiDjEdRbXfIPTzsFIDmMWGcuilvLmjUtUk3EAG0s6bnm674Igk1J0DdeDGANnstT8kiKMy1Ee85lihEWJUsw0Q++RJVrwziZs+H7Gw1oNtgVNFR/zEuE=
Received: from DM6PR10MB4363.namprd10.prod.outlook.com (2603:10b6:5:21e::21)
 by SA1PR10MB5782.namprd10.prod.outlook.com (2603:10b6:806:23f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 12:16:37 +0000
Received: from DM6PR10MB4363.namprd10.prod.outlook.com
 ([fe80::999b:18e4:cc6a:7cc6]) by DM6PR10MB4363.namprd10.prod.outlook.com
 ([fe80::999b:18e4:cc6a:7cc6%7]) with mapi id 15.20.9052.017; Mon, 25 Aug 2025
 12:16:36 +0000
Message-ID: <b9bb201a-8993-427d-ae0a-7aca06ac8516@oracle.com>
Date: Mon, 25 Aug 2025 08:16:34 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 5/6] virtio,virtio-net: skip consistency check in
 virtio_load for iterative migration
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, farosas@suse.de,
 eblake@redhat.com, armbru@redhat.com, jasowang@redhat.com,
 mst@redhat.com, si-wei.liu@oracle.com, boris.ostrovsky@oracle.com,
 Dragos Tatulea DE <dtatulea@nvidia.com>
References: <20250722124127.2497406-1-jonah.palmer@oracle.com>
 <20250722124127.2497406-6-jonah.palmer@oracle.com>
 <aJOCiUPp0dckmgAn@x1.local> <5e276607-cd86-4a1d-99f3-47dd2f0f3bc0@oracle.com>
 <aJTU641465aGKWRU@x1.local> <0cf99747-443e-4a29-a0da-64012548a994@oracle.com>
 <aJnydjxFzKwVzi7Y@x1.local> <eafcf9ca-f23f-42d5-b8c2-69f81a395d11@oracle.com>
 <aJpm4-JfmevsI7Ei@x1.local>
 <CAJaqyWfAnH-Lca3zmQTiR2wtaryKUo2KDKa=s5pcuAO9E6Efsw@mail.gmail.com>
 <aJyb6n9Vf4BhHqpb@x1.local>
 <CAJaqyWdUutZrAWKy9d=ip+h+y3BnptUrcL8Xj06XfizNxPtfpw@mail.gmail.com>
 <59317419-e832-4590-ad4f-cfe7d21e8fd4@oracle.com>
 <CAJaqyWfc3G5NLnxqXvZFxw2aRnVvOcZbLds5LHzcdoLjVGmOsw@mail.gmail.com>
 <c5b97e10-a8bb-4d59-b509-734eab7d5be3@oracle.com>
 <CAJaqyWc-vKsqs2boiktJn_cO3fSVk=-EfP3G8QN-z=n59VCoHA@mail.gmail.com>
 <4f067326-6c80-4768-886b-2b819e7184d3@oracle.com>
 <CAJaqyWcNdPyrAmRMBgdEk3o4AR1kK6ZiHWdY6q4MuwvGgjub8Q@mail.gmail.com>
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <CAJaqyWcNdPyrAmRMBgdEk3o4AR1kK6ZiHWdY6q4MuwvGgjub8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR15CA0050.namprd15.prod.outlook.com
 (2603:10b6:208:237::19) To DM6PR10MB4363.namprd10.prod.outlook.com
 (2603:10b6:5:21e::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4363:EE_|SA1PR10MB5782:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a84498c-cbff-497c-9639-08dde3d13cd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TlU5WWdkYWtnS3FZK1NlVG1xMHpSVlVXM25CU3hZMG5MTG4vcGZoOEM3Tm15?=
 =?utf-8?B?VndhL0tnQW02SXdGbmtpeWZQMFU1OFhjQmwwaWxJa0d2eFd2d3BCRzViWkFx?=
 =?utf-8?B?aE5GYnlrMW9nRXBxNVZDMVNiSTArOHJUMUk4Um5UWXlrNkJoTlN1T2lWd2ZM?=
 =?utf-8?B?bDh5L0ZRNWJaTUZzR0ZNUURGck5kZVh2Y2FuNllYZG5ERExvU2xncWxIUzFm?=
 =?utf-8?B?NjMrbUZIRFdrNHBtY1l0VlV4cFlsSlNjRStYVCtwYS9lL2lTRG9EWVZOVFhC?=
 =?utf-8?B?NWdiRGJHbmptUzdaSGRCN0psU2xXSEV5WmF1NVdrRVA3Lzliak5iU0dmem9r?=
 =?utf-8?B?NHlmSzl1ci9KZnFWVWRDRmFEVGxYUG5aTElDc0pvT2FSMmpETjVEeFF5eFps?=
 =?utf-8?B?bDNmT0ZCYWE3Wk5xeGdGbm83UW1EK2c2S3hpb3hKUzRrWlRCSEtrZktOUGli?=
 =?utf-8?B?OUNrRHY3TGZjQ2FEaGRRbkY5cGJjem9MNjV2ZHhjY2VlSDVMQlRHcE5uRTAx?=
 =?utf-8?B?RFJaRDlWUTI0RVZvWCtSd0oxRTNuTEdZRG5CSkhxVHRIUjlpdXpSbFU0ci9v?=
 =?utf-8?B?N3UvV0oxT0xwekIyUU45ZnNEUmVuRDc0KzFDRkNiZW9OTGtzdXJ5UjFyUGVo?=
 =?utf-8?B?TDJuWFNrSHB4VjE1VjZqT1ZJYmZQSDBDNzFaUjJYMmhlaDdjS3cyQ0RlekFs?=
 =?utf-8?B?OFlzMjNiV3NmaHB1MGh0eGNJODBDay9mbWQ0d2g2MUdaTXVId2tBVEYrcDd3?=
 =?utf-8?B?T2pqd2F3MXlZUUFxOWdESWVMU01maHNsdXZsQlBpQ1hRQkhMd2pKSlIvb2Vx?=
 =?utf-8?B?Y2pMQ1N0eUd2WDhGK1pERU1DVmdqV291V01sQkg3THRWRk9oK1JZTWR2MFRa?=
 =?utf-8?B?QzRLcHRyeDhrNU4wQjluVzFyZWpBVjA4ZnU3eHlibktraU12R3hlelVMOFRR?=
 =?utf-8?B?VWVkT2FIRnJOb3JmYU40NXNUcWptQ1ZxM1hFMnN3NkU3ZnkwQW1YUE5wUDNP?=
 =?utf-8?B?ZDFUOHVmWEpuSFhNbVE1VCttZ3dSZEl0Zm5qRDMxZUpxQmZhWEpkSlJ3b1Bj?=
 =?utf-8?B?SnQwaFpZWkM5VGJRV0F1ZXZqaWpHYURiRDFZdjlhNzdsa3Flc1JNQkdhbXUy?=
 =?utf-8?B?Q2N2QnFXTE9OM0pzZGhDWjl1ekZQdExnVXV0SmNlTENydDFydEVMQ3VSM3Aw?=
 =?utf-8?B?ZmxtanB3dS9zMGRrY01xbEV1MTJuWWg4U0w3M2lLVGZnNmp2VzVmeThaR2Ji?=
 =?utf-8?B?OGZJTC85bGU4bEdseWNGWjVvZi91bXgybjY4YnUxMW5keDhoMGVFSmtoTXVW?=
 =?utf-8?B?aHNJVDZmRi9HMCtQUUJ6SmJEM1R6bS8xNG11NUhaYUdyRWlNcS9wdnlJNlBQ?=
 =?utf-8?B?LzZSWVIwU0pzQXlOK2dlL2M5UC9PYjhhODRFSVEzKzdwemZiRVFaWUZhZDM1?=
 =?utf-8?B?RjVZNG1hby9uQ3VnMTJpNDhxbStIeUhES3M0TkJhV3NaOThMYnNxTG9mM3Ez?=
 =?utf-8?B?TUs1N3M4amdBTXk4N05vdFlOM1o4NmdlcjAwa2gycFJpMGFvQjJkQUtvbkRm?=
 =?utf-8?B?S3hrT3N6VEtyVzZaOW4rMnpFeUNxSkR0RzcwR1lpcEF3c0Y3UVUzOHhjWkdI?=
 =?utf-8?B?WU5IeE9pb2JLTUJSUmNBMDMwRStPZTkrQ1FTYnZoNDNhd3VyN1FHNHhzc3ZC?=
 =?utf-8?B?cXNiSmFZdk40dHFkUkRJYXdyQndsUkNIYU9OQjlLUkMyd2RwRlJDS0ZYWE1Q?=
 =?utf-8?B?Q2JxL0k1RTJhbVpxR2c0bENjektsRXBzajVvc2VYMVFQUk1EaStUTDJLZGpu?=
 =?utf-8?B?WjJoK2tGbWxtWnRkVERuMUx2RjFrRDNyZ0daSHBpcWFnbFJCN2FYdXJDQUhD?=
 =?utf-8?Q?zBrlIdUBync8g?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR10MB4363.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2FoeVRYSlhuYmtLZFdIbkZzelBBWmNRT0lxK1lIbkgzTnM3SVVUbXVYUDNy?=
 =?utf-8?B?bXMrWGtwejhWUjloVnhHamlwVG1acW5tbGNLNTNxZHhnL0EvaUc3Y3pNeVc3?=
 =?utf-8?B?cHdTM3hhZCtPamFPa1h6ZjZzTGxZN0JWZ2YwKzBJVGVySWlDYXhFbjhOa3hs?=
 =?utf-8?B?ZldBSUFraFBxSWZ0dTZsWUdsN3J4OVRkZHBQSWw1YUQwamNIL1dRTjMyWHdz?=
 =?utf-8?B?ajNIUTBJcHBnSXhWRTJJMXA3UXp2WEJKS1RDUi9EUkFaR3RsMlJXRFlPQzVF?=
 =?utf-8?B?UlFrWGwzMXN5d1psaVA4czJaVmZQNmoxZ1Fmd3E5dWxzTGY0V0pHdER5YTJi?=
 =?utf-8?B?ZWwrSi8zVFFGUnhnd0kwcklNWWpXS25MMXlWMWZ1VXFMUWY2NzVxWVRIUUFQ?=
 =?utf-8?B?ME9RRnRTQXhuR3ZCMUl3YTNwQmQvVThOKzlVV0xsRnE1WE56cjBkQ0ZyU2x5?=
 =?utf-8?B?eCtXSFR2QkpYTEQrcXFvWkNBblgzRStYMEl6bVlNRHQwdDc2dUlySUNUcXFV?=
 =?utf-8?B?QTlkV3g1NER5bm1jQUYvZmlGc1VkdzVlRTkrYWRDd2pPS3prRG10U3FucDFB?=
 =?utf-8?B?T3V6R01wYjM1enIxNUg0NEZUNGhtY24yYllBWmlOYzN1M0xQcTVMVWdMYUtz?=
 =?utf-8?B?RVJ2dExFMjBRVTYwYXdSbU1PRGZOdFVYQ2ozK3FnNzdRQkIrYm1yZnp0Snpu?=
 =?utf-8?B?SGU5RFU2cnRud0dlbE45OVl6WHk3dUtxMVhKVEV5REQrbUtCNnlPWGlwNmtJ?=
 =?utf-8?B?bFQzTHc4V05KR25TeHRoMk1PcHdtalBpakY1aU9HbUJzY1lBNzh1YnBCTjFm?=
 =?utf-8?B?SlhFRFIzbm0xeUdjUUR0N2NZM3NZU0M0YlZseUo5aSsxWmEwWVFVUFMyblc5?=
 =?utf-8?B?M0RJQWg5MElCYzNFZUtTR3hOSkN2a0hIckdvNTNPckJNdjgwYjZxT3Blangr?=
 =?utf-8?B?Y1JLdHhrekhiQ2xaY3ZCcitPVlB4cHZQakpJbkRkcEF2ODRTZDV5MGVldFlj?=
 =?utf-8?B?SVF4YlVlWnhxZWIrZEF1K2gyNWdUVERBUHJLUk1BNGhkeEVjNHpIb3JpN2g5?=
 =?utf-8?B?YzB5VGFvMEtYVFNHM2R0eU9Wd1FlTE5WdUxqQmRud2NaS05JdjRCUzVOYlE0?=
 =?utf-8?B?aGRzQ2VocWFpM25rSUFDQlhmS2N1enoyMnU5Y0hYZVl3WlJYTld1Q1FQVS90?=
 =?utf-8?B?QTNURGFVM1pRa1BEOUU4b2FES2M4NVJ4aHVYcWpBTlYzQVlaU2ZYdVR0Y2hC?=
 =?utf-8?B?OFRoUjRleUkyanpuZElWMEVySFNRSmVTVk0yaXBZRXdqeUExc3ZFREE1QmZY?=
 =?utf-8?B?Smw5MUlOdmlweHhicCtVcWhDRUNQMk5xdHRKRlJaZTh5V3NBUXJnVHlPbmRM?=
 =?utf-8?B?ME1YckJCdENGRUtPVm1sV00zbytVSU5ZVm1SYzBFeHd3NnRPQnRGRzRGSVpY?=
 =?utf-8?B?bzJZZVdHcXoyZ0F0YzlmdFZUcWNVV1lua3ppSXNyQ1N1c0dOVGpkaDZyOVpM?=
 =?utf-8?B?dXBSTHZZcytNdnlabHJJemo1ZmJib2xQOWdUaWJteW1uQkcvT2lTUG53cStH?=
 =?utf-8?B?RzY4c0JlbGM4QjUxUkl6VWxGYkI0b0ppMVBsK1JCSnpyZEJtcHR1cFlVL1N5?=
 =?utf-8?B?bndoekVBdzkyMng0VlJhZ1dmblRzMjI2YnordXNaWXZkdzR5K1ZzU1ZaU2t6?=
 =?utf-8?B?TDIxYnhabGtYdGMrUG1VZkVCN3VPUURVV1FGZ0padFRSbTFMS3pOK01yRFlr?=
 =?utf-8?B?RU9taGlKaGloSjR4UVNtSXAwWm9RTWQxRWY1SnBRS0xpQjZUR2lTdGQ3Rkp0?=
 =?utf-8?B?c0J4eVdaVE1qVlpyS25Pa2pueEVRSzBIUkVRMGkvMFE5TFNzdjJoT3IrQ0d2?=
 =?utf-8?B?ZU1UcjZtZmhBZ2dqTnYxK2lUY3p5dW5mdmFqUW5JcS83VVNqVnQzWTkwSTlj?=
 =?utf-8?B?TVZtWjFkZzJESmx6MHFNUnEyT1dvYWI1ZzNqaXN4YTIxZklQVVNaV1YvSmVa?=
 =?utf-8?B?c0VNOTFpTW13eGp6MDd6amo1MlJ2dHNGRzh0Y1V2YUJSWWZCWDBsRXdXTU1O?=
 =?utf-8?B?czZDbWtKTnZ1bzBmS3N0dUJuWDRvK3RDdlpPanVqcnhNY1IvbW9XYmtUSXAw?=
 =?utf-8?B?R2M0TjlyTUtRQ3d1RFduZVdMQXNUT1E1RGhrQWpkSTFtdEdZN1VTaGZpWUVP?=
 =?utf-8?B?Nmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HERLh0qIpoBZtNsBMQ2XtfAu8eM3Hl4Aqk5mJzZheRL+EwPcwSbNz8WgBWxKTu57JHfBOFZTBeD82BJk2IWUqxpcVkNvm8KdCZZmQ4sYawWxhodW+kJhKDJtf7HEg2VlaWEdsHtYOM1N3JydMtngHExsqUCGtE9sd57Db5RD5YEJ3Kno0lWXXtgmjTYsgmGEE0g7nIvi/dH2obddtQB0OYMRehguKv8rMhcTJJoazWwEOAjLmyEFFus8j4q1NSMJKpOHzH95ACFOHP+ECgbRqCDI3Ef75xYducY2G+6hOZIkLuXTfOnkCjGraeBBF3yDmkxO9nbIdZEwp6XQiMTjgZXzbsT0liPU3VaOsMlTfhBwbBD4ZXJ+m3RsMAguSLX+JFKPRI/RTRre/akJk6niuJuN0sQpcWy039WqrE7gWkavy9mALpDIplB9knvNfl+1GvSrslRNTe3E4wt3YD4zqNMwLVqlq5u0fIylmYbGQpPOFeiz+wrzAIwC4FDJ15D5/fi4h7zKbxw6cMt7xeeAktS5VukAsqC1PUfwmaCnSdh72NJQ8kxKuaZ4IioQHamXxugEbF+VxARAoimxX+F98CSPC5dtDNBK76ix+Nf/zMQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a84498c-cbff-497c-9639-08dde3d13cd0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4363.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 12:16:36.6732 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NZklrialEAkafO335ZvPvyweEZQDEuVo8gpSrZfrbJCfdAElNbF3WnqvlJBXHnh4spvo+ql/1ZJvuWojqg/lwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5782
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_06,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508250110
X-Proofpoint-ORIG-GUID: iI8uWzIDRxWXzn47wjlKKKyrRbzOfqiT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI0MDE4NCBTYWx0ZWRfX8IuOyG5FCtL+
 Ya/CFhyoj4MKo0q8nut6vX31nLmYVKejnKhsBVI7ypxzUmr3IyxYHofNIO7+zQTG0dqdJjf4KUc
 Rc9kDiTemkkRGlr+HTX5SDTjUdFL6xHg/KPh1DGg9b5vuxau57xqhJg9hIAQnJBe1zpWJ3p50AM
 6Sav87gM5OFIr8yW9wAh3ujQQq/GxlhOV7quQ13g2ImPG3tGm+BHmsXqyxO+6ZHjb/7O0efSc1x
 yHfeMoMvY4oQdrLTl4jB8j8k9SEtri3P21Y8/sQOoBduWmliixsnVOwfjliFgyOq9J6a7tQNj+J
 EDFGYY6qlWYVUj/92fCjOgB9p0B9fituZ2Dk62pPBpuL3D+g6mCTlqne+HzaOJ52zq30Po/orCs
 hC6NhzDcOoo9l7g7RaFbVhnynLX89w==
X-Proofpoint-GUID: iI8uWzIDRxWXzn47wjlKKKyrRbzOfqiT
X-Authority-Analysis: v=2.4 cv=IciHWXqa c=1 sm=1 tr=0 ts=68ac542a b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8
 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=AgB_dVTMMSuf6mv7kwkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12069
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 8/20/25 3:59 AM, Eugenio Perez Martin wrote:
> On Tue, Aug 19, 2025 at 5:11 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>
>>
>>
>> On 8/19/25 3:10 AM, Eugenio Perez Martin wrote:
>>> On Mon, Aug 18, 2025 at 4:46 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>>>
>>>>
>>>>
>>>> On 8/18/25 2:51 AM, Eugenio Perez Martin wrote:
>>>>> On Fri, Aug 15, 2025 at 4:50 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 8/14/25 5:28 AM, Eugenio Perez Martin wrote:
>>>>>>> On Wed, Aug 13, 2025 at 4:06 PM Peter Xu <peterx@redhat.com> wrote:
>>>>>>>>
>>>>>>>> On Wed, Aug 13, 2025 at 11:25:00AM +0200, Eugenio Perez Martin wrote:
>>>>>>>>> On Mon, Aug 11, 2025 at 11:56 PM Peter Xu <peterx@redhat.com> wrote:
>>>>>>>>>>
>>>>>>>>>> On Mon, Aug 11, 2025 at 05:26:05PM -0400, Jonah Palmer wrote:
>>>>>>>>>>> This effort was started to reduce the guest visible downtime by
>>>>>>>>>>> virtio-net/vhost-net/vhost-vDPA during live migration, especially
>>>>>>>>>>> vhost-vDPA.
>>>>>>>>>>>
>>>>>>>>>>> The downtime contributed by vhost-vDPA, for example, is not from having to
>>>>>>>>>>> migrate a lot of state but rather expensive backend control-plane latency
>>>>>>>>>>> like CVQ configurations (e.g. MQ queue pairs, RSS, MAC/VLAN filters, offload
>>>>>>>>>>> settings, MTU, etc.). Doing this requires kernel/HW NIC operations which
>>>>>>>>>>> dominates its downtime.
>>>>>>>>>>>
>>>>>>>>>>> In other words, by migrating the state of virtio-net early (before the
>>>>>>>>>>> stop-and-copy phase), we can also start staging backend configurations,
>>>>>>>>>>> which is the main contributor of downtime when migrating a vhost-vDPA
>>>>>>>>>>> device.
>>>>>>>>>>>
>>>>>>>>>>> I apologize if this series gives the impression that we're migrating a lot
>>>>>>>>>>> of data here. It's more along the lines of moving control-plane latency out
>>>>>>>>>>> of the stop-and-copy phase.
>>>>>>>>>>
>>>>>>>>>> I see, thanks.
>>>>>>>>>>
>>>>>>>>>> Please add these into the cover letter of the next post.  IMHO it's
>>>>>>>>>> extremely important information to explain the real goal of this work.  I
>>>>>>>>>> bet it is not expected for most people when reading the current cover
>>>>>>>>>> letter.
>>>>>>>>>>
>>>>>>>>>> Then it could have nothing to do with iterative phase, am I right?
>>>>>>>>>>
>>>>>>>>>> What are the data needed for the dest QEMU to start staging backend
>>>>>>>>>> configurations to the HWs underneath?  Does dest QEMU already have them in
>>>>>>>>>> the cmdlines?
>>>>>>>>>>
>>>>>>>>>> Asking this because I want to know whether it can be done completely
>>>>>>>>>> without src QEMU at all, e.g. when dest QEMU starts.
>>>>>>>>>>
>>>>>>>>>> If src QEMU's data is still needed, please also first consider providing
>>>>>>>>>> such facility using an "early VMSD" if it is ever possible: feel free to
>>>>>>>>>> refer to commit 3b95a71b22827d26178.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> While it works for this series, it does not allow to resend the state
>>>>>>>>> when the src device changes. For example, if the number of virtqueues
>>>>>>>>> is modified.
>>>>>>>>
>>>>>>>> Some explanation on "how sync number of vqueues helps downtime" would help.
>>>>>>>> Not "it might preheat things", but exactly why, and how that differs when
>>>>>>>> it's pure software, and when hardware will be involved.
>>>>>>>>
>>>>>>>
>>>>>>> By nvidia engineers to configure vqs (number, size, RSS, etc) takes
>>>>>>> about ~200ms:
>>>>>>> https://urldefense.com/v3/__https://lore.kernel.org/qemu-devel/6c8ebb97-d546-3f1c-4cdd-54e23a566f61@nvidia.com/T/__;!!ACWV5N9M2RV99hQ!OQdf7sGaBlbXhcFHX7AC7HgYxvFljgwWlIgJCvMgWwFvPqMrAMbWqf0862zV5shIjaUvlrk54fLTK6uo2pA$
>>>>>>>
>>>>>>> Adding Dragos here in case he can provide more details. Maybe the
>>>>>>> numbers have changed though.
>>>>>>>
>>>>>>> And I guess the difference with pure SW will always come down to PCI
>>>>>>> communications, which assume it is slower than configuring the host SW
>>>>>>> device in RAM or even CPU cache. But I admin that proper profiling is
>>>>>>> needed before making those claims.
>>>>>>>
>>>>>>> Jonah, can you print the time it takes to configure the vDPA device
>>>>>>> with traces vs the time it takes to enable the dataplane of the
>>>>>>> device? So we can get an idea of how much time we save with this.
>>>>>>>
>>>>>>
>>>>>> Let me know if this isn't what you're looking for.
>>>>>>
>>>>>> I'm assuming by "configuration time" you mean:
>>>>>>      - Time from device startup (entry to vhost_vdpa_dev_start()) to right
>>>>>>        before we start enabling the vrings (e.g.
>>>>>>        VHOST_VDPA_SET_VRING_ENABLE in vhost_vdpa_net_cvq_load()).
>>>>>>
>>>>>> And by "time taken to enable the dataplane" I'm assuming you mean:
>>>>>>      - Time right before we start enabling the vrings (see above) to right
>>>>>>        after we enable the last vring (at the end of
>>>>>>        vhost_vdpa_net_cvq_load())
>>>>>>
>>>>>> Guest specs: 128G Mem, SVQ=on, CVQ=on, 8 queue pairs:
>>>>>>
>>>>>> -netdev type=vhost-vdpa,vhostdev=$VHOST_VDPA_0,id=vhost-vdpa0,
>>>>>>             queues=8,x-svq=on
>>>>>>
>>>>>> -device virtio-net-pci,netdev=vhost-vdpa0,id=vdpa0,bootindex=-1,
>>>>>>             romfile=,page-per-vq=on,mac=$VF1_MAC,ctrl_vq=on,mq=on,
>>>>>>             ctrl_vlan=off,vectors=18,host_mtu=9000,
>>>>>>             disable-legacy=on,disable-modern=off
>>>>>>
>>>>>> ---
>>>>>>
>>>>>> Configuration time:    ~31s
>>>>>> Dataplane enable time: ~0.14ms
>>>>>>
>>>>>
>>>>> I was vague, but yes, that's representative enough! It would be more
>>>>> accurate if the configuration time ends by the time QEMU enables the
>>>>> first queue of the dataplane though.
>>>>>
>>>>> As Si-Wei mentions, is v->shared->listener_registered == true at the
>>>>> beginning of vhost_vdpa_dev_start?
>>>>>
>>>>
>>>> Ah, I also realized that Qemu I was using for measurements was using a
>>>> version before the listener_registered member was introduced.
>>>>
>>>> I retested with the latest changes in Qemu and set x-svq=off, e.g.:
>>>> guest specs: 128G Mem, SVQ=off, CVQ=on, 8 queue pairs. I ran testing 3
>>>> times for measurements.
>>>>
>>>> v->shared->listener_registered == false at the beginning of
>>>> vhost_vdpa_dev_start().
>>>>
>>>
>>> Let's move out the effect of the mem pinning from the downtime by
>>> registering the listener before the migration. Can you check why is it
>>> not registered at vhost_vdpa_set_owner?
>>>
>>
>> Sorry I was profiling improperly. The listener is registered at
>> vhost_vdpa_set_owner initially and v->shared->listener_registered is set
>> to true, but once we reach the first vhost_vdpa_dev_start call, it shows
>> as false and is re-registered later in the function.
>>
>> Should we always expect listener_registered == true at every
>> vhost_vdpa_dev_start call during startup?
> 
> Yes, that leaves all the memory pinning time out of the downtime.
> 
>> This is what I traced during
>> startup of a single guest (no migration).
> 
> We can trace the destination's QEMU to be more accurate, but probably
> it makes no difference.
> 
>> Tracepoint is right at the
>> start of the vhost_vdpa_dev_start function:
>>
>> vhost_vdpa_set_owner() - register memory listener
>> vhost_vdpa_dev_start() - v->shared->listener_registered = 0, started = 1
>> vhost_vdpa_dev_start() - v->shared->listener_registered = 1, started = 0
>> vhost_vdpa_dev_start() - v->shared->listener_registered = 0, started = 1
> 
> This is surprising. Can you trace how listener_registered goes to 0 again?
> 

When vhost_vdpa_dev_start gets called with started == false, 
vhost_vdpa_suspend is called, which calls vhost_vdpa_reset_device. In 
there is when v->shared->listener_registered = false.

And even by the first vhost_vdpa_dev_start there was another device 
reset after registering the memory listener in vhost_vdpa_set_owner.

>> vhost_vdpa_dev_start() - v->shared->listener_registered = 0, started = 1
>> vhost_vdpa_dev_start() - v->shared->listener_registered = 0, started = 1
>> vhost_vdpa_dev_start() - v->shared->listener_registered = 0, started = 1
>> vhost_vdpa_dev_start() - v->shared->listener_registered = 0, started = 1
>> vhost_vdpa_dev_start() - v->shared->listener_registered = 0, started = 1
>> vhost_vdpa_dev_start() - v->shared->listener_registered = 0, started = 1
>> vhost_vdpa_dev_start() - v->shared->listener_registered = 0, started = 1
>> vhost_vdpa_dev_start() - v->shared->listener_registered = 0, started = 1
>> ...
>> * VQs are now being enabled *
>>
>> I'm also seeing that when the guest is being shutdown,
>> dev->vhost_ops->vhost_get_vring_base() is failing in
>> do_vhost_virtqueue_stop():
>>
>> ...
>> [  114.718429] systemd-shutdown[1]: Syncing filesystems and block devices.
>> [  114.719255] systemd-shutdown[1]: Powering off.
>> [  114.719916] sd 0:0:0:0: [sda] Synchronizing SCSI cache
>> [  114.724826] ACPI: PM: Preparing to enter system sleep state S5
>> [  114.725593] reboot: Power down
>> vhost_vdpa_dev_start() - v->shared->listener_registered = 1, started = 0
>> vhost_vdpa_dev_start() - v->shared->listener_registered = 1, started = 0
>> qemu-system-x86_64: vhost VQ 2 ring restore failed: -1: Operation not
>> permitted (1)
>> qemu-system-x86_64: vhost VQ 3 ring restore failed: -1: Operation not
>> permitted (1)
>> vhost_vdpa_dev_start() - v->shared->listener_registered = 1, started = 0
>> qemu-system-x86_64: vhost VQ 4 ring restore failed: -1: Operation not
>> permitted (1)
>> qemu-system-x86_64: vhost VQ 5 ring restore failed: -1: Operation not
>> permitted (1)
>> vhost_vdpa_dev_start() - v->shared->listener_registered = 1, started = 0
>> qemu-system-x86_64: vhost VQ 6 ring restore failed: -1: Operation not
>> permitted (1)
>> qemu-system-x86_64: vhost VQ 7 ring restore failed: -1: Operation not
>> permitted (1)
>> vhost_vdpa_dev_start() - v->shared->listener_registered = 1, started = 0
>> qemu-system-x86_64: vhost VQ 8 ring restore failed: -1: Operation not
>> permitted (1)
>> qemu-system-x86_64: vhost VQ 9 ring restore failed: -1: Operation not
>> permitted (1)
>> vhost_vdpa_dev_start() - v->shared->listener_registered = 1, started = 0
>> qemu-system-x86_64: vhost VQ 10 ring restore failed: -1: Operation not
>> permitted (1)
>> qemu-system-x86_64: vhost VQ 11 ring restore failed: -1: Operation not
>> permitted (1)
>> vhost_vdpa_dev_start() - v->shared->listener_registered = 1, started = 0
>> qemu-system-x86_64: vhost VQ 12 ring restore failed: -1: Operation not
>> permitted (1)
>> qemu-system-x86_64: vhost VQ 13 ring restore failed: -1: Operation not
>> permitted (1)
>> vhost_vdpa_dev_start() - v->shared->listener_registered = 1, started = 0
>> qemu-system-x86_64: vhost VQ 14 ring restore failed: -1: Operation not
>> permitted (1)
>> qemu-system-x86_64: vhost VQ 15 ring restore failed: -1: Operation not
>> permitted (1)
>> vhost_vdpa_dev_start() - v->shared->listener_registered = 1, started = 0
>>
>> However when x-svq=on, I don't see these errors on shutdown.
>>
> 
> SVQ can mask this error as it does not need to forward the ring
> restore message to the device. It can just start with 0 and convert
> indexes.
> 
> Let's focus on listened_registered first :).
> 
>>>> ---
>>>>
>>>> Configuration time: Time from first entry into vhost_vdpa_dev_start() to
>>>> right after Qemu enables the first VQ.
>>>>     - 26.947s, 26.606s, 27.326s
>>>>
>>>> Enable dataplane: Time from right after first VQ is enabled to right
>>>> after the last VQ is enabled.
>>>>     - 0.081ms, 0.081ms, 0.079ms
>>>>
>>>
>>
> 


