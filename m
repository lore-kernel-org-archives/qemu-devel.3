Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1ED0C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 13:58:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHNU8-0004Dw-DR; Tue, 20 May 2025 09:58:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uHNU3-0004Cu-2q
 for qemu-devel@nongnu.org; Tue, 20 May 2025 09:58:22 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uHNU0-0005nb-QT
 for qemu-devel@nongnu.org; Tue, 20 May 2025 09:58:18 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KDtir0002925;
 Tue, 20 May 2025 13:58:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=pm3nuZSTxiaHy7b0aAhjCVWZ7OxUENsuyG4ibhcaAdk=; b=
 bJEU7SjeAVkMZ3Hi/fVUyxmv2lnBEwPcsdhb/KghhSpChK06ban21FxDG5Z+TYKS
 nSR0pfpGxqyjbWSAqXKq5l/8GQdVotJ0iYz0z4ul4mC1S6P6a4EGuWzRYKQ315SB
 Ko+70Ul+Y9sh/MUq0qStAtnb3re9e/PikApQ0/ST4XuPg4QHIPHxmw+xBcHuNWHU
 IoL8vE5DzQrfPmE6McZ6G4Tjqp124fQhfwksIqMMYTr210www4PZqFLmZH0Vr820
 8+tkBgi3W01ZPhv5GkNZawSVakRdlpsONi5JhHTqCcTmWxIq1SYwOkFY7dgQLa0S
 2glYjxxsXBuxJSBR1JPMGQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ru27r05s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 May 2025 13:58:13 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54KCfQaT015745; Tue, 20 May 2025 13:58:12 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46pgw7svu9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 May 2025 13:58:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M6cVahr0EiI/5UPW5Uu2LyXaGWQECQMDvW8zb+3DvvAe9aQDdzqas0ieIdodI41dSYMxkdXogVbYgcLYnjmFnePeJzqgu7y22BIjZfY5ga1oIN/Vnvy6XiToCJbLYptEEbG8FwvM9KzaC1YwlSqgDtFLBGiAGYEaLQRGP3HLT4LFExdTEgO+bTeeuVlE4QpZGYSQa/tjjrTqU8QPWYl886YPB7cwDJDMHov6oA/nghF8yfdkTbW3Rybj7gS+euevpMY6MCo/rVACquUaJmO291tSX/gYpYGUktngUQ3KyqZk9vVn9FCT3weOsmMi1NQl5Q+EW5MKVH4TunBbiE3wcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pm3nuZSTxiaHy7b0aAhjCVWZ7OxUENsuyG4ibhcaAdk=;
 b=FWhu+JolTjuMHcsACX/T5+aDYmA+5gQ5JrpNLrKQJpkPX9TrzbliESJdpgYfUyzJfhQqb69DI9nKhXja4pIt0TREK5k+xd7+Y8Y1RGzKdfa73UOGv3fmIqFvbHHqcs5B/pJjAAzl8D+FvUWjDk/OHG4VXBrnUkn9zae3kbn78O/GYYjPTa5u3fRTpKmCvcIA9T9xCFO8UbvzviLPHGMi8aTv4oFA8JViFde181j42naHy5qbCDbK3Pn4raw4UUQP9MxHip2HxIMg85KY/OdywePrlwUesRN0lQqd0q4cImCYcFSw0Lyb0gHTHzc7qQywN8OHEAGrPsSzvnBWA4UNaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pm3nuZSTxiaHy7b0aAhjCVWZ7OxUENsuyG4ibhcaAdk=;
 b=hkaDMPobQrlRA4JvOokbPPt6XEFZC2pRqYxJlWiilnJLFZyMBMLsVilvOAJWhhiGtkPCI3ue5JypytQO+YO1h2htDSOPKdriwXVZ+QXLrwXrcdlmfdsmIkgyG/NrHxiryV2LBnm3NddDjPgrGcKSB13GCEhF+Xg3YPCFCVXonCU=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH7PR10MB5829.namprd10.prod.outlook.com (2603:10b6:510:126::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 13:58:09 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 13:58:08 +0000
Message-ID: <7b0f1e6a-ac9a-47e8-b37f-e8b09abce270@oracle.com>
Date: Tue, 20 May 2025 09:58:05 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 31/42] vfio/iommufd: use IOMMU_IOAS_MAP_FILE
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-32-git-send-email-steven.sistare@oracle.com>
 <cac28777-c881-4ec5-b49a-8293019b1d33@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <cac28777-c881-4ec5-b49a-8293019b1d33@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0081.namprd03.prod.outlook.com
 (2603:10b6:208:329::26) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH7PR10MB5829:EE_
