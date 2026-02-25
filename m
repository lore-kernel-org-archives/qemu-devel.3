Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC96F357DA
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 10:24:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvC17-0004Ig-EJ; Wed, 25 Feb 2026 05:21:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vvC0h-00043k-Ki; Wed, 25 Feb 2026 05:20:51 -0500
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vvC0e-0002uZ-Ul; Wed, 25 Feb 2026 05:20:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DsKxPec8MaAufx5qjJd7VqzTonXZAl6m/6e90+Rtr/Px6tC/NMN/GGMqpOSnG9K77Aj+LvWhMetI0LW38O/CuVhNvt9HN2dCBD4uTJc0pEimpZsTEpXlONl0C3mI4qIPcTDtTFmQxGVorCXoGAe8eimYLKR1jPU62CYGDO+z5nPjHEQAdHdHpwoiE/hCB99HOXstW6FGGXq1K2bG5BKMqNOFiK+1JOPUm/Fvprh1haN4ZzaBS3gKT4QK3BfQOxgh3URhPD/nUN92k2deyzHShXrBW6jO5N+wIMpMHFfNbjiGL1g64q2EF1/+SDcXE5ywRazK3fNbjx2IPgSN4/Q0wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oHkHuJoMcp9GfjxPPeuGYHjb9sMRLy1Ps6mwIOy/QwA=;
 b=ZtdeUzUqlnMdJEoOL+c3NPGxVurWLKcAAuOj/EKE6xlCgyMqEoct17uGqTg1Ld0dsSKqWXZ9Gf0gBQUXQ5UDSnnlxaLQECDprNPK58RXq9ElUU2hheqz9WfRg5GOQMoiOL+PC6kCZf7Wx1wgS85xaiwS9tbfqhJd9vHh6CtpWsjWaeWILbzLpUjSUwPTf3G3EwlMSg5oF4aRcRUZ8JJagkajl0Pfl9Q0vV8Lt7Nmsm8aerO48ORFSbVapXI3KPLgPhKA/STrqf1sNBYq/xLFrRWTjDcC5kkAYzDYB1NWbVFe591wGtKxbuC5IhTBLpgzRtoX79x3Q7NLbOsMFPyDYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHkHuJoMcp9GfjxPPeuGYHjb9sMRLy1Ps6mwIOy/QwA=;
 b=AE5KCIpF2Rr+U7CacWh9GPB/2dnuWTF7u8eYYwxj4P43I0ESn5THkIz/v6e531657XEMRc0z9rOPhiyAvA2ExmOk8ECnrdXwu40h7kpsKsD0a0Met2gJ8yPgNG5flnm5PyryZC5WC2NB+nKqo5HJBbGwIozJ0n3jhfsAdRAzUHIofVqHiFNAOdWJU1oY1NNKqzlM34KC0lwbK+LSyqvUkNGtkaHmSllmgLa6/ZbAvKPkXQUaNfFruGn2Szo7UJslLZSZbkBoY7zoKDjGXiq/5c4++HAQY1IQ7O3EjzRLl7lz0yH7W+Ll0NiFLddPIJTOvzzVjm3VIDDvaS6KXpIG0Q==
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com (2603:10a6:150:358::6)
 by PA1PR09MB7406.eurprd09.prod.outlook.com (2603:10a6:102:466::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Wed, 25 Feb
 2026 10:20:30 +0000
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63]) by GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 10:20:30 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v2 08/16] config/targets: Add RISC-V userspace targets
Thread-Topic: [PATCH v2 08/16] config/targets: Add RISC-V userspace targets
Thread-Index: AQHcpkBcr+SkDgrZRUexK7nbf/9Eog==
Date: Wed, 25 Feb 2026 10:20:27 +0000
Message-ID: <20260225102016.200654-9-djordje.todorovic@htecgroup.com>
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
x-ms-office365-filtering-correlation-id: 37ae1723-c2b4-47ce-9f4b-08de74578089
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: TRphnUGpTjNF87PnpneKDRjHjgsbedpP0BXKar8/MbHCrChIvijPt2+dPM8peGryiww/PhuBixESkjJ5Pai2kikJWlZ5MzbfXpMk21zIYbb9pXG26nnj33yRM2f0pfSEyUwJjddBYzpQwRUs2QFOVJpxwiZoFj0P+J29yQIwkvtBR2M9KZA473SIZX+0ML9a6g9/YHq3omM8vZj4/ZqKwR1Jo9EOy6jP+TFIzg74hOBKY5Tesl2LewnIyAt45PDm0uu2yxxKijAHO59m3p//Mgb4MOMtSS5kwQqK+nhbgzuB3rrWuGPpQMu29n4UKhfmgP/cRgU1W2FlF4EbdEA+dQq0zpAI+L7emwDfRyftWJIHCIH3Qo4TVeQzAd3m/gkRKDzuzHD06bVinP0aLOWI+jvL1VEkHnpNg8h8qruuq5ziKt9wgRdWVz6TF4BSZrdv+TEEt3wVsBNAdvLd8NJYMtg7wqsfjHKS9Qp9pbdohATlSmb8QbtzHgNiqcOe8D5y8UqcFDp3x5xDN6uAq3jVfFWddWtDpinkrXYdymuhxugRt3aE9VPZ3kO5ev3zTocccTFN0AGZnCw/qPio+DWXBknFhGRxcR+q0SVeXEBsUB68JMNPeAAM6VEwzAHP6BDRLu1SuoLt1TY1I9g6Cdvq1UdmVPHxGIHWNzLXbKY4bJJJum17n+YIoghF28xkkoOahXa2wr3TFqtmwlQvx/JDknimbR4r54pphTPpP0WcGlI1k2pWTR41o9hGW4TLGvAvuO8rMXQpPYB4TsHL6y+JyMMQqEEl7v9m4sVWzLaOaqU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR09MB8755.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ushS+iGt2kKOQL5gtu2vSlmOMBH/qoqXzJ2zj6NmSRPNvejwQeZOv1ITeD?=
 =?iso-8859-1?Q?I3r/AFcgxxAH/KwsdK895mwhc7AFwKYq4CntZOW/OeNV+R0wDgzBKh/B0M?=
 =?iso-8859-1?Q?9WbV1IJc9PvzVUrCSJaF1aIOOYg4BjWfHlDkZITCMrVznuNoWMNmac0qb7?=
 =?iso-8859-1?Q?tmrxtY+zWM19W9r6yI30Wfg5q1QEo0zQYX10Ud8KrdeNa5uKhw2DXPOo22?=
 =?iso-8859-1?Q?m+JZ9+YNlNk+zUwV/XG6Yprb4Z/1JmuGCaY3bdn5zhZxeMQm4hJEKGWhnO?=
 =?iso-8859-1?Q?vS6tLMserY536PlN2EeabRlKUAljjBWIAoAO6KBrFev7+5+VEH1uX6GjUX?=
 =?iso-8859-1?Q?WFH3cbbCV98t9dNRL3ebbdDPh5I84Il7As832Q24+tb4mUWiwRTuVp+UP+?=
 =?iso-8859-1?Q?CI7DRkupvPjtFUb455194ojlg5IwkzL8oQUbG20A/F4IMDj0FR9QRMLMg1?=
 =?iso-8859-1?Q?5bs0WK+lTL/D8OomLxoh6r/a4X3O7MRFcVeoHxrjuCj8ba32drFbbj3Oz8?=
 =?iso-8859-1?Q?W9e7L3Ml0dEVKHAPM1heAeTroIzRM7qeFJA13CmaUyZv16mxIisrGgDcyH?=
 =?iso-8859-1?Q?969YoYTKpzKnAaGKvEOtpJVfXqvZyy534D0Eg+HCWJlrbtk/T4r88dTOly?=
 =?iso-8859-1?Q?qYExKPredyjZwDFxWuI2HZKoLtrktxKUCEa1t4LhwvmoryL+85mZISmI4Y?=
 =?iso-8859-1?Q?1bI8WOhLm5u7QHoWMICxP3WmEV4cUfWnCBFwdYw9e0q50zDFiGNZRkwMG3?=
 =?iso-8859-1?Q?siAZUShAr2bF/gaimtw9hNMsjPVVfiaXKhbhY19T2U77xDgE2riDnvBqeQ?=
 =?iso-8859-1?Q?RmsJ6DMO9u1rOQUhP8QGDy7P1Mx6HQLIPyAJ56uiU2eKGBM/X6Owa/XKiP?=
 =?iso-8859-1?Q?Iy8WvRYy9jYDWIYR7BPTtGPlWYsXp8Z9gAj3X1y4BP7TvSk8i0uulMMMPi?=
 =?iso-8859-1?Q?9d68JbvFQLoILkzrwIRgugg6iFERKDO/K5JVT67QgjqxKEvxK/Vggihn6x?=
 =?iso-8859-1?Q?poT1zvXZliED4/i1P6dd2Y3MtmiCKtOSOJWwVwe+DR1Gv1Jhd+zwrQS/qM?=
 =?iso-8859-1?Q?cx6byDx0Bn9orz8dHwuqgXyMnfzld5TaHCYyy+x54WmlcGFS/+vv2PIdpD?=
 =?iso-8859-1?Q?cX/1Kar6AuQa0GuZJM3D4XZtAEDJlMAGBoZNjgwuyspXtLw8FjCmh2yARB?=
 =?iso-8859-1?Q?DOkyuAZMBu7wvwX1lG8GTjvieqWgV5d5r4k9sYVOtTGYKpj1eBJbT8xl01?=
 =?iso-8859-1?Q?x+U/YhkrbaDHRvUYd+ynN2AhIbnJaqYS2ul7/x4XzkVaIdJ7OQkTmFhIFY?=
 =?iso-8859-1?Q?OB1RLdcq2LdYJMk8kByS/rtMxCBqdKFaKG6mBF5CpXFSBrNnMhQ2btzYTi?=
 =?iso-8859-1?Q?tkly+pUMBd2+5O6Ufwc84PtGA/0rZUSkyeNeHnCMcXlvpKfea91O+HOGB0?=
 =?iso-8859-1?Q?8o2BZLDcPC/jH55DJvZ79YZbXdCobTfal+sUYAQ+9ijDcj1dsda211RIwE?=
 =?iso-8859-1?Q?hB3CiLT/pdgAPdFPgWwC/ggFIwclq927jR00fyCu/bewEh/MEipFp6gOTW?=
 =?iso-8859-1?Q?Jfi0Et0UD0SDZTEgaGnW7rXJ+p5pMoaMzcr3BGQJVoYQYjFFDixZnye70o?=
 =?iso-8859-1?Q?f0uUDSUOOT5k4vPe7Svr7UhVSiWrliKpDXbEHY45gB8VtDa+rVmRpgxOJ+?=
 =?iso-8859-1?Q?XG/L01Q/ELIsc7W3Ac+tZzyh8XGXcyCjCV3ygD/pJuX/miyGEvvVnHRY2o?=
 =?iso-8859-1?Q?qmdF7ufcKwWPhK4sHaaHbrHqVXgqnLYU9ojT+dz4VRjOeEf+y/girnRUfE?=
 =?iso-8859-1?Q?Vx4xrTX0ofruMTST8lq62tM1Q1r19BXJ58tGGFDgW/89BrmxOhto?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR09MB8755.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37ae1723-c2b4-47ce-9f4b-08de74578089
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 10:20:27.4940 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w+vffQDnm0b6j/aXKR7JWWQyTrTb4tqEon7aCTqMu/ImpDKtoq1e8rcEFgEwr6ubwpjlGoRKMKTMmb852617lIgx4C78uWjhWrFpnJrWM3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR09MB7406
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
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

