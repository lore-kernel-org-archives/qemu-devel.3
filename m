Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC57EC77B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 22:09:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTpLQ-0003b6-Ib; Mon, 23 Jun 2025 18:08:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uTpLO-0003ar-Pj
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 18:08:51 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uTpLM-0008Tn-9i
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 18:08:50 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55NLgM3S032327;
 Mon, 23 Jun 2025 22:08:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=oWIcrW57NIScsUGPF62eoSUL/VVorLyuOo1U7fNbCUA=; b=
 g03/4bCLbWwtvUFxe6sq4LbzO3lnEWuobNhIHk494uYCZC+zVamGmbj0fye70WEj
 dctwwlS4Tj/keDqHxdOfiMXQVX3J9bBgyciO2hQXbVfBKTj7Ocd5c9qVO9Q3UzpT
 9nF3s74t14UC30FL/5im+x2i5qiO6Xx0WMTA37ZzUgY/I4NFB7M/Q87HlERqq5ze
 zY3GPnkvNJd6BvTQJknBBg2AWk0b+WeqTxI6FaUUs/qVdYkerJ6RFHOjvWy9N19+
 cAnR7d1QGaKUfzZhbKqxGmyuQi/grd1KW0n0CId905llcc1QjeNGnGFljN8lmBgB
 mXMq5+gloCgKcH2LvfVTRw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47egt1apha-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Jun 2025 22:08:38 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55NKtErB031316; Mon, 23 Jun 2025 22:08:38 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2073.outbound.protection.outlook.com [40.107.96.73])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47ehppd4wp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Jun 2025 22:08:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dRpWq4ZeBg2OSThdTDvBFaG1ePD9rDk36+9K8cwn8t9DKAJ+AzlIR0FZUFoSc/kej6/Cn8/98EDzBZayvDkfa2rfeVBlpkGaKI3uWdEW8cuU1h00tUo+9dhO3Uq92A1TJfejsdlzqXBvYc3LAEWFcdAJhd3ZxSVLFxYDqC8/nL831chTjFf9eDEzm5rvn1ijPEBadHMhEG5LuEfvw9NZ/qnf2kBUyPiG2Xgp+C+SFyUPvLOR5VZY/ys8k5y3RCgZiHUwaTHawRp89l3BoIM9yYR2bJzG4BaAu4AOzxWe4XqVDpedXDtOyTA0xMWKDmS9FN5bj5jETo3jksXql4Fphg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWIcrW57NIScsUGPF62eoSUL/VVorLyuOo1U7fNbCUA=;
 b=Igio/JsBLfYq5nWwiqkS40r0ffEloX2PrbAlw75As5BeCMEYhcyvVD0OnLC6dELmx3MhkNnHF/gX2a+yKbceaotgLCfTEE/KGj+j/oDEPOTcAacinnHS2wox4voVNfZC3v/AWlAvdCrNCODoVYjNmg4mNJtpdow9GEheQpU68HIvfuxYVfgvN73Bedu98P4ViJCf3zpIgP7OhWsuahrTjgHguRw6b8xK5hrzRO9EK3pN8JkfXhjTnUUPIra+7oN6Une0car/F1m0vhXH5iC97WtTUayAC11uY5Uq53crEAA3ghYpHi+uxHuBkjP9cYAQCxebz67YxPueH1XRtx2Kyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWIcrW57NIScsUGPF62eoSUL/VVorLyuOo1U7fNbCUA=;
 b=tx1NTzCN3Nu16ivwH1UWjmXIj8qb9q3SK4d7U+ssO/wq87SnrntYBhp8+CLwujjPlXfZcWLisGak3/g810TBO9p0BnYiU9zHcxpFxABA7ItEgqvQr8Y5O7Zf2X0pIVVCD+UT9/+oKU6mNNVhLsjIgzSklBHv9KtXiF1EQn4J5hM=
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by DS0PR10MB6728.namprd10.prod.outlook.com (2603:10b6:8:11c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 22:08:35 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%5]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 22:08:35 +0000
Message-ID: <efc8eba8-b602-4ef4-9e07-7c4602ffa96f@oracle.com>
Date: Mon, 23 Jun 2025 18:08:29 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/20] amd_iommu: Set all address spaces to default
 translation mode on reset
To: Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, Wei.Huang2@amd.com,
 clement.mathieu--drif@eviden.com, ethan.milon@eviden.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com
