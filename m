Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92BF6C61DE2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 08:38:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0xWV-0001eB-Cx; Mon, 31 Aug 2026 04:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x0xWS-0001dE-D2; Mon, 31 Aug 2026 04:37:44 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x0xWQ-0003MM-AG; Mon, 31 Aug 2026 04:37:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bcIGDM0oWywqaBuueJRvuRsDXxvVlKkZpUJYKRGXvrM0EO+RP4M82wltzkV8uuw0pCeBoSR7eFjjLlTQBUQNcWotvUI+DgXDGfCWyufwoVX6mgwpPQjJd61Ws/gkXLke2ln9Gjez6WzPBPX/jK1zB1wus8FRLFgtUyEYSQAZYU8lN3eM6Vz1x76iWpvL2r6Vr2iz7EM6OFgwCNu8cN4vEcaAn+s6UUSusAjlhcBVmss7lQtd5aV13UURjd1bsefobz2R7uRGjdS+N9M8ztbEpOqtFVm8bsvVTa8AldZ4Op+xBPY0EW1j6bm1yPgFfnfztXY3HA90KhFn1sALK4zzJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z18/yM9DExc2EIXR7V123JqXL5wDuemithbw2nunGzs=;
 b=HgWEyt9SxICYtm+GEXbzUJlbNAz8Iht3Ehs8FzIYFDSyiAn/yRyNcINKPJkrCtwAuMLvmLXY+7u8i3sYYPax9gFzHTzCrLqYdithRsBQQqJ0bbhGtEBMGz15BkIKYDVjZnfVY+kfEARIGg4rJvyqIoqvDaZDDX9z+xGtPKQJjGqoHGFtIGXrrfVSaO5VdUflc306cvirUTqUMqZ0YvYwd9M+o9EiCtpEIIEfhz8vQsyG+jAJArjwiKNjWZ3o63M7bAwtNin/DXW4nRDJtvN4kPoJAYh9TSI7567mwbDIUfSzGI+URREXCiNmfg0gTBlxPIzq6uDJdzZIREOrGBjWQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z18/yM9DExc2EIXR7V123JqXL5wDuemithbw2nunGzs=;
 b=PWodn1QqPzqwcTZoLvpEPVqnRrOWCxL/13tJzIqkFHyWHhFM6vpzmY7ga/InNVqLgcctj3BJT/X66D8QHc35WZP3woBYsZMbz8BreElGLCTe32s6TYnwVk4oNbHzVM6Ed86vyFuHjlHRG+KKjSLT12DidXxKzHem8E4d7qgVSbrJQIk3FtzVGU6qp2RTOjs+GbxsuJTX7HzUlOkZ6fN3jvU7BqGvjWyMFyNwFo/tNdjxBdDLsJEPwBB98uGJ6t8ib/1MilQfmY6hVSWjkq/KNxyNtOgItEeWIZ5G4HrS8weu2p8vc6uAwH/7uiil5GBkhBn2IeQxU3DaofhGgPbxnQ==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SI4PR06MB8350.apcprd06.prod.outlook.com (2603:1096:4:29a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 08:37:33 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 08:37:33 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open list:ARM
 TCG CPUs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v2 2/4] hw/usb/aspeed-udc: Add ASPEED UDC gadget USB device
Thread-Topic: [PATCH v2 2/4] hw/usb/aspeed-udc: Add ASPEED UDC gadget USB
 device
Thread-Index: AQHdNsw0QfINOzBp0USUkeNuaEZqILazM2iAgASmvQA=
Date: Mon, 31 Aug 2026 08:37:33 +0000
Message-ID: <TYZPR06MB49808B8BC2F1E812A429F7AEFCA92@TYZPR06MB4980.apcprd06.prod.outlook.com>
References: <20260828090412.981841-1-jamin_lin@aspeedtech.com>
 <20260828090412.981841-3-jamin_lin@aspeedtech.com>
 <e603f6c8-9f7a-4bad-bb41-00abf46226d9@oss.qualcomm.com>
