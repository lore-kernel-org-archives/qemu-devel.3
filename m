Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 347A9C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 09:55:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucLKb-00005k-2e; Thu, 17 Jul 2025 05:55:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ucL4v-0006U1-Lk; Thu, 17 Jul 2025 05:39:05 -0400
Received: from mail-westeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c201::5] helo=AS8PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ucL4t-0002Os-EX; Thu, 17 Jul 2025 05:39:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h/5+OuQu/PdBrX8qWscpE3GR+zWRwxIXNIgcphTsQwsR2dMTN1Z1k81EDK7/wDePeXqPJkfvqq/hyTQklmZBiwo+/xaAaZ3DkbfwYKYWulcp7MolZtxQ8DcAiRzQqmUsdo1GCrCg2u1ersSuy4kWfrUK4ZVf7GvJyvri2nNuI/Wh/svnKegj1ZgloE6QeUjj5X+aid0LlbJDgwlC1dgMjpOBVy2KGUpWR79hWfjZzBiG16AWd/aw1YwGkshCqabOg8Ppd2yf6zG4cfnjmR5KsKngeJFsXgEH5dxOKhoV32ITn7tJB7STuj9El0cBJEdoPB/kirG/KDIiCUUcwCpPzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WE8sEeMdTVnoYDKN9b+c8rZe3dX56qPLf7im5dHSW4k=;
 b=dn+Ur+LH3gTTP9vIbYodqgK1jg4dJj/6W7KNP8lsveaO8NQySMHkGpaGixrolSHDz8RDeSQpzXfE3PHciEbHgiEyJDY8zkvfvndGYCuOM+JsKGw0Gvd2RVl3+oKAgyN7YT2BAtTIILpBgo98EGw5gz+/5ckvjlaJolM851ftT5JqKX4SjPbPeqq9bW4b5HVHQidRL6Pm4W0qZEIfTzCJGP3YqaiZeiHRVkEityxMziAUnR029TJ+gj1m7K/fsZJnZjfyA/8xEXssdGXX2knrBu8iycVDO4NvbFLb4O/DbiuqV/hS9u/As/XlgTr+IDthpWmWM+TGJ+eo7IPwwm9Qig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WE8sEeMdTVnoYDKN9b+c8rZe3dX56qPLf7im5dHSW4k=;
 b=Xv9XfIOKvZpqNdHyoW2rMDCY+ENX2cldkeaN6XdKqNlgK6BsHkTHus01izM3hx7AC3P/D2MgiU/EFLmlTAe7yOeEquEohwi9OnlOezjXtl7yLGVw/CylQhGB/Mm8HPIfwnvDsXqCTHSuINOXpTlKFBtfYlOr0Qh977OjaPb43qyRboeiF5B23KcS82ehwRBxdmfc2zejowSB9ogc8zdwZfH89L5ss0SZvgHR3jsy2Z/IFTXIPb0C9RmhFRwu6uyh46aCpGGH6cENQnNh553ea+N6PXb9UJvTRzG8/7+EHB4141VJiPjshJRLGlprz3SAk/8L6hCDPBkRB7a4q3gfYw==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by VI1PR09MB4318.eurprd09.prod.outlook.com (2603:10a6:800:155::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 09:38:48 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%3]) with mapi id 15.20.8857.026; Thu, 17 Jul 2025
 09:38:47 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v6 07/14] target/riscv: Add Xmipslsp instructions
