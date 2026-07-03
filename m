Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A66C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 09:36:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfaK1-0007QB-1i; Fri, 03 Jul 2026 05:36:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wfaJv-0007FH-1l; Fri, 03 Jul 2026 05:36:28 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wfaJs-00040u-Gl; Fri, 03 Jul 2026 05:36:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gcozhMFMdjZBwvphxvfRFv37kvVbHrot7/vQeSBQ6iv3jSpgSzLc35Iiqib9rEfYFlzeLOzwA1F6gxJYu1UsnohtS5GY4pFyXLd/hsU1Rvq7sfQGklGyR2bTzZWJOur0OypbPsBE9wqIImDUB1g3J4V19foten7yko4fj3Fq/UtkC0D0V5bZcL4ZPP1UekFjyZ+yGIMlG5KgUESMBwLUT9pL0XkKCrfePYAv3f/OGXIuGrDLYxKnvM2RZKMQXdntf40P5nU0kH0PKOCXtYuNqmdca63uZ4BEUrgmRYDWJaHIlOn9EROBI3rJt6QmXHmnWvy13oZ0eymD2vkrR00M3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vn8qUCDSas6Nm7RVJwizDohLP+OC+RjwSWeD5f/kW54=;
 b=aiUf5irCPvMheAc8lGA9D1pcfQ9mqofMfQZYM79w9In+e6XMNy4yZ8sZRTMmf/hM0mw6n5ytQsjWHHXYIa/F/Aw3zz7/LPvQ5yPoAf4ib7UFcxd2s/3xLXaDImKiZRUU5bMB4hYy1gby/SEzEtAHAa9j8irXhCZu0fSda0FTayQ+Xrr9kVDaxJdEmvY5rrbXPC159xvBnWK5ekeW4gvgazhacqTpegta4itmlJBwaYHU4YnrwS4owKXnG0Ins8k5S8mX1Qurbq0uvbrLDPx4mwV2FWauAQ7C1xjXUQjqCwa30S9QzWaZOCklnsgJN21lA4H1aFnfwTvJXVDLziMC0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vn8qUCDSas6Nm7RVJwizDohLP+OC+RjwSWeD5f/kW54=;
 b=rRon4O8IY2JdY8bWsr/frir1iu7Fy1dXVzrXWRbNhIw5bQ/oqsKTZUYnBSVcAUltlshke6zQSOxDY9+85eccxhJs4YhQmfLrMUMOg/NdlUeRBS/qR3iI73CfHhJpJqTnSc2nd07CLlURjFb8FWQNgzlvXWYLay5tDe6suE75lELStDPssjwLGIix1nnAnYyZ77THRvdfI9C0Hg33NUPXlHxcLl3kCccX4YfgPCVnVO7A9YCUoJXdfiO+Zh5b1eOrW6QXj9Nl9Nl4+XLC0WkRDuc8TlQs4ekpPQteu9cNq6c7kz8anNTp9QTiq52Fg+o7pJv4OPx7FXzHVUtTGAY0cg==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEYPR06MB5256.apcprd06.prod.outlook.com (2603:1096:101:83::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 09:36:17 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 09:36:17 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@oss.qualcomm.com>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1 4/5] hw/arm/aspeed_ast27x0: Add unimplemented Privilege
 Controller MMIO regions for SSP/TSP
Thread-Topic: [PATCH v1 4/5] hw/arm/aspeed_ast27x0: Add unimplemented
 Privilege Controller MMIO regions for SSP/TSP
Thread-Index: AQHdCrd+ZtN6L3PHxEuFNmiVsOOwerZbhj+AgAAC26A=
Date: Fri, 3 Jul 2026 09:36:17 +0000
Message-ID: <TYZPR06MB49808ECD0E677137915CBA34FCF42@TYZPR06MB4980.apcprd06.prod.outlook.com>
References: <20260703064506.937904-1-jamin_lin@aspeedtech.com>
 <20260703064506.937904-5-jamin_lin@aspeedtech.com>
 <492afb3a-328d-4354-a620-10e1aa0a2ec9@oss.qualcomm.com>
