Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 906EECCD196
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 13:09:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v91EW-0003PZ-Np; Wed, 15 Oct 2025 09:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v91EU-0003Oj-O1; Wed, 15 Oct 2025 09:07:58 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v91ER-0000mj-BP; Wed, 15 Oct 2025 09:07:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sEUqpMlrVRd1Q0AlMzzhYDtBvB0Sce1xkdgFE7DWT3Mi6Bcl2JJf1JLb2YbrzK/PB0wEpCosbVz55ThP8f0i/mD/52r3yf/IlnWjM6FOZ14aZYJVPaRuzuhVv6WcjPttHNG3gvkq8L+Y45qSIBDFXKVAM94NI1sTz4BukpdTlFs6fA3/Zop4/JFZQCq1rxVtUIwadYRB9duEufcVqEP9Lw8XxHwNsgtW9+TvH2GJJyEr0/2eBkkqbpbsoO48G3J0C1I/PE9x6QuV0NpI7/TBtsYEwQ5tp6KfIr2uBC+bJHmCWC+9GQ1wLar3l5oqgGn2KkLkFdRqA/7GX7oDRM+0fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1uJ1nZcMszuOEYS2dgtFT0UIQ3DHUQLHvvIi5VaMoM=;
 b=pfO0UR41cK/jN0NKLR2g191WhMiVBmb9sCDRii4nyNT/mE7i51tVxYV1iDi2t5YCdhpz527/+nTh7Cxv8oTfIjXkq923vwaBHy6eUbPaAad6j5pIjqFoM0fxfzpnfgVEMGNKQ1OdWlOJSPAhvxtbCpb4zTukWXLpweOM//ZiOY7vR7aRDogqO2HsGLk+q11EfONm88iKOl6fb50YLy01pL+brgmsWQESpk1JWECyZ65gHbuuVe3YTv5erQ1uT2Sbwnvbjfn8Smc1x3ThGYy+hd1uT6eGJEl0D2VypwlF/ZL+/ib8FVVO+owtkzBPhR3VN4YoU6QHuDP0BQpQjkPg1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1uJ1nZcMszuOEYS2dgtFT0UIQ3DHUQLHvvIi5VaMoM=;
 b=Ft9VOAXuLqaYqoA/uCrKo0662dEY9ke+zuekv2GrS2HOvI8n2cg9U0kM2RvXluSeHqd+8wuTNGlgE8zW0K5li037EnievrZMxkU0RReGldoXbPe/21QI32S5L/TWSeYveyOGoBQdZ4RDhp6jXKs4nG0potQLboEr03D8F0ygw/zs1q5t3NMDxn9m8vjPBipWoydyhQio+0pqJMV9kTLuiZ6UC/xPge7dklv5YoL2zhT+dzycIqQU3lUFNSB0LU8LCtAuhs9fto2hpqZUoS4QAJMeJDoe2HrFwbTX+1FjlfjidFn+y1MoXxe3KKj/Me3rp0h2WZgKP2LiVY6+F8MDpA==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by DB9PR09MB6057.eurprd09.prod.outlook.com (2603:10a6:10:3da::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Wed, 15 Oct
 2025 13:07:07 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 13:07:07 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v12 10/13] hw/riscv: Add support for RISCV CPS