Thread-Topic: [PATCH v6 07/14] target/riscv: Add Xmipslsp instructions
Thread-Index: AQHb9v6W1kBgImncQkWlgy4s7uggmQ==
Date: Thu, 17 Jul 2025 09:38:44 +0000
Message-ID: <20250717093833.402237-8-djordje.todorovic@htecgroup.com>
References: <20250717093833.402237-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250717093833.402237-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|VI1PR09MB4318:EE_
x-ms-office365-filtering-correlation-id: 77985cac-542c-4825-5d14-08ddc515baea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?nM/1zAIX2gB2/UGd6etRnC7arpv1E/cy3VM1cT2tbXeJO1u9b/q5Ol74QJ?=
 =?iso-8859-1?Q?Vti3SQjImCvz1LkrRcHo/3Kvfl90PIUABl9y4ibX62oyIZk6H8L/LPbxMx?=
 =?iso-8859-1?Q?GwLStXjTFF4Qp1RxIQfP1xb0Apv8gtaDJQ1jeHwNWmfMHxGbmJED6kW446?=
 =?iso-8859-1?Q?sJKUxmDgfS6yAzrKLq+nIY7q9CKmXGDpYTgWdQzipi2rbec2Pr/Lozr/mS?=
 =?iso-8859-1?Q?XxNS4FItwqGgAjIwCXbgpypIaszK4BgxaxgNYKYZXOlyE++EqOcQtuAL5K?=
 =?iso-8859-1?Q?wQ5ykE9NzIn4R376y5SJ1uFRNrz46vCZ8D1DkcJU5yKQIEufVSpox0ov81?=
 =?iso-8859-1?Q?ZKehPhQUoGah1yG/hvA1CI1MX5/O55GzeTWEZV6RTFrxvJtuE/KGUzbubK?=
 =?iso-8859-1?Q?fS5DkYVhEN7bvwMYaEWSV3fl9K0TlF7J7wn+G77ENtEexgF114czAwT/75?=
 =?iso-8859-1?Q?0b9jkSPJBYKs65goe4LyqMiDGVyvYNHYB7y8F/NSzIJ7x77tQsSMRjSklp?=
 =?iso-8859-1?Q?3pqWbj/lsVMe3ySXL2h2K/KnvhFmJU/+UDwXwRfGYuQnF7FfEQBXS3+Yvi?=
 =?iso-8859-1?Q?tBSajFfTSdTlp07rTGDiZUd5W59kiCD/frqs1Jp5VuBL+29ZfctkV93mRu?=
 =?iso-8859-1?Q?LGkiPx8ivjggd5fmfzQDDoTJ+mdlcSioiP4h47KY93tUbL/MD6VdjnD/eO?=
 =?iso-8859-1?Q?fOzwywwWYH8bezIvPpAFVSpqADDbZBEGJ67/hW8K1mhu/UICf/WzbD4ftE?=
 =?iso-8859-1?Q?0qELQRgL6gWUWVeIQzFCyykbgK+KKX2ASx3wpOf9JkXGXw0VHrJ5LniyhG?=
 =?iso-8859-1?Q?jRZUvzhGxnT7zYFfDdACtBmZrg/0li47e45ZNqaJCfZydIVQUpfCAL8hnJ?=
 =?iso-8859-1?Q?9cr/h0KHhyS6cI2BBh8iImI6WWlKgrAmkdhqiigkcrt76T4S21bbgHTlAG?=
 =?iso-8859-1?Q?4jqZCvlb7YRfrH7GqA1gbENDZqM/ELuJYsUCeNRWhGdPwEHPis/IqAL/Nq?=
 =?iso-8859-1?Q?uhApRzp/S9kfkzwCrkuYvzCHDZg+3QvwXpoHIbfB2KSyi/yN/kC2gjrEZL?=
 =?iso-8859-1?Q?Ap56ZtacZA8bdgV3JmFp9XDiHzvXCo4wfOg4imTR1PW5rrl8ejcDtLxrwm?=
 =?iso-8859-1?Q?upYmaG7EvYyP67lBskNFPeF36ATRmNTIJl1+FkwSCWaD+MZbYL7VyeQSbQ?=
 =?iso-8859-1?Q?0AH0bkdkOe2XcB/NNnZikd94NzOSm7qPc9wfQpqpMzrhplPYUaAJv4ZtNK?=
 =?iso-8859-1?Q?/95pMTt8nJ2j82FyFUCGCnV2n31+6MeRsXGGqKbBomd/91A933Kr1gnV3a?=
 =?iso-8859-1?Q?rstGNsNp3JjelwUH1bfSgTFRkKdQG70luKvnQjqI2XRs7ktFrPG5e7/rtb?=
 =?iso-8859-1?Q?h4Cz0uKeEFX4+44GZgNeeuNg8aJIoFCtcUeTYrANazePjVm9AeoIV0nE4v?=
 =?iso-8859-1?Q?56C61t2HivW5Ax1a3qoPj9fObyUKCxWdaBTG4zHXzpk8+TSRtzRlIUMvIr?=
 =?iso-8859-1?Q?OE4RcsVkM3vZEkYhI/4S/E6HUFZvrmzGZjIUAK1LXngVagCnSOwkK0P97X?=
 =?iso-8859-1?Q?hrWvtgU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?QkfUSKidjgx1+Ga/3JUVA8NQ8vukbG4MxPU6PC3s45331X4RABiR5MXXJI?=
 =?iso-8859-1?Q?3GLKlwmXVBR/AfpWAyZHyJTkTRLd2b03wmMX/j2hoxxbDH8v7bUX00z0dS?=
 =?iso-8859-1?Q?hc6fOCXXu6NpYOYxA0C4paEO3UMv6qyC+shjMa91QvKcvLz0bTUqo5r4Xm?=
 =?iso-8859-1?Q?h4/8Uo3/YcCwnmTUvn5cvbqOG55dNxMzGhSJsdiv+Ij+rZUVITe1OpkSdB?=
 =?iso-8859-1?Q?kevKGjI55Haw2fM/PpVAXR+W/3N6SU1IfA0tjrFJTQFVfeSno8ri7jpP/w?=
 =?iso-8859-1?Q?ViWDZkW/cENDGs7xZ1C/NAVIYlzjdM0gk+LNIbjwQLJx36ax49WF84MEN4?=
 =?iso-8859-1?Q?XXf6r00fG3hvs7N5Hu7MXmBM1pt/wyu+SlhvZF6itxMa39yBeREHXF9jOa?=
 =?iso-8859-1?Q?jRAg78B/NLCneBehB98GXre/7vF32Z8lzaIWdHth6ojgavp2t0JXz1Iw6u?=
 =?iso-8859-1?Q?+EfepVb6vNxWYLbGMEuW6QHl7jSHGcKYxiP+PLc45PsFqQroszzYmIDFQR?=
 =?iso-8859-1?Q?UURM1s3pmT1A3ZpVJysdRKP7jINTTJxG4Gjjj6mZlpREdWam/v1veZYypr?=
 =?iso-8859-1?Q?717lAVFRZilRmVKJEjgPH/jhyl1q/x9XCXMyXvZYL0vbmwf3KEUBMIjl0V?=
 =?iso-8859-1?Q?3QyVi7udYMNMicHEVgAP+3Dlg9e1LINLFKYajRDOhW22IuFmo/vPS6Jy7N?=
 =?iso-8859-1?Q?padty2TCP7B8LDsiB3X3e5cJFW6fXCoCsKhhknAf7GDGVaZXZ0OTMoTR/R?=
 =?iso-8859-1?Q?WVybCfPgTq4m5BLrFryULCD0vyd7JqGoTN3NlXkdB7U8Q7xNN7n7P4Uv31?=
 =?iso-8859-1?Q?vHx6JTy6N6rwgtF6Llp5uXdJ4sosn7KD7g7++E3ZIYH7FAIck7X0Wu80iq?=
 =?iso-8859-1?Q?hZwRhScyl5x4dQZNp/9R2tWXzD3MLp5INJdpo7NvHeGTi9J25kj/liuj8/?=
 =?iso-8859-1?Q?qgiBEPGiak9m44fzV7lCgceEEyxY62l6xU73vSuBHA6mx4wV3fdbwD7Ajr?=
 =?iso-8859-1?Q?loiu8lrfwoR+xFdCxywLZdFArkme7UYXMSEI1Q17u4FOZM6Or72E26n+B6?=
 =?iso-8859-1?Q?QS4Hb3n5kw+nnZQOMW4dLf7tkSSq+PoUgEYYbQarL6gl2iC0fm6vrbFN24?=
 =?iso-8859-1?Q?ioLLniv/6yav2XIsm41d4EAanir8WtfET9pR0DR2ZaH7aqbQO7HANpuC0j?=
 =?iso-8859-1?Q?CxA2qusHQ3CzCwttYAWl9/scgTsEeLSgYgwdyRHLPJsxFqLoFdS7jjIGLm?=
 =?iso-8859-1?Q?O71aetIEXtsBE1RQC2Io5FVYrilaSkci/9Ag1JOx+PjN9PZCkz95Amx9xk?=
 =?iso-8859-1?Q?smfQiul4IgFFjdYuAaUjI8mMh46S77lBCL7QDKZMSlK1sXODjKLGUTtaZd?=
 =?iso-8859-1?Q?qQBhCESqlULf0iE0p8KTE6hKm87+eK715wPIPKSyJd3s1mCoXtcinjlMuF?=
 =?iso-8859-1?Q?Hq7gBrtBZJaUQczNQyw0Pn1uCSMt60gc6n+oaIOhlj84JImpcpqFfOkXdS?=
 =?iso-8859-1?Q?oBguzyt/50R8qOELz1msH4ge695P0WRnRKBeHdokPrRZQjBEwXEsBg2TQv?=
 =?iso-8859-1?Q?1ZSZbx0Tyx8UgnFPAkEFs9Gj4PedyiHn7Ev6Am/FviiduEkErlTavMACea?=
 =?iso-8859-1?Q?t1lnCk4qQrH4Zt+1+jvjBRR/nwi4dVWvfcLBZE3+tKKiWO3a+zLPHi0qsy?=
 =?iso-8859-1?Q?5N9ZVhUZDY2OsLBuV+M=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77985cac-542c-4825-5d14-08ddc515baea
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 09:38:44.1004 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vdm0fRMBCjD8Bt9tLO7eqnlYIG+Wjkc0FLTZEpGLzMnJhvb/U0X/ofNOO5fy/qn9fhv9DtcV74EXfHCKTgGdDqsd1oXq9oYOlvOqYV5t59U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR09MB4318
Received-SPF: pass client-ip=2a01:111:f403:c201::5;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AS8PR03CU001.outbound.protection.outlook.com
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

