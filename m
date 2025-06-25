Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B63C7115C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 14:19:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUQxW-00075I-QK; Wed, 25 Jun 2025 10:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uUQxV-00074G-0e; Wed, 25 Jun 2025 10:18:41 -0400
Received: from mail-westeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c201::5] helo=AS8PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uUQxT-00048J-BB; Wed, 25 Jun 2025 10:18:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S+g3DaZDCo8OGNe4LTaXC4MJDIYEvrTazjIiGF0QWuEBulLHV5KD3orPiRjRdsgaN3fKKQmo149sG1/kTMiFCQa/D31u8xj69xHytf4D91hLCQSYLYDFl7NgGl5uTx51WTti4L8sBeGu/NsIM6MwjiQ5CP7gT5v7p31Dc28GFxDH3CkcwWnuvqLGOFP4VusQoP80YRmriB6nFZNiWSaf9coRAUf2lissLclN1O4HSeu4jjTX80940SS7qK7vv9yEtUIsGZTDLZKz0WBwVYQ0cSIAsIQ4d9aVXUDFeE7OreTxQ15/YApIrPlIOV91M6p5DDPM5vZOFXUocf73XgAMAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FkophoQVRUe/YsDowUs/IlXmuFawOCRlr871HEoTkmI=;
 b=d/q0BRzzeyGVl0OcYi9dgvzxafs4iZnOxGrvjvQkqO+19MGYtACKSRcG3fqIkaZSH/TXBd6LMPEHeYlNFFLa494yqPRaqBDQiB6R3iYodpJ5w2wjmFlOC/6bL05DaryJ9C6g/mFa/52sPm81rE4BSdLaxEEBxbD6nXXbV/h0Y1OqtriOHPHVUfE43zS6rOboF3XFLCvbOv7RYp16f0tFHPLeRmdkZVEXZw7tfmkDR+9tQF+SAPB8frErR2IhzEhWkmBVQMIQAUFlKyDqWeHYF4Mkz5OmPPf+naFnvybHVdB2VyFBdvUvD8Pw6xdYg/WnqEwn/zpI3XY2c5kgxFAtNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FkophoQVRUe/YsDowUs/IlXmuFawOCRlr871HEoTkmI=;
 b=rCJMmyRK+J3lSzF4tDUNzQJL5kxYy5kylxmqneX79rECwtjwSG3DHjBrYrOaeWA9us3l7VpNJEa+D7uQnznc3cNal2uHGx2214TYgjz9ypTHZK6awX2ZyO2DSie57Eg34BsuZAtmngDiPbDjL8e8irLlquRPohyR062xXVqNcMNTjbebi0vd2vAUtx6n/g4ccauQgzMSn8vXE9rzJ8ApbJRC5UQlPxygtCap1UjOZJkwMxr5K1Z56GsudvctgKUMmy3L8Avd046scCQGD3XRrdLy7IwQtxTjbnl8QGSQIwhNYpHf0Jr8QfpXpKHnlz76TL1pQSc/xnAnJcP48KmAcg==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by AM0PR09MB3665.eurprd09.prod.outlook.com (2603:10a6:208:182::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 14:18:23 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%3]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 14:18:22 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v4 10/11] hw/pci: Allow explicit function numbers in pci
