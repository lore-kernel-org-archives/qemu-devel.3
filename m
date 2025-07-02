Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0EC4C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 17:55:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX1fg-0000df-9a; Wed, 02 Jul 2025 13:55:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uX1fe-0000UK-2z
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 13:54:58 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uX1fa-0006ls-WE
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 13:54:57 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562HMcqu009678;
 Wed, 2 Jul 2025 17:54:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=x9OoD4HBHWE9Vnh2p6JHpLJF1200JYzEdd7LNPiK26c=; b=
 dzz9M3KwHOjDIUCkHy0gpaZ0p37aAr/6+75HDipmHKo4DJUKjRWFNCJMdN+Bp7fF
 5NVDtAxZQ6EtaU/XnsIDXoghIyPbEw1/h1c8uWf+R+guryuadLHo6NqzM4i9Pk0q
 PIMSNjMhzTu5fqyvJHAvba/7pQb8Me7e36MiPjPIzOe6CU8tSU9mf+eAZZY2Svjp
 qkQ09BmBak4ZBw8f7IKKKtze7xKOACzdNUYYJbaBxjeTUywOq47u6e65NruJCbi6
 KnmGwHtZazuzk/bYDD4/HntCO0owwHL9GfbbJDmqA3wNhTva5FUKG5LYeGNvK1nK
 +pXd1U6jkgMR9HdHTXFXFw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j704fhs4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 17:54:50 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 562HpnSC033705; Wed, 2 Jul 2025 17:54:49 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47j6ubj2d7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 17:54:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OmZRGrFkBHPIAuskiFEGD85OkQaOAO0UNRkP7gZP1euLq1DAY1Laeijr7Sp9NQgGjTJgYyNt68PoUtKx0s3Pa1NsmAMZz2rfxFUTUEZYIBUJnuMUwkMW6WTYoSaJS/Lg2HPENls8ARfG0i5G0VAin+3wPMAxUNVxxwoyvR6Jg0rzYIo9xAD7TGiKV5H0w5Gp22cgeGLFRR6j1kvpZM1DZZpn/clRoRcia4aB9pndP72xe9ArZZrUC9MaXquKJIFXX8h2rPujz8cyoZ2EwkzR8+0eGIHCosY0N88diMIcrFkUMYItcOYDXv5VKbZcfEtAiGpSUf8P7aF0k4ujKLFlgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9OoD4HBHWE9Vnh2p6JHpLJF1200JYzEdd7LNPiK26c=;
 b=MSanueoSGumEbxAi+t49CGDzfBTg36VJ0BKVXQuxerFk9jF4deuxvPV40PnUotHAOYSvUWb2y19m4+y4cKgTeCRtegqKnqfb9WGVVPXL5MFns383nUees4ngto0E1tio94lFs6kNLKLAIEqh+sowerlo4Yv3FsFEVNcqLIUFBh1rqYIPKeBRZ9rJ1luDWtRVllcNLOs3jzOTd4L+qwzI212Y9ZEQ1/uJDFklhOLH1aKrr4a+ib9IRrvqHPWT5fCrpLCvRjWNDjuk4HbjTYq0u0Oqos9IiPKpq6F42ft0RV52yNbDTCGX8p64Avf37RdBkw1mP0rRx8k6pouD8eWvSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9OoD4HBHWE9Vnh2p6JHpLJF1200JYzEdd7LNPiK26c=;
 b=rYhECbcAbCJyrC+NEOs18qPfknNQiJxvO6um+DzeNe0tq0P3VgM1NBES1TbYNFOF5PCcyWyknurwGN0b1z71bFjVEAHBiVm/DtrzHfHrCqP3/KjxIMUGti3I7dDt3W5/02hTax8pMZmY16R/8pslF/KGQtbDRfzE840GhBjUhWI=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by MN2PR10MB4221.namprd10.prod.outlook.com (2603:10b6:208:1d7::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 17:54:47 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 17:54:46 +0000
Message-ID: <9346143c-ffd8-4444-9eb3-db35a0a586b6@oracle.com>
Date: Wed, 2 Jul 2025 13:54:41 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 19/38] vfio-pci: preserve INTx
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
 <1749569991-25171-20-git-send-email-steven.sistare@oracle.com>
 <892830a0-eb38-43ce-9d34-8ab6c77605f4@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <892830a0-eb38-43ce-9d34-8ab6c77605f4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH5P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:34a::13) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|MN2PR10MB4221:EE_
