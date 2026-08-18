Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B618C5DF70
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 09:24:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwG2M-0001nJ-Bq; Tue, 18 Aug 2026 05:23:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wwG2K-0001m9-Qg; Tue, 18 Aug 2026 05:23:12 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wwG2I-0001a1-Rx; Tue, 18 Aug 2026 05:23:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YkAaEXvks+4N9rxdD0q3sK4/HNgKbvlnZl3Fkwppk9zGgxamYaFBzm9YzglgafgQVBijYogR30XmPic9a9PSCNIQi8bgWzjEEoTXjpEdY0EI8dG4gvpyXJcajctq30KtDA4b8ENoklBUroOkphlGkXQeVuywS6+rL9WYxhW8v7eT40ytjFJjhzwjCrNv1EdiigC4Ktg7G2ke/Aamksn6lpMWCGLnfu7Ajh2LIQDkUF+msfAqlhmB6iIPKLlJNyY3wvIEcVEANOMaLU0JBDB7uNSo4JQzVo4yzM7quEsFuGcL5VP51COv0rjiRUzYt3QJS+XJ5V8S7790ii0QpVbW7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6j7KR7at4ZSuHZcip9Txyi/6b9EprFI3Ap+Zonp2jM=;
 b=ksb4GBAuM0g7UrzhEU3caIMrJWFjQYLdf8HHsvlDJsJABHaSo77L2Ep3zHfmU1JjAt9HIF9E85qTNtcRriAquLKrUsKrzsSNzpODSsmNSRYMxX0sMizN2igDLgAH17lsM7uiuKD65qJf5n4d07BpewSKJpVj9y9HmE3jjgU/BCeZpJLp19V2sLas652VlY1OnJoC+Nd+zjxmGe38DvMTVt/j8Np6OWIhhn+31J2AtC0Qjt8+rFwsCYBjC/mmDvcBYt1JZtg4/mJN2hi2ZV25JJw9AmpSyBn3PwH2M88q3t2eSg7gdZh6SrIVVJgJjhQ94L2+yrXB0T5T8QYF7SgUDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6j7KR7at4ZSuHZcip9Txyi/6b9EprFI3Ap+Zonp2jM=;
 b=FQkCTrhmC4+rZOONzN89spHqu9x+poTjLZrnkNOcpkTsoPSsPZH6axCBUC9PPsfI2Um6yiLDB/pMTgbBAnWh0bwKkwtRILawVmGdlFuqSN0a61fBiYdAz2mAjuMaifgJPIL7CtEZ/pd9CfPKeD7lHUukIkGGNSP9SFI9MWnJQN+cFRTloXUwmYr4OSK0R8Kvu6dfg/1UiK47atIjcY9CyCtPTL3SgIxx4+amLlMa6t9Q1ujrvbRBprk8FGztx3U9a05vlHor3z3WHebl1CyByhakGSvyOvwHVEJJIhK+6DH6o1yTbT6Etuc6RbigViuvTYs8cKHIr19n0eVCCDCw4A==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by PUZPR06MB5982.apcprd06.prod.outlook.com (2603:1096:301:112::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 09:23:00 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 09:23:00 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 5/8] hw/misc/aspeed_sbc: Support the ECDSA verify command
Thread-Topic: [PATCH v1 5/8] hw/misc/aspeed_sbc: Support the ECDSA verify
 command
