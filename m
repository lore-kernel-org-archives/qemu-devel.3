Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A12BC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 20:25:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjmCM-0001Nz-7t; Mon, 11 Mar 2024 16:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rjmCI-0001My-Fu
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 16:24:34 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rjmCF-0004jv-Tb
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 16:24:33 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42BIUMdV022518; Mon, 11 Mar 2024 20:24:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=0kjju7VyvHojuh3hgSNtcARkbusAuytnSyNrAxryT6s=;
 b=e9wudSb8AuU5eL+VYWMKcYm3TqiViZgyPIY+C6ShDAp4s0R3Wj7YvNdblrZ72Np2p3Pm
 MdtxlkD/ABpvDpwT2G2YQw+mivH8Q57JME/ZBm/nzGW8Dfte2rQD8HL/qf0dIw8CUGeS
 FNoprF+zEoqfUajL/Obt8cV581AdgEKX/PGxOA0Da5begNxoW1vQ7qSNDKL3s93CuuhS
 1LmJEMwdb/AztC2DtF4RlS3QGCK5ceCGA6nHFbmLaVOKhq9/UiPW9KQ+60OjuD46CW4f
 jpVtBK2xNJI9/O6PP1qceFhpSmFJX2+rUl2qgjWHCy/OZAxV2ATSkCgyCX/qmCGVdtY2 Pg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrepcv7q9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Mar 2024 20:24:22 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 42BJ5lc5004758; Mon, 11 Mar 2024 20:24:21 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3wre76d7hr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Mar 2024 20:24:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QYlSvO0sbyPetZgXK6GXlSebnyHC6g2xHQPDScNb2GhEcIqy3necggHyr4+6tMWIiUERDGzGV6pGjQYpF1V2Hua2/PzFx+DAr4EzDYWi5dCH4rtc1czobS5zWkU+zZvb6jLQnZBWJIhs5iMWcE8jP32Bl0eFY74rbksBhGJdpdROVo0cjkqtcd9RF9Wd/L3QaTuD9P07oYO3NTYS5fDeHP14lSqNq4qfWYEZ0R4G2VpVcTC5qqC9XKdo7F/iT4cAkEElz/ttzmq/EHs2OdqSWjBnJwQ7IHWHIhHxPuGGeS/7j94CEBlInPg8WoduOIx4tAMjc4vCArvjfFHierFOww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0kjju7VyvHojuh3hgSNtcARkbusAuytnSyNrAxryT6s=;
 b=oYusMqCaFwaB27jba8+r55RHSlUCp5tQI7ymw3aYolkbcc7d0aT4biemD4sgr/MVlVE7bZouaL4QjgkjmhLa7Wx6sMjGiZIaJi+iRPxDOSCEW7UxwJ1h9XDtTCpri/L6FGgrCUGYj95QSXXU9Fkgf2/yJzJ2Nofe2SlUhSMbgDMkPSBn+Sde6hn79U9HI15nxzi6g1sqFCU9tsl3Mxb4LM3Ci6sq85tS9ck2MHJMkgZFunSjNVFcEtYUtazsS9iW9CYWt1R3Nax9U5WRGOrWwX4ULEgJb+N5Oxk9L3IPF9SYh1Bzf6oEow4Bdoo2nDbCn36GEChnK5p/mOXpceVd1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0kjju7VyvHojuh3hgSNtcARkbusAuytnSyNrAxryT6s=;
 b=lza4gDX+OhOb+SxHO/aLcbWfOiYbvAhhsvm6zSGuBaNIYK9cjnCoJa8f8p4FsYb3DQTUFBwJMJsE+16JA6c8Wi5KU677AXBoWFS/ikYEKrrh21a/cImbGr+e0qp9QAr/XbgtoIlfMZLZjlZfi7cN8e3CuxB7o6hdwwxcWKBqmPs=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by MN2PR10MB4237.namprd10.prod.outlook.com (2603:10b6:208:1dc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Mon, 11 Mar
 2024 20:24:19 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::6130:f924:897d:7da]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::6130:f924:897d:7da%7]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 20:24:19 +0000
