Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50EC8C10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 09:29:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3uem-0006qi-QB; Mon, 06 May 2024 05:29:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s3uek-0006qO-LP
 for qemu-devel@nongnu.org; Mon, 06 May 2024 05:29:10 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s3ueh-0001mi-7q
 for qemu-devel@nongnu.org; Mon, 06 May 2024 05:29:10 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a59a387fbc9so379768166b.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 02:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714987744; x=1715592544; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NDFtcL5t4gXzrN/uQPJUI7ZcnUDtAe2YPjtW9fAQBEw=;
 b=E8gySF7GdCttEuvBlIRvtOak2x9ep+X6tGVv52vcDlebDetWJPFRTMAbLaFjf3IMMJ
 +PzrEfxZSC+1XVqaT5n5bUwd91obMu/g9ziHxUa2zjWGX5ZFBanoQCcYp/Rn9moZ8c7A
 MT/riiAgUFMMCQypijxavRe/2JQ2ftDLazgffsu6ny9+rncOf/m0nSFmAy+GIGc/b+S/
 lRHxy2FRj6mS/urvmVyuwokAMiVVcbGywtUgwNUTijFSvi1Tal6wJAQO4NKI3ymD5tfO
 N2WMpMPrRYFxz3rRzAdvSDsqLkAuGspDMhqTHrx1yYjtF2xkP/gf1rbxfO/1/mYUNBh9
 gY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714987744; x=1715592544;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NDFtcL5t4gXzrN/uQPJUI7ZcnUDtAe2YPjtW9fAQBEw=;
 b=r4svlqwmAsn3TG00awRUlHEZYg/hogeLNiyAD/de7WWtmhSPlhrwocfiyUfIsScQRq
 ob+herOUTO/anB+gj8hy2aT2t+j7RmnivynWpEl1Tt5bldKrRctbM86oMWrP8XfQJL+j
 Z9gslogTYc0yV7v6dYhXGz/KOwKXt+M6+X2/2IKUyR89hw3zmwg0DRpPiXr1BQWGp90m
 YqNsISPilPGXmeEH2lKuLC0bSE8h4rjyRCnmc6zE+jVh8D8VZqj+15p3e/YzBksF63cF
 bx/Zc60wnl7xTA5W6rMJ7pEquYsz8vR6sN/wUgh88fk3s/pdgHxCSyx8IYYF5EY6KG/r
 7J/A==
X-Gm-Message-State: AOJu0Yy7CAUq8mCiCvsYVaXFsAGeGUZlZ0GgzZq8t7UZvQl7Te+7E/5V
 N6BjyqbS0gVkeftGwKCv217dmPgaEc9Z/rNvLpog18qk5liUYh2ddTo3nwBEX1wBWjcPLWiz/up
 C/tFyD3wSJXl1CR+s3YJq+mZSVjDCj5NN8m2zJA==
X-Google-Smtp-Source: AGHT+IEqIDgMe2oDZ5RHq9MbU78RQXnYjCtvPqFtl7gl7Mutky36zjfwIX03Jme46gdh/TtmGKOA/vo0RCOy1YbvXv0=
X-Received: by 2002:a50:a696:0:b0:568:d5e7:37a1 with SMTP id
 e22-20020a50a696000000b00568d5e737a1mr6219741edc.36.1714987744248; Mon, 06
 May 2024 02:29:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240312020000.12992-1-salil.mehta@huawei.com>
 <20240312020000.12992-7-salil.mehta@huawei.com>
 <CAFEAcA93EotG4-LXRJF034_9dWAWgZJA1VF6dB-xCsXn0T059g@mail.gmail.com>
 <10f35804a55e460a8ce6ecdb3f0c79b6@huawei.com>
In-Reply-To: <10f35804a55e460a8ce6ecdb3f0c79b6@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 May 2024 10:28:52 +0100
Message-ID: <CAFEAcA-w7wf9F4VVAnZR3b34ydEWq=QNw=CxhTMobsr+AP_LCg@mail.gmail.com>
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
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x632.google.com
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

On Mon, 6 May 2024 at 10:06, Salil Mehta <salil.mehta@huawei.com> wrote:
>
> Hi Peter,
>
> Thanks for the review.
>
> >  From: Peter Maydell <peter.maydell@linaro.org>
> >  When do we need to destroy a single address space in this way that mea=
ns
> >  we need to keep a count of how many ASes the CPU currently has? The
> >  commit message talks about the case when we unrealize the whole CPU
> >  object, but in that situation you can just throw away all the ASes at =
once (eg
> >  by calling some
> >  cpu_destroy_address_spaces() function from cpu_common_unrealizefn()).
>
>
> Yes, maybe, we can destroy all at once from common leg as well. I'd prefe=
r this
> to be done from the arch specific function for ARM to maintain the clarit=
y &
> symmetry of initialization and un-initialization legs.  For now, all of t=
hese address
> space destruction is happening in context to the arm_cpu_unrealizefn().
>
> It=E2=80=99s a kind of trade-off between little more code and clarity but=
 I'm open to
> further suggestions.
>
>
> >
> >  Also, if we're leaking stuff here by failing to destroy it, is that a =
problem for
> >  existing CPU types like x86 that we can already hotplug?
>
> No we are not. We are taking care of these in the ARM arch specific legs
> within functions arm_cpu_(un)realizefn().

How can you be taking care of *x86* CPU types in the Arm unrealize?

thanks
-- PMM

