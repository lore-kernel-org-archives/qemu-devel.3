Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 423A2C678DC
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 14:40:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPMcP-0005cy-1v; Wed, 11 Jun 2025 10:39:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uPMcI-0005Wn-BN
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 10:39:50 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uPMcG-0007yO-LW
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 10:39:50 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55BEdHlv026559;
 Wed, 11 Jun 2025 14:39:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=I222YhbpjBV5lIggZsDTug0E84/z/dcYnNy+HN1NiAA=; b=
 S+lMmoa2ltYowuuapkd36TvcXbiYGS+rN0mln2DDSuxOMPwMK9tFgwboVB/QS3JN
 axEe3pQyaCu/wEuHdP9NWzWJUaPFV9R13+4k4dIVuLaolhnz3nXCKb3npnSWCWtN
 b1HjF3tAef6ndGJFDc1Q8TyuBtnTNfkRHtuk1SqYJ5OE8e5QcVScQ4meKt/YgWJb
 gptqI7t2IZlz8BPj/oCFXni+TY3tFtgt9blLZoHSK7s8x0jmy03MEfRIfeToioqU
 0taAYaIWjyG8JS/d+Md3V/zDRFFFHcU1R2gYyO/zQKlMR4N0Z2fOiVCN9X8+tiKj
 jvsBRmuwmVJL3HmxzInhJw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474d1v7jvp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Jun 2025 14:39:45 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55BEUBoP021511; Wed, 11 Jun 2025 14:39:44 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 474bvb0cvy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Jun 2025 14:39:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=axBEg8FwsrOC+PupUSSgi3sPs+ar41ZxeYIeVgJWWyVciDjMzis06mrqpQ7kcdhU/WY2QuvSY0MTdguryngqlt9sM699c3RmCHVL4oIs4lFxMj/378KUVSGTOv6f0lNlXbBMR2hnanQT28OCj5tfLT8AOsvZaGjQHr4fXAPkswASlHYelrNRajdPJFLRZQIsP7b1s4FBGaCaludpHjUQeD5vANU8cif/Hoq0oyZjagwspdujN1GfKSKn3RuZR0raQx9IZJsTeNpw/npBCO+tHQT7wmxBBKrsDrMYPiLKpdPTTbNcH07sejOLH9oEVKyRXZXmTJNXRBBYcW56YCbfYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I222YhbpjBV5lIggZsDTug0E84/z/dcYnNy+HN1NiAA=;
 b=qNeuPGS4+DHRVAlCFdWUpk7B8YPhE6fIvwgBJxafxKlFmXNDA3z2pA/3PT9PyzQJfxXbr6/cMktnAFIqz+T222E5mN8TmloR5lXJD6fl6nge1NkTmhryH9yEGPdOyMTS/ouFfK3DAvu5ShEJBmAm84xrPWAMlkSoco9aFzWhaa2aZfYNEj4kvwShNBi40L65O7om+lTBQ5//Xj+OVGlnGKHTt0TFtI37DTG0XG+63eArW/b4/vZM0QzI//I4Hn8Fmaoe7FMJxJj010HbLCM6KchmRPwiftKcqa6nuJf9rcEh9MjNG0Ss4iiiS8a9xSck/wUvQie0oTXEkfTNwAgP1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I222YhbpjBV5lIggZsDTug0E84/z/dcYnNy+HN1NiAA=;
 b=wq8aW1fdamyRGF1QPfF+hgLr7Xwxf/yN0fTCTNe58BcXVFR8/TPE7vC0qKX5y5NsUpgnfNjrCcIoehqI2qZ4m2menRusGJgZsAvzcsbNz+Qlr9SRzmgKeo96xC2nY8a+h8f1J5xgMvZ50KaVx4ecIRLtQcLo65PMQAkaMLP9oTA=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by LV8PR10MB7989.namprd10.prod.outlook.com (2603:10b6:408:203::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.40; Wed, 11 Jun
 2025 14:39:40 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8835.018; Wed, 11 Jun 2025
 14:39:39 +0000
Message-ID: <573aa339-1c40-43b4-997d-c3e4996caaec@oracle.com>
Date: Wed, 11 Jun 2025 10:39:32 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 00/38] Live update: vfio and iommufd
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
 <0330df5e-8a9d-4fdf-bee8-a864eedac24d@redhat.com>
 <effe22b4-c6e4-41c2-b3e2-d03160560f86@redhat.com>
 <b6e11593-cd1b-4d51-9c17-37ccefccd094@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <b6e11593-cd1b-4d51-9c17-37ccefccd094@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0184.namprd05.prod.outlook.com
 (2603:10b6:a03:330::9) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|LV8PR10MB7989:EE_
