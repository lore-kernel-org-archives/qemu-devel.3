Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2579AC5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 20:48:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOjP4-0002lo-9g; Mon, 09 Jun 2025 16:47:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uOjOz-0002lH-Kt
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 16:47:29 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uOjOu-0003V5-A6
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 16:47:26 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 559FcPRe018914;
 Mon, 9 Jun 2025 20:47:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=pZ/7QJ9rskaZSRN49gE/Qg3TAVMARQzjSKbGJDP3HDQ=; b=
 hpkFUIpaZZTUUMU3YsoJ622/qU8L72xqkOO2HnwYP7JGJr273OoeFajLD43Nx5mt
 dGzDmZRmkkxEwEuRGoYQCfXXLVh6Ta3Ub1a7LsEnd97InxC3oxYNr9TraUY1y/Rt
 ypl4CP5Z/oaeCihPxGDb2zcDAm7Ht0ouQkQWPIT2zEwcHs2MBEWinxvlM7JUg2EF
 GbRGTgezclt3WZ+Jo1xOaRyd9+tM1OurpZV3ik4a7brWt8Lvqv/82Z8THFIGsWor
 YZlbWlsQZoSlLsEx3PiHRV2ABOPKxfU3FYRgEaV6Y58Z5R2iOCCbA4wTXnzBBXHR
 209CJ7uk5SLM5BRn547W6Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474c74tyyr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 09 Jun 2025 20:47:20 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 559JZM24020262; Mon, 9 Jun 2025 20:47:19 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11012054.outbound.protection.outlook.com
 [40.107.200.54])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 474bve56q2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 09 Jun 2025 20:47:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vBZA5ybBYK1dPhBVVTOJWtsHq1pAqpp+VLoBiyzFpjEcmjXl+L+QEK+QjBlEOPH46MT+Cq68V/ctAlx9sx+saWdvNHaop5XQ4bUuCL53cT8MJT4rsV0qZtXjjv6hfa/3jW+3cW5agXJGcuKudRNRk1Daff2yBNGy/ZuImW4SgStqO+Iy5zsLxlock3c1h4Ii2B08w0j9GpNlm4mbtiL/JyH/4YGLm2BE7Llxzuzwa8a937sH8vfqJq7sLyAiGMVTUG77q8zN8sySjAXJ6vsVnidjhyacmYjBpPjRT4p5dQ6cgFU5ErDAOYT2kS9JlZi8IPyq2ON4FPFP1664BgXm8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZ/7QJ9rskaZSRN49gE/Qg3TAVMARQzjSKbGJDP3HDQ=;
 b=lpQGins4NR4l3EjDHY82aJHQ2wQ3wdw+8bDRgverSCChFNT8zsSgEdCbcS0Pbm7TdpBgqi57zqdCDJgtg1Tz1v0Ua9z9I7SwAtPwKAXSnmiPIP+Gm2u1Zw5qp6d5SkCNRzuwjFqbW8ZnuN453hrTOAutV69OMAo3I9he4q6Ux2ZezJhq3g9PYWzh/d1ePpKiTmPnZKk6u+hr7hAhM5kbESgE/nSVF12TKUTzCYB9v1NGCh2mK3bMRqGcWbiEOCpdzIegXR/IkU+wWNGQ0bDho42zxB/LVpcPOuBh6NmnSmD++SPVqC7cwP6eko80pk4YQ+UKG+YH0klRYHVqCrwUIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZ/7QJ9rskaZSRN49gE/Qg3TAVMARQzjSKbGJDP3HDQ=;
 b=crm1OYBl6gb6qJOMr1bEA+KsKZIDGCgmGpGKaqYKrpvY7tifWh4y7+UkIZDmCMWANhKsyOODzHjhc+2uzsTeyFvNYxxBJmyvSnRDjKtBLaKCzDbkxLhcsTJy3FcTQtiFpf0e6r5o+MOD1tAHPaOYStkHcbOfiOuX1Slb7+PCo7E=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH7PR10MB5830.namprd10.prod.outlook.com (2603:10b6:510:127::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.27; Mon, 9 Jun
 2025 20:47:17 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 20:47:17 +0000
Message-ID: <a97f25cb-b543-44ad-b38d-76a086c55606@oracle.com>
Date: Mon, 9 Jun 2025 16:47:11 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 35/43] vfio/iommufd: register container for cpr
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
 <1748546679-154091-36-git-send-email-steven.sistare@oracle.com>
 <d94fc70b-2275-4c69-b163-6a3e3ff40f88@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <d94fc70b-2275-4c69-b163-6a3e3ff40f88@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR17CA0050.namprd17.prod.outlook.com
 (2603:10b6:a03:167::27) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH7PR10MB5830:EE_
