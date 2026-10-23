Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CED4606A319
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 03:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=pO46qdkL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK5bi-0005Zt-OF; Thu, 22 Oct 2026 23:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xK5bX-0005ZQ-V6; Thu, 22 Oct 2026 23:06:05 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xK5bT-0004e6-Gv; Thu, 22 Oct 2026 23:06:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hvucycA70qjJ92yX2SIabqAPlkYBbrwtgh3IC1v6RHldym1JwjJ8ElUpjyN4alz+LRvFyDxPJ+UKf05B0fulh5OToivB4RA+OIM+Q597ZnjVSXStwaOo7UbIBedjZvYewq8UyYgzIMnh5ZPR26H80PWmMM0nk2EpXJu9XklWFJAzKqE4O+X5N3wnKC3YmppaJ6eSKVEzn8602k64i0PXetX7Oh1Ts7gRFqRcyiwm1Oifq/NquskUrr+o1T8+5lc0XRGzUbIGzBgGJKGe6GEq2DbGXI0mAaKIe6aPgMTgfHW4GMfatf/ta2aRDVevliXwqvWqvCs1gdbyDFFeF6fILQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=60PhViATs/hCw803rJDkOB7/crYxBOKzqMXmRzdm9SA=;
 b=oZdQ2UitN7EguCBrmKv7KtwivHJD3l7LkaKguGJHQWaxbYvCJacWomEZSKfNQ5zxQX8Zyz6coMqHIxsBttyybVmZQ9cQy+F15h0kX5x3ZPaGdjMOj16QzzaAnm708S4Otp6v9DmcNPijL8VtpVrRpaeVa3AgNuauoQ5HcMkdhsyBBXQgTXygnYBOxrA7QE7zjuFGrfhBFOxEs7sd4Izo8aJv8IeJckY+EtfA6+RnI8DWyfpi9YX2mAoiIGiq3FGviA7zC/TgTzMcnth1QgaE4GxjJhGeIbK7QvKcWetLBIvS3TsEU1d/d+gwJ+6zRt0wLS9ceUM2pGLAbJMbpTl/cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60PhViATs/hCw803rJDkOB7/crYxBOKzqMXmRzdm9SA=;
 b=pO46qdkL9HkyiqeNsDoereAvCfAHqDGv/0xxZxEYALz1VbA3VgCu2hJy806B2r/Y+yWAGAzaA5kF2mMuPfuM3DwAqTT/OTQFTgiPNIKU9Si2y6vfPDF2OkR3JTcf+lKqy80RdRxhkMTLUb6vMhZPbXwFLuI8sXR3/Y7v9G9u+XpvDq1PCxBL+u3ylyVQhryMOh+3Ow/Byk/83/0wqPAJGd0vOW94GXdajruGw9U1AFGNbN+hsU8BuONGX3VGWepIxJWCF3Q+EklZm9lOcaepGP08NGabZ9oja+PpCRaXsN0EgrslZlqOIFbkmakyu+dnsHTmSV+H5D+LjaMPOrOIRg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by TYSPR02MB7526.apcprd02.prod.outlook.com (2603:1096:405:32::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Fri, 23 Oct
 2026 03:05:50 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 03:05:50 +0000
Date: Fri, 23 Oct 2026 11:05:43 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Ralf Ramsauer <ralf@vmexit.de>
Cc: qemu-devel@nongnu.org, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>, 
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Lukas Landgraf <lukas.landgraf@st.oth-regensburg.de>
Subject: Re: [PATCH v3 2/4] hw/riscv/virt: only describe PLIC contexts that
 exist
Message-ID: <atrO9uhJhZ4KxA5u@MacBook-Pro-4.local>
References: <cover.1792700406.git.ralf@vmexit.de>
 <299b4ab6843fb4655355b449359eb38f717af445.1792700406.git.ralf@vmexit.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <299b4ab6843fb4655355b449359eb38f717af445.1792700406.git.ralf@vmexit.de>
X-ClientProxiedBy: SJ0PR05CA0120.namprd05.prod.outlook.com
 (2603:10b6:a03:334::35) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|TYSPR02MB7526:EE_
X-MS-Office365-Filtering-Correlation-Id: e2bc5a72-2fec-4c32-e392-08df30b28ae9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|7416014|1800799024|366016|261021123027099003|56012099006|261022075727099003|4143699003|261009223027099003|10067099003|18002099003|22082099003|6133799003|261021121427099003;
X-Microsoft-Antispam-Message-Info: Z7o60Zd/AWBVaaj1Vf1lTHhcI6s+Aci3P6kuDHxL5NFC1VDWDq+hbw9bVBrnlfCqjxtwpmCq8r04slC5W1KBGv2aD2E6p+NyepHpbtWia5N0LM4kE/Jy8G2SUWBXjVyewBs54BYDwqYj7+lTlY49v46cRbzs3LltXMy3pQQJIvFCJSfv5gd6VToVS7yKY+VJzzrRY6em8Yh27prHExF8dij7xjlGyKO3gD0o8s1MUViSirVGxXv8t6lMh6ciXmAqlrz0gY+axRfn3P2O4JR6sjut+9U5XSYprh9KLG9v1mlgTxQNpv+YO58iiSCwLr3zlGly3SnRsm2rZUxOWSkPfwQS8V7+pSsGzJEJgtiDtD/qBtOmWm9wzmefwWVtZOJMVAw0q6GuuoYzkjKZFCEetZOaMKUGbYWuM3jb6j21X/MeZi6X9d1NasVyR9QESeNYKVwjnyDbKXXvCxx28XYI+1n7dR0nBiKD1F4RH3y+q3xPQZTZQUgnDR2lT7IOcDQZddvDu4w8m1pe1okhs/IRTmJxyHUuJmn5YfS8eAOHC1Q7X58Aw3zxt2qnbiFC3D28AJCCQFfJlH27zIbWGUP4lYlcROonUho9VwcibOO5bHmFVGl5PdqOng8ry7fnsB50laivAw7b1vIiQtDYnh+NKYkIx19AK8TuGOKqWeFv0kk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(261021123027099003)(56012099006)(261022075727099003)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(261021121427099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n04Q3R6/9/Kae25eunHFJ+MSUcGy6+cNHGgfydB/9nH1qlJn1vYY6c6/RVHH?=
 =?us-ascii?Q?eQUk4Hb8RMqnXNU1aLiPePWY+eJOA+Mz4VY0n/tD6mzbOCOuUAR7lu3Lv7+H?=
 =?us-ascii?Q?BfpFT4pFJAqpHWDQEb8dizQrauNcZbiodkGiJ/7Owicw6ikPflexkKzFwcwh?=
 =?us-ascii?Q?fQbCBEzzhzGUebHA+ybPDEwAH7r9jxFAAwOjPnIre4LHqJgAxp0ijbgJeV+s?=
 =?us-ascii?Q?pTea8lz7Kecth7qBoPFCXdGrELbjC+L560xrcMVjEdZEUd7iaCcvQmcYrYcz?=
 =?us-ascii?Q?9HbhShadImikP9oLNU/9e9TiLqkUOjPxC4c1le+JcMVjBKMBREnYNohHgDlV?=
 =?us-ascii?Q?TJWhbkO7mx59gNfmC75cNQUBO0qrNqHmsBEjnJ3iGw7rPTCbDMZ3e5S6n4v7?=
 =?us-ascii?Q?oOssNSV72EK9qMNarCHRg/RiAvW7dDo2rhDtMZ89mbFR3+kGIqtyQiRTY78A?=
 =?us-ascii?Q?g+N8ujZLq3hc+k6Cop6PG7MDyFfWJpCEZz/RzZvhu687GSz0UT2VzXF1GoI+?=
 =?us-ascii?Q?1k3+/dwlqikvWzgUIrjtyNl3oD+qziNX9ZOY58bwwJIpOnTJDJm/z1SGfMMC?=
 =?us-ascii?Q?azT59uJrliinF4i/gqxCkV7gBmL56GLIKIUFYfH3q1Sjk38+97lhzTqD1BXo?=
 =?us-ascii?Q?/L/IHY3QpmjA/LCZEYcrGq0HwFcJMvK/t0m8hN0CPEOgUVBWaKzH3jkGyMSc?=
 =?us-ascii?Q?qDYyJgaSjwMBZTyObkDkR4hYGSMrcTsNGOeZDOPa23uBFqF6U+Qy/Ti19jpy?=
 =?us-ascii?Q?sL4k3IGyaysTKkzWVGJXPYuJtWPHoLh3ze/FJSZB5alLU8xWGEKf27WlOfRl?=
 =?us-ascii?Q?4M7F5EbtbnA9sIJl4KM3ioV97lvVPF2U0jWlCojEm/lu8WTs6nujB/ofifeL?=
 =?us-ascii?Q?3aatbDa+1wQQu8bqwt8iQXOCqZES1gic+x2Dek7uaidVl0dr4VtJwTfnq9fy?=
 =?us-ascii?Q?txhLcKBo1ASEvdgLB0z06YQZnJYxnhxchV1ZjdpWCpJtDKfY1duJnIINfS4s?=
 =?us-ascii?Q?r5rSkoXLxUZDelCJiem+2Q+AQhnPk4PHUb12Jcj1jI0Xmq8d2D83BDuZya3j?=
 =?us-ascii?Q?fPo+o3EQIZqNNe9VFg7C0esVn3OVl94GYyDwAguSvO4paGFF58DkRPn/pWi6?=
 =?us-ascii?Q?JXMafcBIdAJjtq0vGVGi6UuZQYNNs1bM2Kg2h+DlX+e8AC8l0667OiUybQez?=
 =?us-ascii?Q?rOnwQOdwjvxjfe57oVR+vjOUFOTCpVCbmP/6LwoLrSygrgawUK2t4HXmmuJt?=
 =?us-ascii?Q?pN5pAENNPa/Vq2fNuIo2N1+jFrq9zKiR/ffmCX4/1BArX1Qg+UOjP9bYTf6D?=
 =?us-ascii?Q?fRiSF2n6IFHyhL7+CbQ8V5L44munHtIJQUwnXdx80DMrwVBYZY2nnmsG8Q66?=
 =?us-ascii?Q?8VjHjFQx0dfyCVITCL4/fpKW1N13idlI5stjHwT7ubpMLBl5BXGi7KtYjKSk?=
 =?us-ascii?Q?wHjsgcYJ4czsNXDL8+WkY808I0TujgSwRPoFCquDyyfE09s/vYNWjVc8za6l?=
 =?us-ascii?Q?3cqR2UF7BDBXPrJXC6LpalXYJUbtFgh/A9j4iiIA6gfdKE2MNrEMqLVj1VWu?=
 =?us-ascii?Q?4Rh5RqpJTfS0OM4cQBEbBD7z3/R4clMSD1dFtJcHv/yMpbePwEuMT97MSgxi?=
 =?us-ascii?Q?hiADhfAcXAxpcxK5Cn7ggQ7uUS/BJ/0vXIZaWpxIJqLVF2dcPwqOcwq1B3zu?=
 =?us-ascii?Q?PGerMlFTmX+5Bl3jgG9tR50B+vyyT+Je1rwaOXHY5RxEqbXQE0mDy5+LS4P9?=
 =?us-ascii?Q?sWm2KgAgWYmU31yPUf3S/jzvUoxbQJ0=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2bc5a72-2fec-4c32-e392-08df30b28ae9
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 03:05:50.3393 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4MvDeLRYCOA1YVEjH3le4DNBx9+8t3UMlsvydS+RjbqW1r0qunokZ3ScMsMm8U/SZsuetNlRnk+kDp40zdNejjTUR9SYMraoKK+L+TQu0yY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR02MB7526
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=chao.liu@processmission.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 10:22:16PM +0800, Ralf Ramsauer wrote:
> From: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
> 
> The PLIC device is created from the topology string built by
> riscv_plic_hart_config_string(), which gives a hart a supervisor context
> only if that hart actually has supervisor mode.  The device tree, in
> contrast, lists a machine and a supervisor context for every hart,
> unconditionally.
> 
> The two have disagreed since commit 7d10ff8a4d ("hw/riscv: virt: Use the
> PLIC config helper function") taught the device about harts without
> S-mode and left the device tree behind.  Boot with
> 
>     -cpu rv64,s=false,u=false -smp 4
> 
> and the PLIC implements four contexts while the device tree advertises
> eight.  Contexts are numbered by their position in 'interrupts-extended',
> so a guest that takes its context number from the property gets it wrong
> for every hart but the first: hart 1 drives the context of hart 2, and
> the upper harts address contexts the PLIC never created.  This is what an
> M-mode kernel on the virt machine runs into.
> 
> Emit the supervisor entry only for the harts that have supervisor mode.
> The KVM case then becomes the same rule, not a separate one: its harts
> have no M-mode and always have supervisor mode, so the common loop
> describes the single supervisor context per hart that it used to spell
> out on its own.
> 
> Fixes: 7d10ff8a4de7 ("hw/riscv: virt: Use the PLIC config helper function")
> Signed-off-by: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  hw/riscv/virt.c | 28 ++++++++++++----------------
>  1 file changed, 12 insertions(+), 16 deletions(-)
> 
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index d4b501802f..a2851b506d 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -156,23 +156,19 @@ static void create_fdt_socket_plic(RISCVVirtState *s,
>  
>      plic_name = g_strdup_printf("/soc/interrupt-controller@%lx", plic_addr);
>  
> -    if (kvm_enabled()) {
> -        cells_length = s->soc[socket].num_harts * 2;
> -        plic_cells = g_new0(uint32_t, cells_length);
> -
> -        for (cpu = 0; cpu < s->soc[socket].num_harts; cpu++) {
> -            plic_cells[cpu * 2 + 0] = cpu_to_be32(intc_phandles[cpu]);
> -            plic_cells[cpu * 2 + 1] = cpu_to_be32(IRQ_S_EXT);
> +    plic_cells = g_new0(uint32_t,
> +                        s->soc[socket].num_harts * (kvm_enabled() ? 2 : 4));
> +    cells_length = 0;
> +
> +    for (cpu = 0; cpu < s->soc[socket].num_harts; cpu++) {
> +        if (!kvm_enabled()) {
> +            plic_cells[cells_length++] = cpu_to_be32(intc_phandles[cpu]);
> +            plic_cells[cells_length++] = cpu_to_be32(IRQ_M_EXT);
>          }
> -   } else {
> -        cells_length = s->soc[socket].num_harts * 4;
> -        plic_cells = g_new0(uint32_t, cells_length);
> -
> -        for (cpu = 0; cpu < s->soc[socket].num_harts; cpu++) {
> -            plic_cells[cpu * 4 + 0] = cpu_to_be32(intc_phandles[cpu]);
> -            plic_cells[cpu * 4 + 1] = cpu_to_be32(IRQ_M_EXT);
> -            plic_cells[cpu * 4 + 2] = cpu_to_be32(intc_phandles[cpu]);
> -            plic_cells[cpu * 4 + 3] = cpu_to_be32(IRQ_S_EXT);
> +
> +        if (riscv_cpu_has_supervisor_mode(&s->soc[socket].harts[cpu])) {
> +            plic_cells[cells_length++] = cpu_to_be32(intc_phandles[cpu]);
> +            plic_cells[cells_length++] = cpu_to_be32(IRQ_S_EXT);
>          }
>      }
>  
> -- 
> 2.54.0
> 