X-MS-Office365-Filtering-Correlation-Id: b435d5e1-365f-4791-2671-08dda8f5cbcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d0IvOU5zMmxMQ1dUcEZEZ094VmlIQUJxOFFZSUlqVzhkVE1VOE40dDFXVHFj?=
 =?utf-8?B?N0hOVFZoNlg2MlBtaVZML2lmcXgyeDhoYzJPUS9FRDNxQ0VSbXhtQ0MrVWxD?=
 =?utf-8?B?TGZ5TWhzRVFud2JaNHFaR3JYWXhreTA5WlZBU2ErSjNFMm9KRUhuUkE2dTNW?=
 =?utf-8?B?cVBoSG0vQVhvYWZ6WGpjQXk0ZkhZL2R3T0QzdDFBK0wxVDF5ZUttd1NtNmFV?=
 =?utf-8?B?cHhZL0dhZXpDendINkdsbHlSeVdPWHBrMFo3MEVncWJITGduT1J2ZFNFL1dU?=
 =?utf-8?B?M28veU5lTzI4UXZnaFNlamUrdUluZUV1cjl5ZmwwT0Vsa1haMC95bjMyWS9r?=
 =?utf-8?B?UGRDTFJWVmF0MXp3alg4aG4xSUg5MVZQMVNkMTcyVU53OEZ6YmNSelI2MmM1?=
 =?utf-8?B?U29wUFdiT1hXemMvM01BVGhRdTNnbWNLTEF6NytSNGE2dC8vWWNnRzhzOHNT?=
 =?utf-8?B?VHZweXA0VGMxYSsvTnQ3ekg4SWtlNzM2bWhOdnFpMWpFWEYyM3UvNG1FVHFH?=
 =?utf-8?B?YmZ0c3NHdXkvaWk1Y25saGVTamdkTEZ3N0hCak0zV0pHald1R3N0OHNtN3ha?=
 =?utf-8?B?b3A5RDVIVU4vYVdoa0xwcEgwV1c0QU5wbUphK1JwSXdycHFjV3kxdXRTTHBo?=
 =?utf-8?B?UGFkeGRVTXBNT0J3NEd3cUhqSkNjRTV2NDRhaGFzdE1HaEI0UzFwbXFWOWlo?=
 =?utf-8?B?NXBVSEhEbCswWmZCcmJaUmM5MFAzTnJua2hGaDhmdy9GQ3phRlF3NVBqYVRx?=
 =?utf-8?B?ZkRWR1l0ak5qVHAvMG4zTFJKMGp5NnhObjZwNzM2NUkxVlFpRnR1UjJMK2lX?=
 =?utf-8?B?bHFrRUw4UUlPakNtS3V0d0tQVithQ0V4OGNmbzEzYmg0TGVFUlJ5VU9iNlpO?=
 =?utf-8?B?bFFMT3ZsaDYwTUFUaHlBWWZlbitnUDExa3d0bVNGcFBIaUxleXZ0aDRENThy?=
 =?utf-8?B?RmppT2pwMXVzak82ZGMwZW1BRVIvZFpXTmxZdEkvbWhUZlVEVzVCRUZvZDhH?=
 =?utf-8?B?NjI3MWY0S1ZDdU5Pa29BUk5ySkpFdDdsMG9EU3lwK2FMZFJLeXNLSnM4cEZG?=
 =?utf-8?B?NUwxNGpjbFUvNUt6RW5Yd3RXdlh2cjV6d0Z4ZklBOWU4aitFeGZmVTRJNVRW?=
 =?utf-8?B?dG9xS2pZRDNXL0JLZml1MytSZEZxOWxvbWZGei9VcUdVRTJZbVNzdXJQWmI2?=
 =?utf-8?B?MVN0aVBaT0hGSUpPZEx6S1VOdmJOYVdvckJqSld5S3Q2ckxkcGloM3NzeVpv?=
 =?utf-8?B?Zm9KSjd4VXRKTFN5L3lNT2JSNGo4bks1Q210VDdjelJtd1hyZmNLa05IYmY4?=
 =?utf-8?B?ZGFUK25TY2tYai9laHJIMndGRTVtSXgxSEFNeFh5QWdieW9UdU1talZoM3Rq?=
 =?utf-8?B?eURBeWJza29pMWMxTXVKV0NEV0h4b0xsSGpYZWU3dHdSbEVQeGxNKy9Nd3BY?=
 =?utf-8?B?YXQ3RWFWV0hwZUFXSU5ZZndrcUtCSHhDS01GSFV6YnJCd0ZxOHBiRUlSR0o5?=
 =?utf-8?B?UFJLQ0pWcTBNaXNQR2VyZFg3UDRxOEFZMkpIS0FLUDhLdHc3dUV1QzEzcmdo?=
 =?utf-8?B?U3RtRU9vU1BQL0lvOVg3aVZjbzJrVTVpR3R3bVBjMElKN0VCR1o4RXJwNzJW?=
 =?utf-8?B?M0hzVUw3UHFZSzY2bkUyZE9aU2lYUm8vdTRRc05CSGFNcjIrUWhRUFVtdmpa?=
 =?utf-8?B?Nm9aek10VGdTV0dUVHJLVGlpanNPdHRzVkZKT0pYbGEvY21SZlVJSmJUdUty?=
 =?utf-8?B?RlRRMTNBL3ZNREc5R0JkSTc0OFM0QlNXNG44NGZaMTlyTEdUMnN0MWJHMWcw?=
 =?utf-8?B?YjFXOGo4WE54YXlBblYxeTB6VkNEUTVSL21Lb1hCeWtDZ1huU2JmUDJDb3Fp?=
 =?utf-8?B?Q0xUMjNmSS9PVzV1SEs3SWlxT2gvTUZyUGJ1dTFTRWhWeThJdHFOMFJaZnFW?=
 =?utf-8?Q?92FMs26JM0I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTQ0VEE4aUVZblViZ2ZrNmF3WFlOczQrY05rZEtpSkZsbzgyNnRvMGRIYWNF?=
 =?utf-8?B?N29mV3pKQVhzLzhaNlpKS0pKMWk0b2hxL0ZHd1hZdHhQZGpQanVwamhTRGxM?=
 =?utf-8?B?ZWtveUlGZTNkSncwWXhxdGJxSjBZakVjS281ZThObEJMOERpZjg3OWZuYUwx?=
 =?utf-8?B?cUkwc01lNGlNbVJJWlRFYXFVbHg5ZldMem52WEJJd0xTTUFnU3hTd0RiUGF0?=
 =?utf-8?B?V2tYaXdXN002OXp5N3E5S3h0TmE5a0MxMG54QkxZT0JMU0M3bm4xekxTRXMy?=
 =?utf-8?B?SWM4ZEh4eDhMeVBMN3JPcW9vZ2hjRUlOMFRJYU1CR1JTaGZza1pIQXlnczRw?=
 =?utf-8?B?bFEwTlkrZW9uUjNaTmxMam95NEh2TW9OUjVBMlQwWkMyMWZOY013U2dOTEkx?=
 =?utf-8?B?U1grYWRpbTdFVXJmTDVjdnZZcjRQRUVjeDNjS1AzTEZmRXVWY1piWVJrL3k4?=
 =?utf-8?B?a0ZnY29kaUgwUkNHRCtmTyswSUcvQXhPOXIwNHFFbmNDY0E1bVRFS2p4Z0VT?=
 =?utf-8?B?WkpLZXVBa0E3bGRneld3KzlySlNnZUdxUHRqSnNNNGpBaVpyS3FQN3A2K1Ju?=
 =?utf-8?B?WjlKOW9MTGdBc0tKR2VibVpoVlcvOFZUZmZoV0RMRUVNT1c5dkVxbWVudjlI?=
 =?utf-8?B?cGROcjRkZ0V2eDhnRmlEdllBLyt3TGlOcGxna2xHc3pqU3pPMUZqbUd0RU96?=
 =?utf-8?B?UnVJYVMxRUNzc1p0QnRCSVdHR0hHczRkQUZRQnFlUTR4SzN3TmQ4QjBFN3Ay?=
 =?utf-8?B?UjBwVkgyNGx2dTAzbi9ZTHN5bFBxd0FwTWZIcnRYYlNsM2ZRcWVINFF4OERR?=
 =?utf-8?B?WGJjdkM0cmc3MTc2MTRKT2hyeXZLdXFtREhqclo5TXlnRjd0RWw4bWNQSXRP?=
 =?utf-8?B?YnVWSnZmNjhSVDF5YTE1Wnk5ak9jRjF4L2VXbmxPclVXcVc5OFV3TTEwQzJG?=
 =?utf-8?B?Tm13dW53S0lzdExFQ3pLeEwwTEFBZFYrQUtqNlZxYWlJSkVkWmoxbkZmdVVH?=
 =?utf-8?B?bkJvV1Y3TlUvUlA2alRwZ08wdFJNRlNMVzVKMXQrb1RUYzkyUzJVSFFkekFP?=
 =?utf-8?B?UllpR0hVUnV3Z1EyejFEbm1zbGFjR1BTM21DUW5XVk9pYmU1OU1QemU4aEdP?=
 =?utf-8?B?NVd4SG96YUZYOG81cHJSSHJrdkVId1UwSFJTdUJoT09BMUdCMWhkTUcxUDFo?=
 =?utf-8?B?QmwzL3NuV3dScS9zdmJ2US9kSThVSHRCM09RenFWeUlTSUIrMWk0dDRZQjA5?=
 =?utf-8?B?U1J5Vkp3OUxlSlhqZTJQNis5eVp4S0t3QnRoT05TYU84SytnZzQ5YUxCamJL?=
 =?utf-8?B?MmlzTnhaZm1BMyt6QlQ3VHY4NzBOOGFvQ3FNeldYSHRWd01XYTd4ZFM1QnZO?=
 =?utf-8?B?bHg4Zkd5dFI0SmdEWVNQalUyUTFwT21oaWVpL0kyZ0dCN2UrS1E4dnhHYStZ?=
 =?utf-8?B?RStXejlkLzEwNmRobW94L2lwNmkzYmNrOHpDZjBnejhqYXArYnJuQ3c1STJD?=
 =?utf-8?B?OHhKTlJYU3hINkRqbmpJdEJMZSt1aXI3dk9rVjFQeUE3YUE1aXY1WU5CUGtk?=
 =?utf-8?B?LzJkejNnN0N0RVJuWmhsNVNnVWNHZGxLMU9QMy9ra1hja1UvRFhBVG1EUnc0?=
 =?utf-8?B?UVNoZUNUTUZ4S3dkVEFRai9yZWhoYW1kd2tydDFhN1pGZGYzZ2NRWmdpQkZp?=
 =?utf-8?B?YVgwWEcrQ09NUUFMR3VHNGo3SVJNZi8wS0JLdVJoVFN1Z0pXQmNQQllna1dr?=
 =?utf-8?B?R212YWgydUhRSENGWkNFZnNnRjJ6dlkzR3FyRUVwWTI4citSQnJoSVNWRFlz?=
 =?utf-8?B?UDFLeWFYeGlWVkhvc2JZeklQU04yUWMxN3BFakpGVUF6bCtPVEFTNytxRUQw?=
 =?utf-8?B?cDYrNmhxelE2V0ppdXRrN3llaWlKVFVOdk1qMFFHd3pWVFdMRkVQcVJvSzVJ?=
 =?utf-8?B?TDFjaEFNVGVxVGRCWE5UOGhBRUt5NnpvMWJlTzdHZ0lHOGJhTVJsM1hmZG5Q?=
 =?utf-8?B?VVAwWE1uZkhoQkRIMS9kM1YwMTNwMXFBS2lPVUtNZHRXRlk1RHJrSDV3OWtl?=
 =?utf-8?B?T2xIYWttYlFlcGtQdlp2NS9PekFJWE00V1kzLytkdDNJaXREYzZVVVNWN3ox?=
 =?utf-8?B?T3JFQVlESzRFMXNvS1g3UmlRU2dyM3lWLzJYMGJQcnV0OTRyNEdQQ2p5dzlQ?=
 =?utf-8?B?ZGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WnTOfP099BC1Mp9pwls1ax9n0FFvru0QwHNNQP+ZIKODZypWwdqYj6jG+IFtd94qfy4yTj+2eAJ7G6FHq6PLk+f2zG/WPEZQ2veLsAGUqIo6EO7xpUEYuuqKReQK37ORX4rXi10uvqzK76GACQ7vBUSrEW4Ald+BguXYABxFCMVuwnyMfiazo1d82jWOp+qeOaRIxixbO+pMoboAvv7PvknpEGdTHt482N0vf0GsiLqNt8prfLZyEBzxWbAqFy4ED9KmNa1DHMwM1U6L/ZQF0knP4oZL7DfrdggiVa6atr3blcTMuv2LKmpBgTM0v4iiNalZeeUivSongwx8+7U876VS1WpvooYlPYTDEcBFAVYLE3tr5gV6j+XPdQ/2KZQdSuGurY4sNNozPORVXAlOmKMTU7vPUiuFdBBgu+AJY72NtHGrS23Knw8orl3FW+6ZcIWBYtixJhJ/t3LyXU2DjlfjzbUBdUoAg3s03dFI1/P2x3PArg4KU7PuixVlIMwpqGLltfoS11FPPhfNN/Kj2WRZwQesNsSVxkaoWg3T4wmt64mFuyrF94JygVlFjXBUL9RMBXNoZFZEFilT0heK7o7jbrA91oHWQ3AAhs16C8o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b435d5e1-365f-4791-2671-08dda8f5cbcc
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 14:39:39.7818 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KleSEb7sOR6POrrr4dAGqSz//6TmS+nyS6F+aMwVDd4QMgvSJUIoo0+FYqiMY4nxHXSkqQO/jC3lSLCzG2vcFRhVaJm6CV0LQQEhbT/OcNc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7989
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_05,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=850 bulkscore=0
 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506110122
