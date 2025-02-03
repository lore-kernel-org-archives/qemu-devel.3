Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05DE3C02193
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 22:28:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf4vB-0002AS-Uw; Mon, 03 Feb 2025 17:28:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tf4vA-000262-OT
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 17:28:00 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tf4v8-0002Ph-Dj
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 17:28:00 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513JMtKg001047;
 Mon, 3 Feb 2025 22:27:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=TH0v4OMyCvmBQC54YpD/3EZtZ37kAiY1bk+3qu81VP8=; b=
 SrcJl8IcGkHaAmh3svGNRzozBIEh/73CZ8CstoAEiAy+ORRsR/K38YaPCoIQru1g
 r9COdB73l7xkSeofpfTahJZ5eLKN4vEpa1rBnlzW/+XTRh7obJHXKwl5nOlXF2Kx
 MylZbO5BcupMCSAWkfzSeFlALDpsUvwx7E3GoJvS2bxOljN22CZvDiyS25CrvX20
 /2RsiSRaO6LrbH8EYveJdTE8I883Kec3upRmhGiB/kpoHDxcwjgTtav4kdi0ZDNa
 nSQRyts4+Hmyjj3Y8BI4mv4FxcpJR9d7+3GtWukA0msLHGoBwj/BDS7euBF54As0
 p+YDGtyzSWs0oRJ9bGzPSg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hhjtupmd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 03 Feb 2025 22:27:54 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 513LiML7029909; Mon, 3 Feb 2025 22:27:53 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 44j8p285sq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 03 Feb 2025 22:27:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c9UOL0NIy2TCQYB9MjLBkRg0F5rvN15RrUouSJcqR3t+01vbW9ulH3RPPno20eo18jNLtanJMOcMVr2qtIqVHNvMIxUXeN22lMHYn0SepEmsSIOe8zc5/nMg4prxsFdziKSUD8Iswf72qHM0x3InkmRU7CM+cFFmO3wPmXqlw4e/wVmfvmz76p0FqDywcFH2B8lTYXzXJTgYnIYMTnkl8BnCIW/lUQy62lCY27WhwIW//T8L21DFu/gC6NWHuLJ3Lp2L56iFqVJjRiYSm1H3rP59kj7PpbCaznScIcaALlnR/zgaqc1nnX9vMddhf+qY/ULVHCPnjC7fWdAaYzAOwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TH0v4OMyCvmBQC54YpD/3EZtZ37kAiY1bk+3qu81VP8=;
 b=QZL5jG2g9uvzTJbTWz6TsF1obPG2ybPTUBJOlfeHz1C9IkyBu9wQnaO1dnlaBGa7teDjNnQSVmKHzsNp66VNcd6AIUOUK6C8Hre7tRJpbbg77rojeU6ZbKwwPvkCEcDN4QpGHkIhrDC3Ml1Z2tKNCYoJZCu/ZiBefn12JtBDqCJbbrofkR7Khw2JVdAaFdyR3Y6s73Pg+jeT45JwoDRFh4fRrtWLtCyPx4G9STvOc+CQYW/tFY/gq6dkRSPd54raSO9Q4h4LOhOXfpSz60BIL6l6maKYgcXAC4xWHqSu0eLzFmm/kKRMGsZUzFB8RuNfKNtgG0n4Z4DluHzYKxrveg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TH0v4OMyCvmBQC54YpD/3EZtZ37kAiY1bk+3qu81VP8=;
 b=MqRVTExuiymhQ19KqgoNIUCtU9tuePyOvVkdK0u0pA4wttl+Ps+EL6vg6n5MoXhQPyaayKju0D4HmFvc8GrvNGXyDhzGIFuao4xj2NcQrzQQo730mSK6K373j9PGM0vkbCYkDTeae8mDokZmO9rmfZQzsh99TUSFZpm7ViBZL1w=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH7PR10MB6312.namprd10.prod.outlook.com (2603:10b6:510:1b3::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Mon, 3 Feb
 2025 22:27:51 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.8398.025; Mon, 3 Feb 2025
 22:27:51 +0000
Message-ID: <5e3fd711-2875-4eaf-a3c6-2a94f7dea6b2@oracle.com>
Date: Mon, 3 Feb 2025 17:27:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 06/26] vfio/container: preserve DMA mappings
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1738161802-172631-1-git-send-email-steven.sistare@oracle.com>
 <1738161802-172631-7-git-send-email-steven.sistare@oracle.com>
 <d5ec094e-490d-4de4-ac3a-66b1bdae11e2@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <d5ec094e-490d-4de4-ac3a-66b1bdae11e2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR11CA0096.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::37) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH7PR10MB6312:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fe25c47-682d-4eae-cc81-08dd44a1fedb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eHJzOWw2RW9FaENpS3UzcTk5ZXpTL3ZiYzlINHRpTW1oNG9qd0t2V3d5WFZD?=
 =?utf-8?B?cUpFdFpKMlRuZUQzcDNmSjF5M1BmT2ZQa0s3dzB5Y2ZMSEhYRGN1L2dBMXNV?=
 =?utf-8?B?cm9zUTdoTGpGTmZQV0hzTHhHNjJRd25DbVZqUk9ham5yajdkMHdkeGVib3Rn?=
 =?utf-8?B?S1ZIUSt4YzFBbGdJSmhUVmlxaE1wUHBxTUdZL0d5TkszaHZ6UUNKTXVaQk9n?=
 =?utf-8?B?cC9xbm5DV0x5VVU4TWNCTmFPQkQrdWhGT3pqYkZlOXUyazFzWGU3cXN4TnhM?=
 =?utf-8?B?S3cvcDlqNFRQQis1bzdmV3BmM0xRdW5DdGNqdTMzbDdaWGtDaXhacXNpRlRm?=
 =?utf-8?B?K3dVZ2NGdGtSRHhoSk14aEpPZXdQUStPdVkxdkRLOGJFYll0UzZaUXN2UEph?=
 =?utf-8?B?aEpJYk9ROFM5MXVNVVQ4TXpIYXluOTNFUWtHdTBlc1Q5aEpxeEdZdE9YLzl3?=
 =?utf-8?B?Z2ZqRUlFM2QwZXlxeGt0a3pnMTViLzB5cUh6eU9YTWNud1FmbHg5VUxmRnBr?=
 =?utf-8?B?bkQ3MHpHYW9RNk55aWlleHNYayswbHY4RmxKc0xhRFZTSGtYdnBNWnducTFm?=
 =?utf-8?B?ZWk4d3p6VEVsNjQ1dHBXTCtHSytaaFpteWRabit1bWxYeG9BUlN3UnJ5N2My?=
 =?utf-8?B?MXNQTlVVVGRwSzg3aVk4bldjbDFlNGF6UTR5S1U1V0QrcHJwN0JSa0tidWJZ?=
 =?utf-8?B?WjJhMXdhak9TT3B6Tmh4dEtvWDBCam8yalBDSlZ0dEI1RVU4eS9sWGE1cEhr?=
 =?utf-8?B?cmxBS1VReUcrQTk2M2dPVGlsd0t3UUFPUDFTU2MzdFpha2RXTjI4VTVob3E0?=
 =?utf-8?B?RDlGNG1KVVNSMU9PNUlZNTI5ME9sZ3lQYSs5ZUJ2ODNKRkhqNzR5ZjZiVEll?=
 =?utf-8?B?RXRsN2YyQ0RJdXBvWWpXaFBLalFjL3dRRjZuTjh1UmI4eUwzMVE0S1R6aVYw?=
 =?utf-8?B?dVR0SHdvUTN4cmpHL1ZkMCtyNkl6UTFWNXNvZ3hjYUhodmV0RHdHQ0ZsUXhu?=
 =?utf-8?B?V3Yvb1VtU2crTlhkUzBuM1JtTUtDTE9JSkFaK0ZJN2RqVmxLWFlXcnR1dHhB?=
 =?utf-8?B?RDlmUFdmWTZoVkp5UTFKZzJDSDRiajJkVFBSYVZNeXY4a1JlS0RDL0dpVFVI?=
 =?utf-8?B?bnI5NVJZcWNlanZtWUpNQzlMV3lpM21nUUR5RjdVUFhNaWJrVHEvQlo1b2dC?=
 =?utf-8?B?c2ora0ZvRmtjNis0WXprQmdHQ2ExSzdKNTB5cGVici83TnpueHpaM2tXRkNj?=
 =?utf-8?B?RmJ0U1UwSXVKODNzLzdnRkxRUnVBTVo4YlNtOXdzSXdjcFFNM2tuU3hRMzF6?=
 =?utf-8?B?SGxwUExVZkR4SmN3c1RWSkY0T2tNbDdINDJsLzc2RWZtcVBHV1RMUVZkOXFL?=
 =?utf-8?B?Ynl4QVl2dDdqR08yUWJpNjJ4ZlMvUjVHL0JaSXV6cTlYRndsWjhJRms5MU05?=
 =?utf-8?B?UFRPNmx3M1lLMkRJNUJHK2NxWkRQZENSdVViYUNlSGNtK3RsczJYUDhqUVMr?=
 =?utf-8?B?QUdBMDRsRUdhN2tVT1hDb3ZYZTBPaURvMnArUXJGL01VaWYveWpBODhFNTZG?=
 =?utf-8?B?WEg4Zlp2aTNuYlZ6OTVSSEpyY0xNZXhicnhYSnNzeEo0ekc2YkVFUDhnTUZQ?=
 =?utf-8?B?TU9wMkpyNGZhU0RUdm5hTWUwNS93N1hONndpOUVuR2xnai9FMWcyOUQ2OGxs?=
 =?utf-8?B?V2NwWnUwTUMrb1pjQjhBSmhjbUt0eXpodGJYYzc3L2kxUXRJTVRrTFdGTHR5?=
 =?utf-8?B?ck1OWkFMd3FrUVdZemxjaWVBa0tkWDR3R2w2UG81SDJ1UUVaVDh5d1FGbmV4?=
 =?utf-8?B?WUdtZ0R6MlRST0hkNzNldUEySjBKYlVYQk54dVp6a1FYcjdlT0M4NWVaNGwv?=
 =?utf-8?Q?eYRCQeGuu+G5c?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czNXOGlrMWVrZzBRTytGenR5c3UxaSs0VkZqckFuVW1wYitRY0ZUTExIUWhM?=
 =?utf-8?B?UWZITUpsZVduQVUzUDNseGpVWUtzaTcvYlRsZGhDNjZUVUtKT0pQOUdiTm5R?=
 =?utf-8?B?OFVROGRTd2lta3Z4MmtuV1ZHcTV3UVFLQ0FvbmhlR0ZQWXRXWE5QZ0E2QlQ3?=
 =?utf-8?B?a3pXbzhIbVgrbkQ2M0oxSEc1ZDB2QlJXZXUrbk13TjVoY1YwZlBaam9GTjBm?=
 =?utf-8?B?bWFnQittazA4TWhEMUJjelErcVI3OFRZcWVUTjhnV09JVnc4Q1g3anhqZEdn?=
 =?utf-8?B?SFpnNC9ESklnMWpUV3ovMy9YQjFSSGlsb2lyTkdiUExad0NRTjIxYVZ3OEFO?=
 =?utf-8?B?Y01GVm5icHAvNUlkcFJNY2hqOEpWOTVzTE5CVjVGNHR0ZHpud2dmdGl0aE1N?=
 =?utf-8?B?OGh4aTBwZmx3T0pHWVMyU3BVdTBEVTU5eUtXclpBenczZ3RvZ2ozY2hwMTY2?=
 =?utf-8?B?T3htRlNDaWt6d01hZ2pYQjZ0K2lqZGxCZk9rQVp5cGRhUGZjNzhiRWZjcmU4?=
 =?utf-8?B?KytIQUhaWGlBeUhxY2NnR29xTEFvWWE2WVR3SzRKdTVHWkNiRmRydTUvSlhB?=
 =?utf-8?B?K2FZcTNjM29WclBJajM3TklyR3g1VlIzekNhNjdHMEJFMzYzVTJKZDZPdURI?=
 =?utf-8?B?L2dnamVoM2E2eWZuVzBSTXgzSTRnTlRLWUhBTzdzNFpxRUlPeTRtd0xxQUVu?=
 =?utf-8?B?ZHlKSnhCZDA2YlpFOU52RUhDTmxBNk8xR09EZjBZZkFsKzlUM24xa3ZwYUox?=
 =?utf-8?B?VEpxT2pWWVhjY2krWkttR1g1UlJQT1ZicEZmbEpXVUFMVmZwR3Z3dWMrLzd3?=
 =?utf-8?B?Sy9CZlBsZGExTnVrdldUa05rRHQxazd5ZzU5K1pTVURxUWFZM0RKL2VSNWdy?=
 =?utf-8?B?Q21zM2h1N0NxQ0tPNjlXQkZ4Z3UrSmJHMXBJUE9qOExlQ2RVa0E5ckVEM04v?=
 =?utf-8?B?Qkl2VndBbFprQUtmam1kVktyTkFnenl4RWNlNG5tT0Y1SE9zaXVZWDJ0LzRi?=
 =?utf-8?B?Y2tJdHZyZEtDeHQrT3RUYXJVaWFEUTNEQVlpMjBkVEptRFpUL0lLSzlTdzJi?=
 =?utf-8?B?dENKUzQ0bGtmWGdSOEprdUlZNzN1N25ZekpOTzIxemQ4dWtsRWUvM1FCeU9v?=
 =?utf-8?B?bjVrbW9XTW03TEthSUJ4Tmh5ZFVVZ21Bb2FCTmx4Z2tvNnNjYzNGenowOSth?=
 =?utf-8?B?ak9SS2NEWHNtbUYvc1dKdTUrRHhaZ2R3cCtObitlbHcrWm5DM1UxenBZYnlJ?=
 =?utf-8?B?WWljaG1QNmphbTk0U3QrSmE1aXAzNVl6ZzM2TlBXc0dLQTBpUWwyeWZQSkFM?=
 =?utf-8?B?WlI3QmFrUzRyR1RNYjdmdEVKbTRqRTBiNFkvQnlGTzNFcG1DN2h6M2oyalRE?=
 =?utf-8?B?SDVudERoSk5mUHFiYjg3TmtWRFhUcFI3Uk9hMFRzcXFsQWF1UkkwNDkyckRU?=
 =?utf-8?B?L0ZFaC8rNms0VXFVN2NId2dzSmVHeVV3YnlEVjhyc3ZhVmhpUGxvYVFNbENO?=
 =?utf-8?B?MXA0NFNLWDVQWW9WNFJ0aWsxbkt6TnBzUDhPa29vbmdISG9hVkIrK2ZkWXZH?=
 =?utf-8?B?WUJ6SVJJdFZmY1o4bXdZTWcycldRd3dnM1hHTWs3cDdpSlZJSW9WeE5mQyt6?=
 =?utf-8?B?cDVTT01NWUUvcHN3d3BVS2hYMXF0b0tDZkI1anUxKzdYbHJXK2RiN2hzazRs?=
 =?utf-8?B?OW81SGVqMkZsVHhTZEpWdEhkQmZuVnh2dlB0azRwLzNpRjRCTXlnYW16eFM3?=
 =?utf-8?B?NVBEbGx1Z1ZFaW1LN1k0RG9sMWtyY3I0SjRaUTJKNC91NjQ3bmI3L0FiYitM?=
 =?utf-8?B?Z3o1VjRDdkx1M1NoRW8yMm5SV2VSZ0Y0MUwxL2Rkek5peVY0ZXRBODF5dHNZ?=
 =?utf-8?B?aHhsWXlYZGdxdXZLVmx3N1c2Tk93RDdTbTVOYUJSNmZvUlVBWjU5cDZSYkcx?=
 =?utf-8?B?TTJjbWJIYW9mQnRHb0ZZYytGUFFJQXMrS1ozczRIUUZQQ3k0RHNLd2JPZkd2?=
 =?utf-8?B?dUxBTWNGSGl4c0NlRUVqc0ZMWmkwRGNCZ0daWUdzTm1WaE9CVkJud2FCUFNJ?=
 =?utf-8?B?MW1lYjJCODJ2cHo2YXZxbGJkT3VrU3VjRVNoK1cyQWlOdlcxWlIvUEY0bzh3?=
 =?utf-8?B?Nm5obzQ1c1FkSldWbzlxaXJKRTlMd0xVV3JrWGpDelBOOGpIc2t3eDcxVnhI?=
 =?utf-8?B?aWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YQ2M9afnBjvYekNlTVbYmL46h0fm0cAxJ3hRroEeH8ONe+ADrCKEmgnohCOk1CuOHt0siJW0pFcXToyF31eYFDBQl6LEJ3K7sQ99o8IbUbjJNdCH+zNm3ljqRiHnEzeovaCXyYYmZYlEp3V8GbnJ6pXjv9Soh2L1OtVo0u/XPRbX4rAQbmfMdPedfi+/dHzCTubznNDIkWkgAHdbBcZ+mI5v5TmDm8T17iyQPeYFGPe/769WhtoNcnB9ESS9BXrsZVRw7IAocpfna5fWxu+HseOdIvLzOPL5p90tCwkmonDfRBxlzJu8bgJkAM/qi0GLBbH6uJ/ieJd9bHEUrnwk/1CcKnabbzB3vEfcWmx5niNO8FT23Ry32b3YsKQpxSmrIO1GXtLSKUe4YK8DK3HmBa40c/v6nICPPhSmq9iKv2YGoyzP4ciG4On10AS3oZAdWJSlnE4wWFIT7DLEqf4FsUmEs83aEeAK1Vi/k8P0iIUyKKVvMVYgeMRd6SsgWdxWlU0CY1aldiiC+21nmvUvtX8f+fcyKG6srDo8KikHZqZTgWWTQJ2kHUiqQoMhs6BsvLqDaS8HwJm+hQR4eLlLJ8B1ImAHPx8UuA6VS4QGs/I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe25c47-682d-4eae-cc81-08dd44a1fedb
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 22:27:51.4862 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 37QWZCFgc/I25wopieMMxFYnS4B5qfAnZnzG+DSzQjMSFEet40rXFxoExVEnIFQfYAHWleAqsMu058n4kEHYvpxlD0Dt5HTgELL5/a8aP2A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6312
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_09,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502030163
X-Proofpoint-GUID: BOajz32kZNnAuD2uqxrGC-snXfJav6QK
X-Proofpoint-ORIG-GUID: BOajz32kZNnAuD2uqxrGC-snXfJav6QK
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

