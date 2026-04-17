Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D213BF8E499
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 03:31:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDZt6-0002F2-IE; Thu, 16 Apr 2026 23:29:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDZt4-0002E7-RI; Thu, 16 Apr 2026 23:28:58 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDZt3-0005oG-4j; Thu, 16 Apr 2026 23:28:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bd1aF8EOuN6+RbH69TYubyar3wlU4CLZ064Z6OshWP1lRj3OVhp3peiL/tcPzZsx4oR30v/0yUwDt0lXEZUscWGdpD0k+sZkr9sJkPt8/rNa7l7G4uWIa+uPlu8tsyq+uonBrghMsF/s7ORAsi7o8aCIHmITzm7YC4rL/BZi96Tbl5DSpJjxwSHsH38/nsLcvdm2dprozlVDUMbHwcqr8EBMPItGbCo0GPqoL3ru4oy450HUieHrSvkVW7M+F7c+1nFyD4NG7ItY4hrFUEc8ldzdKhzkHXC7bHDmmrh3iV+OXI2v4NWmMhRfz+MVrYejmte/+G6yT5z5xYtzDiSK6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0e+xjd7ySC59jWZIeY6oWCYA1XZY84Kbg7cGwbgv0wY=;
 b=zJkXpFGmKsXFRS4N9N0CbOr3SkfJ2kQnoz4fVAZOywhzpopjddwdkwqSlMsOJBaFROM2DmXdy3+CkcZD7rYpee6fbN6nN+HfJ25DzVDavet5kAbbNac8a+WtGtJGxB7B1REXWRpJepSqn/w9TffWwnNBHftE6O+YLR2wack3D5vwgTNQWvFA6rNaPUAq7L3jCWPbVyXIi8F/Tsrbt9cCiZFOYfFX4+9RYTPJ2dOsfYwZWHItk6CIcNCSUiOhamVt/JzFbgA2FAILnuDHF4MO1GQUxWa/tBHJXHqjbFGdMtddm8+TlSDxRbgNGMsBupHJPvDIFfXHTgB4aQKg9Nkzdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0e+xjd7ySC59jWZIeY6oWCYA1XZY84Kbg7cGwbgv0wY=;
 b=GTn4RbwDAW3KHh+0lX8FCIbXLYaMG+iaFAFnPW6FuIXEQNcUGACBkyjheN9+ZgFtshn8ROktNrMMthuoU2cdsYX1AgvkiRk2dA8VedL+LtGTWzL6sD4ProIrLWzU6YpDoorXa2fOHxyx1OkPaVFnao6n3hhXlQxZJfFck3+7+iO/ALnqBtz78hUOj/AAjBGDrMYrvRsywm54gJpmySgGepJFEp8aPZX3IkXehY07bRaof8/wPZ6Qh04KkDe1j0ckHi9vOWvX1ZRLbaRNt8XYpDwpx5mjBxYzcHwp3AwxtiTYzB/FlxdOKUo9DLBcJupft5VlzT5KoiQAzAiIBF8XTw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB6299.apcprd06.prod.outlook.com (2603:1096:820:ce::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 03:28:46 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 03:28:46 +0000
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
Subject: [PATCH v4 05/21] hw/arm/ast27x0: Add DRAM alias for SSP SDRAM remap
Thread-Topic: [PATCH v4 05/21] hw/arm/ast27x0: Add DRAM alias for SSP SDRAM
 remap
Thread-Index: AQHczhpMih2bvP+gF0eQLYKwHPAx6Q==
Date: Fri, 17 Apr 2026 03:28:45 +0000
Message-ID: <20260417032837.2664122-6-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: eb3814d3-bf28-4755-3fc9-08de9c316eeb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|921020|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: UYNJTYbpiFzStUlwQCpQju57lxQDaysO2Gsg978ZJ/vtn5s6Wp7keAxIYN/8ukUXiyNBXoLAd8Sh2JYNS05juD8KuzClKLrF7DlhVECePVtrb9DWgtuRN/vTY9CRLdiJLKQlN3Qxv/EN5L5GAQn5HfXpFGDAFmOzpEz1VaBXH3Crtu2OLgSj+hnDwrm/RR7bXjYehQHsRhs1Pl8LspOXmP0MqrsYGx4Brvmzir5d+4kK9See7FKj7gbkDXIpgEk6TYXcU4Gg7r+5i2/IUkPgQ1OpXGf1fFhftti/HjWYTC6NVjz3IeoJegdutaK/cdIXvUVsqNRhpY3nWbKy0gYFrTKTQSFdh/hyczA8o2FriyN1BSAR0Ik7Zfsqo+ScldVMiN9chfVsWQdQXzb7uGwULFr1delWtczRDP9F5ARKKyjUJ4soVn8XRWW8REET0R4iDw8OYEzqiynzB1gcZGKbco9EeZZZU2k+q1TxRbNEQhv9vNxSqbKmEW5nlqURFwlXI7N087plH4qG8WUAmuE5iuOij9l2rQlNIUea8UFY41nk/lFrutUl6mV4xUjMk887U3H3qHSZ3lBe7j3ytTqI78GyzXfU1HSTCIv3tYjTEnuv8R0dyjFMuIgYwtPRbF2j4zI6JKKjR/19ro2G3Esf0xGC+6bVxDCJuUaVLEGgu8Gb0ZbsHPCi+AhspG7NJhMw/cbWAOLF0alUOXyMM1Ij6yVmEGrhbzXX1RNaBgspyJKL1DIOG0pnv2NOS9VTNiz68snAYLB55cjfwKj3nAru4E+7bd2k+eUU/+V91QPjdS99xPJxAP2q/ZVgCHL3JqTY
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?30Z101IyaDLIoZZ6T+1k3G3+FWoGmgFYKS1wtUc3kO7CniA05XE58d9Lbm?=
 =?iso-8859-1?Q?PYVsg7plbd+F+mrHMM+XNeAXqlU+q4ak/0lwZXDUNrYmPqw0foegrgyKmb?=
 =?iso-8859-1?Q?ETWbxqYmLdfdXNlvDujCev14Fur4bTW++vAmsM7K9Vx3WI3idyVGuZ0BUv?=
 =?iso-8859-1?Q?027kbYxTofjTPrtTe5rOVSNSv2NggVQykwuPyb4ayjuT+MMt9vRNRFzTCL?=
 =?iso-8859-1?Q?Qf7ANnxPyyh1M+TxwDY5CyO40F5bfeSPaaVfV+FKOCVTHTlegGfnX0GFh4?=
 =?iso-8859-1?Q?C3vhfu5NUN8Se6KdtWipFN6C4Wqg0tGSnaucjmzb6Wn2HilfndutycwTUT?=
 =?iso-8859-1?Q?+yQe+s1jIjS13mbVLb3+/zzW/syLLV5I3BGFB9r1OpHjP9wKnSEHs5noZE?=
 =?iso-8859-1?Q?Z5UhM4T14dK9GswPZPOwxTy3XlMwqZFiDICDj3f1ldTw7QCWbEHgQoA8JE?=
 =?iso-8859-1?Q?ejM3CcC8+eg0nkcoPS22FTOSzv0LNEWMMzbsJLDWXvlyrvAutRAcfzAXac?=
 =?iso-8859-1?Q?FYzYUG6UJOM2qQePg2DEH7QvzqH8HV46p3i9nI1y34zutsjda67Be+xHZj?=
 =?iso-8859-1?Q?GUMSsovVMcTUdmekvfyRpqmXxdTYD91Jm28VWq86ZJ+ZVgVl+T5Y5nWEWK?=
 =?iso-8859-1?Q?IhbDP3lt63gzpuctP9I4NFlM5Xv1DXAh6+ceTftKonBjciAGGpaekgLSMw?=
 =?iso-8859-1?Q?omM2v2FRAcLcdJUXVcfiAiJ6xiNaWPbiv0CxQAChgposGEKLw4qoSSQ0je?=
 =?iso-8859-1?Q?wTrNhmVjt081GOnKV9gYouYYDSpy/4bphgaG4V39eWU52KH1cA5+6TaxAB?=
 =?iso-8859-1?Q?2/Mw1oDFb7jSTJKZxLFmksHe0iw/toG0kDvTsYL677a0Sjmd8bSoqOKrw5?=
 =?iso-8859-1?Q?yN72ukXZ/xrUH+/dysKdenewzMVTj50GWR6UQ/qy00ya2/S+3YSpnVCs9p?=
 =?iso-8859-1?Q?JU8EUT9MLASn57zU8cJhYmLmyISGkWmY8lWzoBbFAJkmhUL7fhPqte90M2?=
 =?iso-8859-1?Q?AOZKI4o8VcC2V55eRrQQn5ZvbT6oKPGsU7Btsyg4olCLquXVt/upMmSyts?=
 =?iso-8859-1?Q?3B/PqpWcQFmqetS+WbVefwtmw2VxNAE4Hb+EOhONNDQLGWmqcWYZy8fanX?=
 =?iso-8859-1?Q?aajYJmQPq8TdKfPh2MP00G2TfHtg/dbubPIDaUmRybYFcSO3l5miNqjUMz?=
 =?iso-8859-1?Q?LPUG8Hs8rDPIsqMRw0WE4yNJSTm+0TRHAfLE3iG/W657X/PQ5CKYntTh+T?=
 =?iso-8859-1?Q?WClGHZXt3TFwk9nMl63a6w5Vh7C1Ojrzic9o2GJ+0w+z76e0u9Sj7QBiif?=
 =?iso-8859-1?Q?dpSs7pYwV6AygvX4ryeJ9aV345xE0sBVDurpyzkEEOn5Sr6P6bEOS9o5Pu?=
 =?iso-8859-1?Q?Fn+4vDhFXP2PffBUfLAUr0FHFx6lyMx2s36WJy7pzPrDIKRIjx1z7ijdDj?=
 =?iso-8859-1?Q?yuOzhh97px9O/gfLLle5M2Com0cuFhQur6WnKGTAN72uenoV5NRX2MVSCV?=
 =?iso-8859-1?Q?Bet0zFC03++DPEQ/QnqI8r8YWCk7LLW8WwmQWMxTtWmwUOM5Ibn8ARE3/N?=
 =?iso-8859-1?Q?tUsg6q1XvlDkQLFPX8XO3SnI6v7Lb/5TeiaYq12vEMLK/iE7NHgvvS9rgV?=
 =?iso-8859-1?Q?Z3s/tlcVJswCPVknlhCw8PIZejdKsofHHi2yxLu9Y0Ql9/icshO3ndNl5O?=
 =?iso-8859-1?Q?CQmT4H5zl7ol8sEWgN3o+THvY2HsAVMPimfbe6nuAUFla5vtA2zoZnlcjq?=
 =?iso-8859-1?Q?zWlsAG8e48dYJZhuUPbNgys7afrdfbRfr2WmVfX1duofkB6oK5BD4CS1xP?=
 =?iso-8859-1?Q?u35XtSmPGQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: v9d2MbQWDUp3FE+6xxpu6CAF9jj77nxxg8ZJxeWWjnr6P66TqOJVEQ/px3wp0hZ3ugMFjDmjk+s4zD+BTm2lUJvx5RzO3QytsmEfTFLit3rfsdvS37/pxPvEDoXGv2zG9MBSwhVLps9BJXrP8eMpi5SfF1/Ovez2ZJhQB1HUGj+3ZycfpBauKiEnXkV/GBGHAu18X1opugWQl/G22IKUQLYA/stOUpruaXM8Fg6ZBza1g6qPMwvuw8TvCPujsUpLGsByIrmYmINEvvpCzYr+xPRIOiWcuB379p37MjwCwBbfY1rqML7r3ykrBM+K411qhvKOc26QvLdH7XZUNLrOJA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb3814d3-bf28-4755-3fc9-08de9c316eeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 03:28:45.5171 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mgjOqJ2iyBIW1bsJc9NHaXg+xKmgrham+ZqrkclXiB3hM1kUQtgnkSZ0deRy4uvraU3zMYPM/C4yjCnAPydEk49tiDAT6szrkWJYW3u0L6s=
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

This commit adds two MemoryRegion aliases to support PSP access to=0A=
SSP SDRAM through shared memory remapping.=0A=
=0A=
The SSP exposes two DRAM aliases:=0A=
  - remap1 maps PSP DRAM at 0x400000000 to SSP SDRAM offset 0x5880000=0A=
  - remap2 maps PSP DRAM at 0x42C000000 to SSP SDRAM offset 0x0=0A=
=0A=
These mappings follow the default SCU register configuration used by=0A=
the ASPEED SDK firmware, which defines the memory window mapping=0A=
between PSP and the SSP.=0A=
=0A=
Set SSP CPUID 4.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/misc/aspeed_scu.h |  4 ++++=0A=
 hw/arm/aspeed_ast27x0-fc.c   |  2 ++=0A=
 hw/arm/aspeed_ast27x0-ssp.c  |  6 ++++++=0A=
 hw/arm/aspeed_ast27x0.c      |  4 ++++=0A=
 hw/misc/aspeed_scu.c         | 36 ++++++++++++++++++++++++++++++++++++=0A=
 5 files changed, 52 insertions(+)=0A=
=0A=
diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h=0A=
index fd30313e69..106ab4b04a 100644=0A=
--- a/include/hw/misc/aspeed_scu.h=0A=
+++ b/include/hw/misc/aspeed_scu.h=0A=
@@ -44,6 +44,10 @@ struct AspeedSCUState {=0A=
 =0A=
 struct Aspeed2700SCUState {=0A=
     AspeedSCUState parent_obj;=0A=
+=0A=
+    MemoryRegion dram_remap_alias[3];=0A=
+    MemoryRegion *dram;=0A=
+    int ssp_cpuid;=0A=
 };=0A=
 =0A=
 #define AST2400_A1_SILICON_REV   0x02010303U=0A=
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c=0A=
index 46f0c97329..0688750e78 100644=0A=
--- a/hw/arm/aspeed_ast27x0-fc.c=0A=
+++ b/hw/arm/aspeed_ast27x0-fc.c=0A=
@@ -100,6 +100,8 @@ static bool ast2700fc_ca35_init(MachineState *machine, =
Error **errp)=0A=
                             sc->uarts_num, serial_hd(1));=0A=
     aspeed_soc_uart_set_chr(soc->uart, ASPEED_DEV_UART7, sc->uarts_base,=
=0A=
                             sc->uarts_num, serial_hd(2));=0A=
+    object_property_set_int(OBJECT(&s->ca35), "ssp-cpuid", 4,=0A=
+                            &error_abort);=0A=
     if (!qdev_realize(DEVICE(&s->ca35), NULL, errp)) {=0A=
         return false;=0A=
     }=0A=
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c=0A=
index edfcf1badb..0500c02755 100644=0A=
--- a/hw/arm/aspeed_ast27x0-ssp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-ssp.c=0A=
@@ -199,6 +199,12 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
     memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SCU],=0A=
                                 &a->scu_alias);=0A=
 =0A=
