Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF41CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 10:07:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urD3L-0006JY-SC; Wed, 27 Aug 2025 06:06:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian.ehrhardt@canonical.com>)
 id 1urD3E-0006Hz-6t
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 06:06:44 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian.ehrhardt@canonical.com>)
 id 1urD37-0005vF-FZ
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 06:06:41 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2F0F93F7BF
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 10:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1756289194;
 bh=tQQY0zALVkGT3UPD7Jwo90C7aktTLhChgoCLpii4ZXk=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=iP5IPZ6rK7+aOr7+p3H58bQKfF4EL1PKtQEjHLA8eo9cGsBhf8saFci8K2k6Hz+UE
 X5mDuovzuqqF/z/Q84z22AsX5LJ7MjcPMqWVb/VLS4QzVqmnM6haUtBFqiPHc0VKQO
 69NWvdZB5OmqKku66HGZlKOTSARsRgv2eM8sOSBFzxcVmBOVHrEfpMZJsBVf5F34qg
 tyU6cT0b4+tnrOakM8G8NaGrmNmGGpTan1ytHRAyWj560euTCR36vtJOEEXgztjxS/
 7rzdkvFaW0ew0Wx2MtYnswAhCh1GqJygHtbl4Fqhh2vIds3LPHfif+WAx/bdhw127u
 m2ssDAZUZN9IQ==
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-61cbf7f2956so45819a12.2
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 03:06:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756289193; x=1756893993;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tQQY0zALVkGT3UPD7Jwo90C7aktTLhChgoCLpii4ZXk=;
 b=EvQ9KpE6AkNdm26yFg7g28a7B7/KUtNtp+iygeLbWTK+AwL+LuooMF4KSqvDPQqfmX
 SactCrp5c00329OkXSUr6pr3WFgFI1Kx/WzHIcNd9GjPRBTSobz4WlD+8ppN0TiAHUEr
 1cnDe1NTv17+SVMU5mhjtGr/7bFynETMmMBi/sVCXjr5m1lBDW3jnB9Y6zn8iSy8txWK
 AgyLkoRQ8ZiHfWQEPtNIuIULAKWmP7iSilR/JlZLbHDM365hPkZmsyRW2MqP6K+WkNlQ
 q4y6F4sJTMAttLDnLq5M9iABBzWrvFJFHH9RakmZz0PVYSTvR85co9MnlFvQriqC2/jE
 bPtA==
X-Gm-Message-State: AOJu0YxfBQR005Ex94C/PKamFMnbo+NdyWaoA4dFe1ESfbzydymsD6zZ
 A4tQDYXwkCOdCIH+n+FoP+shWuSoQOjsgH6J6S3aIWYDqk+9/Ttkc9XBQbRilGk+ISb+j6mKIrJ
 SGAOP66lOBE2neM/EkLD9FAAP5UaaIIjRZRqaozn1SJvkwAEwkindrI0CW6A4J5guNwh/C1uMi+
 knE/41OyaQ9yMHVZyn1rWWYVil7tedft03cBZjyYJpHrGehFo=
X-Gm-Gg: ASbGncuwbM0Dj2uls06Cwny+jxph7hBlW9aedom8Q6AqXJQksnohy5Ta7wH2gnPzJ0w
 UGnZqMJiyM5RCcYBzoajKP+UATbDP9ifBufkyzedbWgsWkom4jh1+SJC0QOUJzbspZt0qHx3rwz
 8/5H3oASShjsHdcB0KHko=
X-Received: by 2002:a05:6402:1e8f:b0:61c:bfa5:8d74 with SMTP id
 4fb4d7f45d1cf-61cbfa58ebbmr92456a12.2.1756289192827; 
 Wed, 27 Aug 2025 03:06:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/xYP08KWvL6PueXcXQa0/P45/fBJO0RcS7YYvFkterR6RpLEQNky5BuNL16haajDiIL32kNlYWR7LzbQd7Pc=
