Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D03F357DA
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 10:22:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvC0n-000468-1I; Wed, 25 Feb 2026 05:20:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vvC0c-00040t-3Q; Wed, 25 Feb 2026 05:20:47 -0500
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vvC0a-0002vD-2y; Wed, 25 Feb 2026 05:20:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wum5k4kgQ92ObJlOJeGbQ2vPPV255wAMDv/w+zxSdRgbia1WjudNNuJ+a9F2M3KNCiBwWaYSo4CEW6IYNimyP9Aoe2c7jG75ULf0ITEz5YltopPCdr7FV4RA4Z5F3Fi7Ge8hp+24VwwNHxPmiwmmqvj0OOJFh9fdO7P9sDdN0Hp22pVWKSZ5V9vh9RZQTmG3MgGKipC0wTXHp2ld+uQlKpacsrdtE805JSPMs5l18MBw/LbGov+SbOeQN8KLkaTYGVBtDKRqP2mhX0nZujtsW+G7Uis81ak5DG+SetDEn/dDObJCBPEjJ/Tqwm3YLVFZjgZE5BRKiw1Qjc65Tj470g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+svpBjquN/bNS5IJFh/sbZwNXY5XVm2/hxB5e9fC3U=;
 b=GQ4pIQ2KJEyMbQH8z8AbWLzgfGaaBeyDqPAsYVcXgGB8+2OStYC/yD+qam4bngAoTFQGymPAaoVNdX7l+dkme1cGNkenrWJkEoi3JRui/ir6BnVkFvQYaaPOLdFuELqRhAtP2vnoW4n5R9KaTHCfIesX1EPo8edldGn9LRZgNa2lXEKoxvLeVv7CIy0Hp0XPx2qsrJj0NhTJFELKGRpnHyV12Zb4lcT+NGuCfiiAbwDc0J9C75hvSq5O+PR6V0Dn5L3tvCSyjtJzFlCM9G1g3VPeLvRvFFpMRTT1prt8Hg84U5X6fWcKGMJ889ZqNCay0gIPbmMLi4teeg7R5SusuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+svpBjquN/bNS5IJFh/sbZwNXY5XVm2/hxB5e9fC3U=;
 b=SZjmuiahjuVMoFqMkxrBax3zh43p0f6JpYxpqAzXL+nHSteU59eKJODnkT7gpSSqFf3J1LKIEorrT1z94/E+tvI28nqlf4uOfZlu11noMNXSSchBI60OChtBRsBXkhOKexc1BEtgpIMAvhQScrA8hJDOgkVBN+u0Vqw6PJjaqQAhql4BkIE5iX80pRjmWBLcBU8p2NlGqAWIMryLQ6pqx4PTMlzYvl6KT/xanhXy9xYtlF05ghEitOVWmvnJzemd0e/yAQTWmwkhbwWmUd5KTgXBDEl6ADji7V8VGymIkriPciAkGnr4aP+dBAp3rxrACPk4UA+rduiKzbEPqO1/pg==
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com (2603:10a6:150:358::6)
 by GVXPR09MB6845.eurprd09.prod.outlook.com (2603:10a6:150:11b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Wed, 25 Feb
 2026 10:20:30 +0000
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63]) by GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 10:20:30 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v2 10/16] config/targets: Add missing fields to BE linux-user
 targets
Thread-Topic: [PATCH v2 10/16] config/targets: Add missing fields to BE
 linux-user targets
