Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D555EEE3698
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 15:51:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqYxc-0001R8-DO; Thu, 12 Feb 2026 10:50:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vqYxa-0001O1-3L
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 10:50:30 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vqYxX-00060H-Nh
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 10:50:29 -0500
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-4834826e5a0so34731805e9.2
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 07:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770911425; x=1771516225; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8h4LNHf/EiHoZAsr0uia6doykrKocQZsB0AtPAQ9oeg=;
 b=usC1EmI/cfVmxR5PXa0DZeuV/lu9TXJHWNpHlRWdh3OGb0VSzQ835JJCWY85zc0rZU
 +sPHSWHXPBR9LYrfMIIgaaU5LlOMw5eLmJ092LbikSkORRVK1Gwj4e4subEs4JGtS3ig
 E/F7sDe0JiRFw5n7UGtcxrysuIAlZuUIOch4iQdyAeFAQqIBaAYb0M4maH9T2e0Gc8uC
 LSRGSiKh9PyO9fmn2zZqSxjX77Fjl6Cqdt+OvGBUioATnNOZIawKtJ65mlNeyi+Wg5Bw
 Cpkgk9yVdSyLGvWIg8pf7MLcjJK1H9llJmQZ1/dWikpJQXsV8yRgkJTyeuSd4F1CkGBT
 y/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770911425; x=1771516225;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8h4LNHf/EiHoZAsr0uia6doykrKocQZsB0AtPAQ9oeg=;
 b=BvUQSmVb+eBj+o7U6jvodOVPlhWbhzJCDmy/fK7vKwPuaTcFbgemn8KAqzJ1Fs65YK
 W8duxzY7EcSEuHkCLEmJg8f2jyO3bNTVK1h4/YBeE8S+PgeXp0YKNuWQxfcGTADJhWzz
 X8vxl1D46fvSMLmi1o6bb5F2ZEjIfC9ziKwY0Fv0UfQ6wz+8lSbjUzKN511LeH5m4wxC
 zXLG/mAr141uYKH1WuhZXPlrwk6/3c2Qt1i9Z7NVV2Z0N0krfbbfBuECILg5V5F8OdqJ
 1dOZdDi9zcEDu53dZuxA2jLUJVAAq3SdGLwMv3S19vdavWdJpmUVQNF4OsRATJBucW0Z
 NGrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoIbvKC4yAxLWtm6Aykr9MtCHbHa741WgAGKPcDzYobpo1MNPC/PjVZvUaq3qyQf9c5u8Dmgu9DFvj@nongnu.org
X-Gm-Message-State: AOJu0YymZ1c9PlX01eocdXX7WKbZLJzpcrj/suLIUJkYk4sjrecLZiLp
 DSXlqQz25HnqiX+hEQLjOZNbWbVDbaqihw+MNGtvDlpYPO7kjIc0Ga6R891JUguKxBY=
X-Gm-Gg: AZuq6aIkjtfUxkJg1uvFDIwds7CC+MDCMQW3XkDl6Nmcs2Tub1P+9UpafhS6x68K+n/
 /t2LeDcOvam2gWH2sTazlssMwgJdMe2v/O93XejHQQqPBmeJdG/cI1U1yckgndhBWFEH7jWEM9j
 /ZkdWiYOKpHmjzYjJjFSVP+tAW3ZT/e6TRHLNzpXzcgcxTCh4qcYsAv20OcIdoJQYLSa+EW0wI4
 ab8Fwy9vKMUZPPfBA1xILnt18E50We+yi4B3gXG098/kyWs7NPYBEF/45Pklg3jOSx6QAupgyZ6
 RVzARIvUIiWFXpVMqE+QjCVg8eOc5fOCcFv1qNta/EjvIkOj/rvbpNrOHvDQijNL5p9rTIKN5y3
 fO8Gvnc5fXADZQ+SYhJKoVViF1T/qolZS0PA4cJq/mdMBuQJDWCRZnf5lgc2lkocEbydcqvo2YZ
 qstF59A50NKJUaa4jWPhoOiqKV4aol42DGrweAVvCalERgCJKt9ZNL11mYnHel1Fq5gEcL3007J
 rL+
X-Received: by 2002:a05:600c:470d:b0:483:54cc:cd89 with SMTP id
 5b1f17b1804b1-4836710d804mr42012635e9.9.1770911425424; 
 Thu, 12 Feb 2026 07:50:25 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d930902sm176590905e9.15.2026.02.12.07.50.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Feb 2026 07:50:24 -0800 (PST)
