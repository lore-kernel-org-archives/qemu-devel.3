Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38723E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 19:46:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVyTH-0000iG-FH; Thu, 09 Jan 2025 14:45:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVySw-0000gT-9k
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 14:45:15 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVySu-0005JQ-K3
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 14:45:14 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5d9882a936eso2249538a12.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 11:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736451910; x=1737056710; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qfn/UfuphWLYfvuk3oazNLhidQ11ArR1qM9GkwYj42M=;
 b=F6nYXBT5reyGXBLLzLAdp/HuYxI4I9TJv3CHwK5rRwc5RSVgIj+At3OGZ3tHgi04kv
 bPPsy7BHfjcAvXVtgw9S2kJVq7FTBL1N30GDoyVqzsy7DCpY8d8boKIwjMw62cHIbGI0
 4Qnwyi5JpkE6SMBvA9A/E1dSTHLyDP2rcrrIwvzTd6yd3iEqX2MI6by0cwYb+RNozANA
 NUej6/qFSwHCpvaWDsPf/HjgHoFlAE1gC9WhvIyLj+mwVpu9n4IOj6bRaOy5U+aARBbv
 1KcE4NCWFKWPaxgKKpgH895DFdx+nbtVwW18ZGt8MYHRxQ7RtZThH4p3g77Co8OzfmKy
 sJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736451910; x=1737056710;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Qfn/UfuphWLYfvuk3oazNLhidQ11ArR1qM9GkwYj42M=;
 b=E2DpdxXlp4BqkxScIvGcCG4wNqPhKzQSr+fCQ3KEveBUQseBB8IZ3IYDNnZyH2GMQ+
 He4bm0BPYcht2sZHbNpehOd/Hvn5yTLrNAEk2VbDDPU2hVteWKPRDeA+HhoZg+iEGfKA
 bcq7SMDcYRdwjWUhC0ysfHXE5E5aJlrBdlWjSs821JiOMkNLUVEPmPTJ8HtU8HyTPG5Y
 l4yK/J6jXZH/FZfKxC8qsF1gAqFwSaLSjBwRRvx2QJC+BQk2JMsuGbGFRu8+3jLCp0Fo
 Iv6Bq0MgfTYL/AKbBWErb3et3QdJjFs51nDfGi+2/kt2rOOfOm+AjiP86YFfsR2cugTH
 3NUQ==
X-Gm-Message-State: AOJu0YyaW2MsXpkAwcddrmwkV5Nf73954SQpbe59FNcZVuva7QHORmvW
 H/+PAsPUP/gH+yIaYJz2JUL9MmPr7wiaZe+xC2L0CRRFE9vegqLP46rSMrkdS5/wvNx31KYX/+C
 lXyk=
X-Gm-Gg: ASbGncs5J/AyhQH5W/6RGCrqlRC1Aj1ylSLsVx9f288xEe9bStpBMAYPXRUHEpVwFZG
 UZv24+4qW0crHAgAMyStct0v+IL72FVlEcDPWEwDmnDndQ+J/t3bZvUiuA4eBjng6UulIA9DwMx
 C7yOJgUjXNDz8vsbHqKlqCRMnWS+7MMny4LR3IrsG6uJgxuqAXPk6XBEjnK1nP7GrrYo4JwGNhl
 VEzxxkBd6bnSviJDd9YQEUwucQKjq138W4TYA5g0DOLbpcD/UdyRWk=
X-Google-Smtp-Source: AGHT+IFEcUZDxLCIWMpo67efTwR7Du3WfJpXMnv3O1xMX6bT5pUD7c+5y/rsLPvD1T/3XYaOzyyxMA==
X-Received: by 2002:a05:6402:26cc:b0:5d0:e696:1bfc with SMTP id
 4fb4d7f45d1cf-5d972e16896mr7710109a12.15.1736451910560; 
 Thu, 09 Jan 2025 11:45:10 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d99008c394sm903443a12.7.2025.01.09.11.45.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 11:45:09 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D02045F75D;
 Thu,  9 Jan 2025 19:45:08 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  "Dr. David Alan Gilbert" <dave@treblig.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Thomas Huth
 <thuth@redhat.com>,  Mahmoud Mandour <ma.mandourr@gmail.com>,  Alexandre
 Iooss <erdnaxe@crans.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,  Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH 10/22] system: propagate Error to gdbserver_start (and
 other device setups)
In-Reply-To: <da769717-0823-45b4-8b1c-9fd2611d0092@linaro.org> (Pierrick
 Bouvier's message of "Thu, 9 Jan 2025 10:55:17 -0800")
References: <20250109170619.2271193-1-alex.bennee@linaro.org>
 <20250109170619.2271193-11-alex.bennee@linaro.org>
 <da769717-0823-45b4-8b1c-9fd2611d0092@linaro.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Thu, 09 Jan 2025 19:45:08 +0000
Message-ID: <87bjwf6abf.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x532.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> On 1/9/25 09:06, Alex Benn=C3=A9e wrote:
>> This started as a clean-up to properly pass a Error handler to the
>> gdbserver_start so we could do the right thing for command line and
>> HMP invocations.
>> Now that we have cleaned up foreach_device_config_or_exit() in
>> earlier
>> patches we can further simplify by it by passing &error_fatal instead
>> of checking the return value. Having a return value is still useful
>> for HMP though so tweak the return to use a simple bool instead.
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
>>=20
>
> <snip>
>
>> -static int gdbserver_open_port(int port)
>> +static int gdbserver_open_port(int port, Error **errp)
>
> Did you mean:
> static bool gdbserver_open_port...?

yes, yes I did. Will fix.

>
> With that,
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

