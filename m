Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E2F1D1BDC7
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 18:10:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQrIj-0000k4-T8; Wed, 03 Dec 2025 13:10:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1vQrIh-0000hO-NQ
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 13:10:04 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1vQrIe-0001dk-UJ
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 13:10:03 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5B3F0xvI2929894; Wed, 3 Dec 2025 18:09:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=ukcrDEA/RaHsy4pVnd/TOFvcL6sytI9mD/HGTFHO1y4=; b=
 lK1Y99a64oKZO2O6Q6ATReT0MtIXrQtSNSdwslaH+g3lmxkCYzishUYwKdW73H4p
 uN8ku1wZts4Ntg/nC0dqOs11aE4VyqqXX5b6s5Iatf32Ley+ccXzvBC9hTBwiq8g
 y/t9Ccc1jxrvSDAXtc+SA+sIh9nobUyEKAzzwQv/3zSujs0NyMkyJ0OEegA7UYo4
 GAD/88vjZe2Rlo80yXBsgcQTlAHIx47yMFR2bhmoeqcx4ZO6onVQYp3fI/Fr2eFF
 x2usvaW6Y03ljVq19Mrku26CauYkiI3czT5ECFBq0xFBlCVJZ6sz2sAbMq8GuuyU
 2lLeTFlwz3G1dPoax5iGQA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4as7f25ygh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 03 Dec 2025 18:09:51 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 5B3HkPKo016415; Wed, 3 Dec 2025 18:09:50 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11013067.outbound.protection.outlook.com
 [40.93.201.67])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4aqq9asdc7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 03 Dec 2025 18:09:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IS0GOyoy71ydapOchC4LPbFnZhNvFJYEPwoB2YHGc5Y4LQTXQ4ZHrJppYIKuQe83Ibm6rXbC4dYKY6Gtl5IAsnmac5xeXk4oPl01JuNHi+tt+ZrX2xDXVkho/o318iGb/eqAo5KBGLt4eztfSHJg2krDBjZFeDcBO6BNobbe812zUuZ1KfDCUCbThjhwyCBWD+XawatlvYEjsyhJj2iQ1XLFeZC+MV3H7FT+oHSB9JnqU2ffVX+dAV8B8135VyxDqdajwBevoq2+eB0Pyvc4hT4SIjqVfWA/TN0PLN7Lutgiwku6TKSaTrrjrk3rninRfqGgzs6EnYSgnNUNNhY02g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ukcrDEA/RaHsy4pVnd/TOFvcL6sytI9mD/HGTFHO1y4=;
 b=zVJemGMmMQX93y5K7bi4R76jnTDtQzf/gGyr5XGtb7mWjobQW8m83gH0BTOHwUQ2AHqmuAROoQNXIA5+DzoL/Jxw6UwhmzzzN61h6h12CXMx0cMNdar+qfTKLIIM6NovVoIXystwaz7SQX5rT1cYuDOQSehJ88YsNVvcTqMmfu/uOPtya6llrdqDuMUVXy+0EDcKMKAgo1nXQsLEe2oNalibhyDes3ayvj9tLUoKrTI1QrQ3u1dX8EuIdtTRd59ansOgfDwTUGWzLwLKqmjFTc5DNajCNzBVYXmrqBZM8ecbzPDbjkocGNna5lT0rW6P8+FQWu5w+xsiGB+d5UT5MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukcrDEA/RaHsy4pVnd/TOFvcL6sytI9mD/HGTFHO1y4=;
 b=Gs32/bA3HF0L3sgbcSzRqq6KaIbH0n55Wt8w8VQ8MK1GaZ8Z5xLXQkrRx5WYLzwFn+fRLHFpoN8CIirMhvzDTTEQyO2/NkBnw5PYKhQzfiJLjV3oevnme9B/WytG0NUzicrZv62A3N1eyHhd2SB6oDtZLGlPZZWLVM+hk97f/q4=
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by DM4PR10MB6814.namprd10.prod.outlook.com (2603:10b6:8:10a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.10; Wed, 3 Dec
 2025 18:09:47 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%4]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 18:09:47 +0000