X-MS-Office365-Filtering-Correlation-Id: f1cdbee8-010e-40a9-3d0b-08ddb991884f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K05hWWJMaHFNMUJWc05xL2JPR3ZUV1VCdVVnVC9uOUFyVncyZU9lc1JtNDVM?=
 =?utf-8?B?SDRnT3pYSTA1N3NoWlpRVCtYU21mek9pZ1JNVlNYR2ptZG93SmJMdUJyTHV0?=
 =?utf-8?B?RUNzU2ZBeUVybXpxSFFmUE9PLytUNUdCRXRzZGhtNDVZZTgrVC9KdC95a05B?=
 =?utf-8?B?M0J3a2x1b2t3Znc4ZWNrSTE2S2tMZVlYeUNsVUEzSFNHVVBCTEs3czV3eGU5?=
 =?utf-8?B?VmF0Qk5jT0s2b0VHYTR5bG5kUEZZY0hwL1NBTllSZW43eFlEWEFDbmVpOHBq?=
 =?utf-8?B?QUZXSTh4TVo1ZTltNE5lVUUxNWdxRXNlRWFVdE9ZU3ZHOFpiNGR0RkFuV09z?=
 =?utf-8?B?TzVleElJZDlTN1o5ZXNuRFNVVU1pa3ArazYyYm5ickI3WEJraGYvaGRGNVE1?=
 =?utf-8?B?Z2Rzc0d3N21ab2FnZ3FaOUN4M29nTkMyS1pQalJBaFRDdVJzVGtnNjF1Mi8x?=
 =?utf-8?B?MnlaTW1lY0hTVEtZdmhUOGRkUFBCZmd4ZVRWanBMR0s4MVZhTnVXSUJyRDdP?=
 =?utf-8?B?WXBCcGdraVgwNU9YelUwMGZjKzdZRGg1ZmE1ZjJMTTRNNzNHck9PNGprMEJ2?=
 =?utf-8?B?c1ZTbm95VGtCZVNxNGdQTyt4MzA1Q08vemZBaTRRREducFdNcFU0SE5KYTNn?=
 =?utf-8?B?N1lQTkFtSFNXT2REb2tFSzlKTU42NWcxVWw4Vmk0RTZhTmdYYkFOM0xZZWVh?=
 =?utf-8?B?UTE4OTJHeXFERmFROW5KTnBGQ3Nla2hWREtpaDJYUVZqZzF2ZE9vaHZqSzZl?=
 =?utf-8?B?VGhRRVhkUVQwUTBhVVRPODFEa24wbkFEWldYYjE5c3JTclFFb0pYdDJNV2VM?=
 =?utf-8?B?TEFxdEdnUllCQjNoZHM0MHpOaGFHZ29rMjBRSE1TZndSUkIwMUl1M0NuRFlL?=
 =?utf-8?B?TkRpeXlTa1pKOFlOKzUvSVpKZVhPZ0VLb0o4a3pJUHE2LzlnN0lqY0lPVVRx?=
 =?utf-8?B?Y21tWFIyTXJtSzJuZnRQc05scUxGU1NZS0VFZE5VMjJNQThaNGZ3ZEsveWZv?=
 =?utf-8?B?a2VnOTJMalYwZTU3dzNuNkkyZDlNK0o0Ry9vNGVneHYyTUdxYXdmNllONGlC?=
 =?utf-8?B?TTI4T2d4ZnFnc1BqelR4VDFZaGNnMThPaDlGRExnWk16c08zQUV4cWpkcGs0?=
 =?utf-8?B?Qm9YR2xqakFvN0U3T0NXWlJEeHdhR1QzeE9QL1JzVWdOeHBaZ0hVY0RBc2Ji?=
 =?utf-8?B?TTdRUDFBVlBwTTdERjY0NFBGMlJyK0dsWms2Yjl3STloRU1ybXNJbnF4VU9q?=
 =?utf-8?B?UEVEZlExaWZVaXZyU1NsbU9FUVAxSFExTXpxS1BTbmVYY3F2K0FPSnZ0ckhX?=
 =?utf-8?B?VnBJUUJRdEpHR2FUd3JCcUVQYWNsSHc2dlpFQ1JBa0g3UXhyWk45YklxQ0tk?=
 =?utf-8?B?ak5PZWJQMms4SFQ4RFhiR3BueGJzSllKRFNOTHZZaVBCTFhOTG41VUx5UUl6?=
 =?utf-8?B?Z0VzSk1mSE93N1hNdHFrTFFXaWdGZkRMNGY1bGFRdGFGWEM1aXQ3c2pRZWpF?=
 =?utf-8?B?RWNZMHFvUGdjMG42U2ZidEd5a3dQUU10MTA4VG9LN0pnZDA1R2pFWm4wdWVJ?=
 =?utf-8?B?RmFJbnZJbjdJR09naVBzYlA5bVBmME9xbDAwZ3RzTkdqZDJBNW82bkoyMjJa?=
 =?utf-8?B?YTdQM29vVXA2NUpaeDh0UERTTW1yNkpOemR1aFc2VEV5QlFrelVHTGNWMnZn?=
 =?utf-8?B?aUlvM0p4SWozV3VwaHoyek9vd2diVTVSQUJPcm5xRmlJWEZJMFVzV0xmT0Jq?=
 =?utf-8?B?VTczeW1BTS90UXYzb0tnbWU1dklzVDdNUGxnYld3dTErNmEvUkFpdFZYOHhB?=
 =?utf-8?B?MmRYc0xleE5uRHRvN0ppVWptK09QOTV2SzhIdVFPL01tdHI1cTVhWXdaY05o?=
 =?utf-8?B?bzVKRnZjOWZiRUFBR05qVStpTTN2MW1TVjFQeVQ2V1QvVC8zRHdydkY1Nm9j?=
 =?utf-8?Q?MzSexCYWRuI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VndIZUc3UzV3ZVlTU2NtZjY4YW1pZTNlZzFUc0lMZHpHVm1SVCtOWUphUUY5?=
 =?utf-8?B?RWRPSFJxTTVxdHVXdWVUQUV0N3FJdGxoZUxqYTRjbTVBcnlaZXBBd0w5SGU0?=
 =?utf-8?B?VFNrNEFKaUdYcnFXWUt2V0VOS3VyMEFjVmVhQjRqVWNKTUJoNFg2bzBJRmxP?=
 =?utf-8?B?M0owcUh4bUJHNkJNQm4yZWtYSFlzRTdhRk9Tb0ZuVmpXc0hKRDVTT2duV1Az?=
 =?utf-8?B?Snl4RmVIVTQrNkU1bUhRZmFsc0luUTFmbmRwdU9DbitlK0RJeWI5dVA5eHlY?=
 =?utf-8?B?cG03ci9xNmhtWktZUlVlT3BhR1MxTlFqamdIVk5EVGkyaWFHN2Raak4wNVNy?=
 =?utf-8?B?cUxLUlVBb1BqTm40RmJvUUgySDJUVkdtektiVXoxQUU2OTFicEJiRnF2OVhH?=
 =?utf-8?B?c0I3MS9SWngvT1lIOHFMRGNUT2h4ekwvL0Z0d3RFT3Z3bWxmOGRiL2hDQjh4?=
 =?utf-8?B?b0JFN3pFU1dHelJrZWhEMGpNb05TM2F4Slh1THFPZ2VtNit3WDEzM1lKM1l1?=
 =?utf-8?B?UHgzMTQzRFVSREVFQ2lFbXd6SS90SlNTaEdudm5WV0ZyY3NTa3ArNnBrWEdS?=
 =?utf-8?B?TkI0NGRwT3FvS1IvMUF0NGI3eFo1L01HY0h4K0NIT21nQTR3ZHNOTkIrbm5J?=
 =?utf-8?B?RXRPaGJsdWlyQ1Blc0NqNXpmVjZzZXRTWXB1d3NqUDQzVlhXcUNuTThiZ0NH?=
 =?utf-8?B?UithamdCR2VmeDZZOGZ0aUl5eTlRZEJEV1RIK2UrOFpHUFhwRzdRR3g3RS9C?=
 =?utf-8?B?WWFEY3g5OEs5QWQvUHdSbTBxS1dwaCtIWUlBOThBb1BSOVduRUl2dm4zcEZl?=
 =?utf-8?B?ZEswV1FCNTEydDZHMnJtblN1enFIUVlBSlRiSTRudVNsanl6KzZqdzYwczlh?=
 =?utf-8?B?TnZaeVVHNWZvVzE3QkZGL253akljZXJFYno5YitEcGFVT1NmbElrUEQwdEY0?=
 =?utf-8?B?clpwcXJzU1NxcnUyTWsvR2UzTmc1N3ZJTkZzcllEWnJzbldHb2lhUko4Sm1S?=
 =?utf-8?B?VkY5QjcycHVDTHo4NndVOGx5NmpqN3E2ak1NVWNEaDd5bzU3MHlDZUpIS3Rt?=
 =?utf-8?B?RHF6UkUzb3BVZGRIUXE3cmJKMng1S2VOZkFtTThCcHdBdHNrU0JzVkMxanFL?=
 =?utf-8?B?L1J1dDM2RlM3anh5ZnZpNkhCaXdjTE5vZ0ticUUzUFpvUFBwYmJxb0RsMWUx?=
 =?utf-8?B?N3pPVlpDdDd3ZTlGTHMxNmxBeXp5eGJ3ekRpZnRVZktqd1Jaay9ic0xaWGJ3?=
 =?utf-8?B?TnBodnpMVm12ZGoyYjZIUFZoYktuSVZJMjVlSVhKQThiQXRrYTNoUkZ4Ti81?=
 =?utf-8?B?ZzBWK09XbGZMQklXaGxGREdjVWtTc0lxbDlaSDhWRlFBRjg3MExNN1dTcnUv?=
 =?utf-8?B?R1ZNVUg0WGlKSkpNSkNxNC8vajdJOWlhekJEdjkzNHZNbllEYzFCTitBY1pP?=
 =?utf-8?B?ZDk0Nmg2NlQzcURiM2p2UG1qZmdOM2Z1SUVzZitUYTJWS1Vmait5Y0xwN3NL?=
 =?utf-8?B?QmhXNFpIU1EzYUROd3RuaHIxZithWGtoOEp5NXZQSTErbStPMG1QZG5UK1FB?=
 =?utf-8?B?VS9iajZTemFxL0xvVm8rdjdma3M0N20waTZVaDVjNGlSNTVyODVYQ2I3cjhN?=
 =?utf-8?B?RlZBakpIQS9tVTRHb0NBcGYwZ1FlaFB2bEZZRHpKeE12UDRsNWNTMnhRT3RD?=
 =?utf-8?B?Q1VyYTliRWlBN2RRTW8yQm80a3h1K3BXQmpMWEI3dUljaTEvSThpeVVzTng4?=
 =?utf-8?B?WEFvWG1HMk54SEhDUGh1aTR1bnVGbm4yazZVaTJzY2s5bXArZEpPU2FwaWMv?=
 =?utf-8?B?QVBXSU9ldllOMUZFaDFMcXVGYm9Ca0FxRDlJd0F4OEgwWHdqQjNoWmFEdm9u?=
 =?utf-8?B?YVN1alZpL21WU3AxdU1CanBlUjdaaTNkRmljMlFkVWtCQTV0MjVlbFZwTEl4?=
 =?utf-8?B?YjUvT0dBaXBOSmpBU2lKK0tJdW9HOGFscVU0K0FwL2ZVT3UvWkVVRGJkTlBZ?=
 =?utf-8?B?Tk4rd3E4dEJXOVEyc01KamVYOWo2cVlWSDBtNkFBWk0yTXkrN2t0eDlNUGQr?=
 =?utf-8?B?K3lxc0hSWHFLT0lNUUllS0wwd1d2ZkhXK0JkNy8xL1ZYT3J0Slg2YVBBMVI4?=
 =?utf-8?B?MnNnN0hVM1l0MjhsdFFlZ2FIdUVEVDY0QXNXTU1QOWYyVXpVek12dk5uVGJh?=
 =?utf-8?B?dXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QGBAYT83+x2505whI/jIVBjlyiBBfSnf14L7tfHWVYF8GqniINV4qyO+USJvfcW8gtiWEkqUIUZ3Sym1s37ToaEoHH4zIudDPSaQGsRhmfAGDMIqZwznkogIQI4QsIGKLbqmADnAt5WA5Urp3vobm6YuFkkNQ1IL4ho8WX4RPJT6xY8YvOh7dv5UO1pc+3nHVohlIMaHxuviOkWOSWve/AS1ZF/5OfHewqZUHttyRIu5zFnEn+g26hE5zuE5mRapqkdhGZRUtfvUK8A4ecVbWbvJAmCwU+aWON827qcJA3q5JtF8ZsLIPjY8Bjip3oxTa+FcTeGqKndcYylGnOZC3c/pdegRSu3tVThk3g3JPaMeOOAWdmNpJ8cbSzgrfQ0TauqNrhj9Xu87yjvbH4VDErpRepiXrFxZHnrCrTM4IoavPqlOweZjjpID6rkNXv46lQomrKyC0QGoY6BIr3QVUgFn5xm3YFPlfoYHpfOHT0ad4skTW1T3G9ZCFCrnpCCC531Yq1b2MrWyjLEoqsCM5QusPwQyX3UCF2E9uLnqYK4GPx9Jclg4a1AOwlDbCd3NNLRkTzjDdEEjiZSwVdiNiVH2Hhax9acbixYO264VNLo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1cdbee8-010e-40a9-3d0b-08ddb991884f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 17:54:46.6584 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D1zAdr84dqj9hDpGG1a9sObw2ih7igSODfMaJP7CM+XUbGJe3WLA610LWG/cqoH4NZQrvKUODrdYnMz2xV+JwXiPRQtIgpZV1udlxrKXshk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4221
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_02,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507020148
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDE0NyBTYWx0ZWRfX8b3bkYuFpvnc
 cSn0htBdvDtqmk+pW/mQuT5A2m1L89zF8+5n5n1fy4LsS75Z856xBnr/FIt5HNgN/gwbfcIamUD
 ffBQxk4uLM/9ssq08OavdrJkShld+xe3IKL1dF3TiwuHthRKUjxLvKq8X+7xF2qZQb2ouR9xTuG
 /byzVfpamwCBSW5i90eCb9jLBRqf2tD00j8IiJNJsCVXuK+vpLiPOcruxcRIKal0nMbKHxIzfpo
 akJaATPGp5kUH8fjjcblij/2oulnEEn+TvNUs4htQh0RTvw1DK9v2lK9CbNDVYtUKp8bltvTFxQ
 4VhqkurfFtMR1LnYUuQ+xgU5C815rswIvokbKHH8U/iVUSWgJ8G0R5a7m3j1S5fy4eiPf14yEYT
 XNDSYy4kyPFIbLnpiWZJRtA2Ox1V7veNOYxlftlM5u1JxKzaprtCwtNcctQss0Jf0PGPEm6T
