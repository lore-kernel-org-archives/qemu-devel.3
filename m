Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46815CCD193
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Oct 2025 15:47:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vA97m-00055Z-D6; Sat, 18 Oct 2025 11:45:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vA97l-00054l-5U; Sat, 18 Oct 2025 11:45:41 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vA97j-0001QR-55; Sat, 18 Oct 2025 11:45:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YHoPgNNF0p30kZBiB+AJA7WLO9UCCZEaQ9oGnBVAAKNfhoAbAXJwwG6eJFWk0iXw29akQZw5nNv3Y6A5i0VHpYXlYdyNBzipk83JNJv6aeQ96TlvBnTNfPYL6wAXZZKFl5ETiPv7/aVJ61RMF2/k6meBxFslt157l2GU0aEWJS6WJzoB0MZgsxzOug1WOj5T+3l6D+6YnlG5vx02jbqr4jq4h3EATf3IM5SGVXSFLWKr6DLOi7DjqZoz74fy5pa9nUzdNFysU6yVPf1X+JyYmz9mdTQ9w/vP2N4jnAgJC0JO1L45eKUuh3tMG3Lfwi+HhveZ9AKTbJPk+63yIKHMnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EsPu9btCbW7DSJ7NChZhc6fp7/pC8mUVVI3PCreQbSw=;
 b=WbUPMmIH5ZtXUiYPO4qAfM+Z5wm/z7jrNOsOaBih2sqt/HeYmowVxYA9aQtTKbNwyWYar998hIKKd56V3z+pCAPLdIWKG3ZMUiB8p3yjct9rMF/yuOaRAZXPdkTCznkHBdKNUaiW+2jHLaJQNZS0ix0I5VIizru6zI4XLGrz50XGTjDHszyOw04Arjtu73KRvaphkcXZqArSZo9Xu50orfWggbdgchDInsjnCHJkPLvawG9p+2aVPqwkVkMwtR6hKzLH9JHbANlQTs+ELfEAnKn2FWkQRWQb/kPJqm5+l3NhbdCEWvOMltYcAA7hOCc+177BpvdJeK44Ae2aY34Deg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EsPu9btCbW7DSJ7NChZhc6fp7/pC8mUVVI3PCreQbSw=;
 b=aBY3FVd7boJV2XANThL2MI5lbhj3psQRWb8hVm8EZcIajMJLmWoADfbtXn9OZk5mRWvJyOhxEz3h6eHFm+LYxSsURZt6l9/6rSztWyDlY8Xvh4FobJOTo6pdCLIoXrAEXfsSa7ica4SZ6zUYKZh2z4Wag5rin4bpLyHjABJySUabXrvIQ2DkDCCkXmdqvn8zg2OnE8aXGz4mjCcM642wGKBMzXnfmze2Tu1IKdTqh1/2bTA3Q2R+QysfcinhU2k4bNsz+ut+8NHKLG3ADxD9qOr7d+qyN1k+oBOHXNvMFvfPR38BjFCqVUbJIqaH1RiMSmnVxDm/R5MFLMSJ0VoVbw==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by DB8PR09MB4360.eurprd09.prod.outlook.com (2603:10a6:10:154::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Sat, 18 Oct
 2025 15:45:29 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9228.014; Sat, 18 Oct 2025
 15:45:29 +0000
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
Subject: [PATCH v13 04/13] target/riscv: Add MIPS P8700 CSRs
Thread-Topic: [PATCH v13 04/13] target/riscv: Add MIPS P8700 CSRs
Thread-Index: AQHcQEY6MOnKyz/QQ0Glk6JMNyMp2g==
Date: Sat, 18 Oct 2025 15:45:29 +0000
Message-ID: <20251018154522.745788-5-djordje.todorovic@htecgroup.com>
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
x-ms-office365-filtering-correlation-id: 2cde611c-f284-412a-b03a-08de0e5d5d54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?ODj/x3fAf1NkAwH4/kfqwi8lAVcVo9h82qOdM/oPD5bdYKbap0GwQ3RgeL?=
 =?iso-8859-1?Q?Ts0j23D2noqUCC6MXtQ9Vr4EbyTUby8P/aBqI9A7rolWvORURCHExR18ZG?=
 =?iso-8859-1?Q?y/2lB7YSqAzs4AAZqtwMHsLCX8k2KHfsv9P99Ks58S+0PEGniYNgmfaaE6?=
 =?iso-8859-1?Q?O7EJiMivWCN44di1sVulxZ8Hz17oNbvnOMjuU25omE4g+WqxqM3LFSEoQJ?=
 =?iso-8859-1?Q?Z7S3z3tLNjldZvzkJ98Ckn1lzkGXtfxH66wTms1XDeK+wnF6V0VCf1WUnV?=
 =?iso-8859-1?Q?LLTaCdftVFajFEX0CmLnB45TXcp66j6kdc/GK9FeBLMjmzOdi1RZ31ra+I?=
 =?iso-8859-1?Q?a117Aaug1UFlq/Cj4CVHfuMoV2w4XMwxBFf5jB6FG3b54oTF2RcFqAKRlE?=
 =?iso-8859-1?Q?xQutO1Vg79MX2DQnMHbvLUy2K58DRmU8pjAUm4smbkKx5TUD3rEYjqV9n6?=
 =?iso-8859-1?Q?0WpyoSyZgp6BZtXg34w0zWJHQbZm38xgITVhLEXPVkFf3F4LBuGQ2KXps1?=
 =?iso-8859-1?Q?HZCt1FUTZRiaFw/7e8nPo7NAHNZa2UoioGYVOOttCrK2H5VUjhm2Ah8dPg?=
 =?iso-8859-1?Q?y5e4AyMxAbgYVDWorhSXzrtelxDBTYCRVLlQksQtwQabMQwyoFlQTT6ZFz?=
 =?iso-8859-1?Q?wZCBuklkRDW8cYWia6RzvCMbz0dzedwryI84nMuRVoyCFnmErm979nXuRj?=
 =?iso-8859-1?Q?2j/gAO3MoXR0sTtZQrzZrQz8BD5JSjFJHVzgsoemfTqOhPz3tb5kGWyLmZ?=
 =?iso-8859-1?Q?d/YhwhjN17RanqENPg9bffoShVJWVuCdzWtcPIIg2D6E3GQkIE/kPyZw9D?=
 =?iso-8859-1?Q?J1ZBo/TNCu6cZk3UWVdiEBmxe3dMxJ2sXo/dX9q5orAtoNARD6YQ2c3UgF?=
 =?iso-8859-1?Q?PHLue+SP862cm69wBEUdm8ezysHchCeYvrynG8EJX88O8+PBVOUGyQ96Jh?=
 =?iso-8859-1?Q?ep5c02N+kAZB59vxM004aZyEdh7PYmzyvFAvMFizRkKoCk9+vqZcmhUoN1?=
 =?iso-8859-1?Q?ISiG9KxX4qHFt732jf0BOyMLBtBWaFz7/UPvUweKDEejzroXQjsMeAh19n?=
 =?iso-8859-1?Q?rchb/KDRVC03P17EUSIpGtNKYFxs8LMJOMPlnk+bD1S9QxVKGujhOOIjQU?=
 =?iso-8859-1?Q?fz86Dmhkaox73S9OljFnTuP9jKjQJ597hJMc/0wykygALBtJ7hftPDZhjP?=
 =?iso-8859-1?Q?TxETZ2b7sXxD7Yd35ckEMnfR8DeHBe8I/h8JH1II5AKQn2wM4eyNKZhz2c?=
 =?iso-8859-1?Q?7ww14RzK9ZOMkXPjIk0zMIbI+F2D+2PQEitWxaKgwetFc47eGWbhxfjSPV?=
 =?iso-8859-1?Q?3RV+vAshyPM5RH/Ztf232sRg5/PiV+xi3prEu2I7Sz1WU3JtrisLTVtoNU?=
 =?iso-8859-1?Q?MvuA9KeQErWEgD68OcHgSw1ZyuPlJKOdgHMMaZwI5tQeTibYVwoOiaDSr9?=
 =?iso-8859-1?Q?FS7mcBVaAdbR074Fb8bbEAak2Hfq7hSCIbiYVbhkc13r72BdpP5LQxUckX?=
 =?iso-8859-1?Q?KmU5OR/yFr+/nxVHNw0l+epCfMoIPpK178MHaHZTkblVm8crdIuTfBO26D?=
 =?iso-8859-1?Q?j8HeLczyPfd8RCsPzYwbhr5HPy74?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?u95IkwslIRjzvgGkR4G3VbRgG9tPXKu7ENxPXcCZAsd2NZRsaU5JiS9jq/?=
 =?iso-8859-1?Q?TDfnwxpn9GO0Wt4s2jgLAMhTOA/nzpRIYLoEKClLTOfcShz6KFYRwiEBdz?=
 =?iso-8859-1?Q?1Qz99+k7M49ZgLLFYmWE0iKzX4+y1ptIpQW0JFaS//lgMjvTl/0wLJFm00?=
 =?iso-8859-1?Q?2r2h+fa5IYuf638a3f6sv6OLAe7pypB+sVp6zPBIp2OFz+Tbog8oaGrpVr?=
 =?iso-8859-1?Q?Uwdd33DWofh4a6iI6rT5wlDRddtIvKG8F2eCglsl9K9MM7pTDnRuNQdXhD?=
 =?iso-8859-1?Q?D7taRdpyTHjboSKLlkcjORdTbdwsM/jPlMGjDMFK5xA3AEhMxENVfkmvLS?=
 =?iso-8859-1?Q?E644Vq4Ces/0yVGJcFPLfMznpEE2Mw6JJPaCjd3fNUrOoAy4E/EHYb211m?=
 =?iso-8859-1?Q?jPr9HyU/S1F0Eco3psmwHvx537fj0uMGZIw+KYuQF5crTeSP2K9nyGs0UI?=
 =?iso-8859-1?Q?UfXEUejZzolJjjEvGif6kutATNoxL31UA2nJNptxEsTz2ACh9MTEcbWVJi?=
 =?iso-8859-1?Q?v3VhjH5ablG8e4Hk2HdBH1xUUS1Y4A32iJRaJz0iHFbwsg3AggOabqdEFL?=
 =?iso-8859-1?Q?CE6XmwUG8V18xjX+s8jJxShLF6MUOayfxALtvC4Ns5vF6UTFHdz6GpNW0Q?=
 =?iso-8859-1?Q?zu2LD72/fFJpWGLaVaZVjzGsZMjc7Xl5GF+Reskwu9DRFRz7+vUYMbiBNi?=
 =?iso-8859-1?Q?5tA7C/PLsNmCVuehx1b0Fm9S68e2el9d0MilOFRrPKaCbFZR2RkuoYJh9O?=
 =?iso-8859-1?Q?sQBBLvzjzMFPeYwTxqGpTGL3m9A6paUmcgQGJum4jOCRz/ByADWPL4qRM5?=
 =?iso-8859-1?Q?oEjTeEvd9/JZMZxj7TGACTwwgnAccWMUj+31Ap1nTgR7r3LE+oG9GyxHO5?=
 =?iso-8859-1?Q?ta0VWV64AcHj0NI5EqdtlVKqKKyoiS8kbUSj8S8J9tJ7Yz5xRf1nB98jX1?=
 =?iso-8859-1?Q?7FKpXYDkrvq5BEMG7Cv800CM7h3mp93O/Jk6N0p4Zp36h+bkwOfXIROZeN?=
 =?iso-8859-1?Q?q4CYinW42KEWSaRP5EDBbqs+/yZewiuTDVif7yOjZJzx6AF71DYhnOUvJN?=
 =?iso-8859-1?Q?vtNfBHOvmtfBQhRvmdK9LqGzS0jh+hUG/z2+GGx0zoMrl3rgabQ4ty1CIf?=
 =?iso-8859-1?Q?ki5xCRpO9T/EMf8imjuxOLA7cjlzhrB4bZn7SEz5NDwKlL6QfJJfoV1Ml3?=
 =?iso-8859-1?Q?YW3B9QoOuAk1xKIWxbN1c8NcUXhnfJL6dWdIJjXlEQDXP4v7p4Fr97YNen?=
 =?iso-8859-1?Q?s1VnArwBOuYKCqVVQ5vZpdle5VCEzxmGauqyDXaVNwxCuyBMmvL1GcA3ad?=
 =?iso-8859-1?Q?T2jp+2AMOmtguizRKzXIBKF/VYVNEnRkc1NudLzaA5F48q+3OV/kX0N3F5?=
 =?iso-8859-1?Q?EGqp5moW+qsWLtN+G8l8ZmEXUQMs0xg8Q89viZckozOKczbYdI1UB2K17o?=
 =?iso-8859-1?Q?IsO3jntIzyUw7yEN43jtAMqVpfPW68b4QjcxTChpLHysytU6pTE3T+oVbt?=
 =?iso-8859-1?Q?tUFPsxVOBrw5AQO30dfPrSucYpKebylGbqXxPsRCANQZ3X0AKb161d2s7D?=
 =?iso-8859-1?Q?1pjxQALvjMZb6PHXyV//pTR95vpI1EKB9PrSEv4IwkJB1NgJMwbs0RDbwX?=
 =?iso-8859-1?Q?gVcqin8idSGlg0Rw9nsOkkj9K4CykoAFVOyuj4Rb4lzRZ+itY1v6PEe0Qo?=
 =?iso-8859-1?Q?tSg5wdTWSPbPy52q3XU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cde611c-f284-412a-b03a-08de0e5d5d54
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2025 15:45:29.2356 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zPfVKyj41pldJqgbGkTFi0ZiZQ1vRa6Qvabse+MidlaOzFJ0A+AB2iJ526v1HZIMHKDx9o0Sk0lo+FrOM35O4eANzbQKMzUt0cb7UYatQrY=
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

Define MIPS CSRs used for P8700 CPU.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c       |   3 +
 target/riscv/cpu.h       |   3 +
 target/riscv/meson.build |   1 +
 target/riscv/mips_csr.c  | 217 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 224 insertions(+)
 create mode 100644 target/riscv/mips_csr.c

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index cd4e442bdb..2fd0ced25f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3297,6 +3297,9 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .cfg.ext_zbb =3D true,
         .cfg.marchid =3D 0x8000000000000201,
         .cfg.mvendorid =3D MIPS_VENDOR_ID,
+#ifndef CONFIG_USER_ONLY
+        .custom_csrs =3D mips_csr_list,
+#endif
     ),
