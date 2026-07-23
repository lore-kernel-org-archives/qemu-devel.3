Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 749C2C531C8
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 02:24:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmj6M-0005P3-DI; Wed, 22 Jul 2026 22:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wmj5n-00056u-KO; Wed, 22 Jul 2026 22:23:24 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wmj5l-0002ZT-Ry; Wed, 22 Jul 2026 22:23:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UlgcW1YYQvUSVgFIzeB5ns3IORx1TjA8SYNLEwxYnFlK0Gvrihq7ZsEHiUzLQszL9DGGz9JS2N5S97MnwZZDRJe/6v7T1yuyHPEcf3NKeOUPxvTzeqPNSRECpFT7/Jkor43RXxgWtgrThglCvv2r0hy7ijGrDnt1DCq9uPZLmQAltV3nuRE/09If6ooEcggxYhuRUQuC/NfZFdmCwGWRCxmEdmez1hBOgPG8leFJh+9knVnSsRCLRnqih9ex0aPQ9XYkFzM6IU/y4+isHcWIaaNHLRXfX06JV7htuYyGEjCfC+0HQOB971vgyZS5E0zDt21YIVUFEryVvLSvXpJbIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fNrsYNhcxiPQiYU1k/OFFYY28ST5Z3MgKiIqAip7wIg=;
 b=H1j9LMnINqaSOeaydThmQzjgE/DkX3XAyQA4OxyV0uC0r69+xOgbSZsvPElZ/7AF2dnPvfKkok1QjSSpr19n35gg3l6f/BQc4Mhhlfpd70mqphAaqwQ2hNCNgOPm9LtRSU3moxE4IXhhYoSeda6e9BRihyMvFGWmaM1AIkBTd9tCewZDTV7pOnMPZAGh2FgnBDmAqpR9eY8zjda9ZsCT8IV0aWS4tfvKwJ4lcoFDIjeIBFhSYifYAFAXssBqA5VR20loq69MDu/P81fRD+hMCtgIlEuGqH/x/1lA01E6wAEXaS5rxUXuRo2ryKl38assU76QXNJfyJPp6KcOHQBMFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNrsYNhcxiPQiYU1k/OFFYY28ST5Z3MgKiIqAip7wIg=;
 b=ML51oy5VCDqPlyQOchu+vP8+2JE1rnAB6bJZiLpzE6sjRisgTfcQeY5lD0HQH/4EH9WVbvIxeqL03ezVOzP9sJd/2oUpmsIjpj8oMjlcuahqRylcco0/UtHzsoJSypMLqUwhX57J3g2gz0RxKSzFt56PaDwynoFi7ZnmkW+vpIviaqN4GtUhaaARLu+grii/YRrl54QbRpWXpM3NSqHah4ejWOiEGpBcxJ+9r5QmS55tQTAK2FUbFZYoqSDm3ilHzolAYhu/8iDPpgssYH3EwcdI547Ppl4VDqiXYuNbRaLlM+MlfuW/KIQZL1pbwWf5Hx/pECcoD9Uq3QLoE4r8+A==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KL1PR06MB7034.apcprd06.prod.outlook.com (2603:1096:820:11e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 02:23:10 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 02:23:10 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v6 07/11] hw/misc/aspeed_scu: Implement TSP reset and power-on
 control via SCU registers
Thread-Topic: [PATCH v6 07/11] hw/misc/aspeed_scu: Implement TSP reset and
 power-on control via SCU registers
