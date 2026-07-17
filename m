Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D21C44514
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 08:22:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkdmO-0006qZ-SL; Fri, 17 Jul 2026 04:18:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wkdmL-0006p5-77; Fri, 17 Jul 2026 04:18:41 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wkdmF-0000Cy-Pa; Fri, 17 Jul 2026 04:18:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k/09B7b2Tp6SuI4drc4AJkz51yNXnTKYvKIzMCxRDC1VI+u1mR4pkGj6sG9k8+cHMrYh87yrd3XtjgdwjpF9xx80JpfVxluCTX/MGguEgEMJPT11x+GVYUqrZJ751wJWkg0wo9zmKlgXHdwgdM29x3y39VoJ2mQM5ES8Yb5fa6OcKXla8+ZSxkV8jjA2cQYsXMZcxLcjNFPiPGqYLLGIFoUKBH30e7Yw76JKOsochC3A0Jl4J4+F8HV7rzi4pZ6PfQtb5533RNR+IqcqikwG3OFr1qx96yFuom9ynd9L0Hmkci42UlnXC9Sgl0ODzjYCGeTaHjlMN+TsPzQIwqsk/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+NsZPU0vp5g+L+ZwYkgzN0/vSqDgJxWBI/lwu9OovNo=;
 b=hnLWvaGfm28r7eVrDwex+mM9u5SX3WmExmcYOfO17vChn5sX6wvW/pMCcklPzJ5YgbnCTMW0z46V6I/uVg2P5dnz4LF2MT4PYG5pg2amUi32mJGF1HXl+fTTxFUIonnweLjLO+/F+dwM+Ic0YSRHHV/t0kKleHppQVLzNSt+Nvfj9dp4QRSVxbijNy81iBymx/OAFSYFzFrzUPqEnGiz/oIfFDpAh7uT2FcjcDBob5fxCEwRqtHhBYmsrSFkSfS2QS3fZGGdIV1CvRp9i7087BYsblIxCkvK1jqjS6hA4C15uLGjjPwWNZXGKWzLPsF2INFtTjNlRRoVpJZmskgLqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+NsZPU0vp5g+L+ZwYkgzN0/vSqDgJxWBI/lwu9OovNo=;
 b=m9Og6/JY04JjLQ2CxFoE/v8Vy9FvhYmyP62136kkH+MaNpIJyEcFS2RVrcAXktCIH6IVRBI3y2EXqDSRny2KXieU4/U5X8aq6hg439403pkp5rHEd3m4GUOWpxRm5+/BQqxHlc0Aym49oDyznLGGxEIL3ln5PWccpex+ZkPD3b+0wUxX5nbkMaGPRWluaO77n9HbbRL6LomCL/Ttp8JxwoOoefVjQZqP41BV3Yo6jT5bVyf3XjjD1JyMyloQQtzSjQu4driakxAXSHI5bdMJsLYAPC/ITt5Ka95u7Pz7HC4Zt1h3gsOgMeF9AvZWINVI6sqI54UkkfrIMjs3Ou6pCA==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KU4PR06MB8339.apcprd06.prod.outlook.com (2603:1096:d10:7d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Fri, 17 Jul
 2026 08:18:22 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 08:18:21 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?Windows-1252?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Fabiano Rosas <farosas@suse.de>, Laurent
 Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?Windows-1252?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 =?Windows-1252?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v3 6/9] hw/arm/ast27x0: Share single SCUIO instance across
 PSP, SSP, and TSP
Thread-Topic: [PATCH v3 6/9] hw/arm/ast27x0: Share single SCUIO instance
 across PSP, SSP, and TSP
