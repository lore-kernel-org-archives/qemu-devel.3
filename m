Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11683C54F30
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 19:32:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJH4J-0005Vx-Sd; Sun, 25 May 2025 15:31:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Edgar.Iglesias@amd.com>)
 id 1uJH4G-0005Vf-1J
 for qemu-devel@nongnu.org; Sun, 25 May 2025 15:31:32 -0400
Received: from mail-mw2nam10on2076.outbound.protection.outlook.com
 ([40.107.94.76] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Edgar.Iglesias@amd.com>)
 id 1uJH4E-00086J-3t
 for qemu-devel@nongnu.org; Sun, 25 May 2025 15:31:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i0bkgJ/ue4a2LNCt0VHYcAU37dtfwknfsRy6BXO3p8tX1OHGudTFUxCOTpkwyg+uiC3p0d7yD7KscGQ99Xte18w2EN6drbX8ywaihcZQwuo8jjRF65Z+eePbd9ZsGf5F2VbhUbJSzVIpW4QjCmzRYtol5LkNAavZ3WbvhGOIcY99N3CXPC9Ebdvl0Ys28KKyAKihvNZEH56jsYO+GZl8tXI/duzLLu8yaE3HoY2hxm2CZ5DfEepF48yPGetYbjgMcYgn/YN1OAauy1Fqgr1MjuopMJvCqDzkSoWCfLN2IbkhEYM59Ih677AS/gSc4R7Z9u8Ln60sWCUkK1YoKj4hvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cytz+9KXOJseXjqXH2d61l15VgXuFScqE7g+i1VxMlo=;
 b=RIKXAlfB+sRD4pE/q/rbAgDZMv9uPrh1CHPjYvCiXGsGhH39L+OX1IGkTz+4/xC3SZwtyxTa/5w4twEryN3C5Zs55ptT8StSFTtRrDow2wm3kSbtE7PwgLaUlRhZ8n6YytqcGThwvZDXW2tjfCtxgu0rRKjg+s7eW0BBLfqJO75j3CzT+1M3oU/xs6CnzwfyTqngb9U+bk+Ljxr+n4NeDyKfBJjoEdjk4//93kLnTAy7pKIj2QIj9n/sKPYt7MqVc6K+ohpcCCSUlpiIw8+LoLe38F0wNNkGQTjpnwlbYyVLbnptgDUKL5zj0RZKw6KCV2+dnyK4amDSJGWW4/bf+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cytz+9KXOJseXjqXH2d61l15VgXuFScqE7g+i1VxMlo=;
 b=3SW0zmGEh7vgB1JdqJdLlArZJIGWDdb19LwIY+nhPh+jww93y174srp/EgdPoIVOGBDvu1KqqZPdA0qJGoNDDHg6EUMiL+rGEa7CXjLTACKM/K629KCjioP7h8uU2IJRCcGXO4s/ULNq/jEh738DMTpZ2YP6zoWWvJwahbtsX9Q=
