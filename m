Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42A69C54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 13:57:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI6Pl-0005Yd-54; Thu, 22 May 2025 09:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uI6Pi-0005Xo-GP
 for qemu-devel@nongnu.org; Thu, 22 May 2025 09:56:50 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uI6Pc-0003tV-2g
 for qemu-devel@nongnu.org; Thu, 22 May 2025 09:56:49 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54MCxebm018657;
 Thu, 22 May 2025 13:56:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=gdolFCb+MNTlOBtnnIE5MpXzHfFRgkUsZiMkx1ubJSM=; b=
 TPJ2SaO05tbrW6Im4Wy09INQnWmkGTJ6x/zxrwY7EZLqjM9eS6H/lis/XqsdM016
 whsTFEM8Qd8ciKNGrwtxdWUwbuJ/5Tqfb+whzB+FUqxlDi0IoL48vzQtdMtRi9iF
 WZRJisjxZ5aGFgoAcQwPN0oIEcnB+zZS4WKj+EL0e4cMSJOypu69dCKrMMNmpLOU
 huNL6gfl+B8xaq8tZltp2VggFD3yt9GfIp0/tSAgIvQUaLc78HMO+zZYeqsFhLfX
 +MrWCpG5ucug22zGRmSKNC8m/r2lgVx1vBGiWjg8g+ydfYhcdKWqGMACKRGkCdYD
 jMXP7a7etR7mW7cO+zRxbw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46t47yr7cv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 May 2025 13:56:38 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54MCdRhb033546; Thu, 22 May 2025 13:56:37 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46rwepprbv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 May 2025 13:56:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l7mumGKdvm6LTZWMcudy0tagGLyrmAMNEzFslprgPMjM1eoGz1piKQYRYFlpduAyDFASOGxQPZwSPVBXbbNNoRUtfkqiAMbnvkORBsta5lTknLvccHgpeSiLfD12WZizDrMl8vPBC4zSdqEbG4NmQxyzRqicbbOvdSlNQca1+ySLaMEtN2lrajNq0TKoKmxcHwUdJNt+iN9mZRCfD51p5rO4OvwlLbgiG9XPteeESTZ/mIeftxzSByohrblZxrVh7G1V0YTd+kbkagKHqGC0lhmvGkdiLz0DLqzzKChDEB+LLrvcKaaW1ufpuqAmYzPAvKBbY1b9jZDV32Zht8R9bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gdolFCb+MNTlOBtnnIE5MpXzHfFRgkUsZiMkx1ubJSM=;
 b=BS4N+B6x5Z8I+gNN66jYs4nWk3wrjRquVYdj3ZneltK09vO7vKyKtm01t7KfFfvo/G436LxcatsBnyfn0LTsueO1VC6GsS2vxV0DGQCjwou3zS5CaXWhmWXTElHdQ365GHSE3Exq1ALeclTtnBOgM34rW8SevzmDCUO1H/AsUrymMLGD6nppvxtVUtljTW2k0W3GLJVVedvBgFYJ1NN5AKsyFHW8rM2DA6eNQeWwVNjLotmdcyknJOpwadNssxxh+MJeGDObLH2XLjoPK4icqFaVh0jvlc3zsAxVmuwQkL2jbN2aV+StXLvqO1QOCDNVV1kaGUEyIRLX2/7HWP++mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdolFCb+MNTlOBtnnIE5MpXzHfFRgkUsZiMkx1ubJSM=;
 b=oQW11F6MzN1LSebX8Egrsmfeg2wMLJe6RAtG3Ojvtea5W3Ntn9sgy2Dyv5JiOl+SoqUij/Q0gsJk0DriuIbu1klhEJAzoFaGZpJ6EgAbRVzyoFZHYecb9S41Vzr0m+WThMO6kf/2hWKMLDJ5D0HmUIijAf0duElmViSfF1Ttma0=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH7PR10MB6602.namprd10.prod.outlook.com (2603:10b6:510:206::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Thu, 22 May
 2025 13:56:34 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8746.031; Thu, 22 May 2025
 13:56:34 +0000
Message-ID: <095a77af-b569-4a79-a28e-cff02b0f4998@oracle.com>
Date: Thu, 22 May 2025 09:56:28 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 07/42] vfio/container: preserve descriptors
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-8-git-send-email-steven.sistare@oracle.com>
 <4eca1b69-332c-40ed-a245-6f9b3e89bf8f@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <4eca1b69-332c-40ed-a245-6f9b3e89bf8f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR21CA0017.namprd21.prod.outlook.com
 (2603:10b6:a03:114::27) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH7PR10MB6602:EE_