On 2/3/2025 1:25 PM, Cédric Le Goater wrote:
> On 1/29/25 15:43, Steve Sistare wrote:
>> Preserve DMA mappings during cpr-transfer.
>>
>> In the container pre_save handler, suspend the use of virtual addresses
>> in DMA mappings with VFIO_DMA_UNMAP_FLAG_VADDR, because guest RAM will
>> be remapped at a different VA after exec.  DMA to already-mapped pages
>> continues.
>>
>> Because the vaddr is temporarily invalid, mediated devices cannot be
>> supported, so add a blocker for them.  This restriction will not apply
>> to iommufd containers when CPR is added for them in a future patch.
>>
>> In new QEMU, do not register the memory listener at device creation time.
>> Register it later, in the container post_load handler, after all vmstate
>> that may affect regions and mapping boundaries has been loaded.  The
>> post_load registration will cause the listener to invoke its callback on
>> each flat section, and the calls will match the mappings remembered by the
>> kernel.  Modify vfio_dma_map (which is called by the listener) to pass the
>> new VA to the kernel using VFIO_DMA_MAP_FLAG_VADDR.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   hw/vfio/container.c           | 44 +++++++++++++++++++++++++++++++++++++++----
>>   hw/vfio/cpr-legacy.c          | 32 +++++++++++++++++++++++++++++++
>>   include/hw/vfio/vfio-common.h |  3 +++
>>   3 files changed, 75 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>> index 81d0ccc..2b5125e 100644
>> --- a/hw/vfio/container.c
>> +++ b/hw/vfio/container.c
>> @@ -32,6 +32,7 @@
>>   #include "trace.h"
>>   #include "qapi/error.h"
>>   #include "migration/cpr.h"
>> +#include "migration/blocker.h"
>>   #include "pci.h"
>>   VFIOGroupList vfio_group_list =
>> @@ -132,6 +133,8 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
>>       int ret;
>>       Error *local_err = NULL;
>> +    assert(!container->reused);
>> +
>>       if (iotlb && vfio_devices_all_dirty_tracking_started(bcontainer)) {
>>           if (!vfio_devices_all_device_dirty_tracking(bcontainer) &&
>>               bcontainer->dirty_pages_supported) {
>> @@ -183,12 +186,24 @@ static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
>>                                                     bcontainer);
>>       struct vfio_iommu_type1_dma_map map = {
>>           .argsz = sizeof(map),
>> -        .flags = VFIO_DMA_MAP_FLAG_READ,
>>           .vaddr = (__u64)(uintptr_t)vaddr,
>>           .iova = iova,
>>           .size = size,
>>       };
>> +    /*
>> +     * Set the new vaddr for any mappings registered during cpr load.
>> +     * Reused is cleared thereafter.
>> +     */
>> +    if (container->reused) {
>> +        map.flags = VFIO_DMA_MAP_FLAG_VADDR;
>> +        if (ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map)) {
>> +            goto fail;
>> +        }
>> +        return 0;
>> +    }
> 
> This is a bit ugly.
> 
> When reaching routine vfio_attach_device(), could we detect that CPR is
> in progress and replace the 'VFIOIOMMUClass *' temporarily with a set of
> CPR specific handlers ?