Thread-Index: AQHdLvMpP0UtlcWcvUW1KH8tz518gA==
Date: Tue, 18 Aug 2026 09:22:59 +0000
Message-ID: <20260818092249.602137-6-jamin_lin@aspeedtech.com>
References: <20260818092249.602137-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260818092249.602137-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|PUZPR06MB5982:EE_
x-ms-office365-filtering-correlation-id: eb5a8c06-84ed-49ec-7239-08defd0a4bec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|22082099003|18002099003|56012099006|38070700021|6133799003|10067099003|921020;
x-microsoft-antispam-message-info: gyWzzP2zgJLah8+kUJiqQGwJON/Bmdcb/ZIJUKGQOPo8mNYtCs2ZuHwOPsbwzjrFeTbTeNT2PiKmEU6PnvVMVkDAZXfP2ugdZl1vGPL2UtM6JSuAzz3Y11Ok1hRPenJsfp7sxHBofUYUz2+QNAWaYeo6zzo9TTI99S8uF3TQ6xjSnj5pyQemkfOpkkbnGQ6b6bco5zMdPd8Ff7LQx537HIskjzAyD3/tjO6H+1wDapw3WBWe7YfcmO5ZPCCCv7TMcLJBwf0lo1zO+Qs5VYHW4WCm5m1HI0J1Q+4lIy2x0vFH+ZA5fk+YOruC5RDpkPvLSgRMbKsYDowCBreVtGByz4SnqjoL15FrH/FUZQdDxpkg4wURu2m6v2QTOD1F3d9r6flt1AJZ3uhmpcWaGQju1oMk09JF32lrqQpIFLsvRRvAXrCL8/eqFUF48Sm6roYPa7yqkEfQlVRixqAmoibmpgW+yFRorL4JLaMqLItO4GEhyGfNEsGVnaUE8HYPfTEt6WjaLpCj0u8XIGzkl/KTuakQARidB20VhwMvGEg+zw9g3o8+zhgYoVDmFMCngW0uzMYaFXFF6WAtd+JiIY8ja5OkEGgFpjp0aA3e+s9HkeG6fEUyPsu350PyUeKyAiFpmE8GhDecA6L2/6CaBQ5iYnzZohQE0r+2el42whhdYJK6d91trU/eWPIYo8YzRjE2T1U4m2nmMDrIer2d+43TLXNvcjwpiXlcC5uoLqcXXSNl6ZiAbHka3mWfuObNKKY8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(22082099003)(18002099003)(56012099006)(38070700021)(6133799003)(10067099003)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0PEWPlELgrM/q1oGkoasad9JRpx8O0Uv9lqL+8TyGKA8g4cEVbWZqfTFBD?=
 =?iso-8859-1?Q?jLHTVuPyQ8Gyxao83ZOwJU55Zj7SpnxecH6McvOVL1/9LtoMPjBG/sRPg5?=
 =?iso-8859-1?Q?f1xDsw46Lv9TjX9fW3ezICW1uBQ0pjqQR3HYXp3f/CJIYPIqLV3/13ZTkj?=
 =?iso-8859-1?Q?Pm+0fFi7NbhZtfTAhYuwAfnhXt4tpK/gY3EU7uENML6QbSmPwN8GcdiywJ?=
 =?iso-8859-1?Q?fhfQ7HcT7SNszsgX0QDV2F68UI9YJYCoYaWG7JWYVaFokeUOoBxVAzC2B9?=
 =?iso-8859-1?Q?FXQvsv66A7+yG/fNJcIRK23+wwxq7XUTHKZ5saNz37vXOC0QmFj8AnGxBS?=
 =?iso-8859-1?Q?vo5C7m9JQkf5H2EoT6umIV2D+DaFtzLUOM45OQ0jfzLYpIivs36BB9LAVw?=
 =?iso-8859-1?Q?k/SK0rHnEfarPf4c4RIL4x3BMi+erovLbsgEVe2cL9VXFGCUhrJaHerBqw?=
 =?iso-8859-1?Q?WjPJbFOxNM85PlRVTVi1hMB4BduDTtNecFK81ueGXrH1uLPueBL0UcJtO5?=
 =?iso-8859-1?Q?lv0Up58+U3bcMzilblF+/hEOpeWuxDaol9WWeTa0wEch29c/fRrMKrmdiM?=
 =?iso-8859-1?Q?OHx2PM0398IVqVxllnoEHfjdx+dg3ovD6hz0BzV0kpofur9WLKJdONemQn?=
 =?iso-8859-1?Q?oujuufvmt8R3b7MUot7E8Pcuk4jJfhlDBLdZFDmxYfJuHtAedGp2Ij7sUb?=
 =?iso-8859-1?Q?6FWoWPOpKDimOQN6jU/G4/OtBpQJvAQo1Y7D4Z41bso4jjnUzXldfzBKDe?=
 =?iso-8859-1?Q?yf9pwIxuO+mpi4zj/eatL7JPM2iWdwVdQCWL+hFeg24AnjLX4LDviSmvTs?=
 =?iso-8859-1?Q?s9VzWnJdY4VTgcn1dfLb7hBESt3OVLyoGiDjIzcQsC352VCaNgtbvBeibb?=
 =?iso-8859-1?Q?zc83vMcf5TWnc03cQvkouZz7kARaT8YuCPcHhpkBSYiYrVKkfWoMz88Gfq?=
 =?iso-8859-1?Q?16ySldI2d/qVeQD3cBNIzzkz6HFUVLdaHi93zmyrRtcJHLn7iow7Ru7dfo?=
 =?iso-8859-1?Q?/oTgz/Aa9iW/v1tblE91ZBMfgDb0Xdvz1pONk3zJkU5JiKjPEJT3/t7tnU?=
 =?iso-8859-1?Q?NQRPLZm3BTCWGjkABPzQulHOSbCkyitZiqVXgsDWEGTMcg3AcOJeCZG5CL?=
 =?iso-8859-1?Q?HJ5mVUCc2FFgE3LGbA9cliByFe4vo8P55H7B2b9qucKXfg/9kGQkCI7SiX?=
 =?iso-8859-1?Q?r5ZM17IqNBRHJMlTSJ9Qnuj9usAseMwY9enPBlTjFjuuv6Ik+rB5LrJvpN?=
 =?iso-8859-1?Q?5iAc6UBQnXH8MwlBCvwEwkVLXuEG8gKWZEyxreUABucw1qJBHD8JBQg1A6?=
 =?iso-8859-1?Q?yHIBickUSbBF/lCyagfJAQMSlH4PpsI3wFaq830aRZqh2hij0ZNFRooTMr?=
 =?iso-8859-1?Q?kltmN7/Im4ftCGOWouKOt92uNnOj4OD+9e+SBA2OsE4L3ANcCz1TyLdiHS?=
 =?iso-8859-1?Q?ZAk9lxZiXAUfqGG/DZwS6qEhjWvsPFkdpWksLTAc5al1otQHcgEDL/1q23?=
 =?iso-8859-1?Q?cqXDNLfex4DuIf/dYnm5yFpbm8qpPxWZPm5qz2XgyCAP9T7jZDVmGZsuas?=
 =?iso-8859-1?Q?MPfHwlorJGZD1iD7nPtpXmMEU7yZtRdnWcn6W7DFwmZ3Fwbeqti39HQkw9?=
 =?iso-8859-1?Q?/6qnQLSx58PcMMjjS20bdB16vAY//VWepGJW86P5PXCvoteW2UvdF4Ql6/?=
 =?iso-8859-1?Q?kbG4lcOuc9telZGYtDsgd2gCYAQ/ZPaUzXP7EP0vi1jd5HfAIw5U9q4KP7?=
 =?iso-8859-1?Q?/vS3CdvhlJbuxpr+Lxlo2HlrzSzSlz24Xbrr1Q9L01P2zmbQF8Gp/W7sir?=
 =?iso-8859-1?Q?YKasRqZfhQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: N0Gri3nO7tNnxYjwn5i3jWz72DGWQNpW8a7bI5k48iLcUifqn4PxQTOBiAf9PHOZiHFYXZH2/kUjXLjbRQgeAIpUI2nlsrxepgfwEt3xkaMx+4kvak0hi82eXbO6dUUVf4LXZILiO/keN00YPptz47qJasRf01hufY7i2KWu01e9NiYvpJQkJNufgmMeGdU7fB9F9Vo/oj5CVRDrOrBC3vb1U9xQXGJLI63EKKVmmCBjfhsT+/HmwB5i6+HVyE1NlvqBq031X0tGIDT62aOfRvMpkG4HotLYu9N6GS6whLfkWXGCXXUXdIa5zjw3/qMeR5DZ0HWactR1XQ9+aDXNcQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb5a8c06-84ed-49ec-7239-08defd0a4bec
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2026 09:22:59.8416 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mWfvAf/qUJlWR1UglA/2rdi5yZB6oM16vnLRPR9XTxqno8WX64XPmopDV7D7QAVr97t1YFqeVYW7P0wTmp/RUWOJnAN6lt7sMmBBpiJJKDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5982
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

