Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C861FE77183
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 20:39:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLpxI-0006Xy-GW; Thu, 12 Dec 2024 15:38:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tLpxC-0006Wy-NB
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 15:38:34 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tLpx9-0006dr-HH
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 15:38:34 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCJftHj009130;
 Thu, 12 Dec 2024 20:38:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=Fneq20+uk3LuxBjCGpv+SkHXtTrmBaDBSRD0Zd77biA=; b=
 QbSyWILzp9a+0XNPgBEgZ4IuAbDzYUSaJbDWyRC4GmKQ9xPUEUq7dNkBs7wgIQxi
 QZefkFGB7hCG409ZDzOngYZvYp+3pWRI7LABkIGSMotnxkOhp4QCLQKq+cVZYumR
 g4KLaYB9Tj/I1HvIu3OaZrvqHFZ+8zNiAQd7NnkGG93xK+75yVVll5SfgRxAZb/9
 6ZEehZUTW2uTrsmfA0AUYhdm6TxsyQ6eafdu+bRB3hR7bWqXTfWOcNEpvBQm0SmQ
 /AmRZasRZitm5RH4Rt70jcHG5KFsebd91YKXDjcUoR4JJVoxXB9w+P+x9EKhwI/U
 yDjyo81SGu4k1ByH0oiU1A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43ce89bx7m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Dec 2024 20:38:25 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4BCJpTBT035674; Thu, 12 Dec 2024 20:38:24 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 43cctk6700-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Dec 2024 20:38:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FkEQVL6pfClBWe4Fq7aG5/sojt3GAvP8M6Qr3tKlHA55z0ug2vyp00bD/2P9Rldh3zoUfEFi4vPdQE0ctT9QhSxyuhbZQ5HbrLmybWRn527HEdzAJURv1hsuD+ICNNF9jN1XbXoHIMPaWMJ26pkZ7ykqRLhJmnSmWyifHB7oxbECxpik6qygznB7myfiFENVRzJLncNEPInS0DxNz2+DWAYgQqfq3HpOLNSjcgX5isq2pgXJ0NUd3XsL+DUsDCOs5egADmD4A85T88mFy36N++nD3n0Y+f5jmSEnwgzMHSSL6kYC5/5UD85HBSFYoD+kUBtqLzDi2TRr5ZaD2GJxwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fneq20+uk3LuxBjCGpv+SkHXtTrmBaDBSRD0Zd77biA=;
 b=qJU9tXVaQoS5fQC/0ydkvQmX0HaS5Vv8jy6M7ybrjRRQoE1FhnwNcS8dO62hxjF7d2JYNG9eh3qlUS/iUQQJfZzGiAkuhpMGfPU7mnH98aMbwh4/gFdAT5j2MSAQd42LpE775FQ9m7khcJ+Cuc3aafjRdEO3UupR591R3E/R1iaD1Cx7NMQk6G/dgxfCsohJdbmK0o7RctaUAkYMlri7FA/FLs5DEOKsqJKsTZpzmd0mV48Vh+AIFMhvbNGAolyy41854eRyUqBg9LZf1Ddu7UK3pigAGvec9M/6QNWbnFzCf5KD3DGtDKnKTE0ZQHcczrimMD1Ejs1/VXI/JV05jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fneq20+uk3LuxBjCGpv+SkHXtTrmBaDBSRD0Zd77biA=;
 b=FRlNoPjCK/p+MhETbSJyKjgHrZdmdUi8UMXAJcotqheD14JhRWMM9it2tEVTGXmwFytUaaCQeYC1MwBeDqtNfktUMC4yBCfjFhk3Cz68PblPmLQn2bVjzUcQN56oI1mZHhCTuLF0Z55vwTNMv7mD0bk2fT7CoRqeypNXyRh8Ga0=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CH3PR10MB7806.namprd10.prod.outlook.com (2603:10b6:610:1ae::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 20:37:55 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8230.016; Thu, 12 Dec 2024
 20:37:55 +0000
Message-ID: <075b39bb-87f7-488a-8d48-428110863257@oracle.com>
Date: Thu, 12 Dec 2024 15:37:52 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 01/19] backends/hostmem-shm: factor out allocation of
 "anonymous shared memory with an fd"
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
 <1733145611-62315-2-git-send-email-steven.sistare@oracle.com>
 <Z1cqjgcvKuUf-zfj@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <Z1cqjgcvKuUf-zfj@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0251.namprd03.prod.outlook.com
 (2603:10b6:408:ff::16) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CH3PR10MB7806:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d0487f9-7525-4d1e-3ada-08dd1aecdb44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VWR5bkllQ0h1Ynk5aGtkc0o1SkpkejJvcFVqT1A5ODVIcEhid2xaaklkenpk?=
 =?utf-8?B?VGJ1aSt0U2RDSElxY1JrcjlvMFJWRWtCVGxick9iYVZxVGFPbDFxd0p1QmN2?=
 =?utf-8?B?Q2JTK0xWaURFTzJMNDFpbmRVc3R6Vkp6bTVaZDRQSCt5eVhpUE93SjNIQkpT?=
 =?utf-8?B?cTJpd1lwSUhXUE51K3ZkQWtLL0JFalA3R1lIbmhZa0p1U1BrUWpncWpsZVZJ?=
 =?utf-8?B?Y0N2UEVWMG8vWTljTU1VWkhjS1FWSnBDaFF5Tk5iNjlLeCs0UGFYVDViM2l5?=
 =?utf-8?B?WnNhbXZKeThvSVFCYlpDTDJxU0VxbHJVMHRCZjBXUEhWZFZkWG9sUEZLNEpG?=
 =?utf-8?B?eGlmcFBtVnU5cUdKZkF5clBkbFB6REFLZmcrakZlVm9IblcwazRWWVJFMzll?=
 =?utf-8?B?MWp6SnJReXZNMExDSVd4WldKK1AwTnhNWTJNZVdHNEFwYVZEcTdxMWNvYzUr?=
 =?utf-8?B?L29JWGMvTndnTnMvc0RZOUZZYkdBV2kySjJUY2JFVUJqR3RXWW51d3hSeWQ2?=
 =?utf-8?B?OVFNbXZrd1JFaElHR015bVhlMytMSlJHSmg0YWM3OXJReHFEMUE2RjBNQ2hZ?=
 =?utf-8?B?RnZuMCtIVWVrOC9TZXNnKzJnK0VuWEJHczZuNVlHL0RIK2VWelUyQTVxanBz?=
 =?utf-8?B?YzNBVytjZUEyeC9DSmEzUkswSG11dDFTVDhhWUJmczBHcnZ6VGFEWldVcEpQ?=
 =?utf-8?B?Yy8wY2tTSkwyZkQ3N0VCM2tYOTNFZXNoZTAwRFNQYmNlVVpibDdWNlhteVhR?=
 =?utf-8?B?MlhoMUM2M0NqTnI2QkF0MENmVWh1ZlZ1YmhzWHJHUDZJZ0lWNFdQTnc4Z05l?=
 =?utf-8?B?VmRjbjRIRG1KTC82enhrMTltUWFpUVBpZTYxek5RSXNLdWdGWlFJVFNGcVhP?=
 =?utf-8?B?UVQ1akI0NkU4TUdhVWkrYk5oL1loeFJYcjlvVTM4b2FsV2ZwNzhaTUhxNml5?=
 =?utf-8?B?Mi9vcW10b1Y0TWc2b2dQZ0IxVHFGdVJacHJSdUp2U2VvTDV2b1NCS3k2Mlp5?=
 =?utf-8?B?QzJ3N091YkN3cFo2Q1R3QVBUU3lEMXRwOFlEODdodVVBNWFub1BXYTFoN1hi?=
 =?utf-8?B?R05WQy9RSEdmQmtuZWpQNGN6R0xOY2xvbHVkb25zVlF4cjd4bEpnamlNMnRa?=
 =?utf-8?B?VEhIbHVDaFNYRjgwaGVPRWJ3b1IyY3dxVmRmZWErbEFmMDI5RnpOdjFsUzF2?=
 =?utf-8?B?SmJXbXorNXBTQ2ZvRFRuU1hOK3ZJNzJSb1BkakViTTVEMEt2a0pFYzJmdllq?=
 =?utf-8?B?ZnRwUGUwL2wvWVZJS2hiMElpL1QyS1RKQ0hmalAzczVGNVJMbEFoeDVaTk5p?=
 =?utf-8?B?WUh2blE1Yi8vTVlOT1M5S1pQOVR6Nk9qYkZGa0VwUkswTkVpK25BclZ6Z1d5?=
 =?utf-8?B?MXVxdk14UFpCdnBMdEcyMTBsM21TQnlJUHhDY3lKSS9wL1RxRTRSanZtVzhX?=
 =?utf-8?B?TGJBUzVwM0x6ZnIxR2ZKL1F2THlMeVhyYlVXSzhGcXk5cW5SRHhwQ2JSUGh4?=
 =?utf-8?B?K0F4bzJoV0YxRis1U2ZHVDkyOWQxT1g0ZmFvZnFVSkRFVTlGY1RrTm5BSmRC?=
 =?utf-8?B?QktxRzlRbUpyRmRVbjRDMS93Q2Z4aU9rZGJLT3ZLRlNCNHl0N25OVjltTEtJ?=
 =?utf-8?B?SGVnNE54WVRpQ3UrSUhkNFoweTIwd3RXWDdLY0ZFSTVPcE1SL281OWtMTDlZ?=
 =?utf-8?B?WFBzaG41dERXYnhxTDA1WjhscnpLSkF3cWx4RXVrMUtNMENHaXlUeWVkamxR?=
 =?utf-8?B?c3ZGQmM5WEczK1FuMExXRGdlWXdINHR3YXRON3h0SXc4YUJwMjRBbSt4MnpU?=
 =?utf-8?B?QWpYK2NGM0QzWW9SZ3dTdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFB6K0k2NTY0eEUzcEhPMExZMzl5QmViRkFpRWtxaVlwampiRGZxTm5RUHZh?=
 =?utf-8?B?bXBZZ01yQmhMZ1hTbVAwWkRVU21BSjdFb3pvL1dZUDE3bUxwdUI4ZXhtajAr?=
 =?utf-8?B?Y0ZjQkJhQ0U1dHkzQVIvaFFBOXBkSmZuZUFTcW5ZK3M1cDhwRjUwQzIveDVN?=
 =?utf-8?B?NFRUQmhjYkEyczZURVJrZSttNURqOC96Sit6UHYvMUxJOWpVMC9tRnpPck5h?=
 =?utf-8?B?YTlrSS9mLzlSQUoweUZxVVpFQjhIMGY1RVFVWEJVcVk1eG5pUW1heDAvM0dZ?=
 =?utf-8?B?L01PeDhRY0l3WTUvbnRsNHhEV205MFZBS2licEZuV0R4Z2JreVppUGUveTFV?=
 =?utf-8?B?b0FvWWhWUXRDQzBuYkRoSlFtU2NMZHZtZi90M2FEUUpUZ2VhcysvdytUV1pJ?=
 =?utf-8?B?cGNuKzl3VzJkdEVSL3NOZEpSc0NaWDhEWDhRWTlXd3QwKzFkMG1TKzBnQm81?=
 =?utf-8?B?RlhjRS9QU0tGeVRvbEVXOGZVMWRlMkJDcWJsTkVRUWM1Q0FRVkN1TVpRT2hN?=
 =?utf-8?B?bzRVUWVVSmptRk5tMDRLZmhsQllVTFh0ekZ6a25WRy9pQTB5d0FXTEdWR295?=
 =?utf-8?B?TUFFL1VTams5c243N1k1NEt0eFgvSzIvOTR4aU1VTzY3aDFDYndNbitOV3dS?=
 =?utf-8?B?T2RORXJ5dG5MTTErY0tUNU1hQ3lpTkNMTGh1TnVnRXVMSXdLQ3Y2TDBPa1dn?=
 =?utf-8?B?WDh1c1RKL3pqSEJjc2pnRmkxSXgrRGxmRWZBZUorSG5Ja1RJSzhVQ2p1eXBk?=
 =?utf-8?B?Z3ROMGp6OHlFYWJBTFNTaFlpWUhFRUE2YWkvVm5abjVTQUswdzN5cDRUVDQ3?=
 =?utf-8?B?YUFoZDk3UlQ4c3VXdmI0cVRIVG0zaVRwNEhpeFVxdG1hUzQ4blRmQ3JLSHVS?=
 =?utf-8?B?aDVDWGFqTDlOTFY5WFFmNFFKbXNXN1UwOGx2aW1CTUQybE9VRkw1dTJodFNs?=
 =?utf-8?B?TmR0VEVjeHpuTWZpTGxFQVliVEU0bW9TSkp3MGVjNDdnZEtkb1VNSSt1QTdz?=
 =?utf-8?B?bFpKcGcxT2NHdTRLWVpaMU1zSjJ5dXhnZm5PSlo1MklseFRIVlFyRjhRYTNw?=
 =?utf-8?B?TlJ6VlJLQ1dQUFE2ZXNoOVdxdm5NeXVSZzd3Y0NuNnhsZzBSMCt5Q0lWbTFa?=
 =?utf-8?B?Y242b2FNbDY4MGI1ejcyUXJVZGhkc2dKR2EvQ2JTMHJPUXBnbzVkN3R5WDJs?=
 =?utf-8?B?OFlnNTBJU3ZGSWxJNTk1SXhnR1VZOHVjUEQvWGNjL3U1QjR0dCszWFhhNkI1?=
 =?utf-8?B?MUY3Z1hYZ2M1N3gvT3JVSFlnM3B5QUhZSmloNm1zZC81K05xcXpKbS81SHhr?=
 =?utf-8?B?dFI5eGg2YlRGVVZSeDQ4VHRESUpXbTFLNi9ydGEwZzZNckFjdUpvY2FVQXZo?=
 =?utf-8?B?dk5Pcld6ZGpzeEVubXBnZXE1UiszQ3ZudjRZNFVJQ1NZV3lOVTBvVmh6YlM4?=
 =?utf-8?B?STJrOVlpY0t3VkpnQ1BwTmcvWFUxSWF0a1E0QWkzamdIZTZKdEdWRDgvNGVy?=
 =?utf-8?B?OVhWejBnZjdOQjB4c2FoeGFVYUlMTUZRUldJbkdIcWxVQS9UR3FZL3B3MDRp?=
 =?utf-8?B?YmhwUi8vODJsbW9GbTEvVUxwR0FPeDIvMHBoUmMyRmFBRXltT1A3Y21ndFZX?=
 =?utf-8?B?MkRqbWhTM2lIK1BjV3JXZW1nanJiNllSSXZ0K1VBUS9EUWZ4UnRSRXJQdTUz?=
 =?utf-8?B?NW5CR1J4MDZMcEdkanVMMVpOUWV0R3hDZUUvWVdsd0hIa1hiWDZvN2xkZnJo?=
 =?utf-8?B?SW90VHlsQWlKczhmZURNMy9BZ0NoNkFpUjlZRlJCR0Y2NmcxSjlGMU9uRm5m?=
 =?utf-8?B?WmFQZVBCTFh1cGIwc0dzM0dTcEtheE9oRVdndndBREEzNWNVVm1Jb0REWkhZ?=
 =?utf-8?B?K1ZBY0o3T0JhbjNvL1RldDd1ZG9TcTgzTGVydzZWZ21VVnpycDJjdkNaY2hp?=
 =?utf-8?B?UUZMSzFaMEFma0lZU255MlJLVTlWakZnOGZFZTg2bEFQZlVLZzJPZ2hscEpT?=
 =?utf-8?B?cHpRemF4bHdsM25qSDFBNlVQeTZNYkF2bGpja2RvT28xWFQyTlhpQ0V4UDcx?=
 =?utf-8?B?bFNwNm9VbmsvRWhoSlNwSk1HUW5YUDhjWGtqWGlxVWljeStVY1ZBVFB2aTlH?=
 =?utf-8?B?NFpIbGh2K3BVekZydC9Sck45M0swSFRCT0N5N0pPMERqNFhEV1BlZGFKRnBG?=
 =?utf-8?B?L3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 70B1RMVAn1KwVRydjQbha40tFdCezA3gb04UcR7vgIdxLDXg+C18AYSyBLIiKSdVtkukUb8pF1qeAcpstnYMQPnqs5tNjL7hmVmW8X0QPDZ4b1/bbdHgcaBcAFNMU2Rgultl2QLug+X75V52M6Tqya12HHHpJqTo4ZRp8j2eSqJc0Fk8xYHcXwqSLwPo0KxxzIjlOI2oahi9LfKBzCCUnRRtX4L3qDyE0Cuwq4DVuHqJ9PgAy0K0qr9qgn8eUNWYNG4z0i35mz5zsWziyQKOYajRYJK343dot03hCIpmv5doFQsmv69WmCFa/25Wbj8WH2S5zhDhAi6akgk330fExkL2YOueCZoyz5VKCQX6WzL5HjbmFRpQIxp8aGdAN6OxsAcDLFS3qCfzaFxyCYZP8ouFuxDP5focC4ErM6/fDZ1eaDSbznn3VcNLlk1qandk6QQzbKywYmhUhFAHYcviaOzowDHvIx3Elwu8J3C6IXTHAGBiceU0fh6A7aB0F5pKBq2VI0KZXQPe5a+Wn6YCpD7EUPbZDsQRCM0sdJqw7IsgUtO6b3GHHi7LWJpTiyOwtOSsWttPgS3Z34IVsGkKec/Vkn2tUr71nsgRd+FbZoc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d0487f9-7525-4d1e-3ada-08dd1aecdb44
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 20:37:55.1655 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fqP0hJtnrC7G08qG6RDzCLn2rILy/mqgfk70EESrj1mDYWbT/NGk5ZSRNxv31Fgt+mp5KwXvA9loUS6ciDqcumP7yTEL3fMYnHew//oErQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7806
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-12_10,2024-12-12_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412120150
X-Proofpoint-GUID: ABRC3YXpPHioiXUw_xJHlpAM0E7dSzBJ
X-Proofpoint-ORIG-GUID: ABRC3YXpPHioiXUw_xJHlpAM0E7dSzBJ
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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

On 12/9/2024 12:36 PM, Peter Xu wrote:
> On Mon, Dec 02, 2024 at 05:19:53AM -0800, Steve Sistare wrote:
>> diff --git a/util/oslib-win32.c b/util/oslib-win32.c
>> index b623830..aef5779 100644
>> --- a/util/oslib-win32.c
>> +++ b/util/oslib-win32.c
>> @@ -877,3 +877,14 @@ void qemu_win32_map_free(void *ptr, HANDLE h, Error **errp)
>>       }
>>       CloseHandle(h);
>>   }
>> +
>> +bool qemu_shm_available(void)
>> +{
>> +    return false;
>> +}
>> +
>> +int qemu_shm_alloc(size_t size, Error **errp)
>> +{
>> +    error_setg("Shared memory is not supported.");
> 
> May need a fixup here to make build pass.

Yup!!  Will fix.

- Steve

