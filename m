Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B8DCCD19A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 08:59:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLHXl-0008Cv-Ow; Tue, 18 Nov 2025 03:58:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vLHXj-0008CI-W5; Tue, 18 Nov 2025 03:58:32 -0500
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vLHXi-0003Vy-25; Tue, 18 Nov 2025 03:58:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MFxh/ahO7OLlMjed37C+JjqPLyRV7K72Mws5zlu58e1HDcJnwJPJWbbO8MhvT/eV4STc71J3ZpUH6xejxNJfu9vH69aJg8LSGRu6CpDH7ouj5XHJMI5soUSo7laCErH9iO3FQMpNumrXqDZu85b9zSchcNQ3c+JtIWFR4xZzmsCOM5hCGdS0D4ZD6EcBWCF9+KE8lYYN/s7HT4TfM7UAfHRanqYmGd+CvsQZYL0Hw9yQodpa4OHJ/8JPnXRihxU2Kr92DtgQHHF/aADjMX8SUoIo4pF/hRVfAhlObXDaGuFQQrxZL3MzCKAJ6eEt0t2VYj4wKBnTpehPUSuSy364bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1uJ1nZcMszuOEYS2dgtFT0UIQ3DHUQLHvvIi5VaMoM=;
 b=zV3asH1RYy3O47LROsfjuxHZjHRH2DwRMfI75DnfHxe3lG3SijyFEIIX21TMF+NOJiFM9S2OTfjoshVFi+LEWi+9Q+AzNGAtMbuOQMlDwB9yqDphbYKG/ehy6qDG7xB36zZlqEUeuj2f+kpZ/iaGuSPBaVWKXezgU04cShkAQTQZ3ELuGJxKVykUUVXUj4A0WWxAtP/qX/JbzYl8AXj/dLZ2lG6GHY0+fZEjijzgymxWtczC/ywGTYKQ4Z8GPq2tPiJezHgKc0l+AMd3T5jlOaomY9+9SgPGYEDxe7ksG4Z5rcCoZZyob0OKMgjAWmVb9N6pZTwFv8cwLb8rJxyrIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1uJ1nZcMszuOEYS2dgtFT0UIQ3DHUQLHvvIi5VaMoM=;
 b=pJk+ZCROmDThGNkOgyS5rWh9lcXZDGbrcov8JwHLkx6ZOJkJ90ZJgeKUXw3Q6AtY0fPDVuTklggJj10vIpHtYK0R/77KsKuH3x3eZcpZcF45WE+Wye/rUmdOworrGpVC+GzT37uw+85I40YqQc9rrm+UJdftn1fBHRjLrZXTdlc2kM9XxAE2HT8eLQZ9Ls78aFZVopK4jNtXzb+Z0vNWqyxA8sawIxv8SLlHnnFyxedi+BPqxjVT3qhXf2XimRBhE4oeJkpXlCgNUh0AJPuTG+myDgsGsx5Rtb5Iy0fj0pOQtfmkhXngYrRMiZd6GWEry16wswRzC6snG3hLUSU2lg==
