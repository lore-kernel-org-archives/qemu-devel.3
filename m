Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A664C54ED1
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 17:48:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIWUr-0001yP-8g; Fri, 23 May 2025 13:47:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uIWUe-0001xh-Rr
 for qemu-devel@nongnu.org; Fri, 23 May 2025 13:47:47 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uIWUb-0007Vg-H0
 for qemu-devel@nongnu.org; Fri, 23 May 2025 13:47:40 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NH8k9i030971;
 Fri, 23 May 2025 17:47:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=sV6+6qP1caJJnHVKKEJhsMf6foHaADffUshLha98gkM=; b=
 D47F2LDTZTaIMlfc1L04ET3Eao+XPIaQnfN4l5q2CrOu2AtgxiIa6wOhxpF1NKry
 xlU4LPEZBrluLF90ZfGQ/1VbPwCKp4GXzUhbt1QMcrmM93tEQq2e9J1tvH7lT0NY
 Xwq9MZxfhsJi8Jms/4CARukE7oaKY/c2Re7t1tmbRxEVsKguN8idOIbiueDqLDhX
 6+kSXKoEOqJT33pgGerjYF4NIOSw65uhO4PJtMf6nAKaGF6w+MBociJbzB3EO+8A
 KvFwEJjQ3/iuEw1m/Sb4gjmzUOcahMXUwmkY4RooenSOvQoI7UQOHb3VdqHayEoY
 UyRIRX6ov/Dga578jgnoGw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46tw5hr2jm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 May 2025 17:47:33 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54NG5jKq001753; Fri, 23 May 2025 17:47:33 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2062.outbound.protection.outlook.com [40.107.101.62])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46rweva0h0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 May 2025 17:47:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AbvdGlIQwS68rvv9OSHcSh/lLoVNWv9lpYW+ygvrBVmST4+VtcCr7s90QTCgv76wZo52iKG2/AmMosjSsZd+o1Ka0Y3yJG6t3ZUOBzvgI3oiimxWq80WwTi0NVhPRpm8C2l4K6F2JkzL1pwDBZyHbLzADe29UA3wyYNlFGiS+WI8/l6yrboAVvVZzyrpnD8d+NKNEztX1sDcOwMDWTEn/nMlu7VwQZCmEvWAK7GrVJFM9mozRs7ymYC8nBXWMr8wim6uhJhncEzGVHjpT0em3QpQpQntll1rZMi8ossKiuJmiOI6tVT4PXCNNoCNoHM6cffjI4MoIiu/5DzCJ96NOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sV6+6qP1caJJnHVKKEJhsMf6foHaADffUshLha98gkM=;
 b=vziPbfUM5CRq8qxa/yKwe+FDxR6p93t4jRT0ttNsu9tApSt9e3FskiHtsBYrQ20HNg2mHoFMkrfzNED1dyUYD1ICLVfhBGqwYxeMqZSUfDGXkeLXJyUkeNFePzpJM0Ow58aAJ0A+aW+Ii0/4Img5MjnqgiFiQCjsfnWEx069kzMWcCu5cASuIJa36R5oFCFSsAHvXZvbWTovxzie5SOs1spEITKmJeszoOqijcKFgAz8kz/MHzJCJffxhPsWJgA3h+dOHl/hWqWSRRqRqqIQoj4LUx17Fil0YmTzpLz1N0uuzcSAWT7C2pP+c158kjvb9iUfzmukGUejNR/QNjnt6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sV6+6qP1caJJnHVKKEJhsMf6foHaADffUshLha98gkM=;
 b=o/Xfp47qzI7Zk7dTbTqg2NWcogQWSR2dgn1UaWZfjyaiviY+8+5p754+gUDsNDqz5sZlBQgBZ/C8vYLbcEHX6jaMGqU4bCAatFMoRLGmWlQ+H1oBoFX6AlAkuxyGx6SWNENXq+eM28UeQpO+dfz7dK5qiKMR4RF3hPyY9XUZo5k=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by BLAPR10MB5172.namprd10.prod.outlook.com (2603:10b6:208:30f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Fri, 23 May
 2025 17:47:30 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8746.031; Fri, 23 May 2025
 17:47:30 +0000
Message-ID: <cb9ab607-0921-41be-ac61-4782562c526c@oracle.com>
Date: Fri, 23 May 2025 13:47:27 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 33/42] vfio/iommufd: define hwpt constructors
From: Steven Sistare <steven.sistare@oracle.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-34-git-send-email-steven.sistare@oracle.com>
 <SJ0PR11MB6744C9ABCAFF7FB3204BA6549293A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <f0a68359-399d-42fd-ae26-45b0324a9c93@oracle.com>
