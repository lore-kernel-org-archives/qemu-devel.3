Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3DCAC47258
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jan 2024 22:03:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSOqX-0007jl-U4; Tue, 23 Jan 2024 17:02:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rSOqW-0007jc-HE
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 17:02:16 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rSOqU-0004Ka-CA
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 17:02:16 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40ebf373130so10614985e9.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 14:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706047332; x=1706652132; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5GMlCtYcd5DKtcVSsp70f/t6mAB1i0SKsjFes3LHtOA=;
 b=FSn+ry1wq4dSenOPq3iLuMsuxvafIiADZGxhAlVsdg9njSKWTcPUbYGk3FESGwmNX9
 lA1dhoUWnTDlm24okNWdDxdNq6PxQvm/Zim5kQyxJknqTMOGQv5HNFOIxRDBBMDMaiVi
 jdIcQ+NYo8yHdaX0ZV7seLQBYBqrHUirMmnKCxAV4RwJRssaZ81YQC3WfIHxNqio2Sav
 r/SJs0KYskI5Prjj9JUjQPuyuHhXHvhLX8sLe5jcFj7QjGlCn2gU3oEiA+FBu56XMMLq
 C25/PQExwvW/q7+o9dXZ3mJm8yXaPFD3G6ez4Yu5XHwJXEkIrdbPNodTrRi5xfrKAo7z
 gYjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706047332; x=1706652132;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5GMlCtYcd5DKtcVSsp70f/t6mAB1i0SKsjFes3LHtOA=;
 b=qeSvmLDRNNQSkN+eo1vv6ZhqDFyHVVUhZcOVTLWJtsysXHNuVhdbAAB3PInl4zrhll
 W6ZhDQ5raEvN2GDeOnDfn3JME+2+xv6sUv+AuepOdcqpeUvxVyHcQUgoeVnPOM4m0B5J
 AW/dEuSLKBfFeUTvIapu7twmwX9HzXkWeZUS3RrWlFVZD1lPZHmGtqodB7AjNNTjw3rs
 KAK70c29Js9EbQBsJXq7jJk2f1G5Gbr8QyHUGHyTrU4S3BKW+rAWacjKlBLzopgD2nZE
 9ES7riS3BzNjttTcH/c+R42YMYS+0r+2+JBircjfSqsn1yBk+bbcE3p5L5u79CXa1qux
 XdLA==
X-Gm-Message-State: AOJu0YwqSnCFZY2Im5sIwYnYh3i6d+q2t2Vu9EZrOvWIzDnJj1IU+z7W
 bKfLzQly6zevFl5EWuLSPIYpMyO3xpluLiuLd/7XlSdOyHfU8Xb/vAWUJJ3TRpKC3MdosumKffV
 U
X-Google-Smtp-Source: AGHT+IG5HZa/khF/odvcggsQPacpHPqWAEtarPIeJN7NbEe22RVhIIL51Gz2YQLKW7apC+sPxMGVzw==
X-Received: by 2002:a05:600c:880f:b0:40e:44c2:6bc3 with SMTP id
 gy15-20020a05600c880f00b0040e44c26bc3mr926184wmb.142.1706047332409; 
 Tue, 23 Jan 2024 14:02:12 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 az8-20020a05600c600800b0040ebf626bfcsm2842497wmb.1.2024.01.23.14.02.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 14:02:12 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B89315F90B;
 Tue, 23 Jan 2024 22:02:11 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  richard.henderson@linaro.org
Subject: Re: [PATCH v2] cpu-exec: simplify jump cache management
In-Reply-To: <20240122153409.351959-1-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Mon, 22 Jan 2024 16:34:09 +0100")
References: <20240122153409.351959-1-pbonzini@redhat.com>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Tue, 23 Jan 2024 22:02:11 +0000
Message-ID: <87ede77lp8.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> Unless I'm missing something egregious, the jmp cache is only every
> populated with a valid entry by the same thread that reads the cache.
> Therefore, the contents of any valid entry are always consistent and
> there is no need for any acquire/release magic.
>
> Indeed ->tb has to be accessed with atomics, because concurrent
> invalidations would otherwise cause data races.  But ->pc is only ever
> accessed by one thread, and accesses to ->tb and ->pc within tb_lookup
> can never race with another tb_lookup.  While the TranslationBlock
> (especially the flags) could be modified by a concurrent invalidation,
> store-release and load-acquire operations on the cache entry would
> not add any additional ordering beyond what you get from performing
> the accesses within a single thread.
>
> Because of this, there is really nothing to win in splitting the CF_PCREL
> and !CF_PCREL paths.  It is easier to just always use the ->pc field in
> the jump cache.
>
> I noticed this while working on splitting commit 8ed558ec0cb
> ("accel/tcg: Introduce TARGET_TB_PCREL", 2022-10-04) into multiple
> pieces, for the sake of finding a more fine-grained bisection
> result for https://gitlab.com/qemu-project/qemu/-/issues/2092.
> It does not (and does not intend to) fix that issue; therefore
> it may make sense to not commit it until the root cause
> of issue #2092 is found.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  accel/tcg/tb-jmp-cache.h |  8 +++--
>  accel/tcg/cpu-exec.c     | 66 ++++++++++++++--------------------------
>  2 files changed, 28 insertions(+), 46 deletions(-)
>
> diff --git a/accel/tcg/tb-jmp-cache.h b/accel/tcg/tb-jmp-cache.h
> index bb424c8a05b..4ab8553afcc 100644
> --- a/accel/tcg/tb-jmp-cache.h
> +++ b/accel/tcg/tb-jmp-cache.h
> @@ -13,9 +13,11 @@
>  #define TB_JMP_CACHE_SIZE (1 << TB_JMP_CACHE_BITS)
>=20=20
>  /*
> - * Accessed in parallel; all accesses to 'tb' must be atomic.
> - * For CF_PCREL, accesses to 'pc' must be protected by a
> - * load_acquire/store_release to 'tb'.
> + * Invalidated in parallel; all accesses to 'tb' must be atomic.
> + * A valid entry is read/written by a single CPU, therefore there is
> + * no need for qatomic_rcu_read() and pc is always consistent with a
> + * non-NULL value of 'tb'.  Strictly speaking pc is only needed for
> + * CF_PCREL, but it's used always for simplicity.
>   */

