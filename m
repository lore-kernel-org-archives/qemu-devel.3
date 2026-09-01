Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F037C61DE4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 03:34:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1FFe-0006m5-6g; Mon, 31 Aug 2026 23:33:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x1FFc-0006kd-FX; Mon, 31 Aug 2026 23:33:32 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x1FFU-0002o3-Na; Mon, 31 Aug 2026 23:33:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJBCcnQUdM26M2JqlNYMprDgk0ckgTJ9c+WryQ78cLlRQL30KgG9NcKkAYjeGnUu8kAdfW0NsK3XWsZ6CogiGCnwa1vt1ULWKOA4ngsYjL/w71x4lG4FhmolKXrubaR/PrcyiZ86KkFHZtT1tLEknFa63O/z15N+G8moM+kD4WWA8uGTPXytv7GeqgVGJH4QoZy6GIz2mjkJytn9Mo2DQPSpWMvy7cZ9ySO1lFpxkufyttyQEwpOHAixG2rcvU0hGmaqwQZ4gxp/kAvwFPmrhpIem5MH39xuGlchobqHIxmnzXjg7OFKuWWwYnBlDO9ro9K4SXv4RPalTgegF2EYFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8fKh3UEI7QUzAtoKEUl7zvHs96OZ86tt67hnIXDjBkg=;
 b=TuxJ4zl3kxaWw9ke0Vaei07qtr2iQL/lxHNFWzYkST8o6y4OpbTeuDAdXI+lrzQdmD/k1FCyhIc68jyMDHGdMm70nTTF01iw0Z8yN8dGxr3ItjCZyzUfeM9xb6v2QiSx4YCjw7RbG79rw0fec+md9dyUvvq320Tfo7tkeJ/8pMCJzIKGexYN6op1I+/D5GqDdlOxTYpKfPJOahwQgeWPkfjGyr0WBsO1k/7aKmjVN+hK+3l9tUvWXOigY9szfu8L3adTHoz+6IutHgjQdZ9pvElzATMse+/tI1+TJbQed1crbOurKRXXKZG1n5Bg49e9UX0rWHark/OaDBYg2CtjZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8fKh3UEI7QUzAtoKEUl7zvHs96OZ86tt67hnIXDjBkg=;
 b=LWLk9V+Djf9OIzlMXEsDTTjHs+cjTp+ThfNBt3SSu2O3f5R2V0ZozZlsfzCeCrwPVCQ3nFyU+0DsGiayrfl4wQNd8vNwunL6zCV6QcH/fMSaxXUTUlrguCn6ZUb1PITNSDL9IzgG8CNe2kEWQSV2CsXXVabQU2lVExsozwo9NFZQpbPAZp89Coa6J1tQuSz5V+QumMK9DUkQ9f9Q0eIVf6Uk0NednnCCdpwzDQrJsNvbjT3utDyAeYOTtf6w624slZbmY6Dl7tYw1V4XfgLNXT1Ee9H41cpghll3w2bPdorBvlzIDPl7D2+17zUmhjGYs2qUtR72FsJ0K6qkqfHu4A==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEYPR06MB5718.apcprd06.prod.outlook.com (2603:1096:101:ba::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 03:33:16 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 03:33:16 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>,
 =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v3 8/9] hw/arm/aspeed_ast10x0: Wire SEC SRAM to the SBC
 model
Thread-Topic: [PATCH v3 8/9] hw/arm/aspeed_ast10x0: Wire SEC SRAM to the SBC
 model
Thread-Index: AQHdOPqwR+45tqTcpkyQLAkyQNmja7a3y0cAgAFH2sA=
Date: Tue, 1 Sep 2026 03:33:16 +0000
Message-ID: <TYZPR06MB498044B53B04C0A2683D5EFCFCA82@TYZPR06MB4980.apcprd06.prod.outlook.com>
References: <20260831034153.192916-1-jamin_lin@aspeedtech.com>
 <20260831034153.192916-9-jamin_lin@aspeedtech.com>
 <23bef282-1f18-4d06-b096-f6876f8afa5a@kaod.org>
