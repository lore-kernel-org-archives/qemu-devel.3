Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3471AC61DE4
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 02:46:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0s1G-0005XW-M8; Sun, 30 Aug 2026 22:45:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x0s1B-0005Vc-FJ; Sun, 30 Aug 2026 22:45:07 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x0s19-00028U-Dz; Sun, 30 Aug 2026 22:45:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rPFcKOdJmGUGSru8qlAnZylnzk+P/eSC7M9A5TjAzoQvZN+7hYk6ye//9ejpLDNoYBrRdeKeZVwhAHmD18PETlnsBInrGTk1kj53UTTKDDHAOHEx22T5WR5flWvafQpUCLJfLjgNwI325VtZj2DEIAypQG1TDpgHLlYd18oPsd7vYnQLWpDLjQptYTnzNfNQLEue/b3OJuwqvNpwbKePubu+IirJMpAhAe/Inp/9fFJEPTfMwf7FbTmRrFlEUp1DR+hkgdALDDGCt6DRUIWLJ7rDJSXc/JkoK12cfmwUrkgD8ap6CoBeiqZ/qJfP5C6AdGLHo8yewE2dNBhbpouLQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KeyJO1SRqD7fsBefK8FVchbTAtjz709ERA9x+fzkD1Q=;
 b=LCyvj5LssJxRrVepLwD7SAZupGPyKnHaroZ/kdNL4jsnmfYREDfirQkSA31s+Q0kZdHvk6nj8fpOT0OA6mRSi2xb3fyk4o96nrQP7xo4msvH7NlacJlik1whEZeGLgzUrJVG/dJIHxMESzrAHZhA74RmMB4itYdQRjxWIu3Ngb8QvCecYp+Bt5n5cc/+hfbljtEyWQGCoENv0Bm/qTGth1nKlmZUylDKopPSqbvZpLoAR6zSoYIakNDlHslgpYIa/hrYBtpHsNiC49pjwaF5ad0jlHp4YizlIhQtM3QNTgoIKdpIHI+5nkS5bj/ZRbmpCVs5E1owODTbYONkVb/1qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KeyJO1SRqD7fsBefK8FVchbTAtjz709ERA9x+fzkD1Q=;
 b=p2ADuVXddraUfZ91peNyD7eN3P0DtIQ7bL0TTlwrde6l7UMiAYm7PRpfePQLXEQErci/1QU6TRYpJgYFr4ctFjjg5Fat+VppnHHgMPLsmAyakSsI6TSg2VnwNdmmmKzrSfsMqfWm0px0hoa9LIdVMNAbZBayDJ99rDNH2Yik/89rAxadYOKg+b8/R/8PlEepLhU0wryGgyC5doHeJDyuC+44TWmWP0+ctBdBA6rr/xOVMqZWMp+9+V7Z96l5dLQTO3yVprXx1F+h+3Ads+I8JBAeIXqetDy/Yfn32blK7YW93mHdxMb07+YNpEVQxdHJkyEq2zZCtZRidSK+n8yZow==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KL1PR06MB6759.apcprd06.prod.outlook.com (2603:1096:820:101::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 02:44:56 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 02:44:56 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v3 3/4] hw/arm/aspeed_ast2600: Wire up the ACRY model
