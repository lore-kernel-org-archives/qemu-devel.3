Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81746CFC518
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 03:07:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMd68-00045F-NC; Fri, 21 Nov 2025 21:11:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vMccs-0004u6-FH; Fri, 21 Nov 2025 20:41:22 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vMcao-00034B-CX; Fri, 21 Nov 2025 20:41:18 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5ALAnhLa078745
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 21 Nov 2025 19:49:44 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=Nctt2G5VdGAd0f97i5IQdXGCf3/Ph3bC8lF+lgjLw50=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1763722184; v=1;
 b=jksot3XuhnFKOX4NBpb9WtrjLgbGKthOlZoxlErqPILtc/Ghh1YHJF7PCFLnDSA1
 2gTdS135uBzu3V3ajJxPGbOssJlKvaLiZm7U9HytP/TMKOc9zQbuvUblCWxzHK6h
 oYGoICc1YwPjrshUJjPRaAbVn5UujNXXs1iBuvif8yhUz85W3yhoz7fYW41S8SCP
 4sbMvV8lLWGSO7EGGynKJFrI6j4kZKfBfSevycD+rvzg2LD2NXntUopGB5CJmSbL
 WRYJOJnuPIN7rz8mgX/0X9MceuuNy65nY3XvnXSp1k0xB7MoGAyQ4u735OkIxskN
 zeCtYJYTbabj8JIe5B9qoQ==
Message-ID: <073d66a9-1507-4ff2-95c4-0a2d362a0feb@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 21 Nov 2025 19:49:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 11/28] whpx: switch irqchip in kernel to a bool
 outside the struct
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Xu <peterx@redhat.com>, Mads Ynddal <mads@ynddal.dk>
References: <20251121100240.89117-1-mohamed@unpredictable.fr>
 <20251121100240.89117-12-mohamed@unpredictable.fr>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20251121100240.89117-12-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
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

On 2025/11/21 19:02, Mohamed Mediouni wrote:
> Fix buildability on newer Qemu.

Can you give some more explanation?

> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   accel/stubs/whpx-stub.c        |  1 +
>   accel/whpx/whpx-common.c       | 10 +---------
>   include/system/whpx-internal.h |  1 -
>   include/system/whpx.h          |  3 ++-
>   4 files changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/accel/stubs/whpx-stub.c b/accel/stubs/whpx-stub.c
> index c564c89fd0..4529dc4f78 100644
> --- a/accel/stubs/whpx-stub.c
> +++ b/accel/stubs/whpx-stub.c
> @@ -10,3 +10,4 @@
>   #include "system/whpx.h"
>   
>   bool whpx_allowed;
> +bool whpx_irqchip_in_kernel;
> diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
> index 18d93225c1..4dabe3a032 100644
> --- a/accel/whpx/whpx-common.c
> +++ b/accel/whpx/whpx-common.c
> @@ -39,6 +39,7 @@
>   #include <winhvplatformdefs.h>
>   
>   bool whpx_allowed;
> +bool whpx_irqchip_in_kernel;
>   static bool whp_dispatch_initialized;
>   static HMODULE hWinHvPlatform;
>   #ifdef __x86_64__
> @@ -492,15 +493,6 @@ static const TypeInfo whpx_cpu_accel_type = {
>       .abstract = true,
>   };
>   
> -/*
> - * Partition support
> - */
> -
> -bool whpx_irqchip_in_kernel(void)
> -{
> -    return whpx_global.kernel_irqchip;
> -}
> -
>   static void whpx_accel_class_init(ObjectClass *oc, const void *data)
>   {
>       AccelClass *ac = ACCEL_CLASS(oc);
> diff --git a/include/system/whpx-internal.h b/include/system/whpx-internal.h
> index 81c0c1819f..b1706a2749 100644
> --- a/include/system/whpx-internal.h
> +++ b/include/system/whpx-internal.h
> @@ -44,7 +44,6 @@ struct whpx_state {
>   
>       bool kernel_irqchip_allowed;
>       bool kernel_irqchip_required;
> -    bool kernel_irqchip;
>   };
>   
>   extern struct whpx_state whpx_global;
> diff --git a/include/system/whpx.h b/include/system/whpx.h
> index 98fe045ba1..4217a27e91 100644
> --- a/include/system/whpx.h
> +++ b/include/system/whpx.h
> @@ -25,8 +25,9 @@
>   
>   #ifdef CONFIG_WHPX_IS_POSSIBLE
>   extern bool whpx_allowed;
> +extern bool whpx_irqchip_in_kernel;
>   #define whpx_enabled() (whpx_allowed)
> -bool whpx_irqchip_in_kernel(void);
> +#define whpx_irqchip_in_kernel() (whpx_irqchip_in_kernel)
>   #else /* !CONFIG_WHPX_IS_POSSIBLE */
>   #define whpx_enabled() 0
>   #define whpx_irqchip_in_kernel() (0)


