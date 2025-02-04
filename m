Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F525C02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 16:16:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfLaU-0005A2-L3; Tue, 04 Feb 2025 11:15:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tfLZr-0004an-Tt
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 11:15:12 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tfLZp-00076k-01
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 11:15:07 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514DSIxs013476;
 Tue, 4 Feb 2025 16:15:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=YvwIA76e11Ox9WYqP7ejz8HV94qGdytK5R/cl10VfCo=; b=
 NjFQYfGl9+88MThnF1yjh4sBnqeSxkob9kkEzcg7MEGZ28vg2+hKh7SdtgtGnsjx
 ATRxuhZTCKrLJr5Nuq03w1PbaMbp6fo81NcYIdHezEZ2BSickmlhuiOS6BIGdKaU
 7Vvjti8WVv+hWIow9BkpXOIsq92Wulo6/z78uRdL+FSdvm6eXDKSjLDSxxC4l7Oq
 FR+xLrBJC8ILk/oRVY2vwvGen7znSzpnRDcAB7z6AflUn1ZvuIwi6W+gJS8C7aoh
 b2M3jUR1ReLFxn4DG/yUv0+Q7rStRE93KZEIxgW8krWxTThSV27FWDVJOfSZeNvq
 TKh1cb0QtI/iZytIbgr8wQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hfcgwaem-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 04 Feb 2025 16:15:00 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 514EjG3Z039025; Tue, 4 Feb 2025 16:15:00 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2049.outbound.protection.outlook.com [104.47.55.49])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 44j8e7w7et-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 04 Feb 2025 16:14:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sPldydTmjuvYQj+c3DIlRXSpa6Z2+O31m5yOcNF+s8/HQZrlPUcbJbTQUwQa6mCw5FUGUnhAEC/g2pEpDOywg6Ptdv2OjR9VJxfLC5aRsD5vzmbESkkUYSQAe4SedOWhlZV5PQT+TapTrvUnfx5GqDLcLm+d7+pk4wht1h6tOfvfJo2cWbj1gul0nkyq4mMs0M/UjdeSL8QsNRRLN/Cs3DPNUNk3bKFst/k4V8rFnvwXaSGw4fHpfpnfFIc/KnRhH17UISTFzuW4HtC4dwiVQIAZG+F136UGlxkEHlaBkoxicAqlh+M7gi0lpHPrwqJFbxXFjJPJXujHnFTdGYGJlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YvwIA76e11Ox9WYqP7ejz8HV94qGdytK5R/cl10VfCo=;
 b=Hyd77ljXyQhd1Jx8B5vMaJpUvqGQk+jZpcifB8RleD6s8AJ/AaKAEwzViZK4GpFL3l1Y6M2TE3IQ2ml/k2dYjmbjA0nviHNVQ/Wl0fp0YlTOAAZj77csWwx8Fxt2rcW2fSJEV36SRYwj2qrT2YNvKhQJf14WMHLVZ6eo4rOvIlCJ7jdBRCM+SQkWbjjb8+bCKD/mU8dOeM1liAgwTxSU1HQhQ3gqQ2Wf0Vd/f7SN4ryXUulRw82AIqjkHE4JW9T0i3bcKWdzyUrYcBMUXIgICiLeQ8SmqDbnMjGopP6EGsfecaiuvMTaG7k7rLfHdc0bnXv4uLzZOrNVjFV2gsg3Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvwIA76e11Ox9WYqP7ejz8HV94qGdytK5R/cl10VfCo=;
 b=jV/NRaLKL4hA3HzwyXT4vksjC/QP9jiwhfzQUSA9J3HKemLMIT+k5qfqTF4SSOa1KVye2q4M7+Eg/ceV/swK+8dTHGVatuM9mX+/isrygQQKtxPBpN7og3P2+Tj4FqWMu7LYU72M7hWlNBDZujvnavJN0dgCNDwaCOQZkn+jJeI=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DS7PR10MB7299.namprd10.prod.outlook.com (2603:10b6:8:ea::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.24; Tue, 4 Feb 2025 16:14:55 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.8398.025; Tue, 4 Feb 2025
 16:14:54 +0000
Message-ID: <a44b22c0-2be2-41e8-b27c-84aac55d1ac9@oracle.com>
Date: Tue, 4 Feb 2025 11:14:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 10/26] vfio-pci: refactor for cpr
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1738161802-172631-1-git-send-email-steven.sistare@oracle.com>
 <1738161802-172631-11-git-send-email-steven.sistare@oracle.com>
 <f08ce379-f69c-421c-a852-38736322c8e6@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <f08ce379-f69c-421c-a852-38736322c8e6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0014.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::19) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DS7PR10MB7299:EE_
