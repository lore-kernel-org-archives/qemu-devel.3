Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DDB4CA9ED5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 06:47:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xG9mh-0001r6-27; Mon, 12 Oct 2026 02:45:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xG9ma-0001oX-IH; Mon, 12 Oct 2026 02:45:12 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xG9mZ-0006Ms-48; Mon, 12 Oct 2026 02:45:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zGW5dCWVGn0PM5cgtbIr9+1NpAyoD7KJntYOREJA4Fx0ENuX81WcsIDIkdhljd9v/U2FmVxh50vTW5sE/q6PVfaqrNszaGb0bgoGG53ucHu1+PiDgK/gMnXW2eS2jQC5IKikCIjidRqfQjeD1Mf9fTFz+3VUFUG4mP2ulEu1yPCna0rZW2+eTfCMGvCJxuK5Y0s8xTnqdyBjYATsJJMbPI/s08QETgqVqHuQYVALq6uB6CC5rZiRAHEsRrq46i1EhsvkvpKUoDxUgNXy8BMTz7914YvTF3XMZfBRAo89siDTK7T1WfQ6hZQOfgwC2vbZUyJbvA4Za7HH+sx6bBnqRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8R6QC7rZsp+5qW6HMI+M+bud2W5oZ8xLIISlTMJd2g4=;
 b=WQStc66MDTFo4ibDNfAlqgeX1dL1X2SYK+LcJEW09h04ZsCV6IMF1IG8VG33XDDXoj5rpZZ7Tu9m+2WoPrhp8sL7pnObwgUSffOTRlaVrDPY68cXYJVnWAF2wz7JPOUyiMSfuhtMtLk3M343lxmGkhgYdxrEOA50+zfJS9pmZKSLy9k3KKSvl0Tl4fCWJDyr+WgP2HPoA78+hfFJPKS1OBWH9xdvJWc6wZu5NozdQrZiC0mmnIrjZ/qopsx1S/8soV9KAypbE69Wy3nXgultjcak8FQRXH9kOwqWjP9WuRJitYin8n5dEDMhTbvDV+wFH67nEVnWD3mmWC0RS1dUzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8R6QC7rZsp+5qW6HMI+M+bud2W5oZ8xLIISlTMJd2g4=;
 b=ORaChRf1TJFk14xF/gP1vFfi4y/B/Y3JTz2j6z14MzccVfhRurHi6SbEZp58nMb0glt7YMKeotp2/QWlzTxW+GoxtoDJmjhQOwJuNhxdOVWaWwGNt9Fdg/UJe71f1hMhhEKFWy7KuDhcnggfLIrmIlnMg3iab9W3hemQBV/O8W+PUIYqvljhHS7TkDG0xcbMrxOvF+Ye51l4OUzoPiC0wgcRpOejy6/H/7ikrUv5or8CpD9dylQLYuwPvy2HyKM1H3B6jL2Gx3pMLXZsO/AmNrbuTlmMQDZuNeebyDiDNf7D8cplMMwRJBqWnY6d1QraB4d2iNDWcORXhQXFoqqp+Q==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SI6PR06MB7244.apcprd06.prod.outlook.com (2603:1096:4:243::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 06:44:56 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 06:44:56 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Ani Sinha
 <anisinha@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v2 09/12] hw/arm/aspeed_coprocessor: Remove unused
 unimplemented device fields
Thread-Topic: [PATCH v2 09/12] hw/arm/aspeed_coprocessor: Remove unused
 unimplemented device fields
