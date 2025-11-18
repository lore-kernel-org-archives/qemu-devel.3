Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B59CEBF92
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 08:59:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLHXZ-00081x-Ke; Tue, 18 Nov 2025 03:58:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vLHXY-00081D-Eu; Tue, 18 Nov 2025 03:58:20 -0500
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vLHXW-0003VY-Kw; Tue, 18 Nov 2025 03:58:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dCDaWYJFyi0h3taLOxWKlYtdCqk+nmI2vuaejLffY5WniAO1Rh7gaY7dgrXUFAbO5SezavzdSY5V1Wm8fGiosFSM6RBgRWg9FvDno9rHW6SdEMDI1kT3v5pf/uhmdmkVyQVyj+6VgRBQCa9DiNpBxeu5DKArZW7z5B8FdUW2m+KWV8qjztCWbYOIRYN9c3k2KHg5TTP8IvEAAcHlq9qtWk6JmvX2eTsR2wxIUDiawjwdOdQ2SstaXAMLkZ7sP6/C7hHEXlf0Y0nBZX4/f3QXxTDoUH8xA5qAewyqdaJcw42bPy1wRRlmxwXU+xIGtQIZK58oJtatx5ahGHsgEU1qmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EsPu9btCbW7DSJ7NChZhc6fp7/pC8mUVVI3PCreQbSw=;
 b=iN9+KldzN9ZwHjwH1jkZnoCbJVG6a6ziFmccvac9T2eUb3ka7+o4ilkZPO7fDQmqkmyX9mfzgPc27PkFqZEIzvWbJXU/amUzWTwh/F4eo1jl9Ff3zRiCWZhUakDE+aov+KsRd9jOV+TOeNLAf9gRXxN3fjDtU9xXUl7PnxEdnhoNEA/g8SG5/RSmwHF9gFnjjZGflmRz/hO6t7R867Q9jLFsJc2NYm5+erDTY+V34LENbxMh6gnvcEew0p2WDyjeHkrYtlpJvJ4MfhnXjV+CanXYyMpliht0tmhNsV8IAwqEDwCbvEWavt442OBZM6pijG/g0ksi394GXdpcMwXGNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EsPu9btCbW7DSJ7NChZhc6fp7/pC8mUVVI3PCreQbSw=;
 b=LREblKAs0FgduNdviwct+2GIseJgzJ2DOe7FiWOtKW1aWCBsgZEGM6RD1pnPzAEhtK0Q/+3A5bPu4dwNsVU09xnWSme4yZ7lmI9y21+qAKIOgM4/4uBjOZLiBvqeMm88q/PllEAO7P50E02St+36+shUvevUOqzZ4pw6zVYKHgFilgrcopG+Z4sDpOZdM30iuviDSXlkN99MVjLsPMVT9lRQh7RoMiCAQMrjVmZGTWJOrtBdQtBcItX6IPICW9RKqw6YdxK7Iph2c0p1zoUj3LEGZC3IPkrlOuENFMUoe2y7Yu5mDTGdeZnYOwYRtxG7FQYxxgIYmk9Nbq2EOilVmA==