X-Authority-Analysis: v=2.4 cv=LcU86ifi c=1 sm=1 tr=0 ts=6865726a cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=U_Aa3v4WQjBvHhVVDIYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 6yMn1VmIhCTTUaASywlW_3eNytsPKegj
X-Proofpoint-ORIG-GUID: 6yMn1VmIhCTTUaASywlW_3eNytsPKegj
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 7/2/2025 11:23 AM, Cédric Le Goater wrote:
> On 6/10/25 17:39, Steve Sistare wrote:
>> Preserve vfio INTx state across cpr-transfer.  Preserve VFIOINTx fields as
>> follows:
>>    pin : Recover this from the vfio config in kernel space
>>    interrupt : Preserve its eventfd descriptor across exec.
>>    unmask : Ditto
>>    route.irq : This could perhaps be recovered in vfio_pci_post_load by
>>      calling pci_device_route_intx_to_irq(pin), whose implementation reads
>>      config space for a bridge device such as ich9.  However, there is no
>>      guarantee that the bridge vmstate is read before vfio vmstate.  Rather
>>      than fiddling with MigrationPriority for vmstate handlers, explicitly
>>      save route.irq in vfio vmstate.
>>    pending : save in vfio vmstate.
>>    mmap_timeout, mmap_timer : Re-initialize
>>    bool kvm_accel : Re-initialize
>>
>> In vfio_realize, defer calling vfio_intx_enable until the vmstate
>> is available, in vfio_pci_post_load.  Modify vfio_intx_enable and
>> vfio_intx_kvm_enable to skip vfio initialization, but still perform
>> kvm initialization.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   hw/vfio/cpr.c | 27 ++++++++++++++++++++++++++-
>>   hw/vfio/pci.c | 32 ++++++++++++++++++++++++++++----
>>   2 files changed, 54 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
>> index e467373..f5555ca 100644
>> --- a/hw/vfio/cpr.c
>> +++ b/hw/vfio/cpr.c
>> @@ -139,7 +139,11 @@ static int vfio_cpr_pci_post_load(void *opaque, int version_id)
>>           vfio_cpr_claim_vectors(vdev, nr_vectors, false);
>>       } else if (vfio_pci_read_config(pdev, PCI_INTERRUPT_PIN, 1)) {
>> -        g_assert_not_reached();      /* completed in a subsequent patch */
>> +        Error *local_err = NULL;
>> +        if (!vfio_pci_intx_enable(vdev, &local_err)) {
>> +            error_report_err(local_err);
>> +            return -1;
>> +        }
>>       }
>>       return 0;
>> @@ -152,6 +156,26 @@ static bool pci_msix_present(void *opaque, int version_id)
>>       return msix_present(pdev);
>>   }
>> +static const VMStateDescription vfio_intx_vmstate = {
>> +    .name = "vfio-cpr-intx",
>> +    .version_id = 0,
>> +    .minimum_version_id = 0,
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_BOOL(pending, VFIOINTx),
>> +        VMSTATE_UINT32(route.mode, VFIOINTx),
>> +        VMSTATE_INT32(route.irq, VFIOINTx),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>> +#define VMSTATE_VFIO_INTX(_field, _state) {                         \
>> +    .name       = (stringify(_field)),                              \
>> +    .size       = sizeof(VFIOINTx),                                 \
>> +    .vmsd       = &vfio_intx_vmstate,                               \
>> +    .flags      = VMS_STRUCT,                                       \
>> +    .offset     = vmstate_offset_value(_state, _field, VFIOINTx),   \
>> +}
>> +
>>   const VMStateDescription vfio_cpr_pci_vmstate = {
>>       .name = "vfio-cpr-pci",
>>       .version_id = 0,
>> @@ -162,6 +186,7 @@ const VMStateDescription vfio_cpr_pci_vmstate = {
>>       .fields = (VMStateField[]) {
>>           VMSTATE_PCI_DEVICE(pdev, VFIOPCIDevice),
>>           VMSTATE_MSIX_TEST(pdev, VFIOPCIDevice, pci_msix_present),
>> +        VMSTATE_VFIO_INTX(intx, VFIOPCIDevice),
>>           VMSTATE_END_OF_LIST()
>>       }
>>   };
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index b3dbb84..b52c488 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -161,12 +161,17 @@ static bool vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
>>           return true;
>>       }
>> +    if (cpr_is_incoming()) {
>> +        goto skip_state;
>> +    }
>> +
>>       /* Get to a known interrupt state */
>>       qemu_set_fd_handler(irq_fd, NULL, NULL, vdev);
>>       vfio_device_irq_mask(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
>>       vdev->intx.pending = false;
>>       pci_irq_deassert(&vdev->pdev);
>> +skip_state:
>>       /* Get an eventfd for resample/unmask */
>>       if (!vfio_notifier_init(vdev, &vdev->intx.unmask, "intx-unmask", 0, errp)) {
>>           goto fail;
>> @@ -180,6 +185,10 @@ static bool vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
>>           goto fail_irqfd;
>>       }
>> +    if (cpr_is_incoming()) {
>> +        goto skip_irq;
>> +    }
>> +
>>       if (!vfio_device_irq_set_signaling(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX, 0,
>>                                          VFIO_IRQ_SET_ACTION_UNMASK,
>>                                          event_notifier_get_fd(&vdev->intx.unmask),
>> @@ -190,6 +199,7 @@ static bool vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
>>       /* Let'em rip */
>>       vfio_device_irq_unmask(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
>> +skip_irq:
>>       vdev->intx.kvm_accel = true;
> 
> Looking closer at the code, I think it would clearer to introduce a
> vfio_cpr_intx_enable_kvm() routine and duplicate some of the code
> of vfio_intx_enable_kvm().

OK:

static bool vfio_cpr_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
{
#ifdef CONFIG_KVM
     if (vdev->no_kvm_intx || !kvm_irqfds_enabled() ||
         vdev->intx.route.mode != PCI_INTX_ENABLED ||
         !kvm_resamplefds_enabled()) {
         return true;
     }

     if (!vfio_notifier_init(vdev, &vdev->intx.unmask, "intx-unmask", 0, errp)) {
         return false;
     }

     if (kvm_irqchip_add_irqfd_notifier_gsi(kvm_state,
                                            &vdev->intx.interrupt,
                                            &vdev->intx.unmask,
                                            vdev->intx.route.irq)) {
         error_setg_errno(errp, errno, "failed to setup resample irqfd");
         vfio_notifier_cleanup(vdev, &vdev->intx.unmask, "intx-unmask", 0);
         return false;
     }

     vdev->intx.kvm_accel = true;
     trace_vfio_intx_enable_kvm(vdev->vbasedev.name);
     return true;
#else
     return true;
#endif
}

And the new code at the vfio_intx_enable call site becomes:

     if (cpr_is_incoming()) {
         if (!vfio_cpr_intx_enable_kvm(vdev, &err)) {
             warn_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
         }
         goto skip_signaling;
     }

     vfio_device_irq_set_signaling ...
     vfio_intx_enable_kvm ...

skip_signaling:

- Steve

>>       trace_vfio_intx_enable_kvm(vdev->vbasedev.name);
>> @@ -305,7 +315,13 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
>>           return true;
>>       }
>> -    vfio_disable_interrupts(vdev);
>> +    /*
>> +     * Do not alter interrupt state during vfio_realize and cpr load.
>> +     * The incoming state is cleared thereafter.
>> +     */
>> +    if (!cpr_is_incoming()) {
>> +        vfio_disable_interrupts(vdev);
>> +    }
>>       vdev->intx.pin = pin - 1; /* Pin A (1) -> irq[0] */
>>       pci_config_set_interrupt_pin(vdev->pdev.config, pin);
>> @@ -328,8 +344,10 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
>>       fd = event_notifier_get_fd(&vdev->intx.interrupt);
>>       qemu_set_fd_handler(fd, vfio_intx_interrupt, NULL, vdev);
>> -    if (!vfio_device_irq_set_signaling(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX, 0,
>> -                                VFIO_IRQ_SET_ACTION_TRIGGER, fd, errp)) {
>> +    if (!cpr_is_incoming() &&
>> +        !vfio_device_irq_set_signaling(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX,
>> +                                       0, VFIO_IRQ_SET_ACTION_TRIGGER, fd,
>> +                                       errp)) {
>>           qemu_set_fd_handler(fd, NULL, NULL, vdev);
>>           vfio_notifier_cleanup(vdev, &vdev->intx.interrupt, "intx-interrupt", 0);
>>           return false;
>> @@ -3234,7 +3252,13 @@ static bool vfio_interrupt_setup(VFIOPCIDevice *vdev, Error **errp)
>>                                                vfio_intx_routing_notifier);
>>           vdev->irqchip_change_notifier.notify = vfio_irqchip_change;
>>           kvm_irqchip_add_change_notifier(&vdev->irqchip_change_notifier);
>> -        if (!vfio_intx_enable(vdev, errp)) {
>> +
>> +        /*
>> +         * During CPR, do not call vfio_intx_enable at this time.  Instead,
>> +         * call it from vfio_pci_post_load after the intx routing data has
>> +         * been loaded from vmstate.
>> +         */
>> +        if (!cpr_is_incoming() && !vfio_intx_enable(vdev, errp)) {
>>               timer_free(vdev->intx.mmap_timer);
>>               pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
>>               kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);
> 
> The changes in vfio_intx_enable() seem ok.
> 
> Thanks,
> 
> C.
> 
> 


