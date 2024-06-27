Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF46DC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 19:11:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMuW7-0000nD-7n; Thu, 27 Jun 2024 15:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMuW6-0000n4-4l
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 15:10:46 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMuW4-0002o6-Bz
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 15:10:45 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7066c799382so5553530b3a.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 12:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719515443; x=1720120243; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xM8nG+05CocUsnyh9fTD6U9Q0WFu0rxPUPxppyzyHtI=;
 b=ZdGawpJ1mR1bziWqfp+VXPMKVuz2AkCWfja1zWKKro9t4sRnHjOegZZUyff/Zz3uEF
 AJbcbuiCkBHgcb/ht9OYtF6N8NWMCfSUJu7gqXRc7oBoDGFU6b6cOp8j9v/LNX4jJGpr
 p3hUitE/573ltGBeKm+Wa3JqXRqDuBwrDSBqN6bD4t2eLLYNy1iAb1raZV3Elx+AROAp
 U9EOUgBIJtQ+BxqJNp8EWVC3JAerg4r4IjVOCjVkFV7G+u3e++DMjqzgUSBvd0UNHK6l
 3ZrRqWYcWHnAVsX6vmuikOUQFEe+8CF9gLz4Blf/pAX077S2yhy5m8ga6WpjiXDfhYB0
 AzPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719515443; x=1720120243;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xM8nG+05CocUsnyh9fTD6U9Q0WFu0rxPUPxppyzyHtI=;
 b=DFzT2E5EKVmmxIy6rkXoqufRGYu+13ojBc0RaTq+8zyaOasMU6Z2QyC0k6pW0wkfJ5
 ZGw0sG0mJF4UQxRcJe4tDaVKCFJZVGGg8acaH1tc6J+6i3hdBMI1qUWH5EFrgO51aUog
 CDFD3ophhfv0Npu2a0EfI1lUhIggq4W/rMEnASVZ6yKviIN9DdhlRyBq9LGf9CkXYxHr
 M4jMNPM4hUd3csjFIRwFu41utJEba98wzcYXygWIluiknlk/YzW3Pa59HOvQnqr1pZsm
 s5Jze5b8whJTgpSP7OWzSG5WDh4J5tzzvqHPA7PCUNCRcuDkXQy5J6Iebr7qI+QQDEcK
 SvpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmsudw2LwRiYXFS5J6d0pvbmKveU1k9lEhs21ELXzc9d5fIMAck+n1xvUP6tQp7J2Ff+jNYqjM/QxmXaXNk1ZpRjGlUrI=
X-Gm-Message-State: AOJu0YzEqfHFU2xHufQWlYN2HTgdln320MEb1sHDVWtzm42ymVKivWA0
 d82Jj8JW875VSMSnV+mgTo9sdwwtBhj3/JQ7jmsam48f1L2eYiHVqgfMeeKsKwU=
X-Google-Smtp-Source: AGHT+IHYAXe2EbTqFz3E7tkTyCu7vB2xMTSnR1UuxP/VGXxWA4+QrytySd/ID+8GLa22EY0ZenBufA==
X-Received: by 2002:a05:6a21:3289:b0:1be:cea5:c781 with SMTP id
 adf61e73a8af0-1becea5cfb2mr3543953637.16.1719515442581; 
 Thu, 27 Jun 2024 12:10:42 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70803fc8b67sm64007b3a.128.2024.06.27.12.10.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 12:10:42 -0700 (PDT)
Message-ID: <1fecfba7-6a42-405c-a32a-e82164539650@linaro.org>
Date: Thu, 27 Jun 2024 12:10:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] plugins: save value during memory accesses
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20240626233757.375083-1-pierrick.bouvier@linaro.org>
 <20240626233757.375083-3-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240626233757.375083-3-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

On 6/26/24 16:37, Pierrick Bouvier wrote:
> Different code paths handle memory accesses:
> - tcg generated code
> - load/store helpers
> - atomic helpers
> 
> This value is saved in cpu->plugin_state.
> 
> Atomic operations are doing read/write at the same time, so we generate
> two memory callbacks instead of one, to allow plugins to access distinct
> values.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   accel/tcg/atomic_template.h   | 66 ++++++++++++++++++++++++++++----
>   include/qemu/plugin.h         |  8 ++++
>   plugins/core.c                |  7 ++++
>   tcg/tcg-op-ldst.c             | 72 +++++++++++++++++++++++++++++++----
>   accel/tcg/atomic_common.c.inc | 13 ++++++-
>   accel/tcg/ldst_common.c.inc   | 38 +++++++++++-------
>   6 files changed, 173 insertions(+), 31 deletions(-)
> 
> diff --git a/accel/tcg/atomic_template.h b/accel/tcg/atomic_template.h
> index 1dc2151dafd..830e4f16069 100644
> --- a/accel/tcg/atomic_template.h
> +++ b/accel/tcg/atomic_template.h
> @@ -53,6 +53,14 @@
>   # error unsupported data size
>   #endif
>   
> +#if DATA_SIZE == 16
> +# define UPPER_MEMORY_VALUE(val) int128_gethi(val)
> +# define LOWER_MEMORY_VALUE(val) int128_getlo(val)
> +#else
> +# define UPPER_MEMORY_VALUE(val) 0
> +# define LOWER_MEMORY_VALUE(val) val
> +#endif
> +
>   #if DATA_SIZE >= 4
>   # define ABI_TYPE  DATA_TYPE
>   #else
> @@ -83,7 +91,12 @@ ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, abi_ptr addr,
>       ret = qatomic_cmpxchg__nocheck(haddr, cmpv, newv);
>   #endif
>       ATOMIC_MMU_CLEANUP;
> -    atomic_trace_rmw_post(env, addr, oi);
> +    atomic_trace_rmw_post(env, addr,
> +                          UPPER_MEMORY_VALUE(ret),
> +                          LOWER_MEMORY_VALUE(ret),
> +                          UPPER_MEMORY_VALUE(newv),
> +                          LOWER_MEMORY_VALUE(newv),
> +                          oi);

Just a nit, but tcg is consistent in using little-endian argument ordering for values 
passed by parts.  I would prefer we continue with that.


> @@ -142,9 +142,13 @@ struct qemu_plugin_tb {
>   /**
>    * struct CPUPluginState - per-CPU state for plugins
>    * @event_mask: plugin event bitmap. Modified only via async work.
> + * @mem_value_upper_bits: 64 upper bits of latest accessed mem value.
> + * @mem_value_lower_bits: 64 lower bits of latest accessed mem value.
>    */
>   struct CPUPluginState {
>       DECLARE_BITMAP(event_mask, QEMU_PLUGIN_EV_MAX);
> +    uint64_t mem_value_upper_bits;
> +    uint64_t mem_value_lower_bits;
>   };

At some point we may well support 32 byte acceses, for better guest vector support.  Do we 
have a plan for this beyond "add more fields here"?


r~

