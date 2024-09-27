Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8C93CDD1AE
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 13:26:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suAym-0003hf-7M; Fri, 27 Sep 2024 09:25:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1su9bk-0000y2-A9
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 07:58:00 -0400
Received: from mail-vi1eur02on2072e.outbound.protection.outlook.com
 ([2a01:111:f403:2607::72e]
 helo=EUR02-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1su9bi-0007D7-Fs
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 07:58:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dxB+AMNgAlc7Sk7nLVC43ZyTK2zM6gOKb6GiHWoegW5nbIcZmQkQPtjwhmNvxbwGBUORnpB3/Y0E+4EJcUR85OuHKStUs9UHV+8XWNGgPRKf3GWINegKk/BUpW7s2ii9giYTc/5NbBPHNgUvizZohBMNfk+umpvK8XMSJzW/gBi6hIxcIjKoTaAYeH93sksCpfAf1hxNfVMQTCQdMOBQyuD0/GgT6UfkWSWwiYNixEHe01Ror3RZnJJj9B9j+Eq+s95NQc69xMXCHwSDPnKfrMd4i8XjYJCsfVW1lWvFJLJbl5smxnEMXqelxN/fbnnjbczLBPZcpoOkMDVIu7+Xhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OBtDcolui7qciLiSwGr78Oq/7iC2cgsYAS9QeU5uywg=;
 b=IlzfFgda9r+BZccrJt8iz23JYlbwTexsEb2aBDAPWA8ueAPklOjEe8p0fxzhvcD9FAkuB8B5KN7JhYOhLoq05lpKe362VcseWp8YxAIOBp4IDkizGdu7xUeUJ94xN4cGf6LAocGoeUvBj30sR4kZ+fKl3NvrMrhwgSkj2bFMArvpR+Hu90QwLFJ8GI0GCuNZE64rww7HlR+7r8r6NwkwQ8bOiNCaEEhEjZTEX+CevL3Ck/r+EaKNdIdW1tnxtTdR3kXCcEJlbB/p/DvpjuCilxTXdfJPBq3l4te0xrT+Gt/gOlEekTrT0NOoSB2K0J5fsenRbkcJGpWpMsbo1cbTKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBtDcolui7qciLiSwGr78Oq/7iC2cgsYAS9QeU5uywg=;
 b=qC5Lj+2Z798cBKZzg+0qW3QWEvX5AXFiez0J0hUTTarOlHS8suBdSpivfRXW329xKPFHhbvIEy+5heAA4P0+y9Al5N+OK2gRgymDxXDJjwMFP+dOpdA2NBMppEvvcdJjWqXcTxbiOFklldnhQTlQ/haDtsXQF0wPnuuAfha1JtMSU17FYRqM8IciNDinNwZGdhn8+tL0bZMv2nPRZDMNSd1Jue4+psWr3hTjPd1olNSa0gq99mx31PN5wIgMJWxysXSNoXKMmL0uRvtSd1am8Z/yW4UEYtaqKbplVwwk5Ah3H9ASTyEhSkMdY7Y+xt06pOQUPERwLKoQeyh280H3+g==
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com (2603:10a6:102:ed::17)
 by GVXPR09MB7199.eurprd09.prod.outlook.com (2603:10a6:150:1b8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Fri, 27 Sep
 2024 11:57:51 +0000
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024]) by PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024%7]) with mapi id 15.20.8005.021; Fri, 27 Sep 2024
 11:57:51 +0000
From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, "cfu@mips.com"
 <cfu@mips.com>
