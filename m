Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE81C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 07:36:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taVHL-0003uB-Si; Wed, 22 Jan 2025 02:35:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1taVHH-0003s2-Ka; Wed, 22 Jan 2025 02:35:55 -0500
Received: from mail-sg2apc01on20715.outbound.protection.outlook.com
 ([2a01:111:f403:200f::715]
 helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1taVHE-0007X0-O5; Wed, 22 Jan 2025 02:35:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BroB7m/JdCeB+lOm6fcyw7rtuC3n8A+aQTv8UJ4UnsBqKLZEFuVltgPQrnzqmPxT012tcvJ+nDqzravaiZE5eGxbGgf7uK5qEd7lJRrZunuW+sJ8Lb7PrUx+2MtaGGeNCf3EjelBFseyW0INz0xs/Dxs7Iw10xSIU8K5mw9cJp3vBM+JaHMgQ4sq/sKxw4X+7iV8TJ9M4/JaEZgyTHcUNT+rAkXauFyZ6308LmgckfWe+UgyBTZZxFjAhNAKq38Q0Aw3sRcEeeDXPavNNFuZUmd9QAgZlwEn4INo9tC5Gcolmbc2zd+UbjE6y/Vqvcvi+UiseQFgnB0xWF5CzUiRQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=//alTB2w79cG+VQx6SjEnYNzDYCgY8wXLO9Ux92kHhA=;
 b=Xz3vx2DhHxxawgPjZ31ueiQ3rsE6EWIlUqcD/HmrQb6vQgeaYQKZimFIhb4+RZlkHjPRo+aD/Ku3s7mggimDgwb/OseMBAzUgGGhZYfe5Hd7qbsaCBMiqc32x2Ff0+0k9NyPjAjhquCId3LuI0NI12eVytzpoP+xdKKZTZ3bqmRR/Td1+lcz7Ybum2zm0flQz9uTJCsyhKTKTajDUQWtW/Vb5jfyK03yClaj3DEgzCef5yBi/zkLd96wKIeFpcfL9TW+EV5JUa/ICPeFUVGLTJ3UCd0cgoPFfgOSHseM+G10BpSSl+R5pRYjl0lXvjxVCAhtKIsWN3sVUmZpf9kA9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//alTB2w79cG+VQx6SjEnYNzDYCgY8wXLO9Ux92kHhA=;
 b=IvH/kTWD1+aAQiFtzhkKlegOUJrN6v30SDHly4djsh83RYVH4NgNsrg721a9cUwUG2Foe149N18Nu36jjukHai9Pk3rL/U909IFkUQncFfmzO/wKgERg6nWKf/zZ5sPxO3ma8woG5x2rCegDA2IoTOC53n+ZNrYtGWzeYnuGmfsO1kr9PB3efUy7X7AAvv0UeA93c+Y0pmGU2vO/n65DWokYDa4zIVSvGH67IE12pqfoC38VK9UY/xgv5ZzM8Zbc8f4+7/E7UwmqT6UPpIKDm4BfcWVypbbarbhvUx2FMUSYh1z04FDEcS67cXkkZZQjcaHcVZCbCU0TYi69eUGbXQ==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SEZPR06MB5989.apcprd06.prod.outlook.com (2603:1096:101:f3::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.15; Wed, 22 Jan 2025 07:35:11 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.8377.009; Wed, 22 Jan 2025
 07:35:11 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Joel Stanley <joel@jms.id.au>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Troy Lee <troy_lee@aspeedtech.com>, Steven Lee
 <steven_lee@aspeedtech.com>
Subject: RE: [PATCH 8/9] test/functional: Update buildroot images to 2024.11
Thread-Topic: [PATCH 8/9] test/functional: Update buildroot images to 2024.11
Thread-Index: AQHbbJyjzhOOPT8KhESnU6op9+OtmLMiZvLg
Date: Wed, 22 Jan 2025 07:35:11 +0000
Message-ID: <SI2PR06MB50413752AE47A6B249F26B31FCE12@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250122070909.1138598-1-clg@redhat.com>
 <20250122070909.1138598-9-clg@redhat.com>
In-Reply-To: <20250122070909.1138598-9-clg@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SEZPR06MB5989:EE_
x-ms-office365-filtering-correlation-id: fdb4e11a-6128-4a34-88a2-08dd3ab74dc8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|13003099007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?M2hSOGdJbWI1NEIzNDVYM2MzNTVwZml1YjNrK0dpL092Y0FSWWxrVnZ5TFhj?=
 =?utf-8?B?QU1KNHlyYVMwQWNLY05SemNHR1Z5KzljZkZVd0g5ZzdvM1doSEhuRUZMaC9V?=
 =?utf-8?B?a3NmTUNLckU1a2MrS01oSGh1Y2h3a0JaNytoOWNhTWlmQ25zUk8vNENUR0h4?=
 =?utf-8?B?Q2V3S3pYaVZGQVJlYjM4TTNhNUh2R2t1STdEOXNRc2tWYjJQTU5SblAwMG9t?=
 =?utf-8?B?cUpqYWkrdGZwa2dUSXpheXhmVGlSaHJCUWxOalFTUTJ2VjlkUFkvWjNLTVlJ?=
 =?utf-8?B?NHlKeGNDM2w4dlVvT2pTblN4RzdHTFMxaDJzUXk4ZHBJc3BxaURac3JXc0d6?=
 =?utf-8?B?UVBiZnhhdkVqY0FxanErczFxT1RBRUVxWGg2U1BuWWxuSG9nRUEwQmRzYnhP?=
 =?utf-8?B?cnlTcEp2OGl1RVNONTZSK1k0U1VsRjBiVFNEamdITmxsejhxT1Q4MEFuQXRE?=
 =?utf-8?B?MUoxNnRGa1krbkxUNzV5V3Q1ZWZnTjFvYUJXSVk1WWpKME43QXIzeUVMQnZC?=
 =?utf-8?B?M2NRd1AvTXI3bFJDN0pCWjNmTlhMZDZXeTBoaVVjdk83VmxmSk9Pbm90OEk3?=
 =?utf-8?B?clIxU1g0Rm5HUy9wT0Z6N1NwL28yeTZ1RnI0THJjWHFVRGRVdWtUUDVqRGpm?=
 =?utf-8?B?cTNGK1NIT0pzNmZxc2FrL0haa3E4RTJ5TzhnL0pyUW5jR2RreTBzUDFYNnpT?=
 =?utf-8?B?K1FIenFPbjNCTzNEOHhMbitPTUFhRklUaHl3OHgrMmtEYUNkamZTcEpnVjFt?=
 =?utf-8?B?b1k3R3dDdG1kbkF0TFRZUG1jQUYwTDJsNUxYTWxCNzBiSnJXWFRtY1I3WWY2?=
 =?utf-8?B?K3R2R2hQOVlYSmRvd3BGdmNBbkpRbGh1di9NSFdlUHdwMFpsM25KTDdsTGJV?=
 =?utf-8?B?aVBWNHRUcXdXVEd5WmZnZGFhUDFXQkFmWDMwZGZPK2xZTEhPbzVKUEtvTDFY?=
 =?utf-8?B?RHFxNVF1cUlxem1PdWxJU3hzUU5YZ00vZktaVjg3eS9HbllyZFdramxGMTVY?=
 =?utf-8?B?M3Y1aXpHeTZnS3orRkxXYXFmL2ZoT3F1eElSTTVqMVRJMXE5dE1tdXdEMSs2?=
 =?utf-8?B?Wnp4L3g2aDFhU1IvUkdqTmVxSWFYc2VpMDBWcnplbVFJZFRTRkVSdUxXRVlT?=
 =?utf-8?B?U1h4MHNrTC9Zdm41WDFIRGV4ZTFLeUlwWkFQT0xRMHM2cXdpSThvTjdKcGpC?=
 =?utf-8?B?UWFGNVMxY3VVYVRENGxxcGtwcitCbVBYTm9pNWhuREd0NUs4TnlKZ2xDS2g5?=
 =?utf-8?B?MWxTM2Rpc3Vxa1dBZ0xLRE02Q0NTdGM5Q1h5cGVHd3M0dFEzc0JybUxRMU5D?=
 =?utf-8?B?dEJWT21MTUpETHAwYnpvLzFKWE1WcVRyNkxSUTF4cGd1cWh4MzY4YzNXSC8x?=
 =?utf-8?B?M05ISTgrdnRWMEdyNnRhcGYraFhHVEpWamlKQ1hZWEI0VCsxOXI3VzhaZml2?=
 =?utf-8?B?NDRwYjB6WXVwM29iNUt1SDZ3K0t5SjIyVE9KZmVjeURmdlVsd2NCWG1XVXlo?=
 =?utf-8?B?UW16YWxzcFR3cEwvbERCRXlWQktvZFpLdFdscTRzTFVPL3hUNHZrcW5mUHRq?=
 =?utf-8?B?VFhlMzF2dlpkUHphRTM3c01DWTVMQmp2S1YzM2dxUWNSVnI4UjJnRlZoT2Mr?=
 =?utf-8?B?bGE3S0RaZktoV1FUaU5yTkQwcmJROTNCMklLVThPUU84LzNsdmVTUFZLQVJZ?=
 =?utf-8?B?MWlXVWs0QzRjSUZLbDVkQlU5bXdGMmFmUEt1WENOcjN1MVVCR05PNTI4dlZv?=
 =?utf-8?B?TTNURGp4clpPNXh6MktDRkRVaWkzVnpqSWxWb1NkajBkQ2hyMTFlRTdPdUE5?=
 =?utf-8?B?bnViZWRKRjBJUzF6UEN3VXpDQ3NwK3doVWxld0M2eVlKQXpPdkh4YmtDdG1O?=
 =?utf-8?B?eFZJSEdyUGpmdHJyWnVEeXA0ZmlNVHhoUDA5MUZnQkZEVy92YVF6dFVxM0Z1?=
 =?utf-8?Q?a3bQFD8Nor3YSCy83rGYLO4//r6jmb63?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(13003099007)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2VYZVBBWlJSbkJUeXZpb1NlUVRiQXhFTnNxRWdPajcwQ1p0N3R3WVY0SGFE?=
 =?utf-8?B?OVJTN0ZzM3BiK2tTdVZ5UGRJaW42ME1EMEkzak5sQ2pjeW1iQTVQODBsVE1t?=
 =?utf-8?B?RUlJb0ZsakNHZVR5QWlLRGpuc3VDWTFPQTFhZDEzZEJpblNWQXh5aTNHYS9G?=
 =?utf-8?B?RkNUanYrR1lib3A5NUtNN2duTjF6Nmx1WEI3eWxFRUNGZ0srbGJ2UEpCZlJn?=
 =?utf-8?B?aEQ3R015T2tqeWs0UEMzcEp0RWdhRjZpaEh0QU5pLytYc085MTViUFNCRUtC?=
 =?utf-8?B?Ty9vY1pqRGZnMGxybldNM0M3UHVCdFBGWFA4K0VXS21sR2hXZko4RjJrNlpn?=
 =?utf-8?B?TWZaRXlMUGFQdFExYXhreERZVFRxSE1PTktDK2UyTVRXbkc2ZytlQXBCb1Nv?=
 =?utf-8?B?bzNudEM4cWRGaXVITXNOeWttVmN5MzEwd1hwWkhUNXByZXBxRUIrVmcvRndL?=
 =?utf-8?B?NnFwTk1ja1R5QXNGQTlBb1lTdjZRTFFtb2huVnhVaDRBMllIbE5aZk5mdTRk?=
 =?utf-8?B?VDhEUnl4WUUwWDhNZ1FsUmZCYUx5VG9QQkxhNmpDOG1Gck5RTmVJMGNaVUsx?=
 =?utf-8?B?MXlUOXpBb1dxRkFaTHJlUEx0MzdIY1ExRXpVeTYzUEd0bG1UcmJ5UWVSdUw5?=
 =?utf-8?B?cVZkTWhITmFmdURrQzNxbkF6NG5RbXB1UXRBeUxZdVdybUpsYytnWWR1U3ZJ?=
 =?utf-8?B?cjlXN1JwVStBTGoyWWU4RWg2eHdJUU5OcXVNbVcvNzRtNklkMC84MG1EWWt6?=
 =?utf-8?B?VmYrUTd4ejJxNVhmblZKK3RQL3NYR084bUxpeXhsdFcwTEszNUFDODdZUkJa?=
 =?utf-8?B?c2k1d3Y1U3YzTldGc1JkOEhETUlZdThQWjQvUEkxaFhsdnVZRnZLVWh2Z25K?=
 =?utf-8?B?ZXNSYisxQURlZE0vZCtRVEIvUlhndFhSeWJyZlRpTFdUQUU4cGhoMVdQSy9w?=
 =?utf-8?B?N0hLS3FIYkVWc2c2S09XNjVyZ0h6ekxiZ1puaW1YWHpaT2gxR3RyY25DWWdx?=
 =?utf-8?B?bVFLVS9abnlHRXdSNFlSVkwybno1TVZPMFVFSmo4cktrV1JkOFBvZ2s5RnpV?=
 =?utf-8?B?Rm90eS9acExxbGZucjNOQVR2aFdBZjFuY3NhQmtlcjQrQ2lKeGkvNk5jMkkw?=
 =?utf-8?B?WEp4VlBGWkVQMUQ4VVJKclVyTDMzZFlLSy9hZ1ZiTkIxT2NrVTdocjJCZHZr?=
 =?utf-8?B?WWNsMHpCSHpmbVU4UXJaSFFYTUQyNEErbU5YZ05mejRhSlV4MXIwZGVwejll?=
 =?utf-8?B?ZFIwNzhxdVhybXIvckZFRFRSVndkdWlVR3NtTmMrbUVDYzlYbHgwQllKcEIr?=
 =?utf-8?B?N3VDcENEaXRGdlVOTXpqWG1PbEFMbnQ2OW05bFhSZGZjU1JPZ3RKb1RIMnF4?=
 =?utf-8?B?SWxMUG15YXNYbUdHd3hkdzM3TTBWS3RiR1ZtZkdvSWNDbDlWaGZ6bUV6MDlU?=
 =?utf-8?B?RzV5MDJIWnY2QjlSdFo2NlhQYkVJVnFsUHgxb3dvTFF2MnAzRXdkdkhEaDJa?=
 =?utf-8?B?aTlpbCtLaDlmejdEQkVza2hsdlMwajVOUVgwSkQ3RUhWOUVZV00xWFNkeHFi?=
 =?utf-8?B?Wm9CU1REUWtZQ2ZDdnFEYmw4YldLN01WZjBYVlErcXRQbFpVTXdZc0M4cW5a?=
 =?utf-8?B?dUhXbmNPWHJ3dnlDRHd4bm92ZmIwbGVuNmFjQittU0dHZ0FBNWdqaDFOZTVB?=
 =?utf-8?B?QUdIQU1SRGRBQVZiSzY2Um1QT1BNYmI1UVhVK0c0ODNtQ05QNjZwUjRXMXht?=
 =?utf-8?B?MzYxQVpzdUU5Z3NNcGRuN1ZEWCs4TzhFOEdmcXp1V2ExcTFyK0FPc1l5UThN?=
 =?utf-8?B?ampZL0hQMVgrd2k3V2h1WW43TitMN1pBVTlDaVFqZFpBNldmYmU4WWVIeVFk?=
 =?utf-8?B?Q1lMU1gxdUlTTE5zTXpoN1E4VzcydnYvMEJxQ2xzZDJuT3dXV04xb2ZONDUy?=
 =?utf-8?B?Qjg2TEZSR0NHRjRTK2gwaGdQWGE1dGJMOWJlNzFnNEVldVgxTkhJVTZFU04v?=
 =?utf-8?B?UWZ2a09wNjJMTHIwcHUraSsrcU5CWWZPTFo3cE5sSTJVaXRWMktnWU9wanU3?=
 =?utf-8?B?SzZIME9hMEdrVEc5cVB6T0hOZzdWY1lkS1ZnUlIxdWIzaDJJZXltWkl5WkhP?=
 =?utf-8?Q?/wFN6CLYAdKKiUomkRQmT6+8T?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdb4e11a-6128-4a34-88a2-08dd3ab74dc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2025 07:35:11.4486 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ffn1FgIItCBJXUkDNGK08E+amrb0SoTW9gyOsTZmNtq8u9+5DE9qxTlDn0BICxfPKhld53KEndWYksn3MFm+YuKhBv1JeSwkfM+evgEM2OU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5989
Received-SPF: pass client-ip=2a01:111:f403:200f::715;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-SG2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

PiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFdlZG5l
c2RheSwgSmFudWFyeSAyMiwgMjAyNSAzOjA5IFBNDQo+IFRvOiBxZW11LWFybUBub25nbnUub3Jn
OyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IEpvZWwgU3RhbmxleSA8am9lbEBqbXMuaWQu
YXU+OyBBbmRyZXcgSmVmZmVyeQ0KPiA8YW5kcmV3QGNvZGVjb25zdHJ1Y3QuY29tLmF1PjsgVHJv
eSBMZWUgPHRyb3lfbGVlQGFzcGVlZHRlY2guY29tPjsNCj4gSmFtaW4gTGluIDxqYW1pbl9saW5A
YXNwZWVkdGVjaC5jb20+OyBTdGV2ZW4gTGVlDQo+IDxzdGV2ZW5fbGVlQGFzcGVlZHRlY2guY29t
PjsgQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0gg
OC85XSB0ZXN0L2Z1bmN0aW9uYWw6IFVwZGF0ZSBidWlsZHJvb3QgaW1hZ2VzIHRvIDIwMjQuMTEN
Cj4gDQo+IFRoZSBtYWluIGNoYW5nZXMgY29tcGFyZWQgdG8gdXBzdHJlYW0gMjAyNC4xMSBidWls
ZHJvb3QgYXJlDQo+IA0KPiAtIGJ1bXBlZCBMaW51eCB0byB2ZXJzaW9uIDYuMTEuMTEgd2l0aCBh
IGN1c3RvbSBjb25maWcNCj4gLSBjaGFuZ2VkIFUtQm9vdCB0byBPcGVuQk1DIGJyYW5jaCBmb3Ig
bW9yZSBzdXBwb3J0DQo+IC0gaW5jbHVkZWQgZXh0cmEgdGFyZ2V0IHBhY2thZ2VzDQo+IA0KPiBT
ZWUgYnJhbmNoIFsxXSBmb3IgbW9yZSBkZXRhaWxzLg0KPiANCj4gVGhlcmUgaXMgYSBzbGlnaHQg
b3V0cHV0IGNoYW5nZSB3aGVuIHBvd2VyaW5nIG9mZiB0aGUgbWFjaGluZSwgdGhlIGNvbnNvbGUN
Cj4gbm93IGNvbnRhaW5zIDoNCj4gDQo+ICAgICByZWJvb3Q6IFBvd2VyIG9mZiBub3QgYXZhaWxh
YmxlOiBTeXN0ZW0gaGFsdGVkDQo+IA0KPiBBZGp1c3QgYWNjb3JkaW5nbHkgdGhlIGV4cGVjdCBz
dHJpbmcgaW4NCj4gZG9fdGVzdF9hcm1fYXNwZWVkX2J1aWxkcm9vdF9wb3dlcm9mZigpLg0KPiAN
Cj4gWzFdIGh0dHBzOi8vZ2l0aHViLmNvbS9sZWdvYXRlci9idWlsZHJvb3QvY29tbWl0cy9hc3Bl
ZWQtMjAyNC4xMQ0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0By
ZWRoYXQuY29tPg0KPiAtLS0NCj4gIHRlc3RzL2Z1bmN0aW9uYWwvYXNwZWVkLnB5ICAgICAgICAg
ICAgICAgICAgfCAyICstDQo+ICB0ZXN0cy9mdW5jdGlvbmFsL3Rlc3RfYXJtX2FzcGVlZF9hc3Qy
NTAwLnB5IHwgOCArKysrLS0tLQ0KPiB0ZXN0cy9mdW5jdGlvbmFsL3Rlc3RfYXJtX2FzcGVlZF9h
c3QyNjAwLnB5IHwgOCArKysrLS0tLQ0KPiAgMyBmaWxlcyBjaGFuZ2VkLCA5IGluc2VydGlvbnMo
KyksIDkgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGVzdHMvZnVuY3Rpb25hbC9h
c3BlZWQucHkgYi90ZXN0cy9mdW5jdGlvbmFsL2FzcGVlZC5weSBpbmRleA0KPiA2MmY1MGJhYjdh
MzMuLmI1MjM1OGJiOGM2MSAxMDA2NDQNCj4gLS0tIGEvdGVzdHMvZnVuY3Rpb25hbC9hc3BlZWQu
cHkNCj4gKysrIGIvdGVzdHMvZnVuY3Rpb25hbC9hc3BlZWQucHkNCj4gQEAgLTQyLDcgKzQyLDcg
QEAgZGVmIGRvX3Rlc3RfYXJtX2FzcGVlZF9idWlsZHJvb3Rfc3RhcnQoc2VsZiwgaW1hZ2UsDQo+
IGNwdV9pZCwgcGF0dGVybj0nQXNwZWVkIEVWQicNCj4gDQo+ICAgICAgZGVmIGRvX3Rlc3RfYXJt
X2FzcGVlZF9idWlsZHJvb3RfcG93ZXJvZmYoc2VsZik6DQo+ICAgICAgICAgIGV4ZWNfY29tbWFu
ZF9hbmRfd2FpdF9mb3JfcGF0dGVybihzZWxmLCAncG93ZXJvZmYnLA0KPiAtICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJ3JlYm9vdDogU3lzdGVtIGhhbHRlZCcpOw0K
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJ1N5c3RlbSBoYWx0
ZWQnKTsNCj4gDQo+ICAgICAgZGVmIGRvX3Rlc3RfYXJtX2FzcGVlZF9zZGtfc3RhcnQoc2VsZiwg
aW1hZ2UpOg0KPiAgICAgICAgICBzZWxmLnJlcXVpcmVfbmV0ZGV2KCd1c2VyJykNCj4gZGlmZiAt
LWdpdCBhL3Rlc3RzL2Z1bmN0aW9uYWwvdGVzdF9hcm1fYXNwZWVkX2FzdDI1MDAucHkNCj4gYi90
ZXN0cy9mdW5jdGlvbmFsL3Rlc3RfYXJtX2FzcGVlZF9hc3QyNTAwLnB5DQo+IGluZGV4IDc0M2Zj
NDZlYjI5ZS4uMWZmYmE2Yzk5NTNkIDEwMDc1NQ0KPiAtLS0gYS90ZXN0cy9mdW5jdGlvbmFsL3Rl
c3RfYXJtX2FzcGVlZF9hc3QyNTAwLnB5DQo+ICsrKyBiL3Rlc3RzL2Z1bmN0aW9uYWwvdGVzdF9h
cm1fYXNwZWVkX2FzdDI1MDAucHkNCj4gQEAgLTExLDE1ICsxMSwxNSBAQA0KPiANCj4gIGNsYXNz
IEFTVDI1MDBNYWNoaW5lKEFzcGVlZFRlc3QpOg0KPiANCj4gLSAgICBBU1NFVF9CUjJfMjAyMzEx
X0FTVDI1MDBfRkxBU0ggPSBBc3NldCgNCj4gKyAgICBBU1NFVF9CUjJfMjAyNDExX0FTVDI1MDBf
RkxBU0ggPSBBc3NldCgNCj4gICAgICAgICAgKCdodHRwczovL2dpdGh1Yi5jb20vbGVnb2F0ZXIv
cWVtdS1hc3BlZWQtYm9vdC9yYXcvbWFzdGVyLycNCj4gLSAgICAgICAgICdpbWFnZXMvYXN0MjUw
MC1ldmIvYnVpbGRyb290LTIwMjMuMTEvZmxhc2guaW1nJyksDQo+IC0NCj4gJ2MyM2RiNjE2MGNm
NzdkMDI1ODM5N2ViMjA1MTE2MmM4NDczYTU2YzQ0MTQxN2M1MmE5MWJhMjE3MTg2ZTcxNWYnDQo+
ICkNCj4gKyAgICAgICAgICdpbWFnZXMvYXN0MjUwMC1ldmIvYnVpbGRyb290LTIwMjQuMTEvZmxh
c2guaW1nJyksDQo+ICsNCj4gKw0KPiAnNjQxZTY5MDZjMThjMGYxOWEyYWViNDgwOTlkNjZkNDc3
MTkyOWMzNjEwMDFkNTU0ZDBkNDVjNjY3NDEzZTEzYScNCj4gKQ0KPiANCj4gICAgICBkZWYgdGVz
dF9hcm1fYXN0MjUwMF9ldmJfYnVpbGRyb290KHNlbGYpOg0KPiAgICAgICAgICBzZWxmLnNldF9t
YWNoaW5lKCdhc3QyNTAwLWV2YicpDQo+IA0KPiAtICAgICAgICBpbWFnZV9wYXRoID0gc2VsZi5B
U1NFVF9CUjJfMjAyMzExX0FTVDI1MDBfRkxBU0guZmV0Y2goKQ0KPiArICAgICAgICBpbWFnZV9w
YXRoID0gc2VsZi5BU1NFVF9CUjJfMjAyNDExX0FTVDI1MDBfRkxBU0guZmV0Y2goKQ0KPiANCj4g
ICAgICAgICAgc2VsZi52bS5hZGRfYXJncygnLWRldmljZScsDQo+IA0KPiAndG1wMTA1LGJ1cz1h
c3BlZWQuaTJjLmJ1cy4zLGFkZHJlc3M9MHg0ZCxpZD10bXAtdGVzdCcpOw0KPiBkaWZmIC0tZ2l0
IGEvdGVzdHMvZnVuY3Rpb25hbC90ZXN0X2FybV9hc3BlZWRfYXN0MjYwMC5weQ0KPiBiL3Rlc3Rz
L2Z1bmN0aW9uYWwvdGVzdF9hcm1fYXNwZWVkX2FzdDI2MDAucHkNCj4gaW5kZXggMjE2NDAxMjNl
ZTgxLi42YWU0ZWQ2MzZhYzMgMTAwNzU1DQo+IC0tLSBhL3Rlc3RzL2Z1bmN0aW9uYWwvdGVzdF9h
cm1fYXNwZWVkX2FzdDI2MDAucHkNCj4gKysrIGIvdGVzdHMvZnVuY3Rpb25hbC90ZXN0X2FybV9h
c3BlZWRfYXN0MjYwMC5weQ0KPiBAQCAtMTYsMTUgKzE2LDE1IEBADQo+IA0KPiAgY2xhc3MgQVNU
MjYwME1hY2hpbmUoQXNwZWVkVGVzdCk6DQo+IA0KPiAtICAgIEFTU0VUX0JSMl8yMDIzMTFfQVNU
MjYwMF9GTEFTSCA9IEFzc2V0KA0KPiArICAgIEFTU0VUX0JSMl8yMDI0MTFfQVNUMjYwMF9GTEFT
SCA9IEFzc2V0KA0KPiAgICAgICAgICAoJ2h0dHBzOi8vZ2l0aHViLmNvbS9sZWdvYXRlci9xZW11
LWFzcGVlZC1ib290L3Jhdy9tYXN0ZXIvJw0KPiAtICAgICAgICAgJ2ltYWdlcy9hc3QyNjAwLWV2
Yi9idWlsZHJvb3QtMjAyMy4xMS9mbGFzaC5pbWcnKSwNCj4gLQ0KPiAnYjYyODA4ZGFlZjQ4YjQz
OGQwNzI4ZWUwNzY2MjI5MDQ5MGVjZmE2NTk4N2JiOTEyOTRjYWZiMWJiN2FkMWE2OCcNCj4gKQ0K
PiArICAgICAgICAgJ2ltYWdlcy9hc3QyNjAwLWV2Yi9idWlsZHJvb3QtMjAyNC4xMS9mbGFzaC5p
bWcnKSwNCj4gKw0KPiArDQo+ICc0YmIyZjNkZmRlYTMxMTk5YjUxZDY2YjQyZjY4NmRjNTM3NGMx
NDRhNzM0NmZkYzY1MDE5NGE1NTc4YjczNjA5JykNCj4gDQo+ICAgICAgZGVmIHRlc3RfYXJtX2Fz
dDI2MDBfZXZiX2J1aWxkcm9vdChzZWxmKToNCj4gICAgICAgICAgc2VsZi5zZXRfbWFjaGluZSgn
YXN0MjYwMC1ldmInKQ0KPiANCj4gLSAgICAgICAgaW1hZ2VfcGF0aCA9IHNlbGYuQVNTRVRfQlIy
XzIwMjMxMV9BU1QyNjAwX0ZMQVNILmZldGNoKCkNCj4gKyAgICAgICAgaW1hZ2VfcGF0aCA9IHNl
bGYuQVNTRVRfQlIyXzIwMjQxMV9BU1QyNjAwX0ZMQVNILmZldGNoKCkNCj4gDQo+ICAgICAgICAg
IHNlbGYudm0uYWRkX2FyZ3MoJy1kZXZpY2UnLA0KPiANCj4gJ3RtcDEwNSxidXM9YXNwZWVkLmky
Yy5idXMuMyxhZGRyZXNzPTB4NGQsaWQ9dG1wLXRlc3QnKTsNCj4gLS0NCj4gMi40OC4xDQoNClJl
dmlld2VkLWJ5OiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4NCg0KVGhhbmtz
DQoNCg==

