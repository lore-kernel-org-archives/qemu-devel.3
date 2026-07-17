Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 498E0C44514
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 08:19:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkdmN-0006qQ-Sq; Fri, 17 Jul 2026 04:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wkdmL-0006p4-6r; Fri, 17 Jul 2026 04:18:41 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wkdmG-0000E6-0f; Fri, 17 Jul 2026 04:18:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tDDI2+7wTLBVavWngeHVU7I2DDQm4CQJLmkkPyJiaG4p45q+SFrZYnD3JqnFzkq5lRyWzaR5IkmzJImSqL8e4hohGsql76ncx0t6Tf5HhYDsinsmBAQscr5t0WIirTKZwUuQcIuKkKaHPFWIvxXqnwKsARxmytLo53ar057qe/ZKgqYVaT8D1Mk2c2Vj/9fz277M3+IkHIm3d+/rA6byxQzdIU1vPL1imJYGbNV6NjwUi6ulGtW8eqifwFZQqzYYALjDHQzDqJjo8GA0U3jgnEu5bUSNTyji/cejWeeYIGynDyY79bkmezHz8w2v/7cTfcQDa0mKRsYNM5Vww6T77w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EyKKYN90mdpRteDX8L33Wt65GBO4e91s/klb3HWPZXA=;
 b=uF5Tl11oaQjbgoQDV9o/p2A8Seqb0G0r/lHYiXwWOLasUbYZha9bmaEV/v2cMZC84VGYytdltxzeGPS40RS36WmjOTrxjd5gbpUe4XVWEMgA64hRSJSoLpdsiCSh3w/J/n6wV0JvjYSFyWX26xsDfo/CYqlp4Bw/oMKP8qT6A2pNySOJDHFDEISRrHKEXnG0q+zkSUXey2qnUNnkRO114c9Aqt0HJ3N1gYLgbQS0z8RxpctVS2+9KslNujSDyHxcSfmIxNCCEnjfCFwuCKARXh2gK435giflUnlBF78WZUzAO0sClf6gTmfFmujePLOD1Op0Uc8DOa7E+FY/5Fz/vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EyKKYN90mdpRteDX8L33Wt65GBO4e91s/klb3HWPZXA=;
 b=Dc+uMbiwGLMDda3b/JxUMQ0EQO4ETT0feVd2hRj+MlHyQs4snQyRuHoiBc+kLnveQVzPpSV3rgAyLw5qRjULhAfYR+jwhX+d1/NaJyGRjAYP622mGIfSwzlKT5/LXT4T9/uhNbB5PDjGonZGwMbp4z3d2y8CSoYtk6FFsUT3JhOjE1rFLwoxy9Kb6HjvvfrG09KWs/oqSjhB5gMHNTm9n5SjfOkQw9aLflIke9E3toQIoxQzOPm/vKViHaP4FE3SlXs/NrKTU8CN2si7G/iwfwnoagBT+ozexbEWof9NhOboHLf4ahHqCLmw8LXRxdc7qxEoP+Foc4etZ/0vVHKFAw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KU4PR06MB8339.apcprd06.prod.outlook.com (2603:1096:d10:7d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Fri, 17 Jul
 2026 08:18:23 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 08:18:23 +0000
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
Subject: [PATCH v3 7/9] hw/arm/ast27x0: Share FMC controller with SSP and TSP
Thread-Topic: [PATCH v3 7/9] hw/arm/ast27x0: Share FMC controller with SSP and
 TSP
Thread-Index: AQHdFcTV6ZB5mxKEskq6l72xaRNXbQ==
Date: Fri, 17 Jul 2026 08:18:23 +0000
Message-ID: <20260717081813.3407862-8-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 1e3c125a-be84-4647-b367-08dee3dbf7f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|366016|1800799024|38070700021|921020|56012099006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: ACpqzVIaqoTtGC9TWLQr5OdIrjY+H1BIWUSp+KNLgkW+WoLB70FbtMAMt5uzor2Jmn3iYPIxSeJG5erqrUGg2sd3Z4W/W0GnhAS2HSw7I+hbSPULFYPg4L1cemzyF70vpjbmvBeBt0CdtVIPbFVMN9n7GokOP6llxWVkNhgjh9PIfzbbmgGKiFjmdLbiB1Qt9d6C3qQappOTJR2jSJUAhYYQ6owWQReN3u91Z0Ul+U7ekDFB1Hnu62p3i5u2zJG8J6jn3IcJXtmgkTajMSJMKCbGZFmZZgjD6qaMicuDTerOA0KylxCuAdpijUUBp3MaXY6hhDkB2ZeVo6Q7SOyGv2FdzcZIPEh+vhUhc+NeHuLWA1/ggqslnGW/jlu6A0R6dEqn7MhvooeNEPjBck6XmrkdCF0aPBn9jRYY7hTZrizDcb9fXo4zVb5sm5SmgdU2cQiTCMeKpscd59z+YWugeYU2A5BWMn4Y95MaTCJIPz+w4Mpi9jiP7Mqnuz4bCI2W+DYqJTKZv02Fq1wsnRdq8+7Mai2wtZ64US60/TtdfgKQKx/vZtvWEmgy23UdwIxtjsTGLmseoN+XQ/XGh0MUqy9k4yVZf59NxSLoIsAMMfzrIAoCCniWIXr2ISr/aVHJGVzzoMnowjuAph5SLQb2X+d5Hl7FLMEJhEWZN7/MyQNO06C+RIKQTaV359vfO0B7YLBjRtr93e09xuR6wxog1xMKrqJWtvHb60ZVTrvuGl0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(38070700021)(921020)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?rlTci+EIQLEe2TRSKpZJH0F7yT407SChBTnUn5rgsZXqmufMk9nShDDh?=
 =?Windows-1252?Q?CSb0kwP8x1BBMVxeC4wxGuGiAgCkZUK003gCx/0nMAr+nBY2ulmLKkL1?=
 =?Windows-1252?Q?qYqsREQ+IP0IdbElSW0yC4DV8F3+0I2z+mS1G3CBn5G2ipAuXAWpO1md?=
 =?Windows-1252?Q?QMJVdbryiZLzgtt1IsPqaeNi6kkj162XKpRXIFsHUHIjxXAivmb6UwZN?=
 =?Windows-1252?Q?UldbUH8ZocOQDEPwpYc13O/5kgu+vKj+4pxSkcWZR1Rn1C23/GwcieGz?=
 =?Windows-1252?Q?dhiehMaq38d9okBJKocMgtf2V6ST/KjryXxBvfVhjapLJpaKvgZdMIIW?=
 =?Windows-1252?Q?MwMXfBPXcL1aKM78vXk7CVd8+XaUOvl0QJo/CRBCAX2mdQ2/qbA2aT6o?=
 =?Windows-1252?Q?xSnCc8o5vPgIWSx7gZhfoWkygVo9K1kYoL/4//zzM6QvAemhTZGXvGmT?=
 =?Windows-1252?Q?9Uv/rpIzKY1OmmexbMsGHNcMJltfQ8EIR6BIv7cmO3hjnvRpX+6eojVX?=
 =?Windows-1252?Q?fuP6CwmDIsF/IqrAD+fg8ujJLMYGC+dScxQHkb+lIRPsWwz2EOhIRLFN?=
 =?Windows-1252?Q?a0sWWOK7BehACc2ImzybmsiONqRTOKiOqDEgBCeqe9nIutso7ZoZAjI9?=
 =?Windows-1252?Q?IANyQ3EwxOaJF7FyB/QOJYR/c0grdo6W4IEeZ/bUqc4F8XCvFc+We4Vn?=
 =?Windows-1252?Q?gp2PJv/P/hr07QdMcgXjFTCrqmphhr2WlN+36v0m4NjFOOFNsQ9f6oe3?=
 =?Windows-1252?Q?w9Dao0SsdimYd/48xoT4hRSB93F0sfcOaRCmmslJ8xqpwLanOsTpcmcb?=
 =?Windows-1252?Q?UkopN/tWDAL02OnMhEnuqsp4Z9bebTWkCpu/SlJASH4PUpbv6HapmdNc?=
 =?Windows-1252?Q?Vgh88N0zczrBOKXz+NdXgbmhczDHBU+fUUBqwYMys6H6ZKfHl8QmhX6K?=
 =?Windows-1252?Q?MqzvTWxDbhSfFtiPDkPdS2ikXhuhpS6wnvkVvL0XzzZcNkkMguBKwBlC?=
 =?Windows-1252?Q?Q1QMxT2XixjqxlWMqBlZq0f8dfOO7TQStPsRr2BLA2BdnB6GkgLDfPCc?=
 =?Windows-1252?Q?7FVgamMOjkfuTGPl3nCi4lcNPckzF1bPL3an4qWUvfhb2rMz58B7kt5G?=
 =?Windows-1252?Q?3XImxYDuceUHD/M/eyaT5AoR8ux+uVbS09LUcTtijLydGbw+ktt6bCZv?=
 =?Windows-1252?Q?/hE6K1kWwvL8EolmKK90xtsYr17cg7WVLBAfFsNOdero00ziFEdaU4Mv?=
 =?Windows-1252?Q?HRyGUo8tyTlZ2TdsP3RZYeyq+5hlYWC51dDmwNvVs17UbCQJrl1pxDBo?=
 =?Windows-1252?Q?/+UcHTsIHsFzjqsi6DprBxS9f4yMbmljll8nNGltqIVnrG3rZ7blijg4?=
 =?Windows-1252?Q?G54FAHliXBLPylOLjFOKgP7d7uwTJ6u+p8r5rVAFUdlI4yC/fWuq4Ppo?=
 =?Windows-1252?Q?RPl7nUcvJ+ujMI1hRhwZ5DVPzpP3fYAVbC6OG+638ktI2BBbz0OjuJQp?=
 =?Windows-1252?Q?bHm8sElfL6vTc5Ts6xkucOxeobzgUX95SOlMd6uahPdERsbjtmAVmqWy?=
 =?Windows-1252?Q?MIZswopff1JAmxxU7iQjO0JTIJguB3rze0Kf9J8CSGIoMoRIpJ/lUtLk?=
 =?Windows-1252?Q?IvADtAR24g5KoxFEPseCc1ePeVPTtV4wIeixhA+b6T0jhwId9Fc2g0FQ?=
 =?Windows-1252?Q?Q/ejrwAIl6Gm0DfqilqNCxJZTRnNxrNEEmJURBKrp7kb28AuF9xrqcRI?=
 =?Windows-1252?Q?5we85wYucdGHZSAIwSyqUWai4os1fRAMjiZHdzq4DLJwR1cmYxX2Q9KX?=
 =?Windows-1252?Q?hWuCudKyCy/lq3wGom8iMAnK9ZNUcztknDrQaQ7MF5c9obPQttyuZBk/?=
 =?Windows-1252?Q?QeaWD4/y5pdIyw=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pnfQFLJP3KgD+6NneY/XZEUG/xT1y/v++crDzN65TgLyKuufqoKvBg1+1o/ShxmJuzWzY1U0oOUH9ZSJXC4Z4rtCvjmgGUiVh/M9uC8lp8khwGDMfAMCuQOS4/wBkQH2/41cXttrLe3soUYjFH8HeBbNyHfmeEUpIJR5YA/9zWlrOwaXMWdDp/S3EQMpweS4CAB0x2LsU6GZ3BxdIIUY+XsSicRa1X4hhY4BM8fVTQRLaPPcUJ/jTde/N0KCoRGh2uINHqq2H6TdagX35IOxw99vpKAQyUgDNNi6HDMLL3CmxqYrnuD0tqEnZmXU6fcZ+rPSIu3V6Tmn6hzMs5NXhQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e3c125a-be84-4647-b367-08dee3dbf7f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 08:18:23.0353 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qrmSMECCWcPNe/F6e5oMtyLf5KCR29TMkVrQthLsDFIeVNzk5C6YqkUGj0EfXuCgvQ76Z5gWx7lnAhl7n2mA6fXqhxaxtKRfznlK0+cTeSQ=
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

AST2700 provides a single FMC controller shared by the main CA35 processor=
=0A=
(PSP) and the SSP/TSP coprocessors.=0A=
=0A=
From the PSP perspective, the FMC controller is memory-mapped at=0A=
0x14000000=960x140000FF. The SSP and TSP access the same controller through=
=0A=
a different address window at 0x74000000=960x740000FF.=0A=
=0A=
This change allows the SSP and TSP SoC models to reference the existing=0A=
PSP FMC instance instead of creating independent controllers. An MMIO=0A=
alias is added in the SSP and TSP address spaces to map their FMC access=0A=
window to the shared FMC device.=0A=
=0A=
This ensures consistent FMC state across PSP, SSP, and TSP and matches=0A=
the AST2700 hardware design.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
Tested-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
---=0A=
 include/hw/arm/aspeed_coprocessor.h |  7 +++++++=0A=
 hw/arm/aspeed_ast27x0-fc.c          |  4 ++++=0A=
 hw/arm/aspeed_ast27x0-ssp.c         | 16 ++++++++++++++++=0A=
 hw/arm/aspeed_ast27x0-tsp.c         | 16 ++++++++++++++++=0A=
 4 files changed, 43 insertions(+)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_coprocessor.h b/include/hw/arm/aspeed_co=
processor.h=0A=
index b77ea06e7f..acb8b06457 100644=0A=
--- a/include/hw/arm/aspeed_coprocessor.h=0A=
+++ b/include/hw/arm/aspeed_coprocessor.h=0A=
@@ -49,10 +49,17 @@ struct Aspeed27x0CoprocessorState {=0A=
 =0A=
     ARMv7MState armv7m;=0A=
 =0A=
+    /*=0A=
+     * SCU, SCUIO and FMC are not owned by this coprocessor: they are=0A=
+     * shared with the main PSP SoC, and only aliased into this=0A=
+     * coprocessor's own address space here.=0A=
+     */=0A=
     MemoryRegion scu_alias;=0A=
     MemoryRegion scuio_alias;=0A=
+    MemoryRegion fmc_alias;=0A=
     Aspeed2700SCUState *scu;=0A=
     AspeedSCUState *scuio;=0A=
+    AspeedSMCState *fmc;=0A=
 };=0A=
 =0A=
 #define TYPE_ASPEED27X0SSP_COPROCESSOR "aspeed27x0ssp-coprocessor"=0A=
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c=0A=
index d14a42ebca..058cea42ed 100644=0A=
--- a/hw/arm/aspeed_ast27x0-fc.c=0A=
+++ b/hw/arm/aspeed_ast27x0-fc.c=0A=
@@ -159,6 +159,8 @@ static bool ast2700fc_ssp_init(Ast2700FCState *s, Aspee=
dSoCState *psp,=0A=
                              OBJECT(&s->ca35.scu), &error_abort);=0A=
     object_property_set_link(OBJECT(&s->ssp), "scuio",=0A=
                              OBJECT(&psp->scuio), &error_abort);=0A=
+    object_property_set_link(OBJECT(&s->ssp), "fmc",=0A=
+                             OBJECT(&psp->fmc), &error_abort);=0A=
     if (!qdev_realize(DEVICE(&s->ssp), NULL, errp)) {=0A=
         return false;=0A=
     }=0A=
@@ -191,6 +193,8 @@ static bool ast2700fc_tsp_init(Ast2700FCState *s, Aspee=
dSoCState *psp,=0A=
                              OBJECT(&s->ca35.scu), &error_abort);=0A=
     object_property_set_link(OBJECT(&s->tsp), "scuio",=0A=
                              OBJECT(&psp->scuio), &error_abort);=0A=
+    object_property_set_link(OBJECT(&s->tsp), "fmc",=0A=
+                             OBJECT(&psp->fmc), &error_abort);=0A=
     if (!qdev_realize(DEVICE(&s->tsp), NULL, errp)) {=0A=
         return false;=0A=
     }=0A=
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c=0A=
index fa492f1797..e03653086c 100644=0A=
--- a/hw/arm/aspeed_ast27x0-ssp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-ssp.c=0A=
@@ -27,6 +27,7 @@ static const hwaddr aspeed_soc_ast27x0ssp_memmap[] =3D {=
=0A=
     [ASPEED_DEV_TIMER1]    =3D  0x72C10000,=0A=
     [ASPEED_DEV_UART4]     =3D  0x72C1A000,=0A=
     [ASPEED_DEV_IPC0]      =3D  0x72C1C000,=0A=
+    [ASPEED_DEV_FMC]       =3D  0x74000000,=0A=
     [ASPEED_DEV_PRIC1]     =3D  0x74100000,=0A=
     [ASPEED_DEV_SCUIO]     =3D  0x74C02000,=0A=
     [ASPEED_DEV_OTP]       =3D  0x74C07000,=0A=
@@ -177,6 +178,12 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
         return;=0A=
     }=0A=
 =0A=
+    if (!a->fmc) {=0A=
+        error_setg(errp, TYPE_ASPEED27X0SSP_COPROCESSOR=0A=
+                   ": 'fmc' link is not set");=0A=
+        return;=0A=
+    }=0A=
+=0A=
     /* AST27X0 SSP Core */=0A=
     armv7m =3D DEVICE(&a->armv7m);=0A=
     qdev_prop_set_uint32(armv7m, "num-irq", 256);=0A=
@@ -269,6 +276,13 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
     sysbus_connect_irq(SYS_BUS_DEVICE(s->uart), 0,=0A=
                        aspeed_soc_ast27x0ssp_get_irq(s, s->uart_dev));=0A=
 =0A=
+    /* FMC */=0A=
+    memory_region_init_alias(&a->fmc_alias, OBJECT(a), "fmc.alias",=0A=
+                             &a->fmc->mmio, 0,=0A=
+                             memory_region_size(&a->fmc->mmio));=0A=
+    memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_FMC],=0A=
+                                &a->fmc_alias);=0A=
+=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->timerctrl)=
,=0A=
                                   "aspeed.timerctrl",=0A=
                                   sc->memmap[ASPEED_DEV_TIMER1], 0x200);=
