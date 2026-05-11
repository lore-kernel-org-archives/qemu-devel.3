Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE327CD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 09:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMN92-0002fk-1b; Mon, 11 May 2026 05:41:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wMN82-00024U-RW; Mon, 11 May 2026 05:40:48 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wMN80-0001R4-GG; Mon, 11 May 2026 05:40:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uQagcscvnVKJFZheMOCTIKPDOh8pg5uAiQ2X+q0hHX0dkNK/DJD1qLz/zfy3DYHR6bB9TdtVS4m4bBBhh1NPWauKm4LMEysR/rqIBMRPaFk31bQld1tLo62XIMAZ9ujJUNeXgU4iYbDU9eKR1itxQ+qiUlauxVLEt+FncjPKS/ALzIKikTJmxiNmv8K8LtZoDWXXOyvAnndGUzwLfKIR8wyDF/eyHf0HGHxSuPGQ0JCr4wFxh4Wc0qAswlc3qrfBvlnNN0H/+lgvbWWH6Rphf+YsjyoMIvoCO/9BvqE2kfnzbV5k+kFiLhIvOegt97K6eEW6ZjG6Y59H/fjcvZlzsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZg8D90wK0PAzQ0/I2lP+WzQ34f54PN5ewMramnY3vo=;
 b=Nb8vvr2TBNmopViJ9z7XWEs8GuEXV1nX+UD+a/74AIq5L/s226hPjVTV3Ekr/b9fOjvh1SPsnWZnNX9DDlbDjXmhd3eCR/5o/TQCQAZ3wUxSPdMye/sl39soAERGDICAPh0vE/f/jbWWQ8GTTdP72ZFsfQ1JkdRFGzgKvodIWhdrIaKpBSlhN78wl8V0v7JMDyazUuPv0XgsjwI81MHgTn8zo+rVK0oaJ+/t55l2E2TNcLIYl8PYWLH27QQySsVJ3zbEB/6tvU5Yql2010jMws26gE74k8SAsTWyem6X4bYNx7QwI3lKqkstzzBLRJjjZhZ59AutxeJ1zZUeGrz6Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZg8D90wK0PAzQ0/I2lP+WzQ34f54PN5ewMramnY3vo=;
 b=IrOqeJ+u6ezovLre6V3XpDk9IiznU3EzxG4yWVtw/7yoswKtZgJ0I/kWsW8+yFBFQiMI2RW9FTJL9muDxBpofee7KkNY6mauLUIO2gbvmfHfXclABBBPnjEXVi6EKHRIYvSMdokK7bH98LpStz2Dr8eM8bJOnRggGjcnBYna7xoXVPurt/5N1ixMPM7Kt5IZcG76ruERiumxfzEl+A/Xn3ry+I+FiFZc4lggHtvZmKfaaHsfpPi1HG/Ip77xJfuPS/EZ1zaqOn/oLBXaNE98EZ52Fpy/gPNYwDaWjT4SxjtydXnIE8FBYbSsDv04KaM07flz3Vbc3ojKirC3ObIiwQ==
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com (2603:10a6:102:412::6)
 by DB5PR09MB8695.eurprd09.prod.outlook.com (2603:10a6:10:64a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Mon, 11 May
 2026 08:38:31 +0000
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442]) by PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 08:38:31 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v9 6/7] target/riscv: Expose big-endian CPU property and add
 documentation
Thread-Topic: [PATCH v9 6/7] target/riscv: Expose big-endian CPU property and
 add documentation
