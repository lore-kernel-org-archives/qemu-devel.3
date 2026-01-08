Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCCC6D185F9
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 13:43:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdqH6-0002c6-OJ; Thu, 08 Jan 2026 08:42:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vdqH1-0002a9-06; Thu, 08 Jan 2026 08:42:00 -0500
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vdqGx-0005p5-5k; Thu, 08 Jan 2026 08:41:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XXJysftfRl7mtO+BBTSzPfOvMQ28QVkFp9Uk4jJfVmm0WzvgCIjoLyPyABDaC0kL2TKFejA3KLsYSq11w36x4ULn6599ym4H9UgqzACwnWT6nAgYeTxsLaVA6yBjZ2e5Sjy8bE9m3Q5uJPevVIGNjwLi8gqyH/+zml/8/jIXNxyVEP4ycxkZvvr44Hshmc7KQxYd5xYySnSqUKcLvUHLnPJHzfiJ+7JlHnJrKDf0/NI55nG3QH5FbcoVsIUtpmTrYW2xGx81lyhaEJX4aPcuwPJqRpr+26VI6Skw+OGC79rptsPeANAi8K8bp7sVn8maT5kRNMkfF7eOYC1xi8Pjwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/xQGPsUkkbkTXmN0OmZGS33zeK3nHZKyUQDZeequ+Os=;
 b=HGjsxFEVxMWUBNdCXjYbLiLp1WVzFn/VPYqDMSbAadHVBYAb98c0+H/3nhfkEn25vduxi69UtfdAw9N7flnQHuJC+s8EX2oAYYuZFvFGBAgUe/hRayvd4/3g0kXssiZZy2TAh1m8EpXk/Kvd3VRh20aNL2NMlxztXl6hFSLsPxTlw88aPNukf3U1axC/PWfWRx5Of+sDtOAEEbn3JD5clxLTMshtsly89vafHxzes+a6960ROjLwSkELDcvN7RrdjApbNXs3IPIQxVYTwIAgiHGmq1bfrZnibEAyNFVkXm16coeWbA0fgLfBpeAlayQe904iLUzdtle+v7oNlXSRqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xQGPsUkkbkTXmN0OmZGS33zeK3nHZKyUQDZeequ+Os=;
 b=oSjjgXaZnRfpgamDSJ7CD8VrJNvkXZR4HiGKA/jaBIn8Qa53zgl109NkPLae9S5RCQhrlbsWyN7x92Cx80yaBVeT4rjp/J536zw8s6m9kNPnv7FWGo4omn0QPkKbmQgsdLxu1OgU/bHamMGhYPqZPpNm+3zIzf3/H9fZhHanlf786oQiIi5J4e7j/CCCf0lURRK1ISEl1o2xwQGgclx5ztSO07j1PN2OLa1hnrzzz5L4yNgfAvcFRT7llh/S2ARj21XNNm56+PuEj48wgoo/mvZwHvbvf0/0UGEz3Yc5hOL3lt9B4TI/bLqepVaEra3yX0n8wfRzcSJ8Phz90rPYTg==
