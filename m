Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34CB9F357DA
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 10:24:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvC0m-00045j-Pn; Wed, 25 Feb 2026 05:20:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vvC0Z-0003zM-De; Wed, 25 Feb 2026 05:20:43 -0500
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vvC0V-0002vD-Vi; Wed, 25 Feb 2026 05:20:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OCsGcHxboj+QvI7yI7BNGipzuItAyRiEkiA62RHic+nkHGh2S0/NzKtlfpgrWbVj8LAWrSBJ057M05SejlpCXOIV/g1qlmIbQ9lREadrV42SBlzRIA0GTlnmTCT2y2gBbN4NDxZl9fSh1h691acpLQEV0Y7Ip+iPGjBEZub2Jl6rCsiUZ249V8WiWktdO2UmudJ4N7Yk13WOTb8irfw4NDzjpxIlLQFOeosRkZkFDG0ElvSjA/KrBeaz320VYKWoB3RcBQlNkqj+Jq2QR6JyToEqKGg3kn1rsrOfvPoNqZ+RhUHh0S1GltxqyZTIqd12tcATTeQLQzlOW4JzYhc37w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hbV4GTZnZYuBtlF5RrmuyjjZMTn0/qcV5i9lOsFrhjQ=;
 b=JxkPjXeRh4SjG8IZFdPjkkDcWi/LQArgCsPvJzKxUCsqCMtOEnlmgntePe+GdIMugoeb/Eo3fDquc04GZKLhFJUfEi0dk0pbOBASECKw0nZ8rw7ARcN7DWRdiAvIsd4LqpREQkAA7Kp9Zqinw5VXrCNBTR+y2sE43FZuKYXn5DjgOhPmge2xKt+KA6dkCCUmNuX6NaS3mKpm/2exZ/Sf/1cCSVvfZv35LTIyZ5bUl49ugfBB+nnqMcRX57Qo2m/NV7q7QXavjCAJbdNZPoPFzCqJ1Gey7RHDWR4JZN7tjWW1CMa6IsSb1CFBYgoMriLrSXYXJF/2OCvy+wML7q9lig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hbV4GTZnZYuBtlF5RrmuyjjZMTn0/qcV5i9lOsFrhjQ=;
 b=XAELrszF10CHvN+5YnPwhg3pfxE5rjY2S61TPCcw/3RTtA/cv4kH9zdtpOXKU0d4Fr5gvDBs7fdVl3GrVgxgGggv972vBH8S/NBOTEpzpv+olO4Cuu717WJsNcU1+BaLKti8f1BY8ExaLLZkdflBX4hZ2VHK4jhM5CM2+9/1l2Pek1hqiPeLHK+q/q2L5BOBcprGh58OWRHpknp5OdhXaGrCHEf5F85/r33CLgD5nnyiMnTDCSbk9DtT4tZ1sbAzRsFportKdvGSavwI6rZftoNsr4nEIM9hTNOPmGP0EfvDrOt4PSHfZxsfp55nchzL181c/3g1SvuC5YJQQt/WWA==
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com (2603:10a6:150:358::6)
 by GVXPR09MB6845.eurprd09.prod.outlook.com (2603:10a6:150:11b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Wed, 25 Feb
 2026 10:20:32 +0000
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63]) by GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 10:20:32 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v2 16/16] qapi: Add riscv32be and riscv64be to SysEmuTarget
Thread-Topic: [PATCH v2 16/16] qapi: Add riscv32be and riscv64be to
 SysEmuTarget
