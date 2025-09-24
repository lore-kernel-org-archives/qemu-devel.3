Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F7FFCAC5B2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 09:20:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Leq-0003vA-Ew; Wed, 24 Sep 2025 05:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v1Lee-0003rn-TU; Wed, 24 Sep 2025 05:19:17 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v1LeW-00030I-8R; Wed, 24 Sep 2025 05:19:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x+yQSWWsupZWZF57lZSGiHCNYm6CPwbmIlq/l4aUzZTN67nl+9ZLoKfeYyJKdFCMLzQZ6iQqcQ4L578Sx+/tNL6Bvfs74GVGuH9t5SZevuwuPK6DoR7HR5BolEHICqqUv4KROmydnSR/ok1sMp+1DjgCZq6eqRMbccK2J4UosA5fZhW9NLvzlCuz/4fhPKBMlQue9aDH7Q8jFq2SiW9y6wD2Nk9MBy5e0W6UfF0xd10FHcXtYBT+1ie2MRYuSARroQM1HQYPEIjYvQ0oz1RhHRRBtMu42n5TLcdGOfgzwS92dAhwaaLtz/AHSGLVZ6Wip2ufbt3BxyRa/S8asdkO5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dneX68j8FuzKTnqV5D0s0N6GQnjVcgt7XwOeOFJaEg8=;
 b=wZFEykcF2SgOcWHDgWvCXWAX3yr7IQcDLP0Gz0HfuLEWR0Ju02o3h7jo3yrwfmRSiQMaKnwRPVmoOYPmPBIYAeIWLktWPbiJbtGwATYWuBDwNV1W46VKb06cZjlh4BHAPGvYPy9Wqef97EjApjBZyo78ZLrhV9VzqcwrRd3wWLafGOvbeEBK/UhqpRiJQZXU9/JBDQL358aobhWw0gWxKPuqW/FhRDorxGfXmtxBNPu8Yld++Of721HaBZDxLlWjGlmGJ5xr+v2v/ST6/3bvt3qgKbr3czcu9OHdfC9SzY3PPXbz2xQ5Ed/qZBZaeQez2g8Gqatqg76MCTXKD6I3hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dneX68j8FuzKTnqV5D0s0N6GQnjVcgt7XwOeOFJaEg8=;
 b=JcR3w9qG2o2T9SBqSnjJbUZywFn/vh4cHWXIbFlFsCPWl9w7OMfY3kaK0umgxvO2G6hJp0A1PjBIiBkq05YaMWOvsbaAk93/h5QH+4aBDewp/85qezlxpCvkdCnvOUz7BzHmlKQNBAAukrsU5JrhyrvQujvav6yiaMg9quUXbrn44qiPBfuKXbqZKI358sW6r2wF3SdQmxKQF4ST5tpl1wWjkoKLa8ppzSlZikyvyhDwzuazIwZw/fn3m5Glmt9COWyUSQmOp33pIDizrjX0JIcgVL9ZMAEaPvIXW7UKR8P5yTtQ6Ef07FjEc+njWI3hfOXQGCZOWkFfTBrkuzWQPw==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by VI0PR09MB7826.eurprd09.prod.outlook.com (2603:10a6:800:21b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 09:18:22 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 09:18:22 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v8 14/14] test/functional: Add test for boston-aia board