Thread-Topic: [PATCH v3 3/4] hw/arm/aspeed_ast2600: Wire up the ACRY model
Thread-Index: AQHdOPK1h03tKnWFQUqlDbxkGvxdQw==
Date: Mon, 31 Aug 2026 02:44:56 +0000
Message-ID: <20260831024450.27178-4-jamin_lin@aspeedtech.com>
References: <20260831024450.27178-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260831024450.27178-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|KL1PR06MB6759:EE_
x-ms-office365-filtering-correlation-id: 309adbe0-5ed9-445e-7bd8-08df0709d78b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|1800799024|366016|38070700021|921020|10067099003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: qpLGBgfXSIRvB9cihmUvqvo0q/Be0hedkL5m7uhUxSr6vf7cJo5K2Xu4KaF70d95UTVRLTPXiEIp3aPjlDwTlnrWhvyDDbIk8eGtKB35E/oMZBelsL5rc51Lv9of6EApDH1aAMSLdhyNpBvgvI4o1Tx7xRpAye1kH5pePGWuTUWJxHzFXNj2ifNRKMyQesBhOWzCNKL+uAl21SMM2CFX6XmaUWF+dJptnPT1vdot6U2krJ1Nelk3Jg2dOFV/mWd0ihQ6YdIIsnGZlCDAnW8+VPKcR+9LRMMfOUmT4sTLWtsL1J9O8HQ3CQYBw6YY3Zx0luhc5jBP2v3KVAPC5NUhBNUJPzLTu3E6L9QJ0DFdq0Tumoru3L7r4ze1rqUJyWBJ8Q6T1UFH0yvM16O6ec+YmI8PHYXt/MIOUUN2GJ1opxivjAdh2almZNHvlSlUzo0IzvR4GJdZbyTCuOESefAEbu4BDDwHF0NrEU5gO9dsu8hC06JxeoYR1w0hHB6SCSMKh+oXB/A8Ct852201iDgFvBnwHLctS9o5HvI0g587i1I4xhjIpF0I4jOVOx9rX+NvZI6f1/HELI8FVB2bKiOzRBg5OnMHmYdvFvdZXUERFdM4uK6II8vXodCFkbgljn/n+QR6o0qSyYLj/R4zjbNtK81jd4zrJzfIndF4Z6sCOTF6Jf2Z+JEdNryUqbjWYg+m/bGmfEFVwY340lHREhPq7x7ywbMEY3ZcnnGUgaYskX6hZZEowMQ2UVEg7ZpQbk0L
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(38070700021)(921020)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?YWEDo4zogZR1Wr8GMKXpUuXhPX6doT30kUwIl/FU9J4KqAElBxhL+pP5G8?=
 =?iso-8859-1?Q?vBP4FW5UPqXVwWdm8uI9fB21MASok5DINSp9MMTP+EFmwx41s+Y0b8qWFL?=
 =?iso-8859-1?Q?JRyHk8oP7S8gRdI0iydv1350ugdCNQC9YXjJQrdlVo1YFgQzgpeAKJPEzT?=
 =?iso-8859-1?Q?BAxhcyl8CdZMFZmrZznICPXmhM95WH42vb6DTZ+l2olxpqVxbKrJZCKKFC?=
 =?iso-8859-1?Q?sw74NyNtWO9LNhxSqycBMCZVFoadrUE+JY6Lnv/YvuOzdOxZW+KuFBRown?=
 =?iso-8859-1?Q?prRc5sGB25aPbns3wdslmuG2H81Ryn+fTAS7Ky9Ws5ikKjep8S2UsuDJsn?=
 =?iso-8859-1?Q?rYSCmPMG+dfyqY8oYiUhUdUSylPgRKHkYYtGYINUrZMzq3Pvt1rx5Z/a06?=
 =?iso-8859-1?Q?tGBQSPw5xVooLpoFguQnXtmdxFTrgN7f9x51f26md4cro9h/J6Tg+natAT?=
 =?iso-8859-1?Q?CEWeEs7qNLop43F7khRTSorT9JY8XowfOOt3nxZmAyFeg3NvSk0LVZ5jgr?=
 =?iso-8859-1?Q?3Q5vsp3x9LWK+4xvoAdI1EumEs35zb1LBbnUDwhxaQBzIfdTiyBLrMtdQN?=
 =?iso-8859-1?Q?taSzglpFyRXq92I+UI9OJRS1Usp+WLqqowzvP8TElQCrTi1hdMUv5XO2dW?=
 =?iso-8859-1?Q?jjCCaOXfro6OJLu/A1YQtXmepPzsdbtOUwVSxRcY9sFLmIGAzmifUyNkmn?=
 =?iso-8859-1?Q?3/GK1FpszKV2Dp6FE3VE1uUlDRYIcCYKNww5Imr//k559s1Y/Io7XHpWjP?=
 =?iso-8859-1?Q?wKdq/+chGZpUa0OWTETEw55WOTAa50O5cVeKBQdpITeK50E/TJg2eilWpF?=
 =?iso-8859-1?Q?lWkKwEUTsUNmD0/8L+cRO//YyQOknlWcHc63Nd92Q1hcBOvRag2jcLcrk4?=
 =?iso-8859-1?Q?Vk6fuP1WT/ZvZJNrZUdha8ng1hZyu0n40vDGnPHgqbiYIbMsCHE405p8rT?=
 =?iso-8859-1?Q?Nmd9Jld9xMGqyTaSjbGgNXQFJ75vrQopm6dyTLmJ3fPYejOmT8zZ5lM+Zc?=
 =?iso-8859-1?Q?R0mtoFwaaBgzrXRKUqn0o3/sfVJwtwlThPY6AgvHHhmSsWVmg8gOSBh6Gt?=
 =?iso-8859-1?Q?s2twxUP5vaOoZ2ONfwfbMHgrrREFtlcNQgDKCqzF5VBWhjKDKrQ2Pt3Cyz?=
 =?iso-8859-1?Q?pV7rbYQaYg4Tvm5czGbklxfPqblbmKGySGvQp2LzlutEqjRh5lh99j+HFr?=
 =?iso-8859-1?Q?OeV9qO9zR8hKegnF3QahWIaWTcMXGGqcqDiDiLwtzPkK/XkAWvzbWzo/8E?=
 =?iso-8859-1?Q?oR74VelJO6BorKdn85xIhIuX0g3//Yu3p0lGSqYmVeGtwuJpLvyK5H6wCA?=
 =?iso-8859-1?Q?SCaOmOklmKkYYTY5v0yrbh9jQO5VUUIFaX55hlKW2AmxfuD7l87vI2dqpK?=
 =?iso-8859-1?Q?FTI6D5kSXKbxMG3m+Cv6B/ZJfZGLjqJYXu6aV8dXZ9Gt/ZXZzs2IhOm50Z?=
 =?iso-8859-1?Q?e5bsk6ESlGJX34r6j79CpAnaizZjPHqJqo/qAP4IiZp1fFD1vyv+5qgd9a?=
 =?iso-8859-1?Q?BuVfSlWl9OpjFUTmhswTMU0OuizOxuixkmvi+DLYWFndEZM2TmbyXfFmDw?=
 =?iso-8859-1?Q?RBXejXtzAAl1z8Dq55ssMT13wDg2na9dWy96c3chFaEMhT3Mj6nbq7tYKy?=
 =?iso-8859-1?Q?tzrmsN18YP2jd306N496f9OojTn0nnzq82Fl6yaWCHbiH4GhJhDhkxrfYY?=
 =?iso-8859-1?Q?ucPVUUETtHYsh4jsheMrrV5n7vyYFmG1nAcrp/qet2evrjdeG7bHL/aDV+?=
 =?iso-8859-1?Q?QfE7+sdcqLB9hw0ap25r6naE9JU19PmoyQYT7hyq6xgltuDy9fWfeGXrv1?=
 =?iso-8859-1?Q?DTE+9T0/+A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: c0Y6Pnf97NvfzedyS7hYJ83ULLQYyM446RN+pMseS0fzuivrdatNqZVPfjydMPSH+Hs264ajbXPw4mZW13pww4Ba0Kc/r/DLDjz7WGvwp3S/jcWI/UR7LtjqJ3Fc7Kc+sUgm+bHx1fveYW3Prl3fN4La4xfGX2vi+Q18e0rkz3QKjEHjgPCGkpWq0/uQ0ugidCbL7giVNMuv7E/dJqc6JSxDRdB419zpw3en4dizhKccIAeIQaotfIvBOCrG9dGNjMG3L0RTMv8sG4yPAfEQg48kGQoTptvsHeq5jG9RnjobVXSc/+qsJ7Y/ghzxlmxk54k9H9Zw/n5PSoHywkCBsw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 309adbe0-5ed9-445e-7bd8-08df0709d78b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 02:44:56.2081 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TyDeJF91XHRt4lqNmm2ubgYV+7CsZaS1AAHxskBd7acgLy65LKrneX4kfWHDs5/34+DO5epTC9lRKFnbviv0qcNbZyPfGPOM32JZgVVDEMA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6759
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

