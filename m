Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FEBDC624C6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 08:17:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Jez-0008Eo-OR; Tue, 01 Sep 2026 04:16:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x1Jex-0008E9-PK; Tue, 01 Sep 2026 04:15:59 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x1Jew-0001wa-3G; Tue, 01 Sep 2026 04:15:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LIHh5b1B24lON8MKNh/BbYG8dmwDPXSS0nMihtuoh+kPlDAYNHtSq0mZVxfVoYt0oiTRVNn0ohib9get1iHiQ2oYXmDqNXXJs35kVj1C0y9lqdKMA8zk17aqUdMAvIp0h1yJTqRhyNY6petNkF1tO1eAHDhlIgVSkTkYl5KZ+WCOGUxO283Py0ChmpcaCjAGuRpjPdV9t1Nnn5ib6P/h7X7l8KIcB85s9hP0b1epFQXXOaGO79Q7+jSNxG+G+X+mjT7RuZHoNE6OqkSX/3mx97vyF/hNZ1Ew3pUvwZmJq8a9v86s+qJe6QpmE/uMYGrL6YP1Anql5ez8EpaQTcowKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJ8JpveE/W4RsMCKA2IiFp3RPzIqYTRuosbyfDXAgrc=;
 b=eQQzDLdMz9doJzNWMMPEAVW14jFynhF2PHBNBUkU/tJZHLzwD/xgc3XaDy5FNWEEHnqEVWsCKwjfZKY7XZmvSNnaLsYSW6ZW6ty+I+/EWsGxwmgevcs+XjCyUvgsHgdxvCfjadaxzx+5AkKxGxuT9SvZF1Ggu5l1TuwwqdB5giVEPDyMBRLpFjXxtr5uhHSr8QbAeDOsCXmgPYfuo4jnHIBFn77q6MvDA3KqFo3M+TSG63N/CU4tJzIRMiz2KFXMU5OzPo/onAVwZm0bR7zGMagpNbTqzbkDSnAogMZsYMIBju+xlbl5YI0ZJpWzRKBZEvFD+NrWHqh5oUm76DJa8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJ8JpveE/W4RsMCKA2IiFp3RPzIqYTRuosbyfDXAgrc=;
 b=ASSACmcw6E0XJmtO36+09AFLir8fdY7uAWuvxvpPmKsjsL0UAcGJBFS6VFUfEraRsbAxjK0QjtRYCsrTKm5cDAZs7MhHGMzzFwrf9ZMW4Pf4AyoQyFVngltrkZBRSZ9pdlcTpVbZeOhGaZYTTKmvTvtvWWAg/OAATnk1LyzIBHdciHqRkXc67I7gfYde0fGC6LVE7DfIci1Gv4x9LvOiVlO8owaDUSmGRTXFEmgcrvnC3BFEvuMl0obdFWPU+aYiK7em/aM7l67bVeOYiZ2vuWRLYCbju/JSASLLFHLvmYMyAYZqXWkcQ+awFHyK1MdD3IMjY9IuOeK5cl1tCFAF3g==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TYUPR06MB6151.apcprd06.prod.outlook.com (2603:1096:400:350::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 08:15:36 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 08:15:36 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 3/4] hw/arm/aspeed_ast2600: Wire up the ACRY model
