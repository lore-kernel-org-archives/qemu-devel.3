Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D31C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 13:30:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugNvG-0004W3-1D; Mon, 28 Jul 2025 09:29:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1ugNBB-00013t-4G
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 08:42:10 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1ugNB4-0004Ob-Al
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 08:42:08 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SC8J2i030423;
 Mon, 28 Jul 2025 12:41:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=OHJweR0dpYM7NbvLLM+UyipX2riFHWoV6Le1Q5eBDZ0=; b=
 Gd0ED5/25DFrI7Bp6Ji8L1DImCZIguLysOaizX6ibXJwp2GoeQX7y8dnQ6YRkp05
 beitRISdNbFSnMDqYCzF5zogjun/qQhLHsawbbJFwFSAoZAaUXqS86y7jfsKH6kd
 mG1veeZ52OMYaYi/EoqLUL8XiqqUGW/NG5BppzFMjFMOWIvNp7O6mZllrNRCrAHj
 fb8YQ/SpoQYIKo/0ivB7UhQhDz9yFiXrUw+efjkk8qGD8XEpZOD92gR2kgbrSHEK
 LcbrPG5ZQkwq1HiLlV1K77dWc/FMXLx/L6yukg0gxPkNyIoxJSBQF1Kr1CPtmv3/
 r1NKNfHCredqiSNALnR0FQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q5wu6y0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 28 Jul 2025 12:41:58 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 56SCFDqM003171; Mon, 28 Jul 2025 12:41:58 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 484nf8g4tt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 28 Jul 2025 12:41:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bL0bSdhdMmW8jHnGecZrSxR1tC7Zd5SC85xKrAydBaY+gdGNfia9QLqGMHMnDyUSoGY4ZQVd7AoAEUrXHIhbWUiZxK194izCGbxR0BrICLOxU7TZKmAF/nHA8XLJfTC2ieP6edgwm80C13i+VS9gT7lcIF2hLh4InsufNFRbEdg+++yHKY3gMAK8mceZe19Auspo5RbYbXxVmxG9Wu5Edgv2uLiXChA3T6kZ2wDY4rfSY/fdJhx8E0ISy6jnG8cdV7rnkglERRXiYv9TUxIbrgQ1DzPp2yjzdqdCY6tCZ6jCtaMqYzAnBR8poS4WXFZK261rK/5wvwQx/Em96vvW1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OHJweR0dpYM7NbvLLM+UyipX2riFHWoV6Le1Q5eBDZ0=;
 b=oinG/rpP/zGShrPr/AHzkNB5rNf2C0m6eEGvPzoFXQoH7D3lTOkee40UsJzz4u+S5bFInuHpT1TOqLZU+BQfdfzlaPHvID4WtISgJpUbLcQexkjnLSWxjTOF36iCSUSAmPHiAXL28ngTyZXyA9AijD2P8maRUVCmza4mjCH7JVaA3Oo8V8Qqjhewsvj2D1SjdzqymwnN6C+sZ9GgmnNMRzRqlPg7BEiaf9lz8WYgUifal2G9B5zb51D41OTE5oXMkql6lIVbbFcn/piCzcY6bMJVvU/KHiRcvH3Dg0Y0QdSc9P3BMwtLgqFqWCQegWnGkxuxEu6gchz30+UhriCF8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHJweR0dpYM7NbvLLM+UyipX2riFHWoV6Le1Q5eBDZ0=;
 b=A8JdLtZkHvAthk11Q7Jg4JWltzFh9tcNeCs5Jcet536OijaTNjPY1Q4qfZp6f4MOXdmSTHeL4Q9KVEB+LpRHyfXrCMAastreDOkOKjGbDX3ACgGKq9/AocS8OFyDMZrOjF4cBzDk5u4tfiE1VYXoc4ZmLdaRglGFaL07qmbuXLU=