Thread-Index: AQHdGko0FWMjzA1qi064MZwE3YCd/A==
Date: Thu, 23 Jul 2026 02:23:10 +0000
Message-ID: <20260723022300.4174471-8-jamin_lin@aspeedtech.com>
References: <20260723022300.4174471-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260723022300.4174471-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|KL1PR06MB7034:EE_
x-ms-office365-filtering-correlation-id: 6223e8c2-3704-42d5-0a21-08dee8615700
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|921020|38070700021|6133799003|56012099006|5023799004|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: a9bUpbrO/BpIaaLy6nis86rSU5TwNCNq6Zb+OUD3/yI+U3F2tT6u06YfRFCdXE5r5cmBpnxJB3nuuyePdMMulceVqHUeKYw86SfbigUABoBOGXcSjKAmM4MaS4S2rmFKS4E1u0AHsUap/jysetygiMwGwPwb/EmQV7GgINJpgGUs4KM3GtRgZ/O8Cf8YJWJAPfB+9DR+MMcfWxBSJNmLG/jYJkEeb4KD3tL+y1M5wQXz7oVRVsjPskm4mtZed9BkUgRsTH5tFoma3jYlkb4k2ha5e15QZ9dyfAafOxQAsteVE6MYnMo5/UbbiCbBSXzyfITaUMxp/6UglHlq+Nf11wfHVlKNEo7TKsYchCvS38BcOvLAxAQ93BH6OcdHbGXOQsen6TMAM0/nL+H/HJm4n9kLJ7YoQKFMTU8VUuht0ZdC/Q7cLhVaQmWO2FyKS39FgnYEyVNmB80XHn9iMveH3mIx60ZRf8B6Pr5YXP9HS6irDyPLrn7rO8IO0GdBGP0mm+2Vvb/FPsVZ8JnCzW1FpjBj89L96d0YqyP1zVzWe5KptCYzpG7HCzL3+Jsi1yS9PeTakZbXX23iDwsa5RU2+ktQmqHBKJjUECgURpCpPZHQLwa6F7xicmaQ+yXUtlCHPbdvo89fbetWPxZFppWTbmNz8cMwcPPHa/iUoh0jcxH/m5jZXX6KkZznypUOmVRiORCQ5sziROj4JjMsNhxXq+mVMQmHxMi3UATiqm18zDc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(921020)(38070700021)(6133799003)(56012099006)(5023799004)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?H1A/xirCy6udQNcpaVbdFVnkmGzCSI8+m98a0tYfTZQhhTqJ/wAAkWIEr+?=
 =?iso-8859-1?Q?WP46HfpCcORIthxwUz78VWSblbnVPf9TDPhhuHKaC75LKfzzo2wXYM9B/F?=
 =?iso-8859-1?Q?GbPLtL5DiF0FtwmwAnDT4Bes0gAHDwDj8piJSA+8rUiSpSgSIn0g18C/+e?=
 =?iso-8859-1?Q?u6pmZSpNyFMxQoPEogYbOPXn59+eHB7ge7A23eHksf1/0RZdBRX9Dc733z?=
 =?iso-8859-1?Q?gSSEagbJcnAmGO0CxVzanE6EW6zdgxx/GEs85DUz/iLclkUNTqKGjVAsQn?=
 =?iso-8859-1?Q?jT7al8vomNF3BInkm65l27PGb5KRKWq+HoctPOPQDve70xZ4mr/7f8gTJt?=
 =?iso-8859-1?Q?r6Rhp97kbsAfQVS8aizUEVhVi2eaIzXTfSA0yDJaiYMbYU+zcUMaW73tK+?=
 =?iso-8859-1?Q?04oazfu+f4MBpyBLYJL13SvkLNoVTwiapseUP+2gB7QRbeTMmPlIWpSStf?=
 =?iso-8859-1?Q?62i2hzr+SBn7lTkRAsrlFjzGAuYic/g//dG/PpojJLqvO8rIRHCxn6rpTL?=
 =?iso-8859-1?Q?fFd+LsapO/TyNyhBn8ZnOF4/QjUrLEXOjPDkbvXxp2sGS0XHkh191afV6h?=
 =?iso-8859-1?Q?HfvxWsg5HqXgBIRX4EW0IZ0RiC8J3ZdxpkQ57BlX7DB9Cv7JnQyHdpQfkB?=
 =?iso-8859-1?Q?YV+dmEtPcIH7Pn7w9Qh0SNYRbeU7eLAJ+pr7/qanHw4s7c5BMvoX9P9iQJ?=
 =?iso-8859-1?Q?8Nt3MWOpdpReyV9uw7QeQ8zFFhIWuUE60IfhH0MArmiQCBb6DkyiHO95Mi?=
 =?iso-8859-1?Q?uq6FduSBHahOW/7AWR3jij2dc+eSYFTKqwyDpWNt5WwwRnlsnVo+17sUp1?=
 =?iso-8859-1?Q?V5FGQub6kjxcY9TkkfZUWFz3rsrrG+ReYIKA5N4FVmDb4YZ+g9jzhJw8xN?=
 =?iso-8859-1?Q?7peTVySvKg4nse/pli3w9Iq7G9g1kA9eFRXpfLXGzQqk6559bTZo/bWNp8?=
 =?iso-8859-1?Q?reHEoqf+m9s5TIIp6+u9jOCjLvcf8i4oJA1cEU0JaOTkHpT15vd2f8XvAt?=
 =?iso-8859-1?Q?TqH7KpkyMlkeJ8p0cCi28Iz/hPa5o3F3U7np/j5hswjOSMnk9Q2d77Eslf?=
 =?iso-8859-1?Q?OXb73Ba+pgZxnYZA+gLuOUDm70PO8gRQxfV3QAq7UAr/BOnVFiYV/ou+n+?=
 =?iso-8859-1?Q?U3uypvnLCkcMhV4LRUlHGo5oHGO10jIIgJNefZ4oyMWQAvkJHEOdB6REAx?=
 =?iso-8859-1?Q?hTaG0LzkRI+MqiSnZ/WJrt8sMRCvCQSMWWIzALao4yC97bM4F7GqWHcQkM?=
 =?iso-8859-1?Q?GubVXhh6CDnkxFdwO4+DZ000U2bwkvkR/UhokzAplBcUuuHsu173kiATaq?=
 =?iso-8859-1?Q?aChjy67BFk9jvTrbuZwKhyb35CTYznVlRIeS+dMe7Qxy55/mKwshkMMnlF?=
 =?iso-8859-1?Q?WN7xH0qemwogOOFWJrteGLDLAxFK1xJWow4zruc53vgLTeYuwCHn0wKKUT?=
 =?iso-8859-1?Q?IO9lg8oHKH3RZrFktmFelazh2M04bg7ht5bAKQ+qabMYE3i+1WzPVvywLz?=
 =?iso-8859-1?Q?HE9+GIvdrwFF9kfejv0dlZdi88TLShSi0uqmfAiFlQZVGzHQ+sUdG1xsbH?=
 =?iso-8859-1?Q?aXgUuL2onZ8/AxZUpp+o3ViqgGacjrIgSW4kW9Hlt2/jAyUq1izsfnlCUS?=
 =?iso-8859-1?Q?eovsFw4V4YjN9pYbccMLonf8a2HsUFNPPXBz0p69dD4Hk1yW7LBdMcoufT?=
 =?iso-8859-1?Q?ag3fV69Iei0kks0aAtdswfY1d8PiR/OZd+f/oNM7P9drbt4Q/iErXrulfm?=
 =?iso-8859-1?Q?kBn/GPDukoKbveszcf8NBFhFW8Viy1uPk2bgS3VAWN/AFbFLnM+hVUUNEh?=
 =?iso-8859-1?Q?QkmHrXzQww=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZaxX+UXzvPfIsQE1gwxEiVJMxbA5HVnggKAV43aqSlHVR1xlypcv8TR9pJ1vn4k4U5/ITSqINuHfQkdVWpVrYFSfECMOF7p0EBv/1lRXLqxIYcM2zec+B3qNEfBpcCzoM144opJMGuTz+sUzdUuTEd6Ben4fBY1zOdzfo7jsQqzVLZUD0Iqi6akJ7P8fqprrm/lR/pMSbvRLokP3A3r3isJL+IdiUKXfgKMeo+9aFzvPyr1DgP4g+3iie0mkD3hD+8GHDEaL6t7u86A/YyevwfqNZpreL4xcAWn/yl2wuZSDf6hj578bNu2UockfdsyG+QpPZuLMevIJxMAhqznPmA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6223e8c2-3704-42d5-0a21-08dee8615700
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2026 02:23:10.2046 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +D8nuaZoUmFTm1q7wa7WtKc9kCsUDd/uvgoLq9XcNqUmV6tLrEr2MFAuepZCgjQNV/4qAfws7OFXPPHJoqIbryw4tdIoJMLFojcvHaef/wE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7034
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

