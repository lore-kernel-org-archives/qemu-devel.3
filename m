Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BED3FF357D5
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 10:21:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvC0e-00042r-QR; Wed, 25 Feb 2026 05:20:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vvC0Y-0003y0-4a; Wed, 25 Feb 2026 05:20:42 -0500
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vvC0V-0002v7-3c; Wed, 25 Feb 2026 05:20:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ls7AlVqRUSAujC9OD0jES9gYyyjmLuMLS3SzY6lKTX/wI36iwR+foWR09j2rEGMJmrtuMc8PkDbqQUEU0HXl2waICFY/rmXnhl5+qgns5KinpOTyxZ/yLV6GHDcmqYyuGWndA8eGTq7hmzju7jdoiRVr1aHyq9z2aglr9Z1wXfCN3TLbB91SbB6Zq/+HprlUgxKkjdRzwC+jwnM7dhfutFuSQ6+Cy9bvoVNX/0m7ST4BP8++WDIXzzeyXNCR8v04YVbKtOOcPfUDTkmlB+EhU9YERgRL/gVrAstTxdmcXPsoXTEsyYZrPPGXBlHx4MltPrz+TON5J6Dax1PWM3TMSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykR8Ls8V/e8xoHHOkTKZbRcp+M5x1NwEpixdNcTGeUY=;
 b=dQdauuEPnTOja7XXHMBw4lx+jH31IxuI2u4jumk9W/J2bjDLkcBsfs2mGauqYojPUhdyqKCHEfrJRv5ymTckLcatcoNg0aTrHgg/CvFBxUB0/Ty8QN0W4YeElOf+nw5HRnYaraNn1HDstX1CporwA9e9Njij0/iZC3PZtlfQKwzal4lCkqRIpdIYI9SxiBj1stDpH7E6SfV7gTNMTErDl2q/DVRI+7z7ZnNuGFEWE6Aq8aKsa9wPSsATOn6VrF2uXScH8Z3/TNAh8wpKHuqANQ0LDkk+6zqGwNmYfB7TUupxLAayFc3PgQ6I1ZjD+/oYjgAMfpZ/y6ThEJ+yI78atQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ykR8Ls8V/e8xoHHOkTKZbRcp+M5x1NwEpixdNcTGeUY=;
 b=XGzvx/+oLH7zXWIoJfS0yv4DIJaWKtIJUy9nZ7FHSiTnEF5BdkXBz4c0jWXVb78Nbfl0xmq4o3QbWEqikpgZjnOIc5y4e8oyLWel3Q7F28lARnTGROaINzfxMLV5QjAx1r5W/I2JQaTTcWAthMMu8ZvTtZJInbWExcL28GJuisbhuA51xfQcdwLARrSxX5UzLFTuHzpO3u2T1vL1E7X//XPVcd/VE+KuwLlg+xkgVjSAUtshUVxYghJRGp3JvzXJs25qrASzGYH+mWB4O+/PcABHeEQuuPYgX9Tc371UAO/RVsm11hsTjhQRQJ+RZOphcVtwjKnFkYATfPF38y7idQ==
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com (2603:10a6:150:358::6)
 by PA1PR09MB7406.eurprd09.prod.outlook.com (2603:10a6:102:466::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Wed, 25 Feb
 2026 10:20:25 +0000
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63]) by GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 10:20:25 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v2 01/16] meson: Add BE RISCV targets
Thread-Topic: [PATCH v2 01/16] meson: Add BE RISCV targets
Thread-Index: AQHcpkBbwoHd9wpWCU6bxiczJ3oOjg==
Date: Wed, 25 Feb 2026 10:20:25 +0000
Message-ID: <20260225102016.200654-2-djordje.todorovic@htecgroup.com>
References: <20260225102016.200654-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260225102016.200654-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR09MB8755:EE_|PA1PR09MB7406:EE_
x-ms-office365-filtering-correlation-id: 23dddaa7-9aea-4939-f9f4-08de74577dff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: NPbemczwfih/D5NFMAXfSBlc9nEfeWPi5ShyDCcZ3lei7aCaiiaXAPvPOgiXymrl6VtgHrntEJWBTIBy3fMnEJ265Y8WRHb0XillJhZhsPxqYNxgz+w2sh0NisClecx3ww/KAM2jpKmHnwBUNjd/jHI1CsKMLjp6AQK41x7VQlDV73aRF6LQJfkbXq5HtWuJRAP0Wl73mlWAffv3joGUlQOdPXeszHbBh7NfNqwL3ByHU4ROg0PiN8He8kQKza9r4H6UqX8pr2CQdQRpNaHp9a+xgypMBVLivYBLAaJqJjkoESTiOtqvbN97GHZkEwUxAQQSBANuYS3PLCf813I8iNLtdSUlA4h1Z0zPTUFDjipWX4itFgEmRFuP7I3goMRpZn5peZlwk8K6jomdIgoBxMaKlU66hMarklGSSUV64pmr9o3LxGnRVV4bsR9g3v4RP2BRK7hDEJd74xcqyy5ZmNQLXhhEPGIEuJRpPGfgOpYAVC867qHVNiydSNEaZBwIuZgy9vR11LnpJ8o13E7mWdp9TuWsaX+EMGAVaexEa49d3sV1SsM91vS+vN8gC2wno8ptvXfu60/ogv416ypNd+yDCoG7K+AcsSWTp5MUYAt4Oq4J5aMApbNfSH77J+oQrAy1Vmy8NFPab/3VA5SfVoSfRWg8Iqy/Mf9mLA52aDKhFoUno7KhL2hPhw11xOHMZ/yMaBo/6xKc+IIRsPWR8FR2nUdAMMaGH3b/lu0EH/j6JHiy8ek0vHx6TDhXbGaZ0QncIUcggI+E8awLUzV4xQkn7lRyr1KlCSt/F27N4JE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR09MB8755.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6enJFEaImeLJRFBvvFhFLJvaxbPM1OarwCV1joxaKh4Vw9oOhap5mj1T2l?=
 =?iso-8859-1?Q?XWd/2IAu6+cBjyGhdxayGGIhqv86aEWBZHl5EAJtgzfN77juGn0NDftsYy?=
 =?iso-8859-1?Q?wLKJPyPytOLIaU6lgJRQidLYkY5/iKWWUuPWnxkG//MED9ziSZSnDWqytR?=
 =?iso-8859-1?Q?jNT8Xyso2DT+LT/GFlHE/YcqfYDEVFDryLcrstpegaPDOhO1NOkTqFOuzU?=
 =?iso-8859-1?Q?nfeczO3JIg12mYqPrFx5Jgs8t3Aa/TEKVPawLUnC2ndD6JyirgR9FpjRyy?=
 =?iso-8859-1?Q?kOZyCXIgONY78uZ2YQAMrJY0anXeXtCDnT1NXs+4ztE7ZolVbf7+OAL6en?=
 =?iso-8859-1?Q?cwL+W/XyjIu1DeYIlWwvAt1gEbNYj/S8tQcXZ0RO4PXI8VxA809a46oA1F?=
 =?iso-8859-1?Q?Ti9dFfIhbcLBkXjld5WALzmoNGDbmE/KJ319A3/d+TdexPboYzziy01uUV?=
 =?iso-8859-1?Q?Qxew+En1g59JOUfD5yJ/cFPG5iz8hjyHbM3i/m8mYYr0AYw6mFxdj/x5Pe?=
 =?iso-8859-1?Q?12OfaXj654nWKPd2bU8LbC8GwQvyejYJhY9JdtjhQbPhnk0BhdxoUBz4Ch?=
 =?iso-8859-1?Q?1D/u3FaRREe5k9Y1TXYRj9F40ubSpyFLyY14vlpijEyOc38HhgRCA1voGm?=
 =?iso-8859-1?Q?JQ45ERWNC2PgsoM5FWgJ+pFmgEgzPJyUUm8lmPiPnzWAQqQURNA0I8ZQO1?=
 =?iso-8859-1?Q?MFifiu1dDFmNiqpWE/PxLtDs1xGSWIc+7jaiLpe0go79fQT5H8UMf6S/gm?=
 =?iso-8859-1?Q?0iAn29QVpwoegQmMeYYEFf9DGleXWunCqICvVpllx3dga6sRL/YokZXs9b?=
 =?iso-8859-1?Q?eOWIfN+7DimRSJ1kVXIPT9bbqkzglHVX6mgcCsX19IPCQoxFFCQdHapvoA?=
 =?iso-8859-1?Q?egCS+F6xpzn0WAiSnCCtiRf75Bb/WpHPTnu2hsVqp3PBW46T4yaezXiQP+?=
 =?iso-8859-1?Q?6LBj+sH0ZULFEBADitxsVuOpCy68HSqyDZaVHK7vQYY2+FbCvUlv8KAUfE?=
 =?iso-8859-1?Q?+vKbBV3G7WB906ke9xW2eCvm7D3BVCjdbZrXMfKSa1zV0t8oVWP5LkFMWZ?=
 =?iso-8859-1?Q?BKxNt50m6RzNuwoF60uQvgd78Defwz6Yxh9Z6kytp1htZaZ76y7vwdkVAa?=
 =?iso-8859-1?Q?eHrMDVwpe+8Fvyf8B9lzvIlF2sZkyKHvNOrwaMsqG+7jtRWxBZeq1PqkiS?=
 =?iso-8859-1?Q?t5j3u2zxX2uSAz+5jlPgKrLC5xzXpVJJG9btVhG0YJZMbKpVtEo6Wh9f0R?=
 =?iso-8859-1?Q?/gANy60RxEShMk7qWK0DUPV3X9sWOoFt8pxx+aHgY7PLGqvtu+OAbkjosh?=
 =?iso-8859-1?Q?kYh5b1jLCIuvRdqUeShNEDtEYcu30hmDgGd6k6KUbFbObFWH2SMAiIjdPT?=
 =?iso-8859-1?Q?IWki5hrhULiix8UjnvVGLtRHI2JXvz03GActiNvWAG5ypvuwhAqS41jMFG?=
 =?iso-8859-1?Q?scCUclAdVflEpozRAC/iLsG4DUrqqVIVtX7tS3+/Ru4EnR/xkS4yqHvFMc?=
 =?iso-8859-1?Q?ZgsMrgfabX4Pwa7cpZ7/23B1c7M5fQPOSqsvelLQ3jtBdFiXzlf0kVPExq?=
 =?iso-8859-1?Q?DaEQl4RijZ3jxjTL/xcKHJaEji2uTKR9+p6aCdhrWWtur2vm9cj0xSd/fO?=
 =?iso-8859-1?Q?vCaYfFAY8zdgqFomuBO4IlprP0qD/q9ibnr/HmhKvC7dbhd/YDLBzE6+8n?=
 =?iso-8859-1?Q?7X40iO7DWjs1QXe+hPzAkV1V8pGh5v1VyHYo7vrPQzDv2cAXB8jaNfDrfS?=
 =?iso-8859-1?Q?9EZUiVnsxr5plgSLAMa346ZtSQfF5N4+AmD15jj2FZ0XleWfqvoRNvtDhO?=
 =?iso-8859-1?Q?TdZYRMYPKOV6nqGS7tgiAzW+8WWD3uklgvD548DmYg69jGlhh236?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR09MB8755.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23dddaa7-9aea-4939-f9f4-08de74577dff
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 10:20:25.3098 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bNNSH5R+70EZoz9Mt1vcVIwRoXIlGMxrjai5rB/eIN3djXhnvDTDojI4NFbko//ClET9bGogpkReOTNyc6CAZYZBCGGdEt5JfonUwIlqD5s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR09MB7406
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
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

