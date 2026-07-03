Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 071D4C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 06:47:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfXeQ-0007Wi-6q; Fri, 03 Jul 2026 02:45:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wfXeP-0007WD-1E; Fri, 03 Jul 2026 02:45:25 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wfXeN-0003vj-DX; Fri, 03 Jul 2026 02:45:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xNMO1+jflw1B5OlTrVmHa9Pt3o/TB2khpe5nDfmSPsthaeAxzvPv9JUKTB9Ja+L8vcMr71msIUf5/zOXB2B3G4tv23gKo9c0FcmzkhBXYnqPZogozxHM4WPrTdiGOVIVW+CLFuHW1SOQqlCwmOMgLNbUTzwUYkKrWfp/zBMb5nxTJhNGATo1FZF6rCpF+rk5qNb5995UL8OwHuI71U2vxS5A65Bv0zKYQWa61OSQaxLusj62Qn1KeiLSpWls1lBiKBB+myVkG0mt9fTfS6QBuI5nwJyxTqP9MOy6FRFE15O+kBoXMxMrdH256GQNgIdYMLELGR0p/c9B6M65qSpQyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c0BJSjtYjdkqi+ILhq2zl568FPcsZdGVcro0LW+ary8=;
 b=Cdx45/z1DBtlMFu83TdN5QQowsNyDyI1PVU3/5Qs9v69VGHApMkHOePQsgTxDoUhsK9GB4SB2DnbGtjHQoPQ5SdTRo8kzlzreZgUpAOg4e8EqOKFnV2IIGoWXOEFK0G/72q2RquRuEmlLJOQrioq76dcKcAN2zd56Pt5yx54kcXkj4D9ccghEfAhgCCXLdCSeMZeIvXsIpFIUTRAAYN8aM6Nxgkls4qSRwNjOqotoH0NbBFIHTAcNZXwGOrcSTtw5o4GemI4Ga0cyAauNSZ54gcF415civU637rsm8i+Zq9T12vui7iF2Wj9B98Z5lw9F8O0rpitc20IQBifK3xA/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0BJSjtYjdkqi+ILhq2zl568FPcsZdGVcro0LW+ary8=;
 b=fn3IKsmMUIsl0xUCEK6LkO1Bxi+fPPklYXWgXKT+RxkafsabbY6LIgoVxNkPKt4p1GhvzLrrYGsGoeMoUC+3CWpsdyfAx6sa8hPf3o7mcjt2CkbELGbvAAJJeC96sb/x6KjC44yEJP5bEtkrMvJYbv9V317R3hWPV0Ogw7AsDCs5+H8xYv6S5nQXZm98fSsPVjfaV73oM1mqaWfYsakTzREQH3MXaFxCXi42qvPImL0u3WIwM0BjygmlcqlTuhVhYZWajhalfxPrikB//PxlSxs/NFzJBYD5fUWPjFD1oONrUwlhW4Y3rjCpGyh3v67eoN65lzJk63VNLH8RplJkxw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by PUZPR06MB5499.apcprd06.prod.outlook.com (2603:1096:301:100::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 06:45:12 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 06:45:12 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 5/5] hw/arm/aspeed_ast27x0: Add unimplemented OTP
 controller MMIO regions for SSP/TSP
Thread-Topic: [PATCH v1 5/5] hw/arm/aspeed_ast27x0: Add unimplemented OTP
 controller MMIO regions for SSP/TSP
