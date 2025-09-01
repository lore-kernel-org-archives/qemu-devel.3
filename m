Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D62ACCA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 10:32:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut1n8-00041Q-3x; Mon, 01 Sep 2025 06:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ut1n4-0003xo-FK; Mon, 01 Sep 2025 06:29:34 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ut1n2-0005KU-DJ; Mon, 01 Sep 2025 06:29:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oEYut4EqBYzYeM7Klxfpu3OJlkXgmZZUIC0uHpxaJwoGtzbaHJuBW3g7MlYNidHsmwmrLF+rVrQQIeTxse0w/wLsObI1g7RXSUDWc269j75dcPe78jBonj4RiBTby/2qVs5+FjvxTAcxKZyS+J150MyKHAGz2gvirj5Jy+fb25wO4n3CssLCV2XDZhAJlw5Crgzzi6KiwWkzeYe1mXUTwbPVHf+T8SOzWkmQlGYSDt0k0o9fQ4OBUC2uA7JVbsgbul4xSkYlNnTcPDhIm0bNLJ3dGT3ccv2CP2f4aJFny1R5ZiLq489yQAwdnIS8Z1FTj2HAZCIg9iLQJzUERV4qQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0H3mtfTxP444XZaqpQ4BNzALpxnjQDw7Oc9qtvC86Q=;
 b=t4p2gt7giHaiVWtW0Yh8dT1JJtlNrVPnUpwgiQLgvyxV1vbfl9wjhBCO6q6hMNM2rP1NpzQCNrYfekXDT/9YpTFps9bmgQoq2w82mcJpKdvwvAdWvEugc9zWfxczFlDVOO+PzAmXRsv0uGWZoGiXRfjV+mUma8zFAE1/VRpTzKJO4C6LPrC8wqBb4g9MfhAEe07LaVJdOW945c1L8OWAxr/nnTdy34zjKj2vrXYOAOvOvXoYoDx15dPf3/5aghMdJ36mvmqWZvy4tJZkmiOg0dCCrUqNx2ndV8t2TGoLv3W1ySjJaACHLnWMj+MimlP9AAIY3BLOFuxX5NeS7gIC1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0H3mtfTxP444XZaqpQ4BNzALpxnjQDw7Oc9qtvC86Q=;
 b=afm4XpBACYysselO9ZbFhAowxsuATPimHZdm4CMQ+Dw/U40gNxGGC5zXbhUmQbDM2VqvBjA+XCe6Ir+eyIAMosgUGEWwkuxovvLCEVPijIJ7fQ3FeWmqocaWpJQLgRUoVoml0LI+8ToxpZZo/hhvFodJfhpvpzcGsM2Kxrfein8N9s5WG1MDEpI9sHFI09Mk5YGLUUZw73HA8dyjXaFi+xeS8gywXNrGaUCkAlsyIahoqEv523pnIPVZcWHle6cuTz6VaIIbJVHkB/bYgf1EBJQC7c5xWbMpaVUOxPVcblN2g4MuRoAcqeW6EFVbX8G9qbcyUM+aRv00TqKUMeEN5w==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by GV2PR09MB5992.eurprd09.prod.outlook.com (2603:10a6:150:be::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.28; Mon, 1 Sep
 2025 10:29:11 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9052.019; Mon, 1 Sep 2025
 10:29:11 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v7 14/14] test/functional: Add test for boston-aia board
