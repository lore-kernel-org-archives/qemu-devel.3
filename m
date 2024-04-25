Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E60C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 07:46:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rztng-0007Bo-Gh; Thu, 25 Apr 2024 03:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1rztne-0007Ba-4n; Thu, 25 Apr 2024 03:45:46 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1rztnb-00054L-WE; Thu, 25 Apr 2024 03:45:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=Rq8d06m6s42X4h2ib9fAy+KULI9FU3Q5txL6pm2U1n4=; b=M4ke973ggf9J5/p
 +c1KL9nqZalPyKaANSq98z/Ddboyx0H4d4oS8lRFlfxUbpdDwFCt6lbKOMc7JOL/9zO5stwugHk1I
 JICNOKtRbhI5I4gloqfcVKOwMDrs1TH4cQCZz31V2BwdM/Ot498SWSToTAe2IxShO+uYK/GYUDBNx
 NU=;
Date: Thu, 25 Apr 2024 09:46:53 +0200
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, 
 David Hildenbrand <david@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH 20/24] hw/xtensa: Include missing 'exec/cpu-common.h' in
 'bootparam.h'
Message-ID: <hp5oea7xa673uxb7jqf3m357bjvheehbjxn5ktxqooa3cowvq4@q3hx27in2tyj>
References: <20240418192525.97451-1-philmd@linaro.org>
 <20240418192525.97451-21-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240418192525.97451-21-philmd@linaro.org>
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 18/04/24, Philippe Mathieu-Daudé wrote:
> cpu_physical_memory_write() is declared in "exec/cpu-common.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/xtensa/bootparam.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/xtensa/bootparam.h b/hw/xtensa/bootparam.h
> index ade7891ec5..f57ff850bc 100644
> --- a/hw/xtensa/bootparam.h
> +++ b/hw/xtensa/bootparam.h
> @@ -1,6 +1,8 @@
>  #ifndef HW_XTENSA_BOOTPARAM_H
>  #define HW_XTENSA_BOOTPARAM_H
>  
> +#include "exec/cpu-common.h"
> +
>  #define BP_TAG_COMMAND_LINE     0x1001  /* command line (0-terminated string)*/
>  #define BP_TAG_INITRD           0x1002  /* ramdisk addr and size (bp_meminfo) */
>  #define BP_TAG_MEMORY           0x1003  /* memory addr and size (bp_meminfo) */
> -- 
> 2.41.0
> 

Reviewed-by: Anton Johansson <anjo@rev.ng>

