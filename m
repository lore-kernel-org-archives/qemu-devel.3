Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78040606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 15:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=pRrG+pwL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM5Gj-0004Rc-QA; Wed, 28 Oct 2026 11:08:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM5Gh-0004R1-DV
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 11:08:48 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM5Gf-0007xP-MV
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 11:08:47 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-8acda240937so9471017b3.3
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 08:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793200124; x=1793804924; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ahxXOebYtq0EX0IWJL9hvMd1jWkaKTZ6nbnZE2DQVGo=;
 b=pRrG+pwL1lrydkCJkj3Hc86BZ8A4gffMfSIJcS9dt4w7vOfDrZ5R+LkiAy4nKSsZ+v
 Zef/DbNvbStAIsP549izo992hy/CrKmFUqThIA+Yg5xTvC5F6XTezFnZBsh1faAtH2ux
 Jupvrp8sKL27BZ43XMb4tUjYrwPPueS2Dr9voW7+b0FMlj0tqFHuRHrgKasQ4CPSDe0t
 PK6KOf00cHu84VwEKyrZ9aDfh9uNupAcjdzwHKVzjTBRwysSXlMQa8mO7h7oHq68vhr0
 0Qa9rHZjURS6ORnmpN5fXcN/tNjUbyjnroZhiMpzlgm1a5NczzYOps50M8F83D8fYP6a
 gdLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793200124; x=1793804924;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ahxXOebYtq0EX0IWJL9hvMd1jWkaKTZ6nbnZE2DQVGo=;
 b=0aKYFNd/6yxmncBYgP5lqM7f8yxiFfGNQAJA/CsPVj7+7/uR9wnPSK2GFPr3jeGW8k
 xzKzaGd/T1em31JJ1VX1Pq9ozAumzyeBktVe8XLpMZd3cXMK2ulo1xesn+4AtkEShHUM
 HLpFGAu6P05o9RD+xGIj92qcxypZSol/Mao/51qOZXawGz01Y5Vz/tTe9a1rauBriiYx
 X3sFOWgE7j7VeXsNwNr8T3dBtFfjl+wn1dp8KTmjns0g5i2Pzp+dWP5Imm2jGDdYvKzJ
 NkYW5/2i1YnselT3us+IfzWSNT8Wdvzx1WGBrJdgFNK31RAztLSxBEgylyAJgf/u20a3
 h+pw==
X-Forwarded-Encrypted: i=1;
 AKwUvByJtBLWfs25u9PJ0vfzi85fX7b53wGEVp0K3Oco9uvjDToL/MRl1AKj73P6uSACl0Hn5L93E9xBIWJv@nongnu.org
X-Gm-Message-State: AFq9FYJnDSGKUkoi863tqYo8OYDeXc78ex0/SOvJGgAwkpQBYbeWjMdX
 fTjnYp8rOixnmdPqhhgA+WPB89L0TEsvHic1Q6MPQrGAiTUCeAVQ2imQEE6rL+LNQao=
X-Gm-Gg: AYBFou20uk3BL0c5S7bokak9+1+vv6eeSfVTwlNvgbRAsyij85LAh1uTpRZW194SpDx
 xheZ8cTPV9z1P8x8GpCLTuQk/lRpKtTpPtFtYo1dcHdR0j4pytNB0CshXEKQnGbJSKSa94oPILq
 vxYCLUc4/6CBEbWFXQXvSAzFkkfnrSc2VuzXohC+lsYdLojYC4xnHSfxK1Ub2eXwYGMgIiwjIul
 U+PL1xPonnRODN2MNAia+3LCup3Iodp/D6+9/e2htP4PNrRwZq63HYNlVgy9FGJ1CZAV1WY+bPC
 T/lIPnQrG+fMK+nFvnNa0fiOBlptwZWSt+UrRqr0RYALhXsxd4tPXPv8VYj0Wr+o3RMb6DtbGB5
 4TzvIEL6kyhMwegtv7KlrgzfE/fExB7V1JepYpeilaiN77VXud8a2z1ZT+wWFa65aaUtq4gHKxu
 A+9dPohv5F41+lZi742k9Hetr10cbYL54j98IaXFfgOUnyVgTnMpnpRAen/kCTZSpV4RP2Z9pPU
 62h2AFf4fDVanC99smk0uz4XMWATKMhEXcMiaL+3rKq4VQx3N+qfisFRn6mfm5T1KzGblhNQ/Id
 0xdrExc30mB6TFd9Hoq2i5A1SCOrR6EQduiGjPw5QNTl0RqylBtpNKvPv8GKhvzuhPVJ2IIpPce
 esdt3Oco4Mtw=
X-Received: by 2002:a05:690c:e010:10b0:8b0:d978:db65 with SMTP id
 00721157ae682-8b1c4b87837mr1918457b3.25.1793200123660; 
 Wed, 28 Oct 2026 08:08:43 -0700 (PDT)
Received: from ?IPV6:2607:fb91:2c2e:8a8c:60fa:827:925e:3bb6?
 ([2607:fb91:2c2e:8a8c:60fa:827:925e:3bb6])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b19e2bd279sm29678907b3.0.2026.10.28.08.08.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 08:08:43 -0700 (PDT)
Message-ID: <d767b8b4-435a-4a68-a140-da163cdc5ee9@linaro.org>
Date: Wed, 28 Oct 2026 10:08:41 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/tcg/cpu-exec.c: Fix false awakening of gdb
To: Aleksandr Sergeev <sergeev0xef@gmail.com>, qemu-devel@nongnu.org
References: <20261028072308.839836-1-al.sergeev@syntacore.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261028072308.839836-1-al.sergeev@syntacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x1134.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/26 02:23, Aleksandr Sergeev wrote:
> From: Aleksandr Sergeev <sergeev0xef@gmail.com>
> 
> In qemu there is a mechanism to cancel execution of tb.
> If `cpu->neg.icount_decr` is <0, translation block
> will exit in prolog.
> E.g. such may happen when RCU thread kicks out vCPU.
> 
> If tb is not executed, we shall not raise EXCP_DEBUG,
> because no step actually happened.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4766
> Signed-off-by: Aleksandr Sergeev <sergeev0xef@gmail.com>
> ---
>   accel/tcg/cpu-exec.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 9ead35418d..4497701486 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -478,16 +478,16 @@ cpu_tb_exec(CPUState *cpu, TranslationBlock *itb, int *tb_exit)
>                            last_tb->tc.ptr, pc, lookup_symbol(pc));
>               }
>           }
> -    }
> -
> -    /*
> -     * If gdb single-step, and we haven't raised another exception,
> -     * raise a debug exception.  Single-step with another exception
> -     * is handled in cpu_handle_exception.
> -     */
> -    if (unlikely(cpu_single_stepping(cpu)) && cpu->exception_index == -1) {
> -        cpu->exception_index = EXCP_DEBUG;
> -        cpu_loop_exit(cpu);
> +    } else {
> +        /*
> +         * If gdb single-step, and we haven't raised another exception,
> +         * raise a debug exception.  Single-step with another exception
> +         * is handled in cpu_handle_exception.
> +         */
> +        if (unlikely(cpu_single_stepping(cpu)) && cpu->exception_index == -1) {
> +            cpu->exception_index = EXCP_DEBUG;
> +            cpu_loop_exit(cpu);
> +        }
>       }
>   
>       return last_tb;

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

And queued to tcg-next.

r~

