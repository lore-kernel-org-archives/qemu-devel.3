Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8A50CD6E56
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 02:55:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUFHI-0004gh-Rz; Mon, 01 Jun 2026 22:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wUFHD-0004fZ-Nz; Mon, 01 Jun 2026 22:54:48 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wUFHB-0000y5-EP; Mon, 01 Jun 2026 22:54:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AiBqa1+dxSAYuXnraQ4+Ke21jvvbCs1us5nJI6SDcPfc/kbvPZ7ifkcxfJTK3fgtE8Wp2JMhyj5fDvKufWCCtVTL/siDLfyOO9Qf8EceHL857HwUgm1pePkiScKtief5yFp9Om6+SFzYY/MWbyF6e2TMqYAqfSc0Qmsp5TgvQ7gYXk+oZuCMPC1kFnc+U1BKMoQ15Sgw8qqtdGJroxIwcquye8v2/z3gudRtxlI+QcfY+WYr+uM856TEAD96jPVmPLd0bWxh/JNjRF3ZbCNrmYw6mHhbAdsD7qYP9SYu2HuCxUxaNKZRpWSmr3Nk7pUBM2SfCRrY7XgtZOskMsSZyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBFaKvQt9X2z0S8QktPQyGqBOc6LisYehYWWOVNd7BI=;
 b=l0fI+OQhPsTG/bXlpH4oGzNwMLEQp+hW24FqnvgZOm5NJ/B1l/ppRR9PNwnvrc2fZ14sHDnowedugHM73CeIqQPDCHMjpWAlpc1vXO6WD2mA7rd+LzvYUBL9yHvLchztvoFxXKsqJyT8xc3ZwziH8eV2dd85OhhcFXibVWVWZ3FvSp+gyP0/Q5nq+z+/D7k2LbzlInc7ILPcOSnm09MuQywtBSGqoi54/NByYYusERuoXesH9qCC+WZzT60iZvoWUIxprhKoK9EZuAUUOO78duk1seCMGa6dpAjPPVILu+wuznMHkOmQY/iFi8YXizp5g6Q2VsLZSsi638sETGnTcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBFaKvQt9X2z0S8QktPQyGqBOc6LisYehYWWOVNd7BI=;
 b=FG5/39BuDW9Jh6nAf+2T5Y2HQytrP/lDxlbDrOnwyZDSgWEqPjRyRb7MHFHhk4QN37ov4gOmMw0HtkMDdGJTQ4X2YH1RU1hP9lcmRXKx4zRvSVoylaIUw2eoJInMKRaliidiX08qPMErTNQsucQNAYfBIjHKKVx6xUA0l4ICYh4GfkQM41Iyy6DLhyKitSZ16EYaDvX4ZJNuzRgfZiehIAriuQcz0yRCi1P27Stlwo4xbv66oAqU5j/WY0TVD/0h25bz9y7s9ZtKgRQjpEqWHu+SxOBMmD8WE6a80OmDADdxMb5dwOYixgFoJVG9XH4sCT9TJUxqVNFskFG5z+8ugg==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SI4PR06MB8373.apcprd06.prod.outlook.com (2603:1096:4:298::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Tue, 2 Jun 2026
 02:54:33 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%5]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 02:54:32 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1 02/10] hw/i2c/aspeed_i2c: Increase AST2700 buffer mode
 size and adjust offset
Thread-Topic: [PATCH v1 02/10] hw/i2c/aspeed_i2c: Increase AST2700 buffer mode
 size and adjust offset
Thread-Index: AQHc7zZc69NhFNx2/E+FFxJ5LOWxJrYpq+eAgADq55A=
Date: Tue, 2 Jun 2026 02:54:32 +0000
Message-ID: <TYZPR06MB49801279CC5AD1A34BEC9698FC122@TYZPR06MB4980.apcprd06.prod.outlook.com>
References: <20260529064243.2064188-1-jamin_lin@aspeedtech.com>
 <20260529064243.2064188-3-jamin_lin@aspeedtech.com>
 <760b6545-2710-4eb3-9a70-321374b6e3e4@kaod.org>
