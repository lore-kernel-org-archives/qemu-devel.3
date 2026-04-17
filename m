Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5651BF8E4A4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 03:31:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDZt3-0002DK-6V; Thu, 16 Apr 2026 23:28:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDZt1-0002D4-OD; Thu, 16 Apr 2026 23:28:55 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDZt0-0005oG-8F; Thu, 16 Apr 2026 23:28:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qC7L+fAJfPDZGHslk83qQK/we4EJC0dNDs/x3dYEb7kyVD91RQOz0/D8TFSi89bLE9vXKqGNaCNEvewR/zCKPmfEXriDcoASBMSt/5a0+AQnn3fVcpM/n5YkgjAZM8S2KcfoIfdeCuioclyBgj3Ls8d3I+VjeRoQCKThXc/JupAALCzoUTtlR41PG2Tg6mRt+C8XAxYKYUfXqL3zdVeUOx7TlcDNn6kK+YD4d9Lt5v3gEzrHEjNR50Vo1wTdyiAuYKNMWuL5uputKmKLTqf6WJuIKdTA2XHVTnk245IOhOBRvsu2boFoN4NRJVV37lbt2JSfoFfKSEU2dB08trBhhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bOHM/kkDPcuwjCzd9k89BYuoUVU9AYyaH4uSGqp+f0=;
 b=yOsrHnI9vBaIZUIaq+nrHh66WBzj2ZKkEJoxgmC3tEJJJWN8ChdsYxX3axkD2SQ8t5gPPUlDh7CxvqDESdbxcIG5W51LREZmqiZhlGdYO9BSv5OwRR4NvPbnI2c9l9ji9oYf5Yei6WxZ0PQV/agI+oQzYfVLxRWqFiP1vlhW3IBSDW92KHGhtDstxOS5aqLCn6JTTYiGdSXgolmKvmX5PBImGf+MCZfvaGfCzdxV6Bc8Ch68OvoBn28IavEhuVvbziRexl440Gp6HM04TUn91XwLQAQ180XndiqZLrBymnB+TKNPb9J1B/xGA5So+qVKrTRsJbt1C1GYhO82KNSYCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bOHM/kkDPcuwjCzd9k89BYuoUVU9AYyaH4uSGqp+f0=;
 b=kI3OhfwmzdLIg3sBxCI5MkPDMA+4LHa0i/+Gw74pq3whojlAz7RhNsULPoP2TV51GCjzmpWWGcr7MdXaMR4tvikJ2GAV2qgxpdwx2tVd3yWJZbZWRhtgjm9CMUBfAtWWB5HNpgGbtYnX041PNXNL84AoIpXIdXR/uig+CbkyIbFwaCFjugsddrqc1MbNSYhop5pEpoOtSkJXTqV5nZzQZBfDN6e3NWFpSZWHVwzYtOf9lQuw6Ktjbg7JMEty5EN3MmPXTQJi4ly+mYZbsulpmEmn1M/5Hy60es2RwDclELDn2c1L0q3zS51/wSMXNAkxz/Jli+S28BQBK7Pe7OB5GA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB6299.apcprd06.prod.outlook.com (2603:1096:820:ce::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 03:28:43 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 03:28:42 +0000
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
Subject: [PATCH v4 03/21] hw/arm/ast27x0: Start SSP in powered-off state to
 match hardware behavior
Thread-Topic: [PATCH v4 03/21] hw/arm/ast27x0: Start SSP in powered-off state
 to match hardware behavior
Thread-Index: AQHczhpKkhg4a40UOUW4myzo4TbEpQ==
Date: Fri, 17 Apr 2026 03:28:42 +0000
Message-ID: <20260417032837.2664122-4-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: a35cc147-e3d8-4e15-58f0-08de9c316cd6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|921020|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 4mPoOCFMJjdf9kCgoLqhFV6e6SSpZne7+CGfi76brJ9cDceErQj4sMjqJweF4PY2tDBpORtc9v26XMTrJt1rGR35CKyIPAT/p62s0VRYPNxNFTjE6WKFviYPTa824rMHGjToueOgTvQPNcpJHpyc7LCkKwuVO3GB8iJCv1zgJp9DFctqX+sBa2bP2nm7Ji8fBYC0b7+VKKeKzRzn2m1CWRUTfT8Z3qLK2G94PQAjHTyJoqQYWB9CysGWTeH8cVOI/C7QQtahulUT7enkixLdYZYi4Z9f09HU3rN2W2n2fdy0SgOmlWwG3sN11zwgjQldUl99pNXBP5nhztgTiBniIYaMiLiIua2J7LChh1o/dZiCVy9r4T9Ef0aPjSCS0ABw4AKXtVPvGppyfnaI5F5YfJiGeaddqFADIl+GkhRSE6XjyJkMMaiFNNdZfuGXj5nfV2lmnlw0AmU7k+bp0FwMpg3m7yBoc2zEFd4v1e/Ah0yYPJZ94ndUacD4Ui9D1Fo6cPX4S+FZFuW/UpsHTX5fYyUn5KJk5cq9acgWgn1PSJmIBVwDT2lEvlPG5QOBFp6BceAc1PsV1prAVqas2bIaIbI4p7SzHCqGvfReea7pVzlBHTqq7mxjGhDVxP0aKTdrwKXazVG6KCNkQYXB+/u82ULKN/Sb46vwxgMCYPvRjKFnacsRgcka8hpwyVioV5mpbmBSmvBSkSgdZ117cRh9dZS0wK0zF+CbYgM6KuLk7gdBJIJ4gaeFqAbrb7IikyIq6OP5ChqN74qEtHOceYny/e3bbGv4RSvPY9nwroYtBxJCWU8B/AMWj9WFWjJ+Y/wo
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1TX47aFLhdZ8kn+FeOL/BGyNZ0DoOyW+V3GrxSk5RBFu1kORrbI+lt0YJK?=
 =?iso-8859-1?Q?z4kep+9rBq+x2sMytJ+ehegPomnjI1PGRcR28itUBSrlCD28FkFupdJb1J?=
 =?iso-8859-1?Q?tEXrgpHTJ6hoLLo/XceaD8Jdhgjp6xciXc0+CxAoNgt8UO5kyNUqahi3Pn?=
 =?iso-8859-1?Q?mB/HuWXobhWAwqFwffYeP6Nx84CodaoPtT+7Crgh0eWplus36ERSYDNMcQ?=
 =?iso-8859-1?Q?goxBtsM0jk2vAFkBCLzMrVvm6i0MjlxJCyQT7g0gZ2cbQUUXSGiDSyBI9/?=
 =?iso-8859-1?Q?iS9KVGsvfKY6GSBKCF61oJhALjnBsckQ8UbWzc8VOYVOD/yEIfEaB1mkWk?=
 =?iso-8859-1?Q?5Au7EYUp7bbp36yUXibqzVjQypiBdC1auQi8Mjywy3Jo/5tApV+EytTe/z?=
 =?iso-8859-1?Q?dKt6uwQgBP/j0DiNMgdN/6Z+Yczm0Ve+n90mhd15wZPNumNWLM+B/ee7A1?=
 =?iso-8859-1?Q?VkMWhVaj/y650icTB09rAwAkoB0UfvNZbGe92QaLZZ6T93xGgeDJz0VJzt?=
 =?iso-8859-1?Q?de37UR5n/1mejDkTjR7r51vUoJ7djCcxuur9xeOZgOPkz6uX8Bzifm0Pb5?=
 =?iso-8859-1?Q?+YnfV4V1iMOMn3bqGj8cxpoRQLi3M81smUzsZoeEx3zFqFFcQK1TgumpXT?=
 =?iso-8859-1?Q?EolAmxkUYmKZcOYaJDB91Qk0ylhDpZwMPB0ivgzYwWdCcWnjtYIseTOD8h?=
 =?iso-8859-1?Q?25dAaFmRupwIIFCr0A33AkBdQil91/LK4u+NHqvojm+V6Olrb3+Hjj8mfO?=
 =?iso-8859-1?Q?ai0ijg97tdNFv0WIGUplfvNgaTt64oBgY5yyJWiwc5sKGmhmZ8mkZfkmYD?=
 =?iso-8859-1?Q?fjrr3LEkE/2Cwu1qHv0p1yGsnMpGrrVhQ+Z/v2XMFK340UDoBA7F91Ue99?=
 =?iso-8859-1?Q?hhzGXQXLLRtgFr3KNUcm/eMH+1aQD1JmcnJ/q2suPW79ChYfLHrsxthDFp?=
 =?iso-8859-1?Q?7lzAWWnJuVP/pJDUxMsbDkmiR0RMyFYs9bTRyCvm4yHCyNmUVotf0EfY67?=
 =?iso-8859-1?Q?P8btyymybTqB36WhU5LyrJjaAqPTYk3lJIfqwqhjsxwem5sRLsyvAsv8go?=
 =?iso-8859-1?Q?rSCmmv3F3mCMwBL4ap7amUP3Ng882+/mv2GvDn/O09tFfDcuAn6q1ZpJwX?=
 =?iso-8859-1?Q?uka8NN4WHk4ESjxOG8T/4iqkxAbH7jcOfL+WF3ywislLJa22FW2kg5N5NT?=
 =?iso-8859-1?Q?/tplsGEly/dslUw12JmrTTgUXyR/cDpot9EMaTEchcJ7DV9hPOM4dN4xRf?=
 =?iso-8859-1?Q?Qg5ewSNh3HC7hzBVc7pGWfz5nXXyA0YosfFnoYki0EYmDUL2x13Vyz/v52?=
 =?iso-8859-1?Q?QrnrISFLDAsKowwLbjOskECvE1AxmcllO9KiHV2bzLPkJqG8L7SMG8T19/?=
 =?iso-8859-1?Q?bHQ64Lbha96k/ETIqx6+8jW2/Xr29M7C9Fw8kYtlISe5rXFY5oV49wAVfw?=
 =?iso-8859-1?Q?KdfMB1aXXh5ehffggBPg2yCkdERVv2nebY6fV6ZgguobpR2eVn9RlFt3cp?=
 =?iso-8859-1?Q?i2DvWx0GNfKDKLc81FOh1EfL4vHHqbn83U4CA9glWRmvbiKvFP90E+i+af?=
 =?iso-8859-1?Q?f7avOn4GuBbcDmsnVnKwntbeEUe4lftqU1WtmgbVA0tNxe1o0IULvqMLv9?=
 =?iso-8859-1?Q?UqRA2JkH8CsCx6K1/RWmhyliSHGk8DITS+yDf6XUsrW6lR0Upnl3Uq4y87?=
 =?iso-8859-1?Q?4zCYp5PdZ8MODVsUUUvmqpcZ+ila3eUJCsdrPiXBKiJNLf3E8kNK5wBMQa?=
 =?iso-8859-1?Q?OjOpGJXyGaGkTV1ZTK0ptrGisT1ko2qns4jg11QSVvvfqSOpArwDV2j9RQ?=
 =?iso-8859-1?Q?sh61QBxfbg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: bsel1OFUAU2Vq/cm92V4OHeVZjIwLavTv+wp3Te8C6uiIgvjv423agbhixiHEmau6F5+WQY5zwvpKq8kXGikBoBshUm0bPptNK/QIBs2lW4RNs6rKCOEFObZsYeVzK9Ml/iFlFwLFDCb574GAo/IivSKv6B7EqOCjAK0LFclR4gyKff3eQR7zPiFsnuY5Wnq3eA7GNl6VHpnqZ6KhuhRNPzduVKC3PpVnFY9Tmk1VZYCk7RgU26C9TGBLKIcjzEBI9n4u4PIGkr46qerw4U1Y7YU7iNzWeFaMmesw2u0TYb9SAHPks0rI853UZl6enk6DL9anIqdB47oZHBQL0j0wA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a35cc147-e3d8-4e15-58f0-08de9c316cd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 03:28:42.6434 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NFQtvUSkK6GYd4Jak7jvBygAruRMTQ395ixwEEdoMTnI5LSKp5yH2unrbZDj6tYj+vldxRHvLG07YhqvRjdRrDKVwlNleyPSYfyACqiHdKo=
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

In the previous design, both the PSP and SSP were started together during=
=0A=
SoC initialization. However, on real hardware, the SSP begins in a powered-=
off=0A=
state. The typical boot sequence involves the PSP powering up first, loadin=
g=0A=
the SSP firmware binary into shared memory via DRAM remap, and then releasi=
ng=0A=
the SSP reset and enabling it through SCU control registers.=0A=
=0A=
To more accurately model this behavior in QEMU, this commit sets the=0A=
"start-powered-off" property for the SSP's ARMv7M core. This change ensures=
=0A=
the SSP remains off until explicitly enabled via the SCU, simulating the=0A=
real-world flow where the PSP controls SSP boot through SCU interaction.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast27x0-ssp.c | 7 +++++++=0A=
 1 file changed, 7 insertions(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c=0A=
index 9a2079668b..edfcf1badb 100644=0A=
--- a/hw/arm/aspeed_ast27x0-ssp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-ssp.c=0A=
@@ -166,6 +166,13 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
     qdev_connect_clock_in(armv7m, "cpuclk", s->sysclk);=0A=
     object_property_set_link(OBJECT(&a->armv7m), "memory",=0A=
                              OBJECT(s->memory), &error_abort);=0A=
+    /*=0A=
+     * The SSP starts in a powered-down state and can be powered up=0A=
+     * by setting the SSP Control Register through the SCU=0A=
+     * (System Control Unit)=0A=
+     */=0A=
+    object_property_set_bool(OBJECT(&a->armv7m), "start-powered-off", true=
,=0A=
+                             &error_abort);=0A=
     sysbus_realize(SYS_BUS_DEVICE(&a->armv7m), &error_abort);=0A=
 =0A=
     /* SDRAM */=0A=
-- =0A=
2.43.0=0A=

