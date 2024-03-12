Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B04C9C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 13:48:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk2Tf-0008B1-79; Tue, 12 Mar 2024 09:47:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk2Tb-00084Z-Ud; Tue, 12 Mar 2024 09:47:32 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk2Ta-0004ei-9H; Tue, 12 Mar 2024 09:47:31 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6e6ac01447aso332300b3a.2; 
 Tue, 12 Mar 2024 06:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710251248; x=1710856048; darn=nongnu.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bZe4+7Qxvn2PAwdnF2D7yCw30nx9a1H9S/bWYZZe6Ws=;
 b=gULK9odt9cYwv2yoSRbeHGvp6gQqk8p4h/d6c4LSmBLpoH33Y/wwoqdAfRRJAfELEr
 EhJqy04S4q/Zv54Otztj1DDplGIQuzDzhRUTMapf9+8YglF7IkGZhQP+j3ReLmXRNVp8
 5CPqz+guMgCOtuYy1HccLjZ42WeXWcQI48rVIZVO7AlENiDlsq2G6lOVw25er1lPRguL
 is1WA6Ozrm24iqbsH4lo/pHgeh1d+7AEiBdQrVG/h9ah/l5ap7L7aIFSoFuwolZ+I6SD
 IUhZrC1h/394HEY/TsFTdV2uJqASP18Opcbi4r0gwSFpa1XDWC4BXggM2iApE4CF6JBl
 HjOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710251248; x=1710856048;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bZe4+7Qxvn2PAwdnF2D7yCw30nx9a1H9S/bWYZZe6Ws=;
 b=Cew0AO5avDi3G5IQ8DnE9piXyi64ffCY5LVi5QxEwh7MjVq2/Nbg8l6asVJ5JA0CXd
 14+C7gm5ByiTul3+t+vwkqxoJpustR113vi/Kg3Q7XKGNqXpLdeE5jwbIfp3vYwSFpf2
 VOYFHWVBYHAg7K8Ft+yLIBWjatViexQLD6iZSO/SvISRybgJrqhOKrcWmOmiLEjvH+x+
 VWPFBz5LbNpjJAViInVvztyx3QsudS6ccyyCQX/9RYr71KOlFhIgWjwKWhA4Z+k0ZNju
 yFzAiqg1Rs7dN5KE3IKGXrXMbSgjAt4Ek6751hv1X6EOSrAj28uwrAyiFLSASqpM5JlQ
 XszQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUO8w012+rgcb+gcag569/LIezxU++SIzuxGjJ/qhJrBrmwrLQDNIPKSEzMmaAg04E92lJeR5Wx7ewC/qhTmasbn/kz
X-Gm-Message-State: AOJu0YyAJyIAtzHgQBANArbzIL7uPSwe7Ci4UWjBrh4xqWc8LFAZrgVG
 WFDKSiIymI9uv0ju6ZPLHp/tL8ksF/FVlEelvES6EtQfqq8+boHG
X-Google-Smtp-Source: AGHT+IHb/MWpgOonXBu2QaNExkRgtBzeI0TQFVVXd4RM2kB5wYn4q3UN1l6ureZz0ASTkdrkqOMb3g==
X-Received: by 2002:a05:6a20:d39a:b0:1a1:87c7:2d03 with SMTP id
 iq26-20020a056a20d39a00b001a187c72d03mr8247191pzb.33.1710251248031; 
 Tue, 12 Mar 2024 06:47:28 -0700 (PDT)
Received: from localhost ([118.208.155.46]) by smtp.gmail.com with ESMTPSA id
 18-20020a170902c21200b001dd6290283fsm6702044pll.248.2024.03.12.06.47.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 06:47:27 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Mar 2024 23:47:20 +1000
