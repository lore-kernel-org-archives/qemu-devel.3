Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22DD4C7115F
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 12:30:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRrtc-0006AH-Te; Wed, 18 Jun 2025 08:28:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uRrta-00068s-UR; Wed, 18 Jun 2025 08:28:03 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uRrtZ-0005VZ-1A; Wed, 18 Jun 2025 08:28:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YZPL65l2bNBWbwVtIQxBKw+HECkoAYowjd3zQrNbOwI8N6xgwTWnxoRaaw/r0Mh1FBsD3uVRnG5CDpfgBEiANCRdcKFucnY1IlmUY4dHElirEjNmia+woX6xNQdHVQ+vkfhNm2dHXNZsDBAOY6/VxdlWx3u/vMR17w/fuaGGrnonPKX8h0zUn5lmVjV2J0A8Eq5R/f/m0OK6lwji/ap9waPumMGuxuNJDkSdurobDEXMtOsJOkAtrkSe599w+wqOyMddOmJ27uVNpjx9Afu87Eyyqri3t/GE+FfaAoCCWUVRy3sg4CQtMVKM2W8pOKCam8bWSHzmAaRHUFZGL8U2Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JiwNdw8m75e3rwLVVi7gW51vg8p4l6Hkr5fZ00vCmEA=;
 b=ot7DNBNXbir0BSbTrHKleaXQYBtbQvUMS181VKUB/IL5ykohwkQtFJpzrn5aoxYZ1rzEquiBGyFx51rwxPAgcwT0dkvJfb6HS2w4xGe6QAmhOXxA4ycW+WIBmKPf+VGz7a83vfCQ7YP2v43WP29MPrFmBqWJt1T7lRhNGSM0CCrJJHElKoXJJjxQdyqBHzeoqETJalwFDlTPmonm1ciOSqYab6bglntU/tTV+GpGWwNX0RTd0pkWgHXmMduPFQ2e6uTOZ3Nww2YGTOSPju5QaAn+7Opk7OdEKjenXAYb9G9gpxVFDFNwnVBmLJAbuCahbeMinTF2xRVYClxLbUCp+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JiwNdw8m75e3rwLVVi7gW51vg8p4l6Hkr5fZ00vCmEA=;
 b=OtAKi0WslBaeMoOT8lxCwHAzJiBI6IoVTL3Tl8UYnafUQzWFf5p4150LyALO5qGWYi+1B5jJ7QlQg5oWUuPHxE5idQV152lHt+11rrRtbng+UJh2vCjqwydZ5O7iNyAuC6RVMvZffA39fP23FjcigsaAcDlF6Yv0CnPtdWio+kcEK9/LRoZBtCkkzyHZmxfE7bbWqVQTa6WKAjf3bVuqGC+fhKiWK0OIhKBiguBMhz9vU5MGFahEQKl+DWii4Jubsai/KBuDsxv3DE4JydKqazKimZvTO0732dP3QOYjLl4peqt1KYkKyRK9jVREExdyrlHCNZE2N7JAmb7O8CV+hA==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by AS1PR09MB6509.eurprd09.prod.outlook.com (2603:10a6:20b:482::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Wed, 18 Jun
 2025 12:27:49 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%3]) with mapi id 15.20.8857.016; Wed, 18 Jun 2025
 12:27:49 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v3 06/10] target/riscv: Add mips.pref instruction