Received: from DB8PR09MB2796.eurprd09.prod.outlook.com (2603:10a6:10:ab::30)
 by AM8PR09MB5226.eurprd09.prod.outlook.com (2603:10a6:20b:3d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 13:41:39 +0000
Received: from DB8PR09MB2796.eurprd09.prod.outlook.com
 ([fe80::e42:9fbc:3e58:febe]) by DB8PR09MB2796.eurprd09.prod.outlook.com
 ([fe80::e42:9fbc:3e58:febe%6]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 13:41:39 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v16 08/12] hw/misc: Add RISC-V CPC device implementation
Thread-Topic: [PATCH v16 08/12] hw/misc: Add RISC-V CPC device implementation
Thread-Index: AQHcgKSDdBVOp+CEdEKZawSOG8edgQ==
Date: Thu, 8 Jan 2026 13:41:38 +0000
Message-ID: <20260108134128.2218102-9-djordje.todorovic@htecgroup.com>
References: <20260108134128.2218102-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260108134128.2218102-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR09MB2796:EE_|AM8PR09MB5226:EE_
x-ms-office365-filtering-correlation-id: a01f82aa-f0b7-4468-ebb5-08de4ebba67d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?ekIv0YFzHdKCE0QXVrZ3/1ADfY1L7idNhuSrGsxvyw/WppbNGHs0THQbFP?=
 =?iso-8859-1?Q?wtBpuAEgiuffZVX+kJqVqBx4Q/+Jk6cK5Pp8lwKWejCqIXjVJHEgEDIUUg?=
 =?iso-8859-1?Q?RohnXVVWLnHhmWqoJ/kzit7MHsVXRs7PAQnwNO8rprR/20FL3LmMT/eOwm?=
 =?iso-8859-1?Q?h1qPcFzyjYV7YdEQYPDlvxJoiCKcgIyn6buroTSTpBoe2nKJtcFPz0gOxE?=
 =?iso-8859-1?Q?zAvb9EyFThKVUf9VoRAf6F2JsRWxuMrcaChsA9WogPyCIQjBpymxrU5QMI?=
 =?iso-8859-1?Q?B6ReRBdazoRwzkpTmlPDSowAa6GfjYt+V+jyzjWxzUWarcT40jeJ8GpriO?=
 =?iso-8859-1?Q?bwZK1VuvR3c4Qg6JHBdRnNk7ok42ot1ta48C0e+sh5YhxlVKTor+exYj/L?=
 =?iso-8859-1?Q?OYEVurpQJEPMtHtYCgnottORopIsmbW0eG2PkiOEPfOlsocfOZ41GBRan2?=
 =?iso-8859-1?Q?jKLI1CjSnxM6RjbrxBgJ6KQQHA/nc0XHy6pvb551DswUdkyxPmWbSzKYf6?=
 =?iso-8859-1?Q?2D8HlwWqztzaUHUDKcKtkGGIQLyHs6ttaGVkfToCCIPnnS3DneCDeH5VQb?=
 =?iso-8859-1?Q?bVRfmpgSlyj1vpdLljkFIyMS319O5Pi83fgn1Vf55yUqetdO4FBeaUKAzg?=
 =?iso-8859-1?Q?xZAHgWntfh6a6/vq5qe5UJXjHYfch5Ufm4BB+0Kqu4AWz6LCJRZP/6hfoS?=
 =?iso-8859-1?Q?1pexIpi6ai4eDnuzbsu6TushAnXkwZfKf4yt9vpsYsEulWXdI4HzwVbuMj?=
 =?iso-8859-1?Q?xNrdKY4CRwaTIXgH9QWe/wBrbBYKW2EMQrXgLcz35Y4kK24pvHbTyB12eE?=
 =?iso-8859-1?Q?AAaMSmhyxW5YdZWpVvSJsgZuIhR/NgpNPT3GHC/2OLK0SPFsCy+4ogwXQV?=
 =?iso-8859-1?Q?TH2sNVgsWJBOsHbjCdZaydZmRm3mBlhkqn7OnYMbkO821bcl/LJ8q6GShz?=
 =?iso-8859-1?Q?lRoc/8/4ofwPOPaEWfJVfspLJlLLeMnD6KopCx6FOFHDmNBFeQbZOrbN7h?=
 =?iso-8859-1?Q?7SDADYDi9IbQopBOHQ8qr+Afvg2OTUVq+1WqK912mejlZjrwbA/aI11uVP?=
 =?iso-8859-1?Q?2Wi/tX63F/3RR2cbVMiHUQXYhExYAF+FGJcrHJ/VCQwaZLGZO+P+PslyiL?=
 =?iso-8859-1?Q?9BwUl06xnaR2VcV0BgMBwBt1R0qTC5P0p4kTJb4GAnYFx5bOjLtFTOGUGt?=
 =?iso-8859-1?Q?fo0h+q+3jf5eJ2p3zQDpM+i6xJssR6QoKsu7mGV8/bFPOnoTT6hgicYsrE?=
 =?iso-8859-1?Q?xSUGi8+gf4johHYn04lkxGzzxkflWllBP6mGeh8Lb/vV+wRnULc85tdCk4?=
 =?iso-8859-1?Q?ia1LrmTX4qTx3Znhb/khUcIPD0EXf9jvng2LZjhLomNdbOOkSgbk4h9+FK?=
 =?iso-8859-1?Q?zqylbXjbfBVypwjZ+OQ17oJRbwcCP3q20tqIoOriY6+Mrz8igVpHnXGSB+?=
 =?iso-8859-1?Q?8NjA0wh1LIX/4Q3XNMhGJEB+C+xhKee3jFA9bRrEP04HmqFVb46QRXsFj5?=
 =?iso-8859-1?Q?n1sGi7XbuHyQoNvoEGeWDMOk/ZufMEIVCn2rGw80w2bdsMHTgj1vDKowGq?=
 =?iso-8859-1?Q?jdCb8MqOekIN+HpKwjivb/8ruNWq?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB8PR09MB2796.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qbF25RXswIjPB3WdUGfy8FO5HHS2XHMaHfSW4t+k6eAIYRmVglijci/jvO?=
 =?iso-8859-1?Q?lhhzFTl+BYNe9YJW8vipZrX0zPLpBumcrQsgY/z9iTseNu9teelA34D9s9?=
 =?iso-8859-1?Q?WVBuh6Y+lNRHwkIIm+rWxvBDLpkf49dMLRcpNHnNHFsM9ki46edD2C2uef?=
 =?iso-8859-1?Q?i1IO6dqLQJ8QmYC9I+x22/RJAEXx4mM/j3dhL4vksl96bf0Kn8U5Lnh9l3?=
 =?iso-8859-1?Q?2gOep0usfXzdJzyE0JAqGYq7eFzD/DL82t8sywog1IzZsHSoOhuTtl9ZYn?=
 =?iso-8859-1?Q?MnpbnCToj80bRYNCN+yJAZmPT1h0bzHKKnI6bVp5lgkFykCkghW92ht8jK?=
 =?iso-8859-1?Q?AWogI1exasigcpynuuhHl4UCS+fCO4sNr31TaGWl0UTvX3tdsngZeiSHRT?=
 =?iso-8859-1?Q?wTzCf1myZFZoUsRjco7LP1nIABnLsU+R4jTvOwB2iIjv1UeINP2PSw/WsD?=
 =?iso-8859-1?Q?He9VucnulbxHuHIOlVm4pzVeaP+m5BCFrR0Jx0wuIg35ENa0knrtkbpZVU?=
 =?iso-8859-1?Q?n1LNHTfR8AarA92mAH2QqAFz6Gron2AqejMtglhM8jLNK2g7fmO67MeIiz?=
 =?iso-8859-1?Q?ceXq63Mv0eS8GOxft6aYQxTXgh3vdg7UCRZrD08VbDMp0KM7Tzf9wsACyq?=
 =?iso-8859-1?Q?aDLnOHCmr1TGuNOLKFLERgmcu1h8f7NKM1T66tFxQyCqRcBcn9fGg6T7S/?=
 =?iso-8859-1?Q?Z1AfuLveDw8K8x4hGXr1wbALNiXS9sEeqmTg8m+g63p31+n76LWe4Hu/Kc?=
 =?iso-8859-1?Q?1un7yki3RiQevnGA/Uk6maXTl5zA3RXyJ8LhY8WKbVrwB/68+OZlBeiJaz?=
 =?iso-8859-1?Q?EljhQ8sGueySykDl/BNn4uDGYQNVnY2zzkE4KmJ43qqV4xnZoL44HLkziT?=
 =?iso-8859-1?Q?xPlJ3BWxwGAkhP3Y4WWLCeNlxsnuB+I0OnUYmGYvySeiBws+t6Y6hJ62kz?=
 =?iso-8859-1?Q?MF8DUzeEH0hIa/mGaXqqXOMKz3ixL67Kh1Vd8juUogsiPgz4cEC4fGP+V6?=
 =?iso-8859-1?Q?3lrQdOXs+m7ftY4xRO1eguznzg+t2YRPIsnsgIXs7LjE0f37hy+EgN2D1R?=
 =?iso-8859-1?Q?7tHV5Wp4HzhSUa+5SIhn3n8JSbdN3bbtPIWaU9WKP5aVVDOwiZu1gdJl+C?=
 =?iso-8859-1?Q?5eM8kiZSRqfaisUkkeOszZ7F0NXM38aHB2LMXWdiZ9s1+8fRbQcJZC0ZHT?=
 =?iso-8859-1?Q?Ol1UCKtj4Z7d7PJrzGyrGRjpOf/c3wn7j5iORV3Q0N5ZZGccCjELOnmjEZ?=
 =?iso-8859-1?Q?PhrnSvYEMaZbrCXihmklKJE3ZwlXcEJkpHRV3L/IubXOMuOIv3qSiklutZ?=
 =?iso-8859-1?Q?YZ4UoFuynuYcHfOjWko4F2rQmH2XZq85z88rd+nYgEu0lftB3xGTEgt/Gm?=
 =?iso-8859-1?Q?BKA5AbIYCy7DxB+oIfCRYohmF+afLrR0GA9PA4hunxLFQjrDuNnFEl8T1f?=
 =?iso-8859-1?Q?88sGu7ln3PvClXSQS0Fo9+P/LKrSgMnS75IQ6SIfgvSwEgRUpKOz/ACzIx?=
 =?iso-8859-1?Q?Q0hxUzTDOg1wRvbBULtWB6eoHMOzA5VsiFnrHeV33ijqQj9f2cv0P2v1oM?=
 =?iso-8859-1?Q?DxSiO++Sp9yZ65F25Lyr6rZrDEzGHdtny4arwTdfiz4e4fBqXXZy709iY2?=
 =?iso-8859-1?Q?AdoprZEG2dvKTwl+QbBlsAeXvwW5oNi+1lDr4eYTjSc/JaMEBiFACgSbd7?=
 =?iso-8859-1?Q?KPPG+7L5HsBxpFgriwRat9ywRoi5Q9Lt0lyB4otiNXmGrSkveIsDRtr5S4?=
 =?iso-8859-1?Q?dDWCN/0rOw4sfJy+UV2WvLlrz9mV2A+e9+TkoCTxVCAorN3py5a6o6/p5a?=
 =?iso-8859-1?Q?ph52cc1c9YGhyawwKrKoofth1/eg3YwtgtPaMwHXxxg4pBZsB5T4?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR09MB2796.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a01f82aa-f0b7-4468-ebb5-08de4ebba67d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2026 13:41:38.8202 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d+A7OSwYFfs7STHyn3VIwUtt4eaX4vIqrTqebmsAoSiFfgQnn7Z1Q1nh/LDuZinmV+SPzFx0UsEVpRvCrIuHvdVM5i6L9/d8I4edMNO7hW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR09MB5226
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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
 hw/misc/riscv_cpc.c         | 265 ++++++++++++++++++++++++++++++++++++
 include/hw/misc/riscv_cpc.h |  64 +++++++++
 4 files changed, 334 insertions(+)
 create mode 100644 hw/misc/riscv_cpc.c
 create mode 100644 include/hw/misc/riscv_cpc.h

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 404500979c..38be72b141 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -124,11 +124,15 @@ config MIPS_ITU
 config RISCV_MIPS_CMGCR
     bool
=20
+config RISCV_MIPS_CPC
+    bool
+
 config MIPS_BOSTON_AIA
     bool
     default y
     depends on RISCV64
     select RISCV_MIPS_CMGCR
+    select RISCV_MIPS_CPC
=20
 config MPS2_FPGAIO
     bool
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 489f0f3319..32b878e035 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -158,6 +158,7 @@ specific_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files=
('mips_cmgcr.c', 'mips_cp
 specific_ss.add(when: 'CONFIG_MIPS_ITU', if_true: files('mips_itu.c'))
=20
 specific_ss.add(when: 'CONFIG_RISCV_MIPS_CMGCR', if_true: files('riscv_cmg=
cr.c'))
+specific_ss.add(when: 'CONFIG_RISCV_MIPS_CPC', if_true: files('riscv_cpc.c=
'))
=20
 system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
=20
diff --git a/hw/misc/riscv_cpc.c b/hw/misc/riscv_cpc.c
new file mode 100644
index 0000000000..231a419062
--- /dev/null
+++ b/hw/misc/riscv_cpc.c
@@ -0,0 +1,265 @@
+/*
+ * Cluster Power Controller emulation
+ *
+ * Copyright (c) 2016 Imagination Technologies
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Reference: MIPS P8700 documentation
+ *            (https://mips.com/products/hardware/p8700/)
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "cpu.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/timer.h"
+#include "qemu/bitops.h"
+#include "hw/core/sysbus.h"
+#include "migration/vmstate.h"
+
+#include "hw/misc/riscv_cpc.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/intc/riscv_aclint.h"
+#include "hw/core/resettable.h"
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
index 0000000000..43343ed9e6
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
+#include "hw/core/sysbus.h"
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

