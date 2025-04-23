Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5522C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 07:03:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7U8H-0005g7-5Z; Wed, 23 Apr 2025 03:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u7U88-0005fh-T9; Wed, 23 Apr 2025 03:02:48 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u7U81-0006og-Vf; Wed, 23 Apr 2025 03:02:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HDfd40cZdZvYyiUhiNyb201YoJv9Z/WlJFdLNuawmPeskGAPXZuyff+IwZFfrkZmXfU9w+0nX0Wcd3LVnE7jVCQtXOdd7UHu5iTkSuLOhwxfxqfmeHihfGhfOVPdlOk78hXB1y0/g5r+lx4Ssqfk9ar3/tqJNW0qSmHzhcDkm+8+ryJw0v+i7OlBMUXKiRrNxvUuazN7C3dvwnNkMGloMi3FJUmWG8aAMJWa/BjetTuj+WSFO02HXBW5Acq+QdoSXmJY7er4/sEE0wTO+q6AXWWcuOuWDyGHwS1/cUprv42lqSbjHUrSRu2H4ygxb1uMUJOuNPmCxp6ijKY0GLbIKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JerE4ngRfnSib7niQ6RjR0vvKjTosRhYZYobKWgX1bo=;
 b=Y7unAg3AOwwTMXxCL2cc/Y4BMZcE1pzq0smBdXnS9J1h+bYyiT2Mk+q5Xnf49e17HOKBWGHPrGYs5kSN6eTHc+huXcFZvBJnOxm4XPJ/h9YONa8Z75IE0dbe+i/cyHU8UECHyCUBkcY+v5/d6ZSeyO+eAFcSov0QGRW0nBx1nKO8PiqpFQ9SHFwCw1jVxtsUz81ftBpA0zedVdipMSUF4aTK4Mj7risg2vaKjPOe5I4A1/Aa9rc9LzZkMoD18IzjE+63H0gk0m22YJbg8X/eft5+ePk+6qBqHuOuvOdw70EK4aSfzBODt/341P6vIt9wW1vPNgauItUoZzDgMckq4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JerE4ngRfnSib7niQ6RjR0vvKjTosRhYZYobKWgX1bo=;
 b=VmXDaKPA+KDdjb+S41ckm4UR3lkPXjB0feNaso/aacBX+tfw6FVam7Ydyvnd2JdkB2UuhySyUE5xNpynEps1+YwCqCjFs4Xe1XfO2BbpCsWks880+Prjzkxx5gt31zGv8WUTYgYDBTAExnFj/RWSHOvPowV1ujMMZ98I4OVWaNFbXgbRWSXYZimctyMKBO/K0WyU0hw7eOiklK8da6/6pVUl4bZHMdCwzxWem/gjG6UwnBuSOcBv8SqVsu8xP6HSzwvpIDPIzEOkh/au0dfGR/T67HS/hHEx5NmLcF46iV0lv7OH9bKYcUaa8vw2tV9jfxmXYrUKQuZHEf4ZXqrAKQ==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SEZPR06MB7237.apcprd06.prod.outlook.com (2603:1096:101:238::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Wed, 23 Apr
 2025 07:02:30 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.8655.033; Wed, 23 Apr 2025
 07:02:29 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: RE: [PATCH v4 06/10] hw/arm/aspeed: Add support for loading vbootrom
 image via "-bios"
Thread-Topic: [PATCH v4 06/10] hw/arm/aspeed: Add support for loading vbootrom
 image via "-bios"
Thread-Index: AQHbr0arWgH+5S4p6UW9XfH4aQxehLOuolcAgABZe1CAAPNLAIAA6amQ
Date: Wed, 23 Apr 2025 07:02:29 +0000
Message-ID: <SI2PR06MB5041756942DE834177DFF573FCBA2@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250417031209.2647703-1-jamin_lin@aspeedtech.com>
 <20250417031209.2647703-7-jamin_lin@aspeedtech.com>
 <85a2947e-6909-4311-8b58-f9eb8045e76c@kaod.org>
 <SI2PR06MB5041D4AD25381C7D1D6A5C1CFCBB2@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <a4c178b6-7048-42d1-9e90-58ed87baf9b5@kaod.org>
In-Reply-To: <a4c178b6-7048-42d1-9e90-58ed87baf9b5@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SEZPR06MB7237:EE_
x-ms-office365-filtering-correlation-id: 9a062e3e-059e-435e-6db7-08dd8234d02a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TWVYS1NZSkFsckR2bTRSVWpZWkN6b2VOaSt3Q0wxbWxDK0l1TUhsR0grUVcr?=
 =?utf-8?B?TVpLNm9vVUpHRVIxbENuUm4rajVTUlVrSlFVYWp2UVFBT29FWGVHSkMxL09T?=
 =?utf-8?B?TGpMTmVDazA5S0ZOMkYwbXNBSklITjdXWmRnMkEwbnZDVkt1elNoZEIzMXJ6?=
 =?utf-8?B?aGZzTFRVekVpalFhc0dRTnlpcjJjTFdkT0s1b055ZDZxV1BLdGh5eWNEZHAr?=
 =?utf-8?B?RVRBYU9pRk1CQTY3VjhjaXk4eXZxRW9MNkFoOW5WNmM4RkVra2FvUmdBOGpU?=
 =?utf-8?B?MXVYUVh3UnZqdGdUbTArT3ZXZ3hOT3ZmVy9YTHFqdXRTajc2NVVPUTZERVBI?=
 =?utf-8?B?Z3NwN1N2NVZjdGhpa2xXRzd3OWJFaTF2SlJ3dm5xRUxwV2syWU9SSVA5dlZW?=
 =?utf-8?B?WXZneXBxZ0dRTWdnNjRFdC92Y0haeWJKUnJoVXJtT3h3K3ZzaUV1ald1QVBm?=
 =?utf-8?B?SWR5NE1NMFBaT1lyMEJkWThiTHV1WXJONTlObUtESkZTNERON3lOQnIrbktV?=
 =?utf-8?B?K1BtL2JodlZFREFFUXFWTU9MUXlMYit6cjBLK3RhZ25GUWxKa01xZHV4dHRR?=
 =?utf-8?B?S2pJVHVXeTNrdmRaaTYzQlpTUE51UEhzU09BdjJ6UHViUm9sNlJveXV6RzNr?=
 =?utf-8?B?bVNQQm5yb2VxaWZyREVoTFVsckVzZGQ0NnRKRUhFYUtqMDFZUUtvTktlMWhZ?=
 =?utf-8?B?UGJoK2U0bFM3aUJaZk43aTF1dnh6aGl5TWtMaUI1NWk3Wm0zdEY1UHp1bkcy?=
 =?utf-8?B?dlFLK0l4ZHVoUVlHSXFtZTBkdGtOZ01GRzBRaEJxaXlnS1B0QjVDY2hqK1R2?=
 =?utf-8?B?djYzWkVIOTlSTnFyR1lDRTZMWVlrbmFJanUxQ0syaTlmTE5GWjFDdmRXNld1?=
 =?utf-8?B?WDlEVmFWcW02MjVRV1JRbHM1aGpEVG9tclpJQWhqVzhQclB4ZkNzWG1iVzEy?=
 =?utf-8?B?cXdyMjE3SjIvbzdsUVNucXh0VlhoZlNXNEQwUFVlRWUrU3puY1FEREh0Myt6?=
 =?utf-8?B?QVo1M2cwU3piU2RIN2R1QlhDcUFpd09HaW8yY2pvdjBySHV2OC9EckhtTC9R?=
 =?utf-8?B?M0tROFVsT252aHhTTFg3OWxPVWU1SExXNDhQeW03aEl3dmNwMWNReXl6Qy9W?=
 =?utf-8?B?TjVBekg3dE8yMXpCWWc5NDBwb1BZSldTaWk0bWMzazFXSE1UUDF6SUJhNUZG?=
 =?utf-8?B?dFczbU1TdXdTc05aWTQyYWxjdjVYcVJjcE9CZzdvLzhSQlJhVFhQeWZ4Q2NV?=
 =?utf-8?B?Yk1zZjJDOUpGdWlUV1BRc1lOak4zNmE2WFlNN3V3L1RWS2djUjFFTXNiQ0dZ?=
 =?utf-8?B?bklTZmNsNVYxd0J1VnVPcW8xaWVzRnFaa1JHUzRmbmR1R2liUjBaMjlUbzNN?=
 =?utf-8?B?dFV1dWQ3T0xQVldyV3JEK0VidlozeWJFWjVqRXExQUhGQlU3R2F1SXJSU1pY?=
 =?utf-8?B?VVlDQ1ZYZ2NxWVRRZWRNWTJRTENGeWNGTEdCYm50dkNwbHNLRTlhUm5ydFBH?=
 =?utf-8?B?a2tyQzVBUHRGWEZjdUh4TEt5bFduOWxsUnpJTEkrTEJzL0pTaVRQM0ZFM0hW?=
 =?utf-8?B?WTNJUDNEcERLclNOSXNXQmlhK2lPWVkvdk41NDBEQktUT0haWGViOXMyNno3?=
 =?utf-8?B?TENkdjFVZ1ZrVDNMS2YvRXE0dkQ3cFNwYzk3Zk1idUw1Y3ZFeTU3M0lZUm5V?=
 =?utf-8?B?OWJSbC9Udmk0V25mTHV5YnNQVTJNTTZNRHNyWkduZllKK1ZNZm1qaWU5Wm1G?=
 =?utf-8?B?MVRqZy83ZDRRUU1rZ00zUkZJZFExZjQ3Q0FpNm1zTGZxTGJsQ3dVMVFSQUdF?=
 =?utf-8?B?eTBVVzVOQVlpdXNHK2tlSW1ETUJVeFRxVEhuK3V5bGZzdjlBR3ljUy93UmVD?=
 =?utf-8?B?V1N0WHlFYUZjQlJrWXNnK3FVUzFhYmRnclNvRlFrZWtPN2ZreWU1dGhUUmpM?=
 =?utf-8?Q?Kc9g3wkZCUo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1p2eVNINnJsTTJZL0Q2cHZBZGUraUQ3RVF6a3VLYjNWTnA0MklnS0ZXWkNz?=
 =?utf-8?B?VXVJYTNya3IzWEkrM2lId3kzSlluRkRXNnE4MkJHZ1FOK3RPbnNud0NBaHJN?=
 =?utf-8?B?OHJiUGJaRFlaOTdjMUJtc2M4U2RlRzZzT01ZZXE4WFdYZGRSNDhsdG5Bemo2?=
 =?utf-8?B?a090Z3l6NUZISWdJSU1GdkFSK0I5QWVGT01acUQwVUdlcnltUUhOd3BzOWUv?=
 =?utf-8?B?bmlJdmxwM2tyaWswUlI1d2gvWElVYXBWVFRJNU5YNXQrYnFobExOWXZaR25h?=
 =?utf-8?B?NkYrVmlVUEwva09yM3RCSDZJVmVTdFJlQzUveTh1a1pxUlBhOTgwWGhFbTZZ?=
 =?utf-8?B?M1h2U21UQURwelBvcFFlUGxpbHh6Q1NZK3hFOGIrYXE0d1ljTXNJZHBJVVVn?=
 =?utf-8?B?MHlNZTM3RFZtVmtEc01wWnByenJtNUVwUTY5S3ZRZU5RWUdYNmRMS0l0Ynpv?=
 =?utf-8?B?Wm1hMm5DR0cwTFdXRmVwU3lVUCtXUndFaEk1ZXh3Qi9aWmxIOTVrL2N5MFhh?=
 =?utf-8?B?MU9Qd1d5TU5Tc0VnL1lLMVA2MVdHV3Vhdm9CNHJqZTNvbVVFN1VqM0xmOE94?=
 =?utf-8?B?Z0syOG9ZYjIvRm1sMnQ5ZzBialNvYk5Od3Z0Rm41YjNNS014VDVvaWVsTmVq?=
 =?utf-8?B?VmYwK3ROTUM1MFNyQmJwWmVlNjVzZzdXZ2htcG10MW5XajR3U2hpdi9ZbW4y?=
 =?utf-8?B?R2FzaUc4WXQ3NXFPSGpuUkxJRHU1L1hSSUt0TnBhVW9yTXlsZGI0R1lZZjU0?=
 =?utf-8?B?bmdqdjJLSTB6cTlqWVBxZUpXM0hSTlhsRi9uVUttSEtRZkwxMzZoejUrejVj?=
 =?utf-8?B?OWVBZ005RGU4WEZRMzJlYU9pZExEUjZ2aHYyWUxKdDVQMjlmMDBLL1Z3byt2?=
 =?utf-8?B?em1Ddmk3aEJ2MXRXcDVoUEVYS0h0RkFmNXVzVnp3Y0tqU2RnWHNvMkVRVXBU?=
 =?utf-8?B?QTY2MWFKWEpETlREbGowTlAzQ2VlVmtzcTZYN3dpb2lRdDI4MjR6TjZHK2Qw?=
 =?utf-8?B?SGVYUTEzYXU4WHVjYmNjdFQvWjNuUEJNSmlZeUlDWUFnYmFDZ0NVcUd1Zndw?=
 =?utf-8?B?QmpUVzdPbzZ2Y0VtVHUwemJHSlhOMmtBcmFHWGQ0dE4yekgveEsrZ1cweFUr?=
 =?utf-8?B?VFFJYkZoNVc4b0gzbDdYdWZiTitWZ1dYSkExcVRMTVNSNU1ZN2REeGdYMWhQ?=
 =?utf-8?B?eHpURkZRMzZzbFZVUGdjNFNOUlV4U0FxTFFiUUY2ZnFkS2hJSXltWldiUXlY?=
 =?utf-8?B?ck4wR0J4T0ZsTHI2a1c1MDNWZjcrUEFVNHY2RmhQNXhxR1NhMTZDRTRuQWtS?=
 =?utf-8?B?ZWpMelF4Zk1NRWdrTmVXQ2VUZ1lxejBpMGxMY2xLcDhJTlIxVmhNWWo2b0ha?=
 =?utf-8?B?ckM1UThzelh1KzdBSTdxV3ZLeXlXVjdicEdNZ0phN0ZSNzV6MmY3MVhTM1Uz?=
 =?utf-8?B?dStVeVJlN3BNczVuN2EwRUVKY1cvUEgwUFR4OXVWYzFuUUhZQnJOR281dS9V?=
 =?utf-8?B?NE9UdXlvM25STGZsUGFmdTZxYk0yS1NHekg4Y0RoUHdCM2ltNXRWZ3ZhcmdE?=
 =?utf-8?B?Rk56aXhQNmFSdjdaNVZLakFHRytCVWR4ODdBdE1KUVlhZVkyKzJWaEdnVXdp?=
 =?utf-8?B?SEdHMThjWUVwaFRYcTJzTkFUUGhFbjVyZkZuNmdMQU9Rak9GY2RiWUx6c0c3?=
 =?utf-8?B?bVBpNWJGeDZYZ3IveDVibmpDVmZXV0tObU9PUHV4K25MUHg2bkN3eHJOM2Ex?=
 =?utf-8?B?b1QxUCtoUDFnbWJieER1Vklic0FIQkYwcUZYckhwcHpHTFR5TmlvYTFxbnNZ?=
 =?utf-8?B?OFdydi9TaTNZZzk1MEttRzFRYWlQQW5nUjVXbDY1a3hYTGJkWWFteXBtMEtN?=
 =?utf-8?B?KzVRT2FXYzg5MW1mVUl3S0IyUzRQdDR2Q0xsaS96TFIyYVFRRmZTczduTVRH?=
 =?utf-8?B?S3hLaWM3ZzVXcWdsbHJJQlorbEVkMnlnYXQ2Q2RsSEo2eVJQTHVYZ0dJbzVo?=
 =?utf-8?B?dWtBMXlZNGJtTVhOelIwckZLamlJYjZuMHBkcnJvUTFndHFubWdZdXQ0NVJR?=
 =?utf-8?B?eUVNR0pOUktyb2VmS0o5VjVXNkJrOGNWKy9pN1JHMUthcHNlN3crMFlma0RK?=
 =?utf-8?Q?vtBsenrKz0NDdSoL0k8syRmGU?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a062e3e-059e-435e-6db7-08dd8234d02a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2025 07:02:29.8427 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H6pY6Ij4Juy43CS09dXx5b6Lpi/zU7Usyp8k5vzJCkjhWzZcvNWMc1j21zHwweWDQMvXJHiMRlhayQqPhr+R+MQPblm2UDZ+6RZn2T+BJoE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7237
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

SGkgQ2VkcmljLA0KDQo+IENjOiBUcm95IExlZSA8dHJveV9sZWVAYXNwZWVkdGVjaC5jb20+OyBu
YWJpaGVzdGVmYW5AZ29vZ2xlLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDA2LzEwXSBo
dy9hcm0vYXNwZWVkOiBBZGQgc3VwcG9ydCBmb3IgbG9hZGluZw0KPiB2Ym9vdHJvbSBpbWFnZSB2
aWEgIi1iaW9zIg0KPiANCj4gSGVsbG8gSmFtaW4sDQo+IA0KPiA+IEJhc2VkIG9uIHRoZSBkZXNp
Z24gb2YgYXNwZWVkX2luc3RhbGxfYm9vdF9yb20sIHVzZXJzIGNhbiBwbGFjZSB0aGVpcg0KPiA+
IFJPTSBjb2RlIGF0IHRoZSB0b3Agb2YgdGhlIGltYWdlLWJtYywgYW5kIHRoaXMgZnVuY3Rpb24g
d2lsbCBpbnN0YWxsDQo+ID4gaW1hZ2UtYm1jIHdoaWNoIGluY2x1ZGVkIHRoZSB1c2VyJ3MgUk9N
IElNQUdFIGF0IHRoZQ0KPiA+IEFTUEVFRF9ERVZfU1BJX0JPT1QgYWRkcmVzcy4gIEZvciBBU1Qy
NjAwLCB1c2VycyB0eXBpY2FsbHkgc2V0IHRoZQ0KPiA+IGJvb3QgYWRkcmVzcyB0byAweDAgYW5k
IGJvb3QgZGlyZWN0bHkgZnJvbSB0aGVyZS4NCj4gPg0KPiA+IEZvciBBU1QyNzAwLCB3ZSBpbnRy
b2R1Y2VkIGEgdmJvb3Ryb20gdG8gc2ltdWxhdGUgdGhlIFJPTSBjb2RlIGFuZCB0aGUNCj4gPiBC
T09UTUNVIFNQTCAoUklTQy1WKS4NCj4gDQo+IFNpZGUgcXVlc3Rpb24sIGlzIGFueW9uZSB3b3Jr
aW5nIG9uIHRoZSBCT09UTUNVIFNQTCAoUklTQy1WKSBtb2RlbHMgPw0KPiBoZXRlcm9nZW5lb3Vz
IG1hY2hpbmVzIHNob3VsZCBiZSBzdXBwb3J0ZWQgb25lIGRheS4NCj4gDQoNClRyb3kgZGV2ZWxv
cGVkIGFuIGluaXRpYWwgaW1wbGVtZW50YXRpb24sIGJ1dCB0ZXN0aW5nIGhhcyBub3QgeWV0IGJl
ZW4gcGVyZm9ybWVkIGR1ZSB0byB1bmNlcnRhaW50eSBhcm91bmQNCiJob3cgdG8gc2hhcmUgRFJB
TSBtZW1vcnkgYW5kIGNvbnRyb2xsZXJzIHJlZ2lzdGVycyIgYmV0d2VlbiB0aGUgUklTQy1WIGFu
ZCB0aGUgQ29ydGV4LUEzNSBjb3Jlcy4NCkZ1cnRoZXJtb3JlLCBSSVNDLVYgaW50ZXJydXB0IHN1
cHBvcnQgaXMgY3VycmVudGx5IG5vdCBpbXBsZW1lbnRlZC4NCg0KPiA+IFdlIHVzZSBhc3BlZWRf
aW5zdGFsbF9ib290X3JvbSB0byBsb2FkIHRoZSBpbWFnZS1ibWMgYXQgdGhlIEZNQyBDUzANCj4g
PiBtZW1vcnktbWFwcGVkIEkvTyBhZGRyZXNzLCBzbyB3ZSBzZXQgQVNQRUVEX0RFVl9TUElfQk9P
VCB0bw0KPiA+IDB4MTAwMDAwMDAwLg0KPiA+DQo+ID4gV2UgbG9hZCB0aGUgdmJvb3Ryb20gaW1h
Z2UgaW50byB0aGUgdmJvb3Ryb20gbWVtb3J5IHJlZ2lvbiBhdCBhZGRyZXNzDQo+ID4gMHgwIGFu
ZCBzdGFydCBleGVjdXRpb24gZnJvbSB0aGVyZS4NCj4gPg0KPiA+IFRoZSBndWVzdCBPUyBmaXJz
dCBlbnRlcnMgdGhlIHZib290cm9tLiBGcm9tIHRoZXJlLCBpdCBjYW4gZWFzaWx5DQo+ID4gYWNj
ZXNzIHRoZSBmbGFzaCBkYXRhIChpbWFnZS1ibWMpIGF0IDB4MTAwMDAwMDAwLCBzaW5jZSB2Ym9v
dHJvbQ0KPiA+IGl0c2VsZiBkb2VzbuKAmXQgcmVxdWlyZSBTUEkvZmxhc2gvZW1tYyBob3N0IGRy
aXZlcnMuDQo+ID4NCj4gPiBUbyBzdXBwb3J0IGZ1dHVyZSBlTU1DIGJvb3RpbmcsIHdlIGFsc28g
cGxhbiB0byBpbnN0YWxsIHRoZSBlTU1DIGltYWdlDQo+ID4gYXQgdGhlIEFTUEVFRF9ERVZfU1BJ
X0JPT1QgYWRkcmVzcy4NCj4gPiBodHRwczovL2dpdGh1Yi5jb20vcWVtdS9xZW11L2Jsb2IvbWFz
dGVyL2h3L2FybS9hc3BlZWQuYyNMNDc3DQo+IA0KPiBvay4NCj4gDQo+ID4gSXQgaXMgZnVsbHkg
c3VwcG9ydGVkIHRvIGhhdmUgYm90aCBvcHRpb25zLiBJZiB1c2VycyB3YW50IHRvIGluY2x1ZGUN
Cj4gPiB0aGVpciBvd24gUk9NIGNvZGUgd2l0aGluIGltYWdlLWJtYywgdGhleSBjYW4gc2V0IHRo
ZSBwcm9ncmFtIGNvdW50ZXINCj4gPiAoUEMpIHRvIDB4MTAwMDAwMDAwLCBqdXN0IGxpa2UgaG93
IGEgbWFudWFsIGxvYWRlciBzZXQgaXQgdG8NCj4gPiAweDQzMDAwMDAwIChlLmcuLCB0byBqdW1w
IGRpcmVjdGx5IHRvIEJMMzEpLiAgVGhpcyBhbGxvd3MgdXNlcnMgdG8NCj4gPiBieXBhc3MgdGhl
IHZib290cm9tIGlmIGRlc2lyZWQuDQo+IA0KPiBvay4NCj4gDQo+ID4gSG93ZXZlciwgSSBiZWxp
ZXZlIHRoaXMgdXNlIGNhc2Ugd2lsbCBiZSByYXJlLCBhcyB0aGUgdmJvb3Ryb20gZGVzaWduDQo+
ID4gc2hvdWxkIGJlIGFibGUgdG8gc2F0aXNmeSBtb3N0LCBpZiBub3QgYWxsLCB1c2VyIHJlcXVp
cmVtZW50cy4NCj4gDQo+IFdlIG5lZWQgdG8gYmUgY2FyZWZ1bCBhYm91dCB3aGF0IHdlIG9mZmVy
IHRoZSB1c2VyIGluIHRlcm1zIG9mIGJvb3QgbWV0aG9kLg0KPiBJdCdzIGRpZmZpY3VsdCB0byBt
YWludGFpbiBvbiB0aGUgbG9uZyB0ZXJtLiBMZXQncyByZWNhcC4NCj4gDQoNCkZvciB0aGUgQVNU
MjcwMCwgSSBhbSBjdXJyZW50bHkgY29uc2lkZXJpbmcgc3VwcG9ydCBmb3IgdGhlIGZvbGxvd2lu
ZyBib290IG1ldGhvZHMgb25seToNCg0KMS4gZU1NQyBkZXZpY2UgYm9vdA0KMi4gVUZTIGRldmlj
ZSBib290IChOb3RlOiBRRU1VIGN1cnJlbnRseSBvbmx5IHN1cHBvcnRzIFBDSS1iYXNlZCBVRlMg
YW5kIGRvZXMgbm90IHN1cHBvcnQgcGxhdGZvcm0tYmFzZWQgVUZTLiBUaGlzIHJlbWFpbnMgYSBs
b25nLXRlcm0gZ29hbCkNCjMuIEZpcm13YXJlIGJvb3QgdXNpbmcgdmJvb3Ryb20NCjQuIEZpcm13
YXJlIGJvb3QgdXNpbmcgYSBtYW51YWwgbG9hZGVyDQoNClRoZSBib290IGZsb3cgZm9yIHRoZSBB
U1QyNzAw4oCZcyBDb3J0ZXgtQTM1IHNob3VsZCBmb2xsb3cgdGhpcyBzZXF1ZW5jZToNCkJMMzEg
KFRydXN0ZWQgRmlybXdhcmUtQSkg4oaSIEJMMzIgKE9QLVRFRSBPUykg4oaSIEJMMzMgKFUtQm9v
dCkNCg0KSSBkb24ndCB0aGluayB3ZSBzaG91bGQgc3VwcG9ydCBkaXJlY3Qga2VybmVsIGJvb3Qg
LCBhcyBJIGRvbid0IGtub3cgaG93IHRvIHN0YXJ0IGV4ZWN1dGlvbiBkaXJlY3RseSBmcm9tIHRo
ZSBrZXJuZWwuDQoNCkJ5IHRoZSB3YXksIEFTVDI3MDAgc3VwcG9ydCB0byBib290IGZyb20gZWl0
aGVyIEVNTUMgb3IgVUZTLg0KSSBhbSBjb25zaWRlcmluZyB0byByZWFkIE9UUCBjb25maWdzIGFu
ZCBzdHJhcCBpbnN0ZWFkIG9mIGNvbW1hbmQgbGluZS4NCkV4OiB3ZSB1c2VkIGJvb3RtbWM9dHJ1
ZSB0byBjaGFuZ2UgaGFyZHN0cmFwLiANCkl0IGp1c3QgbXkgYnJpZWZseSBwbGFuZSBhbmQgZnV0
dXJlIGdvYWwuDQoNClRoYW5rcy1KYW1pbg0KPiBGb3IgdGhlIEFTVDJbNDU2XTAwIG1hY2hpbmVz
LCB3ZSBoYXZlIDoNCj4gDQo+ICAgIDEuIGtlcm5lbCBib290DQo+ICAgIDIuIGZsYXNoIGRldmlj
ZSBib290IHdpdGggb3Igd2l0aG91dCAiZXhlY3V0ZS1pbi1wbGFjZSIgbWFjaGluZQ0KPiAgICAg
ICBvcHRpb24NCj4gDQo+IGFuZCB0aGlzIGNvdWxkIHdvcmsgZm9yIEFTVDI3MDAgbWFjaGluZXMg
d2l0aCBzb21lIGxvYWRlciBtYWdpYy4NCj4gSXQgd291bGQgYmUgZ29vZCB0byBkZWNpZGUgdG8g
b3Igbm90IHRvIHN1cHBvcnQgaXQuIElmIG5vdCBzdXBwb3J0ZWQsIGxldCdzIGluZm9ybQ0KPiB0
aGUgdXNlciBhc2FwLg0KPiANCj4gRm9yIHRoZSBBU1QyNjAwIGFzdDI2MDBldmIgYW5kIHJhaW5p
ZXIgbWFjaGluZXMgb25seSwgd2UgaGF2ZSA6DQo+IA0KPiAgICAzLiBlbW1jIGRldmljZSBib290
DQo+IA0KPiBhbmQgd2UgcGxhbiB0byBleHRlbmQgaXQgZm9yIEFTVDI3MDAgbWFjaGluZXMuDQo+
IA0KPiBGb3IgdGhlIEFTVDI3MDAgbWFjaGluZXMsIHdlIGhhdmUgOg0KPiANCj4gICAgNC4gbWFu
dWFsIGxvYWRlciBib290ICh0aGlzIGNvdWxkIHdvcmsgZm9yIHRoZSBvdGhlciBTb0NzLCBhbHRo
b3VnaA0KPiAgICAgICB3ZSBoYXZlIG5ldmVyIHRyaWVkKQ0KPiAgICA1LiBmaXJtd2FyZSBib290
DQo+IA0KPiBXZSBuZWVkIHRvIGRlZmluZSBhIHByaW9yaXR5IGJldHdlZW4gdGhlc2UgbWV0aG9k
cyB0b28gKHRoZSBsaXN0IGFib3ZlIGlzDQo+IG1vcmUgb3IgbGVzcyBvcmRlcmVkLCBhcGFydCBm
cm9tIDQuKSBhbmQgaGFuZGxlIGNvbmZsaWN0cy4NCj4gDQo+IEFsbCBvZiB3aGljaCBpcyB0byBz
YXkgdGhhdCB0aGUgcGllY2Ugb2YgY29kZSBiZWxvdyB3aWxsIHJlcXVpcmUgc29tZSBjYXJlOg0K
PiANCj4gICAgICBpZiAoIWJtYy0+bW1pb19leGVjKSB7DQo+ICAgICAgICAgIERldmljZVN0YXRl
ICpkZXYgPSBzc2lfZ2V0X2NzKGJtYy0+c29jLT5mbWMuc3BpLCAwKTsNCj4gICAgICAgICAgQmxv
Y2tCYWNrZW5kICpmbWMwID0gZGV2ID8gbTI1cDgwX2dldF9ibGsoZGV2KSA6IE5VTEw7DQo+IA0K
PiAgICAgICAgICBpZiAoZm1jMCAmJiAhYm9vdF9lbW1jKSB7DQo+ICAgICAgICAgICAgICByb21f
c2l6ZSA9IG1lbW9yeV9yZWdpb25fc2l6ZSgmYm1jLT5zb2MtPnNwaV9ib290KTsNCj4gICAgICAg
ICAgICAgIGFzcGVlZF9pbnN0YWxsX2Jvb3Rfcm9tKGJtYywgZm1jMCwgcm9tX3NpemUpOw0KPiAg
ICAgICAgICB9IGVsc2UgaWYgKGVtbWMwKSB7DQo+ICAgICAgICAgICAgICBhc3BlZWRfaW5zdGFs
bF9ib290X3JvbShibWMsIGJsa19ieV9sZWdhY3lfZGluZm8oZW1tYzApLA0KPiA2NCAqIEtpQik7
DQo+ICAgICAgICAgIH0NCj4gICAgICB9DQo+IA0KPiAgICAgIGlmIChhbWMtPnZib290cm9tKSB7
DQo+ICAgICAgICAgIHJvbV9zaXplID0gbWVtb3J5X3JlZ2lvbl9zaXplKCZibWMtPnNvYy0+dmJv
b3Ryb20pOw0KPiAgICAgICAgICBhc3BlZWRfbG9hZF92Ym9vdHJvbShtYWNoaW5lLCByb21fc2l6
ZSwgJmVycm9yX2Fib3J0KTsNCj4gICAgICB9DQo+IA0KPiBUaGFua3MsDQo+IA0KPiBDLg0KPiAN
Cg0K

