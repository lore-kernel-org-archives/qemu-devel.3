Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B3ECAC5B5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 09:20:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Leb-0003q4-62; Wed, 24 Sep 2025 05:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v1LeN-0003h4-TA; Wed, 24 Sep 2025 05:19:02 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v1LeH-0002yg-G5; Wed, 24 Sep 2025 05:18:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v5amkQmwy/mPU21d9jbYynC7JV6sO0gMiTXFE+p9nuxoRwZm+erAKG5BsdmBm3ZhW3licxfEfoWVSMbj1sXxW4kBSiIznwps07DiGREdJkdqbNwb7nPyXUlPy2FJjW+jcfoHqGkuV/TMJczaTFiMtXIb5lCbESqp3UarOGTo8s9IQzoCEjrmHL0ssrT5BpJ07lZG4ZGJ7M5qPCQ0Kw1amsrYV/ctRNrgUSdqVLwoRPJLIZ227IyRzR+CyeKEUD4SDsIfzRE1/cOritzcgof6uRB4/tGHuGeXFz1XbxuQAvEZjrXu4qnKOSWx9y2YYMtf+yqUUgA2hzw1RIRkda9QoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3cbm7cZyPj4QyF8DPtpfrZmcnjqQY708yIRWMvYhwbo=;
 b=jq9Ew8rO2B1BzPstmK3UsPuuhQAZ3ZoRJyDyor8tVmdnemRI/h2aoBuO2TSGeIKhgVietgxLPYTtsnf6WmKjIOdAZooI3rr3QeR9sAFH3wvmM1rTab33Q3IQQKKatIfeP7o4NFy+ZtABPL03Si2TbP0Rp+pyI8upZjiRpvnIT9VKaGmIT8w7x9yO319Cfw5Tebvx4RiNbkrsl13OkauvsGQKh+loVB6UD3r/icHgCAe5S236DyurzqILooO4UQ1YVSf1HAssbbTX0fjBc3D3HFZ0h53FeghNf1qwvNFQ2lhsqW6UGVc5g2WjHCT9Lg/rknTbHnIGJ56JQbBB2jryQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3cbm7cZyPj4QyF8DPtpfrZmcnjqQY708yIRWMvYhwbo=;
 b=Z1O4iR4etXKDWxm53aajZMp9GaY37VM7LZynBsD+uYbqbloQLhXLRg3LoMzwkvOfBH/tO1l/iE1hco7klpxYy8gD/VYWIJ2JJKzDXZjUXsF0nVPR7kv6m8YpOCVWrdVUuRk8C0q5ou2sPlZWTY5qH0QDoIVAYPXm/njpC8TVIwYqPHTkd7rhxBrGCZrkyILhf32FLSgNCSz0fF4syc6CaUAl99kifZ2wZAK35NgGtVSFT5yrtPU4fD69HQzGYIDFuNBwGpLQtY4ntB08gOD4c/4ywxYZP/eBVrZbYAwOxlAzeTgHMKHItdjHp33//n+yk1Stz7NLPMieu8EOR6ByIA==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by VI0PR09MB7826.eurprd09.prod.outlook.com (2603:10a6:800:21b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 09:18:20 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 09:18:20 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v8 09/14] hw/misc: Add RISC-V CPC device implementation