Thread-Index: AQHcpkBeMzCaPt/AvkGG3pwGUbOjvQ==
Date: Wed, 25 Feb 2026 10:20:29 +0000
Message-ID: <20260225102016.200654-17-djordje.todorovic@htecgroup.com>
References: <20260225102016.200654-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260225102016.200654-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR09MB8755:EE_|GVXPR09MB6845:EE_
x-ms-office365-filtering-correlation-id: 4eb89fe0-3e05-462a-3dad-08de745781ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: eEeDik8JAJs6e1uvEOB5iyelOxWjUcxYxWh9r/BoV8CLPsC/9ubWhqav8UtpEapwAAIN0cg3HQVVjRhQAfg+sP17+nzP2Qgdo7mohGvKNT1QKRGhNi7mVsHQGolFG5udgldnvbwl3It70nnUXz6Rr4NagPF/C4tFLedw4w7WTPubH3Lo/26gtxBWO4mva3tDQgQ7VRvQJs5CJI3Z4MsLia0iuX9qs0OFROsq/jsCzAyPzBVThSvXZaFbnHDj3YPam2FIv7AmAtHNTTFy7ORiiLpJwv7lCg0bkKH2TpY+kGD9YJTpgqu8nrv/B3YSVmQLLC9xXj2NQWkLrhk+8JmbEAb0MsIOYpR+OOL3LIfQf4lv+pXoEqm324FA1iRMNfyAX53ZcDUwOmh7EiUE6CS9ZxgE6gZnxXl5cjcAPGZYdaWhfYvpeFsUFFDpUTD006qkhmLyC1GQMCWLHMxbnjtJVSooxSkFNZmfYVj/qBCxL0LAj8EoCwfDyxzvIl5srw00W+BnfEvjzYoDwCU/ftDyjKojcMSmXUej6IFCvtLSXW6/M7Coj3XuVs7E4lgM2yQ8HULIgaJPmtpafq+bH6VHKT8KNuZ1HCjcknTE+etr2TptGamjcZr0qAYQ8tB67LnSRZBW2tTO9lYjw6ndRWzpXVkhRSv3Yv4qwJmkN1esVQHm2LaGiyYrK/uv8ldxNZaA82WmNXBCiUgKIUIFByxBXrdcnBVKczGQftrWSV8S9U3kk/LblIGrdOySqrzlIclr+lsL8hSloQ5CrYzxHaWsADHFc3hVBvDlZzIvO57uObM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR09MB8755.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8yE48vODSFxzZhT0BxzGJzfhE8GaUHL+SRbolRQnjYpJbk4PsjVERHYtIV?=
 =?iso-8859-1?Q?/tkku88tEGQRYZObCw38p6Uxi980xTZ4RxAKGZUEaOlh3YynqwmnT68Hfs?=
 =?iso-8859-1?Q?IEFSa7Fg5aSwUS39SKxYO9ExIM1+MG6wRXyXL9+vRKDUg5cGTefseP3QWG?=
 =?iso-8859-1?Q?PGr7OYkMLcVCGnLnZCWeYh6h3T5E6yXoQmgfiCn0lx77ZsdsjTaJCmi+BF?=
 =?iso-8859-1?Q?ImSnV+L4SFiYTmQ8wCx4rzxR3TvOZ8s6WL2HQGqZtRpuU5J4NJgsf1SqM5?=
 =?iso-8859-1?Q?XMjyimKsDcDQ3CssC01P/UanAKCBqGuLM5NjKcb92FGmQkWsyq6q0M/GKf?=
 =?iso-8859-1?Q?0iKwmrnRPCOrZfgylJ9Rb4YNk5v5+oQXCu30AFPb25zbx4ALd9YUpBPSs3?=
 =?iso-8859-1?Q?BBawUqC7AE7aO4/nQBtopxi0iFbnz1prHfoXG3SDYyFDZxXnoq/ABVITpM?=
 =?iso-8859-1?Q?jJjs/YfOGzBcyBK9Zvc0vQhsFWDq29GRi9W5wfqT8+Bo9tA0W5LF/x8gkl?=
 =?iso-8859-1?Q?Hb03dKM9ZkBl52dCgu6xjLDBLhcOWkXGSJAKVoJlf+yXsI9YkEg8bYx6HP?=
 =?iso-8859-1?Q?xUejGHo56JMnJ7mzroi6Ku2x4yZubcj5Xi2W+BdqwD5NaC67tQuqo+P42F?=
 =?iso-8859-1?Q?oBYDfEg48/W2JPYevyye7LmQk7pdXLWGbwstRtZWlrRSxOK07ddAVyx/O1?=
 =?iso-8859-1?Q?KABmWx5XNbL2bZ0fqlyrI0YXIw+y/QXx3rf66++S6tuAe5CTrZdNqlcnnU?=
 =?iso-8859-1?Q?YJAB9c9vB/IBXjKxLgYBuzkC4lfaV4IjTisdjsjL4+bPVcZN1y53xZvWyY?=
 =?iso-8859-1?Q?Fjj3r5vFihAAtKVYA6hlqXa/gNVepzZf9iSY/yTbKo3jYXbLERoYA9fqA5?=
 =?iso-8859-1?Q?EBMb5F3DWquoHnK42NUKJ++WAEZ9yEUHvv9L5mWksf0J2qG0636WbWn9Ia?=
 =?iso-8859-1?Q?zt/iB9DX5ddU9CG1j7/noi4dK6IfyFkloDh4d23g+qcX6ScmBGklqLYh5D?=
 =?iso-8859-1?Q?OtVQuAq5x0RaKJmB+CnfqSlwNsFQh+S1MuLepGjR52jJOgXJCXMtHjEYfp?=
 =?iso-8859-1?Q?YFTcD6ha+HOnBbu582ZwPKuZYSa6+uXp/pmkg4JSUgq2ik0IybqPoOUgbB?=
 =?iso-8859-1?Q?OiPIFQrN3kHfYu1qMftZ5vfZGWri5LNGCMY4bmNfsSI1qiMHEY4vNeLES/?=
 =?iso-8859-1?Q?qZa/fhNfar3EJePDacIkan1ygXzqgCVz9Wlq9lfzY0q6aYmJx1naOUqQkI?=
 =?iso-8859-1?Q?6+KRx/eaKgYPYimMV/iUDBR8wRNXSx/m4l866Bq98q/px38jiha6UlnOw7?=
 =?iso-8859-1?Q?DNbCOyP8z+hLLW+cPnQqWhJ+ZYRa/tVLK6+TdT0hVhcHVB3iYirBGcjmMQ?=
 =?iso-8859-1?Q?jfrkjtF2OlNxVpdq6bD1pDyjYjOzhdpNC/ILIHT1H1nqJxtsC0ehsUGnOW?=
 =?iso-8859-1?Q?JCTdYbBovR91f3vQ/46OsAie3GmTtEneW8sAlCAvy/O22vn3gVA8zA3au9?=
 =?iso-8859-1?Q?xmL0RGRuARoHb9kzvXncWsNL7Tb43rKsg5tuVGpQ8aBx8oewEpXr/KWl98?=
 =?iso-8859-1?Q?eo6D6v4zJAM2h/JhC6OAOJiEv1cSsu5LuNjF4UscC5LwaW31/J/FXoAe6r?=
 =?iso-8859-1?Q?zCghAPEEkN4gyGGEHFv6rVJoW5Aq9Ud0Y8YM9xEY8B/xeWkUsEX185QMrN?=
 =?iso-8859-1?Q?WXJQlCDBKQOlVL6Jn+Ky+NwBTQY2e2hzksXqcKH9yXYClaYEbSX+Tm0KJt?=
 =?iso-8859-1?Q?+yPKkV8MHebnFW5bl9W3OT7qDsO+ID62LpAACQrDZzGHFg5PclCP4AY/yu?=
 =?iso-8859-1?Q?2hSHHX91Oqd1O19Iv33Ka+h9QIrn6CQtjLofFuNPDwT+3BCSLJ+1?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR09MB8755.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eb89fe0-3e05-462a-3dad-08de745781ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 10:20:29.9886 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4xATsCAZJceZdHB6RzL1Mh3XNJtwyM5hkSxILCpo0+xfuu0GQO3QaRKz3/IUSJLC087KNdP4bJ9TYSTjxRy4+A07h8HcoTpkAA6OzhZg9vU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR09MB6845
Received-SPF: pass client-ip=2a01:111:f403:c207::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
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

From: djtodoro <djordje.todorovic@htecgroup.com>

---
 qapi/machine.json | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 907cb25f75..b62b8a1896 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -38,7 +38,8 @@
   'data' : [ 'aarch64', 'alpha', 'arm', 'avr', 'hppa', 'i386',
              'loongarch64', 'm68k', 'microblaze', 'microblazeel', 'mips', =
'mips64',
              'mips64el', 'mipsel', 'or1k', 'ppc',
-             'ppc64', 'riscv32', 'riscv64', 'rx', 's390x', 'sh4',
+             'ppc64', 'riscv32', 'riscv32be', 'riscv64', 'riscv64be',
+             'rx', 's390x', 'sh4',
              'sh4eb', 'sparc', 'sparc64', 'tricore',
              'x86_64', 'xtensa', 'xtensaeb' ] }
=20
--=20
2.34.1

