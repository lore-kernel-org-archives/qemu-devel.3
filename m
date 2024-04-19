Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45437C04FF6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 11:02:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxm0b-0001mI-9w; Fri, 19 Apr 2024 07:02:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxm0Y-0001ly-UD
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 07:02:18 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxm0W-0000MV-Lf
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 07:02:18 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-56e37503115so1683829a12.1
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 04:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713524534; x=1714129334; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZiXQsPQ9dWjSb4Y/GecdNlQyuKBTABOytO02l3aZ6ts=;
 b=HnOsQXlHpuTZMzxzfmCzKlPYicDVnlWcyoOC0bQAyNEESRj6Jmub3OwlTpJrJYLKFz
 I37HnWB3KVudLVUz9moEe1POUO2WnvbBIaSRKgSXm46RBDUvx2suRLowyZGmYvoRNpdI
 QyDj7ihGUECoA2rprNyndNs9d1zOkZ5H6Dq25cO5iiNTpr7Ko7Ky2Sd0Vtosu/OAXXpJ
 XaxBo7ToT6kVfrkXjrkSDA73qDYfgAt721ZKmnDHpkrkG/yfhdcJNtdu0XSJTnmAfOAj
 WdFQtOkp2zBLwgsKFp2bvYx6gw0gvdulPlX8rclHpUgs2FCpcnv6PmDz8al8jgG79uv4
 qpHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713524534; x=1714129334;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZiXQsPQ9dWjSb4Y/GecdNlQyuKBTABOytO02l3aZ6ts=;
 b=QNMM7qhrIBZajJVpLSCpQgUDJzF5K/NS81nlWZmR4ugV5NhP0xWaI0slaR+01yI2IU
 6cAcxAPbv7urTRikLigmGA+EQa7wqlvqfz30IQrWutoBs29Kk7YZlCMmOAdZr6W+XLO/
 OLg1OiDpR2EUDbo1gFyPYKvu71j73T4NwbOchpiOg5hNe4oweRMW9OkAmSFZhG6stIWw
 34kGcNCu9KThNXZrFHlBypzErYcAYl55wfwTT0xsyqN7q8oaMibdJjvU4agcKKokn8Jy
 GALm6nE+SXJcRi2rf+Ot3Z2Gp1xDVGSNAP6AFTemj7YPruMRok5VtiWZG9G02FnQnncy
 TJlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXg3xV+zXyXs2yBIa2RkUJLOx//a0AEYxassxgGZ8J4UZkCLI0rLWwCzf9lRRb/+LleFLi3xCrEO+47m9GUq0a4oUv+YTs=
X-Gm-Message-State: AOJu0YwkSReG4AiozKn89UKt/k8xEUkpRfXGZTTZeLH+EtPYRZGHrJtc
 sglonyV/2JddtjhO/9O3PNQELlBtvj8XjuCC17X1IIVnIl+Xkhf+IEhTsvCEfLU=
X-Google-Smtp-Source: AGHT+IEUuluAOL8Abbo56LkdYbT1ngZf7d0sGzniG+VKyI3NAc/HC3CZ0KohDqvAdWLAt1xLD2F08A==
X-Received: by 2002:a50:9b50:0:b0:571:bd88:e832 with SMTP id
 a16-20020a509b50000000b00571bd88e832mr1053557edj.41.1713524533818; 
 Fri, 19 Apr 2024 04:02:13 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.143.233])
 by smtp.gmail.com with ESMTPSA id
 h25-20020a0564020e9900b0056bc0c44f02sm1963768eda.96.2024.04.19.04.02.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Apr 2024 04:02:13 -0700 (PDT)
Message-ID: <ac907ce8-a91d-402f-ad30-2c0962d86f6c@linaro.org>
Date: Fri, 19 Apr 2024 13:02:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg: Fix the overflow in indexing tcg_ctx->temps
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?B?5aec5pm65Lyf?=
 <jiangzw@tecorigin.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, pbonzini <pbonzini@redhat.com>
References: <CAFEAcA_Q86TH19xZMT=gtRwL-ABook5NAFTgcGjfnfcqhgnwCw@mail.gmail.com>
 <5b29a661-1e37-4a90-8871-983d07094b69.jiangzw@tecorigin.com>
 <CAFEAcA82fjAT7Dh2x4i+UM3bvkWJpSCH8a-tH4KJc82_hfA-_A@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA82fjAT7Dh2x4i+UM3bvkWJpSCH8a-tH4KJc82_hfA-_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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