Thread-Topic: [PATCH v8 14/14] test/functional: Add test for boston-aia board
Thread-Index: AQHcLTQqtD/FHTZLSEW8Oz8veaatwQ==
Date: Wed, 24 Sep 2025 09:18:18 +0000
Message-ID: <20250924091746.1882125-15-djordje.todorovic@htecgroup.com>
References: <20250924091746.1882125-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250924091746.1882125-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|VI0PR09MB7826:EE_
x-ms-office365-filtering-correlation-id: ea75750a-da78-450e-f425-08ddfb4b4f0b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?/nzNiioBYtvSkcVidRGhSHptJPa2/CU/fSMBBH2L/WcDwiiBY3bo9B5vdy?=
 =?iso-8859-1?Q?IcMzt9AHu7aO2eTOkwQDSc90jluQ2o9nWD+UP3+jkBLiBNx+nPmzc0k2/c?=
 =?iso-8859-1?Q?baNvD+b8dUsHF6z3X7ZZJ7pri7YBEn8TNUtCyZmOrQWtgYnEzdzdk9iYot?=
 =?iso-8859-1?Q?jhNglN5jZ4mbFRCjWzj6G6LR/JxJrm7+VcVxdzI4HcTaUbeERHMjZgnoQe?=
 =?iso-8859-1?Q?EncINvjGy/RwGc7gry4Nvo03SOhN6+UMNhi3/rp9saDlYTPTUnn4edC0+N?=
 =?iso-8859-1?Q?s0+2Wry5Ya6qlNdSF492PyUuQ8eq61OtES4oyJUVO2WDVDi3QUyQsknyOT?=
 =?iso-8859-1?Q?x8k3I6g9qqrJDdOTJV7sYefMPPoc/1KPzz3gG+9V6EHCkvzvmzcINL1asC?=
 =?iso-8859-1?Q?wYHjU9Q6uNHvxREZrKiXr8iS3NEFo7v/SU8bG/UzQtHMNpEmr/MlCakA0W?=
 =?iso-8859-1?Q?s3eoK9jsuQzNTz2hK35G6S2J/EOjjhOer/Nrn4baSrYN5+2VUU9twF4P34?=
 =?iso-8859-1?Q?ZwgKadRLRwZFo9ImwZmAsa1Lu6p+RFIY59zShkQCoU02H/187PnbSTLSk8?=
 =?iso-8859-1?Q?4dP67zdtH48OfWwfzVZwTW6dsvPgjt3CBw/nQWE8lXNN81oR8sVevoICQu?=
 =?iso-8859-1?Q?oDI7Z/mNqaoxfdERGtUOu6MGCk9W+JTWA9eNzP7VZsFwDD3KwemCD9XCz/?=
 =?iso-8859-1?Q?dXGut8KZ7xUAxMTWiWzIDLHo32vpCAOc/vwqNy/5NB3F2jMWEAtbMNHq5y?=
 =?iso-8859-1?Q?Rj4tvDhTGNSiPyywF8w+g46U4dWjRVgK4cEfyP2Uetodi8NH2O4C4dGer3?=
 =?iso-8859-1?Q?0kmvcyWRMDLxF1ERjolvkI5YLtHyQzu1uAoP9JoNEGZHZVcH7tuNPRrRmR?=
 =?iso-8859-1?Q?DmHYhrI7iVWP9yQWOmseTNfvt/Ju7aqU6SPNnBOgMUUHb280tBNTbtlB66?=
 =?iso-8859-1?Q?4aSD1SJgBrdehDdtUk5cGw2/yXlH0foy98QCBUSEkAWmGgtnBuTHHjTSbV?=
 =?iso-8859-1?Q?7c9jkC5nXlMxmEE1SadgSMJo0zhkJSZpxJu4Of/jBxbyPv2u4CJvcvMMif?=
 =?iso-8859-1?Q?cLQFeL72Bq/bP62vsUCSb8VLHTgTvzaT8z5ottQFEc8rPhKYWP/gsymQHr?=
 =?iso-8859-1?Q?Wt7kXBLtYetCqOWaopLlZhASgiS6qltRja6L/miD3C/QwBGHOrLbd516SC?=
 =?iso-8859-1?Q?kV2NUMwqxT9yEJcQ09rCV45Ina3v6IZ47dHz3X+Z9bznmRvbrdyHVSlflF?=
 =?iso-8859-1?Q?HQc3ARR2QadfpF/UYMx2A4uv2vSuA1UmWwZvp9nBIlVWEU6J+L3ORzbkRZ?=
 =?iso-8859-1?Q?FMMoLd2jgm4Dgo61LJ7U1KkJqNnG7BOwpJCZDpAUJBlYJ9WNIzde0HbRz1?=
 =?iso-8859-1?Q?9a0IF2MUt2nYoWqpyaEKHv4Pps9iHNWqFucmd5cFCaVYfH9QdD4evH2wft?=
 =?iso-8859-1?Q?OqEN5zfwAwYHKvW4RM/67m315heocFE1VHu6AGYoLDhw+HgpJdQcC/U6pQ?=
 =?iso-8859-1?Q?BuyGrKJLdTR1hALZVyn3Bl7Cisp1x1aZ0Xe6c5j8GeSZHe8ahe2M/2khzd?=
 =?iso-8859-1?Q?gu8+MiI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Lmu17vfln1KHBQTBzpwDxkjp94KGoZmM74Y7/BxtMlaU4emQckdhn0eUyi?=
 =?iso-8859-1?Q?xP/jlHaLdP/gcKNR4OikUY1r9GApKeafrAIQRCK4famhFZ1LBoxTSFSLqD?=
 =?iso-8859-1?Q?EA8LJe3jbVKzfINF6ghLXmkJrLKBsjtQACR7nkohmAXqqjHEvrtrkudxm9?=
 =?iso-8859-1?Q?LG/CCthsg3GlW1yY2TL1U4403Cp5VhaF/B/IeF+kjyzNRTFXCZiKNkAC14?=
 =?iso-8859-1?Q?lZOuz1if9Nx2wVh7vJmY2q85KhslD670eqMKkUDpfvcGVAoILw4k0sqauH?=
 =?iso-8859-1?Q?QXVe2sNZ84oG4VaqprtJ7hMpF2sff+0azaCus2roySoFGValvM+gkrM1CW?=
 =?iso-8859-1?Q?zwRReyJ/HwNbWCdcWUcIW+n7FHluQ7kIgXnPGnqF1SQlNiKSP/gZ4zTC1g?=
 =?iso-8859-1?Q?rpfZMZMyZZRcifm4YTA6vpyHyab1uBC5QE0p01+Tm2yaASu1c7hlD8+7fY?=
 =?iso-8859-1?Q?p4riFTMoL2Ozf+nHwmHExRc82g95gSO9sS5UG85qcS16cB566u5QeTcvCt?=
 =?iso-8859-1?Q?y2OUvr/uXEBACivy2d75TN23uQ0rUu50V53RpKA0zp9Y7l+/Pe3oe+ZWlE?=
 =?iso-8859-1?Q?9t27oW48Rnh1gv9FIqn1PUmW0ei9nABbKWY09LSpg3mFl250yDAxFqSGZa?=
 =?iso-8859-1?Q?o+Df/KpvZFBDZ2OUUa8aJp6W7fWoI2LvKijDlALsrhi1p2ftJN9qoESidL?=
 =?iso-8859-1?Q?rsPL/ppv7gyuV76A62JNFRJSOcj+pXzB0bxDfyQt8pN1Xci4/tA3nA9v6u?=
 =?iso-8859-1?Q?50sanDo/LbhtPdt1N4oeMewfggxONa2ntivPwXUqcAwbeVhEVJJzv/gfxn?=
 =?iso-8859-1?Q?VIYY96QHqhyRsCNxGWrvByAUZqXUV6tPGk0sYxo7ZRThALfrD4+wSrQhEk?=
 =?iso-8859-1?Q?HKkhwsvslhUbE/M5RixfxbccBr1912Z1UdP5iRH4+nlxBCsQh8Sz/DtI0P?=
 =?iso-8859-1?Q?Z7rNwWpkY6qDs2bTILvcLR/TzLcuMP6hK5w9eCVHU/JvWJH1Wn/iU9kTXz?=
 =?iso-8859-1?Q?8as1R40XneDq/VqsJVKubQlhf4okTj+7qSBsIgSWwarvtgVkBuQSTLG6b7?=
 =?iso-8859-1?Q?C7cjBzLdouhgHZYXomqJxrINu+giELl69wTBjeys8tmHGpcFxPPckgmc56?=
 =?iso-8859-1?Q?zL8Y2TAYVqITKtnE5XcJyaSJ5IP9mzSq87Kr7jdvIeQimJJoO6Ujdruq+9?=
 =?iso-8859-1?Q?TlRMo8Mzo+ZRvTo4lRiUMJCS5ger2WmY1XOyqY3izUlNmCeVCoQLTbBi7m?=
 =?iso-8859-1?Q?X6PFobmc/IKDxRbJznnQEx6aK8gKe9oiFwYFatFEmb+rEDxbGGrKoZetsa?=
 =?iso-8859-1?Q?t7Gf2jhgag6ztBzU/tjlONYrNa+UMcv7uJj7VuhFvyh28IiKLNCrRTapob?=
 =?iso-8859-1?Q?qCM97+46frQgJ+a1HUjk/zg+pnSbr36wZd8jP+ZxCD0kzpVDx5/LfWAEnz?=
 =?iso-8859-1?Q?domL/Fv42JltFVWZ3xKg7OVlsD/CubSQWkoex1jr/53GIiVZMofRIknWvO?=
 =?iso-8859-1?Q?hyMA+9r6OCe8+Lixs1FKVFWMtZZWz68ZXswj4rZvtSPM+1fn6Twn3UWnc4?=
 =?iso-8859-1?Q?ieVdb3mPc0HF4Q/m4R1HzotbE5j90DbAunC+G4nhKXNn38m9A6a48TD45Y?=
 =?iso-8859-1?Q?qcEVvEu69MD+kPfLUz4Jmud71VA1xdpQP5SzwJpx6KpLGKFgJI9Yaykrfr?=
 =?iso-8859-1?Q?M+dq7nM+M69yNuie6D4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea75750a-da78-450e-f425-08ddfb4b4f0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 09:18:18.6549 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tEYHV/TClmjdWKSBtzdL0B2+v4gzqR8bMIfm2xeWOUTG75Qkb0UuM2zzdJKTAgdo3MInszVOlmeo5V1hCRK196MDRE5768O8Xa+prhCAIzA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR09MB7826
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