References: <20250502021605.1795985-1-alejandro.j.jimenez@oracle.com>
 <20250502021605.1795985-17-alejandro.j.jimenez@oracle.com>
 <6cfb9c54-d7ac-4e4d-9370-b62175f861bc@amd.com>
 <18ca629c-0ac5-4a0f-a88f-92a3afa328ab@oracle.com>
 <f1575acb-31ad-40c8-bf64-e5296812d362@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <f1575acb-31ad-40c8-bf64-e5296812d362@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR17CA0068.namprd17.prod.outlook.com
 (2603:10b6:a03:167::45) To BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|DS0PR10MB6728:EE_
X-MS-Office365-Filtering-Correlation-Id: abbd96f7-462f-418d-fcc6-08ddb2a27f6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aXpkNy9YK2xOdHdUalZ5WnhaTnh0UFE2NisvTHFXRUZqbHpVT0hJWFppMytX?=
 =?utf-8?B?TGxRMzR6dmlYS1NzZmtFZlc4SWpjUlhTRjF2RUtrdkdyM3k0ZHZ4d2xpbmRW?=
 =?utf-8?B?RmdjM0FSU09HaGZPV0NLSkgvZmF1ZGdPWkdWaFhPbThybzNuK0lRRzVpQnlU?=
 =?utf-8?B?aHhpT2FvU2lUdWwzVkI2cThzRTVHY2F4ZFR3TDVJSldKMjVLZUhxSHdLRWU3?=
 =?utf-8?B?NUlCN1J4YkJXRzloWlNYUlJkMHV2UCsxOS91akh5WnQ0REFzOEZRZjV6NHRm?=
 =?utf-8?B?NTM0ZlhjcmZXOFlMeGx5eitheDNBbndoUEh1WVRDN05ucHFxNDh0aW5mQXJt?=
 =?utf-8?B?YnlmNWFWcWhteEFJUFZGNys1aDgzb2dIMEt0ckxxekdabVJla09BamxkUmRM?=
 =?utf-8?B?ZUxqNmhQSFVOWXM3YW1MWUpOazZmbG9aQlpSNWZmK0lFSlJUVE1EY1JsSHpa?=
 =?utf-8?B?RlR2Tm1ON0tjb2kvZzZ4aE9ncDYrY0I0YWJCeGpKQzd4UDY5OXhIZVZTVkd6?=
 =?utf-8?B?U3RVVVA1bkFxaXJWWWFTSVh4WnQxMHJxRzRBRXNITE8vZUp5VldqTjVSaXdo?=
 =?utf-8?B?dVVra2pKNGVlT0ZGTHdGY0hwZm9UMGFWbFBnOXEwTENFck05TFhBRGJZY2ha?=
 =?utf-8?B?R3pXc0duUWoxQ0hGajB2WUFDcTQ2VWRjelRRZCszL1d0bC8zVVovNzdOV0k0?=
 =?utf-8?B?V1phNExJNkIya2l5bGFjYWhYNEcrYW1WNmFMVmU5a1VRY3JPc2k4QUJBd3I2?=
 =?utf-8?B?UWlidW5qWTF3N2U1SWdKeUUvTEhOZGdZSnYzaUczN0s1dzI2Y1UveXJoeldD?=
 =?utf-8?B?MktGd2Y0dCtpcG5jQ3ZiODNNSXhpYWFMTHEyZkJ1c1F0NW9UTnBJWUVMU3lQ?=
 =?utf-8?B?YXByZDQ2MlBsUnZ6YlhPWEd3Z0FhUGgrUXZGZ21GTHBZcld3aTFBTHdlRXB2?=
 =?utf-8?B?bHhXSUxGUm1Bbm0rbkZTWmp1QldRNGpJamNiOFgrSXdCWnU2WWc4L01MVnBk?=
 =?utf-8?B?TGcvZHVYSGxXRS9wUkdPdWZET2xYLzk1dVFBLzExRlJoekZ3NnVPd1VJUnBD?=
 =?utf-8?B?ai9pelJqWDNtSHhxSmRVOFIxZHVmbGtBRjZic0hpdEZoVkhYNTZMTldsRUdk?=
 =?utf-8?B?YUpVUW9zd0ZXdkJSNDlhOW84UERxUFhVKzZYTWJNTk5mUkdUNTA4N1BicU84?=
 =?utf-8?B?ZEg3cHBEZHJpZmNucXJGalA4czFXT3B6Z1RVVm8xK004RnIzVnZBUzlMZ3Rv?=
 =?utf-8?B?K3QxSktUUngxUm5rWEZTK0JIVU1LbjZXY3FGOENmMEtFQ0Q4VzluYmFMTnZ2?=
 =?utf-8?B?WEJlVXBCL3VYdGZIV3BWb1N1eWRUVXVDQ1ZybkI3Zkk3b3lncnFMZ3JuOXdW?=
 =?utf-8?B?UlhGNnFhZmJmelUwNGQ5b1NCRC9BL0JaQWRDR1VZVGFYdlVDM245bEc5TDQr?=
 =?utf-8?B?MWh2N1BBcmFRd3p4alo0TVRJSTlkeUlPQ0ZwT3IyMHdBWFBIM25NZGZlVXJR?=
 =?utf-8?B?MkNrSEh2OVNndjdPMFJqbU9YRzBxTG5jaGJvR0JHVzgzemZTM1RPaCtkaXpy?=
 =?utf-8?B?eEZCRUNSWUk0TXBHSG9WS2FDNExUcTlxMWRkakxkSzV1aHdoMW4yVnZXUUNN?=
 =?utf-8?B?KzR1ZGlPWmswbUI0Z2tMa1VvR09tUkVSM2t6bDZPOUNZUjNsVVNKeC9LaG54?=
 =?utf-8?B?aldZNm93ek92WVBaaGNLUkhsWjlWbVFxdEY5UGJ3clphb3BZMWhwZ01WODNR?=
 =?utf-8?B?aUh6RnpHY2FTekRjaS9HQldBdVNkeHVUamRGQ00rOE9tR1YzdWdPYWtHaVd5?=
 =?utf-8?B?blhBN1A5N2V0Qk5EeC9raSsvc2drT3NTalZNV1RlaHdYWDlHVmF3SGVTM3Uw?=
 =?utf-8?B?NTJ4VWZsczNVTEVsWWpqcGt0a2R6Y1AvaFVBbUlvNloveHA0WHpQcWNpZVNm?=
 =?utf-8?Q?u9M+4DmESp8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5041.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnpUMkh4N2F3OW5FaDVGaGtRMFFheUFON3Q5OHNDTWtRdjE3elFYNjkvM1Mx?=
 =?utf-8?B?UzNSVVcxOTV3SEphOWdxMnorNUdyNnl1ZURpWkU3RXlKZGY5d0hPS1ZRSFVC?=
 =?utf-8?B?bThMNUtpV0N1dzY4ZnhyZ1BrdStzL3JBcGl4N0E2eDRBUXV1ZzU0eEkrVHpp?=
 =?utf-8?B?aEJubDFoRnJCV2lQc1QwN0NIc0tRZ3V3YitBVjVHSVVIdzk5aVI0czhhK3do?=
 =?utf-8?B?WWkzcGtzSEtuMG83ajlBWWhSTnI5M2Fad2JPWjhqRnlDdjFFUGdUbmh5VWdo?=
 =?utf-8?B?czdUbjdxKzdYRUdhZGZCMmVYRGFsN1pYNFFpWkdTeitpb2dNNk1QcmVFRitz?=
 =?utf-8?B?S0hqWmhjQjFCc2tybEVkaVVaZjN1aTY4K21KZXJoUEVNU1l6MFhTdy90UXlY?=
 =?utf-8?B?Mk1iSU1rdlYxUUh6cFAxL0VPWVMzbklqeDJ1dVFzQ1IzaHJjbllNc1JQSjNE?=
 =?utf-8?B?SVBZVlZVamx5V3lqdUlIbnFhdmVkeDV2ZHdzUUIyLzA5cnNOREZUYk1JTk9C?=
 =?utf-8?B?eHVEdjlwQmpObUdwTWVRMlFwVWxzTVdMb0tLUXBaZHRQSVpwMjliTTZ3VzZX?=
 =?utf-8?B?TzFmUDNsK2lxcDExc0JDN3lxWHpYZXZWUGNKcHJZT0tvRUU4MnB5UFdvTEVU?=
 =?utf-8?B?c0ZLQzhLUmovTzV4WWtmWThBbTBBUDlwY0ErNHQxM21MRysrcG52bldEb3pW?=
 =?utf-8?B?VjRDWDlMNE1wc2tVcFEzQlhFSzBhN1lydEZiWktseVhuQnNxMm5HYTkzYXMr?=
 =?utf-8?B?T05iNnJuZUNvc3pzM014RTZzUHFMTUpST3BLK3QxQlZ3OWJ6ZisyaElSR21q?=
 =?utf-8?B?dVJYUUZaa0hYbmdQbHdWRUpzamRITTR6MzNmN2djMnZNRkdkWTV5Z2NFWkQ2?=
 =?utf-8?B?dWFnOUtXa1F3b2hPSlhST2xxelhvZWtvUklTYjF4SHFrUHVjT05HNjBWd2xM?=
 =?utf-8?B?dUNZQTcyS1ErYllNVVZCOTZjOEFCT0JGUjRYME4veFJOTEhKOHcwVXVCWFI3?=
 =?utf-8?B?ODBraGhNakwwMVV4cUJ2NW5SWEJTYUkxNlNZMUpPNUxLZ1lBaWh6SUNuZlhR?=
 =?utf-8?B?MVhKaXp3amJKRTJJN2Y1OWQ1RGFoWW9ySzZvSVN6MEFKOFN1cTVWMnZpYkI0?=
 =?utf-8?B?enB6c2hMS2hJU3oyMGFnUmJmVmh6N0tRQjBhay9GM1Q5TFF2RFZDb1JtT3dT?=
 =?utf-8?B?blFKdHB6T1dDNUd3aVBnVFZvNFJtSWYwZDV2L1ZnNmk3ZXRFM1NPQjlidE0z?=
 =?utf-8?B?SGdwZkpyaHhMZmozQzJGT28rRTZYQi9zTFpHeXRObXZad2svajYzZEtGN0tT?=
 =?utf-8?B?a0V4RHNvVjJ2K1dQN2F2N1BkWEhsWENqd3BxQWZ6WFNJNnlKZk5RVGhJSUhQ?=
 =?utf-8?B?a09xQk91amNFNHowaGkxaHlSODFPbWNPSjUzUXNTYk1yWnJVVHJ0VnJIbGNL?=
 =?utf-8?B?STN6SE5rbzlIRThuYzBIZzM5UU9xY3F2ZGpkM2h0eHo4NEJYQjNNRk5aWUNq?=
 =?utf-8?B?Zy9Vc3AwSEIwZEl2YnpUKzJSQVpDdHRnb1VRNzhnT0hkNmNaYXY2ek9KOVZ4?=
 =?utf-8?B?ZEY4VnRWRnlhMCtMOVJvVlRHYjB3bVRDWEZmZy9KTnV5blhVa3JDWmF3eVZ2?=
 =?utf-8?B?Nkx3OWU5RHp3c0l1T2UzUC8vaUEvb3d3OEFzRjB6S0Y1SkpzRzdnNVg0R0hl?=
 =?utf-8?B?M2dJNStGWVBUS09QbjV0dmFvNGNPSjRuRWp2aStqWG1wMEZjL1B1cHdPOEdI?=
 =?utf-8?B?bllYNHFjbGFxcURWaXgwNHhkZGk4V2ZXTThsVTdFNmo2WEFGdFF0d0Y1YnVi?=
 =?utf-8?B?cEJOMC9PcWdyTmJObWpaWHAyREdxOWVXU3NRZUdFQ1JxMzNCZnIxVzNTQ3lG?=
 =?utf-8?B?aFdibUF2Mm9DSldNbmo2c1JVYnNOMG1EZm1LVDNOT1kyKy9OT1UyUDhZdy9V?=
 =?utf-8?B?ZDJJSVVPQmxFNnFzeWt5d1JNczZGejg0SWZHcjdTaVVoeFMrTlJ6cFBSOVhZ?=
 =?utf-8?B?a1JEc1o5MFlpYmp5Z3RTTTdVczFEbDNEUFJQcy9adHRQSDlSbFRiVFhnb2JI?=
 =?utf-8?B?RWMvS2syL3YyaXBlVzgwSGIrc1A3dmoxOGVCcWRKSFFwUlRKNlVsbjlPZklk?=
 =?utf-8?B?QWRqdFFodkhibmdiaThqeFZBM3kzL0hYTDEzSXJYa2k0RVAwTmE5OWVEM0Z2?=
 =?utf-8?B?SFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JRhyaFM4QZjlnFNk/gTj30r7mEgmQloQOcLqyzqthRpYSOtpRE9Fvvd2iFGdwNztVERqpVhU0iQH5qAwdbLx2+3cA08p38yiYdrqHYEEF83/IW2YgWsSFW9f0vQyXxjqE9LF4b9rGxxZG8gDFNy9KOWXuR18uNUwYcIxNlrj98HRP61p0lZ6ZlP7kqBNL0Vto0ZI2mMmMCzzSavEPGoOm5vO0guSvpPqH19qrz8m+vQK0sbB7UQWn2Y3/BGMdimv7DW87mvsvBKmM73L0c35nv7I3ufAEENadd7ysuO9GIy3aOzfHglskG5FhHhf0fwAtRPDfFU/rjRdgFIsXNkr7tBUxefDGK+jI8Fjz+VP/s06C7X0kVxLhlwZhlrYZHkXCmgOBcVS7a76ZopujH42pq1uNLe4cFrx4zHWywMaAHzkurquJqik/H0jhlyXgONo/2eLfdF0uEfL0g45TuOvj38SMlZoe10y4oAWhPcP+43iLG0ZWQWqBkRW+exSQwKj6kra4HR90VwUkOal1bbKSs+2KV987c6mbkZkshaQEz0N3DxL6aH2Ow234LF+zDKA/ZgMzittjdHLQoY7qhm8mjzYpMttCmOEQ4wu3kwUc+4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abbd96f7-462f-418d-fcc6-08ddb2a27f6f
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 22:08:35.1540 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ct4Zc+U4pwgXYLi4BMC046KFB5ndBvNp6mmrAHZTJiAM6EtvwWckHh2P7jMvjbxfK9mjmjgUOL0gGn2nwj5r0inr4GIAq/+oeBMcWpMGuJY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6728
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-23_07,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506230150
X-Proofpoint-GUID: 6UOuySXwtuspcU7yp_HGeLjO9cirCVyN
X-Proofpoint-ORIG-GUID: 6UOuySXwtuspcU7yp_HGeLjO9cirCVyN
X-Authority-Analysis: v=2.4 cv=cpebk04i c=1 sm=1 tr=0 ts=6859d067 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=Nq7aaTLnNCK5f_pnejAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDE1MCBTYWx0ZWRfX02hOzZYZE/RM
 AUM4CAdqw5E0hyUL0TR+faj6q1D2G8+0m2IndlZ9qIEafHFRxA9WS2YzIya96FvAzOkIaLOELyg
 raSFJrIBMpiEbHjxZIt73T73xlb3jkHnL4pIXbQbiwwvKyzlBG0sWnUJJK20cxe/zBJ/NjttIfD
 4kYwSycgx1hBn/DOXLOZV2KDY7HugI5Fux/HNMTgbkpj+9xAG+mT96xUMeOAcw61e2tL8xTyQ6w
 3wwmrsvh9lQUfXdU/GZDKENo6TrIRky95ul1W/9Q/23dFhERQIFS4Xcje+C7v2KalqsqsAkh0S6
 poHVEE7VpY6HGca4uLwqsg6v86iVuEKqJJWsiCSxU762B+PUjF+yXR+aXZgVsR8fG1MstsZmJs0
 r4FsxCiiU3miJCqM3iT4Lag67cpApmA7bBIeAOtNZIK4cfUntHW43K5nd0iUxQyZVSGYuFj+
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
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



