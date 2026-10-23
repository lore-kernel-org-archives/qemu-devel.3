Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F346606A319
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 03:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=jO9RpR+o
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK5cV-0005kb-7h; Thu, 22 Oct 2026 23:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xK5cR-0005il-V5; Thu, 22 Oct 2026 23:07:01 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1xK5cP-0004ip-B4; Thu, 22 Oct 2026 23:06:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hw7v5sbpVPouVTBRcm69SQ0lf38pLNt4eTwOkXGGIBN146h83phdSl7nfbZx0XrbrbxGlTEsyOg68sCjT4gUqQ0K6+nONRanA10xvM/M1f3r0lQuyVXalIsnJjS4Sc1eOGHgmQ1ZhVcruBEN2yHTIl3NUiZMJ3e8cw5ejc9CmbqX4IFC+a+Iz5RyHIG/zCTxNQMw1dvoXW1M0NJPmDnd5OgyqG71Safg1IhB6JOyMulSaTQLxWCb1POL4K18vPm53MFy+C+5hpcPs+fvI0E4ptzo7iCrIlHKEaep0Xq+tYnBSrLHQykC9nQ4Y5SCC1JnAMpL5SWQIbH8k/SL5rK49Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2WCBQ4Z4K+TqkNDckpFRkQ9O+WffQpMr0dj2Q+uEzvM=;
 b=baZResWtLlX4UYKgrfjqJKh3Gi+Q1fwUE/mp5/Ny5YOAl+UwzfWgdGj5nuU1tLkoN0ppy99QEMOjkxKNx/Fgs0i/qnVspl00QwnjgEgUc8gu5Jg3Sn/6FF6Cvqt3ENbXchLr+046MWDkA0Q3WPz6J9AbVa0tRBVFE8DEAoclJCR1KcH8780uUnE+8tE+Ddc850/ioaMRCMGQlne+GMIh/oxlMK35Iq/efvrjLt3fXyBtuH0Sln5V+7+CyBbGDeX9sd5mm/3Qs3oI5ahIHismCqJPY0KW8MTqQc1D9mWRsRCTE7D4+mNjNjF0DVgBNzDGx3S0lPTGr8Rtaz0rEPNI7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2WCBQ4Z4K+TqkNDckpFRkQ9O+WffQpMr0dj2Q+uEzvM=;
 b=jO9RpR+ohTkD/2eLspdJMacWDaIPEifwf3VG5XhndaNPGAr527BJx2/g+kVdPyu9TbvHIJZLb6hKwohE6+cjZYrbGCWKCl7kIYLBEpikocnwIyhvaprtUG0ZR5yQjbxae2rmswC0po6APaqIK34ytiH72ab+f54xJK/Lpt46QY6H8dld5BLYnwrfT7f6IkZvK+yjY3kfd1efzUEhdSAF+cEq1aonwe2DhNCc8yFdW4ocG9fPuHrI36RvFINhDXMSdZOu0yT0D8VeQmKiFuAbNfD8p+tECcXxtXYAGhuQYNnUbu6//fZ1YnL/+pPCk7wX4TFRTpoC/qHKcXMSU3ME9g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by TYSPR02MB7526.apcprd02.prod.outlook.com (2603:1096:405:32::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Fri, 23 Oct
 2026 03:06:51 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 03:06:51 +0000
Date: Fri, 23 Oct 2026 11:06:46 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Ralf Ramsauer <ralf@vmexit.de>
Cc: qemu-devel@nongnu.org, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>, 
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Lukas Landgraf <lukas.landgraf@st.oth-regensburg.de>
Subject: Re: [PATCH v3 3/4] hw/riscv/sifive_u: derive PLIC contexts from the
 harts
Message-ID: <atrPNiR6nZotQMyl@MacBook-Pro-4.local>
References: <cover.1792700406.git.ralf@vmexit.de>
 <f5bffbbaf8272e743f184e9f5681ec5931800e23.1792700406.git.ralf@vmexit.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5bffbbaf8272e743f184e9f5681ec5931800e23.1792700406.git.ralf@vmexit.de>
