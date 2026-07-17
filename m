Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9606FC44515
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 08:49:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkeDI-0000cc-BL; Fri, 17 Jul 2026 04:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wkeDF-0000Ya-Aw; Fri, 17 Jul 2026 04:46:29 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wkeDC-0003vC-Tx; Fri, 17 Jul 2026 04:46:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q3h/jdYnJTsYi49qf/YJh5AZhGsA0xCFOXLYZlTgaDGmwub8s6qjKbKZYPGuLYSkILpEPp1b5iYMzdjfqRqGYn8/e52Uzsb1J3iE35yzW9h6pdCaD1jU60DvaCcP2VHq+4y66863bBTQY2jJ+nQ2E5jmB7AhHDq2J5nDD4aqwPj+wm8G4XK1rUFrArcOB4SUTxespKJgO6c/p5ITJiiKmactLZis3WYUAmmqbxXJoGBBMiCkZqM7pPpi8El83Pu63sRhWD8FhK9kS8QYf4Xkr5LBvNhAwWxZQn+HNXzvLcrKRhk1c74Nt9TeFu5rkcfXH+tUGa2u1xEJu+H5eFA8gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=08UIiginG1nL5wq+OdaaIs8PxlwWCdsb3XgO18Lvb58=;
 b=UUAU7TqJT/8O4yOi3gRlavo3xe+g/6wXKo41XxIFLan+g6uZmgrG6eai3v8u0Ili4jC+uEV8edfCJkXc6xPNPobNJnqLtVLWt5gXNhpbvak1747COyZZt5Ac9iZWcQUEsBvy/FUxoi/j4EO2Tf3z9+0ipk6dpzhAMjFYyBJ5GgcrhJAyQ8yDBaiReitDk0rHEKRSTfkODc0qebTTEsniwR0l4Ujzz8Swcj46xldPx06PA7FvWHyF2u1M0KHcq9YAPOui+2YPVPmt3rhsJ7S+YgJBzcLqnUQjpgRT8nyaXssJj/iESC/EEBdLF8XVMuMP4XAGHnit3bAr9E7zeT9p6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=08UIiginG1nL5wq+OdaaIs8PxlwWCdsb3XgO18Lvb58=;
 b=paO0JKokg+EsrVV1tJKgBXTf6Tf5RF3wfpi01smWDWlj9zg1y75HsftfcsXGd9AE7dV2ICLCUCveGnR2MC2NoyVkrziI/LNxz4omUEgnSVQ5idfpr9bTPc31NG6Q++AFUcwQot38q/FgluIZyaU0KIFyMWU2tKFar8kcT1uKSCJiiUfcsIQE7UKKJTnfaYK7r0uEpsCy7obmNfjf22Bb1cUyx1ETeysdMvocjO6FXR9PVqKldB4eW+mcMUZOo2uF9pbYbwTFcMOVZwRxU1kF6Fh9j3pNVNrcarrXa3fiyqlBUuknyuM9bxQM1xuiKq0En3/j6er3TVFurA7B6txROw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KUZPR06MB8267.apcprd06.prod.outlook.com (2603:1096:d10:63::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 08:46:11 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 08:46:11 +0000
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
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 8/9] hw/ssi/aspeed_smc: Add Data FIFO-based flash access
 support for AST2700
Thread-Topic: [PATCH v4 8/9] hw/ssi/aspeed_smc: Add Data FIFO-based flash
 access support for AST2700
