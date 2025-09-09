Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2967CAC583
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 14:37:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvzSi-000427-98; Tue, 09 Sep 2025 10:36:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uvzSd-00040S-UT
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 10:36:44 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uvzSX-0003Hj-11
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 10:36:43 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589CPfrX012293;
 Tue, 9 Sep 2025 14:36:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=yVKBos/NT3RajWrLlDcE7GXM1swAN4ziKVZBYVUiRZY=; b=
 CVGm+gS4uG6ITAuZtUU9K4l42sgkfZez64vvqFBpvZieYGcqtTdgS3eEWsvrobEW
 uVhSQoAL1w4tziFhyT/MqYF/wBY4RzY8yOdkr/24BK39khnUfWBcIgsZm2/dq7Ds
 zqetEGB4beI1/ZBqWVSAHSgU7cCozPaHUZ+35C3DWKXmuhLu2SNKNeabQae3egK1
 v5/J2ZEemPzdh86Pv+R2QLQClEqdT5sO0GoZ6j8yLppY0Fhl0fJp2WEZn7nCHDi6
 ONFM+bPHXx58AXw7eMtG9X278TlfVo63uGhGIXoDPZn//hn1FB/Y4NX0MfIUiSGw
 MLkn+CtPDQBybekZ0oqjvw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922shsyke-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Sep 2025 14:36:25 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 589EFqdc012806; Tue, 9 Sep 2025 14:36:24 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 490bd9wxb6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Sep 2025 14:36:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jt6WTuUN9yLuYhbqrzw58KNsk/kaXdzeHFo5msygUswy0X0IHEUvPtQV1J1yd2wpuvCSjiIuIn6L9UXH8ZYMn7E8qFhlhl7zzNgiSgzCupLG2MLPdgAk6QipsxMybkGaaegZhxjYS1lewOTuvNDvf9UPo7EF5O9K2932Eas8Jf1/+jZu77b193OxWQk5jElc0gXK67QaLxICNJ/60tNbEXQO0GZzxteUJ+kJUKQ9ZdTtsOp6bsBj8evrR0UdnORM1HFP4k23+BIvReTspfFOIFnjU8z7BtSLmyLcdnpHxgQisKBbxAxt4dQcS08V4G0qagvc866dQOemWWZFsMPw8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yVKBos/NT3RajWrLlDcE7GXM1swAN4ziKVZBYVUiRZY=;
 b=NuS9AK9CB+VWQYRgatUZiqS5l+js18rAfOl73AkNfp4jfjz4Ks+HmHZh/AVdw7a1JfcoSvRzB0PYynbdMv4qJwaUgMgAL52/5v3bxf+xswvGoaj14OVi/asLncTUM6BimJQjj53xH9HjLKXJXJ7jjj97fW/Le3mA0ktm1DbW5frOTDN8z3ZZlGrZ5Hg7+HmQn3sdQQ0//2n2yc99iNGlN+BuyKq3ANV8tWjlAL68HmE8NbINXlHFEVPGFGrV0RQVNxAnbhrXKek9Lb1uuLE6zVnn6H82ga7uoiZtVsUGQTCFIQtt4WrkA/McwZ7aRh8ac4U5SL75XuOqw+CHXOpajw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVKBos/NT3RajWrLlDcE7GXM1swAN4ziKVZBYVUiRZY=;
 b=CvqDtpt+LtMuEFmF150vB0i26q8J5zfy6FcC193jE3wDlG1RuwsmHJL3L1jjH96gfK06uGwPAumRp5a2tEjFZtNSS82BIuGKinupwCtDuKXbHymOsTRJf7IFQ51ezOHn3Wp4fBCt/1goodoNLkyW+gw/Z4/nGOOg7rKnVyV0/R8=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by IA1PR10MB5900.namprd10.prod.outlook.com (2603:10b6:208:3d4::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 14:36:20 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 14:36:20 +0000
Message-ID: <fd56205a-11c1-4297-898d-603f1836bdad@oracle.com>
Date: Tue, 9 Sep 2025 10:36:16 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 0/9] Live update: cpr-exec
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <1755191843-283480-1-git-send-email-steven.sistare@oracle.com>
 <aLsUQWjW8gyZjySs@x1.local>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <aLsUQWjW8gyZjySs@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH5P222CA0012.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:34b::8) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|IA1PR10MB5900:EE_
