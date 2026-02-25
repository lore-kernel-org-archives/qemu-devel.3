Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 688ABF357D5
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 10:23:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvC0Z-0003zj-OS; Wed, 25 Feb 2026 05:20:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vvC0U-0003x7-Sk; Wed, 25 Feb 2026 05:20:41 -0500
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vvC0P-0002uZ-VN; Wed, 25 Feb 2026 05:20:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oZ1S7sUB6Xy60wd0M+obX6xKFniJN2q6AfIu9qWtZmXNcNA24s36+XYBJ0tRONQDH3Io5Ica7twZDKTDNGO+nZ52yMeMrtq/AU4fKxz4vQp+dDfL/jKIJpA0d1pB3R4GRgf1ixboW7hHGgbuISKn+b0Z+4L3B7+1nyFFF2HD5GIL/ojLBgmsfX8E1MQa+sjz/vxgXxNwCWC0KtTLmSXnK4EsYEWJtbpzKIg5yw1EwM3YYfZMIQJvMfRzBEhQjZa5KC+aY+RuhdxF4WcbiikSHGQhHu2PkSbbA6JC5hruH7TrxCdHTgNochWqwYpgNMtxJSjfIae4IMh4et3TSCxC0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bCgxKXYJaWm8Xf1BtuaEa1xsD1OLHig3kUfoLEsDSuU=;
 b=iTCd/uS4oiXpBSy3mhR+iUFvZzVWu9xoQfvzFUS4JstrnlIV+hPYSbjwgvn6l59JvJ62P+46aX2a/KZJCXMCSEvRX6kU8ZXkc8pYcolo5w4UZO0c17QEABAm34XaQfCbZgy9PfqKTwWOZEbsck3sY16/ILhGWor7TvezNk+K1svm6Xt5oiXQyuDX71RW2dGTTNCa38Oc56zUp2T+rYBJ1m3Pp0qoCcRKi0vpXUOC5Ve51a447CduPCNrl2IJTIwzt7dWlATAmGdGB3d75jprMIMy5QnXVAV5rfUwu9nrphjRR8PYTn/gmV7eaIpp4e3+BU6t8au2lTtK+EYcgBdMuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bCgxKXYJaWm8Xf1BtuaEa1xsD1OLHig3kUfoLEsDSuU=;
 b=UYzIsCiP8xj36Ct5bGTE+GtUOKDOsi9vQoQPmX469Hm8DVQkxU16j5XNXQTO6odZ1w+b4zahpYFDluDnLHpLzJAmRjVq8R73ZfjrvPlT3/1uiaCoEB/bxvibClflE+Dpc+0HYP4jca7ZDy49RvFrykpR+c59yodlpo3BZ/YR/jAkT4CxtAApNUKl5mYS3ue2+q0XN2yhXo1ow8A6hTrUH+3mfgQbwxJ2iYfA9BmmIiJNBD9JH72WccEdjxwvW42fvFKR8lAi8a1Ka7lyQE/9La6TAYrFyRne6JxOWlTMbtBgV+PpKqUmHWhfeqCQI2vuiQ0HI7nawWWOK7RsI68G4Q==
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com (2603:10a6:150:358::6)
 by PA1PR09MB7406.eurprd09.prod.outlook.com (2603:10a6:102:466::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Wed, 25 Feb
 2026 10:20:25 +0000
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63]) by GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 10:20:25 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v2 00/16] Add RISC-V big-endian target support
Thread-Topic: [PATCH v2 00/16] Add RISC-V big-endian target support
Thread-Index: AQHcpkBaA1l4l1CIU02NL47xpBxJMA==
Date: Wed, 25 Feb 2026 10:20:24 +0000
Message-ID: <20260225102016.200654-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR09MB8755:EE_|PA1PR09MB7406:EE_
x-ms-office365-filtering-correlation-id: ca72ca92-0f11-4b2d-b870-08de74577d7c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: HwQyJ1CXW4gpX2zfUi+zSts/mBjdN80m6MbFq4CjZwHK6Uh3p/VgVOKGbAtz5meBUGKs38yjJgQrwvf0ToLCkbqoXt8QDUtMMENuzqj41BTIKUUJM3G6LY5qNZvWuv9VpAEkVLkN/2BF39dcS6fcx2I2HO6btnBX/vVbENyPt2CcE8U+pa6MSwIMRDFza+jbcMg3UB0ZY+vABJQxQn3Swy52TOJ7YKS+bLurivArZ4qHQ26TlydkD5yoENkC8mnWI7BH/kETyxiIknztt6a6EjVn/nrYlUj5yf/9+5VX6J77iJ6cVnuP0VkxAKujjthUhcLkgpVH3+ItmlJnQak4hmWa+Pa7mA3hDR26A3TI+edxOj9Lq8n4jnS846LUO0ET0Cyz8Dk+EEZg1T9jOZkphC2b/vdxGaGHG/zh0mo7d/Y02lFX3D3LFS4YkOEAtpkUh9ZQEcDg7HJ+PsXA/krWlUAn1fwNfH8pnNV/hd7Fn3DSMRHWLYmn5z74EUCXZwstjhH9Z5IQJAkts8WXfuoJTNMnrpmC4IBqonxXdOvaeyaACdaBG8X0yZJMMQjROosc4X6WYN8w6wH+xrp+FpoDhvl90dQhVLR/P7n4uOXYquFqckArowTHV/BB26iW138ulONPdX1Wt2ktfrPlnenW+H14Gw8f/E2tQR6zoavsWJ6lBS48/xFK9BvlPecVdPkyJHPODDUZMaPlMk9HH9opLOfnRjDKuMjBh3uPEV304pWJHjMnKTBhKeLO0CxKr+9ZV6Wdtbl8Z4lEvblWkL4WNAIfastOkU79CL4CbUB1tRc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR09MB8755.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?MWWVLIWZXXOPpdLeErMQzkryNC2P32K6d331cSTg8Rx4Mg2hrSWLTAYK5m?=
 =?iso-8859-1?Q?zBRCgSA7sb98DA4y7CiNC2yy0DnRCDA+gG82cvcdpnlxtOxVjR7icZ9YFb?=
 =?iso-8859-1?Q?3s4rv8SA/UQU8fh6p0fMHzHtgncutEY5ayb1HGbAjpaBwhBKd5c1e4wJR5?=
 =?iso-8859-1?Q?6Lj9GIYPVfOXwFzS6vXB5KXbsxM+tgonKJpMlhAeN0MLRpbGuTSpnEHQM/?=
 =?iso-8859-1?Q?tBvEf4d64hmRxUCc1LvPO+dmGrU+ZtRYWNbDeVa6bZVffkN3zIH4abmF6/?=
 =?iso-8859-1?Q?4kqKD+qiM3BmjexP4VacmZyDYyMnccuAyPF+HJxvQ8tUSR4DtFjVjQEGmU?=
 =?iso-8859-1?Q?Rrq5cBis7dueLO9XrxogcLljF94iis7fGd554jD5FI24Y9aYZrOgOXg5uk?=
 =?iso-8859-1?Q?m0ixj11RLSlTY6/eHS4szy7KqtoGeAEpC4E0BYXAy9ZEgK++7VKRK0wzY6?=
 =?iso-8859-1?Q?N53bMsCQDNVxS18P/ocqwT5l9I59Lvhfm14H9AmjbSGVURUTXi8bw7ApFF?=
 =?iso-8859-1?Q?L1OirFcEDR1WuFM+EUJKyKSOCbt/MV8J5QFp3+XUm47ofwglBejX/s6FH2?=
 =?iso-8859-1?Q?8qNXg5BSPEMTZdNOI6Lgs4x5k9ByYjm8OEnYIwcuKWdyYv19JbWrStNZuf?=
 =?iso-8859-1?Q?M9l/dInxhl0y48Hv71aSIWDAoPIzGSG2cUAE8h7Q3hIia6nzZV94T8dfm9?=
 =?iso-8859-1?Q?un13mS51qWYRYmxsPIBCBB9D9dJyiTYokIxSWfF2K/iSjMuWE6Z+JpZg6e?=
 =?iso-8859-1?Q?LDiUcTOCelbZXohDK3qfmjW2A5EZdma21uO+kxCgGCCFfSwwYA7HwwpECH?=
 =?iso-8859-1?Q?Bme7RWNSQdmPU3ZnJquRc3zCm+r/iLxqRu9jBvknDiglTjOHye+/mkEPgz?=
 =?iso-8859-1?Q?uEnKARWcUA2UDZY+9KX+6dY6v1RkORdmTeD4LUpBJLLb98BPL0kjOx8Fab?=
 =?iso-8859-1?Q?JDwVhPZcGTu7ymNvRPC9OMBXZxMjQLGXfjVPBfpWHMcO4vhq8iWSuSlgzj?=
 =?iso-8859-1?Q?52vcVigve+5qNByDmeaz7HZsML7Pa9Uo7r73LvBCfLpumFpDn8fp6fhiE2?=
 =?iso-8859-1?Q?XZDvTR3AFYmavef/JCx5qkqJXuCMEyXBY+ReeK03iLFng7bFMYcfaFwM71?=
 =?iso-8859-1?Q?1wIdSP/E3GSlhF/kY+D7GoDKX2vIEVWl6iLcSxduTKC6RFbtwAwzrg2O35?=
 =?iso-8859-1?Q?xCgHmTe4fkunrLTBYA/Zl6ouiXD2aNl2nCGU0bdLjSfMV7Wv9mUwOu+uj1?=
 =?iso-8859-1?Q?WkJwXQG/ONAi7zDgFR39ly19FlazccFwwHaJxGkRwoZTSWBF340PBHhaGY?=
 =?iso-8859-1?Q?wljwfAJ4+zOsKQ8nSgBIf7HzKjKE6mxu7KLM4HCaHrvIPinYGTET3FEeHC?=
 =?iso-8859-1?Q?fHm+i3XvSpqTsUxgx+yuJYHgkHrMRHafK56UiXAUIzK9bSRb6NET8wWTby?=
 =?iso-8859-1?Q?Q7Q0k7NJiSAeaXUd0FDcVKJjt4f47F+4JNN+hbuw/tvRFerd/M4+N+6Txv?=
 =?iso-8859-1?Q?cyl64Y1kmYYOBNLTcbTzMqT0AX5svvwDendtcujggWDQCIGxfo3IZ0GXou?=
 =?iso-8859-1?Q?o687eo6iZGZ2HTbGyOKMWxC76AI9OoCeg+1imIoRXNulkzc8KLyF07+CjI?=
 =?iso-8859-1?Q?thMN35iMBgkKyFV6cOhuQcXFqYF2CkAz5f9koJg+2mXsJMzFn7RFPAwSkZ?=
 =?iso-8859-1?Q?eu9GJoJsCs75G0kXrIZhw5zgfFzMkRFN4tIjFESQuUcMDO9dFfp+FlAnoB?=
 =?iso-8859-1?Q?PLNTNvVe9DTa7EiKTn5iga7k9W1sNu7yLACrnxTvycItsSSXbAOhyF9uim?=
 =?iso-8859-1?Q?VhsgXBMbITxLVZGLHcOfVEI+dWIec7LITPZHmiEURdQ+P7jrWdZj?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR09MB8755.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca72ca92-0f11-4b2d-b870-08de74577d7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 10:20:24.9439 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VbMx+MY0rIQjBl1/Ep7Gn7EOIQOG7aIZrjVLGyz7gHilZzTST0WHnUmjucLDskJWmoH2Efs3oxxLpAZzxFdEB/HDqdHp8cAZELpi7ndV560=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR09MB7406
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
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

