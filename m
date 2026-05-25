Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB266CD5BCB
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 05:32:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRNu3-0001iz-SO; Mon, 25 May 2026 01:31:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wRNu0-0001Vl-Ku; Mon, 25 May 2026 01:31:00 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wRNtw-00038d-B9; Mon, 25 May 2026 01:30:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EVvkVXnB4HFC40mxdj/XeRFS8W5nEnGRjbCiFwQHh+vlB0mc5sXtU/aIXyvqzoGRc0wlPtAOkvIFnAhXp8Z/WH3CUelC5WICYzv4AWnCM7ex3H+B05RSbpjRr0Kc3/aMJOw4Bu2Vg/QtAwF+mDzNL00otOglMtEgIq5yx9k0jkzC4Y6pCrvexP9Q9EWANZKJmeTYtAbrylHZR85CNZ0J4epQYdhMrSaFOsDtFXATZY6cRQ9v9vt2Fu5oyMxXZBmbzbZpMNpcSPrsc3tSN8iq0nC8zrdoe7QnkeNlerA3al1SRkt/5f4i3xKbdy6VD6Ych3XgsSHQpEZg3WO/DUqWLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5pnp8FdgpurMyKcpX6hQjkNZjxzkRDDkma2rUlL2KM=;
 b=nNISIoKbj9Y5UczYHYiyW42M1duQ9154XLWvaUzyq6dCIwLSQLv04sNHW48C32zdf0Rp/2bZq6SJBTVE84XRJzNNEEtvnnhKpWG74tASVOfuTDDN/zQtVBkmQPizQmZIC0aNHaT6slvGODsXbLUINybV5n1ugX8xpMvV708/YmcnM8/d0sIG9bTxC0NI5XZtLcBrYMN3FMX5vlt8zXxoHlvleaAeJonfUkOorSETTm3eGwRJFkazefmnL/8QIz/bGCCBAkuc88+q+U8k03cEx3Wjd5pPyJV403XvN1tMBivQEJr9df9EJmhdeRs6HloCcIQkwIUvxtgFcMqxTaKECA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5pnp8FdgpurMyKcpX6hQjkNZjxzkRDDkma2rUlL2KM=;
 b=gU8xMzlBUISJ9enPPpK5lOfmC2hbjO3HT7/lrvYz82RmVV6OPAsQUytun7COZp/pAJGcX5syX5ZaQs6dXyV3G0phv67g+BjBNKG4CXwkgUMlo6O95kIi/9UplX+p04Xo2v0FtL/vgUYrgSfJbP3Zd4DizNVMEdjclRz5XZqkgj2QCTyFO2XXrk7pXGzL6eW9+0RQoELEGkYMMGhHzeZSHv0Gyh663piu2/3kwJrjTYdD8xWxTHKOLzNX5z3pegVGVhvIpijPzM/x4hyLK2CmFtbi/XabC0BpEeBGjnPOy6Lo4I9KNTSEAcxzrrVq5Hc+8sntCnYfzSvpR4TR7Nz98g==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB6657.apcprd06.prod.outlook.com (2603:1096:400:451::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 05:30:41 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 05:30:41 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 2/9] hw/arm/aspeed: Convert SRAM size definition to array
 type
Thread-Topic: [PATCH v2 2/9] hw/arm/aspeed: Convert SRAM size definition to
 array type
