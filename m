Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B4B8EA3F28
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 09:13:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpjlr-0001Pv-Q0; Tue, 10 Feb 2026 04:10:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpjle-00018H-0h; Tue, 10 Feb 2026 04:10:46 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpjlZ-0004jF-DO; Tue, 10 Feb 2026 04:10:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f3l84nMMAuZdS6T4hkXOJSqEXowvJmCFZGylF7jd8GaeFeohMPJUXZSur99T3Sj+McTdhc3vtsxCx4MDTSNvUtlzvt/FqZ1mFhY5EO/5f+NAbvB+J9vCSpbOEmeMTRJ8bPmbD8VXz8sscL4ZfiYf+OlZ1mXu7s5MhHBW1I+f9Gn5UdQOikpDEKDyZKlpBwT6SLExhcLM+cgwV1/VeaOU5vzB3PTdHuxUUXOOuPXNaitvk5ahBNIl+LbSz5Exuqb6kdBW146D4kGwuZfRFNMlWsXLFv9G96mlhw7HTklp+1SkXKQIUwcuPw/x2iC4/TGQDsOy9a08Nrw4LCAT/LkfDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0AfGtPMk2GdcOR/dNWkYdXVyFTbKcXQekwWg2uyyeg0=;
 b=eh9kV3CAQwSstMdOOsufOZjD1u5Ha7Nu4e+RBk3VcKOnawvmKVlcgYel2yNCv+zoaOxBAC4KlYfhrT39NfFLhriUmxU6lTvob0yiZQE1fw6i9BNU40a6/JIfU39YUw6fdh8eSjJ+86lE5rNttoC+Q4snGPQx5inPzEeujPnFxuIN4QUQVobw3Z6LlvJTrPZ0eMTiCTlQt0Sd0mKHenxPhBPVAofMROwtt2I29Mb6jYzk7xhsmF4fvJNT/tIpng8Su3IRXPQKl+jTQxKDH8K5DR8kcdiVJ9ISgT2sSgNKWPZqLIOlm76W0JRrvtZ78YEaHsDnR4WuhEKYrMtA0Lb2cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0AfGtPMk2GdcOR/dNWkYdXVyFTbKcXQekwWg2uyyeg0=;
 b=ceiHdL84dN9UVMsX8hAaSz+m4XvDy40s65XgAfzgfutFNf1W7c8EyG5Kg7xa/KeLqIMRbZCK8rB03dS31GxdIcIa7ERWND1RPmpp5qAFKZRQ/Z8WCAYODfKtYZWAQso9wh3eN9GBLd8SEelEPAoE+bKAgWnxUyR9Pmg8t84i2Jp9fJCMID/5g96Vn8gozdIXAodRY3PyT7r8D+uRnY7bgf2YKR3CzVal5wnfqQR2LJ0nIrwTiZ/Ak7MSQd3n4PrJqXRyTJX8nYrQrKgvTXLqEr3hiO3gcHQeUdqKFpzdEb8xBSmJ5/Uwd2myiwc+e0cGGgtWfzENNB2WXqiTHHJ2sQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KUZPR06MB8268.apcprd06.prod.outlook.com (2603:1096:d10:62::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 09:10:27 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 09:10:27 +0000
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
Subject: [PATCH v5 05/21] hw/i3c/dw-i3c: Add more register fields
Thread-Topic: [PATCH v5 05/21] hw/i3c/dw-i3c: Add more register fields
Thread-Index: AQHcmm0YgPZlS9q25EqHG1SjEZnJsg==
Date: Tue, 10 Feb 2026 09:10:27 +0000
Message-ID: <20260210091018.1553489-6-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: a54b8fad-b85a-424e-2509-08de68843b4f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?f6Ea3cjvYo4fqAfpJ5NuTGnqGuGv0E7TmEWmX2AjkipWh++jEXQ0PqL1gm?=
 =?iso-8859-1?Q?GMsJATRoYSYEBWMMiT6PwSh/2NhmCLxMzquxVpNEgBrQ6ThGhwF7/3IFmN?=
 =?iso-8859-1?Q?gJFroVVsCVSvaGm3DPC878NxCFcHXmYZ9BUTFRkOG9GKKK0spL5UerbJBb?=
 =?iso-8859-1?Q?i1ItdQQB3ELDR2pNR2wBVRxtmeDeA/KusuJ2FBKY3DHG5rDThBZopJooCn?=
 =?iso-8859-1?Q?Veqs4LHJkglNBdSn2D3TSTXDQTWHc0e6KjKQav3sUjNV3DO6nSsAnegB2v?=
 =?iso-8859-1?Q?wsFhmsKeJvB8x5jrujgt0s/pyqqInCzKNFbQy1+gpk/66sBWHFd6fdx8kU?=
 =?iso-8859-1?Q?kLkdyDRQpGfR2ILb9ZhBKxzE4m7jtUmgp5cBwlo4E2O2jkui4YCyaOTJ+M?=
 =?iso-8859-1?Q?NUhXOlkItb1f0fSuD9xQ7vrVXPtiH4Z91xIg2JKGB82XO7q7dXUVT9T/Qn?=
 =?iso-8859-1?Q?694kxNKckJ9OLNp1pgPRPKqS9xNiGHJOV3XOSVeTI7qa6LlZlFZDruRVGY?=
 =?iso-8859-1?Q?ydsFKt6P3i0nf9EeaAalLnDU8rq002VjnKJ4A8Jmit0tXUu5Y2qnEg5Aog?=
 =?iso-8859-1?Q?lbQEfboFUf3MC3NFr16GCkn2qUu9HSsUKC5GsKhbDu/nvaaCLCJZMDwl87?=
 =?iso-8859-1?Q?ikiuFCr2NRtxzZl5CMBKLIp0OST5qE2m2keWwX9VArPfTmzZxN88hRFMWZ?=
 =?iso-8859-1?Q?uSMerqA7Ri5obp/QQcd8PuEQ4coFMP075dertEwwXnvMwhVWenkglLGHtD?=
 =?iso-8859-1?Q?ZWAdgGt9ElJZBTJt7Z2Nxvcz+Dklg3B20G3RWqJMwF2+xqM9jMourRTbgm?=
 =?iso-8859-1?Q?NwPdp6r+ogATHpdn7V9SK/LHb6TvEOrNHrvqHVdyEPxVgscCmmUGQcgGF1?=
 =?iso-8859-1?Q?h7iYTR9GaJSkbJhfoYDotMTx/WJyp+yd1SULm/02Hzxcp0lRI7am2EEbfi?=
 =?iso-8859-1?Q?arvHkUf5ESsh+22pJE2HIprkdg7p12VfNa/6ghoHiYeK+L/ZpLZTi117gE?=
 =?iso-8859-1?Q?ZgOB8i1GeRLuKcPpU4GyCuoUxCFEFEdg/iJOsfw13hGh0PfyncUAok0QFI?=
 =?iso-8859-1?Q?5DYoONAE/QaJug25N0EV7bxy5UNOGoHpTw+OBfucZhhG2DWGjDYw+d7WO+?=
 =?iso-8859-1?Q?0lH7G9TFiBHoL3cGi+crYuCyI9llzCUAGr7MIIOXEEaV7IGwSlDSnX+TT1?=
 =?iso-8859-1?Q?Fcq6lKlgDPdJSLcxt1ZbJ8m3pBE8kqHE5yLixqc6dn0hZCWDVDxu964gII?=
 =?iso-8859-1?Q?rjbSzApRdosrCy/OKivC8IZrHVtAwmWHjsnJgAQFZOzvcAYpx+dMPheUyK?=
 =?iso-8859-1?Q?rO2lEvVc15G2faauSCugPNzKH/8LkrQ+otYiKvZpgYQJYV0W+1hc099L9J?=
 =?iso-8859-1?Q?oF7ezVMIGJCUwXqthOL+bQz1LT+SF/TOgp506iX206ynPZWEuvCfgkh0Iw?=
 =?iso-8859-1?Q?g9C6Q3YAjLvk7GNkNdFWFxxR7SS8QaLK/OV/g7hsu7OTmBODh+fNmxAIFE?=
 =?iso-8859-1?Q?C9zDxRVxYQol9o/4OF7I5RQ5qQLCyDmgsrul3XVV9Dz8ZhV1p7kNcG+FQZ?=
 =?iso-8859-1?Q?IhRgCatsTCLMdGqlVaAlnuUobyB5wi29yv7O6sj8+F5zCrJSlmK7aIOUcN?=
 =?iso-8859-1?Q?GH1IJKPC2LZCoE9eJEv9yLl/m5kV1W0WxhS7VYB4tzsVCzBWslpXfzMTZs?=
 =?iso-8859-1?Q?8QB7ToXy9kjPA8fmaYbhs3QjmLARp1hRyaefVlpV?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?MsyMDt7yOphnuicuYME5M06iMLwFdyVUgG8cGKNiHh3NJvC0x/yMlRvnXy?=
 =?iso-8859-1?Q?2aNwxIP7IqVCqdl/qS9VNn8dgprYpGqM8lGZsLWO/ieUnKfR68OnhFDeXo?=
 =?iso-8859-1?Q?D4QjuSKN20UCsIb+sgQIUrK50U+0P5YN1HkYYZQLUagfRuxs2bS1c37ZY+?=
 =?iso-8859-1?Q?ruENiX68OJTu/0F7H8ebLack8CXcj9QOiW5U7YbZ0PgdDY/IZUY36OABZq?=
 =?iso-8859-1?Q?FCn8J1yicNKV690EOMYX/CVqMcLxubkgHqmHfAk9Vp4pXmLo3C8w/LSNRI?=
 =?iso-8859-1?Q?EkCb+Wv+JQdzDbqTFCDPydtzxsJGc88Ve0XPgOsOVVERBPm8gZzVJ/ucJ6?=
 =?iso-8859-1?Q?+whtTK01VZaCXXiMensHSA5suU6RjDWOIPHdk2w+adpv2alyt0HfJEQ+Av?=
 =?iso-8859-1?Q?qp5QuG1JBxAm/MWNroHfhHBXl5VXtEPBZ0zj2CLKUwCuBynF69dtpNyvWB?=
 =?iso-8859-1?Q?vhlDZVXoga+8mcUkrYdWpZBWVH52XOKcveQfF7dbjBWJxtyRNQHUyH1gi3?=
 =?iso-8859-1?Q?XAbmvBCVFg4OSYxGGIugswQdPIV5X2+QKuFeHj1AjGS4KZWFgn8rze2BB8?=
 =?iso-8859-1?Q?rNeFyKHi2WESbZB9R/DXS6uHzGjsmg1hHKmSs5o4H3AZ8WHbjKdfvrX96Z?=
 =?iso-8859-1?Q?zLPrYQ1cne33GOHb4+8sujpNlP4SMZjhgE5xTZQZ6dEB48AC49+1H6BUdi?=
 =?iso-8859-1?Q?FPNlCjHrIo2QvArOdm6WWgcpQpZY+scwDQdZcdook9KRwiHwSKd5aCi40F?=
 =?iso-8859-1?Q?yucBdBTEERymcGQ17GzDi3A5+C9enqZgLnmhMbgjmnOkSc4Yt0F4hsHxWa?=
 =?iso-8859-1?Q?f1sYzIn3QZ16Cw2js3554BxWSRn/aAgQzub8k5AwQ3NC2Wp22tdLpwyT6a?=
 =?iso-8859-1?Q?Q0IvumYKsz0FO2lfROO6caL2oy160Sd8IFjA9pK2OiCc8yZfBPblsP4NLF?=
 =?iso-8859-1?Q?4gMjauIgbb6CieKVLvZw7hzaTz70cAYEQ1TJIaHmQQuPHGFSONG0WiAliT?=
 =?iso-8859-1?Q?U41EPQNJxhYU2GdGvD/Syisq5peM/8DbpC5vy9+425VKUuubt2pS9dvtgL?=
 =?iso-8859-1?Q?9t6KmWWWHyhBYepSJPNXy1lHzraUZ/P02GbaXfzCyg3/nI3+gJqY4YDRET?=
 =?iso-8859-1?Q?LRvEtWxnZHN9IRsRvHvrgTAGgWj/Gs47ql0EEGHI/nUt1bURzSWq5An+rg?=
 =?iso-8859-1?Q?lYQLTiufHKOa+g+l12MAWKPJJC9qowMwZJ+/wZ5ktkBCj878N/jhp4tPln?=
 =?iso-8859-1?Q?7rsKQmbasRmql+s/abmnxhNHAiruTqZbAdjZvq94X0dQimwYTq/QwPTYcy?=
 =?iso-8859-1?Q?BS4odmGWOgwR61EV60/BQiYQh3/uYIZtdOIsHgPfhl1Ob/jvSAER+ZOBxn?=
 =?iso-8859-1?Q?Fci3azY7d25ztFabi5UCRFV6obINVb9g5fLJn4TH/TWHid0HTie04JmuaN?=
 =?iso-8859-1?Q?HO2d56R74kc9nOu4ap3BUNzuVbg6xazb9SanWZ2W8M5Tp/fTB7amQIXK62?=
 =?iso-8859-1?Q?g4fyMTMqho+g60qci79eHqSmSuj69SpBZl5ncRBFTz2tRs/ZTL+NwFz4rd?=
 =?iso-8859-1?Q?HQmvtR1ApuP2peHfEcVHSKDSHh44Bo4e/5jP7JiYNl87kdTG0JkjxjD95L?=
 =?iso-8859-1?Q?efvqoM6KXQbgM24Z1nZCFx+uWBKU9+UxCobFG8CWRdaQDktYcxkvSM4g2x?=
 =?iso-8859-1?Q?m7KECwbQiuNLROq9KNScHsTOnG9bNPnOGbwoyPbQ9hDxx/i2jTBMVVg7V0?=
 =?iso-8859-1?Q?mdvLycPMENlu/DF/Z3oXHRnMeoZJlhuAu+zZJTagrm1GXQZxax5ytWzgLg?=
 =?iso-8859-1?Q?laL6ilHspg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a54b8fad-b85a-424e-2509-08de68843b4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 09:10:27.2736 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VaDWyhLe08o4k1XxuJmJ1SWa4bW++AyVKIl51QdrIgfj9Lme2XBwsWKy2A6XwFZ9Tt181h4pqkIj15V5lIKS7yWu5rbVVEpjAP0+0AC8pgA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR06MB8268
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UPPERCASE_75_100=0.001 autolearn=no autolearn_force=no
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

Adds the rest of the Designware register fields.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/i3c/dw-i3c.c | 199 ++++++++++++++++++++++++++++++++++++++++++++++++=0A=
 1 file changed, 199 insertions(+)=0A=
=0A=
diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c=0A=
index 6cadc59191..48dde008de 100644=0A=
--- a/hw/i3c/dw-i3c.c=0A=
+++ b/hw/i3c/dw-i3c.c=0A=
@@ -19,54 +19,253 @@=0A=
 #include "trace.h"=0A=
 =0A=
 REG32(DEVICE_CTRL,                  0x00)=0A=
+    FIELD(DEVICE_CTRL, I3C_BROADCAST_ADDR_INC,    0, 1)=0A=
+    FIELD(DEVICE_CTRL, I2C_SLAVE_PRESENT,         7, 1)=0A=
+    FIELD(DEVICE_CTRL, HOT_JOIN_ACK_NACK_CTRL,    8, 1)=0A=
+    FIELD(DEVICE_CTRL, IDLE_CNT_MULTIPLIER,       24, 2)=0A=
+    FIELD(DEVICE_CTRL, SLV_ADAPT_TO_I2C_I3C_MODE, 27, 1)=0A=
+    FIELD(DEVICE_CTRL, DMA_HANDSHAKE_EN,          28, 1)=0A=
+    FIELD(DEVICE_CTRL, I3C_ABORT,                 29, 1)=0A=
+    FIELD(DEVICE_CTRL, I3C_RESUME,                30, 1)=0A=
+    FIELD(DEVICE_CTRL, I3C_EN,                    31, 1)=0A=
 REG32(DEVICE_ADDR,                  0x04)=0A=
+    FIELD(DEVICE_ADDR, STATIC_ADDR,         0, 7)=0A=
+    FIELD(DEVICE_ADDR, STATIC_ADDR_VALID,   15, 1)=0A=
+    FIELD(DEVICE_ADDR, DYNAMIC_ADDR,        16, 7)=0A=
+    FIELD(DEVICE_ADDR, DYNAMIC_ADDR_VALID,  31, 1)=0A=
 REG32(HW_CAPABILITY,                0x08)=0A=
+    FIELD(HW_CAPABILITY, DEVICE_ROLE_CONFIG,  0, 3)=0A=
+    FIELD(HW_CAPABILITY, HDR_DDR, 3, 1)=0A=
+    FIELD(HW_CAPABILITY, HDR_TS,  4, 1)=0A=
 REG32(COMMAND_QUEUE_PORT,           0x0c)=0A=
+    FIELD(COMMAND_QUEUE_PORT, CMD_ATTR, 0, 3)=0A=
+    /* Transfer command structure */=0A=
+    FIELD(COMMAND_QUEUE_PORT, TID, 3, 4)=0A=
+    FIELD(COMMAND_QUEUE_PORT, CMD, 7, 8)=0A=
+    FIELD(COMMAND_QUEUE_PORT, CP, 15, 1)=0A=
+    FIELD(COMMAND_QUEUE_PORT, DEV_INDEX, 16, 5)=0A=
+    FIELD(COMMAND_QUEUE_PORT, SPEED, 21, 3)=0A=
+    FIELD(COMMAND_QUEUE_PORT, ROC, 26, 1)=0A=
+    FIELD(COMMAND_QUEUE_PORT, SDAP, 27, 1)=0A=
+    FIELD(COMMAND_QUEUE_PORT, RNW, 28, 1)=0A=
+    FIELD(COMMAND_QUEUE_PORT, TOC, 30, 1)=0A=
+    FIELD(COMMAND_QUEUE_PORT, PEC, 31, 1)=0A=
+    /* Transfer argument data structure */=0A=
+    FIELD(COMMAND_QUEUE_PORT, DB, 8, 8)=0A=
+    FIELD(COMMAND_QUEUE_PORT, DL, 16, 16)=0A=
+    /* Short data argument data structure */=0A=
+    FIELD(COMMAND_QUEUE_PORT, BYTE_STRB, 3, 3)=0A=
+    FIELD(COMMAND_QUEUE_PORT, BYTE0, 8, 8)=0A=
+    FIELD(COMMAND_QUEUE_PORT, BYTE1, 16, 8)=0A=
+    FIELD(COMMAND_QUEUE_PORT, BYTE2, 24, 8)=0A=
+    /* Address assignment command structure */=0A=
+    /*=0A=
+     * bits 3..21 and 26..31 are the same as the transfer command structur=
e, or=0A=
+     * marked as reserved.=0A=
+     */=0A=
+    FIELD(COMMAND_QUEUE_PORT, DEV_COUNT, 21, 3)=0A=
 REG32(RESPONSE_QUEUE_PORT,          0x10)=0A=
+    FIELD(RESPONSE_QUEUE_PORT, DL, 0, 16)=0A=
+    FIELD(RESPONSE_QUEUE_PORT, CCCT, 16, 8)=0A=
+    FIELD(RESPONSE_QUEUE_PORT, TID, 24, 3)=0A=
+    FIELD(RESPONSE_QUEUE_PORT, ERR_STATUS, 28, 4)=0A=
 REG32(RX_TX_DATA_PORT,              0x14)=0A=
 REG32(IBI_QUEUE_STATUS,             0x18)=0A=
+    FIELD(IBI_QUEUE_STATUS, IBI_DATA_LEN,   0, 8)=0A=
+    FIELD(IBI_QUEUE_STATUS, IBI_ID,         8, 8)=0A=
+    FIELD(IBI_QUEUE_STATUS, LAST_STATUS,    24, 1)=0A=
+    FIELD(IBI_QUEUE_STATUS, ERROR,          30, 1)=0A=
+    FIELD(IBI_QUEUE_STATUS, IBI_STATUS,     31, 1)=0A=
 REG32(IBI_QUEUE_DATA,               0x18)=0A=
 REG32(QUEUE_THLD_CTRL,              0x1c)=0A=
+    FIELD(QUEUE_THLD_CTRL, CMD_BUF_EMPTY_THLD,  0, 8);=0A=
+    FIELD(QUEUE_THLD_CTRL, RESP_BUF_THLD, 8, 8);=0A=
+    FIELD(QUEUE_THLD_CTRL, IBI_DATA_THLD, 16, 5);=0A=
+    FIELD(QUEUE_THLD_CTRL, IBI_STATUS_THLD,     24, 8);=0A=
 REG32(DATA_BUFFER_THLD_CTRL,        0x20)=0A=
+    FIELD(DATA_BUFFER_THLD_CTRL, TX_BUF_THLD,   0, 3)=0A=
+    FIELD(DATA_BUFFER_THLD_CTRL, RX_BUF_THLD,   8, 3)=0A=
+    FIELD(DATA_BUFFER_THLD_CTRL, TX_START_THLD, 16, 3)=0A=
+    FIELD(DATA_BUFFER_THLD_CTRL, RX_START_THLD, 24, 3)=0A=
 REG32(IBI_QUEUE_CTRL,               0x24)=0A=
+    FIELD(IBI_QUEUE_CTRL, NOTIFY_REJECTED_HOT_JOIN,   0, 1)=0A=
+    FIELD(IBI_QUEUE_CTRL, NOTIFY_REJECTED_MASTER_REQ, 1, 1)=0A=
+    FIELD(IBI_QUEUE_CTRL, NOTIFY_REJECTED_SLAVE_IRQ,  3, 1)=0A=
 REG32(IBI_MR_REQ_REJECT,            0x2c)=0A=
 REG32(IBI_SIR_REQ_REJECT,           0x30)=0A=
 REG32(RESET_CTRL,                   0x34)=0A=
+    FIELD(RESET_CTRL, CORE_RESET,       0, 1)=0A=
+    FIELD(RESET_CTRL, CMD_QUEUE_RESET,  1, 1)=0A=
+    FIELD(RESET_CTRL, RESP_QUEUE_RESET, 2, 1)=0A=
+    FIELD(RESET_CTRL, TX_BUF_RESET,     3, 1)=0A=
+    FIELD(RESET_CTRL, RX_BUF_RESET,     4, 1)=0A=
+    FIELD(RESET_CTRL, IBI_QUEUE_RESET,  5, 1)=0A=
 REG32(SLV_EVENT_CTRL,               0x38)=0A=
+    FIELD(SLV_EVENT_CTRL, SLV_INTERRUPT,      0, 1)=0A=
+    FIELD(SLV_EVENT_CTRL, MASTER_INTERRUPT,   1, 1)=0A=
+    FIELD(SLV_EVENT_CTRL, HOT_JOIN_INTERRUPT, 3, 1)=0A=
+    FIELD(SLV_EVENT_CTRL, ACTIVITY_STATE,     4, 2)=0A=
+    FIELD(SLV_EVENT_CTRL, MRL_UPDATED,        6, 1)=0A=
+    FIELD(SLV_EVENT_CTRL, MWL_UPDATED,        7, 1)=0A=
 REG32(INTR_STATUS,                  0x3c)=0A=
+    FIELD(INTR_STATUS, TX_THLD,           0, 1)=0A=
+    FIELD(INTR_STATUS, RX_THLD,           1, 1)=0A=
+    FIELD(INTR_STATUS, IBI_THLD,          2, 1)=0A=
+    FIELD(INTR_STATUS, CMD_QUEUE_RDY,     3, 1)=0A=
+    FIELD(INTR_STATUS, RESP_RDY,          4, 1)=0A=
+    FIELD(INTR_STATUS, TRANSFER_ABORT,    5, 1)=0A=
+    FIELD(INTR_STATUS, CCC_UPDATED,       6, 1)=0A=
+    FIELD(INTR_STATUS, DYN_ADDR_ASSGN,    8, 1)=0A=
+    FIELD(INTR_STATUS, TRANSFER_ERR,      9, 1)=0A=
+    FIELD(INTR_STATUS, DEFSLV,            10, 1)=0A=
+    FIELD(INTR_STATUS, READ_REQ_RECV,     11, 1)=0A=
+    FIELD(INTR_STATUS, IBI_UPDATED,       12, 1)=0A=
+    FIELD(INTR_STATUS, BUSOWNER_UPDATED,  13, 1)=0A=
 REG32(INTR_STATUS_EN,               0x40)=0A=
+    FIELD(INTR_STATUS_EN, TX_THLD,          0, 1)=0A=
+    FIELD(INTR_STATUS_EN, RX_THLD,          1, 1)=0A=
+    FIELD(INTR_STATUS_EN, IBI_THLD,         2, 1)=0A=
+    FIELD(INTR_STATUS_EN, CMD_QUEUE_RDY,    3, 1)=0A=
+    FIELD(INTR_STATUS_EN, RESP_RDY,         4, 1)=0A=
+    FIELD(INTR_STATUS_EN, TRANSFER_ABORT,   5, 1)=0A=
+    FIELD(INTR_STATUS_EN, CCC_UPDATED,      6, 1)=0A=
+    FIELD(INTR_STATUS_EN, DYN_ADDR_ASSGN,   8, 1)=0A=
+    FIELD(INTR_STATUS_EN, TRANSFER_ERR,     9, 1)=0A=
+    FIELD(INTR_STATUS_EN, DEFSLV,           10, 1)=0A=
+    FIELD(INTR_STATUS_EN, READ_REQ_RECV,    11, 1)=0A=
+    FIELD(INTR_STATUS_EN, IBI_UPDATED,      12, 1)=0A=
+    FIELD(INTR_STATUS_EN, BUSOWNER_UPDATED, 13, 1)=0A=
 REG32(INTR_SIGNAL_EN,               0x44)=0A=
+    FIELD(INTR_SIGNAL_EN, TX_THLD,          0, 1)=0A=
+    FIELD(INTR_SIGNAL_EN, RX_THLD,          1, 1)=0A=
+    FIELD(INTR_SIGNAL_EN, IBI_THLD,         2, 1)=0A=
+    FIELD(INTR_SIGNAL_EN, CMD_QUEUE_RDY,    3, 1)=0A=
+    FIELD(INTR_SIGNAL_EN, RESP_RDY,         4, 1)=0A=
+    FIELD(INTR_SIGNAL_EN, TRANSFER_ABORT,   5, 1)=0A=
+    FIELD(INTR_SIGNAL_EN, CCC_UPDATED,      6, 1)=0A=
+    FIELD(INTR_SIGNAL_EN, DYN_ADDR_ASSGN,   8, 1)=0A=
+    FIELD(INTR_SIGNAL_EN, TRANSFER_ERR,     9, 1)=0A=
+    FIELD(INTR_SIGNAL_EN, DEFSLV,           10, 1)=0A=
+    FIELD(INTR_SIGNAL_EN, READ_REQ_RECV,    11, 1)=0A=
+    FIELD(INTR_SIGNAL_EN, IBI_UPDATED,      12, 1)=0A=
+    FIELD(INTR_SIGNAL_EN, BUSOWNER_UPDATED, 13, 1)=0A=
 REG32(INTR_FORCE,                   0x48)=0A=
+    FIELD(INTR_FORCE, TX_THLD,          0, 1)=0A=
+    FIELD(INTR_FORCE, RX_THLD,          1, 1)=0A=
+    FIELD(INTR_FORCE, IBI_THLD,         2, 1)=0A=
+    FIELD(INTR_FORCE, CMD_QUEUE_RDY,    3, 1)=0A=
+    FIELD(INTR_FORCE, RESP_RDY,         4, 1)=0A=
+    FIELD(INTR_FORCE, TRANSFER_ABORT,   5, 1)=0A=
+    FIELD(INTR_FORCE, CCC_UPDATED,      6, 1)=0A=
+    FIELD(INTR_FORCE, DYN_ADDR_ASSGN,   8, 1)=0A=
+    FIELD(INTR_FORCE, TRANSFER_ERR,     9, 1)=0A=
+    FIELD(INTR_FORCE, DEFSLV,           10, 1)=0A=
+    FIELD(INTR_FORCE, READ_REQ_RECV,    11, 1)=0A=
+    FIELD(INTR_FORCE, IBI_UPDATED,      12, 1)=0A=
+    FIELD(INTR_FORCE, BUSOWNER_UPDATED, 13, 1)=0A=
 REG32(QUEUE_STATUS_LEVEL,           0x4c)=0A=
+    FIELD(QUEUE_STATUS_LEVEL, CMD_QUEUE_EMPTY_LOC,  0, 8)=0A=
+    FIELD(QUEUE_STATUS_LEVEL, RESP_BUF_BLR,         8, 8)=0A=
+    FIELD(QUEUE_STATUS_LEVEL, IBI_BUF_BLR,          16, 8)=0A=
+    FIELD(QUEUE_STATUS_LEVEL, IBI_STATUS_CNT,       24, 5)=0A=
 REG32(DATA_BUFFER_STATUS_LEVEL,     0x50)=0A=
+    FIELD(DATA_BUFFER_STATUS_LEVEL, TX_BUF_EMPTY_LOC, 0, 8)=0A=
+    FIELD(DATA_BUFFER_STATUS_LEVEL, RX_BUF_BLR,       16, 8)=0A=
 REG32(PRESENT_STATE,                0x54)=0A=
+    FIELD(PRESENT_STATE, SCL_LINE_SIGNAL_LEVEL, 0, 1)=0A=
+    FIELD(PRESENT_STATE, SDA_LINE_SIGNAL_LEVEL, 1, 1)=0A=
+    FIELD(PRESENT_STATE, CURRENT_MASTER,        2, 1)=0A=
+    FIELD(PRESENT_STATE, CM_TFR_STATUS,         8, 6)=0A=
+    FIELD(PRESENT_STATE, CM_TFR_ST_STATUS,      16, 6)=0A=
+    FIELD(PRESENT_STATE, CMD_TID,               24, 4)=0A=
 REG32(CCC_DEVICE_STATUS,            0x58)=0A=
+    FIELD(CCC_DEVICE_STATUS, PENDING_INTR,      0, 4)=0A=
+    FIELD(CCC_DEVICE_STATUS, PROTOCOL_ERR,      5, 1)=0A=
+    FIELD(CCC_DEVICE_STATUS, ACTIVITY_MODE,     6, 2)=0A=
+    FIELD(CCC_DEVICE_STATUS, UNDER_ERR,         8, 1)=0A=
+    FIELD(CCC_DEVICE_STATUS, SLV_BUSY,          9, 1)=0A=
+    FIELD(CCC_DEVICE_STATUS, OVERFLOW_ERR,      10, 1)=0A=
+    FIELD(CCC_DEVICE_STATUS, DATA_NOT_READY,    11, 1)=0A=
+    FIELD(CCC_DEVICE_STATUS, BUFFER_NOT_AVAIL,  12, 1)=0A=
 REG32(DEVICE_ADDR_TABLE_POINTER,    0x5c)=0A=
     FIELD(DEVICE_ADDR_TABLE_POINTER, DEPTH, 16, 16)=0A=
     FIELD(DEVICE_ADDR_TABLE_POINTER, ADDR,  0,  16)=0A=
 REG32(DEV_CHAR_TABLE_POINTER,       0x60)=0A=
+    FIELD(DEV_CHAR_TABLE_POINTER, P_DEV_CHAR_TABLE_START_ADDR,  0, 12)=0A=
+    FIELD(DEV_CHAR_TABLE_POINTER, DEV_CHAR_TABLE_DEPTH,         12, 7)=0A=
+    FIELD(DEV_CHAR_TABLE_POINTER, PRESENT_DEV_CHAR_TABLE_INDEX, 19, 3)=0A=
 REG32(VENDOR_SPECIFIC_REG_POINTER,  0x6c)=0A=
+    FIELD(VENDOR_SPECIFIC_REG_POINTER, P_VENDOR_REG_START_ADDR, 0, 16)=0A=
 REG32(SLV_MIPI_PID_VALUE,           0x70)=0A=
 REG32(SLV_PID_VALUE,                0x74)=0A=
+    FIELD(SLV_PID_VALUE, SLV_PID_DCR, 0, 12)=0A=
+    FIELD(SLV_PID_VALUE, SLV_INST_ID, 12, 4)=0A=
+    FIELD(SLV_PID_VALUE, SLV_PART_ID, 16, 16)=0A=
 REG32(SLV_CHAR_CTRL,                0x78)=0A=
+    FIELD(SLV_CHAR_CTRL, BCR,     0, 8)=0A=
+    FIELD(SLV_CHAR_CTRL, DCR,     8, 8)=0A=
+    FIELD(SLV_CHAR_CTRL, HDR_CAP, 16, 8)=0A=
 REG32(SLV_MAX_LEN,                  0x7c)=0A=
+    FIELD(SLV_MAX_LEN, MWL, 0, 16)=0A=
+    FIELD(SLV_MAX_LEN, MRL, 16, 16)=0A=
 REG32(MAX_READ_TURNAROUND,          0x80)=0A=
 REG32(MAX_DATA_SPEED,               0x84)=0A=
 REG32(SLV_DEBUG_STATUS,             0x88)=0A=
 REG32(SLV_INTR_REQ,                 0x8c)=0A=
+    FIELD(SLV_INTR_REQ, SIR,          0, 1)=0A=
+    FIELD(SLV_INTR_REQ, SIR_CTRL,     1, 2)=0A=
+    FIELD(SLV_INTR_REQ, MIR,          3, 1)=0A=
+    FIELD(SLV_INTR_REQ, TS,           4, 1)=0A=
+    FIELD(SLV_INTR_REQ, IBI_STS,      8, 2)=0A=
+REG32(SLV_TSX_SYMBL_TIMING,         0x90)=0A=
+    FIELD(SLV_TSX_SYMBL_TIMING, SLV_TSX_SYMBL_CNT, 0, 6)=0A=
 REG32(DEVICE_CTRL_EXTENDED,         0xb0)=0A=
+    FIELD(DEVICE_CTRL_EXTENDED, MODE, 0, 2)=0A=
+    FIELD(DEVICE_CTRL_EXTENDED, REQMST_ACK_CTRL, 3, 1)=0A=
 REG32(SCL_I3C_OD_TIMING,            0xb4)=0A=
+    FIELD(SCL_I3C_OD_TIMING, I3C_OD_LCNT, 0, 8)=0A=
+    FIELD(SCL_I3C_OD_TIMING, I3C_OD_HCNT, 16, 8)=0A=
 REG32(SCL_I3C_PP_TIMING,            0xb8)=0A=
+    FIELD(SCL_I3C_PP_TIMING, I3C_PP_LCNT, 0, 8)=0A=
+    FIELD(SCL_I3C_PP_TIMING, I3C_PP_HCNT, 16, 8)=0A=
 REG32(SCL_I2C_FM_TIMING,            0xbc)=0A=
 REG32(SCL_I2C_FMP_TIMING,           0xc0)=0A=
+    FIELD(SCL_I2C_FMP_TIMING, I2C_FMP_LCNT, 0, 16)=0A=
+    FIELD(SCL_I2C_FMP_TIMING, I2C_FMP_HCNT, 16, 8)=0A=
 REG32(SCL_EXT_LCNT_TIMING,          0xc8)=0A=
 REG32(SCL_EXT_TERMN_LCNT_TIMING,    0xcc)=0A=
 REG32(BUS_FREE_TIMING,              0xd4)=0A=
 REG32(BUS_IDLE_TIMING,              0xd8)=0A=
+    FIELD(BUS_IDLE_TIMING, BUS_IDLE_TIME, 0, 20)=0A=
 REG32(I3C_VER_ID,                   0xe0)=0A=
 REG32(I3C_VER_TYPE,                 0xe4)=0A=
 REG32(EXTENDED_CAPABILITY,          0xe8)=0A=
 REG32(SLAVE_CONFIG,                 0xec)=0A=
+/* Device characteristic table fields */=0A=
+REG32(DEVICE_CHARACTERISTIC_TABLE_LOC1, 0x200)=0A=
+REG32(DEVICE_CHARACTERISTIC_TABLE_LOC_SECONDARY, 0x200)=0A=
+    FIELD(DEVICE_CHARACTERISTIC_TABLE_LOC_SECONDARY, DYNAMIC_ADDR, 0, 8)=
=0A=
+    FIELD(DEVICE_CHARACTERISTIC_TABLE_LOC_SECONDARY, DCR, 8, 8)=0A=
+    FIELD(DEVICE_CHARACTERISTIC_TABLE_LOC_SECONDARY, BCR, 16, 8)=0A=
+    FIELD(DEVICE_CHARACTERISTIC_TABLE_LOC_SECONDARY, STATIC_ADDR, 24, 8)=
=0A=
+REG32(DEVICE_CHARACTERISTIC_TABLE_LOC2, 0x204)=0A=
+    FIELD(DEVICE_CHARACTERISTIC_TABLE_LOC2, MSB_PID, 0, 16)=0A=
+REG32(DEVICE_CHARACTERISTIC_TABLE_LOC3, 0x208)=0A=
+    FIELD(DEVICE_CHARACTERISTIC_TABLE_LOC3, DCR, 0, 8)=0A=
+    FIELD(DEVICE_CHARACTERISTIC_TABLE_LOC3, BCR, 8, 8)=0A=
+REG32(DEVICE_CHARACTERISTIC_TABLE_LOC4, 0x20c)=0A=
+    FIELD(DEVICE_CHARACTERISTIC_TABLE_LOC4, DEV_DYNAMIC_ADDR, 0, 8)=0A=
+/* Dev addr table fields */=0A=
+REG32(DEVICE_ADDR_TABLE_LOC1, 0x280)=0A=
+    FIELD(DEVICE_ADDR_TABLE_LOC1, DEV_STATIC_ADDR, 0, 7)=0A=
+    FIELD(DEVICE_ADDR_TABLE_LOC1, IBI_PEC_EN, 11, 1)=0A=
+    FIELD(DEVICE_ADDR_TABLE_LOC1, IBI_WITH_DATA, 12, 1)=0A=
+    FIELD(DEVICE_ADDR_TABLE_LOC1, SIR_REJECT, 13, 1)=0A=
+    FIELD(DEVICE_ADDR_TABLE_LOC1, MR_REJECT, 14, 1)=0A=
+    FIELD(DEVICE_ADDR_TABLE_LOC1, DEV_DYNAMIC_ADDR, 16, 8)=0A=
+    FIELD(DEVICE_ADDR_TABLE_LOC1, IBI_ADDR_MASK, 24, 2)=0A=
+    FIELD(DEVICE_ADDR_TABLE_LOC1, DEV_NACK_RETRY_CNT, 29, 2)=0A=
+    FIELD(DEVICE_ADDR_TABLE_LOC1, LEGACY_I2C_DEVICE, 31, 1)=0A=
 =0A=
 static const uint32_t dw_i3c_resets[DW_I3C_NR_REGS] =3D {=0A=
     [R_HW_CAPABILITY]               =3D 0x000e00bf,=0A=
-- =0A=
2.43.0=0A=

