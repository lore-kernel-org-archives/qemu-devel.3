Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34479CD11DD
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 16:03:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmbuZ-0004Uw-3V; Tue, 19 Mar 2024 12:01:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rmbuK-00049u-Vu
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 12:01:47 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rmbuE-0000OL-9D
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 12:01:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=p77Q65+5OkY8UkCQDN13ilJmVC0j2BZ2/0nTLk/N8QA=; b=bpDUlF++MDdXZ2LYC3foHUN19j
 BFbVPqRcJoaciFZTvWm6F0YLF/KsRGbIhvNk1a97ecgxWhKiGEFSRA7uOFAmTc2TteKo1qkEtqM0p
 ApeM6iQUs4P7/YQlk6zXDnDMziODxrmc40hvaMLHADQLNZneGyXSxPMxQ42R3nAOb0B8=;
Date: Tue, 19 Mar 2024 17:02:26 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Laurent Vivier <laurent@vivier.eu>, Alistair Francis <alistair@alistair23.me>
Subject: Re: [PATCH-for-9.1 6/8] target/microblaze: Rename helper.c ->
 sys_helper.c
Message-ID: <gmvj55xm6bafiooxbsef3257rutvsi6om632xf5l7ax7u6lewd@zixw6murfoml>
References: <20240319062855.8025-1-philmd@linaro.org>
 <20240319062855.8025-7-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240319062855.8025-7-philmd@linaro.org>
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 19/03/24, Philippe Mathieu-Daudé wrote:
> helper.c only contains system emulation helpers,
> rename it as sys_helper.c.
> Adapt meson and remove pointless #ifdef'ry.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/microblaze/{helper.c => sys_helper.c} | 5 +----
>  target/microblaze/meson.build                | 2 +-
>  2 files changed, 2 insertions(+), 5 deletions(-)
>  rename target/microblaze/{helper.c => sys_helper.c} (99%)
> 
> diff --git a/target/microblaze/helper.c b/target/microblaze/sys_helper.c
> similarity index 99%
> rename from target/microblaze/helper.c
> rename to target/microblaze/sys_helper.c
> index 3f410fc7b5..5180500354 100644
> --- a/target/microblaze/helper.c
> +++ b/target/microblaze/sys_helper.c
> @@ -1,5 +1,5 @@
>  /*
> - *  MicroBlaze helper routines.
> + *  MicroBlaze system helper routines.
>   *
>   *  Copyright (c) 2009 Edgar E. Iglesias <edgar.iglesias@gmail.com>
>   *  Copyright (c) 2009-2012 PetaLogix Qld Pty Ltd.
> @@ -24,7 +24,6 @@
>  #include "qemu/host-utils.h"
>  #include "exec/log.h"
>  
> -#ifndef CONFIG_USER_ONLY
>  static bool mb_cpu_access_is_secure(MicroBlazeCPU *cpu,
>                                      MMUAccessType access_type)
>  {
> @@ -266,8 +265,6 @@ bool mb_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>      return false;
>  }
>  
> -#endif /* !CONFIG_USER_ONLY */
> -
>  void mb_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
>                                  MMUAccessType access_type,
>                                  int mmu_idx, uintptr_t retaddr)
> diff --git a/target/microblaze/meson.build b/target/microblaze/meson.build
> index 3ed4fbb67a..013ea542be 100644
> --- a/target/microblaze/meson.build
> +++ b/target/microblaze/meson.build
> @@ -5,7 +5,6 @@ microblaze_ss.add(gen)
>  microblaze_ss.add(files(
>    'cpu.c',
>    'gdbstub.c',
> -  'helper.c',
>    'op_helper.c',
>    'translate.c',
>  ))
> @@ -14,6 +13,7 @@ microblaze_system_ss = ss.source_set()
>  microblaze_system_ss.add(files(
>    'mmu.c',
>    'machine.c',
> +  'sys_helper.c',
>  ))
>  
>  target_arch += {'microblaze': microblaze_ss}
> -- 
> 2.41.0
> 
Reviewed-by: Anton Johansson <anjo@rev.ng>

