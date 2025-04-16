Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB46C369C2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 13:30:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u52pk-0008AM-FZ; Wed, 16 Apr 2025 09:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1u52pi-000871-Gv
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 09:29:42 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1u52pg-0003LR-2u
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 09:29:42 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53GDN1i1005513;
 Wed, 16 Apr 2025 13:29:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=fvHG3a3bOdjdbu/RAkCG1XzK0TGZjzgspla5pTWRwHI=; b=
 Be//bBe23WyXYdRiisX9DFvsrGuuKWOZaZMEuo3Oglg3xDlEbqvxP677H6BHylIh
 mAelxzQysLZIDrRdWObtk4KlRgxkQGqMdqaqIAAg375fIUUhriP8zpJXZ7o62kDE
 n/cjEcHoxhoFJSUV/IdKF+nmwv6HVpI0EtYTZ/jDiyxS62/KS/Ue1uhywAKVPz7t
 ZJKK/YifrHtCkTv8IIkJg6hCMzc8v5TwzTO2Oqb1y7arAfrf2LasdGoZDUZPMqH7
 kA+afCoy1Lg1wkqO6SIxW1263draxrd4DZ/hnIgAku7xKT+aspT3qbbswJn92EkV
 GCw9yoX1ecY48+50OPdPAA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 461944bvmm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Apr 2025 13:29:29 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53GDA7hG009295; Wed, 16 Apr 2025 13:29:29 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2048.outbound.protection.outlook.com [104.47.70.48])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 460d3kkq6v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Apr 2025 13:29:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CwklEOgXoK5UmGiYd5Yvd5gDy2aWUhhrceNSTvoub+9sql9htaWaLjXy33bYo+1hnkU8UVSglFf7jE/W65CyxNrNqn60VIMH4ZMwiTPPVgva7Y8i1UWq/3g1JEeyxs8BqKoxM22pMkBPhPjiBFNSeTv/tA56zJFZ/tkQzmnGDrSNno+7gkhJjfQ51N3c8hC9E1zWL1ME9HYp+lpYCtOuybXOaHsUPhK8abKBTvW55HDQPtgPe5sNiEPfx0acVD37vjsAW43N2WUjlLcwT6+Uy3kROxaQVBnaHbjFm9F5b/VhBABzfeMj0M4CnqGes0CBgIvGh2fdNjDSgq40LQDPng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fvHG3a3bOdjdbu/RAkCG1XzK0TGZjzgspla5pTWRwHI=;
 b=q2+oudetBEE46qzj3kDZQZNb0gEHZ0kljwxi1ORsJdLvJpBB8VEU38oTWpSs/JnaRV/RdHNaypcBrlR12dj3o04T5EFt6kTfhzsqIRO1HIxcFilN+fRwsbEpvPieMnoFL8H46jpvgvdAtuzRZNsSVcf5DMEP5tPCOWLiSR2rkt4qnE1Lm/oyUVBKuQ/mEU0cUs/+t6ipuhUoCd16enIKvFFbGPeHgSs/+A2ArP7Tlb1LpjIB4kczr06sPtSEBDtLlbh6yaNoJ6BbntPXBID0Mdb2rPe4jrUWnXnNDRVGSiVwBqo87mLAXmoVRO40WgFYg/b55v1y/FSOasFdaes/+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fvHG3a3bOdjdbu/RAkCG1XzK0TGZjzgspla5pTWRwHI=;
 b=uE8DqP/wPoA28cDEfYTfTzPGHzUG9SYEZYa4RyHN576vcQj6RtYJ3ph7v+XTT0ZGd6Dv3vF2ks3xuHNqbRNgkoG4TLZnTTUEB++UxeC7Q0PdWjlnot6rLD4xWwevwfJCYZTltvfQWgeZj5isJHWAnwjoH/dcjbC6ueLJ89e+zlk=
Received: from DS7PR10MB5280.namprd10.prod.outlook.com (2603:10b6:5:3a7::5) by
 PH0PR10MB4518.namprd10.prod.outlook.com (2603:10b6:510:38::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.34; Wed, 16 Apr 2025 13:29:26 +0000
Received: from DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da]) by DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da%3]) with mapi id 15.20.8632.035; Wed, 16 Apr 2025
 13:29:26 +0000
