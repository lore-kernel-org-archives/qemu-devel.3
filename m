Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD720CEACC6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 14:07:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svdWd-0003lL-Ez; Tue, 01 Oct 2024 10:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1svdWZ-0003Yg-Hs; Tue, 01 Oct 2024 10:06:48 -0400
Received: from mail-eastasiaazlp170100000.outbound.protection.outlook.com
 ([2a01:111:f403:c400::] helo=HK2PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1svdWE-0001BM-2l; Tue, 01 Oct 2024 10:06:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BIFbQSRx4d2Snl3eWKNhpsG4zBFMwcRwJC0FyLLpL5dSwlARQupZPEudLQqUFTsuDVn/wbfCYE8fZx9RyWhGll5cfERDT4deM/4ZKDuIh41F/qaU2vugScwe8MmamLAf54ib/CNng7zU6V3CV8rEmuKYgZDdEkAemMs2X207osptkeTfEcGTKJmCcJV/CoN3V1b2ufRslkkBq+uEy+3/H5eesfjS6Kq+3p5KFedqoCH0a8GHES8u6NPvN0WKmNriaaXQf3zz1JGJ32RWYBhjaRzqKvmOUqQF5fKst+3+pmU1iyYE0jUiB/7iFAgiBVE6SQ/5md5r7eJDmBuMcIhF5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Fma3N1/D8QOKxQt1fQt1gsvZC4ePGOwYBK8ruYEo3I=;
 b=iYa3GvAM6FqJ0wmS4wNJg4qDYahz9SemF3VjUBVasR/bZuB08DLD5o1oD9lAdEpqYZk2zif386kvnmnWyabhm+r11sCSPTVLbhwGa/hNKSj+tr3PutxdcOsmgAcZ8zRWZMQq4xvLvGZHfvo/Dq/QZ+JXpIgXv1JuuxXYEvmrIDecB48fZ0iDFned7eJgpv70fiUrdaPIKvSWy5k3cfqfnYs5L8owsdsallyaJ0GuXOJzSUV8p7JTrmVlsnohHYbcgPdxAnPIqsnFhvAU79hy85BAZBQGvkm1qG+Vi9UxddN1rVzlUYYNgv4CUGJMu+X6Iwr9QBr8r+KiEAphijoF8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Fma3N1/D8QOKxQt1fQt1gsvZC4ePGOwYBK8ruYEo3I=;
 b=SL4ywLXJWkJKSJWA9HrxG8z+nE8wGaDIsrT9WzteCPKO/CZzkorz29ZN6VX52oP3wrFb8AQtrZNZyAuAK3gFBb+sIvWM7GCKZ6hyY2bGnz9+TZA5kT+TUJb37pLXiwv7S6Tn3/3a/urG5QiiKrpvigKuNZP3qLr1/UfLSZuACU8Gb7rqHUlexhvHui2bQANswFprbnTOvCDXQoLpucq5fhASNfyVlEG92XkTykulg6597qfnYJ3CbFAnouho4oX0HL5QXuyZW/F1xK11c/2o3szQ6txDwWTxggUQ3U8SnwpESJXJIQ5+fqL4mtGsd8uaE//tmThVZoT3g4FZO8zKxw==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SI2PR06MB4996.apcprd06.prod.outlook.com (2603:1096:4:1a3::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8005.27; Tue, 1 Oct 2024 09:43:18 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 09:43:18 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Thomas Huth
 <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v7 0/8] Support GPIO for AST2700
