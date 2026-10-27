Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A713606A320
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 01:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=RMNSJrHM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLW8R-0002JU-NT; Mon, 26 Oct 2026 21:37:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xLW8O-0002HR-OX; Mon, 26 Oct 2026 21:37:52 -0400
Received: from mail-japanwestazon11022125.outbound.protection.outlook.com
 ([40.107.75.125] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xLW8M-0003yq-3y; Mon, 26 Oct 2026 21:37:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q5fvptjD10RsAP6uDjqK77liZgen0aMr31NM4yrEq64JfqOn58oNCG5QNRxDlPybTI36BrRiQuEzAbbLm9H9CZCSAFZIGOhuYvxUzD6K5xOx/FxnlOmGbgj2PxvbxYrRPgxGFDe87l3VJrDt7YlA3U7YmgJOvcN7Df1BRFX068FG129z3VASOG1IGEme77SnCcL+Wcl4FxKZfzIWqmhDazX7dDlQze0dukD8qj7cMCctpmDWSd7Id0jVe3D1eWLZI2zmR2jPIV/B/F/FNHw64sye+PLx/aWlOed/p/NDeFBrpalQ6RR65LH9eMIeO3FHkmxb1b4Dbfxp1OmPd/sYvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqKL++jCrINVINHfmieoIuu1qOoDBYk74drRE6IUbCs=;
 b=A7ExMWx57VPUCfD2Wk7OxDQcgTcoZ3fWj6pLs4BWAamknXOOrlG6WKPTKGRM38cPlyMgpamXiftoKUuneYjHaYXY6wTZo/odtIEIhx0+Rz7akFAciaITiEMBlHPUAdEJlQ9irLUqNZfDJQNZ5ryk/9UbYVOF/kMx5gznYVB7Ba37RPNSGyK8UHRSEa6If1qNm3CWNZ2PPSwrG4kppLuv0aT75w8o2nqxZhLGUXEPuP9U2JyXFWvgd/ml42jpYWxlxq6ctro1rlwBIfgNo9SKZJ2h0FIi/9zC3zNSG6nF1IRSqUV0x61ePirHhYciUU+ChV+DbUYCURUPc0iWdKGSMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqKL++jCrINVINHfmieoIuu1qOoDBYk74drRE6IUbCs=;
 b=RMNSJrHMQ0CeHynlJ7P0I9ZEH9AEG9doJevL3f8+SzXWFJdDH4auCzkiKA/4EoO3kZZUpyHYmKsObahiG8iAcu9S2szvAe3Z2O2xlW3DLYJdJ1t78xWt0tMaX8Qjl1kVQIQADueTMilc2mo+0DuPAbDMUH/Lt08cIs+V7K0vSyWfRzvS/xy31nivmpJbM7lEoK693L8Pd9YcmxiqL+7TLx0dvDn+4VK7MsMa0UgxFW0uSv9TQzQt6fWpBKqTvsg4+wTqdxa/uFIeBRQBayxA/49mJ0t9wVV0T79J+aZ5mqtX8Cw7oEfMs72GvOV/KWMRXxMrdLgqLivs0X4LligPDw==
Received: from TYZPR06MB7373.apcprd06.prod.outlook.com (2603:1096:405:a7::14)
 by JH0PR06MB6559.apcprd06.prod.outlook.com (2603:1096:990:2f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.7; Tue, 27 Oct
 2026 01:32:35 +0000
Received: from TYZPR06MB7373.apcprd06.prod.outlook.com
 ([fe80::9b90:c4d9:22de:2ac4]) by TYZPR06MB7373.apcprd06.prod.outlook.com
 ([fe80::9b90:c4d9:22de:2ac4%6]) with mapi id 15.21.0569.006; Tue, 27 Oct 2026
 01:32:35 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1 03/14] hw/block/m25p80: Rename w25q32dw to w25q33pw
Thread-Topic: [PATCH v1 03/14] hw/block/m25p80: Rename w25q32dw to w25q33pw
Thread-Index: AQHdXGn2L8V1TgY+PEeI7EZZXZP+LbcQHXkAgACPVJA=
Date: Tue, 27 Oct 2026 01:32:34 +0000
Message-ID: <TYZPR06MB73734264E93D567EF7AF1E0CFC602@TYZPR06MB7373.apcprd06.prod.outlook.com>
References: <20261015055642.106204-1-jamin_lin@aspeedtech.com>
 <20261015055642.106204-4-jamin_lin@aspeedtech.com>
 <d4a1ce6f-96c9-422f-9380-b8c0bbdfa775@kaod.org>
In-Reply-To: <d4a1ce6f-96c9-422f-9380-b8c0bbdfa775@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB7373:EE_|JH0PR06MB6559:EE_
x-ms-office365-filtering-correlation-id: 563bd005-1b80-431d-e4a4-08df33ca2d89
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|366016|1800799024|261021121427099003|261021123027099003|261022075727099003|10067099003|56012099006|261026121527099003|6133799003|22082099003|18002099003|921020|4143699003|38070700021;
x-microsoft-antispam-message-info: 7aDF+3V1yKcmRatje/2D6OF3ON3JhE0RIVJPgandxAGI0mHLYOvryg14ZHBv8puY7GuAaukH1f3fRT48t0Oqt5u0F+Kz+kBb2bq1fFZv9bv52y9UuXwwkVohuxuXeUVfBAGT2csYD9+47SrOcqRb2Cg1GE7QF/7HHhCyEw8DrAwxn940nDyzfsHP2CCuZBZh2gY2rgBNN12a8S4l2igIHXWBHyA0CzNSNHMsetLChMDSQQtWgJGfPa/YyZvOd0WGoDiqNtwmtJbTK+RySzB8Cya5duMDuiEl9yJr+g+8hyZXIwFei1lCz4iZnLB+5+8JibtP3/HeHTqxUD6TckR9beNyZ3R4F9gnTNKUs0AfTW/o1SEVfdYOMUU43s5ddHF5nPDvTS2Ce+KB5x61gDrWn0ag22+sbhJHaus5xq6D9v1cgQ5fX6xD+XMIsghEtNO0ZySg23u3JuSQWeCxIIE+vV4Ho6H8zULiEeNtPFtwlq2aKnITt0wmWCv5v8782UtSeMP2koTLpFVaz7nk1emjFf7YZToGO1Jpuuo8Ctc3wtM5Gy/ZWH3JqkrJjymaeM3RMB+9wrpR+gzunWQduLrU66kwhyCTM0ZKkgO5fBvfDV4+8dhslc5m/T33tfqqw5zJORAMe7SdWGebfIUeF2Oe73nEQHwk7+J2q8Xi6g1UCB0orItkom3XTgNxPwZDpWFTRohn+YDHVUUWbbfkgnRuugvYbeFtBvUszG/1UNvKOOM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYZPR06MB7373.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(261021121427099003)(261021123027099003)(261022075727099003)(10067099003)(56012099006)(261026121527099003)(6133799003)(22082099003)(18002099003)(921020)(4143699003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHE5L0xhYStXK2tLeWp1bThsK1VabkNGRTV0TFE3OHJIZllkZlJEQVpjTE9O?=
 =?utf-8?B?TUhXL2o3WTNuQW50Vzk3WnV3ZU5MNVVjakhZRzRqeHg5akgzUTkxUjB0bjR3?=
 =?utf-8?B?UEVaK1B3eHVhYS9IaFIvcDlZWGM1WkNMZXRmdUI1ZU14amZ4MEdQNjRVcXIv?=
 =?utf-8?B?bXB5clJtdVJHOG5JZFYrNFJTVVhOaWs4R3kvcThOTTgvT1pINUEzS3V3REsv?=
 =?utf-8?B?QzV1aHMxZ2c2Qm5EN0RTZXhQem9OaWswUjBkV01mYUU4Tkd4N2g3L3VPaDhl?=
 =?utf-8?B?RnloSmplOTdPTEdGajlwZXlHemtXTkI5NXdyZkVQb0JVclFlT0NjcDNJUDh0?=
 =?utf-8?B?WUNkS3BlMURvTWdoWVp5Sk5ja3QvdkZ1MEVPNnVOWDQrOFlvZTRZdlFKemxB?=
 =?utf-8?B?NWVXWHdLZXpWdDE2aDJ1bXVQV2I5ZHZjeXlHVC83SUQ4a2JabHVxOXVoNzNH?=
 =?utf-8?B?TmhPSUpLSTdmMS8rQ2Z4M3BERTV5VjJBTmVzRndvTjhqS0dlNVl1Si9CVkRo?=
 =?utf-8?B?Yk5VUzNXVDZzUURQZTVWZUZ0U0Z1MkRlL0FEVU45V0t6WWp3V0x5MDFHRW1V?=
 =?utf-8?B?Z1A2bndFSEl3aVU0czY2Q3pwQUFLQVFnajNVbUVTOUFDRi9pS1N6TzN4RW9a?=
 =?utf-8?B?a29uOGlvUk5Qc0NoU3R1dktaK09DeWhUbllIcWtQVFA5bisrSjIydnRXM0NH?=
 =?utf-8?B?OWxiSmxHeEJCTldTY05uNUtLbEUydmZJTk5HTGgxbGQ2L2FTejY5K2EyZGRR?=
 =?utf-8?B?TUpLT1c4OG94d1k1Y2RlZVpyT1lWZHRDbDljYUZnT1pwWmZJcE1ta3hoVlFY?=
 =?utf-8?B?bXFaUmVvWjJPYnkvQVgvbWJxVlh4SnpFcXhmaTk2dCtXN2dLdDVRRmhaa05W?=
 =?utf-8?B?ODVLdUZRZ1IwWjF0bEhQckhiYzdRT3FSUnhzYW1KOEtHcUR3dGh4L1FwR1pX?=
 =?utf-8?B?Vm9DcmJaR3M4L1lvVG9xRUJhUU5sS0l2NzRqRTUxTjFvNElxRFljMk9uMTdH?=
 =?utf-8?B?QXVQSFQ1eEx1NXpUc3V4WTMxYkgyRVo4U295UWxQRTFROHlUcm5pUnNVRDlh?=
 =?utf-8?B?TC9UaWlremFDamNWVTNENUIzT2NNYXB2OUdLcG8rVHhSMWlEbWRyd1ViK0pt?=
 =?utf-8?B?R1hBQThBcmRuS0VhQmsxK2paQ2IvWmROWjZCZnp3T3MxekJmSXZkUWVqTlpQ?=
 =?utf-8?B?bjhrYURNcnFkTTBZWGhudVJtS3lkZ0dNYmwzVzZYaG5QSExISElWQm42dTBn?=
 =?utf-8?B?N1NzQVJKS1NJSERRMjY2cll4UFBhSmpoZFRxbG9hK1M0OEdrTE95Y1krS0dx?=
 =?utf-8?B?SlkrUStXazdYNFk1QXh1MjBITm5CbHpsbktERThKUmFzTENQTDdsdk1XWVhz?=
 =?utf-8?B?S0NCcWtacExTdjFQTTA2NzgvYjdORThKendMSFNtblZ1ZmlLTkRVSEZxRjZi?=
 =?utf-8?B?bjVlaHhhWjV1V1llZGpvZWc0NmtRTlRWWTBScFNhRXlmSDVJV3VweE02NlE2?=
 =?utf-8?B?WkdKSE45azl4b2JEalFJZlh4ZUVodVJQd2pReWE1eVJCemdFQ1QyaFNhZGpZ?=
 =?utf-8?B?clpmb1FzMzMvQkVYNjRiNVBnMkMydGE1Ry9pbnkrMDlDWEc3alhBVnB6d2d5?=
 =?utf-8?B?aFRWemF3RkxEcnp6SklGSFp6Vm14eit5Rmc4VmZ1bTJFVk9Qd2M5azJFdnQ2?=
 =?utf-8?B?K1Z1bFhjU0xpYmRobGh4ZFpnOC9KVWFkRGcxUVJDTlkrUzVwMEtkNlh0K3dO?=
 =?utf-8?B?a1grT3JnSzh0T01zb2cydmI2Vm5hUFdtWUhnSUVUUXBEYXUxeHBpa3BZZzBQ?=
 =?utf-8?B?MmFDaVRBVE90c1pXVzZ6VWlQT0Y2bVg0bXgxZXpYeGlScU5IUEZ1Rlk5dFli?=
 =?utf-8?B?Y05HOEtpblJmbE92Nk9FL3pKMTMzWjNKZ1d0Q3FoeUwwUjNYZXFHcXNBeFJz?=
 =?utf-8?B?YUNSTkVqbVNzeGQ4amRDOXhNSFdGTEVtTzZHNXorZmhEUTdiQUttZjNIMUJq?=
 =?utf-8?B?Z05JdFdiWlVaSm1FVE4wNWJCdnVhVXVXbVoxOWVHZm9ZUmR0MUI3dE10a2VC?=
 =?utf-8?B?NXVuNzR0MmJCc1FIeWQzKzhONTcwMVliNnBOcC9BSnpWY1h5d2FMejExWHlv?=
 =?utf-8?B?MEhwbkRzcXZ4NmdlQkNEbWVyTnp0QnpSb1IrMXVGUUF5UlF3OEtJVWZyelBz?=
 =?utf-8?B?UUpBeXU2cVFpU3FOU0txZmVmTUxtTEprVzAwanQzVWpuMG1Dd29mZnJNRmcz?=
 =?utf-8?B?MHd6N0VuSlJlaThFUXN2bmFyc2hSa3NqUnlsYkVMMVMvMEIvMlpHWXhEV3RQ?=
 =?utf-8?B?azJqYWx0OEdLSlNnSFJVcjhpT1pTYlllcDJ5ejdRMUpreWg2ZWF5dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: vD1pDzvZicDgyNiWPsjjQYWVM3cniePNx+18Ry3gyzJpdPRanh8g+fL/6iBO63wO5NlKuWsI9hmeGz4sW5eoooSpjcI66nXSVTVf4QL+Hbt05VO82utDR5Z58Au+rzgI7G1sBLbAUkN9HTJCYRGb7umsY0ladZFwMZ3rUL15zHjuub8WQWllu4Vd4SKJfXktpVfY49EBG2r7nkVxDxmlUGjJ3DB6l54R9g5LououlbN9UwMi4rycTvSUDt3TCVT7hUMn4O4SvQgEp+0x/7fDCri3a/I6unKZB/WrBPZsYQ9sJyDeAi3dJQ1XRbOP289/l/uILBM04PCzppvfmfG71Q==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB7373.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 563bd005-1b80-431d-e4a4-08df33ca2d89
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2026 01:32:34.9448 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wgJjruppzVDAG746RSV/v5HQ5Gsl7hNFimKfEY0AiFc8ydpFsDWc8itUr4/hzwN64Z3/ho9NcDpww4P8VxpVOCAH0/w7JCBYc2NC4xE7dbk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6559
Received-SPF: pass client-ip=40.107.75.125;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMDMvMTRdIGh3L2Jsb2NrL20y
NXA4MDogUmVuYW1lIHcyNXEzMmR3IHRvDQo+IHcyNXEzM3B3DQo+IA0KPiBPbiAxMC8xNS8yNiAw
Nzo1NiwgSmFtaW4gTGluIHdyb3RlOg0KPiA+IFRoZSBXMjVRMzJEVyBhbmQgVzI1UTMzUFcgdXNl
IHRoZSBzYW1lIEpFREVDIElEICgweGVmNjAxNiksIGJ1dA0KPiBoYXZlDQo+ID4gZGlmZmVyZW50
IHBhcnQgbmFtZXMuIFNpbmNlIHRoZSBKRURFQyBJRCBpcyB1c2VkIHRvIHVuaXF1ZWx5IGlkZW50
aWZ5DQo+ID4gYSBmbGFzaCBtb2RlbCBpbiBRRU1VLCBib3RoIHBhcnRzIGNhbm5vdCBiZSBhZGRl
ZCBhcyBzZXBhcmF0ZSBlbnRyaWVzDQo+ID4gd2l0aCB0aGUgc2FtZSBJRC4NCj4gPg0KPiA+IEFj
Y29yZGluZyB0byBXaW5ib25kLCB0aGUgVzI1UTMyRFcgaGFzIGJlZW4gZW5kLW9mLWxpZmUgZm9y
IG1hbnkgeWVhcnMNCj4gPiBhbmQgdGhlIFcyNVEzM1BXIGlzIGl0cyBuZXh0LWdlbmVyYXRpb24g
cmVwbGFjZW1lbnQuIFRoZSBXMjVRMzNQVyBpcw0KPiA+IGNvbXBhdGlibGUgd2l0aCB0aGUgVzI1
UTMyRFcgYW5kIHVzZXMgdGhlIHNhbWUgSkVERUMgSUQuDQo+ID4NCj4gPiBSZW5hbWUgdGhlIGV4
aXN0aW5nIHcyNXEzMmR3IG1vZGVsIHRvIHcyNXEzM3B3IHRvIHJlZmxlY3QgdGhlDQo+ID4gY3Vy
cmVudGx5IHN1cHBvcnRlZCBwYXJ0Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmFtaW4gTGlu
IDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+DQo+ID4gLS0tDQo+ID4gICBody9ibG9jay9tMjVw
ODAuYyB8IDIgKy0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2h3L2Jsb2NrL20yNXA4MC5jIGIvaHcvYmxv
Y2svbTI1cDgwLmMgaW5kZXgNCj4gPiA1NDVlMGI1NzI4Li5lODhlZmQ5MTNiIDEwMDY0NA0KPiA+
IC0tLSBhL2h3L2Jsb2NrL20yNXA4MC5jDQo+ID4gKysrIGIvaHcvYmxvY2svbTI1cDgwLmMNCj4g
PiBAQCAtMzUzLDcgKzM1Myw3IEBAIHN0YXRpYyBjb25zdCBGbGFzaFBhcnRJbmZvIGtub3duX2Rl
dmljZXNbXSA9IHsNCj4gPiAgICAgICB7IElORk8oIncyNXgxNiIsICAgICAgMHhlZjMwMTUsICAg
ICAgMCwgIDY0IDw8IDEwLCAgMzIsDQo+IEVSXzRLKSB9LA0KPiA+ICAgICAgIHsgSU5GTygidzI1
eDMyIiwgICAgICAweGVmMzAxNiwgICAgICAwLCAgNjQgPDwgMTAsICA2NCwNCj4gRVJfNEspIH0s
DQo+ID4gICAgICAgeyBJTkZPKCJ3MjVxMzIiLCAgICAgIDB4ZWY0MDE2LCAgICAgIDAsICA2NCA8
PCAxMCwgIDY0LA0KPiBFUl80SykgfSwNCj4gPiAtICAgIHsgSU5GTygidzI1cTMyZHciLCAgICAw
eGVmNjAxNiwgICAgICAwLCAgNjQgPDwgMTAsICA2NCwgRVJfNEspIH0sDQo+ID4gKyAgICB7IElO
Rk8oIncyNXEzM3B3IiwgICAgMHhlZjYwMTYsICAgICAgMCwgIDY0IDw8IDEwLCAgNjQsDQo+IEVS
XzRLKSB9LA0KPiANCj4gDQo+IEluc3RlYWQgcGxlYXNlIGFkZCBhIG5ldyAidzI1cTMzcHciIGRl
dmljZSBhbmQga2VlcCAidzI1cTMyZHciLg0KPiANClRoYW5rcyBmb3IgdGhlIHJldmlldyBhbmQg
c3VnZ2VzdGlvbi4NCg0KVGhlIHJlYXNvbiBmb3IgcmVuYW1pbmcgdGhlIGRldmljZSBpcyB0aGF0
IGJvdGggdzI1cTMyZHcgYW5kIHcyNXEzM3B3IHVzZSB0aGUgc2FtZSBKRURFQyBJRCAoMHhlZjYw
MTYpLg0KSSBjYW4gYWRkIHcyNXEzM3B3IGFzIGEgbmV3IGZsYXNoIG1vZGVsIGFuZCBrZWVwIHcy
NXEzMmR3LCBzbyBib3RoIG1vZGVscyB3aWxsIHVzZSB0aGUgc2FtZSBKRURFQyBJRC4gSWYgeW91
IGhhdmUgbm8gY29uY2VybnMgYWJvdXQgdGhpcywgSSB3aWxsIHVwZGF0ZSB0aGUgcGF0Y2ggYWNj
b3JkaW5nbHkuDQpBbHRlcm5hdGl2ZWx5LCBJIGNhbiBkcm9wIHRoZSByZW5hbWUgcGF0Y2ggYW5k
IG9ubHkgYWRkIHRoZSBTRkRQIHRhYmxlIHRvIHcyNXEzMmR3LCBzaW5jZSB3MjVxMzNwdyBpcyBj
b21wYXRpYmxlIHdpdGggdzI1cTMyZHcuDQpQbGVhc2Ugbm90ZSB0aGF0IHRoZSBTRkRQIHRhYmxl
IHdhcyBkdW1wZWQgZnJvbSBhIHJlYWwgdzI1cTMzcHcgZmxhc2guIEkgZG9uJ3QgaGF2ZSB0aGUg
U0ZEUCB0YWJsZSBmb3IgdzI1cTMyZHcgYmVjYXVzZSB0aGlzIGRldmljZSBpcyBvbGQgYW5kIGhh
cyByZWFjaGVkIGVuZCBvZiBsaWZlLg0KUGxlYXNlIGxldCBtZSBrbm93IHdoaWNoIGFwcHJvYWNo
IHlvdSBwcmVmZXIuDQoNClRoYW5rcywNCkphbWluDQoNCj4gVGhhbmtzLA0KPiANCj4gQy4NCj4g
DQo+ID4gICAgICAgeyBJTkZPKCJ3MjV4NjQiLCAgICAgIDB4ZWYzMDE3LCAgICAgIDAsICA2NCA8
PCAxMCwgMTI4LA0KPiBFUl80SykgfSwNCj4gPiAgICAgICB7IElORk8oIncyNXE2NCIsICAgICAg
MHhlZjQwMTcsICAgICAgMCwgIDY0IDw8IDEwLCAxMjgsDQo+IEVSXzRLKSB9LA0KPiA+ICAgICAg
IHsgSU5GTygidzI1cTgwIiwgICAgICAweGVmNTAxNCwgICAgICAwLCAgNjQgPDwgMTAsICAxNiwN
Cj4gRVJfNEspIH0sDQoNCg==

