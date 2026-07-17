Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6815C44507
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 08:19:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkdm8-0006l7-W7; Fri, 17 Jul 2026 04:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wkdm5-0006kI-Lc; Fri, 17 Jul 2026 04:18:25 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wkdm1-0000Cy-VN; Fri, 17 Jul 2026 04:18:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vwq8Dyl06ALpE5A8cIeLtmgHuRs0Fzbl5WIil9WOyC+VvPSOZ+mAGws/xJc0BlPAQr7mvrfY+Lor/WXt/jE6ttJ+P1hXREmOXwoTBtxMyZwyRGs1L+2trxcV4VPDfP0EU6nJo5i450usnXKIPu2L7NKEDR3/wQQyGwKAWtqKIn0u+qgWKVgHywq5w+7r+UJqqrgFk8GFAhdFQCkn54W1tLvjpx+ZZN1pOuPhRSla67JbYAKiZwQyIRGLQPuFv1WQr11IhZKbR/sh/TpzZFLBhTk2+Nk77xc+YK67obNuuK7aZjtXW+aYEiBPHiwuhmwVPc0gs5QrjVUW3DngaJZHJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZRmDsJZP3abZrS3Ugsnulievg8dfK9CmKWVxJCIHU6c=;
 b=DP7c9nwtiXbIdl8bIDgRC75IwDN0glnPZS/qe+CeWfQu7QajqBKbzs+1bnc1fVC5V5LZstCdAV6VvQDMAMg+ojIgigY41QbqmQSRtXvEa8ARPgcY6+6qrGRYruLUHSTNyucCm8f7Qso5MhcEjJrSEXm0zpbYfbIzZhV5V3RHFMoiEOtNiLkYoi0aXpMNEHfIPm6vXnrcQ4TZKbEG4MK1jXwiVHXxLzgpJTI54GlFNg88tVlPS8zjiIujAMG+nSaiP/Wvhkow/bbLhZfgA5rrUlt0FeRV9JUt5tzh+SK/jDdm5k5Dslg5b5CuqnjtTo37cPmpZq2OYJsHADcgGIRr+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRmDsJZP3abZrS3Ugsnulievg8dfK9CmKWVxJCIHU6c=;
 b=ae1a7HBghgTbOSfA3rFGE6/+8FvwoozeB4TPQhnLgsvpUCallu9VtL5q+wprgv1mQMFcZjQTXLuXU7226ZWI1y007+TaWZT0khyQzSSgZibq2Ynqp8PwgJHSx9P5fbtzQQtzlYk6qMV6tCwpYWs8/JWr04mBfPttpRCRA8osJwUX98eeYbhHycI1IEorVNXRC+ukMb/+/pjk3xpZYaYn0XNbuzKoWpsxqAhf0TCEenp1TQV0vLe9H5IeXRCRQYCPa2/WDmkolK9BFz9DaD9vsXg11JzIRZdzl92XE5dri/1Jw8vNZMQSIGd8KEuuM41/oFymxW4PnUTYpagnbr1dpw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KU4PR06MB8339.apcprd06.prod.outlook.com (2603:1096:d10:7d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Fri, 17 Jul
 2026 08:18:14 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 08:18:13 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Fabiano Rosas <farosas@suse.de>, Laurent
 Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v3 0/9] Refactor AST2700 SCU preparation for coprocessors
