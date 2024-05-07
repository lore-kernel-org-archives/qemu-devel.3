Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD576C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 09:04:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4Gj4-0006Dw-E3; Tue, 07 May 2024 05:03:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s4Gix-0006Cd-68
 for qemu-devel@nongnu.org; Tue, 07 May 2024 05:02:59 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s4Gir-0005vi-QY
 for qemu-devel@nongnu.org; Tue, 07 May 2024 05:02:57 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a59c0a6415fso599027366b.1
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 02:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715072569; x=1715677369; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z2jE5qDfx8bS3LJas2UapfjwL3dy12JCUJWy1N4nJtY=;
 b=l7eLrdWzEUobSXYFbhc2sq/EoTfkCZc1uDgoNrSZSN0vNtVl+6eEodC0NBof0twGQ2
 xWDPKqgMeDl3UCPOvnMi220MOiac5rAyVoXlGX6TGg9WXS9+9OCaqorHGT9rEoPqnmOM
 JaiFr6Asx2dF7dOmMjMiKVzzZKcnVWU1OxxijB4wFUgJyqS5uyeTWTG3kw6Sul0J6JYK
 /8fIgivbm9HUbmxBLIRXD8OcsYwCjtOKGugrdgPQF49MNhphZbGM4lZhkvjCupL1+NUF
 tjPLumzoQ5G5kecI+7ZtzSpyEdWvXz7ikiAyicYH5fvgvbeYgj8N2iK9BqOx9HWCR9KD
 Xt3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715072569; x=1715677369;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z2jE5qDfx8bS3LJas2UapfjwL3dy12JCUJWy1N4nJtY=;
 b=bmD78cLwPS824qg8Vmr7+DcWzKz+FBblaBeE70E8DpEbmDCLEZ6oDiCa8WJ7RcN038
 6tXAs+gohasBzPevR27iqyPTFT7i53OrXBWAu3luGHEKM/uEntGNlCh7SeCUGXdJlxK8
 OiKxCU2hNSDf+GPp9ghXCPyfKFjISao7465gOHXAHneUP1Sg4fxJqKl7k2fGN/nGRBQU
 a7c5CYS1x+KKsT2tYTVckhElw4UYsXaHAJRgXssV8uZ70+w/Xdg8gFZG5KXVA8emNguO
 uHjVbHmdUNiwcKOxYxnesWhNBfzrJ6IQPeHiDj+TKeE9Ph9meX6BkTSrt/XezKV08+RQ
 IENg==
X-Gm-Message-State: AOJu0YzhCnwHzGB2YakXtYUnosMpY1WCu61ECNy4rdc3CwErr27Yfwtb
 UxG9mj0dXq1YL2ERW1190KWvoVkmo9xGo566xvvF+0f41aNcEy/q5ESSDYOe2D/lrmrv84F095z
 DfExG5GHeUNozcOhda2vriiomvmfD5Puel/lEgQ==
X-Google-Smtp-Source: AGHT+IGRKbUd3xCeyVnFWisL15Tu+azAc7g+Ys9aQHJHCKi0yT/uNqNOD6ylCW1UdjC1qCIAoBcMsGi2by5IjZeQDnk=
X-Received: by 2002:a50:cc96:0:b0:572:32e4:daca with SMTP id
 q22-20020a50cc96000000b0057232e4dacamr7264208edi.25.1715072569373; Tue, 07
 May 2024 02:02:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240312020000.12992-1-salil.mehta@huawei.com>
 <20240312020000.12992-7-salil.mehta@huawei.com>
 <CAFEAcA93EotG4-LXRJF034_9dWAWgZJA1VF6dB-xCsXn0T059g@mail.gmail.com>
 <10f35804a55e460a8ce6ecdb3f0c79b6@huawei.com>
 <CAFEAcA-w7wf9F4VVAnZR3b34ydEWq=QNw=CxhTMobsr+AP_LCg@mail.gmail.com>
 <55f942d2a3644bdaaff759014e3a4c20@huawei.com>
In-Reply-To: <55f942d2a3644bdaaff759014e3a4c20@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 May 2024 10:02:37 +0100
Message-ID: <CAFEAcA92nCPPk0Qa6XjRqRGTq_XDyRSVVaz67WgJBEZcxoEtOQ@mail.gmail.com>
Subject: Re: [PATCH V8 6/8] physmem: Add helper function to destroy CPU
 AddressSpace
