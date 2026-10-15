Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED88CC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 09:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHHRp-0003H9-TG; Thu, 15 Oct 2026 05:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHHRn-0003EM-Bq; Thu, 15 Oct 2026 05:08:23 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHHRj-0003Sg-KD; Thu, 15 Oct 2026 05:08:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ATIn7e289tvYKKBpdP0NFxfhOPvSFt/0ckS39BTx7CkB0UdUBanjx04ERqbzBg6kl7vzp0RXZM4AZ+m1dGCR/Z5I8/smgnWgUPiMeo7rAzYltixvWsPRfmxb6fOIMSE6A9/i0Fpfa4wRNPbrWQ/sKzzjCx2H3yIMM+3PofVYujU3x8KRGyKJx0rRFvzCMm26nIIB8Cf/aFfokiU7Y7b4EavopFrW6lopAcx/tGH20LbdexBwS/GpWiuWpCxA5Zygev8OjStzL4RM9J7ZdInU/lhsL8Eqrm5PRwVzmOpyQYurFe9ubvxhqCD2ZuhyODHQtBz6DnylhZle3r2cdODT3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFasqH7i5K5vtVlANZetMFJkTRSDh001f3oqqRWNAZw=;
 b=Yj5A5rrv5dCendDwnJ//hi7FytIyt2oRySHWINpQcV4dvxQBEpvfABh8zzt3/N3hTM6J3xPHSbKs2tMvemZ1hpEiVQWfN2bVhLHa4J9csV5cesm166arZlcX63E9EpVJ9rPvdXQ41LGXfyESa0iXJ5ZsrLgdXOOqTHWa9/eokwx98QvV8xpJUA2nXfw1QaxaDa1yftmjycJaOmWH8GXaLMoteFuxcz5DveuVhR2FupDzseS7Ad+zzMpqnfQmr8sVu/qq18FuAN2zO5N1bLZugtyMGqC++4/mLKnMnfSzGq+OoCAhJncq+BEjzlgMMQlIj1FffpHc86UjtQm0bOw7MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFasqH7i5K5vtVlANZetMFJkTRSDh001f3oqqRWNAZw=;
 b=ilH8zUfbbKk8ZJAfphKfbnmKMz1gLebyaZPDu1ba5cSqWVHrKKwb6AjyNEbQksVG9NDGWPVZHUT7XxFGNad9gfvZrPClddcKfQqaCB9NXDMWY5Ek9R1rngnOY7HUrJKKE1prJ5FP+F/y8IfAvVmsCMVEhFBQ1m/lijZj8swpq4eAv8gxTUGOhbQO7CIVaZXqroPcfZOVZr1J98jnm270horl6lpNontPHjPjCiZZKznMVl+9CG1FWcRwYEoUK4TYkqGIsmBONDbbGzDjUPjPMwLPh+TFKMM9iIXEk834ObD7SasZSLSWUkze5Cr8PupcK3FmotLeho0/pON8eY1uwA==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TY0PR06MB5469.apcprd06.prod.outlook.com (2603:1096:400:27f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Thu, 15 Oct
 2026 09:08:08 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 09:08:07 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>
CC: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v4 7/8] hw/usb/redirect-server: Stream interrupt IN
 endpoints
Thread-Topic: [PATCH v4 7/8] hw/usb/redirect-server: Stream interrupt IN
 endpoints
Thread-Index: AQHdW7CpqukpKISz10Ow54RlzxCrm7b9ZdUAgADr9lA=
Date: Thu, 15 Oct 2026 09:08:07 +0000
Message-ID: <SEZPR06MB7362E817A42C944859C9EAD5FC9C2@SEZPR06MB7362.apcprd06.prod.outlook.com>
References: <20261014075011.2708115-1-jamin_lin@aspeedtech.com>
 <20261014075011.2708115-8-jamin_lin@aspeedtech.com>
 <179200457099.338496.3833991068027849650.b4-review@b4>
