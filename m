Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D82FBC83F22
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 09:53:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucLFv-0002kh-Aa; Thu, 17 Jul 2025 05:50:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ucL4y-0006UN-FT; Thu, 17 Jul 2025 05:39:05 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ucL4w-0002PD-Tg; Thu, 17 Jul 2025 05:39:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DzQ9NZGTklomZ6frcHeqIrfSX6VxHZcSqShtvIwmDZr4ZwT6HNbslI6XB3reVEG6qxrXRv5A9x1YuMakzWMGTPx2em3nSZ8cZ6u8JE0TJdQqN8hZqjHrPUVOAaVwmQczxXUhj9fkunGAPuXsoo84zR5BUtQ7/ZxmUzHw4fGmo+2YKJtOZLTYDvyLLAnuXEBIzmYD5Y+oQAqZ0J+Wzp6A+5MLwZHw4FBDEwa97lu3XnKx9s7qqh76gHOhlETIUiCQcEAgQbUKltC8Y0YeqUzmwPoxFofIPA3mWhoSJc+Bot3gmJlwqMWxYCTWiXtE85seiPs5XnqBgGpocMNV+nTb7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FkophoQVRUe/YsDowUs/IlXmuFawOCRlr871HEoTkmI=;
 b=cuTq2GPqCC0HzDOj5H6Oln7ZDcMXDPBj7YyEyBY3mNgeqq9/Qt3SqESzqggyaoXgf6+ibxpexwj4+pILDYdTt6+YE95YCu1ef4vWHdA9fav5ntkMYpb9btpDF1KED9MOCz+XumdXbSQqGmiv0TJ5dYSpgiCeYTFp4cGfdR4RBTwinUIUIFnpuNVmRTLgo0s0AoQ2/WMmnNLpknMm5tB1xRGYUZWm9FC/TGvLyDL176smUIzC0RlCtrmJbGCW+xSKTvqEDSjVBZ/TZkNnuBXT8DO5yDbMQtoYHJWOZfzD/8ZsFDGmcJf5Omz8thLeRj5QizhlH8ouyP+1GzVaDuZWFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FkophoQVRUe/YsDowUs/IlXmuFawOCRlr871HEoTkmI=;
 b=SaQr6GuJmdvBhuYT/svJ9a0+9s+TqH/0z5cPjpFYcK5Co8TYlREnKCSpwzzQx4leklUHjBbuUXJGH2KrC1/1PQwQ2Z3rIhb4zb4HH1DWEEgqfGDJ0sl+ktVhQ+e/mmwQF1mgIdEyFnw7HtjBOiKkqXTVEAT+KUxQaEeIwtC8GEQ3eL8IpsFEhdWgMvwtVynXZtQ5ThgZlP4QchoHTOZZ78+7ko4/aKXW/sD6bWxIsaHj0tGMkdpfdzSA94D81WcS7AWGy9HWDKPLrBCMTy+SS/zYUQKjUHUXpng3ohwNOkHsR1S1T0FTgeTpPluY1LVjcWfPR89yzyxLU251b5kisg==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by VI1PR09MB4318.eurprd09.prod.outlook.com (2603:10a6:800:155::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 09:38:49 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%3]) with mapi id 15.20.8857.026; Thu, 17 Jul 2025
 09:38:49 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v6 12/14] hw/pci: Allow explicit function numbers in pci
