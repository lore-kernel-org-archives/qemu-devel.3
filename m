Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A63EFB7F9
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 05:39:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vul6H-0001hj-6d; Tue, 24 Feb 2026 00:36:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vul68-0001bs-9M; Tue, 24 Feb 2026 00:36:41 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vul63-0001Hd-QQ; Tue, 24 Feb 2026 00:36:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U/Qf7sKHnmF0f4B7AaPVYLuc/Tx1AkSSbr35ud/U5cVeQHS5rS79QRH9bty8riv0nXLaFKQHqTvASnEXQiHz10WNU/lxikCpz5BX8J/otPdQFiQWfsEPlhKqHlw+Khe0QqPT2mNhaAIks4F7pxdKLMGU0jRQIbt+Qwv5FrV8Zx2P7z2N9H4k6BLp5enH0AUnKYZj4S2AKrO3+vgnQBRkOo+dPZaDn4IW+vZnflbjy8DZpAdd05JgTI5JBIIEXNh/m1TFjaxlS8qd7nT9F2it5TkBIDvGKC7GKh7JyH4lvA52ZY33VA7Lx5ObuvNsIgkKbZvAX2f6CYPE6xIb4NRxPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SoPzQTejXFTqYoC2Du+97jQIn228t1ReBuQeEWAjZR0=;
 b=H8Zk+30JywdM/MzIUpfr2Q1pzLMTv1o0NW1Ie2gyBDwJHmuFmLmIpEXrVemS+FLtfXSfPMH9IoY6W6smouslcHoyiJEWRUxx9Exo+FD4Cqb64ctCDZyQhH+UpsmWbir8auMoBanG2+ZpthqzCd2c7zLqk1dYKdE6B+UgwXCKD01no612KH3fqiYPQ47XPbB5d6I81WS7S7CNXPdoTERVTOcZtWDdg4U8nEUO2B/2k3T/jHYFxki+ajux/MoFDBnUNdydLt7tmUGg/nj9UOCHBOEeTpDaGRpR99WJjgjjCkx4JUoi4r7nHeV7jF5qmToMz7zClAmJt6BVSqwaCQdMtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SoPzQTejXFTqYoC2Du+97jQIn228t1ReBuQeEWAjZR0=;
 b=Rk9Ft/iG35Q9h1CHa4PQoD2yv/ojb9Epwr/egkz4F97m97XAVKJ3V1Y2iP1DYzbFr0wTrw72bDIK5cHcnucrGqZUme/WMnFH1TZ18ViN4M+VQOQwMQyLmoNlv0t0FV2BrXGpLFYAcJwTc3kkpqduE+qQ0jeDNGGv2cgQojm8K6oXnum0TIpTXiqk+idQptaVB0rHP32kPyqa2gDonpWLobzOu7E6R3mj72xoX4OHc7qSmSJ2rreODXxdKEccU7dO07wtrA/0vuJ+HCbIoYNW1qSvFysBQ5rX6Xkr2M3Mz7IxX3JBZNLRnuIK49MQbwln7Vz0tntapckSNG+F4KhiNg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB5179.apcprd06.prod.outlook.com (2603:1096:400:1f8::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 05:36:21 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 05:36:21 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, =?iso-8859-1?Q?Marc-Andr=E9_Lureau?=
 <marcandre.lureau@redhat.com>, =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?=
 <berrange@redhat.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, "komlodi@google.com" <komlodi@google.com>
Subject: [PATCH v6 04/22] hw/i3c: Split DesignWare I3C out of Aspeed I3C
Thread-Topic: [PATCH v6 04/22] hw/i3c: Split DesignWare I3C out of Aspeed I3C
Thread-Index: AQHcpU+BQRDQBLyuSEKRrhO+Ybct5A==
Date: Tue, 24 Feb 2026 05:36:20 +0000
Message-ID: <20260224053613.589102-5-jamin_lin@aspeedtech.com>
References: <20260224053613.589102-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260224053613.589102-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYZPR06MB5179:EE_
x-ms-office365-filtering-correlation-id: 0c0b097f-a538-4fcf-9d2d-08de7366a412
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?4ogEXw9qkI/Cmqa+UsNEsBPtS8j1uEll49HJ3LSq/EeVkh9iDHEmCtyuHE?=
 =?iso-8859-1?Q?YdBQPkkV+1cQ+JYYUvhO0BQUbB7csAnYNPRfhMrLGsePm11pbpaSQ/cKCp?=
 =?iso-8859-1?Q?p85XTO8bron+GCYLvvC1U9Bu+MRA8y28l70/hDFC4ewHAi/p8Udxkk6hul?=
 =?iso-8859-1?Q?m9CueC+SeZ7+8hBWPQ6DbjKK8pRTePk3QqlsCzlm/Dts1IdG2/htu3t3UA?=
 =?iso-8859-1?Q?PPqthecN6ASHGvR78YORj4m4JZ2lKlv8vC7I73zrPvkANk502UOp7taTsg?=
 =?iso-8859-1?Q?9STT52O+DyJV6C4G0gsereozJjMvaWGimOpfE1q0Sljy4wsp+F73PFfkTO?=
 =?iso-8859-1?Q?PkJp1w5YUu8AMLlMLSABHHLGagaD2ncX0yKHq+zKqk5/sHdo9f3eWoHkKX?=
 =?iso-8859-1?Q?1Fxpt2S2diLBo5/gNP/s4SQKoPv8AIIc3tS5y6EVl5BsKZU+qJNSLl9N1q?=
 =?iso-8859-1?Q?17Lq0g+oBmabOoSxG8NM9AEhRx81AZ+VX43aFagsNmsu1b/i6NTfyvVi47?=
 =?iso-8859-1?Q?BmPybwItwT1GpdD59IGtb5RrPih7DpzOhmOqiRqbCRNZoxWOFeRioChGWW?=
 =?iso-8859-1?Q?gmgCpq8udpEYtVuSWveiCZpM8ipzC2g/A5eOV7TsUhw7HF/HK/5OyOajXa?=
 =?iso-8859-1?Q?hHBMMU062DKZLyX0v43gr1rrj/PKPEbiChL34lHgb5Jl3ixLtw3jCGN799?=
 =?iso-8859-1?Q?I/oJhS5yYyvux9Qa+YK8pbAnuwmKgOz2DxYMZCuuIaLYphDXeNDU8AxVb+?=
 =?iso-8859-1?Q?9bQC4hBY7hGDMj4rRw2p3i4rhtDMpcCoeJUxEjNuIqxF6xejm+bZe0Hy4o?=
 =?iso-8859-1?Q?uW8ZDVAr6y8W8uGIyFGJ/O6ah+E5Xl1h8Fps4K8848sJ6GQafE/hawIvXH?=
 =?iso-8859-1?Q?td51I3z91y/nAKGKPhiru4Hr7Eg/nHRNJPUZhoCBEuKXq0Zm3XFzLtl3nC?=
 =?iso-8859-1?Q?lHB41IV0rLr6FMOopuB8Jxa9WXviSI0sTIxqwkZtJSRSJD7McdRH2t9tuG?=
 =?iso-8859-1?Q?QX/JvyJgVO5Zz7+liVEnR6sNmigXvtyEYO6M30edtaqb8XZh38/oaRXPiX?=
 =?iso-8859-1?Q?qNZyVZ1vtkHGir8QSU4VZBUBklXaIrEG3W+R77XPkjVlHiq/zJ3Zy1EFtl?=
 =?iso-8859-1?Q?mAcSdrueWoZDKYjBrxTDoPVNgpYEpHmYst32+srpyo0Y1/JY2StCD7q02t?=
 =?iso-8859-1?Q?Y0AU84f6iEwofbsn5qEkjevzjv8kqorK7DY0IERj7XCicU9bVNljBv3Kld?=
 =?iso-8859-1?Q?naUdLCyeaIYUV6Ao0UDzyI641q4F8vJ+MLrbUaQio2T7itrPsg0x9RpNs+?=
 =?iso-8859-1?Q?IMdqsLgtlrdDH9Uc3Bk9HOt8EK1NNca10TQt3y0CVrJjkmsUxSQ+ugahn+?=
 =?iso-8859-1?Q?lb5egLqUs/MXgfFUmdXqTkCqPbveMyavbQH9WAJAMAPWUbmZTESeQkjKsd?=
 =?iso-8859-1?Q?/OGUAdF+hR/WXm+CvmaQgHw99+TDmdCRN6uo/Kf2LDzUbkZUPjZQgAGX3N?=
 =?iso-8859-1?Q?avYaSVXHHoQRSyWE1mogtF9mlhTwfvXmyF1wRf5zxMhk+HOkZwLGwIbFT+?=
 =?iso-8859-1?Q?MCFLZIM/EsL1/TSBj+kzoDoo3NYeJaFj4dT4/5ZNZmwtQn7vfZN5xeQC2U?=
 =?iso-8859-1?Q?WvjbChlJGjzRfIvYh7fRsr9hN9l83ZtX2UrREU/K/iwQXuVJsc8l9Ny5Bb?=
 =?iso-8859-1?Q?fIVsNZ+RKCDj/dWoBuc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2ay0EKG6/mqmD4dR9RSrN1hNlvKRT6Bhiq6I3queYP/0jcQ8XWbq2Mb67+?=
 =?iso-8859-1?Q?IZ7Kiu0/YQoLMYTl4ah+inCAw6UJHFRBpPzHpfu9F7JuXVgtBt8fgEUx95?=
 =?iso-8859-1?Q?EVww3fIhZpqMWDIAmUZ/rtY1qKznOT9DRzXw2V9NfHfMLxGb3yeDq8ZzsI?=
 =?iso-8859-1?Q?7QUWnbp0wFAokz+b9/AAFcvCtf7yHI45iaDqFPyVr0pFBP/yxQpaxGbciR?=
 =?iso-8859-1?Q?H7q5jCry6UAurbPvXm3AJFkYVPX5XxCYgleo/ge66BfepFB3IKq6BbBAFd?=
 =?iso-8859-1?Q?Tpf38RPmaNpaRVmtEjSeeTpr9ThPoK0//iKqzlSaK0boXvVcTzZe6Nfmqq?=
 =?iso-8859-1?Q?8P39L3TTAkGi/oDN8tbG3gOptpJlHqHZVBcNInd4TttTEPkDKk/Oa4yNV4?=
 =?iso-8859-1?Q?qEm6UbElyuJD99cH7Q5pWwrEf3Ypv62Fv/h74B2hkLpbceoHpUI2cpYhWP?=
 =?iso-8859-1?Q?tOMCkDsqVh4iS1TMitix3ebE09oiJKF8dIHa7g7NwUne10DaDG7kqukQcf?=
 =?iso-8859-1?Q?FI+9JVygSFoLPLEhA7WMu/V74nvAXx7S5LCa7GXOHhU2sBGlA4IlGpUmnf?=
 =?iso-8859-1?Q?nhm1ouki09xQyoHy+jZZlngCQsN1nR+bt/3Tz6CqVceNrRDekGoASAtSRy?=
 =?iso-8859-1?Q?yHYJQVlC2dTFQvYWc+wNKLqOW6DjTlU00FiZ3/SZx4o+Lkme9xoUUCKo2o?=
 =?iso-8859-1?Q?REhCLQPK6GCmfmEQMtJaAQzFr+m27lmvqGByizYdTaRS93lGL/OCW8MNg3?=
 =?iso-8859-1?Q?eaUYYNEsR2+zORK17psLWeCZbnnNU3A1AvZRJiA+71Bqu5yKbCiikxg/ve?=
 =?iso-8859-1?Q?uHsFgACXY84X+wVljHe3qjKK4mo2h9lXNyWNZKpTA0xgtEMmnwOszp6fcp?=
 =?iso-8859-1?Q?JgJ3QZuEAUPZvJmvR57GEI4D76s4/3TGsCfMawe4hTLN2GRRDEUmAc8lk7?=
 =?iso-8859-1?Q?oIcf/XxXTQg/hYDQ5RxzXZ2eO4xH1juskLVrnnk4OSkCJ0Vyptz/680XEB?=
 =?iso-8859-1?Q?AlFsUO/yG8Dl80WTWNFlfC2ucx8+65yheRoB0uW7be14odz2cwfxEBU9tI?=
 =?iso-8859-1?Q?vBu/0FzsiDcgH+9aHLkVnYRc4uxXtE1dMlGBhxiLL8o2xcCiDLp8Z+coCE?=
 =?iso-8859-1?Q?UlRy07JFGRf3AcBf620JlI+GxY9zHeoqgcy8C7cbNzw6APjiag9vHkbfHc?=
 =?iso-8859-1?Q?EaEEF7MGlSI3z004pnXufVih+Eneg+knyag/N1yx4cA2kjwfFe43I6J4jX?=
 =?iso-8859-1?Q?Kn2/lwd3cle25CV7NGxYLL3jeTa1O1Wh4zeL5KaeFzkFvzIKe7Dy1XWzNS?=
 =?iso-8859-1?Q?tGVaXMRQOKRfJDwBid7cSi0fmUQrK/b2xE4unQlppIXUr52ujtq2S8E2HE?=
 =?iso-8859-1?Q?oHISb8A/iukVER+c2hFxNhqk+SEvbrbv8XfNiszSB1hZWLzkus12Z5kBWf?=
 =?iso-8859-1?Q?nHU4nhVD/wpTN6z6lFwiyxtDIO4aX3WE/MKufWMDf04okqMqCB9uc6oghL?=
 =?iso-8859-1?Q?EjnsPEiTnGv+vwd5Ur4fPl6orAalGtTFKdJ1tVBudlof3PZa0DI/Teel4p?=
 =?iso-8859-1?Q?SBMmu8skv/HWXveSbtplFYzjI6pUDXBZ+PdNUR+jyeDyXT//tc88aDfIR1?=
 =?iso-8859-1?Q?2y8qb7FYIQhjBK7Xd4/AOU1wKDL5PEzj44EiBQZmb3Uu5uCtWZI/jtcDHm?=
 =?iso-8859-1?Q?QhgPzMOT+RTt1FQVK7QTMRlQJc7MdRCbG4ieqdWK7UDur9Zs5NhAsk6jKj?=
 =?iso-8859-1?Q?OWMPCjjGsYzYB3VcYOHwnlbUcwqZ4ZOpmF/+j7yzl96I4dNkAPxCIDFnX6?=
 =?iso-8859-1?Q?oWFQeKAyWw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c0b097f-a538-4fcf-9d2d-08de7366a412
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 05:36:20.9696 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b934B1rfWTq5edTggRYWRXZafj6vZXCMhLuWhwx1Co67I4UQRyhrQiIi8B4o8FyVkc7sZlilq1mudUJNYWgOoTM5ox67lNVeOOh253sUP5Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5179
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

The Aspeed I3C IP block is technically an Aspeed IP block that manages=0A=
6 DW I3C controllers.=0A=
=0A=
To help reflect this better and to make it easier for other SoCs to use=0A=
the DW I3C model, we'll split out the DW portion from the Aspeed=0A=
portion.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/i3c/aspeed_i3c.h |  17 +--=0A=
 include/hw/i3c/dw-i3c.h     |  33 ++++++=0A=
 hw/i3c/aspeed_i3c.c         | 181 +-------------------------------=0A=
 hw/i3c/dw-i3c.c             | 202 ++++++++++++++++++++++++++++++++++++=0A=
 hw/arm/Kconfig              |   1 +=0A=
 hw/i3c/Kconfig              |   3 +=0A=
 hw/i3c/meson.build          |   1 +=0A=
 hw/i3c/trace-events         |   6 +-=0A=
 8 files changed, 250 insertions(+), 194 deletions(-)=0A=
 create mode 100644 include/hw/i3c/dw-i3c.h=0A=
 create mode 100644 hw/i3c/dw-i3c.c=0A=
=0A=
diff --git a/include/hw/i3c/aspeed_i3c.h b/include/hw/i3c/aspeed_i3c.h=0A=
index bd0ffc84ea..ade5c42d39 100644=0A=
--- a/include/hw/i3c/aspeed_i3c.h=0A=
+++ b/include/hw/i3c/aspeed_i3c.h=0A=
@@ -10,27 +10,15 @@=0A=
 #ifndef ASPEED_I3C_H=0A=
 #define ASPEED_I3C_H=0A=
 =0A=
+#include "hw/i3c/dw-i3c.h"=0A=
 #include "hw/core/sysbus.h"=0A=
 =0A=
 #define TYPE_ASPEED_I3C "aspeed.i3c"=0A=
-#define TYPE_ASPEED_I3C_DEVICE "aspeed.i3c.device"=0A=
 OBJECT_DECLARE_TYPE(AspeedI3CState, AspeedI3CClass, ASPEED_I3C)=0A=
 =0A=
 #define ASPEED_I3C_NR_REGS (0x70 >> 2)=0A=
-#define ASPEED_I3C_DEVICE_NR_REGS (0x300 >> 2)=0A=
 #define ASPEED_I3C_NR_DEVICES 6=0A=
 =0A=
-OBJECT_DECLARE_SIMPLE_TYPE(AspeedI3CDevice, ASPEED_I3C_DEVICE)=0A=
-struct AspeedI3CDevice {=0A=
-    SysBusDevice parent_obj;=0A=
-=0A=
-    MemoryRegion mr;=0A=
-    qemu_irq irq;=0A=
-=0A=
-    uint8_t id;=0A=
-    uint32_t regs[ASPEED_I3C_DEVICE_NR_REGS];=0A=
-};=0A=
-=0A=
 struct AspeedI3CState {=0A=
     SysBusDevice parent_obj;=0A=
 =0A=
@@ -39,6 +27,7 @@ struct AspeedI3CState {=0A=
     qemu_irq irq;=0A=
 =0A=
     uint32_t regs[ASPEED_I3C_NR_REGS];=0A=
-    AspeedI3CDevice devices[ASPEED_I3C_NR_DEVICES];=0A=
+    DWI3C devices[ASPEED_I3C_NR_DEVICES];=0A=
+    uint8_t id;=0A=
 };=0A=
 #endif /* ASPEED_I3C_H */=0A=
diff --git a/include/hw/i3c/dw-i3c.h b/include/hw/i3c/dw-i3c.h=0A=
new file mode 100644=0A=
index 0000000000..7143e8ca7a=0A=
--- /dev/null=0A=
+++ b/include/hw/i3c/dw-i3c.h=0A=
@@ -0,0 +1,33 @@=0A=
+/*=0A=
+ * DesignWare I3C Controller=0A=
+ *=0A=
+ * Copyright (C) 2021 ASPEED Technology Inc.=0A=
+ * Copyright (C) 2025 Google, LLC.=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ */=0A=
+=0A=
+#ifndef DW_I3C_H=0A=
+#define DW_I3C_H=0A=
+=0A=
+#include "hw/core/sysbus.h"=0A=
+=0A=
+#define TYPE_DW_I3C "dw.i3c"=0A=
+OBJECT_DECLARE_SIMPLE_TYPE(DWI3C, DW_I3C)=0A=
+=0A=
+#define DW_I3C_NR_REGS (0x300 >> 2)=0A=
+=0A=
+struct DWI3C {=0A=
+    SysBusDevice parent_obj;=0A=
+=0A=
+    MemoryRegion mr;=0A=
+    qemu_irq irq;=0A=
+=0A=
+    uint8_t id;=0A=
+    uint32_t regs[DW_I3C_NR_REGS];=0A=
+};=0A=
+=0A=
+/* Extern for other controllers that use DesignWare I3C. */=0A=
+extern const VMStateDescription vmstate_dw_i3c;=0A=
+=0A=
+#endif /* DW_I3C_H */=0A=
diff --git a/hw/i3c/aspeed_i3c.c b/hw/i3c/aspeed_i3c.c=0A=
index e7cdfbfdbd..647074d181 100644=0A=
--- a/hw/i3c/aspeed_i3c.c=0A=
+++ b/hw/i3c/aspeed_i3c.c=0A=
@@ -2,6 +2,7 @@=0A=
  * ASPEED I3C Controller=0A=
  *=0A=
  * Copyright (C) 2021 ASPEED Technology Inc.=0A=
+ * Copyright (C) 2025 Google, LLC.=0A=
  *=0A=
  * This code is licensed under the GPL version 2 or later.  See=0A=
  * the COPYING file in the top-level directory.=0A=
@@ -43,162 +44,6 @@ REG32(I3C6_REG1, 0x64)=0A=
     FIELD(I3C6_REG1, I2C_MODE,  0,  1)=0A=
     FIELD(I3C6_REG1, SA_EN,     15, 1)=0A=
 =0A=
-/* I3C Device Registers */=0A=
-REG32(DEVICE_CTRL,                  0x00)=0A=
-REG32(DEVICE_ADDR,                  0x04)=0A=
-REG32(HW_CAPABILITY,                0x08)=0A=
-REG32(COMMAND_QUEUE_PORT,           0x0c)=0A=
-REG32(RESPONSE_QUEUE_PORT,          0x10)=0A=
-REG32(RX_TX_DATA_PORT,              0x14)=0A=
-REG32(IBI_QUEUE_STATUS,             0x18)=0A=
-REG32(IBI_QUEUE_DATA,               0x18)=0A=
-REG32(QUEUE_THLD_CTRL,              0x1c)=0A=
-REG32(DATA_BUFFER_THLD_CTRL,        0x20)=0A=
-REG32(IBI_QUEUE_CTRL,               0x24)=0A=
-REG32(IBI_MR_REQ_REJECT,            0x2c)=0A=
-REG32(IBI_SIR_REQ_REJECT,           0x30)=0A=
-REG32(RESET_CTRL,                   0x34)=0A=
-REG32(SLV_EVENT_CTRL,               0x38)=0A=
-REG32(INTR_STATUS,                  0x3c)=0A=
-REG32(INTR_STATUS_EN,               0x40)=0A=
-REG32(INTR_SIGNAL_EN,               0x44)=0A=
-REG32(INTR_FORCE,                   0x48)=0A=
-REG32(QUEUE_STATUS_LEVEL,           0x4c)=0A=
-REG32(DATA_BUFFER_STATUS_LEVEL,     0x50)=0A=
-REG32(PRESENT_STATE,                0x54)=0A=
-REG32(CCC_DEVICE_STATUS,            0x58)=0A=
-REG32(DEVICE_ADDR_TABLE_POINTER,    0x5c)=0A=
-    FIELD(DEVICE_ADDR_TABLE_POINTER, DEPTH, 16, 16)=0A=
-    FIELD(DEVICE_ADDR_TABLE_POINTER, ADDR,  0,  16)=0A=
-REG32(DEV_CHAR_TABLE_POINTER,       0x60)=0A=
-REG32(VENDOR_SPECIFIC_REG_POINTER,  0x6c)=0A=
-REG32(SLV_MIPI_PID_VALUE,           0x70)=0A=
-REG32(SLV_PID_VALUE,                0x74)=0A=
-REG32(SLV_CHAR_CTRL,                0x78)=0A=
-REG32(SLV_MAX_LEN,                  0x7c)=0A=
-REG32(MAX_READ_TURNAROUND,          0x80)=0A=
-REG32(MAX_DATA_SPEED,               0x84)=0A=
-REG32(SLV_DEBUG_STATUS,             0x88)=0A=
-REG32(SLV_INTR_REQ,                 0x8c)=0A=
-REG32(DEVICE_CTRL_EXTENDED,         0xb0)=0A=
-REG32(SCL_I3C_OD_TIMING,            0xb4)=0A=
-REG32(SCL_I3C_PP_TIMING,            0xb8)=0A=
-REG32(SCL_I2C_FM_TIMING,            0xbc)=0A=
-REG32(SCL_I2C_FMP_TIMING,           0xc0)=0A=
-REG32(SCL_EXT_LCNT_TIMING,          0xc8)=0A=
-REG32(SCL_EXT_TERMN_LCNT_TIMING,    0xcc)=0A=
-REG32(BUS_FREE_TIMING,              0xd4)=0A=
-REG32(BUS_IDLE_TIMING,              0xd8)=0A=
-REG32(I3C_VER_ID,                   0xe0)=0A=
-REG32(I3C_VER_TYPE,                 0xe4)=0A=
-REG32(EXTENDED_CAPABILITY,          0xe8)=0A=
-REG32(SLAVE_CONFIG,                 0xec)=0A=
-=0A=
-static const uint32_t ast2600_i3c_device_resets[ASPEED_I3C_DEVICE_NR_REGS]=
 =3D {=0A=
-    [R_HW_CAPABILITY]               =3D 0x000e00bf,=0A=
-    [R_QUEUE_THLD_CTRL]             =3D 0x01000101,=0A=
-    [R_I3C_VER_ID]                  =3D 0x3130302a,=0A=
-    [R_I3C_VER_TYPE]                =3D 0x6c633033,=0A=
-    [R_DEVICE_ADDR_TABLE_POINTER]   =3D 0x00080280,=0A=
-    [R_DEV_CHAR_TABLE_POINTER]      =3D 0x00020200,=0A=
-    [A_VENDOR_SPECIFIC_REG_POINTER] =3D 0x000000b0,=0A=
-    [R_SLV_MAX_LEN]                 =3D 0x00ff00ff,=0A=
-};=0A=
-=0A=
-static uint64_t aspeed_i3c_device_read(void *opaque, hwaddr offset,=0A=
-                                       unsigned size)=0A=
-{=0A=
-    AspeedI3CDevice *s =3D ASPEED_I3C_DEVICE(opaque);=0A=
-    uint32_t addr =3D offset >> 2;=0A=
-    uint64_t value;=0A=
-=0A=
-    switch (addr) {=0A=
-    case R_COMMAND_QUEUE_PORT:=0A=
-        value =3D 0;=0A=
-        break;=0A=
-    default:=0A=
-        value =3D s->regs[addr];=0A=
-        break;=0A=
-    }=0A=
-=0A=
-    trace_aspeed_i3c_device_read(s->id, offset, value);=0A=
-=0A=
-    return value;=0A=
-}=0A=
-=0A=
-static void aspeed_i3c_device_write(void *opaque, hwaddr offset,=0A=
-                                    uint64_t value, unsigned size)=0A=
-{=0A=
-    AspeedI3CDevice *s =3D ASPEED_I3C_DEVICE(opaque);=0A=
-    uint32_t addr =3D offset >> 2;=0A=
-=0A=
-    trace_aspeed_i3c_device_write(s->id, offset, value);=0A=
-=0A=
-    switch (addr) {=0A=
-    case R_HW_CAPABILITY:=0A=
-    case R_RESPONSE_QUEUE_PORT:=0A=
-    case R_IBI_QUEUE_DATA:=0A=
-    case R_QUEUE_STATUS_LEVEL:=0A=
-    case R_PRESENT_STATE:=0A=
-    case R_CCC_DEVICE_STATUS:=0A=
-    case R_DEVICE_ADDR_TABLE_POINTER:=0A=
-    case R_VENDOR_SPECIFIC_REG_POINTER:=0A=
-    case R_SLV_CHAR_CTRL:=0A=
-    case R_SLV_MAX_LEN:=0A=
-    case R_MAX_READ_TURNAROUND:=0A=
-    case R_I3C_VER_ID:=0A=
-    case R_I3C_VER_TYPE:=0A=
-    case R_EXTENDED_CAPABILITY:=0A=
-        qemu_log_mask(LOG_GUEST_ERROR,=0A=
-                      "%s: write to readonly register[0x%02" HWADDR_PRIx=
=0A=
-                      "] =3D 0x%08" PRIx64 "\n",=0A=
-                      __func__, offset, value);=0A=
-        break;=0A=
-    case R_RX_TX_DATA_PORT:=0A=
-        break;=0A=
-    case R_RESET_CTRL:=0A=
-        break;=0A=
-    default:=0A=
-        s->regs[addr] =3D value;=0A=
-        break;=0A=
-    }=0A=
-}=0A=
-=0A=
-static const VMStateDescription aspeed_i3c_device_vmstate =3D {=0A=
-    .name =3D TYPE_ASPEED_I3C,=0A=
-    .version_id =3D 1,=0A=
-    .minimum_version_id =3D 1,=0A=
-    .fields =3D (const VMStateField[]){=0A=
-        VMSTATE_UINT32_ARRAY(regs, AspeedI3CDevice, ASPEED_I3C_DEVICE_NR_R=
EGS),=0A=
-        VMSTATE_END_OF_LIST(),=0A=
-    }=0A=
-};=0A=
-=0A=
-static const MemoryRegionOps aspeed_i3c_device_ops =3D {=0A=
-    .read =3D aspeed_i3c_device_read,=0A=
-    .write =3D aspeed_i3c_device_write,=0A=
-    .endianness =3D DEVICE_LITTLE_ENDIAN,=0A=
-};=0A=
-=0A=
-static void aspeed_i3c_device_reset(DeviceState *dev)=0A=
-{=0A=
-    AspeedI3CDevice *s =3D ASPEED_I3C_DEVICE(dev);=0A=
-=0A=
-    memcpy(s->regs, ast2600_i3c_device_resets, sizeof(s->regs));=0A=
-}=0A=
-=0A=
-static void aspeed_i3c_device_realize(DeviceState *dev, Error **errp)=0A=
-{=0A=
-    AspeedI3CDevice *s =3D ASPEED_I3C_DEVICE(dev);=0A=
-    g_autofree char *name =3D g_strdup_printf(TYPE_ASPEED_I3C_DEVICE ".%d"=
,=0A=
-                                            s->id);=0A=
-=0A=
-    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);=0A=
-=0A=
-    memory_region_init_io(&s->mr, OBJECT(s), &aspeed_i3c_device_ops,=0A=
-                          s, name, ASPEED_I3C_DEVICE_NR_REGS << 2);=0A=
-}=0A=
-=0A=
 static uint64_t aspeed_i3c_read(void *opaque, hwaddr addr, unsigned int si=
ze)=0A=
 {=0A=
     AspeedI3CState *s =3D ASPEED_I3C(opaque);=0A=
@@ -275,7 +120,7 @@ static void aspeed_i3c_instance_init(Object *obj)=0A=
 =0A=
     for (i =3D 0; i < ASPEED_I3C_NR_DEVICES; ++i) {=0A=
         object_initialize_child(obj, "device[*]", &s->devices[i],=0A=
-                TYPE_ASPEED_I3C_DEVICE);=0A=
+                TYPE_DW_I3C);=0A=
     }=0A=
 }=0A=
 =0A=