Add MIPS P8700 ldp, lwp, sdp, swp instructions.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 target/riscv/cpu.c                        |  3 +
 target/riscv/cpu_cfg.h                    |  2 +-
 target/riscv/cpu_cfg_fields.h.inc         |  1 +
 target/riscv/insn_trans/trans_xmips.c.inc | 84 +++++++++++++++++++++++
 target/riscv/xmips.decode                 | 23 +++++++
 5 files changed, 112 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d280648b55..fcaee6628e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -245,6 +245,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
     ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
     ISA_EXT_DATA_ENTRY(xmipscbop, PRIV_VERSION_1_12_0, ext_xmipscbop),
     ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
+    ISA_EXT_DATA_ENTRY(xmipslsp, PRIV_VERSION_1_12_0, ext_xmipslsp),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
     ISA_EXT_DATA_ENTRY(xtheadbs, PRIV_VERSION_1_11_0, ext_xtheadbs),
@@ -1377,6 +1378,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] =
=3D {
     MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
     MULTI_EXT_CFG_BOOL("xmipscbop", ext_xmipscbop, false),
     MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
+    MULTI_EXT_CFG_BOOL("xmipslsp", ext_xmipslsp, false),
=20
     { },
 };
@@ -3195,6 +3197,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .cfg.pmp =3D true,
         .cfg.ext_zba =3D true,
         .cfg.ext_zbb =3D true,
