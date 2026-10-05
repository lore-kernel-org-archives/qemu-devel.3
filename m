Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E39D3CA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 02:05:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDY4K-0001wO-CR; Sun, 04 Oct 2026 22:04:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xDY4I-0001w3-0V; Sun, 04 Oct 2026 22:04:42 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xDY4G-00016h-AA; Sun, 04 Oct 2026 22:04:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=otHJi/k+EW6dalBzx0GWHDsnHhVBBd3XjVuaLaOz9EBqE7RlQb9CTIr3BQYn9MMewPs5z6oEtVgrQi7vKoTLeBE0Hqo9IY+E31WM5k+GOQaLyXr4+EcMdZmRxxL4coCvPuEV0D3EEavoC7g2WV1bw0dAAi4xC7sxaAYI+TxO6y2BrxoqsS11/RMDGz1zEXjlsP4Pcas5P6pFsNIHZYcLJGehiNRjuxhc8lh4S3TPlsAURJKH0YMtAU3+tlVn4cgCimgFs3zI0ZSrJ9jIQp54ymSrTnEqQn2vya2ySHKy8dhCG6OqsReH5RYBb+I9LssqHxbZtDTQ1msXZzcM6fj79w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJ04cQ4gRWFfOfaaszlfoMk7vLcBDG9Zh7MyUATUhZU=;
 b=BnmZAdyT0d0UTGfU033TlyyQtssX0+rEk3Q9TP9jcGuRvV1LM5Wa3Kn1BC8BskkS+NGduKQMXjyDlZmQbkChDz0gZNSEXoGmTyFOvJhg6rQbLDw0BNho4bg6qtdfRI5FuIVspBNGkERt2WpgDCLbJPMiH8l9fHSE6ykORbznndFCZd/7dGMrW4jPvlNmtOhqHto6kYiFUBgXfHij8n5T2waKgWdfjlGnwSktwLtnchKfNELpdb7VhfO4VtwextZuR51psJlHTArhSzP19cD1QBuRhAKY2eCO2A+6jJqlOCsVkGsMiYDg5CcHGT2HbE7dWjkjFhgyO0uBO/0FcRCxJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJ04cQ4gRWFfOfaaszlfoMk7vLcBDG9Zh7MyUATUhZU=;
 b=j1NlHnNKnwAuAxsxVHeSRBZtbcJ2CFZ/HcvOE9pgbMBLh1raIm188fmZ4LgqR//tLxUMk6smZQ4vWBHCMAZE3cj+7ruorzdea7ppMwtd1xiSEoLt749Ef30xpZy+dgYrXHiXu+hHzzp4F4tQaDmPV8witlc2esc0nyun4X6++BElGdH+A6QzRIinH873v+1IEqQys9pHhDKnkI3WYGOhEyV+Wdxdai2oBSwzp+ktCTXqAlm/jXuNH4sx4AxCYF73KiVD7Zu66GKu/ox2geN9Y6accJyonDFhQBYdb9GKgrvRwg+BYsCi2Sal/ty9rY9x57YlX2x3uhnx444+IDJ9fw==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TY0PR06MB5833.apcprd06.prod.outlook.com (2603:1096:400:32d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Mon, 5 Oct
 2026 02:04:30 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 02:04:30 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v2 1/2] hw/arm/aspeed: Sort device IDs alphabetically
