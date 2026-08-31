Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A03DC61DE8
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 05:38:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0uiH-0004nx-Bu; Mon, 31 Aug 2026 01:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1x0uiE-0004n9-HH; Mon, 31 Aug 2026 01:37:42 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1x0uiC-0000vD-KB; Mon, 31 Aug 2026 01:37:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UOgw9XWgMWL6jdcz4V1A2HJdqlYLr1+AHnzD7wjxtErF3XGEGoj6kmbgwr9Y8kEWhO/C1ScOzodEmQ0bpPRgojoFEM5sc1QW0snPI2L3/ZcD73LK0f7abJwL8bWRsRG0VLCoTVFCTeXsdyvR041PgOiBpBzxyJWgO2TGeFc+D8zUMyFIdUW8sI+u9bDpcgTCOA2kRXKwiZUb1hQ64+ZlF7w0l0hTOrQ3oPbtyg2CdtBqX39RAHUS2WROEz2KEKnwKlmravDyG3zLWxb9WanEFCaVKj6SzXCJaIhrrNtJP/CsXQW3oC1iOkr+Ew6P5zHTOMpmQarFRHPelzgGoVJUpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IS2gsnpkPz8vs6WeNcTF4vqdn3PMNJ/EteCe1l0qiZw=;
 b=e0zN7llDs479oGUWhuIZReioDG9Bq+0carVQ6aedf4Cl+b+S1oEpoiwwKsAfmutVNylBTq2vBCGv59CsyAljJBahYhB9Ij48ImLqzNQGQWQ23+TiDJOgVt3pDFhni86jWvIrU/ibeHF570u0A/7UmKj8qvNWkNdCHshLU6bt2P/oeasBhrD1zOYV+p9c7ji3noNA/1TVgdaFi6hjw67RGFESxuuAxYurXk8H4z7WHRyeUsdl9kb1mYLlHdU1xxQ6HEhBfR2Bk3VI0Z2PywBiHyEW73QHRzV78Icoa6p+Pavmm56oMyCnLa7MH9Kg66T/2N+aXv+VY5doNY8G4t2J7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IS2gsnpkPz8vs6WeNcTF4vqdn3PMNJ/EteCe1l0qiZw=;
 b=ioiX4GmFD0Zv17Kssd+z/aqo0myKXBdlJxiA/uzxrp9eVPjv/hXGiIrvFvxflLrHqVi/YBzfBa8mjhq2PiRyJQub1LnJt5IrVb+7czHihBp42WsZjwqdMllO0G+6UXJ/YeKX8Gb/SOyZJXlXLZJ5iXumaPksJWQrjx3PlNNZAPAdGjit5b/vaEsFr4UkSBbR+Y6VXTSpX9ARgJRDsmRYuoxiOAQ1oBsyCHNM2BshdzdvANRuLNKJk+QIrSu7mLSx8dfchuCnN9MAoZdLqjfrRIC/89t2ugeQkUH0EfGB/Rn4UNexvJVmikmf2v+qXOvIwsqlXD1dCIyApvvuXEN5Zg==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by KUXPR06MB8654.apcprd06.prod.outlook.com (2603:1096:d10:a0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 05:37:01 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 05:37:01 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v1 2/2] hw/misc/aspeed_sbc: Derive secure boot state from OTP
 config straps
Thread-Topic: [PATCH v1 2/2] hw/misc/aspeed_sbc: Derive secure boot state from
 OTP config straps