Received: from DB9PR09MB6506.eurprd09.prod.outlook.com (2603:10a6:10:303::20)
 by DB8PR09MB3612.eurprd09.prod.outlook.com (2603:10a6:10:112::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 08:58:09 +0000
Received: from DB9PR09MB6506.eurprd09.prod.outlook.com
 ([fe80::1eb3:5638:369d:24f2]) by DB9PR09MB6506.eurprd09.prod.outlook.com
 ([fe80::1eb3:5638:369d:24f2%4]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 08:58:09 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v14 10/14] hw/riscv: Add support for RISCV CPS
Thread-Topic: [PATCH v14 10/14] hw/riscv: Add support for RISCV CPS
Thread-Index: AQHcWGl2JQQxhITBnEujGPJ40Yrneg==
Date: Tue, 18 Nov 2025 08:58:09 +0000
Message-ID: <20251118085758.3996513-11-djordje.todorovic@htecgroup.com>
References: <20251118085758.3996513-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251118085758.3996513-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR09MB6506:EE_|DB8PR09MB3612:EE_
x-ms-office365-filtering-correlation-id: c47dfecd-96d5-450b-ce53-08de268098d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?1YX+wgzjw6OviRAFpwb4LKwUP9oaZebx3++uY/qKyCNfzxyoOPoQD+xgro?=
 =?iso-8859-1?Q?PaRZE0FKnbRuu+VueasKvCOwMMWkLGaWBY/CZ2E5INHdl1TNK1NpaWs3yL?=
 =?iso-8859-1?Q?rUkLor6RqTBjYwDFIciC4jxJx1YxymBXsVIIcHaFDDjMoFa/YKUSIDk1uK?=
 =?iso-8859-1?Q?OroKG8SyEn6kM4N5akUGPXyaxi3L4OmQOepBoeO2224xG2NJb4K6BbNxEb?=
 =?iso-8859-1?Q?z5yvbOh954D7e1Uz22hY1wVhGROtA4q5SHHcQTh0QWf8D03Hq0uKfp9Zwa?=
 =?iso-8859-1?Q?no9yXJxhdHrgTaJwJr2VPC5Sx5JYu2JVPUKFJBRIwb1t5P/ihk/MuBQkeE?=
 =?iso-8859-1?Q?prLRabNAq83xo6Q7U5MRQJzasn4ecY6Z5vUS95N2OU6+ii+K0I9qsicSel?=
 =?iso-8859-1?Q?Xq6gCt5+5CxjFu3us19RsU9hqxJzm3WVUoRQodRjpZLK9vF7l1XCh+phbo?=
 =?iso-8859-1?Q?8ZK25FGeRC089BdJmCZal24sroTeqkhPO/yiBoN4m2YUIHbsRrJBP0cAh4?=
 =?iso-8859-1?Q?b80KeEI3M3sl+P4ciFCWhbOuN8q76h73rqI7ky+cHOdK/ZfM91v+gqk0Pc?=
 =?iso-8859-1?Q?CvzkNLObLO9kPfBzKWTUfgmtJcb0cGvMTw8rJNTzZz1kb88kDpngQvK6o3?=
 =?iso-8859-1?Q?fXW0xvvlkDl8BiDK7QGKKUyfB4Az3JrBTuqIFnvKQ79PiVDzo4tqW2tFnD?=
 =?iso-8859-1?Q?26xVTji8O67rI7IQP3d1chGqcSYUAiTn+zYRHydVNauTQkXpF4L+oK8mFQ?=
 =?iso-8859-1?Q?4tAwi7XfDP2RshfJtiiKy0pgvPOKLz/8CtXIZZBJP6uE57tH+nOuIdHct4?=
 =?iso-8859-1?Q?ZnjaTQ7ZOWdKF9b5R8kKdJMcrddEszN10iqDL80Hmis2/MGGnjjp5piQcW?=
 =?iso-8859-1?Q?pJeVdXgII74V2yiPwWbgGR2GGM0KyHnVanmgu71L3KEbKNN09Rb/TdoAu7?=
 =?iso-8859-1?Q?82t4WxIS6OYVSbToc4cTughWvJIl6pT+Xu2MeCobp55X88GIuiiht/yEG9?=
 =?iso-8859-1?Q?2pvpZ06qT06T6a8t32ERI0PL2JAIF/bt+d+p2Gy/Ir2/+QWMVdJdDf/5Lm?=
 =?iso-8859-1?Q?kQ4AGhiGebyM/7RUywsM4C93PuusRJmnBgwrMo2ej2PU2ErTsKPxBpxZa/?=
 =?iso-8859-1?Q?V5XOeoa9HULONwzDeOfOJOd0OBloEYN8mtkxIkuRGlvgZ9F+R1pzcsBtMR?=
 =?iso-8859-1?Q?fAd/jVJqo/yDrif7KC638ASbrYgMLiaTb6g43CsW3fTB4Cd4sic6pORrGi?=
 =?iso-8859-1?Q?ORqq98pw/7lLKmCXcKXOrMaFBe1o05eRnIib4EHu/M5ayXO+iXI70Tjb9b?=
 =?iso-8859-1?Q?EZ5gxT6enFifcGqMs/gYwKZhv7PFbn79Kk/LLVD4cewfRiPro5uNDD1R06?=
 =?iso-8859-1?Q?myuToC2BsoML9OmGk1R2GdwTDddFK4Q92QL9NVjqpP6vJ4cjUs52kOFrJm?=
 =?iso-8859-1?Q?bIBOEN29589vJ/KBMihq/6y8eAMGbK5X84HclrZUraC8WfmHMjzXucvXyr?=
 =?iso-8859-1?Q?1zpi+ZwWbITRTKFplveoaYNgpOtUT1AwplzfWy1GkwWVmX7mcXw6ZQDJm4?=
 =?iso-8859-1?Q?T6MILwD3c3MO+to7Np5AweIGMt5k?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR09MB6506.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lWOLRRoFPlH3J7LnfgxHQdW++GUZ9e2SUb14aYoHqe3CbiDoBbmjhgLRLs?=
 =?iso-8859-1?Q?nV41tgSjooxuZk1TxqJd+Z0aftJVFZ6rY2Ls1348WO7YnVvCh2AAFXffQL?=
 =?iso-8859-1?Q?KNy6z5RtY3H03NPstHG/oU0CDVgnKnJwzDpN567OMB69bJD+fwhR/mUK3W?=
 =?iso-8859-1?Q?KU5bVU15mbUmmy/ozE3MwIScRzfNYy1hyGClsSO2xqgtH1+2wO/YBONkzE?=
 =?iso-8859-1?Q?HZ3RLOZJ1bXuY8VqMDCIIaKmVtuwkHX0+ZIRjFBykyB3oTgAWopK7W+V1f?=
 =?iso-8859-1?Q?GTLnb6pI1hSwMlxJxhGTbul/GAIgZvHvY1oOpPTOku4g59mXa0BZjb1rZe?=
 =?iso-8859-1?Q?fjgQRLweskcZsIFOImp6eUhv3XGxcfJJvz0kV87PLFAPxLmRyqHAw+p2qp?=
 =?iso-8859-1?Q?PhCkf8hbAiNIHVYABOgCkRyTMytZXoBY8qgZt1iTDq+xT9MA/0gCTvbElE?=
 =?iso-8859-1?Q?/EWMpMAYD0c9+1uRlWwbEPY5uWSwV0fU6bFmDmB9twEHIYkfMui8HjgKU0?=
 =?iso-8859-1?Q?bdrT2ThyhPb72Z2dFXs58LkOCzjOKLFGjwjJ1uc8P2unh2n6CXKPvlh7bK?=
 =?iso-8859-1?Q?VueJhXEr/Ckf8f9/fBeNgIvjmCPxm1BOKE2l9J7A1AWJWq9OEMzqXJksQb?=
 =?iso-8859-1?Q?5Bk0Cuctg9rRu6hyARmJuAIiNsQ9eeCwI0XH0C2mnWbDP2BUhGMx64Wx3o?=
 =?iso-8859-1?Q?mqzXzs+Erj4ZRUOFCxDs2YIeGAhAdoATFpMA+QgLWsZKSg/78QsEvSs1NO?=
 =?iso-8859-1?Q?oPONASyjP4hf9dyPQxyMuKmLPjY6gd6bhc1mp281muA8rSUUruzLjSprzZ?=
 =?iso-8859-1?Q?WM901h+9NkZUdVpOgo7iSzQ2RR3fGCQgmzcgAyDxTRcQbt16KiCTERWq+s?=
 =?iso-8859-1?Q?SPMtkE80UJEF13YgJICneEUc+wlNURhP1OrUit7scEUl06YywxYJBOJULn?=
 =?iso-8859-1?Q?FGYspXPrBmZNITmLUlZLLWKQ0fU0SVr9lInMr7SYJv6EthF9VRgFBnZQOg?=
 =?iso-8859-1?Q?hwQCDdI0tTl3l3bpFaDscLgppeiwVLwRieaZpdccer8CKMSbEbU9BXpscH?=
 =?iso-8859-1?Q?oeXz1Si6EbIoMDJwr2Pi6sPBCpfl0oby+iy8ZgXkil7/uACoklVg/XuY56?=
 =?iso-8859-1?Q?RoYnM9Jj2xq3MVf+qfSYDpQDFWJ/tqd+C8pvvo7Y8mkM6pi7QQDXmwrd4t?=
 =?iso-8859-1?Q?EC+UpGyCqrIuotLk0MLh0vSLGS6LBpFiG4dq6iYthPW+LA+EAVUsV24DkU?=
 =?iso-8859-1?Q?2fOl0vSy3/xj+uT+HAicPWstp20OwvnFSzaUEGNyVz/QXscfXUtjxCHBXK?=
 =?iso-8859-1?Q?h6jeAYohofQh7MpkltAbiby7ypBjUQT5x86vkQHarTYuaXyM3HUtVC14LZ?=
 =?iso-8859-1?Q?wEa8xeB6gxMBAnf/FhqvJcYIm+GyHDQaTERwXDS3KIj0qWjntH/tb8cA88?=
 =?iso-8859-1?Q?Hkx9h9GzUAh1Gj59n6WMhhzCe3PuaEt55hR/7APMCFhTeGuio0phmbvtyK?=
 =?iso-8859-1?Q?D7NmWGaXHiABSvivV7jq9khsso84zJ57FtuO5VxI2DoADDBxIBpVdLX3bE?=
 =?iso-8859-1?Q?utWv6tsEo8Z/xEnDXF85NrGqapLaUzZjfjyKQkj0+oLPo8yK3cIr/wnE7/?=
 =?iso-8859-1?Q?axFkJRtBDl0MRK+S95fQB+B1uX1M32nvJ1I3zmp1EeLUn4l3jMqR/Zeeyu?=
 =?iso-8859-1?Q?NbFykSY1F/4+4W5jDC8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR09MB6506.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c47dfecd-96d5-450b-ce53-08de268098d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 08:58:09.4713 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eCYd/DhZlKqB5c7USAbrhQvsygjSXj/6urcr29O38kKXTbG++aIiD+Pne4FmELL8lSUWUB8CVwpqFOhjbx7wT120sn4Y7wjmT75+72k2iDM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR09MB3612
Received-SPF: pass client-ip=2a01:111:f403:c200::5;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
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

Add support for the Coherent Processing System for RISC-V.
This enables SMP support for RISC-V boards that require
cache-coherent multiprocessor systems.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Acked-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/misc/Kconfig        |   4 +
 hw/riscv/cps.c         | 196 +++++++++++++++++++++++++++++++++++++++++
 hw/riscv/meson.build   |   2 +
 include/hw/riscv/cps.h |  66 ++++++++++++++
 4 files changed, 268 insertions(+)
 create mode 100644 hw/riscv/cps.c
 create mode 100644 include/hw/riscv/cps.h

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 2b308ec9b0..a2726abccc 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -127,12 +127,16 @@ config RISCV_MIPS_CMGCR
 config RISCV_MIPS_CPC
     bool
=20
+config RISCV_MIPS_CPS
+    bool
+
 config MIPS_BOSTON_AIA
     bool
     default y
     depends on RISCV64
     select RISCV_MIPS_CMGCR
     select RISCV_MIPS_CPC
+    select RISCV_MIPS_CPS
=20
 config MPS2_FPGAIO
     bool
diff --git a/hw/riscv/cps.c b/hw/riscv/cps.c
new file mode 100644
index 0000000000..8642d87fbc
--- /dev/null
+++ b/hw/riscv/cps.c
@@ -0,0 +1,196 @@
+/*
+ * Coherent Processing System emulation.
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
+#include "qemu/module.h"
+#include "hw/riscv/cps.h"
+#include "hw/qdev-properties.h"
+#include "system/reset.h"
+#include "hw/intc/riscv_aclint.h"
+#include "hw/intc/riscv_aplic.h"
+#include "hw/intc/riscv_imsic.h"
+#include "hw/pci/msi.h"
+
+static void riscv_cps_init(Object *obj)
+{
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
+    RISCVCPSState *s =3D RISCV_CPS(obj);
+
+    /*
+     * Cover entire address space as there do not seem to be any
+     * constraints for the base address of CPC .
+     */
+    memory_region_init(&s->container, obj, "mips-cps-container", UINT64_MA=
X);
+    sysbus_init_mmio(sbd, &s->container);
+}
+
+static void main_cpu_reset(void *opaque)
+{
+    CPUState *cs =3D opaque;
+
+    cpu_reset(cs);
+}
+
+static void riscv_cps_realize(DeviceState *dev, Error **errp)
+{
+    RISCVCPSState *s =3D RISCV_CPS(dev);
+    RISCVCPU *cpu;
+    int i;
+
+    /* Validate num_vp */
+    if (s->num_vp =3D=3D 0) {
+        error_setg(errp, "num-vp must be at least 1");
+        return;
+    }
+    if (s->num_vp > MAX_HARTS) {
+        error_setg(errp, "num-vp cannot exceed %d", MAX_HARTS);
+        return;
+    }
+
+    /* Allocate CPU array */
+    s->cpus =3D g_new0(CPUState *, s->num_vp);
+
+    /* Set up cpu_index and mhartid for avaiable CPUs. */
+    int harts_in_cluster =3D s->num_hart * s->num_core;
+    int num_of_clusters =3D s->num_vp / harts_in_cluster;
+    for (i =3D 0; i < s->num_vp; i++) {
+        cpu =3D RISCV_CPU(object_new(s->cpu_type));
+
+        /* All VPs are halted on reset. Leave powering up to CPC. */
+        object_property_set_bool(OBJECT(cpu), "start-powered-off", true,
+                                 &error_abort);
+
+        if (!qdev_realize_and_unref(DEVICE(cpu), NULL, errp)) {
+            return;
+        }
+
+        /* Store CPU in array */
+        s->cpus[i] =3D CPU(cpu);
+
+        /* Set up mhartid */
+        int cluster_id =3D i / harts_in_cluster;
+        int hart_id =3D (i % harts_in_cluster) % s->num_hart;
+        int core_id =3D (i % harts_in_cluster) / s->num_hart;
+        int mhartid =3D (cluster_id << MHARTID_CLUSTER_SHIFT) +
+                      (core_id << MHARTID_CORE_SHIFT) +
+                      (hart_id << MHARTID_HART_SHIFT);
+        cpu->env.mhartid =3D mhartid;
+        qemu_register_reset(main_cpu_reset, s->cpus[i]);
+    }
+
+    /* Cluster Power Controller */
+    object_initialize_child(OBJECT(dev), "cpc", &s->cpc, TYPE_RISCV_CPC);
+    object_property_set_uint(OBJECT(&s->cpc), "cluster-id", 0,
+                            &error_abort);
+    object_property_set_uint(OBJECT(&s->cpc), "num-vp", s->num_vp,
+                            &error_abort);
+    object_property_set_uint(OBJECT(&s->cpc), "num-hart", s->num_hart,
+                            &error_abort);
+    object_property_set_uint(OBJECT(&s->cpc), "num-core", s->num_core,
+                            &error_abort);
+
+    /* Pass CPUs to CPC using link properties */
+    for (i =3D 0; i < s->num_vp; i++) {
+        char *propname =3D g_strdup_printf("cpu[%d]", i);
+        object_property_set_link(OBJECT(&s->cpc), propname,
+                                OBJECT(s->cpus[i]), &error_abort);
+        g_free(propname);
+    }
+
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->cpc), errp)) {
+        return;
+    }
+
+    memory_region_add_subregion(&s->container, 0,
+                            sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->cpc)=
, 0));
+
+    /* Global Configuration Registers */
+    object_initialize_child(OBJECT(dev), "gcr", &s->gcr, TYPE_RISCV_GCR);
+    object_property_set_uint(OBJECT(&s->gcr), "cluster-id", 0,
+                            &error_abort);
+    object_property_set_uint(OBJECT(&s->gcr), "num-vp", s->num_vp,
+                            &error_abort);
+    object_property_set_int(OBJECT(&s->gcr), "gcr-rev", 0xa00,
+                            &error_abort);
+    object_property_set_int(OBJECT(&s->gcr), "gcr-base", s->gcr_base,
+                            &error_abort);
+    object_property_set_link(OBJECT(&s->gcr), "cpc", OBJECT(&s->cpc.mr),
+                             &error_abort);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gcr), errp)) {
+        return;
+    }
+
+    memory_region_add_subregion(&s->container, s->gcr_base,
+                            sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->gcr)=
, 0));
+
+    for (i =3D 0; i < num_of_clusters; i++) {
+        uint64_t cm_base =3D GLOBAL_CM_BASE + (CM_SIZE * i);
+        uint32_t hartid_base =3D i << MHARTID_CLUSTER_SHIFT;
+        s->aplic =3D riscv_aplic_create(cm_base + AIA_PLIC_M_OFFSET,
+                                      AIA_PLIC_M_SIZE,
+                                      hartid_base, /* hartid_base */
+                                      MAX_HARTS, /* num_harts */
+                                      APLIC_NUM_SOURCES,
+                                      APLIC_NUM_PRIO_BITS,
+                                      false, true, NULL);
+        riscv_aplic_create(cm_base + AIA_PLIC_S_OFFSET,
+                           AIA_PLIC_S_SIZE,
+                           hartid_base, /* hartid_base */
+                           MAX_HARTS, /* num_harts */
+                           APLIC_NUM_SOURCES,
+                           APLIC_NUM_PRIO_BITS,
+                           false, false, s->aplic);
+        /* PLIC changes msi_nonbroken to ture. We revert the change. */
+        msi_nonbroken =3D false;
+        riscv_aclint_swi_create(cm_base + AIA_CLINT_OFFSET,
+                                hartid_base, MAX_HARTS, false);
+        riscv_aclint_mtimer_create(cm_base + AIA_CLINT_OFFSET +
+                                   RISCV_ACLINT_SWI_SIZE,
+                                   RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
+                                   hartid_base,
+                                   MAX_HARTS,
+                                   RISCV_ACLINT_DEFAULT_MTIMECMP,
+                                   RISCV_ACLINT_DEFAULT_MTIME,
+                                   RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, fal=
se);
+    }
+}
+
+static const Property riscv_cps_properties[] =3D {
+    DEFINE_PROP_UINT32("num-vp", RISCVCPSState, num_vp, 1),
+    DEFINE_PROP_UINT32("num-hart", RISCVCPSState, num_hart, 1),
+    DEFINE_PROP_UINT32("num-core", RISCVCPSState, num_core, 1),
+    DEFINE_PROP_UINT64("gcr-base", RISCVCPSState, gcr_base, GCR_BASE_ADDR)=
,
+    DEFINE_PROP_STRING("cpu-type", RISCVCPSState, cpu_type),
+};
+
+static void riscv_cps_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->realize =3D riscv_cps_realize;
+    device_class_set_props(dc, riscv_cps_properties);
+}
+
+static const TypeInfo riscv_cps_info =3D {
+    .name =3D TYPE_RISCV_CPS,
+    .parent =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(RISCVCPSState),
+    .instance_init =3D riscv_cps_init,
+    .class_init =3D riscv_cps_class_init,
+};
+
+static void riscv_cps_register_types(void)
+{
+    type_register_static(&riscv_cps_info);
+}
+
+type_init(riscv_cps_register_types)
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index 2a8d5b136c..9023b80087 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -15,4 +15,6 @@ riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files(
 riscv_ss.add(when: 'CONFIG_MICROBLAZE_V', if_true: files('microblaze-v-gen=
eric.c'))
 riscv_ss.add(when: 'CONFIG_XIANGSHAN_KUNMINGHU', if_true: files('xiangshan=
_kmh.c'))
=20
+riscv_ss.add(when: 'CONFIG_RISCV_MIPS_CPS', if_true: files('cps.c'))
+
 hw_arch +=3D {'riscv': riscv_ss}
diff --git a/include/hw/riscv/cps.h b/include/hw/riscv/cps.h
new file mode 100644
index 0000000000..00f17112c1
--- /dev/null
+++ b/include/hw/riscv/cps.h
@@ -0,0 +1,66 @@
+/*
+ * Coherent Processing System emulation.
+ *
+ * Copyright (c) 2016 Imagination Technologies
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#ifndef RISCV_CPS_H
+#define RISCV_CPS_H
+
+#include "hw/sysbus.h"
+#include "hw/misc/riscv_cmgcr.h"
+#include "hw/misc/riscv_cpc.h"
+#include "target/riscv/cpu.h"
+#include "qom/object.h"
+
+#define TYPE_RISCV_CPS "riscv-cps"
+OBJECT_DECLARE_SIMPLE_TYPE(RISCVCPSState, RISCV_CPS)
+
+/* The model supports up to 64 harts. */
+#define MAX_HARTS 64
+
+/* The global CM base for the boston-aia model. */
+#define GLOBAL_CM_BASE 0x16100000
+/* The CM block is 512 KiB. */
+#define CM_SIZE (1 << 19)
+
+/*
+ * The mhartid bits has cluster at bit 16, core at bit 4, and hart at
+ * bit 0.
+ */
+
+#define MHARTID_CLUSTER_SHIFT 16
+#define MHARTID_CORE_SHIFT 4
+#define MHARTID_HART_SHIFT 0
+
+#define APLIC_NUM_SOURCES 0x35 /* Arbitray maximum number of interrupts. *=
/
+#define APLIC_NUM_PRIO_BITS 3
+#define AIA_PLIC_M_OFFSET 0x40000
+#define AIA_PLIC_M_SIZE 0x8000
+#define AIA_PLIC_S_OFFSET 0x60000
+#define AIA_PLIC_S_SIZE 0x8000
+#define AIA_CLINT_OFFSET 0x50000
+
+typedef struct RISCVCPSState {
+    SysBusDevice parent_obj;
+
+    uint32_t num_vp;
+    uint32_t num_hart;
+    uint32_t num_core;
+    uint64_t gcr_base;
+    char *cpu_type;
+
+    MemoryRegion container;
+    RISCVGCRState gcr;
+    RISCVCPCState cpc;
+
+    DeviceState *aplic;
+    CPUState **cpus;
+} RISCVCPSState;
+
+#endif
--=20
2.34.1

