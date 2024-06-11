Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F05FDC25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 08:26:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGwpQ-0006fJ-Fp; Tue, 11 Jun 2024 04:26:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGwpN-0006ep-O9
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 04:26:01 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGwpL-0003gk-FK
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 04:26:01 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a63359aaacaso95906666b.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 01:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718094357; x=1718699157; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mbr1KGv7aunhZdLbhu6YUP2eNZU9pDTFqnsGHLOd9iE=;
 b=r5+qcsyE9fhJgvMZ+dGfoTRWaw3rMPgUCeWssusvXcnDw1boLuCjIWWgvf/MiyshxB
 Ea1n0fs+0x99sU6SVNKN600Bfp+YY/pEfbfv/iAw23IkQsddfhkALrwAlEpb6AdoUQ/R
 qEwySOblk/Pyhxqc2ce1uW8nDrIIqSr5uW13rUJxZB5+hgpqejNnr+HVIdw0TgH+vTsf
 C6yugmp+5zXIiKRzypUSMgjkVTdF2R99cwmXCgpOFtSbjlJEi/m9ObBpcjXu86XOxeJl
 dTpCPQbEKgCiOe8BPAaxK+KhahwI/BUNZ1WR1/Gm5ske/SAwsYQTLMfZESqBh93bhxGu
 2OwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718094357; x=1718699157;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mbr1KGv7aunhZdLbhu6YUP2eNZU9pDTFqnsGHLOd9iE=;
 b=Po24Fa35EMfCybQTlLe2vmQuVSgODPJIcunn+9S4GYExcqBDlyo5KPxOX0KvrPUqNB
 Di4TvIYpyQlE/jtbVSA2xgftanHWRyHgvB/RIA0VrZBSk0PuPQNMF71vrktRvvm99ofb
 z4U6e1RbD+1YeXb+v8qgapW9Vg8P6TDrZTJAsWVY7JXN3rU5pudclDk1xF0ndVuuKR7u
 an/3mQ/M5AssmLcOwQGlWSTiwNUjfyuSo9rWYS4yrUoaIR+wGqK1vZQ4tSmHYNyVsx9v
 601CQhKrr5yVYZtyv0eH5rhBrBLT3wsXlPxaQlaRGI5lRU4g8bWcQDeLbpAg5QN3Ds3K
 R/Zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBxOS7UQTSpXK/9pOEn8b0x1WmTWChiFtXlzmEg7oaNh7d4RwRtF6OyVD5YAWiJSNfe2zXX47Ua3Z3KhL3NsUc7/+cluc=
X-Gm-Message-State: AOJu0YyKdthua1KwF6D6pz3DAIsZ9kKmL/xoY/uF/e/1c0qZq8FsgZ1D
 nEUcVH9LI7DAhkVKwXs0pXS2Q8eHTjSzGRgHQ1aFPJKd2sph11NcA8UcEgGIqHs=
X-Google-Smtp-Source: AGHT+IEXTEHHfMU/yBcoStxR+NwyzMhgITy3BnerV7dnu8RH94vScgHIUvS1WxAI8DrvvTI1upOg9w==
X-Received: by 2002:a17:907:94c1:b0:a6f:18ed:254f with SMTP id
 a640c23a62f3a-a6f18ed25f6mr432419766b.58.1718094357200; 
 Tue, 11 Jun 2024 01:25:57 -0700 (PDT)
Received: from [192.168.69.100] (rsa59-h02-176-184-32-6.dsl.sta.abo.bbox.fr.
 [176.184.32.6]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c9717b6e3sm635460066b.13.2024.06.11.01.25.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Jun 2024 01:25:56 -0700 (PDT)
Message-ID: <5b10d49a-8da2-491f-8b8c-26556482957d@linaro.org>
Date: Tue, 11 Jun 2024 10:25:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] accel/tcg: Make TCGCPUOps::cpu_exec_halt mandatory
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20240603160933.1141717-1-peter.maydell@linaro.org>
 <20240603160933.1141717-4-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240603160933.1141717-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Peter,

On 3/6/24 18:09, Peter Maydell wrote:
> Now that all targets set TCGCPUOps::cpu_exec_halt, we can make it
> mandatory and remove the fallback handling that calls cpu_has_work.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/core/tcg-cpu-ops.h | 9 ++++++---
>   accel/tcg/cpu-exec.c          | 7 +------
>   2 files changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/include/hw/core/tcg-cpu-ops.h b/include/hw/core/tcg-cpu-ops.h
> index 099de3375e3..34318cf0e60 100644
> --- a/include/hw/core/tcg-cpu-ops.h
> +++ b/include/hw/core/tcg-cpu-ops.h
> @@ -122,10 +122,13 @@ struct TCGCPUOps {
>        * to do when the CPU is in the halted state.
>        *
>        * Return true to indicate that the CPU should now leave halt, false
> -     * if it should remain in the halted state.
> +     * if it should remain in the halted state. (This should generally
> +     * be the same value that cpu_has_work() would return.)
>        *
> -     * If this method is not provided, the default is to do nothing, and
> -     * to leave halt if cpu_has_work() returns true.
> +     * This method must be provided. If the target does not need to
> +     * do anything special for halt, the same function used for its
> +     * CPUClass::has_work method can be used here, as they have the
> +     * same function signature.
>        */
>       bool (*cpu_exec_halt)(CPUState *cpu);
>       /**
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 6711b58e0b2..8be4d2a1330 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -682,13 +682,8 @@ static inline bool cpu_handle_halt(CPUState *cpu)
>   #ifndef CONFIG_USER_ONLY
>       if (cpu->halted) {
>           const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
> -        bool leave_halt;
> +        bool leave_halt = tcg_ops->cpu_exec_halt(cpu);
>   
> -        if (tcg_ops->cpu_exec_halt) {
> -            leave_halt = tcg_ops->cpu_exec_halt(cpu);
> -        } else {
> -            leave_halt = cpu_has_work(cpu);
> -        }
>           if (!leave_halt) {
>               return true;
>           }

Could we assert the handler is assigned in tcg_exec_realizefn()?

If you agree I could squash these 3 lines:

-- >8 --
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -1077,6 +1077,10 @@ bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
      static bool tcg_target_initialized;

      if (!tcg_target_initialized) {
+        /* Check mandatory TCGCPUOps handlers */
+        assert(cpu->cc->tcg_ops->initialize);
+        assert(cpu->cc->tcg_ops->cpu_exec_halt);
+
          cpu->cc->tcg_ops->initialize();
          tcg_target_initialized = true;
      }
---

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