X-MS-Office365-Filtering-Correlation-Id: 342facce-d5c1-49f6-56fb-08dda796d203
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SVI3TjVVMm9tRldTZ2tBaWNtd1lVcTVERGRPQk5nQkpzTUVDMU5BSnp2NWdp?=
 =?utf-8?B?TkhNMEhQVHhXYkc4NWtEV3VqTEZDemszdVExTG92L0dPVk8rUFh2NWhWZmds?=
 =?utf-8?B?ODQrN0VkYXRaQ2NMbGdQa3k1MWp5Mjh6R1VjNWhJSUFpa3FqV1dEekxuMnJN?=
 =?utf-8?B?VmRObHVLZkk1d0JJR3NDaTJWUGFWUUZDNlRUMVN0QlFuY3ZmbmQ3amozajFM?=
 =?utf-8?B?NkNnajI0dlJPM0dJYzJrYmRsT2NkZ1JqYTlVZlhWZDlTdlNUdDM3WkNCVXVZ?=
 =?utf-8?B?V0NmS0pJWFJVeUgxaVc5TGtIRDJMWmxRREcyR3R6d2JhdE81WUtxM1pJYkl0?=
 =?utf-8?B?VklUY25NQzhsQWJFNmtCUDdhTWlGdURaRjRadXdwMUJuN0gyVEJPNGE2ZWNv?=
 =?utf-8?B?c3pMSkxFckdkbDIvUzRrQXVVc0hySnZsYmRQd2kxL0prdlhQOG1CaCs5N0hk?=
 =?utf-8?B?cUN5YVpXVXhXZDBJR051Z1lGdlpBMnk3VXgxZU8zdE5CVUxKNlFBU0d5SkpP?=
 =?utf-8?B?TStCSWNwZ253V1RBM3A4VGVqelltbFBLbGdRWGVnN2VUZVRaWjRsbkk0djl1?=
 =?utf-8?B?RGlxWkNUalErVmZ6SnJVMDVFSkZheDdYc3l1bWhTOHEvc3lYS0tIMEFUVlNM?=
 =?utf-8?B?Y0d0ZFlpbVhNOFg2Q0EwSXZWTDQxN2ExbldrL09CK3RDaGJxNVFsdkZhNlhS?=
 =?utf-8?B?ak12TzErMndFeFlBVGhYc2txVnJ4RmxoNXNMOVlIZ0NrRERjVXIwKzRoVlQz?=
 =?utf-8?B?WWFWTkxTQUF2R0s5TDAzL0NZSnljZ2QwL0Q2TzhhRHJIWCtCc0NXMDN0ZElL?=
 =?utf-8?B?T0V2SHV2SFBVTzYvVFUrQ0prN3I2Y3pSOXRRbCtJODFDRzlyeHlKWGZzRTdy?=
 =?utf-8?B?QTllOGpWcFJTemNjSDFCWUdWRjBFRlZDbFVMVWhMSVc0bEpzczV4bVFJMnBL?=
 =?utf-8?B?NHdkT2ErRnVSVnBMUkpMMDQvVzBXY2t4Uk5XWGxuM0xIQ1NMd2ErY0lrbmlS?=
 =?utf-8?B?QkV3WU5kTkllVXNlRFplbG53emViQkdxdzJuYmxmb1VOYkR3VU9rcHQrK1J5?=
 =?utf-8?B?UTZYM0V3MmZhSUJCRlBzdHBaVnJYNXZHdW5Ea0RUeC9vaGd2VzhncUlTVzZ3?=
 =?utf-8?B?bC94aWxndTdya0pOUVgyQ2I4UTl5UGl6NzZVOXQ3Q0xKa3JoMEd0ckNIcUhz?=
 =?utf-8?B?MUE2TmkrQTBreVF0QTZ1dDl6Qzg1eS9ZVXNjZE5oTmJQcWpGUnBRSGFET05l?=
 =?utf-8?B?NVZxRmc1aDRXS3lENytiL2I2bCtiU2I3elRYRldSbWZ0a0VnYWYxR2dTa0tF?=
 =?utf-8?B?TTBpSkNBd0QrMGc5andUZEVpV0twSHg1dG43YW50anR4WDQxelBhZnpobGNV?=
 =?utf-8?B?REhUTWYxaTRzOFZkZjFpdnJwL2dhaDFPMWVTd09OV3hWdUhrd3p4OWRqakg1?=
 =?utf-8?B?UHFud1RoYmhWRXBTMnZMQXRZaFllOWowRkNZYVRhUjMyaXFLTXdiSCtxdEF5?=
 =?utf-8?B?RkI4K3gwNi9ENVhkR2N0VG1CVlZFNEh3ZFNRVWY2ZmZwR2I2TmZwbzVDZFFJ?=
 =?utf-8?B?Qnk1MUk3aXNjL0x2UkgwUHhVemdUMGtScDk0NHJsdmhLUHNiSmpFOWZNcU0y?=
 =?utf-8?B?b1JObnBjUkRFdHZaVnVUem1rdFdzZEd4bUZOMkd5V2VGdmxSM09yWXhQNUV4?=
 =?utf-8?B?UU9qbkRiL2RTTjgrVVRpR0NLUVByd2Y2b2FGV0h0cHJuUlkvVTJudVJlK0w0?=
 =?utf-8?B?VnNkM2J6anJFdEpWaVdyQ3VnMkx6bXF2Z29MUGRmakFEeXBCOUpJR0JVNFZm?=
 =?utf-8?B?OXJ0MVdYSE55V2ZMQUFYczNNOHJMNXVsMFBsVnFVb21RNEpxNDBKSHlkZk84?=
 =?utf-8?B?SlBvN2hOdjRUNnRVSnpTYjE4RldBa0doZGJ1ZENaMkZKWmR3OE9YbGo0elBn?=
 =?utf-8?Q?vdY8XF8vMSM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0Uva1FNNjhicWxmaEVIVkpNMnJyd2hVQ3pmaHJPbk5WeEg0TTBvdGw1SXVq?=
 =?utf-8?B?UFBXbkk4VE12TmpNMVNDTXdWVUhVSEM3aDhpZkYyUExSdDVXM3dqMktQSzBU?=
 =?utf-8?B?RWZGamRWTUR1OEhidmdMaVJLVGlmU1ZvU2xMQlNaaWQ1NUJ0NXBEVjFLWjdY?=
 =?utf-8?B?VDZOMWpMRFRvY1IzcU9scFlGWU1sWlJOV1plRS9ERkZiTzdnQjdyR0wwN05t?=
 =?utf-8?B?WTJXTytIRUNkMVowYy9Rb0J4Z2tucGZNQ3RXSENtR0ZSUW9HNnAzbndDRzJ1?=
 =?utf-8?B?Skx4N2VJcXEzd0g2N09oM2EzMFNoR0JoUEQyUlBRRzdHT2lBZUE5c3RpVy9y?=
 =?utf-8?B?U2pxQnZyNG9pZFFkWEowbGJWc0RzRTRobWRVc3ZscDVUWjM5U2FaVjNlTG5w?=
 =?utf-8?B?WDlOT2VRNnkrQ1JHWFlLRllEMTdkTEM1ckxRZW1tcUJTSkZYQUgzaWdRK052?=
 =?utf-8?B?NmdsVjNSb2ZldXJ5OExVdDZpRm50c1d1aUJVQjRZUWlsWkVxOUxmbVVRY1Rk?=
 =?utf-8?B?UENOc1Rnb3NaZUtUcmY1K252RE1VZWplZmlFaDhxY2FwVzFRdlE3T0p1T0pX?=
 =?utf-8?B?cmZRVklZUnJmOWpJSUJORnBVbHFXQ3JaRXpvaUpwRGV4UFREYjRGOW43Q2gx?=
 =?utf-8?B?a0lxaXhVNDRDU1FzZ1p1eUlUMEhDQmdIVWZzNkRBdlpkeG1TNGs5dUNwbk1n?=
 =?utf-8?B?TjFUdmlFa1hoakJJSXR2clNQbjlicjV4Nit1b1U0aFVUVWtjRXloN053SXUv?=
 =?utf-8?B?WEZ0dTBNdnFReFEvdWpwYzFsTGxvWWxQM1lLSC9FaDJDcnNUeVFkT2xrSjVL?=
 =?utf-8?B?cGt2UXJ6SENCajl6ZXBuMllNc3daS3BpNCtXd3E1cE1JOWVnUkMwTWhTNzlT?=
 =?utf-8?B?VGVpNW05WHdsS2R3SUtMNHdubWpyY0gvZmgxSnZoUWowaUNyMzZkM2dUVFo3?=
 =?utf-8?B?TG56dUhZZ0Z0dkNxcXJYVE81bEZDMVJnM3NwcC8zMUdhTzNGekc4QVFnYUJT?=
 =?utf-8?B?dGdzMCtCc0pPYmRTNndhclNaaFFHWXZ6WTVmMG9QbC82d2hLM1lkMm5FZ3Ra?=
 =?utf-8?B?YjZ0TGFhNGVPVFU0QlNBM2xjUFFmblJPZW1YR1grUlpubGJPUEdqK09Pdktv?=
 =?utf-8?B?ampCQW9IcmtoNHFtWmgxRk4xV29udkdpUyt4RVh2eEtDQXB0eElnWC90eUww?=
 =?utf-8?B?VGhwSm44T042ZWdBWlU5cGo1eGt3OUcrTnQzQzBKSi9qd3VQUHEydFo3clpM?=
 =?utf-8?B?dFhUQkJKdjZsR3lCQTdBK3VWK20wVTB3M050TFIrR2FnMDZDaUJTSkZ6MVV1?=
 =?utf-8?B?M2w4Qk1hQjhVOHhTcnJwdXZYUFl4SWVoTmRmL3h3QWNzaWQyMG9xNWduYTIr?=
 =?utf-8?B?a2dXVGFnQkFQOFdsUHc2RWs2Z3V3dWtNczBkUUp1Y2NHOTJiWloranRRZ0VQ?=
 =?utf-8?B?RE5DWnIzOGhYenlNOFIvL2cwQ01sUVFKSUx0VXI1ZmlDeVpIbVFCQXZKNXJp?=
 =?utf-8?B?TzMvTXAvLzBhNFRtblVORmVDMWRMbytyOVl4enlEQ3plSTFwdVNUTTBGOWRH?=
 =?utf-8?B?Zlo3ZUdaTUV6N1NVYmlreElGOUJ3b0FBR3ZzNkV4dEpNem1Ka0Q0TWsyaUJ2?=
 =?utf-8?B?QkVPbGlCVDZ5ckpGaWdXK1c1MkVSMGJCY3pPaWtCZ0FrNUpuZGlVSzNUeGFV?=
 =?utf-8?B?cTZWY3J4QmtvcmtmRFpOZEVOYVNjcWJiQS9mbFlINzVDWmFlZzJ0SmZSZkdv?=
 =?utf-8?B?RFE5bVQwZ2YxSUQ5azVDMGVLMyt4b0hkekZCOHp0Wk02U3ZUWlJzSTk1MVM1?=
 =?utf-8?B?Mmt4TU0rbEppMENzZWxCNWNpR3ZnMkgvaW1ySzdMSE4xUTFTY3lRSllrKzdE?=
 =?utf-8?B?TGg1ZVBJWWVRNk9zWU0vUDY3ZDJVSkNQVDB5WEpRRFBmYjhrNEJSeWdwTUQ4?=
 =?utf-8?B?b3Voam0yRkxNcWVYc1BDRDBBU3huT0NCQ0xqNkoyTDlha1pIS1gvd1lwNHhm?=
 =?utf-8?B?V09iU0VqZmszVFA0MFpySmJ0ZGFYdFIzc0puZ0xwUlVFZ1ZKdW84TnloandR?=
 =?utf-8?B?eHhhWXltNktLcm82d0Z3QXdEVEZDbnYwdXo1VnVrZDlNQnpTLzA0VTRwZWVr?=
 =?utf-8?B?T2tvSzAxS0dPOWt1Mk15em5ob0NuNDlmNXI1NVRsSVJ6TXFTYmtkeHd3aW12?=
 =?utf-8?B?NkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XFY93foxkTYcDJudKwKdJi/BajcZTvo1X/RMN+etsKAggFWyfafQEi0SzL4rIz4Ur8EfquicQmCvQSReB1Yb0qC2YqGRL3H6pdxT8m371Yft/dL5QTXLrzcBBhEyMPnCTglS0CC6fKFZmSNWQwoWjaZ30UllvxevJutuTtdlyHALhsgT3FBShrmnzcPE73Opq+FYWYHj9F9IOsJs8E9yctkrQNkTZUg/CEMlcYmC6+G6FOxSdc5B4ts77erMxhx9AjBlmZOlx9fViqcwp9imW8zVOJ04DPk9jtGG5JaktphpIEaPlD8/VwPwyvkx+Di+pCLmt4k7lSCdFsu4BvxMvnyaEu1oPctLQfKkTP+ta9CNiHTTLxhngZzQPnu4zF+j5Kiu6/o4BKqIyC4HnDFjh0asK1a89u02p+DXGiqZSf2Jc8XyKxxVAqHwf3cyqXtFoD6/7Tvv7f7K3p0Tj84DFmfdI8Dsz9EU8EbfrRdCxzjCKzRMu1xgWneaBE7DJ8LKJsSkHEVtN0xBYTYj815W7h52RRCIMwOV7H7F8m0d/UGjEDhptORtAKNMnBcHbAB7+xF4Vth6Qr7jMfBGwSfIDgC7n4xE1mrdXaBry3G2LBs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 342facce-d5c1-49f6-56fb-08dda796d203
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 20:47:16.9952 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dMVlRB8SW9rEXpYOnB2zLN4EyPHhb33PCHwHWYZcJzTMnPvO5YgItZ3UL4b8j+AhWnhDHDAQCldJe0JvfehLtn0i2wJ2FaFbr0Ml+dy/a2M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5830
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_08,2025-06-09_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 mlxlogscore=999
 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506090158