Thread-Index: AQHdOQq/TjDmmLa7oEyokggEpScsiQ==
Date: Mon, 31 Aug 2026 05:37:01 +0000
Message-ID: <20260831053658.462203-3-kane_chen@aspeedtech.com>
References: <20260831053658.462203-1-kane_chen@aspeedtech.com>
In-Reply-To: <20260831053658.462203-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|KUXPR06MB8654:EE_
x-ms-office365-filtering-correlation-id: cdeb0612-3c57-42c4-44f0-08df0721e1b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|56012099006|10067099003|6133799003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: DZ5kpyBfu1tJP02VrQivviGBBGhS2NCBRukwKqliGGdurYnyJYoHVbrlqurYqzMmeJ2ZHCDIY2PtBbAnryeB6JYe6UsmeHF9knE06i5saWCKVMhJiRTUZ/x2it4LGaBdJ3ng4DXnyYqh+gZttgYo6KnP/ESkI4WgRqCjzAKerkgJ+ZF0sezHg8pIlnYanLuSsauVjPiPGngPqU0yERGiqQGCQ9MWlkiCE3B4E65ioL3zsnMuqzERrSNnA5pJQnfqLKLQNH+vM4lYX1vnGVrq0y0FKZ/Z9+Nb6s+Z1BN7XzLSfW2HpQRsUuIM7Rd0KrwE12Gjy9MOJWIpneploOhZ40Cq4Xtcpf+Y4KqA6mN3AHKRNADfFxComF8kL3bKp4JV8G/JNlc/j/zlU4mIWffd/yH1DSPZniMcDamTPVpvzi3XDT8JtZhHJHYaXnUIiAn3vG94dMn8i2c3jFbFK56pXF5jpH9b0jo/lXlHpPMCLYP1WU47eF2jui3miqUXLMInEUKF/CJYcfxW31CbzZ+FUwhfbtRpnhQJJsBT+iUYzPegetwpJ+hnke8yUoRukAaf3fhmARSl9hFPIA3ez2c6aPTzBzDotfppBLWpxBjPEDktvfw5wYspvY188FTPbbKjjkY6P/9c3fylkZ7YN4TFNPI7mLjPeQ9WiQ7vYMagw7wpBR5G9lmANZU419WZzyPBBE6JHTOP5GsEE8Xfi+/fnaQI3wvpfAZ0SyHUZxsJl70=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?J53mNIr0VAsOERe1Jwakwod3YoVWkr5r1NeHspieJaa6mRA3Y0FIh358Ce?=
 =?iso-8859-1?Q?Y9Eh3X7D0hXmBYFtOUtIc5H6rE50Wr0cmHTXMgTo+2Zf2RGSHJD8plOJL0?=
 =?iso-8859-1?Q?sIW3l0NmJmC/INri2laVJbTSVD90Pxa/ItgqfDcehcsCh6U44N6VmPOBvu?=
 =?iso-8859-1?Q?8fdxbQViB/1zLEGYuwuVOuGNFWxgqEIIbQjHJAAgYHDV52X6qpZ27iCBsX?=
 =?iso-8859-1?Q?C+Rock6WHSSgNx8DffgLzSPu6IMVvoda+3Gj3HptxktfkmYFuoN2W1zWlz?=
 =?iso-8859-1?Q?1vjpJRdy/4YCuMMdZ6ELO7K8yb7f8vOklKUXjz46eAATdWjFyl2hXN2DUX?=
 =?iso-8859-1?Q?lftvlQha8V6/FRU2RUrTM4YiNo4w/d0XvYtcePSsL0sTzvWbZjv3VGNBUV?=
 =?iso-8859-1?Q?4GPtIDg33ZTa5hTPfDFrFL5ijYWOSW9rRy8J1OepyHdL0ZM8kaYFYCpMU+?=
 =?iso-8859-1?Q?9yox8bJArHrEc6pH8mueONispPF3aNUmFXXhvQnNRTeWd9YfI7iOUjafp+?=
 =?iso-8859-1?Q?dRWWgyCIUQDQMjB3WimimpmwSJPLnxeHxHBlZfekevWw+Cx+nRSDAStGu0?=
 =?iso-8859-1?Q?WQvQdkvlENRKcXND9fCP7J59KmUthKPJDEik1BNtIPxYdTb9sko2F2byAM?=
 =?iso-8859-1?Q?qUoE5J7DdkxeCLoWDrPfTev+wHtzJs0b2xCeAIHF30mTwvWzgy+lL3dEtI?=
 =?iso-8859-1?Q?Ql2YjuFVUXzWPqWaGAYfNuoyTIFZYFXFhhi4fiLm4cWHathlL/R3hXZiF9?=
 =?iso-8859-1?Q?6x9ezFPA6XFkevg5vSmDLeCQORzzeT90fOzPsli/b7WTteYoQCNNY2eS0i?=
 =?iso-8859-1?Q?soq9bzYQFcXPLrhzF/QsI8mF/9fFMq0XyykKJX9+oKgI9AJye4+bOZ6UHd?=
 =?iso-8859-1?Q?40UJbkaF6m6tB8o8hSAXQG7VZhOgi6FfOOs5y8yrkOCFe14s59jLaWfS3R?=
 =?iso-8859-1?Q?E5In+T/ej3WrxyUGzpPzraVe7dDdJavCkH8IwJ4mNQSiyVmfeBzlqsriJm?=
 =?iso-8859-1?Q?eTkzGOpSRHygR1RIaShx2nLn8CmwArRo2C90X9HERYYnU+MIYjYfZ4EU4d?=
 =?iso-8859-1?Q?F7ARsWleQ0nWCA7jl9FUQyjWy+Avd7OVyY/s0c5dpo3t/R22pXRWnoLolS?=
 =?iso-8859-1?Q?L2w91K9ISS1rfFRUtDj4FZrRnYt9Gk+0Iz783lx4vruQErnvmcLt2XbVnG?=
 =?iso-8859-1?Q?WEi5XR+gG2ZxT6r/6A8J0T4T7IxTExbq1eYemTslXyyCQaGV+Rx/8KvYLv?=
 =?iso-8859-1?Q?IMX+jyQU8V539seqiXz+rKkUJ1jDMVBiSBRus9qKl0cC0dxoE/A3bL3EcK?=
 =?iso-8859-1?Q?r5gu65lnfd6FV1zMJvrknHLNYEQFkr4agM7Ypzc9BiPLyvjvIewVQjyEcl?=
 =?iso-8859-1?Q?Fq5sGEsmalYpQJv42sY8HwDwCXsSVz06MuIVTsaq6cs9ASludOx4x0DnQa?=
 =?iso-8859-1?Q?KhaT1/7T4+d/G4rP9WAf2YERQgL3VDgtPp426Yyoc0+4RB4zu7acrDmRXK?=
 =?iso-8859-1?Q?ovclin6ATR/0dXb22W+czdPfrlBw6ZZX2Oc+3yc+cV5BAPDUQKqY5ydvXC?=
 =?iso-8859-1?Q?8yb7GhDsfh1wOb1tq6wL65WCIWSQkKLEYud6xxAh0pAOcc7rvIScYZIaOg?=
 =?iso-8859-1?Q?Ch+NlarT39aSCnLTTkuUJFxxZ3yAPenzujuNow0sj2+0tBoBiad3FaUDIB?=
 =?iso-8859-1?Q?4YCtX7wgVKbwfljbGAk8zyHKdG5vlbLuz3CT+8rObRtYvBhAc3kvIrHvh6?=
 =?iso-8859-1?Q?YorgZWfr9jE7g96ck0da7eeTMSiLRtbzkTMrkAiVtjugCxKAKB6iC0OYB5?=
 =?iso-8859-1?Q?bGcWLQAvzg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lhT0u0KlD/3tUi3EbLmwXp1TxkTPZH+FDRw8kZ9Xttevj5vGJEcsysaMnQgpC0jjj5/69d0XHIPLZfvBDbqVq1sjwRtf75e0QpVbiX2IGOQDfJEy+K4OqMSTkzTi1+zsBuV8B20TOgMTPzUaiw8LJbYqkdPdpbAKHhyJtsEcLD9v0kWPy6hmKND3esevFhSKzxrdyNg7m1tXbYXWarFGC1o7s0/cmWfnzLI0ZqDzR64kRCgtwAYX/Y+fB+9i7UgJHEY3nVfI7zIk/ivrJ0E556Bsu+il1nlQIUIIqJHxKF21rdPoske6ioDAny5zcSiP9xSNeJPBN78MunD6PwAp3g==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdeb0612-3c57-42c4-44f0-08df0721e1b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 05:37:01.1277 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pK1owAu567xlnYa4CsOmuIn6C5w6wYgX7Yi+ie5HnKNq/XqzPnQhB7NFObY3MLO6Uykyq1448hx5Daa1qvcPknYgvi4mu9jJIm7ZGfU+SZg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR06MB8654
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=kane_chen@aspeedtech.com;
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

