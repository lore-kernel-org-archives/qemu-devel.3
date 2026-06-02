Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB9ECD6E4A
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 03:35:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUFtg-0006ek-3U; Mon, 01 Jun 2026 23:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wUFtd-0006dx-Jr; Mon, 01 Jun 2026 23:34:29 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wUFta-00044s-OV; Mon, 01 Jun 2026 23:34:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CgCEJxaoXJOFU6C7OPENrqaAvRIh0xBr7e6A6JKWVEXFsAbcVVv8uYrTlooK3PBiaFih9CiwHeNd4VlZCJd2UZhfil6QrdjYncXnz5wh4rzi+1/GJnILq/qVjIqU10Eajvu9jcR/+Fl/NqGiDP3FH0ikQovmOMWsRbAfHAv+3RfUg1TQywN2EP/AcThsZh03BkWfhqtGelgep6GdjZOr3cFsYQtYCPLG0L6H03xi2PydenUDTASDlCE64AtffjfE8UmSBIkL2yk2+1yTIOelo75A4mXW7F5T+8vePt9LtkCimdUjc4Hphl8CaCopCu+z0Zoyp2/PS7ncjnxI3hjLYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4hyECDKO1Yz7stgb6au04eGScyu6gj6Y28Gxr3Hyh98=;
 b=vx0CB9goGVKGhdlqTUD1SvkmTv8bTPDBVCzXRDrfqCX3yXswfLNrnrfBOFBzerOq90c2Nm7UEIy9gyt9Un9Yyt3WdBR8mtNxeXnPmz5YO8YyOhxnIXisgQ9iWVhOdH3A+fwT1ouWm/g/QtzYtdlEsliSVes1uOowlj51EVCQe9x5Gj1iLMZBIxwQawc0H0dBIj9gTVVpYE7yRtF3QBcLiP+YUsEDMQC3CPnBM/mQ8jAoSiFnsFui/nZdeq0MKvA2M7JmOnQSq6A4mm0mOgzbU0fdzNdapadCO1h5A9wIYIWhBXTehvAfQAvThNo2ZSoteBCq2ldArfO7/fpD3l8U5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4hyECDKO1Yz7stgb6au04eGScyu6gj6Y28Gxr3Hyh98=;
 b=J1s6f+zUdZfJIRDDJrHijbAqmRVlZTNeh3wTOX7RT+4BDXJymNWAmZVmE+iHRVM13zbi+MZeFlNPi9LJp3YyxijvPqlhzEbt/qcms3cqAjnp+tub6Vl82DfRQoO1aNZCUYstziU9pTPIz0aCvjEdGaIHVgpeyVke1DgW8RotLwS6GzoznZdqtxfmT5Dlih/K0XeO+QCrQnl9nM57FrgW/v2/Gf9QxDrV9nXg2l55DSo6IBBNk8QAWKHP7HKwR/qN+To3OO8ObLplGESUP23S80ypyraZ+Hge9nVPd9xfYT5Jj39rPFu5UcZhbqIaAbL+m+s5GBPQsgIt9Zrsm+XrOQ==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TY0PR06MB5756.apcprd06.prod.outlook.com (2603:1096:400:27e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 03:34:19 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%5]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 03:34:18 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1 07/10] hw/i2c/aspeed_i2c: Introduce AST1040 I2C model
Thread-Topic: [PATCH v1 07/10] hw/i2c/aspeed_i2c: Introduce AST1040 I2C model
Thread-Index: AQHc7zZfJ/DGFR9jj02PJYaIajPf1LYprfIAgAD0rtA=
Date: Tue, 2 Jun 2026 03:34:18 +0000
Message-ID: <TYZPR06MB49803163ACBA35DC218EE5B5FC122@TYZPR06MB4980.apcprd06.prod.outlook.com>
References: <20260529064243.2064188-1-jamin_lin@aspeedtech.com>
 <20260529064243.2064188-8-jamin_lin@aspeedtech.com>
 <1e706d5e-3124-47ee-9f00-d06ea1d4dbaa@kaod.org>