X-MS-Office365-Filtering-Correlation-Id: e0ee2271-0848-4c7e-1f76-08ddefae3e3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S2NyRlB6UTVEckNHNWZkZUw2SGw2U09XMnhJZ2haRW9xNU1icFladmhlQVYw?=
 =?utf-8?B?cmk3cU01cXBFQlRYUCt6MEhmTDlETHVVejZ0MmxEaWgrRUNDankwTUdyeXJ0?=
 =?utf-8?B?WG1wT3doODhiVXgraUNZYmM1L1grSzRFa1paaDZsdU9jcHRVejcrc1djdVll?=
 =?utf-8?B?QkNsZGtuRnZQd1krOUhyV2ttd3BFcm1EVmc1eHd0bm5OSU5WZjNBLzN5RVgz?=
 =?utf-8?B?R0ZEYzFNSVFTYzdkK2oybUZpVnJ3dHorZFhjbk9NQy9YMGh5RU95VlhXNGpw?=
 =?utf-8?B?Qmc0amRlRUtYMURWM3BHd1gzU2thOEJDbGN1Y1psTHFVdVI1R1lyRGVVSzln?=
 =?utf-8?B?SktjQVlmSzNPdnZhWnFSZHByWTJnWGlCOFpTRnlNQ0tmWTZ6dHlNd1V0aWsy?=
 =?utf-8?B?OTZ3M2MxT0JUR1Yvbkw4eXgvZWxCSFRzRXhXdDM3NG1aM1hORVJJaUpTRSs4?=
 =?utf-8?B?KzJYRlZkU2VrN2NERVVDWmdqUzdVQlV6S0pZaDFQWTJwcGtPMkgzSVBLUnBR?=
 =?utf-8?B?Ri83RDNIc2VSdFk3OVNTcFFmcmFscjVldStweVM0NERoN1JiL2NKTVhxUm16?=
 =?utf-8?B?dDJqZ0orcWNLRGhiWnh6VTMzNHpCdzFQR2puSGUwRE4rT0tuNzhCcExHNVBZ?=
 =?utf-8?B?ZkxxTVp4UUxyVlYvbzVXY1VIRFlVbUZ3MmpkcTBYTFo4Y2djZlZoUlhSSHhC?=
 =?utf-8?B?MHhCWlhNQVEyMnNzNFZpWFhpWFluZ25uMzRoS0JwRExzYzh0d0FBRi85RVhX?=
 =?utf-8?B?Mk1GaGlHNHpuRXBPclYzVjIyemhIRmNPZm9LYS9WbnV6NEhDbnBKZmtWUFNI?=
 =?utf-8?B?L3NxR1FyaWwrbWRSVTFoSTJsbjc2aTJTOHNrYU15Yk5taGdRVG9kQ25ma0hG?=
 =?utf-8?B?eDVmblBLNnFxb1VQRFZNT2UrbUtKam91dGx4VUUvV2k2d3BhR1RGTkN2ajQ2?=
 =?utf-8?B?d0I1YXRhVjc0dzdTVlR4RXl6Q3JuTlNTMGtvK2dzeWlKT2dPYjk4L1FmRG1t?=
 =?utf-8?B?RDNGVEN4LzVFb1dHTTBHTjJZQjZOUGNaMzJZOTVJdFlYSjF6bmNvaVQwcWRh?=
 =?utf-8?B?ZDQyd21Oc2hwN0trUjFzYUgrMVdsb0tubEt2TWdURStGVzNIYlA5emVlL2JQ?=
 =?utf-8?B?dFB5SklZOXFOQThqTWNTSjdhVkZwTVQzSG80MGpWaUpIV3ByNG5BMWVyNGgx?=
 =?utf-8?B?Y0E5ZjZVNEljOEowLzh5R1d2UVAxQm8ycVhaTWh0aVNhQ2ltNDdrUmhxR2Nw?=
 =?utf-8?B?cElUNEFOeGlUaVhyVWtDSmdPMTYrOWF6NndMMEtMTS9qd2I1M3dPc29nKzhu?=
 =?utf-8?B?ckdsZXUxVE5Zb1JMVVB3a1BsTDE3TUtIV0xCYlZBY2s0MGtiOGNZeEJmcmVl?=
 =?utf-8?B?M2pGaXpSMTRPNXBWWEFtMnI3WE9tODlZcDB2N1g0WTVDb0RtU1NVUTJ6THQ2?=
 =?utf-8?B?THRHTEtjVWY4eHozOVF5ZW9pR3RyL285UHEvdWNoUWYrbUEyWmdoaWMyTmdY?=
 =?utf-8?B?K3dNSm95NXFXaVZFU0UwMGptWWpaQW52YUJ6bjhWMDhjMnpwMFVpV3hHb05V?=
 =?utf-8?B?REVDNWk4eEZYMytjbWNoc0RWZ1ltN2tKaU8wS2hYelg2OWRRdVB6cjV3SjVO?=
 =?utf-8?B?anhKVGlwNEt1aURpSU5wWXJVYllQWFV4ZHM2ME1RekZWa3hzY21SWndmMHVl?=
 =?utf-8?B?OTZvQmYyVFRwZExldjRRdWxLTHBkZXFxaVJsSGlFSGQ5clM0aTBJWjBibW5z?=
 =?utf-8?B?UklqeFNGUEgzdkRGUXlFd3g0YkxnQ0ZGMThkMFZVc3NVUWp2UEZvWmswL1Fj?=
 =?utf-8?B?bVYyV3pZaTN0SndJUXZ1My9LWFMyTUNnK3pjbWR1dHIveFZzenluTXc5SExS?=
 =?utf-8?B?aEcxeUxKZytNejg4bVU3WXJqR1RES20wd3dHdnpIaVUvSHN2MTlLK21IVEQ1?=
 =?utf-8?Q?ATL03gaZ0WM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3ZiVUt1Q0R3aGl2OXB5Tzh1UDd4UVU3UzgxakMzMTlKYytnZzJmS2JFVG80?=
 =?utf-8?B?SnBrQ1dsbjJsNGVFeGR1ZkY1dkJBeGhFU1dQdVQ2VXUwYm1YQlFnc09Nb0Z3?=
 =?utf-8?B?OXZ5NXkyc2dCQm5yZW80NTdPc0JCeElkNFp4ZHVqUnNDRWNTN2Nzakgvb0FH?=
 =?utf-8?B?cVdpSmlQUW1sd1lpY3IxM21POXNNUGNsL1VnRTZDdHF1TDR4eUpvaFdTMkVI?=
 =?utf-8?B?d2pvVjM3dnYwNE1aQ1pDc0VyRXY4NEdUb3pyc1JMNG4xb2dOU0pPbWVxMVpu?=
 =?utf-8?B?LzdQbXRTeCtLR1NTWk5kUGVzZ0l0aUh6RFJBQnNhQnJybDFQQzFnVHJlcldU?=
 =?utf-8?B?YTBHKzdObWs0ZjFLd3oyRFNvVzEyMVM3bGRQK1JOQ3AvZzVJa2R4RzRTV3Jm?=
 =?utf-8?B?Mk1XM0lueW9jOG01Y3h4T25DU1VQMVJEQkZpVkJWeFVtWnhYcUNGckZ3Z0Vp?=
 =?utf-8?B?eStYbW9aSGxjbzFjSW16cmo3Y2JaRE1VcTB6R3RVazA1cEQrTzU5ZXRzVE04?=
 =?utf-8?B?K0RZQnZVNWpaNll5a3A0dkMxUUtrdm4yb2RLVTExRTVXUzFMclo0M3Q3cm10?=
 =?utf-8?B?SkdHRkE3aWtrMDY4UXYrWmQ3MklRREZwYStTNVhCSWhtQS9tOFdUbXAwbjhp?=
 =?utf-8?B?bE5kMEQ0dVdhY3B6aFp2dlpHTHR2aDMyeVp3THkrOTU3SmF2UFdwV3QvYlFk?=
 =?utf-8?B?azVqK1BmOXh2YkgySGxwTHJvRkh5R2psbUo1em5xaGZ3R20vVWZ2aXdrTFhN?=
 =?utf-8?B?SUJzZlZjQ0p0cDY2eUxEV3UyWkcrQkFER0xNWlJPNjRHU1FWVkg0alZEam9E?=
 =?utf-8?B?Qm11UTRiVEtRWUZXY2hUT3QwTDlhemxZdy96YXpIazJRajMwMkxmRlFOVGUr?=
 =?utf-8?B?RVN5TXI4OXVTTUVEc0xoWHFEY0tUeVZUVk5BamVFclgwdVFiU0VBbTduZW5K?=
 =?utf-8?B?L0M0WEVXbDNsZDArZDhtRmNYYkoxWEUxN09oMjEvUWljSVdKM2Izdk9YV2t3?=
 =?utf-8?B?ZXhZcUQrcGx3VHpDY3RwQzZpVEs4eDk1SjVtMmdMdVJjZzdZL3VPRFZpSGRh?=
 =?utf-8?B?c01yY0IwTktyZzB4OGx5KzRNYkRiRDFrZ0J0Z3pZRFNiMUdSNmUwK2x5ZU9P?=
 =?utf-8?B?SHFuWjdTR1ptQzV3OVJObC8yUFc3WEpIM0J1YzNtMUtEZlp6VWxuMnlPNjVS?=
 =?utf-8?B?ODlucmhDaUdINmtmUW1BakZpSnhFWDJNUGRqSllhdVJNMGx4OG45cE1QTWFa?=
 =?utf-8?B?T2pvSlRqTE12SUp2bGVGZ2dqZGVIZEU4VGIvWXY2TFZTdGVQY1JnTVJZaUdR?=
 =?utf-8?B?YkR2Mi9JamY4WTRSM0pDMXNMN1pDZzY5MGQ1T0crdko4OG1SSW14d0IxTVZn?=
 =?utf-8?B?ZGZ5MjB3UEl3SEI1dWUyZmQ2clh4aUhZcFZMMG9ROEZhbkNpbWdHRkpMaUdR?=
 =?utf-8?B?bXljLzNObW0yYmJ2Zm9ZU3NTVnVyNTQ4UjdJWmpzelBabXJUanVYZU5MeGdE?=
 =?utf-8?B?eDhSWXBUVGFoSE9hV0M5YW8wVHhkKzVSQjJPWm9Cc01ZR2ZtcGkxVkN2QjBo?=
 =?utf-8?B?T0tBWXd5S01HWVhKL2tRdm9POHR6TzNrTHJRU3hpaHhWa1RId0RzaHIySGRl?=
 =?utf-8?B?cWNjVEp0MjAxS0N6YTYrdERiWFEyVzVOdjBkeENLMTgraTQrSjhwQzZCR3Nh?=
 =?utf-8?B?QWZLWkFVRVhsWkM4Sm9tcFU4UFQ3MXdqSEVlOUl5c0pVYzg4OUVpbEpxOVVw?=
 =?utf-8?B?VUQxRkZwZU9WVXNtWU5FWHBRQ1phYVdURnBzcm9YRVJ5N2xpWTVuUUdvWWt1?=
 =?utf-8?B?ZXZJUnpYMnI2ZjZ1dmhRank5SmVhNDd1M2RzRjFNL2daMVQvQTNzbi85bVVx?=
 =?utf-8?B?RnFMSWxybGNZYmlncnRPcFBBZ0lKMThoaC82ckVVUE9FcFkvSFZUcDdvakd2?=
 =?utf-8?B?enUwME53cmVVVnF0Zld5ZGU3ZkVXTWFyN3ZSYUpvS0ltNkpCaThLN3BMa2VF?=
 =?utf-8?B?dWJLWUYxNmJCdlJxRWJkSjB3WUlTaEIzQ2dqMnJJL3U5UEZGQnFRVDhpczVO?=
 =?utf-8?B?VndReW9rdkpOU1JtcFZPWm5NTDNZL2ZSNUxuYWFGRHpPRFpxZkV4K0dZN1ZT?=
 =?utf-8?B?ZUFMUXJrdGd2MU1kSGJ2TEtQbllTUjEzSEZOVldkdTU0MVdvT3RPMWE5NXdF?=
 =?utf-8?B?b2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RH9tksk7t06si0qOzHPYJQwh7VMhY9HW0f2Ofd5TGr3A1/piAN4aE9GNyo4Av5Hw4TbNOvjIcOKEpJNbvCEC2kCiRjY8XPSg0+UqdXZzuYt6VCBbxz/Iw584HaSrXN5KNjjc2o1R0Rn4K+q4929CrwjUqw+eu6Lli5Mn9i6ghjhIuZg4oK6bs/jsTQEMEdkKU8YyTXRncC6CNIImWMSIUIc6znaOYQDjNlzzaIilxh+1hJzQxTtR5lDWABPsRo8yQaK5fppP8LSKoe/CoHPUq6vbxkK8oY4ZD6rozLn78IwFa+fjQTkF9IlQ60Bbc5BGba8yKS/KvCjB/Aut3PPxu26Ge4He41QJyF1WNtP8n2CmqCDcVyx1L73DxvGVTKO6kKkwR10stY78mTHW0ZswDFck+YCPbL2MUT9s7ABAZFe8+4var4YBKuRs7l0pdmF/snJ/hmDkiPKRZzzUf5VfJE9X0p1kw/JuzBjnwXv21HLnFGtlIE50RC38p0YAZnPmxc7LOfKjjZ5eLzQauPK0gbJe84SUy+2+1w/9dPL1Y1ZbeK6pqYg5lCKPRwQANY5e/6KxFW7BLaPaQp7aEJ2tPd9JOKkubeNUXZWpK8E37hA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ee2271-0848-4c7e-1f76-08ddefae3e3b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 14:36:20.5963 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y0f7ibVrw1ad+D3lxtsNO68LhXlUdGgAGCo49xaLsBXPmG2U2Fh2Fqxm14ZdqvFX6N6eBjql7F6AVZl4gr5+PSYgq7p2ppsxZwA4jZVk9Fo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5900
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_02,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509090143
X-Authority-Analysis: v=2.4 cv=esTfzppX c=1 sm=1 tr=0 ts=68c03b69 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=wHnX8B4c9D6-dwkGJEIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2NSBTYWx0ZWRfX+Qg5mCYf302Q
 cPmoMGXr3smstMLqKy8c+V+Kc0Zjz+2wWYWMeHFzVTw9+Srw6Bq/ArQ5vUYQMk/424cd/N4qfx8
 lhy0J4os4vgSUEyK4gp/E23gZ3LNmC8KJgnckhn3YxiGNFmJd4o48cDUrlwAQMCh3G3GkDXIbRq
 EX960o7LXnEsIUmfhy/sYXkkz4HIN1wIPQkBm5mQK4Q0aC8GQI/UsFe0AXyDHL4ll70eFFt/7Cf
 d1kTt/owRnttaWD5ayX0Y90IjqemLgORtdqRbH6H5ZPhBjK3anxbaZyjD8MM6ac6+KM27YF+juV
 0UJ/78YJBxl5IeFYEGtSA2vKActDGHLVE5WIU/WBOphFW6Y9y894nKmj8BOOPk2Dh0IGCT5ttku
 3hIz8Vsr
