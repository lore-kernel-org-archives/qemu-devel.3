Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB732C3DA41
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 09:14:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR6vT-0000ZJ-NB; Tue, 09 Jul 2024 05:14:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sR6vM-0000Qh-Ng
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 05:14:13 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sR6vK-0000mF-1A
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 05:14:11 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4697tYUJ024840;
 Tue, 9 Jul 2024 09:14:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=W5uz213XLKrULFG1Z4QYcogm3kz8mkUOY0iY/rY+JTI=; b=
 CGsJ4wWHGPd0CEcuXD6y4yfC8xqtETa6HVDNucV/7U+Q30IkVEPDvZo1RDi5XroU
 IGC9XNpny2iSCIvI6kgv59vq4rKiZomRhnMRa7up3JJCdSqqHh/e+Kq3YnO3/WCa
 twf7tHW1JSRL6Z3lp3tCDFHUvSj4bwojgTKVZVz5/DQW1k0PylBuoyUvds8mG1qf
 WrXxSnuNdOnNphVFLwVN1zTvU23IxpW2zwHm6RQ1pF+TqHqbNCsOO9PWIyD0Sp4J
 QFaUSUiH3J9R3RZiMjymDe2qGcC4HkdLjnZZwJAc5HRnawxBG7r5GUetpgPvLAFl
 7LoweaMrc7PyRzzdHLRqkA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wky4hmj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Jul 2024 09:14:07 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 4697vvjD027398; Tue, 9 Jul 2024 09:14:06 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 407tttcpfh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Jul 2024 09:14:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9hX3XWrk2ans3b7+Duo9vAOT6J4W2Nwh57Z66r6B2wCcTjl/QpbDwF260SaJdR19JPlATqHHTx9a++nMQ1ZSzdCCvJ9ZvHTJb64Y39N8z+BlMvdtHBnpVgLvND5vCyfVNb14whlI7XyatbO1Woa442KEWWyQ9lIVnRWo2yDnZkgyoVjMO6+vO8C2bGDPFJkKV+0iwUpGCJqlSIM0F0JkImGa8ZMhqerg43mAKUIGvReEy4c0rgORa/XdM57vyYIB1xnWdr5LkCa6h8hO5jJ4cdjVbD0dvFAm+nNuXH1b0VtHlRUpgbugjvnbDjwN8cI8LKLNRgq/vL5jPNVSWqn5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W5uz213XLKrULFG1Z4QYcogm3kz8mkUOY0iY/rY+JTI=;
 b=MwartGm4eLqfg8odX2i+6IoVEiRB26y964tyuboZJWSFM1u++ZWJMSS9mMhAGo1p+TYpFPbrHUgSbJVLu7kLbnihx2H3O+il3dex+UJL7aZukovDotT3eqQ2coNOPrVQtpLLiaYuy5Aq15cWIdwrwrz6itRWsHFtQmhSOWytorvOJtv6qSOirzIU5kzhb+EBB4BFeo8jVrlTT9oUKU5bHE+fD85xe+2F+hN6vyWsbFVR9Lo6J4ERsDRM2uokbmPdjHn3D2lhvKnpnwebqVgsuL8PknuhQRlGcYmMIwrXfgab5rDVmsSnhyzjq3sQiTEAcbJjxPJPPZwvUoeygMjfoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5uz213XLKrULFG1Z4QYcogm3kz8mkUOY0iY/rY+JTI=;
 b=JKKVYcMeUJZztsiQJz7bkSAvKw9uZD+mMokaC6grKeEASzjBF6hR+iJJlI2mJ7iZZ2DMK4pHfmc3ByNBZrS3DZJDAQLDBQug2nP1p55jtJF/kQJ8Q1Q3/TeNwd3+1ndMV21tOyJbQ3Q9is50DjffLuYm22WIOsQLrxeoCN462bI=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by LV3PR10MB7794.namprd10.prod.outlook.com (2603:10b6:408:1b3::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 09:14:04 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%6]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 09:14:04 +0000
Message-ID: <9bb5df98-9556-4a7d-b402-a15046dca88e@oracle.com>
Date: Tue, 9 Jul 2024 10:13:57 +0100
Subject: Re: [PATCH v3 06/10] vfio/iommufd: Implement
 VFIOIOMMUClass::set_dirty_tracking support
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240708143420.16953-1-joao.m.martins@oracle.com>
 <20240708143420.16953-7-joao.m.martins@oracle.com>
 <4aa6309f-d529-4cb6-8ea9-014423d0a1cb@redhat.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <4aa6309f-d529-4cb6-8ea9-014423d0a1cb@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PAZP264CA0150.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1f9::11) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|LV3PR10MB7794:EE_
