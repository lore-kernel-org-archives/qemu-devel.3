Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A180C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 15:48:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUTMC-0005gL-0d; Thu, 18 Jul 2024 11:47:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sUTM6-0005fb-Ic
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 11:47:44 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sUTM3-0006T6-Ip
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 11:47:42 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46IFjioc029947;
 Thu, 18 Jul 2024 15:47:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=lkHqHPdVPX9/hJgVZFbd0yz+1SO1/cxn26knYIzz9x8=; b=
 NWQAIqAK+MX/29TyImHIHn3MyKSTbcEpSbIo3dn32rXsecc86VNsip+BiT57bjui
 AYabp7hYALK6jR3c1qnYfPnVDmnhzaqhyOtF6F2bXhM00COuY3jxnYaz0xM+GFXe
 LVibDh37bG3RVMVrXbS/4XAP5vT5q6pxFJcuSrGZK0dSbxkUNZ7nAD8gT35OekD2
 bRefRRi7h6pmOgS4dqDBp019W8OF/7d3lk2l8kld87avRBSKoIp6mmza4/aruaAF
 YDgjU/xH36H1ndQlthPcL8HQlQaikScR/mAxCJL6XpiSoCAUSGXE+N11p0njtKqf
 NJ24RYtcLAwFGgTe5wPvQA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40f5yfg04w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Jul 2024 15:47:36 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46IFlWZ6003706; Thu, 18 Jul 2024 15:47:36 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2044.outbound.protection.outlook.com [104.47.74.44])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40dwf0kjyp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Jul 2024 15:47:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gi6tp/NaFEfR5rLHaozKci5/NsUfMMfJY9e281Fjf8+u4xjOd3lQSq7oyc0YsuXjbufxZD8g/hTLWPwBwA9bdDxwzpJkgWVpU3kmMi8eYcs3Br5uEerC8fBIEAI67xDTN6MMWdvY2sjUfSVzeh0BrU4z8ZiAeF+EUPgtwHNtLWWvy26zKBtFU5Sz49sbdYlXSkodVzL9lKTbl8u98YfZSRtkH3eWgZk1iv5sUWZVw2NSfFSPeqyEN/PdpXleE/4nFsh4/R34gqujSXDp0f3edLfIBbAGWJWEjnRZnsa3jZ7XFGYHEASKAHr7qVSJJsFpLqp38RT4LygikoZSNbpUKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lkHqHPdVPX9/hJgVZFbd0yz+1SO1/cxn26knYIzz9x8=;
 b=kALcFq3i3SlKRQ6+KX3cGtstQtu9VcCCNt1mA3TdGW5qPKDGFM4xpix7/9aktK0A+a3orAyfbZ5CZenVbHZJIr+8Ecnbfi7E/HjSNnTRlzlRDRy4Sy/K61Pw6FuYaeEH/PwW7uEGhL6CXwEq9qJl2fIKRtwzhmXtaduDE9nh2NNY0J1JYjkRU8e/9Q1Im2C8emO45hguvVwwSKaiUmw6mrWfFm1BAl4nqI9E1sls8n06plrRQfAWtHSV5889+Ba7mZlFe6+nv+DDo/W43caJ/fkVAsXR/5uQoInGOyLIE8gr7NCC4uJt/wGD78HWM3E7yLFm9jFRQT3Q06N7NVJbjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lkHqHPdVPX9/hJgVZFbd0yz+1SO1/cxn26knYIzz9x8=;
 b=tHuu6cQOtLjehFrHZN5r6r0/btJLCwVtrKKym0qKq8uGeLl3ysDHxfFOEgvpjXgYD4SVuFZu9x4ldz0jlIDHTX16EHYh+vwiM+IHoXuIqTqNkVnnKimtg8KlNy5TIIwBcVxUPmpIFyBXM1KXHxylyu3IjVleBVzIKmRYAGCv0RU=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CH2PR10MB4341.namprd10.prod.outlook.com (2603:10b6:610:78::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Thu, 18 Jul
 2024 15:47:34 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.7784.016; Thu, 18 Jul 2024
 15:47:34 +0000
Message-ID: <77c7e2b3-e067-434b-ba5c-c5a176f532d4@oracle.com>
Date: Thu, 18 Jul 2024 11:47:26 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 03/11] migration: save cpr mode
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
 <1719776434-435013-4-git-send-email-steven.sistare@oracle.com>
 <87v813278d.fsf@suse.de>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <87v813278d.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0380.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::7) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CH2PR10MB4341:EE_
