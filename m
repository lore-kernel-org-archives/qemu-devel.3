Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44598D185F8
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 13:43:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdqHG-0002kw-45; Thu, 08 Jan 2026 08:42:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vdqH4-0002bQ-KE; Thu, 08 Jan 2026 08:42:02 -0500
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vdqGz-0005qf-RP; Thu, 08 Jan 2026 08:42:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q+pmBkjCK/6CgEhywb+hmK7mMDTi8jOjwPp+IbygmREmTSCqYvUZs1mpuraSh62Xfb3SzJBGYIwUVf/r47QWf8N4+BB108YoMl8sJAnRoDXR44/fyiubdZtTWAB37HC81w/8irlApPrBBnkujc7zuzas5X5MD50tzZry2j2rNJUaMpzfbeJ2Ir8m+PfdlGYBQoFVbVHhVOzlTYp0Tt7mgLEIpAQKzQCzvMjrZY1z+FMpKcx8MaXVNxr471aVH3OXZCcw0C2an3PV2QJw/7NjZbhmCPB8rjgoP0KfltPVq94XxWOBGsXeYlQdDKF40EIGFv+rxhHGNb5aEkivZQEYmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYuAJv5q400LjYqArPKviPX7Td5OnrRLCJwge+C4xjY=;
 b=pZE5BFLLd+Gm9upaXP3kKGRDg4U+qmPAQL+tcD6cgCQwTNrIPAT1XYAJZ+J1Xnz7TsMwcyZrqnrj4K2Or1wuvBxbP7IShqANpT4nErCWlbMs0PTW/Ic8fU7exQ6Ztzxhqv3eFhuMfJHe7O4stmKJT2Sse/UR2VIB5WHcRKXK6023P1NH11WHmVX7RArtBHntRnELA5dqiv1ZkjfUqAj4b11dCBRs14UJLCq+okwjtiCvePffAgWljdQYyq6dBSfGWUytK8qUYVN5CHO7iuF6v28/P7HGetOrcnsyDDyhmne9vrkO9IroKGqLRwS7C63ikFiHI2ozcPLehh1a3/uuaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYuAJv5q400LjYqArPKviPX7Td5OnrRLCJwge+C4xjY=;
 b=marJibh0pVt6F2S+rv+GDTy9kihwRDHPIy7TRFQ/PwRjv6DhmztXmfP4d/KZpMnn+uD5OvV7OzkoqE/2T+EK0gyORp8XnU1ewvn0GfmDn2J4SNR9GzsrRk+CVUnTrWJBRt/VJ8XljhTLnRZ9k0mkwJxIn+VzC/v0+Ee4yQoNbsjtg9BpCs3j/2zAbm5iCX5E65gn/M+2652ZSzeDyPWCnU8qbNQSU0w3Mhl6HJe8MTTAc220fU/LpyMgPw9ThjJ+zE7CL9ePM9iYRZVDMGNpuWL6l79Wdz7s0bmfYjK+Au2bLAc8kJsGWMA6HxLeSWRjjpOwDjCGO+S3Ljp9/vR/pg==
