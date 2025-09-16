Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A12CAC599
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 07:46:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyQNA-0007LX-F7; Tue, 16 Sep 2025 03:45:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uyQN7-0007Ka-R4; Tue, 16 Sep 2025 03:45:06 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uyQN4-0008Br-B2; Tue, 16 Sep 2025 03:45:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FQIBHjKlnJpX+jSo1BKqZxBSQniZm/cu20TUdxl6iSgFYISnThPfc1dSKtkZsYxFLE5gbXLyVCdOUsEl1GJmQqSno2NMHQWQZ6tZDqkf1589RdeL/V8HPuVZYpDmKk2p54gnlWXLd+VYlIS1i8ZvEhkXZo3ehSer6n1z18tOL0OrojV9QcA2pDPe8DZFmdzUPFEhmCf4SRgfGjHeeyrtJlgHGjGHa50nv4kUV0k43ZisTkNWdYtS8yhUT45he4ObaVVQJN66DdZMe3jt4VhrMoGDjcZuMokc5yrqWQKqaNzHqbYenVgf6dWSG9SIcWZJfRI5PCjjfrEZh4wtgS5cZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gl5V/TjJmGtanIH96ISXlsh5ky9Q17kWA0rS+Fz2dWg=;
 b=XeFSyCJ3Y9YxhTFAfMXsdh2alI8FsPbBzkAZWbI43oZo1BhA2tFy5lppzvY6Nfq1ZMtqGRVTzJPJjdPLHgXk8/XcFi82J5zz73JclelfdiquroqtEotMHLUA3lOuxAMl1iVnYCvCD6wUv7QFvHG1cY5GeuDMQCAtKu8YfEEKgJ4XKInDtR+RyX7VMdIa6IvEI4sLxuyGQLaBGEkIlSpl8yFPDQTu3elZ/nFyIobffMvi2JRMW8ohL0wGunDNrDu0P6+xxveOtRyy9UEdrRjqt+u9zEviMlLUUf61NGN2A10NnFkobl8A3NBrESY8SEYwvPMn8F+H7leP1zU37y2vCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gl5V/TjJmGtanIH96ISXlsh5ky9Q17kWA0rS+Fz2dWg=;
 b=kTfXzpbM+ZEIVZ6NF7/G117tm12kqhP4xTNdrA+CeYrvM4PmRPessOOyBoz8lSeiqQv/XRDc1e7iRUjoUtBV7pg2AATTGETHvxHclV+/r8ImBg29NDwfIUzNr+sgMLv0gdjDG/pox8h/vxiBKsTrnz1Zwgg0MSYsldZmVjKSWy67/q05mBsoqOfj6GUuH9TV8FPxZlxihB+upFdEAIqm1cZSU5z9mk50dpHYWlCaZFPDgG2BcgxfthHMQNf7KBjp8zOG2fycxzuZaqgNv3nQYMb9INx/kZkIKdTAwDjIrbwwi+1+m5utiLIDnGDaNbEj/F7XdU5GRDHKliYb1+xsig==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SEZPR06MB5643.apcprd06.prod.outlook.com (2603:1096:101:a7::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Tue, 16 Sep 2025 07:44:50 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%3]) with mapi id 15.20.9115.018; Tue, 16 Sep 2025
 07:44:50 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "Michael S.
 Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, "wuhaotsh@google.com" <wuhaotsh@google.com>,
 "titusr@google.com" <titusr@google.com>
Subject: RE: [SPAM] [PATCH v2 13/14] tests/functional/arm/test_aspeed_ast2600:
 add PCIe enumeration test
Thread-Topic: [SPAM] [PATCH v2 13/14]
 tests/functional/arm/test_aspeed_ast2600: add PCIe enumeration test