This series adds big-endian (BE) RISC-V target support to QEMU,
covering both softmmu and linux-user emulation for riscv32be and
riscv64be.
=20
The RISC-V ISA supports big-endian operation via the mstatus SBE/MBE/UBE
bits. While instructions are always little-endian, data accesses follow
the configured endianness. This series implements the necessary QEMU
infrastructure.

Furthermore, MIPS announced cores with BE configuration:
  https://mips.com/products/hardware/i8500/

Patches 01-03: Build system and config for new BE targets
Patches 04-07: Core emulation fixes (instruction fetch, boot ROM, ELF
               loading, fw_dynamic endianness)
Patches 08-11: Linux-user BE targets and vDSO handling
Patch  12:     Set SBE/MBE mstatus bits at CPU reset
Patch  13:     Fix PTE A/D atomic update endianness in page table walker
Patch  14:     Clean up instruction fetch to use MO_LE directly
Patch  15:     Fix virtio-mmio legacy device register endianness
Patch  16:     Add riscv32be and riscv64be to SysEmuTarget

Djordje Todorovic (9):
  meson: Add BE RISCV targets
  config/targets: Add BE RISCV softmmu targets
  config/devices: Add BE riscv configs
  target/riscv: Ensure LE instruction fetching
  hw/riscv: Ensure bootrom has correct endianess
  hw/riscv: Ensure proper ELF endian expectation
  hw/riscv: Check endianness for fw_dynamic fields
  config/targets: Add RISC-V userspace targets
  arch/riscv: Set UBE bit on BE target

