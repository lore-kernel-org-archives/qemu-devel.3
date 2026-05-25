Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA99CD5BC7
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 05:32:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRNu0-0001Th-IZ; Mon, 25 May 2026 01:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wRNtu-00017i-Ds; Mon, 25 May 2026 01:30:54 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wRNtp-00035Q-Um; Mon, 25 May 2026 01:30:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HeF/iLxTZ3J8Socs89l2jc/jcWEifiKxlbK3+rprzGZOMs3bUlXiOveHlfAQ6JWceVRd9e+p0XtQVvRGereceCTjxdz2gnIAC2yZrFldM49ndDrT1e6lX30xeJY5u6duOGHwjbsmEGD5VyhqP5E0FbVr7zvrQKH5lv3/yyKUTNmVpUQ/8oSOFAfN14Ydz4mgDAWsWghbxIrKmwiQv2sqk65dQvtkiUpKXlpblS3sHrxwRaG11s6S/+D4SuGmDk35jz7h2w9WnI23F5OQv1ugHo/8+qxaIC8BK6MzNeGCDVtxEhUyQ8hXw+f2tH9pB5+27ObK2P0jJH86He75eIMd5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MVMEx30Ew6n2Vtm7Kk4FRywrFwbzHE1E+fwVo0Mro+4=;
 b=CZfwSGXJ467r+ZfE6EOKzMNY8/YEXbpRNwzYsFpfOSBS9sNd1Moz3Yzlr+jbZGIgRzi5p0KUhvn42/S2GWjdA0RSXKBvVXncjdeh2+ixShptB12JT6DJrujIUMZBZ3UvNG9AmIdKgFeOODn9ipUS04EB3Na6wIGZRix/NRa0PmTi2QOLOdGD74Ap32rLHQTIr0K0i3yrWKklJner9m9Cs8FTKw8WmXzqUEOZ+/Cn5x8Y+4Aik6tLFOTqN4RLaeCbyKtAS/HQjWDZgZEgjlTQzftAto7WizyTzQdu+yCbsVLmjmFnOyVylbfIA6yB+fyzMZ5+AhcCk5z4+/aCERDcuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MVMEx30Ew6n2Vtm7Kk4FRywrFwbzHE1E+fwVo0Mro+4=;
 b=aKvoS15sSwxO0Dj6yZQR+Bdc2bUklg1hjqJhnkgUCGZi0Gi5TQt1Ur55z8gO1zAVr/5FJFUMgwlWAcacecrfQi00/A5VwBvCOxSAXfkybwhSuFZ9xdxuB1flhdDfPMKKkMxAvi25HSsH/bkwg1hKzp1GbPrD0yVt+eI74MpLDSSwx0TCBGjXnwax/mmhS68MC8sYxOUKAXo1r+8gV2+5XruKjuU/zJC6Ssv1csNwZVYAiqyw4SsPSa2l6IcyIKWalvSdujZsRUGbBnmsycyfzn5QHh+Km9zSGJXGNGc6TuvpMepAN3s/p9NGkmWiKIPX9pXDj1IpztzPYuyhv503GA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB6657.apcprd06.prod.outlook.com (2603:1096:400:451::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 05:30:40 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 05:30:38 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 0/9] hw/arm/aspeed: Introduce initial AST1040 support
