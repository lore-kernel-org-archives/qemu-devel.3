Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12375C44514
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 08:20:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkdm7-0006kg-Ue; Fri, 17 Jul 2026 04:18:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wkdm5-0006kA-Da; Fri, 17 Jul 2026 04:18:25 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wkdm2-0000D4-14; Fri, 17 Jul 2026 04:18:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sLO1GrO8Iepdn9j4fCQT5+x0Gf/17kLt1l0GzArSOWdSiGVvxsQ+WpEYq3EGmEEV9v5RPxfLF1U5CqosOfKZBe7W+zED5pIJ7NOZdPbBIplMl5smbV/lOlr0ZfV/yi0W0xEmwWNYFGBEhxYGacYqAld81+M40GghRfig1XCdvQQ8WARMhgSEI3S1jMJh1LTxBY0C3WfdhMwtTI1qUdO4UxJaO/aFqhTGFyVhEIGKTt5ZFpAduSUAFk9PLlOzE5mB6h+C0q8qxOX8EOzyQ4nhaes5fz+dK8O/9/nZv4Spy3sj+qG94WucNbnXPLBW4eTdO0dm4qpdu/m4AAqgIbPjOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s7gt63c+Pu+s/ti3iTdz48EKwrmeSevZzE1iGlCcMHE=;
 b=JxJ9MElrjN6weUHRWQsp0i60ICefSqFFoojtYHtlIwHwC0y6IAGWPczRhTYS6lG1DpsuNBlUsSdPy6XVRXCFLaopgI6wFfBU+Ze6VlRQLTcHfK5x5MVXOyQO1prIFHIalZmzxErWhozb8B477wxboStKruaZrMdce+iHUR30gN4aiq6jxVjkiFBppuaCnlZeXgYYIoZdk8JWcPD67CtezfVPdCZ+4WUYANthWtHPoByyRQz3xY+hANaHJ59XPu/qXxDc7uo0IH5gSUN7M8i+OOWABORZIuL+K2eQFlo+GQWK2ccX7eS6RUOeUD3KG+bPnsOfRUkD5Rn6yGk9IXLhRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7gt63c+Pu+s/ti3iTdz48EKwrmeSevZzE1iGlCcMHE=;
 b=JXJTBX6AOTn8LWRG8CYLbfdkO2vWENb488Dvw1c19EsFh/z5Zu+FogFIwzPuD/gyxYa2dtXsf4OCtTGF6/1FnHItbZWcdg8W91n+YDSwkl15GbywrG7c7rXqVUwA/n5YxkZl5MJuWOgQYI74KWotkTLCp/8loA++IieF+EvkB+dkYzDOEZK7kUOU1aHPdSWBKWMPbDVaA1PlgwCJYUVsFTad9opuyPCBSWRuyh+yGdTobdgfwtJrswvzcMVRtScF4VEObuDvtKqQ2nB316bhtlbcjL5AGPTD9OTqmhgvm44HA/OWb/SAAaVYdiR0z8WD+J4/tR7uHn08NSQerY9O7g==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEYPR06MB5253.apcprd06.prod.outlook.com (2603:1096:101:87::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 08:18:15 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 08:18:15 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Fabiano Rosas <farosas@suse.de>, Laurent
 Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v3 1/9] hw/misc/aspeed_scu: Introduce Aspeed2700SCUState