X-MS-Office365-Filtering-Correlation-Id: d6d7e1b1-0839-4005-58c8-08dd45370fc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Rm16Z1ZRL1ZFRkRJNWQvaFd6QzNOUFVNVHc5UzR2SGVzM1lCZEYvSXl5aDZx?=
 =?utf-8?B?YWE3KzhoZ1I2a3lWTFZyYTQ3RnFhV0FLdXZCSzBHQXpLQjg1VVR5U1pkZWM5?=
 =?utf-8?B?ZUVyaVdzeE9rUjZSNnN6WE03WGh6ZThmYzQ0aEsxZENPV1EzWm14MUxmbHd6?=
 =?utf-8?B?NmRyWExzQzh4MWkzNGZVYkdhMjJPQ2dRdGErWG8zdWNQYnZWdVlsQWtZK3Yv?=
 =?utf-8?B?NWR4RzZyM3dlc0lJWjg5MHRvQ3hibEY0N29vZmZnT3c5V3ppa01HZDZobjdW?=
 =?utf-8?B?cFMxMUpmd1NHNy9tM1g3T0VOaWVRaFpFUWQwZ0hoeXFicUIya3lKb3N0TVhK?=
 =?utf-8?B?RW1PUlNuc0s2NnBCTTFFbXAyYTRRMkZjQXZmOGQ2Z0twd3ZpbzVvTy93ZEtD?=
 =?utf-8?B?L2pqRlFKRnJFenlORCs5NlF3dncweXArbVBlamVPd3oxOEVOaUlSSks2amlG?=
 =?utf-8?B?OHpoRWVHVnRrNUpFMEJrTXNTVTBEY3Jpdlk1TU0xRldpT1VvNHR3VjByUm03?=
 =?utf-8?B?TnVZc0dHRVVPZzZsM09zWmtmZE5wZmoxdmpHdnJOM0RHQVlpUWQwRm9SRytq?=
 =?utf-8?B?UXQ3OE13cURxOWxSK0luSzJybkdBd3ZpbzdjVThwN2VSeno2NGsrUU5iWE1x?=
 =?utf-8?B?ME1tSjA4MHdRUWZYbEZ6SGgxb0lmd0s0L1VUQ3pxRHFaaG5iREdaMnpJamhm?=
 =?utf-8?B?cmlLMDVEakZxYlBiRGl6RzVkWUpoOHFWTHpmbW9sMUZ1TDlCZUNiTFVNSDZi?=
 =?utf-8?B?SDJKZ3JiQW56TVBjMTZrSFRkOWJuaVVIR0VYUlozRUExckNZd3BDb1RBdTNn?=
 =?utf-8?B?QkZrakVhakZ1a2VMdmI0OXV0cGNrVlNKRHlncGw4b2d5bHc1QjZhbEVnZmp1?=
 =?utf-8?B?NTE4ZU43VGN0VXFrRVRhZkx2cGtnSlRkK2EyU0lBVXdjcWxZMjAwdVZEemFw?=
 =?utf-8?B?ckk0L05DOXNBaTJEZHZ2N1lZeWtQcUQ0aGFXT2h2azI2MWZGRU13bEZMa3BX?=
 =?utf-8?B?ZlA2eUdRQmxCQThTcThoSmZoNjFtb2c0RktLLzltSUFCd2tDRG9hTDZLK2w0?=
 =?utf-8?B?dFp4RVducjBpZlQzNXV3K0Z5bnkveGtYdzVhMjMrazBQQnpaaXprb1NhL053?=
 =?utf-8?B?eUR5YWNtTmwxNFhYZ0hVdEF0TGIvaGZqSEQ0RFRUTjlqbVNsLytTOEp3ZUhZ?=
 =?utf-8?B?SVE0TWQrcmRUUnYwMmE3Rm90bFU0emhHbWZsckZZNmdnYmJGcjhRTC9SbEJQ?=
 =?utf-8?B?WU1WMjMrSGdnSU9UU253dzdjN05qN1RORllOc0cwOXYxMjBJVTB2eTlvaWQy?=
 =?utf-8?B?NnFLa2JrNzFVdVNvZ3BRQk5yc09ROWc2cEpoa3JWSlNMOHN5YkxmQzMwMUpI?=
 =?utf-8?B?aG91M1FMZHZCWlI1MmQvMFUyakdXRFBta0l5UVFnY2NISWIxUGFxU0YwTUsr?=
 =?utf-8?B?OXRzazZSUFhJU2Y2d25CRVNJMDd1bDRiY1NDdzVFSkw3NGV3SEVLNlIxNU1S?=
 =?utf-8?B?c0lvemQrNGcrS2ZyWUlpOGpUbXlGT0VuWGJpNjhEUEhjNGt4VVU2R0JwbGRs?=
 =?utf-8?B?WlpsczJSeSt2S2xaV1A0SGZ4cGFsSytXOHg1SzFVNFNFVGlWelMxTENJSGxa?=
 =?utf-8?B?N2VjMkw5Tk8yOWN6Y2NBNDZjN1RDai9UeHBrYXkveU9VZjh3bW5UREcrRXVY?=
 =?utf-8?B?Qy9EbEdJTlRrZG1nYkY4OTdGMU5aY3NCdFEzVmpoS3d2blZlWkxoM29ldTJB?=
 =?utf-8?B?WnRwR0RDRG44a2dZOFFmMUsxbHNqNUR5eVIrMmM2VzRPdVMvNkxlaVplQnVS?=
 =?utf-8?B?WVJzM01lT2MrbUE0TFhsNGRMTENLVFhOdDdnc0dLZEJGY1FPNFdQNFplM0Qr?=
 =?utf-8?Q?MgX1HFTsJUuCr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVpYLzQvcTdYYzlGVWZlbkV5ZFhjL1Z5Lzl0MUFOWUdmRFovcFFxSjFCTEto?=
 =?utf-8?B?eHVwZk45eWFxaGhLZ1ZzZTdCQktEVjVIdjdMWUVjWE9yL1dVMzFhZ3FRSTdo?=
 =?utf-8?B?RGJab3F0S1VYajhjTXJoQWlGQzlVKzdHaGJ5ZExpUC96NU9yVXdNVXRUSlVa?=
 =?utf-8?B?WW9LV1hTWkJsUHVSREhGOEFWRWtvcnhZUHNjSGlnN2tPYWtsaHpKMDZoOU8v?=
 =?utf-8?B?SDZLMkVxK2NCNG4ra0pWN0dzK1VpRi82SVRnZDNhQVJxZGxGZThvaSsxdDN1?=
 =?utf-8?B?eFhyZ2NIYlFJcnZhNlpTeENsbWUzNGluNFh1TDhSRFFDd0VSRG1OcmU4c2p2?=
 =?utf-8?B?YUl3MnVMK3JoSmxRUHJqSGxSOEdHdnpZR0NBelVERUhTdlpGZnpTQjM4U0N1?=
 =?utf-8?B?R1hrZ1FYVVQ5dlVOTEVkaHRJTEdHdld2UUJJVEJuaHg4dFNlN1ZZeXBYRjl1?=
 =?utf-8?B?MDVBcFJyR2d4eTloQmFtNEp4ZzhFWVN3RGVkNys3bXZSSDRiTEUxc2R1eXhw?=
 =?utf-8?B?SHRnM2FkVzl3Ly9hckhGR1ZXeUlZbVc5ZG1zU3habnAxcWRyY1RhbEc3UTZz?=
 =?utf-8?B?bnlJMFIzVHl2UTFuZXd5UEpOU2F2d2xtSWFuSVBjVGZNWDlwczlqWmVMeGdo?=
 =?utf-8?B?L2JlbVdwK2ZnVmNxbndTUDkxUzNUUzllL0pWUFJtb1QzZTN6VkFkOW5UZnI1?=
 =?utf-8?B?QW1UK3BxbFV3Ukc5bnMrcmRhd1NsbmVDRFFSMG1yTnZ0NmhpckUzbVdOK1p0?=
 =?utf-8?B?MzRGcVRUUjRteTFaL3d6ZVlhQVFaRldvV3JOZFk5QlU4Q3hSNFhqc3lkdDBB?=
 =?utf-8?B?UlhOcFliNy9RYzdGeENpcmlUZTVEVGV5MWVRMHd4MGV3SXlVeHdyb2ZvbzV0?=
 =?utf-8?B?NndBWDBjdWJhZzZhMEhWSVluQlpqcUd4cmd0VUVsQXBWdy90KzEwcitCaUw3?=
 =?utf-8?B?cmpFaUI2b1l6WUIrVWhlOUQ0UjNzOHNyRzFiK2NpRWZYa1NrK1FXUG1DWEJN?=
 =?utf-8?B?TzhRKzhPYmFqVWI5VVVCRE16MzZtdU53LzVhRkNSeXpxeUFvSmVNSmZXK0xV?=
 =?utf-8?B?eFdyNkhPYm5qd1BGck5SaFZSOE9SR0VXaitpWG9aMTJOczR4aUpncVJKNGpx?=
 =?utf-8?B?UDl5bU9neE9LWTFUb1dPb2xHdm5ScVl6M1R6VG41dDBZUzQwR0FkK2g2ZU1V?=
 =?utf-8?B?bnVvWmtDVTJBa3VNbk8wVUpsZ3VTTFhqQTAyQ0VVdHJPOUdXM1h6bXlLa2Jk?=
 =?utf-8?B?M1Bha0g2YTlqVEFqd1lGeDYvSy9GTXhLNkJ4RTRndWZYdndpeXR1Zm4waXpm?=
 =?utf-8?B?bXF3VkhBQituUTBOblkvKy9vUzB5aFcrWFMrKzlBM0JuNTA2LzF6WGxjNEQx?=
 =?utf-8?B?ekk5WXUxL3FHM2EwTElqK1F2U0p2MU1PUFAwcjNMbUpqT0VyYUVjYlFwbTdU?=
 =?utf-8?B?Y0oyczdJdml2KzNPMEdYaGNGMmRkODVLMjdpdzNQMmFGU1hoZ2s5RnVZQ25p?=
 =?utf-8?B?RlVsOW5DZVU3TEhBQldGdXpqMS9BelZabEVaaktHMnJsS2lxcHlIU3ZPTml6?=
 =?utf-8?B?OVBRY0hEdEVBZzBIRlgvaUJCY2hmb2ZFZVNoYUtVcThnNk5uOFZsc1V4cUlK?=
 =?utf-8?B?SENKT0szMFRxUFFFcE1jVDRyTjVMVmQyOXkwWWFSTHIvQlNucHZ1N2lOTHlP?=
 =?utf-8?B?STNlZW03TzJYQTdldFdEdlBGWFpkOE95WXFwaWZQaWV6QjM4amFzVjFMd2xQ?=
 =?utf-8?B?eG90TS8vaHdFSm1WU3lrT1YrNVBndzhyV1hvbUt4QjdjUm4vRThTdWVMZzA5?=
 =?utf-8?B?TTdRVndHVEk3MGF0WS8zMjJWYzZLeGdVTjhuWFVrOUZUYkVBd0FQSzRSaG1t?=
 =?utf-8?B?YXp5RjNBTmxmZDU3NGhOd0x5SXZaN1I1c1ZraFJtQUVKSXNsSGorNk5lRVVJ?=
 =?utf-8?B?aXUwdFJDdUFCY29EbWxZa1hiQlY2M1pvNDdXWVZTTmVrN0pobnNBNmJGY3o2?=
 =?utf-8?B?RTlhUDBKQ2JlQ3BnanNUdWs5SVF0QzUxRlFuVk9qSDlGTVYxeEhhU1VXR1Fh?=
 =?utf-8?B?dE42aXJIWnZFSlp1WWphcHVSVThzTkRKT2tscUxvc01wbTQ0eHRjeU41bmNn?=
 =?utf-8?B?YWxPMnhGNGkyaVMraUNrak1SSmttUlB1UC90dmNLN0tZNFRva3lkSTdtOXRP?=
 =?utf-8?B?c1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /2dhwqXB9TbGoHTxkgZqI6QIBeVz4431c1Yydpl2pdlevhibRoQvWkJtqoFNZKAF8lod4dznGMjVHT1uJDt5dpeq5HhTpSB8Xu/xTyDJoU9uEmooyoIpKGe8046PdpdKM1qvoKM0dnFbM+MiKtDitVRH6tTkEXuQSd5yiZK6T4jgP+u0Gnz9KSaC0dXUtO7koaStkR2OcgAxnv6ZIj8y31vTI/WJAf++CsUbCo4Wkr09e01H7TsBLwD0t0GBbOifVc7D3oRF+UOBGJE6oFNF2Gcy0h+siw7lK+5/VKq4BkYjlvUNzEGJsLwPRtrrX3lIaK4TWrOrtYXK2Fq+WXqNpAmhfIyCcxsw4U925Drm8beLNSFQx1YyaJFkc8mFFz10/8pjkr9oT6OiOPiKc4FBSV7d86TC09lNI9OrXtvDERfRfiJU2kR4JtuP0fCbKsJuWY6Tp7Fu/MCO3CJ1NN6+kB4JVyMTNEDTXW4NogzideiVXzT85XMzfJ/I5pJDWPvXLYDjXMoCKf7Oasv5J/7qHz4hSeRLoVGOsZBvxQBnjooaXMLYc0tXAQEFUUPZHHN0J9T+SeH1UMJbga40YsWsylb99sf2EaSad1UD0ooK8tA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6d7e1b1-0839-4005-58c8-08dd45370fc7
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 16:14:54.8858 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: emsltSzL6WXs9hruLa8QCy8YpRnAen2z9QX7lIfDFZPLKVrDJTFF/BWQGGoYkHCaVLBHe5wFq8kQYkZid/aKgbR2zOuCqHUQ/+h+ssDtefs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7299
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_08,2025-02-04_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502040125
X-Proofpoint-GUID: 9qjd4vI5JD03pxIKzGuuC6U5DfeHK-bz
X-Proofpoint-ORIG-GUID: 9qjd4vI5JD03pxIKzGuuC6U5DfeHK-bz
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

