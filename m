Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FCAFFC034E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 15:34:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFw4M-0001Bv-Bx; Thu, 23 Apr 2026 11:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1wFw43-0001Ag-Jj
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 11:34:04 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1wFw41-0007Mh-1i
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 11:34:03 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63N5uEOq423744; Thu, 23 Apr 2026 15:33:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=Uqq7cgaumurOuk1+pEYhTO8oIoi/9xEtcubBmSy0kCw=; b=
 eSO6kiJ/EutlOKjGtG7zhsmF9/P6WOTUuaxjDw1hMg4aJKaExQmYTtM0bUXnqAYG
 4M1EKW8OY8FGhshblEmXqezLA9LkeSbonP3LLahh/bKaaCMKLayBaxZjrQYMAgrs
 UuogTS+dbPpPNxVsUBeeSeJKFA4k5tK9e0m2D3PEz1DeYSRjvgaZiAMjmu+u3Aqy
 /rPfNiORPKGofJEno3zhTRuEtwwzdnvNG3//Q/kVvbqdpBJL9vsWNju2LppLY3m/
 0HErA4aAPQAKeSMmZ0cCtJNcgX0GnOy4Jep5H2+/VaR0utoGenE3aUM6JwuwRCEr
 kmuorP6fRqDfFMBvPpuPDg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dpenjbqc5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2026 15:33:55 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 63NFVLX2033888; Thu, 23 Apr 2026 15:33:54 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11010030.outbound.protection.outlook.com [52.101.201.30])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4dpjjg9gvv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2026 15:33:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r7Qzg/nvMxsyzX2xQ0sC7c+JPsa2yRKrZopSenZ2x7jUo3WTc2rek+VgvuzUqP7Gmpdw4S460OK+xm0o7VjE8fWITDuTSchySdtG5S25nQ2SR1qnP3Bn2DVb6QxwiB+InkYUnydwReoGQ8fTIdCcY47AqN6Z/8xH9uLMvFSU69qkd+4DGvgLjvucyVwaaZV6JKud2YLSZMLOlELUHd6TnRnrXqKZyFumHka5DiIDFc83C2+n36seL0KCR7Jm+ceMOSu/I2l9C9WYJLiZxw4ynWanW+x4f1viYsvx2G4qE2+IA1zO5RAaqjE16gT98+etfNS1aMHFrXAo99ccdaBINw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uqq7cgaumurOuk1+pEYhTO8oIoi/9xEtcubBmSy0kCw=;
 b=xUFtOYVipBMd9ME0OhiDWeHjP+BHFNBz5TbNO20//7ew5ZmNZI4QLeVClbGzg1S0Ng9l1SsBnA5+8RECM2dn0tijvO6IRJ5huH5dc8qXv1XxXte3rmI+IM/B07x35QH7YW7wT2wygiBEZr1VKjYW2ogzw6YhCYjy/PC9gsdjrKiOwUwCw6vFW6ibcUuqdTQdV3OgWCqznd7jyGoAIintYFWYz4oJbBKXRRnUFy3MoOjtLKC18UML1j2KZTImvRq4WdU6W6ECt45hjIo/8q31bCQUF3/KKtI4et+3Bs3GYeuTBpeCJXEf0mNN6e4kyvTTde45bpq1clRr2gkVAV88NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uqq7cgaumurOuk1+pEYhTO8oIoi/9xEtcubBmSy0kCw=;
 b=iLZPs2wQNGHFAAs1Yu4ATZv5JoYfUZG9Xf4jLGg0Rpwk1vhNG9AruSgRLxMatHcZQYi1SGJWwAo0weHo5Y4Ko4JeahUNdZ6rpRUES9PbnajVzTBMkWI/oiA8i5dMZpGNMrc3H3n5KbXp6UdQobEt63KShIgZ03Y9pThPyUGWF+I=