Message-ID: <49e7c66f-6527-4ae1-b712-10921c538d5a@oracle.com>
Date: Wed, 16 Apr 2025 09:29:23 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/18] amd_iommu: Add helper function to extract the DTE
To: Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, Wei.Huang2@amd.com, joao.m.martins@oracle.com,
 boris.ostrovsky@oracle.com
References: <20250414020253.443831-1-alejandro.j.jimenez@oracle.com>
 <20250414020253.443831-3-alejandro.j.jimenez@oracle.com>
 <4a7a8eff-dd21-49b7-9d2a-449ae0424eb2@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <4a7a8eff-dd21-49b7-9d2a-449ae0424eb2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR22CA0017.namprd22.prod.outlook.com
 (2603:10b6:208:238::22) To DS7PR10MB5280.namprd10.prod.outlook.com
 (2603:10b6:5:3a7::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5280:EE_|PH0PR10MB4518:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b2c8c04-8cc1-465c-645e-08dd7ceab50c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cm5CVk5SNkN0YmlDczBySVRnQkorbFVSU2w5SzRTanpHRm5raEZkMnN3K3Rj?=
 =?utf-8?B?Mk5NMExJZ3ZVZjNXVWEwcjRSVVRDQVhZandpdlJMdGVWNytyYmRWT1NlQURs?=
 =?utf-8?B?STJSUWs2L1dRaXpvbkVkSWZBM1k4Q0Rhd1dkbGxVU0RHdUpxRHo1cjRvWS9I?=
 =?utf-8?B?T21vajZ3bUZqcUdObVNOVFVaYjY1cVpnSUp2MzEyR2tmb1NCK3NqTFcrb2ND?=
 =?utf-8?B?YVYrQ0UzREtaZE44QmZUOUVUZGVWUkVFcVRWQ1UwdnYyMmlxWVFEYlNYZVRE?=
 =?utf-8?B?ME1DQ1JBV1lDbEovckFwU3JuczkvU2hMdmhFTUp2VHc3dXJlYnF3dlFUMTVi?=
 =?utf-8?B?Q0pLZXRkL05VQmd3eTRCS2E2ZnE5T1AyZkt3VFVKaERhQlRpTStQajFuaHVo?=
 =?utf-8?B?dlNpTTFxMnF6M2RMY05IRU9LTEF2YytCdUJFZ1N5cmpna2YyUDdmTExsRGFZ?=
 =?utf-8?B?MmU1TkVTd0N0eFhROEM2ZDVOUDFyTDJBTm05Z08wNjFVeDZwQWI5U1MxNko1?=
 =?utf-8?B?WTBoamdXZEt1em0xWnhtaytQOWJBWEp0dWJQRjZnbFBENEdNL3FMWTJkRXNH?=
 =?utf-8?B?bHY3U1JRRm9XTFBINGkvZEJsK2E3QXRYZmhtdm0yT3psU0djdTZUbjhYNmd6?=
 =?utf-8?B?a3FjS2x1VEJhMmNIdjJNQmZBMXlhK0wvSEloV2dNOTRuYTAzdmE0aVJ0VGZ5?=
 =?utf-8?B?ekU1ZWh3QlRqZnJvQXNrUFhtVy9nRHFCbGpacW5hQ29GWDRwVkZFVXR1UzdK?=
 =?utf-8?B?ZlhjSmExMjVaMkdYUFJUdDBELzF2NUhsMTVlQUFxTDRJL1BXeklOMEZhbElK?=
 =?utf-8?B?M3AvYm9XT21WUWE3bXQwMXFURUtIN2R2eHBaL1FzcEsvaTdYQXdDY1JNSUZw?=
 =?utf-8?B?Rk1raW5xK2VaZnNlTjZVUVdoOHd1U1hQY1E4bVkrTFUwYmg5K0VtWGZWckhj?=
 =?utf-8?B?L1I3S2xyOTZzNjdSWTVyRnpkSDBjcldrampvOEtiRVhyTXJKS0RQVmFvYS9v?=
 =?utf-8?B?bmRlUkEwNUN6dGM5NEdjNHVRVUdYWjEvd0dUSkNrNm1JVDdRUWF2cGZ5T0dY?=
 =?utf-8?B?WDJEdUZCSlJDclVQM1o3dFkxRDhIYW8yUFNMQkdVekU0Z0p3ZGFrc2tUNGcw?=
 =?utf-8?B?eXYrZmswWk56SVlhTmpZV2cvT0twSk1uOUN6U2VrTWg3Z1l6anF4andsRFpn?=
 =?utf-8?B?alhPdHRlandPaE16NmNEUTNraUdoMVJPMkY1eHZJVzRrN2syYk9FYlRxQXBG?=
 =?utf-8?B?b3E3d21vdHpFVjdiWTRja0FvUFhqbVAxVlJHcExzQXVzbzVVeUtHcUcyaXVn?=
 =?utf-8?B?SlV4N29sNFVKcmd3RU9QWWh4cGJ0bGNVVmtoZmpDUGFndFM2bHFVTHZXaGhT?=
 =?utf-8?B?N2RNWTBlWnJzelNWTkRERXhsYURtdi9TRTJJQVBINjZBNnVXdnJOZ2dzWWpo?=
 =?utf-8?B?amR6elVHMHZhWmpJSTdjM2F6SktGZFhORGVUR1lOU2ZOTnNMSVhpUHUzdklj?=
 =?utf-8?B?ZSt6cFF4SW1IWlJxYTdGelNpeW9qMTRkbk90dG5PNzdpT3ZZc29kNVF2SE10?=
 =?utf-8?B?eU5xdFRiSXhad3pjZU11YjJKVkFsN3pCTEtLMXNRQU5jK3RPSVc2WnE4UitI?=
 =?utf-8?B?R25TbkZWbFVLVk1hMFVidG5OY1V2VE9vdlJhclRUOXhUeXNzbGZ2RHFoMVc3?=
 =?utf-8?B?eldMSHJsR0lPV3hMcmVrTm1XSWZ4Y3Zqc1A1Mms5bXg1cDRNc0tLRTNWd1pI?=
 =?utf-8?B?Y1B4N045aGRTSHcvcm9Rc3BYWWp5ZmxNd01ieWRJSGdnYnVHUmhXVWpFeVlX?=
 =?utf-8?B?YmUvU0FHeHlEc2JLQmxzcXpwVXdtMUNlbUsvYkNXREthSE8valF6ZWxuemJa?=
 =?utf-8?B?cXZMNXhNQmFyTEJJb2Y2U2ZDRGplK2FKb3JnblcvOWZJaEY5R2JtTGloRS9U?=
 =?utf-8?Q?FNVIcveK8io=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB5280.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mld5cHJHQnRIejBNTjNNalQ2SEdCdkZaQk0xUW5KczhZVGtvTjRLV1BrZm1r?=
 =?utf-8?B?NU1senUrN1hySlloQ2g0Ykp6QXZDNWk4MzBYczhuVExUZnZiUW40bzJtRzhO?=
 =?utf-8?B?L1JCY2xOUjErc01LVFYxYUdqMk9MU2dqYmI5TWVNYlNYOW52TTF1L3pENnBy?=
 =?utf-8?B?cjVaY1NIWkFTK0pKbmFWZUlUMnZ6MFFJK3hJUWQwbXl5TUNZMXhhU0VUMGtu?=
 =?utf-8?B?TjlOZWtLM2gweVRjWUZMTWZzeWhQTXdaZzRTS3ZlN2NnRU10TndjVVYyS3lu?=
 =?utf-8?B?amVQQ1lLcEJmNUJPREFkemw1QWFFVnRQUWRORExiNGdzZUswdkp3WDZUdm41?=
 =?utf-8?B?Qm9nT3VDaGtyRmhiRWVyV2EzWDMzTDdOaTFMbEFoUStRMnNzd0lWOTdoR09L?=
 =?utf-8?B?VjBPY3YycGRybkJMK0pqUkNmVnQ3eHhObjVzS1RJY0s4WVY1Ti9wOElsWTZt?=
 =?utf-8?B?T0k0a3hybXNBYjd1MzVYd0tqWmdVMW5Uc2U4N083US9XQ0Yrak9PMnlnMXVo?=
 =?utf-8?B?K3Q0ZWRGU1FXUmxmWVNSSjdFbWZLOVdmeXpXZmlmcVdaQytCY0l4TWYxbnpW?=
 =?utf-8?B?UllqM0k0OFpHK2NzUzZmelFub2N0R2ljeE1pQkVzd3QyOW1mOGxLSjZWVVdn?=
 =?utf-8?B?bzY4d015TE9leHkzcVJGMXVHdFMwOFNjbTlUS05TczFGNFU3eWhEWnhiQ3JT?=
 =?utf-8?B?NVVma2gzQng2SjhTZER3ZXFBMTZ0QWpUcWRNRTVlR3UwM292N1EvMzFtSmRW?=
 =?utf-8?B?dFFqMjF5aFpWSWNhbDkrRmdOeENPT0JDRGtONU1Od3VRMWFjekQySGdVQ09r?=
 =?utf-8?B?SjdhVUFwR2F6bUREZzBLNDdDVjdjYWtycTBkVVhaNDRBMlZVV0tjM1l2K3hv?=
 =?utf-8?B?Q3piTmhrMG1odElTMnBLakF2Z25hYWVGWGlvQmlrR1dmcGpHZGFTR2l6RkZU?=
 =?utf-8?B?L1hWRmdzbTFMUVJtbnBEUVlVZ3ZOZ2JHUWJXR3JCekF3TXhDY0ZhSFVacDVG?=
 =?utf-8?B?ODA1RHZYeFBkLzYyZjlWSFZFWkYraENqdWZRRUhyNHVJQTRDMDNrOFdpNWNJ?=
 =?utf-8?B?SXJuVFo3MEZER3lxRmlVRGpkb0RCbFpFVzg0c0hENEFVTCt1ektRRVhmeXZh?=
 =?utf-8?B?S2xXc0cvM2ZTZGpvLzdibTE0ay9kOTdBc3l5M0N6U1Y5QTA4THVnLy9QbE95?=
 =?utf-8?B?OUN2RDZ4bGdnOW1ubGxLcW5mdDBGcXVkZjNXWGMrOUFRQm4vb2J4eUoySHl4?=
 =?utf-8?B?Y0NhZHgxenVSWU1tazc1NUhlZDJwUWg2YkZqSmN4UlhYQXZaSVJRNExXQURk?=
 =?utf-8?B?dW1zSk9iSnJRMDNkNmU3M1dYWm5DSE5rWTVuU05jQlJKblFIeW9IZUxaUGtQ?=
 =?utf-8?B?OEJNaHlWeUhzSVpXb0ZrSExoZTg4MWErRDR0MEtxRVNZbU9oY1MwNnQ5OFdV?=
 =?utf-8?B?RmRtVUNjbWRNdkNPMHl0VWg0MTJLRVZuSHhDZHprZXc1SCtlOVcra2czNmxC?=
 =?utf-8?B?aFhmd3RBUWUrQzgzN24zK2pzcnVWOCtlVXdnczNLKzZmYXRRZG0wT3N1VWds?=
 =?utf-8?B?WEI3ZVJjVzg2R0ZqQXFQKzh0UDhjc2FSYmlZdzNkWXBjek0vVTBQaklVZGJG?=
 =?utf-8?B?a1dQSEJkSGxHRjBxb0FhV29EMXNlaTBoc3FJQ1pOSHhpS0hIWHRMWTVtUDdh?=
 =?utf-8?B?cFl3N1VBWm1MTk5tYmZnZjRrallmdnErcE5KY25xUlh2blp0K3c4bWk1MjdB?=
 =?utf-8?B?eVh3alF6MUtBWGFidU9SOW1jUjRreHg5K0NJVE9SNysvZ0p0M1JWSG9CM290?=
 =?utf-8?B?MDgwWGY5a21PSmxyTHdNYlRWWDI3T2pJVEV1MXNidytaMG5ZUmdvQnVpYkJn?=
 =?utf-8?B?NUM2SE5YWDJmUG9HUkRqY0RQdlBBazZwUm8rZlA2UUFSWk5uc29kbXZieCtT?=
 =?utf-8?B?Wnd4Nm5ZNTNyUlJZSjlSRlNlUG5YVXhteGROdzArNmtFSnpUaUlQWGVpVk1y?=
 =?utf-8?B?dXlpTDdPby9RYWY3YkxWTUgwSFJXRm5kZVNSbnYveHJJZ1pvTnF0VVl6eVhm?=
 =?utf-8?B?SU1PRFF2ck5Ec1ZsMkpLSHBSUHZxNlppSnFtWEh1S1FXbTA3ZUlENzdBTE5j?=
 =?utf-8?B?bkJzSXU4WHRvVE5PUEQ5THhVNDgyL1lYeVRUNCtMUUJpUU5CWHZHSmxBK0s4?=
 =?utf-8?B?QlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /iv1tozdzBxd+hEkyb18kwJGvcBiLswbw5TqtTa46phst4uIS1Dw+H14gFL+pSpS38+kzVKTZBXte+CRV49saWFYAT3S7Hfj1NGB+WnF+ins3C+Ejf5SU7XlXQYU4tpNVVNimK+Nd9ZOiQKFrnc+JJFJIlhVMbT+pix4/ChJ/Yw8SWqHAfYdWdJUIQDQX/bOd0z0yJpF6TN6LRT1dgo28anF7YNDdRPqu/D+fbd5yayW9RdRuHdlJjBQfDC1UAZpHy1H9nqnGsesCQvsqSZIQUBiqdyp9eeFoIqkyklAXFEeLllB49KVMCbfHcPsqi6yCxyfSB4OthtV/Vq04nfVMc6TNJzwCg8OFmyivn9U+y415SjVD4IgfhWhCApmKnp5tGlRVhtK9YXYwiSeGmtddTCja3XWLWsumibmABfuvP5OFXdEZNiDTrC6bXWjLE11RsZK2J8DVcOoMU8pajIO6iQAZRlX5SFKMlMekbtTYWOWZ3buAMOxenm2yqS0UFyMcGu2CS0G520MU+pUM5xB/1PjdepP8Fx57HqevICletDaOiW70C6bWevqfFNe3kx1mnCF8Rje0A+JpFFz5cej8KQn0ctfk+laSw2n68acnSQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b2c8c04-8cc1-465c-645e-08dd7ceab50c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5280.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 13:29:25.9910 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r8qwyWnC+kazLD900CyPbtB5dxp5rAevwNv3nUZ8rjlEohzwV/BPRWZuh9oD+6BRNKA0h+WzaFHLp+TkkVwV/a5Yo6sy4/vdaxlKSo+GNvw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4518
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_04,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504160111
X-Proofpoint-GUID: 1jUG1d9BByGIJxP2QJAfluuS8WDUS6Ik
X-Proofpoint-ORIG-GUID: 1jUG1d9BByGIJxP2QJAfluuS8WDUS6Ik
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 4/16/25 7:36 AM, Sairaj Kodilkar wrote:
> 
> 
> On 4/14/2025 7:32 AM, Alejandro Jimenez wrote:
> Hi Alejandro,
> 
>> Extracting the DTE from a given AMDVIAddressSpace pointer structure is a
>> common operation required for syncing the shadow page tables. Implement a
>> helper to do it and check for common error conditions.
>>
>> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
>> ---
>>   hw/i386/amd_iommu.c | 47 ++++++++++++++++++++++++++++++++++++++++-----
>>   1 file changed, 42 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>> index 5f9b95279997..22d648c2e0e3 100644
>> --- a/hw/i386/amd_iommu.c
>> +++ b/hw/i386/amd_iommu.c
>> @@ -77,6 +77,20 @@ typedef struct AMDVIIOTLBEntry {
>>       uint64_t page_mask;         /* physical page size  */
>>   } AMDVIIOTLBEntry;
>> +/*
>> + * These 'fault' reasons have an overloaded meaning since they are 
>> not only
>> + * intended for describing reasons that generate an IO_PAGE_FAULT as 
>> per the AMD
>> + * IOMMU specification, but are also used to signal internal errors 
>> in the
>> + * emulation code.
>> + */
>> +typedef enum AMDVIFaultReason {
>> +    AMDVI_FR_DTE_RTR_ERR = 1,           /* Failure to retrieve DTE */
>> +    AMDVI_FR_DTE_V,                     /* DTE[V] = 0 */
>> +    AMDVI_FR_DTE_TV,                    /* DTE[TV] = 0 */
>> +} AMDVIFaultReason;
>> +
>> +static int amdvi_as_to_dte(AMDVIAddressSpace *as, uint64_t *dte);
>> +
> 
> No need to have this function declaration as it is a static function.
> 

I am adding a forward declaration since this function will be used by 
several other new and existing functions throughout the series, and this 
avoids having to keep moving the function definition. I do the same for 
many other functions in later patches, since it is more practical than 
constantly moving definitions around to guarantee ordering constraints. 
That approach would create patches with large diffs but non-functional 
changes due to code movement alone, makes it harder to parse the changes 
that actually matter, harder to rebase and resolve conflicts, etc...

Alejandro
> 
> Regards
> Sairaj Kodilkar


