Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0822CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 09:25:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1LeV-0003kU-Mf; Wed, 24 Sep 2025 05:19:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v1LeE-0003fP-Qm; Wed, 24 Sep 2025 05:18:53 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v1LeB-0002zm-7f; Wed, 24 Sep 2025 05:18:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eyQKmH20O14QfUQkY6FjZSuX6DaRSsGmqYV5YPll66AkxhGZAvtBJYXCSC6XAG/giSDh36L4NROzyMmWHAtuj/3pFS0STt+bIYdOU0Qb2mbsPtUsUI+4KWtLNUSEVbfK/k7WoDFjPeTHsJlPhnrzKUBaSQ2f2a3vdzW2wsa4dvzr/S/crz8Mw47exJLActkSbzb1q3ewAAA2e5ouvdJjBaDvsVch+EwIG1Q1NeJi5kFY0FHLiUFmiUqUOt7fNzPRfwHztQoJFHUSul4+/J0ChFS+aDl/gyEVc3U9HvzrBMI3zKZtycF+v8xQa6ainWJbNY5FBiCdjPrm8TggaUSNig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7XlxwrqVkHvTj/AAUkQTbzOEMhbDMll6V6Uf34dgwRM=;
 b=RDC+94ZlxPAbWB4FE7Ua268AEGqWA/daa+kjYvJsrmCdz5tY3Ac5Qbo9vqAiXOmcIP0TMYguax6kVngQB8knOt39cUCRWWCmg8P1oV2xs+ke7Dv4AK+BOJ0zwTUrJezQPU1WSBz6rKZG7/RYnvAErsHvAsRqpyzM4uQWCi+noNAodC/ZipRBSUwINXjvPEwYWRURmuQUgLynY3ad2oMbp2DVSW/epuqGfYaHjudIXSNQ/rv5ODmr+o/BHb+uVoaHrBltsHZgTG1AdzfBB00QNDR93A4VFf2v3TyyXU2hY6Z8LG5DaG6VLHZYimNCULQdaHeaLASViK9keg6LA2mHhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XlxwrqVkHvTj/AAUkQTbzOEMhbDMll6V6Uf34dgwRM=;
 b=eWxbnT1l0G2Yg3971sWTsp2RfsMfezBbrVTy0QgcpKHiajMDR3F1aHKAZLRtszNrTWuRqB9Wjtc2rt6s8yUtuqUm+hXJIE4VoyHVt+jO8gWAcHDyNHlkZtm6SLX1DzVvCzCQKYJhWschFQbcd94nNOfZd48gYY4OJvoAzENsGHs4hGXo9N4gGHaBzRieUYS9eutHOf2x6P9+pppHNbE3CK/Hibo7td1MCPLC2jLt94wxKvEBYyOBbA7W1iSYPvTjcEPVcNevEnsRDqn6yNGxW8ectOqPKMXylz12QVWrBEx4RRSSpFx5LBTjPvUz7SZS/fqG+ceS15pjHlGqQwZD4w==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by VI0PR09MB7826.eurprd09.prod.outlook.com (2603:10a6:800:21b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 09:18:20 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 09:18:20 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v8 07/14] target/riscv: Add Xmipslsp instructions