Received: from BYAPR11CA0090.namprd11.prod.outlook.com (2603:10b6:a03:f4::31)
 by SN7PR12MB7420.namprd12.prod.outlook.com (2603:10b6:806:2a7::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Sun, 25 May
 2025 19:26:21 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:a03:f4:cafe::37) by BYAPR11CA0090.outlook.office365.com
 (2603:10b6:a03:f4::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.29 via Frontend Transport; Sun,
 25 May 2025 19:26:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Sun, 25 May 2025 19:26:20 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 25 May
 2025 14:26:20 -0500
Date: Sun, 25 May 2025 21:26:18 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
To: Richard Henderson <richard.henderson@linaro.org>
CC: <qemu-devel@nongnu.org>, <edgar.iglesias@gmail.com>, <philmd@linaro.org>
Subject: Re: [PATCH v2 01/10] target/microblaze: Split out
 mb_unaligned_access_internal
Message-ID: <aDNu2nGrPyIc-gMC@zapote>
References: <20250525160220.222154-1-richard.henderson@linaro.org>
 <20250525160220.222154-2-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250525160220.222154-2-richard.henderson@linaro.org>
User-Agent: Mutt/2.2.14+84 (2efcabc4) (2025-03-23)
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|SN7PR12MB7420:EE_
X-MS-Office365-Filtering-Correlation-Id: fa23f7dc-6613-4244-9704-08dd9bc20780
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gZxEjT6JAe/XzkouzblgGwNWzn74KUyW/1ZbMi0krWEf6B4hR0mp/8tCCIxR?=
 =?us-ascii?Q?rbM7GfhIcJT1kXqKZSLW6/yfjHp1np/x5nkjf5A1ypKvLf1hl7Gelxeukh3k?=
 =?us-ascii?Q?25kng3wfwx7wPm+eNtX64sauH3McHSlGgEi1VFzXLKH661+FGSJ/ky3p+dAq?=
 =?us-ascii?Q?RZ72SOukYtdWDhzJOtLJS/yQz71LNmAOFBZQhWGBsskvMsZ2XJ2cfQnHTXBO?=
 =?us-ascii?Q?pki41sWg3BPLUPSECRb3Klhl9yjJ8GFI3ijj87UcjpEzVYPpUd08QWIff1Y1?=
 =?us-ascii?Q?knFfue+B/mmAJXNCXfetJzlFmAJmEfzcjhixbwkhUCpUlOmL/XZCxqyUzjUa?=
 =?us-ascii?Q?KUiSlxeR1WUM9Y/C565YLeDi0YSJ25Yx2CoFZf0Ncz6biZorsDyBBWiMUyiF?=
 =?us-ascii?Q?fkoxyraVcWU9DefjVDJISb6UcJxWOfbdl0ycm5aQ1/diUaOkHV4FO/BDr8tp?=
 =?us-ascii?Q?E9FfAT+WGGYvmozqq9hNLJkK/Edyk7dolktT26sbwuPhHKMB6lnNHZQnPMMR?=
 =?us-ascii?Q?kxwpq9LcivhfKcISdDK8YShrwgcs65VZR66undT8nXyP8qRui53KY+uEqvXI?=
 =?us-ascii?Q?krjftkoSivvK05x0QRWuDJIoNRGz7TUxOfcu57RXhTmh5+K2hz8QNqVnp7F1?=
 =?us-ascii?Q?cB3iizuC3VsdK2IrOqxH9SrFBP0vOHfMPFSkMVNpr+vm9ZCIiY8ZMcY0X3zy?=
 =?us-ascii?Q?tNigBvlOBoUsfKQbSGmkaNikOdN6OqsSwiplEQVmPu7q0EXbPDRaWvSJvgdN?=
 =?us-ascii?Q?QMDbGG6Idu7Lup/mv14/1jxFa0RYyXVBsJVI63DoQ8c9TaKyZDzyDRzkPfZc?=
 =?us-ascii?Q?5+ajuAoxPpWVBDWh66JjkYP1ESpYCJEmYZ8uL6TiZZKQgksjsZdrz3aMraMG?=
 =?us-ascii?Q?EbABaZHETdBBrNKX/XihBG90bdqdcgXDmyJiZzYzndGp0GY4pHu/ZMaixODx?=
 =?us-ascii?Q?4jFoBkqdbWmP0ERfU7f7CNo0+dUYdklc1JnNh8jZ/sUccMTtrDTmk9q+dcrx?=
 =?us-ascii?Q?1Gmrui0S+4ItAg8SqhOilDL0oGPeXUbWsYIOSJ77+NeQmxgz4lyHXRqLWlg5?=
 =?us-ascii?Q?OkzJei8uLzeLJqjTwp3ADQILbPjtp+BXOCp62/C1toW8/l6ghBJztwEHvTZJ?=
 =?us-ascii?Q?/v2r9e5kdRRaintX/Ga0ymp8E4WxNvutUJiF3cFzhz0hDb70aNQm0JwmSKiG?=
 =?us-ascii?Q?Qp92e9d5mt94FRqMlG1f2EtuvVIxv5Ik71nxx3o9s/YoXo9cQNX3xKtwh0ew?=
 =?us-ascii?Q?YjNRDTUofgq4xO2667SvIZVxvJ36jh8ha29xsIyEErOxvb4oor1MDw2MRqb0?=
 =?us-ascii?Q?lMwpk4ycbfOc9oQeT/FVQQovE2rpvJvrF/QegPsy4UH36Vjm4cqlau9jVOhz?=
 =?us-ascii?Q?k2sbvFf12tHvVr4qqdKhYu9Q0OfQlO51yp0vd7cYado2YM3BtnG6rdNvjPwx?=
 =?us-ascii?Q?fpOMHb55Nsbgw+NnkcnPKwYREJ+KOAAewVU4x5Z1TcxPAz36oLAAgn83Schc?=
 =?us-ascii?Q?6rkZwz8vVXVV/E2XbZjXiWVzUwRyv2cuO0AN?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2025 19:26:20.7311 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa23f7dc-6613-4244-9704-08dd9bc20780
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7420
Received-SPF: permerror client-ip=40.107.94.76;
 envelope-from=Edgar.Iglesias@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sun, May 25, 2025 at 05:02:11PM +0100, Richard Henderson wrote:
> Use an explicit 64-bit type for the address to store in EAR.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>


> ---
>  target/microblaze/helper.c | 64 +++++++++++++++++++++-----------------
>  1 file changed, 36 insertions(+), 28 deletions(-)
> 
> diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
> index 9203192483..5fe81e4b16 100644
> --- a/target/microblaze/helper.c
> +++ b/target/microblaze/helper.c
> @@ -27,6 +27,42 @@
>  #include "qemu/host-utils.h"
>  #include "exec/log.h"
>  
> +
> +G_NORETURN
> +static void mb_unaligned_access_internal(CPUState *cs, uint64_t addr,
> +                                         uintptr_t retaddr)
> +{
> +    CPUMBState *env = cpu_env(cs);
> +    uint32_t esr, iflags;
> +
> +    /* Recover the pc and iflags from the corresponding insn_start.  */
> +    cpu_restore_state(cs, retaddr);
> +    iflags = env->iflags;
> +
> +    qemu_log_mask(CPU_LOG_INT,
> +                  "Unaligned access addr=0x%" PRIx64 " pc=%x iflags=%x\n",
> +                  addr, env->pc, iflags);
> +
> +    esr = ESR_EC_UNALIGNED_DATA;
> +    if (likely(iflags & ESR_ESS_FLAG)) {
> +        esr |= iflags & ESR_ESS_MASK;
> +    } else {
> +        qemu_log_mask(LOG_UNIMP, "Unaligned access without ESR_ESS_FLAG\n");
> +    }
> +
> +    env->ear = addr;
> +    env->esr = esr;
> +    cs->exception_index = EXCP_HW_EXCP;
> +    cpu_loop_exit(cs);
> +}
> +
> +void mb_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
> +                                MMUAccessType access_type,
> +                                int mmu_idx, uintptr_t retaddr)
> +{
> +    mb_unaligned_access_internal(cs, addr, retaddr);
> +}
> +
>  #ifndef CONFIG_USER_ONLY
>  static bool mb_cpu_access_is_secure(MicroBlazeCPU *cpu,
>                                      MMUAccessType access_type)
> @@ -269,31 +305,3 @@ bool mb_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>  }
>  
>  #endif /* !CONFIG_USER_ONLY */
> -
> -void mb_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
> -                                MMUAccessType access_type,
> -                                int mmu_idx, uintptr_t retaddr)
> -{
> -    MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
> -    uint32_t esr, iflags;
> -
> -    /* Recover the pc and iflags from the corresponding insn_start.  */
> -    cpu_restore_state(cs, retaddr);
> -    iflags = cpu->env.iflags;
> -
> -    qemu_log_mask(CPU_LOG_INT,
> -                  "Unaligned access addr=" TARGET_FMT_lx " pc=%x iflags=%x\n",
> -                  (target_ulong)addr, cpu->env.pc, iflags);
> -
> -    esr = ESR_EC_UNALIGNED_DATA;
> -    if (likely(iflags & ESR_ESS_FLAG)) {
> -        esr |= iflags & ESR_ESS_MASK;
> -    } else {
> -        qemu_log_mask(LOG_UNIMP, "Unaligned access without ESR_ESS_FLAG\n");
> -    }
> -
> -    cpu->env.ear = addr;
> -    cpu->env.esr = esr;
> -    cs->exception_index = EXCP_HW_EXCP;
> -    cpu_loop_exit(cs);
> -}
> -- 
> 2.43.0
> 