Thread-Index: AQHc7Aeg/P2uptVnAke6Q2f5p4gAdA==
Date: Mon, 25 May 2026 05:30:40 +0000
Message-ID: <20260525053036.3305181-3-jamin_lin@aspeedtech.com>
References: <20260525053036.3305181-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260525053036.3305181-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYZPR06MB6657:EE_
x-ms-office365-filtering-correlation-id: de0b5f3d-32dc-45b8-b6d7-08deba1ec2ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003|38070700021|921020;
x-microsoft-antispam-message-info: hrGsTKJGpuBualoDTGkHXkxAvYs8nGtkNOiJ4cRUN7aihSzJOukxfyfA+KpOg82ClVdDBbbofkVUhsxXfCJIsdbqoGnmeC6ep6t67jkjY+MNeTZ+7S4gxbPHeEGwoSrzP44KZcAbazDJT3N67GPQkTM13/DnmAtfh3JoBk2YYbI0Xqe1+aDHPWJQvmsiiu7YDaqtmfSE1ayPXtuq6SWWrSQIjTWNMfWQ5uCxTuwDNUmsKaceD1A09jFyIm/FcVqMKvGCUbQOe8KyK5aKCbQudWyOTuYznGW/lcZACLbyPmT7mu72EXYiDF9ozGCyBRtmuY4cabeFDwsP8boRkVQdqsyS7aAEbIcPiTO1+6ZK2qPeJkqdDcRn0f8Qqq2PDxNr3OWtl4CFFeNoQ48xFmbB3fNDVVcpO8X1FqNtgswk0vb7Mb8XW6c2TTVLZfYvZpg1Kv5opm3TFwcBX2ut1hhWsnQysihC252kDTSkAsItFlcmWPXHd2mdYpzoELADVOmUZU0QGGxnaFlvnArA02o9T1fyPTKVxlIaa6tKN7NzPs3fRbYsM5fZedjc9gy/hEunNfp5g2T2HLfmidkP+rk8ioXRJ9sH7Elg9VqciF5hAamTDpU9bIFHmCs6Wskul6Prm5tPEE/zCNjxrXrXod6LBlNzxHygHy8mAh4XWt1fCrY30zOZE9w8sR0yMrUnt+GI+BGkArlnuka/mocrqXyZMfxHm14ZUQ43x5mBS1yXe5s6To+Fhks99xJ5xTeX4vaIcfl0P5kuUuo+8e1eWIOvbQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tsC8PtSb6VO7ohc1HQDg+mu22Wl9G3n2Mhe1iLCnpBUOj6ppznrDFYTYXo?=
 =?iso-8859-1?Q?uVpopfmLOXebZhoP7DHWmuogvkMdjnbZXNbAYPIhBWYzb5CjXGhmHyQIsA?=
 =?iso-8859-1?Q?ikPEtXlvyiHsbHTiIuKU5pV6um+TEKcIdhdfpcDbIs7g+zlbtiH1cb7/KW?=
 =?iso-8859-1?Q?WU3N95fOERuFWBd0QIbAS1CytpyUrK8gFFKy29SN4bGhaHdxZZd07XSlK9?=
 =?iso-8859-1?Q?K/Fbz9h9xQjUhiVt6lczCoIEPZSXArwmrf7joWqnONyISwjucOaO6ifC2N?=
 =?iso-8859-1?Q?nhQNOB9IlL0hRpMMvxaNJqus0P+XfsqakCLgQwc1xSP6+YCPmlumAu/MyJ?=
 =?iso-8859-1?Q?ly+AIlxl2y52ufLv0k2RL0dk3fotGMT/qlEDNy1CudSEUj1/a18WF3lnyL?=
 =?iso-8859-1?Q?NaY6ZMzX3OfDWqsyTy5fUSQkZzbkVplm8rIdMCck3OakGXqmIJ5b0LvuFM?=
 =?iso-8859-1?Q?XtMx3aarqIyaMG2ge+dhl9jJ4PaBjIk+JAQUAxyxDRfa94PoyE19RHQJu3?=
 =?iso-8859-1?Q?6LgtC8AedOa6/JK6yQRv8un0MsYvm4R4X2f1ZWv6tswQ7ePgvld/hzbhcH?=
 =?iso-8859-1?Q?b/9ZLl9odAGR5Joxp5WAJGmU6g0YX2JI0JG4qT6WXAY8FRWJd6QV2g7vpo?=
 =?iso-8859-1?Q?lguRQmRUPoTFA3xPC4GXBxacs4uUfCrn5iyLUuPhmXYSnBhNeKrx1Cy9M0?=
 =?iso-8859-1?Q?LRUhzDmoqc3qeTDLpWEy7vf3P1YyyWvtuJe+9SZbSA23gcAxZnbrEr+/ew?=
 =?iso-8859-1?Q?KUQAmDNjPvmZFdk16SVLprYVSgjcDuaH6bTtR1mOnxp/1A/9iP4RWqGtuU?=
 =?iso-8859-1?Q?iBpHytRqrF87JtYjUmO7rAOhVHWQGj10mVvOEk7FzKMV3w0D1eWhiB1VMB?=
 =?iso-8859-1?Q?VFWi9r788pzH8XTD5dGvu+Ccubrd5gJ++WWXE5S/qE7k/qTnKEXvRzIMe1?=
 =?iso-8859-1?Q?96JIOb5Vn02zniWJfD++5Orlvy1WvxN1TIhp3DBHwyjS/A7I1lrCvTZp5P?=
 =?iso-8859-1?Q?p+IHSBmBXSDAMBITtt1lFl5C4Ls4zGraCuL2YAzD7dNgp/CFOE2AQrOqUk?=
 =?iso-8859-1?Q?K/plv36Mc2dZzMCFe/0Yf0CXR2Z6E8aj+9wmve5HXFVSyPBJAIdWhCm06G?=
 =?iso-8859-1?Q?fr3d2Oi1Nx4Fts6lsaQn9vAPA1FQVFwNq7wlJDR6patwRpdpd7+Od40+to?=
 =?iso-8859-1?Q?cC+hhsO67t86wi/YReUbLS77D3eaJXZOc6Y3CHE0FNu0VPnsWDLmRqGRZD?=
 =?iso-8859-1?Q?cDvCGeXGNawQmADaGLxuP42DO3RbvmlWH2yXDaAXTQO2Mo1pMdDr+iUXgs?=
 =?iso-8859-1?Q?zcrrJISllNFEMh8WrPrEEYAZtsewuqBAIAfhF1A/lloXlwj24WeAxiwb2q?=
 =?iso-8859-1?Q?yV+2OEN2AbVGqNsl5XtyZz6ppIW6AkqxGKLSPiAB3Fmm0gHw88eNRsepi1?=
 =?iso-8859-1?Q?m1EhO2Oc5wbZyVvwOyAwPu/XYT+brlc9DCbawS6CE0LhW3vFz/ijExcPOr?=
 =?iso-8859-1?Q?OsscNEgv1HdcsMKj0qWTvl1jFJ+ecvMEyV4nH9J4jDFXu19FBuzXl1Npy6?=
 =?iso-8859-1?Q?AocIkiBPCZApb1DwWZaZNR5IxZMRUHcfxVpnLn5KNAf5GmUybCb6vjjm9h?=
 =?iso-8859-1?Q?HhZKImzabvcqF2pTdkOEeEw69a9IBj3qqcVBeYTlqe2xfl913l1d7JgWur?=
 =?iso-8859-1?Q?1QAVtqvCvcR8iilZCZam3DQU5aUXWNUG4W5pwJ+A8e+HDC24FKYkDLNHbO?=
 =?iso-8859-1?Q?u8KCn/vwLzKlZKjrdlwyiM/8XzhyF7BDhuwvBj6tGuXG3R9QiK8WaOLsyS?=
 =?iso-8859-1?Q?7RUlCcNzLg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: SAwVw/wj3YaMy2um25E6M5cOfx/LwcdARNo4Pd/9BuUjbC89f+t1j73pR9XSU+AvNaWnp8xNwJWQOWf+E8YxJHV6PtcQKxvS+46iZZ3EK19xEfwnLlJuYbewr+8Pk0GXANCtufS3Ag1ygPlkSRXxFdL3kskECmCuCvw8DTZ0nLe/O/fiK3pgPDOAiEycUeHzuhMK2iWuRbvwKu6gG+6jK+ujyUdgFD4GktE1wLB83ukX8yyXBiKLzzVB+K27En//M14Fvo9tmm/E9yfKF26vBNWRERkvS18P6PU294uKQ2il53ikqHG9vgZR19HQDb5uy6H5xnnVmb2NBjMYx7pqjw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de0b5f3d-32dc-45b8-b6d7-08deba1ec2ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 05:30:40.9164 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3kBPiWmoMvTGcrklKqNMwTsOIf3NhbJ12mr+yS0hYiIwq1nmdDEeB7p1Mrs4TJ6GpvGzg9w1WCIetr5YKX9xhNyWuWsf4kEDn4NCyHUcsJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6657
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Prepare the Aspeed SoC model for future platforms that may contain=0A=
multiple SRAM regions with different sizes and MMIO mappings.=0A=
=0A=
The current implementation stores SRAM size information in a single=0A=
sram_size field, which limits extensibility when additional SRAM=0A=
instances are introduced.=0A=
=0A=
Convert sram_size into an array-based definition and update all=0A=
existing users to reference sram_size[0]. This aligns with the=0A=
previous SRAM MemoryRegion array conversion and provides a scalable=0A=
foundation for supporting multiple SRAM regions in future SoCs.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/arm/aspeed_soc.h | 2 +-=0A=
 hw/arm/aspeed_ast10x0.c     | 8 ++++----=0A=
 hw/arm/aspeed_ast2400.c     | 6 +++---=0A=
 hw/arm/aspeed_ast2600.c     | 4 ++--=0A=
 hw/arm/aspeed_ast27x0.c     | 8 ++++----=0A=
 5 files changed, 14 insertions(+), 14 deletions(-)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h=0A=
