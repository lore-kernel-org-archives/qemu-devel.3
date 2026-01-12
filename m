Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FBA3D25056
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 09:06:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfDrV-0005ea-Fw; Mon, 12 Jan 2026 04:05:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vfDrO-0005aK-La; Mon, 12 Jan 2026 04:05:18 -0500
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vfDrN-0004wl-A6; Mon, 12 Jan 2026 04:05:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wwG5619AZrJoou2JfSvW+HJr7O1RiCVtScKjn1NzlzYpX6b8zdu8+QeM0cV2xn4Rg9RpUPvPDT3lZw+psHEHU1J6S0mhRnyy++lGWlRoyUAFQ3cUDMd6/v55/2Ac24+C3uX4lOwTKcajg3An4IVGnKIUtamIS/88jFDgS7+L1Sg6YTeTZyKPKsZTuiPht0dCesM6x4eQx/ok1xd6dx6JtB7RqihxVpMlc27eY8a05rQGElsrBLj5UH/oH9VgOpG2DIli5d7Lksvvnps8RXVgK7baG7V3SOZLbV9FN/y8TuZpIbGznNN956Pjk4R0oOfKui1e+TSSLrGBMRur3OT7Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPdA4PthjIWC17IdrwUDOPuhX8ZCbvtZCxF89bL++1k=;
 b=tBrtMBVZdV5gTZb+Yc1fQ0Yls4qFhkB/wHABYUI2A9X5U0hNCJ1PxOYRhAGYA88wPEUaW9XhZXEqaOunHSPcN4CpJGu5KUQx44knb+fk6DZNkS9M+qSG0bEL2/gDaq05xMrQm1SwY9j2HyowQrt02cmH8+wJvqZAHjG56Cwd17Ca5P3f9gKpsfi/ESW/mQXV2AvJ1xoNpMvy2+wNvANVV51pf8jbNiQM6/ipnam13HEBSbgyOUzY0+5ry7YXyHxlywE/fLhQf4B8l8DSV1qFlGN1R+NdrLEqbenrOuWfOJiFp0XOQnqjDBE/3FaRVhYBZYPxfzbziVZ7mbosEL53xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPdA4PthjIWC17IdrwUDOPuhX8ZCbvtZCxF89bL++1k=;
 b=VUjoUeLCT7Z7mlqLMgl/BJ2O9kGfRKjo9AIHNxuShDCg8KRIjiZlNsmAwJNsy0FRT5QaH+Q/MqbmK+Kc6PkOe0NCxEnjvEEkEWi6Y8w+vPl6eeyM89HLdc0ffUHo1yZd8SKbCmPd478s9aaiE3g+j6Cv8xuqeUm5jeyvCllOuqKYq5DhJtSyLX01cuKy+vgGrJuIWeQicVOJ1Zef1Bg97ldO+BLalzr5YCg7L42bBuG39YyT/Gt8FWazgUDSUs/QjJbYOBCJLZFab3M+tIHarlF+Pyfbxj8e8aHs/4Nef5pzSeUhBU5xfyyDgJoG5L8aOydQynjdk/M7lkutrRxTbQ==