X-Proofpoint-GUID: JQUhQlzzOLY1Fdce16brkGFBD-O5TfAl
X-Proofpoint-ORIG-GUID: JQUhQlzzOLY1Fdce16brkGFBD-O5TfAl
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 9/5/2025 12:48 PM, Peter Xu wrote:
> Add Vladimir and Dan.
> 
> On Thu, Aug 14, 2025 at 10:17:14AM -0700, Steve Sistare wrote:
>> This patch series adds the live migration cpr-exec mode.
>>
>> The new user-visible interfaces are:
>>    * cpr-exec (MigMode migration parameter)
>>    * cpr-exec-command (migration parameter)
>>
>> cpr-exec mode is similar in most respects to cpr-transfer mode, with the
>> primary difference being that old QEMU directly exec's new QEMU.  The user
>> specifies the command to exec new QEMU in the migration parameter
>> cpr-exec-command.
>>
>> Why?
>>
>> In a containerized QEMU environment, cpr-exec reuses an existing QEMU
>> container and its assigned resources.  By contrast, cpr-transfer mode
>> requires a new container to be created on the same host as the target of
>> the CPR operation.  Resources must be reserved for the new container, while
>> the old container still reserves resources until the operation completes.
>> Avoiding over commitment requires extra work in the management layer.
> 
> Can we spell out what are these resources?
> 
> CPR definitely relies on completely shared memory.  That's already not a
> concern.
> 
> CPR resolves resources that are bound to devices like VFIO by passing over
> FDs, these are not over commited either.
> 
> Is it accounting QEMU/KVM process overhead?  That would really be trivial,
> IMHO, but maybe something else?