Thread-Index: AQHdFcTUKWdK35iQIUyO1+fTGd3FVA==
Date: Fri, 17 Jul 2026 08:18:21 +0000
Message-ID: <20260717081813.3407862-7-jamin_lin@aspeedtech.com>
References: <20260717081813.3407862-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260717081813.3407862-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|KU4PR06MB8339:EE_
x-ms-office365-filtering-correlation-id: bb91b820-7886-4c14-eeb3-08dee3dbf740
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|366016|1800799024|38070700021|921020|56012099006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: G+M+aoO0lTUUqPsA0zbr3gFvZMd+ZZUZfPrHbPEGTOIkQA4S/ZBwm+ykQqjO7BTguRvRbODP6lZL+9QfNaq4LpnGdi2On8/WVHOWTcDCpyzkEXCgH7IMjGBXn/rlFC/iFMz2SFLeFXs8QtZOgh17e0Wxk7htzVqRKGuyTdqtpRpasZTE2pXcrTU3bs9qQ7SH7VfAaFfP/hDziFUdoW+D6mekS+H9XB0wBnMgNVgOqQmTv7rHSWAW9upAzLNceXiv+5TAUepOzLMmoowNXZ2r+EH4eU9xD4m5ydMjbdnB1DA9NTqI7ldukmNw+hdyxaLcbu1WFM5qfUJ5IZo2xaO/ihnt1niU4/gacvNcnXXWO7DP2FofHJe67lntp1771UCWXD6IQ1Gv5mHHKbQvFdSd5cv2ZyllEp6C8xLyPrFjuFF1Q4UcpMNR1NJIdOoyqj4GjOlBHvlzBjU3jyn19DZ+mCua1V4cdLrUfctEvYhutG0ppYHGdRZHx/4mVucm7YvlPJ+z4XzWWOkWptRoqxmKhinBSrJwTJj03rW2/3bJroLqgrwMWuFUrvYmv2/Golqycjz+3QwavTvznt6OWUqpz+1f7kCdrCmotHMuNzvrUKgzrDSiXVYsLrF8225oFffrv29J7LgyG2rVl0c3WiicGxbB1rjOHa1XSwjzqVYlvvyP+5x7/TD0zyeD/PsUWJrsN9aij02z/wSgsoeO+8Y7jQhLv/slLxncayjhoOtGoUnwsBfWnrpuPs+mIlcgrhac
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(38070700021)(921020)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?ZMpRGkmbkuwo+FYh7fUrxQ1tr1mpiKAOUhgBN6UC8A//yjoWbtw2rJNF?=
 =?Windows-1252?Q?v/Ich6srFQ8B21cnhZA++t2/dg5VK8j2EDjeINXWqHe3Q1+bSMv/4dMh?=
 =?Windows-1252?Q?JoooFfZ8JWDwRmLWlROU+/hZqEB3RV0HJ0Xzpe/p6OWlROaIsiQhawKz?=
 =?Windows-1252?Q?TGCYfBoFVv7qHYDD2NVo50Hud7iceGL8v/3I3sXtfF8wTiyUTjBCLr7R?=
 =?Windows-1252?Q?+7Q2pQhnMA6mipL1kUIHCm+dKVuJEL95QWV9YAXfoYSn/DZ1fMik//1o?=
 =?Windows-1252?Q?wVBe1uXv4dYlWKTrG9Ocx65BdyGUUg0si5nn1M0z9gZYYF19T1KeBCH1?=
 =?Windows-1252?Q?yZV0M/PEkwaWrykV9SFEcd2Pb6Bxz+fl6sLvj0nWUS4fjK18A/hSABEV?=
 =?Windows-1252?Q?kppZ24fypEJWqeSnfQaZFon8Ps9hsJazBoykI8GQxUcAQWTDdSNOivsM?=
 =?Windows-1252?Q?PU3O7hSeFPbb1AhWtdyVegt7qHiwTY240szFcaoUXRto3oS44Wym77YF?=
 =?Windows-1252?Q?ojRaWSfi65iB/CaI9AQ5XdLtyVfRfWE5erHORrlsubZtaD7SsCpCbWs4?=
 =?Windows-1252?Q?lKXtevKdE2VKBYtUdR1cvvPmgMg640HRmIju00ZhkEh55CSMLMNdDT+M?=
 =?Windows-1252?Q?ik9T4Ii4TXvrmS1joAkxXfgriiYJ/UO/rbhUBSWfPTXVziB6iuBwngVK?=
 =?Windows-1252?Q?2P/FTyWb7w4ft8Bdeh1DMQta5C+JaPQDJ8bObm8hC2dvFBa6xtSAUXoX?=
 =?Windows-1252?Q?TXs2nbTLKzA6Qn/PLxGcet1ip4ztolJ1n6Mmhdivrybj5+0gu85+9Fpp?=
 =?Windows-1252?Q?y4zxHcJ6Ar5Z3EZeBQ2ZS8rLci/uHanGbX/f+kTkBgCV4ML5OEqUmuov?=
 =?Windows-1252?Q?ASMKARA4DvY6LiDw+1/iEDmEgqr6SAaSWchCbj9Mzt9iu6JnAA2ehDPZ?=
 =?Windows-1252?Q?k9ff4L4ffJKTnbckrvIhlM5TiAsN90wGZmsHmVqgwVOr/ClP7tBP+c9w?=
 =?Windows-1252?Q?KsV4ieBssOGXX5+cQCBX6TofCJmM2xgP+ikoQBrfj4UYESnDSVh0kJMt?=
 =?Windows-1252?Q?GmGFB0Pg+/N5glQAYs7zOVXXWXI0+/uxUYlEAxHfIpvocKvabMD9Ems6?=
 =?Windows-1252?Q?GwVtcZopd3EJZU7NtJeG4OeAekWIHyhQHFRjriIhFECYuhoarSvmPb4c?=
 =?Windows-1252?Q?/CQNf5v0ULDHOv9M6Ow/ON9XiOqLyfVBYqQWaeEMWO7U4D3EIGyeDBEG?=
 =?Windows-1252?Q?4y0YATNF5bzUS5Fc6OqSOLIP/Fe9qO4X/E62Ta7q2XEcLZApZwu7UVWO?=
 =?Windows-1252?Q?D7gcFVju3gbPWzJsNxIPSaiwa/b05jbqZMv81OPhpULnLpOwfytxHp4L?=
 =?Windows-1252?Q?z3DlJWYAo+XL1GXQw7wkhCgkK+cWAVwH1owm42zewLEkJ9yQVgbE4BQG?=
 =?Windows-1252?Q?M3EhR6B7vEdhzhIBoA7FSjG9qDTjUrBigwgos6QdNnlUKsnufcn4vMAf?=
 =?Windows-1252?Q?Mfg0ECSVd/KHa0W4wp/R8Pz+TM1BJTHiw/kl9gOFg2s5NXp5W+QFJ6de?=
 =?Windows-1252?Q?sjae6f4iPeYA4ZRCDgeJPYQTNBYWcm5sX9LXP4QTM2WcKepMK6Ck0S1C?=
 =?Windows-1252?Q?fULhxBCRWUVMDTVwF+qLky3ZkBK9adnEwZg5IJYvGbvp7oXxFZYiZr6h?=
 =?Windows-1252?Q?ZulzFORsygotbbXRaEOY4wZZeHxmaGCj91fj+DdOc1y8jmAV7VJsIRBM?=
 =?Windows-1252?Q?1mtXQEjA5CfTjVVkF6xANwO/ArRZvrA2y0AiHf6Azor4+2jlf4xKsC9p?=
 =?Windows-1252?Q?VJZ2sl/t0GsiA43GiyHR83y4hMTkRsEKG64hSVzb3boBc9An4Txkpw5m?=
 =?Windows-1252?Q?bVQBy2ZC1s1GhA=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: SunRD61j+pRPz3VOpN+wt1P7jW6PgjGjTftBWCkBTPIPspIAt4dutIYft7fa6Vzg4NrEuRtoCciiqiovJ+FZIwSdl8EeykFZ4yAy1ciX7oOuqBaBVJyNA8lA/nfcmASwh2nXo9jiXs8F4G9q+5eC5edkgimtBSsUDaflqckZsXe8z8T0wnjheEHMwA5Oo0Yb8cnWNaYELWka4EGbG8ftew/U/hsz1EbGvHYzyM/VqczcmI8o3l0L521vJHfxoliK5XXT4xCulciYc8nG2AO49pVa5BqVLn9pgOB3LmnzlTLhWw3H1Q21eumP14wgY5gIVjs3r7EiaenmotQugLXn6Q==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb91b820-7886-4c14-eeb3-08dee3dbf740
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 08:18:21.7738 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MUOYYbHFpW/nD1WKBkAdTupleEi5xlmOS1Z2MJzJDc0E6Q6WqbEqvj9Zaxm9dX7VgKPEAmFoRFE6InRV0+FfldqtL5OVhfL965rDnQ86KLk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU4PR06MB8339
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