Received: from DM6PR10MB4363.namprd10.prod.outlook.com (2603:10b6:5:21e::21)
 by SJ2PR10MB7600.namprd10.prod.outlook.com (2603:10b6:a03:543::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 12:41:55 +0000
Received: from DM6PR10MB4363.namprd10.prod.outlook.com
 ([fe80::999b:18e4:cc6a:7cc6]) by DM6PR10MB4363.namprd10.prod.outlook.com
 ([fe80::999b:18e4:cc6a:7cc6%7]) with mapi id 15.20.8964.023; Mon, 28 Jul 2025
 12:41:55 +0000
Message-ID: <77967b1f-a4f6-44da-a981-2add2fb451f8@oracle.com>
Date: Mon, 28 Jul 2025 08:41:51 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/6] virtio-net: initial iterative live migration support
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, farosas@suse.de,
 eblake@redhat.com, armbru@redhat.com, si-wei.liu@oracle.com,
 eperezma@redhat.com, boris.ostrovsky@oracle.com
References: <20250722124127.2497406-1-jonah.palmer@oracle.com>
 <CACGkMEvrgAqSr9sgvq6F4oKBitZncqhsB_MEsbaNB7p0ZN5fEA@mail.gmail.com>
 <0f5b804d-3852-4159-b151-308a57f1ec74@oracle.com>
 <20250725053122-mutt-send-email-mst@kernel.org>
 <CACGkMEvTgCAbBG20iLB1m_WfYzMZA7FYZ2FuL6To4EV86PXZbA@mail.gmail.com>
 <CACGkMEtCiqq0P_7aB-d5CrQraHL2xky5Qa+9LyZce4hk+wvvYQ@mail.gmail.com>
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <CACGkMEtCiqq0P_7aB-d5CrQraHL2xky5Qa+9LyZce4hk+wvvYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8P223CA0025.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:2db::13) To DM6PR10MB4363.namprd10.prod.outlook.com
 (2603:10b6:5:21e::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4363:EE_|SJ2PR10MB7600:EE_
X-MS-Office365-Filtering-Correlation-Id: 641f3d60-fd8e-4e08-6903-08ddcdd42271
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WEhWa0JSbnM2dzVjanNXWDlIbHhBTWdnbnFWczhjVEh5WnZhZTdQR0NzQzNj?=
 =?utf-8?B?TmwzdnhpZll3eE83S2NPK0dVTEhzaEFzL21FUXZOVm42cFUyelRwYnJGZzEw?=
 =?utf-8?B?VHJKNUpIYkJqbEhPaTlyaHBqZS9ydG03Mk81WWF3Q2dvWkVHcFU3Ri9LWFNu?=
 =?utf-8?B?dEZjSE10ZzVsVkQ2UFBobmtneTRNUG5HeTVJUjFBUjN1NHpmR3RjL0FMNXNW?=
 =?utf-8?B?bHViRXdzZHhnY3gySVdrQlhtYlVRMlVvY3FKUGEvK21SUkU5dWpLZmkrMjJw?=
 =?utf-8?B?RWpJQTEwbEhibnlkSHRHOERPL1luWG1FUkFYMFBYZ0ZKTll6QnMzN3I1aWx3?=
 =?utf-8?B?RmVSamNLL0t4VUtaYmNSQjZvTmNicG1wOUJFQ2dHYi82d01JcU94UFllWUpQ?=
 =?utf-8?B?SGU0dXROR24zcVRDV2pWZkVkM1ExUCtXWnRUcTZZSFBiUVBnVW1zb3lCZ3dq?=
 =?utf-8?B?Z1hhZHY1bFQ0MUg1WFhhdVkxZkJmM2NIVXpoOUREbHc1YVkxRkE5dys4MEdD?=
 =?utf-8?B?b3ZTcEZpYjNtcVZKcTRublpnVFhIL1Fud3c4S3RFZnRBQVRndlBuRjJ6YzUz?=
 =?utf-8?B?TFVSLzJVdzRqZ0VYTTRLb1pkRFI2UlR1UnFJVWcvWVFmYjg3WldkaXdINzQ2?=
 =?utf-8?B?RFN5MFlGS1A0MVVjUlA1RTZwR3lGaWZlTWk2SUNCYVZBOXo2U3lmd0ZONXh5?=
 =?utf-8?B?MnhRSGdZcVNwdlJyY3JJNEpINElyY0wvbEJCR2ZZSjdRdS9SMjZaZThpT1NT?=
 =?utf-8?B?QUttcGFXUGpjVi9sYnJab21HNzMxSHJkVitWWlBZTituMmEzYlVFdnNQRmNq?=
 =?utf-8?B?MHU3b2Y1NjZuU3ZTRnF1OUlLQjdmVUE2VzlScUJwTVRXNVJyWXo5UlBiZ0RK?=
 =?utf-8?B?UXdtMzY4aHdmRDg4T0lhRUtzL2U3WEZDTWFaVU1yNDJrMlFpYmk0a09tdFZu?=
 =?utf-8?B?OUFZM1Y3WHNTNEZsWnZOc0FMOTJBaW9qNmgxTWhncFBJVXJxeCtkc2tsUThC?=
 =?utf-8?B?NHBGZTdVOS9TNXBDNWE5NzBnQUU3OXovTC82b0Y1R2pnUUxPS3pQNmc3M3lG?=
 =?utf-8?B?d3BtTWZ4c0t4QnAwTnh3andNc1lXQlgzRUx4UFRSRkJQdVo5YUdUczdscXFn?=
 =?utf-8?B?VEFyUFRGZ2ZBNlRVRkpTdXBQN3hyNzl4dDVha3NxcHE3VGdCVDBVZjdtT2Nx?=
 =?utf-8?B?QmF6Y0dSdSsyUWZuakxhMEtreW53VmFiaVZJd0NzbUlZN05wYW16cU1kaHQ0?=
 =?utf-8?B?c25IWTZsNzJwZTZvRnFsSFpMZjlsRWVUa3d1Y3E1UzNMQ1J4UitjVGp6VmNB?=
 =?utf-8?B?WmhjaG9PbnZLMXowa05abWQ0c2FoRkZvejcwTEQ1RkNkSERhbWNFSFhjMmVY?=
 =?utf-8?B?d0xkOXc1VUNLNWc5UUZlUmJEbVN3RGdGb1RhMGkrelI1aVF0algzVWpjMTNv?=
 =?utf-8?B?SFRCTkpPUm1lTW80TmFreUxMcDhKRGYwVlZYOXd3Mkd6VjBJcTRHbmt2dmt5?=
 =?utf-8?B?TWVocitHbkFLclB1WktxRFQvSXA4MnJTSy93NXk2Yng0eHkwWHcxQ1pLeUQv?=
 =?utf-8?B?eVNuQVZhTWNpalN5WE9aT2NYWjk0OEJnY3dIa01GbVQ1cTdxT1VQYkpTTXNi?=
 =?utf-8?B?aEVZc2VMN3VRSkUrVDMzTWdaN0dJZTQ0VndjblFBM1hvR1N0RTJBOGY0bk5S?=
 =?utf-8?B?bUJpdzhqTWJIajFaR0JkMkNlQ3dkbzU1NWxRcjQ2ZkUxblBGamFWZlhxZDV0?=
 =?utf-8?B?T0hhYkt2c0NBbXBkajhVQzBWNUh6YW94MDlQc2Y5M2FmajVGSXhNT3UvSHZu?=
 =?utf-8?B?Sm5PVnBrSEMzQ0ZyeTZDa0J1TGdxaFVmb0d0eDZJaHp3cGNKdmo5WkRVUlBV?=
 =?utf-8?B?dWMydUY2L0VQdHhxRElqWk16d3Zid0NDcUc5dXVEOXdtbDlMY2p6Y3M0M0cr?=
 =?utf-8?Q?xbDPSl2I0y0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR10MB4363.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aW94L3FzUEd6YzRKQmNqdHc0bGZLWXFHUTd2RS83WU05OTI5U2RGS3FqODFG?=
 =?utf-8?B?NFF6VGY1cnc2cUdHWmxDaWlSd0w5S1BOQVNGeGJmR3BTN0Y3TGNUTVV1dlRa?=
 =?utf-8?B?bnFkT2E5S0xNUVRoQ3AxbmxsS1EvNUw2RkY0YWp0blU4VkwrcW1IYks5ZXFz?=
 =?utf-8?B?Rit1dVMvaXF1SGRnR2tVM0NEMmcySFhCcldtK1NmNzUrSkRhMnBlcExmS1hS?=
 =?utf-8?B?dlUyNXFrVWl3VVg5NVJZUFB1a0wzelYxd0lMWHp5ZkhCckhYSmlndlVqR3l6?=
 =?utf-8?B?SUMyUWlxbTdHdGdWaGYrUU92Tk1VeGZueXVoYUdPcHBMbzFQZk0rc2dMRHVW?=
 =?utf-8?B?ZSt6V1F3THVsc3Z4Zk8wVHhOUGN1VE4zcFFYWXhyclNKZ3dScDB5d3ppaEtW?=
 =?utf-8?B?bmFJbkJ2SUhFTjd6Y3hFbXpXY3ZiRks4SCtoaWZWdkhxWG10YlJyQ3B5bk5W?=
 =?utf-8?B?NmV0UjRBeE1KZUpXR3NGSFB1OFkvRjdxTi91ejYzRERuT2kyaFZaYkVWOVNh?=
 =?utf-8?B?TlFWT1FlNWh2S1dJZGNMZmYzNFRoRmswa0N6dHJtVkZ0RUw0R3kyT1NaV3NB?=
 =?utf-8?B?YnFuOEFIYXI4SEUyM2l5NHJzTWFGR2JLWHlMTFBLbHBGb3pSRnpaeDdYUGo0?=
 =?utf-8?B?bEl6MTQxUU1ZWHVwZnFGODA1akpDQWdBRnJ5aERKSXg1bmNQRWZxU2ZyUmM2?=
 =?utf-8?B?THUrY3dsRzRsS3JreGpEUk54OHNkU05GVjh6N2o3czZ0SjJWWkRqUXFJcG5q?=
 =?utf-8?B?Vzc5Mnh0V21LREpGL3VzN1JGd0Fjakt2QWd2YXVWTGFkYVR6MW5lVG5oUWx5?=
 =?utf-8?B?dERPWStTdlZnSnZuOTBaTzJnYU9NNnAyWlFicUpkNjZTeWNMRG5pUVJKU0V4?=
 =?utf-8?B?TTVqV1VqVi9yVWF5Wm1GMzR1RmttbzJGQTJLeUhFVXpIWFVKQjZJY25vQjdq?=
 =?utf-8?B?SjlLSFZONWc4bXdQYkNpMjdsR29TWWZhN1AwYTl6dkZsendoZGxmemNYa2RS?=
 =?utf-8?B?R2gwendlWnJZdVJwWWplUDR5djA1VGtlS0tpVUdzWFUrbVJTbTgvZ3B3UFI3?=
 =?utf-8?B?bGdsTWpiblBLc3Rsd0Y2UXlvQWxLMFFlTm03VmkwUkVtbjRpaTROWk1OWVpG?=
 =?utf-8?B?WjlNbEVLazRPN2x5eS9YK2piemRNaFlyYlJyM2gwc0pTL0FLa3FMNHdMa0JI?=
 =?utf-8?B?d1gvb2p4ejNZZU83N1c5OVRGenMrbURBNzUzQ0RRNWpuNXUraWlhcjIweWJo?=
 =?utf-8?B?WEQrNHJTWUNXM1RuZnBVQ0hSOVdpOTVBdm5tTGhscWxtUVhMK2t1Q1dBZUw5?=
 =?utf-8?B?bXAyd1dsV1JyQlp0YWNKRzFhdWNiMXlJY1RRRXF1d21Oc1dyaHlYVG5razlq?=
 =?utf-8?B?OVVwK2dhYzdjU1lzMXpJOUdIMXNPRnpZNkpUUTVFbXlkRzVMWk5HUlRRMjhL?=
 =?utf-8?B?OTVtbDM0ajM4aE1XK1I2NnQwTmRzTHVBYXF4cEZkdmZLbytCWk14Nmc3ay9Z?=
 =?utf-8?B?QWQrK0liRzRuTnVrVmFhSXhuNWVrSk1MQjQ1UTB6YWM2emthY0ZZS3k5bXgv?=
 =?utf-8?B?RndpSXJGT3ZaMGFsUmFydmd6M3hDWmh1a3NYTHlvQnVsdWJadFh4V0RhWkFM?=
 =?utf-8?B?eUNUUTNCUlJydHIyYkdBSmNEUHlYUkd4NGtyTXR0cEJDZHFSeGpJdmcwaXM5?=
 =?utf-8?B?TVFxYTNremVmM1N6UHlld2hFMFBnUzFhRElqYStsTzNYczdBU1BQNWZhR0Ux?=
 =?utf-8?B?aDFUbUp3bTRHVDZOVldtd0l2OFBrT2Q0R0hqTERpNk51NzFZQTE0YmJSSUFN?=
 =?utf-8?B?ZzBtR2tMeHdCYlA1N012TnN3YVZLSGhtR2JoZzhJODhURC9YYi9lUzBhT25T?=
 =?utf-8?B?Vjd1bTBMNThNV0Zrcnh6VTBSZzRxZVNrR3ZseG9ualB3bVpiWW9wdzA1elhj?=
 =?utf-8?B?dXBwTzN5bDJ0cGE2aVo5aDEyTXJPOER2VEN0Tmg0dDRjRWQ4a1g1RU5iV29L?=
 =?utf-8?B?dTFZNkNSNS9pcHNWQUNzTVNiMzNFYUVRWWRBVjNOUW13OFNwYUR4QXpobHV2?=
 =?utf-8?B?UHBhOTJXQ29HSE9iMGNqVExaYTlLQ1B3Q3lqQzNIbVBhL3QyQmtuRlFNRGFr?=
 =?utf-8?Q?Shp10lQb2CoonwXy6nN0VXMBv?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NbeBVSLgBYv7PLn8lEDoBvEx3iJXsziw/XTfKEQWNzBzHLViYn7iHNiHTbz7lg8DuhH5wCQbeYO3kt1Csh1i/A87wsW7aJ0VfmwRtPFs2FqLR5Nx7C9eMEZ5cW1zSDcc4YQWWNMGgLzkzyauw7hSjCqVeBnr1ObxfUrCM6Hghw4eBDpHus0CbYFjYUaXJdd6OE2F9/Qk9EVMb87p/+B0UUHdhyglAIvB/ZSiAlJX5ihvbkZisiKLXsCX6PVQvFiFGpnSzyoU3rLl62PQP9hLRtxqROQy4j+va7PSqPqDG2kZlVUAj7cWAXFQmp7cd3u6drKw/T58B2HlLPyUaCky7Y68Zpl9vwfGmIvlsSq3x1pw7NNdx1k1OVsHm18UIPxohEVrmmZhRCkfIxy6Fdlp+GBGiNwErUhbIuEOVn8R6GQ5YbUk0wDX5eUNyJOI7sRoBWwqqZDOSBR1WgCbIx3x/io9T4DSF97gpxPzTAaxYKxtZnKituHgFbWgEt4z2vZZcaIsITZDMKpGsIt+GXBdglGiCDYGcTGpcPQQf5C89w9B4Vr3l+1xYFdnxEvgw2Wt6CyesaN+QIYITnjSxHpTuZ9f1dLR8CpeeX5dIFMPQ6Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 641f3d60-fd8e-4e08-6903-08ddcdd42271
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4363.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 12:41:55.3078 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ELdoaY4CQdVJ8TJlZ30UKegllJwWcGSRDTahoruF/FmVhZa6Gblx+Jz/P03iVeSzWexYmttdhdvVJEPPWc3CzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7600
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 spamscore=0
 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507280093
X-Authority-Analysis: v=2.4 cv=X+lSKHTe c=1 sm=1 tr=0 ts=68877016 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8
 a=ySjbdQRUVj7h-4mhXxUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: oOBIF2cSzAfwMaqSHEnKXYUBk95CiPM9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDA5MyBTYWx0ZWRfX+biEuhKZLTTo
 V1H0TLYglB1NW8DMysuDb7+oU4lWSFUx11xiATKRpWzQnI+XgtCLTCpLk1F4K1kq/9cYZMiCrY4
 bWBLY181um/emiEI0itGXuJThu126z2NLWgcVOzmY96/24IJUQgmyJ6zA7dskDZhzKpcwUNwjPF
 FnruLkKlur5UsfxH+53SMQjdDh1mm44IfutHNfPLEcCDgfeoo33xjIC4WkJUPiFpuZxzuOfpPn4
 pIUA3KcbjFMspBHrLGeznindW8zC0ua9dUgjDBKQjFpKUx8ertURlfU2eJySYVS2PNbPp2Ow/gv
 FJdxh1IsQGFXedn6KS0y80PwX9egF5FAwj7gDAzcsyWrlN3CeTGbDuGwpXISoO46bu8G+anexR+
 wVheUMyBo5PziiNnOnlSm0fy6hbynHZzZcwaGOBtqfq2TQlrJplgrDVHuxMPrE4nNKvmHTsX
X-Proofpoint-ORIG-GUID: oOBIF2cSzAfwMaqSHEnKXYUBk95CiPM9
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
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



On 7/28/25 3:35 AM, Jason Wang wrote:
> On Mon, Jul 28, 2025 at 3:09 PM Jason Wang <jasowang@redhat.com> wrote:
>>
>> On Fri, Jul 25, 2025 at 5:33 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>>>
>>> On Thu, Jul 24, 2025 at 05:59:20PM -0400, Jonah Palmer wrote:
>>>>
>>>>
>>>> On 7/23/25 1:51 AM, Jason Wang wrote:
>>>>> On Tue, Jul 22, 2025 at 8:41 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>>>>>
>>>>>> This series is an RFC initial implementation of iterative live
>>>>>> migration for virtio-net devices.
>>>>>>
>>>>>> The main motivation behind implementing iterative migration for
>>>>>> virtio-net devices is to start on heavy, time-consuming operations
>>>>>> for the destination while the source is still active (i.e. before
>>>>>> the stop-and-copy phase).
>>>>>
>>>>> It would be better to explain which kind of operations were heavy and
>>>>> time-consuming and how iterative migration help.
>>>>>
>>>>
>>>> You're right. Apologies for being vague here.
>>>>
>>>> I did do some profiling of the virtio_load call for virtio-net to try and
>>>> narrow down where exactly most of the downtime is coming from during the
>>>> stop-and-copy phase.
>>>>
>>>> Pretty much the entirety of the downtime comes from the vmstate_load_state
>>>> call for the vmstate_virtio's subsections:
>>>>
>>>> /* Subsections */
>>>> ret = vmstate_load_state(f, &vmstate_virtio, vdev, 1);
>>>> if (ret) {
>>>>      return ret;
>>>> }
>>>>
>>>> More specifically, the vmstate_virtio_virtqueues and
>>>> vmstate_virtio_extra_state subsections.
>>>>
>>>> For example, currently (with no iterative migration), for a virtio-net
>>>> device, the virtio_load call took 13.29ms to finish. 13.20ms of that time
>>>> was spent in vmstate_load_state(f, &vmstate_virtio, vdev, 1).
>>>>
>>>> Of that 13.21ms, ~6.83ms was spent migrating vmstate_virtio_virtqueues and
>>>> ~6.33ms was spent migrating the vmstate_virtio_extra_state subsections. And
>>>> I believe this is from walking VIRTIO_QUEUE_MAX virtqueues, twice.
>>>
>>> Can we optimize it simply by sending a bitmap of used vqs?
>>
>> +1.
>>
>> For example devices like virtio-net may know exactly the number of
>> virtqueues that will be used.
> 
> Ok, I think it comes from the following subsections:
> 
> static const VMStateDescription vmstate_virtio_virtqueues = {
>      .name = "virtio/virtqueues",
>      .version_id = 1,
>      .minimum_version_id = 1,
>      .needed = &virtio_virtqueue_needed,
>      .fields = (const VMStateField[]) {
>          VMSTATE_STRUCT_VARRAY_POINTER_KNOWN(vq, struct VirtIODevice,
>                        VIRTIO_QUEUE_MAX, 0, vmstate_virtqueue, VirtQueue),
>          VMSTATE_END_OF_LIST()
>      }
> };
> 
> static const VMStateDescription vmstate_virtio_packed_virtqueues = {
>      .name = "virtio/packed_virtqueues",
>      .version_id = 1,
>      .minimum_version_id = 1,
>      .needed = &virtio_packed_virtqueue_needed,
>      .fields = (const VMStateField[]) {
>          VMSTATE_STRUCT_VARRAY_POINTER_KNOWN(vq, struct VirtIODevice,
>                        VIRTIO_QUEUE_MAX, 0, vmstate_packed_virtqueue, VirtQueue),
>          VMSTATE_END_OF_LIST()
>      }
> };
> 
> A rough idea is to disable those subsections and use new subsections
> instead (and do the compatibility work) like virtio_save():
> 
>      for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
>          if (vdev->vq[i].vring.num == 0)
>              break;
>      }
> 
>      qemu_put_be32(f, i);
>      ....
> 
> Thanks
> 

