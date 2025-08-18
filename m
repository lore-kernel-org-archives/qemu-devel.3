Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D93CA0EE4
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 14:47:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uo17q-0007WR-7M; Mon, 18 Aug 2025 10:46:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1uo17n-0007WB-87
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 10:46:15 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1uo17j-00073V-Mz
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 10:46:15 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57IEN5Af010774;
 Mon, 18 Aug 2025 14:46:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=X8AG5y31JugKXRcKMrb3mY7qpV3klJeQ9bGYmj5eMFU=; b=
 TnHtu1S7S6zyGgNHpyGha8iRE5Z5BW0AUWVtvfPdlCb/k31hTqRDfVZLKgLH7m/G
 rQqIOr7rAMLqL+kk0AWgZp1zedHQY64bJ1/J/YsgxkjtXdyUm46fN2sQDjWtdvJz
 RtV2e5ZRt7nlLJH8nT2c5jibgAevaWFPC8yOa80D4ADfZinL/ZVZifRY7+fCFsSW
 C00je3HAJFa9BKpCVSa9GF4f7xQSa3Dmm3iC8uC+q757Q6NwknmVuBsAl94Sk2sS
 FIKFdT4lQUD55NIx1xrkOjMtCeNWrxAW+hlSgW4rShyc5bN131HUMjbb7i9Q5Nbp
 BybDRk9GyWskDjMhh19Smw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48jj1e392v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 Aug 2025 14:46:07 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 57IDLok2030873; Mon, 18 Aug 2025 14:46:06 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 48jge8uxfu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 Aug 2025 14:46:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qGohlGPn7KfYZChjuhOtEq99MlyObpxYYIFhuvxRr3jU5efjt99H2hpDHXQj1snxMtiA8LsszigsFn6zED/Fzm1jWeMMFaXXlbnkLZHgnmumlGv5UK7dzW7Oku89Yzk3108ptSeP54P8BmPd3yiKiYSZXW8IiGz0iq3/p+uc938tXHWFkH1IP+/sh2pAZxwmYujy+1hXS7sl+8uDuynTXvpWAYgt5CxWkRHp0SzcDg/NYaMHQ1K4lTSoDjxvP8/SR7l+vvJKzU0Md8cezi2yslDRnBf5Z2aSHon7yAWcCF+Esejy05g1+SN7KRWu/Iw5MCCNr/lOWsKZD5TZR9GMvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8AG5y31JugKXRcKMrb3mY7qpV3klJeQ9bGYmj5eMFU=;
 b=AHFMWHtdHgT7UbhSYrBnNCEGFPs4UPHCMTiDAQKC1SJzajeml+VFhhRUnNvDsfKJlLGhgvn7w57CloovLf91N0xakWuXz6FbwCDISQFhwMV9NvhBOIJmq5coJDMy7u7hEQ5WoRqMiFRJ2Jx8pkp9csNvGlVkXRpTFOXz+Xdf3vGOKbNAIHUK/bVp3eMlZzk1FPs2O5y9IJC693KjB2mo52GokMCzAZLXhtN00nKta6TMJbEArLHbAv2940lwgjJMF2ToBQJnD7iOJkeWngciiWH8xK7+KGzQUCBIFNmRvZLh9Wcrk7A5NyVtQx4LKT+koKp239hPDFdOkCkRHZhO1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8AG5y31JugKXRcKMrb3mY7qpV3klJeQ9bGYmj5eMFU=;
 b=B5zCSZdDF2Ru5N3flJv/3YoRH9AcS1nvyPfO9nSY9qhA08GU5D8Felije+GaXZpZ5yPxOadM9CaCOgrWquj+tyxgHU3bNj/JaPUbYD+96Y8CWhLGGFz8KfK8NNWWfPtTu1xxPw7CcPxAOWjQaLaNxtgQGotml/nYRWc8PxtsK/4=
