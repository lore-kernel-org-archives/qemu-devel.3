Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7AB5C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 09:54:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucLJ3-0001yW-If; Thu, 17 Jul 2025 05:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ucL4z-0006UY-4q; Thu, 17 Jul 2025 05:39:05 -0400
Received: from mail-westeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c201::5] helo=AS8PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ucL4w-0002Os-AS; Thu, 17 Jul 2025 05:39:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NENX9cStZaXf6AW+lr+xbS6Dh+/ZV3Z2Zm3b14sAZ33vfCJBX/czAWNNFIS2Dwzc9L2cg2dQdnlidkn0eTQ81haCOv3zjqAFeV7LYCOUqm1mk4rxN40iLMAeb5py8LBdffMhuOInwzNsc82+Ry8g50sD8uQM1PT16dHo79DRLkFolUzet7z1vZsYETJCJPJALnbsOpfYsFqhX82bxQd4n+wFBupKUed7sjxaKp8wcJIVZLJOPx6JQDngg6B/vb4nE4a29N42iVe2/N6pADCzaGO8QuPfddka2YGIblHpjYothhu6a1VqGFFGmDoRm8GGRlGizGdwbzF+nxgj+73CxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BiUurYKRZYEnbQmGh5nKXILd1J/krURv2L8YnkESYZA=;
 b=qF6PqqlKW/g/puhYQINrtfOCtRX4zK9z+Gp4MDd7oaMG2pZmnniHOPLXbr++HlhCPnSK+eiwQZxg4Gf2z9wYhqvP7ex4mNbEjDjZYsbBInr4+RfHsPAQn1GKE9Zsz+VHbh+FsF11V2Qusl29BW/jibcuhj16mBbi7OjpeX9GurTAnmzF8ScF0m6NHmXJJI0XcgzKPUZ2TXYc1kYlKuC34jPQgYipWTmVdLIcFIbdfV7iTTKQtv0HZ/0HT9tnzGwE/3+zPwQEuRvQj4vMxImiKxLNvs9dvIu9DrtCg2SzivArtGcPnh428ePa4x8uuh2UgP8xGVH/R8I4FDOgA7td8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BiUurYKRZYEnbQmGh5nKXILd1J/krURv2L8YnkESYZA=;
 b=jWtH+IqwFYNNjPfaWa4WtJjZraclGttcs+uBU4A6LThFWfXOJVAYnJny7C8pQ5NDALagd1ak4ML0K3Y6mGjGUeCS3n20Nk3416j1OLBz9fBvk0gR5+ggiKvWlDYUN3UESKDHagUNkFBtq4fQm2m6pTY/crW+SoRwmOKjFIrldzNKJfybaJ2IMsNzy2wjrNQCmvitiYma83YfhLFHhqvzzgn3e19NnU2tIqPSqrZ2r3TIiDUGJSq1pvqiYbnZ4UoReM6wXEN+thMCDop6x6mzoi8pYPZBg4aLXzEXNFdfV1h5tePqSSzW2V3rC+csmef3iVxhX12mBosSrp60giBFRA==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by VI1PR09MB4318.eurprd09.prod.outlook.com (2603:10a6:800:155::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 09:38:49 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%3]) with mapi id 15.20.8857.026; Thu, 17 Jul 2025
 09:38:49 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v6 10/14] hw/riscv: Add support for RISCV CPS
