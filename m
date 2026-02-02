Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 898C3D172B0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 07:39:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmoW3-0006vY-Kq; Mon, 02 Feb 2026 02:38:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vmoW1-0006vA-8c
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 02:38:33 -0500
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vmoVw-0003L0-Ga
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 02:38:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lILH8bJmcmTG51z0bCVMEW9MAetG/SCOQTOeJ1ZvA1N0QWwhHv7W2MooPXsTJL/IeX1RACrFuOmXZExFtFen64B1ypNBIFR9aVpoZEvPbufwIASfM0CBv6KbgSb2miOHyIzP13nrXSBVvswqXqYgxKx0OT1lTYtNxEG1AQU/D943WyAK5Oh19mT8yYqtYQiOxyo2Vz6nxDh7di3yaILs0bnLbYnYosKcivcEvdaLnBm233uM9sKp07PEa9sbEMUBAtB47eMye8Iay7xF17cOU9KG2Zw04vJyxeDDaWx0Ju0vdgcpZb/0x6deWx4+z9xKSqaxcggcqKUXlVtMaeJIKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yIbAYFYjN2DGTlpKlvrH4Sv3qflbTu/UpvE0aW2q2Lo=;
 b=ug/ZC3W0oteM0sMxLkZETmWyzzEdwgJSery+Iw3gPqkzrKLDJBOp7XFZjufTqkp41M0ouU3yn9AxY8Bu4yaVNS81Wx8xrFCo42v0gFSlwBsj6H2XXnaB7oZYCXm5EgFbyhkSVy2+/oiTRYQ4YDlDRJxN9htN/tAYH4prtyQLc2zx18/ycjDAovAK0X6LuafAADLQq/LJkPN/FW5kJaO8HMjEfXTyBirIyfZUNY71mqvHXH0X1u7wPwItRDQmXLiiezg7MCPSsgX8qXoaQg9sv5pReJpYFggRHHeF7XKGz5DdRw5ik/zcsiKSzfeSi1mNWIVP+9PEBKuD89ZS2Ifubw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yIbAYFYjN2DGTlpKlvrH4Sv3qflbTu/UpvE0aW2q2Lo=;
 b=GdEIYRTDW2k6MXq3/yakMMHlu58edhirP8P13+5FBQLH086py48e0ZtkwWP+UX3un1nKoDQZgTri6DCQelvCxUtM7b2kMmMax+5tHKRMNwUviiQDmQZDy59CIjnx/o61pW05e0jpl3C9B2CC4v5Xv9SB2ON59Txq25AnmhHdfTJ8dYiLnIfGE0q4p5wDLwZW0ZECqZV2Y3MdNj4i0ngKfTpcgS2X2URplUBhQVeBis0JKy/NFrhMBBLYsIGvJet7r1XWJ+SFLDiiIlSVE1IlWQ54Js1DyP4hIDo8DLLg6p1DUHEU5C8FXV4uk5PcBi5cIUiJPC4CWLLzx86bP/xTHg==
