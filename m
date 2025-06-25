Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C476C7EE2A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 14:19:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUQxM-0006zu-GC; Wed, 25 Jun 2025 10:18:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uUQxK-0006ye-1G; Wed, 25 Jun 2025 10:18:30 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uUQxG-00049A-RZ; Wed, 25 Jun 2025 10:18:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nN393JZwdahSu1TYrqMsm55bVTmGsTN/xGZ5zzEGYT3jtxvncgIakFZeeBcqzMMwOjt+Dlnp6T39+CmsvZB6ZdDcCxDm8EgWJE4Ndt2ETJp5pGaIjZUrzbIubXY7KmIWlkHY4EFEpCseKqGAq5RMr7MsZTOgtNJu6YJGlRbwKUCx/0GSxHYQ2+RUCK8odj1VWhupIJ3BDShDj/lpEw5bWDfDPokHtXz5wDFU4wLd7YXe1f8W7fHevmSW3zShLKI3vRmhUC9wFKcCYMnKMLauuZ15Isv24C/4Bsz65vat5wL4PV46kyDsvKC53TM0EtGPRBilG01FjVSe9c8zGvJFyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PrmPUNiYpxLANPjmk3lme2Cm3Q0rIJtRBV5hlRQ8/ic=;
 b=SsLjklAPCrdA36KAjig8baUU3DDBTh8GmVgCZVZNPoBCyB4DRqPy76bxwOi7XUimBlCYlOxz1hZaBVOtJOByHb0VXkrQcMmIRsI2Z9pbtha4LCY6YrxJMT4pKs3PuL45gFOoTSDJujTvEzVPDVLus1A3p2ZmgWqH+uFbmgmIvbUWp+W1fM6TtvdVqfUG1jCQzWCesx+vTyORWlei/L1Lf7GM3BiUsgPwO9zCOEBCXARaSMSTWSCI0VNUWLIdEKTg4ZjRYzziuk1E1m6KISaFyCrDzLEJ/p2SbQGdQASEV633/8+WZlQfWsU9lSXP3EajarAFOB3QYFn2roWYTM5eGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PrmPUNiYpxLANPjmk3lme2Cm3Q0rIJtRBV5hlRQ8/ic=;
 b=bBPSfpfT6vVrxKXmauvcoJUFuGMpSuNOOzCfpwuNfg2mjCs6DtWw5A8yd02H7vgtsTTMN+lP0HyA6G8c7dF2Dsv1CByFluUFI+1khMlG9YVDy9ewHVzPsS8M7CF6Mw77UiYDjgVA0smdg+Dk83F/1b1r7GnAT9cEQTGkzToFkwmYH37EYWkQjXk12d4N6WHwJJEBI+f6uURTYRInnVsvNtR1bdiRttaFyRSo68jg1lFPzQhDr8PAZQ3K+58YcSJnaOZfThPeh9VwsODDGJqtW+N9tLrrrr7T+Z4tcr/CMrtZ9/HKnZnw+GAl/rj5ezcRx/kVPu0V1oN70khkDkzw8Q==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by AM9PR09MB4690.eurprd09.prod.outlook.com (2603:10a6:20b:2dc::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Wed, 25 Jun
 2025 14:18:23 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%3]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 14:18:23 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v4 11/11] riscv/boston-aia: Add an e1000e NIC in slot 0 func 1
Thread-Topic: [PATCH v4 11/11] riscv/boston-aia: Add an e1000e NIC in slot 0
 func 1