Thread-Topic: [PATCH v3 06/10] target/riscv: Add mips.pref instruction
Thread-Index: AQHb4Exm/tXXv3WtnEm9iQBFr7lbkQ==
Date: Wed, 18 Jun 2025 12:27:48 +0000
Message-ID: <20250618122715.1929966-7-djordje.todorovic@htecgroup.com>
References: <20250618122715.1929966-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250618122715.1929966-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|AS1PR09MB6509:EE_
x-ms-office365-filtering-correlation-id: 9d333f32-b44a-4cc1-ceee-08ddae63898e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|13003099007; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?CKo/zMwUaKLqMAijaZmwWztHFXVQGvfReMBugBcyVLVywl3WVdgqKzPlW1?=
 =?iso-8859-1?Q?dadKHv/9dn0Ant7Px3UGY6L762KhOB3lQ/3vMwIXgAMaHKPutpMcA0HGkl?=
 =?iso-8859-1?Q?C8XU1XwEa7eS2XLCilQt/v0d3apbNtcLmiVB+3vOMtA4Qw2hu6TTDkQyzU?=
 =?iso-8859-1?Q?zkQ0JhY1LiKnOy2Jia5jP/v3eRZSMI1dX1HVSeGAjS/9YgdJkvb/wL+/Yi?=
 =?iso-8859-1?Q?siKZZWKPZ6K3FXnGuofPZBXtNuMyR9VvOPpnYo52z7pYSP9tu4toqv1dpJ?=
 =?iso-8859-1?Q?OpScRT8Gw4n2vRndgPki9oYLKm4cZTRQdYecFHhUGq8exaSfrjDU2p3+3o?=
 =?iso-8859-1?Q?RGd3fj++VQN8zCHarJxfBvXSEEGfbuF2jCcfU1qep394yYkk6pU9OxPxJn?=
 =?iso-8859-1?Q?qTbHI50xRh8OxUkYNLFz9ZeDn3Dq2HP1pSiiTAkL3oq38bWOoQ5k+68ivc?=
 =?iso-8859-1?Q?n9kRXy8icYJNx3ARdqgeKjTkOtEfhddxBiRgNpAllKpR3kFMKS2Ll3/xWJ?=
 =?iso-8859-1?Q?9LahrHfRrMcDdDLOy0edyxHs/zNuLiBpMEHpwxdkPvV6Hprz4qYDSba3n2?=
 =?iso-8859-1?Q?Kv6aZAqQZN19/lH+g6hyGL5JOXDPyNNk6BHAmKyihkmZZoZVkeYdBUGC0B?=
 =?iso-8859-1?Q?LN8oiHyTVXAitrrO+RrSScXY7uxQStsERWgunadCD1HzSc2z63KAgltMrf?=
 =?iso-8859-1?Q?jciI8GHbbli3/Y/ABBdQoSPhmBYuvLAyQBHUEBFrvKZt8jEFEyXizwf//l?=
 =?iso-8859-1?Q?ZqpBeAOFEuzqh4L8qT9KqXjcwKgZ6R1qOQ+vbCrMQUOfKWM9hwlQBBjTrC?=
 =?iso-8859-1?Q?Jkf9IzkcKzJNV8rucvSpcsShz2yzj0J45zcC/p40i/OLSIzFcCbm1bjbMX?=
 =?iso-8859-1?Q?l3iknyEnsjVdBM4tm6OTh5ErLioR+nMKpxqCaWT3OzfshecVQtw9UHaUjz?=
 =?iso-8859-1?Q?Q0J/zz0gFbUZ2yzUoeInldQm1xMDz+xe38+3OLwt3TkzdhKzO8A2RZXNNg?=
 =?iso-8859-1?Q?NaNiYN3dBl0UhqjKtnTtXZXN5jNT5JjLbL7heLIe2N1QuyR5NIrqEIcw2w?=
 =?iso-8859-1?Q?dIUQ+h8/TblDH5sl1spXyB6oZFNfROebE3kdoVfMqF9pgQ48xx+LpMG0NO?=
 =?iso-8859-1?Q?ZRNnUfiFEiLBZu6/mGUARgN/6xelP043O819+G3xdcW7JG9us9XEd6G3lE?=
 =?iso-8859-1?Q?MXGRobLVQhCWQoYlFxnjmJRZYZl+VccwvO9VnGXiG9T2M6H3REzLp8sVsd?=
 =?iso-8859-1?Q?LDo+V/JpDfkKD6tUo4y6EKW4iclT9MjaHy/kT4Jv5sXML8Bm9jKUvgxsG3?=
 =?iso-8859-1?Q?p8uG4YQyEcMF5/P8UGqlUKWGAwbrZoL6fiVwxQypFnocS7rdqc0+AgKMBu?=
 =?iso-8859-1?Q?nnyTX1eI5cU74pjQ4cEbSgqWcVjSyu48Txb3vsAP2zVQt/S4UOU4jrH4ek?=
 =?iso-8859-1?Q?q/38bpBrlMj1Fw489g56v3/FHFbQNhchA/cgDdrUcz8peT45y+zm4WikNt?=
 =?iso-8859-1?Q?GC1UUs16O7cDH2kXXqqMLIyvm8JUoG3XFBkBZSZ7NLbjN0dxEVHKs83XdP?=
 =?iso-8859-1?Q?gckqEZo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(13003099007); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5aKhTTBavIH/q/PZNFwDeE/qg6COmfskdxYD+/a1hoInZKKKqHTHw5d3Tu?=
 =?iso-8859-1?Q?0fT93MbH+LCQbgdGbIJGWWttBU3qCmZJBChPTVkSqUy60I0NA0HbBuvJL7?=
 =?iso-8859-1?Q?No/JPT03qc1MKj3eccahe1CthzEM7fjOvp5COHyfV5UjXWaNgrR4awmSAs?=
 =?iso-8859-1?Q?33Wewtx3N4V12ACKO2G7rijs/3XWXhUvLgPWmiZsVMcH2zWCX/xs2pJYPQ?=
 =?iso-8859-1?Q?CpcsiKSFqWBG6eQX3zmCpuLJWYSZ/IOT3EDmuENr8RQiOfBVPrs7xYZlF6?=
 =?iso-8859-1?Q?BUFi4L14eYx9yCIU0GU3+CBwsVG8Pab7eR8SKgFMqadSoW25+nkIqUTWfh?=
 =?iso-8859-1?Q?8qVuwSzx/faCsjmvylU7CE3Je0WGmCVVAHmonJvqM1OgyvSC6M7CNf4QHv?=
 =?iso-8859-1?Q?vzlUx9mKws3G5qE66vyNj9HDOx2CM7qZ5bWbw5d6e4rKxQcS+A29IRPwND?=
 =?iso-8859-1?Q?SSCR8Pqat41bD7UhQB4zGh6x0+NeyznLouV9Y+BCD9RzcpwLhKzVDtfJXG?=
 =?iso-8859-1?Q?mB9WCX0cYh3CgJ2zobeft3KSxqQQDi2YNCfNSq8W1S1pzVep70zUL6kkS1?=
 =?iso-8859-1?Q?uZ/lJZHQiriFIhrdotpw0EhLU6fhWecLuiScg6b+i+EuP3chRsAbj68SOw?=
 =?iso-8859-1?Q?NFbAdtBGXZy+CLIV3ktw8qfmczkaM1XQ/E12HIhaygx4yt6pnOMR4xKkuP?=
 =?iso-8859-1?Q?4GntvKneBSNg6j2VMWHiQAH9DLd9lUsxHHubeCItj1Dpfy8i8zKQdTntAE?=
 =?iso-8859-1?Q?wnWLUa2RMXTdEjh7uVuTt3ZuRcxYEsVtIK8ZseQUVOyQJdUgF9P38vxDcq?=
 =?iso-8859-1?Q?/5r7AogmhgGSEmqEapcAXJ8f5Vo8wvv5tWCgtMCor52k3d3xJHGAssJs7q?=
 =?iso-8859-1?Q?9VvwjJoS+JdWbEz5P4uKk/wES/Ee80kq7w4Om5PslOUmRvq1CU1e8X0fbM?=
 =?iso-8859-1?Q?QKTl6OE355+W/yVyLa7V0HwSp/NTfCTMzah4X2YpbPx/AbrIjEL513HaIt?=
 =?iso-8859-1?Q?IhG2RKvEGFouU5MSBwgBCVIUJ6U+yqnSUt/33R2tr6KrTqHTtaVNxYwdBi?=
 =?iso-8859-1?Q?VTl8s63kCbxARv1m3tNHvgETv4XcdyoHiicvD8pC++UsVH22bvrbzeYNO0?=
 =?iso-8859-1?Q?Fl9AnQPqYehUNhVPQxNVt+8YaYUUUQtcB5DhtowtngK/TIyChbilws8Htk?=
 =?iso-8859-1?Q?ixrDuRjzs7Mo6QSIWgC2LT6XdUoJawSPSEFJpW3mmfDNcW/ZYELk//1SnA?=
 =?iso-8859-1?Q?V9dwmvg1BTFLWH/x3g+awDQ+Hn4mSTw+OjXtG04we61a/n1Bg2U2GEDwoI?=
 =?iso-8859-1?Q?v4givoxFZyvrliTgpKx0mtM0EPhaBFXD2RiIvN/71Uj6ciwiar868QHG7d?=
 =?iso-8859-1?Q?rSkl97dWoQzO1XYKgvokPCqjAYBK9h841zqcOc1GEo/Iu2lDLSO3zq8bA2?=
 =?iso-8859-1?Q?NYpY3LORsIqrvlMME6QJFj+bU3s0SRKn+XOySO26EIV2rhhJwrCsZFgX9e?=
 =?iso-8859-1?Q?17UbY/Qty8xYmYJJvrXnDgl0gzV6AZw/R0fRmol9BmF7vDDnEAyWnUr9gT?=
 =?iso-8859-1?Q?ypLjd1HnX0bxpfP1G8Iwc9YLx6Yjyy8Rvq9ZumqmFM3DhzjmaknHdNIe4t?=
 =?iso-8859-1?Q?wPHTo6j3TYCLnMh7sbdbR/hXcZ4kG4jZ6svXDEdqkn++6fBCM/R+vr6+Uc?=
 =?iso-8859-1?Q?9FjCQ8yjDOLzogBagr4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d333f32-b44a-4cc1-ceee-08ddae63898e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 12:27:48.4771 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kLTa8UBMt4PXnMlhraaZQ71ozwtSuqL5jGxRJ/LhF6/O9XhWwyKCJSYrVFgdjQ8MFHXjWmz+qSPkf9bo+pScO6HGKzJYbv0lH9DS7D2ejqo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR09MB6509
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
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