Thread-Topic: [PATCH v6 10/14] hw/riscv: Add support for RISCV CPS
Thread-Index: AQHb9v6W2D3oRoVWUEW36d2velutqg==
Date: Thu, 17 Jul 2025 09:38:45 +0000
Message-ID: <20250717093833.402237-11-djordje.todorovic@htecgroup.com>
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
x-ms-office365-filtering-correlation-id: f2cc150d-510e-4e83-a374-08ddc515bbc8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|13003099007|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?ndVXCxVwT0qnj+VMuHrFstH9vJtJFMVapl5caZusGtXqm5D+0y5jBNcjME?=
 =?iso-8859-1?Q?GvJhOx+u6yJUQ41ZkFeyhSqsJpa6MB82ajT3Eb0lCdZ7EFCbMJazJJTDPI?=
 =?iso-8859-1?Q?FFceDhWFYTnK2z6Zi3hDG6dU7zoPZh5P2268uCx2MmqHouB/siQr01dikb?=
 =?iso-8859-1?Q?ZGc05aIueRFzz2TbeO1iG+O/h2xp35e686kVc7TDpT0m6XM2GN44wkDIWd?=
 =?iso-8859-1?Q?ldEy/BsQRiwAbQp73336R+qXOlP/4afF3XnBczDx0Ru/69yaO3zwDrb2Uc?=
 =?iso-8859-1?Q?rioexzge5Pes8Uf8av8eYmPrC/rPfMZqMX3vwR/yCKiBfYlsql9uMD+71Z?=
 =?iso-8859-1?Q?vn8WwoTu9Xw9BFxmr21AD/iKJIqyu+yIj9/0FVehJhidxPmnus+N/+dSFN?=
 =?iso-8859-1?Q?D3UJQor1Q5gVvnYt5wfpx2ejlLKc7PjNVbB+1IxQdweE8lyiSFyNKvklCw?=
 =?iso-8859-1?Q?3GjB1YZ8r2ubA9xUnGkk/UBlvE/oc1GxgJAa7x7BH2fF/rOhYlx3lYz2av?=
 =?iso-8859-1?Q?hG0Ih79IUPpGniajWPi22iBry09q9AF2XvRA2ziRX32CMONZEmLYzZP8Vh?=
 =?iso-8859-1?Q?ZIJcSVJzz+MSXAKs2rCuIv1c/HWMH/HWk9Nf2w8pASbkCZ+wL9owM/VAps?=
 =?iso-8859-1?Q?zmkDjmNZHS0wrzFKb/AjC3wNGJ9MPo3ui+yuHaHQpeYLbv+mbLCBWYFO3Z?=
 =?iso-8859-1?Q?4y6kZ6FJAefrIrybR9+jpJo8q81zN+4jtYI0ALpgHz0laxM+2IVslcIUnQ?=
 =?iso-8859-1?Q?blQVP3o7D17HWOs6HJ40zF9byYWsWLSkj7OAzw2wg60L4MBmZJ7NFogrL3?=
 =?iso-8859-1?Q?hPMBF+MES7DK2v5yekHCA00CygH2z5M9Zb4jsoapQITN5+F7ZcLyTxVXTY?=
 =?iso-8859-1?Q?p0L3bZ3MWAs1m5XKJDc/FTLLyNJrYS8wL/e8TtuEI//TLDZBnK2ZjghnAX?=
 =?iso-8859-1?Q?k1VL/R0sQCvV1wyh88xgp9vrhsri0c7E4R304Ax/fNugkqHIP4ketVyBK7?=
 =?iso-8859-1?Q?pkPRlAIQb/Y7H9aewlRCBwBePPUqx9taAivb0pUlcJII4wnPaUCK7VbYTR?=
 =?iso-8859-1?Q?nKT6Qzgay13oeW1wdn+P1EgY48wiDGn1kKCj0BnKfcj0U4CNEZ/5yDpbqw?=
 =?iso-8859-1?Q?zfvC+NDKfZE9EqYLPktw+FUWGEH4OsBV5Fjy39/qFLozwDHQYEVqVbTde1?=
 =?iso-8859-1?Q?h2+hMlQInwvON6ISzKPW3cDt977miJwD51pWORB6N4AoKcXFqjqB0VH+bQ?=
 =?iso-8859-1?Q?AK2IrtXmLCBNGJFIHMxtxTs6qj9SLDufqil5Jkighi2mTsBiHq8FnAyUPp?=
 =?iso-8859-1?Q?tOkPGDVvtD498VefokpmIFobUDyHTft3gkE2iovKQrsoyUIw0SRuP62MBT?=
 =?iso-8859-1?Q?IfkX0e0QiuLS3YHWN55WBWILd5iw6MAXxt0UxW8z6lcUWr3m+mK8pYKYxv?=
 =?iso-8859-1?Q?emnQpaFt8O7hirGkU/jCKyUgmXDl+iWCkivWT52AC4uw85o09Ry1pyHm4b?=
 =?iso-8859-1?Q?1dFrF5Q28HmrgGO9IkyLgggtB4GXH6ft6ipbM+1j8tbw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(13003099007)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Pti4LdOjVzhilDFoVNHWW1/ap3JA0ea7EHmi85RQysiHcYLW3ndRxNiOiA?=
 =?iso-8859-1?Q?NXvGT6dZRRNbEGjx8ORLhAReZB0eoQ+N8NgZiXF0tGs+aWgApcmdY+kaPj?=
 =?iso-8859-1?Q?V4BpZlw/xU/q1up0EUomHAru25pE4QrEpxrvj0FXpzFUUAUNkemBbGV8iO?=
 =?iso-8859-1?Q?CrZVSH55y8KNGvIpxeRF7JK6orz4+Ka0/QrRKy7TSsfeKltgIRk0uWh9lS?=
 =?iso-8859-1?Q?3HrFr1w9dlVCcWoqVAIwyREPkgSeZea2DV0r46sbdrOGrqRm6qJAU9qMF8?=
 =?iso-8859-1?Q?v1+RLigdPMmourIP5c926YMJoJvmDeERUGIdP1j/aoAnKjwGXSXoVQdbP7?=
 =?iso-8859-1?Q?QsdSBAn2T/x4xWKULeREStQVjIlAeECgEh94Ft5d0VgAx/F66j+tgdMQLO?=
 =?iso-8859-1?Q?Py0d+Xh9LxJO/jWnAtLxY6Tz/+Gf9/6sz5guyu3Z01aF4fd7R6lY6pHEuz?=
 =?iso-8859-1?Q?9aP/FBzG9quJcqCb0v+qhlGPv0gT5EefZN2ptKSQTTmSQQ4H6SQvCv5OXP?=
 =?iso-8859-1?Q?cJOvogfnZmrbfzjL92G5Lge/P3bDbdGKhaC+F+Et4w+qf0J3PK3jqoGNbK?=
 =?iso-8859-1?Q?Q29oXzyfJASDr2hkYKLIZC9/wkVdDs+upLqn1J1kxs5qSrGO32Xv9/ps/6?=
 =?iso-8859-1?Q?fJLvbPNrTQy2CzX9LWxxLyyI7dE43tMOGftTs7fe4iJK/mWIfQIr0K/lVl?=
 =?iso-8859-1?Q?SH28IvubnIPcSU/PY/k0N6T8GniS3ttoqDX4qgNgzKNHB46RGzdm++VQ7v?=
 =?iso-8859-1?Q?SiT2fgQ12ilSMAqbbmE8vHAtYUq75kyK3zesp7kl9lXYFlS8gN8p1kxe+D?=
 =?iso-8859-1?Q?ZK1IY/BXZxk8JIMFsPSHJ8MMA1pFwkrE7sbi1RoUaGdOjBwEgo6plO3/IB?=
 =?iso-8859-1?Q?ruXLLmNeuav8YJw7p0fiSTKf3Z9zBypeIK9REQsFQMSumu8rYmw0CZTXWj?=
 =?iso-8859-1?Q?gWfT+Uxp4i/V++4/k9PRcniTBzLbfjOoGP1WkncsWm453/UX1e4QKZyYCA?=
 =?iso-8859-1?Q?hhQ2fiereTnD619/oRmBX9JfrVui80q/d8duhfT5sxscJszQDTybTt4Muf?=
 =?iso-8859-1?Q?osHo9K70XSWTjN7baaL+rQsGF1eJ6aM/urrGDu1ix0/+X6rE7Tcg5J4tKA?=
 =?iso-8859-1?Q?xVA8cowC4t5jkxlpEmuyc+H+XmgKt3pVpLuljRxY+Pr6UdGgAHnDkGdj2n?=
 =?iso-8859-1?Q?QG6nqYAW2jDf1JfxhojyFqzWN41b7avuBjB2f69KxcQ9igKnvn66BdxmNQ?=
 =?iso-8859-1?Q?aHvWCRoyv3jV0Fgku7vXnuaC/jQSZL19joBTZEvcy9sI4eKAHHpWBoOzEj?=
 =?iso-8859-1?Q?NxjEYYEGmDlpSxC/WjdhUjzDuCTDWDoXZo2DBonmbXc+ZOM7hKMOrqTPeT?=
 =?iso-8859-1?Q?+KsOPqE/e+DJkabNH6XEOSTGAX1RuWiwdka/G/EvT9Bjyanx+bD+65JxAw?=
 =?iso-8859-1?Q?5CSGRXw4UXM1C84+UenyYS3QUDbPSFCEnWR4Ja5nviqvyrSMM474Yqth0I?=
 =?iso-8859-1?Q?D06ogvXebKrJgjcE9AwBx5Lj9LtOKeEAPMzm42RQibnvkFL4XlV6cwmqSW?=
 =?iso-8859-1?Q?KK9hMhRXYMX/bI1hmY1dS0rDOAULdyNgYpgKmR51ycoEZ9fli5iIsdu3oQ?=
 =?iso-8859-1?Q?R9QVhZq17T4BKYpNG6zHxtIo7y8mD7EuI5xMFk1eNcgLGvHOpAFaNr1Wk1?=
 =?iso-8859-1?Q?JbQ7NNWx7vDJBBWCjLM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2cc150d-510e-4e83-a374-08ddc515bbc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 09:38:45.3439 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ma87pOCBwEX4bE6Lk8WI488FQphvg208t6oethg2kQtTPgfNjlmLW69kdOA8BH7jCNHsyFF3EBnknP/yg5xw/hAmbqWETo9YCgug5kHNw7I=
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