Content-Language: en-US
In-Reply-To: <f0a68359-399d-42fd-ae26-45b0324a9c93@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR12CA0036.namprd12.prod.outlook.com
 (2603:10b6:208:a8::49) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|BLAPR10MB5172:EE_
X-MS-Office365-Filtering-Correlation-Id: c54ab4f2-67e9-4223-78b1-08dd9a21e3a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cjV6NWVzZ2pWaXlEaEVzN1MwYnhia2VmU2RGUXp5dDZxU1RTSTd2SnViOGlY?=
 =?utf-8?B?THFkZFZiaHRsbE5YbW41WEd6aG9KamJYaW9BcnJRWDh6cUdVQmUrL3ozYmxM?=
 =?utf-8?B?OXJ4VkM2ekVJR1VPWUFlUGlVVk9TVGNJajJDNFVsNjdXaU1ZYjF3QjhlZFZx?=
 =?utf-8?B?MHZ2ZDBYNFo0RGtMUWRWWkxablVFdVF4bzVHMG9YdG1jMnl4R2wyR3FPdVIx?=
 =?utf-8?B?cHZwWnJteVZieGsyYmtQZmNSVjVWY1BMT0hQM3NiMmp4bWFpMWh4YXJNeTNT?=
 =?utf-8?B?VlRKK1dIVzV4RGIrNWE3cXFUSDJFdithZ0JCTE16Zk5sNlJvdFJaZ0dGWkVB?=
 =?utf-8?B?dTNKNTl5ZGc0VStXZGFZSDlTdjk0VnUrTFJ1UktKeDdrNWswYXIyYlFUMldG?=
 =?utf-8?B?NGNtZVZuQldKRzl6YjVMb0VQc1VvYkVKVTAxdTNaSkJmaGRJS05uZVBrSkN2?=
 =?utf-8?B?ejJIMXVETlh1WkwvZHZqTXRHWnRFSmlTc1dueVBNcHlyOFNaMzEwUWt0ZjZv?=
 =?utf-8?B?ZWVsVzBDYklYcjVXM0twNlJXT3QvWWZSVFZDSWdaVytPY21GR3VGNVN3b1JN?=
 =?utf-8?B?WXNEK1Y2SVJOdlErN2hSUi9URWFYUkk2bHFBYmR5aHArVjFaT1VJYWF1Y3hh?=
 =?utf-8?B?R1B1cDdaRUR3QTk4Zi9nN2wwVmppS1NlRFFITWJXaDBJU0E3SE52cWM1QkN3?=
 =?utf-8?B?SDdYRnBYMWJTdjNNSEhnNGQ3UGRmd05KK0g1ODMzeUdtaGhubWVqb015aU1F?=
 =?utf-8?B?Znlhb3dxT3ZhMlpWdlVGTDFmMzBzZy93SGwyRFV5M3kyZDBvUC9TVDJqVzZD?=
 =?utf-8?B?d1cvTUdKUUR6dEtHWmZqMTl4REljSlVpTHU1OU9CL3VPV0taRjJtWlZ1cnd4?=
 =?utf-8?B?MEU5bFBBeDRtcFJOVUcxdnBHNFpHeXFXTUpJZ1ozM29FekRUR3JrcXNqOUo2?=
 =?utf-8?B?ZUVqajNpMkF3ekNyTEhwODN5bmtPNS94ekRHMWk5Q09uTzFxZEdTTjZlYjZW?=
 =?utf-8?B?TzBxY1dXVVdpQnE5Y0I4MUtlUmdxYStFZTZEQ0F3WG9NUjkybm8zYjdDdjRF?=
 =?utf-8?B?MHAyNVEwUTR5R0kyTm0wSHNWN1dtR29ZRGxCS3JnQ0JCaXlxNEV5ZVpVNklq?=
 =?utf-8?B?QUJrUXNPUDJHTWtmQ0w2eHBLNi9ZaUhJZG5ja3JmYjNKZGpLYXU2MUFRUU1H?=
 =?utf-8?B?NzFrc1JDQVZRaS9CUTRLU2hocVNxOGJqcmhnOHpuVUVnUmxEcUZsY0RZQ2hJ?=
 =?utf-8?B?enpib0Z2NmNPSnNVQ1BvSHlDdTNMaWlTbHVuYlRDbU5VQjlVSlFEVHVLY1ZP?=
 =?utf-8?B?L3I0YkpuSmJTZk9HYVBQOUNmZDIwTk9HWWNvVUszWlFaWTBQaG1KdytPaStr?=
 =?utf-8?B?UWRHUzljMWk3dW9VblprVmlKVkM1bmZsTEUrSFQycEVYaGtHeXNiWXdaL2FX?=
 =?utf-8?B?Y2NOOUNFRG96V0xla2NEK1FuRHlLaUhKZUtHKy9pVm9pU1hqY296TzZMcy81?=
 =?utf-8?B?dlNyczRzV1U5d0VYdUQ4TU5pQ2t6U0Y0NktqSmszSVF4Nk4yT2tRWlhHZ00z?=
 =?utf-8?B?NWdVWkd3OCs5TmhQcmlEM0FTRjBVVDRBSnUzbkNZeUhHUXpnaGs0MERJTTBE?=
 =?utf-8?B?NkpOczdXaHNmNzJYYm1uNXJaeUMvQXV3RTdSNko5d05YWVdTcUNwUDc0TGhz?=
 =?utf-8?B?Zmlwdkdoc3RXRVhLTHQ1VVBtSDRFZkdOTnVnVVE5K1plUk9UQzdjTGJYSTBO?=
 =?utf-8?B?SXRGcGdDZUs1elh4bEUwelNTcW9XSzg5Y0VpQ2R3d1RLNXdxNnkwR09HNGFW?=
 =?utf-8?B?eWRPRHpxTnh4a0ZMcUV4UHRLbTFsRHZZLzlKcWJlUis4QmNKc0V3ckp0ZG5X?=
 =?utf-8?B?WDlNZmhJdXVacGpKcHROWm5DeUxCcjdGNCsxSzRrWFRlNVhOem5CVW5WL3lp?=
 =?utf-8?Q?u1KLdtIsnMg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFE5RWNPWUtHbWlPeUlFdjZieHFoQWFTTEViR2NQZmxHYkVIYlk3NXRCWXIw?=
 =?utf-8?B?TFRaeldPZE4zK1M5K0NSV0toRlBxNUtrc3FQMTg1MnJTQlJtUDBCT3JDdWI0?=
 =?utf-8?B?SlhIK01xUi9ZTGlxT2p1cjhLa2VhNzUyYk1Wc0pRdk03SUVxU0VIVFRwZFBu?=
 =?utf-8?B?RVRmamJxU0pnVnIxN3JwSmo0czE3TVg0WmFLN0xnc1BuWXZ1L01od0IzSWhT?=
 =?utf-8?B?NGV1em1SS2JRVkZQVUNFeHNDKzVlczRQSGNFSXBOY21SZG1vTytJNWdic0Y4?=
 =?utf-8?B?ZWY0N0c2M05nd2xuWkR2TXRDellVQkdMVUR3TVh6bUgvM2ErS2s0MC8ycld2?=
 =?utf-8?B?MUtjdld3YUlzNjZVVjB5amlMUWNyaXd3NmJrZjNMQXlaRVpFNEVYY1RERndC?=
 =?utf-8?B?RGJCeFFlZk5uVDloTU9CdVVMNjZFdWZlSXBCcUJsTzcwQ21nMGpBZGo3bVZF?=
 =?utf-8?B?Y0dTSS9FeTVoeVFCN3dYQzFYWndKakNBdFZIVUdLOXZSeGVnVzhpK3hlRXN6?=
 =?utf-8?B?dy9kR2tBQU4xa3pIRGRvYm9wMFU2SjlRdDZGS2dPK3N5SUl1QW4vUDBHTWtw?=
 =?utf-8?B?eUFXU05WL2FwTmVFTy90VVYvQXp4R0EvQmtpOUM3ZUI2U3NKdzVSZU5rRlZp?=
 =?utf-8?B?SllMYitvcmtyQldUQlJ2VHBBOUdhZ0trSEJaSHM3MTYzYmduNHBmZktyYW5P?=
 =?utf-8?B?aXJoNjRwTmZycGZRWlJRd3M0K2EwYjJya09pWklOVGZpL2hBZ1gyZzQ5Yys3?=
 =?utf-8?B?emJJN2txRTFMZWliMU1BYnBMODBrNmsrajd3aDhzNXgyR3g1Z1VKWCsySGlI?=
 =?utf-8?B?eCtJVytmaTB3dDRNTEtacmJ4ZFludE1qNGw0bEdLN3lUbHpiN0xGanpjSUFV?=
 =?utf-8?B?YTVZL2pkSVBjNURKeUQ0OW1zcE52RmV0ZmQ2MUg1VTd5N2s1ZzN0NVR6K1o3?=
 =?utf-8?B?aU0ySTVmcG4vTjBnRWFBcnZIZHh3MytJM3BOZkR1bmRBNnIrZDdjVnhIdUhp?=
 =?utf-8?B?dHJlZDhwVWxDS0ZqUXJyekJHcHJKY01RK29TMkw1SUR3cGtMd042QjZvanBr?=
 =?utf-8?B?L25sOTE5QmhWbi80V1VPRk9wZXNHNXhtZUdhVW1WRlJiNFhnUXZiUjcydW5Z?=
 =?utf-8?B?WjBMZTY0SEZUeFE5RXlrT2hUeFBTWDlrSFRFaURYeUp3WTk3OTlqN2U0Z1hQ?=
 =?utf-8?B?U3JHckRhMVhUU0xzeFpsZUJhV3g3UHpPNi9Ca3lTMElrT3dSQ0toWmhWekFB?=
 =?utf-8?B?WWdpVXdseldBTGRMVTdNakd4Mk9ZQXpUcHlHNXpvNWNadTZqK0E5dVpTb3Ri?=
 =?utf-8?B?Nzg5WDQzRHd6OXVrYi91N0ZYRkhLRlBtRCthNFBhWTd2WHpML0szMEpDMU9z?=
 =?utf-8?B?cStEL0lWZTJDT2RYUzhON2hvU1FaN0Z4blRrcUFjTSt1ZUNTTDB4NVlSQTFB?=
 =?utf-8?B?bXBueXlacm5VV2VpbFVrbGNMKzYyc3NHcVlOYmRDU1ozOG5EM3crZHN2bW9S?=
 =?utf-8?B?RUJ3QjBINTFDdmUxaVd3THNhK3cyVVZBc1lPdmhlTkh5QUU3SXRTdm9odFhy?=
 =?utf-8?B?U1kwVFRpZUw3VnE3SUM1T011Z2gyeEVYY21tbVVNQ3ZzNFgxVFRZNXZib0dC?=
 =?utf-8?B?TVBrRFVKaEJoUWNoVDVGdmtiSURsQTN6UGZYK0d5Mll1c2hrcWZGcGcwN2Ny?=
 =?utf-8?B?WHA0V1RDN1orbzFFQUpsQ0NrUmVFeHUyb05zOUc3WHdQMS9YQzBEZE9mb0hF?=
 =?utf-8?B?azA1QUdvZk9SbmsrVDlzOVBUeXRFVkJGaE5pZWt0YlE2RURFaUJzaG5RRzhi?=
 =?utf-8?B?MUNpNVkvVlVVa2czdmQvVUhyT1BySW5Gcm01WVJ0UXJoSEt5eGE0Z1M2cTA0?=
 =?utf-8?B?QXp2WmpFVVZsMHl0QlRWV3BWaWhjMTlYdmhUM3doRVI3Sm5EZlczWGE3WXVB?=
 =?utf-8?B?Y0Y1OHg2Q2xvS1RnQWdZeGNJUDZRbWR5RERDTFFtYk1LU3hUdjV0MzhPWXQ5?=
 =?utf-8?B?b2o1bHV6NERtTFFTeUUwY0VGWWs5Ylp5andQQzZUT0hYdlljVnZzWEhZbzlv?=
 =?utf-8?B?cm1YZ2YzWUZFZ2RmaThpaHRMUEc2RzV2TGxiYmxMTGUyUDFhYkJEc1BmbU1j?=
 =?utf-8?B?MGk5dEhjeG5zRGU2YktXTTRTVGJLU2xLYlVzZ1BZMWNRWVo0MDduRHlYak9X?=
 =?utf-8?B?S3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fjysZ4A10y+KyIYDK1v0vz4grmuKLu6+HT6+PqICRhNEVfLdXetD3JSM8CvBXhkkKZDt9EU3D6FdFu5tqpiQweCUK6ofd4fNsxXALa6PH761Y8lpeg4thrV/3p5GlO/KM4TIvLxOjC3hsQZQI8uN/5yLto3pY0Y0nnO5hp8ObHKtp9J15k/XMK6UaqELq8Zk3oujY8nWOhBOqKvnVe2ngQE3ERLMRErIbF+UaoIz7aED7j/7qP83Ug1e8KpTgHEfmViTPojVlQ5SNZ3jttwDgCTgVLUALHHVgtQ9mlYCds1inPFwjhW6l6+7ZxbQwOqk/d5fzgihVEASOc2+0bmVaCZ2rY8af+DrNbwKjPHccdzeCoWWdiXtsMkZB5d3RL5c9NFwHKGnqGy3m64W2SMyw49DFFguLaKBMaas89rA+xkWoDRj1gicG0cEmCcTo1T0CjLdMbJLu/Pwu0GoKa1Q//O/rCJV7kPlF7Lt5d08y/GpBl61U1XNJu0nLuOIiwJWXbSuGXgt5sdTJM31hVXyaR2MElbvVAM3T43P7k2+DhP7zeeM+iFuwDyMF82aLn7y0wzALCb9CrJrXB4DP13YBWcj5A5l/pSwyKWiBMBxXGc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c54ab4f2-67e9-4223-78b1-08dd9a21e3a8
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 17:47:30.2988 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UjRge5SmAByNcg5NU1T16nhFziHecTGhvOipsbD9eWtSi3xHs2ctakAlQTnsBhsNxrmRsbUmsHELn4CXq5UJ/75ugaWtJ3Scwwtyi62cJb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5172
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_06,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999
 spamscore=0 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505230161