X-MS-Office365-Filtering-Correlation-Id: 31746d7a-281d-46ab-0fe2-08dca740f0ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NVdIRnZpUStKbllHNUg1dDJLdm9iblVBdlFITXA0MzlOaDJaRHMvS09Talg2?=
 =?utf-8?B?bkJWRy9sLzNEYUZZS1B3MUEyRUQ2SU9xek1URXZsR2xSUWIvaURxK0RPbTJl?=
 =?utf-8?B?ME12T2lJR0JIME0xcWRncURkVktqak16NkJ0TGZQc21TS2ZUZllXOHBIZFY2?=
 =?utf-8?B?ZE5uQ2NxdkFXVk5OUk9VSlFSRGRydFBObHVRd2I5blIzaVZObzVocHIrU2VB?=
 =?utf-8?B?Ri9QT01IakxkZ1hzakduTkRpUWFkR05uYXpHUTdjT0dHSnlwVllzamNhOStO?=
 =?utf-8?B?ZVBXeHI0SVBzc082QVZJL2VVcEJsdUx5Y2FpYkprU2JTbXF6MHJ3bzFTbEFh?=
 =?utf-8?B?THZuTW8zcWhXV1lYQk5yZzNwZFI3TmNWYmxiaDRZUEZsRHM5amE0bmo5Kzlh?=
 =?utf-8?B?L3ZtczdmL0x4SU9xa21tbG5TbG5JRVFwY21oYXlHbkNjdW5ncVljYjRrelFk?=
 =?utf-8?B?Wk1Dc25wUFVrUzFVcW84amxCUGtSQm5FVFZOcU1FR1l2d1lTQ1J4V3IrdWJS?=
 =?utf-8?B?c291OHNpRHZXeFFUL0tJTy9GY3orNUVJSHdGSTVzM0xLMFJUaWIrajlPV2F4?=
 =?utf-8?B?SndqUHFsUTVFV1J4S3BoMW5nWTlxTjR5QXFwYXRwaWFyTy9hVEMwdHROenNy?=
 =?utf-8?B?dkVOV0Z3anUrVUxOKzM1b0p5VFlkamw3VzlpQXFNV0RiSHBVaU1id3ZwcXpK?=
 =?utf-8?B?OU5JYmppa0FiTDBGS0tpdEZ5M2xOUnBUMlNvcjhGSmswbVJ6QjY4a1c0RG1o?=
 =?utf-8?B?SEkvd2orb3o1bm1OQW16L0I2Qm5DYWY5Slg3NU5aQStpMU1XaEZRYWZOS0Zr?=
 =?utf-8?B?MHNoT3BmVmhSL1h0VGhoa0FiZC92S1QrU005akcvQjRsekVucnRiQmNpZysw?=
 =?utf-8?B?VGEvQ05wc3p6MllqZGh5T2VqOWpQZzZkYmsrT1RLUkcxMm4zWXlxM2tFVkdk?=
 =?utf-8?B?REU2RGJsWFE3TGtCUC9iUm1PaXlPU2s1TSs3NEdrS2NkdzcrMEZrWm94RkRo?=
 =?utf-8?B?TGxDY3R6NXlqQUZncUNkZ2FFY1dERStRcTc1WUhtL1NwOHhCaFJnVVZ5TmtI?=
 =?utf-8?B?NDUvZUhsUnd4L3R0dkk0NUJEQjhzNXJtSFBoZEp3QUk4eE1yb1NGVHBnRmVZ?=
 =?utf-8?B?ZHpRejF4M3pkQnNaNUwrQVF2Q0oyTkFwZXRCQ0lndmh1V0tLNlhFbmJUcTZv?=
 =?utf-8?B?WWlyTUl6YnhEa0RPVWoza0JBMUJvMU9lQzQ2ZDRvY29kRTlEUVArK3k1WklJ?=
 =?utf-8?B?T0J1eFFyWWpycmEwS0VOT3JIcUhsdGRVUWhiaTNCZUw1dE9aQnQ4b0NXTVEz?=
 =?utf-8?B?REdCV21PMnpydFY0OGtWMnlONk4wRmFqeTJGaGZHOXVnY2l1VUdFZzBqdVdY?=
 =?utf-8?B?czg1OG1oNTdNaFdocUZNdjltK21LSUVIWU1vemNycjhGZDhlUEJmcC9XYXBr?=
 =?utf-8?B?SDRYNkFsN2RiODJRcUNjanNPQWVoSFl1MXVZZjRucHZZMVNzbWdBaTAzYVNG?=
 =?utf-8?B?MlIvM3hQM1g0Z1R4ejkyMkNCUHUzUzM5OUU4RzE2RjF2by9XKzZDTnRxWlpz?=
 =?utf-8?B?Q3dHOHJ5M1UxK2JVdnN4OEVoSnpnNGlJamR2TG5ERXN4TGVTTzFkUWw5MzlS?=
 =?utf-8?B?OG1PVStGMFVnR2ptRDZDQ04rcG1ZbnB6emVFTFlQaytVNUVVb2hVZkJIREpF?=
 =?utf-8?B?eVVlcHZtQ0FDanNxa2FBV3cxSU4wMXk0eCtkYTQybWFqellJRVUvNFV1THF4?=
 =?utf-8?B?c0ZNZVo5Sjk3djVBckErelV1NGo5c0VhdTl5TjYrckc0dW9yVTJCU1BURFo2?=
 =?utf-8?B?czhMT2JnL29HYlEvQ3FBUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTlrWVErMVZGNkhCd0xLVEliL3UyZ0c2aWppcVZicit2R0YrUkdCeGFZWW9t?=
 =?utf-8?B?VVQ3RWE4cW9lVHNEN2V5WDNjMHRoQ0VlTzM0dnFzcDIzUm5yZkxpeUVkazBo?=
 =?utf-8?B?WXFnTEVqY29zSzRPNlRiaFppdkJ5dHFpZGpOL29YdlZwQ1I2QmNVcXY1dUZh?=
 =?utf-8?B?N1lTVW1UUXdGY25oNW9LWDlzcm8wUE1rcWxyWndiUXp6WmFnQVpDMGN6K1hR?=
 =?utf-8?B?UUVuT3pKVGs3N2VuZ3k5ZXMxWmtvYmN6Q1htY1R5ZzVhR0srazdBbFMzWDBa?=
 =?utf-8?B?cWFxb3piQ1NobmxYZVJhUE5VVTY4SnlzeDZZOHV5RXl1M1JYY0o2M3lsMXJm?=
 =?utf-8?B?VUdlblQrOFQ4MTg0S25GMGoyVEs5UlF1NUgyRmpTZ0RzWjg4ODNtSm9NZ3FH?=
 =?utf-8?B?ckpOM1dQQzhFTkJOOHM0cTRlTEgwR0tkakFYRjdDZkNza1MrNFBzR0g3eVRj?=
 =?utf-8?B?S2hxRWxLWTMrSkY3N2xscVB6ajB5MEhLMGZ1MmNuVEJTMlNzcHp6OW9VeDRu?=
 =?utf-8?B?MnY2R2xLN0xkVDd3bDVNcStoa3QwbUZTV1NZVS9lWllJc3dCcnBFR3B4RkNr?=
 =?utf-8?B?QThJYlFjb29ITFFEYXhXVC81OFlrOHhwYkdHYWNjSXNqcDVrbC9xWDJKSmp1?=
 =?utf-8?B?RzVlY2JRMGlFQVlrTmtpOHJraTYyeHA5T01XMFdMQVpTallsZklraktDSmsr?=
 =?utf-8?B?RHBvbEg5K1U4WmpQcnhzTGNBdmlZUjNFbGRLUFY2cVNlMGFZN2kzTlA3WkhN?=
 =?utf-8?B?OUVmZVE3NldqRVlPanlmRXZHYlZtVUVyZ3JLSUJ6anJibEVqQmcwd29OZ000?=
 =?utf-8?B?NG9jQ0Z5YXk0enpHK2J5a2k2aXdkQUFMWHBIK2VQQnBzTzFOUnJreFJBTkVx?=
 =?utf-8?B?OFdBMWZWb0tMMUlPUkVxWSt0dWh5dVoreXd4U0owWjY0b2pEZnJzUm9sMU54?=
 =?utf-8?B?MWxNbk8yLzN3b2R2Wkk3bjFzeWVFV1I3VU1yakJpRlpDS1RibTEwOWwyNXVi?=
 =?utf-8?B?eFBtQi9sVzNqOHZMVDl3eDFqeEo0b2FyVGVtTHFXVDlmdGJxQ0E4RElObzdZ?=
 =?utf-8?B?U1pmd2plWVJjT3ZjMVRLaG9kNFhmU2NBZ090VUVYK2NiVXZsME81clQ0dGxv?=
 =?utf-8?B?WnFkWDFjYVRlOE9INUlpckwrS0c0N0l1UVhqeDAzY09wVzhrdVM4NEVGQlNT?=
 =?utf-8?B?YXNCY1VMbzJIL2pvOE0xNU9OM0ZxUGs3bGZucndOTVB4TTZqK0lPU3lmbVlR?=
 =?utf-8?B?NXJwckJ2VDRiTHIvcHJGck03MURqWEhLLzg1L3V5RnFkU3FTR1U2K1J5dE4z?=
 =?utf-8?B?bVR4eXpkQ1hBK1czM2VUMXNCOXU2ZzMxa3YrbmtqZ01KeFBSN3ZjUk1rVzdz?=
 =?utf-8?B?eWhpZHpEZDZaYzJFRnRyRi9adnZadHF4cDc4Y2laM3l6T21lUkVyKzZucDB2?=
 =?utf-8?B?Z0tkNVZUOEV2TVpPdklDYjZDMWxRc1YxaUthUCtQOHN3Tm1FZU9zVXRMN3Nh?=
 =?utf-8?B?Ky84bG1GaDFURXcySVZncDB5ei9VVEEzR04yMEJiNFFvR3lqRG9nUzE4N2Np?=
 =?utf-8?B?RFVjUE5Hb2VCdmgxQTlMcHUvQ2hock9LMVozdm9ZVXcxMWJnRjNUdGdlWTd0?=
 =?utf-8?B?ZDVYOGtXU1BHMHJJKy9mR2lEY1ptRDJRTG9HaXVESHRTanEwdDRLWmp6VmxQ?=
 =?utf-8?B?YldkT3czeGx2anltME5zSitVSUp6SDV4bnA1ZEFxankvSmpubXNabFA4dEhN?=
 =?utf-8?B?QU9PM3hiTmUyVTF3VTR1Q0dJNlNBSGMyZXdlU1czYWlkb1VwTDdqcHNqN2dN?=
 =?utf-8?B?MklBejhTVm9CdC8xQmtyQWE2TUJvNXdqVWM1b2pyMmNMNUZWcTNIWjJEV3BP?=
 =?utf-8?B?bjFFeCtLcFhicEw3dnNsSDQzMFFnd3pDWFJDaFVKemFuTTI5czdpd1luM0dN?=
 =?utf-8?B?YjRBUWdsMTJwRU12NTRXK0NzTzRFSkJ3cnpFUWlTWkRVcnpHNlN6dHlqR095?=
 =?utf-8?B?cW9XbndSbEJXM2Vkb28wQmZ5SXZ2T3FIS2xwK0FRMFk0ZGczay82U1JtZk1H?=
 =?utf-8?B?MnhwUzBsNmpCbWM5T3EzOGVJTzNsaERHTnQ5ZnhjRXZFaXFpY1VjMldtamFs?=
 =?utf-8?B?L1pEWTFWWnpsNjhxUElTYXpNaWlWZjJYWEdhWUdCT1cvbS9kdzRibkNna2tF?=
 =?utf-8?B?V0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fA/VEk/FPD6udIMhzOEaWxxOJDWugwzjDd/5GE0EG8FVvTplDuSus7NsjKrUP/dLVF3I+hwIhmLlPZimX45+TtSFyAlA9T8V+c3qmr/NLO68385bkx9iJ1YLQrD1fmcPYrXn/bjcnwoUOk7qPgPxlCHeMKpzQ9c6KkvHM2As0SFZOdw02w0ZWmxgXMCPKek95auvaboiLvvWAsW7Xob2zyb5PKFDWbVClij6A0gv8/0V1xymtqNYvS8/2ec1WQkgeBOzgbJ4ei7clfm1NGIyNjqO50ZiGcJyuhET54Agk8h2hKj83cVv8O/wnYw6fwT8Khc8L3MX/+zJFbtmxc6ErU7kV/0Dc2qUoU9mRW+AclkCYFFsOGPJ48PyxOUH19Td9q3u4E0GJ3FI1eG2a0ZEMx1akUu72dpv7IoKm06Co5ybjpDVA5yYeLxgI4dtaobLpLUSlVVJa24xyZI0h7Xp6o9kx9D7p4PLccX0V0mim93EuoWaloKqxmV+LIh9tr/ngZ+M42UHaaRkf1PxwkGCerKMYFbpbglZUamUrxqYlKB9VTWKnsEgEFleziPklENbUVIgUPtQwsHofesvYV5s/IgivauFBYkJJkJ2xaiBYGM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31746d7a-281d-46ab-0fe2-08dca740f0ca
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 15:47:34.0601 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BCE4ug3EvzUUK6mpNCK62mitmw55wf4m/MHg/Y/+R+Sa0km68KSTCZTx0f9zWCVGxfM7SQ389N97PSdBwS5Q95rEXREH5ZfjlenzTfSLvzA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4341
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-18_11,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407180101
X-Proofpoint-GUID: 7I7l8MewFqoVWidavxeyh1vkOM3zuZVw
X-Proofpoint-ORIG-GUID: 7I7l8MewFqoVWidavxeyh1vkOM3zuZVw
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 7/17/2024 2:39 PM, Fabiano Rosas wrote:
> Steve Sistare <steven.sistare@oracle.com> writes:
> 
>> Save the mode in CPR state, so the user does not need to explicitly specify
>> it for the target.  Modify migrate_mode() so it returns the incoming mode on
>> the target.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   include/migration/cpr.h |  7 +++++++
>>   migration/cpr.c         | 23 ++++++++++++++++++++++-
>>   migration/migration.c   |  1 +
>>   migration/options.c     |  9 +++++++--
>>   4 files changed, 37 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/migration/cpr.h b/include/migration/cpr.h
>> index 8e7e705..42b4019 100644
>> --- a/include/migration/cpr.h
>> +++ b/include/migration/cpr.h
>> @@ -8,6 +8,13 @@
>>   #ifndef MIGRATION_CPR_H
>>   #define MIGRATION_CPR_H
>>   
>> +#include "qapi/qapi-types-migration.h"
>> +
>> +#define MIG_MODE_NONE MIG_MODE__MAX
> 
> What happens when a QEMU that knows about a new mode migrates into a
> QEMU that doesn't know that mode, i.e. sees it as MIG_MODE__MAX?
> 
> I'd just use -1.