Add MIPS P8700 prefetch instruction defined by Xmipscbop.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 target/riscv/cpu.c                        |  3 +++
 target/riscv/cpu_cfg.h                    |  3 ++-
 target/riscv/cpu_cfg_fields.h.inc         |  1 +
 target/riscv/insn_trans/trans_xmips.c.inc | 14 ++++++++++++++
 target/riscv/xmips.decode                 |  1 +
 5 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 6ed767e922..c96bf08edd 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -242,6 +242,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
     ISA_EXT_DATA_ENTRY(xtheadmempair, PRIV_VERSION_1_11_0, ext_xtheadmempa=
ir),
     ISA_EXT_DATA_ENTRY(xtheadsync, PRIV_VERSION_1_11_0, ext_xtheadsync),
     ISA_EXT_DATA_ENTRY(xventanacondops, PRIV_VERSION_1_12_0, ext_XVentanaC=
ondOps),
+    ISA_EXT_DATA_ENTRY(xmipscbop, PRIV_VERSION_1_12_0, ext_xmipscbop),
     ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
=20
     { },
@@ -1361,6 +1362,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] =
=3D {
     MULTI_EXT_CFG_BOOL("xtheadmempair", ext_xtheadmempair, false),
     MULTI_EXT_CFG_BOOL("xtheadsync", ext_xtheadsync, false),
     MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
+    MULTI_EXT_CFG_BOOL("xmipscbop", ext_xmipscbop, false),
     MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
=20
     { },
@@ -3180,6 +3182,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .cfg.pmp =3D true,
         .cfg.ext_zba =3D true,
         .cfg.ext_zbb =3D true,
+        .cfg.ext_xmipscbop =3D true,
         .cfg.ext_xmipscmov =3D true,
         .cfg.marchid =3D 0x8000000000000201,
 #ifndef CONFIG_USER_ONLY
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 2db471ad17..9734963035 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -22,6 +22,7 @@
 #define RISCV_CPU_CFG_H
=20
 struct RISCVCPUConfig {
+
 #define BOOL_FIELD(x) bool x;
 #define TYPED_FIELD(type, x, default) type x;
 #include "cpu_cfg_fields.h.inc"
@@ -38,7 +39,7 @@ static inline bool always_true_p(const RISCVCPUConfig *cf=
g __attribute__((__unus
=20
 static inline bool has_xmips_p(const RISCVCPUConfig *cfg)
 {
-    return cfg->ext_xmipscmov;
+    return cfg->ext_xmipscbop || cfg->ext_xmipscmov;
 }
=20
 static inline bool has_xthead_p(const RISCVCPUConfig *cfg)
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_field=
s.h.inc
index baedf0c466..9ee0a099bb 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -145,6 +145,7 @@ BOOL_FIELD(ext_xtheadmemidx)
 BOOL_FIELD(ext_xtheadmempair)
 BOOL_FIELD(ext_xtheadsync)
 BOOL_FIELD(ext_XVentanaCondOps)
+BOOL_FIELD(ext_xmipscbop)
 BOOL_FIELD(ext_xmipscmov)
=20
 BOOL_FIELD(mmu)
diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/insn_=
trans/trans_xmips.c.inc
index 269b1082a6..6555a6062a 100644
--- a/target/riscv/insn_trans/trans_xmips.c.inc
+++ b/target/riscv/insn_trans/trans_xmips.c.inc
@@ -19,6 +19,12 @@
  *            (https://mips.com/products/hardware/p8700/)
  */
=20
+#define REQUIRE_XMIPSCBOP(ctx) do {              \
+    if (!ctx->cfg_ptr->ext_xmipscbop) {          \
+        return false;                            \
+    }                                            \
+} while (0)
+
 #define REQUIRE_XMIPSCMOV(ctx) do {              \
     if (!ctx->cfg_ptr->ext_xmipscmov) {          \
         return false;                            \
@@ -40,3 +46,11 @@ static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
=20
     return true;
 }
+
+static bool trans_pref(DisasContext *ctx, arg_pref *a)
+{
+    REQUIRE_XMIPSCBOP(ctx);
+
+    /* Nop */
+    return true;
+}
diff --git a/target/riscv/xmips.decode b/target/riscv/xmips.decode
index cb334fa4bd..697bf26c26 100644
--- a/target/riscv/xmips.decode
+++ b/target/riscv/xmips.decode
@@ -9,3 +9,4 @@
 #            (https://mips.com/products/hardware/p8700/)
=20
 ccmov          rs3:5 11 rs2:5 rs1:5 011 rd:5 0001011
+pref        000 imm_9:9 rs1:5 000 imm_hint:5 0001011
--=20
2.34.1

