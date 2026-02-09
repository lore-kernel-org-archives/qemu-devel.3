Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C1AE78D6F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 09:18:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpNOJ-0004nf-A2; Mon, 09 Feb 2026 04:17:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpNOF-0004lN-F4; Mon, 09 Feb 2026 04:17:07 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpNOD-0007Kt-K4; Mon, 09 Feb 2026 04:17:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N+ERgzFiKKN3b7f/Lhc9+UET5A0a8lutbemTBbKUh8EqvANXnpTsVVPvwGZdQMcgAX8WnjOFjjbYvUiyJqdX9GjfpxHPZOxO6PYm8xIMfjfxka22XSaA/NjruBd2UN0hORsKFVC+7QF/Bc4laa5cjtKOp8aZcu8gJCM5oBdyVHc26zSdxNlVjKpnHd6Si2Oc+Hqyu0zsXQdH2VkugENFBHyRZslXc6HANSrM/h5uST11hVcOKals0fOGtKMcvwqyyGsNSy49FUBQKwxpzra9QZYPNdj3pvd3lP8X7T2h72+v7Mub+uzTOWPItasxCLM2jtgORLKgHVjIs6O6XZ9ALg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KfkUqGiC5/00XohqK3z3+xpjLPqUyfalmZWGsyAbe3Q=;
 b=fsB1ImwbGAenJ03CyygY1lVisBMIURlNy1ixzFQyVjb72976c0fgIS37Wdl83vXlRh9dNNo2g1VbMM7Lbu5o5C+7KcFbCAgW9TBEVUgqlr3k3+zESMvokZmIUH86Oy2Y68hv13pAPKjuT1jInOG81sGL6f52QXHxCmIFUAAi+WNUNhGJHMHmwWwtSGU/8+tLSIpRuDreCif60jeeUXqAx9VYv7YnlzG2Y8F06wJiG4tUAaMxCPZK8dDIv+KWjlo/nEuXDSXVvFhIIIDkfqabYQdrKH2/588+GCcRl1fLvyQmvKPTBKlEli18HoCrF2EGoDC0kHfoWUOiNI5wUY9fAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KfkUqGiC5/00XohqK3z3+xpjLPqUyfalmZWGsyAbe3Q=;
 b=Yu3IRXeTIO8Ta540z7wW1pDROO1jwgdvP3tMfA8gF9GwWPfB01ua/SkBaCLp4RPyy1daz2eIRtyCnN1d404A9J6Jb88XywvHva0msTtn+T7jWa4/3ZNZMv02FiiYpr5ljDLFzg7n746gTCprK/OBy0YtFzmYUQx8d2v/sHWL5rJU9JN9ZVuZdtRwpWg4UGZSnd5D0Tg9NLJf1IaCdSmbhM5JlCOnogwPX4zRxwcshwPL0qEYomX9Pjt5f1bSaJZUY3/mxmKl8chSvnUVIw0nGhussiJXnLqnz7lteuT9JRkjgZET/1Kgme6oj9khel8Fdai84bLLjLfKf7ivMNjQcw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by JH0PR06MB7031.apcprd06.prod.outlook.com (2603:1096:990:6f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 09:16:53 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 09:16:53 +0000
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
 <nabihestefan@google.com>, Joe Komlodi <komlodi@google.com>, Patrick Venture
 <venture@google.com>, Stephen Longfield <slongfield@google.com>
Subject: [PATCH v4 15/20] hw/i3c/dw-i3c: Add controller resets
Thread-Topic: [PATCH v4 15/20] hw/i3c/dw-i3c: Add controller resets
Thread-Index: AQHcmaTUi32HC+nYmEi4K+K/ZX4UdA==
Date: Mon, 9 Feb 2026 09:16:52 +0000
Message-ID: <20260209091629.823457-16-jamin_lin@aspeedtech.com>
References: <20260209091629.823457-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260209091629.823457-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|JH0PR06MB7031:EE_
x-ms-office365-filtering-correlation-id: 098ecf4d-0ef3-473c-b00d-08de67bbf71e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?S/N+vM/Etl830nE5HWETqNaHmzOKGVfkyUSkNHxuf1Gmpe7wRLdOjSnri9?=
 =?iso-8859-1?Q?b/INUb0qyrAwUl0eqAX4znGuPwmxoaOdyKjk6zxM5H3faQn0Od2D7p24pQ?=
 =?iso-8859-1?Q?YaqaRXl7BFBH6EHYxFXZBRzddGAuHpIHLngDrFXuxRLIaTuToXAMwpem+4?=
 =?iso-8859-1?Q?4xz+Ozvmj+12VEPJa1aoM0Af8Q1DEF7QFfiGTrUtxUzN/gVjkIZWkcLhrR?=
 =?iso-8859-1?Q?N9QVgwstZi/71GwzFAI8H73+9u+Cy8nFo2YkrmVGvggMFqDZpd+bDb1J7A?=
 =?iso-8859-1?Q?/G2D3eY4d2jq+d168BQa/hqfigrRLcfuqjIkTryvJOpLCAdz9brwoLA0ek?=
 =?iso-8859-1?Q?dgHYpgUUozJSv+uIpkQGq8y2A0azhIapztfpCpFHFtA2awlfg6+3uxs91Q?=
 =?iso-8859-1?Q?68pjifbsHzevmtK9NjS8nqlUjUiCJrPtAz0Om+YHs+orMqbaIkBU+NJxbj?=
 =?iso-8859-1?Q?11FglsGuvRJzxTfTZCG+U/vx+R6jKe3wVXx0qYL1TRPUa/7pMAWaR0yOpq?=
 =?iso-8859-1?Q?apYcvfQkmw/hQyo6PsalcJdKTUOL4PCEXe2EcisMgPRsaecw9tHCWJL5/j?=
 =?iso-8859-1?Q?QD49QWCyOsrsshcTxJslI+sYrt6LrZHUIKCvBSeYz0RTZLMU16i+MN+LOW?=
 =?iso-8859-1?Q?3E/d3NPJCGlprDWaXjlBmtSU1mk+c7HGCTKoscNNQ8T3aGMK9iGFOp/m19?=
 =?iso-8859-1?Q?RZcaHR3hZsiTPVkLmFFCVieF3PZWKr1A842JryKRXikU16y0d/x1GR5A5G?=
 =?iso-8859-1?Q?JHIoLGLEJVFY2qzITPK0erIQ5g9DYgnlNskx7XXwC3nPreUUDqJreRe/+b?=
 =?iso-8859-1?Q?BlGF6IO5OGCOhQ1CeSjLwMuwReAqvB2PRK7NLvis68G5wjRdnxH++62K2G?=
 =?iso-8859-1?Q?zVXuqbb2YVV8KzSaUZyDM1Y6HTiSsc6Wt3x3TlPOHzMZpkYFpew/sgg67J?=
 =?iso-8859-1?Q?uIphPK+CbmBphhZgv41s7G3fulwUFIyY3AlIOOq5X5rjyLCruDZ1dqmThn?=
 =?iso-8859-1?Q?9JwNPqQgPoB0Y0+BHC6ufY0wyeEAWVFZGgi4O6ioGG3ZHeDMYh6ZB5nX+4?=
 =?iso-8859-1?Q?2DMgX5IEetIz4/B/CqWtMU9HuCiesbPaSncRdVa5r1cKDgr5PPlxz7FzxG?=
 =?iso-8859-1?Q?X931OTOTKXWgz40yRd29UAP45YTmnM0qbOwRgSYczZVIciIZxcSKRyW0QH?=
 =?iso-8859-1?Q?Aj8CeCjh4Kk5y2IOTjeAgSYDipDuu8S6EPpkjUflddceQnayPmeEYceeIF?=
 =?iso-8859-1?Q?9im9SI6zHCfqAu1VXTslljfJvk+ENwBm2RsICaOyu+G9o32Qy3oqsoyuWj?=
 =?iso-8859-1?Q?P6Pg7KlIzsAUES2PQZ7r7Ni8VnQo0dzclcBjE15KAgFzOJiQHxwXkFwsfC?=
 =?iso-8859-1?Q?Q8pCqqG2yw1XWV9KlAR29w6dk68gh/yLn1llGzihTT0290KoX2o8jx5JJ+?=
 =?iso-8859-1?Q?tYV6v4Da9Lc0tRwM4xdfd/2oFpwtYGn3V/1wqyZHdA44ZtAKZ4vM0f1JSa?=
 =?iso-8859-1?Q?TjkhAqcG9yU6ZnU44/j7r9ia6pqELj23c86L5TYRL5gr1MFnfYRNWUzFfb?=
 =?iso-8859-1?Q?6Ua6WFokbH8LmFHiAFq6xS4x2ncVVnOCnAuMsP6/kwXkHahEAnHjhzh4Gj?=
 =?iso-8859-1?Q?WkcAvZjrGWNHD9kNrVA0m9qykgpBtZfqGi0Q7YkX6Kk2V6P8pmoecOMsnX?=
 =?iso-8859-1?Q?zJ9cz2pDjX3GBXp5MayvfytEfKzyQ/MA5H33C6q1?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BcXFn6yDLbnA7BNgSkg+8wz5rng9LdOIT4PPsJ4yrhXgwZHJw7lAniVjV6?=
 =?iso-8859-1?Q?ySD/jvZxCdDVRpAOnTMnIOqIHzaWSKyHasBsw0i0iehuygZAaEP6MXP4Iu?=
 =?iso-8859-1?Q?tawq+kbF7WeJbZusTyz0r3QrB6/TEOTrEnyDqooCdHIUSac8bvHIwQPFHc?=
 =?iso-8859-1?Q?1NbXRg/q6hdcnzV1Jzm8YWthD0cOoyLyNyx6yaW5CciiKzOdS0ghTMHl9C?=
 =?iso-8859-1?Q?rRaYCKNr6kvA4tY6X75bfJ7+Bntu8ylqw3dmsAzsMITUOOatTjDYGE/ld7?=
 =?iso-8859-1?Q?F7xdQABmePq9kIuI+VnBmpmW87/Em1anatOXCwsVN/bdySMWGXaEVSr5aA?=
 =?iso-8859-1?Q?EuXe8ZRpP30PO2uEz7bkrVrWv69tp0SA9NpLVLQsgjOz/D14OMy97X2zfN?=
 =?iso-8859-1?Q?ZbOkFK5X111ILrKVz6E3CU33vnhRhkijvlmyoSgNOHYy6K22DB/AJQ/aCm?=
 =?iso-8859-1?Q?zIhbTYZFt9kXwQ0ddElwHLXE11tjlwsaOastLhpqW5iEd7Samm5b8CSnc8?=
 =?iso-8859-1?Q?5UNlH4AHzYOpxW/8ZF3D3tqU0e00+Hfc2lJFkwDjY9u+wkgW3pWlQheqYj?=
 =?iso-8859-1?Q?uX5VqnBC7ePHCRoWZCJ6H6ycyTFYkGRDNN2DHuDPIZiNQDIVrvMlUNCMuR?=
 =?iso-8859-1?Q?34EwzALYn036GYp5bElmpwLD9giixs6m+hXX/w+bqs5T8wsxbf/UP1uyil?=
 =?iso-8859-1?Q?JCSBIoJaAmue8reDZC192GaRuXA+dHfYoWrc/qf5k5eb2Yxyzr17uYg19k?=
 =?iso-8859-1?Q?k4tnIxzQTDT0fHPeVHue3ek2KgfLhzLSUAQrcyVjnCmY0T0vR7Sm3L+ftj?=
 =?iso-8859-1?Q?3k7yDWan2N+U71vAxIUX7icfxlIg6TLu2oKX5MpyghtgLqe6WFi4FElmC2?=
 =?iso-8859-1?Q?Jthrhu5zkPerel4acy0bh2Uts74MXNcBnUyR/r8e4w/xBnmuH5Zqc5rvJV?=
 =?iso-8859-1?Q?gg6IKUZpKNkZpuddb+vOZ2yoa4Cdw5QFDOLj6YmxbxYrcZSz0CSV1CT0a5?=
 =?iso-8859-1?Q?cndyE2T2vy9JgwyFM+5sP8KyF3iP1vv9KfGA5zdB+gFwRkI4+9cGmFXTHB?=
 =?iso-8859-1?Q?Uc3LYitOCpQkmvizqbiYxDPno9xdqEQ3ADgDS2bMDcdb7+Fse4sQEI4vsU?=
 =?iso-8859-1?Q?yOt65CcgyIhXrIdjVBkhDhJu0vHxFgXMwojvR0n8UHlajnJ2iJM4YG6Inq?=
 =?iso-8859-1?Q?nFNd4s//Pq1VpvGF2/vTZqhqG1qXovqn8ylSaKXDmuDlLQ8phCVKksiewd?=
 =?iso-8859-1?Q?/F2IUZSEJeuDZubLh0DXtTTDE0wF+29x8T4OfcZrkWS/OSAtJrsGQEC9l2?=
 =?iso-8859-1?Q?mY/20yoOUb9b4oG+cW3R7N03pjYKOT1nxn6GZqx5m0RI95tg/vh+NN0LX6?=
 =?iso-8859-1?Q?ZWCenY9b8BCCgOLk0EZAGCFlZqPwAnYgVL8o2Zq3TrGtdtSxo1IETYJuK3?=
 =?iso-8859-1?Q?cFGS98ADZVyLeX2VMHR7Y/zrq8LdFJnUxflJDAiF6GNkkm0e+3pdZi8Yeo?=
 =?iso-8859-1?Q?cSsimXeRxClxLr9C8puqM+wsUFaTUnwJ4KQu3T5LRWuQWDvpD+20JemDPc?=
 =?iso-8859-1?Q?zG6kfcxWnJNj7GDxtkZPHn/1c1OPJkhWF3Hscm8FkOZv4caxV4ZCeOyBKc?=
 =?iso-8859-1?Q?IHurpsCd9RON6ete+XJ7/RT68smY7DrgIkuCAVVY0me28bjwnPX9SEuYw9?=
 =?iso-8859-1?Q?N4opKafz1Okn7EiU22G1DbM3UekCBVanB8WLMRCFikN8IMOWH6HO/Lmis7?=
 =?iso-8859-1?Q?t0Y2gpeBMQdI/OWvl2tzE4VeCBTFJ9c2t0MRrGjpY2fy/8gda+YGgxkyGN?=
 =?iso-8859-1?Q?52QdXYSh6Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 098ecf4d-0ef3-473c-b00d-08de67bbf71e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 09:16:52.8497 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 50QHXJ8svlGATqj2FRvUSTob922mKropPsI1+70DlPL7EZEYP685qsYzy0AxGpBxcjPhkWn62bJvvzdu0Q+kDZtOp+wsC3x3RLDeeu81qZo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7031
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

Adds behavior to the device reset register.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Reviewed-by: Stephen Longfield <slongfield@google.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/i3c/dw-i3c.c     | 117 ++++++++++++++++++++++++++++++++++++++++++++=0A=
 hw/i3c/trace-events |   1 +=0A=
 2 files changed, 118 insertions(+)=0A=
=0A=
diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c=0A=
index 7a1f79e10d..87ad344e5d 100644=0A=
--- a/hw/i3c/dw-i3c.c=0A=
+++ b/hw/i3c/dw-i3c.c=0A=
@@ -860,6 +860,122 @@ static void dw_i3c_intr_force_w(DWI3C *s, uint32_t va=
l)=0A=
     dw_i3c_update_irq(s);=0A=
 }=0A=
 =0A=
