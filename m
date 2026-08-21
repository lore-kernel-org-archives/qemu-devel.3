Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D772C5DF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 08:05:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxKEk-000409-I8; Fri, 21 Aug 2026 04:04:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wxKEe-0003zu-PT; Fri, 21 Aug 2026 04:04:21 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wxKEc-0007VH-8H; Fri, 21 Aug 2026 04:04:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nfV6OLTANPLCuiApTkhCxtEjyappqQ8vTf33ztFS2xwvfIu9rrZLqfF8ZP5b58I7LZu3qAf1BxpwtlgY+veH8pCipLdNAM9k+WWvN0gW7XIFIlj/jGhEgvVWxwsjbaR5MG6t0q1NvjcEGzo+H33//yXnamDviShPgXMcSxYSLfrjbVwcki2zJjdD6AbGNsVIOhHbCHLP6nwnm6doy3IJujYC5MnsrKRHBNH73kr+TqwUDkAjmHYAJ2e0rTLGqwDNOHo+gOpf94oz32eLw5+ntzez2SsEIrXML5/iZjAGYmCm31HQ6TlkPDXACiLY411kETzd6cywI7RjXb4wkpdlEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dc3pRXwPjCkwlqWeB7WiFUyg3Yoo5A9Q2hpqRYKv7yw=;
 b=GdgKhbPYKJYLjULAp6NsQu0POKAdMCvc/6Ydmdc1/Hy6q9YMTccJRroYDdm7x7BGDcwvXjO65d+3ImtYnFKq+398l8yTOkAFXBbBVGT5tyTNlggEhN4G646nl7OO1x3NX1envSh0HZ22Mh0RxtETrFjSD2yp9ozC+LkrFnNzXsEIaI/xIffpYRhi6j/tyaoJyl0+OdRuSswyj2r7FTzl7Xn+SXAtCj6Z1g9lvsTlqovgKASIh9JaJ7f2dWtRwTmoCBkysJQTI2A57JoefLl328dJCuVWdmZb5ZKyTEuE4C2mbEa/IWI1o8pLdmMYpVF/d+IQg1U8SjFm5fTH6hwZ8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dc3pRXwPjCkwlqWeB7WiFUyg3Yoo5A9Q2hpqRYKv7yw=;
 b=k/EYcAXyqf2EGha1YPfnT6MEh0hd04Ilo6+IFftB6cYPWrnx2ZF2BCXIzeUHbxW6Py/iypRhLJ5j5ZmE7RVrY+CJLykCZW7xlxU3T67VIuzjMPDecmVvEEICDWdwaVE5m4STtOJxuTAVSh/wUT9EmnlTGq0GG/ORNUntIVUMU/Ok+QdL7dDkP9v5+JPxZl7BCdjiJu1UnohzwTzzBhn7jCCT4WcXoA67Zb5e+JTjP6hDn2t1twYFgoJ5mbFEe12XmeOwKtHu+ngNMMEw9iHueZ3POmxQYceJLbaufH76a95BGlqJUPdBXgRqmcLiwwk8E0jsLdfqlc1olYRk7cHm7w==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TY0PR06MB5594.apcprd06.prod.outlook.com (2603:1096:400:32b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 08:04:10 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0339.008; Fri, 21 Aug 2026
 08:04:09 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1] hw/misc/aspeed_scu: Support the second random number
 generator
Thread-Topic: [PATCH v1] hw/misc/aspeed_scu: Support the second random number
 generator
