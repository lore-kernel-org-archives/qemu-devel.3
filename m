Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D567CCD193
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Oct 2025 15:48:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vA97y-0005DD-P3; Sat, 18 Oct 2025 11:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vA97u-0005A4-F4; Sat, 18 Oct 2025 11:45:50 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vA97s-0001Rh-T9; Sat, 18 Oct 2025 11:45:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KD2eOPkoign36/3vCZC8KyrQ1jmYdSIFf6k7fB5eTdl0krBY+1W5M9xi7GZiavNnb+7KWHr1v+0slO/64znFcFdQM50TjyT+ISAkFN9wAuv7OBfmUslgWOHN4DIhR7SiTxEf2UoGu1UKwQPUbSq53o+XhkqDGJcTQcExm6Uyr6Zwb2tTXngjwvqG3bIH3PTKy9Qd5lKE4NkCYaH+dXd1cyZPYQDKYceUJMTEE6oVaS7ovg1pbSZibF4aeIxFw6uEZQ2AQPNzq+wmDOcjkrEoagr3InN/JGBzxfU1zxGxM5E0RRog1EuCFK65r5GkM5SuXPptzMQ2kF0RiTQKzniK4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksIeetRZ3Mvf38H2ffdYm4vS0vWAgZzhy6QHP28h1lM=;
 b=jUmt0Yk6whXlV4W0gmO0VsrCZ04P02lo+lEgmISyA7hdoZGWbqii7IV8waSqZTlESZ+wlhmwCvB0E1QvUGrHFgQK0QX5JO49OMkV3HXEuNXHPuWhBLcnmKwjneSePGgqHeqE1J32lu+EcGXOCaV7os7T1B3yoYHGF+HVnt0/FdLKZNr4SKcyaCWk39sbrq47XBWN3csYAhsboU8pviyobSLYWGV/3aidXalB5j6QP4i4LUmjYJT78ou4FXUhRa9eskpRiS+7WGC9DIjFByG/4AjYlOtXrbtXpbj3k5lVGNOD7ZTNPJRb2Hpa/Iq6Jsd2rBhTgtZcOqPmELNPgoZ5lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksIeetRZ3Mvf38H2ffdYm4vS0vWAgZzhy6QHP28h1lM=;
 b=FSdtSzfWGMwNBJd3en0S5eksdt8DvGk/CYHl50sv4wXHg+9lUCHnT7M/CzatlzfThUrClBc8ENF+5PJ+DVFDOR2Y/jN1252lFtmbpDo2w99H/fN2qwie6IvZ9KCpozsuLRQLsoCbzMLg+xtypvqwSeTSoIL7TIsdoS7JuhrVW+nRtkneNpN9e5j9ixE8yxQuHXILDVOcld7Pkh+Ey7Tx3lAa5fo9q39Q5EXR8fco1+qNGZrK90EWZ/5zMxZxHmoAS9qg/u4TJMHkuDigDeoduLbBLsnh0I6NmD+5gh+nVwWjzpbwBSqE28xwyArmaRszmw+5DWdcGtvh9GFhtnSnEw==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by DB8PR09MB4360.eurprd09.prod.outlook.com (2603:10a6:10:154::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Sat, 18 Oct
 2025 15:45:32 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9228.014; Sat, 18 Oct 2025
 15:45:32 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v13 12/13] riscv/boston-aia: Add an e1000e NIC in slot 0 func 1
Thread-Topic: [PATCH v13 12/13] riscv/boston-aia: Add an e1000e NIC in slot 0
 func 1
