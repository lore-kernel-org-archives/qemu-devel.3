Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43135E7716A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 03:15:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLw9B-0003sd-Pr; Thu, 12 Dec 2024 22:15:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tLw97-0003rg-TY; Thu, 12 Dec 2024 22:15:18 -0500
Received: from mail-tyzapc01on2070b.outbound.protection.outlook.com
 ([2a01:111:f403:2011::70b]
 helo=APC01-TYZ-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tLw8x-000358-II; Thu, 12 Dec 2024 22:15:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tzqte0zE3AeqPb4/AOosy/sZ9jcVWvvEatEJK0KAaoXuZONuBouVb4zxetPnIMqckzgHu86ZX3BU2mcejMJK2dckIigD5hm6CwLNaXKWiu4sLBJfD3tzD1xUBb4OZAa5cElb7NpZdteGaJjoJW9nFOzHsAeDCaNfyUG2WxnJ4NjwxYGVUX6RBkNc3IkdhueXukR6uYQnjfjPzJ6UczIyGULYhLLbuMLJBUuWE1wv0h4mWb6dZxu0GhD+LUnRuCIeByRRDP3LBxA4dHQyN6IAyPkDoe5QzwOEoc/kda/o39f4fJKVE0BJN02OmRCBzUBgn5xt2swOax9JN0HTbr7Scg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3r7EnmgVYNoK+J8aTIYjAoSk8WSIP7galB57221auzg=;
 b=ES+AjuywtYDpNhaD8RmpasRNGVsnS1OBlfZtwZu/hww8nn6/GimU7Lv2eKTKYbk4xWRDHRQMkVOMb4++1sppTKlBaLr6QDFg2cKRoAfC0ZSxvcbirumx7AqzGv9rnb2CaHCXOz8nMPXTWG1uL96oV0EAAeYMMQnHB2xJExIqTrHAQp1JZhhpstlVt+/tCNjN1/J1yganomDeLIVcWhBA5a633AC+zQK/N4QG/Sl+9ltKJpb4HPQ9ECNJE3eXRUBeNQSA8fyRkvbVWRrMA2Zc2y7NrR/OXihGndyOv3L0WrHh0jf1UM8QnhMNY1A+mj4ZuFf+5NP66U03z9VNqO13Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3r7EnmgVYNoK+J8aTIYjAoSk8WSIP7galB57221auzg=;
 b=qQz6Zl8Ypl9Y9ENzzFz9gY9Q5zXsFE+2n0gVosyI+mgHNS0P+cob4AXIpuhTUTwLEi2YYQpBD/gAvr7Nw/Xfq5HCXFXIJy1jxk8DYuGl9m1/gdWcks0y9sr6Ko6WAEbPcxfaxh+xSkRMtAzm4+d7m6akHlChlG6b2qQ/7U4eizdk+6GI4h2mBZa5vLM0T8qWnCcJtciYdWXID62V4XNPGLmrO/lsy47kvPDmhQ47WXjrrzE9A8JrvBdsLXH3T142z0XjDa52tafkEt6YgWtIN1jmNxq1ZolFdLSZd4gI2QTdNyu8vehsccdy6qQ/kjxgNAxrBBN2ovSSO1gLz1setw==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SG2PR06MB5333.apcprd06.prod.outlook.com (2603:1096:4:1d0::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.11; Fri, 13 Dec 2024 03:14:59 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%7]) with mapi id 15.20.8251.011; Fri, 13 Dec 2024
 03:14:59 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, Bin Meng
 <bmeng.cn@gmail.com>, "open list:SD (Secure Card)" <qemu-block@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [RFC.PATCH v1 0/2] sd:sdhci Fix data transfer did not complete