Thread-Index: AQHdWhUxLzQZ4Bp4iEa6br/nliVo8A==
Date: Mon, 12 Oct 2026 06:44:56 +0000
Message-ID: <20261012064445.2571633-10-jamin_lin@aspeedtech.com>
References: <20261012064445.2571633-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261012064445.2571633-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SI6PR06MB7244:EE_
x-ms-office365-filtering-correlation-id: 5bac63a9-9f01-486e-b3a5-08df282c53fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|7416014|10067099003|261009220027099003|261009223327099003|261009221227099003|261009221727099003|261009223027099003|38070700021|921020|22082099003|18002099003|56012099006;
x-microsoft-antispam-message-info: 9I67EqqLPOMbZStMV/km0ZRwqG+DL6t6kVi8G4+GCRvYdlOs+1YDS7Rvs0xvo9bWlvd6VnkCxVw6y+g2LO4gR4GPkYjXlFPihJGTQwaeOc4gA5h5ODpqtxY2/c52Hh6KoxbQObsyXeq6sDIKgHBGJgTnljKB6FZH1FjsAo3uDRL6jlnDcR87X9DpCowjvJkwP+Xjsj+dqRpXoNSrdTG/EvRJUnTE9YTHB0wjbfM+k5GjBt2zemnyHFbNwoQIXkIY6dMvcN7u1bcZpO6U+Bb3I+Tyk2hiNeKGuAWBuIB3yP6bU2GMDJpsiSgmXI1Oa/0i0vbD3bOuZGIyFzEp3fRH7bAIbN4iDhUIfj5qr0CV9kDCqh0Aeqos2ehG4ws5yWUoM1SczIuienHI/g02HRGESpmKyKT4OHE0mTUEtpXlp0vTnU+6WTbDkkDy4j+XloIzTWf1V98G41pNpB4Ml1sjeGs8Fj3xReA7kuwv+Nu+JfNx3G0EDlYEhBmWI6eEatrljrqttjjEC1cx3gzayZJ8R/nz//gaarbU0J/Lm9sW4Q/azUWn6/PGrlFsB7Oe7/+tJ3IVbaZqSPtK2PEdkSUTxx12q/Dvk+JqLJjZMyw7J6yGFcDJc3ax1XcxZ1Q2kZdp5tdsWtfV6fcdvmcXY/aZJhtp9AIfBYTmSmXDKazocIpSKJ418mDET5a5ffPOrXeXuMFLKHve44qGvdGjC+FYoHK+LuAMziugUclmWuppyB5Xlw/vbN7ZvznXbbce63mJ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(10067099003)(261009220027099003)(261009223327099003)(261009221227099003)(261009221727099003)(261009223027099003)(38070700021)(921020)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?HxkUu0Vk8g+hrQkF0Znkt223Al4J9xG6rBIGrH3+Rq3K6BzmslBZEm2hV+?=
 =?iso-8859-1?Q?sJetWFmJoInd8kSC1hFkGbscqt6EAULCCEyyqNF3qZHTOdA8vqndN18A7x?=
 =?iso-8859-1?Q?CX2ANJql0wapkfk2KM9BpFWToKOpnJ3yl7x1fJZwS8i1uoYPC7xozA2pdN?=
 =?iso-8859-1?Q?YLJlTdhEchICfhOpVtfLhVmuPdpCoSuBb6Ns2rosL2FoNfsdfV2p5q0s7B?=
 =?iso-8859-1?Q?LaommIN/nfDnjSHZRH0nDVhkw4w36BYthO6+ZJFS+1bgdHI28SF+mDR6lG?=
 =?iso-8859-1?Q?7QZQd5u4AXcrxi4oyeraEG/cpBmj7XSijmeqLmNs7x4jwzEFsiUQ3rQLY7?=
 =?iso-8859-1?Q?M1zRe9tHn93g5D6oN3zpCqDQTKtli3rSrnPiOreINFhkZQ77WTwyLoFt1m?=
 =?iso-8859-1?Q?030syV9VgQJb9dsxgXeO+w76sxMG7fGx9okH1TNqjMTe/oCLY/uy305THD?=
 =?iso-8859-1?Q?AjZ5UlfOppWrLnyzKfo/X5zHekeJHYAQbE3cunDrr36xDCq5EfcmdjHakN?=
 =?iso-8859-1?Q?znqgitt45uoLms49ZDpyAF+UFwwB87O8hZ7qDO4Ne2WJT7aaHHTKh7HRkO?=
 =?iso-8859-1?Q?X8a4fZNFJVJ6hyrqKwDPoW8YiWSTWM+rtuFjLIM469moH4vhVO3V/K4wYK?=
 =?iso-8859-1?Q?Ov6JTu7GVmT6GxGIz9fou1qsFEig2cSnATgIkvBSVQrvzx9V/PPDn6J94y?=
 =?iso-8859-1?Q?m5QJhObEXx1YLT5da39tObV7rvhtqNc/pOgPFhHmOd7/Cews+jRkSlKe14?=
 =?iso-8859-1?Q?m5r7bFmkqlcMKCyxh5BBNEBttvaBUVoqdc4ql5RgLb0zFTMx2oif5Dcsuy?=
 =?iso-8859-1?Q?k2xq1AftPOnj5OuQ3ocJ0gjZxxUq65eCThSyeJyH+YzjS4X+bWLSivZNFv?=
 =?iso-8859-1?Q?FdQc6iA9zYc2eQA9ltl6cz/fvpSjD68z+vvbAO4Z6FHz+kTJ1294ATt+ux?=
 =?iso-8859-1?Q?y+MO0sVHQOemSlMLPRUjxrPdsk4QA97z0YQ8dRWb7q4HBG5mL+X7wtS/SU?=
 =?iso-8859-1?Q?vj4FMVuheKCZ9sIKZt2DG/+jNomtL4dC8iDW6YNoJ8lUF50yeOoPTzyUkP?=
 =?iso-8859-1?Q?mXxITlAlHyME1IIL+SnWlyfU0NK4Xr8qG6LNwOwWJs9lZSrMTOX19GSWYJ?=
 =?iso-8859-1?Q?I1k2yJzBJ+owwaF3QUcrE/W5OcwVKVtgp8LTAc3qBs++bDb9+dLS/28ke+?=
 =?iso-8859-1?Q?nQu+rWfy2Liroj18IzR5d+VqJewPPixdMuQi4MYKpZ3eVZYtJ1SqTxE2YS?=
 =?iso-8859-1?Q?DL0f1thpAdmhUctfzTQMAhkk581FtKZ7AmYndmq0/pzaAjFF5/yruJKt56?=
 =?iso-8859-1?Q?/bwfYxLjHhC6DIkGMxkPqeXeJ0KODdsLYHakvyDJV6ZUeOx8yX+H7OJ0sA?=
 =?iso-8859-1?Q?DTD1sRTDYvNqZ0UbbSUDJId0BJHk3swhxofwqQGO7uvZM10L8gF34+oeEK?=
 =?iso-8859-1?Q?KbFTUKNar/fGMQtBuQQSj/R7JV7UqlP/zJ4HWzeGv8tcF4B/VMjwpE0k2C?=
 =?iso-8859-1?Q?Jd9z2w0QYptu41ZxzjjYCIQR0Ck+VXsHLV7ZOtMoCkd10myrLE0gvrjkWP?=
 =?iso-8859-1?Q?o0tWqsUVRgLm81T8jURN56qQG85xsF52SXXa6xM96m3HI4kxECVBD4mz1H?=
 =?iso-8859-1?Q?OJpaBcwLzlxFrg83tKeO/P+MuKM/REOQFQubk8B2nwro6ds7rakXdbfV+q?=
 =?iso-8859-1?Q?BcP9G38ycH3s5I+Tm4/e9vjmG1UZs0MD6+XM0eFIJGR+DYRYyax10qovI3?=
 =?iso-8859-1?Q?uAlZMLlbpTzF8ARnizY14tSaZi0tMzl6UyPsfP6K4hHF6DDXLKUdhJCSis?=
 =?iso-8859-1?Q?KZ9uIjBWVA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PpkTxpXK+XIqbToh/bB8Mmii4Vr8zS+xzroK8oyyXAnaf1/s3g6KdHfmkE5DQA2gT5ezRipxFRIKnRQdw93nR+qW9avGa6KjPCSNzkcq5ieWfEjTtg/Qba/E1IDF8HSog5Q5A8Bv33cS76vU94z9+T1aFCeLe9FhaOnEZ2E31IYVMfmOJTFeo9fCZMf83oGP7FIwZ7vceQzDULGHtUD02ltfaLF1Ye8hgZLHi890vwOq1EIxfAa2nK1utSou1x6TsC5ZEEeefu+ZSBORcQO+UrW5YF69NyRX5uUX/oMFAd8dIiZkpIeNp1gXUgFVJIbsN199d18I96u6o69VWn53gA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bac63a9-9f01-486e-b3a5-08df282c53fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 06:44:56.2289 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: obKANugpCua9HSsTl5czfCLZVlw9c2AoJFVYw38pPzKSWRlbNcPL1UMU+Vx1J6pFSS/U8UQ8o7Yy7xejzBnv/CV8sQV7+y25qgki6bapPCw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR06MB7244
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

