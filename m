Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41929EA3F2E
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 09:11:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpjm2-00022h-8J; Tue, 10 Feb 2026 04:11:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpjlx-0001l3-Ti; Tue, 10 Feb 2026 04:11:06 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpjlv-0004kR-Je; Tue, 10 Feb 2026 04:11:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EgkkoIVtJpNXPZk2S7cmlR6Q1t9ZB6UuppE+b60yZVA58gmQlyPuqS6FKt0JHH1TxltjLszMF/2yd9Mf3Pe4c7kaHTuzfXCPu9XfZsa0qUZ9n/XvVK8S41hwPMtMlWtU2eda0dvUMHwQOc9Z3OPqtFv0qHwRh5+/jmFrP7kXHJsm2XyHwNi/9eZUiEyriJpIQBpsXEFpRkJnCkFuPfF0gniIdXnb6SrvrU+s+Qvs958NSvC9xhv2Hfaf4ZHv76vBMb8JwCuR2NmA7rX2Ev3hHctSsKVElZJu1xJ8hAAt6zBa4DLL6ED8+w5m7JNjTe870p1hiznxfjyJ8x9IWlBb1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZjFS/hdvT8y2d1p3xi33JUio+UqLSU4JtKs354VCAg=;
 b=zHfDgRVpBXBcloIU5LEOzL0VsALbMbkuPLgXESYbqSqbXa2i5i35OEk0qJv/oJWiQtcMwHyEUM49yUlsCQrBGm53i1kV8uuXAmNuXgXXdA4X8qxezR+TM67YcV6+MqjMvcyyIqUlVKtLq4MJhoZR+pzvMlIz1bNy1JcT5LVXYAWtmM8xG2P0GpmQOL0M3z2PKd9WWDQsuRNxpj8P0h3mtZsHqpmRyaMSfH92BWSvtV4TYSCeBXcFnFPJCo2FzjR4RO3c3DCWsaIZQnuGYBZN3o9VKaGlUAuPH8y4umCNZLKTJw1uR+Nftd26OgK53oBiwpQSj4YcyGzjDKjEfxmWDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZjFS/hdvT8y2d1p3xi33JUio+UqLSU4JtKs354VCAg=;
 b=Xx4Fvhs0zAzpQwpX8v0dl97+IzJVCq855/jF1fg9IJc9/UFljM7ht1s3ZQyM8trHzcNL+qVULdm+wEIrjZrSwS9H1s0t8gN/OANHotzhUkvX3eLcFUDSXf/PgKAxfNTqT0r2KRidTZk9VAoENFUOInEab796v58vqcGlV8NF/zjwuTuHb6g6axqWEN1oJwTbesa9CLDmAoYTx/YfcChHj//uuHaiZ+0HRpg2qyJ2mJOX2FCOVatK18TkSJA3YWOne5QUwO/ikRZzWsLHVW33q1RO9Jt5m1IPvpOH4I9EI/yn4WiC2mxv56qfZEUgg2ypiC/qBs2dBnef+9wp0Xz2dQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KUZPR06MB8268.apcprd06.prod.outlook.com (2603:1096:d10:62::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 09:10:46 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 09:10:46 +0000
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
 <nabihestefan@google.com>, Joe Komlodi <komlodi@google.com>, Titus Rwantare
 <titusr@google.com>, Patrick Venture <venture@google.com>