Add options to compile riscv64be-softmmu and riscv32be-softmmu
---
 meson.build | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 8c6c0a9a32..41ad38d184 100644
--- a/meson.build
+++ b/meson.build
@@ -55,6 +55,11 @@ supported_cpus =3D ['ppc64', 's390x', 'riscv64', 'x86_64=
',
=20
 cpu =3D host_machine.cpu_family()
=20
+# Unify riscv64be to riscv64.
+if cpu =3D=3D 'riscv64be'
+  cpu =3D 'riscv64'
+endif
+
 target_dirs =3D config_host['TARGET_DIRS'].split()
=20
 # type of binaries to build
@@ -281,7 +286,7 @@ elif cpu =3D=3D 'ppc64'
 elif cpu =3D=3D 'mips64'
   kvm_targets =3D ['mips-softmmu', 'mipsel-softmmu', 'mips64-softmmu', 'mi=
ps64el-softmmu']
 elif cpu =3D=3D 'riscv64'
-  kvm_targets =3D ['riscv64-softmmu']
+  kvm_targets =3D ['riscv32-softmmu', 'riscv64-softmmu', 'riscv32be-softmm=
u', 'riscv64be-softmmu']
 elif cpu =3D=3D 'loongarch64'
   kvm_targets =3D ['loongarch64-softmmu']
 else
--=20
2.34.1