AST2700 has a single SCUIO hardware block, memory-mapped at=0A=
0x14C02000=960x14C03FFF from the perspective of the main CA35 processor (PS=
P).=0A=
The SSP and TSP coprocessors access this same SCUIO block at different=0A=
addresses: 0x74C02000=960x74C03FFF.=0A=
=0A=
Previously, each subsystem (PSP, SSP, and TSP) instantiated its own SCUIO=
=0A=
device, resulting in three independent SCUIO instances in the QEMU model.=
=0A=
In real hardware, however, only a single SCUIO exists and is shared among=
=0A=
all processors.=0A=
=0A=
This commit reworks the SCUIO model to correctly reflect the hardware=0A=
behavior by allowing SSP and TSP to reference the PSP=92s SCUIO instance.=
=0A=
The following changes are introduced:=0A=
=0A=
- Add a scuio property to Aspeed27x0CoprocessorState for linking the=0A=
  coprocessor to the PSP=92s SCUIO instance.=0A=
- Replace per-coprocessor SCUIO instantiation with a shared SCUIO link.=0A=
- Add "MemoryRegion scuio_alias" to model address remapping for SSP and TSP=
.=0A=
- Create SCUIO alias regions in both SSP and TSP coprocessors and map=0A=
  them at 0x74C02000 to mirror the PSP=92s SCUIO registers.=0A=