@@ -323,20 +168,6 @@ static void aspeed_i3c_realize(DeviceState *dev, Error=
 **errp)=0A=
 =0A=
 }=0A=
 =0A=
-static const Property aspeed_i3c_device_properties[] =3D {=0A=
-    DEFINE_PROP_UINT8("device-id", AspeedI3CDevice, id, 0),=0A=
-};=0A=
-=0A=
-static void aspeed_i3c_device_class_init(ObjectClass *klass, const void *d=
ata)=0A=
-{=0A=
-    DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
-=0A=
-    dc->desc =3D "Aspeed I3C Device";=0A=
-    dc->realize =3D aspeed_i3c_device_realize;=0A=
-    device_class_set_legacy_reset(dc, aspeed_i3c_device_reset);=0A=
-    device_class_set_props(dc, aspeed_i3c_device_properties);=0A=
-}=0A=
-=0A=
 static const VMStateDescription vmstate_aspeed_i3c =3D {=0A=
     .name =3D TYPE_ASPEED_I3C,=0A=
     .version_id =3D 1,=0A=
@@ -344,7 +175,7 @@ static const VMStateDescription vmstate_aspeed_i3c =3D =
{=0A=
     .fields =3D (const VMStateField[]) {=0A=
         VMSTATE_UINT32_ARRAY(regs, AspeedI3CState, ASPEED_I3C_NR_REGS),=0A=
         VMSTATE_STRUCT_ARRAY(devices, AspeedI3CState, ASPEED_I3C_NR_DEVICE=
S, 1,=0A=
-                             aspeed_i3c_device_vmstate, AspeedI3CDevice),=
=0A=
+                             vmstate_dw_i3c, DWI3C),=0A=
         VMSTATE_END_OF_LIST(),=0A=
     }=0A=
 };=0A=
