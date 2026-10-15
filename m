Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B142CCC6B2F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 05:58:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHETU-0002iF-WB; Thu, 15 Oct 2026 01:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHESj-0001st-0L; Thu, 15 Oct 2026 01:57:09 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHESh-0003FL-Hb; Thu, 15 Oct 2026 01:57:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TMcp6lFSxFunkZbePOqiS74RLcKPbHVRNyqPUwUoqh0saM4vafHhJeLDCnFVRVuUtHqPXRvOcUxdGMNF/r48jph4BjZXCdq7NGP/mdEdA7PKWVgECXGf2SEvZreiseT2I3PQzYC3rso9YwTI46lAya0/cmsSG+Yl+7/fG892s7KDeTdOJBVFpvrVJqQeBRatwTS2SprS3Ed7rwDawXyAR2L469fVeutiybP7ax2bIwBEVVJ2zyWV350gS1ivBPgQXm3ZsDj7iHnyltcyGsRD5MjNuowFkhGDBDslNyR9n7+l2shgdqFpPsbAeuO6VC4YczkWU6kmvsDjkMtpVkNINw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B41g/1wNlV20mY3fJA5vhMhKDARN+l1o1DLzApyB/2Y=;
 b=GNJ+VTuENyMwhBfGsGhGcz/NMiso6OVG7nE3h5NBAt3zCrBbmnqwM6g80YF/T5s+So9cAazDG7bjKhKMWA3+QIa4/RKMrBD93IHXfX6FT4Gnt2jdNo7vlMPIOjpX21tXgXNZfBLLwhsztLo0qZZwc+gkc9y7eMWZnwR8UFClzWmaDcC6URtoCiAdFmiHIJb7uXIAlLZXMe0tBNyEUrQXJmCsP9Q2L7IHqwYgYQP8H2RG4YUQ4RC2liZnQZ++KJRbtxRdu1nBcTXc5DWktShxYhnOYFXRD3A7ofHQprLJO11Z6SfdnxDLHHUv761f6409CPZRUAtErBdPA2LrQby+4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B41g/1wNlV20mY3fJA5vhMhKDARN+l1o1DLzApyB/2Y=;
 b=XGTXYXklAd8H6h1vhC3tkceQ9ZGd8Gnv8dXPBbfrPcfa13NdbrywVFwsyX2j5rJMyH8tG42H7MwjsQh0IhVZaixW1eJMngNpccuVPxWaHoFlCuBoxZtFsE6j1oJXF3OUMBTxm8gNVr7S1RaZ26Qixsn3BO579KkcHx+3GvxgIOYEu+71TTSDFxL0SslLpZAIJonYrAa3Ntn7XSvwo7HggfXua2Er/IlFvDAVT3YNIG0hPYEG2keOMg5g/6To7J6PiCRkR2gPpPtFsiVFLA977xQXgjpYDdrgMPuimcortuuVXmiJMxXddh3Do9pP9YnmXHgr3we2HO+Dn3wUAr714Q==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SI2PR06MB5337.apcprd06.prod.outlook.com (2603:1096:4:1e9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 05:57:00 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 05:56:59 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 10/14] hw/arm/aspeed_ast1040: Add Anti-Tamper Controller
 (ATC) as an unimplemented device
Thread-Topic: [PATCH v1 10/14] hw/arm/aspeed_ast1040: Add Anti-Tamper
 Controller (ATC) as an unimplemented device
