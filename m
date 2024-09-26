Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 514E1CDE026
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 17:22:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stsBU-00038L-WD; Thu, 26 Sep 2024 13:21:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alan.adamson@oracle.com>)
 id 1stsBR-00036T-Ml; Thu, 26 Sep 2024 13:21:42 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alan.adamson@oracle.com>)
 id 1stsBO-0006FT-O5; Thu, 26 Sep 2024 13:21:41 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48QFiadR002947;
 Thu, 26 Sep 2024 17:21:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=bjOpQETTUZnFCtvf5MVbkIHYtPEwj0oWLkVda6XIRMI=; b=
 QukfnuY8ZTVXM2RH+qNWY+PXG4lgKzhkR4e1LzkbY0t1Aw4BZZhQ5Fvxm7XJlBPg
 i3tzTsFmGkS3DCR0pXen5LNvCg/1W8rws6Ma1WyXZ8RdSSXzZWU1Fep0PKBXTVEy
 agtDGTcO6J02dv010N5vvDVx8cWrnAWjJeUrUqYvP1FSzY+EppppgAaJi7groWoB
 yYj8FEB/q/GXqbd68Ex+Vzi/ztfRfaBZCEwNKz7CktUJxTTVYI13XWO1e4sY8F1u
 Xf/pTtK5h3qotKar2PxLthLDcStZEk8/I686HGYLlWnk2VF61C/S1YrgXpsP0WJ0
 nTuR+XJUi7PWLUF2x7JT2g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41sn2cwx5u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Sep 2024 17:21:28 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 48QGfHCv026227; Thu, 26 Sep 2024 17:21:27 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 41smkcedqj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Sep 2024 17:21:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HAeO5tkzxlV+Nuhad+lKxsh3/GmKYiHzNKuTJIcEDvXW7tFez2FMJiTSl6dr9U4U9npNBGPWIHl8ROHybTwdzFGsgK2NiL7oyNVlyrQcEioChrzdi29XZlzMH6eDrerrsAKmUbu1qy401YhLmHCJ0uSdlEUKfFTkTxobFoMy1ONFVqY7fah8CgLflVmMn5l1voCVAqvM6sJWiIufcuTnPD7RZsYtVkn3rusBTuxfYjQJMjn26DXcca3j7CO1hpsMSzHj77iuvDi5tONT/IumIYJhEeGSBS62y9dAK3uO3EySn0ygKiXNTeEJGuVY5aKOvigUSfTquhO0oe7OMQRn3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bjOpQETTUZnFCtvf5MVbkIHYtPEwj0oWLkVda6XIRMI=;
 b=riZ6BNELBlb8ywFXMZyvqyDAruwgsOpNGj0zsVkZl7j+RiyHX07MO2T41Md9aSu4Fe/+MD40tjkq8awK+zIvRi4o80HWTFTzraZBCFwBGIps8RALKvetb3BhMA/H5UesUqQWA10FHvyy/iKgoaGy7/+qhLMhk4tLoi5YlpTnq/wISu8U89CANyRdY+GKj9SqZYTP7JWug117nPMjgNtTr4LVUy+Rmscj25KXHyPjZ7D0TbCI2YGmoSRuvCz/18V+M+qDssTMB8RIg8c4LA19jc1j6krT+BBuEx8qJQO/pjNmOKF9v7VrCDLL2Nv42Ie0odc4ldDV5fXRpB5iM1qdtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjOpQETTUZnFCtvf5MVbkIHYtPEwj0oWLkVda6XIRMI=;
 b=GdvZThvLAMWBaNgdloJUffEDLyvnqzDkAxJXDKiZWA8AQ5EOxTBDz4+xetpzWrFD+fIUWIftoH8F44XaYaMsP68UrOiYRFVRWbW+TBm6vAE3m7Y6a+RV/0TxRLeNzi+I6TWm07ZJW3PhRFqkp107L8jZQfGUwkcZr8hGO69QLo4=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by CH0PR10MB4843.namprd10.prod.outlook.com (2603:10b6:610:cb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.9; Thu, 26 Sep
 2024 17:21:23 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::10a5:f5f4:a06d:ecdf]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::10a5:f5f4:a06d:ecdf%7]) with mapi id 15.20.8026.005; Thu, 26 Sep 2024
 17:21:23 +0000
