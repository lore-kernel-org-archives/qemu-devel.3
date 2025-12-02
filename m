Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80E86CFD376
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 11:10:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQOGh-0004La-Tf; Tue, 02 Dec 2025 06:10:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vQOGd-0004FG-T3
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 06:09:59 -0500
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vQOGb-0003oE-IY
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 06:09:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R4HjOtCfoS6bzyY+QpYVjSZgaoI90jCN1A74x4HoLG5KEVdSdaLkd/d/EkJjmwSs+07s3vjUP5wWngWDyha9pbJVO1A9EM3D5MwF7971vREDZ7+JRVFDgdjFJO4pUnis82XiI0vbC5jyD76qwGuH/esbMtdpvZ45zXUi4DBYu5gkjgQCRzJXA1mfj5xo8qRmtJBk/n61BWbHxq10QpzxiHaBztpq8jvjKPrRScq3fMSxACDBwVKM0WOIm8r4TDlsvgAP1cwkVEKcIRK+7MMFGF1YAEhHvjTZj4MZi5fvq5ZauU2t2M0S0taIbDQL6/X1qO2LAjKFXmSOkbEvyOd5sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pbeSlsUvA7myMMa+6daYbvA/QjO24hZxeKjKSFHH+jo=;
 b=AQUg0qux3bCOsCEPyimpMJqk+glviZtI3KMV/WPqIIhjYxiKyF026hbr9VDTafU+ou4RhZku0Zjqy3Geu+Lq8wgVZ6oDz9OD7akIiJbyBGGf0R2wbfrbZFk3peg7rbTqpI66rCABeZsr3KPFPW4KV8p8Ipus+I4rCcJeBMwibTUN7D9Z9wbfAtOrXdh7zkx+kHhbpgLT36n/WnGlDVO1P1J2BUvGVq0OhSXbk2mvSQmyH11D1kffWvYR0XIiE6pokl/l7dchh0m7qcKitx7+Cw/RzYZj4Bedah59t/1mpY3pzDwOoEuLEfBAujb8I+L4A974fXPD1F/EGf6Yw2c3vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pbeSlsUvA7myMMa+6daYbvA/QjO24hZxeKjKSFHH+jo=;
 b=CfPjuNPCjVRXiBxq1j7HBgaJhc92qaQU9/nJWU3pDfMte9d2MtFCO8lwSRQChbL+OK0ofdlc2J15OsvXpc7nAuIbSW6l8VU1liBmX4kOfIgoFKuxfc/GsQXlXTD06dw82gZSoEnbpqVJeigVghxkiEGPLjk3jKFngrDkx6ys1D1Wz4j1UD4gfGzOBRkXMlIBynbvVGnMxiLrzQo/vRVSqQoNnbHL50nefsQbKxBP4NpnwnTgiIaMeFabqbtoEGHnICYHaufmIIotmOjOrA6zuSsbqlTgHt8q1aBYpz/dVMOmlO+fQCHyPEY3XxA8M6vi3W30fnwLQ78aD8gczZlHkw==