Message-Id: <CZRTGTKUK82Q.ILI4KLTI9TQL@wheely>
To: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: <qemu-devel@nongnu.org>, "Pavel Dovgalyuk" <Pavel.Dovgalyuk@ispras.ru>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Richard
 Henderson" <richard.henderson@linaro.org>, "Paolo Bonzini"
 <pbonzini@redhat.com>, "John Snow" <jsnow@redhat.com>, "Cleber Rosa"
 <crosa@redhat.com>, "Wainer dos Santos Moschetta" <wainersm@redhat.com>,
 "Beraldo Leal" <bleal@redhat.com>, "Michael Tokarev" <mjt@tls.msk.ru>,
 <qemu-ppc@nongnu.org>
Subject: Re: [PATCH v4 22/24] target/ppc: fix timebase register reset state
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.15.2
References: <20240311174026.2177152-1-npiggin@gmail.com>
 <20240311174026.2177152-23-npiggin@gmail.com>
 <87cyrzpopg.fsf@draig.linaro.org>
In-Reply-To: <87cyrzpopg.fsf@draig.linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue Mar 12, 2024 at 11:24 PM AEST, Alex Benn=C3=A9e wrote:
> Nicholas Piggin <npiggin@gmail.com> writes:
>
> > (H)DEC and PURR get reset before icount does, which causes them to be
> > skewed and not match the init state. This can cause replay to not
> > match the recorded trace exactly. For DEC and HDEC this is usually not
> > noticable since they tend to get programmed before affecting the
> > target machine. PURR has been observed to cause replay bugs when
> > running Linux.
> >
> > Fix this by resetting using a time of 0.
> >
> > Cc: qemu-ppc@nongnu.org
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  hw/ppc/ppc.c         | 11 ++++++++---
> >  target/ppc/machine.c |  4 ++++
> >  2 files changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> > index fadb8f5239..f22321779e 100644
> > --- a/hw/ppc/ppc.c
> > +++ b/hw/ppc/ppc.c
> > @@ -1112,16 +1112,21 @@ void cpu_ppc_tb_reset(CPUPPCState *env)
> >          timer_del(tb_env->hdecr_timer);
> >          ppc_set_irq(cpu, PPC_INTERRUPT_HDECR, 0);
> >          tb_env->hdecr_next =3D 0;
> > +        _cpu_ppc_store_hdecr(cpu, 0, 0, 0, 64);
> >      }
> > =20
> >      /*
> >       * There is a bug in Linux 2.4 kernels:
> >       * if a decrementer exception is pending when it enables msr_ee at=
 startup,
> >       * it's not ready to handle it...
> > +     *
> > +     * On machine reset, in this is called before icount is reset, so
> > +     * for icount-mode, setting TB registers using now=3Dqemu_clock_ge=
t_ns
> > +     * results in them being skewed when icount does get reset. Use an
> > +     * explicit 0 to get a consistent reset state.
> >       */
> > -    cpu_ppc_store_decr(env, -1);
> > -    cpu_ppc_store_hdecr(env, -1);
> > -    cpu_ppc_store_purr(env, 0x0000000000000000ULL);
> > +    _cpu_ppc_store_decr(cpu, 0, 0, -1, 64);
> > +    _cpu_ppc_store_purr(env, 0, 0);
> >  }
> > =20
> >  void cpu_ppc_tb_free(CPUPPCState *env)
> > diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> > index 203fe28e01..4c4294eafe 100644
> > --- a/target/ppc/machine.c
> > +++ b/target/ppc/machine.c
> > @@ -215,6 +215,8 @@ static int cpu_pre_save(void *opaque)
> >           * it here.
> >           */
> >          env->spr[SPR_DECR] =3D cpu_ppc_load_decr(env);
> > +        printf("cpu_ppc_pre_save  TB:0x%016lx\n", cpu_ppc_load_tbl(env=
));
> > +        printf("cpu_ppc_pre_save DEC:0x%016lx\n",
> >  cpu_ppc_load_decr(env));
>
> I think this is left over debug, which btw needs proper types:

Yes you're right, sorry that was intended to be removed.

Thanks,
Nick

