Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1266EE83EED
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 08:24:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnY8p-0002R9-SN; Wed, 04 Feb 2026 03:21:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnY8n-0002OY-G2; Wed, 04 Feb 2026 03:21:37 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnY8m-0003VZ-0Q; Wed, 04 Feb 2026 03:21:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jyNyojq1f/qt89PZB3NfwOXAfw1Q80t5Ji4tF2bTukxCuQREaEotHIZoxtLyVXSqrMvzH3VPwr55fVm/mIe5p1zv2VlZKuAwrcd3TLc6GJAEeU7INVK9NHFcsgaNB1PDmR4NgTLtVHEPhN+zkbE3lwb3XnIgsF3z4elIW4wRG+1DeUdY43HahsdFGiagUuU7TjUcdECcG0Yd3bZpBUZtEPxDE/0SvfHHVLIgkGp1Iv5hvIlXHRorJwqUhw3CYCPQvvwYsHyG8CXRynVvWUmfuQblT40Z6dSY0yRSd+hYoyuXck1hlCfHauGndlpS/eRabqh0ettihoAN0lSGfve1OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BwYEL+jW3dutlUOz7FXuK3J7DbyAkGZJ5u1q4FUhnjA=;
 b=yaAyXwLBwj3hGMJ+oCKoIN0DVmcL2ZcymjZb/25Nt14oXJ7SCq6Mg8w3UyL16W2E974H95x9iDJ0j41Q9stLI6g6ycyzm96MgKSq704NXkdfigh3ZnHA7kvF3L94vzOYwFEIY5IHsqJ9TARSCpvj0moQi1IRcOg9i13gdKv+z89kQDnVqA7deAe/eU2biOTZNtVoqvL5vh+kEIuHTcijPwksZwuZPobKh6A+1XBMHhU9r5SHeHA91pUeumM3hS2O/Ga/0Br5CUc+a+g8x3vxuHViH4CbGjg97Aw7l6MlAB5Hy3MAGQ2+lXH+oEdyCR9LK41cyWqzidYEuh8OEgosgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwYEL+jW3dutlUOz7FXuK3J7DbyAkGZJ5u1q4FUhnjA=;
 b=BvkCfUafmwGNg88UacAFgw8ysQREgWECOL5a25+8o6TSo+cVrfTEuoUHD0y5bXMVgsguZoCaOrh5t8vBWrd3qJVXdj/e4dbqAK5MTRz076b/TjFJJQZ+oR4R5BBnzVHcJQcdCZHGbeeYxXkwCnmh6/AB6cOG7RjakDBmj+TIgjGE2VYUxNgUDftlmcyvFwRQ3FrrRTvE0TuQPN7bMJT8sRcQZUbZ6G2pd+7pJHcrS9RDz+GpeUc/LthgB/TfCdwevCvtumomAKsyqVnR6ZMwBSt4Xm5GPIgs+FWrSRY0o1nVYLInKM3zcm30oZBuLdK3VQYo6EcK7A+p2AglQuzo1g==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by PUZPR06MB5586.apcprd06.prod.outlook.com (2603:1096:301:e8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 08:21:25 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 08:21:25 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "kaneluno1@gmail.com"
 <kaneluno1@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>, Nabih Estefan
 <nabihestefan@google.com>
Subject: [PATCH v7 08/22] hw/arm/aspeed: Attach UART device to AST1700 model
Thread-Topic: [PATCH v7 08/22] hw/arm/aspeed: Attach UART device to AST1700
 model
Thread-Index: AQHcla9AlAFPykSi8kevfv4abjNvJw==
Date: Wed, 4 Feb 2026 08:21:25 +0000
Message-ID: <20260204082113.3955407-9-kane_chen@aspeedtech.com>
References: <20260204082113.3955407-1-kane_chen@aspeedtech.com>
In-Reply-To: <20260204082113.3955407-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|PUZPR06MB5586:EE_
x-ms-office365-filtering-correlation-id: fc29f553-4079-4f88-3dc9-08de63c66349
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?hUbwBf091WiNu36iUuvS35i2oiyJ4IIPIw4w5GBO9jqf+j3CIOvxwnFJoG?=
 =?iso-8859-1?Q?7ci3Mq0OiPxFwS01hUsxqjRvPqTSLRlHJzwE6GqUV3DDrSAWn8Lfd1fs2b?=
 =?iso-8859-1?Q?Gd8+8fxdy79pE9fw45PB3CoqTHZ0DUAG+JUQWedFCqpJqEwMJq3Zc1qY8J?=
 =?iso-8859-1?Q?1oCJwMlZzZOPb/l6g9JZGOYg1Bk4zDaDiYjHvel2n8xj/VyQBYiPTH+jpC?=
 =?iso-8859-1?Q?D1hfSJk8KT7HB1H5SjMPsw+gt59YDnH79QMvIulier/97hCLrGhMvVIhVm?=
 =?iso-8859-1?Q?i9H4B23X0fCOXSRzSO45foozG4xFp/gWKExEvh0gSOvZc9BFARk3v0e2E0?=
 =?iso-8859-1?Q?HBuOoJkVBjmQdMXqRlMEFJwPKKTzaUV2KetohyPFVHDONEIgznHAHEFX7x?=
 =?iso-8859-1?Q?Qz4HCr6/PUilboKEewulCGGzd8/IAPfszjGADG2eaA9iA4Gr6YtX4IGadL?=
 =?iso-8859-1?Q?EBJFgK6fiuX6Y5Nts+WnxXl+xa2t5fpvvmGLYozhCKtxq4nGb3KPOV10TD?=
 =?iso-8859-1?Q?MGBKEvL/zTybiGs28EQtmqgOjoxsN4Cnqq6HwKC7pCqkogkvCgs3LiVgVE?=
 =?iso-8859-1?Q?2jVFqAqs7DL5ezYpzt2xjSPbz4/SqlqQv72PwSd9XSMmmtKOnjSXv5LoAe?=
 =?iso-8859-1?Q?BYYobQyo9Rx1G0FQMBBkB86fyag0AGt88K87IbzQ9Qs/SN9MZW38J7QEEN?=
 =?iso-8859-1?Q?JGm3pl5GjKQ/e0GifIphNGdNNxg7qWSiFyvGGMHk4mDMZXwYASc/cBlN+y?=
 =?iso-8859-1?Q?jktYQO4GwWB5VRKafqRGRs+3n5T4U0pAKKtK5ZTg2EMZUHeDQBomM8GWKd?=
 =?iso-8859-1?Q?KXlJl8dEVY2sb5Q1denV0MezLAdc4/6gYkJv/VAzxjTM+T8H+PWqeIiyoq?=
 =?iso-8859-1?Q?LJeXoSBJSqCFzTNefNeqwUrjuQ3TK8LHGykh0EZejxQ80z+fetPPu3Ar6S?=
 =?iso-8859-1?Q?C8tTKM2Awhvtd5j7vrDF0vkAKvz+YuNTovUYwjZBtnckgUDaVvZqUH9jSR?=
 =?iso-8859-1?Q?1iwJtxcSmzpgJiEERrohUQFtLKD1k3sxForqhxUkBJoYyCJTRIZIM7mNyd?=
 =?iso-8859-1?Q?s6lYbm/IRAgQVehKvTOWN6l/uH2+q5Ga5eMGerOmOE4fW/czc64zAe3z7E?=
 =?iso-8859-1?Q?Igew7OCyC5YDQnAKVUuRSRSaNp8CkO7l0s7o7QsPhkeBCri8Ilg0uErHGF?=
 =?iso-8859-1?Q?BUKTyQs8onsC8lrKzQNdsIKP/r01dFds1Q6iY2cQVNwBFPx5I2wrIbQEjw?=
 =?iso-8859-1?Q?zJoiIgKWRzJ8sQ4dcTlLf9VZkSoW+SzbwmYb0vrVYWoKFLH3KfU8iE6CrG?=
 =?iso-8859-1?Q?ww7ODqyku9qU9VaQ8s3UR5522t9BbbGPgz3Vt1rZAnib+lwMkrKoGWU3fB?=
 =?iso-8859-1?Q?l5u7xmfijp3BNwGkc9TjCEJVjbnFc9DbLCtp4+05t6H4zM8DFfiDyFTmKB?=
 =?iso-8859-1?Q?3TwleDdCbdineIqIipx9wjnEpIHGa58dOUSNlY8s/r8pBBdDBYYlM62NhZ?=
 =?iso-8859-1?Q?p2QpGQfzn7ev0tDec8N+9G4rfol/mYp5BVXJXYlV+/KMRUmLNtvNwFpMIC?=
 =?iso-8859-1?Q?NMs5Wjrctml5h3au6RZRNgPkHehsxIoDKSTlvX3/sK05o5xAdGXp+KqYpK?=
 =?iso-8859-1?Q?lFVW5ENDIq9tjz9E66v0QhvMW+a20+vmoG1F3X18YE5IhghnXChQedn4bY?=
 =?iso-8859-1?Q?362racCIQ/s5Gwu7QFk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?OVHIrb4sWQxaqOmxVHRJxHrF8D2CqCr/kljpj0LEF37y0MNWhm7JVtNwqf?=
 =?iso-8859-1?Q?MLEhDF1JQecapNNPdKRXDN0mKmjIKuYT9BX616hiUgnHwuyU6HFK04lo3c?=
 =?iso-8859-1?Q?CRkFec1oUCQtankAf5PrF/oTSwWzgna0mTu+MTtV2AAxv2hg4XnFCmkrvT?=
 =?iso-8859-1?Q?L6a5p12q/xRaQg/PCd3Vrkr27X0SBS0vhaGhH8+1DDdh+diwJywYzmQSzI?=
 =?iso-8859-1?Q?EGMo/+aV4Cb+B2/RmLoattAG4X8ZzO2Qc3FyVrCUF+bas5JQzI2VRENaYz?=
 =?iso-8859-1?Q?21GH7QRBWGS2EeD6BMeLY5e4oZUiTMCVAyy8MQlR3L02mqscZJaU9cqMcb?=
 =?iso-8859-1?Q?XmlTM42IMVdbTEZPinumQ/TC4YClqyGzijw0cZFi/IhAuvQVjdrkzBXNkt?=
 =?iso-8859-1?Q?Oi6FHDiRpDV9GzAsmojTEne8NHJ2T80nwIRrD/MFOyUCDCB65r8HPHgOVs?=
 =?iso-8859-1?Q?+lYDtQXcXExYcYtyoMiRKry8qHLIhCBl0/qENisS4FuvA210G1LiQWi9Hs?=
 =?iso-8859-1?Q?fJZ3Ae2NhO9uIw1Lue3KD6zkMIPg5uL50LGKsQ+MHHHosYDu2Vh+IJ3Uwc?=
 =?iso-8859-1?Q?O4cHgp5S/PO2IMjLEepvu0Y0Ro7VSb16iyA+W68Qoq7QMT7sOdVkORKTRX?=
 =?iso-8859-1?Q?Vy3Pn031RdUjVO6sixtkh/b6//KFh9fdxr8IUqLypxCs6O+PxqZfXqkml6?=
 =?iso-8859-1?Q?Cg/xXgZPZp8YA/rtGYwz1TCJ2IoZa14Hb2hLmGSFmJw9hH+Cta3nxaDxef?=
 =?iso-8859-1?Q?PudzdCrijKGSEBsPkAVW+quwnVlA/3zhiuI3u95eH1tcKRHMKqSy0/1bug?=
 =?iso-8859-1?Q?it+Xx2I3Kud8F/0YFp5DXO21iNrE3FTtCw5HY2F8IKI8U+de98gEXdY0Ey?=
 =?iso-8859-1?Q?DKVzzWawLOhlyrxHXjNkW1+0pBBHnWaUo4tF01eeXLxwpcdXIo+ht2Dbga?=
 =?iso-8859-1?Q?zlGCgxFirx9zLcaVR/7GhlR50hbKtHBuXgGGCjfWCbwI58bs8Bea8tCDCB?=
 =?iso-8859-1?Q?U42hdwJehjLnL9U8yT36S/5pg0Os/bEw2HFAqpuYcJydF7OsZUJDM76c4z?=
 =?iso-8859-1?Q?HzMg/GXeeKPikuiEbV+nifgXN6dp5idhJiexzvZt4bTpRfI2uIkkCyNhRQ?=
 =?iso-8859-1?Q?w/TRCDHpoWlGk5Ds55mIV8XM+JV052CE0QDhyJti/Q1OXI+aBNWCZhwEBY?=
 =?iso-8859-1?Q?kT3RbqoaspWnyn2WGrg/wOhGoPWS/FiZaurLjLQdkCPDUXbyny4TkXr5Z9?=
 =?iso-8859-1?Q?dCBx542Gy2nE5k/sxhfhGx71uYLkTl2B1p3qdMxXIw9yiZfyyFGyXx6T8p?=
 =?iso-8859-1?Q?ldF8yvHO3xXBFh5swE2nhdJRkrQPNq4bq2mNt6iy3pm9DRBNyRZD96IIIG?=
 =?iso-8859-1?Q?BYUWJG+9E5bLehfjshO0b5OL2KyOMXuGSEhOSYLPYokpVqwB+Y1RbQdwVr?=
 =?iso-8859-1?Q?03538puiHfpU2GIipvAaCO1/nDIpDLQUcQUZRnljV5c3tfxtH57bq7XnWE?=
 =?iso-8859-1?Q?UgN6Fr5G3PfH3k3qNU/ZEZcRSbXJjzX5yfU+oxqPSjVrVq0IZawFyGh8Zt?=
 =?iso-8859-1?Q?D38gfxvJx9MmcJyQ/pAmGNLYgooZZqh+ZsQUm41vFc/sj9+jAJuxpnSoTA?=
 =?iso-8859-1?Q?82Cdq3DkE14xmko/a/93IXSzFizYbSBfcnKrXgHP+CX7oNzEud48EdJ+9Q?=
 =?iso-8859-1?Q?0dPCEj9h2nvpOQs0RYjjKk8WKus+RemQuL/9mvSg0F/idj01Ibh1JRCbGO?=
 =?iso-8859-1?Q?nkLS0KqAbPuKyQlOQiW7bvMBQS99zRNBKamnvuTmB1eozFdLRLfNKpMqwv?=
 =?iso-8859-1?Q?EKYJUOBHrA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc29f553-4079-4f88-3dc9-08de63c66349
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 08:21:25.3304 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dJm23qkMfakcPq1eZSYKc0GCy/pejrXJ8oMsyj5TpQUIHhF15DgSSaitMCXSXeqhbDmEpajiBAjwkvpm7rDahjBvD0YWlkzI8S0qdEHdle4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5586
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=kane_chen@aspeedtech.com;
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

Connect the UART controller to the AST1700 model by mapping its MMIO=0A=
region.=0A=
=0A=
Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
Reviewed-by: Nabih Estefan <nabihestefan@google.com>=0A=
Tested-by: Nabih Estefan <nabihestefan@google.com>=0A=
---=0A=
 include/hw/arm/aspeed_ast1700.h |  2 ++=0A=
 hw/arm/aspeed_ast1700.c         | 18 ++++++++++++++++++=0A=
 2 files changed, 20 insertions(+)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_ast170=
0.h=0A=
index addea3ab1f..b15b13aedd 100644=0A=
--- a/include/hw/arm/aspeed_ast1700.h=0A=
+++ b/include/hw/arm/aspeed_ast1700.h=0A=
@@ -10,6 +10,7 @@=0A=
 =0A=
 #include "hw/core/sysbus.h"=0A=
 #include "hw/misc/aspeed_ltpi.h"=0A=
+#include "hw/char/serial-mm.h"=0A=
 =0A=
 #define TYPE_ASPEED_AST1700 "aspeed.ast1700"=0A=
 =0A=
@@ -21,6 +22,7 @@ struct AspeedAST1700SoCState {=0A=
     MemoryRegion iomem;=0A=
 =0A=
     AspeedLTPIState ltpi;=0A=
+    SerialMM uart;=0A=
 };=0A=
 =0A=
 #endif /* ASPEED_AST1700_H */=0A=
diff --git a/hw/arm/aspeed_ast1700.c b/hw/arm/aspeed_ast1700.c=0A=
index e4c8565d3f..f610f25932 100644=0A=
--- a/hw/arm/aspeed_ast1700.c=0A=
+++ b/hw/arm/aspeed_ast1700.c=0A=
@@ -9,15 +9,18 @@=0A=
 #include "qemu/osdep.h"=0A=
 #include "hw/core/boards.h"=0A=
 #include "qom/object.h"=0A=
+#include "hw/core/qdev-properties.h"=0A=
 #include "hw/arm/aspeed_ast1700.h"=0A=
 =0A=
 #define AST2700_SOC_LTPI_SIZE        0x01000000=0A=
 =0A=
 enum {=0A=
+    ASPEED_AST1700_DEV_UART12,=0A=
     ASPEED_AST1700_DEV_LTPI_CTRL,=0A=
 };=0A=
 =0A=
 static const hwaddr aspeed_ast1700_io_memmap[] =3D {=0A=
+    [ASPEED_AST1700_DEV_UART12]    =3D  0x00C33B00,=0A=
     [ASPEED_AST1700_DEV_LTPI_CTRL] =3D  0x00C34000,=0A=
 };=0A=
 =0A=
@@ -31,6 +34,17 @@ static void aspeed_ast1700_realize(DeviceState *dev, Err=
or **errp)=0A=
                        AST2700_SOC_LTPI_SIZE);=0A=
     sysbus_init_mmio(sbd, &s->iomem);=0A=
 =0A=