Good idea, I'll try it.  I wrote this code years ago before the dma
map and unmap functions were defined in an ops vector.

>> +
>> +    map.flags = VFIO_DMA_MAP_FLAG_READ;
>>       if (!readonly) {
>>           map.flags |= VFIO_DMA_MAP_FLAG_WRITE;
>>       }
>> @@ -205,7 +220,11 @@ static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
>>           return 0;
>>       }
>> -    error_report("VFIO_MAP_DMA failed: %s", strerror(errno));
>> +fail:
>> +    error_report("vfio_dma_map %s (iova %lu, size %ld, va %p): %s",
>> +        (container->reused ? "VADDR" : ""), iova, size, vaddr,
>> +        strerror(errno));
>> +
> 
> 
> FYI, I am currently trying to remove this error report.
> 
> 
>>       return -errno;
>>   }
>> @@ -689,8 +708,17 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>>       group->container = container;
>>       QLIST_INSERT_HEAD(&container->group_list, group, container_next);
>> -    bcontainer->listener = vfio_memory_listener;
>> -    memory_listener_register(&bcontainer->listener, bcontainer->space->as);
>> +    /*
>> +     * If reused, register the listener later, after all state that may
>> +     * affect regions and mapping boundaries has been cpr load'ed.  Later,
>> +     * the listener will invoke its callback on each flat section and call
>> +     * vfio_dma_map to supply the new vaddr, and the calls will match the
>> +     * mappings remembered by the kernel.
>> +     */
>> +    if (!reused) {
>> +        bcontainer->listener = vfio_memory_listener;
>> +        memory_listener_register(&bcontainer->listener, bcontainer->space->as);
>> +    }
> 
> oh ! This is an important change. Please move in its own patch.