Received: from DB9PR09MB6506.eurprd09.prod.outlook.com (2603:10a6:10:303::20)
 by DB8PR09MB3612.eurprd09.prod.outlook.com (2603:10a6:10:112::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 08:58:07 +0000
Received: from DB9PR09MB6506.eurprd09.prod.outlook.com
 ([fe80::1eb3:5638:369d:24f2]) by DB9PR09MB6506.eurprd09.prod.outlook.com
 ([fe80::1eb3:5638:369d:24f2%4]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 08:58:07 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>, Alistair Francis
 <alistair.francis@wdc.com>
Subject: [PATCH v14 04/14] target/riscv: Add MIPS P8700 CSRs
Thread-Topic: [PATCH v14 04/14] target/riscv: Add MIPS P8700 CSRs
Thread-Index: AQHcWGl0Ds4Owh2N9Um8nRD7btFM3w==
Date: Tue, 18 Nov 2025 08:58:07 +0000
Message-ID: <20251118085758.3996513-5-djordje.todorovic@htecgroup.com>
References: <20251118085758.3996513-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251118085758.3996513-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR09MB6506:EE_|DB8PR09MB3612:EE_
x-ms-office365-filtering-correlation-id: 07c0115f-431c-4495-7360-08de26809788
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?jwWMUFghnxfIB7aVwsQ+Naljyh4KFOkn7eordhgrQUI0JTw+7+H515mGdt?=
 =?iso-8859-1?Q?TQ62vHqZtg11vH5SnZkSpHyRwM3FbzPeusE9xxCQNICLWe2yN4rWjtCQ6A?=
 =?iso-8859-1?Q?BEIm+ZRXMRjbHxwUBv8RKGBcwN9tP4XMk0fZQg50QX3x9uNuGf0IZ3pxmD?=
 =?iso-8859-1?Q?VW1AWyCWo5S20nQ/pA4ViDLQPvXNmZw9vLlod1BFflM0a3tARIa2jm73jJ?=
 =?iso-8859-1?Q?K5pB6TTaNU5QORxdYfm2h8Y9/97jJmyci7JOjKlIGlfk2wJWQhToi97kGV?=
 =?iso-8859-1?Q?Rzs8tq/mQzkEAH73bK2MnS2Cjxja2rldbHJK/WD7zKYNA2Hk/S/ezwhtf4?=
 =?iso-8859-1?Q?rXyCs+M2l48du1EDUPuwqnYXpROLMsyVJJVMi0mHGxPwPJYwkzHogqy2ZN?=
 =?iso-8859-1?Q?9lGqYnF4V9fZx7XdLkYndo9NoC2p/7QRG/zPbxUdN9p6c0Aj2o97mXQ5iR?=
 =?iso-8859-1?Q?2R+du3VKKtKX8egJEI96qLTPIfKYejdTer6Y61wb9oBtHsbWH4YQB/mWMU?=
 =?iso-8859-1?Q?SC2xsShhtivIvLTPXoed+yvk7DDAx/HZYeGl3yx3Bdqhl+SM2+BNqSyhrZ?=
 =?iso-8859-1?Q?V7cYFOIORC9VLL5Kxvg6Z0nmKnE/BROmp8zj2p5yGWffPNIGA+3Nn/d2Nb?=
 =?iso-8859-1?Q?1BWFh3K+ELa9poX4Y9hZe+8UO4nc6yfvDewKnAXHowap9PGuKWd9JI5Rdd?=
 =?iso-8859-1?Q?Xse9QX6DPBp5edFDsNDZrUHrcl6FTIsj5vP6HWEocCj7xDiz3dFKw4Np6D?=
 =?iso-8859-1?Q?I56pKbYfFCc3grU7t520EeYa0CP5hW8JQqxJSnNhOZUa7gB6G3TTxEpQ3i?=
 =?iso-8859-1?Q?TsfVyMJSaBepIyeCUTI2zvyHLIlNDjdwphPaKCzQ0iR5hKC4jGZ/AiVQwt?=
 =?iso-8859-1?Q?WO6BqvmZ3pq/37cwWBhxeKHbVRJ4bagui++TRA/YYKYqjdZXMbF6CSi5CA?=
 =?iso-8859-1?Q?KO+jix+RZuOJApXH9LGOMSVued1wKvHtDkCvnMUUCBCygnHtNfH9NjdVo4?=
 =?iso-8859-1?Q?2MB3/JuuIQtdiKOjSs5XLiam/ueaYMOjpAi189TAYVX0AlnfnTBYPymK6L?=
 =?iso-8859-1?Q?rV87LT0Q5GSl8rpxLbCdTihc5ED8u0mzbycEltnC/EHPpRtOh0Y31OWweT?=
 =?iso-8859-1?Q?KHeaAclXV/5fUKORG6BybBeM3G9xZ3OkNGBsXI/EHDJHAEt1LAGA3g+0zl?=
 =?iso-8859-1?Q?zt3xat94ggKrr68DhE/6Kvm3wHGis9e+97wstZBTskGxczfrMnWYtHmiqk?=
 =?iso-8859-1?Q?GKo8pvl/h53Oar+6HRc9Zvhv8pJk/u/C81bIvlGgVkk36ZDcQCZQCD/3OH?=
 =?iso-8859-1?Q?BMxjEvdXSsg0jySdbOR5d0f84sPiuZZlHmD8FrnF0KURm1O+EtCD+nWhgs?=
 =?iso-8859-1?Q?p5/VqazRSQj0tmkdyItrbQT8t1+T7XkRCUNkLJdfa7fibVQV47R6ojYSbz?=
 =?iso-8859-1?Q?gEyRIhLme+lHK0SaQXN1Lb1loO+T0TB5FX8jZ95vS4fUW+jDVMEBgckqO0?=
 =?iso-8859-1?Q?yPLmszH306E6b6YuicjzveU/nzZdCebnPKD8giqxjNKnlcYa344omXW+in?=
 =?iso-8859-1?Q?Ms7nOe9tLVSZS39YaCfnLcM0MKgv?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR09MB6506.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tuprh4/Pub5jQAAodgF5+GUze/dgC2VQjo74SJXlofzNYKysB7ah6j12jE?=
 =?iso-8859-1?Q?amB+TmC5ymdLbK8vMcdM2zZXRcSIePaACC3geH3DtzZ/SgECGKOUuJbe4T?=
 =?iso-8859-1?Q?pFg/ifBRZe5VqZDl9FeyAzL/sIjhkIVClN74te03OZ+TRvDyDWyT2aifom?=
 =?iso-8859-1?Q?sVuS3ZeMoxDuFqdFB8f8B+V4FRbuKFHPu+g4p+sL+iwY4Ftu93Tp0S9Kwy?=
 =?iso-8859-1?Q?Z8uW4zA5/ntRyFdpeznDKsx4uWGm5jK16cOR1T6WrPmOfm1HR90fPIdWur?=
 =?iso-8859-1?Q?G643CHifPfJmyeDXqTtqiYfY7pBpqOTAqDv/NoVwSuMofPY2wpbdMd6RYA?=
 =?iso-8859-1?Q?G9YBkAw5AfZnmcXaH5o3DOV9pn1dh/MqeeOtls08wYenjG06fRQLtVSsbd?=
 =?iso-8859-1?Q?Dl0P6N2k5TA4lz7XP8UWkYzOwxtudai3qJ9hugohbhohm4FUXXywcPHnuC?=
 =?iso-8859-1?Q?B/3CkXgx7WW5cd6+GCMjM1qB7ZhYlctJRKK1P8qrmtc+UCyuSBLoxBRnRj?=
 =?iso-8859-1?Q?YEstbeNLtB0nbHOD3tj4SWVxI9FrKlrzrSUnp+vaDFsPWO3x6FCobsOIxT?=
 =?iso-8859-1?Q?AuCovlSfBNnCVtQTbCmFsF+63CdjIyif37p5W2m4cCInBTL2B6+EPzmf3I?=
 =?iso-8859-1?Q?EOQJjy7Kv515nkG2kqp0Ga5RYzSnc+7dlX3cS4PEClygu/9U0V4yQM8ULc?=
 =?iso-8859-1?Q?Z4VuKP5Z+3JcjjqJr5WoXvXqHEfoTghLQPUodN3JrWbAt5yNXlKe68/kFS?=
 =?iso-8859-1?Q?47cHURXewf3gSzncrCHoG+S3lfa9L7HdBrz79skeDz4AsLL2fgQe9YcfUU?=
 =?iso-8859-1?Q?74DpV92o9FuTtv6/hdcdOjK06F1Ewf3uiAzMTNDSnEZkwDIAx6A87DsnT1?=
 =?iso-8859-1?Q?TRAgbOdgfvuImp+kU1LoQNIfm1QGU6vM1XdJdERwh3Il44qZdUzDExK9xk?=
 =?iso-8859-1?Q?WP8Wd+aBK143BJW1fQNhZJw7WahxVgwMH44zXz4JKkxOvQYKG37AbjFkHN?=
 =?iso-8859-1?Q?uLrutnefFsQw0gibv67inU+NbAl/l6DbkIYAEttTIWBn3Z/pmdvzOT4gVk?=
 =?iso-8859-1?Q?e7WSjhKQZcLOCFOc1yR53qCGE+60CvFpI6yJLd9d8z5ET6ODqvK8wIjHdn?=
 =?iso-8859-1?Q?yW335Cv/brta0QUQqOiZsMJHQBet8EMLH9hEcOy6nv3snT1Fn70UbzyMSK?=
 =?iso-8859-1?Q?6kaot/sPx8l+VErxKxyzxyj0wXharPnHnjtJ9GKUND+cCnbMYHMfimlcWX?=
 =?iso-8859-1?Q?4vLmB1S/fQx+Vioeo9Xqpg6kkZ3YgKb4Onw8CFtsNlpjdP2JaTqvWlejr7?=
 =?iso-8859-1?Q?94XVc1CsqSeqFffTGTvrL9rrTolRqQO4M5Y3Izsr/mXetPR84KnXa9cLAB?=
 =?iso-8859-1?Q?0TjL48cFnLj6t/8vLLVcB8ibS+OS28IOUdhmIfm+8i3MsElN5V/vaTmmLC?=
 =?iso-8859-1?Q?x9dksjFScwSOaSxbqNf1nnnf2gdfVXb+rjmnJFS/dKRyjimeNfsB8Gne+Y?=
 =?iso-8859-1?Q?S3nEFeF2DPTiUoH1rbjUR+aAPJ0c2Jn1asstI7uI0zejZ7W0S1Is+bIdC2?=
 =?iso-8859-1?Q?2JrmqmIwJ2dAyZum8HL3haVSrgkZGE0jKkazajQXvzbTCG/nKi3j7KQpN9?=
 =?iso-8859-1?Q?04Ika2DsbP1+g/4wLoz+3OGy1smtS+oo8SR8GaOU5TTtGD9CdX3mhQ2fsX?=
 =?iso-8859-1?Q?rkIZ0doaBrFkpdfkfyU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR09MB6506.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c0115f-431c-4495-7360-08de26809788
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 08:58:07.1263 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ICf/qlQdD4bHRfYzIhL5+572FNnEjSvEkXevlfMwhvXX9bWAvwJJSNA2ixZwy4wpNDuRBss6OWob2CMZ2SgtIBSda4QQ3Ffn5CB0gMSTsT4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR09MB3612
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
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

Define MIPS CSRs used for P8700 CPU.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c       |   3 +
 target/riscv/cpu.h       |   3 +
 target/riscv/meson.build |   1 +
 target/riscv/mips_csr.c  | 217 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 224 insertions(+)
 create mode 100644 target/riscv/mips_csr.c

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index cd4e442bdb..2fd0ced25f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3297,6 +3297,9 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .cfg.ext_zbb =3D true,
         .cfg.marchid =3D 0x8000000000000201,
         .cfg.mvendorid =3D MIPS_VENDOR_ID,
+#ifndef CONFIG_USER_ONLY
+        .custom_csrs =3D mips_csr_list,
+#endif
     ),
=20
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 34751bd414..234210c6b6 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -987,5 +987,8 @@ const char *satp_mode_str(uint8_t satp_mode, bool is_32=
_bit);
 /* In th_csr.c */
 extern const RISCVCSR th_csr_list[];
=20
+/* Implemented in mips_csr.c */
+extern const RISCVCSR mips_csr_list[];
+
 const char *priv_spec_to_str(int priv_version);
 #endif /* RISCV_CPU_H */
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index fdefe88ccd..25d59ef9f9 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -36,6 +36,7 @@ riscv_system_ss.add(files(
   'debug.c',
   'monitor.c',
   'machine.c',
+  'mips_csr.c',
   'pmu.c',
   'th_csr.c',
   'time_helper.c',
diff --git a/target/riscv/mips_csr.c b/target/riscv/mips_csr.c
new file mode 100644
index 0000000000..822e25e346
--- /dev/null
+++ b/target/riscv/mips_csr.c
@@ -0,0 +1,217 @@
+/*
+ * MIPS-specific CSRs.
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "cpu_vendorid.h"
+
+/* Static MIPS CSR state storage */
+static struct {
+    uint64_t tvec;
+    uint64_t config[12];
+    uint64_t pmacfg[16];
+} mips_csr_state;
+
+/* MIPS CSR */
+#define CSR_MIPSTVEC        0x7c0
+#define CSR_MIPSCONFIG0     0x7d0
+#define CSR_MIPSCONFIG1     0x7d1
+#define CSR_MIPSCONFIG2     0x7d2
+#define CSR_MIPSCONFIG3     0x7d3
+#define CSR_MIPSCONFIG4     0x7d4
+#define CSR_MIPSCONFIG5     0x7d5
+#define CSR_MIPSCONFIG6     0x7d6
+#define CSR_MIPSCONFIG7     0x7d7
+#define CSR_MIPSCONFIG8     0x7d8
+#define CSR_MIPSCONFIG9     0x7d9
+#define CSR_MIPSCONFIG10    0x7da
+#define CSR_MIPSCONFIG11    0x7db
+#define CSR_MIPSPMACFG0     0x7e0
+#define CSR_MIPSPMACFG1     0x7e1
+#define CSR_MIPSPMACFG2     0x7e2
+#define CSR_MIPSPMACFG3     0x7e3
+#define CSR_MIPSPMACFG4     0x7e4
+#define CSR_MIPSPMACFG5     0x7e5
+#define CSR_MIPSPMACFG6     0x7e6
+#define CSR_MIPSPMACFG7     0x7e7
+#define CSR_MIPSPMACFG8     0x7e8
+#define CSR_MIPSPMACFG9     0x7e9
+#define CSR_MIPSPMACFG10    0x7ea
+#define CSR_MIPSPMACFG11    0x7eb
+#define CSR_MIPSPMACFG12    0x7ec
+#define CSR_MIPSPMACFG13    0x7ed
+#define CSR_MIPSPMACFG14    0x7ee
+#define CSR_MIPSPMACFG15    0x7ef
+
+static RISCVException any(CPURISCVState *env, int csrno)
+{
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_mipstvec(CPURISCVState *env, int csrno,
+                                    target_ulong *val)
+{
+    *val =3D mips_csr_state.tvec;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_mipstvec(CPURISCVState *env, int csrno,
+                                     target_ulong val, uintptr_t ra)
+{
+    mips_csr_state.tvec =3D val;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_mipsconfig(CPURISCVState *env, int csrno,
+                                      target_ulong *val)
+{
+    *val =3D mips_csr_state.config[csrno - CSR_MIPSCONFIG0];
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_mipsconfig(CPURISCVState *env, int csrno,
+                                       target_ulong val, uintptr_t ra)
+{
+    mips_csr_state.config[csrno - CSR_MIPSCONFIG0] =3D val;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_mipspmacfg(CPURISCVState *env, int csrno,
+                                      target_ulong *val)
+{
+    *val =3D mips_csr_state.pmacfg[csrno - CSR_MIPSPMACFG0];
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_mipspmacfg(CPURISCVState *env, int csrno,
+                                       target_ulong val, uintptr_t ra)
+{
+    mips_csr_state.pmacfg[csrno - CSR_MIPSPMACFG0] =3D val;
+    return RISCV_EXCP_NONE;
+}
+
+const RISCVCSR mips_csr_list[] =3D {
+    {
+        .csrno =3D CSR_MIPSTVEC,
+        .csr_ops =3D { "mipstvec", any, read_mipstvec, write_mipstvec }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG0,
+        .csr_ops =3D { "mipsconfig0", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG1,
+        .csr_ops =3D { "mipsconfig1", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG2,
+        .csr_ops =3D { "mipsconfig2", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG3,
+        .csr_ops =3D { "mipsconfig3", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG4,
+        .csr_ops =3D { "mipsconfig4", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG5,
+        .csr_ops =3D { "mipsconfig5", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG6,
+        .csr_ops =3D { "mipsconfig6", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG7,
+        .csr_ops =3D { "mipsconfig7", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG8,
+        .csr_ops =3D { "mipsconfig8", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG9,
+        .csr_ops =3D { "mipsconfig9", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG10,
+        .csr_ops =3D { "mipsconfig10", any, read_mipsconfig, write_mipscon=
fig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG11,
+        .csr_ops =3D { "mipsconfig11", any, read_mipsconfig, write_mipscon=
fig }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG0,
+        .csr_ops =3D { "mipspmacfg0", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG1,
+        .csr_ops =3D { "mipspmacfg1", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG2,
+        .csr_ops =3D { "mipspmacfg2", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG3,
+        .csr_ops =3D { "mipspmacfg3", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG4,
+        .csr_ops =3D { "mipspmacfg4", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG5,
+        .csr_ops =3D { "mipspmacfg5", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG6,
+        .csr_ops =3D { "mipspmacfg6", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG7,
+        .csr_ops =3D { "mipspmacfg7", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG8,
+        .csr_ops =3D { "mipspmacfg8", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG9,
+        .csr_ops =3D { "mipspmacfg9", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG10,
+        .csr_ops =3D { "mipspmacfg10", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG11,
+        .csr_ops =3D { "mipspmacfg11", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG12,
+        .csr_ops =3D { "mipspmacfg12", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG13,
+        .csr_ops =3D { "mipspmacfg13", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG14,
+        .csr_ops =3D { "mipspmacfg14", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG15,
+        .csr_ops =3D { "mipspmacfg15", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    { },
+};
--=20
2.34.1

