Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E5AC3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 20:56:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sehVU-00062n-0X; Thu, 15 Aug 2024 16:55:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sehVP-00061s-QB
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 16:55:36 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sehVN-0005c1-EK
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 16:55:35 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47FJteOv027220;
 Thu, 15 Aug 2024 20:55:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=ciCon4RrkGi764WBLcIOWxNLb4Fec4wDJzFO+MijzIw=; b=
 e3q7wbDXGMI/bWXOqxd4Gg104luZjHeUPH7Yuw5CK2BTXZDgDu0JkccPDHuAAktF
 S1l6NlNbTZx/oE5aeC4OhxRcB8gapqsTxjT3gitJ6zmYVvHVFR8leqsFJilX4OlP
 RcTPgXU1Grg+IahxLjkARwvPAP3/kQViCrY17R34+0KIZe8wPShXX3AGzcID3XTp
 RugZxKnQHuqoNawkrCAQtEIJydRx6IT25Z7LWNtUuWGzcdUHpBIe3r12/ZS0Tfam
 1KW+JurKc0f/GVx0XXVX/i3SyHe2sERZ6shG0CJvAZlDulKVYU9mD+x8PERSWjX1
 gDru8GrXczlZiYLQjd+brw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40x039b7bw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 Aug 2024 20:55:29 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 47FJ0wSf020583; Thu, 15 Aug 2024 20:55:27 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40wxnj4fuk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 Aug 2024 20:55:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=abZEYfpUUlVvfBufWj5/ZjG/cjT8FrYmf7PbnXMmUvyTX2gq54H4ZMxt4wxJdk4Y+BX4WfN58K0JC/xGmmjQhy3o4GUeOXdF/dMhx19G0U8gvQQxxH16PP/ubnfeFAOP5vAVfGYLxh1yS4jTzpQQuMtI1P3FHXmiKGA/Wy0uNtlFpU9SfF75KzgUASSdDacbRAPSWEltER3Xd5ihUEGa0k8mQD9eFiUmRRrNG3E9EnhETTKEsqoeX2JcKZASVdQOI4r9e2qE7D/2rcuByaJYystLYzMV541ZrljGSB3+kWX/RFvYSr+E08U8pBWxfjG2V8g6ZJDzPv3JwTySS39nXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ciCon4RrkGi764WBLcIOWxNLb4Fec4wDJzFO+MijzIw=;
 b=joBfLp/cqRau+/hN6VbXWZDdC5nSR1+wHJC/KpuUzOmujOXXxE+DMgRTyR1O1AeYWAqI2hQZCNN3/03b1tlpUukp05CpimtV3v45eH2oUSM5NNsEP7cEByUR3UV9akVmXKbSzsfCWpyQ7sL+IoKKvMoIIqxxCteyKxGvVKgJ/7pHbQ5h1HLxROeEtQA1XS4MH1AmpExqlq2m7FjPveiA3nwkT3pLFxMUuzrmyTuVnLJZVx82jC0hWb8jjQfcelkc8gQz+haqAKylxqtShThRlf7SrknV+C+gml7DJvdyoVIWYoy6qy4l9LILKP5K1JnVI4P16aXYgM9DnI6X/U7jig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ciCon4RrkGi764WBLcIOWxNLb4Fec4wDJzFO+MijzIw=;
 b=ot2epvWqrBZC9JTFKvCkSSD2KWXQzWG8ozp9t3ZPycKGIBVfUTf7h8Xpjt9Q/ZwW0EgGcDjzqPcFtKbPhFOSZ9j+cF6cp3XBiu1/OQ22b3pZ3UL98VnTZOU8j77m32GJgOuSRvXQ1DYnKedCsCW2WyowUM9Ad7t3ILh6JPf47Ew=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DS0PR10MB6126.namprd10.prod.outlook.com (2603:10b6:8:c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.16; Thu, 15 Aug
 2024 20:55:25 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 20:55:25 +0000
Message-ID: <46b63356-9602-4fa2-9d31-186f5f85151f@oracle.com>
Date: Thu, 15 Aug 2024 16:55:20 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 00/11] Live update: cpr-exec
To: Peter Xu <peterx@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
 <Zpk7Mf2c7LiNV2xC@x1n> <ZrCi8DWCKFiBHQAQ@redhat.com>
 <5776f6b4-c55f-4e56-aac5-bee7e441ad15@oracle.com> <Zru4AaTmBIAGnyDr@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Zru4AaTmBIAGnyDr@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0029.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::42) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DS0PR10MB6126:EE_
