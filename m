Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92FD6CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 19:21:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG06X-0000CX-La; Mon, 03 Nov 2025 14:20:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1vG06V-0000C3-4T
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 14:20:35 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1vG06H-0000rm-Qe
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 14:20:34 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3IWP7q008958;
 Mon, 3 Nov 2025 19:20:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=Eq3aZ4bAVxG0cXIikKcEXaC1uU9pxMR2qiycdKWfWTQ=; b=
 TpGXuw2jO9MRsAjR71pLQHDouLmEsh4Kiww8jICfTWihXM6yB1syK7Z2aYOj2o0i
 ZdszpBlDQxxa4FSj5czIBwPGqpmO0b0bxtOgyQjO1XKKSdY1IEF6CV4knNBQQfcz
 yHfDvOrU6voyu4b3odhMfdMTrHwZfJp9L8exmbCdQR+Xm5agyrwoh1ELKE70Bb2Y
 MkOlnwoLkF6RTOur3BWqVgc8VJxd0EEO4ajn8Dwsg6W0aRzU0ir7jdAS3CeIe8YH
 RJODPcXjzbhthaQSOMCXyZZ7iLm4qcKPJywHNgiu1ugCRgMV537h5UM9S0zTsO0M
 iZPzQnoB97LragCqLPdgDg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a71rj84xp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 03 Nov 2025 19:20:14 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 5A3ILFG0007950; Mon, 3 Nov 2025 19:20:14 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11011009.outbound.protection.outlook.com [40.107.208.9])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4a58nc3q8n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 03 Nov 2025 19:20:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yje8RuCKD9QnXZj6Z6N0GC9M38wbgMui8hKn5pLG0TGP9IIVCoWI4LsqY0pkB1maG8KH8i/w9X7vbBTGiKO4zEsybcRQJu37wm0J5Xiovwa938D5FmAMRP+oHoZrZUchEiXoxSwKegYMWyB2kBV+15li2CxEkqV3+1Mr0IfGObvbNr/6rXCE1TPbUTS6kzCFlRg5Xz9fhnqONmzrFCDSM05le4BxogqoXh/pgIiJvk72U1tKfoFE8+9Lam9LlojcSaYWbeOq4iG+u/NXd/IJaiE6H1dYIVg1cPCmjOu1NJk3BLcL0YrbyI0RwYHoVEmzMp/HmwcQKiYhYNDiorOVCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eq3aZ4bAVxG0cXIikKcEXaC1uU9pxMR2qiycdKWfWTQ=;
 b=eAfuYwMhhHSunFzPxoScdcPAqdGFEU6jcDPfL5f6w/Xp6F3TuDntdVb1NvrMxcIbyslhx3VOTdEvNJ0Jr7OhJuhj51b8h5JtPi2t/L7gNrgBRVR8Npsj/Q3m6jV1Zlwi0Rir/ht8A05AhDgN9JqwMniNpucnuwN5mc/rHdHTV+9w5hwC+Tjt0pDuX9EZ5l+Lgtkh80DCNNZWTQEpBTe1v4QaOYG9/Pd6Zl0RvS+dM2eRhDc8sjhZDbajtY67Vz6Y4Dfsw60DX+hxfGKDqBRZ0lJG42uI6+/P5QkO76TDDNjSDXxWCucSpuWmK8DG5q2O1Ykub0mQOB/nKaajnEwcLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eq3aZ4bAVxG0cXIikKcEXaC1uU9pxMR2qiycdKWfWTQ=;
 b=f8grTVW3iS2f092xxYN0pP6ErAoogW/VUT8hD90EOSJJFYl+KDoCtnUNhbpd/5LDBCEMxy6RKPXh0rUIFHq/NStfuhYJPdjGPVAaK2XVNwuIKcXBCy74V5CzTNH0bkEdJvC7ZxaPR6MYa5vHCWQvJhoohiIPOM401jAfnUuy+5c=
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by SJ5PPF6998A7572.namprd10.prod.outlook.com
 (2603:10b6:a0f:fc02::7a3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 19:20:08 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%4]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 19:20:07 +0000
