Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87727C48BEF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 17:46:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb2HF-0004to-PQ; Fri, 16 Feb 2024 12:45:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rb2HE-0004sA-6n
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 12:45:32 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rb2HC-0000X3-Kh
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 12:45:31 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-410e820a4feso19426435e9.1
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 09:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708105529; x=1708710329; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UHuJZzGSwAniZ9FRlRvkUTQT6pdUc/uq/B2TjFLwuhg=;
 b=l3JFKHDfXlTXWHojb7Ogrqyp2yu5jVLvAPWnu3WW3mF7GoDBOCC1lCVfnc2Lyljex5
 OmL92xwGA1IlftaB4s1yD+8aI0xxaA6xL5kyQxanKX+vJSGFI+kybhp1qur5HkJ62cDv
 jUrH5cFB6isuBCDjrAQb9W/k4AaEZrd0tr78qju9tzzzsvoS3hHi5nTrlp/PV1q3XkXt
 jg6wz+5jXWZ2fPNaXNksj+ajbPI7C/nM57Z4hR+dQUucQBIWzEWVcUKqDFltRUYHJfkW
 uU1BCs2HMKGBykmmhzn9jwZY1CPF2jSXw6flpqnpBwJsCGmmooYdtzQbQqR9pD9KV42Z
 w0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708105529; x=1708710329;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UHuJZzGSwAniZ9FRlRvkUTQT6pdUc/uq/B2TjFLwuhg=;
 b=gb1/E15q3Myi5LXrITEmM1ZVfWV3KywCbgWCfa2GA/2saM/dLT6jTKhdRb+yjLxzOJ
 r8ox6hGLxTQY8i5Fxds6KrCLMUAjKVBNxTEINLu06YCzF2cUEJP6EXRlpBFhBgEI7tSC
 vsam+Z9DZ/OxHnZEZWIHp75s8NfxDfLU72boVNc0ernyaIApGkE219HP1O81XiwzDfud
 IJFRbqiDfMw1WqNlMC0U22/WRwxmRl6F7Mq06ffEva5FiyI6j1/IsvwhQTnVULjIlbNp
 ONZi+Mru+TeF85fW4+NjSsByeOZ3LuwpGxbHCj0MJONc3RLS4T8l7H2lP+aPOmYFmSOL
 3Wxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7RsdE1gzwoNm6CHLIrJ+X95EUORTHR3/h1lr2NYZjBMAwGLgkvJygYNPLlfk+ZAFlDzUgr/zAwxjRxjKWQIWi4AT7fgI=
X-Gm-Message-State: AOJu0YyIWJ2iFf2lxK61GQU4Ej4+mmUktKrNy2pWbwJfVLoQNcALvDTD
 msfMqpOh61WByzeoI965+zG3HTAZE0Meh7IhQCTX2OlaPrNH6SBfEqtB260iFvA=
X-Google-Smtp-Source: AGHT+IEOvvFTgV/FK0EyWMkNb1PtcIOJYE/VEE8uEg8yeiSSVltB5NcOi2+h1ajnraeOleFRHVi42A==
X-Received: by 2002:a05:6000:92:b0:33c:d02a:b4d7 with SMTP id
 m18-20020a056000009200b0033cd02ab4d7mr8071157wrx.23.1708105528761; 
 Fri, 16 Feb 2024 09:45:28 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 k10-20020a7bc40a000000b004101f27737asm2934828wmi.29.2024.02.16.09.45.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 09:45:28 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1F1725F83F;
 Fri, 16 Feb 2024 17:45:28 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Laurent Vivier <laurent@vivier.eu>,  Warner Losh <imp@bsdimp.com>,  Kyle
 Evans <kevans@freebsd.org>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v3 02/11] {linux,bsd}-user: Update ts_tid after fork()
In-Reply-To: <20240216130817.369377-3-iii@linux.ibm.com> (Ilya Leoshkevich's
 message of "Fri, 16 Feb 2024 14:05:29 +0100")
References: <20240216130817.369377-1-iii@linux.ibm.com>
 <20240216130817.369377-3-iii@linux.ibm.com>
User-Agent: mu4e 1.11.28; emacs 29.1
Date: Fri, 16 Feb 2024 17:45:28 +0000
Message-ID: <87ttm82thj.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

> Currently ts_tid contains the parent tid after fork(), which is not
> correct. So far it has not affected anything, but the upcoming
> follow-fork-mode child support relies on the correct value, so fix it.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  bsd-user/main.c   | 1 +
>  linux-user/main.c | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/bsd-user/main.c b/bsd-user/main.c
> index e5efb7b8458..4140edc8311 100644
> --- a/bsd-user/main.c
> +++ b/bsd-user/main.c
> @@ -127,6 +127,7 @@ void fork_end(int child)
>           * state, so we don't need to end_exclusive() here.
>           */
>          qemu_init_cpu_list();
> +        ((TaskState *)thread_cpu->opaque)->ts_tid =3D qemu_get_thread_id=
();
>          gdbserver_fork(thread_cpu);
>      } else {
>          mmap_fork_end(child);
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 74b2fbb3938..e6427d72332 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -160,6 +160,7 @@ void fork_end(int child)
>              }
>          }
>          qemu_init_cpu_list();
> +        ((TaskState *)thread_cpu->opaque)->ts_tid =3D qemu_get_thread_id=
();
>          gdbserver_fork(thread_cpu);
>      } else {
>          cpu_list_unlock();

Given how many functions do this cast dance it does make we wonder if we
should just have a helper for *-user:

  TaskState * get_task_state(CPUState *cs)
  {
        return (TaskState *) cs->opaque;
  }

and be done with it. Richard?

Anyway good enough for now:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

