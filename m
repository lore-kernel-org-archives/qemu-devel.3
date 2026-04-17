Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF1BF8E499
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 03:31:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDZtb-0002fX-4V; Thu, 16 Apr 2026 23:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDZtM-0002PE-FC; Thu, 16 Apr 2026 23:29:19 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDZtJ-0005q6-Sm; Thu, 16 Apr 2026 23:29:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JKD9Rt/nd8gdsFKG3YlXztapqjRXEoucfhg0s5L2QNF99S6rjqRJ+fEbUl8Je4/l68ap6ACn+VYMlLkOsBpS/d6JRurAz4WM8FwzqZQxWq7+mqGJhTGRC2Ey4+I53P5oYxZCtZgnpn4miK8Q8O7JHwpgCNnDrPMe2VdekTE9Nf815TaF2rjrRlZmAob2ScYIuPY+x+uJAX6i70SzWAhwTGzoenQXdTOOGVr8OafDhF1JuzaDbOF7KuqWd61L7y8T7986tqYMLd1ee4ogCQiI3GtARc+7W3bok/5WsvI7cqdLCbYUzVgrsqAmLS0pOrRRkuv2qYt51QLIB68VrXnZBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ofljzjUgu5mmvrOIu0a56F6ltFXnA24cJupnUdHz2c=;
 b=GCCmDtDhuEONPDduIMkAM4kdPZyh1a3IogMoSycGPeb1He6KUZjPEUUlCpn0GnMI5yAIoE9lYCW5ZEYhAn2ktdN5euP4nNRj0cOjEa+nX7hb+TlHnXIlhAkflKiW/KDIrHY4ElG8mQ4pHRNuwNqXGUs9xnnv2HJg2iNuuy5rQQL1T2XF11TVVjXr8tLNPkF17k8JQeJIckmbW0/YJADYOev/EhgWmmhrVAvbezdm0skFUzM3nMjlhudmeiksqBQDuhsWojVggrx5Mr4RuTwOqomo71jABPKo84V3YRpZQZbip3DAQrCM2V9tvMdKZ6YRXwduXblXUh8STcy4Aa075A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ofljzjUgu5mmvrOIu0a56F6ltFXnA24cJupnUdHz2c=;
 b=c/DWqeG4LrIzDBA2f9mBMeDhMy6DHdOUE3r0CfS+7EwqHgsAIY+Q96R4oHdWxsFZ0aRhmsPK65pArBO0ClGgFhh10gBIjz4pDtJHo2dzBn7b9SxL3+XkjlglBHGYOoNdr/sK/hNChpigeAZheTZEjnpGA3fuoGCMdbehzlFK8g+4lhQH/IXpU9iG7oy/mLYmWuK2KG50JouEPp7PvKFTLtBjmxBIXHOj1Wkh70ahjq7KSPSDHpoqvgpw0GOm9Q8FqyAX9zeaetEqWL2UNwfne+8QSEHCnkDLn02J5grUBlZMWW98dXxR8pI2edYrrztKHTsscfmu/OOyvEphCJ2NuQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB6299.apcprd06.prod.outlook.com (2603:1096:820:ce::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 03:28:58 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 03:28:58 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@linaro.org>, Alistair Francis
 <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>, "open list:Block layer
 core" <qemu-block@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v4 15/21] hw/ssi/aspeed_smc: Add Data FIFO-based flash access
 support for AST2700
Thread-Topic: [PATCH v4 15/21] hw/ssi/aspeed_smc: Add Data FIFO-based flash
 access support for AST2700
Thread-Index: AQHczhpTBYUs0FuRPkSzZ2Mp/GAT4Q==
Date: Fri, 17 Apr 2026 03:28:58 +0000
Message-ID: <20260417032837.2664122-16-jamin_lin@aspeedtech.com>
References: <20260417032837.2664122-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260417032837.2664122-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KL1PR06MB6299:EE_
x-ms-office365-filtering-correlation-id: 8a906809-a6b3-4a4c-75f8-08de9c31765a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|921020|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: u/HjIEYr+l97vZn01zzz+vU+GpWOmarprFnhmkTzSUeJoOCarjxO+MRoyEUlbj3izrPGp2eDq+gXa/ysKRSb75indXspxcZ69Spq2suTQonUoPXMURnHjGyuu4lPsLE1ljMyqDKEOhqwMTFkSMDtvJufar7hOZVb6hR8FEOKokfecm+TCmvDDHTXKC/k2UihHgWcJNw8ksvnO3ZDaKqHmUt4mShDiuiZEyQGQ+V6mnod4UNc6g/RmGS+mx3rJwzhuyNtNOEvxkAibHOoYA6uwxx7Ge7x9i226Mv+cllooPFx3t/g4nI9ft3SyKJ7lAaRNtELG17QW6/Li3vgvZb42+V1gSaUohshA3wbN8xb9nfj2YY/gL6ss2VX0bjH4QOTomLitVYn2rY6Zqq2tx9OVKqGfCkK9+ZKCDY53k6WcPnwrbSp38evvZOY1AJiqn9GZ9rqVTYBLn3z1hk/bdGojTVyaexoXBFdRMvmCgvYPoHKd2cis/WP6TovI2cEUhetG5cclfhhnGubZlXujbShdpZrP5nVcfWI8kggcFLT8pTH/d1V9zr4rsftwIB5NUomY4BYdQy9XLHu4zaK5uJFytjqdX5gTyixvI67GRM/+QPtrLDPnBZ/2kL2lp3FLbUES0wDQcnkWWbdBxLRjKrNdmuwmahve26PFsKSZF0NJJtHCMMNtGqTnEF4H8NzekDENFTFs9xUAmLTaI0W21muV+blnwFwZ3EAK+HqVYCJWnK4r2X4bwMBOLLeLQ3hs9ZtlHAD4RvFwljWDZeOyMMxg7YCOsDgrwpOcuxYtIbYAwp/57b7Snx+UCDTNJIOc2Wp
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4zawAbNs2g/uU6wrlmRZ8u8sCWCdipN/+9A3IDqKHNA2gpYmzwhpOIBaCv?=
 =?iso-8859-1?Q?FOfac+SOfEdar/mOtw7gDpDQcBaVsmRGBI02nalN7UEyW8Zq3qPM4oBBGB?=
 =?iso-8859-1?Q?LAXcsLeajMo0eQkzk4KtZI2g71hyqaEKyLdfsTTRenEzyJXCCyDPYVPgsf?=
 =?iso-8859-1?Q?mpUlO2fTioiNryb0tRzvXUPiU4x0wglP9HNC1/6sBcd++qvaOTzKoCx+TT?=
 =?iso-8859-1?Q?M+N73JI6UFG8F6FCPQlrpU5o1jkIBN7e0ecEIDuGRJpvo/6VR2bovA2Zip?=
 =?iso-8859-1?Q?oSOC7hVJuDkfnG+ezt5rwMyf6co4MZ63/fymIJutT1enmufa/2ccBPcV5V?=
 =?iso-8859-1?Q?oQDiNJ9suRqh3nGqck83gjSHBifSguRtRhT1FPPi6pGmH+Uthq6HsdTNsJ?=
 =?iso-8859-1?Q?ClLnBkCV3GsPn/YZWEGw74mlNR+klLTFX727eer8uVPSFrGEDj7mdFbm7V?=
 =?iso-8859-1?Q?R/4a1h5Oj7x585rMcMcyIoDSwH/ChrhZXOsjPKOULAi+kQ3hefM809zyMt?=
 =?iso-8859-1?Q?ccocwszGYBkRSpkUm2WdY0MTa1+qMxTQIIh3odGTv0NteTjJ3X712cxAeC?=
 =?iso-8859-1?Q?hKXH/wk0TGA8eL4qjBfWjcAI7TlyZ085poVNewpt3f+E1IkccbCyW+j+Em?=
 =?iso-8859-1?Q?FuSJlo/j03GzCNmbmS6B0zf7wAP5n6Tpbq95KKJXNYjlPQHfi99G5dGABS?=
 =?iso-8859-1?Q?vLaWHhvZpztcblUdrt4jC0JiyJPnVE6g7zOYo2OPBuLxfJAepEdAd8AxaR?=
 =?iso-8859-1?Q?AVPXjd7lP355Rt8LmvNwa/UAx5kDUdFOiotcGezzwmuOS0Q1YyZr1tT/zp?=
 =?iso-8859-1?Q?VDJa7GNUYo2ZO08o52TDZJLiZyenauCVIIdmdDmkI14TNTxICX2vzuyzvY?=
 =?iso-8859-1?Q?DnUW2iW0yfnsrCEs1TFtEw/FpWgbWYMZPE886/qvbXDsNybI3GdRFR3BX4?=
 =?iso-8859-1?Q?CCqCU2/g8uDFRuEQJt7bkZaAVhtZfIju9krPwX5dxD1CzIMnGNinphBo9c?=
 =?iso-8859-1?Q?jo/dVrVEsbeTmkYTSeNCdCWa4n1jIOqtZwuNZodr73W4lYC0SFhYRuUp6T?=
 =?iso-8859-1?Q?2MVtL1GANWOGmR2t/EcYh/n/JCggtwbht1gBLG1Pcb4i7qtKM06hgYdL1M?=
 =?iso-8859-1?Q?XV6ENwn260OBab+eDjwj4n8W4XezIE6htsyvDgEMRg4uKcyjm0m03rbS+B?=
 =?iso-8859-1?Q?/dcKQ98jA2+s+rsvqSW6ZM3KGumiU0MoUGSMXkfdDVrAXlUkxNIWb/KAvN?=
 =?iso-8859-1?Q?RR8coDPU8Q+e1gqgdjsvtsfKo7OvE5JeYww0fsPFBZp5tTtW/escXSv8e+?=
 =?iso-8859-1?Q?sewXq6yUC9bJZn6JYoCL2ANCW+qQq73GciWPzef+F/cRM8QhcUrjdkwCpD?=
 =?iso-8859-1?Q?1CpH9+3o6tz23MHvI0Sak4i2D1PVoPSlAgFb7hAFrd5wUFxqOd3IAgmtqr?=
 =?iso-8859-1?Q?wfaxOc6Cfe8a1gwpTN0SE5ydA+J9Mp++Kt8OH+OpvS9oipdUlbP4wXFtsy?=
 =?iso-8859-1?Q?xErs6NnqPcj9fdbJf1ETKpMOAKusGUpNDbUqQBIrEdlaHCN9o8SgkyszG1?=
 =?iso-8859-1?Q?6GhIyw8wFlaV+9n0mzoiKmrbAHd9+9M8GyXWgbpP1h5gFbuk/HSNndNRMK?=
 =?iso-8859-1?Q?v7f8W7mg/XFvzr49QncjriCqwbo0wOsZoBUxG97SX9it48jqTj9fUOufqV?=
 =?iso-8859-1?Q?qHpzRan3MFblB4fg72lICOlbRjLVKafRBpe47pfBlFiVHKsHytfXQEQ34L?=
 =?iso-8859-1?Q?mcNWHB8w36qowNmRwu/S5nBIsOM2BIeslJVGOjjJLnqgj5oPt+QqFza9nv?=
 =?iso-8859-1?Q?owWRc2Wzzw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: IaaQprGu9WfX4H809SQV2FyIw1qkNwp5fEsyU3lYWl6J6tYh5f2G/8oaj+hlH2FbcC2AkrHQ+Xw80hY1wpKp9BuzI6GBAk4PIrzMLm1X73qW/oG6K+RbJMXHfNYeKD++lFBSxomXRhPag3LzorVKA9LJRt1mw9m0hMQat6+Ln1fExfRZPbFrhicGfNWPNlpQiUiu9Z4s4yadOjYLMCr2kQ4tYZsCrho1K+d1bL2LqyTXmS7G8iUzk+VqvIeGx4L7eDubys8Kj+reDkO0/zZgpJDiSzAKtD2k5LSczzLnMNbLManC04f7Z88rQza61BvcfCK0aPpi1R3P32C/FOTDEw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a906809-a6b3-4a4c-75f8-08de9c31765a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 03:28:58.6066 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F5ZEjh1g1fgdJVG52C5nVcI8xAwjAV531cK/RKRHh1dMKSSNdSrXjk/20RXVkKCpGlZrdElnVUc4/75r2hmKryVN6l7cAHUSXP01cngIGKY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6299
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

AST2700 supports a Data FIFO mode where flash accesses can be performed=0A=
directly through Data FIFO MMIO offsets. The Data FIFO start offset=0A=
increments by one for every 16MB of flash address space, allowing the=0A=
chip select (CS) to be decoded from the Data FIFO offset.=0A=
=0A=
This change adds Data FIFO support to the Aspeed SMC model and introduces=
=0A=
a class callback to translate Data FIFO offsets into CS indices. For=0A=
AST2700, the Data FIFO offset is matched against the segment start address=
=0A=
of each CS to determine the target flash device.=0A=
=0A=
The SMC register region size (nregs) is also extended dynamically=0A=
based on the number of supported chip selects to cover all possible=0A=
Data FIFO regions.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/ssi/aspeed_smc.h |   3 +-=0A=
 hw/ssi/aspeed_smc.c         | 113 +++++++++++++++++++++++++++++++++---=0A=
 2 files changed, 107 insertions(+), 9 deletions(-)=0A=
=0A=
diff --git a/include/hw/ssi/aspeed_smc.h b/include/hw/ssi/aspeed_smc.h=0A=
index 76831422c6..640efade94 100644=0A=
--- a/include/hw/ssi/aspeed_smc.h=0A=
+++ b/include/hw/ssi/aspeed_smc.h=0A=
@@ -47,7 +47,7 @@ struct AspeedSMCFlash {=0A=
 #define TYPE_ASPEED_SMC "aspeed.smc"=0A=
 OBJECT_DECLARE_TYPE(AspeedSMCState, AspeedSMCClass, ASPEED_SMC)=0A=
 =0A=
-#define ASPEED_SMC_R_MAX        (0x100 / 4)=0A=
+#define ASPEED_SMC_R_MAX        (0x300 / 4)=0A=
 #define ASPEED_SMC_CS_MAX       5=0A=
 =0A=
 struct AspeedSMCState {=0A=
@@ -116,6 +116,7 @@ struct AspeedSMCClass {=0A=
                            AspeedSegments *seg);=0A=
     void (*dma_ctrl)(AspeedSMCState *s, uint32_t value);=0A=
     int (*addr_width)(const AspeedSMCState *s);=0A=
+    int (*data_fifo_offset_to_cs)(const AspeedSMCState *s, uint32_t offset=
);=0A=
     const MemoryRegionOps *reg_ops;=0A=
 };=0A=
 =0A=
diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c=0A=
index f0deeea996..186446c1ec 100644=0A=
--- a/hw/ssi/aspeed_smc.c=0A=
+++ b/hw/ssi/aspeed_smc.c=0A=
@@ -163,6 +163,9 @@=0A=
 /* Read Timing Compensation Register */=0A=
 #define R_TIMINGS         (0x94 / 4)=0A=
 =0A=
+/* Data fifo */=0A=
+#define R_DATA_FIFO       (0x200 / 4)=0A=
+=0A=
 /* SPI controller registers and bits (AST2400) */=0A=
 #define R_SPI_CONF        (0x00 / 4)=0A=
 #define   SPI_CONF_ENABLE_W0   0=0A=
@@ -212,6 +215,7 @@ static const AspeedSegments aspeed_2500_spi2_segments[]=
;=0A=
 #define ASPEED_SMC_FEATURE_DMA_GRANT 0x2=0A=
 #define ASPEED_SMC_FEATURE_WDT_CONTROL 0x4=0A=
 #define ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH 0x08=0A=
+#define ASPEED_SMC_FEATURE_DATA_FIFO 0x10=0A=
 =0A=
 static inline bool aspeed_smc_has_dma(const AspeedSMCClass *asc)=0A=
 {=0A=
@@ -228,6 +232,11 @@ static inline bool aspeed_smc_has_dma64(const AspeedSM=
CClass *asc)=0A=
     return !!(asc->features & ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH);=0A=
 }=0A=
 =0A=
+static inline bool aspeed_smc_has_data_fifo(const AspeedSMCClass *asc)=0A=
+{=0A=
+    return !!(asc->features & ASPEED_SMC_FEATURE_DATA_FIFO);=0A=
+}=0A=
+=0A=
 #define aspeed_smc_error(fmt, ...)                                      \=
=0A=
     qemu_log_mask(LOG_GUEST_ERROR, "%s: " fmt "\n", __func__, ## __VA_ARGS=
__)=0A=
 =0A=
@@ -764,6 +773,7 @@ static MemTxResult aspeed_smc_read(void *opaque, hwaddr=
 addr, uint64_t *data,=0A=
 {=0A=
     AspeedSMCState *s =3D ASPEED_SMC(opaque);=0A=
     AspeedSMCClass *asc =3D ASPEED_SMC_GET_CLASS(opaque);=0A=
+    int cs;=0A=
 =0A=
     addr >>=3D 2;=0A=
 =0A=
@@ -789,6 +799,18 @@ static MemTxResult aspeed_smc_read(void *opaque, hwadd=
r addr, uint64_t *data,=0A=
         trace_aspeed_smc_read(addr << 2, size, s->regs[addr]);=0A=
 =0A=
         *data =3D s->regs[addr];=0A=
+    } else if (aspeed_smc_has_data_fifo(asc) && addr >=3D R_DATA_FIFO) {=
=0A=
+        cs =3D asc->data_fifo_offset_to_cs(s, addr << 2);=0A=
+        if (cs >=3D 0) {=0A=
+            /*=0A=
+             * Data fifo mode only supports SPI user mode.=0A=
+             * The flash address is provided by the SPI command/address cy=
cles,=0A=
+             * the MMIO addr parameter is ignored.=0A=
+             */=0A=
+            return aspeed_smc_flash_read(&s->flashes[cs], 0, data, size, a=
ttrs);=0A=
+        }=0A=
+        aspeed_smc_error("Invalid data fifo offset %" HWADDR_PRIx, addr <<=
 2);=0A=
+        return MEMTX_ERROR;=0A=
     } else {=0A=
         qemu_log_mask(LOG_UNIMP, "%s: not implemented: 0x%" HWADDR_PRIx "\=
n",=0A=
                       __func__, addr);=0A=
@@ -1163,6 +1185,19 @@ static MemTxResult aspeed_smc_write(void *opaque, hw=
addr addr, uint64_t data,=0A=
     } else if (aspeed_smc_has_dma(asc) && aspeed_smc_has_dma64(asc) &&=0A=
                addr =3D=3D R_DMA_DRAM_ADDR_HIGH) {=0A=
         s->regs[addr] =3D DMA_DRAM_ADDR_HIGH(value);=0A=
+    } else if (aspeed_smc_has_data_fifo(asc) && addr >=3D R_DATA_FIFO) {=
=0A=
+        int cs =3D asc->data_fifo_offset_to_cs(s, addr << 2);=0A=
+        if (cs >=3D 0) {=0A=
+            /*=0A=
+             * Data fifo mode only supports SPI user mode.=0A=
+             * The flash address is provided by the SPI command/address cy=
cles,=0A=
+             * the MMIO addr parameter is ignored.=0A=
+             */=0A=
+            return aspeed_smc_flash_write(&s->flashes[cs], 0, data, size,=
=0A=
+                                          attrs);=0A=
+        }=0A=
+        aspeed_smc_error("Invalid data fifo offset %" HWADDR_PRIx, addr <<=
 2);=0A=
+        return MEMTX_ERROR;=0A=
     } else {=0A=
         qemu_log_mask(LOG_UNIMP, "%s: not implemented: 0x%" HWADDR_PRIx "\=
n",=0A=
                       __func__, addr);=0A=
@@ -1996,6 +2031,39 @@ static void aspeed_2700_smc_reg_to_segment(const Asp=
eedSMCState *s,=0A=
     }=0A=
 }=0A=
 =0A=
+/*=0A=
+ * Convert a data fifo offset to a chip select (CS).=0A=
+ *=0A=
+ * Data fifo access starts at 0x200. The data fifo offset index is=0A=
+ * calculated by subtracting the data fifo base offset from the MMIO addre=
ss.=0A=
+ *=0A=
+ * The data fifo offset index increments by 1 for every 16MB of flash addr=
ess=0A=
+ * space. Each offset step therefore represents a 16MB address decode rang=
e.=0A=
+ *=0A=
+ * The CS is determined by matching the data fifo offset index against the=
=0A=
+ * segment start address of each CS.=0A=
+ *=0A=
+ * Returns the CS index on success, or -1 if the offset is invalid.=0A=
+ */=0A=
+static int aspeed_2700_smc_data_fifo_offset_to_cs(const AspeedSMCState *s,=
=0A=
+                                                  uint32_t offset)=0A=
+{=0A=
+    AspeedSMCClass *asc =3D ASPEED_SMC_GET_CLASS(s);=0A=
+    uint32_t start_offset;=0A=
+    uint32_t fifo_offset;=0A=
+    int i;=0A=
+=0A=
+    for (i =3D 0; i < asc->cs_num_max; i++) {=0A=
+        start_offset =3D (s->regs[R_SEG_ADDR0 + i] & 0x0000ffff) << 16;=0A=
+        fifo_offset =3D start_offset / 0x1000000;=0A=
+        if (fifo_offset =3D=3D offset - (R_DATA_FIFO << 2)) {=0A=
+            return i;=0A=
+        }=0A=
+    }=0A=
+=0A=
+    return -1;=0A=
+}=0A=
+=0A=
 static const uint32_t aspeed_2700_fmc_resets[ASPEED_SMC_R_MAX] =3D {=0A=
     [R_CONF] =3D (CONF_FLASH_TYPE_SPI << CONF_FLASH_TYPE0 |=0A=
             CONF_FLASH_TYPE_SPI << CONF_FLASH_TYPE1),=0A=
@@ -2030,6 +2098,27 @@ static const AspeedSegments aspeed_2700_fmc_segments=
[] =3D {=0A=
     { 0x0, 0 }, /* disabled */=0A=
 };=0A=
 =0A=
+/*=0A=
+ * AST2700 supports data fifo mode with a base data fifo start offset of 0=
x200.=0A=
+ *=0A=
+ * The data fifo start offset increments by 1 for every 16MB of flash addr=
ess=0A=
+ * space. Each offset step therefore represents a 16MB address decode rang=
e.=0A=
+ *=0A=
+ * Assuming each chip select (CS) can use the maximum flash size of 256MB:=
=0A=
+ *   256MB / 16MB =3D 0x10 offset steps per CS.=0A=
+ *=0A=
+ * Data fifo start offset for CSn:=0A=
+ *   0x200 + (n * 0x10)=0A=
+ *=0A=
+ * Examples:=0A=
+ *   CS0: 0x200=0A=
+ *   CS1: 0x210=0A=
+ *   CS2: 0x220=0A=
+ *   CS3: 0x230=0A=
+ *=0A=
+ * asc->nregs should be set to: 0x200 + (asc->cs_num_max * 0x10)=0A=
+ * to cover all possible data fifo regions.=0A=
+ */=0A=
 static void aspeed_2700_fmc_class_init(ObjectClass *klass, const void *dat=
a)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
@@ -2049,14 +2138,16 @@ static void aspeed_2700_fmc_class_init(ObjectClass =
*klass, const void *data)=0A=
     asc->flash_window_base =3D 0x100000000;=0A=
     asc->flash_window_size =3D 1 * GiB;=0A=
     asc->features          =3D ASPEED_SMC_FEATURE_DMA |=0A=
-                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH;=0A=
+                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH |=0A=
+                             ASPEED_SMC_FEATURE_DATA_FIFO;=0A=
     asc->dma_flash_mask    =3D 0x2FFFFFFC;=0A=
     asc->dma_dram_mask     =3D 0xFFFFFFFC;=0A=
     asc->dma_start_length  =3D 1;=0A=
-    asc->nregs             =3D ASPEED_SMC_R_MAX;=0A=
+    asc->nregs             =3D 0x200 + (asc->cs_num_max * 0x10);=0A=
     asc->segment_to_reg    =3D aspeed_2700_smc_segment_to_reg;=0A=
     asc->reg_to_segment    =3D aspeed_2700_smc_reg_to_segment;=0A=
     asc->dma_ctrl          =3D aspeed_2600_smc_dma_ctrl;=0A=
+    asc->data_fifo_offset_to_cs =3D aspeed_2700_smc_data_fifo_offset_to_cs=
;=0A=
     asc->reg_ops           =3D &aspeed_2700_smc_flash_ops;=0A=
 }=0A=
 =0A=
@@ -2090,14 +2181,16 @@ static void aspeed_2700_spi0_class_init(ObjectClass=
 *klass, const void *data)=0A=
     asc->flash_window_base =3D 0x180000000;=0A=
     asc->flash_window_size =3D 1 * GiB;=0A=
     asc->features          =3D ASPEED_SMC_FEATURE_DMA |=0A=
-                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH;=0A=
+                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH |=0A=
+                             ASPEED_SMC_FEATURE_DATA_FIFO;=0A=
     asc->dma_flash_mask    =3D 0x2FFFFFFC;=0A=
     asc->dma_dram_mask     =3D 0xFFFFFFFC;=0A=
     asc->dma_start_length  =3D 1;=0A=
-    asc->nregs             =3D ASPEED_SMC_R_MAX;=0A=
+    asc->nregs             =3D 0x200 + (asc->cs_num_max * 0x10);=0A=
     asc->segment_to_reg    =3D aspeed_2700_smc_segment_to_reg;=0A=
     asc->reg_to_segment    =3D aspeed_2700_smc_reg_to_segment;=0A=
     asc->dma_ctrl          =3D aspeed_2600_smc_dma_ctrl;=0A=
+    asc->data_fifo_offset_to_cs =3D aspeed_2700_smc_data_fifo_offset_to_cs=
;=0A=
     asc->reg_ops           =3D &aspeed_2700_smc_flash_ops;=0A=
 }=0A=
 =0A=
@@ -2130,14 +2223,16 @@ static void aspeed_2700_spi1_class_init(ObjectClass=
 *klass, const void *data)=0A=
     asc->flash_window_base =3D 0x200000000;=0A=
     asc->flash_window_size =3D 1 * GiB;=0A=
     asc->features          =3D ASPEED_SMC_FEATURE_DMA |=0A=
-                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH;=0A=
+                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH |=0A=
+                             ASPEED_SMC_FEATURE_DATA_FIFO;=0A=
     asc->dma_flash_mask    =3D 0x2FFFFFFC;=0A=
     asc->dma_dram_mask     =3D 0xFFFFFFFC;=0A=
     asc->dma_start_length  =3D 1;=0A=
-    asc->nregs             =3D ASPEED_SMC_R_MAX;=0A=
+    asc->nregs             =3D 0x200 + (asc->cs_num_max * 0x10);=0A=
     asc->segment_to_reg    =3D aspeed_2700_smc_segment_to_reg;=0A=
     asc->reg_to_segment    =3D aspeed_2700_smc_reg_to_segment;=0A=
     asc->dma_ctrl          =3D aspeed_2600_smc_dma_ctrl;=0A=
+    asc->data_fifo_offset_to_cs =3D aspeed_2700_smc_data_fifo_offset_to_cs=
;=0A=
     asc->reg_ops           =3D &aspeed_2700_smc_flash_ops;=0A=
 }=0A=
 =0A=
@@ -2170,14 +2265,16 @@ static void aspeed_2700_spi2_class_init(ObjectClass=
 *klass, const void *data)=0A=
     asc->flash_window_base =3D 0x280000000;=0A=
     asc->flash_window_size =3D 1 * GiB;=0A=
     asc->features          =3D ASPEED_SMC_FEATURE_DMA |=0A=
-                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH;=0A=
+                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH |=0A=
+                             ASPEED_SMC_FEATURE_DATA_FIFO;=0A=
     asc->dma_flash_mask    =3D 0x0FFFFFFC;=0A=
     asc->dma_dram_mask     =3D 0xFFFFFFFC;=0A=
     asc->dma_start_length  =3D 1;=0A=
-    asc->nregs             =3D ASPEED_SMC_R_MAX;=0A=
+    asc->nregs             =3D 0x200 + (asc->cs_num_max * 0x10);=0A=
     asc->segment_to_reg    =3D aspeed_2700_smc_segment_to_reg;=0A=
     asc->reg_to_segment    =3D aspeed_2700_smc_reg_to_segment;=0A=
     asc->dma_ctrl          =3D aspeed_2600_smc_dma_ctrl;=0A=
+    asc->data_fifo_offset_to_cs =3D aspeed_2700_smc_data_fifo_offset_to_cs=
;=0A=
     asc->reg_ops           =3D &aspeed_2700_smc_flash_ops;=0A=
 }=0A=
 =0A=
-- =0A=
2.43.0=0A=

