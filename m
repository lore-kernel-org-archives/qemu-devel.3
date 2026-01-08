Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B4CBD185F1
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 12:49:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdpQw-0005vT-GB; Thu, 08 Jan 2026 07:48:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vdpQc-0005o4-Fv
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 07:47:59 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vdpQa-0003Gf-4P
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 07:47:49 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-477619f8ae5so25181955e9.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 04:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767876465; x=1768481265; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kdATo99z76ouqQ9tfynhT8fc8SBg9nT/FO4YjvWyMd4=;
 b=fnMoNTENnp2C1pjVQ2XYvIib4D8KwXjNcCm3PpXZxOWF5kdRuApMMQ+KmQ4bLTIXZB
 rZPB5Y2CC02a8zgf8rXrm39P2X13ynLrEDLnUys7wxuzN6R5K04cX2vMnaJdTl1JHb5C
 Tl0SZ637ByST/aVFyzbnPZzB3uJij9oeA5hcudSUvkHddNuOUZZR73kYEQ+FMeqmuOYB
 coNlRhMJd+/IVr+UBRnEkGdERDqIA7VYoR32FMNzz8vveYsSK7wwdZvb59iWrV8Bxk0w
 kTzBg1hZsBXrmIGVvhUwG7Xc0Dz6NdTxBFaz0qPmpg62veTzM5j6v9KqhgiATj6kprD1
 G2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767876465; x=1768481265;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kdATo99z76ouqQ9tfynhT8fc8SBg9nT/FO4YjvWyMd4=;
 b=O87liorTAVhVknztRioArlVaHcfJwiTd0qhPt5uVKsGLGrzzOq39NGuSkFFuHjuH8m
 YpN3swJRiBDkz/Ld/oRoZLE6w8CdrhaHp7++KdHJTNNRr37PrzWNGtEF1Wva3S5QGqKQ
 yM4I6lzI2eYrlmYWSCwTWjCvEMc/l1R5F4a3ZRF7qG3L0iaEVeGL7YpN1FPzK9Qj/v+j
 S111qGUDdl6qSu/s3muzMabilSxCyodEw3fg288MfMy6iqyy6FwOSsxvCFGo54QG90jA
 s97ert1NGtrECDe5W5/vR0GZwxNLptdlAbWh1XoR/oWnOlLXYoLY2NsOE6c26imxFxR/
 CfaQ==
X-Gm-Message-State: AOJu0YyfhKbKORhzKFLmR9IcaWHszlpxEkMsK4u7DQaUYdk5PwmknRjZ
 cf7qqKGzZ/sNW/+i1UpQKA2pyr9Jwgw6LdxlzoGcgHPOp+kxcV22ubzaaWm//K/eqqU=
X-Gm-Gg: AY/fxX7PHg917xIXKv+rP/DlpaUTXwKLZYDHeo3fZhAp6lnQS9gcaa/nOusBBjG8DyX
 DOzlB4v7M2TABqsCuEPCjmFvZTtd3/VsttoBvNxCDJHqeHmckXhPG4AsrNdPwlEKh2yo0Qyjchq
 WwYR6E5raBka67pMTzXGtvCPHtncjv3rvR9/0fMn2P/59FSvECDnW42lF+ItnobyxmqVweKYV+U
 86pSVx5c4D2BC6anAV2v3Sg8OPmO8sHoLix3NTFpYU+HVXsAKMfx2rUfbKHmgHVb+Ltk0WuFmnx
 RCFmmPHaorojlQJ4e9Yc0S7UtH8s5akNyC0m2CxrVbAajdH/Lduk4HwycerulMsW8JljZcKIiE2
 /ShCY4KuJ625f+LhQ0cC9rASIDOVQ1ogC0wDPzGXnaSVaL9IqCj2UNNpDFXgtNtBSih0LUsuc3n
 jP2bt3XZS9Ock=
X-Google-Smtp-Source: AGHT+IEphcSvjOK9UqOPbcKWFe3mvUyuO3h7/vhhhnHmy6rsnTAQVojkURmHr8+sEzJ+BS6T5wUgXw==
X-Received: by 2002:a05:6000:290b:b0:432:8651:4071 with SMTP id
 ffacd0b85a97d-432c3632942mr7975048f8f.18.1767876465201; 
 Thu, 08 Jan 2026 04:47:45 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e175csm16161350f8f.14.2026.01.08.04.47.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 04:47:44 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 844D45F804;
 Thu, 08 Jan 2026 12:47:43 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Alano Song" <alanosong@163.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,  "Jonathan Cameron"
 <jonathan.cameron@huawei.com>,  "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>, Chris Rauer
 <crauer@google.com>
Subject: Re: Question about qemu patch
In-Reply-To: <331af4b3.96f0.19b9d487bf4.Coremail.alanosong@163.com> (Alano
 Song's message of "Thu, 8 Jan 2026 19:05:31 +0800 (CST)")
References: <331af4b3.96f0.19b9d487bf4.Coremail.alanosong@163.com>
User-Agent: mu4e 1.12.14; emacs 30.1
Date: Thu, 08 Jan 2026 12:47:43 +0000
Message-ID: <878qe89spc.fsf@draig.linaro.org>
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

"Alano Song" <alanosong@163.com> writes:

> Hi all,
>
> I am writing to share a patch and ask for some advice.
>
> I noticed there is no DesignWare I2C controller model in QEMU,
> so I have attempted to add it:
> https://lore.kernel.org/qemu-devel/20260106131253.16192-1-AlanoSong@163.c=
om/
>
> I have a couple of questions regarding the patch:
>
> 1) Is it acceptable to submit the I2C controller model by itself,
>     without instantiating it on any specific machine board?

The problem with this approach is the code can very easily bitrot if it
is not exercised by anything. We also tend to cull code that isn't used
(for example if the old machine model was removed and we didn't notice
at the time it was the only user of a device).

>     Users who need it could then add it to their own machine models.

There is a long term aspiration to support dynamic machine models so
they can be defined with some sort of Domain Specific Language (DSL).
Until we reach that state we can only support devices used by machine
models in the upstream.

>     1.1) If it is required to instantiate the new model on a machine boar=
d,
>         which board would you recommend for this purpose?
>
>         Patch reviewer remained me, that the arm/virt board is a main mod=
el used.
>         And I don't want make troubles on such important model.

virt is a poor choice for as it is the main platform for virtualisation
so adding extra devices just increases the potential surface area for
security exploits.

Ideally you would find a real machine that uses the IP and model that
board. Looking at Zephyr it doesn't look like there are any existing
QEMU models missing it:

  https://docs.zephyrproject.org/latest/boards/index.html#show-shields=3Dfa=
lse&compatibles=3Dsnps%2Cdesignware-i2c

>
> 2) Coincidentally, I found that Joel Stanley is doing the same work=EF=BC=
=8CHAHA :)
>     https://lore.kernel.org/qemu-devel/20260106055658.209029-12-joel@jms.=
id.au/
>
>     What should I do next, may be we can work together to submit such
>     model ?

I would contact Joel/Chris (cc'd) and collaborate on getting the best of
both patches. It looks like the patch is part of a larger series that
ads a new machine which solves one of the problems.

>
> Best Regards,
> Alano Song.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

