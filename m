Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA9C8F46C54
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 15:54:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9mHr-000247-5w; Mon, 06 Apr 2026 11:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w9mHp-00023p-UQ; Mon, 06 Apr 2026 11:54:50 -0400
Received: from mail-francecentralazon11023134.outbound.protection.outlook.com
 ([40.107.162.134] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w9mHo-0003KG-Hy; Mon, 06 Apr 2026 11:54:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FpRJcFC/MvyVHbfJ5P0eLpJRt1+kMTh5XqJC2oOQHyjejtC2+Zt2BfX/sMcmEG1MF7SA5kGTGml84QEof+UlAvvIf2E6OOsI4eSc5kPS3olQL8WVR+KjA4gYtelRqEGFwfoFMHvp57QbJ36Dtq89eQgVtrpiVVZS1+XQpYPhskaR32meaivy6Z/5UQadeWpD1ZdSwdhItwncNAWPLaXNCYlT+AcHt9s3PhGZrO1CJjjM1a9DYCy/A1TBfhIkC6pwhb6oAXaUHAfObozRogoXB7pZVoS8bD1mtERdJgaVC/Ae0AFBd0Jvp5N3TkT+nL588/NQyuK654JwJdD6ctuwFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ecCfSg8uDGE4ujf8sKSBImdcxzfMnPxIU4Dlw7Q9APE=;
 b=aijSgETzPyZTxdbQzh6g6wZhD7NLRe89ENYgiF2e+cxlgQOvxQxfweH7H1Mv3pnt/t3vkyDB/VV7VAx0JKrJ9CoL7VIo7ZPZoSR/S+Ioasg168SgE9Rrt1p6Ayiy4rT5+bP/j3mUTfxEiUd3CUuxYG/w+8E4KnyParqp+YZkIu/BIsM/VHKR1lAdRDXPAuoWjs6r1BtIv26RKfRPXG+L7Gc1myYNEQylAK9G82gSAz69Lq0ex+hnjOOmocL314jyqldO9xuXyYHXuo7XfjomYIAoCB9RjHKq6uv7E6AiXlQ8pF4PNDig+G7Zsx2tjt1999xAkUHj1sCdci3niWWjFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ecCfSg8uDGE4ujf8sKSBImdcxzfMnPxIU4Dlw7Q9APE=;
 b=KM8xcibsfNW65ZvkuXj8JU19YERLzGf90qoQ5w4FM/M2/Z30imBMjstAr2jli+JxNdcGOYDLL0CYhE7O8njhc77lZmi7geDH64+ZQPcf0+BqpLdFXGp2Co4ryNstemMHk6y5pq4FJhGts3c7bo937cA3yV9h2cEDirKT02KzrC1lrAHHW5sBEylKwgJ+7lRCzgoccf7+VonCSd9iZ8wlB2v650tb0LsglfuneD9mK+3aY7EB+2tDKVYh9MNEmzVgbSY3Q7zRniEr+TV/uO7Y5k9ig8qzy2EeCRswdMwwXr0a4mP7iUEjFZmrIwMePtCbsr8IetiTC/hzw9FROYNhpg==
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com (2603:10a6:150:358::6)
 by VI1PR09MB6903.eurprd09.prod.outlook.com (2603:10a6:800:1e2::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Mon, 6 Apr
 2026 15:49:42 +0000
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63]) by GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63%3]) with mapi id 15.20.9769.014; Mon, 6 Apr 2026
 15:49:42 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v6 3/7] target/riscv: Set endianness MSTATUS bits at CPU reset
Thread-Topic: [PATCH v6 3/7] target/riscv: Set endianness MSTATUS bits at CPU
 reset