Message-ID: <9bc52a98-972a-4376-aec6-69e438971801@oracle.com>
Date: Wed, 3 Dec 2025 13:09:44 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] amd_iommu: Generate XT interrupts when xt support is
 enabled
To: Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org,
 Vasant Hegde <vasant.hegde@amd.com>
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 mst@redhat.com, marcel.apfelbaum@gmail.com
References: <20251118082403.3455-1-sarunkod@amd.com>
 <20251118082403.3455-4-sarunkod@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <20251118082403.3455-4-sarunkod@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH5P222CA0001.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:34b::12) To BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|DM4PR10MB6814:EE_
X-MS-Office365-Filtering-Correlation-Id: 98846065-cd92-48ff-3d54-08de329724ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bU9XMFM1Q0NqV1dvblh5Z0ZkcVNvMjU1MDBGaWt0ZnVDbUVGTXBiU2xqYUlF?=
 =?utf-8?B?R2s2ME94d214bzlTUWRLUGJXV01VRlBOTWJsSzE1c3dPa2M4OGt6Zlc4MzBR?=
 =?utf-8?B?YVBLZDMrZ1gyd09acklSTitLK2tRT0ZicUg5ODVpY0I3RWYrZ0JqZmxKRllK?=
 =?utf-8?B?MGVDbFcrZVBzU2s2dlNXeGVzVk50MEZ2djJadlF6OW11M0xBYXdSeEozZm53?=
 =?utf-8?B?U08wNFhFaitTZ3ZCSGg4VmpCVFJsWE1LaFVNY3diSmI1dzgvV1ZkVFZzaWJR?=
 =?utf-8?B?M3VOSy9sNHRIdUhpMGx1M01RRkNPQzIrRzZNMU9lTWxMQVdQdVA5VnhUUjFr?=
 =?utf-8?B?N1Uyd2QzRTVJcUZSWGVpRmN5blVoOXFIMWZiQmV5L2ltMk1hUUV5WDdLTWxK?=
 =?utf-8?B?TFA0dUhZSW83Nk1VYTZnbmV5aTJxOWVVbk1PM2w0UjdGTzNWdXVaZWxHcXYw?=
 =?utf-8?B?aS8vaEs2VGlNYjl6Zklmcyt4aGF0bDN6NGVDV3pHR1VtYmFKeHpLcUpmTzlX?=
 =?utf-8?B?bnhDNEpiaCtKVUVhU0FhekY2cy95UkZxMUVuRit4UHRxN1V4dWEwb1NPbkhx?=
 =?utf-8?B?cGt3cHNEcEEyRXcxV0dKZEFEMWR0VjYrekVJOVE1cDJLZFVnWS9GOW9xRWRi?=
 =?utf-8?B?dlg4em55Mm1waDh5R0orNlZlNjB5Y1prTGtsNGZEQTFMb090NUlZSDhKQWJJ?=
 =?utf-8?B?RTBiMTNGQUVmVXBLa3JpWGhCU2RacWRabUdOOFA2TTNRMGVPS2hkc0pkZHR6?=
 =?utf-8?B?d2EvNndwRXZyaHV2NGxnemVBam5wNWJqM2daN2loQTJPaDhjYlEvMEVTdVZC?=
 =?utf-8?B?NDZveEN2Z1NTQ3NHdGNJM1pHbGdFeWNqY3Jna1E2NE5MN3labE9zUnRiVmJo?=
 =?utf-8?B?VTN2Njh3SGZWcHJ6NXFlMGZyT3I4dzlYdDBhOUYvV2ZZaFhuNU1Ld3M4czFz?=
 =?utf-8?B?L2dBQkVNWTFJd1VBcW43N1VrcldLY2lSYTVuWk5xb3FsMjFZUUk0U3ZneStw?=
 =?utf-8?B?OGZRNUZpL3JrUmtzazZaWlBLTHU4VHB2NHpuSS9NRy9TcHdlZUZ0eDlkOHBi?=
 =?utf-8?B?ZlU3VzVwT0k2bXppdHpQYnRZMFkwRU8vUlhTTzdzTWZxa0pTa0luT09kUWpB?=
 =?utf-8?B?dksxUGhjd1VHOVp6bWVpUnM1VEZCcDRWNFcrdVUwbWo1TnVxSzdad05HTFdo?=
 =?utf-8?B?ai9FQjlWbkxGMnNNRHArWjZKeUR6VWljbXZYdGF6TTRoR2kzb3FPRURkMjgz?=
 =?utf-8?B?NW9xcFFwUE5uM3REdXUyUTZwNXBrM3lPdkhwZnIvQzE5amt5SEhSbE90V2o3?=
 =?utf-8?B?NG9Rc21oejByR1JmdnpxZS9SRTJIc0RGaWUvdXluc2lVT3QrWDhuaEFSdm9x?=
 =?utf-8?B?dlR6dWNhVlRCa0IreE5CU2ExU2dPd24va0c1bGN2WHF1OEZnenk0TFNDdktV?=
 =?utf-8?B?bC9hbHd4SitHUHJ6THYxTXlDVTdHS1k3QUg0ZGZxR0I5OGZXcEZMUW1ZM0tJ?=
 =?utf-8?B?ZHpaeldFaUlQdWVzNGx0b0wwS3FrVVZHM3VHY1JmakRJSjJ0VkppdWxqS0w0?=
 =?utf-8?B?cnBzTUhHTWJneDhidklWZmhsOVdKZ1dsWjRNSTZsRHBlenhoRTFPSlY5ZGtu?=
 =?utf-8?B?K0FKQ0Fzb25MdlI3dWU1SWJEUmpkYWRwVTcxUUYyU3BTQmdMVXprVXZhSFlv?=
 =?utf-8?B?QUlEV0tvdFV6ZkV3YnBsRm5OOW1MNGZBTisyZ1JSTmNIdUFmRzVYZklJb1VZ?=
 =?utf-8?B?aSt4YlowRmFpdEJNNlNkRm1ObjNKR0s3K2QzdHZNY3c4anhLRE12V1lUb2M2?=
 =?utf-8?B?TXZIMGNLMEpNQ1A0VFBtdFNIblFMdVhCN3ZOWVplcUNsTWNjQ3N5R0d6Rjly?=
 =?utf-8?B?Y3Q5YUtsWk44UzI3Qi9xbXNqRVVtZGJrUUZ3R2g0M1gzR1YwNDMzaVJCRHEw?=
 =?utf-8?Q?FmJxFMZb5SGyxB/NvusDG2ssxV332X4O?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5041.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eS9Bb1BYTTZoSnFMNEc0RWtPMFF2Vnl5MGE5TzVobC9IR2xudTlJZkdVS1RW?=
 =?utf-8?B?OGo0UzE1QU1EQ2VhVXc5RnZNRTE3ektWWWpZVVp2bnE3d3VodkdMRmV6ajFO?=
 =?utf-8?B?b1RNQ3FpTGROWllTVStwdldDNWJieXU4V1pzenRkUENESm1XSXR1bE5sUkZL?=
 =?utf-8?B?aG1samtqcktremRPenhBQ1AzTHhkbHU2WmlZYWgxMDZoU1RXaytZS1cwYktP?=
 =?utf-8?B?bHNjSlNGZlZXR3l4YXA3QTFZNS9jY2dzT1d2SWFqajZPYmtvMkZVT3ZhZlpo?=
 =?utf-8?B?S2ZDbzFVQVN6azQ2U282L01IN25CZ2U2NzNzTk02R1RXRzdXZjJvSlZvdjh6?=
 =?utf-8?B?dG1iaTdyMzZTc0lhU0N6WDR2eWlNU0gzY1NraHdmdlRJR2xRY2xpaHNUZ3JP?=
 =?utf-8?B?UWNpTDNyZGFoZEg2NjFvVFhUOGlaY29MdUJUYmkycmx0MXNZV1BESWdBZU5L?=
 =?utf-8?B?dTZxeXFJVHhPbTRscm9vUm5EVFE1S1lGVmVLdnpPT21ablJDbUhzMlpXaGZR?=
 =?utf-8?B?Q3AzaFJ1cjdXODl3c0tKVUljdTM2eEdZY3N0bW5jeDlBdXdwM3E2Ykt5d2Vs?=
 =?utf-8?B?aWZRQ0p0QkpQcWtZMUhZc2lpOGxEOTAxNHR6eU1FRnh3bE9DMklwcUZ1bk9y?=
 =?utf-8?B?REFsUFFFSE9STFFNRjZzT1FFSWE5enFMUlh5UjFFVTdYdU5xUVU5NkFrZXF6?=
 =?utf-8?B?SU5TaVQyVUgrbXd5a0hXcUVraTZHZWYxMjNMVk5CTklPUlkrVDVhbWg1bEtk?=
 =?utf-8?B?cFNJZ1M3UFpHSDdwYW54VEVWbGo0WnNUMGRXbUs5VE5MdjFFNXBFSHRmcUU2?=
 =?utf-8?B?UGR3VTMwcUxWdkFZd0dHYTdYelJ2Yk1wV2VLYTJJK3pMczJRQkthNjJSODRv?=
 =?utf-8?B?cFBSUTdkRTkwWTVNUmI5aUxUeXNHamp2SHl4dEpZOXQ0ejVWeTZmb0htVEtL?=
 =?utf-8?B?clFicTJaZEE0MHFPQU1QNDN3SHZUeWV5VzNEa2NYUU1hTENaeWJ2S0Y2R0tK?=
 =?utf-8?B?dFVlbG9KTG5OZm13Q0x2K0c4clpZb3B0RFkvdm9TNVZzSHVXZXdoVFZYL3gx?=
 =?utf-8?B?WFNMQk1idEFuYmhGcGhra2xuN1BoS2YxbG1nSDVnODdCZzl0bE5uakZzd2du?=
 =?utf-8?B?NEhGWWx3UXZZL0VBWS9QSzN6aGVKZ0dCMlNJNExRVktZQ051dWRmU1c4OWpn?=
 =?utf-8?B?enEycDlhQVN6MGpuL0FZdmcydGdqWStMbFkwL2kxbzU2OTdvak1GNlUwVkdt?=
 =?utf-8?B?L2VyaW1JQzJDUm51UHRMTVBkTXZCN3YyQ0Q2Yk9GV1pBcld1Z0ZGRGdnZDBh?=
 =?utf-8?B?dFRlMGJnbUw2MDNKUTRUQU1wdU9wZWVScTB6NG5WVDdmOTRJbWhwWkJySkUz?=
 =?utf-8?B?c0gvV0Ftc3dXRXJpQnVWU2Y1S25hVTgxdlM3cXdGWHlueXZvVG8zYlE2eXh0?=
 =?utf-8?B?Z3lVU1l0ZVJrVnRsODczNENtZS9MY0hJVGRkYkZzTGwvNHJRN2wxK3NaM2s1?=
 =?utf-8?B?RnpNUmdtL09wS2s5eDRvOS8yaU1LY2lvV3hEdnpUMlduNkVvdDd6QUJ1emFH?=
 =?utf-8?B?RU40OG5sNVJzdW9MYVN3Yk5mVjRFbHl1SnhrblR4a21OZy94SlpxVmlvbm15?=
 =?utf-8?B?cVV6OGQzSms3SnZ5UU1jZGdnVGV2OHVHNXRhT2d4L0RVenAzZEllbWdwN0hx?=
 =?utf-8?B?N1dSRjRHZHlRWlVYa29VWVkzVjZDVkQ5QTdRU0hkcmNwTVBxY1RNbUZpMERk?=
 =?utf-8?B?THhsaTlERzF4Sjd4KzVUblh1blY1S01PamFlaDZmd3JKQUVTL0FkMms0R0RT?=
 =?utf-8?B?d1Z4bUxRZVEvZE5qVGNicGc4S1BteUovL3Fwb0ptSmlnR1g3eDg2eWNSNWFE?=
 =?utf-8?B?TUg5VU43WGVRdzNqZTNxSVNXbklsTzZqcWNxUFVjMU82ejdrY2o0eklKL2ZD?=
 =?utf-8?B?d1dWbFJab1REMWYwK3NwbTVGRUhSOUNkK3RKWDBxcE9WaU5ydnJ3MGJERjZ3?=
 =?utf-8?B?Y3Yxekt2WnNkOVplRkV6QVpGM21uQWdkamV5Sk92enM4VWxZQjc1OVFoU3lu?=
 =?utf-8?B?MkUzbUcyU1BFaTZ4T3BQNXRhbWZPbFNTdHpQTWpqK3N2cU5HSjk4a1l1dSsy?=
 =?utf-8?B?ak8rc3FRVVR6akl3bmVZanV6ZkxZc05XdEQ5dktCSHJOZnhSbFBUV0JIa3J6?=
 =?utf-8?Q?aZwCxhUhC2E9uSeMicQO9RY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yIs8X/T/SiviAvVKdow66av4xDB927L41QHv0YnXpziKLUL8q8O8xId2YayAiAIQrxWV6k19rn0yhgDNs0rL6IZWOjxwBhrIkKEDc0cLvTP24yL2HA/dVPThrLp6OptN7jB2WO2qSLKGvRAN+HrofRuhPUv/CC4MxRs2f7cuMZ80b2IaHxFFUcO9jCcCC9OmXFcCvfdMY5HkmdySTNTv2JIpa/1rt+ynR+M22WkdA6uVwsVS5UjCF7xW1+eTgPA+K7/pIiRIk26f0Wl6Ch5FPGKvNwkruv4/Y3eYMu8KOasoIPlChTWITcTTfGYUlE66CXX8HZ7+W7JM9LqUh9PvNMUX/xfKis5eN50UkedeVFixQ9ddjLyJ4FbGLfeANqBv9mUfO4f7SJlf2qJDjgucK3r1eZreJVgGJLF2i8YrRSZkd8K1QuEdo7jCXHyydt2z8vvbgYXdoUPZHnS9bS5gPY8BfpjOgfa8PvfqgjjtIG4h4Wo+T3fGsFFOXdiwOH0SeF5tw6yhroTMYk/phUe4InsI2QTXRLAdh3DFRRXzhIdsLHPb6TQKE3tWIJgPcLC6CZvdK+fyrkF+a3Sy+PuJDYNPyL4j4FO/+5fplTnZXgk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98846065-cd92-48ff-3d54-08de329724ef
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 18:09:47.5395 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SjvpDgxOEnrVLJ1xYb6C4yG6w/A31pcSRIvW6d/NXMZp6RVuOQCuZq044kEjUQoJV2EOfKyqmnfAbuzwgbeRPifFeNg0BgU2xDdqf8hs/SM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6814
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-03_02,2025-12-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 mlxscore=0
 bulkscore=0 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512030143
