Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08EEECAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 09:52:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3tTl-0004uq-OG; Wed, 01 Oct 2025 05:50:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v3tTg-0004sz-Ly; Wed, 01 Oct 2025 05:50:28 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v3tTS-0004v0-Ff; Wed, 01 Oct 2025 05:50:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A4RzreTWD+ij6nUtAN16gA235C5s7pftv3oh+t2W9D9maZcxRGsDxwAvTLl0iCbZ+wnLGoEIdhmxgziITro1dwIk/SyiS18uRwqF5qMWaQMLI+yEZd/ezZEsh5OmMHNhek2nBk8MPjrWM7k2p0i/VVbfnm21L2jI03FZ6/VmtKoq1Roa33clT9EJdp9wmfvMQq3Rj5BT5RTbagvLwypeC0hm2z76mWjiVaahV1zLsdSb5BtIISJ5xc/2RIvF8qccHb1CY/SuqL1kuH2R172c2pHN+jDyhpSfQHrI95wyEyIqk4SLtQcIQTVrx6KAJvvAC0f8nG5TXhksLNVfG6FTSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKzgDxULJuMWfoX8xOtiMwRU1bzy/qcvmPFkfNKEEs8=;
 b=h6mq762xRi38evzdAxfAKFZgd5LoxjfbEEmb6LzQi/dI1hW/elTqyv8x0Qjx3FCkQMwYQCDOAscDrQtlaRiwMXUBg8pD2vCd/jxiAi4hgmF25Wd+8InPPNpIYXzTXv+waXomVe8g286rO5kyiOT4vzn/xJdF7j44yOkNnrt5BQ77gTtKmm8lgU59nJCQtsRhTt4vdGQYiPRa4KPb1imnzsxiaXqZC1wkwbKJwmiwivF6dsI0Si0zN1jMfbi8kYq/XXYAPLBBSiaYNIiCgY8MtPZkD8EgRUrPlEVeIbZii9dTEf3EDbWReEWCD3iITqqBVmBaGRoevOJI1QxpGAClRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKzgDxULJuMWfoX8xOtiMwRU1bzy/qcvmPFkfNKEEs8=;
 b=mrrqMRbxyhcwtacBgFQXwyfSbQBGb1731Wa3uby0PEHPRyqHSWK8Dc2ljuqvJKVuHfcaMQvV/GlswnXSDJ9aaRXavk87MtToCI0wwSJnYEm0guYm3snRG4J9T1e9L89y86jp9sgKNx/Zl10+wFRZX6J/H1ntNf0Q/92UsGX6lof5HWh1ccsDEnQGDudXKQW0Ik/ZfJNX85gZpfZkCKirTVBYFYPa5rkG0N7Q3uq00280Igu7Xu2eVAigtfA+v5mQ5maybcu+UdY/Y8zz0X+Gua3atO7Fsyn7uGrjS+KlopOzSNXvNhBSFlwZFBCDiMn+o9bmxGILbmOBBeFQKrfx/A==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by PA3PR09MB8279.eurprd09.prod.outlook.com (2603:10a6:102:4b9::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Wed, 1 Oct
 2025 09:49:11 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 09:49:11 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>, Djordje
 Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v9 06/13] target/riscv: Add mips.pref instruction
