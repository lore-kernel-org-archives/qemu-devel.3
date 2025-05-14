Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A22C3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 20:24:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFIdx-0007qN-S5; Wed, 14 May 2025 16:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uFIdv-0007nZ-52
 for qemu-devel@nongnu.org; Wed, 14 May 2025 16:23:55 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uFIds-0006QV-J9
 for qemu-devel@nongnu.org; Wed, 14 May 2025 16:23:54 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EJVSu6010813;
 Wed, 14 May 2025 20:23:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=phA3wPGFm18xOKuqej+P071jUpxgSvTzGl79p0oah5U=; b=
 Jl23qwS5MLp/eulJZD+1f5SYyL8K3x8rxm+5Ct/7R+1x8gLr5aEz/1O0bKcTq+6R
 Jr3Xtx7GzIjpuVd7jW7kqXtUwfBkmSb+LHQPwI1bD+SAz9Q9x+kW3kyE0l/dK292
 c2Ccssr+qZD2ntb7W1fWbfm+kk7aeMACIwdZ/D/2PR0xn1JwKWHNXZj07uG/b3bx
 ve46h8tDwlt6Puhn+ARMcagL5dAu/hASrTdgWIWerpjU5p6ZPM6Tw6u7FfYqiLP7
 XqKPg0mR6tqlcbg/fTOFk+cJKZMKE4Qiha6X9FAJN2I+zqPKNr1wtKBlWJEXrIJt
 zeccfRJjpULPVBQecJlYJg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46mbcdtqnp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 May 2025 20:23:34 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54EJY0fI016131; Wed, 14 May 2025 20:23:34 GMT
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazlp17010001.outbound.protection.outlook.com [40.93.1.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46mc33y5um-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 May 2025 20:23:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZVEC5UU9cB+RIdtNfT4LojvJfbAIq5uJzKHnxjFS20GHj+iaCc/ki3i5v6q2wDbuMlDzjnxi1aCJC2vh0U2Jq23LiOxd4FmWvsti02Mi6rry2NDaMXNTNnd9xEmK5TgcuAF752+zQId3AAl/Io9TzYSn2wK+ti2r7r1kOATIUv7Zm4D5cR9+4Tm7bU0jfFMIxjuza+KUOucT2JnqdsdSAU7DbLksTlvgHjFe0q79rwNt66jdmYcXssCKrKXzzhg7xiOCTDnAdIOXvUAHIK9Z1z2nmXlteMPHGem5BEuVtTF4bxaJVJrCNUIAr5Ol87MF04zHe0T69NWnmAI9rvlNTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=phA3wPGFm18xOKuqej+P071jUpxgSvTzGl79p0oah5U=;
 b=M9zEJEss6Pq30zbJ04sUrZrt2qF1wrVfSaSBbsq3CyzFV3S11svS3BsKB4Na2enxeYfZbBvZfEr+q3jo5KlJeiHHoqpotngv7IGdrpEayffoDVkMYhjUjTV6tEJmHSKbo0QRxFi3PbTxQbzGn5992n1kQ5d4zPd5Znf0RaWUmOsBAuY7CVpfu+JT0QDU1w9XukwKZdKUgZVDYX6wXmh/f4iw/usQIxJIGgtURjxbczIjZxs7M+45enLSarSeMqhv/gPKUWyILg3gkPzVqtQebo243bkx3C0hCg5qalRzgbYCpofEAgAObGS+S7POyLlthJYDboNCMgy2iABUKXe03w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phA3wPGFm18xOKuqej+P071jUpxgSvTzGl79p0oah5U=;
 b=zGG5zasrzN3g2hCardNXmDPzxRbBhrShMRFzNPYKWgbCQwZsl4mcFMhmZrakGeHFNkN9JbhdGJB1+b9jnEzmiKF3cgl6mR8TCyH+rGEEMH4ngdvH60zeva9aX7/I8DqeOGI2HH93PhEv2WSwFBL7F+5XgBqotOaE0LA5uhOOTjY=
Received: from DS7PR10MB5280.namprd10.prod.outlook.com (2603:10b6:5:3a7::5) by
 DS0PR10MB6752.namprd10.prod.outlook.com (2603:10b6:8:13a::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.30; Wed, 14 May 2025 20:23:30 +0000
Received: from DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da]) by DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da%3]) with mapi id 15.20.8699.022; Wed, 14 May 2025
 20:23:29 +0000