Right. There's this for split/packed VQs and then there's also the 
vmstate_virtio_extra_state which ends up loading this 
virtio-pci/modern-state:

static const VMStateDescription vmstate_virtio_pci_modern_state_sub = {
     .name = "virtio_pci/modern_state",
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = &virtio_pci_modern_state_needed,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32(dfselect, VirtIOPCIProxy),
         VMSTATE_UINT32(gfselect, VirtIOPCIProxy),
         VMSTATE_UINT32_ARRAY(guest_features, VirtIOPCIProxy, 2),
         VMSTATE_STRUCT_ARRAY(vqs, VirtIOPCIProxy, VIRTIO_QUEUE_MAX, 0,
                              vmstate_virtio_pci_modern_queue_state,
                              VirtIOPCIQueue),
         VMSTATE_END_OF_LIST()
     }
};

...
vmstate_load_state_end virtio/virtqueues end/0
vmstate_load_state virtio/extra_state v1
vmstate_load_state virtio_pci v1
vmstate_load_state virtio_pci/modern_state v1
vmstate_load_state virtio_pci/modern_queue_state v1
...

I'll take a look at what could be done here and try and get it into the 
next series.

>>
>>>
>>>> vmstate_load_state virtio-net v11
>>>> vmstate_load_state PCIDevice v2
>>>> vmstate_load_state_end PCIDevice end/0
>>>> vmstate_load_state virtio-net-device v11
>>>> vmstate_load_state virtio-net-queue-tx_waiting v0
>>>> vmstate_load_state_end virtio-net-queue-tx_waiting end/0
>>>> vmstate_load_state virtio-net-vnet v0
>>>> vmstate_load_state_end virtio-net-vnet end/0
>>>> vmstate_load_state virtio-net-ufo v0
>>>> vmstate_load_state_end virtio-net-ufo end/0
>>>> vmstate_load_state virtio-net-tx_waiting v0
>>>> vmstate_load_state virtio-net-queue-tx_waiting v0
>>>> vmstate_load_state_end virtio-net-queue-tx_waiting end/0
>>>> vmstate_load_state virtio-net-queue-tx_waiting v0
>>>> vmstate_load_state_end virtio-net-queue-tx_waiting end/0
>>>> vmstate_load_state virtio-net-queue-tx_waiting v0
>>>> vmstate_load_state_end virtio-net-queue-tx_waiting end/0
>>>> vmstate_load_state_end virtio-net-tx_waiting end/0
>>>> vmstate_load_state_end virtio-net-device end/0
>>>> vmstate_load_state virtio v1
>>>> vmstate_load_state virtio/64bit_features v1
>>>> vmstate_load_state_end virtio/64bit_features end/0
>>>> vmstate_load_state virtio/virtqueues v1
>>>> vmstate_load_state virtqueue_state v1  <--- Queue idx 0
>>>> ...
>>>> vmstate_load_state_end virtqueue_state end/0
>>>> vmstate_load_state virtqueue_state v1  <--- Queue idx 1023
>>>> vmstate_load_state_end virtqueue_state end/0
>>>> vmstate_load_state_end virtio/virtqueues end/0
>>>> vmstate_load_state virtio/extra_state v1
>>>> vmstate_load_state virtio_pci v1
>>>> vmstate_load_state virtio_pci/modern_state v1
>>>> vmstate_load_state virtio_pci/modern_queue_state v1  <--- Queue idx 0
>>>> vmstate_load_state_end virtio_pci/modern_queue_state end/0
>>>> ...
>>>> vmstate_load_state virtio_pci/modern_queue_state v1  <--- Queue idx 1023
>>>> vmstate_load_state_end virtio_pci/modern_queue_state end/0
>>>> vmstate_load_state_end virtio_pci/modern_state end/0
>>>> vmstate_load_state_end virtio_pci end/0
>>>> vmstate_load_state_end virtio/extra_state end/0
>>>> vmstate_load_state virtio/started v1
>>>> vmstate_load_state_end virtio/started end/0
>>>> vmstate_load_state_end virtio end/0
>>>> vmstate_load_state_end virtio-net end/0
>>>> vmstate_downtime_load type=non-iterable idstr=0000:00:03.0/virtio-net
>>>> instance_id=0 downtime=13260
>>>>
>>>> With iterative migration for virtio-net (maybe all virtio devices?), we can
>>>> send this early while the source is still running and then only send the
>>>> deltas during the stop-and-copy phase. It's likely that the source wont be
>>>> using all VIRTIO_QUEUE_MAX virtqueues during the migration period, so this
>>>> could really minimize a large majority of the downtime contributed by
>>>> virtio-net.
>>>>
>>>> This could be one example.
>>
>> Or if the system call is expensive, could we try io_uring to mitigate it.
>>
>>>>
>>>>>>
>>>>>> The motivation behind this RFC series specifically is to provide an
>>>>>> initial framework for such an implementation and get feedback on the
>>>>>> design and direction.
>>>>>> -------
>>>>>>
>>>>>> This implementation of iterative live migration for a virtio-net device
>>>>>> is enabled via setting the migration capability 'virtio-iterative' to
>>>>>> on for both the source & destination, e.g. (HMP):
>>>>>>
>>>>>> (qemu) migrate_set_capability virtio-iterative on
>>>>>>
>>>>>> The virtio-net device's SaveVMHandlers hooks are registered/unregistered
>>>>>> during the device's realize/unrealize phase.
>>>>>
>>>>> I wonder about the plan for libvirt support.
>>>>>
>>>>
>>>> Could you elaborate on this a bit?
>>
>> I meant how this feature will be supported by the libvirt.
>>
>>>>
>>>>>>
>>>>>> Currently, this series only sends and loads the vmstate at the start of
>>>>>> migration. The vmstate is still sent (again) during the stop-and-copy
>>>>>> phase, as it is today, to handle any deltas in the state since it was
>>>>>> initially sent. A future patch in this series could avoid having to
>>>>>> re-send and re-load the entire state again and instead focus only on the
>>>>>> deltas.
>>>>>>
>>>>>> There is a slight, modest improvement in guest-visible downtime from
>>>>>> this series. More specifically, when using iterative live migration with
>>>>>> a virtio-net device, the downtime contributed by migrating a virtio-net
>>>>>> device decreased from ~3.2ms to ~1.4ms on average:
>>>>>
>>>>> Are you testing this via a software virtio device or hardware one?
>>>>>
>>>>
>>>> Just software (virtio-device, vhost-net) with these numbers. I can run some
>>>> tests with vDPA hardware though.
>>
>> I see. Considering you see great improvement with software devices. It
>> should be sufficient.
>>
>>>>
>>>> Those numbers were from a simple, 1 queue-pair virtio-net device.
>>
>> Thanks
>>
>>>>
>>>>>>
>>>>>> Before:
>>>>>> -------
>>>>>> vmstate_downtime_load type=non-iterable idstr=0000:00:03.0/virtio-net
>>>>>>     instance_id=0 downtime=3594
>>>>>>
>>>>>> After:
>>>>>> ------
>>>>>> vmstate_downtime_load type=non-iterable idstr=0000:00:03.0/virtio-net
>>>>>>     instance_id=0 downtime=1607
>>>>>>
>>>>>> This slight improvement is likely due to the initial vmstate_load_state
>>>>>> call "warming up" pages in memory such that, when it's called a second
>>>>>> time during the stop-and-copy phase, allocation and page-fault latencies
>>>>>> are reduced.
>>>>>> -------
>>>>>>
>>>>>> Comments, suggestions, etc. are welcome here.
>>>>>>
>>>>>> Jonah Palmer (6):
>>>>>>     migration: Add virtio-iterative capability
>>>>>>     virtio-net: Reorder vmstate_virtio_net and helpers
>>>>>>     virtio-net: Add SaveVMHandlers for iterative migration
>>>>>>     virtio-net: iter live migration - migrate vmstate
>>>>>>     virtio,virtio-net: skip consistency check in virtio_load for iterative
>>>>>>       migration
>>>>>>     virtio-net: skip vhost_started assertion during iterative migration
>>>>>>
>>>>>>    hw/net/virtio-net.c            | 246 +++++++++++++++++++++++++++------
>>>>>>    hw/virtio/virtio.c             |  32 +++--
>>>>>>    include/hw/virtio/virtio-net.h |   8 ++
>>>>>>    include/hw/virtio/virtio.h     |   7 +
>>>>>>    migration/savevm.c             |   1 +
>>>>>>    qapi/migration.json            |   7 +-
>>>>>>    6 files changed, 247 insertions(+), 54 deletions(-)
>>>>>>
>>>>>> --
>>>>>> 2.47.1
>>>>>
>>>>> Thanks
>>>>>
>>>>>>
>>>>>
>>>
> 