I can follow the logic and soak testing seems to show its stable. So:

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

However I would note that TranslationBlock has the comment:

     * jmp_lock also protects the CF_INVALID cflag; a jump must not be chai=
ned
     * to a destination TB that has CF_INVALID set.

which I don't think holds true. It might be worth summarising the lock
requirements of TranslationBlock in a kdoc header.

>  struct CPUJumpCache {
>      struct rcu_head rcu;
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 67eda9865ee..40c268bfa1f 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -253,43 +253,29 @@ static inline TranslationBlock *tb_lookup(CPUState =
*cpu, vaddr pc,
>      hash =3D tb_jmp_cache_hash_func(pc);
>      jc =3D cpu->tb_jmp_cache;
>=20=20
> -    if (cflags & CF_PCREL) {
> -        /* Use acquire to ensure current load of pc from jc. */
> -        tb =3D qatomic_load_acquire(&jc->array[hash].tb);
> -
> -        if (likely(tb &&
> -                   jc->array[hash].pc =3D=3D pc &&
> -                   tb->cs_base =3D=3D cs_base &&
> -                   tb->flags =3D=3D flags &&
> -                   tb_cflags(tb) =3D=3D cflags)) {
> -            return tb;
> -        }
> -        tb =3D tb_htable_lookup(cpu, pc, cs_base, flags, cflags);
> -        if (tb =3D=3D NULL) {
> -            return NULL;
> -        }
> -        jc->array[hash].pc =3D pc;
> -        /* Ensure pc is written first. */
> -        qatomic_store_release(&jc->array[hash].tb, tb);
> -    } else {
> -        /* Use rcu_read to ensure current load of pc from *tb. */
> -        tb =3D qatomic_rcu_read(&jc->array[hash].tb);
> -
> -        if (likely(tb &&
> -                   tb->pc =3D=3D pc &&
> -                   tb->cs_base =3D=3D cs_base &&
> -                   tb->flags =3D=3D flags &&
> -                   tb_cflags(tb) =3D=3D cflags)) {
> -            return tb;
> -        }
> -        tb =3D tb_htable_lookup(cpu, pc, cs_base, flags, cflags);
> -        if (tb =3D=3D NULL) {
> -            return NULL;
> -        }
> -        /* Use the pc value already stored in tb->pc. */
> -        qatomic_set(&jc->array[hash].tb, tb);
> +    tb =3D qatomic_read(&jc->array[hash].tb);
> +    if (likely(tb &&
> +               jc->array[hash].pc =3D=3D pc &&
> +               tb->cs_base =3D=3D cs_base &&
> +               tb->flags =3D=3D flags &&
> +               tb_cflags(tb) =3D=3D cflags)) {
> +        goto hit;
>      }
>=20=20
> +    tb =3D tb_htable_lookup(cpu, pc, cs_base, flags, cflags);
> +    if (tb =3D=3D NULL) {
> +        return NULL;
> +    }
> +
> +    jc->array[hash].pc =3D pc;
> +    qatomic_set(&jc->array[hash].tb, tb);
> +
> +hit:
> +    /*
> +     * As long as tb is not NULL, the contents are consistent.  Therefor=
e,
> +     * the virtual PC has to match for non-CF_PCREL translations.
> +     */
> +    assert((tb_cflags(tb) & CF_PCREL) || tb->pc =3D=3D pc);
>      return tb;
>  }
>=20=20
> @@ -1012,14 +998,8 @@ cpu_exec_loop(CPUState *cpu, SyncClocks *sc)
>                   */
>                  h =3D tb_jmp_cache_hash_func(pc);
>                  jc =3D cpu->tb_jmp_cache;
> -                if (cflags & CF_PCREL) {
> -                    jc->array[h].pc =3D pc;
> -                    /* Ensure pc is written first. */
> -                    qatomic_store_release(&jc->array[h].tb, tb);
> -                } else {
> -                    /* Use the pc value already stored in tb->pc. */
> -                    qatomic_set(&jc->array[h].tb, tb);
> -                }
> +                jc->array[h].pc =3D pc;
> +                qatomic_set(&jc->array[h].tb, tb);
>              }
>=20=20
>  #ifndef CONFIG_USER_ONLY

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