The AST10x0 secure boot controller register block also hosts an ECDSA=0A=
engine. Emulate its secp384r1 "verify" command: on a trigger write to=0A=
the command register, read the public key, signature and SHA-384 digest=0A=
that the guest staged in the SEC SRAM and defer the verification to the=0A=
crypto akcipher backend, reporting the result through the status=0A=
register.=0A=
=0A=
The engine reads its operands from the SEC SRAM through a dedicated=0A=
address space over the SoC memory, using a 'sram' link and a 'sram-base'=0A=
property.=0A=
=0A=
The absolute address is sram_base + the SRAM-relative offset.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/misc/aspeed_sbc.c         | 154 +++++++++++++++++++++++++++++++++++=0A=
 hw/misc/trace-events         |   2 +=0A=
 include/hw/misc/aspeed_sbc.h |   5 ++=0A=
 3 files changed, 161 insertions(+)=0A=
=0A=
diff --git a/hw/misc/aspeed_sbc.c b/hw/misc/aspeed_sbc.c=0A=
index 1dfcf14e5b..724f4cb06c 100644=0A=
--- a/hw/misc/aspeed_sbc.c=0A=
+++ b/hw/misc/aspeed_sbc.c=0A=
@@ -10,11 +10,13 @@=0A=
 =0A=
 #include "qemu/osdep.h"=0A=
 #include "qemu/log.h"=0A=