Thread-Topic: [PATCH v2 0/9] hw/arm/aspeed: Introduce initial AST1040 support
Thread-Index: AQHc7Aee/7S2NsUY4UGL635R1+NscQ==
Date: Mon, 25 May 2026 05:30:38 +0000
Message-ID: <20260525053036.3305181-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYZPR06MB6657:EE_
x-ms-office365-filtering-correlation-id: b6a1572f-8f09-4347-13ab-08deba1ec111
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|56012099003|38070700021|921020;
x-microsoft-antispam-message-info: KvYPDQ/DHauwwKl03wZwpKS2yoRrDlY+DXhGxJqNLc3ZdkFrL9eyl2G2GD5A2XvRPxCdiins90ez7qFPtef+/Y7Vpm6+V9frGesDeh9q4qsrwY/yGLL3N2QILJrVWH/c4YTfKi7d+8On2aJxYiLwjVpuTlm+nj7pz/baUgDi/uDpU15tNzuTzgX583Qzx761UK4U4dIHkkcmoiLJNmfWEb+hvA3lB0Hkx1FQFP2VsajKJXb8tOu90Dr+nba0UcClS2QNfZ3IBfmXs8as3qbM5IpnuwlAb5mr8FigKTI2xi6c7E/dIcg/AZpgisK1tukOmanJWCJRfF8NPxBKuUmWmr7uJUyNTBVN1ZgPkBtv5aXLgAHwySPUlznOfwlJ3WLn19epwCJu5xjA3iuGHrKB1kBIZvv7c/OySw2P9Uv9dPZtuW1PlNv+PgPS9vD1WdSxWGjDKECDjbtawuMZkhvWQ5FPqU4e4nsSJiH73Kheo/UJp0BTOIxeyQyv6cxXhI+Mxj5mZE0Fu9Kfljwd0AwNFNi8LNFItKHZUoqDq52D4acGuJTMhdZr+Ik/S+YGphHmVRW7TtmdajRxnwHrByWC3OIh1qF610QmHs9ylH/PNg+AcKYq0DTWqumx9PoszFeD8tqpYeMzHJFh77+Yuw7IEwofba4VXQMhSysxo1qv4UCCtHvyLaDdOx3o7ql1hH53aaNT5tgaEoFknXhmnzhMT8Z3YDkDyw6f21+JmlTHg+nH+5Wei26S/dv7si2BXNqs/M0hB7GH8ih8oCemDxuJ/g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lVWl8s0ZVNh6qWqVSYvXZmaGtZElHpjAa2Hn+4NhZ1J9yUA6/WZ1djZDLi?=
 =?iso-8859-1?Q?kxaJGX3HN/CTXoizLLiHMu3D2RgR3LDLzORYu0L0m/0xG+5ZR507cG5riY?=
 =?iso-8859-1?Q?lHUY93ig9Mkv0hgT//Nt9645vPwTOlnzTceqL2hK2i4cXgZsiGQ+xvKrEu?=
 =?iso-8859-1?Q?tO8gw1A4jMj0Dc0oUXPxcsjYYeBHHCpSKS007q63UtrMbu8Dx0T5YIh0aE?=
 =?iso-8859-1?Q?mg3LBBDdEQkSDII9d0j/YfLZutyXLjxNfIXb7qtrpsXFa7bY4NXAcMAyuH?=
 =?iso-8859-1?Q?ob/7nbICg0SAWAkKq7LmGtRz1P5qdQp4kU2hwyzVss+yCC7tK3x3NINkju?=
 =?iso-8859-1?Q?M6ArvdCZNDwxu4YpaCbhgmgqHg6TFZYA0CCFSib8GIxl9b7A6VxppZ+Hvo?=
 =?iso-8859-1?Q?5KD51fo2ZLWs3l1bsiDlPEjm1I4CXK/PeTjhTxs1BuOVuT0MrFO7yTAQQ/?=
 =?iso-8859-1?Q?OKxFwRK0O0T0D85VuIB/vkIrSkWK31eUorXsuPaPuYWUka4RUZ8c9ap4/3?=
 =?iso-8859-1?Q?Tan6b5TswHLlD61M1OlJjpursgJaTWEO/6QV0yaMb3U/clIB+fFNxKmi9t?=
 =?iso-8859-1?Q?UcK5zAFD6TxptWdUJBVH9rXIYRJl/Kpaf0JhSM6iwI0yZ09geW39nWRc5H?=
 =?iso-8859-1?Q?yuyCQSkqVoIaB/gX+/yO6+FTEgvDvqOH8adURX0EnMt4ldw9Jh1nnbWVF1?=
 =?iso-8859-1?Q?D1D3zMj4ZAqZIOqNIhyP99v2Ez3oP3bQ4H6ZYd+9KftCQkofExlSaVYouO?=
 =?iso-8859-1?Q?9dnbUIaE677FEGxKDah3qIMCVF3SyccqN5KBrl5HDqAwsoY2SfwR5SFl7C?=
 =?iso-8859-1?Q?Pa+QRx0kdJN7ASJHJtV7a1gVnZH8WF0brcp5cjhBlguVcYq7ROAaNdqL2H?=
 =?iso-8859-1?Q?ITXxIbY3Xtpvif8IeJPK940bwsVjKaqJAOqzPUJv79pSkxqlSlVY4DJnZF?=
 =?iso-8859-1?Q?8vM6uX+qHE2UGDsD0gik8yn927vnQaMvfwmavZFDFhFDtqinx3B2ulWk2w?=
 =?iso-8859-1?Q?08jY2lYG/PP4c72AOoPBlBWN8qvrojFGX0X2WDvowd9h2Z4T2B5c/CqC4x?=
 =?iso-8859-1?Q?M72I+fLvk/ijdCtjZ7SE3dOJjfpYh+eiMcfEd+7QJ09OFq0i0HX7rI02lJ?=
 =?iso-8859-1?Q?uRph1twrIlJZI8DG4SGiv3DLiUpkBxZtAaPCYgafY7+moynz/NXMj/k16Y?=
 =?iso-8859-1?Q?i1qotMGQaqBdy64YZLwBSH0fdXlKtCvNLvxZcKEJQdVh6G6RSnYV9cnLpn?=
 =?iso-8859-1?Q?bMlanAJyEWfSnahXDH0n8C50pgELm3crQ9urhJ//Gtku7wiNEW0xOLNqrJ?=
 =?iso-8859-1?Q?EbSuqpfXrFJcLEEGVranjG3agrJ12YRf+r6sDAcu7FhiSPJYgBk6hy6tGj?=
 =?iso-8859-1?Q?UPw7JcxAJAiF/4XTxWJJbcFij7poqQJL5GB6hN0wv4QjQ9B6LppdJ21bVB?=
 =?iso-8859-1?Q?fY8SOTTpXotE/g39CAhzRjzPpZkasMD8DCkZC1eAVF5ya7FJuWXoOFzAWb?=
 =?iso-8859-1?Q?II3rBfbH8crj/1iYthHrWENbZbbBP1hU2EHhBuzKEaZ7/jScNRWx1+t4XM?=
 =?iso-8859-1?Q?bij7gL1Y5WXPNJgelT6yNwjvmOPPiB5uCLxAxBzhzp+OxqtLw+ZJD84e6Y?=
 =?iso-8859-1?Q?2bttvObx5EzhBPaqWeAvNGPq8ViTUF0/FKk1dKD8V8od5Rp+r0XETA+JjH?=
 =?iso-8859-1?Q?gsy+3wtoyh6siSx6//uccdLJoIM6QgYf07fBzSE/yvSy70UxpHwKg1iAKl?=
 =?iso-8859-1?Q?Jj3Cm1HBCrnNh7G77/PinCbVWxqq1Zr8UhkLPoPg5UU/gm5RlJKmJMEb2g?=
 =?iso-8859-1?Q?oKDC00XkbA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HxvsMpBvPzsSQ21092V8lHJDMmzSVY5uk/n/1jWxKA+U5Yx4HkFyf5ZqltxVdNMQdtYqJ00O6atSPilsztNAOwKV79D1tM4YBOMo6zK2Aa1ZAddCxxBdbQnKkg7SSnaiwHfx6GffjrAwjvzJZXJECh00QGN8TK6mlxVpuS+14YxqWG0w+urIr6WIVOcPEoiKeDy3EoYNzGM2Eh+zt8vZeMUjfgc/HSMzKySGh5uf073NbGk6YKFDVSAK6pXGDzG9yf8TDVq/L122JwrYjU4uAwRB7pmu0xzjr2XrSXowYEpczdnuk0VtlvTF84Xaf0X8UFeMHOZDUSTUM/A+tZyyCw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6a1572f-8f09-4347-13ab-08deba1ec111
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 05:30:38.3946 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VDlzndvksHo0wzyMk3uX+1f5AosdcyIVmyKyX9yA7D/NloBJwUhUX2rH5oXuyCNW7Xo6KMCcDjMtU6JLuWtJnrpBK6j/Qn+1aHPyo/jG9+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6657
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This series introduces the initial ASPEED AST1040 support for QEMU.=0A=
=0A=
AST1040 is the next-generation bridge/BIC controller platform=0A=
following AST1030 and is based on an ARM Cortex-M4F CPU core.=0A=
Since QEMU currently does not provide Cortex-M4F support, the=0A=
existing Cortex-M4 CPU model is used temporarily.=0A=
=0A=
The current implementation provides enough functionality to boot=0A=
basic firmware environments with UART console support, HyperRAM/SRAM=0A=
mapping, and NVIC interrupt handling.=0A=
=0A=
Currently this series is able to boot Zephyr successfully to the=0A=
shell prompt:=0A=
=0A=
  uart:~$=0A=
