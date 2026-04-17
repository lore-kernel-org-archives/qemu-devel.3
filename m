Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68291F8E4A4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 03:32:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDZtE-0002LR-Sq; Thu, 16 Apr 2026 23:29:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDZtD-0002KI-KS; Thu, 16 Apr 2026 23:29:07 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDZtC-0005oG-3u; Thu, 16 Apr 2026 23:29:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TlbHvXIAX8fv2Bolc8sfskZzINob7vttanKk32mOUG7K1fCOm9uQiX6F5KUFtWN62Vg011XfGmP3h47yfWLzR5ckQ+6rbAJBAxgQDIE0h/ZrFqILn4wBZvw89iMcfmlQ45imBcO6zxjCJin/xBjClgSGNrpqZ1Kww4S0ZHJFy1U+12jXd00llyr0ktHhmAOZr1dmq+8zvZNv0n965y557DeIP9BBJeZFGgFZRhpsPQU9BuzIluwo3u0HINQrdj6dD4nra8g4ZOrEXFuj74LNYCgsqHk7x/KMTvZcHpiSKQrTXJ3Q2NcL3pWpkIGUcIt98xz0iCeyasJ5+g7WSDX6tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qaoxux3U7tEqsD1k+2i7SKWa2qpmqjynjl9i7U6MyhE=;
 b=QTLRVMAs2Eh8POi4QB3S/DuEZcDOaH6YwzPr70SG1WOiHajs8Q5+f/Ll2vWQnctDt+N0jHy5vi2E1s+r0n4EattP5D92+nQ4AYs2wkmdTMAyWJW1P+/IxLir7uTGaVcbGPqK4K/r8UYjhP3frnvSc5t1kHjOlidgp11KeZDPuF+hNJ51YOKs0gVNBTEPupfnGTS3ECzwBMfUF5/z0erWtPnN+81oJmN4Ojxh+H0v9HtAKj0/bLA8L6oFSy3dVWbDBtHAC6TEDt3c6LCIp7iSh/L1G6DWGk34ol+i+qSKBGjlha3vHvCpDwwq4jnVC3FIcBytiRLJ/R8//TiOn1e7rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qaoxux3U7tEqsD1k+2i7SKWa2qpmqjynjl9i7U6MyhE=;
 b=ER4x3qWDKurqP0UV1rz+co+0ehWxjDaiZYRzRxKa+r+tC+9nFB0TMWyUdwMIBMa+wklKUr51F/6qOL54UVSyNib1f4CtYRMU0np9MZUo9Gh9RH6FKOONU2Sp0SrnkOESg+eqU+YA74mzKLzKLkqWeEEpfBxCsBjn0ApnqTiK9a27wUgLMLNZlNjfE2rXGB8cv3oN+uBEaw57aIChBK52NQOlixAklu9jMTGMLp0DSoonVhp9YVQB0zZkvGyJL9UqTCzIlqTmLwrZSUU/X5IcCdZKHI4kpp2pk+IixbWFsUpIGLAokUNB9J2NFMLnO9GSF/+7lPjAoXXJUuIyaT8lWw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB6299.apcprd06.prod.outlook.com (2603:1096:820:ce::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 03:28:52 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 03:28:52 +0000
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
Subject: [PATCH v4 10/21] hw/misc/aspeed_scu: Add SCU support for TSP SDRAM
 remap
Thread-Topic: [PATCH v4 10/21] hw/misc/aspeed_scu: Add SCU support for TSP
 SDRAM remap
Thread-Index: AQHczhpQEnjI9zXqzUS3EPg2LKDiuQ==
Date: Fri, 17 Apr 2026 03:28:52 +0000
Message-ID: <20260417032837.2664122-11-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 6291e928-e6a6-477b-9dda-08de9c317290
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|921020|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 5fxDAxiHGr4/anM0/L/MaqYa21ULDcZBpRNLFzt3OvaFMBxBgejQKUWOVtswMrHAY48qhgeqz8DXZw98SOeAfh9uLlqWk39PgaWpWIED7BYTf7Dp+kpEEe+QG7CkH5+g4hickwMu6GMpArTsGF1CYzlnViOk+rsQgRnqzwL6T8+UCoz40IKlO5DWQJ5ypJfln/wDRsn5lUzOtG0ybSODu9iaaz3BszYY9xCOJ1uElBPfcKFMR5dEmD05Zu16p2/Qvs3iIq3rkap+rWRRnCokRzf69JpepYGeHNGOpzQHL3ZkGzC0SaHHMg45XUEOAkIRhmuWGoYsVPoFDZ/A6MbldO8Ed3pivEwsKD9w3LgiG3xtr4CxYROgGJ2+Vj4jk0Sd/F80QrbBC9XUyp/bu1anXVYCm3MhUGHQWIrNlbXhSBaltzVplyg+icNznUlKE7iyBfaLfJZRdCZ8+otrNXzLpW1fcKU9GfLwJg/NaPt63/F1Lllh09lb9tVWon7o+sWHNyhQbtV4N24SDIcdQskeKpizxEerW19CyhvWXfquSBuO/NMNhrBMu4D2balDEJ6rg/NkokPVtW14tE8PzVwS3Vm2ZEU5eueUrJnJdCGVuBbInmRn6g/eGF68ER4KzIGdKpu/0b3gGipcAJZjvrhvUigjcFZH7fGRcrM8/KNqCMzSsk8AZa9ObqGMeSHlWgowyU9XlWK6SQpMNOfH5i0nGOWIy5ATffedZlJ3lnFJm6sE0H7Sol9VQIhWdH3DW9IPfNkG2sNfJJQ6lpUXpXN4VmGkBG1zfb9ZlB4oaW4z6OJgakuIvLA4Pz+8Hw4s5SHw
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?b+V+R5NacbF3Q5khY+dD0P9OrZAUJqY9xhXPZoPYAzInZ+ScjsrK1AIGSK?=
 =?iso-8859-1?Q?bxjrkF4uDpQcbzwIKuNlTmCdpA0bOM/54fanX0sxJDTpPiQYuzyT9oPuFR?=
 =?iso-8859-1?Q?wiv+zceGNvvs1SseEzCfZPiL6SIUYrtAy9dwKtnJMaRc6H3VG4R/wMYSMz?=
 =?iso-8859-1?Q?Mkiia7/Mh9BNzXaIJJkP5xiU+e3apMZssG2kInY+MBvuqrthiwVnuxBDsc?=
 =?iso-8859-1?Q?VNG+J8kKKXM8sTxpS+doQgW1FqqF6hmb/Yr6eJUXRcsf4J1B46vDxWv/+c?=
 =?iso-8859-1?Q?LtNOky4SdyecFPinPaxpIm7SU3qVngGXYrWJestA4jRggGHPVf7GQF3Gg8?=
 =?iso-8859-1?Q?VHq7Ovb+2y6uSoYhz/S+0UsCV9SjZ/mtyKnK/xm3YdBPKyqwdoJYiWvHJh?=
 =?iso-8859-1?Q?oZjt0ZTTsvu/kbsqq9sAEpzBJG/WaebrxqK90bhw48AJtEJw+2+kny/L4t?=
 =?iso-8859-1?Q?r8gKwD3WYT6RwTRTdMaF7hxDfXSOZ4NhOFFUxBG3jn12mr/LZ6eyj4WMs3?=
 =?iso-8859-1?Q?y2d1EF93byne5SMW2jWDp+qnY2vQQgdaKCm07oPKYmIjRVq8Wr8tEFXs0e?=
 =?iso-8859-1?Q?26DdY8DxJv2/f27+o+ywWVvcX8TtZZVmDrp+rdb/Z2e8oeSa5rjRLQZ0e3?=
 =?iso-8859-1?Q?BBbOznS8Dr9hRrlUQ1UDPDq4qA2B7cQ7QLtBdXd6D4gmGQDYVuFMi6yb86?=
 =?iso-8859-1?Q?XasOHQjbBo2l0QUeoQa3pB1uw23jyVRWkbdLo2rcIycPzOCBh+q2jjQjkM?=
 =?iso-8859-1?Q?VY15L99V5oCYQqQklpDB1BAeqRRktyxHkd/mxoe5WkqSuViCsNS76Co4ah?=
 =?iso-8859-1?Q?w28nd9LN1sF8tMzjKFMm84Sl55JWOhj2gNvuZOULS0LSxIRBuD7402O4b7?=
 =?iso-8859-1?Q?55TVIAchIpq2vLXjTyj3QF46rRxVohoAehEyOO7S/kPT5NJojsP30SVyHC?=
 =?iso-8859-1?Q?u2sWsOoCYfU/NZiPEXj/4mohef9ux62pHSO+/5u1aGrHXglIC+TAgsu1xf?=
 =?iso-8859-1?Q?6FbGjanfWRpQYPFJC+Z+194PWXYrFvpZlnIU8B4mFCjF4yJEjBPD9jDvlA?=
 =?iso-8859-1?Q?BxxsoKrtPdOGCyomdyhKGuKaYC7W4KYIL8CmpcD+Z4D2QN7/eSpvqPvDZa?=
 =?iso-8859-1?Q?FgUDEBgm6RZmoKiHKca8/fniONt7i8O0OEZ4MifvV7pUf69CLLisZLyZnn?=
 =?iso-8859-1?Q?Xf27JKlblLgXidXthHZmT71i+xpSzO6B3aYcObaF/3K7VHJmGdSg5K8pjW?=
 =?iso-8859-1?Q?6Z3H4tJUpTMQT9fF7gAb8cLFeqjMBS2rFq20fvp++DA+cQNdpWjNXXai8w?=
 =?iso-8859-1?Q?SPq2e10VgNORJCGpcbYiexVRydgWdaLuhgdpYzVwGJRuODY42y/XfTjNRW?=
 =?iso-8859-1?Q?30aZ0HoU2vGfS+BRqw7Og8K9FB62P9k517yrnrhUkfXPoaKZRFTQkvJPPT?=
 =?iso-8859-1?Q?W/UmrRMI+rDzUJnEFbk7oouGV+X6B5fWvoTR0BTdWmXKRcN3ITK9Mzsun1?=
 =?iso-8859-1?Q?g2UecnEmWUHYH43H+1x5gvBLks5V8SI2aiJsbkuxYl1zZyPVeGEvTAT4So?=
 =?iso-8859-1?Q?Zr0pBsUsQ5QdGHw2C1Dw7Zj+3IS+Buo/aW82e0ybMNq/8gubtBGjo2gyrD?=
 =?iso-8859-1?Q?4NIys4SSwf9OLKQSLzGfS3nL3tHzWzIMdoOMHLSnQMclUvuQyjvWEeAH9N?=
 =?iso-8859-1?Q?4O/TcXsVVcsaD7t/o+9mQgqH2WuSg0EGFc2UNBl+Y3Hl+T9Vm8dQUsB3SM?=
 =?iso-8859-1?Q?bYtXNCqOIQff9v0fjSwTq3hiUrJuOrvktGMB1iiqomhi9wi6OO11I5ymFU?=
 =?iso-8859-1?Q?9Wox0OQeNA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: uSAc13IME/ca5yZwiflB4mhonxGufY7jESlKwrxwSnslu8deDhCPEfXVuMjYrK46voyHJtGO0+yLd6cq2vweyhQghUw1ZS+oq0tMXhpO46i0TUgq8qofNMcD0pfWzLiy6BHzcucSa26PNRzHTpE85Sktr0Uen/YkioPGzQISmftvje2AJd7eaeyyeWfC17dB9Xh10nqFbciuHB38BLyJVqvqmZOX5veWdGsFWkHgiA6zqyawZ18v5k7c4ANmokujCAfazwVfl22OjjHheFptabWFgwgbkpju6NEqjnas11s175gEx0CIpseWBXK5BTU9jxI5NFEphd/HXU2QRuRNng==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6291e928-e6a6-477b-9dda-08de9c317290
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 03:28:52.2504 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rh5JIksINPj96wTGoRLMZl2B+/IyXic+guPcYCMQm6lZnap4S4eWqYuOm8RClaRQ489g71qoB9NpckZlhjVvQFHe3qv17LZikIdGZ1PGu6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6299
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

This commit adds SCU register support for TSP SDRAM remap control and runti=
me=0A=
activation. Unlike SSP, the TSP does not support configurable target addres=
s remapping=0A=
through SCU registers. It only supports setting the PSP DRAM base and size,=
 which=0A=
are then aliased into the TSP-visible SDRAM window.=0A=
=0A=
coprocessor_sdram_remap[2]: maps PSP DRAM offset 0x42E000000 (size: 32MB) t=
o TSP SDRAM=0A=
      offset 0x0=0A=
=0A=
The SCU registers AST2700_SCU_TSP_CTRL_1 and=0A=
AST2700_SCU_TSP_REMAP_SIZE_2 allow runtime reconfiguration of the DRAM base=
 (alias offset)=0A=
and mapping size.=0A=
=0A=
|------------------------------------------|         |---------------------=
-------|=0A=
|               PSP DRAM                   |         |        TSP SDRAM    =
       |=0A=
|------------------------------------------|         |---------------------=
-------|=0A=
| 0x42E0_0000_0 (SCU_168 << 4)             |         | 0x0000_0000         =
       |=0A=
|   remap base                             |------>  |  - fixed target addr=
       |=0A=
|   size: 32MB    (SCU_194)                |         |                     =
       |=0A=
|------------------------------------------|         |---------------------=
-------|=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/misc/aspeed_scu.c | 23 +++++++++++++++++++++++=0A=
 1 file changed, 23 insertions(+)=0A=
=0A=
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c=0A=
index 8d1ad95402..251c23def0 100644=0A=
--- a/hw/misc/aspeed_scu.c=0A=
+++ b/hw/misc/aspeed_scu.c=0A=
@@ -161,6 +161,8 @@=0A=
 #define AST2700_SSP_TSP_RST_RB          BIT(8)=0A=
 #define AST2700_SSP_TSP_RST_HOLD_RB     BIT(9)=0A=
 #define AST2700_SSP_TSP_RST_SRC_RB      BIT(10)=0A=
+#define AST2700_SCU_TSP_CTRL_1          TO_REG(0x168)=0A=
+#define AST2700_SCU_TSP_REMAP_SIZE_2    TO_REG(0x194)=0A=
 #define AST2700_SCU_SYS_RST_CTRL_1      TO_REG(0x200)=0A=
 #define AST2700_SCU_SYS_RST_CLR_1       TO_REG(0x204)=0A=
 #define AST2700_SCU_SYS_RST_SSP         BIT(30)=0A=
@@ -1035,6 +1037,23 @@ static void aspeed_ast2700_scu_write(void *opaque, h=
waddr offset,=0A=
         data &=3D 0x3fffffff;=0A=
         memory_region_set_size(mr, data);=0A=
         break;=0A=
+    case AST2700_SCU_TSP_CTRL_1:=0A=
+        mr =3D &a->dram_remap_alias[2];=0A=
+        if (a->tsp_cpuid < 0 || mr =3D=3D NULL) {=0A=
+            return;=0A=
+        }=0A=
+        data &=3D 0x7fffffff;=0A=
+        memory_region_set_alias_offset(mr,=0A=
+                                       ((uint64_t) data << 4) & 0x3fffffff=
f);=0A=
+        break;=0A=
+    case AST2700_SCU_TSP_REMAP_SIZE_2:=0A=
+        mr =3D &a->dram_remap_alias[2];=0A=
+        if (a->tsp_cpuid < 0 || mr =3D=3D NULL) {=0A=
+            return;=0A=
+        }=0A=
+        data &=3D 0x3fffffff;=0A=
+        memory_region_set_size(mr, data);=0A=
+        break;=0A=
     case AST2700_SCU_SYS_RST_CTRL_1:=0A=
         if (a->ssp_cpuid < 0) {=0A=
             return;=0A=
@@ -1114,6 +1133,8 @@ static const uint32_t ast2700_a0_resets[ASPEED_AST270=
0_SCU_NR_REGS] =3D {=0A=
     [AST2700_SCU_SSP_REMAP_ADDR_2]  =3D 0x00000000,=0A=
     [AST2700_SCU_SSP_REMAP_SIZE_2]  =3D 0x05880000,=0A=
     [AST2700_SCU_TSP_CTRL_0]        =3D 0x000007FE,=0A=
+    [AST2700_SCU_TSP_CTRL_1]        =3D 0x42E00000,=0A=
+    [AST2700_SCU_TSP_REMAP_SIZE_2]  =3D 0x02000000,=0A=
     [AST2700_SCU_SYS_RST_CTRL_1]    =3D 0xFFC37FDC,=0A=
     [AST2700_SCU_SYS_RST_CTRL_2]    =3D 0x00001FFF,=0A=
     [AST2700_SCU_HPLL_PARAM]        =3D 0x0000009f,=0A=
@@ -1155,6 +1176,8 @@ static void aspeed_ast2700_scu_reset(DeviceState *dev=
)=0A=
 =0A=
     if (a->tsp_cpuid > 0) {=0A=
         arm_set_cpu_off(a->tsp_cpuid);=0A=
+        memory_region_set_alias_offset(&a->dram_remap_alias[2], 0x2e000000=
);=0A=
+        memory_region_set_size(&a->dram_remap_alias[2], 32 * MiB);=0A=
     }=0A=
 }=0A=
 =0A=
-- =0A=
2.43.0=0A=