Thread-Topic: [PATCH v8 07/14] target/riscv: Add Xmipslsp instructions
Thread-Index: AQHcLTQo3J6x/wWIPEGI4hcbGPHzAA==
Date: Wed, 24 Sep 2025 09:18:15 +0000
Message-ID: <20250924091746.1882125-8-djordje.todorovic@htecgroup.com>
References: <20250924091746.1882125-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250924091746.1882125-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|VI0PR09MB7826:EE_
x-ms-office365-filtering-correlation-id: 30938298-de70-4c84-0e8a-08ddfb4b4da6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?i8kIpyoH2d+iGL90DvlvlUN+seLYEMafLwaliAQ0p6xutDuSUn2A4sRFlj?=
 =?iso-8859-1?Q?W3vGdjl4kkHv6iUXRGnly41VxHpSzOhFonSi5Pn1R9tkpNzaVOM04qqt/8?=
 =?iso-8859-1?Q?TUhcwPU719lk2/TwzQ5Az+5mhX7CPu+VGo2A5KDfkEyKoOLNvyGSvynvTs?=
 =?iso-8859-1?Q?xtBd3kcIWPEOF5z3iw9pNpJj8RNxbJIe3d2gfq9QfQy7cvamaFtlbX+ciC?=
 =?iso-8859-1?Q?7HigqSxuWGBheVM3tfOux3+nAXt9z3Z8LOSXl2BJ/Ls0UesIQa2QnLDjSJ?=
 =?iso-8859-1?Q?Xd2Wsc2R3zV0g+aM4o2k+ATdpZQs+HmpbMSEgsmBzGJYllfFVhR2CGrJKF?=
 =?iso-8859-1?Q?AG1cHXyDbEK0jbX6iyvF5h66yoN83H55zfqOeifMBnqyRkdDXdk5Ioh81C?=
 =?iso-8859-1?Q?fM73F4vvaGN/yuKUJuhTE2fi9V8G/mcoo771tjpyge2w1Y93z2QN9yGwHf?=
 =?iso-8859-1?Q?MnJ8JgNbRtja4yhSzJtB816akFqB854xN7dSotQhUGMld83tzqz1rVS+kL?=
 =?iso-8859-1?Q?wjGgAi9el5HobLfLRqD3WiGRr3dXjXpF5LDcdaVttCp63Xh4uMRAUVJf/n?=
 =?iso-8859-1?Q?xLgV36IQziWbElDPl62NmIra3I4rs/v8aoHO6DJmu+JDKVDOUYwP8qz2U/?=
 =?iso-8859-1?Q?42N5iFFM6dTZzKO89S6MsqA5UIjgl+jjoJT8NVUxx/IG7QeIvh5NmaFlec?=
 =?iso-8859-1?Q?hPF3+KrBtCtDjx1VcS7OjLMIq1K0ziEuiTvNpePc2jWEfO/xxtUV1Mrq4d?=
 =?iso-8859-1?Q?qK9fIw5/+LRxBesFuMb8A0mFGs838RWDrx5bulhqoPD17pYhahaeevAu5W?=
 =?iso-8859-1?Q?hfVuqertbpgk/xHq+O/ypwhIg+r2jD3FQwT/jrtAhwInJHaJqheeQp8rqc?=
 =?iso-8859-1?Q?V59Klcs7dO6pAvBk/Fvuu09mGWRNmJEZHM9QGWBEOIKp3fK47LyLkSHIAu?=
 =?iso-8859-1?Q?Sbf3WrUNyxU/+omGjMYsE0pJ9n5Z5RieRv4dfEn8C8MhohglZdNE8aOzAe?=
 =?iso-8859-1?Q?JJJK1kcdFZ1NewSa+5b+gV1F0d9KaLx9q/wybbvtBklnDolmUPGnXCC0Sk?=
 =?iso-8859-1?Q?2GEBcsE8JLqONEWYfpx4t+K7dU9kUMZXY8ZYQuvZJ1ApgTrpSwlDEM3A3v?=
 =?iso-8859-1?Q?We0n4dWjF06LpqEhiTcgOSX4UOnSfC/dgCLP1Bswu0+jqPnWEwjI0leq6d?=
 =?iso-8859-1?Q?rMFhhqCff7A4BgxPWmxvF+7S6LypnJSzdMOVhVebunXGCeOYZ9gBHvYy8c?=
 =?iso-8859-1?Q?43C7RLa/ZQVRinHEIoyr0V2OnKyJLrE9CLips1XgL/bRau1Nc2ujJ42slD?=
 =?iso-8859-1?Q?v27bDWk4Ej8L8F6uVYwtail/P8HB85ZKNBGHnVDa0W4WlE8eQ5RHTNEFQZ?=
 =?iso-8859-1?Q?2DSeJyV/EbjHkGFE82dqP8qBpec+Z7UYZih5Gm2vr/zAySykEJ4Un0rsnh?=
 =?iso-8859-1?Q?/4FuhdTRE03QUBaounnrp3tg4sn6rqDm9yD1BGMC68xJtVk+Qm3FiUTE3V?=
 =?iso-8859-1?Q?U=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?eLdnmSO5ogMI2IPwd+M+eM8MtSfPRV4wvoP6WaF5KkHrCEZLXnzuH6yMGn?=
 =?iso-8859-1?Q?SLxRmX53OJNquIZNetTKrj3l/ibQgNSLzlUbjNUxf3d5rnVYJ+q9QWTj4Q?=
 =?iso-8859-1?Q?7s3Q7bz3U9TBoD69NfOXDfAM9W3qrEX+7ORg8/hqj7CjoUGttzjMs/tLu0?=
 =?iso-8859-1?Q?l8aaOOEYYcfsbZ+T/9nBe7zD8Wy84lxNCg2YxhuuRSncew7OgbNB8o2C1U?=
 =?iso-8859-1?Q?WtGhnddWwTC7ou90eNG4cBEFD5E4xyPLpNm/Zy/oVT4Lp035uRwEHr6WM8?=
 =?iso-8859-1?Q?F7xRqlipstuu0uBP++hEabKrHV1gu/5FNmPbBsS8GJxEihRx1Am4bcfQdA?=
 =?iso-8859-1?Q?22nsIrKqFqL3klawlSEWlXGAIBl3xzArVYSBwSrQ1mNNutgX/zRBlw4POQ?=
 =?iso-8859-1?Q?MKOHyFRGwNzGkJWF2QURSp9K4H69FWWK6mf903LTW8CLINs5l6FarmcTem?=
 =?iso-8859-1?Q?esyplknTYMAS9mXpzqfZNGw5Ea3p6SBDU4ZfOxL1HAj1uOSgGbq9eXLv51?=
 =?iso-8859-1?Q?5EZr03ZzX4LeglQxv0UX3lSSjYdfel9nyaxSVXaFAYLYWXGOAWUm6KDWsi?=
 =?iso-8859-1?Q?n2sO7OBa1n5zfrEsBG5eF6zW6YeADSWIPznop8adK3pahiJtL7OpJFHgeh?=
 =?iso-8859-1?Q?mwcR1AW+/3Jybn9JX7rHCubBo0FKmmZ82gYLeI9LT2jrrB6UP490N9RXj2?=
 =?iso-8859-1?Q?PbBUQgZtnEdo5l41LSrd3yJVzPtPw2Hi3Y/Ny8qp7uXlwBWCPXw6265WZT?=
 =?iso-8859-1?Q?qi9R6DlNpMqwDsxI/YkT80bRyit90w7Q+vEUo+d5L79iH9WaWbKy9oy3xl?=
 =?iso-8859-1?Q?zuEsj2YdjbcOSN7W9Qns4FERXi/tV+5KKoRQLIZba13nZRvAqdE1ORWwC2?=
 =?iso-8859-1?Q?NXtkVzpBJsRNWB6/nmcedoqwKcBkRB3geStoqwxCLMk6+r+G8VJNxmZwN6?=
 =?iso-8859-1?Q?SWicVKmg65Pqf7Rdc58TffbdCiMce8X8nlvzIwQ1hiapbBRJOhjTW2QmGD?=
 =?iso-8859-1?Q?ciQuhPMJ2FYw2Az32HyAGEktO9foRZfvylbRGHHID9xf//+FmLIFMSeq73?=
 =?iso-8859-1?Q?S78MAAit5t6tC4rYhKPSPzGT8phNqWqguXpPFgqG/Gux+x0tYktS37x8dj?=
 =?iso-8859-1?Q?eBMLpBfGbAQfURIfRKmtfvK+FEE8GfixcE3D4Ijp4T0wJSSK01K1IoXNXa?=
 =?iso-8859-1?Q?2UbQVNUiyEKp4n6Sk610s5Qq2aux5jYVYrUNHyHHk37X21DOD4xokKW+6s?=
 =?iso-8859-1?Q?wYymusFLhXvlqe5sg300KhsX4hFbawno45BruouDL1D2n8wQvh1wva9v00?=
 =?iso-8859-1?Q?l8jNnERhv4t96qEh89S1Lk1OFFeNbTWuUuY5Oz+9UGhoHx/TxQQPSCTKWj?=
 =?iso-8859-1?Q?aod1tlFRExXvHCrATwE5eF705Z7t7Q4Xf+b/M7sXFZUc/JagucrcUHMP2o?=
 =?iso-8859-1?Q?DpBHQNn8EVyTojG9AGlTIZ+UNaVmjbL5K+7yD6GltuxpY3VEpqVndSiBZm?=
 =?iso-8859-1?Q?pHbew5Xf8Nuq3IfC6OBBxt8+6UyfLoFa2JRcJBtijiL5ToRIl1/pdOnxNh?=
 =?iso-8859-1?Q?frCEhbCslRtk/rtFop7GsTFeaz6rWyTuDVIACxGpy30XlUNJxFRjOvp/OM?=
 =?iso-8859-1?Q?MKekdWrhN7BekVASKykgJbzDvA/X+b0P/bxMYAFnPAjAZcrfztCdK73+HC?=
 =?iso-8859-1?Q?ovJGfi/mNlEGttsoMT8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30938298-de70-4c84-0e8a-08ddfb4b4da6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 09:18:15.7986 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oRRF4gT9GTVEZDx0QskP3YD9fVQuUmNxIGqEFaq5WaA9Ts4fG6XytInxYzyi9ADA4sDxGpsVMieMll1IlwwFH4vpt5fCtAowTdGaxvIwf4M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR09MB7826
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