Introduce the ASPEED_DEV_ACRY enum slot and add the ACRY model state=0A=
to AspeedSoCState.=0A=
=0A=
Instantiate the new ACRY model on the AST2600 SoC using its=0A=
real-silicon register address and IRQ:=0A=
=0A=
- ACRY register region 0x1e6fa000-0x1e6fafff=0A=
- IRQ 160=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@kaod.org>=0A=
---=0A=
 include/hw/arm/aspeed_soc.h |  3 +++=0A=
 hw/arm/aspeed_ast2600.c     | 17 +++++++++++++++++=0A=
 2 files changed, 20 insertions(+)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h=0A=
index 46e7854727..8d80f16705 100644=0A=
--- a/include/hw/arm/aspeed_soc.h=0A=
+++ b/include/hw/arm/aspeed_soc.h=0A=
@@ -25,6 +25,7 @@=0A=
 #include "hw/i2c/aspeed_i2c.h"=0A=
 #include "hw/i3c/aspeed_i3c.h"=0A=
 #include "hw/ssi/aspeed_smc.h"=0A=
+#include "hw/misc/aspeed_acry.h"=0A=
 #include "hw/misc/aspeed_hace.h"=0A=
 #include "hw/misc/aspeed_sbc.h"=0A=
 #include "hw/misc/aspeed_sli.h"=0A=
