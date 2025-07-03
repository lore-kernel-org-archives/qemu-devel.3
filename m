Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF946C83F04
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 10:51:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHWL-0003Ro-9P; Thu, 03 Jul 2025 06:50:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uXHVq-0002sm-QS; Thu, 03 Jul 2025 06:49:55 -0400
Received: from mail-westeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c201::5] helo=AS8PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uXHVp-00077q-6W; Thu, 03 Jul 2025 06:49:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HZ6PvLeMSDJj5VopJGtapwG3G7vr5LYT1J+/+2I7o8gA/vSfzoNlVuJ1/uKjOGfLb7GhUSVKhn/vTWAQD36LHHeGg9oNbsffnbhuMUl+PVHdkGk1Qb2kHe8MtpH+yMzPp6mY+CojWKDZCyq4qowdmnkGrv9jMHqXRx0cYAVAcbZFiErz6Yng7TMoTQ91AfrSkiYP3yIUv6xiqzZJfLp7B1+GdG5vtQHgniCgGmcr84KIQ+r2zEWHkkir1qza+jQO14A2XpEgXc7715QophvQEAkLiGro8ekhSr9YVWuAeJ4WfBL1e1r4Q5HIvaan2tdaaeXmvhgXyRcmmFzaJ4kLxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FkophoQVRUe/YsDowUs/IlXmuFawOCRlr871HEoTkmI=;
 b=iX3ZzyvndtZ20dLsHN2OjMHFfmUHzX7KC6jdynT8D+e8gffrLHVbk8m+Bbqrf6d1hZ9xP2BuMl9Ab4pl9EuilpQPfDm8tpvGEz6vDJn1oHkujVLtEjSduZ6KrFFP1x+VhscXgiKszH9C75p6bOqmstEBllEM0Wu8dwz8VD1oLuGwscq1ad7e77bru6IYFfO4iDrxRabtnEU0aVxzXs9tRlVo5OpUvuPeGuMfhvFSAgYnrA7lQH7KhiTboaWit1/weCeEXwpuYlT73MRrtlCRNQ+og0jVM2HBaJwAgecPFMxTkW6T/2NHUXrozr+1cFMecAFsKNpkqdKWfSEYZU5xrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FkophoQVRUe/YsDowUs/IlXmuFawOCRlr871HEoTkmI=;
 b=ddRvhUlhoHy4y5pMk/yRVJ1m1nF/aVmzgK2svhfRCTFHPJswKDCW4ig3dz3pXOa9FzmYRIac4hoLFtTpA7xkjGxAMrfAvcbb7R1Wv7LxYpWQyG/0/CgWaiVRTVpcErHt6sm5WFAAumgCVKCsLoPwnWsdGCe4RAVjcwOzKu7RqOleifQ3ObFURFk65QRZaqp7NRZDQhYxZN1Op4Yv4264WEJ0A4XXGSgsbYaH9CCBiyaVtTXx86/chuMUZlJGPXq1MpSsRBFbqBZYjhO5i4nGeVnuGqAxCumFcOWGVOkAZA1+YIcqySmtbWi2DqTt8EoaqZW3Vp7OGjUlz4X2lifp/A==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by GVXPR09MB7293.eurprd09.prod.outlook.com (2603:10a6:150:1bc::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Thu, 3 Jul
 2025 10:49:38 +0000
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
Subject: [PATCH v5 10/11] hw/pci: Allow explicit function numbers in pci
Thread-Topic: [PATCH v5 10/11] hw/pci: Allow explicit function numbers in pci
Thread-Index: AQHb7AgpOz4by9o/RUanTsqAM0rtNQ==
Date: Thu, 3 Jul 2025 10:49:34 +0000
Message-ID: <20250703104925.112688-11-djordje.todorovic@htecgroup.com>
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
x-ms-office365-filtering-correlation-id: 63558257-db37-4228-3274-08ddba1f4ebe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?HfKVAarARXNDI2dzxxF+7k1iA5vln4pqpZaV+J0kMivxjTiqjaJexZKw3m?=
 =?iso-8859-1?Q?OzLM1920ygBEje2PQiNx+9kjTMisadcsUVSHGQGQ6/hOgamliHgkB+DNwr?=
 =?iso-8859-1?Q?ze5DNtEK03+aLet01EbjsTBFc87psFvWXZV6+RwDbmbYI+9shh6e+W7MxD?=
 =?iso-8859-1?Q?L1/qyaQE9wXLlEI2sY3EE9mLQGQpjdWR376Y/iT0P1JqHUB4/Mee7ZDVXi?=
 =?iso-8859-1?Q?VEgI3tgFNRS83J6ZuIIsKDzReWLW0Oz8H+o7AYJ4QUq9e6/zavb/oMRtJ7?=
 =?iso-8859-1?Q?Tr3+DYnCehydXIiBXB5QqgTgUgCh2NSzqEdQRpGvuQVw+geYllBeeAhJrU?=
 =?iso-8859-1?Q?R9UftaE6iAz4JQ5C6yZl3pfup31UwfJxGEfq+8vdRAafohFcyyRm7Rpbsc?=
 =?iso-8859-1?Q?En99jHymDjXgmnqC5e9fOvB1ClvM1o+hMoyJNw36k/IQMu44EujnrcFcVP?=
 =?iso-8859-1?Q?yls80m9picnipQLkPBwwui6s3LRopB0DnoTbid4McM4y5oGZOxubADhoTc?=
 =?iso-8859-1?Q?V52uGfXxEU02pasocMyQpPbbHuKv0wb9uPvw+C6nVfdIWpsM9+aYEYX5lC?=
 =?iso-8859-1?Q?DPhdFtxeDJvEuXZtH8gb0XgDY7PmFDSDWf1+4MHx8EjwAWZSLee8PTYHtX?=
 =?iso-8859-1?Q?0WcOi4IQMBgUaV3JZ0q2Kvk/mIuojNQsUQNlTUnqlyz9zQpA4NVcKcFMLQ?=
 =?iso-8859-1?Q?IGcpQmq4eUZ6OHuJe7PoPxTmEEsDLsxVp0zUsKQ3GQVVKQCXJ08qmOAKJg?=
 =?iso-8859-1?Q?4rE0YpDy8UNBnZvSKBOggTbfRJJyaitsv6I8YgwLO+ds8Kjr1ZnB82y+t7?=
 =?iso-8859-1?Q?QJnaJJ0ot2qkZesT7NKeF0QMMz3Cr6yWrW08Zojd6FnGZH/5lqDcO7/sU8?=
 =?iso-8859-1?Q?6S2JJ+Tll2+kq3M9/2AsWHMYQTDKycw3VShFlYPiWaN8PVC9brW5itbJjn?=
 =?iso-8859-1?Q?1seSSYZeIqyTbnyHDfogdgqTFzbvpWx/Kjs5/7sP/SSGoEfxf6J7CgHTAI?=
 =?iso-8859-1?Q?FjfJLuDbft1FcLPP42iasmIme1uKAx0L0KI8q7bt6dOItc3kmcUQtqLss6?=
 =?iso-8859-1?Q?ooApXOjg/h/b0RovHC8/lTdCNtmNApwLq6L8JujGt3jGW/cgA/JUwxnsrv?=
 =?iso-8859-1?Q?o5bqdNVbIWS4ILwCyOetqlcN9YXIPu/DOJgHsXOzr2TjPmB/2HXhNahT+H?=
 =?iso-8859-1?Q?A44fFIb+bnYw+rAWB6AxTom7YEzgtdqPRwtYGFDH8dZTwwMLizIg4q1t4A?=
 =?iso-8859-1?Q?sxiKV21iE4tMvjLkteNyIc+cy/cKtXT2g5jPEnM2Namw1iCV6al8PN21GN?=
 =?iso-8859-1?Q?4eDJTKuDZk821ncJZ4wpN5OcBsl2e5smKFto1KD3EsZAOycBRkVKvuM71c?=
 =?iso-8859-1?Q?b4COhdAsWwcy8H4OngEKjnHFPMWLbw+BB+v5aSueXVk+9Z0ywdDtCdPnzQ?=
 =?iso-8859-1?Q?ssKqV0F7KXa3kYfii6jFJAvPbFVHXKXCPaoVZQhb6hnKSDm18AltObFh6F?=
 =?iso-8859-1?Q?eT6kTpcS/yA9kXje4dSH21gUayKKXR72ouq5clrEhzwA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?SLabPKOa2GKAQnKTUwlBZb9eClwMTM8CZz0mJR/IUNjMAn+WYKNoxKUnrf?=
 =?iso-8859-1?Q?1PW6jpRkTqUHb3ulfv/8B0CvFRhRZHMdEcXX5yl1TihCjB6D6eAWi8egJ2?=
 =?iso-8859-1?Q?8wtvTLzkZ8nfmroLTrE9yCzPrvlM89pXKzrGevO837Zm7NogTWV5G3fbAp?=
 =?iso-8859-1?Q?g0v7WIqXEqww4u92q5hEK3/HbbpqhUNWiwAOBIfJn2baP5AuyPp5NyIwgv?=
 =?iso-8859-1?Q?lsXEZ7XRVowZx8JtSvzw0eKVH5alazJ3knsv3DYpUkzgUfL8dg+nYRLbpo?=
 =?iso-8859-1?Q?Yy589u+ucT5XuFKN1hJFpzYwpdsITXJRRxVjCJjm0jHuXQa2DPpmbYJfLt?=
 =?iso-8859-1?Q?FCxG7G+VRrMlzzwVcp8zinEsNqWSIA52+1cMbkxs2jGgZ0IMUfUzUyKwKj?=
 =?iso-8859-1?Q?E23H9wLVK5IgsIS1tGLDMTqnmx6JNpTH8kUAzor/D3vAo3Sgj+TteWmFNg?=
 =?iso-8859-1?Q?HGY15WxvJSU6fOGV3e9QZio9G6oeOd1nfyPD98jJVgoAZFGAF6/wOwud9Y?=
 =?iso-8859-1?Q?KVt6FcrR0+jcs8YCAdQOz8B1owPnLfg4ezNGQQF67DZeerX9igN2N+BnpL?=
 =?iso-8859-1?Q?iR6ckcxyS7RfBmSDwZgX/3byY0ocDcDmGugK6tMs7i83IStcYpRXWnZgyq?=
 =?iso-8859-1?Q?V8o7GQrmImwxRtOJVT5RzE3VVLzKo85hdk9rlP5/2X9DWswRBeWLG0eXFq?=
 =?iso-8859-1?Q?S2lZKn6SUZHzJwSkAr+UU78HrGRXVdet2J3cOrRXUrOvEneHo/na3SoflR?=
 =?iso-8859-1?Q?rRvimiIxRM62t6k6elkURyJJtYw5eZnASpVVAuuuboDXIzE6pY54u/8wVO?=
 =?iso-8859-1?Q?2HV12bwNwChfYlNkw+JZUBIg4yXoi3+6cz877Xx7kxQr7mX2ZwFypg+w2K?=
 =?iso-8859-1?Q?a7UOeUyY8FmCjbFwt6ll6+C/04EoEZ1LOBpnPNiBnKOQaiwWTu+EaSvaXH?=
 =?iso-8859-1?Q?c1ewT/7F5sOrz6Cmebh/UmzSjwZouH1dwHs+6kTqgVfqCwnxDcVJaaVtt/?=
 =?iso-8859-1?Q?6PIdQEBzkfM4cV/D71yYrv4mVzu1jxZ6di7MykmKlTEcPbl79FR9HLqDfk?=
 =?iso-8859-1?Q?nJOv5/YTIz8OC33//ZODYsh2CIzm64mLu9ylWl+ska6JScL9d5F48nEJfb?=
 =?iso-8859-1?Q?40FAfJ0dZxwmA4oTtp9c1oyB7noxU/6u1nAYH/sfZukzphFnhsWcTPzfoa?=
 =?iso-8859-1?Q?r96Cr81Fi89CXFRalmMslCiqRO+SDSCw4FppBudx1CyqBgZXXNqB/F/fAJ?=
 =?iso-8859-1?Q?nnG4GhDJMTuzJaK8nSr5ygLJnx4LMnJhbKcmAhv1U1G8qF8C6Ei4ePCYRh?=
 =?iso-8859-1?Q?4b5+Q/IVctmFpVmqClv8+YD+AQnssBtnh9ocyY4sQssGoysPJqwKzTsgt+?=
 =?iso-8859-1?Q?n7VhlSX0JhY/QqpQA/fJe2wmcU6dhb3g5VXNoelJla/dbkjDCROGRprL+i?=
 =?iso-8859-1?Q?vF4pvIFkl1AecbRPUumidIRAPP/OJSnNnn2HXKkqQxYdwMeOHTLOfAk8nl?=
 =?iso-8859-1?Q?Y7Ffc0RsE6gNbiLn8oFBSl1H27/XsCbrScvqc6/F5ERlpe6GxG2vbn7dld?=
 =?iso-8859-1?Q?Cy4w5Cpj5rQpOzjbi2bxw6GC3jd2Ohtr48ypdKHrJGnrmmaHrdUYMQ3TI8?=
 =?iso-8859-1?Q?9BbdDLgtIMtLiMVZn6UAFLTplZarOOOWWg7Kt9kDumIctgmgBP8ZHI4u98?=
 =?iso-8859-1?Q?4yioDe6+sNF5+Kyc7cU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63558257-db37-4228-3274-08ddba1f4ebe
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2025 10:49:34.5357 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kYkwbV7xL1yCZFLrQiGkAxtLTb+ec/GwCCAXDUxE4OQzxvW6VcNqm5zUp/83eSzJbdVrmxVyhAfzkiF4tkJWs4teAfxdJs/FlBzdL8fNkbc=
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