+        .cfg.ext_xmipslsp =3D true,
         .cfg.ext_xmipscbop =3D true,
         .cfg.ext_xmipscmov =3D true,
         .cfg.marchid =3D 0x8000000000000201,
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 9734963035..f35d477f27 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -39,7 +39,7 @@ static inline bool always_true_p(const RISCVCPUConfig *cf=
g __attribute__((__unus
=20
 static inline bool has_xmips_p(const RISCVCPUConfig *cfg)
 {
-    return cfg->ext_xmipscbop || cfg->ext_xmipscmov;
+    return cfg->ext_xmipscbop || cfg->ext_xmipscmov || cfg->ext_xmipslsp;
 }
=20
 static inline bool has_xthead_p(const RISCVCPUConfig *cfg)
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_field=
s.h.inc
index 9ee0a099bb..b5195959b2 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -147,6 +147,7 @@ BOOL_FIELD(ext_xtheadsync)
 BOOL_FIELD(ext_XVentanaCondOps)
 BOOL_FIELD(ext_xmipscbop)
 BOOL_FIELD(ext_xmipscmov)
+BOOL_FIELD(ext_xmipslsp)
=20
 BOOL_FIELD(mmu)
 BOOL_FIELD(pmp)
diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/insn_=
trans/trans_xmips.c.inc
index 620c59cc28..d0c1c9fd19 100644
--- a/target/riscv/insn_trans/trans_xmips.c.inc
+++ b/target/riscv/insn_trans/trans_xmips.c.inc
@@ -33,6 +33,12 @@
     }                                            \
 } while (0)
=20
+#define REQUIRE_XMIPSLSP(ctx) do {               \
+    if (!ctx->cfg_ptr->ext_xmipslsp) {           \
+        return false;                            \
+    }                                            \
+} while (0)
+
 static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
 {
     REQUIRE_XMIPSCMOV(ctx);
@@ -49,6 +55,84 @@ static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
     return true;
 }