X-Proofpoint-GUID: ESP6S9jm1j963RVc8o0X7-aXTtFFVfYK
X-Proofpoint-ORIG-GUID: ESP6S9jm1j963RVc8o0X7-aXTtFFVfYK
X-Authority-Analysis: v=2.4 cv=FaU3xI+6 c=1 sm=1 tr=0 ts=6830b4b5 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=JZYn2fOa4Ve4NGXM7ZkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDE2MSBTYWx0ZWRfX0fEVkcqq7K/W
 l8usK3kqKQbRIcKKlF3MvDz1/0VjFBdW+ZBIfOZ1tFH3X3ZKOlodwj9Aw1v8OTd492Zr0SKm5hj
 yBD8//EJdmR/UkhBi/+QuBii6vUvc4rOfKp2cG6Rg9ves5TNhxRu/BXsDvvRJMX+RvFfOTMTJJ5
 mYksaA1wVT5ssyf2w7LKjbpHvymkwvVc+7QL4VaJP0SIukUsrMiKrEzsN5w1MH2qztspD6Kha81
 sP7/JYSzyrO+/DYjCl74mGCIv3MXKEJRSHNkjqxGrIrjkXsZKrtb6QwX2JW9zoGAbZK6I4wlM2I
 KYpadY0NuIgrv1ArYNp6To14pc4etq/OvqfH/5IikDevwc1qcDt7Pdk7UrYgefd6k+Kqro2NLLL
 EZU4rty7jMrUOww+7lmoDy84f6H1L/yDyaHS1+bKeKNuE7qziAOcKxlvnGKzYcYPrHzDcP13
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/19/2025 11:55 AM, Steven Sistare wrote:
> On 5/16/2025 4:55 AM, Duan, Zhenzhong wrote:
>>> -----Original Message-----
>>> From: Steve Sistare <steven.sistare@oracle.com>
>>> Subject: [PATCH V3 33/42] vfio/iommufd: define hwpt constructors
>>>
>>> Extract hwpt creation code from iommufd_cdev_autodomains_get into the
>>> helpers iommufd_cdev_use_hwpt and iommufd_cdev_make_hwpt.  These will
>>> be used by CPR in a subsequent patch.
>>>
>>> Call vfio_device_hiod_create_and_realize earlier so iommufd_cdev_make_hwpt
>>> can use vbasedev->hiod hw_caps, avoiding an extra call to
>>> iommufd_backend_get_device_info
>>
>> We had made consensus to realize hiod after attachment,
>> it's not a hot path so an extra call is acceptable per Cedric.
> 
> I'll rework it per the consensus, but I suspect the result will be less pretty --
> code duplication, or more conditionals.

