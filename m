Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 041C5CD6E57
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 23:12:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUukT-0007hh-Iq; Wed, 03 Jun 2026 19:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wUukR-0007gh-6g
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 19:11:43 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wUukO-0008Rz-JE
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 19:11:42 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-36ab8816a35so16465a91.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 16:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780528298; x=1781133098; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8ULEIIrTY92wCUqClxi0x+94M4v8ZLt4NXd0EcItNZQ=;
 b=J1WnNYUtqlKRxP0rjoL4BXItw9Pi5JDQRIo4s9cYXdPpMUMWWUhqErW/X73Z9+Wn5E
 LORhhs3WHOJJrOGY5KETTB4hXU4WDevGrgo8AmxpJGS9Vl8lMWtvyTIX+eTFP/hEXYd0
 JNZXqNmj3PRjpwojnWmwnNQZNUkL6EmXwUF5hCQYTLNa9K8ntYrfcCdjxPUfGaA/TKAX
 kXM06annaX6UqwN2TzaUUa+Qgcc/TE/2gvYqxYPKLachtijioxt2VDeNk4IGi/REQ+qn
 00nS73YUmqeif6h6fahsJqH+RHDoZ/Qo4CgRwimbEUAts1caUNgHjvlElxT8/L02pFxU
 PGBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780528298; x=1781133098;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8ULEIIrTY92wCUqClxi0x+94M4v8ZLt4NXd0EcItNZQ=;
 b=s8leC8EdCQrnjVpsHhTv1JNJ469tayCuRi52DvAzZYUFD4qJWRq70DAtaoAANhoNGO
 j0+i7hS3NvHwKrw4srmIhxUxC6bm1uCczMO5VW3MAXGZSilH0TSCFEoiL+0rYjA277D5
 pJLyd4DRIHqxJQwUdx61e5YxHqgh6vRdFlNgZwvEUa8jo/KbFjmCnL7JnvBGf7IJILr6
 OY+oPGJjtSbYt9Kd/gRpq69nI/4N6Mgj7tpXOfPyFJAab69kzQdX9BAP27Jsisve91bN
 LavSuqKypMM1QN5tim1FjRr938ACNLEHK2OLLbkm4zCPQjGGewDkxrLlJykI77Xhz2qN
 u2Tg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ObmSKQ6UeDhkkopNpljQNzG7k6IgKB4CHzxnULhtGO2pR/zlNqR6UxRTkZPTF5PPtnOw9sF7S43Uq@nongnu.org
X-Gm-Message-State: AOJu0YxfV4PHZ5OcmWOju8F3c+Y9urt3WqOZ3GwtnKJyWfPGNlujV3WJ
 Om8mYwsxCvvB1ipc4Dm6pV9GOT9K4uMENegY+XzwUwiU1uwLT1kkYw2304ZsI5mvMqU=
X-Gm-Gg: Acq92OGWiDD2eVxNE9Duk2KdS/avoFyaSSWqqtT2DMZnQwFvU8a1Kcyk1RfkOilpg7b
 m1cDrxNXHYKAMN/MhmNUf1swBurxJfJbdLRGSpz6LBETASBnJyeZXuBHVnEvm2MZBkNpw4zUo2c
 bO+FYhtlBQFG1DNvXc0RZ4bup33NJFWTYtaebhkj/CtCBr/YcUZbwzPyq+waAjZyn/ZqEs4z2c2
 Q4ZmowHgeEN1uRrNAqyb5ZwMcLuo1GNk5HYuBpDQHtSbSd9hmKmagm0pwAcY6N1vLNpg4Y7c/nj
 qVlOVd2/zaAt9AOLOlgo/ZeJ0hFnrO09ClAMvPhxNMTmZLLdOU1QBl2m9hxQScoUWj3+WCUeC6x
 1CHm2OH/+YxR7JW9yaCiZVuO+JvQ908N+/vDs9i6mbkRDrjnjtdu7tVGkulR9UxM/Pf8enTEpi4
 gY0AmjfAYv385Obv1DJsqiy9/RqVC5fu+HMjH3G6cU3dz7X4M=
X-Received: by 2002:a17:90a:c10e:b0:369:7421:75cf with SMTP id
 98e67ed59e1d1-36e32285a36mr5252032a91.16.1780528298273; 
 Wed, 03 Jun 2026 16:11:38 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36e702533fbsm2160832a91.2.2026.06.03.16.11.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2026 16:11:37 -0700 (PDT)
Message-ID: <afc76685-7cab-4be4-9736-7760719fe323@linaro.org>
Date: Wed, 3 Jun 2026 16:11:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg: Silence ubsan error on tcg_splitwx_diff causing
 overflow
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
References: <20260603223048.2574846-1-farosas@suse.de>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260603223048.2574846-1-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

On 6/3/26 15:30, Fabiano Rosas wrote:
> UBSAN complains:
> runtime error: addition of unsigned offset to 0x7bc06e1f5000
> overflowed to 0x7bc02e1f5000
> 
> Cast the pointer to unsigned integer to perform the arithmetic and
> silence the error.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>   tcg/region.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)

That's irritating. Does it work to make tcg_splitwx_diff be ptrdiff_t instead?


r~


> 
> diff --git a/tcg/region.c b/tcg/region.c
> index 5d4be1453b..b405fa2ecb 100644
> --- a/tcg/region.c
> +++ b/tcg/region.c
> @@ -112,7 +112,7 @@ const void *tcg_splitwx_to_rx(void *rw)
>       /* Pass NULL pointers unchanged. */
>       if (rw) {
>           g_assert(in_code_gen_buffer(rw));
> -        rw += tcg_splitwx_diff;
> +        rw = (void *)((uintptr_t)rw + tcg_splitwx_diff);
>       }
>       return rw;
>   }
> @@ -121,7 +121,7 @@ void *tcg_splitwx_to_rw(const void *rx)
>   {
>       /* Pass NULL pointers unchanged. */
>       if (rx) {
> -        rx -= tcg_splitwx_diff;
> +        rx = (void *)((uintptr_t)rx - tcg_splitwx_diff);
>           /* Assert that we end with a pointer in the rw region. */
>           g_assert(in_code_gen_buffer(rx));
>       }
> @@ -200,7 +200,7 @@ static struct tcg_region_tree *tc_ptr_to_region_tree(const void *p)
>        * a signal handler over which the caller has no control.
>        */
>       if (!in_code_gen_buffer(p)) {
> -        p -= tcg_splitwx_diff;
> +        p = (void *)((uintptr_t)p - tcg_splitwx_diff);
>           if (!in_code_gen_buffer(p)) {
>               return NULL;
>           }
> @@ -763,8 +763,9 @@ void tcg_region_init(size_t tb_size, int splitwx, unsigned max_threads)
>       /* Request large pages for the buffer and the splitwx.  */
>       qemu_madvise(region.start_aligned, region.total_size, QEMU_MADV_HUGEPAGE);
>       if (tcg_splitwx_diff) {
> -        qemu_madvise(region.start_aligned + tcg_splitwx_diff,
> -                     region.total_size, QEMU_MADV_HUGEPAGE);
> +        uintptr_t buf_rx = (uintptr_t)region.start_aligned + tcg_splitwx_diff;
> +
> +        qemu_madvise((void *)buf_rx, region.total_size, QEMU_MADV_HUGEPAGE);
>       }
>   
>       /*


