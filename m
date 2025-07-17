Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE3FC83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 10:01:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucLFm-00024v-Im; Thu, 17 Jul 2025 05:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ucL4s-0006Nj-GD; Thu, 17 Jul 2025 05:38:58 -0400
Received: from mail-westeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c201::5] helo=AS8PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ucL4o-0002Os-R9; Thu, 17 Jul 2025 05:38:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UeTvytqxldvVH8LxUj/3hcRgkArISum+Cl9wjk0pD+HkKApJG/XMz52NORhOQvscePWl2KUChAkLsO/+yNIC5aqQknWQjIukLqmccP3mXxE5TijSTiRI55SFGCZk3B20td+1o7yQ8rRHFPvWGU3e8EqNAG4qnjaig22QG18wxlmU2tYm0w18xMDv43SrNscDFG0qMVw2HX24J+4qSXJ3+J4ecr/UcIv0z/Aw27zOolZAiGDPrri8O+dHD9CGNglwS9PqU3cRPpOLkxSreLp/zuBqY3bNXs3mCeSI6/QdYHmwhhdsjBBEhQ4kjI0ndQm9CrlchW9mrvZvkCM/L+ssSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uRr2c3D3bIyYK0NNeoV1tvmHbyTBdSIHGDWLq4CpIuA=;
 b=Hkwxzk8o8rzzt23vTjA3nYofmP7OF06YpCOUcuh8OODFdOAesFSyBFGtB1v0PeXPESRVFKgQ8SHWIYiaVsb26nNgD+A32wcieVdNgsRn0qEIZZRd11y4ut4A3w/erGcZWvRDniFpRSSl9nEjhKgSIGXOpC1Jf1hPaMPmhDjOMhcUZ2b7ehxmUkeBPQF24+TAiuLIjTmdSFV1bkNk+SAMVyyP7bB98rS8Im/mcftVxGlxEeoZ6TGrLJnbU2AXhw4fsMZg0NZWzGaM3rRcpLrjNQuIhSpIjGGWYJItRZpF4I1k5T5q5s8wpAR7uoFBQKgKC15IXTHSVUHVuaTq+nk0Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uRr2c3D3bIyYK0NNeoV1tvmHbyTBdSIHGDWLq4CpIuA=;
 b=fP6pj15DmGydsbDxXY6rm+1JsP9m+uuXJG6/TsIc33Kkl2wDJbdhhIrLxZE/IW59XCizsqnPbi78Ngt01fIFGESCaxfwdziZvRGQz0Qxaqr+pBtQ9g2VV10dFpGY+3vH6aM2me6eh9GodkEd5LWEYwQHEo/r+J/EJsaS6EP1kWFjjaanU2F1eUm+A+3C442vwXkreyHZC2zuhh/p9jfKiw5SIpfKf5gaNTkTskF+cBVIxtDs+DPgJa5yhX6NQCZbd+G+IYrPDXm6PGnTsm9l7nNhITfeEZTSdsWejRqow3tH1M9kvLT8iiHziKALozhHFWON8EXzRekdisnR+VYfJg==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by VI1PR09MB4318.eurprd09.prod.outlook.com (2603:10a6:800:155::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 09:38:45 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%3]) with mapi id 15.20.8857.026; Thu, 17 Jul 2025
 09:38:45 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v6 05/14] target/riscv: Add mips.ccmov instruction
