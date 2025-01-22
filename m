Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E2CEC02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 07:30:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taVB6-0001f6-F7; Wed, 22 Jan 2025 02:29:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1taVB0-0001eO-Vl; Wed, 22 Jan 2025 02:29:27 -0500
Received: from mail-sg2apc01on2070f.outbound.protection.outlook.com
 ([2a01:111:f403:200f::70f]
 helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1taVAr-0005RM-Q4; Wed, 22 Jan 2025 02:29:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fJOskI6fxUrpZE4Spm6WIh+K31UR4sCR3GXd5inHOkUFXwiFJtZpkMRFw1GZcaLArvryb7ut5UFR9XQq1BnHM3VjKK/A2YVWXbpUWMfWENVHo0t3hoitb5tWKqQsyrQ5hwN6QaFdsY7zGWF6DauJSPXVWhjXX7Hy0Y6HWXw2A7ttBsq3cNwZuiQdRqDpYbwHIBwSydavbRazRHS7Pog8ZGl57D3AYgOFQL/w7Rl4oq/EzVbPInDH8i9Wty2uVV70QUuk9mJBoS+CMR7xdqtN1Oks402sdw0c3gJoIOuWzNdFi/qmQLxpFH2UKYFTBCALJE57E4v9QEyIxz+XEfZe+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LhodHhgW7qZ/Uep3jMZ7hnpNn5a/IGmlzPKouNnjzcw=;
 b=O4DbVaF/JYNzTG8G2bS55mcnLXH7KHDWHywU8EC3Tv96yg0uFlGMRwYmVhib2g6MyrqQM7phhtIGZhdU0WrYSl4Vddu6viMJxS8Y7yZfyNyjpU2aN3h56ZFUhKZWLeM43dOimoN87z5ZZOOtl/XK0MflG9/7VSWql54AwwPtxePDWcWJvV2iFLLs6sf9oHxPZN9p0FpUMgzmOLossT7LrB8E3lbQHROPe4wMyx3GivIkYkxqjejTYPXcCtLLD64DRRgvzJyDbiPV919f7SVDtqZMZszNeFaZrpRsS9PaQsyRncA6ZY6I2WYYo9HEixl3RaQSxUvZvFrV9ge7PK536Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhodHhgW7qZ/Uep3jMZ7hnpNn5a/IGmlzPKouNnjzcw=;
 b=R7OvD6ryZOA3n6tckIBz9qEO3ax+yJX/GhjJ4OVNBcBQE8hhserTBeM6eQ8R5Gb1WxfAyhPcqTBsJLK+/BwZKelPc0gl1Awg1rB9GzVXFKlNXaEoujln1ccZWT5k12BqCna5rOIGfYJAftD7wz41aY2ITJgZh+/pjMV4hZooTvBD9NjEzPoa/JQepsPB06ENZ/N1Ri5lCeKne3/GNGx4v6WnwegxBSJcco56P3cg9Z9rWZDd2owYv8m0vdrNrK1jh/aKVPrbkeBxwO47ojyjhraZs3z2sDaQ8E/5Yvm2a4lKjzc4+9PStJWoD2n4XYzcrpKq0pxmiSW3rfe3C4cmSQ==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SEZPR06MB5166.apcprd06.prod.outlook.com (2603:1096:101:40::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.14; Wed, 22 Jan 2025 07:28:56 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.8377.009; Wed, 22 Jan 2025
 07:28:56 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Joel Stanley <joel@jms.id.au>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Troy Lee <troy_lee@aspeedtech.com>, Steven Lee
 <steven_lee@aspeedtech.com>
Subject: RE: [PATCH 7/9] test/functional: Update the Aspeed aarch64 test
Thread-Topic: [PATCH 7/9] test/functional: Update the Aspeed aarch64 test
Thread-Index: AQHbbJyizk6CQreZqEGCaud/t97pSbMiZLqQ
Date: Wed, 22 Jan 2025 07:28:55 +0000
Message-ID: <SI2PR06MB5041EE7E3762D569F0E13B2EFCE12@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250122070909.1138598-1-clg@redhat.com>
 <20250122070909.1138598-8-clg@redhat.com>
In-Reply-To: <20250122070909.1138598-8-clg@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SEZPR06MB5166:EE_
x-ms-office365-filtering-correlation-id: 6d28f687-24ed-41bb-54e9-08dd3ab66dfd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NnVxaW5pREIwR1ozQlgwdlM0QXpaMUI3bjZzMXhRK0xveWxudFgwRzZRTXpy?=
 =?utf-8?B?OWRXUlhacS9vMDhwR0FkaGQxMXhLTjFNR3J6bXJqZjNuajVlcC9uL2VlZ3ha?=
 =?utf-8?B?V25DT3oxcGhjTUs1UmlPTUZOd2NoTWlUejA2V0lIZm9ySUlqQW8wTjI3cGZw?=
 =?utf-8?B?NGtCZ0FVbXlMQzJDS0tkbCtzQ3FyTlVja0xkaldiMnNOTHVPWThSeHpFZ0l2?=
 =?utf-8?B?ZnhvTW1qUC9XTk5BYndaWCtiYUV0a1czckgyWkdUbEZIb29ZbE9raVptb2pM?=
 =?utf-8?B?MHFCY1dnaWxzUWVSTEFJOUt6TGtpVjBwbHphQnhGNHh0SzJiaG1vMkVKM2N4?=
 =?utf-8?B?UVhvS2FaUFJ4R1hidnVEWWZrM1RxM3pIWmVod1BRMWdmSzl6cUFuWSsvNGxr?=
 =?utf-8?B?a0Y3MjhrNzc2c044VVNpbjlsdzFJRlNNbkMyRnpXSzhHRjJTczlNVTRMSmFC?=
 =?utf-8?B?b05nOHNad2RjZXIvSVpBQ2xhWjNrQktIem5NbDhKNXdIK0wwZUVvdG82eHNP?=
 =?utf-8?B?OFhFc2g1TVBKSjl4bUNjdzA4WkhFR1B6bExWRGh4WU1JTlE0RGVQVDdqdlB0?=
 =?utf-8?B?UWtKZisxWERUYVdnU05Ia2hwRXdQZktHK2JITkpyQkJkUHd6UFQyZmVYL2tU?=
 =?utf-8?B?Ymd5UzUzS1pRNm9USFVNRnY1bzZYZktGeS80T1hvUnFyVkRDU2tpNzFXWEpU?=
 =?utf-8?B?K2lPaGJuM3RGQzlsdE1hdzhLd3QzTWNiUFpzM05aVi9wcGVEYko0TnU3dWZt?=
 =?utf-8?B?c29QaGNlRlJabjEyazY2MGo4SjF5RjU3RHg3R0U4QnVsK2pNdDNzMEdvUzla?=
 =?utf-8?B?aVM0alpva09WMitLVjZCdmlEY2RDL24zOTZwdmJ4c0NkdElDRTV6N3RBeFF0?=
 =?utf-8?B?Smt2L1FUU1RrNWYvZkhuNHUwTk4wNWhMRHdNMVNPSENoWFFpS3NDTkgxUDNZ?=
 =?utf-8?B?WWJrd3NScmIyN3VmSTFnTmF1SmNSNklSbWxqVmJwL1RBdlVKY2hYRXVTd00y?=
 =?utf-8?B?dmRZaXBzQUVwYWtZL09FRVVpUlloaUxjL0g0VDNNcmhPU0tMR1pMZ2pXYUpD?=
 =?utf-8?B?aHFLak5YMGhraENqQkJVVzVxT1RQSnpSeFZlNC81QWR0UldSWDBSaVVMVTNS?=
 =?utf-8?B?UmNYZ1RhcnczYlFJbkFuaktuNXZsSUwzejB6aWwvRDBtN281NnJLREgwWDNF?=
 =?utf-8?B?ZmplY3dscGNEaGJwMi8rc1puVDh0M1BBMzlxWk9EdWQxRkZ4dUxCZ0I3Mjg4?=
 =?utf-8?B?dTdGTU1GTm1FaXVwTCtNVXF0eVlJMHhLSXZReSszdXR5SVdWQ3ZZMHFSN3Iv?=
 =?utf-8?B?Rk1DNmt5WGJDMzE1MzJuRzloODVrc3l3SlZ4VXcvNkRFVXRnQmVLQlJlU1VP?=
 =?utf-8?B?ZWJrclYrRGU1Y2IweHNXM3NXTm9FcklTbkt5Qlh3UENZazlJSkNFR29EY0xY?=
 =?utf-8?B?MGM4ZUhIL2pjWk9YalRmZG04Ukk5Rzh2QjEzWmlXaGpPWGs0UWd4UTN2bHZn?=
 =?utf-8?B?L2RHYW1GRjBVaHdYTW9ObzNoRlFPdG9GTjRaN1RGYzRRRm8xbUs4Y0tDeUlB?=
 =?utf-8?B?dWtwQVNDTFdrOTcwd1BNc1liWFh3UlFZNTVyMGdSSXdVbDRKUThoTkRPTTlo?=
 =?utf-8?B?K3M3aE8zYVdjU0d4YUF1R0djWVFOSjNwbzNqUk1IRER3S0VBdjdUb0xKQ3NR?=
 =?utf-8?B?aFBSMzZxcllwZm52dXI5RWF6bEYraVllYW1SM0RmU2VNQTRaVDVBUXZvVERj?=
 =?utf-8?B?YTZ2R0hYZUEyeEZUUHM2a1dIZ1h5dWQrZVlRcS9OUHpMb2RBcGNRb1VEOHYy?=
 =?utf-8?B?MElkSWUwVllpVDd0c3JBNENuUmlvTkIwZTJZMHYyQ1lNZUFtNVh2dEpCbHNO?=
 =?utf-8?B?WVhoUytYNlNVb0ZvVW9MUTcyMU8wMndkaGVUZ2VzalptaDNiRlVnUWV4eFNa?=
 =?utf-8?Q?dOx/j505daOntGc+uXVzKUcTvidC45pN?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1dtSnlMYmlhMGVEUytlb0NKYW9xWkZRc1VmOWFaM0FsMXdxcy9oc0VSQml0?=
 =?utf-8?B?d0VCOUNPQXh5eGt1Lzk5c3dyaXhpQmgyb1U0VjdIZ2lKNEgzbXJoUEp3R0Nv?=
 =?utf-8?B?QkxVMTJXWUZYUkwyaUNqZlNueTZQR3lSTitWZTVNeVdSY003SXBXYXphSEoz?=
 =?utf-8?B?bmxjbEZsSnl5ZDgraTIwckdibzlmbytoVlBQREdZdnIwbzlTVmRkYk1tNXYw?=
 =?utf-8?B?emZiZEFDUTR1ZDloTk5nZ0loYndXekovMVFZRCtZTko2SUdRQ3I4Q2N4a1dw?=
 =?utf-8?B?RW8rSVo5VVQwdkkvdVFZNFpXczJOTGN2N2NLWTNmclBVeVE3UVdtcWhzbDc4?=
 =?utf-8?B?Q0FMd0NwSy9yVXJlT21ZYXlKRGVpQ3JEazJyemtaZERSaVNyejRNUTVPa3Bv?=
 =?utf-8?B?ZDd1WG1JYnFqMU8weUpuY1krdVB4QjJzeTdBa0xpbUVEaDBDUk0zRkcxdjk5?=
 =?utf-8?B?ZHpmMjFzeGhWNTE3dk1XZWZBWmx1Nm9xa25QSzl5SzlmK0RqU2JDZTZYbEpB?=
 =?utf-8?B?WFNlc1VZZ3RDSVZYbittQWhoVTNlbVhKMldIQ3lEcThKRUZNOVBrWnhCMFl4?=
 =?utf-8?B?NkQwVmF1dVM3OUZPeGc5VVFnMUcyVDJpYTRZeEFpNlptT094aGFwWEZTTEtQ?=
 =?utf-8?B?RmRGUGZkWjVaTlZjNFE0Y0I4ajJaRXhYbnlPWndmcjgxR2EzSitFRTZld29l?=
 =?utf-8?B?ZVhLSXhSaGwrRXc5QW9abXZVb0x4UFZUS0VZWkE0RFN2MjIyUEtEWkdaWU9X?=
 =?utf-8?B?L3ZIcSttR2J5WmZBZWh2MVFDUG9oeWJZM1h0NEJNVWEwcFNwQklvYk1mdDBI?=
 =?utf-8?B?Q2JiaHFnR1ZMRnpGS1F2T1c2N1YvRnZMUVNReHpJYkxwR3ZEY1FLaUI0KzR5?=
 =?utf-8?B?ZmUvVFdjUTh1TEtZdWdqZS9uMFhHUzhIVXhiOTNLL0M5Z1pEdlFGWGVtR0Iy?=
 =?utf-8?B?Nkc4QnJLSXRMMkwxSTgvNXpWYnJ2L01naXNXa0VkdTJVNDBVUXBSUlYwa0Nt?=
 =?utf-8?B?bzBmWmZXcHpWRVZzeXkrOS9FTE5MVm1FbG5EbHpKM05YNk0vWDZ2MWp6YlJ0?=
 =?utf-8?B?NTNjMkx1S0J0Nmx1bHl2akZzTnFrSUkySUJubXZOc3dpTkc2WXl1djdWUjJM?=
 =?utf-8?B?YWNwQ1JuaWJWdDNLUlBNdnFHQlVmVnc2L0dleFR0a2M1NHJyUlBYRmZxTlNj?=
 =?utf-8?B?dE45YzhzZjA0aUR3dXZIZW5yaGp5aWZrcjFsZ2k1RGdSUnEyN05tK0RTaWpT?=
 =?utf-8?B?SXRKZk82cGZuSXI0TEE3RytYWUNvTFlaR3lNeURhTDdTbG1jVGlyaDhxZDBm?=
 =?utf-8?B?dW40NW9TVVQ0U0Q5bTN3clJDSTBSdnBocExsb1dSRmJHcW1UdjJ3MUZtWVRL?=
 =?utf-8?B?YThVOXpIUE8ycWkzK001c0pNNzhFeDlMczRLWm1wdk9DMzF1Wkx2aUNPYkY1?=
 =?utf-8?B?TFAwQ1NlNjB4V2Y5WllSdEdpTHhqV25zT3hmMGk2ejY3bDdyQUpRaVFKMmsw?=
 =?utf-8?B?N1Zlc01jVkVsUEU2WUU4d2NRSStTNis3WFl5SUFqZ0NaRDZmT2RieWcxYzJn?=
 =?utf-8?B?aWpHaGlRWWJPMmlzTlArencxZ1F3UHV3dUtiRzVQbmdVUmplTFhrUFZXUWJv?=
 =?utf-8?B?NDJBa3JIRVZsYkNwTXhxTWlrWllxZEl6YVFabkJYZUtFenBCZnFmWnZDcVRw?=
 =?utf-8?B?ZFhEb0dYSnNTZUFnNHZQcnJ2QXJUSlhMb0pDZmZlTzJTMC80NXVTYVBJRmlz?=
 =?utf-8?B?OFhJczNydnlXSVlrZ2ptU2Q3Rm1EMGNTMTRPanYrZ2pkQmFzSWcrUG5MYTdK?=
 =?utf-8?B?MnlkcENuYktDYkUvZXM0SXNOVE4ya1BPUWRZMjdrZTNQcFNFdWZrZEx6b1ZV?=
 =?utf-8?B?V2c4UW9OeEoxY2hDd2MyN2RvSXp1Vi9oZUpzMEpsamltZTlPbS9HSWw0cTJk?=
 =?utf-8?B?bjJhM0JYTFFtVXY1ZUNFZzY1UGcwMVdxTndGemo1NjJ1ak13eEpuRTltSXFu?=
 =?utf-8?B?ZHlmZ09tVDBQRGJPSmM4NFdHZHNaN1BtQzlQZDY1NjBieUQ4cHhXeDhVNE5o?=
 =?utf-8?B?SnppZjZkNHhvWGo5WWU1MTBPanZFcUxrQ2lTdXRjaTcxY0JpRDYrOUpaYUFF?=
 =?utf-8?Q?OvEsrXQph8Zs8S0mt1ZgXZwR/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d28f687-24ed-41bb-54e9-08dd3ab66dfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2025 07:28:55.9705 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: INH8Gft1tgQ+FQsU66h344XVh+b8fdKvPwAUxa2FwoxeQkAwxwG7vtZ6b3kMF97nStHm0vl1aO9MWIsKnWOXEWRYD3WV7r9b5wgCotTFY0w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5166
Received-SPF: pass client-ip=2a01:111:f403:200f::70f;
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

SGkgQ2VkcmljLA0KDQo+IEZyb206IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0LmNvbT4N
Cj4gU2VudDogV2VkbmVzZGF5LCBKYW51YXJ5IDIyLCAyMDI1IDM6MDkgUE0NCj4gVG86IHFlbXUt
YXJtQG5vbmdudS5vcmc7IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogSm9lbCBTdGFubGV5
IDxqb2VsQGptcy5pZC5hdT47IEFuZHJldyBKZWZmZXJ5DQo+IDxhbmRyZXdAY29kZWNvbnN0cnVj
dC5jb20uYXU+OyBUcm95IExlZSA8dHJveV9sZWVAYXNwZWVkdGVjaC5jb20+Ow0KPiBKYW1pbiBM
aW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT47IFN0ZXZlbiBMZWUNCj4gPHN0ZXZlbl9sZWVA
YXNwZWVkdGVjaC5jb20+OyBDw6lkcmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+IFN1
YmplY3Q6IFtQQVRDSCA3LzldIHRlc3QvZnVuY3Rpb25hbDogVXBkYXRlIHRoZSBBc3BlZWQgYWFy
Y2g2NCB0ZXN0DQo+IA0KPiBCdW1wZWQgU0RLIHZlcnNpb24gdG8gdjA5LjAzLiB2MDkuMDQgaXMg
YXZhaWxhYmxlIGJ1dCBub3QgeWV0IHN1cHBvcnRlZCBpbg0KPiBRRU1VLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPiAtLS0NCj4gIHRl
c3RzL2Z1bmN0aW9uYWwvdGVzdF9hYXJjaDY0X2FzcGVlZC5weSB8IDggKysrKy0tLS0NCj4gIDEg
ZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvdGVzdHMvZnVuY3Rpb25hbC90ZXN0X2FhcmNoNjRfYXNwZWVkLnB5DQo+IGIvdGVz
dHMvZnVuY3Rpb25hbC90ZXN0X2FhcmNoNjRfYXNwZWVkLnB5DQo+IGluZGV4IDE0MWQ4NjM4NTkz
Ni4uNmE5YWUyYTM0OTU2IDEwMDc1NQ0KPiAtLS0gYS90ZXN0cy9mdW5jdGlvbmFsL3Rlc3RfYWFy
Y2g2NF9hc3BlZWQucHkNCj4gKysrIGIvdGVzdHMvZnVuY3Rpb25hbC90ZXN0X2FhcmNoNjRfYXNw
ZWVkLnB5DQo+IEBAIC0yNywxNCArMjcsMTQgQEAgZGVmIGRvX3Rlc3RfYWFyY2g2NF9hc3BlZWRf
c2RrX3N0YXJ0KHNlbGYsIGltYWdlKToNCj4gICAgICAgICAgd2FpdF9mb3JfY29uc29sZV9wYXR0
ZXJuKHNlbGYsICcjIyBMb2FkaW5nIGtlcm5lbCBmcm9tIEZJVCBJbWFnZScpDQo+ICAgICAgICAg
IHdhaXRfZm9yX2NvbnNvbGVfcGF0dGVybihzZWxmLCAnU3RhcnRpbmcga2VybmVsIC4uLicpDQo+
IA0KPiAtICAgIEFTU0VUX1NES19WOTAyX0FTVDI3MDAgPSBBc3NldCgNCj4gLQ0KPiAnaHR0cHM6
Ly9naXRodWIuY29tL0FzcGVlZFRlY2gtQk1DL29wZW5ibWMvcmVsZWFzZXMvZG93bmxvYWQvdjA5
LjAyL2FzdA0KPiAyNzAwLWRlZmF1bHQtb2JtYy50YXIuZ3onLA0KPiAtDQo+ICdhYzk2OWMyNjAy
ZjRlNmJkYjY5NTYyZmY0NjZiODlhZTNmZTFkODZlMWY2Nzk3YmI3OTY5ZDc4N2Y4MjExNmE3JykN
Cj4gKyAgICBBU1NFVF9TREtfVjkwM19BU1QyNzAwID0gQXNzZXQoDQo+ICsNCj4gJ2h0dHBzOi8v
Z2l0aHViLmNvbS9Bc3BlZWRUZWNoLUJNQy9vcGVuYm1jL3JlbGVhc2VzL2Rvd25sb2FkL3YwOS4w
My9hc3QNCj4gMjcwMC1kZWZhdWx0LW9ibWMudGFyLmd6JywNCj4gKw0KPiArDQo+ICc5MTIyNWY1
MGQyNTVlMjkwNWJhOGQ4ZTBjODBiNzFiOWQxNTdjMzYwOTc3MGM3YTc0MGNkNzg2MzcwZDg1YTc3
Jw0KPiApDQo+IA0KPiAgICAgIGRlZiB0ZXN0X2FhcmNoNjRfYXN0MjcwMF9ldmJfc2RrX3YwOV8w
MihzZWxmKToNCkRvIHdlIG5lZWQgdG8gY2hhbmdlIHYwOV8wMz8NCg0KT3RoZXJzIGxvb2tzIGdv
b2QgdG8gbWUuDQoNClJldmlld2VkLWJ5OiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNo
LmNvbT4NCg0KVGhhbmtzDQo+ICAgICAgICAgIHNlbGYuc2V0X21hY2hpbmUoJ2FzdDI3MDAtZXZi
JykNCj4gDQo+IC0gICAgICAgIHNlbGYuYXJjaGl2ZV9leHRyYWN0KHNlbGYuQVNTRVRfU0RLX1Y5
MDJfQVNUMjcwMCkNCj4gKyAgICAgICAgc2VsZi5hcmNoaXZlX2V4dHJhY3Qoc2VsZi5BU1NFVF9T
REtfVjkwM19BU1QyNzAwKQ0KPiANCj4gICAgICAgICAgbnVtX2NwdSA9IDQNCj4gICAgICAgICAg
dWJvb3Rfc2l6ZSA9IG9zLnBhdGguZ2V0c2l6ZShzZWxmLnNjcmF0Y2hfZmlsZSgnYXN0MjcwMC1k
ZWZhdWx0JywNCj4gLS0NCj4gMi40OC4xDQoNCg==