AST2700 SSP and TSP now use the unimp_devs table and=0A=
create_unimplemented_devices() for their unimplemented devices. Remove=0A=
the old "ipc", "pric" and "otp" fields in Aspeed27x0CoprocessorState=0A=
and the "timerctrl" field in AspeedCoprocessorState, which are not used=0A=
anymore.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
---=0A=
 include/hw/arm/aspeed_coprocessor.h | 4 ----=0A=
 1 file changed, 4 deletions(-)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_coprocessor.h b/include/hw/arm/aspeed_co=
processor.h=0A=
index 39209d2579..b0d72f9163 100644=0A=
--- a/include/hw/arm/aspeed_coprocessor.h=0A=
+++ b/include/hw/arm/aspeed_coprocessor.h=0A=
@@ -22,7 +22,6 @@ struct AspeedCoprocessorState {=0A=
     MemoryRegion uart_alias;=0A=
     Clock *sysclk;=0A=
 =0A=
-    AspeedTimerCtrlState timerctrl;=0A=
     SerialMM *uart;=0A=
     int uart_dev;=0A=
 };=0A=
@@ -44,9 +43,6 @@ struct AspeedCoprocessorClass {=0A=
 struct Aspeed27x0CoprocessorState {=0A=
     AspeedCoprocessorState parent;=0A=
     AspeedINTCState intc[2];=0A=
-    UnimplementedDeviceState ipc[2];=0A=
-    UnimplementedDeviceState pric[2];=0A=
-    UnimplementedDeviceState otp;=0A=
 =0A=
     ARMv7MState armv7m;=0A=
 =0A=
-- =0A=
2.53.0=0A=

