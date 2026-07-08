Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32DF7C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 09:21:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whOSZ-0004Eu-VY; Wed, 08 Jul 2026 05:20:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1whOSV-0004CP-95; Wed, 08 Jul 2026 05:20:47 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1whOST-0000QA-2j; Wed, 08 Jul 2026 05:20:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JhVLUEj+GDq4Go6Vt/LZIjCe7b2Aquw0xU9fhp/c0s2f/o1ApgX+FaUYmQ8yRhuzr2ghD/Ah84lPuZmaN6q0KkhDXPUQlNzLAW8n/eRKplfYI2A8wAF4AcVw06SKsviOXZxOzz80v7IebMsvbUo23wPlh4OJE2ScZIgTBfD+fgOLaKL3gb6w4rSRfnZtuzUAdlvSwUcT2pCYWfKkljdVdJRsM9oktU2muB2moyeTtPFPETXbcpT1QVcBK7TOHExx3yhTMdZrI6+gXK5QKUnSQwJvQz8v33t+mOy88wapkgZzTIVhbTZ1st2OXXoLQD31QbuWhx6z2ADUrY2nrrBRLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=obQX2NK0C06CPR6zQrKz0+IjBsUIw0IhF71Dq7EKYhw=;
 b=xbixTWZYBT/GnG0ox+xw6pNiBz9tpzax30CyX7iy6vK3PlBnH9eHa09HlaRJNa7ACcXyd7fxMyLT4BuQFBPe2Wkkd8RqAl8pgHDsRGLN2UKVKWLES2hFZ9WkFny782BUWTn5elrCQYago7RneXkm6ceuCb64Fwc/0kgtwf/bmNQE8sg3qWW1iYR4sl6w1N7LyAaIGexjF5GfZmTGPZIo4YWaxkbFps8tnly5vkq1fMcVkCKAuwTGSIyyKk0jj66omTl0kWCMzmZt24d8ICryPOfNPiA8TTXFAzY7ef1Zpc7YtMqYLoCkCRgP7XgM04ha2Ty4s9jQ/St+XqkBP4oxpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obQX2NK0C06CPR6zQrKz0+IjBsUIw0IhF71Dq7EKYhw=;
 b=Bk8meJVjzrpUusDLredFRiQd46dWJv+GMgbIBjrIK8fOLwyAKGKFcJECu1sDX9fDbThinyuXkaCcgDDdPDy3Wuq3SPjShaH7yWM+giyud51BCLMgeU2ACxXQ9PqSS43CwMNTekpGFJdgSIs821wFU6V3RWf2lGWUcvlHiwbS+mI2wMC9Q+VK/YRKudtj0s8ekmQWtaFYwOY5jHgvQKom2VvbbHQfEl0/rWRh4vSTXXYygoR05gDCuEZD56+ohOC1OoTdnZeBWONYKw3EQuK+WQLIHNcPuvPuE63wg2xRoh85gMEttkTWXKJMm5Vngl3BxI0uhyW+6t6EUOra+tmf0g==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by PUZPR06MB5499.apcprd06.prod.outlook.com (2603:1096:301:100::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Wed, 8 Jul
 2026 09:20:32 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0181.010; Wed, 8 Jul 2026
 09:20:32 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v5 05/10] hw/misc/aspeed_scu: Implement SSP reset and power-on
 control via SCU registers
Thread-Topic: [PATCH v5 05/10] hw/misc/aspeed_scu: Implement SSP reset and
 power-on control via SCU registers
