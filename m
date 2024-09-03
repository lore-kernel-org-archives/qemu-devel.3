Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 865A6C54FC6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 03:08:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slJss-0007Ms-VB; Mon, 02 Sep 2024 23:07:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1slJsq-0007Lm-TW; Mon, 02 Sep 2024 23:07:09 -0400
Received: from mail-eastasiaazlp170100000.outbound.protection.outlook.com
 ([2a01:111:f403:c400::] helo=HK2PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1slJsn-0002Bu-G5; Mon, 02 Sep 2024 23:07:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a+sFyjV1i/o57gr4YZO3UMa68Yh27nJeb0hWB6LPEAck/nLgw6xxzqwvw1yadrOcFTsLUB2nQQzanxuqCHjggyVJWSYmEelWE6l6D+yF21X4cawjp2s+N+PmoyYn6JATMKq9ijFqRRgm6xbQvBMdZYQrWIcDaeM6yTp0vum8pQOIFSYqKLfR6qSZJazqFqjxIoiuuMNnd6uAbiC8ThrPLqrnNbNNOBrs1jO5s/bXdfgIn54AYb3oTQiQLI032MgmwXp1YhcYrliZnp9YjguuLm4ovnNcQe/wTB8HZ3esPEH19T8uNMaZRSdkuvXnbZMvHsRlwlPZrTp1XE0IBSQ55w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6JcPlt8g4HJP4s5d5a1co2ZDCiWocR7i0Xy8sWvECY=;
 b=Th5f70fZscShoh9Bt1NF9VPgcmCcWKYPA4kk8H/oTFUUuWVtYbZ2myvNeCFg15lldpElMfmnY7+A4zEcCbJNyCd63hpr0LLgYO7cCBmkMb+ruY0eojht9FLK5vhqY0Z1ztfVcEoHXrf3RnyTDGdQiNmJPfCPHWL8PfJ12ljw/zHzQ4NOiIRp1j7o1d7uEIIxZi703xSSGUlKsxuEQtyubHpSNnijgYMtdiANZMXUfLRzBYTR7w56zbvF6cj7hbFMKgpbv0sdFTOu1veqWUrBVqQ48jakprtdKXadQluvY49udf4P9W6IvoA47sDcW5gKRArQVaXI1vtKeoVIg1hcxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6JcPlt8g4HJP4s5d5a1co2ZDCiWocR7i0Xy8sWvECY=;
 b=CJUfOZCc+pOsfuDw2jgFM6nbeYYcvXM7oUrnDKm2zbgo1vQv/Bh0ycK+5OMlZpElGkhYdsutMMes26jocxO1q8uABu/b66aYeKT+ppYXKgIJXLywhRTagDSUmVxF0GpGB7VEugR5wmW+i1ELR+L5LfbPyb+R4tIb4PvDzThWsBXl/p4DwZqb9zKVNoKnlWEU/vSo3CCCwiRPNwoFtfy93N9uQ56YAGdhQqYLeuJ9EkC8HZSqaWiYKDKYpE15YsZxFoVmaIi7v2AkEI2sI+aaeZR8A+72Kt7bjs1e53f+NQ1evD4iPxR3OKVQaqTgweLE3EkVW/KSUMbdX0AGSSCRsQ==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TYZPR06MB6499.apcprd06.prod.outlook.com (2603:1096:400:462::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.23; Tue, 3 Sep 2024 03:06:57 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.7918.020; Tue, 3 Sep 2024
 03:06:56 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Cleber Rosa <crosa@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Wainer dos
 Santos Moschetta <wainersm@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?=
 <clg@redhat.com>
Subject: RE: [PATCH v2 07/11] hw/i2c/aspeed: support high part dram offset for
 DMA 64 bits
Thread-Topic: [PATCH v2 07/11] hw/i2c/aspeed: support high part dram offset
 for DMA 64 bits
Thread-Index: AQHa6T2WGJJO30MNAkmAAXkkqnI2FrJEpXYAgADkQXA=
Date: Tue, 3 Sep 2024 03:06:56 +0000
Message-ID: <SI2PR06MB5041259485142B47913B7E9AFC932@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240808024916.1262715-1-jamin_lin@aspeedtech.com>
 <20240808024916.1262715-8-jamin_lin@aspeedtech.com>
 <0e62d8ed-f30d-4b18-914b-89a51d6d9687@kaod.org>
In-Reply-To: <0e62d8ed-f30d-4b18-914b-89a51d6d9687@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TYZPR06MB6499:EE_
x-ms-office365-filtering-correlation-id: f4aae60d-8ad0-4ca7-b2da-08dccbc57850
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700018|921020; 
x-microsoft-antispam-message-info: =?utf-8?B?Z3YrL2dJei9aMVBzRmpMNW1qclVnSVhjbThVanpwcHRRU3p4V25aREVmcUMw?=
 =?utf-8?B?WU1Oa3plemZYQzdDWVRZT2c2VXR2YTZxR0ZPU21IYy81akJiaE9WeWJaM1JN?=
 =?utf-8?B?cUs4LzdqVU9pQVNucG96RkZxWjBCWlhIeWx3eFFDaGV1NTB3TmN0RENoUW1Z?=
 =?utf-8?B?VzkvbnAvYXB4QlJURlY0SnhEaW1YTDk1Y09qZUdnQ0ZENTBIdDRLUDhFMHNS?=
 =?utf-8?B?bU5tVVZiNlo5b2NIMHZ3aXYrSmtNUkZleHpKYVlnTWtoSjRqQXVTd3dvVWpT?=
 =?utf-8?B?aUFFcG5yeHpGTlFUVWxpSDdENWRVTUxLYW1NTEY3MzYwTVBwWjFOZGxZRE5K?=
 =?utf-8?B?WGlMUkpXRyt5dGNwd0hPZjJqa3BIdCtDMExGbWFaaDBreERjZlRVRTMya09Z?=
 =?utf-8?B?RGtTN1BHSFluSjRHeXk4M1Jic1hnWkdYMWZOb29rNXVUNGlYckpsR0VvOXdo?=
 =?utf-8?B?Q3lIQnVYaW1JcDg5bThNTXlnMnF4VXhHcjNWVzB0bnNKVnM2UFhubzE4N2tu?=
 =?utf-8?B?ZVlpelFpcVdkWUNEbXM1TDM3a3hhd2RoT2FFWE9QSzZWNmkrdE9RWnhwai9J?=
 =?utf-8?B?OTZYT3dsdDR0TEJvTDVyQmN5N21SZk82Q3ZKcXF1bEw5YWwyYkMzYVVQV1NR?=
 =?utf-8?B?VHFkYXhLdlhRUmY1NTZxUmpHK1htdkFiLzZDM2pwRytabUZOWVBHeGRtY3ZD?=
 =?utf-8?B?SExkK3dsV1lVUUl3NDFkeFdSQWdoczNSWHhDSFNLT3puSEhSd0cyUWFRci9p?=
 =?utf-8?B?UXQzeUZEdUQ3WTRHWVZocThDRHk0V0poS3RjNmU4Mld2M2RJdkhQaERIbjl1?=
 =?utf-8?B?VkRmOTRhZE5rV09NNUx5ZDBFVk9rUW9tSW9PclYzcXVYbWliRzE1aS9WMU1x?=
 =?utf-8?B?a2JJSzNaVGtSd3praHMyQURnR0tRNFQ1Z1JoNUxtU1FRTWdnR01mRXArL2Nh?=
 =?utf-8?B?SWVEbXd1NTA0OE5qNjB3Nlh0RWQyRXFwVk52UDY3ZG12L2tob2owNk54WDBU?=
 =?utf-8?B?eVdGdmthWXgyMGxuYldrU1dMMTZLa05IbHUyRWpFaHV0MFpncUoyZFpieExN?=
 =?utf-8?B?WHFIMWVUVFl3em1VdjNlMHJ1OERnYlo1YTZVOWRyTm1HZ25BcDlCd3ZUaEk4?=
 =?utf-8?B?ZHpPdklicGg2QXRGWjFuOEpqL29KYVZOM0lwTnRsditYbTc1OU1NNzBrU3pT?=
 =?utf-8?B?Yys1Qmh4RmtrN3ZoVFhCVHRFRFVkVzdYNlh5WHB5TWlyNEYxbnhXci8zR1lL?=
 =?utf-8?B?aGlyVmIwTmRrVEQwNjB6UllMdmlmUWplYmlUUVRobkIrOEpiaTBSODB4bCtW?=
 =?utf-8?B?L1JnRUl1K1hOQnZMMTVJcks2cWpVOTYvcTRQU0NxaDZNdFhJWXQvVFpWeXlT?=
 =?utf-8?B?VU8yV0VlT3d0N3dpUkxGTkFDVTlSRzZSQlk1NGd2SVA2RXFqMkdIa2poQ0d3?=
 =?utf-8?B?eDJWUlJhWC9KeDdscUZOZFVPV2JnQ2tDaWs4eWU0a01IVTdaUnFlRVRPMXZT?=
 =?utf-8?B?VFhmMUNjQXZ0b2ZHOUtjd3ZuZXU1eS92ZEdhVkU3NFJ0N1R2NjhYWnhCVkdS?=
 =?utf-8?B?REtua1F1MUtyalNmRGdoUy91QlJzZGtZRW5TZ2EzZnZrTFlHemZMWGhvSHBC?=
 =?utf-8?B?ajR5NFJLWWRNZ0RVN3U3bUgyeFJCeGU1TytmQUVjYUxCMWdIZ3BnYzJqK3Jy?=
 =?utf-8?B?ZWNpbk1uc3pkZEx5bTVLZnVKd3VlZy8vMXFoMXRpVnllMml1Ni9xS0xFSzR4?=
 =?utf-8?B?cHZpZzZZL1F1SURwcXhkajVjUUo4U2RNTkpTM0FsckhndGEwdjhReGg1QlFV?=
 =?utf-8?B?MjEyU2lDMzR6VFZYV1JCcEQ3N2dEWW4yMFZ2UmVuQ2JqNitIZnQwbi9QcE1K?=
 =?utf-8?B?bjIwVXFUbFlUNjdycDlqNjlZWVVaYTZzYzlMNnRkRTkrVmFtVitZZUFUak91?=
 =?utf-8?Q?ryw8Ch23grM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SnEwSGFVakFlcmIwaWlvb093bFQzV3JCMW5zUTl3d1lIdzROQ2s4Z3VZNCtJ?=
 =?utf-8?B?YUJKZWxqbHM1Y3MvYU9VNDFzeWhEd1JVM3Vjc2lBanNsd2FDbzVLUVZyd29R?=
 =?utf-8?B?SUVMaVNOdUZGWVVtMDBuWitKZ3NWRGZmMkw5MkZZa1NFbU95NmZ1V0V2SDV5?=
 =?utf-8?B?U0RTbktDc0g0ZjJ2eVh2Q0MwcmVkMkNNS3ZRNGVaaUdMMmRyeEZRRHlmYjZh?=
 =?utf-8?B?QWhGS3JJdFVXVXZwZWVoSk5WVHQ2VUR4S3A2ZTVjSWplMHorengya040eEUr?=
 =?utf-8?B?dWhxVnFuN1laNUs5UU84bmhXSzRmdW9mdE9WSFdSamRBOEJVK1A3cFA3N1pk?=
 =?utf-8?B?YUhzb21ueVFZWE1ESm16SFpoMjFPbWd3cWU0ZURRMEphTW50V0RJOVcvcGpM?=
 =?utf-8?B?eDdYbUw5cHVtV0VZTkg0K2d6TlpBdExqUENUSEVqeWpwejdFcXJDM2dzRFZa?=
 =?utf-8?B?Z0dWUkRrbjBJMHlzcndVYUNaZFFEaGcyYm9qeGx1NVQ2Y05zWHpqTGxlSy85?=
 =?utf-8?B?VzJ5OEVFT0Nhc3NCZGhlVEgvWjIzRFNDZFlDYmlIOE5iZDhoMmdnVDByM0Nm?=
 =?utf-8?B?M0wvNyszaVdWY2UzcE81TldPMVBqVEI4WC9nZld4RzNxWU5CRUFzemhTNWox?=
 =?utf-8?B?aDNna2ZCZXJ1RmdWWGd0MkRKc1B6MVlrWlpHUHlxQXNiVW1kMyt1bS9tNGF1?=
 =?utf-8?B?a3dlVGpmbVFOSkU0bXdMaUlHdW8xQVdld1doOCtQaTc0T2JyVEFRN3VGTGds?=
 =?utf-8?B?L2NWNVZSc1FqakdlSVh4ZkhoVjJHUVp1WSsyaVlNazZFVjJCZWN2eTg0bmRL?=
 =?utf-8?B?Y0pFL29lbGUxYnBRVGxWMHRlenNiSU9MYnJneXRnVHNYald1aDNtekQzOWtG?=
 =?utf-8?B?dDNUWW53TkY5ckljbE5odmNWM2YvcW9YMEU3RkwrSmpyVEtqQkFOaGdXbXRU?=
 =?utf-8?B?K293a0toN09DMzBSNEpwU21ScHZQazFBbWVUNE01a0hXcGNFbDJzbXl0NlZD?=
 =?utf-8?B?Ukl2aGIzN3VPVGN6QkFESnhQR1hCbi85U1lXazFWak9VQUV1N3QrRW5na0Zq?=
 =?utf-8?B?MERmcmI5VzAxQ0E2YlRtQlZkUGpZeFQxdytXaU1Ob1VURTBUdW1hSVJWLzE5?=
 =?utf-8?B?d3NhT2cxbkxIaFpzaUZKSHptaVgvSUtQMmpPQlk4dUU5MUxFK3NGSjVhem5I?=
 =?utf-8?B?S3RMa2QxeFlNWWdoSGdSak04T291VDg3QmdEUWI5NCtMMEFaeHVLZkRadE94?=
 =?utf-8?B?c21HUnB2c0JkSUg2bGdtNitaRmtTSXA5T0Y5eE5oMFJ5OUFrYzZnT0ZIdjhz?=
 =?utf-8?B?MXFzZUhKWEZGNVQrS1drMzlhM1dRMzdFaGVtRlBXR3pGVzVaOGlrUzhPK0k3?=
 =?utf-8?B?SDVqYVJibHVtbXVoemJwc2ZkZTQ0eTV2NEVZUUN3TmN6Z3lWY1JRWGlldTBK?=
 =?utf-8?B?Vm1NRHZ4YWptQU9KMzRPV2FtWjJvRnVNRlFSSzR3UDY0UUxnU3ZNUWN2dzdC?=
 =?utf-8?B?N0NsVDg1QlJCci8wcWN1TlZVYW1Pd25OVzlkbzhLdzFUM2VyVmx6NUJDM3pr?=
 =?utf-8?B?dGJnRXcxekdQbHp1ZjVhOEJkdVkxVmVTemFnaHFWZmd2QTJHSEd0eEo5cGM1?=
 =?utf-8?B?K05QRUhXSjlvYnRtUkVYb294K2hvY3BUTkVsZHdvMmxNTFZvMWdHbUdxbjBD?=
 =?utf-8?B?Y1ZVL1ZXSkVNMy9IZ1JKb2c4TkpzNFJZeGNoTzZadWVQRkUwYmxuUFBscmxS?=
 =?utf-8?B?RTNBa3FRZkcxSXRBU0lDTWhhYTFiNlZueGQ0Y1ZHY1lGMnhoZlF0dSt6bWx2?=
 =?utf-8?B?eEdDN2cxa25MT0hFbzhQcVVrTVdBcHd6NmlTNlV4cVNTaVZOb0VRSWpPVVFP?=
 =?utf-8?B?UStuWmN5WDNQcUpjcTU5aENjMUdMaXlJSjI2TFFFNTJsYWNKN0U2T3VSU0k2?=
 =?utf-8?B?eTdLR0ZldTkwcjVGTzdoL29EZmJ1OVdwS1UvRFN1WkZWSW9hOXd3K3RzQzVY?=
 =?utf-8?B?cjV2a01Pc0dITTBVdThqcFhrL2kyYTNJeGpuankwaEE1Z2FuNWkwc0lVeVlu?=
 =?utf-8?B?UVJKbmVlaFVKUmw3bStKRWZoM0ZOL1E0ZXMwVWZqLzZMeExiUHVsakFmWkxJ?=
 =?utf-8?Q?fnbfPdc/+8Jim+4Q9P1ihhqCx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4aae60d-8ad0-4ca7-b2da-08dccbc57850
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2024 03:06:56.7223 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5pF+7q9oXuGsxnKJotm9QEQV2kf+mv9xRKr/inyONd6J9h1nk+1V28zcvnz95tbaxLWtsTRGPsICbtIu9/sW0s4/NBx4gNLq2w2bFIbSyaA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6499
Received-SPF: pass client-ip=2a01:111:f403:c400::;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=HK2PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

SGkgQ2VkcmljLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMDcvMTFdIGh3L2kyYy9hc3Bl
ZWQ6IHN1cHBvcnQgaGlnaCBwYXJ0IGRyYW0gb2Zmc2V0IGZvcg0KPiBETUEgNjQgYml0cw0KPiAN
Cj4gSmFtaW4sDQo+IA0KPiBQbGVhc2UgYWRqdXN0IGNvbW1pdCB0aXRsZQ0KDQpXaGF0IGRvIHlv
dSB0aGluayBpZiBJIGNoYW5nZSB0aGUgY29tbWl0IHRpdGxlIGFzIGZvbGxvd2luZy4NCg0KaHcv
aTJjL2FzcGVlZDogQWRkIHN1cHBvcnQgZm9yIGRtYV9kcmFtX29mZnNldCBhdHRyaWJ1dGUgYml0
cyAzMyBhbmQgMzIuDQoNClRoYW5rcy1KYW1pbg0KPiANCj4gT24gOC84LzI0IDA0OjQ5LCBKYW1p
biBMaW4gd3JvdGU6DQo+ID4gQVNQRUVEIEFTVDI3MDAgU09DIGlzIGEgNjQgYml0cyBxdWFkIGNv
cmUgQ1BVcyAoQ29ydGV4LWEzNSkgQW5kIHRoZQ0KPiA+IGJhc2UgYWRkcmVzcyBvZiBkcmFtIGlz
ICIweDQgMDAwMDAwMDAiIHdoaWNoIGlzIDY0Yml0cyBhZGRyZXNzLg0KPiA+DQo+ID4gVGhlIEFT
VDI3MDAgc3VwcG9ydCB0aGUgbWF4aW11bSBEUkFNIHNpemUgaXMgOCBHQi4NCj4gPiBUaGUgRFJB
TSBwaHlzaWNhbCBhZGRyZXNzIHJhbmdlIGlzIGZyb20gIjB4NF8wMDAwXzAwMDAiIHRvDQo+ID4g
IjB4NV9GRkZGX0ZGRkYiLg0KPiA+DQo+ID4gVGhlIERSQU0gb2Zmc2V0IHJhbmdlIGlzIGZyb20g
IjB4MF8wMDAwXzAwMDAiIHRvICIweDFfRkZGRl9GRkZGIiBhbmQNCj4gPiBpdCBpcyBlbm91Z2gg
dG8gdXNlIGJpdHMgWzMzOjBdIHNhdmluZyB0aGUgZHJhbSBvZmZzZXQuDQo+ID4NCj4gPiBUaGVy
ZWZvcmUsIHNhdmUgdGhlIGhpZ2ggcGFydCBwaHlzaWNhbCBhZGRyZXNzIGJpdFsxOjBdIG9mIFR4
L1J4DQo+ID4gYnVmZmVyIGFkZHJlc3MgYXMgZG1hX2RyYW1fb2Zmc2V0IGJpdFszMzozMl0uDQo+
ID4gSXQgZG9lcyBub3QgbmVlZCB0byBkZWNyZWFzZSB0aGUgZHJhbSBwaHlzaWNhbCBoaWdoIHBh
cnQgYWRkcmVzcyBmb3INCj4gPiBETUEgb3BlcmF0aW9uLg0KPiA+IChoaWdoIHBhcnQgcGh5c2lj
YWwgYWRkcmVzcyBiaXRbNzowXSDigJMgNCkNCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEphbWlu
IExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPg0KPiA+IFJldmlld2VkLWJ5OiBDw6lkcmlj
IExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+ID4gLS0tDQo+ID4gICBody9pMmMvYXNwZWVk
X2kyYy5jIHwgMTQgKysrKysrKysrKysrKysNCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNl
cnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaHcvaTJjL2FzcGVlZF9pMmMuYyBiL2h3
L2kyYy9hc3BlZWRfaTJjLmMgaW5kZXgNCj4gPiBjMWZmODBiMWNmLi40NGMzYzM5MjMzIDEwMDY0
NA0KPiA+IC0tLSBhL2h3L2kyYy9hc3BlZWRfaTJjLmMNCj4gPiArKysgYi9ody9pMmMvYXNwZWVk
X2kyYy5jDQo+ID4gQEAgLTc0Myw2ICs3NDMsMTQgQEAgc3RhdGljIHZvaWQNCj4gYXNwZWVkX2ky
Y19idXNfbmV3X3dyaXRlKEFzcGVlZEkyQ0J1cyAqYnVzLCBod2FkZHIgb2Zmc2V0LA0KPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgIF9fZnVuY19fKTsNCj4gPiAgICAgICAgICAgYnJlYWs7DQo+
ID4NCj4gPiArICAgIC8qDQo+ID4gKyAgICAgKiBUaGUgQVNUMjcwMCBzdXBwb3J0IHRoZSBtYXhp
bXVtIERSQU0gc2l6ZSBpcyA4IEdCLg0KPiA+ICsgICAgICogVGhlIERSQU0gb2Zmc2V0IHJhbmdl
IGlzIGZyb20gMHgwXzAwMDBfMDAwMCB0bw0KPiA+ICsgICAgICogMHgxX0ZGRkZfRkZGRiBhbmQg
aXQgaXMgZW5vdWdoIHRvIHVzZSBiaXRzIFszMzowXQ0KPiA+ICsgICAgICogc2F2aW5nIHRoZSBk
cmFtIG9mZnNldC4NCj4gPiArICAgICAqIFRoZXJlZm9yZSwgc2F2ZSB0aGUgaGlnaCBwYXJ0IHBo
eXNpY2FsIGFkZHJlc3MgYml0WzE6MF0NCj4gPiArICAgICAqIG9mIFR4L1J4IGJ1ZmZlciBhZGRy
ZXNzIGFzIGRtYV9kcmFtX29mZnNldCBiaXRbMzM6MzJdLg0KPiA+ICsgICAgICovDQo+ID4gICAg
ICAgY2FzZSBBX0kyQ01fRE1BX1RYX0FERFJfSEk6DQo+ID4gICAgICAgICAgIGlmICghYWljLT5o
YXNfZG1hNjQpIHsNCj4gPiAgICAgICAgICAgICAgIHFlbXVfbG9nX21hc2soTE9HX0dVRVNUX0VS
Uk9SLCAiJXM6IE5vIERNQSA2NCBiaXRzDQo+ID4gc3VwcG9ydFxuIiwgQEAgLTc1Miw2ICs3NjAs
OCBAQCBzdGF0aWMgdm9pZA0KPiBhc3BlZWRfaTJjX2J1c19uZXdfd3JpdGUoQXNwZWVkSTJDQnVz
ICpidXMsIGh3YWRkciBvZmZzZXQsDQo+ID4gICAgICAgICAgIGJ1cy0+cmVnc1tSX0kyQ01fRE1B
X1RYX0FERFJfSEldID0gRklFTERfRVgzMih2YWx1ZSwNCj4gPg0KPiBJMkNNX0RNQV9UWF9BRERS
X0hJLA0KPiA+DQo+IEFERFJfSEkpOw0KPiA+ICsgICAgICAgIGJ1cy0+ZG1hX2RyYW1fb2Zmc2V0
ID0gZGVwb3NpdDY0KGJ1cy0+ZG1hX2RyYW1fb2Zmc2V0LCAzMiwNCj4gMzIsDQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZXh0cmFjdDMyKHZhbHVlLCAwLCAy
KSk7DQo+ID4gICAgICAgICAgIGJyZWFrOw0KPiA+ICAgICAgIGNhc2UgQV9JMkNNX0RNQV9SWF9B
RERSX0hJOg0KPiA+ICAgICAgICAgICBpZiAoIWFpYy0+aGFzX2RtYTY0KSB7DQo+ID4gQEAgLTc2
Miw2ICs3NzIsOCBAQCBzdGF0aWMgdm9pZA0KPiBhc3BlZWRfaTJjX2J1c19uZXdfd3JpdGUoQXNw
ZWVkSTJDQnVzICpidXMsIGh3YWRkciBvZmZzZXQsDQo+ID4gICAgICAgICAgIGJ1cy0+cmVnc1tS
X0kyQ01fRE1BX1JYX0FERFJfSEldID0gRklFTERfRVgzMih2YWx1ZSwNCj4gPg0KPiBJMkNNX0RN
QV9SWF9BRERSX0hJLA0KPiA+DQo+IEFERFJfSEkpOw0KPiA+ICsgICAgICAgIGJ1cy0+ZG1hX2Ry
YW1fb2Zmc2V0ID0gZGVwb3NpdDY0KGJ1cy0+ZG1hX2RyYW1fb2Zmc2V0LCAzMiwNCj4gMzIsDQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZXh0cmFjdDMyKHZh
bHVlLCAwLCAyKSk7DQo+ID4gICAgICAgICAgIGJyZWFrOw0KPiA+ICAgICAgIGNhc2UgQV9JMkNT
X0RNQV9UWF9BRERSX0hJOg0KPiA+ICAgICAgICAgICBxZW11X2xvZ19tYXNrKExPR19VTklNUCwN
Cj4gPiBAQCAtNzc3LDYgKzc4OSw4IEBAIHN0YXRpYyB2b2lkDQo+IGFzcGVlZF9pMmNfYnVzX25l
d193cml0ZShBc3BlZWRJMkNCdXMgKmJ1cywgaHdhZGRyIG9mZnNldCwNCj4gPiAgICAgICAgICAg
YnVzLT5yZWdzW1JfSTJDU19ETUFfUlhfQUREUl9ISV0gPSBGSUVMRF9FWDMyKHZhbHVlLA0KPiA+
DQo+IEkyQ1NfRE1BX1JYX0FERFJfSEksDQo+ID4NCj4gQUREUl9ISSk7DQo+ID4gKyAgICAgICAg
YnVzLT5kbWFfZHJhbV9vZmZzZXQgPSBkZXBvc2l0NjQoYnVzLT5kbWFfZHJhbV9vZmZzZXQsIDMy
LA0KPiAzMiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBl
eHRyYWN0MzIodmFsdWUsIDAsIDIpKTsNCj4gPiAgICAgICAgICAgYnJlYWs7DQo+ID4gICAgICAg
ZGVmYXVsdDoNCj4gPiAgICAgICAgICAgcWVtdV9sb2dfbWFzayhMT0dfR1VFU1RfRVJST1IsICIl
czogQmFkIG9mZnNldCAweCUiDQo+ID4gSFdBRERSX1BSSXggIlxuIiwNCg0K

