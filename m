Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9BA3EB5950
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 02:16:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpzlk-00058l-JM; Tue, 10 Feb 2026 21:15:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpzlW-00053y-NK; Tue, 10 Feb 2026 21:15:43 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpzlU-0001ez-WB; Tue, 10 Feb 2026 21:15:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aLzAKW8sYjBxVSUgq+SZRU9sc6ObsFM6+LjoLpMCG9JXEA1R0TyPSxRJInCQuzovNeg3ZiTI4F5eLGsYqSpb75OjpbjjuJzcjaofiP9lxw/O1cm4MN1Q8ANLe1ep1j0pWRGmkDUwrbyvUXbKfwFYi6sF6qa3WWyWaKSjChZab46Qz3ug+pypxusXVWov6JosmGt6suMXh0rVx1puLblWarZuQW17+3A5qOlmFISTqKY5bcIh+v4l7mez0Jvcn38n1CG+/o7BbsNJ9M+n00SMYN8jNR6ncgwK2kHCdkzryd4t/Gr2hBd3ee3hp3MEhGFgVHRkeT2/RPFPeTc8C4jbJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KlAXv064gcfDzrGFyEif9PGbNQIbhwZv8kNNbLemSbI=;
 b=eWRBEu57uaFrowMBElhzz7ZjhVkChEztC69ZU+mS9+sSN7Jll/FEoI+obqKiztXzWqj1WC0DPR7YsgDIngPHmLc9OHCXsWM0QwSBkdr1iTJwgeTGe6Mk6w7FUKvJdSeZU18b5SCpiHwGzbyEqPgz9HN7XEOb5khIOE64s9nuZ2zB60cqi/2cULJtyd6jPgd+gpEytBsdGXknOYJ8EaAvyweakW80AUUVZJiY7U2mFqIUVxDQMRiTU0MsJGYKMQIV8dWvXiHQqUWFdzaavZRoqKhonIc3/PjXbm09a2o3AfGdNBCbqV8lpdC5gC5x78cTuTp9/UbnuYiNk7bGU6yh1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KlAXv064gcfDzrGFyEif9PGbNQIbhwZv8kNNbLemSbI=;
 b=DVJZVXRxbBQ5SYGJHayf0IHRX/sAj5ppQ4KEiVLiCZ9xgCdRFCRR+3yNCRCN100jXbogF451xMHtkQKOi7G7DtGJmnQMCCSugg42Qb9xATmCvjQLU0VqqwmpPV/HaAwfiAFbmVNsQqfNB7R8gNYUK7K+tKBnn2su+3Vi1S4XsbRm9VT4gPw+NY0+Dkb2UQG5q5XqhxRXyB5wk1pyZwSFkVoHwkmOGE4VUpsvWhC14EgX0y1ju4COR8LtI8fT1jg6lsJUNh3sn7TUbCvWKfpaG1VoFTodqmj1BeQ2YA5PTIbfHXkH5RRTw4KpM0Bkm7YryGiIvFvODXfwevGgR4wl6A==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB7994.apcprd06.prod.outlook.com (2603:1096:101:2d2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Wed, 11 Feb
 2026 02:15:30 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Wed, 11 Feb 2026
 02:15:30 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@redhat.com>
Subject: [PATCH v3 02/11] hw/misc/aspeed_scu: Add AST2700 A2 silicon revisions
Thread-Topic: [PATCH v3 02/11] hw/misc/aspeed_scu: Add AST2700 A2 silicon
 revisions
Thread-Index: AQHcmvxLWIaFTUjRq0+TfkaQA3EhvA==
Date: Wed, 11 Feb 2026 02:15:30 +0000
Message-ID: <20260211021527.119674-3-jamin_lin@aspeedtech.com>
References: <20260211021527.119674-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260211021527.119674-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB7994:EE_
x-ms-office365-filtering-correlation-id: b79fa80c-1698-41b8-5e8c-08de69136dfd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?XZqO6+76ppjKq18TfCSSRsx6mhBIyocNCXf+jKdDiHuQMUk/Zav/eSZOVr?=
 =?iso-8859-1?Q?gIH5RWmUeBVNSXJo0g+mo750OAI4HItfGOLzpP9N0L5Md5/K7h9HYBtD3S?=
 =?iso-8859-1?Q?b5hoFBa4Z409VRTiajLzE3mzX8QCsXGlFu8gKsrrpUTy+yfnULbD/SqdWa?=
 =?iso-8859-1?Q?g6pr894TDja3XW/hq7S2GxRh0lFyPCZaIGyK3Ronsql5rlVii9nO/mWlo8?=
 =?iso-8859-1?Q?twKYNs3bp/4GaWtYUM2BGWsMTz8HDNo1jHmCJjIWVL/L4dI6Bjl1baNxir?=
 =?iso-8859-1?Q?SeX4pJ01Qg63yTV+eBNBQwHdXxcWNuzJa1I7y8m8IFF0NFSNjCRSQcuKWT?=
 =?iso-8859-1?Q?oa3hz8P0LH8BUjGJfiJ6aOWQahpK3Ejviqh2eF0E9seti0mTPuRuTaaqGC?=
 =?iso-8859-1?Q?gPQgCGRJSJ6V4GFf0c06EGrYzuF6hjHQa+yqvECWiwnc4tsY6aAdBesAbF?=
 =?iso-8859-1?Q?vSMJhx9tj/xNbzhl1Xc8IIk/zp0s3rj62qXuiAtf53dzQBItdqCI0Yj05m?=
 =?iso-8859-1?Q?xrqwNPIv7jloBDyI3Kk7LLYcmEkSiG5GS3n1FhW0L8JS0OoR+BlZsiVP5j?=
 =?iso-8859-1?Q?wjLwCco7c88EAm5Adz2GrzF841xhyG9VBVAozrOMEraIBB15PKtlAN5B9e?=
 =?iso-8859-1?Q?ifeqx5/ZoHgcBej/01E1Gf7kzHXXmJlW7qJt2afLBq67c8hQDFGV666ANF?=
 =?iso-8859-1?Q?9C4ZIlsTQITm9OKZLqq/66hDHW2r96RDGLfDYGQtggKgqw/3E4aY3V144z?=
 =?iso-8859-1?Q?adTSBlMoPttMDn3AYGUcH4S19CHQZU4C/kWIy4LlAJjnT2T7J3z2FVCb/1?=
 =?iso-8859-1?Q?2Cw/Lk64W9LnT8JB0Ta7lqIVS76CqHZSKyfBUiGfYzgE65euyuJJdMkD4K?=
 =?iso-8859-1?Q?Zr8snMMiD1iTqPKxmPbHSi11o3e9otkztkvietneI6TXZIFy6r8KXuI5bh?=
 =?iso-8859-1?Q?YxlcJRRbLGH1w47bHdS0bpfteZldg8hZueYejjt6iuy5Mc06MlBHuqNvPC?=
 =?iso-8859-1?Q?T6F/186QGAZqkVYXrAkcN3hFOATde0E2VMtXEU7vVRk9s0lbJKRiebMVjZ?=
 =?iso-8859-1?Q?6K6LXnUyyPFidhIzb5MkqsTqr+8CDEEjYnCbeeI74jeqV5sGAN5mFrEYbs?=
 =?iso-8859-1?Q?Adnl1Mpq1Lvs47yWG3H64l/m7i80BIrr4T4nNkMrufnjw9Lnr4Y1YRU9Tp?=
 =?iso-8859-1?Q?TKThuhEQltzan+/M8Aq7MUmLUUT/yP+h6JW8lEBkagS4o7wVBlgu1qJPNA?=
 =?iso-8859-1?Q?41Lxs+QEuSWfa10iLKnb7pT0jcnxdjaIIdPoKcFNSxDxwVozDHxl/pmoG5?=
 =?iso-8859-1?Q?c5C2MuxnwtJMAQl9cvSE5tns5dn9mOtgasvcT8vfuevHPuH0wVWmE82sce?=
 =?iso-8859-1?Q?BVWY1boxaHccK3U/4VZII5NvO7tQyrNO5SSBqUPt5zgTigiBsvoMrXa299?=
 =?iso-8859-1?Q?TDWd7VZT0he0WnEAMr7/l9EcDTeRLRMq8lNtIIKhTzPPIl3XZzbWp+rsle?=
 =?iso-8859-1?Q?k0U2YAFaKl+FBe+9QB4kbsBM2r3qOyaWYp8SRwfXtGOEGQOMSScw23AU8F?=
 =?iso-8859-1?Q?5OUnZmYqEcCXMmA92jZd5wA8y+Lkeqhk+G0PvokxAZFnV3uigUPKvvH+Oq?=
 =?iso-8859-1?Q?+nlT1Yuf7GrPEWcSV2ivR/7/0ifQNOSTh5/qEb73qOb+oLyShzGcK9UtTw?=
 =?iso-8859-1?Q?lssdLunDfxJLy18n7Owf76cV0mPHhdVKYH7nTOcu?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?vk4JMbepORXtkAvryfNCcCVbhyUaGtB7aGnEZsOaHoMliVsOKc1jK348Jd?=
 =?iso-8859-1?Q?RRvUxQBvwygmWzqrFV2hy7ueoujp4E13raZhfEiNUWdiPzLiSHZGHJnRUf?=
 =?iso-8859-1?Q?8IjbV9C4bo8twhUfysTMAXtbuW2sjRRDeUl7eSi5TohthI7EDFtIub+C+w?=
 =?iso-8859-1?Q?XcwAxiiG7w/ww7EunOfksnhQWRzYo7Rjn2d0AZKyoc24Y4ZHIkaxZ8RycL?=
 =?iso-8859-1?Q?NuJkzrkEJnlBJ8JEPjI+Qt1vXJbr8SgKKqQuLcqzyaBELG3PIj/bnxs/tk?=
 =?iso-8859-1?Q?ZiHMIrt24mZ3h/s4HgPYxboCVdysdF3sLgcFkuGNNTLECUvMa5OLUw7zmi?=
 =?iso-8859-1?Q?AiP59djhdm+cH/FxBzBoNKMjhDWtrlGAdeOX5znFIzkW2F5qHln8zYp8ZB?=
 =?iso-8859-1?Q?+38OiMbKP4AqtQmFIIKdCLyC++qGnRU1OfnaC1ImScnhk27it0JOclY+vf?=
 =?iso-8859-1?Q?N4V4V40nTk5hbYig5hh9nzcgwdFrIygEH9BfR5QkHXB04jD24aPuyHAlZq?=
 =?iso-8859-1?Q?cfQor9pLjlmiaW4OFFZpSgt6DmII97sXeXhVDYMTe4uceyUE2tks9ZDZTf?=
 =?iso-8859-1?Q?AftnJfn7t+/YUb1uSMx9IHXlsgWmJgPlddNfmlXxrzzJ+ZA+eXPbvoxpPe?=
 =?iso-8859-1?Q?BWaR7cX729K+J8ulHktJHL9SJTP206d5Iy24Ffu772ajwtD7012XK8EGBh?=
 =?iso-8859-1?Q?xF7iKXS6NW7d06XlDmDiSajVHBEQXr1aILiPKEbkhTWgTe7MDE9Usv4kLw?=
 =?iso-8859-1?Q?o2P7PfVgM3GaBo6xoPaSDXIslU3fb0cSMoJK07CMWfRulGIpQPcV8g02HD?=
 =?iso-8859-1?Q?ZENJjDVDJ3tBPb0SPd5d+6sjO1xSjYnARj8r/vGxrCNdH+QTXru/CK8c/l?=
 =?iso-8859-1?Q?jKIrMcCwFeh/q95QmHGnrMALZ9QFUbxoEAew+YsSpIVteKfewU/hoso7YU?=
 =?iso-8859-1?Q?WEsNxgNAxFQeSNJEYeMEoGvuC8Uty7qZb9o13d3LqA8iNrtNSt/1vTS3lc?=
 =?iso-8859-1?Q?1wlPSRSV/D1ezUU3tQRuUTHwDS/cbPiLlYt5mvJkqbi4TjDN+ciEB+jJoA?=
 =?iso-8859-1?Q?aEQZB2ZavXDcAonzSs5JDWL2MkXtvwqIvO8Ad7vqRU6bbWuYJRr7g0/WQl?=
 =?iso-8859-1?Q?5n4+ril/RxpMjaig87WPC0Kd7l1i4C/RllgZyXp6q2Lurz86RaCqBoC443?=
 =?iso-8859-1?Q?R7N3u6WFEZ1rHdiweRajEObFE5jb/rZfsiaooLDglAoIVJrpd58B4mq2D0?=
 =?iso-8859-1?Q?wnjQc0Db/mB3IdX0lrOuFgS6tH59n9AsD7zny5gdOOHqjh3qAYnaQeyfF3?=
 =?iso-8859-1?Q?mKGxh8GYTXYEZwQDS9AYIctiHeRni+ohqtJ0dyzPJfcJwzKXBVeCc6ulpA?=
 =?iso-8859-1?Q?7h/IYqYyfBsCkwy0sYKaKK6BOS0Ss4Y8ZGDchw5/PSbmjyTJhU+TqJDGjD?=
 =?iso-8859-1?Q?4j8+PcKFcQO4/UkXPJ+66hXnsT86nlV0fjtPSL4WKCiCpsowtRoXTvql30?=
 =?iso-8859-1?Q?oWindYJSCzwev5sxatASHjwUw2d2qT/BUk6nlnO/sgfScw/XekTZ3JYiDe?=
 =?iso-8859-1?Q?Cv4uVo0hMSMQbwDg0wmKbwx1r58XRBZa7z60DorhUqk5YvStBpabWRlVQz?=
 =?iso-8859-1?Q?woHr2wx/R+TI4QimMqKSsvgfBLVejviTaLOBbCAwO1uekE/NZkDjcvWb7w?=
 =?iso-8859-1?Q?VSjcapX4gTb5AlRCoBSrnrww6u/3ru0rsVS7f6ETUaQUxbjyOlEL/RxEWU?=
 =?iso-8859-1?Q?NI7pf4ufveaiXeDZltbmxJerGVnVpUSsM5sbn1nJTC7cjG2grrNJ/D3mZ3?=
 =?iso-8859-1?Q?8B+Uc4/DFw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b79fa80c-1698-41b8-5e8c-08de69136dfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2026 02:15:30.3341 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oc7vmy7RTpKFgyPiacKbXR9lGgYF742ALxjgdw4A7Y2f6U0jdP2VC4Fy1Y++alfmR1NTgcszr1s0cHGMcnZgjxArKo5+XLQjTZ7psWwWGJw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB7994
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

Add silicon revision definitions for AST2700 A2, and include=0A=
them in the list of supported Aspeed silicon revisions.=0A=
=0A=
This allows newer AST27x0 A2 silicon to be correctly identified via=0A=
the SCU silicon revision register.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
---=0A=
 include/hw/misc/aspeed_scu.h | 1 +=0A=
 hw/misc/aspeed_scu.c         | 1 +=0A=
 2 files changed, 2 insertions(+)=0A=
=0A=
diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h=0A=
index 313a79f2f7..d003955428 100644=0A=
--- a/include/hw/misc/aspeed_scu.h=0A=
+++ b/include/hw/misc/aspeed_scu.h=0A=
@@ -47,6 +47,7 @@ struct AspeedSCUState {=0A=
 #define AST1030_A1_SILICON_REV   0x80010000U=0A=
 #define AST1060_A2_SILICON_REV   0xA0030000U=0A=
 #define AST2700_A1_SILICON_REV   0x06010103U=0A=
+#define AST2700_A2_SILICON_REV   0x06020103U=0A=
 =0A=
 #define ASPEED_IS_AST2500(si_rev)     ((((si_rev) >> 24) & 0xff) =3D=3D 0x=
04)=0A=
 =0A=
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c=0A=
index 0edf9c1b16..e4160356e4 100644=0A=
--- a/hw/misc/aspeed_scu.c=0A=
+++ b/hw/misc/aspeed_scu.c=0A=
@@ -561,6 +561,7 @@ static uint32_t aspeed_silicon_revs[] =3D {=0A=
     AST1030_A1_SILICON_REV,=0A=
     AST1060_A2_SILICON_REV,=0A=
     AST2700_A1_SILICON_REV,=0A=
+    AST2700_A2_SILICON_REV,=0A=
 };=0A=
 =0A=
 bool is_supported_silicon_rev(uint32_t silicon_rev)=0A=
-- =0A=
2.43.0=0A=

