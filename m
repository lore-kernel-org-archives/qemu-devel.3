Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0286EB3648
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 02:08:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxFAA-0001F0-Ik; Mon, 02 Mar 2026 21:07:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vxFA9-0001El-86; Mon, 02 Mar 2026 21:07:05 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vxFA6-0006SB-T0; Mon, 02 Mar 2026 21:07:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V/m71GrDyQARKQsqsVkPh3wFUFkLdDk3TpeU3inFvtBm5jARd/E2dAkjOU6CrgcW95tosDAI4Mik9Yx3xf19bwRGfA8tiFR7FuYEFCcOjRmleloJL6WD9RH/XqFJylH0a2/9pV6xrT9TOKOnPWU/bbYK10hQgMI5ove3aM313Uc6xiiZBaLFmtKggPQ468DQxnwN018wq/K5P4KS48jGLe3f9hEZd2CaAWXFu1f1v1Yx2TDoQiiaUwOVZmntnHfm03nqKokmUNmb4tkdBj0Ej1mt+ypfeRof/hx84uWDE5LOGWZqQJ5MUZRtriEYGV31Go2uAblQIFOOwVPFFWHsGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IrZNfcBpdvo1hjDMsExui0M063Ssl35sZ0lKZMmQgm4=;
 b=gELpIqmFuFXagnclYBYg+nUjzLRs9hdNzlroPIC1LdF2FhSy/hWryMFNnrQys173Nw1cB/8WjkqoJK0P+y14Gdybi+9tbuCRbyeHVqGg/Lxw0gMFA0VKlx5ptRkbipkNekZ+QTwJeCaCyV1fJ2eMn5ZIdivuDJobiBvKXcnD+UavRHoZ9kv2So4vpfcuptJBCXZQoWkIDlXJ2LQi1i7WkmdID4Q+6ls1HYIEqJZq7hFasc4HdGhr2enES+H79H+gTAUtFCRAWib81v6dzIXixxv44w0oTF/bl96ZPrSYQh9mXF53sFClDlPgjGI74YX6JZgRGanWuTXlpto6+7q8fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrZNfcBpdvo1hjDMsExui0M063Ssl35sZ0lKZMmQgm4=;
 b=ZEfdCga8jVyBWAfkgfzrmSFEipX8oFicXJt/OwzXacaG/q0CsXqtXl3NTJXvoN5aRd5LVin9StEGPw+b451DGS/kO3Fs4BYrjDR5Rk1xIRH932f+5dYqbYAdz6kXbAnNNhNpz9HWJjAwYA0jmUXhflPMmR46pWljgj9RUtMu2p2+DNfyaduxZjw9ST1Yh5yCzpAUOmLT6ayiSxxP04iUITZIyBo6+ZbJcxv/Hxd/z8xgRZlv8IvzvInaJ9v6l9RITDiGBmW3eijuynhL52S7PpQ0LRi4bAY7vS+NUJ/8J1SZFHDRmk2NXZYp/7VHd1KCcIfczkWbL7RjAe38uU/qGA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by PUZPR06MB6030.apcprd06.prod.outlook.com (2603:1096:301:11e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Tue, 3 Mar
 2026 02:06:54 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9654.020; Tue, 3 Mar 2026
 02:06:54 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Bernhard Beschow <shentey@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "Michael S.
 Tsirkin" <mst@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9_Lureau?=
 <marcandre.lureau@redhat.com>, Helge Deller <deller@gmx.de>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Richard Henderson
 <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Joel Stanley <joel@jms.id.au>, Troy Lee <leetroy@gmail.com>
Subject: RE: [PATCH 10/12] hw/arm/aspeed_ast27x0-{ssp,tsp}: Do not access
 SerialMM internals directly
Thread-Topic: [PATCH 10/12] hw/arm/aspeed_ast27x0-{ssp,tsp}: Do not access
 SerialMM internals directly
Thread-Index: AQHcqpBhULSlZ68/cECN5iRaPNocu7WcD2HQ
Date: Tue, 3 Mar 2026 02:06:54 +0000
Message-ID: <TYPPR06MB8206C9B5A6512B1858B6294EFC7FA@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260302220254.1166849-1-shentey@gmail.com>
 <20260302220254.1166849-11-shentey@gmail.com>
In-Reply-To: <20260302220254.1166849-11-shentey@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|PUZPR06MB6030:EE_
x-ms-office365-filtering-correlation-id: ad56db81-4d8e-49ed-4be1-08de78c98aea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700021; 
x-microsoft-antispam-message-info: eiknOiBN/Be/dCTfCy4FDbVxLdclgw0pKBkgtJlo1IFyXgzBtuMXF9JGBGmi+MZtMLEBgAExWW69hJ8GmzF8K/W6ceLT+AK/8nZBkg/rWsrKzq6jtx26JJKohtIt64KJalIC5F2rvi9CsY5MIdFa99C0+jR9fzzcTb/lDPqGrzex1Oe2GBB8+blX2cZdRUQevVhC0cZ1WoiOFvWHwzG4eu/gxvitIUVXskb4qoUOeCj/NYczqJodZm1M3w9Ne9e1e3rcMMa8XrY9bWeWcTGwhO0Idn1VWa2hZroXvwScESLmvEh7LpNTlYTiVmwfkgmAAePE3093OlnCi7qaUT+IbJRJ+l1fJDqpVnRf0oceBTAtKS3xVziv19AQcQaxYJAeLRC4TFQZ7bUG6jsrEfO5XaCUvkLHTHGbOH1iXWEwOPsoEINZ4ax8MIJa1l9//UXZfd/hzETbPby4WiAUY7P9+jCKXUtq1W8FZ1OaYc55b2UQclIbSvCslkVacoxVVYX4im++qCJZsXtT5xNldksXJKfMOvf5avT7zWTXibShA96IaHqwca70tVsnbF0iLccIgNamA6b8M2uG2TYfDPTSPhJQ4GOAlvCvzUpy+aYgdPuaxsE/n0TbCdO11SUADnHCyXGpFLMH79j5pY26R/EM1ELlXG0uuio+j9K2J1v+UrPiUX/vMoszsyb6euQiS1a5ln3k/GA96U/C3lP4QQ3WtvFF/8n6CY2Q7COvqYG7wUs1MEyegTvzo7HfrrjYCccVviF6YXUFvhIvb9kitevveb021S44ANGfCIKhgX0LNi0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?vaLkRZ3xOV6CMFTU/Ndx8lxySFl7d3i505F/t0e1EMp8UTdIX3HPtvJaig?=
 =?iso-8859-1?Q?Tjbc5ua/TtWbWuAKtL5if5rSqgWHAgXd2in7sM6gAbtQJmckt9DSfR6kxJ?=
 =?iso-8859-1?Q?at5wYPA5OrI4oPW340Y5jYysQgB3G6un7xUh8RvQu/jMTXUgwxrZUSZFTj?=
 =?iso-8859-1?Q?1wFlB37g9rIppgZE0Y33SCDLWg7pvaLV7F8XIeEFBmGO2mgi6g4ULKVPBI?=
 =?iso-8859-1?Q?ZSqx669hIcku54ZvQOmjM9vpfd2Puf5Pz7+skURp0oXQW3J1edYTCOMzEv?=
 =?iso-8859-1?Q?JmYRpmVbz7pEaEGxzd8PBOTrfpov3BhyUmj9RZVzeI0tR1uWDdxjdAg38x?=
 =?iso-8859-1?Q?9mwbXRspgGlTa2cxRwWzafST3sh5xafN4JkZZ7dEG/+/PCBiS2ZZnNylXk?=
 =?iso-8859-1?Q?O40eHwIbPZRZ2ktboL/NPaD+273aS/F8uSHGsEOw+F8fH5wEVgvzCYG6ou?=
 =?iso-8859-1?Q?Y2bvnRJyiNBBJfGhBMvWyDtmRCbQp+s4zFr5BDgvsdVQN2LgSduaO0mNm3?=
 =?iso-8859-1?Q?k3dq5D3OK3U8VIQb0z7ZeBVb92kUvCmvuCL5C+6hCEiXXhW6fOiOlOLFsO?=
 =?iso-8859-1?Q?iIn4AYk/LeAtfePkfR/LN48JSOiLDSitQjuJQ3QjQauw0AKW/sovuD37AW?=
 =?iso-8859-1?Q?bJhIXPrZfBDR6hHrtuXKvwNAADPLpL8V1oO97KC8OuDCRbbiBwCfIm+19u?=
 =?iso-8859-1?Q?WBWr1peX1KJMhWRYgCWESpRIAKMc/gBdcVrE+i5qgrviQi1bWHDj8IarSw?=
 =?iso-8859-1?Q?SPmZ+Xky9lS9zZmHR1YR229ZTboQUM6FnV5x4dk9t6L1Ee126n9zMuAadZ?=
 =?iso-8859-1?Q?WOy+S18aapPGdoPN26+l0IFb1NIGVdUTP4JAQxAyb11rIUgU7ueuv42+xz?=
 =?iso-8859-1?Q?ykerqSx34req17zRPUgMuPZrOSYE9e3gFI6K4+kiYa6v4Xsr5SE7MX6NUn?=
 =?iso-8859-1?Q?tI98VYhP633B57LUcwA2xhYv4fQTDGn5xoSoxZ8oFphAFgx4tvY5XXMUxs?=
 =?iso-8859-1?Q?M+Yo548e4WzNdLStVIMJq/6/ouw+5m/GVHY3CcvS2kTENW1Fk+qiXZWVya?=
 =?iso-8859-1?Q?WewCCyKjn+8sa1yW3cXeZKXfpzc0diy0jJVvB7ElbOua3H3YYAVjTViRui?=
 =?iso-8859-1?Q?f6JoHUjr3IfYMOvlxCnGiv/47GyMHr1AjJV1UTskaKyb9wUxqpBK606vvA?=
 =?iso-8859-1?Q?wfLTtk5Zk4BQXTFymoqq+9OGGtz82KRi/p/zLjcwaEGxrvuI6pF7luUPtt?=
 =?iso-8859-1?Q?LbC226Ju6A/F1eGjtiPgjfqhtdYeE0gYlOj+ypyL6pD+TCzpz1T5N+DbJd?=
 =?iso-8859-1?Q?9RSxpBY1Om5QSYA3OtuJW5w13xPXgBlJ5FxNfaYkzQ2jZM5buQ5hLkr2X/?=
 =?iso-8859-1?Q?esgJKXuJSS/+TBWbC/hoOaA87mkmg3UPOuEqHW+Rt7ZtNM6sfHBUA68sx2?=
 =?iso-8859-1?Q?wJlw4ZFXwIDOvs1s5dhfywXUKs64cUasY3MkgLoW7nETqTpyok2bboEzLZ?=
 =?iso-8859-1?Q?fztFK65+2LujlQAwp8m5ltvflva47VLdIzFBKOl/bQg2b1otTL+kEpb6F1?=
 =?iso-8859-1?Q?t/dx5uy/Al48iKLEu+7aJv26gs7AhD2/6NxZ2sp5yohtg9c5pbpVnhFx+t?=
 =?iso-8859-1?Q?MAevaXc5U1inscAJ0xSaUEJNazMb1QxmL7/P1NRLx6D3faORfxsqZhIYoJ?=
 =?iso-8859-1?Q?3LSWYwMlMP+6eHov8ybDMLpJrDiGmT9RMn//SDEjtgHnMJ6l0tmxJDcujJ?=
 =?iso-8859-1?Q?YmswCVHSEeA9WIqmraCNfiXkj/SdhwutMftwIHV+qXkXYi5OK2baaWs1rD?=
 =?iso-8859-1?Q?NWojTo20bA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kU44pD3SJLjmHoanzzjaMJ4jt0GAEeAiANxhP+TinHbh6bvIQo41ATEZhnzHitFHDm2gbQqqNdZ5CwkLKjW+McoIAhVK7n6AAXWIg/6a5GVge/6ocpwM8CpgsbB6v015xNRBgCd/wZpTpa2M7W9ghjg5Qd0EpjoP/gQmki2/TUydYCxwRgfpNxgQr0iP+WDZxW5kO/tMZSb+Yvx/iQqu9eaO0BuKrcJNCnPnhPSAybuyorPfCNMcfSGKgKcs0WeI4jkLsz6iuxZLkUP7WCFAXKxbjOlBmNYuJh9c1xiWDMEf/pyGobRj8sPKAueDfzoiX2VI7QKUdhPb55Bus043zg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad56db81-4d8e-49ed-4be1-08de78c98aea
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2026 02:06:54.6666 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7i5AQMx2t/qtW5lKBnfPdy9ep+3DY1vWw0Tkbny+DCgwyqb0uIznF/1t5+Fr4ziyKEqCpWzFXCyEPKyV1EWlDSv9P2KvY9Ps6lKHO6IJe2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6030
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

> Subject: [PATCH 10/12] hw/arm/aspeed_ast27x0-{ssp,tsp}: Do not access
> SerialMM internals directly
>=20
> SerialMM inherits from SysBusDevice and exposes the memory region by
> means of sysbus_mmio_get_region(). Use that in order to avoid accessing
> implementation details of SerialMM.
>=20
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  hw/arm/aspeed_ast27x0-ssp.c | 7 ++++---  hw/arm/aspeed_ast27x0-tsp.c |
> 7 ++++---
>  2 files changed, 8 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c
> index 9b12ba6743..8b84300e0f 100644
> --- a/hw/arm/aspeed_ast27x0-ssp.c
> +++ b/hw/arm/aspeed_ast27x0-ssp.c
> @@ -149,6 +149,7 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState
> *dev_soc, Error **errp)
>      AspeedCoprocessorState *s =3D ASPEED_COPROCESSOR(dev_soc);
>      AspeedCoprocessorClass *sc =3D ASPEED_COPROCESSOR_GET_CLASS(s);
>      DeviceState *armv7m;
> +    MemoryRegion *mr;
>      g_autofree char *sdram_name =3D NULL;
>      int i;
>=20
> @@ -230,9 +231,9 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState
> *dev_soc, Error **errp)
>      }
>=20
>      /* UART */
> -    memory_region_init_alias(&s->uart_alias, OBJECT(s), "uart.alias",
> -                             &s->uart->serial.io, 0,
> -
> memory_region_size(&s->uart->serial.io));
> +    mr =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(s->uart), 0);
> +    memory_region_init_alias(&s->uart_alias, OBJECT(s), "uart.alias", mr=
, 0,
> +                             memory_region_size(mr));
>      memory_region_add_subregion(s->memory, sc->memmap[s->uart_dev],
>                                  &s->uart_alias);
>      /*
> diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c
> index e39d1dc171..e7c7b74491 100644
> --- a/hw/arm/aspeed_ast27x0-tsp.c
> +++ b/hw/arm/aspeed_ast27x0-tsp.c
> @@ -149,6 +149,7 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState
> *dev_soc, Error **errp)
>      AspeedCoprocessorState *s =3D ASPEED_COPROCESSOR(dev_soc);
>      AspeedCoprocessorClass *sc =3D ASPEED_COPROCESSOR_GET_CLASS(s);
>      DeviceState *armv7m;
> +    MemoryRegion *mr;
>      g_autofree char *sdram_name =3D NULL;
>      int i;
>=20
> @@ -230,9 +231,9 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState
> *dev_soc, Error **errp)
>      }
>=20
>      /* UART */
> -    memory_region_init_alias(&s->uart_alias, OBJECT(s), "uart.alias",
> -                             &s->uart->serial.io, 0,
> -
> memory_region_size(&s->uart->serial.io));
> +    mr =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(s->uart), 0);
> +    memory_region_init_alias(&s->uart_alias, OBJECT(s), "uart.alias", mr=
, 0,
> +                             memory_region_size(mr));
>      memory_region_add_subregion(s->memory, sc->memmap[s->uart_dev],
>                                  &s->uart_alias);
>      /*
> --
> 2.53.0

Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>

Thanks,
Jamin

