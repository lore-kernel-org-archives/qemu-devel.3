Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 063BDC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 09:22:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whOSO-00046Z-41; Wed, 08 Jul 2026 05:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1whOSL-00045r-UA; Wed, 08 Jul 2026 05:20:37 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1whOSJ-0000NV-K1; Wed, 08 Jul 2026 05:20:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QCUQrePchGRPq+MEDp4MFxIgA9djq31tJzpXCmqCnXGbUYxqYb/4zQyl50eUznnVpGtMSQGEvRC3vvrPK/N35mh8i+h4Ud8eIQxZTXb+2z9AyxerUq7uktG7tGaO4+H7q3i7/fQS28dNqQGux3ygOIq2Mqrj/is7ZdeC7xrH8pnKKglr2iTbLofY9bSyXHjhJQlF4fVNldhIP1OkZdgpXO4/2ojMaE0zgnQJNZew5whpa2QAuKFg74pk6OrekXd6eWl7uQzOfoi3KjOjL65qmD56HaEccmLy1OGbOgVLtbyYclfo4VAWmHb1IQjERoAAD8vgla74TAPJGPzOrbAZ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwND2v++UX6pFyoywTK2r6sOR3992T7gH+shOWTbosE=;
 b=vV9pCVrNMiNTH4hyHMboK4S3L0CDT9lHyiR9N1AJR13jsnqKi64upRgZiqXkp8ZCtJkp0XebFZdHakBjkSnDVYG9dCUXpZmIJLlSco0Zzmf3mPEs+48j4cmRQuvOj9Xr7WfeZefCG2Ww3vaV4pCPRCqL5OzmB4ETE7a+AAhEI7LwczVq9dc9l9u7NidNC5xA3y5EH1gjFDKXzp9xHBShS7OPbXcScAgI51B1+L4yF9Ut9pyw9a3j6ZYlvGcu9erjJ2CZAS0WKATXt1sxaffqMJJiYAQt065VoivHhoCNu+mhrvMsUL88D370rQav+GcgRABVmpUElwYZi7+sH0F4aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwND2v++UX6pFyoywTK2r6sOR3992T7gH+shOWTbosE=;
 b=r7GmW/Y4GByvVIZo5y2rVeL/OUvU5SJ8p/gzS9q5eoGLLDCPJVAoRVrAdFzRCylssgCoPy9iDgnwjen6zSTQ9o1930aEXYBqgFZluuzcTEtbrle5fjYjjWnz9/VDFOrFO8wvO5xSYZHgVHFw4yTC7By9zfa0fRMZMOJodisswrnFDebsouLX6j8FsbtXcZrlEpzidqdeLCIN6d3maTr/21hDNrXz2OvnVPJFF//UMb4JGPWqp1otuS3gGkUn9t9e5iIfL4O41xNyz4Ezt57zGfgJdnZIMghYgb2w3LKL4j13raPy0anCFNtnn46j41U7R1MHJrj2l6WbckfbghsiZw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by PUZPR06MB5499.apcprd06.prod.outlook.com (2603:1096:301:100::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Wed, 8 Jul
 2026 09:20:29 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0181.010; Wed, 8 Jul 2026
 09:20:28 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v5 03/10] hw/arm/ast27x0: Add DRAM alias for SSP SDRAM remap
Thread-Topic: [PATCH v5 03/10] hw/arm/ast27x0: Add DRAM alias for SSP SDRAM
 remap
