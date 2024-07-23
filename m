Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F7F9C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 17:10:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWJ1J-0000oe-He; Tue, 23 Jul 2024 13:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1sWJ1I-0000nb-B6
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 13:09:48 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1sWJ1G-00078q-AB
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 13:09:47 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2cd48ad7f0dso1803546a91.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 10:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721754584; x=1722359384; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gDkXEieNrpjksULZ6LiACCuQz6qVE4kM6ONB4xImeXM=;
 b=WtscTS67X1z27VRISsbnwH1Ek0NNr8Fj/kh1FKT9imMUU2n5QeqjSS2yII152EP5p1
 DLUbe3YX8MecTB+S23PCs8BbgavfE+QT5lLjSwUddZ/b4qGmMmwkUHzp7BZfdcBbe5r1
 Y4BGZv8jOIyWk5Sh0omz7GS1cobtO7AUbwrgGKEQovmoW1X8aRiDYRMFGdHx7WMCZjLj
 uA4PgEb1mJOtcjCnD8TUeurgriBYZ1VacQ9Eo6lyrtu9CS2Z2zlbHGDi6BoKx6cQmIjG
 2AOgXm/DTgXsOqANAPWq7qGydxX6yMCkfl60Rxh0lJUGe6rh3ixJh5cXM2cXXqEFd4Xj
 SNhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721754584; x=1722359384;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gDkXEieNrpjksULZ6LiACCuQz6qVE4kM6ONB4xImeXM=;
 b=O21+z+YZr3Fk7DJnNsU/DRrSU92f4GaOX81UV4HkXXcQ13CJHi7sh6bIO3gU3yg8lp
 gFemz9GXIhvsWo4TlHCCeGy8j7Czel/xG+/IO5dkTF33h0KomEQ4GXQ8Qb40WHFvNugk
 yO0mzsMK7UzAT0Vb6gOBkpDeIrwPs6DnVJiFL6/fuHNXdLLz7zfv0DRXJ7CdTQdLQXGq
 13haRKvVJvUOhmQjRCjUpD/qdE/yBUP8f88h39SCozGMu8rOOUfDnJAquCRf2GSZahA+
 nOmcDZ4xi9qv6E5lQ2M71U5gqzlnW96vCOuZoHsvW1BynHSYNY97Etui3XLgL7CFeUNu
 norw==
X-Gm-Message-State: AOJu0YyahDHhXSyL7X1/GzKEBnQCIM1ZMe6/AwUvRPWP23XnJEHhVY8K
 tGW5KPvgQa2aS8JqM0GnZ+C5U23DsUuLbpbU6GC2wu+ZBQSpTmwNv23GfrDLBx1uu2kppdMqEYj
 QhWVgETXPCf7bZVjjeAxb6oFG8Hk=
X-Google-Smtp-Source: AGHT+IG4+UYdpKH/Jo1KMNGWnNT0S/R9+SyuDeWr6jCKk7tlGSKHKm+uRtsMwJydsxGhxRrpKf9zJII/p96ograTo6k=
X-Received: by 2002:a17:90b:17ca:b0:2c2:f2d6:60d4 with SMTP id
 98e67ed59e1d1-2cdae2ec16bmr391452a91.8.1721754584461; Tue, 23 Jul 2024
 10:09:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240723151454.1396826-1-peter.maydell@linaro.org>
In-Reply-To: <20240723151454.1396826-1-peter.maydell@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 23 Jul 2024 10:09:33 -0700
Message-ID: <CAMo8BfL_1CsSVbi66rhR=RTSFyVgOwZqEZfUv4tc=EqvTYjmNA@mail.gmail.com>
Subject: Re: [PATCH] target/xtensa: Make use of 'segment' in pptlb helper less
 confusing
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001,
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

On Tue, Jul 23, 2024 at 8:14=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> Coverity gets confused about the use of the 'segment' variable in the
> pptlb helper function: it thinks that we can take a code path where
> we first initialize it:
>   unsigned segment =3D XTENSA_MPU_PROBE_B;  // 0x40000000
> and then use that value as a shift count:
>   } else if (nhits =3D=3D 1 && (env->sregs[MPUENB] & (1u << segment))) {
>
> In fact this isn't possible, beacuse xtensa_mpu_lookup() is passed
> '&segment', and it uses that as an output value, which it will always
> set if it returns nonzero.  But the way the code is currently written
> is confusing to a human reader as well as to Coverity.
>
> Instead of initializing 'segment' at the top of the function with a
> value that's only used in the "nhits =3D=3D 0" code path, use the
> constant value directly in that code path, and don't initialize
> segment.  This matches the way we use xtensa_mpu_lookup() in its
> other callsites in get_physical_addr_mpu().
>
> Resolves: Coverity CID 1547589
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/xtensa/mmu_helper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/xtensa/mmu_helper.c b/target/xtensa/mmu_helper.c
> index 997b21d3890..29b84d5dbf6 100644
> --- a/target/xtensa/mmu_helper.c
> +++ b/target/xtensa/mmu_helper.c
> @@ -991,7 +991,7 @@ uint32_t HELPER(rptlb1)(CPUXtensaState *env, uint32_t=
 s)
>  uint32_t HELPER(pptlb)(CPUXtensaState *env, uint32_t v)
>  {
>      unsigned nhits;
> -    unsigned segment =3D XTENSA_MPU_PROBE_B;
> +    unsigned segment;

The change suggests that coverity is ok with potentially using
uninitialized value in the shift, but not with the value that would
definitely make the shift illegal, which is a bit odd.

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

>      unsigned bg_segment;
>
>      nhits =3D xtensa_mpu_lookup(env->mpu_fg, env->config->n_mpu_fg_segme=
nts,
> @@ -1005,7 +1005,7 @@ uint32_t HELPER(pptlb)(CPUXtensaState *env, uint32_=
t v)
>          xtensa_mpu_lookup(env->config->mpu_bg,
>                            env->config->n_mpu_bg_segments,
>                            v, &bg_segment);
> -        return env->config->mpu_bg[bg_segment].attr | segment;
> +        return env->config->mpu_bg[bg_segment].attr | XTENSA_MPU_PROBE_B=
;
>      }
>  }
>
> --
> 2.34.1
>


--=20
Thanks.
-- Max

