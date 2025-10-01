Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E3FDCCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 09:50:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3tTJ-0004V7-Qa; Wed, 01 Oct 2025 05:50:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v3tSj-0004Mj-V6; Wed, 01 Oct 2025 05:49:32 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v3tSc-0004vh-Cr; Wed, 01 Oct 2025 05:49:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U9hp4o+UBENBgHMOZhtUvJUghpYy3iveb0/gt1sbXy5VBakgwLAScZYk6uaNvWpM//LA/THLlQCiMVIeq7By1NtfOfKNK/4e402bpQ6MHljXK3Xq/1Ov3Yo5cw56Ib3nJC9Nf9sS0e49X4PC+nVK6hqJZFMbZ9TSZTcYVYF4aw9Ygj4h7L2DpLibOADM2pSCWnsuPJZRs5iimPZ8jykLxmyIWs7WoscvODWurbggfSj9Diex2+iCrIqerlT4lU1Kb7AyyPBMjF36naTjd8tlEmgIBIlsZ5vcRxWvAf7rxmALemFsDwoIw+l95SdDxUhe+onfpDuGBlC8iwJcAQxzuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6uA4Ogk+XKGtJQLa+9YipJAohxIbmI4d6AifflQB8yU=;
 b=PYbpNNJ/h81m5QEJ7qk5dxEUVRTbqS1MMdcSKXXXe8pHTI2ZWniTqRC51xi7QXl88u8siNk7Z6LYZ0pdgPe4QLayvNvueheyD3tgNraC5BUIccWsUAhSCHqOXD82Bilf38tktTVoSu0rdVflTL32ojXr1FI5l8KrElk+TWVyc7T2RjvGPEsjB5BOx8GwODh5Cme8UP9weorFtISNG8ujGV6+9Vgo82ExyoYfovErcgFnDuB/d1tO5LrQfctr/kPHevi8gIqWkba6XtQ2upbMx4/zKl1vHnF62JOzgCFK7oL4fuL/Px6FbP9rJzu9w1jFuSjAdUIHWUEmF/4SaZPz5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6uA4Ogk+XKGtJQLa+9YipJAohxIbmI4d6AifflQB8yU=;
 b=SLeHF6wTQuYdx6qy55y/RJMOjy2ASlnEOiY9sIbx9h6nDRWp3IFmyeAg7jiAovr2MJrSNh6Vcad1HoeTXi0zkwzHjdgOC1tJYd/kROnrGvmOvADTEbDZcczu3Icszmv9a2Y5IQOgyrdwvJvDLJpdX3seKczF0kuz61ToaZd8U85xk18xCoSUsDTSFFK6Kmx86duO/CSXY9WqllEEpoBOGyt7l4T7Pz6p2mCAB9sVhZzs5W14zfD3hgarkeK6WVWkd8cZpqNObhR0IPOF3+bx661di0I/glrhX+T+RiBr7Hh6Df3oUpfosH4MGPWEyYLaw/fcUCbmx6myXHx4vqriOw==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by PA1PR09MB7820.eurprd09.prod.outlook.com (2603:10a6:102:44a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Wed, 1 Oct
 2025 09:49:12 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 09:49:12 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>, Djordje
 Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v9 07/13] target/riscv: Add Xmipslsp instructions