- Ensure the SCUIO device in PSP is realized before SSP/TSP alias setup.=0A=
=0A=
With this change, PSP, SSP, and TSP now share a consistent SCUIO state,=0A=
matching the single-SCUIO hardware design of AST2700.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
Tested-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
---=0A=
 include/hw/arm/aspeed_coprocessor.h |  4 ++--=0A=
 hw/arm/aspeed_ast27x0-fc.c          |  4 ++++=0A=
 hw/arm/aspeed_ast27x0-ssp.c         | 20 +++++++++++++++-----=0A=
 hw/arm/aspeed_ast27x0-tsp.c         | 20 +++++++++++++++-----=0A=
 4 files changed, 36 insertions(+), 12 deletions(-)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_coprocessor.h b/include/hw/arm/aspeed_co=
processor.h=0A=
index adfc3c4512..b77ea06e7f 100644=0A=
--- a/include/hw/arm/aspeed_coprocessor.h=0A=
+++ b/include/hw/arm/aspeed_coprocessor.h=0A=
@@ -22,7 +22,6 @@ struct AspeedCoprocessorState {=0A=
     MemoryRegion uart_alias;=0A=
     Clock *sysclk;=0A=
 =0A=
-    AspeedSCUState scuio;=0A=
     AspeedTimerCtrlState timerctrl;=0A=
     SerialMM *uart;=0A=
     int uart_dev;=0A=
@@ -45,14 +44,15 @@ struct Aspeed27x0CoprocessorState {=0A=
     AspeedCoprocessorState parent;=0A=
     AspeedINTCState intc[2];=0A=
     UnimplementedDeviceState ipc[2];=0A=
-    UnimplementedDeviceState scuio;=0A=
     UnimplementedDeviceState pric[2];=0A=
     UnimplementedDeviceState otp;=0A=
 =0A=
     ARMv7MState armv7m;=0A=
 =0A=
     MemoryRegion scu_alias;=0A=
+    MemoryRegion scuio_alias;=0A=
     Aspeed2700SCUState *scu;=0A=
+    AspeedSCUState *scuio;=0A=
 };=0A=
 =0A=
 #define TYPE_ASPEED27X0SSP_COPROCESSOR "aspeed27x0ssp-coprocessor"=0A=
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c=0A=
index 58d0b4d7cd..d14a42ebca 100644=0A=
--- a/hw/arm/aspeed_ast27x0-fc.c=0A=
+++ b/hw/arm/aspeed_ast27x0-fc.c=0A=
@@ -157,6 +157,8 @@ static bool ast2700fc_ssp_init(Ast2700FCState *s, Aspee=
dSoCState *psp,=0A=
                              OBJECT(&psp->sram), &error_abort);=0A=
     object_property_set_link(OBJECT(&s->ssp), "scu",=0A=
                              OBJECT(&s->ca35.scu), &error_abort);=0A=
+    object_property_set_link(OBJECT(&s->ssp), "scuio",=0A=
+                             OBJECT(&psp->scuio), &error_abort);=0A=
     if (!qdev_realize(DEVICE(&s->ssp), NULL, errp)) {=0A=
         return false;=0A=
     }=0A=
@@ -187,6 +189,8 @@ static bool ast2700fc_tsp_init(Ast2700FCState *s, Aspee=
dSoCState *psp,=0A=
                              OBJECT(&psp->sram), &error_abort);=0A=
     object_property_set_link(OBJECT(&s->tsp), "scu",=0A=
                              OBJECT(&s->ca35.scu), &error_abort);=0A=
+    object_property_set_link(OBJECT(&s->tsp), "scuio",=0A=
+                             OBJECT(&psp->scuio), &error_abort);=0A=
     if (!qdev_realize(DEVICE(&s->tsp), NULL, errp)) {=0A=
         return false;=0A=
     }=0A=
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c=0A=
index 28bb59c8c5..fa492f1797 100644=0A=
--- a/hw/arm/aspeed_ast27x0-ssp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-ssp.c=0A=
@@ -142,8 +142,6 @@ static void aspeed_soc_ast27x0ssp_init(Object *obj)=0A=
                             TYPE_UNIMPLEMENTED_DEVICE);=0A=
     object_initialize_child(obj, "ipc1", &a->ipc[1],=0A=
                             TYPE_UNIMPLEMENTED_DEVICE);=0A=