X-Authority-Analysis: v=2.4 cv=QMplhwLL c=1 sm=1 tr=0 ts=69307cef cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=zd2uoN0lAAAA:8 a=GCy-OPx65DmvahqlRQcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: kVtQ_oobjIRxnwM7aeWpth9tnpFFkZ4J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDE0MyBTYWx0ZWRfX/GO1QLotG3n+
 Xa8OQtNhHQS8GPnjQGlLT7tSKbshr6rRp/Heb2EWPaSAsdjWCq/65abuGgtSu0kOhAPqqhDWRWb
 QWxg/mMKsVCWM6Qq2j51hwRQxbjoFx1juUbGoGsETSiVAr7yNq/pNliFYHaqzcP04sgBmNZX8hv
 8/C/RQ5+dF+w+DiYYfeTbGmgki3PCJFbrb+Ple4d6wHOaa7l+Lgx2Yl+U04BN5mNUrDb0tU6Y7Z
 EwVP0OlXL9nz8AWP8jpwz2rr2sX0ObH//8oCFvh3E+bWblu1fN6EmTbfdbFVwlMGxXev7n5IWpQ
 ouPFBFKNuajqO96wRbU3EO8k/jFTJY5N+7MPIh0pjKUEzFPq1eApE9HuzKOJtF0nYr38VcIrJWR
 ZuR/3GAHnpnmOhitysPCIqe71pt9FA==
