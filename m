Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FEFCCFD376
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 09:33:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQMkE-000127-4i; Tue, 02 Dec 2025 04:32:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vQMkC-00011k-MN
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 04:32:24 -0500
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vQMkB-0002Io-0t
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 04:32:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j3ZQFD9484GVPfUMItkxiCqaBZ40IWEfbx2ioZ22q5seaHcdM/Vmrfgfz711VP+vk5En5wHsNCyGz6rEnDkw2edTWOeH4KH8FZEdAoE2E/a65Asb5zFNLuf9asHX+J3r0UvW2PDzAK4yswPhciSGHwgUZDKtMO6Ztb1KgWTn2YcHgvjmyj46HN85FNuexY2lRNgSSiGLkWP+oi7DDUC6kaccr/GdrObqP1AAFiXrSySF3G/gHSNvOHL9AQfIf1t+WedKTUUDcE6JJybWCtBInsg4j1g2cW1crwY4bcqXOVklSseSfXEkG04cbp1KtxEBBxOtV+yFamTIEyHQjbuH7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fw0so+y/F8gTvHpFHRlx3hsTuus8vRxPCBQJUlckRP0=;
 b=Y9aQ1dqJiOW7JIP1HBYP3VE85cbORfVPCH+Tiy+Hg3/9yKF6wDKpdyEEuPoDRiHSD3aTibm5LCv3p405b20aJ5dldfQmC8K1iQhPOyXv031s9wtJrbWIGrZNpjkdj6EJJqrnILBu1IMou/WbrsPt8pGpSiXysTubus1nnkEa5swTsWYEqpXSG9FBoIw3/I3hCWLX4A1ZidrLiYkCqPywvmqKyK4DjK9aWSVB4LZSrTsp/8AOE6zyZJghQm2B04dm4Zb+C+zWllDmG44x4Y7SUuz5k+6CjZSxl/ede4aAJJqa3SXByiLwRyCjd3SQbvtuayTlyRtWX6ILT3KsP9UBdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fw0so+y/F8gTvHpFHRlx3hsTuus8vRxPCBQJUlckRP0=;
 b=FSwGu+2qTrT3vMnOyAvrEyYMo7ZsIMnjdTx9TKsGFBxkMybLtFZ/wr4hBHfok3jfnAG4ywW/3mFEtk1Gzmu0n0SHSpHuEKuie7VisIePReKVl+iTzs5TLM4RnEUMjjE1lb9OBpf8Qwq8Pc+dogy7VenBPI/fHUmr1sa4df7RZ8NnmXJBofaaWutnXxDe/4kp7fNZkyOswQi+recv8WyrDegYCqMRQkb+ZigL2WdJUuNyyJKiUejCiu6BoNNj9xstpzLhDPDD5T3j6Ug06nSYcNHLLgF+ErRtAA9lzf51lfLzk/BcDQTSeKbRMhEjc2eGQ3Q3zKRSF0nxED+6BXI8mw==