Add functional test for Boston AIA board. The P8700 RISC-V based
CPU by MIPS supports it at the moment.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 tests/functional/riscv64/meson.build          |   1 +
 .../functional/riscv64/test_riscv64_boston.py | 164 ++++++++++++++++++
 2 files changed, 165 insertions(+)
 create mode 100755 tests/functional/riscv64/test_riscv64_boston.py

diff --git a/tests/functional/riscv64/meson.build b/tests/functional/riscv6=
4/meson.build
index c1704d9275..9bce341b80 100644
--- a/tests/functional/riscv64/meson.build
+++ b/tests/functional/riscv64/meson.build
@@ -7,6 +7,7 @@ test_riscv64_timeouts =3D {
 tests_riscv64_system_quick =3D [
   'migration',
   'opensbi',
+  'riscv64_boston',
 ]
=20
 tests_riscv64_system_thorough =3D [
diff --git a/tests/functional/riscv64/test_riscv64_boston.py b/tests/functi=
onal/riscv64/test_riscv64_boston.py
new file mode 100755
index 0000000000..0527571847
--- /dev/null
+++ b/tests/functional/riscv64/test_riscv64_boston.py
@@ -0,0 +1,164 @@
+#!/usr/bin/env python3
+#
+# Boston board test for RISC-V P8700 processor by MIPS
+#
+# Copyright (c) 2025 MIPS
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+
+import os
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import wait_for_console_pattern
+
+class RiscvBostonTest(QemuSystemTest):
+    """
+    Test the boston-aia board with P8700 processor
+    """
+
+    timeout =3D 120  # Timeout for boot tests
+
+    ASSET_FW_PAYLOAD =3D Asset(
+        'https://github.com/MIPS/linux-test-downloads/raw/main/p8700/fw_pa=
yload.bin',
+        'd6f4ae14d0c178c1d0bb38ddf64557536ca8602a588b220729a8aa17caa383aa'=
)
+
+    ASSET_ROOTFS =3D Asset(
+        'https://github.com/MIPS/linux-test-downloads/raw/main/p8700/rootf=
s.ext2',
+        'f937e21b588f0d1d17d10a063053979686897bbbbc5e9617a5582f7c1f48e565'=
)
+
+    def _fetch_rootfs(self):
+        """Fetch rootfs and fix permissions"""
+        rootfs_path =3D self.ASSET_ROOTFS.fetch()
+        # Ensure the rootfs file is readable
+        try:
+            os.chmod(rootfs_path, 0o644)
+        except:
+            pass  # If we can't change permissions, try anyway
+        return rootfs_path
+
+    def test_boston_boot_linux(self):
+        """
+        Test full Linux kernel boot with rootfs on Boston board
+        """
+        self.set_machine('boston-aia')
+        fw_payload_path =3D self.ASSET_FW_PAYLOAD.fetch()
+        rootfs_path =3D self._fetch_rootfs()
+
+        self.vm.add_args('-cpu', 'mips-p8700')
+        self.vm.add_args('-m', '2G')
+        self.vm.add_args('-smp', '2')
+        self.vm.add_args('-kernel', fw_payload_path)
+        self.vm.add_args('-drive', f'file=3D{rootfs_path},format=3Draw')
+
+        self.vm.set_console()
+        self.vm.launch()
+
+        # Wait for OpenSBI
+        wait_for_console_pattern(self, 'OpenSBI')
+
+        # Wait for Linux kernel boot
+        wait_for_console_pattern(self, 'Linux version')
+        wait_for_console_pattern(self, 'Machine model: MIPS P8700')
+
+        # Test e1000e network card functionality
+        wait_for_console_pattern(self, 'e1000e')
+        wait_for_console_pattern(self, 'Network Connection')
+
+        # Wait for boot to complete - system reaches login prompt
+        wait_for_console_pattern(self, 'Run /sbin/init as init process')
+
+    def test_boston_7_vps_boot_linux(self):
+        """
+        Test full Linux kernel boot with rootfs on Boston board
+        """
+        self.set_machine('boston-aia')
+        fw_payload_path =3D self.ASSET_FW_PAYLOAD.fetch()
+        rootfs_path =3D self._fetch_rootfs()
+
+        self.vm.add_args('-cpu', 'mips-p8700')
+        self.vm.add_args('-m', '2G')
+        self.vm.add_args('-smp', '7')
+        self.vm.add_args('-kernel', fw_payload_path)
+        self.vm.add_args('-drive', f'file=3D{rootfs_path},format=3Draw')
+
+        self.vm.set_console()
+        self.vm.launch()
+
+        # Wait for OpenSBI
+        wait_for_console_pattern(self, 'OpenSBI')
+
+        # Wait for Linux kernel boot
+        wait_for_console_pattern(self, 'Linux version')
+        wait_for_console_pattern(self, 'Machine model: MIPS P8700')
+
+        # Test e1000e network card functionality
+        wait_for_console_pattern(self, 'e1000e')
+        wait_for_console_pattern(self, 'Network Connection')
+
+        # Wait for boot to complete - system reaches login prompt
+        wait_for_console_pattern(self, 'Run /sbin/init as init process')
+
+    def test_boston_35_vps_boot_linux(self):
+        """
+        Test full Linux kernel boot with rootfs on Boston board
+        """
+        self.set_machine('boston-aia')
+        fw_payload_path =3D self.ASSET_FW_PAYLOAD.fetch()
+        rootfs_path =3D self._fetch_rootfs()
+
+        self.vm.add_args('-cpu', 'mips-p8700')
+        self.vm.add_args('-m', '2G')
+        self.vm.add_args('-smp', '35')
+        self.vm.add_args('-kernel', fw_payload_path)
+        self.vm.add_args('-drive', f'file=3D{rootfs_path},format=3Draw')
+
+        self.vm.set_console()
+        self.vm.launch()
+
+        # Wait for OpenSBI
+        wait_for_console_pattern(self, 'OpenSBI')
+
+        # Wait for Linux kernel boot
+        wait_for_console_pattern(self, 'Linux version')
+        wait_for_console_pattern(self, 'Machine model: MIPS P8700')
+
+        # Test e1000e network card functionality
+        wait_for_console_pattern(self, 'e1000e')
+        wait_for_console_pattern(self, 'Network Connection')
+
+        # Wait for boot to complete - system reaches login prompt
+        wait_for_console_pattern(self, 'Run /sbin/init as init process')
+
+    def test_boston_65_vps_boot_linux(self):
+        """
+        Test that 65 CPUs is rejected as invalid (negative test case)
+        """
+        from subprocess import run, PIPE
+
+        fw_payload_path =3D self.ASSET_FW_PAYLOAD.fetch()
+        rootfs_path =3D self._fetch_rootfs()
+
+        cmd =3D [
+            self.qemu_bin,
+            '-M', 'boston-aia',
+            '-cpu', 'mips-p8700',
+            '-m', '2G',
+            '-smp', '65',
+            '-kernel', fw_payload_path,
+            '-drive', f'file=3D{rootfs_path},format=3Draw',
+            '-nographic'
+        ]
+
+        # Run QEMU and expect it to fail immediately.
+        result =3D run(cmd, capture_output=3DTrue, text=3DTrue, timeout=3D=
5)
+
+        # Check that QEMU exited with error code 1
+        self.assertEqual(result.returncode, 1,
+                         "QEMU should exit with code 1 for invalid SMP cou=
nt")
+
+        # Check error message
+        self.assertIn('Invalid SMP CPUs 65', result.stderr,
+                      "Error message should indicate invalid SMP CPU count=
")
+
+if __name__ =3D=3D '__main__':
+    QemuSystemTest.main()
--=20
2.34.1