This patch implements TSP reset and power control logic in the SCU module=
=0A=
for AST2700. It introduces support for the following behavior:=0A=
=0A=
1. TSP Reset Trigger (via SCU 0x220):=0A=
=0A=
   - TSP reset is triggered by writing 1 to bit 9 (RW1S) of SYS_RESET_CTRL_=
2.=0A=
=0A=
2. TSP Reset State and Source Hold (via SCU 0x160):=0A=
=0A=
   - Upon reset, bit 8 (RST_RB) is set to indicate the TSP is in reset.=0A=
   - Bit 10 (RST_SRC_RB) is set to indicate the reset was triggered by an e=
xternal source.=0A=
   - Bit 1 (RST) is a software-controlled bit used to request holding TSP i=
n reset.=0A=
   - If an external reset source is present and bit 1 is set, bit 9 (RST_HO=
LD_RB)=0A=
     will also be asserted to indicate the TSP is being held in reset.=0A=
   - If bit 1 is cleared, RST_HOLD_RB will be deasserted accordingly.=0A=
=0A=
3. Hold Release and Power-on:=0A=
=0A=
   - If RST_HOLD_RB is clear (0), TSP is powered on immediately after reset=
 is deasserted.=0A=
   - If RST_HOLD_RB is set (1), the user must write ENABLE (bit 0) to TSP_C=