Message-ID: <97619da7-d0e6-4079-b4ee-71b15384d091@oracle.com>
Date: Mon, 3 Nov 2025 14:20:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] amd_iommu: Support 64 bit address for IOTLB lookup
To: "Michael S. Tsirkin" <mst@redhat.com>, Sairaj Kodilkar <sarunkod@amd.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, richard.henderson@linaro.org, 
 philmd@linaro.org, suravee.suthikulpanit@amd.com, vasant.hegde@amd.com,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net, aik@amd.com
References: <20251017061322.1584-1-sarunkod@amd.com>
 <20251017061322.1584-3-sarunkod@amd.com>
 <20251103111145-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <20251103111145-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR21CA0023.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::20) To BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|SJ5PPF6998A7572:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a07d7bf-8095-4c0a-ff1c-08de1b0e0008
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bm9ubmtweWpUeWJTaHhSZzFoOW5HSUk0c1hKbGFlS2pJTWdOVDRiWjVJTDNS?=
 =?utf-8?B?ckdkcnJGc0RoeGRHN2xvRGFFMXVQc2x6dDMwNGNydDdPeGZQdysvekNjMlhm?=
 =?utf-8?B?SFZZaWZVeGpJTzNaQ0hOK2dEUTFUNzFDVitkWG0xclJxVHhNd09odzNQTnlJ?=
 =?utf-8?B?WXlZNGVDUURuRUppWk5VWHhZYytGYXAzeGN5ZER2d2pIckJ2cnRlUEtETWZV?=
 =?utf-8?B?c0l2ZVBSaGFBRCtQRDY1OStERnRyaXJVb09rN2FxZzFmUkZjOFcrRVVscnN5?=
 =?utf-8?B?TytCVHhzdEpSMGwvODcrczdOcjJFaTNKSnI0SWJRdXJTNEZBMnR3NGJ4RWJY?=
 =?utf-8?B?Q0gvNjNoK04reWhVbWxscThBdlphaVRSRnBlRzdjVy8vbTVrKzdxaURSeldk?=
 =?utf-8?B?QUNwY1B3TGNNWnlYeUhTZzUwU09DSkx3ZEdrRk5GV3VxRFV1dVljcmV1SGZ0?=
 =?utf-8?B?dmJxSEN2ak4vOTRHZG9JMUViamJDdnB6aUpmcTUrZXo3dXRQV3V2elNLL3k4?=
 =?utf-8?B?L3BFMEFRZ3VwZ0V3cVRTRmt4RG0rdmNwWUdpMHFORjFkaFVpZU5jb21vNXlj?=
 =?utf-8?B?enYwemRpVTZ5c3NJbFZ0OWhFYnVNN1BkYk1ncFFUd3h4N2FyU2hYaXgyejVa?=
 =?utf-8?B?SDM4SFc1cnZTeEdzRmVsRURQRWsvL2dxY2VWVDZ0RjZPV0VYaENiVlhRS25m?=
 =?utf-8?B?NGN6U25GTzAveElDWkdSOE9NdXNkWTQzV0t1amRCQkJKcEQwc0JPR01rZzJC?=
 =?utf-8?B?RUFySjY3ZU51a1Bmd2JXaHpycFpXSTBkTTljb2VlNlUxMXNDS09HemhJUW1s?=
 =?utf-8?B?YVhPVkVQeFNtS2U0ZXVSWTJyVE1DY1JlV0NibTBzVjBEeE1OanRnVENKYkYy?=
 =?utf-8?B?dVUycXJBZU5sdXJJMDRjQWhmeHc0dXRTNTg0ZjQ1bGpaZnZ5djFDNnJETC9G?=
 =?utf-8?B?bWh2bE9uNkw3TE5iOFgxMFZDbFhDYWltUUVQVzIyTDdBazlnVC9EdmgyN0hT?=
 =?utf-8?B?UlJqRDVjeVUwTUlOOHJER0F2S3BUbVZMZ2lBYVhBZUo3ckpFcEFZWkMrbDM4?=
 =?utf-8?B?SFJ5bkdJUlVkRFBxM0wxQjZxc1ZMM1htaUtXK2d1WGQveWNPU0d2aHIrTTRi?=
 =?utf-8?B?ZWt2eEk0T0lKaWZST3lOY1F3VjZpQldFVUI1a3VJRWEwaTV0MTJBeHBWQUEw?=
 =?utf-8?B?bG9xVjZCQmd2a05xYTdBc1JCd3MyTnNDRWdJRFQxZ2pCeUo5VHJsMFNiZWI4?=
 =?utf-8?B?cWQ4UzJkcXV6WmdObmR1MHp3ZEljbjVaVGhmdER6cmxZRDFFT3dUbDV3d3JB?=
 =?utf-8?B?d3dPcklwb0doak9QOXorWWZKRmF5cXRXZmg1N1c1RmlwZ0lFUXFUYUVYeUVF?=
 =?utf-8?B?R05LUEVJYmJSMDZvTGhhNk5BWWk4WEFRNW1RYTRxbzhPR1VQS2Nka0VHbldw?=
 =?utf-8?B?WTJYNEJNQnQrSjdwWGNjTnVhRnBxRjlCT3NlbzMrSmhhRVRhdVU2UXM4TWRL?=
 =?utf-8?B?d2N2NktBd292SFlacCtYM2k1ckRwVTJmSzF1cDFFemNDemtsczB5emRObGF3?=
 =?utf-8?B?R01qUGtMUlRjR3RQbzFmOFpGcXk0aU55cXp3R0c0UjNqdnRIalE3RjBqWUdM?=
 =?utf-8?B?cSt0Ui9BTUptRVZNSG9hUUdwQVE4bDNGSlBIM0ZRZU1jcFRSVFFEdlJUbkY1?=
 =?utf-8?B?bWhYK2pxeXFhSHdzSG9uQzBLRWxrQ3VlQ0wrS1lwTnVleERWNXl4ckdIOS80?=
 =?utf-8?B?a0hqV2dTM016YzFwNlB4Q3ZrR2ZuZWJoNi9VOTcyalN0dTQ2Uk5hdnM1WVBq?=
 =?utf-8?B?dEk4c0p5R01jc1AyT1FROS9jNUhqWkpHT2IzdzQzeXZ1d2JhelZORkJpQXBn?=
 =?utf-8?B?dDdrdDBTTHdpZ1VJWDE0bkdRV2sycG5oTmNjaWZEKzhXVFNKS1dFV1UrcmN1?=
 =?utf-8?Q?Cvz6Lx+t9DfcOmnzVwa4ZuKFc8LAgCp7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5041.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnpiNmg5RVN1TnRxZWlGenFJZjZ3RUxJM2RNYWZzU3dGaXVwbXkzVzlrUXVh?=
 =?utf-8?B?ZzJ2ZW5VSXJqZ3hTbG9odlJSZmVqc1JHckxqWkxZVi9qc2MySFFpekk1MEh0?=
 =?utf-8?B?Z3U3bVJQNFplblRvb0x0WDAvc2lrZ3drdHBTako4d252TmM0NzVwd2RHU1J5?=
 =?utf-8?B?MVlVTWtyTnhQUTcyaEVuUzJsdFlrL0ZjVzhzU0RyQ2VRSDlUdnpReDFvY3ht?=
 =?utf-8?B?c3l0alA1Y1hxc1NaY1FUdVdOVXo0UkE2aWVBb1l2UUdWVkhsYUJYcGdMU0dM?=
 =?utf-8?B?Z0RNWTdleWFtdzgweEZ4VHJSNGluY3VZQ3ptdGdScUhVUUdDbzUzd21tQ2VY?=
 =?utf-8?B?TloyNy9hTS9FK3A5RE1INjdDTGF1RzdaZjNvdXJsMUpxbHd5UG1WbzNZU09l?=
 =?utf-8?B?V2xpdjNtekZKTGR5RmpPRGtrcTA0emo2cXJKRVpEeGJHaWJPN2owS2kxMGZa?=
 =?utf-8?B?N0tKemVhRnRsTFc0VmpnUUZrYkE5UTBES0VSQVZXYUNTTW5weUhmblJUc0Q5?=
 =?utf-8?B?WDVGV3ljelV3UXU3MmtuVXNxNm1uUEpqQ2RzdGtJcDhlWXkyMGx2RGNXd0VP?=
 =?utf-8?B?cXowY0k4aDdjRncwNVh2QlZXbWRVaGVyZys4bkxhMjMvSDAyNjE0bXhWdlFs?=
 =?utf-8?B?M2R5a0w4Z2MrKzkzRk9PdTdNbmtaSVZQdEViY1lsWnFhZTJDaklrUG1oUFNL?=
 =?utf-8?B?ZE91VkJ4ZlJEWDZsNW9Mci9lQ1RuMDRrTGdDNDVEQlZvZU1vb2JsVklXcW90?=
 =?utf-8?B?T1NId2tzVllRQTRGUDdqOURaZ2dGNjJENnBQOW1STnI1aUNGZERJMmY2ZFBw?=
 =?utf-8?B?Q2lXRkFUWExJV2ZtUlBvcTIvaE1aV1cxMWZVNWxtTThJbGVpOWl1OHQ2d09K?=
 =?utf-8?B?QTlIN0pwa1E2bkQ0NE5JeUxBS1NXUk5tY3l6V3l2a2R3dWNFM2xraWFrT0JM?=
 =?utf-8?B?dVNSdjl3eXFleDBTMm0yMnhsRDdEYzBUMWtVZ2lOQUxGbzZIOEVPVGx4dThk?=
 =?utf-8?B?NjN0QzRDM0F0a3VTU2lVUmg4cnJGUW9iMUlRWWJBcHo2TjdMR1VGQnh2Y1JV?=
 =?utf-8?B?TW82Z0VONWNYZU54RHBUVE9TYW12NUd5anFBbEJKeHJuSDN6eC9kdUdKVGZz?=
 =?utf-8?B?V0Jhc1dmSk0wWkgrODlUU0pMRFlWeVFUMFprbVJBQzAvK2U3V2tlQ1dmNVpv?=
 =?utf-8?B?aG9zTnUvek5Pb2s3M1NIbHh2TFN5SUY4RHl6ZDVleFJkM1dzdTdBN0MvVnpO?=
 =?utf-8?B?SlFmeThmVDhVQmVVN3F0dEYrTWpMLy9oRG04dDNaME5yNnEwWEN6MHgydVNt?=
 =?utf-8?B?K3FpdVBtUFBsd0dwSUxhOFFDMGp5dG9vL1BteDJvM2ZrQTFnbm9zTWgzTlF1?=
 =?utf-8?B?dEx1VUpaN0g0TUwzZm5mV0RMSEVMdUN2QXJLbmNTbHdyYzhzZk0zMUY5M1ZW?=
 =?utf-8?B?ZWlBTDl1UE1JNEkvTWI1YjdzeGlYTGk5ZjdwVHVhUTNCVTNQRkRXM0Nibjdt?=
 =?utf-8?B?MXMrTDFwa05tcWpuQ0dnZm9vMFdGSDBXemRDV2R2ZlRBWGdsdDd0Njc1eEVC?=
 =?utf-8?B?bE5ocnkwS01ZQ05MOU0vWU9JVlJmc3RtWXRodEJyOTVQcjVVNFZOSnlHMS8r?=
 =?utf-8?B?c1hpcWNXY25pdGNaZjRjbmFjS2F4ZDJsVFZSUWRGMzY0dU51LzNQVXp6WFU1?=
 =?utf-8?B?azhpU1dJa1JUMjcwUGpyOVJGU25jRyszNXJZNnRhbFdvSlNxdGMyQWZkeU9B?=
 =?utf-8?B?WXJHVFkzN2IycVVmSnJsY3YvQmZzQU82NnFmMkUyaUFVUnBOV3c3Z2RURlFW?=
 =?utf-8?B?QTBuM3ZVTk5LbHB1Zk9nWVo1b2o2ZFNrc3UvVVAvdG5UZXF3MzNDVDhtRHhI?=
 =?utf-8?B?c3FSQVlBT29BeXdNK2s0d0lzQlR5cVlkY0hQRk13VGptK0dLYnQxN0Qxdm1t?=
 =?utf-8?B?dGwyQkhYZjJPU0pMNGJYakV1RnpIVDVuckFjMGl3LzY2cHo0R0Y5R2JzNC9I?=
 =?utf-8?B?VlViVjV6ZlNmNnNLVDVHQWF5aVBRVTZUQldTOWZiZlBUdXBxZXovUU9wYjZt?=
 =?utf-8?B?bm9TYzRvQ011ZVgxRW0wU0JBamU0bTdINWszSHpuVjRVajZvaFdSSlVGcFJw?=
 =?utf-8?B?VTJDWmVvbzlCc3RJTTc0Z1pnQkNpZzZxaGlBWUh1eWZXWDI0NVNYZnNmaTll?=
 =?utf-8?Q?KV8JWVA8s65OfFBCEUd0+pA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HllN9o5saHNTBli2sBFmR2Zg7aWQATNcMyyJ1LskuNnWd/u5xVSArd3xWa3KliCAH6dhlFT7ZTtJFZN3ILm5tNJw7E4ygjroh3Pxe5BW7dw0fopLycDEc56dNUw3wqVs2tE7g8lJnggsfoxEHh9OHHTGnHmCTk13WstB9yL1AAmA+9Y9nXkQtq11DZ0iErjFrhztzsTu5FgiXHH0A7EbF8hT/GObuzUTjVR6UX27m73DqEjKNavtvi/yB9sq1oCQxd66lJzGgCssj+6KnW+x9GAXlqCdDVmkij6pgZ31gPxAWoDaWv6JQrYYBdUvMA2cRpW3UfNFZaqNhNqYjtP6nZu8opVM5PDQwm9pdxa7DV6xrT2oPsy+Yc9pn4lIlA7fx2ijbAYklCs1sx8CT7RaFWGCAH3RlvsLPCRocB+vDKRkMykv3LFOuuhbCPWAaNStA8UBbP9wEy7XOK5dpyeH6QuaHnFbSvAziZmwtvQB/T3347rCshubvVirjAGd1mqa+M481AQNiaG3L2ITHJZjZMmTwGE5VSy+XfFkZOLBYXQ7Vm/XqUAhMidoyGUDTlmAkWzd5H6vZWdjIl9c8YjFfPD6mMu1hSJykzyb3mXC1Nc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a07d7bf-8095-4c0a-ff1c-08de1b0e0008
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 19:20:07.8960 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rRMPr8PcEeyEeskzbv8a6uk0Uov2oTAee44hwKcX9O9ignwsOxhSxK5fa2PcsF+ryGHae73NtRymMqkEP7Yi9C9xMyLL0Gp6LSLmyOeiPZM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF6998A7572
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_04,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511030173
X-Proofpoint-ORIG-GUID: YVM3X9dHtya0FuYW30Fm3xxMhytWdCy9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDE2NiBTYWx0ZWRfX6Bqvk7Y/LQp8
 nHeQMgXLW9qbxs4fwR/utCFn1PQe83CDbofAqeFXEdvLjIIzsNXo+klPGBOCGwqMAQvRCbtjPEK
 ppIsMcAi7Jscu5dPh3l+98TQwsZB6lAYZjSPr+o/NOeR4l8+4LyxGGpaXKS6qyI3iPOWHbwJFr3
 arFyZbQRpf0exlOdH4QrBe3z/1GqkW2lqIpQ9DPSUI2TMN9CEuM5DOcbFwn8SnS20V4tPLDSHl6
 GbwjLT7eGxCts5uYtL0/co4B96BB97XrJiF57wHFwbGAp4tUy013ezR0+a/9xp03FZx3+K1BF5W
 uYwzZZz+KUc3TUKBJxGSMTfSEn8xAH3B5pISouHBfBlvEH3Pk1NSSmnUAyl1qptHDn0tqXQ8/kx
 3uoKESSDUkRXL/5FSa7eliB1xxLW3/eP8Jmuwrnn8isaFJ0lZIE=
