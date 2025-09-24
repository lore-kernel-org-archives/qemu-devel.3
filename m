Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26BC9CAC5B3
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 09:20:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1LeX-0003nT-0o; Wed, 24 Sep 2025 05:19:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v1LeS-0003hS-Fn; Wed, 24 Sep 2025 05:19:04 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v1LeG-00030I-NE; Wed, 24 Sep 2025 05:19:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ww0bb/nHh2CEhA+SKrC3n8hhcwUOJGi6PhLUzZWIU0eYgDnwNBKbFK/Yy+H0XmiRRP/djJfdL8TVpqSM1wdLgNTIIJFHSAQd/LqJD25NxhMIdcbvAK7Yz8UADmBwVfNqEoSWqUZWFgV6ofwaNX7fMrFexCU6l/K1j8TM3n9Mtf418Y3pYqP3pkoO6+wmGFYmC09ZISi0qz3/MWCJmVIjVjPJzr6LIU6LiQePAMcl0/d36XDppHCj7OWHoD9x4OfnB+3Jw5/S/LkCSOIxyA5G3ENArNE1Z21VeMZuoa9vQ7SfRwoSWzy4bhdmCE2jpr+nokKuvm6vLdB27MAn0hzWCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8kb9JU86YyDIslZHnP7VhlS0I3bETdVR9b1Ej1Xkwg=;
 b=vtYFMmqJgjZ6fH4FHE7of36TyEFFDbUUBVFHrWheMDn5PycJJtLctpBxxPEw/KCkDcTdCH8t+SX5Inflit7ROJN6GP1B2iHESyEwGyzK96JS5oJEpqmeorqzobXAsjZKz3QwvcdD7TOCW1D2rVxQ8eDwMMsxJE99zY7HwsxbaqnxpumfQEuUWS60q7vppRMcbMhcpNqqikcLy9PAOUOcWk+3Hw/VN6+jNbYZ0txFaXzjY+PDFaPayrFUip9QcW8h49zXDDhmAMwcu+lM64O1DyZ0FJR0aZfTJCTK8XT65f6aPU8hcluKAkBin3hhO/OMc8AEo8TJSEjOYfCbx26CFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8kb9JU86YyDIslZHnP7VhlS0I3bETdVR9b1Ej1Xkwg=;
 b=N0cyiyy59+D1L0VNuvygW1n1C0Dx6gmbfcKmTImR5gnQdrt6/KOCbE8si1WSet7AxCnLgkoFWh/eU5Y0E3ekgBty7Xablci0x10cZogOyiahDWUnf4tERz3R7X0eD6loMV9N4zthuSQiiZ2tITbIf/gtzzpc/YRcSYX8bTk0UER/uoLsy2bekJx9ulF6xHeisk8Tn01+hN3RMfqdpQH7z/LJEzUQBpZ9wOzJ/IyoO2Rw1EjmCzCfOhDpW72ARR6+9k88f4kM6DUKo0pz3xy9SBg5Tle8l2QX3ExiTDOPwYdINygg+Dk9GvzsZ+1RGnI/P2mWt/+5U8aSjLxlAzg9og==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by VI0PR09MB7826.eurprd09.prod.outlook.com (2603:10a6:800:21b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 09:18:21 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 09:18:21 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v8 10/14] hw/riscv: Add support for RISCV CPS