In-Reply-To: <492afb3a-328d-4354-a620-10e1aa0a2ec9@oss.qualcomm.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SEYPR06MB5256:EE_
x-ms-office365-filtering-correlation-id: f16a5ada-7f79-4b99-354c-08ded8e68834
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|56012099006|4143699003|18002099003|22082099003|38070700021|921020;
x-microsoft-antispam-message-info: XwYkTTL04C63dbdmiuseg5oM3a0HyaawymVYNNqrOXet9Y8Y0jdugE6KoFe0gyXsFIV1D1L5QVyNqFmbl44r8xd0Jy/tFMQLQNRNI+lq37115svwv5mUgs54L0B/+g15SDEiRyKpZ9VkrMBB0S6UXwUyzd9fpH/KOALw+uo3zbE3qEF1b7ILsm2bbwZuHKq86dt/7sOWDgYdTZ1rzUuB5NSglFJC8qVriHBtYObv5Kcx8j1DDMfY/1ZnPL3G9cNc+Jp6QtRdRyHHzPzdzDuwsEHYhwDoCx73AYIqoGe1gtXP3kmT+Pe+8ZGhZmvI+sajkyE+215hjXUnXZrPZ3Sm23mL228jhZQVcKOjVycJxtqTisBz4ANBwLYKHTOst6Z5IsC5+2KWikYIyNbGDJRYeIW2VnTbG2vINHa/o8+ZnMYQjbvg1XeweFbffr5QWhSI7aTfWgYxoJtuRVULh192Khl0g9cT27MSOlW+Anj2s7v8y3lRpmgpcN7hA1MuvHqjWRubGQl2u7GpawnYQvOsMjGKCuJkt52l56Qul9nGw396fIA1ftV3ryTHQJS4RDUXFYqDTmU/IHkoswvlRRLHOZTrA3EvS1tldC38aUSGkhExTOotqAFGM77s7bCM3mFrm3Jl5QzXfnOCtXilnXyBsoPPnI7ddnPX6oK9WuOrWlpd3Gax+qM878dGb5gsM3D+pUSTC05ha9NnLbl3YPm2v+1J1vFsAULsWLxXTD/aavI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(56012099006)(4143699003)(18002099003)(22082099003)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YVYvY1JGdXhLWXA1ay9DYWpiZ2d2S0d6RURZWlZieHA4bTJjM2VrYUhKdHI2?=
 =?utf-8?B?QzJneXJHQld2aGROaEZlVUdHNm1JcDNSb2NSczBETkR6MVN1Q0pydVMzTXI2?=
 =?utf-8?B?bzdIbUU4Z0hxK3Rrc2VoSXY5eWtJdXB4bjVGVHVyQnpxU0FTS2xKTVdLZnJV?=
 =?utf-8?B?SngyTXhDS0ZKNG5LZU4rMC9LM2paNW5hWlcyZ1F0U05aRlhEYjd1RWtRUkZv?=
 =?utf-8?B?T0JMUklma2pvQXRXQW9scHc1R0xZRURUOTFvYjJYNWttaU85bDY3SUNUN2ZO?=
 =?utf-8?B?dFlBSnk5MzJ6cEI5Z0VjblJDclN0dlNzR0pVWWpnWDJTcUlTQW5abDNkY3di?=
 =?utf-8?B?RGg4TnprSWVTRVlQb3VwMUlybHhhU3VZcENZYVY0Sm1mQXdQNDJmNm5UeHJN?=
 =?utf-8?B?QVVnd0VqZmp0RGFtWVl1RE1sWTM2QlpldTQzSXVBWkFISWpZMGRmZHZ5Ymk2?=
 =?utf-8?B?N1VTUkRPeW1TelJsTmtVVXlTa1piSGIyVC9WaVZaa0hGSnJIeHV6K3hSMnd3?=
 =?utf-8?B?Wit4NGdadHBjcDhBR01OOFUzdy9hZHBPSG1zZFMrbDRSTWFkM2lkeXovMVhy?=
 =?utf-8?B?a04rU09FcEhoUlFWc0lRdFhBTEwwVUNUK0piNVpGSnpmWmIxNVBmYmY1VFkz?=
 =?utf-8?B?MmVWZnVJVzFRbHRCYlhIZUsvdHFja3RmMkdxRmRKaEtIWWhMcDNVVlN1eUY0?=
 =?utf-8?B?ZGpsWCtCRGlJc1FLUTdUMXpycytMM2VvSzJoUGNHT1NNVkdTT0IzUi8wMVF3?=
 =?utf-8?B?ZWJXcmg5Zk5FMWlKQ0wrbEtHZmRrWWNFaDZCcllnTnpsRUowRmx3NUhpVzg5?=
 =?utf-8?B?OXNwSzcyWmNsTVRwUWtDSHFtdVA0bFRzSzVHNkgvUm1CWkxiT3RMVkdTbzhu?=
 =?utf-8?B?VmVJaVpOMmxGSk0wcEVtYWUxbllCM1NodzQ2Y05waDVqM1Q3cExkcDlPY2Zr?=
 =?utf-8?B?Zy9zdHBwUElnQ2JUbjJMdjNLR2ZuSUg3aWJwK1JwcnNwbHh2UVlpYlVwb3or?=
 =?utf-8?B?bGsySEFqMDlxc3I4MnBwZHArbXdSMWwxaURmbTF1Qk9adGQxOVlIUitiMytn?=
 =?utf-8?B?dEQySWVRYWdPbEtZNlV6TmhOY1ZFRE0vSzVUSDVNSVgrVXZMRlVGOEJmMHR4?=
 =?utf-8?B?SkZjTXBxK1dwK3hKdzM5YmxKWE0yT3V3dml1MGxzQzE0NUIwd0lIK1MvRStz?=
 =?utf-8?B?dlhZNDlzanZJWHB2L0R6U0oxeGpSSmQxNFNHRTVNTjZFV2RydnltdVR6Snhz?=
 =?utf-8?B?Z0VrL21iVVN5VFBsTnM4djVJRFU5VkxieXhvcnE4Qjc5U0NjdFFGbmFLOHZR?=
 =?utf-8?B?dGxhVVJzcFhOVnV1NktZOG93cy9hdzhMQmFQaWx0b29QeE9IRHhhWkEwOURt?=
 =?utf-8?B?bEVWZERjRkFmRC9hMCt4dGV2cEtETnBuNGxDWnZDUWNRcE82T1d1VmVlNVBw?=
 =?utf-8?B?b1o1MklvNUpjOWlNOXNzQ3lWNU1kMmpyeWRyNzlxRHdiWVNUcmoxaVRnWk5F?=
 =?utf-8?B?KzdjTkFaUnlHZ3pWdnJyMFJSZG0wUXhpWE1KQ3ViL3Q3d1V2UDBJaHlxRE1t?=
 =?utf-8?B?ZDJUWDVkYktJWk85UDNYTkYzSC9uQlNkOEo0djhkZm40cnQvKzlLNzZRQkJI?=
 =?utf-8?B?Z2tEZ1p0eFNxZ1lFYlJLUHZzMFE5UFJlakN2cHFMcVBidmZSWGo4M05NY3FW?=
 =?utf-8?B?d0RqaFBLNlEveU0xQnQ1MzREeCtvYXpFenNvemdtYTRsd2pUWU5wSGtUQWRs?=
 =?utf-8?B?a2dxVDRWL1lSc3BWUmd4RUN5UXlQeE52TUNmdmlCdEMydnVaQVpxRDdyNTYv?=
 =?utf-8?B?QW1CMGE5NnJmb0p0ajF6Y2N5M3c5akVGZjBNV055a1A3RlNjcEQvOUkyZTRN?=
 =?utf-8?B?a204alJKS0R5cEFDN3BRT2QxNEtpdUlhQ3pxbUQxVUQ2TDJzY21sbklUelY0?=
 =?utf-8?B?UExQeStKQ3NtU2VtQ09ySjBKSXE2VlF3SzdNY0JsUUNIRWlDeHB2UVNkY1Uv?=
 =?utf-8?B?aFRPVnAzT3ZBOXNvTGpnWld4ZGtCL2QwRFdyalZxSnQrdUo2UXR1WGg3dGc2?=
 =?utf-8?B?RHV6akVwZU5TTHNhN2FxaUp4My9obTFDZnMrSndvV3JoaWlObnJxL3d3cVNC?=
 =?utf-8?B?RkZPVG1leWIyS3ZYREhnbnd3T21UWkh5RlkvSks0ZVBZU2FDZHpFTkRyU0lm?=
 =?utf-8?B?Y3ZIYU9WY2t2UjVUVXlwWWFIOHo5bmV0QmlkR2FKOGJ1K1hjYkYxbkFBSWk4?=
 =?utf-8?B?WnBZUktjbnY5SzZ3T1hYOHR5blZ6MFdyU3FWbjVKNnU0VUx6NEllSVd6a1JI?=
 =?utf-8?B?VGxjdURjdUZDdzBBNlBybjdSTHNFVFBISVB4dkRBVENvbkJrSFZ6UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: RLBhRjMxzo4YbKp19sdptTd8y3uOUzvcnl7WYNNZtqP3JDBfrnkoPW/QgSmnrk+XWDRwYisfejsfnUAklakCII7dMdCtVA8f5gdVdWs0ZMePNwm1S4gkh9oCwHSSquVBn7X5o1r9A6BdNtcK70hY2Oe28v9wuxe4kjCRQ66dnXnEY7vUFMJtDfP4TjS7ZxkEK7ogeGd/mzHq7xhcdKPIM57/lS8E7oLHB8Nf1EVnCbhaTVfFVNk+OOhUD3W8Pf9/AKlZv+c6KnYylcX4BqKmsWI2cCy00JeEaQbydSfB+eKFQL4brOKUyFyb+FdYT/WsGlx2+d0r+aFysJSpgJVXeQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f16a5ada-7f79-4b99-354c-08ded8e68834
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2026 09:36:17.1859 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wfzqMJsI1k/JaeeCnF2d1/svkDhQiWMepQWJeaGhO5wk9+D4OBy6V6bBUD1IM/ZbpKBU73JRTH8CUfD2tXxXtLKBHLInL/7PyDbPGZ6OyWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5256
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SGkgUGhpbGlwcGUNCg0KPiBQcml2aWxlZ2UgQ29udHJvbGxlciBNTUlPIHJlZ2lvbnMgZm9yIFNT
UC9UU1ANCj4gDQo+IE9uIDMvNy8yNiAwODo0NSwgSmFtaW4gTGluIHdyb3RlOg0KPiA+IFRoZSBB
U1QyNzAwIFNTUC9UU1AgZmlybXdhcmUgYWNjZXNzZXMgUHJpdmlsZWdlIENvbnRyb2xsZXIgTU1J
Tw0KPiA+IHJlZ2lvbnMgdGhhdCBhcmUgbm90IHlldCBpbXBsZW1lbnRlZCBpbiBRRU1VLg0KPiA+
DQo+ID4gVGhpcyBjaGFuZ2UgYWRkcyB1bmltcGxlbWVudGVkIE1NSU8gZGV2aWNlcyBmb3IgdGhl
IFByaXZpbGVnZQ0KPiA+IENvbnRyb2xsZXIgYmxvY2tzIGFuZCBtYXBzIHRoZW0gdG8gdGhlaXIg
Y29ycmVzcG9uZGluZyBwaHlzaWNhbA0KPiA+IGFkZHJlc3NlcyBpbiB0aGUgU1NQL1RTUCBhZGRy
ZXNzIHNwYWNlLiBUaGVzZSBzdHViIGRldmljZXMgYWxsb3cgUUVNVQ0KPiA+IHRvIHNhZmVseSBo
YW5kbGUgZmlybXdhcmUgYWNjZXNzZXMgYW5kIHByZXZlbnQgc3B1cmlvdXMgZXhjZXB0aW9ucywN
Cj4gPiB3aGlsZSBhY2N1cmF0ZWx5IHJlZmxlY3RpbmcgdGhlIGhhcmR3YXJlIG1lbW9yeSBtYXAu
DQo+ID4NCj4gPiBObyBmdW5jdGlvbmFsIGNoYW5nZXMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGlu
Y2x1ZGUvaHcvYXJtL2FzcGVlZF9jb3Byb2Nlc3Nvci5oIHwgIDEgKw0KPiA+ICAgaW5jbHVkZS9o
dy9hcm0vYXNwZWVkX3NvYy5oICAgICAgICAgfCAgMiArKw0KPiA+ICAgaHcvYXJtL2FzcGVlZF9h
c3QyN3gwLXNzcC5jICAgICAgICAgfCAxMyArKysrKysrKysrKysrDQo+ID4gICBody9hcm0vYXNw
ZWVkX2FzdDI3eDAtdHNwLmMgICAgICAgICB8IDEzICsrKysrKysrKysrKysNCj4gPiAgIDQgZmls
ZXMgY2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygrKQ0KPiANCj4gDQo+ID4gZGlmZiAtLWdpdCBhL2h3
L2FybS9hc3BlZWRfYXN0Mjd4MC1zc3AuYyBiL2h3L2FybS9hc3BlZWRfYXN0Mjd4MC1zc3AuYw0K
PiA+IGluZGV4IGIzYzRlYjE5MTUuLjFiNjhlNGViNWYgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvYXJt
L2FzcGVlZF9hc3QyN3gwLXNzcC5jDQo+ID4gKysrIGIvaHcvYXJtL2FzcGVlZF9hc3QyN3gwLXNz
cC5jDQo+ID4gQEAgLTIyLDEwICsyMiwxMyBAQCBzdGF0aWMgY29uc3QgaHdhZGRyDQo+IGFzcGVl
ZF9zb2NfYXN0Mjd4MHNzcF9tZW1tYXBbXSA9IHsNCj4gPiAgICAgICBbQVNQRUVEX0RFVl9TRFJB
TV0gICAgID0gIDB4MDAwMDAwMDAsDQo+ID4gICAgICAgW0FTUEVFRF9ERVZfU1JBTTBdICAgICA9
ICAweDcwMDAwMDAwLA0KPiA+ICAgICAgIFtBU1BFRURfREVWX0lOVENdICAgICAgPSAgMHg3MjEw
MDAwMCwNCj4gPiArICAgIFtBU1BFRURfREVWX1BSSUMwXSAgICAgPSAgMHg3MjE0MDAwMCwNCj4g
PiAgICAgICBbQVNQRUVEX0RFVl9TQ1VdICAgICAgID0gIDB4NzJDMDIwMDAsDQo+ID4gICAgICAg
W0FTUEVFRF9ERVZfVElNRVIxXSAgICA9ICAweDcyQzEwMDAwLA0KPiA+ICAgICAgIFtBU1BFRURf
REVWX1VBUlQ0XSAgICAgPSAgMHg3MkMxQTAwMCwNCj4gPiAgICAgICBbQVNQRUVEX0RFVl9JUEMw
XSAgICAgID0gIDB4NzJDMUMwMDAsDQo+ID4gKyAgICBbQVNQRUVEX0RFVl9GTUNdICAgICAgID0g
IDB4NzQwMDAwMDAsDQo+ID4gKyAgICBbQVNQRUVEX0RFVl9QUklDMV0gICAgID0gIDB4NzQxMDAw
MDAsDQo+ID4gICAgICAgW0FTUEVFRF9ERVZfU0NVSU9dICAgICA9ICAweDc0QzAyMDAwLA0KPiA+
ICAgICAgIFtBU1BFRURfREVWX0lOVENJT10gICAgPSAgMHg3NEMxODAwMCwNCj4gPiAgICAgICBb
QVNQRUVEX0RFVl9VQVJUMF0gICAgID0gIDB4NzRDMzMwMDAsDQo+IA0KPiANCj4gPiBkaWZmIC0t
Z2l0IGEvaHcvYXJtL2FzcGVlZF9hc3QyN3gwLXRzcC5jIGIvaHcvYXJtL2FzcGVlZF9hc3QyN3gw
LXRzcC5jDQo+ID4gaW5kZXggNjA5OGQxYWFlMy4uNTlkY2NjZDUxMSAxMDA2NDQNCj4gPiAtLS0g
YS9ody9hcm0vYXNwZWVkX2FzdDI3eDAtdHNwLmMNCj4gPiArKysgYi9ody9hcm0vYXNwZWVkX2Fz
dDI3eDAtdHNwLmMNCj4gPiBAQCAtMjIsMTAgKzIyLDEzIEBAIHN0YXRpYyBjb25zdCBod2FkZHIN
Cj4gYXNwZWVkX3NvY19hc3QyN3gwdHNwX21lbW1hcFtdID0gew0KPiA+ICAgICAgIFtBU1BFRURf
REVWX1NEUkFNXSAgICAgPSAgMHgwMDAwMDAwMCwNCj4gPiAgICAgICBbQVNQRUVEX0RFVl9TUkFN
MF0gICAgID0gIDB4NzAwMDAwMDAsDQo+ID4gICAgICAgW0FTUEVFRF9ERVZfSU5UQ10gICAgICA9
ICAweDcyMTAwMDAwLA0KPiA+ICsgICAgW0FTUEVFRF9ERVZfUFJJQzBdICAgICA9ICAweDcyMTQw
MDAwLA0KPiA+ICAgICAgIFtBU1BFRURfREVWX1NDVV0gICAgICAgPSAgMHg3MkMwMjAwMCwNCj4g
PiAgICAgICBbQVNQRUVEX0RFVl9USU1FUjFdICAgID0gIDB4NzJDMTAwMDAsDQo+ID4gICAgICAg
W0FTUEVFRF9ERVZfVUFSVDRdICAgICA9ICAweDcyQzFBMDAwLA0KPiA+ICAgICAgIFtBU1BFRURf
REVWX0lQQzBdICAgICAgPSAgMHg3MkMxQzAwMCwNCj4gPiArICAgIFtBU1BFRURfREVWX0ZNQ10g
ICAgICAgPSAgMHg3NDAwMDAwMCwNCj4gPiArICAgIFtBU1BFRURfREVWX1BSSUMxXSAgICAgPSAg
MHg3NDEwMDAwMCwNCj4gPiAgICAgICBbQVNQRUVEX0RFVl9TQ1VJT10gICAgID0gIDB4NzRDMDIw
MDAsDQo+ID4gICAgICAgW0FTUEVFRF9ERVZfSU5UQ0lPXSAgICA9ICAweDc0QzE4MDAwLA0KPiA+
ICAgICAgIFtBU1BFRURfREVWX1VBUlQwXSAgICAgPSAgMHg3NEMzMzAwMCwNCj4gSXQgd291bGQg
YmUgY2xlYXJlciB0byBzZXQgQVNQRUVEX0RFVl9GTUMgaW4gYSBkaXN0aW5jdCBwYXRjaCwNClRo
YW5rcyBmb3IgdGhlIHJldmlldy4NCkFTUEVFRF9ERVZfRk1DIHNob3VsZCBiZSByZW1vdmVkLg0K
V2lsbCBmaXggaXQuDQoNCkphbWluDQoNCj4gb3RoZXJ3aXNlOg0KPiBSZXZpZXdlZC1ieTogUGhp
bGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBvc3MucXVhbGNvbW0uY29tPg0KDQo=