@@ -367,12 +198,6 @@ static const TypeInfo aspeed_i3c_types[] =3D {=0A=
         .instance_size =3D sizeof(AspeedI3CState),=0A=
         .class_init =3D aspeed_i3c_class_init,=0A=
     },=0A=
-    {=0A=
-        .name =3D TYPE_ASPEED_I3C_DEVICE,=0A=
-        .parent =3D TYPE_SYS_BUS_DEVICE,=0A=
-        .instance_size =3D sizeof(AspeedI3CDevice),=0A=
-        .class_init =3D aspeed_i3c_device_class_init,=0A=
-    },=0A=
 };=0A=
 =0A=
 DEFINE_TYPES(aspeed_i3c_types)=0A=
diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c=0A=
new file mode 100644=0A=
index 0000000000..6cadc59191=0A=
--- /dev/null=0A=
+++ b/hw/i3c/dw-i3c.c=0A=
@@ -0,0 +1,202 @@=0A=
+/*=0A=
+ * DesignWare I3C Controller=0A=
+ *=0A=
+ * Copyright (C) 2021 ASPEED Technology Inc.=0A=
+ * Copyright (C) 2025 Google, LLC=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ */=0A=
+=0A=
+#include "qemu/osdep.h"=0A=
+#include "qemu/log.h"=0A=
+#include "qemu/error-report.h"=0A=
+#include "hw/i3c/i3c.h"=0A=
+#include "hw/i3c/dw-i3c.h"=0A=
+#include "hw/core/registerfields.h"=0A=
+#include "hw/core/qdev-properties.h"=0A=
+#include "qapi/error.h"=0A=
+#include "migration/vmstate.h"=0A=
+#include "trace.h"=0A=
+=0A=
+REG32(DEVICE_CTRL,                  0x00)=0A=
+REG32(DEVICE_ADDR,                  0x04)=0A=
+REG32(HW_CAPABILITY,                0x08)=0A=
+REG32(COMMAND_QUEUE_PORT,           0x0c)=0A=
+REG32(RESPONSE_QUEUE_PORT,          0x10)=0A=
+REG32(RX_TX_DATA_PORT,              0x14)=0A=
+REG32(IBI_QUEUE_STATUS,             0x18)=0A=
+REG32(IBI_QUEUE_DATA,               0x18)=0A=
+REG32(QUEUE_THLD_CTRL,              0x1c)=0A=
+REG32(DATA_BUFFER_THLD_CTRL,        0x20)=0A=
+REG32(IBI_QUEUE_CTRL,               0x24)=0A=
+REG32(IBI_MR_REQ_REJECT,            0x2c)=0A=
+REG32(IBI_SIR_REQ_REJECT,           0x30)=0A=
+REG32(RESET_CTRL,                   0x34)=0A=
+REG32(SLV_EVENT_CTRL,               0x38)=0A=
+REG32(INTR_STATUS,                  0x3c)=0A=
+REG32(INTR_STATUS_EN,               0x40)=0A=
+REG32(INTR_SIGNAL_EN,               0x44)=0A=
+REG32(INTR_FORCE,                   0x48)=0A=
+REG32(QUEUE_STATUS_LEVEL,           0x4c)=0A=
+REG32(DATA_BUFFER_STATUS_LEVEL,     0x50)=0A=
+REG32(PRESENT_STATE,                0x54)=0A=
+REG32(CCC_DEVICE_STATUS,            0x58)=0A=
+REG32(DEVICE_ADDR_TABLE_POINTER,    0x5c)=0A=
+    FIELD(DEVICE_ADDR_TABLE_POINTER, DEPTH, 16, 16)=0A=
+    FIELD(DEVICE_ADDR_TABLE_POINTER, ADDR,  0,  16)=0A=
+REG32(DEV_CHAR_TABLE_POINTER,       0x60)=0A=
+REG32(VENDOR_SPECIFIC_REG_POINTER,  0x6c)=0A=
+REG32(SLV_MIPI_PID_VALUE,           0x70)=0A=
+REG32(SLV_PID_VALUE,                0x74)=0A=
+REG32(SLV_CHAR_CTRL,                0x78)=0A=
+REG32(SLV_MAX_LEN,                  0x7c)=0A=
+REG32(MAX_READ_TURNAROUND,          0x80)=0A=
+REG32(MAX_DATA_SPEED,               0x84)=0A=
+REG32(SLV_DEBUG_STATUS,             0x88)=0A=
+REG32(SLV_INTR_REQ,                 0x8c)=0A=
+REG32(DEVICE_CTRL_EXTENDED,         0xb0)=0A=
+REG32(SCL_I3C_OD_TIMING,            0xb4)=0A=
+REG32(SCL_I3C_PP_TIMING,            0xb8)=0A=
+REG32(SCL_I2C_FM_TIMING,            0xbc)=0A=
+REG32(SCL_I2C_FMP_TIMING,           0xc0)=0A=
+REG32(SCL_EXT_LCNT_TIMING,          0xc8)=0A=
+REG32(SCL_EXT_TERMN_LCNT_TIMING,    0xcc)=0A=
+REG32(BUS_FREE_TIMING,              0xd4)=0A=
+REG32(BUS_IDLE_TIMING,              0xd8)=0A=
+REG32(I3C_VER_ID,                   0xe0)=0A=
+REG32(I3C_VER_TYPE,                 0xe4)=0A=
+REG32(EXTENDED_CAPABILITY,          0xe8)=0A=
+REG32(SLAVE_CONFIG,                 0xec)=0A=
+=0A=
+static const uint32_t dw_i3c_resets[DW_I3C_NR_REGS] =3D {=0A=
+    [R_HW_CAPABILITY]               =3D 0x000e00bf,=0A=
+    [R_QUEUE_THLD_CTRL]             =3D 0x01000101,=0A=
+    [R_I3C_VER_ID]                  =3D 0x3130302a,=0A=
+    [R_I3C_VER_TYPE]                =3D 0x6c633033,=0A=
+    [R_DEVICE_ADDR_TABLE_POINTER]   =3D 0x00080280,=0A=
+    [R_DEV_CHAR_TABLE_POINTER]      =3D 0x00020200,=0A=
+    [A_VENDOR_SPECIFIC_REG_POINTER] =3D 0x000000b0,=0A=
+    [R_SLV_MAX_LEN]                 =3D 0x00ff00ff,=0A=
+};=0A=
+=0A=
+static uint64_t dw_i3c_read(void *opaque, hwaddr offset, unsigned size)=0A=
+{=0A=
+    DWI3C *s =3D DW_I3C(opaque);=0A=
+    uint32_t addr =3D offset >> 2;=0A=
+    uint64_t value;=0A=
+=0A=
+    switch (addr) {=0A=
+    case R_COMMAND_QUEUE_PORT:=0A=
+        value =3D 0;=0A=
+        break;=0A=
+    default:=0A=
+        value =3D s->regs[addr];=0A=
+        break;=0A=
+    }=0A=
+=0A=
+    trace_dw_i3c_read(s->id, offset, value);=0A=
+=0A=
+    return value;=0A=
+}=0A=
+=0A=
+static void dw_i3c_write(void *opaque, hwaddr offset, uint64_t value,=0A=
+                         unsigned size)=0A=
+{=0A=
+    DWI3C *s =3D DW_I3C(opaque);=0A=
+    uint32_t addr =3D offset >> 2;=0A=
+=0A=
+    trace_dw_i3c_write(s->id, offset, value);=0A=
+=0A=
+    switch (addr) {=0A=
+    case R_HW_CAPABILITY:=0A=
+    case R_RESPONSE_QUEUE_PORT:=0A=
+    case R_IBI_QUEUE_DATA:=0A=
+    case R_QUEUE_STATUS_LEVEL:=0A=
+    case R_PRESENT_STATE:=0A=
+    case R_CCC_DEVICE_STATUS:=0A=
+    case R_DEVICE_ADDR_TABLE_POINTER:=0A=
+    case R_VENDOR_SPECIFIC_REG_POINTER:=0A=
+    case R_SLV_CHAR_CTRL:=0A=
+    case R_SLV_MAX_LEN:=0A=
+    case R_MAX_READ_TURNAROUND:=0A=
+    case R_I3C_VER_ID:=0A=
+    case R_I3C_VER_TYPE:=0A=
+    case R_EXTENDED_CAPABILITY:=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "%s: write to readonly register[0x%02" HWADDR_PRIx=
=0A=
+                      "] =3D 0x%08" PRIx64 "\n",=0A=
+                      __func__, offset, value);=0A=
+        break;=0A=
+    case R_RX_TX_DATA_PORT:=0A=
+        break;=0A=
+    case R_RESET_CTRL:=0A=
+        break;=0A=
+    default:=0A=
+        s->regs[addr] =3D value;=0A=
+        break;=0A=
+    }=0A=
+}=0A=
+=0A=
+const VMStateDescription vmstate_dw_i3c =3D {=0A=
+    .name =3D TYPE_DW_I3C,=0A=
+    .version_id =3D 1,=0A=
+    .minimum_version_id =3D 1,=0A=
+    .fields =3D (VMStateField[]){=0A=
+        VMSTATE_UINT32_ARRAY(regs, DWI3C, DW_I3C_NR_REGS),=0A=
+        VMSTATE_END_OF_LIST(),=0A=
+    }=0A=
+};=0A=
+=0A=
+static const MemoryRegionOps dw_i3c_ops =3D {=0A=
+    .read =3D dw_i3c_read,=0A=
+    .write =3D dw_i3c_write,=0A=
+    .endianness =3D DEVICE_LITTLE_ENDIAN,=0A=
+};=0A=
+=0A=
+static void dw_i3c_reset_enter(Object *obj, ResetType type)=0A=
+{=0A=
+    DWI3C *s =3D DW_I3C(obj);=0A=
+=0A=
+    memcpy(s->regs, dw_i3c_resets, sizeof(s->regs));=0A=
+}=0A=
+=0A=
+static void dw_i3c_realize(DeviceState *dev, Error **errp)=0A=
+{=0A=
+    DWI3C *s =3D DW_I3C(dev);=0A=
+    g_autofree char *name =3D g_strdup_printf(TYPE_DW_I3C ".%d", s->id);=
=0A=
+=0A=
+    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);=0A=
+=0A=
+    memory_region_init_io(&s->mr, OBJECT(s), &dw_i3c_ops, s, name,=0A=
+                          DW_I3C_NR_REGS << 2);=0A=
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mr);=0A=
+}=0A=
+=0A=
+static const Property dw_i3c_properties[] =3D {=0A=
+    DEFINE_PROP_UINT8("device-id", DWI3C, id, 0),=0A=
+};=0A=
+=0A=
+static void dw_i3c_class_init(ObjectClass *klass, const void *data)=0A=
+{=0A=
+    DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);=0A=
+=0A=
+    rc->phases.enter =3D dw_i3c_reset_enter;=0A=
+=0A=
+    dc->desc =3D "DesignWare I3C Controller";=0A=
+    dc->realize =3D dw_i3c_realize;=0A=
+    dc->vmsd =3D &vmstate_dw_i3c;=0A=
+    device_class_set_props(dc, dw_i3c_properties);=0A=
+}=0A=
+=0A=
+static const TypeInfo dw_i3c_types[] =3D {=0A=
+    {=0A=
+        .name =3D TYPE_DW_I3C,=0A=
+        .parent =3D TYPE_SYS_BUS_DEVICE,=0A=
+        .instance_size =3D sizeof(DWI3C),=0A=
+        .class_init =3D dw_i3c_class_init,=0A=
+    },=0A=
+};=0A=
+=0A=
+DEFINE_TYPES(dw_i3c_types)=0A=
+=0A=
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig=0A=
index 8344b9769f..d545ecd712 100644=0A=
--- a/hw/arm/Kconfig=0A=
+++ b/hw/arm/Kconfig=0A=
@@ -546,6 +546,7 @@ config ASPEED_SOC=0A=
     select FTGMAC100=0A=
     select I2C=0A=
     select I3C=0A=
