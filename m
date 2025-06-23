Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64630C77B7F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 10:07:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTe4a-0007zW-8G; Mon, 23 Jun 2025 06:06:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTe4Y-0007yy-7i
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 06:06:42 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTe4W-0005qq-Kb
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 06:06:41 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-71173646662so37249247b3.2
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 03:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750673199; x=1751277999; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Nt3sm8GY0gYw53ety0eK2MQ1IIUX822iA/TXsx9xzlM=;
 b=Gwzb9zQRzibUJYXyqhjA9O4wVMlztLC31+Ya3FlhBsnPxHb+PwZ5nZKEz6F3LgYk00
 x918cufIjHhLqL7HHnF1ZmR+vbptJQUz+CS+WrvXjJ2NWtDhZzjQBoihBgJwUFPw10sB
 us6Fl8oE5JmO/4P0O/wE6g5kUBsod+9v+b8ih2WUp9KYDHS1AQwvWUHaqy/Q3bbopDeT
 +URoZvhEDOMxk+BZ5N50RCECnn5s9KOMoqlFcl1VwFZZrZigkVQOUCD6nzTk3NBzUh7u
 ZlTI7TInN1dCJn6UQ4zu+OJSRN8gpXRFsv+SZboK8xHYHvK2p75FdqEXqTnnNNTqSlSy
 b85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750673199; x=1751277999;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Nt3sm8GY0gYw53ety0eK2MQ1IIUX822iA/TXsx9xzlM=;
 b=Ovr/pZbmEjNWrr1ElxzEkIuKk7eap6MOuHDZrG1/Vi88a8P71L13QLcnG7UZcKKCYY
 kcxkip+nrDMSv118rwbOtVHSFpETsuiT9a4rUOk6+3ILoMGymipx5zfCfxxayVp2GrNZ
 ylhzkuAfhTpo9oSqT+59jIsYZnBAk88N6ZnTLmSS9+sbaiu5LBhs/0IcPpxAKtjYe+YL
 M6Rt13cB3HhEei6J3P6QRYbMeAcNdu5g0swQ0I5FyW6X6syqn2ijMlbE49NF3euURyT4
 ef+KaVo6X+NwYOXEVV/l+r0L25F9UV2ARq5dLT+KnMhy66XMoavNn0Evj/xKUw4dk4gR
 vmIw==
X-Gm-Message-State: AOJu0YzD8mIpUG5STttYxzTbqFr9ZXcuGCixJ8vPB8tAPuk1jljMYieS
 kjxvXd99qj2Qc83e8Zas9O+/3oHUj5EwMzmQyKWMExWeuUQxeaXXaKCx68VShxI2M/nleeZs6ft
 jHqNP5b9D3M3ZT+l6xF9+U5yzCarc/fbW23khomnmfSgTZv3FtnuH
X-Gm-Gg: ASbGncspdPchu+h234uhvtNL81q2Rxwbq6J73hACs+fAiV3gEyGYeHJWlku8wnwIqus
 T7ThwDluIkAe6XRMnvuLQzkjP8E0dG1SNtYze2d9mQqBaoWAUuuY8NVUZSxD/2jyDu2fxRwsaFk
 1N6ikAc4li67JITuh6bgejtO8jjYuty9sb1RlTiaWOEy2xqa+jHsdotmU=
X-Google-Smtp-Source: AGHT+IESF8bLvBd+QsDwhiCxWSMykj+v76TlQpR7ysR7myUCqp28xuRAVqccFtVM8hqhqH6dDHRpLBCdxCvnKsW82TY=
X-Received: by 2002:a05:690c:23c2:b0:702:d85:5347 with SMTP id
 00721157ae682-712c67758afmr168019487b3.36.1750673199041; Mon, 23 Jun 2025
 03:06:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-5-richard.henderson@linaro.org>
In-Reply-To: <20250621235037.74091-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jun 2025 11:06:27 +0100
X-Gm-Features: AX0GCFvrxWuyOIOq0bdMCUXpiR8dC76GyqzeUddW4JhWHSfLfY6zIdq6SnpJzEs
Message-ID: <CAFEAcA-Zu8O6gGKdSUg57Sw0Q3VtfnQ5RnQWw0WDCKp3mietbA@mail.gmail.com>
Subject: Re: [PATCH v2 004/101] tcg: Add base arguments to check_overlap_[234]
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

On Sun, 22 Jun 2025 at 00:58, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/tcg-op-gvec.c | 55 ++++++++++++++++++++++++++---------------------
>  1 file changed, 31 insertions(+), 24 deletions(-)
>
> diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
> index c26cfb24cc..54304d08cc 100644
> --- a/tcg/tcg-op-gvec.c
> +++ b/tcg/tcg-op-gvec.c
> @@ -58,29 +58,34 @@ static void check_size_align(uint32_t oprsz, uint32_t maxsz, uint32_t ofs)
>  }
>
>  /* Verify vector overlap rules for two operands.  */
> -static void check_overlap_2(uint32_t d, uint32_t a, uint32_t s)
> +static void check_overlap_2(TCGv_ptr dbase, uint32_t d,
> +                            TCGv_ptr abase, uint32_t a, uint32_t s)
>  {
> -    tcg_debug_assert(d == a || d + s <= a || a + s <= d);
> +    tcg_debug_assert(dbase != abase || d == a || d + s <= a || a + s <= d);
>  }

This is now a looser check than the actual requirements, right?
(in that it's possible but wrong to specify overlapping
vectors via getting dbase and abase wrong). Might be worth
noting that in the comment.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