Thread-Index: AQHb5dwBxA0crRbmXEKNHzdZaz9wAg==
Date: Wed, 25 Jun 2025 14:18:22 +0000
Message-ID: <20250625141732.59084-12-djordje.todorovic@htecgroup.com>
References: <20250625141732.59084-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250625141732.59084-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|AM9PR09MB4690:EE_
x-ms-office365-filtering-correlation-id: 07923da4-f784-4469-f801-08ddb3f324ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?PupmEIav9FpuTxj4aEQE0HrvmTQgItJbTcLCmQ7F+nnzbOqJk/g0BJfrUR?=
 =?iso-8859-1?Q?B9BdhvXGy+s5XqwAiD7ITjQM3YouwU6qkkZ67aIqxr9wsAVO0E+wlRlii8?=
 =?iso-8859-1?Q?1SeZCN6MMW1jUgJt89EpNdX4iuLT0/5tC8chvXRC1d7fQEcLyAgcVXsbaP?=
 =?iso-8859-1?Q?TQ+cGxqDd1cewCqBLs3YOitlVmk7wu33U2li6iaP5i0ZRcNDxscb2wyUY3?=
 =?iso-8859-1?Q?rvNDpVNYzPZdH6qQ5PriZut2ZPmmZCc9RL1eSHcEC1JT5Aexp+bbI1/x73?=
 =?iso-8859-1?Q?HFebIoJxNiu4sum5VgsEAAg5vDgMCpSw+INnQVaPeXYjETOt0kZIr+f0ho?=
 =?iso-8859-1?Q?0v6vT/FK5T6zKxmIdIqo4JE6vTmGm3UY2u37ZM0Iqrx5UPOk8OQQjO+eiy?=
 =?iso-8859-1?Q?Q4WrI3yjPgbc++MPW9oZNNBNRUIcQMFo3X+oBifVFIqdFKkt6pD2p27xaN?=
 =?iso-8859-1?Q?xgJCZoJnP7jn7t1kGZA6uany2RApLLK3CzVLl5sDqdQ/yoxyHTnqCFXNQi?=
 =?iso-8859-1?Q?FChBa2guSuyhmeeUkA1Eror/stvghnVjBkscuOCMZOpEbdXCqVT4WI/x39?=
 =?iso-8859-1?Q?0779shMBPyjy/JeN/HCk+fC3JkAYdB+OhPlKPRCvc23zaTZKFgTezhyuKp?=
 =?iso-8859-1?Q?ZOHos4pT1PbFPGc0Mv/YnZnR0K/oQCS37xii6x5lzp5zMCEcM3FH6d6odM?=
 =?iso-8859-1?Q?Z9/iBOYLfgqAPHyOlfaOb8zp+xBR7457k9WHZLsgZRuOdthnkrGy9YbCzG?=
 =?iso-8859-1?Q?xfsPTpldKNMUrr19/2BshtW+Q2gsfNE9AxuVFGOiPDpJWwY2Gr3zLHrbQX?=
 =?iso-8859-1?Q?43tcGhpWeuiarw+b3Ycp5NaLuaSxaLqW+n8Ah6sd95+BzAJHPXyPItiiX9?=
 =?iso-8859-1?Q?UA2zFCmu1gZZVthb2H62rt+aRRSGCd6INpwhhPgdjD6CRjHkniOj0TaD3j?=
 =?iso-8859-1?Q?g7DaY7Z6dy4QL+PWDICPec9wnM3RkKNYs5MHb3ccJdYPdN0Muy+Fg8eIel?=
 =?iso-8859-1?Q?oipxbmimTMplWbSQb4D0mfaMxUSVHwMQI5RiZLMx0s56JEtvF4LwL9uCGR?=
 =?iso-8859-1?Q?zEnKyLoFYapQ9CGp0q2mrWUktpa1aJ5pOj2wHnnSbv27TuI09HkB0RZfoe?=
 =?iso-8859-1?Q?la0vHVQL0RYB4vXYTtYzGDvn7wFG3xXyAPvt6w5r7sJi1lXb6yS1FIaLHj?=
 =?iso-8859-1?Q?AeFlgZDqgwlJFqLTxP9yL8lUvgj2IQFnV4edwDF+czEpwyGn5ZQFKCYtBK?=
 =?iso-8859-1?Q?F2L7UXf4BnwJvqH5BeAOG1MWL67BftTCsnGi6jNZ8NoVtv+RQ15CYTkkmQ?=
 =?iso-8859-1?Q?EC1nYLa7smDiv/jPFgNwYNdVhEzMW+pWU26QpWjFpCSkpKjMK4M2nlyEUe?=
 =?iso-8859-1?Q?gSjQde3FKfJillouXynSXuQpnxvqP+EK9YzGnONimFMYGQgloOGN8uTKzJ?=
 =?iso-8859-1?Q?J2Vq7bkGiUv2FDW1CAVEbHqL1fy3lxfvDtn/z3LaO9UEUnMwQWYY5ENsO4?=
 =?iso-8859-1?Q?kJcutNbaVYVV4WTbfpqUZV6bGpuCNuXhNEVdg4OZxKSA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?WgTes76y/a4r5WW08wQMfPsYY0cY9XVLKVbHzodkgihxlZaQ6sPLsxifBh?=
 =?iso-8859-1?Q?T4Df9+BmYIdO0tEVEG3mXY/owZYviXr1XgDJ/T4FT7n+/mdZEGniJ40epq?=
 =?iso-8859-1?Q?TKql+KU1QvrQVdi7y2Jq6fw0kRnzHo68zrxUulZZbXa0JcFOOmnO97aCfb?=
 =?iso-8859-1?Q?nyBwLYjZNcbnFaV7jkwcDUvwfTiHS7wBF5hVLmFOg7tGRyIteOu7mMOTEi?=
 =?iso-8859-1?Q?rUAPLqirE1Xt0vkVQyWFnpVNsFY1VhDnbZBS1vceb6kU8u0HgrUh+7Oi9A?=
 =?iso-8859-1?Q?GvgcaMKc5cbjEFTcmqhwm6dpueJQUOjce/1X1XoBkOuNOwtUEQexbqlmyl?=
 =?iso-8859-1?Q?KZUJ2wqfyqvC6WO+ISK9k5J2oPX5GBT4tW+H5b3ocfEAy94SNstv9T2bg7?=
 =?iso-8859-1?Q?uc92Ob+vjbp2bJxDpaQiyN57zbaAe5BJIDhjzAbsjMSjkb0D0ig09/hwz0?=
 =?iso-8859-1?Q?Tdspdy8i1S64uw5uCsHB44YQNrufOY7rznxbn64UeVM5JuRKFI72u289RI?=
 =?iso-8859-1?Q?9X/AFDsRe9gMTVWwAzmGNIhA416tGEjH+ZGs/Uf/tpQSSg0aZeC5p0w60C?=
 =?iso-8859-1?Q?9jr23cGLHapt6pbvmShC+NiPYtMT1Kh6dH90A92IhHFAMWGTBN6+f9xXv+?=
 =?iso-8859-1?Q?y1f6gacaBxCG+IIsRkByuOzWdECWFDqPrHY19ncqAF4eX+VEGYCkgm4fYJ?=
 =?iso-8859-1?Q?K+CwYxCmZChFIrwBW475m+P3a9X41vgselhvoUdwTfk/rS3bzu66888XO9?=
 =?iso-8859-1?Q?iL/Qq9cpapg2W1RPBpuLKnrBiCkmA+b8NPcZIQ8kxhMyWoQZH18SVCJBHy?=
 =?iso-8859-1?Q?K9wTaqV2KdxvXuDD2KZQfWZV4KJk+rQm455x/m4bDRCjlHpud0/GKXva5l?=
 =?iso-8859-1?Q?+MRM9Ryyi21wu26yGQiWtpPim1P73uc27BwKUFYOO5RSnBr3lwX/clTM1D?=
 =?iso-8859-1?Q?/WtM6nJ5AflLGRmSR1frSmGIrPXBXGMAasVWgUwiqarW1Y/ho5HKeu69qv?=
 =?iso-8859-1?Q?FyMYznU/Dlmqm2kTB669c8Ebk1kJPoWaMSD1S+TfEaULnIVKyhl+zPNehs?=
 =?iso-8859-1?Q?9Onni5VGljdQyOvHifPrOVur6Cj+7bfL0BH/81UWBBzIyoEGx1Y++7vQGE?=
 =?iso-8859-1?Q?5qXG4bv5IpRuvCZidlirUW4r9+noEm2Zbhxx8Rq/9LusnX/pwQYTBLHkyi?=
 =?iso-8859-1?Q?m1i+ffnHdlKGepNuLEJdv/l8pYQuzxZcHQLgkEoh7rYO7AutXG/JjgJ9qI?=
 =?iso-8859-1?Q?tRhr6bb+FozdYNAnc9I50NmV8LcxO+o+PC1p6YTqiH+rX82kJSclim0rJA?=
 =?iso-8859-1?Q?AlHzJxsy/gZMafxC8kIceD8Px1/hMUK4eYsgVTH+YxGBz8M8EOQjq4iX5+?=
 =?iso-8859-1?Q?prM5QVU6goxOQHt/l0Rnsw4KlUD7URTSzA1C+QjUTqlxqnimuotZt1J6II?=
 =?iso-8859-1?Q?hUirux8sWppxzQZyBfwyHhZbZ5B1frnJGlYXGyaTO5LlMA3LYmCzO+bhUu?=
 =?iso-8859-1?Q?eErZ9JigWX/qcLaehwgypdqJ1sXpf4PMPcbcloHKyZC9bFmr/VOgk8xyhq?=
 =?iso-8859-1?Q?vtn3q+lOBHi0+kdFfqWu8IIVO4vYgHTXbrFg0qbTATlOwFoLo/xwAC46Si?=
 =?iso-8859-1?Q?HGoNcPdD7giHaWHFvLDQ8zueTat8ZXBXxJ6GZBz0Pr922XCjXcjVBuEdMn?=
 =?iso-8859-1?Q?4kZl/I4ZLd/4/9oWAJs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07923da4-f784-4469-f801-08ddb3f324ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 14:18:22.5801 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0L6apIz1OtTkISkqllEffQw7uSi9Ix5QuiuslPSAvmE5tCA3Eq25MQBAD51bV831ZVD416EfBxD81ILb97znur/iRYUcuCuiF4nztEVy2YQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR09MB4690
