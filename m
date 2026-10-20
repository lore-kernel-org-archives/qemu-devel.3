Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB219606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 03:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=P6e9qCJW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ0li-0004mm-DQ; Mon, 19 Oct 2026 23:44:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xJ0lb-0004l8-C5; Mon, 19 Oct 2026 23:43:59 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xJ0lZ-00039V-M8; Mon, 19 Oct 2026 23:43:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v7lURMWWFKL7RRZ5pXDTpBUPvQeQlR+zKy9qLHnErfer5yUBsVMbCL7Eu5w56sPMfnlvyq/UZQNaLnti2VLFLj1bAX58zul4QW5X8acbQPuvHSMr5e6acM2pQol9qPojAxPBoxgHYXQxUJwjZ+kpk9HWMBGNq59KXEa8upB8ALvZT3RKhnHzYodYv8OeSs/fR0pjVnKwjhTqm4uvrb6lenZAUIL54iGCtwmORe69F2IXTP2zy/5UPnLvOMr0jqNhUSaw18OlH6xVmBBlQ1TWSYVCh4uLafbFrf1QNERTRK5brqE9Pcsb/nefD9l3fUyUjvla1Iw1b7Bx3wAq3ndA3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YJf6eO+y5e/XX3fH/jH0pc3rYMsXNwXanlXjXe1SaZU=;
 b=CQgdaInn+UkzfAWe5fAKuHFt+i9OqFi92HzDSFpP9uR9t+Q0wdNTZzc70/S3Qi9tdvqL3WLPe3Z993E7wZrB6UiDf11Stub1CxnikErLs85M94ER1NUEgBngNXaWn8sEWKDup1FA8f+rhWzXb+Xc7W6IEeMZ59nWJJTKdag7F9EBOYgE2ZUIHD69btdBHYCZcZfMXfI1ECvjH3G6taC+3iWG6MGmzy+z77epuwCxr+izK2b9FzCTMTztXcZ+49xYEDZfZdUmR2d8muB3tJWV5PBQcQPIeWcG+udu3MOGxIfZXT2IEld1xqriONZeq3dgoF8YQg/fowLJYplwC7XNoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJf6eO+y5e/XX3fH/jH0pc3rYMsXNwXanlXjXe1SaZU=;
 b=P6e9qCJWrh5/7Cr+3MHBbpKP+lUwD2WlJgMul1+92+n220QTl47YEByleXjNdP082BBNmX3vTf9Uc0m/BVrp4VLfml+WdA8LhGqnEWBCvyzTvFZLJ/x9sTrMh7CxaND/Uah7EubwQ2NHjuf+EGtRGYmV/ELQUC8IOPTpUggDTgwnao0lnZM78w6ZPVjwFBdxvNoOUv5o3NJyI2kkGzVQzgH0gNtMQWQcYAEMNZdPX2HxgyRMeaPs4muNNhCjI27bOT71pt+LMZMxpU7ubQJJ3RP7/wMSPvSYLJFp7oV2Ah9dh41oClDM0c0wX8YnO2CRplI5DCAIloBklcrTmRZ2MA==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by JH0PR06MB6438.apcprd06.prod.outlook.com (2603:1096:990:2c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 03:43:50 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 03:43:50 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@oss.qualcomm.com>,
 "marcelomanzo@gmail.com" <marcelomanzo@gmail.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?=
 <clg@kaod.org>, Kane Chen <kane_chen@aspeedtech.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1] hw/pci-host/aspeed_pcie: Fix global MSI setting during
 class initialization
Thread-Topic: [PATCH v1] hw/pci-host/aspeed_pcie: Fix global MSI setting
 during class initialization
Thread-Index: AQHdX3PLSL9rksVckUu01uZZcMa9v7cEpX2AgAEka/A=
Date: Tue, 20 Oct 2026 03:43:50 +0000
Message-ID: <SEZPR06MB73622D0A6BA505FFEA189F9FFC672@SEZPR06MB7362.apcprd06.prod.outlook.com>
References: <20261019024441.3554329-1-jamin_lin@aspeedtech.com>
 <271cde58-d72b-4dd4-b0c8-e3ceba7da342@oss.qualcomm.com>
