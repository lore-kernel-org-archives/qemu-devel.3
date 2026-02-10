Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E790CEA3F28
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 09:32:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpk5b-0003dN-I7; Tue, 10 Feb 2026 04:31:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vpk5R-0003ZE-72; Tue, 10 Feb 2026 04:31:14 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vpk5N-00041b-QY; Tue, 10 Feb 2026 04:31:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=brMgmTdhhdRARhsZZ4IfWIpSwIrGiJ8IGyhQ1oqXK7mBZzxf8WR/d8OTqKmSCE+mNG/rwCOPfeRKivI+NKkiAFKw51nxk47sGukw0fk7SeN0A0nUC3T9RGY1jFcRlJNH0iYCB41m5Hna9mNaHAa3AkYTcVVCLqC48yTl7o2Hse3sRcOwIFCarPQqZ2kGMFNX0sCjiGYDwpHCO9bpIkXKY8LKqgYP9oXLwCPIPOaJXE5cOlJgXU7F3n948uwbun/rGtPEiY+JMrTlSgricrWEDWp86Upvj/khxxnKT757URNmtuo32jhmN0ZlbdpnRQV8dJbh1PNyGKMMNRiFVY83Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IkJIVMHqEZICLE8xjcBLhnIo2/2J5eTr+6t/ljRcm9M=;
 b=ITHoSGsrTNZZ2CaD3BTuaGsJE3+ng5PT7I/PakSscNOfvIhyUOx2GfC5mc9/c27sWlrhSoyjRQ8d6OAU016rEZFyZVnuDIowud/jNePCqqFhqhEuKssopVIoKH29jmzcdeqSVK8EJvtIAGwVIg21KOZ9KCPo2u84tKpB7t0szDnn+CUEe4KJd8S3btba2hcb8Ykej2NFjH99cCev3PHY7GxKpekEku1wwUjDdzop/LzW9Sy3XXtPjedflVuOEpkrx54ygueM9ror2j4o4jlpKm1nAMEfvIQ52viw+9+m0or6WytisiD2DoULtBmzI8qxVD4x6zwHU5Oz+EuWnTXtYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IkJIVMHqEZICLE8xjcBLhnIo2/2J5eTr+6t/ljRcm9M=;
 b=Jui1A7Q+3Rs+bpuAc14G0omSfks7b8Jzc/mxT+N/guvHk+SP11HmMv7hGAswAGk+Va8qdindoYoOtUq03w2IeHx3UjdqeK/cdhiiU+WDJ9m5sz8T4RHDmt9d/kMQsf/Cx+yw/wQp5+SytDa8LCBv3CrTwV0kqN0Akq/kXIou+qKgcUoNzormx4z6IYJDOBUx3e280fGf8mau4utyPBeWPYG1p6SnW0wkfC7vfFxakf1EAb6bH9Opyrg26GGAxjdqEBDNMEgNUbRObPYlAf5uH9q9P2DuGkPXcH4ElkX1nBrcKXVfo6q76zLiXV47kgBp8nkmWr0OcYnW9HaQMOBmGw==