Thread-Topic: [RFC.PATCH v1 0/2] sd:sdhci Fix data transfer did not complete
Thread-Index: AQHbS7I46+EnXTBXO0uGLPXfGJWTY7LjgoSA
Date: Fri, 13 Dec 2024 03:14:58 +0000
Message-ID: <SI2PR06MB5041307469BCEEAC8463913EFC382@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20241211095111.1421928-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20241211095111.1421928-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SG2PR06MB5333:EE_
x-ms-office365-filtering-correlation-id: 463913ec-354b-4ea9-6798-08dd1b245381
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?05mcRjavRQAd5ySObnXnSjOqREeFGRKciNd17Bgcx2ZBJ7Jtp7K5IpgWNs?=
 =?iso-8859-1?Q?anq1NFZy6GuyieDprVn27nqrehtp/SyUvybS+ZynEUHJuGegUkOsDlAJuU?=
 =?iso-8859-1?Q?al/ykoanI6rHord/HZBJyFBs1SyZkKUMo1HL+ElIyX1lCynPO3JG4sg0UA?=
 =?iso-8859-1?Q?J7MXSfOI7d0Zr5o88qiQMczXOno+jwpRHdMWNV0Qn1mrewKas6TXrIaRrZ?=
 =?iso-8859-1?Q?wcIwAfDY5GpHNejOGTU5c9ZP5SZmPU2hc/yAj1PWaSl9lx4yaMvld2Wj1f?=
 =?iso-8859-1?Q?dkGLZ4F6ZfC3REjyIGcDtxIEkKy5/X1DO/SFl5GFRKrzfxhE2q+pQt/ViT?=
 =?iso-8859-1?Q?sMc4b79qZuepx8IXeHZo1SnzTX+C9QVSJmmqEJHCf3DMHOohwQvK3sHPuB?=
 =?iso-8859-1?Q?yd9IYrwgTxy6Ac9VIVqhETsHqaFqPfwgtJMGUn5jLgvENP/I1awf+JDXuJ?=
 =?iso-8859-1?Q?POPItDOixZsMAKAyZgOQPvvFTfQotjvlD1Gs187FGnZZh+qq9rUK4L2bV4?=
 =?iso-8859-1?Q?ESkrJgl4XPRV+moJFOhcKLRUs6GBsQ5a6doxVFfIwZQiD5LC//7No6VZDm?=
 =?iso-8859-1?Q?ICfQACZwlLPlJP46JlHSuDYYfRixrctdxOOe7/w7cl1xtGhVSpz2OOqIpn?=
 =?iso-8859-1?Q?Z/zlAUIG3+yMvPy3uL0pHFMWZ3gfnIs+taQy05HLo/lGRlnKHdtr2JbGDf?=
 =?iso-8859-1?Q?cS3xUve7XHUA47ruZpbZuWdGgOTrHsPI0XrEWF3nvGJv4SyQj121Wb/UW6?=
 =?iso-8859-1?Q?QQcDxJUymtueI6z+FvP6q1yLbU8zJDSqtT0eDC9EDFK1JdyC1eaxXu7QHs?=
 =?iso-8859-1?Q?RugOlwVfH2tzoPGSC3VgHtZ6lSHcvdCjnXRLQSbAHmPZyajRFL8FAjp/Xm?=
 =?iso-8859-1?Q?0fa7ZWJFPufgRu6wC8vZcYNrGRuh4spd/aUku5epaLs3q/U/jzoX4qy2g6?=
 =?iso-8859-1?Q?0bQU8j2T+xHR9nZWr08RiOKEWaHW6AAGTjBvk2qt7vNU+I9bv2wDQt5icq?=
 =?iso-8859-1?Q?Fjg21UY4wCC9hxTXBt8KwTGNx7VCzxKZuxkVj4z7w0FPs3cHJS8XhJrndJ?=
 =?iso-8859-1?Q?RJGS1HSuYCM/lPdQG3I2cQgKhJI1EoqQbTY3VOMSXnjANF6Tm1aj70lxqM?=
 =?iso-8859-1?Q?/3lNgaRT7V27PCe3SKtHgFt+2xHFSfg2TMaeC3MkfZ9QKOYAi5sLhDR4l7?=
 =?iso-8859-1?Q?0byM9kbNGqO/seVTK152YJwFy5rYfC3jTUUzFM9OlyIxF3XVpl5avUIHPu?=
 =?iso-8859-1?Q?FHaXn//iNj5/pFLreBAPKKpWXPneQF7c157zbSRJ93OpE3rlxJFzcxVCRz?=
 =?iso-8859-1?Q?0w7FIptnm/F76UIc8xL+xvjpgyvg1SzKCFUMjqnLt5bVRXDf3TwP8p3mBp?=
 =?iso-8859-1?Q?H0d83UxgX+MNPUqK2T7t0NWDjXBZcv0tXbc5H6EHzmBpU+QP+FzVKDpM9Q?=
 =?iso-8859-1?Q?Fu9nbT+TMlWiiGN5xF8Mqtr0hDNAKo2JTlKP1g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?X/iZrTKpMeixCA5gbC1X4Mu2CRiwC24r5wnA9YdV445aDUtWmOz+9+5ZWj?=
 =?iso-8859-1?Q?P15wDMWa2dkLrBYttlxGsrjtNVxCy9kyB+zHxVCWKds908EZ5UO7kuW03K?=
 =?iso-8859-1?Q?aua0i3fREA0+8b+USyad2/IWMEve6yePATLA02dbtFDDpOzuOUFQFuNHuZ?=
 =?iso-8859-1?Q?Yqe2l9pD6ebfGrTewK1XJG4DrBa8MowhYaonV0YnCHyqcUBvzrhlzSB8rL?=
 =?iso-8859-1?Q?N6Mf6uMiWJwqXjHk1m0HdwBD0L9S0/C9xgGAf7e78s9uZLfXYsjDeEk3oW?=
 =?iso-8859-1?Q?6hULN/A2HKQ3Arm/ihJkh1xVxy50AU+rdSQSy1C0omAPkQZ69ZTJ7GTQVQ?=
 =?iso-8859-1?Q?z2W20/Shc6oVWTqjUcUnKVEabPxcFsRr+QE563rAQcG6m/bcO7Byrgn5+O?=
 =?iso-8859-1?Q?QP1cdhgpxAkF0m4O8A75f9fVrpsOusyl0nKXV1hldhVuYJX2LVmTjOHTLz?=
 =?iso-8859-1?Q?bmylrQzQk3JRBbIUAAuPb6QVveu2g5cTikYiOdhXKd4aK+H8aWiOt13Z57?=
 =?iso-8859-1?Q?nfh2bCCTtEqjYcqRLLvFWGy15ns+lx6wSKRI0uVPXRpnHrPSKVC+pUAKuK?=
 =?iso-8859-1?Q?GvJhTNJeOZbGtJHoLVW3HBWg32FrRU523t4Qw4eDI7yQluP8MmtY/ePzmg?=
 =?iso-8859-1?Q?JfEQf0C08NsBlzSBBq1cxQ8ONqMH6dJF4PvuIdm523H+GTxtammPgUwAAF?=
 =?iso-8859-1?Q?1QXBKR3a9vDFz+SI6VVISnaArn2hmY1wL07H3EI4JeuKZb9eubKmgknBV5?=
 =?iso-8859-1?Q?8ARXO1OzagCFh111YYYxQ+aOWZkDTsGsR10FsDvXY1aPlso11a8kBqa6Q+?=
 =?iso-8859-1?Q?cPZaeAgObbnu5BygRBX3AcVZyCM4HEivftZbX7rl4rqrdGBcc17DOwNS+Y?=
 =?iso-8859-1?Q?T2YCK8gLLpNSFJxcIsDPZeXcl1eCoTbm01gM4gu6+0ComebJ6qLSCuHgMi?=
 =?iso-8859-1?Q?fhOHvEv2pqQqydHDHMzyb3PQCJaQeY8YFakqScdkpWcvRqn504dZr4Bj+T?=
 =?iso-8859-1?Q?Gl9q52Vzs2PsBlB8Qy6J2BYrpXNXFebOnR3w4k2yxl66hXdOe+k0odAcIi?=
 =?iso-8859-1?Q?KyasDG4tk3fgWORj7ZZ6otzwll+SAJ5AnyJaw65Vnj9snfecbX7Ji8/3Id?=
 =?iso-8859-1?Q?TQG/8idMAIi7Rpr7cfSOb7HyKRJsSEwaM75ildFMODg12RdyNMSj8lGy9O?=
 =?iso-8859-1?Q?S7sFrdDDonD/RNLEuqSi5vaQrPYi6Jad62oIQRudmlx6zWnuUs29wIk7UD?=
 =?iso-8859-1?Q?QYK80Iw1NlPSNQZO3v4NVkUM7eDSGcElOOuG0RZ7ZtDSgfDoSLs5u+a9ty?=
 =?iso-8859-1?Q?r7wT40heD3xdB352SohisG71bmxuE8GxLvSgjSbFqR3HEgAZN46JUPGXj7?=
 =?iso-8859-1?Q?Y0Na7cpXPUsH9A6opVe2AwvxWWz8eyHVR/WVOZW94XvLSACf0bFwwXFZaz?=
 =?iso-8859-1?Q?49hDGC952rsrsdZ2WCJ1yG2EBAefAlnn953V/ixD5qgw0/lfH6OqtbJ5js?=
 =?iso-8859-1?Q?SO8pC4XJ91CU9/yO1ORDnc4igdKG0zD2Mtel/CNx4h6I81jHoa7ia+vHRv?=
 =?iso-8859-1?Q?MxNMNW+/bMgOJwOQ66/TE5e6RFpTaYN2TbmyFp7P6enTs8LGsMqTnZS7F5?=
 =?iso-8859-1?Q?FIFIy/I+WCocxiCniDtsGvs0D0xdc3Q4Vw?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 463913ec-354b-4ea9-6798-08dd1b245381
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2024 03:14:59.0048 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vm6yXBGzmOQZ6nNuVfBv0rmQHzY7t1Vyt7tdS2I3moUj5MoVWBszeCCBvb2IFadjV7+ILMKw4uTiJRXMVLK+O2F2Jwf24SAg21qwlHHJAIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5333
Received-SPF: pass client-ip=2a01:111:f403:2011::70b;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-TYZ-obe.outbound.protection.outlook.com
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

Hi all,

> Subject: [RFC.PATCH v1 0/2] sd:sdhci Fix data transfer did not complete
>=20
> v1:
> 1. Fix boundary_count overflow
> 2. Fix data transfer did not complete if data size is bigger then SDMA Bu=
ffer
> Boundary
>=20
> Jamin Lin (2):
>   RFC:sd:sdhci: Fix boundary_count overflow in
>     sdhci_sdma_transfer_multi_blocks
>   RFC:sd:sdhci: Fix data transfer did not complete if data size is
>     bigger then SDMA Buffer Boundary
>=20
>  hw/sd/sdhci.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)

Sorry, I resend v2 patch, so please ignore this patch series.

V2 patch link here, https://patchwork.kernel.org/project/qemu-devel/list/?s=
eries=3D917437

Thanks-Jamin
>=20
> --
> 2.34.1


