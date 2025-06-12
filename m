Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2627AC61CE8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 13:35:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPi4J-0001kC-HA; Thu, 12 Jun 2025 09:34:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uPi42-0001fd-Tz
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 09:33:56 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uPi3z-0007zK-SN
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 09:33:54 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55C7fbKs019032;
 Thu, 12 Jun 2025 13:33:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=otodZVRiGcodMoN34xkULjnPlKpb2q2d0yAePPF56Mg=; b=
 LJwlnf7laCbEr/gExt+TL5OAZ7X5hryiXrcR6tsVppkfyMrOa+v9PkdhMS+vw1WH
 h6W441Ngdir/liT3fk4v5xvmDwYHC/t7yZouzFCPaipYJYFyikbOgfSkAuz4J2IZ
 JOU4XtUpFiojFyQfoAj/lR4Q17xTfMGgbk8GABGYAaPhMVY86FMs8Rh87kVr4JGv
 na9Q+L2TyTO+oZboCD9i6SC6LVl0ClO7my5yBkdDxcuPLQPJQ5AMBtUp5NVPledi
 2PF3UFOE670HBQEzOpsGwRcu/CjxC8l0Tvot+Lz6aVpk0bVlRWmvnQwboo3+ttFs
 qf3WbjVlMbAyXZTX1AQnlQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474dyx1sra-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Jun 2025 13:33:45 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55CBu5sj000480; Thu, 12 Jun 2025 13:33:44 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 474bvckm9u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Jun 2025 13:33:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nwbFdNNL/O+1fPq7CzJhrNtXywqe3nrjfK/QFO8JZ/wpK1z4hIFob+igOeSgSYVcoMaYhYqkSEd2FbdR+JiZKP3j20mGmcq8OToHOkNHRvmuwaUWUzsVvat+nal/Hyzwi/AcN7xK0gEMSDIgf472xpKnWAk28Mc1+jEmvxgZeTL3UTIdBwOlh2eP7bi+XSpMtWN/HkUKMSvQtVnAsHEYTJryMi2fnOQzUmXoZanrQgfue5eadTFDIQu8Svn/7fXEuh4ZmZJXpN3Fbop7KmTfounRhw2n2ImwsvXnpLFXwL6HfKAL6aozQvDRbE7QkH1fNxjZj2uRUvWwK89zAriVzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=otodZVRiGcodMoN34xkULjnPlKpb2q2d0yAePPF56Mg=;
 b=yYvwn84nMznkMrFxXt3lCyRhyAfayiZCzozrYOW9906bh66y16lC1r00efpODj3n55eY66em0w88SNU49Dey8E2TcZTb+nt3WERRMxatf4Ca40gRLOxu48fWnG97qKlcFN9FoNMQfEmcIbapjV2e4KuqL31HyOozePivAtGIXZonDgZLxTkU0Y9B/N+0gE58oXfjlxBK+Ctixpz8OJSs3Aelu+yQ7Of2RqYrTvbV8blQvJWYFmnbIrw7X2Wgn6jZT0f0ZvKVf8d2Z16XUzlsb5PET69DDfDxwSBRBtif3rmCprxqAEz0pCI/sFQ1XZd/ZgCb2hyA8Vo390v8nB7vvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=otodZVRiGcodMoN34xkULjnPlKpb2q2d0yAePPF56Mg=;
 b=uzSNQjPyR+zd09xCYnSxtkEnfwnQeELrarsy2IFa6+CinQsKixPoascps+s4CdU+V7fc9GqNbGKxbwnvX9TraWsC+PRqnB+FxdBYsGdDWwb7eNalrIBc5/MNw9HaLnbPVzmf6MsO+u8EE8w8gExTdrFhHJjis1dt9r5x37gHWOc=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by BLAPR10MB5204.namprd10.prod.outlook.com (2603:10b6:208:328::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.23; Thu, 12 Jun
 2025 13:33:41 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 13:33:41 +0000
Message-ID: <5dc94e5b-8f00-4961-b62d-55c43064a9bf@oracle.com>
Date: Thu, 12 Jun 2025 09:33:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] tests/migration: Setup pre-listened cpr.sock to
 remove race-condition.