X-Authority-Analysis: v=2.4 cv=frXRpV4f c=1 sm=1 tr=0 ts=6909006e b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=zd2uoN0lAAAA:8 a=8YJpqoJC4tMra1vk2EwA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12123
X-Proofpoint-GUID: YVM3X9dHtya0FuYW30Fm3xxMhytWdCy9
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 11/3/25 11:12 AM, Michael S. Tsirkin wrote:
> On Fri, Oct 17, 2025 at 11:43:22AM +0530, Sairaj Kodilkar wrote:
>> Physical AMD IOMMU supports up to 64 bits of DMA address. When device tries
>> to read or write from a given DMA address, IOMMU translates the address
>> using page table assigned to that device. Since IOMMU uses per device page
>> tables, the emulated IOMMU should use the cache tag of 68 bits
>> (64 bit address - 12 bit page alignment + 16 bit device ID).
>>
>> Current emulated AMD IOMMU uses GLib hash table to create software iotlb
>> and uses 64 bit key to store the IOVA and deviceID, which limits the IOVA
>> to 60 bits. This causes failure while setting up the device when guest is
>> booted with "iommu.forcedac=1".
>>
>> To solve this problem, Use 64 bit IOVA and 16 bit devid as key to store
>> entries in IOTLB; Use upper 52 bits of IOVA (GFN) and lower 12 bits of
>> the devid to construct the 64 bit hash key in order avoid the truncation
> 
> to avoid
> 

