Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 861D4F357D5
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 10:21:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvC0r-00047K-7n; Wed, 25 Feb 2026 05:21:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vvC0d-000415-MA; Wed, 25 Feb 2026 05:20:47 -0500
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vvC0c-0002v7-3b; Wed, 25 Feb 2026 05:20:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fcr8vi2HiF9yT8ME2RvrQ1ZpyupRISVoqpV2Ks8NpybdltQjQhSJAb8NDXj10oLd/JUmD9crjTLqrvOGtoNR0yLcpgl7V+xZ3gLLszEHvm0AVzATaihJmC4RlyOFTP/fvqqJ7pK/I2Z56Dc2IIdMrVf5uaTdQBMx//z/Xs86i2ckP8xYpCPf0XWrTwDG6ta2VbEYMeUV3LDjhDKI4PM22JRrNcVg0udFz75Fef8scAQv1DwdINhW9v37dcGp4ZM4XpDOWoUnRJEi4vVcpUWriDdYaPIs6iB62Ub+1fL3Te1Dv+3NhjKvSYg6+4pXM63l/lrxO/EYdXXs0DMjQjxXZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0NijLj0Fr/Rz3NeFtIyH72DnyHYCNUTg+R3ZWw3fdDA=;
 b=mpFlILCqS0XaRNTJonQs2Sjs8cYO8jD7yilN/wkDJRXwkQbD3w1WAGiKveb7bPqBHGU5W7NcQgEvOgasKk3BMjDbp6OYz+KHr94AvebFW8yhkkPafdGbAaxFfSZTpQ6+Xe28kq1iahETm31Xm3mGcyS6bVmMnGtORVcI4bTqvtx/eaJ+uWlBKxBPCBKHwdUUKqs1LClLV28lYV3X6hEd4FKBsd8+zbhOCUMUECdHai67h8uzpuJdUREnKWUGEQsliTByxmebqU1Sb9+0BMaAUtRN5vHhaZvwPeCMfTeCcU2Xf/b/hesG1wwqoB9qroHlKS1Ibciei58tLg76SC2Dsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0NijLj0Fr/Rz3NeFtIyH72DnyHYCNUTg+R3ZWw3fdDA=;
 b=iHCXA1WhMpJYTjG+p9rXMaHzCturfdznlCTXfkGgnlbIGl9iC6ROP7QsegrukrPfMYjk+/Tk5ciJYbUkL3+wsAnoXxs8bY51uMauS4SKYwTZGFpi8dwFZF7qVY3kBaeERHkiK1DCz1N8KHf3Xte0cWxVKG1LivpbYsawPl+iptkxxsR2kqf52UXr9crjPHcoitDMUjRtWAsugcRxzxMNpgwNBIsBBsQkGmg5PDkT/vtK/Uf/letPj7x6Awzfd/7a3ip9/6eKrz/U79EG1bYEbgkEvxD3IWQPKHSJgWWzcoAINgWG8W1zw161J6TlXOIQUzqT6ExVdD9zYiKTDEiyZA==
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com (2603:10a6:150:358::6)
 by PA1PR09MB7406.eurprd09.prod.outlook.com (2603:10a6:102:466::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Wed, 25 Feb
 2026 10:20:29 +0000
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63]) by GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 10:20:29 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v2 05/16] hw/riscv: Ensure bootrom has correct endianess
Thread-Topic: [PATCH v2 05/16] hw/riscv: Ensure bootrom has correct endianess
Thread-Index: AQHcpkBcDbe3Pw9670mFyVIyTB3KCA==
Date: Wed, 25 Feb 2026 10:20:26 +0000
Message-ID: <20260225102016.200654-6-djordje.todorovic@htecgroup.com>
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
x-ms-office365-filtering-correlation-id: ec423a7f-37a6-42de-29a9-08de74577ff5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: DmPduOud5OcI0vbRQMSGehwM0zNV20CvKrkSfwGKisjPqVciTXNY16QzpFw97N+YJwAOOlFJbVK7eL6emTEodKBJFdKbWyUStlsrYpXZsfX1PLCYn0UQ4fbMOG+qx/9nFyKFUuhrqxy9C9VLrMZezsCwmmoD7E80rJFHeOtIL0H1sSzSsg11+ull6xXiWHxZo3c3XHRBzAX4UKttxe3f8jlzwtseT6PhJbuY04NSnP80JPltdmHH+x2cM5q/v031VQU9SxruHj06fchskuJhUyVG5DwAMknX1bgl/F1RJRvhTnW0fIf76vG3PiZwzc5zxZOd2aWYWz2qgGv69VacULqQeAqTJyWVMr28CkoB+R/7Bfc8r6bhzalQKyef3LQjLBBNH7FZnO8chcmfAeEjxtHpAoicwR9SaN8qybuCwByCJS8GZurosN/EPTyfk/romZiqIntrLn0HXp6/+nufn+HfG01JQ1M+/vxJmxwi+VStjpRIUuboHEuhpUyFUpAbnMfYoQVHocokZGQF/3+dHP8rFkBHTaw4hNRvbuA8F5BybyYvm2G6M33vQtcFa9pcVjpPxzjeGdG9/vClKfViv8bqPzkLIcJlQQL7RfyihZOIUDuXfWYdhjpGIN98s9UzHsWv6y+k5YGEwLaexlTye7S3mlt9S2Xy2t5/Tz8NS4OVEpF1o6aDhcvFURMecn4dR1GjTLZoaPXfOG0k0Rn55wEmloLekQWgHqxjMOE2KFIWXZbqYAqj6WTxOTl34IO1P4A8qOKR9Cs3fpN51ZvUdMsxoXoQkR1bkvYs3wy0q2k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR09MB8755.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?eGK8UafMqMhe+6D7EiZcU0ODdK3aOcb93k6XtW9A1Apc8ofDGuqFlGuagV?=
 =?iso-8859-1?Q?pYnQmIx/6G2RlBKN4CLNbVmlEbQujNyoaD9xbxl7LbLSGhmZ8H7wQEULoa?=
 =?iso-8859-1?Q?M1Ywyyi6iZkBcNN5ZjqeNwI6JAmDt0J+hMdYtI75O/vDEHzYd2hkpw0vDL?=
 =?iso-8859-1?Q?kiUAptoxtyucnCrAK9JP+3bS+uFRuPHxuFHJxyJsuRMJjJzY7/KJWSlXYQ?=
 =?iso-8859-1?Q?ahvvZAx4Itjr9jNaL5i+KnWavsH4PVRj56A80iK0NedlLV2kWu5SxdDEFS?=
 =?iso-8859-1?Q?PlEGjjcTLjWnRjuSFj+UhrHCE84P9yce3odq9Z9ZXXlcMwiaKPfSQjskZZ?=
 =?iso-8859-1?Q?y0hpP8xyIBmiIez9hibYgvSIgbTKMOyVfF8NDTXg8URwMWXlslzDzKLLJn?=
 =?iso-8859-1?Q?NJ6B2HYDMp1X8VQlkrerD6/qZSOafKbX3Mjx+N0jto3F5MWNy2jZtIzA6h?=
 =?iso-8859-1?Q?b0STywcL/bomym8mcS7gZQ7u4dmP+XgOkUVzfNTppBru6CP1aWgyItusnu?=
 =?iso-8859-1?Q?nIooLHnr0mLbZ4HreEDmivz2xjjwCG/tQrzFDcTakeTdWzjciFTRDhIgjM?=
 =?iso-8859-1?Q?27ZdY6FaEjXglBlwtaKgScXKZ5lrOkPwIlIqAQl5mfRMIkj6zOVMzpeaSv?=
 =?iso-8859-1?Q?lvl8uZJ+onAZqkkmPgLEJcyPeHbXBZZTVPwrvZNM8LXcI/uL9aFcUYkr/R?=
 =?iso-8859-1?Q?Pnzme+dMK+EqVsx67WBBr8EfYSda7MzsUMBkwrd+djv5ZhMkhBz6nvVyrL?=
 =?iso-8859-1?Q?V9JwD8p/NVnmwK2QTJe0TsC4QOpSqxmfKt3fBFCqATWXeDsK0dOl6mk7/y?=
 =?iso-8859-1?Q?VcZSPO+H7ITMG2Jp2+tny4e08vX8rH0/o+tz68XQHH+AdsaM9FbuWAJOKo?=
 =?iso-8859-1?Q?qTYSXiCjPwkSzPEvK5mC1xOkDcSjFofWIHMr4jTuHLcMYpARzwoHwKPek0?=
 =?iso-8859-1?Q?I1+f9A7c8jxD6iRoOkvFxRU2GWUmqAQIBCOsg7vk8FV+LGtg5mVp/nH95G?=
 =?iso-8859-1?Q?uTfykrwfa2YDiWyzIvn0b9aAngrWxroNHj9j5ECCusTXMGwotBE/E6MqWj?=
 =?iso-8859-1?Q?U19D1+TJvs9F5AXSV5dLp9ND06Rsttfp4MkdZ0okS0fL5I12Rx/4Dt8PAi?=
 =?iso-8859-1?Q?WCy3kw9lhqIpl+O2MEvhYgELgLgDA+WJs6x3rx8q6lPzcJB7ln/K4nxinV?=
 =?iso-8859-1?Q?PJdt4crLnjYS2dhYzvWLkKb0pAiSV7RQx8S6CMX2krPXNJruhvU1VyIBp4?=
 =?iso-8859-1?Q?m9lfgF5FQsXsYQGBvmrNirSWjh7hEVFOc8PsbRkyv5w/7gicW/SrMxO7lJ?=
 =?iso-8859-1?Q?ueT/MZn2DwCnz45iGCYUUs6WcuJQoQzM2JJbFYClyU97qdiJaApgngAhDl?=
 =?iso-8859-1?Q?lzYLYPLneMkCg4WE1/x5NcIUwnjY3Jyc+hCEZpoo5QuCIDe99eBw4pOZFq?=
 =?iso-8859-1?Q?u4H4gtmrwFlA5zrNlyA10NPREZkcmSdXqMAaENosUeoE64jfLm4KPXsiJ0?=
 =?iso-8859-1?Q?UzBT0SULYDNbnzfA0QLPrfZeZ2zbOEuD5WJnSVOx9NymcCBWgx7OEsI7Q+?=
 =?iso-8859-1?Q?SK3JoycU6LHkZ7bxUohl5MJOY7xDN906Vjz1JTFJN8jJ1e/FgAdoTYx7U1?=
 =?iso-8859-1?Q?+oPRPCssVFptJldz1okQY2R5z37JH2pI23risELbfRbomsa+GKXK9lyOKG?=
 =?iso-8859-1?Q?3srTlGwodp36LQKPGYFF40pnBy8pLwZoY4w+Jsqa2fUZdXrPFdrmS40e3Z?=
 =?iso-8859-1?Q?QQADNtG6wo9+OtCr1oWrXyB6IJAF+C6IFqtATNORTgA9YlZZmWNk7UqrR5?=
 =?iso-8859-1?Q?kgkO14kprgvKaOHihq84wi7yM1ODQvGcGRrqq4nCLjbmE2XDsvu2?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR09MB8755.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec423a7f-37a6-42de-29a9-08de74577ff5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 10:20:26.6217 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0OqOfmLxLVLcibdEpvHwwV36k8sGo1JpB6mJRnRckVFfZhDkw55DnyWR/ZARWeYlsU3qYmKBJMLxSZBMd7b+3NtFkF5sm8dooTTrc21B2lE=
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

