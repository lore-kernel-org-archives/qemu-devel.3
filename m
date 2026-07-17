Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D000C44507
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 08:47:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkeDG-0000Za-OP; Fri, 17 Jul 2026 04:46:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wkeD8-0000WV-OO; Fri, 17 Jul 2026 04:46:23 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wkeD5-0003vC-PE; Fri, 17 Jul 2026 04:46:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=psWKj7hzu8O3HgwXxEZLxdeOVKeSTlAmC4A3Sn9faysnQGIoZoYNTFPj6dwZ9UaQahENTRuBbWvYbZ2Z+CU5dWnPyVNkfKehWDZ9/mBuaoJbjaM3p8m+u4irP4XGOiytEqASysj5LAizFoeikLzFImrKdWwhc03umrxhI65XcH9jNZ9/19/jxm2CjaaREkjZcQIOks4Sqlm4sNVIh1wTJOkrVL/F/LjwQ/qykGdStq8t2EmlIoZBBe91bGSj5rRr5m6/9CiAoy8sIxtIV4PgoSpx45iAEINHejsDKdpwgKDIbF6ipCxP5+SzvGVxwuXxz08qd6hIlCG24NlBx2aK2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IPmBPJkX+8OKOwDgcLfQFDkJ0k+VudPL4dmg7u+qCgg=;
 b=ZJFHLt+ZxyK4HrUAaWdiJx1IuuQzPW2q0c8jbYEv/F3+S5/9p8AaFNALXXQ37uLckewMnd0DU/sWTvJc0ktPY5M/7z75X02EUm82G4DXAKHSOqUdi4PNgxhpMOapDnYN9kum9VzSx9z/Ro2RWRktx9LIhIDFI4Z7sARQbKcn3n5TqwThvHMjxhmNbcuuuccgzi95Y+fQZqEvtUmahAuwyXtb6WTzsruo0u7LGqSpQCXvrQYBKeherO+QP10jN5LpK5mZ0OLnhee3YU27XzbYx+fPgtRSdxn4zjt7iBXNalvUWZkrOnue8KRFgGYxN7I27WxDbCxqIXVzsBNSQXsLbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPmBPJkX+8OKOwDgcLfQFDkJ0k+VudPL4dmg7u+qCgg=;
 b=HB8qkeeumQ/YzPWdwfloU0+AGzZaaQ9ixo7PUMEgWgO92kDFZKj+P3euYv87rLnNKVUWh8km6vlUE9+2E0bezKk/uTssOmasPy+sa4usjjxvGYuSMvU3JDPCbk8dWnas5DRnL3soDhrHHQfxCD6dKJoSHk/ZFhL6PEH5OrUflPuvApvxLgV8M54vXRtBpESXGUpPusoezaDX2ay+r8e1AfhLU7SsntRXLtAFUdaaS9tB7MPP/7/gdn5efvBfvJAmQtfJUVuzIAaTuxxBLsAKZZIXdw7NN3PS+6ir/gcwz3QLhrcYI0K0YJeKR83WdiXY1g/zhPE6FteYVSbvzwk9IA==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KUZPR06MB8267.apcprd06.prod.outlook.com (2603:1096:d10:63::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 08:46:04 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 08:46:04 +0000
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
Subject: [PATCH v4 3/9] hw/arm/aspeed_ast27x0: Move SCU link into AST27x0
 coprocessors
Thread-Topic: [PATCH v4 3/9] hw/arm/aspeed_ast27x0: Move SCU link into AST27x0
 coprocessors
Thread-Index: AQHdFcizTfQTfq5egkmHkyfANspk5Q==
Date: Fri, 17 Jul 2026 08:46:04 +0000
Message-ID: <20260717084559.3477061-4-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: f4b9253e-779a-40e9-bbfb-08dee3dfd61a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|7416014|376014|921020|22082099003|18002099003|38070700021|56012099006|10067099003;
x-microsoft-antispam-message-info: 7vftPZli1heJvAHD1fYdM7P0SAEs9ioyN8lEKy127yYq7K28xcc1mMxERLZ6wf99laf2y88vQs3usopi7NJs1G8/tRQBlOwF9Q26BtyBb5U/0d2CXyKgvHmyhleBOtSv2xi4E0molzzLyxgRJPhDwpwFlRkG606yROOxRYfuRT6zvfDShHiZpDNug36zj6jdtAQPLN0zua1MJDF6rZkkVA//DhYYXUdlI4iW3U5nEgajtegk4b9DND6+LSjjg5FPCJNNNcYIrEAbDtU021o8E+KaQszgpqm4mJqPnn5qap4lBSlBFRo422UIpRVyfD/4Ybu87hPOmRd0shzoxgEhry20wWjx1sz6PlTQld0zYV1Ce060vHmA4iEPZHIQErp5upbUAWsWpaFei7fHbD1xqg1Zj3LHDMzpAsiXUOy92oviRdDnAwpN5SAAeXZhzbU1rKl4x6Xk8iW8wQ90y7K63dufbhzjowa9sp7X/vIzop/lSrexkjQrH67nVqQlvRefuLih+1CFBKi4BSY4Nwyx95JqwxmY9E2QbP8950m5PkKp1ZkVr6AltoAC3dZFqA7a/gpkV4EcU9gAGiJT2EtowW8+SSo2oQ4bypdoRtdo7g+9ehUtAuaU6dDuttfmJh1kAON7CzVblkBlQofD99j2h/EAc+OtfvCS9KR5LRQ3Gj38i0tu25WJVaBzVBonEm3bgi0QNZGUWI3el+bvSU7ovzAxKdEDEl7awSWLwjLK3VA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(921020)(22082099003)(18002099003)(38070700021)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?IBV60UvwOxQtw7EZbySZBSAqeCoDZxM4WpjAjWjIxSgc6/fdktGhsROFj1?=
 =?iso-8859-1?Q?Q5CAwYZOjdHhh3EwzvOK0hcOnLOZXUaIFCZDOs0HP9qJddHDiWs3QcSiC8?=
 =?iso-8859-1?Q?JPQshYiFFHObDnKBIhQCpWzqh36JJOWJaLAM6/W2RjbqIiYQElWHFHoRA9?=
 =?iso-8859-1?Q?ZCsQByPdZCvQWFZ+FsPZ+zMATkll5L9nHGNJ+b3xOm5XvnkNTdDau7YN13?=
 =?iso-8859-1?Q?T7bPdSAK3h5ym8z7hWmUS+8CUUVSWdr6ZlND7oV4230cM7UwTT8g4LqbFR?=
 =?iso-8859-1?Q?m4F//uQ5aDK+/192rjdSrCCUJI+S5YSL3ZuPrjTCl64XP3a6+wHR+JvSwd?=
 =?iso-8859-1?Q?3ZcyE8aXqZzP84J7XpJLYC1Wnogp36nBVD3rPVJuJQ+vU9YL7AvNY7VToT?=
 =?iso-8859-1?Q?AC/h9YJ5iZwhshHFNo26ETgqLCp7HHXAYjbNrj4wolpKu3w+zf25Dht5qt?=
 =?iso-8859-1?Q?hgh+zrag4FeBH1olIYPHsSuBxuYdDhHsO8d8924LtoPI8GA/l7VHATozr1?=
 =?iso-8859-1?Q?JMj9+cgPbYsdIAuqP6gLgnViITrv/QrM1OOVVGlklNGWJ6QM/xhQuXUsND?=
 =?iso-8859-1?Q?5qh4AOTw8t2ESw5ou0eTjuIr+aXiw/TAz3MLuxSYx9Bu02CiI8th9U/7gz?=
 =?iso-8859-1?Q?ER3XZJktwFEIU8uj9A/J2IKPZl5QGle1LgkasW3NNwis1SRZZylcCZh+x1?=
 =?iso-8859-1?Q?O/IGBCbUslPEt0qFt+MCs1+OdmAZZtecd+q+KiG2J4iGwY2zv+h3ITOCMe?=
 =?iso-8859-1?Q?4IDjnVf7kcLaCltA0qIrWlD+djbyS8w4LBnP7aeSLZ4DA1VBHIDRLw8MBq?=
 =?iso-8859-1?Q?HLD1CjgkNFdkJu9ys9WDKEWZTlmiyyoG3CKg8E4E7owsqr7dHWipHlRYfG?=
 =?iso-8859-1?Q?dq6qO9G5Fv6FLGD6kqodX7Bh3Xb3NXZh1VbtHVfJQ7EGe7+JmdIYusIIfh?=
 =?iso-8859-1?Q?IA8G3jmX9iXI83DsZqYkGBXQMpXisJ4XN8+QrqjgOXdnMYzAf5715zmk4i?=
 =?iso-8859-1?Q?LGdvPFDweIQlOXsWjwFe73t1/fG0xVwi5h28/op0P7xAcVQf26+nditpWQ?=
 =?iso-8859-1?Q?99RqARuwstqtKoMUgkkleFId0xE72w+U2oREmJbNmQkz78/UA5R3lbjPOT?=
 =?iso-8859-1?Q?M8ag/qaU5wJAjyMVzswoWr+J7CdFyr2K6PeStL+cvitG1GvCJGz2blxe9g?=
 =?iso-8859-1?Q?ajH96JWed+4MoGK0hEOUwsp30YeVP/VUknYWUjSRTVAvZjRGkeYaD+ek5p?=
 =?iso-8859-1?Q?+mSircspIdRstlOROtZ/imRcf7yvcs16OJ5dzOuTc8ADq2qUML1FDHOmi7?=
 =?iso-8859-1?Q?+fpjdbHMgSoJ6KhTvCeDhL/MvOBEiSbbKFzOzYNHKawETH1rfWVRUfTXsD?=
 =?iso-8859-1?Q?oCx5WXENwxV2xQ3v1ZItCUW9wS+9/Nf695N9+JvfA3F+ZTLQIpdwRE+3uR?=
 =?iso-8859-1?Q?BHkhVJ0Yds58wRB4j/HouTluAKUfp4ifizIp/3prpeylEOAAUemIV278RK?=
 =?iso-8859-1?Q?XMmXcCcQGKjA3VaBY7GjxHYOUc/Kev6Edb/VPl1Jm81X5VCiHu/jnl9voV?=
 =?iso-8859-1?Q?ZJZGGPOp/V3mDck9e6yyyhXlxopxRjqBS02ry8J8/UEPtRkNLQBXFf8ToR?=
 =?iso-8859-1?Q?L2bImjFKsvzn4x1RJZboZAu7hPR+GApy8T/s1gmoE2cSiF7SVUNYe27REr?=
 =?iso-8859-1?Q?amxTf2sAgaoNyOPQM6ITYh2B5LFlDtfCJc5UlajB4gdF2eRT39MDFmKr+0?=
 =?iso-8859-1?Q?3c8AXnStXojAB5c+oneOUAY/xflDZudKYqgipEXOCYyWcfBcnk2Rs+B0Ng?=
 =?iso-8859-1?Q?rl0WxWqAPQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QlqFggLfg+CZOzp76vNn2eDNtPxnpsQTZ2/C8/cW1fCTjVXVc3Yw96MNxuaUGToC/Qoaf84iB0CzbIwfJxvcY8iU5RbvYlTlJbUlB8IsLgxkNlDCxqFuEzn38slO1YVYO25IlIZKT71ttMUPz+MEXHQzSNE9MdK8iH4zPVIJlShz/fj3uuwiBFgIR9IVxhe7qq2kiZBxB2ze6ks04lJjeaT8zHkBDkcpJmDkHMdDxrn/vX4ceNph8sQz2ssDHF6/otx8yozMLpIhR/dyuvjK4Wpv5X7nqsmWx36Y1U6dOuLgKypbrIRgidjrLF4SjbD+ZIK951Gtt6gAntbDVQvpHg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4b9253e-779a-40e9-bbfb-08dee3dfd61a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 08:46:04.2141 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3YaZ9h6DpHPQrCGKW3N2A8IgGESd6eym7r7dPlk88o9+vIkaeZFNvOYmIJHq28XR54VjyV2nP24fesxcTkXOPuaYsxq1xZaUTfBg0Qxk55I=
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

The SCU link is only needed by the AST27x0 SSP/TSP coprocessors for their=
=0A=
AST2700-specific SCU alias window.=0A=
=0A=
Move the link property from the common AspeedCoprocessorState into=0A=
Aspeed27x0CoprocessorState, so the generic coprocessor model no longer=0A=
contains an AST2700-specific dependency.=0A=
=0A=
Also validate that the SCU link has been provided during device realize=0A=
before accessing it.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
Tested-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
---=0A=
 include/hw/arm/aspeed_coprocessor.h |  5 +++--=0A=
 hw/arm/aspeed_ast27x0-ssp.c         | 20 ++++++++++++++++----=0A=
 hw/arm/aspeed_ast27x0-tsp.c         | 20 ++++++++++++++++----=0A=
 hw/arm/aspeed_coprocessor_common.c  |  2 --=0A=
 4 files changed, 35 insertions(+), 12 deletions(-)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_coprocessor.h b/include/hw/arm/aspeed_co=
processor.h=0A=
index ac58a5f424..adfc3c4512 100644=0A=
--- a/include/hw/arm/aspeed_coprocessor.h=0A=
+++ b/include/hw/arm/aspeed_coprocessor.h=0A=
@@ -20,10 +20,8 @@ struct AspeedCoprocessorState {=0A=
     MemoryRegion *sram;=0A=
     MemoryRegion sram_alias;=0A=
     MemoryRegion uart_alias;=0A=
-    MemoryRegion scu_alias;=0A=
     Clock *sysclk;=0A=
 =0A=
-    AspeedSCUState *scu;=0A=
     AspeedSCUState scuio;=0A=
     AspeedTimerCtrlState timerctrl;=0A=
     SerialMM *uart;=0A=
@@ -52,6 +50,9 @@ struct Aspeed27x0CoprocessorState {=0A=
     UnimplementedDeviceState otp;=0A=
 =0A=
     ARMv7MState armv7m;=0A=
+=0A=
+    MemoryRegion scu_alias;=0A=
+    Aspeed2700SCUState *scu;=0A=
 };=0A=
 =0A=
 #define TYPE_ASPEED27X0SSP_COPROCESSOR "aspeed27x0ssp-coprocessor"=0A=
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c=0A=
index 68a8ab26f7..28bb59c8c5 100644=0A=
--- a/hw/arm/aspeed_ast27x0-ssp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-ssp.c=0A=
@@ -167,6 +167,12 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
         return;=0A=
     }=0A=
 =0A=
+    if (!a->scu) {=0A=
+        error_setg(errp, TYPE_ASPEED27X0SSP_COPROCESSOR=0A=
+                   ": 'scu' link is not set");=0A=
+        return;=0A=
+    }=0A=
+=0A=
     /* AST27X0 SSP Core */=0A=
     armv7m =3D DEVICE(&a->armv7m);=0A=
     qdev_prop_set_uint32(armv7m, "num-irq", 256);=0A=
@@ -195,11 +201,11 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState=
 *dev_soc, Error **errp)=0A=
                                 &s->sram_alias);=0A=
 =0A=
     /* SCU */=0A=