In-Reply-To: <271cde58-d72b-4dd4-b0c8-e3ceba7da342@oss.qualcomm.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|JH0PR06MB6438:EE_
x-ms-office365-filtering-correlation-id: 196ca906-f5f7-4003-a42d-08df2e5c5ac6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|38070700021|56012099006|4143699003|261009223027099003|10067099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info: NSRXUIvQ6uusedOkie7M3AeBJPZpz8+88cmE6I08xALW6J3+ckLneUsI/auBIqD6pFunsb6hx0NLyuhi1SVb6SpEhTqw7ZybgjktoU4zRDTTDI4w8u9kIwF/rQaRe+94wMjqy5TyArF/fZX9LbhglXXgqn1YUiDHzlmFS6EBlc9wdkhuPjuyq7tZiijXT1jVVfcPozQ7wjqu66SHiLGbJuTffWnawpxKZpczFdQfTUnDo7VQXiXxZlE4joGgWX4qHNocdGdsl0+7BmucrvNduqpZTgtH/jx4P+kc5v1Rag/xHaNm+LJTTijnd0iy8zxsVU8h+JLq1cZIQEXJ14LzLkI1uw69jYEh2Xk05Lk74vhsYOgAjNygOvcmuTUgb8YcsskmAfuLDwrBSbxqjL/JfPrHMRX1KcKyCidzX7G41fL8wDgCLPR0RPe/CcjFOZT06Xq/LXZ5SMuHxDBl1dLXuxXZVHyA4UW/ctHkjG6B8JQElpS69WS9wkI0ABqCz0bcTfZaVSOwgio7rqx/Y046x1eeuled4XRjGST7z+EIJuiESiTmAPJjq1ivTVXIcwffiEU5/NmPsS+mwrRl0/wzT+k5yyWRCc5zvWsT7q8Vp1LW4mDxlWgdgRuxsYY18uHfstFZ1T1/bHTk8+dL/tFL01DpO6i0u2ODbXju02cgOYA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(38070700021)(56012099006)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TWQ1VWErZ2tLVWtlTXE3MlRRZjFNeHlJeWxCUnVmMktDWXVmTVdGNGsya1Nk?=
 =?utf-8?B?a0NOZUR0cXM5NjVjZHhJOW8wR2hLNnhwSHJpUUJLRHhhZi9pRFlSVzAzaFNF?=
 =?utf-8?B?eEsxWmhEM1NrL0NONmF2TFZYdDN5ZHlvVWN4VDkvMnY5ZVMyZDcrYkhWcU9R?=
 =?utf-8?B?NnNHR0lRT25pamRHUVpGajFWQk9qNUhQSmtuVXdVRmJ1dmZGM0tGOFNsU3JR?=
 =?utf-8?B?VFczZjYreDMxWFhTd2Rabk0zQnFGQ3hPbzUxZDdQMnhqM1pVelpSUDhCaFZJ?=
 =?utf-8?B?c1FNSXplMnpybStCVWlpK2F5SHZtTTNGZkVwZTFMTDhxWXo4bHV4TVR6Z25m?=
 =?utf-8?B?Q0J2eW82WXVoZ2R3amdXU3pnQkpQWWRYMlZHSG5IYnVMNWFIQnExVWE4bTNq?=
 =?utf-8?B?aDZGc2hrY2tlQ0JwM1VFdDNYTkdlSFJnMlU0UTRBV2Y3SnVCOGEwZzNGZ3Rh?=
 =?utf-8?B?Y1djRFg0dzcyMjRMQVVlRW42QUowZC9wVVNtckgrV0N6SEVWRnYrenEwcFJa?=
 =?utf-8?B?NG92UUFKY25EZFlCbFNJcE8xVUtyU09QclNDUDl3ZWxtZWpBR09OajN5LzNF?=
 =?utf-8?B?MWVoR0tSb2svWFZwc2xnTVgveU5hVTc5Mll2YUplOVNXZitVTjdaUW8rdGVu?=
 =?utf-8?B?RkdjUHkxNVdrTXEwSnZyL0lyMzdWV0c3a0ZycHEvTlBBTzRLRldQWHF2eWFx?=
 =?utf-8?B?K1FWZDdueXFvblp2U09YeU1kNmpTTG4xalVKOUZhSHBZc2hCdkVxUDkxR2R1?=
 =?utf-8?B?bU9HcWY1bFdKUHlKNHlGbXhSenFkZFQrbnZVeWYwTG9xajRhRG5BalFsdGMy?=
 =?utf-8?B?M3pXMUgvQk9ldTJlRCt4YXhhL0lYb29mUVRDN0FxeWQ3ZEFZaTNpUXFsTTVp?=
 =?utf-8?B?SG50YzJPLzB2L0JjSndDc2QxUXBnZjhJNUt2TjB2c3RKMDRDZldKUGNuMFZJ?=
 =?utf-8?B?UDBnU0lqU3dJcEhLWU9NZmJXTUVRaHlXY2tlQUZlaEx0NDEwK3p5L0tGWEZm?=
 =?utf-8?B?L3ROallyWWRFbW9uall1akJLRkNwb0FhbFVxeUNvMVNoemY3YkxvNTJXaTl3?=
 =?utf-8?B?a0diYTQvZXEySWcycXNTQzk5R1lKQjBITlNRQWhNdFRzOTBJeFpKdDcyNUNC?=
 =?utf-8?B?UnBXdUluUU9UeG83cFBFRGcwcjR2MytvZFdmT1V2VDFXVlp5Rko2VFFIb1FG?=
 =?utf-8?B?QWlWaG1zYkY5Q3NtZkh2TkdmYUwrRTkxRlZ4SmMxTmliRkFEY2lvS2dTVllQ?=
 =?utf-8?B?VTIzNy9kQmZ3Q3JJbWJFdDJUbFlxeGc1SU9OWlRpTjNOem9vSGZSL0lhTklV?=
 =?utf-8?B?T1JaQjVSYVFUYXhMa1RueVpYUnJ0c2l2N2RZTllWejlsSndubXRXWm5ZNmgy?=
 =?utf-8?B?TFkzOEVUQWZWNFFTOE82RVJYMjBmQzdSQVlPVWZxNUVMdzZKaVVTbzlVSEF1?=
 =?utf-8?B?OTBHNDlrdE13WEJzMm5DRlhlUThZSEZPWkc2WDBVc2JGR28yNys4NTVTZWRR?=
 =?utf-8?B?dFBzQmlCZDB2VUlYMGJEMHBRd3M1dk15aytwaldzQmpQVE5FazNDbE5ScW1u?=
 =?utf-8?B?Y0FSNG1icTVNUzRFckNPWFNoVkV0UlRlTllKMUluTHk3SzBQdjdoNXQ5YzBG?=
 =?utf-8?B?bDl6SlBPMGxlS0VqdDl3Mk8xSkkwOTZmeG5VSllYbTBKNm9wQWxOSE0vRHFk?=
 =?utf-8?B?K0xNU0VHa3hXS2lmVWNWM2JGMit5MzY1YUhKM2tGZE9xSmw2dXZFbzFjeHg3?=
 =?utf-8?B?UGVJd3lYWHUrcG1qVnZ2eXhUUkN1ZHJGMm5EbklETGdnbG9XNkNMYkZuSnhR?=
 =?utf-8?B?RWVLWllMQXBDamdHR054N21ndXNpTXNjQ1pHelRMaGFBbHZiNVlndWlSWlJh?=
 =?utf-8?B?UGQ1dDg5em9TMTAvZ0s3SElaL0FCMnNUZEh6VGhsVFJ2WEdtZWg3ampHR3Mr?=
 =?utf-8?B?dWh4bDMwdWZZWFpvdldkWnFzVVd4ZnM2QXFhOXNxMVN2UGljVy90ZHhDU1Bz?=
 =?utf-8?B?QkRXeTlFUWZmbGpNcG5adEV3M1BsNTNla2gzbXVqb3JUSURuUHM3NEppU0xJ?=
 =?utf-8?B?ZFgxTjZocjUxL0dCZmFBMjhRSXRHWWdvaTh4Y1kwckJIYTA2SDhDYkR3WXZC?=
 =?utf-8?B?UUYvK0NaYUF4MUhKYTdBQUgwZ3pxZWxjQU5qdVNNd3k1TTZobU9zelNpdFRP?=
 =?utf-8?B?ZytuUW53Tk1VVDQ3S2dZSCtLMW5FYi8wdkZpeDlEVFZNTVpYM0ZDRUZCVmxQ?=
 =?utf-8?B?OVFNbVU5OFhlenVwc1VUUjl4enFwa0RrT24wRWROWkJvK2Y2M0htSlp3T2gz?=
 =?utf-8?B?RllycFhTOGNyZ0hJWVdKT2hVQWllYnVyOHplb3RHOVZBRlBBWXl4Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: iLq3jnpmZoaj0PiTqvGeijh3p0zTHFtOgObSoPXdPYu35e4cbpoMs+WOAebY3B73Wq+oaVTm5l0n8phkbKthdSQ7ymF0cmlciWMQlbnzEQT9PmhTQH2eOhjdtSOD40/2K0f2biE/hBR3gcngvK4KK+plnKvzmVdGLepHXfDh5Qn/f6J1N3iMnC7byThkLsV6XEaI8aSSGEhPCYzJxgjTtuNf9wSdlSbEnk6IxOnIvWHhZaD8QxTBP2fK6q76BbTG+Jzkqq1TbPJhCIsnz4zIuZ3AVHE6bfHnVM6SKV7+JpWFVpvTbvi9/tV+r4Pa+iyZCGgBaXbv7eXBNR5K7UnkCA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 196ca906-f5f7-4003-a42d-08df2e5c5ac6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2026 03:43:50.4702 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ycPSBT1HVcbzLkW/AVDSVLP/ORSaWjfpDv5kmsE+Lc4h4gfsf3GXFnIipG0tcragUIOTmzjqlkQZzCPStoHC9BFviDBpYC+1N/xQ9MQAzog=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6438
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SGkgUGhpbGlwcGUNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxXSBody9wY2ktaG9zdC9hc3Bl
ZWRfcGNpZTogRml4IGdsb2JhbCBNU0kgc2V0dGluZyBkdXJpbmcNCj4gY2xhc3MgaW5pdGlhbGl6
YXRpb24NCj4gDQo+IE9uIDIwMjYtMTAtMTkgNDo0NCwgSmFtaW4gTGluIHdyb3RlOg0KPiA+IFNl
dHRpbmcgbXNpX25vbmJyb2tlbiBpbiBjbGFzc19pbml0KCkgYWZmZWN0cyBhbGwgbWFjaGluZSB0
eXBlcywgZXZlbg0KPiA+IHdoZW4gdGhlIEFTUEVFRCBQQ0llIGNvbnRyb2xsZXIgaXMgbm90IHVz
ZWQuDQo+ID4NCj4gPiBNb3ZlIG1zaV9ub25icm9rZW4gdG8gcmVhbGl6ZSgpIHRvIGVuc3VyZSBp
dCBpcyBvbmx5IHNldCB3aGVuIHRoZQ0KPiA+IEFTUEVFRCBQQ0llIGNvbnRyb2xsZXIgaXMgcmVh
bGl6ZWQuDQo+ID4NCj4gPiBSZXBvcnRlZC1ieTogTWFyY2VsbyBNYW56byA8bWFyY2Vsb21hbnpv
QGdtYWlsLmNvbT4NCj4gPiBGaXhlczogZjAwMmFhMzVmMzIwNWQ1NWJiZTRhNjg2NzBiYTE5YTZk
Y2YxZDZhOCAoImh3L3BjaS1ob3N0L2FzcGVlZDoNCj4gPiBBZGQgQVNUMjYwMCBQQ0llIGNvbmZp
ZyBzcGFjZSBhbmQgaG9zdCBicmlkZ2UiKQ0KPiANCj4gVGhpcyBjb21taXQgbWVudGlvbnMgQVNU
MjYwMCBidXQgYWxzbyBlbmFibGUgdGhhdCBmb3IgQVNUMjQwMC8yNTAwIGFuZA0KPiBBU1QyNzAw
Lg0KPiANCj4gQVNUMjcwMCB3aXJlcyBpdCBpbiBjb21taXQgYmE2ZmIwOTA0ODE5OGEyOTUyZDcz
MWNkMDYzZjQzMDdiMTM3ZTdlYy4NCj4gDQo+IEFTVDI0MDAvMjUwMCBzaGFyZSBody9hcm0vYXNw
ZWVkX2FzdDI0MDAuYyB3aGljaCBoYXMgbm8gUENJZSBob3N0IGJyaWRnZS4NCj4gUHJldmlvdXMg
Y29tbWl0cyBjb3VsZCBoYXZlIGJlZW4gYmV0dGVyLCBidXQgdG9vIGxhdGUsIE9LLg0KPiANCj4g
U3VnZ2VzdGlvbjoNCj4gDQo+ICAgIFRoZSBBU1BFRUQgUENJZSBjbGFzcyBtYXkgYmUgcmVnaXN0
ZXJlZCBmb3IgbWFjaGluZXMgdGhhdCBkbyBub3QNCj4gICAgaW5zdGFudGlhdGUgYSBQQ0llIHJv
b3QgY29tcGxleC4gVXBkYXRpbmcgdGhlIGdsb2JhbCBtc2lfbm9uYnJva2VuDQo+ICAgIGZsYWcg
ZnJvbSBjbGFzc19pbml0KCkgdGhlcmVmb3JlIGFmZmVjdHMgdW5yZWxhdGVkIG1hY2hpbmVzLg0K
PiANCj4gICAgRGVmZXIgdGhlIHVwZGF0ZSB0byB0aGUgcGVyLWRldmljZSByZWFsaXplIGhhbmRs
ZXIsIHNvIHRoZSBmbGFnDQo+ICAgIGNoYW5nZXMgb25seSB3aGVuIGFuIEFTUEVFRCBQQ0llIHJv
b3QgY29tcGxleCBpcyBhY3R1YWxseQ0KPiAgICBpbnN0YW50aWF0ZWQuDQo+IA0KPiBGaXhlczog
ZjAwMmFhMzVmMyAoImh3L3BjaS1ob3N0L2FzcGVlZDogQWRkIEFTVDI2MDAgUENJZSBob3N0IGJy
aWRnZSIpDQo+IFJldmlld2VkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQG9z
cy5xdWFsY29tbS5jb20+DQo+IA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcgYW5kIHN1Z2dlc3Rp
b24uDQpJIHNlbmQgdjIgd2l0aCB5b3VyIHN1Z2dlc3RlZCBjb21taXQgbWVzc2FnZSBoZXJlOg0K
DQpodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvcWVtdS1kZXZlbC9wYXRjaC8y
MDI2MTAyMDAzMzc1NS4yNjE4NjQwLTEtamFtaW5fbGluQGFzcGVlZHRlY2guY29tLw0KDQpKYW1p
bg0KDQo+ID4gU2lnbmVkLW9mZi1ieTogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5j
b20+DQo+ID4gLS0tDQo+ID4gICBody9wY2ktaG9zdC9hc3BlZWRfcGNpZS5jIHwgNCArKy0tDQo+
ID4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0K