Thread-Topic: [PATCH v7 0/8] Support GPIO for AST2700
Thread-Index: AQHbE6u60gZfwQqPOUSqLWZQZLwIObJxpC4Q
Date: Tue, 1 Oct 2024 09:43:18 +0000
Message-ID: <SI2PR06MB5041260E63C468FB348E1F2BFC772@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20241001024334.834807-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20241001024334.834807-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SI2PR06MB4996:EE_
x-ms-office365-filtering-correlation-id: 97a0b982-e120-474a-149f-08dce1fd7ac7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700018|921020; 
x-microsoft-antispam-message-info: =?utf-8?B?Vk80TWNwQ0pRdHpVNlJHanVUNzVmbWVtd3FIN1ZDaWhwa3M4Njk1eDFFdVRw?=
 =?utf-8?B?M0tiV2huQ2JCem1GcEJkYWJtYnFQcEVEK2xpelo1R3dzSWJ6cnVnOFhHVE1s?=
 =?utf-8?B?VElQSkh3RGIzN0RxdUNMQzliTHJOdlh0QjZCMGY4MDFZN3Z1eGhiV25Ed21V?=
 =?utf-8?B?c3lRc3BQRDRUTmd1TW00MkVHYzdoZFlUdnpMNnNSWlo5eFZYT2pQSTI5U2V3?=
 =?utf-8?B?cnYrTXlJQU5rM1NYak1GdGgzTVVDM01meGxzOXRQakJHM1V6Z05yOFNjMU9V?=
 =?utf-8?B?ejVkamtueERPNlZkcTVtWTNaRm1jSzZGL29NZ1FhMEc2cmVMK1c0WUc0am92?=
 =?utf-8?B?dE1PaHZsWm1HZnpTa0F2Y3pFUDJkQll0Ynlvbjk4UGxsd3FuSzVGcytTVGk2?=
 =?utf-8?B?Z21IWGdHQnBGdngvRXdSakk5ZGtnYkpvcFo2bDRteG8rMGF6Q0w4bEkzRDZr?=
 =?utf-8?B?Y01uVlA5KzYrYXVhb1cwbWtONkx0UThNS3E5WGJNaEZjRFZweTVidm4wSzlS?=
 =?utf-8?B?bEtoZStKVFRiV1I3b2JSK25vcFRhcTFFaEZsQ1R1U2RtdlJvZy9sWW9XNk1a?=
 =?utf-8?B?bG00NVUwdG1GT2kyQ1hWbm91VkxpbkRKYkhhSEh4VE0ydjVNcmRrUWcyaVF4?=
 =?utf-8?B?dmNsTmQxdlIvMVBpSjR2ZHpVODVYT3UxOFRWeWlPVFk4R3c1aWxBL1ZXOWg3?=
 =?utf-8?B?dTB2RlU4SW9SK2dWdlNtTkx4V0t3TkNTdDE3YzhJVS92RFZiM2U5bGFGUUZB?=
 =?utf-8?B?SDhFTmNGWndFUU1mZENmbzVXRExGbWhoM2V1ZTQ4U2JCUi94TWkxZzhkNVZ3?=
 =?utf-8?B?MVRtQ0J4VTk4K3BRVTlmR2VYazVPWnNkMzFjTnRacjRSUVA2Y0RxaVpEN1JW?=
 =?utf-8?B?NWY0MUFYNUE1cmxVaTE5YXJLSkpaZHJ0NFd1QXZSY3pXQndmSUhYZjlFNWRL?=
 =?utf-8?B?K29ReFdpZ2hXWFVrWDZUU3QrbGhpT3gvVjc4ZHg2dHdUbnhFTTFiWjcvc1BU?=
 =?utf-8?B?L012YndGamZ3SjJoZG9SeHdsZTBmYmxHejdnSEY4K0Z6NU5nNldST1JYRkFa?=
 =?utf-8?B?ZVVWNjE5ZFFDNUphL3V6Wk5KU1lzSmxPSkJmblV1U0IzS1UraGRWcVBTSDBW?=
 =?utf-8?B?Y0UwTkFZQzBuWGVkcjlkYWcvR043ZlNaOGFhTmtOQi9Fd3hucW53T25PWkxl?=
 =?utf-8?B?N3VJb1dBaHBxM1BQRm55dHRlQjZmOTNkaitoc0dVTU9ycDE3MDhSMWQ2Q01x?=
 =?utf-8?B?bzlBNDU2ck9LLzYxQTQvRmNKS28rTzVBTC9QblNOMm9LbTJVelhxeGdVTU5N?=
 =?utf-8?B?ZXZtdUcrWll3VUxRK2FSTHdXdktyODY4R2lHSEw1RFNwZENBTmhYc1EwZVQy?=
 =?utf-8?B?ai9hU3dkTFgxVlUzbFM0WURGcGJWSXU0SnB3TXhsQXpPcmVhY3EwSis3b09H?=
 =?utf-8?B?MnJsaUpDRXBRS0VaVzMzaEZyWDRBY3VUd29GWm5XdzdWaUlVVnVZdlVtRFZY?=
 =?utf-8?B?bDJaWmo5K2dGUG9FZWpUZG1oM01DT0NLOVpURWpvTGsyUlM0TE4xMkp4QjJO?=
 =?utf-8?B?b1c4N0llVEZXQmp0NU1mWk1GalJqeUp6T29TQzlPUXZpSDFFV25CbVdwM1o5?=
 =?utf-8?B?VlV6TGpWQmVOc0xDS2tiL0VOSks2bWtrMFNTUFVEK1ZyRTVCVHZrMElMU3dY?=
 =?utf-8?B?ZXFuam96ZHp1dVN2QlhIVXpWUGJOd1FxaXRjUEtNRnJPaDN3MElUcDk3d1Ew?=
 =?utf-8?B?a0ZxT1dnSkNOYzlCdTZOUjdoRzh5ck9Ca3hiWm9XRDhNV3ZIbG9WSitWOERR?=
 =?utf-8?B?aGl5ME1WVnZuUWsxVjUwb1hOZ2JtTlFFS2JHbGU2bGRGNXNQMVBtSS90bmdh?=
 =?utf-8?B?b0IwcU8vRElpNUROZDVObWhYb05FQ2s2Q0FFbFFUWVhEeGoyTituMms4SUF2?=
 =?utf-8?Q?wiK02Hg043k=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1IrZXVyamZlKytpb3ZoaDRRS0tueXpIalpPUzNlM0haYnBhQmx6cVlac3FU?=
 =?utf-8?B?citsUWlaOC9Td3Jvc2NiczM1UTNheHBlK1Jma2JPSDVQanZFbk5LSElISXhG?=
 =?utf-8?B?Yzc0MzJ3WFB1YmpkNWZlODVUUEFTaEdSU1hFdThCYVhVVjNiSHFHRmdKUkxn?=
 =?utf-8?B?aWkyNTl2ZXJERVR5SENNeEJyT3p5dlJ4MXpRUXM4WW1HNlkvZDJmenZYOGQ2?=
 =?utf-8?B?REU3bGk0V2RPMWRRVjBMZ3NXcCtzUUgrYzEzL2grOEl0SXdqMXA4VlNud1VZ?=
 =?utf-8?B?RXJobGc3QkhOckV5OUdIWUp0aDcxRDg5dkxTOUsvNFhwYmt2d250V1ZiOWZO?=
 =?utf-8?B?WEE0WkFQaVFqSzBpdFRML1B5NTlKZWxNam54ZGZDY01MWS9LL2F3Nkp1SHRU?=
 =?utf-8?B?TnVCOVFRUzAyVUlWVXh3dXRveDVKSU5GSWY0ZkpCcHdZZWlKODhKRGZjVWZu?=
 =?utf-8?B?a00xbHhxNWVSNHJ5Z05ZSXphZnUyTlBnVFdYZFJzK1FOYWxGYkUxMWJwOGxV?=
 =?utf-8?B?ZndGaHhGZk95OG93UFBVSHBkbVplUUM2UDVJdyt0UFV4OFozYWRYZzZNNkZB?=
 =?utf-8?B?b0NwN05nN1J6WGZiWDYxNHhxWmRVMXd0K2d3bFpva1EvT1FGbWZpbUJUdStY?=
 =?utf-8?B?TFp5ZkViNXFkSWF5WC9IeWliU2JzOWxDVTZNaVRBNDIrZDB2NFhiUWJoTzM1?=
 =?utf-8?B?c25KTVdWS2c4UHBlYlhSUzI2YWpnTksrTENhT21kbTdKWVk0VCtyWDV3cE9G?=
 =?utf-8?B?Z2VET3RQd3k4MlhBWnUzeExjQ25KSnRyNXd1UEhSUlZLL0Z6RDU3ZFdDY0hL?=
 =?utf-8?B?QkFaNldob3ZmQklBdTRqaHA4b3lpbHVpSUczY2pmalhpTGVrRHpsL0tPZkxZ?=
 =?utf-8?B?MjJ2NDl4YlNERXFoTlI2bVlrWkRxV09UR1AwY1gxTkp3RnNQSU40TGt5SU4w?=
 =?utf-8?B?WWxQelE4bEpLcWVXV0ZPbEhvQlZYbjdrdS9IRVRiQ0RrS0xrQlByZmZZYzRG?=
 =?utf-8?B?SndxR0dlSEMrMzVETWlvRnFDQzBzNUpENnUveTc2akkweUpjT3hRSU5RdlpY?=
 =?utf-8?B?aHBDcGxSM0Y2UEVndE9oNTNSTmtsNnV5b29UVEoxTU5VdWR6ZzdxU2hYb1NT?=
 =?utf-8?B?ZXJOSXlWTzJwbysrZmNOdGZ6TUVKblhJUUVCbWRPSG1scGkyaHFDZGZoandy?=
 =?utf-8?B?VlhDRFN5RWNaU3Q2VWZBWkx2cTFpSGN4V0loL2l1WGNjaGNRUjl0S2EwM25B?=
 =?utf-8?B?YWRNREV5TEhYMURpMk5IdVR3NTc4MDIySlBiOGhPUEE2Y0JUZE9DOTNIeElM?=
 =?utf-8?B?UitHdG43OExDYjdiclJzY2xUSHlhUWVxVVJsWE1KT2gzTDFQbTQxbWxoVDI2?=
 =?utf-8?B?ODdDbWcvb1pUSVR1enVtRTcyajNZZ3FJUXppL2c1RlF1RW41eStrVGp6dHdV?=
 =?utf-8?B?cjNEck91MW1mWXRGRFczLy9PdlhDU2cyKzdOUlBmOHRJQVIxNmFLbTRweG1S?=
 =?utf-8?B?d1RwdUFXamg1TFNHK2poZW9za3JzdmhUamFUTXBCUnZTL0wyK0t5SHVzazZE?=
 =?utf-8?B?RGdyQXdISlphNUk3VHN4M0ZTcU9ZVUk1WkJEVUt1QURsQ3BCaFIraGY3TVdy?=
 =?utf-8?B?ZHN2MU9KbXVSc3N6aG96Z2hSa1FOdE1oSFNUMWIyMVQwYy9SMlhHeUVGYlhZ?=
 =?utf-8?B?WWVhelB6bXVzZnpGclMwWUtHbktNWVNMMFpmWGxUTEpabURkTmR6T1NSRHNV?=
 =?utf-8?B?TDhZY0dyeTRZVkhiRXVRY3JoWnhhKytwUlRWRnRHSmNiMWoyRElDV0pUSDg0?=
 =?utf-8?B?eW5NbCtSTWJ5SDE0OGhmU0lYOHFpZGN5Ui83T3dRSzN1MXpzV0ZXSUtzc0FK?=
 =?utf-8?B?VDhLTi9wU2M2dTIzYzlhcDB0ZEd6YmhEMThSRTNpL21BNGtKK2xOQzRpdk04?=
 =?utf-8?B?TlUzNFlCNE1YdVAxYTR3OEZuZjQ3S29PVkhEbGhEQ01STFl1QytrMzdmWW5u?=
 =?utf-8?B?eFRoeUZieFVMcHFweUJncmhqY3ByQ1o4TTRDNHVSU0QrM0FlMXdFbHg5c1Bo?=
 =?utf-8?B?RkJYSnkvZ1QzeW5ld2d0VGM5Ny9aRG9QaXRNWXJDSUxtbnVQZU54SjVMRW9x?=
 =?utf-8?Q?cP/Pih82kJtT9sauyic5R424h?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97a0b982-e120-474a-149f-08dce1fd7ac7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2024 09:43:18.2313 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rOB/WJpuk3jvJ2f2mKse61UWx+wWEgzSv6RR2efuZppMZt36CDzcaibbEaiQeqjlgshMXfz1rh/3yIYrWyaEfTTPa1/ABGI6nRIrweE16jA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4996
