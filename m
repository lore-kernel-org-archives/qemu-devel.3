Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E67CA600A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 09:03:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEk25-00041s-95; Thu, 08 Oct 2026 05:03:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xEk23-00040u-FP; Thu, 08 Oct 2026 05:03:19 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xEk20-0000sh-Sa; Thu, 08 Oct 2026 05:03:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E4vx6I42qxKxP9Hd17K8MdLjKiQnqiWaH7HxH0kXWoL3wPz1A0biEa4LsbUHAL2GsWLdOqP1em0/34xMoaPdlnUQ1o5CmHZA9COtSNFhVHC+730Xq/OeCaeCnC7bI0LtRWRWxJiPGiUas9JNFzwmzPsX6Hl0hN2XwtekQxEnHf8CEdErVmizogbuIJZ3le/n405D8r9AlePcRNL7uDAip9gvE1MaHxXSfduK7Gyzgj5F8LuYSmR8kWGgX/qo6Ljrm/x6LZoIcsDILOiTeMQfyA8fTOrWv4wQP+LJVz8XHVpl2PIficfXzAeEHKaA3eqD1FM5WPDT4UuWjy2b3928gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1iFly5BKK7tHEbVFrAahd4JHRdsJvRaoc8wOLzuqJk=;
 b=KcGuftlMJkMzyEYs8syBamtZ1UlCSUXjg40Btg5HZft498eIivc9lzCnBapU0ZPYghRWyb+GLwmnJzDS6rdZlAcJEhLGcdg3Le8HUfjAqNkognkOdpB01ZJTTRu8C6X8Mrem5yPZSmSd67ou4tx9+82VkwFB579evpgdjhxaGe4D9YbSaSbBSkPSOynRGa6UVjV+JAD20gxKUFkoC+aP6X9IhA6m0QunbRyPdIbZAYnrnfi+zy64WnnCJJfvwEqdz5DEJ3od8SKc7oKZJofxwXv48t7qBM7T+s/pytjz+2skGvsTqu05+ebG9KMKkI1Lj9ZSECdrNI2LB9czOL0bVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1iFly5BKK7tHEbVFrAahd4JHRdsJvRaoc8wOLzuqJk=;
 b=h+5EXl5e9qljXS8eok/WedrESbtncfmS09fJIc/AlER2sHOKM6l9Tvyfuxl4tD4pmmFPoDcZX/JJZVXvgMA8oW6GRDYZ18PgCEoCIIR9i0xAihF5ZP5qogTVETKNuSNBpzhKC0qMxLGCm2VvVrAati+J+wFBkPNt96r7CH8JmAjzkf06cjTE3k7rAnwVF5av4EBuwYtVwX8FkKG/EPv5TKX3emDe2Mo2W58PPSkH/OAXi9OEB4uQLablXcnrXxW5P8Ruy7YzYAnFevpvoYLm05elv/zY+zuFZOpA2eBbPKyC8Xm7Wrk5pdFxmJvKHAkehX85kdWDFPH02Ge0GhfEhg==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TYZPR06MB5998.apcprd06.prod.outlook.com (2603:1096:400:33f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 09:03:04 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 09:03:04 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Emmanuel Blot
 <emmanuel.blot@free.fr>, Fabiano Rosas <farosas@suse.de>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, Kane Chen
 <kane_chen@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@oss.qualcomm.com>, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Patrick Leis <venture@google.com>
Subject: Re: [PATCH 48/50] hw/arm: minerva: add Facebook BMC machine
Thread-Topic: [PATCH 48/50] hw/arm: minerva: add Facebook BMC machine
Thread-Index: AQHdVwPAdJ2e4S1gnkWFGJsSpdSBKg==
Date: Thu, 8 Oct 2026 09:03:04 +0000
Message-ID: <SEZPR06MB736205BB571BC4FA9E89CD7EFC932@SEZPR06MB7362.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TYZPR06MB5998:EE_
x-ms-office365-filtering-correlation-id: 090e41f2-fe04-4254-e4a7-08df251af699
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|366016|1800799024|38070700021|56012099006|10067099003|18002099003|8096899003|41080700001;
x-microsoft-antispam-message-info: Jhb/KDDgJwbnOpuZ9w0SGmCBneQg9X1xtZ188D3qlabtP2ui2fMKkQM2l5IWuCi08XSfWUUAZmgSHAokrn0yzmaQ5MJN4D5Ojvvf8yBA4Gl1uF4k8Rvu/U2NGXUDIw+pO+6mUSk2FYAG5MfzEhYy70aj5oG9wb04zksbrXiWK0ZbWnt0c3FELJgnrzkyYrBBzR4/EJ6M1e3Ud1J0/2DMkbg1LHzDdsdOzSveZTUsjgSLe4C+wp2K6KUC8mbQ2VZU3MZKyo1OYOF0c4SwsGafTDSfW1Yy61j156MX1XvoNpktgY5Q7blDhUHTw7Iar9+jHMOwQXKgLFk+YhUjakA79tWmmRsOTG2pkCGBZy5iZ0C7OWk0ouQBXcJcOQ+BuVumcEL/cyvlDgJopRlOY1mf9K7EYa2hlRi7k7TGpR/XouszSKzldEjvNXNUI49bP6hVp+XvDiDTPzy1n36+35C543sVfGYqU/ssKygB/Zw3AZksdyFvzxiK2+GmHI3WDDT7WVN3HomXTKn2R38VpqpmyVsZviF0RuLXsnXbMLgyVOO6Y5B0WRD9hRGJUBbRoz6Do3tdAArK4INI9EDq4AbKZ1NIhV6y2oTV8Vo1j0i1IjqV9uwiEmUN+mG2LkD2Z0pz46lHefKFBvGEdKgxH32iOZ+B71Qbs2qeU6TBdlGV9VRgqomRarnxg1lH9pFpyjkMPCQvaFg2TRb/tPYKRAyS8MYYytHzsOgRuv+bOGMhZLjoQMBt2Ue2qshuBJG09Q1U
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(38070700021)(56012099006)(10067099003)(18002099003)(8096899003)(41080700001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ChRWOKNAa4eD1n3MrpI39yqPnLueCuhxh+4x+P+8rTgMUadqpjcldFZ4dX?=
 =?iso-8859-1?Q?oOSd6+H5d908LNSf/yNY6LWOGNimJ68pXJIFdulH/w0MxClzc8eDEzDCGI?=
 =?iso-8859-1?Q?juTr0xMLaz0diIDAIhsLAghl4p6AVHOlTthH3gF27c7G8i46Khyq7jz9LM?=
 =?iso-8859-1?Q?9QLXZAVLdEv/BaAY2Pqw9tNd9KyFYx0W+Ek/r0yYBPRtRvmHIZDjibe/0S?=
 =?iso-8859-1?Q?tbr7msbrZ7w8aKc6zpE11FI/8ZRca1Jh6rW/BVgb3+o000Qc/UJ0JL2TkA?=
 =?iso-8859-1?Q?A3Tn1lax+RmJUsU48u6/oLW7ZLlRC/Pzh2vwlZ1pUPsxEnEc8/WyethtQd?=
 =?iso-8859-1?Q?myvrx/6dhZnI4gUozPDzaPyexDsY+4qrYBgJibNFF5GVmmaSKNjDlLhpq/?=
 =?iso-8859-1?Q?1hI3NdKelT+w8CXgkqBl4Rc9rhwnvNsPC1UYwOWOPf1bQCLNEle6XOICx0?=
 =?iso-8859-1?Q?FRSWV/Z7lEFTfaKevFzYt6RnI2MWhwK9Pvt4phONS1uZvARGjZbd9gduhd?=
 =?iso-8859-1?Q?0gmnivvejavcbksK8tpsB0BQNNElLSRuqcItN9LYfyDn6fjPdTNFzm3+tt?=
 =?iso-8859-1?Q?+lMRvIOdUDYuoV1uP9WDZ0ve30Fi2qXd+/Bn3ZD3/HvBTDzdd5fPpc6AmX?=
 =?iso-8859-1?Q?zz07sIv1TZB4QD0ZENzcZ68YdLSdaUqt41GbPhSxUj8TLdK0yL1dqCyzih?=
 =?iso-8859-1?Q?nqifLgjlID4ulCZS/QXme4wWA1qdyNRPW/y0KYlUIoUDpXwzw3YlC7lGLh?=
 =?iso-8859-1?Q?3HGhyMYKvFiUTVy0GUZvH5HbTR7HvmXsRofM6gtgLF1llMpHO4jP5BmVAi?=
 =?iso-8859-1?Q?aaxOSjzqWd8X2O60D1MHVW+K8sztwMntXzLXZxkBxBd2YYb9IlUxDLgcIg?=
 =?iso-8859-1?Q?8gSS/ryY9dP2M9S8Pmat2Lx4o+X0W7TZaOJ+eyVleV1d7Jv0Z9QFDLak6P?=
 =?iso-8859-1?Q?pYpuDsUE1Zw2LNXVwH7KpKG8JvvFa2aJxs3D6MC95hwM4QtNQirdJPGYai?=
 =?iso-8859-1?Q?Y3CzemkklTKakPbQOsrQagrW0mlBrrQEOiQ/9ZeghlMLrzpbQ/suDCPPhX?=
 =?iso-8859-1?Q?qXnaGe2Uge2Yk04oudUynnsg/so+SSkFZ0V/kphsHn+I6iJqt1qAeoHr04?=
 =?iso-8859-1?Q?Hyi2Fp7r9IVj7ScxkQCVNNzRTnjIeEl8y6S5IoFslSeKzOLIz6sBxP81CE?=
 =?iso-8859-1?Q?QmuisD9u+qhdirdelOtFutcdP4RtnEl5I35CHuZUsrxhLogBGMFjKhxFL/?=
 =?iso-8859-1?Q?bNV62LFtC4aUrpJvVlYu6h7uavq8YGreaocXZeH5wiDuvlzSMykkZiG0cb?=
 =?iso-8859-1?Q?SHcKFns0T1wdlmkgfBCNsvOl01U18oDLrK4wt8y0atSKSNvkQIV5/sSB/w?=
 =?iso-8859-1?Q?1ZzsgAwJieZanxDRU493QOcHYppU+RwzLYMunJr5cyVU4mNODPcSgj9FhS?=
 =?iso-8859-1?Q?dmb2SWgPKcKfPKX4vCprinGDnzd6OM2S7H+wcBZCGk7iY3f2ZoXZFZOYxV?=
 =?iso-8859-1?Q?5D0+31mAhHLVLX0NTTXpPrch1tv1qzjzkkd8iLePIjB44qM6WaVrv7ac+M?=
 =?iso-8859-1?Q?xBi7gdo+Z1HqF1DM+ofw8AFk40t9nkuXKo7EGKb9VFYcaVLwA+5b5I7zZa?=
 =?iso-8859-1?Q?xHHMAczwGwb0qPxf+V3rNGHNjzgk4Wm8GNpP907382zVXEoILHBI8IGG6b?=
 =?iso-8859-1?Q?r057FFP5ZIkdhdMw/LWmUqt6GZypz210r6CTwH1v6CKMpPwivFf8C6DUY1?=
 =?iso-8859-1?Q?9WpArFdOab70gnGST/xQm0hfFskTIXwMPjkF7x8aNYzHmkfNkiNMnD7nF6?=
 =?iso-8859-1?Q?gkMMB4sOFQ=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_SEZPR06MB736205BB571BC4FA9E89CD7EFC932SEZPR06MB7362apcp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: GFafzrYgKauW+Ge4z/PLsG7cM8Tvl0mvb9WEdL2CF9L/aBMmsbYLhT4XwVE5EsQdLBYAoAyifzEFuD3C3aTGwXooTf7HJXuUjyZc11NbUgyEaJGFGVDdAZ/8smXP6ShkyNI1L3iF97Rh5KxMZP0UP128YAo6VlrJh5pZPauEcpwz5Lhn5r0c/QJN7mjgF8dZEmNFQr+1sebBPHepF9MCS35MOv8+ZP187BA703IVRQhhSgpMSkqiNv60bzXuqHgJvgaDKmNV83rCW/Wx4VTWUa3I8b0ZhojcCK7XSas2IyOJY9VXWEo4a7b7a4G3SifFL9ESUYkkoxlGBpor1gxGwg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 090e41f2-fe04-4254-e4a7-08df251af699
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2026 09:03:04.6016 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0vhWXV+0dzlvaHRw7RhZFqLPHyVOxHpx1WK1iF/tA9Cin3GC6BV7uWWW9qRqJfJk8Ks1aEmvw3Rv9aOI95Nb9wK4S3f1Of5wOOAvJeTtykU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5998
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--_000_SEZPR06MB736205BB571BC4FA9E89CD7EFC932SEZPR06MB7362apcp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


/*
 * Minerva hardware values.
 */
#define MINERVA_BMC_HW_STRAP1 0x00002002
#define MINERVA_BMC_HW_STRAP2 0x00000800
#define MINERVA_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)

Please drop ASPEED_RAM_SIZE
https://github.com/qemu/qemu/commit/c5538ca99dff8b5a000b0e5d639d784eeb0d9f9=
9

Thanks,
Jamin


--_000_SEZPR06MB736205BB571BC4FA9E89CD7EFC932SEZPR06MB7362apcp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
/*</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp;* Minerva hardware values.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp;*/</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
#define MINERVA_BMC_HW_STRAP1 0x00002002</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
#define MINERVA_BMC_HW_STRAP2 0x00000800</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
#define MINERVA_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Please drop ASPEED_RAM_SIZE</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
https://github.com/qemu/qemu/commit/c5538ca99dff8b5a000b0e5d639d784eeb0d9f9=
9</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thanks,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Jamin</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
</body>
</html>

--_000_SEZPR06MB736205BB571BC4FA9E89CD7EFC932SEZPR06MB7362apcp_--