Thread-Topic: [PATCH v8 09/14] hw/misc: Add RISC-V CPC device implementation
Thread-Index: AQHcLTQoO1AdUgeAnUKFiYtk5PyjaQ==
Date: Wed, 24 Sep 2025 09:18:16 +0000
Message-ID: <20250924091746.1882125-10-djordje.todorovic@htecgroup.com>
References: <20250924091746.1882125-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250924091746.1882125-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|VI0PR09MB7826:EE_
x-ms-office365-filtering-correlation-id: 150ba3e6-906a-465c-1229-08ddfb4b4e0f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?bfdn/s4O7cLLEM8+y+7Ws+jgYmyBWlOdcK9byuxb/RI7AVc80mVO7hKqhM?=
 =?iso-8859-1?Q?S6ciSLw+P+Z+BGoMUpBh3V5w+0vj0/AhDgW0h/1up7Bs1yeDkNuXmsUyxt?=
 =?iso-8859-1?Q?hMToQBzxY0EhYgW7u7EZYG4WxlMNVHqs/exT8YJjZjf7QUNQXJ8R/PvL6g?=
 =?iso-8859-1?Q?IdTnNY7LI8WaJQ9CUKbowOQKOV06ClqvK8Mcp2+USp7u/Ircn09tLUOb38?=
 =?iso-8859-1?Q?u31siwQc7lGZv+fQExB0TRZbddLtmYQGtHWLcs56yu8jrNHqFBLSR9gSBR?=
 =?iso-8859-1?Q?piSCS56ib88gihESmvl5vcbbqlTwWO424TgRBAcTkYS8fO9YUGiL/CUJUr?=
 =?iso-8859-1?Q?6M9PhWX+OgD8gXX564Paq/b4FManZIjOy5Ay6aQKgu/iOOWqKffmcNJfki?=
 =?iso-8859-1?Q?LL0eQtujyp1JEV8f8WEWtlAZzcfbfmbt+2RdFbLWl9hO4PmnHmMy2DFqTR?=
 =?iso-8859-1?Q?+77T/u8vD3jcHEVOLg1n4md8C6cKSgfjuSvvYQXkZH1/yIe0MAkbH9WpZN?=
 =?iso-8859-1?Q?Vpqkrb5Vzmk6wj28OzlQe5+P7Sb8AK0Y7o7bs0QMbbPfp025c7dYpWwhbl?=
 =?iso-8859-1?Q?TKgD9SZvyCrm9jOd0KasfCAyFuOn8T3PDdfFFmwldrn1fO7sQTJSLgUvLP?=
 =?iso-8859-1?Q?Qu6jMKE2FXQmogOtHVZSS7QK+tmHBXyoAB6TyvgiJ3JjhPeqnznfmbkDyn?=
 =?iso-8859-1?Q?CIQ3u1dA8NybEs8L7kz9n5iWRaRc2vqeFmOS+/J1Eo3Uups8/9TVH1foR6?=
 =?iso-8859-1?Q?xLwgZx2hWJv3ORxkYNlavkEft2n/JJ+fc9noeRUT/DcGIkyFkXXQjx7P+w?=
 =?iso-8859-1?Q?yNIq5yHmp2goFIICwj3wqK6MzIWzGaq+mKjsf+ZttwZ/eed2kJQuc6Jg9M?=
 =?iso-8859-1?Q?HRv29T7ehVoZztCr/a6B2im5/tVbtfMBUpsOpIm765T3HxVrZDZCATMjut?=
 =?iso-8859-1?Q?TBN/cpXDlaMkMrUpSPjiI9OxxyZcpw+Yz5nyNC4zUZAlctZOxL1+WVxDm2?=
 =?iso-8859-1?Q?pSO935xDcYKs2lYsem/nyx/K27x5krUSUJGh25YxmLlWPGZsEcJaQv/psE?=
 =?iso-8859-1?Q?EPZdL/P+kbQ/QC2udqBIg5waA8GJYAg1gdv7AaBYgKwREdVrx7mt2pXANk?=
 =?iso-8859-1?Q?D8Sy0xyQMBymY6vdO8VvkWTkHVnPnqWpOXKAH0LYJFoJGvvkMIXSVaW7vl?=
 =?iso-8859-1?Q?Pf7DdX90w5gI694vo241XdcgHI9fRzKMIHCKz6EJAy6JkdZD/2Fivj4Vot?=
 =?iso-8859-1?Q?Nr8ESK/ZbUXUh/BAVGD8N+ZudFTNAy3spdXnYEiU3B2dUBZT+QyjJU36Hy?=
 =?iso-8859-1?Q?9nMDFbnKXoDx7JEb+ruN7QqjBvxghCvj5+mSWaXWkLK7iFtfGUcTAV1df2?=
 =?iso-8859-1?Q?fs8DXA7a5aVcbclwdqhalm3i/0hBAUU6T9B7HghcVsaeWihNMgdYXkeTqI?=
 =?iso-8859-1?Q?jn8DFNde6l57kC0Ni1XBF42z1tcTKRcdyh0Ws/5DgpHDdeKu0QiuUDIUCv?=
 =?iso-8859-1?Q?9QA3rrZzy9JHfjtK+aUkDxK0QVAKcQa1Go0+g1Im6Rfg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?A1Q/aWm34BIhCa+JIVtb2ySsobIRrAWBDZ9odWoIoQbC1XtoEtjKNR6zPH?=
 =?iso-8859-1?Q?0zwNCfSEtPWzFavnv5F3iEXVWLUW8uFI9fw6Y4Ii0cCYpewxf6MN94oiV3?=
 =?iso-8859-1?Q?yM9JIZOTQC46dDuZ7rZkyEl+uLUN5n58848juuPwz5NEIfiRutoaWyL2LC?=
 =?iso-8859-1?Q?kCOheqc3SnRKDKGGkDNeFIDIoA05EHOYkPbYePLc4a1KmZhHm2mKo0nIHo?=
 =?iso-8859-1?Q?OKzqMuc7GJtR8XA23PllLxIWxP5XtHT74LBh+prq65VNF0n/XirXVRc0vU?=
 =?iso-8859-1?Q?Yrz7EASQPY8S0Z9cH37EwZ7suiiCynf4IVWGBEYx/G1MDeqFiBwZOGYWqQ?=
 =?iso-8859-1?Q?+fkrNFPQ9SuAznmX1Ijy3bIQXBReTNJEYQhrLeIpBkQI9P3YTG4VhiTjvS?=
 =?iso-8859-1?Q?pY8o0fJ3BGLdtlNWifOmR3AK8L4ghbSRbV2afC+no0Iowq8BKXHaRN03zw?=
 =?iso-8859-1?Q?43DXrBGWXMLiXtV0k1hpCfrXYsL7ZdSu+Mna2oB4+v08dv7LzxzoUqnMfZ?=
 =?iso-8859-1?Q?RCZXCYv6N9ureVNKFqtQ6zkin2KAJV/W17hDyQZt+GLpbJMHDUduWTUGlo?=
 =?iso-8859-1?Q?ooVZt8FelQPwwk8JFPkk4eV2imwudg5EoZ1MGI1BbpxoT3Ll9Fz2L5V0iG?=
 =?iso-8859-1?Q?9OpW+FYsd1D463l6DU4LwhKbAAwGbt9xUWuPKrYpWmkM1NsJEVsak6SOSY?=
 =?iso-8859-1?Q?b5MZzYSSSUjCXG3DEcgxXhm5z8Bmy0UsEJTMuYYTR+A+Q2uzosPIFuyKTw?=
 =?iso-8859-1?Q?U0Pw/BpyVCGG1lxLbkwr5v0Xoo0zVkxh9mUj77hcDShkaWLXKLj1r2MLTQ?=
 =?iso-8859-1?Q?yGRcIlN1t5uPin8998FmPR8XGPXYe/Ra5/ULKHHNJV+rzZONKHNgiVfo5q?=
 =?iso-8859-1?Q?Cxe3epZ4dGXlN4ak+RPwDjmLxB5U9OE4eTxSZOdfDleDXtoJSXQLzHof+C?=
 =?iso-8859-1?Q?1xxZZDZSzvjcRTTIma5tYIcyBBOKQNj/INucyGQxx7RIloiyZ+czyfsGka?=
 =?iso-8859-1?Q?3TACWEiz8pZKec9kXf7ehkUh3g4ye7Igoeub6eAP6BhGleZfGHLBflztAY?=
 =?iso-8859-1?Q?+FGtIlcZ5mZU04UYjvr9aJhbcrMj85BwSTmhKLegx1MkqqStkHf+Ji/6j8?=
 =?iso-8859-1?Q?USONz1/rsy56OmQZThsfW32uzpnoVLNqz24l+MPIcOp4w/eYcwmBGo5MXh?=
 =?iso-8859-1?Q?Ctpa4BORnl6ypuauovjXDfe2dyNggJIJGvFUD7PFr9itAZvaWtKzlVUp6v?=
 =?iso-8859-1?Q?+/EcvI+VMfjARCnAnCil6Fln+Vz0CtOgnDtjRxJjLRL13zheiLAyJ/8Yrm?=
 =?iso-8859-1?Q?it1Psmarwzrb5Bw27uzAEOG/RgcHyBXglkathDkhmv/oVEUAn3Jp16f03T?=
 =?iso-8859-1?Q?vQjbMkc49REYYzWRtZo2wv0OMWH292iG+zWpE60xm9ggD2jIwzcLNbupaU?=
 =?iso-8859-1?Q?+75gOy/d/wcT0RSFmaI8hJ0lv/rXmZFLvrcwIA5yy9TCkmYmJtOJbK105V?=
 =?iso-8859-1?Q?XaWqPikbqTsH9oOfAhXiYMv3lFoy+RjOk3oeAkwJYKGC6fHVjjJff8D/RG?=
 =?iso-8859-1?Q?z/EZXCqElpe7wF3Bq7+0dk0m4GZyKb3huVQT9AmmbykOc6cIRKAkr3aJvC?=
 =?iso-8859-1?Q?p6TFG9s/0K73bQh2iLfXJ26ErRmy0+olIZY3Nf+H0Rn4iy2G/GtDxvXnwU?=
 =?iso-8859-1?Q?EouuopDS+VPCzQ+8Xu4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 150ba3e6-906a-465c-1229-08ddfb4b4e0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 09:18:16.4236 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PLyci2l8aRqTyuHd6CF+1u7U5lGxwkX9iaG7ApA3xP0fdh8gWUGaDK/ANwWCq73qq0ZdbYP4OXMLcdcLw0xvgFR3nEt3aYthlLw5dc0sk80=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR09MB7826
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
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

