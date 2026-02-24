Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 288CCEFB810
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 06:57:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vumLb-0002PR-01; Tue, 24 Feb 2026 01:56:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vumLS-0002Ii-04; Tue, 24 Feb 2026 01:56:34 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vumLP-0005Ll-Vm; Tue, 24 Feb 2026 01:56:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iJOpmrtF8x1rSfBBOkReIztqQxIBiKQt2CTy0NjZuFqAlGxwd/faGMhWqfPmWo/yBfkSeRyK1U6eecAwgzsApjo96TivLmFK8ups2lfZj/VfjsXeXnnhZHXJpK8R46POaDpdrc+PMvnuOga1c8ofXo/FzqZ016dAey9tfgp1PZ3gtOH2RIgZX4AVA+s8dJJI9i8NnrxwpFTQsjoxGMzFmBcfDHpNh/8IHhjZjqmMtPOG+7MI3e3GB1cme7oeEgKpdLDdvOHM11wo0qTfKToDaDupTx8IEikq1SCWUI4vMJCwOdqBvW9H+bQX44vD8fR9m8scUy3MsYPmvQMFisIadQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+AokFyU3mZivx+X26Jj7/e6Jjozx2g8FNox2EBkk1Y=;
 b=aoUS5iHMuHYv7VIEMvO9neRvaMDeGW6niuDdkL17lFfqyjH5yA+AvUxov0JlTNiJRPwJdlxN7IrwDGH4+S8LIot7zHOcdldieuTogY8bbwC/9KXfl34B0RjkZcm4n3+rHD2gxhHLL0JbefscC+aSc8uHdvvPQHFHSH8ZVuS90nS4kijVWVTxQ4rRyfpl53JpxQ/01PuvMpueOfUEdCZWRD0hdbirALHPPRmo223gzPbJ6fa1V9yiJc09X5+asMw8VoKQQ/BYJhquJhMG7mygY9Q333GUB52naKgbyVKcaw9Ea9XsCulV77xMZcVU+dFbr4a2PRqFtKKVHyHCAD998w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+AokFyU3mZivx+X26Jj7/e6Jjozx2g8FNox2EBkk1Y=;
 b=MrQSt8NzB/hjCFJggd61aLDYvz8T7Xyqm6lQWA1VGreJJXA65FhUEM858SxmSN6sH68zxQNf8dNqSNwNiggDrz9OcSm5DgI0xEm8D3qoj1KWFnWKm4esePaflG5RlJS6omWJZ4JK87ZwP8FeNPwJMBIqWrkASYmSjuIJ+hyDFTdJ5Q3e/Pvl+s7GXO/dLf3xjxzTCKJZA2Mf59vKVPnD3ze2vuAz7XWr4u6+FzJJ/2s/7uohdMkwEoCJWXUoM31n/rGjCnGtCaEnMx2WRXhRJhqVZvWP2O57IP7u4QY+z/AKffD18vUkt83K8mCLZzWpMM58e6WEObC7AnpmYjOk2A==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB6109.apcprd06.prod.outlook.com (2603:1096:820:d1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 06:56:11 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 06:56:11 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v3 10/15] hw/arm/aspeed_ast27x0: Add unimplemented Privilege
 Controller MMIO regions for SSP/TSP
Thread-Topic: [PATCH v3 10/15] hw/arm/aspeed_ast27x0: Add unimplemented
 Privilege Controller MMIO regions for SSP/TSP
