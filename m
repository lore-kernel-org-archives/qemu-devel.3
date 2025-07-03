Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13692C83F04
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 10:51:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHVm-0002qC-Gh; Thu, 03 Jul 2025 06:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uXHVj-0002op-TZ; Thu, 03 Jul 2025 06:49:48 -0400
Received: from mail-westeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c201::5] helo=AS8PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uXHVi-00077q-2K; Thu, 03 Jul 2025 06:49:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J4GVkKcP+Ek/LyyOWoCpoNDbZCg8DiWhujP8XVJsGpGQGP9H4C5rBnhcJtSdJKJQqWF8xG3P2s2GS1zyXrCE68lF0V0J2Ye+gCzzYogDA396dD+8yEU9XrEgMo5Zhdz/mXKcnZCAF8cslQng0abfTIxPlMceYvQmOHL0ZCIOLTyJG5cuJ5qofxgZOuNhWoC4WKd/9K4I6mG5W8b0LzmBNaRgMLzNmK+4Ea0NgKcpw9cA7nX70Mz048pq7oc1iGk/mu7LisxtWWFITJejP7PdHwzJqF8XjoekQF4e2HIFthN/vira3IdFrnEnwePtkd76yHICNnGY5A7UEf5haBRZJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PrmPUNiYpxLANPjmk3lme2Cm3Q0rIJtRBV5hlRQ8/ic=;
 b=C6zuVH9rzB7bR25l+lRT9pDPJ/JFMxO95rtA2qCyrJnyYenrPcyRHEs5j5i9nCuYJvSf5IPf6BCoozhO3zZ9WoL57+NGiKfMcWoieH2V26ySiNASghRBjvHeY/IzlbcuwJCc4WX5tUAUK833Xzb+gXD3LuWduvcOnCfI8lE1LwNcygufRrZgm9DcMs76Q3dqEm3PhZFXRDjH/9aBooYS1/E61wA3eYs8itIvD+dgMMsk3xkY1e6CGnLkMKRa6rmwnMmHpt6FFP4UUgAOxaioFvQJc6+yMRGo8JBgjGfnG459pN+QGtB1K47AwWKn7bPLwdtYIIn1H2hvnC1EGNXdyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PrmPUNiYpxLANPjmk3lme2Cm3Q0rIJtRBV5hlRQ8/ic=;
 b=VNXlRvCitWrqNwt8TNCobYrrHayTDTvpldViyi0q2b7WMT3fmOWorv6HrrBvaInkcxioVV4TWGdKBJIDFSOTY70n3yfSGmL7UTW4yfrlyKsEb7ywA3PZ91KnDk7ydxLINE04/B8FyCEy/iwf84ZCtMC4jvesqU6DTFRd9RdWFeRrjrdvtRTmBz5bdgMelr+4wRgB8glDsQPLB16QOySS5dlwA5hzw1hZs/ebyMvcUHlV2GGCmnKzjB7XtFS3xDYJi7w0O2RA1Pnyf4eABhwNG3gh9GqS8JK1JEiIQPtmnRQQdhF0NW4GcI3zTUzqa1zNRVLa8Fud8sI1EWEPqHuZSQ==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by GVXPR09MB7293.eurprd09.prod.outlook.com (2603:10a6:150:1bc::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Thu, 3 Jul
 2025 10:49:39 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%3]) with mapi id 15.20.8857.026; Thu, 3 Jul 2025
 10:49:38 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v5 11/11] riscv/boston-aia: Add an e1000e NIC in slot 0 func 1
Thread-Topic: [PATCH v5 11/11] riscv/boston-aia: Add an e1000e NIC in slot 0
 func 1
