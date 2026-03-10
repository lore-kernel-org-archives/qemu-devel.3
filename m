Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BDFAFCC9D1
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 06:58:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzr2c-0006ja-V6; Tue, 10 Mar 2026 02:58:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1vzr25-0006fj-Vv
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 02:57:34 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1vzr22-0007qh-8j
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 02:57:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1773125852; x=1804661852;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=PQldqOOnUYXFJtHrO1QHI1UAXFVe/QG8I7HU0EjD9b0=;
 b=YsKPDLJFGtHTF3p3W8AyJpFlFRG4/+YtD5paK+SIybYTtNQusHkSgZxv
 4WxRmIORuRnqEvvrwZ73ci3WecPgZFzVkMeF+2g9nZC8y3AV8x+88Hs7A
 U/BZGkXdJk21dJREZU2R2fvyY7Z7qMnVLngvC77FjXATaPIKrHq6OelD+
 cUiGRGkYkHtu3qK1a7sa7RpMbF0fdcbUEioH601+O74um43s5KScdZueP
 wRx6AybAYvlGLfeiqAU2T+ZwRABaxpZUm6WZLBNTi8/2pqkd9Vjdkfrf3
 ylUAYiKRy5DK0ih/A7eUrKRSu2oKLOmxrqeTbMkcdqhti8p7aOVKq5k8m w==;
X-CSE-ConnectionGUID: xInsvjHMShioDZJePG/5ow==
X-CSE-MsgGUID: T4e8MD/mQFqIOOQeot2yiw==
IronPort-SDR: 69afc0d8_B/1zvyOiEeIOIWtrLEiRMNo32YMxtFsKcuQufQazLg7DYUE
 Q2BOAZjx/oiFIvdpRqJz4EaO6IahsMHttT9AbhQ==
X-IronPort-AV: E=Sophos;i="6.23,111,1770591600"; d="scan'208";a="46930364"
X-MGA-submission: =?us-ascii?q?MDEwP18PPcZ8BnTHK+/7IJLgyr7J4C/IadZdVD?=
 =?us-ascii?q?5pXgeioKb+I6q+9g1G1vpeDf6jZAHavLaIrgLWZiv2ZZUGgbTIb+Troy?=
 =?us-ascii?q?VMb7yT4boG7Kh1ikaZPVRJ04UGWgCZP5R/CfVcnXyssyjy/STngXUhKt?=
 =?us-ascii?q?IPX5iOOlPNykg9T6ZiIXejEw=3D=3D?=
Received: from mail-francesouthazon11011021.outbound.protection.outlook.com
 (HELO MRWPR03CU001.outbound.protection.outlook.com) ([40.107.130.21])
 by smarthost2.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 10 Mar 2026 07:57:27 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RQUOYzWT4V/vT1cUnmLPjbeue8iwK9n7jJsdI/21b6OId0LeGc+KHjarkjWYjrW3z43zbuZrV4D8j9bCrZwgLG83qDBsFXOjkNCee53lc6onSogp/GBVAk/tQlqlvvcpNczrHYbJTeEwXrejIM1GmYpylg5nHH2vzUnjgkegMfgh5HZuAFgh+6gGPSoaZfufHUy9oyfxSp+xuTLphwASKp6Grt/3BR49KgFtCpi0lno89rewDjBD9j44U+e88FKEH6Tj368rhHY55VmFPZfHIiV/LZS7/8APKokO5jpLz1Vvx1NGI4SIs2pZfQeeNs0wQvVw2crGbQKWV5RUmeAsdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=17Ql2e4xlrbX3L1wlvSDHobWLxIPpwWKO70Pj462S5U=;
 b=Wt96/QHzT3AXgT1C+zLXM2MykUqYigG2HdcAodAEVYJuUc5Tf5hS3f1zPMExwvUptpySc1ePFz03lm29UDsAld8H9z1K6zksDixLvAf955DObPTqDFSC21LBh8ALqbWcGTKqN31oC5ABOCK3PRX/Fi4y9q0c5woUvbIsv7yh/XR/0Ms5dE4ReqLY/akp5nEwMBz545B20WZ0e+R7FgNHQslQKKJUgomntvRHUXNm+YgWjVyrahrtBF3etNtcECzF+oHFuEHYRTLalal46ulNo+YpfarbeqVu7xa1GaAnEVgtMrK1mcx9VaxqiptUEtxnBN0JoS7ugh8rprgauRPQdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PR3PR07MB7020.eurprd07.prod.outlook.com (2603:10a6:102:5f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 06:57:23 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%6]) with mapi id 15.20.9678.024; Tue, 10 Mar 2026
 06:57:23 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@bull.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "eduardo@habkost.net" <eduardo@habkost.net>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@bull.com>