+    /* SDRAM remap alias used by PSP to access SSP SDRAM */=0A=
+    memory_region_add_subregion(&s->sdram, 0, &a->scu->dram_remap_alias[1]=
);=0A=
+    memory_region_add_subregion(&s->sdram,=0A=
+            memory_region_size(&a->scu->dram_remap_alias[1]),=0A=
+            &a->scu->dram_remap_alias[0]);=0A=
+=0A=
     /* INTC */=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[0]), errp)) {=0A=
         return;=0A=
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c=0A=
index e84975a9c4..e38b829cc7 100644=0A=
--- a/hw/arm/aspeed_ast27x0.c=0A=
+++ b/hw/arm/aspeed_ast27x0.c=0A=
@@ -432,6 +432,8 @@ static void aspeed_soc_ast2700_init(Object *obj)=0A=
                               "hw-strap1");=0A=
     object_property_add_alias(obj, "hw-prot-key", OBJECT(&a->scu),=0A=
                               "hw-prot-key");=0A=
+    object_property_add_alias(obj, "ssp-cpuid", OBJECT(&a->scu),=0A=
+                              "ssp-cpuid");=0A=
 =0A=
     object_initialize_child(obj, "scuio", &s->scuio, TYPE_ASPEED_2700_SCUI=
O);=0A=
     qdev_prop_set_uint32(DEVICE(&s->scuio), "silicon-rev",=0A=
@@ -794,6 +796,8 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev=
, Error **errp)=0A=
                                 sc->memmap[ASPEED_DEV_VBOOTROM], &s->vboot=