Thread-Topic: [PATCH v2 1/2] hw/arm/aspeed: Sort device IDs alphabetically
Thread-Index: AQHdVG3b6Zq/MRhWHEWGITqjeCkPUg==
Date: Mon, 5 Oct 2026 02:04:29 +0000
Message-ID: <20261005020428.3496039-2-jamin_lin@aspeedtech.com>
References: <20261005020428.3496039-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261005020428.3496039-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TY0PR06MB5833:EE_
x-ms-office365-filtering-correlation-id: 68cb8204-f31f-4626-c478-08df2284fdea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|22082099003|18002099003|38070700021|10067099003|56012099006;
x-microsoft-antispam-message-info: mkUO4gyMvdyk9uL0Wdn3UavNLlhIadMbR3FFtc5QXumknoXDPpMP5RZ2uhPPnuHBIvXRiFDnYC+CbGyTFGJQCO+Hktk4fwuthDDCEeqB+tUdxcTsY1tG7Bo/Fofm9iUy3CXJ3aW++rcn4E/vbloWDTkERXFMvmvGic1Rkd7T0aDsGH7tHZxKiDuYSI6XITBm1Vfkbei6wajr9DNdpbIaNCmZPDgDuBH04Mo+Xt32fZ12KdqtmdA/DHplrvsNlDDtqKjn7JMsc8fV/tbgXptuT23ltHMVVKkMAiNh93u2FDLOJy+hxJbeKiwCeYjWxYaChvUuQ5AIIOzXUT3TDdWJUDq99p68GOLd3qzxCdzblmV1BnnkDfsYmwYyL6C84w2bRcgAM3bIiMBrkgDF6ccwOZaiuN6thErOzctim5XcGkyuffHZiJhFqOblAhpAAbAhSt3pf5jueosrvKnJRN/ihuKlgG1KbsmfOVoRkz3p49pP91fLmLvBopLjtXL77Bplf8nTP+dHTgMoyDDDutG7UMA+YcrqwmfXke4vGOSnDaPRas0LvQB+ycdUbF6eEXas6i+qzHquBWUP47IZt3+ySTJ0o+GqvspoZYLCwNSrF6BzwHVaH/PqKHQ3OArtVqdeDrmnVNg9iZQWxdu4ET/rsx+O4IW9FRSi8H09Ab9qWj7MhsmWSjHWo9oXXbmENev4SQ5gQ18YtZ6siu4DPPzvXHsXEG/wGDMzSdhZ6dInWnU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(22082099003)(18002099003)(38070700021)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?CggdFrlhuuBcziYlpjHeySspbcyZkty15gUVt3+vvkQfmrTrpHp2ZEanFb?=
 =?iso-8859-1?Q?tLd5nNt6omiKAr7edB2czJmKOF2R6O2+MLjX1g7cQvwNaPuofMWM+jmEmu?=
 =?iso-8859-1?Q?BjBfzNiSjR1+mUPyjRsyzA8T8PsdkpxSfu8CSM65nNkcz/GTUcAMUljT48?=
 =?iso-8859-1?Q?14ld63l3yvvaffO1+xUwZ0p0MLPfIDKGXwyto6u6UUHx71AGryJrz7OOQa?=
 =?iso-8859-1?Q?POLjQuUuZsdwHi7vUvotlYEoz6qV/3mKi7MUT1kDeU2z9Vyr9qG3Jn4Kjn?=
 =?iso-8859-1?Q?ld+Xn5TeG4cUDn4pCx1dR2yfzyGmkgwg70URt5h9mR4bUnMPH8AqUAzb3C?=
 =?iso-8859-1?Q?QjHMQ10RnPVtI3y6Dm0ykO66kYGBu5QNtQ3K8cTNi+/2geV1GKeIhRkG+8?=
 =?iso-8859-1?Q?b55xq0qIKmNC7uLn4jAr0udYLOB5la5KOfe7jCoCHGqTHvVmWj3HitygEi?=
 =?iso-8859-1?Q?aEbvnb5u5gs6zy8Ya3tIAnp0yJ8premw9/cPpDPYrKMzUxgi0SjGqt/U4X?=
 =?iso-8859-1?Q?5sP6mxmNr4mIOiIQLb5xR334J9D7t5yK52CI6JrbpAu+Atc3WTDerDEgo/?=
 =?iso-8859-1?Q?8m9mFJ0OS2kmIUKQRRzjRyU+6FgFY2GPYx+x0BlrEH937pDsCK21o8iXIp?=
 =?iso-8859-1?Q?CWzWk2VdWMleIfMCCA4lXhznYNmkWEGUkz5pzge7ysiQyrrcMHudmKBOtj?=
 =?iso-8859-1?Q?S2o6gSlLgklfEHb03nupGOIt0SVt3iYVm1+YaNuQLo93BZ3qg8rNrMxWMK?=
 =?iso-8859-1?Q?/bXBh3MLsE2BnU3exZ329MCC1GPsReWNVFs1fUsaWb6jcqeRctThQMTbC+?=
 =?iso-8859-1?Q?1jeKIt1Ao2Qi9Vz5dSE8pRTk8VbZ+jImZESnfEY6KPRAYmeX6MX4TSwBXU?=
 =?iso-8859-1?Q?8NvgG96og+sfLnCwUkhYh3ujY4HCxOqmFCVrmR3C+ieTNlTj7U2STUCD2w?=
 =?iso-8859-1?Q?XhQ5P+loBZimwtObZP28lRz0xLntD84nMEVUsJPmU4Xo0qjKZqW6ANrSNL?=
 =?iso-8859-1?Q?5TR/Ew1joyLWrfLCtqAetTMTSFdhLHDRgfEU4ikHOu97DyPFk85LlDaZXZ?=
 =?iso-8859-1?Q?868ig5kBLuN54b+0GTa7JWTik6XOoMfEsz/uLnR21JhTFIwt3axyL5+8Oh?=
 =?iso-8859-1?Q?3zslocR46YM6K7y1M4hkOStbfTix5rZ2YXxtyjPVO89Y+TcI5dfMVTVDCS?=
 =?iso-8859-1?Q?mgORb5yIxIGriMznxVipSPHmqGkaaQtSCVvT6NxYH5bjdrjXYwAUhNEZGI?=
 =?iso-8859-1?Q?qAM8OYLhpRe32CKl+PloPvoS/QWuARBk2U6tFFjDOnFoGGdE5zzE83yq85?=
 =?iso-8859-1?Q?rYpHMDdCP1XmjW1sCutdyI2zQ1MrRJ7ZPIKl/EzOQ9eLkmiaaskwQkQSNk?=
 =?iso-8859-1?Q?+dNvrYAJ9ckRy6P6nlvcNZWOA5sNR2VLW/6Us1a4t3/Ciq/g1ESNljRbHD?=
 =?iso-8859-1?Q?YsAyHXnoWhmHn9RKO+V3PGqWJHOTltwbTGQ94AAH527Xpk1yAiMNOMCH3H?=
 =?iso-8859-1?Q?/40FezXrx9HMPcxvhjLYJjWE3fjUPMWPCryOxDFR6F/qU1twQCh/DOZZYc?=
 =?iso-8859-1?Q?AnSacCrKUPhZ4OjulmNT1eg+7zsOW3T6Bh5+J+wPN1nBWlbKL7kHHeqIYB?=
 =?iso-8859-1?Q?6uCtmlt6TQ9Cnb54byDTrhSYP0aetflTbvs+M0J5XrOhHGdM86rSIrxI/e?=
 =?iso-8859-1?Q?01UHl0kuoAa7uQmSV2ficWsOjfk2U78Divpn38Oe1Fj7W8hZcNb17NXYb0?=
 =?iso-8859-1?Q?5tpdIilGpNPOoU/M/h1oZTWEZAfc0HLeYZvzyIRxrFwjBo1KgpHqb0UxAp?=
 =?iso-8859-1?Q?1Lxd3yQgig=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 3My8ObdOZtvb4F8j4AuwuCPTB6k3t8fJw58NBwvgEYnRcrqR9Z/zSzEagPvfk+LFQpLkpyTA1fzZpoy80l7jy87tzCxrCst2es2NTYY28RyTOUg5//rYJv82sY81fklfhmO6H5T7kMGDr75NNcC95bPxjbrQEUUD3ZmFBGvfe7sbHz5W2zTB/dIdR0WOY7sdXSkHiyA99LUhAdaWLS3LhWI9iEEhn64xmUbRaO6cc/8IMx7PLVdXEBVuqRtQ6XdAYztwUO0J8bLSYe8lhg9sjdaTEJjfEKXgQWktxzhwLYJSHMpICMUsEGqruBxGntFVULhLOmkGvNa7DfUslOU5Iw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68cb8204-f31f-4626-c478-08df2284fdea
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 02:04:30.0482 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Y+REnRD6ziyGylOrgxGrI8gVbeajxUoFcZltDMvM+P4gqlGn3C3Fv+K9wBwSWVHu66OMZDt51CKdddic+DeBlbqTZ+H/vkscanw5UIup/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5833
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UPPERCASE_75_100=0.001 autolearn=no autolearn_force=no
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

