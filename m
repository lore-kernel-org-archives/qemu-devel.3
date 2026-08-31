Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F9DFC61DE8
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 05:42:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0umV-0006MP-Hu; Mon, 31 Aug 2026 01:42:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x0umT-0006Lc-7n; Mon, 31 Aug 2026 01:42:05 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x0umR-0001FX-EP; Mon, 31 Aug 2026 01:42:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A7Hk0Pwbk22FEiW0yicCAVigz6h9bTdJ/7wBTErsgSB4c7jQ4A1wrY8BhvPuOo78AqcHkyDK5cjaHch9kdkxe1reyh3wmEhZ/7DjEHKvqGIJ3ZFwfUVaBHkFVlYHzKWLbyVTfuxl3DXQu+fkqdbUz77YN5MVj7ZWG8CfrJM6GXZ9rYVj0SY7ZVA02Dz/AV5r8epxn7L9DVNi9RrE38wOmr5rfj9+lgvng3IGHCXHJi/lqsPVk8JHIGQkTSCLKjkgv5dyhQUDPjqfVwS5UhbYVMSdVUhVZx8UQZ+a9sxq5T+uyz1jsKFUHdIan9Efioa0fEAhiSI8YbCd30Ng4wH8vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YgJRbGLml8U+9TRkNlilQsRbfrCtOFfIb5quM1jV0rg=;
 b=E1wekBzc4C2TKkmA0kKWADQro7z7AnRngXaaVH0C84FY6Hx8W6QWj2KHH5ddDtz7FvT7WohMoN7ymBoIzbnjE6ns3RyZ91wUdb4AAOryVdt3F8IFdY/HvKTsLQhQh27UkPCyyCbEl5PnGRg6FNR8xspd63sM4gdP/jPravEzktyGX+mRzZWwGZycim9Rt8zGVOzq1/tScOo5XJhWNQQS+k0geBkmuBcvJH1d2K4vk3rGLbdnp0CvqTLwh4I2EUrsC3fiMR0/QYG9uruTwo1DkZsknqFOjOMD2f44rC4Siukrc783CzyxWP0NB1jBeRTyYDCOInSWIoQMyIaxslW0Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgJRbGLml8U+9TRkNlilQsRbfrCtOFfIb5quM1jV0rg=;
 b=KmFg0m2S/bYjLNED3y/YoGX4C9RoN8oIPBFvkyUxJY+aKiFbY/yQX8hn+lh1N8MbR5JY96b2lQFob61o+AA1f/qoSWGk3KEddpAwmoF3n7hvRPCjv0LYgCGEMJXj9491CKiQIrRXQLUkVOSvO2Sf/m033ORyO7BK5BWyVOCCLMn9vYms5bU8wR4VTHTt4h4QuqBcShxqz0LU05qzVbOi1gd4U7MR24bX0EojGicOfy0ZWQoYInbrwRt5//Cf4oqZP1wLujDtqwJjDOaU1NZ+o2Mw2s8prSRKrGUczReBpn2GAeAa/Ytj32BuoCq6lo1So+bnxzh8Xu75oqbQ9miwAg==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TYZPR06MB6326.apcprd06.prod.outlook.com (2603:1096:400:41c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 05:41:53 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 05:41:53 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Kane Chen <kane_chen@aspeedtech.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1 2/2] hw/misc/aspeed_sbc: Derive secure boot state from
 OTP config straps
Thread-Topic: [PATCH v1 2/2] hw/misc/aspeed_sbc: Derive secure boot state from
 OTP config straps
Thread-Index: AQHdOQq/OmlU00iwUUmb6Lv9yXh78La3pKkw
Date: Mon, 31 Aug 2026 05:41:53 +0000
Message-ID: <TYZPR06MB49807A543D983DB4B8FA95F4FCA92@TYZPR06MB4980.apcprd06.prod.outlook.com>
References: <20260831053658.462203-1-kane_chen@aspeedtech.com>
 <20260831053658.462203-3-kane_chen@aspeedtech.com>