Thread-Topic: [PATCH v4 10/11] hw/pci: Allow explicit function numbers in pci
Thread-Index: AQHb5dwBl85HCSZW5kKIzPpkepV+YA==
Date: Wed, 25 Jun 2025 14:18:22 +0000
Message-ID: <20250625141732.59084-11-djordje.todorovic@htecgroup.com>
References: <20250625141732.59084-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250625141732.59084-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|AM0PR09MB3665:EE_
x-ms-office365-filtering-correlation-id: c54584a5-3de6-4220-14ab-08ddb3f32429
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?8vKT1/AXyvQxK8Giao4v1uQscB/gUVbghKlYS0GrclCbfzLBqLD4SLy2fR?=
 =?iso-8859-1?Q?+pflaf0XvUwL0oTMs+HSfMhi8AaOtV6hV+5LmAlnRF49qbNt5Pl5N6cxHb?=
 =?iso-8859-1?Q?/gnx4OhcNz/zUNlUPFKLarM/NRMIC1jPYvix38skp9qfYj3f9BfIzIq0Dl?=
 =?iso-8859-1?Q?8wlGA+HCS3bDHfl9u9grd6f1s6bN9evfwctGEzzhPKM3/jCBpGjBeQnhxN?=
 =?iso-8859-1?Q?Sd/e4cai3cD+u5BwttTDnec9jMptZMY1oFbmnP2arN3CIsC/kUZjBIAX0B?=
 =?iso-8859-1?Q?Jo6ZZVk3n+1htVmcT7jC3X1iT0yBcXZiP5y78p0ku1gvroyeWxExts95rE?=
 =?iso-8859-1?Q?5zBK2GUqkWQX2jZ3HigDo9rbV6wt1cmDCg8Mf6hzZ/Ra4/I+iIGFVcipM4?=
 =?iso-8859-1?Q?xSkc+fbSCB6bviwWuCIYuxQ7tptHTD1FxwF1sm5CjwzSSzB08zyY36BAnF?=
 =?iso-8859-1?Q?MFpBvdekc//uPiuUppYeLfjaCpXLwLkNyv4qiqVQYlRtQwkSjdLizoLqrz?=
 =?iso-8859-1?Q?v0/l/Z8h67VrirDU3daCPw7nDwRYXADg/ox5USEXeaZLWtlMNxfBdqcb1u?=
 =?iso-8859-1?Q?AQzzD4CNjevDMBqFMpPEFMgDimb4Z2L7I1F2663BwJt2oLSc259qQkQunr?=
 =?iso-8859-1?Q?AmjkrJq/BAM29j4htxsSq725YcJJvuidHMvufP4bgtkROgyDkJZQW+Yy+t?=
 =?iso-8859-1?Q?ojWu4yGRyAfkRiaBb4QCWrwNW4wSP+BxskK9tjIgMLVbBZldWijuQ2EtJ+?=
 =?iso-8859-1?Q?z5U414Dt49Tm4a7Ru3CytJE8wN7SWvM2nR+2kNnT8xId7VKncS743S5kRS?=
 =?iso-8859-1?Q?X1D+aNVqvbkYjmpsJ/cPWcIFUjPfFwwFdsmiO1IC/CwkyMABFoYtV695Xy?=
 =?iso-8859-1?Q?itmMLy+/hPpBIYRizFoAjcuuOEtO0ig7SAynVSyjEctBqmQUUuWG8wBlxY?=
 =?iso-8859-1?Q?dnl2Rjqi0KuBUy1xwoaJeJ0kZuHU41ay7qfRf/Nucca38BQ7Vto1jhj+dq?=
 =?iso-8859-1?Q?IP2KCx3iWS/VOGY93jS0ZguVppQ9Fv4VO5PwtUerGuH+fk7ntRX3CtO6/Z?=
 =?iso-8859-1?Q?WASKHSLNqb4/+R/n8UyPcB9Cveei8ZD57LGVI9CSd+yQPR3RhejAAaUBWa?=
 =?iso-8859-1?Q?9h5F2OvnfUvTHjvRwGWNYn6Bm3+VaUNiX3C5qMbdwb4p9iFx6yCkz5NR4f?=
 =?iso-8859-1?Q?6CfdYryimeqng+0c1vnRAVvyXwNlNKSM+0rVouSb0nLgQwXw2KC8ikXDdA?=
 =?iso-8859-1?Q?GxsLw7xZkXmF6s6lTRFSaNHGjFcECwF+6wAIKNROQXw9244vnOuibAof9h?=
 =?iso-8859-1?Q?6IrwgfZ5Rhtl0CGRlr8a3h8PMNTuEUxkxyQ1Zr9xXk/P2JPdVcXvYQWmBT?=
 =?iso-8859-1?Q?y+//X3L31Pb0gT21OLN+zJ5iwZr7FSJhlJldPGpKe78T9ODCy8s7sMnPDz?=
 =?iso-8859-1?Q?xRCpm+0ijruiUlxEEwTs6tRlP6J832cAgFyB+jVqrFQx4kQjC5Gfzvm5yj?=
 =?iso-8859-1?Q?APof0m9xPjnlsvuAawnPBbGHBM9is1xTt7BmQz2V/5KA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?b5mDP1rqx9WMTgerJGCzwg7uJLBZYB6lBE9fQc3Y0J8wBHhr3f/dXSFXGj?=
 =?iso-8859-1?Q?bRQ4UOAllIa6dF7DSoT1tsQdsETvJz/Y0sRzy6HtI7VXsjGOOa0pLveXd3?=
 =?iso-8859-1?Q?1xF8LnDERdpHKRS75Afu/84NtnUzmaOSjooGh5bwupvyMf89EAY/jw7Zh2?=
 =?iso-8859-1?Q?eFWkp1Ia+OtCwaVNeWMrpLEEaf4H0Yj9gDd3x5+5ns0lZHR8iw++5lN9PN?=
 =?iso-8859-1?Q?5PlzCpUPRgTXY+ur48bG3pBOTGdEqGU1BKWGowIZRi92eX6/eUycJ1CrHe?=
 =?iso-8859-1?Q?W94QFPViQEBZUC2R9GQdNutcUQs/RDV/R8mCM9b2StYnojiVhAIYmSaldg?=
 =?iso-8859-1?Q?7IYRF+ypu/pzByTDX8/DYfh4rnEYSzLVyIQqB30YQNHe3K9j63uMwINBaq?=
 =?iso-8859-1?Q?V+uNXn/DKmiKg8ilPVFAO1R3HabXu5WTYCv8sqiejgEsuZ01ZxZhSQr+1z?=
 =?iso-8859-1?Q?WVzSkmvFS34XVh2iT9SV2c04RsZkz8sG24UCshF93KNqjFPJTni0A6WYp6?=
 =?iso-8859-1?Q?aaASnVoPaf2Ym481SO5xAprEbqEhDcUQYVPQ3ivTmARoS7tPTqoTR/ilOa?=
 =?iso-8859-1?Q?KgttlJE3C0xTvhtCKBAebT7jJGc2ThJs2BdkeBOwkMcBKzcngvZiTqZujL?=
 =?iso-8859-1?Q?LPBjdggpKOmzL5C0tLQX0SeMNxuHvfQ6Ga1SCmBAqd9oHgbGNdK5QHStDl?=
 =?iso-8859-1?Q?9Sustz9OCuGnLAAFBJxEXmBFVM7566iVdt31YWweFzw8VqJRlgsudnYMv5?=
 =?iso-8859-1?Q?IHvZZfEsOVm6+A7ayFG5ljaOmZNET2a+tM62bbyg6TJopxm8rMYkX4qitV?=
 =?iso-8859-1?Q?S1Pnt5OJyAfhiJS+Q6hCZQxhST/T754ly0j8L3QmgO2IKaXAkJFiAbl3E2?=
 =?iso-8859-1?Q?xxvV5ZY0CkPCBB0OiW9ekxmH/NjA+XJUkNvwK0HE4+stAGfG3X3dMmsNLS?=
 =?iso-8859-1?Q?dWuIBbj6PQcN/M38f6v1guSVdp58Xx9be+2PvOoCTiSILWIhvUMLLYaI+C?=
 =?iso-8859-1?Q?aiiPjokMy8PfDLt/1KyK5MXQaCBK3yjwt09xHcZs+hgNDIn/o+gx5YpRNR?=
 =?iso-8859-1?Q?OTHDOd+Z4CM1HWUUoYk70xxwtrkf/4bFAdC1ak5iX2dkaPMLIBxTneHeRY?=
 =?iso-8859-1?Q?UzV4sIn/p5VBwHgwIDD2xtB9SMikX6+/pN1I5ATQZFh96FZmz7XqbewrgE?=
 =?iso-8859-1?Q?IGqXA4HsNwafbuEy9+OpTFfPGj73ilT3xQHzbDixP3EST8Ey1INsEhYIVc?=
 =?iso-8859-1?Q?XD75HmIaQ9k/InSzU8mJ8W8P4PVW8C6/swBzirjkmRKPhVojtfGbc8peIP?=
 =?iso-8859-1?Q?2EhJg6lz8B1rjlLl4/T1wJ5dTxl5SHiA/R1FhR//e5MKAfgE1GDVt4nDaz?=
 =?iso-8859-1?Q?9HfQrWQoWJCJNS4gFFd9vIr7z80tZLrUZyzM4/b8nQsfE3TW2iKV8WRyvu?=
 =?iso-8859-1?Q?IGNkHlNOsaTILAzLAmhuAeiGsJzL78XhI938al0tSo0YrXH9gc0SLpCBRy?=
 =?iso-8859-1?Q?v6c0pPAyR9jWdGwNsVss4XORmX3vV3XaWuqVSP44zOrcP+BdlkMxft3cyG?=
 =?iso-8859-1?Q?KZIlBUIgpZVekgTJmdZgjRllX9tMTwOv+td3ate9pQv4vncP+3fad5EaYh?=
 =?iso-8859-1?Q?8khoqNl5dT1zQq4yStQhDTvsKJ0lMzCL8XE/OOOfeICewejJyNURH0pELe?=
 =?iso-8859-1?Q?KvJ3FCyPnp43dce7/fU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c54584a5-3de6-4220-14ab-08ddb3f32429
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 14:18:22.1467 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H6OVsrvOzxDayNM1UhgY4Q7ZUjJHzNDfvhobKy8Ml2gUIiSHbgdD9chsOAltF1DU8lolURxhQB0rJuD8Qvzm3sdqoFt55RC/Ak0fJxBEIf8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB3665
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

