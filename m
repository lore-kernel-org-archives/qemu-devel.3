Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68656C5DF80
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 09:23:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwG2B-0001iC-Ft; Tue, 18 Aug 2026 05:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wwG29-0001hJ-Rg; Tue, 18 Aug 2026 05:23:01 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wwG27-0001Yk-RW; Tue, 18 Aug 2026 05:23:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UkX3ICBjT73Jo2fYpiWM/xVCozCeYtvShRCYHVf6b2TkQgL5I2jyElBmHwML3TK4X3QTbwGIyHHHe6MiFUd0/ut1fNziDwq3hCeQytIclmPi9zN23JDDfEEV6tIVz84UuSX2q11+1ALMUsGQbMBUiY8bY9e+NWNvWWTbtsCFjocAkIoUqNVnKr1E9pNn40tsMbr4bOkTMGtuz2OyHG1VJt4LV0xdo0ZKyQqeLS4Dtntxm06ZHlaLclaLJbzh3IaQ8ZC5CfCSmlGjnphnb9M+j5F+vNW7+FYcdtwlJGLUDh8kHpGS7fqD//kazncUuBlsRBsv5A5SWfUXc+e7Jhwmlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rDCQwIyRkidaaPVsKqxSmHldv1WgBin2R3zY/sxx28=;
 b=EjM+g8yQvQuzKlr1azlo8Rg7xvtbtHYYgmuslQxQcCd7HPMH0wqO0jN7PulRxPfLaonXiNSKibNVb+uB6w8iXraOb7jnQqyhdFsVlCnJIhMDVUYSqPUiJeGKHRS/FnVKdDCtCPO7lgzck4QpFqYoBVUYlRm+6z72OWAWy+N+9douzpxaajaLMVU2LQuNEqIKJhVUMKZAKD3DP7P/PBq55wPElK6mwctu8Ma6aLYl6VxYfk1DqcNWZ8OmEwT/4h9CCEqLfj+fV4Ax6299u9ARqP/glDU/X1M6LEB1KBqgdAN2FnqjTNadWmC3dUD2zwWKRiErXfiz8rzksIdLUnurFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rDCQwIyRkidaaPVsKqxSmHldv1WgBin2R3zY/sxx28=;
 b=ZPY8vY4XgfCQfBj7xho4d1//nBVi8FzLif+w3e6W47Vzk5aCNmXfMytNRlEmcjQDDiu2KB2s4X1A0dc4JL1HP+QUyAjq96OuUaF4WDMGc8kWuMLk1Ennot6QuRS7oVp+W+yqJWB1OUjVsc7yM846+6h8K/KT0YBT00HARRd2RUqMoMpvkWqt96yT7M6aZFm7EbUgFHDVYQgk1JE/iExtuPb4gXlDf/1FP1EGxgoFkv2Rwj2bVoxtQgkYkh4lZVI3zlL5xDQq8y0IXEOQDZ5n+JoCvOJTsxEjGKWZbdJsQtswnXWMuUj0txRfW/jU602h2xBXOYeP3SSmKU+aEXY4dw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by PUZPR06MB5982.apcprd06.prod.outlook.com (2603:1096:301:112::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 09:22:52 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 09:22:52 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 0/8] Add ECDSA akcipher support and the ASPEED SBC ECDSA
 engine for AST10x0
Thread-Topic: [PATCH v1 0/8] Add ECDSA akcipher support and the ASPEED SBC
 ECDSA engine for AST10x0