X-MS-Office365-Filtering-Correlation-Id: 73069ff9-6226-4f59-07be-08dd97a659e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MFJ0UVVsMTN3eVVFdGVFV2NLM3A4MElyVFV6cmJ4dSs0SEZVT1dRSGNsa2VO?=
 =?utf-8?B?NEw3T05nOWd4NUFwOGd1RHhpVjBnSDZ3c3ZxTTdFSVZmS2g0QzkvbnJkbGlL?=
 =?utf-8?B?aFFOZ2tBS0pmc1FqWHpjUVJxSHNxVkVjR3lzQnN4TVFSY2l3UGdsbU5zQTBw?=
 =?utf-8?B?ZnNPZDc5MFZ6Nld6a2YrYmp3Q2FiS2U1UnFPaXZvM0dubC9MQ0thS0s1QUZr?=
 =?utf-8?B?dzZPUGQ1YWdQbjlUNXBabFJVeXBES1B0ellWaVR2VWFUbGx0TmVZbUFDWCsy?=
 =?utf-8?B?YXVtS0FCaTdYUzNwVUU2cU4xbncvZ253VXRtQVljYU50S2xhMkpQQmpuNWR5?=
 =?utf-8?B?Y0UvR0lHb2hicXJJR3pPL0thTzRZYTFNU3B1a25mN3BiQUhIM2FXcE9SWTBN?=
 =?utf-8?B?YzdldjQ3aXoyVkdJYWdnWURKdHFHcml5WE05Zms2QjR5RlROYnVEZEZQaUEz?=
 =?utf-8?B?SGc5SGQ4K1dHRmx5ZEplQld0WGlhZEFiRklseFl4SEd3SlBLbmpSOFhjeDJh?=
 =?utf-8?B?ZkdYdW02a1JNUWZndEhaVjJablNaSU1IeHlqQTFhcUlyZHZ2R2I1ckF6QUN6?=
 =?utf-8?B?SENJNTllazdCU3FDV005SzljOWRlQ255cVB3YmtKNThUaXEzK0ZkOTZBRXdV?=
 =?utf-8?B?RTZPeEVvNFNESFVtd0w3MUd3b25TTmcxT0wyMlJ2SmZQdVVBaC9pMUM2ZTYx?=
 =?utf-8?B?Q2F1V1NpUEptTkg1NW5Uc1ZSSExRNnBqbUh3WUZjNFpYaHBKTHdGakdJNnVJ?=
 =?utf-8?B?cGJ0eVQ2YldBUGFQK204UXVMMGcycnZJZmc5QVI3MkRhZDRUbFY0MGhKMHYx?=
 =?utf-8?B?SDdXZVJiVDd3emdFdlV1cHowWjNoY05IWE1EZGtOWmRjNG9UQnJsZlArc0I3?=
 =?utf-8?B?K0JNTFpSU0dkaUlQUWpOdXYzQzI0bmx5dEpwbUk3aUd2bmE5ektuOXAvTGd2?=
 =?utf-8?B?OU1FdjNaRGljUFd5b0YyeEljN1pNU3lVYzF4Q3cySGFaMnUwZHllYnZ0emls?=
 =?utf-8?B?OFVOaUdyaFNwMmxwalFTSFlaZkxCK04yV3lNYlBXRmFzR1NKc0IvWnA3dW9X?=
 =?utf-8?B?dDAzUDRtTWN5SWprWlJ1aGc3NzUwNHEwakREbW82OTVMY3EyQ3lpdVhKZkx4?=
 =?utf-8?B?cFgxSHdDY3FYZTZCNlhnNG5JVm9pZTNyMk54U1dRRzh3dkJuTWVCcm1PaHpn?=
 =?utf-8?B?U1FjNXNlc2lGVjRoMkZab3MzTU4xdEp0czZzYXdFU2hTTnp4Rnp0VnUrSVpE?=
 =?utf-8?B?YmRKd2NTSmttZUp5eS82ZWVkc1I4RzJhSDArMkN0YWx4OU5qYzM2LzZsRk1Q?=
 =?utf-8?B?Q084U3QvSE1SVWxtbDJseDc0c1dMYm5Rb0tqcm5nRmNaeUZuamtiQ1dXRTN5?=
 =?utf-8?B?OGhpbldLWEV2R3FHaW9HeUxySWRVN29rWllWVDZXT2VTOW9UMHV0aDhIRk5H?=
 =?utf-8?B?RmJ0U3AvY01xMzdkOEZhVnFlUDF0b3UyaVlsY1NYYjMvdm92bnBsN1IvdmZt?=
 =?utf-8?B?V1RWRXVJaWNPQWlicHJnOTNXOFFkeWQwS0pWMExMRW9uUkpSOVpDMXh3T3ZT?=
 =?utf-8?B?bVJYQ3hrdGEvU3QxWndNTHVQS3VKTXFhOU0xSnAxWjZ2NWl1RXFscE5BbHZK?=
 =?utf-8?B?V1VkU1dWRjhWV2l5aHB2bFFVVmJ0TkJ0ckZhSnd5WnpxWFpJZDlWVURpL2Yv?=
 =?utf-8?B?SDNMaTIxY1ZWV0xTTmlsWUdFeTRpd2tXTkFBOE4vMUZ3ejRqb1p4SWt6QkZr?=
 =?utf-8?B?YS93Ukh3NW9pWTYwQUZYdThqeHplWUVFVjRtd09kNEFxY2VMdVN1Tm81cklM?=
 =?utf-8?B?ZHFBQ3pWdWt2c2g5Ylk4Z3V2UVRUY0dWZUphVit6Z01GMTl6MzkzT3pDaXZH?=
 =?utf-8?B?RDNmNjloTm9lSWtPMXd1WlZYNzVXOVJGWGNYQ001RE8vSW9Xa0kwS3RVYklk?=
 =?utf-8?Q?yr9+gsv0vfA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHF5UnRzRzBOZEtJOFFJbjA5aldibWJxd0laanpkbEE0c0t3YWthZUVIT05a?=
 =?utf-8?B?TVorNlBtYi8xcTdjbEUrajN6cjZoM01yL0Z2d2htNWdULzlVTytyckFITnlW?=
 =?utf-8?B?UUdMS00xcjNDMElIc2FDL2thbzhCcGpaQkRpTUlKUmlmWDVNTU95Ti9pUFFh?=
 =?utf-8?B?aXBVcFVsUFFmU2c3MkhCWTBFV0xySHZzNTZtSkFwVlpTcm1XVU9nMnpsRW5m?=
 =?utf-8?B?UTdhMDRZV2dqQ2NFMktyYW90VzRuS3c4dUQ1UkpOUGc2ZkJmUlY5M2IrazVR?=
 =?utf-8?B?ZExzbzZ3QWtVSFdsUGMxMktTSkowMGtYR2JPR2NsNTJhcnVNSEhRWStBSlVM?=
 =?utf-8?B?dWhrV2JEcHRsemVrK0VLWWZyN3dqRTNTT0ptTmVQNDZhQjVLV2szTk51WWZE?=
 =?utf-8?B?VVV0eklSQ20zVnl6WDhCVUlLbXJZRHA4SU1XZi9Ud3h3VklFL0J0dkNDTzBW?=
 =?utf-8?B?RHpyUmFoU0t0QW1XYm9CQ0lBc01ON2xRREZ1OEpyV3NaMGJINDY3OVhPYlVt?=
 =?utf-8?B?bjRaWnNGcVNQWEFhMW45Um84S1pWTDRrM0NFbFNNQW10VXpUalBEb0lNM2xK?=
 =?utf-8?B?aU8zTVJWT0h5ai8yMzZzejM4V1JkZEZHWDdQWWJNaVpLQ1Y1cHNBQ1gvc04v?=
 =?utf-8?B?dDcxcDJGMTBGK1VtTmxNK0lNVm5KV3J5YUl5MkpneDN6M01tbXU3M21DNlR1?=
 =?utf-8?B?WXIwNmdWMlZ4TW9xUUlYNUpBZzYxRDlWNE1SQ3A1ZkhPUXRPYnNha21IVi9H?=
 =?utf-8?B?WUI3VHZRRVREd2hrazZrMFlZdHlaM0ZJcUhXK0J0TzNXc2lrUFN5RHhuVXZU?=
 =?utf-8?B?d20xaGREYWdvRlU3NnMzdndUYUowV29Zb3FWbEFPTTJkUnpYQXhUT0duU3VN?=
 =?utf-8?B?aXRZTy9lMm1DNG9DVHgybGJLUmF3RGUzRVYvcXZ1Tm5YSVVGdUJBU1U0VjlK?=
 =?utf-8?B?a0p4Vll4WmNUcTJPQ3dWTVNPK25pK0J3MEVxLythSlpvQUtaSVpxcjVROUhw?=
 =?utf-8?B?dVYxSE9BWkRWeDVwTTZ0S1d5Smx0ZUZrR1hWRWRDTmlnbVYyMytTbzBFMFRH?=
 =?utf-8?B?RXB6emZYb1FtdWZLQ2JrS2N4R3BFTkVPUlExRGQwSnphQTlUbWRxS0k3L1FT?=
 =?utf-8?B?TVVibzBpMEFoQ2JpRnZhcHcrV295OTQxNEtBSzJ4NTJ1TUt3dDJyYk1ncmdx?=
 =?utf-8?B?TUZ2NDRzamlFc1FESGJCTTVpMTczcTJnUDZKQWRBWTNSMEZXYWhYdFE3c003?=
 =?utf-8?B?K3Ezd1pnWWlVamt0TFNQbGxYMGVLWU55dUI4eDduamdhdEQza1VwajRkUGNz?=
 =?utf-8?B?NlB5TDQvV3NFbWV6QVFrcTBUWHBKRitseitPR2RsempKMnJNdEQ2ME9JeDJz?=
 =?utf-8?B?ZXNPc3NWWEtzL2J4M3lrWi9tTnBNeTJRdmJUTHJRWThHQm44bndBSGpFUkEx?=
 =?utf-8?B?ajhQZWFaNEFMWi9kYkY1TGFVekR5SVRQeFFqSitONjc0YmQ0VUtMSEwxM252?=
 =?utf-8?B?akdqNG03QzBwTU9xOWJuNXBnL2FpOEdRcUp1N2J0UVFtZ0VyWUVMc1RxUGQ5?=
 =?utf-8?B?UFh0UmIrMllBRlFLTWp3V09qdGs3dGsvN0xaclJBVmNYTE91YktpSmRLRkln?=
 =?utf-8?B?U2Y2VXAwZVd3OWw4bEZNUk1vdFpPbDltVU1LT3E4djZsQmxObTVrengzTGdW?=
 =?utf-8?B?b3RrV2ZpeHNHVnFLb0NzZElPSlpsbzhNelc1SGNZVEl1Q0lLUU4yRC9iOWwz?=
 =?utf-8?B?M3VaYWYvN2lRNitpcVVhLzJBOTZpVEU5YU53SEFVWDBjelpCU0hCOWI1b29P?=
 =?utf-8?B?czVYMWZuaGZ3eXJEQUpvWDIzTE1UeHdKNW9iaG8vV0tlT2lCWWlzWVVIeWNN?=
 =?utf-8?B?QjBiOVhPSjFRcWxOUm1ycGhIZ3lrMVZ1c0FzSkxScWRXek1ma0NMYldKZ01L?=
 =?utf-8?B?clh1NXZaaks0L3MzcFBKdnIzYTM0WUNRL0d4UWE1Vmt6OWRtcFRZY0hYTXoz?=
 =?utf-8?B?cStSbUlmWkg0OWh1Z1ZKTXlrRmk3YkcvK3ArSkN2RTRXRGVNbGZnSDFjaXB3?=
 =?utf-8?B?OUtnamo3dTV2NHB0UXh3Nk45N05NOWN5Umd1NndwSzI5OG1KZGV2K09kdEFW?=
 =?utf-8?B?YVZVMmlpYjg3djVnZ2puZmdoT2pYUFpxYkw5RTBXeUlpaUw2ZmFRYlRCc09K?=
 =?utf-8?B?UHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RUey5hS0RhBCC2joIplra4QWDb5Ha4IcIKwOXdBqLEiJJBwzTKJCdxwuURY666S8KGl8lhhEBJGQspC2dLPWCcw0GUMx7GmdIfsB9Xr+xF2SIpErbjMoZkIrz6lLvF9UHMW6f7gQDzwGufDemDCk4j39K10gnoe3VovG1csXbD4sJsRyNhXjYEk1RWaQFSMK2PwL9HR1XWeXrwIUs78BK8hiMixk3ugOIA0bRBw1wFy/HlCSLl/mVJ+GVNisshBnoqmaL1wIrQkWiA806QFW+0iiDEJbdT6t2sE/FTJg4R/0FSiE5TZtWCMwxc1X+/HWTsYT6lqkNN1/s0BsqbtCL3bMN5J9c6akxcjnVs063/AUqFC0sSxXJkinslzQ2AshNhUaTQnOphIwmbyTwUf9O8M6etXcbADkTC3DhFGiYRKi6/wM13F4/QEf/YsH2efzL7VFTjh8dQ+HjCXl8v9S+0p/wOYy9mO/nL5XFqxNoa3Dbn3Anl9E3K/F5NKvLOjpIFxCGJF9yUWBkQ0M1oQTTpk918U7YxQRL6zqi/IC/QNv/1rpXUhKNHB0wgyEISMm8SQSO2Q3uH7IqqZjitIGGLMwqpb88hI7HkouBnNdTyg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73069ff9-6226-4f59-07be-08dd97a659e0
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 13:58:08.6241 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CRZMKtCf68+3qLcJouNl+MR8SJVTCCwphJS5TRdxuDAY84tL9EyP5z98vyJQTlXuFEgq6yrPVFJccAZDWxf8Z2LTnMLT0MeZFlbMXkw9wCg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5829
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_05,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0
 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505200110
