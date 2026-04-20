Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0A78EA71B9
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 03:47:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEfap-0005wc-Vp; Sun, 19 Apr 2026 23:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wEfah-0005vx-EO; Sun, 19 Apr 2026 23:46:32 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wEfaf-0002Bl-90; Sun, 19 Apr 2026 23:46:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cF8MsbkvaIakp87eL7AdzGxigk6nl4jn8dMgDRJjmMKW82Wil92nsfOgPT2eVeR46YKEKpHD6sXg5AFf0Q250ResGGayIBSIlzz9zkjspZgsWVzfc21A0wPhql6niDs8UMvBpp0pUm9JqBis6CLwgzXmGTKrPc+X7uP4266wHmKJvuDRhkfuqbJ+LWWwdqy3LRWyA9DFrswStA3d8EuVTkFNVTJrwcCf0u9XDVzwWsNbzbaOCon+aiwnYoWfxiLthFfuiBlWLPWXC6/e/PTh/d6oWiUJK0ErxjNfGYNJNAHYytA25jNGewsiJR4ix0Ai22x+g3OnA8zKwsmWNk44DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LWZw+YdUnonxfkq6uEmXY72LLG0nxoV8NSogM7hgWPE=;
 b=ih9t1st/72hNO5BwlqnYsD2rf5vJUsAbNnC7VQIHuE47egMeLD1p9LwKGAU6UunBJaCG4xDPcY8CKA3H1AaUHcNR7fo4RuXu2eV/oUuHydSiiXSlz9H2mMvPrLZdsaC1epRRy8RlRLZV3OLRm/SEfsFhdWLAL7FgyVeKrWmJRt3aFyaWhVa0hCPecsx3GsBNIm6gLtIhDNvQbl3ofEGkinuwuHLrTbwuvloKiEZPUuYVUId6qTTSA3LJMVMTCeAzt4AYWNbGXoZrw0YxZ4iubOMv35uXC82kgVz4pnYxtxuVT4gEDGKtv4S23MmXPtLuvRuiYFRT7mKpZtii0io2+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWZw+YdUnonxfkq6uEmXY72LLG0nxoV8NSogM7hgWPE=;
 b=MwXmIPVDSAklyYBQBWC2fY6q9d3sqASmkrbCCsijdgPjlO8wKAC2ikGwCg7XKag+J+rcxIIYeucuozHW/euR1hR19Gwe++DyCmJJpzvx76IYMSUrxYCSFSatL/o9/UfxDsOQalg6d8P/rNi+ZlUd3JOCb7PtwvA0bOCSeSRqk3gR1x+bPPf+yDOGRepjfWzEmwD3i8rhKF4kyEnLTQ+WRryFNifyjV8rknuEKjQVYFXkDv12K/neVXXV4h5EpHbSS7BmgwjMuNsUiukcBWzFjk3RwU3hIwc+AlPOlX661exmsTcmWAime5reoKfDZPKPeO1Vj6YTiVCXBoNattGucQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYPPR06MB7972.apcprd06.prod.outlook.com (2603:1096:405:2c0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 03:46:16 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 03:46:16 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
CC: "philmd@linaro.org" <philmd@linaro.org>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, Troy Lee <troy_lee@aspeedtech.com>,
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: RE: [PATCH v3 01/17] hw/usb/hcd-ehci: Remove unused EHCIfstn
 structure and dead code
Thread-Topic: [PATCH v3 01/17] hw/usb/hcd-ehci: Remove unused EHCIfstn
 structure and dead code
Thread-Index: AQHczUNFhK5MCMsaPESXZcYoH3r+fLXhmSoAgADa5RCAABGycIAAfiQAgARRziA=
Date: Mon, 20 Apr 2026 03:46:16 +0000
Message-ID: <TYPPR06MB8206FD23CEB6362F35A42B65FC2F2@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260416014928.1279360-1-jamin_lin@aspeedtech.com>
 <20260416014928.1279360-2-jamin_lin@aspeedtech.com>
 <d7e9d943-fd8d-dd48-5a86-e54613c466dd@eik.bme.hu>
 <TYPPR06MB820623725F12A9326E19B44FFC202@TYPPR06MB8206.apcprd06.prod.outlook.com>
 <TYPPR06MB8206FFD9BA069A555C54A137FC202@TYPPR06MB8206.apcprd06.prod.outlook.com>
 <efadd094-380a-41e4-0346-7ba296781968@eik.bme.hu>
In-Reply-To: <efadd094-380a-41e4-0346-7ba296781968@eik.bme.hu>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYPPR06MB7972:EE_
x-ms-office365-filtering-correlation-id: 62c34e2d-6bfe-47a0-ac2d-08de9e8f6002
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: rRBcy4P3L+K2GfjoeZIJdZ6TZLjEYvYjLR/TOMwdLK0gqzTbDNk6eKew3VseOM7/63TtVlLD7rovzZNV/iVH57PO7O+Bt3Ddu5qyEurvc2zGu1lVBSpziKu8xfZmR4/ukVURrDbbQvF1pjYxGxaw+sLD1yvavlCRTZnd0z35BKouCmtHAyNXvbV549HAUpZiaPg1zqsbXxXArhI79l1gD4Y3Kb0A0vGgbCKEIc53D3U8BZu0TvuYKvjtVDnh0Fb6Z027zQhCE6BrlYADSRBQJFZXjHj4/MiYs/tuglLu5qXtg9dBOCgfoxQs4LtINPWmDxXu1OgjSQcnG8QbN8kQayXmVgBiXoHjPl7xpLowWp5sKYYEBcOws+/S4Qd8VHICFUYoXk8poZ7HQ5wDFQvJRz5aqHh0xkCmkSX2oRizI9cZWoh9Z/Rr1E+hwjzZLkucnwrDOUcWVZBOktbaLmkrzqD0CFT+9gd/u1b6aaYd5TCiYfBz4/mwaiG7DaMqrZ4aNNQ/N6hfrHjG9NiouAz3DA5FecKaru4OXAi+/gOBIvzWqRLaOz7aum5tPcO139CkZyzwIVSL7rvmzAytXBn1zLnvaN+Y9LFcTf5i/D37BWOYysYGerBGkqz6+uXyPEp04dvqo+UqoWavpWYFYwgC87yQCOxqHEuk5+vWF0eV/sLcYVgokeCo9gWZ4J8BqbZTqnc6zZTqWuXHaiWD6by5+b8983Htvxj74DkHMns4QhXs3FYfsTNBuLP/Mx720je3n4sTV/VkmqefPrjLa4Oi0kKvo5E3vQIzdDfr7Ai20KU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5Do81KxJxMn57iEGr+2kZPvNgl2VI+bT/se42IzIFskx6P+7nmDsBDredr?=
 =?iso-8859-1?Q?PrYBDDFrUa3Tlonq1FJlfglP/47oLteMhxQhZkte/1anVZYfLIQrbGBBpy?=
 =?iso-8859-1?Q?gwWvq3e6tYuyzI2alFYPSSfxira3u2sayP7LYqmtc1ivJhVJNVOQjH1JB2?=
 =?iso-8859-1?Q?I3f8F9WROudR/gWmQqv3CxcAWOFleT9uafha05MhFi5qOmvXInr5cxaP6e?=
 =?iso-8859-1?Q?enCtfmAGrkxVxHUYpvcqY4rUtTdty44Nvi+PagS2uADcBmhfsX47UTr5o+?=
 =?iso-8859-1?Q?jtJsZR3oGJYCT/BAnpFRVbg4M1GCFwQmRJZF/JXCWGGKrvV2HAqAHMBMkK?=
 =?iso-8859-1?Q?z6zsA0eATblELZ2Ua5RQYv4FOPkU3BrLlG6woVZWfSaAOlg0Ju3vksLJIr?=
 =?iso-8859-1?Q?R/E/lufOcspc6axNY5kCC2sOLOY3GvZ2BKwEj3rBEU85+IdEpeUoD+u5xb?=
 =?iso-8859-1?Q?6qZEvY4sfH1s0U8s6jXnHL/TYlyVGODxzGdQfpww1L7MUrVmHigqeLAGU2?=
 =?iso-8859-1?Q?/k0zcPHHlaal3oa3IWEs2fo8lJUg4oE8fki5msvfBS2Rx9PlzKhDrjvUJR?=
 =?iso-8859-1?Q?SIIShlVeYBQL8fi+cf4Chn429UkdgU3kC3dU3F1sm/xDP4JEqfn6BYoORQ?=
 =?iso-8859-1?Q?CR6L5bBq/r+5rZHQTykuMOBDaLHKxeOG69m+ahi5wygojXGMya8Fw21aED?=
 =?iso-8859-1?Q?jHPTxOc3V5BW9TMF/MZuSOjEmkU5OVRxKdXQ+6KohWWu6N1MXiEJqZuwVA?=
 =?iso-8859-1?Q?LCYWfRoNKT+FlzXiQhWDL3ZrhUfXdZq1igyhgs0+i3PssR4NF0b81ZoO0s?=
 =?iso-8859-1?Q?yXta3c/zxC2N+HOscs/FJ4C32E6NkBqF+ivwGKZ+sAJAnrUaDdK3JcwiPa?=
 =?iso-8859-1?Q?BvW4ESAJCIuAYolYo/A8aYujuYyyOCwIFA6/lmnPLcgp1qTWypgLTkOKXM?=
 =?iso-8859-1?Q?hugq3R136gRuyXU3UQbBjiZCFlFYROBO48aJs7Ch61SxC7dw9F3gKxWGZJ?=
 =?iso-8859-1?Q?94qYCtEYJbL71krAqwOoBr2vH/QjLsMZecB8zWPCXinklFkmdOgHaZXFIp?=
 =?iso-8859-1?Q?exDoTFOUepYdM/yByyT4BhHv0FHWuUHoktg9ynDyurR/Udf80IDRsnkz9D?=
 =?iso-8859-1?Q?0KiokZVjYk1IpqBSnORx/BjguZgvBeXW14fXhzCzFd/RskOsntRC5kSDr2?=
 =?iso-8859-1?Q?1d3WGvn2QJkudwO2t+Op3dYtFJw1n+Hwqq+uGgvxBLv6AwRIPlP+e7dzOh?=
 =?iso-8859-1?Q?mzbYUXp8XdGSjTHfHb+sfIoiV+V/S4xRF4H9+CoewJuOMJkTLH3JDAE9QA?=
 =?iso-8859-1?Q?0afQCBzyoniG42N4JtNBxji6w46nLbKb/xaBxWgTWenyNbo6ihvxIRnoRm?=
 =?iso-8859-1?Q?kePgp4oNyEFCN47w76EBIF/fnwsQQkK6qaAmdPkfU4oTGd4Vlds9yvkXLV?=
 =?iso-8859-1?Q?55YbX5BWJ7rYkXB83UCldBcSeMOnzQorroVqu7aMJ00JZYrWBp58mxdJUx?=
 =?iso-8859-1?Q?m/oXdEDvchoRnbQekf38leCaLUtDb8OIi8GcCNUCxnB7lm0yOwZuf8ZdtQ?=
 =?iso-8859-1?Q?nM/H98eQ2nWhRaqhY4CSkZZEyh4NW6QyzDqApOYA/9Du0G2n/3eeOh0EGr?=
 =?iso-8859-1?Q?mdhbEhtsKFXtegKO4Gm5MhPwgXjdTrz4GFVTMR1uY1IirGvjmX7tg1qevM?=
 =?iso-8859-1?Q?3KYeC5jWknkuEw+GpLnK4vznvdTdTgGqQYRmvRltw90Di7kXe7srOqaHwP?=
 =?iso-8859-1?Q?u9Uc7frB/vSkMz5o3nGR/Iid63v/QJmigk+LZMGC7iH17+p62nJ+x81dVk?=
 =?iso-8859-1?Q?7STrF0T8yA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ustCPxoUMypyIWSq4ibKNB3FlHrgCRBNxWMfpMaGqzGTAminPIIP/0oX+AGqXb4HlztiqRwhmtll6tK+sNS/8aOCWPspf6S3NPFo1kogEB4fE+/TKxTMktcjbhpIeqIPGMmb2ImQSQrRqzYG5K7Gy3TvxOm6kMydi6ps5oJ24/QmA+6NFL4871wLLkvbaDawysw194IX4016x2yhg3OEsJwiI0ofnV31LyYokNcnY8QUO8+L/pStvnznj1YD/RlswzQb4jvmRBlXaBMejiglKMinVcPTde75FKRXHjNMNat8L804uqnCV4gAmFiGQZucLgDbgLCIuBsTmTLW6Hu2xg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62c34e2d-6bfe-47a0-ac2d-08de9e8f6002
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2026 03:46:16.1100 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GGlnX1dk2yOb8FQ+9SkJW1xO8VTKDWsafXWI6sTlSsaHaRmIWJaFlbSGQWIwErEb+chddU+hM1iHMyBEenYfINSqSoNNz1V5KYWus9lS/Tc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR06MB7972
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

Hi BALATON

>
> Subject: RE: [PATCH v3 01/17] hw/usb/hcd-ehci: Remove unused EHCIfstn
> structure and dead code
>=20
> On Fri, 17 Apr 2026, Jamin Lin wrote:
> > Hi all,
> >
> >> Subject: RE: [PATCH v3 01/17] hw/usb/hcd-ehci: Remove unused EHCIfstn
> >> structure and dead code
> >>
> >> Hi all,
> >>
> >>> Subject: Re: [PATCH v3 01/17] hw/usb/hcd-ehci: Remove unused
> >>> EHCIfstn structure and dead code
> >>>
> >>> On Thu, 16 Apr 2026, Jamin Lin wrote:
> >>>> The EHCIfstn structure, defined according to EHCI spec section 3.7,
> >>>> is currently unused in the EHCI implementation. Remove it to reduce
> >>>> unused code and improve maintainability.
> >>>>
> >>>> Additionally, drop a block of disabled (#if 0) code in
> >>>> ehci_state_advqueue() that was never implemented. This code path is
> >>>> incomplete and has no functional impact.
> >>>>
> >>>> No functional change.
> >>>>
> >>>> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> >>>> ---
> >>>> hw/usb/hcd-ehci.h |  7 -------
> >>>> hw/usb/hcd-ehci.c | 11 -----------
> >>>> 2 files changed, 18 deletions(-)
> >>>>
> >>>> diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h index
> >>>> 0ae8c06331..3aec0e047c 100644
> >>>> --- a/hw/usb/hcd-ehci.h
> >>>> +++ b/hw/usb/hcd-ehci.h
> >>>> @@ -202,13 +202,6 @@ typedef struct EHCIqh {
> >>>> #define BUFPTR_SBYTES_SH              5
> >>>> } EHCIqh;
> >>>>
> >>>> -/*  EHCI spec version 1.0 Section 3.7
> >>>> - */
> >>>> -typedef struct EHCIfstn {
> >>>> -    uint32_t next;                    /* Standard next link pointer
> >> */
> >>>> -    uint32_t backptr;                 /* Standard next link pointer
> */
> >>>> -} EHCIfstn;
> >>>> -
> >>>> enum async_state {
> >>>>     EHCI_ASYNC_NONE =3D 0,
> >>>>     EHCI_ASYNC_INITIALIZED,
> >>>> diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c index
> >>>> 57f930b099..5ea8461f70 100644
> >>>> --- a/hw/usb/hcd-ehci.c
> >>>> +++ b/hw/usb/hcd-ehci.c
> >>>> @@ -1756,17 +1756,6 @@ static int ehci_state_fetchsitd(EHCIState
> >>>> *ehci, int async)
> >>>> /* Section 4.10.2 - paragraph 3 */
> >>>> static int ehci_state_advqueue(EHCIQueue *q) { -#if 0
> >>>> -    /* TO-DO: 4.10.2 - paragraph 2
> >>>> -     * if I-bit is set to 1 and QH is not active
> >>>> -     * go to horizontal QH
> >>>> -     */
> >>>
> >>> Is it worth to keep the comment in case it's still valid to remind
> >>> we have something missing here?
> >>>
> >>> Regards,
> >>> BALATON Zoltan
> >>>
> >>
> >> If we decide to keep these comments as reminders for unimplemented
> >> parts, please let me know. I will resend the patch series and drop thi=
s patch.
> >>
> >> Thanks,
> >> Jamin
> >>
> >
> > Another approach:
> > We can remove the #if 0 dead code and keep only the comments as a
> reminder that this part is not yet implemented.
> >
> > Ex:
> > --- a/hw/usb/hcd-ehci.c
> > +++ b/hw/usb/hcd-ehci.c
> > @@ -1756,16 +1756,10 @@ static int ehci_state_fetchsitd(EHCIState
> > *ehci, int async)
> > /* Section 4.10.2 - paragraph 3 */
> > static int ehci_state_advqueue(EHCIQueue *q) { -#if 0
> >     /* TO-DO: 4.10.2 - paragraph 2
> >      * if I-bit is set to 1 and QH is not active
> >      * go to horizontal QH
> >      */
> > -    if (I-bit set) {
> > -        ehci_set_state(ehci, async, EST_HORIZONTALQH);
> > -        goto out;
> > -    }
> >
> > Thanks,
> > Jamin
>=20
> That's what I meant to leave the comment but OK the remove ineffective co=
de.
Thanks for the suggestion.
Will do.
Jamin
>=20
> Regards,
> BALATON Zoltan

