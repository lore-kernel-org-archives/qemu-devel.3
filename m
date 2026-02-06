Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 148F6ECD9BC
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 03:22:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voCOe-0001lI-Hr; Thu, 05 Feb 2026 22:20:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voCO3-0000Uc-Ev; Thu, 05 Feb 2026 22:20:04 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voCO1-00006q-LU; Thu, 05 Feb 2026 22:20:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ei8klwEaymVoPG5HvN/Y0CwWSX1qsxtsovGuA+pUAEupl7sCKiYSZMS7RHt7r6nSmRLsiIebuciTjDehhINsVGk8Vo63iz+uK3OOMbbtanC42PXt9wDlUF5eBWvPhr8DiV85vAWJ7eap8kF0GVyDFvDtHlxsVuJPysH/lCBTItwUCARFHHaXgsrgyEia7v3PHqwhEq7DHXnBCBRc97u8GYqzbMZW16UiowG2tMbPJ7e1Srax0buttl2Ba3lnltgTqCBhQqae0iKvYSo4uVf4IVtKGHtLEajIoaG9rKQ7i1ZbOrhfo9o0H+QIpDcMxdDfoijhviXI0ShAEXjwErKxDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VUIYcWBlMJzBBXmKOzZ8NlO0ajCvBQRUusSgDnbOcMM=;
 b=dbs1IQJhc7qk4jhDYHQrNY2CB5nIWVp+yg5xe2RaIye4Yfue/FZVuzAkK1szN7kU0HbMhLaYILgq7DJxVcs8NFCCu3X2VdWyeGxf6psTezX9wt/vyHt0unpRwC5ckb1+10bnJ+AtwgSdJZyv+s3OEbSmjwTVVl7ibZnDPQJOwpV2gSnMElrXJTYhXKxrRWrMNOVS7aSmnTHsjcQNmclTrsWyhMnYF4LY5bvpoV6oaWzr4K29yo4mQYlFtz8Qqi6cIskpko4+37SjWmG4DfqjjFr9nWhc7XTqbS929cYYWjNm8tRNnxx5uIgawavUaScVak0GkifhnIXVvb6UryQleg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUIYcWBlMJzBBXmKOzZ8NlO0ajCvBQRUusSgDnbOcMM=;
 b=BaLG4/L0mkfOeOIy3/jYhLpmT0xYbOJDy0X/Zf0U9tIfO8Z1PUdm2ZbivqyVTVeHV2z7j13vvQ+/RI+cfzgiGuQoRk1nfc0F4poHujQa4tQhv4zFbNwNOrcbKy/4SPMaMNE7B6ZZZb22xDBbNmgMzGn1PjBRa+wlIWYp1LNhu/Hx29EbzdiEeLQ4IiZfExGJJ5s5ANRPy5mL1eHdyYiugweADY4ln/mnQ/gvYlwKbQMO0zxKjrntdPdInxxqsnEUxXqRVzN6eUQPAxWnXvuGCcOQigGrteccmzxtmdJs3Hdrv4JH19NRV2LaAMNw/HuyMh/IFmFUttPn0LdP4g+2Sg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TY2PPF4DD1DCAD3.apcprd06.prod.outlook.com (2603:1096:408::78d)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 6 Feb
 2026 03:19:48 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 03:19:47 +0000
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
 Kane Chen <kane_chen@aspeedtech.com>, Joe Komlodi <komlodi@google.com>,
 Titus Rwantare <titusr@google.com>, Patrick Venture <venture@google.com>
