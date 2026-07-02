Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F9C6C43602
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 02:13:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf6v3-0001hQ-8O; Wed, 01 Jul 2026 22:12:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wf6uz-0001gU-11; Wed, 01 Jul 2026 22:12:46 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wf6uw-00054T-3T; Wed, 01 Jul 2026 22:12:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RM4DCuB09HHXFBP3e+m8ZqkxlI9CaJqbak/av0YN5IDfNys1QV6L83IseV4ykbXMl2gjwgWNJvir9WeoZWHpKMZivY6xpPc1aha0ukAZoNNUnpkrPSCs60dBAbg6mBGQSYwtvuPDfmO7m/OU1yZJixud2erX8+8odjfzhNkO9erMo48buT+y6WIX3u1XeM2dN6tZg6pfjZGycmOIMTF7/fLX5ZONEj2IZXzjJ70cwQzX2SQiiGDihyIvnd3qGdZNoCC6gVEb0wpq9nUsbf7ArFe8/yWG7KE0GN+RiEyxB9n+RBhHkkSkzCzY/WNsiPXYMPfpQ1BRcu3i2Mte1qQGCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H5z0jYApRjCybLxv9f9RwHkCqZhs6Be8FpJRdDe6aEo=;
 b=ZIXTRt0R14KLinq/6Czks4oCYp2b56/hoGMoJFpPjPrrpm5YQaKTTDiK2bXqHZ97NOmHIWjqdi/vF0He/oiv3guu8sW6sxj1ihnciGJSpULljOvnfg+gKjstW5FSWqnIrhPNbRmqA8R1hggFzcH5uSRKu6u4dWHpPDr5Gc2d0qc8mcz5V8qcJrM9qrqRJut/9euXZLic7peFLC2oa4FNqLvlM8fUMU2nipH2e8Nxgts/knXj8ybeap0NsfeJpEYwx3vSrFsmDIG0qmS2RY3wP3XUuRl0+TSCKqbhQv31jE7o+i92m4Y+dziIBm0Fx4L+45Z6XKv9X9LOtTQDyjVyzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H5z0jYApRjCybLxv9f9RwHkCqZhs6Be8FpJRdDe6aEo=;
 b=RR4AASIDqTmmSZjtA4ZdWXtulGo/PMk+iq01xQCVyXBugjqnnqY7RzhqtodaAWEy/JcoWAKE6/E/h7yOE/nEz0WsfRnuk1m4WHJis+e8ErKyZYiE1EBiMrhDcZUemywwjdNfI01MGhwoz3as+O55x8Idxia8sEkg7VsBsbiVpdSRpIxu77flFOK5vd/NThTY1QOLjBBiIw7d3u5Xr/+JT0ZCF0SNZ/5rh3LSbOVHkSsTuXMFiTJOTki9BZdx8HpM6CuyfZobkzurMeAVXYliWxiPwaahahXJGSUOsOAx53R3FhuCI4phwWvhB+Ck87841wN+s6dBSCkxx4VpQLflfw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEYPR06MB8333.apcprd06.prod.outlook.com (2603:1096:101:300::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 02:12:32 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 02:12:32 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Jian Zhang
 <zhangjian.3032@bytedance.com>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane
 Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH] hw/intc/aspeed: Drop stale pending interrupts
Thread-Topic: [PATCH] hw/intc/aspeed: Drop stale pending interrupts
Thread-Index: AQHc+jIKHghr8rxFOUqk5ESOyd7jJbZWksIAgAMFakA=
Date: Thu, 2 Jul 2026 02:12:32 +0000
Message-ID: <TYZPR06MB49802293F9C42F605294BED3FCF52@TYZPR06MB4980.apcprd06.prod.outlook.com>
References: <20260612060857.1842819-1-zhangjian.3032@bytedance.com>
 <2cce4512-a223-4821-96c3-77d13942c58f@kaod.org>