Thread-Index: AQHdMUOlne7pEatyg06yHRUtu8jqqw==
Date: Fri, 21 Aug 2026 08:04:09 +0000
Message-ID: <20260821080408.2503092-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TY0PR06MB5594:EE_
x-ms-office365-filtering-correlation-id: e461567b-4a93-4adf-137c-08deff5ac7cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|10067099003|56012099006|18002099003|38070700021;
x-microsoft-antispam-message-info: eNLMEbii9MqDAenSwqqxxfzf6C+LW+vsGgHcBw9EVnXdiqTO4yWE+nk9CeMyqxB9IE0/7hqlCgc2+/MDBh7mYg/FQuP+n5Ny94q0tmEdq1/5pLogUjAkCJuRzceVNNQmfxCnLu1/TUnikZeMo+hFZgSDoVLjnSD6byR4uhwwUMzV4uPDKVSSQvAf5VDi9xgCnkjmU0qpAF3gp/3Ucli66zl57l7X0/Lyscxqnt0jeOhr5R9f0AtX4/nya2RZHUU5Eg8YsL7BMe6LfmDhIqY8N+Hg2iZKOYH4/9kkPIuThXtp2VhMWrkjmfhmthpcp3PexRs08/GzAceIblMurgAAfTlVHGGqY4OISHymAVQRHXSDJnXKIngdFO+MxbxyQKHvKA8l4n7L8cDLamhFTWqXlYNMfoAmZPbrRcntuLshI08/iVL3kZmadCqabpB+F2dMMWRN8ZwinNTFRCUMiKNV1pXdOaQnBQZs9wbPnu9/6dPTi3yXaCNVaIA0zKLyizyiNF2spq3ido1FMvRqxgmyNjjqPGqBrLPLibCMC9kI4WkO5z+SFxXF3eR2iaUumiY1UnzreUpAYEsKx2+S/J14WPi95ut5uVGvp7hTLSWVldkd5SolRbVgfIxYPc/GVOqSp18lhYjECsKvedHEw292v5F77VWPnipCNLFThznsDu1WCsLxvjnj8qVimdVHjqxIBcesNC2eYHXDgfwc715Sww==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(18002099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cdSJFogSP8SSEJjbZAwyaLCfEkqKgt/DQeAFW0uGDNUGu2PxeCPyIC6faP?=
 =?iso-8859-1?Q?GNDGnQjKRDZSBa5/fakMfy9D2XCGeLoG2q3ndSKkSGqykzjhnvQQJ6xyeA?=
 =?iso-8859-1?Q?RWXHJjQ+HnxIq+1RBT/anc3cJhwrjIGjbSGBSkBsrA9PvrNldAfJ0x7FTT?=
 =?iso-8859-1?Q?3c3+wkxcELtMPoQnc9IihK6EbaM67dN9GEEmb8ne2BQIEZ6IhdE2Vb+aIQ?=
 =?iso-8859-1?Q?X93YoLj+65tzBqnJitD72Y4IuR8H8lC/ttqWvngRgG2jUA9cidy+v4c+fa?=
 =?iso-8859-1?Q?wlK9fGWFijDIEz/vHx0g39t+ZtFvQUBt3ZZFtD72fsCsvrQIxoKUZi2jdW?=
 =?iso-8859-1?Q?li4Twem3EQKPkUoh/b/7kSI8AgpIHJFkT8WFjyO9wMcp5+v7GLbb9IFhM5?=
 =?iso-8859-1?Q?Frpqy8gMe889we+WGG4/TbnZ4ysQ8zATjmb22RWosFMUY3qNV4AJiAKI4u?=
 =?iso-8859-1?Q?B0VASe+JUjfL0z3UwJNamOQd607ovvrQbCM8JnwisdbmhnLV3ozd59rZwx?=
 =?iso-8859-1?Q?GmxuS4iEURAVtwFIzaeSJrPklKFoGlBwarqvsLk5cV5z+/I7IFo73riddf?=
 =?iso-8859-1?Q?pQCOaJ/M19rwaBT+fAvAqLzW/paVZXxJpi5YOP4Hy9JrpolcAeb5ofgNJm?=
 =?iso-8859-1?Q?E/kyIlGQwuYOROLT1JzZT1CtNDJS1wqEVT/Jt5r3oXYxUkOtz6Ip+BsHhQ?=
 =?iso-8859-1?Q?HLeoWSxwS+ppgzjDCVO9dCgzcihchveo4u/jF92c7WlkUcQpmeTsFTPxbX?=
 =?iso-8859-1?Q?/0xanCWQI//Kb9W+8XQDF2nBdaYbfaZD6zni/JhE70EfqkpfrYKF93Cgeg?=
 =?iso-8859-1?Q?AioKVsCbkqRxX9Sqkp2w86zH7P31uIeaGmTI0OaeEgrRczBw+alR+TVc55?=
 =?iso-8859-1?Q?rjoGQS4bR1ONCt2ZcCME0/HLA47VGtMwroW0u3Rn/LaUzLno3sHYxN65cn?=
 =?iso-8859-1?Q?F+TrYH1Sd1h2hkKxh2xT6Pw2gg6G7WMUqtlOyDdTWhwr/jwtDaR8KQyUsJ?=
 =?iso-8859-1?Q?Rb0e6X17rjtwljVLP1nBwVSnur1SGajILfHa7nwcn78+gtl4dwBctcOZF6?=
 =?iso-8859-1?Q?ZMZQkGwbPwP2qkdAHRNuBFU9zi/fderPVjLUyY06c72adMUveBklhQsaJ0?=
 =?iso-8859-1?Q?FZTUIn1MzG0Ocb8eok8CmjUDnRLICKS4J2Cnkp4GG4tF7v/wVLUSrA0PR/?=
 =?iso-8859-1?Q?ML0pCXX4O3+bDt1T2xYpSip02NVNb67OCa07x1hXXvJ2PNf4ZtmAUzCnRM?=
 =?iso-8859-1?Q?bEun8k+c6a3jweEnXyR7eOUAPxWfEg+k7sfgKH8TdJ9dw372qyrpFWHzfq?=
 =?iso-8859-1?Q?jdEB2YZce8Ix+biYOvCyuqegpjFCKGPYwAYGcoT6qb+VxHJwaz5U2WLOMS?=
 =?iso-8859-1?Q?6ehlMY1rl8CEgWf61yw8bnzN0TU53+RxE3NZnas5OB9FDvHKgQ43HEeMvR?=
 =?iso-8859-1?Q?/l2KTAxvbVgRmuKMyJTW64VT6p3sKX5joHHp8f7uRlqhbgUA5kphZaJx1o?=
 =?iso-8859-1?Q?3i8zfViIExQ7nqk98ZidbxVNAXqFZXaey3+I+dzUfJWF7k+1w+1wuuDYjv?=
 =?iso-8859-1?Q?sOJGxOTCSLOk4kwxtgCetkfM8rn3mv3KLDLcpF+JujmTSxGuuvkQ3m1Tlz?=
 =?iso-8859-1?Q?dl6Ege9ZXpYyD/BF5bzoDfXBUelbK7eZs3XNcsDWbHwTmg21loGiepKv7s?=
 =?iso-8859-1?Q?6aOpfEaYL/GmDIF/tB6QQ0EEBUTlKEMR+fD0aPz8zUfazxXJJIoXdx0Nsp?=
 =?iso-8859-1?Q?rF8XeG6zmxy4jtPL9Ka5tpmbgZjS+26+9vH3U57wZeIljehfE7kEi4K8wc?=
 =?iso-8859-1?Q?vnr3tVGTTA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: q2u8Q+RcwOKEokri7HkIW9y2+nPegyZ579sZPfDZ0/Ok3+ANfKkqK8mC8w2gP3yJBnnJqPypO9vAqv3FUtmpBqBa69r6R0MegywcKnGmiDlmO1ydLcaAwUdS7tSqBW0BFg56LliDz/IpnohZ8SdocSjJdSHOF1sedESDg7Ip0qclTsnxjjmkY7HZZMwcXi67lWtyAxTIrTQfI7Y4aFSj5pC6J3KxvkWVoYfR0sK8YW2gMeoHZ4dJ+rcw4dhq74iA/VTOPbm7eyw5eDnBEbfS2kXeDSmHyaXY95yRw7Z65krKvrplFlpb0eGdnJU5fFzgae4NyvXC6SvnoS4OUFgUOA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e461567b-4a93-4adf-137c-08deff5ac7cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2026 08:04:09.7431 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4jIQmj7TfvYI0i/HG8tPVIagvKnLpDFkkw7cRHqXfNnN+sjefLk7Aj8ukw3yuvpUeCFxj/oK8hItrN2JJ6pL/CvjarGJhN7469teBgpDPbU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5594
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

Implement SCU530 and SCU534, the control and data registers of the=0A=
AST2600 second random number generator.=0A=
=0A=
Per the AST2600 datasheet, only SCU530[5:0] are writable and the=0A=
read-only SCU530[31] reports that random data is valid, which is only=0A=
meaningful while SCU530[4] is set. Report it as set whenever SCU530[4]=0A=
is, and initialise SCU530 to its datasheet reset value.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/misc/aspeed_scu.c | 18 +++++++++++++++++-=0A=
 1 file changed, 17 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c=0A=
index ca93c3699d..ca79a93b15 100644=0A=
--- a/hw/misc/aspeed_scu.c=0A=
+++ b/hw/misc/aspeed_scu.c=0A=
@@ -130,6 +130,10 @@=0A=
 #define AST2600_HW_STRAP2_PROT    TO_REG(0x518)=0A=
 #define AST2600_RNG_CTRL          TO_REG(0x520)=0A=
 #define AST2600_RNG_DATA          TO_REG(0x524)=0A=
+#define AST2600_RNG2_CTRL         TO_REG(0x530)=0A=
+#define AST2600_RNG2_CTRL_MASK    0x3F=0A=
+#define AST2600_RNG2_CTRL_VLD     BIT(31)=0A=
+#define AST2600_RNG2_DATA         TO_REG(0x534)=0A=
 #define AST2600_CHIP_ID0          TO_REG(0x5B0)=0A=
 #define AST2600_CHIP_ID1          TO_REG(0x5B4)=0A=
 =0A=
@@ -679,13 +683,14 @@ static uint64_t aspeed_ast2600_scu_read(void *opaque,=
 hwaddr offset,=0A=
         /* PLLs are always "locked" */=0A=
         return s->regs[reg] | BIT(31);=0A=
     case AST2600_RNG_DATA:=0A=
+    case AST2600_RNG2_DATA:=0A=
         /*=0A=
          * On hardware, RNG_DATA works regardless of the state of the=0A=
          * enable bit in RNG_CTRL=0A=
          *=0A=
          * TODO: Check this is true for ast2600=0A=
          */=0A=
-        s->regs[AST2600_RNG_DATA] =3D aspeed_scu_get_random();=0A=
+        s->regs[reg] =3D aspeed_scu_get_random();=0A=
         break;=0A=
     }=0A=
 =0A=
@@ -756,6 +761,7 @@ static void aspeed_ast2600_scu_write(void *opaque, hwad=
dr offset,=0A=
         return;=0A=
 =0A=
     case AST2600_RNG_DATA:=0A=
+    case AST2600_RNG2_DATA:=0A=
     case AST2600_SILICON_REV:=0A=
     case AST2600_SILICON_REV2:=0A=
     case AST2600_CHIP_ID0:=0A=
@@ -765,6 +771,14 @@ static void aspeed_ast2600_scu_write(void *opaque, hwa=
ddr offset,=0A=
                       "%s: Write to read-only offset 0x%" HWADDR_PRIx "\n"=
,=0A=
                       __func__, offset);=0A=
         return;=0A=
+    case AST2600_RNG2_CTRL:=0A=
+        data &=3D AST2600_RNG2_CTRL_MASK;=0A=
+        if (data & BIT(4)) {=0A=
+            data |=3D AST2600_RNG2_CTRL_VLD;=0A=
+        } else {=0A=
+            data &=3D ~AST2600_RNG2_CTRL_VLD;=0A=
+        }=0A=
+        break;=0A=
     }=0A=
 =0A=
     s->regs[reg] =3D data;=0A=
@@ -803,6 +817,7 @@ static const uint32_t ast2600_a3_resets[ASPEED_AST2600_=
SCU_NR_REGS] =3D {=0A=
     [AST2600_HUARTCLK]          =3D 0x000145C0,=0A=
     [AST2600_CHIP_ID0]          =3D 0x1234ABCD,=0A=
     [AST2600_CHIP_ID1]          =3D 0x88884444,=0A=
+    [AST2600_RNG2_CTRL]         =3D 0x8000000E,=0A=
 };=0A=
 =0A=
 static void aspeed_ast2600_scu_reset_hold(Object *obj, ResetType type)=0A=
@@ -1122,6 +1137,7 @@ static void aspeed_ast1030_scu_reset_hold(Object *obj=
, ResetType type)=0A=
     s->regs[AST2600_HW_STRAP1] =3D s->hw_strap1;=0A=
     s->regs[AST2600_HW_STRAP2] =3D s->hw_strap2;=0A=
     s->regs[PROT_KEY] =3D s->hw_prot_key;=0A=
+    s->regs[AST2600_RNG2_CTRL] =3D 0x8000000E;=0A=
 }=0A=
 =0A=
 static void aspeed_1030_scu_class_init(ObjectClass *klass, const void *dat=
a)=0A=
-- =0A=
2.43.0=0A=

