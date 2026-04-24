Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 538E3FB44C8
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 08:09:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGBXv-0005Er-TA; Fri, 24 Apr 2026 04:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wGBXg-00053M-F4; Fri, 24 Apr 2026 04:05:45 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wGBXe-0001GV-2b; Fri, 24 Apr 2026 04:05:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UH9aPMzaQxVu5aX0J5SmgxdWkPfZuWg70cSrwZD7Tb6TiPZLFFnkRuB0ejVyHUTl0bcYi2kL+0dudOD+vym+YGwnknWcqMf9U/KZF6M7mRo3rJaQ0yJwsS5DUX4DrbnNqVIjV7sXyZogZvip9mLp7GBZy6roZGTL8V2/ZCdR7iDvESnVt/jRRPCGmNv8NellUCzP+31PLjJnjJeTqTfSG4BZyccAnkU42jNGMVFr5aOnf18vtUryn6gmne+DxqLjhGk6t+vzs861qxJyOS2j0xH79/+qbfbfeYw1B36JFp75PIraVRmdOdOTSp+z4phywMXNmQYwqU9kWy18LQj75g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84a6H1AYkCG3PlZqCD6Dcg7C2Qm8Mm+r6Pi+HNsJuUc=;
 b=vXzep0RvNmwXldgSaeR0RD/0TaN91GgwuuYtLWie8JvnKChMjL/6OJ/EHXO+16jBR42zpwbNuIrUc25SckbjWPhfxWBJnbsWj4Xrgx9Qeabhd778EwTLZB20iy8cphlfycLnXVlPQBhUGFPOVdzGucI4nnSJAhDLUnYK+j+ExbEOTplsau2bx9J74cWEHuNEpSXsO5mCGoL6OA8A0L7Uqaqx/K+y01ee6NXhNSKYUZooLAuvDGtGAsmS8pgvKXqGjvbFWkc/9g1kWvapAli6Xa13gNkScanIDz4hcFzEHRh8+YBk+xw04jbvP9lfCtFPW0frDLKx49XN83P4Bpuesw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84a6H1AYkCG3PlZqCD6Dcg7C2Qm8Mm+r6Pi+HNsJuUc=;
 b=YGAwmEaOGVMcY0XXrJnsz7/27wvR/s6l1eyRVrVkuI1FwG9qMHgrJwaY6GCqKHTQEUOWhVv6TCSDimBKNakTNI80xyEh8KjvTbzsRQsCK6Lhp+5Q1e7LwR6shmFQMLo9dRlt880PBybEFMcQ5SMGJm06Ue0xon24M9pX0GrBwQPfkEyiZDMauWG+ui0z7z5WMOjqfbX611TmddwKWzNSDkxwP/sb6mZ5zHOqS61x2+xgn0dOxCiZG9dRvf0NOduU7v3uiz6eV9unTJdKBlewR7fuO9J5Ofy4XNZqPfhzAcJzAvX2Dov3jZ5vghXjmKKoqabqdDEAVoGsKdkk7D56PQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEZPR06MB5856.apcprd06.prod.outlook.com (2603:1096:101:9e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Fri, 24 Apr
 2026 08:05:25 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 08:05:24 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "peterx@redhat.com" <peterx@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>, 
 Nicholas Piggin <npiggin@gmail.com>, Harsh Prateek Bora
 <harshpb@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, David
 Hildenbrand <david@kernel.org>, Halil Pasic <pasic@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>, "open list:sPAPR pseries"
 <qemu-ppc@nongnu.org>, "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "farosas@suse.de" <farosas@suse.de>, "flwu@google.com" <flwu@google.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>
Subject: [PATCH v5 11/18] hw/usb/hcd-ehci: Implement 64-bit QH descriptor
 addressing
Thread-Topic: [PATCH v5 11/18] hw/usb/hcd-ehci: Implement 64-bit QH descriptor
 addressing
Thread-Index: AQHc08Eaxh1bCtBkGUq/Gjwbf+9McQ==
Date: Fri, 24 Apr 2026 08:05:24 +0000
Message-ID: <20260424080508.53992-12-jamin_lin@aspeedtech.com>
References: <20260424080508.53992-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260424080508.53992-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEZPR06MB5856:EE_
x-ms-office365-filtering-correlation-id: 394affad-efb9-434a-da55-08dea1d83d18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: TcQP1I4eAAq1M4yga+NQCCJ3Ge9slQPuEAnqm2XZ9jgObQenIDlb1nY6hcskiiGWDc2hh1BjEn4uqEPCDHJ4uPxmdntIrC2JxnTSHcDbA76mujBsuTfMVO9DRI6FYaiJ+6iDk5L6nB5bVr+buYM2+anT5qR2sT7i9bbqRxy6uucJkDC43QYgX599DlawsKgx5qytyiLoYqLitJBFu2RYV4Y8G0BhnOB5rV0IAiS6Ppod/wk+kkO9ioCwvMmmq2KQPQ4mK1W7w6raktdaHlmZa+Xca+82gv174djFuCjYsZtO8Uy8w6D3CoGpSRK/nDXyK2OMpiP1hTGHgifFHXJ1ybdhkx9GcK6Fu7lUFOK4+MckSEEdCi3ZhjRbA2OAXwCznoGcjlSYBWmj2+iDdYzzItgC0GPWsIsAyW+KzKrbslVRZeqPB+dEJBPA6QMa0GqJ4TcMSGdNW3i9tNjPeoj0HSEmLPAx4SFqG/c/AYJoMdeS4GnPjFmQAWF62ryNA3F2pJO9kNJI2svUZ1NlPg7DCadAPu0KIwArytbPPRZNyesJOHs6pHMlQucM5qtWv1OfYIYgCNa9sM88v6ud3c6rcl18dVoPeRR+2mB4lUko33CFJs/EGzejXfsGK0u8Y5D/yq3X5pxDUcyS3TLs7OWF34zw0iv55b1CLQ43O061QfeJiP//7zsB8dSvhAQ134hIqP/RVIu2RNSfN4sVamsFrciZacW0eL2MmMfp8i6xfhZxLazH3Iwx+HkFBpXR9GVtjlJWq1G42r7ceIo/VyjtZz/gqkm/V4GnNIvJdXngi2unWSDp7Cn//Zoy1A9mc7k6
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?YYXMYMqKbMBn8cfXE/6kHEyadLtzKkXBdCgnRj/NdRXRBbgj5kaSfUiQD0?=
 =?iso-8859-1?Q?kbOaLPO6Hyvdn1itqUdUt3dckCqMD8PpEzleuNCKFtXgv2qMcppfdDyZvq?=
 =?iso-8859-1?Q?+2Ql0ohqNnITYjyty9RsArasa+rYBooEqoHvyHccnFTwObshpepNPFpqCx?=
 =?iso-8859-1?Q?irySbZRtF1AeIFvO4lMJZZSYlvpG9Af9cjTzyuPoeTJucZ0blVyGzX8l4O?=
 =?iso-8859-1?Q?8wVRiuf14znZjS2pWmus9Jyo6SLA1dJHCwWaLdA6f/0CmEPjWvEQMQiq5G?=
 =?iso-8859-1?Q?/ObIhMI7F0FkwH0UUPL9+bkcQ3bgiu/7RY3bCKBauK6azunHgbE6k7urUr?=
 =?iso-8859-1?Q?pcHq++JXTRO1flCPMvPu3RJYmvticWCJAjkr2Ewq5Lh1g1BhAqK3rtq+92?=
 =?iso-8859-1?Q?4j5Y5PCthl6sP1dDbeA1YinQ0UGW+ug+xtK6/t0iTyg3fZTjoniZSdRFtK?=
 =?iso-8859-1?Q?4Q0ZQydFl2dw49bqq2rl7QPe2s5tBtYtKn/NBLDuNo4kd5hC53aWxtR5BF?=
 =?iso-8859-1?Q?elzGImydCGp7ykpT7wRXeBw5wYsgX7BIIk9ksUefTnvuwWOL28qp7l36An?=
 =?iso-8859-1?Q?x6MGzp+C0C4fSpa/l5ydZrZHr2EFL51EAnREUxQWDGR093a/4GZtRuullu?=
 =?iso-8859-1?Q?zwdKOvDRVUFZpNm25jz4wukqZVc4LDfaPa7xeyPpPjvk77kMT71rjWMjOX?=
 =?iso-8859-1?Q?+GtuHzflPwKKu9HIqeAZAnnkpdsU/lvlmzigegRNm1EeepqSXmgB95aTLK?=
 =?iso-8859-1?Q?k2OYQMwaqq+xw39gmbtXF4km3xK1tRp1xJMolFcQGBD9eRUUDHM3h/wqq3?=
 =?iso-8859-1?Q?aahSjroEvIw9VRWctnczrir7JQ+RxQrX8OqA/1iaqKMqvYWOeh3wMejg4S?=
 =?iso-8859-1?Q?YERShIjyGboLedNWtcQIjhYbviV8OwwGQFm/8e67PeH016gDQ/U5WrojrY?=
 =?iso-8859-1?Q?eOrwCX0e/HP7Pj9POOeNGb3b61tFe4+Mpd7IDozJux38MJbF45bdz9T3A6?=
 =?iso-8859-1?Q?ZMB4MjOu0YzjJOfndkF7Cy6o54RJyvpFMwneaMs+6gpHk52gk6a/B43C6q?=
 =?iso-8859-1?Q?Ce97uMfU3n17UqqMip97AaeRLf23cIWCOjOwReoCpe+tLvNL4c4zUKiDWg?=
 =?iso-8859-1?Q?uUYoYxsZoMmluFpOaYJzjOnJGl4gTgJBytBFILARu/1UjqYOw34U9/nggP?=
 =?iso-8859-1?Q?cMUo87c5QfLf3YJZsAFBRjL2/1M+OchvLvRf8xL7wsQQX8QOmuDAb85Zry?=
 =?iso-8859-1?Q?dBxHwSdj25ncZS3xznWXi2a1Ir9HREbkH/X1KN96YxiiJ27ulN60O++GW5?=
 =?iso-8859-1?Q?KwZZWu5HekNy+D6gm0uAxcDbZm5VcR1iXlHIUjdxmvDQ2kHuZ4+/3Hxkt7?=
 =?iso-8859-1?Q?Q0aM6T51/9d2h2hTvtHw8ssldtWR64RUEXoyCSZyseofVpS3yyfR/axOji?=
 =?iso-8859-1?Q?8OPuePdHJhmA3QOwDKLSrkBoBOJwD+yHqTNtPejvzHY7ihL8ieC1Qy1EbW?=
 =?iso-8859-1?Q?y2ZV8pxed4c+ClTguQh0QuDv8Q0kydYfiAHV8EjHJK+UvDlRLoZCgH0EB2?=
 =?iso-8859-1?Q?tPlJwkn3mHT7SE4iMOWULqJpBRU6vDxM45Kh6XYS9hWrjSVYfzghUy4NUX?=
 =?iso-8859-1?Q?a5HDCwCA01eGLZfxQ3veg1vmiIC3mwiDxp4ip3VZU+ePWNe7l9XF7rYzL2?=
 =?iso-8859-1?Q?BsnJlnytzoenjc17L/x9Tk4Py8KsU9QH/z+Bmxuqli4ISR2zL4WyUA0e4E?=
 =?iso-8859-1?Q?Xf19lpTNJKghIP+XfiKpAGmOCBy7Ru8h5qAgM/2v/O6Ev1z4qgfGjB9T5D?=
 =?iso-8859-1?Q?EKZZKyHYOA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: LDI2XEl7jnL8yMocssCrp8rcCiEFAaqFZzRywnRUTXe4QRRrblNm+csqhPYfSYL6gojpnETc9trZgM5zRugPq137BagIvZm7pBtkPdhvhogJK2FlNgnypMpu40+tL5prNwOqotubcNx0wyuZpCYga9uE1xP1xTLhFX0oL/hH2Y5ho3xkMm+GDFNa7hxeJLlhbEriuPY5Ps6DJI7WesXhnvJwhNBvj8dzyCAVb4vBpu+a7x+5wGdxfwDzFGmHwyavyrHzzxTAf3UF31GJcE+iHehITfP1sZQh7lnoddZG+nF1FNBqRqVFAf/5PJCbCdLxOAkyXLUBJNug+r6mqCUyMA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 394affad-efb9-434a-da55-08dea1d83d18
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2026 08:05:24.2774 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1pFv5ALz+mZy8YxMW/W6IjQ7D7V8x9sPv6m6CFGV3VInnwrL3CBM5/t8CDgYv5bvDjZpjoZCif1yKXmmtn4ak4s+3VL927GGFdekfnXXLKs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5856
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

EHCI supports 64-bit control data structure addressing when the=0A=
64-bit Addressing Capability bit in HCCPARAMS is set. In that mode,=0A=
the CTRLDSSEGMENT register supplies the upper 32 bits which are=0A=
concatenated with 32-bit link pointer fields to form full 64-bit=0A=
descriptor addresses (EHCI 1.0, section 2.3.5 and Appendix B).=0A=
=0A=
The current implementation assumes 32-bit QH descriptor addresses=0A=
and directly uses link pointer values without applying the=0A=
CTRLDSSEGMENT upper dword.=0A=
=0A=
Introduce a helper, ehci_get_desc_addr(), to construct full 64-bit=0A=
descriptor addresses when 64-bit capability is enabled. Update QH=0A=
traversal paths (async list walk, horizontal QH link, and periodic=0A=
schedule entry handling) to use the translated 64-bit addresses.=0A=
=0A=
EHCI 64-bit buffer pointer fields are defined in Appendix B as=0A=
split 32-bit low/high parts located at separate offsets, rather=0A=
than a single contiguous 64-bit field. Therefore, the buffer=0A=
pointers cannot be represented as uint64_t bufptr[5] without=0A=
violating the descriptor layout defined by the specification.=0A=
=0A=
Introduce ehci_get_buf_addr() to construct full 64-bit buffer=0A=
addresses from bufptr[] and bufptr_hi[] fields. Use this helper=0A=
when calculating transfer buffer addresses so that data buffers=0A=
above 4GB are correctly handled.=0A=
=0A=
Also add bufptr_hi[5] to EHCIqh to support 64-bit buffer pointer=0A=
fields as defined in Appendix B.=0A=
=0A=
When 64-bit capability is disabled, descriptor addresses remain=0A=
32-bit and existing behaviour is unchanged.=0A=
=0A=
Note: Similar split 64-bit buffer pointer handling is required for=0A=
qTD, iTD and siTD descriptors, which will be addressed in follow-up=0A=
changes.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>=0A=
---=0A=
 hw/usb/hcd-ehci.h   |  4 ++++=0A=
 hw/usb/hcd-ehci.c   | 47 ++++++++++++++++++++++++++++++++++-----------=0A=
 hw/usb/trace-events |  2 +-=0A=
 3 files changed, 41 insertions(+), 12 deletions(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h=0A=
index f1f2fde578..3428839ec6 100644=0A=
--- a/hw/usb/hcd-ehci.h=0A=
+++ b/hw/usb/hcd-ehci.h=0A=
@@ -141,6 +141,9 @@ typedef struct EHCIqtd {=0A=
 #define QTD_BUFPTR_SH                 12=0A=
 } EHCIqtd;=0A=
 =0A=
+/* QH overlay: altnext_qtd, token, bufptr[5], bufptr_hi[5] */=0A=
+#define EHCI_QH_OVERLAY_COUNT 12=0A=
+=0A=
 /*=0A=
  * EHCI spec version 1.0 Section 3.6=0A=
  */=0A=
@@ -194,6 +197,7 @@ typedef struct EHCIqh {=0A=
 #define BUFPTR_FRAMETAG_MASK          0x0000001f=0A=
 #define BUFPTR_SBYTES_MASK            0x00000fe0=0A=
 #define BUFPTR_SBYTES_SH              5=0A=
+    uint32_t bufptr_hi[5];=0A=
 } EHCIqh;=0A=
 =0A=
 enum async_state {=0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index b23ff92e12..5ffd4c9885 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -147,6 +147,23 @@ static const char *addr2str(hwaddr addr)=0A=
     return nr2str(ehci_mmio_names, ARRAY_SIZE(ehci_mmio_names), addr);=0A=
 }=0A=
 =0A=
+static uint64_t ehci_get_buf_addr(const EHCIState *s, uint32_t hi,=0A=
+                                  uint32_t lo, uint32_t lo_mask)=0A=
+{=0A=
+    uint64_t addr =3D lo & lo_mask;=0A=
+=0A=
+    if (s->caps_64bit_addr) {=0A=
+        addr =3D deposit64(addr, 32, 32, hi);=0A=
+    }=0A=
+=0A=
+    return addr;=0A=
+}=0A=
+=0A=
+static uint64_t ehci_get_desc_addr(const EHCIState *s, uint32_t lo)=0A=
+{=0A=
+    return ehci_get_buf_addr(s, s->ctrldssegment, lo, UINT32_MAX);=0A=
+}=0A=
+=0A=
 static void ehci_trace_usbsts(uint32_t mask, int state)=0A=
 {=0A=
     /* interrupts */=0A=
@@ -440,7 +457,7 @@ static bool ehci_verify_qh(EHCIQueue *q, EHCIqh *qh)=0A=
         (qh->current_qtd !=3D q->qh.current_qtd) ||=0A=
         (q->async && qh->next_qtd !=3D q->qh.next_qtd) ||=0A=
         (memcmp(&qh->altnext_qtd, &q->qh.altnext_qtd,=0A=
-                                 7 * sizeof(uint32_t)) !=3D 0) ||=0A=
+                EHCI_QH_OVERLAY_COUNT * sizeof(uint32_t)) !=3D 0) ||=0A=
         (q->dev !=3D NULL && q->dev->addr !=3D devaddr)) {=0A=
         return false;=0A=
     } else {=0A=
@@ -1538,7 +1555,9 @@ static int ehci_state_waitlisthead(EHCIState *ehci,  =
int async)=0A=
     EHCIqh qh;=0A=
     int i =3D 0;=0A=
     int again =3D 0;=0A=
-    uint64_t entry =3D ehci->asynclistaddr;=0A=
+    uint64_t entry =3D 0;=0A=
+=0A=
+    entry =3D ehci_get_desc_addr(ehci, ehci->asynclistaddr);=0A=
 =0A=
     /* set reclamation flag at start event (4.8.6) */=0A=
     if (async) {=0A=
@@ -1566,8 +1585,8 @@ static int ehci_state_waitlisthead(EHCIState *ehci,  =
int async)=0A=
             goto out;=0A=
         }=0A=
 =0A=
-        entry =3D qh.next;=0A=
-        if (entry =3D=3D ehci->asynclistaddr) {=0A=
+        entry =3D ehci_get_desc_addr(ehci, qh.next);=0A=
+        if (entry =3D=3D ehci_get_desc_addr(ehci, ehci->asynclistaddr)) {=
=0A=
             break;=0A=
         }=0A=
     }=0A=
@@ -1693,7 +1712,7 @@ static EHCIQueue *ehci_state_fetchqh(EHCIState *ehci,=
 int async)=0A=
     }=0A=
 =0A=
     if (trace_event_get_state_backends(TRACE_USB_EHCI_FETCHQH_DBG)) {=0A=
-        if (q->qhaddr !=3D q->qh.next) {=0A=
+        if (q->qhaddr !=3D ehci_get_desc_addr(ehci, q->qh.next)) {=0A=
             trace_usb_ehci_fetchqh_dbg(q->qhaddr,=0A=
                                        q->qh.epchar & QH_EPCHAR_H,=0A=
                                        q->qh.token & QTD_TOKEN_HALT,=0A=
@@ -1876,10 +1895,12 @@ static int ehci_state_fetchqtd(EHCIQueue *q)=0A=
 =0A=
 static int ehci_state_horizqh(EHCIQueue *q)=0A=
 {=0A=
+    uint64_t addr;=0A=
     int again =3D 0;=0A=
 =0A=
-    if (ehci_get_fetch_addr(q->ehci, q->async) !=3D q->qh.next) {=0A=
-        ehci_set_fetch_addr(q->ehci, q->async, q->qh.next);=0A=
+    addr =3D ehci_get_desc_addr(q->ehci, q->qh.next);=0A=
+    if (ehci_get_fetch_addr(q->ehci, q->async) !=3D addr) {=0A=
+        ehci_set_fetch_addr(q->ehci, q->async, addr);=0A=
         ehci_set_state(q->ehci, q->async, EST_FETCHENTRY);=0A=
         again =3D 1;=0A=
     } else {=0A=
@@ -2205,6 +2226,8 @@ static void ehci_advance_periodic_state(EHCIState *eh=
ci)=0A=
     uint32_t entry;=0A=
     uint32_t list;=0A=
     const int async =3D 0;=0A=
+    uint64_t entry64;=0A=
+    uint64_t list64;=0A=
 =0A=
     /* 4.6 */=0A=
 =0A=
@@ -2229,12 +2252,14 @@ static void ehci_advance_periodic_state(EHCIState *=
ehci)=0A=
             break;=0A=
         }=0A=
         list |=3D ((ehci->frindex & 0x1ff8) >> 1);=0A=
-=0A=
-        if (get_dwords(ehci, list, &entry, 1) < 0) {=0A=
+        list64 =3D ehci_get_desc_addr(ehci, list);=0A=
+        if (get_dwords(ehci, list64, &entry, 1) < 0) {=0A=
             break;=0A=
         }=0A=
-        trace_usb_ehci_periodic_state_advance(ehci->frindex / 8, list, ent=
ry);=0A=
-        ehci_set_fetch_addr(ehci, async, entry);=0A=
+        entry64 =3D ehci_get_desc_addr(ehci, entry);=0A=
+        trace_usb_ehci_periodic_state_advance(ehci->frindex / 8,=0A=
+                                              list64, entry64);=0A=
+        ehci_set_fetch_addr(ehci, async, entry64);=0A=
         ehci_set_state(ehci, async, EST_FETCHENTRY);=0A=
         ehci_advance_state(ehci, async);=0A=
         ehci_queues_rip_unused(ehci, async);=0A=
diff --git a/hw/usb/trace-events b/hw/usb/trace-events=0A=
index 8c90688bb3..67249d69c2 100644=0A=
--- a/hw/usb/trace-events=0A=
+++ b/hw/usb/trace-events=0A=
@@ -113,7 +113,7 @@ usb_ehci_dma_error(void) ""=0A=
 usb_ehci_execute_complete(uint64_t qhaddr, uint32_t next, uint64_t qtdaddr=
, int status, int actual_length) "qhaddr=3D0x%" PRIx64 ", next=3D0x%x, qtda=
ddr=3D0x%" PRIx64 ", status=3D%d, actual_length=3D%d"=0A=
 usb_ehci_fetchqh_reclaim_done(uint64_t qhaddr) "QH 0x%" PRIx64 " H-bit set=
, reclamation status reset - done processing"=0A=
 usb_ehci_fetchqh_dbg(uint64_t qhaddr, uint32_t h, uint32_t halt, uint32_t =
active, uint32_t next) "QH 0x%" PRIx64 " (h 0x%x halt 0x%x active 0x%x) nex=
t 0x%08x"=0A=
-usb_ehci_periodic_state_advance(uint32_t frame, uint32_t list, uint32_t en=
try) "frame=3D%d, list=3D0x%x, entry=3D0x%x"=0A=
+usb_ehci_periodic_state_advance(uint32_t frame, uint64_t list, uint64_t en=
try) "frame=3D%d, list=3D0x%" PRIx64 ", entry=3D0x%" PRIx64=0A=
 usb_ehci_skipped_uframes(uint64_t skipped_uframes) "skipped %" PRIu64 " uf=
rames"=0A=
 usb_ehci_log(const char *msg) "%s"=0A=
 =0A=
-- =0A=
2.43.0=0A=