Received: from PH3PPF1D715CB68.namprd10.prod.outlook.com
 (2603:10b6:518:1::78d) by SJ0PR10MB4703.namprd10.prod.outlook.com
 (2603:10b6:a03:2d3::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Thu, 23 Apr
 2026 15:33:49 +0000
Received: from PH3PPF1D715CB68.namprd10.prod.outlook.com
 ([fe80::f1d0:317e:4337:b516]) by PH3PPF1D715CB68.namprd10.prod.outlook.com
 ([fe80::f1d0:317e:4337:b516%6]) with mapi id 15.20.9846.016; Thu, 23 Apr 2026
 15:33:49 +0000
Message-ID: <912387f6-7876-4194-969f-61c5af739bee@oracle.com>
Date: Thu, 23 Apr 2026 11:33:46 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/remote: update libvfio-user subproject
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
References: <20260422140244.2147400-1-john.levon@nutanix.com>
Content-Language: en-US
From: Jagannathan Raman <jag.raman@oracle.com>
In-Reply-To: <20260422140244.2147400-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR05CA0049.namprd05.prod.outlook.com
 (2603:10b6:8:2f::27) To PH3PPF1D715CB68.namprd10.prod.outlook.com
 (2603:10b6:518:1::78d)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF1D715CB68:EE_|SJ0PR10MB4703:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f4a1aa9-de20-4405-bf86-08dea14db705
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: Bydxe0oohVv69020EA0zwzdE+THXoM/fbxjeWQQM/zAIrGB2ufKg83EMlVXiV/Y2vMmEX2d58FlaaGFcKfNMedFOQt5EEy5o8HlMFjjrF0uJ9KdZTggksvk0Y/5E3++8h6eJARrogUXyn6/+jAK3yWQcRlLc8IZKx3yi6g3xvTBEOW/poca5wfR01gZPal06i/nDLgri5k5D5kYet15lKyXtG8EmjCTXLIomiSv2O3jbgbpT1bHLr2RmrtKXv+nIV7K0iJj1cyrh8msVzzsEi+vy+x2P3okqhF0nkxrGpOmQyenZ+0GhxSMcdeRVqTXlxLIqU1irkMtNl9SubkH99u+NTr416lOJbAjAKYnptPP7E/mulu2CQNeYglU54mD6csMxt+J7wMtxuKkG2kaxRje8Cs/cN+pmPj58h4K8ZmPz3+aXGqj7VvHpF1WYLqsaWz8hKWxmx9CmixfDgfae34e0+0oNMZXCCRF7knh6YiGido2GygyDCsk34mReL83Pm5+22gbDf93xsKgRsCyAnoRaVuGNl9V5h58MogQWE9MADJjPuK8GEHQMYHbFAR/BZ4QlytCtehmfWWScOBUuqWmmOAZzGW5+AbqBR6wxUcwOGJhGCh1+1Eq7Y5b0qiy1UcZaSUuwe5Witscz/MqPado1YPPq6+AMjkeTt7g8dYAPM2sTGXSpw8iLK49JSsZzeVGOPApHMJhnC4/55iQSkiWD8W9tizFC6zuofs1oNEw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH3PPF1D715CB68.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejBkR29qTzFzaEEzYjYrTXJlUFdYT09PempEY3c0MnpCb3Y1dUpPMFhjbWlY?=
 =?utf-8?B?OE5YNDhhZW5kZCtxSFYwMi94VnZSMUVZd1VWei9PQmNSVGt1YlA4Wno1cEJu?=
 =?utf-8?B?MEdxTUM0ZS8xVndnOFJ4T0ZVVTVUdWVOQjI2Q1VZaWtjQndyOG1yRm1JbTZj?=
 =?utf-8?B?YThUc01mSDNFNHdKT1pmeEZQaVV4eVRCNS9KNGRDM0l0Sk9YK3FFLzN6SzJB?=
 =?utf-8?B?WE1GNmVQSXcvb1Y2Z0t6clJzbWlFZnZxTE15UlpmSWs4b0hDdkNpOEQzYnk1?=
 =?utf-8?B?M1dXckZYUXlJTFF5Z2tZamxQczd1Y2dwL1lVSTl2RE1IYXR1WksxUlZscHFE?=
 =?utf-8?B?QTQ0cHJ2bWFhTmMyRTlkdGRYQUVlcVNlVi9xeXFCZitjN29aYnVqb3Uxc1lz?=
 =?utf-8?B?Q0M3OTc1cCtuVEwwdUJDNnNvUUZjbXM1WkVXN3Z3dXdaUzVlTW5FN0sxeU1O?=
 =?utf-8?B?UWVpT3JLMGFtNFM5Rk4yZnBWTFFOWkhvUGUrRVRmQXpBN3VFanZ5enFJVzNE?=
 =?utf-8?B?VEtBeVR6WlJPTW9UdFJRUEVGZFZoRE5NdXF2RWV0VEhzMTNuS1VPdW5xakF2?=
 =?utf-8?B?cVA4dFovYVpMWjZCUTh6dE9IZVF6eTRYWXZqUkNCRFhnajQ5L01rczcrVWxW?=
 =?utf-8?B?OFZldFRJTG9meUl2c0cybHVsR0hHZ1BWQzB4Tk94VENKYmlLMGJYdjV2Wjkr?=
 =?utf-8?B?T21hNkQrWGpDdEFLZ0ZjWHRXWmg0MWZtU3pNbDV6cHFVNEVoOHZRQkp3dnNM?=
 =?utf-8?B?N2xyRldmS1JaSzJVQlR3OUxhNnkwQVR6TkNXd3JDZ2sydmN1R2xqUWk5SDZO?=
 =?utf-8?B?VDkvT3RUd3dKS0dNaERlckNxdHorb3Y4TGJPV2k1bzkvTWM3Qy9NSmcyMW1Z?=
 =?utf-8?B?VlVnaWhhYmF6bTdxL0d3aW0vbnFtb1FMQWpydFAvTUd0elVtWm95a1h0Y0JD?=
 =?utf-8?B?L0o1T1pmcEhFdXhPU2o3YTROUHZNQWFaQmRtdDhyY0hTOWRTbVR4NjMyRVNo?=
 =?utf-8?B?LzFqSWZEWmpSMjFGNWNSakRzQXpxWHFHazlCMy9nWjVZbWFUWGh3ZFRLSk9O?=
 =?utf-8?B?WEZrK3U0Vng0NURNcVo4Uzc5eEh3N0hkWjAzM1NiVE5hTkZBeWhURjJuUHQ4?=
 =?utf-8?B?ak1XYys0N29CeFpDdno1RUQxNmV3emVmYXVsck9nS1N0MGJyMi81RkhyYWN0?=
 =?utf-8?B?U1ZsYVg4eEZvN2RIb3Q4SExiZjlTWmVXZTVzRzVNaU02TzZNY3I3UUNLeHdx?=
 =?utf-8?B?TGMrZzJka29xdzltbWcwSkZZaHd6MDZQSUJJR1JLdEFlbEllWTN2OWI2RkE4?=
 =?utf-8?B?aEJZWldTdmI0MHZmNThhTXFCMkpEM2JJVEtiYnBZTHlJTHMxQStLMjBDKzZi?=
 =?utf-8?B?VWtOQXltczE1amhTdk9PZjQ0dHdsbWJDU0ZRSDNDS05wNDIrSmJOYVp2Q0lX?=
 =?utf-8?B?UnlkL09ldEVsRnpOV042Zm9NbWYyMVpMSDdWSEh5TFVlNjZWZGxVRzRvQnpZ?=
 =?utf-8?B?UFFkOXlWYnRmTlNVOGpwNkI1cmNEdWJITHBtYXdYRUM3WWE5NjJkVXRXYmVD?=
 =?utf-8?B?YXQ3Ynd1L0xnZkVuS1pvdXJpWmduQU00UTllczdpVnVWQWFXNGxRTXJCaDdP?=
 =?utf-8?B?NVZwWDUwbjZ0aVY1eVZiWE00UHhTa1ppcldkQ1YrUkZxQ1JyS0pqUUV3YWRI?=
 =?utf-8?B?YUsyaVYvVUlDVzZZUEdrOWpDay9ZWWszS2dZWDJOTDJpVjNBcGJRQWFjaGJT?=
 =?utf-8?B?M0VtTVNjN2pHOUJmTVYvMTFSZkdvZWZUb3FvRjk1TTYvTXllZ25jWlFXVDcr?=
 =?utf-8?B?K20vaExGTjVYc25POWlGZThCcVZqQjE0R0FFMUU5T0ZkZ1ZwNlo1Q2pKR2FD?=
 =?utf-8?B?cjRqSmUzY0hkenJYM1RkYlNleEVOM0JKV0x3UEZFdXk2Y1lKOWl6S1l6R0VX?=
 =?utf-8?B?dFZNWFk5RUpaeHFnL3FaOFlXQ1czdVFjZzAvV0d3WFZ0TUdscmVrNVJvclpq?=
 =?utf-8?B?emYyUzNlRFJqand0RE8zWVRHMUd3MFZSZ2t2dDAzS1dYcTFyY1dZQ2VrYW02?=
 =?utf-8?B?bi90NFFnZjhjYThYYmZHVjRmUXZNZ0R6OUN4aWZOWHI3eEtFOVYxVmNYS2Yw?=
 =?utf-8?B?RWFUQlRUMHdIVzRNYTF4eHRqQ2lNL0pFWE1OUWVFeFE3Q3h0WGhiTm90VWFW?=
 =?utf-8?B?cEhhQmhkaTlrUmp3SjFjVHcxOUJ2SzJQSlBiOGdmVk1OVk1XWlVwNk50UVlS?=
 =?utf-8?B?NXJ6VGFWeHlwZ2h2NlZCekFSOWRvV1MrcVVoNEJsN2pLSTVoV1ZxLzdHY2xD?=
 =?utf-8?B?cm9za0ZaODBKY0t6dzQ4Sk9xZEVPVTZWQVNYbFhBZzJRMnJObnkwUT09?=
X-Exchange-RoutingPolicyChecked: pa4wd6PDIfMqnssEWbsiOMAq4qIeJRa+rNjmzFIsL8vFlcd8N7GuhVIFPPjBl/XGBwZI+w6R1yEJAZqgSToL6mrxGF6ivjtFsf7veqFTibB/xjUg/yhb6fAb/8uVkIXyxS+n64ZmtGGMUrk1i4atStQpF4eR4ScQath6t17+xbJU3eT/9WwSBu2BNcmorcLhoA8Dt/3xp3DkGBPAM5Zd7+SQ3GP+01UUXpYLSFkyO+O4ffCHqH23uIheXrQAqmmqbaVSQEFwpAcGSCwDWUQuF/Q5svtucDV9bbU1IJUb8ckRWQAzsenU6d8IN4BKZ0xvbmItwSRPB2Eao1o+GBau0w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Jw0qkcavgFvXuqujAleFQnLYtoJDFqTRbesFD0TIKJQfCXey+8CXINtbvPdudqrhGYLuNIdNUwSoTApVmi3oYwPPkcg6duKAP5v7ygaI73Kx1gtQcaIFMTiyKMBVrnDb29ReCKCVtmnhDf2/iVifAjoFC6RsO37X1mv5KhSAMo6B/cd4AzPFle0c451143bKslQRYU/CPf+4SPkb1KIBXPsVedYpUN9DVUhOvGZjadBjq3y/NvNENNPt1pO+y9ShL4bR6bjESIB+sc6mblNr0tcE4tjJjgVwESa2fkUKD6udlP6gHHu7OhFwj2Uwx4CsJbXT+/w6JxPQ686W22jbdzf1sInj6xx3eWrCnr1ngOFHqJ2UGLljsK6IFhlL6dWBBt/8SxZ8SWHEe1YyMikvlGe0gUpgYjs+tvNLHclnFs8EHMY+BA6mRDNCzoZIlDtv/QyA3E+hRjD+s19rIyDY207qd0GJl/+OOQzUUeNBmDbuB0J1UBdMArpG1vTys49D0XXxTubRH8rnQEYuBWWHP2Lc+tqMz9l5ZTTdU44fr33u8S4QQiJqO/qm1txxTqaeEs9KeObLhgxsFrkFDDPa2fdbbzPUTpr/sAgzdU9Ufos=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f4a1aa9-de20-4405-bf86-08dea14db705
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF1D715CB68.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 15:33:49.0657 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zXMZ4xeqj2wN4RzYTeGioX+KkUwrACeMe8BaiP8VHQzBhLbv5m4SxgKBWSlhcUFqCg/j6j23imm/L0QKM1I4Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4703
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2604200000 definitions=main-2604230155
X-Authority-Analysis: v=2.4 cv=MrliLWae c=1 sm=1 tr=0 ts=69ea3be3 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=p0WdMEafAAAA:8
 a=64Cc0HZtAAAA:8 a=yPCof4ZbAAAA:8 a=M1ZCMt9Itu7FI-cFpI4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: czf-UNGjgWMsWjYY0unZaR6Yaj8STApb
X-Proofpoint-GUID: czf-UNGjgWMsWjYY0unZaR6Yaj8STApb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE1NSBTYWx0ZWRfXyEfQadGlRN3W
 FecxI2cYvDHt0HXTCJBr+QX6bOq856ohghxo4xlmuhkWDkCU9bYwY+VpQd7PGUNaVjSFytIWjbg
 AxPHUDsJctrk5A9zN+brterWPOgvVoc2mL3aJCbNnTjkVw/oGLnLo4cP5dLU5a8z4Z+ARJQGy/N
 46+uqxGIHGX4HHeQIkfDq93P6ZZKyAKhCmIkYauwU9H1sT0SlBpdA9gScCmltk/agDkbD3MGhoF
 XijQmP45QsWun4RdjBV0XgwJn6gcMX69n8AaW0dE+Ylq1Ed+pb/KVY3ElNVRfwczevQh3qFI7rW
 BCMLuQPEsGXSRMggqqOj6/N4lsy714JwMandBh3tpXeMc97pdwIGecBDVXtkpUpt4OBTOmTyLyu
 2L/afecG0TcTTwPJdSJvyJGmAwq736J8RH2zmEaqKfUOa3l7sg20SltuGg8hKXX6Fl2a9SjKKIA
 h46b61g9B2eIJql9uuQ==
Received-SPF: pass client-ip=205.220.177.32; envelope-from=jag.raman@oracle.com;
 helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 4/22/26 10:02 AM, John Levon wrote:
> The currently wrapped version of libvfio-user has compilation issues on
> newer compilers; bump the library version.
>
> Signed-off-by: John Levon <john.levon@nutanix.com>

Looks good to me. Thanks for the patch!

Reviewed-by: Jagannathan Raman <jag.raman@oracle.com>

> ---
>   hw/remote/vfio-user-obj.c     | 3 ++-
>   subprojects/libvfio-user.wrap | 2 +-
>   2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
> index 12ecdab6de..3c89e7a741 100644
> --- a/hw/remote/vfio-user-obj.c
> +++ b/hw/remote/vfio-user-obj.c
> @@ -798,7 +798,8 @@ static void vfu_object_init_ctx(VfuObject *o, Error **errp)
>           goto fail;
>       }
>   
> -    ret = vfu_setup_device_dma(o->vfu_ctx, &dma_register, &dma_unregister);
> +    ret = vfu_setup_device_dma(o->vfu_ctx, LIBVFIO_USER_MAX_DMA_REGIONS,
> +                               &dma_register, &dma_unregister);
>       if (ret < 0) {
>           error_setg(errp, "vfu: Failed to setup DMA handlers for %s",
>                      o->device);
> diff --git a/subprojects/libvfio-user.wrap b/subprojects/libvfio-user.wrap
> index 416955ca45..11db795f8a 100644
> --- a/subprojects/libvfio-user.wrap
> +++ b/subprojects/libvfio-user.wrap
> @@ -1,4 +1,4 @@
>   [wrap-git]
>   url = https://gitlab.com/qemu-project/libvfio-user.git
> -revision = 0b28d205572c80b568a1003db2c8f37ca333e4d7
> +revision = 4d9f663450fa80ff375612dbbafe073700e3d3d8
>   depth = 1