The ASPEED device ID enum has grown over time without a consistent=0A=
ordering rule. This makes it difficult to determine where new device=0A=
IDs should be added and reduces readability and maintainability as=0A=
more devices are introduced.=0A=
=0A=
Sort the device IDs alphabetically to provide a consistent ordering=0A=
rule. Keep related numbered devices together, such as SPI0, SPI1 and=0A=
SPI2.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
---=0A=
 include/hw/arm/aspeed_soc.h | 176 ++++++++++++++++++------------------=0A=
 1 file changed, 88 insertions(+), 88 deletions(-)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h=0A=
index 38226d9b80..a110385743 100644=0A=
--- a/include/hw/arm/aspeed_soc.h=0A=
+++ b/include/hw/arm/aspeed_soc.h=0A=
@@ -195,64 +195,56 @@ struct AspeedSoCClass {=0A=
 };=0A=
 =0A=
 enum {=0A=
-    ASPEED_DEV_VBOOTROM,=0A=
-    ASPEED_DEV_SPI_BOOT,=0A=
-    ASPEED_DEV_IOMEM,=0A=
-    ASPEED_DEV_IOMEM0,=0A=
-    ASPEED_DEV_IOMEM1,=0A=
-    ASPEED_DEV_UART0,=0A=
-    ASPEED_DEV_UART1,=0A=
-    ASPEED_DEV_UART2,=0A=
-    ASPEED_DEV_UART3,=0A=
-    ASPEED_DEV_UART4,=0A=
-    ASPEED_DEV_UART5,=0A=
-    ASPEED_DEV_UART6,=0A=
-    ASPEED_DEV_UART7,=0A=
-    ASPEED_DEV_UART8,=0A=
-    ASPEED_DEV_UART9,=0A=
-    ASPEED_DEV_UART10,=0A=
-    ASPEED_DEV_UART11,=0A=
-    ASPEED_DEV_UART12,=0A=
-    ASPEED_DEV_UART13,=0A=
-    ASPEED_DEV_VUART,=0A=
-    ASPEED_DEV_FMC,=0A=
-    ASPEED_DEV_SPI0,=0A=
-    ASPEED_DEV_SPI1,=0A=
-    ASPEED_DEV_SPI2,=0A=
+    ASPEED_DEV_ACRY,=0A=
+    ASPEED_DEV_ADC,=0A=
+    ASPEED_DEV_DP,=0A=
+    ASPEED_DEV_DPMCU,=0A=
     ASPEED_DEV_EHCI1,=0A=
     ASPEED_DEV_EHCI2,=0A=
     ASPEED_DEV_EHCI3,=0A=
     ASPEED_DEV_EHCI4,=0A=
-    ASPEED_DEV_VIC,=0A=
-    ASPEED_DEV_INTC,=0A=
-    ASPEED_DEV_INTCIO,=0A=
-    ASPEED_DEV_SDMC,=0A=
-    ASPEED_DEV_SCU,=0A=
-    ASPEED_DEV_ADC,=0A=
-    ASPEED_DEV_SBC,=0A=
+    ASPEED_DEV_EMMC,=0A=
     ASPEED_DEV_EMMC_BC,=0A=
-    ASPEED_DEV_VIDEO,=0A=
-    ASPEED_DEV_SRAM0,=0A=
-    ASPEED_DEV_SRAM1,=0A=
-    ASPEED_DEV_SDHCI,=0A=
+    ASPEED_DEV_ESPI,=0A=
+    ASPEED_DEV_ETH1,=0A=
+    ASPEED_DEV_ETH2,=0A=
+    ASPEED_DEV_ETH3,=0A=
+    ASPEED_DEV_ETH4,=0A=
+    ASPEED_DEV_FMC,=0A=
+    ASPEED_DEV_FSI1,=0A=
+    ASPEED_DEV_FSI2,=0A=
     ASPEED_DEV_GPIO,=0A=
     ASPEED_DEV_GPIO_1_8V,=0A=
-    ASPEED_DEV_SGPIOM0,=0A=
-    ASPEED_DEV_SGPIOM1,=0A=
-    ASPEED_DEV_RTC,=0A=
-    ASPEED_DEV_TIMER1,=0A=
-    ASPEED_DEV_TIMER2,=0A=
-    ASPEED_DEV_TIMER3,=0A=
-    ASPEED_DEV_TIMER4,=0A=
-    ASPEED_DEV_TIMER5,=0A=
-    ASPEED_DEV_TIMER6,=0A=
-    ASPEED_DEV_TIMER7,=0A=
-    ASPEED_DEV_TIMER8,=0A=
-    ASPEED_DEV_WDT,=0A=
-    ASPEED_DEV_PWM,=0A=
-    ASPEED_DEV_LPC,=0A=
-    ASPEED_DEV_IBT,=0A=
+    ASPEED_DEV_HACE,=0A=
     ASPEED_DEV_I2C,=0A=
+    ASPEED_DEV_I3C,=0A=
+    ASPEED_DEV_IBT,=0A=
+    ASPEED_DEV_INTC,=0A=
+    ASPEED_DEV_INTCIO,=0A=
+    ASPEED_DEV_IOMEM,=0A=
+    ASPEED_DEV_IOMEM0,=0A=
+    ASPEED_DEV_IOMEM1,=0A=
+    ASPEED_DEV_IOEXP0_I2C,=0A=
+    ASPEED_DEV_IOEXP1_I2C,=0A=
+    ASPEED_DEV_IOEXP0_I3C,=0A=
+    ASPEED_DEV_IOEXP1_I3C,=0A=
+    ASPEED_DEV_IOEXP0_INTCIO,=0A=
+    ASPEED_DEV_IOEXP1_INTCIO,=0A=
+    ASPEED_DEV_IPC0,=0A=
+    ASPEED_DEV_IPC1,=0A=
+    ASPEED_DEV_JTAG0,=0A=
+    ASPEED_DEV_JTAG1,=0A=
+    ASPEED_DEV_KCS,=0A=
+    ASPEED_DEV_LPC,=0A=
+    ASPEED_DEV_LTPI_CTRL1,=0A=
+    ASPEED_DEV_LTPI_CTRL2,=0A=
+    ASPEED_DEV_LTPI_IO0,=0A=
+    ASPEED_DEV_LTPI_IO1,=0A=
+    ASPEED_DEV_MII1,=0A=
+    ASPEED_DEV_MII2,=0A=
+    ASPEED_DEV_MII3,=0A=
+    ASPEED_DEV_MII4,=0A=
+    ASPEED_DEV_OTP,=0A=
     ASPEED_DEV_PCIE0,=0A=
     ASPEED_DEV_PCIE1,=0A=
     ASPEED_DEV_PCIE2,=0A=
@@ -263,49 +255,57 @@ enum {=0A=
     ASPEED_DEV_PCIE_MMIO1,=0A=
     ASPEED_DEV_PCIE_MMIO2,=0A=
     ASPEED_DEV_PECI,=0A=
-    ASPEED_DEV_ETH1,=0A=
-    ASPEED_DEV_ETH2,=0A=
-    ASPEED_DEV_ETH3,=0A=
-    ASPEED_DEV_ETH4,=0A=
-    ASPEED_DEV_MII1,=0A=
-    ASPEED_DEV_MII2,=0A=
-    ASPEED_DEV_MII3,=0A=
-    ASPEED_DEV_MII4,=0A=
-    ASPEED_DEV_SDRAM,=0A=
-    ASPEED_DEV_XDMA,=0A=
-    ASPEED_DEV_EMMC,=0A=
-    ASPEED_DEV_KCS,=0A=
-    ASPEED_DEV_HACE,=0A=
-    ASPEED_DEV_ACRY,=0A=
-    ASPEED_DEV_DPMCU,=0A=
-    ASPEED_DEV_DP,=0A=
-    ASPEED_DEV_I3C,=0A=
-    ASPEED_DEV_ESPI,=0A=
-    ASPEED_DEV_UDC,=0A=
-    ASPEED_DEV_JTAG0,=0A=
-    ASPEED_DEV_JTAG1,=0A=
-    ASPEED_DEV_FSI1,=0A=
-    ASPEED_DEV_FSI2,=0A=
+    ASPEED_DEV_PRIC0,=0A=
+    ASPEED_DEV_PRIC1,=0A=
+    ASPEED_DEV_PWM,=0A=
+    ASPEED_DEV_RTC,=0A=
+    ASPEED_DEV_SBC,=0A=
+    ASPEED_DEV_SCU,=0A=
     ASPEED_DEV_SCUIO,=0A=
+    ASPEED_DEV_SDHCI,=0A=
+    ASPEED_DEV_SDMC,=0A=
+    ASPEED_DEV_SDRAM,=0A=
+    ASPEED_DEV_SGPIOM0,=0A=
+    ASPEED_DEV_SGPIOM1,=0A=
     ASPEED_DEV_SLI,=0A=
     ASPEED_DEV_SLIIO,=0A=
+    ASPEED_DEV_SPI_BOOT,=0A=
+    ASPEED_DEV_SPI0,=0A=
+    ASPEED_DEV_SPI1,=0A=
+    ASPEED_DEV_SPI2,=0A=
+    ASPEED_DEV_SRAM0,=0A=
+    ASPEED_DEV_SRAM1,=0A=
+    ASPEED_DEV_TIMER1,=0A=
+    ASPEED_DEV_TIMER2,=0A=
+    ASPEED_DEV_TIMER3,=0A=
+    ASPEED_DEV_TIMER4,=0A=
+    ASPEED_DEV_TIMER5,=0A=
+    ASPEED_DEV_TIMER6,=0A=
+    ASPEED_DEV_TIMER7,=0A=
+    ASPEED_DEV_TIMER8,=0A=
+    ASPEED_DEV_UART0,=0A=
+    ASPEED_DEV_UART1,=0A=
+    ASPEED_DEV_UART2,=0A=
+    ASPEED_DEV_UART3,=0A=
+    ASPEED_DEV_UART4,=0A=
+    ASPEED_DEV_UART5,=0A=
+    ASPEED_DEV_UART6,=0A=
+    ASPEED_DEV_UART7,=0A=
+    ASPEED_DEV_UART8,=0A=
+    ASPEED_DEV_UART9,=0A=
+    ASPEED_DEV_UART10,=0A=
+    ASPEED_DEV_UART11,=0A=
+    ASPEED_DEV_UART12,=0A=
+    ASPEED_DEV_UART13,=0A=
+    ASPEED_DEV_UDC,=0A=
+    ASPEED_DEV_VBOOTROM,=0A=
+    ASPEED_DEV_VIC,=0A=
+    ASPEED_DEV_VIDEO,=0A=
+    ASPEED_DEV_VUART,=0A=
+    ASPEED_DEV_WDT,=0A=
+    ASPEED_DEV_XDMA,=0A=
     ASPEED_GIC_DIST,=0A=
     ASPEED_GIC_REDIST,=0A=
-    ASPEED_DEV_IPC0,=0A=
-    ASPEED_DEV_IPC1,=0A=
-    ASPEED_DEV_LTPI_CTRL1,=0A=
-    ASPEED_DEV_LTPI_CTRL2,=0A=
-    ASPEED_DEV_LTPI_IO0,=0A=
-    ASPEED_DEV_LTPI_IO1,=0A=
-    ASPEED_DEV_IOEXP0_I2C,=0A=
-    ASPEED_DEV_IOEXP1_I2C,=0A=
-    ASPEED_DEV_IOEXP0_INTCIO,=0A=
-    ASPEED_DEV_IOEXP1_INTCIO,=0A=
-    ASPEED_DEV_IOEXP0_I3C,=0A=
-    ASPEED_DEV_IOEXP1_I3C,=0A=
-    ASPEED_DEV_PRIC0,=0A=
-    ASPEED_DEV_PRIC1,=0A=
-    ASPEED_DEV_OTP,=0A=
 };=0A=
 =0A=
 const char *aspeed_soc_cpu_type(const char * const *valid_cpu_types);=0A=
-- =0A=
2.43.0=0A=

