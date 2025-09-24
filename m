Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1172CAC5AE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 17:25:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1TEd-0002g1-Mo; Wed, 24 Sep 2025 13:24:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1TEb-0002fC-G5
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 13:24:53 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1TEX-0004hO-1c
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 13:24:52 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-b4c29d2ea05so1057319a12.0
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 10:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758734685; x=1759339485; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ns0UNBMqjtaZP00d9T9n94sju1xh/i1Dulnvibt/OQY=;
 b=QY+LMremzvRkbnhAJYuFnv7OjgQ4JQFSeFExu76KGzGxECWR3o0zib+mEAXmDpBp/p
 EgKmb3Aj/9fQpGzs96Frf1kSQKP95rJ4i2uFfTKF51bIUxd/0+fNEZo1al8ODOTWdluQ
 OftZH4S+jgGASWymP+Ml8SOzXiyCKVemlwxOhRMOevPqIpznf88T1TK0YFkhP3YJYlLf
 eCSMBfB/+DXFl3wmlKHHlW3a5WX81/SeF7wIDS2zjm9PB8sB7NMok291NWFoPZKRlVS0
 UgTAaRoKCDhFCP3vsMGJsGiJRvjb+jRdLG5YsGb7qm6Nl/2+4KKBcXAXvHLdB2UQdm4d
 f4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758734685; x=1759339485;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ns0UNBMqjtaZP00d9T9n94sju1xh/i1Dulnvibt/OQY=;
 b=Q4oVABBDQWKa48+OAjJvI91KI98Grc6r/BAqr0A+rdW+XpiXRI5lK+1XGrak3KUDdP
 X68KvYBpT2UnINzx1ANFxzMGwjgHs1srPegyogZnlSwUWCp/YE1q+hWw41YvBkFg5+TS
 OWGgQEvVYwMLGO3ex0gxjGkc+UhX5Y3g8sB+29ISA0Ueg69eZOEU6Cf86nxzWUmA2orW
 O1IU/bj17Fb7RlAymvwnVw3WXeAiotz7p0cbYhRpE/wZrlCm4BHj6iT0OALWnIDo6ln1
 srkPW1fGzPtxKwO/UCsa7ScP78mBps4YXKMD6pvhLesdNT0PDSFoFzl6C1z+C8VB0OsU
 K8ng==
X-Gm-Message-State: AOJu0YzX76h/+xlWgaZTfuJg7NJkHao7Lu4pO8VRdGzjLaX3fh8DjR1y
 wvn27Zdiv7wEIYWuN0bbXlqtXzKpCYyjCKQv98yy0QuaS2ZB30Gdys19Jfyqxi63yTxmj4UM0WU
 ocAj5
X-Gm-Gg: ASbGnct46cRhp1HwtZfpy+5WUmLFaSNvTW7way7Ogh0Uoqv91v64sMU4GBCxtWWMuTf
 Jte+FzLA7hTprkwUp+RFXJdTghMmV1Da6yYdov6jlpxFPPy7R5oX2/r+PJ4NnmWK5MtkayiAKuG
 0QLueUvl7vApbqr/SRawmFJ/1s9xOv64QR+w4FWoQXNC+vj9nphrfS19tU0gpzoQy9chU9OKG2L
 cTIYur0caESLgxGaIBlU9UZ43u57LzunxfsnO6lxCA1vhL+/DwR+BDNg0pdFjdFYXUkjEcmPZQn
 rniXALqEGSF15NLrGAA3qLgfHMAIfocyT6xaaEp/8pJxOgvgRXweVu5ZtgIWSuXrUBerLwM/y5K
 AGCThI00InC9LWcc5GvYP73CALeGeuRPzSKRJ
X-Google-Smtp-Source: AGHT+IGDo2x3OaEa40RSfDYxhjRMEjKS1M4yG40tqFPCJHZuWx83n0IPHICd0llRA3Cebbmo8tcI6w==
X-Received: by 2002:a17:902:e889:b0:265:e815:fcdf with SMTP id
 d9443c01a7336-27ed4aab727mr5094945ad.17.1758734685081; 
 Wed, 24 Sep 2025 10:24:45 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b5524c329e6sm14144927a12.42.2025.09.24.10.24.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Sep 2025 10:24:44 -0700 (PDT)
Message-ID: <7a4fe7cc-9627-4a62-a51b-9435719ba21c@linaro.org>
Date: Wed, 24 Sep 2025 10:24:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/m68k: Remove unused @cpu_exception_index TCGv
To: qemu-devel@nongnu.org
References: <20250924171308.53036-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250924171308.53036-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

On 9/24/25 10:13, Philippe Mathieu-Daudé wrote:
> When moving the @exception_index from each target ArchCPU
> to the global CPUState in commit 27103424c40 ("cpu: Move
> exception_index field from CPU_COMMON to CPUState"), the
> @cpu_exception_index TCGv has been created for m68k target.
> 
> For years, no code ever used this register. Simply remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/m68k/translate.c | 6 ------
>   1 file changed, 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/target/m68k/translate.c b/target/m68k/translate.c
> index 97afceb1297..0cee54f4900 100644
> --- a/target/m68k/translate.c
> +++ b/target/m68k/translate.c
> @@ -45,7 +45,6 @@
>   #undef DEFO64
>   
>   static TCGv_i32 cpu_halted;
> -static TCGv_i32 cpu_exception_index;
>   
>   static char cpu_reg_names[2 * 8 * 3 + 5 * 4];
>   static TCGv cpu_dregs[8];
> @@ -81,11 +80,6 @@ void m68k_tcg_init(void)
>       cpu_halted = tcg_global_mem_new_i32(tcg_env,
>                                           -offsetof(M68kCPU, env) +
>                                           offsetof(CPUState, halted), "HALTED");
> -    cpu_exception_index = tcg_global_mem_new_i32(tcg_env,
> -                                                 -offsetof(M68kCPU, env) +
> -                                                 offsetof(CPUState, exception_index),
> -                                                 "EXCEPTION");
> -
>       p = cpu_reg_names;
>       for (i = 0; i < 8; i++) {
>           sprintf(p, "D%d", i);