=0A=
Example command line:=0A=
=0A=
  ./build/qemu-system-arm \=0A=
      -machine ast1040-evb \=0A=
      -kernel <zephyr.elf> \=0A=
      -serial mon:stdio \=0A=
      -snapshot \=0A=
      -nographic=0A=
=0A=
There are many different types of RAM, including DRAM, SRAM, SDRAM, PSRAM,=
=0A=
SECSRAM, and HyperRAM. To support these memory types, we need to introduce=
=0A=
distinct variable names for their memory regions and memory sizes.=0A=
=0A=
In addition, the SoC contains multiple SRAM instances. To make the code mor=
e=0A=
flexible and maintainable, I am considering changing the array structure to=
=0A=
support internal memory types such as SRAM, SDRAM, PSRAM, HyperRAM, and SEC=
SRAM.=0A=
=0A=
For example:=0A=
=0A=
sram[NUM]=0A=
sram_size[NUM]=0A=
ASPEED_DEV_SRAMX=0A=
=0A=
v1:=0A=
  - AST1040 silicon revision ID=0A=
  - SDRAM support in the Aspeed SoC framework=0A=
  - Initial AST1040 SoC model=0A=
  - AST1040 EVB machine model=0A=
=0A=
v2: =0A=
  - Add AST1040 functional test=0A=
  - Add AST1040 documentation=0A=
  - Convert SRAM MemoryRegion to array type=0A=
  - Convert SRAM size definition to array type=0A=
  =0A=