Message-ID: <fb3d25ca-4a46-4a59-b172-cade9dbcbe55@oracle.com>
Date: Mon, 11 Mar 2024 16:24:14 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 00/11] privatize migration.h
From: Steven Sistare <steven.sistare@oracle.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, Zhang Chen
 <chen.zhang@intel.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Jason Wang <jasowang@redhat.com>, Hyman Huang <yong.huang@smartx.com>,
 Song Gao <gaosong@loongson.cn>, Alistair Francis <alistair.francis@wdc.com>
References: <1710179338-294359-1-git-send-email-steven.sistare@oracle.com>
 <Ze9b7JULHLUoYGgV@x1n> <93cbe4f1-6451-4dc3-8150-f62a99f83f4a@oracle.com>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <93cbe4f1-6451-4dc3-8150-f62a99f83f4a@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0042.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::17) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|MN2PR10MB4237:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b6dffb7-adec-4544-ff2c-08dc42093ae5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H9xLM5/RkqccebQN4K2ycB4bAWjEvzrx9fe0CT6OJsO/d2BMhA77g7/Wq/5SHvQMDDDdailn++4qn3vp+v0XbwVqJc/8/BaGrNE1LeQm+kDBA2wZ4kKiKE1RCl+bqbdy0AqH4iIBCHWiBFcGHGkDYPXVfPtXDnpXjNeK1lVoYbY6SW2ryNrJAXoJVTwH0HxMK/0KRvAtPKDEajwWhE7VcgXn+eeGyP8x+HAmwEPOcoc2riGNV0aWhua1FhKMNejMitlh3iMvTU07Gj2ohEL+dFeFttE4q/cmUr7FE92hl180Q8sN1TtS0P3L6gsISV9+/TQm0jAOe9sxUNHtFEI2lNNByOyw2qBinZ8U0m3HalTvY+tQKFAy/AdQlG4ALc1FyELX2UJItoE1qjnD/Q+qN5mQiHqjv5cPruZyEXpOEQh2aqZqTKj7eMOmeQQW6pcRndZZQneaI5uuoBL1j/LUWuzrawWAmTmYAE4eAYXrAYb85H1/8Mfn2ula2bMZvdM0DZxUu/LxkEUmI5QwVUoJQyXnljOk7Q1mieHoK/7BVkjNsbuONQRErFxx/66lCL7Hywor2MFLqX9SBGXoCXqlKOb0BOqCWC8+mx680zu4Bwo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(7416005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVYyRHJzNHgyM2ZMM2tCRTAycVV5Sm55bTZscHhYS2JRd2xYeGlEdFpBcGto?=
 =?utf-8?B?bVBpT2c1ZUp5aXJVeXJHa0FzdFhGMzdiVEc3ZG9RVGFZdFgxQjFpaVl5b3E0?=
 =?utf-8?B?MEZpczRDaCszRk1PcmpHVC9YUnEwb2Z2S3pGUW9DUlUvS0lFMFFVeEExTWNH?=
 =?utf-8?B?QnpIemROZGdFdHdsL0FsSHlWb282MEdDTXFQLys2RnBaczRiRU1sYk9OMkJC?=
 =?utf-8?B?SlozOU1uR0puM3NNZUgxWkYrMUJDSFBLUkh4cmdRd2l2U241c01qdkxPakVJ?=
 =?utf-8?B?eVBZZGhFb3h2ZEhjcXlrVGIrSDIzdllCTUV5N3ZwWWZJZVNZYmZZOVdnZU0w?=
 =?utf-8?B?aG5JQUxqdms0YklBRCtEbG9CSmV1M1V3UllIOCtjdVNvY3M1UHhTc1BrTGFU?=
 =?utf-8?B?TXcxNUJIR0ZWa2VJM3FHMHJVTmRaUmhkWnhlZDc0ZTU1VU9xWm9WWWxXaFox?=
 =?utf-8?B?UEVsSGhjSGdTUGJrdmpHV04yTnNEeVNEVmNJK1d5UzVscG45Y0d5U2VOd0RO?=
 =?utf-8?B?T0dTSFJBQW02akROYlhDTlRmRWZvb0tsNGpqNWRSZ0JDL0MzeUtxbkVqc0tU?=
 =?utf-8?B?eHR6endYaWF0dGVjMVhuYXk0bHl0UENWTDFTQ1RpRGRyRHMxWGdSSUtwWXhP?=
 =?utf-8?B?QS9UUTFyZDd5b0NHbFJUYi8yaDcyOURma3c5NUZmN296T3hxbmRFZUdvQ0Vk?=
 =?utf-8?B?WWhlN2RubWRhbXRtUWQyRit1UGR6Sy80L0p4ZUdvTTFrNWRNdVlnMUdDWDNW?=
 =?utf-8?B?WHVVWmc1Vm9nSmszUkkwVkJaSFRpOHhBZGxSazNpRkRqUXc1Zm9oOTVzSWJm?=
 =?utf-8?B?TFc3YzJxZlZJeFZ0eTZPMGgzcFZWc25FNVZBcGVIaFNwZjlDT1hKSGZuSkd2?=
 =?utf-8?B?R1dMT3dBazlDbWpuVXhXNU9BRVBDZHUzSzI5K0tyM3hJZWt3bkQvcHBYaEV3?=
 =?utf-8?B?Z0Vka1AzMStMYW11dlFnT3Vnby9iVDBUaWQwdGtTenlMckU5T2JrL3lzTEZs?=
 =?utf-8?B?SEV6VjhmK3NkcFRDKzZrc1cyTkpNNnQyRzljNmFucTFuYU1UYnpzT0VvMDFH?=
 =?utf-8?B?WGFGYktXaGF6QTQxcnUwSmlxbE50MzE4Y1VKYktDaXNsM0wwcW5CMGZlWjFx?=
 =?utf-8?B?bXUrMHhRZjFWRkpheXc3Q0R2ZEo0SzlxVDVyTC90bnNuUXY4Tmdndm1ieHJQ?=
 =?utf-8?B?NGNjbHJXeDMvbEE5M0Z5RDkrODY0OTlkOFZlRzV1eUs5aW1RL2YreGd6S0Yw?=
 =?utf-8?B?bEJidTZheHFVcVFrSkIyTW9zMUJWL1EyVG5yMlpTYUYyTkJ0S3h4T0lldmJZ?=
 =?utf-8?B?b0kxbkswVFJLRlc0c2hlYmdHNXlHZ0xQeEp5WEhjelN3THBpZjRGVlhDNG93?=
 =?utf-8?B?VlBZMzJMQ1FjSEhDcy9sVGx1c0RNY3lGdkpETzREd0hZa3BZaEh0dURjV3NV?=
 =?utf-8?B?c3ljdXc0dHZFMkJUemViTTd2T2Z2TGhUSnhNYk5WNm1FN2YvZlE2c0svTUIx?=
 =?utf-8?B?Zys3bWZ0MUdZV2g2Y3QyQU1xRlY0M21tY0lrSnhuQmRyUVVkdnplUHV3ZDlG?=
 =?utf-8?B?MEdyaUxyRStJbGxRZnJJU2hJRTJhZjZvdnRKSXkzZytqSm03K3ZHN3NtS2M4?=
 =?utf-8?B?aGdzYkc4d3hERU1EMUQ4NURMajlHcENURmF5K1VuR3dPNElrZ2ZVVXNaaGZJ?=
 =?utf-8?B?REJaQzRpM05XMlY0aVJIaGRUWUFROHg3dlJBc3hxUGVHWGw5RytFWGZvTXFI?=
 =?utf-8?B?c01tV0NVazVZR2ZqTVB6TUdjc09wOVNHRURsZU82b1dnc3U0OGFjNXNMOVg1?=
 =?utf-8?B?bktldDJrNUJyb1lLR3RqQTBOOXFXZlRhVVVoQmU5MENjaDZJcXlYVytYTGFR?=
 =?utf-8?B?R2JaREJlNVZuWTdHUHh1dEhlSzNHN1NwbEpWN1locE5lUkZ3aUs0YUVVbWdl?=
 =?utf-8?B?VUJqUHFlUElsSDJRQkM4NUw2WHhvcklJVjRKcWVnako0NHhpWTd2ckJSMWFZ?=
 =?utf-8?B?bDMxRXpEY3l4dmRjS0hva0pPV3pDSlpVcFFhckllandyQ0tNUWRBdVhPNkJ1?=
 =?utf-8?B?WUZ0dXo4dkZnMmcraU5iSzc5WHJoOU53MUFsK0R6VW93c1lxblBOT2hiSUFC?=
 =?utf-8?B?NGRJK0xOczY0YVhQY3M1NDJjZWhkNDBFYnFkRXhGYmlpT25NQ3Y0TnVRZ2pF?=
 =?utf-8?B?OEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TLsyhB+Ey9DYCV98zkDBCkAdL1Hs96r/5vh+ueKkHOhj7V6G//lckUPuq3Hu/F9UenAUtoFW+FLmLjT8Pj1V9H+vC+npAf5H2auAQ4iIKpBqhAlXcjjspkQmIOKLMkN6ypNOAjnQD8nyVIAzkwQk4gmxlpJKO6USFwStSozFfLbq9BAEdW0QBLuNTvSnahLsrCb0alGvwMluotM2Z8EVllEkFA2bGyK2dlgcCPVmDd0gMFyXPLMI8VQQhHkRHXrI4Wn5YE8LIuXBe4NBP3Szi8GnaRhhIl55VWdlQWD0SbSEpKHfsJbACdsubqfriYLboTQscSEwWOnKPD7RctijIbq49qW9fdectH7HzgGHgVr9GLUL+xAsN7LOohiE/vysc+IQQZa8or8dqniIbA7gxHizbZVS6y0yOwXbQwUPN6DO1WC7UgawBLLokmLMBotx/YUS2o4N4p2gbDTw2uwTwq7PH7iNtPvp7Z6GOg1Rf7juTbgTWgdTJDtr2206Qri3Vxzp7OmQtHHz9cEJjlnNMacLFn0Yjk6nfNAxtQyzi5r3nJKBAfdIgB1+lRSFpbJQdcgV4ON77dt7zuhf8pVLoV0Jw9FM+Ydxk5XgWgrrqk4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b6dffb7-adec-4544-ff2c-08dc42093ae5
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 20:24:19.1457 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lPDkK+kMcVQKjhMFgzSsPVjzT8MbMJLw/uVoK9xkVLr/cSw23v92jYrDuL+eBacpxT2jSdAbjfe6OpETIbnS5Q+zdWtsHD6h70ZGdGLcNGk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4237
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_11,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0
 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403110156
X-Proofpoint-ORIG-GUID: bzCYhYV7iuXovvSLOzIpnFgY4pOv3QuM
X-Proofpoint-GUID: bzCYhYV7iuXovvSLOzIpnFgY4pOv3QuM
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 3/11/2024 3:45 PM, Steven Sistare wrote:
> On 3/11/2024 3:30 PM, Peter Xu wrote:
>> Steve,
>>
>> On Mon, Mar 11, 2024 at 10:48:47AM -0700, Steve Sistare wrote:
>>> Changes in V2:
>>>    * rebase to migration-next, add RB
>>
>> Not apply even to master branch.  Note that there're >=1 PULLs sent and
>> merged since my last reply..  Perhaps you rebased to the "old" next?
> 
> I pulled from branch migration-next in https://gitlab.com/peterx/qemu a 
> few hours ago, but I must have screwed up somewhere.  I'll figure it out
> and post a V4.

My pull was a fiew hours old, but my patches still apply cleanly to the
most recent tip:
   a1bb5dd169f4 ("migration: Fix format in error message")

I can sent that as V3, but ...
Note that you must apply "migration: export fewer options" before
"privatize migration.h".  If that does not help, I will send V3.

- Steve