X-MS-Office365-Filtering-Correlation-Id: 19329d74-d8a8-4a5e-c471-08dc9ff77a76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TUhxR242TVpKNlRVZk1tYUhlOWljUEpObXEyTW5DRmtLZHlpajMvMUJTUEEw?=
 =?utf-8?B?bDFhWjhibi9sZ1FQbjBlUDVKWVpQZFBSYmFwdmdqOWZ5ZU1Ib0phbE5yaVJn?=
 =?utf-8?B?MEEyWnd5bE1HUW4wNThoV0gxaHp0enNhNldpZ1NvUy9lQzR1UVNjTU1UUWpH?=
 =?utf-8?B?Z3hpelJRYWJXbUtyQVdvb3FjbVBDRmJINDd3c0t6OWNRNFVFV0o5QWhESWFq?=
 =?utf-8?B?RGRYNkRqdDNpTlUwUDFTQ0R1Q2tKSzNOa3BmeXdHY1RBOU01eFI0V1RybUcy?=
 =?utf-8?B?WEJVTEFoZEhWV3JsdmRsMCtZODg1ZDBWRmtqbEVNTzgya043NEw0eG1YY24z?=
 =?utf-8?B?WHZ4Z2xuNUlNNklpRSsyclNmSENRMjhpZjFlRmt4ZmdTRVB1c1BRNjM0eTk3?=
 =?utf-8?B?bXBIOFNVZXN1blJkZi9TMlBjOVhKNEJDd3NOM2RFUWlQU0o5RzhEL2ZEOExp?=
 =?utf-8?B?V2F2UUJYRWF6Zm5FZlFtd1A2MHZhT0hsSkhqZWpnUkNjN0RMSEpLZkhIUlF2?=
 =?utf-8?B?ejQyZVp0OGgvNThlNHFPUUEyOUtCcEhCakVzSFRwMVg5bWt4bWlkRHhSekdw?=
 =?utf-8?B?T2hnVUNsNDhja0VXdUorWkVoM2d2OXJMUzBFRzg5MkZHV0tFWXR1UGQxWG5p?=
 =?utf-8?B?bVhQa0NNWllVNlJPVmN1MHByS0ZaVDlVQ3lNUU9SeEd5Wjk5ajlJcUg3OTU3?=
 =?utf-8?B?N2t6Yk5qRHpPaC9RNUNPcDRIemdLaXZ6ZCtKSW9OWmwvSURlQXh6WTU0SS8w?=
 =?utf-8?B?RTBJU2xWM0tIbEVrc0dDRnd4b3FyYmYvcWJZaGlhY3p1Tkk2ekhNZkJIYjNG?=
 =?utf-8?B?OCttbVVham51ZURCaXdYb0I4c1VHUkxCMitxcUFnSWk3b2pMdU5La0ZpaWpS?=
 =?utf-8?B?SElPS0I4LythY2RSZmovNlB6S2Z0QksrY1hjMUNHaG9MMG9wU1BTeGhOSkpa?=
 =?utf-8?B?TWcxbnBPakt3RWxsRGUyaTJ5Wlk0NWtXRlFySE9waEIvMk1IWnZHSi8wNHU3?=
 =?utf-8?B?MlNGZGRLZkZmTWRDamxScCtpMy9iUGEvUktSZ2VIcklPSWZQWDhVNDdYWnBH?=
 =?utf-8?B?RHFadjd0YnNDRFAyMTdidXJMbERIVVFkSGpCdlhCU3VURkxnL0sxUGRkRGJU?=
 =?utf-8?B?N3MycDJFYWdzMGZRYzlPdFpWRFBRZWRVdDFVNHdVWnFSNHc1NFROWFJ2MFlI?=
 =?utf-8?B?UXhjaUZiZVZIM2swRTlWTTJDSWR0SWZkNzRxMU1KMWxadzVRcSs3aTRJc2xp?=
 =?utf-8?B?WDVFVEpjaERSSVhCM1llenpkWEhjbDRDMEkwSFl6YmpOVC9DNFhyV1Qyd3RP?=
 =?utf-8?B?bk1JVCtmZGlndDI5am0rREUxM0gzTUNnQTdsTitPcWJQTmdNVUVMZmN1elBO?=
 =?utf-8?B?anVMTUFKRXN3TnZ4aWZDYjQ5NW1sQlIwaklucGs4MEIvKy9yVExXSVp4NDgx?=
 =?utf-8?B?L0tuc3lkYW1YWGtQK3NZeUx5ZmNiWHo3eU8zVmJmV2pPT053cFN1anlmcVFh?=
 =?utf-8?B?RHJBY3BVdmJUSXd4UUlhMUp1Z3hRTVM4Y0RUalZtWmdYcWR5VzV3RUtyR1oz?=
 =?utf-8?B?V09GdmxiWGdhRTZ4Y0V0LzFEMjBiV21IaGdFUTJKSDd2VzdXcjA2QWpyRnJo?=
 =?utf-8?B?OFNoSlBXVno2SGVkcmtZREt6dVlOSGhmSzRVbHVoMzdkR0hDaG84TnVKWC9i?=
 =?utf-8?B?YytORGhEMlI5dFRvbkJIMG9obExRcnJGNkorUmRoWmRMbFRIdlRieWpRc2JX?=
 =?utf-8?B?WjFGRTZ2ampDTUVyVTREdHRZK0Z5V1JKQ0ZJVkZ3UUE0WjRGNklHTU5VSzFm?=
 =?utf-8?B?VFhSZkhVYjhHNE5GRzFRZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RU5yOW1lMHpQbE9yd2lFd2NqeWhlWTFVdjlSWGdCZGxBT2VsUk51eUtacWxX?=
 =?utf-8?B?THpVV3lFVWEwY3UyVkFuVTBzQjA2TjhwZVliSGcxNzJVMGpXcWYvQjZuUm0v?=
 =?utf-8?B?WVVRNXRneEF5SjBZbXVBdENmdG4vUzNzZ21hLzFOVEFMSElWZUxxT1d6cFhL?=
 =?utf-8?B?YzU3U0xjTDJndmd5UHB1NjF5RENtc08yMkdrME1CMWs3YXlOU01aRE4xZytI?=
 =?utf-8?B?TWc5eXMwWlNKL0pzei9kNDZ1MGY2bTJ6N0MvQVY1S01Wd05OVGx6d1Y2Njdp?=
 =?utf-8?B?VGhmRXBvdlg0MklmL3h3OXVIU0U1Ukt3ZG9MNzJzL1pTMU95SGJzK1owN09Q?=
 =?utf-8?B?Z0Rrc2U1amFDQjBrMmR3K2hoMDNDUVVMTFRTMGVyYld6c29VRCsrUUIzQlRM?=
 =?utf-8?B?NE96Yk1rcnY2Z0xUbUlZbWU1aEhwZHM4TExpYjdkVzN3S05MOG4xNmFIdVI2?=
 =?utf-8?B?bFVvOGFzVjFKclNxS2F6MCtLa1lEcit5d0dNb0RGWmpRMnduY2EyTzdtTWNw?=
 =?utf-8?B?TENxMXgrMURXeWdMajd2cEkzblFDaUFOZVZzNHdFVCt6RXJwUXVpZGFlRkxv?=
 =?utf-8?B?MTd1Um5hdjRBUSs0cFlWOEhtbHNwNktwSWN2dFFBWWxHZU1DUGo4a2g5VE1R?=
 =?utf-8?B?OEp6SUxSaTB2UEZjOGhDMWVrRG9ZcVJwQUFWd1phV3lIdml2VytkczRRc3lV?=
 =?utf-8?B?VnV0blV3QTVqL2VYeG5XWGs1LzNNeDJQTFJaUzJYeGY3Y21ib2lxMldkVkJ2?=
 =?utf-8?B?RnNLN3ZFczlFOWhTZWFSOTk2WCtaUVorcjdXbFVnM2xYYit5anpZMFAxT3ZI?=
 =?utf-8?B?SzkzRTZHSG01UFdPckZEVzdDb2JHODc3VVNzQVZBMUpBZ1NrWXB5NVhCUXRJ?=
 =?utf-8?B?MnEvMmtJMjZVNDkxNjNNVWE1S2JsS3Y3NzMrK01ISTkzUTJBTUpGWGo4ZzhR?=
 =?utf-8?B?amFCM0VrNHdSUFFNd3lqVGh0U1p2Y00rVFIvREN5aCtRY1hXNzJZaUFkbVV0?=
 =?utf-8?B?SC9XTmdBNWZlL3Y2QmxQSWVHY25DL1RaZ3RYTm56M2J5MFFEanlsWG11S2ZC?=
 =?utf-8?B?bmMvMlM0RTlXYkI3cTBNc1ZET01HYi9tekZvb0JPTFJ0dmIza2FmKzJnVndX?=
 =?utf-8?B?VGd5RWNwSVNBOG8zQ0VBQS9oUGZOUGRQM28vQTlhYjBvRzdndko4NEJyazlM?=
 =?utf-8?B?WnlTY0xEWnlVYldOVmxib0xiVHdFTVlOQzU4aWZ2WHNod1BZOCtGcmUwRUs3?=
 =?utf-8?B?ZVdEYXA2LzBvNTh1ZDYwYWZiOEFWVVdwUkdjcnZuRlNES2ErR3FIa2ROL3Js?=
 =?utf-8?B?aG1PVGZYWmVxVTZXUUY4dkcwazdtdE1NUk0rK0E4QXArNHlwRUs1YTdkSWEw?=
 =?utf-8?B?UGR4TTFIWmZ0YlZTQUZ0dFQxSjF3TktYZkJ6U3AwZG9VT1ZKSWRKckxFSTlX?=
 =?utf-8?B?THdzeEJaSFEyaVpsemZDd1lSZFJPWjYzUTNOQUF6blhZYWRjVE81Tjd3OExV?=
 =?utf-8?B?Rk80R3RHRWRCN2hkZDduNG1WSmdnekI1U3NENlI1QlFsN3ovRk1UMkFINEM5?=
 =?utf-8?B?eUpBOU1vMVNPNTJBejVrTzNaaUQwdmdjcDBtcENuOUFKK1hOb2JUYTh5b3px?=
 =?utf-8?B?eExiVXhRSFRZZTM5NVM1cXZLa0RvSzdvNlNhQjRXSTVjQUtRaHI3WGVWSGhB?=
 =?utf-8?B?YldpeUovbHpTSno5d0dSc3gySG5ub1NDT2tMUUY0TDhaMVgxUGJQNEdtUmpC?=
 =?utf-8?B?OXRhVXFCV3Awd1U0MjBnUi9QUkg2OVF1ZlhlVGtSRXVBNUc2ejZSWEdoUE5D?=
 =?utf-8?B?YWU5R1FyRDVvZnJmV2dob3VoUVVrYk9heVhYVmFQQVRoSUNBUzkvRWhEN3dP?=
 =?utf-8?B?cGl3cGpmVXRzMmZSUjlPdlIvbDdUNm5MWTlMbGErRlplcHBrbXBvTEFyejhI?=
 =?utf-8?B?a29MZFBXSmJZOUIyQjkyNStOaUpyTm92VGN0STR0Y0Y0YW9vbUV1ZDRsNDQv?=
 =?utf-8?B?U0JQdEhPWTdXbTVtYlBrYlhwMk5JYTRRLzliZzhsbWd3OUtRTkNwZkh2b1NU?=
 =?utf-8?B?NGdndXdCVUc1V3FtN2VMQUE3UFphek1EYnE1eEtwSnkwWExZU3F5cXhIOS9Q?=
 =?utf-8?B?enowQjhTYzliMGxJOGpjc1hNQXgwVC9vS1drbzAvSFU2Y29Mc2J5UERpdEdY?=
 =?utf-8?B?L3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2NDWPGyJ94ZgF1/LAd2GE66iD0or3/67e8h6KzEs24cphhwNsPe3dCWCjdZEBV/tU0TrfN1TLwHyW5FHGosT/XHcGLs49PrkR2nz81QyL/dRkvuR0D2inu/08V4yTLbGp1+A07OBPHPZ7AXHRq88+eqJuLP8/M1Xk8XUYmTf1Bb4sOV9qVq3XB3bzoSV6DAct1tU03GjZMinuCvrMt+pDKeYCK53lOQkAjrhJNE56L4in8SBH9exLOJAAl4IDl1Evoc0Cr4cpntJyWZizPVPTMtmOEaH2v12hTchae5CQfW4lOWyhugculREM3iFZjtGQ+gJzrlRbjDs2EeV6SlgZr54+xvL4rMAc3esXbirb/Vq+HhU5C2OooIXZ5C29SayhXkESGXaVLOxbd9bA7hFWouWBTiWsqT2xXb7ZfutfCPQ4jLWQuTd7Fwi2naS3mClwPdvlZxSAybB6r33vXdeG+LEnIO/gO/o/tkXSDmkbPbNRCjFg2lhBXSTTRNDAmjgX2rrUNs7kwU+TUN+ARocsH9LFMWAJ3OHhw3w6sVwk3RJvdf23GDHJwvo2bCuMjY0nz6v84YJ+1KHGTFtnJlFy6Ad4Cz1o7M/zj1SoCWmyHQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19329d74-d8a8-4a5e-c471-08dc9ff77a76
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 09:14:04.2479 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xpNnrj5XaQSgqhyOQpR413N4hHz3ILjRu6K0CcI1xtAhi6hRSEtYqsKlisK/pl4FsX8On5YyrBmhxZkwYHjx6iRNJt/nIdVsSU8wtiH7cTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7794
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_15,2024-07-08_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 suspectscore=0
 malwarescore=0 spamscore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407090061