Thread-Index: AQHcxdz7egpNESDMekSh2U2baJ4koQ==
Date: Mon, 6 Apr 2026 15:49:41 +0000
Message-ID: <20260406154935.144674-4-djordje.todorovic@htecgroup.com>
References: <20260406154935.144674-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260406154935.144674-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR09MB8755:EE_|VI1PR09MB6903:EE_
x-ms-office365-filtering-correlation-id: 88733c24-2174-433b-161a-08de93f41e8d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|38070700021|22082099003|56012099003;
x-microsoft-antispam-message-info: kTJz8PrZJqnm7fJd15RtOKe/uPlaiVJbZi7SDi1PATbDDAWYGuQHl9JHIK2/gxLtNNLbcUPV3DuuWEyD5vdKl/IvYXimvANCkbvI/Bz/mEqw138UCNAv61atprZrh99ycVxNlHSUucqAqpYY0Uojn+HWwClAktbn+LMJFafQP+Qcj1XmxGPhtjOXwPVFmVsaAb+vHQG83uVX/TuNEkkxjEMLnaV2mAYbZqMx9aoiHS1/SfPAwMNvBEM+wgYlw8s9Cmy1+ymkhmPhFKWdvPdkx14HMmf1sZqS6ImhHo2gUoV8hmkjjcXyqMSMEt7OIVnK2tBTR+EblIOr/g4BAldgd3f6LDO8EqLVk6AaRnmmbBjLabOUmOf2IUfEZCExtfD57FF3ZH7hLYjH6+zxYQvC3w4Z6LRw84hf+39WmyLNNrCCzYdHXYXEYKN2PReoaQ5mnuk5o9lRtzCifZ74gISV24cMpUP3TlaOVeqAfLul0bSw9o5wF2//dNqWjVcYeluUjAy9N6T4WvGkngNStccwPNzUNlU3m1sxhUrNngrA/KUdS/3raPdXRwn+HsFL/nsX9x3YNjbKVQZw3Nj8jMmMlVZ7YU/JG3Xl3Ci7XOpVCr9/bdLJ6KEEQDesoq/g4Avaic+na/E9ZClaQFiB3FPBvz+eYNM048lnuUBK9CdErSmSJvlg5QTdMaq4lAU+FiSCj801TT7wzjqHaJKHeVSCRw4YrPnpT+V/fB52E3vYSp+eeHT04Ss8KwkoGE9QiWpzEitUmg2A0TIxNDAQ0c4opD6CQjlliJLw+6z7i/KoW1k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR09MB8755.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(38070700021)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?owvX0tC52T9mkcXnlDcQqIbQ4oL2uQcRhrGeTVfD4fsJc8PzZK2KUnl7Iv?=
 =?iso-8859-1?Q?GC3/Suj+WqlG9gBPhwKbRLrQjZiXifLzpx0bMAEeVLxC1/o5HqVHhOCJg2?=
 =?iso-8859-1?Q?tMBH0S8CcOeRp9or4MaarpziGy7A4jmEIkXOe2dA36DZsi8FccSPwsvlUt?=
 =?iso-8859-1?Q?PffhBaT4DEIVQ5WQo7ge4YP+vDNTNyKaKEiXgyJk03DHz9zeZh12kTUAvM?=
 =?iso-8859-1?Q?6dlwEJKoo8dofLxs+7PQxlHskBQxzypgIXmWVRA4ixBzKrzGEKcBNUQNHx?=
 =?iso-8859-1?Q?/MWwKwHA98NljjOV0p44N72/M8WZFXRsJosYaril8HMV/VcYhd4FIXO6mi?=
 =?iso-8859-1?Q?SxT46KwaLHAdSRMxGW6okxux70m5t5HRPgW6R6xTEUnl9f2UptZGPLjhlp?=
 =?iso-8859-1?Q?rhJgzmCdKzzGgexFQwZ04DID40kFeOYcEmJfDYuBC85YaXD5Rr4wH/ExNR?=
 =?iso-8859-1?Q?6e1o133NmNJAKDxWRFYQkvAEGn26qz0U8xm0XufF2pvQlugDUGWkT2CN5j?=
 =?iso-8859-1?Q?3EFTU0yVD8YvLxTCyIengJd4Lf4o1fTf+ZcYmL5y+EKdI6hqcf5y4d+mO6?=
 =?iso-8859-1?Q?JE2aZXHzThjfy2yBYVOiMJdbg3aOTCVAAK9SpFnIGs1PSNibLqUaW6WURl?=
 =?iso-8859-1?Q?DzwQRLi6vuCjWo29WrrfB3Yqr4hjPFEzANaTNDCvhN1ynr9MrFNYsXn2S9?=
 =?iso-8859-1?Q?IEXShrbniI8cwTOMxZlvav6Ne1ByQYsKkCIAjTMa8lT6KdxBSPRhmeJ7LY?=
 =?iso-8859-1?Q?HS/OdwH74MkZU1EswtFEWr9iqdepiuapvFOAVYhSYDRtrJMp3AAhtr64D0?=
 =?iso-8859-1?Q?52/3d1ZeJZPRx0TlJdZXN6qP3N8PZwsE9+z7kuYQYdYp7Iww5H5Teqpxl2?=
 =?iso-8859-1?Q?IFS8YhIfVgGRT2ASWyIFD8G0d2vVVymiDuoNnK4Oa7elmeRS0LXduuUM9R?=
 =?iso-8859-1?Q?tG9xaxz7xzkA97Er0dj5fj8DcQQrmzoHgAQ4t1qd//58QOkkPbwZrnj7Yj?=
 =?iso-8859-1?Q?1cKlX7kEzAnHtlo0+UzaGVL5qbWF8pkq4YumRdKBLCA55Fh4pw9weJfliS?=
 =?iso-8859-1?Q?9cECUqSKWglfOw+pdZvC7VKAYdFkKXYZkfl+HWtFnHs+bG8hhYOsxbiBm5?=
 =?iso-8859-1?Q?R0iSDyDBXmSZNXWRLbkkiuhHoSBADZyRdBYQkZmuDGqqsvvRkEQAKb21gj?=
 =?iso-8859-1?Q?k/SR8dYMwxcb5TJEqEtyWuTdwiiGK34E908+tE2umefhwooxmM1cKj9g+D?=
 =?iso-8859-1?Q?MPT5GAJ9yF53sFffteYgohul0b/Wr6qiQtOg7OxtU8DgwwQjh6O19Ui9aj?=
 =?iso-8859-1?Q?4G9nrnGocOZTa2RVp21M76JVo0lQlChTCJmCws/m1o8bOpzRIh+xjNzz0E?=
 =?iso-8859-1?Q?MuUVw04zoKi2xrpRYW286Pz2dYvjNhXd+iUH7hAD1lF6x8mcpTFPkkpWSN?=
 =?iso-8859-1?Q?OLJRXUW5W48D6SsrZ1FG6tpodv546t6IKI1yQIu4/AMDTNDj/IwPte7xFn?=
 =?iso-8859-1?Q?xDgU3eSMMEPR9NqtJEWpXUyyCmYRKxZt44wcURK0a+kumpbMrIGB4OWFam?=
 =?iso-8859-1?Q?VjaxT93e/nM+DTVS8tzuH8ZiVOs/OZQVW7WOowTTNWetUgJve7XkJ0+7fv?=
 =?iso-8859-1?Q?myjmwcCuKZFzmYXm+JEJeAV4Mezojw2kQR1cvXrsZfXM8UJJ7fMv6slivq?=
 =?iso-8859-1?Q?LS4ek7fV35j2obL+crUpDaKAqOQv4nnE24OQQbhEkVF2AIY6QdPz2BotEv?=
 =?iso-8859-1?Q?3KgrldNCGSOg4vTyysYujzWJu9sgNsfFsPANt9eoNaG0fHGuxa1pmCBbFr?=
 =?iso-8859-1?Q?q4X/bfxXX6021TyjwdrYehnsX9oFvz3LLnD/EmC7v6FXHx4BHGAG?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR09MB8755.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88733c24-2174-433b-161a-08de93f41e8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2026 15:49:41.9852 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kDfRlLp4choGXGv7sh04yGk3M41nL+UwHCjUCjW1ULrOM50DC5w6JBrroEe2sZsM7iqye2ccyNwJRRTwB3IH6fmRf0mnXvDNWyPAc0TOMM0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR09MB6903