Thread-Index: AQHcIu00cXB6uwmS3UCbqmacudbgSbSUhImAgADp/YCAAAZbAIAAAKdw
Date: Tue, 16 Sep 2025 07:44:50 +0000
Message-ID: <SI2PR06MB504175077E5594E56694E587FC14A@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250911072452.314553-1-jamin_lin@aspeedtech.com>
 <20250911072452.314553-14-jamin_lin@aspeedtech.com>
 <1d990b45-9188-4631-a819-c32257dec558@kaod.org>
 <SI2PR06MB5041375C3586349460CD73D0FC14A@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <e0586ec3-1d9b-48e7-bc39-82c3f3e10746@kaod.org>
In-Reply-To: <e0586ec3-1d9b-48e7-bc39-82c3f3e10746@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SEZPR06MB5643:EE_
x-ms-office365-filtering-correlation-id: 60280bbf-8e65-4747-6999-08ddf4f4eafa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|366016|38070700021|921020|217643003; 
x-microsoft-antispam-message-info: =?utf-8?B?S0ZmWEVTemJaQ3FBVU53LzZZZWtLRms5RmtobFlBdk5LaUpHSUFXUXN5ZnVk?=
 =?utf-8?B?NE0yM1A5NmQxVUJYQ2pFanhJZ1ZvOXhvM0c1QUk2K2UwVXhhdk1kWDI5MmRM?=
 =?utf-8?B?dmIzc1FTNU8wWkhLR01zUVgwOGZkNFJEa3VtNmk1alhaVU1ORE5hMklmcDYw?=
 =?utf-8?B?RWc4RmVEYU9pck44RXhWNHc3VzJjQXNJeE8vV05CVGhjS2NLOUtPdlRHWFBS?=
 =?utf-8?B?eFU4R1pLSTBMSXF1QmpKdExueHdRL0RXVVBGVlcwSHU3dmJ5QXdSK3MrTGRm?=
 =?utf-8?B?clkvM2JybXppWUgrNTZyMUZuQnZ0U0greGVmNjdXWkE0c3hrVE92SmlGWkNl?=
 =?utf-8?B?eGlmczlqdXozQTJobGtsV1JpTzBQbHF5TmRCQ25LV0IxdFMwdUlqd2JNKzhH?=
 =?utf-8?B?TkxUV2FJWDVFVWJDMVRTTmZKc0VaRU9QLzRFc25BTStQc1AwUTVXZDU0Y2FO?=
 =?utf-8?B?OVhHam51ZG91NSs2Y0pueGozM2ZPOWxCbUUvRDNybHc1NHpSUnpBZHdYbVV5?=
 =?utf-8?B?ZlZUano3N3BaZjlMeDR3MCtuRDJMNy9SbEt1KzBrVmt6REVLSUFzSlN2WEI0?=
 =?utf-8?B?Y2VXeVJieU1zVm5ESUx6N1ZNa24ydy9LV2NKeHA5dk1OQ2syRm43dElpdm1n?=
 =?utf-8?B?TWtqUWVhOFRrOWFDSzlWLzBySitONElic085d21idWpKek1PVjB4eDY0T2JU?=
 =?utf-8?B?TGY1UEpnOUhZa0FDTHoxMEgzck92NVhjbGdrOGZkMXdoR1hkWFo5TFRxWUVr?=
 =?utf-8?B?UWdnczl6ZGxGTkRuc0FXdFFXcGltcmE5OE1Jc1Jvb0VSd1Z4alIyRmU5bm85?=
 =?utf-8?B?ZzVOZzVubW9lVmtrUmU1cy9QNkF3VTVOTXZCK0FaSVczU284MTVvYVBsaWha?=
 =?utf-8?B?alhLTWdLS0t6c0FEK2pNL0oxZWkrR0hNM3N6cHpzdjMvK2hsdlFPdlE0UTZD?=
 =?utf-8?B?R08wYXgwQWdPZnZubWR2TTZlWFpIWHAzOGZsV2hYZHFCdHFiaE4xV291Titx?=
 =?utf-8?B?WEdyb1pISGdQMDlQMGphQVNHQUVqazFma3V2ZDlDNHRQT2NaOUhuTTRZVG5M?=
 =?utf-8?B?bHB0UGFVN0FFcG44OGgrSis2Q0xXaTJkcEFlUE1iclZTZXAwUUpIV0VLTHNk?=
 =?utf-8?B?SjdmRXUvQWQyMHc5ZlAzbjNJUGxVZ1VWSjlnUlRwbVBDVkFXMEoyUUxOWHIw?=
 =?utf-8?B?MDVCdHUvN2ZaQnRyOFV5R0lSSFVvd3QrWGRrT2QzZHpmcnJ0dUkrSUpacTVK?=
 =?utf-8?B?WjBlQVJEaFdmNjRXV2pWenZOR3htazNIQzBxZ0VKRThEWTIzTlpOdERlcWo4?=
 =?utf-8?B?a25YbXA5VjlKRm1wWmVjb1EyYUlSY1IwNVdMS2FvNjJvU3Y3SlpZKzNVSVla?=
 =?utf-8?B?aE9HUS9kVUIvbmpULzBUQnFFVEFCaXdIT3V5eXQwbEgxR3hRZVR3ZEFUazVR?=
 =?utf-8?B?WExyWUdUSVJoMjdkaVl0MytaWDdEVTYxR1JYeXJvL0lLelppU1VicGxLZVVB?=
 =?utf-8?B?bTZCdUlrdWpEYmNrK2xQR2x3TWhubEoxVG5pWkhpVUNSMDBDMS8rTC9NdzZI?=
 =?utf-8?B?Ymh2UmJDMTdBL1RpdGp0V09oYmdVZER4OGVJTlY3cmpCdGYrOFQ0UCtiakxl?=
 =?utf-8?B?a2tiT1BiWmtzNTJWem43YnF6SHlEVEJCemVSYWlKSkhqekZFWGlLODlOS09F?=
 =?utf-8?B?V21QVFRGSGY0STlLT0F2dWNjeEdzWWxlbGVkSnd5L2dFR3djNnJGZnUyTXND?=
 =?utf-8?B?UDFsSjl0bjV2bW92OFdPNFE1ZFVuTWZsS3dHZGdmKzhjVG90VGYyL1RTLzUr?=
 =?utf-8?B?a1lmWFRsZEtWbS9uSVZOSEtIVUViNlJ2dVpiWDFXS1VnNVRiYzlJUm9zWE5P?=
 =?utf-8?B?V0Rpei8ra05XaWpMV0xNcytISm1HU2V5a3pZdkhtQVF0RGZCV0IwOGxKRTVY?=
 =?utf-8?B?TWVsakJWckVXSytvcWliNmF2SDlXbWdCUXVYT1Q4M0dVRmVsbDZXZlJBQngw?=
 =?utf-8?B?TDZRV1BFMnpGeEQyQVRFd1Zib2dTVjZoS1FQTzBXZjYrSDI1dk5OazZDQ24r?=
 =?utf-8?B?N20za2JKY3NzWEYwQ0QzVTQzMkg0ZnFBRDVDZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700021)(921020)(217643003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NjRId3YwdTc3SDFxTkZMZEZNVjhING9DL1pjdzllQWcrMi84dzlhZ2s0SENw?=
 =?utf-8?B?MXNaYzMyNDdPL1JxZ0pCdGNyT2l1bE5XSnVCTkM3K0doWm02cHBRM1ZWUEsz?=
 =?utf-8?B?SXZHMW80UURJZGNZaDdDcmlVY2tOREU2Q083eVNrK3dJWWFiM05OdUNxRUtT?=
 =?utf-8?B?ZjNuQnpPbHFoRit6eExsWXRhUHFUSlR5bzhJemE1K3JKaGpURTR5eEdGUEg2?=
 =?utf-8?B?T1BkQkpqekZZN2IrRlNSbjFYUmlNOStNMEwyOTBLNmZuaHRnT0kzV2VEUlpn?=
 =?utf-8?B?ZGwzcWY3cDFjVGlvQmJwdHJTUVM2TC9tZzZ2U2Q2cXRXa3Q5eWl4UFZOdzRp?=
 =?utf-8?B?cGdOc3dHejJxVjRSbkczb0Z0UThzNDNzdmRUdThCK1hxRlJvTjNqSGViVHFS?=
 =?utf-8?B?L2tzcHU3VERhakh1MTg2VjdkSzlHV05OeGpMSnBHdmNPV3E0MklSczkyekUv?=
 =?utf-8?B?cG5EbkpKSWkwbllXbVNqbEcyRXd2ZHg3WjhYTXRMZmtmT1QydVUwS1didmg5?=
 =?utf-8?B?OHZ2aTlickhLaVdndHRwVEhodW9BK3dmWFhld1Zva0haWWhoRDdFMHVkN2Vh?=
 =?utf-8?B?dDRwR1M4cVF2VGl1cDUwV0dGZnRUeTZGRU5GWm1SKzJGRjhJdlg1Vy9vVUtI?=
 =?utf-8?B?SW1FbWExaTRjL0RqZzcyem9YdDBaeTZXbC9GODdqTU5CVTJWU2Y4ajZiNmp6?=
 =?utf-8?B?V1dFYmoxbm5sU3BFUHhaMnhmamtnQ3ZvNlNmQ3RXTFErbnNza04yQzFrejNE?=
 =?utf-8?B?OWJjMnIvbFJjUW5XMzNWalJ5T29jK1JKR3Uvb0czaERBRVBXYkVld2d1cHA2?=
 =?utf-8?B?V2h0LzJoSmFvS1lxSE5RWjFCcFpQMklkbmhMajFacm1FM2JITWFaR2dBcUo3?=
 =?utf-8?B?TDFXZkFtTU9oY1VWbEQzT2hWNi9yQnQwQ05NMlRlbE1Sb1dXcUFZeVdrNGI0?=
 =?utf-8?B?MngrVjdPcWlCcFU4WjF3VzA2QUYxaU9hd01POTdTSGkzWEZXTncrTlVEdzB1?=
 =?utf-8?B?dnZsWlA3VWhwd0Zvc0NaZ2h6TTV6RXNudE1aaG9LZk15RFVwRWRJSkpMZFlt?=
 =?utf-8?B?NUJPc0xrNFg1cDZ4QS9XRmxkcC80NFBSZFRxSXlSYmxvc1IxQVlzU1NhWGpZ?=
 =?utf-8?B?dVNYVTBhQWxlOW1sdGcxWGtCdUZiWHI2UkQzL0dxNE9YRkt0UHhCNXZPZyt3?=
 =?utf-8?B?di9ibWhXeWpYV2dySmpmLzVXVC9PbmlveXUzQ1VLVXRNNUgrbmx1OFRTVlJG?=
 =?utf-8?B?ZFZpYVRidUMrU3BML1llZXN2RGwxMk9EYlFrN1RSU29zWXdsb2RpamlJZ090?=
 =?utf-8?B?elZoNlVRbVJsYjFOK25jdGFXRUF4MzVxSXoxbG9oNTVkMDlsZUdmd1FhbVoz?=
 =?utf-8?B?eFl6aEpJSEdjVTYyVTFnZG5GTjhhMDZjRWpubHkrdFMyMkJVU2ppbk9MaGR2?=
 =?utf-8?B?UHhTZ0ZSMWE1TmFlRjhySEFPS0Y4MkVtOTF5S2JzQUhpUEQzRXg1U0ltVXlz?=
 =?utf-8?B?VzBkcnJKYk9XZk11MVdmS0YzSmJETERlaWw5aW5GR1hycDRuNE8rd09WYXhQ?=
 =?utf-8?B?R1pLcDJWY1ZVbm0wd0VkbkFjRGJXZWVtYUg0dDdCbEdxcEY1eWhCelM2Yjg0?=
 =?utf-8?B?aW9EdGpnQlZPNzh1V2VQNE9vOUVFKzZ6MnVzNk1kdnVIbFNlSHUzemRGYzA0?=
 =?utf-8?B?d0oySFVZdGJHMUNYOUgzK2ZUYUZBU2lzM1p6UEIxTVBlcWpVcThBaUxrVi9C?=
 =?utf-8?B?aEZib0NzNFdPaUtaVXZjcWFQY0ZlQzRIbFFOYnBXSlUxQmxoRFpOREhHNUUz?=
 =?utf-8?B?K01mN3JWQ0F5RlVUZndxS0JUa1pVUHpzRFZzTG9ZTzc4UytuSHYvYmNSV2VK?=
 =?utf-8?B?aXBodk1aenRjaFFPWVlhdDJORXN0R2RHNlk5NG0yYzFpdlM0RGo5WWpMYTJ4?=
 =?utf-8?B?N0l2elhLcGZqbU9ZN1N4M2hNUGNyMmhISmpEREhmbzlrVnpYdGhJUzNJVW1u?=
 =?utf-8?B?dVhVTWs0RHpsZVdjbWRTeFlCNlFyRU5YK1d1ZnpKdWN0NGlrS0FRRFFnU0Zr?=
 =?utf-8?B?ZWFDZ3lLNk95RHlTTGt1UEI0OVArSU9NMGlKbzlIMGh6Q25ZRTZWdy94QXEz?=
 =?utf-8?Q?BouG21ZsaXFXS4KMkfY50j3mN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60280bbf-8e65-4747-6999-08ddf4f4eafa
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2025 07:44:50.7449 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0SKpFgsySuRYpSR3/40ODw45cpBRHZMFG6bpelM5AgeWMIJ5qscxsAaXy/7W24uw8i3d8Gmc9aM8qcuverPpVYSwbMzBrNdsEd/c/+xbhHg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5643
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

SGkgQ8OpZHJpYw0KDQo+IHRlc3RzL2Z1bmN0aW9uYWwvYXJtL3Rlc3RfYXNwZWVkX2FzdDI2MDA6
IGFkZCBQQ0llIGVudW1lcmF0aW9uIHRlc3QNCj4gDQo+IEhpLA0KPiANCj4gPj4gSSB3b3VsZCBh
ZGQgJy1kZXZpY2UgZTEwMDBlLG5ldGRldj1uZXQxLGJ1cz1wY2llLjAgLW5ldGRldg0KPiA+PiB1
c2VyLGlkPW5ldDEnIGFuZCBjaGVjayB0aGF0IGFuIElQIGFkZHJlc3MgaXMgYXNzaWduZWQgdG8g
dGhlIGludGVyZmFjZS4NCj4gPj4NCj4gPj4NCj4gPiBUaGFua3MgZm9yIHlvdXIgcmV2aWV3IGFu
ZCBzdWdnZXN0aW9uLg0KPiA+IEkgd2lsbCBhZGQgYSB0ZXN0IGZvciB0aGUgZTEwMDBlIGRldmlj
ZSBvbiBBU1QyNjAwLg0KPiA+DQo+ID4gSSBhbHNvIGhhdmUgYSBxdWVzdGlvbiByZWdhcmRpbmcg
QVNUMjcwMDoNCj4gPg0KPiA+IDEuIFNESyB2MDkuMDYgZG9lcyBub3QgaW5jbHVkZSBhIGJ1aWx0
LWluIGUxMDAwZSBkcml2ZXIuDQo+IA0KPiBXZSBoYXZlIHN3aXRjaGVkIHRvIHYwOS4wNyBub3cu
DQo+IA0KPiA+IDIuIEFTVDI3MDAgQTAgZG9lcyBub3Qgc3VwcG9ydCBQQ0llIFJDLg0KPiA+DQo+
ID4gR2l2ZW4gdGhlc2UgbGltaXRhdGlvbnMsIGlmIHdlIHdhbnQgdG8gdGVzdCBlMTAwMGUgb24g
QVNUMjcwMCwgY2FuIEkgb25seSBhZGQNCj4gYSB0ZXN0IGNhc2UgZm9yIHRoZSBBU1QyNzAwIHZi
b290cm9tPw0KPiANCj4gSSB0aGluayB3ZSBjYW4gbGltaXQgdGhlIHRlc3QgdG8gQVNUMjcwMCBB
MSBzaW5jZSBBMCBzaG91bGQgYmUgcmVtb3ZlZC4NCj4gDQo+ID4gMS4gVGhlIEFTVDI3MDAgRkMg
U0RLIGlzIHN0aWxsIG9uIHYwOS4wNiBhbmQgY2Fubm90IGJlIHVwZ3JhZGVkIHRvIHYwOS4wNw0K
PiB1bnRpbCB0aGUgZm9sbG93aW5nIHBhdGNoIHNlcmllcyBpcyBhcHBsaWVkOg0KPiA+IGh0dHBz
Oi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9xZW11LWRldmVsL2NvdmVyLzIwMjUwNzE3
MDM0MDU0LjENCj4gPiA5MDM5OTEtMS1qYW1pbl9saW5AYXNwZWVkdGVjaC5jb20vDQo+IA0KPiB2
MDkuMDcgaXMgbWVyZ2VkIGFscmVhZHkgYW5kIHRoZSBzZXJpZXMgYWJvdmUgbmVlZHMgYSBsYXJn
ZSByZXdvcmsgb2YgdGhlDQo+IGNvcHJvY2Vzc29yIG1vZGVscy4NCj4gDQo+ID4gMi4gVGhlIG1h
bnVhbCBkZXZpY2UgbG9hZGVyIGNhbm5vdCBiZSB1cGRhdGVkIHRvIFNESyB2MDkuMDcgYmVjYXVz
ZSBvZg0KPiA+IHRoaXMgY29tbWl0DQo+ID4NCj4gaHR0cHM6Ly9naXRodWIuY29tL0FzcGVlZFRl
Y2gtQk1DL29wZW5ibWMvY29tbWl0LzE3ZjdhMjU5ZjNhNGQwNTJiOQ0KPiBlYTkNCj4gPiAzMzUz
YTM0MDAwNDBmMzk5OTJlDQo+ID4NCj4gPiBTdGFydGluZyBmcm9tIFNESyB2MDkuMDcsIHUtYm9v
dC1ub2R0Yi5iaW4gaXMgbm8gbG9uZ2VyIHNoaXBwZWQuDQo+ID4gSWYgd2Ugd2FudCB0byBzdXBw
b3J0IGl0LCB3ZSBjYW4gZ2VuZXJhdGUgaXQgbWFudWFsbHkgd2l0aCB0aGUgZm9sbG93aW5nDQo+
IGNvbW1hbmRzOg0KPiA+DQo+ID4gZHVtcGltYWdlIC1UIGZsYXRfZHQgLXAgMCAtbyB1LWJvb3Qt
bm9kdGIuYmluIHUtYm9vdC5iaW4gZHVtcGltYWdlIC1UDQo+ID4gZmxhdF9kdCAtcCAxIC1vIHUt
Ym9vdC5kdGIgdS1ib290LmJpbg0KPiA+DQo+ID4gSG93ZXZlciwgSSBhbSBub3Qgc3VyZSBob3cg
dG8gaW5zdGFsbCB0aGUgZHVtcGltYWdlIHRvb2wgaW4gdGhlIHRlc3QNCj4gZW52aXJvbm1lbnQu
DQo+ID4gQ291bGQgeW91IHBsZWFzZSBnaXZlIG1lIGFueSBzdWdnZXN0aW9uPw0KPiANCj4gSSBh
bSBub3Qgc3VyZSBJIGFtIGZvbGxvd2luZyB0aGUgY29uc3RyYWludHMvcmVxdWlyZW1lbnRzIDov
DQo+IA0KPiBBcyBvZiB0b2RheSwgYXN0MjYwMC1ldmIgbG9va3Mgb2sgdG8gbWUuIE1heSBiZSB3
b3JrIG9uIHRoYXQgZmlyc3QuDQo+IA0KVGhhbmtzIGZvciB0aGUgc3VnZ2VzdGlvbnMuDQpXaWxs
IHJlc2VuZCB2MyANCkphbWluDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBDLg0KDQo=