Thread-Index: AQHdDrsEMBb+a3i3mUmZCyVNjM1MZw==
Date: Wed, 8 Jul 2026 09:20:28 +0000
Message-ID: <20260708092023.3826159-4-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 798d5605-ff88-4051-b94e-08dedcd22708
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|22082099003|18002099003|3023799007|38070700021|6133799003|56012099006|921020;
x-microsoft-antispam-message-info: VeuL8W/JbQ1w3npxqwcNA9nrcuyQRNJWQBqBC4z/4grG4s9+GKWNO/ZNPgB/mR2zObNqIj5QQwzg1aZOn/L6n8Q0vwxFs954NNzsmYus6MigkQf5zU7IvSC3SNrJ7Wu6uZQTWDPUikEpQQQJbz8h6kjF0SI9cVlkk+WL8IsQ7kiIQUyC//OKE8GH9apP6f5E/A6UU7nThx2tt37jS1S8r8URVdVt/TF1boR7nldew9Srjd/QFh2Wn0+U46UVCUW2adZl7gEUyyOP3IJzKdVrVQQ5lQ+MBtslAJW3yAlCnWUWAUSuCSJ+S9pSGiEClTdVNPcVJoZcgGMkUkIiC0/T0B4LsUgjytwLOjyaCQRJYID9ccvqLyYptlXb63pa8JXLUkGbice++voLVMd2aLUIqrYMly+v3XgQXm3d944Ib5WC8nsj828ObQ4tkRN92Y95JIiIkemWLhfLYe35ipenJy6CJ8A5i4KsIKOaua3iJgWaQMvutNXF0XeE4X/frMr4UeSX1CNjnR4YAIywW4DUh4alBSDlgRLvbZq2hMGGqutpucPrj5tTMHKjStEzzWMHYvbeXXB8GhV1w6vRR9X8FRwZMZJCfrOGlv5rm/NtElGkKK4APIkJueL6qpH65+CMNz86sKighw8ueUKeEVraV/jF//rDheDfeBGkvlLDt7LJK0H2Ya1Hhh2QHaB8rXSSNKqL6e44cmyywbrQJ6dKiwD9h59mDH/N2r0JSuru8XN/NxbUj7AEkhm+XIGO3p/O
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(22082099003)(18002099003)(3023799007)(38070700021)(6133799003)(56012099006)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?W2VZ1s5qN0morv5Da3UAYfhT7NdfFPf+5MvVuZ/0DM/cyP8Az00+/mztfx?=
 =?iso-8859-1?Q?ASfTl8fZgQw9sU530LZj9s5pV1WVkLUe/8HKdroxZu0WR5bCe0Wz2SSlFK?=
 =?iso-8859-1?Q?D07DiCTCt8JZgXAeXD5Gsd7khCbHCapuugAC3ah76Fh+8CHllvVm+StlLD?=
 =?iso-8859-1?Q?kxsiVjyA2BdA3/RaDOf0ywalRZH1QfiiBNvAwnW5jjbllOewbKxr86sK26?=
 =?iso-8859-1?Q?805pIBFA7zGq1+ZZJrcQYi/9mrY1sMLbSHYnG/hjCJKv0WU40iN2JUdCq6?=
 =?iso-8859-1?Q?ZZfjvMb5kVnM24L2+2b8r30WGJ/VoNmamirvVD55LSQivfWGP5pV0Vc3zq?=
 =?iso-8859-1?Q?Lb+xgxtwbY76DK9cp5Uueg4BOUVFjpujiaTA7ZQW3c83zk0L9oWS7xYZuN?=
 =?iso-8859-1?Q?SsR1p9uhyEmSgw5YR/xzBq8KCTOlDTIZvdq91llyLNnU0fYgFSTeNCK4fE?=
 =?iso-8859-1?Q?XkFeXL3CJbSiXPuzejHcbG1Shgj8cTJE8+auUyjZxfbmakVIvRZt3dhZ2+?=
 =?iso-8859-1?Q?7hVe612MYDqLekoiI+C0j0ZIJeIUdFKoV70mUgfZFSi2Jjzc7nrPI3HSl3?=
 =?iso-8859-1?Q?6+AzDwOzrCBSPcvPwpsiIzsNvY1Uk3eI2P/gutYDolBKV3n2OEqLf3ehMR?=
 =?iso-8859-1?Q?DF5A5DNau2qcuMXYHeFFXqwue9S58bqAYvIRYBhSiRKeMtxDcFBNY7jS6t?=
 =?iso-8859-1?Q?A3/j2M+bNWuT7SGMNUzrFlEVTjh0AmzL/kflgTp4w/YYIMsatPfI5vzh8O?=
 =?iso-8859-1?Q?srfsmIBh2JZFpc/DWTgq9Y0GJ/ph0mUx1VgpgybhQHlOTPKvQq1RzUunjR?=
 =?iso-8859-1?Q?nwxZKqrotEO3SDdfbcD1GXu8U1/w0IZH4PXpTLSLWVOlGWp5grQt7P3xqq?=
 =?iso-8859-1?Q?kVBMx2cj6tafneeDP+IJsyxU3StcZXVQZC5AGPLFx6jEaJnKwAoLiTO2m9?=
 =?iso-8859-1?Q?vm/H01S1KAAHqfOSA+d57e9FXz24WnHeCcOLny+vssOELMv/s8zv6JTB2m?=
 =?iso-8859-1?Q?DW3FUX1BCpJe9z5nH19cl58j3a+1/L3tCsm5lNUzkX7Lmb8eBtvyvHrKFc?=
 =?iso-8859-1?Q?+yQv3kJpamx1ol5WEEn63Ny4eqL/aAa7aghYhpEimkXTa2sDqeDZfkl8u4?=
 =?iso-8859-1?Q?z3PfNUNWunI3hKgGNm2gkJ8NZcBbnOtjq2ai4gWhhNHSu1pcHE6mzAiE0Y?=
 =?iso-8859-1?Q?rDDveDnpY2K6Y7FU7TSKC7IXgU+u7h1KbNo0bmuWI+RoSEWEF+kS+J65BI?=
 =?iso-8859-1?Q?i7gIgzlf42vkPXsWp7lEkHc6JHl1aRO8Q1HMCntaRHQ7hP08mYlWtQ0JoI?=
 =?iso-8859-1?Q?ObyN2n6p1g2434YaN2iCixDJOVJcRnJ5jYwVI5FroEFOzZNMgKWrM/WmCi?=
 =?iso-8859-1?Q?roKui4ZEo9VCfbdrSMDHI20bbv0IZAk/9jJ0sy2vaOYbfk1h0RftbEoIZv?=
 =?iso-8859-1?Q?FL29xCmBL8nZTbmbIvf2etf24BZSckreXv7l8Xjogn2WUnEEXOr7/c/Lxm?=
 =?iso-8859-1?Q?/d2MdKbwfU+PEKfSRJXHlWH3Rys+XyNIO03QI0o9IGM/fD6aEH5E3AiXt6?=
 =?iso-8859-1?Q?U/KJV8/B564qn1XXihRY0+SHpsnNChfWcOd32psAsdGJtJuJYDbqzvlHHk?=
 =?iso-8859-1?Q?G69oapDDWxsdGweSyE8xs/Ui6U3oA+K1m7xDlh/lYQm5VD1EsbVXfV5ja+?=
 =?iso-8859-1?Q?TbzHRJ9WwPf7TDjQ81PSJnZfGkthoRoeBr0SLeapKZwTTm4dxA/IaZmlBp?=
 =?iso-8859-1?Q?6a/Mcz75MhCUfaTUZhEF539JJmCX+pX8GzhUODwyTi8GRrQwt3beRtYRP7?=
 =?iso-8859-1?Q?ZmiJSE4lIQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: oO6mgo4IwmJrwfL1YMOvkMw/aA7Ghz8j1AeIGlq0nI78AMUcL49/i/WY1rX7ZJ3e8BgNDh+6pnbFIgBVuz0wGRsNbkpNMyb+0Goa9nlugNK0bHfjLQCPBI/fQj5zFfGq+PzpGXUDfAYgrbRQQXq6jcbOr1TrvGlZc+DrlTzk1TUQxo52juZBL54OwQ5B4u84v/o//nD/7CjZMyzying5UHQIdkWv8LanygZQZaojNAX5gwtGu24OxI5WsRza4MC5/jC3P+akfX7/GvpchALA1ZPM3lZmepEAXp0yjfK+X5XXOaNdljB2gNjdU/6IIdmPhDHrMWtr/Boxg5hNm7vPdA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 798d5605-ff88-4051-b94e-08dedcd22708
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2026 09:20:28.8790 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NoIuS1dTMnApiOyk0loc2pNFZ+kYfaNph2SXJ0oaZN7ASJxydxGO1iZSD+5Lw4No8ll+Fl+ftreO4Tk3dtXoiBPkKnhQA/WOOoN6kStZGy0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5499
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
 hw/misc/aspeed_scu.c         | 32 ++++++++++++++++++++++++++++++++=0A=
 5 files changed, 48 insertions(+)=0A=
