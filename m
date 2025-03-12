Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AA3BC28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 07:46:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsGls-00031z-Mn; Wed, 12 Mar 2025 03:44:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tsGlq-00031A-Bg
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 03:44:54 -0400
Received: from mail-dm6nam10on2060e.outbound.protection.outlook.com
 ([2a01:111:f403:2413::60e]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tsGlo-00084t-4y
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 03:44:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ooGW9mJXJ3020dE6Ct25kHqNK4cDiEqbFHDgvNaL6j29JPY9bZGX8vediVtKL29DRtw6ti5xxVLBzFvc6iEOLD9w4KCaTwEPUaJkz83XXDnloVL3j4iqeEofzC96d+FOjcx44fCdVpX4GoeH717Tu7QMserw4q0c/uKVQwhJpnVmF1PvB8z2CfvuvTNf2cCEH9wx7l3/3JywL72UaefxUYL6inXfggofs+L1nJUNFbyK5v3hvhVlPyi0kZpj7eM9Pkk320jmpaN5uw6Tse8MtKryDh7Odr1hakQz31XCHL29noPPTXlBvovhETZNRKIfesyyPSTsl136o1BhAK/u/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQXG3F2XbX5SC+OpF9/gF8UzlU7y++/QRZ0V2bWu3fQ=;
 b=n2lw/tUUHoDS2ufD9JWnRSH8b6FzUl+hsiu9498QUbYnKOpJlXAAt7hy1KO6AIwDDvOe6mqFhzJnPlb+fjMcr3Z6TkKCIumqNe8ElZ9OYg6Uz/gxxEwUZviigzWLwdPzkhfwfrLW7Rz/wLIv8lpuWwgbnnxwSqLlXJeACU6eAd2OunE7SZX2McAv90UjKv+dM8yvhSyEmMekVy/r3ruOceaQMmhiDfXn23/0bE0fFCsE1eBgsjv+tfsVL5aDcp+NyUSvSWvn/Xj5/hnVbCetkZQF+mbR+A5K1WKiuRldCien+weP+oN1Cu7Jn1741q+XYdMzx843dp4grcBZkN8RFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQXG3F2XbX5SC+OpF9/gF8UzlU7y++/QRZ0V2bWu3fQ=;
 b=MZsZGYJKgMPJzpBl2b36oRmR1WPThst8grinFKNnWyq0mlil9l5r0dAqPfHU7d7s7aj5NdZVU575CCgj8/LPlD/jqn9GgFjfsDk2FDxGxaIQHkmF8IU5L5A0eCofGxjdfRZ4I6sIBISo5SwvBRsQVUglKFg0uapDnWJAD2t3rLdndFIVI4QvvxHswFggMgAbhNy5iA2bqp/5ApyprDHRkD2CdXHZWey3/S+6xwzypJe1qAfnaEoUcD/M4udZbx9meR65ob45zpiBCnf2GXeaj8tWx+rxqFmbF+mKLret66lkaAw5QdCQTi1q3PbSUq0TvWQvavtPHUuCXC7F+JjB5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by SA3PR12MB9091.namprd12.prod.outlook.com (2603:10b6:806:395::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 07:44:47 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 07:44:47 +0000
Message-ID: <9e04eeaa-a03a-4411-b559-f4575565259e@nvidia.com>
Date: Wed, 12 Mar 2025 09:44:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] vfio/migration: Add also max in-flight VFIO device
 state buffers size limit
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1741124640.git.maciej.szmigiero@oracle.com>
 <2b2469939198c2f31dba33b284576d2df22697b7.1741344976.git.maciej.szmigiero@oracle.com>
 <abc049f2-3497-4557-89c8-74bcfaea221c@redhat.com>
 <3826d47f-d79b-4db2-9719-35f48f582bf0@maciej.szmigiero.name>
 <fc547687-b313-404c-a6a6-dd599b0a9dbc@redhat.com>
 <bdd69682-3d0f-4687-a8a5-43a6cb4cecc3@nvidia.com>
 <fad3dd28-d91e-4add-8258-5918127e9346@redhat.com>
 <538afa76-7456-44b9-abac-c238dbb0e64c@nvidia.com>
 <4c5ae74a-3b4f-4b60-a93a-7e9dbaf974a2@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <4c5ae74a-3b4f-4b60-a93a-7e9dbaf974a2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0426.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::30) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|SA3PR12MB9091:EE_