+#include "qemu/cutils.h"=0A=
 #include "qemu/error-report.h"=0A=
 #include "hw/core/qdev-properties.h"=0A=
 #include "hw/misc/aspeed_sbc.h"=0A=
 #include "qapi/error.h"=0A=
 #include "migration/vmstate.h"=0A=
+#include "crypto/akcipher.h"=0A=
 #include "trace.h"=0A=
 =0A=
 #define R_PROT          (0x000 / 4)=0A=
@@ -24,8 +26,22 @@=0A=
 #define R_CAMP1         (0x020 / 4)=0A=
 #define R_CAMP2         (0x024 / 4)=0A=
 #define R_QSR           (0x040 / 4)=0A=
+#define R_ECDSA_CMD     (0x0bc / 4)=0A=
+=0A=
+/*=0A=
+ * SEC SRAM layout for a secp384r1 ECDSA verify operation. All operands ar=
e=0A=
+ * 48-byte big-endian integers.=0A=
+ */=0A=
+#define ECDSA_SRAM_QX   0x2080=0A=
+#define ECDSA_SRAM_QY   0x20c0=0A=
+#define ECDSA_SRAM_R    0x21c0=0A=
+#define ECDSA_SRAM_S    0x2200=0A=
+#define ECDSA_SRAM_M    0x2240=0A=
+#define ECDSA_P384_COORD_LEN    48=0A=
 =0A=
 /* R_STATUS */=0A=
+#define ECDSA_VERIFY_PASS       BIT(21)=0A=
+#define ECDSA_VERIFY_DONE       BIT(20)=0A=
 #define ABR_EN                  BIT(14) /* Mirrors SCU510[11] */=0A=
 #define ABR_IMAGE_SOURCE        BIT(13)=0A=
 #define SPI_ABR_IMAGE_SOURCE    BIT(12)=0A=
@@ -42,6 +58,9 @@=0A=
 #define OTP_MEM_IDLE            BIT(1)=0A=
 #define OTP_COMPARE_STATUS      BIT(0)=0A=
 =0A=
+/* R_ECDSA_CMD */=0A=
+#define ECDSA_CMD_TRIGGER BIT(1)=0A=
+=0A=
 /* QSR */=0A=
 #define QSR_RSA_MASK           (0x3 << 12)=0A=
 #define QSR_HASH_MASK          (0x3 << 10)=0A=
@@ -220,10 +239,121 @@ static void aspeed_sbc_handle_command(void *opaque, =
uint32_t cmd)=0A=
     s->regs[R_STATUS] |=3D (OTP_MEM_IDLE | OTP_IDLE);=0A=
 }=0A=
 =0A=