Subject: [PATCH 2/2] intel_iommu: Always write all the flags passed to
 vtd_set_flag_in_pte
Thread-Topic: [PATCH 2/2] intel_iommu: Always write all the flags passed to
 vtd_set_flag_in_pte
Thread-Index: AQHcsFslrp0iE0S4gUmzYJTXTi+w0g==
Date: Tue, 10 Mar 2026 06:57:23 +0000
Message-ID: <20260310065644.426838-2-clement.mathieu--drif@bull.com>
References: <20260310065644.426838-1-clement.mathieu--drif@bull.com>
In-Reply-To: <20260310065644.426838-1-clement.mathieu--drif@bull.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PR3PR07MB7020:EE_
x-ms-office365-filtering-correlation-id: d90dece6-61a5-404d-4ecb-08de7e724864
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: sUnlBmO0ZmGDJWmkZWOrM/Ce1BK6OkBlsj5wlT8DPljcWPxQz43FyvnS0fg6eNn3zqRF9XoOvsY8C0/2AkZMA2OzXtfznLH+O8r2/pGtzCr46yzNrLUA4r0ATh5nyEbqtuZmdCcC+UtsY+QoMdHqPp+RzWJu0H2TSbr3YeIrkuyXn5qLuOEmd83u9yEXZLU0n0Og6Zve5pIS3us/IBC7rJGCK/9CBvmK7aCEXhlLVak0aCEJpF9DWwcNlAAP6yCfzoqr16oV99Rnfk+EySEWfBkMG6y/bPu1YIJSd6FOuD7CAJFzwUP/hzfv0d4AGhHjlWaxbPSA8Hm/qSVz4Cw1EHz+KRFf/74jMqxg/OoE3h8Gl/zdK+UhgaWG4sMlL3Pgl3e7e7hC1GJ3x+rZ7oBtVmWEOeqYygWEAng1e8W2RV+/K4TPtAH5MVAqBdxqNU+4txVE7BXKJq3v9D5wkCXZ2ZVsPEQaBEQtyWxUap1C6ujPHMvhlFc2n5marYXjinxHfYOWuXvm/ydId8yTwF94ItDuibEkRzpDj0opEanBD9Qx6jKgJzOJw2y+Tkyv27IqzKO6BQ+piQPyOe/Hp8BRLuw0ZN+KHq2BKikEU1N+iBcLbsq/ZPAjTgQdvbKXQ6HXep1/5COgT9RtoJWywiKkyS1qTv4m2mOyC5YGPa1FD+Q+zXjyDo+X6EZQYfHyPK0ch+ag+LxUbCX8dQRJWpO4f8DaOTb7vmNYgMgTxG0y0fEZ1VBzgnnvYy8WJQanTFa75fTV5hJCwPktA6wTWZdcP8rcMzj25xJ2Rj7lnSi2zvI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?I3offmxxt47/e0RmQEbuuTlUu2gcbMzfwJRNVhnz8xm5eirOfRtGTVe5sY?=
 =?iso-8859-1?Q?5JVLDmVoxzIcdnVhnJkb2owmGajAK7cMZJGbZCi9xgeb7uIsh1eDP19qOg?=
 =?iso-8859-1?Q?92RGBav39OrRijk61yoTZw5SUpMyNofaUSA1wh4j/8CEMFFS+6ZKJVGH1o?=
 =?iso-8859-1?Q?VYK+dQSMQXe8+Y1xrC2+N6F+hXU+9fal5NgqAoR09jBYuWe1FbyL8O9DRi?=
 =?iso-8859-1?Q?4Am2VHIFxE2Cy0AsI8lqoVSGFld+K/O3Bd23N/kzhu6rtox9GhWhjgYFNv?=
 =?iso-8859-1?Q?UYB/kjaf09o+aS/AGG5ZaEzQkwN7+B+cWmX2qwPnjFNsSwSxbLqjbZNb2w?=
 =?iso-8859-1?Q?xMIyP1Dr18Cg3raQzxOzqXHTyW//78SypCxCtdALyElnK4H1EIFc8eyh2H?=
 =?iso-8859-1?Q?9on2HxSuetdaR0LYa6e49mr6Zkhw4S6RrWHSRPniAVReIRwePyzfsYytIf?=
 =?iso-8859-1?Q?N3AcEDoJqKpxm8aNyHZqoLrODsAfY7TP7bJ7DqozZoRY6W1JxNLoKr3do/?=
 =?iso-8859-1?Q?btX9mprc3NhQerl/2hUP5QFL/0ECSAvjsy+AejsQBNWe5woAORg29I3q60?=
 =?iso-8859-1?Q?a52VXdmm9tteikFgvhkwVlYn8u6ywUd03q8prBxUgDOSeDlc1Kz7nQ4hZ7?=
 =?iso-8859-1?Q?QdtSq0n7rkOaChWYZhSbHl4vpwyZSE5pu3n5MGXy1juBURBxUj6VYl1jcl?=
 =?iso-8859-1?Q?/XkdIlRelWYPDebFEkiiTR7vgurhs3TykoTDSE15zbnBpvqSUYKNCNTwvR?=
 =?iso-8859-1?Q?O0iTXqs4wFEeynoy+oJr+USq0gFlUERXYV9QT5cX5naBb6gu6Wz5A9A7g6?=
 =?iso-8859-1?Q?YFREFrlgLW7uHruZBg5GiOpuSYy/2eovwcttdZU1J0YiEzkz7ouP1MxdNH?=
 =?iso-8859-1?Q?2RppBKO1mgvUISMLv6nHyK4QBN0E1OUJmmSO5aTovEL2EP0/fassfykrMe?=
 =?iso-8859-1?Q?S3MlhlSi1ju8G35PIgyKq85/HwcufxqxvYfwNXug9vmSAxSj1nMRGnBIsk?=
 =?iso-8859-1?Q?kV94tbZjQC2aWu9g72yWxmBWUaUivXl1+iE24SMtUOVhJWhnIUNmq+ydIV?=
 =?iso-8859-1?Q?XZ9IlGvNXGdNcVG1Sgnl+h2uGD7Y7ZYSAwqN4dblzbV4GLZTzDgNHC569W?=
 =?iso-8859-1?Q?77sNgkAanHjNERtkZN3tiCSO1kI+Xtd+Rm1iLh3Q3ziwkwCmLyXMipnclo?=
 =?iso-8859-1?Q?FvZlWu3bKBPVN39+sSBbSPPqIVx/FVnCCwIs2ObSRoAsJxugwfQNSusTd0?=
 =?iso-8859-1?Q?uLl+ap8cYV/Ay+FRY4W/16I36/f0EAF0dAMuABATk90J2WBcn7CdwrjhoO?=
 =?iso-8859-1?Q?QItwbXIH2LJ3muExbN2PBBLFKWR7J2gHDkBprHylnJT+e+ijZh+uPFEMn9?=
 =?iso-8859-1?Q?n1OZQMl46unlL1qyUoTgM+jEBLKUjkW5QqVKDedht4fQ36yiX5vb4un3J7?=
 =?iso-8859-1?Q?9ZjgXD6QJ6PhXmlaOwCRYeq4q510CoWyA2RGqx+wDJJO37OpPExBg2g4DH?=
 =?iso-8859-1?Q?jXC1rHuDheghBi5DE3/DuimusyKlXXuQmU6Uha8XlyxV8x+IuV2PqQPcoa?=
 =?iso-8859-1?Q?HTzKFhFCewS1uSBxxni5w3evMkmlY5YxAnnmgVCAEWRWq8U7YF8aTpC63O?=
 =?iso-8859-1?Q?viIcPr1hnQuAaN2KOLSt4t6Mgh99sgtPYOZWThw+cgDWyTwbmzM6W+S8Ls?=
 =?iso-8859-1?Q?oVofN6aBG9gRjWVLbTAqxzULJTAcy69nj6aw5C+GmnNo2c9iY7p0ys7lbl?=
 =?iso-8859-1?Q?PYHt3HgHFbXkT4xKlnEDBB2o0eigzDtM2g2XdaUXa96/FmYK+00bahuMDy?=
 =?iso-8859-1?Q?suxrXvTm/I1iF0/rlxti7HgoCo68vr39Ky424Wn1fO3BsQ5PGGol?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rIsDicDB8U3sBJvzRqMrdtAwhazt5RePuE/F+KnUemOCOdU2HLLjeYVK8OwoiBMy1QHDevJo1BFLXGpPHKTfMuUiUPtTg+9uExqn/GqhDHGk/1bv3K05VBZM9rCvMTIL2X52p0qxL7Mfq3DSfByIXGMwyhi4qXld78s0jR0BbKpqVdZfSymOjB5sl/jrgtXJSKei2IFoJLqM6fxzr8aA5noHVDmrZdNHAWrjQaE7adzgHrME9FqYy9zyRf6il2MkGXwEaWmXbaq3CLHsQtKe0MF9qEy4qxadBQWlq+qDY7Vy3QPK2ZPOHceEOKl+52nCrHU43Q0BnCQSoZFiGk3AiQ==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d90dece6-61a5-404d-4ecb-08de7e724864
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2026 06:57:23.8964 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DhBee8JH14Jn2Psu6UCX4ZADqVCLHFgN6LsIMa4rzi0uMkxlEUvx8OGyj4xam+u2BwZjFegj5cYmxkKJrGIrIKOF8LYWweNC09ecE40hiU1rqJ+3Jq2B6aPuLihut5W4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB7020
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@bull.com; helo=smarthost2.eviden.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This function was initially designed to write a single flag in a pte.
The current implementation expects it to set several flags.