X-Authority-Analysis: v=2.4 cv=LIpmQIW9 c=1 sm=1 tr=0 ts=68474858 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=H5Zmno9YOv--405hJhQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13207
X-Proofpoint-ORIG-GUID: 6m6bpbYUwNtfgpGBbnvTxWVwSuyRz5M7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDE1OCBTYWx0ZWRfX4NZVmU463Srw
 GkpXAsHBnDnw+p5bZlHH3HwgeQdJKe+OD34eQ4ldc0cq+sasowMQIlcRYatFtAAjfTomJKPWhze
 rw6/PpCv1l7L8/yvHplkulUs+wOHYWpiYeEoHiuzxZ8YUrv1CmF32lG05SWrs9Q2K8xcZyAtSb6
 FmSUZSlojajFKQhQ0ClcSVVMbwq35iHUXjd4PkftLYKsOXyYHDuSMazCHIcLAB1TzjIWokwo7ZW
 wiG2+lZm7Mzd1h9eLbpR7ORakVMKoLNnAW4obyaiSnqdZOK08G0L7QjT8LJFr/Qh/MQfBEnkXFP
 JZz0KLfzojCuGxceldGsyNceTEAZ+w34rvZr7egnS2AkGg2yO/TpM9gaRNfie8Ixh2hd++Z3lGA
 66h3dcdDgkq/0pL8g3JQMcC03QOvkI7+rD+5qXIfnMFwv5LVKBZBjwJsKme8MguLxlXBgilA