Subject: [PATCH v3 14/20] hw/i3c/dw-i3c: Add ctrl MMIO handling
Thread-Topic: [PATCH v3 14/20] hw/i3c/dw-i3c: Add ctrl MMIO handling
Thread-Index: AQHclxdyNODx7i7L1UuqHM0bNFGiag==
Date: Fri, 6 Feb 2026 03:19:47 +0000
Message-ID: <20260206031926.3227848-15-jamin_lin@aspeedtech.com>
References: <20260206031926.3227848-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260206031926.3227848-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TY2PPF4DD1DCAD3:EE_
x-ms-office365-filtering-correlation-id: 978dca88-51da-41a2-6fd5-08de652e9539
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|41320700013|7416014|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?mHPSyJl3kE/SGBPwUmylZ0Y59OOLmj2hopJyri3hJAoT/1xNycibz2LER1?=
 =?iso-8859-1?Q?CpIGDeGS+7kqL5McfRvx8+8Sv4bcwK0h4HhamvGVgLrUj835QNYwJ+bBhE?=
 =?iso-8859-1?Q?gu8UJL4jwcXojj2R7RDXDWykjQn6yv1ypxxHKKiH9pIMuTQ+dCc+D5oyGV?=
 =?iso-8859-1?Q?n4Py0yHaNrHQXB1/aUUvf/qiTmd1kxrGAhgOg5IUFJgJgsOUV2ykEtXi14?=
 =?iso-8859-1?Q?kTPkcOxur+Qk18Uz+Us9ERvHYo3cp5WVjH4KbrngS00Lx8QH3+8mzQwQdo?=
 =?iso-8859-1?Q?YXnySIJAfpzrap9WL1vOKmj00Yj6RcmbczMewKna0DRj1JZcLqm/tbl35D?=
 =?iso-8859-1?Q?ckF2nbwTo7F+lcmhGfMAocxZQ7xBnOBhjJ7U0e0S2S5c1XqhgddrhqJuO3?=
 =?iso-8859-1?Q?sA/MQer6e/Wllvyoaeh9JBzOQ9CkjpmWZaJEAePIxf6MRISv6AJdEGMr1K?=
 =?iso-8859-1?Q?XDrcdV5G/EIct4oNQklyndmC3LfvwtxVFbJhci9k0gZErcx80eLbuKoTIy?=
 =?iso-8859-1?Q?5ns9S8D0ujW2sXMpLdahCWec6tY/mA53AbtDcmeyskk4FyfhlGpuuaQy7s?=
 =?iso-8859-1?Q?sg3+eyGkEjw+0HA+ekjFI7/Sw+cgSVtfA+KTu+q5hWBCdJHm27mdoIM1cg?=
 =?iso-8859-1?Q?UcveQ4o/yTvPWIyQj2WViVI8fcoQTdt6T+J2Gtmp5u6UJG2UKpM8Uh/W/3?=
 =?iso-8859-1?Q?7Y38gYBaSU+8BTs4EnxHU/MCFQem7Gpas2KIPVTXiW2M57wZmuUtfpKo+t?=
 =?iso-8859-1?Q?az2M2S4iuO2pbfLXtKmmDRuQqOno3hOAVtYnyGcM4Gpdg1cYjlF2dqf9Wl?=
 =?iso-8859-1?Q?R7FIMEXW9HJvAa03gjSfEmY/v0GC7xlPl6PKcazX5LMKU7H756bsyP0c5O?=
 =?iso-8859-1?Q?AisvcaUdcCa9iz0i1U+su5HxWws8SaZ7ep3Y9C3lJ5T2s25sS/ANySiSaz?=
 =?iso-8859-1?Q?30BcE62R9cCe04mzkJNfqknZgjb3u/rN4xw9NYn8Q28+3ZyRu+PbHvkeJZ?=
 =?iso-8859-1?Q?pyYlduG4G18YdZvx6Og0FdoKERMLc6zgy9wc+K1DI7ySgqcV941C7UShwj?=
 =?iso-8859-1?Q?Vbn3M+t2/2itpxKzaMgJLVHyEGcO2oSUDRi2beANeeVbYxMWjVe1TUv5UF?=
 =?iso-8859-1?Q?L5Xafg6OPH0lFR4xue0X9hqm+AOxOD5q2f8ZPkAd9muTAEl2FyRnU9y2Z7?=
 =?iso-8859-1?Q?TW5qI/nrLTDFpW6ChsBrSaUs0bT5qkglCeHuIKKemrIN8crAtAjA6tv/Ib?=
 =?iso-8859-1?Q?0OjutDdJ3n72zIkdtx3VGQ7cFUPbnHARmSnmhr7EjuQR0L2Es9e64NOD+9?=
 =?iso-8859-1?Q?l2IBdXXmEuG8RMyHMETltwy/0eQbOhP0ZhmjLXIv9HNNVoLIAMcZBvX/ah?=
 =?iso-8859-1?Q?YVn3cJYrjUDAY0hUBjzeUC0iIj4YSX5SPyBsrY7ccNJgX/AxBcta1jM7Xh?=
 =?iso-8859-1?Q?uCoNKMwvtj8HEQcW6Kpb5QJq6j0/p93CkGe6RcvuwLHJzr6dVKZkKTqb27?=
 =?iso-8859-1?Q?CgI9iSlAJShOZFZMdRWO15Ik9eYzpnkIoPAZdeD1fDB4lKsGFtZ3b4bpmX?=
 =?iso-8859-1?Q?uhcMGwONq5esjaksQxb6NXHgzlVmUMMXO9ttzDdujgGOaHWgSzLeOLNqZl?=
 =?iso-8859-1?Q?GQ1jCT1WOQ0OWdejKi3oHOQpAlSsPppv80Ss14mLZj3M5MWYl+F8Ao8Jow?=
 =?iso-8859-1?Q?yKZDjJCj4gWDtmVtLwAkMHWy4rSM2els/6am4Hzn?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(41320700013)(7416014)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?AR6L6QTAP2N6JsC4uHy6rQg14s36n3iL8Hf8KwpUYcWMxR+TPIicVYGbqv?=
 =?iso-8859-1?Q?8cExYBL6JIrvN8bdzzlVk2CbraQvIlfgAeHkxRvJe9Oer00LhdvVi7wONw?=
 =?iso-8859-1?Q?+osEOT1wyOS1Jhtij6QhtqHnBgHtHldJTQ/3AJjAW4o8xtjHpWA+KaTQ2h?=
 =?iso-8859-1?Q?y/O6oqEcrIKH2485N4gpYYIKWdfi3xRj1aws2WJQdgYQAPvU/xiXsf71Cn?=
 =?iso-8859-1?Q?9Zu6AH8iQh1H6cQVSGLAJVEhV6BnJulydC8BlB4Pnn56WKo2UxWTIeCghV?=
 =?iso-8859-1?Q?j9yDfKAy3CTOlot7gjl73FRaOyxXrEP+alY+URpkzzlWxyjf7Oa+BjGT+e?=
 =?iso-8859-1?Q?2iDawEw3PuHQy3N1a4Dvc7culCxpEvJhiwevF+4zyFnaR0bYWmLqG2Dn8U?=
 =?iso-8859-1?Q?fTpetz3yLwUfv+s0QMDAGyb5V4a7+47GngV8IaxjaqbU4DZT+0JOzNgm6k?=
 =?iso-8859-1?Q?/qTD1ss5uVEKqO3LUuvzNSwQQlFaMXoa1tEeJ+c1Hj6pTyC/gEW9myhTfJ?=
 =?iso-8859-1?Q?o6Hvh+xLI5WxM+vWCMkz7eTRyuXSoj3CgCT5yq+Ue2q0T4S3vhM9I4FhSn?=
 =?iso-8859-1?Q?Tlu9vaTjJBoNmNO43ZBUUDShwLe9RxMZdvtb13K0FQGIvZzKfLEsSV6REa?=
 =?iso-8859-1?Q?Zv+dYJ8jetOPFaPcSSCUsxQ7hgasMTPnb5ifZqv/uNVK+OIMlpe6Wut4mI?=
 =?iso-8859-1?Q?SLjUY6o8iMU+Z6CYqxkd8PUHI47GEpqS/ZAdwY12yXSQlZCELdoYI9FJ4l?=
 =?iso-8859-1?Q?XmREMQuyJ2wwPKYKunCSsoUShrd2vPgFsqA6yyfiEInj/hmQrPUVaWvOlH?=
 =?iso-8859-1?Q?QIddZ2BDfMrGkg2PBcM9ogfF8/59bJfCF/2HOkBdLEwaQr2rO8TlO/ioph?=
 =?iso-8859-1?Q?Cz+9wwZuDSErdr+sPeBSUVGPXqqvyDsXAfdXfkP60oIMAkErZtMDDPPKpG?=
 =?iso-8859-1?Q?7ardY4zY02Yz+BHdPyh0el+5lTEh6IpXaOgwJFW3CvB4g0M0C2tC2waf3N?=
 =?iso-8859-1?Q?7jVamwAbqVr47oQk5FenevnZbX97K2wQhiL5z6bAVSLsSeTy7/8og8+Ldq?=
 =?iso-8859-1?Q?T4nlD/rPuBTCnpNytqT9/v75k5kDwCSdVfzJJD8YI0yPd+cZTuAoP2b0Iu?=
 =?iso-8859-1?Q?zSVkBKs0ScFZrCwLnKr9946+bRTrBGk+p1F0uDX8umvVjWSjbcEMsbx2JD?=
 =?iso-8859-1?Q?nEy/EDBq8sq/Jn0D3dMq0XiJYPir9NiigmT7ec0h4T3rjd90BwExJ0uny0?=
 =?iso-8859-1?Q?++gcm6TvswHtBobbs5IoAUyNRUho/1m6DMJmGMVCABLr2rhYX3BgvAlUIo?=
 =?iso-8859-1?Q?t3lArzWA/mFfp86hcNd6Hqbx8OpF0KaqyEtz2Edbj611NPx2vp7+539/ZU?=
 =?iso-8859-1?Q?iGmg090LoWrnLBI21Xtn+XAQTl+/02fftCZ+Fl2wZDGWHQq2k2hyQ3TNmb?=
 =?iso-8859-1?Q?jZcDNsy5KuZI2SfVSULgpN94B0jL9NdOP+CfqM9MG1HDi/LYLQgzO35gZn?=
 =?iso-8859-1?Q?8wSQLfoEmKd04Fp5fHONrT2301guGHkTSRoySQ6TMzwEn31GtyRGvdBPSq?=
 =?iso-8859-1?Q?12akOsZn5BaFg6z5Bm1Y0OW2ClcwB9QUuRpBlVPfMPVFpJGeIZXj37ZQci?=
 =?iso-8859-1?Q?/wxCQtOnAOX1pWaT1s0nRjYtdYdDC4GQ5JkDZFS3zNeAW9iGI4pEYsQfM2?=
 =?iso-8859-1?Q?zqrvbyJTfMazzjf9MQYS6T1LrPYUAPxevF8CSAp8k8stv1jUuPF8mh5KAc?=
 =?iso-8859-1?Q?VOt3OOO751ZGj2GsSdEP7QUUSgNHKvOYrnRv1+vDh4eKyiQ2wURT35Gjt0?=
 =?iso-8859-1?Q?h4/6nHHbRw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 978dca88-51da-41a2-6fd5-08de652e9539
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 03:19:47.9613 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7ZU2zqeJeBm++BY0xTBAFIaDaMmQI83U9jIwadUDSDnJ51EhTYML8u50SV2W9AyEoL+hbmf2alHuvDwniAPU4wMpG31SWLiej4tOofAIFqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPF4DD1DCAD3
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