+    select DW_I3C=0A=
     select DPS310=0A=
     select PCA9552=0A=
     select PCA9554=0A=
diff --git a/hw/i3c/Kconfig b/hw/i3c/Kconfig=0A=
index e07fe445c6..ecec77d6fc 100644=0A=
--- a/hw/i3c/Kconfig=0A=
+++ b/hw/i3c/Kconfig=0A=
@@ -1,2 +1,5 @@=0A=
 config I3C=0A=
     bool=0A=
+=0A=
+config DW_I3C=0A=
+    bool=0A=
diff --git a/hw/i3c/meson.build b/hw/i3c/meson.build=0A=
index fb127613fe..83d75e7d5c 100644=0A=
--- a/hw/i3c/meson.build=0A=
+++ b/hw/i3c/meson.build=0A=
@@ -1,4 +1,5 @@=0A=
 i3c_ss =3D ss.source_set()=0A=
 i3c_ss.add(when: 'CONFIG_I3C', if_true: files('core.c'))=0A=
 i3c_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_i3c.c'))=0A=
+i3c_ss.add(when: 'CONFIG_DW_I3C', if_true: files('dw-i3c.c'))=0A=
 system_ss.add_all(when: 'CONFIG_I3C', if_true: i3c_ss)=0A=
diff --git a/hw/i3c/trace-events b/hw/i3c/trace-events=0A=
index cdf7cb07f6..2d944387db 100644=0A=
--- a/hw/i3c/trace-events=0A=
+++ b/hw/i3c/trace-events=0A=
@@ -3,8 +3,10 @@=0A=
 # aspeed_i3c.c=0A=
 aspeed_i3c_read(uint64_t offset, uint64_t data) "I3C read: offset 0x%" PRI=
