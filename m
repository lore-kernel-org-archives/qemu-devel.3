Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E2CCE6F07F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 09:50:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXyzr-0001UW-Bf; Tue, 23 Dec 2025 04:48:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vXyzp-0001T3-DQ; Tue, 23 Dec 2025 04:48:01 -0500
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vXyzn-000255-Tq; Tue, 23 Dec 2025 04:48:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dmG+pYW7qdi8Y3WhFAR57kvj3snRvqH5uIHcxUvDh0nJEdJwM+TFkVyiER+q0QTmFhGLcd65bFW5aq451JbqgDJ9wRudY2yaDFVBpkw8XmejdNaen4ff54+A6DNOwB6f62Xp6/2JiySgDpsZu/4NhZ1C/5reZeWXgzYhvszOhHXctyr7EX2kzpPvnPP7UkvAvFSPKkrSUda7+bj20kI6Dy2FdeE8xS8bO2NW/641XBE5vipxpGUCdgf67eBZ2q8kR0QvlPTE4MWRxXs6YrYVnBO1670yBFT4KmGcfHGzJtyGzq9Aa9f8WfDKplX8HD1mewcczuM1eav8U/O65NS2dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GanhHfsJt5l0a8bNjrfx9XwuSY1uzRvl3Ro5s2/q4dg=;
 b=hr0+pa6/hH/E0eYrEALGuGDw4SZljqPLR/+XPDaKds0BZaSua+RurYNvnn5BecbACA2cU8L5rea/yIBqrCQOzH8y547AyDFQAtVGCg9garFa1zQ3lwV4Rv3KBF46bNVuxleBCMipWNXsGelyNOCPOHck5UeZrprBKVks0ESxC22AdgSDQyjrEbIQIeQdiMNGOk3yLHq6DuO7prUrBcCSfjlFi+zTByQYJNP0XVrZDhXlsfzMX1cN7qbFhQ5OorQnQk9fRF1ZJf6NdxMkhKuErcRXEporvLgkqpuyhcCUqHcKkY9lj6wG/tiPOLpv3u7TqSXua4F8QXhNIB1f5FuA3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GanhHfsJt5l0a8bNjrfx9XwuSY1uzRvl3Ro5s2/q4dg=;
 b=bdF+YmlmTS5J47L27EHAJ2lNy2NKjZSlJn2UCBrGj6flrQC8F++dy8+4hLoW1DGW0D2rMHDWXi7aVcmgly+Cr9OAu9g/LrThFWFzILm683awfGJF9q7zY96br2NcKsmwA48+0u4TyXpTZQccAb2nShFtLggIFUAbdvlljphb+iw7FGcITN8UCJ7We+sR/EvRmjAvg0dHfhgVMNLUx7KH/q+yTFaw+J9t329Muq6fXiNE6REEgFB6Zvghob336pEQZwPJjXBY2lmaAbUWVdJXabovT5koZ8XvhRRwweetZcc+OtJfQnTt+RlQi2SOUyNV8/LfD5OTDLYgx9cghwt7Zg==