Subject: [PATCH 1/8] Add CP0 MemoryMapID register implementation
Thread-Topic: [PATCH 1/8] Add CP0 MemoryMapID register implementation
Thread-Index: AQHbENLokkATLUJCy0qckBlOtOnxgQ==
Date: Fri, 27 Sep 2024 11:57:51 +0000
Message-ID: <PA4PR09MB4864BBA872813BA523DFA3F2846B2@PA4PR09MB4864.eurprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR09MB4864:EE_|GVXPR09MB7199:EE_
x-ms-office365-filtering-correlation-id: 0a2392f0-e170-40a9-0aaf-08dcdeeb9d13
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?ehABL6VTkbmdA0ZtkKpfTui/c1k42ZEMTP4cluxRas9XhY8tj591enD24D?=
 =?iso-8859-1?Q?ujmlYsvB5vCYVB+lCHhMnF3oCfW4jwDmNxDdVCK5+qj3YPFgwNJSHiq215?=
 =?iso-8859-1?Q?AogTiLGKqTN5Xlq1OVx8BfptGoz4QK/mE/OB5wnqj630gMACveT2De32lE?=
 =?iso-8859-1?Q?Y2kfyMKi1HpwYL4gfaLBUgjImPUn8ae033vrqGva4lK0NQCtaoO/Iii3o+?=
 =?iso-8859-1?Q?kXzUwgR3tOYHQM51fTHt5SnHzA363j5eIWF1VT/3Ye1xO/4byEl7YOuPbi?=
 =?iso-8859-1?Q?Yz5AwbHC27RTKADFyhzD+g71DueZURfaY5lqj5H7W58qyTH+9JIPPSCvYx?=
 =?iso-8859-1?Q?Hdq4PAol7Pe/Ixt6Te+F7BhZf+4mpW1SdagrjXv2j7P8yTgZ5XG8jmYE8M?=
 =?iso-8859-1?Q?M0W1GDh1fR9tWfFI2daxQVXRU7r1r+Nki4k/d1w71muknBmPY6H48JxAW0?=
 =?iso-8859-1?Q?Xrp5HItNk9uxFuZCPkJkAi5A9I7duIavPB8NixkZAlJiZKzu0/I3tTAOxJ?=
 =?iso-8859-1?Q?rOZNtl7BlOKAJXANK+2dHgkYayMAVhlVSoaOzF/4/yEtViuoW/fYoSC0/v?=
 =?iso-8859-1?Q?qQuE4eQz4EnbqcPRWSdasqMLNijLr59Jaj1ntoWb5uZ0TZlKF4TSifI4T5?=
 =?iso-8859-1?Q?y2Azatf6PMqSHrmeFK7d1B8gCpg30Gz3uIhpNmhNOM8CqaA6voUJ/L96sC?=
 =?iso-8859-1?Q?kcJkzImezSpON1g2rK5wZTZNrr8E5XB3ftwUytJf3AZH5glvii2DojpDAt?=
 =?iso-8859-1?Q?nOP4tG7SfNcsZVBp5BETaXEIkN5jBhCWBQlcs8cJ3cdjwjHxNjSpkpqbHf?=
 =?iso-8859-1?Q?w5nW6/7Cq+wbl2VVZ2iiq4Xu0Uc85RpiGTj1Ufi64In5aRW31dZZ48lb2z?=
 =?iso-8859-1?Q?XbtCW6O2BNS3bs50k7UuUHLTPiFExINm8Bipfq8YaFbDqGSpVtCQyAR4YJ?=
 =?iso-8859-1?Q?JsTS248L0hkKpqw0ikPPolQ+9an8msbr6j7FwMlpN156lZA4tTcT8PPqAY?=
 =?iso-8859-1?Q?NkpEtodpXmxFWXNd5idqkbKW7nRgkfDFJf6hIqIyxNmMMCIS0kyK7yoFTC?=
 =?iso-8859-1?Q?1/8ISi1iG9O7bS/UOUEyxtf8smv8WjObQszJf3SrY8z+mvb3t7OiQ66I6Y?=
 =?iso-8859-1?Q?NEQzqhCu1vepc7JpZSakuvDlLSOT8rJIJzUjOJm97x8qWox23VI0P4YAWl?=
 =?iso-8859-1?Q?50j31CaY6XBY2IgT7qtcZRpOC4+xhY7CZ8D6z2UJW2TgicT/Lz8Z5SS1+b?=
 =?iso-8859-1?Q?8tHGlfN3tZfvEIzdaJnpCuzp29PyrloaznulElP5TTswuBtybKi0XMW+F7?=
 =?iso-8859-1?Q?qigoXO/7sGm5d9PK18JlSCGAQFgoaGBRCgGVFIv9n2YleDYhSZ9heY3q1I?=
 =?iso-8859-1?Q?3y8Bji0OQvx2TNyAuznwVZpECtnT5H/psV0RipVDVA18+cnf7Hcpuh0zCu?=
 =?iso-8859-1?Q?DoYsk9NZa4Pbju6oPesPa+N8koL/YyxbcLD/ag=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR09MB4864.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Bx+fDP7m3whRhrYp1Zdb6a8U+CW/hS5H3T2jtcEsf5hcjuOckffGf/1suR?=
 =?iso-8859-1?Q?HAau1gOihKITIUBaIFNVIFQtw5c5gTNoR2S6YDK+DApEg/OIi1slxTWy5t?=
 =?iso-8859-1?Q?6W5W6Lwox7sreXry2uBDdgklyDxnMfHI+HU9Jby04g7btuIP2dEfVh+uUH?=
 =?iso-8859-1?Q?7X6G//THnf+YcaFwIk7l8X851D2DdCbLd6d1iy/BnZkDMAlE88VkgLSPqx?=
 =?iso-8859-1?Q?jlMnxffOktQD8ng+GgK8csjRQr0sGmNRcnONX7NvuftVMwWO+Ua9xCLy5I?=
 =?iso-8859-1?Q?2o67toCpbcJyl9ojYWzcChmvSVAN2Mbt/TblxBGCf/zcUuEyRvRtGnC0L5?=
 =?iso-8859-1?Q?MLw17Ia4t7BgKYeEpMlz1Oq3pDm6poIOdcOIZSyaaW/jd2y45rybtIJyqY?=
 =?iso-8859-1?Q?WTl2jMG2pdad/yh7MW0YOxtl0hhlCJFV2k6J8XECogH9kQ0AxWkjtpGHey?=
 =?iso-8859-1?Q?JjfJjMWWGWOphWQTp/6/K4i5f2STy9y2ItOlMBnwEiDxWs6SWfZi+XO8d/?=
 =?iso-8859-1?Q?tMDiHj41wgF2MDqWV/QLxhm0BiJfRX3fNhoA5gzIwnzp7+V/RER4T7856l?=
 =?iso-8859-1?Q?VaqwIMcwYVtdsxlqPVfPPJzEHw9J6CEdSjiNKZLW5jfRmFYMhl+kkASAFh?=
 =?iso-8859-1?Q?anNmb4N+cf+oiD6D/Ioa6tDvz4gQtrVM1M7IVsdhV0/8m7uCDLBEV7Vj/x?=
 =?iso-8859-1?Q?eLzIFF8mzgRx2fDMmKpdB0BKOmD66v+gx3OP3diHlcms4jGV7VsoHJqc+m?=
 =?iso-8859-1?Q?ell03oJpy2z2uVrny5iuIqZfemNVRnwjPphA5x+1md8oeCgIjTGTlAifHK?=
 =?iso-8859-1?Q?H38rmy7c6JeK9+zCZ5x0iLUwaPCw4rJY8zPvD5YV1fwfQYRKLNcjJqSPzN?=
 =?iso-8859-1?Q?pkT/GTDPAJAWyTjNM8toSBg9ts0i1uMtNaiwY8Ooia2O14LhdJ2oTiyOyL?=
 =?iso-8859-1?Q?pgyg8II8m6Msi16KHRrzb4hB5wPKHdgc3oBQdlecr7V0sLhB1lNN8a9fKv?=
 =?iso-8859-1?Q?lJMPlpl8xgup+p1GkCV617Gg3pssG/pBhrf87kLs5nyCpvmphNUWGONjZM?=
 =?iso-8859-1?Q?pZ5u7uehsoWwCR6UVtZfRY+Kc965wzkRTADKXhgPPLsLtFdui/YseOQMF6?=
 =?iso-8859-1?Q?cKrfg4RLXBtCnlWj6w0NmFwnnVluleMYmo7hwXoAJE7yCkAYetmco6a1FC?=
 =?iso-8859-1?Q?e+UJd3PYq8G7MvCCo6627fXccXpzEP7m5vHFBgwMlWULp69ophHWmaJ3Mf?=
 =?iso-8859-1?Q?Hot67EzZisTiiUK4LpvWKWsQYB4ORxSiQZIOmjwqoDCpj8bwNIEtthvdFU?=
 =?iso-8859-1?Q?f5LeZTGGApchDP+c8xLIZmby/CgumL1brSGylS9SXIpgwiDjFgvt9RPPvY?=
 =?iso-8859-1?Q?fIOXgMEnqnfO0DQI1txkPMjTSvmz/RQu56nY74dpDEUUO+22VgRnP2NxBg?=
 =?iso-8859-1?Q?XOb0Ib7s2+Y9po9oGn9ZCT+rJYZWmS4MRImD7SCa05hhgIP74kqntrGtSv?=
 =?iso-8859-1?Q?Hk0MuYFR1puTf8Q4MCKNPduUH92QT0V2UszK2qfqIRpOeCpzgFhJmq4xBn?=
 =?iso-8859-1?Q?yczHBKtuCwT2Ta5S3UFj8/SZ9oqYrfB20thFjUzTbaNtnDaUBI1r0vDLLz?=
 =?iso-8859-1?Q?HZqkqnHclg8nF/D0l2S45Ay5dtZyToi1Jk4cNnDXLHwD1Wu1/3ihtB9Q?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR09MB4864.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a2392f0-e170-40a9-0aaf-08dcdeeb9d13
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2024 11:57:51.3366 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ocuW5KfQ8USYul/hYyHAv9oZQTadfF6o30dEeTH+CDomzhmx26uFPy++fGndu/6sdt66NY9S3fKX6Y/aAaMb/PY1gqi5zmowlcUhZ4X4gpI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR09MB7199
Received-SPF: pass client-ip=2a01:111:f403:2607::72e;
 envelope-from=aleksandar.rakic@htecgroup.com;
 helo=EUR02-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 27 Sep 2024 09:25:47 -0400
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