Thread-Index: AQHdDrsGfV/yF2gXK0yM9CLfRnemnA==
Date: Wed, 8 Jul 2026 09:20:32 +0000
Message-ID: <20260708092023.3826159-6-jamin_lin@aspeedtech.com>
References: <20260708092023.3826159-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260708092023.3826159-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|PUZPR06MB5499:EE_
x-ms-office365-filtering-correlation-id: eb45d424-7a11-431d-8a22-08dedcd228ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|22082099003|18002099003|5023799004|38070700021|6133799003|56012099006|921020;
x-microsoft-antispam-message-info: g3lrEg7Cy0j4dF53seGj13oc7uOQwyJuvQ+lFYcgjF/gImrlhG+D7X+C5BdjBgpuvU8slTNOdtZGZGJHrHX6bycYfTGiJITT8ThZ9XiKRlr4GIuyrXeRzv13FGM2ZYCyIOiv7r+zXi8yy8UmjGfSHGWPt+6clV6C5EB93WyGmy8Zv7EEZ/tMdc1rpGypL/9kBw+Gb31BiDhpcTzC8r0deaAslfxys4smmkNGij64K6xZQnf+lFQtM5sgkAAjdyqrdlgeoToG6KynICRsodUZC9upiS5BqggG4VKxITXNJ66li+Vx+3dTk6PCVdQ1TSVne+yehMEfe5YNNiJlf3RSHbwj1WY+rfKRhfbzm6YZjf2ZsnjaZPYly+pa6pHxbJfu6fva4DRyje1/jbnjgoerCpHJluohThktKERXSY/ZNhJS8nWhNoC/kg5eQIC3ZfD4dISP620c8a48D+SNz2kmHbZFMFp3XWBGz5ZWxIBsD8cxSz0XsnZPRDhaitVxROkrEFB5jjGjWbkyZ2igXVaZL1jb4thM8KdXWbgViPiLej+MzeSzw4lXbK3xiaPclQCY7WT2NSFPHPQapFTR0p/c2ozlZqFUaXXyw9CFG/7ghifHGeMNU6P/QXbSwf9uzC70ojx1n/GarT/3n58te0e/zJxSEnIvHboZng9IeDjlNR4Je7qq5tmdw4T2m53aM9bPv8YT+YzbnZrYjbbR2VHvReT8/LLzC1bBlwXuNoP9W38=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(22082099003)(18002099003)(5023799004)(38070700021)(6133799003)(56012099006)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?s5n3GU1hXXfKCYlWNskgVfCvHfIT1VVdhqHxUG1viYa9HLp447SZ2mN8cl?=
 =?iso-8859-1?Q?qe6C34Kh61QSLYGWmHORjlKDzU8I3VJRO/IN1qUfvRedP88Fk1Dd03DfGq?=
 =?iso-8859-1?Q?2k48xzJvTFfcMpnBCrNU4gwb9wTVDHw0Kq9+ctbCy8P/H3FV3//CF4BJFP?=
 =?iso-8859-1?Q?G6jwtPELJYBKAfjFce44halze/J55Elzz8kFZR0m34j95sSEOz/FO1WlY+?=
 =?iso-8859-1?Q?yG6mZCykVRIjqFh6Ijb71U4RYHDTyH2cwe/IRMOP7FCVhCxm/KSt5mMeFK?=
 =?iso-8859-1?Q?b8VCk2bVO5OkwNRXLuHmUzahLIINJqzClhaQFBcrQNnAB7g4LB1cqKQvIH?=
 =?iso-8859-1?Q?aDoeIeTRQSoFAyEl/cgAkprxwwseg2oM7AnusTHtwTs+LTZ51W9hcN4twj?=
 =?iso-8859-1?Q?4muQyki+o/AFNTjJoTy/t+UKAbyTtRVVaJUQy8wZnit3r9Q2UlG+K/Rkil?=
 =?iso-8859-1?Q?nOkkJqXByF798pjlxUXy2CADvPFsS/b+btiuuA4y3BgnzyoG28TOMmhqMF?=
 =?iso-8859-1?Q?rxwAN6dsNRU4aOhRus8sc4VCQoskKsi5x5U3H+5xtLdE1MurOLT5V/BbZq?=
 =?iso-8859-1?Q?0KSo7l0fjRmYsRHajY1ZLQf89IAEWRYBz59Q6cpBsVfU5cEMFiIaj+0qco?=
 =?iso-8859-1?Q?dKUg+w9tAELzs3s/vqWbd361WQH3rgbn5T9Ua8y8gVoP+OcX0c2iTL+w9R?=
 =?iso-8859-1?Q?eQHGG06SM5WGX80DYbNxVNsWIwZyVjXFNmUnsxjw4+Z7CQbtV9bfJhTePr?=
 =?iso-8859-1?Q?6kyt0SKQzKTVoWNLq+M1S4fY+mYGKdhOPCMzJSGcSUUsmmxU3D6+fO7Pae?=
 =?iso-8859-1?Q?NyjzVOkfg5RIgswHpnyDlF8B+Y7wXVxzJ8mTvgCZnVnOAJeeHY510O1g9l?=
 =?iso-8859-1?Q?7Dgg1hgqZPuTfpyes1ugHBHSpux7ikVUpS+1NlOxPExaJj6cIUOP1dLBaF?=
 =?iso-8859-1?Q?rWwfpmUbnth0B4muk9td2oG39opcS8yTpATxhkOVu/1AAQnQY3FV6f4hpn?=
 =?iso-8859-1?Q?t+40q1L+uVJCc8ZDB2hFLI99VUtHXDLPl46PyuocV747NSsOZPpGutff+6?=
 =?iso-8859-1?Q?XBGTy6Rxt+ZINPUhW4z6HaYSnS1apsPmqHUIROGg1PHjGUe7wY5khq0Yd7?=
 =?iso-8859-1?Q?PZ1+iYlKa57Gk2Pm2pdY8Te34Vf6M8qo/WBVC4st9uRO4r9DJma5uBaYVh?=
 =?iso-8859-1?Q?IOsXGrvjzXOTT9npn5I50UQNEDCVL2hjZK36ToolLVSmlQSF5ZCA6ZTe9i?=
 =?iso-8859-1?Q?2fkSFSpeDUvM8LBSTVEVztTOLBtGqp0Emepyq7qypztM0CeEZgErc236J6?=
 =?iso-8859-1?Q?famLXCVctLJxaOhMbE/wkZuOFzQMwRKcb1YDBNKrOkaOhCGQDzv9FKgwCc?=
 =?iso-8859-1?Q?zaPpX5QYDQ7zsMOJ970TncnA0VWwibbhRnxeg8AOx5by6TEJfTY3y7Z158?=
 =?iso-8859-1?Q?TyLf2rUWVU+lP0da4ittzLOA1fItiu52LpJLr7Tw1GU1W8W90Ho4wDVS1j?=
 =?iso-8859-1?Q?Pp6eT6+9NjGPYSgXrou22vfo3VZ3J5a+qPBf9b09bqBKR+nw4TrtwnF6xi?=
 =?iso-8859-1?Q?rvUe3bq5knIurnj4V7uiL333uH7m/xuKXsExbIXQqJZW93IlwvegwH03hP?=
 =?iso-8859-1?Q?rN26Hqai33DRT8MuWkxUMSTOXvLkJ7Fpee4LzvdjKmZS/65ESnnrRq+0hj?=
 =?iso-8859-1?Q?q0MKSzd4Do1QGIpA2Z1G59wfXSdzlNGV3R4UfFxu1lUvPA8+bDTmR7ip8h?=
 =?iso-8859-1?Q?vE6rHRnqBE24UUmEbbgCZJreyRvkIiTH3zu5CbeRF2N59srg5to1OAEOht?=
 =?iso-8859-1?Q?DqXp4niK4w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: eOjvr+4p2oJvMB176EfKgXxOQ1ElwE+74+Zp+gaJM6cwAnNsNfLdsNqKfXzUiBV82ljpChc6I9CgOgBc6/PWK35eorDfEowDJirWWTAWKgV6/rhxcCvLg5sBoAxJMR722+jkL8aZxR6LEwM51/1x4ny8qIVNURRp3AkDGy6GKL5pkMVkB7RoUNzfZ5izI+56U9MRm18K0crm++OW/gOk1iNtDfLV8JZFvyH941Qb4DWc95wuEAQATxpMkw+JqwFpDz6TkVKORhvAUy0gx2BQLoRvFqifqgnuWpINpyJhD3JrgaglH/FE9YjgRNB0u9xKZNHS+TsKCNmi60zD2ljC+Q==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb45d424-7a11-431d-8a22-08dedcd228ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2026 09:20:32.0867 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xoIyL9yfVFmoRehyqYworiE5fLKIDDhzwlI6uCFmhtpsjRNHkuEpfWRnEuAoJEe+HIr6XFhKMk5o+H+WzLeRc9EbkTsQq9ghoTLv+eBWj9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5499
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