Received: from DB8PR09MB2796.eurprd09.prod.outlook.com (2603:10a6:10:ab::30)
 by AM0PR09MB4435.eurprd09.prod.outlook.com (2603:10a6:20b:168::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Tue, 23 Dec
 2025 09:47:52 +0000
Received: from DB8PR09MB2796.eurprd09.prod.outlook.com
 ([fe80::e42:9fbc:3e58:febe]) by DB8PR09MB2796.eurprd09.prod.outlook.com
 ([fe80::e42:9fbc:3e58:febe%6]) with mapi id 15.20.9434.009; Tue, 23 Dec 2025
 09:47:52 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>, Alistair Francis
 <alistair.francis@wdc.com>
Subject: [PATCH v15 01/12] target/riscv: Add cpu_set_exception_base
Thread-Topic: [PATCH v15 01/12] target/riscv: Add cpu_set_exception_base
Thread-Index: AQHcc/E0qk/O6vys/kqzld2Esa3pqg==
Date: Tue, 23 Dec 2025 09:47:52 +0000
Message-ID: <20251223094739.1983381-2-djordje.todorovic@htecgroup.com>
References: <20251223094739.1983381-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251223094739.1983381-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR09MB2796:EE_|AM0PR09MB4435:EE_
x-ms-office365-filtering-correlation-id: 6fd230b2-3d40-4ba7-7dd9-08de42085756
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?vNgSJ0uVMd9RGZ91hVGwtFtljmf1aRqPFT8hO9Zfqf8+a8wBrDalssU1Hk?=
 =?iso-8859-1?Q?OiZrWhn/xZLZm732YP3BijrZPWV6jHyaAwAVEBdnJz+66D5zLQ7K5zP83o?=
 =?iso-8859-1?Q?GCqnkk9xdCHNgEp2c12dKIS1YcRZsqwSOFO+SZNLDoPowdyFmIK5NMVWmq?=
 =?iso-8859-1?Q?v0AM1IhU0V/M3yWn8nRtLcFq0DVEb0ElI0S8AkX6GLka3pokqa+ELkj7cN?=
 =?iso-8859-1?Q?7rcWAtIDFaups6nj2MtHyKAqognSoKpFpMEMjavZ50yGSKtBhprUOKS7Hv?=
 =?iso-8859-1?Q?KbcCJrqWPyBoPXDLSYqL1mUmeaFVmGDGnwQmJHiB5SM9MBRUqlLpLojiUv?=
 =?iso-8859-1?Q?SEe/niZT/ihbA1nwOFHVtCUH6sDoZ0Vy3FhnWpDrekTbIzLC8IEcTWe8Bl?=
 =?iso-8859-1?Q?z4UdED5NvGruG1puUsRQei5bJ2UfHfxhsIx6HZkp3hrLT960xLDWZty5BS?=
 =?iso-8859-1?Q?kM+5C205v+vx9FVUiWi7sTwhhNvRQ/G/Y3CrylhK21LS6jAFSevYGyGiev?=
 =?iso-8859-1?Q?E5+knLvfLTFr8OHbS57E52evaX0+lnIhQEmkPZjbHEjCi7NVwN9lfsPb3J?=
 =?iso-8859-1?Q?4Cqq/M2eJo49tbiVDGEKDhkxiEJYDpORy4TURGmdp309hkoSnqwMF5lVsc?=
 =?iso-8859-1?Q?vccIOG/cQzXokBlcpwZINEdBVcSI1eBxokIZlBq2smoiodHyCkWo6I97z5?=
 =?iso-8859-1?Q?U1x/RtgInYdKA1bWKCfMmLBMbz8FG0weQkEX8oJsEXB6IbaFks35y9lIIJ?=
 =?iso-8859-1?Q?xA707LzZI8ksmUIc65VVhpMgusFwREYPcXGyj0Mql7mbCgCMzp2FnrxPKf?=
 =?iso-8859-1?Q?3+wMAdIgzqiKzvWip7idpqENdAWRSKt4x35vINCruJcH5ygJOlGFld3uqc?=
 =?iso-8859-1?Q?6gA5cd5U70xo+/sGobGy/md3hQQtl/nSQFpdVKOXeAlOpYxUt6xtAHgdM7?=
 =?iso-8859-1?Q?dGGoSGRnRCj8081mxV8xk9gqBnxO2gsBIYLVJ+mF+99i5fHh1XUVFa3lH+?=
 =?iso-8859-1?Q?Lsab6RCd8HX8XWbD6LNNpC9brgSe7Pqo0AycVPTggcNCIpM8gRQTLsZYl0?=
 =?iso-8859-1?Q?LZfuzq7D6bVB+0+kFV8Iy3KFPIFNlxjZq1zw19GGP5LLE2AX7OCywdCS12?=
 =?iso-8859-1?Q?Rq8Elf1KnKEtSkYFSFTblXnE0wJc2Ch1TxRhbnFZkiIpLOjEQpetOHhUI1?=
 =?iso-8859-1?Q?gs3gzfXqLkFaIrQbQ+P80klbBJS+HcXW5JZmFiDh5FjnIs1zM7uE46hOIV?=
 =?iso-8859-1?Q?ngfs7QLu78wmYPS+E1FjIw+zS8bZ11uqsEHO6sEY8VsN4Wauumjc6KXhtA?=
 =?iso-8859-1?Q?55C1EjJyRbHdiAfMPrAF/dSVNHcQcpGzynsAFdYNifde90ah+nLs+Un1OY?=
 =?iso-8859-1?Q?GPo7pAFjMB/oTFYGd0gP8dfitbw4jhC1IO5OG4sE6iwREesTDqqt3wg19E?=
 =?iso-8859-1?Q?F8hlRrrjMlRznZzIohN5Cpw6ha4SYtzB7nawRVrV8YlPMQ5pqIZ83iLOev?=
 =?iso-8859-1?Q?SzrYvHuZ4cTgZMH2glMnbW24dgsRCFOoBvlF5MYUv4tEz3vsCZeWNndFzN?=
 =?iso-8859-1?Q?+E6niytUQbhyUyD1B9dBxws+pt9y?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB8PR09MB2796.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?QtucpKN08Acx6UUkje7/8vBxUTf8PEyBtKqMuZE1WaWck0dZGbLrQiqW50?=
 =?iso-8859-1?Q?XkgTLkGuokGd0Nlfwnou8BwaxLJuq9AyyrfL8hEfm7qxEo/c4ilys7wCsD?=
 =?iso-8859-1?Q?QJZUTxVPmhLHyYJHRYiNfb+4Du7pS1tBOEv7F2boiWcQ6+T46eiAsCvT6V?=
 =?iso-8859-1?Q?kLf5w9dvBnTxpL/Ngx1M43pftSAqhCqd4evxtzwF5FeJV5grflaG2nkwpK?=
 =?iso-8859-1?Q?SdsUoCTp7KuYPYquY5KgBrPP1Et+1i/R14FePjvm0dcwR0U8tGHoQj3ciF?=
 =?iso-8859-1?Q?iS7rvPldi3GT3SOOyFo8Nrq9kf2U0iw8/+vwmf+noSSV/TUwLIOyfDW/zR?=
 =?iso-8859-1?Q?AIEINqYUUVdFRGDzqmJKAEp+Lwoy8jdTgAAhOXU4sWkOZ0yNW+TsWFlPm1?=
 =?iso-8859-1?Q?G7Sl1VMgtOv/K01p1gXOLJeIk5L1U3ZG/+OHCNYx30yPTpxHGvU1/cX2yb?=
 =?iso-8859-1?Q?CO46RI/HgNCKZ7CDXQuAtqUXf1QbBMJ/mMmCoUae9Zpd5L37S62mwNiX8x?=
 =?iso-8859-1?Q?FIlu5/6fbhTxYhfvWoEE0ZboAe1ZHxqIz8nPSgcF0xqj4xqUFvxlb6ZbSU?=
 =?iso-8859-1?Q?Vh7t6fYJDbR/5dKqd0J0n9Hs1aQO8qVqBDY0A8GA6FZTdiqdKQL0y07ZsD?=
 =?iso-8859-1?Q?I9zaz8Rv2fKbfFD1ISDsXP6QALJ0Fc4a2KtRR7rkCeYMpsOhEn1ola7YIu?=
 =?iso-8859-1?Q?P1ndPa6l2NvN3vFmRW8bVj7PqFfG+eh+kXOhKO4wb8vqae3hqfp1op7IuD?=
 =?iso-8859-1?Q?iZbRDm2ImxOZjmjn2wTrjiEZcEfzioD+2TukvgHIcELSS+YFRHqf86drGP?=
 =?iso-8859-1?Q?tqCWrK9t3pddSeVF77rVXvYggH5qt77SoH5xHa6O+nlQKNinDmn32s9ZjV?=
 =?iso-8859-1?Q?QeEVVVAbl9I2Rnk4xJw6kp5bbwxwaDRvbwTTq1kuwb6PE7tth3ofS3x7ep?=
 =?iso-8859-1?Q?1HTDq2Kthco4LzjoTT2LTBADekgpMIyuVwsNAFcJpGBTOEi2ozSmErAyIg?=
 =?iso-8859-1?Q?RgVxSHtNvyJCGsnH8OP3wgHcifyl1PUgqmV6ZyLIhscniZaht6eMcPuObt?=
 =?iso-8859-1?Q?bn+Hno0nPIjqhr658OmAg+xZGxU7AO0MIx4sxi6aDVZIdl6zKk94YgKecq?=
 =?iso-8859-1?Q?5N8s8jfyipBfdti5CprQIz9C3gyrWdbQb5BOadwh9yUldYL94sZswWNwZ5?=
 =?iso-8859-1?Q?FhCbhdEMbGb3iB7qkx4Fs1pOrGfKtqpbjmqeq5Cso8RUVrXx/I7+6m+cJp?=
 =?iso-8859-1?Q?ene3iDN+vPPzBlg648Oklr8/9BlLkvgir5d5vtFzceOTVFjdih3KPzhPst?=
 =?iso-8859-1?Q?7eqWjioiWE4Mo0yq1djii3c/jp0KBlNeP462rOvX5+W5kSvnXt22W7gaST?=
 =?iso-8859-1?Q?ICft/eWl2yAA8zb+EDdGRhtsl3nY8lM8wQVGKL3qWTMWNZO8Rsk9gH8EDZ?=
 =?iso-8859-1?Q?huKyh5QNmcdm/XqW2dGMWEDuc7B/4jPtXmVH4/NKHuB8xByi/69IHhQ+F2?=
 =?iso-8859-1?Q?l8QIi0YwnzzR/mSKRnH4qXLpuvkexJKYJxKwUoXwZsyQSwD4PxiPHolXTa?=
 =?iso-8859-1?Q?rqAGxiihgiaTPSUojX36kYQSmZlStDizjDU4oDND5RPosxtnTeIZY+K2Eh?=
 =?iso-8859-1?Q?YOUR273Ii+kHxbhDksX7StY6H+mpSlpwIbUrymJfpk7e/FMtPPWScCAenr?=
 =?iso-8859-1?Q?Xpu0olbTmLXD/4yTIBFipVa9u/zR1NgAN4zi6O3BcJAQYThDSCgPGx8HcY?=
 =?iso-8859-1?Q?uEL8sImL0/9HMjEVw3Tb7PAQMRCoJqiR4Vh8lvHyuUH9a9Wv9DxUV/0tMW?=
 =?iso-8859-1?Q?TblzFFy2Hx/Kx7v8gYgIfmPioAQP5oULPoiknxAnQ2whoLN0KtG+?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR09MB2796.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fd230b2-3d40-4ba7-7dd9-08de42085756
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2025 09:47:52.5460 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3SzqE4E0XKbh9EroXeHaxpfI8kO+nKjQEGfdwmznO40GJmOEQ3ChtSzZWhPSEr64KlZtqaljWvl4HJc4YzNG0CasxdN76yESQIrOe372BrM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB4435
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

Add a new function, so we can change reset vector from platforms
during runtime.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 16 ++++++++++++++++
 target/riscv/cpu.h |  4 ++++
 2 files changed, 20 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 73d4280d7c..07c0e215cd 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -73,6 +73,22 @@ bool riscv_cpu_option_set(const char *optname)
     return g_hash_table_contains(general_user_opts, optname);
 }
