Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A980EA3F28
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 09:12:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpjm0-0001sk-8l; Tue, 10 Feb 2026 04:11:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpjlw-0001dK-8k; Tue, 10 Feb 2026 04:11:04 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpjlu-0004jF-PI; Tue, 10 Feb 2026 04:11:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UvcFuu7LIh5xVjbUidd0ZgYa7gyOtkEBXe2G4fznstjixFI8r2wCUFK5GRxB60c1xd57IsfKAs77S19zH7Lg+3KocLPMFvBS1ty8cm8iaMzarl3f1Q1lnKX0ozR9PN5O3wLqvfJBB6kj0Ka+GRi+sj4WMcoEHx21k0ouExARr0OhYdRAESqQ95O06zWogA5NNosltZ30LUEswDZiXondH8uodoGA9yHZiWEYVUzvV5Vf7Uq/bJGf+/Qju9qSQTqA2TXQ4nLA9FvBPXQmiHluX9qfKCdP3PMsn5NDFQ1n6l8Sd89wO8qnhaPRcH1lHckV2kR9Ogun8kDXq2v6y/mASw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BrDshy7VWeA9H+0OoW8EVb/iuPmeqQzByo2u6j5AVVQ=;
 b=KcVyWuBRwuptif8npY2Usq0S8VAFXdwH9TIYAv2dfl+f4mLpwnDapRfjvc6k3UoXjxKStbG3jli3NSMSJDN46tQ/cWd6kayvwVZCQlYRfJtXKL2u+g8HZIYdHURjSSBRU+mduFHM5SPMn9nGEWCRjk2AtELdXr8ZXYPtiSiavA4UluX1GjdW25eZLfFtsyzuZjP4FZDNyD8gmuY2iVXmtxOai3T57llaXbb+JwQ24h0JyfxPrjeFVPvtM79x5S9sxcAKgxm7pSG79x6RO/nS/Lzm43xPhbAptx4HN/hCKVsFgPrHXd/KF+/9ybI47O+aS9omEFkq/hBbGnhUDJTONg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BrDshy7VWeA9H+0OoW8EVb/iuPmeqQzByo2u6j5AVVQ=;
 b=i2dUAHJah4pySTgPMZXsxbubkhWYcWRXoqDeEd6QI4JONS1Mwv+XqSZIam9wG6JhYuQk8EO+65JbPHGCSg0qgcbNpdMdixb31FQhNPpi3UUWawWiyjRUNjQCbXoplHA0h2x7Fd57M6Ac4jXPyi199EGPZGfWMqGWCtfC5Ls97Ql2Wo111+Ti6iYOpdT8Cdt/YprTcxW8T/GsrhL1x8XVaPXa2MDHEJThqUaH8fcbYq/cU32K6G1wH9bdlMUjU8fpKlcrVDSgsBA2TTIH7kFDABYP5jQxI0yJ50d1lNo29QABFxEWp29wz9o/Sf/c51kFRfpDgUF9/nX/+CV5D4Xg9g==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KUZPR06MB8268.apcprd06.prod.outlook.com (2603:1096:d10:62::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 09:10:44 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 09:10:44 +0000
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
 <nabihestefan@google.com>, Joe Komlodi <komlodi@google.com>
Subject: [PATCH v5 17/21] hw/i3c/aspeed: Add I3C bus get function
Thread-Topic: [PATCH v5 17/21] hw/i3c/aspeed: Add I3C bus get function
Thread-Index: AQHcmm0j49tSvq1bJUOevjycdFIE9Q==
Date: Tue, 10 Feb 2026 09:10:44 +0000
Message-ID: <20260210091018.1553489-18-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 5f82599d-dd18-41a4-32d0-08de688445c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?3sfjKyxfRvfSzJMFe9x6lUXPdem3Xq9aHQyyUSNjdBuGmg6f+XgugSqzOs?=
 =?iso-8859-1?Q?fzMtV7oOtFrq5c7FdzSSbUQiLtzr/QQBt50Uo+a9IN1lDdjUIx9SSPdvZ3?=
 =?iso-8859-1?Q?nKT7R9KoPyhj6CTyQ1BjA7Va7O93Qom6KSB272uRFdjTJvapEuNpT8mTb9?=
 =?iso-8859-1?Q?pW/NmL6pvqlEYV4FnLSEUBLIuEtojvT6STA27XoweXCYCduudyEGcWnFde?=
 =?iso-8859-1?Q?3WmxqbtVd0BKBwTFv3vV7i2xc3fWApUTrkw5jS6jVytyMvdrx5/pBK/9W/?=
 =?iso-8859-1?Q?1ED0pMU15sjtJXpvEYNCsFOH6gkTzIVIanzHYuFHCUos0iloYTMunOnqQ/?=
 =?iso-8859-1?Q?N5AM2pT3km7U3p3s9MFhrjse24R7FcfO0cCC+d1tPmPS7/cY7mEr6rf+dj?=
 =?iso-8859-1?Q?Jgpvgwcz/v0cawhADDChZ/fgoiD5q0PjBctnTLL2Em97YjvNolFnRbxUBg?=
 =?iso-8859-1?Q?MgNy3gj+LthdBs2L2m9Raernp/dMDmvyPDfuWnMHG4OyXbNpTsWIFoVlG2?=
 =?iso-8859-1?Q?uJmVE36XreEuCQTbC2sFb3d7Q/+n0R5dkKNW6xPa3egec3fyJK3GFFyezS?=
 =?iso-8859-1?Q?+4DHOjNzWNYcMhDWqW2gaZYKi5r7H36/0xgBTzpVRiF5boylTO87NpQJIZ?=
 =?iso-8859-1?Q?5MYdEX8TtT8Ip7xo8JC9a3HgDJ0vSg+heBM4pLBntkBw4059+LEJpFkgIT?=
 =?iso-8859-1?Q?bpXt8LLLJ3TeRq6lKPXvagzXc42h8L6ik/hfFiaNlAnkppzRcJyY++wwck?=
 =?iso-8859-1?Q?FeqXpbOKaJ8L87H8QQaPVGF2Tsy9x+ElKhrRwBy9AM5OtD77xGd2PAt+P2?=
 =?iso-8859-1?Q?QJKeTx0Gr5ThUFPzjqBm4iEUIIOUXhUF5N411udSr+QnSPfuhE4m4vkzln?=
 =?iso-8859-1?Q?tcN3H7+KBjAX2Lsw/SYbpPEgz9lVU2L/rLYQHglZfjDUUwRWcNGD9N9rhH?=
 =?iso-8859-1?Q?V5pLGRnLHdH0JaK5GoKjC8/H87oVHzp6AobdUCRM8JXxc0cuF5EJ1owgv+?=
 =?iso-8859-1?Q?iYjU5WwnznxrIE9L0XfwfOxpiZwEF0YjXneU81pnr1F1UZqiYZnwC17Fyw?=
 =?iso-8859-1?Q?IF1u8WGsA7bTRT48VzWsZu0vbZeKKuD/LfbfDvF6rOz5P5LZ04GamkqoKo?=
 =?iso-8859-1?Q?x6+3nNr4CUXu6V1hKPH8n0llBrHA/en0IV0NXvFP2at/8l5mPNMkaZVDQo?=
 =?iso-8859-1?Q?cqb3UPNc4EADZT4SsHR1yzP9g+cqjUTLGBMQhqTNVynlW/1vpWwHrLz4sJ?=
 =?iso-8859-1?Q?0ZsVJDU72/eO/4i69I6Op9aiU9IVESsGPlLaIaSrIgKONJt74WE6nrVddb?=
 =?iso-8859-1?Q?g1sf5W3EEfKOR8NILjiVRDTfjPvYRphbQPOSvLAexLirVCJz0IQiB6rqX9?=
 =?iso-8859-1?Q?Jn98Yll55YDeSM3TscdDFhJ67DPIOlkQYcg7gQVV0ZrUCyU4kLu1G3GQ8m?=
 =?iso-8859-1?Q?2D3SJ9o9JnyC2w9nwO9bd5fvRsi84tyJ/wYf1/O6V8kb6fdYAuAmjTIY5h?=
 =?iso-8859-1?Q?8dzQiJW0pcLznWivthnLZnsidZ38oukQTd1AH/iFdXmSY1jxNStmWM/AHz?=
 =?iso-8859-1?Q?0vz1P+3OadamxCkVAUCBWNMc2XMeghuCzAvH7Ps41IroPjOgLJ5297m81P?=
 =?iso-8859-1?Q?uA2njtCSc2ApXGXDS7mDzakmSrJTHv5oTxXqCaeEQ1tR9NZK/LKhafmfZh?=
 =?iso-8859-1?Q?gkYDpiqdPepqveG1INfw/XsxD+aGygfTJ4KKVbms?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?T50bjXN49BuTNv/5dHcHpPx1V5d2/FW6TIPD6/TY63V7X4elkk7/Wjuvna?=
 =?iso-8859-1?Q?4dpJywMkfvrXHeUBmiNjUBVxGW0D2RbQpTTuRRwnsvdA5oE8DnJIBiNriD?=
 =?iso-8859-1?Q?w9yjpUbWSxVk/hEap2n1f4Oe1/h3Rcx7BT5noM+bfrBdYCQjxy9KA4NqKy?=
 =?iso-8859-1?Q?MQ3gXYRlp3D1OevDbHjXlIQ49CcNa0RIX2Yp/fM6pYQ1LzaxJzZmyLWPB7?=
 =?iso-8859-1?Q?rgXhhWCTLrRwYuByEoHUewHlqPylu6nRFxSY428fF5cGQHrhnYhyy2iEPT?=
 =?iso-8859-1?Q?e0YqCjxXWhnDjHze+K1ZJCrbvYjWkm4uplYGTJ+cZg+tCFdMx8sr8We3D+?=
 =?iso-8859-1?Q?OaN3hZths4mgOuNhZIpxJDzytgwrwyPZmv8wdjei6zWtrAngVzhQ7qjdni?=
 =?iso-8859-1?Q?aEIqpn343RlCOmfB5FqAu3X/XTaDfZ53iaTSXQmvGmM7ppW0tInwVYJP5L?=
 =?iso-8859-1?Q?DEED4SrKgMK6hNonLYKVNiwbdgJ5ty2DFoTnQZ9XeVep0Gi4fS4wbcU44D?=
 =?iso-8859-1?Q?3XHbqW1jOjg6k5MIQNHGc1pH22kjr8JNJK1lXxo+2sLMMmqmeqz0a9jhbf?=
 =?iso-8859-1?Q?UnvGKUOiLBEwHeCVUdvcJmWgjbK6T9zpm0ziRYi5leq7KYp2qrn6On7njc?=
 =?iso-8859-1?Q?VXtDwXO/iFYxJPQFyey2qsFAW9yQBNkQb1soWTd/IvPUb+e3gJYyijW0GR?=
 =?iso-8859-1?Q?VMYENqjotcILV7zP2NyGjKVmP9M+8RjzG8gErr7hWrSd2bkvw2DDPhpGU/?=
 =?iso-8859-1?Q?WX1MPL74VBIAX8B6lUdMPcJr03i60PuxcuP/airoNUOAr0toWc8x6HdOHf?=
 =?iso-8859-1?Q?S3Y7D2pxytAO+R3J31jadhz8CHW4154RXMcvIelkpSTqot1+jlq4gpAb6v?=
 =?iso-8859-1?Q?yVknRp+wObpfgoaLF/NkK61LN4ntiWHYgDXIQQVmFPGgWt6ghXqyJrl+pC?=
 =?iso-8859-1?Q?muXvZFGmIEU75CoCe4eGlGQCIGJQyTHAOvyust2aWV32EvbxzKgFQ4ubrW?=
 =?iso-8859-1?Q?w2EQCFJl/ncgOKDG64o6jLMGjdjEzB0B3ewF8iiNpi7kF+EyKLDKuEe2Wd?=
 =?iso-8859-1?Q?9tPuojTbuyeA+t3uqBovgtqaKaZDmbFjZ4GSuDLoZngFrOk72TEZfJt5hN?=
 =?iso-8859-1?Q?sD6MsDuCkFEuLE3FObsx7qJZenTyi64XoMzvFTz+KCJ/F8Jv8VQYymfr9Y?=
 =?iso-8859-1?Q?wM2ZH+fKWWr4Ub6gFtuRr7yf27vvuELdRhIZHX8CFam+XhFnTS7hhJGu+a?=
 =?iso-8859-1?Q?kjhc3JMi2SgHys3k6+q+CopOxnKAwMYH0ItDXNHqju6gYgATOAnw5jZBiZ?=
 =?iso-8859-1?Q?uXkwvuUGmtmeTftFqc58Z9JtVAtlKx0tclKKlqiX2CcIl6S+GRnosFcxXX?=
 =?iso-8859-1?Q?MxN2sb28YEkqFAEDan6ZawAYnweUjhvuL+CI8Df6ibjLAPP2ipxXvwjkDQ?=
 =?iso-8859-1?Q?4VkoDBVYyaqy9LplzdzpszPrmX2TsLpezHgyzl75wAZj458phU/NHbj/jS?=
 =?iso-8859-1?Q?YTkHXajinVIlCJY94CTS6eOsrfsq+FRXAfi87KIgwxa9E0HHjnR9JWNBn9?=
 =?iso-8859-1?Q?C21kII5Dzutyl1VKRLomWfWTIewh+Sp+lB9U8GxoMwNFLW7cZJxy619hSU?=
 =?iso-8859-1?Q?Rm8iONe6tE6zX1nOU49TJpQ3JZEDy0CVmS4vSZMMbsNB45/4rAFrNwMYrU?=
 =?iso-8859-1?Q?Xk4RbhOor4zNae8OEFxT3Xll9wv6vILIYJy5hD/aBrmykpn22+zkjEMfMg?=
 =?iso-8859-1?Q?o/6pONrKPiB3v2UOzkDcTfTYYSHWpz39b7Y1C9BAKg3eYh4wDTetZl8lDm?=
 =?iso-8859-1?Q?jJPtx4pqEg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f82599d-dd18-41a4-32d0-08de688445c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 09:10:44.8207 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sTUlMgFIvxXOckTZFlz4ZeWFmY0InxPHedj0kUq8fI8TQR5y6SVEIW/NX8Ct+u2WerW8f+jAH1DtokVnBMriTx0qn/H8i5GR2lTH0rIjnYM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR06MB8268
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

To retrieve the I3C bus object normally, the order is Aspeed I3C -> DW=0A=
I3C[n] -> bus object, so make a nice wrapper for people to use.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/i3c/aspeed_i3c.h | 3 +++=0A=
 hw/i3c/aspeed_i3c.c         | 9 +++++++++=0A=
 2 files changed, 12 insertions(+)=0A=
=0A=
diff --git a/include/hw/i3c/aspeed_i3c.h b/include/hw/i3c/aspeed_i3c.h=0A=
index b8827d31d7..42c9eedd85 100644=0A=
--- a/include/hw/i3c/aspeed_i3c.h=0A=
+++ b/include/hw/i3c/aspeed_i3c.h=0A=
@@ -31,4 +31,7 @@ struct AspeedI3CState {=0A=
     DWI3C devices[ASPEED_I3C_NR_DEVICES];=0A=
     uint8_t id;=0A=
 };=0A=
+=0A=
+I3CBus *aspeed_i3c_get_bus(AspeedI3CState *s, uint8_t bus_num);=0A=
+=0A=
 #endif /* ASPEED_I3C_H */=0A=
diff --git a/hw/i3c/aspeed_i3c.c b/hw/i3c/aspeed_i3c.c=0A=
index 2700c5f4cd..bac8c55bb0 100644=0A=
--- a/hw/i3c/aspeed_i3c.c=0A=
+++ b/hw/i3c/aspeed_i3c.c=0A=
@@ -153,6 +153,15 @@ static const MemoryRegionOps aspeed_i3c_ops =3D {=0A=
     }=0A=
 };=0A=
 =0A=
+I3CBus *aspeed_i3c_get_bus(AspeedI3CState *s, uint8_t bus_num)=0A=
+{=0A=
+    if (bus_num < ARRAY_SIZE(s->devices)) {=0A=
+        return s->devices[bus_num].bus;=0A=
+    }=0A=
+    /* Developer error, fail fast. */=0A=
+    g_assert_not_reached();=0A=
+}=0A=
+=0A=
 static void aspeed_i3c_reset(DeviceState *dev)=0A=
 {=0A=
     AspeedI3CState *s =3D ASPEED_I3C(dev);=0A=
-- =0A=
2.43.0=0A=

