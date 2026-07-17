Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B482C44514
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 08:19:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkdmG-0006nm-8k; Fri, 17 Jul 2026 04:18:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wkdmE-0006nD-EK; Fri, 17 Jul 2026 04:18:34 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wkdmA-0000Cy-S6; Fri, 17 Jul 2026 04:18:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LelLSG8osT7mtJPj/PIjJWQ4WdEw/Fv+j3RAwpxrnKDeQR9NApUrpdGhyEUUWVLIcyH37VSNcEWKsxxQ0F5PH5yEGItw8oQaoyJX9riz04m2zzOrsotEgZq2Kua1HbyEGGqDyRUZicuN1cpw61+/yBxKUuWpSqFxVN20AVzZc46eVDOU4zfHQ2ddEEnOBDVyrn2p5A5zuIfA9LXhaJy87jxHiNKWFEE1a/eP7oIPBWiNwyjg2xGa7+KYq6Glou4IOrfhPF26ELrHWFJHNo0vnh5GW8aqd4gtVQ5wed3yJwrJdY5S95zxKx48HLooXT5zEiPz8cfFwVsNSIEK85J+WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bx3Iojt6We9l2KiNM6vA/h9zsim8zdynz8i4yrlpFBU=;
 b=SEnKp00r3KGr+qfu+ugW089T2ke29Q5SOi4nxvHjxuYTb1zKsJRorlkBCCo8s0WlyP9oRsR1jEzloUb6M/154axLytEJd/42bgytSK/U1WMOKZ8IULT6CbpX4edi+y1nHmc164lOdNTQuGKdhK03SR/yDFVLhD+3pWBXgEETp086qDzDy5VeFrSw+mWw88/LNOCGaEqi9TeqGfrcQFNgAYBq6toBZUfy3imAKPh4B3NhkslJzV2eN4n52Ru5vZPMtoAdF8ZNq9Bu4wbtvgGYKuuzUrFfHbCFUz7ygWzdmei0+9kJCuB2BTtGpUClP2mZhE6DJ7PpV4DjeN4GM6YQFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bx3Iojt6We9l2KiNM6vA/h9zsim8zdynz8i4yrlpFBU=;
 b=KjleQjHsNxoXxiiKFpa1pNIEOSubWKy3vVExHqdBf4clr56wTSriwRBbi6q0wBoZmx46pm+BGvOvjTP+OoHrjCmuAUwdWmiA98/PE8PYMhMNPWBHncZfVIsCnU9Bh2MVEJC251FEA4N8UHgDpIvqECRTcQH5Y6oYhCq23+E5UbtKWoftgwz++OOHkibwsCzZf47Q2Ul8GCiBZzpAI90PdzYsYr6W/Dt4WBA0wUJ2HvU5sgfS+md3w9vVcDHAgr2AGKQH4AyJTT6Evb0NKpslYrc+NrSw+10CIOnz0PD1dgvAauecxOhekzkFeyEYnMlh777YkQcX+EkHq5GT1urAfA==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KU4PR06MB8339.apcprd06.prod.outlook.com (2603:1096:d10:7d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Fri, 17 Jul
 2026 08:18:20 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 08:18:20 +0000
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
Subject: [PATCH v3 5/9] hw/arm/aspeed_ast27x0: Pass realized PSP SoC to
 SSP/TSP initialization
Thread-Topic: [PATCH v3 5/9] hw/arm/aspeed_ast27x0: Pass realized PSP SoC to
 SSP/TSP initialization
Thread-Index: AQHdFcTT0b7FFW1VA0KE3Oc87sJrfw==
Date: Fri, 17 Jul 2026 08:18:20 +0000
Message-ID: <20260717081813.3407862-6-jamin_lin@aspeedtech.com>
References: <20260717081813.3407862-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260717081813.3407862-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|KU4PR06MB8339:EE_
x-ms-office365-filtering-correlation-id: b61e192c-400e-4ff4-3f76-08dee3dbf657
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|366016|1800799024|38070700021|921020|6133799003|56012099006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: kOU1Hm+DDctUIbEZv/VfhH4L1e66WR4vMyFuqmIrEHLEKGuMS6OCzOLCKODMPGS7F5ay/cIqZRsVyM0+MjikUvPR3ITOEqq3xLKSpCkLzh4X3WgI9dRwONSSGNWDZlz0j1NvREjtEhKJXd7ZhfmXmjMYb/Z9VpR3qTP//4954Yg10W8jcitudyzz0BFmcMtQu3wGhWebeYSleePDg/zZMieJyQubVQNByd6ee052vP7R43paHTOgGx07grdyLAQZEQaHK1lqe+XFQgnc+/i9dczoNyDOpy1hczpvf6fmhnLZMWqy0gSSJ5rQNWhWxQDJj0RRfghYRnqQiYngMsB/Y/ClG+8plkoUJx7oGnUHCFtCcig8qEVZLTL2rhRaMlGzmpjlWgn5V8Hi6wzBjvNTO2X4EmNijpGxo8Pe/4L6rmrbV1ANWb5k6hPAUgPkOQ7HFLTZoLRw1BSN7gHd6teV0RvRLomHs8ELCYzGmFYE6iTGxcdzXyF+HaWD1Ij2MYiddPgZ57EG4oWJXICuqyRyqsgrRxt2HmdQuyBIWT0B7JDJZUumKoovRLEdyf44Pd4uXdGuY+Y0ys2PQBtQtJSbEr8wQWi8RsGY8hw32aNMNThcuyDj/vSIq8DHsKykoAr/tVF4TEy1xrGnPCJ01UGXQTgpxc6w7y0AviSbtHnHFujUlwejWvyht0nPsYKLe70Auk/0TU9z40/DrcIzHx7RkzjXBkMVR9/YYo76E/FUSQlW3Ddm9XzpmNUINyqc6KLc
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(38070700021)(921020)(6133799003)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?uwZUZbkM3lKN8C+Jw65w5lNT8cj8mUcMenoaW4lFtBDhOAp5a2Wjp1nKyk?=
 =?iso-8859-1?Q?Fujg4+kG16i+ET48tKPnZSP9t3MxolL8fD4RxuVxJK8tPAOX58+nFOz39M?=
 =?iso-8859-1?Q?ozMizbsDSqaZlHUn/8uFcl53CiCEZiTxOkGa4CEAeeZcAWEv3AKZRbSVwj?=
 =?iso-8859-1?Q?QRclAtebuMmCCXpjxdWwsryLUIbD98r40b98jpfMT7eiBJGU4irpoddkob?=
 =?iso-8859-1?Q?zt3oa7xs4T88nf9YMmaKZq2AcnLtLNEqamypNt2fh7bKA3YHqbyWYb85Gt?=
 =?iso-8859-1?Q?Vhd1YDRYwZdGBBmmtcyTnAHvVCYIxuYGPY43DUqsaI11P6pVT4LCwQ1UxH?=
 =?iso-8859-1?Q?yXgUBzGF+THIV9JBOoWuMkirguKHvX0Aphf4k2QSf57K5kRg09RUWf3+uQ?=
 =?iso-8859-1?Q?tOj/K3Pzt3f493bthXTrLQa7GAP2frM4bNDjVpn7rguSf9tjW8msj99BOE?=
 =?iso-8859-1?Q?8sOFoZGKU1WQ2HRcLOiw2W0npIVew+IHLxcv3BxGTJWmPPID5deQXLv+sG?=
 =?iso-8859-1?Q?SEEdbBgEoB6lW8nycHeoZpwBeWUY/8ohX/IRNiw+p0CuuGEGwLpUlv4Ov2?=
 =?iso-8859-1?Q?ZrREdg5+G/i20Q96oHbBkbhToAAkB7xaKHK5bV0Sx2G6StXP79vxknZUqA?=
 =?iso-8859-1?Q?bsBbfA48TJXx+bS0A5hg43E+3kMPz5dZYKCFx37eHTvo0Grv/5KLO6PB1S?=
 =?iso-8859-1?Q?gz8AiTZSojfHj331PAeW+uQjePp6Adv7w2SDU12njuTmmCfCv/RecXDcSR?=
 =?iso-8859-1?Q?UIEIJC/2TQCVrZMs3rnGss3BHg6z7px8aIbC0wXoLjX0GPxaLSjjT5M8AT?=
 =?iso-8859-1?Q?EODppI4tl51OU8clTWZ7nGK40dscVHoje1xtuyfkT2nzayxO7rk8zQ6//d?=
 =?iso-8859-1?Q?LOqqiSJguOmywwWxTvbPbdFYY1YgnfbGUqUevrDKiozS8ZAIUDpXeQeVSg?=
 =?iso-8859-1?Q?yDbjjbriW1o6ivm6vCiKuKtJ3tdLe24F/1LrfkAO6QqTqqekvBDI8aptiv?=
 =?iso-8859-1?Q?T5hMCyGFRnWGRbYIhsm0jwrUZnyn4Zx4RSXCDQq+i922bt57hGAdmzj5HK?=
 =?iso-8859-1?Q?BjJYXb4J8h8m4HgGIeauSY7fj0sT35AswUaVtzPdaoMgSTn9FyPa6O+w+U?=
 =?iso-8859-1?Q?ljovYj9+Q/kMTp9NjeUojxYvUA3xn/rDC+Sv+AN7LF3vrwLkHe84E5FQE5?=
 =?iso-8859-1?Q?WypQ6heTiiIjuhZABwB65R8JNUYyRjq9fENaoqeoacqnV32PgvzTBxRfdQ?=
 =?iso-8859-1?Q?oN/k4ydhg0T7i5eYJGAO4bLA4TsCwciBPH6BnpGARoLMWdTr3M+vEZK+co?=
 =?iso-8859-1?Q?Uxg/dJJoZyPQpeZHlo0uWT45YwOACTnlvVsK/Pou+T6cDm9UfLF4sccPLz?=
 =?iso-8859-1?Q?8xkZYOUuXVSf5iF6t5TyTXobEquZJTjQQwHBfo12l4KC4e2eSUWFiXxQia?=
 =?iso-8859-1?Q?Y6oW1lwQX8F04LHUQp2KdfYmsNz5veBEz3B2Xp8acd/q4TgKTa5nOejN2i?=
 =?iso-8859-1?Q?7LZWfd8qpTHxDMR7GXsOWbLnjgMnnfVrOWFQYRiI8ddO92kTHOKOzJr715?=
 =?iso-8859-1?Q?rYWv6xqdypBxacJEAAY/+rgYSrg7GYChXD/9nvEsneJTsARdwcDxcFbRjU?=
 =?iso-8859-1?Q?1swDDM56cufqvu4j+U2ZSUCGQsAXT/3ZuU3+oJc8vAh4bhjpxXj6wnaWDr?=
 =?iso-8859-1?Q?QnusGqAUUgBnH4UZbh8+YRQiguFejSinw6d+t75JkvwYDMN3lY95ttt1px?=
 =?iso-8859-1?Q?0tecEvCUiFdXq9CT71XE+kLgcsk9W4UBqo7rBkfnsCLmG5Wox8BPOXYf+o?=
 =?iso-8859-1?Q?0PMrRhLR5Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: C4kLuu6t2x0ycCn+eHrylA6Zel5g2niUONBBHaknmH/14MIt+UBiDO9QuSKDDzCBDRrH+U9WNw8YbJdiFm4K6aWWUsKxRvfWt4E3gLU2QPW7jBSegKJ2c/sVfn68AzYCe/R32+rvssUAJnvEOa+HN+mD77jvrFpRRh90Eaqlg2Up+Xca/cEVFsa/Z+IklSa+5JUtQu+jhPgDHk8+DAgNo66zFBxoDLbhVbi0WxiJMgMg1c81cbfB6a8MMWBp0aPkNzdA/dM8ZoEbewii5ZzPAmOW+b0tFYZSa+9c61XwfM0rl/lteUCyuBOrnOFSvyAr9GgIDBx/vN+NjW/euoa/qg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b61e192c-400e-4ff4-3f76-08dee3dbf657
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 08:18:20.2223 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cLEHxgjRr0E2Alm9OPtpy6QT5t4PGlNwzenmu+T5v9/0q7ckxx4t0RwI6qeqVL4rL9G5sC8YmbKrLTmYkENEqucWN47cA16GvNbEWlamw/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU4PR06MB8339
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

Pass the realized PSP SoC to the SSP/TSP initialization helpers instead=0A=
of retrieving it from the MachineState.=0A=
=0A=
This makes the dependency explicit, since the SSP and TSP coprocessors=0A=
use resources owned by the PSP SoC, including the UARTs, SRAM, SCU and=0A=
SCUIO. The PSP SoC must therefore be realized before the coprocessors=0A=
are initialized.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
Tested-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
---=0A=
 hw/arm/aspeed_ast27x0-fc.c | 26 ++++++++++++++++----------=0A=
 1 file changed, 16 insertions(+), 10 deletions(-)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c=0A=
index 8d49bb95d6..58d0b4d7cd 100644=0A=
--- a/hw/arm/aspeed_ast27x0-fc.c=0A=
+++ b/hw/arm/aspeed_ast27x0-fc.c=0A=
@@ -134,11 +134,9 @@ static bool ast2700fc_ca35_init(MachineState *machine,=
 Error **errp)=0A=
     return true;=0A=
 }=0A=
 =0A=
