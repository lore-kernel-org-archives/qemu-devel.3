Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4061BD3B7FF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 10:43:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFWYK-0004wq-9A; Mon, 25 Nov 2024 05:42:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tFWYJ-0004we-BN
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 05:42:47 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tFWYH-0004so-M2
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 05:42:47 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5cfddb70965so5482099a12.0
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 02:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732531363; x=1733136163; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1/g7N4umDucvNantqETlVEzdddtDeuJUxC1yjxJwCWM=;
 b=tvJHLdfMOUwhTtB6RCzhVINuw4Enmkowq1lJjBWZvAzWcbmdArq8ZlOzOivtDKLoBL
 zsqRk9cNDl4Li5+0h+pVNmf3Kq6RRFCHz1+GbJUoNSoqbibnV1YzAaiS2/eleOYqadiK
 TUAFmH3EAHOa5xY5p9U79YwYylUFF5ksf/FBYO2Ewx3/yh/CaFE7GOBzYL98Uw4sG+Tl
 DHKWS9l6Zlo2+DzwoYOW3czfw693d7leahENQyE1+Xw4biE25GrXF100t7wUEG156pdt
 ep2WS5JR1dL1fig/Mh580wHW9DhVszeJwhBZc9JFVoOcOMc4dYkxUFUYt0KY8S1GdtYt
 4wBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732531363; x=1733136163;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1/g7N4umDucvNantqETlVEzdddtDeuJUxC1yjxJwCWM=;
 b=cDzcXHGfnaAKV56VjJqJUsMR4AENsPSv/a3QltTxfoNWUjvpyMa/0FiFAz7RWzL+77
 eVa09fkAoPnGETvUo1Kp4EAbEch8sIYAu92SrHxvNzz8itzJMcDm7vwKEovmTB9SUsRA
 8tY1K6Kd/3VopLeLlaY8+0GQ5XyOoJ0fe0LOsb8X/bDcj9ezx8CYvR/LMoxAKBu8r/fW
 zLFr0FAzItiaNi19ER9ojG43IixLOKvjCpq1a99Kz9FdxxvuVsEH3/OtKXGme97YCF2W
 62GtpE4IILoWgdnicBEfdd45VDmt4eRdgcwV9JRPn4U7/830zsxsl/rbKKZ5tK7R1/SN
 WOwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtGIA5EMz+PwXVqIS4d6Bkq/GMgdRiAlE+/vMWFqc5hUU3x+bJeFH4sBvN4a/HH2Sp3O6M7w2fo+xn@nongnu.org
X-Gm-Message-State: AOJu0YyxTca1KD2nWpxl7dbF1abL30vfLTPi+kYiOfYai6+iSSfdT6vg
 ilTkDOmNoKBefqPFECpTkYluqzdcxy5lVtTJa2Pd3NBzHaDZURDQ9apP9eTJ7eZIivcJOHJqDwx
 0XTYhyG05kzpwqVS8AxotBlNiJVB48prD0UCnWA==
X-Gm-Gg: ASbGnctlMeidfaEurCAFfuo6elpGQtPJQqMUVXcXAKum3kpHJmn6g8cPp36I37nq+/m
 hXlgXmNhGmTKPqw393V6oO6uSTcFHOysX
X-Google-Smtp-Source: AGHT+IHyvVQUD770XGn0CGpBpftU0OyR0tU+lTVUvrumMiR5vJKaSuIkATKfKUnTspHnCXRZUTVMdjUmksIrx3RWRKU=
X-Received: by 2002:a05:6402:268c:b0:5cf:e022:24f5 with SMTP id
 4fb4d7f45d1cf-5d0205c2679mr11693511a12.2.1732531363237; Mon, 25 Nov 2024
 02:42:43 -0800 (PST)
MIME-Version: 1.0
References: <66c346de-7e20-4831-b3eb-1cda83240af9@linaro.org>
 <b045c676-4722-4fb9-a800-27c92d832347@redhat.com>
 <c8ec9243-f489-4b91-946e-2c6ff7e36f71@linaro.org>
 <CABgObfbpEEHbLYNNXoNUwD0VNPiNAYB-9REqgEFhRz3QQKTZYw@mail.gmail.com>
 <Z0REl6xtaYuvP876@redhat.com>
 <CABgObfYeNW2WYVkPVGmaPKXHLC6bfHm8fFO+wuoQzZiOB5DPyA@mail.gmail.com>
In-Reply-To: <CABgObfYeNW2WYVkPVGmaPKXHLC6bfHm8fFO+wuoQzZiOB5DPyA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Nov 2024 10:42:32 +0000
Message-ID: <CAFEAcA_4etEfsRAa5OBW6Eh==9SovM12kH2UQEc4NKh5KQkakA@mail.gmail.com>
Subject: Re: Supporting clang on windows
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Mon, 25 Nov 2024 at 09:39, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On Mon, Nov 25, 2024 at 10:34=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrang=
e@redhat.com> wrote:
> > IMHO we need to have confidence not only in the current state of the co=
de,
> > but also that we're not going to accidentally regresss it in the future=
.
> > This is what the gcc_struct attribute gives us confidence in.
>
> Yes, as you say below the "solution" to that could be simply to avoid
> bitfields. They are problematic anyway for big-endian machines, see
> the commit that Thomas pointed out. Unfortunately it's a
> human-enforced solution, but then it is already human-enforced for
> endianness issues.

Mmm. The closest we get to auto-enforcement is CI on the big-endian
host, which requires that there's a test case that exercises the struct.

> > As an alternative is it practical for us to eliminate all bitfields
> > from our structs ?
>
> It is (at least for guest-visible structs), but it is a lot of work
> and I don't think it's reasonable for it to block clang enablement on
> Windows.

It is such a pity that C does not make it easy to have a portable
way to say "this is a struct that must match a particular layout
for ABI compatibility and it should be like this exactly regardless
of host system details, even if that isn't what you would 'naturally'
use". Does Rust provide any better facilities for this?

-- PMM