Subject: [PATCH v5 18/21] hw/i3c: Add Mock target
Thread-Topic: [PATCH v5 18/21] hw/i3c: Add Mock target
Thread-Index: AQHcmm0kEufGdnpVB0yRA+lK+teccg==
Date: Tue, 10 Feb 2026 09:10:46 +0000
Message-ID: <20260210091018.1553489-19-jamin_lin@aspeedtech.com>
References: <20260210091018.1553489-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260210091018.1553489-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KUZPR06MB8268:EE_
x-ms-office365-filtering-correlation-id: 56b3074b-9bf8-433d-b191-08de688446a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?ahi8bgcammQAeTqFLZZGXTG8yRjpupwgJIEcc9qj1sx1POy+CGjfb6ahkn?=
 =?iso-8859-1?Q?Z+1sc6Ghc3WIW4lD078Jf3vgtb3gMQaKzz2i55LCRj080ap6NH/dchFzXW?=
 =?iso-8859-1?Q?JGb2WxkQbaf3z/OF9sl5gPiSsV7tflE1vKYjJS4idpJIGDvo5a1IxDZUhq?=
 =?iso-8859-1?Q?CvTb2MY6npmAk6TWNLUL/Y1wiuKpxJOlDE1QLEQiJMN6n18xVvsBxhY4h0?=
 =?iso-8859-1?Q?euNNQqJMkqss+50xO+vtHHgiQ/axGV171wNSg9NcuMXPeg5rUttyy/Aevi?=
 =?iso-8859-1?Q?IxePOr5lanILyeUGQa53/ZrT0lTtSxTqeLkQezY9xUEW1iPkgSJ8PtpPVi?=
 =?iso-8859-1?Q?erXstEtqthu2DpYFnqJTEQ9+fcB2MNqhGPVEZb7FZS9aYz9k+jt/KWGSaR?=
 =?iso-8859-1?Q?a8q4tl1VLnciJ+Yb494Kjn/8Lo9QAOmvjIQv7JYqlkOBjjBTWAEeD9+cMW?=
 =?iso-8859-1?Q?UqznQpuiLn91YKUtHHIJhiwotHIJo2NAs2Cs4rjcgRc20qY3mOveP6l1c+?=
 =?iso-8859-1?Q?+eRjs1BpkJuzoUSwvBh8YwbUVltWIcFW9rVSX1htlLUR8v7s+WHdNT/Ijy?=
 =?iso-8859-1?Q?halCwk12nPOclq53e7jbualMSlPBw+vG+rO1uXEQjMnqxmzbqorlEbVnl3?=
 =?iso-8859-1?Q?Si2dQdphAKgY3uM+WKRFl+TM7JETB+q9yr1Ski7EKtbsmasgFINc8wEpBs?=
 =?iso-8859-1?Q?681Ripz/O/EMAV7GmpaQl3+pkxHrEyyiSkvQZv+HIjNo2v7VO6lNfL9dqj?=
 =?iso-8859-1?Q?1NAtSCvHn3JC+Xf5XNLjGyisWt3sEmnYjav3mj5xFwllv7itM1+J7xfwJn?=
 =?iso-8859-1?Q?wT7n0YuFiRvcQbIpFlXJw3C/XUXQvsX7mWdJC7TpI2/N5+y6WH0H6IfsUw?=
 =?iso-8859-1?Q?E0bFiFiL7lt754fGreCbwJ4VgqW/hlTNdCfMMooU/XE1ddp/CjQRST7r/1?=
 =?iso-8859-1?Q?Hhb5MCr29de7rpVJpj45PYBqAKng884iyw2d4x/0MerOSP6oGQUub2awqy?=
 =?iso-8859-1?Q?JEq5G8Ns71H7avqihNruqOPj/Sl5oFFLNC8jHyvl4a7A6RgKZ7K/ze4llS?=
 =?iso-8859-1?Q?mdspsA+m7ZO0HzPrrBzjLr0nQ/VJkYb3H7V+120lW5EXfyiI2AmkfiND2m?=
 =?iso-8859-1?Q?3xNbNoSx0mCiCv+kjGAG/l+tZ8Zpxptdx6WFBJILnvjHOmluxAzhI5/19h?=
 =?iso-8859-1?Q?/PGlOspcvGMEpOFr4+5x5Mha6NPhc5wtdFMQPg23VNXFZve3fVcr/H83zY?=
 =?iso-8859-1?Q?c+tqxaoNNAfMNOkcKqrIU6QUq7AAuFv13ocDh2VfvEAG+kYLAHIOWp4GVq?=
 =?iso-8859-1?Q?ZNuX+ELr5VeRvA8zFq1F8CgD/GGAgP618YxEBecgXVFrd5TeOvwHDuuxVf?=
 =?iso-8859-1?Q?kJRH+I5JAIuiKQjpEv97iOk53Amw/ky3cowtnVXj+omxvw5chmgmrP0ue6?=
 =?iso-8859-1?Q?bguOW4jewMcTaViWS9FPOhF7/7/kOEINbrjdj+r9z6IXiPZ6Zp9dJgAgtI?=
 =?iso-8859-1?Q?HIuCfFD0LB5A42xd0Q5Hv5bXMhBy2EDORFy1ox0OubmdPUdD2+COVpOxnD?=
 =?iso-8859-1?Q?IBpVu3ymOhyXMp2cEST2O64u22HPJYtYBoNwASLRFplEX68BIrC7LdL5RH?=
 =?iso-8859-1?Q?BPzspYotE9rck7oZQRdAEbddx8vkj4ll2NoJb2m2cjed4MI13YyQs9tjme?=
 =?iso-8859-1?Q?ikZ/D82WA1elbiVJHQ/QJc9ER9qjmWDxxqFXEibn?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Mn5TqFXR8OAfiMWQaNC3/LtFqlIUWuYJsoyQ1lD+oPM+g5EoLmksNkMsR3?=
 =?iso-8859-1?Q?uSDH6x+7MRxAhWO2zmmkOvKSFJA9i0awitPJ1Kg6e9VHyqbekhlS8sB2/a?=
 =?iso-8859-1?Q?PmfBpDxCFiH9ey1pq7blDVIQZM4p8RLGVTLnOuUrzXhTeoyaRWSotgDwDz?=
 =?iso-8859-1?Q?mMOtjgaWA3f9Oodl8POe/KghhCGKqBPOLwvlt5UNdEDLbRnU/+PC88F4MY?=
 =?iso-8859-1?Q?B/v4+la9GRNKimgd7dGXFYHmfloLfypcXjQeLaxKXb7hI1rKiEy4urf21z?=
 =?iso-8859-1?Q?mfTLs2SXrl3/W1bdJ7P20OJdHL3x0Lj8PeQMLv83geL3rUn38ITwHHWhsP?=
 =?iso-8859-1?Q?0zGrSctciiGOxvTjIiS7Nkqa5a71iEak6Myfo/XB1CaGb/3D7X1SSX82/g?=
 =?iso-8859-1?Q?3HNtb5E1AFgoD6lRyBaYAGC5r8mGR+BH+qBJZeG7DiN42eEzLLwZ/h46cq?=
 =?iso-8859-1?Q?2sXFl9YuX/2D4OmxDazhVJNBa72JHabdV8KEn06+Z5PF4U7CryS3Zpq1fv?=
 =?iso-8859-1?Q?AaqG6WhHyW1NKhBANpAD/4UwuM0+q13SBdQpf63m1effFDQOMu90jT314w?=
 =?iso-8859-1?Q?FgMBhWRisIeqL5WYafVqhhrWnUkfpdKjrTgr1rzUOjrYHTlNOoe6vLgZYf?=
 =?iso-8859-1?Q?qlaxZ/tCn9lYpMpEk4K8kURn0bjVx4K46rK+SSSxL2VYONRRuQjQytaUhW?=
 =?iso-8859-1?Q?xKnBAo2IGDJbVqFox6W01LPJIN9r4u2Jj0Ma8zR996ik+FhmfPSm+zbMA9?=
 =?iso-8859-1?Q?JE3A4VrBnfidEmR2pe7tWxp3iM7EQn0liz/XOPHfX85/qplAuvi7DonNzC?=
 =?iso-8859-1?Q?stimGWH4Rx2c52U0c7cgGhe+JaXHS2vkf7SS0UrTPQZ/n34vEn2tbRQLru?=
 =?iso-8859-1?Q?OZHrHxNkw8aNAxvEifiRoQ3oNEpYnqEq6c9gQBm1BmL2I/Ar7YLaVcJedS?=
 =?iso-8859-1?Q?IMkiaraV4DQLncuuIVJZZ9Zn1n1oiXOSHKmCYirsd88mqjH6rOOdhoS+/e?=
 =?iso-8859-1?Q?Dww0GdjVwUSxASSoPPO4nKoey7NLkBdvl/gMpGiDgeUUdEwkak3s/WX9Lh?=
 =?iso-8859-1?Q?zc/2o1+xJVr4ONZP21tAXCBe7E11ksC4ktvYzIlqChKR6AMSq+dq7h0bXH?=
 =?iso-8859-1?Q?a6VMAms9XP0ABFLX/GQAgRHd8UeeVH0sWjWt7QT+5Vrek9Bhe0UaAHwRzt?=
 =?iso-8859-1?Q?gygxUPQAlZGCboPi9MrGtPYYCJ8oBqMWBf844wSqjR16nCh5iOBRtDTEpP?=
 =?iso-8859-1?Q?e9own69hHFJMg8hXs3uQVIh7bYZ1JNTSsgDvV5hFGACEKaWLeCgdoFGcPo?=
 =?iso-8859-1?Q?zf/caP6fhtIG2QH7+je8v5jbTcpTw3111b4Ggu1+hMm7CdZHFf540lNB35?=
 =?iso-8859-1?Q?EHzsbVoQJUjCvIu4pYPRZJgrSZxTznKtGbubOJw3P/2qqn2WRBqpvkq6Mq?=
 =?iso-8859-1?Q?S/Pae6kpMKx8Q7rKRRa3ePARlXVEYvozkcxGDzAqV4Fth0ZFmsBjIyuSKz?=
 =?iso-8859-1?Q?DFBZRYesABEWBKdnRlSyESLoxBIjXVx0RhiHGTtZ63lEodLTs0knN3nXGg?=
 =?iso-8859-1?Q?LmE51z2Ve2DiBJDvBvgGQb6NLsZpeBM/X18BogJE+hEjUsDIVlI9MFRos5?=
 =?iso-8859-1?Q?5B4jrZOVnDLb7UXkJuDgxjU3VbRIZdxmK0ig6GoZir3BOtsSwoQvlaPEv3?=
 =?iso-8859-1?Q?viWXz91LqikQjkEuMEjHC4z0v8GkT+V7NhliLFVeK6UGP3QJRZgcBSpkS5?=
 =?iso-8859-1?Q?zCgzizV3e7K+Xus4jfDiGNqrrX/5XXwjEbPfZjpkcmfWa/uhx9WdRAu0Tl?=
 =?iso-8859-1?Q?K+tN4UinCQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56b3074b-9bf8-433d-b191-08de688446a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 09:10:46.2976 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i+nfbjOfc87Ir0Jbziha/m6kkRhPBVbwEo/nT2qRZd7L7maSmCsbXIs5MyMbNfEb65zfarJFjGTaumO6o2IED4RnyL/yF1LcvQ2ZW+A2BDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR06MB8268
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

