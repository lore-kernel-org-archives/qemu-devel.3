Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F32B8CCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 10:51:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4dJ3-0003hi-1M; Fri, 03 Oct 2025 06:46:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v4dIz-0003fn-UL; Fri, 03 Oct 2025 06:46:29 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v4dIv-0007QF-Ra; Fri, 03 Oct 2025 06:46:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rjb/H/cBoEsrXIGUVykb5CzoAkb/K7ULYIwgkwxVvD9+aCOIZNeEtiqb/1TXp24s1ksMaQLadCoroQYhPKCB35OuKvZRfK+TX2DUpqlNjFpMG+7rDjMu1pkxTTVPP9g37DlVXsSWPgmTJGNFxBSm8BFaFRJF0qN37g634YeDp/7lCsO27VvsOmdCevBo/LyWSUErYrQLza9d1Vd3H0/JkJVovlJP6o18MeNQfNGlf9CeyeTRm3cIgAglbYokyYKDTvhjito74PEmmtszD1D8uF9/BeWekbO/GqWNQm8c2W4O7Gld0MHwMYhk0Mso1gaZ2BlKEXzbp+FyjXTJwUduEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1uJ1nZcMszuOEYS2dgtFT0UIQ3DHUQLHvvIi5VaMoM=;
 b=JxIlX4c9WkCmJE7OdXICMoO+85y473LluFcRwoNUltFsWNzPUjR8bmUhJqXxRPYawg+FXLjaCoI6YIE9ZWg1NMVpT5f8hnl8F+A01tZvhJOyBBFfjSmov+srxAQ8+H2Xq/O6r/dTpmFlEGCWCxcGDQ5DX/+ACdOYASyCzQzfG6uWf42/km8R2TjLn8hyrVEL9/SZQ5mJXGTKwpcNLArs2+NURh6n1w4+ncM2VJV3S/A0XIh0OHOmAgjZRB44v15vfzLOuozqTBz6jqMhMAwUJ9kYCDBOjGS0YhpgaPNOf2mSXrGG7649VdFbUotKmc5o5HAlUdgkg5+zP8BrCY6Jkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1uJ1nZcMszuOEYS2dgtFT0UIQ3DHUQLHvvIi5VaMoM=;
 b=UMMA6WAKexPcXCScMKp3akEoYpdJVOhq9b3jYBAMbB2RDm7nD4ZjwXi+ZjqSr9lysBP1l3yAVwhXEf4XCW0+dFcsWHQqvUhyR9mnSJo4NBe9qpKTpaW0bdT61V5WxtfktgCm5ACBryPBHOT3S4HWx6TCxpm3BpPbafXaYgQQN8T/DjooEmU5Jq8FX/q9t4vMc0Wim68+j6FZyK5KCFtZisTvHDUb624RqzxmOenumXTX4NoDK7nxnBxxJGDuuAlA2c2FTqDuFdKGbOsYHZ9DzsreTqzxJ9QGCU0LiY31Mmke0FSQ/Sj/RSWYtoVbCJxjJi9QY8EPuLtujNncvT26oQ==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by DU7PR09MB7941.eurprd09.prod.outlook.com (2603:10a6:10:5b1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Fri, 3 Oct
 2025 10:45:25 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9160.017; Fri, 3 Oct 2025
 10:45:23 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v10 10/13] hw/riscv: Add support for RISCV CPS
