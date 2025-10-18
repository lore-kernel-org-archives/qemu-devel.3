Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8116CCD195
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Oct 2025 15:49:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vA97u-0005A5-JS; Sat, 18 Oct 2025 11:45:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vA97q-00057q-BX; Sat, 18 Oct 2025 11:45:46 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vA97o-0001QR-1F; Sat, 18 Oct 2025 11:45:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wiw0eJCLBI8m9nlcFGGLdw6PpnJMoGWgG7IwSkP6LlzFbStCJ0oDA0j6xqDaa8hajbluFNwZyb7RM4gc0mdszaxwWt5SNVQLCM9EE3qvQRmtMhLTbxXOoyR941QXHPxwcvSlbI+zONbdEjG0ubs9+M7hGxg6ZxyVUb0krFo+wrU5o8jTV34NCvz+pdDChdhptui10kkZ4k9E1pd92225W9jZT5++E+6R0rLcjedouCNN3Gbp/a+AaQMDjua/W9U0Zs+6HV8qpnuBdj6d4ZezXZFNJNjZeelK2MT7z+121RO3n4p74xYBm0pBvyISQmX60B/8J6PpUL7W6Dnmvg4Unw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oyW3Q7ZQ6oaIBLODAOp8zDllh3sILwEUmncfhjuRgAc=;
 b=hGWVeYczYm4RRpm80Y+3DhLODmOgSg3MuWYGF1kynusHBeX57M1M6TQPQGPS6WItGKTE8Sj417qS2Eu/als+juzmhW9B2gi6qcomlPsu31ZCQ+NX6TLQaxzYDbzEq8+5EVALtRnnPygH2JjTjjxi/L7hjDDxT3AdUdqH9EcP9EA50cUwFHuruaoG137Jkjkun0lYp/QkseNKM5hdGe+YmRCAnhpqmpYCL/C5gf9mBMNbf9vhImK1miYC9/BwgPxjewwzFrm/klovS43+lzYNkVHzRiB2ZHGupS1NjE/8fjdu19akgqThjfpnfZ39oz8Xcd+iz0Zx4AXJBbtVdmhXxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyW3Q7ZQ6oaIBLODAOp8zDllh3sILwEUmncfhjuRgAc=;
 b=rH0pL7Jvx8zvMx1C1SMZHQaIAALAw5jVla0lkW0VVP4oQWcRnfnJNOVkz//ek3uzUeuXILKkBX5BwcZ7suVv9SDaN5cVWWhSNTZ+ukAIZRte7uougvNdRFXIhIPZp0ddWiw9pXbGL+HQY2mGn2J/MeTnJDZHOj9/5RZGzYPUOyp+KUU2yljqZLQiJUpzknOItVHRMDlpFv2zkwKT4HRzqeQ8nvlgMIQ0f9IG0Tw8gH9GTxCqTVHuyZNZQTHvtqSzewzi4OJdKyKTgz0z3VI8JfhYl1dZaLTAAD0y/7e0N5Up+JOWYFd4xkYRc/wwRuoPVQYFNZT92IQHaIi1sj1ZRw==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by DB8PR09MB4360.eurprd09.prod.outlook.com (2603:10a6:10:154::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Sat, 18 Oct
 2025 15:45:30 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9228.014; Sat, 18 Oct 2025
 15:45:30 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v13 08/13] hw/misc: Add RISC-V CMGCR device implementation