Thread-Index: AQHdLvMktRDL2ADim0azJ9qf2ocwow==
Date: Tue, 18 Aug 2026 09:22:51 +0000
Message-ID: <20260818092249.602137-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|PUZPR06MB5982:EE_
x-ms-office365-filtering-correlation-id: c92db936-952f-4b50-6a8e-08defd0a473f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|18002099003|56012099006|38070700021|10067099003|921020;
x-microsoft-antispam-message-info: nR+bj/VBUxGrfcXX7aUm9Pg3Enp8+9HJGLY0JKWzc5oJkfke2HN5X5MZ+wK36k5hlw54je6K2CYNh0/6v0xvha+SYT7E/INFPs6F/KLITyxxN8MPkJWZeLLKOBIcUL/Dd/Sw5RvIpktcFNxhODnmFtqF81ifPwu4PwlMlKHN576b5jBsm8QzshooYOM8glKjie3M8feNk+WisQgP0eX9o7OtPr7z11UyafLwGIrVPVSRTs99Atot9BieMuIn3C5V6ro9s8OFtoQqtzDX302AOUpjFX26lXERZ6l+/8YRmJS90It4fo2Aswust94/p66GOeyfJv2mEubslFzkJ897R3ohQetCMlVO2Bp4CSPeOR8nhG+VyYjBF5Ws2IQmfwm7xTTB21UK6wDDmWt/E7z44GODiONc5zr9mrIe7AUbw988gRvDKDYlrftC/22P1EUKczEgpyOixnm5bZjRJKThD6oUWsbzv6wEKJMwsEH+LQTd0LEJtbmDcsKFCEqzGANCxgMcwy7c/cQ5WcDHUXlPJkZxW9tdGWxiKhUlx3bFebsCELigv5d3rXShdrRciM66pcCQ42Lr4ZzF79vJ63e4XkRgfQnD3u/ywKTXe6e1e1VtQNcixOr58w3FOW12zfFZWlf0Y28IdFRpN/TvENIeoaPN8XvP2KTPwTFEeDWu+tDchNOOfN5kV9VrxsDExWX84pMNwaY0No1eDKuZd34uMq1oupRyiGE+AO2AuQHBu3o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(18002099003)(56012099006)(38070700021)(10067099003)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/J1VCpHIH3FAUGpEhlkwh41woT7whaI1RbZ27zpsokHSD/DyWiiLmCO3ZI?=
 =?iso-8859-1?Q?6ZZS2B9nehJSJ4O5VD/0eKuMKA9zjVtNOES6TfS7aNiM3jbZkThrXAds53?=
 =?iso-8859-1?Q?CMv5eoF+QSud3M0SXIiAfmbs+5tC+gDyJmYn+6vhv5jmuULqVd3vCWgPSI?=
 =?iso-8859-1?Q?IMMu7y1iT9pje2Q0xIaPPHeIuMXa/Pmht9q8PKMwWUbKVaYAJPFdRSyY29?=
 =?iso-8859-1?Q?vcITXygiGXZYVNooQ6XGaxqg42N8YXLUhwzP68HfbcrctRfjLkyhjSNiZ/?=
 =?iso-8859-1?Q?aSWdKNL/0Zo+mM1Wpjzt4pyRsN2C5vPYlHnXEJFU2u3rRM+Ndm8/5cP4qX?=
 =?iso-8859-1?Q?axa1VDRIrueT0e+l5N9bW0RkUNwsD+EzUvXy8s8u3Wfa6LID6D2id68vFo?=
 =?iso-8859-1?Q?467WUk2XKUH5LE5KTPuGWZQ89RTpYcA9QBFV8Tp8yUzmEi0/HyIwiy3pce?=
 =?iso-8859-1?Q?f2eFgJ33P0t7ChqLIznYBOVbjyuJW6wTRkk73djPav5MdYfWvGfAi3+eOv?=
 =?iso-8859-1?Q?mtC8cpw6T7Y0eET18H6WubRMXKQH/WOq40blMrbukyn4QhZ3zLOqosuUS6?=
 =?iso-8859-1?Q?h1G9mqynMxgIiL8ThaeUgVRaJiu2LepNTJKxuD4OMWnx8jdM+oGZwMGaSu?=
 =?iso-8859-1?Q?UWu2bwcqer/P0VH1FP74ex2dzL8FGYJUdhLLWUcVrtUII+sJW6FB6Sr49W?=
 =?iso-8859-1?Q?wcDHdrrH75fHETMguIHe0EfCjP/nv9RGDVk/9q6LCQo1dRTKyyZwQ6JN2Z?=
 =?iso-8859-1?Q?FZEJ221Je0ceuocWTmnoHQ/5izfFNhUD4hrIvtnfcQKjQoBQmm0NwJfhJ5?=
 =?iso-8859-1?Q?h1RSoHrclhSdiCzUNztYzYWeX+bqE7jLHwPfdKhz86BBbU6ZyXUf0wA9j4?=
 =?iso-8859-1?Q?rYpCEGu53KWJHG0x7HrIg37XnoxbqIzTd6GyeyDpY10WP4yWUzeQUUCoxo?=
 =?iso-8859-1?Q?lMmFjMqccJuwPdkk/30QrMkgBuxYvi7aOUW3RrYKf++dNLQ1/t3hqRWmO3?=
 =?iso-8859-1?Q?OD6uw7CW8gp+ZG2tMkHe5vJgEAHZip0kRXJq4JUBr4YEKJXScFB/Zf5NT7?=
 =?iso-8859-1?Q?2bd9eUU+1F2vTy/GihVJaT8itUjuCk2fnJNAIv6HYu15G0/W2rKEiETnjQ?=
 =?iso-8859-1?Q?g60VXNnjUXZTM/SYUFDY1IswMYrqeju937bX1Bno5dSr5eQheFXDrU69Fj?=
 =?iso-8859-1?Q?fIKtyzC+TcsDWZSKId107bU9C7Kxu8NymWFiF0uTMee355UB1y31UI41Wg?=
 =?iso-8859-1?Q?6bXO7nBUlcm/rVXt++UPn78cZiyxcvZycwWiG0WdtoFEhdKG4TTTAK2b/l?=
 =?iso-8859-1?Q?hkzDC6BgfwPHnT+ERu/zQO3jTuh5CTlbNrno8ESfL4q5y0trokQnohjcV/?=
 =?iso-8859-1?Q?zF6eLdKmDHmld6t1lb/0jAu3WKboKXUOVQpKUmXwcDFSovT4hjuYQVBP+g?=
 =?iso-8859-1?Q?bifrALgBjIzG9ABzcjQeaz48DbxwyZ0xLON15OXArrHojn0L6N0wlnTISl?=
 =?iso-8859-1?Q?JNuY0+9g6NxfMBRUF2v90pwVT5DjqRQtiphaPVpG6bkTePzzKTEqjHGKTM?=
 =?iso-8859-1?Q?ej4ijCT58sm2GMLCCCkwlq816CLu6fGwjx3vOjfXJaYxCyEWOtzhDWycdg?=
 =?iso-8859-1?Q?FLVvBjlMklHPm/Fo3jpXjva+KJ6o1TN6cGFTA9ZbaznXJEUvn5SyVaqJiu?=
 =?iso-8859-1?Q?KmcegbvX7bNsLB/+0qbo7R4WK1OGK5onT6NJmBCX3a7YSFlPqDpnhbpLwe?=
 =?iso-8859-1?Q?BHx29vqIono/bwb8t7pn+ZAXi5bVIBiVRTRsb/F531beZAuS+S4ztzYcYp?=
 =?iso-8859-1?Q?kwBwGDNbRA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: q2zPBmlAywIO+nqzgoboz6LpiXI1qrlt3wgMA4kL6AMAAHWmwzCl2ba9vgBeI6x0GcN/NLwgxGxZynhnMPUDba5ktqbo/uskQYUpkRK90TZ2x7Y9ydwMTMW+sRv2qDqbk4uLQ4kdUPXc7gZHWtiQGjoTRShxpJkaLq8Sind0rd9FlVbjQGGwJa+6NIcT1bmYGOPYSEuqh3tTGyh1m6MV1uCLf9Fo7xytPuyUegrxaLafaQZgrZtUSd1yrkknFpXqzYc0mPudoC2+tPS4c92ernl3FIJ4Xq1EsQyFXQlwRGd6Xmno9tl+Qb0EdVDk9AZxlwRRGksoS7EmZ2eze1imlw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c92db936-952f-4b50-6a8e-08defd0a473f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2026 09:22:51.9300 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I9aaNaRw4hRdC/NBDI0AEE4JJeM79imToADS8ev3DVph7xmqUPFU5x/wjLnYleHQK/lGtZFj1caj+QCN5rK+1jnVGEV/tey7mnCcO9BDoAI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5982
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