-    memory_region_init_alias(&s->scu_alias, OBJECT(s), "scu.alias",=0A=
-                             &s->scu->iomem, 0,=0A=
-                             memory_region_size(&s->scu->iomem));=0A=
+    memory_region_init_alias(&a->scu_alias, OBJECT(a), "scu.alias",=0A=
+                             &a->scu->parent_obj.iomem, 0,=0A=
+                             memory_region_size(&a->scu->parent_obj.iomem)=
);=0A=
     memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SCU],=0A=
-                                &s->scu_alias);=0A=
+                                &a->scu_alias);=0A=
 =0A=
     /* INTC */=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[0]), errp)) {=0A=
@@ -275,6 +281,11 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
                                   sc->memmap[ASPEED_DEV_OTP], 0x800);=0A=
 }=0A=
 =0A=
+static const Property aspeed_27x0_coprocessor_properties[] =3D {=0A=
+    DEFINE_PROP_LINK("scu", Aspeed27x0CoprocessorState, scu,=0A=
+                     TYPE_ASPEED_2700_SCU, Aspeed2700SCUState *),=0A=
+};=0A=
+=0A=
 static void aspeed_soc_ast27x0ssp_class_init(ObjectClass *klass,=0A=
                                              const void *data)=0A=
 {=0A=
@@ -288,6 +299,7 @@ static void aspeed_soc_ast27x0ssp_class_init(ObjectClas=
s *klass,=0A=
     /* Reason: The Aspeed Coprocessor can only be instantiated from a boar=
d */=0A=
     dc->user_creatable =3D false;=0A=
     dc->realize =3D aspeed_soc_ast27x0ssp_realize;=0A=
+    device_class_set_props(dc, aspeed_27x0_coprocessor_properties);=0A=
 =0A=
     sc->valid_cpu_types =3D valid_cpu_types;=0A=
     sc->irqmap =3D aspeed_soc_ast27x0ssp_irqmap;=0A=
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c=0A=
index b8a4f7c91d..f5c4a02161 100644=0A=
--- a/hw/arm/aspeed_ast27x0-tsp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-tsp.c=0A=
@@ -167,6 +167,12 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
         return;=0A=
     }=0A=
 =0A=
+    if (!a->scu) {=0A=
+        error_setg(errp, TYPE_ASPEED27X0TSP_COPROCESSOR=0A=
+                   ": 'scu' link is not set");=0A=
+        return;=0A=
+    }=0A=
+=0A=
     /* AST27X0 TSP Core */=0A=
     armv7m =3D DEVICE(&a->armv7m);=0A=
     qdev_prop_set_uint32(armv7m, "num-irq", 256);=0A=
@@ -195,11 +201,11 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState=
 *dev_soc, Error **errp)=0A=
                                 &s->sram_alias);=0A=
 =0A=
     /* SCU */=0A=