This patch implements SSP reset and power control logic in the SCU for AST2=
700.=0A=
It introduces support for the following behavior:=0A=
=0A=
1. SSP Reset Trigger (via SCU 0x200):=0A=
   - SSP reset is triggered by writing 1 to bit 30 (RW1S) of SYS_RESET_CTRL=
_1.=0A=
=0A=
2. SSP Reset State and Source Hold (via SCU 0x120):=0A=
   - Upon reset, bit 8 (RST_RB) is set to indicate the SSP is in reset.=0A=
   - Bit 10 (RST_SRC_RB) is set to indicate the reset was triggered by an e=
xternal source.=0A=
   - Bit 1 (RST) is a software-controlled bit used to request holding SSP i=
n reset.=0A=
   - If an external reset source is present and bit 1 is set, bit 9 (RST_HO=
LD_RB)=0A=
     will also be asserted to indicate the SSP is being held in reset.=0A=
   - If bit 1 is cleared, RST_HOLD_RB will be deasserted accordingly.=0A=
=0A=
3. Hold Release and Power-on:=0A=
   - If RST_HOLD_RB is clear (0), SSP is powered on immediately after reset=
 is deasserted.=0A=
   - If RST_HOLD_RB is set (1), the user must write ENABLE (bit 0) to SSP_C=