+static void dw_i3c_cmd_queue_reset(DWI3C *s)=0A=
+{=0A=
+    fifo32_reset(&s->cmd_queue);=0A=
+=0A=
+    ARRAY_FIELD_DP32(s->regs, QUEUE_STATUS_LEVEL, CMD_QUEUE_EMPTY_LOC,=0A=
+                     fifo32_num_free(&s->cmd_queue));=0A=
+    uint8_t empty_threshold =3D ARRAY_FIELD_EX32(s->regs, QUEUE_THLD_CTRL,=
=0A=
+                                               CMD_BUF_EMPTY_THLD);=0A=
+    if (fifo32_num_free(&s->cmd_queue) >=3D empty_threshold) {=0A=
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, CMD_QUEUE_RDY, 1);=0A=
+        dw_i3c_update_irq(s);=0A=
+    };=0A=
+}=0A=
+=0A=
+static void dw_i3c_resp_queue_reset(DWI3C *s)=0A=
+{=0A=
+    fifo32_reset(&s->resp_queue);=0A=
+=0A=
+    ARRAY_FIELD_DP32(s->regs, QUEUE_STATUS_LEVEL, RESP_BUF_BLR,=0A=
+                     fifo32_num_used(&s->resp_queue));=0A=
+    /*=0A=
+     * This interrupt will always be cleared because the threshold is a mi=
nimum=0A=
+     * of 1 and the queue size is 0.=0A=
+     */=0A=
+    ARRAY_FIELD_DP32(s->regs, INTR_STATUS, RESP_RDY, 0);=0A=
+    dw_i3c_update_irq(s);=0A=
+}=0A=
+=0A=
+static void dw_i3c_ibi_queue_reset(DWI3C *s)=0A=
+{=0A=
+    fifo32_reset(&s->ibi_queue);=0A=
+=0A=
+    ARRAY_FIELD_DP32(s->regs, QUEUE_STATUS_LEVEL, IBI_BUF_BLR,=0A=
+                     fifo32_num_used(&s->resp_queue));=0A=
+    /*=0A=
+     * This interrupt will always be cleared because the threshold is a mi=
nimum=0A=
+     * of 1 and the queue size is 0.=0A=
+     */=0A=
+    ARRAY_FIELD_DP32(s->regs, INTR_STATUS, IBI_THLD, 0);=0A=
+    dw_i3c_update_irq(s);=0A=
+}=0A=
+=0A=
+static void dw_i3c_tx_queue_reset(DWI3C *s)=0A=
+{=0A=
+    fifo32_reset(&s->tx_queue);=0A=
+=0A=
+    ARRAY_FIELD_DP32(s->regs, DATA_BUFFER_STATUS_LEVEL, TX_BUF_EMPTY_LOC,=
=0A=
+                     fifo32_num_free(&s->tx_queue));=0A=
+    /* TX buf is empty, so this interrupt will always be set. */=0A=
+    ARRAY_FIELD_DP32(s->regs, INTR_STATUS, TX_THLD, 1);=0A=
+    dw_i3c_update_irq(s);=0A=
+}=0A=
+=0A=
+static void dw_i3c_rx_queue_reset(DWI3C *s)=0A=
+{=0A=
+    fifo32_reset(&s->rx_queue);=0A=
+=0A=
+    ARRAY_FIELD_DP32(s->regs, DATA_BUFFER_STATUS_LEVEL, RX_BUF_BLR,=0A=
+                     fifo32_num_used(&s->resp_queue));=0A=
+    /*=0A=
+     * This interrupt will always be cleared because the threshold is a mi=
nimum=0A=
+     * of 1 and the queue size is 0.=0A=
+     */=0A=
+    ARRAY_FIELD_DP32(s->regs, INTR_STATUS, RX_THLD, 0);=0A=
+    dw_i3c_update_irq(s);=0A=
+}=0A=
+=0A=
+static void dw_i3c_reset(DeviceState *dev)=0A=
+{=0A=
+    DWI3C *s =3D DW_I3C(dev);=0A=
+    trace_dw_i3c_reset(s->cfg.id);=0A=
+=0A=
+    memcpy(s->regs, dw_i3c_resets, sizeof(s->regs));=0A=
+    /*=0A=
+     * The user config for these may differ from our resets array, set the=
m=0A=
+     * manually.=0A=
+     */=0A=
+    ARRAY_FIELD_DP32(s->regs, DEVICE_ADDR_TABLE_POINTER, ADDR,=0A=
+                     s->cfg.dev_addr_table_pointer);=0A=
+    ARRAY_FIELD_DP32(s->regs, DEVICE_ADDR_TABLE_POINTER, DEPTH,=0A=
+                     s->cfg.dev_addr_table_depth);=0A=
+    ARRAY_FIELD_DP32(s->regs, DEV_CHAR_TABLE_POINTER,=0A=
+                     P_DEV_CHAR_TABLE_START_ADDR,=0A=
+                     s->cfg.dev_char_table_pointer);=0A=
+    ARRAY_FIELD_DP32(s->regs, DEV_CHAR_TABLE_POINTER, DEV_CHAR_TABLE_DEPTH=
,=0A=
+                     s->cfg.dev_char_table_depth);=0A=
+=0A=
+    dw_i3c_cmd_queue_reset(s);=0A=
+    dw_i3c_resp_queue_reset(s);=0A=
+    dw_i3c_ibi_queue_reset(s);=0A=
+    dw_i3c_tx_queue_reset(s);=0A=
+    dw_i3c_rx_queue_reset(s);=0A=
+}=0A=
+=0A=
+static void dw_i3c_reset_ctrl_w(DWI3C *s, uint32_t val)=0A=
+{=0A=
+    if (FIELD_EX32(val, RESET_CTRL, CORE_RESET)) {=0A=
+        dw_i3c_reset(DEVICE(s));=0A=
+    }=0A=
+    if (FIELD_EX32(val, RESET_CTRL, CMD_QUEUE_RESET)) {=0A=
+        dw_i3c_cmd_queue_reset(s);=0A=
+    }=0A=
+    if (FIELD_EX32(val, RESET_CTRL, RESP_QUEUE_RESET)) {=0A=
+        dw_i3c_resp_queue_reset(s);=0A=
+    }=0A=
+    if (FIELD_EX32(val, RESET_CTRL, TX_BUF_RESET)) {=0A=
+        dw_i3c_tx_queue_reset(s);=0A=
+    }=0A=
+    if (FIELD_EX32(val, RESET_CTRL, RX_BUF_RESET)) {=0A=
+        dw_i3c_rx_queue_reset(s);=0A=
+    }=0A=
+    if (FIELD_EX32(val, RESET_CTRL, IBI_QUEUE_RESET)) {=0A=
+        dw_i3c_ibi_queue_reset(s);=0A=
+    }=0A=
+}=0A=
+=0A=
 static uint32_t dw_i3c_pop_rx(DWI3C *s)=0A=
 {=0A=
     if (fifo32_is_empty(&s->rx_queue)) {=0A=
@@ -1617,6 +1733,7 @@ static void dw_i3c_write(void *opaque, hwaddr offset,=
 uint64_t value,=0A=
         dw_i3c_cmd_queue_port_w(s, val32);=0A=
         break;=0A=
     case R_RESET_CTRL:=0A=
+        dw_i3c_reset_ctrl_w(s, val32);=0A=
         break;=0A=
     case R_INTR_STATUS:=0A=
         dw_i3c_intr_status_w(s, val32);=0A=
diff --git a/hw/i3c/trace-events b/hw/i3c/trace-events=0A=
index a262fcce39..39f33d9a50 100644=0A=
--- a/hw/i3c/trace-events=0A=
+++ b/hw/i3c/trace-events=0A=
@@ -11,6 +11,7 @@ dw_i3c_send(uint32_t deviceid, uint32_t num_bytes) "I3C D=
ev[%u] send %" PRId32 "=0A=
 dw_i3c_recv_data(uint32_t deviceid, uint32_t num_bytes) "I3C Dev[%u] recv =
%" PRId32 " bytes from bus"=0A=
 dw_i3c_ibi_recv(uint32_t deviceid, uint8_t ibi_byte) "I3C Dev[%u] recv IBI=
 byte 0x%" PRIx8=0A=
 dw_i3c_ibi_handle(uint32_t deviceid, uint8_t addr, bool rnw) "I3C Dev[%u] =
handle IBI from address 0x%" PRIx8 " RnW=3D%d"=0A=
+dw_i3c_reset(uint32_t deviceid) "I3C Dev[%u] reset"=0A=
 dw_i3c_pop_rx(uint32_t deviceid, uint32_t data) "I3C Dev[%u] pop 0x%" PRIx=
32 " from RX FIFO"=0A=
 dw_i3c_resp_queue_push(uint32_t deviceid, uint32_t data) "I3C Dev[%u] push=
 0x%" PRIx32 " to response queue"=0A=
 dw_i3c_push_tx(uint32_t deviceid, uint32_t data) "I3C Dev[%u] push 0x%" PR=
Ix32 " to TX FIFO"=0A=
-- =0A=
2.43.0=0A=