+static void sbc_ecdsa_hexdump(const char *desc, const char *buf, size_t si=
ze)=0A=
+{=0A=
+    g_autoptr(GString) str =3D g_string_sized_new(64);=0A=
+    size_t len;=0A=
+    size_t i;=0A=
+=0A=
+    for (i =3D 0; i < size; i +=3D len) {=0A=
+        len =3D MIN(16, size - i);=0A=
+        g_string_truncate(str, 0);=0A=
+        qemu_hexdump_line(str, buf + i, len, 1, 4);=0A=
+        trace_aspeed_sbc_ecdsa_hexdump(desc, i, str->str);=0A=
+    }=0A=
+}=0A=
+=0A=
+/*=0A=
+ * The hardware only supports ECDSA secp384r1 (NIST P-384).=0A=
+ * The guest has already staged the public key,=0A=
+ * signature and digest in the SEC SRAM; read them out and defer the actua=
l=0A=
+ * verification to the crypto backend.=0A=
+ *=0A=
+ * Returns true if the signature verifies. The caller is responsible for=
=0A=
+ * updating the status register.=0A=
+ */=0A=
+static bool aspeed_sbc_ecdsa_verify(AspeedSBCState *s)=0A=
+{=0A=
+    /* Only ECDSA secp384r1 is supported by this engine. */=0A=
+    QCryptoAkCipherOptions opts =3D {=0A=
+        .alg =3D QCRYPTO_AK_CIPHER_ALGO_ECDSA,=0A=
+        .u.ecdsa.curve_id =3D QCRYPTO_CURVE_ID_SECP384R1,=0A=
+    };=0A=
+    g_autoptr(QCryptoAkCipher) akcipher =3D NULL;=0A=
+    uint8_t pubkey[ECDSA_P384_COORD_LEN * 2];=0A=
+    uint8_t sig[ECDSA_P384_COORD_LEN * 2];=0A=
+    uint8_t dgst[ECDSA_P384_COORD_LEN];=0A=
+    Error *err =3D NULL;=0A=
+=0A=
+    if (!qcrypto_akcipher_supports(&opts)) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "%s: ECDSA secp384r1 is not supported by the crypto =
"=0A=
+                      "backend\n", __func__);=0A=
+        return false;=0A=
+    }=0A=
+=0A=
+    /*=0A=
+     * ECDSA_SRAM_* are SRAM-relative offsets, but sram_as is an AddressSp=
ace=0A=
+     * over the SoC memory, where the SEC SRAM is mapped at sram_base - so=
 the=0A=
+     * absolute address is sram_base + ECDSA_SRAM_*.=0A=
+     */=0A=
+    if (address_space_read(&s->sram_as, s->sram_base + ECDSA_SRAM_QX,=0A=
+                           MEMTXATTRS_UNSPECIFIED, pubkey,=0A=
+                           ECDSA_P384_COORD_LEN) !=3D MEMTX_OK) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "%s: failed to read ECDSA Qx from SEC SRAM\n", __fun=
c__);=0A=
+        return false;=0A=
+    }=0A=
+    if (address_space_read(&s->sram_as, s->sram_base + ECDSA_SRAM_QY,=0A=
+                           MEMTXATTRS_UNSPECIFIED,=0A=
+                           pubkey + ECDSA_P384_COORD_LEN,=0A=
+                           ECDSA_P384_COORD_LEN) !=3D MEMTX_OK) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "%s: failed to read ECDSA Qy from SEC SRAM\n", __fun=
c__);=0A=
+        return false;=0A=
+    }=0A=
+    if (address_space_read(&s->sram_as, s->sram_base + ECDSA_SRAM_R,=0A=
+                           MEMTXATTRS_UNSPECIFIED, sig,=0A=
+                           ECDSA_P384_COORD_LEN) !=3D MEMTX_OK) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "%s: failed to read ECDSA r from SEC SRAM\n", __func=
__);=0A=
+        return false;=0A=
+    }=0A=
+    if (address_space_read(&s->sram_as, s->sram_base + ECDSA_SRAM_S,=0A=
+                           MEMTXATTRS_UNSPECIFIED, sig + ECDSA_P384_COORD_=
LEN,=0A=
+                           ECDSA_P384_COORD_LEN) !=3D MEMTX_OK) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "%s: failed to read ECDSA s from SEC SRAM\n", __func=
__);=0A=
+        return false;=0A=
+    }=0A=
+    if (address_space_read(&s->sram_as, s->sram_base + ECDSA_SRAM_M,=0A=
+                           MEMTXATTRS_UNSPECIFIED, dgst,=0A=
+                           ECDSA_P384_COORD_LEN) !=3D MEMTX_OK) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "%s: failed to read ECDSA digest from SEC SRAM\n",=
=0A=
+                      __func__);=0A=
+        return false;=0A=
+    }=0A=
+=0A=
+    if (trace_event_get_state_backends(TRACE_ASPEED_SBC_ECDSA_HEXDUMP)) {=
=0A=
+        sbc_ecdsa_hexdump("pubkey", (char *)pubkey, sizeof(pubkey));=0A=
+        sbc_ecdsa_hexdump("signature", (char *)sig, sizeof(sig));=0A=
+        sbc_ecdsa_hexdump("digest", (char *)dgst, sizeof(dgst));=0A=
+    }=0A=
+=0A=
+    akcipher =3D qcrypto_akcipher_new(&opts, QCRYPTO_AK_CIPHER_KEY_TYPE_PU=
BLIC,=0A=
+                                    pubkey, sizeof(pubkey), &err);=0A=
+    if (!akcipher) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: %s\n", __func__,=0A=
+                      error_get_pretty(err));=0A=
+        error_free(err);=0A=
+        return false;=0A=
+    }=0A=
+=0A=
+    if (qcrypto_akcipher_verify(akcipher, sig, sizeof(sig),=0A=
+                                dgst, sizeof(dgst), &err) !=3D 0) {=0A=
+        error_free(err);=0A=
+        return false;=0A=
+    }=0A=
+=0A=
+    return true;=0A=
+}=0A=
+=0A=
 static void aspeed_sbc_write(void *opaque, hwaddr addr, uint64_t data,=0A=
                               unsigned int size)=0A=
 {=0A=
     AspeedSBCState *s =3D ASPEED_SBC(opaque);=0A=
+    AspeedSBCClass *sc =3D ASPEED_SBC_GET_CLASS(s);=0A=
 =0A=
     addr >>=3D 2;=0A=
 =0A=
@@ -244,6 +374,18 @@ static void aspeed_sbc_write(void *opaque, hwaddr addr=
, uint64_t data,=0A=
     case R_CMD:=0A=
         aspeed_sbc_handle_command(opaque, data);=0A=
         return;=0A=
+    case R_ECDSA_CMD:=0A=
+        if (sc->has_ecdsa && data =3D=3D ECDSA_CMD_TRIGGER) {=0A=
+            s->regs[R_STATUS] &=3D ~(ECDSA_VERIFY_DONE | ECDSA_VERIFY_PASS=
);=0A=
+            if (aspeed_sbc_ecdsa_verify(s)) {=0A=
+                s->regs[R_STATUS] |=3D ECDSA_VERIFY_PASS;=0A=
+            }=0A=
+            s->regs[R_STATUS] |=3D ECDSA_VERIFY_DONE;=0A=
+            trace_aspeed_sbc_ecdsa_verify(=0A=
+                (s->regs[R_STATUS] & ECDSA_VERIFY_PASS) ? "pass" : "fail")=
;=0A=
+        }=0A=
+        s->regs[addr] =3D data;=0A=
+        return;=0A=
     default:=0A=
         break;=0A=
     }=0A=
@@ -306,6 +448,14 @@ static void aspeed_sbc_realize(DeviceState *dev, Error=
 **errp)=0A=
         }=0A=
     }=0A=
 =0A=