In-Reply-To: <760b6545-2710-4eb3-9a70-321374b6e3e4@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SI4PR06MB8373:EE_
x-ms-office365-filtering-correlation-id: c127dfe0-b5d8-43dc-0942-08dec05245e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|18002099003|22082099003|56012099006|6133799003|4143699003;
x-microsoft-antispam-message-info: 0pJiSd3676HUYhKZaI/nZQ6u85kixfZyx2jWGYV1qSZtTYNKwyDOKlZmgi6AwanMl8FE1it8fleQQ/UWNK69YG6J4Dn+w4sVLFrjtJCcl65aWa69vAE835qSGRpVDHtdmDi84rdEPyFHnG08hdYjvqloJFBtqfaKQN/qaL6f1zBlLv8iyQTslIH/plzU5PFQOPj6V+9tT8egUER+z1w0uzJLva+wWvtHXLW5yCXO6vh6LCPmyZeQJgQxxSVgecp3x/T2GJbnnsxxb7epbICkv1HXGGVpa2YD91JL1nwl/KwOxR5qnMrDgd3kmeTaxdJGyUCBz57ZhZmBXZQ84SeSTa+ozSIVgjbzs+KNwJIH6UCXtlMenRLbab/+9ZXKiuewVJQyZtZ91vhYYto8Ybir3827lYtIl2SlmeUsdBp4bTXIQ/LZeT4ppeX95CUHjT9uR+oEBtltjOJR4qDj9A8ngMCREoi+WMu+29Hig2rmkCBsqYSBuHy3B0t5XPoOuRD2arQyXU6loUumQ3rEvqwhbdHq6XgNthS9D7L6WgBp/4J/pAHl+AbBdlaNmyrNR6CoyrjeVk7/ELHeURAi6Kg6wJ9hXNuVwcGg/e2OVFriXe2IhoFxQzwzz9wD+zP7bS0m3RCGbOdTpbRQyQtG/KZTYw4o3QARik7oTtQ030baCdiqH7LiogjVE6ZT1Xk7I+b3ly0dERplNiv/NqYEgCmi1waNrlTpnf6BFpIS0Ba/mSazEbvlM8XbK4GKzzH2Ba95
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(18002099003)(22082099003)(56012099006)(6133799003)(4143699003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXljbFhvSXh4ZG85NSszZHZvN0s5b3c0RHVEVkE2ZXVabkFncHJ3YlE5aGov?=
 =?utf-8?B?Y3UrRUdaT0RpRzBUTXhoTCtDcVYxUGI3cVNTVHUraW9pQU5ucUltWFhvbmpn?=
 =?utf-8?B?MHpCOWVmbHlESFhLdGthdnBrQ1BXVUJLOXJ5RGs5WkdNVDc3Y3hpbkYvdUVh?=
 =?utf-8?B?Qm55TE1lRFo0Y3p0a2hRbzFxOE9pbFdQQjBwNUt4Wm8vUG9PSWVzUTNva0gw?=
 =?utf-8?B?RG5GRzZBSVJaZkhBU25UMnlpaXVkalZvd2lLaWdFaWZTSHdBS25jV2tFY1Y1?=
 =?utf-8?B?Q3dodlJaMnN4dzh2anp1S2IxVXpCdTFaL2Z5eHJVUHdCSE5xWDE0bmd4MUU4?=
 =?utf-8?B?eGVVWUQwNzN6OEMyOEVQdllDUEhWenF6VW42T0ZaV0VTMnk3TTBTVWthZlBm?=
 =?utf-8?B?UklDZHk4eGEwZnNwWnBBQkFxMFFtM3Vac2ttUkdlYmxKdFpsNERpTHQyeFBs?=
 =?utf-8?B?czNXbVRoWHlEc1phVGFtV3Y0Qm5GZXowdXNIZDdhb1VBYzhHaGtZWWQ2NXpj?=
 =?utf-8?B?RFBGS0QxRVRYZEhzc0l3b1BIdWljQ0xJOGdRbXN2SW9kcy80WHp3UWtFTHRk?=
 =?utf-8?B?YWIwdFYxQkNoOU16VFF2Yll6SjZjcCtzR2ZnV1NDODRRc0ZHd2M1b2twY3Zm?=
 =?utf-8?B?WHJiM09iN1N1Z3NNOWFONUwyUzlUMnh4b1hnUWtKV0E3bHRRZ1QzMCtucmJS?=
 =?utf-8?B?MlRkVXA2UkFPY1NSa0pBUW9Jc1grRXNreXVZSUxic0FVNGE1R2ZyQkFuVlhy?=
 =?utf-8?B?ckhsMmRTUW9YNHI0Q1NBVlEzZnN0Zlk2L0pjTldKSDVzT3FoZ1FJME5PNE1n?=
 =?utf-8?B?bzdBd1diQlNUaWxKSGZwWHcvd08vTlYyUWRiYWRwY21Na2t0ZmlWbXlSUFFO?=
 =?utf-8?B?a1gvY3c3eWx3Y09nNGdBd285bTR1SExsL1Vrd3hwWk1LS1ZqVlJzenZKd3N6?=
 =?utf-8?B?RUpCNDRPUEdMMENJN2FlWHdpQXdhN1QxRVhCMndJNnZoeWdadUJsYnp5d2lG?=
 =?utf-8?B?ZjU2T2RKS1FOclEvSXNOVjArVXRLTkU1eTVtemJRaHJKeUhFZVk2Rms5aXdF?=
 =?utf-8?B?azVWbjhDaGI3UGwvS2VkY3dRUmpGaGRRSnY5Q3B6NWxtRUxxQnBtWU56Zm1P?=
 =?utf-8?B?RFFMbW9ydmlOTmMrbzVHVnhjeWdyVzhhZXVIOWUveDJUNzhFN3dGbTltRmJJ?=
 =?utf-8?B?cTVTOTVQMUc2RnBhWDNISTVQeXg1d2EybGpQdUtYd2M3bm1mbXdwdkkvZlZT?=
 =?utf-8?B?T2NvL2V5M3V6Z3NMRFY3MjI4OVlkdHJCZWI1OEtid2JCeko0N0FTMVV3TXFx?=
 =?utf-8?B?cVVVSkxkNWFGSzVkR0taM252UkRHck9Ua2VST3J6WWNaUW14emZpTGxKZlRN?=
 =?utf-8?B?L3VmcVBudk1kbzZ3RkRBdlIwRU44bFFRU09JUU1ad1ppZE03Y3gwK0t3N1dB?=
 =?utf-8?B?WnVqRmp2WW9HSkRKMEcvQzNWSGtwWHdzWE9QSnM1NlAyWWJTWlJvaGxhVGtH?=
 =?utf-8?B?NEg1MHZQRktuMWRrd3FBU2dwc1UwT3JRc1ExNkQ2dWIzay91NU9HeVFCbzB1?=
 =?utf-8?B?MzZkcEVlVXloWnZjR0ViUml1bUN1ZDFtTnNNWEFBTkh1WkRTUzFoS3U5djVD?=
 =?utf-8?B?V1VsZy91WmwwZ01MTitWYkFZNTI0bjVXMjBhTXBMeE5LbnMrOWdyOURHTHFk?=
 =?utf-8?B?QVU0M0tpbVVsUk9VUGE0R3ZJM3RzcUl6SlFlaE1XQlI1WXdra21MUCtWcmI1?=
 =?utf-8?B?NTNJejdZVDJSZTg2UlhQa285WHF2RHUzSEMrQlJWcDhVNldkVUQ2N2ZGK1ND?=
 =?utf-8?B?bU84Q0IrUThwK2FNRFhYSVBtOVRqOFFhcU9Wd1BRNnBMUHNHTHlQcTQ5SWhn?=
 =?utf-8?B?V3pnVmcwc0xTckdPQkJ0KzdUdmxyZmJFTDRLaWxzL2J2cEt1blh5ci9BZUxP?=
 =?utf-8?B?ZktZK0trdk0xbWdVQjJiTGNlRUdRRTVtRU9VQnFZV1k3S0d4alQreEtRRkFO?=
 =?utf-8?B?NUhzZXh1djZ2c0NrdmR6YjNvcW9qSzg1QVZLeEx0Tjd3VllucUZtaGdIMlQ0?=
 =?utf-8?B?S2RFbTBGenFtVUk0Uk5JWlBnZlFib2UxWUhBdFAzbDdwemNVTjV3TlBrTnh3?=
 =?utf-8?B?T0NDWUdjSTJRZVJzb0N1L29KMlZnRm5HeTFOTURDTnlrVTNBV2p6b0I4RzFK?=
 =?utf-8?B?c0NxL0FtYmxrejRId0FsTGR5THBJWFJKV1FsNWRlSVQ1TjN1TGhYSDhqUWZp?=
 =?utf-8?B?ZXpSeTlmeGJpc2RZbHZ0NjBMUmpyVUJZQkdOenFKTWhzcmpRQWJQUW9OZVAw?=
 =?utf-8?B?UW5lWkEwdkYvZTBZQXV6WmZWNUUwVTY1dzAvbzdqWnRoekoxd0NzUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZDsbltZmxxQGXNKQE6g/YlriN8xjKx5YaaSpXZNmHmRtiBeqeIJpnT32Ew1PPAwuCG6NHjEteWnO9IXbwseeGWFm1456Ndiimm/H7l10MRky9klRWOd3jOPZo0dg6wqW9itY3GqoNqKLHMOMrqTdgMYPZO+VqERpxkTOlcXByoqVnaAbXZrNM09uJmpJ02GXqFsxiweQjNUJVxDOL4z/dT25dpaFRwES+7qsA2VH4bCvkVXi0AYwKvfLtJEP4jXLbSLGv4OWXiWpDUGrl8AkI8+5VMVBBoZKLFR1NZwWvCRWK6fR0LTCrKEJx79ANVq4CjwGr5JcP0tN7f46n+Wocw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c127dfe0-b5d8-43dc-0942-08dec05245e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 02:54:32.5551 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DmO4sKPueJuqSdgluouQaz9bq5pMPsPnGZgaiFMw7Y0NLUwmVwDebALhXHHq6XkbhFm/A2/E2e4fX/ADA2ayk+QkZcIgD649IWWTNf93OUs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI4PR06MB8373
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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
U3ViamVjdDogUmU6IFtQQVRDSCB2MSAwMi8xMF0gaHcvaTJjL2FzcGVlZF9pMmM6IEluY3JlYXNl
IEFTVDI3MDAgYnVmZmVyDQo+IG1vZGUgc2l6ZSBhbmQgYWRqdXN0IG9mZnNldA0KPiANCj4gT24g
NS8yOS8yNiAwODo0MiwgSmFtaW4gTGluIHdyb3RlOg0KPiA+IFVwZGF0ZSB0aGUgQVNUMjcwMCBJ
MkMgYnVmZmVyIG1vZGUgY29uZmlndXJhdGlvbiB0byBtYXRjaCB0aGUgbGF0ZXN0DQo+ID4gZmly
bXdhcmUgZGVmaW5pdGlvbjoNCj4gDQo+IEZpcm13YXJlIG9yIEhhcmR3YXJlID8NCj4NCg0KSXQg
aXMgaGFyZHdhcmUtZGVmaW5lZC4gVGhlIEFTVDI3MDAgSTJDIGNvbnRyb2xsZXIgYnVmZmVyIHNp
emUgaXMgMHg0MCBieXRlcywgYW5kIHRoZSBidWZmZXIgc3RhcnRzIGF0IG9mZnNldCAweEMwIHdp
dGhpbiBlYWNoIEkyQyBkZXZpY2UgcmVnaXN0ZXIgc3BhY2UuDQpXZSB3aWxsIHVwZGF0ZSB0aGUg
QVNUMjcwMCBkYXRhc2hlZXQgdG8gZG9jdW1lbnQgdGhlIGJ1ZmZlciBtb2RlIGNvbmZpZ3VyYXRp
b24uDQpEbyBJIG5lZWQgdG8gYWRkIHRoZSBmaXgtdGFnPw0KDQo+ID4gLSBJbmNyZWFzZSBidWZm
ZXIgbW9kZSBwb29sIHNpemUgZnJvbSAweDIwIHRvIDB4NDANCj4gPiAtIEFkanVzdCBidWZmZXIg
bW9kZSBiYXNlIG9mZnNldCB0byAweDFjMA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmFtaW4g
TGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+DQo+ID4gLS0tDQo+ID4gICBpbmNsdWRlL2h3
L2kyYy9hc3BlZWRfaTJjLmggfCAgMiArLQ0KPiA+ICAgaHcvaTJjL2FzcGVlZF9pMmMuYyAgICAg
ICAgIHwgMzggKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICAgMiBm
aWxlcyBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCAyMCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+
IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2kyYy9hc3BlZWRfaTJjLmggYi9pbmNsdWRlL2h3L2ky
Yy9hc3BlZWRfaTJjLmgNCj4gPiBpbmRleCAxZmMyMjlmNjk5Li5iMmU0ZDJmYjlkIDEwMDY0NA0K
PiA+IC0tLSBhL2luY2x1ZGUvaHcvaTJjL2FzcGVlZF9pMmMuaA0KPiA+ICsrKyBiL2luY2x1ZGUv
aHcvaTJjL2FzcGVlZF9pMmMuaA0KPiA+IEBAIC0zNSw3ICszNSw3IEBAIE9CSkVDVF9ERUNMQVJF
X1RZUEUoQXNwZWVkSTJDU3RhdGUsDQo+IEFzcGVlZEkyQ0NsYXNzLA0KPiA+IEFTUEVFRF9JMkMp
DQo+ID4NCj4gPiAgICNkZWZpbmUgQVNQRUVEX0kyQ19OUl9CVVNTRVMgMTYNCj4gPiAgICNkZWZp
bmUgQVNQRUVEX0kyQ19TSEFSRV9QT09MX1NJWkUgMHg4MDAgLSNkZWZpbmUNCj4gPiBBU1BFRURf
STJDX0JVU19QT09MX1NJWkUgMHgyMA0KPiA+ICsjZGVmaW5lIEFTUEVFRF9JMkNfQlVTX1BPT0xf
U0laRSAweDQwDQo+IA0KPiBUaGlzIGNoYW5nZSBoYXMgYW4gaW1wYWN0IG9uIHRoZSB2bXN0YXRl
Lg0KPiANCg0KSSB3aWxsIGJ1bXAgdGhlIFZNU3RhdGUgdmVyc2lvbiBpbiAiYXNwZWVkX2kyY19i
dXNfdm1zdGF0ZSIgYW5kICJhc3BlZWRfaTJjX2J1c192bXN0YXRlIiBhY2NvcmRpbmdseS4NCg0K
VGhhbmtzLUphbWluDQoNCj4gVGhhbmtzLA0KPiANCj4gQy4NCj4gDQo+IA0KPiA+ICAgI2RlZmlu
ZSBBU1BFRURfSTJDX05FV19OVU1fUkVHICgweGEwID4+IDIpDQo+ID4NCj4gPiAgICNkZWZpbmUg
QV9JMkNEX01fU1RPUF9DTUQgICAgICAgQklUKDUpDQo+ID4gZGlmZiAtLWdpdCBhL2h3L2kyYy9h
c3BlZWRfaTJjLmMgYi9ody9pMmMvYXNwZWVkX2kyYy5jIGluZGV4DQo+ID4gOWMwMzg3YTM5NC4u
NWJlNmZlZmM0ZCAxMDA2NDQNCj4gPiAtLS0gYS9ody9pMmMvYXNwZWVkX2kyYy5jDQo+ID4gKysr
IGIvaHcvaTJjL2FzcGVlZF9pMmMuYw0KPiA+IEBAIC0xMjUwLDM3ICsxMjUwLDM3IEBAIHN0YXRp
YyB2b2lkIGFzcGVlZF9pMmNfaW5zdGFuY2VfaW5pdChPYmplY3QNCj4gKm9iaikNCj4gPiAgICAq
IEFkZHJlc3MgRGVmaW5pdGlvbnMgKEFTVDI3MDApDQo+ID4gICAgKiAgIDB4MDAwIC4uLiAweDBG
RjogR2xvYmFsIFJlZ2lzdGVyDQo+ID4gICAgKiAgIDB4MTAwIC4uLiAweDE5RjogRGV2aWNlIDAN
Cj4gPiAtICogICAweDFBMCAuLi4gMHgxQkY6IERldmljZSAwIGJ1ZmZlcg0KPiA+ICsgKiAgIDB4
MUMwIC4uLiAweDFGRjogRGV2aWNlIDAgYnVmZmVyDQo+ID4gICAgKiAgIDB4MjAwIC4uLiAweDI5
RjogRGV2aWNlIDENCj4gPiAtICogICAweDJBMCAuLi4gMHgyQkY6IERldmljZSAxIGJ1ZmZlcg0K
PiA+ICsgKiAgIDB4MkMwIC4uLiAweDJGRjogRGV2aWNlIDEgYnVmZmVyDQo+ID4gICAgKiAgIDB4
MzAwIC4uLiAweDM5RjogRGV2aWNlIDINCj4gPiAtICogICAweDNBMCAuLi4gMHgzQkY6IERldmlj
ZSAyIGJ1ZmZlcg0KPiA+ICsgKiAgIDB4M0MwIC4uLiAweDNGRjogRGV2aWNlIDIgYnVmZmVyDQo+
ID4gICAgKiAgIDB4NDAwIC4uLiAweDQ5RjogRGV2aWNlIDMNCj4gPiAtICogICAweDRBMCAuLi4g
MHg0QkY6IERldmljZSAzIGJ1ZmZlcg0KPiA+ICsgKiAgIDB4NEMwIC4uLiAweDRGRjogRGV2aWNl
IDMgYnVmZmVyDQo+ID4gICAgKiAgIDB4NTAwIC4uLiAweDU5RjogRGV2aWNlIDQNCj4gPiAtICog
ICAweDVBMCAuLi4gMHg1QkY6IERldmljZSA0IGJ1ZmZlcg0KPiA+ICsgKiAgIDB4NUMwIC4uLiAw
eDVGRjogRGV2aWNlIDQgYnVmZmVyDQo+ID4gICAgKiAgIDB4NjAwIC4uLiAweDY5RjogRGV2aWNl
IDUNCj4gPiAtICogICAweDZBMCAuLi4gMHg2QkY6IERldmljZSA1IGJ1ZmZlcg0KPiA+ICsgKiAg
IDB4NkMwIC4uLiAweDZGRjogRGV2aWNlIDUgYnVmZmVyDQo+ID4gICAgKiAgIDB4NzAwIC4uLiAw
eDc5RjogRGV2aWNlIDYNCj4gPiAtICogICAweDdBMCAuLi4gMHg3QkY6IERldmljZSA2IGJ1ZmZl
cg0KPiA+ICsgKiAgIDB4N0MwIC4uLiAweDdGRjogRGV2aWNlIDYgYnVmZmVyDQo+ID4gICAgKiAg
IDB4ODAwIC4uLiAweDg5RjogRGV2aWNlIDcNCj4gPiAtICogICAweDhBMCAuLi4gMHg4QkY6IERl
dmljZSA3IGJ1ZmZlcg0KPiA+ICsgKiAgIDB4OEMwIC4uLiAweDhGRjogRGV2aWNlIDcgYnVmZmVy
DQo+ID4gICAgKiAgIDB4OTAwIC4uLiAweDk5RjogRGV2aWNlIDgNCj4gPiAtICogICAweDlBMCAu
Li4gMHg5QkY6IERldmljZSA4IGJ1ZmZlcg0KPiA+ICsgKiAgIDB4OUMwIC4uLiAweDlGRjogRGV2
aWNlIDggYnVmZmVyDQo+ID4gICAgKiAgIDB4QTAwIC4uLiAweEE5RjogRGV2aWNlIDkNCj4gPiAt
ICogICAweEFBMCAuLi4gMHhBQkY6IERldmljZSA5IGJ1ZmZlcg0KPiA+ICsgKiAgIDB4QUMwIC4u
LiAweEFGRjogRGV2aWNlIDkgYnVmZmVyDQo+ID4gICAgKiAgIDB4QjAwIC4uLiAweEI5RjogRGV2
aWNlIDEwDQo+ID4gLSAqICAgMHhCQTAgLi4uIDB4QkJGOiBEZXZpY2UgMTAgYnVmZmVyDQo+ID4g
KyAqICAgMHhCQzAgLi4uIDB4QkZGOiBEZXZpY2UgMTAgYnVmZmVyDQo+ID4gICAgKiAgIDB4QzAw
IC4uLiAweEM5RjogRGV2aWNlIDExDQo+ID4gLSAqICAgMHhDQTAgLi4uIDB4Q0JGOiBEZXZpY2Ug
MTEgYnVmZmVyDQo+ID4gKyAqICAgMHhDQzAgLi4uIDB4Q0ZGOiBEZXZpY2UgMTEgYnVmZmVyDQo+
ID4gICAgKiAgIDB4RDAwIC4uLiAweEQ5RjogRGV2aWNlIDEyDQo+ID4gLSAqICAgMHhEQTAgLi4u
IDB4REJGOiBEZXZpY2UgMTIgYnVmZmVyDQo+ID4gKyAqICAgMHhEQzAgLi4uIDB4REZGOiBEZXZp
Y2UgMTIgYnVmZmVyDQo+ID4gICAgKiAgIDB4RTAwIC4uLiAweEU5RjogRGV2aWNlIDEzDQo+ID4g
LSAqICAgMHhFQTAgLi4uIDB4RUJGOiBEZXZpY2UgMTMgYnVmZmVyDQo+ID4gKyAqICAgMHhFQzAg
Li4uIDB4RUZGOiBEZXZpY2UgMTMgYnVmZmVyDQo+ID4gICAgKiAgIDB4RjAwIC4uLiAweEY5Rjog
RGV2aWNlIDE0DQo+ID4gLSAqICAgMHhGQTAgLi4uIDB4RkJGOiBEZXZpY2UgMTQgYnVmZmVyDQo+
ID4gKyAqICAgMHhGQzAgLi4uIDB4RkZGOiBEZXZpY2UgMTQgYnVmZmVyDQo+ID4gICAgKiAgIDB4
MTAwMCAuLi4gMHgxMDlGOiBEZXZpY2UgMTUNCj4gPiAtICogICAweDEwQTAgLi4uIDB4MTBCRjog
RGV2aWNlIDE1IGJ1ZmZlcg0KPiA+ICsgKiAgIDB4MTBDMCAuLi4gMHgxMEJGOiBEZXZpY2UgMTUg
YnVmZmVyDQo+ID4gICAgKi8NCj4gPiAgIHN0YXRpYyB2b2lkIGFzcGVlZF9pMmNfcmVhbGl6ZShE
ZXZpY2VTdGF0ZSAqZGV2LCBFcnJvciAqKmVycnApDQo+ID4gICB7DQo+ID4gQEAgLTE3MTQsOSAr
MTcxNCw5IEBAIHN0YXRpYyB2b2lkDQo+IGFzcGVlZF8yNzAwX2kyY19jbGFzc19pbml0KE9iamVj
dENsYXNzICprbGFzcywgY29uc3Qgdm9pZCAqZGF0YSkNCj4gPiAgICAgICBhaWMtPnJlZ19nYXBf
c2l6ZSA9IDB4NjA7DQo+ID4gICAgICAgYWljLT5nYXAgPSAtMTsgLyogbm8gZ2FwICovDQo+ID4g
ICAgICAgYWljLT5idXNfZ2V0X2lycSA9IGFzcGVlZF8yNjAwX2kyY19idXNfZ2V0X2lycTsNCj4g
PiAtICAgIGFpYy0+cG9vbF9zaXplID0gMHgyMDsNCj4gPiAtICAgIGFpYy0+cG9vbF9nYXBfc2l6
ZSA9IDB4ZTA7DQo+ID4gLSAgICBhaWMtPnBvb2xfYmFzZSA9IDB4MWEwOw0KPiA+ICsgICAgYWlj
LT5wb29sX3NpemUgPSAweDQwOw0KPiA+ICsgICAgYWljLT5wb29sX2dhcF9zaXplID0gMHhjMDsN
Cj4gPiArICAgIGFpYy0+cG9vbF9iYXNlID0gMHgxYzA7DQo+ID4gICAgICAgYWljLT5idXNfcG9v
bF9iYXNlID0gYXNwZWVkXzI1MDBfaTJjX2J1c19wb29sX2Jhc2U7DQo+ID4gICAgICAgYWljLT5o
YXNfZG1hID0gdHJ1ZTsNCj4gPiAgICAgICBhaWMtPm1lbV9zaXplID0gMHgyMDAwOw0KDQo=

