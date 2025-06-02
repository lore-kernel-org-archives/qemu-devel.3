Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25FC2C5B555
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 20:50:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMC69-0003yU-A2; Mon, 02 Jun 2025 16:49:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uMC66-0003y2-5M
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 16:49:30 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uMC64-0002A3-2Y
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 16:49:29 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-b2c41acd479so3214253a12.2
 for <qemu-devel@nongnu.org>; Mon, 02 Jun 2025 13:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748897366; x=1749502166; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tI8FXyIyUJmtcXVdRTJ00uVv9oe44t0OGGLxaXREHQU=;
 b=Z3k9C471/DwxkChgzD6HAoN1zaKYwdmrqv91MjzHqaSy4vCmkmvF/UWLfeqExdSefw
 t5vt98m5PgTBbiG64MDoV9e0KW0khKvEDtlfsjq7iFz2DhXLWBJyP6Bal7Z5akiY6nTa
 27mV8JBhw2IEnY8IkdaowWw9mY4xH8yayfnUg7WfabJhUpT/riVjh2qgvqrIUiPdxZNe
 8HPIA4nxJ1XRgr7L4dznH+GNa5idBjvnExVCR/ZkZKYlrjuLkg9AgnBjiIGJFRJuFYTg
 Q4HQLAht01qa1Oy2s9uQu8BbtI/U+8VQtqxZSkwtnjGXnXDTxAWJ+Rt9JJ1G1jNfHcWl
 ieig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748897366; x=1749502166;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tI8FXyIyUJmtcXVdRTJ00uVv9oe44t0OGGLxaXREHQU=;
 b=ujb89goWA0a0ICJHWYtp50KZMwwTDA89AJXz+/qGvA1dGTdiYFPdS9lFfBo0ddjAKk
 S6s4k3dDOmc24Z01AUX49gJhQUo8anp74/Q+hKcRVNgGesHYelzTNf6v0mIwUlge9WbG
 E0xO6WmQRSyHXaNHjMrfd3bbEGzoIPZbxBKz6UEIT+Aj1MI9wjdEvhyJ5YLfxglQb4zQ
 ZRPOS6nEyi93bfLhlcldJy9OfYziG7sIngZSQgUQ1qX0UJX4UUIkkIgvOeCJflbKQJH/
 oXHnoRi6+JqYW2g75H0d/S48LaKIBHyQjP2Zfn07Kz0VKHUbsls3qSJ9ymhkRFOicXpP
 kNwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAY0LcqmUCwt/NrkZQgBgCKSA+gZ1zd5WxHqLbOSa6h5l4V4oL1RRGwU23EDNv/TxfuInUBQkMd5NM@nongnu.org
X-Gm-Message-State: AOJu0YwDJcs8Sf5jJ+2q83z5NktfKC+jDDb+g21jHwdgTKPBUVcAvSOT
 tdVtP/3AeVsFk6bSgrDsDpDW6KIKg/VZkf+slIwu4TkrlZQmfGn977m//csYLgjo9Fg=
X-Gm-Gg: ASbGncvVdePK4MPRPw2NHsyvKXizzhWJs12EY84N8dvHoOSbC1Y2zSoOYzmJAbXKdny
 v4bq5DW/7kusLl+fF5l1ZXtElnZicMKv5/RgJWenlx92yBKB0TjhvOJ9EuYmZMQ743xaXgMNzR2
 pf53mIGMTlXVrOPVREtEJ7bswyU4gnYLhRSwzGFTUcpXa7iSsoU/NXzIcisgriof85lAKgSML7M
 yGgwNrmvakpEjnN4pfwrU3tuJpIgrDUFhDsOHNm8yF1NJJsb0M6fTVHSJhCnliPpmxm0gy6ekZo
 q8iyOYkkkgXLHGjtlga5q1RAINL6Erop16MmB6C9PUngSpjb9zO1cPsD2FIFtQ+H
X-Google-Smtp-Source: AGHT+IG5LZRGerpSryvEfiJ52lWA9BrcrNO697ctf43dFSj7dm3/3Tiw6JClkIQVImSw7LtsxjRBfQ==
X-Received: by 2002:a17:90b:17c3:b0:312:1c83:58e7 with SMTP id
 98e67ed59e1d1-3127c6a9c1fmr13471914a91.1.1748897366267; 
 Mon, 02 Jun 2025 13:49:26 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3124e2c2fa3sm6613120a91.19.2025.06.02.13.49.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Jun 2025 13:49:25 -0700 (PDT)
