Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C024CEA3F28
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 09:14:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpjlx-0001k1-S9; Tue, 10 Feb 2026 04:11:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpjlv-0001aS-AS; Tue, 10 Feb 2026 04:11:03 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpjlt-0004mZ-5p; Tue, 10 Feb 2026 04:11:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kZbaLW4K8CR0aemLK+JIEKPhcwU1GCqH+s5v0y9d9qIlcjb9RtH2fb1ZAw9xgyy3yWFUW3GW1masP3Rxz3ThX3SGVIpYXJjnBfDegSkHy6wQ5vSnZuZYU5aSXP38UJx2yf6cnARUpwxNPTvgLJMS1A07B6ssT6gk9iY5K5YHCHHZ0zRMY5zBqBuIrgKtXEjWAsK01PgDj638wRg52tLjsCAtRqtBGqdBmOhU6RlinJpYMZIfkOlo6RISqJwhSbtgzGCPFw0rqWspjPxmyo1mRQaRQz2JwXQxuP/Wfe26kZ0dIxauQ1wd1Z+0dwoCOebAjLPZSjdYXvA+UUH9XF+v2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1TwHv/7KzfQ9FX9uU6wHs4J3dlaJJwwRwPKB8I479Jo=;
 b=SGhDvRRo1ZiPO58X2kkELqPM39b+ZY6L+EaFVIwSC9dZNRTQ6CggpcP3NBFuK5bVjK63awE7Wol7v1+bE4ARrr4YD0uvhpcRD4+GTQ21pepA6cigZhJuaKd3krPnDN1xbcU0/rYMn0PwVvV2aIpY3THlpAdOlsYKGhD0xHT6yp6/xIMY8fkw2do8aTl1YoCsH3jGXBe30hT9285Riqaxn4N8sDFeHCcAwxF5ypY1DRx3l4xNSqFHvXM04kQ+3t6USMZdUr/6wjCYC96DdbZXKVit0Hrq8X3e7X1uN650ONPc3sff57eYKiNTY4aucmZ1U2kCWgeMrXLEVayH+X6H7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1TwHv/7KzfQ9FX9uU6wHs4J3dlaJJwwRwPKB8I479Jo=;
 b=GzRFkwNoZFpOZLXfJJgFQVHImdzaHCp0B4KF/xokCQfJR/n2/BCk46YiMuLdGsFW6UxaMxn2uF/kN4nQsIuDTtRO0ie+IwsPQCN2ahYkzz52TMrtIzeisTowLou1OElkpGey7KMXtwhdYIMz1iacqVKS2CdOuRIEW5uhOBJe0azWjcEM6JeKrDwxGynso4E1Qc2YLaIC3hWGKo3rjKFhwi0BOIur/BfE2I4SB6CvuRU59KoJbvTXz7k/S6i/CV7tC6nqlt6WQDnwF7FBLRjIa6NJTfP+bno4LHsqKFB0k11JagM44h1mOlYr3IrADyZfCJFPV+Ijr7WJ8Uh3V8Tlog==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KUZPR06MB8268.apcprd06.prod.outlook.com (2603:1096:d10:62::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 09:10:43 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 09:10:43 +0000
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
Subject: [PATCH v5 16/21] hw/i3c/dw-i3c: Add controller resets
Thread-Topic: [PATCH v5 16/21] hw/i3c/dw-i3c: Add controller resets
Thread-Index: AQHcmm0iOoO98wBrVkm7uZ9FFOaTuw==
Date: Tue, 10 Feb 2026 09:10:43 +0000
Message-ID: <20260210091018.1553489-17-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: c1db6e2b-ebad-46c5-1642-08de688444fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?CUgj00jLjufNU66xjo34Rl75lomGFTKnQKGo0OXyxPskg2Omh03xtqB+Hz?=
 =?iso-8859-1?Q?VAqS7Et0+jEhkKdSJ9C7ZpdkZNsUgp8MLBOEMeJiZu3DL0Gs3dQiPqIv5Z?=
 =?iso-8859-1?Q?X6CQStcreMwrSl8uQxjzuiygTOycswdwrBek/2MK4uRBLgjLHxMRFqjy+X?=
 =?iso-8859-1?Q?2qM3+mLFuTdOXSdJ6VS6q+nTESnrYBMpwqrpYnaNW7NRp/eSfbGA1yb6vw?=
 =?iso-8859-1?Q?pagPlpnuwVf6mdCf5szCHZl0qfoGtWO/SjlYYtXD/eJrZKiNDsPYqqakaU?=
 =?iso-8859-1?Q?4+2uxs9eWeRw9cx+HoE73M2gKX8SRRQz6Evmj1iRv7dah7WBInETf23qhE?=
 =?iso-8859-1?Q?02mizYashdpR/E+1mjT7PKUClUXkqGot1ua2ii9BqDn8IJh5Msz5OGIeyA?=
 =?iso-8859-1?Q?thFSHqqPralrKWnHnW8Nw0EvCd2MfPzoDYec4huVPRHtABriXOpm+gKRlx?=
 =?iso-8859-1?Q?alFTeH1QIVrLGWzCbc5snKejp27MXvIsxL+Nv0Ea6Asd8rj48PWMBkWULO?=
 =?iso-8859-1?Q?FqEYmQIq3Az45WX+zbndopj8mRMrmkYjnL8ULGbVOdIivGXNjOb38xaTln?=
 =?iso-8859-1?Q?Uewiv0yKmoWMKY0UO48ZhL+hQCi/ebpcEHHuAF+ZKccoQlCi5q25Ms8rov?=
 =?iso-8859-1?Q?y5qt9wALKcd6OMPSwecp5QE3pU/Ptjkb4SM4HXAuYHIbRICxfylAUpqLm9?=
 =?iso-8859-1?Q?xRE44Q8+V9GvERHsP8cb2wbit3kA3oCTZj3YB7eKsS8uBN6eV/GfCrKyPO?=
 =?iso-8859-1?Q?nUWVFXz/R4NaRzKLAPejiMXr9G9boXoXZbq7RKBVWvCKddJgwSFaXcXoY4?=
 =?iso-8859-1?Q?JWi8zlDa6i+DFJ+YkwxFij8VjNCsTI1jMJwgwcNW739235+oazeLVgdagI?=
 =?iso-8859-1?Q?DffpBbxM+xDfv8+zyKA6PPB0qSTAUoxNsdduPPItOIwypeAcPhtJpNW1H3?=
 =?iso-8859-1?Q?Qn0JpTb18Ht0XPfh2A2xHij/hRibZY4sK/t4LRSVZb9uOla9csi4/FI6o/?=
 =?iso-8859-1?Q?viAcFhXEdikOYnajGkdVq1kLCwcpjBCWAm7ySUwtRvhCxg1uJZZsgABdhK?=
 =?iso-8859-1?Q?LiBD9Oe4IFT8Y2e88232J9w/OxnCuTZpVqZVEib2fmoYuDNBD1n6BSN+hk?=
 =?iso-8859-1?Q?nLavcYBtWvQTJ8ahHusGCNq3ptLGVbuZ2gyzWu960+pa686QQxYaUYmlm5?=
 =?iso-8859-1?Q?VIum5MG0/FSn+Mvu1ng6bSR8zo10TWqLk+vXkiVpRA1jt60o6DaQGBg9fK?=
 =?iso-8859-1?Q?dsd0dmRg2v95RdEom8Tg0w0pcmcszN72Q5P2kjwtNsAzem+l4Hly+m3VsX?=
 =?iso-8859-1?Q?zURuOD7p8eOjdVEH69ki+PH4ns6O6n95w2KUa6pSE92XhKYPVGQ/DRiXDQ?=
 =?iso-8859-1?Q?khqT2bN0wf7dwkV1pfdiSm4NKYOIuI58NaoxWDNmDs7NGgXptprCiDhImh?=
 =?iso-8859-1?Q?lub7JJ0Wzufhz6lnVoT+0AO0FzCu7asbj3dsKL/9GMMuRekx3LQH49wSY6?=
 =?iso-8859-1?Q?7waqs6qfDqOJhOsubLpn5yAJHRExcvLU4zEDocF+EilWUn/+J/2T6zaJBF?=
 =?iso-8859-1?Q?TNqvfuWom5OOSNyu5DfxzObR1WYAUp992BsRVm5I8RazTZ4EGWHyF9VvX4?=
 =?iso-8859-1?Q?4Xpa3ghvi0aC6JHKVki88ykec0lLc3XXezwqUgCamrfkPjszPdsg7JWerd?=
 =?iso-8859-1?Q?oL4xtFOLvfJzfXJytXojmMfM0Kurt8BD/SlP7CO8?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1Zf3geNA/lCnu2ORBQ6OzV+xXj0dsaAheWlCuKKJ7fJ32qP751xPnKqW7q?=
 =?iso-8859-1?Q?gyyTYK7mNNl93DjZw+wH0M6zERh/jUg+6yGqFhW81ODwssrhCUlWzKAM+5?=
 =?iso-8859-1?Q?hujOqw1XLvihszyAgDnmG5kj9q7jQql5A4Hho01Sj414EeMifvu6LVDxyV?=
 =?iso-8859-1?Q?2FjnUABllrFwPKlIbudVrhWLDvSq//z8Wfviw+spoEH/mo97N6pjFFaN4a?=
 =?iso-8859-1?Q?NA0LRhOfXGfCnc6/gxEKq11ByhjWfXQYjS/JyR6F2Kzq2h/HEJ5R0eCTro?=
 =?iso-8859-1?Q?eDNjCAOFSgsJJ9xEuRAfVjDbNW7L8KSvL4JKyhuuf/EEU0Pz1XnLULG6A3?=
 =?iso-8859-1?Q?mv0ih1aLDkrQIIMJINeS9XSvxFSsI4KaPbrbJnSEVAvsNFkXyrnfSXZINl?=
 =?iso-8859-1?Q?DZEVfcoILS3VAWgA9YEyr4FzYwSYx/K2o+lc0vccBV51SFcA83bV/EoscA?=
 =?iso-8859-1?Q?KazurIG7BrOseOFwSm1TrdOb+LcHQAuUpGk3zFX1+sgUzluR12ThtXF42l?=
 =?iso-8859-1?Q?TyWMaCzgAH1WoIgIBSFIbvJp3nMlW7alMwx9ELXxJoS5MQMQJvvwB3Z9S9?=
 =?iso-8859-1?Q?tRdDKt0GwrM9CxYJ66rQGwMjEm6ew6MauSHwhIwOhbaHygqTdG371GfaBF?=
 =?iso-8859-1?Q?KBUCr/PghtyhuaB7WE22WCfNQQZxWj35hYO5CxhV3HSu4U+9d/P/RgE7ZS?=
 =?iso-8859-1?Q?aL/AzCoZd0S75EIFxYLJYmiqmYPIFVM9QGhoV9UaT9Yx44JEYJMua+rwW/?=
 =?iso-8859-1?Q?hJICq2DFhaRU8urOS3eOEHvtRdcI5B1VhfJrj/7SDoQQCo1uf8HbUb5r6D?=
 =?iso-8859-1?Q?q8AntddjbvYpxpK/A8gKJ0rkr9qEIN/vpPSD0FKjTTr0NfMyr2Gqg4vySK?=
 =?iso-8859-1?Q?Fqc8QQMRpArJqBPVOajIaGfSZWz8gbUzmkqJuJlxmDou9+9pX5cWdCjI5c?=
 =?iso-8859-1?Q?uqgiUt1S3zlCjPJ5a0Kc7jw4Ke4Ts7C8e9Inw6ci88jOD4llJZySRmfLQY?=
 =?iso-8859-1?Q?CKWqqU7ik0sRrQEYcrpNXyUqboF6nSUEd67DHfDstEZVv6b41UtRHrVVGB?=
 =?iso-8859-1?Q?j5Ik2txCmtDXQ7kpZ423YwEO4pKwQNDB0XW5wVnn8spC6Dd+Oq68iiAYT3?=
 =?iso-8859-1?Q?8xu5AE6Nw2b/QCXrQJulfK9w7KwoHzk3ViEgQKEl0tnCvu8enEP4MLr6/K?=
 =?iso-8859-1?Q?y55cfyMdJzSFuIEk5//U4WupPU84lzX8tDhB9F/Hn3uSQRDXQU4IZxn64Q?=
 =?iso-8859-1?Q?eM8SVfLNk8UetoM0yJE/YSsTER8I+EAzlTCEFSXh3OFMHgcrTVUt0Sc1BF?=
 =?iso-8859-1?Q?adLVKiiPgebp5yZ/iwnn8RVkwgDB8ZsHXy6J7s2kbvz9R672sv3wobirCY?=
 =?iso-8859-1?Q?u7f7MyLwIrkuSL9qU8s3jPvoDMlIuohrlhPnjW7HW+nIWm1FcE2QAYB0PJ?=
 =?iso-8859-1?Q?QQBCri7NIPVKuHK955Uzvza2KCsT16WLlvkw7nL6tV+kJEPK/n2qbhyAeO?=
 =?iso-8859-1?Q?vDWX8Ghc0fkGf+n7JDnE028sdUxpigOuWddMWcO8AJVcPpVN4P9BJr124A?=
 =?iso-8859-1?Q?FtbcYGF3BElT2FdRg8ZvDNC7qWZugxM6vjuMp2QqCvEaUrLw6Pg7iO+X9v?=
 =?iso-8859-1?Q?b9hes61QBOw71WPb0WLZfxDtLsyAuLjNe3ktDULrBdqg7GL8BxlyHGsPmn?=
 =?iso-8859-1?Q?4/ve5DT4TwgqTEZwzIs/Gtm/crdESiE4VZRN5X/8yT271Tb3XlHInbrvQv?=
 =?iso-8859-1?Q?TXWTnmYAE0MtrA6KySMWNqTcRs8QX++gMtlzZW+//QmuFcOMJgo2jNx47g?=
 =?iso-8859-1?Q?UX6MFB2vsw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1db6e2b-ebad-46c5-1642-08de688444fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 09:10:43.4878 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v2WqW65NcRtCFQ+MfsukyeD50rEnmK4WtBtYaJxSDsyOiqlhe4Qa3O1iEZfEVKBdAu3LTVIPnbVemXs9wuNJEhsn20L06bzG0VDIf0SVo+M=
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
index b6ec0d9579..d742458129 100644=0A=
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

