Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F64CA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 10:31:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut1nB-000444-Px; Mon, 01 Sep 2025 06:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ut1my-0003vA-Lk; Mon, 01 Sep 2025 06:29:29 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ut1mv-0005M5-56; Mon, 01 Sep 2025 06:29:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BxHRiDZd5/CsfNQYCl8zn0chSTFv8CWP7mWVxrCdaHb8SLjscWe3NU5PLoGaIqBymgpeGel8O07D8nXf0bU2rnOlatUOl6n6mCYTnwWXvzc4FWX5BDk+eYfCTZKuokfl/BfZSDbul9MQuvosetFrD3yyfzFvEwlbU8xYvYV5MWV5TTdc0hyA7/TcBd/j9rmwAwtwxFsCnBbaKsObMGVFGaksZU0H/PL6YGV5HxlKCr2zjZSLGGRzMnXYPV2OPc8Zb2p7wcLkMeZGPSsZsAeBLnUYscMztnK783pEL7UKr8VJF1d3LRYCbn/HPpHxDwF9uAE8vrWmCg4yQjOd3N6syw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DSvD9SFB9kQi2l4O0kK5d+55oKIpDMfpuOiAudbNHVE=;
 b=i4kvo99yuggLuurKflQOwzATCZ73MyWdqqr5Ib8wSg5jI/dxkbSOj9gTOwDveNK/Y03nTzOD0Hl1ihaWBrjbvlg04yKiuGQV9KZaNUjOvpuTwZUU9vuH8179sFWbB/kKp5p78uOWJ+C/0Nwxo3YwM3EvjQYqT58AA68GFhOVGxLPBp2MMxPYb2ObrMk7doLvOqMcUsUEQhiTEkBbJWWrA1EwfMuELwDN0pk+yCwDbyk0G4P9pBlGisimhLsMbss35urr62pfqJzpavfdraxPhD+R4BFX8P2QJrmCNsPbzj0wVuRUW7htwiahZhu7sKOoRZaKXWr0h9pvrwNhjtW9cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSvD9SFB9kQi2l4O0kK5d+55oKIpDMfpuOiAudbNHVE=;
 b=Ykb8u9RGfJrT6TTqAAZw7vY0dPSOqOFtrSdEaTSftHLgRpMIWA5Ez92LVIbPSLziPX2041/OB50So2+Lhw/4VCBOOEDgwfdIKLw8oEqLS6tTZ0w1E7kkdsZJdEqnM3DGhwoJNfYnDj0chIlIPOCX6bsKFsBNZDvWQ9ohWJJ0aGSi0R9F0MHFf4hDopdTEy+JB+Le0YLYaIwE6+zrsGLQHS+EfoqHPlSR6QZizlsKF3ZisyjlcmeGV8QwQ6wen0N4KdcdpYP/9NXP9jqSv6/dXxfprZ9rhFdz9NSb5lWdznqKr+llJunYniMuALLvAg2DZ+YM6JmrPr+XKvORpnPbJQ==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by GV2PR09MB5992.eurprd09.prod.outlook.com (2603:10a6:150:be::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.28; Mon, 1 Sep
 2025 10:29:08 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9052.019; Mon, 1 Sep 2025
 10:29:08 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v7 10/14] hw/riscv: Add support for RISCV CPS