Thread-Topic: [PATCH v6 05/14] target/riscv: Add mips.ccmov instruction
Thread-Index: AQHb9v6VMH3/WN2MHEqiw0W41x6pvw==
Date: Thu, 17 Jul 2025 09:38:43 +0000
Message-ID: <20250717093833.402237-6-djordje.todorovic@htecgroup.com>
References: <20250717093833.402237-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250717093833.402237-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|VI1PR09MB4318:EE_
x-ms-office365-filtering-correlation-id: df822689-c693-4c04-3432-08ddc515b9b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|13003099007|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?U8kgyiXtmNulyY53ZIOOXhoTQNWmOfsQ8eFsc1RbslvkompSLDJ7E864UH?=
 =?iso-8859-1?Q?zNT8uqmW6GiUicZ5i7PHm/9S2Z3ezREsiBI9PNHmqDW+EJlMv/0nrqD4CX?=
 =?iso-8859-1?Q?Hj7vbCj5FbE/uZTtIdI7WtUQwKMb+3W3EXCfUNkXljWJKG7XmzA/qoV3Sl?=
 =?iso-8859-1?Q?agygZ3od+7cprxemJt87r8RKlfFr02IJgWM3ZlBT7E0DDSbiC/vyJpuRl4?=
 =?iso-8859-1?Q?uKMy1bF4aw6Va5qWP9+9bhDAOtABIIjXbUs0YXHCAGQyGEQRn5rHPk9I0N?=
 =?iso-8859-1?Q?xpvYewU9RNKtr6HpvALy4L4YGH7YLk2LJpbavdcj5hnonb9pJw1bxAVg/c?=
 =?iso-8859-1?Q?Pg0vizNtUJHn3umQJV+HgJ0RG9YQUGVogan1TS1oL/esMtjdeAuPbe8fmJ?=
 =?iso-8859-1?Q?mSdYlBegP4Xs+1no9tyv0BB7kviffSH9Z52u1JIli5X779oPPloD6NveCB?=
 =?iso-8859-1?Q?M2a8kSUOdvBlkmKH8a7tHGcT8VZtbl+xFcGvJqXTX/63tHJ6Kx5uU8guXC?=
 =?iso-8859-1?Q?SGe67WOgs9Arz8tx05XUBp4k20l46N2IQQXrl8q6nEkp+DRr/rcaLwt87x?=
 =?iso-8859-1?Q?4lQPPZ6VYCfFSLgAO19glEFhlWYqOyZczM7zlcxfLu0Zkot6BTAX8CoZo2?=
 =?iso-8859-1?Q?BKdt6KXEK43JzC5E1gmPuOamG/AsCm24s+F6D9JH9vSv5odnCB3ER04afX?=
 =?iso-8859-1?Q?85mk6YjYrIiXRrh4y2JQW03k8Pd0T2rWVNhTExbb2UpoNy2zshB+ky+bGF?=
 =?iso-8859-1?Q?sEv886ujCvfjB9Qnqu9+81UfXjcIFD4iPtl17BL9wMLBdeI39L8KyhANul?=
 =?iso-8859-1?Q?dv0er3Kh82/R21eHZHk5qDQWszILF6vfya5oSDhTYJnJ9buiZ0MPDzlRA/?=
 =?iso-8859-1?Q?B0V3YFGWbND+Z0I/IVVYDKjHApgXXzTQ3WwE3jYLA7J7HqEPLZ2u9NcN/z?=
 =?iso-8859-1?Q?i/8Okk9nIWhtRdOp9KFHkexLsaRUjdnrD2n3G+hn7VSpF3yjU4wXDKxjfS?=
 =?iso-8859-1?Q?nro9Sd8aw8hYcvkaN5FwgYdFBKhKEHmzw5reOk8r3uXdrxbcZ9ZWISc2A8?=
 =?iso-8859-1?Q?UmIk6AAdEBgNkhBrZpd6hAFJmRf4CzKdxtexEj1wHnu0hdbA9DLjdRu0M1?=
 =?iso-8859-1?Q?cMXvvgCaiptIlgdG3YJ/3yi85/d2JFGdu68zr/QS1BpRlfTtR2sfsOPXvj?=
 =?iso-8859-1?Q?+AS0mDMXz/mfAlk+F+UzhYp98z0fa0DApdvuG81zCnRP3OPKC5LrDYZ938?=
 =?iso-8859-1?Q?Uav1mFRa2xy8qISczdE55tSZUEkPrnGJOqZc9AyhzpWKuLcm3hJRGchXGb?=
 =?iso-8859-1?Q?fr27Eta9osQromRkNtdQUoS7wJEIRKqH3lP8q6UODni+AHaUEGFul9iXg3?=
 =?iso-8859-1?Q?0Tl3QXjSMW+O32IcVwTukHNxkcDd5hSBxWihlhCsowY0QtqbbHSza3mvgd?=
 =?iso-8859-1?Q?BLV1QV+A9GEf2tEd7zAWTGRN3x0Z07OhH+sZ+ppkWgtrzsGZioEcU+Kmqg?=
 =?iso-8859-1?Q?bYpJNP+Z72nrr8HpYCwxvkTbMuZTFW9eVxnU3ZFa1RMieZ3GxHIru4IbvD?=
 =?iso-8859-1?Q?jCX3LUs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(13003099007)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?kk5uF4u67CxCHJPM+9haEPrnN0aH5G+EpuS49X+ustUw2WKjRpFxBuBJp6?=
 =?iso-8859-1?Q?7R6vacVJQIaj+POlfmr8Tg2LfR2oI61yPWS6nROeZxW8K9mU2O3fYBjQ/U?=
 =?iso-8859-1?Q?PyIkvCD2son/WGUt/crCCrCUB/ZRH/YFXyx4HbQ/1rsPklsKUf04KpBGT9?=
 =?iso-8859-1?Q?CLHYzrmnpuxhQDD4ZDH+39S+tc9bbhk60UNDSXb+S2iDEOkl1BfCuFYaJu?=
 =?iso-8859-1?Q?Kd0/Al73oba9BbISqc1QUxDP8eRdcPQSPUaUHg7Ro00N2iRlzw3ZzPvYoY?=
 =?iso-8859-1?Q?0JDZWUXBUM3cMTURRQo2elgGgAFBieM1FN7naojNpIz97HkGe3gKY31cdJ?=
 =?iso-8859-1?Q?0FuwgsyxpqaiFEKZ4pv2EzEQHxIH8kuVhw+1SZt7WNp/1jp/Mwn4fA0riA?=
 =?iso-8859-1?Q?h0fHxnftw53f5QR0i7TjFmg1R5w+ANbfOCWcwlFbxwKfY4UOKUFJrLQF+t?=
 =?iso-8859-1?Q?dzuZiTiYsSbJg3Vj8sRULENWm8YUxivJUgjPrZhS6u1WyXc3XfFE0wmsnG?=
 =?iso-8859-1?Q?GalhwflHjlknKGX1XL4kUEOGvi2/s70ROJBKKjlmW+JCpnb5Y2uabZTJp5?=
 =?iso-8859-1?Q?aXtS5NQeXp6RWrwxA2GAfPewj2hEokW/ko5Crqo/Zpd5bxkrRf8zDEtutk?=
 =?iso-8859-1?Q?lacs2zNTghyXjpbevhp6irmFlgGHu0J0+W0W17135RE4aq/YkuYMv53vqt?=
 =?iso-8859-1?Q?z08o7EVxTo1hNKTPB2su1HN3tJLj1riFBePn1GQlZDHaFFWG2vsrROwS1n?=
 =?iso-8859-1?Q?YSBS+ad7/ESscRdjx88fNYY8Vp2j/q2S+hCHR0yAIYB0zBrpwt6ihZBBEZ?=
 =?iso-8859-1?Q?UGgkM5npIpLn+7WgpQ5BmEHA6fu2qYFFLXqgnv1T19aX56sHzwhXmY0fpX?=
 =?iso-8859-1?Q?c3CDROiM1qtUNxFrNxQ0ccBO35ZqhPnvy8iccfqT9qq+lE9IzXB8HToPIA?=
 =?iso-8859-1?Q?fyR/wy1DPNvz1P/XdSsV014UbHWztu4XY+bzMb8U3ipuTCpcWowNBCVIXT?=
 =?iso-8859-1?Q?13c/dw8NiSdqdPJrXBMHZ6U1BRRNdgJa3gnVbIHAbVSVbAi5cc3kVGR7rR?=
 =?iso-8859-1?Q?tkqBl3ZYLOCognZRR+uW6jSWwR9nN9ibpaOUdf3zYPFcfGyV8RCN2VQ97V?=
 =?iso-8859-1?Q?+Hmg0uC90iE4t5TkRe47iNcAdLdYlzRljPjFHWZYYi2jGcZ9olExr0/Ri/?=
 =?iso-8859-1?Q?wlkvFtgqazNwuVugj59FvN27bE2tGa32wF6OpfGers0noxVCUyydrHLmCi?=
 =?iso-8859-1?Q?PerC9yT0nztj+7gRZfKJdDdIUfL9Szw8voA19BuT1dunbSBCjj2NPbibIg?=
 =?iso-8859-1?Q?WS8S6EPzcLgfuIpvTRxC8QSaThu3jT7YykE6kwoMeANsqYDzhUP0Qonq23?=
 =?iso-8859-1?Q?hurO0GDynnFfEN+0eycX9DpB1h9zSwTSFsWbsBfv0Kqnxv3M2vYtGKlkZh?=
 =?iso-8859-1?Q?IkFBLkLTYv4fxGQx2GS6JGNqMVmcUiPrFsD1D/1h0ZGwhrYK+oRap3Pxwt?=
 =?iso-8859-1?Q?7uYVEWGCY2vlODT7hy4NkEeKMiEEOgtO/0e83S/iIVEMt4WRz5sN0Nuklr?=
 =?iso-8859-1?Q?iLOZXujHVuRpBghRtO80v9KNrrr+ZRj+UpFyZd967E+ADrWRkL2a6ATmPr?=
 =?iso-8859-1?Q?worHkDqamilFxFfhy32ubULlxR1a3NY4x0SHpLguouXjxLkklMB7oMNuRO?=
 =?iso-8859-1?Q?456thcDEmKyawP7eGrc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df822689-c693-4c04-3432-08ddc515b9b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 09:38:43.4205 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gWt2qc2kYCZgVDaWK+l/gZ1PfQlWRAlqq6DGQEEqskIgFu8nWrOxWevAJkICnO9Ffis7rsZDcrBqgs3On4Zn8zkM+nNvP1362jY2I5yRy7I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR09MB4318
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