X-Proofpoint-GUID: kVtQ_oobjIRxnwM7aeWpth9tnpFFkZ4J
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Sairaj,

On 11/18/25 3:24 AM, Sairaj Kodilkar wrote:
> AMD IOMMU uses MMIO registers 0x170-0x180 to generate the interrupts
> when guest enables xt support through control register [IntCapXTEn]. The

"the interrupts" is a bit vague, considering that it is only a specific 
type of interrupts that originate from the IOMMU itself.
I think the quote from the spec is pretty clear and we might want to use 
just that:

"
When MMIO 0x18[IntCapXTEn]=1, interrupts originating from the IOMMU 
itself are sent based on the programming in XT IOMMU Interrupt Control 
Registers in MMIO 0x170-0x180 instead of the programming in the IOMMU's 
MSI capability registers.
"

I'd prefer if this was documented in the code comments, but I would go a 
step further and mention the specific interrupts, e.g.:

The mapping to MMIO offsets and interrupts controlled by each is as follows:

XT IOMMU General Interrupt Control Register (0x170): Event Log exception 
interrupts and Completion wait interrupts

XT IOMMU PPR Interrupt Control Register (0x178): PPR Log exception 
interrupts

XT IOMMU GA Log Interrupt Control Register (0x180): GA Log exception 
interrupts (irrelevant in vIOMMU case)


