Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9254CCD195
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Oct 2025 15:46:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vA97k-00054K-Pa; Sat, 18 Oct 2025 11:45:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vA97i-00053L-Ic; Sat, 18 Oct 2025 11:45:38 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vA97g-0001QR-SU; Sat, 18 Oct 2025 11:45:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M69fwIJ/2TTPYW1RoM2RIeY8DrxtWk4a7PbZI+cxm/sfNdPeK2FvRYFVQZeFekG4o0PCuT7c+0ZhcgzLVvNCbvZVXu7b6wcov1WCgoTb+vcaWpDqVxaoznV4mJKIaCWN7ufNMMI9U1MaIYLVKQjyo1O5RBt1pPUmTwgqxakYuSxwgGsj0IyU1ReIObq/Iq5ww6RnpP4ikk/+XbMWyqeXgDhhj5lNpmIkxzG2V6bTDmVVJgEYBAqFNhA9kg6uUJ1UxCV9OybPclL0mXortRcLlxpVp6NAk31aLLyVFSzL4n30GxgkM34iQ0m6ycSKGmd5G2EvV3MgrKJXFKei/QT/Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4KBazVfEid2gaSPREfx/zq16YcEM1woDFNWp9mRo40=;
 b=EEkZedU89t0wTxJBNiB8UJujHOTBQXj2zJJguHegohS3MJ8c14rAdc3AhMC2/24r0k3glYBC2U8k7IJMnEv3DPsWJaIMC9pmUVsgQ5Be8aLGIpsF4DNPEzUlMhUFR9DCjxNxIxpjGOHeUxPlhGVyqTGoQBoG30l6kcC5U+IOBWvI1iPXdZSHSXalY4p2dz3x5FsHIgLbB4ryqO/3e98NuHkFaL9njvcfrbuoB7jRtMc4aGkcQ0rvXs7YXlJxvbJO1lyj3kWx7UGspkNgriBVL3S2/VuRqTbk0L7AJc0dp7EZn09kib/BAd1U7v9OC5drly5U54XDH9MT4HOz55d5/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4KBazVfEid2gaSPREfx/zq16YcEM1woDFNWp9mRo40=;
 b=Im0caYabnHVfs1cbIZvbtNQm8gWAbOWdKu3+7az756CRfxO2uFtRwllziqngizpM1yU8CvV5d/FpfZkmbaN931NX6couR4i0yiA6q8gkZbARC3UM1R8I9IHtw8eH0CeRtC1tVTOwf7WyoiWnx3r2Vowv4ZOgN9bPBge5HprvGLlKQRKOk4E1tjMFfarJfwiOTgTLadMNr92nfQOXv3g0e0aT7rBfCCw1DpupEGtvLVwTVJCA2Sm/rt1ixLuXtUwxxLegWpWZPBkAfpmwFyWXkz1gBaJyW7Ife1H4U2LjOxjuRtixB+KTXE6c+X8bq+O/FP8N5HxYMBIvhhAofS2Akg==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by DB8PR09MB4360.eurprd09.prod.outlook.com (2603:10a6:10:154::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Sat, 18 Oct
 2025 15:45:29 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9228.014; Sat, 18 Oct 2025
 15:45:29 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>, Alistair Francis
 <alistair.francis@wdc.com>
Subject: [PATCH v13 03/13] target/riscv: Add MIPS P8700 CPU
Thread-Topic: [PATCH v13 03/13] target/riscv: Add MIPS P8700 CPU
Thread-Index: AQHcQEY6DLh8r7v0MkewXYiPPi+bxQ==
Date: Sat, 18 Oct 2025 15:45:28 +0000
Message-ID: <20251018154522.745788-4-djordje.todorovic@htecgroup.com>
References: <20251018154522.745788-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251018154522.745788-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|DB8PR09MB4360:EE_
x-ms-office365-filtering-correlation-id: 5eb43c5b-61a4-4b95-34e7-08de0e5d5d31
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?31O9zh5dYQLSW6KN+UCaYMrH1JRf5RSh0YVjwt9YO7zPYY2zHv4EdwUzOb?=
 =?iso-8859-1?Q?RuGpA7CydpOpe1zbfp2vwJ2ibqE2we64SuURpNJbzhELvf6rY0r1aljBxu?=
 =?iso-8859-1?Q?/ffj8GFMJzBOxdK7khjhtzYSXxXdGN5g5S5xwykIpVWdMFl5Q0Md14hqi9?=
 =?iso-8859-1?Q?85ZmH/YB4z3rIAlggwSj8kZAGiIARirsW+pM1dhBEgTL5OpzDDs2EGvn9/?=
 =?iso-8859-1?Q?3+ai7b3+9yQzV2gX4afj++jLiMIdqYkLFvvNgna9ouSzjpM6GJZZw+qYHD?=
 =?iso-8859-1?Q?5ccybouPOvn1DRJcD+S4agG7ZtOybRIc74fN++aWFn86kWo63kOCcAZs/Q?=
 =?iso-8859-1?Q?tewWLE/LcJTq/lxRJfohYTcl/qReizZefDTJp82+MUKN/5KuQg+owLZY2v?=
 =?iso-8859-1?Q?VlGzFHQzzbxyUq88mZZxSpuhBu4+Btgz2m+zm6y3E7QfXniVVgHGMmo0y8?=
 =?iso-8859-1?Q?1e1NAtqjx9dmw2W/XD1mmXHw6m2q3PabvSuEFxt1tiEEFRfOk7NkW/TWOu?=
 =?iso-8859-1?Q?ZDHHFJlFISZ24e9lWtMsx0ZqzFCrli9ik6IEv1nHhAl5R2+tUFADhnaMUF?=
 =?iso-8859-1?Q?T02AC3OpZguttknGfHCYZw3xUvCNoJ1kFPv7sRuD9P8Yd/v4bY0qu6GZC7?=
 =?iso-8859-1?Q?4UdI8HDq2BbAFsUFuctqjegFwOCRi66Afc6E8bHuRo4BFWOkQk96pBPl22?=
 =?iso-8859-1?Q?dZzRAs740liNyEqrTSlKMH7QG+wc7vFr2nGfYuZFYNQfR+LEAhzyRFgmr5?=
 =?iso-8859-1?Q?MD/rjssvhypDFlIMJoUp/kh2qyKH8GKKnWrP6RmyIGHKCub5p8ZAuy6Xzf?=
 =?iso-8859-1?Q?rFPWNaFxx8ohkyaCis1ulI4D5Adg8Be/FmqFVn0W00lfQ/s0H2tm0C7Q+z?=
 =?iso-8859-1?Q?QqOz+5rzDZL6c/DbvEbMzrdS5W/EToy1uRChKC6gxDQpj8n5QNFuk7RzX6?=
 =?iso-8859-1?Q?E5vjVmG8ItUTssP/y/WEJALFMM1aJkF6XChX0yhHGfsTrTDLDR0oCTq7Py?=
 =?iso-8859-1?Q?omXiLT8/l6Py7J5LeDymR18Gay3yphtsAKHIdLs5R7Kfj+yBcoQwrF0p+i?=
 =?iso-8859-1?Q?w750HR6030uu1ISgG+8P9sfF7yIAV76SOycLheDnLNqbtN8pCVDa4HH5QA?=
 =?iso-8859-1?Q?zbPX+D9Eh2/DTk4vrbh6MwSR5nXakBKxfYwTsTszMcO2lartRP8CV/JFbd?=
 =?iso-8859-1?Q?gayBFwCXq3awIcRl4pus6hsTWuefM/xbM/YTNMKf1YzKDR+IW3VNjowZMp?=
 =?iso-8859-1?Q?gY504gZcB9OfkNIBwmqrAITJMSJOgveWUJrCoN9tO4oJMBrlHGjCgiwq2b?=
 =?iso-8859-1?Q?d+nyScDfWx4Gnrrvd7fP3OJZnFB8fkjTonez55K2yxCyQrBPd6MWQsjrY7?=
 =?iso-8859-1?Q?Fa8B+NuN+EKsz1SEAmT7+FHAPjQ1QmFt75/midQuHICC5ioKnu1nl4bDgR?=
 =?iso-8859-1?Q?FtCyhlmNkTUJhulK9mM3XaKNK2d0evGNzu126wAzZt0HFgy8fH3R20HFeP?=
 =?iso-8859-1?Q?F1gR+aVGtSzhndNXexPL2dMw270MRcEiqDcz8KExEBsDnJOLnoiH1e2U1/?=
 =?iso-8859-1?Q?Ct5iwTyBVAEtPNTrBzhyrQsxa8bK?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xyIX9tHwOdYk/4tQjHTe2I+EGu7DrEG35bk3bEHzqxCCwnV9P8Y1rhaOxT?=
 =?iso-8859-1?Q?89Ltx+Ot+dX9AOUZSVirHGRle/eCvvD6byb4Pjc7BaWCSLBW6oO4lS1ZVa?=
 =?iso-8859-1?Q?HaAN2MFk+C/iCIE2DKvPzw+rFSacP+8ZWdToNZb9/GH53rMklATqU+AtGc?=
 =?iso-8859-1?Q?JUsNb2LxQOqUYngzgiGLWqN3gWEC7iPJdBeOovtVtmyCZ8TsDv2pPrXa8K?=
 =?iso-8859-1?Q?SRv/+V9OXmvZP0axJRq24f4cq2gQeSWcp2UFpLVyzvR3FIuVxL9WR/f5yt?=
 =?iso-8859-1?Q?+HNbGoBlEvdUjyOTvWlMWu/ErsScT//YFNKxOLuWXqG7gojW6DcmCWkU7G?=
 =?iso-8859-1?Q?HDg/E5uKAJbrZsNGZ5KFz4O9PXBknchoR+cHUKnNUC3jwbGU9N8wkVZSuB?=
 =?iso-8859-1?Q?8Ux6uEPgd/G0HWUS9XrRoE5qo8TAus/JS/nNtAYvtz5QycFPWwY1UgkM1N?=
 =?iso-8859-1?Q?dyH3tI0djV54dkEnFrE3gRRzV8lPXeJIqrAVJEmr9CcqPzt9nEncvkXbO2?=
 =?iso-8859-1?Q?wKpgV+sMK+MRlU6LYAHBX3B6mxr7fCiVivuIt/IOMqVc3ikb9IUCyXyqNt?=
 =?iso-8859-1?Q?AtONSMxI8ncT9+tqpzDNTdMSTCgWZIaacWLZPqimdE5UNORsVxNvCbbXLW?=
 =?iso-8859-1?Q?Vd96yHtYpKxtE/PB4le1enoTqYHQ7jRlqJ4UJcYiImKN3jfpI++mhr3/PX?=
 =?iso-8859-1?Q?YsHi0lIMkNaIZklxCbSugFIeCeFuRVRtGac5dHeXgSTcQ9f3+J1bhSGrVV?=
 =?iso-8859-1?Q?CyBo86zIy/ioQXdOyWIoOX0kKWa6JhdR+FilZ04iSVLfF8XkJmiQeXz8ps?=
 =?iso-8859-1?Q?dY0dF0u0/ofeN6zLayvpRMAMWWAOj5gab05cbi2pwUUf74h11v2PrBofos?=
 =?iso-8859-1?Q?n6uOjXoE72ReRDT5dd0pQ2pX47uAPuyE2bxqyCQqK1eN+4FkqVvaENxMpB?=
 =?iso-8859-1?Q?Yr3Lwq4ugOOgR9ZGyC9Y/lKScWNqpXvPn4MjECyIN6/Mjt/RZN4LumzCsA?=
 =?iso-8859-1?Q?gPbx8/7yiSM4RMFPdpoO7QgNF002+DT2nrwZQXyuzT/tGxwN/ce4jyCzm3?=
 =?iso-8859-1?Q?QosfWlHYMbPVTpw18B6KAkVSnIDt4NDSUlqCwYsPYUeWi88drphCjOOA/y?=
 =?iso-8859-1?Q?JyKJUSdizYdO1CPnWUn3DzJ+rKsfi7JSOusZyvEzm8MR6DqrnrKEsM9PpM?=
 =?iso-8859-1?Q?XxTeDuaBRP8g7OGg4aLLQKwPG6A4ncSsLjMVbGzdJz+dr+PpTxAai3ohCe?=
 =?iso-8859-1?Q?be/lR2DLN29Bu+akRfQBLgm2GHth7pCdb3MT1rPmhKBwI4JGegS7/x7VfD?=
 =?iso-8859-1?Q?q37Dqpxkw5Z0TvWX5HusyNUGtEdSdGv0wGgezcHE286vBT68Bu/R3XipNf?=
 =?iso-8859-1?Q?mO0TvfVBbiGD3Hy8VUOjquvmVo9iYcAVHd9JLP6YO6rw7wnbpicjM+xtWz?=
 =?iso-8859-1?Q?OCiUzRc7FGqHGdWuav93MSE3q3b+LZLcx/ZUm/jlPU4tO51/JR159OXLwy?=
 =?iso-8859-1?Q?Ujs63idWwjmN94iWjRt9SfUdHxCYz3XPdoavOXhLWoSA5tuVgoaIvSspSX?=
 =?iso-8859-1?Q?YV+oJiFA8Tavk7fHgnly8trxpjlCt0TjnNX7wARVcOlyF8HlEzSWoaJGSy?=
 =?iso-8859-1?Q?EiPiAfMRLjOBTqCTqx8buk4MeyNZY+bE6PVYV6n1OSHUUBdKS0QJqzdYN6?=
 =?iso-8859-1?Q?AqRhyI43z5DWZI/9zKo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eb43c5b-61a4-4b95-34e7-08de0e5d5d31
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2025 15:45:28.9163 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m3nUIU48tIiPJ7uQ5S80QE7rNzALDo0jakUGod8GUfhyjDAIiRfP5+PzvX8O8DKIdZONykh2V3WpSddr/E2IoSSPX1cnMjIce6D9hkaWZ0Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR09MB4360
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

Introduce P8700 CPU by MIPS.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu-qom.h      |  1 +
 target/riscv/cpu.c          | 16 ++++++++++++++++
 target/riscv/cpu_vendorid.h |  1 +
 3 files changed, 18 insertions(+)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 75f4e43408..30dcdcfaae 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -56,6 +56,7 @@
 #define TYPE_RISCV_CPU_TT_ASCALON       RISCV_CPU_TYPE_NAME("tt-ascalon")
 #define TYPE_RISCV_CPU_XIANGSHAN_NANHU  RISCV_CPU_TYPE_NAME("xiangshan-nan=
hu")
 #define TYPE_RISCV_CPU_XIANGSHAN_KMH    RISCV_CPU_TYPE_NAME("xiangshan-kun=
minghu")
+#define TYPE_RISCV_CPU_MIPS_P8700       RISCV_CPU_TYPE_NAME("mips-p8700")
 #define TYPE_RISCV_CPU_HOST             RISCV_CPU_TYPE_NAME("host")
=20
 OBJECT_DECLARE_CPU_TYPE(RISCVCPU, RISCVCPUClass, RISCV_CPU)
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 7932ba6873..cd4e442bdb 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3283,6 +3283,22 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .cfg.max_satp_mode =3D VM_1_10_SV48,
     ),