Thread-Index: AQHcQEY8G4c5TM/3HEGZwwxEdS+26A==
Date: Sat, 18 Oct 2025 15:45:32 +0000
Message-ID: <20251018154522.745788-13-djordje.todorovic@htecgroup.com>
References: <20251018154522.745788-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251018154522.745788-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|DB8PR09MB4360:EE_
x-ms-office365-filtering-correlation-id: c744126e-77e6-49dd-29fc-08de0e5d5f0f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?0bWzMath0orH5jX4kDpv6gCkd0q64uTqUXCqBh7v/VeiqyzHiUL5akq55R?=
 =?iso-8859-1?Q?vPTmntuohdFGKufGX+SYeImy4qqsrNsNrdopmlCc5Re5lkkMEechJw4l+6?=
 =?iso-8859-1?Q?edEBc7/IDfosJOx+rUjoo7YQZz+vUww8dhvWo0WcSJTW4Bi07pvZFyyjhT?=
 =?iso-8859-1?Q?dGZZb3sFML2888dJMAzmgTHsoiglzwkoZiFm4+Tpd/7DLqnw03Lw6+2BYa?=
 =?iso-8859-1?Q?Pw1suKw/qmpb/b17+BFNOuDKI8hFgvPlcNnyEGuwJq9HvdzMPRy/ab7s76?=
 =?iso-8859-1?Q?2ZmSWfgJhRYAS4UDwG08WJAHmkOD7qRtNbmomh9uc6BY78IBlyhb+zH0T8?=
 =?iso-8859-1?Q?wqLQW3u3wsjDL4YEFMDycB8p+lT4VyGRp3oEwEQjBSjjIfQ86mt2uSmjul?=
 =?iso-8859-1?Q?/EpksUPa2YSj2kq6LJJJ6Uam39cQCdcNbcatztVK2Yv0gHURvL8cijX3cN?=
 =?iso-8859-1?Q?F474kx5c7OiynEa8TgyQPZECI3xEtLDCX1LUJ1713mzURWxbcJ5oYBs8Bq?=
 =?iso-8859-1?Q?dB3jbKpaWNnfx/FAyg8UKKMcmORqdMH4pEJFsNPSJKFjwQnymW3O1wtopT?=
 =?iso-8859-1?Q?tl2OsQsl69I9s9PIvoV0IA4S+HSzzoM2mg0Le8YAKq0ZuCDpL6Cu+hQj+d?=
 =?iso-8859-1?Q?MUHEZ7OuK12mVsipo4finzy5xnMwFnSc2L2LUsbEkHsQ4FmlhIudaxcdXc?=
 =?iso-8859-1?Q?baiy5ffkgsUjz46g0hKAYg6AkZ37M+npGzgihAhp5emg1FKn4dhYksanal?=
 =?iso-8859-1?Q?MGNy3WVkDFdUjDxqgLQQkUhhfDXyR7YoX8HtH0XLtCIcZ1p92Q/hNGlw0Y?=
 =?iso-8859-1?Q?Sn83YECowTdSIwpfC5Dm6rhT75BknDBjaoR7GFRBuVwUVoxhfuO+7tFO9C?=
 =?iso-8859-1?Q?SYNTIsa1Wb7aAsLDkIX2mrjWk+E5FJSHeCCtkG/RxL7IS9UPcaaDpX5xjg?=
 =?iso-8859-1?Q?lQKHS2+Z5fy9GOC1iCy9dFt1dwGBQlE+P4XxxV9nmMRYnBQxI0q8L++e+O?=
 =?iso-8859-1?Q?7nP899kmPn/bL1hDPABaNqyittakfO7X0s1H+HD77D7Pkd7vqY1yHi7ri8?=
 =?iso-8859-1?Q?QXWZ92gOIPTeOCbB/77dEasbl0sUzAy4CKk3O9IRygLDHzZrvYhv5NzwQY?=
 =?iso-8859-1?Q?k9KgcyUt6C85kHNPUzeden5XxEwQystLJzikQobM7JqIsThn8dKUJMpTnG?=
 =?iso-8859-1?Q?Ryi4SOlUqTAMo4Gj+fCcGN3HATFyIEGHufBCmxuMMDYSh7CJFmT8WsBm16?=
 =?iso-8859-1?Q?hN8XsZ7qHRCprMDpTwOIWVYdSM7qDoJvBRhfS66zwIU2vAgUCjaQWSFaSN?=
 =?iso-8859-1?Q?UuUKOGFg74BOJSnwZCjP1Sey1znQhiKYy0YXeL5+iriwBi2urxi2+O13FM?=
 =?iso-8859-1?Q?xMuKpbZ6osYtnxxPIjj+n065+EeJjE56jI1KUFmiem58l9u+P+Qg/heyPx?=
 =?iso-8859-1?Q?n4SNMzWruesNw9poRgNuC/YrkeAVnohUqVjR38XpGYlGcqht373j/y+7jK?=
 =?iso-8859-1?Q?BEtBYkHOpAv3OdLy5oYDGYJQSEWgEusaSTza/fzv8rFFQr99KoP1zrnmrx?=
 =?iso-8859-1?Q?gOJf5AuHcsQlYHMwMjyysh6wXUFX?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tBn/+QIrZwSOxj4E7fxiTKUhodWJTo/wLC8AxuiG2l3VDc37ZZiSjbiBIC?=
 =?iso-8859-1?Q?FoOHuyKkLJCzFOlbESWsWCBwnN8HOPjw7wQZcwOsCLhrXLB+jRXFGPsD+1?=
 =?iso-8859-1?Q?ZqN1LXs96HtFlOmzEVTps8RRwNSVBrKSDQFCAR99HsLNiumSg2iv3iDh8S?=
 =?iso-8859-1?Q?cRbPsp77ctteZZO2pTg2N/dqjkLwyzmFCHg0XbzmLOb0tE+3X8NwUvFdFy?=
 =?iso-8859-1?Q?jyCJ4e53IAQ8RVXS5Qq6Izvsulv+d3zUPuBUCNNGhsJxq1Gm9AdocJbIuX?=
 =?iso-8859-1?Q?eufStWHkNQeIRwlTOV7fZdCHkks9cfcFozeIW/rMbU75H+PraOdB29/Pay?=
 =?iso-8859-1?Q?SCeE4RCd0rXhw38070igB98IUuRSb19xndhwTaKdF82s5bfqPQSqoGD3Jz?=
 =?iso-8859-1?Q?Iz4/I9l8PUdMAkK1lYtXAMPSzef4AD9vKqK7UvtPKvpEPU/IIWlKfzkjBn?=
 =?iso-8859-1?Q?xJlvS4Hgh0Naw3VYk85TR/lGZCoVRDR4f4+az1kBSkTQMnlhWYJwrfJer0?=
 =?iso-8859-1?Q?XUfS6EdsdunY/qZHeISKD/BKmK4Xj8keyUOh2FqYQUMs04BZwnETYsSd2m?=
 =?iso-8859-1?Q?SaEOr9uOobnunzjeAbBsqNirBYsNg+RXGB1DFe/hlQJlAO+HfV6yWjIqkW?=
 =?iso-8859-1?Q?DmF0PTEpqjQG+mOjogXDRdOaYJC4cxR7urNH/tX3Oey8Pn4vOHqYXV5WTr?=
 =?iso-8859-1?Q?o7UYQBrrx67GvzvGsUAZUU2v8uS2/flXhQQwgsLbYNkNgqjt772kvXUoht?=
 =?iso-8859-1?Q?qZgE9Q+7PQMfepH8PpVaW4aEp8S9EUsuta2Zkk6YmZOGo/emuGOfcBaapB?=
 =?iso-8859-1?Q?8lLei+wgxMv5N7ylRPl+wctTQolN3ec9RawAgpcYdzl5Ch/ggFmaqMu+V9?=
 =?iso-8859-1?Q?mwpbQysOsbuVAO572OsJgkvUevyEcLtzKUD80a/dC9a39czjdGKlsFHolq?=
 =?iso-8859-1?Q?yK3nvIdRrvWDXKHQAf1d7c3RSVw4IC6orZWl1hSc/uAVUCNwAegLe3+AQF?=
 =?iso-8859-1?Q?db/ITi0Xpg5k9KqBCFwngEbqu9Y0FM9jBHLm87PS2rEnFWfF5OF//P79aG?=
 =?iso-8859-1?Q?m42IeqL9yqrVR8zRnUyjTQXmuNMIPdv6ws60ln8gVhnCsKxBkkqLGvYJkF?=
 =?iso-8859-1?Q?mDzhk+w/sTuw0/RRTorHhtmWCwcQUkO6vZeUGJ6CN7Ag4zIxQbGsGSy7FC?=
 =?iso-8859-1?Q?BaqUXRfqrSD3aXdqGHzEDEmgGdnfbxd+iNhMnIdjOL7fjfGRHT0Cr7UPPl?=
 =?iso-8859-1?Q?Jxw9DL/t1BoqXt+z83+AaboBOLnPcdTJGx0fGSmv2aN/rXUAU6E+s+30yb?=
 =?iso-8859-1?Q?IWTgbphaOa7WU4T1o7WcTkryBViHdaTS8GBXDOwFwRx48fKHatNetCg29O?=
 =?iso-8859-1?Q?xi7joUFkbEcFr9/8DE8GD4IaqP/1fIqmx2Hv0AZWmiqfqorQIiMV2VokNS?=
 =?iso-8859-1?Q?HQ0Of5fp61Eqvx0roIIuh6QqJyL+Kz99jLVZff80EcihKViadKiLU6MnCl?=
 =?iso-8859-1?Q?kQnMtQPUBD43jTlLXT06gvqP4frmlq1hQ3eBmQioSyEy9oVAEW5vitPJlF?=
 =?iso-8859-1?Q?v8ONnw7pDCZU/uGywvyohcUox3secVyUX6QzsKpR50e+UGpu9TyBDMzd+m?=
 =?iso-8859-1?Q?nLEhAUBLkzbu/nfYas/sc13v3ABFkDAHF9vUIM7OY1gqQ3Rzhs7FJEvAcU?=
 =?iso-8859-1?Q?RMaXH6dceXC7gZCnbtY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c744126e-77e6-49dd-29fc-08de0e5d5f0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2025 15:45:32.2433 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZjG/iuX7iqzqW4VfGRIQedPeJC5qmBzZJExZWxHqyeOSPirAQlvPHbMjBBeg0d1s2e86k72Ok3k0aC3sdS1sIKz6GxNHTvb+GvqdX9lUeCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR09MB4360
Received-SPF: pass client-ip=2a01:111:f403:c202::7;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=GVXPR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/boston-aia.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/riscv/boston-aia.c b/hw/riscv/boston-aia.c
index 7d8b91ef04..44be6e03d3 100644
--- a/hw/riscv/boston-aia.c
+++ b/hw/riscv/boston-aia.c
@@ -424,6 +424,11 @@ static void boston_mach_init(MachineState *machine)
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

