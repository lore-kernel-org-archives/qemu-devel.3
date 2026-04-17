Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB6EF436B5
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 14:51:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDkVg-00050i-N0; Fri, 17 Apr 2026 10:49:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wDkVf-0004xn-6s; Fri, 17 Apr 2026 10:49:31 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wDkVd-0007Cr-Ln; Fri, 17 Apr 2026 10:49:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vrQkFSjvjsggftRWXfPIaCIdo2mWn7VbkYzUtoQ4QCOg0IcYhZBk9gCBdGL/N/ZRcWGZN9AQXV7AsSucwMUCNVtHe9JYf/KDibidL/vVfT63hfOKrKCUaV9ulvXw7ZrtRmCEWz+jF9qSVi4XKETY+usZ0vvIp4wTa2+SPanzpCXf++RGkI9A7TGm7KwyqXEaAfR1cEqe90e2AFDJjwM1ZQ7nxJ3B/KCxdQG5afQfZefh/GXm566zMEHPCbjgZh1w7JAcyb/09VxrYjqO8ZMWDYCY5GTJhDy3w6fXje75TAhgsCNrq5lwi83ptlfCyAe9K8G8k5K6ySCRWuvN4VW7Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7ubkiNH/UUxmYLQ7QxP2Sgn26ElHUYn7ZCVgELn/Oc=;
 b=wMvDpE6HxpUrlgYsdQ3qQb5KKs1A6JBX6RAzH8fEOwW3olNAICeoJkY20lGL1Yges6RAkfGddDE6Sue9B6dj0p4EOvMkwPw4Y9KFEd9iiDQfZVNxrgAQINr0rygNyV5I2UzRJNBwpSQO01aCj1V5blPQVfLCEI6vgtlOkwxVvNVQuo3j8km7vylXrsFoHZtoCRRQPUoFRl+sO2b5M1oLG8m3e/Yd4FsQhMeYsCj7Emx7SdHpRuAmzAwv+OrC24nhZ9n/q0mp0RQSRessITrZiol6TmP41JdHCnzUO4aMlSdgI5txGjEWLInfDPLGjKw+3ptg7Y+8KMv19LTXqLC9PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7ubkiNH/UUxmYLQ7QxP2Sgn26ElHUYn7ZCVgELn/Oc=;
 b=YqEBwtRXnIpVu71/t7ZvogpEJwi6ngaP98HjnRDeI2r7x0xxVikc+vJJrObfmxudpc0N8zRGJkjE9XF76I8pHUpGs8ye5hEwlwU1e0gGGFKLgPIaTOuaphu3S0MtRlE1UbCm8WLilMgQCyO+B0P0sFcApQSzVp2Y9zOUXWJP9L7AlBxeFY8ganS+Mwwn2cALYJci3u4MrJy8jlJLgwd9ZyfrlUsuXMVl8nmRyXpimjWhxMEyyPaZNbijU5Gr60Qk7w4z9dzvB8D8VUj0EuTFW4ejnzKTzxflQQUoQS23+s5zB94wzLNzXBqJSCRCg7dmkn75ZjdeaV+9HBkblJiP+Q==
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com (2603:10a6:102:412::6)
 by VI0PR09MB8150.eurprd09.prod.outlook.com (2603:10a6:800:2ad::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 14:49:15 +0000
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442]) by PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 14:49:15 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v8 6/7] target/riscv: Expose big-endian CPU property and add
 documentation
Thread-Topic: [PATCH v8 6/7] target/riscv: Expose big-endian CPU property and
 add documentation
