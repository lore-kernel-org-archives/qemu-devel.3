Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2B38CC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 07:44:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGXAj-0000lN-CY; Tue, 13 Oct 2026 03:43:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xGXAf-0000ks-5B; Tue, 13 Oct 2026 03:43:39 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xGXAc-0001mw-HH; Tue, 13 Oct 2026 03:43:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iVFsVk9FYZImNDi4+sxi2WwTm+fPg/L/1cgTRFWmfKoPivCky0USaAm16sxhCF5Qv3K5Bd58HKLvH5cMpJABOaRylvE5ejZSjjnEbnpbfbk1k3bWI4o23sY8+wHakAq/kPPfHbDHKaQVN6GrQEsHThzXKBKOGXmoe02n/QArd4P2wpXugA2AX0n4FJ9gbLnhKARoY4jSD9P+Q1KVhvwch2vozWAn+zKKv00k4k31AxnKyEXaiDjwwqtrGSfnw6Mg7u0zhydnLdbQe8rZGDPMEMDAi+Xx2ma7aI0yVC8P8amFz1bdXCxLRLMOJxTF0QVD26xqDz80Ubg9r+ERTXPCfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQGIM9M0uOSqpP/UmMs0sk45sddLFhPbmjNnw0HE0BA=;
 b=mdD0+7HtnDegnOWTqRFj30pREgGwzLRbp2+hX3T9a6wylNvlgdF8mmMDnjHotgmOW4hCn6pM24KfGsCB0k/f58Agm1J3xmZ8Uyz7pkwEhdSNjNEOg4V0hfos1J3rX7T6XKY//d16aSF9mNdPJXCNHFb2rQhx+le2XXTR6AD6lW8P6cWwqWGWoHlRcQ/520MH2nlV82X5JZcnmvfKZTf5KGEZbiFspMXNm+mqIy3V3Jvt/sI3COl5qj91t3J8oRZzaCznTiOEVAsw+g+3ffXE9wQSwn2TJ11EDaxxwndPDJgXRZCmB6KlZfbJRagn+t26za0olYTzXQDRbwOPcJUE0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQGIM9M0uOSqpP/UmMs0sk45sddLFhPbmjNnw0HE0BA=;
 b=lCguEMB77p4PjfiH2wmWNZJvBeqqNJd/54wypeTCus4kjAPcqp3EL5xwgFUe8jAsm+b+9/tSUdCrp3YXuJ4gCVKl7R3TXeZc7w++hrvN/KVmrGyKFZww97BNVhBYi8s9O3+T+yBrPBckCMstTRxNUEb5q1WHWsR9k15BW1iLsthJUQoaBFraALfkgdLpfyueC2vg0NcmQ9JjCJugEiPfw3chthUyftvWkee4YqwRKbNj4/0OCIO2S0rPmyahyw0TuaJJvwS0lSZcK/Tka4L/vvnpmA9DC5l+glaU/+NsYmb+8ktEtLdtGReneLrBBl48ZyuxoKjYyYz3nAdbeV7vxA==