X-MS-Office365-Filtering-Correlation-Id: 88d6fa2f-9269-461a-a3fa-08dd6139c33d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ODFXSlpvNlFITmowQWVmVUFOOXhybFRKODl5VU9zR3ZIR3VUVlVaS3dVOXFV?=
 =?utf-8?B?aWdMcjJwbFE4ekcyYlN3KzJ5UHRlSStTZG14bGUvenNEdHYyNXdoWVJIUis1?=
 =?utf-8?B?YnJObjF4bXN6STJLREEwS3N1WWJyZWptMThUdkRHTlVMZmdzT0UvUEFxU2s0?=
 =?utf-8?B?OTY2SEdybDJHL0U3UGptZmdDWHpYdDczMTFlcXBJNGszYlBtWlM3cVBSbzJ3?=
 =?utf-8?B?OFplZUlTb1RuNStkNy91eVNHc2VGcnh0SUZwTk5BN21zeDVjck1yMU01aW9M?=
 =?utf-8?B?dG84MmplY1g4WDYvQzRqNXpEN25DZmg1eklQZFNhR3RWNmtyWm1DNTErS1V6?=
 =?utf-8?B?elp4S3ZwNlk0RGdyakRSb3k1VXM0N0NqWEkrUXphSE8vZ2hROWc5MWNuMHMw?=
 =?utf-8?B?Z2prK1NKWHZYOEdVK0puTmtrOTdtd2pVSU5TM3BBbkRSVSsvR3VxSTdwamRD?=
 =?utf-8?B?TnJGMmd5cHQ0bExSa0xhNDR2MVN0bHpSZ00vS29NWWJod2U1TjZVN09VTzhs?=
 =?utf-8?B?ZU91Z1hlL0tPNG1DL3h0dldPS1NPdjR2YWttaDhobVh5Tms5bXNrUGNmdldx?=
 =?utf-8?B?a0hrZkJFREtCZWdWd1pUZ2V4WlFHV21RWTFXdWxsdi9BcXpIbjBLbUNySk1n?=
 =?utf-8?B?VmowZForM1hvNXBzRmZWSlJvYlNDMGo2cXUxM3pqcXVRTStnOVVOYzNlM2Ft?=
 =?utf-8?B?WENYOEZRaXlPYXNJM0NMSk50bFdnK05nNUFjcytwZ2lSUE9TbVJSa291MXFQ?=
 =?utf-8?B?cldWYVZPWkYydmU1cjdXbjZiZW9JdmE1bkRxMWl3cmhHYWFXSlhSM0ZUMW1l?=
 =?utf-8?B?ekh4NjYxbWJpMStWMU56b2N4ZjlrR0hIMHp1VmRPUWJTWnBMS2dMOVZObURL?=
 =?utf-8?B?anI1SFlPMFJVaFdXSG5rcTlpQzVrbzdycGFXQ2YzdUg2YXhraHo0K0R1M1pk?=
 =?utf-8?B?S2hUK0dHQzJHd2FhRkRCZDlPbzl0eVVtcWVETUZobDFIRXZSWFNkRmNXdU1u?=
 =?utf-8?B?VEI4aGJuK3k5aEx6VEltOWpCNUc3cnFMTExVQ05vcHhwak90cm51TjArNWoy?=
 =?utf-8?B?d1dFRzROa1hmaS9lM3o0MWgrK2lUaFJvc095NnUyYkFhUER3VUpXK3luekdI?=
 =?utf-8?B?OFJsQWZXekJOTUUvQ1hLSkw5dUtDYlNmRDhCSHBObC9oWGVNVFBkdDdZV3ZH?=
 =?utf-8?B?M2IxVTF6cFJWKzRkRFZQZjcvd01hWXlROXpaU3RzSDRJYzU2VUM2d1JXRlBy?=
 =?utf-8?B?Slp2OE5DaGJxNVJBTitMQWQvYXJ4emdtZlpJOGdTVFJJdU85N0xicXNhMDVY?=
 =?utf-8?B?cWVaaTBWMTRmbklqdWZ2L203ejhHZDZCSmZwcE92eEwvRUF5eXRadkhvcEFG?=
 =?utf-8?B?bk0xOEoxTk1iT0R6RTBQaFZlNkhOUDM4amZXdGtNL3BmQWpyZkpXZ0QyYW1S?=
 =?utf-8?B?VmJqUDl4Ym5abHZLcDY2Y0RaVWcyY3c5S2VMZHVwdWlXSk85dE15Y3RxSkR1?=
 =?utf-8?B?WjFSQkhIRjVXN3c5MjduSnhyZENIdkZSd3RzLytXdjlNemJVd3BlbUxmWjZB?=
 =?utf-8?B?cDRDNnRCN0xLY1djNG5SWllmUS96SzN1ampIUHI3bjB4ZjdqeEt1Q3M2VVFP?=
 =?utf-8?B?ZGxsV2lZWlBRRTltRlZ6cGFTWGNjUXdBTlpVOUptelp3ZkJwY0NTOFNVTXk2?=
 =?utf-8?B?elQ3KzJsM3crYTFsK212ZHdZcnBSeWJ6b29QcjFRUUFjSTY1UE1DZmowY3N2?=
 =?utf-8?B?T0JhS1BHL1FQTUxRZmFGQm1JelRwZXB6ZkJQUlRra1pzdE0veUpUckdLSHVq?=
 =?utf-8?B?QUs2Zk85YlVobmVIckF5Q0cveDdOd0g1NW4zbU1mUkthRUViRG9MaHkzZU5Z?=
 =?utf-8?Q?O1geX0h8Ex7ic?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWJ0cVBYZVZtUnRhQ2txOUtSWXVudlBnRVpoQlNxTGx3L3BId202QVg1cmVY?=
 =?utf-8?B?eU5kc0E2NG8rUG91YUFFbkxOQ2QxR0xtNllVTXIxdmtBV2IzbmV0a25SWTlH?=
 =?utf-8?B?TnQxRlJET3N4Wi9DbDNaSTZGUTcwNzF1amwvdzFPbzdyZ1k0dTIwZWVSbkRp?=
 =?utf-8?B?R1dDWnlVQ0QwSWJhWk8zcERMWEY0d1JzeSttREdNcG9XWEJSN21uMHU5VlpJ?=
 =?utf-8?B?MHZVRlRFUmgybDR0TlFHU1JNOWc4QlhBSlk1aHhGdzhuaFovY3hEcncrN24z?=
 =?utf-8?B?YVVrd0M3RTZJcGFWaVFCWWt3UnZJb0RFU2lqTTVtbzJJaXRxUDAvQ24rWEt4?=
 =?utf-8?B?eFJHVVBjTVhQWFBjSEwzKzlsSnl0MmV6M2RqaDBaUnV0ZUM0QnpqL29jQ0RB?=
 =?utf-8?B?VjVZdktuYUlKQUE2TG56WGxmeG0yckh3UW5JVTdoTVBGb3A2QU5pRkJWcGFK?=
 =?utf-8?B?M2JQRXBkS1dRTlRzZ2kwUHNJR2J1WENzYjJ3NW9pQjlMbVFVSmRINktYcGIv?=
 =?utf-8?B?VEhNeWhrOTB6UlBxRlNpeDdiVjdEd29jNGE5YXRpWWlhYVdIWXNqcExsMXp2?=
 =?utf-8?B?TnpnR3ZXbzNhMHF0enFaa3dSbzZFM3JraTJkME5WbFNOemhuRVNDWXNKV0pZ?=
 =?utf-8?B?NkRtRVBSM2hzcTdYWkRObUVyYnRyMi9QdWM5cGFmYjlWbUNoRFFGYWNHR0Ey?=
 =?utf-8?B?d0NhMGc0ZlFNdHNvTHQ3MUFLSlg3a0lQbzNpdTlEVkNaNmJoR29uYUprWEZD?=
 =?utf-8?B?dVJ1YkdYU2xLLzFoN3JlZS9mVk1Xd3YvOEFDeDJNNUJyV2p2eURXNFZlMmVi?=
 =?utf-8?B?TFIzMkRieHRtNXRxY3BFRk9aYjFmODJXdUF6QmNPVUF1S0dWd25saGtSR2d1?=
 =?utf-8?B?NTF2ZFh4b2lFTU10dTFzU0NyU3hOUm9CaTNIYWpVMExuR1NEem9uRERMeFkv?=
 =?utf-8?B?L1RSQ0tkcWJWN1BFODc5azFyMHQra1pIRmt0NnNHV1ptUng0WmpnOWxIZi83?=
 =?utf-8?B?WGNhWlB1SzdUSmdIYklPbk9Jcjg0YkNURW5TK2s5N3RrUVVoZk1XSUpNRmJu?=
 =?utf-8?B?MlMxTjdLaVZUUFZ6bEZqYzlHWDBGaElncUtUa3F4V0Mza0wrYzNaWm0xSDc3?=
 =?utf-8?B?aEVxVkhiZkxNelZRRFFlQ0xlMkwreElNd2xwZ1lvYkJOWHkveVBHU0tTbWZM?=
 =?utf-8?B?Ynd0U3BnUnl2eFlkdHhjbENIN2RXS25xRXYycERVdDEzMjY4SnFXY251MHh2?=
 =?utf-8?B?cWYwZ05zY2pjclZTMkhPWHhnWXNKYXBQcW93VjdnSW96TWZnbjRVRHVCaFlU?=
 =?utf-8?B?VTVCSkxWanNCdUduVWYwVE9ydHN3NGwyanF2SzVwOUVqN3Y0bUtqYUxSYjRX?=
 =?utf-8?B?WENuV2pYdTRDV2dKc1V6eXFCMjY0eG9wSWtwQnhQTjUxODQ3MjIySXpieWl4?=
 =?utf-8?B?SEZ2bThtVlFzQkwwT1cwczJudVFEemE5Y3A1cmU0N3dWMEV6S1hYU1F0ZTZB?=
 =?utf-8?B?L083cFJCeG9QNGk0YktWUGd4cllSNzdCeW9UWTVlMDNBQWRSYWIxelVEZXJB?=
 =?utf-8?B?UHZZc25hTUdzMnErai9UUjRNbk5OU01aTStSdkNMTkhUenZBaG5GMkNqeHR0?=
 =?utf-8?B?WnU2MFlYSElXamQ0Mm4wTlJ0S1pTME8ybTlobmxTWlVaNFYzNlVpRml6dzY1?=
 =?utf-8?B?RmhtU2ZzdXZ3RDd0ODk3cFFJUGNOS2pGY1VrRUtsNjRuWEJxa2NBdDk1Tmpw?=
 =?utf-8?B?c1g0TnRLN3A5TGJqNlQwMko2eVhQZTBiZXcrL1p1RUZoUHFlQVF3K0ZsYjUx?=
 =?utf-8?B?V0JYbjRyYUJvTzlZLzhqRkF1aDVzcmRNNGh1US8yQm5BN3ZjQy9FYlRLRFJX?=
 =?utf-8?B?cCtzNllmcUJnU216R3NJRHpzdXFWcjc1aTJGdk5RK1NLZURESCtmUE9WZnpm?=
 =?utf-8?B?TDlVa01yNTl6akNxb2FsZW1tYml0NXlmUjNheGxCSHhXMkg0R1UwczY2VG1q?=
 =?utf-8?B?aFYra2NYRnlXZis1LzlEaEIzTnhaNnBvWjVhcS9BUEJyQVVsZGVTb2NxRWw4?=
 =?utf-8?B?THBDc2xkdGhWWUtiNjJSOUJaaS9INTB2RTN1azFXNFp3WGlHSVloTVlKQVBU?=
 =?utf-8?Q?DjiWXH1x4FxDimk6+pld0cSrR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d6fa2f-9269-461a-a3fa-08dd6139c33d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 07:44:47.5537 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RuzmSCis1u5fo+C1i2sTj4E4xAu47scq/JRpIPmISWnHRXoEOuDroa7y+nn+kCs8kDt+XqCorfuFSgVQ3aD5mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9091