Thread-Index: AQHcznlb7yxvFc4/DUezruphM71TPw==
Date: Fri, 17 Apr 2026 14:49:14 +0000
Message-ID: <20260417144905.178056-7-djordje.todorovic@htecgroup.com>
References: <20260417144905.178056-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260417144905.178056-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA2PR09MB7634:EE_|VI0PR09MB8150:EE_
x-ms-office365-filtering-correlation-id: 6111a502-7f0b-4da7-c590-08de9c907ee1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: N2XwqC1HmQNyJ7PUIRizzPpfsm4+yl2cu45MeP/Lgg6hEI4NY14gYgniJMmgUr458ll6fq78qGkhB83eRhi6hnhXa/iEpdOawwsaYW2pAqL44BY0eCFzVjlR2bTMe2zHoz0FFuyK6TCISG3M7e5lM00P1Eq8+y8/Nqu2/S2LpFyCSXpfO0GR3zU708cSmtjEVUjv99CwfUoTzQl+1mRuLwRiLaY+F4zNJTfVuy9fR7BAuTEQASu3FM07AVqcM8aAjnoRqHw3fYiamTwSLD9OprXxm5GXXQj8PiS9EpFCd4IJQZe5DhTBqpFwisQSaVE96Uviw1VItclmBea6b7pll5ex267C7dnQJqg+jpQO1ZMDSl/ieY3pdnwBo28Xi4gu1yGgsvWhyuBnZj0qMZNkbsA8PGaCs3hPLM7Yb/uTSiNadx5ZRSYoMPi0yOgJ63QSe/4YbcqjpEZat4BXyDd6HaBotREGa48CyD4RAQxvqFz7dOWlZKL2l18PBKxmTemvvxiEjMUeEhtdQX/0dGwWD9ClWpNoxNMZF1JdTaoHDWED/zGJ+ulAhm7N80xu/4HzbXqC3bNo4C8zHVT5cZlJ2MgM9LfurH6UBY5mqFzEcDGfz6SjTuqaT0ZVMkpPib9oO35TRT0U73/j4HeqMfMdAgCEiRVNH2ElzMViY+iL+ZUAAz5TiFWdWzYScyzwA360givfDSRj38+PLdFT9nA4nkyY/oqQf88OIjEfh9A1csTKFzGO345eDQa46IYA0JisAtDfKmNMVSXHY/W7PowTlyHB3eqRHet38rHkd7Eo0/I=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA2PR09MB7634.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qF9hg8viuANRc13yPmJirKkH01+5BVwbGEa6bRcSRFt4jE4DVjXIhME7pi?=
 =?iso-8859-1?Q?MI3TWVNVDVUrI8yh9luIrLV3PjE/VJs9IrTE4KXvQE8qoxFU+KC4q6sCTo?=
 =?iso-8859-1?Q?SoBxmRBnfy6+tr4Uf4DayIJDeTPW98l++DSxyok+rb67oPw3xbB3+gI7Bx?=
 =?iso-8859-1?Q?n3rocGIzV7lngs6FIx+oKMy8LvfvlDZmdoBUvUyUd47zt222frMgye9WD4?=
 =?iso-8859-1?Q?qi+a0bMvThfLXtKfTmWbsVh8hnQbNorehz3N3tbNTwXFjTg9kG1IE2hdbk?=
 =?iso-8859-1?Q?5z/H1h8pY56BGG8WY1Iyo00dKyhvVJTMgAy5Am55rKLxKqElfiUobqe/SN?=
 =?iso-8859-1?Q?A0gZg8jNaR5x5BpNiLbbBkLrTF7XJ+ldtWxvfQ53p0R71TUDi/R+ygRwC5?=
 =?iso-8859-1?Q?t/9RxrWEE7fvj/sNL5lQ/uokTL9A/t3OBG/ViKwmww/1mWL59m2IxSe5DI?=
 =?iso-8859-1?Q?tk/ei6adLu+zTfr7jduBaCHFbHuH+aXAzYlDp4rvWiYkyV6uKabruHbXRZ?=
 =?iso-8859-1?Q?YR13Q1R7+WP+ReKnMOV/6ynPDq0HYVXnidRZauQIYNBK6EtB1ahMxMs6VY?=
 =?iso-8859-1?Q?VpSdrx8WBDIRTPD9iXiOX1WZ721Q8A7ExRlNzHASphbIJ1oj/zvITzVNtu?=
 =?iso-8859-1?Q?PBhzK8rQ0IJLVWRLiJHbJnBf9Y4laf522StANPjhxw2nZFoj7xWaFj/rPF?=
 =?iso-8859-1?Q?rjhQLzN0jxv6NDcg1QcGcqM7YaHGUg1JsA6VOnUM+pLB0QM9ZL8okFaKdI?=
 =?iso-8859-1?Q?ZaRefWncdkLmMlmitYP9MpWhaO+M32aYO9admv5A8D+C1pg05pwbo6jybt?=
 =?iso-8859-1?Q?anlgAtlZ9YSHbm8oCqXpmVJNjCY/nvQAjLjRpLcmNGCLWYeYZWxv3oeDZZ?=
 =?iso-8859-1?Q?Tv8rRnhsUaIOuEiQz+c9B9MHb8sqEVPsHhZIFshoMi+EuoaP9lH9dSyQEe?=
 =?iso-8859-1?Q?reGyEDLOP2/oDemUYAuNvXKj69yPKNzu+U1PaKdgxlQhAH1NOY/nkyNRGt?=
 =?iso-8859-1?Q?qKVlyVFtzToLnjnXyfCw16GUtEwQbLB6S6Ly2hF2CcOibf9CoXL6+liYfb?=
 =?iso-8859-1?Q?fjGI6Hbhos+1W24pCw+F4Tw1iT1L7nk2WEIwsNiIEmgN4kTosRb+5gWttN?=
 =?iso-8859-1?Q?2UUYa+q+8I06yAfW6ZLB956tfsEUI+NzVvCdoPSigE0dMKESfF3wjPcIgj?=
 =?iso-8859-1?Q?AL2JuSxOK3GPNcaGmOTAy6HC1zkA+iBle48EdnD8AtQriHcVRkpMubKnz+?=
 =?iso-8859-1?Q?cLSQddnVfIbjx6giUyu7TRnsmkhXPueFvoq09DzzRyJ+ho5055RVPoa7MP?=
 =?iso-8859-1?Q?eEx4GA04CAlyZHAzgVhor9HVmmqvU5IZ7CY7EEkaHllQXsN9EuzT/QuDlH?=
 =?iso-8859-1?Q?hkE65KXBSbaQj17K889wGKTx8AbBH/yPEEBvmBqbg6oEkSJCRVB+2pccG0?=
 =?iso-8859-1?Q?b/GklMpm7yagrz3aGG7fSJWESIl/u1IJ/f1bfs4zFACt61upeAIDpGFJ4c?=
 =?iso-8859-1?Q?VCWqC/phy94hCWaupscuJPmd9eZiKH63CWQovgAWyuCdEqJLpTuPd6xnja?=
 =?iso-8859-1?Q?ZrZov3UvNYsLxRPgEUzuOZILiR+15xEvU4KXrp/v3WqzWqik60toNm1vwM?=
 =?iso-8859-1?Q?BX8jBpSIkeVp8hDqZTqJ1hPoyqBHid5ErDli1a2OAyFSnWynmVjVWnrjHD?=
 =?iso-8859-1?Q?9udiKiooQ7Kq1C1Tho7fbh5RCEB2A4XZecSFf4np9VdC/3vbxRfMCYWkeN?=
 =?iso-8859-1?Q?iuhspCwWwQdcfuqCUYAPpER9FcYUt1yuChYfrtb0KrRTVwGOy6ADeTHgTa?=
 =?iso-8859-1?Q?nMHdbI3ZleaBC0UnRKOIdu076ArVv2lnyhWgVZr4UFgv4gwA1hBr?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA2PR09MB7634.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6111a502-7f0b-4da7-c590-08de9c907ee1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 14:49:14.2392 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 31AtWI7lzrI4H1pUIGXzTQ2Xbsm1a1tfueTsO01aXCSYOPzkL/c83iU9F/5QBhGkpLjy1GWcNsi2pJ0eAtyla8dMLvGm7kjmUI2tNczaNmA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR09MB8150
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
index a32e4fd6d6..c39500cb3f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2641,6 +2641,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rule=
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