> guest programs these registers with appropriate vector and destination
> ID instead of writing to PCI MSI capability.
> 
> Current AMD vIOMMU is capable of generating interrupts only through PCI
> MSI capability and does not care about xt mode. Because of this AMD
> vIOMMU cannot generate event log interrupts when the guest has enabled
> xt mode.
> 

At first I thought that statement was not correct. If that were the 
case, I was wondering why we don't currently have issues with Completion 
Wait, since they are also controlled by MMIO 0x170 offset. But the Linux 
driver doesn't rely on the completion interrupt AFAICT, it just sets the 
completion store bit and monitors the semaphore to detect the 
completion. We might not be so lucky with other OSs, so good catch.

> Introduce a new flag "intcapxten" which is set when guest writes control

And similarly to the xten case in PATCH 2, we also need to migrate this 
new field. It can be added to the your proposed vmstate_xt.

> register [IntCapXTEn] (bit 51) and use vector and destination field in
> the XT MMIO register (0x170) to support XT mode.
> 
> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
> ---
>   hw/i386/amd_iommu.c  | 51 ++++++++++++++++++++++++++++++++++++++------
>   hw/i386/amd_iommu.h  |  3 +++
>   hw/i386/trace-events |  1 +
>   3 files changed, 49 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 7f08fc31111a..c6bc13c93679 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -200,18 +200,52 @@ static void amdvi_assign_andq(AMDVIState *s, hwaddr addr, uint64_t val)
>      amdvi_writeq_raw(s, addr, amdvi_readq(s, addr) & val);
>   }
>   
> +union mmio_xt_intr {
> +    uint64_t val;
> +    struct {
> +        uint64_t rsvd_1:2,
> +                 destination_mode:1,
> +                 rsvd_2:5,
> +                 destination_lo:24,
> +                 vector:8,
> +                 delivery_mode:1,
> +                 rsvd_3:15,
> +                 destination_hi:8;
> +    };
> +};