Adds a simple i3c device to be used for testing in lieu of a real=0A=
device.=0A=
=0A=
The mock target supports the following features:=0A=
- A buffer that users can read and write to.=0A=
- CCC support for commonly used CCCs when probing devices on an I3C bus.=0A=
- IBI sending upon receiving a user-defined byte.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Titus Rwantare <titusr@google.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/i3c/mock-i3c-target.h |  52 ++++++=0A=
 hw/i3c/mock-i3c-target.c         | 298 +++++++++++++++++++++++++++++++=0A=
 hw/i3c/Kconfig                   |  10 ++=0A=
 hw/i3c/meson.build               |   1 +=0A=
 hw/i3c/trace-events              |  10 ++=0A=
 5 files changed, 371 insertions(+)=0A=
 create mode 100644 include/hw/i3c/mock-i3c-target.h=0A=
 create mode 100644 hw/i3c/mock-i3c-target.c=0A=
=0A=
diff --git a/include/hw/i3c/mock-i3c-target.h b/include/hw/i3c/mock-i3c-tar=
get.h=0A=
new file mode 100644=0A=
index 0000000000..8c6003ae8b=0A=
--- /dev/null=0A=
+++ b/include/hw/i3c/mock-i3c-target.h=0A=
@@ -0,0 +1,52 @@=0A=
+#ifndef MOCK_I3C_TARGET_H_=0A=
+#define MOCK_I3C_TARGET_H_=0A=
+=0A=
+/*=0A=
+ * Mock I3C Device=0A=
+ *=0A=
+ * Copyright (c) 2025 Google LLC=0A=
+ *=0A=
+ * The mock I3C device can be thought of as a simple EEPROM. It has a buff=
er,=0A=
+ * and the pointer in the buffer is reset to 0 on an I3C STOP.=0A=
+ * To write to the buffer, issue a private write and send data.=0A=
+ * To read from the buffer, issue a private read.=0A=
+ *=0A=
+ * The mock target also supports sending target interrupt IBIs.=0A=
+ * To issue an IBI, set the 'ibi-magic-num' property to a non-zero number,=
 and=0A=
+ * send that number in a private transaction. The mock target will issue a=
n IBI=0A=
+ * after 1 second.=0A=
+ *=0A=
+ * It also supports a handful of CCCs that are typically used when probing=
 I3C=0A=
+ * devices.=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ */=0A=
+=0A=
+#include "qemu/osdep.h"=0A=
+#include "qemu/timer.h"=0A=
+#include "hw/i3c/i3c.h"=0A=
+=0A=
+#define TYPE_MOCK_I3C_TARGET "mock-i3c-target"=0A=
+OBJECT_DECLARE_SIMPLE_TYPE(MockI3cTargetState, MOCK_I3C_TARGET)=0A=
+=0A=
+struct MockI3cTargetState {=0A=
+    I3CTarget parent_obj;=0A=
+=0A=
+    /* General device state */=0A=
+    bool can_ibi;=0A=
+    QEMUTimer qtimer;=0A=
+    size_t p_buf;=0A=
+    uint8_t *buf;=0A=
+=0A=
+    /* For Handing CCCs. */=0A=
+    bool in_ccc;=0A=
+    I3CCCC curr_ccc;=0A=
+    uint8_t ccc_byte_offset;=0A=
+=0A=
+    struct {=0A=
+        uint32_t buf_size;=0A=
+        uint8_t ibi_magic;=0A=
+    } cfg;=0A=
+};=0A=
+=0A=
+#endif=0A=
diff --git a/hw/i3c/mock-i3c-target.c b/hw/i3c/mock-i3c-target.c=0A=
new file mode 100644=0A=
index 0000000000..875cd7c7d0=0A=
--- /dev/null=0A=
+++ b/hw/i3c/mock-i3c-target.c=0A=
@@ -0,0 +1,298 @@=0A=
+/*=0A=
+ * Mock I3C Device=0A=
+ *=0A=
+ * Copyright (c) 2025 Google LLC=0A=
+ *=0A=
+ * The mock I3C device can be thought of as a simple EEPROM. It has a buff=
er,=0A=
+ * and the pointer in the buffer is reset to 0 on an I3C STOP.=0A=
+ * To write to the buffer, issue a private write and send data.=0A=
+ * To read from the buffer, issue a private read.=0A=
+ *=0A=
+ * The mock target also supports sending target interrupt IBIs.=0A=
+ * To issue an IBI, set the 'ibi-magic-num' property to a non-zero number,=
 and=0A=
+ * send that number in a private transaction. The mock target will issue a=
n IBI=0A=
+ * after 1 second.=0A=
+ *=0A=
+ * It also supports a handful of CCCs that are typically used when probing=
 I3C=0A=
+ * devices.=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ */=0A=
+=0A=
+#include "qemu/osdep.h"=0A=
+#include "qemu/log.h"=0A=
+#include "trace.h"=0A=
+#include "hw/i3c/i3c.h"=0A=
+#include "hw/i3c/mock-i3c-target.h"=0A=
+#include "hw/core/irq.h"=0A=
+#include "hw/core/qdev-properties.h"=0A=
+#include "qapi/error.h"=0A=
+#include "qemu/module.h"=0A=
+=0A=
+#define IBI_DELAY_NS (1 * 1000 * 1000)=0A=
+=0A=
+static uint32_t mock_i3c_target_rx(I3CTarget *i3c, uint8_t *data,=0A=
+                                   uint32_t num_to_read)=0A=
+{=0A=
+    MockI3cTargetState *s =3D MOCK_I3C_TARGET(i3c);=0A=
+    uint32_t i;=0A=
+=0A=
+    /* Bounds check. */=0A=
+    if (s->p_buf =3D=3D s->cfg.buf_size) {=0A=
+        return 0;=0A=
+    }=0A=
+=0A=
+    for (i =3D 0; i < num_to_read; i++) {=0A=
+        data[i] =3D s->buf[s->p_buf];=0A=
+        trace_mock_i3c_target_rx(data[i]);=0A=
+        s->p_buf++;=0A=
+        if (s->p_buf =3D=3D s->cfg.buf_size) {=0A=
+            break;=0A=
+        }=0A=
+    }=0A=
+=0A=
+    /* Return the number of bytes we're sending to the controller. */=0A=
+    return i;=0A=
+}=0A=
+=0A=
+static void mock_i3c_target_ibi_timer_start(MockI3cTargetState *s)=0A=
+{=0A=
+    int64_t now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);=0A=
+    timer_mod(&s->qtimer, now + IBI_DELAY_NS);=0A=
+}=0A=
+=0A=
+static int mock_i3c_target_tx(I3CTarget *i3c, const uint8_t *data,=0A=
+                              uint32_t num_to_send, uint32_t *num_sent)=0A=
+{=0A=
+    MockI3cTargetState *s =3D MOCK_I3C_TARGET(i3c);=0A=
+    int ret;=0A=
+    uint32_t to_write;=0A=
+=0A=
+    if (s->cfg.ibi_magic && num_to_send =3D=3D 1 && s->cfg.ibi_magic =3D=
=3D *data) {=0A=
+        mock_i3c_target_ibi_timer_start(s);=0A=
+        return 0;=0A=
+    }=0A=
+=0A=
+    /* Bounds check. */=0A=
+    if (num_to_send + s->p_buf > s->cfg.buf_size) {=0A=
+        to_write =3D s->cfg.buf_size - s->p_buf;=0A=
+        ret =3D -1;=0A=
+    } else {=0A=
+        to_write =3D num_to_send;=0A=
+        ret =3D 0;=0A=
+    }=0A=
+    for (uint32_t i =3D 0; i < to_write; i++) {=0A=
+        trace_mock_i3c_target_tx(data[i]);=0A=
+        s->buf[s->p_buf] =3D data[i];=0A=
+        s->p_buf++;=0A=
+    }=0A=
+    return ret;=0A=
+}=0A=
+=0A=
+static int mock_i3c_target_event(I3CTarget *i3c, enum I3CEvent event)=0A=
+{=0A=
+    MockI3cTargetState *s =3D MOCK_I3C_TARGET(i3c);=0A=
+=0A=
+    trace_mock_i3c_target_event(event);=0A=
+    if (event =3D=3D I3C_STOP) {=0A=
+        s->in_ccc =3D false;=0A=
+        s->curr_ccc =3D 0;=0A=
+        s->ccc_byte_offset =3D 0;=0A=
+        s->p_buf =3D 0;=0A=
+    }=0A=
+=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static int mock_i3c_target_handle_ccc_read(I3CTarget *i3c, uint8_t *data,=
=0A=
+                                           uint32_t num_to_read,=0A=
+                                           uint32_t *num_read)=0A=
+{=0A=
+    MockI3cTargetState *s =3D MOCK_I3C_TARGET(i3c);=0A=
+=0A=
+    switch (s->curr_ccc) {=0A=
+    case I3C_CCCD_GETMXDS:=0A=
+        /* Default data rate for I3C. */=0A=
+        while (s->ccc_byte_offset < num_to_read) {=0A=
+            if (s->ccc_byte_offset >=3D 2) {=0A=
+                break;=0A=
+            }=0A=
+            data[s->ccc_byte_offset] =3D 0;=0A=
+            *num_read =3D s->ccc_byte_offset;=0A=
+            s->ccc_byte_offset++;=0A=
+        }=0A=
+        break;=0A=
+    case I3C_CCCD_GETCAPS:=0A=
+        /* Support I3C version 1.1.x, no other features. */=0A=
+        while (s->ccc_byte_offset < num_to_read) {=0A=
+            if (s->ccc_byte_offset >=3D 2) {=0A=
+                break;=0A=
+            }=0A=
+            if (s->ccc_byte_offset =3D=3D 0) {=0A=
+                data[s->ccc_byte_offset] =3D 0;=0A=
+            } else {=0A=
+                data[s->ccc_byte_offset] =3D 0x01;=0A=
+            }=0A=
+            *num_read =3D s->ccc_byte_offset;=0A=
+            s->ccc_byte_offset++;=0A=
+        }=0A=
+        break;=0A=
+    case I3C_CCCD_GETMWL:=0A=
+    case I3C_CCCD_GETMRL:=0A=
+        /* MWL/MRL is MSB first. */=0A=
+        while (s->ccc_byte_offset < num_to_read) {=0A=
+            if (s->ccc_byte_offset >=3D 2) {=0A=
+                break;=0A=
+            }=0A=
+            data[s->ccc_byte_offset] =3D (s->cfg.buf_size &=0A=
+                                        (0xff00 >> (s->ccc_byte_offset * 8=
))) >>=0A=
+                                        (8 - (s->ccc_byte_offset * 8));=0A=
+            s->ccc_byte_offset++;=0A=
+            *num_read =3D num_to_read;=0A=
+        }=0A=
+        break;=0A=
+    case I3C_CCC_ENTDAA:=0A=
+    case I3C_CCCD_GETPID:=0A=
+    case I3C_CCCD_GETBCR:=0A=
+    case I3C_CCCD_GETDCR:=0A=
+        /* Nothing to do. */=0A=
+        break;=0A=
+    default:=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "Unhandled CCC 0x%.2x\n", s->curr_c=
cc);=0A=
+        return -1;=0A=
+    }=0A=
+=0A=
+    trace_mock_i3c_target_handle_ccc_read(*num_read, num_to_read);=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static int mock_i3c_target_handle_ccc_write(I3CTarget *i3c, const uint8_t =
*data,=0A=
+                                            uint32_t num_to_send,=0A=
+                                            uint32_t *num_sent)=0A=
+{=0A=
+    MockI3cTargetState *s =3D MOCK_I3C_TARGET(i3c);=0A=
+=0A=
+    if (!s->curr_ccc) {=0A=
+        s->in_ccc =3D true;=0A=
+        s->curr_ccc =3D *data;=0A=
+        trace_mock_i3c_target_new_ccc(s->curr_ccc);=0A=
+    }=0A=
+=0A=
+    *num_sent =3D 1;=0A=
+    switch (s->curr_ccc) {=0A=
+    case I3C_CCC_ENEC:=0A=
+    case I3C_CCCD_ENEC:=0A=
+        s->can_ibi =3D true;=0A=
+        break;=0A=
+    case I3C_CCC_DISEC:=0A=
+    case I3C_CCCD_DISEC:=0A=
+        s->can_ibi =3D false;=0A=
+        break;=0A=
+    case I3C_CCC_ENTDAA:=0A=
+    case I3C_CCC_SETAASA:=0A=
+    case I3C_CCC_RSTDAA:=0A=
+    case I3C_CCCD_SETDASA:=0A=
+    case I3C_CCCD_GETPID:=0A=
+    case I3C_CCCD_GETBCR:=0A=
+    case I3C_CCCD_GETDCR:=0A=
+    case I3C_CCCD_GETMWL:=0A=
+    case I3C_CCCD_GETMRL:=0A=
+    case I3C_CCCD_GETMXDS:=0A=
+    case I3C_CCCD_GETCAPS:=0A=
+        /* Nothing to do. */=0A=
+        break;=0A=
+    default:=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "Unhandled CCC 0x%.2x\n", s->curr_c=
cc);=0A=
+        return -1;=0A=
+    }=0A=
+=0A=
+    trace_mock_i3c_target_handle_ccc_write(*num_sent, num_to_send);=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static void mock_i3c_target_do_ibi(MockI3cTargetState *s)=0A=
+{=0A=
+    if (!s->can_ibi) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    trace_mock_i3c_target_do_ibi(s->parent_obj.address, true);=0A=
+    int nack =3D i3c_target_send_ibi(&s->parent_obj, s->parent_obj.address=
,=0A=
+                                   /*is_recv=3D*/true);=0A=
+    /* Getting NACKed isn't necessarily an error, just print it out. */=0A=
+    if (nack) {=0A=
+        trace_mock_i3c_target_do_ibi_nack("sending");=0A=
+    }=0A=
+    nack =3D i3c_target_ibi_finish(&s->parent_obj, 0x00);=0A=
+    if (nack) {=0A=
+        trace_mock_i3c_target_do_ibi_nack("finishing");=0A=
+    }=0A=
+}=0A=
+=0A=
+static void mock_i3c_target_timer_elapsed(void *opaque)=0A=
+{=0A=
+    MockI3cTargetState *s =3D MOCK_I3C_TARGET(opaque);=0A=
+    timer_del(&s->qtimer);=0A=
+    mock_i3c_target_do_ibi(s);=0A=
+}=0A=
+=0A=
+static void mock_i3c_target_reset(I3CTarget *i3c)=0A=
+{=0A=
+    MockI3cTargetState *s =3D MOCK_I3C_TARGET(i3c);=0A=
+    s->can_ibi =3D false;=0A=
+}=0A=
+=0A=
+static void mock_i3c_target_realize(DeviceState *dev, Error **errp)=0A=
+{=0A=
+    MockI3cTargetState *s =3D MOCK_I3C_TARGET(dev);=0A=
+    s->buf =3D g_new0(uint8_t, s->cfg.buf_size);=0A=
+    mock_i3c_target_reset(&s->parent_obj);=0A=
+}=0A=
+=0A=
+static void mock_i3c_target_init(Object *obj)=0A=
+{=0A=
+    MockI3cTargetState *s =3D MOCK_I3C_TARGET(obj);=0A=
+    s->can_ibi =3D false;=0A=
+=0A=
+    /* For IBIs. */=0A=
+    timer_init_ns(&s->qtimer, QEMU_CLOCK_VIRTUAL, mock_i3c_target_timer_el=
apsed,=0A=
+                  s);=0A=
+}=0A=
+=0A=
+static const Property remote_i3c_props[] =3D {=0A=
+    /* The size of the internal buffer. */=0A=
+    DEFINE_PROP_UINT32("buf-size", MockI3cTargetState, cfg.buf_size, 0x100=
),=0A=
+    /*=0A=
+     * If the mock target receives this number, it will issue an IBI after=
=0A=
+     * 1 second. Disabled if the IBI magic number is 0.=0A=
+     */=0A=
+    DEFINE_PROP_UINT8("ibi-magic-num", MockI3cTargetState, cfg.ibi_magic, =
0x00),=0A=
+};=0A=
+=0A=
+static void mock_i3c_target_class_init(ObjectClass *klass, const void *dat=
a)=0A=
+{=0A=
+    DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    I3CTargetClass *k =3D I3C_TARGET_CLASS(klass);=0A=
+=0A=
+    dc->realize =3D mock_i3c_target_realize;=0A=
+    k->event =3D mock_i3c_target_event;=0A=
+    k->recv =3D mock_i3c_target_rx;=0A=
+    k->send =3D mock_i3c_target_tx;=0A=
+    k->handle_ccc_read =3D mock_i3c_target_handle_ccc_read;=0A=
+    k->handle_ccc_write =3D mock_i3c_target_handle_ccc_write;=0A=
+=0A=
+    device_class_set_props(dc, remote_i3c_props);=0A=
+}=0A=
+=0A=
+static const TypeInfo mock_i3c_target_types[] =3D {=0A=
+    {=0A=
+        .name          =3D TYPE_MOCK_I3C_TARGET,=0A=
+        .parent        =3D TYPE_I3C_TARGET,=0A=
+        .instance_size =3D sizeof(MockI3cTargetState),=0A=
+        .instance_init =3D mock_i3c_target_init,=0A=
+        .class_init    =3D mock_i3c_target_class_init,=0A=
+    },=0A=
+};=0A=
+=0A=
+DEFINE_TYPES(mock_i3c_target_types)=0A=
+=0A=
diff --git a/hw/i3c/Kconfig b/hw/i3c/Kconfig=0A=
index ecec77d6fc..d5c6d4049b 100644=0A=
--- a/hw/i3c/Kconfig=0A=
+++ b/hw/i3c/Kconfig=0A=
@@ -3,3 +3,13 @@ config I3C=0A=
 =0A=
 config DW_I3C=0A=
     bool=0A=
+=0A=
+config I3C_DEVICES=0A=
+    # Device group for i3c devices which can reasonably be user-plugged to=
 any=0A=
+    # board's i3c bus.=0A=
+    bool=0A=
+=0A=
+config MOCK_I3C_TARGET=0A=
+    bool=0A=
+    select I3C=0A=
+    default y if I3C_DEVICES=0A=
diff --git a/hw/i3c/meson.build b/hw/i3c/meson.build=0A=
index 83d75e7d5c..e614b18712 100644=0A=
--- a/hw/i3c/meson.build=0A=
+++ b/hw/i3c/meson.build=0A=
@@ -2,4 +2,5 @@ i3c_ss =3D ss.source_set()=0A=
 i3c_ss.add(when: 'CONFIG_I3C', if_true: files('core.c'))=0A=
 i3c_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_i3c.c'))=0A=
 i3c_ss.add(when: 'CONFIG_DW_I3C', if_true: files('dw-i3c.c'))=0A=
+i3c_ss.add(when: 'CONFIG_MOCK_I3C_TARGET', if_true: files('mock-i3c-target=
.c'))=0A=
 system_ss.add_all(when: 'CONFIG_I3C', if_true: i3c_ss)=0A=
diff --git a/hw/i3c/trace-events b/hw/i3c/trace-events=0A=
index 39f33d9a50..9e58edec99 100644=0A=
--- a/hw/i3c/trace-events=0A=
+++ b/hw/i3c/trace-events=0A=
@@ -36,3 +36,13 @@ legacy_i2c_recv(uint8_t byte) "Legacy I2C recv 0x%" PRIx=
8=0A=
 legacy_i2c_send(uint8_t byte) "Legacy I2C send 0x%" PRIx8=0A=
 legacy_i2c_start_transfer(uint8_t address, bool is_recv) "Legacy I2C START=
 with address 0x%" PRIx8 " is_recv=3D%d"=0A=
 legacy_i2c_end_transfer(void) "Legacy I2C STOP"=0A=
+=0A=
+# mock-target.c=0A=
+mock_i3c_target_rx(uint8_t byte) "I3C mock target read 0x%" PRIx8=0A=
+mock_i3c_target_tx(uint8_t byte) "I3C mock target write 0x%" PRIx8=0A=
+mock_i3c_target_event(uint8_t event) "I3C mock target event 0x%" PRIx8=0A=
+mock_i3c_target_handle_ccc_read(uint32_t num_read, uint32_t num_to_read) "=
I3C mock target read %" PRId32 "/%" PRId32 " bytes"=0A=
+mock_i3c_target_new_ccc(uint8_t ccc) "I3C mock target handle CCC 0x%" PRIx=
8=0A=
+mock_i3c_target_handle_ccc_write(uint32_t num_sent, uint32_t num_to_send) =
"I3C mock target send %" PRId32 "/%" PRId32 " bytes"=0A=
+mock_i3c_target_do_ibi(uint8_t address, bool is_recv) "I3C mock target IBI=
 with address 0x%" PRIx8 " RnW=3D%d"=0A=
+mock_i3c_target_do_ibi_nack(const char *reason) "NACKed from controller wh=
en %s target interrupt"=0A=
-- =0A=
2.43.0=0A=

