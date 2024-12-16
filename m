Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8635DE7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 19:38:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNGv9-0001E2-Nn; Mon, 16 Dec 2024 14:38:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tNGv7-0001Dq-To
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 14:38:22 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tNGv5-0006TX-8j
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 14:38:21 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGItrGM025192;
 Mon, 16 Dec 2024 19:38:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=WRm0/b5icNEno6ag8tarGsYKT449i+UFp4ldmwApAMw=; b=
 Iij+brtyBrPX3Z3HLx160rWp4Sc+dyEXJUJrd+ef8HF2x2MePw8uXSai61GqsSaG
 6W8d45HmcKMviPqW4uiJUZiFLa5I5ynb+Nwpd1KVa8G5HrDsS13GGiCnggf+J1vS
 mFnaieeYhfYAxuzj6H/TlCh20JbnPSxakL0YVEz3NcxhtXIBVPxPz5Cf1J9T3/Ul
 nR1BW8TDiI9Rr5QdrULnlHOdKP2yscGPZ7kFmwlxsgRK0aBxbjHUMJdRAtY5RVpi
 G6KPjoTnFgxoFlUe9PrE5kPtxYQQcIiSZ8t2xhtNi4liEv1u6mQ/ImX5KJudGSZJ
 nY/KleHBq5MAdrLS9LHCRQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h0ec4501-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Dec 2024 19:38:16 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4BGIOOTe032928; Mon, 16 Dec 2024 19:38:15 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 43h0fdr4m8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Dec 2024 19:38:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n3km5uLeeIdGgzJs44w4ws0kcHEFpJy7x+Kjjc3ck/QQbUeyqVZv/yDv7GuRCRr675VFpLXzcDbLyZyFjKy21MS+qnIJyF+EVFphmOVFN1AsQI1n+yTro1jTLncYHMzUqGcQo5y5WlVrUkeK7guFTS9dXmzdf3xPVkVLxUTaiWnldHY0wfjPQ5hqmzzRRE6OQ03/fkdFiTVUIjjx670ke7g0XrjXflXzFb1l9w4SPlbakUBPyOTbYXHGho36dtueF263DuY3yHhk6VLPPLqPELHNb0xywFm4udShKBHzhwWvS0JzXyFAySoE260GCaGtB2q1TbWcYKJSxmdjdIysnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WRm0/b5icNEno6ag8tarGsYKT449i+UFp4ldmwApAMw=;
 b=dlgEVilKat7U7mW4Fd5p7XkWlibMXrSvbEXGWGeTgm2YhRO+qhR+o6em/UUmRkGMYkViIlyE6iEthdjDQ+ey2SkyRBKM0BzoN63EdfghRDOQB9thPhC3h60WjoCiPh4cVcPD85sCzTFUjXmaGhKzIdp7+5nRllqp9cUKjhyM4DkBbEUypDdEuEPpvPzJl4sX5UYqmCax+kkgMPpX4opcU9Gdv23W0ne/+4ei0v6wJycYTKr/3v/hf2B+mch1MnLe+S9V9nthPKeuHd5dCSS8m5pr7WzofK/rK3zrQxhjtvS/nSIjVSW3OctFjMfH4cf//Gd4mtFHthvoqryj4wV9PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRm0/b5icNEno6ag8tarGsYKT449i+UFp4ldmwApAMw=;
 b=PUdEEbcECfDETgX59Auj39azQm4zuz3V6CJcja7eV2/u/U3djsZfpI2dGDnOa9sMXodpqrPLURYPYJr9YKOMaFlUC0fBYIsLAodsk0fQndZmfpBPNz0E47Rnbb/GsyuK6ooE+R5Rc7HodKov/vlNhkH+SNwCNSTnz2yPixHOEHM=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by SJ0PR10MB7691.namprd10.prod.outlook.com (2603:10b6:a03:51a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Mon, 16 Dec
 2024 19:38:07 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%6]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 19:38:07 +0000
Message-ID: <bec218e5-5b60-47f3-935f-2cad59e653d9@oracle.com>
Date: Mon, 16 Dec 2024 19:38:00 +0000
Subject: Re: [PATCH 0/9] migration: Drop/unexport migration_is_device() and
 migration_is_active()
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hyman Huang <yong.huang@smartx.com>, Maor Gottlieb <maorg@nvidia.com>,
 qemu-devel@nongnu.org
