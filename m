Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 242E5C87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 18:12:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uizfe-0004zd-Al; Mon, 04 Aug 2025 14:12:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uiyEh-00075Q-08
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 12:40:40 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uiyEf-0005TV-5A
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 12:40:30 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 574D6XcZ028499;
 Mon, 4 Aug 2025 16:40:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=1ZQZ+sihs/MuWj/QNaAJvjytDYz2bW7ZKNI9mTs5hgg=; b=
 TBGQgWtkTbjvAqyeyw7uE6dfjNmeCtecpm4LPBsNQKxhhuKphqMnlTXz6hEz26TO
 udKzPFgHXhfJ24/SuXgSBGblxFJMLNdU6ID+GP5K49dDkreBtdQh2FkRkns/uP3z
 veTofCmVlol4N30Tpuz45vwGiW+utYalP3qV7xNX2h42I2N4Ii3z8Kk1/LXxJIfy
 Gqis2CERh9Ey5y0/wNu7HUqny4xj8k8oyydjp9xGcjSgDLGcira2ziudfZqBAcsr
 QxI8POJo2vBal6ymX6kWSDxTX6thf8XKZlNvWjnskoJ6xqto/LVMuuapOvasoOFs
 RRfdk8zNbgtBIWHqV3FnWg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4899f4u15n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Aug 2025 16:40:26 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 574GP3ae013603; Mon, 4 Aug 2025 16:40:26 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 48a7mrn7rc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Aug 2025 16:40:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X+2Z1BgnfTJZ2Da+SBjyVbjTkd9cnDx6Fhcw6x28/xfzpgTipBxcaOfPqPcdp1alPt02IXCQQRjjQcOACVGAt1lXW2XS4t+S/tI/E6A9MQIi70YsfNRC5qArk+6f71rYHIVZVoiNao5yKlJAIj1k4YbV1heDr7fzMxTGXba185LSV4oyd8osjx+nZv74bzR4LAVqs88+dl0uI3gMdSRz7TAVz7tKGS/MHyI29v1lCRyueL8CNS32j0+CQSdiJOgLVwCbQXVtPoMcnw9h+zTkXYoNmUrI5lqc1q7Klsl3ovgl9cGVRg1n3IUzgUE0pCp6hFeFdXeXM2tooNBrdmDSHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ZQZ+sihs/MuWj/QNaAJvjytDYz2bW7ZKNI9mTs5hgg=;
 b=HXbGi4PQp6F8OUiYRxPAwCTnPEEN/Awape5emtfMaAmSgafDzwy3NtL4ZsfC57D6So6MmcjYeSEsIxWyusgXaZnbdu3ciqndUBTq8Kqk/xmkaoh0dvDMh2UY4fUrZolYLjKUs0+1g3me9Ta5yOU4SEHT1+GBcTFOreP9ux3oi1frWbAGJs/H1Pj7bl6UnxjLo7TIAPVmQXz3GYlkTCtv/pv7GtT1zUNs4FbJuPHHooK1kbXBAYTIZbi0RDP2YTWQx32M0qRElQpWUJzxZi+13HhHN8zDmUYM3bB54c5kY7sno2InxpIdd6ZxT+5ZZ3a51dBvxPX9zck4/5CjTfE/uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZQZ+sihs/MuWj/QNaAJvjytDYz2bW7ZKNI9mTs5hgg=;
 b=LSZ2EzkN0dSuNY3t3fFNiUk9Z/MgkHU+6Sa1Lk3QdbDm71HUxNpN5RE2HQ777+lrbHfirn9Df0kRSzyWiAwXicHEdnFBAuCq87dyuVaKeCNvWuaN0NIM0KgRd43s49Xq8gj/ccLI5oukcioMxnPjZhVRJwrzgo3T/84pXt2nx0A=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by IA4PR10MB8398.namprd10.prod.outlook.com (2603:10b6:208:56d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 16:40:24 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 16:40:24 +0000
Message-ID: <495859c5-aa6b-4379-8667-a0968f532326@oracle.com>
Date: Mon, 4 Aug 2025 12:40:20 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] qtest/qom-test: Traverse entire QOM tree
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net
References: <20250725135034.2280477-1-armbru@redhat.com>
 <20250725135034.2280477-4-armbru@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <20250725135034.2280477-4-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH1PEPF00013312.namprd07.prod.outlook.com
 (2603:10b6:518:1::d) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|IA4PR10MB8398:EE_
