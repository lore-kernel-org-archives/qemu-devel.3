Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D980CC6B2F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 06:37:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHF5X-0004ia-R4; Thu, 15 Oct 2026 02:37:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHF52-0004cs-Gl; Thu, 15 Oct 2026 02:36:47 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHF4x-0006Xp-WF; Thu, 15 Oct 2026 02:36:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r0X/J1plEQbEGPE1NhjLBJwwXshNCT1cGpDtR0j6bTD5sG6MfG7/zAqdI3woEQz7WqnCGc2oXcWyWjR/rA7sjUlaN/UYGGq7klUIlOIHjT6Rx4OD47NmtDH3wYYAvxn7aioKplw7BfPJU/mt8h/e4YOZLKglmVXU+hVN+LbnVe4LlPoHhcz7whcq6rmTbKv+EGCcuY3TK85waI77a4QrUXuXex/qi1keXMl0d87Ahwl9spHEKPrzuk1KfW3OW6q0Uj8bgvymlbsu0eSQhXConO1Kj5ljxCkS3ipIyXmgjikyZ8rpR77TskWTYfLmvN3Zw3C480hv5L/c8HYYmVsiow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIUpDFjlhPKpqL+asGitOLWWL5sqA4iytR21Akpfkkw=;
 b=ho/EXXsE8xCLYBdhDCAq9n0pEOkzXM6vFNrCED+uNAiSAHbgcCAQqkEmmA4Zvh52GHYlBVO274CM24Zanwu5Sf1mn5Qbl61bj6neRCQND+ahF+HwbLWTF4NT8r4OQ19n7k7llIhJeNJXfon0Pm8cVtjLI4EOtPX5bG3uYB9GB4TueD5FaQc7tupOD0Ww4YM0/O4Hqma581gKNEmRqsaa58wlc5oC0Ubdpr0x3+vNYlQJcKasToEILA0ZTAHCC5dki+zm8gABCgWnUQcbGveEWtyPTXRcz+Pqad209HRX8/SvbJ/PcbUA903+EgG6C5iSbuL/Eh53FapelYrnSleHQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIUpDFjlhPKpqL+asGitOLWWL5sqA4iytR21Akpfkkw=;
 b=OX2UerYFAgXaKYWBCQuahxy9JTXjcfgM7X/inYzEOuZzczZV8guDgnfRQjtaX0gfwGTvOEES/Vc2EUzsutzee4Axm5To7FrlYO5P5Xutd5pJnAWGyw4pED+HKXMslRHE+pVQ/+NGhFtPx6D9A02CGhrZug0Wq9Ao0iqwU+s+CDK0vm2R5yI+3yB5olEr1y8+Tz5Mzbg6focz+z9odtaXEIsy5lDTLxSHcBxyw1oZZcbHkXxZzjcmXZZkaBNADuCkNrRnCSnC2IG4JkQDJJZ0j7APehMD7vuKoESLEb7TllfcWHPvaMljZ10kbcWeBX4TIYm5NdtWWDqW+VhIEk4IMQ==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by KUXPR06MB9060.apcprd06.prod.outlook.com (2603:1096:d10:67::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 06:36:28 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 06:36:26 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 0/9] hw/arm/aspeed: Add AST1080 SoC and EVB support