Thread-Topic: [PATCH v9 07/13] target/riscv: Add Xmipslsp instructions
Thread-Index: AQHcMrijBgo4JSa+yEKIcD4ZzgxFcQ==
Date: Wed, 1 Oct 2025 09:49:11 +0000
Message-ID: <20251001094859.2030290-8-djordje.todorovic@htecgroup.com>
References: <20251001094859.2030290-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251001094859.2030290-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|PA1PR09MB7820:EE_
x-ms-office365-filtering-correlation-id: 3d348471-6ff1-47f8-65c2-08de00cfc670
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?ApYtCI2TtMdbtNjtKCzAqSy/BnEo8SqIieByAG3q9B9ivJXz1pQGZ3mvlM?=
 =?iso-8859-1?Q?S+jUP0CQ9m0VEPO4rPDKNKL3j/Nb7RuGD8+OM7qWnrn2QXjBs+Eq3/ORHc?=
 =?iso-8859-1?Q?7bLEtI0vYQH1F3qwebbAhBZpRqrkwEdbyDcdvnGJLvqAxJCnKNJh3DPgII?=
 =?iso-8859-1?Q?57b6/foeaAsqRWZDn17OBJbB3bjuyydVS697BM57pxmXNV9eYFlS4AqUS4?=
 =?iso-8859-1?Q?yfhbCPbCCTg6i3kGyyHH5UBJJ2Y+dMJ26aeRfrrEgt5s+g/pb6jj9cfBxD?=
 =?iso-8859-1?Q?DjTppqQ4USC/o7O3cUDR37+odDfJtbpK6OqbE82f28wX1fKoEmI/SnGqtH?=
 =?iso-8859-1?Q?vbRxC6tF/WGBiuHwBDkGarYZ+ImmwdfUztBNKsZ+X1E5y1XeyYRmM4J9kr?=
 =?iso-8859-1?Q?SyMwt7oWJ5JLkXECIws4jTNOHOnfrR1iUHHNX+i8WfIK4L/ADCM+9jP/IY?=
 =?iso-8859-1?Q?PtKpD1p+DO/YgXOtSyr700SWt+ajvw+iuvbjTJv3a2qgVOgtpje4WlOTK1?=
 =?iso-8859-1?Q?AyBmiXdDAWxomcPZFvixTys1mctxZiU4v/HiR8GlRm1RF0cbbPChkY87UO?=
 =?iso-8859-1?Q?rxrZxU9fO2ZSQcDgS/8Oayx2BgN5zDH95OLIzhCgmwjkCJhUb20Bg00AmR?=
 =?iso-8859-1?Q?79UcxXKqoIA4/6LVcl+CxI2YspmZihdRB2LSeLuR7H73fX86QY8vJawimu?=
 =?iso-8859-1?Q?GyV01hmkyuJ884HU47wZLMt8xgjefEVDzYCXnSPDtu42Dh2dUwEEW//bpq?=
 =?iso-8859-1?Q?3yJVEKSJUCKSCaFeiA7kgt+Z1OUlhHwca82MayTV9bRwcnJHV3pfTaNv3k?=
 =?iso-8859-1?Q?OF1RH4sCOkIK3gKUm3AixHeTkJrOeNvI3u2fSGayMs2zoSAreodnEMA/LP?=
 =?iso-8859-1?Q?6g3AmL16Lgs3vZNmlQheiZYOI2+BAMzXZ70hwQY4M8+mhid6wGY/PxyM9u?=
 =?iso-8859-1?Q?Dem70ylhUXropJiCfPplusGCAuFDtYEypiRHHDXS2FtpsTX53ExrXznrQA?=
 =?iso-8859-1?Q?N5jzDuPv9SqmCLMPAT0EaOFigCIS8oKDtEoyV28TgH8wmiKdi1adtMxSH3?=
 =?iso-8859-1?Q?J604dD0nFmIsBuUPzz7/rk98ZoFLwYq2iMPtP7IzEMZpmPXNWVmfKp6dYF?=
 =?iso-8859-1?Q?mqrIr2toNeZbyBhR/S53HD9wpMF1BWU/jB2lZMhbHS1RMaI9tFhKyrthOA?=
 =?iso-8859-1?Q?FHjqcQusHp2KSSeAROtNcgwsaUttrqL3DjpyT1XG4PixuYL8vuxUxsvQAH?=
 =?iso-8859-1?Q?XBXeV7PGhdwnaHW+t6+9abViNbFfgD8hStI2PHtkDb+1waOTGjEvuOZVrb?=
 =?iso-8859-1?Q?MDt/mkJRjafQX+mG7z2IZ0MQTI7J1bk8ZyL0xbsC+LrrPNEwLgbbFv6f2X?=
 =?iso-8859-1?Q?5iZ1oJSUNSssVopjMyEGpZ7I1DyYD9XwYJmnODoY/HCxWnC86dYY2qUCMq?=
 =?iso-8859-1?Q?kKbT9YO104qepUljcMehChpbpPfdT/3xxZrX94USWHKrAVceifsigmYjmy?=
 =?iso-8859-1?Q?WNcEFgrai5Apd5AbZWLUC9uvbk/l0kKa9Qjjhl+5LbJw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?akmG8bQ5vadk26InunmnAobzgqj6d4j4PPLS4ooJBhiAOeuJgzW/7klhAH?=
 =?iso-8859-1?Q?67h1ab+nZUgXaD4CKu8MZbdYJDsKJhCpyBvIjLBU0uQh5Dw06hPPMMCk/k?=
 =?iso-8859-1?Q?CYyawYVzzYrYzEv0LwjwXkKnLnEvc+pKzpcdHRzRjXx8MnNEamWYfHph7H?=
 =?iso-8859-1?Q?Em0G5yINfoYJYTNj5X2EfeH2MWq1hJsKmZVZZtSELzGvEjJT/akIU+0llS?=
 =?iso-8859-1?Q?GZdQ8yh5zg1UAIhSg5RXqOoj0GCQngCY7C/oePuXHe5UCKMl6DBGVGm659?=
 =?iso-8859-1?Q?34rbGjOq7DIi031FjsQUi51MehReOfgoKgxN1aRJrnxKwWBCplY6DxXdVv?=
 =?iso-8859-1?Q?zvZisSez/MKKIx/SwLYUv7xnK4Dcm4xYbAlTqaS3G8pxHxZzFQPZhZkDfa?=
 =?iso-8859-1?Q?Thh2/MPOREsuboujwMGR/jczceosC1K6vTkDkLqGiqE3s0wmeQ9i99Qhne?=
 =?iso-8859-1?Q?ReBzbVYYlVJsRNtfInyOduK0nCjFrlglNpi7sQ/a4/NT+BAoG/CA986kGH?=
 =?iso-8859-1?Q?cljOtFF91z76s5h640Xw2L8yQQI5x9AAMvuuMB2+WRMWolnho9gziatPYr?=
 =?iso-8859-1?Q?y3Dnnbw/qri6bPnvPvywZjn0AXoOC8JqeRVTWUvf1ba+6HAsxNHOx03lXf?=
 =?iso-8859-1?Q?g94BITIWsmLbe814fod7YYzgiv9g8zxs9d1YpbgYVx/5HbHlKg1Xrxcvcc?=
 =?iso-8859-1?Q?Y+UtG8VeSHFFO1u3/UJrfKNMtn8OAJXN5rai8FbJfwStpDbWQ3hgEU2nCT?=
 =?iso-8859-1?Q?KCQxZkIVuac2/TbVsftYrq/ACgQDkJ7vSuHT8cPkzoA7xdl6d6XFBrCu30?=
 =?iso-8859-1?Q?K2m+rTK5KWLZR2JTmzWmID4iU+l7BdhLZAgU9UYaetoCzSmHM4/qE2DJ5H?=
 =?iso-8859-1?Q?43YZJ9MFqpi84aQJcuHTDDFOaJJFStyN6chpiJhGCVTV6MfhJEfiVxPXPX?=
 =?iso-8859-1?Q?JVW4oP+nfkEfkjZeA9iUObRdzqgHNF9Q+8P6FdT0CTm2J8wxFpYtQ8DXRr?=
 =?iso-8859-1?Q?xKBAfEWLV23HGu/rQMwN+vhat3BuudNlSh92/QBc/YXsoSaAm7Z/UMaGxu?=
 =?iso-8859-1?Q?srSEOU1lqosFojpviiZsqv2WTUDCKhmJh6U+5SxWE9KGliylDYMQ1+kjgT?=
 =?iso-8859-1?Q?F0p5l/XyZjPsgdlYqYf6svZrKM6PLkkvP5yVxR3E14VE4kAmzgsW05K6Wt?=
 =?iso-8859-1?Q?Vn62lRs4TEbJFNIFoH8ODQZt3+/z0OLTwoBYWrhRvM5dlh63nBJ5wYmrXM?=
 =?iso-8859-1?Q?PMoSFW3zGJ2LJdA95K4sfMKOgCWOvdE2ECVpo4roPo3XVgfqonTqe9jlSO?=
 =?iso-8859-1?Q?EploY4SdaKFw9Dqy0CZRMXTToHquX6N9UzOUTa3Faq5e5QxYA6zGdl8veH?=
 =?iso-8859-1?Q?yJI3ThMQ1RX1o/DUwnMJPWNmJ6rgoeddEeTd9idf04vYvt/wVl0A5+cQOK?=
 =?iso-8859-1?Q?2yiPEbkuI5AKHmypt2iJ7k54MUXust6XLAgTa64m8xySq1vA8/9xhdAs49?=
 =?iso-8859-1?Q?4ZVWIKQZRXLS7MkUingAK53fncnw+JC/Bsz1byGaKHre3CP59GqgOMGLGS?=
 =?iso-8859-1?Q?bAvbDSLrndV5UFytsL2w1n02gkYi+sEz9sTL0/FWqWF5BXTLpdEvdsJA7+?=
 =?iso-8859-1?Q?EuIW4amQpT6KFrPncqjJeFiKlT2ZiYVtle0seVoLztKZVMtbq/oJK8U8uZ?=
 =?iso-8859-1?Q?Z8vh7EuNmkA33/t933A=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d348471-6ff1-47f8-65c2-08de00cfc670
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2025 09:49:12.0444 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FZHi8sKC4tYiTBFrUVv20FfCfBplj6PsRPyIiQsrqTcIXZ6qhkLjBjDzsTv0idi6y7Fd4SsOlGpHdLVZ8LNVi0yLl+ZGROmxcFpQWbPjT3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR09MB7820
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 target/riscv/insn_trans/trans_xmips.c.inc | 88 +++++++++++++++++++++++
 target/riscv/xmips.decode                 | 23 ++++++
 5 files changed, 116 insertions(+), 1 deletion(-)

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
index bfe9046153..9a72f3392f 100644
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
 /* Conditional move by MIPS. */
 static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
 {
@@ -38,6 +44,88 @@ static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
     return true;
 }
=20
+/* Load Doubleword Pair. */
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
+/* Load Word Pair. */
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
+/* Store Doubleword Pair. */
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
+/* Store Word Pair. */
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
 /* Move data from memory into cache. */
 static bool trans_pref(DisasContext *ctx, arg_pref *a)
 {
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