Message-ID: <8f01319f-b42d-48c9-bf23-821aeafb0bc6@linaro.org>
Date: Thu, 12 Feb 2026 16:50:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/ppc/translate: Fix TCG debug assert translating
 CLRBWIBC
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-stable@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Glenn Miles <milesg@linux.ibm.com>
References: <20260212150753.1749448-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260212150753.1749448-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x344.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 12/2/26 16:07, Peter Maydell wrote:
> The test case in the ppe42 functional test triggers a TCG debug
> assertion, which causes the test to fail in an --enable-debug
> build or when the sanitizers are enabled:
> 
> #6  0x00007ffff4a3b517 in __assert_fail
>      (assertion=0x5555562e7589 "!temp_readonly(ots)", file=0x5555562e5b23 "../../tcg/tcg.c", line=4928, function=0x5555562e8900 <__PRETTY_FUNCTION__.23> "tcg_reg_alloc_mov") at ./assert/assert.c:105
> #7  0x0000555555cc2189 in tcg_reg_alloc_mov (s=0x7fff60000b70, op=0x7fff600126f8) at ../../tcg/tcg.c:4928
> #8  0x0000555555cc74e0 in tcg_gen_code (s=0x7fff60000b70, tb=0x7fffa802f540, pc_start=4294446080) at ../../tcg/tcg.c:6667
> #9  0x0000555555d02abe in setjmp_gen_code
>      (env=0x555556cbe610, tb=0x7fffa802f540, pc=4294446080, host_pc=0x7fffeea00c00, max_insns=0x7fffee9f9d74, ti=0x7fffee9f9d90)
>      at ../../accel/tcg/translate-all.c:257
> #10 0x0000555555d02d75 in tb_gen_code (cpu=0x555556cba590, s=...) at ../../accel/tcg/translate-all.c:325
> #11 0x0000555555cf5922 in cpu_exec_loop (cpu=0x555556cba590, sc=0x7fffee9f9ee0) at ../../accel/tcg/cpu-exec.c:970
> #12 0x0000555555cf5aae in cpu_exec_setjmp (cpu=0x555556cba590, sc=0x7fffee9f9ee0) at ../../accel/tcg/cpu-exec.c:1016
> #13 0x0000555555cf5b4b in cpu_exec (cpu=0x555556cba590) at ../../accel/tcg/cpu-exec.c:1042
> #14 0x0000555555d1e7ab in tcg_cpu_exec (cpu=0x555556cba590) at ../../accel/tcg/tcg-accel-ops.c:82
> #15 0x0000555555d1ff97 in rr_cpu_thread_fn (arg=0x555556cba590) at ../../accel/tcg/tcg-accel-ops-rr.c:285
> #16 0x00005555561586c9 in qemu_thread_start (args=0x555556ee3c90) at ../../util/qemu-thread-posix.c:393
> #17 0x00007ffff4a9caa4 in start_thread (arg=<optimized out>) at ./nptl/pthread_create.c:447
> #18 0x00007ffff4b29c6c in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:78
> 
> This can be reproduced "by hand":
> 
>   ./build/clang/qemu-system-ppc -display none -vga none \
>      -machine ppe42_machine -serial stdio \
>      -device loader,file=$HOME/.cache/qemu/download/03c1ac0fb7f6c025102a02776a93b35101dae7c14b75e4eab36a337e39042ea8 \
>      -device loader,addr=0xfff80040,cpu-num=0
> 
> (assuming you have the image file from the functional test
> in your local cache).
> 
> This happens for this input:
> 
> IN:
> 0xfff80c00:  07436004  .byte    0x07, 0x43, 0x60, 0x04
> 
> which generates (among other things):
> 
>   not_i32 $0x80000,$0x80000
> 
> which the TCG optimization pass turns into:
> 
>   mov_i32 $0x80000,$0xfff7ffff             dead: 1  pref=0xffff
> 
> and where we then assert because we tried to write to a constant.
> 
> This happens for the CLRBWIBC instruction which ends up in
> do_mask_branch() with rb_is_gpr false and invert true.  In this case
> we will generate code that sets mask to a tcg_constant_tl() but then
> uses it as the LHS in tcg_gen_not_tl().
> 
> Fix the assertion by doing the invert in the translate time C code
> for the "mask is constant" case.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: f7ec91c23906 ("target/ppc: Add IBM PPE42 special instructions")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/ppc/translate/ppe-impl.c.inc | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/target/ppc/translate/ppe-impl.c.inc b/target/ppc/translate/ppe-impl.c.inc
> index 0a0590344e..1c27facb89 100644
> --- a/target/ppc/translate/ppe-impl.c.inc
> +++ b/target/ppc/translate/ppe-impl.c.inc
> @@ -424,11 +424,15 @@ static bool do_mask_branch(DisasContext *ctx, arg_FCB * a, bool invert,
>           shift = tcg_temp_new();
>           tcg_gen_andi_tl(shift, cpu_gpr[a->rb], 0x1f);
>           tcg_gen_shr_tl(mask, tcg_constant_tl(0x80000000), shift);
> +        if (invert) {
> +            tcg_gen_not_tl(mask, mask);
> +        }
>       } else {
> -        mask = tcg_constant_tl(PPC_BIT32(a->rb));
> -    }
> -    if (invert) {
> -        tcg_gen_not_tl(mask, mask);
> +        target_ulong mask_const = PPC_BIT32(a->rb);
> +        if (invert) {
> +            mask_const = ~mask_const;
> +        }
> +        mask = tcg_constant_tl(mask_const);
>       }

Nice.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