index e6942b2936..3a7db959a9 100644=0A=
--- a/include/hw/arm/aspeed_soc.h=0A=
+++ b/include/hw/arm/aspeed_soc.h=0A=
@@ -172,7 +172,7 @@ struct AspeedSoCClass {=0A=
     /** valid_cpu_types: NULL terminated array of a single CPU type. */=0A=
     const char * const *valid_cpu_types;=0A=
     uint32_t silicon_rev;=0A=
-    uint64_t sram_size;=0A=
+    uint64_t sram_size[ASPEED_SRAM_NUM];=0A=
     uint64_t secsram_size;=0A=
     int pcie_num;=0A=
     int spis_num;=0A=
diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c=0A=
index 3e478f7520..9e597a75ec 100644=0A=
--- a/hw/arm/aspeed_ast10x0.c=0A=
+++ b/hw/arm/aspeed_ast10x0.c=0A=
@@ -240,8 +240,8 @@ static bool aspeed_soc_ast10x0_realize(Aspeed10x0SoCSta=
te *a, Error **errp)=0A=
     /* Internal SRAM */=0A=
     sram_name =3D g_strdup_printf("aspeed.sram.%d",=0A=
                                 CPU(a->armv7m.cpu)->cpu_index);=0A=
-    memory_region_init_ram(&s->sram[0], OBJECT(s), sram_name, sc->sram_siz=
e,=0A=
-                           &err);=0A=
+    memory_region_init_ram(&s->sram[0], OBJECT(s), sram_name,=0A=
+                           sc->sram_size[0], &err);=0A=
     if (err !=3D NULL) {=0A=
         error_propagate(errp, err);=0A=
         return false;=0A=
@@ -493,7 +493,7 @@ static void aspeed_soc_ast1030_class_init(ObjectClass *=
klass, const void *data)=0A=
 =0A=
     sc->valid_cpu_types =3D valid_cpu_types;=0A=
     sc->silicon_rev =3D AST1030_A1_SILICON_REV;=0A=
-    sc->sram_size =3D 0xc0000;=0A=
+    sc->sram_size[0] =3D 0xc0000;=0A=
     sc->secsram_size =3D 0x40000; /* 256 * KiB */=0A=
     sc->spis_num =3D 2;=0A=
     sc->ehcis_num =3D 0;=0A=
@@ -521,7 +521,7 @@ static void aspeed_soc_ast1060_class_init(ObjectClass *=
klass, const void *data)=0A=
 =0A=
     sc->valid_cpu_types =3D valid_cpu_types;=0A=
     sc->silicon_rev =3D AST1060_A2_SILICON_REV;=0A=
-    sc->sram_size =3D 0xc0000;=0A=
+    sc->sram_size[0] =3D 0xc0000;=0A=
     sc->secsram_size =3D 0x40000; /* 256 * KiB */=0A=
     sc->spis_num =3D 2;=0A=
     sc->wdts_num =3D 4;=0A=
diff --git a/hw/arm/aspeed_ast2400.c b/hw/arm/aspeed_ast2400.c=0A=
index d79aa832f3..c4e5388999 100644=0A=
--- a/hw/arm/aspeed_ast2400.c=0A=
+++ b/hw/arm/aspeed_ast2400.c=0A=
@@ -282,7 +282,7 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev=
, Error **errp)=0A=
     /* SRAM */=0A=
     sram_name =3D g_strdup_printf("aspeed.sram.%d", CPU(&a->cpu[0])->cpu_i=
ndex);=0A=
     if (!memory_region_init_ram(&s->sram[0], OBJECT(s), sram_name,=0A=
-                                sc->sram_size, errp)) {=0A=
+                                sc->sram_size[0], errp)) {=0A=
         return;=0A=
     }=0A=
     memory_region_add_subregion(s->memory,=0A=
@@ -533,7 +533,7 @@ static void aspeed_soc_ast2400_class_init(ObjectClass *=
oc, const void *data)=0A=
 =0A=
     sc->valid_cpu_types =3D valid_cpu_types;=0A=
     sc->silicon_rev  =3D AST2400_A1_SILICON_REV;=0A=
-    sc->sram_size    =3D 0x8000;=0A=
+    sc->sram_size[0] =3D 0x8000;=0A=
     sc->spis_num     =3D 1;=0A=
     sc->ehcis_num    =3D 1;=0A=
     sc->wdts_num     =3D 2;=0A=
@@ -560,7 +560,7 @@ static void aspeed_soc_ast2500_class_init(ObjectClass *=
oc, const void *data)=0A=
 =0A=
     sc->valid_cpu_types =3D valid_cpu_types;=0A=
     sc->silicon_rev  =3D AST2500_A1_SILICON_REV;=0A=
-    sc->sram_size    =3D 0x9000;=0A=
+    sc->sram_size[0] =3D 0x9000;=0A=
     sc->spis_num     =3D 2;=0A=
     sc->ehcis_num    =3D 2;=0A=
     sc->wdts_num     =3D 3;=0A=
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c=0A=
index a69103de89..2f8f49a376 100644=0A=
--- a/hw/arm/aspeed_ast2600.c=0A=
+++ b/hw/arm/aspeed_ast2600.c=0A=
@@ -438,7 +438,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev=
, Error **errp)=0A=
     /* SRAM */=0A=
     sram_name =3D g_strdup_printf("aspeed.sram.%d", CPU(&a->cpu[0])->cpu_i=
ndex);=0A=
     if (!memory_region_init_ram(&s->sram[0], OBJECT(s), sram_name,=0A=
-                                sc->sram_size, errp)) {=0A=
+                                sc->sram_size[0], errp)) {=0A=
         return;=0A=
     }=0A=
     memory_region_add_subregion(s->memory,=0A=
@@ -764,7 +764,7 @@ static void aspeed_soc_ast2600_class_init(ObjectClass *=
oc, const void *data)=0A=
 =0A=
     sc->valid_cpu_types =3D valid_cpu_types;=0A=
     sc->silicon_rev  =3D AST2600_A3_SILICON_REV;=0A=
-    sc->sram_size    =3D 0x16400;=0A=
+    sc->sram_size[0] =3D 0x16400;=0A=
     sc->spis_num     =3D 2;=0A=
     sc->ehcis_num    =3D 2;=0A=
     sc->wdts_num     =3D 4;=0A=
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c=0A=
index 0fb5e4b24c..30883ea7ce 100644=0A=
--- a/hw/arm/aspeed_ast27x0.c=0A=
+++ b/hw/arm/aspeed_ast27x0.c=0A=
@@ -778,8 +778,8 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev=
, Error **errp)=0A=
 =0A=
     /* SRAM */=0A=
     name =3D g_strdup_printf("aspeed.sram.%d", CPU(&a->cpu[0])->cpu_index)=