Thread-Topic: [PATCH v3 0/9] Refactor AST2700 SCU preparation for coprocessors
Thread-Index: AQHdFcTQMWnZZjXLSketRIkrG3O49g==
Date: Fri, 17 Jul 2026 08:18:13 +0000
Message-ID: <20260717081813.3407862-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|KU4PR06MB8339:EE_
x-ms-office365-filtering-correlation-id: 46e8329a-c667-4d4c-be4d-08dee3dbf286
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|366016|1800799024|38070700021|921020|6133799003|56012099006|10067099003|18002099003;
x-microsoft-antispam-message-info: GBzsZBA42E0vlhHwpGbd7UJLBCqnK+4S7h02WfKUbTunzQQGSfkvi+adlL0EMcvhOj2HRkR/nJsegAfMk38wkNzY1q9Ne6h/jvXJvjl2p1eG4DVFsW7WXWtc9hjjZZclO81UA6cyyn0Hod6TxdmM6FvrbkUJRjcrAWbFG9QmMeqb02dG7XY7AXHbR6nS16GT62dd3lyN/20n5li6oDMfhLhHJ8NRsej7wunhLpUDfrgVSiKKLRFGb0BXzlQr2bJVIBYnAIlk5Qa5oarBHFTsUZygG735iIgZWMjl6B9ZRblYfbAmpWMpNg6wOC1T+t4RLjbmUtrhMhwLiDgds4XdhRkhHFcsYiPldrmXDN4os2w63/PgpIzustDQ0jfZJZZEZKgoXR846keNrPfZB40tnX0UZiN/2cBauHO7GlxDwxx8g20AJ0oIjf5QpDBZGqJQEU7ji1Bw/q+Utx6QTZh9jrzDb9e3ty/+mJ91j9tAk9Ow5fEuRV3MmJpD9zBMndx2Zlv+zK4UA6r5oLzzjztp40AXRFANqxecoxKX203c7Gdis16vK1L+ZhC9yfMLIHPqXNbH3oGNcaQDAVX5yQK3aSex+BFR8Ga9iqlSV75FnSrosqYAsNzYAYGXNuysve6MQnR0ExuaXhM71ojKgD8OyBB4uq3p02emZzkG3DQLEUkj5J7ruG/FgUmxc7V45wiOYps86eAOf5Ipu+1zvCczDwx1T1PJ8epJgX8t61cFs90hKY5xgO+cS15klPTcfoPd
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(38070700021)(921020)(6133799003)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?TimgEi4QfVHrb3m/d7jLSEvvo31kvB/BpeUAmCQMgGEcfEO//I4L2Yycfw?=
 =?iso-8859-1?Q?mcWsd12p2tMNkCsNvTGi3OjtFLagVmWMAi4AGWLcLwInS7lkVL6SvsnxCG?=
 =?iso-8859-1?Q?1JZ8cVjx2NK6WNp13nNunxaHYTfct6GOChhd4vsXWeS/rr4LFchZDS1xlJ?=
 =?iso-8859-1?Q?PxCGaZ+L/ujHFhgx9Gnz3PaxO2Z5DRSjL8zrLRPEn4lYec4jkzTO6fN23g?=
 =?iso-8859-1?Q?W2n5qafHWKgiuWfkKEvxvNKmhKxeU2eV8Bup9x4Imx61LxihO9ix1qJTGp?=
 =?iso-8859-1?Q?n8FkCSBD9cVPHM4Ul+qVuuDC9f79UjtxBVNBp7dG13HQEz5AW7gaMf9+qX?=
 =?iso-8859-1?Q?EJJG63kIpnVaC1yZk5jqLEhpxPVRINIqQhkPYkJJ9BczDDVVW2EZgi/Z98?=
 =?iso-8859-1?Q?/M4qyqY+wWQjmqMo44CuYlvkBTcUsMimuz7UbeYKhz2Xxk8QrOkwbEd+4q?=
 =?iso-8859-1?Q?a+PmOhekF2PgE2OkbQ2F4wK1fMvfdh8pIyXvwpF5uCnzcQdNfM0u1Rpkiz?=
 =?iso-8859-1?Q?Q6FKh76AcJs9w8OCjzRgfcKl+WvoKpZNCCFrHCc95MbnbuTE5cEq8xgUzl?=
 =?iso-8859-1?Q?qEFg5u+U8LKl4l+QjeBn9xm12Vp9b37PAgzPYgyQo1p9eQNz4kE3vSH+4w?=
 =?iso-8859-1?Q?Uzjm3A5O0gIwKe4Rse8ORtEd3PYWdw67XcQIK+2zWOfoVUuJXsACZMnkBd?=
 =?iso-8859-1?Q?avMgcTwu6x6JynqMu5Qvcwnf45cHgJS5HTUjD54JOtQ8/xAjugVEN9XGLJ?=
 =?iso-8859-1?Q?T9jV5QRifO6ikgiCFylMn4w7oJQ99VKwKa4hVbXjH6NXNMpAIFw/DxDLj3?=
 =?iso-8859-1?Q?7FWVnWOevtp5Fhhx3k7zTG81dmS/sV3fraqiZ/Oeej6i9X00Z550k9+EMD?=
 =?iso-8859-1?Q?4qqgupR9klvQQ6DNkTVwmUaPbA3dYdolGgnPIVKzj+6xSD3bRvB8pGKZV9?=
 =?iso-8859-1?Q?ARGfVk+K9dheuM038P1XBDLlHVUvTmyenEOFk6I70xVrQ4U5sPz+VeL1WQ?=
 =?iso-8859-1?Q?mEINOZQdsLsyybGWZRmFzykjl9h4zYOynES1+Pbvq8Sj0V7zKvlH64ucrk?=
 =?iso-8859-1?Q?4kybWeviCds60uX90urMYOyjNiwBc/tUvfsD4fJgKgWFAmxApL1kI9HIel?=
 =?iso-8859-1?Q?chp4fb4hhNySxEMfaKDn6ajVLMzoDizTR0i3FkIPWPqj99ulokc3GBmf7o?=
 =?iso-8859-1?Q?PzDW8vUBqwUzCjjhSRJllVPr/8fI+pNr8GZ6OXICVSQHFDzh5jhFAq6PTc?=
 =?iso-8859-1?Q?atksV6FgHti+CjgUCkgvVK6u3swHrfc/YPyXd0U91epO4EClnxJnZ5UlKs?=
 =?iso-8859-1?Q?uc/XIJWuxcFZofcQOqqrRM066M9wpKVf7BfTYqFErEwCnaMSIr/8w2CzqK?=
 =?iso-8859-1?Q?fjKdFbkEOykjn5aKE/zvPjdApo/4q39/lNTFRNFch9I7YcWdbrbiQRTZpZ?=
 =?iso-8859-1?Q?8heMDWNV67X2Ifeo48U0Iuyr7nj1l4GKyT4iA7yahkAyA3sgS4RJOiDxev?=
 =?iso-8859-1?Q?dHDM9f2peKoUAEObNkcCg3m0F0FZn0xw0MD9MaUf8kqaHHBhKWXg4w/lO4?=
 =?iso-8859-1?Q?i8yBxFvOuZlG5QhaAsxNpX0IgeEWa/kiyYNw3WbRDi5Ubo5OsgLCedVLwo?=
 =?iso-8859-1?Q?Xzql2fbwwwYmRrfxmwer/l5BQB4EjddgUGvUFA4WgvoeFtjdx+b9LZ0ZX6?=
 =?iso-8859-1?Q?VIwa6yEHI0IVXaoPT1BbqjK22wxsLFJYdJx2DwSMOUqzQoe4HRZ5HS2Rce?=
 =?iso-8859-1?Q?rz1uHCVUT7vSG1OB9ACGvaY2uQkETdOqpGcTskIi5NeITF1ySmrEh8sjvG?=
 =?iso-8859-1?Q?Drit4OuZMA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: F1elz/siT500kapp9fpO25nhtkMIrpl4IXfzLsChfSD23Psh3pxqvaHJsBVtkZaPA6LC92En/190FWANDknfqgArAXiIARdbZ66+WTZjxVJoP3W+Z6VRg0+JtaLniq2lweQZ2X0taDd0YK2EhfzTQUvbjfrjwGgfEbUGK3rkGcK1yCTPYM0lodmJWAjL0OTcER3/n50JvW6PD1n8S7MaX9zbRPKkVEmw2y+58EJceoNYZ3NA/a0Y3vZQnTJoTrmgyEOWjWoBDi0UeXf40KEdqFUs1008anYLRRdBM7SkZt/DAK3QkG9rsgLFEIzjp7lQnS8mpJd2x2hcJooJhRD4ig==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46e8329a-c667-4d4c-be4d-08dee3dbf286
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 08:18:13.9247 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GtpTFcf6cUlC9CD/oKRypgC6h8fxI+eTuzwWhXSbBS18KHLGvHlaWdbLtqaVK25g3OBSBX4KMZ1ppP4tqVvaQcSmNjQiNPMGGYjsjgJP0LA=
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