Received: from DB8PR09MB2796.eurprd09.prod.outlook.com (2603:10a6:10:ab::30)
 by MI3PR09MB8569.eurprd09.prod.outlook.com (2603:10a6:290:71::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 09:05:04 +0000
Received: from DB8PR09MB2796.eurprd09.prod.outlook.com
 ([fe80::e42:9fbc:3e58:febe]) by DB8PR09MB2796.eurprd09.prod.outlook.com
 ([fe80::e42:9fbc:3e58:febe%3]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 09:05:04 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "alistair23@gmail.com" <alistair23@gmail.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v1 1/2] hw/riscv: Fix integer overflow in cm_base calculation
Thread-Topic: [PATCH v1 1/2] hw/riscv: Fix integer overflow in cm_base
 calculation
Thread-Index: AQHcg6KKHohQLgT/bkyt3PokVm99Bw==
Date: Mon, 12 Jan 2026 09:05:03 +0000
Message-ID: <20260112090458.2345280-2-djordje.todorovic@htecgroup.com>
References: <20260112090458.2345280-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260112090458.2345280-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR09MB2796:EE_|MI3PR09MB8569:EE_
x-ms-office365-filtering-correlation-id: 3c674841-bd84-463e-706d-08de51b9ac9c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?yT5GEUtt4RzWGokfZHAB7OqmJeF0qV5WnZZnP+O7LiorGabV6JbmZFKkUt?=
 =?iso-8859-1?Q?7Rvxr+TS0xeDIhzDlZqlVM5I9W+7dRMSIufufAL9JAOdCWMiYarE1mbShp?=
 =?iso-8859-1?Q?jHt1WtWixQkp1YgAQSG4CdZW16Ui0SEnYDH77DAN+sog6/5O8cWzRt9iXh?=
 =?iso-8859-1?Q?iP6VAml8w6PtMIOTZ0HoabkdRv9vcrlP9TsMR8UXIsnDjn/zeaOOO+dqw9?=
 =?iso-8859-1?Q?TyJW3Sx3SXoGMgPNlOdTPLYvIGw/diXgzKZurB7IoJlhdAl8/TNRRebh2d?=
 =?iso-8859-1?Q?sojgzO8RGkJwYNcYSgO48TQAVlRREWAbaPZqfkUGBG/S87Qzy8anOY0ge+?=
 =?iso-8859-1?Q?q0/tGn8HQ2ID8AlJf90SbvmwcGN4IwtkdtnDV0VwEfV7uyEjmYW0hpBoTd?=
 =?iso-8859-1?Q?V1hZ1TS03fFSVa0VVz8EdEd+0VGeotkqWe8mc83nGzc+aM/liI7Odh55j8?=
 =?iso-8859-1?Q?6NxN3LG/gXP3cYgt/fCMnJQRIziSpJU++GIfNtsdVpRH+gY1y4EYl+aalq?=
 =?iso-8859-1?Q?kXaqPoGp0X7B1ppOmYxDNInW8bOMQfeL52KjCOLEBr777Z49Pwz5dA1zgv?=
 =?iso-8859-1?Q?p/ZP6EvZCx8Bm4g8F+P3XuPDdE/+nGfIbnI/PofQYcdySkFMNGe23RNC3S?=
 =?iso-8859-1?Q?jMqueMCpAWh7yy/SMvG7laIDn4yU4mAFfi8aPpla4c9meeH14D/SYjOjtL?=
 =?iso-8859-1?Q?hYDPfgph7n1lXA+8AWzbMvSYAnrVprOQoYY8oO7VnvOemTaao6GsCy86+G?=
 =?iso-8859-1?Q?8CMJBLCqiPeQ4s0FnJij9Uw3BH+UN0eA8QDE67xf1ovruNQx0yxLSS71sP?=
 =?iso-8859-1?Q?XWxItnDcY9oaw5anGP6K9HLmXgAPCZ6BbimER67Tf4HKLy0mUM/+L285ML?=
 =?iso-8859-1?Q?At/lPINrN3WLgwqiLfMFCBq6G7avE9ljGgXDs1rnTIt959ZoYgeFl3f0w1?=
 =?iso-8859-1?Q?hDgUA+JDLUf1/pqeqGDsh+zk1HGZx4ibUuqCVvdTeyMLRxYVl+V4zKdRDS?=
 =?iso-8859-1?Q?sysVpWQ6Xmafn45rP8gYIF40n4i2R7dC+Xd3TteVk6+8kK9WKcLmUXKotg?=
 =?iso-8859-1?Q?1N3d65lj5Z/KTZ/8TNeJteSCuSMGEGPqBmzoqAnz7vpMqL60dlWBQy+eTZ?=
 =?iso-8859-1?Q?ZtFF47ZjeR1yDvCmbCML6FhhfFt32WCnjHHy0iRmPfAQUyzAnTPg0w8m/Z?=
 =?iso-8859-1?Q?NhTibyPDQH5zvRKerTEDxQLbCGlauky/lB4902eSOKUxWXhWU7LzvNjhFS?=
 =?iso-8859-1?Q?vCvR1VXaww55o/pI+m61O7qguSMOfu3L/FhSlBIC2ZQ7VHU31tUZPIW7TM?=
 =?iso-8859-1?Q?zTwpR/uDGsT8e8lwN4Aa3TdPKKlh+mq+eiz57x+S+EDy0WrRdp0aoZL3C0?=
 =?iso-8859-1?Q?eDLr4ePLPjFbms7Q/TJWpmZPWQ0V8O5mI20MrFMFMcY7ME+ehcquh+ED6z?=
 =?iso-8859-1?Q?SmuO+yqN93gXMPL6VOEUObpSB/TxnUfubdlHltUClrRzsYv9kNxg0/8ho7?=
 =?iso-8859-1?Q?3qwd5z/VB+9GeKuJzyxgXQh28V4I/JgvvDcgsRlssojnLI+vIJr+ZJBzx3?=
 =?iso-8859-1?Q?odV3QDagMtdRHQy6nCKZh2Nd/8FA?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB8PR09MB2796.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?vjJDualphgXHS3gpBc4IKFTh5bbt96+0ZBC7QyE6WgDRQy5QiRrioczbb8?=
 =?iso-8859-1?Q?EAuNyI+7/cAzL+2MC5fJM8bqWRQ5VSwOmIAW3SbLVrfdxMOq8dB5OCmLjo?=
 =?iso-8859-1?Q?bxKKRYVESYuv+mSs+DAsjMbak2WGO1QUyyQ6luNzaF0zrQxbuqUGPhfiU1?=
 =?iso-8859-1?Q?EhGublAwa5GacfwKHZTgWlNzF0+chasUmUruqHqNNOjZ5BLDXU9NtS7NHo?=
 =?iso-8859-1?Q?VwRdiWlx0cuPog4xOAK/47FrcMQ13kqc8SV/deSsl2EpuL1IPMeEqDxrv4?=
 =?iso-8859-1?Q?QatpSKxhEJyFGkA064pyRahXkldmQoWAU0HEGIoBdrgpn3x2a0/SAyhjb+?=
 =?iso-8859-1?Q?I+wTFXVNSzfjR9CbW6SIEPKZTzZmD+tpLjOKQ93y/SfU9RoE0aikoAyjwi?=
 =?iso-8859-1?Q?wfoFe9F3xMB65tsZOOOil5/X410LWlFdinK9loPek2DyLvZ4IprkMkLja9?=
 =?iso-8859-1?Q?ycEBcsOwfBNPdOEzyYMgrwYaeKUgRNqa29RMvO4wTMGRHXkCDTUa3FKg1b?=
 =?iso-8859-1?Q?PMswoSvX4AVKuysnXFsPADx8VFybmzJ5y5SoYNmM+PC5s+o0CsuDtIA24d?=
 =?iso-8859-1?Q?agJ7xuAxlwPhp7p0vXZEsw47/BnP7FSdugf+/N2wwuh8fjXNe6TKGhhxJh?=
 =?iso-8859-1?Q?y+274h/qfx68dLmhfrPOSkPUS4s152RyOw2qBMtENL+6ikhXyzDmYtkLqK?=
 =?iso-8859-1?Q?Q7EzsUU3zQyCgRxzWg8zHdRLS76JfVKzJJQfXsL7OGfQogOdQyA6az7J01?=
 =?iso-8859-1?Q?hE8KxRq4WOSMdmus7sfN+GOvN7ULJO7erIHlu13dg5JfC7dmwKtDFVP1VW?=
 =?iso-8859-1?Q?cF+gLaIZuzHzaMFWfSeoZAB/cCu8oQM3BTxHMvlxE2tAZ5hWke+QusSrLf?=
 =?iso-8859-1?Q?F3JfJ1FyRRMuwd2fFdk/WQ34nlA4/LUDUFfUX2Z5kyLUnHZ6EYCSDBnzfD?=
 =?iso-8859-1?Q?YjX9MrRxbphYv8tOP7qlXDgP/JspuZ282ke7YU1vqQF4y05ECcKaab7t2n?=
 =?iso-8859-1?Q?d1HHZSkmcgWHGVYELDfutirVyOrT571zpezTHyKGREJFAWnGWCeRmCJXdl?=
 =?iso-8859-1?Q?k8i/UyoZw/lzZlxQfqN4CUOYc4nNCyH988fCSAeQXc9EoKpDbdw4ZyoY+h?=
 =?iso-8859-1?Q?m00RRpgABtFElmY18AnA6RMXi1EjVxnJl71PxetlueiL3Ka+Dn/U9D/e+K?=
 =?iso-8859-1?Q?05Tr+f6iUVfonPP15zOy3cUy58DrtArxfADlGS6hqr39T9MD8cC67+Ki6Y?=
 =?iso-8859-1?Q?Ya93wr5bTnsHgyRZWRufJ4b2dpoD8B4CBHDaj/4R4cFiiFe8ZByt9HtevG?=
 =?iso-8859-1?Q?85WRyKIOtGqw+q2VAaqjsUiVYSeGA6gOA5PzgGkSquornvqEfwLQV6G4Ft?=
 =?iso-8859-1?Q?ugl0bsssRN6U2MP4ZbEZdnqVHynnDWLLxXAF4AEdudHh4gyEFggeZnSNOI?=
 =?iso-8859-1?Q?QXtjokeYaCyNr8bqkuPl2pm2aH9aTR5Vk1UuefB109Wm8HnwD4iy8677ig?=
 =?iso-8859-1?Q?ZCcGzPjmT10SlBRtSrUbDS/ia/OrYfZhG7boWsKKqKPvsbwN0+wWnKf/aC?=
 =?iso-8859-1?Q?fNu+eGy846oy6GuLMRiIL5LD2mEH8n+mAq34MmYVbqSL1GaGvDXOZexjHW?=
 =?iso-8859-1?Q?JXawpP0ygNTjN80BT8bs63381gs0H4AebJOXQdLe9KWKujGZBA+lTMzCcW?=
 =?iso-8859-1?Q?0QH9e54D7bE5GGt/UHWo2/Y7Pbpzu73w7k1N7NcMkk0bh2UXd4z/ZwQb2z?=
 =?iso-8859-1?Q?REiVue2T2uTf27XUMTQ8IZncl47maAb+6KJLh3zq+NcL0FaaXN+FmWwzqI?=
 =?iso-8859-1?Q?bEPnIE6qluo1C0Qim5fFlTQRBeOfWObn373ORJg3XntUhd+JaIw0?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR09MB2796.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c674841-bd84-463e-706d-08de51b9ac9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2026 09:05:03.7864 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1cKslr76AKWNRYhITetvs16IGBChjldOyo0LSqNyjmzGbcNoXWcSsU/fGDkSNv6tmLDFVFAZm8ayTYNYg38+clK84glw8xDrf4g87NBZW3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI3PR09MB8569
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

Cast CM_SIZE to uint64_t before multiplying by the loop counter
to avoid potential integer overflow.

Resolves: Coverity CID 1644076

Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 hw/riscv/cps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/cps.c b/hw/riscv/cps.c
index 86172be5b3..620f54e48a 100644
--- a/hw/riscv/cps.c
+++ b/hw/riscv/cps.c
@@ -133,7 +133,7 @@ static void riscv_cps_realize(DeviceState *dev, Error *=
*errp)
                             sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->gcr)=
, 0));
=20
     for (i =3D 0; i < num_of_clusters; i++) {
-        uint64_t cm_base =3D GLOBAL_CM_BASE + (CM_SIZE * i);
+        uint64_t cm_base =3D GLOBAL_CM_BASE + ((uint64_t)CM_SIZE * i);
         uint32_t hartid_base =3D i << MHARTID_CLUSTER_SHIFT;
         s->aplic =3D riscv_aplic_create(cm_base + AIA_PLIC_M_OFFSET,
                                       AIA_PLIC_M_SIZE,
--=20
2.34.1