Thread-Topic: [PATCH v1 0/9] hw/arm/aspeed: Add AST1080 SoC and EVB support
Thread-Index: AQHdXG+A/4MnDcrXGEi2UrBp7p4o2Q==
Date: Thu, 15 Oct 2026 06:36:26 +0000
Message-ID: <20261015063625.186708-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|KUXPR06MB9060:EE_
x-ms-office365-filtering-correlation-id: 2228c5d6-4faa-4eae-6091-08df2a86a38f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|6133799003|18002099003|10067099003|921020|38070700021|261009223027099003|56012099006;
x-microsoft-antispam-message-info: JMk8orjlyPnkyAEwH1SHtq5AmRY0/oAwRukp3GkDXsYZpJZW3Os3g2tWz/f5cTuV5Lof6aJ03EWi+/5EhjTQRIdZC8G4T1rrZOCOBNk1OBnRBa29NPVx01cszQK/RXzMBg8wJFo+JBR6pasCd/j0h9AeS6az5x132lQYs81CuVaV1CpZRrzLG8JHjCLks5O1Xz/nsQb09MuMMn3hqbI5F3EWuqbthSgSUFdw2DF6JuxoabhNDtBYfXQqKZkXe4t+F8TH0rhH7C8bSiGtTj40OjhuMsimBnlV2mA5RqfQjXX7ZjgXXNheUJRUq+3ZNS/ic0eNhTJV+yfmfHLIe2sH/CePvrffSyGvTus0zkFQ2qmTF0cXWxckHljd4RXPn4tDGfjenK6RmP6Fzf3GIvEa8a7FtZ9qyRzvZId5ju35JMWiWqvFkKqMgQ+b/qCrlMlu8DpIiJIjEYAbcxP0bVUvs1xW9rThO7lbLuHFOa9DG9RCHNVmRhtw4PyZUsBb206R9HrPwI2s6bXQ4kjcj/gj6br3L6EXBqdoo8wB9l+9+mw8ekl1IFEDa56VXzminBzD6A6V6TsCCn/Im49XSWq26zEzVBi/wuql9BTB+0CIqf5MrDwhaTYgLxn5OpCaeBRBZrCiSEInwCDxG/Df7bDZwcJfK2dWlljiu+dS4ZYpr+ay9VKaZx0bG5qhSCngmbs4
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(6133799003)(18002099003)(10067099003)(921020)(38070700021)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cKTi8ONPFAB58HGHnxmFh16wWCsrCIV0kNT0hY1EzTdjxfjq5ezk3Z4cmR?=
 =?iso-8859-1?Q?2/oEr8ofnEQ4hA4kgomHxVRwOJvPtaDQMsQFEKchSueqePSa90az7g/cgp?=
 =?iso-8859-1?Q?YqdI8Z4oTrMMQvX9TFhdj3Dp4GYxCjnz1uGRQcsOgFlEmmheIcvTih+N/i?=
 =?iso-8859-1?Q?FyVGlqvS2Rl/fnjLUXdho7z2+/O8pvsPwokgImCN0+qzm8IML+ZA5MegFe?=
 =?iso-8859-1?Q?Ct35t0xCaFnmaqmYaItUgpCiwTweTuH+/ic3jnRRkHM6GiBiqs4omp0tIK?=
 =?iso-8859-1?Q?fEOlmhMDKzA7T1+jFraKdSmfZ5CtXWsP11JhA+uxqmGWn3hF9WtKYrwGnd?=
 =?iso-8859-1?Q?WBnBR98/iwMkTqQrNTa0BFUnEaig80BzPzWFNWrLcwWzC+RY6RkirfYXio?=
 =?iso-8859-1?Q?6zjdTSXnsCqn1+nQS90R7+77B4H2DYqiWBGa7Yq3VHrnAzbB1QVQfcp3uf?=
 =?iso-8859-1?Q?Wq0QSELSBui6PXmPZROljTIcFugPFqYhaXMgZQcb9xOhes3bQmNz3NM34f?=
 =?iso-8859-1?Q?He4rya61MV2WpaOmqK5bAGpUuRsbDBdk1frDT6YkpXD4BKfQxswiqSI/hB?=
 =?iso-8859-1?Q?vC7Xt8fZZsGIoUIhqt947GXAIgWvKuAEGBbiChk350Ms9/1E0x3OJ49Fii?=
 =?iso-8859-1?Q?jm8VaU7cH2zKieGduy5B5JBQEWMCUKojE9ZX5WT/DPZNMpiEsnD6lKbBAH?=
 =?iso-8859-1?Q?puUhuiaoQqg2++9M8Ze81qwvSr3Sn6TVeu/zVXzURd4NeBYmdIF4bIbOTo?=
 =?iso-8859-1?Q?TFbqmBpWX3f1SZ/lUP2qXgXyU8Ms2Atv9pqH7CMkbgQ6LLJF4CLYzEVwo5?=
 =?iso-8859-1?Q?pMmd/gVGhvCphpVHVmEEk6xZzTQjggJk3mmAhXtMRt5xLOa3k8De0b8wl5?=
 =?iso-8859-1?Q?2MIc3izFToGi+C6zpLxFlCH3UBlg/Y/bwkttfMCdy/lp81ueTgWQn5lYp4?=
 =?iso-8859-1?Q?LbBoCVV/uEw22mA2rw5Op3VtWJUIIyYpqKFo11tmwfdgvHJsCkNMuO1Scr?=
 =?iso-8859-1?Q?NgB7WeP0POu53DGbDG3yW29L2AAjjb2Ywj7lrGUXxfCFgEF+jdMWqMMZFK?=
 =?iso-8859-1?Q?A8AFLU5MKC4ZLXDu9snIkak/jXnbf3P4Pqml4En//2hCAOKOuhNQiWLvSQ?=
 =?iso-8859-1?Q?ZqvKbEEYrKoT8WrU1QJB7+0tYFxGKxd3dhJ1r4ZiRk/MZ7/7/ureWBvNp7?=
 =?iso-8859-1?Q?r41iWKBH1/SSfrLxKTaamZTPn3gbZae/Thu9l0c8eBda/CdT0a1+PKf9dC?=
 =?iso-8859-1?Q?atg6v0a3yKMot1ogK/byG/h+IV5H0j3/leuR+/txFWh819oxcbospwyLbr?=
 =?iso-8859-1?Q?uXoF6nN7N41Kol7bZSsW6k55G8ShZtxLVyweeBRwPnia25oO3UzS83OxpU?=
 =?iso-8859-1?Q?ozgQ7XCKm6W5frWWcsL0K+Qq/Qr/Xb1heqlQ7zVFJA/ma/Weh0Wv0I4CP0?=
 =?iso-8859-1?Q?3zHb/jaCacMMcUqEr9T5Q0pF8Jrcaj2zulcCYYGf2dTpjckpRusOwFe7nv?=
 =?iso-8859-1?Q?bJZlKMv19Ysd3PW39VcP1TCvUSj3w2KJrJr7BfOoRwVm4H6z2p2SQtmXrE?=
 =?iso-8859-1?Q?grNhEa636VEQF1kaL545zKduGGOHzg+9VWKr41//yESBjqA5yI/icr4FEw?=
 =?iso-8859-1?Q?L710S/OY9tfZ/eSoj2QUD8f75hpKAnHR9Ku1TR5cnchz1SYxmyrTeCJebx?=
 =?iso-8859-1?Q?VRhfY2u6ITskWTiUDmCcoo2iTEcRodJJXRqUZTfwooiN2AffcovFjqVNZD?=
 =?iso-8859-1?Q?yiN0VvqmZBizJGdR72WGMWatOXVHlop6XjIflX/sdMVPDvdwKV23VngbPB?=
 =?iso-8859-1?Q?NlB8V2ERcA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 2/LOUUoT/5Samzpq1cAmr3lY4tkhhd+OQfd1DqgY6S+SrC0EqvKPv2kYkRGWa2+6xTCyVbEXsxrNiFicN5yCKgiP3m/bLoBGkVBjTtUMIYdU3+THu8kf7/F9gRL1eNWy+cM6ZCt4UjvcXZPG2UOaO0/ADw0U08gbi3DotJpIGMyRtAnLMc5FZvlKvIT7n42ofKatNNTvbGxTmZ/RhgV/6uKuIVL2NmU2iUWTy4iKmaqaCiCmMRcnGfASGlOxcm+YJrYnOA5rAUr0qpyNgqzbvzryXOJmZnhCWu+y1uOi0GfJkqcwwOgb9+I6Zzz6e05whPa6pLllb1sVcqZeHabXQQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2228c5d6-4faa-4eae-6091-08df2a86a38f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 06:36:26.2921 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rAquFYpnm0oc09pOaSJTeAAp24MkTsvNsovB0Ghtr7t4pxrhzXF3/EemeH/NOqLRDcL2seC5br+5VtyAVruLeHDMsgqretNgyd1Evb+xDhE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR06MB9060
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