In-Reply-To: <179200457099.338496.3833991068027849650.b4-review@b4>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TY0PR06MB5469:EE_
x-ms-office365-filtering-correlation-id: f27e1494-0f99-4f1c-0d2b-08df2a9bd432
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|6133799003|10067099003|18002099003|22082099003|4143699003|38070700021|261009223027099003|56012099006;
x-microsoft-antispam-message-info: lcWM/eomkYbbr2dDXb2ZXU1v2oSMVC4KWq5IyMKbQRtsVRvDalaStN81gfxN5qHdU5FuITAcEtLOolFIO9ROvSLEXGJrKt5bFDIvTaqAe2XL+AGIHj+bhPu3o/dDSMyamp0AAFJcaLdb/fUyEd3l8Z03ZnnCYmcOgla7VvyY+XCLsCSJ/e0RmSRpk/SK/7WtDngopanTfQ5hB6TZC/27VuC/q6aOcpg0mad3SxXC/qbscJ8MaQrN6iG1SGgbAn2pG6G1bTYUB5fwCadb8uhjtRyRPMkQqBgkwsnVUFGoeUXIZnPT+yv+IuHSF/6xWXFJ0a0fZK04Y+sASRteOlLWSEWWh9Kvm+6EBAodPudpnW75wRX2BJA4W8gnXZR9d2D2gOOihJ0P7SD2YBrlfEkk3vCFMa4nhpBl9nBjdKAa9IUc5pH58uPAF3zjn1qBZFZQS2jbNqfUEaSxCxnsQqdhdYr6GqHPmyaW0rGaSdzbck0Nof/Ld/d7dq7tw5QJ4FWPS5d8/wyPr85p6giU1MCPUQDJoi+42gWdeNYwhaBe8vbjok05rphzhkn3bij19yEt9BEVfGHMknFDgkeZ1oaP18KFz5FbtD431LAtZBgOoq9zbvHBXEQvTurKZ9LhINkIWvo90qSvjKinHyGcmsj/btz9/Rwq+OYqT72i2n0+fMN8LO/IKXQcil0tcr72NlSL1UsXGRlPviu3VUfxFGUHg0+n5Mx7oLPp5nmeWx61Uao=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(6133799003)(10067099003)(18002099003)(22082099003)(4143699003)(38070700021)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGdCQWtmZXhaZmFKM3ltQVNIbStoNFpYbzNyWmMrNzRKcFRtSlhSZDd2Rk0v?=
 =?utf-8?B?NHpuMHdqTnlqV1J4cXQwSVIvUjhmTVJIeUlXTDdBeC9UeUF3ajdackpxRStO?=
 =?utf-8?B?MkMxNVZlUmVmdUpqSHVhcmJFblhvaWxGOXR2anczSURkd0I0YlFWSE1xUWpL?=
 =?utf-8?B?NHhOdnBHQzJlSzliVnFPYitTMXZlSTZmZktHNE1Fbmg2TmRNMU1paTFlOVFk?=
 =?utf-8?B?aEM1TGEyckRNUlRFRnpwZFRYTkpEYklIa2VCdGxHaVJicDJCb2dTQlRoQ1pi?=
 =?utf-8?B?QXNXNEMySWY4dFpXSXl2eWR0NWIxay8wbUJCbk9XODlLMHV0Q3V2cGMxdlpF?=
 =?utf-8?B?QVpnSjV0MHpoTzF2M3BEU3g3eklHdXZVMTRxNGZMRVA0YVphUzZsd3VWcnRp?=
 =?utf-8?B?UmFBL1BpWGdaNnRRY2Q2V0pNQ2ZLMjlrZnBwSVpDcExKcjBjTFJjclZMbVkz?=
 =?utf-8?B?bjlVM3N4QVRHT1lNSGFPRERrdlI4cThGNzFYOTV6K0YvSmk1ZTR1d0xYTXYv?=
 =?utf-8?B?OE5qaHZ5QjFQTWJ3V1FnN3MvMDBRb21CUm1zZ0x0VVFxdjZjVUFzejVZdVhM?=
 =?utf-8?B?RVRhZGFLd25Rem55UU5jOEcyU1pwS1U0eUpYaUVhdDJqYnFIOGJYVVRoQkhx?=
 =?utf-8?B?VDl6aVdDRy8zV2ErK1VyemhhQUpHTENFbWdld0dhK2JzZ2pveE1ScE5sSVRB?=
 =?utf-8?B?cDU2Nks4U2ltaVJnU1hlRnpZMkhEbDJaZHRtVFVQM3dQMSs2WUpZbEFNTmZi?=
 =?utf-8?B?dWUxYXRqZ0ZOUktxd3FXVGpVbG5qSmhERU5PUXM5Y3QxVmNNb0VuVjJYRUxM?=
 =?utf-8?B?RnlXYnBpdFlyNzdOV3hKQysvTGt1Y0xINGpmclVMT1VFK2x2MUFqOVNXYlZh?=
 =?utf-8?B?Y3Baekl2WTJmSzV3WmtyRTBtN0ZBYVZtby9ScVlaOHhabHEvb1d6MndVa0lX?=
 =?utf-8?B?QzUrQ3Fxd1BwUUVJOEFKS1gvMkhOQWh0YVNieHhXSWJva3h1WUpjVWZPeldy?=
 =?utf-8?B?Y0JLeGQrUTdMcnlGcUttUGswL1JZWmJoNWV4T1V2aEJjd3ZxSllTZkJiUUlt?=
 =?utf-8?B?L0Iyc29TaW0wc2dsRkNKZXBLNE1MamZ1OEdXQmt5ekFYTk5Jd0p3b0xlN3Vq?=
 =?utf-8?B?VEp4cDJ6QVZsSTQ1bDhuVjFDVFA4RGtkeWVRMEZ1eDEzcmpSajlqUmI0a21a?=
 =?utf-8?B?ZnBmVUlCd1I0RVpidjdCVFRlL0pwTjVmc1JrYlR6cVlmcTN0TFBmeXBmUG4v?=
 =?utf-8?B?UHBnU2pXa3FXZnVNNmlWUG5oZzhJZFg0elpOU1c2NUdCeXprdDFhV3UrRGw0?=
 =?utf-8?B?dXJocHdSNWJ1SEhGaUY0blBhZ0VxRzlER25pTzR4ditsY3BPYzFHZlZUUEtO?=
 =?utf-8?B?ZFkrM3NOZXlkRW5IODN2SzBvdDhTZ25TZndueUl2ZXkrSVNuMCtRUHJmN0ho?=
 =?utf-8?B?cStUSnIyVUJoYVQyWFNwelQzWCt0NDJWalZyZExpZkhrTitmWEdZWlhsdXNV?=
 =?utf-8?B?T2hMdzFkdnRYcXRYSHZOeWtDN3VpcUwxajBlaUF2UEhLb09MSW80TmlyZDlN?=
 =?utf-8?B?dWZnbmk5eG5oNC9YQy9VaHhNc2ovNTNIZHFCdTFNZEo4TG9KTndGL242a0NH?=
 =?utf-8?B?VHRXelYwYnFKNzhQZlBFS3FIUGQ3Z3pqb3hiR0VCb1pEcWgwRW0yZTlHbENE?=
 =?utf-8?B?Sk1aVWh1NzNVZ1Z5eURiS09MQ1pNMkV2eUdvMVBEUE1TZnJzclNINjRTNlNp?=
 =?utf-8?B?OHg4emhGcFlnQnJUWVFicGNTT2U5SHVCY0NMTkJFS2VlYlZraWFpQmQreTVF?=
 =?utf-8?B?QlFZRzNyVld4UVZ0ckJLVHo0d1pMZzNDRTJVOE15ckpLcWt1K0RGK3J6MjNa?=
 =?utf-8?B?cGdiMG1OeEMyTk1DU29iVmlzckRmdEQ4RW1kb3BFalFPQVBIS2JMM0hRQTVy?=
 =?utf-8?B?eVlncjRzZW8wWHdZdlAwcXFlR0RmeURNbDRrMmp4OFAzdllYUnVRTERtOHJz?=
 =?utf-8?B?VHI4WHArYkVDc0tLd2Y3anQ5Wi9seUJEcVl6ZUZsSkkwRHlNMmtEb2ZBNjhx?=
 =?utf-8?B?aUdyRytXcXROdkFlaWkwVTBZRnBqTlJoaUN1cFVHTFE2S3RDZkR0WHpqdVB6?=
 =?utf-8?B?S0VJcm01eEkrNFRFRmtWZDdIOVloTkl1b3ZHZlVuQnF5S3FDN0o3VnRQd1BB?=
 =?utf-8?B?K25JMy9RZFhDS0p5YTViaHhMbmZxWWxsQVp4WnoxajJsbDFheEdOWmZMaFM2?=
 =?utf-8?B?M3phOWgxQzJwV3hCc21aaWlPRG1BaWlUOXQ5dmRjTWNXRENEb3FyMkZvQVZC?=
 =?utf-8?B?S2NxVDIwMU1BeTAvTGFicXQ3Wm9kMHZMVXI4K2lMc1pjcXYwSUkrUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: aXede5mHooE26NA0WiQAP1OESBQxpJvmQYPiaPYXWayddodlk6HZ2Tey7vSdT3x1+8Tmb4qr9b+dLnSy7iZgQ1otk8QuLCQpt2FnA4KBNAtoyAt3aEJsYm2s3kQoMbVz352xmR4vrcje6NQS/cYWL1vhVCr/6+fhVpkeGfoIT1u78p7Boefvv9guzEpApl8aCiyMiIw8jzv2EOaWutMh7juVNumMLl+Vf5jJWBlcUIicrefnZhAvYA0RcMtPtg2Vyw8aOwW3x8WlrsNeBjq1el//0YvDHpn58lg5gSYTMzdB/RluZRx+Pe7CWpG7tGW0CfI9EqezgAUYf0eOuRpQKQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f27e1494-0f99-4f1c-0d2b-08df2a9bd432
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 09:08:07.7930 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Kasho51F2qvM10wbRN24g+0rZpgeYIOI2hnPUB3ajc2H/hkFCA3MubHLRauZ/u6y3KY/DAxEfmszJcPDP9/+1+WesLUE2ROq/NEDXH4y3M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5469
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

