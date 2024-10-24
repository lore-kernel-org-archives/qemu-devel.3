Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DCDED10380
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 21:17:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t45CQ-0003LM-4n; Thu, 24 Oct 2024 17:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t45CN-0003Kp-Dx
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 17:16:51 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t45CK-0003zR-Sw
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 17:16:51 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49OLDqMe003056;
 Thu, 24 Oct 2024 21:16:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=OQfb5HKnSLJdJM9kW52JaUckt2nEB1+Tegtygs0Kthk=; b=
 lWvKuL7ZPZ/mMx7dbd2dQtxdFgMbZCDxcPn8X4FsQg2ZCAo6idap6AyP+QWAHZBT
 CtmXbStM9WagXlAqXfk5sru1JQPFlNrbwov+qiLJTH0ivRSDtziBMDZr8846wRvZ
 BU8lSm8o8KeKnyZTOkU2b+e7vlnb58R0NJOnX2t9Aw2ddLr8iFf0THOoFqGP5GUj
 kkuaB28EDMMxAsokohSNJr1x+fwCSWW25GYGGNAJmvIom1pcvfFhmRWe79PuvukY
 I6jBlgeOau+Gf4uoqoaaLnfrwCa7sCsVoG9p2ILY3pw/d2V432pTJwZESy/MSfr3
 k6kyCJopQocRs6BjmqGrXw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42ckkr2yg3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2024 21:16:43 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 49OJXhU3030987; Thu, 24 Oct 2024 21:16:42 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2049.outbound.protection.outlook.com [104.47.73.49])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 42emh3ha95-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2024 21:16:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SezMtsjQ2n/g+x36bY4lESau0LZnTFP4PWSJoekxd9fLhE3UYM5ua1vRJ+NG9K+RkvLvsQIMNq5HXu8qqJUEwPkdRdtABKiXHg3RhRvuUhult4zGCS0bju0dzxHLm5RydfjVK+h0Yo0MavQocKBhvK7aKpMpDAgYAh/rkevVSVsFGVbYC+T5C8FSvym+DSG+SBIWO9+/OatCJhtJ6z1NdNN7uJ7nHSe/Y9Opae8lvUdFr9daD2/WJ5Bmr/5FtryFNKVNVWzM1SRMs2pQ0TFCQC7NLSe4N7T95NNtd2yGH1Ga3CMh/cu08akN3OlU6HHDTRUQ520m1i96q+rC/mFqqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQfb5HKnSLJdJM9kW52JaUckt2nEB1+Tegtygs0Kthk=;
 b=tbrPIKbEuvKc6QeqVPN91e6+AtSmxbJZE1aVus0Zf3MHHI3mFMSapHVhoZJiP6mdI2C+vlWbWkZmmqrR31aIjm960lYqE2/htnzvEuo/MUyPHaJPyiLsPrUGu/nyIVmbcUG2fGORdO2aWr9rnQl5SufCg3fYlB2o8g5fNajpoQ/EEXuSG/8/Fr9khOAbAdigW6mNEtSCfOiJdaE1qhaAhG5seRgJH4WzHeLG1R2kaUk+05pL4UQkdmTuL9ASlhkKHb/heEzY9Pt3Cf/ILtD1YfbwPa6GCrPl91ZbTq2nRhIn0fWTTo/Yo73XifuEelYoGzKqUnB7AgV8VGb/GZC1Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQfb5HKnSLJdJM9kW52JaUckt2nEB1+Tegtygs0Kthk=;
 b=m2exKanejkN50f81CRE+AbVRHT9/glV8A0s2sBzf+8nSWCXKASM3DxkrtogGvPcB5uZeUFUcO/aAIu/tNXS1H8N1ZD4acEnzntatkROAFpxtBtDGMV4Gs0wn0y3uIplGTIcWUQHZzK05c+Go1YU7YyNKN2GRfl2mI5pSU+ZmkwU=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by IA1PR10MB6759.namprd10.prod.outlook.com (2603:10b6:208:42d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.19; Thu, 24 Oct
 2024 21:16:35 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8069.027; Thu, 24 Oct 2024
 21:16:35 +0000
Message-ID: <fd8977f7-2787-4387-81fa-240665d0bf1d@oracle.com>
Date: Thu, 24 Oct 2024 17:16:14 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 00/14] precreate phase
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <1729178055-207271-1-git-send-email-steven.sistare@oracle.com>
 <b36283ff-2e14-4ee0-a64e-a5c4f9e86534@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <b36283ff-2e14-4ee0-a64e-a5c4f9e86534@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR04CA0041.namprd04.prod.outlook.com
 (2603:10b6:408:e8::16) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|IA1PR10MB6759:EE_
