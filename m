Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A64F8E4A9
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 03:30:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDZtA-0002Hr-S4; Thu, 16 Apr 2026 23:29:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDZt9-0002Gu-DW; Thu, 16 Apr 2026 23:29:03 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDZt6-0005q6-Pp; Thu, 16 Apr 2026 23:29:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cqkhgKk45br2+CAnp9SOIHXVoFb9dusYkHF8YEl+9k5L9+ib9GHOQyejgu0k3Vm3IWeFAK9v6N0gOO6WqewlBg90RQ0Ss7fXht84uehNo3jlOygpgJNS/Bt0YSHmJCcMqZlA1cpds/ex8jZhvNvDre579mec1ODO3DVJl70gtFssUrONQiuT2YptfSh0hXrEF/S399DmeLvHAunTedmaGIkytalucyRXYY6heQ+bMxLdPCxnYfe//DJ1t7hsYfcZDEGOmXlneOSjndFvoTtf8DSBrOglM/05DJTMERS/XzIdw0JhbLWhyKBwIEuhhuLCeVqzQ++/xDFYvy3O2OySLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MzNnHwuUXze6sA6xPQCTaYr9YA476laQBgHkXdNhNfE=;
 b=zFmRNdH7Xb7+E1uRk3/AoMizI9g8QaOUfnzRt7SfUECQGVJ99v12LUIfxjvDJnK+8K5ZbPQx3rL8AaIzxTnT9kI1pet17vw2/uuTYMK9Hkp1aqrPUB+URoimcerw82SP6GtfbmrMsCGlPFfWjEf/RyYucLv0NxzsnCR4H4R3y0OvcFD7uRyiRhWJP5vHhw6P6QVpyN7sifNuyOD905XSPV1menSduFF2fyE4JxYvkUEotH9phNWR+qCwZUo8/tzmDw/G3Dm2xs5Dmh3hBNSPAD6Pt/CfzB/bo/2RhAjgD/bUel4jUETnGT+bpiShhPlTabnqsU2ccwFer0tKvJbgqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MzNnHwuUXze6sA6xPQCTaYr9YA476laQBgHkXdNhNfE=;
 b=eKukVpjLjo2rKtDbO7jVvZzHiADnwR5ciCc2pz3ayCMWeVPLjI7c9IGX2+qHIZ5mWK0hVCjhxBJQGSv4t31+4pgZf+FzJ8zAsC2Rsfj9sCFzveg5YlnkrdX8f//4zWBC/XUKVT97F2vFxpIrGVqLg+jmtob7/ONtaAadDW7SyoEKnW4+qVke4GabPAZfnYXFCidQ7ittL62nE1ZiO/6Bho7HPSuu73+judbGOA8pz7JdpVi1VCHwiEdQ6EEbWjxsLTZ3pl23WEv2839f6Ec5biqX861BAtfa1S7NAtnJkWd7/Mz9Ehrq0xqppeVhMoUBw8iBoTeW2xEwmY+8sMIspg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB6299.apcprd06.prod.outlook.com (2603:1096:820:ce::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 03:28:48 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 03:28:48 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@linaro.org>, Alistair Francis
 <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>, "open list:Block layer
 core" <qemu-block@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v4 07/21] hw/misc/aspeed_scu: Implement SSP reset and power-on
 control via SCU registers
Thread-Topic: [PATCH v4 07/21] hw/misc/aspeed_scu: Implement SSP reset and
 power-on control via SCU registers