Add RISC-V implementation of the Cluster Power Controller (CPC) device.
It is based on the existing MIPS CPC implementations but adapted for
RISC-V systems.

The CPC device manages power control for CPU clusters in RISC-V
systems.

This is needed for the MIPS BOSTON AIA board.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/misc/Kconfig             |   4 +
 hw/misc/meson.build         |   1 +
 hw/misc/riscv_cpc.c         | 263 ++++++++++++++++++++++++++++++++++++
 include/hw/misc/riscv_cpc.h |  64 +++++++++
 4 files changed, 332 insertions(+)
 create mode 100644 hw/misc/riscv_cpc.c
 create mode 100644 include/hw/misc/riscv_cpc.h

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index c72927c3ff..1e35bcd443 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -124,11 +124,15 @@ config MIPS_ITU
 config RISCV_CMGCR
     bool
=20
+config RISCV_CPC
+    bool
+
 config MIPS_BOSTON_AIA
     bool
     default y
     depends on RISCV64
     select RISCV_CMGCR
+    select RISCV_CPC
=20
 config MPS2_FPGAIO
     bool
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index ef891e465b..1f9945755f 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -158,6 +158,7 @@ specific_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files=
('mips_cmgcr.c', 'mips_cp
 specific_ss.add(when: 'CONFIG_MIPS_ITU', if_true: files('mips_itu.c'))
=20
 specific_ss.add(when: 'CONFIG_RISCV_CMGCR', if_true: files('riscv_cmgcr.c'=
))
+specific_ss.add(when: 'CONFIG_RISCV_CPC', if_true: files('riscv_cpc.c'))
=20
 system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
=20
diff --git a/hw/misc/riscv_cpc.c b/hw/misc/riscv_cpc.c
new file mode 100644
index 0000000000..f3168a79da
--- /dev/null
+++ b/hw/misc/riscv_cpc.c
@@ -0,0 +1,263 @@
+/*
+ * Cluster Power Controller emulation
+ *
+ * Copyright (c) 2016 Imagination Technologies
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "cpu.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/timer.h"
+#include "qemu/bitops.h"
+#include "hw/sysbus.h"
+#include "migration/vmstate.h"
+
+#include "hw/misc/riscv_cpc.h"
+#include "hw/qdev-properties.h"
+#include "hw/intc/riscv_aclint.h"
+#include "hw/resettable.h"
+
+static inline uint64_t cpc_vp_run_mask(RISCVCPCState *cpc)
+{
+    return MAKE_64BIT_MASK(0, cpc->num_vp);
+}
+
+static void riscv_cpu_reset_async_work(CPUState *cs, run_on_cpu_data data)
+{
+    RISCVCPCState *cpc =3D (RISCVCPCState *) data.host_ptr;
+    int i;
+
+    cpu_reset(cs);
+    cs->halted =3D 0;
+
+    /* Find this CPU's index in the CPC's CPU array */
+    for (i =3D 0; i < cpc->num_vp; i++) {
+        if (cpc->cpus[i] =3D=3D cs) {
+            cpc->vps_running_mask |=3D BIT_ULL(i);
+            break;
+        }
+    }
+}
+
+static void cpc_run_vp(RISCVCPCState *cpc, uint64_t vps_run_mask)
+{
+    int vp;
+
+    for (vp =3D 0; vp < cpc->num_vp; vp++) {
+        CPUState *cs =3D cpc->cpus[vp];
+
+        if (!extract64(vps_run_mask, vp, 1)) {
+            continue;
+        }
+
+        if (extract64(cpc->vps_running_mask, vp, 1)) {
+            continue;
+        }
+
+        /*
+         * To avoid racing with a CPU we are just kicking off.
+         * We do the final bit of preparation for the work in
+         * the target CPUs context.
+         */
+        async_safe_run_on_cpu(cs, riscv_cpu_reset_async_work,
+                              RUN_ON_CPU_HOST_PTR(cpc));
+    }
+}
+
+static void cpc_stop_vp(RISCVCPCState *cpc, uint64_t vps_stop_mask)
+{
+    int vp;
+
+    for (vp =3D 0; vp < cpc->num_vp; vp++) {
+        CPUState *cs =3D cpc->cpus[vp];
+
+        if (!extract64(vps_stop_mask, vp, 1)) {
+            continue;
+        }
+
+        if (!extract64(cpc->vps_running_mask, vp, 1)) {
+            continue;
+        }
+
+        cpu_interrupt(cs, CPU_INTERRUPT_HALT);
+        cpc->vps_running_mask &=3D ~BIT_ULL(vp);
+    }
+}
+
+static void cpc_write(void *opaque, hwaddr offset, uint64_t data,
+                      unsigned size)
+{
+    RISCVCPCState *s =3D opaque;
+    int cpu_index, c;
+
+    for (c =3D 0; c < s->num_core; c++) {
+        cpu_index =3D c * s->num_hart +
+                    s->cluster_id * s->num_core * s->num_hart;
+        if (offset =3D=3D
+            CPC_CL_BASE_OFS + CPC_VP_RUN_OFS + c * CPC_CORE_REG_STRIDE) {
+            cpc_run_vp(s, (data << cpu_index) & cpc_vp_run_mask(s));
+            return;
+        }
+        if (offset =3D=3D
+            CPC_CL_BASE_OFS + CPC_VP_STOP_OFS + c * CPC_CORE_REG_STRIDE) {
+            cpc_stop_vp(s, (data << cpu_index) & cpc_vp_run_mask(s));
+            return;
+        }
+    }
+
+    switch (offset) {
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: Bad offset 0x%x\n",  __func__, (int)offset);
+        break;
+    }
+
+    return;
+}
+
+static uint64_t cpc_read(void *opaque, hwaddr offset, unsigned size)
+{
+    RISCVCPCState *s =3D opaque;
+    int c;
+
+    for (c =3D 0; c < s->num_core; c++) {
+        if (offset =3D=3D
+            CPC_CL_BASE_OFS + CPC_STAT_CONF_OFS + c * CPC_CORE_REG_STRIDE)=
 {
+            /* Return the state as U6. */
+            return CPC_Cx_STAT_CONF_SEQ_STATE_U6;
+        }
+    }
+
+    switch (offset) {
+    case CPC_CM_STAT_CONF_OFS:
+        return CPC_Cx_STAT_CONF_SEQ_STATE_U5;
+    case CPC_MTIME_REG_OFS:
+        return muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
+                        RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ,
+                        NANOSECONDS_PER_SECOND);
+        return 0;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: Bad offset 0x%x\n",  __func__, (int)offset);
+        return 0;
+    }
+}
+
+static const MemoryRegionOps cpc_ops =3D {
+    .read =3D cpc_read,
+    .write =3D cpc_write,
+    .endianness =3D DEVICE_LITTLE_ENDIAN,
+    .impl =3D {
+        .min_access_size =3D 8,
+    },
+};
+
+static void riscv_cpc_init(Object *obj)
+{
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
+    RISCVCPCState *s =3D RISCV_CPC(obj);
+    int i;
+
+    memory_region_init_io(&s->mr, OBJECT(s), &cpc_ops, s, "xmips-cpc",
+                          CPC_ADDRSPACE_SZ);
+    sysbus_init_mmio(sbd, &s->mr);
+
+    /* Allocate CPU array */
+    s->cpus =3D g_new0(CPUState *, CPC_MAX_VPS);
+
+    /* Create link properties for each possible CPU slot */
+    for (i =3D 0; i < CPC_MAX_VPS; i++) {
+        char *propname =3D g_strdup_printf("cpu[%d]", i);
+        object_property_add_link(obj, propname, TYPE_CPU,
+                                 (Object **)&s->cpus[i],
+                                 qdev_prop_allow_set_link_before_realize,
+                                 OBJ_PROP_LINK_STRONG);
+        g_free(propname);
+    }
+}
+
+static void riscv_cpc_realize(DeviceState *dev, Error **errp)
+{
+    RISCVCPCState *s =3D RISCV_CPC(dev);
+    int i;
+
+    if (s->vps_start_running_mask & ~cpc_vp_run_mask(s)) {
+        error_setg(errp,
+                   "incorrect vps-start-running-mask 0x%" PRIx64
+                   " for num_vp =3D %d",
+                   s->vps_start_running_mask, s->num_vp);
+        return;
+    }
+
+    /* Verify that required CPUs have been linked */
+    for (i =3D 0; i < s->num_vp; i++) {
+        if (!s->cpus[i]) {
+            error_setg(errp, "CPU %d has not been linked", i);
+            return;
+        }
+    }
+}
+
+static void riscv_cpc_reset_hold(Object *obj, ResetType type)
+{
+    RISCVCPCState *s =3D RISCV_CPC(obj);
+
+    /* Reflect the fact that all VPs are halted on reset */
+    s->vps_running_mask =3D 0;
+
+    /* Put selected VPs into run state */
+    cpc_run_vp(s, s->vps_start_running_mask);
+}
+
+static const VMStateDescription vmstate_riscv_cpc =3D {
+    .name =3D "xmips-cpc",
+    .version_id =3D 0,
+    .minimum_version_id =3D 0,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT64(vps_running_mask, RISCVCPCState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static const Property riscv_cpc_properties[] =3D {
+    DEFINE_PROP_UINT32("cluster-id", RISCVCPCState, cluster_id, 0x0),
+    DEFINE_PROP_UINT32("num-vp", RISCVCPCState, num_vp, 0x1),
+    DEFINE_PROP_UINT32("num-hart", RISCVCPCState, num_hart, 0x1),
+    DEFINE_PROP_UINT32("num-core", RISCVCPCState, num_core, 0x1),
+    DEFINE_PROP_UINT64("vps-start-running-mask", RISCVCPCState,
+                       vps_start_running_mask, 0x1),
+};
+
+static void riscv_cpc_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
+
+    dc->realize =3D riscv_cpc_realize;
+    rc->phases.hold =3D riscv_cpc_reset_hold;
+    dc->vmsd =3D &vmstate_riscv_cpc;
+    device_class_set_props(dc, riscv_cpc_properties);
+    dc->user_creatable =3D false;
+}
+
+static const TypeInfo riscv_cpc_info =3D {
+    .name          =3D TYPE_RISCV_CPC,
+    .parent        =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(RISCVCPCState),
+    .instance_init =3D riscv_cpc_init,
+    .class_init    =3D riscv_cpc_class_init,
+};
+
+static void riscv_cpc_register_types(void)
+{
+    type_register_static(&riscv_cpc_info);
+}
+
+type_init(riscv_cpc_register_types)
diff --git a/include/hw/misc/riscv_cpc.h b/include/hw/misc/riscv_cpc.h
new file mode 100644
index 0000000000..713455eb83
--- /dev/null
+++ b/include/hw/misc/riscv_cpc.h
@@ -0,0 +1,64 @@
+/*
+ * Cluster Power Controller emulation
+ *
+ * Copyright (c) 2016 Imagination Technologies
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#ifndef RISCV_CPC_H
+#define RISCV_CPC_H
+
+#include "hw/sysbus.h"
+#include "qom/object.h"
+
+#define CPC_ADDRSPACE_SZ    0x6000
+
+/* CPC global register offsets relative to base address */
+#define CPC_MTIME_REG_OFS   0x50
+
+#define CPC_CM_STAT_CONF_OFS   0x1008
+
+/* CPC blocks offsets relative to base address */
+#define CPC_CL_BASE_OFS     0x2000
+#define CPC_CORE_REG_STRIDE 0x100 /* Stride between core-specific register=
s */
+
+/* CPC register offsets relative to block offsets */
+#define CPC_STAT_CONF_OFS   0x08
+#define CPC_VP_STOP_OFS     0x20
+#define CPC_VP_RUN_OFS      0x28
+#define CPC_VP_RUNNING_OFS  0x30
+
+#define SEQ_STATE_BIT       19
+#define SEQ_STATE_U5        0x6
+#define SEQ_STATE_U6        0x7
+#define CPC_Cx_STAT_CONF_SEQ_STATE_U5      (SEQ_STATE_U5 << SEQ_STATE_BIT)
+#define CPC_Cx_STAT_CONF_SEQ_STATE_U6      (SEQ_STATE_U6 << SEQ_STATE_BIT)
+
+#define TYPE_RISCV_CPC "xmips-cpc"
+OBJECT_DECLARE_SIMPLE_TYPE(RISCVCPCState, RISCV_CPC)
+
+typedef struct RISCVCPCState {
+    SysBusDevice parent_obj;
+
+    uint32_t cluster_id;
+    uint32_t num_vp;
+    uint32_t num_hart;
+    uint32_t num_core;
+    /* VPs running from restart mask */
+    uint64_t vps_start_running_mask;
+
+    MemoryRegion mr;
+    /* Indicates which VPs are in the run state mask */
+    uint64_t vps_running_mask;
+
+    /* Array of CPUs managed by this CPC */
+    CPUState **cpus;
+} RISCVCPCState;
+
+#define CPC_MAX_VPS 64  /* Maximum number of VPs supported */
+
+#endif /* RISCV_CPC_H */
--=20
2.34.1