To: Salil Mehta <salil.mehta@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, 
 "maz@kernel.org" <maz@kernel.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, 
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>, 
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>,
 "david@redhat.com" <david@redhat.com>, 
 "philmd@linaro.org" <philmd@linaro.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, 
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, 
 "mst@redhat.com" <mst@redhat.com>, "will@kernel.org" <will@kernel.org>,
 "gshan@redhat.com" <gshan@redhat.com>, 
 "rafael@kernel.org" <rafael@kernel.org>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>, 
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>, 
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>, 
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>, 
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>, 
 "karl.heubaum@oracle.com" <karl.heubaum@oracle.com>,
 "miguel.luis@oracle.com" <miguel.luis@oracle.com>, 
 "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>,
 zhukeqian <zhukeqian1@huawei.com>, 
 "wangxiongfeng (C)" <wangxiongfeng2@huawei.com>,
 "wangyanan (Y)" <wangyanan55@huawei.com>, 
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>,
 "maobibo@loongson.cn" <maobibo@loongson.cn>, 
 "lixianglai@loongson.cn" <lixianglai@loongson.cn>,
 Linuxarm <linuxarm@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x635.google.com
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

On Tue, 7 May 2024 at 01:11, Salil Mehta <salil.mehta@huawei.com> wrote:
>
> >  From: Peter Maydell <peter.maydell@linaro.org>
> >  Sent: Monday, May 6, 2024 10:29 AM
> >  To: Salil Mehta <salil.mehta@huawei.com>
> >
> >  On Mon, 6 May 2024 at 10:06, Salil Mehta <salil.mehta@huawei.com>
> >  wrote:
> >  >
> >  > Hi Peter,
> >  >
> >  > Thanks for the review.
> >  >
> >  > >  From: Peter Maydell <peter.maydell@linaro.org>  When do we need t=
o
> >  > > destroy a single address space in this way that means  we need to
> >  > > keep a count of how many ASes the CPU currently has? The  commit
> >  > > message talks about the case when we unrealize the whole CPU
> >  > > object, but in that situation you can just throw away all the ASes
> >  > > at once (eg  by calling some
> >  > >  cpu_destroy_address_spaces() function from
> >  cpu_common_unrealizefn()).
> >  >
> >  >
> >  > Yes, maybe, we can destroy all at once from common leg as well. I'd
> >  > prefer this to be done from the arch specific function for ARM to
> >  > maintain the clarity & symmetry of initialization and
> >  > un-initialization legs.  For now, all of these address space destruc=
tion is
> >  happening in context to the arm_cpu_unrealizefn().
> >  >
> >  > It=E2=80=99s a kind of trade-off between little more code and clarit=
y but I'm
> >  > open to further suggestions.
> >  >
> >  >
> >  > >
> >  > >  Also, if we're leaking stuff here by failing to destroy it, is th=
at
> >  > > a problem for  existing CPU types like x86 that we can already hot=
plug?
> >  >
> >  > No we are not. We are taking care of these in the ARM arch specific
> >  > legs within functions arm_cpu_(un)realizefn().
> >
> >  How can you be taking care of *x86* CPU types in the Arm unrealize?
>
>
> Sorry, yes, I missed to reply that clearly. There was indeed a leak with =
x86 reported
> by Phillipe/David last year. In fact, Phillipe floated a patch last year =
for this.
> I thought it was fixed already as part of cpu_common_unrealize() but I ju=
st
> checked and realized that the below proposed changed still isn=E2=80=99t =
part of the
> mainline
>
> https://lore.kernel.org/qemu-devel/20230918160257.30127-9-philmd@linaro.o=
rg/

That seems like the right way to clean these up -- Philippe, do you want
to fish that bugfix out of your big patchset and submit it separately ?

> I can definitely add a common CPU AddressSpace destruction leg as part of=
 this
> patch if in case arch specific CPU unrealize does not cleans up its CPU
> AddressSpace?

Arch-specific CPU unrealize shouldn't need to do anything -- if we
fix this similarly to Philippe's patch above then that will do
the cleanup required. Handling this kind of cleanup in common code
is more reliable because it doesn't require every target-arch
maintainer to remember it needs to be done, plus it's less code.

thanks
-- PMM

