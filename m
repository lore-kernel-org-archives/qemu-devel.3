Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF9BAC021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 17:27:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmyhY-0002rm-Tn; Tue, 25 Feb 2025 12:26:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tmyhM-0002qm-9t
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 12:26:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tmyhJ-0005Uf-Mk
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 12:26:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740504380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j5rDfqM/g4NJICFigwh1qXNjERvlORIjPQ0Er2R+Qe0=;
 b=UgjverAtCTM0tpYk6GGI6vgGk6kFYUtM4tk/76mYo1PfXU3R3p4omGv3WkWdeUZHhUhpUt
 RpBWwQ0cQed+DcdatjTw1tpkD82r7sqYOPE9EsnFwNz5tIT/pf4CZjQ1spMcWFzLoYQ47j
 mp2PgKsorJx0BHdc5/vY2QWSVNLbiYU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-WIwwu3I0NF2z3PdziV4arQ-1; Tue, 25 Feb 2025 12:26:19 -0500
X-MC-Unique: WIwwu3I0NF2z3PdziV4arQ-1
X-Mimecast-MFC-AGG-ID: WIwwu3I0NF2z3PdziV4arQ_1740504378
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4393b6763a3so25544425e9.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 09:26:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740504378; x=1741109178;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j5rDfqM/g4NJICFigwh1qXNjERvlORIjPQ0Er2R+Qe0=;
 b=Q2z1FquK9IYodKtWFzNuF3IF32IAE2CIvl1scb5umF6kAPAHWmJgt88i5IyTysG6pb
 KxwpPnRwFSric2+hmilQvSi+iDkxM9dziq8IiRntODZNwU8oeSdWpSwHqEH+K55fhrGN
 709XhWrSgs9UY6q27ZGJjnugYI3L5uOUgMtjK2jcMheO6CSkkieyDFQbCkL3QtYzIfx+
 5N8ZT1XIa0W+BTzlK0v27Lxuhexrw3TXOsqJl6EAhWdz17D0kQj7hEdI4EDU8ojOzRXj
 25Hjdvh7FDcSR3KrkF1NPDZEidUMaN4PREpoyzc/vyKhRWBo3g8fmbe3kdzXaQvkBJSv
 WLhQ==
X-Gm-Message-State: AOJu0YzihZo8sVDpJsIHY3zVjAEltabdmHWiazZ3YnmrhyZFSDXsbs6n
 KkNa43Yy2b9oT2ma72K1caWNJxijNi/NOCR2ZIhsXggwuCTMOMBasUriwAIz8MSnS/SmaT8ytd3
 5yNJL9E69DB0xaIUUrUnfWdDZWliErdf6YROx0EZCiAr5ZePT+wdG
X-Gm-Gg: ASbGncsIAAbVZKbXZoAWmWIJr6DfRTpD9OsDFttyhDxjxUUPHb93qzzumPLVUI/T6wQ
 XOkEitH5M5xSx5bp1bzBSrlc2wW8RCaURo81KvsT8LynQ1oEDQVDsDcqnbolTqJcBaD4fwIxVpI
 5mZbkOX7nqDa1A9rbJ+6e2dxPLXfCuy9xDSoL0/vdH1VEXNffwLHCAL2W6bNwocEiRRVn9rXvL7
 3mI5PgHBfk8NfO6Z+S0ipkeGjKUgrLSV+EbYp0FSylnF+TsLYqBMp0ct75qOi5H1Dbrutc1MZmn
 5TFXdNRGaV3zpRv34r4BO4/Hf1428etVaZQmb7vY4tz3IRZoZWRRGDV6qEY3Ue0=
X-Received: by 2002:a05:600c:3c90:b0:439:a202:86dd with SMTP id
 5b1f17b1804b1-439b155b048mr140407865e9.26.1740504377639; 
 Tue, 25 Feb 2025 09:26:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEaJQ0oly/LMGM1ZPMbCKKub0lGUAvY6CXnWX15PdC9fRO4t0gaexc6fYBVP/rPh1bTWdscVw==
X-Received: by 2002:a05:600c:3c90:b0:439:a202:86dd with SMTP id
 5b1f17b1804b1-439b155b048mr140407565e9.26.1740504377198; 
 Tue, 25 Feb 2025 09:26:17 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab14caa5esm36176575e9.0.2025.02.25.09.26.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 09:26:16 -0800 (PST)
Date: Tue, 25 Feb 2025 18:26:15 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Philippe =?UTF-8?B?TWF0aGlldS1E?=
 =?UTF-8?B?YXVkw6k=?= <philmd@linaro.org>, npiggin@gmail.com, BALATON Zoltan
 <balaton@eik.bme.hu>
Subject: Re: [PATCH v2 05/10] Revert "tcg/cputlb: remove other-cpu
 capability from TLB flushing"
Message-ID: <20250225182615.0bfce880@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250225181903.444729fe@imammedo.users.ipa.redhat.com>
References: <20250207162048.1890669-1-imammedo@redhat.com>
 <20250207162048.1890669-6-imammedo@redhat.com>
 <87seo25h73.fsf@draig.linaro.org>
 <20250225181903.444729fe@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, 25 Feb 2025 18:19:03 +0100
Igor Mammedov <imammedo@redhat.com> wrote:

> On Tue, 25 Feb 2025 12:42:24 +0000
> Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>=20
> > Igor Mammedov <imammedo@redhat.com> writes:
> >  =20
> > > 1)
> > > This reverts commit 30933c4fb4f3df95ae44c4c3c86a5df049852c01.
> > >   ("tcg/cputlb: remove other-cpu capability from TLB flushing")
> > >
> > > The commit caused a regression which went unnoticed due to
> > > affected being disabled by default (DEBUG_TLB_GATE 0)
> > > Previous patch switched to using tcg_debug_assert() so that
> > > at least on debug builds assert_cpu_is_self() path would be exercised.
> > >
> > > And that lead to exposing regression introduced by [1] with abort dur=
ing tests.
> > > to reproduce:
> > >   $ configure  --target-list=3Dx86_64-softmmu --enable-debug
> > >   $ make && ./qemu-system-x86_64
> > >
> > >   accel/tcg/cputlb.c:419: tlb_flush_by_mmuidx:
> > >     Assertion `!(cpu)->created || qemu_cpu_is_self(cpu)' failed.
> > >
> > > which is triggered by usage outside of cpu thread:
> > >     x86_cpu_new -> ... ->
> > >       x86_cpu_realizefn -> cpu_reset -> ... ->
> > >           tcg_cpu_reset_hold   =20
> >=20
> > If the reset case is the only one I don't think we need to revert the
> > rest of the changes as only tlb_flush needs calling. How about something
> > like:
> >=20
> > --8<---------------cut here---------------start------------->8---
> > cputlb: introduce tlb_flush_other_cpu for reset use =20
>=20
> while that works for my reproducer it's not sufficient,
> 'make check' is some tests fails anyway
>=20
> ex:
>=20
> 10/378 qemu:qtest+qtest-x86_64 / qtest-x86_64/ahci-test ERROR 13.47s kill=
ed by signal 6 SIGABRT
> stderr:
> qemu-system-x86_64: qemu/accel/tcg/cputlb.c:419: tlb_flush_by_mmuidx: Ass=
ertion `qemu_cpu_is_self(cpu)' failed.
> Broken pipe
> qemu/tests/qtest/libqtest.c:208: kill_qemu() detected QEMU death from sig=
nal 6 (Aborted) (core dumped)

here is v3 rebased on top of the patch

https://gitlab.com/imammedo/qemu/-/commits/qemu_cpu_cond_v3?ref_type=3Dheads

it seems that reset path is not the only one that relied on 'cpu->created' =
workaround


>=20
>=20
>=20
> >=20
> > The commit 30933c4fb4 (tcg/cputlb: remove other-cpu capability from
> > TLB flushing) introduced a regression that only shows up when
> > --enable-debug-tcg is used. The main use case of tlb_flush outside of
> > the current_cpu context is for handling reset and CPU creation. Rather
> > than revert the commit introduce a new helper and tweak the
> > documentation to make it clear where it should be used.
> >=20
> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >=20
> > 3 files changed, 26 insertions(+), 5 deletions(-)
> > include/exec/exec-all.h   | 20 ++++++++++++++++----
> > accel/tcg/cputlb.c        |  9 +++++++++
> > accel/tcg/tcg-accel-ops.c |  2 +-
> >=20
> > modified   include/exec/exec-all.h
> > @@ -64,12 +64,24 @@ void tlb_flush_page_all_cpus_synced(CPUState *src, =
vaddr addr);
> >   * tlb_flush:
> >   * @cpu: CPU whose TLB should be flushed
> >   *
> > - * Flush the entire TLB for the specified CPU. Most CPU architectures
> > - * allow the implementation to drop entries from the TLB at any time
> > - * so this is generally safe. If more selective flushing is required
> > - * use one of the other functions for efficiency.
> > + * Flush the entire TLB for the specified current CPU.
> > + *
> > + * Most CPU architectures allow the implementation to drop entries
> > + * from the TLB at any time so this is generally safe. If more
> > + * selective flushing is required use one of the other functions for
> > + * efficiency.
> >   */
> >  void tlb_flush(CPUState *cpu);
> > +/**
> > + * tlb_flush_other_cpu:
> > + * @cpu: CPU whose TLB should be flushed
> > + *
> > + * Flush the entire TLB for a specified CPU. For cross vCPU flushes
> > + * you shuld be using a more selective function. This is really only
> > + * used for flushing CPUs being reset from outside their current
> > + * context.
> > + */
> > +void tlb_flush_other_cpu(CPUState *cpu);
> >  /**
> >   * tlb_flush_all_cpus_synced:
> >   * @cpu: src CPU of the flush
> > modified   accel/tcg/cputlb.c
> > @@ -414,6 +414,15 @@ void tlb_flush(CPUState *cpu)
> >      tlb_flush_by_mmuidx(cpu, ALL_MMUIDX_BITS);
> >  }
> > =20
> > +void tlb_flush_other_cpu(CPUState *cpu)
> > +{
> > +    g_assert(!qemu_cpu_is_self(cpu));
> > +
> > +    async_run_on_cpu(cpu,
> > +                     tlb_flush_by_mmuidx_async_work,
> > +                     RUN_ON_CPU_HOST_INT(ALL_MMUIDX_BITS));
> > +}
> > +
> >  void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *src_cpu, uint16_t i=
dxmap)
> >  {
> >      const run_on_cpu_func fn =3D tlb_flush_by_mmuidx_async_work;
> > modified   accel/tcg/tcg-accel-ops.c
> > @@ -85,7 +85,7 @@ static void tcg_cpu_reset_hold(CPUState *cpu)
> >  {
> >      tcg_flush_jmp_cache(cpu);
> > =20
> > -    tlb_flush(cpu);
> > +    tlb_flush_other_cpu(cpu);
> >  }
> > =20
> > --8<---------------cut here---------------end--------------->8---
> >  =20
>=20


