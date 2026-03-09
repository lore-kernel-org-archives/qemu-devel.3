Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97055F4181F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 17:25:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzeMQ-0000Wb-1v; Mon, 09 Mar 2026 13:25:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vzeM8-0000FX-NM
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:25:29 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vzeM6-0007AG-Eu
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:25:24 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2ae5423b02aso55238755ad.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 10:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773077121; x=1773681921; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7oOFgLCjTGPgT8WrQcJ5xRlx0WQd4ReFZk+yVcQCQsw=;
 b=kACX8cPCdT8r2/ajQ8GO50rAh8mfSCA4YyCrabRJEQBQNpbV10vTjxF87B3S5dnKS5
 K8itYGYtQcN+owk3LWzUNsIlB5osPB4XV2zgL84PinL1QoVdKKUGTKf2WvIwVZGvoS1N
 K+tMhHJeHX2WESfSxKdvjJ6hio44BAnFQgmYcmm81XmoDNCYujZrPmE5VqzinaJbJPH2
 BX9GQmNSWb+iRW2R48YU792NmZD3syyoDmsuWD2h1caKeGFgVKrG8cZ5zsFAe1eeev+n
 BLO4yXDNZpgJaTyzkA95K7qfE8cYUkGTFWvUGJISS0nz6t/MCHRXXMClWaC8cBurg0pZ
 Xrsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773077121; x=1773681921;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7oOFgLCjTGPgT8WrQcJ5xRlx0WQd4ReFZk+yVcQCQsw=;
 b=hCUrOKccI8nGdBM733ZVy3yI7X/dJZFx2Q3qKCdHzMX7bvrYYVKX5MQ/Kc9yjUTpmB
 4qajzXlhd43+q4Zk7ZnaNOwufpXEwa7Ij+NGmwwPHk/tj1ZFdOHWUKNycQS56GTg3DAP
 mCiQvudwGikefEqxGpJ4384dem9JR75Gp+i/amN2pzMnNaS/Fk48Uy6X0uTNsFzkEC1F
 1JfNVogwfDJ2rNgt7L3C3kmdCiKuS2THCbRfIHXfbBh6i2FrDIL9Re42Z4yY4JHCmo98
 KrVeO92AeEYzsvikhONyRqS/WnUtOTKwZqAS5m7cqIA6cD4mzO4WywGGukzNIxqMe9L5
 dfNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVttL86+ar31evQt5iBv4auUrW+kCP7mRvZneatuKpWHHjuB4K8k9QFegsgC0di/g+1fJdXrfNE45vX@nongnu.org
X-Gm-Message-State: AOJu0Ywpyoy+by5y08eIW1KMZ0kLOEs+a5YEMJDZG+8YhyjUqZSN/XCq
 zWOF4QgVXI9MXhqSvjtSF3FxjPv9QjNTwCziu2pjVTVTActNP7MQSDeHNGPQwDmrBzE=
X-Gm-Gg: ATEYQzzeTwPid8F9bzgeXC9wSEyERMdZiRsMvV0LtuDPjIai4+0j9VQFXJTj/WbHyVp
 j5keGSSPSlFqUj5FghVbXad2aR1T7FU658Q7GG3tCXBFxxDhaO8rSVyK24A2EmA06UMAHNrmPxX
 U3SwQUnCw1DeNHowAkJjatQBj2SpZ/G/waWEHKbg48Pi3zZZU6A6ZRtCbNyct5Oy1fF6ZRlUDSk
 Xw1Ruh52eNzNV0CiLVjf8gb2vcuwW1LrkEBHDxjqNZQ23okeT6+Bm8Us/aRNBpq590/1n0O2Owa
 PhhW3KAaxZC4IHFvwmk3h75wJ0yp7wd94v6a86YirCUEAgiE29rbtAuXMggGnkFEf++9s6sZoRe
 mqvPJcg7Rh+OCvh+O9V3XYW4GrcCq43tG3gY/w/cmTA1PxiYoTG3BZGC+HaqVby/55iKR1M5dTp
 4i8SOWiO0VbbBG5Zzgl9uaj9PWp6Z+edbzVsAiCe/mnP/hVH+yMU14voegnle5P3cKLVSy
X-Received: by 2002:a17:903:3b8b:b0:29f:301a:f6cf with SMTP id
 d9443c01a7336-2ae8243435emr108891965ad.35.1773077120607; 
 Mon, 09 Mar 2026 10:25:20 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ae83f74272sm123724855ad.47.2026.03.09.10.25.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 10:25:20 -0700 (PDT)
Message-ID: <f624f3d9-aa11-406a-ac9b-f3fa2b103291@linaro.org>
Date: Mon, 9 Mar 2026 10:25:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH trivial] plugins: add missing docstrings to qemu-plugin.h
Content-Language: en-US
To: Florian Hofhammer <florian.hofhammer@epfl.ch>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, alex.bennee@linaro.org,
 richard.henderson@linaro.org