x64 " data 0x%" PRIx64=0A=
 aspeed_i3c_write(uint64_t offset, uint64_t data) "I3C write: offset 0x%" P=
RIx64 " data 0x%" PRIx64=0A=
-aspeed_i3c_device_read(uint32_t deviceid, uint64_t offset, uint64_t data) =
"I3C Dev[%u] read: offset 0x%" PRIx64 " data 0x%" PRIx64=0A=
-aspeed_i3c_device_write(uint32_t deviceid, uint64_t offset, uint64_t data)=
 "I3C Dev[%u] write: offset 0x%" PRIx64 " data 0x%" PRIx64=0A=
+=0A=
+# dw-i3c,c=0A=
+dw_i3c_read(uint32_t deviceid, uint64_t offset, uint64_t data) "I3C Dev[%u=
] read: offset 0x%" PRIx64 " data 0x%" PRIx64=0A=
+dw_i3c_write(uint32_t deviceid, uint64_t offset, uint64_t data) "I3C Dev[%=
u] write: offset 0x%" PRIx64 " data 0x%" PRIx64=0A=
 =0A=
 # core.c=0A=
 i3c_target_event(uint8_t address, uint8_t event) "I3C target 0x%" PRIx8 " =
event 0x%" PRIx8=0A=
-- =0A=
2.43.0=0A=