Thread-Index: AQHdFci3q3btou94FE2nN3wpBynYPA==
Date: Fri, 17 Jul 2026 08:46:11 +0000
Message-ID: <20260717084559.3477061-9-jamin_lin@aspeedtech.com>
References: <20260717084559.3477061-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260717084559.3477061-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|KUZPR06MB8267:EE_
x-ms-office365-filtering-correlation-id: 059e56c1-6f2c-4fe0-86cc-08dee3dfda24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|7416014|376014|921020|22082099003|18002099003|38070700021|56012099006|10067099003;
x-microsoft-antispam-message-info: O9Q/CVpjAkyEnFf5UjQhwEFHP9r806ye4EoV7AF6zkEamnBHZ649T1HUVzI5/wpYesL7tBz4amIps9DY5HByBKXakoEB5kupNr12kA7bROEwcfHeEuolOkn+pLltKbpbeC+sH9RJe6sTdePgPiUh3vdf8XszfpLdhhXNN1uxZWTmxoIlaNkolrS3nsfY2zoMi2+y1rfgPDWBSzFcH26e0kDPMbnqKNN5l3DVctwMAcVJ4gB9+7PmUTj/NOYb1ndZJumhcmh9lz86819xK/p8kYB4MqqKMuBMETdfq8r/+gHggYx4emdzmMCvKRjuLD0llZOsTBwCvL+UxbxL3ctUTMDEAxo+JpJ8qTjU9DgpS3njLpPc8B6bEXcsDUWCQfHyJMuY6oESUexMFuBNj6Zq9WuRJbdAya2CJHxUqxT2crZA80oVs+kVjRRf7YGa6B46MF6+tB+kfaWaf1mtPu+LF660kZDNcvnk5m6SsfdW5KB2Ak8Rfwb42o2H6uVoSPUkNXM/aX4zz9vlQRVY0+Jf95nSna7CKkuEJYYVS6xqLFJwr8mn7bcq3gfKp/SZNwu5xD3j03TIdsXba1bB4InECkcIq1cRm122iIib4HUQqvYflsuyoWsnb7fLUVA9Tu/DKp2MvFte7jNf7kHT9YbRfaXzzNqqNWuPHQfDyGwgtHTpTJH7WeRbOltpJOa6QFcq9fzodCuY2aU0s0YYQuOXlIlF5eOMr8slJ+dojFCrfPvlTN6ytMIVHiLBVLnGGRQ6
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(921020)(22082099003)(18002099003)(38070700021)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3iRiQ3PrBO/dUa7I1zb8yfgRVMogYND+r0N2mt0VJrGZnXZXuVG0ihi+jL?=
 =?iso-8859-1?Q?OXlGUgM6I7UYFBKzlcvReogxC6F7KNhH8GTXV0ee0xcERS+aOMUcZhXPJJ?=
 =?iso-8859-1?Q?YE4TP1TLlvQcgoUBQ5nvX06gEaPqLbhyxNj8QHbPwDni9pjSxYOzaiY3H5?=
 =?iso-8859-1?Q?/36saqJWIl4jc5myUJ2AJKFsIRZFUiE1urJclzxNDaQFfPaxXn/DukWoxI?=
 =?iso-8859-1?Q?tBAuxQdeGDlKpYr9DX2oM4ucI4eS/fknnGN1ze+8Q1aYDahiIDU5hG08hY?=
 =?iso-8859-1?Q?B4YdoNYZOyPo4i+71szdVHeAlSZIHSgBhs1eZJ0GBDaOQ0oNG6LMH0cH0W?=
 =?iso-8859-1?Q?izVC22SWi3gVrwgjVNOuCIflXa4/v2IjzaLPGxlp9ptWYez4m7Vkqhufp7?=
 =?iso-8859-1?Q?ApVm7T74bpVLU6EmBnf17HotE21vQ0UUqd2USbREazZUTQXlwmy6qaaU+W?=
 =?iso-8859-1?Q?UzM8TQRIXZ6zOror/VWBj0Cc11se4gk+ZWHu/GDB8Im9yL6xMIknD2VYjO?=
 =?iso-8859-1?Q?5UTuzA+WlP08Ez8ihgZXofPjMEYzU7IJvpyi5I7F2vJmVuzgTINCOqkaam?=
 =?iso-8859-1?Q?HXGGqmpMKlfoM+8ip+XBkpi5s55255KthVplCNMqST2uI27BOS9NZLPyJH?=
 =?iso-8859-1?Q?LsJnP9cuVrG/chZ2axNqkPjFGEtZlS1JzuLa3ynhxmnp/24p9lMpRNF1MZ?=
 =?iso-8859-1?Q?IxpD4IYINf/4hH2jkLN43utQcqu/iJLzBUwlTHY0TMM9pqUyKtLRy03Stt?=
 =?iso-8859-1?Q?8+DZRiTmJp4qd/GcVnO1BP9OCitb1aR8ICF5Z3xXv/bHB0LdPGzkDKgLU4?=
 =?iso-8859-1?Q?OVUhulKlEvnGTCFH9EwSyH3yBN9tQ59iqP0cnk6WgHYPriZaHzvBg2ynaO?=
 =?iso-8859-1?Q?SFOnsf0TG0IQzs4KDfx1haWbFdl9Z9zeRdpvekpP5O3IqZPI+HvgudHUzH?=
 =?iso-8859-1?Q?oxw6Emr35atTMI68K2+Fw5vuYhfoLxHP7efO+A6rfsaFFcGY1kBIDXagzm?=
 =?iso-8859-1?Q?RVseCjcRu1FYFZC8widVHbUenq8MQAajSu7yR8yJCWyAH7xpr56sXZFPHc?=
 =?iso-8859-1?Q?PHbRiqR1kWD328I5u+2xG+j7gJHiwblE2tV2e7NPubTJC2O34GMfMjN4Ju?=
 =?iso-8859-1?Q?EancGXNpPgpoviFJ4biR3vmEpIZkILfInar6Vl5kj4PutvOq9SjxN+7uwW?=
 =?iso-8859-1?Q?1c9zJWxt4Uxm6Kj9gq0aIVkgz5QK6PyX20CYakvQQxWu4eMFW4wrme7jNB?=
 =?iso-8859-1?Q?P+etYoLWgkTxHq7ry7gxL6+uCPiozLCtipqoa35FinAHlz9EsQrV45bQow?=
 =?iso-8859-1?Q?YuwivQgSBP0A5500XtSugalWBbk67VbSXXd+GeWFJ64CHVSkXIdfbnSbXb?=
 =?iso-8859-1?Q?p5tDcNlyaDxyerQhMgTUqyYZBDFA4BTGjY1jlIefKYogi144H8m7Hgl5Ej?=
 =?iso-8859-1?Q?k7/0xOFCEC+w9VX5UcMFVX1bg/3KDENer/RZggsWy3Pkrq/toUlICxVXIE?=
 =?iso-8859-1?Q?mxr8Lsk7nUVKQxhTKhoEPI/8HANS2mXvUArg0t+22rOe9NwfzCZWkUyrHQ?=
 =?iso-8859-1?Q?XgRYyAPmKA8F5/piQqF2D13q6F0YrlR/hb9nXyQcoVHuLAQQ6UsCVWCH3i?=
 =?iso-8859-1?Q?i+P3BLofQdbtvd16C60MTb8eVFRjpGBisr99kK7m+oyqUz2X7DF/eRxyDH?=
 =?iso-8859-1?Q?7U4YJA6NEE6q1/16GuetzEFwkKJFep9/23yGEDE0GraEcMsf1ptu3ivvh7?=
 =?iso-8859-1?Q?CG1ilrdN8d34pM0rxfDTL7DOsxdpG3+3ycRE1Rsi4k+Jk4D+6P2SFN9gPG?=
 =?iso-8859-1?Q?b9s/bWLc+Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: FhBACU8ANLvfNYThS8jHiQlxXTDLaij4tQOv+0cXSTFoBdJlmkMDnAUqjzCRWb+c3zCvz4hFqt31P0aFAbrDc2ie3AlCjONsCiXMxJ/M5DwiFxSjReGqn/+oTIhBARmJ8ZuR41++A12MhPzc/vk2b7mPgp2/0e30JPZg/aygHTP6g2CWWSQhKDZZyZcEjzi6zeNCfoy/1Nvv0WZ00YR4VeZ+R/MqOrs79K0QZuaHEwbwvSazrj+S4l/0G6UccgHvMDKXrz1is6OPt5c6lS01xpGhitZIjyXovyMxUeAU6xzRvvwIQq6qrBIPCrYBzeMnBV858Ph9ckXHBWKTQPQHUg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 059e56c1-6f2c-4fe0-86cc-08dee3dfda24
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 08:46:11.0128 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uOaCbIl8HO2/UfCZbYmYM8/eeWD2wv68MWS9UWtT8etYNRrUJduh8ok+wsoS1oEebShbW+7PFo/s+edUk+ota/5VDKrao5Rj9Vdvz+C0b7Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR06MB8267
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

