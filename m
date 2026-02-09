Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7814CE78D6F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 09:20:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpNO4-0004gP-Fn; Mon, 09 Feb 2026 04:16:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpNO2-0004f5-Rb; Mon, 09 Feb 2026 04:16:54 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpNO1-0007H3-FM; Mon, 09 Feb 2026 04:16:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XyaYLVnfvp7Gxc17xlla7AMUwJ8S8RjCUxn1E8XBDsgbUuFj/6PC/oLLOfqFC32eLL4EmZC8y/p1cfl12Hoycv85H2QIyiUZNwd78UhmyVgrb2W4mAPe8yHQ0rFW+LjtgkLk3kr0uU+vUqHDwczU2AbdtiYDD+FMDr8JIpQrfKb+QKSb/UZqTNfDXipsC1aqP7KZ5iTclPfZOVFFK7vczRIE3Nlb9ibvpSUzqrpJvDHBbema3Ua8HyHv5QFGP+ZZgRrp3KQKM8/uFKi70+Jyr7oYuPidqQ2kDe1tgqarDbVluHNnbuk9WNQ/EvoZkvXu4bJrlorIUJo8S63wWzR6ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DjmDhdIPKiTCR/s4ZyAOgOa2CyXAu08wFzTTJSSl+XM=;
 b=h95iQju1BV7PFrUp2RVTPEiUFmb1zRC3Gyk6ScyrxRMpriGMA5GuKBRPBfU/WKKCM+t1aPsF4ZA5lRsprnWV1P9dk7sz/pQnzf2HxpNlLplpK4rIfghc9b0i8ZX/nQvH6UVZQsdVh9bAlNUdfixuERyLL983mx9HIPfvn0tMQfP7A3UYfapLo96WpkQHAZYfXYY/IpBVgMxRM7Vl9lVSogjrvUqmjuKJhyzHuIZbo6Uafmdnm8zb4IOpIMRcegEn1uJUZjIxwhTySPk5MoR9U+6YmEdLyFETGRT4VzvTtzZtyJW1+9miD9CFeG/DYbtteAj47PnMpu9co9Fzp0YhMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DjmDhdIPKiTCR/s4ZyAOgOa2CyXAu08wFzTTJSSl+XM=;
 b=gtdprj6CAIlJ4dUQuXCukSAt1VONMYpv/DxJfqeXjaH63QbbJiEFJkonuL/y9KfOVUKIsr/NrY5NRaT2Fdoz9tmlBHLt8j0fn9XJUr9mF55IcYDCm4u9mU6GbRM/WC3JmYVn9lulmXtdzTQgDJ7XHdVUjsJN2L2L19YF1NOD2dlH9LSOrg50PW6dcGZ1ylDc7TGKp//qYf/kfAdz4xKSta87SEYVMA6gGfDZkiGBcnenCnm9/AZsQWbLV99rZEeSdgb3ZkVFB7TgC3Wn94/p79YXZT1rlU1JbVa7un5co9gGbmjNtrGuN24NvdFLniDDhcp1gx8ZI6k+yXAg6sgLow==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB5784.apcprd06.prod.outlook.com (2603:1096:400:268::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 09:16:43 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 09:16:43 +0000
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
 <venture@google.com>
Subject: [PATCH v4 09/20] hw/i3c/dw-i3c: Treat more registers as read-as-zero
Thread-Topic: [PATCH v4 09/20] hw/i3c/dw-i3c: Treat more registers as
 read-as-zero