TRL_0 to release=0A=
     the hold and power on TSP explicitly.=0A=
   - Writing ENABLE (bit 0) is a one-shot operation and will auto-clear aft=
er execution.=0A=
=0A=
4. Reset Status Clear (via SCU 0x224):=0A=
=0A=
   - The reset status can be cleared by writing 1 to bit 9 (RW1C) of SYS_RS=
T_CLR_2,=0A=
     which will deassert RST_SRC_RB and potentially trigger power-on if no =
hold is active.=0A=
=0A=
5. TSP Power Control Logic:=0A=
=0A=
   - handle_ssp_tsp_on() clears RST_SRC_RB and RST_RB (if not held), and in=
vokes=0A=
     arm_set_cpu_on_and_reset(cpuid) to power on the TSP core (CPUID 5).=0A=
   - handle_ssp_tsp_off() sets RST_RB and RST_SRC_RB; if RST is active, als=
o asserts=0A=
     RST_HOLD_RB and invokes arm_set_cpu_off(cpuid).=0A=
=0A=
The default values are based on EVB (evaluation board) register dump observ=
ations.=0A=
TSP reset control shares the same helper functions and register bit layout =
as SSP,=0A=
with logic selected by cpuid and distinct external reset sources.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Tested-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
---=0A=
 hw/misc/aspeed_scu.c | 37 ++++++++++++++++++++++++++++++++++++-=0A=
 1 file changed, 36 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c=0A=
index 0fdeaf5648..fdb1cf59b4 100644=0A=
--- a/hw/misc/aspeed_scu.c=0A=
+++ b/hw/misc/aspeed_scu.c=0A=
@@ -146,6 +146,7 @@=0A=
 =0A=
 /* SSP TSP */=0A=
 #define AST2700_SCU_SSP_CTRL_0          TO_REG(0x120)=0A=
+#define AST2700_SCU_TSP_CTRL_0          TO_REG(0x160)=0A=
 #define AST2700_SSP_TSP_ENABLE          BIT(0)=0A=
 #define AST2700_SSP_TSP_RST             BIT(1)=0A=
 #define AST2700_SSP_TSP_RST_RB          BIT(8)=0A=
@@ -154,6 +155,9 @@=0A=
 #define AST2700_SCU_SYS_RST_CTRL_1      TO_REG(0x200)=0A=
 #define AST2700_SCU_SYS_RST_CLR_1       TO_REG(0x204)=0A=
 #define AST2700_SCU_SYS_RST_SSP         BIT(30)=0A=
+#define AST2700_SCU_SYS_RST_CTRL_2      TO_REG(0x220)=0A=
+#define AST2700_SCU_SYS_RST_CLR_2       TO_REG(0x224)=0A=
+#define AST2700_SCU_SYS_RST_TSP         BIT(9)=0A=
 =0A=
 #define AST2700_SCU_CLK_SEL_1       TO_REG(0x280)=0A=
 #define AST2700_SCU_HPLL_PARAM      TO_REG(0x300)=0A=