Add mips.ccmov defined by Xmipscmov.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 target/riscv/cpu.c                        |  3 ++
 target/riscv/cpu_cfg.h                    |  5 +++
 target/riscv/cpu_cfg_fields.h.inc         |  1 +
 target/riscv/insn_trans/trans_xmips.c.inc | 44 +++++++++++++++++++++++
 target/riscv/meson.build                  |  1 +
 target/riscv/translate.c                  |  3 ++
 target/riscv/xmips.decode                 | 11 ++++++
 7 files changed, 68 insertions(+)
 create mode 100644 target/riscv/insn_trans/trans_xmips.c.inc
 create mode 100644 target/riscv/xmips.decode

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 7f453acbf8..52828846c6 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -243,6 +243,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
     ISA_EXT_DATA_ENTRY(svpbmt, PRIV_VERSION_1_12_0, ext_svpbmt),
     ISA_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
     ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
+    ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
     ISA_EXT_DATA_ENTRY(xtheadbs, PRIV_VERSION_1_11_0, ext_xtheadbs),
@@ -1373,6 +1374,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] =
=3D {
     MULTI_EXT_CFG_BOOL("xtheadmempair", ext_xtheadmempair, false),
     MULTI_EXT_CFG_BOOL("xtheadsync", ext_xtheadsync, false),
     MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
+    MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
=20
     { },
 };