X-Proofpoint-GUID: 6m6bpbYUwNtfgpGBbnvTxWVwSuyRz5M7
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

On 6/9/2025 4:30 PM, Cédric Le Goater wrote:
> On 5/29/25 21:24, Steve Sistare wrote:
>> Register a vfio iommufd container and device for CPR, replacing the generic
>> CPR register call with a more specific iommufd register call.  Add a
>> blocker if the kernel does not support IOMMU_IOAS_CHANGE_PROCESS.
>>
>> This is mostly boiler plate.  The fields to to saved and restored are added
>> in subsequent patches.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   include/hw/vfio/vfio-cpr.h | 12 +++++++
>>   include/system/iommufd.h   |  1 +
>>   backends/iommufd.c         | 10 ++++++
>>   hw/vfio/cpr-iommufd.c      | 84 ++++++++++++++++++++++++++++++++++++++++++++++
>>   hw/vfio/iommufd.c          |  6 ++--
>>   hw/vfio/meson.build        |  1 +
>>   6 files changed, 112 insertions(+), 2 deletions(-)
>>   create mode 100644 hw/vfio/cpr-iommufd.c
>>
>> diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
>> index 170a116..b9b77ae 100644
>> --- a/include/hw/vfio/vfio-cpr.h
>> +++ b/include/hw/vfio/vfio-cpr.h
>> @@ -15,7 +15,10 @@
>>   struct VFIOContainer;
>>   struct VFIOContainerBase;
>>   struct VFIOGroup;
>> +struct VFIODevice;
>>   struct VFIOPCIDevice;
>> +struct VFIOIOMMUFDContainer;
>> +struct IOMMUFDBackend;
>>   typedef struct VFIOContainerCPR {
>>       Error *blocker;
>> @@ -43,6 +46,15 @@ bool vfio_cpr_register_container(struct VFIOContainerBase *bcontainer,
>>                                    Error **errp);
>>   void vfio_cpr_unregister_container(struct VFIOContainerBase *bcontainer);
>> +bool vfio_iommufd_cpr_register_container(struct VFIOIOMMUFDContainer *container,
>> +                                         Error **errp);
>> +void vfio_iommufd_cpr_unregister_container(
>> +    struct VFIOIOMMUFDContainer *container);
>> +bool vfio_iommufd_cpr_register_iommufd(struct IOMMUFDBackend *be, Error **errp);
>> +void vfio_iommufd_cpr_unregister_iommufd(struct IOMMUFDBackend *be);
>> +void vfio_iommufd_cpr_register_device(struct VFIODevice *vbasedev);
>> +void vfio_iommufd_cpr_unregister_device(struct VFIODevice *vbasedev);
>> +
>>   int vfio_cpr_group_get_device_fd(int d, const char *name);
>>   bool vfio_cpr_container_match(struct VFIOContainer *container,
>> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
>> index db9ed53..3c58ea8 100644
>> --- a/include/system/iommufd.h
>> +++ b/include/system/iommufd.h
>> @@ -32,6 +32,7 @@ struct IOMMUFDBackend {
>>       /*< protected >*/
>>       int fd;            /* /dev/iommu file descriptor */
>>       bool owned;        /* is the /dev/iommu opened internally */
>> +    Error *cpr_blocker;/* set if be does not support CPR */
>>       uint32_t users;
>>       /*< public >*/
>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>> index ed8bb4c..2e9d6cb 100644
>> --- a/backends/iommufd.c
>> +++ b/backends/iommufd.c
>> @@ -108,6 +108,13 @@ bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp)
>>           }
>>           be->fd = fd;
>>       }
>> +    if (!be->users && !vfio_iommufd_cpr_register_iommufd(be, errp)) {
>> +        if (be->owned) {
>> +            close(be->fd);
>> +            be->fd = -1;
>> +        }
>> +        return false;
>> +    }
>>       be->users++;
>>       trace_iommufd_backend_connect(be->fd, be->owned, be->users);
>> @@ -125,6 +132,9 @@ void iommufd_backend_disconnect(IOMMUFDBackend *be)
>>           be->fd = -1;
>>       }
>>   out:
>> +    if (!be->users) {
>> +        vfio_iommufd_cpr_unregister_iommufd(be);
>> +    }
>>       trace_iommufd_backend_disconnect(be->fd, be->users);
>>   }
>> diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
>> new file mode 100644
>> index 0000000..60bd7e8
>> --- /dev/null
>> +++ b/hw/vfio/cpr-iommufd.c
>> @@ -0,0 +1,84 @@
>> +/*
>> + * Copyright (c) 2024-2025 Oracle and/or its affiliates.
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qapi/error.h"
>> +#include "hw/vfio/vfio-cpr.h"
>> +#include "migration/blocker.h"
>> +#include "migration/cpr.h"
>> +#include "migration/migration.h"
>> +#include "migration/vmstate.h"
>> +#include "system/iommufd.h"
>> +#include "vfio-iommufd.h"
>> +
>> +static bool vfio_cpr_supported(IOMMUFDBackend *be, Error **errp)
>> +{
>> +    if (!iommufd_change_process_capable(be)) {
>> +        if (errp) {
>> +            error_setg(errp, "vfio iommufd backend does not support "
>> +                       "IOMMU_IOAS_CHANGE_PROCESS");
>> +        }
>> +        return false;
>> +    }
>> +    return true;
>> +}
>> +
>> +static const VMStateDescription iommufd_cpr_vmstate = {
>> +    .name = "iommufd",
>> +    .version_id = 0,
>> +    .minimum_version_id = 0,
>> +    .needed = cpr_incoming_needed,
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>> +bool vfio_iommufd_cpr_register_iommufd(IOMMUFDBackend *be, Error **errp)
>> +{
>> +    Error **cpr_blocker = &be->cpr_blocker;
>> +
>> +    if (!vfio_cpr_supported(be, cpr_blocker)) {
>> +        return migrate_add_blocker_modes(cpr_blocker, errp,
>> +                                         MIG_MODE_CPR_TRANSFER, -1) == 0;
>> +    }
>> +
>> +    vmstate_register(NULL, -1, &iommufd_cpr_vmstate, be);
>> +
>> +    return true;
>> +}
>> +
>> +void vfio_iommufd_cpr_unregister_iommufd(IOMMUFDBackend *be)
>> +{
>> +    vmstate_unregister(NULL, &iommufd_cpr_vmstate, be);
>> +    migrate_del_blocker(&be->cpr_blocker);
>> +}
>> +
>> +bool vfio_iommufd_cpr_register_container(VFIOIOMMUFDContainer *container,
>> +                                         Error **errp)
>> +{
>> +    VFIOContainerBase *bcontainer = &container->bcontainer;
>> +
>> +    migration_add_notifier_mode(&bcontainer->cpr_reboot_notifier,
>> +                                vfio_cpr_reboot_notifier,
>> +                                MIG_MODE_CPR_REBOOT);
>> +
>> +    return true;
>> +}
>> +
>> +void vfio_iommufd_cpr_unregister_container(VFIOIOMMUFDContainer *container)
>> +{
>> +    VFIOContainerBase *bcontainer = &container->bcontainer;
>> +
>> +    migration_remove_notifier(&bcontainer->cpr_reboot_notifier);
>> +}
>> +
>> +void vfio_iommufd_cpr_register_device(VFIODevice *vbasedev)
>> +{
>> +}
>> +
>> +void vfio_iommufd_cpr_unregister_device(VFIODevice *vbasedev)
>> +{
>> +}
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index ca00d08..c690c2c 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -446,7 +446,7 @@ static void iommufd_cdev_container_destroy(VFIOIOMMUFDContainer *container)
>>       if (!QLIST_EMPTY(&bcontainer->device_list)) {
>>           return;
>>       }
>> -    vfio_cpr_unregister_container(bcontainer);
>> +    vfio_iommufd_cpr_unregister_container(container);
>>       vfio_listener_unregister(bcontainer);
>>       iommufd_backend_free_id(container->be, container->ioas_id);
>>       object_unref(container);
>> @@ -592,7 +592,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>>           goto err_listener_register;
>>       }
>> -    if (!vfio_cpr_register_container(bcontainer, errp)) {
>> +    if (!vfio_iommufd_cpr_register_container(container, errp)) {
>>           goto err_listener_register;
>>       }
>> @@ -619,6 +619,7 @@ found_container:
>>       }
>>       vfio_device_prepare(vbasedev, bcontainer, &dev_info);
>> +    vfio_iommufd_cpr_register_device(vbasedev);
>>       trace_iommufd_cdev_device_info(vbasedev->name, devfd, vbasedev->num_irqs,
>>                                      vbasedev->num_regions, vbasedev->flags);
>> @@ -656,6 +657,7 @@ static void iommufd_cdev_detach(VFIODevice *vbasedev)
>>       iommufd_cdev_container_destroy(container);
>>       vfio_address_space_put(space);
>> +    vfio_iommufd_cpr_unregister_device(vbasedev);
>>       iommufd_cdev_unbind_and_disconnect(vbasedev);
>>       close(vbasedev->fd);
>>   }
>> diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
>> index 98134a7..12711fb 100644
>> --- a/hw/vfio/meson.build
>> +++ b/hw/vfio/meson.build
>> @@ -23,6 +23,7 @@ system_ss.add(when: 'CONFIG_VFIO_XGMAC', if_true: files('calxeda-xgmac.c'))
>>   system_ss.add(when: 'CONFIG_VFIO_AMD_XGBE', if_true: files('amd-xgbe.c'))
>>   system_ss.add(when: 'CONFIG_VFIO', if_true: files(
>>     'cpr.c',
>> +  'cpr-iommufd.c',
> 
> This file should be compiled under CONFIG_IOMMUFD.

Sure, will fix.
Tomorrow I plan to rebase to the lastest master, add this and the few other
comments that came up for V4, and send V5.  Sound OK?

- Steve