+    /* UART */=0A=
+    qdev_prop_set_uint8(DEVICE(&s->uart), "regshift", 2);=0A=
+    qdev_prop_set_uint32(DEVICE(&s->uart), "baudbase", 38400);=0A=
+    qdev_prop_set_uint8(DEVICE(&s->uart), "endianness", DEVICE_LITTLE_ENDI=
AN);=0A=
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart), errp)) {=0A=
+        return;=0A=
+    }=0A=
+    memory_region_add_subregion(&s->iomem,=0A=
+                        aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_UART12=
],=0A=
+                        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->uart), 0=
));=0A=
+=0A=
     /* LTPI controller */=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->ltpi), errp)) {=0A=
         return;=0A=
@@ -44,6 +58,10 @@ static void aspeed_ast1700_instance_init(Object *obj)=0A=
 {=0A=
     AspeedAST1700SoCState *s =3D ASPEED_AST1700(obj);=0A=
 =0A=
+    /* UART */=0A=
+    object_initialize_child(obj, "uart", &s->uart,=0A=
+                            TYPE_SERIAL_MM);=0A=
+=0A=
     /* LTPI controller */=0A=
     object_initialize_child(obj, "ltpi-ctrl",=0A=
                             &s->ltpi, TYPE_ASPEED_LTPI);=0A=
-- =0A=
2.43.0=0A=

