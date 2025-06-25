Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 533C8C7EE2A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 14:21:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUQxX-00075T-Mf; Wed, 25 Jun 2025 10:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uUQxV-00074H-3z; Wed, 25 Jun 2025 10:18:41 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uUQxS-00048d-34; Wed, 25 Jun 2025 10:18:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kQU+sc0IxnoYOC0zrjmc+O766qt7yGJVytht1q/LxC76VJNi8r6AmZmK+9T62kNBE78uNPLj/MyAGdnmu7IZJabnyY1fgcQ55IrjXvCq2dxIbl+d7PpzvA/vycx7XaQ+9eSyhanEZHxm+WQf6XVdKuUiam8dSZ3ndv2DnpbFq/P7yzce0MUk0XBp3XK04AcULSwgu2IbUPCt9kd7jsPMSd/5/CUpp3iZQdUFj8K1qCYE5tjVgcONv7dRvqyGJULhxin66IQpdsqKJc3AeR1kW2Ksjm8/32YIExd649Lamr0X1dJs+xy5ClwiVZ/gDh8Y0/r50orKSwcqGL2lKnnddg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=blrwSJYBmalMRvIhy5o0VT1JQDFUJ9y7KVTgJEFRmAU=;
 b=SUp1N16bAGF6EBY6YhAe8WddEP4ZvcmZmK3X/uB2lCMlPlteHhsDn0v5exXaM8Uc20ER9sBWI4DoAlGrAnT9hasJZOnyVshDCSFWgkirGzn8/97Jj0nNxEZp+Z6233WDNVADZPlqzKdU2+iZRJe8s3q659YSu9yQPFH3kPze+Qf1L+ZaO80FeTu13lGk5xSY8foH8VsaHDrj5224r/HZKR6ZT8WNq+8IIVDn+qbc56/CE8rQmyroQ3xsTygwByxFKi2nrHIseQf+cQ5g8mFDv4sDjzeSfv0z3Q6pTg2rTZpI+wY1Q7fbr4hRr4K+Fk3oFr2HsxTxcjgWu+xxdkd15g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=blrwSJYBmalMRvIhy5o0VT1JQDFUJ9y7KVTgJEFRmAU=;
 b=D4Gtqqm3i0SBEDm8GTNOyOHwue9pwb59oog2XlRmQ4nt86kSK0KGSJDH3PItCL9jEJkXfgOxMxC2ITE79BvqpR7Mg4GLsNRklUJpf5Wt1nBKAMH0hz4LWSplHxRiK6hHypwZP902WDGsRlFPb9VT9cl1ySo/gdM2+WqRtQRxldFQTKd+bl49WT9ztCMNqCj3eunHPBVpZ8cXYTnbBXSdo8R6kVXiQTNpF15XFq2APW87hH+vYNW0zrDDw6kxJprrKhMEeiyOJd1n5SOljSpvLL0NRydFY6jt0WaIWcAlOOHIAh90NTyAOl6YYaobAl7KPg7kvWUA58AdhDpw/TR9wQ==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by AM0PR09MB3665.eurprd09.prod.outlook.com (2603:10a6:208:182::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 14:18:21 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%3]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 14:18:21 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v4 08/11] hw/misc: Add support for MIPS Boston-aia board model
Thread-Topic: [PATCH v4 08/11] hw/misc: Add support for MIPS Boston-aia board
 model