Add CP0 MemoryMapID register implementation.=0A=
=0A=
Cherry-picked 9e0cb40adb110c2c76e2e97719ba8afcce72bcf5=0A=
from https://github.com/MIPS/gnutools-qemu=0A=
=0A=
Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>=0A=
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>=0A=
Signed-off-by: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>=0A=
---=0A=
 target/mips/sysemu/machine.c | 7 +++++--=0A=
 1 file changed, 5 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/target/mips/sysemu/machine.c b/target/mips/sysemu/machine.c=0A=
index 213fd637fc..91cd9f1900 100644=0A=
--- a/target/mips/sysemu/machine.c=0A=
+++ b/target/mips/sysemu/machine.c=0A=
@@ -142,6 +142,7 @@ static int get_tlb(QEMUFile *f, void *pv, size_t size,=
=0A=
     qemu_get_betls(f, &v->VPN);=0A=
     qemu_get_be32s(f, &v->PageMask);=0A=
     qemu_get_be16s(f, &v->ASID);=0A=
+    qemu_get_be32s(f, &v->MMID);=0A=
     qemu_get_be16s(f, &flags);=0A=
     v->G =3D (flags >> 10) & 1;=0A=
     v->C0 =3D (flags >> 7) & 3;=0A=
@@ -167,6 +168,7 @@ static int put_tlb(QEMUFile *f, void *pv, size_t size,=
=0A=
     r4k_tlb_t *v =3D pv;=0A=
 =0A=
     uint16_t asid =3D v->ASID;=0A=
+    uint32_t mmid =3D v->MMID;=0A=
     uint16_t flags =3D ((v->EHINV << 15) |=0A=
                       (v->RI1 << 14) |=0A=
                       (v->RI0 << 13) |=0A=
@@ -183,6 +185,7 @@ static int put_tlb(QEMUFile *f, void *pv, size_t size,=
=0A=
     qemu_put_betls(f, &v->VPN);=0A=
     qemu_put_be32s(f, &v->PageMask);=0A=
     qemu_put_be16s(f, &asid);=0A=
+    qemu_put_be32s(f, &mmid);=0A=
     qemu_put_be16s(f, &flags);=0A=
     qemu_put_be64s(f, &v->PFN[0]);=0A=
     qemu_put_be64s(f, &v->PFN[1]);=0A=
@@ -204,8 +207,8 @@ static const VMStateInfo vmstate_info_tlb =3D {=0A=
 =0A=
 static const VMStateDescription vmstate_tlb =3D {=0A=
     .name =3D "cpu/tlb",=0A=
-    .version_id =3D 2,=0A=
-    .minimum_version_id =3D 2,=0A=
+    .version_id =3D 3,=0A=
+    .minimum_version_id =3D 3,=0A=
     .fields =3D (const VMStateField[]) {=0A=
         VMSTATE_UINT32(nb_tlb, CPUMIPSTLBContext),=0A=
         VMSTATE_UINT32(tlb_in_use, CPUMIPSTLBContext),=0A=
-- =0A=
2.34.1=0A=