On 6/13/25 4:46 AM, Sairaj Kodilkar wrote:
> 
> 
> On 5/31/2025 3:00 AM, Alejandro Jimenez wrote:
>> Hey Sairaj,
>>
>> On 5/29/25 2:16 AM, Sairaj Kodilkar wrote:
>>>
>>>
>>> On 5/2/2025 7:46 AM, Alejandro Jimenez wrote:
>>>> On reset, restore the default address translation mode for all the
>>>> address spaces managed by the vIOMMU.
>>>>
>>>> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
>>>> ---
>>>>   hw/i386/amd_iommu.c | 28 ++++++++++++++++++++++++++++
>>>>   1 file changed, 28 insertions(+)
>>>>
>>>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>>>> index 71018d70dd10..90491367594b 100644
>>>> --- a/hw/i386/amd_iommu.c
>>>> +++ b/hw/i386/amd_iommu.c
>>>> @@ -962,6 +962,33 @@ static void 
>>>> amdvi_switch_address_space(AMDVIAddressSpace *amdvi_as)
>>>>       }
>>>>   }
>>>> +/*
>>>> + * For all existing address spaces managed by the IOMMU, enable/ 
>>>> disable the
>>>> + * corresponding memory regions depending on the address 
>>>> translation mode
>>>> + * as determined by the global and individual address space settings.
>>>> + */
>>>> +static void amdvi_switch_address_space_all(AMDVIState *s)
>>>> +{
>>>> +    AMDVIAddressSpace **iommu_as;
>>>> +
>>>> +    for (int bus_num = 0; bus_num < PCI_BUS_MAX; bus_num++) {
>>>> +
>>>> +        /* Nothing to do if there are no devices on the current bus */
>>>> +        if (!s->address_spaces[bus_num]) {
>>>> +            continue;
>>>> +        }
>>>> +        iommu_as = s->address_spaces[bus_num];
>>>> +
>>>> +        for (int devfn = 0; devfn < PCI_DEVFN_MAX; devfn++) {
>>>> +
>>>> +            if (!iommu_as[devfn]) {
>>>> +                continue;
>>>> +            }
>>>> +            amdvi_switch_address_space(iommu_as[devfn]);
>>>> +        }
>>>> +    }
>>>> +}
>>>> +
>>>>   /* log error without aborting since linux seems to be using 
>>>> reserved bits */
>>>>   static void amdvi_inval_devtab_entry(AMDVIState *s, uint64_t *cmd)
>>>>   {
>>>> @@ -2199,6 +2226,7 @@ static void amdvi_sysbus_reset(DeviceState *dev)
>>>>       /* Discard all mappings on device reset */
>>>>       amdvi_address_space_unmap_all(s);
>>>> +    amdvi_switch_address_space_all(s);
>>>
>>> Hi Alejandro
>>>
>>> I think amdvi_sysbus_reset should set iommu_as->addr_translation flag to
>>> "false" before switching all the address spaces. Without this, the
>>> devices will keep using IOMMU address space.
>>>
>> My first impulse is to agree with you, from the standpoint of 
>> considering the no_dma mode as the "default mode", and a reset should 
>> bring us back to default. But I wonder that is necessarily the 
>> architectural behavior...
>>
>> After a reset, in order for any device transactions to be processed, a 
>> guest driver must reinitialize the IOMMU data structures, including 
>> the Device Table and specifically the table entry for the device. That 
>> must trigger a INVAL_DEVTAB_ENTRY that will be intercepted and as- 
>>  >addr_translation will be set correctly. If the guest driver doesn't 
>> do these operations, then a device won't be able to use the IOMMU 
>> because it doesn't have a valid DTE, right? The earlier mappings were 
>> already dropped, so it doesn't affect the host.
>>
>> Again, I see your point, and making this change is likely the right 
>> thing to do, which is why I'll make the change for v3. Just wondering 
>> if implementing such behavior is actually architecturally accurate or 
>> just the "common sense" approach...
>>
>> Thank you for your attention to detail and all the valuable feedback. 
>> I will be out next week, and will send v3 once I am back online.
>>
>> Alejandro
>>
> 
> Hey
> 
> I tested current patches on OVMF and reboot crashes with IO_PAGE_FAULT
> logs on _host_. But setting "addr_translation=false" fixes this crash.
> 

That is odd, I have been using OVMF since the beginning with no issues, 
so I'd have to ask you more questions about your setup to figure out 
what the difference is since I cannot reproduce this specific issue.

> I think the reason is that, kernel does not reset DTE while shutting
> down the system. This keeps the stale mappings (IOVA->SPA) still in the
> IOMMU and OVMF initiates some DMA operations on device before guest
> reboots and sets up the new mappings.
> 

On reset, the call to

amdvi_sysbus_reset()
	amdvi_address_space_unmap_all()
		amdvi_address_space_unmap()

is intended to avoid this problem.
I have found that on reboot AND when using forcedac=1, there are 
mappings for the upper end of the IOVA space that are not dropped (this 
happens after fixing the integer overflow issue you pointed out). I am 
looking into it now, and once it is fixed I'd appreciate it if you could 
try to reproduce this scenario again, as the underlying cause might be 
the same.

Alejandro

> Thanks
> Sairaj
> 
>>> Regards
>>> Sairaj Kodilkar
>>>>   }
>>>>   static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
>>>
>>
> 