Thread-Index: AQHcpVqosLoOovkPtEa/thW7Et5aTQ==
Date: Tue, 24 Feb 2026 06:56:11 +0000
Message-ID: <20260224065556.3847942-11-jamin_lin@aspeedtech.com>
References: <20260224065556.3847942-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260224065556.3847942-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KL1PR06MB6109:EE_
x-ms-office365-filtering-correlation-id: ea222ace-37c2-4a98-239d-08de7371cb9e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|921020|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?6InaCvMvoGXNpppt65kubzOruZcZq6R9Cbdx59OudGAqANA4hNHoqsLhq3?=
 =?iso-8859-1?Q?7AqJeqBZACqeEfCV94vjqq0xliT4OYFV+ZZa4Dbf6sRZWeIDMvxSTxfnBQ?=
 =?iso-8859-1?Q?WEhTq2nqaGrHOZLeEO8DyWRThkkAU8+QkoLH3YGGqIYh6jdFVaAJElS+UL?=
 =?iso-8859-1?Q?+/q/1AoyG8lrN88ehg0C+PrAmAEFqr2fKNtdTiwrH7FDQKxXeRQsKPWDrS?=
 =?iso-8859-1?Q?CCcR/VWhs1g6Oj4vEezW34dkv6jnXFDKCY5t3av++xnAMXxM6theGsXeW9?=
 =?iso-8859-1?Q?dvRGOOAnEshbVcb5hivq8IxWSFCg6h6DGz4XFJvVr+QPZxKMVQ65dPTatk?=
 =?iso-8859-1?Q?Dhugu0/zX+JESF6G3QwaOsOhxRDMeFqjmhjl2ERSStjIPbGIISxaGzYa6U?=
 =?iso-8859-1?Q?wYuu7p5llv3u4bXYK9lpdqW2JyLRYSeUzPEg3znMwBNSHS4SZgOkMHRfAj?=
 =?iso-8859-1?Q?S+B0D5lb21GFZdyZfK05zfLsmCN1KFa4DnH/+iKPmalXBG/J29RDXjNEUA?=
 =?iso-8859-1?Q?CB3Zz9ahJdFyDsZHplYVammB/4USsIbhcuNgpc+V8KmyfWUHWDT/2VbyMR?=
 =?iso-8859-1?Q?5hVm66UmsFhn98XqsYILrt3uhEmVeoMXxaqTH4MZiOrowz5ui8iMQC0cvu?=
 =?iso-8859-1?Q?Vjn9c32aBOF6NBtmeBQu0xZCrf7NsJEqp4kQFCt2ilouWRc4TQShrrvwbC?=
 =?iso-8859-1?Q?KvrvBiX/MYVUAXlMt8Mg8Uup2CC2d6PUyqaea2scHUYtSi45f9D0YUuJBr?=
 =?iso-8859-1?Q?h7CrodWzBXF1gi1cYWaejDZAIhmOetwu1Vu/Usd8/M3+xldFKBi5t+BYfi?=
 =?iso-8859-1?Q?QWzbXlyF7+rzGlLy+/QZ3Ua6sHMqqUqcuLJUkTe2/TAtWUW2AGaJQ0+iuI?=
 =?iso-8859-1?Q?RumkbWXeqAEnmpnFTsUg9GokknkQdFqkYvbb3NMs04ZAjsKd0GtaK4amZR?=
 =?iso-8859-1?Q?osSy2vsgz7dpzsd6bptrVUpaDCpRqejNsez5FKr8JJPtLZQ82Iur5zTdH7?=
 =?iso-8859-1?Q?Mh9OQZsMGmEfbF4MXOLbweF7UXRik7o2TIRathxQ78Qhg9VkIEtmc/BIuw?=
 =?iso-8859-1?Q?D5rJKEHoChWIEeRaxvJfKQHwWa8to/cAjiWCPRhS6H8FIMMEPS1D/NbbXc?=
 =?iso-8859-1?Q?ESXqEYIH0NPG+KyHTLyqAsR9/Tv/eueca+kqmrosHKqgHnckkItKzc8euY?=
 =?iso-8859-1?Q?AHpkLcWJDyRj2mH47WR4g4Dlm8AVATBwfQitCmyPDcs6pNSB3oe+ExZX/m?=
 =?iso-8859-1?Q?c9PjsJAXc5fYChAPbo3E3zS60ueI84ICp3V0JvzaBWDXFsg0E/MZhWaG45?=
 =?iso-8859-1?Q?gg2j45+B0y4Du717FgWz3lJBghKBqxYCcqSWFH4p6WGUBGD9yPcFMhRqdx?=
 =?iso-8859-1?Q?duAmEBB545gYAnOHL3CHqpL965/iaQOq6ypquIGI2xuEGN5EPJICCV9QVq?=
 =?iso-8859-1?Q?y/zNoPmSvpIySqFAff41ZSy4tb+yO2E4Vo6eH/gZMcRh3w2N+TcIEGgXSK?=
 =?iso-8859-1?Q?K9xIj00xoYUqLNimZg1tRyjWwBcZdpvWt3xjvVCJU/cXh7CCV4JPpw//Hp?=
 =?iso-8859-1?Q?z6WxpK8wqiYwS3PLITEOakmT3ZDo5W5QpZGNGkhT8H+ID2T7Hh0QrKHgfl?=
 =?iso-8859-1?Q?W8po3t6armUI3XOKRFasiiDUKIE5xhVb5O7KFnCUMuqpfsmo1mpTGw4JWW?=
 =?iso-8859-1?Q?r/UkUPx2TSvZEpLF2b2n8aZ14jEAjUZQc2/X+eAQ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?nCKFCqp5TPtp+E8XabKxDv6EC2U5DRaxbJtOAws1A4tDwazTGEonQ5VvSx?=
 =?iso-8859-1?Q?AtkfWzJAIuDK7LwEdQNP48gaF/lIfE6TlTBMlhjiOygHv/VjFVdabp5jEw?=
 =?iso-8859-1?Q?oG72s5jTQbVHSB3huWGtNigb8OBIBNX8Tv7V0NINWPyDZTYrjuCbDzNQAk?=
 =?iso-8859-1?Q?/zIKDUwIhgeM5g2XDlBS/fnM50PNqhJE4QhXP1Uu4vdeneWhhCcrxVaxjL?=
 =?iso-8859-1?Q?3Fnolv1JzTnxjK6f3uNAUICw83BwlbYrcDBRqvjJVvuuztabZiINk08iqM?=
 =?iso-8859-1?Q?Er9v6qzoURoPJgws6CZ63kO0U/nQNHMR0wH5TR5LSvBS/QbKvU9zyCV+ir?=
 =?iso-8859-1?Q?dodyY0ArBWKtfVmT38ktCgfx2P0JgY+OHFl6t5POw1Wqx8U4u1gzIEOQTX?=
 =?iso-8859-1?Q?3ecUZIkf7bv99dQh99BqVi6RmYpFojBwZrMdLHm5N9mlD/3jg27/53Fz3y?=
 =?iso-8859-1?Q?nbMOD8c1t5gko4lwgZ+X2P1tlHoWpy6762H3BkW1yv3HUSIXLlbmPdSSah?=
 =?iso-8859-1?Q?2rtZYPrDV8Xx/QR6dUTANFj+reh5bwJaG+IMOswNNYSG7zBNDKYwxCCUno?=
 =?iso-8859-1?Q?tM5A3tT1BZ+RWBRCtxE7vkp1c3Mh1HdnCFv/YQ4izhWwLkOh4oxl2K15YA?=
 =?iso-8859-1?Q?HPoNHqf+e6+gP26lkSfap9Ege58jtW3LID/dZ+sqKKdyKYyZ/ohICFX8td?=
 =?iso-8859-1?Q?MsomwEuivfDGQzvJDMi2aZ8bmujpr6HhWFPidwDyZLMClM9cAy+4AR4lBm?=
 =?iso-8859-1?Q?0xgea3RNoarZ2TTi24ub2aKu0leX1qhhCU6fHhhlEGC8OTIO5d94O5crmO?=
 =?iso-8859-1?Q?DcAykaLZ3sumBWZrpVal69KVE22IMQFY+v7gwdyhsIfNfXBmI5oa1i5fgj?=
 =?iso-8859-1?Q?JGD6yFNOjJi0hrwN2mO5mlXVecoJKoH9j83EsVzcGQ5d5VUeaFu4GKGovM?=
 =?iso-8859-1?Q?KKJQSXK3ZZEmcqwC5EsZyivBzDfRhVrSCK1Zl/pgfGFtI6exzTo+xhc12W?=
 =?iso-8859-1?Q?w7cg+4DhSr9lfZPKQ8e9Y52ykznft7EzWC76Qy/X+EpBSTp2A0GWxnPC4h?=
 =?iso-8859-1?Q?d0T9eOVyCuD5Cu12wHaIM8miHQGDhytHmWbhkbi1zMPKeECAs2+HtY/IOu?=
 =?iso-8859-1?Q?M1twkXO5MiZnDVOyYW504M0Wzf28iHd0FWWlti4NrwSy3mRSdxzDvOacdL?=
 =?iso-8859-1?Q?frWucSsZhMZ2+I5HC5KZ7wkDRqHmfDQ2oZ8dIxYyL/dRHc3AknxrUto72x?=
 =?iso-8859-1?Q?J9dJKx71qYy00mPMkyiXd9GUll+A9RqzFCGXShLSQMpLQCyrD66qIb9ANu?=
 =?iso-8859-1?Q?wbWmW2EZOQmEJtFZXQBvK1FII8GxQrsLaEGIzJCY1Dz6cp2YZbNhJgFmfT?=
 =?iso-8859-1?Q?IcLIqd7FoGyWhTuwW4niIzKIAWmmDtjvjhoh8MYEMZmt+61EuWl7juM3sy?=
 =?iso-8859-1?Q?rNuy9zOZ2f4k9k3eOE5TsUuOAo0yw6OVOWwE6P1M3gxszNJh7tQbYRPOCT?=
 =?iso-8859-1?Q?NIjOhCwawO6/vHw3j9Scq1a5n+5M8XrqanhSaMGpJOOE6j/vEU1jG9mJ2n?=
 =?iso-8859-1?Q?gs9n7kFwnaekjSfEcPRIhzak0gYNrTMoh6zbtfGoxj8fv+4CGKV8h1l7fK?=
 =?iso-8859-1?Q?s8qrhIF/SzehL2nEPPJ5imVUpkxIAr/YWffXQP6MHXyqp7dJ3ATNaYN4OI?=
 =?iso-8859-1?Q?+QprbNfXAhoNSnSYa/4tx58ZERL9e1bzJ0+1ZLjv2ZnlrV3l3OCwiuqIQi?=
 =?iso-8859-1?Q?VyMrbAXzbBbaI1BbAOCCtFCw9jcuo7/4EP0lQE8tyWjCu0tdT2Ypt6M/Zb?=
 =?iso-8859-1?Q?Z9IHWOigNA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea222ace-37c2-4a98-239d-08de7371cb9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 06:56:11.2128 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ALiyqnoqxGJ2Wjk6JRyh9I7MFqQMEfSZgtgWm4dqnGjPFjGhYKJvXxjgWLXs1Vnw/yOCLQqGlwFNhZtNgd28B6eW92Xs2tIii7JF/ZEEpvo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6109
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

