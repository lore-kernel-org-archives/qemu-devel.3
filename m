Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB52CFC518
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 03:21:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMcqz-0005Z7-9q; Fri, 21 Nov 2025 20:55:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vMbcW-0003kv-IX; Fri, 21 Nov 2025 19:36:56 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vMbcK-0005Dq-Sy; Fri, 21 Nov 2025 19:36:52 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5ALAewEQ076011
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 21 Nov 2025 19:40:59 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=lNp5divqF01PzSSdYyTYotITUvUSEKBSIbpmecHY0wY=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1763721659; v=1;
 b=Q7LtqkiZwzkIflPjzsgPou9z+aE8ifUvpSsk2lSaLTHBZIbGSNDnDvC/LDiCxzpC
 9LzTmb2Vsv7npJcGCubT76QyzLmL3k0IT0PQ5n/MkR+KAgXeXb3xPbwkFFbDVUHG
 7YTUYGMzEoDArjytR45R8hC0puz4FPhDirtxzAQIUyXm+Bm8KVOH+2lovqQTP/5A
 isE92gJm8co4FCUq2Oh6O2AS63pNpI1B3pDRVRGjyTXHZuOA3c/NxL08qCMS4ar3
 5okswiRpPYPPCRNRioaAhubAZfbmxWl5MzBxO3wYmuk+4JV80z5G5c3/c11uCjJl
 vQm1nA5rvWuxe6nd53jfXg==
Message-ID: <013084e1-0f6d-462d-b4f5-e5a38e4d8f3b@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 21 Nov 2025 19:40:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 08/28] whpx: ifdef out winhvemulation on non-x86_64
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Xu <peterx@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20251121100240.89117-1-mohamed@unpredictable.fr>
 <20251121100240.89117-9-mohamed@unpredictable.fr>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20251121100240.89117-9-mohamed@unpredictable.fr>
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
> winhvemulation is x86_64 only.
> 
> In the future, we might want to get rid of winhvemulation usage
> entirely.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   accel/whpx/whpx-common.c       | 14 ++++++++++++--
>   include/system/whpx-common.h   |  2 ++
>   include/system/whpx-internal.h |  7 ++++++-
>   3 files changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
> index 66c9238586..95664a1df7 100644
> --- a/accel/whpx/whpx-common.c
> +++ b/accel/whpx/whpx-common.c
> @@ -41,7 +41,9 @@
>   bool whpx_allowed;
>   static bool whp_dispatch_initialized;
>   static HMODULE hWinHvPlatform;
> +#ifdef __x86_64__

Please use: HOST_X86_64

Rationale: scripts/checkpatch.pl has the following code:

# check of hardware specific defines
# we have e.g. CONFIG_LINUX and CONFIG_WIN32 for common cases
# where they might be necessary.
		if ($line =~ m@^.\s*\#\s*if.*\b__@) {
			WARN("architecture specific defines should be avoided\n" .  $herecurr);
		}

>   static HMODULE hWinHvEmulation;
> +#endif
>   
>   struct whpx_state whpx_global;
>   struct WHPDispatch whp_dispatch;
> @@ -236,8 +238,10 @@ void whpx_destroy_vcpu(CPUState *cpu)
>       struct whpx_state *whpx = &whpx_global;
>   
>       whp_dispatch.WHvDeleteVirtualProcessor(whpx->partition, cpu->cpu_index);
> +#ifdef __x86_64__
>       AccelCPUState *vcpu = cpu->accel;
>       whp_dispatch.WHvEmulatorDestroyEmulator(vcpu->emulator);
> +#endif
>       g_free(cpu->accel);
>   }
>   
> @@ -412,8 +416,12 @@ static bool load_whp_dispatch_fns(HMODULE *handle,
>           LIST_WINHVPLATFORM_FUNCTIONS(WHP_LOAD_FIELD)
>           break;
>       case WINHV_EMULATION_FNS_DEFAULT:
> +#ifdef __x86_64__
>           WHP_LOAD_LIB(WINHV_EMULATION_DLL, hLib)
>           LIST_WINHVEMULATION_FUNCTIONS(WHP_LOAD_FIELD)
> +#else
> +        g_assert_not_reached();
> +#endif
>           break;
>       case WINHV_PLATFORM_FNS_SUPPLEMENTAL:
>           WHP_LOAD_LIB(WINHV_PLATFORM_DLL, hLib)
> @@ -539,11 +547,11 @@ bool init_whp_dispatch(void)
>       if (!load_whp_dispatch_fns(&hWinHvPlatform, WINHV_PLATFORM_FNS_DEFAULT)) {
>           goto error;
>       }
> -
> +#ifdef __x86_64__
>       if (!load_whp_dispatch_fns(&hWinHvEmulation, WINHV_EMULATION_FNS_DEFAULT)) {
>           goto error;
>       }
> -
> +#endif
>       assert(load_whp_dispatch_fns(&hWinHvPlatform,
>           WINHV_PLATFORM_FNS_SUPPLEMENTAL));
>       whp_dispatch_initialized = true;
> @@ -553,9 +561,11 @@ error:
>       if (hWinHvPlatform) {
>           FreeLibrary(hWinHvPlatform);
>       }
> +#ifdef __x86_64__
>       if (hWinHvEmulation) {
>           FreeLibrary(hWinHvEmulation);
>       }
> +#endif
>       return false;
>   }
>   
> diff --git a/include/system/whpx-common.h b/include/system/whpx-common.h
> index e549c7539c..7a7c607e0a 100644
> --- a/include/system/whpx-common.h
> +++ b/include/system/whpx-common.h
> @@ -3,7 +3,9 @@
>   #define SYSTEM_WHPX_COMMON_H
>   
>   struct AccelCPUState {
> +#ifdef __x86_64__
>       WHV_EMULATOR_HANDLE emulator;
> +#endif
>       bool window_registered;
>       bool interruptable;
>       bool ready_for_pic_interrupt;
> diff --git a/include/system/whpx-internal.h b/include/system/whpx-internal.h
> index c59f9de091..4565436682 100644
> --- a/include/system/whpx-internal.h
> +++ b/include/system/whpx-internal.h
> @@ -4,8 +4,9 @@
>   
>   #include <windows.h>
>   #include <winhvplatform.h>
> +#ifdef __x86_64__
>   #include <winhvemulation.h>
> -
> +#endif
>   #include "hw/i386/apic.h"
>   
>   typedef enum WhpxBreakpointState {
> @@ -100,12 +101,16 @@ void whpx_apic_get(APICCommonState *s);
>   
>   /* Define function typedef */
>   LIST_WINHVPLATFORM_FUNCTIONS(WHP_DEFINE_TYPE)
> +#ifdef __x86_64__
>   LIST_WINHVEMULATION_FUNCTIONS(WHP_DEFINE_TYPE)
> +#endif
>   LIST_WINHVPLATFORM_FUNCTIONS_SUPPLEMENTAL(WHP_DEFINE_TYPE)
>   
>   struct WHPDispatch {
>       LIST_WINHVPLATFORM_FUNCTIONS(WHP_DECLARE_MEMBER)
> +#ifdef __x86_64__
>       LIST_WINHVEMULATION_FUNCTIONS(WHP_DECLARE_MEMBER)
> +#endif
>       LIST_WINHVPLATFORM_FUNCTIONS_SUPPLEMENTAL(WHP_DECLARE_MEMBER)
>   };
>   