-    object_initialize_child(obj, "scuio", &a->scuio,=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
     object_initialize_child(obj, "pric0", &a->pric[0],=0A=
                             TYPE_UNIMPLEMENTED_DEVICE);=0A=
     object_initialize_child(obj, "pric1", &a->pric[1],=0A=
@@ -173,6 +171,12 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
         return;=0A=
     }=0A=
 =0A=
+    if (!a->scuio) {=0A=
+        error_setg(errp, TYPE_ASPEED27X0SSP_COPROCESSOR=0A=
+                   ": 'scuio' link is not set");=0A=
+        return;=0A=
+    }=0A=
+=0A=
     /* AST27X0 SSP Core */=0A=
     armv7m =3D DEVICE(&a->armv7m);=0A=
     qdev_prop_set_uint32(armv7m, "num-irq", 256);=0A=
@@ -207,6 +211,13 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
     memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SCU],=0A=
                                 &a->scu_alias);=0A=
 =0A=
+    /* SCUIO */=0A=
+    memory_region_init_alias(&a->scuio_alias, OBJECT(a), "scuio.alias",=0A=
+                             &a->scuio->iomem, 0,=0A=
+                             memory_region_size(&a->scuio->iomem));=0A=
+    memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SCUIO],=
=0A=
+                                &a->scuio_alias);=0A=
+=0A=
     /* INTC */=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[0]), errp)) {=0A=
         return;=0A=
@@ -267,9 +278,6 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *=
dev_soc, Error **errp)=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->ipc[1]),=
=0A=
                                   "aspeed.ipc1",=0A=
                                   sc->memmap[ASPEED_DEV_IPC1], 0x1000);=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->scuio),=0A=
-                                  "aspeed.scuio",=0A=
-                                  sc->memmap[ASPEED_DEV_SCUIO], 0x1000);=
=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->pric[0]),=
=0A=
                                   "aspeed.pric0",=0A=
                                   sc->memmap[ASPEED_DEV_PRIC0], 0x1000);=