Thread-Topic: [PATCH v3 1/9] hw/misc/aspeed_scu: Introduce Aspeed2700SCUState
Thread-Index: AQHdFcTQySeu7tIOkEafEjIkPeaAKg==
Date: Fri, 17 Jul 2026 08:18:15 +0000
Message-ID: <20260717081813.3407862-2-jamin_lin@aspeedtech.com>
References: <20260717081813.3407862-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260717081813.3407862-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SEYPR06MB5253:EE_
x-ms-office365-filtering-correlation-id: 9c179a6b-57fb-438b-26e9-08dee3dbf348
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|1800799024|366016|56012099006|22082099003|18002099003|921020|10067099003|38070700021;
x-microsoft-antispam-message-info: RfdGyqrpA1Ircnulscs0LvhoqxSVCJEgcndiAzb6nj/LNUz5D56xqfG1PoNlkVKat/w41xICvrXpghJVDOTt8HUZILuxhBrW32cupBoc/BdNGcDwe8+OBEFRyJToNbXt392vZO9QiB4meoVc5iCUv8H3E/pRoV3a9kAT8xURpQu5L9fypvvdXIXIhbDOwfEEtL7OHjO+xwouse/5230Hmk4qDk+hSdlEAu+ge0CEdES9uThrU8DulH3wTRWSJz6s5T+gAS6F1XjOJ6uBAVbrykTdJwkGwc1uYEGj4wCnZvzDqx5orWr1LC0jcUhbIrVv9DyJyGjT/RaV5HlVOnFRewW7XzP+lUuVhl8a7HdYCtSFSusYVCarMBAAkUiWtsuS2AmID/Cs17M2yAn107HjOkOLCmCUIeK8HZ/oKaXj+RD3dWuyxDErQbg1YSjv5mvZHHatogJ1Qle1o0QF/SH4b7HaTUx6PRtfyDS0X7GLSlzNolCP8MIxobS1/vSUhyeEQ714Lu2ddrS9jkUcURVg+YUviU1llptAcNOEUIOcXGzT93iuR6+hZta8UwvTn44UwhtNimvm48ingqwNrRW2/7jn5NBtH41Ks2cEJNjGSoawPqCywgoFO+ZNcijY5pfDUTaG9xwz2VzDXQvatZjzrsWKzHzRMLUlc3xA8fxx18hKw9Z5cuacrGLvFuuCYzMNcuXD+abVIunHg0E32hzH0NvREkKGrAmWXE7t2D+A1Q/mRjQd3OcGXOzLzPLHP956
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(56012099006)(22082099003)(18002099003)(921020)(10067099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?zzhKTmgtv5habDpH9xInkZz6YUEZK4Ydt4rCwTB3drYg2zjscvi+B9XnBs?=
 =?iso-8859-1?Q?VspASsFKye0hqSLtEMDUEXuUZQSYh57T5Wd5ZAM/+Fe9b93aXMQrP7Svau?=
 =?iso-8859-1?Q?rucK565/cTvuhlNVdwt4vVnajARJyP5dmDotlLKmJk9S7WH5PR7HDI6fED?=
 =?iso-8859-1?Q?lNcJeST216fu2XY4xSTOKm9qZxJgs6tX8cKXGGjfHAGVCO+a1MUAXBQglN?=
 =?iso-8859-1?Q?uWCcnZVyuk4VmycEB3tzgcesbKDQKgyXXU4K4Lb9TQgLWO+U71oLqumXNm?=
 =?iso-8859-1?Q?CHP4ZGXc5kYMm+aRfox0Q7rgqaboHTFrwHH83mb8uF6Gn+ZaQj+4jhTjZd?=
 =?iso-8859-1?Q?7yv9FCf9w8RBjGhZ54QS71XoEqzC2dDvEEL8TAFLlUTcCEl96f80pdM3d8?=
 =?iso-8859-1?Q?6kvQpKOowJv6bLrXX0kGQIjVrazyjMTLPIIyCrANZcyRUwNw6YO6qVkDRK?=
 =?iso-8859-1?Q?XpQIP3A6udZNtDkFl3CRysDnYUX30V399sJMiT7dtnVr2u3/Bbzy86ve9y?=
 =?iso-8859-1?Q?V4FP7U8/onONl6FOnWDgbmy92J1hIdb1UOpcbjjsFF7zZUo+SUcW1045d3?=
 =?iso-8859-1?Q?iks1NmiYLyvos5mvc/XqruyQ3PsU6n8TVokFrreQUsCcIiXpTsL8fzJixY?=
 =?iso-8859-1?Q?aWC8tK6oKjcnovwT0zFrcwSJrN+HXGglN8j7Sxis2uZz+eOTybVzWAH+gl?=
 =?iso-8859-1?Q?Na9hUTfZkPBZ3t/nLYYvzc5fOrX0Edw+xa8tvd1mOuwglP4mSy7Z0tVPt+?=
 =?iso-8859-1?Q?gAKtzrsLbABXv1krkKj8suAJ/yWiJij4/QCQeBkd2iQvIgY/Xmy//m5vOO?=
 =?iso-8859-1?Q?DaHPJ9yHHqIgek+vGUd6b7WS0L5z5zsC3bkXn+o80MxWTuHt5wwLgOBJzk?=
 =?iso-8859-1?Q?Y5ymb8gM1WeQlTNjbCnktGgDU4gD3KZxp8Kweg6cOU0zbBPfIE6bZV/01i?=
 =?iso-8859-1?Q?2JPp8f9sdbmHOVpPY8p/1cmsukPC9azv1kuw+UJQitJ4rukA9q7xx9XxgY?=
 =?iso-8859-1?Q?i4qB7q75kO09SCYEbKM+/qWpqhr5iEIwSeefpAU+TvSfne1wlI68FakiNk?=
 =?iso-8859-1?Q?39AhHx8Y5ATrN4qwO0MNUZx8WUq7KlI5VZHPqOUWgZ8urWZ/meaw5lYJ1T?=
 =?iso-8859-1?Q?RTQ/lY+j1WfEygHTv7+eFUocw3TYGbP6sEa9bhRYTMLjpXpCg0u6lNK5vq?=
 =?iso-8859-1?Q?TfV++gsdtgPe1WJjTIRBoTHUUnNM6DnyE3rkgx+jpgO/oig4AsBQU8vp25?=
 =?iso-8859-1?Q?DsYjvj4DIymG1PbPsZqM1jIbnFE9F2lC4jTLSdewaXT7FrQzOpQQ0FkMS/?=
 =?iso-8859-1?Q?gLopoTdlxD3cXxpd+iEJRBZtY4kxitfvVdpxO9XYV8Z38ceTOxd41Cxtv5?=
 =?iso-8859-1?Q?zlObVkFP4LC5x1Vm5ThEGgl4h18aMGyFtKZsBaYa8DKwV3K93Z/FpmYVAh?=
 =?iso-8859-1?Q?HZ6qb+T9aeBuc5f45XvyZ3lNsFHuXB6qC5ZlNSjiEaniTG4Vpkl/TXNgMC?=
 =?iso-8859-1?Q?2/Bjux7IbX9PQlwp9eYkYe5klrNOd0OV24ijmAD55J/Ek4+tAlmZBcU9/o?=
 =?iso-8859-1?Q?ZzvU+K/lQ/EyzXrG/Za3A3+lBtRDhEEIv4CpMcYZ97D4N587iAZRGTpF72?=
 =?iso-8859-1?Q?x1dwwXuEAxVIBl+cwTf7rETkJVstexGNjFwKwZB0eTIfWp3GlNR8ZtPqPR?=
 =?iso-8859-1?Q?M6oH6i+DfaiHHQxOhfvHOO6GdqfF+REHmWRvWL8yhHgF/K3tgOsOJ8QrK7?=
 =?iso-8859-1?Q?afrgxXAKpt9uFTGyrrvzmmv4qnVl5+RmIHewQfrsw46REj3ibpLmAm72ED?=
 =?iso-8859-1?Q?GRf4t0Woiw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HzdcwH/GZ+x7RgUrZH5TFco0kC43jTphNPfrXWuhG2aktUzHsfah7P6K83xdc2jwEBE33E18JYm9mwwy3eRYFH9w5BF6vhs3auN7kwRpB/uGY/4VMziUJEtny8HHGYPK9SVD7T5g3Q7XKEGQEH+ZHhxbxk/OsgEKuDiUNmYBjpeJ5BflKpCllRiwc6GcCYByhP/ofohBpsxugdO+ARS5gqUyEZC6rfVP2ZGfXLAc881YCd0rPUXNfzzPIDai8fkk5aWDrQrZoo1l+g+8ObnagBLhVmfqq7PJqibpV8ZtFiCiTGbhKlKSu7+MR1FvIoOhBNU7tASWimH4NM7in+Zgew==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c179a6b-57fb-438b-26e9-08dee3dbf348
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 08:18:15.1756 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eEYrjxZEZu9VsLm+xZe2hs8XBIbDhNfnQnfjRg8kDDhlub9+9kEZLHWp7X3i7p7thicdWf9E2f3IExgowUMdGz8vcLTz9VXAjvHHD3IigNM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5253
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

Introduce Aspeed2700SCUState as an AST2700-specific subclass of=0A=
AspeedSCUState.=0A=
=0A=
Currently, AST1700 and AST2700 reuse the generic AspeedSCUState.=0A=
However, AST2700 requires SCU functionality that is specific to the=0A=
platform, particularly for interactions with its coprocessors.=0A=
=0A=
Introduce a dedicated Aspeed2700SCUState to provide an extension point=0A=
for AST2700-specific functionality while keeping the generic=0A=
AspeedSCUState unchanged.=0A=
=0A=
Subsequent patches will migrate AST2700 users to the new subclass and=0A=
move AST2700-specific code into it.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
Tested-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
---=0A=
 include/hw/misc/aspeed_scu.h | 5 +++++=0A=
 hw/misc/aspeed_scu.c         | 8 +++++++-=0A=
 2 files changed, 12 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h=0A=
index c30940ab76..904549465f 100644=0A=
--- a/include/hw/misc/aspeed_scu.h=0A=
+++ b/include/hw/misc/aspeed_scu.h=0A=
@@ -20,6 +20,7 @@ OBJECT_DECLARE_TYPE(AspeedSCUState, AspeedSCUClass, ASPEE=
D_SCU)=0A=
 #define TYPE_ASPEED_2500_SCU TYPE_ASPEED_SCU "-ast2500"=0A=
 #define TYPE_ASPEED_2600_SCU TYPE_ASPEED_SCU "-ast2600"=0A=
 #define TYPE_ASPEED_2700_SCU TYPE_ASPEED_SCU "-ast2700"=0A=
+OBJECT_DECLARE_SIMPLE_TYPE(Aspeed2700SCUState, ASPEED_2700_SCU)=0A=
 #define TYPE_ASPEED_2700_SCUIO TYPE_ASPEED_SCU "io" "-ast2700"=0A=
 #define TYPE_ASPEED_1030_SCU TYPE_ASPEED_SCU "-ast1030"=0A=
 =0A=
@@ -41,6 +42,10 @@ struct AspeedSCUState {=0A=
     uint32_t hw_prot_key;=0A=
 };=0A=
 =0A=
+struct Aspeed2700SCUState {=0A=
+    AspeedSCUState parent_obj;=0A=
+};=0A=
+=0A=
 #define AST2400_A1_SILICON_REV   0x02010303U=0A=
 #define AST2500_A1_SILICON_REV   0x04010303U=0A=
 #define AST2600_A3_SILICON_REV   0x05030303U=0A=
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c=0A=
index 5dbf81c0ce..efe1d6315b 100644=0A=
--- a/hw/misc/aspeed_scu.c=0A=
+++ b/hw/misc/aspeed_scu.c=0A=
@@ -930,6 +930,11 @@ static void aspeed_ast2700_scu_reset_hold(Object *obj,=
 ResetType type)=0A=
     s->regs[AST2700_HW_STRAP1] =3D s->hw_strap1;=0A=
 }=0A=
 =0A=
