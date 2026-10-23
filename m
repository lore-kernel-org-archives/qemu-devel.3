Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7106606A319
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 01:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=pYD6VRrO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK3kL-00084g-Un; Thu, 22 Oct 2026 21:07:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xK3kK-00084T-3V; Thu, 22 Oct 2026 21:07:00 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xK3kH-0002Xw-Rp; Thu, 22 Oct 2026 21:06:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yjReC9lpzHhREeFNkqB4A65nhXRO97RSuTU/x46NwmRr4DtGEwGY7UZojCHRkOyhthDzLgTojoDTGGFAukqDFQj+PaVHaq3bYpANxdGwSBdaICis62jaVHT6RSMTg0ub0US6HMwjVbDnNPIzbMFdSDnim6qK9/r51jLh7AF6gt/iEj51bOjr6S8wECqZ8aZOKzWbzi2I7Hs4fagInBmAPYz3lPs6zLqRUMvtjw4wGhlVUhewuitPLY6FsCXwLkf+86T1dcl3s5nzhlJA2cMCAlNRuQXve3ETOhTm16ZtruHcO0WPrj0tvdoaK+DZokO4e7HQkauiK1z2bU2JBa/t0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifg0DhZsx7p/YarwM1iOlXVYTghVa6AmlE59PqLuK0Y=;
 b=qVtX2sREHCzHCAmXuscwlN3OFF7fyMiBg8BGuNSverPSq61lx3Qm7GYOYbt5gQVSLekdIOyKhiUc97SC9dB4QTfJQDCvTZaiNlYH5GicMh8kWK92ygkafylUUojCJN3ja6tD2Z0DPYx5H+W9htHzX4H6BuF3GV/vg9TRflOlpYlpWIhszY2Kag0xSzI/FKiNHVKCav1hP2XENNVj4hc18di63VAsQZ2ualAHdhE5hhQvLHiJjenPIjQ0c9RkN172dYuDANLnvnRV/U/DyeRzLc8NGYVFbZUZJuPj4IfeXCGMMFTbCeLJl5PkJvQelDb66V8KlIl8JgKFK0FWjFW4Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifg0DhZsx7p/YarwM1iOlXVYTghVa6AmlE59PqLuK0Y=;
 b=pYD6VRrOgu2vJNTvZEuPMbUXGRN2no+gZRWcw5mPupuIvPXf5I0H5+RujC3v2GU4Jb1lvAn+k3rI6KaMYJMydh5+fGFkD3Cv1hkUbcZLCzqFM69ZcCneL2uFq5+XPU1EB4XYl0PplTypKx1JkyB+Rvn2EsZzmETtKxBhvEyrFfY0k84LgiJgocvyZK+pKHimLjApWV3wEQqLZpnwCpXo2G3IQdq/I4I+VmXn45YTmmaZzGT552paFrIfQmse0+Vi0+/bG9kE84+elb2zm5W9AIHxMXSjskmXMNlPNv9UFzt18IlCAoSUPR17770gKS7z4/ZfZYu3WYiogNmPZBOnWA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by SEZPR02MB6947.apcprd02.prod.outlook.com (2603:1096:101:198::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Fri, 23 Oct
 2026 01:06:49 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 01:06:48 +0000
Date: Fri, 23 Oct 2026 09:06:41 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Bin Meng <bin.meng@processmission.com>
Cc: QEMU <qemu-devel@nongnu.org>, Conor Dooley <conor.dooley@microchip.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-riscv@nongnu.org
Subject: Re: [PATCH v4 04/27] hw/misc: Add SiFive L2 cache controller model
Message-ID: <atqwIQTXz_2Eifo5@MacBook-Pro-4.local>
References: <20261014012323.322790-1-bin.meng@processmission.com>
 <20261014012323.322790-5-bin.meng@processmission.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014012323.322790-5-bin.meng@processmission.com>
X-ClientProxiedBy: PH7PR10CA0009.namprd10.prod.outlook.com
 (2603:10b6:510:23d::29) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|SEZPR02MB6947:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e2cbe7b-66c8-42e4-3cbc-08df30a1ea0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|56012099006|4143699003|261021121427099003|6133799003|261021135927099003|18002099003|22082099003|261009223027099003|10067099003|261022105027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: pJaRQNnI5e9ZY6/WpgxAinhhcALdHChuDsNiUXbzC9A6Hi7NGND3PSMTG+v8cpEfLfdOHbBv4h8s6x7DgtfL3ddWQbTy7hf7MfuI0TO+NGxrS02KKeMwVy6g+JSOZvgdUBWL/NNia0ScFpi0zpIWo1FT4nInf8zg96Hq+qBW+mHvvaWvL6k1Hn0RlBX3F8bgLf5ntm5KZ2UH0c0WJ6ndBkQu5D0tEebkgnGECPq4kIlYBSQGgF6czt9MoMH9i6Lfw79aStJigsKJqzms/fQkRL+ObvieokGQpwN5sVL/8u81r9S7knTBezAv0w/1CjsW8vjnouGXRLFgPhEH4R54/jc//mqUrI7bkmrxTKQynOgj+GQGdv6asCos4GM5V4kgJXHSQsOhfEUXET21EHjFRQ75stMxX4oSNUbnl89TOd3vkHUEjm9oJJe7IM7mWOCOz6y0TBZo1yH0abPP0myjaOqkbe5QCB7PrG3l2p4N7i6mZB9m2h6YJGFH9Oh3MFYZTJFToMzxtGntVFr+uVTCzOGtF0y6nf3GtYlBnYW04tRsCrxHoj0Em8CXP34wwXDsN8P0LUKL+HQsF9xLFiP4gfNOKUqccQSMi92Jkaqqw6G6WDeiJwfqwWmP33U9rLNnw9a/zYI4EKzFRilOzhKJWPJy0tg5tiSDOLPjtjOeKJk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(4143699003)(261021121427099003)(6133799003)(261021135927099003)(18002099003)(22082099003)(261009223027099003)(10067099003)(261022105027099003)(261022075727099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xqoMXbHTR6WUDdlReTEd6r4J2YSiM7nRW1hBnpHuE/ON+8cR4n7GkNVt7Ub7?=
 =?us-ascii?Q?AnG4mGeCP6RhvNym3OB2nNSMxUNNkolrt87EmNrZ4SZFwOArt60YFMevyogw?=
 =?us-ascii?Q?hyGByv1tJ+lXQSKxBqziU3lMXbl+z1x2kayM55L8XxjsCDoKE8pZ91lnHDPM?=
 =?us-ascii?Q?UK2OGpt62NvHouLkm8N6gAMity9jWiajxHxM12PsNn4jyBwDjimjGLukup3q?=
 =?us-ascii?Q?/vdRo+LIm0IzIEkmSM+CjOmW+aby/mkoNPU5vuSDrvOx5AVQo6cfQ+JbAZ+i?=
 =?us-ascii?Q?US4ecU9QCthFSPJ2Mgf7k2fRlEBnf0q5P6VIqpvM5w5mPWPElrPU3M7u2Mlb?=
 =?us-ascii?Q?bYh6tuN7a/xtEm12AuDQrH/ZtaOYEm/JSN8MJiyJAt1EFft18OZEHsov6y9C?=
 =?us-ascii?Q?PSGX/UDysjZr8i5Qcmfl4Rxh7yBWOhbViKHXLQRdZXjndRaRvPCJXrJBlOw1?=
 =?us-ascii?Q?uC8ySmuRSp0IowMHGUYC0etgrJp4PlOUp4FtS3TwVFwsa17x48xudSvze8+N?=
 =?us-ascii?Q?u4lBx6li89JD2hgHUGE5jCasejVbnzaIcdDjaDyvze5vIe3CoGcDJQM4OaUc?=
 =?us-ascii?Q?as86BVYSRqjB8C7s3hm6DVUBhzN8cqjbvQqVwTO3Um/59fOkrjkLGcso0XZ1?=
 =?us-ascii?Q?iVk9MoOtkPioIDvkYFBROtqGiYMfaU3CHHyqzSihhi0+JUatBON8Nm+ZmSha?=
 =?us-ascii?Q?+9FJQUVqKTpgDzaDfAQR77QT6PcQSMxnsi0JNM/8VnfU8brUeBNB9z8iDEo5?=
 =?us-ascii?Q?8lP7dk8zTXD3an+VJlCgVhCEFRq9rfnXmSnYuiSHQuGERNZ7P8Uo9JCidWRU?=
 =?us-ascii?Q?xg07dGomIQ/VX6ZtFHR4FzL3xwPRtANtKKs61g6YZ0Rbj/gCfKZ/JGHOzVOE?=
 =?us-ascii?Q?TWJTRQQhCwf8n0caDv0TuUZpyjla0CVQGFBiLVauV+njcaRIZojhUeCK+ISw?=
 =?us-ascii?Q?8qfB+Mv9a7vnuZQ8LsqX7jmz7Pn4/9kgwwlFptMb5SckIJ16L1puIxAHZGMh?=
 =?us-ascii?Q?2bdUZs57ykdu6ZFYajqTU9PqBGwG/F7J9gwKFTvmO2LRqyMyJehgpaVs6MJH?=
 =?us-ascii?Q?JpHCpbFKiDTgqt4IeD8CClvPLRQgUIMamDYMM2lXcXEr4DKQD2h53SmWNtQH?=
 =?us-ascii?Q?cMm5rO477kNRN6WPCfF1YTBqJNyOsf9aK7cJfdTgyPZps2OkFwZJEJArTgTl?=
 =?us-ascii?Q?HcyA/uNhnWBH6TgtU0lR+wD/ZPPTtfIViY5bJDY1hcBukikokjaPl5kqUpdn?=
 =?us-ascii?Q?fMPTRjpeM4NThPb+iQf8KAtvYp66HvGhMJym7FzKo3daw3zVUlCqpuKWOxoe?=
 =?us-ascii?Q?MTuGK4bwmIr/0+lCg29IoX8OGACKNLtveI8xb8Vmj2J8xwNh0MXyiAtsdAyG?=
 =?us-ascii?Q?oxDnp5PohMheiO4Tf3zY2DCHyUpkERnOoEPmAdcg17IrYrt5Vo/QhRDniQHy?=
 =?us-ascii?Q?EoGHhIYGcNe31UKWUnlnyYminVMnqyQd5mnRyTNXMxnD+ofhowTXdGj9oh99?=
 =?us-ascii?Q?rmWcu7Z8fKQ9dCwmXzxJu5sm1w7lt+RNb+c9/fmmpK7g9OIbkOy41sUrSGxW?=
 =?us-ascii?Q?ZoWwF6wUa3VuNgxe0tLURGt1xu8wNRTixuAharrruWTHb5Yc8YfD1BgcT0He?=
 =?us-ascii?Q?hRsN/AO9DmEJAr9a6gxyXpJP/n16mNx7ZRJn3Ps5pFVVMura8AOctXnxhR/S?=
 =?us-ascii?Q?2LLLgsRY6ZlilpCosPo0aXrAOT2V7RnCj+fUo2Mzu0lzTuHVIFYT0ZptnZ5D?=
 =?us-ascii?Q?kj/ikoJ1XzbavFRWz/LDliKcdhxh5yg=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e2cbe7b-66c8-42e4-3cbc-08df30a1ea0d
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 01:06:48.6433 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5MIJhtAjn7jsowgz6OOjzIr1Qf2aLVatY5hCsGeX8xNK2zmB4TtXcJk5O+WeaLZ9TrcbT0LUrdFFN/1Luf0qTaWyNPxOyQCXiVd4KTkJQe4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB6947
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=chao.liu@processmission.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi Bin,

On Wed, Oct 14, 2026 at 09:22:44AM +0800, Bin Meng wrote:
> FU540 and PolarFire use the same SiFive L2 configuration and way-control
> interface. Implement Config, monotonic WayEnable, and indexed WayMask
> registers with a configurable master count for the 21-master FU540 and
> 15-master PolarFire integrations.
> 
> Own the fixed 2 MiB SRAM backing inside the controller and expose the
> remaining LIM ways through a resizable alias. Also expose a separately
> sized L2 Zero window backed by RAM to approximate scratchpad accesses.
> The Zero aperture is independent of the cache/LIM way partition; cache
> allocation, replacement, coherence, and ECC remain unimplemented.
> 
> Export register, LIM, and Zero windows for the SoC to map.
> 
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> Tested-by: Conor Dooley <conor.dooley@microchip.com>
> 
> ---
> 
[...]
> +type_init(sifive_l2cc_register_types)
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index 46e3c03cc8..254103e4ff 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -206,6 +206,9 @@ config MCHP_PFSOC_IOSCB
>  config MCHP_PFSOC_SYSREG
>      bool
>  
> +config SIFIVE_L2CC
> +    bool
I built riscv32-softmmu hit a link failure, undefined register_* symbols from
sifive_l2cc.c. SIFIVE_L2CC needs select REGISTER. Please add it.

riscv64-softmmu is fine, because REGISTER is selected indirectly through
DESIGNWARE_I2C.


Thanks,
Chao
> +
>  config SIFIVE_TEST
>      bool
>  
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index 9790afa104..6c401541e9 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -33,6 +33,7 @@ system_ss.add(when: 'CONFIG_K230', if_true: files('k230_ddr.c'))
>  system_ss.add(when: 'CONFIG_MCHP_PFSOC_DMC', if_true: files('mchp_pfsoc_dmc.c'))
>  system_ss.add(when: 'CONFIG_MCHP_PFSOC_IOSCB', if_true: files('mchp_pfsoc_ioscb.c'))
>  system_ss.add(when: 'CONFIG_MCHP_PFSOC_SYSREG', if_true: files('mchp_pfsoc_sysreg.c'))
> +system_ss.add(when: 'CONFIG_SIFIVE_L2CC', if_true: files('sifive_l2cc.c'))
>  system_ss.add(when: 'CONFIG_SIFIVE_TEST', if_true: files('sifive_test.c'))
>  system_ss.add(when: 'CONFIG_SIFIVE_E_PRCI', if_true: files('sifive_e_prci.c'))
>  system_ss.add(when: 'CONFIG_SIFIVE_E_AON', if_true: files('sifive_e_aon.c'))
> -- 
> 2.53.0
> 
> 