Thread-Topic: [PATCH v6 12/14] hw/pci: Allow explicit function numbers in pci
Thread-Index: AQHb9v6XjEBVch1nWE+Q3So8hAVSfw==
Date: Thu, 17 Jul 2025 09:38:46 +0000
Message-ID: <20250717093833.402237-13-djordje.todorovic@htecgroup.com>
References: <20250717093833.402237-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250717093833.402237-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|VI1PR09MB4318:EE_
x-ms-office365-filtering-correlation-id: e53d52eb-5dbe-4a01-20e3-08ddc515bc2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?O3oijsI/swCziKd9fcezq38BKFNtcpyMx21fsM7p5t8fBPR06M2NICEi8C?=
 =?iso-8859-1?Q?qHNWW0Q3+t0Cl2LWVLBAVAO8ZDZNu3wtWV6CqEuRRAd4VQb8OkNU5S2JZe?=
 =?iso-8859-1?Q?/SUWWil5OSUyG8idhW5Aj2ABgKADhUcHJXehfM7Bk7shl/w9GizSovVUCN?=
 =?iso-8859-1?Q?2tvCYhN3oR1gSTGo71Bde8N/s655tc3XmUkCZL+/T1fckXKDBw8L83BqSN?=
 =?iso-8859-1?Q?3D8QgpMzCrJmBl0G72jibJfHPoeQmV3d7OU/p8pmxscOHO1i3Rf/nh9A++?=
 =?iso-8859-1?Q?s6Dgl2Qbm6UMQhK7KNlaNuPCg0bu8eBB7NaPoVAmwm1B8P2HxNpk5Rvufe?=
 =?iso-8859-1?Q?fOqwfpgnZV3Pd6jcJXTOJ+3sTuTBpzIoQ+NRG2dlFs7hppap8QDcKjZOXr?=
 =?iso-8859-1?Q?k8ReKD1hJWKuZF9RVMbxzsatv1ebKNtOWZZbceWumzlvn+mHJHi81s4wSG?=
 =?iso-8859-1?Q?Ex3hRAn3P68hB34Lnveq6bPD2cPL9LP+5/QhZ3vg9/5ld9gVzMil6CftO7?=
 =?iso-8859-1?Q?2/XKWW+KQ9+hWtUiQ+MyjYLekDMiTSnDWlnz+wPnQ7fYaJrqsdwRZ/Pez2?=
 =?iso-8859-1?Q?PmcWWmzGJYO/9w/+Kjl8dUyWderQw1fXIwrJheVnbQaLrpQFx0bvzdKZik?=
 =?iso-8859-1?Q?bYC8BiFJX0LtXSnW6HoTL/aitdxjqp9SPgfWQziKY2D945ZYQ6HqYWTUp5?=
 =?iso-8859-1?Q?FKLZfuIF8YSrVAFuwpOu9SQv6AHUYYxfYxIjky2Z2ORJkRszbeLw96KMah?=
 =?iso-8859-1?Q?LJ5kT8IE6NmQExUx+I/1d7u1ejoUAIxNJBd86h0R1/xTd7g1tYCIjE8wyI?=
 =?iso-8859-1?Q?6Dim0kd/oATHglWH6KnpuhbltNoBzIyfdLMbg/tZ2m3fdS3I9iQJgLGMFO?=
 =?iso-8859-1?Q?P6XyDkmqWwLSBjKRtcB6wx9jk0DMsbz6LNKZF8zjdX/5qyWSGzUo6gubZp?=
 =?iso-8859-1?Q?7gZKHWmcOnrtFDkS0CB/WGhKS+5UM98a6uRNmEF/cUMtP69kdDz9RoeMGN?=
 =?iso-8859-1?Q?BOTtVEW7j9VA1PAC4iHSqx3vodLiE/f3l3durZFh2rBrrnCCWs1Tpc09oV?=
 =?iso-8859-1?Q?uwshnJcJB4x4ejeOpEHua5i7xCh5tlLsCg1iUnZbrB2E67/+Up1ylf450x?=
 =?iso-8859-1?Q?LcFcgFR6n8se/MVwgHAH9jCbvFpf3LFzdhF6ucjG8CHaQK8gHJ98tMucZE?=
 =?iso-8859-1?Q?QvQnEuoFOpapp+qG2VBBCDUbFQ/wMQmeCDe2Fc1pdky6fnqg0v0ygfRLgT?=
 =?iso-8859-1?Q?yIuB7/BycIuDPnMjcosdkLURvEmfdeF2iS4R0HE2vn2hZZgP2vYymm1Nqq?=
 =?iso-8859-1?Q?2RTbGyVe77Drv2H3Se1QOzadZ5U+Yud3tGWiWLf+EUoSnFizTUo8J4Pahm?=
 =?iso-8859-1?Q?20/X8OF8K0OfPGY+Yk5t4vX5slqbDVguobzdazf/Usn84V9bSRCZTy3KG7?=
 =?iso-8859-1?Q?WlmI/N9AqqVumAQLlTjfdee4IbqOtiovuPdCp/2jOKeBdUQqeRRf+E3vpM?=
 =?iso-8859-1?Q?yQgXYAHbz8PHJLcL3tI3gIMOH01lOXKyummQ4MwBcdhQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?HHpcOLx3YdktqtLJ+6Iyap4srWFdlnNmwcH4Aw0PS9tGkYt8E0naEMiC5P?=
 =?iso-8859-1?Q?niwI5OHkG/AgFtNcFbCdYPogDkWiqjHwhcNuky9bmoutb3m8c44/aBUSb4?=
 =?iso-8859-1?Q?FIiV+nHvLv5vcJNuwrr9zcr6Ubq/ulycSEY8tkV8GuHAgchlq5qrPGXwuM?=
 =?iso-8859-1?Q?aiL2JWBRmmymhAUGgQtWbhdQRRJOsZQ8kdyYYpi0uRhX82g/kS4YUBXxxm?=
 =?iso-8859-1?Q?Sjb3GMrxRumiK72h875g/RtODyF9Y6cePd/WAgLoRdI6cE5SJMJghZrTMA?=
 =?iso-8859-1?Q?tdU0bfz1etss0b3M75Hz/x+h3ZuYeQ6BQ/m8w8Wr3fSPxC/x97kOxMvUzr?=
 =?iso-8859-1?Q?ocpt8WdO6hlFK/K+qrwMRWuxyt2+bMEkKjGaRE1AxPa1qM/A9NIVsViL3t?=
 =?iso-8859-1?Q?IUzU+K31oV2rRrPCXNu+fczbiEfiUf43licjq3qWpJyu/JlHnnumVrKMHQ?=
 =?iso-8859-1?Q?ENhpbiQ0Ad/gs0LovodH4HWbYDqJb1h7HKbhI5oT9Ri5hzt98K018QSXw2?=
 =?iso-8859-1?Q?syofg0DCcU/9LSRJpxSO9ElVTY5swALT4fPXX5Qql4uHk0+u8r8CXLinMU?=
 =?iso-8859-1?Q?m5+logneIgnoHz22RhoNDlEauxc3Eif7wKwHyPfPFFiEHbuUfxOoYo98hl?=
 =?iso-8859-1?Q?vN2iZWYYbCYykmC7GvxhKf7yBm7A/PH7Tjpp41Rcrm5e8aHPW31DTpIiue?=
 =?iso-8859-1?Q?HpyTZilMvsE2jZM4EBUPcSySBgsvXch0Rocw5zmt52LztkRf/Sej2+McCh?=
 =?iso-8859-1?Q?QJFAtraSe87FyXAHs+5vAuQ5A7TWCRhii+tpPvYa6ADH4qCy2zoWeVZT70?=
 =?iso-8859-1?Q?h8OUBXX9XvGOIjuk6l69NljFkku37nCm64yNCHDXCGPHNOazgrxeTajliz?=
 =?iso-8859-1?Q?KU+HijsHW3EouT/SB6B6JbNOxJdz0CMJJUPMubZqcsXZE1LBFd8A7rI/eq?=
 =?iso-8859-1?Q?FrjMwKCvTi4tD0tuD3YFq2k/rZ4aBOrw7LUmbXSSyCmtBjaORqmuIjRLvP?=
 =?iso-8859-1?Q?k7o57s47AFm2G1HOBMBlGdIc+pwqhaE+nxOU+SFVtyyan1QWkbBwciXm5R?=
 =?iso-8859-1?Q?csgzwPnUEsI9pb0LaAhr5TMMde9KItmtldJrlmeJOFckzR8JwE6H+isMCl?=
 =?iso-8859-1?Q?BmSQBSCoUSg+kkOHZys03VpxuMhZsR4CSpu4AciLVFHB6gRf/HxExIctDe?=
 =?iso-8859-1?Q?pLxl55ZaJ5Qt6NRX5vGhN4EVGnTbXvgYJAg23nn2kjT0BlZT6EukrvaAqk?=
 =?iso-8859-1?Q?d0qQjDjfFOdpVNBts1V0HgAOSP2qsKtwCQLYchtn+dTRFaRKBXr/XKEyBo?=
 =?iso-8859-1?Q?5r+veoJ0FIShWQUXp4Q1+gF1wiOS/9MLrGT6fwlWYXnRefIkJYGHjHJZEi?=
 =?iso-8859-1?Q?BI9Dviswl/Tq7pc8FKW7YQamS0JflqNK4oEeEF/qWgQikWgKGKq+ELqJRh?=
 =?iso-8859-1?Q?qs2JqwShbgPnaQaHEc0GUZ9JWhGVWDy3TI0WVLsFbZkh2NCq8XRG9vCwnO?=
 =?iso-8859-1?Q?bDpsrGxAOV5zqIA/fhuCfyl+1BSOXZ15bqVvqTo/W2lgMfmkMSp7vyIFmg?=
 =?iso-8859-1?Q?xs65UWwFVb0StTCNTs2LBtWdGZI8rUSolS2GpQxh7RUXTeIYIZ5IHR9mDo?=
 =?iso-8859-1?Q?Jx32Vv+NfyK+1Ye+XRtFktjf2S0lBGbow/r8xctvXBBMEsxOrSHpLIMvKf?=
 =?iso-8859-1?Q?fV4DTWsT3uayFRPjIMQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e53d52eb-5dbe-4a01-20e3-08ddc515bc2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 09:38:46.3123 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sBdMYTI3JghJ9h5CjkE4uPvIg/fqsxYViXsRcSMQZgDVcw3MqGjrxGiF+zdofSpoTSxQFLWIMlJQz1n3U6qy/qx9yAoLtsLwlIDRiWupa7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR09MB4318
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
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

