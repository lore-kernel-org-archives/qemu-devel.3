Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07591CC6B39
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 05:57:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHESj-0001sa-TG; Thu, 15 Oct 2026 01:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHESb-0001oq-JE; Thu, 15 Oct 2026 01:57:01 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHESa-0003Dj-4e; Thu, 15 Oct 2026 01:57:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZPN4OSqviJFutVBcybQbzGVpBAYD1YdUecEvAiR0FSvIT1D8feEi436qPkKO1dVuTziy8Qn+rtbwnMV+W0+OwDCiJwcOV/SRHdUlVz30xjkl+yuGj5QvxTp7Kf0W5yrAyNg4NxCK5qRXbJYJ2tIE78H/kKgzs8mwv6E/5UDZBVVrg1HKT2IuDOox1s+/z1Ax1DUaYoQ9Yn2auzXIXcLt7+z/aD/hH1F6pPuHGhiEBre8szPfJn2/gz6qj71g93TXBWHk9ZaptmAageLXPRnmNsOYTIWQTIH6RgCgeUAEl7ldCaw5jJ0Lclb5+P0PjQAvcZE6wyaVzew1ZzX0Yo46Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXXCjk6J8Flla8Kx74defY0Brk2CV1L3YvOvlh2XG3M=;
 b=qPosYFZzmbQwlnZFLcZSEVuF8wauqNXZ+rHvtMex54DAvpnh1qyJV74CGkleg+vSsn2j/jMgAJJQO3rf8ZKHwz08V3JVIevroDIui+P6HweB7plYGXJRir0D31FtMp7YwQ2ybcuddsjXyzQUSNt7j6btrgy9hYccXz3UI0xHMZjGahbdTRD33itNTpzjPoUXei+KGzbY4yu2hbRslGwsgciQH2E6QlmzyG1uIxmC7c5TM2sNwZ30Fk9x3DMOYE8psNOSh10uC3gMXM28vSNz3VNoOEY91WZUpteg6DotpWxyFhw0q53gUx1GBwsXvqqX/kMv1B4ikgjCBuhLS//nvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uXXCjk6J8Flla8Kx74defY0Brk2CV1L3YvOvlh2XG3M=;
 b=RRyFTn/NDp8kCsFGE7MY34fptLGIeN6m0cXM1lw0eZkFj9W6RIx8y/nkYzTj8wi0fXiEEsukGLkfTkwWD8Oa8Fn9GJkrhEtUxLs1QqI6i3d7B/xUb8JFhyqEZS7kRJecKikLJzyK3ZmChi3oKxE+dl6MrVZsyCmjXb9W5hlWg1dv7cEy7N8ArLy/tmnQr6lEDdXNfTjspD+zlf3GKJUuJ88NOxUjR4TzoYOsRKETfhF/F0W5l/spCQ3jKovsqb21YyXG1VPIWaKeR7WrZsQ3Vwz1Syv7CiPeebv5LkErX00F2+uOkkTaMTakMWcZ4XPoxdcUv81wmyFesIEp0dVHAQ==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TYNPR06MB8379.apcprd06.prod.outlook.com (2603:1096:405:3b6::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 05:56:54 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 05:56:53 +0000
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
Subject: [PATCH v1 05/14] hw/misc/aspeed_scu: Correct AST1040 A0 revision ID
Thread-Topic: [PATCH v1 05/14] hw/misc/aspeed_scu: Correct AST1040 A0 revision
 ID
Thread-Index: AQHdXGn3bmU5fdu/6Uuit9RRI6oT1A==
Date: Thu, 15 Oct 2026 05:56:48 +0000
Message-ID: <20261015055642.106204-6-jamin_lin@aspeedtech.com>
References: <20261015055642.106204-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261015055642.106204-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TYNPR06MB8379:EE_
x-ms-office365-filtering-correlation-id: b8395c88-24f3-46a3-7c78-08df2a811ca9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7416014|23010399003|921020|38070700021|56012099006|261009223027099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: DcGL4F+hyHQZrEwp6akrXrLzdQ4sQWh46r9wAess1PS89YeAFyMgwLzgMgosfIpzraTpxDT/Mjit9oT7+wG2N4qvQHPItq404QBBmvg4QIdOO17R3W7u7FmACq+wG1TGfPZFxKVm9Y9G5e/b47LpJCFUsDgR9lItjmWxU93by8y4q9XUx3J6NovyFk6zK5u8zJrmfIrRQh3MwSH+3kF0ScoIHoeU59iDm/T4q6uY7jYSUXSIJaFAdFpJa4bihD23l29o2yMN/ZcxszynK1Wn+i738qj23j2P9Ck2QR7xXdGoLvysyhPOhNfMfQveTvMlU65GpEa0fHTb65uZ1oTWhQVP8dh/5BC/K2ZG9yGMlVWgDHNiEGeQZIToRZvI+DPhEZsJ6Ar1rTcxydah5yHpIOECoCY6a8fCp6SCkvFHXiAINCecaTjDRzEeEL7yW06Eexbm3nXjrsQctcLT6lcOb7t12FSYsvtZP+sUsTE/YSvW01eOH9cBDrtWby8V7DywHD1/KeNptep95cX6EOAN+nr/8IvIpwvheMAmKA7an7ZGYZBCkstMHc/IjQ/ziVz4Bu2kMJF1ghUHSU3udV3ez/44qKLAMvpX2S/ynXOHt0JQIRBnmy2KxAFor6pWOURksJKbnmI9mT1GESq/KevKLW2hZA+lMxbglbH5atsqQNEONCRE2rSwxuReYYYPE8wOv9pTmsMGiObmQSmPLmyWZciDoR+6TZZNzrqY9tv9zb94tmBQR6wp5nuq9ObjT3UF
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014)(23010399003)(921020)(38070700021)(56012099006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1bxejGdFA/SqMn9aAhXX2Jn642SYc/HwftdOsXh2qNYFnJOF6g9+9tOAxz?=
 =?iso-8859-1?Q?2lv0gXSXXFyYA7PU2Ql0qGxnegpYynFL8YheVvFlgGHZj6EymrRr9pgE2u?=
 =?iso-8859-1?Q?y0weGAMTU3hpC5xyNJc7zDlsLWX/rJVbh0Cg2wmvGZ3xcJSF1OGGXuq3gl?=
 =?iso-8859-1?Q?s+IZxLHrmRAaYAi9McNocrpTF13Pvw3G4z2/wczfBkZkj64QsBweyeIZ0Y?=
 =?iso-8859-1?Q?06DmFGOG6Smhrr23dgVJBRTHReabXxEKdAlvaxcb3ff7aTaCmsEFSbDmNP?=
 =?iso-8859-1?Q?3s2OZmqrnRCwBVyeQM3US/z73X5YxFznw7SUAvwuSssUi/t2fUozyqdvwu?=
 =?iso-8859-1?Q?s2jgN/j5dABSpfXYeuuagecW/JOQjsAfUlZi6JZehS3iMs5SVivEXRcrjB?=
 =?iso-8859-1?Q?nybjZQnUcnLWu5Ym2o5RH9O3GWa/bxswQCGG6MEBOQzZjU1imZMDQIlSGM?=
 =?iso-8859-1?Q?GXOGIQ1UA1jMV4Sbv1YKuzcku+KP6+e/D2UqngyHZgIK18mZrQmE5TNEOO?=
 =?iso-8859-1?Q?wSDNn0XyVjlXJXbdG6VXH0FdN3aq4BWlmRPSlW88J+O6NyEYpLAdBh7zFD?=
 =?iso-8859-1?Q?qca+JI0g/DkvB0+iP2jYuAMcucolN7mikwaReKFneLXOyjIlX3kUMGEltS?=
 =?iso-8859-1?Q?OjNiDIqHxHk/+1mjIwlecJfJwLP57umTptAOZsjDOfwKzP5MsfOIW5SXP0?=
 =?iso-8859-1?Q?j0lGNhfDTSe0ay2nS1CH6PNvihnUMdTRI77OK/3UFp8kC7jzls55x2yGFP?=
 =?iso-8859-1?Q?DOB52jJDZUE7tMuyyP0J+RDGgw+y4lCLfcKS5Vetw0dD7OkfyGG54zq5h2?=
 =?iso-8859-1?Q?BJ9GhQbD3/m3ZZ/HITtphG3dririC4JaKDBgV6hk0ix6Eog1UWctPxAY9a?=
 =?iso-8859-1?Q?+w+C1M/5sxbKh0XwOw2oiDRJT75XXHOgYEHWdX0W6Zcb4knQ3hj9EnqEWJ?=
 =?iso-8859-1?Q?n6P41DHpXnHZgfWb1UFTSsZLzVvlyvX/emrgZHroMbpw4tjbkWpqpexrMI?=
 =?iso-8859-1?Q?og3ip2RvMGuOgTD5EQIh+HsvdWqEBqV93eY2sv9KcDNozzW6S4WgbP/Ne8?=
 =?iso-8859-1?Q?XUx0EnKSO/59Oo/AyYOA8j1dMHOJwl4NbK/7HdyhqkK9NhaBWSrOvdobkI?=
 =?iso-8859-1?Q?PYBE9n0+CgHDOJIdpDSlo1JxI1TkRlkSOdJndW0QC81XLzE5saLraROn8S?=
 =?iso-8859-1?Q?p6LtA2gEfqvxb8eyqBwdj3IAJ3wz090X4nXF58BSvda8HqUP8RahRQDnRp?=
 =?iso-8859-1?Q?avQDnzzcQ1zKDbn2b+MnhQyDV6et+XOgVDWNzKKv8oW9lViqjGH9c477EW?=
 =?iso-8859-1?Q?EafNWdXDpsPjAvnbVJFKig1aHUKmaaZGznBZWRYqdV4QgPs7uLhm2aAKjj?=
 =?iso-8859-1?Q?SXLlUdgiuXGqa9D//BIf+DgvzQMXW741F/5OMk+GB4lfd2P9BfPSZ8mAS/?=
 =?iso-8859-1?Q?Ye/nMQUckOwQ0xJ8I9RuUczJxQ5CnU6F36q5CXeU7rW3mtAMguAWfQQN9D?=
 =?iso-8859-1?Q?iEELAuV0TCA7HmCxWJkXLq3/cuyOq5xcnu6puiDgmrvBz0ThS1ziYOApXf?=
 =?iso-8859-1?Q?OAnG1GxvzlBiIJk1gHAKUbURjIfiOCYTqkifLSlUs28W15rDtRChiCOiot?=
 =?iso-8859-1?Q?zD3bcI5zlicgeooUbOQJSrhjB1X1kVZouOBLeMIvl7yql3H6W/d/NLfogf?=
 =?iso-8859-1?Q?KJ2KeI0kD2vRJ4rh1B8aky9wz/b5BbU6c0NQNqvttAqcK3hJHipFCF5XWO?=
 =?iso-8859-1?Q?di8bxLCipyn8PTYDBXEVdnDiVhUPPbDRLR51Xqr863jZYXwHRfcTTcZLir?=
 =?iso-8859-1?Q?dsMjiWbU8g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lej+yfkatD5nB3sOujtfNPrfW/if8sDmPIOaz136PeETk9DmV/qmWRA0/MJNfQ0FS53WZ+2TCzcPCnCLCACeNU2LGugQmFgQzTS8omjuChOvThYaw/ZQETUecFbfAsJdhzQNwqC12/XAnFVbDg8qY2dIysfAFhVchPBtpFnkaPM13Fu14NSzrNYPnv0hp2MMZukyJ1+2DfX06Pv+9ZNCxoANX5nJSSXMS11eVMnG0JPDa5EirYNXuedUsl3DDoWepa6M1NQVFg2moAUaNiclLtZ+fCkFYJl8muYG0uewDscByAzg8fgRvxGOOTfwnXW1ckUoJTnsPwo6/ZwonEnvDg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8395c88-24f3-46a3-7c78-08df2a811ca9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 05:56:48.8978 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 70fK4V/z6zLTm2/eEw/mwoYKeK7UZwrX2x7B7g7P4GRaj8atc2hpd4MCEAvxzlIbpEUzklyw0HvuzGAyPxXXtkmjTJfyFf/WDsShA2ueejU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR06MB8379
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

Correct the AST1040 A0 silicon revision ID from 0x81000000 to 0x80000000.=
=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/misc/aspeed_scu.h | 2 +-=0A=
 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h=0A=
index 904549465f..6482038f12 100644=0A=
--- a/include/hw/misc/aspeed_scu.h=0A=
+++ b/include/hw/misc/aspeed_scu.h=0A=
@@ -51,7 +51,7 @@ struct Aspeed2700SCUState {=0A=
 #define AST2600_A3_SILICON_REV   0x05030303U=0A=
 #define AST1030_A1_SILICON_REV   0x80010000U=0A=
 #define AST1060_A2_SILICON_REV   0xA0030000U=0A=
-#define AST1040_A0_SILICON_REV   0x81000000U=0A=
+#define AST1040_A0_SILICON_REV   0x80000000U=0A=
 #define AST2700_A1_SILICON_REV   0x06010103U=0A=
 #define AST2700_A2_SILICON_REV   0x06020103U=0A=
 =0A=
-- =0A=
2.53.0=0A=