Received-SPF: softfail client-ip=2a01:111:f403:2413::60e;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 11/03/2025 18:05, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> On 3/11/25 17:01, Avihai Horon wrote:
>>
>> On 11/03/2025 17:45, Cédric Le Goater wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On 3/11/25 15:57, Avihai Horon wrote:
>>>>
>>>> On 11/03/2025 15:04, Cédric Le Goater wrote:
>>>>> External email: Use caution opening links or attachments
>>>>>
>>>>>
>>>>> On 3/7/25 14:45, Maciej S. Szmigiero wrote:
>>>>>> On 7.03.2025 13:03, Cédric Le Goater wrote:
>>>>>>> On 3/7/25 11:57, Maciej S. Szmigiero wrote:
>>>>>>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>>>>>>
>>>>>>>> There's already a max in-flight VFIO device state buffers 
>>>>>>>> *count* limit,
>>>>>>>
>>>>>>> no. there isn't. Do we need both ?
>>>>>>
>>>>>> This is on a top of the remaining patches 
>>>>>> (x-migration-load-config-after-iter
>>>>>> and x-migration-max-queued-buffers) - I thought we were supposed 
>>>>>> to work
>>>>>> on these after the main series was merged as they are relatively 
>>>>>> non-critical.
>>>>>
>>>>> yes. we don't need both count and size limits though, a size limit 
>>>>> is enough.
>>>>>
>>>>>> I would also give x-migration-load-config-after-iter priority over
>>>>>> x-migration-max-queued-buffers{,-size} as the former is 
>>>>>> correctness fix
>>>>>> while the later are just additional functionalities.
>>>>>
>>>>> ok. I have kept both patches in my tree with the doc updates.
>>>>>
>>>>>> Also, if some setup is truly worried about these buffers 
>>>>>> consuming too much
>>>>>> memory then roughly the same thing could be achieved by 
>>>>>> (temporarily) putting
>>>>>> the target QEMU process in a memory-limited cgroup.
>>>>>
>>>>> yes.
>>>>>
>>>>> That said,
>>>>>
>>>>> since QEMU exchanges 1MB VFIODeviceStatePackets when using multifd 
>>>>> and that
>>>>> the overall device state is in the order of 100MB :
>>>>>
>>>>>   /*
>>>>>    * This is an arbitrary size based on migration of mlx5 devices, 
>>>>> where typically
>>>>>    * total device migration size is on the order of 100s of MB. 
>>>>> Testing with
>>>>>    * larger values, e.g. 128MB and 1GB, did not show a performance 
>>>>> improvement.
>>>>>    */
>>>>>   #define VFIO_MIG_DEFAULT_DATA_BUFFER_SIZE (1 * MiB)
>>>>>
>>>>>
>>>>> Could we define the limit to 1GB ?
>>>>>
>>>>> Avihai, would that make sense  ?
>>>>>
>>>> There can be many use cases, each one with its own requirements and 
>>>> constraints, so it's hard for me to think of a "good" default value.
>>>>
>>>> IIUC this limit is mostly relevant for the extreme cases where 
>>>> devices have big state + writing the buffers to the device is slow.
>>>> So IMHO let's set it to unlimited by default and let the users 
>>>> decide if they want to set such limit and to what value. (Note also 
>>>> that even when unlimited, it is really limited to 2 * 
>>>> device_state_size).
>>>>
>>>> Unless you have other reasons why 1GB or other value is preferable?
>>>
>>> none but UINT_MAX is not good value either.
>>
>> You mean UINT_MAX is not a good value to represent "unlimited" or 
>> that unlimited is not a good default value?
>
> unlimited is not a good default value.

Why not? It basically means "disabled".


