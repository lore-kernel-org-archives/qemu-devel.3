Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48566C83F22
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 10:02:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucLId-0000qs-MN; Thu, 17 Jul 2025 05:53:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ucL4w-0006U8-6x; Thu, 17 Jul 2025 05:39:05 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ucL4t-0002PD-Ru; Thu, 17 Jul 2025 05:39:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KrjiAvjK3Oe1aVfmIuw9bISd1fLrNLHf0OtC6R07253Hi70A74KLfjdpvoWuJNZaljEoP+whrOnPCIU+2LfWdg7gxX+MsfPKXyp30UiDSGoFD57gG/aMIco/8hUcpFyXNB8Laj5s05Z14f29t9WOCcaLJRdV47UsSegPpBt8hxjJ8sy5slYoLWl0uhS5RqcGrhb+YbIUK4cq2YqL90agAsprH8Fs+UUZulie5KBs58j0M3k3m2W6HYgp4+qJQ8wmEEPaknflI0T3R/mLq1rAYrS+HZIbSwWnS/Z5+/XS2r3jjVOd9TmRUsntrI0ewaPb83zeR4lhcVN9yYmz2jjjYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MhbfqQDM4Oo0UYQcGmsmfrh6Kr/AYVQ/jx+KUZKy1gA=;
 b=ceAUSLYxlYW1d7unpn7x5sSzPBDP5wSv17gw0pKuhnLRJLaZFbFrC/fVF+UMWCaO3p16YqrXuT+2cdmxE4gqqyNxWjXUhosUvpe+ghGFj45XgYYN4uQYjp0SrcUcjjTs6foh4eexZJ+I6so8rYcuK868HXjFDjDq86zDyc9V6jMUbDsHU78MS0VKXODixGMrskT3+m7UgpAZM7NTp1aRSLr4+DHGw5ryD/j3PHCmZIRxXfTFzAtQmAR7k8u6+SSauYnaoM0hOXGMlJtCR2YMTBKBeN4gNu86t9n5SFnfzcm9VBR2q5Fj6KHyVvbMX7qorVsrECaJua7a5eeCkxnIPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhbfqQDM4Oo0UYQcGmsmfrh6Kr/AYVQ/jx+KUZKy1gA=;
 b=eukqPbvgoOLv6raZVtcJjnDo2ByhLNpyh36NUPdssDzCoGMeMnp8xVNZjh9It2w48OFNRr1olBv5jjnTG0lECKYhHEbyoYQ3Q9V18VctlMIJ5rym/wbKTXygA9BD0SLGgEKsJKeBNC3uPGMIqnwoZ2x4nDzoVa7BAxrvVEMjUno0WSHuI0R7iEpWL+C/7wFQP/xLpR4H0gsUAw+l/dOgMFW46Iv3d9QG+b3RfJsM+hYK9WJEdrzE2/bVHtbArE21FV7WoiVMHt/MGnxodCpJ0eb4aptWV+b6+hO8o771cd8TIPhO7L2Ab6VqBr6JlWc/RPj+/QgcV5bHlszltEeaAQ==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by VI1PR09MB4318.eurprd09.prod.outlook.com (2603:10a6:800:155::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 09:38:48 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%3]) with mapi id 15.20.8857.026; Thu, 17 Jul 2025
 09:38:48 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v6 08/14] hw/misc: Add RISC-V CMGCR device implementation