Thread-Index: AQHb7AgqucPYh1/8WkOgMJd/6NIsfA==
Date: Thu, 3 Jul 2025 10:49:34 +0000
Message-ID: <20250703104925.112688-12-djordje.todorovic@htecgroup.com>
References: <20250703104925.112688-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250703104925.112688-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|GVXPR09MB7293:EE_
x-ms-office365-filtering-correlation-id: 02389fd3-a440-48b4-2d0e-08ddba1f4f08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?L+VZ6eEMDiEtB87vUVnbjDvPMhThpeeR9CdZQ4JjjcK4CrIQRQzNB6hYAc?=
 =?iso-8859-1?Q?4Z9KNV846S/Ic6WbyQBir5A8dtztnvQhQjWGIcQ62U6etT8lqOr3E86mBL?=
 =?iso-8859-1?Q?Ki8C2X/LpDahCXe3OCrEV9UUgOoQTJJCidcYv0CbFAhHbnhHa+wO4P+cTu?=
 =?iso-8859-1?Q?EI0HU8tJ3biE58NIOw+7Qvz9JdBwVZFbEAy41l+WSM51ICPsyu+61gjroO?=
 =?iso-8859-1?Q?nVDZ/k6tiZZfyqzOkIXKJrcbAhXeCClkwGwxWjAwVw1sckYoUbyguyfyIT?=
 =?iso-8859-1?Q?yf9OEUiim4LvMYGcesdTxjHdtexvwzpPgo40Tr1jzS91ZSlgD2mAIjlcVi?=
 =?iso-8859-1?Q?7f2Vts9GLYboNFNiVRX0KjWRgGW/Mw2GW9I6eLbirf7AsJ87UPyvPNEI7R?=
 =?iso-8859-1?Q?T0KhJzJFW/w2deAXwsT0d2bqotYYkXuPKk7ooXgalW1uVySmf+Ei1McprD?=
 =?iso-8859-1?Q?gbNEihVCFmPRCGlYqCfQrpd+UDqCXos6aqDgsz7wu3LLIa8suzY6Ium/jf?=
 =?iso-8859-1?Q?iHx56aGOSz0BksXw0VRrOtDdL52MFXvBYOUmL34TpzJvKmsanh52QonXWS?=
 =?iso-8859-1?Q?jceA0pX06QXB0AUKDpuWtxvEMWmZQhDYpwgM60E2aID86w6TKCS7dB4OhC?=
 =?iso-8859-1?Q?YJaEj/T9gll30LEZQMn+ciMqXfpe2FAVVSzuYQzAWi9MOi9Gj1zXCELrMl?=
 =?iso-8859-1?Q?YoSb1WjwmyFOIyCnBVSg8Ed/vdRX1fjR/0btnhCqJBVyxsvFk6M+OA/XOY?=
 =?iso-8859-1?Q?sPfgARbSqKAP8DD6gAUtr+49M5583OI/5kSO8kwattp2orz85SKDQD5zKX?=
 =?iso-8859-1?Q?l67qjyIrLkvzF3C+Ms+w5m9gBVFsz3waFwRu1BW5xA54M1w6zaRAXG1WgF?=
 =?iso-8859-1?Q?YjxDCa6XKmI2mLVRYzoYAPo1vm8yoAu/olSC+ASl68bfzpgl448FZVzT2i?=
 =?iso-8859-1?Q?eN2GYb4joaSGpQuiAOx6LW1aBWR2TRtOGXf2/I5q51UFcdvpL3AIpp5B1I?=
 =?iso-8859-1?Q?FXSqVfZ9QGv2AEUdIAR9lBgd2T7nITCGR9dUyj1jVgAD5pAnTyDjhgbFyx?=
 =?iso-8859-1?Q?WoGl3ANJE0hK4KGkTdGmS06uDbo6yedbpll9wHdtImHZkX+OPsBYFZwx4M?=
 =?iso-8859-1?Q?cYEiZzUL0F3nRa6Rjvj1EpJx5WMuLjMZ5qnUHiD2EisQguAgEjW+0omc9t?=
 =?iso-8859-1?Q?MNLzOTtR5y3A3A4EOX8a2Z6thhioKiViF1uj75Uq8lhI3eKeVuTdJcc58d?=
 =?iso-8859-1?Q?kYQBhqgOzy2G2MkQw17YKXdlgo2U1l4X1Y0b29zEpnVSnyELUBdBVfIlRE?=
 =?iso-8859-1?Q?ZgcnlgZLgUl6NOww9rXdo7Wdwvm6aUEMREQLqMvdsxUW2doOD8PvS4wX68?=
 =?iso-8859-1?Q?gvPRzpVbXoMISVPZi4to010cEvCxZIRETqUEZldtecu6brH61lkit3pZTM?=
 =?iso-8859-1?Q?UF58C6LQ2kpP7XK/Xb/inmxKx14LI121ECE42zkA5CYuNQpzTaVUpIaEaM?=
 =?iso-8859-1?Q?P+xFyPDx0MirSLy+0YscwOvj4IC5BzI5XMYy0ALXa6Ew=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?c4qRTWGJMvwzu41BPwI26I97cFhtmg/jIlfyWzhIwoH43aLqYLdAwBkCDt?=
 =?iso-8859-1?Q?Y6RLrb5H3xsHY72UCnp+2Iyx3J+aY3aZoUvdXJm5fnovHTPjXWJ2K+vkWn?=
 =?iso-8859-1?Q?U7xAtMIHcTzm89+lmsst3f9Dhvlql068htTC+L/fuzJyLEr6nQDFU2Eev5?=
 =?iso-8859-1?Q?mB+CvLdvk9LIYGdYWjfgOgOWv/CyBHiSGRJypetKjt5es+P4L2w6Hk9fGQ?=
 =?iso-8859-1?Q?Ro6+D/kzfoOKj4OD5FfXXVdHtpDezFW4PP1aieMDOUPwPq0VziekXxST/s?=
 =?iso-8859-1?Q?O41In99hGkB26kaZgud+PENGQ76MCBYEafu7oLNGtqjimZIxs4E0gxODKS?=
 =?iso-8859-1?Q?ND7VBhDnsC/0zeXVFHEDYlpAPbweRjCFYDwwJY2xI7iWavOw2XIeNW6372?=
 =?iso-8859-1?Q?hjQEvGXf/CFZMHfO0IfkzR7Ka+czUcfee+4IKEhM2CkgInnTBemuN0gVkk?=
 =?iso-8859-1?Q?7bwZAKN1N86fFrCai+FT062I9D45Zd5R1KvQKOc4Lj/SR1p4RC2cSf+yId?=
 =?iso-8859-1?Q?ubnzrh0WCi4dlsgYGJ+axFDUmcy0soywuXq/rjP6AVjlaG/EFtpjLC+Jds?=
 =?iso-8859-1?Q?xmXaJ0Zc2mbE2GB7h2s9xPMTmu163xI5ejM2GHMrwsmPrfj6yg5W6y7ggP?=
 =?iso-8859-1?Q?Upep24U2n56FUGV7k6mkLA8uHpKxUftPhCvnJWmiZ4Z8pWR87H028GqiFn?=
 =?iso-8859-1?Q?H6/E3HbUqg6cLh4po3qX/1V9zt48MQL7dZ2NSPzwuodzcuODZ63eqofzny?=
 =?iso-8859-1?Q?P6rFkA71PtY00DH2Qplx4aGzXJXkWuEWQwAcVl81/RmagRw6CotB9LHUBt?=
 =?iso-8859-1?Q?CAOL6JVneyiHemVBRKvIs7oCkc7juBffSzmBotTTfZqaOiMxtFL8atc2EH?=
 =?iso-8859-1?Q?xXuGqa+bUIF2RPemDlhvNCRlXKWnKRzSk0Nj0UGYa474Dc3eshAQc5bGw9?=
 =?iso-8859-1?Q?2SnoPx46y8pJvJf8QBqleyt0qNUalfLpsOAP3mRk+THEKEHH7rQl3zXo9m?=
 =?iso-8859-1?Q?mbY5vDO7LYAynKtOl1PABOKazNXGJVhQdsQwCfy9x5CGyHl1+puZNPZpry?=
 =?iso-8859-1?Q?hFQN/jT0Bq4qvkr92jYEpH992vjTrg7ghKmPuy+tMVmhZ6WKaCTG/rzPPa?=
 =?iso-8859-1?Q?Oqq2ROxiERq+ekK4UlUdapNUrJ8A2LF5x/K9jlsGVTIU3VxTAGOwVuJN8M?=
 =?iso-8859-1?Q?ysps5ZGGDTGDPjN0jAHjz529fairX1CRpJSJlz7L55w7tmipfZUGtALap9?=
 =?iso-8859-1?Q?qzTZYimSUpud9aY8zeWOxWz523RC050j9vflegSKJlUuWNgghK+ff9n7eV?=
 =?iso-8859-1?Q?6nBOb5q69zi5SBARBTfxdyhk58B/80MUZyjRWJfPObOYQTY9qoU5Rn6Oyh?=
 =?iso-8859-1?Q?0rri4ZlTwlpqJbw1npx4Gzw80j8EWmoUnSTipVBEB0NK5KxZ11pLNsMvPN?=
 =?iso-8859-1?Q?oxCV5jVmnKpB97lohpaX06ft86ViwX/CGw1xbdlzMkuLi3/tS5Qn8wtc9x?=
 =?iso-8859-1?Q?ljoGjOABUyfkdeeJCebCB+l1se13S2kIv8hXSiMzjtiShK83Lk2mxeNds8?=
 =?iso-8859-1?Q?z9VnwltmrsXEq4fa8AcUvQlS50VIY/JhJscN2jDGYhVYplAClXG5n1XGm6?=
 =?iso-8859-1?Q?iNdSMRRP2oHgW4MrPA9w0UFxmSNXlsRnbbNzbMeznL+27c/Xzd3s6xQPVK?=
 =?iso-8859-1?Q?y/mAiwhRg/3YmIz4G9w=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02389fd3-a440-48b4-2d0e-08ddba1f4f08
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2025 10:49:34.8936 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vU1Kt3Qfvhm9QwVDXRLwzqhyB007cGddhZS1ssqAWdh3kqXYD6ku9b6F3EtcGdSG+T2y4mz72W+icB1+m+FNBn/t0aDTJpE5QHi8nALYtIM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR09MB7293
Received-SPF: pass client-ip=2a01:111:f403:c201::5;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AS8PR03CU001.outbound.protection.outlook.com
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

The Boston AIA board needs a basic GbE NIC.  There is no PCH GbE
device emulation, so use an `e1000e` instead.  We place it in
**slot 0, function 1** in order not to conflict with the existing
AHCI device in slot 0 func 0.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 hw/riscv/boston-aia.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/riscv/boston-aia.c b/hw/riscv/boston-aia.c
index 6ed5c636cc..34cc0abe79 100644
--- a/hw/riscv/boston-aia.c
+++ b/hw/riscv/boston-aia.c
@@ -437,6 +437,11 @@ static void boston_mach_init(MachineState *machine)
     ide_drive_get(hd, ich9->ahci.ports);
     ahci_ide_create_devs(&ich9->ahci, hd);
=20
+    /* Create e1000e using slot 0 func 1 */
+    pci_init_nic_in_slot(&PCI_BRIDGE(&pcie2->root)->sec_bus, "e1000e", NUL=
L,
+                         "00.1");
+    pci_init_nic_devices(&PCI_BRIDGE(&pcie2->root)->sec_bus, "e1000e");
+
     if (machine->firmware) {
         fw_size =3D load_image_targphys(machine->firmware,
                                       0x1fc00000, 4 * MiB);
--=20
2.34.1