djtodoro (7):
  config/targets: Add missing fields to BE linux-user targets
  linux-user/riscv: Disable vDSO for big-endian targets
  target/riscv: Set SBE and MBE bits at CPU reset for BE targets
  target/riscv: Fix PTE A/D atomic update endianness
  target/riscv: Use MO_LE for instruction fetch
  hw/virtio: Use DEVICE_LITTLE_ENDIAN for virtio-mmio legacy ops
  qapi: Add riscv32be and riscv64be to SysEmuTarget

 configs/devices/riscv32be-softmmu/default.mak | 15 +++++++
 configs/devices/riscv64be-softmmu/default.mak | 16 ++++++++
 configs/targets/riscv32be-linux-user.mak      | 11 +++++
 configs/targets/riscv32be-softmmu.mak         |  8 ++++
 configs/targets/riscv64be-linux-user.mak      | 11 +++++
 configs/targets/riscv64be-softmmu.mak         |  8 ++++
 hw/riscv/boot.c                               | 41 ++++++++++++++++---
 hw/virtio/virtio-mmio.c                       |  2 +-
 include/hw/riscv/boot.h                       |  5 +++
 linux-user/riscv/target_elf.h                 | 10 ++++-
 meson.build                                   |  7 +++-
 qapi/machine.json                             |  3 +-
 target/riscv/cpu.c                            |  3 ++
 target/riscv/cpu_bits.h                       |  2 +
 target/riscv/cpu_helper.c                     |  9 ++--
 target/riscv/translate.c                      | 16 ++++----
 16 files changed, 145 insertions(+), 22 deletions(-)
 create mode 100644 configs/devices/riscv32be-softmmu/default.mak
 create mode 100644 configs/devices/riscv64be-softmmu/default.mak
 create mode 100644 configs/targets/riscv32be-linux-user.mak
 create mode 100644 configs/targets/riscv32be-softmmu.mak
 create mode 100644 configs/targets/riscv64be-linux-user.mak
 create mode 100644 configs/targets/riscv64be-softmmu.mak

--=20
2.34.1