I withdraw this patch.  I will instead save hwpt_id in cpr state, and the existing
hwpt functions, called in the existing order, will use it.

- Steve

>>> No functional change.
>>>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>> ---
>>> hw/vfio/iommufd.c | 116 ++++++++++++++++++++++++++++++----------------------
>>> -- 
>>> 1 file changed, 65 insertions(+), 51 deletions(-)
>>>
>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>> index f645a62..8661947 100644
>>> --- a/hw/vfio/iommufd.c
>>> +++ b/hw/vfio/iommufd.c
>>> @@ -310,16 +310,70 @@ static bool
>>> iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, Error **errp)
>>>      return true;
>>> }
>>>
>>> +static void iommufd_cdev_use_hwpt(VFIODevice *vbasedev, VFIOIOASHwpt
>>> *hwpt)
>>> +{
>>> +    vbasedev->hwpt = hwpt;
>>> +    vbasedev->iommu_dirty_tracking = iommufd_hwpt_dirty_tracking(hwpt);
>>> +    QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>>> +}
>>> +
>>> +/*
>>> + * iommufd_cdev_make_hwpt: If @alloc_id, allocate a hwpt_id, else use
>>> @hwpt_id.
>>> + * Create and add a hwpt struct to the container's list and to the device.
>>> + * Always succeeds if !@alloc_id.
>>> + */
>>> +static bool iommufd_cdev_make_hwpt(VFIODevice *vbasedev,
>>> +                                   VFIOIOMMUFDContainer *container,
>>> +                                   uint32_t hwpt_id, bool alloc_id,
>>> +                                   Error **errp)
>>> +{
>>> +    VFIOIOASHwpt *hwpt;
>>> +    uint32_t flags = 0;
>>> +
>>> +    /*
>>> +     * This is quite early and VFIO Migration state isn't yet fully
>>> +     * initialized, thus rely only on IOMMU hardware capabilities as to
>>> +     * whether IOMMU dirty tracking is going to be requested. Later
>>> +     * vfio_migration_realize() may decide to use VF dirty tracking
>>> +     * instead.
>>> +     */
>>> +    g_assert(vbasedev->hiod);
>>> +    if (vbasedev->hiod->caps.hw_caps & IOMMU_HW_CAP_DIRTY_TRACKING) {
>>> +        flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>>> +    }
>>> +
>>> +    if (alloc_id) {
>>> +        if (!iommufd_backend_alloc_hwpt(vbasedev->iommufd, vbasedev->devid,
>>> +                                        container->ioas_id, flags,
>>> +                                        IOMMU_HWPT_DATA_NONE, 0, NULL,
>>> +                                        &hwpt_id, errp)) {
>>> +            return false;
>>> +        }
>>> +
>>> +        if (iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt_id, errp)) {
>>> +            iommufd_backend_free_id(container->be, hwpt_id);
>>> +            return false;
>>> +        }
>>> +    }
>>> +
>>> +    hwpt = g_malloc0(sizeof(*hwpt));
>>> +    hwpt->hwpt_id = hwpt_id;
>>> +    hwpt->hwpt_flags = flags;
>>> +    QLIST_INIT(&hwpt->device_list);
>>> +
>>> +    QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
>>> +    container->bcontainer.dirty_pages_supported |=
>>> +                                vbasedev->iommu_dirty_tracking;
>>> +    iommufd_cdev_use_hwpt(vbasedev, hwpt);
>>> +    return true;
>>> +}
>>> +
>>> static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>>                                           VFIOIOMMUFDContainer *container,
>>>                                           Error **errp)
>>> {
>>>      ERRP_GUARD();
>>> -    IOMMUFDBackend *iommufd = vbasedev->iommufd;
>>> -    uint32_t type, flags = 0;
>>> -    uint64_t hw_caps;
>>>      VFIOIOASHwpt *hwpt;
>>> -    uint32_t hwpt_id;
>>>      int ret;
>>>
>>>      /* Try to find a domain */
>>> @@ -340,54 +394,14 @@ static bool
>>> iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>>
>>>              return false;
>>>          } else {
>>> -            vbasedev->hwpt = hwpt;
>>> -            QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>>> -            vbasedev->iommu_dirty_tracking = iommufd_hwpt_dirty_tracking(hwpt);
>>> +            iommufd_cdev_use_hwpt(vbasedev, hwpt);
>>>              return true;
>>>          }
>>>      }
>>> -
>>> -    /*
>>> -     * This is quite early and VFIO Migration state isn't yet fully
>>> -     * initialized, thus rely only on IOMMU hardware capabilities as to
>>> -     * whether IOMMU dirty tracking is going to be requested. Later
>>> -     * vfio_migration_realize() may decide to use VF dirty tracking
>>> -     * instead.
>>> -     */
>>> -    if (!iommufd_backend_get_device_info(vbasedev->iommufd, vbasedev->devid,
>>> -                                         &type, NULL, 0, &hw_caps, errp)) {
>>> -        return false;
>>> -    }
>>> -
>>> -    if (hw_caps & IOMMU_HW_CAP_DIRTY_TRACKING) {
>>> -        flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>>> -    }
>>> -
>>> -    if (!iommufd_backend_alloc_hwpt(iommufd, vbasedev->devid,
>>> -                                    container->ioas_id, flags,
>>> -                                    IOMMU_HWPT_DATA_NONE, 0, NULL,
>>> -                                    &hwpt_id, errp)) {
>>> -        return false;
>>> -    }
>>> -
>>> -    hwpt = g_malloc0(sizeof(*hwpt));
>>> -    hwpt->hwpt_id = hwpt_id;
>>> -    hwpt->hwpt_flags = flags;
>>> -    QLIST_INIT(&hwpt->device_list);
>>> -
>>> -    ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, errp);
>>> -    if (ret) {
>>> -        iommufd_backend_free_id(container->be, hwpt->hwpt_id);
>>> -        g_free(hwpt);
>>> +    if (!iommufd_cdev_make_hwpt(vbasedev, container, 0, true, errp)) {
>>>          return false;
>>>      }
>>>
>>> -    vbasedev->hwpt = hwpt;
>>> -    vbasedev->iommu_dirty_tracking = iommufd_hwpt_dirty_tracking(hwpt);
>>> -    QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>>> -    QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
>>> -    container->bcontainer.dirty_pages_supported |=
>>> -                                vbasedev->iommu_dirty_tracking;
>>>      if (container->bcontainer.dirty_pages_supported &&
>>>          !vbasedev->iommu_dirty_tracking) {
>>>          warn_report("IOMMU instance for device %s doesn't support dirty tracking",
>>> @@ -530,6 +544,11 @@ static bool iommufd_cdev_attach(const char *name,
>>> VFIODevice *vbasedev,
>>>
>>>      space = vfio_address_space_get(as);
>>>
>>> +    if (!vfio_device_hiod_create_and_realize(vbasedev,
>>> +            TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO, errp)) {
>>> +        goto err_alloc_ioas;
>>> +    }
>>> +
>>>      /* try to attach to an existing container in this space */
>>>      QLIST_FOREACH(bcontainer, &space->containers, next) {
>>>          container = container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
>>> @@ -604,11 +623,6 @@ found_container:
>>>          goto err_listener_register;
>>>      }
>>>
>>> -    if (!vfio_device_hiod_create_and_realize(vbasedev,
>>> -                     TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO, errp)) {
>>> -        goto err_listener_register;
>>> -    }
>>> -
>>>      /*
>>>       * TODO: examine RAM_BLOCK_DISCARD stuff, should we do group level
>>>       * for discarding incompatibility check as well?
>>> -- 
>>> 1.8.3.1
>>
> 


