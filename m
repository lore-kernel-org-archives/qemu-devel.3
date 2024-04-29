Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88DD7C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 14:03:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Rb7-0002MP-A7; Mon, 29 Apr 2024 10:03:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1Rb5-0002Le-6K
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 10:03:11 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1Rb2-0005ck-6P
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 10:03:09 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-343e46ec237so3830066f8f.2
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 07:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714399386; x=1715004186; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wCvAEsMUaxCFhShE8mmsXDjUjwQCylE7/FYCoO6ZSm8=;
 b=yBadmjvEPFuZmiF7DVkhsxSZXEgKgDxICL6BeXTBrFjobajNudWIY3PymMMQHVuEqt
 1vmCmMYVuKH+Ec5I0OG2Dckbn97lZN6hzIwd0eYIv//CaEj53HC7g0JNhDcej8ub4BKo
 xNNiYtDeu1SJDqoqAu2O1lr1ywvoQuhRCii/+at9krbhGGdOg80nqAdoWfWSaTwLMkTo
 qC/LWJGDL739yo4W94OmlJPnO6xkljb259sSS2b9JcJJpJmfsU/12oAQ/KgWWbnsGVno
 N6sQOTu/E0KYSkhdwxHR9AA/IKGCDIlCxsa2MqdqPkpw9gZyX1kzHnuN5EW1hInySRly
 dQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714399386; x=1715004186;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wCvAEsMUaxCFhShE8mmsXDjUjwQCylE7/FYCoO6ZSm8=;
 b=wC48SLsHuL8teRWRbGWC7lDls0aAvnDD9zAQmrXs1jdXalRlMNJXv1qpSY7xXn8uHm
 MTxHGnvcQsXrPOopK55AaXyEVlZ72+lchQnCRL/i9Ynhw6jqKxfhVx8j0j17KAvZVfMu
 dPqeInXVchkJXKNW3VX0q+lEdXiEqmvDIoNhIMRIhUVC2oUIxCGQQ2rTiIgnpG/fVsIF
 8Ad9jHK0M2jx7rQfJ0fhc2UYW3xLHwc2Gkbu7RhVuBDJK5A97v6PFx8V+C9l6ngrY0cN
 8OSwvVTy5zNtjRV9/Gf6493FqxlVx/gj0aqiW+hntyrqjNcITY5QIQMLLwENFJbxIghA
 Lmow==
X-Gm-Message-State: AOJu0Yx4rXSf6E+mlgb+oS/vjM4lfTY68hs5uchuNFJfyVwDQHW6sLTr
 P838VSpisMpSaOPPIKvwFsZgdPP2QDwF2kqyswlOOUl3OdIhW9461dNshmzwlfm5Z4IsdrYfAVc
 3J6I=
X-Google-Smtp-Source: AGHT+IFR+Ejmbv4y5Glwd+xFx9BIZprN8O8RFNyC3UTJ/3DW1reT4IEeSCrPSp+VBZbcORw1Q6mRKg==
X-Received: by 2002:adf:f212:0:b0:34c:a509:6138 with SMTP id
 p18-20020adff212000000b0034ca5096138mr4717465wro.49.1714399385820; 
 Mon, 29 Apr 2024 07:03:05 -0700 (PDT)
Received: from [192.168.69.100] (bny92-h02-176-184-44-142.dsl.sta.abo.bbox.fr.
 [176.184.44.142]) by smtp.gmail.com with ESMTPSA id
 l15-20020a5d480f000000b0034d5d00979csm245005wrq.59.2024.04.29.07.03.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 07:03:05 -0700 (PDT)
Message-ID: <5f59c754-44e5-4743-a2dd-87ef8e13eadf@linaro.org>
Date: Mon, 29 Apr 2024 16:03:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/24] accel/tcg: Restrict IcountDecr and CPUTLB to TCG
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240428221450.26460-1-philmd@linaro.org>
 <20240428221450.26460-16-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240428221450.26460-16-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 29/4/24 00:14, Philippe Mathieu-Daudé wrote:
> IcountDecr union, the CPUTLB* structures and the
> "exec/tlb-common.h" header are only required for
> TCG.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/exec/tlb-common.h | 4 ++++
>   include/hw/core/cpu.h     | 9 ++++++---
>   2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/include/exec/tlb-common.h b/include/exec/tlb-common.h
> index dc5a5faa0b..a529c9f056 100644
> --- a/include/exec/tlb-common.h
> +++ b/include/exec/tlb-common.h
> @@ -19,6 +19,10 @@
>   #ifndef EXEC_TLB_COMMON_H
>   #define EXEC_TLB_COMMON_H 1
>   
> +#ifndef CONFIG_TCG
> +#error Can only include this header with TCG
> +#endif
> +
>   #define CPU_TLB_ENTRY_BITS 5
>   
>   /* Minimalized TLB entry for use by TCG fast path. */
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index ef8b85b6fe..dc28920bcc 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -27,7 +27,6 @@
>   #include "exec/vaddr.h"
>   #include "exec/memattrs.h"
>   #include "exec/mmu-access-type.h"
> -#include "exec/tlb-common.h"
>   #include "qapi/qapi-types-run-state.h"
>   #include "qemu/bitmap.h"
>   #include "qemu/rcu_queue.h"
> @@ -256,6 +255,9 @@ typedef struct CPUTLBEntryFull {
>       } extra;
>   } CPUTLBEntryFull;
>   
> +#ifdef CONFIG_TCG
> +#include "exec/tlb-common.h"
> +
>   /*
>    * Data elements that are per MMU mode, minus the bits accessed by
>    * the TCG fast path.
> @@ -311,11 +313,9 @@ typedef struct CPUTLBCommon {
>    * negative offsets are at the end of the struct.
>    */
>   typedef struct CPUTLB {
> -#ifdef CONFIG_TCG
>       CPUTLBCommon c;
>       CPUTLBDesc d[NB_MMU_MODES];
>       CPUTLBDescFast f[NB_MMU_MODES];
> -#endif
>   } CPUTLB;
>   
>   /*
> @@ -337,6 +337,7 @@ typedef union IcountDecr {
>   #endif
>       } u16;
>   } IcountDecr;
> +#endif
>   
>   /**
>    * CPUNegativeOffsetState: Elements of CPUState most efficiently accessed
> @@ -346,6 +347,7 @@ typedef union IcountDecr {
>    * @plugin_state: per-CPU plugin state
>    */
>   typedef struct CPUNegativeOffsetState {
> +#ifdef CONFIG_TCG
>       CPUTLB tlb;
>   #ifdef CONFIG_PLUGIN
>       /*
> @@ -356,6 +358,7 @@ typedef struct CPUNegativeOffsetState {
>   #endif
>       IcountDecr icount_decr;
>       bool can_do_io;
> +#endif
>   } CPUNegativeOffsetState;

We also need:

-- >8 --
@@ -1110,6 +1110,7 @@

+#ifdef CONFIG_TCG
  /**
   * cpu_plugin_mem_cbs_enabled() - are plugin memory callbacks enabled?
   * @cs: CPUState pointer
@@ -1126,6 +1127,7 @@ static inline bool 
cpu_plugin_mem_cbs_enabled(const CPUState *cpu)
      return false;
  #endif
  }
+#endif

---

Otherwise this inlined function fails to build when TCG is disabled...

But since it is only used from accel/tcg/, I'll move it to
accel/tcg/internal-common.h in a preliminary patch instead:

-- >8 --
Author: Philippe Mathieu-Daudé <philmd@linaro.org>
Date:   Mon Apr 29 16:01:18 2024 +0200

     accel/tcg: Restrict cpu_plugin_mem_cbs_enabled() to TCG

     So far cpu_plugin_mem_cbs_enabled() is only called from
     TCG, so reduce it to accel/tcg/.

     Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
index df317e7496..867426500f 100644
--- a/accel/tcg/internal-common.h
+++ b/accel/tcg/internal-common.h
@@ -26,0 +27,17 @@ static inline bool cpu_in_serial_context(CPUState *cs)
+/**
+ * cpu_plugin_mem_cbs_enabled() - are plugin memory callbacks enabled?
+ * @cs: CPUState pointer
+ *
+ * The memory callbacks are installed if a plugin has instrumented an
+ * instruction for memory. This can be useful to know if you want to
+ * force a slow path for a series of memory accesses.
+ */
+static inline bool cpu_plugin_mem_cbs_enabled(const CPUState *cpu)
+{
+#ifdef CONFIG_PLUGIN
+    return !!cpu->neg.plugin_mem_cbs;
+#else
+    return false;
+#endif
+}
+
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index ef8b85b6fe..24ad52af7d 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1110,17 +1109,0 @@ void cpu_watchpoint_remove_all(CPUState *cpu, int 
mask);
-/**
- * cpu_plugin_mem_cbs_enabled() - are plugin memory callbacks enabled?
- * @cs: CPUState pointer
- *
- * The memory callbacks are installed if a plugin has instrumented an
- * instruction for memory. This can be useful to know if you want to
- * force a slow path for a series of memory accesses.
- */
-static inline bool cpu_plugin_mem_cbs_enabled(const CPUState *cpu)
-{
-#ifdef CONFIG_PLUGIN
-    return !!cpu->neg.plugin_mem_cbs;
-#else
-    return false;
-#endif
-}
-
---


