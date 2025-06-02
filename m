Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B88B7C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 13:14:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM4yH-0008Aw-Lq; Mon, 02 Jun 2025 09:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uM4yF-0008AK-Oo; Mon, 02 Jun 2025 09:12:56 -0400
Received: from mail-westeuropeazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c201::7] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uM4yD-0002Ae-Vr; Mon, 02 Jun 2025 09:12:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pZ8HzGxfI7o0ccZAIPCIMdqzQ1RKUE1vLNznLLtH6ieNHSTdGy9sI4Suyf5VKKRb6Ilk5ShUJZQGX0ZaX6fU9xUEnLiA2DtwTRAIxDUTn+AuYh54Ywxk0FbupqgNpyDjt02XfrgPlWemRBJD/EcqbE47LKsHu7ATtWu0BxrjYmL+d+FmuOyTWR3SGUc8QUN+ktahqbap/wprX0b1r+OvSi9AuKsbV78jOAd0bNGz9whY1/XWkWUPhxe193YQmQKpZ5yUNr1uy3PeUD4gIY8OD9j9/5ax9kyFIl9p+72g9vVF33aQXrVHT0Rr7Fl7ba2LXQZG3Wen0xE+hgdUbScRbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46uHK9FGyiiI3phwc/LBD24Vq6SLRoxGrYYnQi5Ue8Y=;
 b=aLILZSFCFF/58zReynE04B/6TFLzNmIJmkmtTLXttyh5EoWJJLH2RHjJVE1lft3TS6fuJEm4HasmD1+IKKZPbAAucXiYOSjxUrfNZJrtdfzj94oyaoD7huP+GM5V92HKNhmNl5v5A5QXHceyTAmmT0/Xtraqm3dxamCw8e634O/AEkEiZ5teP/P/JHPpC8eFCsR0pQI/4RYDwRlp3BsqjBlFMBB0fd7q0frXsSL9LCB9Xiim99tK2UYwxPtMd1WMQD/SN1iAt47wnHPwhGra5c9H+69UxWB3v7ZuSatNrxGHMF9qi7xjOgUAf7Frw7oQ2jVi5dErPMVGUuyS9Z9whQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46uHK9FGyiiI3phwc/LBD24Vq6SLRoxGrYYnQi5Ue8Y=;
 b=NB9FMP1jK0G/ysLQNN+kJ3lop2aUzOgA5Yaww/xuU0KiGFpr+YkDnYhW3rR8ew7JL6yOl3thrdsD5GjZ0z+LeIkcU0+tX+w3xRreYIRoRwTr6jezeepd4ZVFMnTiZxnVLVaIDwd5wN+c7b+pg63f1APSO+P8kVhbrPgMN9f0BY8JdUqYyrfNgERSKp5DmBsFP3LKLonlMK7FdciJJitOqdA+r1DE+xOxVhqhUD5ZlhoGqJ0f24qyCr5YQo1rmmgGQVXOS0ZIE7quy1d4k2WQPh/E3hY/AjHZ8S8DFAnUveiQ/vZCJMJV24atlTQJdc5Wpn5Z3Z2fwAMI8MwCYEUHEA==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by PAWPR09MB6728.eurprd09.prod.outlook.com (2603:10a6:102:383::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Mon, 2 Jun
 2025 13:12:35 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%3]) with mapi id 15.20.8746.030; Mon, 2 Jun 2025
 13:12:35 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v2 2/9] target/riscv: Add cpu_set_exception_base