X-Proofpoint-GUID: mtXj_ulTN8aIxCZycRVyLzL_5suGUPVv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDEyMiBTYWx0ZWRfX7LkUTSbWb9EQ
 +GhkoEtD9it55eXwT+pRpu3tTg0p/TN3WRrffjPDO8cUf/kT7eeLX4zzH20rphqZI/L9XxLvrnp
 LntXUPZBUASJ1JVoRiYebMsIZ7A0f3ajd1JR3Cq9XiHg5UMH0y/AvdR8LhnuAhvuBrvhQRFuSLi
 zSKEnybd5q9S24wohQHqcSlZAY36bUrnxde4MGeMwPvtmnJsFJduLcqfPJ0i2nBqh7ykgKt/rra
 UerJHaG+Iu8ynRwq11toaFjsOBozaH/+RFv+EDfLvfuztAj79DeiUlxoCTVZ5cwCPiiYEqms6+B
 0JJkc4dOFiyAZ1wuMYeP195oGRfsudKRkAE4U05U4GPU71JfJVfFucAUGc6NXtclbttkRPc+etI
 EqX/APAq/H5hiNaf7ImbxmQpFG9CCyx/8m1omJRPxMbSITz0dQuj+vbGJv7PUMeEjNj9R26H
X-Proofpoint-ORIG-GUID: mtXj_ulTN8aIxCZycRVyLzL_5suGUPVv
X-Authority-Analysis: v=2.4 cv=d731yQjE c=1 sm=1 tr=0 ts=68499531 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=mPrr1OiV-zpBTxu-RGUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13206
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 6/11/2025 10:25 AM, Cédric Le Goater wrote:
> On 6/10/25 19:39, Cédric Le Goater wrote:
>>> Steve,
>>>
>>> For the next vfio PR, I plan to take patches 1-17 when patch 10 is
>>> updated. The rest is for later in this cycle
>>
>> Applied 1-17 to vfio-next. Waiting for an Ack from Michael.
> 
> I am planing to send a PR with this first part to get more visibility.
> There is a slight risk of merging useless changes since CPR is not
> fully reviewed. My optimistic nature tells me it should reach QEMU 10.1
> and we have time to adjust.
> 
> Please feel free to intervene if you prefer the series to be fully
> approved/reviewed before merging.

A partial merge is fine with me.

- Steve

> 
> Peter, Fabiano,
> 
> The first 2 patches are migration patches. Do you agree if I take them
> through the VFIO queue ?
> 
> Thanks,
> 
> C.
> 
> 


