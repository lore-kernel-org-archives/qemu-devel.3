Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D73FC48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 17:49:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb2KY-0006aj-Sy; Fri, 16 Feb 2024 12:48:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rb2KX-0006aD-3s
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 12:48:57 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rb2KV-0000zz-Dh
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 12:48:56 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-41243d19ecaso6007035e9.3
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 09:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708105734; x=1708710534; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=phveRhLH/DN46qDhyo9X86tVQLN6imc/KnF7N0eMjyU=;
 b=VF2nUIxgKvSIgt+p0HCwj/ejPKfPJkg0shq6jPiW3TqAfbMMkXBYnAxHtVnuCxB+fS
 1tCNsCx1G24+yqLySszdK4Rz9tQ/RYnnDM0dUxMNlSbMTcK4JhJ1vdTMXEB7Ce+fjoSq
 6RLkhXlFiAvd9oFi7HajEhGHyVLCXX1E5pi1dKRjM+gNTeaAvlLiWLwWHT1SLHTUHBNG
 mcdJcRUr5NbC9U6gnNvzSngGe6hiOHViI0/jdK91rr9YZwLs4eeWYsHxKNIfWh7dsjDF
 7X56FHzzeIWkANlpXg3mnEq48KLbaAeJJgThHVuRCEhm6tM34SkzQfwYuk87ctX1+Iyb
 g6LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708105734; x=1708710534;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=phveRhLH/DN46qDhyo9X86tVQLN6imc/KnF7N0eMjyU=;
 b=EoLTet4ye21acIBQ3z+ZZQqqUEl0QVwC0hIPZlJyE7Vku6Ru3gyeoYUSB3tkBxt8gQ
 xzt+ZdU4daNQ6+h4z/h3r9wzSbRwSz2rVeVVDv6+nDTuTE505LunjXIWSokrol5oWB2M
 e0r29RuzNxbonV0Oji2l+LgIlFkiCzsZ3JUmvTV5EQHIqhSDSBz4x5Bk5PKtb1rkGhhF
 lVeABEfFaDNrYOU3FO8M79PryRB1RQ4Lr6C7IPzBHHKRo4osi9XfsPac7LTswYr/aBj7
 SzkSWSAeNtjF6v153wVow7jQJ+ZtdswHbCRf/6NtX85Ih5RdEZiVrDofub0GVpfndBed
 jpXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRGjZgBet059ZJngUKp60soZh/p+Al2wXLgw779gbYFouPLksmIaGH54uFs9A2D5RnNraUd+8LzFR2nfJtRaVNFE6ieUc=
X-Gm-Message-State: AOJu0YxDVoha7ZCEkEIETkpkm5e+JFw16FTy7KW+LB5ihXy89bZfaMZ9
 i8249860L23CQ+ThiV4TxO4zNa2purysvCpvs7yTjAAxxhUvesTWTKKvF1Zhkoo=
X-Google-Smtp-Source: AGHT+IEbz1q2b0901SaI5ksQrfeQGfAVObCcWWO5H7/HZS+ErFN5aajiQZyc6kZbGCpVyV4PKxu7vA==
X-Received: by 2002:a5d:6810:0:b0:33d:10bd:fad9 with SMTP id
 w16-20020a5d6810000000b0033d10bdfad9mr3576411wru.17.1708105733793; 
 Fri, 16 Feb 2024 09:48:53 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 b4-20020a05600003c400b0033d22852483sm1525229wrg.62.2024.02.16.09.48.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 09:48:53 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2387A5F83F;
 Fri, 16 Feb 2024 17:48:53 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Laurent Vivier <laurent@vivier.eu>,  Warner Losh <imp@bsdimp.com>,  Kyle
 Evans <kevans@freebsd.org>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 04/11] {linux,bsd}-user: Pass pid to fork_end()
In-Reply-To: <20240216130817.369377-5-iii@linux.ibm.com> (Ilya Leoshkevich's
 message of "Fri, 16 Feb 2024 14:05:31 +0100")
References: <20240216130817.369377-1-iii@linux.ibm.com>
 <20240216130817.369377-5-iii@linux.ibm.com>
User-Agent: mu4e 1.11.28; emacs 29.1
Date: Fri, 16 Feb 2024 17:48:53 +0000
Message-ID: <87il2o2tbu.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

Ilya Leoshkevich <iii@linux.ibm.com> writes:

> The upcoming follow-fork-mode child support requires knowing the child
> pid. Pass it down.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  bsd-user/freebsd/os-proc.h  | 6 +++---
>  bsd-user/main.c             | 4 +++-
>  bsd-user/qemu.h             | 2 +-
>  linux-user/main.c           | 4 +++-
>  linux-user/syscall.c        | 6 +++---
>  linux-user/user-internals.h | 2 +-
>  6 files changed, 14 insertions(+), 10 deletions(-)
>
> diff --git a/bsd-user/freebsd/os-proc.h b/bsd-user/freebsd/os-proc.h
> index d6418780344..3003c8cb637 100644
> --- a/bsd-user/freebsd/os-proc.h
> +++ b/bsd-user/freebsd/os-proc.h
> @@ -208,7 +208,7 @@ static inline abi_long do_freebsd_fork(void *cpu_env)
>       */
>      set_second_rval(cpu_env, child_flag);
>=20=20
> -    fork_end(child_flag);
> +    fork_end(ret);
>=20=20
>      return ret;
>  }
> @@ -252,7 +252,7 @@ static inline abi_long do_freebsd_rfork(void *cpu_env=
, abi_long flags)
>       * value: 0 for parent process, 1 for child process.
>       */
>      set_second_rval(cpu_env, child_flag);
> -    fork_end(child_flag);
> +    fork_end(ret);
>=20=20
>      return ret;
>=20=20
> @@ -285,7 +285,7 @@ static inline abi_long do_freebsd_pdfork(void *cpu_en=
v, abi_ulong target_fdp,
>       * value: 0 for parent process, 1 for child process.
>       */
>      set_second_rval(cpu_env, child_flag);
> -    fork_end(child_flag);
> +    fork_end(ret);
>=20=20
>      return ret;
>  }
> diff --git a/bsd-user/main.c b/bsd-user/main.c
> index bfe6888ea89..bc233a85cef 100644
> --- a/bsd-user/main.c
> +++ b/bsd-user/main.c
> @@ -109,8 +109,10 @@ void fork_start(void)
>      gdbserver_fork_start();
>  }
>=20=20
> -void fork_end(int child)
> +void fork_end(abi_long pid)
>  {
> +    int child =3D pid =3D=3D 0;
> +
>      if (child) {
>          CPUState *cpu, *next_cpu;
>          /*
> diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
> index dc842fffa7d..2414a87559b 100644
> --- a/bsd-user/qemu.h
> +++ b/bsd-user/qemu.h
> @@ -180,7 +180,7 @@ void cpu_loop(CPUArchState *env);
>  char *target_strerror(int err);
>  int get_osversion(void);
>  void fork_start(void);
> -void fork_end(int child);
> +void fork_end(abi_long pid);
>=20=20
>  #include "qemu/log.h"
>=20=20
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 8c7bea1c631..f1a0267816b 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -147,8 +147,10 @@ void fork_start(void)
>      gdbserver_fork_start();
>  }
>=20=20
> -void fork_end(int child)
> +void fork_end(abi_long pid)
>  {
> +    int child =3D pid =3D=3D 0;
> +

The intent is clearer if we make it a bool:

  bool child =3D pid =3D=3D 0;

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