Accounting is one issue, and it is not trivial.  Another is arranging exclusive
use of a set of CPUs, the same set for the old and new container, concurrently.
Another is avoiding namespace conflicts, the kind that make localhost migration
difficult.

>> This is one reason why a cloud provider may prefer cpr-exec.  A second reason
>> is that the container may include agents with their own connections to the
>> outside world, and such connections remain intact if the container is reused.
> 
> We discussed about this one.  Personally I still cannot understand why this
> is a concern if the agents can be trivially started as a new instance.  But
> I admit I may not know the whole picture.  To me, the above point is more
> persuasive, but I'll need to understand which part that is over-commited
> that can be a problem.

Agents can be restarted, but that would sever the connection to the outside
world.  With cpr-transfer or any local migration, you would need agents
outside of old and new containers that persist.

With cpr-exec, connections can be preserved without requiring the end user
to reconnect, and can be done trivially, by preserving chardevs.  With that
support in qemu, the management layer does nothing extra to preserve them.
chardev support is not part of this series but is part of my vision,
and makes exec mode even more compelling.

Management layers have a lot of code and complexity to manage live migration,
resources, and connections.  It requires modification to support cpr-transfer.
All that can be bypassed with exec mode.  Less complexity, less maintainance,
and  fewer points of failure.  I know this because I implemented exec mode in
OCI at Oracle, and we use it in production.
> After all, cloud hosts should preserve some extra memory anyway to make
> sure dynamic resources allocations all the time (e.g., when live migration
> starts, KVM pgtables can drastically increase if huge pages are enabled,
> for PAGE_SIZE trackings), I assumed the over-commit portion should be less
> that those.. and when it's also temporary (src QEMU will release all
> resources after live upgrade) then it looks manageable. >>
>> How?
>>
>> cpr-exec preserves descriptors across exec by clearing the CLOEXEC flag,
>> and by sending the unique name and value of each descriptor to new QEMU
>> via CPR state.
>>
>> CPR state cannot be sent over the normal migration channel, because devices
>> and backends are created prior to reading the channel, so this mode sends
>> CPR state over a second migration channel that is not visible to the user.
>> New QEMU reads the second channel prior to creating devices or backends.
>>
>> The exec itself is trivial.  After writing to the migration channels, the
>> migration code calls a new main-loop hook to perform the exec.
>>
>> Example:
>>
>> In this example, we simply restart the same version of QEMU, but in
>> a real scenario one would use a new QEMU binary path in cpr-exec-command.
>>
>>    # qemu-kvm -monitor stdio
>>    -object memory-backend-memfd,id=ram0,size=1G
>>    -machine memory-backend=ram0 -machine aux-ram-share=on ...
>>
>>    QEMU 10.1.50 monitor - type 'help' for more information
>>    (qemu) info status
>>    VM status: running
>>    (qemu) migrate_set_parameter mode cpr-exec
>>    (qemu) migrate_set_parameter cpr-exec-command qemu-kvm ... -incoming file:vm.state
>>    (qemu) migrate -d file:vm.state
>>    (qemu) QEMU 10.1.50 monitor - type 'help' for more information
>>    (qemu) info status
>>    VM status: running
>>
>> Steve Sistare (9):
>>    migration: multi-mode notifier
>>    migration: add cpr_walk_fd
>>    oslib: qemu_clear_cloexec
>>    vl: helper to request exec
>>    migration: cpr-exec-command parameter
>>    migration: cpr-exec save and load
>>    migration: cpr-exec mode
>>    migration: cpr-exec docs
>>    vfio: cpr-exec mode
> 
> The other thing is, as Vladimir is working on (looks like) a cleaner way of
> passing FDs fully relying on unix sockets, I want to understand better on
> the relationships of his work and the exec model.