This series adds ECDSA to the QEMU crypto akcipher framework and models the=
=0A=
ASPEED AST10x0 secure boot controller (SBC) ECDSA engine on top of it.=0A=
=0A=
The crypto side adds ECDSA sign/verify for prime256v1 (NIST P-256) and=0A=
secp384r1 (NIST P-384) in both the gcrypt and nettle backends, using the ra=
w=0A=
big-endian form (public key Qx || Qy, private key scalar d, signature r || =
s)=0A=
with a pre-computed digest as input.=0A=
=0A=
Both the AST2600 and the AST1030/AST1060 have a Secure Boot Controller (SBC=
)=0A=
that supports RSA and ECDSA verification, but only the AST1030/AST1060 have=
 an=0A=
ECDSA verify engine, so this series models ECDSA only. RSA verification is =
used=0A=
solely to verify the AST2600 SPL in ROM CODE, which ASPEED does not release=
,=0A=
so it is very unlikely to be used by end users.=0A=
=0A=
v1:=0A=
 1. Add ECDSA akcipher support with gcrypt backend=0A=
 2. Add ECDSA akcipher support with nettle backend=0A=
 3. Add ECDSA sign/verify unit tests=0A=
 4. Support the ECDSA verify command for AST10x0=0A=
 5. Add ASPEED SBC ECDSA engine qtest=0A=
