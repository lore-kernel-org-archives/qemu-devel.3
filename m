Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 281F6CA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 13:15:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut4Lm-0008IH-2l; Mon, 01 Sep 2025 09:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1ut2XW-0004L7-DI
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:17:34 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1ut2XR-0004lm-Sz
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:17:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1756725450; x=1788261450;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=FGJpoV60L72HE0x3+fim62b3dV9YFJe48z/idYWR92Q=;
 b=EaV+EM5jZsZ8zxIIbodx1w4PnNb+o1Z8ccJ6cGzxkKloVfL2mAWU71GT
 yfJOZ7tI6b6eCBhOHXPWkA3dmLIy8Bl55o4Bo8Mf6m19mgHkvYkZACuk9
 dOvNKMgMMHNRuhPatATl3xQyADbDRWVibAEQcMgVLN8zpqcJ1e1J/VAp5
 GFaPqWKoRqqXcjMauN+j92njjxcK4KtjESPzUQs0OYj2XxvWvWsGct9Ic
 zgcPE8v/hAPVIq6pzRPdv6t6IPP1pSGENewW+CCQYg8W7FPmrjmifUuAF
 zolkuQO2/n9v1nFZ1h8hgcTvC4czHY6JG+yt5V7bx5ZnmOqDcSViK/tBB Q==;
X-CSE-ConnectionGUID: JudlwTQiRyGD2Qhn1uEXfQ==
X-CSE-MsgGUID: xYm2W393RUuFRsKVNYXDAQ==
X-IronPort-AV: E=Sophos;i="6.18,225,1751234400"; d="scan'208";a="42537902"
X-MGA-submission: =?us-ascii?q?MDEvBGIlF+1J+lC0riRIAufRbzllD7gimux0/s?=
 =?us-ascii?q?r1YCseXjeYWgpauPbH0Fcj1A4sLokqYMaFvbuz8QEa2d9nSRHM+UYGyG?=
 =?us-ascii?q?qCxbD/LDR/veKVs94JJVXoNgII+SXTeM4/V6FtTsRlwVUP0kvoZBpeUG?=
 =?us-ascii?q?HCRYs792pcA/f0ffFGNPrQ6g=3D=3D?=
Received: from mail-westeuropeazon11010070.outbound.protection.outlook.com
 (HELO AM0PR83CU005.outbound.protection.outlook.com) ([52.101.69.70])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 01 Sep 2025 13:17:22 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZaeGkMFt5vnse+8dFW4Xvw5CDKk76ElZ2l6tSvz/9HjxyQM+ZK+ILnvEUFMPx4897jQu9Hv7KZXpn3BFtTR58ZeDqPqQU7YjXo4iICt4vbMLLo1n84LNggDg+XOefzm9FGC3zXW0bibTjfaftcHqYjr8AOacGXTHqZAmwAurMax7rbjf5tBPx2yvsW8u6lfD+dCnhBsoVUWAGDulrrFdayCWK8J91+9CmthGdonWlVRttAFe9KMxJhRSxGpn8YRXx5VFMdi1AErjEz9tF3C3jElsxMYU6751uzz+BXB+XLn//4/Rv8DMN4vMTbhYd4jW4JJamh1KFVw5VG8QOx+6pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBtfnv3f4oOZRftunLF8Qd82qIrHgWAjDrwCpwtzhOo=;
 b=Epir4qojlUNsQlCb1t9/G3D7PbqhqYUFFtnQCnv8TwH9vmsgvMoai5PqWZoYOqnd5/ixdDAttx7fIBo/brdH8v/kscGjtFJovMLoZxqoBVjWuxQ5cjdTnCMsyLG7B3e8Yl5cS9pqsmgZFwSiPEc0ap4TR/Klf3ckGH7vx4sd8hRT27ip7C+O/hQD/d4kWaXikNxAmMjjdcNK13C+26PnFHYyZX2Mw9f86U0Or3fAqinVKhQnVs+v4XC1kyAyih5ABsDJuCoW15I/kHySH94P8ncSKNd9+QTQzci2J6DEoVQJjqTPddAeJnQS1tmdWVwlEVTE2Pcm+dmRPCemFNxfVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBtfnv3f4oOZRftunLF8Qd82qIrHgWAjDrwCpwtzhOo=;
 b=qlgU0bE4d/UYrc4hCmy8El0MKHWmQDakzv5XmW+ttYZyQu+OwriLsZDH0dvs+AC/7s4swZxUE+pAEtmtbBF9Co4iKfjvZ4Ke4Ybb20y1AktENqzM/mV9qw2aACZ/7Ww7j7p+2YP3c8lldBY54OCcFDmAv7yiGyUv+j7VndxqTJloz6EYUhbYlu3j+u+wUaUYOBd+z/KGoQt2yFik9gaLJrLhHy/MahNb/vvkTZhaob7UwpIsRd+5/LMXxDP+4qjaUILWBX6U0VR3m6KPLB4gGVOSiTvPAnYJje7TVbDwAjs7uarV/5GLAei4UUv+HgOftYrlZ04jHZdLgJZyHmSbRA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PAVPR07MB9215.eurprd07.prod.outlook.com (2603:10a6:102:317::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Mon, 1 Sep
 2025 11:17:17 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%6]) with mapi id 15.20.9073.026; Mon, 1 Sep 2025
 11:17:17 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "kevin.tian@intel.com"
 <kevin.tian@intel.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "minwoo.im@samsung.com" <minwoo.im@samsung.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH 0/5] intel_iommu: Add PRI support