X-MS-Office365-Filtering-Correlation-Id: c6257171-67e6-487d-1500-08ddd3759c47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c296VWxMTHRndGNoRlluOC9FRGhwcFBMT2dEdGhqdE1PWnRsTmYzTy95SVpZ?=
 =?utf-8?B?R2tTazJDWm5ualFqbDFqWm5uMmxmR09qVVBFVWZERDExNE1UMHhVN3R2Rk9S?=
 =?utf-8?B?c01WYjJoVGtGQ25oc0daU2h5YVByUVc5S3F2NGwzb1FNT1dJbzV1ZlVwR1RH?=
 =?utf-8?B?djQyNFhWM3BTb0ZUZ1JBT2F6TGU5WUI4VURlQ0JyclpMeTlzNnVyZERqZEl6?=
 =?utf-8?B?ZGJtSU41c0tFbWFvbDE4NWV5WXJxUTVucnhVNW9vUGhpWTd3M0FxN0ZWdGk1?=
 =?utf-8?B?MmprMGtRM1E4d2VrSWl4MDF2Y2l4a0RJVXl3NkRrZExSa2FxWDV1SFRBUjZZ?=
 =?utf-8?B?WlpNazZRWVhnY3Z6aFlpdXdDNDRGWEpUejhXZkpHaEo3aXJoU290MFM3eHVl?=
 =?utf-8?B?VU5ZK1hGcWRhUnpmYzNNalRZNEg1L1lEb0M4Y05IUzgxcS9PN1pFWWlLTC9I?=
 =?utf-8?B?YjNPNWhUVVVpc1FqTVR2WWFESnpLaVRtWjlmcEZQZ3FVV1EvdkVqSEY4L05F?=
 =?utf-8?B?c2JONmR4WVJkSFhnOThsdHdrdUxDRU5QbWRTS2NhVEpLQ0o0dzl1TDNaSGJM?=
 =?utf-8?B?WEdBTTd3OWF3NG5tZTFLdUNCZnJCcjF3S28yWkIwRWV0SEdDOHNjam9heTVh?=
 =?utf-8?B?L1NEZTVPUDVGVjNEeEN3U0RsR0R1S3E0NnFQVmMzcG5Bd2xGM0VGdE96SUk0?=
 =?utf-8?B?MXB3YmlkQVNmUDZPdEdxb2pHcWd5VHFBa0JEVENSaTJScnk1U1FCSW96V0xm?=
 =?utf-8?B?TGhDQnJ6eWJuaTZxSVJ3UHRRUEdWdUpTakZYQk5PbTdVL0kxRFZpbGVxdnVy?=
 =?utf-8?B?VHh4Q2lTbWhvdFZCS2VhTnJBRkp3dVhMaWYrU2hwMHVXVm5pUE03b3Jialoz?=
 =?utf-8?B?dERTMjhrTnlCTEQrb1N2U2tuVWtxTEtjK3NGVzk0T3MvSGtZTEdvNFpBYTRD?=
 =?utf-8?B?NVBNTThINEV6OEhUNVYxaDAwZzJBdzhNMW83U3VKczk1YzFkNnZEdG5HVXNK?=
 =?utf-8?B?MWhydFJVZXlNcTg4VlcvbFU1a0Q2K1h6eUlWU243d3g0Y1dHeTNlRGdBNldz?=
 =?utf-8?B?dGdHaFc2cVFIbEdSNk1yS0dxWHYrMHcrYkJSbzdXRjdKLzhQNW5yRVJUaWZU?=
 =?utf-8?B?Z09WVE5xbDVuajBpMHc0d3RMRjg0Q2ZxblJvV2pIcksrcUQrdVRYdmNkR1hQ?=
 =?utf-8?B?MlpxTkdFU2N3amlzaGkzWnJGOElsRmxpWWdVVUdQRmVVRi9XVnMwaFRxem5y?=
 =?utf-8?B?V2IyejlLcUNzS2NwSWZPb3BrZkorWmRoUEhlcjBEekllWmdQV3dUbWgyMEdR?=
 =?utf-8?B?Q3FCNzAxWUJscWRjTXpiVlozei9xbVo2REdXWFlNa3FHSkNlNmxsL2V4Rm9l?=
 =?utf-8?B?YzU2YWgyT3duSjlyWFZOME1VUXE4SURoWHN1UlRWSHlnQTIrZjBHdWpVRXl4?=
 =?utf-8?B?TjB6dzgwNnVTeC9QZ3Z5Uk5jYjRCakFZa1dtUDhiY085aGYvRWlrYWtZYUxJ?=
 =?utf-8?B?V0NUb2tCU3MvWkdaU2Z4RWFpOVFWWUptK2Y2U0FOdDBRMEhxTlFRNkdtckxE?=
 =?utf-8?B?eVBZbVZ4ZkNGWHJrYUVLVHZsdmQxRERSaVJRZXhidmhsZEdleUtOanBiQk5V?=
 =?utf-8?B?OTFyamRKU0pTVU1iWWp5V2lsTWEyR3FIVmRhY3V0YURkenZWQWZQTmlQUndj?=
 =?utf-8?B?dmxCbTB4TlIzQVNQMTRHQTdMVjFTOGc5cXFFSG9KUmczeERWM3FMeEhwdGxB?=
 =?utf-8?B?YXFLUWpZNWp4K3NVYWltbUZwWUJaTnZDQXdRYThweWdSbEYxYW5WSGc0QS8v?=
 =?utf-8?B?Z1h2VjlWbGovL2c2Ung4bS94RmF6V1dNeXA0Y1RqaWprUWZXUW5QUnpLUzlh?=
 =?utf-8?B?aXpXaEFkSEhpY1VYYmhwUEZaanZUay9wSHNaODJTcmliRnZieGhOUDl6TEZM?=
 =?utf-8?Q?s0BYzl1sb5g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yytqd01pTU1UWmw1bFlGbGlRbjhjTHFibENWcjdZTVRXOVlZZ3A4dGNOT25X?=
 =?utf-8?B?ZWlBUEVBWDRPU3dxMmdZNWhVenlaeWRpNGxkUStVQjMyeWx1RFR4bFNSUG9x?=
 =?utf-8?B?RE5hckl0YUw1YlZlYW1aZ0p6elRwZ1hYOGtPMy9vSDEyMDA5SC9ZSGtzSWp0?=
 =?utf-8?B?OCtLVHNYU3YwR0owMkxMQWw1S1QrcDB6Mk9WSUFtNnhEVEd2WitYR2Mwdkdz?=
 =?utf-8?B?ZkJ6VEJ4UmlQdDRCT0ZDTzhHSytnMVVocGFtY28wenNkOXVuMWVGR1FnTmZH?=
 =?utf-8?B?OUdCelNSZnBBQW5ua3FrUHU5dW45dWJkYkZxeFQwY1YyWlgxbENTbkdvMDhy?=
 =?utf-8?B?dEhabUo4WnRHcmQvMzVlaTBqZEcrUUVCVXZOS2RWZ3B0ZTB2Qnk5SjVaTms1?=
 =?utf-8?B?UTZhWFdZc1BLeVc1ZXJ5RTk5dmhDWnBPQVFhNDd1MlRNeTlKaTViK09LaUJx?=
 =?utf-8?B?MWFVR2gwa3ViZC9kcnNweS90cS91aUo2ZzhBK1FKK2g5Z3Y4NWVvMkJBL1JB?=
 =?utf-8?B?TUxWM2krZGdSNitDTDlvaDBITThTNVJFL1AvRHZHMmhESVhjcVptcHJXM1RR?=
 =?utf-8?B?d2FjYTA4YVBkZVBjY3ZoK0xuSEJ2a0F3cWR1QlpodjZnenNtZVhlcHdjUDNx?=
 =?utf-8?B?N3g3cUVWWkw3amVkWktqalFvcjBpSU1ZZHFlOTl5cHBUSUxnVkhTOHAzd1dM?=
 =?utf-8?B?cGtVUDVZZXp5TER5T0ZXQ2hIWEFiUXRhT1lTOTFUaDllcjZQbXlzWnlxVStF?=
 =?utf-8?B?cTc1cG41byswYjlZZzR3ZVdtSDlrb0l4MHRicENXTTk5NmxTZlNsRDNJUUQ4?=
 =?utf-8?B?eWV5amRiVit3TThwS1c2M1FHU3pSc0JGSldXMmpqaGJOcWVnN3VQWjgrNlNX?=
 =?utf-8?B?ckMwOW5DY2FlNUpGcWtMZTRyREpUTCtObWlWQnpXWEpmTXhhUDBwd2w1RXNr?=
 =?utf-8?B?cVZ0STUvbzRsZmRtUlRPNUFnY3lpTGFWR21EdDBYL3ppNmxlT0xidHNyUTk5?=
 =?utf-8?B?a2NtdkkwVXBNTzVqUW80RUtFSk1kK1l4QUt6VlIwaEtlYkYyTEV5YVdzYlZQ?=
 =?utf-8?B?TnNucSs2QXg0ZnF4MkJDUjF2cWdHSExvSUtzM3ZKOTV0ZitURFJVSFpIeEph?=
 =?utf-8?B?Z1FOdjF1RzBmcmt4dHdsNDFnZnlkbDlxbW82dE4zenY3T0dZRVZEQmxUNW44?=
 =?utf-8?B?WGVvWGpCV1FxamxvTU91SnYvK253b0Fqbkx0Q21QcHhLZ3pxWWMvSUNZbVpp?=
 =?utf-8?B?WDhPdElxallaZWJxREZVQ005UUZHR1YxTFI1dk9TMlRCekQrS0NWZ0FNNzA0?=
 =?utf-8?B?QmpTR0d4TjZ1WVg5Zy9qdkxtSWhiVnpsRXp1eVRud2ZKMFhVSHVhTVYzR0N1?=
 =?utf-8?B?SHVSa2pyNEZuUUZTMVdDSlNHK1Bpa2QxMCszZmxWcmNScUt4T0tlMnVwZUZK?=
 =?utf-8?B?cUpUNXZLemdoMVRXdmppY2tUcWM1aUZnaHllRHpIbFhqazhMK3Rubmx4QWpl?=
 =?utf-8?B?VmZVb2czYkFwUFNqaXhhdm9ab0grU01SVjRBY3E0QWZIODd6RHRBbXB3YU8z?=
 =?utf-8?B?S2VFRHllbElNbUpiQWhoMGdIWHBkQ1dDTXFFaHVNbTR3ZmRYbEN1UzlLS1Y0?=
 =?utf-8?B?SkltUVdsOC9UQzlCNTl1enN4ZGZPY3E3NFozcWpua1pqS0dZWmd5dUxiZSto?=
 =?utf-8?B?WmJnSDdZcXNXdUZoZGFUbUIySVdRWExXL2ZkL0J6YjBDQkJDaFNkcTIvQ2g2?=
 =?utf-8?B?MTByMnI2NnFMRzJzMlp3djVzWmpValN2OEJSR0t1SFg3Qm9paGtKK1JKMTZW?=
 =?utf-8?B?aGl1ZDdmSWtHUUNMMWxLbUo3RmZuTUxXWDdsdTkrRXl3aElyNnp6TDMxNW54?=
 =?utf-8?B?eEcwaEMvOUlNUmlTOVpWNy9vOHlZckx2SlhOZytvUG1HdThtRlNMb0hyNzFF?=
 =?utf-8?B?ODNobjhjelEwUGUyc0k5Tk41V1M0dzNkb1lueW9WVDh0dnpmeDlXUHZ1MDMv?=
 =?utf-8?B?U3Zwcm9sLzU5SWV0MTNwSWQxbUdIRWN5TTI5U3ZMVldGM2oyZE05Q2IvUGFJ?=
 =?utf-8?B?aG52YWsvcU5BZWVqVE9qTSszMFZwQ3pVcnlkVG1iM1hVSFBIWmdYSmQ5R1FE?=
 =?utf-8?B?aFJPNlF1T2ZETUhvQnh2N1F5bE1rT1QwK2IwVGIrbWwwYnRBdmYzU2JJcG8z?=
 =?utf-8?B?Y0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: O7jkH67EcdGcudMy0oUxYKb/Urp+WHy64kVCwl2avngMxW7zDK4gfsyg4Msih6V/gmC6Qv1KVAxs7X0fGEn4Yxp9w/5au73M5mGsRsJek5doBnJEeLAylAwclYMNAYcxxFTY9lvagD3SGY1aGNQASaT5bzvZUItvzlcFstZesPm3AEjrMt9/0KDRYyAcR/s6GC132ym1hermKRWCkYDU703GJ5gKRXo5HD8mU1rz72DPANAkCjxnjPjArLrCGg9mqf68+rfl+fEBKXEKUSeqyrA71wY+G7vVJ8h/iQKCuiYfTKemtoJIv1w0xXqxgRa7rdd6gKorI2GaNpI3HV1cvtMmLLD+lb0bsl7Stf3iJrqR287xDrfditzjj7Vh30Uv7miUbDcuBH4RgdN29LL0arUxvNm/DAX2qhQmevSzwIoCV6jQaCxWRdLojVq1+6my3W5wqt5G9bqRVeCpgurimWMHmccSjYX01jqiM6jW7hIoMl9IUFdEUyHYwKvdBO0bYWN27N9wMlKErAMIEmH1mDiq44hpzavo23smbo5RGRZxG77WszqOTnILhpTcfvE+YLT1ZhBtPz5Q21sTTrFhX7o6DvBT18yrY1FAoGmF18Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6257171-67e6-487d-1500-08ddd3759c47
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 16:40:24.4954 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VXqjVpLWRHxAhB7rnthbuFbqzmq5hsA2/hD1O+beySql0jAVVXLkZhOEDupkeLWqUL22fP2k/jCTwHeJ1hnBf4ywWfOr7orMqEuFCMTIvE0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8398
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_07,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 suspectscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2508040092
X-Proofpoint-ORIG-GUID: RB_p_jJPHlAM1rNtuS2bpyXnNb60xIRl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA5MiBTYWx0ZWRfX4CMHCXZB/SyF
 9EwWJCKKuOuFsTIV2TXAMWwS/VqfY2Lt3FakJaxeFLl0cwtaIgIKlFgkQqE6yontnbT3oaKpBQT
 L4AEeQkTUhdSSGnXvdKOKeI+ixMn1z2NQj4xOYW+2n0JmDyHjk6nVCySRCqThhSU0+C1i8cP+B0
 ZrGWdw7Oxp9swtumeG2EODfPNQwjM2bBvYGV350OMagElYmYIzoUbRVPQeqxAiPrS5E61K+Y7xu
 Py/eCELjJPFCYI35xMs8gu/4ojcH+IhcgVRzdjwHpbHHF7lgFWGsrZJFvcO1OCyluU1Jx5Hrrgx
 EwNIzkow44n1SksU+9VGRyMVCGDYiXS3P/QRD5/gt2Ylv4KOHJy3uZoc03HdP671ZjUQWD3JOVy
 xsT4DBUHuQSgDFWJ7yTg1yHLojpN8w3e+EqV3ukrI9MvhlR9tWz1EEld1a/6umebzFPZQdw8
X-Proofpoint-GUID: RB_p_jJPHlAM1rNtuS2bpyXnNb60xIRl
X-Authority-Analysis: v=2.4 cv=daaA3WXe c=1 sm=1 tr=0 ts=6890e27a b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8
 a=z8_3p-S9xEqzf7aDSvEA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13596
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 7/25/2025 9:50 AM, Markus Armbruster wrote:
> This test traverses the QOM sub-tree rooted at /machine.  Traverse the
> entire tree instead.
> 
> The x86_64 test runs some 40 additional QMP commands, and stays under
> 5s for me.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   tests/qtest/qom-test.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/qom-test.c b/tests/qtest/qom-test.c
> index 40bdc3639f..d358b69c7e 100644
> --- a/tests/qtest/qom-test.c
> +++ b/tests/qtest/qom-test.c
> @@ -211,7 +211,7 @@ static void test_machine(gconstpointer data)
>   
>       test_properties(qts, "/machine", true);
>   
> -    qlist_append_str(paths, "/machine");
> +    qlist_append_str(paths, "/");
>       test_list_get(qts, paths);
>       test_list_get_value(qts);

Reviewed-by: Steve Sistare <steven.sistare@oracle.com>