This series adds support for the AST1080 Platform Root of Trust SoC=0A=
and its evaluation board.=0A=
=0A=
This series depends on:=0A=
=0A=
[v1,00/14] hw/arm/aspeed: Add AST1040 FMC/SPI controllers and unimplemented=
 devices=0A=
https://patchwork.kernel.org/project/qemu-devel/cover/20261015055642.106204=
-1-jamin_lin@aspeedtech.com/=0A=
=0A=
and is based on the aspeed-next branch:=0A=
https://github.com/legoater/qemu/commits/aspeed-next=0A=
=0A=
The AST1080 shares most of its design with the AST1040, so the AST1040=0A=
init and realize code is first split into common functions. The=0A=
AST1080 SoC is then added with its own unimplemented devices (QSPI=0A=
filters and I2C filter).=0A=
=0A=
v1=0A=
 1. Add common init function for AST1040/AST1080 SoCs=0A=
 2. Add common realize function for AST1040/AST1080 SoCs=0A=
 3. Add AST1080 SOC and EVB machine=0A=
 4. Add AST1080 functional test.=0A=
 =0A=
Jamin Lin (9):=0A=
  hw/arm/aspeed_ast1040: Add common init function for AST1040/AST1080=0A=
    SoCs=0A=
  hw/arm/aspeed_ast1040: Add common realize function for AST1040/AST1080=0A=
    SoCs=0A=
  hw/misc/aspeed_scu: Add AST1080 A0 silicon revision definition=0A=
  hw/arm/aspeed_ast1040: Add AST1080 SoC support=0A=
  hw/arm/aspeed_ast1040: Add AST1080 QSPI filters as unimplemented=0A=
    device=0A=
  hw/arm/aspeed_ast1040: Add AST1080 I2C filter as an unimplemented=0A=
    device=0A=
  hw/arm/aspeed_ast1040_evb: Add AST1080 EVB machine support=0A=
  tests/functional/arm/aspeed: Add AST1080 test with ASPEED MCU FW Hub=0A=
    v01.00=0A=
  docs/system/arm/aspeed: Add AST1080 Platform Root of Trust evaluation=0A=
    board=0A=
=0A=
 docs/system/arm/aspeed.rst                  |   8 +-=0A=
 include/hw/misc/aspeed_scu.h                |   1 +=0A=
 hw/arm/aspeed_ast1040.c                     | 154 +++++++++++++++-----=0A=
 hw/arm/aspeed_ast1040_evb.c                 |  23 +++=0A=
 hw/misc/aspeed_scu.c                        |   1 +=0A=
 tests/functional/arm/meson.build            |   1 +=0A=
 tests/functional/arm/test_aspeed_ast1080.py |  37 +++++=0A=
 7 files changed, 186 insertions(+), 39 deletions(-)=0A=
 create mode 100644 tests/functional/arm/test_aspeed_ast1080.py=0A=
=0A=
-- =0A=
2.53.0=0A=