X-Authority-Analysis: v=2.4 cv=KtBN2XWN c=1 sm=1 tr=0 ts=682c8a75 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8
 a=-WfsLHh3GgrZwrjktH8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 65NVTmajQcxHUG1NLL3sQN9I-tIrtDue
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDExMiBTYWx0ZWRfX9OEggrwfzrNm
 9JurJ3fR0pMPSWEz9pjmSOaFMkDda0o0bTD1xtser7zSevIW7qStvEManeZOWNrC54tWv5BkRV6
 5hjz3ahcRKcKOcyJ3uzul/uVrr3F6VxjSJnmXLkY21Vv7gTg+/cPc4rleK4GGxaaDevzYNbB6Tu
 ZCbV8fxeCj5BwVlF96ut0GE3+FPeBvpz/nMm2HUSssNPp6Jx9b9VqgBNo3S+WLRQiVIdiRBrio5
 QFpP9Bhe9QX+gowUDMiEjU2WA6TblTewjVqjAyASLAsBFbKSfszfMcP8FYEzLFkRgfbzRuwd+z1
 qryfyXZ3yQhc1m6AK/66a9VifvJZMKiP4E/mx7u6Da2rSfNwtxJy+TB+gG538NZWUijwdtg6tSP
 Qx3Ltuf76AtACusIF49RL8fzKEMDvuVRH1J5kbXGI03/edrS6fAoK3LVSJwb81oLXRVrrQmL