Thread-Index: AQHcpkBc7UTIrTU4w0mkd7IrmLXboQ==
Date: Wed, 25 Feb 2026 10:20:28 +0000
Message-ID: <20260225102016.200654-11-djordje.todorovic@htecgroup.com>
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
x-ms-office365-filtering-correlation-id: 4793fecb-0568-4b1b-d170-08de745780fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: 6vt3cCBGnMj+GKUApB9l4KU2bU/Fc/P6mAYdGgQa+kB4uQIAW8d3hNG5YN86u15/RGvpcpTsVXzXuI7LrKhn+Lhwe+bCsP6Pj+PvwSW7KF23B1lmmlfFfDDR7esRSfFOy3TO/mS0o3RZkfeMh6DK9Lr+kChMCX88fF1/wviD5PkJVi7yuVg/xw0qgOHIuCCm7iSL72JMGCrMVObaT7bPVIhr4Wmx3TL8SShpaSLvt0VNvxxaDHuXhapkjFGQsolVGVr2FRm6el6qvy6qyTEqYgpPTbvjmwZ3kkuioBnihO5BMLpBxGSbtic0wX+oStsClx3Yn6n4+5i1m8gDnU3jRtCBCEl0yXK8JQ2NKVtTzmNDCqtnqANHatqFf1KyiAwPum3SCzj3wn/Ve0rzT7G9JAEpNnkjVnke+ssmWmUbIbjpsB1MT4h5jiqHbWT/EyOlIBBP4IKFQuTGSSzx4+Onxhm4zXI3JPFqQ6fExjaSbNsMF0ZAClkK/k7892gN3vi+RNRBhyb+7pPvuih7T3Mh3RTJcOZ/IDXrZx1mACx5I4XDY0j9LX6hoHAGw6b+v7dIujsCKZJ/Dox7Ao9DDXSQOMV0MQdemymQ/v7e6J6P+A4y40KnalexjCUBajrCsHdkCPfgJ7+AEwqgNBSuq1xf2WjR9+hjzyx4rKY35LMhjkunVWELz6svwvgjPm5t5l8CTjN8c+tyUbjJC3ZskGwnIUqv8NIItBGP28GVYDsSeYEv5KayhDVX/XWS8C8pxfBNIj5/YVnHpLEivYWMUTbDSaqElQXdSwmNW2c53BSV1f0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR09MB8755.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?nZhnC6vINxo7vCAjP+0sJYfvmNXhFcUsG32HxpReJFHEi48kUZ6awzQ6Jj?=
 =?iso-8859-1?Q?7bSVbXmRR+OlrexM5gavCRddMbSTWRXFXsjYU8fs3h0B2ymZvBofCHMbi7?=
 =?iso-8859-1?Q?z71gieKB8XxmWf1p4SK+uIbZpSodyUxCUzOxpwJYxXBBVGhD8bqXp9wZNc?=
 =?iso-8859-1?Q?kkkNdp+n08Xrsrdk6R/IHTxjfAdrPZe6u+rYtGCVpNoFW6bW0E/kd9ejOB?=
 =?iso-8859-1?Q?UU+kSoA0ddabkUXvdcmq1V/ujyi30CPyFSeujlZcgxCGRLFkq29QDcytb0?=
 =?iso-8859-1?Q?WxwIakQ0F5WpkYLiIz+8WFnedMn+mVlAkRcZcvjAZZwKCYI6S0afnVhbOh?=
 =?iso-8859-1?Q?rSTfYURZEp/JE/+K55JMVffr0tVwitMdXxYNsdZJzfJuUBMZaRrtU6PCZC?=
 =?iso-8859-1?Q?YFW1GOVF2JE+RxV906KP3S3Shp+WrQTPQvA0MNBFN/tRVTjEE5UK5zoYKI?=
 =?iso-8859-1?Q?XOu4NIXeNU1Sme96oEEHhXtY2jyYqN06FCreJ2/bFiMdBRZRDi9Kn8RTiO?=
 =?iso-8859-1?Q?RpTrn6IxwbnNSeSX4d7ku1dHlD7qFTdtfhidV2TlOoQ0itTpOgpAURadCE?=
 =?iso-8859-1?Q?hkmZ8kRsojV58Uw5MLdrY1D0b5iCVo024TTxgO8p9svG/7YsAFG5GprTH+?=
 =?iso-8859-1?Q?Zl2b/CpZHNi2S7OwI0Q5we6CCESUBIi9okB7pc1l0ZN/vI7K3JnM5CBSDY?=
 =?iso-8859-1?Q?x3H20qhRQVFOEQMQLnseZCn2ubEgcWLcFNRZwD1o2T1cmN/3M1dmsRPBzT?=
 =?iso-8859-1?Q?zbXRNRrdMMl9X+ypbr4BNNLxRvzeSwZP0s7USOnQOzimOIqoalR+VgW/3L?=
 =?iso-8859-1?Q?Of+SjMPP0eihU4UMoj1z00qe6V8s2c9ACSXR3Y3I1erqZyM2OowbiBJ9n7?=
 =?iso-8859-1?Q?B0a/UeSgbQICLQpyQDWKZEXWutCqwXYfNeAhvZQtDxJBW5dEWv5BJAbfOW?=
 =?iso-8859-1?Q?yKl31dnSxW1UNJOHaQ9Y+9OlyOKdFFiZ6uHjYDqeAwla2pHveJV3cBs33O?=
 =?iso-8859-1?Q?7pV44z23O9SYd5bAjRJZrUkSStr6ChUlV/V0vGcgDEP79G7OgFwgxKMTBZ?=
 =?iso-8859-1?Q?Hcxn9q2J3VxvhMuXnSy2Dn+169e1Dlqz7p24UdYz4S/efu8IohiIzAwJfs?=
 =?iso-8859-1?Q?nIi5PAu7753sRlfol1xiGEmzlj06uM6E976EOIYblVmqB2yCn8gsib2R/V?=
 =?iso-8859-1?Q?1794E+Aerlq9oqz25wF1e6yknN1Jhvg2mRIJ7lQTY1H0bF/UEKy3t1FDb8?=
 =?iso-8859-1?Q?bn5FRkefH2ItSe4NYnL+ux1uCOWq92hEipOqQnzIqgye4GQmL36QWNKNEd?=
 =?iso-8859-1?Q?T2uxFEcuUkWqX2t/u2XoctdXUDNijHgUZUYACZQzfUWYk7yrF1bSH45Uwz?=
 =?iso-8859-1?Q?4VC/F+RGxmhHfrl8FIeQgkbtTcU1o9U21y3/7UZv5fE+zFQl4vgghFvnNi?=
 =?iso-8859-1?Q?9CqLfcdodORYuMIn1V8rMs4FpLXdCbcPwcU0yZTqK7mU9AXskJfXgSSE7R?=
 =?iso-8859-1?Q?AO2Cjyi5Z9prfqfIh+UDBxIEYJ+39WB1ihb0gZv6vYxBVLIZZwJiwb8/1G?=
 =?iso-8859-1?Q?e0tSZTPjjIMt4Gry9BC41FCsNmXT+0tkQr8dbV7DKhiEvfr59GDcv+NlbR?=
 =?iso-8859-1?Q?Ueao59umIRA+L8mODKKLzbZ1b0mWmb0PscPQhfPF3k/gbqFA/g043azAJ2?=
 =?iso-8859-1?Q?BU+n7MLejMNVOPW/lS3RoTFmz4BBGGo68iFd/hrgEq99okk9KEL/QcTTBs?=
 =?iso-8859-1?Q?NLO+Z4FrdIlwmutRRrHiSTnANNdroMo+y4NeWKV2+i1/kMfxrhW8Q6rT/y?=
 =?iso-8859-1?Q?7R7aGpD4axVK7KgLt2T+VgZEMYIrrARSSzs0Gh8cHt7ogEVrsNjZ?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR09MB8755.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4793fecb-0568-4b1b-d170-08de745780fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 10:20:28.0333 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k/2k3YURNeYbBgfn94/Gso9S7imiVkZaT/62DS73zO9pFut7JsP+RnBJ6ssynSi+oshqekrUrsw2Q0o/MKDkB6XylazYZqfuUjfQIdgLpic=
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
 configs/targets/riscv32be-linux-user.mak | 4 ++++
 configs/targets/riscv64be-linux-user.mak | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/configs/targets/riscv32be-linux-user.mak b/configs/targets/ris=