X-MS-Office365-Filtering-Correlation-Id: 909d802a-3462-42d0-e8af-08dd993876a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WTNPd2V5blNTWFFEcVdqWXdQaXhJbEsxYmY2K1VZNGdoTFJhWlg2NmhvL0U3?=
 =?utf-8?B?MlRqZ3M0T2FBV2xHVjNROHJxQ3JvMnhQcGZZTHorOElpSkk0d2dGaUR6Rkx0?=
 =?utf-8?B?bSt5N25wZHJscFhBaCtGaGpvUHpaUjFBZjVWQnVEY0dTaHBJWEowdVZtOEE2?=
 =?utf-8?B?VnZKWXVTeUtZTTF3MG9uYVJOTGUza2pNbmVCNEVNdzBXRDNjTmZoMndBOGhM?=
 =?utf-8?B?T3NRelp2OVB0U0puV2hnM2szRVlRbm5qbXpuNXY0SkhDT21OVkhqYlRzNi9T?=
 =?utf-8?B?aGh4NnNKckFRL0Z1YWd6NWpHemRyQ2FVNlIzV3JVRWt5Wm9lZkQwMTdOQmM0?=
 =?utf-8?B?YUY3R3pMbS82S2hWcE1HVWFGRVJrMG1LNWtaMURkdnpkK1k0b05CTnBJVktS?=
 =?utf-8?B?akRzS2gvbDVmcUg3VTFxSEFVRlUwWitjbTRCYklZTnJYcnpMZ1N4czhFUG1s?=
 =?utf-8?B?MGRqb0lPS2dJOFRqYVdyTm16Q2s0SUhsWU55WFlFUHBqbk05K1N1TmRYOElC?=
 =?utf-8?B?RGluY3BuR3B6cFd4T0Y1RVZVcjErOE0xS1Z3a1BYQXF3NnArSEZ0UlY5T1hz?=
 =?utf-8?B?U2tHb2dsNmQyaVgyNlRRazhoNG14M3NCRkY3L09ZaUtaNDFoampFWTRMdWtQ?=
 =?utf-8?B?REExMzhkN3hhcGJtR0xGRU9ITjdmemgwbmUwRTVDSmp4M21ENFN4SUVtTVo0?=
 =?utf-8?B?dXVEZ0MwRFNFS3NvbzJYQUdhdW5vS015c1FBMjhuYTI4blV4WDdvclVaQnFC?=
 =?utf-8?B?emNlL1NFQy9uTnRTNEhRYmUvNzRvZi9vTHc1aWt6VjBIcWZuSFVPbThWaFY5?=
 =?utf-8?B?anIvZXZBZm94WHNwV284ZmR1VTRHclhPL24zelZaQUxiU3NUeElEK3F0eHhP?=
 =?utf-8?B?d2dKaVN0N2lNbnFoSW52Z0J0em51ZWVtN1hCV0FtUDk3ZG9ZY1FpcWZWeGRm?=
 =?utf-8?B?dnlROXZVSDlPNHpDU0lBZmZsdlNMNE43MXVneGtIY1ZyRDhCTW1mVTJrYk9S?=
 =?utf-8?B?Rkl6VHBCaVFmYkdJbHZqRW9ZUXc1Y09BTk1CTWlIbFNPUlFUL2ZoOWpZRGdT?=
 =?utf-8?B?dWdWWE91Q1ZVVFk0a2xpOFBTN2dCWmQwVjBUMWFrSWJXWVVqcWJpdzlwdDNL?=
 =?utf-8?B?Q09hVG5LUkJ0M2k1eElxcGd5M1RDTGpQLzlyS04xZHhndVc5WExMUGQwVjBj?=
 =?utf-8?B?aG1tQ1FnU2JYamNEdHRSdTRyOTA2L0lmUDJhMFk2NC9UNDcrM3lqKzJKNS9F?=
 =?utf-8?B?QWc3YlN2RXY2NmtEYjBkMmdnbFRCdnEzaHBTUFk3WGlGZ0F1Z2Z3YlZqTEJG?=
 =?utf-8?B?N29CQlJHaTR4UFB4TmhIczJlczBtVkZUQjdVVEtETURVUFlBdDg4blJXcUQz?=
 =?utf-8?B?N3RRL3dlVlFUa0d2elorWXQ4cHg3ZlQwbS9FSEJ6UVJnYjM2QVdFNUhpdGhC?=
 =?utf-8?B?cVBxZzN2TEZaVGdQMkFEVDVhNWxoMHJkRHNidkJzYTYzdGpYWmxjT0VGTHhm?=
 =?utf-8?B?NWFUZVhtcTJhR2twOFdCc2I1UzYwdzk3Tk5TeCt3dWlxdDFlSkdKWFNteFV6?=
 =?utf-8?B?ck9FdENpK2JiVC9QSDcwZk1hbFphdnpMc2U5NmMzTzdtUkNhWXlKK1I5SjNk?=
 =?utf-8?B?SzNZRURUYUhiVUxjWXVJOFE2V20yc2xQMndWcEkyK21wZmYrRFpoSy9TcTR1?=
 =?utf-8?B?T3c5RklIdzNCNEo1LzhBdENMdmxCRGVjaHZsQ1p6bjVGYWNaeE5wKzlLT1Nx?=
 =?utf-8?B?QkVlbkxFT205RjNBbWtxMm5CYU02RlVudFA2dUVHL0l3ZTFEVTRIUmRDYkpz?=
 =?utf-8?B?cUVvbnExaGRPeXlMaTJPZFYzajU2dFNqQ2xkOGRxMVhoaWhTcHlUNlMwVko1?=
 =?utf-8?B?cDlrSHhXVkFZcGhvbW1LaU1WSHdIKzVnaW9vUGpNUWhWRmV5TDV2dkN0Nkt3?=
 =?utf-8?Q?S1fjk+Q96pY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bElLeFQyZmpmSkMxMHlsKzdrT0VudzBuc3ludXFTY0xDZEtSSW9STll6a0c2?=
 =?utf-8?B?KzdreGpuNkRtcVkxU1k4NHpNZmUrbW8yNTZneFJUVlJLNVhNblNscW8yTXo0?=
 =?utf-8?B?V1dGVS9wRTJ4NURQQmVoU3dsSGNsUm9UaHNkQzVvQTlBMGU2WlBTT1Q0bE15?=
 =?utf-8?B?eTJTMW1DaFRtYTJncm05MFcrbC90QXBHRVRDd21hZkVGNC9jMW9IejRIZWVD?=
 =?utf-8?B?ellJc0YxTXk2ZTA1WXQwZGlrOVJTMlBlWUdSODBBa1NHRWlZOUJqeTQ1RTlL?=
 =?utf-8?B?Y0hnc2xUc1pmei9CczNwMmdMd2p1KzdzdGVMM0JCb01JbUZVRUxpV0JKRnJY?=
 =?utf-8?B?eUVaaERDcWM1V1ZwM1Bkek9yODRxV0ZxR2RGSzhRZkVTN3BlbFhiWFFhREJs?=
 =?utf-8?B?cnR0VGh5c05MR2hPc3JFejBGa1RuQVJuMXpobzRmNFJGU285bjV5NThlVmxt?=
 =?utf-8?B?eDNEODhocFo3N1pTRDlFZWxqS2VTcGxlUlBwbk4xOVQvaGJ3RTN3U3UrcUtP?=
 =?utf-8?B?NE5vRW9UKzVRMzdZK1d5SERTNnphVEpONHg4ajd6cXVhNFAyQWxjdDJmbEV0?=
 =?utf-8?B?QTNrL1QzZVlRbUhMMXgvbE50SEV2TmxlN1NrcnhaOFZoc0owTHNoQlV6TEhI?=
 =?utf-8?B?cVRhUUlOMjlTYTZHUG02R3pqeGtDeXBleHZialk4WWtxZTZYWVpTaVhaOTYv?=
 =?utf-8?B?NEgwSDc5ZDF1RHdla0JRTUdFYk5Ldm9qeFgxM3JDQXlGOFJhNkk2QVRTaTBI?=
 =?utf-8?B?bjY2THZwZ0EybkYvQ2RhZHlManc2RjJhVFRmM0d6UWVkTk9xYUNROFFGelJ5?=
 =?utf-8?B?Wll6cE1jSmJmOXJ2amNTcDVrNHZSVnJENitBanJNS1pNd0ZzVmR6a1o1Wkhr?=
 =?utf-8?B?MVNFZkpQOS9LMEIzVjh5amFQR1RlRmcxVmNQeFE1S3JFUUZkRjB4MzZETEFh?=
 =?utf-8?B?UDZ5cUsyMFB3TUwyVHhRenVPa1gwMHRodWFvK0tOYjRubUtITS9mcjZoRVJQ?=
 =?utf-8?B?QzEzc2ZGK0MvWWJjQmNJeWJVZ1RNUmJBQXN5S0VNR2lOUDBFSk8xaGFucmNS?=
 =?utf-8?B?UHVnWTJOcUZ4UUNwRXpZdHJ0akxabGNKSGZ1eHpsV1NvYjkzSWl5ZnF3V3pY?=
 =?utf-8?B?eWF4ZDRXZkU2b3YyNlZhak4zcTVzclBIblJSbGpGQ1V0M2EwNExKOHV3bWFU?=
 =?utf-8?B?NzVGQWFPVEhPODdqWVdYNXRCRUN4ZUEwYkVVN1M2dk5tNVVzMlQybHMwczJB?=
 =?utf-8?B?YUdidEY3WmM1RzdQSDNLV0Z2N0VKbDFsWmRVRU53anFuTG52dWw5cUZmQnhU?=
 =?utf-8?B?UzhDd0pjWU5Vd21GdnN2RFpTejhXSXc3R25BYmZSYzNtTmNFejFXenhWVTJE?=
 =?utf-8?B?eFpqS09PY0pRdnJKUXYreFIyZU1WQUU2NEtTKzk1QTZpR2pXa3RzUTNjVmU2?=
 =?utf-8?B?WHE1NFVrUnBha0JweUsrdXJyaGNJSnRjcTI3Z09XN01IUC9tcFcyaG1vd0Y0?=
 =?utf-8?B?ZkVSRjNSTVl5NFhhcXV6empYanJCeHdZU0JhS1Y4WWEvalFYMmIzdjBBVytz?=
 =?utf-8?B?VUxtR2JqT01rUXlzQ3VWd0xuWURpQ3ZwVHdra1NvRXNHRFpmN1FVVldLQUU5?=
 =?utf-8?B?SVhEUlVoOHlrdTlOQ2FCNmpHVTdEYnpyNWxqdm9taUIzdnQ5b2xVUzNDR3hv?=
 =?utf-8?B?SFY5MURrMHZPQ3RaSWpVMVh6VjJwOWI2Q0greXFucnVVSzdYZDZwTWpONUUr?=
 =?utf-8?B?NTMwaGtNTi85RTBBTGhKV1FIZ1RiMVRxWjJVZG9ZQ1dRdUZRcU9TM2dMbWY2?=
 =?utf-8?B?eWxGQzB4dlBHbzJicjhleXprUWNPcEhOV2lFMWpYK2dUcW05dmdIUGZ1ekxn?=
 =?utf-8?B?Q2Q5WkNuMnJJTHlVcTgvRUZqWXU4UEJQQmVRNGxZWUNOazZYMjFwSzNDZFNy?=
 =?utf-8?B?bEhDRHFDdS9JU2xlTHVDZG9oQzl0MUlxNjFEQWlna2FzWWhTVTRRcFJJc0Q4?=
 =?utf-8?B?SjBFVGRmUmpmay90cW8zTXp0YksyZEpjaTlEbjhNRTNJUTE2cHUrZDdrcHBa?=
 =?utf-8?B?KzgrSnVEMzF1aHBXR2JWdWVZb3JhbjhrY0ZvckFjZjBIZUdYZFpxcFp6M0tI?=
 =?utf-8?B?R2preG5PenI5YnJvLy9XbW1GQXBrRklzWStsN0hCRFpkc3Y5WXR2aHJVOTlV?=
 =?utf-8?B?eXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7BytngJzn9Hy1X/8aWxQyLp1Ur+DHkvSLiuNQ2Wh8UBks9kYvnImgJ868KtL9sOcaY99SxzRp2kteVusEJSibGr8rqFeTQFk89R0mNqd/sU/8XhOk/d9uN9sCN4CjPjrokkyBUC/rbmeqnlKGQ4Hs3YA5+MKRC2Xyok6YOfRWGlLiQIncdeamNvIo8Srx38hXvrnD9VopIdC689j4XcTgkHFvKCsyEDbdNFdgrjtAy4bN/EJ2q7E99NppfcjlPOpqSu+D/USomiIP+tdQsOC+7B3R8zKwn0lJhhOXCUBso5JRTE/a5y67+Y0WaXQUcXuyhr+n0hpc1OZj1vbFhsdR0NJKcvYf6A56COC4c6p84zewm60WkZRH0AdmGpHfmal5evM6g5Aov0UMCMpV/YWH9r2BGYGytNfB+qzTvVndcn3W6i6iqoskLp0TSQyOtjAJVEx9NnTxvSST7FggOo/PHlJ5BHC11bffuGHlGk36/AfdZSdp0uq5y48MPjlmQYGrIS35BH2TnYPLdhQu1epfGbSOXPWPklxAbkXEeH60QGiIwuonVDr2OW2B+hPwGNwLVnmmZKLPV5mN5UynO/eBUjLHctbc/xtNLgRHj3i22g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 909d802a-3462-42d0-e8af-08dd993876a4
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 13:56:34.5934 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cvmtFQDuahF5vNX6T7UwHs+5g6+LcUxpu8aTDmR7MITFAZF7DXQ5G++dY/6WLeHztBoWbPvfDjQ5pHOaB5ZsyO4WdvNX869UbYNzJPlS02U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6602
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_07,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999
 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505220141
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDE0MiBTYWx0ZWRfX3nOxk+Xnk1Bi
 qAJIPR90NpE2OrpCMzYOZmjjxlNRMx450lnqtU5I7oBJKBNtwKIwMqCOLSjk4kq1DnFsa1+Nhq+
 2HIcap9FGSXoI4Fj6EWNkJshG4eA0j2cE0AAdcqSGbt9mhsfceGJB8COayGFtBJyfY8JyYBQ8SD
 upbq7BhUnG7ICSSp3RGN0qFUhpAYug+Ua1ChMlH0jMfcJU3kumDaOjggHJgJBbPaEzdfCzNLmQy
 73uusmOo2LpRW95dM1zZtn4GVIxezT5n/FWwUAaWpwZXEjFOekmgHbUK3iygvwTDKKBunkhI6wj
 PCznKlwY+eZV0rJdc8HeXdfhgJp/UCBrx/nu3twaoURdwOaO5scudmNK3rvVAgEB+WSwl8Klb8b
 sPARvs2Cx0FRUO23TMARzi+i+RTN8lRgqA3E8hP6+zyqiyVjCVfCydx7LGrImtTkLTjDY+Ar