Thread-Topic: [PATCH v7 14/14] test/functional: Add test for boston-aia board
Thread-Index: AQHcGys/9tuZz59UK0Cs8j8iKyR9Nw==
Date: Mon, 1 Sep 2025 10:29:07 +0000
Message-ID: <20250901102850.1172983-15-djordje.todorovic@htecgroup.com>
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
x-ms-office365-filtering-correlation-id: c3f8b996-3da0-428b-3f4a-08dde9426401
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Zdj3IfdSYoVV6w93n+UfkMs3Kdktnmycyr+ynjeTVluB2dWNZtHe4kwkAH?=
 =?iso-8859-1?Q?rw+KL8bWTdlUvxxAFQKH7PgNrUrNrwZ6Ed3Mg81n8Kfp2rJsuOXu8dnB1r?=
 =?iso-8859-1?Q?MZa+5x+/HuhrdHpri5jI1e3xFdpuO5En+3Nlm4IynV0lFbF0AchRPtnfEV?=
 =?iso-8859-1?Q?Tizjnbjl4veKybvvUtuaXPLRrZSWy4QiTLCO5Sc6cmLvY8KA2ZXzr+sQbu?=
 =?iso-8859-1?Q?qHsfwTUqHcZf5h/AXwUqWs7nwXd4BKrr0IXI6hcRqMNpC2roJebAu3ICgw?=
 =?iso-8859-1?Q?1Rcuyz7Z8cbr3EEGOfX2x9JIVUehKKdTmOj3sDA00kEaF+jb7CBOuKQWGt?=
 =?iso-8859-1?Q?Iefk7XePxoFqidKqDe/afU9m+cYm6XUHJ1oZam0H+WtcF3TKMKk+xXVCF1?=
 =?iso-8859-1?Q?rlq4HgH/k2v6Y0I6TVg5fcE5lYZ6Nr11dNkL86DAn2tildVLqYyzO5Jf3F?=
 =?iso-8859-1?Q?xZc2CRcBGADO1UfbLk+GojRh0Im860Z8wHUS0P/BU6ITYpSf5aDLRzW1og?=
 =?iso-8859-1?Q?Rn7so+7wu2Aa0mUBEMM9d6zpkvl8bkbE9tpU3vGkyKX9Usrkll+P11v7Nc?=
 =?iso-8859-1?Q?a0ot4nzuJtHvBnGZaPaNtSttc7BdduJwA6eWQ8OnzI+K6ytCqcFuyAaLfj?=
 =?iso-8859-1?Q?4QKgBESrpvCfvtti679VKIXsdYP2eWDp/b4BabrJXqS5YJ9Yo4lg1XJgA0?=
 =?iso-8859-1?Q?K9oim01vjE2N0TbsqFEXgfl07ZN4gndbGSvzdqDdbh4Og/1ioCkJo6JqAy?=
 =?iso-8859-1?Q?EWSuKNUOf8iYCQWqvJi/Sv9WEX+TclJahZU3WGdcms4t/V1lIDVcSnHZCK?=
 =?iso-8859-1?Q?168oRqnE14bfh5FpnxhQuV0ZzL6AMBKoJb8lKOsu2DP3Grw45dCTNQeDjL?=
 =?iso-8859-1?Q?+m9Y/swzgUy0DiYfAa9Yf1jaBmJRiwoKs/oKMSeE1ctK83tp4pUCm0l05g?=
 =?iso-8859-1?Q?nWnrHxCEDnSSyeDx+DYoYC+l+SNg3zReaQqjSBpgbxdyMuOR3IcwOobGPL?=
 =?iso-8859-1?Q?m55VDPjTMTg+WyHbNUKB17QRU5YbKBrceBLdt0nfdoeJ+mZYFKuFIBrA9A?=
 =?iso-8859-1?Q?G6gDQwsVfnujvdgtaL+dUs/USpv8qxm6Tpef8ehbe0BdDkgRuWNG2Pgmrv?=
 =?iso-8859-1?Q?ozyKSmft/5Uy/x82MybOAK36FYJdZnPflFa5/5D9YwQU40IB4Lc6ZRLLl6?=
 =?iso-8859-1?Q?jIDy2jPmbChRs7gO8eA6n+7TpI97OosVz5ZBol3i/ZDPb2px2K0QGCXd3u?=
 =?iso-8859-1?Q?mB6f3ZJpZuSGlU0vNd7zL9/D1JCHSNGKjemyjZtF9OjETPZS1p84w5y/yu?=
 =?iso-8859-1?Q?XwM0vMibCLSxhoWpEHPDdayVqkZ24wqxI3vlWubKEYvrf3YMT5DYqdOS2b?=
 =?iso-8859-1?Q?QmOQVazDC3FXEMGDqA1PcBeId1mX20ldZwcq3MAubb64J7GThxVxV/ctoC?=
 =?iso-8859-1?Q?qg/SEATpcVHYp0jnsou08vIzc45zR2CL7njr981rcLACQD06XZm6ZNROLR?=
 =?iso-8859-1?Q?fo7utSvmB6Fw439tXfylcQT4o0t5L5xZJRU5ExXAtMlp4rJxB+c9h14l+7?=
 =?iso-8859-1?Q?rimw8K4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JFgKsyaVp82hVF3eG5rhD+OL/Bd3xoTFMvdrkGXXMY82HiT+a299paIEVh?=
 =?iso-8859-1?Q?sScospvC9k4XDIcrQhnNkeIFwOoB6Sll276uJQccSBlCr+W8u5SE5OhxNQ?=
 =?iso-8859-1?Q?uB7MiMn3PGXnd2atRg+YgyJUOOD+ZH3ynCcy5xbhGIriwc/QePEyonj9s7?=
 =?iso-8859-1?Q?t7e20be0uKOJSjK+50LLS8pkQ+DeZmbtmueCQcn8eTMldawPiY/9OROFPS?=
 =?iso-8859-1?Q?WlorZrX3ern/FOUEk6tCcWlAOdOpE8kBqhpJ0MZWb+w+swmx4EKG0gHIhp?=
 =?iso-8859-1?Q?siAmzLWB1RKR55ImytnR2nppbr8LKHoS7L4ps1B0+sMEfKTPdhSxjRMAAN?=
 =?iso-8859-1?Q?ycnZ69C3TDtx3jCXSkJqedsCfSmfNf6wPH8OSW4KfXo9B8SVcqSgI8KI9z?=
 =?iso-8859-1?Q?q0rQmCAAPCSba6DH3ALFAA7E8FMqsC0UMjHw2mX7Uhod7ktX33uwQsZmOz?=
 =?iso-8859-1?Q?r9V6It5zsxhqkQzfLQ0Ar6yAQ0nB4bHrnidm7q8P3/thjqOSLfLlvB+mcV?=
 =?iso-8859-1?Q?v14u9OUw+5rzTVgZweMeRqGDMGBqpqd5rapAvse1k18a/E3o4RzDs9RBLz?=
 =?iso-8859-1?Q?D9gA7pCqxWX419q+GkZ4rKzYU7KbuZksNkX4qzDMS+GwZ3bI6l+MzuxB+Z?=
 =?iso-8859-1?Q?EVUllHqmA9E/KQ4/yo6tX/Rka42XLdAF6AvVe78ha05YQwVdI4Oq9Kvhwc?=
 =?iso-8859-1?Q?8drDOAahR4QbUZoGw19ceAU0Wu1wZuNHOXT+R9h4/pxohdBm0urcyJGUJ7?=
 =?iso-8859-1?Q?Zfx4bFruVBJUaaJT0SVzRNsCuEQ9sATJDn6uzO+3RQexKlXFuHofmKzVCW?=
 =?iso-8859-1?Q?QjXqiqxvhav/pq6CsS9zJyRznQro4FpcpRR1qRjjnbYD7n9c9rak51IdyJ?=
 =?iso-8859-1?Q?cUpVZzS+SMlLC+H9/Fi9Q3SxE9ayXG1vrUA6UBeaSaM4pbOoAVrlJVR68+?=
 =?iso-8859-1?Q?dOBe/8DV+whiISXNhQbabB7Om5DgsJfFT0Uc9USAzTA4lc6YGHHxIYxxO4?=
 =?iso-8859-1?Q?jVjI1Pl79IvtzqYr5mdn9hjGxVo3cirHKkiUAaLZiM1kU9LTuZuf/2AJmq?=
 =?iso-8859-1?Q?iwoxXlQx2rxY+/DBvuCuJd40hnbtvQcJU8wX/cqjNNI6fjSvx++OomZa4M?=
 =?iso-8859-1?Q?/2uRDJZ+LwCuzLSHvgckB6WmBwfKOkyUXJRLGntiOpBs7J0+TdCPU4jICB?=
 =?iso-8859-1?Q?1DQjVbH8OH2WdlPHVVocZYR7rr89IOYRqcMICTPYv5jFYnhICbwPc7+pVI?=
 =?iso-8859-1?Q?HvPMC7Ahpz67XGfBVBBmKUfs8IUZXKlsvAQhny17cQPxXOzrY5bNR44hLm?=
 =?iso-8859-1?Q?afhCiuXQmRTRwjj5vG6YqdSaxq4ffbeNxjfHqHgrJucCPOuCK7bPDytSUp?=
 =?iso-8859-1?Q?J/LRTmCj/4N1NavKOSMKESB/RUcFGwsi1jdbYD0CUY9IEZyFETj5s6+Vxn?=
 =?iso-8859-1?Q?mTdcnhnEYXpGr7EsXcPdAoiHCxrdLVwuPw+nS8EW6hODU3TiGfx2n1I63X?=
 =?iso-8859-1?Q?JxTtR/hJKLsqv3T0z6sdpi7CEJqjwjo/cXtatgt9b8rBEPGZjXOipAdR9a?=
 =?iso-8859-1?Q?3ptr0zdGZhhTfKyegABjgRp0nwg8tBxl2i1+NbLc7T6JKH+wyz+xOUORzt?=
 =?iso-8859-1?Q?slkKeUkNwZmTbIx32YxGfHdhd5eJiD40LypGSn8PHrR1ZUMMnZZEMV8/8y?=
 =?iso-8859-1?Q?v/SjlfZ6dJWGPcu4wAc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3f8b996-3da0-428b-3f4a-08dde9426401
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 10:29:07.1056 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G8fdB2A+u8KgPSeEDMQmFpjjCiP3DbYJ9rXzB5iGGYqzBPCjd0ScwoPm2r2vVjTo15T/1FNq0aFqo77ZodX7/godDugUbR3h2rBzV2LpB8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR09MB5992
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
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
 tests/functional/riscv64/meson.build          |  1 +
 .../functional/riscv64/test_riscv64_boston.py | 71 +++++++++++++++++++
 2 files changed, 72 insertions(+)
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
index 0000000000..ea4e144cf2
--- /dev/null
+++ b/tests/functional/riscv64/test_riscv64_boston.py
@@ -0,0 +1,71 @@
+#!/usr/bin/env python3
+#
+# Boston board test for RISC-V P8700 processor by MIPS
+#
+# Copyright (c) 2025 MIPS
+#
+# SPDX-License-Identifier: LGPL-2.1-or-later
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
+if __name__ =3D=3D '__main__':
+    QemuSystemTest.main()
--=20
2.34.1