On 2/4/2025 9:39 AM, Cédric Le Goater wrote:
> On 1/29/25 15:43, Steve Sistare wrote:
>> Refactor vector use into a helper vfio_vector_init.
>> Add vfio_notifier_init and vfio_notifier_cleanup for named notifiers,
>> and pass additional arguments to vfio_remove_kvm_msi_virq.
>>
>> All for use by CPR in a subsequent patch.  No functional change.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   hw/vfio/pci.c | 106 +++++++++++++++++++++++++++++++++++++---------------------
>>   1 file changed, 68 insertions(+), 38 deletions(-)
>>
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index ab17a98..24ebd69 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -54,6 +54,32 @@ static void vfio_disable_interrupts(VFIOPCIDevice *vdev);
>>   static void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool enabled);
>>   static void vfio_msi_disable_common(VFIOPCIDevice *vdev);
>> +/* Create new or reuse existing eventfd */
>> +static int vfio_notifier_init(VFIOPCIDevice *vdev, EventNotifier *e,
>> +                              const char *name, int nr)
>> +{
>> +    int fd = -1;   /* placeholder until a subsequent patch */
>> +    int ret = 0;
>> +
>> +    if (fd >= 0) {
>> +        event_notifier_init_fd(e, fd);
> 
> Could you please first introduce the vfio_notifier_init() routine,
> which can me merged quickly, and then, in a subsequent patch, modify
> vfio_notifier_init() for CPR support.

OK.

>> +    } else {
>> +        ret = event_notifier_init(e, 0);
>> +        if (ret) {
>> +            Error *err = NULL;
>> +            error_setg_errno(&err, -ret, "vfio_notifier_init %s failed", name);
> 
> I don't think "name" is useful if the caller calls error_prepend() to
> extend the error message.

I don't follow.  The new code is strictly more informative than the old.
Some of the call sites before this patch printed generic messages such as
"event_notifier_init failed".  The new code identifies the notifier that
failed.

>> +            error_report_err(err);
> 
> Nope. We should propagate the error with 'Error **' parameter and return
> bool.

OK.  Some call sites will simply report that error, though.  And some ignore
errors.  I intend to be bug-for-bug compatible with the old code, and not
introduce new behaviors.

>> +        }
>> +    }
>> +    return ret;
>> +}
>> +
>> +static void vfio_notifier_cleanup(VFIOPCIDevice *vdev, EventNotifier *e,
>> +                                  const char *name, int nr)
> 
> That's a lot of unused parameters which should be introduces when required.