Thread-Index: AQHc4SGK6m5EzLpZZkmRXit4jII5EQ==
Date: Mon, 11 May 2026 08:38:29 +0000
Message-ID: <20260511083819.206216-7-djordje.todorovic@htecgroup.com>
References: <20260511083819.206216-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260511083819.206216-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA2PR09MB7634:EE_|DB5PR09MB8695:EE_
x-ms-office365-filtering-correlation-id: 1272d9c0-35d7-4df1-8436-08deaf38ae7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|3023799003|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: Mq6HKWqrZofWDoV2YbPJ4vGAP9XGCy3+Z6eECF3hcVtkCA4wfgbxEAURY8yKT2bE1eIpFKNvbq4qg3HVHnpX4PlOX7apV3MdTC6onh7WMs0Ep19MpcWSLsE4Dxl8JgLE+l3jaYCgIKBdb644tnXCsBerDx0NuKu0WYb1xA3uUgorbQ9K9RSHS+vw/Qas9vGB1nJ7YzHkmKr6rBr1CL1h+CTqcohvny5xaqt+YCKv3q1cAFMwlsq5aKPBIBmgoGcb3as8tWrPs93JoVHyYZrI37TjnaO4C24oJmgDPl5veVkIF1/EGr1EVguzkI96pGPVPg70p22DPu9cvsqBNQ9/hC2KJQV0hdHWqB5LTHhOOiK+HXpYvAg2cBfiRSfYT3X/RrdRb2REOr/ilEwQ4Fcj0oPpuaj4GaYioGwqecK9oq5XJ4/nrA7piS77R122D8G9aLIxIhBQjg2c1dKLDVYnyuQY4wWA0a8JpAjRXyZcmoI4O9Vp36GJM1Q23Zyg/5hEbd41tbVD7n2IhdsAWdGrqATvLLRFyY4/CoCZUDnC9QAGR9IyX7eQ3R3ebFhqwygueWcl0S8Bb/ZiAQ5DhiFRv3fr34/MCIhqIH3F/4uYN3V7Y2XA3sjAAJQkLNLvXQDR8AXFgR1M71+KPrWWWPL55tO4NU5Cx/DEvMmz90y4jRDcKeJpOgBsFyr0mhKSX4HdUXJ+9DXrSLhf0eFH/TkiYRlc9nswYcU7vhzKBH7fzJ+ZZV6FS+6AeAzH+nKAfxt3
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA2PR09MB7634.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(3023799003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZNFGFY8gg1wGwb9wssBxrewEP4o3jw6OZJydj7zNdJy562iaYEB1BCjGlu?=
 =?iso-8859-1?Q?UAwspPdeOHY8XUe0R02Cq4iCBkiNykVv+q3mvJ1SE8HmJql5j4WAuzyP4R?=
 =?iso-8859-1?Q?ixgs/06j2d3/2ysb5gfVyQwOOvjXgAfpHq6BuCidclMVJ5fm0/vpzJkJ69?=
 =?iso-8859-1?Q?C+n8LGInfKaApfNffMbm9FOhvZwbFYY8qdLKEQK375I9DsRcRxMnso8nof?=
 =?iso-8859-1?Q?fE1JXcrwE/9AZMDnkMwocc3/lttoW8ZRzq5zvL7z2i+iQ/vJEvD7Z7hdRg?=
 =?iso-8859-1?Q?DsxvbJE2At0iqdtvt5WH4DDD+lTSM9zdM5BVcTg3bhl3B/ItS3EzJKuiF6?=
 =?iso-8859-1?Q?nEzibJMAAPMHh46LmPiCTafW0dFicSBIki2pbY5rirztsMLpOAw5FJrmNJ?=
 =?iso-8859-1?Q?bT0JkDxj8q/i3K7WG25otoQ0MOokaJoUnfRmKr7lsgdaOPNTtVN4M/NeYb?=
 =?iso-8859-1?Q?PJfTuTs0wbaQyGxRuj6tQ60vxmCYUUXYI50b/glVTPAtiQ4iwa7F9HT/sc?=
 =?iso-8859-1?Q?vHbWqdl8VyJR5JQ7sdT1KOxD5QctZbVEHmQLfpocejXCmbwCzUZUynvx7p?=
 =?iso-8859-1?Q?GrOTVflKur5xNkUn8EquwQJ0w4UuI5NyCPCQlqPzQ0cnC2myzlS5/db0B7?=
 =?iso-8859-1?Q?T881PBIaTct1GiZgf79z1zXd+qgRU69Fl5FhVa2XBnBUoRKI1PdOhzY2Og?=
 =?iso-8859-1?Q?jEgc3nY+ZI9qbp+xrJvABZTXLzYCSZNBKaspMS9VEH9QrRMgCHehDSWK1q?=
 =?iso-8859-1?Q?L48XZjlXPiKS4FIQGwxclcgw82Xhxr+Fl8lC5MuFOdQOB0Yn83t5YT6zL3?=
 =?iso-8859-1?Q?MwSJeL7KlQfKXEKTOUueEKUwcGYjWbb88iuvQvnn0klsG0PeP48ApPq85t?=
 =?iso-8859-1?Q?IlJBqQa0CnXtd7JCbDtKYRPufbS7kusOD9NLWib45hurJ7JO+Lf7UODsfY?=
 =?iso-8859-1?Q?LPLfDpKtonlWVCrR8n2nKQqS0G3U5XX7zxeALmAYPqs8m+UrPb72/FP+mQ?=
 =?iso-8859-1?Q?O/ip8WJxTviwnB7RikOuEV5GrDfD558KzMAnbJAbKNNcU8BSpM4yd6K3Ap?=
 =?iso-8859-1?Q?BAmONFvyEcOtMkkwn2SsO8yPrXVw4+CvbUEXS2AXndWruKNBMeu6b9WhTj?=
 =?iso-8859-1?Q?HDRyddLiCqwKsO9bXkIVKEhC6DtSPqBiTAtsC7ICqDaTVAqAIb7kmAk4YK?=
 =?iso-8859-1?Q?6Dol8+UpaTyp+aNELHFYKq0Ip2t7dRbWA6GxuUVBxQ/Kl/p4d9MuwBzDC+?=
 =?iso-8859-1?Q?nwlpYC6G3jIrhzIlVyGSL3qgABfRBaLm50h4Y1gXI1gs+1Zrn1zfzp00xr?=
 =?iso-8859-1?Q?WU3bq0iVJL1tSHxRTAuUyuaKe1hFsrEKkuur5Cfjq8jpbYW7koLwXoJ2Wt?=
 =?iso-8859-1?Q?84gSnkXnxhdFhKk1v/JVA6c7d+F4NR1vx+FyJAgJFY8RbJvbIjr/U+v4rV?=
 =?iso-8859-1?Q?CvSF9a3Rj4AZn9Uwp0HFm5YDh0rDhSxXQH0WXkb9O7ovHVU86Vd1iyHXms?=
 =?iso-8859-1?Q?4T8Ik1ZlcAC1ohSMKeaV8/6++5s4yt4+cjF1qDk1k/W+A7cPgLaSc8O8xI?=
 =?iso-8859-1?Q?oj1PQm6opBsNNxvvlKNL1sq1Yeza9Bwj3+p1+BLPoV78BD7QVzGFzj01TX?=
 =?iso-8859-1?Q?kjlxgolDnUn7+YyzOblkg8VH6ckSY/9IdHOnW7isu5j2oRTy33hyhxdaP/?=
 =?iso-8859-1?Q?HaVs/dfheuJEQSiNWUkzN2zf/etIiC8NYZ0dff8n+1Zw01vxF097kVcvzv?=
 =?iso-8859-1?Q?zt4if21NGB0hJiO6rj+AG1sskWHIMiRKWyyH4D+ly89uINQOa2AANFcH2o?=
 =?iso-8859-1?Q?HG5ZnjCIWBA/ai+oSUD74XlLZmKA/Gbk8D1Ad1dhYrhqgdCwz8xq?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA2PR09MB7634.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1272d9c0-35d7-4df1-8436-08deaf38ae7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 08:38:29.4814 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /xEsdAcdDJy3M8RoPu88I5jKN0TDY4YFoh8o2UAxehlBnB/GAGjFK4ZwttqjVXFM4UF2SFC2xiQBD5awthWtxCZpl4AysKd5fnuP+aYIqDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR09MB8695
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
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

Now that the full big-endian data path is in place (runtime MSTATUS
bits, boot code, and page-table walks), expose the "big-endian"
property to users via DEFINE_PROP_BOOL and document it in
docs/system/target-riscv.rst.

The property can be enabled from the command line, e.g.:

    -cpu <cpu>,big-endian=3Don

Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 docs/system/target-riscv.rst | 24 ++++++++++++++++++++++++
 target/riscv/cpu.c           |  1 +
 2 files changed, 25 insertions(+)

diff --git a/docs/system/target-riscv.rst b/docs/system/target-riscv.rst
index 3ad5d1ddaf..7798184ebe 100644
--- a/docs/system/target-riscv.rst
+++ b/docs/system/target-riscv.rst
@@ -95,3 +95,27 @@ the images they need.
 * ``-bios <file>``
=20
 Tells QEMU to load the specified file as the firmware.
+
+RISC-V CPU endianness
+---------------------
+
+The RISC-V ISA specifies that instruction fetches are always little-endian=
,
+while data accesses can be either little-endian or big-endian under contro=
l
+of the MSTATUS ``MBE``/``SBE``/``UBE`` bits (see section 3.1.6.5, "Memory
+Endianness", in the RISC-V Privileged Specification).
+
+QEMU implements the full data-endianness behaviour described by those bits=
.
+In addition, the RISC-V CPU object exposes a ``big-endian`` boolean proper=
ty
+which models a big-endian-only hardware implementation, where the
+``MBE``/``SBE``/``UBE`` bits are hardwired to 1. When the property is set,
+the CPU is reset with all three bits initialised to 1, so the guest starts
+executing in big-endian data mode from the reset vector. The property is a
+static, per-CPU hardware configuration option and is not meant to be toggl=
ed
+at runtime.
+
+The property can be enabled from the command line, for example::
+
+    -cpu <cpu>,big-endian=3Don
+
+No upstream CPU model currently defaults to big-endian; the property is
+provided so that big-endian-only RISC-V CPU variants can be modelled.
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ae75019186..f1fff92d4b 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2657,6 +2657,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rule=
s[] =3D {
=20
 static const Property riscv_cpu_properties[] =3D {
     DEFINE_PROP_BOOL("debug", RISCVCPU, cfg.debug, true),
+    DEFINE_PROP_BOOL("big-endian", RISCVCPU, cfg.big_endian, false),
=20
     {.name =3D "pmu-mask", .info =3D &prop_pmu_mask},
     {.name =3D "pmu-num", .info =3D &prop_pmu_num}, /* Deprecated */
--=20
2.34.1

