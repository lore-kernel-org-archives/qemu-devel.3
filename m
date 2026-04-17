Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEFE7F8E4A4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 03:32:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDZta-0002fB-Ex; Thu, 16 Apr 2026 23:29:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDZtL-0002PD-Dq; Thu, 16 Apr 2026 23:29:16 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDZtJ-0005tG-Hp; Thu, 16 Apr 2026 23:29:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kM4rvUS0uE411c30dfQVSwm/+p5pWWplU0gmuzDMk1P7GN6ScXeeuM6S8hDR5rSoe9NjEuQcY3ljOuZwlttEKkyFy/2xANMeFUrfOk+Ck5vzvNiCnliPQmbmvLRukeJaxCk/87PA3ApPPHTzZBbJ4Hgh8z81dZ3OWaQSipsZzzfDS3CCY3QRfEk1wocEbmungLVVsRoQWsOtdXpS6wVrOITyqrDJsK5g33ELWHZDbxlCuZrBMFzmBxdw/bpwQsVUdRZ48SKbIinA3uD5Q9mMqmTU44DWqTRo6lUOLlFuWHjOcecOjyZegi3YhP3tIyHHuSsmN+M3ehPPwcWP0/eiGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=04PwlUO/BubAURcLwbcrB9F563KOOUB9mK7onbOxn5s=;
 b=Xjglp2fLkQAEZUdFvTrezL1FwATdhlwNdXs+VdstXgi9UsejK5izHVwevbJBfSwXNUOHGjurAuHJmZpBZoKKS9hsuxOTmfmgZFPCTlCXyqlGcYGE9N3VTIZicO1RvVqjd+a/Oc6D6XVaysj03aijwvpkjTvjRGYr++tGT72FYvJmsUtZaDXUzBBEWjAJWgIJjznWk2hclgUg4nxXCBmaTj+hw0zeawEr3hFp8M9+AJAcr6yRZWhJkz8x2vmBOo21HOFaJD7GWgREW/ujmFUYKBRejOhkuLfSnCuxtVIlY8iDDN5KiOe3d5zyGuPBTeuseotZc5zR4nM/g4xQ9Bj3Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04PwlUO/BubAURcLwbcrB9F563KOOUB9mK7onbOxn5s=;
 b=ILarq7JxeJSPAQbsmGr3E15pb15TsA+jQEelW+wgmT34aTLWbzfnqxqOE0eXDmNjak5UIPoWvSwyMSiJpZnpK2beQ3z1+I2+9YD4KEuor77Qr2ABMwFzJo2zI/8T1a9eR/On9cUZp7ZAbov1vU/yyB5dPl4mgEBpWpdHjugXP/Pju2tKw4ReZmGrhxUyuJdafIM69qOYjgvTks4j07/SPVrXfiJyW3oqggxlXO00YXTOFeQTplmKlBC929OU/ivEjkpQUzmbEMPIS1qDaulo2uCQVgFaGo1J3ExDylxociuF1uMaLR3ZD9v55RbjyojrsIxDSZ5vr6h/WVjRQKaBdw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KUZPR06MB8076.apcprd06.prod.outlook.com (2603:1096:d10:43::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 03:29:02 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 03:29:02 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?Windows-1252?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@linaro.org>, Alistair Francis
 <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>, "open list:Block layer
 core" <qemu-block@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v4 18/21] hw/arm/ast27x0: Share single SCUIO instance across
 PSP, SSP, and TSP
Thread-Topic: [PATCH v4 18/21] hw/arm/ast27x0: Share single SCUIO instance
 across PSP, SSP, and TSP
Thread-Index: AQHczhpWpaIQjJL2qkyBZ0SmmuHXHw==
Date: Fri, 17 Apr 2026 03:29:02 +0000
Message-ID: <20260417032837.2664122-19-jamin_lin@aspeedtech.com>
References: <20260417032837.2664122-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260417032837.2664122-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KUZPR06MB8076:EE_
x-ms-office365-filtering-correlation-id: cb4e3318-544d-4a45-9e5b-08de9c3178a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: lJFd0ptxt+0jrKjz0mmrJ7yR0E7webE3fJRIP+pKulmafSXRMi8wMIKxeorAhrOLXHC9WLkh+ODzxztaNFJAiaHuyx4rCLLyE1yuP/g1atiK3QAQtB7/xzUnCVdUofkRKgCbuDEARk5nDqAd8e0JxB6hzh7hG/D5vDhey1XOpgAm0v+m1U6xkjvfThkzRE2JJVmFPaVONvzUJtgQoi5gdUub3+ZdqnKD0eT0Di+UI1vKeUdIPp8l+I5u9mDPxWkhJjAxKv691vtmwMX3Qi6qsa3ZVBjznfGJgBGRQGVQvgvwCBHMJgHcC19XcJcDVT3YrOxtIoEPSwg71Y7VIQtcpqSHOGtT9ewAUeOSqH81aR7hCMADYLbQkk2r7InTSTF19JkFgMhy3VcLKIvk3+7mjew8AK0i0ZJ7JGsHF+8b/I7lxSV9D+GU1BRtnozGrA/mOl+UNfk2hxHGb3kKKK1f3Lh0lXGf29hzOgCcRxEAQFonyQrlvyEQB4iqH9M51piSgLnSMJZgh1gjijMU439FV/UQAlrTc5qDWVhFuBfr8cTPY3Jko/W5ccCAtNISYcABOhiZ7EuSxiVNGtbtATuPNgZ4oqY9hImQr+DodabKa1MWUCSAh4/qJf7/HKP1i0SO5vaNBm8iw4VFNKhMbEpHaVUJvrZ/BHlJL048g7TRX/YoZFuEAOZMwrKV4PzdLEn0imiEJTLxPiFuSE6CFoD6f6YvzlRW1cEqCyCy+CT4ceHMtOPYOL0hsU8YkuOygunnT1Y+maQ6VdGWnyuiPioFVfNrNqG+/B7fuvQHmf+O1ZnrGD7h4qqORjm+QwdcXgHg
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?qb8ENnaVICruGSvB+2zsKlQV68EcTpJWbx3BDWcesUSwvgwCPCSFO1q4?=
 =?Windows-1252?Q?qVvyHt+atfjH13SRQPwUy0omK4NlYAEoaJuvJIUULPyypA02tq6kCoG0?=
 =?Windows-1252?Q?4AjGzqUxgBvoPRsUe0shzmDDjcvsejX1V99F3wvvwIksL/ME1Q41TynT?=
 =?Windows-1252?Q?NhXGuaIN2Bz+tFwvHccnspeLGzVIgLwni6gk+qmmG5DQW80wiJlwc3QT?=
 =?Windows-1252?Q?koTphVkTWoA4NwphjbA0gNWuGBxYt5VOGNHFdw1FNXoSPLvIMnyxH5Gx?=
 =?Windows-1252?Q?1VCz/l2QfuueEj3b0w3U2lgyLgiNg7o9knxZJTGhBslgnD0CQQCPgcA4?=
 =?Windows-1252?Q?Kbvt2CP2rQj+q5vQcDnejd6NnkCNLf+e2bjgjISrOLvW/tAWHxqshTA9?=
 =?Windows-1252?Q?xGV7XmgEHyC4vKWIrI9lq1Y3MR79//JmW+V2t26QxJ9lGQO8NRYOx3jM?=
 =?Windows-1252?Q?ta1OoNW/nYTRJgRULIjSdU8ea7JnLYwWLyYe/aynAC69HZO6CWCqt4GQ?=
 =?Windows-1252?Q?tKyXMchoUgSztTp51HFOijqspsJnKW/+2ivdOnb4sm47t+4SrdPQ/VPa?=
 =?Windows-1252?Q?C9ikhnoMxpwstcJz9WIM3FkAB4sCLogH3hmBUxDxBIADNfMIMNMSfNOV?=
 =?Windows-1252?Q?2NlmRq43QEhBFKxg9dulpoJIjW0MA0Bk7FxvRq38qYjBKHwbfGWgs0jx?=
 =?Windows-1252?Q?sLXdv5M4BDi4NKOH8Vf/hHGl2+qlGy8v3FJp+ZYh8a9tVQMGq2WLvSCI?=
 =?Windows-1252?Q?XY4zsdLqQbp8wuICTVVr8D58JPhj4RhQB2f26Z3xS5OJPXilgemi6H70?=
 =?Windows-1252?Q?+ZdV0wLRnoBbvRLJTDFrqOFTHyiakQd9wT1ELE1i++J1CgnmALv4r+1t?=
 =?Windows-1252?Q?KquevkOOus9a2LPmtNbb5gV1B/aQeZRqUGSZsWa/tAIwdIFheTwY62cz?=
 =?Windows-1252?Q?3HQmvfiuyQebvlYL4fDgB97mPH4bsQr+PZS5kTBhTE7m9iAA8K3eLeoQ?=
 =?Windows-1252?Q?QhDwav6rtVh8wk3MF/3uciJZLyTy0RaDVEynI0PaAilurTCY4GlKEaTu?=
 =?Windows-1252?Q?FIv/ES5nz9KUzIx7lCj9b2iRWoZD6bN4c9Br0fhDCDLlT9GWX1uK2xRB?=
 =?Windows-1252?Q?EsP8sc5Zz795dnaYNaxV3zNL7vtLp7u6BKWHnz5wMpzL45ebXma71Lbu?=
 =?Windows-1252?Q?kzkxCRTkHDCgU8yNcxIDaq2YNsuzfthG/jBvjl87/+LmpO9GVA2qjeTx?=
 =?Windows-1252?Q?0AllJU/+KOOjtJ0isZ1wek2bspVB35E/1cFJiwu1Hlk0iaU7CC/Efzcm?=
 =?Windows-1252?Q?1TNeP6pmF1IM+posC37f1ugK7ADSL+QPlxqZbhfTINSHrToIwIqwYQ+q?=
 =?Windows-1252?Q?1A+DXVF8crYbU1yQv8ah/rqkUac7JLiizAfoOe+6rtrhBLuul+acP5zN?=
 =?Windows-1252?Q?gs5mzeYFZjdF6CSzdF9+AX0qfwLZAYvSa2xOkljw4y3uxL9hkc0S9JBD?=
 =?Windows-1252?Q?qweaQoIExFbGtQDjFRYZ2qhp40Yn9+AzRN3ovdgVBBhArSZVYDhWhLbm?=
 =?Windows-1252?Q?cnt9PIH/aJeyKHVTs++XBg7uBYuvxNkf8/vongMqirm1pwU/zg3KlHY1?=
 =?Windows-1252?Q?RzQMAKPx1fSVEVJ0zm6EY90/ubpDfN/bPaVPNBgRfhAZS4cOccbcz3bH?=
 =?Windows-1252?Q?AxnRteuLmFUfmB4MFnRLMsbk2iEuOokKOLKGlUcD1T52LMxYeFb2SzI9?=
 =?Windows-1252?Q?XS1EwVSpFlLBX1fOD5h8NmBAgIb9qC+2tDD59GuPQswv05uaJ9xw5YhA?=
 =?Windows-1252?Q?RSF7pQQSuzSnHHTXJ36mu2zijwNL/1XEtH/F8/8/zWLus8RRU9YmQfC9?=
 =?Windows-1252?Q?nLIdMi/iIP1fzQ=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: vgoZwwpUXr/AVESK64l6kBquN65EVY0ylf9obfFH/7D4I2sXWio4+UYrRvmkm8Br9OkoWHo6QhMCtlQyrwdqiDazg+815u8KInejuGf703bYD3FYDL1IkuvGBo9wWtF1MzUVjsGBYj4C9lFSUKb2K6GqUQC5nPOYvF8zHF1uiwhkxl3D/eO9B323EyHNm0ABqENf4lApX6h1F48+tQD4uUuQZ8pbcHTuNT5wAmtDPYtsAvwTZXIViXAjewb/9QL2OuG21eU3ev/E0tkrLUgZLOGmMObYVygE4J+wDio0V0FIwrq85pNx+QQU9SiKNwxcmqedvyDnchQjB4xpUcK45A==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb4e3318-544d-4a45-9e5b-08de9c3178a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 03:29:02.4069 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oJ859lWe01igD+HwPoStmkug3hmbUpU0loXxnescUQV+SHzT9WYvRpdoZlx9zUNXxXZZRBrwqKoTJmRINmzYb0oaNKW2rLQDWVI5aKXFMzY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR06MB8076
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
---=0A=
 include/hw/arm/aspeed_coprocessor.h |  4 ++--=0A=
 hw/arm/aspeed_ast27x0-fc.c          |  4 ++++=0A=
 hw/arm/aspeed_ast27x0-ssp.c         | 14 +++++++++-----=0A=
 hw/arm/aspeed_ast27x0-tsp.c         | 14 +++++++++-----=0A=
 4 files changed, 24 insertions(+), 12 deletions(-)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_coprocessor.h b/include/hw/arm/aspeed_co=
processor.h=0A=
index 7750569eed..23c3b97f06 100644=0A=
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
@@ -45,15 +44,16 @@ struct Aspeed27x0CoprocessorState {=0A=
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
     MemoryRegion fmc_alias;=0A=
     Aspeed2700SCUState *scu;=0A=
+    AspeedSCUState *scuio;=0A=
     AspeedSMCState *fmc;=0A=
 };=0A=
 =0A=
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c=0A=
index 56dd86e2c2..d1ff6fbd4d 100644=0A=
--- a/hw/arm/aspeed_ast27x0-fc.c=0A=
+++ b/hw/arm/aspeed_ast27x0-fc.c=0A=
@@ -161,6 +161,8 @@ static bool ast2700fc_ssp_init(MachineState *machine, E=
rror **errp)=0A=
                              OBJECT(&psp->sram), &error_abort);=0A=
     object_property_set_link(OBJECT(&s->ssp), "scu",=0A=
                              OBJECT(&s->ca35.scu), &error_abort);=0A=
