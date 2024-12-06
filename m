Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE46DE77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 12:42:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJXeG-0007ar-MK; Fri, 06 Dec 2024 07:41:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1tJXeC-0007aL-GD
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 07:41:28 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1tJXeA-0007Hm-UR
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 07:41:28 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-215909152c5so22419115ad.3
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 04:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733488885; x=1734093685; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8xbbbkeN0skqJj2tVItHbNSq7aCpwAlp8pAUpWgt96o=;
 b=IRv5Doa/nK//gqJZLICNS/ipryjrZ9IYh+o1SsVTqFGXiuc4qPiJTP9QUBNnBjlPxA
 CKy6rUHI4j/yaynanxtGeWaoSTUYRcYK5gEV7jlpw1qSDeSvL6bdIsQ1hMIMpBsFWuTR
 ZjVtoXPIkRMZDxAXCq+mChO9V++iNnTMdmv4YlxQdT2yPzvK5jcfFEAXkx8eXX87TB7d
 Gkd+qFobbETLAP6t02I/257eo0VpABtNWtqw4oseGivNlvJ8D+dBc7ZypqJMDLBbB9Hx
 jTcd+sT01pHC5FKOV0DScKTIIHeGRzxE9aqXdA57TJ+LpOiRc6kiH85ayhZv2TPRUDbD
 Q0nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733488885; x=1734093685;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8xbbbkeN0skqJj2tVItHbNSq7aCpwAlp8pAUpWgt96o=;
 b=VsdlFAyeMSSu4SvMYef7LrwUiwjSkNk5AIP89uf9iVfitXbHRpA0eNUsI119lMwIxT
 DkWJE3fwFfTh6YySdc8odXldRdRG21MhVA7TpHzVJpRn/C3U0x/3gtNlYMaKr7v+7pWk
 MO2ACdDOA8NlkOq1uFVOwTuYLxVikP6pLvqf8oT/ZVXiWxYx+akYFrkvfl/yZHahJCn3
 6Drom26C48zGTLbcNJmwlh3f0d6dX/wcP5W7a//CnYThHEyPyoZbV0XjP8ilU294lp0g
 +Xs5kjyAq1pAqtcMXJy1h9rdzRNjCc09Rt3Z746wtw33dAjypx7R+Ug2ylHdELcZlzuX
 MRgg==
X-Gm-Message-State: AOJu0Yw7YnXBGM6Sp4f6ScrBfyNj1i3MolekU46CEvbXSYf3658LQXIf
 YabP2GPcNVfYH0CMqpXXrX/bP8s3XR5QaRtUtde7ubJJVkCyUs784Mo3pEt9th3qatSoHtRSg6H
 ntDA8B4EMyIIBxPKaDVSRk0qCqsw2xQ==
X-Gm-Gg: ASbGncuErD1xbWhV4Yo6qDE+zi/6+4quACvRtC8yO/+v5bM0lbk02ZOpqae7oFqTL/t
 Qe4kry321t2xV5nukB7u4kBM8bUmzcw==
X-Google-Smtp-Source: AGHT+IExJhDpXVGQfwA1BfBHJ5gBewNa6hn5YvfS6gUb3zQ/6Dzi2RDsJvdYfGfrTriMK6fbsZBb37iky05m44Nzb+k=
X-Received: by 2002:a17:903:110c:b0:215:6f9b:e447 with SMTP id
 d9443c01a7336-21614db3f47mr45632415ad.30.1733488885488; Fri, 06 Dec 2024
 04:41:25 -0800 (PST)
MIME-Version: 1.0
References: <20241205232437.85235-1-philmd@linaro.org>
 <20241205232437.85235-3-philmd@linaro.org>
In-Reply-To: <20241205232437.85235-3-philmd@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri, 6 Dec 2024 04:41:36 -0800
Message-ID: <CAMo8BfKMhNd0C2HwL2aGAjPUZS8B7u8ncyW5PicswPns28SAmA@mail.gmail.com>
Subject: Re: [PATCH 2/2] target/xtensa: Remove tswap() calls in semihosting
 simcall() helper
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.828,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Dec 5, 2024 at 3:24=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
>
> In preparation of heterogeneous emulation where cores with
> different endianness can run concurrently, we need to remove
> the tswap() calls -- which use a fixed per-binary endianness.
>
> Get the endianness of the CPU accessed using the libisa
> xtensa_isa_is_big_endian() call and replace the tswap() calls
> by bswap() ones when necessary.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  target/xtensa/xtensa-semi.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/target/xtensa/xtensa-semi.c b/target/xtensa/xtensa-semi.c
> index fa21b7e11fc..21d23e39de5 100644
> --- a/target/xtensa/xtensa-semi.c
> +++ b/target/xtensa/xtensa-semi.c
> @@ -328,10 +328,17 @@ void HELPER(simcall)(CPUXtensaState *env)
>              struct timeval tv =3D {0};
>
>              if (target_tv) {
> +                bool cpu_big_endian =3D xtensa_isa_is_big_endian(env->co=
nfig->isa);
> +                bool swap_needed =3D HOST_BIG_ENDIAN !=3D cpu_big_endian=
;
> +
>                  cpu_memory_rw_debug(cs, target_tv,
>                          (uint8_t *)target_tvv, sizeof(target_tvv), 0);
> -                tv.tv_sec =3D (int32_t)tswap32(target_tvv[0]);
> -                tv.tv_usec =3D (int32_t)tswap32(target_tvv[1]);
> +                if (swap_needed) {
> +                    bswap32s(&target_tvv[0]);
> +                    bswap32s(&target_tvv[1]);
> +                }
> +                tv.tv_sec =3D (int32_t)target_tvv[0];
> +                tv.tv_usec =3D (int32_t)target_tvv[1];

This conversion looks a bit heavy. Maybe it would be better to
give tswap*() an additional env argument and give the target
a way to deal with it?

>              }
>              if (fd < 3 && sim_console) {
>                  if ((fd =3D=3D 1 || fd =3D=3D 2) && rq =3D=3D SELECT_ONE=
_WRITE) {
> @@ -381,6 +388,8 @@ void HELPER(simcall)(CPUXtensaState *env)
>              int argc =3D semihosting_get_argc();
>              int str_offset =3D (argc + 1) * sizeof(uint32_t);
>              int i;
> +            bool cpu_big_endian =3D xtensa_isa_is_big_endian(env->config=
->isa);
> +            bool swap_needed =3D HOST_BIG_ENDIAN !=3D cpu_big_endian;
>              uint32_t argptr;
>
>              for (i =3D 0; i < argc; ++i) {
> @@ -388,6 +397,9 @@ void HELPER(simcall)(CPUXtensaState *env)
>                  int str_size =3D strlen(str) + 1;
>
>                  argptr =3D tswap32(regs[3] + str_offset);

The tswap() is still here.

> +                if (swap_needed) {
> +                    bswap32s(&argptr);
> +                }
>
>                  cpu_memory_rw_debug(cs,
>                                      regs[3] + i * sizeof(uint32_t),

--=20
Thanks.
-- Max