In-Reply-To: <20260831053658.462203-3-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TYZPR06MB6326:EE_
x-ms-office365-filtering-correlation-id: 4deb6b8e-d288-4bd0-ff29-08df07228fdc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10067099003|4143699003|6133799003|22082099003|18002099003|56012099006|38070700021;
x-microsoft-antispam-message-info: mqv/o68sZiVJlyte0bb0K+D0yjmOQ+d8ZyoASKJxmfdyzg4E2e1ljcEDGtrXmNr4XltKZi7QUMPjVRvm6Q46EQQcPcvKu5KShjxCuUqSPFVX0981hqbYEzbmvQfoZrZ35DRAKIegYJUkFFp1xLhwVosGczhTx45mm4Af8jtuOhleTLdnXu8kQstv1BuWQSEFE8F0Zs3pfJ+46nh7IyQIT6zaSTQ+7nQnMkEzkT3WsSrUXKywNEGuA7rx6OELcmMGSATIMvesriUZ/mIJ0fBGpD2lVpq9T7tymdb/2B4jdVcUVpTjWWmp+fCr7maNTWt+dn72rS7K/m62f0PCTAlhgutf355XJPemdNaNP2ZPhvkloD82i/kMaa7FSsRNXF4RPJ3auRJZgSkoKGStbI7OAJ29h/D+qCNJX9/Gp52+pjI2mCJQrL7fhOm8Cv5oI1BDpjFoLmge2EM7V9JH69Q2h3aGNHBE8D/1m35/wuR81Q/h3xqx2KAPWHb4bmCybt6ksHWSO3zUp0XC75nzK6fBptqIEtyA/yh0KIotKZQshtiDEmAAQdmYM5j1nqiYsbndkBs3hAhqAYPz0/v3J8fq3MWhwNY7LzjyuQRZg4oJBgW5vSYac9MEVSxdzW7Ken2FCC/YkLOdNzuG+sALzVT2CTPSQQm4I9+uF/JydRNnkL9jwURMO16ypmJd3H33ofUaWRaOviTBxsC/EJ5zGZcpuu+XRn6BLAeRK6nY4bybWso=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(4143699003)(6133799003)(22082099003)(18002099003)(56012099006)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?HJzdRC1NFNnVBcATfCH7t6MCDF1ztsjKTqYqdBMsOWLLVvyGOqsqWxfctm?=
 =?iso-8859-1?Q?sbJJTU1poZGSaaxHHyzhb6gYubNSXzbHncC1N4ByNo3aJ395lScDykVnZy?=
 =?iso-8859-1?Q?ynD3unk7hypvsuvPYOlMU8aGllPGC+5mctWYnPTnUvuD1toVsdDKfzaEY8?=
 =?iso-8859-1?Q?BZJTHQVT5VsF68sFVpbFU12nWHF48voQv6hjs7mhhoIQViirlZLji8EVxR?=
 =?iso-8859-1?Q?i+xsetUlj9TYgf65rzYMqqQBEeXsV8ALWdiK4pdjibLaC/acEEnZyspafm?=
 =?iso-8859-1?Q?4PIjfj0BSMud91dBZEA2gb3KXZG/sMWgpyN/EICu4EgrFTOI3G8TLZFG/W?=
 =?iso-8859-1?Q?z2T9OptI+WtZY4ufIL1YPc4J1YXLh4nv3M3J6C1V6Zt7VFNwl4eoFUbBJ3?=
 =?iso-8859-1?Q?GTFuu68uMBbW7aEHCiASGCCZLugMbH81oNqsHxJvkPyuN8hSC0DsyQot9G?=
 =?iso-8859-1?Q?/3e895guywsTs3iEs+tCwwboLpYDwKpfab42gS5gncrfbqRpcUzmNL+1xU?=
 =?iso-8859-1?Q?d5N3nlfRxVjqj1VyJxxrIcsQf/cVtu9XUiZCQNNubX68WRQRfAj6Wr1soe?=
 =?iso-8859-1?Q?TnSmFActo6ZwZgzhjo0NCwqKgXR19CODBqqYrqvT0ySo8t1Z2vRa+uSXwn?=
 =?iso-8859-1?Q?0qrQRNS+2jE0QAGSPPr/VsT4UjH9eDYOmdGOBpqC1ItlJoIPG8RLtcAvK7?=
 =?iso-8859-1?Q?xBwY6jRd560d4hb909G1j+e2yNbdp8GKEN5tb13YFERX1QGodqq84vzvI8?=
 =?iso-8859-1?Q?yR6sabv9ivtvcvnp6Fo9iQDqGmCtwIeptW1g8ARtotWaYXG7/yfVdnCAQR?=
 =?iso-8859-1?Q?lP3Bl6LxivJdobjgmEd5xAIkPaa70P+0Ccm4yUFxALi6+YrZWoFH+B3Yb+?=
 =?iso-8859-1?Q?Y0YDv4ViB508X3IawS5b/oCUXBChQhICdyqQpk5hynVEohjhDM0BxNeS1J?=
 =?iso-8859-1?Q?SpgL3KGHvonSiXTgmT8L5m26xZw/J3P58kGyI/dmVspujBnSzz763VUywz?=
 =?iso-8859-1?Q?dQiY9/Algoo/34aSgkelAKZXaCfqY8EncpKkUkpWx326FApTCB5249XGda?=
 =?iso-8859-1?Q?ocflIeLrXThg7otnvtkWeqvfjaeXk7wt4RkjFHGlbULCdaFyZWzMQWh3fc?=
 =?iso-8859-1?Q?TtpQffuRQ7Clbx3xixPn5zfc/wJZCsEBdzAj0HnUQpn4cGMQw7gESie+cD?=
 =?iso-8859-1?Q?38S7F4Nngvcu8nE1+uVkF5WP+/ykWIAPbTRQXlFLZ5Lm6DsKwQbM31l4bi?=
 =?iso-8859-1?Q?7Ba5BvVaLEfZ1+caGNT5butQ9Xad2kIKziOL6cb9QJYa82KiWMoq0H4aHX?=
 =?iso-8859-1?Q?P+T0n+dizCefhgifXz2nyprHzBK1IzEACDnzhAUA3+4q92Xyg/Hh3YyNb9?=
 =?iso-8859-1?Q?OjRaWbmJQdtf6WJTTXm+WZOUOCDp6QLXdpbI4a4sBr3ip75cL/8vz0EkuJ?=
 =?iso-8859-1?Q?+naY7ON/gqcPh06jdTm5OvgCKqR2npMt2Fel63yjt1fbtJjC0LoeMCDJ5f?=
 =?iso-8859-1?Q?gBERtHIGHW8XNTMDV8w1isCWgALJ43b/00IgIGB8XCDDzDCl1QpIM0mnUH?=
 =?iso-8859-1?Q?urbLpC6bKg+x7joVgzHihjw+zITvhDgZPzvH6PV+0fLYVunp3FHT1Rgu8d?=
 =?iso-8859-1?Q?IvnAY2aoRhzWPAttKh1WzRVf8T/iinmWxV5urEzJypeGfXx+zjqOTlgzsN?=
 =?iso-8859-1?Q?czk0IGWN7ChCH5uSDB1LHXN8qO8sqH/1b3LPmTRZkOrnUc9c95vixfkOIF?=
 =?iso-8859-1?Q?vEAL0aesQ6vVrWLHNYi3aMVuQbYgJab8/ymZ3Qg1nWelbtvDkFM0/T4wIC?=
 =?iso-8859-1?Q?/47NtT/IXg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mh2UGUf4bdosHRqhl+dxF6KFXnH0pXWgDQ/oTK5IdBcMNFNDHNgFwest5wbtz2Mn1yVGVwHU+0EIpC83bRd7/93QZisimXzNRxVFFGBY7Xm5YND2qk1LQrQebYrD3JcPiowB73UqMzNWBxEe6AcFNjOlQ/apizY7b9bu+FDfwuyzdF3SO9+OqmylgOh6ex7IrfRefxZIjPikoynhBds+LfpzpDk9W8Qoc2uz+cP/0Ifihk3Fy/fTz38u3mdsFP5sDZCzmyL1puP+3B1hOJRMvcTOZdl4gtmSZX59e8cBPQHPE/CiQYpMaydYHzjFRroHph5mRHCnFd8KgzHN0jNAEA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4deb6b8e-d288-4bd0-ff29-08df07228fdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 05:41:53.3207 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H1JDKSpC0TGzTNQnDXuK4Y/ggLnn5PfyX3TV3shp6l5/Y51CkvEzAlyOO3ZHx/6/vUWJoczeGKjcbPRiyaXu9i7CcsriX2zxxoCXxtCsHlg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6326
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

