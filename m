Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5AC8CA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:26:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBoh4-0001wb-CS; Wed, 30 Sep 2026 03:25:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xBoh0-0001uQ-RE; Wed, 30 Sep 2026 03:25:30 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xBogy-000289-QT; Wed, 30 Sep 2026 03:25:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OKJ+yChzTAXZKx2YeE6N/T/RIZnkhzC3E84q2tnC3Vgmu/wsxnimr/gCkMq1xi8E9Pe5j9FlNswzzy0VOfblymzHggLjRI1Ouldkh6D+/+rERp72+NFqqVYI+1o8HiMBovksav+c68JuqCNlUrTTozOXKVYY1PNhsqgRBMwU7NvRpRKEBJB7I90Bc6QHV6ozmGB63CREmXfJoW30Hb54KS3FjSchkTA206E3Bz86nCdvBDzv5Ene6bYhey2eBvJ9hyJVTL4vIyyDKDVXKtcahMeSRcFqOqdza/3tJ/tgJcc4h4qlCvsSHWCNBksXPmZxMningqlMi804EUmQUrbcMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zPqyB38otWazfbtcEmfhEeHIhtCpFa9O0hGGDuzpTjk=;
 b=rvg9FLA91QJPDMUMS7AXcelloS7wSyg7gboyiAII9DZFP43GKVPVPrvMdv2HVk2jSZ4I5fpwHvCNWsDgLWoXvhqBf/qeWxycr7f9q5PJQ18Eu0pQkWhKyD/VPbv17W78jFPmQ+whxZiUEulrzzP4p/9CB0Xr80MpIEuDM1xBm1VwLzNtOxVkZCzJxJHS2zERBWFSQtq3fipE4k6ytok1t2eb5WyZwNHhV6hQaO9kkxHDrTTQHIz1Rn1eh6y+IWSG9cBbWy3fZUN2Y8C3qo/DRxnHoHJg0MuXgQ1gmt/mPahY0xWs0h60FkOgFkFZfvCM8e4/iLDPpsMRvk6qSjB4TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zPqyB38otWazfbtcEmfhEeHIhtCpFa9O0hGGDuzpTjk=;
 b=T4jLpci2evnI2JK+a/iKXd+Yi8Xg9TQclRqBgXzKg3M2gqxXaI3whNdkhT+mEV8vkBGHZPtPvY6nLHZm/bX98iHZUDlTgKYWI/LUVlCsvIBNjYTKEgTImcUQeyJwVNQs3aRKAbDPbC/hXmuXBT1grU/6wH+Bdwg6i6gmP1wScpAh/i4HkdasY/I3AN5+AYEBsJj8VPEJUeAa89LYzdDxMwdxcIOqRd+OoqZ60kTYgyKGhglTq3P0UrAZZZtKYp2knTGkmHBfGv/1Cbu1bwcFa5c/hHPl3huUIjExjjQURIjLuxAepl+ax1CBvJQH/RCMRemDWpxsA2B2rEMPepXMFg==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SEYPR06MB6616.apcprd06.prod.outlook.com (2603:1096:101:168::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 07:25:13 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 07:25:13 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 10/11] hw/arm/aspeed_ast1700: Remove unused unimplemented
 device field
Thread-Topic: [PATCH v1 10/11] hw/arm/aspeed_ast1700: Remove unused
 unimplemented device field
