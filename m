Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52EC8CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 06:06:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZMwJ-0000WO-JB; Tue, 16 Jun 2026 02:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wZMwG-0000SG-FJ
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 02:06:20 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wZMwB-0004cE-Jn
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 02:06:20 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FKDhxP1343666; Tue, 16 Jun 2026 06:06:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=c7JY/QRi7VI7viVEJmqlKSX0sFnbMKRX92VHDfI2jpQ=; b=
 nWExqGbxcUQ5ow8Ii4GXuE+6OOQA4Y9G4yhX5iDWN0ZdH//asspdnonfVYXoGNPO
 PboSyP0Q8NVIctnfAfomlzLNEvQypP3zxJ2geIpKypIXU1sksBfYXj4Kv0CV9g9A
 Fb+U/USpcgvdXx4XXMgwpIgHTkIW5j0rEI/IZGuVCa0fvo5ROvciapPCrXcJM7ER
 YW5CIprzYI9oSo6Bpw0usfD5i0LyO0rTfccVtZuT811exPO719YOvtL1DxWGDCxX
 642GPKADIOngwvdMBCFq8cPdmjTi1mB/fNgikj4/9GR0/ORDerxjnsDElqWvrozV
 hFJoo6EZMAmye+AHnBdFsg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4es18m3s7s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jun 2026 06:06:04 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 65G5whCx031563; Tue, 16 Jun 2026 06:06:04 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11012042.outbound.protection.outlook.com
 [40.107.200.42])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4erwnpvg95-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jun 2026 06:06:04 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VG7aK5fCoet8F055ijkvHgv7hEAjlM1bldJhJJv6bfb6GWhz1Ghb4xCIDR/2inNKCHyk+7G6ErVvZIDL/zDinnkw3EalGp+qC5IJoEdaAGs53s/LyR2soq17CmmXCsusMnMqbCZG1urQtZFd/PGjk66zQeQbbydpRajzJ0CZc54MkDEGYT+E7fGBJEGf5S/YUlPWjV6SVtNW1iMp1x/ey9DMYx+YVsPyS1pRuufD1X3WTai3bRSo4bjtYmkdRgeokqUF4jAZ3Ol73QqfoLhP+f+38OVKc3aHsdxSIPGEqgJPjoh6v2ciIoIFuiwGtnIxlCW2s+EfMPRSr9q8TGNn4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7JY/QRi7VI7viVEJmqlKSX0sFnbMKRX92VHDfI2jpQ=;
 b=aVnLy/hctA7lj+SctWQegge089/kFM4GPs52lCvEZs1GfgALK9+SO9qmUP1GGht8B1CiOzr4UjSQ0x6cnHFRJ2HF0aefmsmo17kMhWeGJ0bwkBo1nN1+nk0wOMATfkheq7EabIFC3W89h8S6ACTmvDPIW44+iLcUSSSz+mPsrtf+IpJCEAl88ghb9PN0fFuP625OXRdk5+yjo8IzOH6Xsg5wlULnr/Y0k1D+tYFDgvnyC/bhnSI7WeyWU8kgy6wuzeFuagCtxBVYCjioAEkPbxCIbL/89T0Aip+98JKyEW29+32NwFgFNvSHauWvoVXsogRPtW9QGA4ZT5m1+J1zVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7JY/QRi7VI7viVEJmqlKSX0sFnbMKRX92VHDfI2jpQ=;
 b=tEE/q6kowJsSTpIQKP3XcvH8gZoH9PLVFj0axtIKU6vQCkTvFLRmBsRLF80lU5ZIASV6Ayb8prMb12wl4bUuL2+OXfafi39iS8VvYXivYo0I0j1b3yJMW88JtDzDJl+paeALPAY1NklKeTGLjCvA6l4w5SL4xMo317SfbGnacRs=
