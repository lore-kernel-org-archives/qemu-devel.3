Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28AF4EE6425
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Dec 2025 11:01:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vatxJ-0001Ik-Hh; Wed, 31 Dec 2025 06:01:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1vatxH-0001EB-QX
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 06:01:27 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1vatxF-0002zR-98
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 06:01:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fMSpJZyLFdalj7iG6LEbZk0nJ91fHqTtGzmTcCSxRFdqDwWLz3j19nYoIsazkasHArWusWZVd/r+I4NvcNnweu0jljilwHKBEQOZnFcMkN0AJFlKlD80tVqO5xumoPLDnQomdsAzpTdFhnRrHNmtRxkpGpP7NUJVVt6fUY0jMjYCl7Or9PKWw2pfUlhFk8iBkAj/og/n1MGyaAiJvKC3QClfdCurnIr8Bw3bEsqPBmtnKT+SjYAYLZne1FHqG1m0nHWoT4SZwZZ8voAvQMSTQwhMAUdSC82rirPXfF9sSDFGilGTlLUtI8vxFSNzt1dLY3iPKY3Ib8wYRbIRTKexuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PnXphnnycFR9NnJSpprmktqpUlHPVM7yEEQ4qMHHpQc=;
 b=h3f0FrS2ss/AODswu6MBGzratecVTd4mw+MYU3ZjSAMZVKKFXtZeTMGkUbbK8Q3VqTqgufXaTWqB8X/HX8eGvz9dBf+rL0BdpupzqbkfOvwFmG9u4UgatRx/+Gnxj9cwohoIttxwG38pXCihnv5hmD8HpJaXma9lMP6v5qkD8Q91rCbNeaZ/hgUYfHNyWJSvDp1u+m/cTSIDceLiRdyMTXJz2wFD/UnPP/t42OgoRY4BK1OcgbhGmVg85oV+S3H45pCOuu9RRRvQB1MhgDzfH6q406Jv2GKuRPUPyB58+YboM9h0laHtDawaLa4cBl7OABnrl36XQ35SOYZeJeE+cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnXphnnycFR9NnJSpprmktqpUlHPVM7yEEQ4qMHHpQc=;
 b=YSdPp3D68SxC3tmqs5GPQznDwpPPylCMfQYDAPclgbMz7ZclMCTqqiwgi3awcj9URmw1NWw7oa9XiDxHQHpKkvx+sUw7ok8osEVm8c5DlpRgPwI/sp/4OD1U+SyWDRJkS4T92QkCqinMSdrffZ6xxIXp7t9m3H2jkpMmJTERrcngodEYPQwQ9hVIGZE3Y9ur+zIU05koPafyfQojwL41ajmR5bDAxcEnPrlIAjvcRPb4AQ3qxDJU7UKpy+7I6l3JEQ/XnGTHEAo4FaOqG3m9ILBz+UAZK0oj+ELwfZaJqHMLTFoJesKGeTotRCG5+w6Jv6K0wa/9bNaeZ1B1Dlp6Kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com (2603:1096:301:b4::10)
 by JH0PR06MB6920.apcprd06.prod.outlook.com (2603:1096:990:6b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 31 Dec
 2025 11:01:20 +0000
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::1b36:28b0:4e5:de66]) by PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::1b36:28b0:4e5:de66%6]) with mapi id 15.20.9478.004; Wed, 31 Dec 2025
 11:01:20 +0000
From: Wafer Xie <wafer@jaguarmicro.com>
To: mst@redhat.com, eperezma@redhat.com, jasowang@redhat.com,
 qemu-devel@nongnu.org
Cc: leiyang@redhat.com, sgarzare@redhat.com, angus.chen@jaguarmicro.com,
 wafer@jaguarmicro.com
Subject: [PATCH v4 4/4] vhost: SVQ add the indirect descriptors to available
 ring