On 19/4/24 12:21, Peter Maydell wrote:
> On Fri, 19 Apr 2024 at 10:37, 姜智伟 <jiangzw@tecorigin.com> wrote:
>> Peter Maydell wrote:
>>> I feel like this might be a bug elsewhere. Can you provide
>>> a repro binary and command line?
>>
>> The test file has been attached with RISCV CBO instruction as the first instruction to execute, with command-line arguments as
>> ./build/qemu-system-riscv64 -M virt -smp 1 -nographic -bios crash_test.bin
> 
> It looks like you're building without --enable-debug. If you do
> that then you'll find that we hit an assert in the debug version
> of the function, which your patch doesn't touch:
> 
> #6  0x00007ffff4b90e96 in __GI___assert_fail
>      (assertion=0x55555639a508 "o < sizeof(TCGTemp) *
> tcg_ctx->nb_temps", file=0x5555563995d5 "../../tcg/tcg.c", line=1940,
> function=0x55555639c000 <__PRETTY_FUNCTION__.60> "tcgv_i32_temp") at
> ./assert/assert.c:101
> #7  0x000055555613104c in tcgv_i32_temp (v=0x0) at ../../tcg/tcg.c:1940
> #8  0x0000555555d0882b in tcgv_i64_temp (v=0x0) at
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/include/tcg/tcg.h:638
> #9  0x0000555555d0c17b in gen_helper_cbo_inval (arg1=0x2a8, arg2=0x0)
> at ../../target/riscv/helper.h:121
> #10 0x0000555555d7be65 in trans_cbo_inval (ctx=0x7fffef1c8e50,
> a=0x7fffef1c8cf0) at
> ../../target/riscv/insn_trans/trans_rvzicbo.c.inc:48
> #11 0x0000555555d41f4f in decode_insn32 (ctx=0x7fffef1c8e50,
> insn=8207) at libqemu-riscv64-softmmu.fa.p/decode-insn32.c.inc:2332
> #12 0x0000555555d925f1 in decode_opc (env=0x555556d53e30,
> ctx=0x7fffef1c8e50, opcode=8207) at
> ../../target/riscv/translate.c:1165
> #13 0x0000555555d92ab4 in riscv_tr_translate_insn
> (dcbase=0x7fffef1c8e50, cpu=0x555556d51670) at
> ../../target/riscv/translate.c:1236
> 
> This happens because we've been passed in 0 as our TCGv,
> which isn't valid. That in turn is because trans_cbo_inval()
> does:
>             gen_helper_cbo_inval(tcg_env, cpu_gpr[a->rs1]);
> but a->rs1 is 0.
> 
> The comment in riscv_translate_init() says:
>      /*
>       * cpu_gpr[0] is a placeholder for the zero register. Do not use it.
>       * Use the gen_set_gpr and get_gpr helper functions when accessing regs,
>       * unless you specifically block reads/writes to reg 0.
>       */
> 
> trans_cbo_inval() doesn't do either of those things, so that is
> where your bug is.

Our minds crossed =)

We need to use get_address() to get an address from cpu_gpr[],
since $zero is "special" (NULL).

I'm about to post this fix:

-- >8 --
diff --git a/target/riscv/insn_trans/trans_rvzicbo.c.inc 
b/target/riscv/insn_trans/trans_rvzicbo.c.inc
index d5d7095903..6f6b29598d 100644
--- a/target/riscv/insn_trans/trans_rvzicbo.c.inc
+++ b/target/riscv/insn_trans/trans_rvzicbo.c.inc
@@ -31,27 +31,27 @@
  static bool trans_cbo_clean(DisasContext *ctx, arg_cbo_clean *a)
  {
      REQUIRE_ZICBOM(ctx);
-    gen_helper_cbo_clean_flush(tcg_env, cpu_gpr[a->rs1]);
+    gen_helper_cbo_clean_flush(tcg_env, get_address(ctx, a->rs1, 0));
      return true;
  }

  static bool trans_cbo_flush(DisasContext *ctx, arg_cbo_flush *a)
  {
      REQUIRE_ZICBOM(ctx);
-    gen_helper_cbo_clean_flush(tcg_env, cpu_gpr[a->rs1]);
+    gen_helper_cbo_clean_flush(tcg_env, get_address(ctx, a->rs1, 0));
      return true;
  }

  static bool trans_cbo_inval(DisasContext *ctx, arg_cbo_inval *a)
  {
      REQUIRE_ZICBOM(ctx);
-    gen_helper_cbo_inval(tcg_env, cpu_gpr[a->rs1]);
+    gen_helper_cbo_inval(tcg_env, get_address(ctx, a->rs1, 0));
      return true;
  }

  static bool trans_cbo_zero(DisasContext *ctx, arg_cbo_zero *a)
  {
      REQUIRE_ZICBOZ(ctx);
-    gen_helper_cbo_zero(tcg_env, cpu_gpr[a->rs1]);
+    gen_helper_cbo_zero(tcg_env, get_address(ctx, a->rs1, 0));
      return true;
  }
---