X-Proofpoint-GUID: 65NVTmajQcxHUG1NLL3sQN9I-tIrtDue
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 5/20/2025 8:27 AM, Cédric Le Goater wrote:
> On 5/12/25 17:32, Steve Sistare wrote:
>> Use IOMMU_IOAS_MAP_FILE when the mapped region is backed by a file.
>> Such a mapping can be preserved without modification during CPR,
>> because it depends on the file's address space, which does not change,
>> rather than on the process's address space, which does change.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   hw/vfio/container-base.c              |  9 +++++++++
>>   hw/vfio/iommufd.c                     | 13 +++++++++++++
>>   include/hw/vfio/vfio-container-base.h |  3 +++
>>   3 files changed, 25 insertions(+)
>>
>> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
>> index 8f43bc8..72a51a6 100644
>> --- a/hw/vfio/container-base.c
>> +++ b/hw/vfio/container-base.c
>> @@ -79,7 +79,16 @@ int vfio_container_dma_map(VFIOContainerBase *bcontainer,
>>                              RAMBlock *rb)
>>   {
>>       VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
>> +    int mfd = rb ? qemu_ram_get_fd(rb) : -1;
>> +    if (mfd >= 0 && vioc->dma_map_file) {
>> +        unsigned long start = vaddr - qemu_ram_get_host_addr(rb);
>> +        unsigned long offset = qemu_ram_get_fd_offset(rb);
>> +
>> +        vioc->dma_map_file(bcontainer, iova, size, mfd, start + offset,
>> +                           readonly);
>> +        return 0;
>> +    }
>>       g_assert(vioc->dma_map);
>>       return vioc->dma_map(bcontainer, iova, size, vaddr, readonly);
>>   }
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index 167bda4..6eb417a 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -44,6 +44,18 @@ static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
>>                                      iova, size, vaddr, readonly);
>>   }
>> +static int iommufd_cdev_map_file(const VFIOContainerBase *bcontainer,
>> +                                 hwaddr iova, ram_addr_t size,
>> +                                 int fd, unsigned long start, bool readonly)
>> +{
>> +    const VFIOIOMMUFDContainer *container =
>> +        container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
>> +
>> +    return iommufd_backend_map_file_dma(container->be,
>> +                                        container->ioas_id,
>> +                                        iova, size, fd, start, readonly);
>> +}
>> +
>>   static int iommufd_cdev_unmap(const VFIOContainerBase *bcontainer,
>>                                 hwaddr iova, ram_addr_t size,
>>                                 IOMMUTLBEntry *iotlb, bool unmap_all)
>> @@ -802,6 +814,7 @@ static void vfio_iommu_iommufd_class_init(ObjectClass *klass, const void *data)
>>       VFIOIOMMUClass *vioc = VFIO_IOMMU_CLASS(klass);
>>       vioc->dma_map = iommufd_cdev_map;
>> +    vioc->dma_map_file = iommufd_cdev_map_file;
>>       vioc->dma_unmap = iommufd_cdev_unmap;
>>       vioc->attach_device = iommufd_cdev_attach;
>>       vioc->detach_device = iommufd_cdev_detach;
>> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
>> index 03b3f9c..f30f828 100644
>> --- a/include/hw/vfio/vfio-container-base.h
>> +++ b/include/hw/vfio/vfio-container-base.h
>> @@ -123,6 +123,9 @@ struct VFIOIOMMUClass {
>>       int (*dma_map)(const VFIOContainerBase *bcontainer,
>>                      hwaddr iova, ram_addr_t size,
>>                      void *vaddr, bool readonly);
>> +    int (*dma_map_file)(const VFIOContainerBase *bcontainer,
>> +                        hwaddr iova, ram_addr_t size,
>> +                        int fd, unsigned long start, bool readonly);
> 
> Please add documentation.

OK.  Using @dma_unmap as a template:

     /**
      * @dma_map_file
      *
      * Map a file range for the container.
      *
      * @bcontainer: #VFIOContainerBase to use for map
      * @iova: start address to map
      * @size: size of the range to map
      * @fd: descriptor of the file to map
      * @start: starting file offset of the range to map
      * @readonly: map read only if true
      */

- Steve

>>       /**
>>        * @dma_unmap
>>        *
> 