Good idea, thanks - steve

>> +
>> +MigMode cpr_get_incoming_mode(void);
>> +void cpr_set_incoming_mode(MigMode mode);
>> +
>>   typedef int (*cpr_walk_fd_cb)(int fd);
>>   void cpr_save_fd(const char *name, int id, int fd);
>>   void cpr_delete_fd(const char *name, int id);
>> diff --git a/migration/cpr.c b/migration/cpr.c
>> index 313e74e..1c296c6 100644
>> --- a/migration/cpr.c
>> +++ b/migration/cpr.c
>> @@ -21,10 +21,23 @@
>>   typedef QLIST_HEAD(CprFdList, CprFd) CprFdList;
>>   
>>   typedef struct CprState {
>> +    MigMode mode;
>>       CprFdList fds;
>>   } CprState;
>>   
>> -static CprState cpr_state;
>> +static CprState cpr_state = {
>> +    .mode = MIG_MODE_NONE,
>> +};
>> +
>> +MigMode cpr_get_incoming_mode(void)
>> +{
>> +    return cpr_state.mode;
>> +}
>> +
>> +void cpr_set_incoming_mode(MigMode mode)
>> +{
>> +    cpr_state.mode = mode;
>> +}
>>   
>>   /****************************************************************************/
>>   
>> @@ -124,11 +137,19 @@ void cpr_resave_fd(const char *name, int id, int fd)
>>   /*************************************************************************/
>>   #define CPR_STATE "CprState"
>>   
>> +static int cpr_state_presave(void *opaque)
>> +{
>> +    cpr_state.mode = migrate_mode();
>> +    return 0;
>> +}
>> +
>>   static const VMStateDescription vmstate_cpr_state = {
>>       .name = CPR_STATE,
>>       .version_id = 1,
>>       .minimum_version_id = 1,
>> +    .pre_save = cpr_state_presave,
>>       .fields = (VMStateField[]) {
>> +        VMSTATE_UINT32(mode, CprState),
>>           VMSTATE_QLIST_V(fds, CprState, 1, vmstate_cpr_fd, CprFd, next),
>>           VMSTATE_END_OF_LIST()
>>       }
>> diff --git a/migration/migration.c b/migration/migration.c
>> index e394ad7..0f47765 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -411,6 +411,7 @@ void migration_incoming_state_destroy(void)
>>           mis->postcopy_qemufile_dst = NULL;
>>       }
>>   
>> +    cpr_set_incoming_mode(MIG_MODE_NONE);
>>       yank_unregister_instance(MIGRATION_YANK_INSTANCE);
>>   }
>>   
>> diff --git a/migration/options.c b/migration/options.c
>> index 645f550..305397a 100644
>> --- a/migration/options.c
>> +++ b/migration/options.c
>> @@ -22,6 +22,7 @@
>>   #include "qapi/qmp/qnull.h"
>>   #include "sysemu/runstate.h"
>>   #include "migration/colo.h"
>> +#include "migration/cpr.h"
>>   #include "migration/misc.h"
>>   #include "migration.h"
>>   #include "migration-stats.h"
>> @@ -758,8 +759,12 @@ uint64_t migrate_max_postcopy_bandwidth(void)
>>   
>>   MigMode migrate_mode(void)
>>   {
>> -    MigrationState *s = migrate_get_current();
>> -    MigMode mode = s->parameters.mode;
>> +    MigMode mode = cpr_get_incoming_mode();
>> +
>> +    if (mode == MIG_MODE_NONE) {
>> +        MigrationState *s = migrate_get_current();
>> +        mode = s->parameters.mode;
>> +    }
>>   
>>       assert(mode >= 0 && mode < MIG_MODE__MAX);
>>       return mode;

