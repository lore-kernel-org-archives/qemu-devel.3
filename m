Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E66E6F07B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 09:50:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXyzt-0001VM-Ki; Tue, 23 Dec 2025 04:48:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vXyzs-0001Uz-2t; Tue, 23 Dec 2025 04:48:04 -0500
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vXyzq-00025T-Cv; Tue, 23 Dec 2025 04:48:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kpi1OJdb4waayIpuMc1urVpLbA6+TcVu5z/boMfYun5Pq9G6d48GSasxXHXnEo93prpInTAXAaj0ORgu2F6c5PXHvBaBaJ80Q8mZcmIfMkN1K9MJWF0ZAXv/C7/zaC1SMuEtKzr+Vfbq6e6HGUBdc6spwBvowIQ8vgQaUT1XYMrvr7JBfk4iNE1xBBo9K+a2MdRLsLSfnLsglkyY+sNJEx6psC38UEAiL3ggIgBFMwL2uN336BLq4TN1Sk51FMcQxYKo67Tca3uZqIL9+PdzBHbsV/JID4KtCifpbWoKza/k9UYVHGd8aJzAcftk4j9jrOZOomM3U+zIgnCu6UXmjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b116aBZojw1wmasVyMlDaGcOn8TFp2DO4Vau87t9ivE=;
 b=N8HFZS3mn3nzEgDgeMUSeiXV5pinejyeBzmXomb6ZEvafG9UQmyoFcgFzk7cydWd/cPsdHNztbvEz7b6hSUnVKcaS5g1V9MR0za7gdmRaWiJzLV8iSTLLCyK7GlRbkNobDUsc9okJncPUSdzsCWlGTSvhK7cnhQiZ0sYaQ7IELKEtjsNgakuAFb0Xwhr1L7c1ihYS9A/YShKZHdDxPApm44XLbZMqFohG7Um7c9IXM24stNEL3aqrPTkGA06fn4CnZ64osOtzZAwVc9vMBq/wsE3RddV2z8VzRAn7n50k9uEO+27DkeHf82qLuaQAlbxDahltbaKMOtW4vHwEavWPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b116aBZojw1wmasVyMlDaGcOn8TFp2DO4Vau87t9ivE=;
 b=kSMY3oPhFu9fQg30+xGUzleEulwjo+yvHx16h4EmesH4TQ6waV5NHvi/oYcBCnKvdAR5tZeYw2WTWOvZXZoT3bROYTY7rsWqXah1c8lV7ceC1oC7syUG0KYM3O/IbyOg6TGPunqNPFJJxDsxneKE11MOtR6BOUXAP/Gv1YkQaOp+OmM17y+F5f7NEzn5mjkO7m+uwkKmcySRXoygGmgsTeSPJWaAdD/kxhwScHXf4wmjXbMe1KsitLIOeBpuTiB0SWcufNxxtGiU50kAEdc0+fWobRkVp6kP/IdOX11NXxvHArILXjNiYz0LF4zOI65ocfClqmKzVYyWTZ7SBxIXfQ==