Thread-Topic: [PATCH v6 08/14] hw/misc: Add RISC-V CMGCR device implementation
Thread-Index: AQHb9v6Wv13ajPXjLkiShog0d4iGHQ==
Date: Thu, 17 Jul 2025 09:38:44 +0000
Message-ID: <20250717093833.402237-9-djordje.todorovic@htecgroup.com>
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
x-ms-office365-filtering-correlation-id: b15b27e6-73d4-436b-b7f6-08ddc515bb46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Zlp7a0Tv8dtve8maqIkHLbFFKvvZHiYZ7BUcV6p5JCfQNzZ5X0L+IZJ6R5?=
 =?iso-8859-1?Q?QJ+8lWwQ20s36QGt4WMankAODSACdjETMDxEHI48w1MxPygIpDBRaQmVK8?=
 =?iso-8859-1?Q?Z+otjYpUyHegCcEsMp+1umnuQaD1PIGjm9KB8UGBXGj9Z9opBno5BF5tY6?=
 =?iso-8859-1?Q?tGlBxhrXuUkaYIeHjqItOL9Wsd7Ghe4vkbo+V1ofFk+MV/nbhbAf1C7SYn?=
 =?iso-8859-1?Q?OKYei8tKYUh5nW/Q8Ves5BPGO4HQfaFMdFEUAjiLRRN+4r+wD0Cj2ZvRps?=
 =?iso-8859-1?Q?6+V0IjRXQWGwQ5XbUT4CW20EMZvh2QQ7Au87OIeijZR4Lm26ot96TC0+hh?=
 =?iso-8859-1?Q?NhYDrGDaIeTa3L+B+LJLK/IiwyVGtyxh/eKgtkU38Z1OvVJztlbQ2JJ+Yh?=
 =?iso-8859-1?Q?nR5WW0+xiApFIxR5EMUvme3+NfwTg6K3RpWW1eqK6oNAR7qTZ2OCYU90sR?=
 =?iso-8859-1?Q?aKjHkpL2Y0udXGDb4GqQKCmSTihroxlxZmbnOORyOlH08R8dn/xHZ2v2gN?=
 =?iso-8859-1?Q?72U7sSdTacDFUVQYUNcFn1hmnZ3fMoAAJZ/H7zwyXaaq/eqwmk+3I8aa1c?=
 =?iso-8859-1?Q?8ubZQ2619OX+eftu4rfp4Got8PpQfDVOkG5EO0LqFKyJ6oz8hv+i1lNkDQ?=
 =?iso-8859-1?Q?7Ul1NBIeCZeZJ63mrAo9UF7DXr5iEa/O51ZPw2tkQWuKKgoimeiCRP+ezk?=
 =?iso-8859-1?Q?BFjcJkOIkcYBre2pnyIeSM82aCGAvkUaR77kR4GTEaHNpwn1gEFY7u+uHC?=
 =?iso-8859-1?Q?UOVLUVXgRfetehDAr7N3zuzHUwXtZ7YyUtuDHoRiPfdG4azeg+ii7aOOzA?=
 =?iso-8859-1?Q?4sHJTdfHhddQnMo1SWpxgHwNhFwl/14XhrFtTF38MDicNMFlCL6Cae89+W?=
 =?iso-8859-1?Q?fnPTxD6WLUw0wb7Nvi+W5+1YFGvRUxAInR8oHTsP0txvsIKSU2ROqzAQZH?=
 =?iso-8859-1?Q?NNhwJD+Xk9kWiaCVjfqwugkBbAvUP3V/lp9wLV4oD0cQIKaFlDot371Y4d?=
 =?iso-8859-1?Q?qCBwSvWT5dZG8QGG+PL5TF6Ra982PhlgWo9U54sEAXjow2xq4o1mIVt7MG?=
 =?iso-8859-1?Q?aT0MKKfH6X/szQJ9wiDZUhY0SSdVdsJqaYmhiMzIxMf095Y5uH6XyGv392?=
 =?iso-8859-1?Q?lrobjXsvCbKgwGZr0XN9MLm/1Ho6cnUxJ3IDmwIAG5ZVPfMycv2sWYX30q?=
 =?iso-8859-1?Q?vSCQxw8fw32+qdhwg3P3l9DjoDnxxDxkGEk48iEYEmpMlIfIZXmtO6qOVl?=
 =?iso-8859-1?Q?h2MLHv446f+3d4t3UtEK4eGrxc5X0O+22OYle5LFJL00XSymSaFa8tZpmk?=
 =?iso-8859-1?Q?tdIh7UaxPwPpN5xn6Ydr6bIpwQ9H2/dUkRrMV//eC9ZIIwgMxFZXEipvLq?=
 =?iso-8859-1?Q?oZcB5E6wcwqp8YtwJA3f57GEV3HtCqpZkHHzDk750aSsXmeY+Sxopel1rL?=
 =?iso-8859-1?Q?WBwGbBC0HzLpItCvwOGc/xETkT7yd5Bm3VkTPmMApv3897sY9ZL2VcvqII?=
 =?iso-8859-1?Q?KGGQzpKoY0puPIM/2YuHVeMhmHhJ6D+IiXpSg3chPtdQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0ihxBU3bVHwsvbf4uwIXH8X7stBifW1LDgYJkG+a1TWr4fRH+Zs8EEdD4W?=
 =?iso-8859-1?Q?qlLM2VNOjXUDYcMGPXa22LUdUqQqcTiMKa9lkLPE0NRj0jGPTrJd1TL4qN?=
 =?iso-8859-1?Q?GyX9aMHVuvDggpU54UnUYFcvhxvU6XKR8mWtTitOsq/gRrHvbWKhQJWx40?=
 =?iso-8859-1?Q?qvCZ5AwOR9OHoAciVmnMaPsU8hJ7+shzWtiBuVYHkJtypfaQL+tDDz7gBe?=
 =?iso-8859-1?Q?si353jQePppli05bTXGodHjcMLZKNYhINgtVmwS32Xb8mElxR/DpfW2DmO?=
 =?iso-8859-1?Q?XgMYTkeNa9qvvQD3F+7tUb1MjoBmJfIuNlNCezmldriizXJAcUCSm0WSno?=
 =?iso-8859-1?Q?VjFmRguss+1YKuu1gAdpAmaaPPtBxZ1lB1+EWIGl5Z91hMbo6T87s8awqH?=
 =?iso-8859-1?Q?RTpIwJO6AOFUprpv0aMxtnh4gxBCpPu856G3g7z5D9kqRGfoyxJKTghSM+?=
 =?iso-8859-1?Q?2RWBje80xBJN8XfRGtGe+ca8gj2mb6x7c9pgP/hYogE1mH5GsPQLcxynZf?=
 =?iso-8859-1?Q?RtqPj4opiJv4vhTcf3T0nQ6i/A22FZESe6Oel/JYVMuzC1LfjsKG/9yvUh?=
 =?iso-8859-1?Q?G9HpnaQQWs/v6o7dbOEpSEPqXJhghg2nUA5x2JjbA3cHemQpRY+UQ1xn5j?=
 =?iso-8859-1?Q?tdthNBMNg5Z4PE6Kxt47SP2gc4xNSJm+CGPBzTWwAMMZFZHpJv16tJ6i04?=
 =?iso-8859-1?Q?l9dWo/Nz3AlPmIUV+v7auusPrxTu+Wd9jPia0hv6U48+QzmVo8my4V6jUN?=
 =?iso-8859-1?Q?ktl6Q2IxOGCibyeJCf5zA1zOxAZfLvNHeYguoCuTk5btMfCemyEG2uqgvJ?=
 =?iso-8859-1?Q?DtuI0wZvM0W4f45MSOuZMGnR+OXlA36hg72O+asUeI8Mz4eoI1xzwjMACm?=
 =?iso-8859-1?Q?RPBZjY3Wwh9nbcdu7hk/OREauXy49GM0YGdEoXK5pAU54V7vV7ftxHK/4e?=
 =?iso-8859-1?Q?8BEv8lFR5jQfPOg7GtisSz9uAj2z+fuTUgdsjaB8eWx4BSP/Dt6Z2NXMU9?=
 =?iso-8859-1?Q?ZFYjIgrBxRVjQYE/FR4OmOlkstJaDHv7lIc7Eo8Y3aCKayQlzkzUh30SQk?=
 =?iso-8859-1?Q?/7xTyBsnZpyOt35LhbFvwjsewBdyK2wjoUubb9zNN51CFlaR6RnkX03qVm?=
 =?iso-8859-1?Q?AM1RF8oL1BV/3piw9+czkA5iNAen9GbE0SO4ZRknK0qweB3iY9+NntzyJW?=
 =?iso-8859-1?Q?+264yg9Em+0Dpfh0cQZOp4lFrXQAwEFrL18+EIQZwIg94SgUMogvSzv0wH?=
 =?iso-8859-1?Q?ZznKFDZGbkar4GswmgVyTLrmmQ2Ytb2/Bx4e9QSCzz/IpFCUa1SkFrdu2Q?=
 =?iso-8859-1?Q?eF+jip2VOy8WN3mVpWVk/qfunH5a+Bk/eMvEoi7A4MIpGhGGispeZv5ME9?=
 =?iso-8859-1?Q?m/HbXe4hx2onUOF6n1Ou3/t+gE7++0weJu/BXVR18lcXuk3UIetWJT9UYp?=
 =?iso-8859-1?Q?piJcidOghUdAlMh1x5oCzvHaIkKwQatdgS220pJGCEiw0Wbf6v8q1xOrt3?=
 =?iso-8859-1?Q?J5bo9roHR3tr3mPOfzmll2YvJW+ushNZjk8LvSF0NCDNzqpi6V4KENtHP+?=
 =?iso-8859-1?Q?DXJijsJaRK+5scbURmb6ksf0JkrqN7mRfM/WBSckrSGVatjlwF1uS8GB5y?=
 =?iso-8859-1?Q?Y3uN0MpPzl2BZWTBEopNIktfzJq34JMEMZP+jD4LkpheCYiVRorjDpVtTR?=
 =?iso-8859-1?Q?D93N1mt79mOh2edBkAM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b15b27e6-73d4-436b-b7f6-08ddc515bb46
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 09:38:44.4844 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A2LZfsk/jyTpFc5NH7MkV4g82V3AljU0LTGeXPGD7pWbWbS1uWfjhvPdhr9A16IhA/1vPHwwvthPrZ2Lhw5FnAtckCkvTS7PMqM6X82riEQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR09MB4318
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