rom);=0A=
 =0A=
     /* SCU */=0A=
+    object_property_set_link(OBJECT(&a->scu), "dram", OBJECT(s->dram_mr),=
=0A=
+                             &error_abort);=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&a->scu), errp)) {=0A=
         return;=0A=
     }=0A=
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c=0A=
index 51696443bd..7080bd6241 100644=0A=
--- a/hw/misc/aspeed_scu.c=0A=
+++ b/hw/misc/aspeed_scu.c=0A=
@@ -20,6 +20,7 @@=0A=
 #include "qemu/guest-random.h"=0A=
 #include "qemu/module.h"=0A=
 #include "trace.h"=0A=
+#include "qemu/units.h"=0A=
 =0A=
 #define TO_REG(offset) ((offset) >> 2)=0A=
 =0A=
@@ -961,9 +962,42 @@ static void aspeed_ast2700_scu_reset(DeviceState *dev)=
=0A=
 =0A=
 static void aspeed_2700_scu_realize(DeviceState *dev, Error **errp)=0A=
 {=0A=
+    Aspeed2700SCUState *a =3D ASPEED_2700_SCU(dev);=0A=
+=0A=
     aspeed_scu_realize(dev, errp);=0A=
+=0A=
+    if (a->ssp_cpuid > 0) {=0A=
+        if (!a->dram) {=0A=
+            error_setg(errp, TYPE_ASPEED_2700_SCU ": 'dram' link not set")=
;=0A=
+            return;=0A=
+        }=0A=
+    }=0A=
+=0A=
+    if (a->ssp_cpuid > 0) {=0A=
+        /*=0A=
+         * The SSP coprocessor uses two memory aliases (remap1 and remap2)=
=0A=
+         * to access shared memory regions in the PSP DRAM:=0A=
+         *=0A=
+         * - remap1 maps PSP DRAM at 0x400000000 (size: 0x1A77E000) to=0A=
+         *   SSP SDRAM offset 0x5880000=0A=
+         * - remap2 maps PSP DRAM at 0x42C000000 (size: 0x05880000) to=0A=
+         *   SSP SDRAM offset 0x0=0A=
+         */=0A=
+        memory_region_init_alias(&a->dram_remap_alias[0], OBJECT(a),=0A=
+                                 "ssp.dram.remap1", a->dram,=0A=
+                                 0, 0x1a77e000);=0A=
+        memory_region_init_alias(&a->dram_remap_alias[1], OBJECT(a),=0A=
+                                 "ssp.dram.remap2", a->dram,=0A=
+                                 0x2c000000, 0x05880000);=0A=
+    }=0A=
 }=0A=
 =0A=