Thread-Index: AQHdUKzVo1C0E4DRcUOJSNnxj+eQaA==
Date: Wed, 30 Sep 2026 07:25:13 +0000
Message-ID: <20260930072501.2612119-11-jamin_lin@aspeedtech.com>
References: <20260930072501.2612119-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260930072501.2612119-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SEYPR06MB6616:EE_
x-ms-office365-filtering-correlation-id: 7fcb5d35-ce38-45dd-d507-08df1ec3f803
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|38070700021|10067099003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: gPktpDdJnGoRgpN44B52ZFs0OfM7ryjQqGsOM1Kbiq8MMXnL18NYkcJlpzTp+VBLMBuu5Oeh+H5aBcbmsdGwimxZLlDymULYuYBnWdbL6q5zi+youDHCp+GwM8P6dXTWFUTbVUQt9Pvnj2mLChI3Oa0dR0sTWhbX+cy6l3hhcEk7jShAhp/EJtdlpRi90pccN41k7BiiOBx4LMd+fG1iDjkV4yPwFaVS8QBVBJULJDNm8seCqnlwVPCocUmKixFl4CNqWZ5z/x3TNT3DDnW+3cG0wPvQcpRpb8Towqb49xier5QE66JDutOpqgNsFldjy0nqM3F63XT4Oynl6xzA8MCkoSieRDAb5luWYI3KWN2/NxnWLKEuXXsrcHhIvdFXoMZhprBbspYMgWfLLhTwnehAqqY6rDJh5BRzUlmJ79BYgrsLhu33RpShqFBHPqp93/I+bQIwAr3B0K2TDGrSUBO0o5iydEPpndEzzPRvmJZbQnd+hak5M0S6XMW+BgoBAOHM8jG25QHe1caQv2GGgyScFmk2M07jqmcqEfuzeu9dZ4s+2QEnWIqQ6ufcxPuyEmQ6b+uSeNKKbDHzSQ2W9z6GX7NdeHy9tZCdk21YGBFYVQ6u1wCoEgVHPRW5a+eddNHfm+3jWLgyFsxKH79Ghlj8WMnLuksYewUgaY/vBNVmwijjJsgA64A6e1DyoKCyvGZeKCf5y+5zUttve9AmA9WiJiZkw6bp7XuA3bpUBKI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cUuQkQ/NkgjbrEC0xif4f/3q8b74B2L7vOPpCMhWvE5WH+4SJCTrVfuXPe?=
 =?iso-8859-1?Q?6e9Aet14nmYls6bcCGaurAouThOyXBKKat6XipMFOewWk3F6R/HSwALP7a?=
 =?iso-8859-1?Q?CvkJ7PfMs5l45i3Bd/RlNvxo3/jfVFucBbU5Il7yzvho0yyCWhm/zwk6Lk?=
 =?iso-8859-1?Q?PeMM2tZxJV4BOnEW9lhy+oYTJDVLTRskA80pwjiiSuMeo9+sNQtT3hu2d0?=
 =?iso-8859-1?Q?//c/rf8RFjhqr2TuraWV0FeDs0H+j9ATY+XwtIe5IiYjl4lue8digo4Ar/?=
 =?iso-8859-1?Q?B5aLMuQeeOVSMq7jnKLjus+kmuq++JyT7qZCDh9d21VuEH5zsyIVVr4pJd?=
 =?iso-8859-1?Q?IO3pfrODeNzk7nPHFUwa92GR7Sd1ahcZyO/CpGDOvfriO7iBvIL2gJArpK?=
 =?iso-8859-1?Q?QH/+uoRz9Qgru8dA50/as6m8nXgPLH11yzsRdJK32ggpnWq9nfDHb3H1IN?=
 =?iso-8859-1?Q?2PQTuxOJ9VEvDuoi6ndiXjrp14dmtBmlgNtLlGvkneaZM1N44YFSh6pQLe?=
 =?iso-8859-1?Q?eWlElRrw5qf7udAcb/9TYpZRIiQzc+Tcwn6BQU6fCywNtafnm4XBw+/SSk?=
 =?iso-8859-1?Q?QpZtgTacxXbQ5hPnlbJSBI9YeUtYqIAhBa86cpofzMcoEcX2KsO7wIM29d?=
 =?iso-8859-1?Q?apj5MQxuBRjaQ1lGuzpepBTwAbUmiSBhjC5S0JGOuadmf+LSlUCRnLaNR1?=
 =?iso-8859-1?Q?kZmPwK1tCbfHqxEygvKwC/kFXkPJeVAph/ePgDsBEjTlOutvtofE2oUD2r?=
 =?iso-8859-1?Q?DT5tsqJTkAaJVnrslfW4I2BD7TZEMsH3xV+RLWEDwzloUuB2VCZAPptnHI?=
 =?iso-8859-1?Q?PU9BKmK7gLbRPyC4NsOzIgukJrE+wSQK/9pSVLKDNG3mj9zNTuRw911DQa?=
 =?iso-8859-1?Q?N0V6bpvVmsvb0ZBZkOU3XLpR5gRwgpAeI5TuWepm6jwYnufXPpcz2zWAHa?=
 =?iso-8859-1?Q?qLjwSs6vS05K902K/+GKh2jEcKRtej/ynyjhpxAmVnEfL9J6wQ6pWaTLfa?=
 =?iso-8859-1?Q?4Z2TO9GwmupBiDkiqHzz307Lu40iYrt4Kz9JsNgiliwtY73EFqLwTCnKDr?=
 =?iso-8859-1?Q?z3jTxk9IC5CRxGvoJMVt/ZMs4S/YljS3Qx5dGUae6YmugTeL+Jk0ca1CeZ?=
 =?iso-8859-1?Q?FdHfgGO8jHVgaUzLYGjPRJIJh50vfNVzFvxy9Xw2jn2exOSFtUHtV0ahCr?=
 =?iso-8859-1?Q?lLSSnjN+Gorj/hPXCOFUn8U5rbtMJmuzwtpt1Td+bNumY3oGkayfyLKOQP?=
 =?iso-8859-1?Q?f1ZBMM2EQiZOwOkGQh7vvFR9tA04kvdntYNchllD0KlTkO/+0fDLFAERxZ?=
 =?iso-8859-1?Q?GbSyM62ZSarXHUIxtmehRUh3w1Ih8Hd9NYYOJWfMcc/vdfvq5DLouMA0uj?=
 =?iso-8859-1?Q?cExJjd8VAAPh84l+q3yyk7VsqXYhgW0rGx1uLT6bYkH9qvYPpuqjjTEUFe?=
 =?iso-8859-1?Q?LwQnsS0xJK7nzkfkll241g3rPMb/S6fTk3X/B0CZ2bYhyT0xGjAEtG1nXi?=
 =?iso-8859-1?Q?T0zgS6kwS1aySE+ZDmI31Ss4BLAvIrXqbNnaCxHkqnrBRq44BGJul3XLLh?=
 =?iso-8859-1?Q?Kw+AfFc9GAgJ0XpfWH1b91sSmAx1TWq8HmtlcGBCLQvfE8sbjLPuJtDJ7q?=
 =?iso-8859-1?Q?Xn4II5KZH6+uYEp9B1E683jaJKcBSlozLCujtXGxdFFBMKgCq79xJUWl//?=
 =?iso-8859-1?Q?tlJAe9McGVfaPBYa2pYDZvCZFPoiFtNGHsAPk/d3TlUEIzh77Op6Uq7sn1?=
 =?iso-8859-1?Q?3kIh2pwBMcWFsd+JBFNMr0UErdzyWonYVm/rmhlmFebIb8Mzx3UHhopFS4?=
 =?iso-8859-1?Q?eLDOw4yb0Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: OcijMgK7/bAj0OW1eGj293PIqUVNWt6j+Kdl4gPpS2WJtCBzJERWQeswWsmPnDjYvcm+iLFi4LmT9G1tCUPXOFP3ZJjllV9If4SEtb9R9SHUpiSZ/DLKnyGgAtdfFqaXjBj6yl773GtgzRw2Pk7xJTDNlLKd64erzW0IdTmhAs/CHSTHvjbhibyvYxBEYavxMGehVECe7nJadeCjjJUXanZRL1APX08tfzFJLHjia+QYycFvkgGyTTN6lMZRcxbdLOGxWGpqMOEbw1v1p61aoua3X1duim3lZipbntdMnDec6NgB0MkMHPwu6tOjAidZo4Erwa0YdXsJF6hfgpa2mQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fcb5d35-ce38-45dd-d507-08df1ec3f803
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 07:25:13.8316 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vl0NNkbCRteG5BTIckY1mKTc8tNVxSvE0KaFWLSFxdO3G5T0ozzHc2j36hY5WpFBlo0fBoYuWk8e8U4rWB3fyRKfPlIRb42H6ptzlGwec0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6616
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
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

AST1700 now uses the "unimp" array and the AspeedUnimpDevice table for=0A=
its unimplemented devices. Remove the old "i3c" field in=0A=
AspeedAST1700SoCState, which is not used anymore.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/arm/aspeed_ast1700.h | 1 -=0A=
 1 file changed, 1 deletion(-)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_ast170=
0.h=0A=
index ed9b45e202..015d1c51db 100644=0A=
--- a/include/hw/arm/aspeed_ast1700.h=0A=
+++ b/include/hw/arm/aspeed_ast1700.h=0A=
@@ -49,7 +49,6 @@ struct AspeedAST1700SoCState {=0A=
     AspeedPWMState pwm;=0A=
     AspeedWDTState wdt[AST1700_WDT_NUM];=0A=
 =0A=
-    UnimplementedDeviceState i3c;=0A=
     UnimplementedDeviceState unimp[AST1700_UNIMP_NUM];=0A=
 };=0A=
 =0A=
-- =0A=
2.53.0=0A=