OK.

>> +{
>> +    event_notifier_cleanup(e);
>> +}
>> +
>>   /*
>>    * Disabling BAR mmaping can be slow, but toggling it around INTx can
>>    * also be a huge overhead.  We try to get the best of both worlds by
>> @@ -134,8 +160,8 @@ static bool vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
>>       pci_irq_deassert(&vdev->pdev);
>>       /* Get an eventfd for resample/unmask */
>> -    if (event_notifier_init(&vdev->intx.unmask, 0)) {
>> -        error_setg(errp, "event_notifier_init failed eoi");
>> +    if (vfio_notifier_init(vdev, &vdev->intx.unmask, "intx-unmask", 0)) {
>> +        error_setg(errp, "vfio_notifier_init intx-unmask failed");
>>           goto fail;
>>       }
>> @@ -167,7 +193,7 @@ fail_vfio:
>>       kvm_irqchip_remove_irqfd_notifier_gsi(kvm_state, &vdev->intx.interrupt,
>>                                             vdev->intx.route.irq);
>>   fail_irqfd:
>> -    event_notifier_cleanup(&vdev->intx.unmask);
>> +    vfio_notifier_cleanup(vdev, &vdev->intx.unmask, "intx-unmask", 0);
>>   fail:
>>       qemu_set_fd_handler(irq_fd, vfio_intx_interrupt, NULL, vdev);
>>       vfio_unmask_single_irqindex(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
>> @@ -199,7 +225,7 @@ static void vfio_intx_disable_kvm(VFIOPCIDevice *vdev)
>>       }
>>       /* We only need to close the eventfd for VFIO to cleanup the kernel side */
>> -    event_notifier_cleanup(&vdev->intx.unmask);
>> +    vfio_notifier_cleanup(vdev, &vdev->intx.unmask, "intx-unmask", 0);
>>       /* QEMU starts listening for interrupt events. */
>>       qemu_set_fd_handler(event_notifier_get_fd(&vdev->intx.interrupt),
>> @@ -266,7 +292,6 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
>>       uint8_t pin = vfio_pci_read_config(&vdev->pdev, PCI_INTERRUPT_PIN, 1);
>>       Error *err = NULL;
>>       int32_t fd;
>> -    int ret;
>>       if (!pin) {
>> @@ -289,9 +314,7 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
>>       }
>>   #endif
>> -    ret = event_notifier_init(&vdev->intx.interrupt, 0);
>> -    if (ret) {
>> -        error_setg_errno(errp, -ret, "event_notifier_init failed");
>> +    if (vfio_notifier_init(vdev, &vdev->intx.interrupt, "intx-interrupt", 0)) {
>>           return false;
>>       }
>>       fd = event_notifier_get_fd(&vdev->intx.interrupt);
>> @@ -300,7 +323,7 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
>>       if (!vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX, 0,
>>                                   VFIO_IRQ_SET_ACTION_TRIGGER, fd, errp)) {
>>           qemu_set_fd_handler(fd, NULL, NULL, vdev);
>> -        event_notifier_cleanup(&vdev->intx.interrupt);
>> +        vfio_notifier_cleanup(vdev, &vdev->intx.interrupt, "intx-interrupt", 0);
>>           return false;
>>       }
>> @@ -327,7 +350,7 @@ static void vfio_intx_disable(VFIOPCIDevice *vdev)
>>       fd = event_notifier_get_fd(&vdev->intx.interrupt);
>>       qemu_set_fd_handler(fd, NULL, NULL, vdev);
>> -    event_notifier_cleanup(&vdev->intx.interrupt);
>> +    vfio_notifier_cleanup(vdev, &vdev->intx.interrupt, "intx-interrupt", 0);
>>       vdev->interrupt = VFIO_INT_NONE;
>> @@ -471,13 +494,15 @@ static void vfio_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
>>                                                vector_n, &vdev->pdev);
>>   }
>> -static void vfio_connect_kvm_msi_virq(VFIOMSIVector *vector)
>> +static void vfio_connect_kvm_msi_virq(VFIOMSIVector *vector, int nr)
> 
> This change belongs to another patch.