X-MS-Office365-Filtering-Correlation-Id: b2bdfa95-f478-45be-8972-08dcf4711881
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WnI1a0JqNkM5NFVEbHNlRk9QZWdGZzZsakNHVXNFNzVlajY1MTl4RVZFMk1x?=
 =?utf-8?B?bTRFZm9ObDhCNzFsQldBd2ZBYm5MM3MzVUlmNitJQWMxbHNCU2xVdDhWNThy?=
 =?utf-8?B?VzJjQlVVTysra3h4cXpzTk9OK2FPQ3Fma0RVOXN2RkQrWmI3Z0VUbTZzTFZm?=
 =?utf-8?B?MU5lc3k1WXJxZ2VEYjZNaXlnV2ZpdnlvUU41aWlEeEZlKzdzSGtwQkNac0Fk?=
 =?utf-8?B?YUlhM2lxZzIybG1rdGdqUlhYdklENGwySzVQWFBTb0ZwNmF3MndCREx5UmZh?=
 =?utf-8?B?S082bzVpcEU1ZmJSbkVaZEdwM2NPQVB4aGFRTnN0NnNrcllQdjUrdUxkZERC?=
 =?utf-8?B?bU50RnRXNklORWRzNTl6Nk92cksybTlSMU9lUmRXU2ZXQnJoOWk3MWlNcFdl?=
 =?utf-8?B?N0tXMStPSU5kNWZrOVcyZ0xsVWEvNVo0dnpwV3I5U2diRkRsMU85ZFlJcitv?=
 =?utf-8?B?TzJOemtNQnN6KzBaeDFVVW5oamdHOXQ0Qk5FSHc3VTYvOU5hZXRkSjQ2KzZr?=
 =?utf-8?B?ZkY0aC9KVDhvejVhVXJqdFJwWWdYdHRSU1RhaER1N0FOWmVzK3dEblE0SDBZ?=
 =?utf-8?B?VlpCMFgwc1orNXZoUUoydCtmRkNwMTRza2J0RlFSUkM5YnZsR2tjWTI2L3FI?=
 =?utf-8?B?R0tOVHB6NHQxcHRxYTFHQXpNUDAyL3pVcnVjREErRE9jMk50RlVqZ1hmSUpV?=
 =?utf-8?B?b2lEVkVLWmJDL0pTUUNaekw2U0U4MjlSTzIvMklveFZPSmkxQy9TaVNPZmkv?=
 =?utf-8?B?anlkdWgwRTcvcGJ6ei9PN2Q2V28zdUZLbFZkWDhxOEpRMUF0V0Y5bUZtaHNz?=
 =?utf-8?B?eHdPeTIyM3U1U24wZDNZZWxqQ2dFSXJlUldtSXJES3k4REJVQi9sbGx4cEFW?=
 =?utf-8?B?Tm9VeDl5anhoZmJvRDluUFp2c1pTTXVhbkhJNlBhZVp3UVdSWFpkVTRndDRQ?=
 =?utf-8?B?SjZTRFViNVNqVXA3L3lkYzVNUkUrOU5GQlQrYzkzTzRFOUFUbWdVc0hIWHBQ?=
 =?utf-8?B?MFpucFl5OVlwQjVBcFRkQzV6TEh4bnl6aGE5d2NmNGt0RGd1T0dXOEFVN3A4?=
 =?utf-8?B?MWU1TXJsV3lqSlJ0WmUvT0Qvc3NIWU5vWXh0VGlyd2U0R0IxODhoTDNUVGw1?=
 =?utf-8?B?SWpDdHFERjFucHhlNy9KSWR5dmc3VnFNelpSMFhBWmZ0RFdYbkk3ZmVoWFp4?=
 =?utf-8?B?d0hDL3hUakI1NUR0akVjUVREZDNXMmpBUmFkaGxuY0JWbS9aRWRvSEt3Tjd6?=
 =?utf-8?B?YzA1VGc2ZitNTDNuOUtEYTZkWTYyVHRQNGdrVUQxYitqMmIwM3N6TC81VkxK?=
 =?utf-8?B?V3R4UkJYWlF5bHJRcm5EK0JYbSt6Zkc4NTZRdDlDeGpRRTVxZzZNRXhlTlpl?=
 =?utf-8?B?dm8wVHBvdngyRGZUQVBMY0RkOTk2N3QyN3FMa3h1QkhlZm9kL3pBaVdZdkx0?=
 =?utf-8?B?TGI1STAwb3ppRjNaTjk0K05TVjRmSlRQcU1veW9GSVBmanozbllWZmFPUUx3?=
 =?utf-8?B?YnNHcG9Rayt2cmxvdjhHSVFmQnF2emdvbkV1eUU0UGlDY2h0c0ZPQWcyZUly?=
 =?utf-8?B?bkhPc3lua2tJaTdqMVM4NzR0YWt5WmltN2dtOGc0SHVxdXFlRDNkbTEvS2hw?=
 =?utf-8?B?THZja2xtRjdpQ2k0TXpjckVBWFFnOGpLUWNjNzNqNDFjUTJiblBXbnRDcWtM?=
 =?utf-8?B?YW9YVUxUcXpyNGMwanFzQW9SY3o4cG93Vmx4dDdzeUdhd2VVajI4TUhvREdC?=
 =?utf-8?Q?oxlQJqvQPUH/tfZxx0u2p8aRn9DjroIuliwwBLn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OW1hQXpmU1NEdlFRZkVaaWJobDl3NGNuQVpqYkViUTN3YSt3TThqRXNTOUdC?=
 =?utf-8?B?ZEFjdUgrd2JEdlZ4VGkvQmp1RllVN1VZQm44TUg5aWFxbmdXbVAxQ214cnli?=
 =?utf-8?B?ZVkxOS9XVDFvVm5HSS9XVTZUNGhQdUVhd1NFS0RVU0VSSVg1WHJqNExwMkQx?=
 =?utf-8?B?WUYxS3Zxc1REeXFCWGdXcmUxL1VVSDBhb05ESThlc1lLZXhzbmczL2VaTVFU?=
 =?utf-8?B?cXpNNWFVNjhTaUZBRFpaZk1kQ045TVRjcTIycXdiRGxILzhEOFFyOHRNVkxL?=
 =?utf-8?B?SkZCd1pmRTRZMEZtRWt2WHIvaE5QT1ZPUkhJNW9xdEtDdGZOdlB5ZytxUkFR?=
 =?utf-8?B?M0xHdzIwYnp2YzdhVFFYSjFrV29UekduUmNHMGtjdGhrUGN6N3hSRTdzTGM5?=
 =?utf-8?B?RTFrbkpyZWF1TXVKTmVyRlNCVldIbDkzRDZ0NEtSbFg2d0VOaFJPSTEzbE9W?=
 =?utf-8?B?MFdJTXRXTEVyVWpNMFNBNkhGUUlJcE9nR29CbHlBejNlRlBEZE9yMXJSdFJj?=
 =?utf-8?B?bFNnSmJIbS9oczRPQW01NmREWHorMzRwOXRMTVUxWTNQL0ZScXd5eFFvN2ZG?=
 =?utf-8?B?L2Y1am94V0V3cTlnMTZEdzl3MVlUbElTSmFuU200b29RVUJ0cE5QSE9waC9M?=
 =?utf-8?B?aVpzYUVjNFVWMFZWVzQ0RHRtcFM4QXJBaHhuWDI3RjRaUk9vcFJDVTBNS1JT?=
 =?utf-8?B?VDhBV0JBcld0Q01IMmQzRytTVzRkTS8xWURYZGtJckRrSk16Q0JabFdwcloy?=
 =?utf-8?B?WndwcU1NVmJUUmd3RHc1T2RoaFhSWjE5YVVoeitVRE9GRUVoOXhZUCtnNmMw?=
 =?utf-8?B?MTlaSXNhUjV0U0t0Y0orU3RHcFQxcGZyWFIxVkYrbythQTZRQ1phZVptM1Uw?=
 =?utf-8?B?NkFlTlZ6TXU4SG5OUnoyTlhYNHZNUTNmeGFqVlVUTWZYNWdwc3czYjNXY1RT?=
 =?utf-8?B?RDRlOHVKNE5idnR2WllIRFEvVXM1aGdzdzcyUGxXSm1adzFSWFNYOHZ6Qnhi?=
 =?utf-8?B?elFNOWFhV29YNlYwZWJIVDN2TldOTnU4NGYyb0lmZ2JUdEhrL1VTKzdaQzR5?=
 =?utf-8?B?M3V1c1N2L0FrdERyUTlIM2ZNYW93TEdPRUJhYUFiTVdnaDVocHV3WW1hS1Jk?=
 =?utf-8?B?VW1jcmNuUzJwb2kvalN1MXBWY01obDNEYVAxZ1NMT05EY1grUWVtOGFqd3hJ?=
 =?utf-8?B?eXllL3JkMUo5RlpnNjBtRXY3Z2p0WjcrUGptbWN3SkpiTHBzbEI3NVlxZFlM?=
 =?utf-8?B?SFlLOGlSSHg2Nnp1elRRc3hhR1dtaGNqYmhROWx3elp2Nkt6M0JEZno1bzdr?=
 =?utf-8?B?TlRuVEFVdlVqNE5JQTRkREl0RGdrWUtTN1oxNmM1RVRJOEJJc0hEbFo5UEJT?=
 =?utf-8?B?aXlhSjV4OGhKbTZuOUYybWQxK2JnS3JaYUgxUTJMOURVLzA3S2VDeUw0Um8z?=
 =?utf-8?B?aFRwL3FpSkppblBaQm9PN053N0tIaDc4MFl5UEFiTEFrTDNnNENKNkJJZnlV?=
 =?utf-8?B?bk14NkxDUGxPWjVZSGFyRWRDYTdZc2J4ZVFnVzNaQjZaL1dPTndTZ0xNRlMx?=
 =?utf-8?B?L3dOREI5eThkUEdtRGpWU2tJbUdjcGZtZ2RUREtYTFJjRmYrZDhqMFoxcHNl?=
 =?utf-8?B?VVBsc2YzbkRZMXNkbFR2ZkhibE1id0NOaUVkTjNXV1E5QlNrc2FBT1JJN3pC?=
 =?utf-8?B?cHRFckhhNy9TZkJqb1ZYY3h4MnhBMVprRWtoVEdPcWZoclZTcHZDWnV0OFk3?=
 =?utf-8?B?OXJHbUI1dSszK2lmeC85SWFVOWJOenNjY0VKbElWcGM2ZThOa2FBTC8vWUpu?=
 =?utf-8?B?b1d3cEhQbWE4MUVoRFl5d0JzSWIrSVFrNmREd083cS9iUWN6S3VjRnkyaURM?=
 =?utf-8?B?SVhPKzYySHBCanJIS2dvR3V6ZU9DSFM2Y0lvN3czQ2JDcGVZVWlQRDZZaWxE?=
 =?utf-8?B?NHdOTkEzcE41dEpPREk1Ym56RUFDQmpqaHlBWllLNE1ma1dUdkl1OGp5WGRv?=
 =?utf-8?B?K1dvOXZsbWwvbXlpS1VvM1FYTUFFcmR5UEwvU293WHpuR0tIdHBnZmo0eWJu?=
 =?utf-8?B?bzdWUTZyVnNIN29VWUZ3TTI2SzdQL0MxKzZldU1QMlFRM1FkU2JrLy9MSW1i?=
 =?utf-8?B?Nlc4TEk5Z3M2YW56U1ZXTTNLZHhHTzFUWDN6SzBtRFl0amJ6dnhYbEpleEpz?=
 =?utf-8?B?d0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YhiU/LpG/xsjgP18P9U1GMd/sHrlIteduqeypizJT1Nmqp3D9FZTLRPVjrtTiQL5llicCYdMDBB78PsZ47+gee5YLDaQ9xSWAZroNdLAVJfOyYFCj7xySayiNjL/smLkEzi1OzwGNvMP9QtEDF7RaYUC2Ao+1YZDX30tyg0/2WstcUyy1K56H5sIJQsnT74DXZLwPmPYBCOmQKuo2KAqLyObDCpRkLd+qME9knYDZ66O6KSohJmVWuj7XoaUM8hZgFurgWgumqAoMd6G8a7GnkNBfySBlDudCveRt0aLdT9txUy9Ub/8o0pHfksMFaZKtR0TV5DHrCqeJecGOh3AoOGDSqKl7XdKlfgW+kgyar2GLJLKeFTpq/r5c+VuSpG7nQiE1G6Fz1B2sEsgImiyNNsE5tTp/N8rWhPkJVXp5LGP+BvJY6PaDjeq6pINeiO2DIcTZ/46sBOS+7ByGHH2zv/XymQUOa6ruT/boymJ3mp58Wcv1vWCf7A9Me+0A4FHW5UVd/JiuRGDkH1FFv+AL+wWoKbqzcwAFcKGcB+Xl2oE9e/sZWnO9BzrTrojfHiW/w3qL+7OyiWLgAWQFUYLxEgc9MJCt4eW5ko47z1FZto=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2bdfa95-f478-45be-8972-08dcf4711881
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 21:16:35.0153 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yz/iiDegw9E7j7EO4a1lCLE2jwsUDnqnO5W1/rO8+6/KcmSWvc90Mnio7EnnKD4FhO/QOabdnwJBzOuDA1uaDvrB/+61cjXNuX6/4nGdyl8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6759
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-24_19,2024-10-24_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 phishscore=0 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410240173
X-Proofpoint-GUID: yo804LJxLAEkz0KUgWJivLsfkHMEzGSB
X-Proofpoint-ORIG-GUID: yo804LJxLAEkz0KUgWJivLsfkHMEzGSB
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/23/2024 12:31 PM, Paolo Bonzini wrote:
> On 10/17/24 17:14, Steve Sistare wrote:
>> Define a new qemu initialization phase called 'precreate' which occurs
>> before most backends or devices have been created.  The only exception
>> is monitor and qtest devices and their associated chardevs.
>>
>> QEMU runs in the main loop during this phase.  Monitor connections are
>> active and can receive migration configuration commands.  QEMU starts
>> listening on the normal migration URI during this phase, which can come
>> from either the QEMU command line or from a migrate_incoming command.
>> Thus the user can issue query-migrate to get the socket-address for
>> dynamically allocated port numbers during precreate.
>>
>> In this series QEMU passes through and does not linger in the precreate
>> phase, and the user sees no change in behavior.  The cpr-transfer series
>> will linger in the phase for an incoming CPR operation, and exit the phase
>> when the migrate command is send to source QEMU and causes destination QEMU
>> to read CPR state.
>>
>> A future series may wish to add a command-line argument and monitor
>> command that enters and exits the precreate phase for general purpose use.
>> That would enable the user to issue monitor commands that specify backend
>> creation parameters.
> 
> I have a problem with the concept, which is that the split between command line and monitor is much harder to understand.
> 
> Ideally, one would come entirely before the other; preconfig is already ugly in how -device is processed later than everything else[1].  This series makes this much more complex.
> 
> If I understand correctly, what you want is effectively to execute monitor commands from the migration stream.  If you want to do that, we need to take more qemu_init code and turn it into QMP commands, so that precreate can exit qemu_init very early and the "after precreate" command line options can be replaced by interactions on the monitor.
> 
> This is the idea that drove the creation of -M smp.xxx, -M boot.xxx, -M memory.xxx, etc. (see for example commit 8c4da4b5218, "machine: add boot compound property", 2022-05-12).  For example -semihosting-config, -acpitable, -smbios, -fw_cfg, -option-rom, -rtc could all become -M properties and handled by a single monitor command machine-set.
> 
> Of all the other options, -accel, -cpu and -display are the main missing ones (-cpu is the very hard one); a full list is at https://wiki.qemu.org/User:Paolo_Bonzini/Machine_init_sequence#QMP_configuration_flow.
> 
> Anyhow, at this point all that's needed is a -chardev/-mon pair (and I guess -incoming defer) in order to bootstrap the monitor in precreate mode.
> 
> It's okay to prototype without full support for the options I've listed, but if we want to go with precreate we should make most command line options entirely incompatible with it, and also make it imply -nodefaults.
> 
> Paolo
> 
> [1] -loadvm and -incoming too; but for those two we could make their monitor commands exit preconfig mode automatically, and invoke them from the monitor instead of specifying them on the command line.