Thread-Index: AQHb5dwB3S58oVaIk0uukQmB7gGNTw==
Date: Wed, 25 Jun 2025 14:18:21 +0000
Message-ID: <20250625141732.59084-9-djordje.todorovic@htecgroup.com>
References: <20250625141732.59084-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250625141732.59084-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|AM0PR09MB3665:EE_
x-ms-office365-filtering-correlation-id: 066c1e6e-ec89-44a3-cd3e-08ddb3f323a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|13003099007|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?kzIfGo1jd3FJRDT8tVKvTTCpZ4+xYPDG2b+b3AOgFKzcHy1pRirw6r7mfh?=
 =?iso-8859-1?Q?va224uUO3Iur7RifsZmzWcXIUG9T0Th/k9/VDdbJgHNmTg1gdkdCKZyfoV?=
 =?iso-8859-1?Q?RG1sd/p7kaGlUmrtqvbphHZBY16RwyvcyM09VyOJ2WbJP6fBDlGmTjrjEU?=
 =?iso-8859-1?Q?/dkn1Zn2eiSNcQnV63lYhG4dGRDGi7bSLei5jwFcWMUZBEby7vYf0CLkLH?=
 =?iso-8859-1?Q?sWnZ/gmX0GrRT+BMssE6jIRqCFW0q+oDYyYCqjyB07qqFJQ313+7kvcCo1?=
 =?iso-8859-1?Q?e4A0lofkdvZyV9QAxXnxOmGt9oz39e7tWTf2aWeiT0lndpFWWKaTyiwaX5?=
 =?iso-8859-1?Q?xnMs3b5O6jjQTxFTza1S5Il5v8Qc0CuGuGZAWCzU7KLzYpwM4YvZy48mOS?=
 =?iso-8859-1?Q?oe5I1/ANBtGSU6k9mx67G9oMrK+VqImqu369knuZgdppu/JqA3KEmsPPjj?=
 =?iso-8859-1?Q?bW4pLESwJIg5Eo6bJGiULH9yP0WC5GVHQjFtX9GGa3uPQ4BcnUWEq1cFk2?=
 =?iso-8859-1?Q?HypHBZfE5DBVLwPYaBX4LbmHrtLYBOBMhz0n5Zs6y9ntQ6B+o5vcQLm1EC?=
 =?iso-8859-1?Q?YpFF5z/aZselqCQjPfcg6hymCn4UnRGxSTKVJ8Wl+iN9qtD3w2jb/LC4aQ?=
 =?iso-8859-1?Q?7YPOqLzfZvcuth3X5xhuhEUOX+AGo+CW5iUHy7cWZLbRaqL6LbzCYZAM3O?=
 =?iso-8859-1?Q?n6jw4h0pBHimPTsge0/KhxVo0oFwhDDw0Fj4bkBCj/kQJHNzGpDBRtjjLX?=
 =?iso-8859-1?Q?Sa0wIXHOJ5n/h4qjBXrDUvSL39oe1YdQw7Z0Y8Q29uC8gLvIc33TtNopGI?=
 =?iso-8859-1?Q?9TMvQ0FkAoBJsIymBQnG0Pg/FROaeevPvrWK6zaZSt6yzxCps19QD6xhrm?=
 =?iso-8859-1?Q?WmlKTdd6UK+1OlAr518UeIuorot96A0jn7fqX0QEFL2HdXSJ9asKN7eRnd?=
 =?iso-8859-1?Q?sFt5X8B1sBJAW/y0MplkjCGLC9BwSlow6AAG1cii2EOHeSzedvSUBaw5lo?=
 =?iso-8859-1?Q?sgpvHETIIsfgWWqbcTerIZ3rtN9267Enbu1cHmxkh5GZn6R7NKfbiTCfup?=
 =?iso-8859-1?Q?3ZJ31b+fdRE+0yqkfQGH5sUvsizX9GPkBsd83fzZgg6gwIR1v2HBH459ym?=
 =?iso-8859-1?Q?xTEEtkKc/UuK29ggXT7G8NAqRNQeCFYI1Zie2RkfKEDPKrEdeC55DP64hy?=
 =?iso-8859-1?Q?2UmIFrR99RodG2W0XQYJcZZdTdBJCbChlsf/3CAHBV+zro1wbXyNn56PZh?=
 =?iso-8859-1?Q?8pN1moNA1nfTCxEHAAm7VxTHUuhGySljEfTB4dZJnrL0l4Cy0NcBcir7R0?=
 =?iso-8859-1?Q?AE34aEegGY3Dpl5QCOUE+FNp4WxiBX0YsyhE5DAQFrg1fAJ70s9kqPQW2q?=
 =?iso-8859-1?Q?nGDkGSDRirz8AO8Yuzs7/2OTCwVI4+bivpHOIuiy/T9yvv802snKJzqvFa?=
 =?iso-8859-1?Q?4lB6yMVHG5IRAN907PEr8yVcfbt3icNREqXMr+/mcaI9OZp+jYQKYCHI8R?=
 =?iso-8859-1?Q?2LZ0BvsMQaJlMbSYGX1gPkwjyhUQ6Vxj9YxuDJS/iHK+pChyTsjP2GckpI?=
 =?iso-8859-1?Q?TcSUUoA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(13003099007)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?bs3RHkwdGZgljp62Vr+jd9wpW0r5A8mQPSCiB0Ii/JG8bcf2MlV/4/jm3i?=
 =?iso-8859-1?Q?AHxYgCVDPhxW+Pet6uIIAShD9oMfOBGJKmwzAm2tutkoAX9VgKbKhmfF/J?=
 =?iso-8859-1?Q?kCzZoP/G/VzLsSalGlqxtRTh7oUIT4qVifsXyi9YDqhEL0WK7cTSuaQGQV?=
 =?iso-8859-1?Q?RuYmso1zQg6iH47iTWaal0QIDdQgmnt/S4rMLdVMqLCSF9xyEv/qOy6ZOf?=
 =?iso-8859-1?Q?ljaSKaJzwNxz5+YdsBftQTpDvqHAUdNhf05kmx9dhjYXqITYfKxBdahKyj?=
 =?iso-8859-1?Q?xR9+eVlEY0yoqP4TcW9j9NVUfG/7ktJE7+JhD1E7KQaBjNiQ0EHknzCDLe?=
 =?iso-8859-1?Q?QfapXJ9jlKp2Ib1wIpjTDSgJ4qXdhCykIkmZ7PzIdbeZhMBeqcXFZWVI6H?=
 =?iso-8859-1?Q?GiunA/CP98kq8QVsDppvbT5741H/T+Jv2O2s6oNFTD2dLVvozbwKKDb1l+?=
 =?iso-8859-1?Q?dGaVty/MtcH5rvWyu/rm4zSF3ptsfCAS4JU+a/+PzJ6Zhox8CFq2/tHqbE?=
 =?iso-8859-1?Q?Z82KgxONHiTZhach/dc7sM8C9YBikYYLOgvsVBRVDCLV70WPFDxlSa/cEL?=
 =?iso-8859-1?Q?yuiA/CBQk2TmG3EKH2bunns1bbRjpjB721O+d7JYgKs/SQ8INbv1UllzcB?=
 =?iso-8859-1?Q?0D1hNKE7WzFpyHv6ARYtmJc2f10cAs9BMQ5qkuUiGmLueAJGDA1BKYm/XM?=
 =?iso-8859-1?Q?RuTcBoTX0xfWVOqFWgQUFUhIdTpw4N4nC6rbHm6IVxhdjoEJxQsrrNGzEy?=
 =?iso-8859-1?Q?4bPtUhuKQU1ksUOyEb8YkkAGK3jUFYLwMq58GYJvP7lCMfMc+eP1sQsXSV?=
 =?iso-8859-1?Q?vz7SHLdyHQnWqVNl5ahclQI24Lv+umM5zH+gatZWGIlX6mBPsVzReatkO/?=
 =?iso-8859-1?Q?TnYhayQI1KgyHmJ/4uUlXBaEIW1Cd/yYJuJVBHo+G5nD2oDBatDEvNgfhc?=
 =?iso-8859-1?Q?U4gbQtalEftVDGKkxI9fRoVET9Ajur+HM6UyBDZYCXMDGzDn2xk7nKMIES?=
 =?iso-8859-1?Q?6cemwaGDaPSvFRSxdnTmcFzuEzm8wk0vuswPMD5YdWcVf0DQu6uJPk+1mv?=
 =?iso-8859-1?Q?Ds9hlVj2P1hvRZJ2kZxZr1ybyRR1Hf0agH/gEsoYkLCqddVd586jN7M5Ut?=
 =?iso-8859-1?Q?NL0p0P7W+xQBE37A81Fo+vNqEAs6ZZMEfuYoH+mgKl8CTZsMaxBBAx44M/?=
 =?iso-8859-1?Q?TnOL5sJvVEDgcSZlwzmIu/uG2bCgAMWlIH9TqfXY4v8KLfW8nlqJKSOW16?=
 =?iso-8859-1?Q?6RHbYQaCrsmrW5dEbwvwMnLX2yvhsTRm2yptIFqJRSRTb9yNdzVYiPnN8+?=
 =?iso-8859-1?Q?B44uaQPlP1bThz2ySEh9ggj3GYezeoHdrJpSv1UeSjh0rm0Gbcqv9hN2eZ?=
 =?iso-8859-1?Q?ui+4Ndu496tDOMJo7pq6VVmy0FuGlXzZuT37D4JfVwtsyJUSbTQnv/PNP8?=
 =?iso-8859-1?Q?zSJYSvrf/nxP3r/Wck9NRVU7cJKgGE7FOJYf83fQwuwsBey1EJWFXRBYmD?=
 =?iso-8859-1?Q?YI6AHiIrOZcTJHWCrL5zHYVLpea8tO52M27Aw0zbzyD/Uqm37MZqcqZA3B?=
 =?iso-8859-1?Q?qcRqaHmNfv+WIe5hxlzCWDcfTKGl1WQKfEplRD5B5iNm4+HyhJuFOu5MGt?=
 =?iso-8859-1?Q?QDCd5oK2M9pfJJxNwHmWQxVF1955TpGaupMK/hbva6/CPxuP5hP5jXXcA0?=
 =?iso-8859-1?Q?wWwlayQIlPqIuK0/9bo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 066c1e6e-ec89-44a3-cd3e-08ddb3f323a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 14:18:21.2446 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pR4tFKImHlpGKs63cRRcuQXTIzmqhJNeZFTtEA0DFNlDGzph1z8iyranEz+NQ0Fwq1Xo/J9PDUCzBQqXM8pgiZyUySwC0zwJzufMn0xq6vc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB3665
