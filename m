Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68CB4C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 09:23:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whOSO-000475-M4; Wed, 08 Jul 2026 05:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1whOSL-00045t-Uc; Wed, 08 Jul 2026 05:20:37 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1whOSJ-0000N4-2s; Wed, 08 Jul 2026 05:20:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vs6Vci/WL79XoIb8DyHpmAnTAUsvc7W+EtURrDEwvDqq7jaN674UXxpUl781zpjr13uOYeji3Ww1HL2wcXXSqs3MzKCZ0kszzG4EZOyfitfej6vYJlQrzbLBgFYY9juj2v9X9Np3kxvosAcwXRSI/LSl1w2fSI67lEp8Lx1t9yf0VjvC2b1wC5NXOupOCVM5dYnkHniADzr7Mjp93SEHDqQbM0P+B9TMhLSU5/UnUd0bC1Doa96XD5TIm/COh7xThvChyQnxpCOUF2/MhVJeVclGesgo4J5gLxhtb2GHFSDQTiCpo2IPR1NLCDAuPVbQxUNK+uKjoxtO2p/RmuStSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9X66lizawHTSjE//ZjP7pXZtRXso0WAdODT8RifzfU=;
 b=sFART8US1aAh3xbNUo3qS6PDlZZ7aT7UhMtpzP3u58DOvJUrj7V9ujmGp3ounikMfoTPXrg4UB4ZA/HECjaN53OW4cCHsS+uX2vLq0j6NHiT89yKZ1bmzeEvnLqADgeyu+zifXifDhZOy8Fw7Aw4OHhryZ8YNI04emhJGw68ymuCwZfRGybxSTLNxe4rYCCTw/ydBj1S6r0jWotLephW1WIGN5Z6m4GrcpyWAEcrysIcO9Zb5hfyIWlSCW7+Zpf3sIz7tOLuKU5XiFXHE6/vAnHoDCumfgA6rDRBsEL0YrFeJug/DqRxRSKsSGY9DGZrzjQFVwUSG09YWf7gFCS1oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9X66lizawHTSjE//ZjP7pXZtRXso0WAdODT8RifzfU=;
 b=ien3ddVUDQWNGlkm98uivHLumzP84owW67w2mESzzINPABfS7DbROSDmPhhZC8628mjAZsW/LvmDIVUdzQH+WjCCyc4YwO029cNeu0Zb9STFbhNvJH0zRliUJ9xl2KAzTnj+cdPmmr0bEZe1bu700vqDkvUv6fW/FXLtpkHnqjvlLUZ/UTQd4H9y0p8ywS1SDsHATf3pWp7MGRRVlMPZAgRLgIu41vEsF0UycNHmZzg9K/1UvYIqQWz3AnSjzW3/+zPAdnjTaK8bJM1Tf2YOf0GwSKAPnpM6ZpQ5C9PR6lfitpt2/YcsM+eY3rAsbENhrQP8k9QMkGlv2quXILDyPQ==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEYPR06MB6311.apcprd06.prod.outlook.com (2603:1096:101:13a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Wed, 8 Jul
 2026 09:20:24 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0181.010; Wed, 8 Jul 2026
 09:20:24 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v5 00/10] Add SSP/TSP power control and DRAM remap support for
 AST2700
Thread-Topic: [PATCH v5 00/10] Add SSP/TSP power control and DRAM remap
 support for AST2700
