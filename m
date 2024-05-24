Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D18BC25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 15:03:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAWR8-0003QC-8z; Fri, 24 May 2024 11:02:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sAWR7-0003Q0-J0
 for qemu-devel@nongnu.org; Fri, 24 May 2024 11:02:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sAWR5-0001a1-VM
 for qemu-devel@nongnu.org; Fri, 24 May 2024 11:02:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716562939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wma0wt1Q++ex/FEsJBWXF37eEFPz99DivhL9CLOzcK0=;
 b=DQyPoOZ7mRhKbvJcOg+0o5vNmGOvKrjMTSOfDxdUdF1Biku5YNZ7bLRx55UP7Lk8WDImD4
 a95zKFbysowwbzG92GnSaHMLYjwTsHwPJ3NT9IViodaS7eoD1JR4f1HIjzEWzpP3qQoedP
 RWn8jBV97faLPAm+xEkf0ZJql8ZDSGw=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-kVQDiyHePACSLmZ4__H2IQ-1; Fri, 24 May 2024 11:02:18 -0400
X-MC-Unique: kVQDiyHePACSLmZ4__H2IQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2e716db6f7bso19088681fa.2
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 08:02:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716562936; x=1717167736;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wma0wt1Q++ex/FEsJBWXF37eEFPz99DivhL9CLOzcK0=;
 b=r2mta26Z9G0MaU/QSE/dxCRFRbVAqzwrbY0hRrLtJwMHQq1eqc10Z2AoHG8cXwVMpA
 UgQ7IfkE1UIl0IIOYOgpYW+1YxGAH/93XaWT4j7LszoG+ap5dhSophOB6z77yx1JamAM
 UYK8Pv1FzNNUze22dg6jfk7u+TY1m7UiMATMHDZHXF1xYNjw2TSV2OXMPiKjlJK5EpsT
 6LgGqWlStRFiZGdeR5W2xoGF/5x478yIFxhMNe3RCqhjb/pujKEh35nw1eeVbDJWaB51
 2bdudIrKsRyjLqCkDhoHaoixGLx/VmoX6qc5KHeUHNT9hWkYi9PaiSeX7aqqDZwFJ8zj
 TYUg==
X-Gm-Message-State: AOJu0YxcQAh8mb2Y0EFn0TMYskIiWvHhwKl9eJ0NJK+KpE//VzhW7AVz
 KWRpcusyMDEU2LujcBXMpPCX1L6ZtLruIvGOOQZszzo1m8ziLpdbE+1OOGnWJUQHTjQ+ttjH3Q8
 Sz4HHlnF2ooF2yWu5Nk060lmd5lA3pKh+KfWDlrYqxVUhhJVkIMi+nzyG4UlPmr3fq2Umga2G6H
 aasCWjNRTCHuFonD4kGxtJCKQI2bROE7gcoYw=
X-Received: by 2002:ac2:560f:0:b0:524:339:4375 with SMTP id
 2adb3069b0e04-52964eb5ddemr1379323e87.40.1716562935641; 
 Fri, 24 May 2024 08:02:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoGuKbRNCag9krYc6VcpUP2SAUkl4tmvRnkJLMTaiGJKcm0H5JodlIFTliuBcnWP0lqExqZcLS6rgNjvZ4vuo=
X-Received: by 2002:ac2:560f:0:b0:524:339:4375 with SMTP id
 2adb3069b0e04-52964eb5ddemr1379306e87.40.1716562935114; Fri, 24 May 2024
 08:02:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240524081019.1141359-1-pbonzini@redhat.com>
 <20240524081019.1141359-4-pbonzini@redhat.com>
 <a11a973a-bd0f-4f46-ae39-4dc1d7a65615@linaro.org>
In-Reply-To: <a11a973a-bd0f-4f46-ae39-4dc1d7a65615@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 24 May 2024 17:02:03 +0200
Message-ID: <CABgObfbXNZKwxxeCC+6OUt2fie92TGUzhcRAxGsO3QxaLM-1bg@mail.gmail.com>
Subject: Re: [PATCH 03/16] target/i386: document and group DISAS_* constants
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, May 24, 2024 at 4:23=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 5/24/24 01:10, Paolo Bonzini wrote:
> > Place DISAS_* constants that update cpu_eip first, and
> > the "jump" ones last.  Add comments explaining the differences
> > and usage.
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >   target/i386/tcg/translate.c | 25 ++++++++++++++++++++++---
> >   1 file changed, 22 insertions(+), 3 deletions(-)
> >
> > diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
> > index 3c7d8d72144..52d758a224b 100644
> > --- a/target/i386/tcg/translate.c
> > +++ b/target/i386/tcg/translate.c
> > @@ -144,9 +144,28 @@ typedef struct DisasContext {
> >       TCGOp *prev_insn_end;
> >   } DisasContext;
> >
> > -#define DISAS_EOB_ONLY         DISAS_TARGET_0
> > -#define DISAS_EOB_NEXT         DISAS_TARGET_1
> > -#define DISAS_EOB_INHIBIT_IRQ  DISAS_TARGET_2
> > +/*
> > + * Point EIP to next instruction before ending translation.
> > + * For instructions that can change hflags.
> > + */
> > +#define DISAS_EOB_NEXT         DISAS_TARGET_0
> > +
> > +/*
> > + * Point EIP to next instruction and set HF_INHIBIT_IRQ if not
> > + * already set.  For instructions that activate interrupt shadow.
> > + */
> > +#define DISAS_EOB_INHIBIT_IRQ  DISAS_TARGET_1
> > +
> > +/*
> > + * EIP has already been updated.  For jumps that do not use
> > + * lookup_and_goto_ptr()
> > + */
> > +#define DISAS_EOB_ONLY         DISAS_TARGET_2
>
> Better as "for instructions that must return to the main loop", because p=
ure jumps should
> either use goto_tb (DISAS_NORETURN) or lookup_and_goto_ptr (DISAS_JUMP).

I guess it depends on what you mean by jump... Instructions that use
DISAS_EOB_ONLY are "jumpy" - IRET, RETF, SYSENTER, SYSEXIT, RSM. They
cannot use DISAS_NORETURN because they need to call gen_update_cc_op()
before finishing the TB.

Except now that I think about it, at the end of the series they don't
set cc_op anymore, so probably there's room for some more cleanup
there and DISAS_EOB_ONLY can be removed.

Paolo