To: Jaehoon Kim <jhkim@linux.ibm.com>, qemu-devel@nongnu.org
Cc: jjherne@linux.ibm.com, peterx@redhat.com, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com
References: <20250611205610.147008-1-jhkim@linux.ibm.com>
 <20250611205610.147008-2-jhkim@linux.ibm.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <20250611205610.147008-2-jhkim@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0P222CA0006.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::9) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|BLAPR10MB5204:EE_
X-MS-Office365-Filtering-Correlation-Id: e36e5652-9793-4658-c751-08dda9b5bf08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OW1SUTRVQnMyOGFwTGEydFRJaTBWWEU5V3BWdlF0UGNvLzdQSzF1ZkRSank1?=
 =?utf-8?B?QWtaN0FyNCtjNTc3UE9JTStwYTErZ1IrZzBvejYxc1hweWZKVFFUTFNFT2xp?=
 =?utf-8?B?STlKbmhaVnZ3ZmR0eE5HK25sVm1Ya2FrK2cyWEdOTUYzZGVUY01sL0hFNmxn?=
 =?utf-8?B?cTRiOTRTUmdmODdpbjRLdmlueTduaFNFbGNqTkh4Qmw1Si9Sd0FmWHByMldi?=
 =?utf-8?B?eTdiSTlKNFBmMVA2a2txN3paSy8xTllYVHZZWEFZQXB3cDVTMExKYUxTQW9o?=
 =?utf-8?B?OHo4djVvL1liRGNBU0FlMFdGWWk5UEJGa2N3bThOR2EvdzlFNWE3VnVyY3ZB?=
 =?utf-8?B?WlRYVSs4ZDZSZEhGVjc5RmFBMzRoZ28yaG5hSkJaWFA4VjQ5U2E1QnRRcFFK?=
 =?utf-8?B?NDJJemxMZmJRbXpMS29oYWpNb0NIdFlMRldWeFI1UVhTbnhnMVZxTmlLNnBO?=
 =?utf-8?B?bmY0SWRpZUloaTYraVh3NzlIS2gwZExwaC9BSzhZNGVHRERDMzBTcE5vc2d4?=
 =?utf-8?B?a0ROZDVLd3NMMHpDTCtmZnQzdDMyTERnUkNsMmpBcDFMUisxTFE0RWIwVlB2?=
 =?utf-8?B?SzE3U05mbUVDaGpWTmNCMVIxblQ3ald4MVF1RnFqeXZEaDlweEJjR3FwS25w?=
 =?utf-8?B?eitqcDVRRlo3eU1HVjZyV3d4czViUFZGbHBqbVd2UWtMTStiZFBqT3ZyOHFP?=
 =?utf-8?B?Tkw5clozWC9NOUxrT3pjeEJMQ0MwYi85U1pFakc2SVpGRkg0SkE1Z0REc1pI?=
 =?utf-8?B?cXBkMHljakVJeS9tcUk3Z1hlYnNVYjJia29zOUJyRC9UQlNnNGlFd3RGT2tR?=
 =?utf-8?B?cEQ2aGZRTm5ZNHUvMi9Sa0pTZk5wUGdlckcxVGkrNzRJYjAveFBaek5xOEhm?=
 =?utf-8?B?L1YyeEtMaE1IN0E0Tlo5aE5zYUNlektrN1FWNGtUN1diOFdsUXlnQkoyWVpw?=
 =?utf-8?B?c24zUEtPeU1Fc1FsNzZvaVlRSzFodVk0SDFKclpoYWdjaXB2d0x5ZXh2em8w?=
 =?utf-8?B?WC90b0lzZU1vLy9WQWpBR1BJZTZDeEkrbG1FVk5LVmJKNHVQSW5vYUozOVFk?=
 =?utf-8?B?RkhQZzJ0cFR2TU44cjl6VklXU05UaG5HWXNFNGZKbXBJL05hY2RuWkpTMy9P?=
 =?utf-8?B?eS9XUk8xUTZMUnIwMHErZmlCcERqNWVoZUNwREc0dmFWUFlVeXBEZXhzaEVV?=
 =?utf-8?B?QWM4dnJ2cUZ4Z0NlOElOWTBJYWF0ZFpZQjBJL2RpRUpyWXlkaVNvcmlBRXVO?=
 =?utf-8?B?S05EdlhuN3kyZmxLTTVNWHdwd0JNSkI3cGpOMWZ6c1BJT2k5Rk5wNUxqTjha?=
 =?utf-8?B?UVoyTU1CQVRMZjdIVzNVQytiRUpDNjc1b29RdVpURGRBMjhzZmQzbjNjbXZO?=
 =?utf-8?B?UDFrVGFzMnVVeW8wamVvOW1UaVc1cXdkL1prZE1sUWo1dlJBdm1XMGExQjFp?=
 =?utf-8?B?V2RTZnptS08wVnRIV3ZjeGNzVU55cGV2MFAySkNvY3JNQkx1dTkxSXd5U2JU?=
 =?utf-8?B?Y2VZUVpreEF6S3BBSXF2MzM1bStxRmlyY0l1b1hyVkJQUnRaOW9xQS9zVTlw?=
 =?utf-8?B?NnVYY1BlZERaRkhVeWQzb1V6b1A5bVVQWlhTL2tQMFRDVEV4OHk0SUVPak5j?=
 =?utf-8?B?ZzJySkYxQ21kSWYweU1nTGJJY1BPbXhqNWV3YkFVT2haSXpQaGVFWWpmTFVM?=
 =?utf-8?B?V0JmdXFNbWQwUFhhSzczSUNINitLY29kOStBVXZ3WDMyc25EWHNxazJCaEZW?=
 =?utf-8?B?Ym9NYzNiZzB3MGRWRHRPTC9CL3c1cmxsZ0pGUWRPUVd4MGtLZGpaY09WU0pL?=
 =?utf-8?B?YjUwSTYzbFFGM0ZlV2VscGxpMjVNQjlzY09jRVh0d3JjQjVZaTBrcjlFdzBs?=
 =?utf-8?B?NWszVUNkSFk4YTlmOFNBTE02S25RV3VsZmhJQzd5d0ZuYk51NzluS2luR2VC?=
 =?utf-8?Q?6uaRp9TQ7pA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjBzMnlNOFNwbkdLVlVmb1NtYzdyQVkzdzBsbjlrbVE3cHZFZ0k5UTE1cE54?=
 =?utf-8?B?QjNERmxkcFIzbnI3TW5MUFliNGdEbklMcGJac2U2OXIvSjRQMGtxV2NhVDNY?=
 =?utf-8?B?a2ZEQmZsQ1RQcDZodnEybDNkUE9TL3ZxS0xTckJoVGNGalZVZFhSdzc5ZzMx?=
 =?utf-8?B?aVhnN2pPRm51aytwOC9uTXRhdFpGNnhnZWJBOWgvSGhnZURGRVVmRkpveExW?=
 =?utf-8?B?WGZNREgrcnk5MUxVZmw0TVE5OWxYNWVIeFo3RWhyVzJlU1BwZ0k2MWFDQWpB?=
 =?utf-8?B?TURUWm9PWG0vUmxDeHVSL3cxbWVsVlNjTGpDVlIwelVSbUxSNGVJOUpncmVr?=
 =?utf-8?B?Smg1Rm5qZE1nWGNqZjZ6dUpwcFZ3YUVGdU1qY05adzJEWXgyYzFzd1hwSXox?=
 =?utf-8?B?ZUZ1MHN1a0lmNWtOWmNpQ3hGbTB0elRGdlluaTUzRyszSmpyMXZFbFFnSTVP?=
 =?utf-8?B?eGlmNTJ3aW1oNGRGNFAraUtQYkRXOERmcjcrSHZsWk81UFhOZzE1NFFLbXVs?=
 =?utf-8?B?SW10MHBtWkozdURnWkxOZmtSRllNKzlMVEMzWFN4dVl2TUUwTkxtK04xRnJL?=
 =?utf-8?B?a3lFWXJWVk85U1drbnozSWJvMFFLRmJOanVZZzhjdlByb1dxV0o2b3Vjb0JW?=
 =?utf-8?B?OTQxSGtRV2o0NkR0SU9sOWQ1N2xncnVBcTA3L0VEdUs0T3VVR1c1Q0cyL3pC?=
 =?utf-8?B?bkpxYk1TV3JENnQydCtTR0M3NC81bnVVK0lJOG1PZU9RaXlzTFVTWGRRNDNr?=
 =?utf-8?B?K052UzBmUnpDM0MxOElLbWFldExvM2VsSk92aUloMzhmZlBhdE1xVVVWKzBs?=
 =?utf-8?B?Slk4WkFsK1RYL08ydFdveXpOdnNjMU02UGNVRkhtKzc4MnNza2dKbFluZ05m?=
 =?utf-8?B?UVJyOGlwTTBML3VsRnRBV0lFZWNMc0FsUUNOa1VRd2w2aDNLVEZCcXI4K1ZE?=
 =?utf-8?B?NTJYNlg3WUMrakMwbGd2d1UybUNKakRFSnBBc1lPWDJVdHJJN1BwdjhSaHlr?=
 =?utf-8?B?MytKYWdHYWk1Nklhd0FtTmVzSFFDU1JnVWlkL3NCTzBxbDdoYTVaWXhBN01O?=
 =?utf-8?B?TlFSVzZvTXh5MVVJaXpMZTlNWVR6VE9KNEtHQmZvdVVlcTR2NEhOWm1YVElt?=
 =?utf-8?B?NDR2NDhrWVV1SDFnazBKcXRNWDlZZE9JNkNJbERkcXFGSjRmVG5jMFdnZ1BK?=
 =?utf-8?B?UDYvODJkcGQ3ZDB4MlVJNjNVU3FHT1R5MkVGWExRdldWaWRyOEtyQU1Gd0lV?=
 =?utf-8?B?ZFlvSTBSc3VIVGhSTHZOTU5zck4zdXFmNUZHMUVQd3JkdndaSnFWZUtBQWJW?=
 =?utf-8?B?K05PN1NFdWRkVXREVHkzSk5CZ3N5TUVMbnZZclJ1d0lvMUNOZ3ZqUVZzQUZ6?=
 =?utf-8?B?L3k3VkZ1VFluVFQ4YURjdVg3VHFEMjJKZnl5K2lwL0Y1QnoydUJpdU9SVFNh?=
 =?utf-8?B?ZlNaS1ovVmpvanhWWVNPZlRKWXNaYm96RDVoOGEwNWdSTmFqU2ozQU5rSWxX?=
 =?utf-8?B?WTdoU2c2VEx3NjRWdGJCQllZRlF5a04vdGQ1VXJZaTVwM3pkSmlGaGhDOEhk?=
 =?utf-8?B?d0QzbmErdDRKWE50cmFvVEg3U3U0WTNLdDUvNWlRbWhub2NDM3hrajRwQ1My?=
 =?utf-8?B?SkdJN2VBSENRR2FSSEdiQTNhdVhQalhtMHRrZlk4S0Y5bmU0ZG9QZDRpbU9E?=
 =?utf-8?B?UFl0dm9CYXIxb2NBWWtFRENiM0dDZElxN2daNWdzQmRSVG9PbFluSEtCSFlo?=
 =?utf-8?B?enRocG51ZU02ZnBZOTNKVUtlM21QQjlKbGcrNmpoeFNGR1FodGt3UC9OSFQ2?=
 =?utf-8?B?Vk9FaWJxRWNLRDJCaW5MK0NDOVVOaCt0bWdvM2F4VXd6bkpxWGRtQnVVeG5h?=
 =?utf-8?B?RnBheEFuQVhTL1pqbWFvSmt0cHNUOER6Z2h2djBQOWZtTW9GSElFWDh1MVNN?=
 =?utf-8?B?V0o1Y3N6Sk93eUZzSms0ckxCTlRQN0lLVGI0R21OR3JwOE9TS0puNHMyVnlu?=
 =?utf-8?B?MXhaQ0xKL0s0VStGSGtoR0ZvWWdDV213L29uQ0RXeFl3bG9mUVpiYWVtSUJP?=
 =?utf-8?B?TDZXTENGT0EvSkIva3c1eEtwRE01QS9Vb0lwUzVNUHRkWGlxcElsZjFwRGt2?=
 =?utf-8?B?NHZ4NGt2a28yeUM0L3BQSm5HZU9JZlIyNjdKUmIvbmlpMzJWRS8ycnlmcEpF?=
 =?utf-8?B?ZEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Y/A28d1/wRrgceBiNnrQiM1C/9A4w/almfcdMJuCqDJ1luYyray1ueMfdbKHobrua7LWX5IRicPX0sPlkg8+zozx5atws1TDkpGJZY+Z7Sz5o4WUWQohhjB9sf5xJgdcWXZVgVoRI7aBzyd5paqwq+1cxnxX5h5E72Vo02ZCOsUq8pFlBmphM9ObOhIuJ0FZCuuO54WJZsmPsQSi3HZCYBFg4ShdqwSzgjMSQpZ7by9lFfmrHr+LmLTZK4U/H5/OItxf5UpUcF1AV1OhJt6W0si3l6l/TCVGwdVixmP8/kQ3+wqNyHsAOuEyniWcbXas27jaBWAt8ARpYlkKni8GomOvl1Zo/rpc3Q8zSOkrBr/3btdDbaGx1BY9eV0+wQFizIPKglLKCJLRoOQRefPbchIkL1alOBXiXRNuSTXeD3yonRIAKQM/0Mrr4+LPSkEhxEonN1KI2G70VX7i0qIcG7n/F6mO2cxZdVTnFhM9uvGjUdd/KeIVC9QPk7653iHUQ+9z/sxWbFhj/GJoWNf+oc8sF/EhJQzfDe8awAYGRlU9m2u8MwjKtF7D5PGPU/eoIvsBfF19ITQS6mmbzlHg0n3sc+S42Vrv8yIy3f54i+U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e36e5652-9793-4658-c751-08dda9b5bf08
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 13:33:41.6974 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BZKWmMVQ01wzi46BbIZp/sOTtWF926MmQYUCL9fxRb0lEPSCOwW3ooanP7PGVc29zmylE9Sf9PkWyS3TSYcRoHZTMTyjV2jdul/OJkGKLZM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5204
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_08,2025-06-12_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506120104
X-Authority-Analysis: v=2.4 cv=fdaty1QF c=1 sm=1 tr=0 ts=684ad739 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VnNF1IyMAAAA:8 a=yPCof4ZbAAAA:8
 a=1epykj1Zfi4VafzJIxYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: jC0gaY5IvkfndEBvrnKSTiEgEC1cBvdc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDEwNCBTYWx0ZWRfXzH2NpBQ8p43V
 02mWEWEPhoGG2086+CjNqH8Ub8oZ2d19WkBRaDclV1WV5ABC2SxTAvqgIECQXdeU5EeOxt701oc
 o63y6jrVm5G9516I8lZ1CfMfzNJiFjH5QkjOPuRVA7V3OMi/8up6wVU6In6B0KqCJnthxlHwmLI
 V0t0ZzI/ZXZT+Xr5OYOyINEsAOOZfOe7uE8AEUyvqqFwyD6h79nunVA80HOLPJLmODSvGQdf58h
 FdLkYbdjWHhf7G4bhx+09wUopMHUNjp9KmkvclICr+xGIUXXBoo5Ds7eUEfGaXnz8JBIQDUUeth
 lWI3MLYge3MAmikUDFf6JVsygZIlvYc56Wd4kmWbo4+PgwNmUof0u2P2g9EwHeMuJUWxTkESqAo
 JcEJ0aHkYtcAgDapgvH2ChlNxJF+fSh9kQJUpawCP86sN42ymnmh9trcmhQl4z0a+iAbmco6