X-Proofpoint-ORIG-GUID: c7ByCzs7NFEhGatpeAFEuZFAH3dP1YWZ
X-Proofpoint-GUID: c7ByCzs7NFEhGatpeAFEuZFAH3dP1YWZ
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 09/07/2024 08:07, Cédric Le Goater wrote:
> On 7/8/24 4:34 PM, Joao Martins wrote:
>> ioctl(iommufd, IOMMU_HWPT_SET_DIRTY_TRACKING, arg) is the UAPI that
>> enables or disables dirty page tracking. It is used if the hwpt
>> has been created with dirty tracking supported domain (stored in
>> hwpt::flags) and it is called on the whole list of iommu domains
>> it is are tracking. On failure it rolls it back.
>>
>> The checking of hwpt::flags is introduced here as a second user
>> and thus consolidate such check into a helper function
>> iommufd_hwpt_dirty_tracking().
>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>>   include/sysemu/iommufd.h |  3 +++
>>   backends/iommufd.c       | 20 ++++++++++++++++++
>>   hw/vfio/iommufd.c        | 45 +++++++++++++++++++++++++++++++++++++++-
>>   backends/trace-events    |  1 +
>>   4 files changed, 68 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
>> index 35a8cec9780f..1470377f55ba 100644
>> --- a/include/sysemu/iommufd.h
>> +++ b/include/sysemu/iommufd.h
>> @@ -54,6 +54,9 @@ int iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t
>> dev_id,
>>                                  uint32_t pt_id, uint32_t flags,
>>                                  uint32_t data_type, uint32_t data_len,
>>                                  void *data_ptr, uint32_t *out_hwpt);
>> +int iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
>> +                                       bool start);
>>     #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
>> +
>>   #endif
>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>> index f5f73eaf4a1a..69daabc27473 100644
>> --- a/backends/iommufd.c
>> +++ b/backends/iommufd.c
>> @@ -237,6 +237,26 @@ int iommufd_backend_alloc_hwpt(IOMMUFDBackend *be,
>> uint32_t dev_id,
>>       return ret;
>>   }
>>   +int iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
>> +                                       bool start)
>> +{
>> +    int ret;
>> +    struct iommu_hwpt_set_dirty_tracking set_dirty = {
>> +            .size = sizeof(set_dirty),
>> +            .hwpt_id = hwpt_id,
>> +            .flags = !start ? 0 : IOMMU_HWPT_DIRTY_TRACKING_ENABLE,
>> +    };
>> +
>> +    ret = ioctl(be->fd, IOMMU_HWPT_SET_DIRTY_TRACKING, &set_dirty);
>> +    trace_iommufd_backend_set_dirty(be->fd, hwpt_id, start, ret);
>> +    if (ret) {
>> +        ret = -errno;
>> +        error_report("IOMMU_HWPT_SET_DIRTY_TRACKING failed: %s",
>> +                     strerror(errno));
>> +    }
>> +    return ret;
>> +}
>> +
>>   bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
>>                                        uint32_t *type, void *data, uint32_t len,
>>                                        uint64_t *caps, Error **errp)
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index 1b5b46d28ed6..158a98cb3b12 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -110,6 +110,48 @@ static void iommufd_cdev_unbind_and_disconnect(VFIODevice
>> *vbasedev)
>>       iommufd_backend_disconnect(vbasedev->iommufd);
>>   }
>>   +static bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
>> +{
>> +    return hwpt->hwpt_flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>> +}
>> +
>> +static int iommufd_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
>> +                                           bool start, Error **errp)
>> +{
>> +    const VFIOIOMMUFDContainer *container =
>> +        container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
>> +    int ret;
>> +    VFIOIOASHwpt *hwpt;
>> +
>> +    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
>> +        if (!iommufd_hwpt_dirty_tracking(hwpt)) {
>> +            continue;
>> +        }
>> +
>> +        ret = iommufd_backend_set_dirty_tracking(container->be,
>> +                                                 hwpt->hwpt_id, start);
>> +        if (ret) {
>> +            ret = -errno;
>> +            error_setg_errno(errp, errno,
>> +                             "Failed to start dirty tracking on hwpt_id %u",
>> +                             hwpt->hwpt_id);
> 
> 
> 
> This error looks redundant with the one printed out in the lower backend
> version. Couldn't we add an 'Error **' parameter and return a bool ?

I'll add here as well.

	Joao