Received-SPF: pass client-ip=2a01:111:f403:c200::5;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

The Boston AIA board needs a basic GbE NIC.  There is no PCH GbE
device emulation, so use an `e1000e` instead.  We place it in
**slot 0, function 1** in order not to conflict with the existing
AHCI device in slot 0 func 0.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 hw/riscv/boston-aia.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/riscv/boston-aia.c b/hw/riscv/boston-aia.c
index 6ed5c636cc..34cc0abe79 100644
--- a/hw/riscv/boston-aia.c
+++ b/hw/riscv/boston-aia.c
@@ -437,6 +437,11 @@ static void boston_mach_init(MachineState *machine)
     ide_drive_get(hd, ich9->ahci.ports);
     ahci_ide_create_devs(&ich9->ahci, hd);
=20
+    /* Create e1000e using slot 0 func 1 */
+    pci_init_nic_in_slot(&PCI_BRIDGE(&pcie2->root)->sec_bus, "e1000e", NUL=
L,
+                         "00.1");
+    pci_init_nic_devices(&PCI_BRIDGE(&pcie2->root)->sec_bus, "e1000e");
+
     if (machine->firmware) {
         fw_size =3D load_image_targphys(machine->firmware,
                                       0x1fc00000, 4 * MiB);
--=20
2.34.1