X-MS-Office365-Filtering-Correlation-Id: 648b64cc-4952-4eae-a5ba-08dcbd6c9621
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M1RIelFRMjQrU29XK2FibTdXbWFnckdQR0VxMUpnNU5xaklWaENES3RLeXh3?=
 =?utf-8?B?aUJGcUlHN2dPd2piZmJBOW01aE51VG9Md1NVOXNBbzB6bkNQalo3VHFuSTB4?=
 =?utf-8?B?VzdORWo5WGloS2YrWk0vNzdLcDNMRkRKTTlka2c1SmtHajkvUnllbFB6Z2NM?=
 =?utf-8?B?dFBXV01xM3pZbHNvdGJIei8xam1MZnlJbnNvTW0yRkFPdmU5WFhQUVBHd1Rr?=
 =?utf-8?B?UjBpUDBTK1plazRYSnpjQml0S0k1T04ydmxnSW1zYloybG5MN09iNzdZMEM2?=
 =?utf-8?B?K2wyVFVTVG1BeE1qNDlmQjN0Z3BHcjZ0WllWbjNBRk5zUlZwU3dzYWtiM25w?=
 =?utf-8?B?SzA3LzRIVmhPQ2hDZnhiRVgwWWpRd2FjR1puWHRBSlYrOWJZVHdpWUdvRGhu?=
 =?utf-8?B?V0xyZ0pweE5acUZQcitLVlY4Vno0OGpadXVhZG90dXc2ZXcrejF3SFdraDNC?=
 =?utf-8?B?blJ6ZTBTRGxBanBoZ3AyMTIxcktZcll3Mkl6V0dZdW4rNE1kQzlVOExXbnI0?=
 =?utf-8?B?NlNjY0NoWjJkbEN4U2docjQwbTN5SmZXd3EvZWxxV3p2UXJ6cGFTVTU1Mkwz?=
 =?utf-8?B?UFJlN0d1L21UYk45WTNVc1E3aDJPbEw5RWRuSlBSazBWK2RrVDhPeWVvUjhQ?=
 =?utf-8?B?V2JCRHNTTXVIRU5JTFdZUE9kT1oyMWo3Qkc5ZXVib3duU3JQcUt6Y1VqRFpx?=
 =?utf-8?B?M1BDZ0xaS1ZNTSttaytHMk1zRUJHK3dxblkyTjIyKzJaeUhKb2Y1T0k5d0Zh?=
 =?utf-8?B?OGFjSWhYcjdQUStib3ZheWFnb285ZEpDZGlsbUNiQWNZS1JyNThpR1VnZFhJ?=
 =?utf-8?B?Z1JLQnNUQmhxbCsva2JZSmJJeTdZUnZtanF1QjluR014b1hxdkdCUjZQT3Ja?=
 =?utf-8?B?RW81eE16M2MwbnhGSUlTSjNVQjd0SUxTNG4wV0JKRTVscGFsWTFIaG43R0Zm?=
 =?utf-8?B?R2VSbFJ1ZUFQT00rUFJHNmEvQXVRTlNvOFhVR2JjZ04wc2dGOW1QQk10N0Jk?=
 =?utf-8?B?dG5VM2ZJMzB1NWJxRWh0RnZGRTVxbUdtVVBtbmkvVFV6R3g2aVBzelRjN21U?=
 =?utf-8?B?VDZOL1pRaWFtZE9zNmJHQ0hXMXJuOHBqMmk2RDBSdy9JRGdtYXd1MWs1bHNM?=
 =?utf-8?B?d1pMNUVUSXdkMkl6RlJqY21FY09SVkIyeTVQNEkxYTBnK3FQcUcwT29HNjBh?=
 =?utf-8?B?bmIyRytFV216clNxRS9KSlg1Q3paWkhvbU1UWUE1THpSQ1Z3eTh2WGZrT3FM?=
 =?utf-8?B?SGFadXl1VU1VcFk0QWhQZ1pUczlkeU1Qa25KbHd4ZTVjS2IwbnR5WXNOd2l2?=
 =?utf-8?B?cDBRZjFLRUtUTTlVc3NOL29mT1lyN085Q1ZsaWxkUmgwcVlNbU9GMllUQW1z?=
 =?utf-8?B?aFFlR1FUVVh6R25zODNhcUxQbElJMU40amRJOThsY2ZzK0dRN0czNHFLQ2tw?=
 =?utf-8?B?NHIweHJYYjYwcGgxUnlyUlFCalI3R05rbWpQMjhSeVFyckV5S2lPKzN0SU90?=
 =?utf-8?B?NEV2cThwbnNZS1NPK3V5TldpMjFGeU9oaWpDQ01VRE5oM1RDWEtqSDVFekdo?=
 =?utf-8?B?UlduVjVvK3Bpd29DSEY2cy95cWp3ZDBMYUc4WHVDejI1ZkFpRnUvdWlSZ2FX?=
 =?utf-8?B?aWZhcGkwM2xqMDhDSlgzMmNqSEs0RGY2Q2ZZcEVzdkNRb08rMzFnQU9lTTFK?=
 =?utf-8?B?akpBZWNPN2gyeGZWUk1wMXJla0I4T1QvL3VaMjFoT3owR0YxeHlUcCs4MktQ?=
 =?utf-8?B?UFBXVzBGNW5ISWlBaWl2VFlRY3hSa3JMbk9mRzJabi9OZVp2c1lETll3eFIx?=
 =?utf-8?B?amtLME1OZG5aZVI2ZXJYUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVhUNlZ1c1RpaWtrMFJKUFFSTXZxOGZPcTE0dkNkYzZldG9CQ2JFMyszclpJ?=
 =?utf-8?B?L1IzVE9ZcktEU0c1Q1BVTitFSElDU3BnN1hRVStwWXBPNHY0ZUk0RFNrYjhF?=
 =?utf-8?B?SHArTk96OFRxbDZTTHFKakg0eGNIZW9HT0tZRm05NGh3am9Sa1I4clowMmxn?=
 =?utf-8?B?R0Y1Z2hnSXBHcEZGUkJlRmNETWtVMEdxZ2pJeER6d3dWQnpVVnFzY2VvVFVu?=
 =?utf-8?B?NVg3N29acnJ5QXI5dkJiVUV3ZUpBUUlMQVcvMGdFTDBJNVhIQ1ZuS0d4eHlw?=
 =?utf-8?B?MXBBSVlWaHdSNjd2QWxZaGtEeEY0UTU3ZUl5b1VyM1lLNEJRTkwxVWNaMzJm?=
 =?utf-8?B?R1JkMGgrQ0N1RldNOFBEUHRwOUxFcm1YYXRtOUEzaGdUUlhDUHNzd0w2Rmkz?=
 =?utf-8?B?Q2g5R2ZGTzFjdDIwaHBkZXFZRWEveWpjZkR5WjQzY2RpeENPNnlyZmF3cjA2?=
 =?utf-8?B?Ui9zSWVSdW52aDdaV01aVVh6YUN0SUhVTUtvQkdRRzc5eGlWNnIrQXBUZWVo?=
 =?utf-8?B?aCtIdkdGVm1maEdBQkY3UHRZT3hRMnJ1Nk0yTDZURUhvTjhteWY1UnByT1RN?=
 =?utf-8?B?bzVvem11c0JzelE3RHg0czhsN21leTNVWDBMSEhVdUsxWEZHMTgyekp2MlFn?=
 =?utf-8?B?d25rVVI2cDJaY09uSjB4VGcvZzFxblRLemd0dTZoM2xFaFc5ZWJuSWFpUUd3?=
 =?utf-8?B?SURuandUV1RFbk8vM0NKeG5PMjVJNnM5Q2FMcVRjVWpHUUJoOWR1YjVNM3dF?=
 =?utf-8?B?MGxCMVA0d1BIZlJRTy9UV28vK2RpZVBNQ3BzZ01TeHJ6eHhYYzBDY1JGV1dC?=
 =?utf-8?B?SXB2Uzd6ZWxxRkFSZ0llQVhsMlhCek1LMU9aQVFrcjlJS21MdHJuUVRmd2tC?=
 =?utf-8?B?N2lBZHlnMDRWM3cxRHVmVzZvY2pZdlpJeWszM2VPWUwwZlFzNXJlYndHRUlm?=
 =?utf-8?B?bUJZM2lOMnl4NVpSK0Z6eUlobFY1UWFmYmRtQi9kMCtETGtMTUtUOVZzY3Np?=
 =?utf-8?B?Yy9ZR2l0Nk1SQUl0bFVzQWx2bk4wWjBXR1EvTmxYWnJYemM0SXZSc2tUWmRH?=
 =?utf-8?B?WEdkS2xoUzhWc3ZQdW1kM2RkYnpzUkZnMHo1MmNUVDhyUUJ6Y0FEMUZzRVk1?=
 =?utf-8?B?cktXYnl3anlmY0ZsRWVZK1BTeE92anRoZVBJUEpJbXY2SlI3RVU3aVRFbDd1?=
 =?utf-8?B?Ujk5MkVXQnA4MzJlWFN0SHNRay83bDM1Wm5kNDQyTHlWeHNDNXFFMG5CdlVy?=
 =?utf-8?B?ZnRLZ3Rndk5PQnhjWWhSWlJ2elEvTUMvNjVDbFR0NDB5MFNWSDlYVmMrMkVh?=
 =?utf-8?B?WUd0V0Jxbk1lREl6NGZoc3U4V1FseW9uK25rbzZaUE8yWDVWYnZCdlJJeENO?=
 =?utf-8?B?ZFJGK0I0SWF3aHJETEVhanVHSlZWY29xYzVQOS9IOUxMdC9UeElIMjJOamRY?=
 =?utf-8?B?cERlZGk2QUVibkliVEUweHJaRHd6SUxBanBoWXhScDNBNitZS255ZWJjK1A1?=
 =?utf-8?B?WE54eC9TL1hqblBVL1MwWHJ0MTV2TmpGMzZRamQ4UStDQklacEdHRFBaR0hC?=
 =?utf-8?B?djhhaGQwZUdGcHVVaE8vY2lJT3JTU253TTFaNkZVODN2QUJHdmFHMTZ2VVJy?=
 =?utf-8?B?Q2N1ay9iUlVjUHZHQ2l0ZDhhU21rMkhFb0tiWUVwMGJPQzBpdlErUGNkTEkr?=
 =?utf-8?B?Y0JnMmlSaWhsWmtQQnpZL0RLL1RtZ1pwdnV4TWV1ZXppakEvdUFySzJsL2c3?=
 =?utf-8?B?Q1FIY1NrZFlzNlAzSkloN0Q1Q0oyaW9PYWRmZUFwQ0tmNDcza3B3aTJVek1Y?=
 =?utf-8?B?eHZ1bmJDUFZIQW9TVDdSVWNaNDh4emhlQksrZFNYQk1lQy9hWXo0ay83T0xW?=
 =?utf-8?B?dXo0dGdYWnp2eG5OaU5pQnBFNlA5d3pxWC9wV1psSHV2aklQL0dNMTd4OTBV?=
 =?utf-8?B?QklJUmtQSUxGbWNhNVVYMzZXWEdPL2xaUXlJM1hBWVMzMG5pMUNXTk1IcVdK?=
 =?utf-8?B?WEtxbC9RMHZLOCtJTGxKRUowd0xxWnd6c296d3BiTkZUUytYM3V3WVRVMHVB?=
 =?utf-8?B?a3BFZ1V5YkpCYzZuKzBmUHNTRTIyOElRbmd0dmtTNEJ5aHdZZjJZWEFBWTVx?=
 =?utf-8?B?UFFYc21kWTlTMFdzT0ZBRm1YWnQ1OFR5dlRoZUxaS3VKYUlQK3ZGZ3JOKzBC?=
 =?utf-8?B?bXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rDdkAXokJkxEyOYobHAume7eQUJfq+QPiZ5dy9rKq0h3ZgsInpYbfr4vp40dXJMdzEe/ziow3hIiiLihXSXK4JLNcsqfCa10WYl+0nXn08agRSetoHNjGOgbV5Vb4Wde3W3PXZLcRSKPZDfebzcW385HWfVgYrVpJx2bdEiR6/QhZulF46JcDuECMtYT2uBUGoGzA1PkuYgEirdOnAvjQOApGYZH2NenHxlOkh1Pfymvy0GdhGlAT5aE4K4XLQlsSwxo5IxMgfZn5Hkl6vbMK7w43QyjhSG5wCSxyWHpQqRDyDUykH8dM5461IUwwJikOEUvEN8sgrcwPQ48BMeu4drJmXfESZrhMd4Fz5btd3gVFXHw0gZqHbJoUH0mlmsIpp2wKjgcXka3z2g8o60Gwy7FpmNT1DVsioLs8j1jbm9GC8YAn7TkfRlrcODg9n08YBN+4ShNXG3IKEVqQEmjgT2feh/7ZtO6deyYXijE6VeApZVD+EekDTYjkYUYigSJYbKajfZ07MNSrpls9FOt4mbJaEJUyIdVT8VBqKEeVC1c2lA06FoHEIK0FL4Df27WQICAMhtGo/h8tgBNG8m+M/Gu2xRVu06gtPE1Z1+ntbc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 648b64cc-4952-4eae-a5ba-08dcbd6c9621
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 20:55:25.4159 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qSSeFBdDaBV/5sPvV8eNQRIrcYfG9kD3cnX9PW8/rcWP0BjIq63MENt0zh2GkDUi3vF0jlu/cjAhynvm0d7RjUQz8yQoxuXbWDyik1KCGDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6126
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-15_12,2024-08-15_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 bulkscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408150152
X-Proofpoint-ORIG-GUID: Q0lBIFUIR6DOadabUiORv8gVzuQWpQ1R
X-Proofpoint-GUID: Q0lBIFUIR6DOadabUiORv8gVzuQWpQ1R
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 8/13/2024 3:46 PM, Peter Xu wrote:
> On Tue, Aug 06, 2024 at 04:56:18PM -0400, Steven Sistare wrote:
>>> The flipside, however, is that localhost migration via 2 separate QEMU
>>> processes has issues where both QEMUs want to be opening the very same
>>> file, and only 1 of them can ever have them open.
> 
> I thought we used to have similar issue with block devices, but I assume
> it's solved for years (and whoever owns it will take proper file lock,
> IIRC, and QEMU migration should properly serialize the time window on who's
> going to take the file lock).
> 
> Maybe this is about something else?

I don't have an example where this fails.

I can cause "Failed to get "write" lock" errors if two qemu instances open
the same block device, but the error is suppressed if you add the -incoming
argument, due to this code:

   blk_attach_dev()
     if (runstate_check(RUN_STATE_INMIGRATE))
       blk->disable_perm = true;

>> Indeed, and "files" includes unix domain sockets.  

More on this -- the second qemu to bind a unix domain socket for listening
wins, and the first qemu loses it (because second qemu unlinks and recreates
the socket path before binding on the assumption that it is stale).

One must use a different name for the socket for second qemu, and clients
that wish to connect must be aware of the new port.

>> Network ports also conflict.
>> cpr-exec avoids such problems, and is one of the advantages of the method that
>> I forgot to promote.
> 
> I was thinking that's fine, as the host ports should be the backend of the
> VM ports only anyway so they don't need to be identical on both sides?
> 
> IOW, my understanding is it's the guest IP/ports/... which should still be
> stable across migrations, where the host ports can be different as long as
> the host ports can forward guest port messages correctly?

Yes, one must use a different host port number for the second qemu, and clients
that wish to connect must be aware of the new port.

That is my point -- cpr-transfer requires fiddling with such things.
cpr-exec does not.

- Steve