Will fix this as well. I'll rework the commit message to the following:

amd_iommu: Support 64-bit address for IOTLB lookup

The physical AMD IOMMU supports up to 64 bits of IOVA. When a device 
tries to read or write from a given DMA address, the IOMMU translates 
the address using the I/O page tables assigned to that device. Since the 
emulated IOMMU uses per-device page tables, an ideal cache tag would 
need to be 68 bits (64-bit address - 12-bit page alignment + 16-bit 
device ID).

The current software IOTLB implementation uses a GLib hash table with a
64-bit key to hash both the IOVA and device ID, which limits the IOVA to 
60 bits. This causes a failure while setting up the device when a guest 
is booted with "iommu.forcedac=1", which forces the use of DMA addresses 
at the top of the 64-bit address space.

To address this issue, construct the 64-bit hash key using the upper 52 
bits of IOVA (GFN) and lower 12 bits of the device ID to avoid 
truncation as much as possible (reducing hash collisions).

Alejandro

>> as much as possible (reducing hash collisions).
>>
>> Fixes: d29a09ca6842 ("hw/i386: Introduce AMD IOMMU")
>> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
>> ---
>>   hw/i386/amd_iommu.c | 57 ++++++++++++++++++++++++++++++---------------
>>   hw/i386/amd_iommu.h |  4 ++--
>>   2 files changed, 40 insertions(+), 21 deletions(-)
>>
>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>> index c2cd5213eb1b..5487894aba40 100644
>> --- a/hw/i386/amd_iommu.c
>> +++ b/hw/i386/amd_iommu.c
>> @@ -106,6 +106,11 @@ typedef struct AMDVIAsKey {
>>       uint8_t devfn;
>>   } AMDVIAsKey;
>>   
>> +typedef struct AMDVIIOTLBKey {
>> +    uint64_t gfn;
>> +    uint16_t devid;
>> +} AMDVIIOTLBKey;
>> +
>>   uint64_t amdvi_extended_feature_register(AMDVIState *s)
>>   {
>>       uint64_t feature = AMDVI_DEFAULT_EXT_FEATURES;
>> @@ -377,16 +382,6 @@ static void amdvi_log_pagetab_error(AMDVIState *s, uint16_t devid,
>>                PCI_STATUS_SIG_TARGET_ABORT);
>>   }
>>   
>> -static gboolean amdvi_uint64_equal(gconstpointer v1, gconstpointer v2)
>> -{
>> -    return *((const uint64_t *)v1) == *((const uint64_t *)v2);
>> -}
>> -
>> -static guint amdvi_uint64_hash(gconstpointer v)
>> -{
>> -    return (guint)*(const uint64_t *)v;
>> -}
>> -
>>   static gboolean amdvi_as_equal(gconstpointer v1, gconstpointer v2)
>>   {
>>       const AMDVIAsKey *key1 = v1;
>> @@ -425,11 +420,30 @@ static AMDVIAddressSpace *amdvi_get_as_by_devid(AMDVIState *s, uint16_t devid)
>>                                amdvi_find_as_by_devid, &devid);
>>   }
>>   
>> +static gboolean amdvi_iotlb_equal(gconstpointer v1, gconstpointer v2)
>> +{
>> +    const AMDVIIOTLBKey *key1 = v1;
>> +    const AMDVIIOTLBKey *key2 = v2;
>> +
>> +    return key1->devid == key2->devid && key1->gfn == key2->gfn;
>> +}
>> +
>> +static guint amdvi_iotlb_hash(gconstpointer v)
>> +{
>> +    const AMDVIIOTLBKey *key = v;
>> +    /* Use GPA and DEVID to find the bucket */
>> +    return (guint)(key->gfn << AMDVI_PAGE_SHIFT_4K |
>> +                   (key->devid & ~AMDVI_PAGE_MASK_4K));
>> +}
>> +
>> +
>>   static AMDVIIOTLBEntry *amdvi_iotlb_lookup(AMDVIState *s, hwaddr addr,
>>                                              uint64_t devid)
>>   {
>> -    uint64_t key = (addr >> AMDVI_PAGE_SHIFT_4K) |
>> -                   ((uint64_t)(devid) << AMDVI_DEVID_SHIFT);
>> +    AMDVIIOTLBKey key = {
>> +        .gfn = AMDVI_GET_IOTLB_GFN(addr),
>> +        .devid = devid,
>> +    };
>>       return g_hash_table_lookup(s->iotlb, &key);
>>   }
>>   
>> @@ -451,8 +465,10 @@ static gboolean amdvi_iotlb_remove_by_devid(gpointer key, gpointer value,
>>   static void amdvi_iotlb_remove_page(AMDVIState *s, hwaddr addr,
>>                                       uint64_t devid)
>>   {
>> -    uint64_t key = (addr >> AMDVI_PAGE_SHIFT_4K) |
>> -                   ((uint64_t)(devid) << AMDVI_DEVID_SHIFT);
>> +    AMDVIIOTLBKey key = {
>> +        .gfn = AMDVI_GET_IOTLB_GFN(addr),
>> +        .devid = devid,
>> +    };
>>       g_hash_table_remove(s->iotlb, &key);
>>   }
>>   
>> @@ -463,8 +479,10 @@ static void amdvi_update_iotlb(AMDVIState *s, uint16_t devid,
>>       /* don't cache erroneous translations */
>>       if (to_cache.perm != IOMMU_NONE) {
>>           AMDVIIOTLBEntry *entry = g_new(AMDVIIOTLBEntry, 1);
>> -        uint64_t *key = g_new(uint64_t, 1);
>> -        uint64_t gfn = gpa >> AMDVI_PAGE_SHIFT_4K;
>> +        AMDVIIOTLBKey *key = g_new(AMDVIIOTLBKey, 1);
>> +
>> +        key->gfn = AMDVI_GET_IOTLB_GFN(gpa);
>> +        key->devid = devid;
>>   
>>           trace_amdvi_cache_update(domid, PCI_BUS_NUM(devid), PCI_SLOT(devid),
>>                   PCI_FUNC(devid), gpa, to_cache.translated_addr);
>> @@ -477,7 +495,8 @@ static void amdvi_update_iotlb(AMDVIState *s, uint16_t devid,
>>           entry->perms = to_cache.perm;
>>           entry->translated_addr = to_cache.translated_addr;
>>           entry->page_mask = to_cache.addr_mask;
>> -        *key = gfn | ((uint64_t)(devid) << AMDVI_DEVID_SHIFT);
>> +        entry->devid = devid;
>> +
>>           g_hash_table_replace(s->iotlb, key, entry);
>>       }
>>   }
>> @@ -2526,8 +2545,8 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
>>           }
>>       }
>>   
>> -    s->iotlb = g_hash_table_new_full(amdvi_uint64_hash,
>> -                                     amdvi_uint64_equal, g_free, g_free);
>> +    s->iotlb = g_hash_table_new_full(amdvi_iotlb_hash,
>> +                                     amdvi_iotlb_equal, g_free, g_free);
>>   
>>       s->address_spaces = g_hash_table_new_full(amdvi_as_hash,
>>                                        amdvi_as_equal, g_free, g_free);
>> diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
>> index 38471b95d153..302ccca5121f 100644
>> --- a/hw/i386/amd_iommu.h
>> +++ b/hw/i386/amd_iommu.h
>> @@ -220,8 +220,8 @@
>>   #define PAGE_SIZE_PTE_COUNT(pgsz)       (1ULL << ((ctz64(pgsz) - 12) % 9))
>>   
>>   /* IOTLB */
>> -#define AMDVI_IOTLB_MAX_SIZE 1024
>> -#define AMDVI_DEVID_SHIFT    36
>> +#define AMDVI_IOTLB_MAX_SIZE        1024
>> +#define AMDVI_GET_IOTLB_GFN(addr)   (addr >> AMDVI_PAGE_SHIFT_4K)
>>   
>>   /* default extended feature */
>>   #define AMDVI_DEFAULT_EXT_FEATURES \
>> -- 
>> 2.34.1
> 