Thread-Index: AQHczhpNTgWtiUEuW0WJEruo+V6wSw==
Date: Fri, 17 Apr 2026 03:28:48 +0000
Message-ID: <20260417032837.2664122-8-jamin_lin@aspeedtech.com>
References: <20260417032837.2664122-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260417032837.2664122-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KL1PR06MB6299:EE_
x-ms-office365-filtering-correlation-id: 2b126571-135c-419d-abea-08de9c31703c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|921020|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: PWgZPXZkocp4ud+FbpRkXZHeGllSlgeReDqSnGSCt4xBtWA6gzx4uU6W/Gg9owCNSdaaO3C5TBjYosOqyOckxG4Q0njfCkHD5sifUbjSb8IZNU2uOt0kxNlHR00H/doNWFUuSEYBxXRO8j03HFK2wkrIF/1YPtNHzcH54FdKiA49+8UkOXyCUHiDD2iVkIvCc71YcwfcGAGHJn3XvbTNjYJyZ0YkF//cqNCqP21+axq+n+0rNe5q5Ul/4O0pmTwn3cXIJ6qiPgmaVPaDparXHzPlIMotO+RjiqWVhBQS4MCtty0uxdlOT0ralU5eD0dA99LSSakZBnX4RK2Gcn1zLVwNIwSkNVPT8i/nzGlEl3x7DKsOzx/6L7ATSNB1j8pqgsttbVANpAJi/Btp4PeXmw3lraPIzhpFpntbYR22nlsvcH6NB+ljurHcH+8flSKxxqfX9uz+plFKRM+dXdMROgDF2fYmZZNLzII8XQzFRa6779CaEL9wry2FtPEDe5XfyXjVhFAqFBkDa6krFkNvpKXpgZK3olmUWEyDvg3YE88QFy6bCFQWbx7gZQzbsR/z9a0G4CcBr64UUGUEaScQbjgj73eHtXyiyZQ8LT1UHVAbLSmLSjRRVCSSx6MZF7159FXc3vuitgbt5V5tnZEtJVWWxu7ThQjW/QPAVcooCbDPt/MWyt+VNDzTI5FxT5xR25vUcj1RH4W7dv+e4CNosegerGasW0V4ySXPYQ6q9Wk/qQSFaqrpCi4HlieIquq5O1mwxfDpUvFLDAHtgPt1uhoOswE/sNyW7b7I2PSr6L17NDQOMHL5Ehky/lzIOSog
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5autV7Jp8hgSA6zKAZwFwDdfCNWvgF+XJtKaxQqnwBLIr448tXMZyZlYoc?=
 =?iso-8859-1?Q?EIi6FHF+qSf4eiSXOa70s6u8WnLbTFxnyAhuIWVaEaBo2K4DJ/jeFy1v+R?=
 =?iso-8859-1?Q?sCPY8Rzsp1lb8Yy3T8z9wRXCYP8AzcYlKnQ4748GG6xIOSMNyY7UzVuXZW?=
 =?iso-8859-1?Q?IbGjc2OiovIBOMfEl4FYzvjajqgE00IAUYnon7h9DKAw+VCbb6RpjQj1NO?=
 =?iso-8859-1?Q?V2TVGt3MMr5I1LfFYqO1NFOljhwzr6MCjpbsfa50YdOXVUxj8SdVQ/71jM?=
 =?iso-8859-1?Q?xtBz7dXUzR99mfLl7Q/j4upXTSZSAARwvnzoyPqR/+t/6F6jr3ACSPIQ8l?=
 =?iso-8859-1?Q?SiXrdA6DaENKrF9yGOaL/Akk7074VjUr/Uw69EU2x5ghLWqkIiF4C0EbgT?=
 =?iso-8859-1?Q?Y7MkBOArX7+dNkTDAXgv5cfLuhm+R4BQUPhDuzS3F+EoUSfTtOYVYwIdf+?=
 =?iso-8859-1?Q?py5M/Y+qESLddThTDFRS9EARrqk0UeBpotTW+YLMcw191e5FIYrzg4DOPz?=
 =?iso-8859-1?Q?nRJyhEfwpOh4JR/q007YRYCDoTSw9rZZmXXigm1N9mDh9DB8D2ZoJjBsmW?=
 =?iso-8859-1?Q?PiLuCI2I9iurFrKhAOgb4/pDQ4c28yl3h3LPNlMjp3KjGJrXcw6QnyGZ8o?=
 =?iso-8859-1?Q?qzr+wLlRHIjBzOS5PUrHz7Ac0GoC1v1QSK4XWM0WecywPRmwyna9JM0dAI?=
 =?iso-8859-1?Q?FqIWA1qgqAxPl69+PIRVULyTVtjuWI2yOmAy6sjXdyuqDrtk61UsQOwRgx?=
 =?iso-8859-1?Q?vC0FtzO419OKJ11pdgLZnNVQG8UVh2cnlAaZwE0+Y2nd2K0I0tGh9Gf6Vy?=
 =?iso-8859-1?Q?vpUtOnx9FBSUpUUed02PgHRkbGN/1zJuy62iTiv8M6Fi0BjQ7r11YFeFOz?=
 =?iso-8859-1?Q?VnnkRbhmGdY+AamdXzSAFSJlYpB/GjrAmqEFJJ2E/ZfnShqJcI+Nh4X/ue?=
 =?iso-8859-1?Q?pOied+9eK+FHvkFIgD2LvoAEZmyRwlYdpq8R05VtyiLaiM25t0nDAWtqF/?=
 =?iso-8859-1?Q?cW4ftYsiXND/mppulrG0dS6UPAz12RWrhMhX+lFupiPGFk0dG3bU5Z39UX?=
 =?iso-8859-1?Q?jBqZ4DW3iM+NKZLkPfVhZCj6q3PgWpePQNy81lw96T8CDS4ly8tqnUnji0?=
 =?iso-8859-1?Q?wGA1OoHzgXX+wjqUzbCzyQA58ZndXzbeBAi5RrhHGPGtzUq5oMe5xsXOBx?=
 =?iso-8859-1?Q?Fp9WcPxDd77oHjtR2ehAhvnwQsOf5Ei56unF8Afl3qV+rdB/70mxq8k2oR?=
 =?iso-8859-1?Q?BAu6c3XztuhLdw0riOMIJcLhMj/HZhIDQZtSxpDu8i9bxHZpazmTAh+92d?=
 =?iso-8859-1?Q?+He01rnWnuNRNxRQAhHkiCNmx3iSm0y148t8DXbknJyTuHtlHH2hzcwlsX?=
 =?iso-8859-1?Q?Cn5YauVbuTAaCHScZJF3Utm6LtssnILT5AetcRXmLBXVg5WR/hoMXroPHD?=
 =?iso-8859-1?Q?kjROI2OH2gMfeEC5rOri1XWWI/CxNs6nX6kHV8zltbGXRagPqUIKq0qMYQ?=
 =?iso-8859-1?Q?p88liRTNFpRTnRpVwY8wE2qj4k1FEfGdXnyfHbTIOVtDMDFkd4BKLcnqaf?=
 =?iso-8859-1?Q?f//v2bIHVd1nTZCzBQuHwSMO77ixXFJRqx+2GDPCfmskgn/UrCpRoAnfZv?=
 =?iso-8859-1?Q?Hgv9DSp6pi/ZOfjqGOaw2xe15MKSqxM6tWB3e4zvoOJX9cG2bxGP4A/YtM?=
 =?iso-8859-1?Q?ZQ7YX9pd+LAPEh6Iisishxs9TvpSlg8iyTlC3lJPsWuV04RfsDUV4gI4d3?=
 =?iso-8859-1?Q?8ipdnObq5GLgukWW1EdWY4TMT8bYgTs3XbMf2yt5FNu8AJdbLPX4kER/w4?=
 =?iso-8859-1?Q?ZKBsiC93sQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZArIToNqJK+ypgNUJbeQXNRg9e8lYJFqURGOUQGp83fDTM3JL2O0YWwyfdpAStZHomP8JtncFCLdaiPCW6uKfsY/nXCufLkYqeEWKIopwrkb//7SIfoRkVg0qM117EnY5XBb7UA+vkjysR7Qpeqm4WOD+HpMYNAUQg735rg8uXywuUkDeX53c1fzTwErhHvX73auuW3Ozp4vsjbw5vKEbWjcqTcIn5nwexAsRrvUW76PtMJca4fk7yEtfImDyOrDHVzniU/sVzWwSM9Ozd+kpLrn2cglLPXX/e/E5YRgKUpdqsdJ+l7gEbNm09BUX9QFauNRwYAAJVDdoEIpkqpmaA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b126571-135c-419d-abea-08de9c31703c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 03:28:48.3501 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NEzKGFAcGNtU3fLXylTaHHoUNYRRhIOLwwGO+1PQn3iaBTmgusttox/Eg1XT0oNXC4dmMllZp2+Bx/jo4OjWjfjoWvLA4YGRn1c1n2VTGoA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6299
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
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
index 2150261f40..d6c60b1d34 100644=0A=
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
@@ -864,6 +876,35 @@ static const TypeInfo aspeed_2600_scu_info =3D {=0A=
     .class_init =3D aspeed_2600_scu_class_init,=0A=
 };=0A=
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
@@ -891,10 +932,14 @@ static uint64_t aspeed_ast2700_scu_read(void *opaque,=
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
@@ -906,6 +951,63 @@ static void aspeed_ast2700_scu_write(void *opaque, hwa=
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
@@ -933,6 +1035,8 @@ static const uint32_t ast2700_a0_resets[ASPEED_AST2700=
_SCU_NR_REGS] =3D {=0A=
     [AST2700_HW_STRAP1_SEC1]        =3D 0x000000FF,=0A=
     [AST2700_HW_STRAP1_SEC2]        =3D 0x00000000,=0A=
     [AST2700_HW_STRAP1_SEC3]        =3D 0x1000408F,=0A=
+    [AST2700_SCU_SSP_CTRL_0]        =3D 0x000007FE,=0A=
+    [AST2700_SCU_SYS_RST_CTRL_1]    =3D 0xFFC37FDC,=0A=
     [AST2700_SCU_HPLL_PARAM]        =3D 0x0000009f,=0A=
     [AST2700_SCU_HPLL_EXT_PARAM]    =3D 0x8000004f,=0A=
     [AST2700_SCU_DPLL_PARAM]        =3D 0x0080009f,=0A=
@@ -952,12 +1056,17 @@ static const uint32_t ast2700_a0_resets[ASPEED_AST27=
00_SCU_NR_REGS] =3D {=0A=
 =0A=
 static void aspeed_ast2700_scu_reset(DeviceState *dev)=0A=
 {=0A=
+    Aspeed2700SCUState *a =3D ASPEED_2700_SCU(dev);=0A=
     AspeedSCUState *s =3D ASPEED_SCU(dev);=0A=
     AspeedSCUClass *asc =3D ASPEED_SCU_GET_CLASS(dev);=0A=
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