-    memory_region_init_alias(&s->scu_alias, OBJECT(s), "scu.alias",=0A=
-                             &s->scu->iomem, 0,=0A=
-                             memory_region_size(&s->scu->iomem));=0A=
+    memory_region_init_alias(&a->scu_alias, OBJECT(a), "scu.alias",=0A=
+                             &a->scu->parent_obj.iomem, 0,=0A=
+                             memory_region_size(&a->scu->parent_obj.iomem)=
);=0A=
     memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SCU],=0A=
-                                &s->scu_alias);=0A=
+                                &a->scu_alias);=0A=
 =0A=
     /* INTC */=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[0]), errp)) {=0A=
@@ -275,6 +281,11 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
                                   sc->memmap[ASPEED_DEV_OTP], 0x800);=0A=
 }=0A=
 =0A=
+static const Property aspeed_27x0_coprocessor_properties[] =3D {=0A=
+    DEFINE_PROP_LINK("scu", Aspeed27x0CoprocessorState, scu,=0A=
+                     TYPE_ASPEED_2700_SCU, Aspeed2700SCUState *),=0A=
+};=0A=
+=0A=
 static void aspeed_soc_ast27x0tsp_class_init(ObjectClass *klass,=0A=
                                              const void *data)=0A=
 {=0A=
@@ -288,6 +299,7 @@ static void aspeed_soc_ast27x0tsp_class_init(ObjectClas=
s *klass,=0A=
     /* Reason: The Aspeed Coprocessor can only be instantiated from a boar=
d */=0A=
     dc->user_creatable =3D false;=0A=
     dc->realize =3D aspeed_soc_ast27x0tsp_realize;=0A=
+    device_class_set_props(dc, aspeed_27x0_coprocessor_properties);=0A=
 =0A=
     sc->valid_cpu_types =3D valid_cpu_types;=0A=
     sc->irqmap =3D aspeed_soc_ast27x0tsp_irqmap;=0A=
diff --git a/hw/arm/aspeed_coprocessor_common.c b/hw/arm/aspeed_coprocessor=
_common.c=0A=
index a0a4c73d08..43026d2a55 100644=0A=
--- a/hw/arm/aspeed_coprocessor_common.c=0A=
+++ b/hw/arm/aspeed_coprocessor_common.c=0A=
@@ -27,8 +27,6 @@ static const Property aspeed_coprocessor_properties[] =3D=
 {=0A=
                      TYPE_MEMORY_REGION, MemoryRegion *),=0A=
     DEFINE_PROP_LINK("sram", AspeedCoprocessorState, sram, TYPE_MEMORY_REG=
ION,=0A=
                      MemoryRegion *),=0A=
-    DEFINE_PROP_LINK("scu", AspeedCoprocessorState, scu, TYPE_ASPEED_SCU,=
=0A=
-                     AspeedSCUState *),=0A=
     DEFINE_PROP_LINK("uart", AspeedCoprocessorState, uart, TYPE_SERIAL_MM,=
=0A=
                      SerialMM *),=0A=
     DEFINE_PROP_INT32("uart-dev", AspeedCoprocessorState, uart_dev, 0),=0A=
-- =0A=
2.43.0=0A=

