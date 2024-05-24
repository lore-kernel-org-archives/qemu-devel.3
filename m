Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF21C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 15:05:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAWTm-0005aP-V3; Fri, 24 May 2024 11:05:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sAWTk-0005Zq-GG
 for qemu-devel@nongnu.org; Fri, 24 May 2024 11:05:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sAWTi-00022p-R1
 for qemu-devel@nongnu.org; Fri, 24 May 2024 11:05:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716563105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JP5assoHRSjZ/34iE3MZJIDYp31oZ3GB17gGuRUKXE4=;
 b=VtD4E4kT/o5EwKnp/v5cQzgBMEEkvF0Qqt6QAZdudBhLgBiTVBlrQKuWgKlwxuSr1qgl8w
 H5/WREAIR90Kdh0gSf4q/ASAnLAyPYVgg+T4QllxG+ZXbRzJtNBgVzIVnRTHQysKZfWNsk
 TEAe0ywXGudOe1pUNEeZtjBLAKMZB1M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-I5ob2w3JNUWfaOwJcC52AQ-1; Fri, 24 May 2024 11:05:01 -0400
X-MC-Unique: I5ob2w3JNUWfaOwJcC52AQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-35507de96c7so261122f8f.0
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 08:05:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716563100; x=1717167900;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JP5assoHRSjZ/34iE3MZJIDYp31oZ3GB17gGuRUKXE4=;
 b=Cqb2VG0lf9T4+pC0/H+dkJRx/NVcAED+r72qwPGKBkepvzcLNOn4wiM/a2i3JGd0Xz
 eJ3NUNuV/RNEa7dC23qRoKHtKevppY0z4FD6k9Bcf7aqqD5m1hZXngk8SO2tBFYOhXi0
 rvZ3GEGM2qPVDavBR2JEpFSjju1Didg2he7kIKVcuF1ItLcGOa3JjWv15+kccMEoBWMJ
 zq/FnvaE8Qy1yAr26fp0OXX+NCnVIBpeSibGof6LAcLNI4zxHdymFzJvZsNDhShpWyEA
 5n1jou4/M4adO2VlETOa+Wt2Zh5QvEvZxaJ4z1PnEhTc36LewjMT856NlTZNGlIs+XO7
 AygQ==
X-Gm-Message-State: AOJu0Yxp50r1UYZGPYt+YiApuYZw0sshZxg/ZcBOfMae490YeC4xvQx9
 ahtdvFGF1uhzYun6rEEaq/naupUSYjeH+tAO9V2Z/ATBqms6c8Q8s8kdcLC9As4yRgBdAyeO31f
 NlUPKKOPZWK4a8SLY2YVdUHchSaANsovY0Ab1/wPrXncuNBFuT9U2kd+wj46Hv2z78xpSN6h5AB
 isyM7PEx9YL+QIdc/+TRocJtUnswkfnqwJiP0=
X-Received: by 2002:a05:6000:b46:b0:34e:81ab:463f with SMTP id
 ffacd0b85a97d-35506d5d0b0mr2326076f8f.20.1716563099683; 
 Fri, 24 May 2024 08:04:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzhA6z/PF8dChU1C5CQ5Kp/08vlXmn2+zZDzYHZtVn3Ts66qJ8bl1fo6uYYsxSldPUgOI/Cmim0WsddAMcwC4=
X-Received: by 2002:a05:6000:b46:b0:34e:81ab:463f with SMTP id
 ffacd0b85a97d-35506d5d0b0mr2326046f8f.20.1716563099230; Fri, 24 May 2024
 08:04:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240524081019.1141359-1-pbonzini@redhat.com>
 <20240524081019.1141359-4-pbonzini@redhat.com>
 <a11a973a-bd0f-4f46-ae39-4dc1d7a65615@linaro.org>
 <CABgObfbXNZKwxxeCC+6OUt2fie92TGUzhcRAxGsO3QxaLM-1bg@mail.gmail.com>
In-Reply-To: <CABgObfbXNZKwxxeCC+6OUt2fie92TGUzhcRAxGsO3QxaLM-1bg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 24 May 2024 17:04:48 +0200
Message-ID: <CABgObfb04iUXNK+0OQMQUFkj58m5cALuuxe+kGfTaCZqxN3C5g@mail.gmail.com>
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

On Fri, May 24, 2024 at 5:02=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> On Fri, May 24, 2024 at 4:23=E2=80=AFPM Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > On 5/24/24 01:10, Paolo Bonzini wrote:
> > > Place DISAS_* constants that update cpu_eip first, and
> > > the "jump" ones last.  Add comments explaining the differences
> > > and usage.
> > >
> > > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > > ---
> > >   target/i386/tcg/translate.c | 25 ++++++++++++++++++++++---
> > >   1 file changed, 22 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.=
c
> > > index 3c7d8d72144..52d758a224b 100644
> > > --- a/target/i386/tcg/translate.c
> > > +++ b/target/i386/tcg/translate.c
> > > @@ -144,9 +144,28 @@ typedef struct DisasContext {
> > >       TCGOp *prev_insn_end;
> > >   } DisasContext;
> > >
> > > -#define DISAS_EOB_ONLY         DISAS_TARGET_0
> > > -#define DISAS_EOB_NEXT         DISAS_TARGET_1
> > > -#define DISAS_EOB_INHIBIT_IRQ  DISAS_TARGET_2
> > > +/*
> > > + * Point EIP to next instruction before ending translation.
> > > + * For instructions that can change hflags.
> > > + */
> > > +#define DISAS_EOB_NEXT         DISAS_TARGET_0
> > > +
> > > +/*
> > > + * Point EIP to next instruction and set HF_INHIBIT_IRQ if not
> > > + * already set.  For instructions that activate interrupt shadow.
> > > + */
> > > +#define DISAS_EOB_INHIBIT_IRQ  DISAS_TARGET_1
> > > +
> > > +/*
> > > + * EIP has already been updated.  For jumps that do not use
> > > + * lookup_and_goto_ptr()
> > > + */
> > > +#define DISAS_EOB_ONLY         DISAS_TARGET_2
> >
> > Better as "for instructions that must return to the main loop", because=
 pure jumps should
> > either use goto_tb (DISAS_NORETURN) or lookup_and_goto_ptr (DISAS_JUMP)=
.
>
> I guess it depends on what you mean by jump... Instructions that use
> DISAS_EOB_ONLY are "jumpy" - IRET, RETF, SYSENTER, SYSEXIT, RSM. They
> cannot use DISAS_NORETURN because they need to call gen_update_cc_op()
> before finishing the TB.
>
> Except now that I think about it, at the end of the series they don't
> set cc_op anymore, so probably there's room for some more cleanup
> there and DISAS_EOB_ONLY can be removed.

... and nope, it's the other way round - DISAS_NORETURN is a bug
waiting to happen for x86 translation because it doesn't process any
of HF_INHIBIT_IRQ_MASK, HF_RF_MASK or HF_TF_MASK.

Paolo