> -----Original Message-----
> From: Kane Chen <kane_chen@aspeedtech.com>
> Sent: Monday, August 31, 2026 1:37 PM
> To: C=E9dric Le Goater <clg@kaod.org>; Peter Maydell
> <peter.maydell@linaro.org>; Steven Lee <steven_lee@aspeedtech.com>; Troy
> Lee <leetroy@gmail.com>; Jamin Lin <jamin_lin@aspeedtech.com>; Andrew
> Jeffery <andrew@codeconstruct.com.au>; Joel Stanley <joel@jms.id.au>; ope=
n
> list:ASPEED BMCs <qemu-arm@nongnu.org>; open list:All patches CC here
> <qemu-devel@nongnu.org>
> Cc: Troy Lee <troy_lee@aspeedtech.com>; Kane Chen
> <kane_chen@aspeedtech.com>
> Subject: [PATCH v1 2/2] hw/misc/aspeed_sbc: Derive secure boot state from
> OTP config straps
>=20
> The secure boot enable bit in R_STATUS and the R_QSR signing settings wer=
e
> both driven by a fixed "signing-settings" machine property, but the two e=
nded
> up inconsistent: the logic guarding the R_STATUS enable bit was broken an=
d
> never actually set it, while R_QSR still reported the configured signing =
settings,
> so a machine could show secure boot configured in R_QSR while R_STATUS
> said it was disabled.
>=20
> Instead of relying on the property, read the relevant OTP configuration b=
its
> directly and derive both the R_STATUS secure boot enable state and the QS=
R
> value from them, matching how the real hardware determines these settings=
.
> The now-unused "signing-settings"
> property is removed.
>=20
> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
> ---
>  include/hw/misc/aspeed_sbc.h |  2 --
>  hw/misc/aspeed_sbc.c         | 34 ++++++++++++++++++++++++----------
>  2 files changed, 24 insertions(+), 12 deletions(-)
>=20
> diff --git a/include/hw/misc/aspeed_sbc.h b/include/hw/misc/aspeed_sbc.h
> index 7152497b2a..474922cbd2 100644
> --- a/include/hw/misc/aspeed_sbc.h
> +++ b/include/hw/misc/aspeed_sbc.h
> @@ -32,8 +32,6 @@ OBJECT_DECLARE_TYPE(AspeedSBCState,
> AspeedSBCClass, ASPEED_SBC)  struct AspeedSBCState {
>      SysBusDevice parent;
>=20
> -    uint32_t signing_settings;
> -
>      MemoryRegion iomem;
>=20
>      uint32_t regs[ASPEED_SBC_NR_REGS];
> diff --git a/hw/misc/aspeed_sbc.c b/hw/misc/aspeed_sbc.c index
> 5d4da39d30..ce03f717a9 100644
> --- a/hw/misc/aspeed_sbc.c
> +++ b/hw/misc/aspeed_sbc.c
> @@ -63,6 +63,19 @@
>  /* OTP Address */
>  #define OTP_CFG0                (0x800)
>=20
> +static bool aspeed_sbc_otp_read(AspeedSBCState *s, uint32_t otp_addr);
> +
> +static uint32_t aspeed_otp_read_cfg0(AspeedSBCState *s) {
> +    uint32_t value =3D 0;
> +
> +    if (aspeed_sbc_otp_read(s, OTP_CFG0)) {
> +        value =3D s->regs[R_CAMP1];
> +    }
> +
> +    return value;
> +}
> +
>  static uint64_t aspeed_sbc_read(void *opaque, hwaddr addr, unsigned int =
size)
> {
>      AspeedSBCState *s =3D ASPEED_SBC(opaque); @@ -76,7 +89,12 @@ static
> uint64_t aspeed_sbc_read(void *opaque, hwaddr addr, unsigned int size)
>          return 0;
>      }
>=20
> -    return s->regs[addr];
> +    switch (addr) {
> +    case R_QSR:
> +        return aspeed_otp_read_cfg0(s);
> +    default:
> +        return s->regs[addr];
> +    }
>  }
>=20
>  static bool aspeed_sbc_otp_read(AspeedSBCState *s, @@ -291,6 +309,7 @@
> static bool aspeed_get_abr_state(AspeedSBCState *s)  static void
> aspeed_sbc_reset_hold(Object *obj, ResetType type)  {
>      AspeedSBCState *s =3D ASPEED_SBC(obj);
> +    uint32_t value;
>      bool abr;
>=20
>      memset(s->regs, 0, sizeof(s->regs)); @@ -304,11 +323,11 @@ static vo=
id
> aspeed_sbc_reset_hold(Object *obj, ResetType type)
>          s->regs[R_STATUS] |=3D ABR_EN;
>      }
>=20
> -    if (s->signing_settings) {
> -        s->regs[R_STATUS] &=3D SECURE_BOOT_EN;
> -    }
> +    value =3D aspeed_otp_read_cfg0(s);
>=20
> -    s->regs[R_QSR] =3D s->signing_settings;
> +    if (value & BIT(1)) {
> +        s->regs[R_STATUS] |=3D SECURE_BOOT_EN;
> +    }
>  }
>=20
>  static void aspeed_sbc_instance_init(Object *obj) @@ -352,10 +371,6 @@
> static const VMStateDescription vmstate_aspeed_sbc =3D {
>      }
>  };
>=20
> -static const Property aspeed_sbc_properties[] =3D {
> -    DEFINE_PROP_UINT32("signing-settings", AspeedSBCState,
> signing_settings, 0),
> -};
> -
>  static void aspeed_sbc_class_init(ObjectClass *klass, const void *data) =
 {
>      DeviceClass *dc =3D DEVICE_CLASS(klass); @@ -364,7 +379,6 @@ static
> void aspeed_sbc_class_init(ObjectClass *klass, const void *data)
>      dc->realize =3D aspeed_sbc_realize;
>      rc->phases.hold =3D aspeed_sbc_reset_hold;
>      dc->vmsd =3D &vmstate_aspeed_sbc;
> -    device_class_set_props(dc, aspeed_sbc_properties);
>  }
>=20
>=20
> --
> 2.43.0

Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>