AST2700 supports a Data FIFO mode where flash accesses can be performed=0A=
directly through Data FIFO MMIO offsets. The Data FIFO start offset=0A=
increments by one for every 16MB of flash address space, allowing the=0A=
chip select (CS) to be decoded from the Data FIFO offset.=0A=
=0A=
This change adds Data FIFO support to the Aspeed SMC model and introduces=
=0A=
a class callback to translate Data FIFO offsets into CS indices. For=0A=
AST2700, the Data FIFO offset is matched against the segment start address=
=0A=
of each CS to determine the target flash device.=0A=
=0A=
The SMC register region size (nregs) is also extended dynamically=0A=
based on the number of supported chip selects to cover all possible=0A=
Data FIFO regions.=0A=
=0A=
This breaks migration compatibility with older QEMU builds for the=0A=
affected models, even though Aspeed machines are not officially=0A=
covered by migration compatibility guarantees.=0A=
=0A=
Bump version_id to 4 and minimum_version_id to 2 to reflect the=0A=
incompatible format.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
Tested-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
---=0A=
 include/hw/ssi/aspeed_smc.h |   3 +-=0A=
 hw/ssi/aspeed_smc.c         | 117 +++++++++++++++++++++++++++++++++---=0A=
 2 files changed, 109 insertions(+), 11 deletions(-)=0A=