X-Received: by 2002:a05:6402:1e8f:b0:61c:bfa5:8d74 with SMTP id
 4fb4d7f45d1cf-61cbfa58ebbmr92442a12.2.1756289192446; Wed, 27 Aug 2025
 03:06:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAATJJ0++oPyjgXsekOKpHosps4jTpe9p9TWGGDpb2igbf6iipw@mail.gmail.com>
 <1426a2bf-24fa-4424-b045-4cd37d2f091c@redhat.com>
In-Reply-To: <1426a2bf-24fa-4424-b045-4cd37d2f091c@redhat.com>
From: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Date: Wed, 27 Aug 2025 12:06:06 +0200
X-Gm-Features: Ac12FXzO52pmoeQvUhi90jcdfITKKFpGdsCd7la5ykBUc7miUJxJEkD1B4DaGxg
Message-ID: <CAATJJ0JSE2YQ3-qopTMtUyKkUZaQWGvr5E9QbtE1ivSUpu+VuQ@mail.gmail.com>
Subject: Re: Weird conflict with gcc-15
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.125.188.122;
 envelope-from=christian.ehrhardt@canonical.com;
 helo=smtp-relay-internal-0.canonical.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Wed, Aug 27, 2025 at 10:47=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com=
> wrote:
>
> On 8/27/25 10:26, Christian Ehrhardt wrote:
> > Hi,
> > in testing qemu 10.1 since rc levels I've found yet another odd
> > behavior. As far as I can tell it's not your fault, but I wanted to
> > tell you for awareness and potentially to help me get the right debug
> > data.
> >
> > A test that triggered when checking Ubuntu was the one of EDK2,
> > emulating riscv when running on ppc64, example log [1]. Yep, yet again
> > not the most common setup :-) and the same emulation in all other
> > Ubuntu architectures as host works fine.
> > Gladly this was reproducible and it eventually led me to a wild
> > journey which now makes me consider gcc-15 (15.2.0-1ubuntu1) as the
> > suspect here.
> >
> > Since I know the arch, the function and the tunable - I can use a
> > rather surgical mitigation like this.
> >
> > diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
> > index a68809eef3..5317d8be57 100644
> > --- a/target/riscv/pmu.c
> > +++ b/target/riscv/pmu.c
> > @@ -189,6 +189,13 @@ static int riscv_pmu_incr_ctr_rv64(RISCVCPU *cpu,
> > uint32_t ctr_idx)
> >    * env->priv and env->virt_enabled contain old priv and old virt and
> >    * new priv and new virt values are passed in as arguments.
> >    */
> > +#if defined(__powerpc64__) || defined(__ppc64__)
> > + #define NO_GCSE_ATTR __attribute__((optimize("no-gcse")))
> > +#else
> > + #define NO_GCSE_ATTR
> > +#endif
> > +
> > +NO_GCSE_ATTR
> >   static void riscv_pmu_icount_update_priv(CPURISCVState *env,
> >                                            target_ulong newpriv, bool n=
ew_virt)
> >   {
> >
> > But a mitigation is all that it is, ideally, I'd report this as a gcc b=
ug.
> > Yet the - understandable - hard requirement of getting the
> > pre-processed files makes this quite complex. As I can't even exactly
> > point to where exactly things go wrong.
> > I'd ask if one of you has experience in providing gcc-bugs out of a
> > qemu build. Is it as obvious as throwing -save-temps into *flags or is
> > there more to consider get what would be needed?
>
> Yes, it's like that.  Run "ninja -v
> ./libqemu-riscv64-softmmu.a.p/target_riscv_pmu.c.o", stick -save-temps
> at the end and submit the resulting .i file as an attachment to the GCC b=
ug.

Thanks for confirming, that allowed me to report it to gcc upstream as
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D121689

Let us see what they say, and if anyone else is affected I hope you
can use the mitigation I shared until then.

> Paolo
>


--=20
Christian Ehrhardt
Director of Engineering, Ubuntu Server
Canonical Ltd