Thread-Topic: [PATCH v12 10/13] hw/riscv: Add support for RISCV CPS
Thread-Index: AQHcPdSbF+ZyLyb5gkCcawX0xJXypw==
Date: Wed, 15 Oct 2025 13:07:07 +0000
Message-ID: <20251015130657.571756-11-djordje.todorovic@htecgroup.com>
References: <20251015130657.571756-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251015130657.571756-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|DB9PR09MB6057:EE_
x-ms-office365-filtering-correlation-id: 81733226-8e1e-4e4c-379d-08de0bebbe81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?CIVgMiWXszSRtQdxscVYPffVA/3BrNsfV0CDAGJkFrnORB9Pz7KXszOZq5?=
 =?iso-8859-1?Q?cdCIYpzmNK3Txz3TS90CC2PJof0D8SxHfKTaOtL+xmb58i56/be/5WTrzv?=
 =?iso-8859-1?Q?2XRPSjALxGOqnQ4vUpec98RlzFUiRkz3jZYqtRz0hhUszTB4OUXI1j2EUE?=
 =?iso-8859-1?Q?kazg48lDw0ucQx3DEoS6C10oR2Vgv5Nag2hdFgXkydVxC83rY0MsFMd3E7?=
 =?iso-8859-1?Q?2tGJ5t6QGysR1JWe4kbpDe9GuJ41R+WWiKQGOHAqpvJk1f3HX8kwN/KJ83?=
 =?iso-8859-1?Q?K/nXBN5zGeuITom820FeCcefQBce1TurWJXAS9cUN1RAcawB6MWqeaTEGl?=
 =?iso-8859-1?Q?V2mHk8jmJ5hTTEzFABK3+N8FLcsvAR4eZjmyi15NbZTtbnrY6MGksj3IcZ?=
 =?iso-8859-1?Q?2qYKGb63wY7A3/P7/1ar3JxY1culiUso5uCxKN0L2sSP7EWc6VBtULlPoD?=
 =?iso-8859-1?Q?a8vOIwqnAcDaEF8DshBqWJvvVMA7Yxc9fHodIZeh09xv3dUSpjJE6xt/yV?=
 =?iso-8859-1?Q?P15NLERQVR2bjfsBMSm/5VGnP0UHXiHJ79mdwXOv3jYYMbjh2hvT90jMul?=
 =?iso-8859-1?Q?rlEFy/ZFQxahcj5LBqm2y0jV+Da0Vh0Uinh87oFursOVjGSxWGpLBV/r53?=
 =?iso-8859-1?Q?EpI2xlIPR5rGbfLW7/gyUY2sh75pTC0nwke/Z6GuhD0azw8gHxyfUnE3Sn?=
 =?iso-8859-1?Q?vxgiREBMk98H3UyPdQEwYgheafuVk3TJZyjowb/ILD5g1eQf8ClsqPNxP1?=
 =?iso-8859-1?Q?vM3mrm8v57Z6jJGOIkQm1WKCt1OrclPWVHJQZQYSf+fODY+ScAwADdkj2W?=
 =?iso-8859-1?Q?dyyUyAOPi4aKMM95NDJrV7GFzwDOFsV4xnI+lUR2EWTUQYRbagg7c6N3mM?=
 =?iso-8859-1?Q?CidyFjl6mrlSQ6s3UorLhvwAZ9v2eWOoMXt9RL7JzGAidbqrZENwazaJ7J?=
 =?iso-8859-1?Q?OkBnX+iAh4+B0quIy9u4ciu6fKTu9n4pj/g7+6IoVaXoiQgAXmEFh1hbMM?=
 =?iso-8859-1?Q?OGPyxMN6oeHvAYazo83dra7irfWcxNKFsrEv/tpfmmyhWYRBLM0gunC+I7?=
 =?iso-8859-1?Q?nHxNN+0fRhKJ1cvZeiTuFBG6bjDMYd/wc4Z+vbsagN7fUQy5GVj1jprUGl?=
 =?iso-8859-1?Q?nDc799rJBzwtHWiCAss3TK3FPAhYBXjQsAAntEcnL0A8xHPs/lwJ/zu5Ud?=
 =?iso-8859-1?Q?wlcJ6Xz3B4Q+K8x/UEiD5/Asshy9JGnC8fokJCQpdSLVftBUfguIjMbLaW?=
 =?iso-8859-1?Q?B6mDA5mQj1Th/jXNWPJ8/w37hJeOJr8YTkl6oQxT2DWCto4ml4augx9LmX?=
 =?iso-8859-1?Q?mBXP9axWfZtNiwU03k9qM6bmbLRVl8r6zF8CBo5l3fnduvxXqHXMZ3QoKO?=
 =?iso-8859-1?Q?fayApT/8NW+lgCvcMmzo0KTrTIL9gCvmRo0girDGyv9gyP1uknEZZKb5d8?=
 =?iso-8859-1?Q?660uPwIowtAWi1oeCN9sWZV4jhYpFyJVj41+LcYyslt616rAzULyODtSPT?=
 =?iso-8859-1?Q?sdZrdE/9jT/rz3Q0NqFXT/tf2fUcTF+n4ruDtv7VBfc7+W8NdqZciN0zsn?=
 =?iso-8859-1?Q?ciUqKL0Bo61aWZMmltyyOeJrMz2e?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Va/4EUhYgAWGFIN6aS7YTwquxawaDj4VAa82X4o79RX6lBy29q8HrvK9dP?=
 =?iso-8859-1?Q?7QilNXMrM7pgKLhR/AC/oKLOs7CYd+g2T6WGVr8cdt0iRjYih1Z6q96I1J?=
 =?iso-8859-1?Q?104XgnCt5maHbIlYMHzp40H3NncR6/5yCzNsh8InIm18RJh0xbSacKSiDn?=
 =?iso-8859-1?Q?k0OXvzm9j6holQDh6b0hd2aAYBul2CskUKCQfGS4TPRFxryuYM8m4tLrqg?=
 =?iso-8859-1?Q?XlxWzv2WTrr9A6bexlC395fWlHjGhV0jgO4IiObRIWaq1DG273Ng4agn0k?=
 =?iso-8859-1?Q?rA0o4sm9IuCjWPX9mOS1KYuEBblVutA+RXHsR0inyJdqSlHN7DKQBILV6T?=
 =?iso-8859-1?Q?w5vWYiXLqWbInuQAyMct24615h/abEURNtCFOrzUchQEfhWZKE/dkj1FuF?=
 =?iso-8859-1?Q?t96MiDP5pNlik8PnlGYtPbZBpug1NYgMPpzXGQ73QUDiq3j/IRdeGlUbiG?=
 =?iso-8859-1?Q?BWf8cRYd4ekZbajtlcjDyqEaAsLIyuSfwkswKCOW4M5MujOC5HRSCW2PJq?=
 =?iso-8859-1?Q?qEObRMN+XqYQm3JOKk8ZNfCq3jKh3uxSQlLo0ZkakU0Fb+B1YE3PkBH4qK?=
 =?iso-8859-1?Q?0BjFqePRkbUQZ2npS1Uyy0cU79Ta+B2FruF4X+Q6H6Aw0K1uOdklCeCn9/?=
 =?iso-8859-1?Q?A9c41/drr2XXFGD6BwUnLpbyoYv8svy0x3+vXsMKdy+RCrcxy+hyEq6vuJ?=
 =?iso-8859-1?Q?gq+PiWHoNTH2rTs4iYb69kAdMX486D4nnatSPW4dqhaRLbvV34IBYAzNhi?=
 =?iso-8859-1?Q?RODeGUOesm76Gj8CsnTe1bV0wjjr6a+X+3qx0YHqkb4do6ZRvhOH8juKBZ?=
 =?iso-8859-1?Q?Izs/HaANihSSXtw5ORZ+9D+ZM3n6GKszkOcSKfU5DwTT54lJ9LUeNdoytw?=
 =?iso-8859-1?Q?MsCCadU+FKBjfT/bgWO3ZM6BVHbxvszvjV0DfMiw9cX1enCxqtuTXaLHhW?=
 =?iso-8859-1?Q?O9FR/qVH3iWwQJZTsckfeBfrT9XkWUADUJdkcMZbSefJ6tF6pdGureolli?=
 =?iso-8859-1?Q?AsvDQyK2z94pDGRQb0grUgpOARFSY5W4qdQjQKbaw+eYhNb63lnRQtboXF?=
 =?iso-8859-1?Q?HzSo/r4fMI0nD+FaTtQER353mmpm+zU4rScBv6NMs/4ZtPosstwyxFmtdp?=
 =?iso-8859-1?Q?/fRRsagIC//NzubDCrMKuyWyEegi9FLRraOiK5Wmtmjec8diVRhX6y0bRK?=
 =?iso-8859-1?Q?f7yAuI1XtgCg9Ysaz2cjLAA5iUuV6AYB6z0yWCYKUtupSoXIYMLkUMWXfK?=
 =?iso-8859-1?Q?p/gFFwD2hmkbHPtdQTorrFieNAM+jcbN6puftc4W9KDLCRUToz+1EpPXfg?=
 =?iso-8859-1?Q?q3XPOq88Y6z1NNs8FYEwEQFRSIElufPLOW2y11Cv78ydtuiZIJzCEPSxRG?=
 =?iso-8859-1?Q?RnZ1kmSnKGHX/zg2nthL3xxHg5wego9haWT/i3/c9WHdlB5AI0t9v2nR0b?=
 =?iso-8859-1?Q?V2knrbd3rMftUEJeZRi/VyARaZ+oI2yolKRyXRlMVKONZR6SJiq2CrJxEG?=
 =?iso-8859-1?Q?nn6X0Q63KZUZSsoPTSO1uA7T/a0RjU/BRkGVG8NHFoWDflsOYuzxuskYjH?=
 =?iso-8859-1?Q?wYZB+AGJTYykUBnOlWmzARSEPbtlH6iDK0lHai5zKLhcQGWvn9YvHvWZYo?=
 =?iso-8859-1?Q?UrpaSN/W7XjTt53rGyxGw9Leuj/Ix3x+6/z3GQ6JDRsvuW/0uktft0Tff8?=
 =?iso-8859-1?Q?OVlBtt9io7/wECHpOck=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81733226-8e1e-4e4c-379d-08de0bebbe81
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 13:07:07.2955 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rw18POvbTrUz3pU/cKNrj6jvLXfClXr3Kn7ahINzxCoGMhWSaShH1HL44F6C1sxCGXyK4MmBwGj2O0StJPTIIzb9CI/ijXKB5MwokT6p/j0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR09MB6057
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

