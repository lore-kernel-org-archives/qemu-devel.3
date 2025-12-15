Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ABCAD41D74
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 07:59:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vV3UI-0008GK-QX; Mon, 15 Dec 2025 02:59:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1vV3UH-0008Fq-6t
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 02:59:21 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1vV3UF-0004Hr-1x
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 02:59:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MY99IYz6fMZvoO4BuBBO+5U/NN4KGGBDpHPRiY3UmAQ4LDcS93WDX9aDr9dGvMyGR68mViAurXz/d8VKFvdDwD+tB/USghRFI75xcJfUbFQcLznD9UtFPDR58Km9Fr2meOsZMNaiN3rJbFdj45P+zIlISXLvsXwBftBXxEJ9g+kREKRQdbimeIEhObRka/WxQoYfywJLg7iRwg9zQHLvPCh4LZpQGvH/4ceV/ewwzAjiu0XSOtcUr+DqNQUUDNap2iZ1dmdCPNAZIFFL+CLE8b3bulzatk0gbmb5LRlZlf0ZnN1UPtCuptnVmQS7UlsfHM1MApmJ7tDziVBhCrAYtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K8twKTd3sJEqpcDsBLwJRuzOM52cnv/phGQt4VjSEow=;
 b=RnIHuoNmgqyXkTlvMMyPAKa0uhhvs2ygNR0M2as4pkAPB9jqKKQVK/lN6GoJhjlerXHLESTeUnvhoIokP2viFU98zzBQP9qFTJuyA1/yJnF7qYktmBE7a/Xhrx+0DhohrArybmL5D+D3Z3cOP+72aaB5Vk7iVGLseMhQbdybO/vkh0zLhEZt5v8JabnkEp+Td7Ozyj5bC1Ein55avct2ddAN3HCMh9RGWr94Jsy9FytkdVLxggzMEE5CMZyJzqgaaLzyvxHe2fwhkdNQavPWx7j0KRHrDdLPNpzX9JoXvno3zZOW6C+h64T2DtXoLy2bUB/yRkVd2ShbiWB/mvAQvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8twKTd3sJEqpcDsBLwJRuzOM52cnv/phGQt4VjSEow=;
 b=KylFaGyfqe9Z5QRjConEknpVjencqnh0xNRwVxt9loj7qn/QBT+6wLxOsEz/zxRVRety/w8YTDb6dJQRQDSTt0YGOzZrOd5ddFM2q1U8x3+v9+Pr558ct2CTSTre8UgB7jYze3FyR0EAgGlSoYPEE8VCGmQv2GL+pgYmiMGGWpG6+69F6BatgD2kdGl0TOLNjiHSHjIOXnoy9Vy5ZEIE93NsGIxmGP4hw7vMBzYGIEJcJx7DfatvrW+JWf2gcnJFSI5UJ2NbW+jf6S48bYN+XeVRuNU7MXYteuGDjGGrlYvJwfKZdJZM7AKjFWRjqbX5uItxcwA/8sJnxWOGPxM6uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com (2603:1096:301:b4::10)
 by OSNPR06MB8228.apcprd06.prod.outlook.com (2603:1096:604:45e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 07:59:13 +0000
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::1b36:28b0:4e5:de66]) by PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::1b36:28b0:4e5:de66%6]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 07:59:13 +0000
From: Wafer Xie <wafer@jaguarmicro.com>
To: mst@redhat.com, eperezma@redhat.com, jasowang@redhat.com,
 qemu-devel@nongnu.org
Cc: leiyang@redhat.com, sgarzare@redhat.com, angus.chen@jaguarmicro.com,
 wafer@jaguarmicro.com
Subject: [PATCH v2 4/4] vhost: SVQ add the indirect descriptors to available
 ring