In-Reply-To: <23bef282-1f18-4d06-b096-f6876f8afa5a@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SEYPR06MB5718:EE_
x-ms-office365-filtering-correlation-id: 8f5a4315-7169-4cf0-2a7e-08df07d9c282
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|7416014|18002099003|22082099003|56012099006|38070700021|6133799003|4143699003|10067099003|921020;
x-microsoft-antispam-message-info: MU9IaVOrRLDIHEmK/KZNUO/cbMAOwaP0BmBoNfDqYwNFJPbPnwxtV+ASPLN3osBWAPiUv0hgsix1lBXQI34LKaDUMEGxSCx5yvWBi7Ot2FA3cTJIoAZclkS7AjY+1KuBBtu18YSjd5wwlx+n9WNWq4Tq/37/79IVArTBaJa7f5pnkf9H62LCQI52fcWC5gQiK2WpmmBd18wg0oSpt8Sy+HoJK69gZp4M3M+PbSWU0u1kYd+BwE0pMJHyPU+rom70G/cpaiwBuo/ChzdHUmBqRvLTEC2p8e3R6Aowd5kCn4NcZlKSjFrcO0o0/l/EO8RrspwtkYzBvVoVwxh0CsSaCWrdtXsHpST6gr3QUHa6uOP+GCsROC3EecreI83a6+k+TyRQSBYs5RFM9w49ubxu2NZyIMm9zyiHxqlHXWJY2OKjPdf+9lnoaMrHNiThUAcZpwl3Sx+THt3z1imy4wNIoQkARgmkorWyycbAYDYBXShBLrZAWkaupoRzL+cI0upm2IkyF2AOlGjP6WFB+jsca+OJOItsvPHs2q0hJgrXFcmeprHiS5lLCCfLNXLcsFEEqSjc2ZPOVZxVTHpx2P1sU6jWlvsprtL5HZ2f6rrgOD09jzhWRZz+GZuiBMGNkuwVebbuA/olV5pmH5gHK34nTtak1H4cZ7nFIeLTBJ+JUam88pZSkGlDg43NkJmX1n3FHtz2ypSJsyZtssmsMqa17kq7zGiuwrMpKeuLjBtZPjYvlZmYYoWJShnnAGNITkCe
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(18002099003)(22082099003)(56012099006)(38070700021)(6133799003)(4143699003)(10067099003)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVQ3QkpCTWd4blgyL2FON2orSTJtdGphU1c3WFBGZC9QL05CTGhDb095YU5y?=
 =?utf-8?B?TWV1UmJSdUdiL3JIWkIvMmNNRGRjWVJWZnJRQU9zZ0RpaHphLzJURkRwajlT?=
 =?utf-8?B?SGxEdzdJck0vMFFWdkFHTngrMU5MUGZ6ckk1YWxJWlVqRko4cnRVdTYvcXFL?=
 =?utf-8?B?MmlvR09vanAxU2JzR3B4Mk92TGJIVXJnL3M1YUhqeitpUHpGRDh5TnR0cjUw?=
 =?utf-8?B?eXNFZU02Q3ovbjlVMFRvYm8wck95Z2xLTkhOWHp1VG1NRDR3Zng5bm1qUkd5?=
 =?utf-8?B?MlA5YWJEcUVncWUwNW5vS210Yjd0Z2UzY3o1bW9QNVlxZU9TYVdOVjdwM01j?=
 =?utf-8?B?cDNBU1NGeEVaNG94TW9vYW04bXZlR1A4b05KSHFnSHN4dTltNkVRYjFCc2Z6?=
 =?utf-8?B?WGtkWDdPbUZwZnFKRUZjNW5sMHVRd0ZaV3czbU1zNkd3SnlOQWptV2Y5Tlcy?=
 =?utf-8?B?V3FuYjBnVGVsbVpzVWlKRC8wK2NleEF3c0dZNFZpRU9maURZOW8xSnNYK0Y4?=
 =?utf-8?B?TjJhMkRDODF3M1Qwclk3ZlQvTVF6ZUxWajRkQ3N1TzBhTGFUVVliOGdPN1Fu?=
 =?utf-8?B?TE5iKzEzTDZaVEZVbk9tYXpPQjNkcGtGUTE3YlJaWFdaZGxQLzVzbWpiY3Q2?=
 =?utf-8?B?dnoxRDRPN3dBUUZRbXphRWxxMnVwVFk0Mzd1em5YMzl2MTVoOTdBQ3J4d2xK?=
 =?utf-8?B?Y0NlWXhxUUgrRktVUGhqTVBhalViNHVCUSt5T1BVZzBrem55MWxUSmxQK1F6?=
 =?utf-8?B?bjRqM09rRnZ3aE1YYVU4eEpBUmZ2YVllSDViKzl3aHUxd1BPY3JISEI0NCtZ?=
 =?utf-8?B?aStyMW9vSnZ4akwyZzZHanVHM1IvTmdTc1JMS2lBWUVCY2RLK296c1dnN1Bq?=
 =?utf-8?B?WEtLdE1ydmt3d3E0WHNFVitkTlJyMUh6L01UbFMrN2kzOU9LQUd2bFBtaFRK?=
 =?utf-8?B?ZkEyVXNSdHQ0em9pRWNKQyt4cFhUcjBjOUVDeStjOUl4K3RqdEVDbWgya1Fx?=
 =?utf-8?B?VU9GRkN2c0xrSWFNS2tiNmkvakt0K1JlZlNMVlFOdDEwNmNCcUdUS1B2bWxs?=
 =?utf-8?B?NUx6d0JJQlNEQ2lLYXNiN2hXSTZDWkpLYVZSWDVZTFI2NFcwTjdYRFdYSGlz?=
 =?utf-8?B?QU9Gd1R2aHFtUENYTlAyQXRXaEdkczcvL29CTXBINU44aFJlQlpuOGtrYlBN?=
 =?utf-8?B?aWF0MzhjcTRSMVk0b25mcUI1V1RnUEtoaUlZeEk2TTRMSU1SNXdkVXIvL0hm?=
 =?utf-8?B?RHRVMU1nNHZPVUdDSjFFSmQ2cTg4TVNPQUFTUG1Kc1puSWQwNnZUTzlkT1Zj?=
 =?utf-8?B?S3JacXpPSVZNSGFENXpSYmR5alVlSklFRHR0Sjg3bG8vV2t4ZjI1R21OSlRx?=
 =?utf-8?B?UXNNYVI2a20yMmJWMnRyTTM4ZFQ5UVF0WDkvSFBTYjQ1Y0R4UnlNV3dSdms0?=
 =?utf-8?B?cm5VaTZZQjNtU1I3YXZmcmJvbVp5bURPcUI3Y2Z2K1dac1krYXc2TUFoc3BT?=
 =?utf-8?B?VGxybCsyM1g4R1BNTWhqYW1naGJRZndjb1J3YU94MFpja3h4Ni9PZjV6eS9V?=
 =?utf-8?B?bmswNWJSSHQxS0Z1ZXhlQlpsVVpsUkFqYlZRcVRiL0d4ZmFWY3FJb2ZpWDMy?=
 =?utf-8?B?NHNzVmlyUzhOL2s3ZjkrU2ZnaTQvOHg5TWw3V0lHZDhudmM1dmp3RG8xdFF4?=
 =?utf-8?B?MXlVZEdZdElUWEFtTGJFS3pYUUtDb0gxZXpsaEpMVTdjME53RzUwQk0vTGhL?=
 =?utf-8?B?RHk4YU5KWkd0VktoblBQaUtlRDFFL2pIbk5sN2hIbCtOb01SdTFpejdXdUpn?=
 =?utf-8?B?M2RGRkdaOEpobmJVcHlKNEIxNS84RmpDaDQ1cjZFYjhuRXNtSFdNOU14bFRx?=
 =?utf-8?B?ajUxdjNWZTFNSDdoaldPd01nSFBYVm54ckR1aGhSU2UvTTRIRjVIcm9IRmJJ?=
 =?utf-8?B?eldPQlRMbDFUYzI3OGxTZzZmd3MyZkFJd21raVhNWE9RYlJjZkdVTWpPRjdj?=
 =?utf-8?B?WUl5blI1UlFVKzFtSCtDeGRZL0pKRFlkdytBVWxyMWhzcjM2eHlCMWZMWEIx?=
 =?utf-8?B?M0t5aTBKcHUwWndtdG5VNEV3a1VJdVBhMi9sVzBvYU4reFJVUDM4dnBEZW94?=
 =?utf-8?B?bUlDNHlQdzRwZ2RZTHhrTWYyREU5SDh0b2xuRGM0c3pVN3FlUStCUlQ3ZGtw?=
 =?utf-8?B?V1VyeGlFUEJBU2gwTCs2L1lOMmVJMjRyTUdUTWh4ak0rTkNmekFOZW9kSTll?=
 =?utf-8?B?YXFSQnZkbENpQmdEVXdLR0JNVVVHejd1cWhxa3hFbDJUSmtzd3RwTjEzMVA4?=
 =?utf-8?B?UWVlZyttczgzdkUxTktlcUg4aW4zOHlTS0Vqc1hWWFQzQVFqdEZWUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: AnNiHC7D8qOXnbLwmC2cW1nxXgvHGS6bU1BSeG0pv1ERILR6dDXRw8BZAodyjXNkTxy8BN2F8NBuG2hfu/3h+ToHDDQgDFlO5nnTAs97dOAexURe1cEv5f7kiWppF9sJDyASYBemt4AgwxexWNCRg8ujrrlvGxvtV24iMx7GX6edWY6wcbaKQCsFJSabrDBHbWOLjJmJYnli4yiYG0Q1iHsuAdde8BKI4Ug7IJBNJKGpcHfbO+JUh7ZvLjiQcYOvjMl0n/cOWl7EHGgWmp+sfCz0TPNdYEpDLLlr0JWzA+bRI0f90qKtCLJ3pw99Twf1mXrGOU2RBuw5asyV/QL/XQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f5a4315-7169-4cf0-2a7e-08df07d9c282
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 03:33:16.1961 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KObSQJueG9XtffbkWPPescnqgWzmBbnY1Bdhi4vyLLE7i5AoIPuIOgqJJBMAXZwocK8LjMFbjGCNvmXgTqrrqnnhXNV3iWZgoN2gw0jag3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5718
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgOC85XSBody9hcm0vYXNwZWVk
X2FzdDEweDA6IFdpcmUgU0VDIFNSQU0gdG8gdGhlDQo+IFNCQyBtb2RlbA0KPiANCj4gT24gOC8z
MS8yNiAwNTo0MiwgSmFtaW4gTGluIHdyb3RlOg0KPiA+IFBhc3MgdGhlIGludGVybmFsIFNFQyBT
UkFNIHJlZ2lvbiBhbmQgaXRzIGJhc2UgYWRkcmVzcyB0byB0aGUgc2VjdXJlDQo+ID4gYm9vdCBj
b250cm9sbGVyICh2aWEgdGhlICdzcmFtJyBsaW5rIGFuZCAnc3JhbS1iYXNlJyBwcm9wZXJ0eSkN
Cj4gDQo+IFRoZSBjb21taXQgbG9nIGlzIG91dGRhdGVkLiBUaGUgY29kZSBub3cgZm9sbG93cyB0
aGUgY29udGFpbmVyIGFwcHJvYWNoLg0KPiANClRoYW5rcyBmb3IgdGhlIHJldmlldyBhbmQgc3Vn
Z2VzdGlvbi4NCldpbGwgZG8NCkphbWluDQo+IA0KPiA+IHNvIGl0cw0KPiA+IEVDRFNBIGVuZ2lu
ZSBjYW4gcmVhZCB0aGUgcHVibGljIGtleSwgc2lnbmF0dXJlIGFuZCBkaWdlc3QgdGhhdCB0aGUN
Cj4gPiBndWVzdCBmaXJtd2FyZSBzdGFnZXMgdGhlcmUgYmVmb3JlIHRyaWdnZXJpbmcgYSB2ZXJp
ZnkuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0
ZWNoLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGh3L2FybS9hc3BlZWRfYXN0MTB4MC5jIHwgNyArKysr
KystDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaHcvYXJtL2FzcGVlZF9hc3QxMHgwLmMgYi9ody9hcm0v
YXNwZWVkX2FzdDEweDAuYyBpbmRleA0KPiA+IDUxNjVkY2NlNTkuLmFlYjVhNDQyM2QgMTAwNjQ0
DQo+ID4gLS0tIGEvaHcvYXJtL2FzcGVlZF9hc3QxMHgwLmMNCj4gPiArKysgYi9ody9hcm0vYXNw
ZWVkX2FzdDEweDAuYw0KPiA+IEBAIC0yNTAsOCArMjUwLDExIEBAIHN0YXRpYyBib29sDQo+IGFz
cGVlZF9zb2NfYXN0MTB4MF9yZWFsaXplKEFzcGVlZDEweDBTb0NTdGF0ZSAqYSwgRXJyb3IgKipl
cnJwKQ0KPiA+ICAgICAgICAgICBlcnJvcl9wcm9wYWdhdGUoZXJycCwgZXJyKTsNCj4gPiAgICAg
ICAgICAgcmV0dXJuIGZhbHNlOw0KPiA+ICAgICAgIH0NCj4gPiArICAgIG1lbW9yeV9yZWdpb25f
aW5pdCgmcy0+c3JhbV9jb250YWluZXJbMV0sIE9CSkVDVChzKSwNCj4gInNlYy5zcmFtLWNvbnRh
aW5lciIsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgc2MtPnNyYW1fc2l6ZVsxXSk7DQo+
ID4gKyAgICBtZW1vcnlfcmVnaW9uX2FkZF9zdWJyZWdpb24oJnMtPnNyYW1fY29udGFpbmVyWzFd
LCAwLA0KPiA+ICsgJnMtPnNyYW1bMV0pOw0KPiA+ICAgICAgIG1lbW9yeV9yZWdpb25fYWRkX3N1
YnJlZ2lvbihzLT5tZW1vcnksDQo+IHNjLT5tZW1tYXBbQVNQRUVEX0RFVl9TUkFNMV0sDQo+ID4g
LSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJnMtPnNyYW1bMV0pOw0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICZzLT5zcmFtX2NvbnRhaW5lclsxXSk7DQo+ID4N
Cj4gPiAgICAgICAvKiBTQ1UgKi8NCj4gPiAgICAgICBpZiAoIXN5c2J1c19yZWFsaXplKFNZU19C
VVNfREVWSUNFKCZzLT5zY3UpLCBlcnJwKSkgeyBAQCAtMzUwLDYNCj4gPiArMzUzLDggQEAgc3Rh
dGljIGJvb2wgYXNwZWVkX3NvY19hc3QxMHgwX3JlYWxpemUoQXNwZWVkMTB4MFNvQ1N0YXRlICph
LA0KPiBFcnJvciAqKmVycnApDQo+ID4gICAgICAgfQ0KPiA+DQo+ID4gICAgICAgLyogU2VjdXJl
IEJvb3QgQ29udHJvbGxlciAqLw0KPiA+ICsgICAgb2JqZWN0X3Byb3BlcnR5X3NldF9saW5rKE9C
SkVDVCgmcy0+c2JjKSwgInNyYW0iLA0KPiBPQkpFQ1QoJnMtPnNyYW1bMV0pLA0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICZlcnJvcl9hYm9ydCk7DQo+ID4gICAgICAgaWYgKCFz
eXNidXNfcmVhbGl6ZShTWVNfQlVTX0RFVklDRSgmcy0+c2JjKSwgZXJycCkpIHsNCj4gPiAgICAg
ICAgICAgcmV0dXJuIGZhbHNlOw0KPiA+ICAgICAgIH0NCg0K