Thread-Index: AQHcmaTOcf1prTZbPkebu8PqhLX+4w==
Date: Mon, 9 Feb 2026 09:16:43 +0000
Message-ID: <20260209091629.823457-10-jamin_lin@aspeedtech.com>
References: <20260209091629.823457-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260209091629.823457-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYZPR06MB5784:EE_
x-ms-office365-filtering-correlation-id: b93d3eab-d001-41ec-99a7-08de67bbf13d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|921020|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?ITBDL7Wi9nBBGv7m90l3devhlBsy150VV0KAVQ7R5G5bdPhifLmhMx7Zup?=
 =?iso-8859-1?Q?JeUDa3cs4cEiEnQ1FzqX8zNajpFGcI6Gr3/7yQd82xKnRQLqvip6IdYHQW?=
 =?iso-8859-1?Q?JqmBBi3XrSe/y34yGR8HMJLxn4G+gibX9/X3ylV2NLvvd64wC8BlXV5uiX?=
 =?iso-8859-1?Q?QBynny1tZHO0/LiXtkngH1ahc2BB5Nu49c5E9RzG69kXWdO7hu1YcgDdp8?=
 =?iso-8859-1?Q?nGoZLOGjlwewhtHXU8Q7qs2wgeiSbnhL8pSSJWc5W2btAU4DQQG/uRWIE2?=
 =?iso-8859-1?Q?yn1XTEzqj/nh59dIEalGVi8kYYgo3+AQlYStuan5GOFj++/gkvMFU/xGup?=
 =?iso-8859-1?Q?eqXVc6gcX/Fu1FeTUNoOx21/HJMj7hitXIL2OKydwFSIuRwextU4Ejcjm8?=
 =?iso-8859-1?Q?8jwG6dwCwJHyDuL7OxOgOyDe5WG3p/QAYt3vHv8hR8hiHWHtZxrxUrMOLo?=
 =?iso-8859-1?Q?rESvXhxRzh6a9qLaZCyWEASBsTlMXsaqrat91vwUF1tPDrOOcv7pIvt797?=
 =?iso-8859-1?Q?92Mw1EBaWutDKJsb4NELXZj77f15nzTVQfmnkRum5AGPPI3W87bdI2QRzM?=
 =?iso-8859-1?Q?uy98BpnmNg8i8rX8oNUbjZ6shIfKVFXLbAvzLxw/yGfEs8LETp5t/ysiG9?=
 =?iso-8859-1?Q?9MoF1ZV8/KEUMSnD2Yg+QO/46dnD/yOHin/kjtU/fq8Se7yKln32ulpU72?=
 =?iso-8859-1?Q?mE1qioCwOM+0JGy1Gf3nYchrI0PN33LFlTsMdRy2+LnwC0le3TNUiAQKtx?=
 =?iso-8859-1?Q?jR5Ms0kOkdRCOwTllUy+EK841PYEPghmrjmHRl6SvNe0JampDKfbHlVvSE?=
 =?iso-8859-1?Q?os+LmZPhraUo2fYRm5lgNoUYsO/zf11IE18ZoF9+6q+jcRfWWHryt1k1BB?=
 =?iso-8859-1?Q?EW9w1cJZazS/0Qk+r/YeOAbbXGt5dqEpCMs82dc9ElWMLMQ5SCSEpNqVCk?=
 =?iso-8859-1?Q?nc5HUnTTFuAD+TWxmnAyiXfwKVYlhyhvKBf3jQUh0I6ycAvqCQNJf2Ht/y?=
 =?iso-8859-1?Q?1cz5Zq4MB77p0lyf9u2bWMDujcmLSCHKAYD64MEEciSPA4xgAxGIjzKGF/?=
 =?iso-8859-1?Q?mN0OfMu5XiWz8rOAiAS2VUbpJxGW02dYu6gzQAYjB6JbfCdbbkqdczfn69?=
 =?iso-8859-1?Q?96+kBw/e16mdxzR1izuxSi+/X8rTq5lhoB+BfHsVhSmGOrgomWYca7bja4?=
 =?iso-8859-1?Q?XOgIkh+zLkO40jFd6ypV/JUJOOPzkUPlXNYlVkzKX4PLpyteqVM2CgzVn4?=
 =?iso-8859-1?Q?giVA8bQS43llzqSJL2FSAoQcJWbT7v31vJ5z1zk2XF8ZimxcuZFUu3YG1S?=
 =?iso-8859-1?Q?5HKN1UP9uEDtjYs4aZfOjYpL7qMf8koULCd4iSt4i8gS6UERHmCt6lhF/9?=
 =?iso-8859-1?Q?dhrMIuDlW5bRi9jXLox9g60JUMuPJ86xiRhHPE5C3hK24aX8h7ZuJX//dw?=
 =?iso-8859-1?Q?LOWpVGYNmp9C1QsGoGvrHP/hizTzhw2+50Gr2m8TFr1FaB9pAlrWlvtsP8?=
 =?iso-8859-1?Q?Cr43gst7CmSZrKDc39rtddXaPP2TVXQp+VlsMNkkxWGDf+NRccr4eOXb0f?=
 =?iso-8859-1?Q?uvNIng/wB27waouHMmJC9R1dmvPT+dMjQclRoWBLZZ3bo6NYaLzDg2QMXR?=
 =?iso-8859-1?Q?F4tYe3rsg0b2qMD5tmY2uBYaK1vydyjCWcoZ26Cz0rJfMT9PQzpp64+XEf?=
 =?iso-8859-1?Q?m86raNzwDyWCORPRJb8u/7I77MmXctA2pQ5fNAz4?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?c61qnUajJA1YiTChSIMFxXoHkAMclminkzRpc94nVpl2cwfJHZJGEuyUn+?=
 =?iso-8859-1?Q?mi/TOLHMlzWQA9uU5KR3wtZwN2dVi8ZGPswlYdWGqI0zTMxUmmC+dfoxo+?=
 =?iso-8859-1?Q?aeQP6FeqHd5Jh9Rt8meoeygJyl3VybHpcCAGicCJ52gK91XQ3BYNsTCtLR?=
 =?iso-8859-1?Q?pwLeMTJXunJ7bO/pshN0iXV8yXftJ10yOnILsuUj5W8dZpRMl0ZHqS4cxM?=
 =?iso-8859-1?Q?TP8p01bcbv1AYkXpKXWW63xgY0oSRpB+MuKYp/YFBfBz0lPriwZc8SRKe/?=
 =?iso-8859-1?Q?d0to2qa/xNm1Bj9xnfiXktKAhwMyVa1EpMUpI5mNVUXHodb/Gw9p/Q/zDN?=
 =?iso-8859-1?Q?kz1PxaAv577ktB/wC08LGJUzvUP2o6HTB4xJuPiTPtKQ4RUOkB7QEX+oVb?=
 =?iso-8859-1?Q?FleLE3U3mvJPSZKMsblorX5BcVFScyXiUWLAOSTFOJTLkS02lO6Jn8EilO?=
 =?iso-8859-1?Q?H2tBHkO8ZTOgNZn1YubJaWrPVGyMjICKs9R1bLqmjngcJ3Fz5xnUbn/8/L?=
 =?iso-8859-1?Q?QcMR/rMleCcHF6RyyAIsDFDN+BshVsZqKK0M9DbUxdtoo6/DXVS/Lnhlp8?=
 =?iso-8859-1?Q?yE48y7qtMbxiDbvTnTeUCr3PgPpWXtLp7uZxr+ZBPEk76NrnjQpJ0Ggb5n?=
 =?iso-8859-1?Q?iAOujQTJQJ/8DjSVzODZgDzJlsF90EdcqL6QLZVIpQ7JPRo7pmkJJ9Fjwj?=
 =?iso-8859-1?Q?AIO/c1ftKMtWwS3z4COQlefbUuPJpBEXuVz2Sv3IIZIrt46XXPja4H4xxd?=
 =?iso-8859-1?Q?WggLuYjpjpwiVO/xmCbd6vImDHgJg+OjSrYDfa2uU6xkwhsQu4q3Bt7xyZ?=
 =?iso-8859-1?Q?+TI3vYEWukVQ6S1GTqQxD9lPN1ewV+mg/KS5Ff9mGDXJfjA1DHgzhhRY0F?=
 =?iso-8859-1?Q?zZRg6uGH1MqtQmeej8+DuwsORWR+3GRSCBo68+dB248FHPEW5ytoppM/Tl?=
 =?iso-8859-1?Q?Y+FmTBdWrm07lZrvI+tZQX0l/GvGZQPg7DH0hTExulsMVh5wpaiGOb+3b9?=
 =?iso-8859-1?Q?zGa8b3nXP/9YeFpg3fD8bF8Zc5g0KI1hb3WSfymV6z/0piZT0GPd6nyPna?=
 =?iso-8859-1?Q?GXgfAmjUxjN6bej7pgQRcgtmSGa3xePBsEGfTQCvOyH2mVUUiGN1jRDRJZ?=
 =?iso-8859-1?Q?sm1sN0UEKWqcj5JPQfS30KDW1Y+KKcumY+JzrtwDmgiF8EpZY00fYp6jK9?=
 =?iso-8859-1?Q?Mu8T77COsrKcc+tsK+HObzdXIMCFZ0zydaDC8IYjyZkrrk79fmsBRET/Sv?=
 =?iso-8859-1?Q?kKHoMhAtraMb+cE/iqMqwL2k4IzU3uHjo//qDVRrSBibjGulLfsWntXPA/?=
 =?iso-8859-1?Q?jRW/0EAA5ZZ6ILdS/7ws+XQZz4JsyopukJtYww6ClS5AVs2aQV3QoJm+DV?=
 =?iso-8859-1?Q?wDIFnat2MmLCOzT4ANKwzuWoR67xE6Tspz3QsudBxDA5VXhC9tUGCn8AJf?=
 =?iso-8859-1?Q?/guo0+8yRu/yUcCJb/uZaPp8rslETyfFrMig/L+iIIjPQ72BZDhNbOrm7R?=
 =?iso-8859-1?Q?xKprY2sYESukhjujghmF/BAuC/bNzZuu5LeFdN6Co0dQN8C4Zbz5gCElKV?=
 =?iso-8859-1?Q?ofleGY3F9CajhnhoFv164aCsuWwBUOLGCU105fb3vQtK96tMCkvWUfF/bE?=
 =?iso-8859-1?Q?u160je8Iya2gRSHVN36jlcLjt1STaE4Ddy4b24gA8xeG0bnEJS16oWNtw7?=
 =?iso-8859-1?Q?HkQ6N1WHWr3SxQxvTx2hardeSh98ecpxF1yVHfD3ayw9Kp+EUGCc7/rDaP?=
 =?iso-8859-1?Q?QqO+DA7d4X8fM35n/SGnAfFkwQ656x6s+3fM52jVChHOGqR287ihoCzFlC?=
 =?iso-8859-1?Q?8b3vJeoyww=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b93d3eab-d001-41ec-99a7-08de67bbf13d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 09:16:43.6974 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eCTFo2bB1wTXAe79O4/njkqw25ZDUHG+bsy5zIo37XYQxX7or4nkFzPygVdXuvxRdbjf2SBliJwpSpO91TqzXvHnCvbACELMXlLN2KXspEg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5784
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

RESET_CTRL and INTR_FORCE are write-only.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/i3c/dw-i3c.c | 3 +++=0A=
 1 file changed, 3 insertions(+)=0A=
=0A=
diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c=0A=
index 02fa9b3c00..e20244de2c 100644=0A=
--- a/hw/i3c/dw-i3c.c=0A=
+++ b/hw/i3c/dw-i3c.c=0A=
@@ -342,7 +342,10 @@ static uint64_t dw_i3c_read(void *opaque, hwaddr offse=
t, unsigned size)=0A=
     uint64_t value;=0A=
 =0A=
     switch (addr) {=0A=
+    /* RAZ */=0A=
     case R_COMMAND_QUEUE_PORT:=0A=
+    case R_RESET_CTRL:=0A=
+    case R_INTR_FORCE:=0A=
         value =3D 0;=0A=
         break;=0A=
     default:=0A=
-- =0A=
2.43.0=0A=

