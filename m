Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1806606A33F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 09:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=maCiI1/I
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNoGD-0007V8-Hq; Mon, 02 Nov 2026 04:23:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xNoFG-0007KV-MP; Mon, 02 Nov 2026 04:22:27 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xNoFD-0000X6-L4; Mon, 02 Nov 2026 04:22:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dsGPgrnBA2oravjeJk9r01LBLChIFkLu41VIsTNn2HTUOYNVb+EPoTcUivcgpgFeps1SZXHPpDzI1h2bjygp8Beh1zH++ZBl/Q7DbnvBjvP+umZrxyOtsHx4kxpzMWO80JeJ9CTPO6/TRzdf0LT322YJ2WHLg39zxTF7TjjhVHxKgMC1u4lZ24XR0qZQv3rE+RenAbaUDYLZALtGIMLJc5xSVu0uFPpJBU6dWA3RVNn5/iiFB33mr/67p3VFJAVec2HIm0BLU5kjS+HGn3LG5BzslQp0Om4yW+RSPs4WW40qqBdBkbpzl0jyCqPkSsLmEmOBMqWeDzEtnwfN7lj7/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=icejiFuGpf+qVEtUBiMzeJvMEi17GcoPM9MYM4qmsik=;
 b=NxrHBcS2jBD7JozZjseyw9aG/FCgun8YL5tyhdAoeQOdt5XOoHauWclJnWuqy7ORp4MxGuoNMhzDVQu6h87UQWWAwenIDhihfDpe+nvs8ie4+6MLJG9OMtBe4EhKXrNCq2k8TZp47STPh4Zhhbb51Yyut8HkrkeXvOM9crFw0TjMf8euVi/iv1Xgsy2bYbNDOL6C/e3SnRRQaX0chc8ii/MPm/m/3r/fl4nzqEKtdRAVbgz7AyK15qc7KTopmlwcH64DziQr7wW6nJuEXw6NAdBYVuI3O+GSnzlxX1EmEsPXKIxpLXZbCFb8TLlUL/L9Lt/GSKm//qdKeT5N9BFFig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icejiFuGpf+qVEtUBiMzeJvMEi17GcoPM9MYM4qmsik=;
 b=maCiI1/IPo6RIDiHP4bILEa1zkWNHBcf9q5FmjkMyb9cOhB/abooHHmn8eW6hbWQjvPCZnv7Ma9zjH3MMtYlZCcgib6GuYe1VsC8wdV1835W4pj+fN/ipZyyku7khDtSDwWH2YPLHl3j2gUsRTLjBHSGmDZkD+oukEPgKzfUeZg20aXB1vHn7j/GCWBO2nAY+Scu/0VJY+QiFD2YyAkYr4MN9JlTNl4EXk4U73llbP0K4cAwYmCEScngw2QInobougXWmZVVZvsTOZXyOorXyeXFQQMehgzct4/SxKP+N/UpD5NqHO253ycrVLz55YN6iH7hW28vEDcXRBgR7X10FA==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SEYPR06MB6824.apcprd06.prod.outlook.com (2603:1096:101:1a4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Mon, 2 Nov 2026
 09:22:18 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0592.007; Mon, 2 Nov 2026
 09:22:18 +0000
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
Subject: [PATCH v8 11/18] hw/usb/redirect-server: Add a usbredir server device
Thread-Topic: [PATCH v8 11/18] hw/usb/redirect-server: Add a usbredir server
 device
Thread-Index: AQHdaquo7Sqzuz2N4UaAeTmCp9IJfA==
Date: Mon, 2 Nov 2026 09:22:18 +0000
Message-ID: <20261102092201.1729245-12-jamin_lin@aspeedtech.com>
References: <20261102092201.1729245-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261102092201.1729245-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SEYPR06MB6824:EE_
x-ms-office365-filtering-correlation-id: 98bbcd31-43c4-43f1-a02a-08df38c2cacb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|7416014|921020|38070700021|261021121427099003|260925022911599003|260925021311599003|260925021911599003|5023799004|56012099006|261009223027099003|261028144727099003|261021123027099003|261022075727099003|261022105027099003|261026121527099003|261026140227099003|10067099003|18002099003|22082099003|3023799007;
x-microsoft-antispam-message-info: vesjlse4eLK/zV9wuxXU2dsHnuD/zYZPxbrw3pPx4S2XX2JRSIXQpsrtJz1mYjfA34lK2Ewrkg+mDMYfU3fWXmjO+kEUHAYgJlKV1QOeaUKGf7ITJkQeALqUy1r0pqq5aYnPyN6rqLlNWkn4TUfkO2+eQ+/yzzTXmfPX3LTO+CGUE9OV7y0FPd+c45pC8tbwb3IyF5JyOcNUFeOI0Gb9HIPn70n5RhDIgMtXbmo6CB4mI9aR8AoTr6/21SHSORLrfe00qKIWeWqQbUodcDmD/ZT4uFv75k1zpBjBMJ8fn+stIgP9KVfLWW+7YRZXEyazT1GcumyaXHBQskgSdS9P2i43FMVyP/k0zxkNVoEBOvVQzNJF+1KFpGHNv+458wmOfwuB+Wql8UJw+g2J4FRkyV34OwSxYr5OXc4iCHqB3cx7IduouuCctnOv8pB4camtX/fM/MwJreXuVbNkQt6+biW5asN+e5RsPNCjtNsIodwE5atEENSHPx1CuuaTUpeTYpzAEghKPIn6Ry7w38GN+uY6JwS8e8V26HK51WltshRAkGrr4BEkraV4po3pETo5GJiAappWOiBbkNbAuGlFS8t0AB8Ds1Wp3A3HRF2daDh6lohXtPr0xgbuTypZdttZuMlIR2C9ntavG11gb94cWMxUp83dV2sy9Un03s2/OYJWSazLPsc8xBAooUeOeTsFbhwbqrBLEB/UzC3lrUBjfvMNAvM5+9YNCBMxOEC0RKTX7jR4hiWXzg+lVYV68gbX
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(921020)(38070700021)(261021121427099003)(260925022911599003)(260925021311599003)(260925021911599003)(5023799004)(56012099006)(261009223027099003)(261028144727099003)(261021123027099003)(261022075727099003)(261022105027099003)(261026121527099003)(261026140227099003)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NYairemVQg6BPPiGZQYRBhemXOuHTsHW7kYcO8NNhcKd/bIFbZiPMW6klC?=
 =?iso-8859-1?Q?51YoT3XZFQpOYjtnGjw3KgRbq23RzFQF5wuh4najQR7dlGMWBMs+lv2uEk?=
 =?iso-8859-1?Q?SkRUiusN+xlEUdqbyenWaaGPVPL2Ky/401UCDiIQAERRncxH4OcxcV9zVE?=
 =?iso-8859-1?Q?es2cOj+FWekps4OvAoNsA+jQg855oS6eXES/cEjbEBffUUOoLjDv4MZYG7?=
 =?iso-8859-1?Q?mFzZB9BEU4VbjvZFiM0CzafW976lmt9FEodt/JdelZeaBpkFaedU+etpGn?=
 =?iso-8859-1?Q?WL4reo2+xpn3DpL7/CqcZNcIfZGOdLhj/2A6SkdvFLKZLHjNMOynDyNE/m?=
 =?iso-8859-1?Q?AKSZuNq2xrENbk1w+KKSdbTj4Zc8GcqG6hSBYZagUDAXG07pJW7JLb9piG?=
 =?iso-8859-1?Q?W4h3xSNGLUybgmxIhnSXWgcMnhgdSb87xk9DqB+xAd88pezLGkWIiDdajY?=
 =?iso-8859-1?Q?+KEhKgq4hcgC0qiooAxB+X2qTPXeX1MLy334aexqL3+JdCD0w3gMt6/P+C?=
 =?iso-8859-1?Q?j+T1mnnZfdNfkkQ/texAD3BSJK7jVTS2PTVv7FtJZXPRgbIk5tnKxzI9H7?=
 =?iso-8859-1?Q?A9VlpFT9faaHAodvStynHbtlTyu9HB9OGjJ42sLDxVT2cHa2AfsS3ofqU/?=
 =?iso-8859-1?Q?3z9QjaWr7kW97YT2BgplfyCz7fnoEc3jnax9HKTaKHsxJ7FfcqsaolovIg?=
 =?iso-8859-1?Q?pYAqMD7eGm5N0r7kSVTLdKRuLwcSY7VHOYughIxaF0GlnAL1MtARrEvKht?=
 =?iso-8859-1?Q?RAhQzpI6xx8cgbHkJgkxGnksDBdNiVEODrNWDicTX3joNCOrMTkLnGKS1P?=
 =?iso-8859-1?Q?NZAvwdO9kH6mCeIqVBztA+msPr9VoEfDnmBhHvy/l9zIyfv3qsO/otHuJ9?=
 =?iso-8859-1?Q?6aIhOQtuLQ7aVD1oOCzXEM26trWZHakAnXVYRYZcOqgCGPFhPnjIP73lul?=
 =?iso-8859-1?Q?I4KtL8WBCi/sdHqgNvfM7FvYWQK96kWhR0oasnGVZlsQNcHLi3LRlnqgKR?=
 =?iso-8859-1?Q?dcKBJEfyoBjWzcwzPd5nakymgR/TBp6o3GDlkL3FfkBJw47TeZRdtkHxDX?=
 =?iso-8859-1?Q?kqlDs94aXJVJHIV7DJPKCw3FZFEGu1DGJKwYpkRgSMRhlAnkO8u3/5r1KW?=
 =?iso-8859-1?Q?qqk1w+7UvgtPFUk/yY8c4PQ+5kiYA7W76aOZ6xsrsLlxYK7Aj73UfuFElQ?=
 =?iso-8859-1?Q?O9lxItwINABcrm44UFZ/04AY/JBdKBtUXLX7filsee7OzLlvyl4rCNYeZa?=
 =?iso-8859-1?Q?ZiB+QqeNs93OXdKKSrcDskn3YooE3zJaMgvbPx2K39tlhLS7Cxl3/mf0D5?=
 =?iso-8859-1?Q?mzq5Vo04wI+qyGxl/1xrcNMjtNrVnQzwc+7ALgGaVCKmQzkTUwJ9GFjg9n?=
 =?iso-8859-1?Q?WSC+4rjldDE05mjmqoY3v5NCB3SbGYZOCwlVFmLrJRmmIhtHrwVpYkxnaU?=
 =?iso-8859-1?Q?AYdMefqFyS61T3x3HPnOElFt+akGr752bS12aHGcFLrjWJgq030OUpCeEj?=
 =?iso-8859-1?Q?9GUlBdAiO4E9yK7FVl7uOGxTWbwAWuRYUPCsj+fvJcIqKQjqCjcCKPf//s?=
 =?iso-8859-1?Q?0eQ9Jps4HYHPj3hbUraoA2eyBoL4t0BPGiwyF2EkqkLrxqf6Nis5DXKmv9?=
 =?iso-8859-1?Q?L3U/35r8n/tUe5BFAHk9yfnX5M8r4M6YYll1mlyoDrd1gTvaezN9KsEEn7?=
 =?iso-8859-1?Q?gS8ZFwHMLIQMUffM5rMpU5MDPu9MWFvgCYuuUBfrbAmbLdU81C5vrdV4Q/?=
 =?iso-8859-1?Q?jXDh/7kuM8XA3Gi2X2+0OxmxYr4u++dxHz9/P2BgSjfL745hSvI/soIwly?=
 =?iso-8859-1?Q?RC6uJmDf7Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Xz4+eyfZeW8S4sc9XLKUESa8fQsVDp/ZBKqAEO0XtelsBelcGiYYFSeWoo/Kj+Hh2/bn4TNyLTv6RftZ8ivl21+gczoc4FeqinstSZli8HSvdfHQ8ednuglemgiGtVGjrZvTKvTOE0wLZRqGW2F0ciKFUbyYU0FyOQXixZjilDgHP0d+kBP3VGhoWjXY3HgjvHnZ5PGoLvlRL95jJwsvrsWW7pWE0vldy62NhSjLuPEy7eWRjmgPQOgIAig8NszTmFbeQOfLn6oQq3foP7HufJA62znDMPL7YuF2vybKfMMDD4ZNfRs1CArifMkde4EfuU2eqZ9asjf8B9MeDdqbHg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98bbcd31-43c4-43f1-a02a-08df38c2cacb
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 09:22:18.6471 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /8dRNTocBydkQUUUZEalZdCiPQ4/CFrceI+PDWdhTDFVPrfPGtFF0NC+w/W9vYVaKgJoi1Do5ztoIubaOrr1E84an/Ja/0MFkKF0lXWUHzg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6824
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

Add "x-usb-redir-server". It exports a USB device from this QEMU to a=0A=
USB host in another QEMU, using the usbredir protocol. The other side is=0A=
the existing "usb-redir" device.=0A=
=0A=
The name has an "x-" prefix because the device is experimental. It has=0A=
to sit on the sysbus so that qdev can find the USB bus it provides, and=0A=
that may change later, so the name is not fixed yet.=0A=
=0A=
The exported device is plugged in with "-device <dev>,bus=3D<id>.0". So we=
=0A=
have to provide a USB bus. To find that bus, qdev starts at the main=0A=
system bus and walks down the tree. A device that is not on a bus is not=0A=
in the tree, so the bus it provides cannot be found. We have to sit on=0A=
the main system bus. That makes this a sysbus device, even though it has=0A=
no MMIO and no IRQ.=0A=
=0A=
usbredir carries one device, not a bus. A hub cannot be exported because=0A=
the protocol has no device address field, so only the device on the=0A=
first port is redirected. To export several devices, run one=0A=
x-usb-redir-server per device, each with its own chardev.=0A=
=0A=
The link to the remote host is a chardev, so this device cannot be=0A=
migrated. Its VMStateDescription says so with unmigratable.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>=0A=
---=0A=
 hw/usb/redirect-server.c | 143 +++++++++++++++++++++++++++++++++++++++=0A=
 hw/usb/meson.build       |   3 +-=0A=
 2 files changed, 145 insertions(+), 1 deletion(-)=0A=
 create mode 100644 hw/usb/redirect-server.c=0A=
=0A=
diff --git a/hw/usb/redirect-server.c b/hw/usb/redirect-server.c=0A=
new file mode 100644=0A=
index 0000000000..1423564d22=0A=
--- /dev/null=0A=
+++ b/hw/usb/redirect-server.c=0A=
@@ -0,0 +1,143 @@=0A=
+/*=0A=
+ * USB redirector, server side=0A=
+ *=0A=
+ * Copyright (c) 2026 ASPEED Technology Inc.=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ *=0A=
+ * Exports a locally emulated USB device to a remote USB host over the=0A=
+ * usbredir protocol, so a device emulated in one QEMU instance can be=0A=
+ * enumerated by a host controller emulated in another one.=0A=
+ *=0A=
+ * Architecture. The left column is a request going to the device. The=0A=
+ * right column is the answer coming back. The middle hop carries=0A=
+ * usbredir messages over a socket. The top and bottom hops carry=0A=
+ * USBPackets inside QEMU.=0A=
+ *=0A=
+ *     remote QEMU: guest driver -> EHCI/XHCI=0A=
+ *              |                     ^=0A=
+ *    USBPacket |                     | USBPacket=0A=
+ *              v                     |=0A=
+ *     "usb-redir" (the client)=0A=
+ *              |                     ^=0A=
+ *     usbredir |   chardev socket    | usbredir=0A=
+ *              v                     |=0A=
+ *     x-usb-redir-server (the server, this file)=0A=
+ *              |                     ^=0A=
+ *    USBPacket |                     | USBPacket=0A=
+ *              v                     |=0A=
+ *     any USBDevice, "-device <dev>,bus=3D<id>.0"=0A=
+ *=0A=
+ * "usb-redir" (hw/usb/redirect.c) is the client:=0A=
+ *   - it takes a USBPacket from the remote guest and writes it to the=0A=
+ *     socket as a usbredir message=0A=
+ *   - it reads the answer from the socket and completes the USBPacket=0A=
+ *=0A=
+ * This file is the server. It does the same thing, but backwards:=0A=
+ *   - it reads a usbredir message from the socket and runs it as a=0A=
+ *     USBPacket on the bus below=0A=
+ *   - it takes the result of that USBPacket and writes it back to the=0A=
+ *     same socket as a usbredir message, for the client to read=0A=
+ *=0A=
+ * A USB device has to sit on a USB bus, and in QEMU a USB bus is always=
=0A=
+ * made by a host controller. So this file makes one and acts as the=0A=
+ * host controller on this side. It models no real chip: its cable is=0A=
+ * the chardev socket. The real host is in the other QEMU.=0A=
+ *=0A=
+ * usbredir carries one device, not a bus. A hub cannot be exported:=0A=
+ * the protocol has no device address field. To export several devices,=0A=
+ * run one x-usb-redir-server per device, each with its own chardev.=0A=
+ */=0A=
+=0A=
+#include "qemu/osdep.h"=0A=
+#include "qapi/error.h"=0A=
+#include "qemu/module.h"=0A=
+#include "migration/vmstate.h"=0A=
+#include "hw/core/sysbus.h"=0A=
+#include "hw/usb/usb.h"=0A=
+#include "qom/object.h"=0A=
+=0A=
+#define TYPE_USB_REDIR_SERVER "x-usb-redir-server"=0A=
+OBJECT_DECLARE_SIMPLE_TYPE(USBRedirServer, USB_REDIR_SERVER)=0A=
+=0A=
+struct USBRedirServer {=0A=
+    SysBusDevice parent_obj;=0A=
+=0A=
+    /* USB bus */=0A=
+    USBBus bus;=0A=
+    USBPort port;=0A=
+};=0A=
+=0A=
+/*=0A=
+ * USB port ops=0A=
+ */=0A=
+=0A=
+static void usbredir_server_port_child_detach(USBPort *port, USBDevice *ch=
ild)=0A=
+{=0A=
+    /* We only export the device on our own port. Nothing to do. */=0A=
+}=0A=
+=0A=
+static void usbredir_server_port_wakeup(USBPort *port)=0A=
+{=0A=
+    /* We do not pass remote wakeup to the host. Nothing to do. */=0A=
+}=0A=
+=0A=
+static USBPortOps usbredir_server_port_ops =3D {=0A=
+    .child_detach =3D usbredir_server_port_child_detach,=0A=
+    .wakeup =3D usbredir_server_port_wakeup,=0A=
+};=0A=
+=0A=
+/*=0A=
+ * USB bus ops=0A=
+ */=0A=
+=0A=
+static USBBusOps usbredir_server_bus_ops =3D {=0A=
+};=0A=
+=0A=
+/*=0A=
+ * Device registration=0A=
+ */=0A=
+=0A=
+static void usbredir_server_realize(DeviceState *dev, Error **errp)=0A=
+{=0A=
+    USBRedirServer *s =3D USB_REDIR_SERVER(dev);=0A=
+=0A=
+    /* One port: usbredir carries a single device. */=0A=
+    usb_bus_new(&s->bus, sizeof(s->bus), &usbredir_server_bus_ops, dev);=
=0A=
+    s->bus.auto_hub =3D false;=0A=
+    usb_register_port(&s->bus, &s->port, s, 0, &usbredir_server_port_ops,=
=0A=
+                      USB_SPEED_MASK_LOW | USB_SPEED_MASK_FULL |=0A=
+                      USB_SPEED_MASK_HIGH);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * The link to the remote host is a chardev, and we cannot migrate=0A=
+ * that. So this device cannot be migrated either.=0A=
+ */=0A=
+static const VMStateDescription vmstate_usbredir_server =3D {=0A=
+    .name =3D TYPE_USB_REDIR_SERVER,=0A=
+    .unmigratable =3D 1,=0A=
+};=0A=
+=0A=
+static void usbredir_server_class_init(ObjectClass *klass, const void *dat=
a)=0A=
+{=0A=
+    DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+=0A=
+    dc->desc =3D "USB Redirection Server";=0A=
+    dc->realize =3D usbredir_server_realize;=0A=
+    dc->vmsd =3D &vmstate_usbredir_server;=0A=
+    set_bit(DEVICE_CATEGORY_USB, dc->categories);=0A=
+}=0A=
+=0A=
+static const TypeInfo usbredir_server_types[] =3D {=0A=
+    {=0A=
+        .name =3D TYPE_USB_REDIR_SERVER,=0A=
+        .parent =3D TYPE_DYNAMIC_SYS_BUS_DEVICE,=0A=
+        .instance_size =3D sizeof(USBRedirServer),=0A=
+        .class_init =3D usbredir_server_class_init,=0A=
+    },=0A=
+};=0A=
+module_obj(TYPE_USB_REDIR_SERVER);=0A=
+module_kconfig(USB);=0A=
+=0A=
+DEFINE_TYPES(usbredir_server_types)=0A=
diff --git a/hw/usb/meson.build b/hw/usb/meson.build=0A=
index 429dcd6a24..0061b935e6 100644=0A=
--- a/hw/usb/meson.build=0A=
+++ b/hw/usb/meson.build=0A=
@@ -78,7 +78,8 @@ endif=0A=
 if usbredir.found()=0A=
   usbredir_ss =3D ss.source_set()=0A=
   usbredir_ss.add(when: 'CONFIG_USB',=0A=
-                  if_true: [usbredir, files('redirect.c', 'quirks.c')])=0A=
+                  if_true: [usbredir, files('redirect.c', 'quirks.c',=0A=
+                                            'redirect-server.c')])=0A=
   hw_usb_modules +=3D {'redirect': usbredir_ss}=0A=
 endif=0A=
 =0A=
-- =0A=
2.43.0=0A=