Add MIPS P8700 ldp, lwp, sdp, swp instructions.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Acked-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c                        |  3 +
 target/riscv/cpu_cfg.h                    |  2 +-
 target/riscv/cpu_cfg_fields.h.inc         |  1 +
 target/riscv/insn_trans/trans_xmips.c.inc | 84 +++++++++++++++++++++++
 target/riscv/xmips.decode                 | 23 +++++++
 5 files changed, 112 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 87f9eb7ac4..964b995269 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -249,6 +249,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
     ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
     ISA_EXT_DATA_ENTRY(xmipscbop, PRIV_VERSION_1_12_0, ext_xmipscbop),
     ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
+    ISA_EXT_DATA_ENTRY(xmipslsp, PRIV_VERSION_1_12_0, ext_xmipslsp),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
     ISA_EXT_DATA_ENTRY(xtheadbs, PRIV_VERSION_1_11_0, ext_xtheadbs),
@@ -1383,6 +1384,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] =
=3D {
     MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
     MULTI_EXT_CFG_BOOL("xmipscbop", ext_xmipscbop, false),
     MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
+    MULTI_EXT_CFG_BOOL("xmipslsp", ext_xmipslsp, false),
=20
     { },
 };
@@ -3297,6 +3299,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .cfg.pmp =3D true,
         .cfg.ext_zba =3D true,
         .cfg.ext_zbb =3D true,