Received: from AM9PR04MB8487.eurprd04.prod.outlook.com (2603:10a6:20b:41a::6)
 by GV2PR04MB11710.eurprd04.prod.outlook.com (2603:10a6:150:2d5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 07:38:22 +0000
Received: from AM9PR04MB8487.eurprd04.prod.outlook.com
 ([fe80::1e08:e81f:d29:e1da]) by AM9PR04MB8487.eurprd04.prod.outlook.com
 ([fe80::1e08:e81f:d29:e1da%4]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 07:38:22 +0000
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: Bernhard Beschow <shentey@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>
Subject: RE: [EXT] Re: [PATCHv4 15/15] hw/arm/fsl-imx8mm: Adding functional
 testing of iMX8MM emulation
Thread-Topic: [EXT] Re: [PATCHv4 15/15] hw/arm/fsl-imx8mm: Adding functional
 testing of iMX8MM emulation
Thread-Index: AQHcZalizFMuf1HmOEWlb+Y+jcskv7VOfKIAgCDlkhA=
Date: Mon, 2 Feb 2026 07:38:22 +0000
Message-ID: <AM9PR04MB84879F131D2BCF464F29265B879AA@AM9PR04MB8487.eurprd04.prod.outlook.com>
References: <20251205053819.2021772-1-gaurav.sharma_7@nxp.com>
 <20251205053819.2021772-16-gaurav.sharma_7@nxp.com>
 <58E2AC3A-C08B-4A97-93EE-96276DCD0C1B@gmail.com>
In-Reply-To: <58E2AC3A-C08B-4A97-93EE-96276DCD0C1B@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8487:EE_|GV2PR04MB11710:EE_
x-ms-office365-filtering-correlation-id: 86366d43-36ab-47cb-6674-08de622e0b14
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|376014|366016|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?1iw/mZeeBUA02HP25KcaB/TzkJu4YpM5RmC1p8wtnUcHffA/W1Qz3N9mmwEB?=
 =?us-ascii?Q?C04yft1viC5QApTDdWA8a3cdyeHVriw9ldU2REw/pipqka8iNvz3ZeUPVKmO?=
 =?us-ascii?Q?+o097nc37K2tJaKGvP+EtkQ/x4m9eEmjL8nl4/hXimdgirrWD6HKedSaiJP1?=
 =?us-ascii?Q?x+r+lGG/tDs5G5kmPAIOt5K5Pk76BtHs/BLu1B8EeLyG0IYJb/RoxPl+suL5?=
 =?us-ascii?Q?4wEk70FkIV4Q1cTWt4JwRDq1TTaAOSlGlHxXsMxYbJ/ceMkQmVWYSSUstKAA?=
 =?us-ascii?Q?rpXN4tSQhqWIrHEoT/U42mY5fQ27p/Rv6jwNsk2BgW+xAofgJxs1P2XatJhb?=
 =?us-ascii?Q?P9UTGZz2qf9J34eU9kOD7EEXX8QMZGAab0xuXcIztk0i6b8eR1khqY0K7RH0?=
 =?us-ascii?Q?Kxo7HITH5zAl9HUJijRMXmHlP7gWaKjD0+Cu4zqmltyeD5LyDQYGywEn7tyR?=
 =?us-ascii?Q?HtbPOZ2DCHN0Z02jkmv8wIUikoTH1Rcz9gtjSIG10lCdUcb70B8juHRP31iJ?=
 =?us-ascii?Q?F2V6RfxfyZv0SDqZPZ7eNqwK+AJ8BuIhttNbsP08M6xmaAvAg2N667l1lib4?=
 =?us-ascii?Q?4J7sI5xHMu21UUtRQbTDm5CZvrkl++xnUlou6MXfYkKGJv9ektyR5nFIJpof?=
 =?us-ascii?Q?VfIhFWAKsQFgusbVQAmQGSHjK9xbIS2BRHT2HhKwZ8kF3c1gfrsuwWyNp1Ug?=
 =?us-ascii?Q?oitupbuk/h7dHT+NQvcSHYYzD5psuPKzZ4EyeKOccfBfW450Nnig2sD0NkVj?=
 =?us-ascii?Q?JFEZoo7qC94FkK6+ro5CL5+44vFU/qaB8QLeoqnsGGSxb92SChOiFBvRWUyj?=
 =?us-ascii?Q?J6JLjXWxC5/O0d8OvhXz8gMuuVOtWxDm7cIGKIbwTNwPYqpjD9thzV0d1EcQ?=
 =?us-ascii?Q?zSRkbkj03Ajg5npnqqX2RoY76TTbR7unQk+MGKCpuXh3QulAbxj9czukcozS?=
 =?us-ascii?Q?0WvJOBkF0MeCSj1Oqa8Uu/bRim4ojnrylYd0gxnXPHys68OjLgl2Bjfrl/oE?=
 =?us-ascii?Q?Vhh3Atpth8/2d2okdi2tkNdQ7itjTuZxNrhVciTdU9GyUHW/z9AcNpd33I2W?=
 =?us-ascii?Q?oOADMhJNgE4Nk1O3aGOj3tN4OniHIoDg2FPR9Zt3wcCqa7F/GEeSBAtmC14i?=
 =?us-ascii?Q?r9MY85fdCH+DSHRBfixtkPkGq2frY6jueytThCIpmWxbanlZAkyLgduxKno7?=
 =?us-ascii?Q?h95xnhxfeKOZj/SjFqStOwi62eWRt5NatXacCnCJsRn+Y7ARo4M8TW55rsfE?=
 =?us-ascii?Q?uJn773d1edyd2JvP5ji+qPOySxrGVzF6XMBb0AvRBbw3RM2YHV3FAGkQx9SQ?=
 =?us-ascii?Q?2KWqZ8zBxE12T5n7v/E/wt32G+Bv1b7V8bWt7pfIqn431hrPWzJks67P/AxH?=
 =?us-ascii?Q?KzuP4ehErtjCdwN97/pnL3hOcqbClJFQ7mNKlVR15RZvq5gh/cJhq/YKtLwe?=
 =?us-ascii?Q?t1HAebNdL4U7xH+0Remk1sf/Qpt8x+M+OJC5ZF/gi32o7LhOlJmpjtfwWU8q?=
 =?us-ascii?Q?dHzNyC33h9Ky7E3qot1u8vvMCo0azIgIovWeNAnK2tRDCT6uMA6MseQ5ez46?=
 =?us-ascii?Q?S/zvxqp97OyWMXCn3NsMO7IqQG1tq2L2R3gG/75vV0KGx9ZRgxFcrgPsgY+L?=
 =?us-ascii?Q?2aZKbRgC9w/2mmK1oEjtTRs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8487.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(366016)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OHJV8OschtVt49qDuQcjMVWaMjfQOrFa1yh9L7UYdvkezSpxdX0OfyW2oulx?=
 =?us-ascii?Q?j3BdETdIwKsns1SINba9KetZ5xGpOcaAiqxS9o3Ru2TfpxCEHRnFfxeRc+Mn?=
 =?us-ascii?Q?m/bL/e1IYO72InPxfb8asHhXKjj/erGN+IO6r8J+bKi0Zekn7nONEe1z9X65?=
 =?us-ascii?Q?BBlwKnPKA5ztEGzd8+oZXkYoKbQzlRUB4wBEFUouW+J8FZHvqkbHV7muSNFU?=
 =?us-ascii?Q?rwlZLtno7zrgIzG5Kec1XiM+S2b5Eh/Y21FTlOoXtmEE4QW1dnAPpshPqDXG?=
 =?us-ascii?Q?8gbxq2BsuJXHQx+Ma+IbqgBlrA6dCxEaFr9wKvMClwoguo3R7Djau2zOkXYl?=
 =?us-ascii?Q?FeqPvGKDXj+GTA2QbNN07mJ+f7mWLtNxOb+JwyAWVmgzkgid5q4Z4vq5uiW9?=
 =?us-ascii?Q?AqpoqzAU25vbkvRQYP2pXRgZQOFIlPUA8WAQSs7fsZMbZeTR0hk/o2KA6On8?=
 =?us-ascii?Q?S30vXipFeODP7okeRxmLk+fxHR0FqLSQS/3HAqYLM0UbpkWcPd258w+Ap2BM?=
 =?us-ascii?Q?shBwHABC/aKq4s6d8D1Tvea/I7Rb14LBzMzuR20RIgkuucJ4XrsvDDXgDeBX?=
 =?us-ascii?Q?Rrb8XSdAYOHktIdRQuVrbVw4mXHbgBA1OWp5OstATo5FMVPlDUDun3SIiJ5C?=
 =?us-ascii?Q?hAAWMZ3CbV2NdCHPFCm1LIw7cK/mYjKM0B5gcFUTEYPpn7Zzbp3uRFcUBJfK?=
 =?us-ascii?Q?wMsz0PJZ2LEnmT2FpfWe2f4wn6e+/YFUGgH3hLW8OXth7Lm8V195JSDoZxxR?=
 =?us-ascii?Q?Isxe8AGoo2KrxRivezXiv43jBDS7ujoTbIZcIvdBGV5KZ9iOZaCUjXU/Y8Ol?=
 =?us-ascii?Q?UD4Fdwk4RsT6SdD6R8IWgsVxCSvI4FgAsOBIkDvOnPHW99f//1OFgDoLgLZx?=
 =?us-ascii?Q?LSeyAVlF1gJgEJuw+ZTtlcrXrK6ECa1MYdB0WkGmcAofOzcLbzmMNqeztqLD?=
 =?us-ascii?Q?bnlk9FQi10L6qV5JgH3xrJ9++Xis44G9I+b6QnVk89yfANWO7hxHaqBjj8nb?=
 =?us-ascii?Q?CwkftlPYfXph/eas0oIFYNLQ4eVs73S0GCr22CJtIvN4hHMP795HMBMUoaDA?=
 =?us-ascii?Q?gag3wyrvBR0KYymedtMMQy8F38f64ozpOLtcIGq7ZJeEZPKzFb/YgadjOkP5?=
 =?us-ascii?Q?Tb03K3rJHGnxhmohi+NLeUiffJMBl3HIslX71X1hRUnl9d/ob+oDnYcNsq31?=
 =?us-ascii?Q?mt/xG/7M0LbqdZkw3h80hr8h+aNGAyIFd5et24QTh/aaKHdGQbsA7px/rCKg?=
 =?us-ascii?Q?TkWy4GyCXng2MGzvu33zy1JHGzuNNTMRrmkjubYZHzRP8l8R8wc2uqM3/7Ac?=
 =?us-ascii?Q?bpEuPiQi5i13Rx9HI+dOqtEHUPfkCIyvZGvZuWz+Kkda5AoudTzqtTIaYn5d?=
 =?us-ascii?Q?nA2AmfpfBa5Rymmz2kOqs5a3oP+kdaimJg7YCxxGULslz6kqW37ABtRaFqnJ?=
 =?us-ascii?Q?O84wGzf+07vzN18FyfNXtkgQ76EYLrPCqpYptAr8VivuVNjvb3lI4phkWWqL?=
 =?us-ascii?Q?evOT8kXWo1p951PblywBkR5TdH7/LAF8LaZ9aSZN/HS3F3PfAmFpW/kn/cVW?=
 =?us-ascii?Q?0ToMIHJA7Zw25U1Y+R5ZcAVnSngb1MGrBM8oSwxeOZnYPmwqbm7wWsg15kaH?=
 =?us-ascii?Q?69lwVO3bBChXa/vnPfaaAKDwE1RLh30U1h05W1G+XZ5F3UOBeFtoGw5qQj4y?=
 =?us-ascii?Q?4d8DcRiHWBt+sjqL2rcJtJ0p0x7i67a5N79oMQULv3dp/+5BnP9Kxocgx++Z?=
 =?us-ascii?Q?d4QAURujLA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8487.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86366d43-36ab-47cb-6674-08de622e0b14
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2026 07:38:22.6583 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZPO3q5nRY80KoXz8xB25SNdrhkMB5bnpdm+qAhBsPH4ah4uRgIxAri+KapTVtQ1Luu9tFii9OCLdvg3IWnxadw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11710
Received-SPF: permerror client-ip=2a01:111:f403:c200::3;
 envelope-from=gaurav.sharma_7@nxp.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=0.979,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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



> -----Original Message-----
> From: Bernhard Beschow <shentey@gmail.com>
> Sent: 12 January 2026 14:45
> To: qemu-devel@nongnu.org; Gaurav Sharma <gaurav.sharma_7@nxp.com>
> Cc: pbonzini@redhat.com; peter.maydell@linaro.org
> Subject: [EXT] Re: [PATCHv4 15/15] hw/arm/fsl-imx8mm: Adding functional
> testing of iMX8MM emulation
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> Am 5. Dezember 2025 05:38:19 UTC schrieb Gaurav Sharma
> <gaurav.sharma_7@nxp.com>:
> >Added script that would validate the iMX8MM emulation by checking the
> >linux console log. If it succeeds, it will return:-
> >
> >ok 1
> test_imx8mm_evk.Imx8mmEvkMachine.test_aarch64_imx8mm_evk_usdhc
> >
> >Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> >---
> > tests/functional/aarch64/meson.build        |  2 +
> > tests/functional/aarch64/test_imx8mm_evk.py | 67
> +++++++++++++++++++++
> > 2 files changed, 69 insertions(+)
> > create mode 100755 tests/functional/aarch64/test_imx8mm_evk.py
> >
> >diff --git a/tests/functional/aarch64/meson.build
> >b/tests/functional/aarch64/meson.build
> >index 5ad52f93e1..c0e5be1b58 100644
> >--- a/tests/functional/aarch64/meson.build
> >+++ b/tests/functional/aarch64/meson.build
> >@@ -4,6 +4,7 @@ test_aarch64_timeouts =3D {
> >   'aspeed_ast2700' : 600,
> >   'aspeed_ast2700fc' : 600,
> >   'device_passthrough' : 720,
> >+  'imx8mm_evk' : 240,
> >   'imx8mp_evk' : 240,
> >   'raspi4' : 480,
> >   'reverse_debug' : 180,
> >@@ -27,6 +28,7 @@ tests_aarch64_system_thorough =3D [
> >   'aspeed_ast2700fc',
> >   'device_passthrough',
> >   'hotplug_pci',
> >+  'imx8mm_evk',
> >   'imx8mp_evk',
> >   'kvm',
> >   'multiprocess',
> >diff --git a/tests/functional/aarch64/test_imx8mm_evk.py
> >b/tests/functional/aarch64/test_imx8mm_evk.py
> >new file mode 100755
> >index 0000000000..224fe4669e
> >--- /dev/null
> >+++ b/tests/functional/aarch64/test_imx8mm_evk.py
> >@@ -0,0 +1,67 @@
> >+#!/usr/bin/env python3
> >+#
> >+# Functional test that boots a Linux kernel and checks the console # #
> >+SPDX-License-Identifier: GPL-2.0-or-later
> >+
> >+from qemu_test import LinuxKernelTest, Asset
> >+
> >+class Imx8mmEvkMachine(LinuxKernelTest):
> >+
> >+    ASSET_IMAGE =3D Asset(
> >+
> ('https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fclo=
ud.
> debian.org%2Fimages%2Fcloud%2Fbookworm%2F20231210-
> 1590%2F&data=3D05%7C02%7Cgaurav.sharma_7%40nxp.com%7C5b295e153b3
> 2423d31bd08de51bb20f0%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C
> 0%7C639038061323583828%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hc
> GkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldU
> IjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DFPAesw95MGl27hOs8dNQfHzi%2Ba
> Bjk4EqFxB7tGXwK9M%3D&reserved=3D0'
> >+         'debian-12-generic-arm64-20231210-1590.tar.xz'),
> >+
> >+
> '7ebf1577b32d5af6204df74b54ca2e4675de9b5a9fa14f3ff70b88eeb7b3b359')
> >+
> >+    KERNEL_OFFSET =3D 0x51000000
> >+    KERNEL_SIZE =3D 32622528
> >+    INITRD_OFFSET =3D 0x76000000
> >+    INITRD_SIZE =3D 30987766
> >+    DTB_OFFSET =3D 0x64DB5000
> >+    DTB_SIZE =3D 36812
>=20
> The only difference to test_imx8mp_evk.py is the DTB. Can we share the te=
st
> between both SoCs by extracting both DTBs there? The test function
> test_aarch64_imx8mp_evk_usdhc() could get an additional parameter for the
> DTB and one could drop the "p" (and possibly the "test_" prefix) from the
> function name. Then two new functions test_aarch64_imx8m*_evk_usdhc()
> take the role as test functions.
>=20
> Does this work?
>=20
> Best regards,
> Bernhard
>=20

Yes, we can merge the tests for the 8mp and 8mm. Will make this change.

> >+
> >+    def extract(self, in_path, out_path, offset, size):
> >+        try:
> >+            with open(in_path, "rb") as source:
> >+                source.seek(offset)
> >+                data =3D source.read(size)
> >+            with open(out_path, "wb") as target:
> >+                target.write(data)
> >+        except (IOError, ValueError) as e:
> >+            self.log.error(f"Failed to extract {out_path}: {e}")
> >+            raise
> >+
> >+    def setUp(self):
> >+        super().setUp()
> >+
> >+        self.image_path =3D self.scratch_file("disk.raw")
> >+        self.kernel_path =3D self.scratch_file("linux")
> >+        self.initrd_path =3D self.scratch_file("initrd.zstd")
> >+        self.dtb_path =3D self.scratch_file("imx8mm-evk.dtb")
> >+
> >+        self.archive_extract(self.ASSET_IMAGE)
> >+        self.extract(self.image_path, self.kernel_path,
> >+                     self.KERNEL_OFFSET, self.KERNEL_SIZE)
> >+        self.extract(self.image_path, self.initrd_path,
> >+                     self.INITRD_OFFSET, self.INITRD_SIZE)
> >+        self.extract(self.image_path, self.dtb_path,
> >+                     self.DTB_OFFSET, self.DTB_SIZE)
> >+
> >+    def test_aarch64_imx8mm_evk_usdhc(self):
> >+        self.require_accelerator("tcg")
> >+        self.set_machine('imx8mm-evk')
> >+        self.vm.set_console(console_index=3D1)
> >+        self.vm.add_args('-m', '2G',
> >+                         '-smp', '4',
> >+                         '-kernel', self.kernel_path,
> >+                         '-initrd', self.initrd_path,
> >+                         '-dtb', self.dtb_path,
> >+                         '-append', 'root=3D/dev/mmcblk2p1',
> >+                         '-drive', f'file=3D{self.image_path},if=3Dsd,b=
us=3D2,'
> >+
> >+ 'format=3Draw,id=3Dmmcblk2,snapshot=3Don')
> >+
> >+        self.vm.launch()
> >+        self.wait_for_console_pattern('Welcome to ')
> >+
> >+if __name__ =3D=3D '__main__':
> >+    LinuxKernelTest.main()