The original AST2700 FC support series [1] is fairly large, making it=0A=
difficult to review all changes together.=0A=
=0A=
To help speed up the review process, this series extracts the SCU/FMC-relat=
ed=0A=
refactoring into a standalone prerequisite series.=0A=
=0A=
This series depends on https://github.com/legoater/qemu.git at aspeed-next =
branch.=0A=
=0A=
v1:=0A=
Compared with the original series, the SCU preparation patch has been=0A=
split into three smaller patches:=0A=
=0A=
Introduce Aspeed2700SCUState.=0A=
Convert AST1700/AST27x0 users to the new SCU subclass.=0A=
Move the SCU link property into the AST27x0-specific coprocessor=0A=
implementation.=0A=
=0A=
In addition, the SCUIO reset handling has been separated into an=0A=
independent patch.=0A=
=0A=
This series contains no functional changes. It is purely a refactoring=0A=
to isolate AST2700-specific SCU support from the generic implementation=0A=
and prepare for the subsequent AST2700 FC support.=0A=
=0A=
v2:=0A=
 1. Pass realized PSP SoC to SSP/TSP initialization=0A=
 2. Share single SCUIO instance across PSP, SSP, and TSP=0A=
 3. Share FMC controller with SSP and TSP=0A=
 4. Add Data FIFO-based flash access support for=0A=