Thread-Index: AQHdCrd/ydns72oqWEOGdNGkyGYC/w==
Date: Fri, 3 Jul 2026 06:45:12 +0000
Message-ID: <20260703064506.937904-6-jamin_lin@aspeedtech.com>
References: <20260703064506.937904-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260703064506.937904-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|PUZPR06MB5499:EE_
x-ms-office365-filtering-correlation-id: 5a690954-be98-4d15-8cda-08ded8cea20a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|18002099003|22082099003|38070700021|56012099006;
x-microsoft-antispam-message-info: xl6hXArhDwYWOHVTJblqLDJFTBOC0K7JoHUtH9Xl1TzzXD4FLyBlg2el8jYgfGPdmeCPMtYJBzwWrVXEgXZZiL0TTZIsDYpz/oZ4cFyHoGE7fsr7IE7Djg1GRWWVD+HVocTe57o5UoA1CUeXAs/W8oVumUyuR5ZyMCgMQ7Mp++WLPBOUXcDqPA+cJKVFlcrJIhlzJ+8Neryd5Cf61xavxmFDl6ASsO9WxLiOFt3U89y+xPTEfJgEdnsWhD80il5QlHU0+15m6PLThotO9If0G2eSMOMIhmSDQsIUGrT6PE+5us3JtRF0YCzakIsxJDzzckSGUs5CquWa2oNaLxo+LYvLa/jN2KcUp1suXk/hD607Yul3S/GUZZbnDXgACQ1BsMWA5DVWLoyeHn2WIfmZbaazhUp6E26WvrcNRZuu5KB8QFIeKjTSAcvwtJ8L0C2uQMqvbzlhDCxCws+Zhg003HfDamMy4fuEs6eUWWPA0JpyWOpQlrIxssXWmEm7zi8yp64UPSJDKzKHurukWuo/mkOYwVrtrSBiL8ReVjkekOiJWCDusfvmacFgzNfmjnP5GxGpf1r3Rj7lb4mjMeI77anKkrlJ244GIJ/3enmZ2qfaXoj99MPCjLHLmOq6LsG2LHZfZpTicw6hlDSIx+cWffrEl++793bOQ33VSuLIcwu2yY52NSrkiPorpurAb6NW+SVCZ1lhITazJinigC+7mZeKK4n/x2aBnxcXhvf44H0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(38070700021)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tcn8SOxslGnX7sW+eG30Nhd8OMjMkV+/kpw8lzztqzaOgjClEhUNu6yxvG?=
 =?iso-8859-1?Q?RYIoYKGOnSZXvCjJRG+VETe54CbL6qgPAdUghjuAbTiIBNgtshQTkUJEMv?=
 =?iso-8859-1?Q?zKULSCbgmvOt/q6TyV5SLKO9gX28UYL2QVn5ic8qLGe7w/MKbOmxCoSahM?=
 =?iso-8859-1?Q?XadrG2zexCw2RMbERV9U1HMRyto/4Bb2JMMuL9z/aNc1QFajADqmmIQ/20?=
 =?iso-8859-1?Q?M482gdD80F/yIGleHCtciWxQRQlGsQG4JNanQIL0jTKbMXgW4xq0bWR9dP?=
 =?iso-8859-1?Q?EFYbYmZMBr4RuBwm/bWAJqx+ws+TFqZGO1BSvDFJhaoNXwl1SPO1mk4EgR?=
 =?iso-8859-1?Q?WnQV4K03lrfJ/bQT06dO1eXTbRrNEaQHnkglTGl0vjDXQUNumYJYUCjYn/?=
 =?iso-8859-1?Q?UF+KazwWeJmczvJkob0Q0zEY9luqO7gurjnsuPnkFP6Z1ZgkHlFqptQcR2?=
 =?iso-8859-1?Q?uik6/zy3Pxi0M1/DiP3pqibbtvNf1tZPb3riYmMGrHq1yk5/Ul+hrm5cnJ?=
 =?iso-8859-1?Q?HQP8UPLK2Srl8qphtSEPnsKCYBKFZ3LTB0SJbWz1o1SMO8hpu/nCalovXL?=
 =?iso-8859-1?Q?vhVJgHSPj4YMgbCzepn1nbhNyizqooAiLuwbk20QhXNghC6XR1J4ctZlvI?=
 =?iso-8859-1?Q?HjAXClDRkzY/GuYbscVJF2ZJX1Sz2XmaafVHjXcRUqEpsQ5lge5tXe0qQU?=
 =?iso-8859-1?Q?8CdgVbWGggpjYZCt5As+P7Hh20/Nnm6SY7WnWBqW21V+DdzysD4r61VvVx?=
 =?iso-8859-1?Q?HjZj70E4/XF94GWJTsyIk+/Hkml+9HXnGbooBxqxf8w0zzQwgMcPJStr0H?=
 =?iso-8859-1?Q?9f3ARiDitQyuLv/+9PKIS/dMpppPCBrCO3rrlk6nCTxZgoOgv3/ltVxP2E?=
 =?iso-8859-1?Q?pFwnwi4FvxcF/FLfdpj49Kq8IbZ5Mewl/IwW6R34Aar54DblYehPWMqmfa?=
 =?iso-8859-1?Q?eUfRux+aZpFWiRkvIz2eTbP1JiYXrhKTNbpqjXyr8RYkbZ/3xbhIj2vBM+?=
 =?iso-8859-1?Q?7aMbSG4klp02b8ApK7vQaQW07ZMpLTOLc6TFbsEyUYyHqY8m5rjjSAWovk?=
 =?iso-8859-1?Q?ZbpVCFwnh5h2kKyDUSqajfCB6n6Xh1XyN2q5rW/9cZRig25yFMP6c5+5l7?=
 =?iso-8859-1?Q?AS874JWOVGjDq48hafMUFjPXDNF3VRQX+NC2bndXDLZEcDKP8gzxrXL0Do?=
 =?iso-8859-1?Q?p7YD5wd7uRv+Toies826+UznGQg5BREchY+L+bzo5PrTjjR6j22MYv0mpb?=
 =?iso-8859-1?Q?xFbUxBdWltb0hgBpk6qcEOkP2mKD6p1dQ1Z+eEjnXyhj6cNUWMerYRkSmH?=
 =?iso-8859-1?Q?Z4C/mmAOll4LwK0MtcC7E34Q1DehNgasKQoUNlsGn4fywtbXvYibcyDbX8?=
 =?iso-8859-1?Q?x0jWlX3pvia7wxWqB4YBdslpIMRjnC4v/mAtY57Hb7UsZzmIn/UzHRyhUD?=
 =?iso-8859-1?Q?DscgxqaHN260IDdeREG9OjcUG/r6mhf2ahaj6hgZeiUN8QUsbFX5kkQqz1?=
 =?iso-8859-1?Q?0kr+dTvADyJ4KUi8npwG3irP6VJRsDHr/fno/RaZXB5XOLat6/CYygNQJ3?=
 =?iso-8859-1?Q?2F3xkT4VFciKHM7sBrt+xZsJUlgg03kyzcVxRAgG4ix6vlyi0XrZ2oH68G?=
 =?iso-8859-1?Q?pNp330L+O3K+eYjJ58qpP7E2o/+7IXSACR5jzRjIPaWQkAavnD2tB0DiXv?=
 =?iso-8859-1?Q?gQqWcdTUlB/1da5MEsTJBpQn1sI4ZkNHWytfI8kjYoDFnBSxgfPyEw8SQU?=
 =?iso-8859-1?Q?yjwpu2Z+AZUQ35X0f1Zf9picliFlJKxfinNLHUG5pa15gX9UBe1RYYHXGT?=
 =?iso-8859-1?Q?+97Eg53KUQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: D7/6K24bm0uw0yEatBNFmxuO+CfBg4TKWd1aDFGD2JI/VnSOR02t57xg5KeMbS5ery+7iheNokmoIVJF4qGSVlXJxd/pMIRiADj90fzPXJd81Lz77ZsC9jFCZVyCoAPMteyWrSwZW+uaJ+/bisnKKLQDStBgVoxwF09WVo56GiuCuRyU1Aj3xOO0yx0ZAprabgnxyLrQRDVgkPfecgllhPhe206N4vHpllVcCWMYnVhKGel8vAAaawI280lfZCYppkVwkKCrnn+H+sOig1jHGUgno3wBrg2CLF++8ApZwyEUMhJ7BDJoVqV3wPR/Vl61EU+/k9ZL7YvKHtc2/5nmTw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a690954-be98-4d15-8cda-08ded8cea20a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2026 06:45:12.6567 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o4b1rGzsTghbo1T6p/X5wtz/N8eEHIaP/xvk0wqfPtvpcNvPOx27ZaWzz7wXdQ6cdUZD1fMPoojRK6kXIl9LEpgYqQGIyXwuztlfa2pzNJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5499
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The AST2700 SSP/TSP firmware accesses OTP MMIO regions that=0A=
are not yet implemented in QEMU.=0A=
=0A=
This change adds unimplemented MMIO devices for the OTP and maps them to=0A=
their corresponding physical addresses in the SSP/TSP address space.=0A=
These stub devices allow QEMU to safely handle firmware=0A=
accesses and prevent spurious exceptions, while accurately reflecting=0A=
the hardware memory map.=0A=
=0A=
No functional changes.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/arm/aspeed_coprocessor.h | 1 +=0A=
 include/hw/arm/aspeed_soc.h         | 1 +=0A=
 hw/arm/aspeed_ast27x0-ssp.c         | 6 ++++++=0A=
 hw/arm/aspeed_ast27x0-tsp.c         | 6 ++++++=0A=
 4 files changed, 14 insertions(+)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_coprocessor.h b/include/hw/arm/aspeed_co=