Thread-Topic: [PATCH v10 10/13] hw/riscv: Add support for RISCV CPS
Thread-Index: AQHcNFLSQ/xsfWhVYk+dha+IcjVSLQ==
Date: Fri, 3 Oct 2025 10:45:23 +0000
Message-ID: <20251003104443.51501-11-djordje.todorovic@htecgroup.com>
References: <20251003104443.51501-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251003104443.51501-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|DU7PR09MB7941:EE_
x-ms-office365-filtering-correlation-id: f023e99a-982d-491b-3f36-08de0269f4ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?6cUHSUH9w1EhcqDjurAwJkbu/ZI9QZZHut1eQWY7ageEJAb2SpOo6vjV9d?=
 =?iso-8859-1?Q?7GJFbhWysjzIdM2DvLLQ1JsRd2d42ka5K6Zia6cdYYON9aLlZd0wGCAOrV?=
 =?iso-8859-1?Q?a2GOzHdgl1blS71Gp0eDDV628LgKlCTRX72wcAzyxSl4qqZBdISWk/My21?=
 =?iso-8859-1?Q?P2PGd2KXlZbYAd8hZaC5NJbq9G7bXELfC6Xkq0N9YLmj5FjgFhGNrjE+yJ?=
 =?iso-8859-1?Q?TEOvdJnlSfMky31qOJP4qzIHjU5xtXIlKhD/c7Jo3YJMfF7LXQJRwcAN+j?=
 =?iso-8859-1?Q?rTNHt2s159BMbCKzTBkEEttEQGK9lE04WCt/emqcrcpZH2nWkB+khy3F3C?=
 =?iso-8859-1?Q?szRC4prNnHNqlZkLKw06OaJr0rYjVfhXGZtgIHHbyfj71hoGnp9uVXmDJT?=
 =?iso-8859-1?Q?pF6GBDJPqsjmecf95JvWtqMwG59mGeXlsjg4YQlAL+6JEamZ4FFmjBBsUW?=
 =?iso-8859-1?Q?tbUTbhDxUtqdaCK6eTsiRk/sZAixj4dlI6Lp5tkdYYPn1SYGC1q2um7DNX?=
 =?iso-8859-1?Q?dpS9YWNL6ja9h5ZvKHMEC/gvnOHHUcfyzy7E7/8KO+kwLrfFJAwkTCWWCL?=
 =?iso-8859-1?Q?fqeNoWNQqh49nKd5T0/9LVbaexY+MO0Sio+qZK9GGiwfQYp5t6WtKbAGuK?=
 =?iso-8859-1?Q?vhBpWYZlVIfHgrHZ26v8FBA935tS7CduGQie+v7K4tzLxDX+Eakk9hpAcZ?=
 =?iso-8859-1?Q?Ub1R4JNK+88+YhKTP+csWqM7t1jstV7RlT/tY4rVzWlEs3Gd33U/eV4CTK?=
 =?iso-8859-1?Q?ZnBNPG9m+zUy8BKTleUAvwojbeIvi/fANjx3SXJlwx1+xb1GsgCyVPchl3?=
 =?iso-8859-1?Q?GVinfeashItKfeF/2Z1BrwrbS0a1eC9bcLBveA20ArHMRfm9BI4MB8ORqc?=
 =?iso-8859-1?Q?ig55KuM9cUG7detr7j0zJWgg/6FELZerVUkT4tg78Vz5ihRuaW2uSTHpbX?=
 =?iso-8859-1?Q?GZ6hGl/z6Xy5J5gcJxgxrVrP+XNkCzohMmakmGQ0wXH8aR8j0hXPrRllIf?=
 =?iso-8859-1?Q?vC8NTVXs4RroMhTsu3mvRwEH2N0poFVQH+ebZvHvcFyOtaKaH5eqcc+nXE?=
 =?iso-8859-1?Q?TlFQCK4Z7Dw5CXCrZGHiCCWX7GYOzSamrGN+j20gCGn1wprCBWshjxAU6j?=
 =?iso-8859-1?Q?2P6hfkv8DNp0t9+dEbyV7wPZg9Nn02ftnk2df8FvcDFNLk4FJwk8CQmQWw?=
 =?iso-8859-1?Q?2/qZS2a5pkDOsAy7mxOSoELdTWjX1yggFR1RKLMDKy/fzA+Z15XkQKDNhb?=
 =?iso-8859-1?Q?DYYSsPtl615yKbOcw45hrBsrSj+a9I9O5Mk1shJNHt1HbfT2fK/MgY2FrH?=
 =?iso-8859-1?Q?CqqwcfKEEj6obLx0fQcKmef6iJiH3AIcASwmpru2HqCgfD/Aem3snz1Xef?=
 =?iso-8859-1?Q?Kz4eXNg8M3IG26A0aQSWRQoYXT/yjbd1ImezcvNsjcLduWO/wdlHPX2f4T?=
 =?iso-8859-1?Q?TvnWCBiia1Whta2k8zocgFZwSH/xikyrpcaHdeKghVmvVcAFOs4d20561Y?=
 =?iso-8859-1?Q?lDH8HHjCBUlt6kIxB/DYE+qtg6OrSn0k9N0sMgfOfTXg69/rmYvbL3FHCs?=
 =?iso-8859-1?Q?ssktVbi4aS0kTetOEzQyPeURNuBG?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?PyuO3KNXQTfmAd6rSlhAGnWuwfgeP8isJlievixNOgbjcEEXCTLDWSrkKc?=
 =?iso-8859-1?Q?raUD+k17jzQx+mZcZ4HOjiLVVaz8UXIltKJWbFmJYA+7QMUP7BIMAuq57F?=
 =?iso-8859-1?Q?KmGVxzc9/0T3Td+qoUkxbVlV+8Wf8TqkHbVDGFqRBsIVyG2dZhaE5U5OUN?=
 =?iso-8859-1?Q?zgvVgEN44rS1cJu9aHSCt78uo06M5qWPsptOp4ntE7hLEYHmLy22cJROou?=
 =?iso-8859-1?Q?jbYf5Ov5LWfxwfNm+lYCgeLm1Ee2iWp+y4i6XOyGiaGUB+0Q+L4J4KFOUa?=
 =?iso-8859-1?Q?ktfe3LxkxBx7MFxnTZOCysxgBJmsYLA4a9LyD0HcXarxhTLGu63DBbpmZv?=
 =?iso-8859-1?Q?plqDc6uVO/u3RLl6dDh7MZ+mdzwl9N5XUFEinjKYI4feDc1NLVt+2yagSd?=
 =?iso-8859-1?Q?Kq7dDkBv0BzX5fbPVD8S+AA/xFiQTXlxMwNNrtXQYQAdFJKYT5/rrErxaW?=
 =?iso-8859-1?Q?O795Ns1yyE60nV0MWUD5xgRDxRKTxY54Z4QWEj6SyolypU4R/1D6tiC55A?=
 =?iso-8859-1?Q?5koeEn6egGf4PYZNTN/KbLR2oOjfzFuR64wGD9aQ6pucw6m52VHFk6ffw3?=
 =?iso-8859-1?Q?WGq9GxKsDZ7c+be53+Civ6AU+vi/hBrrE5amWecBo/JHAH3x5h43EUdHwo?=
 =?iso-8859-1?Q?a/J3bfDW4/G/F9sSeKQF3MKriZ97v2/5uS6CxJ382G1sIMRP2xEeozGMwL?=
 =?iso-8859-1?Q?HGA7bsH9XvvQYGsyk9xpPbeOC6o/pK3wDtr+/kumPlKNNj9KEq1OgUmrIM?=
 =?iso-8859-1?Q?qQ+comJQeAUPl31Tqwrtl2J9ESfYfSEYUQQy8uw0Zff/lXQMJq6mTr/QTG?=
 =?iso-8859-1?Q?nobPwx9a9rs12OyCwW+cpzKv9pBeZh+6sK60b+kwcI4xwPN4w63soba8i7?=
 =?iso-8859-1?Q?mFtAcUYqvtVK8ZfezF4ewQ6peSPjxQSzCj59wpzO1V29wx4KNxpN3N7Bdm?=
 =?iso-8859-1?Q?5/CKAnbR0Ngwxpt4vS1HYnST1+iMPXJdXhiM7rynNnqTP+oPF5ypDUWM6d?=
 =?iso-8859-1?Q?XzNaQv94/R8U7hgMmlFSr6JVIKv4KcfKcsvkl+MfmpIjaJpuOOOyoy6r8D?=
 =?iso-8859-1?Q?I56v1Fn5p8qJp/Mt2CRbFQY937x0bT1+2e6me3ZemuGsZ9VeEzmgfJOKXf?=
 =?iso-8859-1?Q?Aycz6sdtGVa2Ab/v8DLp8Ywt8L45psEFFZ0s30K5Sko6+RFk09xvNIbL1H?=
 =?iso-8859-1?Q?wV3+3i0lXnQjlx/6JKMXve1Zi/ykt0DQagaF+LihGfwI9IBlt6obqk3/Ju?=
 =?iso-8859-1?Q?XBZKBETlm+YKnZp/cI0EULrAfwyquJ8buaiMgdg5Hrk7tzeGECqfCpvr8q?=
 =?iso-8859-1?Q?bMTPBSUSOKmN/e6ZuSAbGklBpKN1uP0XTS1aZmgyvd0q+l3oGGeL1WVurm?=
 =?iso-8859-1?Q?IsPpnTckHFsSPYo5wq1VRm//evw13/+uVsuCCR9xDgbImiIi+GfDodQZ/H?=
 =?iso-8859-1?Q?K+LPpWWVSfIV807dvDoJZrAjEN/LTVNF3Rk0dzPTlv5pR9yitkE3NAlbHb?=
 =?iso-8859-1?Q?q2PNCoromdJFVsBm0kQJSH42a8bEoCOE0Zs91GaUx9gglBRK11HJyMHRz2?=
 =?iso-8859-1?Q?TIo9Iu5/xdqmelvT7+FWIpUzTQFWIkr844NM5YNbfKAFPAG4wwjvdWINzI?=
 =?iso-8859-1?Q?C6stiAuhS/t6TUw2InE/4RZx/b/bvngbUi/WAhza6YdAkiGZ+4BDLJg1bA?=
 =?iso-8859-1?Q?LTm0b6E6Ql/6468hWHA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f023e99a-982d-491b-3f36-08de0269f4ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2025 10:45:23.2212 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UftcHYub/CzcB1bOg8zNOS2JYtAORnEnDyC7AZLn9kXqd55dfdZO0ih8j6UoDdjBNUDpdjBHVXa64ORupjH4Mo6+Z+AxLAh4jhonuPb/fXA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PR09MB7941
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