+        .cfg.ext_xmipslsp =3D true,
         .cfg.ext_xmipscbop =3D true,
         .cfg.ext_xmipscmov =3D true,
         .cfg.marchid =3D 0x8000000000000201,
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index e4d5039c49..cd1cba797c 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -38,7 +38,7 @@ static inline bool always_true_p(const RISCVCPUConfig *cf=
g __attribute__((__unus
=20
 static inline bool has_xmips_p(const RISCVCPUConfig *cfg)
 {
-    return cfg->ext_xmipscbop || cfg->ext_xmipscmov;
+    return cfg->ext_xmipscbop || cfg->ext_xmipscmov || cfg->ext_xmipslsp;
 }
=20
 static inline bool has_xthead_p(const RISCVCPUConfig *cfg)
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_field=
s.h.inc
index dd3ee7ba2b..7c624ab677 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -149,6 +149,7 @@ BOOL_FIELD(ext_xtheadsync)
 BOOL_FIELD(ext_XVentanaCondOps)
 BOOL_FIELD(ext_xmipscbop)
 BOOL_FIELD(ext_xmipscmov)
+BOOL_FIELD(ext_xmipslsp)
=20
 BOOL_FIELD(mmu)
 BOOL_FIELD(pmp)
diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/insn_=
trans/trans_xmips.c.inc
index 95b8238081..192154e7c7 100644
--- a/target/riscv/insn_trans/trans_xmips.c.inc
+++ b/target/riscv/insn_trans/trans_xmips.c.inc
@@ -21,6 +21,12 @@
     }                                            \
 } while (0)
=20
+#define REQUIRE_XMIPSLSP(ctx) do {               \
+    if (!ctx->cfg_ptr->ext_xmipslsp) {           \
+        return false;                            \
+    }                                            \
+} while (0)
+
 static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
 {
     REQUIRE_XMIPSCMOV(ctx);
@@ -37,6 +43,84 @@ static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
     return true;
 }