Thread-Topic: [PATCH v2 2/9] target/riscv: Add cpu_set_exception_base
Thread-Index: AQHb08ABNSS0HB2yL0i6yLz6ZnvaMg==
Date: Mon, 2 Jun 2025 13:12:35 +0000
Message-ID: <20250602131226.1137281-3-djordje.todorovic@htecgroup.com>
References: <20250602131226.1137281-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250602131226.1137281-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|PAWPR09MB6728:EE_
x-ms-office365-filtering-correlation-id: 8fe7e201-7708-409a-98d9-08dda1d72436
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?b9znwc93onM3QmD3ZclhwKB2XZc98F4dKEnGWonzRPS3+mQYLFNJBHfnJL?=
 =?iso-8859-1?Q?fGKXiyFtvhKsGOAZWvwHtddZ/b7XpyaPaIy1PP8XDwVD/lEZo1S0v8VhaX?=
 =?iso-8859-1?Q?0abS0l4qDanpUPAIBuFsr9r3eUonYAIsTnCfFqoAsAzZ5QZVGt2QCPasJR?=
 =?iso-8859-1?Q?QSz0q3WyW5Xj0tFWQzyWqKJOCUG93RdyN0bYvtkWRhpPV8hXPspzERdDoa?=
 =?iso-8859-1?Q?DqwQqVe+gsPqRGpb/QHqUHdoRIR/pVe0lSoYe+WG0/Ktt17o829QIj8cTQ?=
 =?iso-8859-1?Q?TKAOxLYn+YRJdx7wSX3ebpDNLpfOt+juDmop2vf34kiPk9YjC5jHNPUUXv?=
 =?iso-8859-1?Q?0MMIFHYUSqs7dtSIoID5mABKPWkk3FuDfFrymynHrvQLrpJPER1zmiz1W3?=
 =?iso-8859-1?Q?IG7DS9BApzFzgpgZhrdk7isBXoqACwuwXsFXXTRM/hIIPdmogiCUNdnIvs?=
 =?iso-8859-1?Q?Ponm+UsTTjgIdjeEwMXMI7aXogdSBO1iC0XGJvhGcMMbLLquoORaL917Lb?=
 =?iso-8859-1?Q?BFtQlQaL5xh0eqq5peEPaIPYGnkS6UA3Hl7JWsciOhRXyRlr1+eaSUvuDq?=
 =?iso-8859-1?Q?rjFMS8L/4sN/y6V+2ZohurAdoxm5mOUb6SEfSzoUc4Bcr+pBQPKbFfpE+e?=
 =?iso-8859-1?Q?zom+/Uzzvqf0tEjP3LuwysfUVhlP5Yk0bW04z+BasaopqAQwQ+VAabpsH2?=
 =?iso-8859-1?Q?y+s0Cuh8kwaP7LFm1i+a2rzUDGh4VMZyClghrCtRlYrvVH6oLzAIo1ZaYy?=
 =?iso-8859-1?Q?7ucpZM3pmD8TfiEL06PUkD8l1sW8ls4Oo4DlHDJ4sV99gmnhBILp/W+qqy?=
 =?iso-8859-1?Q?Ii13+vimMX0wdtGU+tefJqoKw38HPkhEha8vVdthRi9nK8cgiJd5BynVU+?=
 =?iso-8859-1?Q?EZj5umrgEdJSyBNzH/iATxXHj9btu822j2pTKFGopovdrlmmY8Aaeq6C/2?=
 =?iso-8859-1?Q?3Hv7YZEHwGJ+0qAIODtJXYY2BUwhOcP7a3M37sY5XdQ268uVf73ZksyuDi?=
 =?iso-8859-1?Q?UBGDJ7nkUexOps3l0W6CEBRT9nDOBrRfQgzvRODJa3dS1Q/ytpMMNckcTr?=
 =?iso-8859-1?Q?n6EQluOdztyXdWU1XD7jREi3N0tcbGdV4Y1wyKkbvRF0bUmdfxCldBCOCe?=
 =?iso-8859-1?Q?OFrppR6WHCBv/i3wsP6Udb8/pLc/AwFOwoMx9vK0EOPn0G7q4TmEzQ0ixO?=
 =?iso-8859-1?Q?4JA3brOCxvOdeR0kMGADoINdppMzPX8wsWy3xH0Grznqc5e7NwXeORoVRm?=
 =?iso-8859-1?Q?v5GkgYMIsmSpxdI+/hag0xbaOmaHV/wO4AB8kl3FYTBUxb2Pw2kccDsyRs?=
 =?iso-8859-1?Q?m7unCO1ePJZmknY/wAaOSvWcgRE+FZXHjjFcxNysKgOUK1RuocvSF7kEtb?=
 =?iso-8859-1?Q?pe66a0DUDiS5FIZXqVlsG/OXmJMpVPapVgi1P6DC7pUKEhEbY5bxVe6Msw?=
 =?iso-8859-1?Q?HVQGT6+AmfWSWvo7dAc6xOzMu5NOFNPQCHJk32Kx6ofBufUBal0YQlbBbJ?=
 =?iso-8859-1?Q?4yI014zZjK/GOaeQMUREESoWt7SBQKP9303GjQDkkn9YAyEOgSBaRQw/m5?=
 =?iso-8859-1?Q?pvxXiko=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tU8TbKYZ2nImdiXlqcnaeLz+Z4xZk/OCFFjMom4v/1UelSh53NnPFKmqN5?=
 =?iso-8859-1?Q?rZpb4n30lrASU6q0F3PCzxfZMhLwh29CFNOJIbzO6Rcij2oEEHsNpykNoV?=
 =?iso-8859-1?Q?oPKLSm0dj93jbJxyxNCwvQ0kxjJVSuvWKYOAJ967jjxEqRfbmGC0yN3QZc?=
 =?iso-8859-1?Q?N2k8Iu67SmdVh/shui0fOjy24FHVpiIDQYqGykku/QOyNXSKweSXuR/iHJ?=
 =?iso-8859-1?Q?0l3oQ7mudSRx037Ezv9rSLKYfPhjTggxI/dn4z7WqCeO7SCrkOiDyuKXUR?=
 =?iso-8859-1?Q?AWoEwzsIG4lKrfeVsrVnc30y5+Lt9gErTteXVuLdAj8VpOBXqFkb1Pqv8Y?=
 =?iso-8859-1?Q?Wmwila3wU0zJuuZzoO+6u4FQnCU7ShU9mOmRVwaWzWEPtuyV57rQeOrYv1?=
 =?iso-8859-1?Q?LfIudgOEB4vaQHj709qxMN883PgKWze/npOvHxY0JHGupibYHsK52UKUC/?=
 =?iso-8859-1?Q?6A3oMutk0peBNi099einCjf4rLnIhBwPEVn/ivDkSr3Z5aw8MpKs5nkW+b?=
 =?iso-8859-1?Q?uxe4P5MHongmEbwZ9fWFCJyvD1Gi813EjLxFI6WHsAp0US3Vx/IUgx0TYG?=
 =?iso-8859-1?Q?h1bSqGN1cHt4KjFKUvTW2i+I53SAzeNomPzeN6GYD0sCmoY6c1BeQvNkSG?=
 =?iso-8859-1?Q?KIET7yHO1j8DyOVq/PuRodr6v4/plZQsLHEpIfwRoCrZNxKSOThiWbDaUs?=
 =?iso-8859-1?Q?6FQ5lK9URrMQ1qdEAw3wunBIP10bHStYG+WCbVWvtu36I2pP9v7LQFaF2L?=
 =?iso-8859-1?Q?XM+PySEn7vk+w/cwFib7TRNdb6ii0d+94m3AkiHL26eeDIiIWA/dGZWij2?=
 =?iso-8859-1?Q?7QmzYIjSHxY0hw/pMmrAY84N3KiGOvodMfQYZa7bdpB70p+nm0oOADTVCa?=
 =?iso-8859-1?Q?tedd3olhN2GQypF/3Gzwrt54bgaIgsdztX686pHP5PxIGepf2bc4WUqqF5?=
 =?iso-8859-1?Q?19qwDr/9O9i5QbI1BUbFKDDRZT8Mr9bqoy9qjUNsBceOjA7jxl0zca5r9L?=
 =?iso-8859-1?Q?EmpgiAQHhX95o+A9b1c2FRTSUL2lSomtwoLaFoaQYHfRogRsdRo6XeAlkT?=
 =?iso-8859-1?Q?V/QOYX0JUje77NcB1mmWhYAuuaQVpNohbxp/gysqQuRzLkV1p7DjawYlGL?=
 =?iso-8859-1?Q?QSIcU3QXUJC48kYSw1uGtru8VkXIX8/5z8vlSc29ui2OhDYBJdUsoX7Il/?=
 =?iso-8859-1?Q?dfIcWN3+qQt+4Ps9P1I4IfzDSl4XYoWJLDw83VjJ/wDw8JZrPQbAa/OCUi?=
 =?iso-8859-1?Q?U/8aSQY6gYzGIx+fnsH8sTeedMnseZ8h5GUWtbbQUDkRTygqd4O0PaQdq8?=
 =?iso-8859-1?Q?LIU7Rbv4qIDX32rwEWe5Qlv/KBHsJXEST5eDWmJOAbEtwU0VpQh0v1iMNc?=
 =?iso-8859-1?Q?Akz+7H63Tl3l77/asr1RQ9jFnM0WeOMNVI6Ej1gHhlMHUZRuT600kfHGxv?=
 =?iso-8859-1?Q?NEN7sFWS11jHneHudIhq0nxPxwnWUdVjc/KAdej8jUZJWWQP3ekGhUw1b8?=
 =?iso-8859-1?Q?GjmzZj+4ttmsi0pmCg/vyHg1QDip2V4AYAzWll25BvFjeZEbX7ztPgvqbM?=
 =?iso-8859-1?Q?k7NpbSNjHo0u9NM/JOpwqnWPnZNW5GgwzUfKw9YJGbiq2gDaNo97DoS2E4?=
 =?iso-8859-1?Q?0bp3Ow2sjSxkciLJOaPiRA3NUoAMZWewaOqWgI/hWsN2u/Y8L1jPXwkyXy?=
 =?iso-8859-1?Q?49prgDd4vG29FAZShoQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fe7e201-7708-409a-98d9-08dda1d72436
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2025 13:12:35.0873 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hAnHuo4Lznqj0xtOXDGDsy4Mm+nLNipLtvNiEcA4uAPbjRQ76GPC9shSA+nfINN+r+FebPwDOLhVNc5duNp8VQc9yXTqYaI4USN8K2XMqSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR09MB6728
Received-SPF: pass client-ip=2a01:111:f403:c201::7;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
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

Add a new function, so we can change reset vector from platforms.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 target/riscv/cpu.h       | 2 ++
 target/riscv/translate.c | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 229ade9ed9..c0e048a66d 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -656,6 +656,8 @@ G_NORETURN void riscv_raise_exception(CPURISCVState *en=
v,
 target_ulong riscv_cpu_get_fflags(CPURISCVState *env);
 void riscv_cpu_set_fflags(CPURISCVState *env, target_ulong);
=20
+void cpu_set_exception_base(int vp_index, target_ulong address);
+
 FIELD(TB_FLAGS, MEM_IDX, 0, 3)
 FIELD(TB_FLAGS, FS, 3, 2)
 /* Vector flags */
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index d7a6de02df..2cba1a26a7 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1427,3 +1427,11 @@ void riscv_translate_init(void)
     load_val =3D tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, load_=
val),
                              "load_val");
 }
+
+void cpu_set_exception_base(int vp_index, target_ulong address)
+{
+#ifndef CONFIG_USER_ONLY
+    RISCVCPU *vp =3D RISCV_CPU(qemu_get_cpu(vp_index));
+    vp->env.resetvec =3D address;
+#endif
+}
--=20
2.34.1