Thread-Topic: [PATCH v4 3/4] hw/arm/aspeed_ast2600: Wire up the ACRY model
Thread-Index: AQHdOeoRPaxgMr8Y2keMxoA1O4RIQw==
Date: Tue, 1 Sep 2026 08:15:36 +0000
Message-ID: <20260901081531.898176-4-jamin_lin@aspeedtech.com>
References: <20260901081531.898176-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260901081531.898176-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TYUPR06MB6151:EE_
x-ms-office365-filtering-correlation-id: b7d8ba0b-e0e1-47b5-9e29-08df080133b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|23010399003|10067099003|56012099006|921020|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info: xlSGCPlpSWEUO4Y0fOxU+a09yTi5byCRvrnisiqLBW+kY2Idvkzin5cbA6F/lW9cr2J4Zp0dKsX109AGaS7quNbrHbxHkm0jWeEOqGy4k3V9QAtsk4D/Vq4MaImmrEu3kurGjzEHaFSir5KXtUTCF/oxDnZn0bv2z2lLbMMpFQedRuwmJbcHInlqvamlJvQjjAvwRs+8GPqpmTKVg+hhFtKCXeRVXAkEQuJRkDE1t5+ojCiCQsE+23ToQPz17XDHJtFCrJoKx1BMLa4y5iZQAtRaXuC4MB57OM+IARiXNq/C9qyfIW5c3JU3ST3Kc7BLQBLRLLeclv0dzWGF9kd4AI/U6Qj52TVAZ0S+JirVExaaJwg54OEIQwCeHmlTxDO6saBkHve7bGRWVWy8IalRzqqFsLU/vKHP+mi8XxvFPf/Tgo8njB1ocYquXAIxbxFMVS6oTQ8uHzCfgkGzpo0IIq6oALsjW6E6h4N1qazv9fWQNtfzk+FXMi41G2P6ExVJ2ejAq6LxIJBlGYxylbncHvdlJ4ESfcvaLmfP2/MlLj4ydujHtrByBuMI5HFxVk7LyfSS1FE2Nf1QsZPw/+oz4xwKhEPsKv5YdSaxBK3v0Q9DoONpUJ4tDswcyb4W2FZWZD3H12zJAslEbaGdtGfOH37hkAixFZA0Nf7OEs9k7fzkv55oa6qkrIJB/e5WarwSldXEGEiyDQ7N17/GBP/x1mQp4oZ0cq6d5z8WqfInU3DpbPWBudC3FqrUQzBV8hjM
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(10067099003)(56012099006)(921020)(38070700021)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?XCmtb4ui8e0C8Vt+YC0mnVblI97fChG+hD6dpmj6hA4KxmyqMBYIvuWnKn?=
 =?iso-8859-1?Q?ydrOvi2hTytOsKmifRJd8HA28vxFFJTRTPUyxEywtAjWqGghkW73rElWq5?=
 =?iso-8859-1?Q?87upWQzv1VHvJckjUzyCtClGG3y/XM/q0qeq+nt5G1H1emuqTrtQsYJxh8?=
 =?iso-8859-1?Q?Ano0WO1bGlr+DaZBGmTaf9vUgD0DsT5+xCJuNZ2AlC1gknIVm4a3yOKHF5?=
 =?iso-8859-1?Q?KBYDj5BtnjVuvXcuYscFeakl148+XxlkZThS6FaoNBRqTAu6jcHbb9GD+M?=
 =?iso-8859-1?Q?w1F3JKGfzCJ+9eMcHbRa8UOZ3ihsSO8MXpZcKNqJ70qQR43dxLCuQWfwdO?=
 =?iso-8859-1?Q?cNkKywi+iJBX7MloYla4CUkwUTi0H8DG1/hxI9yT+vW7afSX3JhadMZHfA?=
 =?iso-8859-1?Q?17k7q6GurAZpaTxsvc6RSGy6wqw+zu6p6xkw5x8cGGyzYraGzxPj0JAxKO?=
 =?iso-8859-1?Q?NBs4SyBjG1PZpOx3KleZGD8bSiwaPNOlOBeGdXA3Ye3lU0J9QCPOJB693E?=
 =?iso-8859-1?Q?c9BQedAYwnphcV2+wpr9iPuyizKM/PmMHrRyhHcrRvWi6WZQHJ/O/49auK?=
 =?iso-8859-1?Q?JGrsPAunuej45dbwqC4Ucwom0aWbWs4MKNljCS9wh+KKWYJ57/vDefTv1V?=
 =?iso-8859-1?Q?+KgbyHHX0jv1aIVJM/j0W1wOeyScvev8ZHkmL/DwYgP5YE+N9dNBTihGoU?=
 =?iso-8859-1?Q?1bEjnEHW8tncuP3E3LWLof01JxxlgxQuq7bvGZwjLYBQ/9rQD4Qf/ecv7M?=
 =?iso-8859-1?Q?jdj+bBJC6wyQqYrvnD+3DzSRlX6dWfceEqZjYctCnn4u61zb5IS4MYqVsp?=
 =?iso-8859-1?Q?KFL1TFnjqXMYmIlfGm1CYL38Y90FEpgvkcOtXd7fPAwtP92bWWu5jgS2Uh?=
 =?iso-8859-1?Q?OM2HrD5hSPhCv7PkmhgS0kFujhCpRb2j7YpKFbpv8aKicrsZiLt+tCRVlT?=
 =?iso-8859-1?Q?lBJH/Z/qTF7ZUuVfUj4302QYauxvlHX4roSC/WlJg7BsK0CHYVFl0ICTzI?=
 =?iso-8859-1?Q?G9zsaW3ndpcEpiQ8H0iofLPuX76Kemk3SNCI3V6NFC2BJlvy4owoy7rmo3?=
 =?iso-8859-1?Q?vQFh/i3aoEA/9yNCVb/tw1Jbv1y45RQVsXeqM2SWl8hVS5DSdz4GImtq6J?=
 =?iso-8859-1?Q?S1PRUMvIxEUrQ6MQ1jga8CxBhgk0gWu0ey+f1C3fHnnNslphfgMfeJwq6B?=
 =?iso-8859-1?Q?oFw6yjphwtEvWuyjhR9u5GWHa1qdVkzAD87Bji1zxifsLWPLnqoxuEGOIh?=
 =?iso-8859-1?Q?jmDGgt6vHXQ18ByHgVwiQrM91a/TXSrtvkhpu1p1VqM+WPKZUZKbB8t+dJ?=
 =?iso-8859-1?Q?9SSjJe9STaO/SvbkFDDcbiiNh/68EboDX5+jFbffeTrzEBnvbNxe+vOZ5G?=
 =?iso-8859-1?Q?2n+KJRfehCZU3Uy5KeWEzCRk1kruMOSuw1Q4g9X5kxeqbKaCn4lSCMuD2i?=
 =?iso-8859-1?Q?5vzusGTJQBadaelU4YBY/wIOncwCtSxmH8Pp+UFXmRMfNGZVWWauuYI6+s?=
 =?iso-8859-1?Q?GJOuHAx2I/MYHWfs6EzOpyOIKrSbjcDSQY3+EyKMFASZOCUyMdJa5kgcUL?=
 =?iso-8859-1?Q?4Xt+evShG4WoKSXDJtUlanyGT+lM9700viJEoKJA92ErpK13h2NzWWw+OT?=
 =?iso-8859-1?Q?p5QuPo0gCw9uqfiRlwYOdlQGbWMCEWzM5ydVlXTUfrLY/ADrE9fRbbFmBa?=
 =?iso-8859-1?Q?aDR15MgRxHvYxcPkFJLUtCD0wDwjAlgUXEZqKYFrAKQnfopNJf6xxR/OY9?=
 =?iso-8859-1?Q?uQw0+gZQXphBcRciXAMV3z6h8wjRZLFvqUxJA/D9x+B8Kg2w8FNAP8alki?=
 =?iso-8859-1?Q?xIZTPKO5Kg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: hbJHazpbNVbUio6nbrWylvLo3dw9CVzr72R+PXJUnVlkhTvpsSUVMBDnJE7+S6aGyECizSp3K/UctmM5RcAIFw/pWxW6Fo2Vhum/6v1fkvw+4/9T6laOcHgyEXgRJtQcCzbg+sSZdIdVd42s684PTz+n1SMK3pE2if0vOK/WVsGpgGAY7eNxs0qTfIbOmsqXl5x8ZDclnM22oHAKMHBmgwCYnng1z2IvmD4zh7LtLYDf3WwyjxTFv1rjUhS3YyCLp1DIyCjuNkXUBEEdn3cgqr7Dc4WlUcAqmq/PuD+1OTZ5yl//cMlra8fdXBx4YaohjDxGjzFQPrBkgF012KImIg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7d8ba0b-e0e1-47b5-9e29-08df080133b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 08:15:36.1978 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ExVo9/DsINsZRfrR6SCvBsdggtL+n/uuy2jqzMefKEEsFEGWfp/peQ01AAQcYOH6c347FS0F1isg6xr3d1LkH7UwUrWK/LocYbYM6KALefQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6151
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
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
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