Thread-Index: AQHdXGn7N4Cu7ZQg7ESeqro8b5EsgA==
Date: Thu, 15 Oct 2026 05:56:54 +0000
Message-ID: <20261015055642.106204-11-jamin_lin@aspeedtech.com>
References: <20261015055642.106204-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261015055642.106204-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SI2PR06MB5337:EE_
x-ms-office365-filtering-correlation-id: ec3b6313-49db-47e1-1ee7-08df2a812076
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|7416014|366016|376014|261009223027099003|10067099003|261009221227099003|921020|38070700021|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: 6oNLvXgSq2dW91MYizbXLFGKd8+WJBH7r1T6fsuu16IB+WqFpDkea9XmnUkW644lFeCZ6J7Bqw4hLM43k7eoPFETg9YukVbBi7j8SW+mIJgF/Gkdam4WEPlbTgcXTAIkCWBKRNMbq2fGVgVGVTi4GFlyCe1Bm+RoLXbkiKkDduHbaLMGtLBmMNBNlSrs3LgPFbQcA0ou1rRRhqOUTFCzztgQAiCnVF0FVPNs4I6/rBjCa08NGQA8T0wq2jp+sLUvGAcDERez7SDICBskorc50QDde3rP2mdrU48uRG3r8+VKwaiB6b4/ophPByggOsD9ifpd8TC/14HWBLS18/RHzGkS+DizNpE50ixaYh360IhnsNKXUJT4a2r+0AJUDRtpuTo/38JAP9fIItIFkb304PCPIrAJioMgQDzLxCfnOGUH1MIm+lT1iw/9MH2zQ9aBIdAeGdzJWDlt41UD39/Wq+XqlPMAXlnHZ9xsWIqUrrGKJvBUrk+ZVNQXXQkZA9Bg+VooajMOFvv7pIXPdGaKbDkMYprKLmVcK897StWZbIZNZk0q+9BnhKZPnM/3vcyo1Pkp5+1AV/MJazgdlCDNP4+nCe5hXBecYP2ipKUiw01Af6GX+owC8oMy9DfJyBElAC2f4kYpbxNjGtSqIvur/pV+UlcUHz9W+AqIQ4gvKPfxPGMPift+hmPOc7rYJc05V1IwkxVVv2Pr9FKpGn8f8N/WAjzGejCI7hx62ziq00U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(7416014)(366016)(376014)(261009223027099003)(10067099003)(261009221227099003)(921020)(38070700021)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Z4Xsj9cs6SmMoxu+czs4lkvoj5a+egGNc8/Z89A4wFCTg1UtrHgyREK8M9?=
 =?iso-8859-1?Q?wOq4sc4vKtEm0XE0t+ItUuS23Dis7FtF1uuJP5rHGdw6TGuObgwIZh6AoW?=
 =?iso-8859-1?Q?6VfLtbAre7a0ku9spurXtMfofPqgnkHZVxwhcsHMwC/XpJzckF7JFaCp5e?=
 =?iso-8859-1?Q?3WxX4nX+GJthUe4fRyyOqA9N191AlsYbFbO37aKRYsL/YMv+fJ1mgg3Q4+?=
 =?iso-8859-1?Q?XSbTZaSryZUIo9nFFCCFNN1YjBIpmcBvCnNefBXdZfinKem1Xl6DbeJbFA?=
 =?iso-8859-1?Q?/dQvr2c13JLCcH1lmIGMKRSZPVuVN2VTIuZv45u7gd+7ysBE262iPI7hl4?=
 =?iso-8859-1?Q?xH9vuQxsyAV4gNgwBLOU0PkWi6qQe3ZbI6i8BZof/sEWEniEMpb74xddvm?=
 =?iso-8859-1?Q?Jl4oNITCWiHiUgwNPS9cxBgbZ+Da6FQDaeWkQlidUaRaz393ehhuTjPl/C?=
 =?iso-8859-1?Q?X6XDxl1xEUbVQDF96PB6dU9tJlA0SC6E31ksDPCkr+B18OTQm3GOvJdaTI?=
 =?iso-8859-1?Q?4KtqCub8UCFneBZFl1IExfeO/kTtJFFsXYJLrKyQ4VSIGJsBDMibT7s5BV?=
 =?iso-8859-1?Q?dl7CCe2pnsF3gW/X5uPrtQp4+qZa83mEGqT0bISNjuj9p2AwRosYU/xTrG?=
 =?iso-8859-1?Q?QDNQKdH+PHOPoo5WWKPDz8u3tJLNz1ls3X6EVe0QVUYvtf2LY8UwG0NGmX?=
 =?iso-8859-1?Q?z3/TkWZZOXHHTsLrrsfsAQvhOouj83TDKcimtfREi00MNZV1GQlWvpcIwZ?=
 =?iso-8859-1?Q?oGGWjnLazyxVEaITN4YkaD0nWGx+W0SeSFlWHrlNQXG8P4TQEkijxSwBeb?=
 =?iso-8859-1?Q?vi6Qdtj1vh+uNK2CemvNkxNAkispjAOIAXoCFGHaVA/gMQ0QPQ8f5WGvQb?=
 =?iso-8859-1?Q?vMUWu1ENXMtVDB0Uj5DWv1Yop7kksQqTqJiD1QvUPHZgjjc7AsRElLsbOL?=
 =?iso-8859-1?Q?BsoDmbTFbIEe91eJAQCivRau/TrkpJW5hP6Wo6qGx8Miaxk85QSPJ7YW0l?=
 =?iso-8859-1?Q?t433kFU2ScBygsRZtVsxVcUal+vYRwbxMgj/8D5ryOvgj1Kt1Eser+YJgw?=
 =?iso-8859-1?Q?czzo4mtHHVtAhdMSO3v5/GFCCsahdpx/aVKkTjGxYYWVZJrXzRwFp4MsNv?=
 =?iso-8859-1?Q?RjkXjcX0XRQ+W0POVAjNtlzz/MPuV55gu7XU63Fqjo9q2au/SpLm0+qUJy?=
 =?iso-8859-1?Q?o0Lazy5/mz2QwvCPE8LMnvrmw6IqP1DcP/eUxg+C1NMpNssnzEnw/I/18S?=
 =?iso-8859-1?Q?hiVAvSTR2U2JNxsYvLM7hQyJRnKSXplGAYvxBsquePy3j/9I/btBGGzu5a?=
 =?iso-8859-1?Q?trfp4E00b06Z5pMLj3ILILv3CZuGlkfZ0FjqjsW3PkBfEor7zmBdzJ9N+4?=
 =?iso-8859-1?Q?nNRDUWAVoEZoulOZ13nZ70cyQCN74eCk2PK8ufytL5WORJuhoG9zdrnkBY?=
 =?iso-8859-1?Q?aDWz1mo1LPOv2PsZ1/ctfx6/NoFRopwv5riqztCHKdgidz1YunT5j/zpi9?=
 =?iso-8859-1?Q?8IWqWQwqnt4Phtjd9z6w1AmGZ2JG4swJnV/nIeJ4lcbKE7bhbwJogmHXv5?=
 =?iso-8859-1?Q?6LMTd8ouyDlFhGGd0ahb/OWl8hkY84lvuQbg5TYOXXS//9VDkaQVE0j6bK?=
 =?iso-8859-1?Q?cCb5WLPi5V+uM5ExFHXXdChx1T10DrOty43Q5j2BSsY7n4RcpvecYIsUIZ?=
 =?iso-8859-1?Q?ChyMJ6/44jp5hGdRDKF/fg6IV938clV5T8+1Fp9rb0Muzq3RqClmAHm3yr?=
 =?iso-8859-1?Q?0Q7yzK6Qpgg5KJiDRU6FlF4yJU7grQ94gtDEuEZr6PSGCkeGvHBdOsz97F?=
 =?iso-8859-1?Q?fiLsmxTzhA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: eHNiu5G20DqQ/FLTJRx1dPtiJGG0CBzYFYladcXgyUMs/Nj3USiQx66RVnF3us430tV3FPXs/gCSKa4l8TubWoxULUIvHhOkARJNeo53wNMCC3qAx7sSszHdKtqkCznK+6lt4oaTzLw9PpNjhS0xJ6yVk/hrFRxVOcHSo0w5yuXS45zZ064C6v3+bmzL6Jd8GTjnAEVqwX/hO/UJM3SEIyujDQ40qG7K7DJwTpEAtAOeLIS2fm9sYXGdkrX9m041Au+fuAH0mZp+sIhnXxiyl+bFT9b6QfdrczfAaFJJ4ZN9oKC+6mK4l5y2EderXyRekQ7ZWvKN/nLJ0bss+/CUUg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec3b6313-49db-47e1-1ee7-08df2a812076
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 05:56:54.6433 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KpN3x4rtznUJ8na88RmPDe2TfDRAmzOQffvrJ621+PxB0EOu6yXxmY2EG0JvMs1AoGnqibSUHca7BVjH2i/MPwthfgtMstIuhHgv9C8boFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5337
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

The AST1040 provides an Anti-Tamper Controller (ATC) at 0x74c35000,=0A=
but the controller is not modeled yet.=0A=
=0A=
Add the ATC register region as an unimplemented device to reflect the=0A=
AST1040 memory map.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast1040.c | 1 +=0A=
 1 file changed, 1 insertion(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast1040.c b/hw/arm/aspeed_ast1040.c=0A=
index 48eda35ffe..88f7a2df2c 100644=0A=
--- a/hw/arm/aspeed_ast1040.c=0A=
+++ b/hw/arm/aspeed_ast1040.c=0A=
@@ -91,6 +91,7 @@ static const UnimplementedDeviceConfig aspeed_soc_ast1040=
_unimp_devs[] =3D {=0A=
     { "spi0-filter", "aspeed.spi0-filter", 0x74010400, 0x1000, -1000 },=0A=
     { "spi1-filter", "aspeed.spi1-filter", 0x74020400, 0x1000, -1000 },=0A=
     { "otp", "aspeed.otp", 0x74C07000, 0x800, -1000 },=0A=
+    { "atc", "aspeed.atc", 0x74C35000, 0x100, -1000 },=0A=
     { }=0A=
 };=0A=
 =0A=
-- =0A=
2.53.0=0A=

