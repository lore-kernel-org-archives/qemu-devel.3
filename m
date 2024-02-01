Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43B5CC47DDF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 12:06:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVVpQ-00076K-Mt; Thu, 01 Feb 2024 07:06:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rVVpP-00075p-3u
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 07:05:59 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rVVpN-0005rx-D8
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 07:05:58 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40fb0c4bb9fso7441335e9.0
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 04:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706789155; x=1707393955; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PYgUPxX/O2OcI+f3CMNjeOlJ5+8bWh9SBwpinlmEqso=;
 b=jA+cXm3YRK3mY39fDmKOYF5vK1YE4DEHDdpPtLVUSh96HxRqv9gwPtiFy7x3YH+mwB
 DIB8SrM8cKWEGQ+WI0h1qqpYqfptwMPYVZ6sR9ZnjodhudB4dFwLbeLeCmQBBADYDsJ9
 OJ5FhcvBM8id4bjfF867FBcCSBOUO8mXjqOQBhZODfZImjc0NwoayScV0R4FxMzp2ZKD
 wOnFGKCzwmwysZ8b/O3uEMkHawVhCeuVbVZR5uW1tNxHmi9cDFLF82ZJQQw/pWID0a2V
 k6UAfulVWrqi9Vh3lP8unQ071/bhsyBx5cElfWfMPvb9rr81f4Kaz5x0ja8D2DKJnnMN
 B8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706789155; x=1707393955;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PYgUPxX/O2OcI+f3CMNjeOlJ5+8bWh9SBwpinlmEqso=;
 b=tBqGmYvRjHuDXbIlqXqe30GauUL5wdz1z9hjl7qMbtzx+qquUPPLhMoSwsYXf4rpj8
 XZG4ozA3hs0QKI9b1v53qjWqYH1OgYOx3zRE2muFVeHUglC68pitEGHGlRRsNdbyXe1X
 0snfw8v33n0wzfVYJuR/aGDVgQd5cpQchFLrvrUXiQBY+gIFsSrq+w7waYnaoQ1pqvC4
 5hpLIAa+rHX3mC2lCykIr7D+QRlpTq9IDcTW4XxAP3hzyPU6IIQO/P8UnhJ1SPQyj8jd
 crx4oEaXVqW5Ggy5/BAzmx6oKfDIVQW2WGu2Zp05eU60bRyhzUQupch9kfW13Smwbgny
 O7lw==
X-Gm-Message-State: AOJu0Yxhcp317eFtwQROsByX66mRSNSOIF+F/sd7rxtXqigjutgojtBd
 OvzUojoFnnD5Ga/BsLzxoZP+vp+/44+ZlZUsxlrfujIC9Y5wh9KtPmSZW2e0k8C+c9xtQkH9oV8
 R
X-Google-Smtp-Source: AGHT+IEr75ckxtByZxALD3nZLDlRb2m2J3BRUlaItOybuCM2j8DiJjn7QZKs49C9QgObsnMFc37YVw==
X-Received: by 2002:a05:600c:1553:b0:40f:b0c9:dbc with SMTP id
 f19-20020a05600c155300b0040fb0c90dbcmr3588214wmg.37.1706789155555; 
 Thu, 01 Feb 2024 04:05:55 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUBx+jkTZfBWb6Vcjw4G21Dy+HLi046Gj0C9NaP1s1kbVHZEacAqbnIl7BsQRElSEHR3A1dCFMt8P0aICiBQ0vgXx+USVxVbLnI2uBRGgZfO8MtvMRvgjHAHLmceTWjnY2k/5eai+ZNGiywJhuDbP9BT0vd2A3r
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 l13-20020a05600c4f0d00b0040efbdd2376sm4268082wmq.41.2024.02.01.04.05.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 04:05:55 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DF8E65F7AF;
 Thu,  1 Feb 2024 12:05:54 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Laurent Vivier <laurent@vivier.eu>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>,  Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 1/3] gdbstub: Refactor fork() handling
In-Reply-To: <20240131205031.144607-2-iii@linux.ibm.com> (Ilya Leoshkevich's
 message of "Wed, 31 Jan 2024 21:43:39 +0100")
References: <20240131205031.144607-1-iii@linux.ibm.com>
 <20240131205031.144607-2-iii@linux.ibm.com>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Thu, 01 Feb 2024 12:05:54 +0000
Message-ID: <87cytgmlst.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

> Prepare for implementing follow-fork-mode child:
> * Introduce gdbserver_fork_start(), which for now is a no-op.
> * Rename gdbserver_fork() to gdbserver_fork_end(), call it in both
>   parent and child processes, and pass the fork()'s return value to it.
> * Factor out disable_gdbstub().
> * Update ts_tid in the forked child.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  bsd-user/freebsd/os-proc.h  |  6 +++---
>  bsd-user/main.c             |  8 ++++++--
>  bsd-user/qemu.h             |  2 +-
>  gdbstub/user.c              | 25 +++++++++++++++++++------
>  include/gdbstub/user.h      | 11 ++++++++---
>  linux-user/main.c           |  8 ++++++--
>  linux-user/syscall.c        |  4 ++--
>  linux-user/user-internals.h |  2 +-
>  8 files changed, 46 insertions(+), 20 deletions(-)
>
<snip>
>=20=20
>  /*
> diff --git a/include/gdbstub/user.h b/include/gdbstub/user.h
> index 68b6534130c..1694d4fd330 100644
> --- a/include/gdbstub/user.h
> +++ b/include/gdbstub/user.h
> @@ -46,10 +46,15 @@ static inline int gdb_handlesig(CPUState *cpu, int si=
g)
>  void gdb_signalled(CPUArchState *as, int sig);
>=20=20
>  /**
> - * gdbserver_fork() - disable gdb stub for child processes.
> - * @cs: CPU
> + * gdbserver_fork_start() - inform gdb of the upcoming fork()
> + */
> +void gdbserver_fork_start(void);
> +
> +/**
> + * gdbserver_fork_end() - disable gdb stub for child processes.
> + * @pid: 0 if in child process, -1 if fork failed, child process pid oth=
erwise
>   */
> -void gdbserver_fork(CPUState *cs);
> +void gdbserver_fork_end(pid_t pid);
>

This had merge conflicts when I tried to apply to my tree.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