Received: from TYZPR06MB7373.apcprd06.prod.outlook.com (2603:1096:405:a7::14)
 by SG2PR06MB5059.apcprd06.prod.outlook.com (2603:1096:4:1c7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 07:43:24 +0000
Received: from TYZPR06MB7373.apcprd06.prod.outlook.com
 ([fe80::9b90:c4d9:22de:2ac4]) by TYZPR06MB7373.apcprd06.prod.outlook.com
 ([fe80::9b90:c4d9:22de:2ac4%6]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 07:43:23 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Emmanuel Blot
 <emmanuel.blot@free.fr>, Fabiano Rosas <farosas@suse.de>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, Kane Chen
 <kane_chen@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@oss.qualcomm.com>, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Patrick Leis <venture@google.com>
Subject: Re: [PATCH v2 48/50] hw/arm: minerva: add Facebook BMC machine
Thread-Topic: [PATCH v2 48/50] hw/arm: minerva: add Facebook BMC machine
Thread-Index: AQHdWuZxsph/f01iJEiWxSk0J6PAhw==
Date: Tue, 13 Oct 2026 07:43:23 +0000
Message-ID: <TYZPR06MB73736F77F75E0CEE4765E3D1FC9E2@TYZPR06MB7373.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB7373:EE_|SG2PR06MB5059:EE_
x-ms-office365-filtering-correlation-id: e8009868-97cc-467c-1ca0-08df28fda8f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|7416014|18002099003|10067099003|8096899003|261009223027099003|38070700021|56012099006|41080700001;
x-microsoft-antispam-message-info: hJPo/AcIR2SYFpQlQAoo45Z70rDvn/fXNAd2bg4cAUhrwQmwZYWOZT6OTayZmaFWAs/JaX8Ze/Qayh0yCJVCMtKbp7r9OIft3GKB3ywkFaRnwcwra6nJzvaq29sqVMzzRdOcHO9cqvH9fgZUO3Qf/7O01QtkggLfX4mrfNUwmIllC4XRI78TGKwCRuZOB3yQ3vmw9B+Na48TO0g/dqOB95juCHZgwzK+nqgwfD/wMIkq4lXUaxhgyWzVIyEoHg6uOR5Kss77h0r8pSoQlS3riRX5f+DzhduP0f53w3kU3z+aIepGvSeVGbAvHOSzpTXoaq6Dg50W8eB/5BxBXe5DwqEBv+//zrLPkEm0Y2hlzg6MyW83H9JP4oJ9GlXyJyQUchCymnlaQswYCj66R9a5dfyroocaJ2z8hwQVEKQIZpIl7ucFuHF2sA9yNsN1QL/EZCyf6Ft90/DNv0gAvn09zE5cCA3uROCll62H2zPgxJyWDY+Y5mQe9RpK3XB5dT1v1CUQ2cL5Lu2hAag1wAYcOW8zE/RTApbUHz3XvFPgHVl1a+wFXWnPZ8Yru1DNUmVe5aHCgYVxQDNEnuIblBvbl/et9zbKEXh1/0njWc5IAhecuYtEJyJUGvVs0OWfY2uUjZPqjU8nPW0WcvkS63/t3LFGw8c+90yBNcNGBQ0azF6+p3PHZV0FfOmK+EhXkazrDoKHTZqj6DX6Fjx8QO4jJ4NxFoDpNF9FO2ZKtS5lB2GmIemt20OoT/1hGoiyPk0m
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYZPR06MB7373.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(7416014)(18002099003)(10067099003)(8096899003)(261009223027099003)(38070700021)(56012099006)(41080700001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?n6XqgEs586Gi29unefh8iiljGrkUCGKgGG1QBzSAkD+yMerjOG2D7p1NrU?=
 =?iso-8859-1?Q?O4UsaiTNs5Bf+T1+6WYOZgnfHq9UekHQnfbFaAme0fktcrCQtFe2HCTm3l?=
 =?iso-8859-1?Q?HAN7wIhpM26t+LJ/XzM3oqL0KL62QF3FcGe2x16skDoN8p0u3S2LtVet61?=
 =?iso-8859-1?Q?V7q2oCO3OBbsbJZevjfgHqOJdAjMwHQ8VQMr+r7a9bELmJCQ86bwkdWxnC?=
 =?iso-8859-1?Q?fQ+Aia5UJYPDVPwyT4ev2Ns8N+b5HF1MuOxx6Ep4la9+1WAviaBcUTc4dW?=
 =?iso-8859-1?Q?URYXoJILDOWLwnpU7OzrbEAEH0pb7z4RaCs/Iubx115TjbPWLmlVC6re9Q?=
 =?iso-8859-1?Q?udN7vllzF0EG4l4AK/T7h9FLP4Nic1I72tqV+UZdIfWeerFDEtGfDjX7fa?=
 =?iso-8859-1?Q?KZ1jZm9Bgn4yhxL3nLmuhkTl1Li9DWMcV2wkxswmOOODIiaiZcz5TR382R?=
 =?iso-8859-1?Q?tZrJRA3tYXCHzV/DUnt3Slm2/TBV0Fe58evzaisJ+MlS9zMX/jEm2T0BcG?=
 =?iso-8859-1?Q?zTFsYQuKFARXMtIT1+DUJAJww9l+FAzkYJFxQWH3yRWmJmKyFcbwa2TGPF?=
 =?iso-8859-1?Q?/dM6iBX48XUcdnEJ+BfnvBOKGzHbWBdlgN+ci8T/cpcxX9MVOkhWboxzuW?=
 =?iso-8859-1?Q?l8GRmn4c6ICP2YLKrWGIxl59bDgzZNKhhlOK+whrBFDtjSorx9A4RhRyFm?=
 =?iso-8859-1?Q?/NvBjL5/NBi5LhLjGRzzpZemujHnqRaicvuqdufc1nE8p7CbwA5oQG/hGN?=
 =?iso-8859-1?Q?18HztwthfijZJgZ5UwDhuvpKwKxv3Tz0qp1LKBDmd4qoVftOFzDWV+7X4m?=
 =?iso-8859-1?Q?kVjipikYsHBkhRHN5vHo1uq1aQI/PQs72Ud9wS4t+AhkwoSHt6uNZQ31Y+?=
 =?iso-8859-1?Q?aPA4L6XqEeLZihdWv18N+YW7MjHbWro3VSqCzVEtGWwXROWI7oswH3DeCE?=
 =?iso-8859-1?Q?MYj5TQDUAXp5n4/dfMU+hqcpb2XuaP2IEkVvyffvQxeatRP9MWTCS/PPKT?=
 =?iso-8859-1?Q?MnvxWI5MY+a8XqEXo5S0DySSlukDlXJYtgVXnGjRsCvievc+FQLrqRHTD2?=
 =?iso-8859-1?Q?1PvFbfxULL4FHJF4wziAAYpafyExAI0VFEo8Qt/kEipWZE+LWHxsTPtz/s?=
 =?iso-8859-1?Q?wUMXOhHaey3awa2C5ckonYN9PadHSxhXy06NX/k/s5okA2m3NQLyzRt+o8?=
 =?iso-8859-1?Q?Hm75V3yz7O2TxKXSoocLqXleX89jl5Yke22Xmb2n1ttCtPYmUfEnhmE/2B?=
 =?iso-8859-1?Q?gOIZYtMAzrUBESqA503ksBfupLqvEGuGTjC7bx5E9o5R1n7Xq6+XMZn+jn?=
 =?iso-8859-1?Q?F/oeG6bC8o1R5KUbk4MuRoJ1ckDukf4LM8hVG1aMa0UueGVTSMnoivOZax?=
 =?iso-8859-1?Q?zjB+J4Vq/ntTxq1Qu1bBpc5Ub9vaACgolQuNsXzt4dkIk4BsZfx7Fg/1U6?=
 =?iso-8859-1?Q?dRbT/WAeKqfW9z15XpGED5AZacetj9NnYsy8+JpfnbLU4c1cntJ/iGuX9/?=
 =?iso-8859-1?Q?Q0E79J572cjmW89tS+VPJ+BdewCly5gHiXG1OXdOtoDTKjRFO+MlWNM8R6?=
 =?iso-8859-1?Q?g44V9zmldRXJhdiY6xjJ/rwymi52husT5IGUDMPLAEAT8SCyhSZulB5PET?=
 =?iso-8859-1?Q?Nd01KZDbALxQE+z+SJ/tgmwVLewQo1SjYIlxQGPEYX4VUoUzxZVCGHIZ+1?=
 =?iso-8859-1?Q?ZYjMcMDBTarDqRGWMdqUvyJh2cedJUKovR6n0Hl9a11GjiDsfMkGGVVTKy?=
 =?iso-8859-1?Q?sKTc0GhMBHEFDUk+8a0pZEKbVk4qxGm8vRuwGgwJDB76NUI7+5/Kd521EO?=
 =?iso-8859-1?Q?U5avvWudZA=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_TYZPR06MB73736F77F75E0CEE4765E3D1FC9E2TYZPR06MB7373apcp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gapkOS5lHmxi2XFFYfaxM9/tRm23a2pnobRwNflyOAP/+V3MimQPYqJszceFjzpmIM4gEe7df3Hyr89/bYBlfQNr9t9qQY4eBQtiQ/VQcKfCY64pToqKirpmIfKQmPOc3HWpKIeoxd2GJKnJdXypH31HXNCHVYHd3X1dZajFUXmr6CEKrlBn7S8cChIR2jbyhfO3VDyIvtDIoMb9o8KsvyWOq/eXqKCCXxcjZTbZUPYCIBmkmNyecpFd9sAv1K9k5pF8WOyxy5w9NYl1hxLuxibKcMw+HfsvjKkdLHbtqkC91GqWrSJqAT4ZAM0jBFsMj/hKayGd0rCEwcOstaS8FQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB7373.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8009868-97cc-467c-1ca0-08df28fda8f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2026 07:43:23.5907 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s/rLhoF9umCOOifhE7oGsz46kn+Mn/K68rUU5lo08/lDGcISiKjErpm/gSiAsi6guGbCEbn3QAYIJW4deALOE3NiH6RNSZbkcfVjM/encpg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5059
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--_000_TYZPR06MB73736F77F75E0CEE4765E3D1FC9E2TYZPR06MB7373apcp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

>
> Add a machine for the Facebook Minerva Chassis Management Module (BMC),
> an AST2600-based board modelled from its device tree
> (aspeed-bmc-facebook-minerva.dts).
>
> The board uses INA230 and INA238 power monitors, TMP75 temperature
> sensors, PCA9555 IO expanders, PCA9545 and PCA9548 I2C muxes, AT24C
> EEPROMs and a DS1339 RTC.
>
> Every device the Minerva device tree describes and QEMU already models
> is instantiated. The remaining ones (LTC4287, XDP710, MAX31790, PCF8563
> and IPMB) have no QEMU model and are left documented as comments.

Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>

--_000_TYZPR06MB73736F77F75E0CEE4765E3D1FC9E2TYZPR06MB7373apcp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&gt; Add a machine for the Facebook Minerva Chassis Management Module (BMC)=
,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&gt; an AST2600-based board modelled from its device tree</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&gt; (aspeed-bmc-facebook-minerva.dts).</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&gt; The board uses INA230 and INA238 power monitors, TMP75 temperature</di=
v>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&gt; sensors, PCA9555 IO expanders, PCA9545 and PCA9548 I2C muxes, AT24C</d=
iv>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&gt; EEPROMs and a DS1339 RTC.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&gt; Every device the Minerva device tree describes and QEMU already models=
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&gt; is instantiated. The remaining ones (LTC4287, XDP710, MAX31790, PCF856=
3</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&gt; and IPMB) have no QEMU model and are left documented as comments.</div=
>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Reviewed-by: Jamin Lin &lt;jamin_lin@aspeedtech.com&gt;</div>
</body>
</html>

--_000_TYZPR06MB73736F77F75E0CEE4765E3D1FC9E2TYZPR06MB7373apcp_--