@@ -3191,6 +3193,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .cfg.pmp =3D true,
         .cfg.ext_zba =3D true,
         .cfg.ext_zbb =3D true,
+        .cfg.ext_xmipscmov =3D true,
         .cfg.marchid =3D 0x8000000000000201,
         .cfg.mvendorid =3D MIPS_VENDOR_ID,
 #ifndef CONFIG_USER_ONLY
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index aa28dc8d7e..2db471ad17 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -36,6 +36,11 @@ static inline bool always_true_p(const RISCVCPUConfig *c=
fg __attribute__((__unus
     return true;
 }
=20
+static inline bool has_xmips_p(const RISCVCPUConfig *cfg)
+{
+    return cfg->ext_xmipscmov;
+}
+
 static inline bool has_xthead_p(const RISCVCPUConfig *cfg)
 {
     return cfg->ext_xtheadba || cfg->ext_xtheadbb ||
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_field=
s.h.inc
index 59f134a419..baedf0c466 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -145,6 +145,7 @@ BOOL_FIELD(ext_xtheadmemidx)
 BOOL_FIELD(ext_xtheadmempair)
 BOOL_FIELD(ext_xtheadsync)
 BOOL_FIELD(ext_XVentanaCondOps)
+BOOL_FIELD(ext_xmipscmov)
=20
 BOOL_FIELD(mmu)
 BOOL_FIELD(pmp)
diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/insn_=
trans/trans_xmips.c.inc
new file mode 100644
index 0000000000..f5aeacc6fd
--- /dev/null
+++ b/target/riscv/insn_trans/trans_xmips.c.inc
@@ -0,0 +1,44 @@
+/*
+ * RISC-V translation routines for the MIPS extensions (xmips*).
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2.1 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License f=
or
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along=
 with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ * Reference: MIPS P8700 instructions
+ *            (https://mips.com/products/hardware/p8700/)
+ */
+
+#define REQUIRE_XMIPSCMOV(ctx) do {              \
+    if (!ctx->cfg_ptr->ext_xmipscmov) {          \
+        return false;                            \
+    }                                            \
+} while (0)
+
+static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
+{
+    REQUIRE_XMIPSCMOV(ctx);
+
+    TCGv zero, source1, source2, source3;
+    zero =3D tcg_constant_tl(0);
+    source1 =3D get_gpr(ctx, a->rs1, EXT_NONE);
+    source2 =3D get_gpr(ctx, a->rs2, EXT_NONE);
+    source3 =3D get_gpr(ctx, a->rs3, EXT_NONE);
+
+    tcg_gen_movcond_tl(TCG_COND_NE, cpu_gpr[a->rd],
+                       source2, zero, source1, source3);
+
+    return true;
+}
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index fbb6c8fb45..26cd11ec00 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -4,6 +4,7 @@ gen =3D [
   decodetree.process('insn32.decode', extra_args: '--static-decode=3Ddecod=
e_insn32'),
   decodetree.process('xthead.decode', extra_args: '--static-decode=3Ddecod=
e_xthead'),
   decodetree.process('XVentanaCondOps.decode', extra_args: '--static-decod=
e=3Ddecode_XVentanaCodeOps'),
+  decodetree.process('xmips.decode', extra_args: '--static-decode=3Ddecode=
_xmips'),
 ]
=20
 riscv_ss =3D ss.source_set()
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index d7a6de02df..a6713b78a1 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1194,8 +1194,10 @@ static uint32_t opcode_at(DisasContextBase *dcbase, =
target_ulong pc)
 #include "insn_trans/trans_svinval.c.inc"
 #include "insn_trans/trans_rvbf16.c.inc"
 #include "decode-xthead.c.inc"
+#include "decode-xmips.c.inc"
 #include "insn_trans/trans_xthead.c.inc"
 #include "insn_trans/trans_xventanacondops.c.inc"
+#include "insn_trans/trans_xmips.c.inc"
=20
 /* Include the auto-generated decoder for 16 bit insn */
 #include "decode-insn16.c.inc"
@@ -1211,6 +1213,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, t=
arget_ulong pc)
=20
 const RISCVDecoder decoder_table[] =3D {
     { always_true_p, decode_insn32 },
+    { has_xmips_p, decode_xmips},
     { has_xthead_p, decode_xthead},
     { has_XVentanaCondOps_p, decode_XVentanaCodeOps},
 };
diff --git a/target/riscv/xmips.decode b/target/riscv/xmips.decode
new file mode 100644
index 0000000000..cb334fa4bd
--- /dev/null
+++ b/target/riscv/xmips.decode
@@ -0,0 +1,11 @@
+#
+# RISC-V translation routines for the MIPS extension
+#
+# Copyright (c) 2025 MIPS
+#
+# SPDX-License-Identifier: LGPL-2.1-or-later
+#
+# Reference: MIPS P8700 instructions
+#            (https://mips.com/products/hardware/p8700/)
+
+ccmov          rs3:5 11 rs2:5 rs1:5 011 rd:5 0001011
--=20
2.34.1

