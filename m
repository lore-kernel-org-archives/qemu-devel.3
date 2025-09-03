Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD6ECA0FF2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 16:10:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utq3a-0008Bq-29; Wed, 03 Sep 2025 12:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1utq3X-0008B2-Ei
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 12:09:55 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1utq3T-0000KU-IT
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 12:09:55 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5839N9lU017526;
 Wed, 3 Sep 2025 16:09:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=6XSxLTA38pgPelZbSgSP4sGKdFDOCWeGQt4s9vQoWp8=; b=
 Q65una8FjpMW/8VrxKZOebBDdLyY5UFYG2yv1TJo2kiwDyc6IfZW44/KHK2Bq9Ri
 TUnIQP54wfI0TUz+SR0MaWMkQ8xTyLFZ36BylNKP9JCeC9LtWt+4JfQo//7FaZg2
 pFbEVra6rHvHB54HtjJ4FJrz0x3r4Qv9Z5WonTXuQgzz8AQnPXL/7IDQbdlzm4Pi
 T81saitH/d4EzqTkqXnNh33umYBSyuH5OGBBen9CE8qUrZ2EGYvsDh/sDAqMvBfN
 oDCm5QgPJmNmFqNF5Pm9RFlc7d2HUWQVY8SJSRNnt0kv7ORst7jtbCDksDstF4RS
 LZJK5lC0n5toIEyiqFjJCw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48usmbepru-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 03 Sep 2025 16:09:45 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 583FAdwQ040023; Wed, 3 Sep 2025 16:09:45 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 48uqrgkc48-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 03 Sep 2025 16:09:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GScp+//SLPVTdoK5ktsKYylR+ek+00lhZe8Z3Lt58z6EaFP+KyXIcdq9xduQJEKt+SjKMNHI4vQIMSOXsWjRFUalA0V0WmXHf475ImKD0G24q6pbk2Rr7yo/hekkPuyqALNi+8YvJmoGso3wnAZmF9ttXnbihH5q0ef9JlfKYAiUuGhKlA4QivjReuBvMIPItCAzlLOoI65/lLC4BiT3Hc9BV/1DJKqZcKZYYnNFCWz0ooCcV1nD/XiAImHvf8Pj+LECV7IlZx2zceUzMrJDFEqGMr7BnHIZ316PP0aLBZFIdDbtHPEPlEeLun+0uP4HTG7D7w/5MxlG4uKJ5Y1puA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6XSxLTA38pgPelZbSgSP4sGKdFDOCWeGQt4s9vQoWp8=;
 b=pO/tsEV/edG9wsfGqcmm3pfSVJcm89h9Tkw9CY49w1dLevvPlI/K0g46YfCT0+EzWv7xdjmlqxF7kdAo1cwL5KFu7q+bsgQ2EVTbWjsZwN4eY7YFQWvHw7BdTWTj+vpRZ2m9WqOSotfusHsn+KP1LrArVJjx56BF9qOQFnn7UCmoooWqQp3x0hPO0hZC9C9kJXivkz9UsEf9ghS6o2p9/m7kzvLMOOhcZtVZMvC8EG9qT0fiveFRQphzCYFFZtNQRBN1krmS9Y8ERve+RiXMAUCWRVf7pJLgfcK8ECO6fSZgQ54o9549BpM+y5wNgYoefEBhqB287xP/2PVcrbJvmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6XSxLTA38pgPelZbSgSP4sGKdFDOCWeGQt4s9vQoWp8=;
 b=l+JUCA+aExHssQxUXnoKPYhC1gYZWD0DMeoX0mCm++eNGVTzqAK9A50MkSwqYV9PN3FK6K8c4x+UpSckAJPdKTB2EGypQW3pBuAZjxanvXO0dYbZq2GJm0Y/3S3yUMBifr+/13CLnUkpW5becxpeWnqL8neh2Nj2cMlfHtUupQ4=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH8PR10MB6387.namprd10.prod.outlook.com (2603:10b6:510:1c2::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 16:09:42 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.9094.016; Wed, 3 Sep 2025
 16:09:41 +0000
Message-ID: <12ec1ef1-9258-4ccb-9140-bbb6a2bd93af@oracle.com>
Date: Wed, 3 Sep 2025 12:09:36 -0400
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
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <16e31f9b-49ef-44a4-b9ad-0668e3c2c530@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH1PEPF00013312.namprd07.prod.outlook.com
 (2603:10b6:518:1::d) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH8PR10MB6387:EE_
X-MS-Office365-Filtering-Correlation-Id: d937cf22-ef7b-4b1a-b918-08ddeb044a35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QWk0MEo1NjFmMVZ2dVVNZ2tsc0FES3JSLys5OFFkRVVWTk4zc2FtMmg0dkEy?=
 =?utf-8?B?TUhLYU1oaENIS1dSK0xuUWxOTkp0cktjN1RERDFBeU9PTzV0cTloRHoxYmdI?=
 =?utf-8?B?Z0JIYlBMNmlvdEJVaUJtWFF5elpydjFMZ2JTNWVibGRnRi9VaGozRm9hclhC?=
 =?utf-8?B?ZFZSSVplRU40Tm9BU0hnaHRaYVZRSG5rMERXZEF3cUJBVmFHRStaMHBKSHFz?=
 =?utf-8?B?SHl6WHBJTk1uTVNKYjZBVVRNblZzS0hTTDBESytZRnk5bjMxblB5dlllVTBQ?=
 =?utf-8?B?Y1pFeHlhZmt6N1ljWm5jeDRuU08yZ1F0ZldkNkhjbE1sYXM3aXBVTjlpOFo4?=
 =?utf-8?B?cHhMeE1NOTNsd2RWSnVFNGFRRjJJTzFLNHkvSlRvSG5WeVc5UXkyK0w3NENQ?=
 =?utf-8?B?ek8yS3k3MGFLREJoTDB0d3lWN21jY1FNSlAzRVFINlI3K1pOMGV4WmVBb3U2?=
 =?utf-8?B?MnVDNmVCd3M0U0NWbWV4Yzhvak8rYU9uYUhkNUEwZnAwMkg5K3lNY0gySFlj?=
 =?utf-8?B?WlFoeFk1ZGt4dUN5LzZwWGdaeVZzbFJLRkMzMS9SSS9xVTV5a2FCTHkwSVpO?=
 =?utf-8?B?Tklzckt6b2Qzdy95a0RPdE1ybWR4a2lvUDhsRjBUYlJLQ21wb2s0bW03S3BD?=
 =?utf-8?B?aUYrTUxNcll0RzBWZ2pWQStFK3ZOWVMrUndBRmNLemwxM1grMnlRVnpocTZY?=
 =?utf-8?B?YWxoQk13cFlLWVB6UnFLd0RUWi9ycWd1d0JXYkt0aEdXQVhxemUzK2h2UCtW?=
 =?utf-8?B?TGRzRVNOYXBIMFpxSkJObEtheWNWSGhPcGc5amQrZk82TUVkNTk5cFNLTWJk?=
 =?utf-8?B?U1hHb2Q4TjByT1BRWFBWZS8zOVdGSzJ3aElmYmZmY2g2QlRCNzZKZmQwdW5n?=
 =?utf-8?B?VHNPcjR5YlR4ci9vM0tYbHkweU1LL1dUMTh0Sjh3MFpMT2dkOU1ZNCtWa3k3?=
 =?utf-8?B?bmNnbjNoY0QrYWpEa1Fhek4wWWw0UmRSTGpZWmNRSXhrZVdUQVFVYmNWNjBr?=
 =?utf-8?B?eE1PUWp2VjBBMEtuZUcvNUROTm13VlRBbzdKMHhGTEh6QXgrdVluVkt6TWdm?=
 =?utf-8?B?YXdiYTBWSHN0Qm15Qktxd0poYzlPZjk2b3JDY2V0dm5QM2xqZ2NFNnVkLzNZ?=
 =?utf-8?B?Q0FaOW83YVFUZlo5SHBwYlRBMERMNlJlbG1hb0FLOWlDdWRnMi9aODBjVnpD?=
 =?utf-8?B?dGtXU21PL1o4bzlsSDNGK01UbXRoQzZZNHdvaDNzRStJODdxdnpieDJJTDN1?=
 =?utf-8?B?Y3hKM29yZHRnMXFmcmhPM3JLRzZaS2tSTk1jUVo2UWJhd3ZQK01qNG9xbXVu?=
 =?utf-8?B?STBCNUFjckNKeXNLK1A2TXVHbGxiOXpvTERDWk02RnFlT2NGK0ZES2RINGlh?=
 =?utf-8?B?VUpNSkU5YjhRQnJxV0IxbmV6UzdoaFhLZHlJZmRLUDZqa2g5MFFjMXIyZlEy?=
 =?utf-8?B?SmJGRk9HYlZpOEsvVm52bHJNbitvL0xVR0lKem1kRjgvb3Yycm1LRHovVERJ?=
 =?utf-8?B?b0Zjd2lhOFZETHVtSU9Jc2tLMHEvYWRyL0o5WnNsaHNnU1JDUkJ2Q2x3Vjhv?=
 =?utf-8?B?QSswd3hRVWFrZWFLNlgrNWJJYTVNQkhKdkRCNlFGdUo2UDk2eWpkMXFma2dB?=
 =?utf-8?B?WStHTmcxaitFQWpaeUNsZnlNQnAyMFM5akkxUVluOTVDdC9HVk43d2lxaGdC?=
 =?utf-8?B?NVZNZnZmcU5weGhLSGZXbG8zQTd5eGdIWmh3N2FFcVJjYldsMGNOcTVMSGxx?=
 =?utf-8?B?NGtjZk9neDNpYXBBdnRlNmUzMTBWekVZSHlWbG9kOFppeDV4YUxUOVpDVHFj?=
 =?utf-8?B?Y2xobDhPYUZyeEVUcm9JRkdXeFM3dm5JVFFYVVFJM0dyNUlrZGpnQ25wcm1k?=
 =?utf-8?B?d2xBTjB6cUQzTmZEVDdWTHVpUUR3V3RrVTJGbXhsQjlOV1NKMTl5MktscU5T?=
 =?utf-8?Q?RjulpSyx7t0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFU5WDhNYndyT2lsclpEbWFRbmJBazJQd0t3QU5oWDJadVlFR0RhL2puTGRD?=
 =?utf-8?B?Z29IOEdiS09NeEJJYVhpQlQyaXFLTFZuYzZxcUl0TDNpSE16MFZIUVc2bGtJ?=
 =?utf-8?B?UitBWitPc1Q2VzdiRE5wVHUrY0lBVllRc2ZCK2RFSWZ1aHFKaHllMlZkaGM1?=
 =?utf-8?B?YlpCQWNWdU9BQU5Pb1RNcEJ4RUFtc2pJWWhrVzJGVjNnODJHbHVxRU1mbHFW?=
 =?utf-8?B?ZXhGZmJtQzJRL3doakI2V3lkbFpzR0FJWDRIN3pOUEpzcjZnWGZ2ZHpPL0Y2?=
 =?utf-8?B?ajk5QlFld3dhWXFIaUxkdHNEbXdGQkRWb0tMc3I3K0J6L2hmb0l6SkZLS3ZI?=
 =?utf-8?B?VnAydEh2RHI0cGJtZnprTHFjcG5WMkp1M3J2NWx3YmlzZ2N5TWFQVTNTN1Na?=
 =?utf-8?B?RzBzalgwTGNUQys2dXYwRnlxSzJVZ2tNNlJSS3VwQmQzLzZlekpxekFjQ0gw?=
 =?utf-8?B?aXZTYmdKUjBxVHV2M1NhcCswZnZKVTZCTTRvUEpXcjJZL0lFVzNuV1dxTEEy?=
 =?utf-8?B?dWhheitvYkxZN2E3VmFWd0tmNVB4eFQvY1lyU2VkUG5rWUFlOXRCaitoZ2hs?=
 =?utf-8?B?SG1aVmtZeFdqakl0K1FSaEwrUGpydTlTODN6Mjg1Y3g2YjdxTiszYkVpWlVC?=
 =?utf-8?B?MWlBRDJWMnlPeE1EWGRUZVM3Zk5GTWxYeEMwdmRlSDFpQkJpOGNTWUxFNEk0?=
 =?utf-8?B?L0Z4UWdmdjJCQ3ZrS2RuTkVYMXZ2WVZWR2gwdytwYWVOQjhCaFVTbnpvYVdp?=
 =?utf-8?B?S3BlSUFsbXZzdGdHSjhnMUtkZVhKaWtsRFZCVFpZbzBuRmp3UzBLVzFTOFpP?=
 =?utf-8?B?cTRzcWJBb3RaMGhqN2xuSlR6UEw1NWYxazNWbXA2UTI5K3Y0eUxTeXF5a25l?=
 =?utf-8?B?cy9XZ2lVUHloWUhHaGtoYkwyVEErNUZqUElwREtJUFpaOUFya0NSVTJidTRP?=
 =?utf-8?B?S29BY043T1hHbzNRN1VOOUM5c2VHdjBjRXdyMmlKb05SR1oyd1RuQUYrWStt?=
 =?utf-8?B?bFpyamNKL3dqZkN2QTZhbzRGU3FpL1ZpcXFCdFZnQyswWjBmV1haQWhGTmcz?=
 =?utf-8?B?ZGtZTFhoZGdyZ0hOb0hNekx5ZHJFd2pGNlVqKzJ0djh1d1hnUzVkZ3dpUnIw?=
 =?utf-8?B?YnY5RERHYlFkWHVZS1Y3a0NSREVpWU5rdTY5ZzF1cTQ5RTFGaTdyY2JpWTF6?=
 =?utf-8?B?U3BVUGsyZjRsa014dU8yTk1DRlhuOHJpQVl2SkFSSENQNW0rdkJGclFpSHlz?=
 =?utf-8?B?NkR4aDJXTXdTMnI0MVB1L05vOHBISkQrNmpuM0I4MFdtWjBOeVpjQnBjSllI?=
 =?utf-8?B?TEpGWmF1MVEya0pZUXBmQ0tZS1VpaTRMYnlLRDhEVUxXVlNaMUtaNk8rUitm?=
 =?utf-8?B?M3lqM3VxUHhmbnBGVXk3THFreCt5S0dyOXRYdk5xK1hYVkVTcHYxc1BneXdC?=
 =?utf-8?B?cVBHeDRmUUs0ZDNhamZXN1RISWdOYmZoa1paaUNnTUIvclNTUHJXL2cyMjhy?=
 =?utf-8?B?QnV5WnZBSm9lNmJNczM0bjVITmpJbVhTZ0thTVN0MXk5L1RhUWxVdElHNFhR?=
 =?utf-8?B?RTF2enlMWS9wRFZQcTBCZXo0ZjBBZXI2QVI3bEdHNHk3QU1ja085a3pxK24z?=
 =?utf-8?B?enZzc3VIaXdoKzBhVGZsTHhNYWZhWnpzY0RjVlV4NkpiRU9CaGFBZHRLTWlY?=
 =?utf-8?B?dDhpM0FaVWVXTkFheEI2Ymp3UklLazIxT1lWN1BMaU11bk1FTUs0eXNRb0xM?=
 =?utf-8?B?VjAwNlBxOXJtMjB2cGsrOWVEK2pFQTBOck9BRi9Fb3J3Tzk3L25JdFZVbzZz?=
 =?utf-8?B?R3dnY284NWZJL0dJb2JoM3ZtbExDd0dWU3ZIcGc5cGFlclJjS2U4MklJYjFz?=
 =?utf-8?B?Q2QyM0l0T3N5OUlvZXdLaUVSdTBMdW1kOHZVR21Nb1IrMTRGUGFYZk9uY2Jw?=
 =?utf-8?B?Q0NpZEhwR1M3d1JaVEU4c3J1QjFNdWRjazZBV0tKbzhDdzM5SzNIMDdGbDRO?=
 =?utf-8?B?V0FsbDNCWldKNUQwYzFTQ0tOUFpGWTlTcHhVWUs3bEMyc3FPeVgvZ3k5VUhR?=
 =?utf-8?B?RlM4OEJBSVJ4cFlZYy9oLzBnNmx6cFE3NVZFdHc0dkEvNW8raERreVhNdUhS?=
 =?utf-8?B?NHlkaEFHUE5OeEhiNlF2c09QRXN0bkVqL3ZaZ3NCKzF3WjFxZmdjNkJIRVhE?=
 =?utf-8?B?Zmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2YC5VQQ48Hg+ZjUMAABzoEByz90s7FkgqwXOWLJeIbSFTN+wdPDFCqL21bh663cL84nSmg32CRl4wlGcgmCNN6AZawvLXAqzboeYJalJZUgLEtGBdRxG4kGJSt6B3/ZixTZUQEeTKgmbqwdc0Iqb8U9lgVnQr+yC+pvR/Zo+LIn+dDajkv5M8gYwrxVzibMaiSLOHcTK0xrnNuMc9zj3kF/PB5EKWuy1WV32KzikqNiKUiG8rBP6d3I1qovJjYuwVV+1rEgfIRmhL6m89JoA4PcAhWsIWOWQY+uq64Bd6M9aSnbhf9cTBnSRWoKlocN5dIGeR1bbhA1msl+3iZhCQLurFRaKn71AK45fgwbffBPl3iXWni3mDDrpqjZCfJYso+xxoL4GSzbxMbzxXKEO+KaiHzKELKi+pqhGcO+rhtVO4X+uzu0tqB3S4hH6++DoSJXFBusy/6klaR6wnt//2+KepO4q3BXC/fr3eqaqRZKnLAvUNSj/CEWd4xOJ3fnEK6y13o2movTbK218nRFf5sJG//dBYuYObRMFqrX0ZY4IWhi2alhgeRJFleyWvoA3wqXn91N98u3bVWiWVm77K/zTPvBTSVOQDLY2IMEJ81Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d937cf22-ef7b-4b1a-b918-08ddeb044a35
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 16:09:41.6916 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jth2J0S8u5EDG9wU50hWWr9lL/33g7gIXYf7HEapxLx0PLIulLibJVhv/KBRpNyGZqaz3BUpppXVzzPCeKscLrcFtPsyqgks2vVQO6ihWJ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6387
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_08,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509030162
X-Proofpoint-ORIG-GUID: bC9Qjr0OTXfDYCU2vs8L-efwIdshjRqL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX+AtQcntOG3Th
 OTWHQCEK/6XkXHSHcqq73FW36L8UoBxDAW3LGiJgUkYcrn1g/QATo3nPOL3fwKd5R44xDgASvvG
 rEtW4kSGbLzM7ohRLU4RP56/l3oa120FdjN7pIeXs/w/6gOtRBlhNSVuKcmC2gBWaDu8anQ44ZY
 F3CmfNdrG/lhBsDsB7cvUK0ytYI5lFLB8hkopgnIzP+WABdZNWd1rIY3pY2Gsrp6Cl86eVN/8eH
 M2kJB4aohzZ45JgbXJsWXSBy6ynLan0pnk37TApwUPVy7LQe3IpWjjdE11p+rnnbhaVGuT+eBl2
 d2MVgu/e/+gD46OzvKu7RKP9qXlBquuMTXn+W+NfJ9KmK9bpaZPSSjGhJXhF1EVmU3heNXVvqYF
 ZCdwXiQUc3HQSk8lvNediM0Uk0OjVA==
X-Authority-Analysis: v=2.4 cv=KORaDEFo c=1 sm=1 tr=0 ts=68b8684a b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=6R7veym_AAAA:8 a=_LKlCwbjXK99E5ehFSUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=ILCOIF4F_8SzUMnO7jNM:22 cc=ntf
 awl=host:12068
X-Proofpoint-GUID: bC9Qjr0OTXfDYCU2vs8L-efwIdshjRqL
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

On 9/3/2025 11:31 AM, Vladimir Sementsov-Ogievskiy wrote:
> On 03.09.25 17:34, Daniel P. Berrangé wrote:
>> On Wed, Sep 03, 2025 at 04:37:02PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>> Handle local-incoming option:
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>> ---
>>>   include/net/tap.h |   4 ++
>>>   net/tap.c         | 136 +++++++++++++++++++++++++++++++++++++++-------
>>>   2 files changed, 119 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/include/net/tap.h b/include/net/tap.h
>>> index 6f34f13eae..3ef2e2dbae 100644
>>> --- a/include/net/tap.h
>>> +++ b/include/net/tap.h
>>> @@ -30,7 +30,11 @@
>>>   int tap_enable(NetClientState *nc);
>>>   int tap_disable(NetClientState *nc);
>>> +bool tap_local_incoming(NetClientState *nc);
>>>   int tap_get_fd(NetClientState *nc);
>>> +int tap_load(NetClientState *nc, QEMUFile *f);
>>> +int tap_save(NetClientState *nc, QEMUFile *f);
>>> +
>>>   #endif /* QEMU_NET_TAP_H */
>>> diff --git a/net/tap.c b/net/tap.c
>>> index a9d955ac5f..499db756ea 100644
>>> --- a/net/tap.c
>>> +++ b/net/tap.c
>>> @@ -35,6 +35,8 @@
>>>   #include "net/eth.h"
>>>   #include "net/net.h"
>>>   #include "clients.h"
>>> +#include "migration/migration.h"
>>> +#include "migration/qemu-file.h"
>>>   #include "monitor/monitor.h"
>>>   #include "system/system.h"
>>>   #include "qapi/error.h"
>>> @@ -82,6 +84,7 @@ typedef struct TAPState {
>>>       VHostNetState *vhost_net;
>>>       unsigned host_vnet_hdr_len;
>>>       Notifier exit;
>>> +    bool local_incoming;
>>>   } TAPState;
>>>   static void launch_script(const char *setup_script, const char *ifname,
>>> @@ -803,6 +806,40 @@ static int net_tap_init_vhost(TAPState *s, Error **errp) {
>>>       return 0;
>>>   }
>>> +int tap_save(NetClientState *nc, QEMUFile *f)
>>> +{
>>> +    TAPState *s = DO_UPCAST(TAPState, nc, nc);
>>> +
>>> +    qemu_file_put_fd(f, s->fd);
>>> +    qemu_put_byte(f, s->using_vnet_hdr);
>>> +    qemu_put_byte(f, s->has_ufo);
>>> +    qemu_put_byte(f, s->has_uso);
>>> +    qemu_put_byte(f, s->enabled);
>>> +    qemu_put_be32(f, s->host_vnet_hdr_len);
>>
>>
>> Is it neccessary to transfer that metadata, or is there perhaps a way
>> for the other side to query the TAP FD configuration from the kernel
>> to detect this ?
> 
> Oh, good question, thanks for it. I just added everything and then I was debugging other places.
> 
> for hdr_len we have TUNGETVNETHDRSZ, so it's possible.
> 
> using_vnet_hdr, seems is equal to initial vnet_hdr option (with default to 1 if not specified), will doublecheck
> 
> for ufo/uso, which are set through TUNSETOFFLOAD, we don't have direct way to
> get the state. But we can use the fact, that qemu tries to set them once,
> and these variables are unchanged after initialization. So we can try set
> same flags on target the same way, to understand what we have. Still,
> this doesn't seem absolutely safe.. Kernel may behave differently than
> for previous initialization, probably due to some changed settings.
> 
> for enabled it seems not possible, but we handle it in virtio layer.. Oops,
> probably I always migrate enabled=false with this code, will check.
> 
> ---
> 
> On the other hand, calling extra ioctls to learn something lead to extra downtime
> (should be measured to be a good argument).
> 
> Also, just architecturally: seems better not ask third agent about metadata that we already know.
> 
> ---
> 
> About forward-compatibility (if we add new fields here) - agree.
> 
> Maybe turn several boolean fields into one flags field. This way we'll get several "reserved" bits for future changes.
> 
>>
>> I'm concerned that this code / wire format is not extensible if we ever
>> add another similar field to TAPState in the future.

tap_save and tap_load should be replaced with a VMStateDescription for future
extensibility.  Use VMSTATE_FD for the fd.  Define a postload hook for
tap_read_poll and net_tap_init_vhost.

- Steve

>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +int tap_load(NetClientState *nc, QEMUFile *f)
>>> +{
>>> +    TAPState *s = DO_UPCAST(TAPState, nc, nc);
>>> +
>>> +    s->fd = qemu_file_get_fd(f);
>>> +    if (s->fd < 0) {
>>> +        return -1;
>>> +    }
>>> +
>>> +    s->using_vnet_hdr = qemu_get_byte(f);
>>> +    s->has_ufo = qemu_get_byte(f);
>>> +    s->has_uso = qemu_get_byte(f);
>>> +    s->enabled = qemu_get_byte(f);
>>> +    qemu_get_be32s(f, &s->host_vnet_hdr_len);
>>> +
>>> +    tap_read_poll(s, true);
>>> +
>>> +    return net_tap_init_vhost(s, NULL);
>>> +}
>>> +
>>>   static int net_tap_fd_init_common(const Netdev *netdev, NetClientState *peer,
>>>                                     const char *model, const char *name,
>>>                                     const char *ifname, const char *script,
>>
>> With regards,
>> Daniel
> 
> 