=20
+static bool trans_ldp(DisasContext *ctx, arg_ldp *a)
+{
+    REQUIRE_XMIPSLSP(ctx);
+    REQUIRE_64_OR_128BIT(ctx);
+
+    TCGv src =3D get_gpr(ctx, a->rs1, EXT_NONE);
+    TCGv dest0 =3D dest_gpr(ctx, a->rd);
+    TCGv dest1 =3D dest_gpr(ctx, a->rs3);
+    TCGv addr =3D tcg_temp_new();
+
+    tcg_gen_addi_tl(addr, src, a->imm_y);
+    tcg_gen_qemu_ld_tl(dest0, addr, ctx->mem_idx, MO_TESQ);
+    gen_set_gpr(ctx, a->rd, dest0);
+
+    tcg_gen_addi_tl(addr, addr, 8);
+    tcg_gen_qemu_ld_tl(dest1, addr, ctx->mem_idx, MO_TESQ);
+    gen_set_gpr(ctx, a->rs3, dest1);
+
+    return true;
+}
+
+static bool trans_lwp(DisasContext *ctx, arg_lwp *a)
+{
+    REQUIRE_XMIPSLSP(ctx);
+
+    TCGv src =3D get_gpr(ctx, a->rs1, EXT_NONE);
+    TCGv dest0 =3D dest_gpr(ctx, a->rd);
+    TCGv dest1 =3D dest_gpr(ctx, a->rs3);
+    TCGv addr =3D tcg_temp_new();
+
+    tcg_gen_addi_tl(addr, src, a->imm_x);
+    tcg_gen_qemu_ld_tl(dest0, addr, ctx->mem_idx, MO_TESL);
+    gen_set_gpr(ctx, a->rd, dest0);
+
+    tcg_gen_addi_tl(addr, addr, 4);
+    tcg_gen_qemu_ld_tl(dest1, addr, ctx->mem_idx, MO_TESL);
+    gen_set_gpr(ctx, a->rs3, dest1);
+
+    return true;
+}
+
+static bool trans_sdp(DisasContext *ctx, arg_sdp *a)
+{
+    REQUIRE_XMIPSLSP(ctx);
+    REQUIRE_64_OR_128BIT(ctx);
+
+    TCGv src =3D get_gpr(ctx, a->rs1, EXT_NONE);
+    TCGv data0 =3D get_gpr(ctx, a->rs2, EXT_NONE);
+    TCGv data1 =3D get_gpr(ctx, a->rs3, EXT_NONE);
+    TCGv addr =3D tcg_temp_new();
+
+    tcg_gen_addi_tl(addr, src, a->imm_w);
+    tcg_gen_qemu_st_tl(data0, addr, ctx->mem_idx, MO_TEUQ);
+
+    tcg_gen_addi_tl(addr, addr, 8);
+    tcg_gen_qemu_st_tl(data1, addr, ctx->mem_idx, MO_TEUQ);
+
+    return true;
+}
+
+static bool trans_swp(DisasContext *ctx, arg_swp *a)
+{
+    REQUIRE_XMIPSLSP(ctx);
+
+    TCGv src =3D get_gpr(ctx, a->rs1, EXT_NONE);
+    TCGv data0 =3D get_gpr(ctx, a->rs2, EXT_NONE);
+    TCGv data1 =3D get_gpr(ctx, a->rs3, EXT_NONE);
+    TCGv addr =3D tcg_temp_new();
+
+    tcg_gen_addi_tl(addr, src, a->imm_v);
+    tcg_gen_qemu_st_tl(data0, addr, ctx->mem_idx, MO_TESL);
+
+    tcg_gen_addi_tl(addr, addr, 4);
+    tcg_gen_qemu_st_tl(data1, addr, ctx->mem_idx, MO_TESL);
+
+    return true;
+}
+
 static bool trans_pref(DisasContext *ctx, arg_pref *a)
 {
     REQUIRE_XMIPSCBOP(ctx);
diff --git a/target/riscv/xmips.decode b/target/riscv/xmips.decode
index 4215813b32..3174f17aa4 100644
--- a/target/riscv/xmips.decode
+++ b/target/riscv/xmips.decode
@@ -8,5 +8,28 @@
 # Reference: MIPS P8700 instructions
 #            (https://mips.com/products/hardware/p8700/)
=20
+# Fields
+%rs3       27:5
+%rs2       20:5
+%rs1       15:5
+%rd        7:5
+%imm_9     20:9
+%imm_hint  7:5
+%imm_v     25:2 9:3               !function=3Dex_shift_2
+%imm_w     25:2 10:2              !function=3Dex_shift_3
+%imm_x     22:5                   !function=3Dex_shift_2
+%imm_y     23:4                   !function=3Dex_shift_3
+
+# Formats
+@r4_immv ..... .. ..... ..... ... ... .. ....... %rs2 %rs3 %imm_v %rs1
+@r4_immw ..... .. ..... ..... ... .. ... ....... %rs2 %rs3 %imm_w %rs1
+@r4_immx ..... .....  .. ..... ... ..... ....... %rs3 %imm_x %rs1 %rd
+@r4_immy ..... ....  ... ..... ... ..... ....... %rs3 %imm_y %rs1 %rd
+
+# *** RV64 MIPS Extension ***
 ccmov          rs3:5 11 rs2:5 rs1:5 011 rd:5 0001011
 pref        000 imm_9:9 rs1:5 000 imm_hint:5 0001011
+ldp         ..... .... 000 ..... 100 .....  0001011 @r4_immy
+lwp         ..... ..... 01 ..... 100 .....  0001011 @r4_immx
+sdp         ..... .. ..... ..... 101 ..  0000001011 @r4_immw
+swp         ..... .. ..... ..... 101 ...  010001011 @r4_immv
--=20
2.34.1