Received: from BN0PR10MB5109.namprd10.prod.outlook.com (2603:10b6:408:124::23)
 by DS0PR10MB7221.namprd10.prod.outlook.com (2603:10b6:8:f1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 06:06:01 +0000
Received: from BN0PR10MB5109.namprd10.prod.outlook.com
 ([fe80::d9fa:7ad2:804b:bb83]) by BN0PR10MB5109.namprd10.prod.outlook.com
 ([fe80::d9fa:7ad2:804b:bb83%6]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 06:06:00 +0000
Message-ID: <406d4a06-98b7-46cc-957a-d961daf96f72@oracle.com>
Date: Mon, 15 Jun 2026 23:05:56 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] migration: emit SETUP notification before CPR
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, sgarzare@redhat.com, farosas@suse.de, peterx@redhat.com,
 maciej.szmigiero@oracle.com, bchaney@akamai.com, mark.kanda@oracle.com,
 den@openvz.org
References: <20260612165110.431376-1-andrey.drobyshev@virtuozzo.com>
 <20260612165110.431376-2-andrey.drobyshev@virtuozzo.com>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <20260612165110.431376-2-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0051.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::26) To BN0PR10MB5109.namprd10.prod.outlook.com
 (2603:10b6:408:124::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5109:EE_|DS0PR10MB7221:EE_
X-MS-Office365-Filtering-Correlation-Id: d00420f4-a86d-4b1a-776e-08decb6d5654
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|4143699003|4133799003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: SAy6y03IRV2NEAWLiNjcNAmC05UT3wf+Ho7O8RZ2mN/xOgCvcNr8BHrbFvR3akOh5TrLjbYiv+yQCgY2wsuW6UfzyG8PK8ZL87xBokZjOIJW3+FAF51go26EJDKWVgKsW+/WuQ2/o1aaG/rae1m5QvwsGzhTJIzNgGueZigp48mKSdxSfoW0tPdL3QMuDwwJj7EreXo4d7+vvUpJAaaXF0mvYyjVWWhHUJaptAmVkVHI+q01n5cLZg/tXFpFsE7/caI90H1Em/IwKx08u+0zFEFAahCMp+SrVeRVsNSqVRtdPVGBGhe6Wnflx06pnLHNYxbByJL6rCIRQkcshrCcqnnZbaatZp1pM+MtuRBi0vSHeN2G4x6YaiQ4jIbZ6qeFQdKrVX8UwzdxzZ6GdwBOhHdQdskPs3JJmh7BomSuWurTM/MaY0dF0Dx0rIT1gsyN9Fb1XV/48Zb6zZf+9dmmzRya0zmLuwHwHsbwfrRVGSubXErewM6R+4XgVPRnFemIb/6dHUVo3IyRvh/zMnuSqRjbt8SufKIJpF0eTnoAZevrDNmXHxaIpUupPXqEMMIAveW09n0+f5elGAgsjeVnqvjRxTatSGlgzwn5T3xdBeljB3W02o9meDuYTW8QeclZoGl4S+59bqG/VbmRRCngbhKHrN/diCvUqHx3XHZluOPwBrMokOUcBaGCnDrKEYD2TTQekiKCAaBz7Pcx7TeLSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR10MB5109.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(4143699003)(4133799003)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UG1rZ0pzNkNMbStGcWdJM0FHMHBkaTZhVUZlRnBuSUppU2hSS2ZYS2tCM1dX?=
 =?utf-8?B?K2xZT21HTFJDaXd2S1R5L1Q0aUszZDNXd3N3OG9LazZVcUdwL3RRT0VCZkFE?=
 =?utf-8?B?dHp4Q1Z0dzdaV2hac1VLcHErdFlxWWlJTS9NTU1RZ3hSUnJHNzg4a2psSVo5?=
 =?utf-8?B?Vk42bHJKQWtjK2Z3d3hTdTNWQk4rbUhhaUZ3ZGM4OFRWYVFnSkVHTnc4OXdt?=
 =?utf-8?B?YjhhRytNQXptdlVsZ09aZjR3WUVnMUxHZjl4ZSs2MlV1cHNnQWJ6am5xbnBX?=
 =?utf-8?B?NWxpb1RsMEY0cTV4M0VWTXhQYUZwQmY5ZTJRRTF6eEN4elViWTUrTStUSmg2?=
 =?utf-8?B?b0hPNGw3dlQyL3RGWUNEM1V6UWRXK0JDcE1kL1FjOGM1VkRkT21GVmNEaG9B?=
 =?utf-8?B?eGU1dEEwVVhYQ25NWTJIckZnSnZuNmdmN0lBVExkeXFEVjZpSFlYTzB6YW5w?=
 =?utf-8?B?UUdtdkVLT25MOUh2U01sdjR2eTlmajRsbjZ1YVdBZkE1VlhWSVI5WklKcG9B?=
 =?utf-8?B?NWNPTnZrWDBlcVJDdFZYcUZ5WGNmTHVUaXpGYUh4eFgwcElvWDEwMnQ1TVJJ?=
 =?utf-8?B?a3lqeTYzWlIzV09JV0dObk8xWWNNaEgrZkFKS3pwQnZaMk5xN1Q0OFE0UXB2?=
 =?utf-8?B?ZnRVbGYwUzZMbys0bHVoNXcxclBWaGFaRlk2Y0lPWFZleDZKbGxvd1g2MTBs?=
 =?utf-8?B?cjU1V1RTL09VVFVPUmpxNWtONnl5ck41M2dBSlRKaU1GZmVpR05DdjZwdVpw?=
 =?utf-8?B?SkZTRktPeC9CR2VCQnNmSkpmZHhtaFJNVkxkT0EzeVA2MXlrRWdETFVuL3lF?=
 =?utf-8?B?dVBvVGtPU2ZhMU80L1JHeEthaDJXaGRNd3dJS0hHMytxT2h4LzFRcktIM0VE?=
 =?utf-8?B?a3hjSUptU1ViNmgxSXlCVTREakMxR2FjaTVHNEhZc2dCTlpRVkFxNkZtcUs3?=
 =?utf-8?B?RU5YQkcySDZ3Nll4RGFTNnZtRW1PektRRHcvbmtSdWFyYnA3Vm9vTFdrK3NM?=
 =?utf-8?B?K0hWNWo1akVIZlNSdnd5NzR2MG5WNmNFeW5MTW5wWG52VGZPUlQvVVRycVNG?=
 =?utf-8?B?bVhBTXBZT0VXcVp0YUxkRUovb3FjdXl0SGVtM21tVitlQ0thc0tPZ0N2RHpu?=
 =?utf-8?B?Umw1UGpMbEt3a0czTHg0cEtTYVNlVTFCemxKeVRidjJJTklEREp2bWU2Vi9F?=
 =?utf-8?B?bFZaaDVFUno4d29STDl2RXJtQldyU3V2WDQvc2Q3K0RvcUFOK0Yvc2JhN3dU?=
 =?utf-8?B?TXR6MHJOMmFKRTRkTGtYNEovbXdCYkEwaHFCZXFSRHJRSi8yUkp5OW5lV0gy?=
 =?utf-8?B?b0JlcjlLWFR3WFREUlRTZTVZeDBFbXNpdTc4QkhHT1JIRDc2NU9NVnd1cFM1?=
 =?utf-8?B?RjNhS1QrK2R6L2lPQjA1bHJvRzhWNHhpajBEaklGTTlJdjBNUlBrNjlMZVhp?=
 =?utf-8?B?VytIWE1oRG1VUGJSYjNJSFFLREhodFlDSHd1TU03Y3NEVUMwbFJBV0RWTHhX?=
 =?utf-8?B?YnlxWnhCRitLekwxMlhOUzhtY0RDZFdBRFpqSmhQT01NMmhYTUErek1vSHBr?=
 =?utf-8?B?RVd2V0NncVNUMDB1cXpjUlRKRGFHRnBrN2kzbWcwcDFLQmtFcytJc0tyM1F0?=
 =?utf-8?B?YzhmN2tmMlA1UXErb2thNFRhd2FJQlNYdUpHS2xmUHA2bnpkWS9pdXZMTTNo?=
 =?utf-8?B?bmk5dWRxODR0QzVvMFlDaXZJK0FOcHUyQXlJa2orcmRhWndYa211Z2lCVktY?=
 =?utf-8?B?VFA0dDdBSlBQZVlKekxhZjMvSVRaNjBYbFViYzBZc3l5aXNqVUZhazhIZEl6?=
 =?utf-8?B?REhxWnZvOVZHV21oWnQzU3dDS1R0UFdQUzFIMTZDRWI5ZEo0YjVrVkZIQkt1?=
 =?utf-8?B?SUZ6d3JDeTJuNDNNUVgveGJQWnlRb3oyaWF6a2R6OStMM2ZkUEluYVFiWFFY?=
 =?utf-8?B?ZXdERmlRN0VQWDd6N203bXVVSm5BZjJGRTFaYjhlN3FKWEhEUjZYZU1PdXpx?=
 =?utf-8?B?c2lmZ1NtdktwRzVaMElEMVh3TWJkSFNPT0NKdHJmbXFGSnlGNlZvMmRuSlAx?=
 =?utf-8?B?YVd0d2hPSGx1NHVVVkExQ29ZelRNekhtcFZIT3pnVmdPR1pteTM1L01GTnFE?=
 =?utf-8?B?R3pWc0pNZzAwaWhzNDA4S0RRWGRsaDFxQ21BSHNXNkJJMVQ1THQxdnFhTmpN?=
 =?utf-8?B?elNWQ3NaSGRnKzBqb1MwT25SblhPeTR4dElJd3pzWXZieXRocmwxSUo2NkNn?=
 =?utf-8?B?RFZHSUdCaFZ2cTQvQm93UXYzYXE0K0RTNjdoSTBDM290K2M3Mytyck85dWlQ?=
 =?utf-8?B?dWw2UEp5WU93T3FJcjZMc3Z1UlNZVmxPcjcrK1NCQkp6MHNIamVOWVh5UVZQ?=
 =?utf-8?Q?beMBS1b+YQyztBJ8=3D?=
X-Exchange-RoutingPolicyChecked: IfqCtwxcbcgSrUnjvOHcdw3wMPSQlI/3y4Mt+9p0STWII2SnCCcBGlylCqC5Ah0LZEwOWqXb+LNLlmYQk7V8H5Qk4IAOSpXs28Yr2hc6SxflsUTKZm82rjxZHFN7wBHZwgUAwTX5LcDCnLE95BVJPJ7l9JlyTcWDBX+Vwss717bE/tAqUF6/Za+hgyJNeHnfdlKYhMIBS+jLexApV6rcVJIACMb4POjqwKZ5f/G9JsM4bTOnCqGdHYjyEtdE63s9Bbk4QhPkOgnePMPBparHbW7ZEq3upcKntBOc90hCwd2zQyebjges+TUia6v87OtuFdcmqkrhNW6EPy58IxoBfQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: X2k1f3QPYQy6cxXRT/m3qv1cS4TU9/58qoiLMPKIXnqwpPmDwIctim+Ummwy57fQJ1k0sTHMMBCDl5A6/NuJ0hCPUL3F9r9WKNx0lpEcGJSyNXUy8kD7mrHTWn3YDKGmFejP4dzDZ0L2+btqy9SuxU1c0IfhTPV75oHgraz2Be7RBPVAhCZ+nuI4eQ8QgsrILHRvSrGFKvF10Gbsovl95N5lEQvzQOKwqcOqa2uuHJe37CF3+2YDccEnRP9vFqyk/ihzf324JUdWHYP9+Z/plKhnFy5+NcxdguE3g5qtENhIzE0w4M5NdlmlB3mHLsV8/kgGWQWhMh4bgIU1iNvshBI+ZEET3QXZ7K5/X+bz+aGXlum8z7BqDctbKEMrP5FzpZjWVcOI/oUK1kPkf54Kbes0vxsqS1A/GuVKq+mzenH21k7RkaVM6I9wDzKXFICvdogxqLFa/gwKfn6KGJpMNOX3vQZ5PZgFVzVSEgkBCPupK5BLl81uG5kasCshOWfnFe4bwmu3bjQl2pVGQ4HuqQA0otjjwWCNcFQ/zMAKE9DuQnRJKTOQ20fM3TpynRhsxpxItHNfxiCFjxIYM3S8wzT2qf/TenIFpQnKwwtAd0o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d00420f4-a86d-4b1a-776e-08decb6d5654
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5109.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 06:06:00.0960 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FIGY1vsa5MI8tQUks5BzfFXU39mmFgv7XUjK6/A8hwlKOxAOphbxdG7hL42wrfIm/mcjK8qj5d1Kfy11A61kFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7221
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_01,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606040000 definitions=main-2606160057
X-Proofpoint-ORIG-GUID: ND1FdmdOVkezfFBJ5iqtRtY0-2Di0he2
X-Authority-Analysis: v=2.4 cv=ROaD2Yi+ c=1 sm=1 tr=0 ts=6a30e7cc b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=VwQbUJbxAAAA:8
 a=X7Ea-ya5AAAA:8 a=yPCof4ZbAAAA:8 a=TYBLyS7eAAAA:8 a=xkv9UGrJE9ngxmcVdJMA:9
 a=QEXdDO2ut3YA:10 a=zvYvwCWiE4KgVXXeO06c:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12312
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDA1OCBTYWx0ZWRfXzK1wK11eYK2n
 xit6uKXAf8XDfSZOrCLIA+Sh7/v+7AYuxJvwZV1AF2NyDgIE9ciWulZ4N+04WLNIe93JIytnGAa
 v4fMZ93fAY65tYU7tI3owjGhd8ESlY6rEcI5mGgS9U7oX0/DEZEL
X-Proofpoint-GUID: ND1FdmdOVkezfFBJ5iqtRtY0-2Di0he2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDA1OCBTYWx0ZWRfX+Nydk5kDv2m5
 nwriAK28fNxd3KyeCAVqYI7AqU2wKa88enAXoTcQLSTVABLECJW6ZgMP2KxwByDAsmwjl1VnYFp
 469S2hp64C7OgVNHvHRzN6oRe3sua4Y+2OJjjokRPfEDdR8YrvxoBYq9e0hRr6dRPgVp++urXLR
 495M0sngiyOcgM8AtBH4vEdBBjgbbOoH0ld1CMMDVEg92VMXXQdvGcMfr7bCM5wegLE4TSiwDM0
 2M5I4GK+5a5KTyXb0XcyJC9DWSuKs4PlvSPgvo7HAD4OPyu1Zwn9kbODAjy+ZFkBe1bhuC8H4pO
 C7Q8bow3nvZ5QGGjAcijwp27ppJmi+glqt7gxmuLkDbwLO9R9ajx8GWJft7xubNV0eSToO4RZMw
 WRzyjnVkHoEYzQpvSR6mky00FcHXp4dwHP0kLhlpXg5NiYLbOK2RpzOUfVm2WHE7HdplQURCQDu
 JO2fMMOG04Y17m2jLKh2Y1WP94ikucOIQlyznWF8=
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0b-00069f02.pphosted.com
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



On 2026-06-12 9:51 AM, Andrey Drobyshev wrote:
> Devices register their own callbacks to MIG_EVENT_* notifications and
> process them accordingly.  But some devices, especially during CPR-style
> migration, might need to be aware and process SETUP event earlier on.  One
> such example is vhost-based devs, as they need to call RESET_OWNER ioctl
> before the target (in the cpr-transfer case) tries to call SET_OWNER.
> 
> Let's move SETUP notification to an earlier place in qmp_migrate().  Before
> this change, SETUP was firing shortly before migration thread creation, and
> FAILED notification balancing it was only fired from
> migration_iteration_finish() (ran in the thread).  But now by moving SETUP
> to earlier we widen the window.  Hence let's also add FAILED to
> migration_connect_error_propagate() and the special CPR-related case in
> migration_cancel(), to balance things out.
> 
> This patch is a rework of the change originally proposed by Steve and
> Ben at [0].
> 
> [0] https://urldefense.com/v3/__https://lore.kernel.org/qemu-devel/20260128-cpr-tap-v4-0-48e334d4216b@akamai.com__;!!ACWV5N9M2RV99hQ!PqTirI0SC9ktAapICP7w1YqQ7Fwlq0iPjHspIeoQU_M2xXPnQ1X5CJSCrLZEs5H-7rWU1DU_s-tNL6DD8riRAcMWPwp49pQVqQ$ 
> 
> Originally-by: Steve Sistare <steven.sistare@oracle.com>
> Originally-by: Ben Chaney <bchaney@akamai.com>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>  migration/migration.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 074d3f2c697..3c70467d314 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1471,6 +1471,13 @@ void migration_connect_error_propagate(MigrationState *s, Error *error)
>      migrate_error_propagate(s, error);
>  
>      if (!resume) {
> +        /*
> +         * Emit FAILED for every pre-thread failure/cancel that ends up here,
> +         * to balance the SETUP sent in qmp_migrate().
> +         */
> +        if (migration_has_failed(s)) {
> +            migration_call_notifiers(MIG_EVENT_FAILED, NULL);
> +        }
>          migration_cleanup(s);
>      }
>  }
> @@ -1530,6 +1537,12 @@ void migration_cancel(void)
>      if (cpr_transfer_source_active(s)) {
>          assert(migrate_mode() == MIG_MODE_CPR_TRANSFER);
>          assert(setup && !s->to_dst_file);
> +        /*
> +         * This path bypasses both migration_iteration_finish() and
> +         * migration_connect_error_propagate(), so emit FAILED here to balance
> +         * the SETUP sent in qmp_migrate(), before the VM is resumed.
> +         */
> +        migration_call_notifiers(MIG_EVENT_FAILED, NULL);
>          migration_cleanup(s);
>          /* Now all things should have been released */
>          assert(!cpr_transfer_source_active(s));
> @@ -2117,6 +2130,11 @@ void qmp_migrate(const char *uri, bool has_channels,
>       */
>      Error *local_err = NULL;
>  
> +    /* Notify before starting migration thread and before starting CPR */
> +    if (migration_call_notifiers(MIG_EVENT_SETUP, &local_err)) {
> +        goto out;
> +    }
> +

This affects not only CPR, but also regular live migration and postcopy recovery
(i.e. when resume=true). Even with resume=true, qmp_migrate() now triggers
MIG_EVENT_SETUP unconditionally at the beginning. If recovery fails,
migration_connect_error_propagate() treats it as the resume case and does not
trigger MIG_EVENT_FAILED.

Have you tested regular live migration with resume==true?

Thank you very much!

Dongli Zhang

>      if (!cpr_state_save(cpr_ch, &local_err)) {
>          goto out;
>      }
> @@ -3893,11 +3911,6 @@ void migration_start_outgoing(MigrationState *s)
>      } else {
>          /* This is a fresh new migration */
>          rate_limit = migrate_max_bandwidth();
> -
> -        /* Notify before starting migration thread */
> -        if (migration_call_notifiers(MIG_EVENT_SETUP, &local_err)) {
> -            goto fail;
> -        }
>      }
>  
>      migration_rate_set(rate_limit);