Regarding: "what you want is effectively to execute monitor commands
from the migration stream"

That is not the goal of this series.  It could be someone else's goal, when
fully developing a precreate phase, and in that context I understand and
agree with your comments.  I have a narrower immediate problem to solve,
however.

For CPR, src qemu sends file descriptors to dst qemu using SCM_RIGHTS over
a dedicated channel, then src qemu sends migration state over the normal
migration channel.

Dst qemu reads the fds early, then calls the backend and device creation
functions which use them.  Dst qemu then accepts and reads the migration
channel.

We need a way to send monitor commands that set dst migration capabilities,
before src qemu starts the migration.  Hence the dst cannot proceed to
backend and device creation because the src has not sent fd's yet.  Hence
we need a dst monitor before device creation.  The precreate phase does that.

Regarding: "This series makes this much more complex."

I could simplify it if I abandon CPR for chardevs.  Then qemu_create_early_backends
and other early dependencies can remain as is.  I would drop the notion of
a precreate phase, and instead leverage the preconfig phase.  I would move
qemu_create_late_backends, and a small part at the end of qemu_init, to
qmp_x_exit_preconfig.

These patches from the series (slightly renamed) would suffice.
The "move preconfig boundary" patch is new.

   * migration: init and listen during preconfig
   * vl: move preconfig boundary
   * monitor: connect in preconfig
   * net: cleanup for preconfig phase
   * migration: allow commands during preconfig

Would you consider supporting that?

- Steve