-static bool ast2700fc_ssp_init(MachineState *machine, Error **errp)=0A=
+static bool ast2700fc_ssp_init(Ast2700FCState *s, AspeedSoCState *psp,=0A=
+                               Error **errp)=0A=
 {=0A=
-    Ast2700FCState *s =3D AST2700FC(machine);=0A=
-    AspeedSoCState *psp =3D ASPEED_SOC(&s->ca35);=0A=
-=0A=
     s->ssp_sysclk =3D clock_new(OBJECT(s), "SSP_SYSCLK");=0A=
     clock_set_hz(s->ssp_sysclk, 200000000ULL);=0A=
 =0A=
@@ -166,11 +164,9 @@ static bool ast2700fc_ssp_init(MachineState *machine, =
Error **errp)=0A=
     return true;=0A=
 }=0A=
 =0A=
-static bool ast2700fc_tsp_init(MachineState *machine, Error **errp)=0A=
+static bool ast2700fc_tsp_init(Ast2700FCState *s, AspeedSoCState *psp,=0A=
+                               Error **errp)=0A=
 {=0A=
-    Ast2700FCState *s =3D AST2700FC(machine);=0A=
-    AspeedSoCState *psp =3D ASPEED_SOC(&s->ca35);=0A=
-=0A=
     s->tsp_sysclk =3D clock_new(OBJECT(s), "TSP_SYSCLK");=0A=
     clock_set_hz(s->tsp_sysclk, 200000000ULL);=0A=
 =0A=
@@ -200,9 +196,19 @@ static bool ast2700fc_tsp_init(MachineState *machine, =
Error **errp)=0A=
 =0A=
 static void ast2700fc_init(MachineState *machine)=0A=
 {=0A=
+    Ast2700FCState *s =3D AST2700FC(machine);=0A=
+    AspeedSoCState *psp;=0A=
+=0A=
     ast2700fc_ca35_init(machine, &error_abort);=0A=
-    ast2700fc_ssp_init(machine, &error_abort);=0A=
-    ast2700fc_tsp_init(machine, &error_abort);=0A=
+=0A=
+    /*=0A=
+     * SSP and TSP use resources owned by the PSP SoC, such as UART,=0A=
+     * SRAM, SCU and SCUIO.  Therefore the PSP SoC must be realized=0A=
+     * before the coprocessors are initialized.=0A=
+     */=0A=
+    psp =3D ASPEED_SOC(&s->ca35);=0A=
+    ast2700fc_ssp_init(s, psp, &error_abort);=0A=
+    ast2700fc_tsp_init(s, psp, &error_abort);=0A=
 }=0A=
 =0A=
 static void ast2700fc_class_init(ObjectClass *oc, const void *data)=0A=
-- =0A=
2.43.0=0A=