Message-ID: <e14f59a1-33c9-49c5-a3ff-b0f6eb614c06@oracle.com>
Date: Thu, 26 Sep 2024 10:21:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] hw/nvme: add atomic write support
To: Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, kbusch@kernel.org, qemu-block@nongnu.org
References: <20240920000721.993119-1-alan.adamson@oracle.com>
 <20240920000721.993119-2-alan.adamson@oracle.com>
 <ZvKtZkmZNuw9_Qzf@AALNPWKJENSEN.aal.scsc.local>
Content-Language: en-US
From: alan.adamson@oracle.com
In-Reply-To: <ZvKtZkmZNuw9_Qzf@AALNPWKJENSEN.aal.scsc.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ2PR07CA0024.namprd07.prod.outlook.com
 (2603:10b6:a03:505::14) To SJ0PR10MB5550.namprd10.prod.outlook.com
 (2603:10b6:a03:3d3::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5550:EE_|CH0PR10MB4843:EE_
X-MS-Office365-Filtering-Correlation-Id: fa666457-0af2-4f15-8e71-08dcde4fa517
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dlpwZE53d0RtRGp2VmRUcTh0NUNnMFBEVzV0bmw4aFloQlloY1NHbEdNNXpo?=
 =?utf-8?B?N0I4QktPcENyamY3UmVRNVNtMC9iUnV6b05QQy9FVkJTekR6a25yN2dMM3Qx?=
 =?utf-8?B?dHFwMzVyeW9WUHZqTi9xTXBtUGxQcEhkU0R6MGV1Tk9TdzNqM2dCWFlYK1A5?=
 =?utf-8?B?RExGTlVNblNTUUJzdU5pVHd1VjVzM2dTbFZyY2pWNER0K3BHWTAvbWJpbFFR?=
 =?utf-8?B?N0VWcFJ4cld1OWptQ1RWUEhhOUJFV0llRkxWc3BIaW5XVmRaNVVXOTlYZno5?=
 =?utf-8?B?Q0hpSEhscUpWWHQ4S0dhaksvU3hxd1kwT254a2FrVGtlWEg1MGtkYTJ0ZGZz?=
 =?utf-8?B?M2tiZUdXNEJqSzJLdVlScHdQTlhXSlVSYzM5NVlhSG5WV0J4dXV1ZVBHUy9v?=
 =?utf-8?B?ZWNQRXUvamxLSTN5bFdiaTZxakNrd05KR203L093S3U1VzFQaDhZdnV5NnJD?=
 =?utf-8?B?YmpENHNCQzY4SnJvQ0RWaFNEeTFaMUlQME01Y1hXaXRJNVc0aHN2Wi9JNGZR?=
 =?utf-8?B?SnpvbjZzRWcrdWN1VzU1SzMyVkxuSmxDT0NTQk1DVkFuYk9mMTJZci9jNlpV?=
 =?utf-8?B?TVE0aVc0Q1d3YnBuN3Z2bStEcGtiSGlmZkRoWUlTV0JSRXcvd0ZDZDlXc0tK?=
 =?utf-8?B?TEVQUDBVMngzR1I2NjhWRklUY3JBWFloWFFJaGN6cHFrWCtOV3hFanVia09r?=
 =?utf-8?B?blhZSkxvY0dMWUJDcHNrU3oxcm5WcE1ITTl5ZlMyeEE0dkpFdjhJcFJGVXlk?=
 =?utf-8?B?SzRLYjBid0RYSUMxNlRDa0U5eVhCNHB1Q3N1aHBQTDNOWmNGeFk1ZUpUNTVo?=
 =?utf-8?B?UExTbnNnUUxXbXpncWhNN05SbUZaSW91V2I5WmkvN2VIYzRmK0x2bXg3Mnp5?=
 =?utf-8?B?eTAxcDJsZWpaMm53ODVmSUhsSEI4WGFGbnIyazh5UGV1MmF0YllOWEppNDFh?=
 =?utf-8?B?WjE1eEZMTVA4b2RkNXRJZVZ1czF6NWVLbTlXSEhkM2U2SW1QQ1NyVVVKa3RQ?=
 =?utf-8?B?K2J6a3gveUxwZkNROGRCMGpwM1pRNmM3Q1k4RGdHanBuRFVRSU5FeHM5YWlE?=
 =?utf-8?B?N3RXblY3RHdORTc0TmVoWHg1WmtVbGwxSXpnTlJNN1NReW1rS0xrTnkvakhE?=
 =?utf-8?B?UkF2cStNMk1sUDd0a0FrdXZuUi9kNlFHU2xjMEFWM1VRQUY5ZnN3Uy9BN1Av?=
 =?utf-8?B?NDdHMk9FRE1saVhPa284T0hDdEswNUJwOEt4cHFQRUZLSXg0SlZMbktlMjF3?=
 =?utf-8?B?N21QVFRUZ1VLYmVFNGpmNnZtWFNia2RIdDQrbHBFOTUrczNSRm52VU1GS2Qr?=
 =?utf-8?B?cVJkZFVFdFlGanJhU2NnNzlOekZRMDViT0Q1d0VZOHJSVWtjOHB1eHR1L0Fv?=
 =?utf-8?B?RjE1cXd5aVZDRHVuYVJvQStvRGZhd0d2a0ZRczE3cHdlTzJXbEFWZ0hadU9D?=
 =?utf-8?B?QUN2S1oyWnB4OEc5bk1Eb1lYZmwzV2FqMUpTMTFBMXNOSUdWL1dkeG9YYVQr?=
 =?utf-8?B?b0hqbStuYTRHL1BNZ01uTW5UMEdiZWx0NG5Wd2NJbnQ4THQxOWs1bzgwR2kr?=
 =?utf-8?B?RnRRRXNLWU9CaTA5V2RERndySDJLaEs5eFNvYXE3bEhGaEtXVS91QitOSzJZ?=
 =?utf-8?B?TUgzeCttMUFmWk5pemhXcEFUc0w2SEhqd25iY1grV2JIWUhydU9TTHFSUzJD?=
 =?utf-8?B?ald5NlRrZ1lYOGRWcW1mZ2pFT2dlU3M2ejJRaitqNlF2Q2JYWUExQzZMN0c3?=
 =?utf-8?B?TytDclFpRW12ekFaZ1BudDYvWXZRY3dWVmplWUw3M3paNm9qOG5BZFVOMG5S?=
 =?utf-8?B?VVJ1UkZHQ1ZPL0lGSFBqUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR10MB5550.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXVyQUQ4V2R3UjhiNkZibFhmUlkrYWRhOWxmeXlscVpnQ0xZTnhsTW1wVWxM?=
 =?utf-8?B?TmFxWFhxNFlxK0tmM1IrMzZWeE5Rd1JGNysyY0FVV25pbjRjVDJOY1BxamtJ?=
 =?utf-8?B?WGdvSVB5T3JLV2dMb0pQQVBtNkRjeTFSand5TUVlUHJTaVRBenRLUnFDOUpk?=
 =?utf-8?B?c2s0cncvOUtVMVZDdERFS1FZYjR6WE54NUFHSmJuakhZNFlsaHptOGxWUWJU?=
 =?utf-8?B?Q2FPN2ZDSHhBQzBEYzl2c3NweUtpUWUxYUthbWRGQW9wNlRvSW9JY1BIVzZR?=
 =?utf-8?B?MFhKV0txUXhzUEhHcm1CZW5FaVFlQmdlMUQ1UHlxbnYzTHZad1pmOHpOeXd1?=
 =?utf-8?B?T1N6bzlPdURPVDBJQWJWa1J0dDMvdGF5N2xBd2d3ZDJPempFR2tyUlFjaE0y?=
 =?utf-8?B?b1E0b2VoU2ZmTkxzd2pQQnR0K2V2S3M4bE1wem5aMHQvRmFhUVRGdWRka1Zy?=
 =?utf-8?B?TEwxcjVTSUswUjBONnFtbmJwZjM2alBZSHZrUklnNTVRTWtXUWZMRFJVYUU4?=
 =?utf-8?B?K1BqeUJNa3JmV3AwcjYzVU5CNFJvVGtFeWowMmxLMjdlYUN2bFVYOEJINWpP?=
 =?utf-8?B?c2ZaUFZXWngxdllJdVBpSkNOZlFaUzNXNHJ2NEUxSHByNDVxYXNhNy9PL1NZ?=
 =?utf-8?B?NFFsTTdIVklYczJEMlNpZ3doRmZvUTEzSnBrbFVidFAwamJGem5aRnJnUGdC?=
 =?utf-8?B?NlAwWjRtUng0VDkzcThlL1N4NkY0ckpSajY5L1ZjdlV2ZmpzNFgzVUJTZ1NB?=
 =?utf-8?B?UW9VcWp0UitXd1RtRE5ZYVFSdW9vaG1UWVl4VHJua0NCdXY1U3pGTzdEbFdj?=
 =?utf-8?B?M3hQYU1OanJMNG5OeWpyT3FPZDBkbWl3UXJVSWVSTGNnZlFlS1d6WDBZTHNX?=
 =?utf-8?B?MC9xWU1xbDV5bXVtRzV0bDMwODJ6ZStNRitmK0RWd0xiSTJGcEQ2OCtZeE9x?=
 =?utf-8?B?V1NwdU5KSG5vS0pYWThPVCtsRVJrYnMrcXdtVkx5OUF5UEZVcjBnSFBoZnQ5?=
 =?utf-8?B?elo1ZHBKc1hSZ3hqVlUvVVRDbzBtVTFLMjljVml1M2NFU2N1dGxNN3N4U0xa?=
 =?utf-8?B?eWkwdGdWbTQvRmJTVVRmbGpyRlhhTUFPTjFYUFM0cCtydStaRDhweHloNUpS?=
 =?utf-8?B?ODFKOGgwMWtxY1FWWFp5UUVya1U0alBBbmdBeXlzNjZPQndwV3AyYWRYUkR6?=
 =?utf-8?B?TTh6QmpMbm5WbHphWXN4S3huNnFWbTNaY0x0WDNpVWdudmc2cUhqQVpaNWE0?=
 =?utf-8?B?SkpFNkpXQmNoT0xaUHBqRmdoTUJJWjJIcnJXN1ViajA0Sk80NDZiU3Vkc0Zn?=
 =?utf-8?B?NGdOWjU0Njcxb3V6dld5TjU4MlJOL29RdkxtWlQ1bWFMQzZtcTROZ3FYNzB6?=
 =?utf-8?B?ZmYvbmpweXdvWFIwRXk2eU1rL0RmaWc3MmtmYnkyd2dkMGZwNUprdGhzZ3Vy?=
 =?utf-8?B?dllkMk9iYXJZS0FVYmNNSGY3MWYvNXBsRmllNHNWNHQ0NWlNbmxoajV5L2Jr?=
 =?utf-8?B?M0huWTU5MUZZbFNveUxtNWREdjNLelIrOHNDQ2ZEL1pyNFlSeXhFUzF6K1J5?=
 =?utf-8?B?elBIOVBTekxqMmRUT1pyRlFLMEdoTzEyaHJiYzBiempzcm9ZcTJiY2xIRi9T?=
 =?utf-8?B?VkFPdkQvdVdpVXUwaHdET0JpTStEU0preXU4a2JxSGVvSVhBS3dWVXZOaERj?=
 =?utf-8?B?OS9xbFVneGxsdXEyeVpNV1g1RjJ2b1Zsd21WV1A5T25xeWdFUTIyY2hEcXhy?=
 =?utf-8?B?ei9tcS9XK25nVUdWcFR0aENrQ0RFRWZBUmNQaG9EREZySWtlVUVEVWw4dk14?=
 =?utf-8?B?dUZqdWdJbDMrR0wyYUNTMGtheit6TmJkWUlDRTc1RHphNVVDQVpFc2cwV3Vh?=
 =?utf-8?B?S2ZWdEdzczlKSmcvaVFJN0V0K0Nsb3VBa2RSWnhFTTZtNHc4RXhJZXZKaWdY?=
 =?utf-8?B?YzIyc2ZHbndWUXd4RzZ2RWwvekFmcUFQSVhFalpqTHlCdVV5NlNQOHV0cUkw?=
 =?utf-8?B?SjhpQW9sMW0vVENKS3k2dHBKVGVRRERpZ1V6ZE5VWk82cERLZDdrb3JYYUt3?=
 =?utf-8?B?TzRPTzRHYTA3WmFTTXZKaEwxdkpZYUxqeVpXOFFVcDI3L2FxQ1JDWlg3anBC?=
 =?utf-8?Q?46JMG5CR8+ukY5oO5envFV9DH?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YuJwKEkwcvMdKrLp9NH+KGV+Yx8BqBgEIzawK/fBslnHUOwr3f7GXFVq4jBcfwH5wgZenvZ+7a4ssKN9Yy26eo2q+CSp+RsI3yz50PbHs6NKtW+rcYve4VFm3cj9iAtv9Xq5DuOkFAR2EP20cIlyu+AbmvD97BW2Xx249w7R1BamWJomBO12bUIM39raHDsxWw0I1ni4SARyA2cAX00W7JLgZyFI0KaRuMzud+YcGCjIfbVz4dW7vQnPFXVmg3pi8fIDzVUdlmXze4j0pepEnPXkaN+yGglX6XFdTtLAHn0Mbn5QqyyrbZcb/yhvbGv2aLXQiD8ymRSQfkJE4R1nMdWg0wrNmNQDiwFpVs60DtAi1ukvpRe4NhmIr3FucHoK1zgqOVNa+9mfwAnc9OLKM50fePoSM0kOaQtVpKG5zc9PRN9VACiLsEzPHYMAARiq7jzUlzFF5tDh7PJ+ZvrMfxwd7h/OaFf08jTLe4r7Cw1K8Hl9nHlwc5Hj9rkSrKCyxcmIfh63s9L+muAV8oO5Cj7z5cwxGJBhl6aOKRDFzbDgIuze4sjaVIjTa0UTXdxpiBfs+YA3aqB6SMSv5/SDq5SALiQ4X5oIz6ughdK0dgA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa666457-0af2-4f15-8e71-08dcde4fa517
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 17:21:23.4545 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aZM21SZP6y1ymd5uqdshiTBC/nrhRqLZufTL4e09VWR8ffeUf2VXg6a5uat7yOzqYAYXeVhoB/Q+c7OzswvyBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4843
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-26_04,2024-09-26_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 phishscore=0 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409260120
X-Proofpoint-GUID: M90XEWzgSBbMZcQco6dDAkPOhQgasa2k
X-Proofpoint-ORIG-GUID: M90XEWzgSBbMZcQco6dDAkPOhQgasa2k
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alan.adamson@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


On 9/24/24 5:15 AM, Klaus Jensen wrote:
> On Sep 19 17:07, Alan Adamson wrote:
>> Adds support for the controller atomic parameters: AWUN and AWUPF. Atomic
>> Compare and Write Unit (ACWU) is not currently supported.
>>
>> Writes that adhere to the ACWU and AWUPF parameters are guaranteed to be atomic.
>>
>> New NVMe QEMU Parameters (See NVMe Specification for details):
>>         atomic.dn (default off) - Set the value of Disable Normal.
>>         atomic.awun=UINT16 (default: 0)
>>         atomic.awupf=UINT16 (default: 0)
>>
>> By default (Disable Normal set to zero), the maximum atomic write size is
>> set to the AWUN value.  If Disable Normal is set, the maximum atomic write
>> size is set to AWUPF.
>>
>> Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
>> Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
>> ---
>>   hw/nvme/ctrl.c | 164 ++++++++++++++++++++++++++++++++++++++++++++++++-
>>   hw/nvme/nvme.h |  12 ++++
>>   2 files changed, 175 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
>> index 9e94a2405407..0af46c57ee86 100644
>> --- a/hw/nvme/ctrl.c
>> +++ b/hw/nvme/ctrl.c
>> @@ -40,6 +40,9 @@
>>    *              sriov_vi_flexible=<N[optional]> \
>>    *              sriov_max_vi_per_vf=<N[optional]> \
>>    *              sriov_max_vq_per_vf=<N[optional]> \
>> + *              atomic.dn=<on|off[optional]>, \
>> + *              atomic.awun<N[optional]>, \
>> + *              atomic.awupf<N[optional]>, \
>>    *              subsys=<subsys_id>
>>    *      -device nvme-ns,drive=<drive_id>,bus=<bus_name>,nsid=<nsid>,\
>>    *              zoned=<true|false[optional]>, \
>> @@ -254,6 +257,7 @@ static const uint32_t nvme_feature_cap[NVME_FID_MAX] = {
>>       [NVME_ERROR_RECOVERY]           = NVME_FEAT_CAP_CHANGE | NVME_FEAT_CAP_NS,
>>       [NVME_VOLATILE_WRITE_CACHE]     = NVME_FEAT_CAP_CHANGE,
>>       [NVME_NUMBER_OF_QUEUES]         = NVME_FEAT_CAP_CHANGE,
>> +    [NVME_WRITE_ATOMICITY]          = NVME_FEAT_CAP_CHANGE,
>>       [NVME_ASYNCHRONOUS_EVENT_CONF]  = NVME_FEAT_CAP_CHANGE,
>>       [NVME_TIMESTAMP]                = NVME_FEAT_CAP_CHANGE,
>>       [NVME_HOST_BEHAVIOR_SUPPORT]    = NVME_FEAT_CAP_CHANGE,
>> @@ -6293,8 +6297,10 @@ defaults:
>>           if (ret) {
>>               return ret;
>>           }
>> -        goto out;
>> +        break;
>>   
>> +    case NVME_WRITE_ATOMICITY:
>> +        result = n->dn;
>>           break;
>>       default:
>>           result = nvme_feature_default[fid];
>> @@ -6378,6 +6384,8 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
>>       uint8_t save = NVME_SETFEAT_SAVE(dw10);
>>       uint16_t status;
>>       int i;
>> +    NvmeIdCtrl *id = &n->id_ctrl;
>> +    NvmeAtomic *atomic = &n->atomic;
>>   
>>       trace_pci_nvme_setfeat(nvme_cid(req), nsid, fid, save, dw11);
>>   
>> @@ -6530,6 +6538,22 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
>>           return NVME_CMD_SEQ_ERROR | NVME_DNR;
>>       case NVME_FDP_EVENTS:
>>           return nvme_set_feature_fdp_events(n, ns, req);
>> +    case NVME_WRITE_ATOMICITY:
>> +
>> +        n->dn = 0x1 & dw11;
>> +
>> +        if (n->dn) {
>> +            atomic->atomic_max_write_size = id->awupf + 1;
>> +        } else {
>> +            atomic->atomic_max_write_size = id->awun + 1;
>> +        }
> le16_to_cpu()'s needed here.
>
>> +
>> +        if (atomic->atomic_max_write_size == 1) {
>> +            atomic->atomic_writes = 0;
>> +        } else {
>> +            atomic->atomic_writes = 1;
>> +        }
>> +        break;
>>       default:
>>           return NVME_FEAT_NOT_CHANGEABLE | NVME_DNR;
>>       }
>> @@ -7227,6 +7251,80 @@ static void nvme_update_sq_tail(NvmeSQueue *sq)
>>       trace_pci_nvme_update_sq_tail(sq->sqid, sq->tail);
>>   }
>>   
>> +#define NVME_ATOMIC_NO_START        0
>> +#define NVME_ATOMIC_START_ATOMIC    1
>> +#define NVME_ATOMIC_START_NONATOMIC 2
>> +
>> +static int nvme_atomic_write_check(NvmeCtrl *n, NvmeCmd *cmd,
>> +    NvmeAtomic *atomic)
>> +{
>> +    NvmeRwCmd *rw = (NvmeRwCmd *)cmd;
>> +    uint64_t slba = le64_to_cpu(rw->slba);
>> +    uint32_t nlb = (uint32_t)le16_to_cpu(rw->nlb);
>> +    uint64_t elba = slba + nlb;
>> +    bool cmd_atomic_wr = true;
>> +    int i;
>> +
>> +    if ((cmd->opcode == NVME_CMD_READ) || ((cmd->opcode == NVME_CMD_WRITE) &&
>> +        ((rw->nlb + 1) > atomic->atomic_max_write_size))) {
>> +        cmd_atomic_wr = false;
>> +    }
>> +
>> +    /*
>> +     * Walk the queues to see if there are any atomic conflicts.
>> +     */
>> +    for (i = 1; i < n->params.max_ioqpairs + 1; i++) {
>> +        NvmeSQueue *sq;
>> +        NvmeRequest *req;
>> +        NvmeRwCmd *req_rw;
>> +        uint64_t req_slba;
>> +        uint32_t req_nlb;
>> +        uint64_t req_elba;
>> +
>> +        sq = n->sq[i];
>> +        if (!sq) {
>> +            break;
> This needs to be a `continue`.
>
>> +        }
>> +
>> +        /*
>> +         * Walk all the requests on a given queue.
>> +         */
>> +        QTAILQ_FOREACH(req, &sq->out_req_list, entry) {
>> +            req_rw = (NvmeRwCmd *)&req->cmd;
>> +
>> +            if (((req_rw->opcode == NVME_CMD_WRITE) || (req_rw->opcode == NVME_CMD_READ)) &&
>> +                (cmd->nsid == req->ns->params.nsid)) {
>> +                req_slba = le64_to_cpu(req_rw->slba);
>> +                req_nlb = (uint32_t)le16_to_cpu(req_rw->nlb);
>> +                req_elba = req_slba + req_nlb;
>> +
>> +                if (cmd_atomic_wr) {
>> +                    if ((elba >= req_slba) && (slba <= req_elba)) {
>> +                        return NVME_ATOMIC_NO_START;
>> +                    }
>> +                } else {
>> +                    if (req->atomic_write && ((elba >= req_slba) &&
>> +                        (slba <= req_elba))) {
>> +                        return NVME_ATOMIC_NO_START;
>> +                    }
>> +                }
>> +            }
>> +        }
>> +    }
>> +    if (cmd_atomic_wr) {
>> +        return NVME_ATOMIC_START_ATOMIC;
>> +    }
>> +    return NVME_ATOMIC_START_NONATOMIC;
>> +}
>> +
>> +static NvmeAtomic *nvme_get_atomic(NvmeCtrl *n, NvmeCmd *cmd)
>> +{
>> +    if (n->atomic.atomic_writes) {
>> +        return &n->atomic;
>> +    }
>> +    return NULL;
>> +}
>> +
>>   static void nvme_process_sq(void *opaque)
>>   {
>>       NvmeSQueue *sq = opaque;
>> @@ -7243,6 +7341,9 @@ static void nvme_process_sq(void *opaque)
>>       }
>>   
>>       while (!(nvme_sq_empty(sq) || QTAILQ_EMPTY(&sq->req_list))) {
>> +        NvmeAtomic *atomic;
>> +        bool cmd_is_atomic;
>> +
>>           addr = sq->dma_addr + (sq->head << NVME_SQES);
>>           if (nvme_addr_read(n, addr, (void *)&cmd, sizeof(cmd))) {
>>               trace_pci_nvme_err_addr_read(addr);
>> @@ -7250,6 +7351,28 @@ static void nvme_process_sq(void *opaque)
>>               stl_le_p(&n->bar.csts, NVME_CSTS_FAILED);
>>               break;
>>           }
>> +
>> +        atomic = nvme_get_atomic(n, &cmd);
>> +
>> +        cmd_is_atomic = false;
>> +        if (sq->sqid && atomic) {
>> +            int ret;
>> +
>> +            qemu_mutex_lock(&atomic->atomic_lock);
> I don't think this needs to be protected by a lock. The nvme emulation
> is running in the main loop, so a Set Feature cannot be processed at the
> same time as this. I think that is what we are expecting to guard
> against?
>
> If I/O queues were processed from an iothread, this would be needed, but
> then we also need to take the lock when processing the feature and a
> bunch of other stuff might become more complicated.
>
> For now, I think it can just be dropped since if we enable the user to
> attach an iothread, my intention is to reduce such complexity by
> disabling all the "faked" features of the device.

I verified removing the locks doesn't have any issues.  I'll include 
this and the requests in v3.

What's the plan for iothread support, just a single thread per 
controller (for all queues) or a iothread per queue?

Thanks,

Alan


