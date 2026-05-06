Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75BE8CD3427
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 03:37:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKT4J-0001ju-GX; Tue, 05 May 2026 23:37:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wKT48-0001i8-5M; Tue, 05 May 2026 23:36:56 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wKT45-0006N2-N1; Tue, 05 May 2026 23:36:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hzvlyPYmcguC50m2TWEjxvtnfursZZxbHLqcz6lPW/cRRdySflcrvdd6DwMB/jGyhLsSyZNbiH62/EQ9Fu/czVB/KXUMGlWKTh1zS7bse5jajAg+0RwjXHNYCAJjyWhm8pVNkR+RVLHun3iwEDehy552xuz66hu+8iesLlJD8CeqFXMHM1FSPO70aPgvchH68nFRTo1H7H/cqF/SZSdjjChm9a8hqdi6T+YHG1DxfupTYuw9LcZ4UWgCqu69ajUwyU3o2dN4aZ0mFbvqq4PJ/Z+HwjwpQDcFo8iFoV6KvPcWAPbPdE8twlTWc+XHOSyaSWXTbwDpzvBptuvlyqGENw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hGWWSsZZ58B1BL88gsdSxmGbHnXd14AsMdJRwhtS5vk=;
 b=FyW7kzKOSvRLLp6t9vdtEUPJtAs9lIxBjsspnx0edUOrFHcToSR99xsBhGr2Ji66M9nin4cnw0RDdMkZsC06yhDTXXMCP5EZaRGksFkmo809Qypje0exI3puctr//bM7oNSgF+5u08Cw4QXH+PVjm0yuA4BrklcmfdmdbMs/QrNHi4N+tHRb+wcAgZv1QY4GYU36VAQ9RF4Iu/kzZZ+0IFQMr6AnwNrn0j2XYGllzOCaGyfcMYkRk1Z4QKczM9APV/8NgS42rXaCgXZDpc1k2s+juq3FQKkSw2NXZnBmpqtzC/hsF4402YSIjS+gQBguCqDmW8lNs3PSiqc2OCo3og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hGWWSsZZ58B1BL88gsdSxmGbHnXd14AsMdJRwhtS5vk=;
 b=N1tkfOstWis/WSwS0Al44ojfnJO+gtJj13itXhQuzKCiZePmUPPj67tQA2/yLHPbvo3XW2e59idL4+xDVaYND4WaIXXebXN/2SToAEeDJrRAydUTwillyCkEPa9CthQmWzU+w4gPOSQX2QlESd4lnkfh9+QUIBhMd+DBpHw0ngRD2Ei18j52pk7lNNO9JYKYtkixPlPFrLS3+dB6hccSXOPbMUFEQ/uPijPICv3rz1bQYcYCL8a6Rc1zk/+AbODqIHu29j+12jb9HOMVTn9I9XB9DM54646PO7uprFOOnKLLGIAdhLJQ4KCd+O8YUVuZhN1KAf2oXIxoToyeTQk53A==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TY0PR06MB6883.apcprd06.prod.outlook.com (2603:1096:405:15::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 03:36:43 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 03:36:43 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "peterx@redhat.com" <peterx@redhat.com>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Zhao Liu <zhao1.liu@intel.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "farosas@suse.de" <farosas@suse.de>,
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: RE: [PATCH v6 08/11] hw/usb/hcd-ehci: Add ctrldssegment-default
 property
Thread-Topic: [PATCH v6 08/11] hw/usb/hcd-ehci: Add ctrldssegment-default
 property
Thread-Index: AQHc23E97LiOY55oYE6l1HWddzDthLX9uLSAgAAQegCAAAa9gIAACG8AgAJbLSCAACYXkA==
Date: Wed, 6 May 2026 03:36:42 +0000
Message-ID: <TYPPR06MB820680D1E9D537E797DFBEF5FC3F2@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260504025342.1452605-1-jamin_lin@aspeedtech.com>
 <20260504025342.1452605-9-jamin_lin@aspeedtech.com>
 <67a45038-e4bb-48f8-af08-af0d5c308ece@linaro.org>
 <e45a4765-0c3d-4fc0-8080-cdad5f877a92@redhat.com>
 <d9c8bf73-70f3-4bb3-b1cc-0f64f1ee5bc2@linaro.org>
 <1ed28a9f-ad15-4109-88f8-e7657fe33235@redhat.com>
 <TYPPR06MB8206C0C6EBCAB79A77BDF3EFFC3F2@TYPPR06MB8206.apcprd06.prod.outlook.com>
In-Reply-To: <TYPPR06MB8206C0C6EBCAB79A77BDF3EFFC3F2@TYPPR06MB8206.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TY0PR06MB6883:EE_
x-ms-office365-filtering-correlation-id: 3789e39f-7ae6-4868-5813-08deab20b100
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|13003099007|921020|18002099003|56012099003|22082099003|38070700021;
x-microsoft-antispam-message-info: bUVJVcBvtAwuZkVcQbikJp5jQ6axeWlRfuj89yFl4EVvam1IvOpncsXeuF3LcVkHe5GYBHT67tTjqRrYMjfWn3kDFrwaMPDFb4A3BJnKl54IaiCEK7/FhzHLAz/G2MrfKYe2nv9/A+wfh6OlpbjwKuuC3RglA1MicVGPuvbGBecgsZVfLUc9RpNfA+ykBGkH2uFvmowi5Ni4DbNQgCVV+J+Rd4AGQVAPvd9fi8cNZXiqrXRbX4FxXQ95lTT6xy0kBWZylXhNOUn5J0FI9pHV+O+jDTPS7zqTxpvC7H7x8advHGm5/0+S0bkeqWYdabko7oWm/II1wYXCxhgHHC51ICrULXzIjJ0fUGswgTn5V/pk/uf9rzW+VKtOOwaxy/0NIsNC/qi/RvtSV9wuqHyV1h/7/F72hc39RhYDNnkiib6Ww0zboYJevjsCsOe4S1CYd/bVdFxwO628aBsMUtHLmb2jQH0VXmBCIrvoTn0hFYFCBUNXvBrekxudevL/SU98wzfX3MKmTcMDNenz53/OUepTaeF/RTFK0jTJEQZUaiybEuNmirD0ue7xph7lLlbkHxLJE3NLD7kmslilsxle2nCRgND08b9vi7Bdx2KSctdbXGTkY6QWZlzJO6XCUez9sqQzD1LDOMkAXT/wDF/kUhf050HxLr0mjMWK4Oe2KuQfoIVyVM/fRbUD/+nwoY0IBQFCqFRCLYe7dw6aFvT8hMITaS0FkIwctvHLb8RQ2Ns=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(13003099007)(921020)(18002099003)(56012099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TVdhZmhtL0laQk1aelF0L3JuY1g4RE80eXJlM0lESWZEdDh2eGZRckRLTDhQ?=
 =?utf-8?B?OFdTTHd6WEhmdUpkZ2xDZDMzK2RVQnRSWGptNmtQN0pjNmFPdWthbEMvQ3Jn?=
 =?utf-8?B?VXMxenBwbEpVVmZLOXB4Q3JlL2NySEREY1puUDFmRmxkR3JEbWhTTy91UEVJ?=
 =?utf-8?B?YzYyWEp6akhGNkRScGtUSkRnK2hYKzJ6NWRBZVNjMDRGRi9QOXdSWTNsK2VI?=
 =?utf-8?B?ajhqSDlrNHJ6bE1DSWlxbEZvNld5TFYvaWcwUXB4YWJBVkVMWDFvZFFVcys0?=
 =?utf-8?B?RnBEMEZPM1hKT1kvNUx0YWN2N3dMSG9FZFJDS1MrVkpzS0hLblB0aTBpSlFK?=
 =?utf-8?B?QVZoUXZ2VnhtWVZrN3AzOU1uYXJnMlJWYUgrd2FYTU53ZjlnNExGS2F6c0cx?=
 =?utf-8?B?cUxjRGRwZ1Q3emZISjhRMW9La0RBL1ZVZnlPRHJEcXBkd1lvaGU2WGhXdkxY?=
 =?utf-8?B?NWl6bVgxa3BELzd4RXF0NW5Vd2VsMTR6aXhOeXdOc3BPSWM5Nld5YW1mSmVN?=
 =?utf-8?B?YXdpL2p3TWREeGZsdkZjNnp6R250VjhnbSs5UUt4TG55QjdORktPSWt3Mk0v?=
 =?utf-8?B?a1o1L2VjM3RtWVl6U0VVVE85V1k3dDJEUW5uZjl3eTdBbTN2YjVKejIyeGNW?=
 =?utf-8?B?WHYrVDhOYWVoWC9nWXhVeDF6eENiQis3MC9wSVNmU0tXSUlvS0xVRHlDL2p1?=
 =?utf-8?B?K1ZnYmZyVHhlcWVFc1N2OG9HcGlYZENHWjZNOTFqZ2FUSXphUUhKR3VtMElM?=
 =?utf-8?B?cGx0cVlxTFlJZkFacnZWOGMvdldXMVdWTE0reU9DV0hCZlZKeHc1Q25hc3pL?=
 =?utf-8?B?M00vOWVDTVl3SmlXeHZHK3BCcnVlUlhDclV3SWduQkJvWWlZUnNVSkwrL0Uz?=
 =?utf-8?B?Q3ByT29BNVhWTGZmVXBobXJaVktwS0RKWGdWemxwQnhVcFE0WXNCa2F6VDNq?=
 =?utf-8?B?TGlDeDdTT2RJbkM4OEV4VG9iUTUwSFl5TFJVWm4xK2VLajVWUXJ2eEZ4L1Bq?=
 =?utf-8?B?eThld2NaZkszQk56RWppRlY2NjlzR3Z1d0VtRlNpSGhxSisrNjN0SHdYTkM3?=
 =?utf-8?B?T3I2Sm1qenBHNnNONGNoQ29GN1k3TGlVQ1JRT1BtK29LN0xrdFY5YXlzM2JF?=
 =?utf-8?B?c0VucXlnMkJsQmE1T2NJdXpzbktJODdxRjhCVkNaUUwzUlZOVG5lOHZOSnlK?=
 =?utf-8?B?UGh3MWVwZU5oRW4zbTZrZWFVVVl0aHFlMWRRMjBJak1nQUovTTNvRzg4Qk1u?=
 =?utf-8?B?M1VVcGVROVdQWlJvYW43S1JNYy8xaU4vVndhbm1ZTU8rSVVlSjBZdzN2Nldz?=
 =?utf-8?B?KzVaVm0xQ1FObzNNeGsxbmtIeVpCSFdhdDlXaUtvd0RCcFJ2NUpJL1NYa0Vn?=
 =?utf-8?B?RmFRTkZQcGJqSnV6bUdvMmRabk1ocEozenJmWXV6R294Q09QUEhMaTVnRTlY?=
 =?utf-8?B?R0Z3YlZlQjBJQ1liY2dxTmJZWllpYldEVytnYklUc0V0Tk5YbloxRmRQRm5C?=
 =?utf-8?B?dDZTcTJjRTVSYUpnUHFmMk9tdmVUcTloZFBpdUtTbmNoRmZBL1Fmc1hpVXRL?=
 =?utf-8?B?anJmcTF0b0cvS0NZUFlRanZWdGJNUHVGb0ZkUTJ4VW0wUkJ0Y2lGK2JCNXpp?=
 =?utf-8?B?QkJKUlR4eGJGMTZoUlJvQW1MYmpaa0NFY3lWNkx5K3JEYlhpaTlMTVZWWFFn?=
 =?utf-8?B?Uk9ZV1NIbFpoVnNOSUZibU1VVGNWRGIvNVdnNnhUWjRrTUVSZnllaWdqaFNu?=
 =?utf-8?B?OVlZY3VIVnNLT1FFQ3NqVTB4UGt2dm1LUWRPek9TdUVWSGR5bkRZM01VN0pr?=
 =?utf-8?B?VG1yWGFWWDFBTGxVL2RRd1ZEYTdaVUZuNDRJTmxNMjY0T1pqa2RrNnRBR0tk?=
 =?utf-8?B?UmJjdm5XTDV2VUNkRDBPaXlmYS9FYklNVWFEU1ZLdkJKaU9IUFlvdWI1cHBC?=
 =?utf-8?B?bnozMXkzTEdTbzhWMEVySytXV1l1RWxtS3NrQ1MvSE0rWnFML1d6bGlwQ0Z5?=
 =?utf-8?B?K3FWWU1WcGRmZW5UVEU3RHJINTNrTU9wNTBCTFk5dkJwWmtIRkdVdEovVERq?=
 =?utf-8?B?N0xXSmRuUWVNdFU0TThObktQeVhsdkdYWTJuTTUzTk1xNjhIdWlxRHRBS3JV?=
 =?utf-8?B?L0wxRnJ5WjhHdXk0bitvK2RzVFo5aFlYSElnNUdvaW1tSmxIYzlaUGZoRkNE?=
 =?utf-8?B?cjBsNk1MVDZIS0JNNHpoeWJtL1NMQjRZdlo1OTl4ZWE3OHdUVVVlSkxBYnAz?=
 =?utf-8?B?U25iUzlVejJTVFEzTkdwRERFTFRzMmovZTlxTTNyZDIza0VMYkhXdlRKNlMx?=
 =?utf-8?B?TEx4WjRJNjNkeWhaK3ZWS1ZIUWFnTlQwa3pIN3A0d1c3RlowWVUrdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: K8TjmPlyfe+I1oK2y9Qvma5OKTzYAWboYurphvVvBQZVNs6EVOxvQrZEd3DG4E6emriuipXTOvfa0A46YzK8Ad29Tl0THSN7jvDqBNoY1zDgv4A6PSXJ3fFcA8iGsEIHZRI70lnPpDQIRndMbQ+nz3DF9QaVIixsxYY6zkpyq5gwSpuN37C1qsYEzr1lB2ZnCFYC8az+q89lRwU+RxEdyflj0J2WZNYrsJLawP4ZFNqrF1IpkNV9Yo3dvJpKOGWcvx8hd9ORRsppyY2CsxvNShT7VpFELfOmJ8179U/8k0ZPrGcyHJAvrxkly7u4Kvt5BjrnlTdYTUs/phqQb8K2jA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3789e39f-7ae6-4868-5813-08deab20b100
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2026 03:36:43.0017 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lknN5zYOF16Fch2sY+MA6dzC2a5uyzzRzA1S+Z+StWK1dJ/JS+U8RHCuzGIsOgYn7yepbyj2+XAxCFzD41iiPn1xzXNeEwYoWmiSJ/V9/Ik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB6883
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
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

SGkgQ8OpZHJpYywgUGhpbGlwcGUNCg0KUGxlYXNlIGhlbHAgdG8gcmV2aWV3Lg0KDQpody91c2Iv
ZWhjaTogSW1wcm92ZSBtaWdyYXRpb24gaGVscGVyIGFuZCBwcm9wZXJ0eSBuYW1pbmcNCmh0dHBz
Oi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9xZW11LWRldmVsL2xpc3QvP3Nlcmllcz0x
MDkwMjMzDQoNClRoYW5rcywNCkphbWluDQoNCj4gSGkgQ8OpZHJpYywgUGhpbGlwcGUNCj4gDQo+
ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2NiAwOC8xMV0gaHcvdXNiL2hjZC1laGNpOiBBZGQNCj4g
PiBjdHJsZHNzZWdtZW50LWRlZmF1bHQgcHJvcGVydHkNCj4gPg0KPiA+IE9uIDUvNC8yNiAxNDo0
MiwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+ID4gPiBPbiA0LzUvMjYgMTQ6MTcs
IEPDqWRyaWMgTGUgR29hdGVyIHdyb3RlOg0KPiA+ID4+IE9uIDUvNC8yNiAxMzoxOCwgUGhpbGlw
cGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+ID4gPj4+IE9uIDQvNS8yNiAwNDo1MywgSmFtaW4g
TGluIHdyb3RlOg0KPiA+ID4+Pj4gV2hlbiA2NC1iaXQgYWRkcmVzc2luZyBpcyBzdXBwb3J0ZWQs
IHRoZSBMaW51eCBFSENJIGRyaXZlcg0KPiA+ID4+Pj4gcHJvZ3JhbXMgdGhlIHNlZ21lbnQgcmVn
aXN0ZXIgdG8gemVyby4gU2VlIGVoY2lfcnVuIGZ1bmN0aW9uOg0KPiA+ID4+Pj4gaHR0cHM6Ly9n
aXRodWIuY29tL3RvcnZhbGRzL2xpbnV4L2Jsb2IvbWFzdGVyL2RyaXZlcnMvdXNiL2hvc3QvZWgN
Cj4gPiA+Pj4+IGNpDQo+ID4gPj4+PiAtIGhjZC5jDQo+ID4gPj4+Pg0KPiA+ID4+Pj4gVGhlIGRy
aXZlciBjb21tZW50IGFsc28gbm90ZXMgdGhhdCBkZXNjcmlwdG9yIHN0cnVjdHVyZXMNCj4gPiA+
Pj4+IGFsbG9jYXRlZCBmcm9tIHRoZSBETUEgcG9vbCB1c2Ugc2VnbWVudCB6ZXJvIHNlbWFudGlj
cy4NCj4gPiA+Pj4+DQo+ID4gPj4+PiBEZXNjcmlwdG9yIG1lbW9yeSBpcyBhbGxvY2F0ZWQgdXNp
bmcgdGhlIERNQSBBUEkuIFRoZSBwbGF0Zm9ybQ0KPiA+ID4+Pj4gZHJpdmVyIGNvbmZpZ3VyZXMg
YSA2NC1iaXQgRE1BIG1hc2sgc28gbWVtb3J5IGNhbiBiZSBhbGxvY2F0ZWQNCj4gPiA+Pj4+IGFi
b3ZlDQo+ID4gNEdCLg0KPiA+ID4+Pj4gU2VlIGVoY2lfcGxhdGZvcm1fcHJvYmUgZnVuY3Rpb246
DQo+ID4gPj4+PiBodHRwczovL2dpdGh1Yi5jb20vdG9ydmFsZHMvbGludXgvYmxvYi9tYXN0ZXIv
ZHJpdmVycy91c2IvaG9zdC9laA0KPiA+ID4+Pj4gY2kNCj4gPiA+Pj4+IC0gcGxhdGZvcm0uYw0K
PiA+ID4+Pj4NCj4gPiA+Pj4+IE9uIEFTVDI3MDAgcGxhdGZvcm1zLCBzeXN0ZW0gRFJBTSBpcyBt
YXBwZWQgYWJvdmUgNEdCIGF0DQo+ID4gMHg0MDAwMDAwMDAuDQo+ID4gPj4+PiBBcyBhIHJlc3Vs
dCwgZGVzY3JpcHRvciBhZGRyZXNzZXMgY29uc3RydWN0ZWQgZGlyZWN0bHkgZnJvbSB0aGUNCj4g
PiA+Pj4+IGd1ZXN0IEVIQ0kgcmVnaXN0ZXJzIGRvIG5vdCBtYXRjaCB0aGUgYWN0dWFsIHN5c3Rl
bSBhZGRyZXNzIHVzZWQNCj4gPiA+Pj4+IGJ5IHRoZSBjb250cm9sbGVyIHdoZW4gZmV0Y2hpbmcg
cXVldWUgaGVhZHMgKFFIKSBhbmQgcXVldWUNCj4gPiA+Pj4+IGVsZW1lbnQgdHJhbnNmZXIgZGVz
Y3JpcHRvcnMgKHFURCkuDQo+ID4gPj4+Pg0KPiA+ID4+Pj4gQWRkIGEgY3RybGRzc2VnbWVudC1k
ZWZhdWx0IHByb3BlcnR5IHNvIHBsYXRmb3JtcyBjYW4gcHJvdmlkZSBhDQo+ID4gPj4+PiBkZXNj
cmlwdG9yIGFkZHJlc3Mgb2Zmc2V0IHdoZW4gY29uc3RydWN0aW5nIGRlc2NyaXB0b3IgYWRkcmVz
c2VzLg0KPiA+ID4+Pj4gVGhpcyBhbGxvd3Mgc3lzdGVtcyB3aGVyZSBEUkFNIHJlc2lkZXMgYWJv
dmUgNEdCIHRvIGFjY2VzcyBFSENJDQo+ID4gPj4+PiBkZXNjcmlwdG9ycyBjb3JyZWN0bHkuDQo+
ID4gPj4+Pg0KPiA+ID4+Pj4gVGhlIGRlZmF1bHQgdmFsdWUgaXMgemVybywgc28gZXhpc3Rpbmcg
bWFjaGluZXMgYXJlIG5vdCBhZmZlY3RlZC4NCj4gPiA+Pj4+DQo+ID4gPj4+PiBTaWduZWQtb2Zm
LWJ5OiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPiA+Pj4+IFJldmll
d2VkLWJ5OiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+ID4gPj4+PiAtLS0N
Cj4gPiA+Pj4+IMKgIGh3L3VzYi9oY2QtZWhjaS5oIHwgNSArKysrLQ0KPiA+ID4+Pj4gwqAgaHcv
dXNiL2hjZC1laGNpLmMgfCAxICsNCj4gPiA+Pj4+IMKgIDIgZmlsZXMgY2hhbmdlZCwgNSBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gPj4+Pg0KPiA+ID4+Pj4gZGlmZiAtLWdpdCBh
L2h3L3VzYi9oY2QtZWhjaS5oIGIvaHcvdXNiL2hjZC1laGNpLmggaW5kZXgNCj4gPiA+Pj4+IDhl
NmE4Y2RmYjAuLjNkNTdlMWRlNWYgMTAwNjQ0DQo+ID4gPj4+PiAtLS0gYS9ody91c2IvaGNkLWVo
Y2kuaA0KPiA+ID4+Pj4gKysrIGIvaHcvdXNiL2hjZC1laGNpLmgNCj4gPiA+Pj4+IEBAIC0yNjQs
NiArMjY0LDcgQEAgc3RydWN0IEVIQ0lTdGF0ZSB7DQo+ID4gPj4+PiDCoMKgwqDCoMKgIHVpbnQz
Ml90IG1heGZyYW1lczsNCj4gPiA+Pj4+IMKgwqDCoMKgwqAgYm9vbCBtaWdyYXRlX2ZldGNoX2Fk
ZHJfNjRiaXQ7DQo+ID4gPj4+PiDCoMKgwqDCoMKgIGJvb2wgY2Fwc182NGJpdF9hZGRyOw0KPiA+
ID4+Pj4gK8KgwqDCoCB1aW50MzJfdCBjdHJsZHNzZWdtZW50X2RlZmF1bHQ7DQo+ID4gPj4+PiDC
oMKgwqDCoMKgIC8qDQo+ID4gPj4+PiDCoMKgwqDCoMKgwqAgKsKgIEVIQ0kgc3BlYyB2ZXJzaW9u
IDEuMCBTZWN0aW9uIDIuMyBAQCAtMzIyLDcgKzMyMyw5DQo+IEBADQo+ID4gPj4+PiBzdHJ1Y3Qg
RUhDSVN0YXRlIHsNCj4gPiA+Pj4+IMKgwqDCoMKgwqAgREVGSU5FX1BST1BfQk9PTCgieC1taWdy
YXRlLWZldGNoLWFkZHItNjRiaXQiLCBfc3RhdGUsIFwNCj4gPiA+Pj4+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVoY2kubWlncmF0ZV9mZXRjaF9hZGRyXzY0
Yml0LA0KPiB0cnVlKSwNCj4gPiBcDQo+ID4gPj4+PiDCoMKgwqDCoMKgIERFRklORV9QUk9QX0JP
T0woImNhcHMtNjRiaXQtYWRkciIsIF9zdGF0ZSwgXA0KPiA+ID4+Pj4gLcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZWhjaS5jYXBzXzY0Yml0X2FkZHIsIGZhbHNlKQ0K
PiA+ID4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZWhjaS5j
YXBzXzY0Yml0X2FkZHIsIGZhbHNlKSwgXA0KPiA+ID4+Pj4gK8KgwqDCoCBERUZJTkVfUFJPUF9V
SU5UMzIoImN0cmxkc3NlZ21lbnQtZGVmYXVsdCIsIF9zdGF0ZSwgXA0KPiA+ID4+Pj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVoY2kuY3RybGRzc2VnbWVu
dF9kZWZhdWx0LCAwKQ0KPiA+ID4+Pg0KPiA+ID4+PiBjdHJsLWRzLXNlZ21lbnQtZGVmYXVsdCBh
bmQgY3RybF9kc19zZWdtZW50X2RlZmF1bHQ/DQo+ID4gPj4+DQo+ID4gPj4+IE90aGVyd2lzZSwN
Cj4gPiA+Pj4gUmV2aWV3ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGlu
YXJvLm9yZz4NCj4gPiA+Pj4NCj4gPiA+Pg0KPiA+ID4+IHllYWguIEkgYWdyZWUuIFRoYXQncyB0
aGUgZ2VuZXJhbCBwYXR0ZXJuIGZvciBwcm9wZXJ0eSBuYW1lcy4NCj4gPiA+DQo+ID4gPiBJIGRv
bid0IGdldCB0aGUgJy1kZWZhdWx0JyBzdWZmaXguIEFsdGVybmF0aXZlczoNCj4gPiA+DQo+ID4g
PiBkcmFtLXNlZ21lbnQtYmFzZS1hZGRyIG9yIGV2ZW4geC1kcmFtLXNlZ21lbnQtYmFzZS1hZGRy
DQo+ID4NCj4gPiBXaGF0IGV2ZXIgbWFrZXMgc2Vuc2UuIEVIQ0kgc3BlY3MgaGF2ZSA6DQo+ID4N
Cj4gPiAgICBDVFJMRFNTRUdNRU5UICA0RyBTZWdtZW50IFNlbGVjdG9yDQo+ID4NCj4gPiBUaGUg
cHVycG9zZSBvZiB0aGUgImN0cmxkc3NlZ21lbnQtZGVmYXVsdCIgcHJvcGVydHkgaXMgdG8gZm9y
Y2UgYQ0KPiA+IGRlZmF1bHQgdmFsdWUgb2YgdGhlIENUUkxEU1NFR01FTlQgcmVnaXN0ZXIgZm9y
IHRoZSBhc3QyNzAwLg0KPiA+DQo+ID4gSmFtaW4sIGhvdyBhcmUgd2Ugc3VyZSB0aGUgRE1BcyBh
cmUgYWxsb2NhdGVkIGluIHRoaXMgNEcgc2VnbWVudCA/DQo+ID4gYmVjYXVzZSBSQU0gY292ZXJz
IDhHIDoNCj4gPg0KPiA+ICAgICAgICAwMDAwMDAwNDAwMDAwMDAwLTAwMDAwMDA1ZmZmZmZmZmYg
KHByaW8gMCwgcmFtKTogcmFtDQo+ID4NCj4gDQo+IEl0IGlzIGEgZmlybXdhcmUgaXNzdWUuIEFm
dGVyIGRpc2N1c3NpbmcgaXQgd2l0aCB0aGUgVVNCIGRyaXZlciBvd25lciwgd2UgZm91bmQNCj4g
dGhhdCB0aGlzIGlzc3VlIG9jY3VycyB3aGVuIHVzZXJzIHVzZSA4R0IgRFJBTSBiZWNhdXNlIHRo
ZSBkcml2ZXIgZG9lcyBub3QNCj4gY29uZmlndXJlIENUUkxEU1NFR01FTlQuDQo+IEN1cnJlbnRs
eSwgb3VyIFNESyBvbmx5IHN1cHBvcnRzIHVwIHRvIDJHQiBEUkFNLCBzbyB1c2VycyBzaG91bGQg
bm90DQo+IGVuY291bnRlciB0aGlzIGlzc3VlIHVuZGVyIG5vcm1hbCBjb25kaXRpb25zLg0KPiBI
b3dldmVyLCB0aGlzIGNvdWxkIGJlY29tZSBhIHBvdGVudGlhbCBpc3N1ZSBpZiB1c2VycyBjb25m
aWd1cmUgdGhlIERSQU0gc2l6ZQ0KPiB0byA4R0IuDQo+IA0KPiA+DQo+ID4gPiBzaW5jZSBJIHN0
aWxsIGJlbGlldmUgdGhpcyBpcyBhIEFTVDI3MDAgaXNzdWUsIGxpa2VseSBub3QgbWFwcGluZw0K
PiA+ID4gUkFNIGFwcHJvcHJpYXRlbHkuDQo+ID4NCj4gPiBPdGhlciBjb250cm9sbGVycyB3b3Vs
ZCBiZSBpbXBhY3RlZCBubyA/DQo+ID4gTGludXggKHVwc3RyZWFtKSBmb3JjZXMgdGhlIENUUkxE
U1NFR01FTlQgdmFsdWUgOg0KPiA+DQo+IExpbnV4ICh1cHN0cmVhbSkgZm9yY2VzIENUUkxEU1NF
R01FTlQgdG8gMCwgd2hpY2ggbWVhbnMgb25seSBEUkFNDQo+IGFkZHJlc3NlcyBiZWxvdyA0R0Ig
YXJlIGFsbG93ZWQuDQo+IA0KPiBUaGVyZWZvcmUsIEFTVDI3MDAgaGFyZHdhcmUgc2V0cyB0aGUg
ZGVmYXVsdCB2YWx1ZSBvZiBDVFJMRFNTRUdNRU5UIHRvIDQsDQo+IHdoaWNoIG1hcHMgdG8gdGhl
IEFTVDI3MDAgRFJBTSByZXF1aXJlZCBiYXNlIGFkZHJlc3MgMHg0MDAwMDAwMDAuDQo+IA0KPiBJ
biBvdGhlciB3b3JkcywgdGhlIEFTVDI3MDAgZmlybXdhcmUgb25seSBuZWVkcyB0byBjb25maWd1
cmUgYml0cyAwIGFuZCAxIG9mDQo+IENUUkxEU1NFR01FTlQuDQo+IA0KPiBIb3dldmVyLCBzZXR0
aW5nIG9ubHkgYml0cyAwIGFuZCAxIGluIHRoZSBmaXJtd2FyZSBpcyBub3Qgc3VmZmljaWVudCBm
b3IgUUVNVSwNCj4gYmVjYXVzZSBRRU1VIGlzIG5vdCBhd2FyZSB0aGF0IHRoZSBBU1QyNzAwIGhh
cmR3YXJlIGluaXRpYWxpemVzIHRoZSBkZWZhdWx0DQo+IHZhbHVlIG9mIENUUkxEU1NFR01FTlQg
dG8gNC4NCj4gDQo+IEluIGNvbmNsdXNpb24sIHNob3VsZCBJIHJlbmFtZSB0aGlzIHByb3BlcnR5
IHRvIGN0cmwtZHMtc2VnbWVudC1kZWZhdWx0IGFuZA0KPiBjdHJsX2RzX3NlZ21lbnRfZGVmYXVs
dD8NCj4gQWxzbywgc2hvdWxkIEkgY3JlYXRlIGEgbmV3IHBhdGNoIGZvciB0aGlzIGNoYW5nZSwg
b3IgcmVzZW5kIHRoZSBlbnRpcmUgcGF0Y2gNCj4gc2VyaWVzPw0KPiANCj4gVGhhbmtzLA0KPiBK
YW1pbg0KPiA+IAkvKg0KPiA+IAkgKiBoY2NfcGFyYW1zIGNvbnRyb2xzIHdoZXRoZXIgZWhjaS0+
cmVncy0+c2VnbWVudCBtdXN0ICghISEpDQo+ID4gCSAqIGJlIHVzZWQ7IGl0IGNvbnN0cmFpbnMg
UUgvSVREL1NJVEQgYW5kIFFURCBsb2NhdGlvbnMuDQo+ID4gCSAqIGRtYV9wb29sIGNvbnNpc3Rl
bnQgbWVtb3J5IGFsd2F5cyB1c2VzIHNlZ21lbnQgemVyby4NCj4gPiAJICogc3RyZWFtaW5nIG1h
cHBpbmdzIGZvciBJL08gYnVmZmVycywgbGlrZSBkbWFfbWFwX3NpbmdsZSgpLA0KPiA+IAkgKiBj
YW4gcmV0dXJuIHNlZ21lbnRzIGFib3ZlIDRHQiwgaWYgdGhlIGRldmljZSBhbGxvd3MuDQo+ID4g
CSAqDQo+ID4gCSAqIE5PVEU6ICB0aGUgZG1hIG1hc2sgaXMgdmlzaWJsZSB0aHJvdWdoIGRldi0+
ZG1hX21hc2ssIHNvDQo+ID4gCSAqIGRyaXZlcnMgY2FuIHBhc3MgdGhpcyBpbmZvIGFsb25nIC4u
LiBsaWtlIE5FVElGX0ZfSElHSERNQSwNCj4gPiAJICogU2NzaV9Ib3N0LmhpZ2htZW1faW8sIGFu
ZCBzbyBmb3J0aC4gIEl0J3MgcmVhZG9ubHkgdG8gYWxsDQo+ID4gCSAqIGhvc3Qgc2lkZSBkcml2
ZXJzIHRob3VnaC4NCj4gPiAJICovDQo+ID4gCWhjY19wYXJhbXMgPSBlaGNpX3JlYWRsKGVoY2ks
ICZlaGNpLT5jYXBzLT5oY2NfcGFyYW1zKTsNCj4gPiAJaWYgKEhDQ182NEJJVF9BRERSKGhjY19w
YXJhbXMpKSB7DQo+ID4gCQllaGNpX3dyaXRlbChlaGNpLCAwLCAmZWhjaS0+cmVncy0+c2VnbWVu
dCk7ICAgICAgIDwtLS0tLS0tIGhlcmUNCj4gPiAjaWYgMA0KPiA+IC8vIHRoaXMgaXMgZGVlcGx5
IGJyb2tlbiBvbiBhbG1vc3QgYWxsIGFyY2hpdGVjdHVyZXMNCj4gPiAJCWlmICghZG1hX3NldF9t
YXNrKGhjZC0+c2VsZi5jb250cm9sbGVyLCBETUFfQklUX01BU0soNjQpKSkNCj4gPiAJCQllaGNp
X2luZm8oZWhjaSwgImVuYWJsZWQgNjRiaXQgRE1BXG4iKTsgI2VuZGlmDQo+ID4gCX0NCj4gPg0K
PiA+DQo+ID4gQy4NCg0K