OK.  It will be tiny, though -- add nr in the declaration and at 2 call sites.
It also runs counter to your advice above, which is do not add a parameter
until it is needed.

>>   {
>> +    const char *name = "kvm_interrupt";
>> +
>>       if (vector->virq < 0) {
>>           return;
>>       }
>> -    if (event_notifier_init(&vector->kvm_interrupt, 0)) {
>> +    if (vfio_notifier_init(vector->vdev, &vector->kvm_interrupt, name, nr)) {
>>           goto fail_notifier;
>>       }
>> @@ -489,19 +514,20 @@ static void vfio_connect_kvm_msi_virq(VFIOMSIVector *vector)
>>       return;
>>   fail_kvm:
>> -    event_notifier_cleanup(&vector->kvm_interrupt);
>> +    vfio_notifier_cleanup(vector->vdev, &vector->kvm_interrupt, name, nr);
>>   fail_notifier:
>>       kvm_irqchip_release_virq(kvm_state, vector->virq);
>>       vector->virq = -1;
>>   }
>> -static void vfio_remove_kvm_msi_virq(VFIOMSIVector *vector)
>> +static void vfio_remove_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
>> +                                     int nr)
>>   {
>>       kvm_irqchip_remove_irqfd_notifier_gsi(kvm_state, &vector->kvm_interrupt,
>>                                             vector->virq);
>>       kvm_irqchip_release_virq(kvm_state, vector->virq);
>>       vector->virq = -1;
>> -    event_notifier_cleanup(&vector->kvm_interrupt);
>> +    vfio_notifier_cleanup(vdev, &vector->kvm_interrupt, "kvm_interrupt", nr);
>>   }
>>   static void vfio_update_kvm_msi_virq(VFIOMSIVector *vector, MSIMessage msg,
>> @@ -511,6 +537,20 @@ static void vfio_update_kvm_msi_virq(VFIOMSIVector *vector, MSIMessage msg,
>>       kvm_irqchip_commit_routes(kvm_state);
>>   }
>> +static void vfio_vector_init(VFIOPCIDevice *vdev, int nr)
>> +{
>> +    VFIOMSIVector *vector = &vdev->msi_vectors[nr];
>> +    PCIDevice *pdev = &vdev->pdev;
>> +
>> +    vector->vdev = vdev;
>> +    vector->virq = -1;
>> +    vfio_notifier_init(vdev, &vector->interrupt, "interrupt", nr);
>> +    vector->use = true;
>> +    if (vdev->interrupt == VFIO_INT_MSIX) {
>> +        msix_vector_use(pdev, nr);
>> +    }
>> +}
> 
> This change belongs to another patch.

OK.

- Steve

>>   static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
>>                                      MSIMessage *msg, IOHandler *handler)
>>   {
>> @@ -524,13 +564,7 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
>>       vector = &vdev->msi_vectors[nr];
>>       if (!vector->use) {
>> -        vector->vdev = vdev;
>> -        vector->virq = -1;
>> -        if (event_notifier_init(&vector->interrupt, 0)) {
>> -            error_report("vfio: Error: event_notifier_init failed");
>> -        }
>> -        vector->use = true;
>> -        msix_vector_use(pdev, nr);
>> +        vfio_vector_init(vdev, nr);
>>       }
>>       qemu_set_fd_handler(event_notifier_get_fd(&vector->interrupt),
>> @@ -542,7 +576,7 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
>>        */
>>       if (vector->virq >= 0) {
>>           if (!msg) {
>> -            vfio_remove_kvm_msi_virq(vector);
>> +            vfio_remove_kvm_msi_virq(vdev, vector, nr);
>>           } else {
>>               vfio_update_kvm_msi_virq(vector, *msg, pdev);
>>           }
>> @@ -554,7 +588,7 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
>>                   vfio_route_change = kvm_irqchip_begin_route_changes(kvm_state);
>>                   vfio_add_kvm_msi_virq(vdev, vector, nr, true);
>>                   kvm_irqchip_commit_route_changes(&vfio_route_change);
>> -                vfio_connect_kvm_msi_virq(vector);
>> +                vfio_connect_kvm_msi_virq(vector, nr);
>>               }
>>           }
>>       }
>> @@ -661,7 +695,7 @@ static void vfio_commit_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
>>       kvm_irqchip_commit_route_changes(&vfio_route_change);
>>       for (i = 0; i < vdev->nr_vectors; i++) {
>> -        vfio_connect_kvm_msi_virq(&vdev->msi_vectors[i]);
>> +        vfio_connect_kvm_msi_virq(&vdev->msi_vectors[i], i);
>>       }
>>   }
>> @@ -741,9 +775,7 @@ retry:
>>           vector->virq = -1;
>>           vector->use = true;
>> -        if (event_notifier_init(&vector->interrupt, 0)) {
>> -            error_report("vfio: Error: event_notifier_init failed");
>> -        }
>> +        vfio_notifier_init(vdev, &vector->interrupt, "interrupt", i);
>>           qemu_set_fd_handler(event_notifier_get_fd(&vector->interrupt),
>>                               vfio_msi_interrupt, NULL, vector);
>> @@ -797,11 +829,11 @@ static void vfio_msi_disable_common(VFIOPCIDevice *vdev)
>>           VFIOMSIVector *vector = &vdev->msi_vectors[i];
>>           if (vdev->msi_vectors[i].use) {
>>               if (vector->virq >= 0) {
>> -                vfio_remove_kvm_msi_virq(vector);
>> +                vfio_remove_kvm_msi_virq(vdev, vector, i);
>>               }
>>               qemu_set_fd_handler(event_notifier_get_fd(&vector->interrupt),
>>                                   NULL, NULL, NULL);
>> -            event_notifier_cleanup(&vector->interrupt);
>> +            vfio_notifier_cleanup(vdev, &vector->interrupt, "interrupt", i);
>>           }
>>       }
>> @@ -2854,8 +2886,7 @@ static void vfio_register_err_notifier(VFIOPCIDevice *vdev)
>>           return;
>>       }
>> -    if (event_notifier_init(&vdev->err_notifier, 0)) {
>> -        error_report("vfio: Unable to init event notifier for error detection");
>> +    if (vfio_notifier_init(vdev, &vdev->err_notifier, "err_notifier", 0)) {
>>           vdev->pci_aer = false;
>>           return;
>>       }
>> @@ -2867,7 +2898,7 @@ static void vfio_register_err_notifier(VFIOPCIDevice *vdev)
>>                                   VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
>>           error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>>           qemu_set_fd_handler(fd, NULL, NULL, vdev);
>> -        event_notifier_cleanup(&vdev->err_notifier);
>> +        vfio_notifier_cleanup(vdev, &vdev->err_notifier, "err_notifier", 0);
>>           vdev->pci_aer = false;
>>       }
>>   }
>> @@ -2886,7 +2917,7 @@ static void vfio_unregister_err_notifier(VFIOPCIDevice *vdev)
>>       }
>>       qemu_set_fd_handler(event_notifier_get_fd(&vdev->err_notifier),
>>                           NULL, NULL, vdev);
>> -    event_notifier_cleanup(&vdev->err_notifier);
>> +    vfio_notifier_cleanup(vdev, &vdev->err_notifier, "err_notifier", 0);
>>   }
>>   static void vfio_req_notifier_handler(void *opaque)
>> @@ -2920,8 +2951,7 @@ static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
>>           return;
>>       }
>> -    if (event_notifier_init(&vdev->req_notifier, 0)) {
>> -        error_report("vfio: Unable to init event notifier for device request");
>> +    if (vfio_notifier_init(vdev, &vdev->req_notifier, "req_notifier", 0)) {
>>           return;
>>       }
>> @@ -2932,7 +2962,7 @@ static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
>>                                   VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
>>           error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>>           qemu_set_fd_handler(fd, NULL, NULL, vdev);
>> -        event_notifier_cleanup(&vdev->req_notifier);
>> +        vfio_notifier_cleanup(vdev, &vdev->req_notifier, "req_notifier", 0);
>>       } else {
>>           vdev->req_enabled = true;
>>       }
>> @@ -2952,7 +2982,7 @@ static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
>>       }
>>       qemu_set_fd_handler(event_notifier_get_fd(&vdev->req_notifier),
>>                           NULL, NULL, vdev);
>> -    event_notifier_cleanup(&vdev->req_notifier);
>> +    vfio_notifier_cleanup(vdev, &vdev->req_notifier, "req_notifier", 0);
>>       vdev->req_enabled = false;
>>   }
> 


