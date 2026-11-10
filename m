Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBCE606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 10:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=c5nkFt7G
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQjTo-0000gc-6e; Tue, 10 Nov 2026 05:53:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xQjTk-0000g6-BV
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 05:53:28 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xQjTg-0003DV-16
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 05:53:26 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4ba013938d7so7327235e9.2
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 02:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794308001; x=1794912801; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8Y1IlFq7fRUVF2JkEAcJt3bDKGdTONj3lqslpY7wHNw=;
 b=c5nkFt7GKrz+r2kohfo89o0BtCp0hPhk7hZKxJk+6eyRxAei4wuc/3MWRKu/hymbM0
 r+rprzmBQr/keVF7IbDLgdD19V1N2zXiyAFFKPgYGj/ImsenMvHYTobJFeytuqkpV3wA
 u1nAV3j8UE99UQiuR+ftxMjY6Vy4l3pFRInHNfweVOb3Qof9d/0Jnf1WRBV6Blt2HrDa
 a24061uvqh2MBkKZJTjffR6RoYyCuQMciwimWIReCGzYsYkhajdvf3DBLfrPKjeFD5bI
 fH3Po+TSXX0PN3Neav7WeMK1isPiW8zcDpThBaytHdZyVenSzV3jitj2sABUPUFD6b+6
 2dYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794308001; x=1794912801;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8Y1IlFq7fRUVF2JkEAcJt3bDKGdTONj3lqslpY7wHNw=;
 b=n7fMbgR+1XuddD677a9n/B5Qhr7RX+Ggd1UHNKkL00P9ulVDWHhbFLnb/fOPaHwJwO
 B/t8c1j+07xShc40NfLYwWIYIbBWW44Fl+cneGH7BP+W7SNmBuX8mqZ9AIYpFeMHNnmm
 aDX+tAIwWTOT+FBCzjt+fwNblS6/vFy/TclXRq9ob2COz3yaNYMOeVj5zGnR/eNqC8rp
 koGUHP9eMvDrxA3Ff6W1ZIuNZuCFprHS7QWvmxp0jIxfMOBuUTMvkKVQoduFIwB1mhJv
 ojgpYRS+oO1k5r72CtqFqamL+jrf1TtvGRwaOWLglgpv0Dklm3x9HYntPfNX/XQuJ73/
 pqBw==
X-Gm-Message-State: APuU4Z+MiLTDQFnt7zeMiOcjPhhf3avHmxJhNaNhmH0QVeA7gJyKdyuj
 jjhVt1VOhGIDq434cyBcnVLI8g0y3a/OCIVLHVdAVG+3em5ICD+4c/KHObvSjr4z4HQ=
X-Gm-Gg: AYBFou3xEbk51Zot9uM7Bvz6AQjQRLklb0/s4zf4ZtdF1Zw+SgjIebvakQ1tGesNX7b
 Uy5VAYpbbNO7ZK+rxVFGcttvQ7vDEhqZ8A5cIkB0F0Oup1qcLJPdPpMn6kKjVmh3qRz87U2Lti6
 +pE1RDnfPuVNBNC8N+I6jA0ZF2OpRAQK+BSMjbbUYh/01ESv3oJn75/8IGqf6rlpU5WQB1yQO8X
 tYY/IdQoQCUXE0hsMCKSfATPwHpEEnVzyS4M7WEAYWWxQVJ2byPGfAMd65xC9H0giD0wuXUw6EV
 r/M7wZvQd1BAHpqI3+7b+BmFFhVRquIk3xu09DBLkIWDklh5MaMUpumjY8IlCsucpNG9a7KWuNq
 peoDHAT/3NUpZMkVOLU20rQ4AXbvr6f93+L++bY1OiOJvYXZdY0G8kUxAiD0p4kp227+0Xzz4vd
 3K9cBbr9LxI0ZoLZ/V8pwcS3hK0DHKCBhiWdaEiEYRYAqihnIF98g9VGO4xH6Fgvpk8IzFob+nf
 F07800jpp81qsjkAIbtCpdyygp0JyNvhglL4O6tzPChBrQSSKt1tsi5Td5w/BAnz5b2bKHagv8F
 J322qpgQDqpB5Pf4mMXAHO4qaRLD
X-Received: by 2002:a05:600c:8b84:b0:4a7:6bc7:f778 with SMTP id
 5b1f17b1804b1-4ba02355aa5mr38172915e9.30.1794308000617; 
 Tue, 10 Nov 2026 02:53:20 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba01d9df5csm67811945e9.0.2026.11.10.02.53.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 02:53:19 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7FCF35F7E1;
 Tue, 10 Nov 2026 10:53:18 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Ashish Anand <ashish.a6@samsung.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  qemu-arm@nongnu.org
Subject: Re: [PATCH] target/arm: Kick the other vCPUs on SEV under TCG
 round-robin
In-Reply-To: <20261109142319.73878-1-philmd@oss.qualcomm.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 9 Nov 2026 15:23:19
 +0100")
References: <20261109142319.73878-1-philmd@oss.qualcomm.com>
User-Agent: mu4e 1.14.5-pre1; emacs 30.1
Date: Tue, 10 Nov 2026 10:53:18 +0000
Message-ID: <875wy5c601.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
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
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com> writes:

> In round-robin (single-thread) TCG, all vCPUs share one
> host thread, so qemu_cpu_is_self() is true for every vCPU.

This makes me think we should check other cases of qemu_cpu_is_self. For
example:

  void icount_handle_interrupt(CPUState *cpu, int mask)
  {
      int old_mask =3D cpu->interrupt_request;

      tcg_handle_interrupt(cpu, mask);
      if (qemu_cpu_is_self(cpu) &&
          !cpu->neg.can_do_io
          && (mask & ~old_mask) !=3D 0) {
          cpu_abort(cpu, "Raised interrupt while not in I/O function");
      }
  }

Besides current_cpu does change even in rr so why I we testing against
thread rather than CPUState?

>
> The SEV helper used it to skip the kick of the issuing vCPU,
> and so skipped it for every other vCPU too: a vCPU sleeping
> in WFE is only woken when the RR kick timer fires.
>
> Compare against the issuing vCPU instead.
>
> Fixes: d238858bff60 ("target/arm: Implement WFE, SEV and SEVONPEND")
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> ---
>  target/arm/tcg/op_helper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
> index 6a673e5ae6e8..173dd0e5151a 100644
> --- a/target/arm/tcg/op_helper.c
> +++ b/target/arm/tcg/op_helper.c
> @@ -470,11 +470,11 @@ void HELPER(wfit)(CPUARMState *env, uint32_t rd)
>=20=20
>  void HELPER(sev)(CPUARMState *env)
>  {
> -    CPUState *cs =3D env_cpu(env);
> +    CPUState *self =3D env_cpu(env), *cs;
>      CPU_FOREACH(cs) {
>          ARMCPU *target_cpu =3D ARM_CPU(cs);
>          target_cpu->env.event_register =3D true;
> -        if (!qemu_cpu_is_self(cs)) {
> +        if (cs !=3D self) {
>              qemu_cpu_kick(cs);
>          }
>      }

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