Thread-Topic: [PATCH v9 06/13] target/riscv: Add mips.pref instruction
Thread-Index: AQHcMrijjRV8fCo6YkyFpdOJLEnvtw==
Date: Wed, 1 Oct 2025 09:49:11 +0000
Message-ID: <20251001094859.2030290-7-djordje.todorovic@htecgroup.com>
References: <20251001094859.2030290-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251001094859.2030290-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|PA3PR09MB8279:EE_
x-ms-office365-filtering-correlation-id: 8b9736b3-ee46-43fb-4eae-08de00cfc631
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|13003099007|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?/rs+/eNpQ/LtbFy/qUGCy9nNKppjP4asjzJagPtPtdrW7p8CuhpbqQfRDH?=
 =?iso-8859-1?Q?t+o64Y1JYPEO8XFcJTfa+RwUDDvUOlnorxCgvuqdZ5WIw1fQbF2WovpCLK?=
 =?iso-8859-1?Q?CuTklz0qocTs3151URWBLQhALg2IAKdx+bH8stIX/+LnCrySj3/TO49+2m?=
 =?iso-8859-1?Q?HekhfE1KyJSdq/qNNIJ+ChXHzzvmOFc+ZBjQS/dDxSQGN6roW165hwzCME?=
 =?iso-8859-1?Q?Y2TWu+cxFJqKbMtoyjdzwxG9sp4+AKDRlqXjzR5YcpHEN8fCdaq/15WIuT?=
 =?iso-8859-1?Q?mo83XGAWWefn0LvRD5dTqBfGHbI3bpkNu3893y3S5Uxa+Pbuu3yRceqZ3P?=
 =?iso-8859-1?Q?DnkhFsv1Trl3e7Ttvi4d8VW7Gf7y2LVM1GoiElnXkfzybnSEJ9aMhmJKBg?=
 =?iso-8859-1?Q?ED/esYhwfFba8gA87lt6HFQ9QQY4O2lCKqaDRMb1xEk3GFTddyBgdiEFcf?=
 =?iso-8859-1?Q?xR1wUoyY4wRm6l5ZKqyDgGwLO5l2OuEizJ2EWrKGw6mPWaKtDVejOI7Q6U?=
 =?iso-8859-1?Q?bNWIRiZl7vT7Y8+FX0Mqx8Gue8ANtxPIv1xHRCz5V/7/u+pdbgUxrIxGzQ?=
 =?iso-8859-1?Q?YJQcsdeougRmQ24cd7OCB+6ZDpXugakb3SO56IvhMTyEIOqdx182h80l8F?=
 =?iso-8859-1?Q?31Tab26AapJANKZ7bCMVbY3AB61skL20QgjdKyOXjBV7fYilwbts4EYOJ/?=
 =?iso-8859-1?Q?4kvL2hK1ubNc9qsl5uKL8itzZeIpajc7PX23JCx72Lbn03DSN5gYTQqL0m?=
 =?iso-8859-1?Q?lJLCjPPuoUlr1fuZRwFIpZEZDPJL2uo29kmbTrMtEz8HTMzu9DuoDH81tt?=
 =?iso-8859-1?Q?5/dAgPQxsN+eb/VKDFxgZtO2mtTV4Y3JPhm+ne2XrinNkwq28CpnzjiZDx?=
 =?iso-8859-1?Q?Q2ymxEJjdWfUW+Tk5N861p4pGRpGgz6jyBAAHnugP48NXJFsn7DgAjSGUz?=
 =?iso-8859-1?Q?H610F8LnGjfxuUASiQwooIrAJ79rp/1WmNuJtrisNyG3cOoFZwF+3sOjMp?=
 =?iso-8859-1?Q?3yGbqstP12KbUVYj+FYmfIR8mBLEeYoCCtASk+cueNppZHF+xNPUgYE+fH?=
 =?iso-8859-1?Q?zQE/ZciD3lfSdqkev25eDYX7iuW47DShtlZ4mr45tZUaWHo3Y1FuVEshkx?=
 =?iso-8859-1?Q?hXP4YjDTIVtVJwjavqhqEUnG972jRzj2xN3+OEXTNMvvPtQJdVOnQZRkC+?=
 =?iso-8859-1?Q?1qrksJDDU16kJncPvTLOD/ChcqKD+JfaOueF5J11Y10sxo7IlJAul6DasV?=
 =?iso-8859-1?Q?r7CuN8PKSu+v6a1LG+dNW4YM81nODrwfmSccqVnhNNOIhqRLS3938YWYjG?=
 =?iso-8859-1?Q?txkPZV5rRT/DmsMfQtcLXVS1hrepkKBDrlND2rlldUhmMbFkHkQwtk6Ryl?=
 =?iso-8859-1?Q?ab2QdRvDPJVdNRM94HPeHn6cPuwRBA1PmgiEg5kcbSskqZWyulJwj797E3?=
 =?iso-8859-1?Q?eyZipkTg+U1hgd1LaiQFw65x55bqb5aBUIsBbQ/rkTTmwmVg8RNjiRF4BK?=
 =?iso-8859-1?Q?uLTJNKM0fgN4TwfGjubLizodeOnjksF5BpPKBGgmLqvw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(13003099007)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?iizht09xnIAYr8i3h5ywVsYga6P4hEUHjlLsUfffHqTLHilOmj8YuXJMTy?=
 =?iso-8859-1?Q?C9FqEBF8K+Il4BcwBgSWyDGUFoN0QGbH6Vx/Hsjh5YRc/tsq+4wzNkemlM?=
 =?iso-8859-1?Q?0zcXjJEtXpEBKwNODQvUbrMOimjqfa5mQhNXQ4Tv2OUFeyFUQhLvXcopja?=
 =?iso-8859-1?Q?IawsYinZDnXWoVsS94OHOxleFBpV2eNmXXYH66/tfuwnKbjwVE17ynrd6M?=
 =?iso-8859-1?Q?AugKnbrM7mc9pe6OfwlhAAelab+zQ6mtV1QdNzm076nyirOUJzhvh5/fc6?=
 =?iso-8859-1?Q?BKBGBHXNGj+Cj9fuEaRAHq7mMvZWIP9myuqNB74N6Uepyg+QxaLWlxyLog?=
 =?iso-8859-1?Q?aIIlBiTHIvkoq1WdAdD9uv1S7B8BH7et9V4bGroiKsDUuJ5VLx9gR78Zue?=
 =?iso-8859-1?Q?chEnEmhGm+0XyvolhTXmRtDwPn8eegY+H+Z/yVKYT3W0CB2uAuRrf1md5f?=
 =?iso-8859-1?Q?YIlU62c+phk1xW0poyd9/YFo3yQysdmowJidOb5IlT9ijwKi1AcC7C4G9m?=
 =?iso-8859-1?Q?xQiXqr7bNDrJpRTVrKYWQJagdueDx9TktGCGUGkUtkaceOEjo1T0puAwm6?=
 =?iso-8859-1?Q?YOZZ4AJSGmz7SKmAVUbanLgRm8x3I6HBpSo5WB8FOsPdwuqscjAdI0xbbF?=
 =?iso-8859-1?Q?jCIkq05EtdbZfDG+GOQBZIU4mqxjsOsKtBDt+R1A4l8o4Nkj2/I15JXOu4?=
 =?iso-8859-1?Q?6AfumLmkx8oQzdGIE0ryBSVezVFUzQdJESUpSVEwOqDKqEcfREd1tUYTOS?=
 =?iso-8859-1?Q?sYgGje8lw4gaXUOs6UgwDDWtwOT4S9F6wGKKE0LDMSmQDmj7RyZ32sAQvt?=
 =?iso-8859-1?Q?SgAe+q6iWHbewQngEHHMixUXJc30pvPOcvuQ66uMjFr4LFWVenYWRxE1Xa?=
 =?iso-8859-1?Q?FdKe1z+8oCHC55HFG78/GoAU5U5PNfagjqQHubI9Tc8j03Gbr8r6X91pnq?=
 =?iso-8859-1?Q?H8XYr3kO82CgJF77VUQpCel6q4lQ7mJTcY1/a+J5r1QZ+aPgxI1DDc6jvu?=
 =?iso-8859-1?Q?x+pcGkHfnWTXmaH19F3pWGmpyP1wADnn/LYaFMGzayeinjzm6BGkYujjon?=
 =?iso-8859-1?Q?s9ZZS+JCF+8AV+Q6Pok5MyLFRS1h/ZEKaUBNJIgLRUSxEZSgGcK58nyjTM?=
 =?iso-8859-1?Q?hdgYqAhxp16+QvSqp6ok9jpE6GUk7nsxrUNHhDSFVGd1WlHDWUHVCRGu1L?=
 =?iso-8859-1?Q?BETA88bmCsHIEy4pRgDuS2ZJG9a5uOoFKRkvUxW4V2KblGeS94X3h5YfpO?=
 =?iso-8859-1?Q?26hvgpGMyjbd6vFR3CeUmAIhw2yYZYGhWBhF265e3GV/+BXChcGpoh09x5?=
 =?iso-8859-1?Q?DvfkZ49/DSmhcfL+qHgoxOVnDchCxKfkXo6/jShw0/b5CaK//aWwu+PDzG?=
 =?iso-8859-1?Q?cA/MQ3s9XPLzVzdKV7uLU1pWhSNQG1+q2JmqK3fdQboZUw6JdamVb986I+?=
 =?iso-8859-1?Q?xx8E9NE0HjS0u52HhJnchetpwSMcewbvsLL3MlGzGv6ZstB0LYdXjYurou?=
 =?iso-8859-1?Q?zRFQTDGsE8rHMmxjA5Fqkfs79zavQjHLgua1iUSoPQS3xpyyvpZVM1Yqyp?=
 =?iso-8859-1?Q?ugWcVqv6varcz3P2QLxDE0Qt3VmUoS/KgGh94mhSHfKmesst9d/FYiZtl+?=
 =?iso-8859-1?Q?Fr9ElL0oLSpgoUS/TKvBKjFODwltivJi++PqfmKC4zyNQvt5VlpDppLnZf?=
 =?iso-8859-1?Q?i5hCFrpbxNxZ/4uCKgc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b9736b3-ee46-43fb-4eae-08de00cfc631
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2025 09:49:11.6145 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oplljIJgCvvRX9prAdXGg4zrDpzZnF40L4g+k5kcaXRFm28xbg+/CR6xv9ErjU4FQVPNgTbd4/1cHMA2D6LHj63UTt4KXLrVobnNSKaQpeE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR09MB8279
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
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
---
 target/riscv/cpu.c                        |  3 +++
 target/riscv/cpu_cfg.h                    |  2 +-
 target/riscv/cpu_cfg_fields.h.inc         |  1 +
 target/riscv/insn_trans/trans_xmips.c.inc | 15 +++++++++++++++
 target/riscv/xmips.decode                 |  1 +
 5 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 77fbf67776..87f9eb7ac4 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -247,6 +247,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
     ISA_EXT_DATA_ENTRY(svrsw60t59b, PRIV_VERSION_1_13_0, ext_svrsw60t59b),
     ISA_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
     ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
+    ISA_EXT_DATA_ENTRY(xmipscbop, PRIV_VERSION_1_12_0, ext_xmipscbop),
     ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
@@ -1380,6 +1381,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] =
=3D {
     MULTI_EXT_CFG_BOOL("xtheadmempair", ext_xtheadmempair, false),
     MULTI_EXT_CFG_BOOL("xtheadsync", ext_xtheadsync, false),
     MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
+    MULTI_EXT_CFG_BOOL("xmipscbop", ext_xmipscbop, false),
     MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
=20
     { },
@@ -3295,6 +3297,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
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