Received: from AM9PR04MB8487.eurprd04.prod.outlook.com (2603:10a6:20b:41a::6)
 by PAXPR04MB9092.eurprd04.prod.outlook.com (2603:10a6:102:22a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 09:32:18 +0000
Received: from AM9PR04MB8487.eurprd04.prod.outlook.com
 ([fe80::1e08:e81f:d29:e1da]) by AM9PR04MB8487.eurprd04.prod.outlook.com
 ([fe80::1e08:e81f:d29:e1da%4]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 09:32:18 +0000
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>
Subject: RE: [EXT] Re: [PATCHv3 02/13] hw/arm/fsl-imx8mm: Implemented
 CCM(Clock Control Module) and Analog IP
Thread-Topic: [EXT] Re: [PATCHv3 02/13] hw/arm/fsl-imx8mm: Implemented
 CCM(Clock Control Module) and Analog IP
Thread-Index: AQHcWVR9T1b/BkRBy0eoF9vYyCuEa7UNVhcAgACZsrA=
Date: Tue, 2 Dec 2025 09:32:18 +0000
Message-ID: <AM9PR04MB84879F8FB1F3E1AE26F784F887D8A@AM9PR04MB8487.eurprd04.prod.outlook.com>
References: <20251119130027.3312971-1-gaurav.sharma_7@nxp.com>
 <20251119130027.3312971-3-gaurav.sharma_7@nxp.com>
 <CAFEAcA8WHgKtPPVQKNSRV2R5xVPCZ3vNxQgy9rcVu=ECrxNE2Q@mail.gmail.com>
In-Reply-To: <CAFEAcA8WHgKtPPVQKNSRV2R5xVPCZ3vNxQgy9rcVu=ECrxNE2Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8487:EE_|PAXPR04MB9092:EE_
x-ms-office365-filtering-correlation-id: bf19a186-7364-4eb1-3d6e-08de3185afe9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|376014|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?e/iYXJalfGH7rwG/UzAV1WOYBM2kea7IeBDh8G5lBNhdpyYGgH9bFlEwuxVe?=
 =?us-ascii?Q?ZpCuVq7dEQhfGoge3JYgynAyoOP77h1vSkeuvj7ne/DO0Xpz9qVM6r2agfCV?=
 =?us-ascii?Q?H79aECouI0buXco8ZxZkBj4rvH/JGQUGwDdHDiy+GkNa8H3z/Qqf4BwNd5Sx?=
 =?us-ascii?Q?LdYGeiDnNpufJt6CqtqYSnY0gYjgyuzxBXlDX62Idt7PS8DOj3eaFr6zkOaN?=
 =?us-ascii?Q?Foju81uQFI39r/ibaD1psC15KFYs1CDFTwc31sFhQxHpu1Q4ThLKHzhmMovP?=
 =?us-ascii?Q?IqOtKE7JrphWMH97ULLTd5PGqRylVYkGEyUleRA5EEOi6rf5Wg2tL7q5m1x1?=
 =?us-ascii?Q?m+R+yFXg00DWALjKyHylOFcxu1kA9UAQhCkHLBPls02BPYQVuWQyLIShbnnu?=
 =?us-ascii?Q?tpd2BcFjMShiAnyfmf/cksjoNTYqWnlhY44fZunlIUOs3fvp5tHOBbHqpnfZ?=
 =?us-ascii?Q?rGEdJIKo1BNNIYRm8DEezhn7cRwMXs+qKxACGPIWcssz2q14B++/R3WLcHIq?=
 =?us-ascii?Q?O84CvVJS7LsdPMWXe2HLUyrq5lbr1HptjGs8kSX/nNW6VJeYVAiW1fYaBYPF?=
 =?us-ascii?Q?G/Y/7xt92BVvjwf95rYLLXrd6I7ECXCfA4kKO9kKdvTYdgzTsQrvOwwBihV/?=
 =?us-ascii?Q?2rcPs1gtb/iTEOLEQpqL6Hzd2Sg/16Y/tWBQZxxchihe7h1/kyi+z6BBXn5f?=
 =?us-ascii?Q?TNPG4eVcUvBoQ3gAKjEmlrJLAYAbSj9dPVZjpejO6NOOoq9MJW1Di72LaUAo?=
 =?us-ascii?Q?JFOTWtAfGRSg/iJh5AthHaVOQbg7z/pfIma7hpG78T3d8us3J/0aqo9fXoNT?=
 =?us-ascii?Q?Bs/yOGnnWpxzxF6MtVf4bHQ2poWMPfHGpp5RcBI42P+MTqE9VjTQOGRbBJm4?=
 =?us-ascii?Q?07QFajqzlVvogH6CGNvNKc26zfWni4n38J0V+0MmuvaGSrNFD1gtT1mV+ar3?=
 =?us-ascii?Q?RXRzzgLXdIiGK/kKaa85I3Gxt5jpsL3/ZOk/4AT65cNwQ8YJn+vTywzZwNec?=
 =?us-ascii?Q?PAcCEiES2wyPaE951oylf8Dr8FrPdDxPG2L8pxqZsstpyBcseQeG1XlUes+X?=
 =?us-ascii?Q?XA7KgC3b6ZaHPvYZ+VY0K62oMhUUfPJ+aFlsTdWiaPntWuTHCkdq+KebR6ZA?=
 =?us-ascii?Q?8etPlGlD+n380464fUhZbgEQ3a/BsR8dMALr09IUwbB3/OLWv0OiIwvkuTci?=
 =?us-ascii?Q?XWvPE+/y2CjU+HABHLaIvEEQMybPLPKO3uSD8SZVXXiDZaz+9EmNR4kZLl6t?=
 =?us-ascii?Q?J+Q86jksT8AUrhj2VsI/pfP9n5vC1trIe+YDMe/C3tLaXnorUTKNOJU2NZU3?=
 =?us-ascii?Q?V1J7TLx03rHVkzSKpa9VQ/jTMfQrN/VAwotn/4qZ+IISvAdjIPQWTyMIhfLA?=
 =?us-ascii?Q?SHkwUaHfMpiavoXi61cDQoj/7F0ysT2/+2lLeTeyzPvaBucKFlGpBKVOffGa?=
 =?us-ascii?Q?sZEoAfHbQFCR7d3zqDA8GjzKUHkloOnzyCo9jCzLws1Q14nIvtTWzBupIVBb?=
 =?us-ascii?Q?KLjP4lAij+4eBd/ellaYivT4N5vArpbB2mPO?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8487.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fqtkS3bNYIfO5JbSUH39+L29gYlMvoJ6eOObYNLwEeS5kawV+QXzukKi2wDN?=
 =?us-ascii?Q?rbhccHhyhJ/oyXKW4fBdMtiGukQrq8+R7/JVQSYM9T+Q0ZlmKXi3f8oi/LiR?=
 =?us-ascii?Q?OQWG2XTNeTN/4N65bJSwJmfkFN51d7XHajrKs0dBKeKNT8nDA9Zawy/0M74/?=
 =?us-ascii?Q?52c6lNK2cAohlDFQwxgKaBgKkYk8ri/MTenE8Yv8KOYqkjyPPvQGG9M6YGoO?=
 =?us-ascii?Q?urjP1GPHH0xer/WFYpRmE8+CHYFzdP65QAOTwpsIM/JG5x0Q0vJhYb692qXG?=
 =?us-ascii?Q?UI5nTqJWBVAglxLnVkTuzqTQtC++hGCjzSlPFkNExa0QYkWaLlmT7oHmBOuT?=
 =?us-ascii?Q?aC0fWN5PZO/IXyxIsuieTknW4l2jZiYODhwlB1kGeFJt6Ef9nLZK7at0pXl4?=
 =?us-ascii?Q?Z8mcPC6ZYHyHxKK46cexpnjUhEdMGtxwwSyHTWUtGIl9M2yGBmrn8uAzSYGu?=
 =?us-ascii?Q?l+FuEmnxFwzuABVJ6A/zTONAYLqamemEyVzWgyxjmTBUpCoYLp9krFTZTSZi?=
 =?us-ascii?Q?FeWNj8v0lSjv5iFJp85Q6fvIqkqihOQL5oSuBIVGx4JP89f980SNxXAknrHf?=
 =?us-ascii?Q?l+QD4eHaFEOEC56d3qk2vglh7T8ceucWzVUqbwopguDBLuBAyqEWkCebuoAC?=
 =?us-ascii?Q?KNLjHpSpdeP96AXbOoG26/ImpAgtC6Q9E6B5+GDicGiYGI0E/bV7NdnOXJbu?=
 =?us-ascii?Q?vkE9kByPQHK77sJIM64z9QBJaF5cXNaj4xzh9cvZ27SygMHr1+GToU7UWOaH?=
 =?us-ascii?Q?eER+e8Yb6RbO32Kvf7YSDd6RxTHDl3qgkEW4eZK3r4f31FWssVA3jtNmE4gy?=
 =?us-ascii?Q?bbhjMQ2mLnXQ5wVOXV8ooC+OmsJdpMxzBY05W5yur8Qo1PS78cgtPSjxOPqe?=
 =?us-ascii?Q?99Gdmdtd6vU/D+dWVOvAU3WeufIcO1TK1DDOB5uqeOEJ6yKW47LInqYO9bGs?=
 =?us-ascii?Q?rLvMULuT+pVHfnQRgLDADc74OWFgEMvRDC5xPoeZzeRpHe4sbTkMCA9yKC8B?=
 =?us-ascii?Q?31OEIULs63nXNVYpELmC46QbdSlpE8kwwXcH+UYzJhyg2LS783CzcRJw6aWs?=
 =?us-ascii?Q?ngFbngMiCi/U9otgUbN5vbYTVj657kdLnyX/J+IFpt9O4BmJZ9kffBGvaMSq?=
 =?us-ascii?Q?3+aOg8Reynr+B2bmJq5yYrkSkiwm+/YMyu9Ss7bWoWndJ7xfb/eXVq3HD70E?=
 =?us-ascii?Q?PUTt442hA43zLcRr1pFF4o8VMAQglTKQRSaHlYgd8z8Z6Ktm4U8mPECQsNqt?=
 =?us-ascii?Q?+D0iD/dp9RetA2/BnjdaePXeMgl74brvQ80WYEFAm5fk+HX0k1btnMwjYfIs?=
 =?us-ascii?Q?cS97Z5uwDuGmqAkdoNG44ggUuAGSuC/S1L3nUHYC1oxvIGoyOviBXsA9gT9D?=
 =?us-ascii?Q?K0Eor2Gl7QRQWYQONEDuWRtrERl9r/ShMvNNSemNTjG2Fg0KwYYS1yJtETi2?=
 =?us-ascii?Q?AuVujQMxrIYM0n+1/ZXPiYA9YrHQQef4rUSvWz1SFY87KGx7YkceOdaQfRJv?=
 =?us-ascii?Q?GrOgxntXS1LfH2MUa26UKbSErwPImXi5xEQ55xsKUZs7jZvRTwh6A1XtgdIr?=
 =?us-ascii?Q?AQSRDFrywYJbkTOV43qAW8/KyfwivaQcSpF9WUfr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8487.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf19a186-7364-4eb1-3d6e-08de3185afe9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2025 09:32:18.4515 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wZhOaxyHI/sNsaRilvNsWkK5uukL4KtEQvAr6z6F/bm5hmV6eykOAQ05gOJBGSO/qU0Rt+eqQUYZy36q3/E2CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9092
Received-SPF: permerror client-ip=2a01:111:f403:c207::3;
 envelope-from=gaurav.sharma_7@nxp.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



> -----Original Message-----
> From: Peter Maydell <peter.maydell@linaro.org>
> Sent: 02 December 2025 02:22
> To: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> Cc: qemu-devel@nongnu.org; pbonzini@redhat.com
> Subject: [EXT] Re: [PATCHv3 02/13] hw/arm/fsl-imx8mm: Implemented
> CCM(Clock Control Module) and Analog IP
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On Wed, 19 Nov 2025 at 13:00, Gaurav Sharma <gaurav.sharma_7@nxp.com>
> wrote:
> >
> > Implemented Analog device model
> > Implemented CCM device model
> >
> > Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
>=20
> Can I ask you to split this one up a bit more, please? Where we add a new
> device, this should be two patches:
>  (1) implement the new device
>  (2) add the device to the relevant SoC or board
>=20
> In this case we have two distinct devices, so unless there's some reason =
I
> missed they should be separate patches, which would make 4 in total.
>=20
> But: why do we need a new imx8mm_ccm device ? I did a diff against our
> existing imx8mp_ccm source files, and unless I missed something, they're
> exactly identical apart from changing function names etc from 'mp' to 'mm=
'.
> Can we just use the existing device we have ?

Yes, my original plan was to somehow derive it from the existing imx8mp sou=
rce to avoid code duplication. But I wasn't sure about it because of some C=
CM differences between imx8mm vs imx8mp, 8MP has additional PLLs for HDMI, =
Audio, Video. Also, 8MP adds clocks for ISP,NPU, Media Block control[which =
is missing in iMX8MM].=20
We can very well use the existing device that we have.

> The analog devices also look very similar. In this case there is a tiny d=
ifference
> in the ANALOG_ARM_PLL_FDIV_CTL0 value.
> But unless we expect these devices to diverge a lot in functionality we h=
aven't
> yet implemented, this kind of "almost the same device with minor tweaks" =
is
> better done by some other method than "copy and paste the source for the
> entire device". A couple of options:
>=20
>  * you can have an abstract base class, which the different
>    variants inherit from, with the shared functionality in
>    the base class. hw/char/stm32l4x5_usart.c is an example.
>=20
>  * you can have one device, with some properties that the
>    SoC sets to configure it. hw/misc/mps2-scc.c is an
>    example of this, with uint32 properties for some config
>    and ID register reset values.
>=20
>  * you can have one device, with a single property for
>    "revision of this h/w" which then drives several different
>    unrelated behaviour differences. hw/misc/iotkit-sectl.c
>    does this.
>=20
> Based on the differences I've seen here (i.e. only one register value is
> different), I would suggest the "uint32 properties for register reset val=
ues that
> differ" approach.
> But you might think one of the other options is more suitable based on be=
tter
> knowledge of the actual hardware than I have.

Apologies. I should have executed my earlier plan to maximise code re-use. =
Memory map of Analog and the reset values of the registers are almost ident=
ical. we should re-use the 8mp code. I will create another patch revision t=
hat=20
1. will have code-reuse of imx8mp CCM and Analog
2. will add a uint32 property 'arm_pll_fdiv_ctl0_reset' in imx8mp analog st=
ate struct. imx8mp analog class init will be setting it to its default rese=
t-value.  in fsl-imx8mm we will be overriding this default value with 8mm's=
 reset value.
3. Update the 8mm documentation mentioning the ccm and analog re-use

How does the above sound ?

One question regarding the patch splitting you proposed earlier- Now that w=
e are re-using ccm and analog of 8mp, will it be like 3 patches ? :-
1 patch that adds CCM device to 8mm in Kconfig
1 patch that adds Analog device to 8mm in Kconfig
1 patch that adds the property 'arm_pll_fdiv_ctl0_reset' in 8mp analog sour=
ce


Regards

