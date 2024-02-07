Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3748C4829C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 03:42:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXYpG-0006kl-DP; Tue, 06 Feb 2024 22:42:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXYpB-0006jZ-Aw
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 22:42:14 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXYp9-0002qe-Mp
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 22:42:13 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1d958e0d73dso1672145ad.1
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 19:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707277330; x=1707882130; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n1zFMdGuHHeaWfEy+3ExlGkuLmb6ayc3o7Nb2fQl7GA=;
 b=SvqxF9ltb1OeYH5wsZFejZADJqvzrIJ3zWwzJKeq0GPudzYp7dRh57H4WNrq1k5kpu
 tTNV0AZ/1B0sFvq0AAh6UuUzpRXmYcyYS69kiUl7+4XFobywJGq5ltViQscc8g17pIzk
 hLWUhLXtD2bC6SKfgO6qGM+5WmPjRic5XJox5AQj9NlytmQC4WQgAaMwZd8o006cQEGP
 0f7rK3LVVDJ5pgI136T/EtkrFRGTdsJ6QvBA/DT786McqTHZZ+Z/jKz5o+END616o9Ph
 nE4CS6HKq0n5xI4gitfCg1gmRNX+UUYs8tw5uH1NuJ4rNx7YxA/nkOFgYzVnuQz51/f0
 3rZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707277330; x=1707882130;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n1zFMdGuHHeaWfEy+3ExlGkuLmb6ayc3o7Nb2fQl7GA=;
 b=jBRcdtbJ1gurUaf6mbK38S0QhrlDN0tT+n371WEnwlxjHYASbmPcVB5Vg2EvhEKD7J
 HhNBa5bu3WiNx6AjqS/xg5+cHr+mMRr+tPVcNvNJEHejAIcr1iKoYzXTrBubADEmiD+b
 aAmleJrzYNyM7VJSEDFHOS0XlP7DWoOAyqJZPtLbnJriFQb3eggf5eOrW8mwjXeYafaO
 xRieT246WZ1ivLbt5ZGrOhdUt56PIig19ZgKGKMQaM/IQVtdnRwDq3xdsDXK7SkM4T41
 bKXyQpIe9ozpnKe3SnL49vxE2LYVpwZWY/A3itEWm/wjFsLIfvrdtC58ak7UGRz75l14
 Dg8A==
X-Gm-Message-State: AOJu0YxlOSJcc6qqkoxxaVpG4Ot7h7h3aXDg5rcURize9m0f9mKt+vEw
 aEwQvn3L+Vswcv/tym7rOkzW4SsRUvEQ3QqC0GVqmKxK6RRn6glf8m0QflcdzAY=
X-Google-Smtp-Source: AGHT+IFQU21zot4reEFsLYh8xfn2bMAqc74wXoFi2DklGLxCXABiRqOswD5AW3apIEc4SiG2GhXs4Q==
X-Received: by 2002:a17:903:2341:b0:1d8:ab27:d784 with SMTP id
 c1-20020a170903234100b001d8ab27d784mr5331515plh.21.1707277330194; 
 Tue, 06 Feb 2024 19:42:10 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUDF+xo3StWwXr0vDIZqf1eg/78iVE2szPA3l5td5o6tg/uzqqubqtMQ0oeofxgrKaHwrwLc1xN+W5WQPIdrQb4Erla70MBB41LLxcQ6rBf2BhzXa6CdbPU1OdKo3hTwHAB6HFVwLkxLpHGWk2T2ubl25ljebPsipuKUeGL3DaeMosfviYTvg+1dsL3HTwR++9yCOolaXMLTiNr2D/cNG2+5gb54C0C7jxyllmaQ8hrFm7IOk9XBsoVyUt6QFzQquRI7SyZTz9Y8zSJV0+OvxBNMTzZM0/eDoHqDZVleDwOViSM5w==
Received: from [192.168.188.227] (60-242-98-186.static.tpgi.com.au.
 [60.242.98.186]) by smtp.gmail.com with ESMTPSA id
 x17-20020a170902e05100b001d9a91af8a4sm309924plx.28.2024.02.06.19.42.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Feb 2024 19:42:09 -0800 (PST)
Message-ID: <1838c7f7-db41-4328-b75b-6b392f600bd2@linaro.org>
Date: Wed, 7 Feb 2024 13:42:02 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/17] plugins: implement inline operation relative to
 cpu_index
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Alexandre Iooss
 <erdnaxe@crans.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240206092423.3005995-1-pierrick.bouvier@linaro.org>
 <20240206092423.3005995-8-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240206092423.3005995-8-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 2/6/24 19:24, Pierrick Bouvier wrote:
> Instead of working on a fixed memory location, allow to address it based
> on cpu_index, an element size and a given offset.
> Result address: ptr + offset + cpu_index * element_size.
> 
> With this, we can target a member in a struct array from a base pointer.
> 
> Current semantic is not modified, thus inline operation still targets
> always the same memory location.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   plugins/plugin.h       |  2 +-
>   accel/tcg/plugin-gen.c | 65 +++++++++++++++++++++++++++++++++++-------
>   plugins/api.c          |  3 +-
>   plugins/core.c         | 12 +++++---
>   4 files changed, 65 insertions(+), 17 deletions(-)
> 
> diff --git a/plugins/plugin.h b/plugins/plugin.h
> index fd93a372803..77ed10689ca 100644
> --- a/plugins/plugin.h
> +++ b/plugins/plugin.h
> @@ -100,7 +100,7 @@ void plugin_register_vcpu_mem_cb(GArray **arr,
>                                    enum qemu_plugin_mem_rw rw,
>                                    void *udata);
>   
> -void exec_inline_op(struct qemu_plugin_dyn_cb *cb);
> +void exec_inline_op(struct qemu_plugin_dyn_cb *cb, int cpu_index);
>   
>   int plugin_num_vcpus(void);
>   
> diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
> index b37ce7683e6..68dee4c68d3 100644
> --- a/accel/tcg/plugin-gen.c
> +++ b/accel/tcg/plugin-gen.c
> @@ -132,16 +132,28 @@ static void gen_empty_udata_cb_no_rwg(void)
>    */
>   static void gen_empty_inline_cb(void)
>   {
> +    TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
> +    TCGv_ptr cpu_index_as_ptr = tcg_temp_ebb_new_ptr();
>       TCGv_i64 val = tcg_temp_ebb_new_i64();
>       TCGv_ptr ptr = tcg_temp_ebb_new_ptr();
>   
> +    tcg_gen_ld_i32(cpu_index, tcg_env,
> +                   -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_index));
> +    /* pass an immediate != 0 so that it doesn't get optimized away */
> +    tcg_gen_muli_i32(cpu_index, cpu_index, 0xdeadbeef);

You don't need a random immediate here.
You can just as easily use

     tcg_gen_mul_i32(cpu_index, cpu_index, cpu_index);

with a similar comment about the true size being inserted later.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

