Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D73A4CCD193
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Oct 2025 15:48:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vA97s-00058g-Dm; Sat, 18 Oct 2025 11:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vA97n-00055x-Gq; Sat, 18 Oct 2025 11:45:43 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vA97l-0001QR-NP; Sat, 18 Oct 2025 11:45:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tChxKlV5PYZ2FupCa4V7JWHRD4rA5Q6JQAczl4dfMYGY3YbNJx40wlKlN0U1H2306U/NMX/zCiTDSlfANGHguZBPM45a8lVyqnvEuUW2MF0WSZ6GWEQDAOXHXnqOL6zdCqT4OShuT2bBNBU6KgoeK5kroP4XwvvGepnX5aKVrklr1t6qI4+dNi33c41kpb26a+kYpGMx0c4p9KgZVL9VuPfnk9nFwjv3QZBKMmJ3+mkGo5aoe+jyX9mNpk9MmjA5TOGwENsM6WPUZxu3D/S2ybONFnCvtiBnSHGrmGWqx6q71IONQkQJNU31zsZ7RyRJ38mv1vbw8z14mwWWjUpjrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tckR7EAHvGngm2H8QuXDOk3uSFLNo9c0HQIWueNfNzU=;
 b=Y72W8xQyvI2h25d5mx9R1kCy2BvFpvbefCBoltQ6FLk1waIjDhUBpidtBZ6IpYAQH68EBhme9u95eXXvs15rXEYXw7WwAn5UMYL1XdEk1tDlB5Dk9fwe9MgKtt466HFcIeu/iGz4sED3XopTV2lGLZdwkEvjSyW51CDXhVje+63D299VyhVCmwxAwnspVUR897BaysDbAjIYbjdB69sSh1q+LsmhEVKW55TNPHMTKlylaJlIaSOiW2ox+ahgr5x26MhgYViUXLFXzZqB1FpA2c+Vx/qfgQomZ/9BXPkv8sYEmWV7NxIZnPI88lGtjWxNEDoinXZ7poYjrugMSg8f7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tckR7EAHvGngm2H8QuXDOk3uSFLNo9c0HQIWueNfNzU=;
 b=q1yV4gjvsdgghAmBHjulEL+KAyuYNajZK7gNOCMIwITI/284P6+WMatBcWLjXpKjrqS108Id839KugTfjMVdDowlL8jXIz+I76402PbaGD8mwHCNhM92lIhySg5Qzq8BS2caZbRw7kXE4OYHYNitUxYC4/ivSJR3yyTirhQg9ZMzCd8qyYsuitAIbqvABDVaegZ2nnexBGw5bxJLpo31c3o54a8PO+CmCoJooPtg4HLPTwJ0lhPc4+GP78tw3PqlCRs4r2Aob1uP7yZNFijbI7ssQeRC09EWljkGmgsp+q/l59QTLVQM5ECV12WU30Hb8rz96GpS6JXKavPZSPb1/Q==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by DB8PR09MB4360.eurprd09.prod.outlook.com (2603:10a6:10:154::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Sat, 18 Oct
 2025 15:45:30 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9228.014; Sat, 18 Oct 2025
 15:45:30 +0000
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
Subject: [PATCH v13 06/13] target/riscv: Add mips.pref instruction
Thread-Topic: [PATCH v13 06/13] target/riscv: Add mips.pref instruction
Thread-Index: AQHcQEY7kFGzmBcYuEGTHrFkkPGjjA==
Date: Sat, 18 Oct 2025 15:45:29 +0000
Message-ID: <20251018154522.745788-7-djordje.todorovic@htecgroup.com>
References: <20251018154522.745788-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251018154522.745788-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|DB8PR09MB4360:EE_
x-ms-office365-filtering-correlation-id: 21b23814-647c-4a3d-12b1-08de0e5d5daf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|13003099007|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?ll9k4QK5u1tEoB+1S8f0LexvPq6gjZPJdTunnHi3kcvztIej25ieePRNgw?=
 =?iso-8859-1?Q?IuV/9v0kakRzQhmdNUiGZYsp9AAAI+qagdMpUsoro2YVxbsT+pvNl21KKF?=
 =?iso-8859-1?Q?sv0WG9M6uGfLsNHI1EIbF0f5dfxdBCi39BR5GFBl2g5tuo+vH4AI3t7gus?=
 =?iso-8859-1?Q?5gdd5amkD1f0B+0vmAu+oj0cP5PZGXTC3SE1aU+cc9y/fpIW9FORNamPjt?=
 =?iso-8859-1?Q?FAOxZeffaSgHPTLpAh0TJNpsvasbCh1BnJPYyFfL1sa0q/FQJMcoYXCMP5?=
 =?iso-8859-1?Q?0oWDS5CEynlj6oYw8jlU+nrnr5k+7BaNTpnxV5gDEJ+Kzo6ITi9yw9Ow4l?=
 =?iso-8859-1?Q?aRH6NlrdLgewYQL/ZAibXR2Ai41aMuz2FC0SwbowOqrwTFDBdCLDE3tpS4?=
 =?iso-8859-1?Q?i1tm1oXazefWMmmdVqmA5rqH8z2YXPCRQ7DLjTJ5HXKKvGLnWxMAETppNF?=
 =?iso-8859-1?Q?RGHuHmLXeVWw4WvQvkFaNK+Wg15adtMzAHw+fucShP5koo7xJiTxW0MQUt?=
 =?iso-8859-1?Q?FNlNi6mkKdjcALjappmNGPdsyCw5IvES4dgmMwTO6OGpuLcp3j4BRHW7oe?=
 =?iso-8859-1?Q?QPOWmZq+i8/JwCvJmXY9KHhp7yoXFf311QAybcloyTHuQV+DXrbKqNbb9t?=
 =?iso-8859-1?Q?c+rHEaHsY3q5rZygIlnzUAdiy+U37lOYLubR7D88jo2+KuPOM9Wp0Z/8wd?=
 =?iso-8859-1?Q?6hHmvtPKGbumRLPbDKd36sAHEYqSSmQ9G8MikmqUBQZdV01InXJMmawy4H?=
 =?iso-8859-1?Q?vJIeP7frI1eZIRIHhzNaRySdTVEPfagr0qTi60U1A1v/EbSMH7H26skmoa?=
 =?iso-8859-1?Q?/K+7rSILLGM2HGn52u2SHZCY6lEOR72jg7ql89z+vko30FfUFMUe2/pbVi?=
 =?iso-8859-1?Q?B2URQf/wTFPeHDPJ4ARETWuDANP7Jh1roLM/XFfARwPgrkmq1XyascIsqK?=
 =?iso-8859-1?Q?N6Gf5QumEYPcYUUIupqWPQliEmjWWWxD3iiMEponYi0BrKHJ1GCswEOwSj?=
 =?iso-8859-1?Q?OKSYeINJtw3nzvCKKhzYab2W698mWWHeTzX2ibABNkwrbwrqfQ9WgEcCTF?=
 =?iso-8859-1?Q?bN/uM1EhDUm4DB+TwUnM7CnFpaUODREv7uSYcoyf/XKaJ7TG4OUUdfxN4T?=
 =?iso-8859-1?Q?IjwtsPPM221kC6lGoDdglJJGSGfLbllxPCCTj6RUsLyeoGXcC3LlfPlCTq?=
 =?iso-8859-1?Q?CywdqJ+Gfq46hGeSJm0KhaMaq8cxSwQdkKb1YNqpycLv1MwpdHEXpqi1Al?=
 =?iso-8859-1?Q?MLhett8bS7OAioqbtqzxEPq5m0BlgUoMxWsQrHpWsIodjJs0blcZKG3cwV?=
 =?iso-8859-1?Q?OLZQwlI0lRwWEVw9n2nUy46LiGcVPeh99jPUuYCWZSEWD5szozeUHOJEgz?=
 =?iso-8859-1?Q?xAh/kFHiReI6p+XYFa5FUjySlJgfaSioSLtJWol2d9YVfwMkbgNuaWr42n?=
 =?iso-8859-1?Q?TXc9Lgi74fezwb0teJXGYDw8laiKaNFTGU6C+L+6/vPbLdUVSjuZ/2GJC0?=
 =?iso-8859-1?Q?1ckKQsHzJz6DlY0av8vmtJl9qyiFSfyLAs8LPmjdXRHactmbiKZ2V5xTyH?=
 =?iso-8859-1?Q?sCOwH/q6oI/cgDv2I/sqyUiwVhzY?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(13003099007)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6Gdd+9HeJZU8BiiIOnQdLBhSxkRt+yMsNnt9xfVwe2yoF6OzjBH/gxgv+o?=
 =?iso-8859-1?Q?McGNopKYDTCJgcwlbJ/TqaSxweNReF3u//qG6uPrjZKo/p0NW7u38dM1ba?=
 =?iso-8859-1?Q?Wm2xC2BjoNDbnoKdk16LigFaIs1cgxywEyIyfohBdZKXEr2q3OJcsBHBpZ?=
 =?iso-8859-1?Q?IJ+OTtBl7cJ9Ltsyz7J9DB71Aigm6za8fLqhOHB5/Y9IMxWs5AkmKmVNeG?=
 =?iso-8859-1?Q?a87gX5Zfs+cnDNLuwHZfq3DPNIG/Iu7Zxf1+MYzTl0FRt8hNIa+nSe+KpN?=
 =?iso-8859-1?Q?UxdVuTm5FArPM4YDnYrrCsKXf2+6RM2aFwcpJgkk0+ZLbzPfAy8FB8WRwT?=
 =?iso-8859-1?Q?pazGOsIP4MHZQmcoRisqiayspicO4ziAgbCzBy0Gfu77hwA6/32Vn3O//j?=
 =?iso-8859-1?Q?+flfxoeIhyqCiFhE2tJ4XjpWE0eofVsY+Ecj57CuEVRFqqI4h1Hcm4hbFS?=
 =?iso-8859-1?Q?xtuheFC7pJ8CeGaxxbVJ1iSiNrmim+GdhH7wsRBVetZyfrcMWpWWtaCM+J?=
 =?iso-8859-1?Q?GvrsTVO3Jt+e1knXpEctSspILr26eBksPUr8ccWFUINb72mFz8kLtNV1ze?=
 =?iso-8859-1?Q?O9dq2t/gSEwhkGSivrIQ8IFV6w8kQCG/BlZkGwP6I+aLAVXrIi+87p1uPU?=
 =?iso-8859-1?Q?YHeZBBWUz3fdizfJcd9ujWEaoJzyLtOLNTj8wL7UMYNOUHVOUQ3a3cS0En?=
 =?iso-8859-1?Q?DIkBlRDsRdZ6P+6NVfrDBZ0BwZFt8MByeAW4FU1B6g//pApAPrdUkTkQbt?=
 =?iso-8859-1?Q?WjWvMYXiP5bPPcdxFeIiv2Nr+6Rw+m5HJ74K5bbMMHqLH1D2hBXNH/wmc+?=
 =?iso-8859-1?Q?DOMFqO/zILYBUOsRDAJ9XC0swKKBPMj7UBOA4jNTN39Z3xz0YWYHsFQbV/?=
 =?iso-8859-1?Q?Wc8PmC9FKqjfX0nP7KrdzMF2Ae2ksLGDjiwUlpPksS7v8wnCBlS25N/Oq7?=
 =?iso-8859-1?Q?AQZoh9WfDG+P9jiD1xQrwuuJXWGj1IKwf/5AAQ3CbpzAXzHkjRqW36R+Nr?=
 =?iso-8859-1?Q?xeXjvQqkmDGKp0XZP46n9RDAJpugCP6n5PHXgDnuUxT92ydVZ5u4iYc0Q0?=
 =?iso-8859-1?Q?70NGhWGN1Uy+XWhqJthhbf0TMp4lyEIyyeZSMLhE8MhMzzUFaOZdfwaWnL?=
 =?iso-8859-1?Q?UIsYi8enq+kBI2kwyiBV9Kms8lqRXB8xrjCmQGuZxgzfz1lOYL/IxaD9N6?=
 =?iso-8859-1?Q?LUZp8fGIOI1YFC4M7UikBBqpI5gy7uwT+gLw24aDnKPTnVa7NTuuPeuQPA?=
 =?iso-8859-1?Q?RNSykiL57AYFG8TVIPeJdZHupnwcieYzqO9DHjPZYaWusHrUxwD6DiANYR?=
 =?iso-8859-1?Q?da2K2wOL/JYWnV7fHciO2jABeG3i3WzesegcgJi5HigtkysQkgNoXmmC0D?=
 =?iso-8859-1?Q?I/2ldbR2VOgteH9dUKXnVDradyQxExCzJXrArfWJt63XbNszd8bt9GHCgP?=
 =?iso-8859-1?Q?wWiMFZfcOFMmaz/bZ1pbRrnKs8u3irK85KGNdaCkeI2Fwag+3U31/ujXtc?=
 =?iso-8859-1?Q?v3z34qOjHLwwnM4P1FfH1DL49CjdPEh1BGTZSU4IYHfDwYt5oeHv7vgVXB?=
 =?iso-8859-1?Q?e5eOUfVucKURj/aFc4V2QLFD0KTedU2xyIxzmvx4TldHH/0WUajvvGDsw7?=
 =?iso-8859-1?Q?xeVpkwnXyYjn17pdpl/Pl3Vj+RDbBH9udsAJ6HPU6ZlYm8FlX5mBe/X2iE?=
 =?iso-8859-1?Q?bd1e+NLU5B4ubrBTnik=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b23814-647c-4a3d-12b1-08de0e5d5daf
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2025 15:45:29.9433 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FgyveH/1cqdn3D5fsu6Gf0vZAmxjdivorsr7oafiTpuCozt2YcXhbEFsdj8hViccBpvT32BZXbN7bgFCc8p0L/L5Lh4rrPJxhZsmn71NnWo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR09MB4360
Received-SPF: pass client-ip=2a01:111:f403:c200::5;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
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
index 87cb367676..9fda450683 100644
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
@@ -1382,6 +1383,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] =
=3D {
     MULTI_EXT_CFG_BOOL("xtheadmempair", ext_xtheadmempair, false),
     MULTI_EXT_CFG_BOOL("xtheadsync", ext_xtheadsync, false),
     MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
+    MULTI_EXT_CFG_BOOL("xmipscbop", ext_xmipscbop, false),
     MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
=20
     { },
@@ -3297,6 +3299,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
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
index a290303ee7..dd3ee7ba2b 100644
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

