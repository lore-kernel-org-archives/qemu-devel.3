Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF60606A319
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 03:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=FcF/Sqwi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ0fz-0003p1-K3; Mon, 19 Oct 2026 23:38:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xJ0fw-0003ol-FN; Mon, 19 Oct 2026 23:38:08 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xJ0fu-0002QD-2H; Mon, 19 Oct 2026 23:38:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=niAgxMOviB//P/2acUOJqz6xcZlm5OMlzXBCX224fV9l9RJQGNFZ6xs11Q4scANC5r1u7bZLVV76ZwrYYi80XTYpdehitSAj77BSm+UrLrGc6Laz4I5WBVeowDaZS8rlFJNwrmVbhgi1vBU8fuHF+DiRDlb8j8iJrncfVQW17iNb5adr5vq1LMun73VDV9CtgLNTJt72yiW8P6Bs49OCy1bTbsMWH1TGrAJMV8kDriM3pYjeZGBnXV4HY9U/Trrwk1w07wq1wCoJez5vmYFIyqQq1E3yvABsI22AclXEIEoj997xjxctYgMTdgGQeDxGpkXZl1ed7IZ3gSxeRlvOpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NzP/rvR5OZBfVffhfpGUjN4OzM9bWtW7p4kWn1G1Fxs=;
 b=sm3iyCkDxWPl+AsJhWILpk77AHf/7sdRSt/PNvkUXnjBAMjl4Nrl2tv1771jc33EFtrWUjUlyZ52dsFpyqLbt7ew1wmiTgmEl2d5rcIhrpDxwx4wnPmMQsKIpnKqAhuF9ey1B5Qj1e8Ojw8Vvg7arXm4ALFFcvhbWef0jZi1+TNu8Z1O6mK12MIbW8EwIQhUYunYepAL6Q/WlcGpwf99/IZYL94INAttApX1wHYElqQhlphUB6DtbNO4DcYKIi8FVmvPMaEfTbXxjr1hvH52RFdoE9xSBDIh0K1yypWM1E1dlMgfiPcXGKhK7IvrunFyR64e2HFZI6HBIMM7psr35g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NzP/rvR5OZBfVffhfpGUjN4OzM9bWtW7p4kWn1G1Fxs=;
 b=FcF/Sqwi3xDONt/Fc9ElJ9svDjKfIG7C2/f0kx2Eii8ijcRf52qs2E+uPWycieUL2hYwA7kvA8MyO0t5spox076Zewj0Bnl7CzOelE1JwHDrhphCgJeviNPEx5UvRVKczWHOg6Np1mOBrP5SiC8mh67Tm6RII5IH4vsZKejLAd4Cux2OZSi5Rr7O0/gTJVXL9DKs7alX2CCj9iZKhRuFvg5OeidaOhoqmYeMStWSScIEk1k210dT4O4B9WRdv1QxAKCHXaAgQet65ven6EyS2WdG50HwpzU5k+8VCQkSY86lJmTt169/yuM4+TJi5Zg3YWHdqQ6yTiJ+5ffmlo5mxw==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SE3PR06MB8382.apcprd06.prod.outlook.com (2603:1096:101:328::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 03:37:56 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 03:37:56 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>, "marcelomanzo@gmail.com"
 <marcelomanzo@gmail.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, 
 Kane Chen <kane_chen@aspeedtech.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
Subject: [PATCH v2] hw/pci-host/aspeed_pcie: Fix global MSI setting during
 class initialization
Thread-Topic: [PATCH v2] hw/pci-host/aspeed_pcie: Fix global MSI setting
 during class initialization
Thread-Index: AQHdYERlr8yuwxi1V0Gk0GJP+kWhUg==
Date: Tue, 20 Oct 2026 03:37:56 +0000
Message-ID: <20261020033755.2618640-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SE3PR06MB8382:EE_
x-ms-office365-filtering-correlation-id: 764251b2-30d6-452d-f0a3-08df2e5b879a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|6133799003|18002099003|38070700021|261009223027099003|10067099003|56012099006;
x-microsoft-antispam-message-info: +nAYyoJwGp3FzLlC1bxWWda4PgCk8K/AFCRjSQ+V67k2gGzueRKactrvsdmWnOCcoJs6Xbb+0PE5XXG12tOtn7rACRh+rjB9HhRXiYbjoMRsUskASJ7p4vLphhR/XjuFCdqyAvwgQrZEHtuXGxpzS+GkiNvUnCQjto1w3SKD7uFqWQmegD0SiZf7MgbnaK58S7wD8mNFzS2VqNvi7x5PNdpeeR6BIqSxHwEfx3B+JcMQA4x7fK9oivpuEfHVIM1KKlQ9yqOGlMcHSh7QYmCH4BgUUaJ9ac1VOqkGHwnfowO3gnW8OedT14mT+NrIX9UnC/LPynNKIGiJXoZi6cFo5q2ysTuS7YUdKPTHsuDi7TT2S2rZUQRHTsYUkSjBni/9Rc3WU6rt2P614/RohjsJ2GJzw2U8meSC3uS9lPpO4rL6rniMW6VLvAFG8thhWF7pfZVppQBDJRKDV27Dd8yN7R+icRBVRwv1DPNI5kzG6AjFxb88k66fdvnhLJTOlgxNQWQJFjj29AS9p9R40Jro/R30lanp1Ue3izblKlewgqS4kpdS26c0ARTHwCA+na+3Vmnn7qqYn73fV5+16ymWgYuCHR8FiFjSo4a3YMCyVeIc6GeTzBw63et+yXeWR+k4rNj4RTpuSP5UEYCti+MKEGID1dQPkEHJtfj5Z6EcBd3x1Fh7c14AF5hrf5EbPLRaoBKVH7zGWzlqYDcuQJKFy+IIaDpPuOgBgU8o5F5u7Lo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(6133799003)(18002099003)(38070700021)(261009223027099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?pLt9R4yCfQUiFnssTspQwrhAITg2kmNK6r9tdsCSabyH1NQsd/JbAzCT1U?=
 =?iso-8859-1?Q?2tVRLeMAQoOYYHQZpa0A/2sLjLYWOvsBc+k3IbPOovrSNdUaSwe71XVLNB?=
 =?iso-8859-1?Q?b8ofRT+jwWrB16Q1MPND0loyjWdKorAHzljxwssurOOM0pb9TpNVIQfX6X?=
 =?iso-8859-1?Q?QK68uKXwSD8s8PCUnWqj+ABv3WDhSxIJD+6LbjXWlsOGRG4Z/UkTRvZDzE?=
 =?iso-8859-1?Q?BUyjCfET3NE7kgoUjozr++4yAaydRWQc8V1pp1SyBCNM6VHYYvybVaV0oX?=
 =?iso-8859-1?Q?rBvcz8KQUoKbBps/NyQN5aO1zF3WED/eBTJKH1rewUgxEbvf01yiy1glVa?=
 =?iso-8859-1?Q?YfB5openozWDF8zLZPfAIHSuNHqhZ2o5eDxuO3w2rSdF7/7NiK1wz2MraG?=
 =?iso-8859-1?Q?FeTY4fckWqpMbQWw4+/UaLVigLoDQdxFcS318RiF40Ajq3SCLNDqjGmvG2?=
 =?iso-8859-1?Q?Fa2fihRqYu1/qw+Sk7bm54TnoEYXCEZoJDFEDSYifnKIVleGCx5MMfD2g3?=
 =?iso-8859-1?Q?wUHEismV1kwxpwPaocSxS7zIH/x0TSFroPrMkFetB3vhAGur+dk4hNjuO8?=
 =?iso-8859-1?Q?kcWciQ/dYTJ+KExCLINC9zTAHEMUYpsJnunsYxHCSLCCI38MVbEmRd6ta0?=
 =?iso-8859-1?Q?PbFVi2E32iuwpZgH7vBhoEREXwoZWBxenY7mJcO6VPIub1ZRPyRZf3ZCHc?=
 =?iso-8859-1?Q?A6MvmXhZCkKlD7ARfXoLjZEcyU09WXlTa2CFlZigU6Rh/SShtfUect2mXy?=
 =?iso-8859-1?Q?F8YhNnRn1OPOExR6UbB4fVUMS1P2MV8asNYUujBEf8Hyg0vSTBrrYMjAWg?=
 =?iso-8859-1?Q?nqBovkSylWiDtxHQCYLiJGW5Aq09p1TXGwMdCXpRYkYWp/r2eHCItMYCTr?=
 =?iso-8859-1?Q?ZCAHl1ZNBuE8VHo1/MWXzmnIrKdGAaXf04nemRAzOmq4MbqPVxetPxkVVx?=
 =?iso-8859-1?Q?kwuytpPPGba0gUKg4Me2BDhikJjGHYsZHtW0GuNHIvvsTHw/SPlAY+Vf0n?=
 =?iso-8859-1?Q?1VFaE2uNcrlmkmhp2iD8kLJHRR1G2y/nZmjFekbXkV7hQXHGVxfHy2KKQu?=
 =?iso-8859-1?Q?ZLtYtm8QysHhYYIAo4/Ou6oTed45LIiYOluYuqahXVUfJDJlZvyEwUdZCp?=
 =?iso-8859-1?Q?kofnKVnHumihTdy4OXpFKsmebA5J9ZaK6Bhkac+LmYCQgH4g8S+MZraL5W?=
 =?iso-8859-1?Q?L+U5eRyg4ObzB+M8TvOM+1rC/jdKMhynb1KwPXCbVBCVsTGIK6OSEkookA?=
 =?iso-8859-1?Q?sG1n6TixRqTj7jGP2Rw2sxVpXI4/Ss/RFCKonmN0wDwhpV2JwiWBJ2J9aa?=
 =?iso-8859-1?Q?8VuOQLJxnn3Gpq5ZCBFUTQa83B3mzG6hErhQqUxWZsHYt+faXtjM1jxfWz?=
 =?iso-8859-1?Q?iusIvD4pf1dCrSdJDVqnt13y0woDuEr30YsE2k2epRCk4Jt65ZYPyQPpnj?=
 =?iso-8859-1?Q?i8VGM8SE1eXjK9QmcNBI/Kr+4wDDKkPJyQHOvwxDq7Fywb2+U0EBwmBZIJ?=
 =?iso-8859-1?Q?lEc/M+OICmS9y6//1oOqnnEBxeXW2VJt+dt8M2tiFOM1Lft/qzNt7UT77p?=
 =?iso-8859-1?Q?/JujjyYcHo/APU2q4NL3AWO5p4YEPJt5v1jupaZis3CJ+1DuROYrUhO5qk?=
 =?iso-8859-1?Q?5tVyU5dTM4QHM9LbOMKnT6dS4FERiV+yXoNimvCRMZG/fINe9155P23AT+?=
 =?iso-8859-1?Q?UVPI6L8/pABbsmMBByaEWAB0kTYXS6zkFmCs8aYeWGKaiLa6R8UvYqdhSf?=
 =?iso-8859-1?Q?TNceKJVCB8pZ/rcLHmioj5EJVTc9/hSmLqTEWnAvqjAypJ58ZTT0CVVwKo?=
 =?iso-8859-1?Q?bzzExrgQ0Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fK1bfmNghwq2yaLkMQxmLjwC/hnTyX3WYNGAYXM1wwNJmgq6s4HC0Nl9NimYPkxalva/TBBn4imrWUG/ifr0Zder4t9pg7xT7/IeXayAgApJSeIP5NWk/OeLMOBqFyGFR6HN0W+OXXEsMoqvcReCLEzzjeCT5fHT1ZffcGwfKT9AmesHx+ygQ5xPb5Z0GbrXSue4jAMLIcvzMenq0moEFkHG0sLDNmEpjB8TGucx/O52BfKguCoATPV+C++AVi8iYiWd5N93TZUxDq7PG/Qy3+J2/Bec9ULxUqIyjWLKeij9cl8GYa53aIj3QClvvNihnqHVNg4qVsPHqcTOLiUcHQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 764251b2-30d6-452d-f0a3-08df2e5b879a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2026 03:37:56.1854 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xQNjQMFnoOM5A3IuneVfsgRX4yvTMt/PvM0C4CR/6+n/4xylt/WIErHM7uAgugLtyOA9ybsthNdOB7XFzoNohBbJWt5OA/74dMyEUh5fD0k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR06MB8382
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The ASPEED PCIe class may be registered for machines that do not=0A=
instantiate a PCIe root complex. Updating the global msi_nonbroken=0A=
flag from class_init() therefore affects unrelated machines.=0A=
=0A=
Defer the update to the per-device realize handler, so the flag=0A=
changes only when an ASPEED PCIe root complex is actually=0A=
instantiated.=0A=
=0A=
Reported-by: Marcelo Manzo <marcelomanzo@gmail.com>=0A=
Fixes: f002aa35f320 ("hw/pci-host/aspeed: Add AST2600 PCIe config space and=
 host bridge")=0A=
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/pci-host/aspeed_pcie.c | 4 ++--=0A=
 1 file changed, 2 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/hw/pci-host/aspeed_pcie.c b/hw/pci-host/aspeed_pcie.c=0A=
index b46eb74234..ceb010f213 100644=0A=
--- a/hw/pci-host/aspeed_pcie.c=0A=
+++ b/hw/pci-host/aspeed_pcie.c=0A=
@@ -181,6 +181,8 @@ static void aspeed_pcie_rc_realize(DeviceState *dev, Er=
ror **errp)=0A=
     g_autofree char *dram_alias_name =3D NULL;=0A=
     g_autofree char *root_bus_name =3D NULL;=0A=
 =0A=
+    msi_nonbroken =3D true;=0A=
+=0A=
     /* PCI configuration space */=0A=
     pcie_host_mmcfg_init(pex, PCIE_MMCFG_SIZE_MAX);=0A=
     sysbus_init_mmio(sbd, &pex->mmio);=0A=
@@ -294,8 +296,6 @@ static void aspeed_pcie_rc_class_init(ObjectClass *klas=
s, const void *data)=0A=
 =0A=
     hc->root_bus_path =3D aspeed_pcie_rc_root_bus_path;=0A=
     device_class_set_props(dc, aspeed_pcie_rc_props);=0A=
-=0A=
-    msi_nonbroken =3D true;=0A=
 }=0A=
 =0A=
 /*=0A=
-- =0A=
2.43.0=0A=