=20
+static bool trans_ldp(DisasContext *ctx, arg_ldp *a)
+{
+    REQUIRE_XMIPSLSP(ctx);
+    REQUIRE_64_OR_128BIT(ctx);
+
+    TCGv src =3D get_gpr(ctx, a->rs1, EXT_NONE);
+    TCGv dest0 =3D dest_gpr(ctx, a->rd);
+    TCGv dest1 =3D dest_gpr(ctx, a->rs3);
+    TCGv addr =3D tcg_temp_new();
+
+    tcg_gen_addi_tl(addr, src, a->imm_y);
+    tcg_gen_qemu_ld_tl(dest0, addr, ctx->mem_idx, MO_TESQ);
+    gen_set_gpr(ctx, a->rd, dest0);
+
+    tcg_gen_addi_tl(addr, addr, 8);
+    tcg_gen_qemu_ld_tl(dest1, addr, ctx->mem_idx, MO_TESQ);
+    gen_set_gpr(ctx, a->rs3, dest1);
+
+    return true;
+}
+
+static bool trans_lwp(DisasContext *ctx, arg_lwp *a)
+{
+    REQUIRE_XMIPSLSP(ctx);
+
+    TCGv src =3D get_gpr(ctx, a->rs1, EXT_NONE);
+    TCGv dest0 =3D dest_gpr(ctx, a->rd);
+    TCGv dest1 =3D dest_gpr(ctx, a->rs3);
+    TCGv addr =3D tcg_temp_new();
+
+    tcg_gen_addi_tl(addr, src, a->imm_x);
+    tcg_gen_qemu_ld_tl(dest0, addr, ctx->mem_idx, MO_TESL);
+    gen_set_gpr(ctx, a->rd, dest0);
+
+    tcg_gen_addi_tl(addr, addr, 4);
+    tcg_gen_qemu_ld_tl(dest1, addr, ctx->mem_idx, MO_TESL);
+    gen_set_gpr(ctx, a->rs3, dest1);
+
+    return true;
+}
+
+static bool trans_sdp(DisasContext *ctx, arg_sdp *a)
+{
+    REQUIRE_XMIPSLSP(ctx);
+    REQUIRE_64_OR_128BIT(ctx);
+
+    TCGv src =3D get_gpr(ctx, a->rs1, EXT_NONE);
+    TCGv data0 =3D get_gpr(ctx, a->rs2, EXT_NONE);
+    TCGv data1 =3D get_gpr(ctx, a->rs3, EXT_NONE);
+    TCGv addr =3D tcg_temp_new();
+
+    tcg_gen_addi_tl(addr, src, a->imm_w);
+    tcg_gen_qemu_st_tl(data0, addr, ctx->mem_idx, MO_TEUQ);
+
+    tcg_gen_addi_tl(addr, addr, 8);
+    tcg_gen_qemu_st_tl(data1, addr, ctx->mem_idx, MO_TEUQ);
+
+    return true;
+}
+
+static bool trans_swp(DisasContext *ctx, arg_swp *a)
+{
+    REQUIRE_XMIPSLSP(ctx);
+
+    TCGv src =3D get_gpr(ctx, a->rs1, EXT_NONE);
+    TCGv data0 =3D get_gpr(ctx, a->rs2, EXT_NONE);
+    TCGv data1 =3D get_gpr(ctx, a->rs3, EXT_NONE);
+    TCGv addr =3D tcg_temp_new();
+
+    tcg_gen_addi_tl(addr, src, a->imm_v);
+    tcg_gen_qemu_st_tl(data0, addr, ctx->mem_idx, MO_TESL);
+
+    tcg_gen_addi_tl(addr, addr, 4);
+    tcg_gen_qemu_st_tl(data1, addr, ctx->mem_idx, MO_TESL);
+
+    return true;
+}
+
 static bool trans_pref(DisasContext *ctx, arg_pref *a)
 {
     REQUIRE_XMIPSCBOP(ctx);
diff --git a/target/riscv/xmips.decode b/target/riscv/xmips.decode
index 697bf26c26..99c98d4084 100644
--- a/target/riscv/xmips.decode
+++ b/target/riscv/xmips.decode
@@ -8,5 +8,28 @@
 # Reference: MIPS P8700 instructions
 #            (https://mips.com/products/hardware/p8700/)
=20
+# Fields
+%rs3       27:5
+%rs2       20:5
+%rs1       15:5
+%rd        7:5
+%imm_9     20:9
+%imm_hint  7:5
+%imm_v     25:2 9:3               !function=3Dex_shift_2
+%imm_w     25:2 10:2              !function=3Dex_shift_3
+%imm_x     22:5                   !function=3Dex_shift_2
+%imm_y     23:4                   !function=3Dex_shift_3
+
+# Formats
+@r4_immv ..... .. ..... ..... ... ... .. ....... %rs2 %rs3 %imm_v %rs1
+@r4_immw ..... .. ..... ..... ... .. ... ....... %rs2 %rs3 %imm_w %rs1
+@r4_immx ..... .....  .. ..... ... ..... ....... %rs3 %imm_x %rs1 %rd
+@r4_immy ..... ....  ... ..... ... ..... ....... %rs3 %imm_y %rs1 %rd
+
+# *** RV64 MIPS Extension ***
 ccmov          rs3:5 11 rs2:5 rs1:5 011 rd:5 0001011
 pref        000 imm_9:9 rs1:5 000 imm_hint:5 0001011
+ldp         ..... .... 000 ..... 100 .....  0001011 @r4_immy
+lwp         ..... ..... 01 ..... 100 .....  0001011 @r4_immx
+sdp         ..... .. ..... ..... 101 ..  0000001011 @r4_immw
+swp         ..... .. ..... ..... 101 ...  010001011 @r4_immv
--=20
2.34.1