We should define this union mmio_xt_intr in amd_iommu.h header, right 
after struct irte_ga.

> +
> +static void amdvi_build_xt_msi_msg(AMDVIState *s, MSIMessage *msg)
> +{
> +    union mmio_xt_intr xt_reg;
> +    struct X86IOMMUIrq irq;
> +
> +    xt_reg.val = amdvi_readq(s, AMDVI_MMIO_XT_GEN_INTR);
> +
> +    irq.vector = xt_reg.vector;
> +    irq.delivery_mode = xt_reg.delivery_mode;
> +    irq.dest_mode = xt_reg.destination_mode;
> +    irq.dest = (xt_reg.destination_hi << 24) | xt_reg.destination_lo;
> +    irq.trigger_mode = 0;
> +    irq.redir_hint = 0;
> +

Based on my reading from the MSI details, hardcoding redir_hint=0 
results in the dest_mode field essentially being a nop, since the 
messages will be delivered in physical mode i.e. only to the APIC ID in 
the dest field.

 From Intel's SDM Vol3, 12.11.1 Message Address Register Format:

• If RH is 0, then the DM bit is ignored and the message is sent ahead 
independent of whether the physical or logical destination mode is used.

I am not sure if the current implementations of AMD IOMMU drivers ever 
use the logical mode, but I am thinking we should at least catch that 
case with a warning e.g.
if (xt_reg.destination_mode) {
     error_report_once(...
}

A follow up question, since you chose to explicitly set redir_hint to 0, 
and something that bothers me about the remap functions is that they set:

irq->redir_hint = irte.lo.fields_remap.rq_eoi;

where AFAICT, redir_hint and rq_eoi are semantically different and 
control unrelated behaviors. So I've been wondering why these 
assignments are done. No need to answer this specifically, but if you 
have a better understanding of it please let me know.


> +    x86_iommu_irq_to_msi_message(&irq, msg);
> +}
> +
>   static void amdvi_generate_msi_interrupt(AMDVIState *s)
>   {
>       MSIMessage msg = {};
> -    MemTxAttrs attrs = {
> -        .requester_id = pci_requester_id(&s->pci->dev)
> -    };
>   
> -    if (msi_enabled(&s->pci->dev)) {
> +    if (s->intcapxten) {
> +        trace_amdvi_generate_msi_interrupt("XT GEN");
> +        amdvi_build_xt_msi_msg(s, &msg);
> +    } else if (msi_enabled(&s->pci->dev)) {
> +        trace_amdvi_generate_msi_interrupt("MSI");
>           msg = msi_get_message(&s->pci->dev, 0);
> -        address_space_stl_le(&address_space_memory, msg.address, msg.data,
> -                             attrs, NULL);
> +    } else {
> +        trace_amdvi_generate_msi_interrupt("NO MSI");
> +        return;
>       }
> +    apic_get_class(NULL)->send_msi(&msg);

This is great. The method of writing to the address space directly still 
confuses me, using the APIC helper for MSI delivery seems to be the 
appropriate way.

>   }
>   
>   static uint32_t get_next_eventlog_entry(AMDVIState *s)
> @@ -1490,6 +1524,7 @@ static inline void amdvi_mmio_get_name(hwaddr addr,
>       MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_BASE, name)
>       MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_HEAD, name)
>       MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_TAIL, name)
> +    MMIO_REG_TO_STRING(AMDVI_MMIO_XT_GEN_INTR, name)
>       default:
>           name = "UNHANDLED";
>       }
> @@ -1549,6 +1584,7 @@ static void amdvi_handle_control_write(AMDVIState *s)
>                           AMDVI_MMIO_CONTROL_CMDBUFLEN);
>       s->ga_enabled = !!(control & AMDVI_MMIO_CONTROL_GAEN);
>       s->xten = !!(control & AMDVI_MMIO_CONTROL_XTEN) && s->xtsup;
> +    s->intcapxten = !!(control & AMDVI_MMIO_CONTROL_INTCAPXTEN) && s->xtsup;
>   
I think that s->intcapxten should check for s->xten instead of s->xtsup, 
that way we create only one dependency on the input parameter, and the 
rest flows logically from what the guest driver configures.

