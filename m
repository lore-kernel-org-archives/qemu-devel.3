Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A8DAC5DF87
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 03:22:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxFoU-00013n-72; Thu, 20 Aug 2026 23:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wxFoS-00012t-HD; Thu, 20 Aug 2026 23:21:00 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wxFoQ-0004BJ-Bb; Thu, 20 Aug 2026 23:21:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LmnP0kkR87L2H9dyE5rFCzVZ4b8C5bxQ4MYabIURRLjaB5DerDTLOWs8zcHrSFrMUJUOzcj9+l5bKwbeYTVly4jBIwlZ8wCx1JI4m/HoqNea/vhekBaoz/gQ008e0Dpz8TkHbzvTWkVfJU3PBb0pbFMtp0wlswUmnuYLJ23oe4HX0fVwNhx88YPXBZD4FD/r22clzTaeJkMGliXXU2D1Cza3ml1+Z9XDVMdgfxsWk5NCkTB8neDKZ2sONLW1A321HuCHlJKVuXN+T7O6YMERZN1kutjCf4k5hmGF9aK0mfQSXZsd+7fQ0B5DbfSvPupSXHOdq6q50X8nMm1qbIXygw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ly/COslt995cMfTRFT2y5Hq+NlO4rCGv7moCdE2KUe0=;
 b=ntBjBIojoTg7lkgPu939kZjECPD/V1SyC15GLWfbT5ViuoR+jRMZ7ygv8QFABx2F3tGjX15SCn43QtaTbejaMysdfgJC+7wm520430C/mj91ggv5IjHPJDyQvBWAYuyuUbwFwv1zsusadILB03oxtCnl1f+r8ZsytMC5Fxr+jgy3R1h3tANBHdFcapZH7bujP73SOa0IqasCXMUZQ+Aj0Hl++gRu8nq8u3Unx3pPpjSuR4lDhiq2cTVPT2G6atAml1HuRcLaXWKjVQc4nrRwKCcx6EGjPZivwwIH2cDAP7zZFenCd+mwQp2I4uIXJ9NYVCPrmsSnF3/guOft0ldoMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ly/COslt995cMfTRFT2y5Hq+NlO4rCGv7moCdE2KUe0=;
 b=V6VYFU5ijMGqzMTmZ9YGyOpO1oAeWROhIR6SOaW0lsaomNliPAejUXACbEizmhFZPRvgtYN5JYwNEfkrnRjVTIBJBQY8iBFzWOA/tuGVZsjR22fDmr9RM+t2hzRYK4cpDF2KtRcGXMUggZxDFaYBVHlzPWB5aYLz7rjc/K9LI8Pu6F2eyvbeMVlc4rGd2ECEaT5pLBLzPZGDFx7KHo19JvzykR35PZbvwyIA5aXfbTk4NiNbz6gZwrt1PsqY/BYZxlYN6/vF3UKuh3Eyhrk0B6RzvGyXs4zpf5XMMwCQH2jtemjnytzRUx7NFtttPwhbE8Xn57QL/Awfs8zGUVJPSA==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEYPR06MB5467.apcprd06.prod.outlook.com (2603:1096:101:b6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 03:20:46 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0339.008; Fri, 21 Aug 2026
 03:20:46 +0000
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
Subject: [PATCH v2 6/9] hw/misc/aspeed_sbc: Support the ECDSA verify command
Thread-Topic: [PATCH v2 6/9] hw/misc/aspeed_sbc: Support the ECDSA verify
 command
Thread-Index: AQHdMRwNmhQLMiKaYE2bTBPSMg5AbQ==
Date: Fri, 21 Aug 2026 03:20:45 +0000
Message-ID: <20260821032036.1829294-7-jamin_lin@aspeedtech.com>
References: <20260821032036.1829294-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260821032036.1829294-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SEYPR06MB5467:EE_
x-ms-office365-filtering-correlation-id: f0ff4c83-7866-4bab-4764-08deff3330cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|366016|1800799024|38070700021|921020|6133799003|10067099003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: 8lvszxj/wAzm8YaOSyKBNl0LMbQGyjzGt9qUOyhWnW0WV6RELSO6GytKivrKF63A5WCGJm/Jl1m/DJpUDxDSR4xjn2PohEOL8tDJgMpwHblaklv9kX6UY19p6eBW58oHaA6VD7sswRQH6w+0ENoc7knDqu1ndcttlNz7JyPO0MN5z4vrNKgR9JzgCESFtODp04m0Znx5U++CkTSkrHSvvwU72FJDf7aiAA7TCZI9EvMsNTa0JIWuU236uZi8vaMFedc5jn7pf2cqGSGIwwNS41wMNJLAmbNu/2bmscSE9aA/VcUrwg9ks4Hs+E5Xr8/FDZO/qUlE9wy5S9fHz33y0pm+XgLyBKe8BA/zOIJuJoEilNahnYIb9IRWygCbatE683rMlFMOoaz0i/Q/gM/cDQJyYhhwDaiWOKbvncGNvx2VDpqF4JT37oPSQUWpssa4MXJynLzGshEOwFMpHwmoRlu/DbYNSS/if8X7lvA2nMgn1hokI/2C6Tpbdju1LAXvw3pI7R4MwIUTNI/2lbtf3vTEB5Kvl1LVKOFG227gsS3g4YdJqTJAanFEkjZdOY3zhFb7ZOgWwp1KEjCXUhzs15lXEGl2X0tztqhj3c0CCqJl/FAqXSAntubYi2TZ2rMOI5eqJUsh7TusZjF9MZBBYTa0zsIK2F57Eg3ONcwSZpBT82jsqF1E5+do6x3Jd6ZPRw0pfIywYieLX/rHhso6vnDvdpCXItN97usdV2O2keo58QMjrz2LlsgzcZ0lftYN
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(38070700021)(921020)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+4r/K2Fq7UDoHcwWqehywvYWErGNvSo4FnqDQK/XtcvxqfY7B1GWzX4pdB?=
 =?iso-8859-1?Q?1jixk7OUv2A2teVa+94QpYBn2i3tKP7y0FvuhrG9B8C18mJq+Pzlh3bB8s?=
 =?iso-8859-1?Q?sR+kwaJIBQM0Wh15H8YKrM7olGwi2lLn7sWMi9xV6T4k/kCVlM8R1qi/+y?=
 =?iso-8859-1?Q?gzpVMhS7lhM+NsU3BLhiYRDshUrk+W1YBLO1z2iFmT3EkRaPFzOpSALaD0?=
 =?iso-8859-1?Q?7L/DDIpxfp31HUUjWWzYOSjZLU4SeFkI5m+reo4Lm0/6tdTW7R1lxooiQ3?=
 =?iso-8859-1?Q?X/sXlNj3DG171IhA7kDUsYxJeBBVx5DHqInmuWhGHJ1hcCn1us8xlJqjaZ?=
 =?iso-8859-1?Q?KlATDyZc6fUsn6pX7b/pc/Ygpfw166ePJmG+zfmFV1sEYjlxDGq693dLy2?=
 =?iso-8859-1?Q?pd5bHC+TGc3XJV3kn2MyUVP3/f7hrAM6Coh5fcZMYJPeOjGrz4PdQMFYRC?=
 =?iso-8859-1?Q?i+sS3RWTDCwq8BtuOoe0HwkKbZ2CvUcsN55/CqXQonQD2wRCXatlLkZO6d?=
 =?iso-8859-1?Q?8chhcBoD9HcZ/nzyxXxHSI+X0ShzCdNPk0mhrSjc01FogapXb6Wn1pPHvj?=
 =?iso-8859-1?Q?dWv89znINnLEzey3PRdEBXuFtXUT5CR+XUfo/3qmGCxSSAB8fmTGOjCcW5?=
 =?iso-8859-1?Q?lAdXKlWr8u9DMS16G6jTI1g/KLySceJqDPzrQFYXdoaxb1QI2lz8gQDI1Z?=
 =?iso-8859-1?Q?2wpddbyWQU1gwfEODzVYfj6EgbHa56N9b0VQ+vRqJdowhtohGb9aB3l0oL?=
 =?iso-8859-1?Q?Pnafx2scKp/EeDMTyJuaFvolgoPFd6Vs4ZsqMhrimFdUOgzBqBiW/AfAd/?=
 =?iso-8859-1?Q?Xv+KX/ljjkDnNpGqX/IEWuVlxTzcqYq7wrwLxwhfAdlvT8tb/7Zh+17Q1v?=
 =?iso-8859-1?Q?ilL9gBpr7WMX582Zx0EO4LJzeJrGbtnbCPP+diwKNhqaUfuGJ2vFe5jrt1?=
 =?iso-8859-1?Q?g7oa65jwCOYGH712xOF6bkFrWGdvy8XNf6HAfGP52Jm5lEIEobVhEH4rAh?=
 =?iso-8859-1?Q?ZBbqKpLbOm0yUjf+q3ZGzjXmDeX73BQVCFTdba3OMvyKoz6tP7B2DbvPLk?=
 =?iso-8859-1?Q?Cfk76tabxVsqTXom4NkJU6WfC1NrdZBc6ygzW9kt1AwNyXXBhJDF4gKxS9?=
 =?iso-8859-1?Q?EWIgKXdLZC3gB4MZWCYxI9SzuEmw/7ntqejfARid1FMh9I10F7t+9PIqVa?=
 =?iso-8859-1?Q?VBCjpiK0R+/+RCSuGFcQ0GH/f682/1mQ8ORXzeU7u3QVBaIa6UKJpyyEgk?=
 =?iso-8859-1?Q?rRLPnS4tnmYtkQUNlAckZpX6CuFjaXApe77PYnBtPRbAILhpXMIdk7gdBH?=
 =?iso-8859-1?Q?+NNoWMRvsVXebeYlZ0vIoxjMRtHN/S8DMVyqi/8BvFAio726nyFNJjvn+x?=
 =?iso-8859-1?Q?VaxNjrblsdhskUzkHAepM+xAoKkggAKa5Cb0JN3KNlo+Pc4UabX8q/NrEg?=
 =?iso-8859-1?Q?G07uN9hY+zVw/GA+JYHrPH+0Hgk8M4jOJxjeQrsZz9MahF8QDHitAqVB0M?=
 =?iso-8859-1?Q?NSt0Sl6WqFFaRuCGv4fW9u9m7YmyqJxFh7ejdethSQeW+T9rcne0+rAJrE?=
 =?iso-8859-1?Q?rEHcXJv7Jp9kYXMWLBbeeeFbItg1SRIV5A4311Yvh8D9STBh6BJFOmwiLE?=
 =?iso-8859-1?Q?pm7aHH7X7BIg/mnD5NrEzGh9+LbD0Hz63ivN0OLwWVZG+ngvJeH3pfULGq?=
 =?iso-8859-1?Q?NUvNeJmRuIy3QFouS0eBA4v3f78Y5o7rW7ojNhcyMWwB1BJlR5lepuPUAy?=
 =?iso-8859-1?Q?FD1Pfrx/HrMXAv+XGwtzMqU8aDFznoFDLgpieE56/hFY8fJwacuiWVrLpT?=
 =?iso-8859-1?Q?42f6loA3iQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: LWaAPY32jYG2X6ajyucSz6kPCZ3dtUB2Z9CM8/tY5sossdBFaePvBT/13yJ+wD97VGbuDGGbhZQNwuGeABrL2+Q8S4JRTizNoI9yDRclZYuhi+sd3KT3qUaXgre575nBjxr2Upr5DuTQ4NdrTc1wXXIO6Qf7ugg5PJHzqqGbyFAJyxNFGq8z4KTzMqEgq9ial56Blm7gzshu0oPFBymHue6r2r3zLcG2r3GuxX3pNGhkVT9/rL8gy/gE9rfaQJE4z7BupI+k0dlNL6U4JFSgyUK49NFpCfaMHQTfTIzax9Y5FJw5jdcBYaaAtNdcKULqiOkT7aJh/WqRSZqT5niRFQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0ff4c83-7866-4bab-4764-08deff3330cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2026 03:20:45.0449 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EntioxZReLLd7pp2NacFxd77MQU1fXaphAxFwYOvLpt0oxKUDPog+VmrBSSjjuF0KtACdz92tvABzcVxSEqCz46TI0UB69YEG2TO0ayjDFA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5467
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

The AST10x0 secure boot controller register block also hosts an ECDSA=0A=
engine. Emulate its secp384r1 "verify" command: on a trigger write to=0A=
the command register, read the public key, signature and SHA-384 digest=0A=
that the firmware staged in the SEC SRAM and defer the verification to the=
=0A=
crypto akcipher backend, reporting the result through the status=0A=
register.=0A=
=0A=
The model reads its operands from the SEC SRAM through a dedicated=0A=
address space, using a 'sram' link. The SEC SRAM is mapped at offset 0=0A=
of that address space, so the engine addresses each operand directly=0A=
with its SRAM-relative offset.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/misc/aspeed_sbc.h |   4 +=0A=
 hw/misc/aspeed_sbc.c         | 152 +++++++++++++++++++++++++++++++++++=0A=
 hw/misc/trace-events         |   2 +=0A=
 3 files changed, 158 insertions(+)=0A=
=0A=
diff --git a/include/hw/misc/aspeed_sbc.h b/include/hw/misc/aspeed_sbc.h=0A=
index 07c7c22a86..8d3f9207fc 100644=0A=
--- a/include/hw/misc/aspeed_sbc.h=0A=
+++ b/include/hw/misc/aspeed_sbc.h=0A=
@@ -40,12 +40,16 @@ struct AspeedSBCState {=0A=
     uint32_t regs[ASPEED_SBC_NR_REGS];=0A=
 =0A=
     AspeedOTPState otp;=0A=
+=0A=
+    MemoryRegion *sram;=0A=
+    AddressSpace sram_as;=0A=
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
diff --git a/hw/misc/aspeed_sbc.c b/hw/misc/aspeed_sbc.c=0A=
index 1dfcf14e5b..aa167be4c0 100644=0A=
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
+#define R_SEC_TRIGGER   (0x0bc / 4)=0A=
+=0A=
+/*=0A=
+ * SEC SRAM layout for a secp384r1 ECDSA verify operation. All operands ar=
e=0A=
+ * 48-byte big-endian values.=0A=
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
@@ -42,6 +58,10 @@=0A=
 #define OTP_MEM_IDLE            BIT(1)=0A=
 #define OTP_COMPARE_STATUS      BIT(0)=0A=
 =0A=
+/* R_SEC_TRIGGER */=0A=
+#define ECDSA_CMD_TRIGGER BIT(1)=0A=
+#define RSA_CMD_TRIGGER   BIT(0)=0A=
+=0A=
 /* QSR */=0A=
 #define QSR_RSA_MASK           (0x3 << 12)=0A=
 #define QSR_HASH_MASK          (0x3 << 10)=0A=
@@ -220,10 +240,111 @@ static void aspeed_sbc_handle_command(void *opaque, =
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
+ * The hardware only supports ECDSA secp384r1 (NIST P-384). The firmware h=
as=0A=
+ * already staged the public key, signature and digest in the SEC SRAM; re=
ad=0A=
+ * them out and defer the actual verification to the crypto backend.=0A=
+ */=0A=
+static bool aspeed_sbc_ecdsa_verify(AspeedSBCState *s)=0A=
+{=0A=
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
+    if (address_space_read(&s->sram_as, ECDSA_SRAM_QX,=0A=
+                           MEMTXATTRS_UNSPECIFIED, pubkey,=0A=
+                           ECDSA_P384_COORD_LEN) !=3D MEMTX_OK) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "%s: failed to read ECDSA QX from SEC SRAM\n", __fun=
c__);=0A=
+        return false;=0A=
+    }=0A=
+    if (address_space_read(&s->sram_as, ECDSA_SRAM_QY,=0A=
+                           MEMTXATTRS_UNSPECIFIED,=0A=
+                           pubkey + ECDSA_P384_COORD_LEN,=0A=
+                           ECDSA_P384_COORD_LEN) !=3D MEMTX_OK) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "%s: failed to read ECDSA QY from SEC SRAM\n", __fun=
c__);=0A=
+        return false;=0A=
+    }=0A=
+    if (address_space_read(&s->sram_as, ECDSA_SRAM_R,=0A=
+                           MEMTXATTRS_UNSPECIFIED, sig,=0A=
+                           ECDSA_P384_COORD_LEN) !=3D MEMTX_OK) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "%s: failed to read ECDSA R from SEC SRAM\n", __func=
__);=0A=
+        return false;=0A=
+    }=0A=
+    if (address_space_read(&s->sram_as, ECDSA_SRAM_S,=0A=
+                           MEMTXATTRS_UNSPECIFIED, sig + ECDSA_P384_COORD_=
LEN,=0A=
+                           ECDSA_P384_COORD_LEN) !=3D MEMTX_OK) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "%s: failed to read ECDSA S from SEC SRAM\n", __func=
__);=0A=
+        return false;=0A=
+    }=0A=
+    if (address_space_read(&s->sram_as, ECDSA_SRAM_M,=0A=
+                           MEMTXATTRS_UNSPECIFIED, dgst,=0A=
+                           ECDSA_P384_COORD_LEN) !=3D MEMTX_OK) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "%s: failed to read ECDSA M from SEC SRAM\n",=0A=
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
@@ -244,6 +365,26 @@ static void aspeed_sbc_write(void *opaque, hwaddr addr=
, uint64_t data,=0A=
     case R_CMD:=0A=
         aspeed_sbc_handle_command(opaque, data);=0A=
         return;=0A=
+    case R_SEC_TRIGGER:=0A=
+        if (data & RSA_CMD_TRIGGER) {=0A=
+            qemu_log_mask(LOG_UNIMP,=0A=
+                          "%s: RSA is not supported\n", __func__);=0A=
+        }=0A=
+        if (data & ECDSA_CMD_TRIGGER) {=0A=
+            if (!sc->has_ecdsa) {=0A=
+                qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                              "%s: ECDSA is not supported\n", __func__);=
=0A=
+                return;=0A=
+            }=0A=
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
+        return;=0A=
     default:=0A=
         break;=0A=
     }=0A=