---
 hw/riscv/boot.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index e5490beda0..dc9f8a7327 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -31,6 +31,7 @@
 #include "system/qtest.h"
 #include "system/kvm.h"
 #include "system/reset.h"
+#include "exec/tswap.h"
=20
 #include <libfdt.h>
=20
@@ -439,10 +440,24 @@ void riscv_setup_rom_reset_vec(MachineState *machine,=
 RISCVHartArrayState *harts
     uint32_t start_addr_hi32 =3D 0x00000000;
     uint32_t fdt_load_addr_hi32 =3D 0x00000000;
=20
+    start_addr =3D tswap32(start_addr);
+    fdt_load_addr =3D tswap32(fdt_load_addr);
+
     if (!riscv_is_32bit(harts)) {
-        start_addr_hi32 =3D start_addr >> 32;
-        fdt_load_addr_hi32 =3D fdt_load_addr >> 32;
+        start_addr_hi32 =3D tswap32(start_addr >> 32);
+        fdt_load_addr_hi32 =3D tswap32(fdt_load_addr >> 32);
+   =20
+         if (target_needs_bswap()) {
+            uint32_t temp =3D start_addr;
+            start_addr =3D start_addr_hi32;
+            start_addr_hi32 =3D temp;
+
+            temp =3D fdt_load_addr;
+            fdt_load_addr =3D fdt_load_addr_hi32;
+            fdt_load_addr_hi32 =3D temp;
+        }
     }
+
     /* reset vector */
     uint32_t reset_vec[10] =3D {
         0x00000297,                  /* 1:  auipc  t0, %pcrel_hi(fw_dyn) *=
/
--=20
2.34.1