+    object_property_set_link(OBJECT(&s->ssp), "scuio",=0A=
+                             OBJECT(&psp->scuio), &error_abort);=0A=
     object_property_set_link(OBJECT(&s->ssp), "fmc",=0A=
                              OBJECT(&psp->fmc), &error_abort);=0A=
     if (!qdev_realize(DEVICE(&s->ssp), NULL, errp)) {=0A=
@@ -195,6 +197,8 @@ static bool ast2700fc_tsp_init(MachineState *machine, E=
rror **errp)=0A=
                              OBJECT(&psp->sram), &error_abort);=0A=
     object_property_set_link(OBJECT(&s->tsp), "scu",=0A=
                              OBJECT(&s->ca35.scu), &error_abort);=0A=
+    object_property_set_link(OBJECT(&s->tsp), "scuio",=0A=
+                             OBJECT(&psp->scuio), &error_abort);=0A=
     object_property_set_link(OBJECT(&s->tsp), "fmc",=0A=
                              OBJECT(&psp->fmc), &error_abort);=0A=
     if (!qdev_realize(DEVICE(&s->tsp), NULL, errp)) {=0A=
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c=0A=
index 78bd6f342c..6c8945ce6c 100644=0A=
--- a/hw/arm/aspeed_ast27x0-ssp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-ssp.c=0A=
@@ -143,8 +143,6 @@ static void aspeed_soc_ast27x0ssp_init(Object *obj)=0A=
                             TYPE_UNIMPLEMENTED_DEVICE);=0A=
     object_initialize_child(obj, "ipc1", &a->ipc[1],=0A=
                             TYPE_UNIMPLEMENTED_DEVICE);=0A=