X-Authority-Analysis: v=2.4 cv=eJgTjGp1 c=1 sm=1 tr=0 ts=682f2d16 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10
 a=yPCof4ZbAAAA:8 a=jmlefDpR8A18i9vHHXIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 1_4SaAh4W1E3xI4tcueiwq3g3f96AxN4
X-Proofpoint-GUID: 1_4SaAh4W1E3xI4tcueiwq3g3f96AxN4
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 5/22/2025 9:51 AM, Cédric Le Goater wrote:
> On 5/12/25 17:32, Steve Sistare wrote:
>> At vfio creation time, save the value of vfio container, group, and device
>> descriptors in CPR state.  On qemu restart, vfio_realize() finds and uses
>> the saved descriptors, and remembers the reused status for subsequent
>> patches.  The reused status is cleared when vmstate load finishes.
>>
>> During reuse, device and iommu state is already configured, so operations
>> in vfio_realize that would modify the configuration, such as vfio ioctl's,
>> are skipped.  The result is that vfio_realize constructs qemu data
>> structures that reflect the current state of the device.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   hw/vfio/container.c           | 65 ++++++++++++++++++++++++++++++++++++-------
>>   hw/vfio/cpr-legacy.c          | 46 ++++++++++++++++++++++++++++++
>>   include/hw/vfio/vfio-cpr.h    |  9 ++++++
>>   include/hw/vfio/vfio-device.h |  2 ++
>>   4 files changed, 112 insertions(+), 10 deletions(-)
>>
>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>> index 85c76da..278a220 100644
>> --- a/hw/vfio/container.c
>> +++ b/hw/vfio/container.c
>> @@ -31,6 +31,8 @@
>>   #include "system/reset.h"
>>   #include "trace.h"
>>   #include "qapi/error.h"
>> +#include "migration/cpr.h"
>> +#include "migration/blocker.h"
>>   #include "pci.h"
>>   #include "hw/vfio/vfio-container.h"
>>   #include "hw/vfio/vfio-cpr.h"
>> @@ -414,7 +416,7 @@ static bool vfio_set_iommu(int container_fd, int group_fd,
>>   }
>>   static VFIOContainer *vfio_create_container(int fd, VFIOGroup *group,
>> -                                            Error **errp)
>> +                                            bool cpr_reused, Error **errp)
>>   {
>>       int iommu_type;
>>       const char *vioc_name;
>> @@ -425,7 +427,11 @@ static VFIOContainer *vfio_create_container(int fd, VFIOGroup *group,
>>           return NULL;
>>       }
>> -    if (!vfio_set_iommu(fd, group->fd, &iommu_type, errp)) {
>> +    /*
>> +     * If container is reused, just set its type and skip the ioctls, as the
>> +     * container and group are already configured in the kernel.
>> +     */
>> +    if (!cpr_reused && !vfio_set_iommu(fd, group->fd, &iommu_type, errp)) {
>>           return NULL;
>>       }
>> @@ -433,6 +439,7 @@ static VFIOContainer *vfio_create_container(int fd, VFIOGroup *group,
>>       container = VFIO_IOMMU_LEGACY(object_new(vioc_name));
>>       container->fd = fd;
>> +    container->cpr.reused = cpr_reused;
>>       container->iommu_type = iommu_type;
>>       return container;
>>   }
>> @@ -584,7 +591,7 @@ static bool vfio_container_attach_discard_disable(VFIOContainer *container,
>>   }
>>   static bool vfio_container_group_add(VFIOContainer *container, VFIOGroup *group,
>> -                                     Error **errp)
>> +                                     bool cpr_reused, Error **errp)
>>   {
>>       if (!vfio_container_attach_discard_disable(container, group, errp)) {
>>           return false;
>> @@ -592,6 +599,9 @@ static bool vfio_container_group_add(VFIOContainer *container, VFIOGroup *group,
>>       group->container = container;
>>       QLIST_INSERT_HEAD(&container->group_list, group, container_next);
>>       vfio_group_add_kvm_device(group);
>> +    if (!cpr_reused) {
>> +        cpr_save_fd("vfio_container_for_group", group->groupid, container->fd);
>> +    }
>>       return true;
>>   }
>> @@ -601,6 +611,7 @@ static void vfio_container_group_del(VFIOContainer *container, VFIOGroup *group)
>>       group->container = NULL;
>>       vfio_group_del_kvm_device(group);
>>       vfio_ram_block_discard_disable(container, false);
>> +    cpr_delete_fd("vfio_container_for_group", group->groupid);
>>   }
>>   static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
>> @@ -613,17 +624,37 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
>>       VFIOIOMMUClass *vioc = NULL;
>>       bool new_container = false;
>>       bool group_was_added = false;
>> +    bool cpr_reused;
>>       space = vfio_address_space_get(as);
>> +    fd = cpr_find_fd("vfio_container_for_group", group->groupid);
>> +    cpr_reused = (fd > 0);
> 
> btw, 0 is a valid fd number.

That's a typo, but a bad one, thanks!  That is the only broken one:

$ fgrep '(fd >' hw/vfio/*.c
container.c:    cpr_reused = (fd > 0);
container.c:    if (fd >= 0) {
cpr.c:        if (fd >= 0) {
cpr-legacy.c:        *reused = (fd >= 0);
cpr-legacy.c:        if (fd >= 0) {
pci.c:    if (fd >= 0) {
pci.c:            if (fd >= 0) {

- Steve

>> +
>> +    /*
>> +     * If the container is reused, then the group is already attached in the
>> +     * kernel.  If a container with matching fd is found, then update the
>> +     * userland group list and return.  If not, then after the loop, create
>> +     * the container struct and group list.
>> +     */
>>       QLIST_FOREACH(bcontainer, &space->containers, next) {
>>           container = container_of(bcontainer, VFIOContainer, bcontainer);
>> -        if (!ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &container->fd)) {
>> -            return vfio_container_group_add(container, group, errp);
>> +
>> +        if (cpr_reused) {
>> +            if (!vfio_cpr_container_match(container, group, &fd)) {
>> +                continue;
>> +            }
>> +        } else if (ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &container->fd)) {
>> +            continue;
>>           }
>> +
>> +        return vfio_container_group_add(container, group, cpr_reused, errp);
>> +    }
>> +
>> +    if (!cpr_reused) {
>> +        fd = qemu_open("/dev/vfio/vfio", O_RDWR, errp);
>>       }
>> -    fd = qemu_open("/dev/vfio/vfio", O_RDWR, errp);
>>       if (fd < 0) {
>>           goto fail;
>>       }
>> @@ -635,7 +666,7 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
>>           goto fail;
>>       }
>> -    container = vfio_create_container(fd, group, errp);
>> +    container = vfio_create_container(fd, group, cpr_reused, errp);
>>       if (!container) {
>>           goto fail;
>>       }
>> @@ -655,7 +686,7 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
>>       vfio_address_space_insert(space, bcontainer);
>> -    if (!vfio_container_group_add(container, group, errp)) {
>> +    if (!vfio_container_group_add(container, group, cpr_reused, errp)) {
>>           goto fail;
>>       }
>>       group_was_added = true;
>> @@ -697,6 +728,7 @@ static void vfio_container_disconnect(VFIOGroup *group)
>>       QLIST_REMOVE(group, container_next);
>>       group->container = NULL;
>> +    cpr_delete_fd("vfio_container_for_group", group->groupid);
>>       /*
>>        * Explicitly release the listener first before unset container,
>> @@ -750,7 +782,7 @@ static VFIOGroup *vfio_group_get(int groupid, AddressSpace *as, Error **errp)
>>       group = g_malloc0(sizeof(*group));
>>       snprintf(path, sizeof(path), "/dev/vfio/%d", groupid);
>> -    group->fd = qemu_open(path, O_RDWR, errp);
>> +    group->fd = cpr_open_fd(path, O_RDWR, "vfio_group", groupid, NULL, errp);
>>       if (group->fd < 0) {
>>           goto free_group_exit;
>>       }
>> @@ -782,6 +814,7 @@ static VFIOGroup *vfio_group_get(int groupid, AddressSpace *as, Error **errp)
>>       return group;
>>   close_fd_exit:
>> +    cpr_delete_fd("vfio_group", groupid);
>>       close(group->fd);
>>   free_group_exit:
>> @@ -803,6 +836,7 @@ static void vfio_group_put(VFIOGroup *group)
>>       vfio_container_disconnect(group);
>>       QLIST_REMOVE(group, next);
>>       trace_vfio_group_put(group->fd);
>> +    cpr_delete_fd("vfio_group", group->groupid);
>>       close(group->fd);
>>       g_free(group);
>>   }
>> @@ -812,8 +846,14 @@ static bool vfio_device_get(VFIOGroup *group, const char *name,
>>   {
>>       g_autofree struct vfio_device_info *info = NULL;
>>       int fd;
>> +    bool cpr_reused;
>> +
>> +    fd = cpr_find_fd(name, 0);
>> +    cpr_reused = (fd >= 0);
>> +    if (!cpr_reused) {
>> +        fd = ioctl(group->fd, VFIO_GROUP_GET_DEVICE_FD, name);
>> +    }
>> -    fd = ioctl(group->fd, VFIO_GROUP_GET_DEVICE_FD, name);
>>       if (fd < 0) {
>>           error_setg_errno(errp, errno, "error getting device from group %d",
>>                            group->groupid);
>> @@ -857,6 +897,10 @@ static bool vfio_device_get(VFIOGroup *group, const char *name,
>>       vbasedev->group = group;
>>       QLIST_INSERT_HEAD(&group->device_list, vbasedev, next);
>> +    vbasedev->cpr.reused = cpr_reused;
>> +    if (!cpr_reused) {
>> +        cpr_save_fd(name, 0, fd);
>> +    }
>>       trace_vfio_device_get(name, info->flags, info->num_regions, info->num_irqs);
>>       return true;
>> @@ -870,6 +914,7 @@ static void vfio_device_put(VFIODevice *vbasedev)
>>       QLIST_REMOVE(vbasedev, next);
>>       vbasedev->group = NULL;
>>       trace_vfio_device_put(vbasedev->fd);
>> +    cpr_delete_fd(vbasedev->name, 0);
>>       close(vbasedev->fd);
>>   }
>> diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
>> index fac323c..638a8e0 100644
>> --- a/hw/vfio/cpr-legacy.c
>> +++ b/hw/vfio/cpr-legacy.c
>> @@ -10,6 +10,7 @@
>>   #include "qemu/osdep.h"
>>   #include "hw/vfio/vfio-container.h"
>>   #include "hw/vfio/vfio-cpr.h"
>> +#include "hw/vfio/vfio-device.h"
>>   #include "migration/blocker.h"
>>   #include "migration/cpr.h"
>>   #include "migration/migration.h"
>> @@ -31,10 +32,27 @@ static bool vfio_cpr_supported(VFIOContainer *container, Error **errp)
>>       }
>>   }
>> +static int vfio_container_post_load(void *opaque, int version_id)
>> +{
>> +    VFIOContainer *container = opaque;
>> +    VFIOGroup *group;
>> +    VFIODevice *vbasedev;
>> +
>> +    container->cpr.reused = false;
>> +
>> +    QLIST_FOREACH(group, &container->group_list, container_next) {
>> +        QLIST_FOREACH(vbasedev, &group->device_list, next) {
>> +            vbasedev->cpr.reused = false;
>> +        }
>> +    }
>> +    return 0;
>> +}
>> +
>>   static const VMStateDescription vfio_container_vmstate = {
>>       .name = "vfio-container",
>>       .version_id = 0,
>>       .minimum_version_id = 0,
>> +    .post_load = vfio_container_post_load,
>>       .needed = cpr_needed_for_reuse,
>>       .fields = (VMStateField[]) {
>>           VMSTATE_END_OF_LIST()
>> @@ -68,3 +86,31 @@ void vfio_legacy_cpr_unregister_container(VFIOContainer *container)
>>       migrate_del_blocker(&container->cpr.blocker);
>>       vmstate_unregister(NULL, &vfio_container_vmstate, container);
>>   }
>> +
>> +static bool same_device(int fd1, int fd2)
>> +{
>> +    struct stat st1, st2;
>> +
>> +    return !fstat(fd1, &st1) && !fstat(fd2, &st2) && st1.st_dev == st2.st_dev;
>> +}
>> +
>> +bool vfio_cpr_container_match(VFIOContainer *container, VFIOGroup *group,
>> +                              int *pfd)
>> +{
>> +    if (container->fd == *pfd) {
>> +        return true;
>> +    }
>> +    if (!same_device(container->fd, *pfd)) {
>> +        return false;
>> +    }
>> +    /*
>> +     * Same device, different fd.  This occurs when the container fd is
>> +     * cpr_save'd multiple times, once for each groupid, so SCM_RIGHTS
>> +     * produces duplicates.  De-dup it.
>> +     */
>> +    cpr_delete_fd("vfio_container_for_group", group->groupid);
>> +    close(*pfd);
>> +    cpr_save_fd("vfio_container_for_group", group->groupid, container->fd);
>> +    *pfd = container->fd;
>> +    return true;
>> +}
>> diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
>> index f864547..1c4f070 100644
>> --- a/include/hw/vfio/vfio-cpr.h
>> +++ b/include/hw/vfio/vfio-cpr.h
>> @@ -13,10 +13,16 @@
>>   typedef struct VFIOContainerCPR {
>>       Error *blocker;
>> +    bool reused;
>>   } VFIOContainerCPR;
>> +typedef struct VFIODeviceCPR {
>> +    bool reused;
>> +} VFIODeviceCPR;
>> +
>>   struct VFIOContainer;
>>   struct VFIOContainerBase;
>> +struct VFIOGroup;
>>   bool vfio_legacy_cpr_register_container(struct VFIOContainer *container,
>>                                           Error **errp);
>> @@ -29,4 +35,7 @@ bool vfio_cpr_register_container(struct VFIOContainerBase *bcontainer,
>>                                    Error **errp);
>>   void vfio_cpr_unregister_container(struct VFIOContainerBase *bcontainer);
>> +bool vfio_cpr_container_match(struct VFIOContainer *container,
>> +                              struct VFIOGroup *group, int *fd);
>> +
>>   #endif /* HW_VFIO_VFIO_CPR_H */
>> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
>> index 8bcb3c1..4e4d0b6 100644
>> --- a/include/hw/vfio/vfio-device.h
>> +++ b/include/hw/vfio/vfio-device.h
>> @@ -28,6 +28,7 @@
>>   #endif
>>   #include "system/system.h"
>>   #include "hw/vfio/vfio-container-base.h"
>> +#include "hw/vfio/vfio-cpr.h"
>>   #include "system/host_iommu_device.h"
>>   #include "system/iommufd.h"
>> @@ -84,6 +85,7 @@ typedef struct VFIODevice {
>>       VFIOIOASHwpt *hwpt;
>>       QLIST_ENTRY(VFIODevice) hwpt_next;
>>       struct vfio_region_info **reginfo;
>> +    VFIODeviceCPR cpr;
>>   } VFIODevice;
>>   struct VFIODeviceOps {
> 


