Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24599C0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 13:00:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdqcB-0003QK-PJ; Fri, 31 Jan 2025 07:59:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tdqc1-0003PK-3k
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 07:59:09 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tdqbv-0006pf-05
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 07:59:08 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-aaecf50578eso388770366b.2
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 04:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738328334; x=1738933134; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iIGs88RrK7yPLYzzPmE9m4QYk9DopQRVlIKIs2G6wlA=;
 b=V8qJbaadau8o24wMnfqBokcOTJ1QbxBSPvxFnQraenvRTd3wHUduykT4gv2OqUah7X
 f3WBxX5h1bAtseYzJ0euTMP8AwViyYGeESHg8sN9hELAL79fmWstCSbj7FYlekEgzAUR
 0bTajW3bryjznaiBKlqIMgCwkKCNo7e4QJ2khQg9vzJsxyugGbv1moUIGYBWiHn+GfeS
 SafKtyNO78cs3Ws/ERMmJMN/qU97ilosz10dTi6hN2jmvEoerSrHEMUs+E3134FPA6aK
 agzPy2RjCvfkQn+/8QequVb/m2UVkd7LwBZN+fOCd5Zb7AiLFOft9+SnIQsh6WeZlATU
 fjxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738328334; x=1738933134;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iIGs88RrK7yPLYzzPmE9m4QYk9DopQRVlIKIs2G6wlA=;
 b=OSD2aFs/qVxQkOBpD39dzP1KhlYeBParzqrld9BHidsoJTKEFeJseBdFNDIE9wQW61
 RYW4YUNeyIfs1tFcifVNCk+RX0yVIm9kAvcSNy+Tg6Wh6JhONSKtrzK+uX4CpoeLWJdB
 SQ49e/lOOWJY0vX4s00c6HFklVU5GJYU2DAWGIYQaR9zvyBL3g8YHwVB8uVsQ/8n8SRR
 HMFUg9Ugx6wX3DQqsBW6BpA/89R5yQMt3SKgBVO8c1GEAby+3uO3qq8MN9I2IPghW3BP
 jGpq6fCq+/pU6Ta2TQ0phdV8aAF8Wk7ybDEWSUNHoOUlkyd8ChrZZ+j4qM6sPIbZnXJ6
 yHZg==
X-Gm-Message-State: AOJu0YwZL4w9NB7rB85URHwWh4l+w8L8IgQKL1/+88ELtxvvNQuIKlzj
 qeBeGzGJ0FRKTdm1f2zfLSK65Jksk181zkdkwaAa59FZkMnSdYPBMASiSNCmOLQ=
X-Gm-Gg: ASbGnct0JQ0Kl9KsYWMHbAVHGnloiHCmNLiDjwQcw/uv+R6fvVTj767r7DyXkxRul7k
 cnhQD5lFWCgrD0PJC+wrFb+EIuwDqhe59NGvMirnLKPegu4YJt4rSMgyIATbzSy8yMIKhEWZGd9
 /zz5s7whf81sQXu1WbjTbY+LXk00jAe0UOAnraW+tzhR6TwqN63Fkq4j4Y5icLsy2jZw2WRROiW
 7R5exU6Yoyjs96APB6fc558P2h+jedWEsmwg3MeGgKISwaCR6MM89bQbY6u+l2vCyHUtW9W583r
 JblfzMcRaRw6Aifhsw==
X-Google-Smtp-Source: AGHT+IHQxL6wZXuH98SDihxeWaWbqBbX8tJQ+tDnTmA5uzJl6yTz0LkZIRHo6o6U87sIjvH/PHuNRA==
X-Received: by 2002:a17:907:2ce4:b0:ab6:8fda:3bcf with SMTP id
 a640c23a62f3a-ab6cfe29ae4mr1208584266b.56.1738328333708; 
 Fri, 31 Jan 2025 04:58:53 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6e49ff968sm290441066b.111.2025.01.31.04.58.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jan 2025 04:58:53 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2FBB65F78C;
 Fri, 31 Jan 2025 12:58:52 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gautam Bhat <mindentropy@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: How does "rsi" get set in x86 prologue?
In-Reply-To: <CAM2a4ux=SH+=qemf+kcf=GBJ_-R5Zj4t9hxTCwvqYhwqmDpQ5w@mail.gmail.com>
 (Gautam Bhat's message of "Thu, 30 Jan 2025 21:04:56 +0530")
References: <CAM2a4uxJFhw71emxdZrB4SF-JSzJy_-bL=g9ke7OmjUoOXUDYQ@mail.gmail.com>
 <87jzbdv7wk.fsf@draig.linaro.org>
 <CAM2a4ux=SH+=qemf+kcf=GBJ_-R5Zj4t9hxTCwvqYhwqmDpQ5w@mail.gmail.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Fri, 31 Jan 2025 12:58:52 +0000
Message-ID: <87wmeb16nn.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Gautam Bhat <mindentropy@gmail.com> writes:

> On Thu, Jan 2, 2025 at 3:45=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@lina=
ro.org> wrote:
> <SNIP>
>> The call into the prologue comes from:
>>
>>   ret =3D tcg_qemu_tb_exec(cpu_env(cpu), tb_ptr);
>>
>> in cpu_tb_exec. With env in RDI and tb_ptr (the code address) being in
>> RSI.
>>
>>
>> --
>> Alex Benn=C3=A9e
>> Virtualisation Tech Lead @ Linaro
>
> Thanks Alex. So this would be regular function calling conventions. I
> thought there would be some inline assembly to the jump to the disas
> rather
> then a call to tcg_qemu_tb_exec(..)

No it is just regular calling conventions - as it is when the generated
code calls out to the helper functions.

As TB's chain execution we just maintain the TCG_AREG0 (cpu_env) and
TCG_REG_CALL_STACK (stack) until the point they exit and come out back
through the epilogue code. I think for *-user we sometimes reserve a
register for guest_base as well.

>
> I verified all of this in the gdb disas of the function.
>
> -Gautam.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