References: <20241216094638.26406-1-avihaih@nvidia.com>
 <934927b9-eaf5-411a-8151-7617218d0cad@oracle.com>
 <7d753d6e-a71c-4442-96e2-fbf1fd04133f@nvidia.com>
 <a0e99b1b-f708-4e08-aa14-9fddf7da6184@oracle.com>
 <3fdaf6c9-920a-46a5-8409-518022b17b04@redhat.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <3fdaf6c9-920a-46a5-8409-518022b17b04@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0057.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::14) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|SJ0PR10MB7691:EE_
X-MS-Office365-Filtering-Correlation-Id: 8836124f-fbc4-47c4-10dc-08dd1e092a9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RGVTb3hkWjNyS3RtR0d5c3ZCVGNHbWppaHhISWxRVHlSaEo0TVlRVVViT1BU?=
 =?utf-8?B?M2dhczRKSW4zSW1rdytNanMwbzdRYXkwaFJsUzVjQTJIWmIyT3d2VVA2cHlC?=
 =?utf-8?B?QjAyNWtiYjZKdk5MYVN0cksvL3JKa3RmTDBhYVlnZ21JWnpsem1tVE5HVVlG?=
 =?utf-8?B?YlNxNjRKM3FNcWpRaXZ4aTYrcklBWHp3dytmQVM1cWd1QkdGV2NyeGV3WlQw?=
 =?utf-8?B?aUIrdkZyanRxb0RyVndGMy90SVZ5MTYyUnNkeHhhNzRFd0tIU29oSmNHY0Jq?=
 =?utf-8?B?TW9jd3cyRzVvOEkrL04yYkJMZEhEVEoyeXQrbUN0VTgxN2MrTlFzenpGbVhR?=
 =?utf-8?B?WmxKeEtCaEZZQUttYXNrdElVTW9oYnpkUVlqR2ErTm1CNVRPMXRkcXhRYVI1?=
 =?utf-8?B?c2FrSUdQdUFhUm4wZjBVNWNiUW1SMXRrVEszRWFma0N2SkNBWVdTaHlIdGJ4?=
 =?utf-8?B?WU9aWHJZUlYrYU9IMWNNSDk3TklsTXFqUkFoaVBSQms0MTk5WHBLaUN4ckNF?=
 =?utf-8?B?YmpXZDdtekF3NjJmRnRFSk5EbWczNGhkbFhscmxhajltRFFhcnpLaW91YzZy?=
 =?utf-8?B?RVN3YjBwaEVRalp2WnU3K1BDU2lLMm9VV1BWYnNvMCtQN2hOcGV6bDZ3MXBL?=
 =?utf-8?B?YVZWeEljMURnaHRYQWJDN2tRTWVGcHdDVEpUSWxJQml2QlYzajJnTlpzVi9J?=
 =?utf-8?B?bjVWZy8rSHAxTyt2c1RhbXg1NTVuVDVCbTlPRVJZT21rTVlxK2VHUWR4eldp?=
 =?utf-8?B?eHdnUHhWK0dGRElSMDZTVGp2YjJnL29nUnZUU29vMDZNcEl3QVFzMWZSUC93?=
 =?utf-8?B?UmRDL3NBUDJTUGRQcWsyL2VDWkcxakZsa0NpQ2huOUtpbDlhVTBqWFFwN1BD?=
 =?utf-8?B?OExmRFFZVWFIcFlRdlUrcks2NGJZc3BNajB2YldiOVRXS2JVRXdRSWFpbzM5?=
 =?utf-8?B?ZFZ2aTBhVXprdEFJcmZxUlI3d0tUMmZkdnVDbWR6bkpIYjBLNWJZb01KQlha?=
 =?utf-8?B?MEVCa3ByQTYvaFRHSVV1RXQyb2lyaFBDZjFXVlQzb1pKZElGRGxiSWxVaU1T?=
 =?utf-8?B?YkJCODY1aVVKaTlsaE44dmdBb0Y3RHQ4U3BXYnQyM3BjSDQ4Um12MUpuZVpi?=
 =?utf-8?B?VEJwZGVJRkNBYU9aeDBYci9BMllUbmFLbmJRaWZVK3phM3c4N1dvTXhMREpD?=
 =?utf-8?B?VUdxdm9ieTczZWgwMkRwVnp4MGZ6NG05TjUxRU5KcDFKb1UwbDErU3NwQUhs?=
 =?utf-8?B?bFVyV3NUbVIrdDJNd3A1dnBHV1NINnJVWmtKTllJdmltT0cvK1lNalZ0OGw2?=
 =?utf-8?B?WlA3QnErcDA2TzZrcC9Ya0U4Q2JqcnZBZjlpRWhuSXpmTkI3bzJKbzQ2aDgw?=
 =?utf-8?B?dDRmWnBrNVBYeDRWQ0ZIUEZ1bXZFUDRFYWcvZGxMaW52WVBnVk1WV1Nob2Zt?=
 =?utf-8?B?SXhVblNhSzYzMElTVHA3NmVSMHB6QVlESmI1M3hTMDZlUkZKeXlaSm9KTnFJ?=
 =?utf-8?B?WnozNEZkSzV2UXl1YUN4RjM1L0U2OFV6ekZaTkFMR0JScmtWVXJ6cTJkbU1M?=
 =?utf-8?B?L0NjemdBZ3FnR0c4dVo2WjRqUDkyRU52bHg4dFJEbEdsV3RZdmNlemZaUjYx?=
 =?utf-8?B?cU0yYXY0Z1o4aldEZC9xSVM5VkYvbm5CY2tmQ0JuN1l6bVJ5MXkvdklwcjBw?=
 =?utf-8?B?eU1tc3RQU3cweS8wMzRaRFNlY2JrU0d5NjlON3Vlaml6dExvRDlldHVVcUl2?=
 =?utf-8?B?NytxYmlRVkhCQzdFcUlURDNmSUNQRUdSOWJ0QkRzdHlHL0JOS2Nibk80WXh4?=
 =?utf-8?B?eGw5U21zL0M4Qk92L2QyT252cGpwZmZwRTBGOXIwaERiK1RzcVh4dGFTVU1P?=
 =?utf-8?Q?hMHnj1SdoItmq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDdmb2dRRjMyUlQwZllZRVZpOEZzWEJGTUxPV2huMXFOaEp1ZXp1cm9xZlhG?=
 =?utf-8?B?cEh4U3R6amNiR0hoMTVjcytjeFEvN3JpZkJsZ091TFlBTWJFWHQ1ZllSRG01?=
 =?utf-8?B?Y0U5VFJNS1h5WFRJRWxPN3BUN2Z0R2Z3N3hzTHJXNEx1MGRsNWp3RHFsMTUx?=
 =?utf-8?B?T3ZCZDRYcWdrL3ZTUXBBdWw0SFZYSkxTZ1hzVWhMdjBCbm9vV3JBekw3Rk1J?=
 =?utf-8?B?U2hvNjJsYTJ1eFY0NExUNW5UZ253c3NUZzZhc3BIV1FKUCtWbm0yWHNFZ3pv?=
 =?utf-8?B?SU02RVFHWG4wcG1mYUFRV3d4M0pxVm5rTWd0eCsyUUFCa1pBS3NjUkxKTEY2?=
 =?utf-8?B?TlluVjJwQlBzRnRKakJHNk9vQ1ZJUzIyVCszZ3pXak0vUHhwK0pqRFZyNDIx?=
 =?utf-8?B?ZGN1VVVnSW42YTEwbW12alRXcnAyLzJJQWwvZEZOZ1MwcG1XZGYwcnd6Kzdp?=
 =?utf-8?B?V2Y1ODNXRVBNdUVNbUlVSDlLbHR0R01iNlFlWnk0TDNUSUxCNlpEcEVqaWFL?=
 =?utf-8?B?RUFjTDcwZzJVaWpsc3hDYTlnY1hOaEZPQmRiSWI1ZkVLTy80WE41d2RSSXZj?=
 =?utf-8?B?OFRmdUVtVmhweVVuOURnOGJZVGJ2NzNvYXlmOEtGUHRtL08rdG9sWVN5WTds?=
 =?utf-8?B?YittTndGWkl4c2daMEpna1BQWnBxWVBXYTZuWjlQWGhiWjQ1T2tYZ1ZpNFZ5?=
 =?utf-8?B?VGtPRldsMlFiMFZmYVpKaU8yTU5nblZLc2p5cVpXOWsrcEl1SFE3WE9PeENa?=
 =?utf-8?B?bSs4Z2Q0NC9XeHE2bEF1aHkvTXNla3hWaGkvaDV2Nkd2d1lzQU1VZjdHajFX?=
 =?utf-8?B?VmZwTGZFUjZ2Q1ExMjJRakpGYTNlbE1BS29FMFBYS3B1ZDFnQ0p3K0I1d2Jh?=
 =?utf-8?B?OEp0Sk9TQW9uSjFOQWNXdWpuREpaWWJ0R3FQaHdwN0h1YWFiYWRsWW1XN3dU?=
 =?utf-8?B?ek1LSWkrakhycGlLRWpNaFdObzNrY0JvNXk1WDNkTlpSMjdONlAvTk9ONGpJ?=
 =?utf-8?B?QTRwWXVWVzBBZlM5Y3JHaUxhVzFpWHcva1hsbHY0UnllUlY2SWxSYmRpbW5M?=
 =?utf-8?B?RDV6SUpQYnIzdDRPdEEvNzhaR2Ztd1pSUExUc0I2eHpEaThjVTVNZmRTQ2pQ?=
 =?utf-8?B?cjcxYUkrN3V4YmdKTVJkQjZySnhzbVRjWUFnMVdSV2JrSERKWS9tRU9CU2g4?=
 =?utf-8?B?OGlTMWdiYldScnpaSmg5Y0NnQnM3MlpCQkFPOCtEdnBWTnc1VHY4NU1PSXlE?=
 =?utf-8?B?SGlHR21JVnViMkphaVhPTzVPSkFrcitNa2J6UENNVTA1Uy9INFJYM3REV3R2?=
 =?utf-8?B?bkwvak4wQXlkUVVwQVBNc1dmMExPb1U3a09HUnlqVFpTQSs2OUdzNGgxb2xm?=
 =?utf-8?B?V09uTTRLMkNWSktQdWFhajJFZ3VQVndCTnhyTldtOHlCdEtGSzVxMU5ocnRx?=
 =?utf-8?B?dVo2c2s5amhsU3NVWUl1SXVlTXVFc0xybE11dk0yaXFma0d1am5acmg2TFpG?=
 =?utf-8?B?TnhENG9aU0lyMGU0eVQ4L2JlL1V5VnF4MEZaN1VHcUtDT0VYNnByVU5WTmdC?=
 =?utf-8?B?aTJIM0NmM3Vmc0ROeVUwVmYwaFhhQm1ZbGRoYzdFN2pvV2hSTVJqcVpNaEsx?=
 =?utf-8?B?MXhqam9SUGNqUjdFSU1qSE9MS245eEZDcmZvTDdwdFQrazEzTHp4dW9lV2k3?=
 =?utf-8?B?YVdzc3hPTkhoT1NlZ2xKUGJLV1Zua0xJRHdYWk16V1BDOXJva1NFZ3VZVHd6?=
 =?utf-8?B?WmcydzRMeU9TaEtINEZsUHZDWHdEM0RtbHh3RGFsS0lubFBFTEJ6ekprR1dG?=
 =?utf-8?B?VlVSVkQ5UjRRd2xQVDdGNFBvZFBkdEtBUk81YU9laFFkZUo2aU9oYTdZT0Nr?=
 =?utf-8?B?U1diU0o0S09MVFNnYUY3cTI2L05rZHpVeFZsZTFrdzZXTVkrWHZ3YzE2TVRQ?=
 =?utf-8?B?NjU2Tjc1dklUbUFORThiWjYyekwvT2JqOGk5TW9Cby9zSE82bHd0eUhmQzdH?=
 =?utf-8?B?VEVXK0hnS0RMaG8vK2VCMHJHQ2hCOVRCWnhKdUltNWtFcjlMWE43aFkwRmFN?=
 =?utf-8?B?MTZGanNVMTRHZVlpUjlXOTlkaUo4akhvbzNKVFZ4SDA0M3UrWWZteDVWV0xt?=
 =?utf-8?B?Z28xZ0U0ZWp3czBDdDNDcHJxeGhISjRxVElab2gvYkVIcSswcTZqZDJjajNG?=
 =?utf-8?B?dUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: eoyYiuQbMJ0QDgUThi7YoMj5Z+FB5f1FvzqgpVhX3vtIqIUSNmFKVD68haEe0bmir3VWLSvMVFvMPLwDC+j2uzXdkqqx/vnHzqZkLd80wo+yqJslSbx0KZn5XnEA3ZOYrn4eGGvlVU3Ue7q+rN6BeRFEuhuM27TomDW/PIPauEvrDwPdm2LzSHzqLYnyKNVyK0r2LxKQqjsG9v1cNVAZ/bN9I6uRU1AOEOYY2GHvAWKe9RmtD1Phmp4a5TuVCdqhj6YsHEYL4eB+WFSNWkFzZR3PTPTII4M989FR8uM/aD3EUpW521FUjElVgX0AolaesF1BnFlyOME+7B4ZoS20IKnBScBZeE/BeZc1YlY3zKJADlodm6oUXD3wBd/jiDt9xDKETbD7GS7NF5/7sYfV4oDtR7RwyvPR0UCxJFKPzxDySnHDfgBkJUgYWfr8CR3tePRSM0GpX3Z8FN4XS1x0nR1UqBGbnn231CfTxaXodPMTLKSvtXgxxfZA/A8aNfISCkT6TymoyKbecsM0HCc+KI+BpctlrUv5iKqYBpywRTfo2Nia01dRX1PICsJwIq62dTHbxu6TGAbuYF04Cib6fdkOxp8AHZALMEGi+wYSdIs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8836124f-fbc4-47c4-10dc-08dd1e092a9e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 19:38:07.7815 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x1YAEPmO35qOlRTKBTVKDKd5DtI7C588RNODIfZK/C+bLQGqfKMKViS9keBhL8dWyY9FZzDQWMEAx0GLa9PSrvTHYteG0CeoF2tFfcZu5r4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB7691
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-16_08,2024-12-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 suspectscore=0
 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412160162