=0A=
@@ -294,6 +308,8 @@ static const Property aspeed_27x0_coprocessor_propertie=
s[] =3D {=0A=
                      TYPE_ASPEED_2700_SCU, Aspeed2700SCUState *),=0A=
     DEFINE_PROP_LINK("scuio", Aspeed27x0CoprocessorState, scuio,=0A=
                      TYPE_ASPEED_SCU, AspeedSCUState *),=0A=
+    DEFINE_PROP_LINK("fmc", Aspeed27x0CoprocessorState, fmc, TYPE_ASPEED_S=
MC,=0A=
+                     AspeedSMCState *),=0A=
 };=0A=
 =0A=
 static void aspeed_soc_ast27x0ssp_class_init(ObjectClass *klass,=0A=
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c=0A=
index 3a98bd232c..39ba062a20 100644=0A=
--- a/hw/arm/aspeed_ast27x0-tsp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-tsp.c=0A=
@@ -27,6 +27,7 @@ static const hwaddr aspeed_soc_ast27x0tsp_memmap[] =3D {=
=0A=
     [ASPEED_DEV_TIMER1]    =3D  0x72C10000,=0A=
     [ASPEED_DEV_UART4]     =3D  0x72C1A000,=0A=
     [ASPEED_DEV_IPC0]      =3D  0x72C1C000,=0A=
+    [ASPEED_DEV_FMC]       =3D  0x74000000,=0A=
     [ASPEED_DEV_PRIC1]     =3D  0x74100000,=0A=
     [ASPEED_DEV_SCUIO]     =3D  0x74C02000,=0A=
     [ASPEED_DEV_OTP]       =3D  0x74C07000,=0A=
@@ -177,6 +178,12 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
         return;=0A=
     }=0A=
 =0A=
+    if (!a->fmc) {=0A=
+        error_setg(errp, TYPE_ASPEED27X0TSP_COPROCESSOR=0A=
+                   ": 'fmc' link is not set");=0A=
+        return;=0A=
+    }=0A=
+=0A=
     /* AST27X0 TSP Core */=0A=
     armv7m =3D DEVICE(&a->armv7m);=0A=
     qdev_prop_set_uint32(armv7m, "num-irq", 256);=0A=
@@ -269,6 +276,13 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
     sysbus_connect_irq(SYS_BUS_DEVICE(s->uart), 0,=0A=
                        aspeed_soc_ast27x0tsp_get_irq(s, s->uart_dev));=0A=
 =0A=
+    /* FMC */=0A=
+    memory_region_init_alias(&a->fmc_alias, OBJECT(a), "fmc.alias",=0A=
+                             &a->fmc->mmio, 0,=0A=
+                             memory_region_size(&a->fmc->mmio));=0A=
+    memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_FMC],=0A=
+                                &a->fmc_alias);=0A=
+=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->timerctrl)=
,=0A=
                                   "aspeed.timerctrl",=0A=
                                   sc->memmap[ASPEED_DEV_TIMER1], 0x200);=
=0A=
@@ -294,6 +308,8 @@ static const Property aspeed_27x0_coprocessor_propertie=
s[] =3D {=0A=
                      TYPE_ASPEED_2700_SCU, Aspeed2700SCUState *),=0A=
     DEFINE_PROP_LINK("scuio", Aspeed27x0CoprocessorState, scuio,=0A=
                      TYPE_ASPEED_SCU, AspeedSCUState *),=0A=
+    DEFINE_PROP_LINK("fmc", Aspeed27x0CoprocessorState, fmc, TYPE_ASPEED_S=
MC,=0A=
+                     AspeedSMCState *),=0A=
 };=0A=
 =0A=
 static void aspeed_soc_ast27x0tsp_class_init(ObjectClass *klass,=0A=
-- =0A=
2.43.0=0A=