+static const Property aspeed_2700_scu_properties[] =3D {=0A=
+    DEFINE_PROP_INT32("ssp-cpuid", Aspeed2700SCUState, ssp_cpuid, -1),=0A=
+    DEFINE_PROP_LINK("dram", Aspeed2700SCUState, dram, TYPE_MEMORY_REGION,=
=0A=
+                     MemoryRegion *),=0A=
+};=0A=
+=0A=
 static void aspeed_2700_scu_class_init(ObjectClass *klass, const void *dat=
a)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
@@ -972,6 +1006,8 @@ static void aspeed_2700_scu_class_init(ObjectClass *kl=
ass, const void *data)=0A=
     dc->desc =3D "ASPEED 2700 System Control Unit";=0A=
     device_class_set_legacy_reset(dc, aspeed_ast2700_scu_reset);=0A=
     dc->realize =3D aspeed_2700_scu_realize;=0A=
+    device_class_set_props(dc, aspeed_2700_scu_properties);=0A=
+=0A=
     asc->resets =3D ast2700_a0_resets;=0A=
     asc->calc_hpll =3D aspeed_2600_scu_calc_hpll;=0A=
     asc->get_apb =3D aspeed_2700_scu_get_apb_freq;=0A=
-- =0A=
2.43.0=0A=