=20
+    /* https://mips.com/products/hardware/p8700/ */
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_MIPS_P8700, TYPE_RISCV_VENDOR_CPU,
+        .misa_mxl_max =3D MXL_RV64,
+        .misa_ext =3D RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU,
+        .priv_spec =3D PRIV_VERSION_1_12_0,
+        .cfg.max_satp_mode =3D VM_1_10_SV48,
+        .cfg.ext_zifencei =3D true,
+        .cfg.ext_zicsr =3D true,
+        .cfg.mmu =3D true,
+        .cfg.pmp =3D true,
+        .cfg.ext_zba =3D true,
+        .cfg.ext_zbb =3D true,
+        .cfg.marchid =3D 0x8000000000000201,
+        .cfg.mvendorid =3D MIPS_VENDOR_ID,
+    ),
+
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
         .cfg.max_satp_mode =3D VM_1_10_SV57,
diff --git a/target/riscv/cpu_vendorid.h b/target/riscv/cpu_vendorid.h
index 96b6b9c2cb..28f0ce9370 100644
--- a/target/riscv/cpu_vendorid.h
+++ b/target/riscv/cpu_vendorid.h
@@ -2,6 +2,7 @@
 #define TARGET_RISCV_CPU_VENDORID_H
=20
 #define THEAD_VENDOR_ID         0x5b7
+#define MIPS_VENDOR_ID          0x722
=20
 #define VEYRON_V1_MARCHID       0x8000000000010000
 #define VEYRON_V1_MIMPID        0x111
--=20
2.34.1