Thread-Topic: [PATCH v7 10/14] hw/riscv: Add support for RISCV CPS
Thread-Index: AQHcGys+C5Hv/zQDNUOuthxDJQy7ag==
Date: Mon, 1 Sep 2025 10:29:05 +0000
Message-ID: <20250901102850.1172983-11-djordje.todorovic@htecgroup.com>
References: <20250901102850.1172983-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250901102850.1172983-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|GV2PR09MB5992:EE_
x-ms-office365-filtering-correlation-id: 69bfdaaf-58d6-48d8-0ce7-08dde942626f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|13003099007|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?gQ/Sqjr9jYQJ+5ltTTA8ZqyjoIKGqw2WuE9kh9FNDolRmaIVz198b6xgTE?=
 =?iso-8859-1?Q?PSxxlqo1U91OxnunsV1GcT/MImU0asomYW6x7T0hmeAPTjMWnBVdWh7AeW?=
 =?iso-8859-1?Q?81wd/QlQN4q+uMJn50eR3Wtj07Q7mJc04YjIcyiFsiYQb9xRhYIMJiptvI?=
 =?iso-8859-1?Q?gtNrjLyb2tybFDIkjDKCmmVvhnpIjjLY3hFnyk1DSscBDJ7+WNGo+tKOMm?=
 =?iso-8859-1?Q?Xm/iYKBgnbxfLP1THeBWyaLq8mkc9z+Ap24xHfBE+V9Ha+ry9VEQAkV4LL?=
 =?iso-8859-1?Q?1zyCFUgoyNePc7cS9ShIOdOnRn1kE3SsivXEe27PjpScYKbMhuIWVEMf6H?=
 =?iso-8859-1?Q?3qxnQRhpuYQ4aJpcEnREbxtzmlUVx3PirYXiEyxpV9hrklxu2tiEhRscY3?=
 =?iso-8859-1?Q?ExgR0ut9fNasockxUdPP0BRLVUKdXslIsCpgL33QzsSFPEcXbemEDNW98W?=
 =?iso-8859-1?Q?mTI8Wuwpx35PRuRhr3H6Bf8xrT2jLyS5FMsQ2q089VyZL8CDOCxrX+yUQk?=
 =?iso-8859-1?Q?EoKNEQ+wErfi7+NjxJX2nZJBk7J5z41/wJMRUI7yUeE8NpkYFhwO6ve/KF?=
 =?iso-8859-1?Q?hKM+JkeEsEOO98dphZ7HK/9UXuYnmqy7794is1CzhQtplcPtzsObky7/Xa?=
 =?iso-8859-1?Q?1P0ZrhIJGnwPAI+Hl8ZLvL2vEmGQAq2MOptxCzm290S9aSudttHcsxxYW5?=
 =?iso-8859-1?Q?PccejWbTdMiCTnC7R71LB6zoJSwDeTSzE0xjk6HL7LOylkC12/kuAi+Bfz?=
 =?iso-8859-1?Q?426RZ+9czCCclDnhG4G1PHnNAKNwoBlSGOuXqk6Yd1rd/Pv/hy5cNFSE0G?=
 =?iso-8859-1?Q?gFcXoiVSpqI7rkdfJ7MAt9XMIYfn1FB4iywxFJKr0//Fm/+ESHSqiBbubA?=
 =?iso-8859-1?Q?fW1mX1NmUlmG0YSnJ06PRvbLOLjEQv1OisqeBjAqmuHWtZe6EJSRp12eTU?=
 =?iso-8859-1?Q?zKAq/cbGYwHDij46ektBjswWBfCMs6CV1EM0B9VEpnL1rD75DlDDMG9WAb?=
 =?iso-8859-1?Q?7SvsKYMuE/BkG1eUR4VEs+iT+C9qgszRGScyCESQ55Ib/5vXPzdUxwhUPs?=
 =?iso-8859-1?Q?ly7GMOXgo5zGfE7C9XGAwbRIc5joe2vAUYhsJKDVaKfB7LAPTQHjLeSmqE?=
 =?iso-8859-1?Q?8uFV0EetdhqQX+AoZ8QQjB+TtLLwGJH0PFOEDOQ3EXhAeEVq4EH97cgA7S?=
 =?iso-8859-1?Q?Lc3eXLfQx7PsyqhXWU9UnGqp3WXF2gLy522Z+X6bpXtM8S4TpugPUxjQKn?=
 =?iso-8859-1?Q?HpCBHgHCHDxZDeeHN/PuGN/PbtbwDlGyvKiVCckfO41+KCnC2hV0CoygrS?=
 =?iso-8859-1?Q?k9lTWAkgTtt1hQ0P6Ze0e91ZjpUjbuluveRHccgIzePwfp7xYorw2XCZHC?=
 =?iso-8859-1?Q?tOG1DhirwWCQ7GzzulV5TlsIu/VAhq530xndntBWBxZwicPTr2XsrJ3k9V?=
 =?iso-8859-1?Q?CVQXsCoDuERVb5iC8hfYHLsgED5MgBKgAiJo9j8cm+rSfFRbe0/wZp4ECj?=
 =?iso-8859-1?Q?9FMko2Im1kNu9gSUuEF68miZN0XfJw94BaMq73IGBWUw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(13003099007)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rco6mXkBVaUVOsEkS0IQC6xCxSyiFLeLvGzUjh7DLZnCw6wvmCd19fD6HJ?=
 =?iso-8859-1?Q?NxVpYS8dtzOEUtXs2I0YMoDtDogV6/RBlty5shiNTgtviYBQt25wdv+Ka2?=
 =?iso-8859-1?Q?i315J231dmQienhdIEU76F8BqIO7L2CwhdEXLq9+P0LRJapKxBr/P8xhub?=
 =?iso-8859-1?Q?4+qiPPPUc1beXEbxCUT6Vrm3iighJ0pLvyjH8FiGEwHPL/bvF13+k8iPct?=
 =?iso-8859-1?Q?JB8PHZuhEJqz1oRQ3HAj8Z+wZKogYOqTa1d+dSxWBdVDALFU7hv7jVady1?=
 =?iso-8859-1?Q?zQmJu+uUnNdLRB1RWY4zZZ4Y8r2y/o5ApWtHuzjtBpHWJn03v26RD1/kgu?=
 =?iso-8859-1?Q?Z0O7M1u2d5A2eEWEa8pG0QdSDGguh1p3Q5fdvUDdjFj/cNauxPPs5sZimm?=
 =?iso-8859-1?Q?87O0I1GQq9VkZLJmx1WKESgO/Sd52GWwRh2icfy/bLZyYfv+VElYKn1rFf?=
 =?iso-8859-1?Q?a+GuOYBpwvGaOvmNpAiXOuMjD0xFKCq9DmSaLez6Pss+rLYivX10Y/iWUn?=
 =?iso-8859-1?Q?NXtlkzR1BSuHuFbSEDAS3/09iMC+nxjEqBCrrbKw3fjX90nRoie+q8Ufwx?=
 =?iso-8859-1?Q?nt3LVi/j9VQGd+UitNgPF0eaahmZhO2eK/wcx0W1IbaEsXSJy67sH4nxh1?=
 =?iso-8859-1?Q?wE/UIPXCOHlIVs0ym7o4tB9JzJrMhWZNADL/+Xw6MKd2vYaKK0E40hth6H?=
 =?iso-8859-1?Q?A9mpwoV+axNQbicTHyjwJe9NqzdcNq99rCyJE76CCIeMdrXRFByrcgQO+f?=
 =?iso-8859-1?Q?46ttaRngVL3cxNeQDZTm/q6VA4jW7KuI73LnjKksbtmlzOfhBPjGCNVXNz?=
 =?iso-8859-1?Q?Th0Du00PSiyGnCtsBUhGC4WqZZMRv69hXFGK7RMa/YiO2wN1ZjuQpi/2xP?=
 =?iso-8859-1?Q?+80GrxRPAfMiXwV7jpVGT4ONh2mSvRkMUYBFR7QL23UgthhWguq8CV5KLg?=
 =?iso-8859-1?Q?Z0pAXDnrr2cgtuvvrIthWt1EIjOHhAI9Id+xEcWI/t+SrXczhYFfdFQEp2?=
 =?iso-8859-1?Q?XBlGI4mc0P0lvXJTiJrSUvvZkgZQKaFbVso4q55YqnHrkQBfhgxL4e3FAp?=
 =?iso-8859-1?Q?m/2DlTUChJ5+zNiJpOJnSkw9AUJM8Xqzw2zSvgG/L5WQuaFgbB5waOsMr8?=
 =?iso-8859-1?Q?rDHQmloXNyOmpg07Aq+1Xtd956GHRnZxqslivNzzD9EkN2UJycOeRWsjmk?=
 =?iso-8859-1?Q?SfmFvvSxsdhaYy3RyIAdNc6CwQd5Tz5fgzfH04KOktdbjafjqUec9NMFEL?=
 =?iso-8859-1?Q?XDdxyp0SEb6NSX5wcRe5OkfNwKGdswjRcNEKG8tnyBI3szWrtRgWeaoan9?=
 =?iso-8859-1?Q?tOEjAzxdLFtgD1rYpFfVMkL2oME9+wcwLQXtWNF/+QaddVsfZO7KGucjyl?=
 =?iso-8859-1?Q?2acZA5IUiihADfPjz2LEcX7AMFLRlkpR2zmDg2ZB8zc5OGxC4x5jGrpwaN?=
 =?iso-8859-1?Q?v+rKsGW0NEU3v14BXcvGZB+HZwGi7JkqFqev8NM+W8iIE+ntQcIemdwORe?=
 =?iso-8859-1?Q?8zxl/vzY/dpCqycI0cdhFVriLO01+RQaFWZcK4BAUEWz+074XBR8mHfbZG?=
 =?iso-8859-1?Q?dqZdre8lXpuo2txO3vXVzQpcGY9D7Z4EuQB5hCnbGH1s2Fg/0TdIm8cCLB?=
 =?iso-8859-1?Q?M4lE9uau5HgsUpxk4g3vPqNtyZGi94IOY4hukwV06Qi7nz1UaybZVCUHGG?=
 =?iso-8859-1?Q?sywgLurSqYvYubBaRHM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69bfdaaf-58d6-48d8-0ce7-08dde942626f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 10:29:05.6123 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yVQce9x61e8AxWbLwoEmS6duBcLQJqfTe34w0RxIerfObXGhIvbeq6+atYTuuJeptRWmg1lr6jH+euQAXpzd5aILKFbfhVcBTxxYNtOe12A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR09MB5992
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
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
 hw/riscv/cps.c         | 209 +++++++++++++++++++++++++++++++++++++++++
 hw/riscv/meson.build   |   2 +
 include/hw/riscv/cps.h |  76 +++++++++++++++
 4 files changed, 291 insertions(+)
 create mode 100644 hw/riscv/cps.c
 create mode 100644 include/hw/riscv/cps.h

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 1e35bcd443..de44afc5b6 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -127,12 +127,16 @@ config RISCV_CMGCR
 config RISCV_CPC
     bool
