Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50DFCC25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 06:24:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE17N-0004VN-5W; Mon, 03 Jun 2024 02:24:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sE17I-0004Nn-OA; Mon, 03 Jun 2024 02:24:24 -0400
Received: from mail-sgaapc01on2072c.outbound.protection.outlook.com
 ([2a01:111:f400:feab::72c]
 helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sE17G-0002oK-1P; Mon, 03 Jun 2024 02:24:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/aG4IVmqLVLawGJMxoztAe7GFk0zK1+9T+X51WXGMmYeZSt6wPHli+peaF8AkEKfYdFEyECe9t0N2IcKZg5lOfWdjKw4c+J01U0oClz+Rm4HlyTmFeBTzDhjzr9snfXJtjzE30DTPDEfwrVFHfAyBkAilV9TcS9JTKIJNqYxyvA0RvTjo9cxb9rRMlHuVUyz9sz9+aEVdrjSZ75Dv2wV8GBm/LZhfBKf6ZG4D6tPDSP4iuNZt07WL6lqDsT5VvEZwr4qxUIHEjlTxDHLmJX5+zltKtA+Ik6Edp0gBgtlb85kWX+2wj5NaGGbpqZDk4Bl2yYwQy42PTIO1abbvuQZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=63zpXNoBgUZ/LBrd7dkdZNM5YZ4uHYjBOIstAwWFLv0=;
 b=EIWCR0ECT78mHcH/AyHp8A5Pp6JnUYc1DuneiBdDmzpsnKIomQ/mDl5sTscuSiC91Ej8KNgMXkJUM9pDuMR1KmX8aXo52k25Lg6JGN/CIYBuLNV1Uhpnlj38egg93uAVRyDiclN2IpEI/An9m3K07YQ2xi+wraggnsu5zC97lOQMiJKYTd46G0p32Kk/b4sEtsfTVg3hx6no+SM1DfEjm05H46qZoEuTc+y9KDg7PgivQc+Mmwgg2opBP2N2Yxh0tcgVH9Tu7BWQ8AEztL9chF+Jh6D/SoI3DUnWB4ADRUGcw5u8Kh40QBCrmAmmOqWzlX8A5vny91zrCzrCVP8gUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63zpXNoBgUZ/LBrd7dkdZNM5YZ4uHYjBOIstAwWFLv0=;
 b=f4mfNT2DdS+81V4wOdHtpWzQwQUbqE4K4bYfDm0qJlmjbFFx845fyGHOGyZwEd56iOS8hgWOglqimxBl/AFkxo771A6RMRNu6U0OVAFf3l1gZEOxczxdnPUTyFKGGKr00Drg6+63p3kyFzePPo1LCKNV6VzF1R8bN7dqspPbU/R4ZkOCgfkfrc1FivwP/lrbb4G94HhSxSK8BA7HEIXWVxPcxtqEXXhdDpxSc9ITp5ysLQrHXLh9eVRnefmmAYuP98ORNV6CkwPKJiByKfFEmNHpqt4Aw7ob1NnLCWQ//yDmJoTBMjGy81GYyU5iQ04BcZPTm1jJH4w6qtIZPfqQmw==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TYSPR06MB7045.apcprd06.prod.outlook.com (2603:1096:400:467::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.22; Mon, 3 Jun 2024 06:24:13 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 06:24:13 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Peter
 Maydell <peter.maydell@linaro.org>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Cleber Rosa <crosa@redhat.com>, Wainer dos
 Santos Moschetta <wainersm@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [SPAM] Re: [PATCH v4 09/16] aspeed/smc: Add AST2700 support
Thread-Topic: [SPAM] Re: [PATCH v4 09/16] aspeed/smc: Add AST2700 support
Thread-Index: AQHasAxD7pGMgs1HT0+SNhsCAW+G/7GrPUCAgAD8sQCACVwRkA==
Date: Mon, 3 Jun 2024 06:24:13 +0000
Message-ID: <SI2PR06MB504115C43768F1DF7E9621B9FCFF2@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240527080231.1576609-1-jamin_lin@aspeedtech.com>
 <20240527080231.1576609-10-jamin_lin@aspeedtech.com>
 <b641018c-e906-452b-8072-1b46f141808b@linaro.org>
 <41e59fa6-c74d-47c7-ba01-690cfaf7f5f1@kaod.org>
In-Reply-To: <41e59fa6-c74d-47c7-ba01-690cfaf7f5f1@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TYSPR06MB7045:EE_
x-ms-office365-filtering-correlation-id: 42a977cf-9da6-404c-397f-08dc8395c99a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|1800799015|7416005|376005|366007|38070700009|921011|217643003; 
x-microsoft-antispam-message-info: =?utf-8?B?dXB3SXBkQnNLSXI0aXBad3RUU2RBOGVyMGpOb05rLy9FdVhzb0wyNjBsUzA0?=
 =?utf-8?B?d0FwTXNORTBVdEl1UjJEUnNYN0VjclJmZXZDeUVXMVZoOU10ZmxmWkR3OVQ5?=
 =?utf-8?B?bEQwd0NnVmJsT2M5QzVvQzlLTmNUUk4rRDRYd3lCNDJ2VUpYV0dQRU5xVDJ1?=
 =?utf-8?B?RHZHNkpKakgwT0lTTGwxbGFLLzQ1akdxcDRLdkV2Yzdpb2kxQWxVTmZPOVVw?=
 =?utf-8?B?RmYvVllON0RJaW90d2xtSEhGZ2pLRmh4RW82SzFSWlRQaGZPRldVUDlXczdE?=
 =?utf-8?B?UVgrV2paTU9UU0R1bGxTNG05S1BKbGRDL3R5WEIzME1Xc2JNWUpvSTlXY3BX?=
 =?utf-8?B?SUc5UVo3N0IvNVVhWXhDdFVNalg3MWJSb2lnOXpKTi9ldEhUd1Z4QjVTd2lj?=
 =?utf-8?B?ZzEvcWpCRHVRUncxRnZaMVJXVzh2U05IQjFlbWNxbFFDZlBQeHFwTG0wVnov?=
 =?utf-8?B?NUJqVFRINFo2U0dPUjB4elhmNUZVY0lDaFlWTkkyV1Nnd3RldTkyVDFsOVBE?=
 =?utf-8?B?L1hSbWlhVVVkc2ZUNHBwK3pnbjFiTXQ3dUJpNnQzUzY1dkZ6QmNhaXFhRSty?=
 =?utf-8?B?WGJKOG5Xa3ZMUHo4enh3a3lPWVo0dFFZMVFONEdQQ2ZzdWkyMlJHN1lJZkYr?=
 =?utf-8?B?bk1hMkcyYmdVbE1OelJCT2pNTFBhZ054eS93T2ZFZUJaMFZyNzJlTmQ0QU5T?=
 =?utf-8?B?UTZRVjU0RGE5SjR5VXRZT3NWdnlMSVo3QjhyYnpKQ3RneFE2ZmpaWlNJVGl5?=
 =?utf-8?B?UDdoOHNnRWN3WTQvUVl4NUFpbk1LblRNZkRHdnlGNnVPREc1alhqUWtaakpv?=
 =?utf-8?B?alBlbE40NVRHblYzOFFGTjQ3MXZyTWw5R2ZXL3Z6V1dxZ0Q0dzFUYm5PeDZ6?=
 =?utf-8?B?Nm1lVzdQaTcrK09JVWZRNnF4M3ExT0dWTk02U2I1OWRIejlzSFFxT2JOTkpn?=
 =?utf-8?B?L0tqMVV1ZGl6ZUlQL2lsSmxvaG1oTlJDY0ZIU3AzbjJTWnJRakFZZEtnUTAv?=
 =?utf-8?B?d0ErMHBzWWhiSTEyMHd3SUpsajhxZk1LVWJCd3pqcnA2ekpab3F0M3h3dnVQ?=
 =?utf-8?B?Zm9SMHdWbWlhVG5vVTFzekYra0hMYmw0UWZGbTc4b2F1WGh3QXpBa01NYjBo?=
 =?utf-8?B?UXgwZlVxZXF5dld2ZzNFY2JCN25sNXB5NnRkZzZWbFc4OVNNSUI1Mlc0ODBL?=
 =?utf-8?B?N1FQUWJVMmF0S2JLU3hHQnIvTDRTOXBQSGMwUkRreFozT0R3TnNoY1hoeG85?=
 =?utf-8?B?WmZCbklvNUljWjFTUEZGTEhFaWRKdjI3bnNVbjNSYm1JcGxINkthcG1UM0ky?=
 =?utf-8?B?MFpIaUNjUmthTFR6bWcvb085VW54Z3U3RWtpR1V1MzlqZFovcG9GdUs1UmM5?=
 =?utf-8?B?Q3ZudmgrUGF2QmRxU29KSEtIRkhLSC96SEtzVGoyd2twYkhxVlg5V0VCcDd5?=
 =?utf-8?B?RDFUZVZRMEExcktCTmZrZ2ZRM2dqYjVoWmRCeGc2engwRnF3NGFPQmFaNjd4?=
 =?utf-8?B?RVcxSUhhY0dUUjd2clJ1dzM4R3l6dGloS3kvSVVDNXd5b1RtSzByb1FUVU5D?=
 =?utf-8?B?SDY0a1dPUTBybzJUbzMyaTQxdGh3TktZa1hQSUFUM2lJcjhiVzVyVkEzdkpR?=
 =?utf-8?B?T2QzSmZrQjlRak11UjNsUUp6NzIrU3plazZlYXFsYzhCd3pyOUtMWmE1bnkz?=
 =?utf-8?B?SzZQNWZmQTIxYW9oZHBIRG5zeDBGdWl5cG5sb1ROQkpSbnAzYk55RFNjRTg4?=
 =?utf-8?Q?QSIGHl8bFSSrk9a0EKuX+5KJAtssYaCUE3Uu+OI?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230031)(1800799015)(7416005)(376005)(366007)(38070700009)(921011)(217643003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eTVIZHhqVXpnQ0h6S2EwblZuR04rVXZwQWQzUk9wRkg2bHNCdnFON00xR1VJ?=
 =?utf-8?B?ZDFaNjM1NTR3dmsxcnRvcDBPTlZJRm9JWTRlRS9WNW5aWGFjUzV3ZW40UTM2?=
 =?utf-8?B?UDM0ejVIVjJ5Y2ZLd3pldFZnclNjT2hUcWRnOVdrdDVzdHZSbTZab3BpNVZp?=
 =?utf-8?B?aHljTGJqV1BtQm1aUGhabngyUmNIN2JhaVowN3pIQ1k3a1lvT3hCdUVoSWpC?=
 =?utf-8?B?MjIrOVhaWjUwTnAwMGlyUEhybFIxd3ROVlN5Q1I1V0pxYUxYODZUanhIYm1Q?=
 =?utf-8?B?SWdMYUhhbUkvNFVweHdCeHhKbVRxbFhYZjFzZEEwamRTU2pQb3FOQkVDVm5X?=
 =?utf-8?B?eGJyZHNvK215TVpkQmI0aXNYdytEZzdIWVNiWmV0ZnlNRDdMR2JUc3pwN29s?=
 =?utf-8?B?UFMyR3hxS2IydGx3elk2dmt6OTRvaDFUWCswR1VBM0p1UDhTTndnOXN2dnpC?=
 =?utf-8?B?Q1diU3FmM041VHhzWUhjeE1veG5Sd3NSb09LaERzQVpPdk9WTEVUZzFlMkRD?=
 =?utf-8?B?ZGFvNGkzR0Q1VW03SnpLMmpNcUo1OFJhV1M1Y01FZTJjSkdwM2FBaElROVg5?=
 =?utf-8?B?L2lwQU9GTjlJc0JRcy9NTFdZejZ3N3ZWaHpxd1AzVExrVkVWc2FVYnAyM2N1?=
 =?utf-8?B?UzlUdm9YUUgrL002TFozTWR5anNrR2preHRodUhOSHJOeXZjNGF1dnZRRDdh?=
 =?utf-8?B?RzV3NnU3d25JVm82RnZLOFlFajBTTzFadDNjV21jeUo4V1JDTHJZdkVDZS8y?=
 =?utf-8?B?Y21zZmtVSXg3b0V5aVpreWppTU1GTXAybGdBWUttZGlCZm5Iamc5R2pTRTFy?=
 =?utf-8?B?NzBMdGhYcEtLbDBOQmVNK29TaWY1elpoMkJGQnduZmtKY2NvRExiMGNMZ0lB?=
 =?utf-8?B?UjBvYUhDYnF6M0JldlBZRlFmNyszK2M3cWFyQ09QN2YvTlRiUXEyYmlEUGdQ?=
 =?utf-8?B?SGh5RXFoQ21yOHh1dzNiWVlIK1RBNnJud0Zld2JtU3RUNVFVVnpzL0l4VkhV?=
 =?utf-8?B?OTJCcm1KMk0xTnZmY2NZd2k5cUxsSjROZjJvcVZPcDc5MTdNTEQwVU1IMTdq?=
 =?utf-8?B?Y2RXYWlUQjVZM2IxMjRLRlBsNjFlQTdOazIrUkVkbVJXMEN6ZEwyc1dSQlRi?=
 =?utf-8?B?c3E2NTdVa3lXTlFtVnlhWEZrSTBmL0xINU42NzJQdERqaE1mV3llSGlBNlRn?=
 =?utf-8?B?S1ZJajJhZ2FZSHEvbnVKcU0vWWJwcXpGRDJwS25MOTlFVUJOME5TbTdLaERz?=
 =?utf-8?B?N2tBSHFNSy9MZnJyNTZoSi9JQjBTMHRxOEp5V0JWQm9neXdoTDI3OFZUYWlN?=
 =?utf-8?B?VUpqcDUrc3o5WUdJakh2NFk1QXZ4R3l5S2NGM2t1UGhXdjhpby9oOVlLOXkw?=
 =?utf-8?B?WmFsZ0xVK1NKMGErVFBnaGVQK2U3WHdoQ2lRcURCV2o5djZseUlKMmlmVG8w?=
 =?utf-8?B?SkZTU1g2cHhnYmpKR2RaL1A5clJvNTAzdUloSzcxc24yUnBIOURpT1d3V0d5?=
 =?utf-8?B?ajFNZWZ0akQ2dnhHUDZKVWF2Y3p5dVEwakl1NkRucGRPMUdQMVg1SW8yVmdp?=
 =?utf-8?B?Z1JsWGptYzBGVnU5WmZuWUpYS0tIVllDbm5KOEdOZ2VYWEx3NlBDUFNkTW56?=
 =?utf-8?B?SUZHRzhKN2xPZTlDT0N5aTJaci9vNkFGaXFuZ2FmM0s5TjFrOU53djk1N05R?=
 =?utf-8?B?UWsyZHN4VmFKZStxRXYwMmo4aUNpU2hpbHVkYW44Sk5ob2d0Y0hLMmhLMm1x?=
 =?utf-8?B?d2R3WFpPWlRhWk5vSFJwYld5dnh0MkRKWGZJeFlWbkZCMkxxak9vWm1zeXl0?=
 =?utf-8?B?ZXJ2d1JGK2dOaVo2UVhVTUJheXhyQjBSR0lqbjVoZVpDMmNqWkptMzl5cHpD?=
 =?utf-8?B?WFVQdUt2YVp5dXZPakVaTDlzaXlIajBtbkY1d1J5cGpFeEJCZUU3UjVvTis0?=
 =?utf-8?B?WVdxeVdrODZRYk1ySTZjdzF2cURvdnBiWlNPQVBTREdDZ01yTXhWMTljNXFo?=
 =?utf-8?B?dUR0UmRsU3d5MHpZS3BKcEd3TFh4eWg5TjgrZkw3Sk1xMDF3TjkyRDJZNHUz?=
 =?utf-8?B?YjNZRjZQTjBKelZ1NlFZNHdCaVVyb2czK0xFQmx5cTI5M3VzTGVRTHBTS2VH?=
 =?utf-8?Q?x7o/2GbyBeGd0b1yvWk18Jp4b?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42a977cf-9da6-404c-397f-08dc8395c99a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 06:24:13.5368 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yXlf9e5VQJLVJRuen3Aj/VO5ej0OlbfS/zt5OBgtuGdUQD9ca9hcqYyGf7FcMUHQqGCw/PQ2+SL208vZPn1je24jmZjUGGZiyQN0SKlo6ok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7045
Received-SPF: pass client-ip=2a01:111:f400:feab::72c;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-SG2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

SGkgQ2VkcmljLCBQaGlsaXBwZQ0KDQo+IEZyb206IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAa2Fv
ZC5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIE1heSAyOCwgMjAyNCAzOjAzIFBNDQo+IFRvOiBQaGls
aXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+OyBKYW1pbiBMaW4NCj4gPGph
bWluX2xpbkBhc3BlZWR0ZWNoLmNvbT47IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGlu
YXJvLm9yZz47DQo+IEFuZHJldyBKZWZmZXJ5IDxhbmRyZXdAY29kZWNvbnN0cnVjdC5jb20uYXU+
OyBKb2VsIFN0YW5sZXkNCj4gPGpvZWxAam1zLmlkLmF1PjsgQWxpc3RhaXIgRnJhbmNpcyA8YWxp
c3RhaXJAYWxpc3RhaXIyMy5tZT47IENsZWJlciBSb3NhDQo+IDxjcm9zYUByZWRoYXQuY29tPjsg
V2FpbmVyIGRvcyBTYW50b3MgTW9zY2hldHRhIDx3YWluZXJzbUByZWRoYXQuY29tPjsNCj4gQmVy
YWxkbyBMZWFsIDxibGVhbEByZWRoYXQuY29tPjsgb3BlbiBsaXN0OkFTUEVFRCBCTUNzDQo+IDxx
ZW11LWFybUBub25nbnUub3JnPjsgb3BlbiBsaXN0OkFsbCBwYXRjaGVzIENDIGhlcmUNCj4gPHFl
bXUtZGV2ZWxAbm9uZ251Lm9yZz4NCj4gQ2M6IFRyb3kgTGVlIDx0cm95X2xlZUBhc3BlZWR0ZWNo
LmNvbT47IFl1bmxpbiBUYW5nDQo+IDx5dW5saW4udGFuZ0Bhc3BlZWR0ZWNoLmNvbT4NCj4gU3Vi
amVjdDogUmU6IFtTUEFNXSBSZTogW1BBVENIIHY0IDA5LzE2XSBhc3BlZWQvc21jOiBBZGQgQVNU
MjcwMCBzdXBwb3J0DQo+IA0KPiBPbiA1LzI3LzI0IDE3OjU4LCBQaGlsaXBwZSBNYXRoaWV1LURh
dWTDqSB3cm90ZToNCj4gPiBIaSwNCj4gPg0KPiA+IE9uIDI3LzUvMjQgMTA6MDIsIEphbWluIExp
biB3cm90ZToNCj4gPj4gQVNUMjcwMCBmbWMvc3BpIGNvbnRyb2xsZXIncyBhZGRyZXNzIGRlY29k
aW5nIHVuaXQgaXMgNjRLQiBhbmQgb25seQ0KPiA+PiBiaXRzIFszMToxNl0gYXJlIHVzZWQgZm9y
IGRlY29kaW5nLiBJbnRyb2R1Y2Ugc2VnX3RvX3JlZyBhbmQNCj4gPj4gcmVnX3RvX3NlZyBoYW5k
bGVycyBmb3IgYXN0MjcwMCBmbWMvc3BpIGNvbnRyb2xsZXIuDQo+ID4+IEluIGFkZGl0aW9uLCBh
ZGRzIGFzdDI3MDAgZm1jLCBzcGkwLCBzcGkxLCBhbmQgc3BpMiBjbGFzcyBpbml0IGhhbmRsZXIu
DQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IFRyb3kgTGVlIDx0cm95X2xlZUBhc3BlZWR0ZWNo
LmNvbT4NCj4gPj4gU2lnbmVkLW9mZi1ieTogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVj
aC5jb20+DQo+ID4+IFJldmlld2VkLWJ5OiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3Jn
Pg0KPiA+PiAtLS0NCj4gPj4gwqAgaHcvc3NpL2FzcGVlZF9zbWMuYyB8IDIyMg0KPiA+PiArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiA+PiDCoCAxIGZpbGUg
Y2hhbmdlZCwgMjIwIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4+DQo+ID4+IGRp
ZmYgLS1naXQgYS9ody9zc2kvYXNwZWVkX3NtYy5jIGIvaHcvc3NpL2FzcGVlZF9zbWMuYyBpbmRl
eA0KPiA+PiBkZjBjNjM0NjljLi5iNDAwNmM4MzM5IDEwMDY0NA0KPiA+PiAtLS0gYS9ody9zc2kv
YXNwZWVkX3NtYy5jDQo+ID4+ICsrKyBiL2h3L3NzaS9hc3BlZWRfc21jLmMNCj4gPj4gQEAgLTE4
NSw3ICsxODUsNyBAQA0KPiA+PiDCoMKgICrCoMKgIDA6IDQgYnl0ZXMNCj4gPj4gwqDCoCAqwqDC
oCAweDFGRkZGRkM6IDMyTSBieXRlcw0KPiA+PiDCoMKgICoNCj4gPj4gLSAqIERNQSBsZW5ndGgg
aXMgZnJvbSAxIGJ5dGUgdG8gMzJNQiAoQVNUMjYwMCwgQVNUMTB4MCkNCj4gPj4gKyAqIERNQSBs
ZW5ndGggaXMgZnJvbSAxIGJ5dGUgdG8gMzJNQiAoQVNUMjYwMCwgQVNUMTB4MCBhbmQgQVNUMjcw
MCkNCj4gPj4gwqDCoCAqwqDCoCAwOiAxIGJ5dGUNCj4gPj4gwqDCoCAqwqDCoCAweDFGRkZGRkY6
IDMyTSBieXRlcw0KPiA+PiDCoMKgICovDQo+ID4+IEBAIC02NzAsNyArNjcwLDcgQEAgc3RhdGlj
IGNvbnN0IE1lbW9yeVJlZ2lvbk9wcw0KPiBhc3BlZWRfc21jX2ZsYXNoX29wcw0KPiA+PiA9IHsN
Cj4gPj4gwqDCoMKgwqDCoCAuZW5kaWFubmVzcyA9IERFVklDRV9MSVRUTEVfRU5ESUFOLA0KPiA+
PiDCoMKgwqDCoMKgIC52YWxpZCA9IHsNCj4gPj4gwqDCoMKgwqDCoMKgwqDCoMKgIC5taW5fYWNj
ZXNzX3NpemUgPSAxLA0KPiA+PiAtwqDCoMKgwqDCoMKgwqAgLm1heF9hY2Nlc3Nfc2l6ZSA9IDQs
DQo+ID4+ICvCoMKgwqDCoMKgwqDCoCAubWF4X2FjY2Vzc19zaXplID0gOCwNCj4gPg0KPiA+IElz
IHRoaXMgYSBidWdmaXg/IElmIHNvLCBwbGVhc2UgdXNlIGEgc2VwYXJhdGUgcGF0Y2guIE90aGVy
d2lzZSBwbGVhc2UNCj4gPiBtZW50aW9uIHdoeSBpdCBpcyBPSyB0byB3aWRlbiBhY2Nlc3MgZm9y
IEFTVDI2MDAgJiBBU1QxMHgwLg0KPiANCkFjY29yZGluZyB0aGUgZGVzaWduIG9mIFNQSSBkcml2
ZXJzLCBpdCB1c2VzIHRoaXMgIm1lbWNweV9mcm9taW8iIEtFUk5FTCBBUEkgZm9yIFNQSSBjYWxp
YnJhdGlvbi4NCmh0dHBzOi8vZ2l0aHViLmNvbS9Bc3BlZWRUZWNoLUJNQy9saW51eC9ibG9iLzEw
NjJhMDc0MjBmOWFlZDRlZDdkYzlkZWIzNDI5YjhlNzgyOGY1Y2YvZHJpdmVycy9zcGkvc3BpLWFz
cGVlZC1zbWMuYyNMMTgzMiANCkFTVDI3MDAgaXMgYSA2NCBiaXRzIHF1YWQgY29yZSBjcHVzKENv
cnRleC1hMzUpLCBzbyBrZXJuZWwgQVBJIHVzZSA2NCBiaXRzIGZvciBkYXRhIGFjY2Vzcy4NCmh0
dHBzOi8vZ2l0aHViLmNvbS9Bc3BlZWRUZWNoLUJNQy9saW51eC9ibG9iL2FzcGVlZC1tYXN0ZXIt
djYuNi9hcmNoL2FybTY0L2tlcm5lbC9pby5jI0wyNSANCkkgc2ltcGx5IHNldCB0aGUgbWF4X2Fj
Y2Vzc19zaXplIHRvIDggZm9yIEFTVDI3MDAgc3VwcG9ydC4NCkFTVDI1MDAsIEFTVDI2MDAgYW5k
IEFTVDEweDAgYXJlIGFsbCAzMmJpdHMgQ1BVUywgdGhhdCB3YXMgd2h5IHRoaXMgbWF4X2FjY2Vz
c19zaXplIDggZGlkIG5vdCBpbXBhY3QgdGhlc2UgbW9kZWxzLg0KaHR0cHM6Ly9naXRodWIuY29t
L0FzcGVlZFRlY2gtQk1DL2xpbnV4L2Jsb2IvYXNwZWVkLW1hc3Rlci12Ni42L2FyY2gvYXJtL2tl
cm5lbC9pby5jI0w0NSANCg0KSWYgeW91IGhhdmUgYW55IHN1Z2dlc3Rpb24gYWJvdXQgdGhpcyBw
YXRjaCBtb2RpZmljYXRpb24sIHBsZWFzZSBsZXQgbWUga25vdy4NCkkgYW0gZ29pbmcgdG8gcmUt
c2VuZCB2NSBwYXRjaCBmb3IgQVNUMjcwMCBzdXBwb3J0Lg0KVGhhbmtzLUphbWluDQoNCj4gQWgg
SSBtaXNzZWQgdGhhdC4gSSB3b25kZXIgaG93IHdlIGNvdWxkIHNldCBkaWZmZXJlbnQgYWNjZXNz
IHdpZHRoIHRvdWdoIG9uDQo+IHRoZSBtb2RlbCA/DQo+IA0KPiBTaG91bGQgd2UgYWxsb2NhdGUg
YSBNZW1vcnlSZWdpb25PcHMgaW4gdGhlIHJlYWxpemUoKSBoYW5kbGVyIGFuZCBzZXQgdGhlDQo+
IHdpZHRoIGRlcGVuZGluZyBvbiB0aGUgU29DID8NCj4gDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBD
Lg0KPiANCj4gDQo+IA0KDQo=