SGkgTWFyYy1BbmRyw6kgTHVyZWF1DQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCA3LzhdIGh3
L3VzYi9yZWRpcmVjdC1zZXJ2ZXI6IFN0cmVhbSBpbnRlcnJ1cHQgSU4NCj4gZW5kcG9pbnRzDQo+
IA0KPiA+IEludGVycnVwdCBJTiBpcyBub3QgYSByZXF1ZXN0IGFuZCBhbiBhbnN3ZXIgaW4gdXNi
cmVkaXIuIFRoZSBob3N0IGFza3MNCj4gPiBvbmNlIHdpdGggc3RhcnRfaW50ZXJydXB0X3JlY2Vp
dmluZy4gQWZ0ZXIgdGhhdCBpdCBleHBlY3RzIGEgcGFja2V0DQo+ID4gZXZlcnkgdGltZSB0aGUg
ZGV2aWNlIGhhcyBkYXRhLg0KPiA+DQo+ID4gUGFyayBvbmUgSU4gcGFja2V0IG9uIHRoZSBkZXZp
Y2UgZm9yIGVhY2ggc3RyZWFtaW5nIGVuZHBvaW50LiBBIGRldmljZQ0KPiA+IHRoYXQgYW5zd2Vy
cyBVU0JfUkVUX0FTWU5DIGhvbGRzIHRoZSBwYWNrZXQgYW5kIGNvbXBsZXRlcyBpdCB3aGVuIGl0
DQo+ID4gaGFzIGRhdGEuIEEgZGV2aWNlIHRoYXQgYW5zd2VycyBVU0JfUkVUX05BSyBnaXZlcyB0
aGUgcGFja2V0IGJhY2sgYXQNCj4gPiBvbmNlLCBzbyBwYXJrIGEgbmV3IG9uZSB3aGVuIHRoZSBi
dXMgcmVwb3J0cyBhIHdha2V1cCBvbiB0aGF0IGVuZHBvaW50Lg0KPiA+IEEgc2xvdyB0aW1lciBw
YXJrcyBvbmUgdG9vLCBmb3IgYSBkZXZpY2UgdGhhdCBkb2VzIG5vdCByZXBvcnQgYSB3YWtldXAu
DQo+ID4NCj4gPiBXYWl0IGZvciB0aGUgZW5kcG9pbnQncyBiSW50ZXJ2YWwgYmVmb3JlIHBhcmtp
bmcgdGhlIG5leHQgb25lLiBTb21lDQo+ID4gZGV2aWNlcyBhbnN3ZXIgZXZlcnkgdGltZS4gV2l0
aG91dCB0aGUgd2FpdCB3ZSB3b3VsZCBhc2sgYXMgZmFzdCBhcw0KPiA+IHRoZSBtYWluIGxvb3Ag
cnVucywgYW5kIHRoZSBndWVzdCB3b3VsZCBnZXQgbm8gdGltZS4NCj4gPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPg0KPiA+IE1lc3NhZ2Ut
SUQ6IDwyMDI2MTAxNDA3NTAxMS4yNzA4MTE1LTgtamFtaW5fbGluQGFzcGVlZHRlY2guY29tPg0K
PiA+DQo+ID4gZGlmZiAtLWdpdCBhL2h3L3VzYi9yZWRpcmVjdC1zZXJ2ZXIuYyBiL2h3L3VzYi9y
ZWRpcmVjdC1zZXJ2ZXIuYyBpbmRleA0KPiA+IGJmNTI4NmI2NDk5Ni4uYzYxMzE0N2ZiZDBhIDEw
MDY0NA0KPiA+IC0tLSBhL2h3L3VzYi9yZWRpcmVjdC1zZXJ2ZXIuYw0KPiA+ICsrKyBiL2h3L3Vz
Yi9yZWRpcmVjdC1zZXJ2ZXIuYw0KPiA+IEBAIC01Niw2ICs1Niw3IEBADQo+ID4gICNpbmNsdWRl
ICJxZW11L21haW4tbG9vcC5oIg0KPiA+ICAjaW5jbHVkZSAicWVtdS9tb2R1bGUuaCINCj4gPiAg
I2luY2x1ZGUgIm1pZ3JhdGlvbi92bXN0YXRlLmgiDQo+ID4gKyNpbmNsdWRlICJxZW11L3RpbWVy
LmgiDQo+ID4gICNpbmNsdWRlICJxZW11L2N1dGlscy5oIg0KPiA+ICAjaW5jbHVkZSAiaHcvY29y
ZS9zeXNidXMuaCINCj4gPiAgI2luY2x1ZGUgImh3L3VzYi91c2IuaCINCj4gPiBAQCAtODIsMTYg
KzgzLDMwIEBAIE9CSkVDVF9ERUNMQVJFX1NJTVBMRV9UWVBFKFVTQlJlZGlyU2VydmVyLA0KPiA+
IFVTQl9SRURJUl9TRVJWRVIpICAjZGVmaW5lIFVTQlJFRElSX1NFUlZFUl9NQVhfRVAgMzIgICNk
ZWZpbmUNCj4gPiBVU0JSRURJUl9TRVJWRVJfRVBfSU5fQkFTRSAxNg0KPiA+DQo+ID4gKy8qIEFu
IGVuZHBvaW50IG51bWJlciBpcyA0IGJpdHMsIHNvIDAgdG8gMTUuICovICNkZWZpbmUNCj4gPiAr
VVNCUkVESVJfU0VSVkVSX01BWF9FUF9OUiAxNg0KPiA+ICsNCj4gPiAgLyoNCj4gPiAgICogVGhl
IGJ1bGsgbGVuZ3RoIGZpZWxkIGlzIDMyIGJpdHMsIHNvIHRoZSBob3N0IGNhbiBhc2sgZm9yIHVw
IHRvIDQgR0IuDQo+ID4gICAqIFRoaXMgaXMgdGhlIGxhcmdlc3QgdHJhbnNmZXIgYWNjZXB0ZWQu
DQo+ID4gICAqLw0KPiA+ICAjZGVmaW5lIFVTQlJFRElSX1NFUlZFUl9NQVhfQlVMSyAoMSAqIE1p
QikNCj4gPg0KPiA+ICsvKiBCdWZmZXIgc2l6ZSBmb3IgYW4gaW50ZXJydXB0IElOIGVuZHBvaW50
IGJlZm9yZSBpdHMgZGVzY3JpcHRvciBpcw0KPiA+ICtzZWVuLiAqLyAjZGVmaW5lIFVTQlJFRElS
X1NFUlZFUl9JTlRSX0RFRkFVTFRfTEVOIDY0DQo+ID4gKw0KPiA+ICsvKg0KPiA+ICsgKiBBc2sg
YWdhaW4gdGhpcyBvZnRlbiBhZnRlciBhbiBlbmRwb2ludCBhbnN3ZXJlZCBOQUsuIE1vc3QgZGV2
aWNlcw0KPiA+ICt3YWtlDQo+ID4gKyAqIHRoZSBidXMgd2hlbiBkYXRhIGFycml2ZXMsIGFuZCB0
aGVuIHRoZSBuZXh0IGFzayBoYXBwZW5zIGF0IG9uY2UuDQo+ID4gK1RoaXMNCj4gPiArICogdGlt
ZXIgaXMgZm9yIHRoZSBkZXZpY2VzIHRoYXQgZG8gbm90IHdha2UgdGhlIGJ1cy4NCj4gPiArICov
DQo+ID4gKyNkZWZpbmUgVVNCUkVESVJfU0VSVkVSX0lOVFJfUkVUUllfTVMgMTAwMA0KPiA+ICsN
Cj4gPiAgI2RlZmluZSBVU0JSRURJUl9TRVJWRVJfQ1RSTF9TRVRVUCAwDQo+ID4gICNkZWZpbmUg
VVNCUkVESVJfU0VSVkVSX0NUUkxfU1RBVFVTIDEgICNkZWZpbmUNCj4gVVNCUkVESVJfU0VSVkVS
X0JVTEsgMg0KPiA+ICNkZWZpbmUgVVNCUkVESVJfU0VSVkVSX0lOVFIgMw0KPiA+ICsjZGVmaW5l
IFVTQlJFRElSX1NFUlZFUl9JTlRSX1NUUkVBTSA0DQo+ID4NCj4gPiAgLyogV2hpY2ggbWVzc2Fn
ZSBhbnN3ZXJzIHRoZSBob3N0IHdoZW4gYSBjb250cm9sIHRyYW5zZmVyIGVuZHMuICovDQo+ID4g
dHlwZWRlZiBlbnVtIHsgQEAgLTE0MCw2ICsxNTUsMTYgQEAgc3RydWN0IFVTQlJlZGlyU2VydmVy
IHsNCj4gPiAgICAgIGJvb2wgaG9zdF9jb25uZWN0ZWQ7DQo+ID4gICAgICBib29sIGRldmljZV9h
bm5vdW5jZWQ7DQo+ID4NCj4gPiArICAgIC8qDQo+ID4gKyAgICAgKiBJbnRlcnJ1cHQgSU4gc3Ry
ZWFtaW5nLiBpbnRyX2luX3N0YXJ0ZWQgaXMgaW5kZXhlZCBieSBlbmRwb2ludA0KPiA+ICsgICAg
ICogbnVtYmVyLiBpbnRyX3RpbWVyIGFza3MgdGhlIGRldmljZSBhZ2FpbiwgYWZ0ZXIgdGhlIGVu
ZHBvaW50J3MNCj4gPiArICAgICAqIGludGVydmFsIG9yIGFmdGVyIGEgTkFLLiBpbnRyX2JoIGFz
a3MgYXQgb25jZSB3aGVuIHRoZSBkZXZpY2Ugc2F5cw0KPiA+ICsgICAgICogaXQgaGFzIGRhdGEu
DQo+ID4gKyAgICAgKi8NCj4gPiArICAgIGJvb2wgaW50cl9pbl9zdGFydGVkW1VTQlJFRElSX1NF
UlZFUl9NQVhfRVBfTlJdOw0KPiA+ICsgICAgUUVNVUJIICppbnRyX2JoOw0KPiA+ICsgICAgUUVN
VVRpbWVyICppbnRyX3RpbWVyOw0KPiANCj4gV2h5IG5vdCBoYXZlIG9uZSB0aW1lciBwZXIgZXA/
DQo+IA0KDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldyBhbmQgc3VnZ2VzdGlvbi4NCldpbGwgZG8N
CkphbWluDQoNCj4gLS0NCj4gTWFyYy1BbmRyw6kgTHVyZWF1IDxtYXJjYW5kcmUubHVyZWF1QHJl
ZGhhdC5jb20+DQoNCg==