processor.h=0A=
index 700cbfb4bb..ac58a5f424 100644=0A=
--- a/include/hw/arm/aspeed_coprocessor.h=0A=
+++ b/include/hw/arm/aspeed_coprocessor.h=0A=
@@ -49,6 +49,7 @@ struct Aspeed27x0CoprocessorState {=0A=
     UnimplementedDeviceState ipc[2];=0A=
     UnimplementedDeviceState scuio;=0A=
     UnimplementedDeviceState pric[2];=0A=
+    UnimplementedDeviceState otp;=0A=
 =0A=
     ARMv7MState armv7m;=0A=
 };=0A=
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h=0A=
index a0d2432620..41dc04e293 100644=0A=
--- a/include/hw/arm/aspeed_soc.h=0A=
+++ b/include/hw/arm/aspeed_soc.h=0A=
@@ -297,6 +297,7 @@ enum {=0A=
     ASPEED_DEV_IOEXP1_I3C,=0A=
     ASPEED_DEV_PRIC0,=0A=
     ASPEED_DEV_PRIC1,=0A=
+    ASPEED_DEV_OTP,=0A=
 };=0A=
 =0A=
 const char *aspeed_soc_cpu_type(const char * const *valid_cpu_types);=0A=
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c=0A=
index 1b68e4eb5f..cb96a56d7a 100644=0A=
--- a/hw/arm/aspeed_ast27x0-ssp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-ssp.c=0A=
@@ -30,6 +30,7 @@ static const hwaddr aspeed_soc_ast27x0ssp_memmap[] =3D {=
=0A=
     [ASPEED_DEV_FMC]       =3D  0x74000000,=0A=
     [ASPEED_DEV_PRIC1]     =3D  0x74100000,=0A=
     [ASPEED_DEV_SCUIO]     =3D  0x74C02000,=0A=
+    [ASPEED_DEV_OTP]       =3D  0x74C07000,=0A=
     [ASPEED_DEV_INTCIO]    =3D  0x74C18000,=0A=
     [ASPEED_DEV_UART0]     =3D  0x74C33000,=0A=
     [ASPEED_DEV_UART1]     =3D  0x74C33100,=0A=
@@ -148,6 +149,8 @@ static void aspeed_soc_ast27x0ssp_init(Object *obj)=0A=
                             TYPE_UNIMPLEMENTED_DEVICE);=0A=
     object_initialize_child(obj, "pric1", &a->pric[1],=0A=
                             TYPE_UNIMPLEMENTED_DEVICE);=0A=
