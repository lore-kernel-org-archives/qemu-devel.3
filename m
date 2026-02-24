Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8005FEFB7F9
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 05:40:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vul6E-0001fc-6H; Tue, 24 Feb 2026 00:36:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vul6A-0001dj-M6; Tue, 24 Feb 2026 00:36:42 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vul68-0001H5-NV; Tue, 24 Feb 2026 00:36:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=De7r9P5lWJb1JhFEdhuUiLsknhW2ffaiz8cPaZy9FBg5uJaM1E4H1q/kWlWQb5CURZ5coLO7IdNhKhAQLcjIvlUQ0QoHM6FhQBJk5eS7/NjmfRLpwGU/3V/Os6NprjFs3EP5dNyNGwdDXPS9+CJ39yhX+eP92JeSIR7W039sAUPyVPEPRt/0rVFNzAYK49HpdY95BfAzsvSJJKm7PhzOz/oPD8et7HCH0c/kHAKxPrwN6v4QguwBwj+Yq5HYZtRinJJin4PbEVn6BnxEVhpFFKTR2KjQCObifFYBAXDHp9ebL9vkfC1razKRADsl+y72PeIxKMvCtHF+Ktxiq/6uWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4slh2/7DVLiijt1mqgRjyW7jmJblU3Fxmk6kklj0BfU=;
 b=qcAPelMaat+nFhuzbTk+gxCnqVuONDv3nR9dQ63CkPJKQlP9fYSmI32lyEPXdjm7iQrv4qEwh1f/E4Jll5IZC/S2wQMofSAQaYUgROt+wIF3bVdQib9I4tPXR1x+eX7oc/Z2sPiiAqPME7sd7NCqbkr6aA+veQffd7Au5xX/QV3TaCqqbpLbnAWUoXdkYHg6rFtZPkMmHKQfNK+XKpCsvD60i1FdReDD5rLoBbxpaiLEIS9sz6GD6BKpyClW+asUpUOBw7QIltoBbANRSvhtMSkSa7rcJ/8/OtVbsYTapZsHWIXwMEGrI+nWTruL0IAEpimqPHX2sJAtmHBcmmcWsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4slh2/7DVLiijt1mqgRjyW7jmJblU3Fxmk6kklj0BfU=;
 b=S4C0jChXbW2XBv6sYZBUeqzeUpKyFjkdH2xDqdi6sx0T09pidoRTaK/kMn4eUzRLkdRbfy2NzQGZ678pcERMaPgr+Te2GFzvJ/Eqee4CtODAReLif4IhDk7gJrF64IIW0IgvDVvEeol6xRtOpPhMMvJURcYGrsnQzUEjNTfrjAISeit+x0l5ZRfnQJRfHbneGYsDXii3L8s4GT7+SERKaAJOoNCAC1BVfA4phCKcqhs7TgHuewsplld8H8G+0cOhyfLoXzZOSEYeisUdNmDmphdZlvwXb+CBtTTKY23bz6QpqSCGx7K4KthZYZcVIlbMdsS62iQ0I6NqZVrYDsWPTA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB5179.apcprd06.prod.outlook.com (2603:1096:400:1f8::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 05:36:23 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 05:36:23 +0000
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
 <nabihestefan@google.com>, "komlodi@google.com" <komlodi@google.com>, Patrick
 Venture <venture@google.com>
Subject: [PATCH v6 06/22] hw/i3c/aspeed_i3c: Add more register fields
Thread-Topic: [PATCH v6 06/22] hw/i3c/aspeed_i3c: Add more register fields
Thread-Index: AQHcpU+DuADfjcJ+MEWnSCqNtposfw==
Date: Tue, 24 Feb 2026 05:36:23 +0000
Message-ID: <20260224053613.589102-7-jamin_lin@aspeedtech.com>
References: <20260224053613.589102-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260224053613.589102-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYZPR06MB5179:EE_
x-ms-office365-filtering-correlation-id: b6153d07-fd5f-458c-a628-08de7366a5bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?NnaM4daWDJrEGrNlrfCzn8Cj/GkDVTjs1dmRyRgUXsHcbeDR4lsVWgFrBI?=
 =?iso-8859-1?Q?ku2VNX3EO042sVYRsUjuKln+pjJArKmh7AKCamkbs/FgPRTiyi4u0VJ9up?=
 =?iso-8859-1?Q?tb+HCL0L+tlBnBbU3WTkXIlMm6y4X56Z2E1yhpXX11FaqKJ3A8ip21oArj?=
 =?iso-8859-1?Q?+4tQ4xnefHbFSiOk3gBmUnPfzi1/WLjVA7OSZhBeIyYhf/rIkfy5ashBSI?=
 =?iso-8859-1?Q?MIFJMs2Gqq/v2duLsDZDKYqbs548R1diCtxPaCDQRKl5jEXgVcUPN3hVnV?=
 =?iso-8859-1?Q?XVO6c9smgvsHhv3H9i0/st7gByNdLiAeAnhwUkES+wCmkIfrc6umNEe/xg?=
 =?iso-8859-1?Q?e1ksdvSR0Xpq14DEHUmTvrVO/k30qqhHJg3Rl6KwvVbs6g0ngqlWyJSFQh?=
 =?iso-8859-1?Q?5Ch/Ga7svC8m+yP52Qe67pVRW7SRvkPGVCvluuIhFuyqiwBOBLkinSMHMa?=
 =?iso-8859-1?Q?kspRb9MUg4K+YcIHe6U50l9L3TcjDKF8ISMTxtqo5BD64/9af2IByxwELH?=
 =?iso-8859-1?Q?OrW06faQBlxWTUyiK5qr24tAzMd2/1UyNPdcT5O6ShJder9awLGZ04GYGc?=
 =?iso-8859-1?Q?YeeYja9kGo5qQA8hdqfpNzmRIRmS+TA0iVW1pBgRROwEJuL5bBmPvJPoEZ?=
 =?iso-8859-1?Q?OFjBCFOPKt2aydcOEZHW29njCkrOE1LmEZ1PpKv6iecX0AGWoZZyp3obV6?=
 =?iso-8859-1?Q?R/OrvQnO+SzqdK5p0KVh+vrXe2rW4NFdl5ExPyNjfd0GqTx30YqS4J3STJ?=
 =?iso-8859-1?Q?3RkF1rHCVqOA18Lrujld959Kug6hdC4hN3JkiFuUP59CQhjoO3ygOSTQUB?=
 =?iso-8859-1?Q?7cyOzQWBQYkrxJ78d3sMxjbiNbeaqHsElFEfLygXbq1QzYVYurgTH0n6A3?=
 =?iso-8859-1?Q?4VZmiJSnsh+RP07oLYG7ZuoCxJUfAjP7tu44Mls05kR/RMWFDbaprFdtyy?=
 =?iso-8859-1?Q?Wu65V1NiL4iySKfYwvUsDyblMXo42BtLopm3tvHCMteqY/lRDh/99P+xf3?=
 =?iso-8859-1?Q?6WjXz8UcF7Gk9aXdv9q5T1ITtCP7YiSXlKhRmcgTlRDw/WEZfuI+wlJZg7?=
 =?iso-8859-1?Q?MOUbGe3LFvW+HCYGpsNNwf4iPAAMbpkBXC+qT55DN+7aaW1/Ud7L4QyRMq?=
 =?iso-8859-1?Q?i1Rlih3sziuDrtcT9dBqiBWVvUmzXDS5U37/5S2X14oGK7DjMNvgcBgol7?=
 =?iso-8859-1?Q?uWU5DBqspG5Hv43sd9SKVh/vIBAQLDp52Qrq6sUBlNMP9S4FxIDg8ZimR4?=
 =?iso-8859-1?Q?zsN6h0AyuHA51KvnKNsZA5zY+6ZRjCLEt5ZgHdRJs13Tj1vRnD8vOsYYsf?=
 =?iso-8859-1?Q?L5NKOlf/pPxOXOMRB92uBLtsYXjqdPIh1iKQ/Rbh7A5vzXSfNAjevvXA3v?=
 =?iso-8859-1?Q?uxSBosAAq2WSrnT237WeRWLeqS5E0Ismad1adHZaJc07eff/XZt2TwTXO/?=
 =?iso-8859-1?Q?IVLi2r2whrgqtPojQAeEQqtBUPFOK4NK/ppcXia+dkZ0PAVF4lWi8Hc/lU?=
 =?iso-8859-1?Q?H0dv5eBHWnbnKtPDMwkRkaDND7Slyl5jZydUuebUtmcqyMwtVPisEBGPcu?=
 =?iso-8859-1?Q?BM+ueaQdfndVjGCEVq3NZ/fp4HrXDHADO4RfCoPqWUuwwUE9PUftjQ6NZK?=
 =?iso-8859-1?Q?lZCcyI8ErrkQ/THjI8QNiSuh1a8QpJ1KnqUpkr2KxFANaZyGtfAeVx9RTn?=
 =?iso-8859-1?Q?ZDWG+LdbV9neqoTgtVMdk9BefcrmeSwmw60XImN/?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?MufzTl8MHDVjlAia1ksnpxyTfrziMDaJA2VwvPX2+nTjJoFv8uEcjloFvx?=
 =?iso-8859-1?Q?U/tLfdePc+XPmmSyC3tdAT+wAhfGGyrWjKjA5LrqI989YcKkd1jGTAFhbU?=
 =?iso-8859-1?Q?4enPhZ4ADNEwS+EFer1FN6CxcLgjk3xEga6q709F1yk///pGiTt1OMEFNl?=
 =?iso-8859-1?Q?SV7uRI1E8drmp8so4TkAWAJtqx9SwlUzS5yKE/8hop2TxrHuOwC/6fY8fx?=
 =?iso-8859-1?Q?Q5ypXaeOehvGm+KeHOumyL1uWIqRPNY9xVYIkEB3Tdhd2dEfWcZEpb8f9Z?=
 =?iso-8859-1?Q?CcYHCbKXS48Fvnw5fPcxGcKjQlFNQZisdufMiBpdcaCBsjkX7pQT31boRS?=
 =?iso-8859-1?Q?w90tz4Px6Rnx5LNzuVxMPxBqFNBEY6KTwkq239mvOPMWOlh8cholPXd+hN?=
 =?iso-8859-1?Q?V/XEmkaz1rIxQIgu90dhrRA2BdSbl/8xlwWmv0nE4ZWk0L6XFXYW/KGV1l?=
 =?iso-8859-1?Q?JFTQRiBV0LgI7wXOWS5mrvm4OQ1HydCSTFRIRVPt/rCptdvZb6wE8hX2GW?=
 =?iso-8859-1?Q?vdzKEh1Hgc6cmcRCP0nhnNWlanUXOuldLjeKAmxKswynYBhZWp60tH4c5F?=
 =?iso-8859-1?Q?MAf6HZMwfa9IroDgEwcMaoFOXWYxzDggpclgYYHgh5H4gl2eBelcrlkNWz?=
 =?iso-8859-1?Q?7T+FVWKTPAeSMNX/SJ4ng86vZyKL4gVGvYArTYp3+xk5+8jddWwDz3HlZ+?=
 =?iso-8859-1?Q?AL0E7Xmzux92BCNXsoQMwCOmAPiAUzJk/ZzO0HNv2fPgBvorXFaf3KwMla?=
 =?iso-8859-1?Q?Wn66c8KqkZfGeWSNg3D6llnUZMwMxmSZCvrLmKf+dyrsTogEYSyL17zqjm?=
 =?iso-8859-1?Q?UdpDJqbO1Fwp/w8cC+5cVRA/wDbxtpTk7RgthjXJDy9QqkM/VTiZ0dUaCL?=
 =?iso-8859-1?Q?0xcxbrjHBMdeZ2KlitvI3RO19zq92cr8LdUzeRp0ExhNuN/7aCwrVJ2NM+?=
 =?iso-8859-1?Q?72andRsyc8gj9a130lNLUcotmScNzratcQgzwUFgTubu2m1O0VAnm5CYeU?=
 =?iso-8859-1?Q?5AK2NEG5GbCEzjE3FS8F8Ag1FH8qnPivS8mTWFyTZvgkARNB65MBmp1hMh?=
 =?iso-8859-1?Q?vBb07bz6ZSkKpRA3WY+I1OsjtVtgCFF8maq85jTlf19hBr3hXT5x501aub?=
 =?iso-8859-1?Q?iufjIXu7ZNPCD0ezlEs04mYVhs5iLoyZoQ28lM6DSXhqObeXiOHJ5Ec4Cp?=
 =?iso-8859-1?Q?oUv/Z5jzTZ1LDlgWYmo6TWodLL821SEvfKmwA//9Ei3+26qXVGIbeF2mtE?=
 =?iso-8859-1?Q?rzcZisAuM+0pPX9OCF2YjUObw6U05GC4TB18sCUexypM+WMEwZwPw/8smF?=
 =?iso-8859-1?Q?VbXXO4i9z7mjjeShGUQqopCYs+M/ZdSJd1mp+7NJc81TctFwe2b1hsa5r5?=
 =?iso-8859-1?Q?wbop0AsPQ9Wf9iENC5v191GXa3vhBJN9uusbth4XWzNNvYoR6QCUmKQ4IL?=
 =?iso-8859-1?Q?2um9hOKq6zKAkd6pR/MFaV25dIPJEO+e+gpcMc0lB7vzgyeIqSdDhgtyMt?=
 =?iso-8859-1?Q?zZEp3+/USZhUyf8aX9xBLcAJMIs3MyoVVnztooO0GN03nFMN7U8JJhGuwu?=
 =?iso-8859-1?Q?RJeLgHKkmY07QPodwSMVnyZsPrTRd6gj+AU350i72pQF+COljzsgMVn4h7?=
 =?iso-8859-1?Q?/8xtUnqH8BAs0gLnBjJGRLTO2S28oq+Nb8wtfOvQy3lwFKtqJdKn4EoPy8?=
 =?iso-8859-1?Q?d27/nk2izGHYaFVGpg9qjqmL/g+5aok5seXdO9J0+fKi7Ofn9u1Y35PYU8?=
 =?iso-8859-1?Q?r7UrCOwh0aGE7tHaNhnMpkFYEvQLiESgXSJBzDrlqGatv1gQ1K9egSDi7c?=
 =?iso-8859-1?Q?/M41anDQvw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6153d07-fd5f-458c-a628-08de7366a5bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 05:36:23.7283 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pnSxVY4wHJm4tpXQhY8ziNUa/S1WvzAOE37yFbQ82clyqQGlXZSQJjcbD4ILZrAyNWHfuxQmrTllmJiGZE7OrfiKW9Sc82zMFgDXjcAtB74=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5179
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

Adds the rest of the Aspeed I3C controller register fields.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/i3c/aspeed_i3c.c | 54 +++++++++++++++++++++++++++++++++++----------=0A=
 1 file changed, 42 insertions(+), 12 deletions(-)=0A=
=0A=
diff --git a/hw/i3c/aspeed_i3c.c b/hw/i3c/aspeed_i3c.c=0A=
index 647074d181..a215700288 100644=0A=
--- a/hw/i3c/aspeed_i3c.c=0A=
+++ b/hw/i3c/aspeed_i3c.c=0A=
@@ -21,28 +21,58 @@=0A=
 /* I3C Controller Registers */=0A=
 REG32(I3C1_REG0, 0x10)=0A=
 REG32(I3C1_REG1, 0x14)=0A=
-    FIELD(I3C1_REG1, I2C_MODE,  0,  1)=0A=
-    FIELD(I3C1_REG1, SA_EN,     15, 1)=0A=
+    FIELD(I3C1_REG1, I2C_MODE,      0,  1)=0A=
+    FIELD(I3C1_REG1, SLV_TEST_MODE, 1,  1)=0A=
+    FIELD(I3C1_REG1, ACT_MODE,      2,  2)=0A=
+    FIELD(I3C1_REG1, PENDING_INT,   4,  4)=0A=
+    FIELD(I3C1_REG1, SA,            8,  7)=0A=
+    FIELD(I3C1_REG1, SA_EN,         15, 1)=0A=
+    FIELD(I3C1_REG1, INST_ID,       16, 4)=0A=
 REG32(I3C2_REG0, 0x20)=0A=
 REG32(I3C2_REG1, 0x24)=0A=
-    FIELD(I3C2_REG1, I2C_MODE,  0,  1)=0A=
-    FIELD(I3C2_REG1, SA_EN,     15, 1)=0A=
+    FIELD(I3C2_REG1, I2C_MODE,      0,  1)=0A=
+    FIELD(I3C2_REG1, SLV_TEST_MODE, 1,  1)=0A=
+    FIELD(I3C2_REG1, ACT_MODE,      2,  2)=0A=
+    FIELD(I3C2_REG1, PENDING_INT,   4,  4)=0A=
+    FIELD(I3C2_REG1, SA,            8,  7)=0A=
+    FIELD(I3C2_REG1, SA_EN,         15, 1)=0A=
+    FIELD(I3C2_REG1, INST_ID,       16, 4)=0A=
 REG32(I3C3_REG0, 0x30)=0A=
 REG32(I3C3_REG1, 0x34)=0A=
-    FIELD(I3C3_REG1, I2C_MODE,  0,  1)=0A=
-    FIELD(I3C3_REG1, SA_EN,     15, 1)=0A=
+    FIELD(I3C3_REG1, I2C_MODE,      0,  1)=0A=
+    FIELD(I3C3_REG1, SLV_TEST_MODE, 1,  1)=0A=
+    FIELD(I3C3_REG1, ACT_MODE,      2,  2)=0A=
+    FIELD(I3C3_REG1, PENDING_INT,   4,  4)=0A=
+    FIELD(I3C3_REG1, SA,            8,  7)=0A=
+    FIELD(I3C3_REG1, SA_EN,         15, 1)=0A=
+    FIELD(I3C3_REG1, INST_ID,       16, 4)=0A=
 REG32(I3C4_REG0, 0x40)=0A=
 REG32(I3C4_REG1, 0x44)=0A=
-    FIELD(I3C4_REG1, I2C_MODE,  0,  1)=0A=
-    FIELD(I3C4_REG1, SA_EN,     15, 1)=0A=
+    FIELD(I3C4_REG1, I2C_MODE,      0,  1)=0A=
+    FIELD(I3C4_REG1, SLV_TEST_MODE, 1,  1)=0A=
+    FIELD(I3C4_REG1, ACT_MODE,      2,  2)=0A=
+    FIELD(I3C4_REG1, PENDING_INT,   4,  4)=0A=
+    FIELD(I3C4_REG1, SA,            8,  7)=0A=
+    FIELD(I3C4_REG1, SA_EN,         15, 1)=0A=
+    FIELD(I3C4_REG1, INST_ID,       16, 4)=0A=
 REG32(I3C5_REG0, 0x50)=0A=
 REG32(I3C5_REG1, 0x54)=0A=
-    FIELD(I3C5_REG1, I2C_MODE,  0,  1)=0A=
-    FIELD(I3C5_REG1, SA_EN,     15, 1)=0A=
+    FIELD(I3C5_REG1, I2C_MODE,      0,  1)=0A=
+    FIELD(I3C5_REG1, SLV_TEST_MODE, 1,  1)=0A=
+    FIELD(I3C5_REG1, ACT_MODE,      2,  2)=0A=
+    FIELD(I3C5_REG1, PENDING_INT,   4,  4)=0A=
+    FIELD(I3C5_REG1, SA,            8,  7)=0A=
+    FIELD(I3C5_REG1, SA_EN,         15, 1)=0A=
+    FIELD(I3C5_REG1, INST_ID,       16, 4)=0A=
 REG32(I3C6_REG0, 0x60)=0A=
 REG32(I3C6_REG1, 0x64)=0A=
-    FIELD(I3C6_REG1, I2C_MODE,  0,  1)=0A=
-    FIELD(I3C6_REG1, SA_EN,     15, 1)=0A=
+    FIELD(I3C6_REG1, I2C_MODE,      0,  1)=0A=
+    FIELD(I3C6_REG1, SLV_TEST_MODE, 1,  1)=0A=
+    FIELD(I3C6_REG1, ACT_MODE,      2,  2)=0A=
+    FIELD(I3C6_REG1, PENDING_INT,   4,  4)=0A=
+    FIELD(I3C6_REG1, SA,            8,  7)=0A=
+    FIELD(I3C6_REG1, SA_EN,         15, 1)=0A=
+    FIELD(I3C6_REG1, INST_ID,       16, 4)=0A=
 =0A=
 static uint64_t aspeed_i3c_read(void *opaque, hwaddr addr, unsigned int si=
ze)=0A=
 {=0A=
-- =0A=
2.43.0=0A=

