Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53729606A31B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 17:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=PX4zYdnV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKIht-0005dK-MY; Fri, 23 Oct 2026 13:05:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xKIhj-0005bo-HC
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 13:05:20 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xKIhh-00074h-Hk
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 13:05:19 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-48df8fe8513so1008466f8f.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 10:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792775116; x=1793379916; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=VztnXkD+QJJMlGA5XGCIdtYhsET5JcvF4e0XDOQo5q4=;
 b=PX4zYdnVdTY/Lo4IRskNVkbItP11cZ3EGBdfNfFcHHtrFqKxVrdxHXIxrbocD34kXu
 crBN1DLGYIdI7GrruD3rKIcpFWrYTq8zfncbn75YSWQ19Umr4K/KvPGJtPNwXh8E5tKN
 2ON6r0FT3nch+NrAg/klha1po9re+BQ3H7KjibK9FAtvG7UKFIYxVajhjQPBWniSNrqw
 zIUl57N+9D2OwWxRzpyVgnsHHY5z9eNFOKKMLXouzexE2itWZCrzZBzP/4uuTPsXQsQR
 +NifGEVq76snxjXGjpNkLp7e2A4TYhi31ecggXq7q+ZbqUZy4MaI6iovOhT3laKvyY6n
 FKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792775116; x=1793379916;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VztnXkD+QJJMlGA5XGCIdtYhsET5JcvF4e0XDOQo5q4=;
 b=jgl0MAY0NvXQfq50kgkyylRsvXZa4XofsZsc5ETpYZ9WW5h6epXFLSLhJJ5+xl0miW
 EpLMMXFgG/f7L9tUACsEYFzkdEutv9vv8xC1m5d78ySD4FXiNVWwLShGHcx1qteQE09n
 D5QRnMougs0Th7EZCy2b9MrjS7VnUlRniENnVG0Lyu+nAmICFzyEwTseb7VntRnLLPAt
 nxkCz9Qo7Nj0lNkRzxwnU46/dfX5Qu+GKveeIZrsntNWG4RCi0ONR8+W/ePeBfpgVUNT
 I0SrTW1GpBiwqmo8buAZdE1UsDEiHS5RmwbzS80gR1Eajj8YvUJHsZixlgdIMd6HdfrL
 kL4w==
X-Gm-Message-State: AFq9FYL5JEKtteHIeRltAJLEa9k06DI/3WX4bLUN2Fo4mPdzg1lx/6Bv
 Pi5uehtahsz7o039xS5mqKhTu5D95TYHDqkf12dJM+UCPqButWvHxdxXvL7NLnGeS4Q=
X-Gm-Gg: AYBFou19x/ckVh61cXbtbNyBDCjrHlpvGHwZeXZhfQKAcCpz+Z7OuTLhmmWsxkU7ZRE
 es7oBdQNN3HPwIXMNFPFaxStdKEfq5SrPIq0IPlzPtsAsK9gVUOYC501Yhw6GpikgiiD2kLhha4
 rIkfsl4Vo6N02WQz8nKd1/r1bl0CxeYSCep+30APpoMVY3mGot2PdQhU2YGSaqpG6DFsyH9y4U3
 /44tLXS89AwNU8pSRr7+heW/imXns4fKGU3WVT099TzngSGZu+c5MO34FEakZu9HE9evNEGJVwH
 RvmYNTSwgN5Llv2448WTvNhG1923XE3Q1wDtG5oPPixMgcJtSEd2H7vviGXyqhBCIkLKs3raWs2
 MlyOrfqmImTiLhnffeEcJQWGjVHD9FL3oMVJnIZmUS8O2hSZg0sUCHuMQGeuFDGVbzJkO/fRsny
 UA26GMSIUwhAanscZFOXQM7H67dLoWYGxCxsKD7C7oui/Ge3RsaJbQ/6AfXsVUGDpp3FCGww9XC
 WkL9ob/1FETP68FQhN3MCRouz1zF6+/UQaxIWFOQU2plJQkkhQWyTs=
X-Received: by 2002:a05:6000:25ec:b0:48e:3085:425f with SMTP id
 ffacd0b85a97d-48e38546d14mr5329205f8f.2.1792775115672; 
 Fri, 23 Oct 2026 10:05:15 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d42221fsm898388f8f.49.2026.10.23.10.05.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 10:05:14 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1055B5F894;
 Fri, 23 Oct 2026 18:05:14 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stian Halseth <stian@itx.no>
Cc: qemu-devel@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 Matt Turner <mattst88@gmail.com>
Subject: Re: [PATCH] accel/tcg: Do not chain from a TB freed by
 tb_gen_code's flush
In-Reply-To: <20261023113245.562358-1-stian@itx.no> (Stian Halseth's message
 of "Fri, 23 Oct 2026 13:32:45 +0200")
References: <20261023113245.562358-1-stian@itx.no>
User-Agent: mu4e 1.14.4; emacs 30.1
Date: Fri, 23 Oct 2026 18:05:14 +0100
Message-ID: <8733tws5yt.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Stian Halseth <stian@itx.no> writes:

> In a serial context, tb_gen_code() flushes a full code buffer and
> retries in place. cpu_exec_loop() then chains its last_tb, now freed,
> into the new TB. When that TB is invalidated, tb_jmp_unlink() follows
> the stale entry and qemu crashes inside its SIGSEGV handler.

I wonder how much:

        /* flush must be done */
        if (cpu_in_serial_context(cpu)) {
            trace_tb_gen_code_buffer_overflow("tcg_tb_alloc");
            tb_flush__exclusive_or_serial();
            goto buffer_overflow;
        }

actually saves? Because we are skipping both cleanup in cpu_loop_exit
(the mem helpers) and cpu_exec_longjmp_cleanup which we get to when we
jump out.

>
> Drop last_tb when tb_gen_code() has flushed.
>
> User-only builds hit this easily since cross-page goto_tb chaining,
> e.g. qemu-sparc64 -tb-size 1 on a program writing next to its PLT.
>
> Fixes: ebf7a5d294a3 ("accel/tcg: Improve buffer overflow in tb_gen_code")
> Fixes: 25e5c6a320db ("accel/tcg: Allow cross-page goto_tb chaining in use=
r-only builds")
> Signed-off-by: Stian Halseth <stian@itx.no>
> ---
> 25e5c6a320db is not in a release yet (v11.1.x does not have it), so the
> crash is new in the 11.2 cycle.
>
> Reproducers available on request: on x86_64 the stale chain happens
> too but has stayed harmless; on sparc64 it crashes every time.
>
>  accel/tcg/cpu-exec.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 5b4bca5084..600e8c5fa8 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -968,11 +968,17 @@ cpu_exec_loop(CPUState *cpu, SyncClocks *sc)
>              if (tb =3D=3D NULL) {
>                  CPUJumpCache *jc;
>                  uint32_t h;
> +                unsigned flush_count =3D qatomic_read(&tb_ctx.tb_flush_c=
ount);
>=20=20
>                  mmap_lock();
>                  tb =3D tb_gen_code(cpu, s);
>                  mmap_unlock();
>=20=20
> +                /* tb_gen_code may have flushed, freeing last_tb. */
> +                if (flush_count !=3D qatomic_read(&tb_ctx.tb_flush_count=
)) {
> +                    last_tb =3D NULL;
> +                }
> +
>                  /*
>                   * We add the TB in the virtual pc hash table
>                   * for the fast lookup

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