Message-ID: <7f925a2a-20d7-40e6-bf2c-ac3823912a04@linaro.org>
Date: Mon, 2 Jun 2025 13:49:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/9] plugins: Add enforcement of QEMU_PLUGIN_CB flags
 in register R/W callbacks
Content-Language: en-US
To: Rowan Hart <rowanbhart@gmail.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
References: <20250602195706.1043662-1-rowanbhart@gmail.com>
 <20250602195706.1043662-4-rowanbhart@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250602195706.1043662-4-rowanbhart@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x532.google.com
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

On 6/2/25 12:57 PM, Rowan Hart wrote:
> This patch adds functionality to enforce the requested QEMU_PLUGIN_CB_
> flags level passed when registering a callback function using the
> plugins API. Each time a callback is about to be invoked, a thread-local
> variable will be updated with the level that callback requested. Then,
> called API functions (in particular, the register read and write API)
> will call qemu_plugin_get_cb_flags() to check the level is at least the
> level they require.
> 
> Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
> ---
>   accel/tcg/plugin-gen.c     | 30 ++++++++++++++++++++++++++++++
>   include/hw/core/cpu.h      |  1 +
>   include/qemu/plugin.h      |  4 ++++
>   include/qemu/qemu-plugin.h |  3 ---
>   plugins/api.c              |  8 ++++++++
>   plugins/core.c             | 32 ++++++++++++++++++++++++++------
>   6 files changed, 69 insertions(+), 9 deletions(-)
> 
> diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
> index c1da753894..9920381a84 100644
> --- a/accel/tcg/plugin-gen.c
> +++ b/accel/tcg/plugin-gen.c
> @@ -117,10 +117,20 @@ static TCGv_i32 gen_cpu_index(void)
>   static void gen_udata_cb(struct qemu_plugin_regular_cb *cb)
>   {
>       TCGv_i32 cpu_index = gen_cpu_index();
> +    enum qemu_plugin_cb_flags cb_flags =
> +        tcg_call_to_qemu_plugin_cb_flags(cb->info->flags);
> +    TCGv_i32 flags = tcg_constant_i32(cb_flags);
> +    TCGv_i32 clear_flags = tcg_constant_i32(QEMU_PLUGIN_CB_NO_REGS);
> +    tcg_gen_st_i32(flags, tcg_env,
> +           offsetof(CPUState, neg.plugin_cb_flags) - sizeof(CPUState));
>       tcg_gen_call2(cb->f.vcpu_udata, cb->info, NULL,
>                     tcgv_i32_temp(cpu_index),
>                     tcgv_ptr_temp(tcg_constant_ptr(cb->userp)));
> +    tcg_gen_st_i32(clear_flags, tcg_env,
> +           offsetof(CPUState, neg.plugin_cb_flags) - sizeof(CPUState));
>       tcg_temp_free_i32(cpu_index);
> +    tcg_temp_free_i32(flags);
> +    tcg_temp_free_i32(clear_flags);
>   }
>   
>   static TCGv_ptr gen_plugin_u64_ptr(qemu_plugin_u64 entry)
> @@ -173,10 +183,20 @@ static void gen_udata_cond_cb(struct qemu_plugin_conditional_cb *cb)
>       tcg_gen_ld_i64(val, ptr, 0);
>       tcg_gen_brcondi_i64(cond, val, cb->imm, after_cb);
>       TCGv_i32 cpu_index = gen_cpu_index();
> +    enum qemu_plugin_cb_flags cb_flags =
> +        tcg_call_to_qemu_plugin_cb_flags(cb->info->flags);
> +    TCGv_i32 flags = tcg_constant_i32(cb_flags);
> +    TCGv_i32 clear_flags = tcg_constant_i32(QEMU_PLUGIN_CB_NO_REGS);
> +    tcg_gen_st_i32(flags, tcg_env,
> +           offsetof(CPUState, neg.plugin_cb_flags) - sizeof(CPUState));
>       tcg_gen_call2(cb->f.vcpu_udata, cb->info, NULL,
>                     tcgv_i32_temp(cpu_index),
>                     tcgv_ptr_temp(tcg_constant_ptr(cb->userp)));
> +    tcg_gen_st_i32(clear_flags, tcg_env,
> +           offsetof(CPUState, neg.plugin_cb_flags) - sizeof(CPUState));
>       tcg_temp_free_i32(cpu_index);
> +    tcg_temp_free_i32(flags);
> +    tcg_temp_free_i32(clear_flags);
>       gen_set_label(after_cb);
>   
>       tcg_temp_free_i64(val);
> @@ -210,12 +230,22 @@ static void gen_mem_cb(struct qemu_plugin_regular_cb *cb,
>                          qemu_plugin_meminfo_t meminfo, TCGv_i64 addr)
>   {
>       TCGv_i32 cpu_index = gen_cpu_index();
> +    enum qemu_plugin_cb_flags cb_flags =
> +        tcg_call_to_qemu_plugin_cb_flags(cb->info->flags);
> +    TCGv_i32 flags = tcg_constant_i32(cb_flags);
> +    TCGv_i32 clear_flags = tcg_constant_i32(QEMU_PLUGIN_CB_NO_REGS);
> +    tcg_gen_st_i32(flags, tcg_env,
> +           offsetof(CPUState, neg.plugin_cb_flags) - sizeof(CPUState));
>       tcg_gen_call4(cb->f.vcpu_mem, cb->info, NULL,
>                     tcgv_i32_temp(cpu_index),
>                     tcgv_i32_temp(tcg_constant_i32(meminfo)),
>                     tcgv_i64_temp(addr),
>                     tcgv_ptr_temp(tcg_constant_ptr(cb->userp)));
> +    tcg_gen_st_i32(clear_flags, tcg_env,
> +           offsetof(CPUState, neg.plugin_cb_flags) - sizeof(CPUState));
>       tcg_temp_free_i32(cpu_index);
> +    tcg_temp_free_i32(flags);
> +    tcg_temp_free_i32(clear_flags);
>   }
>   
>   static void inject_cb(struct qemu_plugin_dyn_cb *cb)
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 1e87f7d393..d3cc9a5224 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -368,6 +368,7 @@ typedef struct CPUNegativeOffsetState {
>       GArray *plugin_mem_cbs;
>       uint64_t plugin_mem_value_low;
>       uint64_t plugin_mem_value_high;
> +    int32_t plugin_cb_flags;
>   #endif
>       IcountDecr icount_decr;
>       bool can_do_io;
> diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
> index 9726a9ebf3..2fef2e7d71 100644
> --- a/include/qemu/plugin.h
> +++ b/include/qemu/plugin.h
> @@ -209,6 +209,10 @@ void qemu_plugin_user_prefork_lock(void);
>    */
>   void qemu_plugin_user_postfork(bool is_child);
>   
> +enum qemu_plugin_cb_flags tcg_call_to_qemu_plugin_cb_flags(int flags);
> +
> +enum qemu_plugin_cb_flags qemu_plugin_get_cb_flags(void);
> +
>   #else /* !CONFIG_PLUGIN */
>   
>   static inline void qemu_plugin_add_opts(void)
> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
> index cfe1692ecb..120fb626a6 100644
> --- a/include/qemu/qemu-plugin.h
> +++ b/include/qemu/qemu-plugin.h
> @@ -254,9 +254,6 @@ typedef struct {
>    * @QEMU_PLUGIN_CB_NO_REGS: callback does not access the CPU's regs
>    * @QEMU_PLUGIN_CB_R_REGS: callback reads the CPU's regs
>    * @QEMU_PLUGIN_CB_RW_REGS: callback reads and writes the CPU's regs
> - *
> - * Note: currently QEMU_PLUGIN_CB_RW_REGS is unused, plugins cannot change
> - * system register state.
>    */
>   enum qemu_plugin_cb_flags {
>       QEMU_PLUGIN_CB_NO_REGS,
> diff --git a/plugins/api.c b/plugins/api.c
> index 3a7add50d2..16141f5c25 100644
> --- a/plugins/api.c
> +++ b/plugins/api.c
> @@ -437,6 +437,10 @@ int qemu_plugin_read_register(struct qemu_plugin_register *reg, GByteArray *buf)
>   {
>       g_assert(current_cpu);
>   
> +    if (qemu_plugin_get_cb_flags() == QEMU_PLUGIN_CB_NO_REGS) {
> +        return -1;
> +    }
> +
>       return gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg) - 1);
>   }
>   
> @@ -445,6 +449,10 @@ int qemu_plugin_write_register(struct qemu_plugin_register *reg,
>   {
>       g_assert(current_cpu);
>   
> +    if (buf->len == 0 || qemu_plugin_get_cb_flags() != QEMU_PLUGIN_CB_RW_REGS) {
> +        return 0;
> +    }
> +

Would it be better to return -1 for "qemu_plugin_get_cb_flags() != 
QEMU_PLUGIN_CB_RW_REGS", so user can notice there is something wrong 
with flags?

>       return gdb_write_register(current_cpu, buf->data, GPOINTER_TO_INT(reg) - 1);
>   }
>   
> diff --git a/plugins/core.c b/plugins/core.c
> index eb9281fe54..34bddb6c1c 100644
> --- a/plugins/core.c
> +++ b/plugins/core.c
> @@ -364,14 +364,15 @@ void plugin_register_dyn_cb__udata(GArray **arr,
>                                      enum qemu_plugin_cb_flags flags,
>                                      void *udata)
>   {
> -    static TCGHelperInfo info[3] = {
> +    static TCGHelperInfo info[4] = {
>           [QEMU_PLUGIN_CB_NO_REGS].flags = TCG_CALL_NO_RWG,
>           [QEMU_PLUGIN_CB_R_REGS].flags = TCG_CALL_NO_WG,
> +        [QEMU_PLUGIN_CB_RW_REGS].flags = 0,
>           /*
>            * Match qemu_plugin_vcpu_udata_cb_t:
>            *   void (*)(uint32_t, void *)
>            */
> -        [0 ... 2].typemask = (dh_typemask(void, 0) |
> +        [0 ... 3].typemask = (dh_typemask(void, 0) |
>                                 dh_typemask(i32, 1) |
>                                 dh_typemask(ptr, 2))
>       };

[QEMU_PLUGIN_CB_RW_REGS].flags = 0 was already set implicitly, as all 
elements not explicit set are initialized to 0.
As you can see, [0 ... 2].typemask was set, which shows we initialized 
the third element.
Adding [QEMU_PLUGIN_CB_RW_REGS].flags = 0 does not hurt, and is more 
explicit, but you don't need to increase array size.

This static array is used to set info field in callback struct, as
.info = &info[flags]. Flags being an enum qemu_plugin_cb_flags, its 
value is 0,1 or 2, so adding one entry is useless.

> @@ -393,14 +394,15 @@ void plugin_register_dyn_cond_cb__udata(GArray **arr,
>                                           uint64_t imm,
>                                           void *udata)
>   {
> -    static TCGHelperInfo info[3] = {
> +    static TCGHelperInfo info[4] = {
>           [QEMU_PLUGIN_CB_NO_REGS].flags = TCG_CALL_NO_RWG,
>           [QEMU_PLUGIN_CB_R_REGS].flags = TCG_CALL_NO_WG,
> +        [QEMU_PLUGIN_CB_RW_REGS].flags = 0,
>           /*
>            * Match qemu_plugin_vcpu_udata_cb_t:
>            *   void (*)(uint32_t, void *)
>            */
> -        [0 ... 2].typemask = (dh_typemask(void, 0) |
> +        [0 ... 3].typemask = (dh_typemask(void, 0) |
>                                 dh_typemask(i32, 1) |
>                                 dh_typemask(ptr, 2))
>       };
> @@ -431,14 +433,15 @@ void plugin_register_vcpu_mem_cb(GArray **arr,
>           !__builtin_types_compatible_p(qemu_plugin_meminfo_t, uint32_t) &&
>           !__builtin_types_compatible_p(qemu_plugin_meminfo_t, int32_t));
>   
> -    static TCGHelperInfo info[3] = {
> +    static TCGHelperInfo info[4] = {
>           [QEMU_PLUGIN_CB_NO_REGS].flags = TCG_CALL_NO_RWG,
>           [QEMU_PLUGIN_CB_R_REGS].flags = TCG_CALL_NO_WG,
> +        [QEMU_PLUGIN_CB_RW_REGS].flags = 0,
>           /*
>            * Match qemu_plugin_vcpu_mem_cb_t:
>            *   void (*)(uint32_t, qemu_plugin_meminfo_t, uint64_t, void *)
>            */
> -        [0 ... 2].typemask =
> +        [0 ... 3].typemask =
>               (dh_typemask(void, 0) |
>                dh_typemask(i32, 1) |
>                (__builtin_types_compatible_p(qemu_plugin_meminfo_t, uint32_t)
> @@ -760,3 +763,20 @@ void plugin_scoreboard_free(struct qemu_plugin_scoreboard *score)
>       g_array_free(score->data, TRUE);
>       g_free(score);
>   }
> +
> +enum qemu_plugin_cb_flags tcg_call_to_qemu_plugin_cb_flags(int flags)
> +{
> +    if (flags & TCG_CALL_NO_RWG) {
> +        return QEMU_PLUGIN_CB_NO_REGS;
> +    } else if (flags & TCG_CALL_NO_WG) {
> +        return QEMU_PLUGIN_CB_R_REGS;
> +    } else {
> +        return QEMU_PLUGIN_CB_RW_REGS;
> +    }
> +}
> +
> +enum qemu_plugin_cb_flags qemu_plugin_get_cb_flags(void)
> +{
> +    assert(current_cpu);
> +    return current_cpu->neg.plugin_cb_flags;
> +}