Add support for the Coherent Processing System for RISC-V.
This enables SMP support for RISC-V boards that require
cache-coherent multiprocessor systems.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 hw/misc/Kconfig        |   5 ++
 hw/riscv/cps.c         | 197 +++++++++++++++++++++++++++++++++++++++++
 hw/riscv/meson.build   |   2 +
 include/hw/riscv/cps.h |  76 ++++++++++++++++
 4 files changed, 280 insertions(+)
 create mode 100644 hw/riscv/cps.c
 create mode 100644 include/hw/riscv/cps.h

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index fe166e08bc..dac830d2f5 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -116,12 +116,17 @@ config RISCV_CPC
     bool
     default n
=20
+config RISCV_CPS
+    bool
+    default n
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
index 0000000000..b6439a85d6
--- /dev/null
+++ b/hw/riscv/cps.c
@@ -0,0 +1,197 @@
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
+    RISCVCPU *cpu =3D opaque;
+    CPUState *cs =3D CPU(cpu);
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
+        qemu_register_reset(main_cpu_reset, cpu);
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
+    object_property_set_int(OBJECT(&s->cpc), "vp-start-running", 1,
+                            &error_abort);
+
+    /* Pass CPU array to CPC */
+    s->cpc.cpus =3D s->cpus;
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
index c22f3a7216..78caaf84a3 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -14,4 +14,6 @@ riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files(
 	'riscv-iommu.c', 'riscv-iommu-pci.c', 'riscv-iommu-sys.c', 'riscv-iommu-h=
pm.c'))
 riscv_ss.add(when: 'CONFIG_MICROBLAZE_V', if_true: files('microblaze-v-gen=
eric.c'))
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