Thread-Topic: [PATCH v13 08/13] hw/misc: Add RISC-V CMGCR device implementation
Thread-Index: AQHcQEY75j3gdGdOP0i1T6+ZpvQfYg==
Date: Sat, 18 Oct 2025 15:45:30 +0000
Message-ID: <20251018154522.745788-9-djordje.todorovic@htecgroup.com>
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
x-ms-office365-filtering-correlation-id: 1d4f6da1-5697-4773-417f-08de0e5d5e0d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?2/KVsz1dcYlR6iUO/W6gpY9MvnfCwEuS6jlyfEt4R7SIgzsuGWQc4EraRs?=
 =?iso-8859-1?Q?1cpRZTeIK1YhaZvPLJCH2nJtJUG+oJcNQ76FOsHKqwqB3yyNbZNBwTHnut?=
 =?iso-8859-1?Q?EeLNcAyHPmG/813qRrWx/g9pr3L4HT7QVdyXoW6dYIKpqqj/AFh7r3spMe?=
 =?iso-8859-1?Q?rSpA/R3SxSzznAqOBDu7/TmGW1JgqtlbHvR6j7qwrK4I3fWRiKmb3K+MuC?=
 =?iso-8859-1?Q?qW/Oa9Sm8sV7Ylfi4u1svLd3l56qGLU0wAT0iFMyLJR5iHdvm0Cy48+B21?=
 =?iso-8859-1?Q?mnVuWIll4o4Q6Tc0/iT3QCAE2+CKnYmTjF1nXlQ0j2F0bBFCvsBt+whbRr?=
 =?iso-8859-1?Q?M4wEvxSSiOtT/Xk+OGcZlLNEpSJWMc4Ckl49iBvIfYXpLe+VDl38Tr3h8l?=
 =?iso-8859-1?Q?gUDHn2I4vYXOnWHdGNcy/mJG64MDchuI4SYZriSnFauwAEwEAvMsfGR5yO?=
 =?iso-8859-1?Q?cl38Yh4Wsd0JkALlg9gf4rv6/AHuxy49ssG1xD0s/0VSTdWhDbg1USMjvw?=
 =?iso-8859-1?Q?4OzZSdoDWSdc6yKEwhf81ct4gCYsgWZKU9IGhUiprK2huG5nLF3gLUU68C?=
 =?iso-8859-1?Q?zExPLQaFgPCdWwd9Vz0bj0STlLqM6Gm137d5qf19y+F4ehVOqB4aVwQbJw?=
 =?iso-8859-1?Q?xA8/XvY6Uyaar7fEerYhy4S+P/4GYYwLxYh8OoisBP+nS5qi4jgCVHajTU?=
 =?iso-8859-1?Q?rkpqV1p/9Q1rT5SLL210wvq8AQuIpfdx5HCaKXBF838S9afowSwebglUl/?=
 =?iso-8859-1?Q?9zm78cgc0fUZIijH5LdCOlF/cQ5echW1oj9s2/4FSeWPu0SKY7LERtAuTC?=
 =?iso-8859-1?Q?CkFe6WH9loErelWnVV52/cu/2+iKUZeQyRhn7qENN82TRgkwajEP4P/YVu?=
 =?iso-8859-1?Q?sso0s6qziXV8swIMbMFILlurDCKjgQweZstfagXloC4ZUUdO4pQn6xIV76?=
 =?iso-8859-1?Q?jt6Q+U9b2AkZr+oSp05UOMhKQqWLst+AE9XcgcleeSOUl+liStML6983Io?=
 =?iso-8859-1?Q?xvMGHa8EUU1a+Bh81bNV2/QTk8sdQju0rfw4jY46xpfGykbVnAP+4QMQYh?=
 =?iso-8859-1?Q?+iiiv+2XzHAZgiTErIPp77Qvr/7I9qCY1Evfqx/SFxxnDD8X+jzEtvjVqp?=
 =?iso-8859-1?Q?jbEho/qTJILBaapFJLDjCMuFkEu9XZwnkmvfmvs3InkCD/oz4XVoLDF8/p?=
 =?iso-8859-1?Q?qUuk4z7gsYvvMCEm9sMhGDLSuRgie3vqZK4YRz505+q2Fqq3VWMLQeWvRh?=
 =?iso-8859-1?Q?K9HNgUllz2lHUadFwMrOOz1oRVhRiSzRrk/e1JikFxcgOm5bZ3a35AZot4?=
 =?iso-8859-1?Q?o94qsF/Y/MmHjQAe2bYVdt4pKa6B0RNNY3Xv4oYur7LNcCxyA+M+zO9T+A?=
 =?iso-8859-1?Q?lZ/FGfKdm3cKejjUaZG1F68VbOt/9XAup9vGAigOna6zdQ/rOG1c+aGlEt?=
 =?iso-8859-1?Q?u70GP+pg+leXnY214ulU0kESuLXQmZic8umVWwucJYGzgdQm3XlVqpW6Lw?=
 =?iso-8859-1?Q?aV5sK7L2xVUC9GOKoxwTKA+m6zSJI88rwMuxGnkp6JezHs3jTNWldAaqMj?=
 =?iso-8859-1?Q?ZD5IURWeYIjygNXV+89B1ngZBnMr?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?I8U+vIPLTmqGRuRc1TJF60tvJGChn5vKeOLqTGeHHcMMYg+GCE3krqDFxa?=
 =?iso-8859-1?Q?/m6Ei252JKv84weNiyERL6lBhKKCUov8Rv3fxEcugXLunq1b9pml5rM1xv?=
 =?iso-8859-1?Q?1lFx6czGAzF8PQyuz8INyYIdtPotGYXxf9az7ifLCqG7scOd1ikuCEwOem?=
 =?iso-8859-1?Q?1kex+ARj2wwoGvxGrjvvpw7Phlho0+Z5MytdqZ3FN79m4C9MW7h6PXw9BY?=
 =?iso-8859-1?Q?R6UPpOUB6fTDCMDv3keAgnLK1S1iSUTvZHp9a4/Cemj2uMlQuVZPQcgl0B?=
 =?iso-8859-1?Q?grBkLQ+F6C/DRUNhJw0VwD023hrbZL4G6HyQ/sxqk8em1OldCccuy0G7lv?=
 =?iso-8859-1?Q?UorIWUkLlJBYjOEL2xAKNiOe43a65yqbtk28DGARFvdkhAiWwX27McBoBe?=
 =?iso-8859-1?Q?VH79/cTwtqWJMx6gpw6xLN+KvF34zIUZpk9R3LyLeCRaURh4lySH2/HkTx?=
 =?iso-8859-1?Q?Jv41txZZMzMFAjSZQOaKEVg58txjGmzNHISg9sQ0A8LtSMa8PL8aS7lLj2?=
 =?iso-8859-1?Q?mN7/skHx74rhxpkFbD34bwY6neaWfP/wWobKmqxhnSk2wbssX704T1DNuW?=
 =?iso-8859-1?Q?Z+miZbn5qyl47QbsJycKmI9uEmgBxG2dVARAINVRxxEIxBg7s4EWK2Etlj?=
 =?iso-8859-1?Q?2UI++4m8lG04UVIRRJHAKdmgtjhPJKUsADm9lQFbKUMpuzZhqLw/LiRPI4?=
 =?iso-8859-1?Q?+W0R8s0tWVsysEG7VexGkLqu7/ufqED468wTAgEU3EQPasJsDSsWuONe6r?=
 =?iso-8859-1?Q?fJiR24VCmwFqpWUVNkxEfgi8/4NGJsPsyslb7n/h7bkyYoMAyvpNmBNKl9?=
 =?iso-8859-1?Q?pyuL4SdnnSelumy6WJ+NVt+sSm2ZdEmgoMNAmGdzo2z+ib4t1YUhM2QMbl?=
 =?iso-8859-1?Q?5Yzd+u5Coq+Ur2u9/14FKCzqyONc9h+XNepvMQVF47glI08X5LA2lUXImx?=
 =?iso-8859-1?Q?/Up0nMZ/VG6r0eyra43GKayQLwGOlTi+2ADcUqSjdDde2zeXK0faCsdH5G?=
 =?iso-8859-1?Q?0EHBZmzLIFBSXQ0rJarzZ5PvIopi5+LlrnWuPoDPVKx7tlDzncOtip58yk?=
 =?iso-8859-1?Q?XfgQR7ILJiaKkdUUm0g3LOzePeaAlugvOeDvbfBZ3NkFxUw81K6q0k7F+R?=
 =?iso-8859-1?Q?eSd44DidEg+NUpZRAl4L8EdEgvhTWhWFsa520T54woQLppy7WSBnvsZdUg?=
 =?iso-8859-1?Q?bb85kM55sfLQfNJjlYrOMarTJooGfBcaqVuykmIZal4tzvZO/C5IMtme9I?=
 =?iso-8859-1?Q?nhtFkimJU98WQkIzi19/Rk4T5q5x/12QeXh5BrWwL+y5T9EA195w5U9WoK?=
 =?iso-8859-1?Q?T2MVG2sHeRkB8VqPObNb8AVt7YGdV4YrzS8vbp9PPFrCFpFmjQX3qyMkTp?=
 =?iso-8859-1?Q?rzzBVhiI75ekfaMyVNAmDMExxAIWb/BPaE9lew6iOvhTuPrJjLxl0eF4uS?=
 =?iso-8859-1?Q?ajPW4KYqFtvo77Dc4dhVBDl9ecO6eQsXVWWpCbkbw49y8YPALffiAnLgEt?=
 =?iso-8859-1?Q?HAuyu/s9D29wPVbAW7umH92aevCeNNRvaBpgPNyMxcFQlrxG3tFY+pVwjO?=
 =?iso-8859-1?Q?gkIRdLJVu9hywjC05qZu+9RoFzbwknWbjV2/P2aooOE/+CO5sthbEVzM1D?=
 =?iso-8859-1?Q?rh5ffJ0sneTpBbLHIQIz3IzJRUgDwDnTaZZ7Kb2ae+bWW7F5ouZAv4Q/zc?=
 =?iso-8859-1?Q?aEFeMbp+YpUWRL6WHzY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d4f6da1-5697-4773-417f-08de0e5d5e0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2025 15:45:30.5503 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lA7adUoAD6hfZl2zK6Aw+t5kNwLNsrkIEtVyLgneyQJ+VFQwe+a9B7v+V+7U2Uikr7X+G2b7fktIQgsHt+KLu5+k2ufzeo+Z8qL/2SAjjF0=
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