In-Reply-To: <2cce4512-a223-4821-96c3-77d13942c58f@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SEYPR06MB8333:EE_
x-ms-office365-filtering-correlation-id: 163ef516-8987-461f-fe98-08ded7df601c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|921020|38070700021|18002099003|6133799003|3023799007|22082099003|56012099006|4143699003;
x-microsoft-antispam-message-info: ALBudeNkBNFQidF+GL4deb4EOV07QZ/PK2NOcu6dqxlbnglX2knFdjV5gyW/84JW2OQetLwr5YAiwKVm82aNt5oP9whWaMj1e0zRbct59znMykr+YtLsSARKFwfry7pKoGQC8+oY9Ywk7F/PlPYgQSHtivpMbOt5McyI9+RK2WYTT/1IYc49p4ZLeUaYKNrk1rs/0RF9CRA2SH+WzsX0cS8FuWG1R5Uz/FryK8xMRGQrEMF8/9Vk46bUHbQpNvs8M0fBXpbYpYT9Nvo2C4/s11D+OrPSUPRDu1l/zwjawX2a5FSiPHJYV5KJWq4ac+EGiwS/0nVrl+fNuWCeNcvup5rY7pph3T/TvjSFAW637y4AxiK7I/D+lLoUu0y5r2PmFB9W4JtQ7ZwKNnrUE2AkJVuD+UtOSqI1FXcxTcSWLtSDj5KYARK7dD254wJcTuuLfL6arkpEJV9gigU1r0RSJCeRvxYKcd/w0Fn58F2Ocq7KZzTJz7bIZm3VSesoIIafMAvMo/gutVtCH6M047Gw2ICnFcsz+J7lTgWFDlcgyo2XXCVwA4+AJqoupwVMHpG38GA0nLqAdaJ8Hxx1Bwid//sLCx5aWnmDvbX3q9n9yO+Xuh2ZEyBZd5Slgx0RgJWYsXf0zuJreSrzZvlpVR91p8e5MpOwQh0VNDAV0oRcnIU6oPdu5ILjPsoyEadGZ7EpP2K7XMNmQdTAewH14R4TQMXPCv5eK7b60vCPBp8Lj/KFlF15DiwEY+nA1hKLr/hU
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(921020)(38070700021)(18002099003)(6133799003)(3023799007)(22082099003)(56012099006)(4143699003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SnN6ZFl5cGV1V0tYdjlHMGV3aFh0MmRDbzRXaTRmejBZMTVVazlRMXlpNFJ3?=
 =?utf-8?B?VE1rT1RDSFJMTnBmOXg3Y25QV3c1bVRCTUhIbkRRa09kbjZBclArbFc2bW54?=
 =?utf-8?B?Q0pXd09QVUkvRTlkeDJVZ2N6dEh5Qithc1ptZktNWWppQklodjVxUXl2M0NI?=
 =?utf-8?B?bWZtYmc4SzBhLzJGYXpCdFh1OE5IS0dvc2FJa2ZnM0VuTmIzQjBMWUpkVTU3?=
 =?utf-8?B?ZGtXVFB4SnEvM3oyTU9VaS8wa2RSekNjbStaNHVDTjBmVmIrQ2k3WEZ3ZWw0?=
 =?utf-8?B?UVdNaTB6ejNUZGdGZTJWQ1NreUxDNEZGVjZGdUNpSC80K0ZTY01iRkZydFNS?=
 =?utf-8?B?OHVqeVNtZW84SFVXSlBwR2k0bEk3OWUwTUxLVHhYcWRUZkRLWWk1TGpHdElD?=
 =?utf-8?B?SUw0QVVoTXZHbW9nS2ZpSEUvRmZpK2poa0sxdE9FQWZkNG9VOFdHOFFQTG5L?=
 =?utf-8?B?QUdtbG85TW1RTmZUOFhsbmJkbU8zb3owL0RCTmpQZHJFN1B6cTdVT3V4TXAv?=
 =?utf-8?B?c21SKzFNVU13bTZmdy90RnowMFlQR1FPRzZ1ZWtLT2VYekM0R3BvdG9UOE10?=
 =?utf-8?B?dytxelV5WlYvdk5kbHRGeThKTmhkMlE4T2xnc2N5OG9UTFNHRnd0R1FtWWxk?=
 =?utf-8?B?RFM3SGhzOVlPY3F5ODhrK1hmT0ltSzZVYnduUVFKa21oLzJaaFJ6b3drbzRv?=
 =?utf-8?B?TUhoMm1uMmNteHljeFFXVlZhTTJDWTdVZFlUVm51Ymw5YzA0ZGdrQnRQcVdX?=
 =?utf-8?B?aVRweUd1SU44RzlPTGU0MVNUckZrNzFNYndNTG5hM2E2ck9wcFM1NkpNZDJi?=
 =?utf-8?B?czFucng3clpQM25veGhINnZocS85MUVWZStVbEVjU0ZERnFuNzlGa3Ewdk1D?=
 =?utf-8?B?YThQbkJoUm1PS1J1M3ZZcVVzZzZUeExUdFdwTnNJY2liSlRNNmhPbHBmcEdw?=
 =?utf-8?B?Zi9jT0JlMHhrcVFhQWdPTi94V0o5dDRBVmlSZmdzTndMVmhUdWovMDYzeVVx?=
 =?utf-8?B?eXg2UW1hZEsrTEljYngvdDJwZmR6MGZrekhUZ0tocUdJQ1FXSVVmdk1hUWsy?=
 =?utf-8?B?RjRFU1RmTEpIWmM2eFZQMFI1bXh0aHhObDNDZmc5RUdHaTBLclNJUUlhSTI1?=
 =?utf-8?B?VFBpazdyQ2J0MWJjcXQ1QUhHei91Yk9WTW4ycTM2cEZKblgzMGsxY3phejF4?=
 =?utf-8?B?S0FCSEQxSk1lK3d6a0ZGeVp1ajlheWdhTExKZ3VVdUtiY0VNSVJjbnBYYUJk?=
 =?utf-8?B?U3JQSStERzk4eVhGeTZkaDNlanUva3VQclFMZE5LaWpxZkJtNW9pdXZFMGVp?=
 =?utf-8?B?TmlQT29CYnR5cVJ4U1U4R3dLSHE4K3RHWkx0WXFQODNTRHk1bEN3NmYydW9J?=
 =?utf-8?B?WkpQbGc3djRXcTIvTkRIbStJczNHSWpGRklEdWtJbzhBeVhjemcvSlQwSTBi?=
 =?utf-8?B?c2NjS2hvUlpGR0pBZ3NDdlkwSTBnM3o4ZDFrci9BU2sxNmtPMHlQc1A3Ymdk?=
 =?utf-8?B?c1lGUnk1c2xMTklFeWJyTjVDQ2JwdmlyUkRDN2dGUEV5NjkxcGM0S0pYQ3Ft?=
 =?utf-8?B?dUVvZkJIcUNTQTN5RjdaakQzM1czZzVxMVdwS2ExSHJVSVl1VVBUbnUxRVB0?=
 =?utf-8?B?NGZnTWhrVk8xaS9QU002YjRCbTIvckRuY21aZEpjNWRrRElzSSs3THgrano2?=
 =?utf-8?B?MDhRUFVRUnIxVmY5aitWVXUwaFdqTWdzRnNVVkRGNXdZd1VNN29oNUo5aW1R?=
 =?utf-8?B?aFFvRGp3U1JyTUp6S1NvQ21yOEgwNGppWFNtUWZ2Sm5GYkdUNjlqT0czQUhG?=
 =?utf-8?B?aWl4STJEZzZaUWVDaUlrSk5kQW5VVi9PdVNWVUNNdWRyd3Y3WDVIcXA4K3dM?=
 =?utf-8?B?RzlDcnVnMFJRaHNUSXpuSXZlWXhHVk9DS3FRcFg1N2pMRnFIb21IOVNTS1pt?=
 =?utf-8?B?T2RVeGdOeTZCNXN1WjRqd01ycXk1SGFvMkxMQ3UySHBsdHYzQzhsczR1MlFU?=
 =?utf-8?B?RDU2MTIxZzhEQW5IK1VuNjIxNktXUjZoZllHcG13VXNkQUlQS0FPYzFzUGJO?=
 =?utf-8?B?OXBZV2JPZVl2eEI4enZQMUFiWVBwYnJBQlpERStLNTQxZzlubTZTYjM0azhW?=
 =?utf-8?B?ZVNna3o3dG1nYm9ZcmJ0b2tEeTZUdFh1OGNkQkIvVGI2UG10Vlk0djZpeW1l?=
 =?utf-8?B?MGRsU3NnTGdQTE9mNzFUT0Y5WFhnckZYU21BUUM3c0lEWk1uZmpuUHkzTVM2?=
 =?utf-8?B?WW1xWE1YREMvMnhFUHJsNk1ObkhWMCtXNHRNdjNiazJsWm16U09aaGl6bzN4?=
 =?utf-8?B?Um9SQ013KzVZbzAwY1UxeDZ4TUNQRDVKYUcxaTNnL0lwMU50UVhrUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: LZBnyd8V8KVeJ/7J0S0hr8mPfsbK8leluLsaL3YxV5hn33GLCS9KeysArNaQRENt43aSsE5BZzzcOqU3QhMXle4S+ykN/aS0+HsjCP9+g/qqkUBDlfdLTYLQCyNUr+B9bmRsLBSf6eTinYCGljgSbtDtqg8+S22MQqPRI9XmlWduwYuFFUpSEBdBwSnWS/M4wMXx+05EHTNs+IBR9S24ulkbFH0gXv4JBchyJuT6YTSuJQg8ARWqLijViDzMPoLNWYdXu4ORAeCYIkNQtyalSAS2DoWWxcEPOsiJ9qSfIQGWfOIkHSVaZaKFF7mzORiCKcZsUlP4K1383PmBPBVaBg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 163ef516-8987-461f-fe98-08ded7df601c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2026 02:12:32.3179 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SfaBLaNg2l8vHSZoFGLj+BvI5tK/7OewkC+3DSmD0hdMDJveKzBY5hMaMns8LGT+X8YI24C9j15mhV75gzmsQza0Cod7copWp5aEzu/GIJM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB8333
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

PiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3JnPg0KPiBTZW50OiBUdWVzZGF5
LCBKdW5lIDMwLCAyMDI2IDExOjUwIEFNDQo+IFRvOiBKaWFuIFpoYW5nIDx6aGFuZ2ppYW4uMzAz
MkBieXRlZGFuY2UuY29tPjsgUGV0ZXIgTWF5ZGVsbA0KPiA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8u
b3JnPjsgU3RldmVuIExlZSA8c3RldmVuX2xlZUBhc3BlZWR0ZWNoLmNvbT47IFRyb3kNCj4gTGVl
IDxsZWV0cm95QGdtYWlsLmNvbT47IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29t
PjsgS2FuZQ0KPiBDaGVuIDxrYW5lX2NoZW5AYXNwZWVkdGVjaC5jb20+OyBBbmRyZXcgSmVmZmVy
eQ0KPiA8YW5kcmV3QGNvZGVjb25zdHJ1Y3QuY29tLmF1PjsgSm9lbCBTdGFubGV5IDxqb2VsQGpt
cy5pZC5hdT47DQo+IHFlbXUtYXJtQG5vbmdudS5vcmc7IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0K
PiBTdWJqZWN0OiBSZTogW1BBVENIXSBody9pbnRjL2FzcGVlZDogRHJvcCBzdGFsZSBwZW5kaW5n
IGludGVycnVwdHMNCj4gDQo+IA0KPiBPbiA2LzEyLzI2IDA4OjA4LCBKaWFuIFpoYW5nIHdyb3Rl
Og0KPiA+IFRoZSBBc3BlZWQgSU5UQyByZWNvcmRzIGFuIGludGVycnVwdCBzb3VyY2UgaW4gdGhl
IHBlbmRpbmcgYml0bWFwIHdoZW4NCj4gPiB0aGUgc291cmNlIGlzIG1hc2tlZCBvciBhbm90aGVy
IHN0YXR1cyBiaXQgaXMgc3RpbGwgYmVpbmcgaGFuZGxlZC4NCj4gPiBXaGVuIHRoZSBndWVzdCBs
YXRlciBjbGVhcnMgdGhlIHN0YXR1cyByZWdpc3RlciwgdGhlIG1vZGVsIHByb21vdGVzDQo+ID4g
YWxsIHNhdmVkIHBlbmRpbmcgYml0cyBiYWNrIHRvIHN0YXR1cyB1bmNvbmRpdGlvbmFsbHkuDQo+
ID4NCj4gPiBUaGlzIGlzIG5vdCBjb3JyZWN0IGZvciBsZXZlbC10cmlnZ2VyZWQgc291cmNlcy4g
IEEgc291cmNlIGNhbg0KPiA+IGRlYXNzZXJ0IHdoaWxlIGFub3RoZXIgc291cmNlIGNvbm5lY3Rl
ZCB0byB0aGUgc2FtZSBPUiBnYXRlIGtlZXBzIHRoZQ0KPiA+IGFnZ3JlZ2F0ZWQgSU5UQyBsaW5l
IGFzc2VydGVkLiAgUHJvbW90aW5nIHRoZSBzdGFsZSBiaXQgbGF0ZXIgbWFrZXMNCj4gPiB0aGUg
Z3Vlc3QgZGVtdXggYSBjaGlsZCBpbnRlcnJ1cHQgd2hvc2UgZGV2aWNlIHN0YXR1cyBoYXMgYWxy
ZWFkeSBiZWVuDQo+IGNsZWFyZWQuDQo+ID4NCj4gPiBUaGlzIGlzIHZpc2libGUgb24gQVNUMjcw
MCBJMkMsIHdoZXJlIHRoZSBJMkMgYnVzZXMgYXJlIGFnZ3JlZ2F0ZWQNCj4gPiB0aHJvdWdoIElO
VENJTyBHSUNJTlQxOTQgYmVmb3JlIHJlYWNoaW5nIHRoZSBHSUMuICBBIHN0YWxlIEkyQyBzb3Vy
Y2UNCj4gPiBiaXQgY2FuIGJlIHByb21vdGVkIGJhY2sgdG8gdGhlIElOVENJTyBzdGF0dXMgcmVn
aXN0ZXIsIGNhdXNpbmcgTGludXgNCj4gPiB0byBydW4gdGhlIGNvcnJlc3BvbmRpbmcgSTJDIElT
UiB3aXRoIGFuIGVtcHR5IEkyQyBpbnRlcnJ1cHQgc3RhdHVzIHJlZ2lzdGVyLg0KPiA+IEZvciBl
eGFtcGxlLCB0aGUgTGludXggYXNwZWVkLWkyYyBkZWJ1ZyByaW5nIHNob3dzIGEgdHJhbnNmZXIg
dGhhdA0KPiA+IGZpcnN0IHJlY2VpdmVzIGEgdmFsaWQgc3RhdHVzIGludGVycnVwdCwgdGhlbiBy
ZWNlaXZlcyBhIHNwdXJpb3VzIElTUg0KPiA+IHdpdGggYm90aCBpc3IgYW5kIHJhdyBzdGF0dXMg
ZXF1YWwgdG8gemVyby4gIFRoZSB6ZXJvLXN0YXR1cyBJU1INCj4gPiBjbGVhcnMgdGhlIHNhdmVk
IGNvbW1hbmQgZXJyb3IgYW5kIHRoZSB0cmFuc2ZlciBjb21wbGV0ZXMgd2l0aCByZXQ9MDoNCj4g
Pg0KPiA+ICAgIGV2ZW50PXN0YXJ0IGlzcj0weDAwMDAwMDAwIHJhdz0weDAwMDAwMDAwIGNtZF9l
cnI9MCBtc2dzX2lkeD0wDQo+ID4gICAgZXZlbnQ9aXNyICAgaXNyPTB4MDAwMTAwMTEgcmF3PTB4
MDAwMTAwMTEgY21kX2Vycj0wIG1zZ3NfaWR4PTANCj4gPiAgICBldmVudD1pc3IgICBpc3I9MHgw
MDAwMDAwMCByYXc9MHgwMDAwMDAwMCBjbWRfZXJyPTEgbXNnc19pZHg9MQ0KPiA+ICAgIGV2ZW50
PWNvbXBsZXRlIHJldD0wIGNtZF9lcnI9MCBtc2dzX2lkeD0xDQo+ID4NCj4gPiBBIG5vcm1hbCBj
b21tYW5kIGNhbiB0aGVuIGJlIHJlcG9ydGVkIGFzIHplcm8gdHJhbnNmZXJyZWQgbWVzc2FnZXMs
DQo+ID4gd2hpY2ggaXMgY29udmVydGVkIHRvIC1FSU8gYnkgTGludXggaTJjX3NtYnVzX3hmZXJf
ZW11bGF0ZWQoKS4gIFRoZQ0KPiA+IHJhY2UgaXMgbW9yZSBsaWtlbHkgd2hlbiBtdWx0aXBsZSBJ
MkMgYnVzZXMgYXJlIGFjY2Vzc2VkIGNvbmN1cnJlbnRseS4NCj4gPg0KPiA+IERyb3AgcGVuZGlu
ZyBiaXRzIHRoYXQgbm8gbG9uZ2VyIGNvcnJlc3BvbmQgdG8gYW4gYXNzZXJ0ZWQgYW5kIGVuYWJs
ZWQNCj4gPiBzb3VyY2UgYmVmb3JlIHRoZXkgY2FuIGJlIHByb21vdGVkIGJhY2sgdG8gc3RhdHVz
Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmlhbiBaaGFuZyA8emhhbmdqaWFuLjMwMzJAYnl0
ZWRhbmNlLmNvbT4NCj4gDQo+IA0KPiBUaGlzIGxvb2tzIGNvcnJlY3QgdG8gbWUuDQo+IA0KPiBK
YW1pbiwgY291bGQgeW91IHRha2UgYSBsb29rIHBsZWFzZSA/DQo+IA0KPiBUaGFua3MsDQo+IA0K
PiBDLg0KPiANCg0KUmV2aWV3ZWQtYnk6IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2gu
Y29tPg0KDQpUaGFua3MsDQpKYW1pbg0KDQo+IA0KPiANCj4gPiAtLS0NCj4gPiAgIGh3L2ludGMv
YXNwZWVkX2ludGMuYyB8IDI1ICsrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgIDEgZmls
ZSBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaHcvaW50
Yy9hc3BlZWRfaW50Yy5jIGIvaHcvaW50Yy9hc3BlZWRfaW50Yy5jIGluZGV4DQo+ID4gNWEzNmZm
ZjUyMDQuLmFiODBjMjM5YmMxIDEwMDY0NA0KPiA+IC0tLSBhL2h3L2ludGMvYXNwZWVkX2ludGMu
Yw0KPiA+ICsrKyBiL2h3L2ludGMvYXNwZWVkX2ludGMuYw0KPiA+IEBAIC0xMDcsNiArMTA3LDI3
IEBAIHN0YXRpYyBjb25zdCBBc3BlZWRJTlRDSVJRDQo+ICphc3BlZWRfaW50Y19nZXRfaXJxKEFz
cGVlZElOVENDbGFzcyAqYWljLA0KPiA+ICAgICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7DQo+
ID4gICB9DQo+ID4NCj4gPiArc3RhdGljIHVpbnQzMl90IGFzcGVlZF9pbnRjX29yZ2F0ZV9sZXZl
bHMoQXNwZWVkSU5UQ1N0YXRlICpzLCBpbnQNCj4gPiAraW5waW5faWR4KSB7DQo+ID4gKyAgICBB
c3BlZWRJTlRDQ2xhc3MgKmFpYyA9IEFTUEVFRF9JTlRDX0dFVF9DTEFTUyhzKTsNCj4gPiArICAg
IHVpbnQzMl90IGxldmVscyA9IDA7DQo+ID4gKyAgICBpbnQgaTsNCj4gPiArDQo+ID4gKyAgICBm
b3IgKGkgPSAwOyBpIDwgYWljLT5udW1fbGluZXMgJiYgaSA8IDMyOyBpKyspIHsNCj4gPiArICAg
ICAgICBpZiAocy0+b3JnYXRlc1tpbnBpbl9pZHhdLmxldmVsc1tpXSkgew0KPiA+ICsgICAgICAg
ICAgICBsZXZlbHMgfD0gQklUKGkpOw0KPiA+ICsgICAgICAgIH0NCj4gPiArICAgIH0NCj4gPiAr
DQo+ID4gKyAgICByZXR1cm4gbGV2ZWxzOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgdm9p
ZCBhc3BlZWRfaW50Y19kcm9wX3N0YWxlX3BlbmRpbmcoQXNwZWVkSU5UQ1N0YXRlICpzLCBpbnQN
Cj4gPiAraW5waW5faWR4KSB7DQo+ID4gKyAgICBzLT5wZW5kaW5nW2lucGluX2lkeF0gJj0gYXNw
ZWVkX2ludGNfb3JnYXRlX2xldmVscyhzLCBpbnBpbl9pZHgpICYNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBzLT5lbmFibGVbaW5waW5faWR4XTsgfQ0KPiA+ICsNCj4gPiAgIC8q
DQo+ID4gICAgKiBVcGRhdGUgdGhlIHN0YXRlIG9mIGFuIGludGVycnVwdCBjb250cm9sbGVyIHBp
biBieSBzZXR0aW5nDQo+ID4gICAgKiB0aGUgc3BlY2lmaWVkIG91dHB1dCBwaW4gdG8gdGhlIGdp
dmVuIGxldmVsLg0KPiA+IEBAIC0yMzEsNiArMjUyLDggQEAgc3RhdGljIHZvaWQgYXNwZWVkX2lu
dGNfc2V0X2lycSh2b2lkICpvcGFxdWUsIGludCBpcnEsDQo+IGludCBsZXZlbCkNCj4gPiAgICAg
ICB0cmFjZV9hc3BlZWRfaW50Y19zZXRfaXJxKG5hbWUsIGlucGluX2lkeCwgbGV2ZWwpOw0KPiA+
ICAgICAgIGVuYWJsZSA9IHMtPmVuYWJsZVtpbnBpbl9pZHhdOw0KPiA+DQo+ID4gKyAgICBhc3Bl
ZWRfaW50Y19kcm9wX3N0YWxlX3BlbmRpbmcocywgaW5waW5faWR4KTsNCj4gPiArDQo+ID4gICAg
ICAgaWYgKCFsZXZlbCkgew0KPiA+ICAgICAgICAgICByZXR1cm47DQo+ID4gICAgICAgfQ0KPiA+
IEBAIC0zNDMsNiArMzY2LDcgQEAgc3RhdGljIHZvaWQNCj4gYXNwZWVkX2ludGNfc3RhdHVzX2hh
bmRsZXIoQXNwZWVkSU5UQ1N0YXRlICpzLCBod2FkZHIgb2Zmc2V0LA0KPiA+ICAgICAgIC8qIEFs
bCBzb3VyY2UgSVNSIGV4ZWN1dGlvbiBhcmUgZG9uZSAqLw0KPiA+ICAgICAgIGlmICghcy0+cmVn
c1tyZWddKSB7DQo+ID4gICAgICAgICAgIHRyYWNlX2FzcGVlZF9pbnRjX2FsbF9pc3JfZG9uZShu
YW1lLCBpbnBpbl9pZHgpOw0KPiA+ICsgICAgICAgIGFzcGVlZF9pbnRjX2Ryb3Bfc3RhbGVfcGVu
ZGluZyhzLCBpbnBpbl9pZHgpOw0KPiA+ICAgICAgICAgICBpZiAocy0+cGVuZGluZ1tpbnBpbl9p
ZHhdKSB7DQo+ID4gICAgICAgICAgICAgICAvKg0KPiA+ICAgICAgICAgICAgICAgICogaGFuZGxl
IHBlbmRpbmcgc291cmNlIGludGVycnVwdCBAQCAtNDAyLDYgKzQyNiw3IEBADQo+ID4gc3RhdGlj
IHZvaWQgYXNwZWVkX2ludGNfc3RhdHVzX2hhbmRsZXJfbXVsdGlfb3V0cGlucyhBc3BlZWRJTlRD
U3RhdGUgKnMsDQo+ID4gICAgICAgICAgIC8qIEFsbCBzb3VyY2UgSVNSIGV4ZWN1dGlvbnMgYXJl
IGRvbmUgZnJvbSBhIHNwZWNpZmljIGJpdCAqLw0KPiA+ICAgICAgICAgICBpZiAoZGF0YSAmIEJJ
VChpKSkgew0KPiA+ICAgICAgICAgICAgICAgdHJhY2VfYXNwZWVkX2ludGNfYWxsX2lzcl9kb25l
X2JpdChuYW1lLCBpbnBpbl9pZHgsIGkpOw0KPiA+ICsgICAgICAgICAgICBhc3BlZWRfaW50Y19k
cm9wX3N0YWxlX3BlbmRpbmcocywgaW5waW5faWR4KTsNCj4gPiAgICAgICAgICAgICAgIGlmIChz
LT5wZW5kaW5nW2lucGluX2lkeF0gJiBCSVQoaSkpIHsNCj4gPiAgICAgICAgICAgICAgICAgICAv
Kg0KPiA+ICAgICAgICAgICAgICAgICAgICAqIEhhbmRsZSBwZW5kaW5nIHNvdXJjZSBpbnRlcnJ1
cHQuDQoNCg==