=0A=
diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h=0A=
index 904549465f..ae49f6ab9a 100644=0A=
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
index 058cea42ed..ce245118af 100644=0A=
--- a/hw/arm/aspeed_ast27x0-fc.c=0A=
+++ b/hw/arm/aspeed_ast27x0-fc.c=0A=
@@ -102,6 +102,8 @@ static bool ast2700fc_ca35_init(MachineState *machine, =
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
index 9c984d23cd..778876a60e 100644=0A=
--- a/hw/arm/aspeed_ast27x0-ssp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-ssp.c=0A=
@@ -232,6 +232,12 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
     memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SCUIO],=
=0A=
                                 &a->scuio_alias);=0A=
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
index dd6dd0377c..10d3e35a9b 100644=0A=
--- a/hw/arm/aspeed_ast27x0.c=0A=
+++ b/hw/arm/aspeed_ast27x0.c=0A=
@@ -442,6 +442,8 @@ static void aspeed_soc_ast2700_init(Object *obj)=0A=
                               "hw-strap1");=0A=
     object_property_add_alias(obj, "hw-prot-key", OBJECT(&a->scu),=0A=
                               "hw-prot-key");=0A=
+    object_property_add_alias(obj, "ssp-cpuid", OBJECT(&a->scu),=0A=
+                              "ssp-cpuid");=0A=
 =0A=
     object_initialize_child(obj, "scuio", &s->scuio, TYPE_ASPEED_2700_SCUI=
O);=0A=
     qdev_prop_set_uint32(DEVICE(&s->scuio), "silicon-rev",=0A=
@@ -808,6 +810,8 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev=
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
index ca93c3699d..cc0aa3234a 100644=0A=
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
@@ -932,9 +933,39 @@ static void aspeed_ast2700_scu_reset_hold(Object *obj,=
 ResetType type)=0A=
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
@@ -944,6 +975,7 @@ static void aspeed_2700_scu_class_init(ObjectClass *kla=
ss, const void *data)=0A=
     dc->desc =3D "ASPEED 2700 System Control Unit";=0A=
     dc->realize =3D aspeed_2700_scu_realize;=0A=
     rc->phases.hold =3D aspeed_ast2700_scu_reset_hold;=0A=
+    device_class_set_props(dc, aspeed_2700_scu_properties);=0A=
     asc->resets =3D ast2700_a0_resets;=0A=
     asc->calc_hpll =3D aspeed_2600_scu_calc_hpll;=0A=
     asc->get_apb =3D aspeed_2700_scu_get_apb_freq;=0A=
-- =0A=
2.43.0=0A=

