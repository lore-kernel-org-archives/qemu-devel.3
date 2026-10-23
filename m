Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39E2606A319
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 02:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=HgAU0dnw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK4sZ-0005iV-JV; Thu, 22 Oct 2026 22:19:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xK4sX-0005hu-GF; Thu, 22 Oct 2026 22:19:33 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xK4sV-0000a2-MS; Thu, 22 Oct 2026 22:19:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ncSmvpG54WO3v4th65dSOyOGK5MIMCV767T8ow0J8fKihmRgUb7qI78B78bxoLvvFxFGFkscBp2D+xH8lEz3uDX4QB0eiGfoYXOknzLiWhG1iCbYlg0MJbCFJ4RxCkOUPsF/30J6UQYV6r9vgqApX/CBxnClCF97OiWGqhIm9vgIw0yYruK6Xuf0R2eHEyeii7gyB4VkBjkRIFDDkV7CSim1XUw8xmNX2k/8wtDUEwbZXVGjdRj7eBIz1F7gfgYFD6mJHRWw0H7Bu0jjAVhU41y94oQX8pDwqftRsNTvYOQP/PV9zArDENOpyUzp3LiUblNWkpuvR1kFsY+YfG+hIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4AJAOQWZLH8261Iaxdlk/tddVhPE55F62M+4jrBW+A=;
 b=P8I2B1nJWsWBjku0xw4yI9kWfTN99dyYvTOzQABUVNWHTOVPDUivnTohSQuhbcOaoJzs80elQv4GM++cVLASvT0Xf49r6q/VyfBAmBe1GLT5r86OaKh1CXgvqZA3z87HFYuYe929/1uj/M+Shj4vN98zYGUtGTWw0eIWXX45oRqKPXkbic01994HGWKQxKj9l/VGZp6ZIdLpvkq8RkG62KaPmsqL75GskMS6Tp058ShVxnG2oJNSKOGIB40H0rIV1M9xPmqR7Xen6X77YxqoVNOJOc3fqZ4oaq6m5dbmk2GhnhuomZ5vAgF0AWKfxgicA8BKjhC8ctN3p+urjsZDaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4AJAOQWZLH8261Iaxdlk/tddVhPE55F62M+4jrBW+A=;
 b=HgAU0dnw9BTZe5edh81dqIfZybeK+bWdEuLc52CbW6H+8bmpFxFGUeXxdXXJ93ecbuEZthwKL42cNxQUvyZz3CFOlF6WtaSzMWVaRUb9l1GXLM77pEHF0hb8Pree41uf52rU7xfpxU7Ni1rlE98MCvJTXnIKkezlFqyKWPpWU7n77fTYLHx4/0RWaDBDYs0HoESNEzwY1hpkV97Y5iQIWlIGE5c1Yrnn3G16Gx8TQpjb4Q7wvquRwjwKbA4lfO+bPhmOzLDZ7B0vvF/y/QDnijUOq44JEGk9lew9QMR2mKkHaAsTzneFu7uyXYbyiFpK5oMbtB8QJwCPEmbzVoG4TA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by KUXPR02MB9382.apcprd02.prod.outlook.com (2603:1096:d10:9e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Fri, 23 Oct
 2026 02:19:22 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 02:19:22 +0000
Date: Fri, 23 Oct 2026 10:19:17 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Ralf Ramsauer <ralf@vmexit.de>
Cc: qemu-devel@nongnu.org, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>, 
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Lukas Landgraf <lukas.landgraf@st.oth-regensburg.de>
Subject: Re: [PATCH v3 1/4] target/riscv: add riscv_cpu_has_supervisor_mode()
Message-ID: <atrD_2QgGVQMXvVP@MacBook-Pro-4.local>
References: <cover.1792700406.git.ralf@vmexit.de>
 <7ce612fe810e410dcac32b9da863182b1f6d2c5e.1792700406.git.ralf@vmexit.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ce612fe810e410dcac32b9da863182b1f6d2c5e.1792700406.git.ralf@vmexit.de>
X-ClientProxiedBy: BY3PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:a03:217::6) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|KUXPR02MB9382:EE_
X-MS-Office365-Filtering-Correlation-Id: beae0230-66d2-4b3b-4051-08df30ac0d4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|7416014|22082099003|18002099003|4143699003|261009223027099003|261021121427099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: oZSALcKog+br/IH24FvOENtVdAj6UWyjBEFxnxF3UJX7P0sYDoYWeVj6vFwcc/k1jbuvGwVZllhlA+qKK9SuD6ZrW8s6d3DP2H3MHlsXpUwvMg1wTCwBr1s0NzI/ZuBiVxcTA58HUEt1AoQTEejrDjqmQKrbROWnMyxzg37KeyPUcRymderJHmTfqdjf5l9ZB2ttLk5rPugSoDCS7CSFOUOz/X95jCKxBbzDHhV0bvMhzzkceOvdwgI8saXWysjxVl0KC+eT/WMxs0ZeKzqgabAi9fI9Sr+VxKhV4qukmmK6x0tCqE/DhWAcEVkoolWheno7p6DYBmAXB8cQapw5c1rg1rU7u2+Yf1z9dx9c9eqTDmvWUyUArnrkliCzeUVT7NNf1k3fQJ2VLkx76SA/TPD6+k9cP6wxvEcwOMZiWeLtclNGmxcwtEVrjB67wrie4nx0a77DpYRkG1/j8MVy3pAV19poEa1fTkqzO18wLkR2iHgwYRnJZILmc2mANVv5Guxua6JqzXyXg74udQyUMhPdvNFpGfQBcHxLlIy+xDI42G9qTChHm0IP1Vwnc2qkEBsjqgB6jzwKzg5HteTXJ6l1HYEeU3s8j+gqPG65Q6DbYmsiORYGuQvpUSGuVcDIs15YMzJrn1a6mvnrMytI1OKP5ACMN3DDgAbTdyy/hqw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(7416014)(22082099003)(18002099003)(4143699003)(261009223027099003)(261021121427099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A7CRWS8wkvRrLbpPcduaMgrSPREK3KScUlLdufTt8LpQ+jk2ylf/wlYjpGMX?=
 =?us-ascii?Q?Fj0c2z1AAFGbfJEWIf3mrvJuig8KPwOT/Q6KtAwhmFUCqJJ80xXIo7QXrUtn?=
 =?us-ascii?Q?EgceVrjzTDE1znyKaMF54VXJZfg3OKP500x5ih3av2FH+4nyg8mtSkmdvNam?=
 =?us-ascii?Q?3xJkiCuiG7echoPrl4kLpeLePPr983PuRTF60hFpnLbyaibKCFEiOYhhedz5?=
 =?us-ascii?Q?x06TktGYdUAC0RXW6qpF85MLqECbLyMIvvRtSpgAj4Fe/WHgThrEneFXzaHt?=
 =?us-ascii?Q?3ng1ZjNpMb/BwtP08EdtyPgLZRKDW2Qv2NM081A2WfBZ9/JNiB5zNSafDyKu?=
 =?us-ascii?Q?YtmP20MZ6buWQfK77VGTMYmqWktul8PtN8eBOWmdrUIujw4yRZHAbwdjuwVF?=
 =?us-ascii?Q?TCTRPChAcrsmgloizonNxnfmI8FSm+2ooMH74iNcuQkQZfRXgINkYJ+MZ0Rw?=
 =?us-ascii?Q?yTItV9RrK/hmerIOjjgjGBCFPjZ5JEwIqWGEXvFhMn7tLo3u9D3omRGekbX8?=
 =?us-ascii?Q?Swpto/0pOORnSUBrYhXzR4c6amo/IUX8cE3QjNs3RjyYgcKA740/PPE3/aRr?=
 =?us-ascii?Q?A974Xs136j1aI+ICscjS8obUQcfI6HnrS0OoSHJnv7431G0/Hx2IIX0tY2ox?=
 =?us-ascii?Q?2g9Mgw9Uq9DDUscPih4MpstmTiVlvjndsSWU5SLiPoCno6g0MPJf36TN7zKk?=
 =?us-ascii?Q?wM1E0X4nx19/SSbw5wUj+KOkkgqnX0uY/m7Pii/xCrd/diIHaotEFWRrY7Do?=
 =?us-ascii?Q?t8352hw5m8mXL/5BxPwYEhAl4pyWiTYq7GJc8jHcd3b9nGu3wO4XP0NpFrD5?=
 =?us-ascii?Q?ewAF/yLI2J76VVn+oKgDBn+CYS1h+ioygZA0lC7iUEqopbud6pAMiLSIdwp3?=
 =?us-ascii?Q?+CD8JqK0nKPIOyku9XoWlWdI3fV1EQn+P0M4gDAvBqQCUvt+NR54GbWLyxH3?=
 =?us-ascii?Q?wMjS3X0hu2Ge2p1zzyq3ncB2jzaMKMEK1EHqZOxTjLvag9i6I6lzDmqzKOrC?=
 =?us-ascii?Q?CeDHM+32Lhf1krTNCFSzq8X3Bp1urB5bU3HOGnRTu+RXcGnjUuBuulHQ5CR1?=
 =?us-ascii?Q?BMKCwLCNSDHPi6XPo/bjdj+ix4D6jOIq2WmQNW6wd8SxSV9KngzLVmmbRUXZ?=
 =?us-ascii?Q?SAc1zc+XoGXxbFoqoEYPsSpMOWWHDsNxbf92279E5eLrxArKOhxMLfrEJYxA?=
 =?us-ascii?Q?eUvMH2w7DYCDTXLo97dVDj0eCihjzVe3nFOr+jUSneHO1N1/BsiWXwLC/Lmi?=
 =?us-ascii?Q?3Y8L7PytFxb/BcSHcvLYuLOthMKDH+4Z52Gaed+POhYaGqRmvLInXiRaM1YO?=
 =?us-ascii?Q?BGBRVNKIJXILhWxK3MYzUNn42v6cQwfGOfVN+up/yDT/RW0C0823tnbTqHcE?=
 =?us-ascii?Q?no8LMwZioNsOLtioXE3e4jPXMCpud1qx4XCjJcXINbquAHd26vOapVKd0AmW?=
 =?us-ascii?Q?qN4pw9S0bF1WZo2AmTZGvvK3r86TNNfC7QJkzL+s6Nfj17HA9WtxzE43SFl1?=
 =?us-ascii?Q?4yLgG6i0EwutngdCmt+TlpvBapgWA5GYAJ4SkgIN/yx719D3M2koktYykirV?=
 =?us-ascii?Q?qIiO/Y3+4f8Ia+T3E850xGLUx+lgyI15yr+mIsrpn8/V5c5H33ZvyhIsEXZt?=
 =?us-ascii?Q?rS9SlFfA418vSNXf13h+f6qIGQvH1goot7cfNRm38nG2JBU5ohtmhJSLA5S0?=
 =?us-ascii?Q?EnHze+Mu/WMs40qB6WLmLjSCd5co+Sric8+bk+aCvHEYFulC90IJzZx/aPEz?=
 =?us-ascii?Q?F1ogdRum6yGVM/xIFvtsD1O2dDQELDI=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beae0230-66d2-4b3b-4051-08df30ac0d4a
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 02:19:22.6991 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aa9BCgPgG67GNAqSVOTgfEqqtJLYyLel2BjgjrXfPxRjHmsZSy39MhbWIOAKi7vWXCu7WAqzyzVZv3enOS9x7eOIdC0OuJ4LES7Li7clfds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR02MB9382
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

On Thu, Oct 22, 2026 at 10:22:15PM +0800, Ralf Ramsauer wrote:
> From: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
> 
> Whether a hart has supervisor mode is decided in two places: KVM harts
> always have it, and for TCG it follows from RVS in the ISA string.
> riscv_plic_hart_config_string() already spells out both cases.
> 
> Board code needs the same answer to describe the interrupt controller,
> but it should not have to reach into CPURISCVState for it.  Add a helper
> next to riscv_cpu_is_vendor() so the next patches can ask the CPU
> instead of inspecting its internals.
> 
> Suggested-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Signed-off-by: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao
> ---
>  target/riscv/cpu.c | 14 ++++++++++++++
>  target/riscv/cpu.h |  1 +
>  2 files changed, 15 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 08a4d14ea1..7be1c65902 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -338,6 +338,20 @@ bool riscv_cpu_is_vendor(Object *cpu_obj)
>      return object_dynamic_cast(cpu_obj, TYPE_RISCV_VENDOR_CPU) != NULL;
>  }
>  
> +bool riscv_cpu_has_supervisor_mode(RISCVCPU *cpu)
> +{
> +#ifndef CONFIG_USER_ONLY
> +    /* KVM always provides supervisor mode, regardless of the ISA string */
> +    if (kvm_enabled()) {
> +        return true;
> +    }
> +
> +    return riscv_has_ext(&cpu->env, RVS);
> +#else
> +    return false;
> +#endif
> +}
> +
>  const char * const riscv_int_regnames[] = {
>      "x0/zero", "x1/ra",  "x2/sp",  "x3/gp",  "x4/tp",  "x5/t0",   "x6/t1",
>      "x7/t2",   "x8/s0",  "x9/s1",  "x10/a0", "x11/a1", "x12/a2",  "x13/a3",
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index b65d631994..a7509b0114 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -995,6 +995,7 @@ void isa_ext_update_enabled(RISCVCPU *cpu, uint32_t ext_offset, bool en);
>  bool isa_ext_is_enabled(RISCVCPU *cpu, uint32_t ext_offset);
>  void riscv_cpu_set_misa_ext(CPURISCVState *env, uint32_t ext);
>  bool riscv_cpu_is_vendor(Object *cpu_obj);
> +bool riscv_cpu_has_supervisor_mode(RISCVCPU *cpu);
>  
>  typedef struct isa_ext_data {
>      const char *name;
> -- 
> 2.54.0
> 