The AST2700 SSP/TSP firmware accesses Privilege Controller MMIO regions tha=
t=0A=
are not yet implemented in QEMU.=0A=
=0A=
This change adds unimplemented MMIO devices for the Privilege Controller=0A=
blocks and maps them to their corresponding physical addresses in the SSP/T=
SP=0A=
address space. These stub devices allow QEMU to safely handle firmware=0A=
accesses and prevent spurious exceptions, while accurately reflecting=0A=
the hardware memory map.=0A=
=0A=
No functional changes.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/arm/aspeed_coprocessor.h |  2 +-=0A=
 include/hw/arm/aspeed_soc.h         |  2 ++=0A=
 hw/arm/aspeed_ast27x0-ssp.c         | 12 ++++++++++++=0A=
 hw/arm/aspeed_ast27x0-tsp.c         | 12 ++++++++++++=0A=
 4 files changed, 27 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_coprocessor.h b/include/hw/arm/aspeed_co=
processor.h=0A=
index 8d45c0b9bc..94b5cd257c 100644=0A=
--- a/include/hw/arm/aspeed_coprocessor.h=0A=
+++ b/include/hw/arm/aspeed_coprocessor.h=0A=
@@ -50,7 +50,7 @@ struct Aspeed27x0CoprocessorState {=0A=
     AspeedINTCState intc[2];=0A=
     UnimplementedDeviceState ipc[2];=0A=
     UnimplementedDeviceState scuio;=0A=
-=0A=
+    UnimplementedDeviceState pric[2];=0A=
     ARMv7MState armv7m;=0A=
 };=0A=
 =0A=
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h=0A=
index b185b04186..5b208a979f 100644=0A=
--- a/include/hw/arm/aspeed_soc.h=0A=
+++ b/include/hw/arm/aspeed_soc.h=0A=
@@ -296,6 +296,8 @@ enum {=0A=
     ASPEED_DEV_IOEXP1_INTCIO,=0A=
     ASPEED_DEV_IOEXP0_I3C,=0A=
     ASPEED_DEV_IOEXP1_I3C,=0A=
+    ASPEED_DEV_PRIC0,=0A=
+    ASPEED_DEV_PRIC1,=0A=
 };=0A=
 =0A=
 const char *aspeed_soc_cpu_type(const char * const *valid_cpu_types);=0A=
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c=0A=
index 8efaaacb8f..8a748b42a4 100644=0A=
--- a/hw/arm/aspeed_ast27x0-ssp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-ssp.c=0A=
@@ -22,11 +22,13 @@ static const hwaddr aspeed_soc_ast27x0ssp_memmap[] =3D =
{=0A=
     [ASPEED_DEV_SDRAM]     =3D  0x00000000,=0A=
     [ASPEED_DEV_SRAM]      =3D  0x70000000,=0A=
     [ASPEED_DEV_INTC]      =3D  0x72100000,=0A=
+    [ASPEED_DEV_PRIC0]     =3D  0x72140000,=0A=
     [ASPEED_DEV_SCU]       =3D  0x72C02000,=0A=
     [ASPEED_DEV_TIMER1]    =3D  0x72C10000,=0A=
     [ASPEED_DEV_UART4]     =3D  0x72C1A000,=0A=
     [ASPEED_DEV_IPC0]      =3D  0x72C1C000,=0A=
     [ASPEED_DEV_FMC]       =3D  0x74000000,=0A=
+    [ASPEED_DEV_PRIC1]     =3D  0x74100000,=0A=
     [ASPEED_DEV_SCUIO]     =3D  0x74C02000,=0A=
     [ASPEED_DEV_INTCIO]    =3D  0x74C18000,=0A=
     [ASPEED_DEV_UART0]     =3D  0x74C33000,=0A=
@@ -142,6 +144,10 @@ static void aspeed_soc_ast27x0ssp_init(Object *obj)=0A=
                             TYPE_UNIMPLEMENTED_DEVICE);=0A=
     object_initialize_child(obj, "scuio", &a->scuio,=0A=
                             TYPE_UNIMPLEMENTED_DEVICE);=0A=