Date: Mon, 15 Dec 2025 15:59:02 +0800
Message-Id: <20251215075902.2428-1-wafer@jaguarmicro.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KU0P306CA0063.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:23::11) To PUZPR06MB4713.apcprd06.prod.outlook.com
 (2603:1096:301:b4::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4713:EE_|OSNPR06MB8228:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d48c659-627b-4254-17bf-08de3bafd60e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bVB0NFZ4dHIxK3MwWDhGUDhDRkYxbDRSajZNcWlWb3VTRXMxc0daN3BWcEhX?=
 =?utf-8?B?SFYrT01RcjV2UVd6bk9iM2ZhMFJoQkFmYjdWSFlxT0JJbVZ0YjZ4WXJOUWlW?=
 =?utf-8?B?NU41UnRodmhLZTdNbG9yYitURHd6Z0V6aENtOG1iQ29JbW4yWmwrQlQ0UUVx?=
 =?utf-8?B?Tm5RWHYxdjJmY2FWOEFXV3pqeVpxWEJMeXp1NTc1cElPbTFmSW5IVHdyaVZT?=
 =?utf-8?B?UTZyZ2RwNStXZWNUT0NITUs1K21LenR4QTBNYUkyM1ZmbnlXRmJYcXNYSVhK?=
 =?utf-8?B?eWFZTmw4a2xLL2lZeVA3eXZvTFdzS3kzTUJvc05EUXNUMjBud1pvSGpTMDdp?=
 =?utf-8?B?a0krbW9wZzZzcnVrTHhNcE9hWUVhbVVsTDZnS1pGcGJiZ25VY3hvWGNjRy9z?=
 =?utf-8?B?cEh3bm5VdWVINkRPN0tQbGdsZlZIeWl1OXlwMDZDU2dnK1ZON2tBOFlTWG1V?=
 =?utf-8?B?OHRveU9YQ0pFbEpBRmpxcy9CMTBhV0pkQXMwalBNTC9RbGhCQjJoTURxSUp2?=
 =?utf-8?B?WXI1SG9FUFBlc3RTUzdkSVdFa2VJTUZWQUROZ1RzeXJ3OG52K3BZU2R1MDYr?=
 =?utf-8?B?WitnRHErZTBPdDdpQ3pwSEIvbURPTk1LTUd2UHduYUE3S21KNzVWWVZCTkZi?=
 =?utf-8?B?eVRiRVFRL0FDWXNjOGYyVDhjMWx0ZVNPQ0NvdjI2VzlOd3o3QlI4dXdrODU1?=
 =?utf-8?B?S0lVczZzWmtySHkxaTNxaEMwa1F3VjRwWmYyNDYwcXZZTGgxbENvaTJmMnhD?=
 =?utf-8?B?NHV3S1dObExCbEZTRUV0NjRHZFRoRzh4QnlURUY3SStHbHVGSjN4OVlJMnJn?=
 =?utf-8?B?Z2hFaFlPODVRTVpIOXZRazZIeDVpbjg3WE54emlyMmlUcjczKzc2dXZRMXpP?=
 =?utf-8?B?WlhjQW5pUXZNSG1oSjZrbEp4d0FCUmplaVNaYUtJV0M3RTZyTEUvb0x4WjdG?=
 =?utf-8?B?UW1oOEVDSU5hVWRXRFZWTVl1YVJmME4zclFsWEZ5Qm1BYjVJbW4xSEQwM3pG?=
 =?utf-8?B?RGZUbFRJRmsyYVBPZEtqbUNlVmRML09HV2NTMnROTU91amtJeENYL1pvSUpH?=
 =?utf-8?B?bXZTWm1ab3BFS3RoMndiTnppemJQVkpQRWNUdjZ1bjZGU1FvRjEwdmJ4ems3?=
 =?utf-8?B?V0ZMdnVVYnYwZlVsVFZhc09WYy96a1FJelhnTG9OSjBUVFk4ckViaHNac3JT?=
 =?utf-8?B?aXdqbkc3MFJSSHVlRlFrelhsY3lPeXJLSitiSUJ3WVN3MmRpSjdWR0wwNjlq?=
 =?utf-8?B?WjIzRmVjQkFOTmhxdzVaRSs0b2ExNGtIY01kYXZOWHRUTStiTXNsUjdLSkYv?=
 =?utf-8?B?STE4NWhMZVdUaHNKekJyck4yUFVwSC8vRWpUYmdoSnlXc29HV05FdGVjSUlO?=
 =?utf-8?B?MVh0OU9LQnJKTFZQL3RySmpPdE40MjNsZGI4b1l0L3FqdFVETks4OFQyS1JK?=
 =?utf-8?B?ZlF5S0NHRUNsSTFBc2I2bEpTdjA1S3UvYUtGV3YvbEVxemJlTExTa1huVytp?=
 =?utf-8?B?VDUwcTZENGt5czVLajRpdUpqZXlRU2Vka1pvRDFFTTFpRnNBclFUYUVIbHFz?=
 =?utf-8?B?cjVVTVZQUkZrR2tSd3JZQU9BeVdUNUxNNTJDYmpVR2FJcDRoVDRPMnc4cmV0?=
 =?utf-8?B?VGFiK0RSUkowa1Z6a0tjZGpHM0o4ZldYa3FUYVpSd1pYZ2o4NFdqeDBjbWt0?=
 =?utf-8?B?OWl5ZU9xUWVBOSs5U3MwWld2U3F5TjFKQTV3eWltbjY4US9IRUZZa2xrZlpC?=
 =?utf-8?B?a0JXbHNYMnFmUXV1cjByYk1CREpXNEl2UEV2OUJrdk4xNWR6bjJPV0hxZWdo?=
 =?utf-8?B?a2RuZjB1ekd6QVpMSzFpdWszb2hONEFud0dTZVJTeVRUWlRRcG9PanRtTElW?=
 =?utf-8?B?U0Vsa1dZbU15ZFR4bFBYdm1NNHh4ODZXMG5tTEJRSnlraXEwS2J0YkhUZVpl?=
 =?utf-8?B?Rk42TWNRRnVNblFxS1doUXdLNjVhMVpoZjU0UnVYN1ZlMlFRUUM5cXFvajY4?=
 =?utf-8?B?T0FIRHJ3cGNGLzVlRXNsajFrSlovcERKUHptcW02Umt5V0dYYUFxa1ZPejY0?=
 =?utf-8?Q?QC/n77?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PUZPR06MB4713.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1FNWUo0K3VJWHBsYU9paEFOMk9GK2p2UEd6S1dubkluenVBMC9iY0hhWlZX?=
 =?utf-8?B?cXdwMEQ3VCsvQnRsRU15TElMTGcvTm8wNld1cWcyekNjNHFodHd2NHNXR3VZ?=
 =?utf-8?B?aEFkaHUxbVBCYmlyVTlSbVVrdEE0ZmpRSlFacG9KUXVZMGZjanB3NjFOOVhO?=
 =?utf-8?B?czJrWEU0K1pncWdVVC9iZUIybStVZngzR0psb3dobEtYZmpGQ08yNWgwR0ph?=
 =?utf-8?B?cXJHdFplOEFyVXdod1hYRmJWK0d6a1NCcFBRa2FVWUhXaks0bjJ0MUJuT0p1?=
 =?utf-8?B?M09kMEpnalRZTUhHaDl0VjZ4K2swcXVCWEIyaDdUekFhaW40aWt1bUd0WUxm?=
 =?utf-8?B?YnBGQ2xxQUFhNWtFNmJhSmtWNUFzRGZYU2JvenpSbjNOcm5Mc0llU2xYTE95?=
 =?utf-8?B?K0pWSkVHakdCQkdydDZ3MFdldSswVWFPMkFsZUZCRHZQTm1VMXNPRFdCM2py?=
 =?utf-8?B?bmE4S2lIeGhaaGhGeHM3c3FycUo3U0ZwRmpFMm1xcWk0eGo1Qy9EYXB0Q2xi?=
 =?utf-8?B?WHVBZ29pVURKUllxMHA2WEx2cEpwSzhPNW41SFNJcWQ5M1p2ZHQydDNvMlVw?=
 =?utf-8?B?VWtZUzhXNmRGc0xvS2xFZzRXeGVreVFVRjFtc01VdG1uaWthaHNZYkU1Mm95?=
 =?utf-8?B?WUozWGJNSjhtQ1NSZnYrWUxGcFBXQW5Tc1poVmZFaWRHV3padzc2MGI3Slhn?=
 =?utf-8?B?YVVGMXNKY1hQWnBQSEVoem4wd3NGWG9wQmdnS2tPRGdSUzNnRngzYmtjUzJY?=
 =?utf-8?B?WkVocCtzV2Ria0NuUVpXRVRLM0d6MUVSY1pIWklOYzEzczMrU05TNHdOTTZG?=
 =?utf-8?B?SjFWNVdwUmlzNDJ1b2padWJ2NHJRRlc2dVMveDlVZVczdHNKV3c2MVliQ09p?=
 =?utf-8?B?UU5Fa0tEVkR0eWZjNWJITTJkUkY2WUdFV0daRmFGNnNTZ1pTSzBjdjMrZlQ1?=
 =?utf-8?B?SnVLV0diT0NhN2gydGJJK056RHkxbTk4WStCa0pRaXNKTFZHV2xURXdEYWVt?=
 =?utf-8?B?RUp0d3dYSVVFbFIraUlvZTJEblo5WHhFekRDV0hQRWFycUhXdlFLbDcydTNh?=
 =?utf-8?B?RktoeVlJYUxYL1dCazM3RlVjTXhBWkpGdWcwQjFJejljSHk0WTZsM21oQVha?=
 =?utf-8?B?Qkd6QkcvVHl6RVlrcmJVSVRaWWlXMytubDlhckJQeDNhNlpvRHkrSmh0RGhY?=
 =?utf-8?B?di80ekhFY2I5OE4ycjkvcEExOUN1MjFwbVpZb0NYRkdZcWxDUDVLYmU5aTZI?=
 =?utf-8?B?Rk1IbHlvbys4ZXk4clJ3WUM4Z0g0bU4zYUZIVUJGc2ZHanNOSEJmQWFSQVlp?=
 =?utf-8?B?aE9tR2FYQW9XdVV0M3FrMDhROGJvSzdJdzhOZGVFTm5wQUNReXZFQXRXVDZG?=
 =?utf-8?B?SmE3NlZiN2plcml1UWtFTmYxS2tCUTFveGtYQ2QzV2NqWWV5YTRRNmV0eGNo?=
 =?utf-8?B?ZW81UDFCNFVYK1lVaVRIeGwzR2Vnc0FPWldnZUZldURjblhiTkUxejBhSXQy?=
 =?utf-8?B?aE5DWW00bWJubEtkcFZydFh6cG1oL3VVYlNsNzZodjArQmE0V2lWSnE1d3cz?=
 =?utf-8?B?dDg2bitIeE1hY0pjemlZNjlqZWlkaWNRMVZHamQ4dko5ZTE4VFBtOGt0czlq?=
 =?utf-8?B?eFZsMmI3RSt2aU9oRkg0eW50VG1NWTB1elB6UUZISXVHVDZUV255a0x0ZktW?=
 =?utf-8?B?K09CRld2a3g4YnVHN05IQVJpTEdzUGR1K1VDMVoreDlRYk1PaGM0NDBUVXNK?=
 =?utf-8?B?bjNLemk1R3MrWWpCVFFzbUJGOHFGZjI4Mm9zYzY0NVB5QkVDbEh6eE9nOEl2?=
 =?utf-8?B?RGFtcVU5dWh3MS9BYy9Xc1kvcDRFekNXSGVpeW4vdE5KYnZKQTcwajJIaENC?=
 =?utf-8?B?bDJTclVOYklubkYwN054YTdObHJVRHNpbE5CdkRZQlkzT1hDOXFoYmZmOEtq?=
 =?utf-8?B?YmFmb0JDRXJWaWc4UGcwWm4wbVV0azdOYnRuaFg0akhEeURtZ0YvT1d5SUZS?=
 =?utf-8?B?ZFZIWTNTdzNuMlkweERNRjJCdHpWdHVRck5RcXZRWVpOM2RsbE9yaW94VTdl?=
 =?utf-8?B?S3JBVFoySmhWWDFiV1BwSXEwQlFhVWlVd3JFeG42OUg4MlgxSHlhbEw5NmND?=
 =?utf-8?Q?KB/r2kKiwzecaufOPZP7pYWWq?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d48c659-627b-4254-17bf-08de3bafd60e
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4713.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 07:59:13.1281 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IPdLkClzpRwjk4bjplxt+oyMY7rM1uUswvnuUgPt9uEX51uFY70wPAr6F4wxIir63ittnUKZloS1cRCAUtLNoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR06MB8228
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=wafer@jaguarmicro.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
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

Signed-off-by: wafer Xie <wafer@jaguarmicro.com>
---
 hw/virtio/vhost-shadow-virtqueue.c | 245 ++++++++++++++++++++++++++---
 1 file changed, 224 insertions(+), 21 deletions(-)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index 9d43f13842..ef7a1db5ae 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -189,36 +189,237 @@ static bool vhost_svq_vring_write_descs(VhostShadowVirtqueue *svq, hwaddr *sg,
     return true;
 }
 
-static bool vhost_svq_add_split(VhostShadowVirtqueue *svq,
+/**
+ * Write descriptors to indirect descriptor table
+ *
+ * @svq: The shadow virtqueue
+ * @sg: Cache for hwaddr
+ * @iovec: The iovec from the guest
+ * @num: iovec length
+ * @addr: Descriptors' GPAs, if backed by guest memory
+ * @buf: The indirect descriptor buffer
+ * @offset_idx: Offset for write position and next field (0 for out, out_num for in)
+ * @more_descs: True if more descriptors come in the chain
+ * @write: True if they are writeable descriptors
+ *
+ * Return true if success, false otherwise and print error.
+ */
+static bool vhost_svq_vring_write_indirect_descs(VhostShadowVirtqueue *svq,
+                                                  hwaddr *sg,
+                                                  const struct iovec *iovec,
+                                                  size_t num,
+                                                  const hwaddr *addr,
+                                                  SVQIndirectDescBuf *buf,
+                                                  size_t offset_idx,
+                                                  bool more_descs,
+                                                  bool write)
+{
+    bool ok;
+    uint16_t flags = write ? cpu_to_le16(VRING_DESC_F_WRITE) : 0;
+    vring_desc_t *descs = buf->desc;
+    uint16_t i = buf->freed_head + offset_idx;
+
+    if (num == 0) {
+        return true;
+    }
+
+    ok = vhost_svq_translate_addr(svq, sg, iovec, num, addr);
+    if (unlikely(!ok)) {
+        return false;
+    }
+
+    for (size_t n = 0; n < num; n++) {
+        descs[i].addr = cpu_to_le64(sg[n]);
+        descs[i].len = cpu_to_le32(iovec[n].iov_len);
+        if (more_descs || (n + 1 < num)) {
+            descs[i].flags = flags | cpu_to_le16(VRING_DESC_F_NEXT);
+            descs[i].next = cpu_to_le16(offset_idx + n + 1);
+        } else {
+            descs[i].flags = flags;
+        }
+        i++;
+    }
+
+    return true;
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
+                                         const struct iovec *out_sg, size_t out_num,
+                                         const hwaddr *out_addr,
+                                         const struct iovec *in_sg, size_t in_num,
+                                         const hwaddr *in_addr,
+                                         hwaddr *sgs, int buf_idx)
+{
+    SVQIndirectDescBuf *buf = &svq->indirect_bufs[buf_idx];
+    uint16_t start_idx = buf->freed_head;
+    size_t total_descs = out_num + in_num;
+    hwaddr indirect_iova;
+    bool ok;
+
+    /* Populate indirect descriptor table for out descriptors */
+    ok = vhost_svq_vring_write_indirect_descs(svq, sgs, out_sg, out_num,
+                                               out_addr, buf, 0,
+                                               in_num > 0, false);
+    if (unlikely(!ok)) {
+        return false;
+    }
+
+    /* Populate indirect descriptor table for in descriptors */
+    ok = vhost_svq_vring_write_indirect_descs(svq, sgs, in_sg, in_num,
+                                               in_addr, buf, out_num,
+                                               false, true);
+    if (unlikely(!ok)) {
+        return false;
+    }
+
+    /* Calculate IOVA for this indirect descriptor range */
+    indirect_iova = buf->iova + start_idx * sizeof(vring_desc_t);
+
+    /* Add a single descriptor pointing to the indirect table */
+    svq->vring.desc[svq->free_head].addr = cpu_to_le64(indirect_iova);
+    svq->vring.desc[svq->free_head].len = cpu_to_le32(total_descs * sizeof(vring_desc_t));
+    svq->vring.desc[svq->free_head].flags = cpu_to_le16(VRING_DESC_F_INDIRECT);
+
+    /* Store indirect descriptor info in desc_state */
+    svq->desc_state[svq->free_head].indirect_buf_idx = buf_idx;
+
+    /* Update buffer state */
+    buf->freed_head = start_idx + total_descs;
+    buf->freed_descs -= total_descs;
+
+    /* Move free_head forward */
+    svq->free_head = svq->desc_next[svq->free_head];
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
+ * Returns buffer index (0 to SVQ_NUM_INDIRECT_BUFS-1) if available, -1 if none available.
+ */
+static int vhost_svq_get_indirect_buf(VhostShadowVirtqueue *svq, size_t total_descs)
+{
+    int cur = svq->current_indirect_buf;
+    SVQIndirectDescBuf *buf;
+
+    if (!svq->indirect_enabled) {
+        return -1;
+    }
+
+    /* Try current buffer first if it's in FREED state */
+    if (cur >= 0) {
+        buf = &svq->indirect_bufs[cur];
+        if (buf->state == SVQ_INDIRECT_BUF_FREED) {
+            /* Check if we have enough free descriptors */
+            if (buf->freed_descs >= total_descs) {
+                return cur;
+            }
+            /* Not enough space, switch to FREEING and try next buffer */
+            buf->state = SVQ_INDIRECT_BUF_FREEING;
+        }
+    }
+
+    /* Try all other buffers */
+    for (int i = 0; i < SVQ_NUM_INDIRECT_BUFS; i++) {
+        if (i == cur) {
+            continue;
+        }
+        buf = &svq->indirect_bufs[i];
+        if (buf->state == SVQ_INDIRECT_BUF_FREED && buf->freed_descs >= total_descs) {
+            svq->current_indirect_buf = i;
+            return i;
+        }
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
+        total_descs >= 2) {
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
+            error_report("indirect error, out_num %zu in_num %zu avail index %u head %u\n",
+                            out_num, in_num, svq->shadow_avail_idx, *head);
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
+        ok = vhost_svq_vring_write_descs(svq, sgs, out_sg, out_num, out_addr,
+                                         in_num > 0, false);
+        if (unlikely(!ok)) {
+            return -EINVAL;
+        }
+
+        ok = vhost_svq_vring_write_descs(svq, sgs, in_sg, in_num, in_addr, false,
+                                         true);
+        if (unlikely(!ok)) {
+            return -EINVAL;
+        }
     }
 
     /*
@@ -233,7 +434,7 @@ static bool vhost_svq_add_split(VhostShadowVirtqueue *svq,
     smp_wmb();
     avail->idx = cpu_to_le16(svq->shadow_avail_idx);
 
-    return true;
+    return 0;
 }
 
 static void vhost_svq_kick(VhostShadowVirtqueue *svq)
@@ -274,19 +475,21 @@ int vhost_svq_add(VhostShadowVirtqueue *svq, const struct iovec *out_sg,
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
2.48.1


