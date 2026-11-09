Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA309606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 02:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=Or25hesv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQFZY-00032W-Bc; Sun, 08 Nov 2026 21:57:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQFZU-00032B-IO; Sun, 08 Nov 2026 21:57:24 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQFZS-00013n-CA; Sun, 08 Nov 2026 21:57:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VPuX7SRLOJ3uZhKRtcG7xvY9UdqigmXCcqj/AE7HJ3KFWhWU20QpMmNvgY3hRv5PvixCVx7AWaXfXSFliFahM5hA+frofbVj1P0oObxsQAvb5bEa28pQS9JXVUtKRk8eGjpv7y3sJQlAcWC8wxuGn6yH1p1hu8R1vd+++BFzWy1/7pqFLcb/sgxpMF2dfMn8oroExGL7gflCJhONGPWzisBrfgLNdeUvNvtO6BuQPgOICTCO5wOqvQRy9hCQA57dxb+tkelN6irQK+RI1Mx1exGfxe6lUFvyrzgJn8lVLMmxtDvVxLYNi140Q37OMaaeqtSJ9zRbT3/yOWXOWKL8MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9nXBS8S94qf4A24kGLZUf4xuXXgQzpnvIVcGjGPAhI=;
 b=mfgfBWJhaWcyuE5o+dVQ7McHxzvCK8IH156v8Ul97AajqmvWxlperMRp4Jk8s6gC7IfCXH8YiXGSaFnybxo8jnq8sOL7gi8icDxdJ+sMgK6NujmKcBltz/QyDK/2kmhYfw/TP974c5cxBMUqf9NDZnegMx2gqeDI02ZpdSMbP8X3aan6SiTaFyFnI/teP9/0ffnqS28H0koYHVI23zToL2OLOAuSHl57jktn51qcp31z3OHQKH/fkcQsfGXGRwg0T5FrF33mDy2gUfy4Nl0iTKX6pE0+fAwa7ikgr4fdbJAV73Qx2VnXrz87WXJqsVARXl55+JHLyHIDp9yWy22qbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9nXBS8S94qf4A24kGLZUf4xuXXgQzpnvIVcGjGPAhI=;
 b=Or25hesvZJqLuEijD9sUb6pN7LusBq9L6jCV6988kYdD9Kk36Rmkk8agRBXBxWt4xftxSGExpGa74ja25lV9b0v6+ybvE/HiF6+rZL3e6ZjwE9zEA4tzn4dp9QuBGUbgO6WumwKYxt1biQY8sCW42OMdebtvn01XMNG1ZaoxP7mEU/FonWuN7uo5Tm0yzpVK1VA1r13lz/6TPcBqgKvsmf6wQwR98v9F5Lj7PRmQG0aZbryC8UxOB8CyApKgoEmHHU32Tp4Q1JcCfXM1wctcOdbsELeFKmiG9wg9aBulEDIc2Ut4MCkIX26OfgEyrlRJyfv/gpzJp6A2cfCPaXaQSA==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TYPPR06MB8051.apcprd06.prod.outlook.com (2603:1096:405:318::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.7; Mon, 9 Nov 2026
 02:57:11 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0615.005; Mon, 9 Nov 2026
 02:57:11 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Junjie Cao <junjie.cao@linux.dev>
CC: "kraxel@redhat.com" <kraxel@redhat.com>, "marcandre.lureau@redhat.com"
 <marcandre.lureau@redhat.com>, "clg@kaod.org" <clg@kaod.org>,
 "pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Kane Chen
 <kane_chen@aspeedtech.com>, "philmd@oss.qualcomm.com"
 <philmd@oss.qualcomm.com>, "kfting@nuvoton.com" <kfting@nuvoton.com>,
 "wuhaotsh@google.com" <wuhaotsh@google.com>, "zhao1.liu@intel.com"
 <zhao1.liu@intel.com>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "deller@gmx.de" <deller@gmx.de>,
 "sstabellini@kernel.org" <sstabellini@kernel.org>, "anthony@xenproject.org"
 <anthony@xenproject.org>, "edgar.iglesias@gmail.com"
 <edgar.iglesias@gmail.com>, Troy Lee <troy_lee@aspeedtech.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "xen-devel@lists.xenproject.org"
 <xen-devel@lists.xenproject.org>
Subject: RE: [PATCH v8 14/18] hw/usb/redirect-server: Implement control
 transfers
Thread-Topic: [PATCH v8 14/18] hw/usb/redirect-server: Implement control
 transfers
Thread-Index: AQHdaquqR4kcpf7BW0WY0PXfmYQ09LccaG6AgAiuDZA=
Date: Mon, 9 Nov 2026 02:57:11 +0000
Message-ID: <SEZPR06MB73628601F248BA1E414079EEFC732@SEZPR06MB7362.apcprd06.prod.outlook.com>
References: <20261102092201.1729245-1-jamin_lin@aspeedtech.com>
 <20261102092201.1729245-15-jamin_lin@aspeedtech.com>
 <20261103142327.1348025-7-junjie.cao@linux.dev>
In-Reply-To: <20261103142327.1348025-7-junjie.cao@linux.dev>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TYPPR06MB8051:EE_
x-ms-office365-filtering-correlation-id: 9475d214-bcd6-4a39-4986-08df3e0d268e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|7416014|366016|261102130727099003|261026121527099003|4143699003|56012099006|3023799007|10067099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: KODUbTQen8mEqyxszSkxr2VWaQn9yStfemy7hA4b5pMAYglf4wR+SBuRvkO/GQsOEHwlmN+uRY7daJX3Tza9zeyYKnLMS8aTSGtrQ0TwHFtgLc6zHAiV08R6DLSaje5FpbqqCKXJmPZX8lCln7Ur2dd+qtDbVn5PG5/zU1R90Wdnb45eicUbCc1foIssQZHer2XkhP8yfHHWEta7COfQWZwKPSL+GzoM9VuckUyrAuE3j2bGcpwfZPO85rvNdDg3bbZEs29ppp3JlCatpSwWWNaL3o490t21pbwHhitYQB1h+D37DyTHRNoIoNPiVGYb4YT+dMxBiO3z6HeAfPjVkL3KggdrKxr4gCetlRtBi1ww7VP7HsKEsjf5aUqaec9DrT0XLy0XDAMSzrr9kKvEWuAvB7ICcvg4+e9Wg4pxGfMKoy5IBjZcPYf3XqiIz/9EfvK+wDeNxkJzgJcOaHlDxGsKdIwAR2Fn/BMQ5Ca6sVI3B9DpmxOW+IeOtR2eh6LW0WROO4lPxWNDY6mpBBack06MOVB9tR9e5j2zvTrU3spo85sgOj6cb8Cd0eJDWczw535i2W7MtGPMjGsfeat9zg6lPjECMKRdUZGLY9/HvXY0MClf2N0kXkj/IiClg6jLZ/FZWp7mFQyYjBlWeQaY/5v7Wi/RmrCj7gpmFoMTRiPMpjJIzMHRJ3vpZDohQ7TfZwR0HuOqsdqY4K48eCpwBJ8MJTV5iGGndJ3itvEa7UY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(366016)(261102130727099003)(261026121527099003)(4143699003)(56012099006)(3023799007)(10067099003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9nhRUj0480/JLvPdj0sBme0iRfoW+eTOc0Z3hfaiVtK5A6LbrjkD8cY+tabg?=
 =?us-ascii?Q?U9NvZ+7e6VzQZgAKoFNKU5Uch+09GRgT5vry0kdBXgTjzNUpx7OQxBcbg5//?=
 =?us-ascii?Q?HLfNphAOogpym+23B61pV10vcw+vDiKjQyWXcO7cibHQTl0SlUGtDdkEo2Hs?=
 =?us-ascii?Q?oMcAEYe7DRBMqNc3L3fnPHeIZ7HzHTCDksptZjUdxb9bAeX/X5f7U6Uj9N+I?=
 =?us-ascii?Q?OviNk5Pm1cF1gUh9AOaGakN+jCTukhOIHUY/+sEHDaDL93W9Otor/rVeE4O9?=
 =?us-ascii?Q?0Rfzo1FKVb/sT8IRxwgLxWmmvDYYIT1YB++p2GUvzZW4x0rXl+WbCAfNhTdn?=
 =?us-ascii?Q?IxG6oxI/X5DvDDqMv4V+rlpPb2sXg3Nw6TQWgcucrBGbvM/wuKi7enAtgCAn?=
 =?us-ascii?Q?sYQsf+C1Lb2w2Lb61WAQdO29zyR7IWN5+ytU8rnlicK7WpxqzT13HzDpfgbI?=
 =?us-ascii?Q?D1QohAzZ6plHF21FwIMWj3n+03mmwnKOw6ltfa0tSt6/UFaGNSCBW0+oZEB7?=
 =?us-ascii?Q?f2UoZYpRR+DgzkvQe2LExOCdvUwxUbdO46B+KlH6cADzC2sJ+rLK8QHvSlKj?=
 =?us-ascii?Q?6CANUIjQfgVENAEuA/54qscZdA9QBQEFJo+26pfTliFWVwo5PEt6tg9zyAG/?=
 =?us-ascii?Q?gxBzw7ZnTzHw3x5S60vGZuUNdDTxsRf4yjRIkfLI/H/8BoOu/gBPkC6lj7Pe?=
 =?us-ascii?Q?ym2wvpG7L3kJ1p95Zcr0VmZOJ3lxI8FPm7HhbZFtVq/nHA60QWIdZoxnPRab?=
 =?us-ascii?Q?5xSKM19bAfJxQ/Nr8m6Li89QeHLf8rIfjewqQop4Reg9B9nopI29hQ3KF7Hm?=
 =?us-ascii?Q?kuZnoKcX/4os2vRnadP5DR+60qvAiZXBvP6RE2rUDjdJ8cukctas1d/BwiNN?=
 =?us-ascii?Q?CrMKWrAZP1jK+M/Xd81Ba6GHy0TcwEvevF/PMZ9CzGrgA9X0e3zzch+2wKzh?=
 =?us-ascii?Q?v905hJNH584x1cz7wlbhjHc4XOOmftekXLI5Xec4rVocMVJCJBT12rhNjqz3?=
 =?us-ascii?Q?KTufcQtcKC01dRi7BA+r4JgO/Gb/H9dMBa1LTyio8Xh3ULef7oNWLGuvWARr?=
 =?us-ascii?Q?gS34QBtOm7UvCEnqB9i5yr24QtvDabLiO3SsDlfDnsQfpWftmLHBkqvl6x9K?=
 =?us-ascii?Q?QweVErU60NQTz5gPrZbGAXfW9Ds1kC68WanK69W6bkrM2xCmDV2gbL/xwZPm?=
 =?us-ascii?Q?poENCBkX5gBQe3QWe1jdv1ruvNCgfWTMWTZ2kuSJvj7ROpq1FXYqdcvt31yA?=
 =?us-ascii?Q?SDNKo2VOXajwt8wD1D4bkGH+ICdQ9WG2Kl3OQH5QD805+orQPc8/6+fRXbhX?=
 =?us-ascii?Q?slQZrdT+f/9assZGUI4mJSr1vTJkjHc6xmybvEfFIbxypZM7fpM85BHKsM+x?=
 =?us-ascii?Q?mRL6uoeMZL91p8jhLLosku89sG20q3nPWOcLZKMUHedd4M0Cc7AEyTY3kYrv?=
 =?us-ascii?Q?5qE8nAgGgBh1jlC+ZGozRZyDVW+VrytnECHMJG2Pft8eUdw/5C7xoLqLxna3?=
 =?us-ascii?Q?d9I6cDe73AMZ2TZc/ckstY6HVCjQsc1LgQxJDuXcEDTDUiCc4CGtsNzXxtu9?=
 =?us-ascii?Q?MVGLcKgdAdWi0Cy6gjMP4V4A2oc4gAXyvXZMoCoUJowhxWgQIGRDVy4Kq9S+?=
 =?us-ascii?Q?QUmjjszxJih6aCfQUuC7hXDkn69oS6pWK+opX5aPRapPILMFJtC7DdmFESSB?=
 =?us-ascii?Q?/OEEUwNAGLBZ7eAg3sZzJLwQylq6qU6Xy2HRdCBpOf976evAHJ14SZT3fzw5?=
 =?us-ascii?Q?qPiijp6zeA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: AmkKvx8IlTXFLRQ+OS78a/vnP/RZWCbp563PBx7BtKdue5I2W85wmPRpiO65whM3PSAvtZAND+lP+MF9QHJ+TtqMSPPtd+bdb1DKqUncua3DychaMj4wrY+eTiDjKGmkA9le9AJAVzPGcUq28sXUUOMDxKZ5ulPySuxDpBNTneMuF1TujagZd9Poy8hDyN2tSp1WBOurdzT/3dSHGg6tLMfvItOHL7EE9fPf3vusEZYIIXIxNnr7He0P/BDmqkzV9OF4ofKeFvWBXBP6vUH74ypp0rAkYij3B1E+f5JkUZlg8ZlWhU//QSukJOmJU5kJFuIey8GnlNDDYA+vONHvfg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9475d214-bcd6-4a39-4986-08df3e0d268e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2026 02:57:11.1662 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b+600HePRCtb7CjFkyXpFdCfFq7+d3g2pbYc0xdFBdmqFfdOQJy6PIpTUIXzEAvbCd2qp02N9f81VH/HDjg7+awnP9kOxOA8cMvxBZm0CSI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR06MB8051
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Junjie,

> transfers
>=20
> Hi Jamin,
>=20
> On Mon, Nov 02, 2026 at 09:22:23AM +0000, Jamin Lin wrote:
> > +    if (!s->host_connected || !device || !device->attached) {
> > +        return usb_redir_ioerror;
> > +    }
>=20
> The device stays in USB_STATE_ATTACHED until the announce BH resets it, s=
o a
> control_packet in the same read as hello passes this check and hits the
> USB_STATE_DEFAULT assert in usb_handle_packet(). Checking
> device_announced here would cover it.
>=20
> For whenever you respin: stop_transfers() on a reset drops packets the cl=
ient
> may still cancel; usbredirhost answers them first.
>=20
> Tested: usb-storage exported from ast2600-evb enumerates behind qemu-xhci
> and usb-ehci, usb-audio behind qemu-xhci, and each SET_INTERFACE alt 1 is
> followed by an ep_info with the iso OUT endpoint.
>=20
> Junjie

Thanks for the review and suggestion.
Will fix it.
Jamin