X-Proofpoint-GUID: jC0gaY5IvkfndEBvrnKSTiEgEC1cBvdc
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 6/11/2025 4:56 PM, Jaehoon Kim wrote:
> When the source VM attempts to connect to the destination VM's Unix
> domain socket (cpr.sock) during a cpr-transfer test, race conditions can
> occur if the socket file isn't ready. This can lead to connection
> failures when running tests.
> 
> This patch creates and listens on the socket in advance, and passes the
> pre-listened FD directly. This avoids timing issues and improves the
> reliability of CPR tests.
> 
> Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
> Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
> ---
>   tests/qtest/migration/cpr-tests.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
> index 5536e14610..f7bd5c4666 100644
> --- a/tests/qtest/migration/cpr-tests.c
> +++ b/tests/qtest/migration/cpr-tests.c
> @@ -60,13 +60,12 @@ static void test_mode_transfer_common(bool incoming_defer)
>       g_autofree char *cpr_path = g_strdup_printf("%s/cpr.sock", tmpfs);
>       g_autofree char *mig_path = g_strdup_printf("%s/migsocket", tmpfs);
>       g_autofree char *uri = g_strdup_printf("unix:%s", mig_path);
> +    g_autofree char *opts_target;

This must be initialized. Otherwise, if the function returns before opts_target
is assigned, then a garbage pointer can be freed.

     g_autofree char *opts_target = NULL;

