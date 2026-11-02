Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAFA606A33B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 09:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=CbH03vDu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNoGH-0007aN-1Q; Mon, 02 Nov 2026 04:23:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xNoFE-0007Jd-Py; Mon, 02 Nov 2026 04:22:24 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xNoFB-0000Wp-SV; Mon, 02 Nov 2026 04:22:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x423h1X35sAG0ni9T4S1K83dtrj9qT697ZNaAjQfwp+NUeM86JaX3YBvOwW5t7rpLZ+Bd6o5ALBkvMkKeMGMAzPlPeywc1IzDm7RkkhoaI+RHrXrX4nMk2yXxPsIsKsm9eUfKbDecyuDC+Tn20pQDPDF2EAk4FWoa/lBbRoZ9hzSX/OB+WK3UWRIgYs1ignAkCz0ivkbSE26Z3Gt5HZtVrVV5cyVGmn/Yuv1XsfwvZMu6g/ZhkW4bhTyM8/RIvXMNbPASoJaaRuE/NksfRhr+5LJ/RkPk5iTuj0VXDMFG+o8GdDc3hMPZo3gDf1k6+Fp8mJu/1oayUPx1OF1vmefTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lU6uLov+bGgZqeJWfdXeshDaWcQkZkWV94xA0Zrhckc=;
 b=k8nDCrA3pBz1m+QmczN65ZNMtEfow+4eZSDUgu8Glsu9jEpgq0vKtpHadWPuHlmbBEIRrvz8KFeL+BbxR1JzeNkCjVLNqBsn8bduGY0HUd9gYo804GSL9Be6Vaiw2mCI+1WsRYvcLcX19mVOFQDqg/fy7cPrIhmWcRtzPyl4kkAcFXDihh4+nrWrwaQl9GG58bZG89WOt8SPKlQbhGCBz6GmujEQW9mgZoG0cQX2H9aDC8U/xTsrLYhlfVCb/+ttqjlttN3KFXMTa9YvVuiRUTzsiYj5AK+epjcp0D8e20eWWo3lbt5n8dlHaceego96iLKGKNPrHPgzDAMkAh/+7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lU6uLov+bGgZqeJWfdXeshDaWcQkZkWV94xA0Zrhckc=;
 b=CbH03vDuxbtoRVN9Y6SPsgSDLadzD2L5xhk7DyFyMVrTQEAg4Hy2xPSTancuceoMc0zJJUslegP9kLWhxlqRUnHYpG1dDgDjRKMVbnXpziNelxLsWGu3HjPtAP7tLXBgwkXf9oE1mk4UDqYvyfWQlp4/JEUls21ZvTde2FnG21XYkF2Pd+Dy9DbFDKcoKPVdPRCZ6RqN07CrcFNnsprLDc+HbPjwzGMiyf6VA+YNHT1+G9t+jgHQS7hiMghHtvEYi/jlP7uBmoN0TreTD25zlEv/M6V0Fz/vxH6g80RJf467SY7JY6AK+PYQjaKlW/Ului3XRCPj59UaS7powpMa4Q==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SEYPR06MB7042.apcprd06.prod.outlook.com (2603:1096:101:1dc::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Mon, 2 Nov 2026
 09:22:14 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0592.007; Mon, 2 Nov 2026
 09:22:14 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "kraxel@redhat.com" <kraxel@redhat.com>, "marcandre.lureau@redhat.com"
 <marcandre.lureau@redhat.com>, "junjie.cao@intel.com" <junjie.cao@intel.com>, 
 "junjie.cao@linux.dev" <junjie.cao@linux.dev>, "clg@kaod.org" <clg@kaod.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>, Tyrone
 Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>, Zhao Liu
 <zhao1.liu@intel.com>, Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v8 08/18] hw/usb/bus: Turn off the automatic hub by default
Thread-Topic: [PATCH v8 08/18] hw/usb/bus: Turn off the automatic hub by
 default