-    object_initialize_child(obj, "scuio", &a->scuio,=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
     object_initialize_child(obj, "pric0", &a->pric[0],=0A=
                             TYPE_UNIMPLEMENTED_DEVICE);=0A=
     object_initialize_child(obj, "pric1", &a->pric[1],=0A=
@@ -215,6 +213,13 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
             memory_region_size(&a->scu->dram_remap_alias[1]),=0A=
             &a->scu->dram_remap_alias[0]);=0A=
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
@@ -282,9 +287,6 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *=
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
@@ -299,6 +301,8 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *=
dev_soc, Error **errp)=0A=
 static const Property aspeed_27x0_coprocessor_properties[] =3D {=0A=
     DEFINE_PROP_LINK("scu", Aspeed27x0CoprocessorState, scu,=0A=
                      TYPE_ASPEED_2700_SCU, Aspeed2700SCUState *),=0A=
+    DEFINE_PROP_LINK("scuio", Aspeed27x0CoprocessorState, scuio,=0A=
+                     TYPE_ASPEED_SCU, AspeedSCUState *),=0A=
     DEFINE_PROP_LINK("fmc", Aspeed27x0CoprocessorState, fmc, TYPE_ASPEED_S=
MC,=0A=
                      AspeedSMCState *),=0A=
 };=0A=
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c=0A=
index d6448d82f5..cab7f47ac8 100644=0A=
--- a/hw/arm/aspeed_ast27x0-tsp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-tsp.c=0A=
@@ -143,8 +143,6 @@ static void aspeed_soc_ast27x0tsp_init(Object *obj)=0A=
                             TYPE_UNIMPLEMENTED_DEVICE);=0A=
     object_initialize_child(obj, "ipc1", &a->ipc[1],=0A=
                             TYPE_UNIMPLEMENTED_DEVICE);=0A=