=20
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 34751bd414..234210c6b6 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -987,5 +987,8 @@ const char *satp_mode_str(uint8_t satp_mode, bool is_32=
_bit);
 /* In th_csr.c */
 extern const RISCVCSR th_csr_list[];
=20
+/* Implemented in mips_csr.c */
+extern const RISCVCSR mips_csr_list[];
+
 const char *priv_spec_to_str(int priv_version);
 #endif /* RISCV_CPU_H */
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index fdefe88ccd..25d59ef9f9 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -36,6 +36,7 @@ riscv_system_ss.add(files(
   'debug.c',
   'monitor.c',
   'machine.c',
+  'mips_csr.c',
   'pmu.c',
   'th_csr.c',
   'time_helper.c',
diff --git a/target/riscv/mips_csr.c b/target/riscv/mips_csr.c
new file mode 100644
index 0000000000..822e25e346
--- /dev/null
+++ b/target/riscv/mips_csr.c
@@ -0,0 +1,217 @@
+/*
+ * MIPS-specific CSRs.
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "cpu_vendorid.h"
+
+/* Static MIPS CSR state storage */
+static struct {
+    uint64_t tvec;
+    uint64_t config[12];
+    uint64_t pmacfg[16];
+} mips_csr_state;
+
+/* MIPS CSR */
+#define CSR_MIPSTVEC        0x7c0
+#define CSR_MIPSCONFIG0     0x7d0
+#define CSR_MIPSCONFIG1     0x7d1
+#define CSR_MIPSCONFIG2     0x7d2
+#define CSR_MIPSCONFIG3     0x7d3
+#define CSR_MIPSCONFIG4     0x7d4
+#define CSR_MIPSCONFIG5     0x7d5
+#define CSR_MIPSCONFIG6     0x7d6
+#define CSR_MIPSCONFIG7     0x7d7
+#define CSR_MIPSCONFIG8     0x7d8
+#define CSR_MIPSCONFIG9     0x7d9
+#define CSR_MIPSCONFIG10    0x7da
+#define CSR_MIPSCONFIG11    0x7db
+#define CSR_MIPSPMACFG0     0x7e0
+#define CSR_MIPSPMACFG1     0x7e1
+#define CSR_MIPSPMACFG2     0x7e2
+#define CSR_MIPSPMACFG3     0x7e3
+#define CSR_MIPSPMACFG4     0x7e4
+#define CSR_MIPSPMACFG5     0x7e5
+#define CSR_MIPSPMACFG6     0x7e6
+#define CSR_MIPSPMACFG7     0x7e7
+#define CSR_MIPSPMACFG8     0x7e8
+#define CSR_MIPSPMACFG9     0x7e9
+#define CSR_MIPSPMACFG10    0x7ea
+#define CSR_MIPSPMACFG11    0x7eb
+#define CSR_MIPSPMACFG12    0x7ec
+#define CSR_MIPSPMACFG13    0x7ed
+#define CSR_MIPSPMACFG14    0x7ee
+#define CSR_MIPSPMACFG15    0x7ef
+
+static RISCVException any(CPURISCVState *env, int csrno)
+{
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_mipstvec(CPURISCVState *env, int csrno,
+                                    target_ulong *val)
+{
+    *val =3D mips_csr_state.tvec;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_mipstvec(CPURISCVState *env, int csrno,
+                                     target_ulong val, uintptr_t ra)
+{
+    mips_csr_state.tvec =3D val;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_mipsconfig(CPURISCVState *env, int csrno,
+                                      target_ulong *val)
+{
+    *val =3D mips_csr_state.config[csrno - CSR_MIPSCONFIG0];
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_mipsconfig(CPURISCVState *env, int csrno,
+                                       target_ulong val, uintptr_t ra)
+{
+    mips_csr_state.config[csrno - CSR_MIPSCONFIG0] =3D val;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_mipspmacfg(CPURISCVState *env, int csrno,
+                                      target_ulong *val)
+{
+    *val =3D mips_csr_state.pmacfg[csrno - CSR_MIPSPMACFG0];
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_mipspmacfg(CPURISCVState *env, int csrno,
+                                       target_ulong val, uintptr_t ra)
+{
+    mips_csr_state.pmacfg[csrno - CSR_MIPSPMACFG0] =3D val;
+    return RISCV_EXCP_NONE;
+}
+
+const RISCVCSR mips_csr_list[] =3D {
+    {
+        .csrno =3D CSR_MIPSTVEC,
+        .csr_ops =3D { "mipstvec", any, read_mipstvec, write_mipstvec }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG0,
+        .csr_ops =3D { "mipsconfig0", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG1,
+        .csr_ops =3D { "mipsconfig1", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG2,
+        .csr_ops =3D { "mipsconfig2", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG3,
+        .csr_ops =3D { "mipsconfig3", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG4,
+        .csr_ops =3D { "mipsconfig4", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG5,
+        .csr_ops =3D { "mipsconfig5", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG6,
+        .csr_ops =3D { "mipsconfig6", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG7,
+        .csr_ops =3D { "mipsconfig7", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG8,
+        .csr_ops =3D { "mipsconfig8", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG9,
+        .csr_ops =3D { "mipsconfig9", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG10,
+        .csr_ops =3D { "mipsconfig10", any, read_mipsconfig, write_mipscon=
fig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG11,
+        .csr_ops =3D { "mipsconfig11", any, read_mipsconfig, write_mipscon=
fig }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG0,
+        .csr_ops =3D { "mipspmacfg0", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG1,
+        .csr_ops =3D { "mipspmacfg1", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG2,
+        .csr_ops =3D { "mipspmacfg2", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG3,
+        .csr_ops =3D { "mipspmacfg3", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG4,
+        .csr_ops =3D { "mipspmacfg4", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG5,
+        .csr_ops =3D { "mipspmacfg5", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG6,
+        .csr_ops =3D { "mipspmacfg6", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG7,
+        .csr_ops =3D { "mipspmacfg7", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG8,
+        .csr_ops =3D { "mipspmacfg8", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG9,
+        .csr_ops =3D { "mipspmacfg9", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG10,
+        .csr_ops =3D { "mipspmacfg10", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG11,
+        .csr_ops =3D { "mipspmacfg11", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG12,
+        .csr_ops =3D { "mipspmacfg12", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG13,
+        .csr_ops =3D { "mipspmacfg13", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG14,
+        .csr_ops =3D { "mipspmacfg14", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG15,
+        .csr_ops =3D { "mipspmacfg15", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    { },
+};
--=20
2.34.1