On that topic (I should have mentioned this on patch 2), I think that it 
might be reasonable to make s->xten also conditional on whether 
s->ga_enabled is true. The spec just says they should both be set:

"In systems with x2APIC enabled, software must set MMIO 0x18[XTEn]=1 and 
MMIO 0x18[GAEn]=1.This enables the use of the 128-bit IRTE format with 
32-bit destination field. Even if Guest Virtual APIC
will not be used, software must set MMIO 0x18[GAEn]=1.
"

my understanding is that we can't support X2APIC mode without 128-bit 
IRTE format (which is controlled by ga_enabled), so it makes sense to 
block X2APIC (i.e. xten) unless ga_enabled is already set.

So in the end we'd have something like:

s->ga_enabled = !!(control & AMDVI_MMIO_CONTROL_GAEN);
s->xten = !!(control & AMDVI_MMIO_CONTROL_XTEN) &&
	  s->xtsup && s->ga_enabled;  // this should go in PATCH 2
s->intcapxten = !!(control & AMDVI_MMIO_CONTROL_INTCAPXTEN) && s->xten;

What do you think?

Thank you,
Alejandro

>       /* update the flags depending on the control register */
>       if (s->cmdbuf_enabled) {
> @@ -1755,6 +1791,9 @@ static void amdvi_mmio_write(void *opaque, hwaddr addr, uint64_t val,
>       case AMDVI_MMIO_STATUS:
>           amdvi_mmio_reg_write(s, size, val, addr);
>           break;
> +    case AMDVI_MMIO_XT_GEN_INTR:
> +        amdvi_mmio_reg_write(s, size, val, addr);
> +        break;
>       }
>   }
>   
> diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
> index 32467d0bc241..399a4fb748e5 100644
> --- a/hw/i386/amd_iommu.h
> +++ b/hw/i386/amd_iommu.h
> @@ -57,6 +57,7 @@
>   #define AMDVI_MMIO_EXCL_BASE          0x0020
>   #define AMDVI_MMIO_EXCL_LIMIT         0x0028
>   #define AMDVI_MMIO_EXT_FEATURES       0x0030
> +#define AMDVI_MMIO_XT_GEN_INTR        0x0170
>   #define AMDVI_MMIO_COMMAND_HEAD       0x2000
>   #define AMDVI_MMIO_COMMAND_TAIL       0x2008
>   #define AMDVI_MMIO_EVENT_HEAD         0x2010
> @@ -107,6 +108,7 @@
>   #define AMDVI_MMIO_CONTROL_CMDBUFLEN      (1ULL << 12)
>   #define AMDVI_MMIO_CONTROL_GAEN           (1ULL << 17)
>   #define AMDVI_MMIO_CONTROL_XTEN           (1ULL << 50)
> +#define AMDVI_MMIO_CONTROL_INTCAPXTEN     (1ULL << 51)
>   
>   /* MMIO status register bits */
>   #define AMDVI_MMIO_STATUS_CMDBUF_RUN  (1 << 4)
> @@ -421,6 +423,7 @@ struct AMDVIState {
>       bool ga_enabled;
>       bool xtsup;     /* xtsup=on command line */
>       bool xten;      /* Enable x2apic */
> +    bool intcapxten; /* Enable IOMMU x2apic interrupt generation */
>   
>       /* DMA address translation */
>       bool dma_remap;
> diff --git a/hw/i386/trace-events b/hw/i386/trace-events
> index b704f4f90c3d..fe7aea4507ae 100644
> --- a/hw/i386/trace-events
> +++ b/hw/i386/trace-events
> @@ -114,6 +114,7 @@ amdvi_ir_intctl(uint8_t val) "int_ctl 0x%"PRIx8
>   amdvi_ir_target_abort(const char *str) "%s"
>   amdvi_ir_delivery_mode(const char *str) "%s"
>   amdvi_ir_irte_ga_val(uint64_t hi, uint64_t lo) "hi 0x%"PRIx64" lo 0x%"PRIx64
> +amdvi_generate_msi_interrupt(const char *str) "Mode: %s"
>   
>   # vmport.c
>   vmport_register(unsigned char command, void *func, void *opaque) "command: 0x%02x func: %p opaque: %p"