@@ -922,7 +926,10 @@ static void aspeed_ast2700_scu_write(void *opaque, hwa=
ddr offset,=0A=
 =0A=
     switch (reg) {=0A=
     case AST2700_SCU_SSP_CTRL_0:=0A=
-        cpuid =3D a->ssp_cpuid;=0A=
+    case AST2700_SCU_TSP_CTRL_0:=0A=
+        cpuid =3D (reg =3D=3D AST2700_SCU_SSP_CTRL_0) ?=0A=
+                a->ssp_cpuid : a->tsp_cpuid;=0A=
+=0A=
         if (cpuid < 0) {=0A=
             return;=0A=
         }=0A=
@@ -978,6 +985,28 @@ static void aspeed_ast2700_scu_write(void *opaque, hwa=
ddr offset,=0A=
         }=0A=
         s->regs[AST2700_SCU_SYS_RST_CTRL_1] &=3D ~active;=0A=
         return;=0A=
+    case AST2700_SCU_SYS_RST_CTRL_2:=0A=
+        if (a->tsp_cpuid < 0) {=0A=
+            return;=0A=
+        }=0A=
+        data &=3D 0x00001fff;=0A=
+        if (data & AST2700_SCU_SYS_RST_TSP) {=0A=
+            handle_2700_ssp_tsp_off(s, a->tsp_cpuid, AST2700_SCU_TSP_CTRL_=
0);=0A=
+        }=0A=
+        s->regs[reg] |=3D data;=0A=
+        return;=0A=
+    case AST2700_SCU_SYS_RST_CLR_2:=0A=
+        if (a->tsp_cpuid < 0) {=0A=
+            return;=0A=
+        }=0A=
+        data &=3D 0x00001fff;=0A=
+        oldval =3D s->regs[AST2700_SCU_SYS_RST_CTRL_2];=0A=
+        active =3D data & oldval;=0A=
+        if (active & AST2700_SCU_SYS_RST_TSP) {=0A=
+            handle_2700_ssp_tsp_on(s, a->tsp_cpuid, AST2700_SCU_TSP_CTRL_0=
);=0A=
+        }=0A=
+        s->regs[AST2700_SCU_SYS_RST_CTRL_2] &=3D ~active;=0A=
+        return;=0A=
     default:=0A=
         qemu_log_mask(LOG_GUEST_ERROR,=0A=
                       "%s: Unhandled write at offset 0x%" HWADDR_PRIx "\n"=
,=0A=
@@ -1006,7 +1035,9 @@ static const uint32_t ast2700_a0_resets[ASPEED_AST270=
0_SCU_NR_REGS] =3D {=0A=
     [AST2700_HW_STRAP1_SEC2]        =3D 0x00000000,=0A=
     [AST2700_HW_STRAP1_SEC3]        =3D 0x1000408F,=0A=
     [AST2700_SCU_SSP_CTRL_0]        =3D 0x000007FE,=0A=
+    [AST2700_SCU_TSP_CTRL_0]        =3D 0x000007FE,=0A=
     [AST2700_SCU_SYS_RST_CTRL_1]    =3D 0xFFC37FDC,=0A=
+    [AST2700_SCU_SYS_RST_CTRL_2]    =3D 0x00001FFF,=0A=
     [AST2700_SCU_HPLL_PARAM]        =3D 0x0000009f,=0A=
     [AST2700_SCU_HPLL_EXT_PARAM]    =3D 0x8000004f,=0A=
     [AST2700_SCU_DPLL_PARAM]        =3D 0x0080009f,=0A=
@@ -1037,6 +1068,10 @@ static void aspeed_ast2700_scu_reset_hold(Object *ob=
j, ResetType type)=0A=
     if (a->ssp_cpuid > 0) {=0A=
         arm_set_cpu_off(a->ssp_cpuid);=0A=
     }=0A=
+=0A=
+    if (a->tsp_cpuid > 0) {=0A=
+        arm_set_cpu_off(a->tsp_cpuid);=0A=
+    }=0A=
 }=0A=
 =0A=
 static void aspeed_2700_scu_realize(DeviceState *dev, Error **errp)=0A=
-- =0A=
2.43.0=0A=

