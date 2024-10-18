Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FAB5D30008
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 13:21:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1mv9-0003jz-23; Fri, 18 Oct 2024 09:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1t1mv1-0003gI-Cn
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 09:21:27 -0400
Received: from mail-vi1eur02on20712.outbound.protection.outlook.com
 ([2a01:111:f403:2607::712]
 helo=EUR02-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1t1muw-00063K-7T
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 09:21:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A6F1gd7tfgiU7zWZpA9ErgII2ALRADxoazkdHmjUdUfdhxHpG48rZZGlyWek+P05IGXPqB/newRiXX3Ab2E/Tu8eYjtaQ4fxKNwY2oOyRZlVa3TM0jg6VBy1h/UHLC2f2xS/XjK/ANKZ4PdYdD9e3/GBgoEhcOOWFh4Kpx55nr8vkupYOHZlTTHDqXzlorb1vpH/vc4DTPpYofe/Ts6KXlu+lVL4hMA6onqaHUMnTEnxYMuZQhgvj6g7i884HkW3bHImUKXsSzNSei+axeS0LFP7TQPb0rw9rSYKrYIBs6VarlQTAfCRw3namR1j6KUJySh+3qtLTyI0OvT9udHVyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQ5sTWhEoiGZLWgsRNQQxTFfkoRF1YKoBojMqC5x6IQ=;
 b=bhowePJh3r6WBupOX3PNAy5ItBBmVJSVmazyiMc6a7SLkX2C8sTbBrqgb9yhMv/bKkOkkdmQFdVS6a7huPgn9S4qfG1VVcp3U+wLM/mLKTAtW3dJ6dGXl752LAqgT6wVcCaQlu4IGIWYFghlHJXsvv6BdAJ1clOl85rW62J92e9xQ+ZmOrOJz8F0oz/lYMTjqi5JcvZthUkb0ByIbfmeFKMHoGexOHA0wZqwMNuShlmj3xmM01+gdUhFLEPQORDXQu+IKwvifbpU06XXxkeWjhQID/oEFQJhYzb+8atTUlvITSi7mLCTCWnz1z6j+RPb7YLOxKKkz0R/ZuCDI/tpgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQ5sTWhEoiGZLWgsRNQQxTFfkoRF1YKoBojMqC5x6IQ=;
 b=gM7laTgDiBP/tOgoOJvrqmACuwcRZbuA7Mi+ML5eqHmsMHK8MsOBeCwOzr7be/pSR9mGr0qYdbuvPHJFJhWpU9C+xu7Awgx16HfDoxXn71u4Xnf4swttYsyNOWQ+KOKqE9YcnCavHmY/MDicjBSXlyDGtMx1vVu9oNSB0zonSLnt3QcQwRHa82Qegp3+t4nY9qsIRWnkinVX5JGCHmQ5vFe5LOU4JfC+XgYYEERc5lYx8Yjvv0PBfcpNFMXMx+6E4pK0xSKYE2gfowmPNK85O1rrFMeRQLgRkuIu1k+PMTZMVqMr/lM3vcR8FhWF6YcKRIPRQYrz5UwF/oWai/JW2Q==
Received: from AM9PR09MB4851.eurprd09.prod.outlook.com (2603:10a6:20b:2d4::13)
 by GV2PR09MB5889.eurprd09.prod.outlook.com (2603:10a6:150:ae::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21; Fri, 18 Oct
 2024 13:21:16 +0000
Received: from AM9PR09MB4851.eurprd09.prod.outlook.com
 ([fe80::2fed:370:dd45:13a2]) by AM9PR09MB4851.eurprd09.prod.outlook.com
 ([fe80::2fed:370:dd45:13a2%6]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 13:21:16 +0000
From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, "cfu@mips.com"
 <cfu@mips.com>, "arikalo@gmail.com" <arikalo@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Subject: [PATCH v2 8/8] target/mips: Enable MSA ASE for mips64R2-generic
Thread-Topic: [PATCH v2 8/8] target/mips: Enable MSA ASE for mips64R2-generic
Thread-Index: AQHbIV6zG7r1NGRInEu1u+T5QtXCOw==
Date: Fri, 18 Oct 2024 13:21:15 +0000
Message-ID: <AM9PR09MB485141F5613A7EBFC5A4A08884402@AM9PR09MB4851.eurprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR09MB4851:EE_|GV2PR09MB5889:EE_
x-ms-office365-filtering-correlation-id: 85fbdbb6-98ad-458c-5a3c-08dcef77bec1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?je9M1hG++82TdDjl/A3/bmM4k7MqEGbzrG4hi9C5Jm/O3QshDOUytrKlSq?=
 =?iso-8859-1?Q?VEFgg5I3AuJaGiHo9GSAm3+O4mmx7uPzEpFI1BICRu4DKBlYlFNrUqqPb+?=
 =?iso-8859-1?Q?9UZOflSWQhFOPwsqYSvA9Q4ueUfkLiKw+qdIOHAdJ9Liv7WG9fKB7pJM9d?=
 =?iso-8859-1?Q?rpUvOkpCvaT90SO8lazrcqcBmEZ84lKTl/f+GU9Mp4CKGMR5rfCVQCcFrM?=
 =?iso-8859-1?Q?KIKa32T4a4niR+8LseZDri4hiRzmis/WsZDGtbCHFFRjXe4DZG8I4wRyRO?=
 =?iso-8859-1?Q?Lad5E3HWZzPaNvABJvhREAbjgBJVaO5e38UTtyG6iD24xpSjVa0UhI2MDo?=
 =?iso-8859-1?Q?+oRYLj2mIwOf4s69rVnrmYU4l/JphVmLNbQgZRRtbg8/JSKb+byzpnXon4?=
 =?iso-8859-1?Q?ozinfsCzvpzD5wDfE0z3TBUOCkHZSArKAK88C1nDyOGZSQs/40x6HvSH8f?=
 =?iso-8859-1?Q?zJB6xzk3kx1IE6wD1xA3YHi+/9afcamjKROb1mlqqG9QjZGIPatI5zqeEP?=
 =?iso-8859-1?Q?KlaFCotb4R7rTC2Nm6xJwXQPfjWwHYZfDoyXL7Vxwhqq1knJC6mwrWmbcI?=
 =?iso-8859-1?Q?Zw+JniIdPO86mBAUW0x7JPUuSFLUBHiR/LACX45Tq1GmYw4UYs+n/CPEOp?=
 =?iso-8859-1?Q?0nl+loa8D+PPTH8a9ZF7V9xYtcx1a9yewkeP7XrnksaERa041XbvU0S8sp?=
 =?iso-8859-1?Q?ASaKO/gCaOii3RScEsRDDSqv5+YE8XcP8sj41EWjlwfLXQCq9HC86+gtIk?=
 =?iso-8859-1?Q?iZYDixcQ5YSyrh8FziNTtMNNW9SMyHVvYjjeqt090lndhn2vCDknB60Ubs?=
 =?iso-8859-1?Q?sjBAj+dRnKBg+x/nIiQW+xoOQEAKTgQULbIUrNRw8SfFH+CbEEEMmpb0Gc?=
 =?iso-8859-1?Q?c/0Lqukim0/WkfF/2iLQUrHgnNO9DTHiVSUADRrLPgRlhATKSiUxCVBpJU?=
 =?iso-8859-1?Q?D8kX4PYTMS6C0K6nWF2/rj4iDpLnkcloTbVOsoHdXbf8rWjIWVpCt9Lguq?=
 =?iso-8859-1?Q?LW0ImWEslHNfD5NyuzZ86DaNnC8HA6kM/Y1wCdS2+bBwjtgZjhtXASE9Z3?=
 =?iso-8859-1?Q?U70I/Nvq6036V7Ek+VDnwzE4uCD5fn29iVxQxYEjoah41yAKdXaiD6msxe?=
 =?iso-8859-1?Q?Nootn802cLjRFNPbm7kHX3B+ncsCjyglWm2AI8gaxGcpdUjhTITHaYgZVp?=
 =?iso-8859-1?Q?Qpl0QNZVNfV235b/rqPzNjXlTV+KiHLqcYubKjLJif9lK+7AcvXLYCISAZ?=
 =?iso-8859-1?Q?1DooiRL1EQb2tLgCin4TdNjorCs9Dk6tDWXubKyCYzOmiu2+jYW+fDexbC?=
 =?iso-8859-1?Q?RAXJHYj+mZd+BIHcYv0cU79BbX+EG07Pdocw4E++b1l/t+8ioh0AVkeHRf?=
 =?iso-8859-1?Q?jps3DmT9GdpnaMexSyF6o7RLEkosDGVTFI6vUt0kXPYuK/tzLkbypms8lG?=
 =?iso-8859-1?Q?BG8FwNhEHf2jHqGw?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR09MB4851.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?uBW5dkLEwpv36tqTqESFN7ZVYNMUaqVwhhr3u4PWGaBUCWiYeeBKSOyDLo?=
 =?iso-8859-1?Q?I2yKtvYyE5dlPdHX3GDuclEDmS30V8/m9+O2KV7sjMa1bRe+yklhrweozW?=
 =?iso-8859-1?Q?pZIRQe4VMXEr8Ylh16AtA3ADetoY3o1nnqpWtFtk6DEkO2cvG4BcZtymrc?=
 =?iso-8859-1?Q?ANXJnCRgr5Zz5cgltAUrBe6+kF3tLaaKudQstCXDDSUU0skpZG1vvIuvWR?=
 =?iso-8859-1?Q?QxynYlv7REXJApV8Ce+FY2IuWakEe17QWmyf6J/EU/2/p2D/Q6sLJGL5DO?=
 =?iso-8859-1?Q?8bWUkIF0E2LajjwtrffzWFyOo77gyHHkLJ8s5cC5hhUAu3cFazpIhny1bw?=
 =?iso-8859-1?Q?Hj6t+Y0w18nji9/SwdUqu8DfjQLe7YpC3zuZIQQUw5gLmBK39Y0uHOksSa?=
 =?iso-8859-1?Q?lMFRNozq5PsFg0h2iYehFbczTXCsGzKMiYYvlnvPI6Y3ER1AQY1cK++6A0?=
 =?iso-8859-1?Q?TaP6FR3vz0EVe9kQzPC71pn43zMNxA+2+5CwAUR4f7QOggtZFPwqSQcIKd?=
 =?iso-8859-1?Q?d/XB+x4i9Mp0xS/PB7PFKa90l+P+PXHlhjDGbOPTJZke5MmZ+E25Bjv3eZ?=
 =?iso-8859-1?Q?cXwYg58qRF0PdAFXbOiVku3ZDcKOAsQ65x4mZCa7YaNoGHKQ49PvamSf9X?=
 =?iso-8859-1?Q?FIHZwDOFO/uhkf+dWE+FVOy0zxbH7ZyhWy26QQcD6RcmR3ZMz/jxlxznJx?=
 =?iso-8859-1?Q?HYqXsr0z87aIX4BYLmmR9scVUK3gLfAXdwfHgMyaBfFgRHSM4VONVNwHGj?=
 =?iso-8859-1?Q?ZqNwRMHGrKNajpsF4JuHKf0YCkAhBOUSAIoGiskJYWLVBrnrMrsfFbpsyJ?=
 =?iso-8859-1?Q?vN0sxRw86osHslEBXfvQh3H0fNomn8Xn13mU+LszXmC46FpTQSiXjzraFK?=
 =?iso-8859-1?Q?FXWjF8lU8dttWoMCWIxuRHBJjRVFBtYfWzWCGEe69VmgrbK/45AJjLuppE?=
 =?iso-8859-1?Q?OjSsvmuZhWDpAtei5+9GJkX0vOjqoCUxDDUJ/RUIRMeWC52iz0EaqUhAqJ?=
 =?iso-8859-1?Q?gadSQmMfy5LetA9zj2HEAedzdDX3oCUBPaSeA1+JLZJy78KMIte3k5JNK6?=
 =?iso-8859-1?Q?sMCTGIGmbs+n/r/TXgFd6OmZoWvWf3ex5lIdJcwQUe4ZaU6F/TOdecLBof?=
 =?iso-8859-1?Q?ie5zLiATFyFHTgTBUsuDZ4oNs8m0IWY3p+E0GU4bZuClHYsLYIYZpsQpO8?=
 =?iso-8859-1?Q?p38mDSymgY6AI2jN9ZlLkbeeog3tnriv1S2yLP/1ksFCURSRAqoNXrx8jD?=
 =?iso-8859-1?Q?uAyQXmdgBlOikvodiBUycm7gDwDQsZyTbpnVR91uGtLkIr4gOh6lIxvlfF?=
 =?iso-8859-1?Q?gCgG6APFUS8w7iSvB1QbCLO17AiVXHpZc13idoNKcRovvc7wWfKgDvLmhq?=
 =?iso-8859-1?Q?B9kLlYEc704jBUhy4JPn1K5zaxg8otJkFFrkW6z6+cA+sSOQ3R1+Nd93YQ?=
 =?iso-8859-1?Q?Jz2G91FEFZ2o7tiUorpzk15NijEJhTcwiQjU5SIuugt3Nb4eKmJPZKFSsD?=
 =?iso-8859-1?Q?eb0qWXccPNLqaiPTJSjpCVZoozjnc4rh2RUSK+bfJviibrTY7Y3Q66vjAE?=
 =?iso-8859-1?Q?J0BU7zwFx0xyG4iYRt+FucJ4LfJ9363+BZm/HtS5nhVUJo9QrVY8sJlbXQ?=
 =?iso-8859-1?Q?dqOGtwY8ftzhM5DEpercRxszg+s8bueCii0quCgqAOynP4LB7g+Iij3Q?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR09MB4851.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85fbdbb6-98ad-458c-5a3c-08dcef77bec1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2024 13:21:15.9956 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dzgnbe9HUZ9hLoa3Z8efF6pqNjPyXkRgQDsDzQyMyD3wxjWY8MX91QrI3fECsZiKBNU22BZl8/QD6uENW2qBiGpMnb+n06bVFSxTlu7SA58=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR09MB5889
Received-SPF: pass client-ip=2a01:111:f403:2607::712;
 envelope-from=aleksandar.rakic@htecgroup.com;
 helo=EUR02-VI1-obe.outbound.protection.outlook.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Enable MSA ASE for mips64R2-generic CPU.=0A=
=0A=
Cherry-picked 60f6ae8d3d685ba1ea5d301222fb72b67f39264f=0A=
from  https://github.com/MIPS/gnutools-qemu=0A=
=0A=
Signed-off-by: Faraz Shahbazker <fshahbazker@wavecomp.com>=0A=
Signed-off-by: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>=0A=
---=0A=
 target/mips/cpu-defs.c.inc | 4 +++-=0A=
 1 file changed, 3 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/target/mips/cpu-defs.c.inc b/target/mips/cpu-defs.c.inc=0A=
index 19e2abac82..2b707cc5a7 100644=0A=
--- a/target/mips/cpu-defs.c.inc=0A=
+++ b/target/mips/cpu-defs.c.inc=0A=
@@ -678,7 +678,9 @@ const mips_def_t mips_defs[] =3D=0A=
                        (2 << CP0C1_DS) | (4 << CP0C1_DL) | (3 << CP0C1_DA)=
 |=0A=
                        (1 << CP0C1_PC) | (1 << CP0C1_WR) | (1 << CP0C1_EP)=
,=0A=
         .CP0_Config2 =3D MIPS_CONFIG2,=0A=
-        .CP0_Config3 =3D MIPS_CONFIG3 | (1 << CP0C3_LPA),=0A=
+        .CP0_Config3 =3D MIPS_CONFIG3 | (1 << CP0C3_LPA) |=0A=
+                       (1 << CP0C3_VInt) | (1 << CP0C3_MSAP),=0A=
+        .CP0_Config5_rw_bitmask =3D (1 << CP0C5_MSAEn),=0A=
         .CP0_LLAddr_rw_bitmask =3D 0,=0A=
         .CP0_LLAddr_shift =3D 0,=0A=
         .SYNCI_Step =3D 32,=0A=
-- =0A=
2.34.1=