Received: from DB8PR09MB2796.eurprd09.prod.outlook.com (2603:10a6:10:ab::30)
 by AS8PR09MB5758.eurprd09.prod.outlook.com (2603:10a6:20b:539::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Tue, 23 Dec
 2025 09:47:57 +0000
Received: from DB8PR09MB2796.eurprd09.prod.outlook.com
 ([fe80::e42:9fbc:3e58:febe]) by DB8PR09MB2796.eurprd09.prod.outlook.com
 ([fe80::e42:9fbc:3e58:febe%6]) with mapi id 15.20.9434.009; Tue, 23 Dec 2025
 09:47:57 +0000
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
Subject: [PATCH v15 05/12] target/riscv: Add mips.pref instruction
Thread-Topic: [PATCH v15 05/12] target/riscv: Add mips.pref instruction
Thread-Index: AQHcc/E1qtDwiZAeTkyvqeemM2HwWQ==
Date: Tue, 23 Dec 2025 09:47:54 +0000
Message-ID: <20251223094739.1983381-6-djordje.todorovic@htecgroup.com>
References: <20251223094739.1983381-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251223094739.1983381-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR09MB2796:EE_|AS8PR09MB5758:EE_
x-ms-office365-filtering-correlation-id: 64169f16-e073-4099-6d0d-08de420859fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700021|13003099007; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?0P157o2EYgGtaZmIftmiH0BQZWaxElCn74PpCKMTuNjlvsxqTWAsP3AEu2?=
 =?iso-8859-1?Q?rZWTjf2OO+bYjGDvv11Kro/unUgI9SedTXdr3Ig+KFIub5N48RRhcG4Jwb?=
 =?iso-8859-1?Q?TsSxCmTyB7GgNMoG87bBOtZdUa3fTntfHdD3ycNxyrIoymPMbSxnbmUJQ4?=
 =?iso-8859-1?Q?ZGgwRia5+T6g22/B6MwsCCoz8IdBPZRLt+Vt5Kw5OlyJT50DpTfSC/LQPy?=
 =?iso-8859-1?Q?TkeH57UF6Eizewf3q6zWmnkcBwCZuose2Gjb8DiXdarezMI6xpGLxYF3j1?=
 =?iso-8859-1?Q?5huQrxUYVHo7lozrmlAWF7etxXiIk17xd9zAO2iUszyKzbgWcBl/7+8Uuj?=
 =?iso-8859-1?Q?NQyeBFPEKKrODwkGbM4Be3d4VBQ6eJqvZPDNJMo1sK2+J1gC2lsl7KDhw+?=
 =?iso-8859-1?Q?+119YzbiJWeSTMTDykFvjVRIFiBiJkXYbWKkqftuUD3YMlv2tttzY94EbD?=
 =?iso-8859-1?Q?R3o4ZHFU5z72OXH7rygkES+/geNYj0meGcquN/0/nHlZIQa+pSW2epNp8y?=
 =?iso-8859-1?Q?3ru+Ddn8ir1Mo6NR/7tMRlC+5jv0dfPwK0TACwqkm2XWvHJmepUN4lGsOR?=
 =?iso-8859-1?Q?Gchj5BD2wHSKbiM5lcyOJ4J204puEF30UUC3zWpoaMcLN7UzJFppvsIxd1?=
 =?iso-8859-1?Q?YPvGiilB+vyKINMf3B/cIt5TjNhHrjDa0HJDPdGAG31O5m+fxsV3KhsRn8?=
 =?iso-8859-1?Q?YlT+BA+pQd5KlnhDKjz5qkRjuxLdGrGyUnU47Qcyjzkef+RzDpr6EanzXD?=
 =?iso-8859-1?Q?EtPTa5/gX5ZfOxEtPsD0TkGVv9r9/+B244CeQSSOwYV559g1ClNOdaRKX/?=
 =?iso-8859-1?Q?h62IjSBMNlSxHf5kcLACbixjwK4vXle8HzorTLTzt3gOoOiTdaNxqs2ta1?=
 =?iso-8859-1?Q?ir5Kw2+q/8/M1C54Dexym8Op45Ij1l7amUIfx+l8n2JdEJZBdUSD/KTmdp?=
 =?iso-8859-1?Q?SgH5PndE5qNOeiYopJeidi7J0M4Yqa6SQLI67QDxtT9/eZpZEfpepttIs4?=
 =?iso-8859-1?Q?oMeLGbs7ztMrGRey2IrrBaYUiC3mz8epCUksL2WxG6Q1NeRNNmFzkO7xro?=
 =?iso-8859-1?Q?VPRQzYllXqEn5divK9DnblKjiGcEqpIhp1lssF0m3vyoy+XBjQKqpgnvam?=
 =?iso-8859-1?Q?IZdz1oZhYh/Uu/TMI8DNEa7rCi9Vdb/QJbUpfW97AZEEn4CKS04FLDok4a?=
 =?iso-8859-1?Q?1E5nvLP9x87SCjB41NQMdKOhNNPDGcCqcVw2ct2D4AnvRNjU1HFR5QFMiw?=
 =?iso-8859-1?Q?EUQw6C7U6JVbac7WjTmcgiMWMb/v1YtQ+MXuIjbCVebX+CrSNotYJOOr0v?=
 =?iso-8859-1?Q?kHZzncIt9vVg+4eyzjZQRdqNA2enTFDMdI2AX8eY3tEqt+sqeyDde7sXFf?=
 =?iso-8859-1?Q?5jPW1j7orLu2ojgSUwzMpFigQxIwPiMu14sVQuzFp0dcifLWEu5Zyt8tW4?=
 =?iso-8859-1?Q?HOMD0s/EInoQoecVbZ2mP1rKUjXYYPiLCzNvtYr3xuvpqZ5epzWBjeB01A?=
 =?iso-8859-1?Q?qXlNtPn6AapuqXN3m3TgfkGEN9FT9uTI56MpHsV03Sq1pa4W7iIGqli9+T?=
 =?iso-8859-1?Q?OVfcfQaYvq1W9S8qKG9GV7vxGtOx?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB8PR09MB2796.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(13003099007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1DsFkk4FVYLn9Gx3Rvf28OR5dv+/D0yj/adhT1pgDsawnIg5X/7chsqBhY?=
 =?iso-8859-1?Q?H2rAeOiOT9AyP9Ezm3a4sdrYoXfCQbnQ6SLHmsQh+d/qtdmMA8beHUr4xg?=
 =?iso-8859-1?Q?vB12mEI2KeIwPd4mVofntcaNxIu883Ri1sYr1Hq0b3FyDYSWrKvUJbZMXs?=
 =?iso-8859-1?Q?fOJio4tc4CZuy6O5UHQO7p/FMy878tTUam6fLQwIrPl27oqmo3l1bpMsU8?=
 =?iso-8859-1?Q?35ko24/W7MNAiRTWglL2t+ZX8mO7ahAsiK+NaGUxQOm+xbOeEtNX7tDp+D?=
 =?iso-8859-1?Q?kfjaH9vdoFoHh+B0fo8tkLlJoVZ2j6OVHpsBCuAEngJHrGQ+GZnRplHIBU?=
 =?iso-8859-1?Q?Q2McXKBTXxF3sswuyikKeam+CJ9Y7YG0UG5W9+pdy6uMwGDZGiL6zC0nDP?=
 =?iso-8859-1?Q?1CpHHtgoTkcG3aSqXAazPlL3GyEG7gUlCS2iN5PRdw4dyckSe46jKzhDG7?=
 =?iso-8859-1?Q?R/A8uVPIJM2ccFZvA1peR2pDF0QiBrWjUEJzuo8SGv/myv+KizUvIlNwSZ?=
 =?iso-8859-1?Q?u/EDwG/7SfcNL+cxivc1NM+LS7v4MMlMDDRR9xW1l6vxFEUY1pksu14O4d?=
 =?iso-8859-1?Q?kGWawiAND/PG1w+7PL5wjVMYfm7Fn6cMZMKfKc3ZKSAVqSnbYAKpIbs1a4?=
 =?iso-8859-1?Q?uf4qh8IpDYrqwr0L9vODD51Y5KhvIHZeVd9DGUR883LuCoiWUbt4cwNXWb?=
 =?iso-8859-1?Q?oA8yQOdljuyrHhfY8OZHG6qCSGc9bvBzOFg8mkhiKDkN1tWKQU+/+epdr0?=
 =?iso-8859-1?Q?Zyo47IIl1UhcMpUYUEptONvUnVRC0/fk0m6XbDQZRONk0uYbCDhK2HllZ+?=
 =?iso-8859-1?Q?PsuOC3eWgIlwo9UuX+TvLqGfhYV66Sd+QujBws9VS/bdBujzbA8vDrBcgj?=
 =?iso-8859-1?Q?PydEU90tT/AquzuBstOeYdfcawFAhJN/mHAzBfj5hCmCLZDK8KSqDevcrG?=
 =?iso-8859-1?Q?ks/Cyp1Jw3ZOIjY5rLpOzTtPDfgPwTTAr+pwWII88Z4AaN9zg7HRxyf3YD?=
 =?iso-8859-1?Q?GB6bxatpAeRL/1VBRaELXB4MVYqjC7454er1S3kPjePx5ic1BxKcfPibXW?=
 =?iso-8859-1?Q?MaUmQGiNAZ6zBvxAuNP/zaMw++37Qykuuppce+rVlotz7I+lsAyuCJri5F?=
 =?iso-8859-1?Q?Uv4eoH85MDa04LdrRTaap4D4mrfXNVEI5ruafAfAkqjtkG8Pn03ioaD550?=
 =?iso-8859-1?Q?JwKjuQXGFsdfOQxRJJjaIt4Adj1cXyM0SeQthaUhBfGE9PtBkmer118pDz?=
 =?iso-8859-1?Q?DTx3IprElHx150j6JyN/owzXi6654qkIDZFQyhAbBLI7z2VU3HG09wUm6u?=
 =?iso-8859-1?Q?GjrZog9Cae+2DXS1aupsv9Bbo1XzjM58z7hPEQ7JaAuf78BSGXv7iZqTZj?=
 =?iso-8859-1?Q?RVuAR11/dyvkMdgh3k22DQlNXGQwSb9YuKi3qTPyY2o+QlaeDLtTG0mC0V?=
 =?iso-8859-1?Q?EppEsRAylIp5BctiUh46h6QnVDk5vL4s+xLeMEAcAW3LwU4ucHGvPemhAk?=
 =?iso-8859-1?Q?d4mBM4KNRfXujUfCSgxozVEn3YK1JEtXwgIcT8UFU7I/l2ZVDkv03o+D92?=
 =?iso-8859-1?Q?hqZtZQtOT2PNSrD7IqL0clOu8xSuvfh33iB8Jj3Y4rKZy+JKCD7W/8q7X2?=
 =?iso-8859-1?Q?QF86wBH3ZHEsktA5sBClCkhwuL25FZYZDxwBZFuP/tVnJ88m6WgxESgIFq?=
 =?iso-8859-1?Q?juTMAc+Msqk13Bkr1X8FutirIIusaDeq+2LlF0MkaPna6h2zpVRrIXUNgk?=
 =?iso-8859-1?Q?NZBaSoNcR46Vxh1zBMLjjuF19xqQEPK9WXtpHjFDwUJVVXQodlF2vMX1bD?=
 =?iso-8859-1?Q?j7qKtTxGKRhKsr0YU66h6ars0Kv/6V963JSmEJpUPT8s2qBXxOzZ?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR09MB2796.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64169f16-e073-4099-6d0d-08de420859fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2025 09:47:54.2711 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L2agXgwYx2+Gs9pfBmaHrNgwA+AEs6kUxUcrqHU6R/zLiOr+9lyQoLDh6NeVBZ2lV8D/TCJz4Y+XTUaqFixspBcNkYGU+eUTBxSqm7PN/RU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR09MB5758
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
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

Add MIPS P8700 prefetch instruction defined by Xmipscbop.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c                        |  3 +++
 target/riscv/cpu_cfg.h                    |  2 +-
 target/riscv/cpu_cfg_fields.h.inc         |  1 +
 target/riscv/insn_trans/trans_xmips.c.inc | 15 +++++++++++++++
 target/riscv/xmips.decode                 |  1 +
 5 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 7a2170eb02..08d6f69ae5 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -249,6 +249,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
     ISA_EXT_DATA_ENTRY(svrsw60t59b, PRIV_VERSION_1_13_0, ext_svrsw60t59b),
     ISA_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
     ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
+    ISA_EXT_DATA_ENTRY(xmipscbop, PRIV_VERSION_1_12_0, ext_xmipscbop),
     ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
@@ -1383,6 +1384,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] =
=3D {
     MULTI_EXT_CFG_BOOL("xtheadmempair", ext_xtheadmempair, false),
     MULTI_EXT_CFG_BOOL("xtheadsync", ext_xtheadsync, false),
     MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
+    MULTI_EXT_CFG_BOOL("xmipscbop", ext_xmipscbop, false),
     MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
=20
     { },
@@ -3336,6 +3338,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .cfg.pmp =3D true,
         .cfg.ext_zba =3D true,
         .cfg.ext_zbb =3D true,
+        .cfg.ext_xmipscbop =3D true,
         .cfg.ext_xmipscmov =3D true,
         .cfg.marchid =3D 0x8000000000000201,
         .cfg.mvendorid =3D MIPS_VENDOR_ID,
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 2db471ad17..e4d5039c49 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -38,7 +38,7 @@ static inline bool always_true_p(const RISCVCPUConfig *cf=
g __attribute__((__unus
=20
 static inline bool has_xmips_p(const RISCVCPUConfig *cfg)
 {
-    return cfg->ext_xmipscmov;
+    return cfg->ext_xmipscbop || cfg->ext_xmipscmov;
 }
=20
 static inline bool has_xthead_p(const RISCVCPUConfig *cfg)
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_field=
s.h.inc
index e842d46805..7dab84fc07 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -147,6 +147,7 @@ BOOL_FIELD(ext_xtheadmemidx)
 BOOL_FIELD(ext_xtheadmempair)
 BOOL_FIELD(ext_xtheadsync)
 BOOL_FIELD(ext_XVentanaCondOps)
+BOOL_FIELD(ext_xmipscbop)
 BOOL_FIELD(ext_xmipscmov)
=20
 BOOL_FIELD(mmu)
diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/insn_=
trans/trans_xmips.c.inc
index 3202fd9cc0..bfe9046153 100644
--- a/target/riscv/insn_trans/trans_xmips.c.inc
+++ b/target/riscv/insn_trans/trans_xmips.c.inc
@@ -9,6 +9,12 @@
  *            (https://mips.com/products/hardware/p8700/)
  */
=20
+#define REQUIRE_XMIPSCBOP(ctx) do {              \
+    if (!ctx->cfg_ptr->ext_xmipscbop) {          \
+        return false;                            \
+    }                                            \
+} while (0)
+
 #define REQUIRE_XMIPSCMOV(ctx) do {              \
     if (!ctx->cfg_ptr->ext_xmipscmov) {          \
         return false;                            \
@@ -31,3 +37,12 @@ static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
=20
     return true;
 }
+
+/* Move data from memory into cache. */
+static bool trans_pref(DisasContext *ctx, arg_pref *a)
+{
+    REQUIRE_XMIPSCBOP(ctx);
+
+    /* Nop */
+    return true;
+}
diff --git a/target/riscv/xmips.decode b/target/riscv/xmips.decode
index fadcb78470..4215813b32 100644
--- a/target/riscv/xmips.decode
+++ b/target/riscv/xmips.decode
@@ -9,3 +9,4 @@
 #            (https://mips.com/products/hardware/p8700/)
=20
 ccmov          rs3:5 11 rs2:5 rs1:5 011 rd:5 0001011
+pref        000 imm_9:9 rs1:5 000 imm_hint:5 0001011
--=20
2.34.1

