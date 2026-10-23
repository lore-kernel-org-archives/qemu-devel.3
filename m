Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2A5606A319
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 01:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=JRT9L4Ip
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK4Ur-0006M7-Tw; Thu, 22 Oct 2026 21:55:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xK4Up-0006Lc-Ez; Thu, 22 Oct 2026 21:55:03 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xK4Un-0006tX-J1; Thu, 22 Oct 2026 21:55:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LNcnNdDMcscHhw+Qh/IQhWz0l3cRmarv8AzMY8DuqhG+Jq0T5FMhXYjeIfNmCexzlDpMFNDRBEuK1cAKinEOqtZLer21Ni+vmRsvYgixBqCJWfpm6Yh8TAlEUL709x5CPwjpFgPO+7JqS9rCpcmsyYX3AEydutP8DWN/fxGGhvgz6VUYHk6W3k0upCUxwKeWGzI4B70QazDFKUJrAsWCdngz/8WoCqted60H3VLMIAMH3dpMJSs0OPH5ssd2smSBKaLxZQqwRgUfzX8g3oa94zTTCt0kW4xJQH3tHgEfxvg6ddIAV7pepPsklfkFS4PeC1QrHTNug1jRtQJumk6ncA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QB8zFAZEsqira6pnJreUPqoTVCdDfgVI2chuPl7jeMw=;
 b=mI6uFgajsRe8FPO7E1C6eRpFmiHKuIEE99EWbANj8qsPyNCI1rO13iOF9+0/TY8OE/vhkcNTQw0LHCshKYLbSl8hFqY7W9409rsI8XHSa4KeKoiAM4fy3+te0rxe0JMAI8yNkQxQUue240VrxuxJJCcSY+iRy2YIl7AOxGYIqHsDDdzmXrH6SxgJgQzzN5cKBAHcabbjWE/hWFk/Pl6RH7MDUkkFAbZn8uipddStgaQaDzkH4Yp+SExaYBDGDwfJz5CANAlBMEv7JJPbWqxJ3ffiF+H9QZzVRQdzlYO/NcLbMrRW1CUPKIWLNN4dM0DuAfchxVc3EuvHzIspN8/89A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QB8zFAZEsqira6pnJreUPqoTVCdDfgVI2chuPl7jeMw=;
 b=JRT9L4IpKslTNIjDDItJA+qzh5FF6FsHafG0n+vlQYL9y0gIY+/N7jloD039p8mLUeplt3Ft4vgiIN1i9wsLPNo71ec5zcuQxI+Q5R7oPuzGlNjSk1xkkhKDHl1XPJwKZBbfucr/nEaQH7CN2lKlDAWdMTvhWGF8toqCPr6YsFF5dPtiqM75tFvSN6xnQJ1Xb4kunx17HfSO3wb8Xy/1OcznA5mxiYmnettun93sw0CYE9TBn/a5Yj1AMlW+UcbH0sH6bvX0rRMslSPGeLNlglJHAEl07hJxN3JiKQIUsD8ycPTPyImt0PAVr/Tbhb/cq6OxSVWAy5YHhUXuwYpPug==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by KUZPR02MB9089.apcprd02.prod.outlook.com (2603:1096:d10:60::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Fri, 23 Oct
 2026 01:54:52 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 01:54:52 +0000
Date: Fri, 23 Oct 2026 09:54:45 +0800
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
Subject: Re: [PATCH v3 23/33] target/riscv: Register
 CPUClass::exception_name() handler
Message-ID: <atq-TxRhT_Ns_nvV@MacBook-Pro-4.local>
References: <20261022215115.19680-1-philmd@oss.qualcomm.com>
 <20261022215115.19680-24-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261022215115.19680-24-philmd@oss.qualcomm.com>
X-ClientProxiedBy: PH8P223CA0025.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:2db::13) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|KUZPR02MB9089:EE_
X-MS-Office365-Filtering-Correlation-Id: df59ce95-0c81-40b1-c528-08df30a8a105
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|261022105027099003|261022075727099003|56012099006|261009223027099003|4143699003|261021123027099003|261021121427099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: lRez5ANXvms0fhRwJwiku0IAQvwkFGo0FB/qcMLXgbE5WMKorjtlwqYmPA+WaC4T9sqaUU9r8oWPertA8UUi1piuBrgn+CkE1WMW9meiPYHUcP4fL8Ex30tU8XZymurlppWO8shm9ThF6la45Dq+MJ7tU4gckteS1fuLMi0radL4uB89aHW3+9mBNnPcCX4URhMs3dfBf8kz2kr2ulDfgQ7zu9lBZe5MwDTaKHtJgNfSHe9sTbzRnahYzVQB0m/Sm0ieU6XoatmEcMS1SOJT8r0zO5xTKNzGUUblgSSCLcfghT7MI3zop44DCQRTYcMfBWu65KS9LF1qRyOsL2KPUqXLpxmwS6cZcbu5qPQbXnt6Nt8f5YN+6fcnKwz5QgLLvOtG/HowxGMPyxPU6lAlnoWSUKdmGM9LOCU0+dikL0vlk/v/HPgWheIR23atJ87rmAbE2i/wstwYL/KTKbPF/UQ36Jx6TSctrqi9WyuzST+llt8cndjhXtKPGs7KphwNrxLzZzHs1/8Ou6ZHsXlfSukQG+KJmNsLBuxBsQGKSXhmBapnuPfwrl8eGd9AkAPBajbWnoVXwSVrwFw97Kkwoq8yJL8otyWSFO1r3goyWCS1rnkxpZgM3ScEGTcnVvGSUC3J+fWEqaHUEJaFXMkpEJO9+QaxMno9SiP4d0isRWc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(261022105027099003)(261022075727099003)(56012099006)(261009223027099003)(4143699003)(261021123027099003)(261021121427099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?oVV5Kp0D8QjGLBGThfz7UuMYeLj0deD3YBSVNDG9PIDHJV2BRv15TmRTMh?=
 =?iso-8859-1?Q?VsV7Kb6spLwVLGd2sri/mHITojezEUIZK0qk40crk1rjqyoL95MjQHdySG?=
 =?iso-8859-1?Q?a+/tIrsvx/aT6gCNmhU2OMIBElEo0jUd83almGS9ww3ucRkDdtGNzMPy+A?=
 =?iso-8859-1?Q?u6xsMGsCCLEZwbpgJPmUJC4RFSLrkmHtBCkhqkm+YVKNnhmgSRwqPM4khB?=
 =?iso-8859-1?Q?uFCpkk2mhDuSDTX0QfJ9icuLrxfADiWjvbRAcxA3hDjbol1oOjSrb6lOz8?=
 =?iso-8859-1?Q?qtMZSf5Qi9mt5eZ/wu4DupgOpj2PihB3R2B8GSvqqvDK0kKIUZMbeG00XS?=
 =?iso-8859-1?Q?jtALXgXPsJHx/Spd8HBplXae3MnTjA6dpzKZasY2v9bUxKZD8zRqRhQ0YC?=
 =?iso-8859-1?Q?l/XzT1DngEqx1C3tBvLOitSYjqQ7dRoAl5zhuJ26YQQJ5GCDBbcysVdVaF?=
 =?iso-8859-1?Q?aY15aMjkfhnqsO1SUXW8lKdPd/Jm95cygsuxRFjBfFlY9TFPs6ffyRcrUC?=
 =?iso-8859-1?Q?LO12342TIerjolifrqZQaFVY0a8oMrR23wQu2bKpnAv69SVgldTU25l9nd?=
 =?iso-8859-1?Q?rjzkNxPx+/UiAnZAaU5DEY5VYjftokrAmHVa+UTncfKBmtgofBxt5OIK9R?=
 =?iso-8859-1?Q?SeLTd29MvW4GbUcNJi6Cv/y5LCYEaz9uWcDdn/YHi6N+XoxB6j204um6HP?=
 =?iso-8859-1?Q?V84EAoE4NnAesd9X9Hr5CgOVsOtiKC+RG5p4Rs6mvHgkyfzaZjw7hIwbXj?=
 =?iso-8859-1?Q?HYgplfAkW7oA+e898mQYfHVYy/GLjqFrf4OGoUpnavyorIA7VQEziL8fJb?=
 =?iso-8859-1?Q?KAdR/x3gJWZ4VFVyXTz231FtUcdDXuwZHIswMxbRlcdFY33fuWhtAX8EIZ?=
 =?iso-8859-1?Q?jUgmqgEjksllnZMtlS5YvzEXrYzfefBUKKzoBuOfLXO+KIHfTYzLS7591X?=
 =?iso-8859-1?Q?EH4VR2pCgLf4zTQUajt/SR6REpdI5LcQ23HxW7g3tU4uDdGhRi4XKI0zDG?=
 =?iso-8859-1?Q?yeSdgtvHXA/Z2Ca7x6ThlGEvizwZlp+sTMd8Gx6qUPZxonnijX+XQdzjIu?=
 =?iso-8859-1?Q?+46QxyDp7MRR/0S7DupCBggwPPnAjc9FkwHc9N3uSDdRnwcghEfAMzVGZV?=
 =?iso-8859-1?Q?Cxvo9flEbMsWwEKSCV794x7GZiX6HayHKXDpeEgISIsFv9nhVgwfNgfyoq?=
 =?iso-8859-1?Q?5+l+h1MMRUXVRb+JeiweS1kjJI6IaPWGs7l3wTca2UtbgIq7O1+nsvpC4S?=
 =?iso-8859-1?Q?A3rzijYhuonLJ3szFkzNmXB+FpYYmFCcaEIQZE7VxUdcLJ+rwmB8hBTaLf?=
 =?iso-8859-1?Q?M5u8/SQSEHWMvxnpQW72Ov40T6RVsG05NhNunp3vN837/6wavt4yYM2WDu?=
 =?iso-8859-1?Q?bthH/+S5ZCceR4/+bGleEI8+ZPguK7zc4OXzujFoAtPnWENRLWeAzD2nr3?=
 =?iso-8859-1?Q?XSpLl7DKKQxqB9yzdUoPgMx2scE2zreGhMVA4J7QX3y00ykVflUFVXl9+h?=
 =?iso-8859-1?Q?RbrdIwSvNpnPOcVAB+gMgf1cCXvPVP+Z7CdnvQKD7/q7AXB8Z4YrYrXmmY?=
 =?iso-8859-1?Q?gFBMjwBcM0fNfxCFLpBTneqshtCIJ8xZh1QY8P4p/pZMrld/McXYv5vCwQ?=
 =?iso-8859-1?Q?AKmoSu0yJKLsruosdO/wuLs+OBKogEF1q8DcqCEVET3udVXXPeYPN4J+JY?=
 =?iso-8859-1?Q?OH3Xa084cSf3kgNkV7H0FOx6NkVkN95ZOYrRrcLC6+AviL7jO3MaVurGY0?=
 =?iso-8859-1?Q?wVkqLIwTrrkjtkUbwh6CgW//SujX8LJ38o0GFhVVMYZjMCXfxEowy227gA?=
 =?iso-8859-1?Q?inv0rgN2vVWYdRbLVSq0RHbmU/9bjlc=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df59ce95-0c81-40b1-c528-08df30a8a105
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 01:54:52.5640 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gb6haxYYl1Sxg+msKW/gSjpa0Wwls0RWDTr8hxOOjfl1DXUw52/Y5DGwF4KkRZeiGrN25Sh//uoVm/Zpnbr4JnBUNFrFV974QH3+51g0G08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR02MB9089
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=chao.liu@processmission.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Chao Liu <chao.liu@processmission.com>
From:  Chao Liu via qemu development <qemu-devel@nongnu.org>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 11:51:03PM +0800, Philippe Mathieu-Daudé wrote:
> Factor riscv_excp_name() and riscv_intr_name() out of
> riscv_cpu_get_trap_name(). Register riscv_excp_name()
> as the CPUClass::exception_name() handler, so the common
> exception logging can resolve RISCV exception codes to names.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  target/riscv/cpu.h           |  1 +
>  target/riscv/cpu.c           | 20 ++++++++++----------
>  target/riscv/tcg/op_helper.c |  2 +-
>  3 files changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index b65d6319940..49a1186bdbb 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -672,6 +672,7 @@ G_NORETURN void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
>  bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>                          MMUAccessType access_type, int mmu_idx,
>                          bool probe, uintptr_t retaddr);
> +const char *riscv_excp_name(int excp);
>  char *riscv_isa_string(RISCVCPU *cpu);
>  int riscv_cpu_max_xlen(RISCVCPUClass *mcc);
>  bool riscv_cpu_option_set(RISCVCPU *cpu, const char *optname);
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 08a4d14ea1f..e1652bd2a40 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -18,6 +18,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/cutils.h"
>  #include "qemu/qemu-print.h"
>  #include "qemu/ctype.h"
>  #include "qemu/log.h"
> @@ -398,6 +399,11 @@ static const char * const riscv_excp_names[] = {
>      [RISCV_EXCP_SEMIHOST] = "semihost",
>  };
>  
> +const char *riscv_excp_name(int excp)
> +{
> +    return STR_ARRAY_ELEM_OR_NULL(riscv_excp_names, excp) ?: "unknown";
> +}
> +
>  static const char * const riscv_intr_names[] = {
>      [IRQ_U_SOFT] = "u_software",
>      [IRQ_S_SOFT] = "s_software",
> @@ -417,17 +423,10 @@ static const char * const riscv_intr_names[] = {
>  
>  const char *riscv_cpu_get_trap_name(uint64_t cause, bool async)
>  {
> -    if (async) {
> -        if ((cause < ARRAY_SIZE(riscv_intr_names)) && riscv_intr_names[cause]) {
> -            return riscv_intr_names[cause];
> -        }
> -    } else {
> -        if ((cause < ARRAY_SIZE(riscv_excp_names)) && riscv_excp_names[cause]) {
> -            return riscv_excp_names[cause];
> -        }
> -    }
> +    const char *name = async ? STR_ARRAY_ELEM_OR_NULL(riscv_intr_names, cause)
> +                             : STR_ARRAY_ELEM_OR_NULL(riscv_excp_names, cause);
>  
> -    return "(unknown)";
> +    return name ?: "unknown";
>  }
>  
>  void riscv_cpu_set_misa_ext(CPURISCVState *env, uint32_t ext)
> @@ -3128,6 +3127,7 @@ static void riscv_cpu_common_class_init(ObjectClass *c, const void *data)
>                                         &mcc->parent_phases);
>  
>      cc->class_by_name = riscv_cpu_class_by_name;
> +    cc->exception_name = riscv_excp_name;
>      cc->dump_state = riscv_cpu_dump_state;
>      cc->set_pc = riscv_cpu_set_pc;
>      cc->get_pc = riscv_cpu_get_pc;
> diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.c
> index b8b3e43ccd5..f85f5cd83c9 100644
> --- a/target/riscv/tcg/op_helper.c
> +++ b/target/riscv/tcg/op_helper.c
> @@ -41,7 +41,7 @@ G_NORETURN void riscv_raise_exception(CPURISCVState *env,
>      CPUState *cs = env_cpu(env);
>  
>      trace_riscv_exception(exception,
> -                          riscv_cpu_get_trap_name(exception, false),
> +                          riscv_excp_name(exception),
>                            env->pc);
>  
>      cs->exception_index = exception;
> -- 
> 2.55.0
> 