cv32be-linux-user.mak
index bca84945d9..4654eb41ed 100644
--- a/configs/targets/riscv32be-linux-user.mak
+++ b/configs/targets/riscv32be-linux-user.mak
@@ -5,3 +5,7 @@ TARGET_XML_FILES=3D gdb-xml/riscv-32bit-cpu.xml gdb-xml/ris=
cv-32bit-fpu.xml gdb-xm
 CONFIG_SEMIHOSTING=3Dy
 CONFIG_ARM_COMPATIBLE_SEMIHOSTING=3Dy
 TARGET_BIG_ENDIAN=3Dy
+TARGET_SYSTBL_ABI=3D32
+TARGET_SYSTBL_ABI=3Dcommon,32,riscv,memfd_secret
+TARGET_SYSTBL=3Dsyscall.tbl
+TARGET_LONG_BITS=3D32
diff --git a/configs/targets/riscv64be-linux-user.mak b/configs/targets/ris=
cv64be-linux-user.mak
index ff4fade9ef..4217d172c4 100644
--- a/configs/targets/riscv64be-linux-user.mak
+++ b/configs/targets/riscv64be-linux-user.mak
@@ -5,3 +5,7 @@ TARGET_XML_FILES=3D gdb-xml/riscv-64bit-cpu.xml gdb-xml/ris=
cv-32bit-fpu.xml gdb-xm
 CONFIG_SEMIHOSTING=3Dy
 CONFIG_ARM_COMPATIBLE_SEMIHOSTING=3Dy
 TARGET_BIG_ENDIAN=3Dy
+TARGET_SYSTBL_ABI=3D64
+TARGET_SYSTBL_ABI=3Dcommon,64,riscv,rlimit,memfd_secret
+TARGET_SYSTBL=3Dsyscall.tbl
+TARGET_LONG_BITS=3D64
--=20
2.34.1