;=0A=
-    if (!memory_region_init_ram(&s->sram[0], OBJECT(s), name, sc->sram_siz=
e,=0A=
-                                errp)) {=0A=
+    if (!memory_region_init_ram(&s->sram[0], OBJECT(s), name,=0A=
+                                sc->sram_size[0], errp)) {=0A=
         return;=0A=
     }=0A=
     memory_region_add_subregion(s->memory,=0A=
@@ -1151,7 +1151,7 @@ static void aspeed_soc_ast2700a1_class_init(ObjectCla=
ss *oc, const void *data)=0A=
 =0A=
     sc->valid_cpu_types =3D valid_cpu_types;=0A=
     sc->silicon_rev  =3D AST2700_A1_SILICON_REV;=0A=
-    sc->sram_size    =3D 0x20000;=0A=
+    sc->sram_size[0] =3D 0x20000;=0A=
     sc->pcie_num     =3D 3;=0A=
     sc->spis_num     =3D 3;=0A=
     sc->sgpio_num    =3D 2;=0A=
@@ -1181,7 +1181,7 @@ static void aspeed_soc_ast2700a2_class_init(ObjectCla=
ss *oc, const void *data)=0A=
 =0A=
     sc->valid_cpu_types =3D valid_cpu_types;=0A=
     sc->silicon_rev  =3D AST2700_A2_SILICON_REV;=0A=
-    sc->sram_size    =3D 0x20000;=0A=
+    sc->sram_size[0] =3D 0x20000;=0A=
     sc->pcie_num     =3D 3;=0A=
     sc->spis_num     =3D 3;=0A=
     sc->sgpio_num    =3D 2;=0A=
-- =0A=
2.43.0=0A=