Received: from DB8PR09MB2796.eurprd09.prod.outlook.com (2603:10a6:10:ab::30)
 by AM8PR09MB5226.eurprd09.prod.outlook.com (2603:10a6:20b:3d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 13:41:40 +0000
Received: from DB8PR09MB2796.eurprd09.prod.outlook.com
 ([fe80::e42:9fbc:3e58:febe]) by DB8PR09MB2796.eurprd09.prod.outlook.com
 ([fe80::e42:9fbc:3e58:febe%6]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 13:41:40 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v16 09/12] hw/riscv: Add support for RISCV CPS
Thread-Topic: [PATCH v16 09/12] hw/riscv: Add support for RISCV CPS
Thread-Index: AQHcgKSE1kECtaVTrUifL8qLnOiaOA==
Date: Thu, 8 Jan 2026 13:41:39 +0000
Message-ID: <20260108134128.2218102-10-djordje.todorovic@htecgroup.com>
References: <20260108134128.2218102-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260108134128.2218102-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR09MB2796:EE_|AM8PR09MB5226:EE_
x-ms-office365-filtering-correlation-id: 2295d557-5f06-4469-a0ba-08de4ebba743
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?d8/7Q8DANxzH9+ejBxNMfxHxtm2N7x7dpY6yFqSGz4Z30tNRYlwrvyNfqe?=
 =?iso-8859-1?Q?PpCHoTZGD2gZWgYVEIVMsi/DyFXlLM+vksp5lmq2bgrXBPbFPp9iYhRk4K?=
 =?iso-8859-1?Q?K0MWxdR81KsQ3H3U7tByCmQEy7U4HnULY9+10nwfpZByuhxe8ZhgIcNqRu?=
 =?iso-8859-1?Q?LMIQfJkJWXjFugHYbj6KY2R5o1vdszn2HYFfnAI9Ks10iEGLJ1PAM4Cz6y?=
 =?iso-8859-1?Q?bQ+HfSPL9otfD385Ok8HdGQrpXbu2x1LO6qds0X8M4UpLqW2uQ0kQAOt6o?=
 =?iso-8859-1?Q?okRQWunnxUjrnPe5bju7tKHvRinN0anpPq4IPhP4YCCaftpV2thQwXLB30?=
 =?iso-8859-1?Q?qdCeR0tbCV+gysoA6dV+9PMQvPk2Vyn1KXwdsUnbwn1VchrYnillTRwU0x?=
 =?iso-8859-1?Q?sZ1O9B6jHUn5KfTImqxan67uwdVmoeRY7IohjtcLQk3Xd0srisCVPI2k65?=
 =?iso-8859-1?Q?S1hc26y1ezOTv17lbZaL81m64GsaVsLg/XP6H7xMUVYTuplYVL/3VAnMYR?=
 =?iso-8859-1?Q?DqQNfUKrjlZ//sAopskOrdXLY12IDC9czEYdpOmqZCFb8PFz8RFNM6WDg+?=
 =?iso-8859-1?Q?cClvyaNJbCBryy0UXTP0DX2nMcdB+qqHewkpiIKMucIUc1VR94L0sTxumH?=
 =?iso-8859-1?Q?u6bC/FnEasvJiFfC0mxaV0EHTXsopIb/bbvrGUwsx1I3RvFV5FIM3ugMwp?=
 =?iso-8859-1?Q?7zeQiuTR8bOqv4TLaKv1q3J+QXl+4amLALyLcS1VHQNl2RgQmxl8vqwNwT?=
 =?iso-8859-1?Q?LfTIE17DvxO5wtxcgmYHi4/n+Kvuf9oQzvClxgwzhiBC57zl5w93oXrgzX?=
 =?iso-8859-1?Q?ThZ8G8IcZZ7Ap3gfI2/qE8Z+h29ysd+arvq0kE8zY3jrJ4DtEVxjNPdSKC?=
 =?iso-8859-1?Q?Jymwxs6pcD7q6oG1XPAE+ts5q/zMIzzPfQ3ENggrRhKlIY5n/gHJSYXeYf?=
 =?iso-8859-1?Q?HjXMwQP+B3Pzg9lOIOccCj3LGSkfDeQkSFDE/zlb/acReY5AQ/8TIkRuFg?=
 =?iso-8859-1?Q?LFlwulf545gJxzue4IOB0S9x4dYbVSOankiIq5SWsry0i9Net9UG1E1k4I?=
 =?iso-8859-1?Q?UF7NHBq3fZ76dtDUZjDD/MEYQQLVUNA9R+/EYNwETpew3makfdMz/iyzEo?=
 =?iso-8859-1?Q?1WL1SMzfiYKQcXvjyF5cdWtC/AiMqjOrkfTRkWaxspDxDxE20Fh3wYPax+?=
 =?iso-8859-1?Q?sbLt8FFVr/SNIXLHeAAmfuUzTdQT/ubFsNDWMu1eO1S563iRUyK9OVO2Sj?=
 =?iso-8859-1?Q?+ZPD2PGghPXG8AxBQ2rKhapj+WvmEa7U8DqfTz39h7wsKeGU8zhCM2iTtP?=
 =?iso-8859-1?Q?SrNorSlVrycq6M8C/Z6IWU1g2TkR33peTRsXM498jl/Vzp1L+mZfnQym8Q?=
 =?iso-8859-1?Q?8ARcpf+eGNqbFfADttiLCobCpPM7H4ta9YFkO76bYCSaLgrVMJdZXu/o5s?=
 =?iso-8859-1?Q?Bxry5vZx09Yg6NSwr0ZiIt+jiuwCiSFHCCG0WT+BRNi29Qw4s54pjFN1mY?=
 =?iso-8859-1?Q?2Behiz/t0GVCNI6HNIROc0lEBtAREOvlk8AdJSHzQa8K5SiG5TbtJVcdAX?=
 =?iso-8859-1?Q?CmMZ4WibIx9/1nnqGpjqGvv6cv1h?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB8PR09MB2796.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cPh/eVyO9kaV3FSQRAPxtydoEAWuawudnPMuthZ8wBFEC6H38+JywFvUj8?=
 =?iso-8859-1?Q?6OwkVY7Y2XXZ6TUjbiNJqOGewSqlOkm83luSJZvrl2If92t9j3eScgxGMa?=
 =?iso-8859-1?Q?NNerU+Kk/b4MvjX/pCGT/gL9MMQWuO5R1O+OoJpY3UPUT3r+3m/FhwUDRt?=
 =?iso-8859-1?Q?DWEz0wlXoJO49O3w5HjMDLgQztSuAqUaeh1Ga9P0vh3udlH3xjC65gy1BD?=
 =?iso-8859-1?Q?g+3jWATki1lu4V9WvaO4UrCxI1kxmOtUFv2LS4kh4j22vQ3GdX5MSC7nBS?=
 =?iso-8859-1?Q?rJK7QT3qAL8sHjFd8ee2qv9Xq3VKfoz6eP94N1zhIKHH96zxiv7fc+OtUk?=
 =?iso-8859-1?Q?6tRz3s9uFaJ1j3qfI28i/EWBOeejQ8LftNISeo6lzVafVpzhCI6gXWToW8?=
 =?iso-8859-1?Q?4Y3m4C7N0xk/f/sXchhC01aAo/m8tJ0O2WYh6kcTSmFDLH3f+A2FNR5zB7?=
 =?iso-8859-1?Q?yHQCdix2UCLuImXFJwzgCshYrf80AwDCz9Rr12Oekh8hn2nwIpOa9dxd/C?=
 =?iso-8859-1?Q?9v5hrBO+JgeVgQOJdByeZF7Buulq5PfphuCt8k3aZjhSrdCJ6cJ1vX198H?=
 =?iso-8859-1?Q?62O4nUMsNCxdNQXGWMmJgWNHPb8nWrIuazx/MNzKwDXsdg0/mXfeKxHyAn?=
 =?iso-8859-1?Q?ep5JC1v11arIblb/vM4nLw/AUPGGkS2sW4CT7M0Y+0nSJtzDRf8GsxonlT?=
 =?iso-8859-1?Q?xFbiEWz6q1heGD4sQbvvV+trZD0TZVUWkj/J1HT/IH5XM6sJcmcXSnpEfP?=
 =?iso-8859-1?Q?ahBr8yQTrXcTPSDp1nDzonLtIGzs3CAfCWr+jp5mC7I1hqi/i7CCH7jcIj?=
 =?iso-8859-1?Q?kcd1B4VEc4Ho35NXR4ebhnfytHrYzSGBdHbUbXs9RcKugVQdwTTQYN94rx?=
 =?iso-8859-1?Q?G4qiK6ZWAVxkwTvmSg6w6ei9UOEnC3myehjd9UqbWvn2zmJPGTy0q9RjRR?=
 =?iso-8859-1?Q?4k2EJbHeDyv1XH8e410gSgdja2cbjYZXZifGZVE5eNo6+AoS1+zRrgeVj4?=
 =?iso-8859-1?Q?tUYQzIzDdFk4fpL46lED3mPK+L4CgR3PTzZUxKOO8jmoXtMMZJapSeBOyJ?=
 =?iso-8859-1?Q?secgS9PuUdnFNgOJoTERbjI53BZ2m+W+VIAB9UvpYpnHKs63VcU6lkIj1q?=
 =?iso-8859-1?Q?WBw9MUfcNh5d21PoNyS1TuHlGG8F904w0HsxmY9KLAzRfVZUsge6YhBlBE?=
 =?iso-8859-1?Q?pIUtFJD1atbLsrL7tJ1YWUN2KJK52aO2mabfpvkIoHNjrODbayAH1/JO8S?=
 =?iso-8859-1?Q?HOcP6mgR2EecYSdaHw6+otETqrbE1MMU9K0BoGy6lCrjAHcE4CXwPPp7Rg?=
 =?iso-8859-1?Q?/LdK+Cx1jjVejb7Fvtuuq1zK4qfxjU/fZZhZ4udFHDHR7R21+rODxwksqy?=
 =?iso-8859-1?Q?OQmUnQ30eU/idF246Z0J9UcamB0R24a1K9DjbV8XoTRJ5mQciTXRAgpFwb?=
 =?iso-8859-1?Q?u0zRDQy0eUfGTCIDCyU6lCWx+CqQMZUG0IfpqSIlLrmvMU2lH4ksY5d1op?=
 =?iso-8859-1?Q?JUeJr5fP0Qd0x7FgMZ65nbBaWDs71S7T0lexCSUHU4mKaKTxFAsfoARzKc?=
 =?iso-8859-1?Q?lM3Kwq/ciexkG89DMjhWYezNgVAkWVpCgLbF9V5ZdYGbfQCeEjH6GEmShp?=
 =?iso-8859-1?Q?lpztkbbEPcYn0JiBlzuilYw/7luxmnZXx61GSFQeNxxYLVBGP9eM2cHSwp?=
 =?iso-8859-1?Q?KdLY1B9K5ycwSKUAuUly0FxyoQWXq1pTXYPrKn0g4C+wXPV5KBfFXD5Itq?=
 =?iso-8859-1?Q?659y+UKuBtu8OpOjpqyXg7/1srv5NHvPcGjJLgNXjfMYzEZLcmtrHUytqZ?=
 =?iso-8859-1?Q?Vs0iVDH7IBpFaBbqM5ePaFOxni3ZxqYdapafriM7tK/5P6h2K/Yi?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR09MB2796.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2295d557-5f06-4469-a0ba-08de4ebba743
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2026 13:41:39.2677 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: COT9gPnPDuhS6YhiuInsYjy3FRaXttqEXZMHKwtuFdoxHpu7gROM1Q0MCMQNq4gam53GiYAJaKu4H7Gpwn4Q2IRKShDolK4AXtvpq6Bkqio=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR09MB5226
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
index 38be72b141..4a22d68233 100644
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
index 0000000000..86172be5b3
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
+#include "hw/core/qdev-properties.h"
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
index 0000000000..f33fd7ac86
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
+#include "hw/core/sysbus.h"
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