X-Proofpoint-GUID: vRy6vrUZ5qIuOlQs3OtEoujd13NnTmMK
X-Proofpoint-ORIG-GUID: vRy6vrUZ5qIuOlQs3OtEoujd13NnTmMK
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 16/12/2024 17:33, Cédric Le Goater wrote:
> On 12/16/24 16:37, Joao Martins wrote:
>> On 16/12/2024 14:45, Avihai Horon wrote:
>>> On 16/12/2024 14:00, Joao Martins wrote:
>>>> On 16/12/2024 09:46, Avihai Horon wrote:
>>>> I also have a much
>>>> smaller series for that sort of unblockage that I can give you a pointer.
>>>
>>> Yes, if you have it at hand, that could be useful for testing next versions.
>>>
>>>> Though, eventually the optimizations we will do for VF dirty tracking for
>>>> vIOMMU
>>>> will apply to IOMMU HW too just so we minimize the amount of calls to get dirty
>>>> bits.
>>>>
>>>>> I didn't test it with iommu DPT as I don't have access to such HW.
>>>>> Cedric, I remember you said that you have such HW, it would be very
>>>>> helpful if you could test it.
>>>>>
>>>> I am starting to prep the unblocking vIOMMU for Qemu 10, so I can validate if
>>>> this series works as well -- but from what I have looked so far it should be
>>>> all
>>>> OK.
>>>
>>> Thanks, that wouldn't hurt :)
>>>
>>>> If it helps I have some pending series that lets you test emulated x86 IOMMU
>>>> DPT support (either on intel-iommu or amd-iommu) that can help you when you
>>>> don't have the hardware to test.
>>>
>>> That would be great, I didn't know such thing existed.
>>>
>>
>> I did post it, but it was some time ago (2y). While I got some comments, but
>> failed to follow-up:
>>
>> https://lore.kernel.org/qemu-devel/20220428211351.3897-1-
>> joao.m.martins@oracle.com/#t
>>
>> The link above has bugs, but let me conjure the version alongside vIOMMU and the
>> other stuff I mentioned earlier.
> 
> Please Cc: me next time.
> 

OK