References: <20260309-add-missing-plugin-docs-v1-1-41dddcd177c8@epfl.ch>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260309-add-missing-plugin-docs-v1-1-41dddcd177c8@epfl.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/9/26 9:21 AM, Florian Hofhammer wrote:
> This patch adds docstrings for typedefs and function declarations in
> include/plugins/qemu-plugin.h that were previously missing. This
> resolves inconsistencies in the docs, e.g., the description for
> qemu_plugin_read_register() referring to qemu_plugin_register_flush_cb()
> but code cache flush callbacks not being documented themselves.
> 
> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
> ---
> Hi,
> 
> While working on a QEMU plugin and browsing the online docs at
> https://www.qemu.org/docs/master/devel/tcg-plugins.html, I noticed that
> some of the API functions were not actually documented.
> 
> I went through the include/plugins/qemu-plugin.h header file and added
> docstrings where they were missing, hoping of course that I documented
> the correct functionality based on my understanding of the plugin
> internals.
> 
> I hope that's useful and I didn't miss anything!
>

Thanks for the effort, that's always welcome to add documentation on a 
public API like this!

> Best regards,
> Florian
> 
> --
> Florian Hofhammer
> ---
>   include/plugins/qemu-plugin.h | 98 ++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 88 insertions(+), 10 deletions(-)
> 
> diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
> index 827e8e1787..fcf5af52ed 100644
> --- a/include/plugins/qemu-plugin.h
> +++ b/include/plugins/qemu-plugin.h
> @@ -339,12 +339,28 @@ enum qemu_plugin_cb_flags {
>       QEMU_PLUGIN_CB_RW_REGS_PC,
>   };
>   
> +/**
> + * enum qemu_plugin_mem_rw - type of memory access
> + *
> + * @QEMU_PLUGIN_MEM_R: memory read access only
> + * @QEMU_PLUGIN_MEM_W: memory write access only
> + * @QEMU_PLUGIN_MEM_RW: memory read and write access
> + */
>   enum qemu_plugin_mem_rw {
>       QEMU_PLUGIN_MEM_R = 1,
>       QEMU_PLUGIN_MEM_W,
>       QEMU_PLUGIN_MEM_RW,
>   };
>   
> +/**
> + * enum qemu_plugin_mem_value_type - size of memory value
> + *
> + * @QEMU_PLUGIN_MEM_VALUE_U8: unsigned 8-bit value
> + * @QEMU_PLUGIN_MEM_VALUE_U16: unsigned 16-bit value
> + * @QEMU_PLUGIN_MEM_VALUE_U32: unsigned 32-bit value
> + * @QEMU_PLUGIN_MEM_VALUE_U64: unsigned 64-bit value
> + * @QEMU_PLUGIN_MEM_VALUE_U128: unsigned 128-bit value
> + */
>   enum qemu_plugin_mem_value_type {
>       QEMU_PLUGIN_MEM_VALUE_U8,
>       QEMU_PLUGIN_MEM_VALUE_U16,
> @@ -353,7 +369,13 @@ enum qemu_plugin_mem_value_type {
>       QEMU_PLUGIN_MEM_VALUE_U128,
>   };
>   
> -/* typedef qemu_plugin_mem_value - value accessed during a load/store */
> +/**
> + * typedef qemu_plugin_mem_value - value accessed during a load/store
> + *
> + * @type: the memory access size
> + * @data: the value accessed during the memory operation (value after
> + *        read/write)
> + */
>   typedef struct {
>       enum qemu_plugin_mem_value_type type;
>       union {
> @@ -462,7 +484,6 @@ void qemu_plugin_register_vcpu_tb_exec_cond_cb(struct qemu_plugin_tb *tb,
>    * @QEMU_PLUGIN_INLINE_ADD_U64: add an immediate value uint64_t
>    * @QEMU_PLUGIN_INLINE_STORE_U64: store an immediate value uint64_t
>    */
> -
>   enum qemu_plugin_op {
>       QEMU_PLUGIN_INLINE_ADD_U64,
>       QEMU_PLUGIN_INLINE_STORE_U64,
> @@ -803,6 +824,20 @@ const void *qemu_plugin_request_time_control(void);
>   QEMU_PLUGIN_API
>   void qemu_plugin_update_ns(const void *handle, int64_t time);
>   
> +/**
> + * typedef qemu_plugin_vcpu_syscall_cb_t - vCPU syscall callback function type
> + * @id: plugin id
> + * @vcpu_index: the executing vCPU
> + * @num: the syscall number
> + * @a1: the 1st syscall argument
> + * @a2: the 2nd syscall argument
> + * @a3: the 3rd syscall argument
> + * @a4: the 4th syscall argument
> + * @a5: the 5th syscall argument
> + * @a6: the 6th syscall argument
> + * @a7: the 7th syscall argument
> + * @a8: the 8th syscall argument
> + */
>   typedef void
>   (*qemu_plugin_vcpu_syscall_cb_t)(qemu_plugin_id_t id, unsigned int vcpu_index,
>                                    int64_t num, uint64_t a1, uint64_t a2,
> @@ -836,24 +871,61 @@ typedef bool
>                                           uint64_t a6, uint64_t a7, uint64_t a8,
>                                           uint64_t *sysret);
>   
> -QEMU_PLUGIN_API
> -void qemu_plugin_register_vcpu_syscall_cb(qemu_plugin_id_t id,
> -                                          qemu_plugin_vcpu_syscall_cb_t cb);
> -
> +/**
> + * typedef qemu_plugin_vcpu_syscall_ret_cb_t - vCPU syscall return callback
> + * function type
> + * @id: plugin id
> + * @vcpu_index: the executing vCPU
> + * @num: the syscall number
> + * @ret: the syscall return value
> + */
>   typedef void
>   (*qemu_plugin_vcpu_syscall_ret_cb_t)(qemu_plugin_id_t id, unsigned int vcpu_idx,
>                                        int64_t num, int64_t ret);
>   
> +/**
> + * qemu_plugin_register_vcpu_syscall_cb() - register a syscall entry callback
> + * @id: plugin id
> + * @cb: callback of type qemu_plugin_vcpu_syscall_cb_t
> + *
> + * This registers a callback for every syscall executed by the guest. The @cb
> + * function is executed before a syscall is handled by the host.
> + */
>   QEMU_PLUGIN_API
> -void
> -qemu_plugin_register_vcpu_syscall_ret_cb(qemu_plugin_id_t id,
> -                                         qemu_plugin_vcpu_syscall_ret_cb_t cb);
> +void qemu_plugin_register_vcpu_syscall_cb(qemu_plugin_id_t id,
> +                                          qemu_plugin_vcpu_syscall_cb_t cb);
>   
> +/**
> + * qemu_plugin_register_vcpu_syscall_filter_cb() - register a syscall filter
> + * callback
> + * @id: plugin id
> + * @cb: callback of type qemu_plugin_vcpu_syscall_filter_cb_t
> + *
> + * This registers a callback for every syscall executed by the guest. The @cb
> + * function is executed before a syscall is handled by the host. If the
> + * callback returns true, the syscall is filtered and will not be executed by
> + * the host. The callback must then set the syscall return value via the
> + * corresponding pointer passed to it.
> + */
>   QEMU_PLUGIN_API
>   void
>   qemu_plugin_register_vcpu_syscall_filter_cb(qemu_plugin_id_t id,
>                                               qemu_plugin_vcpu_syscall_filter_cb_t cb);
>   
> +/**
> + * qemu_plugin_register_vcpu_syscall_ret_cb() - register a syscall entry
> + * callback
> + * @id: plugin id
> + * @cb: callback of type qemu_plugin_vcpu_syscall_ret_cb_t
> + *
> + * This registers a callback for every syscall executed by the guest. The @cb
> + * function is executed upon return from the host syscall before execution is
> + * handed back to the guest.
> + */
> +QEMU_PLUGIN_API
> +void
> +qemu_plugin_register_vcpu_syscall_ret_cb(qemu_plugin_id_t id,
> +                                         qemu_plugin_vcpu_syscall_ret_cb_t cb);
>   
>   /**
>    * qemu_plugin_insn_disas() - return disassembly string for instruction
> @@ -861,7 +933,6 @@ qemu_plugin_register_vcpu_syscall_filter_cb(qemu_plugin_id_t id,
>    *
>    * Returns an allocated string containing the disassembly
>    */
> -
>   QEMU_PLUGIN_API
>   char *qemu_plugin_insn_disas(const struct qemu_plugin_insn *insn);
>   
> @@ -888,6 +959,13 @@ QEMU_PLUGIN_API
>   void qemu_plugin_vcpu_for_each(qemu_plugin_id_t id,
>                                  qemu_plugin_vcpu_simple_cb_t cb);
>   
> +/**
> + * qemu_plugin_register_flush_cb() - register code cache flush callback
> + * @id: plugin ID
> + * @cb: callback
> + *
> + * The @cb function is called every time the code cache is flushed.
> + */

Thanks, I was thinking to document this since someone asked a question 
on IRC a few weeks ago.

May you add here:
"This callback can be used to free resources associated with existing 
translated blocks in a plugin. @cb is guaranteed to run with all cpus 
being stopped, thus no lock is required within it."

>   QEMU_PLUGIN_API
>   void qemu_plugin_register_flush_cb(qemu_plugin_id_t id,
>                                      qemu_plugin_simple_cb_t cb);
> 
> ---
> base-commit: 7608a95d2e0bd8c8d069ab77824d02586dd94648
> change-id: 20260309-add-missing-plugin-docs-159d7ff315f9
> 

Regards,
Pierrick