=20
+config RISCV_CPS
+    bool
+
 config MIPS_BOSTON_AIA
     bool
     default y
     depends on RISCV64
     select RISCV_CMGCR
     select RISCV_CPC
+    select RISCV_CPS
=20
 config MPS2_FPGAIO
     bool
diff --git a/hw/riscv/cps.c b/hw/riscv/cps.c
new file mode 100644
index 0000000000..361dded660
--- /dev/null
+++ b/hw/riscv/cps.c
@@ -0,0 +1,209 @@
+/*
+ * Coherent Processing System emulation.
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
+ * SPDX-License-Identifier: LGPL-2.1-or-later
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
index 2a8d5b136c..945ba20612 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -15,4 +15,6 @@ riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files(
 riscv_ss.add(when: 'CONFIG_MICROBLAZE_V', if_true: files('microblaze-v-gen=
eric.c'))
 riscv_ss.add(when: 'CONFIG_XIANGSHAN_KUNMINGHU', if_true: files('xiangshan=
_kmh.c'))
=20
+riscv_ss.add(when: 'CONFIG_RISCV_CPS', if_true: files('cps.c'))
+
 hw_arch +=3D {'riscv': riscv_ss}
diff --git a/include/hw/riscv/cps.h b/include/hw/riscv/cps.h
new file mode 100644
index 0000000000..4886a01ec9
--- /dev/null
+++ b/include/hw/riscv/cps.h
@@ -0,0 +1,76 @@
+/*
+ * Coherent Processing System emulation.
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
+ * SPDX-License-Identifier: LGPL-2.1-or-later
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
+/* The mhartid bits has cluster at bit 16, core at bit 4, and hart at
+   bit 0. */
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