X-ClientProxiedBy: PH8P221CA0062.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:349::14) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|TYSPR02MB7526:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a007e05-ab5d-4d89-ad82-08df30b2af65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|7416014|1800799024|366016|261021123027099003|56012099006|4143699003|261009223027099003|10067099003|18002099003|22082099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: SiJJQInnSJorPEpmBSkW3AO0dffc2r5mqRWxi4sfsSmlwBuZPSkCqI2X5JdTg7rY6KFrKGt7Qkl/SiKIPzrnxVxYpwEKmf2GMbBgq96b/i27AjRlzE0hxVqkauY8P1L0FyIkxNZm7GusHR+HVg97Zeqynvn1LlPa7Iu988wk3P6Lef5ZUKK15/+14PoKIEhOHL7gqLE1CyPSBH/e4AY5EMF+n6xH/esEyYvdpeq1bLkr3ToM7jNj5wM9xlICCTE/MCuQpn0E/2kb6+sUqon69r9YKK/SibsdfR9rFKAUeuYf2euvye5vk2Doo7UrqWCUTlB9Y+0IjtAXt1kSxtYX46QI5bsR3nfwTpRHa2SqOxO7F8RpWTqLhvw2784OKSyQH3vOLAL8C+8J3owsnNPJ4kQJOwKKwolI1Idl0pTLYqmhHRlc3ao6C3tQF2958tmfoeWXVcVTn+Npzl5QbvBjDCwm0uLrBakW478BffVoENqkoz9tfaoQlrD/1Y2LZMTy0AxYA33TPn+h7H2z6qudpd2ObC2wsjhMKkFJZ8qT6Hpdz2/bO77QNKhXUMUVjecBeJEScmR+7T9dQEBaT+XOeKgPQ4swXFoHEOcS4iTxFRgQFlf+au4zXXTx5o5pDj4PqF6xadg91/uh/87IWJDuGsTRAJB/MiWMJcVRAI64QKo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(261021123027099003)(56012099006)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003)(261021121427099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/vzNs7gZlX6bOqRXnk+lVMfIrlsR2irMGeBU3M/XDhTSpuaM/ctNwTKQUVSA?=
 =?us-ascii?Q?bBeBZBDWGhLbjbrOl8oCKkbd2tcJWcB2pe2nPCIT1vtydgaB+wQRwGvgnll9?=
 =?us-ascii?Q?0++wrhZz8FJGPnnQPWq6+6LVOunA28KeRiDWRrvK5B+QZ+Mq8wOs5iAvKT2W?=
 =?us-ascii?Q?9IdZ9nHysuFHKdfnMa23TEZrKKrmdkAtt0XD0wywwS/meHmn6S0dwqt+MZE2?=
 =?us-ascii?Q?0R42877+LRKFRv4bPfp/DwOyOX/F2/C4RefWGScz4u8nLwYuzndPhqCFR/bv?=
 =?us-ascii?Q?vdsR0x74Holwy946Fy/s1vXRs1nfxfJ5X2yzx+cEF+11v8Hcd37GNOp+biGQ?=
 =?us-ascii?Q?zyy2ECh2vFwcdf+KyIvPD0qo7im1ppCn8Ysj5j44a0GqOsc9yI0ARSCtThXX?=
 =?us-ascii?Q?BYsUnOSSWe+NQ8+F4js92Oks89ssImS8WkgTuK1e+UMWeiMYF5b5Hc0jrJsR?=
 =?us-ascii?Q?PqvlP+BNkdqmCs5Fo1G/y7/gW/Guv7MQhyI1LcFnsqz7Bl2QWxSbnS3VB7NF?=
 =?us-ascii?Q?MKppUdz5Oaij1BGKBhrOc5+53uxMc/JKXTQ2arrIfhLD3CeXfvXugf7sMQ8j?=
 =?us-ascii?Q?ce4GwoJENI1Ib/MtfAcQ/oktR8e6h9bptOiv8jKyD+VLW6mX+CZa9LanKKmA?=
 =?us-ascii?Q?TipJ+vV89a5EIQzLmk2YO6hi4Vv/VuTwJl+4jVRGODRvsXx7eE7aVEf0hdW3?=
 =?us-ascii?Q?9jfSDGJS6dXoq4WnkkiRp9ADVmZ5ozrpCye3zK6WthmWxMwwvjz5rtegcxU6?=
 =?us-ascii?Q?LKmr41fFtyDub9x0Feb0ttcw2dZYptAdI3AAVd2NxKA4RPQmA8LjfWJK9Qom?=
 =?us-ascii?Q?+h9B01ktj+Fgj0pnuDGs3PEoAIcyrSxGn7iC+E2zIpAC5bY9lR7XAlGN1CF5?=
 =?us-ascii?Q?pt68riEvxMoXOFDdUswZ0vH1HY+/tdxXu/zOPusDRrZn+KDghCPWzMZhfSQ5?=
 =?us-ascii?Q?BEwq/CuCwuaYCcoXbSV0iYwuATUuO+9qylMjAPOdQBQV5yyYvifTrnap3FHA?=
 =?us-ascii?Q?VQjRRlkhYNHJh+cDli7S7cNw6Gery59wLU+lo2hrzDkaNlO01+MpOs+zqPEt?=
 =?us-ascii?Q?vjOLVCDJXkrSfkp4NZeXHT868rCJXaYrqKI/egZ8Zc2xf7ozIRqC5qNiFdXP?=
 =?us-ascii?Q?r9LFYJiowRIW28gUrSUpoGOgJXpYoMec40TqIcpFmnxYlu7PqpbsnudkpNg/?=
 =?us-ascii?Q?WgQLa0UKeTs4DqTNSnMrEYhd2/W/BdUNCziNTeXWcfsM68zQbJHLhDF7DHeA?=
 =?us-ascii?Q?4j09vd/LAg0Be9vTOuSqHGt7DpIletbozcrxtKbIeCD7v74IqFblQBY9RktI?=
 =?us-ascii?Q?E3nR1/1FSRmNU5jNglKhisoxpIgcQGCMU1/hxUFdu9QVFmrx+HNacXN6fmQP?=
 =?us-ascii?Q?psPCB5x+iBl7srwk/8J2JKOjxxsj8T0slTP/k+KvDub14hBnAselyb0Mi1V0?=
 =?us-ascii?Q?9VFLrQYxOWUvbrWUdoMQStJybCZhljcisdtuA2hzCVBrtuuf50rjZQUkGMXM?=
 =?us-ascii?Q?+SJ3S2HExCNLrEQqCAdNrNC6zXJM5mae4TiTmrDUIs3pv9VEPKIFjq3oIDuA?=
 =?us-ascii?Q?JajNvbqDXEBryiiaGRlzz+Ao4OtRmaQ5HOI/D3KZLJNWSctL8cWdv7yImRUk?=
 =?us-ascii?Q?CxEclMRc8Kq6vXuW6eNwTC97X1G9Dl8nCsTJzn1DwCugp+q8ZVqcjpUFTvc/?=
 =?us-ascii?Q?feVyWw+ynMycHEc4RYpnvSaLzsaOlT3hkq7VFJNDmLAAZdF6iZmQPeqNBB56?=
 =?us-ascii?Q?ww2wirh0ExPt4od+UNj9Up7AeEABYNc=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a007e05-ab5d-4d89-ad82-08df30b2af65
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 03:06:51.6474 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lbZgb/3C3BGl9nFNyJPA9SN32M4TxDpjGiGdFrLqJxO0ztcydNfjf4iCLeoOcveQ2uazW+l2koarJbgDw4v4h97COWlNsRi1PKMO6rp1eK8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR02MB7526
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=chao.liu@processmission.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Thu, Oct 22, 2026 at 10:22:17PM +0800, Ralf Ramsauer wrote:
> From: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
> 
> The PLIC device is created from riscv_plic_hart_config_string(), which
> gives a hart a supervisor context only if that hart has supervisor mode.
> The device tree instead hardcodes the fu540 topology: no supervisor
> context for the management hart, one for every other hart.
> 
> Both agree as long as the application harts keep the default CPU type.
> The board sets no valid_cpu_types, though, and passes machine->cpu_type
> on to the U cluster, so -cpu rv64,s=false,u=false builds a PLIC without
> any supervisor context while the device tree still advertises one per
> application hart.  Contexts are numbered by their position in
> 'interrupts-extended', so from the second hart on the numbering drifts
> apart, as it does on the virt machine.
> 
> Ask the harts instead of assuming, like create_fdt_socket_plic() does.
> No change for the default CPU type: the E51 management hart has no RVS,
> the U54 application harts have.
> 
> Signed-off-by: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  hw/riscv/sifive_u.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index b7d5e7b4da..8f50c67a14 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -99,6 +99,7 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
>      MachineState *ms = MACHINE(s);
>      void *fdt;
>      int cpu;
> +    RISCVCPU *hart;
>      uint32_t *cells, cells_length;
>      char *nodename;
>      uint32_t plic_phandle, prci_phandle, gpio_phandle, phandle = 1;
> @@ -195,18 +196,18 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
>      g_free(nodename);
>  
>      plic_phandle = phandle++;
> -    cells_length = ms->smp.cpus * 4 - 2;
> -    cells =  g_new0(uint32_t, cells_length);
> +    cells = g_new0(uint32_t, ms->smp.cpus * 4 - 2);
> +    cells_length = 0;
>      for (cpu = 0; cpu < ms->smp.cpus; cpu++) {
>          /* cpu 0 is the management hart that does not have S-mode */
> -        if (cpu == 0) {
> -            cells[0] = cpu_to_be32(intc_phandles[cpu]);
> -            cells[1] = cpu_to_be32(IRQ_M_EXT);
> -        } else {
> -            cells[cpu * 4 - 2] = cpu_to_be32(intc_phandles[cpu]);
> -            cells[cpu * 4 - 1] = cpu_to_be32(IRQ_M_EXT);
> -            cells[cpu * 4 + 0] = cpu_to_be32(intc_phandles[cpu]);
> -            cells[cpu * 4 + 1] = cpu_to_be32(IRQ_S_EXT);
> +        hart = cpu ? &s->soc.u_cpus.harts[cpu - 1] : &s->soc.e_cpus.harts[0];
> +
> +        cells[cells_length++] = cpu_to_be32(intc_phandles[cpu]);
> +        cells[cells_length++] = cpu_to_be32(IRQ_M_EXT);
> +
> +        if (riscv_cpu_has_supervisor_mode(hart)) {
> +            cells[cells_length++] = cpu_to_be32(intc_phandles[cpu]);
> +            cells[cells_length++] = cpu_to_be32(IRQ_S_EXT);
>          }
>      }
>  
> -- 
> 2.54.0
> 