Received: from DM6PR10MB4363.namprd10.prod.outlook.com (2603:10b6:5:21e::21)
 by CH3PR10MB8213.namprd10.prod.outlook.com (2603:10b6:610:1f5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 14:46:04 +0000
Received: from DM6PR10MB4363.namprd10.prod.outlook.com
 ([fe80::999b:18e4:cc6a:7cc6]) by DM6PR10MB4363.namprd10.prod.outlook.com
 ([fe80::999b:18e4:cc6a:7cc6%7]) with mapi id 15.20.8989.018; Mon, 18 Aug 2025
 14:46:03 +0000
Message-ID: <c5b97e10-a8bb-4d59-b509-734eab7d5be3@oracle.com>
Date: Mon, 18 Aug 2025 10:46:00 -0400
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
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <CAJaqyWfc3G5NLnxqXvZFxw2aRnVvOcZbLds5LHzcdoLjVGmOsw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH3PEPF0000409F.namprd05.prod.outlook.com
 (2603:10b6:518:1::4f) To DM6PR10MB4363.namprd10.prod.outlook.com
 (2603:10b6:5:21e::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4363:EE_|CH3PR10MB8213:EE_
X-MS-Office365-Filtering-Correlation-Id: aae6658f-501a-4f7c-e292-08ddde65f4c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UnVSWXkrckdSYW9KY0kzanEwUHBnRmtONHRpTndQMnNiTUpLdTFPV0hCdzNM?=
 =?utf-8?B?WGJPVFBqaEtHTmtMQmVXM3NFV1MzNzZMZTRJdVNQclphQVRHWDFzUENla0gy?=
 =?utf-8?B?Vnp1cmFVd2N4Q3Zyemc0TitQQmJSRnBNL0xUVHdjWEhtUVlmYUlDWFNaM1JR?=
 =?utf-8?B?SWpmanREL2ZlUHFmalJIcXgybzdGUmljN1ZRNjVpVUJpSWpRbWlaZXNTNDNz?=
 =?utf-8?B?TWhuSW0rY0k2dllxWW1oQ3VXb2lnbFFWdzl3ZUJQN21hcThWMzdMNzNWenEz?=
 =?utf-8?B?Rmg5MDV4KzNvOUlldjdDbjRLV20vbGtmZnloYU9RTkxpUXRuK0RVeTJBY1Zm?=
 =?utf-8?B?Q1hlam5SZ0FWKzVBSTdibFNGcktuTlIwWkhiSDkwQVBqcEovYUZnV2JxbmVX?=
 =?utf-8?B?VWdqMm9WckNta3l4OTN0REJFbmprK3lxM2o5RzNTWmg2eU5kdko0N2V1ZHZw?=
 =?utf-8?B?eU00MXdhenVWZmd6YVo4UXRnN2dhUWplTUxRS0F0Q1N5QXdSZ1ZINGJ4bXho?=
 =?utf-8?B?RUMrajZYTXkxUWdPc0VvVy9yNC95UnNha0owb3NDa21PS3lXaWZxRzVMb0pQ?=
 =?utf-8?B?S2NCSXk3NnRpdCtJbGxnU3NMcjA1aGlEUWlXb0pUK3NzNXZENTlXaEhWbURB?=
 =?utf-8?B?QXlmbkc2TnJxRGN6TEJKa2NKZnR0bVZwZlJCZ2JnK0t2UUdBcjVFNGxBS2dG?=
 =?utf-8?B?M25tN0d5SzJXUWt6YW5NQnQ3YlBSTXFyazJHbVQ4YlRyNXNvUXl4WUxYL0Np?=
 =?utf-8?B?RitHcFROdTB5d0txMjBkb0JxUktHRE01SEp4QWRzRFZEYmFBbmplSnlucVlt?=
 =?utf-8?B?cEVPSmx1bW1NajhNWHJMcWZtWkgwWlRWYU1zclQ4Vnkxc2Y1aC9TTnNPU0RT?=
 =?utf-8?B?RTdrZVoyYkxzbmVSaWlyVkpnQWxPS1FnNmZSS0diMFRDbGZaSWk0c21QWHJm?=
 =?utf-8?B?em5OV0ZGcE9QS09IdjkxWnB5ZWFsUXE5bDlpZVc1YTA5N3dHbG1hYlhzbkJ4?=
 =?utf-8?B?SWFWclEyU1Y3NGNmbjZwb25VaW5KcW1lMzJvMVlTOVNwTHp3TEx6dzFyM210?=
 =?utf-8?B?WGUrUFZ0dm11VHRaZVlzRHJwT1p4VE10TXI2UXdHMXEvNGI2SjBzV3FGOGQx?=
 =?utf-8?B?c0dIVWJMbTNWWlZGbUpQc1AyVW5wYVlvOVFpRnphL1phWjJnV0lCOW9rclpz?=
 =?utf-8?B?a2VoU0VpSUdJOGt1eENCUzZOeWlSN0c1Z2ViRlpIYVhwNmZYQmFhNFdtUlg5?=
 =?utf-8?B?cjZoZVJGaU1NUW5xcEwvUGpUaHBkZ2tWeHJheE9oSWNFR3E3bVJrZDhxRjBD?=
 =?utf-8?B?TkpBU1ZTTHd1YTRFaXVtTHZSK0c1NER6QTMrUkkwNWNFYzlaQ2ZnV1RsTnhG?=
 =?utf-8?B?ZWl0NEUraXNUNEp6ejFPYVNESlRqbDQvNm9BbjRvdUhmTWNMV3ZtcXFSVFA4?=
 =?utf-8?B?anI3a3d4S0Q0RDMxaWgxUjZHZFlGbjY4bm1kRldzVmhnUlcyLzRyaTF3dyt5?=
 =?utf-8?B?M3Z1N2o0bW1WY3l3ZHczVkRTKzZ3dXdvT21QZFAvSWllOHBFSjU1VkZPcnh2?=
 =?utf-8?B?Y25FQlJUc2QvN3dGbXYyam1naTFvS0ZDQkV3TnNyN3ZDNWpmSjJpQU1OanVz?=
 =?utf-8?B?eEQ1YVlXc2hBQ01qTW1yVGNqNitSTDhFd081SXF6OE52ZThGc1NJSkNXYjhE?=
 =?utf-8?B?WHdqMmdhSGtJUlJQTlNkbnVDVloyMG15Q0VoZmF3bGxsWVNRd1BBR2pnODBB?=
 =?utf-8?B?azcyZ1ZDUmF3VmR1QXE0NUd2UXYwYmdsZ2dMa2Q3WFYwbTUxKytOcUw2T1FX?=
 =?utf-8?B?QTM1UDlXTXFUQzNta244aHhzOGpzRWNFc2QxQ3I1QXp1SmZJTndkSHZTOTZs?=
 =?utf-8?B?YVVCM3ZZb0RKWjJMRVpzVlh6SVN1eGRaUXo1U2s5dy9mUTRJNjJpNXdLUTRS?=
 =?utf-8?Q?Nl7h3OZ322e+LlyHSV+6+Eg0s424sG3q?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR10MB4363.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUJIYVN4YXhTMjNKS1h1YlRxVkltOVNlNnVReXRSZllodm9EWGsxZnJaR29F?=
 =?utf-8?B?ODdmZHJEV2JUMDl2Q2JzZ3hiYWhaTU9Fbkw0bW9WNkZxK290WHhqRk1XdTBv?=
 =?utf-8?B?UDdOQjNEQnZ6YUs3MGhuVFFxUlk3RU5ybGk4N2tLZVk3R2tWVVI2L2QyOUNB?=
 =?utf-8?B?cGZaeU92ZTRjMmo2MkdOYjFWRzhZMTlKQ3hMWENoTzVqdUNpbVRLN2ZpNGtZ?=
 =?utf-8?B?dHJQU2J3T0x2dWY5SngvWFRKYUZ3K2g4SjM0NG95OHF2a2Q4SjdGZXBxd1JO?=
 =?utf-8?B?WVI4TEIyTVgwaFBwUmViWDBiNnU2WVViU3lnQ1ZvdkN5RTBMVGRrejJzbnRk?=
 =?utf-8?B?c1orekh5UytMYVdvc2VRODQrMVZNOGd3ajJXZzZ6RFg3OS9sZmNqd2hudG40?=
 =?utf-8?B?c2hhSmpaZUtta2d1QVBkcThheXJYZDc4N2hNSmhhcTlMaGtGMDEzZno3Y20z?=
 =?utf-8?B?OEVLU1RGQ1RXVDFrSXk2bENmV0N5ZnZjZXBBeWl1ZVB6TlFkd2VRS3ZxN1ZZ?=
 =?utf-8?B?d1kyYXBkNjNxMTVaRG9yeE5xK0l3cHBGcmcvNE56R2E5Nnd2cm4rU2RzUVBG?=
 =?utf-8?B?VVlpc2duQjR5MmtoMHI2RmRWOWhPNUlpTkQ2N2NwbDJlTWtMeEZBS1lQWTdR?=
 =?utf-8?B?L3Y3eXNHaUg0VUxiRncxZTA2MVE5WE9nY1JtakwvcHFaVXROTWZyMW5kL0x4?=
 =?utf-8?B?SU9aT0I2Y0o5d0NMVzBIcGZ4c1d3WHVXalQ0SnlPdHZIZ0RWaDRpMFg2TWQz?=
 =?utf-8?B?OXR1Y3IvR1pNSE55anVMd0Q1bnZSS3NDeU85UkJvbEtpcWhUL2l4aVV4VEZL?=
 =?utf-8?B?ZnNhWVlEamZZTnV0S2NRb0ZMb0VEc1BvblQwRzdpaWU0V3JZUFptczVZSU9Y?=
 =?utf-8?B?MEZ1UVdvbzZPQytQaGNSVERxaHhQMWJvcmFnMm1vTlQxendqY1l1OXZYdDZa?=
 =?utf-8?B?TFRnT1BJbHBiVTRoMFVhZjlldENDYXNzbWI4RDdQRlNGVURlN290a29MbEZt?=
 =?utf-8?B?aGR1Z0lvNjByVHVUSWpjVjFZdWRPTUNKeUxZaXZwakM1MmllTkRxVHFxd3M1?=
 =?utf-8?B?NGttUUVsWkxCVXFodkNtbm1QRERmaENHSHVtU1VkNWpmM2o3c0swRHpyZzJO?=
 =?utf-8?B?UW1saFMxaHNjaUdyd00zcW9Rdlo4dHNEUkpOOFdEb1FFMUlGUy9la0pmdGo4?=
 =?utf-8?B?VlczbE5SMFhUb1ZuTE9mNmR5UU8xRGZwQmFPd1YwenVwbk1RbnFXRmVQcnRK?=
 =?utf-8?B?c2g3RUhzT1VsVTk2bzgvdGk2ZVhIdkpDUXhRaTlBZjNqU1J5b3RIYVR0dHpJ?=
 =?utf-8?B?ejVyajNJYkIvRkppN3l0eWpXT0g3c21rSGtzWjlRdkxhNGpOcXI4aXBSYm5N?=
 =?utf-8?B?NjdLeHV6a1FLcWxMNjNETVgyQTgrb2ZJaGRrc1psMk5ISUJLTDRwcWt2Ritj?=
 =?utf-8?B?MGdNQnVWalR6bFFKRGlXWlZiZ1Y0eVdRL3F5ZDNiVDZpS0N6MzJJaDZsdzVq?=
 =?utf-8?B?Z2hmRWV6a2dvL0U3TkI0U1lkU1dRYm5vRGRPQmtucll2SG4yVlprcGl1ZVQ0?=
 =?utf-8?B?OS9BM3lwckNmY2hnNkxVYjV5dTNua1FqbkJ1S3A5b1NEYndhWjdzanFlZ3NE?=
 =?utf-8?B?LzVyeUdRbkpCa2tpdTh3dmxWMHZTLzY4SmVtT2gvVzhPc0FUQnZYZ0x1Q2Fn?=
 =?utf-8?B?ZGdyekZ5VzVPODRLSmJNdEVJa09CRXU4SVltRVpDdnU5U1BmcjVXdEZzcU9X?=
 =?utf-8?B?azJJYlp5eHdydlM2aEtJeWpoa0JBSXJLZkthY3BseHlRdktFajdSOGR5Vm9Z?=
 =?utf-8?B?a0VvQ2lPejVTMkQyZDlxTVVFS2hkU29oSmhyaTlRck5TNElheEsybDdUQk5O?=
 =?utf-8?B?STVxWWFwSE5qdWEvVDBFWGpMeTFjN256M2l6OTBHSi82SS83aEs2UXlFRWN2?=
 =?utf-8?B?cFE5OTI1eS9DMGpYNDdwWUp3NDFMZ2x6K0tiVWFzekVkZkpIWTA4YWZKbU91?=
 =?utf-8?B?YUxzUzl3dDZGSFJ3cGI0SWZPR0Y1TUxjR0RiNlVyZkJQMmhVRWdtSmt6SjVU?=
 =?utf-8?B?MmF6MTlIcFFzVUNpcW56bWFTTklPZk9uS1lnb1ZjcThkOUdHTkZYMEVSZXh3?=
 =?utf-8?B?UjJWSndwZFdNTVEzNUxOY0xPZ243cVNudE9RWEJJTGM5MSs3dS9ONEJTRENX?=
 =?utf-8?B?bWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sJosTdjMsKcQSIY32ATNIpbO5j6mJ1Fwcm+GiWttltAqbhxZm1ErnAHp4Q1QtWcMeVPGlP2uZF7Tys0VhonrpERnpmbsrtnG4Eexrawpg+Fa4Y5tjZm/s/UvYcFdFRB+GHi2dseOXLWmN3jP42gjbyvaNDtWugp9gMfFpCmWzKeWczq6RvmK6orYnzdPcvZA19HeDJSw4IiXma3xmMo+28pC+uBxCUn42xmUAE2fhzTHh4DKxZZMBqY3JdSui4+IrVb1VUMyZlBrJzAQe7rzM/Upl6M6RTs5vKG3GRxrWLzrIq0W+nEbt69pgDdt/6uNrpJ3cNS/zREFaqTh36L+mACnROYanSFOsDcrlnvYIozVpxzBRzMtlmUq4w15dofDrom/luOnAjqHx3nOaxFN1dzv0u+F6BvszPHgxQSe8yPKs1QDq/G10Nbav4xxVoq43umvKmpq0bQMHeMWbVjl9PmMtyO69ZURzKlcXan5CllmW/kJkSBnYHULlf7V8CtzslA79N1EA4ZGrhEuurL63WvvQDXJmmXvYSejvSQApduCV8rLvReSBEIZhXtYx8IdouGxHSuPgcTafX//NpsfFOpkFQwW26NmKHUlI7LbNyo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aae6658f-501a-4f7c-e292-08ddde65f4c8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4363.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 14:46:03.8373 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KdmUDxsTQCCykkBrdp0zBiOs1EOkuIF5OsEXj+vr2MQIGBBuQNlwBmoT99I2cX7+uq/waxdFx6L6L+BUIyMhpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB8213
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508180140
X-Proofpoint-GUID: Ql8dzbypD_u6sg-SU6e-03PV8BnwnzDo
X-Authority-Analysis: v=2.4 cv=dN2mmPZb c=1 sm=1 tr=0 ts=68a33caf b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8
 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=_Cf8j3k9u1wtnD4kuPEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12069
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDE0MCBTYWx0ZWRfX+PnfYz+As6rL
 ndquDt/75iPucP/oaiFUarcIMd5uibXJwEhil3Oe9+JZ3+P0RtAoVvjcRKN3ROMec7maAL8q+tv
 Q/UnmPRN8/mYtiKTle0xYO2lqKAbsisflF8MdIRpiu3zcFbzgtoShRZg4fVeEuPfEXmx4KdPo15
 NyS9d72X2iMk8XUET9WI68tLYaf91rdTR69D9kkvJgsnlMzpktCwGBbHknb/CNKHHyenPWR0Jt8
 8V6jzwe4KGny2wv29OdwlSjot7BL5JeRiCWH2mupvfdJim7qN2DAHTMJFi0ht3b0u2nKISc6T7E
 Cy9lqLhGePmUyXiJSUhti+e6sj45W3lPbV+sG/jHZftLdsqx2eqmJeT7xdjhJtikoYAqJs7oAY6
 bkOulsozDWM2TurDbhOwi6hmI46cjHZdMj6jgdwR1nxDQkXmxGwWwLLhA79KXtmkDaZKzhEM
X-Proofpoint-ORIG-GUID: Ql8dzbypD_u6sg-SU6e-03PV8BnwnzDo
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
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



On 8/18/25 2:51 AM, Eugenio Perez Martin wrote:
> On Fri, Aug 15, 2025 at 4:50 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>
>>
>>
>> On 8/14/25 5:28 AM, Eugenio Perez Martin wrote:
>>> On Wed, Aug 13, 2025 at 4:06 PM Peter Xu <peterx@redhat.com> wrote:
>>>>
>>>> On Wed, Aug 13, 2025 at 11:25:00AM +0200, Eugenio Perez Martin wrote:
>>>>> On Mon, Aug 11, 2025 at 11:56 PM Peter Xu <peterx@redhat.com> wrote:
>>>>>>
>>>>>> On Mon, Aug 11, 2025 at 05:26:05PM -0400, Jonah Palmer wrote:
>>>>>>> This effort was started to reduce the guest visible downtime by
>>>>>>> virtio-net/vhost-net/vhost-vDPA during live migration, especially
>>>>>>> vhost-vDPA.
>>>>>>>
>>>>>>> The downtime contributed by vhost-vDPA, for example, is not from having to
>>>>>>> migrate a lot of state but rather expensive backend control-plane latency
>>>>>>> like CVQ configurations (e.g. MQ queue pairs, RSS, MAC/VLAN filters, offload
>>>>>>> settings, MTU, etc.). Doing this requires kernel/HW NIC operations which
>>>>>>> dominates its downtime.
>>>>>>>
>>>>>>> In other words, by migrating the state of virtio-net early (before the
>>>>>>> stop-and-copy phase), we can also start staging backend configurations,
>>>>>>> which is the main contributor of downtime when migrating a vhost-vDPA
>>>>>>> device.
>>>>>>>
>>>>>>> I apologize if this series gives the impression that we're migrating a lot
>>>>>>> of data here. It's more along the lines of moving control-plane latency out
>>>>>>> of the stop-and-copy phase.
>>>>>>
>>>>>> I see, thanks.
>>>>>>
>>>>>> Please add these into the cover letter of the next post.  IMHO it's
>>>>>> extremely important information to explain the real goal of this work.  I
>>>>>> bet it is not expected for most people when reading the current cover
>>>>>> letter.
>>>>>>
>>>>>> Then it could have nothing to do with iterative phase, am I right?
>>>>>>
>>>>>> What are the data needed for the dest QEMU to start staging backend
>>>>>> configurations to the HWs underneath?  Does dest QEMU already have them in
>>>>>> the cmdlines?
>>>>>>
>>>>>> Asking this because I want to know whether it can be done completely
>>>>>> without src QEMU at all, e.g. when dest QEMU starts.
>>>>>>
>>>>>> If src QEMU's data is still needed, please also first consider providing
>>>>>> such facility using an "early VMSD" if it is ever possible: feel free to
>>>>>> refer to commit 3b95a71b22827d26178.
>>>>>>
>>>>>
>>>>> While it works for this series, it does not allow to resend the state
>>>>> when the src device changes. For example, if the number of virtqueues
>>>>> is modified.
>>>>
>>>> Some explanation on "how sync number of vqueues helps downtime" would help.
>>>> Not "it might preheat things", but exactly why, and how that differs when
>>>> it's pure software, and when hardware will be involved.
>>>>
>>>
>>> By nvidia engineers to configure vqs (number, size, RSS, etc) takes
>>> about ~200ms:
>>> https://urldefense.com/v3/__https://lore.kernel.org/qemu-devel/6c8ebb97-d546-3f1c-4cdd-54e23a566f61@nvidia.com/T/__;!!ACWV5N9M2RV99hQ!OQdf7sGaBlbXhcFHX7AC7HgYxvFljgwWlIgJCvMgWwFvPqMrAMbWqf0862zV5shIjaUvlrk54fLTK6uo2pA$
>>>
>>> Adding Dragos here in case he can provide more details. Maybe the
>>> numbers have changed though.
>>>
>>> And I guess the difference with pure SW will always come down to PCI
>>> communications, which assume it is slower than configuring the host SW
>>> device in RAM or even CPU cache. But I admin that proper profiling is
>>> needed before making those claims.
>>>
>>> Jonah, can you print the time it takes to configure the vDPA device
>>> with traces vs the time it takes to enable the dataplane of the
>>> device? So we can get an idea of how much time we save with this.
>>>
>>
>> Let me know if this isn't what you're looking for.
>>
>> I'm assuming by "configuration time" you mean:
>>    - Time from device startup (entry to vhost_vdpa_dev_start()) to right
>>      before we start enabling the vrings (e.g.
>>      VHOST_VDPA_SET_VRING_ENABLE in vhost_vdpa_net_cvq_load()).
>>
>> And by "time taken to enable the dataplane" I'm assuming you mean:
>>    - Time right before we start enabling the vrings (see above) to right
>>      after we enable the last vring (at the end of
>>      vhost_vdpa_net_cvq_load())
>>
>> Guest specs: 128G Mem, SVQ=on, CVQ=on, 8 queue pairs:
>>
>> -netdev type=vhost-vdpa,vhostdev=$VHOST_VDPA_0,id=vhost-vdpa0,
>>           queues=8,x-svq=on
>>
>> -device virtio-net-pci,netdev=vhost-vdpa0,id=vdpa0,bootindex=-1,
>>           romfile=,page-per-vq=on,mac=$VF1_MAC,ctrl_vq=on,mq=on,
>>           ctrl_vlan=off,vectors=18,host_mtu=9000,
>>           disable-legacy=on,disable-modern=off
>>
>> ---
>>
>> Configuration time:    ~31s
>> Dataplane enable time: ~0.14ms
>>
> 
> I was vague, but yes, that's representative enough! It would be more
> accurate if the configuration time ends by the time QEMU enables the
> first queue of the dataplane though.
> 
> As Si-Wei mentions, is v->shared->listener_registered == true at the
> beginning of vhost_vdpa_dev_start?
> 

Ah, I also realized that Qemu I was using for measurements was using a 
version before the listener_registered member was introduced.

I retested with the latest changes in Qemu and set x-svq=off, e.g.: 
guest specs: 128G Mem, SVQ=off, CVQ=on, 8 queue pairs. I ran testing 3 
times for measurements.

v->shared->listener_registered == false at the beginning of 
vhost_vdpa_dev_start().

---

Configuration time: Time from first entry into vhost_vdpa_dev_start() to 
right after Qemu enables the first VQ.
  - 26.947s, 26.606s, 27.326s

Enable dataplane: Time from right after first VQ is enabled to right 
after the last VQ is enabled.
  - 0.081ms, 0.081ms, 0.079ms