Adds functionality to the CTRL register.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Titus Rwantare <titusr@google.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/i3c/dw-i3c.c | 35 +++++++++++++++++++++++++++++++++++=0A=
 1 file changed, 35 insertions(+)=0A=
=0A=
diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c=0A=
index 9a0460cf31..7a1f79e10d 100644=0A=
--- a/hw/i3c/dw-i3c.c=0A=
+++ b/hw/i3c/dw-i3c.c=0A=
@@ -344,6 +344,8 @@ static const uint32_t dw_i3c_ro[DW_I3C_NR_REGS] =3D {=
=0A=
     [R_SLAVE_CONFIG]                =3D 0xffffffff,=0A=
 };=0A=
 =0A=
+static void dw_i3c_cmd_queue_execute(DWI3C *s);=0A=
+=0A=
 static inline bool dw_i3c_has_hdr_ts(DWI3C *s)=0A=
 {=0A=
     return ARRAY_FIELD_EX32(s->regs, HW_CAPABILITY, HDR_TS);=0A=
@@ -503,6 +505,36 @@ static int dw_i3c_recv_data(DWI3C *s, bool is_i2c, uin=
t8_t *data,=0A=
     return ret;=0A=
 }=0A=
 =0A=
+static void dw_i3c_ctrl_w(DWI3C *s, uint32_t val)=0A=
+{=0A=
+    /*=0A=
+     * If the user is setting I3C_RESUME, the controller was halted.=0A=
+     * Try and resume execution and leave the bit cleared.=0A=
+     */=0A=
+    if (FIELD_EX32(val, DEVICE_CTRL, I3C_RESUME)) {=0A=
+        dw_i3c_cmd_queue_execute(s);=0A=
+        val =3D FIELD_DP32(val, DEVICE_CTRL, I3C_RESUME, 0);=0A=
+    }=0A=
+    /*=0A=
+     * I3C_ABORT being set sends an I3C STOP. It's cleared when the STOP i=
s=0A=
+     * sent.=0A=
+     */=0A=
+    if (FIELD_EX32(val, DEVICE_CTRL, I3C_ABORT)) {=0A=
+        dw_i3c_end_transfer(s, /*is_i2c=3D*/true);=0A=
+        dw_i3c_end_transfer(s, /*is_i2c=3D*/false);=0A=
+        val =3D FIELD_DP32(val, DEVICE_CTRL, I3C_ABORT, 0);=0A=
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, TRANSFER_ABORT, 1);=0A=
+        dw_i3c_update_irq(s);=0A=
+    }=0A=
+    /* Update present state. */=0A=
+    ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,=0A=
+                     DW_I3C_TRANSFER_STATE_IDLE);=0A=
+    ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_STATUS,=0A=
+                     DW_I3C_TRANSFER_STATUS_IDLE);=0A=
+=0A=
+    s->regs[R_DEVICE_CTRL] =3D val;=0A=
+}=0A=
+=0A=
 static inline bool dw_i3c_target_is_i2c(DWI3C *s, uint16_t offset)=0A=
 {=0A=
     /* / sizeof(uint32_t) because we're indexing into our 32-bit reg array=
. */=0A=
@@ -1575,6 +1607,9 @@ static void dw_i3c_write(void *opaque, hwaddr offset,=
 uint64_t value,=0A=
                       "] =3D 0x%08" PRIx64 "\n",=0A=
                       __func__, offset, value);=0A=
         break;=0A=
+    case R_DEVICE_CTRL:=0A=
+        dw_i3c_ctrl_w(s, val32);=0A=
+        break;=0A=
     case R_RX_TX_DATA_PORT:=0A=
         dw_i3c_push_tx(s, val32);=0A=
         break;=0A=
-- =0A=
2.43.0=0A=