+static void aspeed_2700_scu_realize(DeviceState *dev, Error **errp)=0A=
+{=0A=
+    aspeed_scu_realize(dev, errp);=0A=
+}=0A=
+=0A=
 static void aspeed_2700_scu_class_init(ObjectClass *klass, const void *dat=
a)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
@@ -937,6 +942,7 @@ static void aspeed_2700_scu_class_init(ObjectClass *kla=
ss, const void *data)=0A=
     AspeedSCUClass *asc =3D ASPEED_SCU_CLASS(klass);=0A=
 =0A=
     dc->desc =3D "ASPEED 2700 System Control Unit";=0A=
+    dc->realize =3D aspeed_2700_scu_realize;=0A=
     rc->phases.hold =3D aspeed_ast2700_scu_reset_hold;=0A=
     asc->resets =3D ast2700_a0_resets;=0A=
     asc->calc_hpll =3D aspeed_2600_scu_calc_hpll;=0A=
@@ -1161,7 +1167,7 @@ static const TypeInfo aspeed_scu_types[] =3D {=0A=
     {=0A=
         .name =3D TYPE_ASPEED_2700_SCU,=0A=
         .parent =3D TYPE_ASPEED_SCU,=0A=
-        .instance_size =3D sizeof(AspeedSCUState),=0A=
+        .instance_size =3D sizeof(Aspeed2700SCUState),=0A=
         .class_init =3D aspeed_2700_scu_class_init,=0A=
     },=0A=
     {=0A=
-- =0A=
2.43.0=0A=