Message-ID: <46713c5f-bada-40dc-9238-3e22df9107db@oracle.com>
Date: Wed, 14 May 2025 16:23:26 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/20] amd_iommu: Add helper function to extract the DTE
To: Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, Wei.Huang2@amd.com,
 clement.mathieu--drif@eviden.com, ethan.milon@eviden.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com
References: <20250502021605.1795985-1-alejandro.j.jimenez@oracle.com>
 <20250502021605.1795985-6-alejandro.j.jimenez@oracle.com>
 <89aa3b2f-092f-43a4-a96c-5755cf06efb9@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <89aa3b2f-092f-43a4-a96c-5755cf06efb9@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0170.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::25) To DS7PR10MB5280.namprd10.prod.outlook.com
 (2603:10b6:5:3a7::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5280:EE_|DS0PR10MB6752:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c4a9b25-1313-448f-a2e8-08dd93253063
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cFo3eFNyZnJJWGxNSFR1MGhHbExDL3o2VUVMWjZWU3BxeHJ3TDV1cVdyUDlj?=
 =?utf-8?B?L0ZFamJOYndWblVTeWFvaG9HdmxuVm1PRURyN3F3VW1WSkovR21qSlZRcDJr?=
 =?utf-8?B?Z0Zqc1JQcU1ZM1RUQTNVRzBHZ0dQU1c1TjV4eXZRN2lDWm5HUVRaOWJ6bEFa?=
 =?utf-8?B?YTc1TnhFRDdrZ3ZJckw4U3NxZzRHV3VDRjk1SXVNU0piQzFvRDI2d3ZkODcy?=
 =?utf-8?B?cTJEYVk5d0ppUjF2QTBqNUhpZDBWSkQ1c2w5SUFaaFV6RVNqOU53WHpnY0kv?=
 =?utf-8?B?SzlRaU9TMllUQUtrMmtPYk1oU2UrTXpTYnljdmtLZ2djT0s5THVYTldvWVBl?=
 =?utf-8?B?TTRBQm0vcmNQaW9rbFpMbHhKd01nczBKeGdmR1RUNWltMU5US0JoZDgrSUIz?=
 =?utf-8?B?ajNFOWRZR2FXSjVoK3pBQWtwbVlPYXE4S2FFTFhJeGxkdURXWCtocXZWVnRD?=
 =?utf-8?B?d3loWlpRYk9sQ0pVR1c1eTFEbnV6RGh4OGNKMTlJZ0NNRSsvVzNHajBwckZ3?=
 =?utf-8?B?eWRpUW5GZWVlbWtLOUpnanVQckxuOWtlekYrL1k1T00zZktqOEsvUkIvN1Ax?=
 =?utf-8?B?RnRtbWRaNFloSmJWbytaOXRGV2h3Rmdwc0h2T2hOMVgvMzF4TUIzR1JJbmxi?=
 =?utf-8?B?VHFSVFYwNDBncGpsMGlPUXNTbG9GSU5UaU5ScUZ1d0tva2tpTU94VytCMWw4?=
 =?utf-8?B?RThFbmU3Q3dNVEJ0emxpdVM3aDBDQzRXNi8xVTlRRUFCcnYwTXRQakQ0SFFr?=
 =?utf-8?B?TThkd1lxdXdISUc4OTJhdEVzU3AyTURGWE5td2FMa3ZoaDErYWpwSHhES2Nm?=
 =?utf-8?B?cWUrNnNtYzFqWEdJUFZGL3BmbDVkV2tKZ2pkWUJDWmZxRGJaVm04eXNSSlZh?=
 =?utf-8?B?YlIwb0xoMmpZcjJTNGJVQm8xSkNzbzJzNUo4N0ZPUWI5dk1rL2pqU1cvK2NJ?=
 =?utf-8?B?U1VFWUVXWmEwZU1jTktBSmUvZm1TZ0l3TS9veWNtTFpnZzFBYlo4ZEVKWGVC?=
 =?utf-8?B?SDhDMnlEVDU1cHhjUjZvaXVaZi9rSUJWakxleDhwcHFLeFc0RWN3d0Ftdnl2?=
 =?utf-8?B?MVc2VUJLcWYxUjBheWZ1U0pqSHB0dXhwY1hJMDBBRE1uQUlIODRxbVZzdk9u?=
 =?utf-8?B?UGdrU25uUVg4RnZmcEV4RDdONHVhVHZYMWpPMXBhZmd3NXVUVmNEL2VqM3FJ?=
 =?utf-8?B?T1RtQkpoMmxTbmIvQWVIdkc2Y0FqdDB2SXZkWHJycmh5RUI2K29rMktYSjJY?=
 =?utf-8?B?NUI1bnYrQXNsMklaQnVFclZEaUVTNXpaaUg4enllY0dEd0pJZjlUSmhhNW9o?=
 =?utf-8?B?N3pZY3NZS0lueW1VSnJJWFRDSXBmS2xYRWRCQTVCVEQ3enJ4NE5PL3ZuM3g0?=
 =?utf-8?B?UU9iaXdyVTdhYmxwQzdwNzY3QWIzUWVZL1ZwMGhITGRETStOTHJ6MGxEZlp5?=
 =?utf-8?B?V09WbzFxTDZwSlRNY2FHUFN0VGdEa1VEaWZEV2RoZ1BIakN5NTJtTmZLR0x5?=
 =?utf-8?B?OWtJYjMxcHROdXF6UFZDc0FKVkFERUNrcGpxUHFoT2pPTVVTaVJCMjlQS2NX?=
 =?utf-8?B?TUtUMXZSQ0lHWmduWG1MZVViVUFJZjUvaXlYcHI0S2JtQyswVjQ3V2greFk1?=
 =?utf-8?B?ZGpmTW44d05LVSs1c0c3K3REcklDQ0tEQ3kxQWl4cU1sN093dHZWMmp5TW5L?=
 =?utf-8?B?azFqbEtYb25RekwyQjRvQjltemdHbnAxb0FBOW5SaVdEQWphV2Q4L0h4NHdw?=
 =?utf-8?B?MDlpM2Y3RlNFTGhGUVBMVEVuWWk4ZlNVN3EzNVRUQmdSY2I4NXdsaEJidEZG?=
 =?utf-8?B?N2Evc25kMC9HMy9ZbExrZW90dFFJN2w5WnU0ZHoyakxHcXZtZUZDWVpOT2ZB?=
 =?utf-8?B?anlEdjhVVDIxVktVNXY3ZVphUDVUbXAvbWIvQlNJcFB2Ym1seWdsc1dkOXNy?=
 =?utf-8?Q?UbcvzayAs+M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB5280.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWJUQXNzK0MrRDU5ZUYwdnlDS0swS1RwdkQyRGFxWWZua3JFOVNKa0JwVFVE?=
 =?utf-8?B?R0JRNzFNa2dGUU9nWllweERYaWNLMzk2VW5Lb2pyZkJxSmhhUTFORjNnK1Qr?=
 =?utf-8?B?KzZWK3pvRHVPeisxN2U3QjFGQVZXeWI1RlkzMTRwS1VoUmhOeDljOW1Qc2wv?=
 =?utf-8?B?c0x1dGhKcm5nekFNWWdHU3h4UVJzYVc2dkFVWGVhNlpZcUh3U3ljNzV6dVls?=
 =?utf-8?B?bGZxeW5XMHRqMzVlVDZFcUgxaVBVNC9MOVROV1BvczlvZjNXSlkvZFhMMUQx?=
 =?utf-8?B?SHI3cmJrMVJ1bHZoMzZSVk9IV3lWYjZmSzBSYUw0Qk1zYjgvOEo1Q0JvTWY1?=
 =?utf-8?B?R2l5SURsUmhHTW9ZZTgrN1AxYVFLOTQrMmlRalZrUVpmSEVHbVdiaU9nVUFN?=
 =?utf-8?B?NEVwUk42cElLSVBiTHBwOXpTdXFqSGM4VTY2VGk5MzdTajRrRU1LTE93Q3Ja?=
 =?utf-8?B?NjVOWmdQSXdpR0JiQ2E0M1BaV0RrQXEyV1BaaW5jRytQK2tvZTFSdUZmUTRs?=
 =?utf-8?B?V1JoRXl3clhZaDE2YTEwSklZMG1QSnJ6dGNJeEh5NEt6dTZsaS94VGxmMVE1?=
 =?utf-8?B?RDN6TTJ4eHYxeFN2eFhvZnJ6MmJtOHZMVVdOTllHRjhZRTBOMDgwU0oxYjZj?=
 =?utf-8?B?K0dKMnA3WkFOOXFNeS9HRGVXWGNOVzNMaVlUMDIrS0ZZakNtL0ZPVWs4ME5I?=
 =?utf-8?B?MGhjbFlxTXc0bEl4TkEwWWxvVGFubGNHbVMwckVsL2k2cTdQem5vdjhXWDBD?=
 =?utf-8?B?N0RvQVNVdEpHWEt0UnB2QzNXemdzZGhXWWVzWUlmUzNTdWVTaTFMOEdnQ00r?=
 =?utf-8?B?M0lyOWsrcENNLzU1bGMyQkZ1ZGlBU25vek1TeHBhUU8zZUQ5V2h5bGthbjEv?=
 =?utf-8?B?WTFrWi9XNXJKeWZQcjFqNzFTSVNWTGRUUDNHM2NJU1VsVzQ4M0syWER0dzUr?=
 =?utf-8?B?azVzNVNIdW9BVGJ3QnFsV2YxZ3Y0ell3OXRobHR1NnNhK3E2Z1JJbFRGTGZq?=
 =?utf-8?B?U1NmcytkNmRFRUZMMVdOVVgwMXlkZk9DcElmWStGUmpsMUZhZFZ6akw0SVJx?=
 =?utf-8?B?TGxFSlV0YlExb1oxM3JhNGl5WXc3MHZaTU9VZWxZUEtEZi9iLzFUYnBtZU80?=
 =?utf-8?B?Uk96eGtITE1mN2dnUE9TbXlUWmhKdndJYTJCZDNwcVB5SlYvdGg2aTRSK05i?=
 =?utf-8?B?NVVySyt5VDI3S0V4dGFsTGkxemdVZm1VbHlpdEIyK1VjYStOU2dOTXM2UEps?=
 =?utf-8?B?dFVlTG1Tb0ZoSmdUOG1MbmQvK3ArQ1FxdFVNcHA2TUo5TmZNcC9Xb1hnQlkx?=
 =?utf-8?B?RHlsVmJ4ZDg1T214RlNxK3liWGJxbFE2MnJFTEVpZEVraVN1bG1HY0RzRUpo?=
 =?utf-8?B?b251QWNzZVpFTUtHYUtYdnhLRC9qRjlzZWluRHp1OEFOcjB4am04ZHFxNXBP?=
 =?utf-8?B?WVYrZ2R5UVYrKzFFb2ZFOUF2VUgzWkR3bFhpT051cTZaTVl6ZTg4K2NoRk1F?=
 =?utf-8?B?VG9VNlRsUkFpeWl2SnduNTdnSk85YlZuNlU0Y0ZLVlBYVWhQYlgvNEpITGtI?=
 =?utf-8?B?RWtxRFJoZElBOWFKSTR2cEVyYTRMOXl2NTYxSXdweXZSczRjMllPRUYvdW96?=
 =?utf-8?B?dVJwU0EwTWVtaGZ5S3poa1lQWWpRbWRMTDB6WTRPaEZhaWlMTGQ3NVNZRFdk?=
 =?utf-8?B?a2ZOUkxrekJYclpQWWtySXMrd0p2bDJTc2dVazZNanVpUytHbUNLWDl5Z3dK?=
 =?utf-8?B?VFp4TFMvbmhRTTMyeW9PSGMyTm9yTmlkYkk4bGFERyttVVovRGdvSTlkT0Q3?=
 =?utf-8?B?d0hwQ1VUdkVkQWlLamlsazYvVHlaQTExckk2R1ovMDJRY2s2czZ1ZGhrL1dh?=
 =?utf-8?B?R3RvYkRjTDBYVmdybTROSURrRjN0VVhaNm9FUkZBei85RzFtQWdRaGhIWWdG?=
 =?utf-8?B?ZmZSZXFja1hsOTBZaUVXZFpvQ2lER2NxZGN1Q2Z5Rnp0aUxJQktCMms2cmMv?=
 =?utf-8?B?UCtJcjB3VDhKQjlQODkxV1dBellXMFpnb1h0R3hCcWhieXZQeTFmZCtiWnBZ?=
 =?utf-8?B?NGRVdlcwalN1TG9NUDVtY2d4NGNHamMzb0s2TnViZmxBUEFGVHhPZktoOUgv?=
 =?utf-8?B?RUpnbEJ5cUFTcng1QXNMTDF4SStZUnllc3NhZVFsdnBuSTVhYU9RczRTb2hk?=
 =?utf-8?B?eUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RcwUGpKEg0heJaGLCY1lsGdtCLWF73NbqzhVmrcbaPzFS8Z4+PUNhA0WK9vsqJZhDk1vCGtyk2xemFsRmJMZp7/RJOLXTv0FzeQgRJFEcQk+7F0B2h7ZdgrEeG8fNQWU1c323KekFErX39Mk5V7qBvT3rBPXxV8TAoQqDoSqsrNQ/Y9Et7WbZ9Oc7xfyg/wzNpZ7zFrWw8/U9smzuFE1yFqZBAd4PhH9VxnImyQlGp75AIFadBIMsOmHqt1e1lNF3QkzYba7VP5hM7qs0m/1/qJwrp+tso6A6KYTKmYlr/2NhlI23UL4QLK0Krsjp8yzm6oIyqa8rw0E8jS9HLBQ/r/hsNKbho+mPv8oz+iKYpaOLLTglZPsg/ak/wCptYk4GSJYchCQ47XneY+XrDrjNJKBOUXpl1G3RoThPZe+18B+hUcchme59Lt4n4H9SA5ytSqpgCh2cC4ZX0NmHDWnYclvNiME7e8OAvaNojKmNWsqUGgbMJ0eFJU1lye2XrdQQlmCrI7a6ICA3aFsE7EnRj0R5BS85YOWNAAsNhqB/xbA3PLnas16h86uP275yPgORZffPQsoQj1qypJtElPneieUBE0j9UUOBvfDaCF6wiM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c4a9b25-1313-448f-a2e8-08dd93253063
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5280.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 20:23:29.3125 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J0m/OwU1WRSkrIiOYcQhydErPi/U5c8S2GLMXdc+smYCvEgaPHYzlQM7/xk9nx+U2nnxI/KpmVZwx1J4mmehpJE6u4c4aXa395qDGkTWtAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6752
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505140188
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDE4OCBTYWx0ZWRfX7CvUu1+PU5mq
 4myVztQzVmencPYTUPyRwed47FxMPsl7RhvgaTKy9x3bWeZ1vRvJezXl1Ak4SWI/8S6KqxrdqV+
 46ziFaVNXxkufEz3pOGMLVvIUWLaLSa26PslyahVxK7Ng2GIiWfnhJiJ1uJiPMdYZbFpFYTkddS
 P7cdZL8nfvAqx0UVjzDlBvMRPWkd3uHae4qZSRqefBKzlEOyNoMSS4t3sNJhgZ8viN7S5HBcE9o
 6hsc/HXmlEVOdL7YkiqAw4j6rqXJJSk9bYIUbMdbqSAnoqVJqAGjnuWJiWNRFDgTczsNiLNj8JQ
 nQGqsMYyqpCT8NBFzCPu6XjPeD1n9MDoavBV/Jpnp/hVss5rh4Xy0Pt4Bh/OWr/xGv5Qzgou6f2
 Wcg2CNekHvSffYZ2vz5tZhIR0IXkfeaRlyIoc9atc/b+LKn2Wqc3qWf7/096VUKCEhlD+9/+
X-Authority-Analysis: v=2.4 cv=Y8T4sgeN c=1 sm=1 tr=0 ts=6824fbc6 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10
 a=2EjKE5zawEpLhMi0F8EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13186
X-Proofpoint-GUID: FkrcPgM_8FsEhUHWhvrVAniwjx4ilHaR
X-Proofpoint-ORIG-GUID: FkrcPgM_8FsEhUHWhvrVAniwjx4ilHaR
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 5/12/25 2:45 AM, Sairaj Kodilkar wrote:
> 
> 
> On 5/2/2025 7:45 AM, Alejandro Jimenez wrote:

>> @@ -1035,13 +1070,13 @@ static void 
>> amdvi_do_translate(AMDVIAddressSpace *as, hwaddr addr,
>>           return;
>>       }
>> -    if (!amdvi_get_dte(s, devid, entry)) {
>> -        return;
>> -    }
>> +    dte_ret = amdvi_as_to_dte(as, entry);
>> -    /* devices with V = 0 are not translated */
>> -    if (!(entry[0] & AMDVI_DEV_VALID)) {
>> +    if (dte_ret == -AMDVI_FR_DTE_V) {
>> +        /* DTE[V]=0, address is passed untranslated */
>>           goto out;
>> +    } else if (dte_ret == -AMDVI_FR_DTE_TV) {
>> +        return;
>>       }
>>
> 
> Hi Alejandro,
> 
> You missed to handle -AMDVI_FR_DTE_RTR_ERR.

Good catch. I'll replace that block with:

+    dte_ret = amdvi_as_to_dte(as, entry);

-    /* devices with V = 0 are not translated */
-    if (!(entry[0] & AMDVI_DEV_VALID)) {
-        goto out;
+    if (dte_ret < 0) {
+        if (dte_ret == -AMDVI_FR_DTE_V) {
+            /* DTE[V]=0, address is passed untranslated */
+            goto out;
+        }
+        return;
      }

Alejandro

> 
> Regards
> Sairaj Kodilkar
> 
>>       amdvi_page_walk(as, entry, ret,
> 