TRL_0 to release=0A=
     the hold and power on SSP explicitly.=0A=
   - Writing ENABLE (bit 0) is a one-shot operation and will auto-clear aft=
er execution.=0A=
=0A=
4. Reset Status Clear (via SCU 0x204):=0A=
   - The reset status can be cleared by writing 1 to bit 30 (RW1C) of SYS_R=
ST_CLR_1,=0A=
     which will deassert RST_SRC_RB and potentially trigger power-on if no =
hold is active.=0A=
=0A=
5. SSP Power Control Logic:=0A=
   - `handle_ssp_tsp_on()` clears RST_SRC_RB and RST_RB (if not held), and =
invokes=0A=
     `arm_set_cpu_on_and_reset(cpuid)` to power on the SSP core (CPUID 4).=
=0A=
   - `handle_ssp_tsp_off()` sets RST_RB and RST_SRC_RB; if RST is active, a=
lso asserts=0A=
     RST_HOLD_RB and invokes `arm_set_cpu_off(cpuid)`.=0A=
=0A=
6. Register Initialization and Definitions:=0A=
   - Adds SCU register definitions for SSP_CTRL_0 (0x120), SYS_RST_CTRL_1 (=
0x200),=0A=
     and SYS_RST_CLR_1 (0x204).=0A=
   - Updates the reset values for these registers during SCU initialization=
.=0A=
=0A=
The default values are based on EVB (evaluation board) register dump observ=
ations.=0A=
This patch enables proper modeling of SSP lifecycle management across reset=
,=0A=
hold, and power-on states for the AST2700 SoC.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/misc/aspeed_scu.c | 109 +++++++++++++++++++++++++++++++++++++++++++=0A=
 1 file changed, 109 insertions(+)=0A=
=0A=
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c=0A=
index 88c1a57299..07901f2ab0 100644=0A=
--- a/hw/misc/aspeed_scu.c=0A=
+++ b/hw/misc/aspeed_scu.c=0A=
@@ -21,6 +21,7 @@=0A=
 #include "qemu/module.h"=0A=
 #include "trace.h"=0A=
 #include "qemu/units.h"=0A=
+#include "target/arm/arm-powerctl.h"=0A=
 =0A=
 #define TO_REG(offset) ((offset) >> 2)=0A=
 =0A=
@@ -144,6 +145,17 @@=0A=
 #define AST2700_HW_STRAP1_SEC2    TO_REG(0x28)=0A=
 #define AST2700_HW_STRAP1_SEC3    TO_REG(0x2C)=0A=
 =0A=
+/* SSP TSP */=0A=
+#define AST2700_SCU_SSP_CTRL_0          TO_REG(0x120)=0A=
+#define AST2700_SSP_TSP_ENABLE          BIT(0)=0A=
+#define AST2700_SSP_TSP_RST             BIT(1)=0A=
+#define AST2700_SSP_TSP_RST_RB          BIT(8)=0A=
+#define AST2700_SSP_TSP_RST_HOLD_RB     BIT(9)=0A=
+#define AST2700_SSP_TSP_RST_SRC_RB      BIT(10)=0A=
+#define AST2700_SCU_SYS_RST_CTRL_1      TO_REG(0x200)=0A=
+#define AST2700_SCU_SYS_RST_CLR_1       TO_REG(0x204)=0A=
+#define AST2700_SCU_SYS_RST_SSP         BIT(30)=0A=
+=0A=
 #define AST2700_SCU_CLK_SEL_1       TO_REG(0x280)=0A=
 #define AST2700_SCU_HPLL_PARAM      TO_REG(0x300)=0A=
 #define AST2700_SCU_HPLL_EXT_PARAM  TO_REG(0x304)=0A=
