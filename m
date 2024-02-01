Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0787FC48286
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 17:08:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVaXa-0004J2-FG; Thu, 01 Feb 2024 12:07:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVaXV-0004I8-Lm
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 12:07:49 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVaXQ-0001Gx-7j
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 12:07:48 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-55fbbfbc0f5so1399798a12.0
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 09:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706807262; x=1707412062; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9lcs9KY1YfoeYmOzyvbqbGjqiLppkJlXqLBWULoGILM=;
 b=rYAOdZ6fbzEgzlLUgWJeJAd8Vk1siZpGNrrvChuuPuoZPZWc3lJxlfBGkI0d+hmqXH
 zh9SpIzwIuk0CVrVwe7XY6THmMP9D5p9qCcCWm/a+QxNACBiMIyUPloNLAos2JGxTNqU
 JveD5lOwnn4/yocrmZZljQ5pWA6yeWSAmcuDwFgQc9hk9Yn9A6VJwJGH1Rjn2Jt+eOBd
 QiqxZuQuaL/JkkSJwdoUZKbaRhSg2z7N3rrVpaHzG/cA78hrPUfeLi7TgZujiSmt4b7z
 3Ww0bhyrcYBQ6deWBA4kRE1+CikqjKMGQP7ySiyPBXUP8qTobzED+JBCjpLvrPsRW+Vr
 F6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706807262; x=1707412062;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9lcs9KY1YfoeYmOzyvbqbGjqiLppkJlXqLBWULoGILM=;
 b=EowXI8Xoa9zOqxUKNpE3se906UUVHXsk9ZwNxn9RTyZ09RDr4scne3uWTDFxVHeBGU
 e83Zio1xtxImwTCC5rC5ywm7FbwKnk1kpXMN9DrPmQvSBn89nImUYqHTTV7O/0mJr9jg
 eO+Y26B/oQquMnRHUqkwf3nFm+Ce/WTSz/sd/aMSCNuw4LPn5hM+BHYeZjYYUrKJ2eqn
 jl1u59Ai4hAxpVd5IOamfUxLprfPvak5HcibkbjFdgIUL7J72p/24AuYMvOfxW5xQY6O
 2cjLicNE6JUQctMeIJMJt4ZxY+WTECqekxsRkw0QGZHw3MKS16lw/AoE5RYMuVlPsXM+
 yHCA==
X-Gm-Message-State: AOJu0Ywp3ULEGNDY9g/6oq5syd+gAM1DN32ThrauTmZo+YFymujuVek0
 3xe9Acc2ZZts8JsclMaa6dZMIb9nS9b+TAg16FmJpy4KdhXz5fAQg4VSl46BUN5bbNswqBeBPCM
 XUkSKA+AR5TCsLzKyzqtAI9Q+n9tLbfIPc3IcNw==
X-Google-Smtp-Source: AGHT+IHt06bMSqT1NVCIus7K30YakD+fbJJIPZUxSQFaEHhuVTqXkt4StlPgv7SxsER8mqJfyskIifU1aspbLYYtig4=
X-Received: by 2002:a50:8e43:0:b0:55f:5197:6314 with SMTP id
 3-20020a508e43000000b0055f51976314mr5076259edx.18.1706807262047; Thu, 01 Feb
 2024 09:07:42 -0800 (PST)
MIME-Version: 1.0
References: <20240126171233.00002a2e@Huawei.com>
 <CAAg4ParQKj9FUe0DRX0Wmk1KT0bnxx2F7W=ic38781j7eVz+OQ@mail.gmail.com>
 <20240201130438.00001384@Huawei.com>
 <CAFEAcA-rgFmaE4Ea7hZ-On4uyaqjWoo-OwwfNrUOdp=+Q5ckXA@mail.gmail.com>
 <20240201140100.000016ce@huawei.com>
 <CAFEAcA9DW8AuMwDr_qyDXPWJcLsvD773XTr1stwuagHWc6p72g@mail.gmail.com>
 <87msskkyce.fsf@draig.linaro.org>
 <CAFEAcA_a_AyQ=Epz3_+CheAT8Crsk9mOu894wbNW_FywamkZiw@mail.gmail.com>
 <20240201162150.000022cf@huawei.com> <87h6iskuad.fsf@draig.linaro.org>
 <ZbvPGV0a3xOMsAMG@memverge.com>
In-Reply-To: <ZbvPGV0a3xOMsAMG@memverge.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Feb 2024 17:07:31 +0000
Message-ID: <CAFEAcA8oLkpSsAabYNxXQTEuJvG93xJoP3yxv0JqJfH4udmNbw@mail.gmail.com>
Subject: Re: Crash with CXL + TCG on 8.2: Was Re: qemu cxl memory expander
 shows numa_node -1
To: Gregory Price <gregory.price@memverge.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Sajjan Rao <sajjanr@gmail.com>,
 Dimitrios Palyvos <dimitrios.palyvos@zptcorp.com>, linux-cxl@vger.kernel.org, 
 qemu-devel@nongnu.org, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Thu, 1 Feb 2024 at 17:04, Gregory Price <gregory.price@memverge.com> wro=
te:
>
> On Thu, Feb 01, 2024 at 04:45:30PM +0000, Alex Benn=C3=A9e wrote:

> > No thats different - we are actually writing to the MMIO region here.
> > But the fact we hit cpu_abort because we can't find the TB we are
> > executing is a little problematic.
> >
> > Does ra properly point to the code buffer here?
> >
>
> What if the code block is ALSO in CXL (MMIO)? :D

In that case the TB is supposed to be a single insn,
so the insn will by definition be the last one in its
TB, and IO should be OK for it -- so can_do_io ought
to be true and we shouldn't get into the io_recompile.

-- PMM