+    if (sc->has_ecdsa) {=0A=
+        if (!s->sram) {=0A=
+            error_setg(errp, TYPE_ASPEED_SBC ": 'sram' link not set");=0A=
+            return;=0A=
+        }=0A=
+        address_space_init(&s->sram_as, s->sram, TYPE_ASPEED_SBC ".sram");=
=0A=
+    }=0A=
+=0A=
     memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_sbc_ops, s,=0A=
             TYPE_ASPEED_SBC, 0x1000);=0A=
 =0A=
@@ -325,6 +475,9 @@ static const VMStateDescription vmstate_aspeed_sbc =3D =
{=0A=
 static const Property aspeed_sbc_properties[] =3D {=0A=
     DEFINE_PROP_BOOL("emmc-abr", AspeedSBCState, emmc_abr, 0),=0A=
     DEFINE_PROP_UINT32("signing-settings", AspeedSBCState, signing_setting=
s, 0),=0A=
+    DEFINE_PROP_LINK("sram", AspeedSBCState, sram,=0A=
+                     TYPE_MEMORY_REGION, MemoryRegion *),=0A=
+    DEFINE_PROP_UINT64("sram-base", AspeedSBCState, sram_base, 0),=0A=
 };=0A=
 =0A=
 static void aspeed_sbc_class_init(ObjectClass *klass, const void *data)=0A=
@@ -355,6 +508,7 @@ static void aspeed_ast10x0_sbc_class_init(ObjectClass *=
klass, const void *data)=0A=
 =0A=
     dc->desc =3D "AST10X0 Secure Boot Controller";=0A=
     sc->has_otp =3D true;=0A=
+    sc->has_ecdsa =3D true;=0A=
 }=0A=
 =0A=
 static const TypeInfo aspeed_sbc_types[] =3D {=0A=
diff --git a/hw/misc/trace-events b/hw/misc/trace-events=0A=
index c9a868b3ef..1cd2ef8acc 100644=0A=
--- a/hw/misc/trace-events=0A=
+++ b/hw/misc/trace-events=0A=
@@ -95,6 +95,8 @@ aspeed_sbc_ignore_cmd(uint32_t cmd) "Ignoring command 0x%=
" PRIx32=0A=
 aspeed_sbc_handle_cmd(uint32_t cmd, uint32_t addr, bool ret) "Handling com=
mand 0x%" PRIx32 " for OTP addr 0x%" PRIx32 " Result: %d"=0A=
 aspeed_sbc_otp_read(uint32_t addr, uint32_t value) "OTP Memory read: addr =
0x%" PRIx32 " value 0x%" PRIx32=0A=
 aspeed_sbc_otp_prog(uint32_t addr, uint32_t value) "OTP Memory write: addr=
 0x%" PRIx32 " value 0x%" PRIx32=0A=
+aspeed_sbc_ecdsa_verify(const char *result) "ECDSA verify done: %s"=0A=
+aspeed_sbc_ecdsa_hexdump(const char *desc, uint32_t offset, const char *s)=
 "%s: 0x%08x: %s"=0A=
 =0A=
 # aspeed_scu.c=0A=
 aspeed_scu_write(uint64_t offset, unsigned size, uint32_t data) "To 0x%" P=
RIx64 " of size %u: 0x%" PRIx32=0A=
diff --git a/include/hw/misc/aspeed_sbc.h b/include/hw/misc/aspeed_sbc.h=0A=
index 07c7c22a86..9b04a10aed 100644=0A=
--- a/include/hw/misc/aspeed_sbc.h=0A=
+++ b/include/hw/misc/aspeed_sbc.h=0A=
@@ -40,12 +40,17 @@ struct AspeedSBCState {=0A=
     uint32_t regs[ASPEED_SBC_NR_REGS];=0A=
 =0A=
     AspeedOTPState otp;=0A=
+=0A=
+    MemoryRegion *sram;=0A=
+    AddressSpace sram_as;=0A=
+    uint64_t sram_base;=0A=
 };=0A=
 =0A=
 struct AspeedSBCClass {=0A=
     SysBusDeviceClass parent_class;=0A=
 =0A=
     bool has_otp;=0A=
+    bool has_ecdsa;=0A=
 };=0A=
 =0A=
 #endif /* ASPEED_SBC_H */=0A=
-- =0A=
2.53.0=0A=