=20
+#ifndef CONFIG_USER_ONLY
+/* This is used in runtime only. */
+void cpu_set_exception_base(int vp_index, target_ulong address)
+{
+    RISCVCPU *cpu;
+    CPUState *cs =3D qemu_get_cpu(vp_index);
+    if (cs =3D=3D NULL) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "cpu_set_exception_base: invalid vp_index: %u",
+                      vp_index);
+    }
+    cpu =3D RISCV_CPU(cs);
+    cpu->env.resetvec =3D address;
+}
+#endif
+
 static void riscv_cpu_cfg_merge(RISCVCPUConfig *dest, const RISCVCPUConfig=
 *src)
 {
 #define BOOL_FIELD(x) dest->x |=3D src->x;
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 36e7f10037..7d49ec4d90 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -674,6 +674,10 @@ G_NORETURN void riscv_raise_exception(CPURISCVState *e=
nv,
 target_ulong riscv_cpu_get_fflags(CPURISCVState *env);
 void riscv_cpu_set_fflags(CPURISCVState *env, target_ulong);
=20
+#ifndef CONFIG_USER_ONLY
+void cpu_set_exception_base(int vp_index, target_ulong address);
+#endif
+
 FIELD(TB_FLAGS, MEM_IDX, 0, 3)
 FIELD(TB_FLAGS, FS, 3, 2)
 /* Vector flags */
--=20
2.34.1