In-Reply-To: <e603f6c8-9f7a-4bad-bb41-00abf46226d9@oss.qualcomm.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SI4PR06MB8350:EE_
x-ms-office365-filtering-correlation-id: 5cd5f727-1ac5-4b07-7f57-08df073b1a32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|56012099006|3023799007|38070700021|4143699003|10067099003|921020;
x-microsoft-antispam-message-info: f2uXa+XHHCqSVt5ayoxvyjJN8yiaVimeWKDB4vVPcM+1M1K+Bf+BjVmolB78t2/ZESb7Xf4rfQRr7RXJ3S5zBzVRNmTlFJI7YS+6o7I7cHvrNpvquDmAZkGMxYPSkD3UHDf5ppFTSbGTfMZf1rQ1DpRBJXrczpF/1gve5aFR4PxIScvvKKDwzk6Usqs5EomVqjoz70woSD9ioa7wamg7OXcpby8P9QhbBhs6pYCsiS98OWS0N4R9uz4UfaDNG6KHf0EN0IgqLI6Yt9ffIwhP+6NeyX9wq3c+Qq6qwr5Ucj2YMaT5911ilesDRykS8GoWzs1gHprcVMB96jo9B0aaiVtGCrtnhPWDkT9XcG4hii+FQYfJGlZ3W84BshX2LGEFdY6mc8Hc1PRDQCVYs1yG1/fdwEZwcGUushlFl+5R+tJprFeVLS3NA/Ttx5VNaEEC0YVD621TwxSfjw3qkI938XPgnU7qa8bT4aR12T+ZfEsG6oJAw0RIfoSjSc5l9lLjotUnyIJxnDi4VHMNxK7ko4T6gyUNZAb0okxMpN9PXyGG4SCVVtGNLccP+e+ShhzAhGfgTwWKQWGHz4uTQFHjuoFw0uF/mzugnoHLi6DGwBX/WbccYkAQ3LorS2DnSI9kFIMc/OMWYgzR6DAsdxIpCnUsSf8dcU5RYocv7VfUtPiHFD4GyJPHAJKaRWPO2iyjs9fXqXK89rMXs5An9Zmk8icyWqAlb3HwuKpNja3ZAxmovDXuoYUctNJZkx/GN/E/
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(56012099006)(3023799007)(38070700021)(4143699003)(10067099003)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkVkSFVDWlZHVnB6Tko0RW9UUWxTR2hua3cvWlpOQm9zNkNIRmNFTC8yREIw?=
 =?utf-8?B?TjZsdlhMT0dOTDUyQ1ZMZmhORkttRkdPMTBDZzVqcnZHaHMwWWlBWGlDQms5?=
 =?utf-8?B?N0xoS0xkSFZ0U0o5ZjJabUd4L3BkL2w0ZkxmRU1nWGMyRmQ2UWp2Z292YVNI?=
 =?utf-8?B?ZVgrRnVTTFhWdUtobG54aW1TY1hTOXlvMzl0NkFKSUtNTnVmNlBHSmJJSnI0?=
 =?utf-8?B?UWlPTUdkMFBzM245ZldxeW9mWllveWhoeFZFSFRZZG5ma2drNTE5bjJHdjFx?=
 =?utf-8?B?c3p4K1Z0Y1p0c2Q3ZTBpVGtNTnNDTElBSEZkL0NQREttNVEwY0dZQlN4cVAx?=
 =?utf-8?B?Ri9tTlBzQVRoZG1zc1ZFWGJzTlJRcFNweUZyT3JpMmhrb3I5QitKMU85b0FS?=
 =?utf-8?B?cDRTcHU3NThkY2xPNHBSRkxINWltZldKU2xib3llajltcUlhQVR5RmRBd0JB?=
 =?utf-8?B?akNveHhYRWNqN1BMajlqdWtlaDg4QXlWcHJVKy85MTZyK0NDRGloZVJLNkV0?=
 =?utf-8?B?SGdQSU45Tko1MDF2c2RvbGxDb3VzUGdGWTdCRzhsakJlcHdXQ2FxcE8rQkhx?=
 =?utf-8?B?S1hWVHFWOHlrQ1EwTnZqL3drVWJRVEkvTWJqZkFoVkhHcjA0UmlUVmlkNEpx?=
 =?utf-8?B?N2M1V1ZpZnhKOVVFbW5DR3QxVHlvWCszYy8zR09aWWNNUGRBSzhRQmJsUnFT?=
 =?utf-8?B?aHdiN0RXbk5DOGtDUWJsdFNZemU0cHloY0dQNGVwU2daVnNEaWdTejJmUWxK?=
 =?utf-8?B?OERUczVHaXdqb2pWaS9DTTE3WVlTakNRYUU0R3lvcU5wMzRkWlA1RVRPMHAv?=
 =?utf-8?B?UEpOeXBqdUlpbDV0Umd0Z2dZZWEvMHNObytocXB5MkRrKzNDN3cvOUhlZC9E?=
 =?utf-8?B?WmZ5NHFBSXY4SWQ5Q25Ka1dQckRuSitMQ0RMVi9zM01ycHNSZ2JVTzlQRGtU?=
 =?utf-8?B?cWNxVEhTYTB1MlpRT3BwWXI5aXh4U3gvSTJFbVFmczBzTkVhdFo1RTZKUU5J?=
 =?utf-8?B?OXQrbExyWGJWam1XUTE1TjdMRG94TGdOQUZTOE9kNlU4NlJMQSs2Zm5CdkVz?=
 =?utf-8?B?cWhxZmpjdEtRYnRvT0RvdFNXd0l5TEdIQnhROE1UYnVsVHFMalZIbmZ0dGp6?=
 =?utf-8?B?eTZWT3dmRzVRa2RtQ1Zoc0ZoVWxvRVplVlVLRXhmVG80YUhnNmYyVGplaTVy?=
 =?utf-8?B?YlRVNWNBZFQ4NXJaMnZpUURUUS95RlZKUzIvNVZmYVhIVmhzZGY2T3Z0Q0Vi?=
 =?utf-8?B?cUVJbWhPVmRlR214aFp0dTArOXRwTGluMFU5YWE1NXFMYUVib0Q0Z24rMmp0?=
 =?utf-8?B?dXVwa1k5RnpBTzJNWWgrclhUUGdyL0xCQTVidm5PaDViRHhmcFV3b04rMVJK?=
 =?utf-8?B?YU9PSElKUUo2WWVqU3FCRytGendjdXZKS1FCdFdtOWpabU9BYVZ6RUw1VlVi?=
 =?utf-8?B?MjQrVlhleE5LUmdtclV2YnpLOEo3Y3g5K3kyTzBPSG1rbTRnUlZGSnlVTFNB?=
 =?utf-8?B?NlFaSDlwMWwxbFJZaXpIaWphQ1NGZEpkQzMydzlZdENuREtxMkF4TUZtNGNY?=
 =?utf-8?B?aExRVUtSM3ZUb2ZYdUQyQ0s5QVVpa3p6ZVpHU3VVNjhDMkxKcHE2RjBRSUZu?=
 =?utf-8?B?K0ZvWXAvbGEzVUlDYlVFcVBpYjRMRThNdWxGYUN6Y2ZCMTlhaFN5WlJNWldm?=
 =?utf-8?B?c2dxNUNmQi9WN0F0ZXYrZUJUUEpyTC8rYzRVWXNuOUlpclcvNy9ENzBtbGFJ?=
 =?utf-8?B?SVZKY2FQOXphM1RBckdlSHFDSnhtSkMzV1B4QkRyUUtFMUtyVldFN3dxUHA1?=
 =?utf-8?B?aUljWWpoWkYyTzAxWEdwT2ZpODVxUHFaYmZEMGVqTmhXN0tDbU9XZllYZWpN?=
 =?utf-8?B?QWd5OFZZR01CVkJJWFlSQVFXV1p0cnF3MXh5VlhZQ2R3NW1YQjlvY2pVYjV5?=
 =?utf-8?B?czhlRVAvRi96REFRZ2hqZ0piT3gyR20wcVNMWFlZRzRmM0F2VWRYUk82cytn?=
 =?utf-8?B?eUNicTd2RzZUaU1NMnJqQnIzUnBwTFIzb1VCb1pMTTJramEyWFM2MkdWOW5p?=
 =?utf-8?B?WC9jeDFLelFucUZZSVNYNnJzdC90cjRhZnZ6eVduQmZiNVo2bDM0ZzVROG1J?=
 =?utf-8?B?UWd2U3J1L1g0djlPSlo3MjB0ejdKbVRwcE5mQ2p3YmZwcW0waEVKalJZSEhU?=
 =?utf-8?B?T3BCZ2JvaUk3TC84cWFPNmJZakNMNitHclpCdEFaU2N5b1RHVHZ3dDRLQUlo?=
 =?utf-8?B?dWNYdXEweW1zamlzU2RXZjZoZHZac3pFV05NOGhtcC9XbU12YWxoNzdKcmFu?=
 =?utf-8?B?bTRZTFdUeFpWc3N1Tm83VU8raHRaVnlVUHliZFplZnl1WmdkSVRQZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Z0Nn8edkDJ7T5d1v3mV94iJMU19phYx9B6wFotQP7zcf5bSFjZHUvBIpcJPaZw8/uBOudQjRfR/jw80FtdW3nCZR15APn5CDd2UfGHdboVaK9H4AW/1KnMM1dHgs5fPIOtYwLzAc9RVk/DRzQl5x38X3OH2RDJY6/PwFAKZneNTFsuM9AuTWH9dV/nStVMBRIQ0C+fcxhXJzZFoHatR3mkaOMdyWc8X5atWWTHY3BCzx5wVMjXpRcnzsDMFitBhIjnbNdTWLowfa58bQU838kQdJHrR3ga8/il53QM601GI1+RDmLvegkTyoojHt+2OC92XbSlBLvL+gGjQjO13xlA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cd5f727-1ac5-4b07-7f57-08df073b1a32
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 08:37:33.2645 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2fL4fz8FRA9s3rCNZYtnHo6wUYZgjE/kDEbDB5ETOLj7diCWqhNrBerRu+F0SuZVg6ZzUob8H4LTS0kuYN2Px5m0j1INsuKWgoDqENA05aQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI4PR06MB8350
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SGkgUGhpbGlwcGUNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDIvNF0gaHcvdXNiL2FzcGVl
ZC11ZGM6IEFkZCBBU1BFRUQgVURDIGdhZGdldCBVU0INCj4gZGV2aWNlDQo+IA0KPiBIaSBKYW1p
biwNCj4gDQo+IE9uIDIwMjYtMDgtMjggMTE6MDQsIEphbWluIExpbiB3cm90ZToNCj4gPiBQcmVz
ZW50IHRoZSBVREMgZ2FkZ2V0IHNpZGUgdG8gYSBVU0IgaG9zdCBjb250cm9sbGVyIGFzIGEgVVNC
IGRldmljZQ0KPiA+IChUWVBFX0FTUEVFRF9VRENfR0FER0VUKS4gVGhpcyBpcyBhIG5vcm1hbCBR
RU1VIFVTQiBkZXZpY2UsIHNvIGl0IGNhbg0KPiA+IGJlIGF0dGFjaGVkIHRvIGFueSBVU0IgaG9z
dCBjb250cm9sbGVyIGJ1cywgbm90IG9ubHkgdGhlIEJNQydzIG93bg0KPiA+IEVIQ0kuIEl0IGxp
bmtzIGJhY2sgdG8gaXRzIGNvbnRyb2xsZXIgdGhyb3VnaCB0aGUgInVkYyIgcHJvcGVydHkuDQo+
ID4NCj4gPiBUaGlzIHBhdGNoIGltcGxlbWVudHMgdGhlIGNvbnRyb2wgZW5kcG9pbnQgKEVQMCks
IHdoaWNoIGlzIGVub3VnaCBmb3INCj4gPiB0aGUgaG9zdCB0byBlbnVtZXJhdGUgdGhlIGdhZGdl
dC4gSG9zdCBjb250cm9sIHRyYW5zZmVycyBhcmUgaGFuZGxlZA0KPiA+IGFzeW5jaHJvbm91c2x5
OiB0aGUgU0VUVVAgcGFja2V0IGlzIG1pcnJvcmVkIGludG8gdGhlIFNFVFVQIGRhdGENCj4gPiBi
dWZmZXIsIHRoZSBFUDAgaW50ZXJydXB0IGlzIHJhaXNlZCBhbmQgdGhlIGhvc3QgcGFja2V0IGlz
IHBhcmtlZA0KPiAoVVNCX1JFVF9BU1lOQykuDQo+ID4gVGhlIGd1ZXN0IGdhZGdldCBkcml2ZXIg
dGhlbiBkcml2ZXMgdGhlIGRhdGEgYW5kIHN0YXR1cyBzdGFnZXMgYnkNCj4gPiB3cml0aW5nIFVE
Q19FUDBfQ1RSTDsgdGhhdCBtb3ZlcyBkYXRhIHRvL2Zyb20gdGhlIGRyaXZlcidzIERNQSBidWZm
ZXINCj4gPiBhbmQgY29tcGxldGVzIHRoZSBwYXJrZWQgcGFja2V0IGJhY2sgdG8gdGhlIGhvc3Qu
DQo+ID4NCj4gPiBTRVRfQUREUkVTUyBpcyB0aGUgZXhjZXB0aW9uOiBpdCBpcyBhcHBsaWVkIHN5
bmNocm9ub3VzbHksIGJlY2F1c2UgdGhlDQo+ID4gaG9zdCBjb250cm9sbGVyIGtlZXBzIHRoZSB0
cmFuc2ZlciBib3VuZCB0byBhZGRyZXNzIDAgdW50aWwgaXQgY29tcGxldGVzLg0KPiA+DQo+ID4g
VGhlIGdhZGdldCBjb25uZWN0cyB0byAvIGRpc2Nvbm5lY3RzIGZyb20gdGhlIGhvc3QgYnVzIHdo
ZW4gdGhlIGRyaXZlcg0KPiA+IHNldHMgb3IgY2xlYXJzIHRoZSB1cHN0cmVhbS1lbmFibGUgKHB1
bGwtdXApIGJpdCwgYW5kIGlzIGRldGFjaGVkIG9uIHJlc2V0Lg0KPiA+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+DQo+ID4gLS0tDQo+ID4g
ICBpbmNsdWRlL2h3L3VzYi9hc3BlZWQtdWRjLmggfCAgMjggKysrDQo+ID4gICBody91c2IvYXNw
ZWVkLXVkYy5jICAgICAgICAgfCAzNjANCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKystDQo+ID4gICBody91c2IvdHJhY2UtZXZlbnRzICAgICAgICAgfCAgIDUgKw0KPiA+ICAg
MyBmaWxlcyBjaGFuZ2VkLCAzOTAgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L3VzYi9hc3BlZWQtdWRjLmggYi9pbmNsdWRlL2h3
L3VzYi9hc3BlZWQtdWRjLmgNCj4gPiBpbmRleCA1OGZlZDVmOWEyLi5hYjlkMDE2YzYxIDEwMDY0
NA0KPiA+IC0tLSBhL2luY2x1ZGUvaHcvdXNiL2FzcGVlZC11ZGMuaA0KPiA+ICsrKyBiL2luY2x1
ZGUvaHcvdXNiL2FzcGVlZC11ZGMuaA0KPiA+IEBAIC0xMCwxMSArMTAsMTkgQEANCj4gPiAgICNk
ZWZpbmUgSFdfVVNCX0FTUEVFRF9VRENfSA0KPiA+DQo+ID4gICAjaW5jbHVkZSAiaHcvY29yZS9z
eXNidXMuaCINCj4gPiArI2luY2x1ZGUgImh3L3VzYi91c2IuaCINCj4gPiAgICNpbmNsdWRlICJx
b20vb2JqZWN0LmgiDQo+ID4NCj4gPiAgICNkZWZpbmUgVFlQRV9BU1BFRURfVURDICJhc3BlZWQu
dWRjIg0KPiA+ICAgT0JKRUNUX0RFQ0xBUkVfU0lNUExFX1RZUEUoQXNwZWVkVURDU3RhdGUsIEFT
UEVFRF9VREMpDQo+ID4NCj4gPiArLyoNCj4gPiArICogVGhlIGdhZGdldCBzaWRlIG9mIHRoZSBj
b250cm9sbGVyIGlzIHByZXNlbnRlZCB0byBhIFVTQiBob3N0DQo+ID4gK2NvbnRyb2xsZXIncw0K
PiA+ICsgKiBidXMgYXMgYSBzaW5nbGUgVVNCIGRldmljZSB0aGF0IGRlbGVnYXRlcyBiYWNrIHRv
IHRoZSBBc3BlZWRVRENTdGF0ZS4NCj4gPiArICovDQo+ID4gKyNkZWZpbmUgVFlQRV9BU1BFRURf
VURDX0dBREdFVCAiYXNwZWVkLnVkYy1nYWRnZXQiDQo+ID4gK09CSkVDVF9ERUNMQVJFX1NJTVBM
RV9UWVBFKEFzcGVlZFVEQ0dhZGdldCwNCj4gQVNQRUVEX1VEQ19HQURHRVQpDQo+ID4gKw0KPiA+
ICAgLyoNCj4gPiAgICAqIFJlZ2lzdGVyIG1hcDogcm9vdC9nbG9iYWwgYmxvY2sgYXQgMHgwMDAg
LSAweDA4NywgdGhlbiBvbmUgMHgxMCBieXRlDQo+IGJhbmsNCj4gPiAgICAqIHBlciBwcm9ncmFt
bWFibGUgZW5kcG9pbnQgZnJvbSAweDIwMC4NCj4gPiBAQCAtMzYsMTQgKzQ0LDM0IEBAIHR5cGVk
ZWYgc3RydWN0IEFzcGVlZFVEQ0VQIHsNCj4gPiAgICAgICBpbnQgaW5kZXg7DQo+ID4gICB9IEFz
cGVlZFVEQ0VQOw0KPiA+DQo+ID4gK3N0cnVjdCBBc3BlZWRVRENHYWRnZXQgew0KPiA+ICsgICAg
VVNCRGV2aWNlIHBhcmVudF9vYmo7DQo+ID4gKyAgICBBc3BlZWRVRENTdGF0ZSAqdWRjOw0KPiA+
ICt9Ow0KPiA+ICsNCj4gPiAgIHN0cnVjdCBBc3BlZWRVRENTdGF0ZSB7DQo+ID4gICAgICAgU3lz
QnVzRGV2aWNlIHBhcmVudF9vYmo7DQo+ID4NCj4gPiAgICAgICBNZW1vcnlSZWdpb24gdWRjX2Nv
bnRhaW5lcjsNCj4gPiAgICAgICBNZW1vcnlSZWdpb24gcm9vdF9tcjsNCj4gPiArICAgIE1lbW9y
eVJlZ2lvbiAqZHJhbV9tcjsNCj4gPiArICAgIEFkZHJlc3NTcGFjZSBkcmFtX2FzOw0KPiA+ICAg
ICAgIHVpbnQzMl90IHJlZ3NbQVNQRUVEX1VEQ19ST09UX05SX1JFR1NdOw0KPiA+ICAgICAgIEFz
cGVlZFVEQ0VQIGVwW0FTUEVFRF9VRENfTlVNX0VQXTsNCj4gPiAgICAgICBxZW11X2lycSBpcnE7
DQo+ID4gKw0KPiA+ICsgICAgLyogZ2FkZ2V0IFVTQiBkZXZpY2UgYm91bmQgdG8gdGhpcyBjb250
cm9sbGVyIChzZXQgYXQgaXRzIHJlYWxpemUpICovDQo+ID4gKyAgICBBc3BlZWRVRENHYWRnZXQg
KnVzYmdhZGdldDsNCj4gDQo+IERvIHlvdSBtaW5kIGV4cG9zaW5nIHRoaXMgYXMgYSBsaW5rIHBy
b3BlcnR5IChhbmQgdXNpbmcgdGhlIHByb3BlciBtZXRob2RzIHRvDQo+IHNldCBpdCk/DQo+IA0K
VGhhbmtzIGZvciB0aGUgcmV2aWV3IGFuZCBzdWdnZXN0aW9uLg0KV2lsbCBkby4NCkphbWluDQo+
ID4gKw0KPiA+ICsgICAgLyoNCj4gPiArICAgICAqIEluLWZsaWdodCBFUDAgY29udHJvbCB0cmFu
c2ZlciAoaG9zdCBzaWRlKSwgZGVmZXJyZWQgdW50aWwgdGhlIGd1ZXN0DQo+ID4gKyAgICAgKiBn
YWRnZXQgZHJpdmVyIHJlc3BvbmRzIHZpYSBNTUlPLg0KPiA+ICsgICAgICovDQo+ID4gKyAgICBV
U0JQYWNrZXQgKmVwMF9wYWNrZXQ7DQo+ID4gKyAgICB1aW50MzJfdCBlcDBfc2V0dXBfbGVuOw0K
PiA+ICsgICAgdWludDMyX3QgZXAwX29mZnNldDsNCj4gPiArICAgIHVpbnQ4X3QgKmVwMF9kYXRh
Ow0KPiA+ICsgICAgYm9vbCBlcDBfZGlyX2luOw0KPiA+ICAgfTsNCg==