Jamin Lin (9):=0A=
  hw/arm/aspeed: Convert SRAM MemoryRegion to array type=0A=
  hw/arm/aspeed: Convert SRAM size definition to array type=0A=
  hw/arm/aspeed: Rename SRAM memmap entry for multi-SRAM support=0A=
  hw/arm/aspeed: Consolidate secure SRAM into SRAM array=0A=
  hw/misc/aspeed_scu: Add AST1040 A0 silicon revision ID=0A=
  hw/arm/aspeed: Introduce AST1040 A0 SoC model=0A=
  hw/arm/aspeed: Add AST1040 EVB machine model=0A=
  tests/function/aspeed: Add AST1040 functional test=0A=
  docs/system/arm/aspeed: Add AST1040 Bridge IC evaluation board=0A=
=0A=
 docs/system/arm/aspeed.rst                  |  18 +-=0A=
 include/hw/arm/aspeed_soc.h                 |  11 +-=0A=
 include/hw/misc/aspeed_scu.h                |   1 +=0A=
 hw/arm/aspeed_ast1040.c                     | 254 ++++++++++++++++++++=0A=
 hw/arm/aspeed_ast1040_evb.c                 |  73 ++++++=0A=
 hw/arm/aspeed_ast10x0.c                     |  29 ++-=0A=
 hw/arm/aspeed_ast2400.c                     |  14 +-=0A=
 hw/arm/aspeed_ast2600.c                     |  10 +-=0A=
 hw/arm/aspeed_ast27x0-ssp.c                 |   4 +-=0A=
 hw/arm/aspeed_ast27x0-tsp.c                 |   4 +-=0A=
 hw/arm/aspeed_ast27x0.c                     |  12 +-=0A=
 hw/misc/aspeed_scu.c                        |   1 +=0A=
 hw/arm/meson.build                          |   4 +-=0A=
 tests/functional/arm/meson.build            |   1 +=0A=
 tests/functional/arm/test_aspeed_ast1040.py |  35 +++=0A=
 15 files changed, 424 insertions(+), 47 deletions(-)=0A=
 create mode 100644 hw/arm/aspeed_ast1040.c=0A=
 create mode 100644 hw/arm/aspeed_ast1040_evb.c=0A=
 create mode 100644 tests/functional/arm/test_aspeed_ast1040.py=0A=
=0A=
-- =0A=
2.43.0=0A=