Sorry I did not catch that before.

>       const char *opts = "-machine aux-ram-share=on -nodefaults";
>       g_autofree const char *cpr_channel = g_strdup_printf(
>           "cpr,addr.transport=socket,addr.type=unix,addr.path=%s",
>           cpr_path);
> -    g_autofree char *opts_target = g_strdup_printf("-incoming %s %s",
> -                                                   cpr_channel, opts);
>   
>       g_autofree char *connect_channels = g_strdup_printf(
>           "[ { 'channel-type': 'main',"
> @@ -75,6 +74,17 @@ static void test_mode_transfer_common(bool incoming_defer)
>           "              'path': '%s' } } ]",
>           mig_path);
>   
> +    /*
> +     * Set up a UNIX domain socket for the CPR channel before
> +     * launching the destination VM, to avoid timing issues
> +     * during connection setup.
> +     */
> +    int cpr_sockfd = qtest_socket_server(cpr_path);
> +    g_assert(cpr_sockfd >= 0);
> +
> +    opts_target = g_strdup_printf("-incoming cpr,addr.transport=socket,"
> +                                  "addr.type=fd,addr.str=%d %s",
> +                                  cpr_sockfd, opts);

Or, declare and assign the final value together:

     g_autofree char *opts_target = g_strdup_printf(
         "-incoming cpr,addr.transport=socket,addr.type=fd,addr.str=%d %s",
         cpr_sockfd, opts);

With either change:
Reviewed-by: Steve Sistare <steven.sistare@oracle.com>

Thanks very much for fixing the cpr tests.

- Steve

>       MigrateCommon args = {
>           .start.opts_source = opts,
>           .start.opts_target = opts_target,