+    object_initialize_child(obj, "pric0", &a->pric[0],=0A=
+                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
+    object_initialize_child(obj, "pric1", &a->pric[1],=0A=
+                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
 }=0A=
 =0A=
 static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **er=
rp)=0A=
@@ -275,6 +281,12 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->scuio),=0A=
                                   "aspeed.scuio",=0A=
                                   sc->memmap[ASPEED_DEV_SCUIO], 0x1000);=
=0A=
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->pric[0]),=
=0A=
+                                  "aspeed.pric0",=0A=
+                                  sc->memmap[ASPEED_DEV_PRIC0], 0x1000);=
=0A=
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->pric[1]),=
=0A=
+                                  "aspeed.pric1",=0A=
+                                  sc->memmap[ASPEED_DEV_PRIC1], 0x1000);=
=0A=
 }=0A=
 =0A=
 static void aspeed_soc_ast27x0ssp_class_init(ObjectClass *klass,=0A=
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c=0A=
index b7ad828528..5037276f20 100644=0A=
--- a/hw/arm/aspeed_ast27x0-tsp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-tsp.c=0A=
@@ -22,11 +22,13 @@ static const hwaddr aspeed_soc_ast27x0tsp_memmap[] =3D =
{=0A=
     [ASPEED_DEV_SDRAM]     =3D  0x00000000,=0A=
     [ASPEED_DEV_SRAM]      =3D  0x70000000,=0A=
     [ASPEED_DEV_INTC]      =3D  0x72100000,=0A=
+    [ASPEED_DEV_PRIC0]     =3D  0x72140000,=0A=
     [ASPEED_DEV_SCU]       =3D  0x72C02000,=0A=
     [ASPEED_DEV_TIMER1]    =3D  0x72C10000,=0A=
     [ASPEED_DEV_UART4]     =3D  0x72C1A000,=0A=
     [ASPEED_DEV_IPC0]      =3D  0x72C1C000,=0A=
     [ASPEED_DEV_FMC]       =3D  0x74000000,=0A=
+    [ASPEED_DEV_PRIC1]     =3D  0x74100000,=0A=
     [ASPEED_DEV_SCUIO]     =3D  0x74C02000,=0A=
     [ASPEED_DEV_INTCIO]    =3D  0x74C18000,=0A=
     [ASPEED_DEV_UART0]     =3D  0x74C33000,=0A=
@@ -142,6 +144,10 @@ static void aspeed_soc_ast27x0tsp_init(Object *obj)=0A=
                             TYPE_UNIMPLEMENTED_DEVICE);=0A=
     object_initialize_child(obj, "scuio", &a->scuio,=0A=
                             TYPE_UNIMPLEMENTED_DEVICE);=0A=
+    object_initialize_child(obj, "pric0", &a->pric[0],=0A=
+                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
+    object_initialize_child(obj, "pric1", &a->pric[1],=0A=
+                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
 }=0A=
 =0A=
 static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **er=
rp)=0A=
@@ -272,6 +278,12 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->scuio),=0A=
                                   "aspeed.scuio",=0A=
                                   sc->memmap[ASPEED_DEV_SCUIO], 0x1000);=
=0A=
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->pric[0]),=
=0A=
+                                  "aspeed.pric0",=0A=
+                                  sc->memmap[ASPEED_DEV_PRIC0], 0x1000);=
=0A=
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->pric[1]),=
=0A=
+                                  "aspeed.pric1",=0A=
+                                  sc->memmap[ASPEED_DEV_PRIC1], 0x1000);=
=0A=
 }=0A=
 =0A=
 static void aspeed_soc_ast27x0tsp_class_init(ObjectClass *klass,=0A=
-- =0A=
2.43.0=0A=