Add RISC-V implementation of the Coherent Manager Global Control
Register (CMGCR) device. It is based on the existing MIPS CMGCR
implementation but adapted for RISC-V systems.

The CMGCR device provides global system control for multi-core
configurations in RISC-V systems.

This is needed for the MIPS BOSTON AIA board.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 hw/misc/Kconfig               |  10 ++
 hw/misc/meson.build           |   2 +
 hw/misc/riscv_cmgcr.c         | 234 ++++++++++++++++++++++++++++++++++
 include/hw/misc/riscv_cmgcr.h |  49 +++++++
 4 files changed, 295 insertions(+)
 create mode 100644 hw/misc/riscv_cmgcr.c
 create mode 100644 include/hw/misc/riscv_cmgcr.h

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index ec0fa5aa9f..e3fce37c01 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -108,6 +108,16 @@ config STM32L4X5_RCC
 config MIPS_ITU
     bool
=20
+config RISCV_CMGCR
+    bool
+    default n
+
+config MIPS_BOSTON_AIA
+    bool
+    default y
+    depends on RISCV64
+    select RISCV_CMGCR
+
 config MPS2_FPGAIO
     bool
     select LED
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 6d47de482c..29c573f7ae 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -153,6 +153,8 @@ specific_ss.add(when: 'CONFIG_MAC_VIA', if_true: files(=
'mac_via.c'))
 specific_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('mips_cmgcr.c', 'm=
ips_cpc.c'))
 specific_ss.add(when: 'CONFIG_MIPS_ITU', if_true: files('mips_itu.c'))
=20
+specific_ss.add(when: 'CONFIG_RISCV_CMGCR', if_true: files('riscv_cmgcr.c'=
))
+
 system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
=20
 # HPPA devices
diff --git a/hw/misc/riscv_cmgcr.c b/hw/misc/riscv_cmgcr.c
new file mode 100644
index 0000000000..45d7a0f1ba
--- /dev/null
+++ b/hw/misc/riscv_cmgcr.c
@@ -0,0 +1,234 @@
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
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "hw/sysbus.h"
+#include "migration/vmstate.h"
+#include "hw/misc/riscv_cmgcr.h"
+#include "hw/misc/riscv_cpc.h"
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
+    /* For boston-aia, cpc_base is set to gcr_base + 0x8001 to enable
+       cpc automatically. */
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
index 0000000000..f6c2073293
--- /dev/null
+++ b/include/hw/misc/riscv_cmgcr.h
@@ -0,0 +1,49 @@
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
+ * SPDX-License-Identifier: LGPL-2.1-or-later
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