Received: from AM9PR04MB8487.eurprd04.prod.outlook.com (2603:10a6:20b:41a::6)
 by AS1PR04MB9583.eurprd04.prod.outlook.com (2603:10a6:20b:472::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 11:09:52 +0000
Received: from AM9PR04MB8487.eurprd04.prod.outlook.com
 ([fe80::1e08:e81f:d29:e1da]) by AM9PR04MB8487.eurprd04.prod.outlook.com
 ([fe80::1e08:e81f:d29:e1da%4]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 11:09:51 +0000
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>
Subject: RE: [EXT] Re: [PATCHv3 01/13] hw/arm: Add the i.MX 8MM EVK(Evaluation
 Kit) board
Thread-Topic: [EXT] Re: [PATCHv3 01/13] hw/arm: Add the i.MX 8MM
 EVK(Evaluation Kit) board
Thread-Index: AQHcWVR8vg+OgN6fY0K/4kkQkn7INbUOMgyAgAACORCAAArJgIAABlBA
Date: Tue, 2 Dec 2025 11:09:51 +0000
Message-ID: <AM9PR04MB84879B6DBD813146CD28208587D8A@AM9PR04MB8487.eurprd04.prod.outlook.com>
References: <20251119130027.3312971-1-gaurav.sharma_7@nxp.com>
 <20251119130027.3312971-2-gaurav.sharma_7@nxp.com>
 <CAFEAcA8pb6cJ0h+L=fsE28HYpgkC2BWrT=kcwgVxCazJMPMy+A@mail.gmail.com>
 <AM9PR04MB848728E3D09323B636E7D54387D8A@AM9PR04MB8487.eurprd04.prod.outlook.com>
 <CAFEAcA-1MJ5oDVihy1Uo-bv5FUtCF_xPaS9oSoDtrnGsWe-2wg@mail.gmail.com>
In-Reply-To: <CAFEAcA-1MJ5oDVihy1Uo-bv5FUtCF_xPaS9oSoDtrnGsWe-2wg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8487:EE_|AS1PR04MB9583:EE_
x-ms-office365-filtering-correlation-id: b99f0435-1fe6-4ac4-7846-08de3193509f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|366016|1800799024|376014|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?j7HlN/PHEgkqEY00KwjnvTBCHmGd3uSAYX4dDBXt5J0Ua/S16tZyci8pLYMz?=
 =?us-ascii?Q?r5ZbRhn0amsmNQWdL0zUsS1oZEy7iaILJg8UNFjmfwboKjSxT2AkPOxoburH?=
 =?us-ascii?Q?dZsJbu3+NWOAtXqB+p2BsbrKQIh2NuD/SaCMEBASG9zbbdy2idLHToLOKFd1?=
 =?us-ascii?Q?8eMNBU6kst8T5FxOFEXPdcklUDRtzaOK10BoQgse9E0+RQVfrSWURva5lFln?=
 =?us-ascii?Q?ujEuaVX8CfFzQFdsyXQsaNUxmy5N3joSpaC+76sy24A/c0P8clZ97L7MF9Yf?=
 =?us-ascii?Q?VUJjULtqwHCXksyC1AK31NOok17ZytNS08AZwMeXImnI+RzdcHMVNhx6JSb5?=
 =?us-ascii?Q?lWpxLDlDh+rAkhqqfrcvSGBiwoHMLt9KT32KnvJ7RQhpO7cfojGVbRK3CG93?=
 =?us-ascii?Q?gKprD+JGFK0MqRO7LSlx9ukCFKtvi+ObXBJByfOTtUK80YOwyFTi/gqoaBxZ?=
 =?us-ascii?Q?GF7EkYTLkKw7navtPZRBSl4hLSdHkTtYDzmvKoHnjgjzqH0znX+FGluT31oz?=
 =?us-ascii?Q?pyFEDMJw99SUFwIgYzM94dYtE248xeP3XYPE6VfKvAyFcGa2NMBAa/Q2lqPE?=
 =?us-ascii?Q?/LTNAi15aUM+TN/0hwJsT/AmjlUWFnbtrOF21oqUiF4vAGiDPXFr0D5iJT+3?=
 =?us-ascii?Q?inS3JO+rELTA1TeHnQktl1rxTbPVjK4IlcDvfHFL3pY+wbCLP9dI9Icvu5sG?=
 =?us-ascii?Q?uDQtwJPqnWB0P8RCNTVFOpI9dcH9yIgR1LBWCaao7QxEdvCAmdduJ32ybVOv?=
 =?us-ascii?Q?UCN4XzhihbnKdluGa+HJgYTO69HLx/F8K1hOYu3at6Vm7ol/PBEGUYLHdWAN?=
 =?us-ascii?Q?djzW2DM0Uu7MnBLhwU1NcAdzC+keILDLcKRaNaqk7Dvyslm33hdCwbeOhqX8?=
 =?us-ascii?Q?ZSBdBlgwVeNZW5ga2/+8NKKfHCxOkKfUsRTmE0OcyRTC+Ii//PUMwMprMDWH?=
 =?us-ascii?Q?6p7FNWoQxfSNAJf/oF5puQqU8dmdLScM2mGj0VbdzhXM56OvJYqhdIuqc1Jo?=
 =?us-ascii?Q?5G5rlvtjcg8QExrWQsKjQBHjHZAuo9lCFE7tb3D+SyT7+xsVlbY2SMvkXT7q?=
 =?us-ascii?Q?zVQXbRn4dRa0M39g9Holvl1dmir25kit7CG80taU6iu0S1WhS3AgFJOfZfY0?=
 =?us-ascii?Q?dOL1PnnFhA+bcAh13NpQrzvxY8sD2+31rD+HK7LDhagVlezAVXC1nof+5fGF?=
 =?us-ascii?Q?s5hp88uLbuFHxfwjrozhfcZU2SWuy1a0oqHnzVy0EaS8ScR+CL0KjTLCkVyk?=
 =?us-ascii?Q?oxBxeOKyMC6tm3fiMAYPzZx9lwkJIjPUPYe+rTCqSZtkajRueO2LEY3dStx1?=
 =?us-ascii?Q?gJq3N+x9rPbuBoYODloJDAyWiAZql0HoCbIJwEFByeu8xjtCLyjZav3NnjoX?=
 =?us-ascii?Q?yGrdnCYq2yYjv4t1TS+b6ISVu9v0wJFBIQvlXYV8gw2KKhppNel6QLjKFou+?=
 =?us-ascii?Q?Rf8dMR7oHg0m+uA4DDyyEaeYdmIFV+vty7Wg6xxpyGITtNvi5tm6pg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8487.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zTlxp4Eo7jWRZ7UVPd8L5SgYMt3pdTA2KlICm3VSkX7Eg9THEIWU6K09BlY6?=
 =?us-ascii?Q?Am2hdBeMHMWrtOuPcq3hhpWzXkyIgpd0L1PBMFpEORNxZfxN1PJOR+8m6WF5?=
 =?us-ascii?Q?7f+saQatNkhwqydLKgxM41j6sITu0vVBPRXn2x5f/YJWFJkljkMPUjcgaedZ?=
 =?us-ascii?Q?diU7RrBYuPZXZmaaVhwWcssnw81HcvormH1o9sU5cipWVC3/dz8TbS1cfJnj?=
 =?us-ascii?Q?/cF/1zPkQpfpp3aAMooD2LC0QZQvCq6616/K6drc9jPnk8hegsuqo2/evLP9?=
 =?us-ascii?Q?9Wq9IOspo0t+2a2qco/PLyerdQfHUF8TyVHiN3TRGMFdOx0dkiTsO9FYmjlr?=
 =?us-ascii?Q?aM0sXKMH0BFr33Dr43J7XmyaxDCyKYPpXwsB4jEwidFCwKU202HxJekJsE4i?=
 =?us-ascii?Q?75kpnMHjocRfQk5ZS52y9OXzclgbVC9+5KLYcS1U3DVN8QwwCuitUliaXVvh?=
 =?us-ascii?Q?K4tYw/Bl9WWEMgwVBmTlSJM7b8Pg0tQ7H1HwyBnxGITqvm8um8dE7DLb8DgI?=
 =?us-ascii?Q?xux/SwCMEkC1iHaF9TsmU1APnhCKteKdX7u/Kil0lh/toCKJTyGCr4FL4xW4?=
 =?us-ascii?Q?pVt3/YcFJ7Xh10iQmWA6s1frFYUZQQUuz+98py4en5L1Qioy8ZlcdaJaTiyp?=
 =?us-ascii?Q?7XulRLpwewG1ps0JnAEfkWMBiRavRsg97MFn13VGLM33smR2raRCPeaUoKTI?=
 =?us-ascii?Q?KztmemxvqgT96ovAbee33o0gQUeqwJPu9cUoZPoF+mssSLVgdihA2u/vEgGo?=
 =?us-ascii?Q?E0WSoWYpKveDLA5QuH/J9ubzLGWi47701LUhbtpv5yJ6oWvwkdvQprGAm5jN?=
 =?us-ascii?Q?ep8DDU+3P5vWAlmQQJOVuwAa+CPgpIEqIhVCUFUTAbxwbEz080FJPKzFWhkR?=
 =?us-ascii?Q?ibG3C2ybiiMAqV5kRIG0ShUpMkpV2DDidSTOS0IAduSA5qsUPRA7/dQy0sW7?=
 =?us-ascii?Q?2RarOIa4lL8+4A5RlmH6RjclOhO9BAiO6AS9YydGJwWIOQzQ6oLqXleEr/Xm?=
 =?us-ascii?Q?ezDUFWRpKSrTOzIiJExcPXYHutGiBC4R+HlTnaUXzmEf5uc2QC8h6h0Gd7ig?=
 =?us-ascii?Q?yA/mRdiw6sXi1qReh1GDFEI7uEKhtLmXb66c9KsqvIghNNcfNkT96Q+1FNK0?=
 =?us-ascii?Q?H+xSAG8kTHa4tvTsMN+Y9me9bWfJ6pW2XC+SoOtnbhKsgOLJc60PYFX/eFsz?=
 =?us-ascii?Q?4OuGSpIEDZcJx7TMjAdUEOqNF+wRIZ9zpFQo8g+lAb5L12/AK+Kok1S4YhG6?=
 =?us-ascii?Q?1N7eKI9iHgWEaXmteEhq92qnyq0frEsSD4ob5nEqt03LVN+1vJJm2QeWP4KX?=
 =?us-ascii?Q?Pfu9tkQH26MkYs39wglmLcfEAIO/+5+4hPQHjiZ9yyR0otL051rX5pWW95Wa?=
 =?us-ascii?Q?6V/365mKv8pNQUgQihSO9YdaOKSAesHVfsB/N7k8MUJetZMqapzikRiYVWCy?=
 =?us-ascii?Q?5R5nUboVyJ7BulTg6xgnfiKNwKyIAPVJTWZZpVe3a0fZ8+RlKSxO+4qgSFaL?=
 =?us-ascii?Q?h5ImJ3yt1oax/Tx/PMrmUSV3nTzOEdRia/mmBuh+wsGAOAZyIGJE/5ZMQVYi?=
 =?us-ascii?Q?Xfz410jqnWeGutoD9wPdx588G8R3AKAeX85HCxb4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8487.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b99f0435-1fe6-4ac4-7846-08de3193509f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2025 11:09:51.5279 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QsedCWnESypPdOAW1aEXRNK+r0A+KXb7wuxlioieOEuSWuUTBJBB0jS3sEWbtFUuTzVX/rDVSFaRjrcwYcx07Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9583
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
> Sent: 02 December 2025 16:16
> To: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> Cc: qemu-devel@nongnu.org; pbonzini@redhat.com
> Subject: Re: [EXT] Re: [PATCHv3 01/13] hw/arm: Add the i.MX 8MM
> EVK(Evaluation Kit) board
>
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>
>
> On Tue, 2 Dec 2025 at 10:33, Gaurav Sharma <gaurav.sharma_7@nxp.com>
> wrote:
> >
> >
> >
> > > -----Original Message-----
> > > From: Peter Maydell <peter.maydell@linaro.org>
> > > Sent: 02 December 2025 15:30
> > > To: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> > > Cc: qemu-devel@nongnu.org; pbonzini@redhat.com
> > > Subject: [EXT] Re: [PATCHv3 01/13] hw/arm: Add the i.MX 8MM
> > > EVK(Evaluation Kit) board
> > >
> > > Caution: This is an external email. Please take care when clicking
> > > links or opening attachments. When in doubt, report the message
> > > using the 'Report this email' button
> > >
> > >
> > > On Wed, 19 Nov 2025 at 13:00, Gaurav Sharma
> > > <gaurav.sharma_7@nxp.com>
> > > wrote:
> > > >
> > > > Implemented CPUs, RAM, UARTs and Interrupt Controller Other
> > > > peripherals are represented as TYPE_UNIMPLEMENTED_DEVICE
> Complete
> > > > memory map of the SoC is provided.
> > > >
> > > > Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> > > > ---
> > > >  docs/system/arm/imx8mm-evk.rst |  68 ++++++
> > > >  docs/system/target-arm.rst     |   1 +
> > > >  hw/arm/Kconfig                 |  12 ++
> > > >  hw/arm/fsl-imx8mm.c            | 363
> +++++++++++++++++++++++++++++++++
> > > >  hw/arm/imx8mm-evk.c            | 109 ++++++++++
> > > >  hw/arm/meson.build             |   2 +
> > > >  include/hw/arm/fsl-imx8mm.h    | 156 ++++++++++++++
> > >
> > > Could you also add a section to MAINTAINERS for this new board, pleas=
e?
> >
> > I was going through this
> https://www.q/
> emu.org%2Fdocs%2Fmaster%2Fdevel%2Fmaintainers.html&data=3D05%7C02%
> 7Cgaurav.sharma_7%40nxp.com%7C78fd8b65fb3546c9714e08de31900661%7
> C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C639002691828235135
> %7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAu
> MDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%
> 7C%7C&sdata=3DJ2Xk9jxc1zm84042UrNGYjmprPKTB7tuX%2BcRDOZWwOc%3D
> &reserved=3D0. It implies that the contributors are generally people who =
have
> been actively contributing to the community for a while. Since this is my=
 first
> contribution to the community, whose name will go up as a Maintainer ?
>
> Mostly what we want here is that there's a section in the MAINTAINERS fil=
e so
> the new source files for this board get listed. It's more about ensuring =
the
> right people get cc'd for reviewing future patches than anything else:
> for Arm boards I do the "collect the patches up and send pull requests" p=
art.
> For this you can list yourself with either an M: or R: tag, as you prefer=
.  Include
> the
> "L: qemu-arm@nongnu.org" line also, and some S: tag.

Got it. Will update.