Received-SPF: pass client-ip=2a01:111:f403:c400::;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=HK2PR02CU002.outbound.protection.outlook.com
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

SGkgYWxsLA0KDQo+IFN1YmplY3Q6IFtQQVRDSCB2NyAwLzhdIFN1cHBvcnQgR1BJTyBmb3IgQVNU
MjcwMA0KPiANCg0KSSBkb24ndCBrbm93IHdoeSBJIHNlbmQgdGhpcyBwYXRjaCBzZXJpZXMgZmFp
bGVkIHRvIHRoZSBmb2xsb3dpbmcgZW1haWwgYWRkcmVzc2VzIGFuZCBnb3QgdGhlIGZvbGxvd2lu
ZyBlcnJvcnMuDQpvcGVuIGxpc3Q6QWxsIHBhdGNoZXMgQ0MgaGVyZSA8cWVtdS1kZXZlbEBub25n
bnUub3JnPiANCm9wZW4gbGlzdDpBU1BFRUQgQk1DcyA8cWVtdS1hcm1Abm9uZ251Lm9yZz4NCg0K
MjAyNC8xMC8xIOS4iuWNiCAwNjo0MzowNCAtIFNlcnZlciBhdCBub25nbnUub3JnICgyMDAxOjQ3
MDoxNDI6Mzo6MTApIHJldHVybmVkICc0NTEgNC40LjM5NyBFcnJvciBjb21tdW5pY2F0aW5nIHdp
dGggdGFyZ2V0IGhvc3QuIC0+IDQyMSA0LjIuMSBVbmFibGUgdG8gY29ubmVjdCAtPg0KU29ja2V0
RXJyb3I6IEZhaWxlZCB0byBjb25uZWN0LiBXaW5zb2NrIGVycm9yIGNvZGU6IDEwMDUxLCBXaW4z
MiBlcnJvciBjb2RlOiAxMDA1MScNCg0KRG8geW91IGVuY291bnRlciB0aGUgc2FtZSBpc3N1ZT8N
CklmIG5vLCBJIHdpbGwgcmUtc2VuZCB0aGlzIHBhdGNoIHNlcmllcyB3aXRoIFRob21hcyByZXZp
ZXdlZCB0YWcgaW4gdjguDQoNClRoYW5rcy1KYW1pbg0KDQo+IHYxOiBTdXBwb3J0IEdQSU8gZm9y
IEFTVDI3MDANCj4gdjI6IEZpeCBjbGVhciBpbmNvcnJlY3QgaW50ZXJydXB0IHN0YXR1cyBhbmQg
YWRkcyByZXZpZXdlciBzdWdnZXN0aW9ucw0KPiB2MzogUmVtb3ZlIG5lc3RlZCBjb25kaXRpb25h
bHMgYW5kIGFkZHMgcmV2aWV3ZXIgc3VnZ2VzdGlvbnMNCj4gdjQ6IEFkZCB0ZXN0IGNhc2VzIHRv
IHRlc3QgR1BJTyBmb3IgQVNUMjcwMCBhbmQgdXBkYXRlIGNvbW1pdCBtZXNzYWdlcw0KPiB2NTog
Rml4IGFzcGVlZF9ncGlvLXRlc3QgdGVzdCBmYWlsZWQgaWYgYXJjaCBpcyBhcm0NCj4gdjY6IEFk
ZCB0byB0ZXN0IGFzcGVlZF9ncGlvLXRlc3QgZm9yIGFhcmNoNjQNCj4gdjc6IE1vdmUgR1BJTyB0
ZXN0Y2FzZSBmb3IgQVNUMjcwMCB0byBhc3QyNzAwLWdwaW8tdGVzdC5jDQo+IA0KPiBKYW1pbiBM
aW4gKDgpOg0KPiAgIGh3L2dwaW8vYXNwZWVkOiBGaXggY29kaW5nIHN0eWxlDQo+ICAgaHcvZ3Bp
by9hc3BlZWQ6IFN1cHBvcnQgdG8gc2V0IHRoZSBkaWZmZXJlbnQgbWVtb3J5IHNpemUNCj4gICBo
dy9ncGlvL2FzcGVlZDogU3VwcG9ydCBkaWZmZXJlbnQgbWVtb3J5IHJlZ2lvbiBvcHMNCj4gICBo
dy9ncGlvL2FzcGVlZDogRml4IGNsZWFyIGluY29ycmVjdCBpbnRlcnJ1cHQgc3RhdHVzIGZvciBH
UElPIGluZGV4DQo+ICAgICBtb2RlDQo+ICAgaHcvZ3Bpby9hc3BlZWQ6IEFkZCBBU1QyNzAwIHN1
cHBvcnQNCj4gICBhc3BlZWQvc29jOiBDb3JyZWN0IEdQSU8gaXJxIDEzMCBmb3IgQVNUMjcwMA0K
PiAgIGFzcGVlZC9zb2M6IFN1cHBvcnQgR1BJTyBmb3IgQVNUMjcwMA0KPiAgIHRlc3RzL3F0ZXN0
OmFzdDI3MDAtZ3Bpby10ZXN0OiBBZGQgR1BJTyB0ZXN0IGNhc2UgZm9yIEFTVDI3MDANCj4gDQo+
ICBody9hcm0vYXNwZWVkX2FzdDI3eDAuYyAgICAgICAgIHwgIDE4ICstDQo+ICBody9ncGlvL2Fz
cGVlZF9ncGlvLmMgICAgICAgICAgIHwgNDI3DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKy0tDQo+ICBpbmNsdWRlL2h3L2dwaW8vYXNwZWVkX2dwaW8uaCAgIHwgICA0ICstDQo+ICB0
ZXN0cy9xdGVzdC9hc3QyNzAwLWdwaW8tdGVzdC5jIHwgIDk1ICsrKysrKysNCj4gIHRlc3RzL3F0
ZXN0L21lc29uLmJ1aWxkICAgICAgICAgfCAgIDMgKw0KPiAgNSBmaWxlcyBjaGFuZ2VkLCA1Mjgg
aW5zZXJ0aW9ucygrKSwgMTkgZGVsZXRpb25zKC0pICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gdGVz
dHMvcXRlc3QvYXN0MjcwMC1ncGlvLXRlc3QuYw0KPiANCj4gLS0NCj4gMi4zNC4xDQoNCg==