=0A=
diff --git a/include/hw/ssi/aspeed_smc.h b/include/hw/ssi/aspeed_smc.h=0A=
index a273365689..5f391fc24e 100644=0A=
--- a/include/hw/ssi/aspeed_smc.h=0A=
+++ b/include/hw/ssi/aspeed_smc.h=0A=
@@ -47,7 +47,7 @@ struct AspeedSMCFlash {=0A=
 #define TYPE_ASPEED_SMC "aspeed.smc"=0A=
 OBJECT_DECLARE_TYPE(AspeedSMCState, AspeedSMCClass, ASPEED_SMC)=0A=
 =0A=
-#define ASPEED_SMC_R_MAX        (0x100 / 4)=0A=
+#define ASPEED_SMC_R_MAX        (0x300 / 4)=0A=
 #define ASPEED_SMC_CS_MAX       5=0A=
 =0A=
 struct AspeedSMCState {=0A=
@@ -114,6 +114,7 @@ struct AspeedSMCClass {=0A=
                            AspeedSegments *seg);=0A=
     void (*dma_ctrl)(AspeedSMCState *s, uint32_t value);=0A=
     int (*addr_width)(const AspeedSMCState *s);=0A=
+    int (*data_fifo_offset_to_cs)(const AspeedSMCState *s, uint32_t offset=
);=0A=
     const MemoryRegionOps *reg_ops;=0A=
 };=0A=
 =0A=
diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c=0A=
index c8cc6cfa56..bf596f7b2d 100644=0A=
--- a/hw/ssi/aspeed_smc.c=0A=
+++ b/hw/ssi/aspeed_smc.c=0A=
@@ -163,6 +163,9 @@=0A=
 /* Read Timing Compensation Register */=0A=
 #define R_TIMINGS         (0x94 / 4)=0A=
 =0A=
+/* Data fifo */=0A=
+#define R_DATA_FIFO       (0x200 / 4)=0A=
+=0A=
 /* SPI controller registers and bits (AST2400) */=0A=
 #define R_SPI_CONF        (0x00 / 4)=0A=
 #define   SPI_CONF_ENABLE_W0   0=0A=
@@ -209,6 +212,7 @@ static const AspeedSegments aspeed_2500_spi2_segments[]=
;=0A=
 #define ASPEED_SMC_FEATURE_DMA_GRANT 0x2=0A=
 #define ASPEED_SMC_FEATURE_WDT_CONTROL 0x4=0A=
 #define ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH 0x08=0A=
+#define ASPEED_SMC_FEATURE_DATA_FIFO 0x10=0A=
 =0A=
 static inline bool aspeed_smc_has_dma(const AspeedSMCClass *asc)=0A=
 {=0A=
@@ -225,6 +229,11 @@ static inline bool aspeed_smc_has_dma64(const AspeedSM=
CClass *asc)=0A=
     return !!(asc->features & ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH);=0A=
 }=0A=
 =0A=
+static inline bool aspeed_smc_has_data_fifo(const AspeedSMCClass *asc)=0A=
+{=0A=
+    return !!(asc->features & ASPEED_SMC_FEATURE_DATA_FIFO);=0A=
+}=0A=
+=0A=
 #define aspeed_smc_error(fmt, ...)                                      \=
=0A=
     qemu_log_mask(LOG_GUEST_ERROR, "%s: " fmt "\n", __func__, ## __VA_ARGS=
__)=0A=
 =0A=
@@ -664,6 +673,7 @@ static MemTxResult aspeed_smc_read(void *opaque, hwaddr=
 addr, uint64_t *data,=0A=
 {=0A=
     AspeedSMCState *s =3D ASPEED_SMC(opaque);=0A=
     AspeedSMCClass *asc =3D ASPEED_SMC_GET_CLASS(opaque);=0A=
+    int cs;=0A=
 =0A=
     addr >>=3D 2;=0A=
 =0A=
@@ -689,6 +699,18 @@ static MemTxResult aspeed_smc_read(void *opaque, hwadd=
r addr, uint64_t *data,=0A=
         trace_aspeed_smc_read(addr << 2, size, s->regs[addr]);=0A=
 =0A=
         *data =3D s->regs[addr];=0A=
+    } else if (aspeed_smc_has_data_fifo(asc) && addr >=3D R_DATA_FIFO) {=
=0A=
+        cs =3D asc->data_fifo_offset_to_cs(s, addr << 2);=0A=
+        if (cs >=3D 0) {=0A=
+            /*=0A=
+             * Data fifo mode only supports SPI user mode.=0A=
+             * The flash address is provided by the SPI command/address cy=
cles,=0A=
+             * the MMIO addr parameter is ignored.=0A=
+             */=0A=
+            return aspeed_smc_flash_read(&s->flashes[cs], 0, data, size, a=
ttrs);=0A=
+        }=0A=
+        aspeed_smc_error("Invalid data fifo offset %" HWADDR_PRIx, addr <<=
 2);=0A=
+        return MEMTX_ERROR;=0A=
     } else {=0A=
         qemu_log_mask(LOG_UNIMP, "%s: not implemented: 0x%" HWADDR_PRIx "\=
n",=0A=
                       __func__, addr);=0A=
@@ -1063,6 +1085,19 @@ static MemTxResult aspeed_smc_write(void *opaque, hw=
addr addr, uint64_t data,=0A=
     } else if (aspeed_smc_has_dma(asc) && aspeed_smc_has_dma64(asc) &&=0A=
                addr =3D=3D R_DMA_DRAM_ADDR_HIGH) {=0A=
         s->regs[addr] =3D DMA_DRAM_ADDR_HIGH(value);=0A=
+    } else if (aspeed_smc_has_data_fifo(asc) && addr >=3D R_DATA_FIFO) {=
=0A=
+        int cs =3D asc->data_fifo_offset_to_cs(s, addr << 2);=0A=
+        if (cs >=3D 0) {=0A=
+            /*=0A=
+             * Data fifo mode only supports SPI user mode.=0A=
+             * The flash address is provided by the SPI command/address cy=
cles,=0A=
+             * the MMIO addr parameter is ignored.=0A=
+             */=0A=
+            return aspeed_smc_flash_write(&s->flashes[cs], 0, data, size,=
=0A=
+                                          attrs);=0A=
+        }=0A=
+        aspeed_smc_error("Invalid data fifo offset %" HWADDR_PRIx, addr <<=
 2);=0A=
+        return MEMTX_ERROR;=0A=
     } else {=0A=
         qemu_log_mask(LOG_UNIMP, "%s: not implemented: 0x%" HWADDR_PRIx "\=
n",=0A=
                       __func__, addr);=0A=
@@ -1183,8 +1218,8 @@ static void aspeed_smc_realize(DeviceState *dev, Erro=
r **errp)=0A=
 =0A=
 static const VMStateDescription vmstate_aspeed_smc =3D {=0A=
     .name =3D "aspeed.smc",=0A=
-    .version_id =3D 3,=0A=
-    .minimum_version_id =3D 1,=0A=
+    .version_id =3D 4,=0A=
+    .minimum_version_id =3D 2,=0A=
     .fields =3D (const VMStateField[]) {=0A=
         VMSTATE_UINT32_ARRAY(regs, AspeedSMCState, ASPEED_SMC_R_MAX),=0A=
         VMSTATE_UNUSED_V(2, 2), /* was snoop_index/snoop_dummies */=0A=
@@ -1808,6 +1843,39 @@ static void aspeed_2700_smc_reg_to_segment(const Asp=
eedSMCState *s,=0A=
     }=0A=
 }=0A=
 =0A=
+/*=0A=
+ * Convert a data fifo offset to a chip select (CS).=0A=
+ *=0A=
+ * Data fifo access starts at 0x200. The data fifo offset index is=0A=
+ * calculated by subtracting the data fifo base offset from the MMIO addre=
ss.=0A=
+ *=0A=
+ * The data fifo offset index increments by 1 for every 16MB of flash addr=
ess=0A=
+ * space. Each offset step therefore represents a 16MB address decode rang=
e.=0A=
+ *=0A=
+ * The CS is determined by matching the data fifo offset index against the=
=0A=
+ * segment start address of each CS.=0A=
+ *=0A=
+ * Returns the CS index on success, or -1 if the offset is invalid.=0A=
+ */=0A=
+static int aspeed_2700_smc_data_fifo_offset_to_cs(const AspeedSMCState *s,=
=0A=
+                                                  uint32_t offset)=0A=
+{=0A=
+    AspeedSMCClass *asc =3D ASPEED_SMC_GET_CLASS(s);=0A=
+    uint32_t start_offset;=0A=
+    uint32_t fifo_offset;=0A=
+    int i;=0A=
+=0A=
+    for (i =3D 0; i < asc->cs_num_max; i++) {=0A=
+        start_offset =3D (s->regs[R_SEG_ADDR0 + i] & 0x0000ffff) << 16;=0A=
+        fifo_offset =3D start_offset / 0x1000000;=0A=
+        if (fifo_offset =3D=3D offset - (R_DATA_FIFO << 2)) {=0A=
+            return i;=0A=
+        }=0A=
+    }=0A=
+=0A=
+    return -1;=0A=
+}=0A=
+=0A=
 static const uint32_t aspeed_2700_fmc_resets[ASPEED_SMC_R_MAX] =3D {=0A=
     [R_CONF] =3D (CONF_FLASH_TYPE_SPI << CONF_FLASH_TYPE0 |=0A=
             CONF_FLASH_TYPE_SPI << CONF_FLASH_TYPE1),=0A=
@@ -1842,6 +1910,27 @@ static const AspeedSegments aspeed_2700_fmc_segments=
[] =3D {=0A=
     { 0x0, 0 }, /* disabled */=0A=
 };=0A=
 =0A=
+/*=0A=
+ * AST2700 supports data fifo mode with a base data fifo start offset of 0=
x200.=0A=
+ *=0A=
+ * The data fifo start offset increments by 1 for every 16MB of flash addr=
ess=0A=
+ * space. Each offset step therefore represents a 16MB address decode rang=
e.=0A=
+ *=0A=
+ * Assuming each chip select (CS) can use the maximum flash size of 256MB:=
=0A=
+ *   256MB / 16MB =3D 0x10 offset steps per CS.=0A=
+ *=0A=
+ * Data fifo start offset for CSn:=0A=
+ *   0x200 + (n * 0x10)=0A=
+ *=0A=
+ * Examples:=0A=
+ *   CS0: 0x200=0A=
+ *   CS1: 0x210=0A=
+ *   CS2: 0x220=0A=
+ *   CS3: 0x230=0A=
+ *=0A=
+ * asc->nregs should be set to: 0x200 + (asc->cs_num_max * 0x10)=0A=
+ * to cover all possible data fifo regions.=0A=
+ */=0A=
 static void aspeed_2700_fmc_class_init(ObjectClass *klass, const void *dat=
a)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
@@ -1861,14 +1950,16 @@ static void aspeed_2700_fmc_class_init(ObjectClass =
*klass, const void *data)=0A=
     asc->flash_window_base =3D 0x100000000;=0A=
     asc->flash_window_size =3D 1 * GiB;=0A=
     asc->features          =3D ASPEED_SMC_FEATURE_DMA |=0A=
-                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH;=0A=
+                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH |=0A=
+                             ASPEED_SMC_FEATURE_DATA_FIFO;=0A=
     asc->dma_flash_mask    =3D 0x2FFFFFFC;=0A=
     asc->dma_dram_mask     =3D 0xFFFFFFFC;=0A=
     asc->dma_start_length  =3D 1;=0A=
-    asc->nregs             =3D ASPEED_SMC_R_MAX;=0A=
+    asc->nregs             =3D (0x200 + (asc->cs_num_max * 0x10)) >> 2;=0A=
     asc->segment_to_reg    =3D aspeed_2700_smc_segment_to_reg;=0A=
     asc->reg_to_segment    =3D aspeed_2700_smc_reg_to_segment;=0A=
     asc->dma_ctrl          =3D aspeed_2600_smc_dma_ctrl;=0A=
+    asc->data_fifo_offset_to_cs =3D aspeed_2700_smc_data_fifo_offset_to_cs=
;=0A=
     asc->reg_ops           =3D &aspeed_2700_smc_flash_ops;=0A=
 }=0A=
 =0A=
@@ -1896,14 +1987,16 @@ static void aspeed_2700_spi0_class_init(ObjectClass=
 *klass, const void *data)=0A=
     asc->flash_window_base =3D 0x180000000;=0A=
     asc->flash_window_size =3D 1 * GiB;=0A=
     asc->features          =3D ASPEED_SMC_FEATURE_DMA |=0A=
-                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH;=0A=
+                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH |=0A=
+                             ASPEED_SMC_FEATURE_DATA_FIFO;=0A=
     asc->dma_flash_mask    =3D 0x2FFFFFFC;=0A=
     asc->dma_dram_mask     =3D 0xFFFFFFFC;=0A=
     asc->dma_start_length  =3D 1;=0A=
-    asc->nregs             =3D ASPEED_SMC_R_MAX;=0A=
+    asc->nregs             =3D (0x200 + (asc->cs_num_max * 0x10)) >> 2;=0A=
     asc->segment_to_reg    =3D aspeed_2700_smc_segment_to_reg;=0A=
     asc->reg_to_segment    =3D aspeed_2700_smc_reg_to_segment;=0A=
     asc->dma_ctrl          =3D aspeed_2600_smc_dma_ctrl;=0A=
+    asc->data_fifo_offset_to_cs =3D aspeed_2700_smc_data_fifo_offset_to_cs=
;=0A=
     asc->reg_ops           =3D &aspeed_2700_smc_flash_ops;=0A=
 }=0A=
 =0A=
@@ -1930,14 +2023,16 @@ static void aspeed_2700_spi1_class_init(ObjectClass=
 *klass, const void *data)=0A=
     asc->flash_window_base =3D 0x200000000;=0A=
     asc->flash_window_size =3D 1 * GiB;=0A=
     asc->features          =3D ASPEED_SMC_FEATURE_DMA |=0A=
-                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH;=0A=
+                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH |=0A=
+                             ASPEED_SMC_FEATURE_DATA_FIFO;=0A=
     asc->dma_flash_mask    =3D 0x2FFFFFFC;=0A=
     asc->dma_dram_mask     =3D 0xFFFFFFFC;=0A=
     asc->dma_start_length  =3D 1;=0A=
-    asc->nregs             =3D ASPEED_SMC_R_MAX;=0A=
+    asc->nregs             =3D (0x200 + (asc->cs_num_max * 0x10)) >> 2;=0A=
     asc->segment_to_reg    =3D aspeed_2700_smc_segment_to_reg;=0A=
     asc->reg_to_segment    =3D aspeed_2700_smc_reg_to_segment;=0A=
     asc->dma_ctrl          =3D aspeed_2600_smc_dma_ctrl;=0A=
+    asc->data_fifo_offset_to_cs =3D aspeed_2700_smc_data_fifo_offset_to_cs=
;=0A=
     asc->reg_ops           =3D &aspeed_2700_smc_flash_ops;=0A=
 }=0A=
 =0A=
@@ -1964,14 +2059,16 @@ static void aspeed_2700_spi2_class_init(ObjectClass=
 *klass, const void *data)=0A=
     asc->flash_window_base =3D 0x280000000;=0A=
     asc->flash_window_size =3D 1 * GiB;=0A=
     asc->features          =3D ASPEED_SMC_FEATURE_DMA |=0A=
-                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH;=0A=
+                             ASPEED_SMC_FEATURE_DMA_DRAM_ADDR_HIGH |=0A=
+                             ASPEED_SMC_FEATURE_DATA_FIFO;=0A=
     asc->dma_flash_mask    =3D 0x0FFFFFFC;=0A=
     asc->dma_dram_mask     =3D 0xFFFFFFFC;=0A=
     asc->dma_start_length  =3D 1;=0A=
-    asc->nregs             =3D ASPEED_SMC_R_MAX;=0A=
+    asc->nregs             =3D (0x200 + (asc->cs_num_max * 0x10)) >> 2;=0A=
     asc->segment_to_reg    =3D aspeed_2700_smc_segment_to_reg;=0A=
     asc->reg_to_segment    =3D aspeed_2700_smc_reg_to_segment;=0A=
     asc->dma_ctrl          =3D aspeed_2600_smc_dma_ctrl;=0A=
+    asc->data_fifo_offset_to_cs =3D aspeed_2700_smc_data_fifo_offset_to_cs=
;=0A=
     asc->reg_ops           =3D &aspeed_2700_smc_flash_ops;=0A=
 }=0A=
 =0A=
-- =0A=
2.43.0=0A=