Date: Wed, 31 Dec 2025 19:01:10 +0800
Message-Id: <20251231110110.18201-1-wafer@jaguarmicro.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KU0P306CA0010.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:17::9) To PUZPR06MB4713.apcprd06.prod.outlook.com
 (2603:1096:301:b4::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4713:EE_|JH0PR06MB6920:EE_
X-MS-Office365-Filtering-Correlation-Id: a722cd09-db61-4bb7-1dc9-08de485bed95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SlcvenU4QkN1UnlHZkZ2Skw2eWhlTTF0dFJlOTZtWUdESjBhTmwrelp3N1pK?=
 =?utf-8?B?dXRMdzFEM2d6OXBXOFlkUUErY2ZCMjArK3FLUzBGOGFrQktaNEtjaUd1bnZX?=
 =?utf-8?B?RTNZYm9lVmExdG9oc0ZJU1dwb2hqUndtKzdTQnR1bkE0Skppb01tM2VERWhQ?=
 =?utf-8?B?TWlSQlVUc1N1bkhYWis3NmxhVmNLWFMyT3Z1NEFSZG03UEtsNHU5UERKaW5k?=
 =?utf-8?B?aERJdmllWW5HRTBtT0NySi9UR3ZlUVdJVzRaUlBvcWFndEpsanVtcUN5Z1VD?=
 =?utf-8?B?dEoyVVJuamNZbWMwcjNmTVFod3VBNnVtMWNLWE5mZ2lEaHYrdlVVZTZ5ckRH?=
 =?utf-8?B?YWk0R0taWlozMUUyWUg3ak9UTlR6Ym83VDZ6anFqRDE3Tk1ZVmlNbm9BTU1u?=
 =?utf-8?B?ZG8yOWFVUnZYSkpOaUJRa2pwT20zMmlvK2UxeDBVOWZhMTJabXZKMnRVM2gy?=
 =?utf-8?B?dnV2NXNERTg1dVo4dDZ2Z2xmYTNjVWsvUHk0amVnY1FCYyt3MTNWSS9BRlU4?=
 =?utf-8?B?L1BuMCtPbm9obHJWbUQybFdPak9ZUjlJRk1qcTlmaXlHcHBiVmczbzVWSzJ0?=
 =?utf-8?B?cnBkNXBGRFpHSFVBMHRiYWdnWE5OQzNoYk5tUkZ1alNmT096dEx1ckd0QWxO?=
 =?utf-8?B?VEpweWdiRjRUVDhFc05mLys3Tk1WVGt5ZG5PQ0JLbkt4ODZLREZxbFJ1N3Zo?=
 =?utf-8?B?ZzN5ZlZQUWNiOXpYQmY3VFduOUY4RWZoUElEL25DZkFmMTM2L1dtaWxsa2Vi?=
 =?utf-8?B?MFRRM0VvdTFXeE1UOVEzUVRVSVgxdlZRNVU2cEtTRFVnMnBYdzg2Ym5ubm9n?=
 =?utf-8?B?REoybGZsM1NzejNQMDkwd0llYXRxUTMvcUdod3c5T0xDSmRMd3hRQ2dBSE9V?=
 =?utf-8?B?N2VabTlBM2tYTC96T2ZIK2lQSmxDS0tWZ3lNbmJUd2hpeGZNSDU4SStHanpl?=
 =?utf-8?B?SE8yUERoQVprVGxkWE54L0l2TXBmYmwzbWhpSmREU0VjemFMWjl6a3NDSzBP?=
 =?utf-8?B?SGF0Z2ZOR3ZaZWRXUHh2b2xPd3I1YUFrdjFNQi95OTlYOVFacWhMSTVFVXd5?=
 =?utf-8?B?RkxnbVNpR3IzRHJ4NTRBWGRSaHVJWVNPcm1tK2ZNdWpCOXd6MmtQRTFST01L?=
 =?utf-8?B?d2s4VWQ1U3NnaWhFV0N6T1c1eHZ1dERNRUcvYlkwREVQaXpnSDJ1U2Q2VkFo?=
 =?utf-8?B?bjJjS3ZoVGRqM2Q2dlZpb1F5WXpNYldPWEcwaFdpbDZxM29Md2hYNDkyaFFM?=
 =?utf-8?B?SEJ1c1ptN0FhdkNveldiTXp6MzlHdE00QTkzZ1htZnV2aDhwQW5wc282azlL?=
 =?utf-8?B?OFBsTFRIZ0lXazNoQUwxejM5YWNONms3eDhITnY0QWtSSldxZllPdjVVQWFC?=
 =?utf-8?B?R2lTUk1DRXc0aDV2a0ZXcGF5cmYvZDZzYWkzdm1qRFV5bS94ZCtaL2xXd1gr?=
 =?utf-8?B?dUQyRWw0a0JVNVdXZlVWT2ZpRmFRdlIwSHVOcFVjUzBZak5ESG4wSVd6bEU5?=
 =?utf-8?B?MHMvVlZPMFE1SjVLY2V5RUd5MUJ5cXFuSXhkdTkva0w0TENtSjZPcUVqbkkw?=
 =?utf-8?B?UnZlaWtlaUg1dGhKblJNQkhuUVczSEpUcXIwQ1pKekJjWVkwRlZ6cVA5eE9h?=
 =?utf-8?B?cnlVVjgwRWc1ZTJNYWt1S2l5NVNJMTBSUzBlcjcrR1JZaVJmazFMbTc1VERl?=
 =?utf-8?B?Y3N4VFBRRjZiZElseUw2ZGVab09nMlA3RGZ1WUlRbEpWSlVQb3hVd1NoVnN6?=
 =?utf-8?B?ZWdNbWNneTh5K1gzVWZPenEweSt3YnZoT1IrWWNIdE5obmtaSFBYSmRZZGdx?=
 =?utf-8?B?Ukxib1g0ZGNZR3NyMTE0STZwOG1BWEhTcDNJOUJiUDhTNFErTkl3ZnpKOUlu?=
 =?utf-8?B?dG5lVHZtSVozMkFzQ0RJWGoyb3NMb0FxejR5L1c1by81eGtvbWIwaFpFUGt3?=
 =?utf-8?B?V0hLTnlxM2ZEMGVaOVhPNUpUOUF1N2c5a3Q4Nzgvenpuall2ZUZGVnYwbzFQ?=
 =?utf-8?B?SHJBaHM5aUFGeWt5SWlwUnFqbnc4RFFuT28xQXZ6a2xUMTRLWWVIZE9PUEJO?=
 =?utf-8?Q?SUfb8+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PUZPR06MB4713.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ck1lT05rcHcvbFR0UUJOOVNnNSt2VWR0cnlBZ2wwQTIyOWgzZmJRVEV4ZHl4?=
 =?utf-8?B?WGNCeFlrZlNmSWxsRzFqSkRsTGtrZzByZ0hBL3BpaU5EZDJteldBbXU5YUxj?=
 =?utf-8?B?OHljZXBkV1p0WjZDZVF5Qit3NjNZM1dOeDhuR1pOVkJSYmR6c0VFV0huajln?=
 =?utf-8?B?Q3BxczEwSFlHSVRFdkVkcVZUdkN4UkRjc01yS2NDZ3d5U0kvNUlBYTV6V1A2?=
 =?utf-8?B?V1V1dlB6RjhzVEFpaFZLL0hWQTJ5NVpKSDV0ZEdFdElSVXk5K0hSa0tCaC9U?=
 =?utf-8?B?RG5Rdi9nc2o2VlJENmZpQTFqZUw5RTFhVmZndmFtaVp3TndKQlo4WlVOdzVF?=
 =?utf-8?B?MDY4YnQ1bGJEMUh6UzFtWFZ1TmtwNDdPK3J2ZUhlSDBmVGNkSyt3MityWWlx?=
 =?utf-8?B?UlpnRE04dzZIQ2hobm43VDNLZ3U0cTcrcXpnMFg3S0E1UEFZSC9qRG1EcjMr?=
 =?utf-8?B?NVExclN6elhNcWR3TTVnRnZKYTc5YzdLNXRwb2U0U2FXOGlCbGpBM255WDlW?=
 =?utf-8?B?OW1KN281ZDlnTkVHTEpmZWZ2TGFRWENmRTFUdXU5UXlGMTYvTk8wbTN3SmhH?=
 =?utf-8?B?SFlnWG1tUzFPNGg4UFV5M0pXb2lmZExybFRBbTFOWStaK0ZpRHBSUkR5b2Zo?=
 =?utf-8?B?Y1E0L3Q1TTN1YWx3TExkRTRXVSszMGZudUsvb25GR015R2lkdjEvRHJTU3ZP?=
 =?utf-8?B?QktqY1JOSUEwa2NLZGtTY1JyTTZZUzhlaFEyZmxCcmFBemcrbWoxZGFoTzc1?=
 =?utf-8?B?UU1KN0Q2THFrejczTXRNYVdjNEVUVnF0UFdEeWlBK3ZUL1ZYWS9XdGF0dEpV?=
 =?utf-8?B?Mk8zWlhIWWZlZHRhOWJEbWtHUDA2aE9ObCt5M2pyaGR6VlRlUFdZVGZmajBG?=
 =?utf-8?B?L2kza1BRSmxmemFCWGRxdTFINkx2dzJHellTNnAvK3JWeWhub2ZSOGIwSHk2?=
 =?utf-8?B?RjdSSjJlblQwOGh4cDlJQk1lUGZvYnJkOTRSTzAzZCtZRzVpSWtySjBlZ3Fa?=
 =?utf-8?B?ZzZqV2pFK1phWFpVdGJYL2pvS25iaG5kekhlSnByVzJKRjZPcm1GWm81b0pH?=
 =?utf-8?B?OTcrMU9pa3VVSzEzV2ZHcEpIblRHM3UvMloxM3FvbmVWdFJVU0p3Z1d2VzlT?=
 =?utf-8?B?a2NXQTVtMTgwRHlLcG9FRkxJV09KZVIzTGNSbE40RDk3L2NsK0hWa0t0SUds?=
 =?utf-8?B?bnp0OUV2OHgvbWhseU9tc0VFcTNrYmtocEsxVGxNK0FINGNTcFJocE8yMGh3?=
 =?utf-8?B?ZGdMVkxWclhOaHVwclgvQlhML1JURUVaUmdXejI5UzVJRTJyaHVUcGVLMFpo?=
 =?utf-8?B?Z3NTT0VjYkp6WGVnYml3M1VNM0xTZkxFandmZEVVMmp0b3pWdHBaZ2pyREh6?=
 =?utf-8?B?M25pd2VtZHI4NTY1UzEwVEx3L2tKckRVL1dkWStVSFJ2MkZ4d0N5dm83d3BI?=
 =?utf-8?B?TXZGUFRqOWQ2Y1M4ZXpiWXhPL0RpM0wwK3cvRUVUSnZFTkozeWgrZ2tmaVM2?=
 =?utf-8?B?a2pyejQwak13eE9jYlRhdC80UkFUSU5nODczVEJpV0YydDY3d3oyUzhmaUxi?=
 =?utf-8?B?dzVYQ08wTzR0V3QwazZQSFVhRWpXZ1QwQjdISklaNnBaNVNQOWlaeHBWWC9q?=
 =?utf-8?B?SW5iWXJLMkVYUi9RUWpHckZnZmdNdnRPOThqUjF1ZFF5aTJmVmJQc1dEZkYw?=
 =?utf-8?B?b2pJMGF6K2pIdXFaWTRVaUUvc0czUnFLaGpWM1VLQ3Y5VlRhV2xXQzdNNysy?=
 =?utf-8?B?dGdHU24xVGxFUWFvRUJ1R2h6aVpFS0d1LzMvRGhZRW9qVkZoL1luZFBNL1Zt?=
 =?utf-8?B?SGN6NTJrVWRhRGpVaFY1SDlLTGtrK0pPZHQ0OWtRa3VqUUdPY0t5LzBuV09m?=
 =?utf-8?B?bUdORmF5VEJTdUJpTlVtcnlaeTRBNUluL3pLQ1NPc1h3cnB1cVFLaVlmN3NX?=
 =?utf-8?B?eVNwQTNhd0phNFJwRFBMOEsyM2hFMlMwNzlpWGZOYlpXd0N4a0lUbzgzY1RH?=
 =?utf-8?B?TjZvVHJYUWlvYXJwQVR0WVVoT1h6UHlZWUowMzBjRkhTODNHNW91Kzd3RTU0?=
 =?utf-8?B?eXp0WFF5eWd2cWNoSUlBeUZGOUNlM1JqU0Q2QmRSTXRIVnUvbkp5cWRGWUVG?=
 =?utf-8?B?YjRDSlNmYjVRelVoaDJoRjNiWUNHbk12aisyaEdMS0x3a1kwanV6VWlaSGRj?=
 =?utf-8?B?dGVRVkRWY1hlb1VUSzYrNUNCaDFJUXoxeHMzTGllWkkwKy9IK3o1MXgzOUFw?=
 =?utf-8?B?OHE5aDhnYTNTR0NqM0N6dk9DWE5kYTdvRkpGc3lCK1FaTGpFbGxjdUV4UGgr?=
 =?utf-8?B?aGFqSVVPa3BiYTNLQ1pFNUxiWVB4bTJMRkxjcGZUczIrcmNMaVEzQT09?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a722cd09-db61-4bb7-1dc9-08de485bed95
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4713.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2025 11:01:20.1511 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v6as31M6fmdo17VtzhX2RF6tK6wZja6aSKFe9i8c4mhgmbbc+QCCpXJOfyr0wPDYEDJFB63LCovdQf/4Y2jRIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6920
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=wafer@jaguarmicro.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: wafer Xie <wafer@jaguarmicro.com>

Retrieve the target buffer from the indirect buffers by index,
add the elements sent by the guest into the buffer’s indirect descriptors,
and update freed_head and freed_number. If freed_number is zero,
or if the current buffer’s freed_number is less than the number of elements,
update the buffer state to SVQ_INDIRECT_BUF_FREEING.

If the current indirect buffer does not have enough freed descriptors
to accommodate the SVQ descriptors,
descriptors can be borrowed from the next indirect buffer.

Suggested-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: wafer Xie <wafer@jaguarmicro.com>
---
 hw/virtio/vhost-shadow-virtqueue.c | 341 +++++++++++++++++++++++++----
 1 file changed, 299 insertions(+), 42 deletions(-)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index 4f564f514c..02a238548c 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -139,86 +139,340 @@ static bool vhost_svq_translate_addr(const VhostShadowVirtqueue *svq,
 }
 
 /**
- * Write descriptors to SVQ vring
+ * Add a single descriptor to a descriptor table
+ *
+ * @desc: The descriptor to write to
+ * @addr: IOVA address
+ * @len: Length of the buffer
+ * @flags: Descriptor flags (VRING_DESC_F_WRITE, VRING_DESC_F_NEXT)
+ * @next: Next descriptor index (only used if VRING_DESC_F_NEXT is set)
+ */
+static void vhost_svq_vring_add_desc(vring_desc_t *desc,
+                                       hwaddr addr,
+                                       uint32_t len,
+                                       uint16_t flags,
+                                       uint16_t next)
+{
+    desc->addr = cpu_to_le64(addr);
+    desc->len = cpu_to_le32(len);
+    desc->flags = flags;
+    if (flags & cpu_to_le16(VRING_DESC_F_NEXT)) {
+        desc->next = cpu_to_le16(next);
+    }
+}
+
+/**
+ * Write descriptors to a descriptor table (chain or indirect)
  *
  * @svq: The shadow virtqueue
  * @sg: Cache for hwaddr
  * @iovec: The iovec from the guest
  * @num: iovec length
  * @addr: Descriptors' GPAs, if backed by guest memory
+ * @descs: The descriptor table to write to
+ * @start_idx: Starting index in the descriptor table
+ * @offset_idx: Offset for next field calculation (used for indirect)
  * @more_descs: True if more descriptors come in the chain
  * @write: True if they are writeable descriptors
+ * @indirect: True if writing to indirect descriptor table
  *
- * Return true if success, false otherwise and print error.
+ * Return the next free descriptor index if success, -1 on error.
  */
-static bool vhost_svq_vring_write_descs(VhostShadowVirtqueue *svq, hwaddr *sg,
-                                        const struct iovec *iovec, size_t num,
-                                        const hwaddr *addr, bool more_descs,
-                                        bool write)
+static int vhost_svq_vring_write_descs(VhostShadowVirtqueue *svq,
+                                       hwaddr *sg,
+                                       const struct iovec *iovec,
+                                       size_t num,
+                                       const hwaddr *addr,
+                                       vring_desc_t *descs,
+                                       uint16_t start_idx,
+                                       size_t offset_idx,
+                                       bool more_descs,
+                                       bool write,
+                                       bool indirect)
 {
-    uint16_t i = svq->free_head, last = svq->free_head;
-    unsigned n;
+    uint16_t i = start_idx, last = start_idx;
     uint16_t flags = write ? cpu_to_le16(VRING_DESC_F_WRITE) : 0;
-    vring_desc_t *descs = svq->vring.desc;
     bool ok;
 
     if (num == 0) {
-        return true;
+        return start_idx;
     }
 
     ok = vhost_svq_translate_addr(svq, sg, iovec, num, addr);
     if (unlikely(!ok)) {
-        return false;
+        return -1;
     }
 
-    for (n = 0; n < num; n++) {
-        if (more_descs || (n + 1 < num)) {
-            descs[i].flags = flags | cpu_to_le16(VRING_DESC_F_NEXT);
-            descs[i].next = cpu_to_le16(svq->desc_next[i]);
+    for (size_t n = 0; n < num; n++) {
+        uint16_t desc_flags = flags;
+        uint16_t next;
+
+        if (indirect) {
+            next = offset_idx + n + 1;
         } else {
-            descs[i].flags = flags;
+            next = svq->desc_next[i];
         }
-        descs[i].addr = cpu_to_le64(sg[n]);
-        descs[i].len = cpu_to_le32(iovec[n].iov_len);
 
+        if (more_descs || (n + 1 < num)) {
+            desc_flags |= cpu_to_le16(VRING_DESC_F_NEXT);
+        }
+        vhost_svq_vring_add_desc(&descs[i], sg[n],
+                                   iovec[n].iov_len, desc_flags, next);
         last = i;
-        i = svq->desc_next[i];
+        if (indirect) {
+            i++;
+        } else {
+            i = next;
+        }
+    }
+
+    /* Return the next free index */
+    if (!indirect) {
+        i = svq->desc_next[last];
+    }
+    return i;
+}
+
+/**
+ * Add descriptors to SVQ vring using indirect descriptors (dual-buffer)
+ *
+ * @svq: The shadow virtqueue
+ * @out_sg: The out iovec from the guest
+ * @out_num: The out iovec length
+ * @out_addr: The out descriptors' GPAs
+ * @in_sg: The in iovec from the guest
+ * @in_num: The in iovec length
+ * @in_addr: The in descriptors' GPAs
+ * @sgs: Cache for hwaddr
+ * @buf_idx: Index of the indirect buffer to use
+ *
+ * Return true if success, false otherwise and print error.
+ */
+static bool vhost_svq_add_split_indirect(VhostShadowVirtqueue *svq,
+                                         const struct iovec *out_sg,
+                                         size_t out_num,
+                                         const hwaddr *out_addr,
+                                         const struct iovec *in_sg,
+                                         size_t in_num,
+                                         const hwaddr *in_addr,
+                                         hwaddr *sgs, int buf_idx)
+{
+    SVQIndirectDescBuf *buf = &svq->indirect.bufs[buf_idx];
+    uint16_t start_idx = buf->start_idx + buf->freed_head;
+    size_t total_descs = out_num + in_num;
+    hwaddr indirect_iova;
+    int ret;
+
+    /* Populate indirect descriptor table for out descriptors */
+    ret = vhost_svq_vring_write_descs(svq, sgs, out_sg, out_num, out_addr,
+                                      svq->indirect.desc, start_idx,
+                                      0, in_num > 0, false, true);
+    if (unlikely(ret < 0)) {
+        return false;
+    }
+
+    /* Populate indirect descriptor table for in descriptors */
+    ret = vhost_svq_vring_write_descs(svq, sgs, in_sg, in_num, in_addr,
+                                      svq->indirect.desc, start_idx + out_num,
+                                      out_num, false, true, true);
+    if (unlikely(ret < 0)) {
+        return false;
     }
 
-    svq->free_head = svq->desc_next[last];
+    /* Calculate IOVA for this indirect descriptor range */
+    indirect_iova = svq->indirect.iova + start_idx * sizeof(vring_desc_t);
+
+    /* Add a single descriptor pointing to the indirect table */
+    svq->vring.desc[svq->free_head].addr = cpu_to_le64(indirect_iova);
+    svq->vring.desc[svq->free_head].len =
+            cpu_to_le32(total_descs * sizeof(vring_desc_t));
+    svq->vring.desc[svq->free_head].flags = cpu_to_le16(VRING_DESC_F_INDIRECT);
+
+    /* Store indirect descriptor info in desc_state */
+    svq->desc_state[svq->free_head].indirect_buf_idx = buf_idx;
+
+    /* Update buffer state */
+    buf->freed_head += total_descs;
+    buf->freed_descs -= total_descs;
+
+    /* Move free_head forward */
+    svq->free_head = svq->desc_next[svq->free_head];
+
     return true;
 }
 
-static bool vhost_svq_add_split(VhostShadowVirtqueue *svq,
+/**
+ * Try to borrow descriptors from the next buffer segment
+ *
+ * @svq: The shadow virtqueue
+ * @buf_idx: Current buffer index
+ * @needed: Number of additional descriptors needed
+ *
+ * Returns true if successfully borrowed, false otherwise.
+ * Note: Last buffer cannot borrow from first buffer (IOVA not contiguous).
+ */
+static bool vhost_svq_borrow_from_next(VhostShadowVirtqueue *svq,
+                                       int buf_idx, size_t needed)
+{
+    SVQIndirectDescBuf *cur_buf = &svq->indirect.bufs[buf_idx];
+    SVQIndirectDescBuf *next_buf;
+    int next_idx;
+
+    /* Last buffer cannot borrow from first - IOVA would not be contiguous */
+    if (buf_idx == SVQ_NUM_INDIRECT_BUFS - 1) {
+        return false;
+    }
+
+    next_idx = buf_idx + 1;
+    next_buf = &svq->indirect.bufs[next_idx];
+
+    /* Can borrow if next buffer is in FREED state and has freed_head at 0 */
+    if (next_buf->state != SVQ_INDIRECT_BUF_FREED ||
+        next_buf->freed_head != 0) {
+        return false;
+    }
+
+    /* Check if next buffer has enough free descriptors to lend */
+    if (next_buf->freed_descs < needed) {
+        return false;
+    }
+    /* Borrow descriptors: expand current buffer, shrink next buffer */
+    cur_buf->num_descs += needed;
+    cur_buf->borrowed_descs += needed;
+    cur_buf->freed_descs += needed;
+
+    next_buf->start_idx += needed;
+    next_buf->num_descs -= needed;
+    next_buf->freed_descs -= needed;
+
+    return true;
+}
+
+/**
+ * Try to get a freed indirect buffer for use
+ *
+ * @svq: The shadow virtqueue
+ * @total_descs: Number of descriptors needed
+ *
+ * Returns buffer index (0 to SVQ_NUM_INDIRECT_BUFS-1)
+ * if available, -1 if none available.
+ */
+static int vhost_svq_get_indirect_buf(VhostShadowVirtqueue *svq,
+                                      size_t total_descs)
+{
+    int cur = svq->indirect.current_buf;
+    SVQIndirectDescBuf *buf;
+
+    if (!svq->indirect.enabled) {
+        return -1;
+    }
+
+    if ( cur < 0) {
+        cur = 0;
+    }
+    /* Start from current or first buffer, try all buffers in order */
+    for (int i = 0; i < SVQ_NUM_INDIRECT_BUFS; i++) {
+        int idx = (cur + i) % SVQ_NUM_INDIRECT_BUFS;
+        buf = &svq->indirect.bufs[idx];
+
+        if (buf->state != SVQ_INDIRECT_BUF_FREED) {
+            continue;
+        }
+
+        /* Check if we have enough free descriptors */
+        if (buf->freed_descs >= total_descs) {
+            svq->indirect.current_buf = idx;
+            return idx;
+        }
+
+        /* Try to borrow from next buffer */
+        size_t needed = total_descs - buf->freed_descs;
+        if ((buf->freed_descs > 0) &&
+            vhost_svq_borrow_from_next(svq, idx, needed)) {
+            svq->indirect.current_buf = idx + 1;
+            return idx;
+        }
+
+        /* Not enough space, mark as FREEING if it's the current buffer */
+        buf->state = SVQ_INDIRECT_BUF_FREEING;
+    }
+
+    /* All buffers unavailable, fallback to chain mode */
+    return -1;
+}
+
+static int vhost_svq_add_split(VhostShadowVirtqueue *svq,
                                 const struct iovec *out_sg, size_t out_num,
                                 const hwaddr *out_addr,
                                 const struct iovec *in_sg, size_t in_num,
-                                const hwaddr *in_addr, unsigned *head)
+                                const hwaddr *in_addr, unsigned *head,
+                                bool *used_indirect)
 {
     unsigned avail_idx;
     vring_avail_t *avail = svq->vring.avail;
     bool ok;
+    int ret;
     g_autofree hwaddr *sgs = g_new(hwaddr, MAX(out_num, in_num));
+    size_t total_descs = out_num + in_num;
+    int indirect_buf_idx = -1;
 
     *head = svq->free_head;
+    *used_indirect = false;
 
     /* We need some descriptors here */
     if (unlikely(!out_num && !in_num)) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "Guest provided element with no descriptors");
-        return false;
+        return -EINVAL;
     }
 
-    ok = vhost_svq_vring_write_descs(svq, sgs, out_sg, out_num, out_addr,
-                                     in_num > 0, false);
-    if (unlikely(!ok)) {
-        return false;
+    /* Try to use indirect descriptors if feature is negotiated and total > 1 */
+    if (virtio_vdev_has_feature(svq->vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
+        total_descs > 1) {
+        indirect_buf_idx = vhost_svq_get_indirect_buf(svq, total_descs);
     }
 
-    ok = vhost_svq_vring_write_descs(svq, sgs, in_sg, in_num, in_addr, false,
-                                     true);
-    if (unlikely(!ok)) {
-        return false;
+    if (indirect_buf_idx >= 0) {
+        /* Indirect mode: only need 1 main descriptor slot */
+        if (unlikely(vhost_svq_available_slots(svq) < 1)) {
+            return -ENOSPC;
+        }
+
+        /* Use indirect mode */
+        ok = vhost_svq_add_split_indirect(svq, out_sg, out_num, out_addr,
+                                          in_sg, in_num, in_addr,
+                                          sgs, indirect_buf_idx);
+        if (unlikely(!ok)) {
+            error_report("indirect error, out_num %zu in_num %zu "
+                         "avail index %u head %u",
+                         out_num, in_num, svq->shadow_avail_idx, *head);
+            return -EINVAL;
+        }
+        *used_indirect = true;
+    } else {
+        /* Chain mode: need total_descs descriptor slots */
+        if (unlikely(vhost_svq_available_slots(svq) < total_descs)) {
+            return -ENOSPC;
+        }
+
+        /* Use direct (chain) mode */
+        svq->desc_state[svq->free_head].indirect_buf_idx = -1;
+
+        ret = vhost_svq_vring_write_descs(svq, sgs, out_sg, out_num, out_addr,
+                                          svq->vring.desc, svq->free_head, 0,
+                                          in_num > 0, false, false);
+        if (unlikely(ret < 0)) {
+            return -EINVAL;
+        }
+        svq->free_head = ret;
+
+        ret = vhost_svq_vring_write_descs(svq, sgs, in_sg, in_num, in_addr,
+                                          svq->vring.desc, svq->free_head, 0,
+                                          false, true, false);
+        if (unlikely(ret < 0)) {
+            return -EINVAL;
+        }
+        svq->free_head = ret;
     }
 
     /*
@@ -233,7 +487,7 @@ static bool vhost_svq_add_split(VhostShadowVirtqueue *svq,
     smp_wmb();
     avail->idx = cpu_to_le16(svq->shadow_avail_idx);
 
-    return true;
+    return 0;
 }
 
 static void vhost_svq_kick(VhostShadowVirtqueue *svq)
@@ -249,7 +503,8 @@ static void vhost_svq_kick(VhostShadowVirtqueue *svq)
     if (virtio_vdev_has_feature(svq->vdev, VIRTIO_RING_F_EVENT_IDX)) {
         uint16_t avail_event = le16_to_cpu(
                 *(uint16_t *)(&svq->vring.used->ring[svq->vring.num]));
-        needs_kick = vring_need_event(avail_event, svq->shadow_avail_idx, svq->shadow_avail_idx - 1);
+        needs_kick = vring_need_event(avail_event, svq->shadow_avail_idx,
+                                      svq->shadow_avail_idx - 1);
     } else {
         needs_kick =
                 !(svq->vring.used->flags & cpu_to_le16(VRING_USED_F_NO_NOTIFY));
@@ -274,19 +529,21 @@ int vhost_svq_add(VhostShadowVirtqueue *svq, const struct iovec *out_sg,
 {
     unsigned qemu_head;
     unsigned ndescs = in_num + out_num;
-    bool ok;
+    int r;
+    bool used_indirect = false;
 
-    if (unlikely(ndescs > vhost_svq_available_slots(svq))) {
-        return -ENOSPC;
+    r = vhost_svq_add_split(svq, out_sg, out_num, out_addr, in_sg, in_num,
+                             in_addr, &qemu_head, &used_indirect);
+    if (unlikely(r != 0)) {
+        return r;
     }
 
-    ok = vhost_svq_add_split(svq, out_sg, out_num, out_addr, in_sg, in_num,
-                             in_addr, &qemu_head);
-    if (unlikely(!ok)) {
-        return -EINVAL;
+    /* If using indirect, only 1 main descriptor is used; otherwise ndescs */
+    if (used_indirect) {
+        svq->num_free -= 1;
+    } else {
+        svq->num_free -= ndescs;
     }
-
-    svq->num_free -= ndescs;
     svq->desc_state[qemu_head].elem = elem;
     svq->desc_state[qemu_head].ndescs = ndescs;
     vhost_svq_kick(svq);
-- 
2.34.1