Fixes: 65c4f0999991 ("intel_iommu: Set accessed and dirty bits during stage=
-1 translation")
Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
---
 hw/i386/intel_iommu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 56146aafc1..441c96125b 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1991,13 +1991,13 @@ static bool vtd_iova_fs_check_canonical(IntelIOMMUS=
tate *s, uint64_t iova,
     }
 }
=20
-static MemTxResult vtd_set_flag_in_pte(dma_addr_t base_addr, uint32_t inde=
x,
-                                       uint64_t pte, uint64_t flag)
+static MemTxResult vtd_set_flags_in_pte(dma_addr_t base_addr, uint32_t ind=
ex,
+                                       uint64_t pte, uint64_t flags)
 {
-    if (pte & flag) {
+    if ((pte & flags) =3D=3D flags) {
         return MEMTX_OK;
     }
-    pte |=3D flag;
+    pte |=3D flags;
     pte =3D cpu_to_le64(pte);
     return dma_memory_write(&address_space_memory,
                             base_addr + index * sizeof(pte),
@@ -2070,7 +2070,7 @@ static int vtd_iova_to_fspte(IntelIOMMUState *s, VTDC=
ontextEntry *ce,
             flag_ad |=3D VTD_FS_D;
         }
=20
-        if (vtd_set_flag_in_pte(addr, offset, fspte, flag_ad) !=3D MEMTX_O=
K) {
+        if (vtd_set_flags_in_pte(addr, offset, fspte, flag_ad) !=3D MEMTX_=
OK) {
             return -VTD_FR_FS_BIT_UPDATE_FAILED;
         }
=20
--=20
2.53.0