In-Reply-To: <1e706d5e-3124-47ee-9f00-d06ea1d4dbaa@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TY0PR06MB5756:EE_
x-ms-office365-filtering-correlation-id: bbf939f3-b337-4636-0db2-08dec057d443
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|22082099003|38070700021|4143699003|56012099006;
x-microsoft-antispam-message-info: GurIkNxji/UV8Mc/giChytS2xDr8EOMDWsBWdxc/Sxp3pYrChePiZO0yrS3Xl4uIKuPhldyZbl3yCcPHMtF1hQMIqG9Gl2yRQjvNrPFonnwELnAnFekIXQmdPGj5/wKIj8CQ+3wO+mdQRDxm1tzpv3shbFMatXmNrsZmBDe1kcssGQz3/b9PgLEpOQB2pRsoqqBtsN25+KaxOfJsHsvJBGtzA53pE2ZH4m2RNCsbj3WbBMoAdYjFCbYH3opQ5ArXpTVqHtN3fkdRU8d88SnKlLh8wZGuzKWWQUn0iwRwb1cGehHn1Ldfy097e6eE/7rYSkG4nfBbjD7T6FrRa02+qiRvtMvzwNB4yQIwA/WYnfDLMEN02QQDftb37nMZ0RXJMv3djhYNikmFLKI1O5dkiHkkO0wGyo/+qjrAj7I+iiYuvmD2J5B0kLCUmHuBMu6J4CcorH4SQ1UExxn6ouYcGOcO36ApoYRvzYUFupPn2kr0DOKEHk5yCyfuweatWCGwYRO5J+zYl0TefmG6eXTVDi+TM0f1kcmJmZ14Ps4jAK8M5dk5j4x9KIiIoZP+Vl0L5bUrJBD6V89Y+831zRBBynvA8zGBsQsZJArCJKQdK8yqcdFDFwAeicHvqdJNeHH6Fo2oF07nQJqr0Mm6lPks2u81VeNYFTyE9JiOU7GfUkABdsVP8hVkH+m2VlDIVW9GjfNuvX8Z4H/tXOxK2UPGloSIBbVUg7fTtX2nmvxpSmL1/6IBfDNE3nlwQ2A8+vPO
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(38070700021)(4143699003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aE5wcTZxNjcyc1JkT2pXcjByUkFsT3BvUHBUMHF6WWUzVjJyN3ZzZkpHN3ZD?=
 =?utf-8?B?YnV1MHpyMjk4eWRSWHZVZGIveVpUZFJaWUNQRXROcDc2S0tsbVA3aXFWcUho?=
 =?utf-8?B?K2daR2FFWmJaNVFZWWlsLzJHekMzTHRDNUVQbGplVVp4c1JkL2Y5dUo0ZUQ1?=
 =?utf-8?B?SHV2YVBuNHZUdU1rVVBVQTc0MDBuaXRiWUx4SDc5czB0ODNkVW5lVWkwb3FN?=
 =?utf-8?B?OXVTMEFHYnd4eHF6dVZuUVRJdDRBakFGTFBta0RsUnNWMFZUMEtxYWZOL3pT?=
 =?utf-8?B?Y2ExcTZTSDR4QjRXeXJxQTByOVJmbS95Qm9Da3AzVEUvbHFLV3dBYzdrOUNZ?=
 =?utf-8?B?N2I3VUt5dGZuVUFwd1hQejIvU1B2WUpmSEtCalVDKzRaVjFUeGhNbjNWNUk2?=
 =?utf-8?B?Ukc3cGVTWThWSXRDQ3lYOUhBYU01d0tjR2dtMkdRb2pmczRTT1IxcWNSNHhT?=
 =?utf-8?B?Q2VtNDYyeU9XRldWV1BxWFhNWVFQOEhpZ2pqelRoTjB5czBFK0dKUUd5elRv?=
 =?utf-8?B?aExMcHZ4bmdZUlVmTWhWdU0ydEQyengybXVRTUlkNkFaLzdXeWswY2wzN3U1?=
 =?utf-8?B?L2JKVW8zL3ZBNkJTT1dXc2ZDTGNEd2YvRmtzYnp0dE1xbjlSYm9wRGxBckU3?=
 =?utf-8?B?Tk9qazRTR3g1Uzl4VmxJZG1IODJOSHNRSGExLzJRZW4yV1RzaXU1VVNXNEZ2?=
 =?utf-8?B?a0xxSU1WemN5aFZRY2tKM3dCSXpIWlpGK0ttQXpYS1h5a0w5SFZZbHE1RUMr?=
 =?utf-8?B?K1RjcnZUSVVUL3lRRUVMT01xNjBraWF4eHVHdks4dEJpTFZWd2VTNFpZSndP?=
 =?utf-8?B?eU40R3E0OXlpUnVJTjRQanhQZVd3dU4xOWpMWUJLVHRvRTRLUlhERGoreHZP?=
 =?utf-8?B?K3JrdURVcmwvWWtPdG1ualo1SmFObC9JN0FocXZlWlNVYzVGRnNTUHBUbVJI?=
 =?utf-8?B?bWJNb21uZW9ibTArbEhreDJveEtSOW5yVWpraTJuditJNVFwbmVwZWhpaDJK?=
 =?utf-8?B?K3RlQmw5NWlFQjZFTnB5NmtuM1dtRFdMeTFGNTltaGRybDJRckpUUzNDckpv?=
 =?utf-8?B?Rm1rdHpxeWExMEl5ZmdaT0RsZEcyQ3hOOHRzamlOQUR0a0Z2MHZnNEd2d2tV?=
 =?utf-8?B?TERzSjhDNDVDYWJDWFdPYTNQMVY3ZDFmaWkxbCtpMXU3eTBiTnhpZkFSUzh4?=
 =?utf-8?B?TmtiWGNQbVB0NUJUcUlXTk9PTERzVW5Ra2FmVzJYOVVYWXpsM3Vnc1loTk1F?=
 =?utf-8?B?VUExS0RsKzN5OEZNQU5VWnFqT2gySnRvWW5UaitPMHdDaFJvbzlBWWdZd2Jn?=
 =?utf-8?B?NStkamR5cUorS1VjdnZvemplb1dPSFlvdkhNVXhMOUhhQ3UrQ1hGYmpXTlVn?=
 =?utf-8?B?MGpFVGZaU2hEYXdwUlQzY2NWekprQ1pvM1RNVHBDZGovc01oczdGYlJPV0RQ?=
 =?utf-8?B?dlVEZXBUTjV4UlpzZ1psNldkVjJKdTFKNGEvTzM4LzlVWkdqSms1WkxFam1Z?=
 =?utf-8?B?MFpwUkVGWVByc080N3JJRUNYS1RJbTFGQVkyT3h1aUN1dUF5ZTEreUR5RmtL?=
 =?utf-8?B?MDgwODZKQlQ0V01Rd3cvQjRUL1h6UDNCb0toUjN6TTZaWmhWN09xc3A2YjNI?=
 =?utf-8?B?Z0M3aEVHWnNEc1NXaWFXZXdIY2hmMFpoSE5NWE5sc2RzVnpuZ2E2UmxXdkY5?=
 =?utf-8?B?YTBJTSt4dFVlYlFmeG45S2d1ZlFuUUQ4VlVEY3E0NW1QdFpsa1JhTmRRYlZ2?=
 =?utf-8?B?TWUrMmRTTkFhamRyblMvTERWTkdUT0VFSUIySE5EODdRUVoxbkFFTUFLOEpH?=
 =?utf-8?B?c0J1ZW1FejI1dHlubjhXYUFUNmhkV0tSQ3ZhdC93bG9penk0MENZY3IxaVFl?=
 =?utf-8?B?NHpVYUdJdFNyQVNidmhvY2sxd3NIMnNEOVRzYnUvSTlyMDFtYk1URVEvYmg0?=
 =?utf-8?B?U24xbVZaSXB3VFNoWEpubEtqc1ZJcEtqcW4xTGtxbnNNZzlqaEpHTnF4b1FE?=
 =?utf-8?B?M0xaaVBFWGVDWUlobEFnNXNSSlJBMlUxOHlITEVPYXZ1MzRWSTBRdlhBWXYr?=
 =?utf-8?B?bkJqdDBFdndWNzBmQnRYUTNtMnpqdVpYN2lMNzkwZzBBdkE0MUdVT3B6VmM5?=
 =?utf-8?B?b0ROM3RJdDlHOEdpZElpTUo5WFpNTEJSN3NJN0dhN3MvWWhyd2Y5emZlUEg2?=
 =?utf-8?B?Tk5vd1B4cE1ycHFxSkNLbXR0Z0hNSVcvWVZTSGF2c1lyL21udE51UjVUVGI4?=
 =?utf-8?B?SjVEOEpsRVhJY3JmM2t0RWxwaVBmOXRqeVdoSUdVOEhmNEdxSmxTaU9menZJ?=
 =?utf-8?B?N3JWZ0tKV1hRUENTWUh6Z0pLNk9SRm9DYkhQYS9URjFCZnFFQ2M3QT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: FVhHAXzMMN2suilF1Y823Pn+dLIngN8TBAiUHRA6JnLLNtl8oZSgXlHzRpBRp9eoiU0m8Gii4Q0/E6Q8rg1zsAus1UllZXvgcf+BmSEUVC2gulQYqwtMpR0ukCqGJ9dnL0L3EmeTppHJw2mL+O8PIh17h5946BOI6XACgsgOBJjDwZ1QY/VAMyCiJRe48W5q+W5z3h2EIAojYyAr9tqLsNwPeUm6LxQK8ywdOnseDZVE7VhgborgD7pYfEnIm7Nn4VZ6qYa8t+8psQl8Teap/zScSxBSnkfaOP9Fnyr13Dec+AnlxWKmXAL+TQ0kEE2b2j8Sfx/QDSintojORl6lbA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbf939f3-b337-4636-0db2-08dec057d443
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 03:34:18.9007 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +z1QDHebtDMXosAfvc0X2kLonVQiJWMHSH25+R5uMBoS5aUdxau/XZYf9QwOHPfmhTMUTAixub2jClZd9pqxADocMqSgh3V60EDxc1/PQog=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5756
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

SGkgQ8OpZHJpYw0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcgYW5kIHN1Z2dlc3Rpb24uDQoNCj4g
U3ViamVjdDogUmU6IFtQQVRDSCB2MSAwNy8xMF0gaHcvaTJjL2FzcGVlZF9pMmM6IEludHJvZHVj
ZSBBU1QxMDQwIEkyQw0KPiBtb2RlbA0KPiANCj4gT24gNS8yOS8yNiAwODo0MiwgSmFtaW4gTGlu
IHdyb3RlOg0KPiA+IEludHJvZHVjZSB0aGUgQVNUMTA0MCBJMkMgY29udHJvbGxlciBtb2RlbC4N
Cj4gPg0KPiA+IFRoZSBBU1QxMDQwIEkyQyBjb250cm9sbGVyIGlzIGNvbXBhdGlibGUgd2l0aCB0
aGUgQVNUMjcwMCBJMkMNCj4gPiBjb250cm9sbGVyLCBpbmNsdWRpbmcgRE1BIHN1cHBvcnQgYW5k
IHRoZSA2NC1iaXQgRE1BIGFkZHJlc3MNCj4gPiByZWdpc3RlcnMuIFNldCBoYXNfZG1hNjQgc28g
ZmlybXdhcmUgY2FuIGFjY2VzcyB0aGUgaGlnaCBhZGRyZXNzDQo+ID4gcmVnaXN0ZXIgYW5kIHBy
b2dyYW0gaXQgdG8gemVybywgYXMgdGhlDQo+ID4gQ000IENQVSBvbmx5IHN1cHBvcnRzIDMyLWJp
dCBhZGRyZXNzaW5nLg0KPiA+DQo+ID4gU2luY2UgQVNUMTA0MCBoYXMgMTZNQiBIeXBlclJBTSwg
bGltaXQgdGhlIERNQSBsb3cgYWRkcmVzcyBtYXNrIHRvDQo+ID4gMHgwMGZmZmZmZi4NCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPg0K
PiA+IC0tLQ0KPiA+ICAgaW5jbHVkZS9ody9pMmMvYXNwZWVkX2kyYy5oIHwgIDEgKw0KPiA+ICAg
aHcvaTJjL2FzcGVlZF9pMmMuYyAgICAgICAgIHwgMjkgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysNCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgMzAgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4g
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvaTJjL2FzcGVlZF9pMmMuaCBiL2luY2x1ZGUvaHcvaTJj
L2FzcGVlZF9pMmMuaA0KPiA+IGluZGV4IGIyZTRkMmZiOWQuLjE1Njk5OGU3YzEgMTAwNjQ0DQo+
ID4gLS0tIGEvaW5jbHVkZS9ody9pMmMvYXNwZWVkX2kyYy5oDQo+ID4gKysrIGIvaW5jbHVkZS9o
dy9pMmMvYXNwZWVkX2kyYy5oDQo+ID4gQEAgLTMwLDYgKzMwLDcgQEANCj4gPiAgICNkZWZpbmUg
VFlQRV9BU1BFRURfMjUwMF9JMkMgVFlQRV9BU1BFRURfSTJDICItYXN0MjUwMCINCj4gPiAgICNk
ZWZpbmUgVFlQRV9BU1BFRURfMjYwMF9JMkMgVFlQRV9BU1BFRURfSTJDICItYXN0MjYwMCINCj4g
PiAgICNkZWZpbmUgVFlQRV9BU1BFRURfMTAzMF9JMkMgVFlQRV9BU1BFRURfSTJDICItYXN0MTAz
MCINCj4gPiArI2RlZmluZSBUWVBFX0FTUEVFRF8xMDQwX0kyQyBUWVBFX0FTUEVFRF9JMkMgIi1h
c3QxMDQwIg0KPiA+ICAgI2RlZmluZSBUWVBFX0FTUEVFRF8yNzAwX0kyQyBUWVBFX0FTUEVFRF9J
MkMgIi1hc3QyNzAwIg0KPiA+ICAgT0JKRUNUX0RFQ0xBUkVfVFlQRShBc3BlZWRJMkNTdGF0ZSwg
QXNwZWVkSTJDQ2xhc3MsIEFTUEVFRF9JMkMpDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaHcvaTJj
L2FzcGVlZF9pMmMuYyBiL2h3L2kyYy9hc3BlZWRfaTJjLmMgaW5kZXgNCj4gPiA1YmU2ZmVmYzRk
Li44NDE4YTBhNjg2IDEwMDY0NA0KPiA+IC0tLSBhL2h3L2kyYy9hc3BlZWRfaTJjLmMNCj4gPiAr
KysgYi9ody9pMmMvYXNwZWVkX2kyYy5jDQo+ID4gQEAgLTE3MDIsNiArMTcwMiwzNCBAQCBzdGF0
aWMgY29uc3QgVHlwZUluZm8gYXNwZWVkXzEwMzBfaTJjX2luZm8gPSB7DQo+ID4gICAgICAgLmNs
YXNzX2luaXQgPSBhc3BlZWRfMTAzMF9pMmNfY2xhc3NfaW5pdCwNCj4gPiAgIH07DQo+ID4NCj4g
PiArc3RhdGljIHZvaWQgYXNwZWVkXzEwNDBfaTJjX2NsYXNzX2luaXQoT2JqZWN0Q2xhc3MgKmts
YXNzLCBjb25zdCB2b2lkDQo+ID4gKypkYXRhKSB7DQo+ID4gKyAgICBEZXZpY2VDbGFzcyAqZGMg
PSBERVZJQ0VfQ0xBU1Moa2xhc3MpOw0KPiA+ICsgICAgQXNwZWVkSTJDQ2xhc3MgKmFpYyA9IEFT
UEVFRF9JMkNfQ0xBU1Moa2xhc3MpOw0KPiA+ICsNCj4gPiArICAgIGRjLT5kZXNjID0gIkFTUEVF
RCAxMDQwIEkyQyBDb250cm9sbGVyIjsNCj4gPiArDQo+ID4gKyAgICBhaWMtPm51bV9idXNzZXMg
PSAxNjsNCj4gPiArICAgIGFpYy0+cmVnX3NpemUgPSAweGEwOw0KPiA+ICsgICAgYWljLT5yZWdf
Z2FwX3NpemUgPSAweDYwOw0KPiA+ICsgICAgYWljLT5nYXAgPSAtMTsgLyogbm8gZ2FwICovDQo+
ID4gKyAgICBhaWMtPmJ1c19nZXRfaXJxID0gYXNwZWVkXzI2MDBfaTJjX2J1c19nZXRfaXJxOw0K
PiA+ICsgICAgYWljLT5wb29sX3NpemUgPSAweDQwOw0KPiA+ICsgICAgYWljLT5wb29sX2dhcF9z
aXplID0gMHhjMDsNCj4gPiArICAgIGFpYy0+cG9vbF9iYXNlID0gMHgxYzA7DQo+ID4gKyAgICBh
aWMtPmJ1c19wb29sX2Jhc2UgPSBhc3BlZWRfMjUwMF9pMmNfYnVzX3Bvb2xfYmFzZTsNCj4gPiAr
ICAgIGFpYy0+aGFzX2RtYSA9IHRydWU7DQo+ID4gKyAgICBhaWMtPm1lbV9zaXplID0gMHgyMDAw
Ow0KPiA+ICsgICAgYWljLT5oYXNfZG1hNjQgPSB0cnVlOw0KPiA+ICsgICAgYWljLT5kbWFfYWRk
cl9sb19tYXNrID0gMHgwMGZmZmZmZjsgfQ0KPiANCj4gQWJvdmUgY29uc3RhbnRzIGFyZSBzaW1p
bGFyIHRvIFRZUEVfQVNQRUVEXzI3MDBfSTJDLiBJdCdzIHdvcnRoIGEgY29tbWVudC4NCj4gDQpX
aWxsIGFkZC4NCj4gPiArDQo+ID4gK3N0YXRpYyBjb25zdCBUeXBlSW5mbyBhc3BlZWRfMTA0MF9p
MmNfaW5mbyA9IHsNCj4gPiArICAgIC5uYW1lID0gVFlQRV9BU1BFRURfMTA0MF9JMkMsDQo+ID4g
KyAgICAucGFyZW50ID0gVFlQRV9BU1BFRURfSTJDLA0KPiA+ICsgICAgLmNsYXNzX2luaXQgPSBh
c3BlZWRfMTA0MF9pMmNfY2xhc3NfaW5pdCwgfTsNCj4gPiArDQo+ID4gICBzdGF0aWMgdm9pZCBh
c3BlZWRfMjcwMF9pMmNfY2xhc3NfaW5pdChPYmplY3RDbGFzcyAqa2xhc3MsIGNvbnN0IHZvaWQN
Cj4gKmRhdGEpDQo+ID4gICB7DQo+ID4gICAgICAgRGV2aWNlQ2xhc3MgKmRjID0gREVWSUNFX0NM
QVNTKGtsYXNzKTsgQEAgLTE3MzksNiArMTc2Nyw3IEBADQo+ID4gc3RhdGljIHZvaWQgYXNwZWVk
X2kyY19yZWdpc3Rlcl90eXBlcyh2b2lkKQ0KPiA+ICAgICAgIHR5cGVfcmVnaXN0ZXJfc3RhdGlj
KCZhc3BlZWRfMjUwMF9pMmNfaW5mbyk7DQo+ID4gICAgICAgdHlwZV9yZWdpc3Rlcl9zdGF0aWMo
JmFzcGVlZF8yNjAwX2kyY19pbmZvKTsNCj4gPiAgICAgICB0eXBlX3JlZ2lzdGVyX3N0YXRpYygm
YXNwZWVkXzEwMzBfaTJjX2luZm8pOw0KPiA+ICsgICAgdHlwZV9yZWdpc3Rlcl9zdGF0aWMoJmFz
cGVlZF8xMDQwX2kyY19pbmZvKTsNCj4gPiAgICAgICB0eXBlX3JlZ2lzdGVyX3N0YXRpYygmYXNw
ZWVkXzI3MDBfaTJjX2luZm8pOw0KPiA+ICAgfQ0KPiA+DQo+IA0KPiB0aGUgdHlwZSBpbmZvIHdp
bGwgbmVlZCBhbiB1cGRhdGUgYmMgb2YNCj4gDQo+IA0KPiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9xZW11LWRldmVsLzIwMjYwNjAxMDI0OTU5LjIzNDc2MzktMS1qYW1pbl9saW5AYXMNCj4gcGVl
ZHRlY2guY29tLw0KPiANCldpbGwgZG8uDQoNClRoYW5rcywNCkphbWluDQoNCj4gQW55aG93LA0K
PiANCj4gUmV2aWV3ZWQtYnk6IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0LmNvbT4NCj4g
DQo+IFRoYW5rcywNCj4gDQo+IEMuDQoNCg==