@@ -82,6 +83,7 @@ struct AspeedSoCState {=0A=
     AspeedSCUState scu;=0A=
     AspeedSCUState scuio;=0A=
     AspeedHACEState hace;=0A=
+    AspeedACRYState acry;=0A=
     AspeedXDMAState xdma;=0A=
     AspeedADCState adc;=0A=
     AspeedSMCState fmc;=0A=
@@ -271,6 +273,7 @@ enum {=0A=
     ASPEED_DEV_EMMC,=0A=
     ASPEED_DEV_KCS,=0A=
     ASPEED_DEV_HACE,=0A=
+    ASPEED_DEV_ACRY,=0A=
     ASPEED_DEV_DPMCU,=0A=
     ASPEED_DEV_DP,=0A=
     ASPEED_DEV_I3C,=0A=
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c=0A=
index f23a51c8a4..f7c7ec7fb1 100644=0A=
--- a/hw/arm/aspeed_ast2600.c=0A=
+++ b/hw/arm/aspeed_ast2600.c=0A=
@@ -52,6 +52,7 @@ static const hwaddr aspeed_soc_ast2600_memmap[] =3D {=0A=
     [ASPEED_DEV_DP]        =3D 0x1E6EB000,=0A=
     [ASPEED_DEV_PCIE_PHY1] =3D 0x1E6ED200,=0A=
     [ASPEED_DEV_SBC]       =3D 0x1E6F2000,=0A=
+    [ASPEED_DEV_ACRY]      =3D 0x1E6FA000,=0A=
     [ASPEED_DEV_EMMC_BC]   =3D 0x1E6f5000,=0A=
     [ASPEED_DEV_VIDEO]     =3D 0x1E700000,=0A=
     [ASPEED_DEV_SDHCI]     =3D 0x1E740000,=0A=
@@ -144,6 +145,7 @@ static const int aspeed_soc_ast2600_irqmap[] =3D {=0A=
     [ASPEED_DEV_FSI1]      =3D 100,=0A=
     [ASPEED_DEV_FSI2]      =3D 101,=0A=
     [ASPEED_DEV_I3C]       =3D 102,   /* 102 -> 107 */=0A=
+    [ASPEED_DEV_ACRY]      =3D 160,=0A=
 };=0A=
 =0A=
 static qemu_irq aspeed_soc_ast2600_get_irq(AspeedSoCState *s, int dev)=0A=
@@ -269,6 +271,8 @@ static void aspeed_soc_ast2600_init(Object *obj)=0A=
     snprintf(typename, sizeof(typename), "aspeed.hace-%s", socname);=0A=
     object_initialize_child(obj, "hace", &s->hace, typename);=0A=
 =0A=
+    object_initialize_child(obj, "acry", &s->acry, TYPE_ASPEED_ACRY);=0A=
+=0A=
     object_initialize_child(obj, "i3c", &s->i3c, TYPE_ASPEED_I3C);=0A=
 =0A=
     object_initialize_child(obj, "sbc", &s->sbc, TYPE_ASPEED_AST2600_SBC);=
=0A=
@@ -726,6 +730,19 @@ static void aspeed_soc_ast2600_realize(DeviceState *de=
v, Error **errp)=0A=
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->hace), 0,=0A=
                        aspeed_soc_ast2600_get_irq(s, ASPEED_DEV_HACE));=0A=
 =0A=
+    /* ACRY */=0A=
+    object_property_set_link(OBJECT(&s->acry), "dram", OBJECT(s->dram_mr),=
=0A=
+                             &error_abort);=0A=
+    object_property_set_link(OBJECT(&s->acry), "sram", OBJECT(&s->sram[1])=
,=0A=
+                             &error_abort);=0A=
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->acry), errp)) {=0A=
+        return;=0A=
+    }=0A=
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->acry), 0,=0A=
+                    sc->memmap[ASPEED_DEV_ACRY]);=0A=
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->acry), 0,=0A=
+                       aspeed_soc_ast2600_get_irq(s, ASPEED_DEV_ACRY));=0A=
+=0A=
     /* I3C */=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->i3c), errp)) {=0A=
         return;=0A=
-- =0A=
2.53.0=0A=