Add RISC-V implementation of the Coherent Manager Global Control
Register (CMGCR) device. It is based on the existing MIPS CMGCR
implementation but adapted for RISC-V systems.

The CMGCR device provides global system control for multi-core
configurations in RISC-V systems.

This is needed for the MIPS BOSTON AIA board.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/misc/Kconfig               |   9 ++
 hw/misc/meson.build           |   2 +
 hw/misc/riscv_cmgcr.c         | 248 ++++++++++++++++++++++++++++++++++
 include/hw/misc/riscv_cmgcr.h |  50 +++++++
 4 files changed, 309 insertions(+)
 create mode 100644 hw/misc/riscv_cmgcr.c
 create mode 100644 include/hw/misc/riscv_cmgcr.h

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 4e35657468..222efb12fb 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -121,6 +121,15 @@ config MIPS_ITU
     bool
     depends on TCG
=20
+config RISCV_MIPS_CMGCR
+    bool
+
+config MIPS_BOSTON_AIA
+    bool
+    default y
+    depends on RISCV64
+    select RISCV_MIPS_CMGCR
+
 config MPS2_FPGAIO
     bool
     select LED
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index b1d8d8e5d2..489f0f3319 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -157,6 +157,8 @@ specific_ss.add(when: 'CONFIG_MAC_VIA', if_true: files(=
'mac_via.c'))
 specific_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('mips_cmgcr.c', 'm=
ips_cpc.c'))
 specific_ss.add(when: 'CONFIG_MIPS_ITU', if_true: files('mips_itu.c'))
=20
+specific_ss.add(when: 'CONFIG_RISCV_MIPS_CMGCR', if_true: files('riscv_cmg=
cr.c'))
+
 system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
=20
 # HPPA devices
diff --git a/hw/misc/riscv_cmgcr.c b/hw/misc/riscv_cmgcr.c
new file mode 100644
index 0000000000..8e7b86867a
--- /dev/null
+++ b/hw/misc/riscv_cmgcr.c
@@ -0,0 +1,248 @@
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
+ * Reference: MIPS P8700 documentation
+ *            (https://mips.com/products/hardware/p8700/)
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qapi/error.h"
+#include "hw/sysbus.h"
+#include "migration/vmstate.h"
+#include "hw/misc/riscv_cmgcr.h"
+#include "hw/qdev-properties.h"
+
+#include "cpu.h"
+
+#define CM_RESET_VEC 0x1FC00000
+#define GCR_ADDRSPACE_SZ        0x8000
+
+/* Offsets to register blocks */
+#define RISCV_GCB_OFS        0x0000 /* Global Control Block */
+#define RISCV_CLCB_OFS       0x2000 /* Core Control Block */
+#define RISCV_CORE_REG_STRIDE 0x100 /* Stride between core-specific regist=
ers */
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
+    /*
+     * For boston-aia, cpc_base is set to gcr_base + 0x8001 to enable
+     * cpc automatically.
+     */
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
+            if (addr =3D=3D RISCV_CLCB_OFS + c * RISCV_CORE_REG_STRIDE + h=
 * 8) {
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
+    /* Validate num_vps */
+    if (s->num_vps =3D=3D 0) {
+        error_setg(errp, "num-vp must be at least 1");
+        return;
+    }
+    if (s->num_vps > GCR_MAX_VPS) {
+        error_setg(errp, "num-vp cannot exceed %d", GCR_MAX_VPS);
+        return;
+    }
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
diff --git a/include/hw/misc/riscv_cmgcr.h b/include/hw/misc/riscv_cmgcr.h
new file mode 100644
index 0000000000..c57d4ada1c
--- /dev/null
+++ b/include/hw/misc/riscv_cmgcr.h
@@ -0,0 +1,50 @@
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
+#define GCR_MAX_VPS             256
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
--=20
2.34.1