@@ -306,6 +447,14 @@ static void aspeed_sbc_realize(DeviceState *dev, Error=
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
@@ -325,6 +474,8 @@ static const VMStateDescription vmstate_aspeed_sbc =3D =
{=0A=
 static const Property aspeed_sbc_properties[] =3D {=0A=
     DEFINE_PROP_BOOL("emmc-abr", AspeedSBCState, emmc_abr, 0),=0A=
     DEFINE_PROP_UINT32("signing-settings", AspeedSBCState, signing_setting=
s, 0),=0A=
+    DEFINE_PROP_LINK("sram", AspeedSBCState, sram,=0A=
+                     TYPE_MEMORY_REGION, MemoryRegion *),=0A=
 };=0A=
 =0A=
 static void aspeed_sbc_class_init(ObjectClass *klass, const void *data)=0A=
@@ -355,6 +506,7 @@ static void aspeed_ast10x0_sbc_class_init(ObjectClass *=
klass, const void *data)=0A=
 =0A=
     dc->desc =3D "AST10X0 Secure Boot Controller";=0A=
     sc->has_otp =3D true;=0A=
+    sc->has_ecdsa =3D true;=0A=
 }=0A=
 =0A=
 static const TypeInfo aspeed_sbc_types[] =3D {=0A=
diff --git a/hw/misc/trace-events b/hw/misc/trace-events=0A=
index bbec0d2178..735d11d447 100644=0A=
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
-- =0A=
2.53.0=0A=