=0A=
@@ -284,6 +292,8 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *=
dev_soc, Error **errp)=0A=
 static const Property aspeed_27x0_coprocessor_properties[] =3D {=0A=
     DEFINE_PROP_LINK("scu", Aspeed27x0CoprocessorState, scu,=0A=
                      TYPE_ASPEED_2700_SCU, Aspeed2700SCUState *),=0A=
+    DEFINE_PROP_LINK("scuio", Aspeed27x0CoprocessorState, scuio,=0A=
+                     TYPE_ASPEED_SCU, AspeedSCUState *),=0A=
 };=0A=
 =0A=
 static void aspeed_soc_ast27x0ssp_class_init(ObjectClass *klass,=0A=
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c=0A=
index f5c4a02161..3a98bd232c 100644=0A=
--- a/hw/arm/aspeed_ast27x0-tsp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-tsp.c=0A=
@@ -142,8 +142,6 @@ static void aspeed_soc_ast27x0tsp_init(Object *obj)=0A=
                             TYPE_UNIMPLEMENTED_DEVICE);=0A=
     object_initialize_child(obj, "ipc1", &a->ipc[1],=0A=
                             TYPE_UNIMPLEMENTED_DEVICE);=0A=
-    object_initialize_child(obj, "scuio", &a->scuio,=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
     object_initialize_child(obj, "pric0", &a->pric[0],=0A=
                             TYPE_UNIMPLEMENTED_DEVICE);=0A=
     object_initialize_child(obj, "pric1", &a->pric[1],=0A=
@@ -173,6 +171,12 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
         return;=0A=
     }=0A=
 =0A=
+    if (!a->scuio) {=0A=
+        error_setg(errp, TYPE_ASPEED27X0TSP_COPROCESSOR=0A=
+                   ": 'scuio' link is not set");=0A=
+        return;=0A=
+    }=0A=
+=0A=
     /* AST27X0 TSP Core */=0A=
     armv7m =3D DEVICE(&a->armv7m);=0A=
     qdev_prop_set_uint32(armv7m, "num-irq", 256);=0A=
@@ -207,6 +211,13 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
     memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SCU],=0A=
                                 &a->scu_alias);=0A=
 =0A=
+    /* SCUIO */=0A=
+    memory_region_init_alias(&a->scuio_alias, OBJECT(a), "scuio.alias",=0A=
+                             &a->scuio->iomem, 0,=0A=
+                             memory_region_size(&a->scuio->iomem));=0A=
+    memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SCUIO],=
=0A=
+                                &a->scuio_alias);=0A=
+=0A=
     /* INTC */=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[0]), errp)) {=0A=
         return;=0A=
@@ -267,9 +278,6 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *=
dev_soc, Error **errp)=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->ipc[1]),=
=0A=
                                   "aspeed.ipc1",=0A=
                                   sc->memmap[ASPEED_DEV_IPC1], 0x1000);=0A=
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->scuio),=0A=
-                                  "aspeed.scuio",=0A=
-                                  sc->memmap[ASPEED_DEV_SCUIO], 0x1000);=
=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->pric[0]),=
=0A=
                                   "aspeed.pric0",=0A=
                                   sc->memmap[ASPEED_DEV_PRIC0], 0x1000);=
=0A=
@@ -284,6 +292,8 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *=
dev_soc, Error **errp)=0A=
 static const Property aspeed_27x0_coprocessor_properties[] =3D {=0A=
     DEFINE_PROP_LINK("scu", Aspeed27x0CoprocessorState, scu,=0A=
                      TYPE_ASPEED_2700_SCU, Aspeed2700SCUState *),=0A=
+    DEFINE_PROP_LINK("scuio", Aspeed27x0CoprocessorState, scuio,=0A=
+                     TYPE_ASPEED_SCU, AspeedSCUState *),=0A=
 };=0A=
 =0A=
 static void aspeed_soc_ast27x0tsp_class_init(ObjectClass *klass,=0A=
-- =0A=
2.43.0=0A=