Received-SPF: pass client-ip=40.107.162.134;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

When the big-endian CPU property is enabled, set the MSTATUS_UBE
(User Big-Endian), MSTATUS_SBE (Supervisor Big-Endian), and
MSTATUS_MBE (Machine Big-Endian) bits during CPU reset.

This configures all privilege levels for big-endian data access,
matching the RISC-V privileged specification's endianness control
mechanism. Instructions remain little-endian regardless.

Also update the disassembler comment to clarify that
BFD_ENDIAN_LITTLE is correct because RISC-V instructions are
always little-endian per the ISA specification.

Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 target/riscv/cpu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 4537305dfe..eed5afd27e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -716,6 +716,9 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType=
 type)
             env->mstatus =3D set_field(env->mstatus, MSTATUS_MDT, 1);
         }
     }
+    if (cpu->cfg.big_endian) {
+        env->mstatus |=3D MSTATUS_UBE | MSTATUS_SBE | MSTATUS_MBE;
+    }
     env->mcause =3D 0;
     env->miclaim =3D MIP_SGEIP;
     env->pc =3D env->resetvec;
@@ -803,11 +806,8 @@ static void riscv_cpu_disas_set_info(const CPUState *s=
, disassemble_info *info)
     info->target_info =3D &cpu->cfg;
=20
     /*
-     * A couple of bits in MSTATUS set the endianness:
-     *  - MSTATUS_UBE (User-mode),
-     *  - MSTATUS_SBE (Supervisor-mode),
-     *  - MSTATUS_MBE (Machine-mode)
-     * but we don't implement that yet.
+     * RISC-V instructions are always little-endian, regardless of the
+     * data endianness configured via MSTATUS UBE/SBE/MBE bits.
      */
     info->endian =3D BFD_ENDIAN_LITTLE;
=20
--=20
2.34.1