His work is based on my work -- the ability to embed a file descriptor in a
migration stream with a VMSTATE_FD declaration -- so it is compatible.

The cpr-exec series preserves VMSTATE_FD across exec by remembering the fd
integer and embedding that in the data stream.  See the changes in vmstate-types.c
in [PATCH V3 7/9] migration: cpr-exec mode.

Thus cpr-exec will still preserve tap devices via Vladimir's code.
> I still personally think we should always stick with unix sockets, but I'm
> open to be convinced on above limitations.  If exec is better than
> cpr-transfer in any way, the hope is more people can and should adopt it.

Various people and companies have expressed interest in CPR and want to explore
cpr-exec.  Vladimir was one, he chose transfer instead, and that is fine, but
give people the option.  And Oracle continues to use cpr-exec mode.

There is no downside to supporting cpr-exec mode.  It is astonishing how much
code is shared by the cpr-transfer and cpr-exec modes.  Most of the code in
this series is factored into specific cpr-exec files and functions, code that
will never run for any other reason.  There are very few conditionals in common
code that do something different for exec mode.
> We also have no answer yet on how cpr-exec can resolve container world with
> seccomp forbidding exec.  I guess that's a no-go.  It's definitely a
> downside instead.  Better mention that in the cover letter.
The key is limiting the contents of the container, so exec only has a limited
and known safe set of things to target.  I'll add that to the cover letter.

- Steve