Thread-Index: AQHdaqulsdqsJFeQ9EiqkOpgDuKOtg==
Date: Mon, 2 Nov 2026 09:22:14 +0000
Message-ID: <20261102092201.1729245-9-jamin_lin@aspeedtech.com>
References: <20261102092201.1729245-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261102092201.1729245-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SEYPR06MB7042:EE_
x-ms-office365-filtering-correlation-id: 00c3e1b9-ac5b-4edd-faee-08df38c2c85d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|10067099003|18002099003|22082099003|921020|38070700021|56012099006|261021121427099003|261022105027099003|261026140227099003|261009223027099003|261028144727099003|261021123027099003;
x-microsoft-antispam-message-info: aGEzX6gmeGQGPUgNIAoETceUHf97JkNAQ7P2lWvvNtA96FFZIvIY9HBpVIuhPnx0v2DfAqLrPWn8rDt0aky68lKUr5ww4QdASEZoSYzjKCUo0k5aXZc7UDj9yJ/Y3WjF/TmbLbwd0G8AV4lliSGeCSyKshLkCoFJHzBXizEJgrDUFxB8vh3ozkFYoHLNPJq1ZkSbWfS7RYiaVqEvGmqtyYtu6/yv9Mzcg0nk/XLszZbxI+iodP+bzAS0gkBEmGcLTffWQJKg6k8WDyI8Xr4Ve9fzbakzDhLXABPG9EPfyySihlXFYrn1AtxGqxQKCTFOvkN8Nwjr5OuaW8jEqQ0YUujO7xjQDpsLjFDydB89t5G/wob7RqwBY3Wv8ItfF3jdhHwMpFsVLx0dkhj4bSeZHOWJflf9N3x+S6lQlft1EoMUvhDzmaK/2PjD4AVasot0OmhU0b/566itSCgGH31UH9Ls/oIcYsEWVAAYBJetm094P265zSdz5ZpRC3K7WO6MyJoupbe3zp7gSsbqQXrNWIgrCxm2SCwSn8t9ULPGfGGb77tLsd+jY4aqqpglYEwHvqtX1hAQwsK9rFZrw/cX4gKJnLbIuO7YcejhW+QvWi7oU9FHtyvXHnSbd1s1TybZrk3HQ+P831cPZhX0HRmTZjvZn2AF/3b2ef70cHHMop6si5lHQ06yRsPM8y4RIKzwK9IfUISZF0hHW3Ub/PN0d5tyDXmSn1mOMeLJFE7OAKpxJTd8biMQAHvu3epCSS3+
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(10067099003)(18002099003)(22082099003)(921020)(38070700021)(56012099006)(261021121427099003)(261022105027099003)(261026140227099003)(261009223027099003)(261028144727099003)(261021123027099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JyEpNQgYdAzO5WEtdYxS+fqbEagzOLiILMLJRL9YItUpd8KPSW0Co1fBuo?=
 =?iso-8859-1?Q?P6ZZ9lmNHS6EnfI9cTLPO9/NEPTShc7CY2FRA1bQj2bfupew49SYrs+kBt?=
 =?iso-8859-1?Q?EDcQ25lnekPEODJ+MNhNa0FKjNCqnHSnrowWb8H14U+ipVGfoVfbgJmYdZ?=
 =?iso-8859-1?Q?v+QRiKQiXN95CaCZuB4iovgRAjUhToIECD8BHX2k3ArY5PATfaHsWENjUl?=
 =?iso-8859-1?Q?WOG6TBx4GYKi9MMTPkC1YievyhG5jRYN3fMo6BU8drRzrTJgA2yK4ZXmoM?=
 =?iso-8859-1?Q?NjkUq2JOabeBHhrSVaWgV8VnI5kbqYhgtCj32U1oNG6vIlQ82gNvgs6zvL?=
 =?iso-8859-1?Q?ctWZBfsyQjsXAopzHb9sIk9RkP3HJnYkRmvgW7VKbsg0Mjpka0IiBEhnTF?=
 =?iso-8859-1?Q?VW3kfyQHoLG4mabes7LsIngTVDjmL3r3cLTN0x9CiltyiPtjpdNLQfATV7?=
 =?iso-8859-1?Q?BgDWgt477NtmDpjNJqxSUGAR8WBYBb7hRwH7e2PhJ4notUFsfl64FyrKcf?=
 =?iso-8859-1?Q?gy7+5mGE9W8h/e69tKU6BFx88kjqVdO0XvKL9oJFuOnPIyD12kpFaN9O0Y?=
 =?iso-8859-1?Q?PXXuEgwFBLiWUW2qF0Eu8M1F/b0+NfuxM9QdYKQ2xmbvKb7zutDSRABoRv?=
 =?iso-8859-1?Q?5i1Z9inmYoTdEjdcaAgoXWzj8Qv13rEkQSQb8ygTgfOiHNQ6OO57Y1Z/SV?=
 =?iso-8859-1?Q?kgXLgj6iowYlib7dd0V2kYiIVfNUvtBB8/2hN21iEKbOd1nOE50To0Fbzk?=
 =?iso-8859-1?Q?1EnnkzEy8QXN3CUyKk+sGT4c/IBLbsMIynd7u/8k06EaspHwXuaKX+1KQg?=
 =?iso-8859-1?Q?yMIjbrq8NbM7MJla8iIXuG62Q7YpdwZZkzlbz5uLY5mKumUpo7uw1aJjh0?=
 =?iso-8859-1?Q?wwHf/GoIBZZD/daNNTZj6SoAnroSPhLPpqWTUTqOsnrM1ZqpPhKCQHs/Ei?=
 =?iso-8859-1?Q?d/vDkOq6wV3k+skiLsZ0LkkWK6EgQp+k/O7nkwFWVqX3PARXO2luCmnvs9?=
 =?iso-8859-1?Q?ANjNfjvJPpJjZzmMFI9DkS2ZlTSJhdSdec3OZbI/8FYNppnH+4gEXZ9WCG?=
 =?iso-8859-1?Q?VtZ4ySzVCKHXs90qNuxCiWUI47DiSNGMfIEsTet08ELyP3gnzNdAwJ8nI/?=
 =?iso-8859-1?Q?wbOeLhTGc6qFCKBpijaiGtRMqW06tCorkoUXaecJ2osS3C9nDwXIuvPHYo?=
 =?iso-8859-1?Q?qtTI4qjzpHTsN86MOvn9a1HjC+vqsune671m8uvUbkcz1KB/ezhp1Gzep5?=
 =?iso-8859-1?Q?D18SKkBg4fAIj7n93E9JwrHciLf6vbtMjKCadMVRzNU/zt0CDpJZsSXo4K?=
 =?iso-8859-1?Q?PM+Rwl5Z5QytaxQqP2e3rEpTnYJUrhLn8CWciypYdbahuk9HRQtEmnsYCS?=
 =?iso-8859-1?Q?SPRc8RMQquuERyz3OglvDNtqhcp5KyoHdK7r7MMtDB3bN5RLaQg9g0PB9Y?=
 =?iso-8859-1?Q?450YhkvNNdIh6CAoqDFHm9rS8R+QZII1VlWlKWFiKhGLAHJN+hk82IZNOT?=
 =?iso-8859-1?Q?68zD6VcpuFUeux4WZwRmM5DH5dWwyj4m4y9vHdk1Qqf3Cegq2+9TsunRkN?=
 =?iso-8859-1?Q?To1lftBgnIJAnwUbLen6XUxyPdmE9tEVB+WJ1WAfdgPNSjwGWH57z/mJZd?=
 =?iso-8859-1?Q?5Ix8see2hZVcMGjV0iTuCO/1yP7XCss+70FUei9DWkcFywXFcGnEeQZPM6?=
 =?iso-8859-1?Q?GpQN4yJBS2gA17PiZjx50GEilp2loQ66tURb04hfQkRhetqOL6bdDOx8cy?=
 =?iso-8859-1?Q?juyAnb6UZDPEO66ijkSFbhVqWrNkzWwejJZWXSX21rlYuo7gITUv4TaZ2X?=
 =?iso-8859-1?Q?+r3uhImtmw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YD/iLRdzUT1tG0jCMUyguyzUK7RyiM0rGP9rCSRUIzM5Fay61bClox3csWSTgZX6r2KZRV83mKpPCJgClvYOGfngPoYnu8VbkIno0RmV0iL8F1AwnhYOVNFYHgoSng/K3oXHBIWmpBo6yZOsS+X7boLHybTNjUebbgSouKejrQNj+pmsRXQ2rfR/6Xod0ByK+Z3QxVlxhPGWtAbdqL2YWnKfkxXNk7OoiZA1gijFqyt5Anmf4Zl39HKOef8KcNQZgA/ObRGQtmBgY+9v1GhjI1uoYqEtbD/Qp86d6BSGmxOnQvRrzXC6r/CuKLop0X7FWgCjXKUOfXpggVpyZgM2Sg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00c3e1b9-ac5b-4edd-faee-08df38c2c85d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 09:22:14.5632 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FEqjhM6JO3KGLmobHpLUb8Gj0/x5voIEwtzWsuk/6O4AIKTxDOseW7ZmvlqkFOzL0u4ejM0jamwhm5K1zrihcSZTdfcOpzidIV9CcHF0PUE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB7042
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Every bus creator now sets auto_hub from its own property, or clears=0A=
it outright, so the value usb_bus_new() leaves there is never read.=0A=
=0A=
Drop the line. A new bus then has no hub unless its controller asks=0A=
for one.=0A=
=0A=
Suggested-by: Gerd Hoffmann <kraxel@redhat.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/bus.c | 1 -=0A=
 1 file changed, 1 deletion(-)=0A=
=0A=
diff --git a/hw/usb/bus.c b/hw/usb/bus.c=0A=
index 92f67de4fe..cd587db892 100644=0A=
--- a/hw/usb/bus.c=0A=
+++ b/hw/usb/bus.c=0A=
@@ -92,7 +92,6 @@ void usb_bus_new(USBBus *bus, size_t bus_size,=0A=
     qbus_set_bus_hotplug_handler(BUS(bus));=0A=
     bus->ops =3D ops;=0A=
     bus->busnr =3D next_usb_bus++;=0A=
-    bus->auto_hub =3D true;=0A=
     QTAILQ_INIT(&bus->free);=0A=
     QTAILQ_INIT(&bus->used);=0A=
     QTAILQ_INSERT_TAIL(&busses, bus, next);=0A=
-- =0A=
2.43.0=0A=