+    object_initialize_child(obj, "otp", &a->otp,=0A=
+                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
 }=0A=
 =0A=
 static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **er=
rp)=0A=
@@ -268,6 +271,9 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *=
dev_soc, Error **errp)=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->pric[1]),=
=0A=
                                   "aspeed.pric1",=0A=
                                   sc->memmap[ASPEED_DEV_PRIC1], 0x1000);=
=0A=
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->otp),=0A=
+                                  "aspeed.otp",=0A=
+                                  sc->memmap[ASPEED_DEV_OTP], 0x800);=0A=
 }=0A=
 =0A=
 static void aspeed_soc_ast27x0ssp_class_init(ObjectClass *klass,=0A=
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c=0A=
index 59dcccd511..f6d63115aa 100644=0A=
--- a/hw/arm/aspeed_ast27x0-tsp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-tsp.c=0A=
@@ -30,6 +30,7 @@ static const hwaddr aspeed_soc_ast27x0tsp_memmap[] =3D {=
=0A=
     [ASPEED_DEV_FMC]       =3D  0x74000000,=0A=
     [ASPEED_DEV_PRIC1]     =3D  0x74100000,=0A=
     [ASPEED_DEV_SCUIO]     =3D  0x74C02000,=0A=
+    [ASPEED_DEV_OTP]       =3D  0x74C07000,=0A=
     [ASPEED_DEV_INTCIO]    =3D  0x74C18000,=0A=
     [ASPEED_DEV_UART0]     =3D  0x74C33000,=0A=
     [ASPEED_DEV_UART1]     =3D  0x74C33100,=0A=
@@ -148,6 +149,8 @@ static void aspeed_soc_ast27x0tsp_init(Object *obj)=0A=
                             TYPE_UNIMPLEMENTED_DEVICE);=0A=
     object_initialize_child(obj, "pric1", &a->pric[1],=0A=
                             TYPE_UNIMPLEMENTED_DEVICE);=0A=
+    object_initialize_child(obj, "otp", &a->otp,=0A=
+                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
 }=0A=
 =0A=
 static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **er=
rp)=0A=
@@ -268,6 +271,9 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *=
dev_soc, Error **errp)=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->pric[1]),=
=0A=
                                   "aspeed.pric1",=0A=
                                   sc->memmap[ASPEED_DEV_PRIC1], 0x1000);=
=0A=
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->otp),=0A=
+                                  "aspeed.otp",=0A=
+                                  sc->memmap[ASPEED_DEV_OTP], 0x800);=0A=
 }=0A=
 =0A=
 static void aspeed_soc_ast27x0tsp_class_init(ObjectClass *klass,=0A=
-- =0A=
2.43.0=0A=