Thread-Topic: [PATCH 0/5] intel_iommu: Add PRI support
Thread-Index: AQHcGzH69L22Lrrt0EKlQsUSfgWejw==
Date: Mon, 1 Sep 2025 11:17:17 +0000
Message-ID: <20250901111630.1018573-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PAVPR07MB9215:EE_
x-ms-office365-filtering-correlation-id: ce613c1c-0209-40d1-c3c7-08dde9491c8f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?MsajPI9MhM0urvx6fOa1MzPTCNS+aDwStw2DEPBx+NSz9xIHql+OwZauuD?=
 =?iso-8859-1?Q?fbsnJI1i+baHrANumkcwmza7FCFPXsoB9irf9rG9DNADCS1HRo9jNUwZnK?=
 =?iso-8859-1?Q?13Wdt15aGixIiMoRzRxiyiP0HlvJfnyWKHCZKkycrEapk/xHlV80vm9Ylx?=
 =?iso-8859-1?Q?g17EkwUSXMaiyNBPNBuTulgNOieEZvaYJboAVXbzF7qh2qz0CABurZwwzm?=
 =?iso-8859-1?Q?XMgkKIQsyFGL4dRtNt8UODo+deBU+wp4K75Z+dWKwfn3mD553V+GZ56+0u?=
 =?iso-8859-1?Q?i8FVtwXAnW8D+WNRh1SgmnMjNzzDZP1U1aO6AyJYi817xZq2zGGQTIFLFF?=
 =?iso-8859-1?Q?x2+/Moh4y6aZTdNvZesljuUuhy5aOe+G3kNqQrbKyYirHLUYnILz+Rau9H?=
 =?iso-8859-1?Q?K6nTQEgl0RLTBtWa9WK0HuRqkKZl9ogoZD8u/z0zF9ztC7/U9AADpuPesY?=
 =?iso-8859-1?Q?T9mPTlz0399/+N3rAnMjL9mDhKdWnCr13mEwnpbZ1P0M2d97jirezc0KWS?=
 =?iso-8859-1?Q?tIL+KGreq3WrwwVOlzsrgQ4izGAaLLSfoXXYzYWxtlFVVgK3hkYqS2xTtx?=
 =?iso-8859-1?Q?izbuMG4T2WWEm7Qb7RucR3OTQ3FQNtArSAhNbZ3GwXPbrozYiG7dFHiomx?=
 =?iso-8859-1?Q?WCUSs5Y1nGdMDstzBGn8/sJk2Ky64kkGbYmTbFlaMSVlSPKhKUk2uZzahk?=
 =?iso-8859-1?Q?Le06SHziRWpnvI8y1c4dqZ3B5KLSUVM48FHzOWooDeJ02HmKJEdQCd1fj7?=
 =?iso-8859-1?Q?fv/NqVvZStHqlJ1VOnxI5s+aWWNfqRatBVUbOhFEi3hf42oJR6IZkV2uTg?=
 =?iso-8859-1?Q?0tJQD2C9BeVS9bxDKIph5Vq8rXY6rNCR9ZwmTFnP+S2c1MpdGKadt3pQsG?=
 =?iso-8859-1?Q?KMtu2If88K5+zz2b0rKlsTFPRz1j/S22MPx0/DxTSbjb7EJK8iVzSblS8w?=
 =?iso-8859-1?Q?JXwMRoNgEUfH0c7FV8bwS2BaLZoB6mOVpbP4kOlKiumOERoMRHpPvGeaJ/?=
 =?iso-8859-1?Q?KhvX/LI3HaXzNf5qP1VaYs/BpdZh+5Zn0oJ8ycq442YYIdxQj2+D7/+F4l?=
 =?iso-8859-1?Q?1J8L5DFpslFIa7WCa6n4Lsp4xO3ZssD5H5oOn0rLF5varXcm7xX6m+IZh3?=
 =?iso-8859-1?Q?3ezWoaQk5z+sw+tDUpMSnno10U70kbXE5B7ah+tD4GZKD4dbJPjfLgtGT5?=
 =?iso-8859-1?Q?XBxJ6Y9Hu1QwhvPRTHZ4gq9UYffqU2aaOY3w8SU3HSE+eQzNSSTvlN4Qck?=
 =?iso-8859-1?Q?5Ev0fLooqqtTEvIRhNpPV3IU+dJ9UfSE3NDnANemDFxWOSa1PR9nFP8fha?=
 =?iso-8859-1?Q?2fDdL7dTuDOlN/y5gy6URQT0twlW8lLNxuISWVjGFmY96PAq5tE24xiScx?=
 =?iso-8859-1?Q?zcqUqBFiHbrfDIJO93YaWGPzD/bWlpcyGbRgeBMcOjGJK4J2MlKMEnIfCi?=
 =?iso-8859-1?Q?4+NYA6ddqXjflTeFNqRkcJ5m3bqkDQIiRGCZ34+xCrnOYesw3iQMljxCZA?=
 =?iso-8859-1?Q?TEm7GpyQBA09AspyK4ptb5c8ygT50FERLxZELJCWPoVTgYOnWWxtw9ePS/?=
 =?iso-8859-1?Q?uO3ho5M=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cC9y/HWCc98eF2eJoa86NHawLK0hEUBgv9k3yuQBm4oCRUX4nt8wUtgFoP?=
 =?iso-8859-1?Q?4v44TWNnu9B1ASUBiBJPa4GcVkXWiZ4hIGnBcta4t434Az7BDl1MbiqqpZ?=
 =?iso-8859-1?Q?LNuG34uShcSLNBhYX5mmvWsLZ9EQcbWpdwA5DgK6Zi8JkT7JfNeW4onrbO?=
 =?iso-8859-1?Q?+EtwDYXDuSnlmsshdzW2c5xPC5Mkon0LqcRAV5AeI9RczxSQHVxMNB5rKx?=
 =?iso-8859-1?Q?Zn5AJ0pKYyjMrY2bq4NLVw4Sc4PUs93AwgVnxkAy+vh7ehW3bO9c8q+8kC?=
 =?iso-8859-1?Q?lC6QX9rMi2PGjShCZeX3U88zZTquOlh9gfK9Pnr4bKJC9YkoAI2FA+6P1S?=
 =?iso-8859-1?Q?+jcBNcy0609z5rdavZK65jn+4Lj3471LPCxX/PLgfRA61xDfxA8lj8KpzG?=
 =?iso-8859-1?Q?i/eLrzX4fuyI/qeOMYlFSCZsW0PXxXVazzcUJ+A58EMzoC5/0KLrrKTRwu?=
 =?iso-8859-1?Q?9JeSYwf/0nA0baxp/X05Fd0VvVjQICz6z9EghQzulT8Bdq0rhRKMIoVw5x?=
 =?iso-8859-1?Q?vDDGNGVDFq34StogJZIJd4QXZw/RrIUefEjKfLrNnjlsCHftNO/2lODTJD?=
 =?iso-8859-1?Q?BcRHsHzuzFzIRyErjK/q7uw06uKB29adPwCG+zDezyf/NFMmRRS/6Kssva?=
 =?iso-8859-1?Q?ttD9zSJUVBOX//+42ERHgDsuYs9ifJj7AyDSM8FmfrpS4eZopwqKmY69G/?=
 =?iso-8859-1?Q?5+FG4FBxREMqcUycs3pWSqX1cpECiEt+OawIfIgdufKQiUJg0am3PNUalC?=
 =?iso-8859-1?Q?ehiRQavZ1E8MV80AOe85shZA0Sdhp5O69w7gkIVixtCZrhc8YUYhbcrJY5?=
 =?iso-8859-1?Q?K/mfUPKqnp/gUJh9RebqAEXlWPxvBn2cD8Y5OBIEYeRTxVjQ8kv48clSVN?=
 =?iso-8859-1?Q?NBfbBM0nxBtGgfvCVWhWd7o2eYOHq5V1DiaH5h3tUioE2BsgRw+sQJjvIp?=
 =?iso-8859-1?Q?OwmpOwGeR9b3+cXSvKV+aj+RFSWSA1cpoRRE3jaiNTyjCsDImwNmsqnfIa?=
 =?iso-8859-1?Q?4/mqkggBrJABB3uGbpxq/Tt/Qmp3M7d0TdO10kh07AeEj10JU/4qVecjb9?=
 =?iso-8859-1?Q?nfq/ooQ/1yEAl5isfeMTZKhPWbpa71wguujHuv0OBsRKJHpieqNE4mWyPx?=
 =?iso-8859-1?Q?edKnNlzSzMAA+C+lCMURQQUov7zkUuZn2203lhNFfdpGcqbpgBYx9KPeEY?=
 =?iso-8859-1?Q?hKuBo+0O1cCjnj/SLtRogxzjvrNgu6adEJMginOJHT8SUVT+KutTSlM/yH?=
 =?iso-8859-1?Q?hRf9c4KJ/SbsvVjACFz0/D1mAH2gt+p1lL242EnV3c3BaAEmtq8+TSp9wW?=
 =?iso-8859-1?Q?V4vjJGLGQz0IPVMfLIc/24fB6b8qrGXJJBAalUaxo8T4WZTKGB0UsPpmaw?=
 =?iso-8859-1?Q?qfJ7xqea5BahtEWHxSp32V7kmHzS6J5WJ8z8jNFKZh+NaVbUgAQdm+DNyS?=
 =?iso-8859-1?Q?1OFRRolz0HQDkoe5pU23l6xpxadjKGop726GplmmiXe6/i5oJUgoJWKYS1?=
 =?iso-8859-1?Q?zYWwsn/Z0ZFv+rBcEtr64qoLWMc2A1+UKuwI+rDS0rSwliLgxeNICCDv8T?=
 =?iso-8859-1?Q?Vihg5vZCzeVSbdlCtz0HhWAhZpWTZt1qx3jl8QD2MVLPaWYKT/XlPhVuT/?=
 =?iso-8859-1?Q?0ZMGpkXt3UbNoJYi9Yt/8vuEFlFO4wbXXD+LyfmfC0UqsWiNhQzGk9zkCs?=
 =?iso-8859-1?Q?G5TlV7mWynFiAcIJCZI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce613c1c-0209-40d1-c3c7-08dde9491c8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 11:17:17.7407 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t8moBYb8vbS9d0Q0Iys8Y0dopZRRNObUK709mNuiBQuj27mHb97IQGym2WdwH1Tr5pnOEDAnogsyCjsBJwx+gIADFTJTFj0gVb57bl6xM07gKsrEN10wI2NjXQml23gx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR07MB9215
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 01 Sep 2025 09:13:15 -0400
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