The secure boot enable bit in R_STATUS and the R_QSR signing settings=0A=
were both driven by a fixed "signing-settings" machine property, but=0A=
the two ended up inconsistent: the logic guarding the R_STATUS enable=0A=
bit was broken and never actually set it, while R_QSR still reported=0A=
the configured signing settings, so a machine could show secure boot=0A=
configured in R_QSR while R_STATUS said it was disabled.=0A=
=0A=
Instead of relying on the property, read the relevant OTP=0A=
configuration bits directly and derive both the R_STATUS secure boot=0A=
enable state and the QSR value from them, matching how the real=0A=
hardware determines these settings. The now-unused "signing-settings"=0A=
property is removed.=0A=
=0A=
Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>=0A=
---=0A=
 include/hw/misc/aspeed_sbc.h |  2 --=0A=
 hw/misc/aspeed_sbc.c         | 34 ++++++++++++++++++++++++----------=0A=
 2 files changed, 24 insertions(+), 12 deletions(-)=0A=
=0A=
diff --git a/include/hw/misc/aspeed_sbc.h b/include/hw/misc/aspeed_sbc.h=0A=
index 7152497b2a..474922cbd2 100644=0A=
--- a/include/hw/misc/aspeed_sbc.h=0A=
+++ b/include/hw/misc/aspeed_sbc.h=0A=
@@ -32,8 +32,6 @@ OBJECT_DECLARE_TYPE(AspeedSBCState, AspeedSBCClass, ASPEE=
D_SBC)=0A=
 struct AspeedSBCState {=0A=
     SysBusDevice parent;=0A=
 =0A=
-    uint32_t signing_settings;=0A=
-=0A=
     MemoryRegion iomem;=0A=
 =0A=
     uint32_t regs[ASPEED_SBC_NR_REGS];=0A=
diff --git a/hw/misc/aspeed_sbc.c b/hw/misc/aspeed_sbc.c=0A=
index 5d4da39d30..ce03f717a9 100644=0A=
--- a/hw/misc/aspeed_sbc.c=0A=
+++ b/hw/misc/aspeed_sbc.c=0A=
@@ -63,6 +63,19 @@=0A=
 /* OTP Address */=0A=
 #define OTP_CFG0                (0x800)=0A=
 =0A=
+static bool aspeed_sbc_otp_read(AspeedSBCState *s, uint32_t otp_addr);=0A=
+=0A=
+static uint32_t aspeed_otp_read_cfg0(AspeedSBCState *s)=0A=
+{=0A=
+    uint32_t value =3D 0;=0A=
+=0A=
+    if (aspeed_sbc_otp_read(s, OTP_CFG0)) {=0A=
+        value =3D s->regs[R_CAMP1];=0A=
+    }=0A=
+=0A=
+    return value;=0A=
+}=0A=
+=0A=
 static uint64_t aspeed_sbc_read(void *opaque, hwaddr addr, unsigned int si=
ze)=0A=
 {=0A=
     AspeedSBCState *s =3D ASPEED_SBC(opaque);=0A=
@@ -76,7 +89,12 @@ static uint64_t aspeed_sbc_read(void *opaque, hwaddr add=
r, unsigned int size)=0A=
         return 0;=0A=
     }=0A=
 =0A=
-    return s->regs[addr];=0A=
+    switch (addr) {=0A=
+    case R_QSR:=0A=
+        return aspeed_otp_read_cfg0(s);=0A=
+    default:=0A=
+        return s->regs[addr];=0A=
+    }=0A=
 }=0A=
 =0A=
 static bool aspeed_sbc_otp_read(AspeedSBCState *s,=0A=
@@ -291,6 +309,7 @@ static bool aspeed_get_abr_state(AspeedSBCState *s)=0A=
 static void aspeed_sbc_reset_hold(Object *obj, ResetType type)=0A=
 {=0A=
     AspeedSBCState *s =3D ASPEED_SBC(obj);=0A=
+    uint32_t value;=0A=
     bool abr;=0A=
 =0A=
     memset(s->regs, 0, sizeof(s->regs));=0A=
@@ -304,11 +323,11 @@ static void aspeed_sbc_reset_hold(Object *obj, ResetT=
ype type)=0A=
         s->regs[R_STATUS] |=3D ABR_EN;=0A=
     }=0A=
 =0A=
-    if (s->signing_settings) {=0A=
-        s->regs[R_STATUS] &=3D SECURE_BOOT_EN;=0A=
-    }=0A=
+    value =3D aspeed_otp_read_cfg0(s);=0A=
 =0A=
-    s->regs[R_QSR] =3D s->signing_settings;=0A=
+    if (value & BIT(1)) {=0A=
+        s->regs[R_STATUS] |=3D SECURE_BOOT_EN;=0A=
+    }=0A=
 }=0A=
 =0A=
 static void aspeed_sbc_instance_init(Object *obj)=0A=
@@ -352,10 +371,6 @@ static const VMStateDescription vmstate_aspeed_sbc =3D=
 {=0A=
     }=0A=
 };=0A=
 =0A=
-static const Property aspeed_sbc_properties[] =3D {=0A=
-    DEFINE_PROP_UINT32("signing-settings", AspeedSBCState, signing_setting=
s, 0),=0A=
-};=0A=
-=0A=
 static void aspeed_sbc_class_init(ObjectClass *klass, const void *data)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
@@ -364,7 +379,6 @@ static void aspeed_sbc_class_init(ObjectClass *klass, c=
onst void *data)=0A=
     dc->realize =3D aspeed_sbc_realize;=0A=
     rc->phases.hold =3D aspeed_sbc_reset_hold;=0A=
     dc->vmsd =3D &vmstate_aspeed_sbc;=0A=
-    device_class_set_props(dc, aspeed_sbc_properties);=0A=
 }=0A=
 =0A=
 =0A=
-- =0A=
2.43.0=0A=