OK.

>>       if (bcontainer->error) {
>>           error_propagate_prepend(errp, bcontainer->error,
>> @@ -1002,6 +1030,13 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
>>           return false;
>>       }
>> +    if (vbasedev->mdev) {
>> +        error_setg(&vbasedev->cpr_mdev_blocker,
>> +                   "CPR does not support vfio mdev %s", vbasedev->name);
>> +        migrate_add_blocker_modes(&vbasedev->cpr_mdev_blocker, &error_fatal,
>> +                                  MIG_MODE_CPR_TRANSFER, -1);
>> +    }
> 
> same here, the cpr blocker for mdev devices should be in its own patch.

OK.  It was a separate patch in my workspace then I squashed it :)

>>       bcontainer = &group->container->bcontainer;
>>       vbasedev->bcontainer = bcontainer;
>>       QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev, container_next);
>> @@ -1018,6 +1053,7 @@ static void vfio_legacy_detach_device(VFIODevice *vbasedev)
>>       QLIST_REMOVE(vbasedev, container_next);
>>       vbasedev->bcontainer = NULL;
>>       trace_vfio_detach_device(vbasedev->name, group->groupid);
>> +    migrate_del_blocker(&vbasedev->cpr_mdev_blocker);
>>       vfio_put_base_device(vbasedev);
>>       vfio_put_group(group);
>>   }
>> diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
>> index ce6f14e..f3a31d1 100644
>> --- a/hw/vfio/cpr-legacy.c
>> +++ b/hw/vfio/cpr-legacy.c
>> @@ -14,6 +14,21 @@
>>   #include "migration/vmstate.h"
>>   #include "qapi/error.h"
>> +static bool vfio_dma_unmap_vaddr_all(VFIOContainer *container, Error **errp)
>> +{
>> +    struct vfio_iommu_type1_dma_unmap unmap = {
>> +        .argsz = sizeof(unmap),
>> +        .flags = VFIO_DMA_UNMAP_FLAG_VADDR | VFIO_DMA_UNMAP_FLAG_ALL,
>> +        .iova = 0,
>> +        .size = 0,
>> +    };
>> +    if (ioctl(container->fd, VFIO_IOMMU_UNMAP_DMA, &unmap)) {
>> +        error_setg_errno(errp, errno, "vfio_dma_unmap_vaddr_all");
>> +        return false;
>> +    }
>> +    return true;
>> +}
>> +
>>   static bool vfio_cpr_supported(VFIOContainer *container, Error **errp)
>>   {
>>       if (!ioctl(container->fd, VFIO_CHECK_EXTENSION, VFIO_UPDATE_VADDR)) {
>> @@ -29,12 +44,27 @@ static bool vfio_cpr_supported(VFIOContainer *container, Error **errp)
>>       }
>>   }
>> +static int vfio_container_pre_save(void *opaque)
>> +{
>> +    VFIOContainer *container = opaque;
>> +    Error *err = NULL;
>> +
>> +    if (!vfio_dma_unmap_vaddr_all(container, &err)) {
>> +        error_report_err(err);
> 
> We should modify vmstate_save_state_v() to call .pre_save() handlers
> with an Error ** parameter.

Hmm, that changes the signature of every pre_save handler.  That does not
belong in this series, IMO.  It would be a separate RFE for migration.

- Steve

>> +        return -1;
>> +    }
>> +    return 0;
>> +}
>> +
>>   static int vfio_container_post_load(void *opaque, int version_id)
>>   {
>>       VFIOContainer *container = opaque;
>> +    VFIOContainerBase *bcontainer = &container->bcontainer;
>>       VFIOGroup *group;
>>       VFIODevice *vbasedev;
>> +    bcontainer->listener = vfio_memory_listener;
>> +    memory_listener_register(&bcontainer->listener, bcontainer->space->as);
>>       container->reused = false;
>>       QLIST_FOREACH(group, &container->group_list, container_next) {
>> @@ -49,6 +79,8 @@ static const VMStateDescription vfio_container_vmstate = {
>>       .name = "vfio-container",
>>       .version_id = 0,
>>       .minimum_version_id = 0,
>> +    .priority = MIG_PRI_LOW,  /* Must happen after devices and groups */
>> +    .pre_save = vfio_container_pre_save,
>>       .post_load = vfio_container_post_load,
>>       .needed = cpr_needed_for_reuse,
>>       .fields = (VMStateField[]) {
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index a435a90..1e974e0 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -143,6 +143,7 @@ typedef struct VFIODevice {
>>       unsigned int flags;
>>       VFIOMigration *migration;
>>       Error *migration_blocker;
>> +    Error *cpr_mdev_blocker;
>>       OnOffAuto pre_copy_dirty_page_tracking;
>>       OnOffAuto device_dirty_page_tracking;
>>       bool dirty_pages_supported;
>> @@ -310,6 +311,8 @@ int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>>   int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
>>                             uint64_t size, ram_addr_t ram_addr, Error **errp);
>> +void vfio_listener_register(VFIOContainerBase *bcontainer);
>> +
>>   /* Returns 0 on success, or a negative errno. */
>>   bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
>>   void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp);
> 