=0A=
Jamin Lin (8):=0A=
  qapi/crypto: Add ECDSA algorithm and curve id=0A=
  crypto/akcipher: Support ECDSA sign/verify with gcrypt=0A=
  crypto/akcipher: Support ECDSA sign/verify with nettle=0A=
  tests/crypto: Add ECDSA sign/verify tests=0A=
  hw/misc/aspeed_sbc: Support the ECDSA verify command=0A=
  hw/misc/aspeed_sbc: Increase register space to 0x1000=0A=
  hw/arm/aspeed_ast10x0: Wire SEC SRAM to the SBC model=0A=
  tests/qtest: Add ASPEED SBC ECDSA engine test=0A=
=0A=
 crypto/akcipher-gcrypt.c.inc      | 328 +++++++++++++++++++++++++++++-=0A=
 crypto/akcipher-nettle.c.inc      | 267 ++++++++++++++++++++++++=0A=
 hw/arm/aspeed_ast10x0.c           |   4 +=0A=
 hw/misc/aspeed_sbc.c              | 158 +++++++++++++-=0A=
 hw/misc/trace-events              |   2 +=0A=
 include/hw/misc/aspeed_sbc.h      |   7 +-=0A=
 qapi/crypto.json                  |  33 ++-=0A=
 tests/qtest/aspeed-sbc-test.c     | 190 +++++++++++++++++=0A=
 tests/qtest/meson.build           |   2 +=0A=
 tests/unit/test-crypto-akcipher.c | 236 +++++++++++++++++++++=0A=
 10 files changed, 1221 insertions(+), 6 deletions(-)=0A=
 create mode 100644 tests/qtest/aspeed-sbc-test.c=0A=
=0A=
-- =0A=
2.53.0=0A=