=0A=
v3:=0A=
  1. Add Data FIFO mode test=0A=
  2. Clarify SCU/SCUIO/FMC fields are shared with PSP SoC to AST2700=0A=
  3. Bump vmstate version after ASPEED_SMC_R_MAX increase=0A=
 =0A=
Supersedes the following patches from the original FC support series [1]:=
=0A=
=0A=
Patch 1:=0A=
https://patchwork.kernel.org/project/qemu-devel/patch/20260417032837.266412=
2-2-jamin_lin@aspeedtech.com/=0A=
=0A=
Patch 2:=0A=
https://patchwork.kernel.org/project/qemu-devel/patch/20260417032837.266412=
2-3-jamin_lin@aspeedtech.com/=0A=
=0A=
Patch 4:=0A=
https://patchwork.kernel.org/project/qemu-devel/patch/20260417032837.266412=
2-12-jamin_lin@aspeedtech.com/=0A=
=0A=
Patch 15:=0A=
https://patchwork.kernel.org/project/qemu-devel/patch/20260417032837.266412=
2-16-jamin_lin@aspeedtech.com/=0A=
=0A=
Patch 18:=0A=
https://patchwork.kernel.org/project/qemu-devel/patch/20260417032837.266412=
2-19-jamin_lin@aspeedtech.com/=0A=
=0A=
Patch =0A=
[1] Original AST2700 FC support series:=0A=
https://patchwork.kernel.org/project/qemu-devel/cover/20260417032837.266412=
2-1-jamin_lin@aspeedtech.com/=0A=
=0A=
Jamin Lin (9):=0A=
  hw/misc/aspeed_scu: Introduce Aspeed2700SCUState=0A=
  hw/arm/aspeed: Use Aspeed2700SCUState for AST2700 users=0A=
  hw/arm/aspeed_ast27x0: Move SCU link into AST27x0 coprocessors=0A=
  hw/misc/aspeed_scu: Add separate reset handler for AST2700 SCUIO=0A=
  hw/arm/aspeed_ast27x0: Pass realized PSP SoC to SSP/TSP initialization=0A=
  hw/arm/ast27x0: Share single SCUIO instance across PSP, SSP, and TSP=0A=
  hw/arm/ast27x0: Share FMC controller with SSP and TSP=0A=
  hw/ssi/aspeed_smc: Add Data FIFO-based flash access support for=0A=
    AST2700=0A=
  tests/qtest/ast2700-smc-test: Add Data FIFO mode test=0A=
=0A=
 include/hw/arm/aspeed_ast1700.h     |   2 +-=0A=
 include/hw/arm/aspeed_coprocessor.h |  16 +++-=0A=
 include/hw/arm/aspeed_soc.h         |   1 +=0A=
 include/hw/misc/aspeed_scu.h        |   5 ++=0A=
 include/hw/ssi/aspeed_smc.h         |   3 +-=0A=
 tests/qtest/aspeed-smc-utils.h      |   4 +=0A=
 hw/arm/aspeed_ast27x0-fc.c          |  38 ++++++---=0A=
 hw/arm/aspeed_ast27x0-ssp.c         |  56 ++++++++++---=0A=
 hw/arm/aspeed_ast27x0-tsp.c         |  56 ++++++++++---=0A=
 hw/arm/aspeed_ast27x0.c             |  16 ++--=0A=
 hw/arm/aspeed_coprocessor_common.c  |   2 -=0A=
 hw/misc/aspeed_scu.c                |  20 ++++-=0A=
 hw/ssi/aspeed_smc.c                 | 117 +++++++++++++++++++++++++---=0A=
 tests/qtest/aspeed-smc-utils.c      | 103 ++++++++++++++++++++++++=0A=
 tests/qtest/ast2700-smc-test.c      |   4 +=0A=
 15 files changed, 385 insertions(+), 58 deletions(-)=0A=
=0A=
-- =0A=
2.43.0=0A=