This commit adds necessary tagets to build Qemu for RISC-V userspace
emulation.
---
 configs/targets/riscv32be-linux-user.mak | 7 +++++++
 configs/targets/riscv64be-linux-user.mak | 7 +++++++
 2 files changed, 14 insertions(+)
 create mode 100644 configs/targets/riscv32be-linux-user.mak
 create mode 100644 configs/targets/riscv64be-linux-user.mak

diff --git a/configs/targets/riscv32be-linux-user.mak b/configs/targets/ris=
cv32be-linux-user.mak
new file mode 100644
index 0000000000..bca84945d9
--- /dev/null
+++ b/configs/targets/riscv32be-linux-user.mak
@@ -0,0 +1,7 @@
+TARGET_ARCH=3Driscv32
+TARGET_BASE_ARCH=3Driscv
+TARGET_ABI_DIR=3Driscv
+TARGET_XML_FILES=3D gdb-xml/riscv-32bit-cpu.xml gdb-xml/riscv-32bit-fpu.xm=
l gdb-xml/riscv-64bit-fpu.xml gdb-xml/riscv-32bit-virtual.xml
+CONFIG_SEMIHOSTING=3Dy
+CONFIG_ARM_COMPATIBLE_SEMIHOSTING=3Dy
+TARGET_BIG_ENDIAN=3Dy
diff --git a/configs/targets/riscv64be-linux-user.mak b/configs/targets/ris=
cv64be-linux-user.mak
new file mode 100644
index 0000000000..ff4fade9ef
--- /dev/null
+++ b/configs/targets/riscv64be-linux-user.mak
@@ -0,0 +1,7 @@
+TARGET_ARCH=3Driscv64
+TARGET_BASE_ARCH=3Driscv
+TARGET_ABI_DIR=3Driscv
+TARGET_XML_FILES=3D gdb-xml/riscv-64bit-cpu.xml gdb-xml/riscv-32bit-fpu.xm=
l gdb-xml/riscv-64bit-fpu.xml gdb-xml/riscv-64bit-virtual.xml
+CONFIG_SEMIHOSTING=3Dy
+CONFIG_ARM_COMPATIBLE_SEMIHOSTING=3Dy
+TARGET_BIG_ENDIAN=3Dy
--=20
2.34.1