Received: from SEZPR06MB7619.apcprd06.prod.outlook.com (2603:1096:101:249::5)
 by PUZPR06MB5585.apcprd06.prod.outlook.com (2603:1096:301:e9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 09:30:59 +0000
Received: from SEZPR06MB7619.apcprd06.prod.outlook.com
 ([fe80::c8d3:efda:b73:f6a6]) by SEZPR06MB7619.apcprd06.prod.outlook.com
 ([fe80::c8d3:efda:b73:f6a6%5]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 09:30:59 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "kaeluno1@gmail.com"
 <kaeluno1@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v1 0/1] tests/functional: Enhance Aspeed AST2600 OTP validation
Thread-Topic: [PATCH v1 0/1] tests/functional: Enhance Aspeed AST2600 OTP
 validation
Thread-Index: AQHcmm/3dZ7lUhWfcUShRwdEChP33g==
Date: Tue, 10 Feb 2026 09:30:59 +0000
Message-ID: <20260210093058.1673887-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7619:EE_|PUZPR06MB5585:EE_
x-ms-office365-filtering-correlation-id: 69b568ca-70f0-4562-abbc-08de688719b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?604j/DfdiVUF9uKI9jz5nNYoyQBcN2RsI13EPzdFCl/4ysMeek4gghAla2?=
 =?iso-8859-1?Q?QxBIvdWuVvrqMSpmHBvm5nMWnjj7Oeac21nGcwLg185DBDggZiQpq1nFb6?=
 =?iso-8859-1?Q?ttzo2h2BkDK2a+Rd0KEdboCO8ATgarq/MMx0QgK54SSce1LqABhGzwySvt?=
 =?iso-8859-1?Q?Mr/4Tx25abU1ipNbVqweyrqdOA+ZnYojPpNxNuR65RaUb4jTt3KzcXLn4k?=
 =?iso-8859-1?Q?uEFkLtqA5WrsKd06N1mMHTQ90HuJ9L+5Jh63aiJTBuZy62qD45TLPJC22V?=
 =?iso-8859-1?Q?+ZsJoq23acLGg7GTZcDx3DM2z7RWr3zE7S51viBJdajX/iof3ySYW9Ffpe?=
 =?iso-8859-1?Q?pEooL43foc62EczcCseyHfTqlqBxANfgiqctpjI6Ngvgenhsg9Jb4CJSsb?=
 =?iso-8859-1?Q?6XtZMN7GflbVmoj0b1Gx3YbdsPSIxqfrlpTqapDAG6yrD69agvrWEOrz/o?=
 =?iso-8859-1?Q?hfBVZkbpSFNn3Ui7dIs93scGHyrbCIFtoMr5u3CXU/LY2j6w51z2+CkaVe?=
 =?iso-8859-1?Q?eZuLc9fhThDjsxbL+s4MV5l+Q7Y0KaNQMC0gOmUcmMxFYuGYd9/BzZwMjj?=
 =?iso-8859-1?Q?klbnO4S+7MIArIQLqpZeRYqB3nQrcu9UDwiLZ+xzQLZGyjHRIDbNGxeQRq?=
 =?iso-8859-1?Q?RBKJ0/36FV2FpwNJC8E9kZnKUF96SQZp8kRU3uRiE9sty3/Xfjz/D1Nlag?=
 =?iso-8859-1?Q?U8aNrvjfKJOpQVRfm6rn4p29n83/KxCTPWbyq6c1WTnzdveGUBNTeB5X14?=
 =?iso-8859-1?Q?8Ziu2yBNCve6TgaBZOuIvjejU3xHLGdZSxFxirOsF0D+ZszbJFDwRPdlXN?=
 =?iso-8859-1?Q?mDmmgYq2e2Y3yiYYQeqtAw/NQj4GTZcfzj6gU6UOUxFfEnKXiZh7AHXlH4?=
 =?iso-8859-1?Q?FiPPf5YFB3AaQak8O7qFfSvb+Ga9jJd1jdN9EojOER/KYgguaQBHDZq6+L?=
 =?iso-8859-1?Q?rtsWJdclKFN2E1aeX8stdou1dvzePWLmKwfCC/vUt3/+3ZKogiGNu5RsOO?=
 =?iso-8859-1?Q?IhJq6ZmnTlnFMcvAM5hKIk77YnnMXCAxGhE7QNIWMjPSyVH/4Z4UGCZOho?=
 =?iso-8859-1?Q?5s9pJ59oANFjngwJXU2nZO7wK65zYwpt8cUnwKQkQgds+E/OhX7BmyxY8Q?=
 =?iso-8859-1?Q?o2ICjUsPp+oOX024SH0UtDZdPycceM3uEH6f87sZ+r3B3XpRfJcleZ+AiG?=
 =?iso-8859-1?Q?GrVXMGg5tWJcn3aG22jR5wiD/3E/mb8PrwxsuBRbPeAbjMBL9/8QXNOJRe?=
 =?iso-8859-1?Q?uZUqei48RJGAyVUZTei+P6x57xlV+2hNPAfgl4y8u9mfqzjgMRknx73465?=
 =?iso-8859-1?Q?lVuW/dz3/0FVZ/zMKMJiDfXsd3jqd3oItqH+O0BeIGtRH5Yf/HudS4+fd9?=
 =?iso-8859-1?Q?zXB5wokUtRRBCYkwssyA2cMIXeroAdqoTi7yugbZCjMPi7rQHDed5z4kdu?=
 =?iso-8859-1?Q?wC+8fNM48lc64EdnNnpjiGmL3g74kqreimU3ez83VSS79m8QiDRA9PUCj5?=
 =?iso-8859-1?Q?j2IyEn3APWlDuV2Gm8XwVK2DvnfxUcNxTc1WmDbGKqwjWdvbsd2usDxAl9?=
 =?iso-8859-1?Q?Zomh4f8WcYA4Em8M/hDxTs19rT39Gq9fX6UQnqfxuEE8B4turT17qL21zL?=
 =?iso-8859-1?Q?f7AE0fb2jJTF712OqYz4GsqqLPwok8Ls4I12prnLLu2P50z4WCoDhAM5N7?=
 =?iso-8859-1?Q?Pj8EVU/dZm0x9sgjtQA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7619.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?uCj6mYNztEeyCDSbaX7cM897tgyUBKYF9lqeM0FHM0VXodyFTNEAxgv04z?=
 =?iso-8859-1?Q?hq+nN8ZQgai6PZZnATANvbYMW9lc/RebaAeQXsT2NNWiCGjwVle/yJAkPK?=
 =?iso-8859-1?Q?nEFd+z/jwVeBYNBfs6oTzn9k0+nzU7t+Y3wlJ7PUwmOtGvdeKInSONGJrR?=
 =?iso-8859-1?Q?Ubgkok6x/DlPiZN2400broEnX8lIvXq6Rgf57Knk49+oFnZYuGQe8MXlog?=
 =?iso-8859-1?Q?NMcwx2bw6sJdQE/4waGdeT4aEqgO8i4A4s4nWwlQagY6Ogo+SFc1+7S2n2?=
 =?iso-8859-1?Q?k3a3Dh92/WwSN4yExNOLi5WXPXOClEvyzO6c7ZQGEFDbUYVwl5u3vbZHOY?=
 =?iso-8859-1?Q?M8NGfGmv6PiTqUouvU2+7Wv6VO+7X3FL5kh43sKdEbqqDmwawcoQKoJVj6?=
 =?iso-8859-1?Q?BUfaYokdB2D6K+m0QX87sWjH5sqCW9vCs1svcjPgtcRgyvYCHLMArumvI5?=
 =?iso-8859-1?Q?176Xvtkbacd4di3aZcgWbb8yQu4NxPRUjz8JWdUFjAhenb8H6u9oGhBRcE?=
 =?iso-8859-1?Q?gg3aDilZ8sZnRBt6Qu+domtmmnfVWGtCRU7o4DkqWDFOhnNRVumCzhhrs9?=
 =?iso-8859-1?Q?b56yZ5j1288xdwXeYYaf7+I2tFJjqHGJ+Hr0jpsCAB3HEgc3UmCdYGdC3e?=
 =?iso-8859-1?Q?eZ6z9iBkXbaVNfP3XoRswLYv/S6apd0Y9acJFNBtRb9GwyIZm3vmi4SOHg?=
 =?iso-8859-1?Q?V3JQRSRRYFW8F/nbvEf3BogysHiTOR9Vib762cOsi1F2X/8zoMyFLQYo3v?=
 =?iso-8859-1?Q?W1/Rc+0oYgr9FRhoT315LQnns9JApsitGKaqNfJ6cIQwgC9iS24Pna0uy2?=
 =?iso-8859-1?Q?u4K6IApKEZphCcLvDKyth67vgdTQhDRFTTjwzkpqwfuqA6I6uoxLzeTSRT?=
 =?iso-8859-1?Q?8FwbUTelMTZZCScN0dLi8pY0RNod4g5iAI/0cL4cDjLQR9Qc5pA0JfytCn?=
 =?iso-8859-1?Q?AH1Cidm9My1VcoxL3AuevIyuuLUJRWprazP3tQPa60hMyCmX4ERG2RV9Sv?=
 =?iso-8859-1?Q?zBCNkqZG3kngfk2KC78KmI+klo3AmXNnJd9PFW4UWYTs1EEMDf4NO9jEwR?=
 =?iso-8859-1?Q?Jp91+DzT2vT68w1/SieWOTWqfm3QWKOM5UJbvizNWx7af0IPRlUOY4sXJq?=
 =?iso-8859-1?Q?kdFE26wpWTqJJETvz8Y6IbDZIGQ0LSDobWigC/VRhNNwtV0InHZvckMsYm?=
 =?iso-8859-1?Q?XnMKrGgpRWQch/Tq4MBbjV6zkZagazZDbzijRhj7ejpPosJhUnvLnMwY16?=
 =?iso-8859-1?Q?/KqtQT603xJ1BJk0Pfen3KXOHJvS+QlGZN+j/X8RFSJz6lepykUUPyalZ1?=
 =?iso-8859-1?Q?eKhLYVdaQ3HEo2DUhVnG5j7ycCCLQwAhdEf8AQzPRLgm4FiBUOEDevzcDE?=
 =?iso-8859-1?Q?ixaA3jGCE1432AG7bLK/3poGI6EH9uMbKqZ3UStNL2EHTf7mWTJjyRjbtN?=
 =?iso-8859-1?Q?cu+xBid8KvCA59RON47ZCAPjq4Qm+KZhtRtGWtdIBmERc+opeBWnUekdzS?=
 =?iso-8859-1?Q?g+Pwj2edfpEVFIOhdjJ4issAFAJFuxnNdasZ78dHXeg+1RY/MTaD2oAJvb?=
 =?iso-8859-1?Q?Fb8avC9LaY2INsXyHhSgT5l1NHs7m91QpVqMM9kRTYkaHj/7kGGbsuzCyy?=
 =?iso-8859-1?Q?ufU14hA6HEaIs+phby1tNbHw2++zmEoSK8TNcJHFYRTR2DjoOIl9SeYOQB?=
 =?iso-8859-1?Q?TD9WtqzIgyxi5NcD3u3UEbZjXkxdTSPJMMej6GeRqi93mvk941H6OFLRxU?=
 =?iso-8859-1?Q?oC4w+Ee8HerDq14ft1KwmmcmhiulV+Uutph+MablPtkJqFn01jrGJur961?=
 =?iso-8859-1?Q?7h+L+J8YIA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7619.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69b568ca-70f0-4562-abbc-08de688719b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 09:30:59.3878 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pc2mmqqhUQQfxtRK/VN0jNtFwEPM+bR6BwypXqI8k7OlYSEYnCRQ+fCYTMWMuB8Yohc+yW9W//ND9qdw9YHle5QoraWk/Ewr8pYssmidgss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5585
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=kane_chen@aspeedtech.com;
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

Hi all,=0A=
=0A=
This series enhances the AST2600 OTP functional test by introducing=0A=
cross-stage verification. While the previous test focused on basic=0A=
system boot-up, this update ensures OTP data persistence and=0A=
correctness through various execution environments (U-Boot and Linux).=0A=
=0A=
The updated test logic implements the following flow:=0A=
1. Boot into U-Boot and modify OTP strap settings via CLI.=0A=
2. Boot into Linux to verify the consistency of these settings.=0A=
3. Trigger a reboot to ensure that OTP configurations persist back =0A=
   into the U-Boot stage.=0A=
=0A=
Note: This series is based on the aspeed-next branch.=0A=
=0A=
Any feedback or suggestions are appreciated.=0A=
=0A=
Best Regards,=0A=
Kane=0A=
---=0A=
Kane-Chen-AS (1):=0A=
  tests/functional/arm/aspeed_ast2600: Enhance OTP test with functional=0A=
    validation=0A=
=0A=
 .../arm/test_aspeed_ast2600_sdk_otp.py        | 35 ++++++++++++++++---=0A=
 1 file changed, 31 insertions(+), 4 deletions(-)=0A=
=0A=
-- =0A=
2.43.0=0A=