Received-SPF: pass client-ip=2a01:111:f403:c201::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
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

The board model supports up to 64 harts with MIPS CPS, MIPS GCR,
MIPS CPC, AIA plic, and AIA clint devices. The model can create
boot code, if there is no -bios parameter. We can specify -smp x,
cores=3Dy,thread=3Dz.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 hw/misc/Kconfig               |   5 +
 hw/misc/meson.build           |   1 +
 hw/misc/riscv_cmgcr.c         | 206 +++++++++++++++++++++++++++++++
 hw/misc/riscv_cpc.c           | 225 ++++++++++++++++++++++++++++++++++
 include/hw/misc/riscv_cmgcr.h |  77 ++++++++++++
 include/hw/misc/riscv_cpc.h   |  69 +++++++++++
 6 files changed, 583 insertions(+)
 create mode 100644 hw/misc/riscv_cmgcr.c
 create mode 100644 hw/misc/riscv_cpc.c
 create mode 100644 include/hw/misc/riscv_cmgcr.h
 create mode 100644 include/hw/misc/riscv_cpc.h

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index ec0fa5aa9f..65a89637ed 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -108,6 +108,11 @@ config STM32L4X5_RCC
 config MIPS_ITU
     bool
=20
+config MIPS_BOSTON_AIA
+    bool
+    default n
+    depends on RISCV64
+
 config MPS2_FPGAIO
     bool
     select LED
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 6d47de482c..05b1c0f3cc 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -152,6 +152,7 @@ specific_ss.add(when: 'CONFIG_MAC_VIA', if_true: files(=
'mac_via.c'))
=20
 specific_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('mips_cmgcr.c', 'm=
ips_cpc.c'))
 specific_ss.add(when: 'CONFIG_MIPS_ITU', if_true: files('mips_itu.c'))
+specific_ss.add(when: 'CONFIG_MIPS_BOSTON_AIA', if_true: files('riscv_cmgc=
r.c', 'riscv_cpc.c'))
=20
 system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
=20
diff --git a/hw/misc/riscv_cmgcr.c b/hw/misc/riscv_cmgcr.c
new file mode 100644
index 0000000000..2954e3b406
--- /dev/null
+++ b/hw/misc/riscv_cmgcr.c
@@ -0,0 +1,206 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Pub=
lic
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
+ * Authors: Sanjay Lal <sanjayl@kymasys.com>
+ *
+ * Copyright (C) 2015 Imagination Technologies
+ *
+ * Copyright (C) 2025 MIPS
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "hw/sysbus.h"
+#include "migration/vmstate.h"
+#include "hw/misc/riscv_cmgcr.h"
+#include "hw/misc/riscv_cpc.h"
+#include "hw/qdev-properties.h"
+
+#include "cpu.h"
+
+#define CM_RESET_VEC 0x1FC00000
+
+static inline bool is_cpc_connected(RISCVGCRState *s)
+{
+    return s->cpc_mr !=3D NULL;
+}
+
+static inline void update_cpc_base(RISCVGCRState *gcr, uint64_t val)
+{
+    if (is_cpc_connected(gcr)) {
+        gcr->cpc_base =3D val & GCR_CPC_BASE_MSK;
+        memory_region_transaction_begin();
+        memory_region_set_address(gcr->cpc_mr,
+                                  gcr->cpc_base & GCR_CPC_BASE_CPCBASE_MSK=
);
+        memory_region_set_enabled(gcr->cpc_mr,
+                                  gcr->cpc_base & GCR_CPC_BASE_CPCEN_MSK);
+        memory_region_transaction_commit();
+    }
+}
+
+static inline void update_gcr_base(RISCVGCRState *gcr, uint64_t val)
+{
+    gcr->gcr_base =3D val & GCR_BASE_GCRBASE_MSK;
+    memory_region_set_address(&gcr->iomem, gcr->gcr_base);
+
+    /* For boston-aia, cpc_base is set to gcr_base + 0x8001 to enable
+       cpc automatically. */
+    update_cpc_base(gcr, val + 0x8001);
+}
+
+/* Read GCR registers */
+static uint64_t gcr_read(void *opaque, hwaddr addr, unsigned size)
+{
+    RISCVGCRState *gcr =3D (RISCVGCRState *) opaque;
+
+    switch (addr) {
+    /* Global Control Block Register */
+    case GCR_CONFIG_OFS:
+        /* Set PCORES to 0 */
+        return 0;
+    case GCR_BASE_OFS:
+        return gcr->gcr_base;
+    case GCR_REV_OFS:
+        return gcr->gcr_rev;
+    case GCR_CPC_STATUS_OFS:
+        return is_cpc_connected(gcr);
+    case GCR_L2_CONFIG_OFS:
+        /* L2 BYPASS */
+        return GCR_L2_CONFIG_BYPASS_MSK;
+    default:
+        qemu_log_mask(LOG_UNIMP, "Read %d bytes at GCR offset 0x%" HWADDR_=
PRIx
+                      "\n", size, addr);
+        return 0;
+    }
+    return 0;
+}
+
+static inline target_ulong get_exception_base(RISCVGCRVPState *vps)
+{
+    return vps->reset_base & GCR_CL_RESET_BASE_RESETBASE_MSK;
+}
+
+/* Write GCR registers */
+static void gcr_write(void *opaque, hwaddr addr, uint64_t data, unsigned s=
ize)
+{
+    RISCVGCRState *gcr =3D (RISCVGCRState *)opaque;
+    RISCVGCRVPState *current_vps;
+    int cpu_index, c, h;
+
+    for (c =3D 0; c < gcr->num_core; c++) {
+        for (h =3D 0; h < gcr->num_hart; h++) {
+            if (addr =3D=3D RISCV_CLCB_OFS + c * 0x100 + h * 8) {
+                cpu_index =3D c * gcr->num_hart + h;
+                current_vps =3D &gcr->vps[cpu_index];
+                current_vps->reset_base =3D data & GCR_CL_RESET_BASE_MSK;
+                cpu_set_exception_base(cpu_index + gcr->cluster_id *
+                                       gcr->num_core * gcr->num_hart,
+                                       get_exception_base(current_vps));
+                return;
+            }
+        }
+    }
+
+    switch (addr) {
+    case GCR_BASE_OFS:
+        update_gcr_base(gcr, data);
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "Write %d bytes at GCR offset 0x%" HWADDR=
_PRIx
+                      " 0x%" PRIx64 "\n", size, addr, data);
+        break;
+    }
+}
+
+static const MemoryRegionOps gcr_ops =3D {
+    .read =3D gcr_read,
+    .write =3D gcr_write,
+    .endianness =3D DEVICE_NATIVE_ENDIAN,
+    .impl =3D {
+        .max_access_size =3D 8,
+    },
+};
+
+static void riscv_gcr_init(Object *obj)
+{
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
+    RISCVGCRState *s =3D RISCV_GCR(obj);
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &gcr_ops, s,
+                          "riscv-gcr", GCR_ADDRSPACE_SZ);
+    sysbus_init_mmio(sbd, &s->iomem);
+}
+
+static void riscv_gcr_reset(DeviceState *dev)
+{
+    RISCVGCRState *s =3D RISCV_GCR(dev);
+    int i;
+
+    /* Update cpc_base to gcr_base + 0x8001 to enable cpc automatically. *=
/
+    update_cpc_base(s, s->gcr_base + 0x8001);
+
+    for (i =3D 0; i < s->num_vps; i++) {
+        s->vps[i].reset_base =3D CM_RESET_VEC & GCR_CL_RESET_BASE_MSK;
+        cpu_set_exception_base(i, get_exception_base(&s->vps[i]));
+    }
+}
+
+static const VMStateDescription vmstate_riscv_gcr =3D {
+    .name =3D "riscv-gcr",
+    .version_id =3D 0,
+    .minimum_version_id =3D 0,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT64(cpc_base, RISCVGCRState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static const Property riscv_gcr_properties[] =3D {
+    DEFINE_PROP_UINT32("cluster-id", RISCVGCRState, cluster_id, 0),
+    DEFINE_PROP_UINT32("num-vp", RISCVGCRState, num_vps, 1),
+    DEFINE_PROP_UINT32("num-hart", RISCVGCRState, num_hart, 1),
+    DEFINE_PROP_UINT32("num-core", RISCVGCRState, num_core, 1),
+    DEFINE_PROP_INT32("gcr-rev", RISCVGCRState, gcr_rev, 0xa00),
+    DEFINE_PROP_UINT64("gcr-base", RISCVGCRState, gcr_base, GCR_BASE_ADDR)=
,
+    DEFINE_PROP_LINK("cpc", RISCVGCRState, cpc_mr, TYPE_MEMORY_REGION,
+                     MemoryRegion *),
+};
+
+static void riscv_gcr_realize(DeviceState *dev, Error **errp)
+{
+    RISCVGCRState *s =3D RISCV_GCR(dev);
+
+    /* Create local set of registers for each VP */
+    s->vps =3D g_new(RISCVGCRVPState, s->num_vps);
+}
+
+static void riscv_gcr_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    device_class_set_props(dc, riscv_gcr_properties);
+    dc->vmsd =3D &vmstate_riscv_gcr;
+    device_class_set_legacy_reset(dc, riscv_gcr_reset);
+    dc->realize =3D riscv_gcr_realize;
+}
+
+static const TypeInfo riscv_gcr_info =3D {
+    .name          =3D TYPE_RISCV_GCR,
+    .parent        =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(RISCVGCRState),
+    .instance_init =3D riscv_gcr_init,
+    .class_init    =3D riscv_gcr_class_init,
+};
+
+static void riscv_gcr_register_types(void)
+{
+    type_register_static(&riscv_gcr_info);
+}
+
+type_init(riscv_gcr_register_types)
diff --git a/hw/misc/riscv_cpc.c b/hw/misc/riscv_cpc.c
new file mode 100644
index 0000000000..0d89de95f2
--- /dev/null
+++ b/hw/misc/riscv_cpc.c
@@ -0,0 +1,225 @@
+/*
+ * Cluster Power Controller emulation
+ *
+ * Copyright (c) 2016 Imagination Technologies
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licens=
es/>.
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
+#include "hw/sysbus.h"
+#include "migration/vmstate.h"
+
+#include "hw/misc/riscv_cpc.h"
+#include "hw/qdev-properties.h"
+#include "hw/intc/riscv_aclint.h"
+
+static inline uint64_t cpc_vp_run_mask(RISCVCPCState *cpc)
+{
+    if (cpc->num_vp =3D=3D 64) {
+        return 0xffffffffffffffff;
+    }
+    return (1ULL << cpc->num_vp) - 1;
+}
+
+static void riscv_cpu_reset_async_work(CPUState *cs, run_on_cpu_data data)
+{
+    RISCVCPCState *cpc =3D (RISCVCPCState *) data.host_ptr;
+
+    cpu_reset(cs);
+    cs->halted =3D 0;
+    cpc->vp_running |=3D 1ULL << cs->cpu_index;
+}
+
+static void cpc_run_vp(RISCVCPCState *cpc, uint64_t vp_run)
+{
+    CPUState *cs =3D first_cpu;
+
+    CPU_FOREACH(cs) {
+        uint64_t i =3D 1ULL << cs->cpu_index;
+        if (i & vp_run & ~cpc->vp_running) {
+            /*
+             * To avoid racing with a CPU we are just kicking off.
+             * We do the final bit of preparation for the work in
+             * the target CPUs context.
+             */
+            async_safe_run_on_cpu(cs, riscv_cpu_reset_async_work,
+                                  RUN_ON_CPU_HOST_PTR(cpc));
+        }
+    }
+}
+
+static void cpc_stop_vp(RISCVCPCState *cpc, uint64_t vp_stop)
+{
+    CPUState *cs =3D first_cpu;
+
+    CPU_FOREACH(cs) {
+        uint64_t i =3D 1ULL << cs->cpu_index;
+        if (i & vp_stop & cpc->vp_running) {
+            cpu_interrupt(cs, CPU_INTERRUPT_HALT);
+            cpc->vp_running &=3D ~i;
+        }
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
+        if (offset =3D=3D CPC_CL_BASE_OFS + CPC_VP_RUN_OFS + c * 0x100) {
+            cpc_run_vp(s, (data << cpu_index) & cpc_vp_run_mask(s));
+            return;
+        }
+        if (offset =3D=3D CPC_CL_BASE_OFS + CPC_VP_STOP_OFS + c * 0x100) {
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
+        if (offset =3D=3D CPC_CL_BASE_OFS + CPC_STAT_CONF_OFS + c * 0x100)=
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
+    .endianness =3D DEVICE_NATIVE_ENDIAN,
+    .impl =3D {
+        .max_access_size =3D 8,
+    },
+};
+
+static void riscv_cpc_init(Object *obj)
+{
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
+    RISCVCPCState *s =3D RISCV_CPC(obj);
+
+    memory_region_init_io(&s->mr, OBJECT(s), &cpc_ops, s, "riscv-cpc",
+                          CPC_ADDRSPACE_SZ);
+    sysbus_init_mmio(sbd, &s->mr);
+}
+
+static void riscv_cpc_realize(DeviceState *dev, Error **errp)
+{
+    RISCVCPCState *s =3D RISCV_CPC(dev);
+
+    if (s->vp_start_running > cpc_vp_run_mask(s)) {
+        error_setg(errp,
+                   "incorrect vp_start_running 0x%" PRIx64 " for num_vp =
=3D %d",
+                   s->vp_running, s->num_vp);
+        return;
+    }
+}
+
+static void riscv_cpc_reset(DeviceState *dev)
+{
+    RISCVCPCState *s =3D RISCV_CPC(dev);
+
+    /* Reflect the fact that all VPs are halted on reset */
+    s->vp_running =3D 0;
+
+    /* Put selected VPs into run state */
+    cpc_run_vp(s, s->vp_start_running);
+}
+
+static const VMStateDescription vmstate_riscv_cpc =3D {
+    .name =3D "riscv-cpc",
+    .version_id =3D 0,
+    .minimum_version_id =3D 0,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT64(vp_running, RISCVCPCState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static const Property riscv_cpc_properties[] =3D {
+    DEFINE_PROP_UINT32("cluster-id", RISCVCPCState, cluster_id, 0x0),
+    DEFINE_PROP_UINT32("num-vp", RISCVCPCState, num_vp, 0x1),
+    DEFINE_PROP_UINT32("num-hart", RISCVCPCState, num_hart, 0x1),
+    DEFINE_PROP_UINT32("num-core", RISCVCPCState, num_core, 0x1),
+    DEFINE_PROP_UINT64("vp-start-running", RISCVCPCState, vp_start_running=
, 0x1),
+};
+
+static void riscv_cpc_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->realize =3D riscv_cpc_realize;
+    device_class_set_legacy_reset(dc, riscv_cpc_reset);
+    dc->vmsd =3D &vmstate_riscv_cpc;
+    device_class_set_props(dc, riscv_cpc_properties);
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
diff --git a/include/hw/misc/riscv_cmgcr.h b/include/hw/misc/riscv_cmgcr.h
new file mode 100644
index 0000000000..c2c07fa0a6
--- /dev/null
+++ b/include/hw/misc/riscv_cmgcr.h
@@ -0,0 +1,77 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Pub=
lic
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2015 Imagination Technologies
+ *
+ * Copyright (C) 2025 MIPS
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#ifndef RISCV_CMGCR_H
+#define RISCV_CMGCR_H
+
+#include "hw/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RISCV_GCR "riscv-gcr"
+OBJECT_DECLARE_SIMPLE_TYPE(RISCVGCRState, RISCV_GCR)
+
+#define GCR_BASE_ADDR           0x1fb80000ULL
+#define GCR_ADDRSPACE_SZ        0x8000
+
+/* Offsets to register blocks */
+#define RISCV_GCB_OFS        0x0000 /* Global Control Block */
+#define RISCV_CLCB_OFS       0x2000 /* Core Control Block */
+
+/* Global Control Block Register Map */
+#define GCR_CONFIG_OFS      0x0000
+#define GCR_BASE_OFS        0x0008
+#define GCR_REV_OFS         0x0030
+#define GCR_CPC_STATUS_OFS  0x00F0
+#define GCR_L2_CONFIG_OFS   0x0130
+
+/* GCR_L2_CONFIG register fields */
+#define GCR_L2_CONFIG_BYPASS_SHF    20
+#define GCR_L2_CONFIG_BYPASS_MSK    ((0x1ULL) << GCR_L2_CONFIG_BYPASS_SHF)
+
+/* GCR_BASE register fields */
+#define GCR_BASE_GCRBASE_MSK     0xffffffff8000ULL
+
+/* GCR_CPC_BASE register fields */
+#define GCR_CPC_BASE_CPCEN_MSK   1
+#define GCR_CPC_BASE_CPCBASE_MSK 0xFFFFFFFF8000ULL
+#define GCR_CPC_BASE_MSK (GCR_CPC_BASE_CPCEN_MSK | GCR_CPC_BASE_CPCBASE_MS=
K)
+
+/* GCR_CL_RESETBASE_OFS register fields */
+#define GCR_CL_RESET_BASE_RESETBASE_MSK 0xFFFFFFFFFFFFF000U
+#define GCR_CL_RESET_BASE_MSK GCR_CL_RESET_BASE_RESETBASE_MSK
+
+typedef struct RISCVGCRVPState RISCVGCRVPState;
+struct RISCVGCRVPState {
+    uint64_t reset_base;
+};
+
+typedef struct RISCVGCRState RISCVGCRState;
+struct RISCVGCRState {
+    SysBusDevice parent_obj;
+
+    int32_t gcr_rev;
+    uint32_t cluster_id;
+    uint32_t num_vps;
+    uint32_t num_hart;
+    uint32_t num_core;
+    hwaddr gcr_base;
+    MemoryRegion iomem;
+    MemoryRegion *cpc_mr;
+
+    uint64_t cpc_base;
+
+    /* VP Local/Other Registers */
+    RISCVGCRVPState *vps;
+};
+
+#endif /* RISCV_CMGCR_H */
diff --git a/include/hw/misc/riscv_cpc.h b/include/hw/misc/riscv_cpc.h
new file mode 100644
index 0000000000..36d20c8f20
--- /dev/null
+++ b/include/hw/misc/riscv_cpc.h
@@ -0,0 +1,69 @@
+/*
+ * Cluster Power Controller emulation
+ *
+ * Copyright (c) 2016 Imagination Technologies
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licens=
es/>.
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
+#define TYPE_RISCV_CPC "riscv-cpc"
+OBJECT_DECLARE_SIMPLE_TYPE(RISCVCPCState, RISCV_CPC)
+
+typedef struct RISCVCPCState {
+    SysBusDevice parent_obj;
+
+    uint32_t cluster_id;
+    uint32_t num_vp;
+    uint32_t num_hart;
+    uint32_t num_core;
+    uint64_t vp_start_running; /* VPs running from restart */
+
+    MemoryRegion mr;
+    uint64_t vp_running; /* Indicates which VPs are in the run state */
+} RISCVCPCState;
+
+#endif /* RISCV_CPC_H */
--=20
2.34.1