This patch set belongs to a list of series that add SVM support for VT-d.
Here, we focus on implementing the PRI API exposed through the PCIIOMMUOps.

This work is based on the VT-d specification version 4.1 (March 2023).

What is PRI?
''''''''''''

PRI (Page Request Interface) is a PCIe-level protocol that enables PCIe dev=
ices
to request page fault resolutions to the kernel through an IOMMU. PRI combi=
ned
with ATS are the 2 cornerstones of a technology called SVM (Shared Virtual
Memory) or SVA (Shared Virtual Addressing) which allows PCIe devices to rea=
d
from and write to the memory of userspace applications without requiring pa=
ge
pinning.

Resources
'''''''''

Here is a link to our GitHub repository where you can find:
    - Qemu with all the patches for SVM
        - ATS
        - PRI
        - Device IOTLB invalidations
        - Requests with already pre-translated addresses
    - A demo device
    - A simple driver for the demo device
    - A userspace program (for testing and demonstration purposes)

https://github.com/BullSequana/Qemu-in-guest-SVM-demo

Clement Mathieu--Drif (5):
  pcie: Add a way to get the outstanding page request allocation (pri)
    from the config space.
  intel_iommu: Bypass barrier wait descriptor
  intel_iommu: Declare PRI constants and structures
  intel_iommu: Declare registers for PRI
  intel_iommu: Add PRI operations support

 hw/i386/intel_iommu.c          | 337 ++++++++++++++++++++++++++++++++-
 hw/i386/intel_iommu_internal.h |  51 +++++
 hw/pci/pcie.c                  |   8 +
 include/hw/i386/intel_iommu.h  |   1 +
 include/hw/pci/pcie.h          |   1 +
 5 files changed, 397 insertions(+), 1 deletion(-)

--=20
2.51.0=