Thread-Index: AQHdDrsB0PfBWMtPU0KIoukeQI21FA==
Date: Wed, 8 Jul 2026 09:20:24 +0000
Message-ID: <20260708092023.3826159-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SEYPR06MB6311:EE_
x-ms-office365-filtering-correlation-id: cf9e5d7d-44cd-4aa1-809f-08dedcd22476
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|921020|38070700021|6133799003|18002099003|56012099006;
x-microsoft-antispam-message-info: xqodCVTadJWiIfW666/ypcblnjbIBxKJKnlSBtX8g7fSrFM/Va2hdjmwzNRA50zexHM9cMo17davuj+7JBJYP6QKg+IYff6gYUoG8zR/OLZS1eG78Qhfbfhzu0GL7oDWozCMe6dafMN1PkIbeQNkAnaz+m2K/gkcsRV53REAS1LUGaIcQWsTGcyfBq5I6V/IbYnUQ9laRiqe6nzFM0EDDpoQ4EkZe34+7/2PS3EBvB+Yz5c5TpLF9n/NGXNYsiNPOeqi/3aE4IwuZAWauGwxB+K8rQOmR3iYwz65L2eCtTVk3GrVu46KPqW+nQq9ahIWDesl6jmAWhNO3YdqUajRuUkwxeBXKJYfSadGG4GEU9x40ZL6Pa1TIu727Y8/Vm1mk++SFxmDoKRtHQJyHgDWMq4u/meullUDGXte891pMgFl/QNuV1m9hGj/tO0ZR2H02AVISKdIhuSQQhAVT8Dopjgf8mklpDH3eZMphJxhny932Fdy7XvCYg7qMBunR9wBv6Zzh1bUb4FPOiA3ckWqDCbitJvQRZO58wwEbQ1lbCvI4EVzbYII2biax00fP62bqSd5r0s6jjIAL8e3gPOdiBpqDY0xKb/aXR7CUPzAUOlfpD9M3uG15pRC6lba0Ozy/Di5U8nr1+oCsSmsfJTyXhxfzb8VgmigUTx4ZOdLj8NIdmmGTaR19mRnfJLBburyP4NRclmBxrEAZvzVHmzeNpyCfePWXmtgUx8zXlkshvdomnazq8No1axd+W7pX/+4
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(921020)(38070700021)(6133799003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5aGvqLjkcKgrtewablb9HJpjRi09QcZAmnWjm18vcmqMH8NNgkOTyr1wj2?=
 =?iso-8859-1?Q?GeLq1rxdc7yr5o/dY0ii4Qyhde+4bjAl63OmQtSu3T1L5ajS+TR27HEv6f?=
 =?iso-8859-1?Q?DGVnbbqh33Ew7vqFdsWrx1/EjBwwEC4kgmn4pcyigro8jjHEqXC8YUXeDm?=
 =?iso-8859-1?Q?B7nz1HSqiJZB2T9Y7XRc3tO2ZLq/FWvNoe/3SXu4D3ndZa/78pQMPmx4/l?=
 =?iso-8859-1?Q?UsgnAR0d2t+cnmIrCpJAL1Hdev9IkVhs3Qej9HYR0j4VyHt+vGsxnEgolI?=
 =?iso-8859-1?Q?oxr8PDwNb8CnlyydxrNb73B0p959UCMxxg9kPSkYTPtZdsp8lXthbYT+Fh?=
 =?iso-8859-1?Q?FJi2bwv6LX8VKXH6Hfkcmp7bKQqALEpbzjI43+LyeXjlPzR7L9HToE8/dD?=
 =?iso-8859-1?Q?tXiYBaEeqW/TeRPd9Ug4+6r3tsPb1ECnhv4DyadJvSj2OTjPJG+jZsqUlC?=
 =?iso-8859-1?Q?3iinmUvw3q17xE0y9KmHEIu0AbIX2AmENLcDpyr2gPTgg1u60m5B0gbM/O?=
 =?iso-8859-1?Q?7n3Zchv2fR93lU2LCan5nDyXL4j7WwoO8TF/WBVtJcw9ls+wpO9Gs7DPLb?=
 =?iso-8859-1?Q?R0Xyx6GHGipbvA/NQts8ER1iQdUhU9LyP1JBK8NOsP/oWpIe9/PrRqIpDP?=
 =?iso-8859-1?Q?cXtJy8IPuLQc4xDBIIJHxYT9vBwjnv6+6s6+U3ffn1PCgkK4bbf202Zmiv?=
 =?iso-8859-1?Q?S/TYdajTXhF3rbksIGixBziAI7JYH2Y8gS+J8sO0hwiX3UNHoA3ja+JWeV?=
 =?iso-8859-1?Q?jkB7YzZAtijTpRNbzZMao+/3ymcrSD8N124TsB392eOHvP6hMZqtfhyJwT?=
 =?iso-8859-1?Q?6OIFWwWQJWYEL1SFGRvuOcbOOPTECjZyUrLmIej7C6VRQns4PvDcia06XN?=
 =?iso-8859-1?Q?Orcqngir4LLpOkRcQPALQUy3S+cGu/KfrEO+eN+w1bZNnzyYSklBxAtAMR?=
 =?iso-8859-1?Q?FSZTGL26gzPyK/wkjsr9lIHx8/nk107iy4qbFyqLUOMFSM3LlZP1w9wmSK?=
 =?iso-8859-1?Q?ReO8NKm4IiB9MCiXb1WL3vA0ajv/yT5xCUFQvODFzsquCZgWgsPAgYNnDP?=
 =?iso-8859-1?Q?DuEU00y7pJNeRsApKTADrpWAsFQ9f0pnhpHzJ6X7JyxULLUaXdxSvQYymi?=
 =?iso-8859-1?Q?viB8nkmupZoVK3Y5hOzdqbotxascS/PoZVvtgNYjjXw59DEl8fiHyryVul?=
 =?iso-8859-1?Q?a8F6thSrld+HlEVqsWs/ISMq7ingUc/Onwa+OC0FWmsj8T65axlYEYXzHZ?=
 =?iso-8859-1?Q?Zzo4tfoftrmaca+9Q3Hh8tw+RAqR1HgqMbp0mWyVZBX/B+R1lKq/IiL76b?=
 =?iso-8859-1?Q?7Z9//6C+zhBQj7NHbOUAY9VLnXe6O+Es8SrdrT5E+Pp9wxI1kk05CX9RCg?=
 =?iso-8859-1?Q?zRdKMWDS7HT3T6kPR5WunIY/8lPR4KrQluMORJ8R5Jc+ZF8T5g68SjcGK3?=
 =?iso-8859-1?Q?92s/YRi8baUJq0zbPJ0ypFKyKwrZKC3aZZY90TUtv5RKwsWl1kcYy2BBn9?=
 =?iso-8859-1?Q?C5HXFEWlvNUwIXFXKiXUW8SfGqK3TUL8h+h+Wr9SlReWIgERkYMbJuDlRv?=
 =?iso-8859-1?Q?ghUsQSM0mlxJMSAJ2OSpprnG3I3peDGcFaNls6JvIxHmllUmBZr4EbTprR?=
 =?iso-8859-1?Q?qmvA4+T18XvPBWXrgIvYaXw0WFRvjDh7DJe+hoqxhxMEtNEg5OHoT9+dLl?=
 =?iso-8859-1?Q?xihN6FaRxl9s3BxA2vbkTHAOksCYv7i1RORYoRSrLSyaO+pVUnRucurDuM?=
 =?iso-8859-1?Q?fKlCkb2BacX2ar2vdXIjcqZuizawiFO4rXjhLw6FkOip9/rMyHQNIlF3OL?=
 =?iso-8859-1?Q?byqWBejTQQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YUu7VcKEmZZ9SbTIlooXdtnnejy530Q/nZhg8ZUI3I8NL+acZRt3ak0D2vPYWAv6sFAQyk5vp2xG/SVfA0b4Rvf0TnNM1C+05WB0o0cZvEJc29Rf4weQbvMLEm706xoZmqEBmuWFG1MX1tSeVG1RDGr0ETsyfv84+ljnFY0/Dus08OwJt2efjRo4zx6aFD1hGaJOyFYRUda9ngnSr7vfxopktL/wLXtAuIBOu8SbRJRObuUMD8N16ypPiZh0VFgJglbg3SU2FpnhcwJaYRhZAz4ve+F5DQx1ClhdtpwoldY5FIpetWLS+8vJfXNxZy39Cimsqw5wnOKGI+Uc4XA0xQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf9e5d7d-44cd-4aa1-809f-08dedcd22476
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2026 09:20:24.6119 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 03Y5GwAHQ8KY+jl+qQ+R6WSqJCn+bIuEez7Kg5cd+r/jAKQaZytTlKD2jwCyTU7onekAVw373hE5WGb8NUKgEICEgW3459W1Je8MK+NK7FQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6311
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

This series improves AST2700 platform support by aligning SSP/TSP=0A=
power and reset behavior with hardware, and enabling DRAM remapping=0A=
required for proper firmware boot flow.=0A=
=0A=
This series depends on:=0A=
[v2,0/8] Refactor AST2700 SCU preparation for coprocessors=0A=
https://patchwork.kernel.org/project/qemu-devel/cover/20260707060919.350637=
-1-jamin_lin@aspeedtech.com/=0A=
=0A=
v1:=0A=
  1. The changes move DRAM/SDMC initialization earlier to support memory=0A=
aliasing, add DRAM aliases for SSP/TSP SDRAM remap, and implement=0A=
SSP/TSP reset, power-on, and remap controls via SCU registers.=0A=
  2. With these updates, SSP and TSP can be booted via PSP and load their=
=0A=
binaries from DRAM. Functional tests and documentation are updated=0A=
accordingly.=0A=
=0A=
v2:=0A=
  Fix "make check" failure caused by both AST2700 and AST1700 realizing the=
 same=0A=
  TYPE_AST2700_SCU model.=0A=
  =0A=
v3:=0A=
 1. Drop "Move DRAM and SDMC initialization earlier to support memory alias=
ing"=0A=
 2. Support SPI/FMC FIFO Mode=0A=
 3. Add unimplemented devices=0A=
=0A=
v4:=0A=
 1. Introduce Aspeed2700SCU subclass and separate from generic SCU.=0A=
 2. Add separate reset handler for AST2700 SCUIO=0A=
 3. Add AST2700 SCUIO RNG control and data registers=0A=
 4. Share single SCUIO instance across PSP, SSP, and TSP=0A=
 5. Fix AST2700 FC hardware strap settings=0A=
=0A=
v5:=0A=
 1. To speed up the review process, move the following patches into a separ=
ate =0A=
    patch series, as they are not directly related to the main topic of thi=
s series:=0A=
 =0A=
    [v4,01/21] hw/misc/aspeed_scu: Introduce Aspeed2700SCU subclass and sep=
arate from generic SCU=0A=
    [v4,02/21] hw/misc/aspeed_scu: Add separate reset handler for AST2700 S=
CUIO=0A=
    [v4,11/21] hw/arm/ast27x0: Share FMC controller with SSP and TSP=0A=
    [v4,12/21] hw/arm/aspeed_ast27x0: Add unimplemented Privilege Controlle=
r MMIO regions for SSP/TSP (Merged)=0A=
    [v4,13/21] hw/arm/aspeed_ast27x0: Add unimplemented OTP controller MMIO=
 regions for SSP/TSP (Merged)=0A=
    [v4,14/21] hw/block/m25p80: Implement volatile status register write en=
able for Winbond=0A=
    [v4,15/21] hw/ssi/aspeed_smc: Add Data FIFO-based flash access support =
for AST2700=0A=
    [v4,16/21] hw/misc/aspeed_scu: Drop noisy unhandled read logs for AST27=
00 SCU/SCUIO (Merged)=0A=
    [v4,17/21] hw/misc/aspeed_scu: Add AST2700 SCUIO RNG control and data r=
egisters (Merged)=0A=
    [v4,18/21] hw/arm/ast27x0: Share single SCUIO instance across PSP, SSP,=
 and TSP=0A=
    [v4,19/21] hw/arm/aspeed_ast27x0-fc: Fix hardware strap settings (Merge=
d)=0A=
    =0A=
  2. Add memory_region_transaction_begin() and memory_region_transaction_co=
mmit()=0A=
     to protect the transaction.=0A=
    =0A=
Jamin Lin (10):=0A=
  hw/arm/ast27x0: Start SSP in powered-off state to match hardware=0A=
    behavior=0A=
  hw/arm/ast27x0: Start TSP in powered-off state to match hardware=0A=
    behavior=0A=
  hw/arm/ast27x0: Add DRAM alias for SSP SDRAM remap=0A=
  hw/arm/ast27x0: Add DRAM alias for TSP SDRAM remap=0A=
  hw/misc/aspeed_scu: Implement SSP reset and power-on control via SCU=0A=
    registers=0A=
  hw/misc/aspeed_scu: Implement TSP reset and power-on control via SCU=0A=
    registers=0A=
  hw/misc/aspeed_scu: Add SCU support for SSP SDRAM remap=0A=
  hw/misc/aspeed_scu: Add SCU support for TSP SDRAM remap=0A=
  tests/functional/aarch64/test_aspeed_ast2700fc: Boot SSP/TSP via PSP=0A=
    and load binaries from DRAM=0A=
  docs: Add support vbootrom and update Manual boot for ast2700fc=0A=
=0A=
 docs/system/arm/aspeed.rst                    |  42 ++-=0A=
 include/hw/misc/aspeed_scu.h                  |   5 +=0A=
 hw/arm/aspeed_ast27x0-fc.c                    |   4 +=0A=
 hw/arm/aspeed_ast27x0-ssp.c                   |  13 +=0A=
 hw/arm/aspeed_ast27x0-tsp.c                   |  10 +=0A=
 hw/arm/aspeed_ast27x0.c                       |   6 +=0A=
 hw/misc/aspeed_scu.c                          | 285 ++++++++++++++++++=0A=
 .../aarch64/test_aspeed_ast2700fc.py          |  29 +-=0A=
 8 files changed, 374 insertions(+), 20 deletions(-)=0A=
=0A=
-- =0A=
2.43.0=0A=