Thread-Topic: [PATCH v8 10/14] hw/riscv: Add support for RISCV CPS
Thread-Index: AQHcLTQpJKAIebPP/UahSxgBch40Bw==
Date: Wed, 24 Sep 2025 09:18:17 +0000
Message-ID: <20250924091746.1882125-11-djordje.todorovic@htecgroup.com>
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
x-ms-office365-filtering-correlation-id: efbe0b6b-efc0-4ea7-8e75-08ddfb4b4e42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?aG+lpeuYhahb6ekDIUdmZetTYhOE2hxQcJeifQlVZcBM/dEksCwKssSDsH?=
 =?iso-8859-1?Q?97718EvMWsK+AOHhg2Mgq/TeMK58ERwKJXuGaG3UbMYtwMCaoGc2C3DfRk?=
 =?iso-8859-1?Q?9RfDeKU1eYKFjPk00Sei6HotTaytdqxxUY6bChmG3rVUvLhnG6GQdGRNGB?=
 =?iso-8859-1?Q?sVVsjiR0gt47uD/EkCP++3aBJJiD1e1ksTkHSb0tSsUDaxO1JYUTuqDFAK?=
 =?iso-8859-1?Q?hapA0kCVp748Zru4gns51V7dnn8i8PxIPb5buy1NF/mdwi4VfyztacoWMg?=
 =?iso-8859-1?Q?3f8p11A3F3kZvSYDI1y7jFUVXhbFTTEySQScBp1MQOv++h8HRoMy5ngbY+?=
 =?iso-8859-1?Q?lzTpLfarYXKlm6tPVRjSpI8pzIOZR/V+oIhBvqEI1u+FSw9QmQXl/K1gt6?=
 =?iso-8859-1?Q?tX/A3lTq7Olt9oLIiNowzEF2C1voziLda4TAIXAUhU1EqtZkPWuhwdtBz3?=
 =?iso-8859-1?Q?OiSqzO+Aj0TU6UtkWdKkPbTR33vV3f7LKknxPHDui9pBFoO3ULTYCMMEb4?=
 =?iso-8859-1?Q?G3jiFHb6nLrBrMqE7wqmJaGXJJpo4xaVeb4u0rnf7+F3IS6HGgNNYzq2xa?=
 =?iso-8859-1?Q?6zCo6JEIad3zfXyRuAsu/x7HZgpepTLjfZo9kbvgBdKt41CTP+bvFFhKth?=
 =?iso-8859-1?Q?sEx77ej+v6tug8PE+Dy7NB5ROEZbeOiUO/CBMhBlE6p3X8ioq08IwRJ+QY?=
 =?iso-8859-1?Q?WLIYTBgrr7ChkU0snXQq0kDvD2Aa1wLgtQucyvAqpz5JhWnQK0m720TIso?=
 =?iso-8859-1?Q?zJlAyRZlSBRkuG1MhjSTMb68N7yTLx8C16ayUnYsxfveBO1IJs5v83h67r?=
 =?iso-8859-1?Q?JJE7tFwrc0fSVTcVasCgltdSnaeiKf45L+wWjYSolgzjXrM2sGjBig3fdQ?=
 =?iso-8859-1?Q?tT64BZzHU5Z0ivBsy507IdsqPBeZJvpdU1C4zdS+rM3TAmmLX5iSzd+kRt?=
 =?iso-8859-1?Q?9lpz546kA/zIMsgIaIH6hFNNN4KnK748zEnjiTxUXXP169514K/TBv77Qr?=
 =?iso-8859-1?Q?1yh1l0fNd0+gUxLJV2yEnBjHkGUIu5n6vieFnLeSVoFZ1xueOlAYcAf5tS?=
 =?iso-8859-1?Q?s8+D488IKnXmBwza9JeLsxxOlk4i9K8nsHsz8/oc3zngapW4nZ9wNxqbpY?=
 =?iso-8859-1?Q?Rn9JBpWOXH3b7/jHpJ7nGKgCkU+58NOdL9bEowgQi4crUhlCEvThQmcuWT?=
 =?iso-8859-1?Q?IFEtyBwAQlISCrQzvSh1Iy9hMGGFXoLYaainGnrD1MxoI4HQilzzhYypW6?=
 =?iso-8859-1?Q?AiyEXYsNb3s5cmzrgNjnugiSJjE3HDH49UDVW1FNwfU47WsCtTOJxJxkq7?=
 =?iso-8859-1?Q?tvb0gaI4GDx+OQe2lzo1ZL8Waw6DM/cLjYtkxygjJtUWV+UiFEd70AKThS?=
 =?iso-8859-1?Q?D5FuZFyYmoWNj1V9oc2uqz0vXBfzD19498FFkl3uR9H3WMR8v1U+xmYy/+?=
 =?iso-8859-1?Q?s6RojiZZbaBObJ8gCEyACAMTmBZvl3usbBAYulb0/lb2DKiZfcDrSpSH8P?=
 =?iso-8859-1?Q?zCNN4uoLtGbRVwg2MVLseP66QOjwcNJyHc0QEkJ4TipA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?z3Pt4ugK/UEYsski6meSFFuK3di4L52v35oMb7yqj2Kr4HSUOq9SJn4esX?=
 =?iso-8859-1?Q?TPkeoWo/T5FuqRdxN1Qzit3K+JR4MZVL5Ea/03+ojL2rZIXPgvFk/uHMB7?=
 =?iso-8859-1?Q?LU8W+p53dGcq1hN1nnffryj3T6xlhAw2jm5d2//93gdmuzY/FLi7Gfs69D?=
 =?iso-8859-1?Q?8CQ7mB091VsrvAoryttMI/Pd28dfI/tV/A22LWFuuHyskeCyctzEKCx7Eu?=
 =?iso-8859-1?Q?IwZiry865YuS8ssWMcAmoKzYg05ra7UxMUKehkuqGswn1sew2S3ukAilNJ?=
 =?iso-8859-1?Q?aTXkU1bgpqmHB9cPtKdjR+9wW7iCbPGNu3uih5jfDNEzERbaBgjhnBkC2T?=
 =?iso-8859-1?Q?RYMXKLLTSKkusA5EsS8fMSy3FokBkHfP1gHBLh8ddKCU0D8lhG8BYT1zvW?=
 =?iso-8859-1?Q?8LHpysXgVEAqvKMOq50X5+9UlMYfC1ueY0nY8Beq3jqp1Q3pzCfVyH9pun?=
 =?iso-8859-1?Q?VbQcYASOhcreEA7ICdEia1rCQGvIkqy3Na2jXQZZ6C/paUCYbQJMYfh5yT?=
 =?iso-8859-1?Q?iYYg2Sh8RCJOlWOYDE+1ouriGts4lr71qsXYfdKZJMGNIYQd0xWe6ntH72?=
 =?iso-8859-1?Q?ypxaZ7iffDHFLCfjXkn9/F2LrYFNc3WcfiHawdpJdpGbAJKKc4jpjqg6zj?=
 =?iso-8859-1?Q?u9XrRIvV80E9iSdZ0DPI6Qlp7kAsFkwlvD2BGrx5+8Dvdp75G9PnaUEorr?=
 =?iso-8859-1?Q?W3kM1C8G1nmJSWGPFcaYYktfXyGsQsGfMII5iefuIbcozrwR0FF5t1kqcN?=
 =?iso-8859-1?Q?hz2tTOn0e5OfkDMdx9DfrMo0eSaNFaY/l+cN9/1TlF0PUkmh8rsM+5wV1v?=
 =?iso-8859-1?Q?Y54Fru6ccfIcFJYX045CokUfeutvnLcIaj1Unsy6h1pEtg0LdFxpMU7hSb?=
 =?iso-8859-1?Q?OUDUV1zxN2lVpncyx00zYVtcrcGCc15USoo5YMoHAiN/GL3jQs1OywGWKK?=
 =?iso-8859-1?Q?+ZFJRFzKw4ul8Vwm/mEry0hrJg5TIidsF5ZFo5+X6BUN1Wgo+zuC6LFAWS?=
 =?iso-8859-1?Q?KFR7xdp5eqxRY4vO8AZrZDt1W38HsPDi1hl6CSc2ggAuIpeLlo/cE/DLZ7?=
 =?iso-8859-1?Q?6UH9Fs12rX27KBS58Y9tLuv6h3u8PFLw0TDSSfOwZK0/D4dJNqtUcl9veR?=
 =?iso-8859-1?Q?8tBGaRA8bGJXccfQ70AkijMNHFUdTYcGcoNtPb8MsbD9bg9kaSMs77tOr9?=
 =?iso-8859-1?Q?pDqphc/xZJZCMNz6CGy58DXi9yKM1+VzHXm2TBoKxGxaxd4zYT5Nap3Mti?=
 =?iso-8859-1?Q?OexNTkQnrt0hdqLxltiaZTyhNLdn9P76LszXmpAfdkq7EdZgwcIZHycMvU?=
 =?iso-8859-1?Q?sSA8EssyVy87R+2M8y9+SsYf9WZCmx/+SVYlHz2YEykjBlyVFFSe2GS9GN?=
 =?iso-8859-1?Q?hw0H8k1hPrh9ifRe5xIXL1kv2KsXbY+cRImQ10IXPNnC9PPv6iOoe7r+b+?=
 =?iso-8859-1?Q?PCRlPXUuEePX0RRkZxeF+yk1Jepm+zXPcnlqC3m3kdpbs04zsbpReYfd5f?=
 =?iso-8859-1?Q?EkHt4JTBNGRFBWQB8vpza3Gw1P361dgaMNTDkart2NwqDpPMFv7rRlnu+N?=
 =?iso-8859-1?Q?XfKp7djzgFVvZn48J3VkD35PgppkZ3YzsVLx1+xUctv+MN19UmHnwQIM53?=
 =?iso-8859-1?Q?0wl6s+XAoTLBR7qqv5EWcmPL+24MNqt1CNpUm0URSVtxU3szkahwVgSie4?=
 =?iso-8859-1?Q?TBbRlKo/CD69ahODu0Y=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efbe0b6b-efc0-4ea7-8e75-08ddfb4b4e42
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 09:18:17.2473 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: utJ/5SF6OsnBu/bUy9rmMBmiULFqOVRGhV4lqrD4DruTHMzVYZLdj5mnBHQm8ADBk2qshbRmvZJfJsKG5c6fZ3eWtcvhicF+ZdR9AtxJOF0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR09MB7826
Received-SPF: pass client-ip=2a01:111:f403:c200::5;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