Since there is no pch_gbe emulation, we could be using func other
than 0 when adding new devices to specific boards.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 hw/pci/pci.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index f5ab510697..23f7f02837 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -974,14 +974,15 @@ static int pci_parse_devaddr(const char *addr, int *d=
omp, int *busp,
=20
     slot =3D val;
=20
-    if (funcp !=3D NULL) {
-        if (*e !=3D '.')
+    if (funcp !=3D NULL && *e !=3D 0) {
+        if (*e !=3D '.') {
             return -1;
-
+        }
         p =3D e + 1;
         val =3D strtoul(p, &e, 16);
-        if (e =3D=3D p)
+        if (e =3D=3D p) {
             return -1;
+        }
=20
         func =3D val;
     }
@@ -2045,13 +2046,15 @@ bool pci_init_nic_in_slot(PCIBus *rootbus, const ch=
ar *model,
     int dom, busnr, devfn;
     PCIDevice *pci_dev;
     unsigned slot;
+
     PCIBus *bus;
=20
     if (!nd) {
         return false;
     }
=20
-    if (!devaddr || pci_parse_devaddr(devaddr, &dom, &busnr, &slot, NULL) =
< 0) {
+    unsigned func;
+    if (!devaddr || pci_parse_devaddr(devaddr, &dom, &busnr, &slot, &func)=
 < 0) {
         error_report("Invalid PCI device address %s for device %s",
                      devaddr, model);
         exit(1);
@@ -2062,7 +2065,7 @@ bool pci_init_nic_in_slot(PCIBus *rootbus, const char=
 *model,
         exit(1);
     }
=20
-    devfn =3D PCI_DEVFN(slot, 0);
+    devfn =3D PCI_DEVFN(slot, func);
=20
     bus =3D pci_find_bus_nr(rootbus, busnr);
     if (!bus) {
--=20
2.34.1