-    object_initialize_child(obj, "scuio", &a->scuio,=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
     object_initialize_child(obj, "pric0", &a->pric[0],=0A=
                             TYPE_UNIMPLEMENTED_DEVICE);=0A=
     object_initialize_child(obj, "pric1", &a->pric[1],=0A=
@@ -212,6 +210,13 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
     /* SDRAM remap alias used by PSP to access TSP SDRAM */=0A=
     memory_region_add_subregion(&s->sdram, 0, &a->scu->dram_remap_alias[2]=
);=0A=
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
@@ -279,9 +284,6 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *=
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
@@ -296,6 +298,8 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *=
dev_soc, Error **errp)=0A=
 static const Property aspeed_27x0_coprocessor_properties[] =3D {=0A=
     DEFINE_PROP_LINK("scu", Aspeed27x0CoprocessorState, scu,=0A=
                      TYPE_ASPEED_2700_SCU, Aspeed2700SCUState *),=0A=
+    DEFINE_PROP_LINK("scuio", Aspeed27x0CoprocessorState, scuio,=0A=
+                     TYPE_ASPEED_SCU, AspeedSCUState *),=0A=
     DEFINE_PROP_LINK("fmc", Aspeed27x0CoprocessorState, fmc, TYPE_ASPEED_S=
MC,=0A=
                      AspeedSMCState *),=0A=
 };=0A=
-- =0A=
2.43.0=0A=