@@ -842,6 +854,35 @@ static void aspeed_2600_scu_class_init(ObjectClass *kl=
ass, const void *data)=0A=
     asc->ops =3D &aspeed_ast2600_scu_ops;=0A=
 }=0A=
 =0A=
+static void handle_2700_ssp_tsp_on(struct AspeedSCUState *s, int cpuid,=0A=
+                                   int reg)=0A=
+{=0A=
+    uint32_t val =3D s->regs[reg];=0A=
+=0A=
+    val &=3D ~AST2700_SSP_TSP_RST_SRC_RB;=0A=
+    if (!(val & AST2700_SSP_TSP_RST_HOLD_RB)) {=0A=
+        val &=3D ~AST2700_SSP_TSP_RST_RB;=0A=
+        arm_set_cpu_on_and_reset(cpuid);=0A=
+    }=0A=
+=0A=
+    s->regs[reg] =3D val;=0A=
+}=0A=
+=0A=
+static void handle_2700_ssp_tsp_off(struct AspeedSCUState *s, int cpuid,=
=0A=
+                                    int reg)=0A=
+{=0A=
+    uint32_t val =3D s->regs[reg];=0A=
+=0A=
+    val |=3D AST2700_SSP_TSP_RST_RB;=0A=
+    val |=3D AST2700_SSP_TSP_RST_SRC_RB;=0A=
+    if (val & AST2700_SSP_TSP_RST) {=0A=
+        val |=3D AST2700_SSP_TSP_RST_HOLD_RB;=0A=
+    }=0A=
+    arm_set_cpu_off(cpuid);=0A=
+=0A=
+    s->regs[reg] =3D val;=0A=
+}=0A=
+=0A=
 static uint64_t aspeed_ast2700_scu_read(void *opaque, hwaddr offset,=0A=
                                         unsigned size)=0A=
 {=0A=
@@ -862,10 +903,14 @@ static uint64_t aspeed_ast2700_scu_read(void *opaque,=
 hwaddr offset,=0A=
 static void aspeed_ast2700_scu_write(void *opaque, hwaddr offset,=0A=
                                      uint64_t data64, unsigned size)=0A=
 {=0A=
+    Aspeed2700SCUState *a =3D ASPEED_2700_SCU(opaque);=0A=
     AspeedSCUState *s =3D ASPEED_SCU(opaque);=0A=
     int reg =3D TO_REG(offset);=0A=
     /* Truncate here so bitwise operations below behave as expected */=0A=
     uint32_t data =3D data64;=0A=
+    uint32_t active;=0A=
+    uint32_t oldval;=0A=
+    int cpuid;=0A=
 =0A=
     if (reg >=3D ASPEED_AST2700_SCU_NR_REGS) {=0A=
         qemu_log_mask(LOG_GUEST_ERROR,=0A=
@@ -877,6 +922,63 @@ static void aspeed_ast2700_scu_write(void *opaque, hwa=
ddr offset,=0A=
     trace_aspeed_ast2700_scu_write(offset, size, data);=0A=
 =0A=
     switch (reg) {=0A=
+    case AST2700_SCU_SSP_CTRL_0:=0A=
+        cpuid =3D a->ssp_cpuid;=0A=
+        if (cpuid < 0) {=0A=
+            return;=0A=
+        }=0A=
+        oldval =3D s->regs[reg];=0A=
+        data &=3D 0xff;=0A=
+        active =3D oldval ^ data;=0A=
+=0A=
+        /*=0A=
+         * If reset bit is being released (1 -> 0) and no other reset sour=
ce=0A=
+         * is active, clear HOLD_RB and power on the corresponding CPU.=0A=
+         */=0A=
+        if ((active & AST2700_SSP_TSP_RST) && !(data & AST2700_SSP_TSP_RST=
)) {=0A=
+            s->regs[reg] &=3D ~AST2700_SSP_TSP_RST_HOLD_RB;=0A=
+            if ((oldval & AST2700_SSP_TSP_RST_RB) &&=0A=
+                !(oldval & AST2700_SSP_TSP_RST_SRC_RB)) {=0A=
+                handle_2700_ssp_tsp_on(s, cpuid, reg);=0A=
+            }=0A=
+        }=0A=
+=0A=
+        /*=0A=
+         * If ENABLE bit is newly set and reset state is ready,=0A=
+         * clear HOLD_RB and power on the corresponding CPU.=0A=
+         */=0A=
+        if ((active & AST2700_SSP_TSP_ENABLE) &&=0A=
+            (oldval & AST2700_SSP_TSP_RST_RB) &&=0A=
+            (oldval & AST2700_SSP_TSP_RST_HOLD_RB) &&=0A=
+            !(oldval & AST2700_SSP_TSP_RST_SRC_RB)) {=0A=
+                s->regs[reg] &=3D ~AST2700_SSP_TSP_RST_HOLD_RB;=0A=
+                handle_2700_ssp_tsp_on(s, cpuid, reg);=0A=
+        }=0A=
+=0A=
+        /* Auto-clear the ENABLE bit (one-shot behavior) */=0A=
+        data &=3D ~AST2700_SSP_TSP_ENABLE;=0A=
+        s->regs[reg] =3D (s->regs[reg] & ~0xff) | (data & 0xff);=0A=
+        return;=0A=
+    case AST2700_SCU_SYS_RST_CTRL_1:=0A=
+        if (a->ssp_cpuid < 0) {=0A=
+            return;=0A=
+        }=0A=
+        if (data & AST2700_SCU_SYS_RST_SSP) {=0A=
+            handle_2700_ssp_tsp_off(s, a->ssp_cpuid, AST2700_SCU_SSP_CTRL_=
0);=0A=
+        }=0A=
+        s->regs[reg] |=3D data;=0A=
+        return;=0A=
+    case AST2700_SCU_SYS_RST_CLR_1:=0A=
+        if (a->ssp_cpuid < 0) {=0A=
+            return;=0A=
+        }=0A=
+        oldval =3D s->regs[AST2700_SCU_SYS_RST_CTRL_1];=0A=
+        active =3D data & oldval;=0A=
+        if (active & AST2700_SCU_SYS_RST_SSP) {=0A=
+            handle_2700_ssp_tsp_on(s, a->ssp_cpuid, AST2700_SCU_SSP_CTRL_0=
);=0A=
+        }=0A=
+        s->regs[AST2700_SCU_SYS_RST_CTRL_1] &=3D ~active;=0A=
+        return;=0A=
     default:=0A=
         qemu_log_mask(LOG_GUEST_ERROR,=0A=
                       "%s: Unhandled write at offset 0x%" HWADDR_PRIx "\n"=
,=0A=
@@ -904,6 +1006,8 @@ static const uint32_t ast2700_a0_resets[ASPEED_AST2700=
_SCU_NR_REGS] =3D {=0A=
     [AST2700_HW_STRAP1_SEC1]        =3D 0x000000FF,=0A=
     [AST2700_HW_STRAP1_SEC2]        =3D 0x00000000,=0A=
     [AST2700_HW_STRAP1_SEC3]        =3D 0x1000408F,=0A=
+    [AST2700_SCU_SSP_CTRL_0]        =3D 0x000007FE,=0A=
+    [AST2700_SCU_SYS_RST_CTRL_1]    =3D 0xFFC37FDC,=0A=
     [AST2700_SCU_HPLL_PARAM]        =3D 0x0000009f,=0A=
     [AST2700_SCU_HPLL_EXT_PARAM]    =3D 0x8000004f,=0A=
     [AST2700_SCU_DPLL_PARAM]        =3D 0x0080009f,=0A=
@@ -923,12 +1027,17 @@ static const uint32_t ast2700_a0_resets[ASPEED_AST27=
00_SCU_NR_REGS] =3D {=0A=
 =0A=
 static void aspeed_ast2700_scu_reset_hold(Object *obj, ResetType type)=0A=
 {=0A=
+    Aspeed2700SCUState *a =3D ASPEED_2700_SCU(obj);=0A=
     AspeedSCUState *s =3D ASPEED_SCU(obj);=0A=
     AspeedSCUClass *asc =3D ASPEED_SCU_GET_CLASS(obj);=0A=
 =0A=
     memcpy(s->regs, asc->resets, asc->nr_regs * 4);=0A=
     s->regs[AST2700_SILICON_REV] =3D s->silicon_rev;=0A=
     s->regs[AST2700_HW_STRAP1] =3D s->hw_strap1;=0A=
+=0A=
+    if (a->ssp_cpuid > 0) {=0A=
+        arm_set_cpu_off(a->ssp_cpuid);=0A=
+    }=0A=
 }=0A=
 =0A=
 static void aspeed_2700_scu_realize(DeviceState *dev, Error **errp)=0A=
-- =0A=
2.43.0=0A=

