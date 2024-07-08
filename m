Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AFC0C3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 14:32:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQpOq-00007A-5g; Mon, 08 Jul 2024 10:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sQpOe-0008F3-Li
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 10:31:26 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sQpOc-0001sy-GA
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 10:31:16 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-58c2e5e8649so7465827a12.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 07:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720449071; x=1721053871; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1OKlewebdRdEbxTmajT78KBQ6FSBdR09yAPN/qa7eUc=;
 b=YIchKu0VayJqdHgYwlaA7n5faG2+tBNXQp/qC3xObLYOgI1Jd3JS/LWCYro5RK1d1s
 ySUqFPkG5eBiuZSQ0XvQ+X42OgaEVzbDu4YH5wu6yLTbPb5SenNgsSmkYC1WFljWPln7
 JVk/HuGLjEHiulwIlOf6ST+JZAgQNYdRawEQEDGkvk8OT101O7DJ4LMh2pBaZWCNOcAu
 OFZFHIUPjmNMVuR0kFWO6npm6AK+HuIuHuS+DIEfZDu2pQ5xpDDdALzVKjtbOIp7kBUY
 7LT10p97hVJuLNXl2WjsrZoOG9zRC6M382976m2DmW7Ysu2uAJaTj7GBdrFG1I2r1LLW
 ignA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720449071; x=1721053871;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1OKlewebdRdEbxTmajT78KBQ6FSBdR09yAPN/qa7eUc=;
 b=Wjw2iRZ1IaGNkCia8xQ+bUwKnrOV2ikc/7qnAdHyPwoOT49Iuv0oYKkkpPfEZW0H0P
 Je3BOXEulpUDv1wxtmo9rPPRHDDpyi19ufaRGBHVtqFLo1QtbkdjvCrZ2flVZOZN9a89
 /mG+OIYvGoQgogmw7PgW8Ezfu8CWL+PdIVklP8ehhzBVp/GYbuGL3hYDYrONoJjRQGOs
 Olz9FCQUL0buHURpUtU8mOEPbzpFRT8KQZV7fF0IvNOgSkn2ozQJwHjWJ1HBhupYCs1B
 4hhUcUGsLiz/JYuRuJ8Wa6h007H7iF+cFJ+2yvNwVemHs2Y7T/omO/gsO3Hup9/2aasg
 lyaw==
X-Gm-Message-State: AOJu0YyhavPtXZ5Z16+bgdUHcSGSlt1t77HrLAP48VVyH6S3GzgORLob
 KCcy5cHLouJz0bQWKJbCrZXjkh8GUPcAyLXI+8tu23jeF8EG5JpUzJYqPCDdutfTWPI60J4ax5O
 4NU5BAQqOLOePPxOqQf2bs5WKo7Z9pIUqs0DjCA==
X-Google-Smtp-Source: AGHT+IFfheZDdAWfHb0b0HlHFX19Bdt2r25h1XbTUK0uq/zlWLv/1Q3rczN/jAvXOMYm7MJhvIY19QlQ+os17NCmWNs=
X-Received: by 2002:aa7:d149:0:b0:57d:40e3:2a71 with SMTP id
 4fb4d7f45d1cf-58e7a94b244mr8128547a12.6.1720449070910; Mon, 08 Jul 2024
 07:31:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240702234155.2106399-1-richard.henderson@linaro.org>
 <20240702234155.2106399-2-richard.henderson@linaro.org>
In-Reply-To: <20240702234155.2106399-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jul 2024 15:31:00 +0100
Message-ID: <CAFEAcA_3Ayf-Eo4OHisewA+qgCWSF1S0Tn5aLrYy_3rF0ytStA@mail.gmail.com>
Subject: Re: [PATCH 1/2] accel/tcg: Introduce memset_ra, memmove_ra
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, 
 iii@linux.ibm.com, david@redhat.com, balaton@eik.bme.hu
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Wed, 3 Jul 2024 at 00:43, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Add wrappers that set and clear helper_retaddr around the
> host memory operation.  This cannot fail for system mode,
> but might raise SIGSEGV for user mode.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/exec/cpu_ldst.h | 40 ++++++++++++++++++++++++++++++++++++++++
>  accel/tcg/user-exec.c   | 22 ++++++++++++++++++++++
>  2 files changed, 62 insertions(+)
>
> diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
> index 71009f84f5..baf4f9367d 100644
> --- a/include/exec/cpu_ldst.h
> +++ b/include/exec/cpu_ldst.h
> @@ -379,4 +379,44 @@ void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
>                          MMUAccessType access_type, int mmu_idx);
>  #endif
>
> +/**
> + * memset_ra:
> + * @p: host pointer
> + * @c: data
> + * @n: length
> + * @ra: unwind return address
> + *
> + * Like system memset(p,c,n), except manages @ra for the calling
> + * helper in the event of a signal.  To be used with the result
> + * of tlb_vaddr_to_host to resolve the host pointer.
> + */
> +#ifdef CONFIG_USER_ONLY
> +void *memset_ra(void *p, int c, size_t n, uintptr_t ra);
> +#else
> +static inline void *memset_ra(void *p, int c, size_t n, uintptr_t ra)
> +{
> +    return memset(p, c, n);
> +}
> +#endif
> +
> +/**
> + * memmove_ra:
> + * @d: host destination pointer
> + * @s: host source pointer
> + * @n: length
> + * @ra: unwind return address
> + *
> + * Like system memmove(d,s,n), except manages @ra for the calling
> + * helper in the event of a signal.  To be used with the result of
> + * tlb_vaddr_to_host to resolve the host pointer.
> + */
> +#ifdef CONFIG_USER_ONLY
> +void *memmove_ra(void *d, const void *s, size_t n, uintptr_t ra);
> +#else
> +static inline void *memmove_ra(void *d, const void *s, size_t n, uintptr_t ra)
> +{
> +    return memmove(d, s, n);
> +}
> +#endif

I guess these make sense. I feel like they're a function where
the caller needs to be quite careful about what they're doing
(e.g. not to use them in a way that the memmove or memset
would cross a page boundary if other guest register state needs
to be kept in sync with the reported fault address), but I
can't think of a useful non-architecture-specific warning that
would be worth putting in the doc comments.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

