Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E023D711CA
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 05:13:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWSn0-0001lG-Au; Fri, 19 Dec 2025 00:12:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vWSmz-0001l8-Bz
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 00:12:29 -0500
Received: from mail-norwayeastazon11013008.outbound.protection.outlook.com
 ([40.107.159.8] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vWSmx-0002OW-F2
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 00:12:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zTNRZxO5ANv7gI6nIn5dRRIVIfnj2If7y4emzbcMf4lPDIelaRtiCD2TkdetuIyiw6YvAI6sEJAWlhUpb8+KBOQoDl6c/MrSAYVqtVf6K4lCEE503ztCIer7BCWqdQEDRNZnUOhulPOxpm0TGVuvFipCzvaVCgH/SWP389JZES5bGhOJJ1LxzTnp2fbrwcnMQBKQhoBVWZ0VJslj/RMf85S5P5/5/0YkRxZSju5ncTmvjYKrQ74FjbgYPAKIBoRu0Eic09ADrPcUu92D6qIPjA4F2f0ir6p6Kqp4+C5RpRWL7keHjQOqn3+Znbnex43jhmczRbU8cEJTwFbD4+sRsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vC7Px0e5olDUwGpKNMnFflNAQ6QiXSLssTUMrwyGouk=;
 b=hQR8esVk5zxObNtnbaL74xobnZjD0sVpFkwp+as3aHrqRzgsJ6sAiqS7gMI6BoueaNwef5nc5mHHQDHwkpMQPwE6FGs/oenORD5ATxwr7CRqC0bc0W23eVRcE18OwMj5/RqR6DAl3D8otuQtnXTq+ojHOBwssA7biHvlTZ0fjshzc0SD5HLNC8p4d5JeVr8SdLzyZqJgilwJrEAW/1Aj+w/P1P0JoLN7TBCkZPOEl+TLVAys1ZDmMz1fTXp5tuSnzNJ1MgGa6rgYx3pXZFYSeLCKym+k8otoAWAcAEKgVfzyNEMF4/lGUsskf1dUWIkGQ9YVaxRbq+5spfU/QNHXvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vC7Px0e5olDUwGpKNMnFflNAQ6QiXSLssTUMrwyGouk=;
 b=V+3u0hfTiWD3tzmMgCfzaSXEpxnA7/53FBW/DuMdsUOToSVhxsGdK+It1AW3byQzjrIDMUWTGDXSrPwPZ1YwYRYTpTbmtmXWGTF44S1H+Qmh5bVjKJWNFwDrez0d+GMNAFIT6zkgZP7s9Zdi6xklwAQUYobf+gqRVokPLXdpcES4n6tAD3PItWQGqdKXy8Pd2VArSGn6M3WBP4pkNoREeJ2V0Cw+sYtI2VFj6NIb+amU97vU4RF3mLFPRBcgt0m5QChnA/s0o0QFMorFP+2m7CL4gmB5/K+za1KGQKkrSJy+p+b0j9wrtRrfRi+Mhm8F6b+cv3npu1Q3g8ulvsJTSA==
Received: from AM9PR04MB8487.eurprd04.prod.outlook.com (2603:10a6:20b:41a::6)
 by AS8PR04MB7592.eurprd04.prod.outlook.com (2603:10a6:20b:23f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Fri, 19 Dec
 2025 05:07:22 +0000
Received: from AM9PR04MB8487.eurprd04.prod.outlook.com
 ([fe80::1e08:e81f:d29:e1da]) by AM9PR04MB8487.eurprd04.prod.outlook.com
 ([fe80::1e08:e81f:d29:e1da%4]) with mapi id 15.20.9434.001; Fri, 19 Dec 2025
 05:07:22 +0000
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>
Subject: RE: [PATCHv4 00/15] Adding comprehensive support for i.MX8MM EVK board
Thread-Topic: [PATCHv4 00/15] Adding comprehensive support for i.MX8MM EVK
 board
Thread-Index: AQHcZaleedsdKqUPWUq5Ui2k470lsbUof1fA
Date: Fri, 19 Dec 2025 05:07:22 +0000
Message-ID: <AM9PR04MB8487B6CDD04406F5EF2F8F1687A9A@AM9PR04MB8487.eurprd04.prod.outlook.com>
References: <20251205053819.2021772-1-gaurav.sharma_7@nxp.com>
In-Reply-To: <20251205053819.2021772-1-gaurav.sharma_7@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8487:EE_|AS8PR04MB7592:EE_
x-ms-office365-filtering-correlation-id: 1b9aa86f-cae8-4059-135c-08de3ebc7e2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|19092799006|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?MyC5OQm916y/r0ddQ9+spi1KcvFLhban3d+gQ5G3CZSEyuHpmLKK+5shOw7R?=
 =?us-ascii?Q?7BmJQrOTZc39U7CC8VKmlOI/IKKgBav6828PwhYbxMCv4LcmokRFG2fiiC9k?=
 =?us-ascii?Q?hyBZW7CXmTD7Wn724nE2S7DyWo/hVnG9RseqQlFw/fVauMjjRcJXLMm0unre?=
 =?us-ascii?Q?/Cb3RrBqhFMsRcvtfn53CVzNLS9MjKooFy0cDDJ/3Y3IZJKe8qMMVg9mn1SY?=
 =?us-ascii?Q?hHG6Ql9bvJiMXuvvp8EHSRfS2kCTwvqTvOQvENTxvQPflBVnCE696KoBlVay?=
 =?us-ascii?Q?ddVOGOdWJ+vTjGICGbiNdFRtYCita9fwh/kdaBL8oZMtGnJMGxsMTFLl6XsB?=
 =?us-ascii?Q?DSMIqlmFHlOuO5Ib7n9mpCz+tsucE3A2ZMCjrIARHPa33bbZM9ZujMtD1dQ8?=
 =?us-ascii?Q?2Ooa6Uc+Zepwlo01/0zXP2SyG7UWEw+ceIbxRkn70Q+iZgUoF8w5yiXyxkX0?=
 =?us-ascii?Q?08ikBlBES0oxLnK5NQDB+YIjURTOFuGPv23N3FNLpJL/bGw4bJLAIbi3yaVi?=
 =?us-ascii?Q?W7c2kql2a6Cb+RJicquJJ0r2jSYkBiaou9NbjUDXp+RTA54P6Q9juZ9PC6Y/?=
 =?us-ascii?Q?5rFQbLXqfz5qeNvl//x4XAq7mIWVUUcRKzIWaRN3Ibv2D+54emG3GXFIfCRN?=
 =?us-ascii?Q?bBjjo3CWoyBnYvWHhVuRyQd5ESdO7NMblsoMFHgCF0XSQorG+0InAhqRQylI?=
 =?us-ascii?Q?tnSKo3SHm3JBit7lM1MR27ML/37HuJDT4AHssDuY3Qg8QCJoHSZBxmzSsczB?=
 =?us-ascii?Q?ohMqJrTmVmWfvmhfE7qBEYJ/ZUdEsD81GEzsc7mboej2E70Gu/m2tAtP2683?=
 =?us-ascii?Q?YGOD6ujAQ/g9OIR3irEbSblRbQT6rS9KONXX+rVqcxYc1uQKgFwdh9YlFURs?=
 =?us-ascii?Q?Ad5FPWyA6qTS6PunYace6Ryih1jVppPicTXUL6uMudWnupf2aj23hqU+DVgY?=
 =?us-ascii?Q?pWsz2ry0GFnlRthukniNs7Kveg5aiJt/GoyFxnPcsTKshXIRNEhemaToV9L5?=
 =?us-ascii?Q?hAZBbhexM/ZgLnYotCvN/qG2jO5m8CXHZso4MTrwT+e4iKAyR/n2ZEUfARlG?=
 =?us-ascii?Q?BlNsg+qF2kNjcKv0F/AQlFFQf0xCpdt/mnC4jmtbBRYzmoOFbIu5Y1nJCqEC?=
 =?us-ascii?Q?dUx1SLFo4PoXp4W8VUAeJ+EXo88dT+Cw2n4p9L9QmkGgRzJ5gdI2vEtqZGMS?=
 =?us-ascii?Q?7C5V7xPQletDMv3CcRQjrRh1XF1qY6TkkEJC5S7LdTvRhvKy52V11Jqsl8pJ?=
 =?us-ascii?Q?+7gtdsXB43ImRnAV5U5RAYvUXvD8Nsb2QaXSAm/0L6BZ+E4dLt2y8S/RnDDJ?=
 =?us-ascii?Q?KXM8rbXcDp/DpqwDiLWYLAJY3Me2zl/j6HJtfB26RvyVN6MvrT2wEI+XTley?=
 =?us-ascii?Q?89MmbKeK0ijYoOOeWlrFypeXS6glWlDLtNHPh8Nzwkk8CDYjWv+EzKgzg7wO?=
 =?us-ascii?Q?mX7eQZaDbx/xB09CTWarYyjNgiWZaTsFGNJ9Tt6bwkzSX6B/p+yxRTNSnT/x?=
 =?us-ascii?Q?3wqvubmQR8Qw2MFpLNU8np5tk7SJ2qjUDeY7?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8487.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(19092799006)(1800799024)(7053199007)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NX9iMCv1dsvcWgQXFuJBDINzwlRrUbW8bScXgVLtXmwghPVd3H67Q0CJD4Sc?=
 =?us-ascii?Q?BR9RNUd/9iOtVASme9j3nEvcoO2iwABV3txvDTSe//jqiVPdUoKSYCyLBGdl?=
 =?us-ascii?Q?WvDZhbGuNDic2rEtcUKuaub+pBZUJp3pWqIG66jKYbDlMHu6sP16l+Rf6Y5w?=
 =?us-ascii?Q?BdN9T51KZcbekNazgHhVAu/vIoxgn53Vo1fVNrV9XzvIX2hUaHlieVLle1lX?=
 =?us-ascii?Q?4fgnBSkzyP8BihsUPRy79MSMiAIpThx6czH1e1k8csYGON9oUmUnwhcTg39B?=
 =?us-ascii?Q?uZPzMy+fGhGCvQSHXlpE6hecmG1swswaoZIsJu1NMHMdU8Pxf40kgBwoD8pe?=
 =?us-ascii?Q?KW2iD9m+xHPX/9V6PLM8Y5ZHsBhPsyDBxAJiT+Q5UXboQyRVoGWj6mQ/pT6o?=
 =?us-ascii?Q?cpOGAkeYLV+pMWDFGj9iiulBUsKKhnNcUx+fernC24xM/a475hwjaWHIvIVv?=
 =?us-ascii?Q?BOL25Iqu6fiYR0NNFx8g/mhucuB2MKqeZ0lU87KeX/nll2oAx/Z42oCFWju0?=
 =?us-ascii?Q?6f7PZpCK6o71On7asGUauHuysnGg0+bhQSo5BetOA4WCBg/II1fhtlsKOc5Z?=
 =?us-ascii?Q?VSfa0mEZOjkESyXdEvV4dV7Y90+xqP2PeumWXJHhAveGu4bFotibuNg+1NHY?=
 =?us-ascii?Q?HpOqEyuH2j60iQmd93tOiQPE0vaV55FeWvdQExGhbl1Y7TZ9T0ChrHiL7LNL?=
 =?us-ascii?Q?jSdC7rhJw5gVNicXIFWUG81Pw67PVpYgUgDifPwR2MPZfZRzSQFbTFnqZwmQ?=
 =?us-ascii?Q?19VjzhVw+uN4Sx3wDg/Ft50+9+VKCKblR/v3Kp8A1dlqCEG7VRUsdA8ggBr0?=
 =?us-ascii?Q?7vPBgXXXNMk1jAsZPXePIXgXmMz5wilNq1DNypEOLNRuZmOdI0e0a6youiDS?=
 =?us-ascii?Q?U7p/T8UiK0yTn2u59OWFUzZ+QwCjSMAs2H44xBk5ni5hM7N2ak4EShGkDmq5?=
 =?us-ascii?Q?fsKBF/dvRDgbX8sD1zqjCJFtYR4WIUUzKeugJMIzAY7XXoeigdxvS6mEBKyB?=
 =?us-ascii?Q?Tkff1o7YAJtsPVYkrgVPywDXfjKxzbWTBlJhJ6vjtKNKOJaHubCwGQM7R28p?=
 =?us-ascii?Q?85Qi+u5fsVeFUH+Ph1NORO/XcO0p6EaNx1y9QDhI9EQABS+YXHYWR4zq68Gp?=
 =?us-ascii?Q?Rwdxgx2olFpE2X/NssHKFknXk4h/55Rjxa+J77t70WdLnK4aJS1jmGkq4m7k?=
 =?us-ascii?Q?4kV2fkDb3Y3yJsZbK/Ca0uNV2G2r6MpuQyD1PMMRyJiDNrsPRJuxME3Ffx8o?=
 =?us-ascii?Q?cdUeVgwZQzu7SqMAvTcvbA5avabfJm12YpD9ilYXKX0D5WoySYgx3ggMmHwq?=
 =?us-ascii?Q?zYPXFGzqdSxPmN7rRHG5yg6/bHN2nYHXHq7dL6amZpqPlp5Y+h9sDYBiywIE?=
 =?us-ascii?Q?iJxf3lMjC7tDW9XR7VfqcdtBohptrB+XLw2F5thTPJtDpxMxF4B31c2QYaU/?=
 =?us-ascii?Q?Mn2tWapAgRNfoqdFMlzTExepRjG516Vm+XieFlawnVky40w+mGCEa8Qul4IL?=
 =?us-ascii?Q?fM0cXIUN5ckzNHPI2164vh5sl8IAbdm3/ap40RVDtLH8vo8YtIWWhFslHFsj?=
 =?us-ascii?Q?WV3JW0EQEoEzva42WekqCvhIE8WDB8XpUcVzThuO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8487.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b9aa86f-cae8-4059-135c-08de3ebc7e2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2025 05:07:22.4820 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nmCgeOdXQTtVRD7XlDhSg7MR+4nFvH3M5OWtRQI3jfNfG+g836qWpW9Tmu/zx/q6exotZ0fe3FiCuIaK3Ce3lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7592
Received-SPF: pass client-ip=40.107.159.8;
 envelope-from=gaurav.sharma_7@nxp.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

ping

> -----Original Message-----
> From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> Sent: 05 December 2025 11:08
> To: qemu-devel@nongnu.org
> Cc: pbonzini@redhat.com; peter.maydell@linaro.org; Gaurav Sharma
> <gaurav.sharma_7@nxp.com>
> Subject: [PATCHv4 00/15] Adding comprehensive support for i.MX8MM EVK
> board
>=20
> Changes in v4:
> - Update Maintainers file
> - Re-used iMX8MP CCM and Analog IP for iMX8MM by introducing a variant
>   specific property
> - Split up the patch that enabled CCM and Analog in the previous
>   revision. Now we have 3 patches to enable CCM and Analog in iMX8MM
> - Updated copyrights
> - Removed '|| KVM' from hw/arm/Kconfig to prevent 'make check' failures
>=20
> Changes in v3:
> - Minor documentation change - Added KVM Acceleration section in
> docs/system/arm/imx8mm-evk.rst
>=20
> Changes in v2:
> - Fixed the DTB offset in functional testing script test_imx8mm_evk.py
>   and preserved alphabetical order of machine names in
> tests/functional/aarch64/meson.build
> - Fixed a typo and updated the documentation
> - Modified structures type to static const in fsl-imx8mm.c wherever
>   applicable.
> - Added CSI and DSI nodes to the nodes_to_remove list in imx8mm-evk.c.
> This
>   is needed because the default DTB in the iMX LF BSP images have CSI
>   and DSI enabled. Developers/Hobbyists using these BSP images will
>   observe CSI and DSI crash logs on the console since these are
> unimplemented.
>   With this change, both debian and iMX LF images will boot up without an=
y
> issues.
>=20
> Changes in v1:
>=20
> This patch series adds support for the NXP i.MX8MM EVK (Evaluation Kit)
> board to QEMU, enabling emulation of this ARM Cortex-A53 based
> development platform.
>=20
> The series includes:
>=20
> 1. Core peripheral support (CCM clock controller, Analog module) 2.
> GPT(General Purpose Timer) and WDT(Watchdog Timer) Emulation support
> 3. GPIO,I2C,SPI,USDHC and USB Emulation support 4. PCIe and ENET
> Controller Emulation support 5. Documentation and functional test include=
d
>=20
> Key features ported:
> - Basic boot support with Linux
> - UART console for serial communication
> - Interrupt handling
> - Clock and power management infrastructure
>=20
> Testing:
> - Linux kernel boots to console
>=20
> Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
>=20
> Gaurav Sharma (15):
>   hw/arm: Add the i.MX 8MM EVK(Evaluation Kit) board
>   hw/misc/imx8mp_analog: Add property to analog device
>   hw/arm/fsl-imx8mm: Add Analog device IP to iMX8MM SOC
>   hw/arm/fsl-imx8mm: Add Clock Control Module IP to iMX8MM
>   hw/arm/fsl-imx8mm: Implemented support for SNVS
>   hw/arm/fsl-imx8mm: Adding support for USDHC storage controllers
>   hw/arm/fsl-imx8mm: Add PCIe support
>   hw/arm/fsl-imx8mm: Add GPIO controllers
>   hw/arm/fsl-imx8mm: Adding support for I2C emulation
>   hw/arm/fsl-imx8mm: Adding support for SPI controller
>   hw/arm/fsl-imx8mm: Adding support for Watchdog Timers
>   hw/arm/fsl-imx8mm: Adding support for General Purpose Timers
>   hw/arm/fsl-imx8mm: Adding support for ENET ethernet controller
>   hw/arm/fsl-imx8mm: Adding support for USB controller
>   hw/arm/fsl-imx8mm: Adding functional testing of iMX8MM emulation
>=20
>  MAINTAINERS                                 |  10 +
>  docs/system/arm/imx8mm-evk.rst              |  79 +++
>  docs/system/target-arm.rst                  |   1 +
>  hw/arm/Kconfig                              |  24 +
>  hw/arm/fsl-imx8mm.c                         | 692 ++++++++++++++++++++
>  hw/arm/imx8mm-evk.c                         | 128 ++++
>  hw/arm/meson.build                          |   2 +
>  hw/misc/imx8mp_analog.c                     |  12 +-
>  hw/timer/imx_gpt.c                          |  26 +
>  include/hw/arm/fsl-imx8mm.h                 | 241 +++++++
>  include/hw/misc/imx8mp_analog.h             |   3 +
>  include/hw/timer/imx_gpt.h                  |   2 +
>  tests/functional/aarch64/meson.build        |   2 +
>  tests/functional/aarch64/test_imx8mm_evk.py |  67 ++
>  14 files changed, 1288 insertions(+), 1 deletion(-)  create mode 100644
> docs/system/arm/imx8mm-evk.rst  create mode 100644 hw/arm/fsl-
> imx8mm.c  create mode 100644 hw/arm/imx8mm-evk.c  create mode 100644
> include/hw/arm/fsl-imx8mm.h  create mode 100755
> tests/functional/aarch64/test_imx8mm_evk.py
>=20
> --
> 2.34.1


