Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D57B4C02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 13:40:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taxQI-0004ZQ-2z; Thu, 23 Jan 2025 08:39:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1taxQ9-0004Z0-6J
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 08:39:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1taxQ6-0005Cn-T4
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 08:38:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737639532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P3SajAGLzvDDtmQYjw+dFkhq+DN+r71DFRzCsoNH+D8=;
 b=BD+P5MagzH2/0rSdZiTtEuv2JLGmyrM95okkxMBuJXDz5Q7GIbqtV4MXkuwTcbs4T/rnEy
 uPjsdO+wsV3YrjOUbRarM6C47U/IK5bmdyQH+ZEY2bPBWFTB7b0J9pOOTGRETviOMLVWty
 vWBhm7hdXpQbQh2w2mDjpmXIsH34Mj4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-8AmmbHDnPx2j0g8uIUZ3sg-1; Thu, 23 Jan 2025 08:38:50 -0500
X-MC-Unique: 8AmmbHDnPx2j0g8uIUZ3sg-1
X-Mimecast-MFC-AGG-ID: 8AmmbHDnPx2j0g8uIUZ3sg
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4362552ce62so4652755e9.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 05:38:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737639528; x=1738244328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P3SajAGLzvDDtmQYjw+dFkhq+DN+r71DFRzCsoNH+D8=;
 b=XO2RysTXcN2jX+iEmfwT9RVFA8gj3YWXFAHYZPp9NNd4CTNu52e4l4u1kFueEmOb0M
 VTSGo8XNPbtSAN4uP2O5Y1SMjMjSOd/p7WKLTNfJ5r77+H27sAuGWo+gMt4WeKlwvHq5
 XkAqFs9aLDw/8IwjWaqEZWKctXzHQs71x/txNJ4MYWihs9mjYSnTa2Cw5Dk9lTnQU+Cb
 hWhtVye2fK7DHPAZ5583YsZB/dG4lHi+XQSalsj1wz/2h2AtMt2gu923fArVZdgQYvy3
 SaMWNob7A79cmN8EyxvTDVtTL72up4dn7a7djylh4FDxDLiThcNQX2DHfLJh+c+7BK6w
 Ff3w==
X-Gm-Message-State: AOJu0YzvwC7Bvxk+61Zv0OMvJkePCjk5GUkMnHGgvTybMafXvbyvwPqE
 Hw0YB8KljMZGTBcCp0EP1WdzA5oydzrveOi3KlO3tTpUWhbgobPNHKEU+7WGWavgiHmBuhvZZmR
 RdYLs5sN2rg3cTLYhylbNZsDinR3bIz6a217t5m0f9iKTn7xRtALU0gx09CR+
X-Gm-Gg: ASbGnctPYqvjeQVBHgpCHhtpnXOvQvV4a9EH61TjsoVl/CLQQ1cVBdH+gUZN4teK+aa
 bOTeCty44xVKAASYbZ6k/tKL6arm6CthBWwoSUlCiBTq5c1UhlFi3acVN6aL8VXRayp2fLzxp4A
 tOF19szuRB7npK0ws3ldfbcox7yKzzhIxVDiSU2614uWlx6mW/ZfQ0m1M/RqYW0cAy4vMdVSd9r
 iVGbD0CKMh8q+vPC0rfe5li/2Pq5IqTrZkYxhrNM0Js3JW+WztB7iGigpskdAWLUoRPMKNMTEdy
 P4YeexozZWUDz811tbN+PS3bl12uGRXGj1Va9Zj1cw==
X-Received: by 2002:a05:600c:1e1c:b0:434:f0df:9f6 with SMTP id
 5b1f17b1804b1-438913bf655mr253875465e9.3.1737639528003; 
 Thu, 23 Jan 2025 05:38:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFC/Fh3Bqz3pOpHFvIXEefCLUNxxir9ctJSFZPtxK8QdPRYUg5BEfXaiheCGtmlQB82XfqGLA==
X-Received: by 2002:a05:600c:1e1c:b0:434:f0df:9f6 with SMTP id
 5b1f17b1804b1-438913bf655mr253875235e9.3.1737639527612; 
 Thu, 23 Jan 2025 05:38:47 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438b3189ba8sm64438255e9.5.2025.01.23.05.38.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2025 05:38:47 -0800 (PST)
Date: Thu, 23 Jan 2025 14:38:46 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, pbonzini@redhat.com
Subject: Re: [PATCH] tcg: drop qemu_cpu_is_self() in
 tlb_flush_by_mmuidx[_async_work]
Message-ID: <20250123143846.586282b2@imammedo.users.ipa.redhat.com>
In-Reply-To: <87y0z1k9yg.fsf@draig.linaro.org>
References: <20250123094511.156324-1-imammedo@redhat.com>
 <87frl9ls4g.fsf@draig.linaro.org>
 <20250123122343.6af8a6e1@imammedo.users.ipa.redhat.com>
 <87y0z1k9yg.fsf@draig.linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.043,
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

On Thu, 23 Jan 2025 12:09:59 +0000
Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:

> Igor Mammedov <imammedo@redhat.com> writes:
>=20
> > On Thu, 23 Jan 2025 10:52:15 +0000
> > Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> > =20
> >> Igor Mammedov <imammedo@redhat.com> writes:
> >>  =20
> >> > QEMU will crash with following debug enabled
> >> >   # define DEBUG_TLB_GATE 1
> >> >   # define DEBUG_TLB_LOG_GATE 1
> >> > due to [1] introduced assert and as it happenstlb_flush_by_mmuidx[_a=
sync_work]
> >> > functions are called not only from vcpu thread but also from reset h=
andler
> >> > that is called from main thread at cpu realize time when vcpu is alr=
eady
> >> > created
> >> >   x86_cpu_new -> ... ->
> >> >       x86_cpu_realizefn -> cpu_reset -> ... ->
> >> >           tcg_cpu_reset_hold
> >> >
> >> > drop assert to fix crash.   =20
> >>=20
> >> Hmm the assert is there for a good reason because we do not want to be
> >> flushing another CPUs state. However the assert itself:
> >>=20
> >>   g_assert(!(cpu)->created || qemu_cpu_is_self(cpu));
> >>=20
> >> was trying to account for pre-initialised vCPUs. What has changed?
> >>=20
> >> cpu_thread_signal_created(cpu) is called just before we start running
> >> the main loop in mttcg_cpu_thread_fn. So any other thread messing with
> >> the CPUs TLB can potentially mess things up. =20
> >
> > it reproduces on current master, so yes it likely has changed over time.
> > I've just stumbled on it when attempting to get rid of cpu->created
> > usage. =20
>=20
> Why the drive to get rid of cpu->created?

During review of Philippe's cpu cleanups,
I've noticed that  cpu->created is mostly used for signaling
main loop thread we've started vcpu thread with a couple of
odd cases in tcg and kvm.
  - 1st silently bit-rotted being behind ifdefs
  - 2nd is work around CPU being prematurely visible to others

> I guess we could assert:
>=20
>   g_assert(!current_cpu || qemu_cpu_is_self(cpu);
>=20
> as current_cpu should only be set as we go into the main thread. However
> there is a sketchy setting of current_cpu in cpu_exec() that I'm not
> sure should be there. Also do_run_on_cpu() messes with current_cpu in a
> way I don't fully understand either.

I'd rather not rely on that, even if it works it would be subject to
to the same kind of breakage.

How about instead of workaround check we would have 2 variants
of tlb_flush_by_mmuidx[_async_work], one that have self check
and other for usage externally (i.e. from reset handler).
That won't have to rely on sketchy globals (which becomes more
sketchy in context of Philippes's multi accel work),
and it would clearly document what can be used externally. =20

>=20
> >
> > =20
> >> > 1)
> >> > Fixes: f0aff0f124028 ("cputlb: add assert_cpu_is_self checks")
> >> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> >> > ---
> >> >  accel/tcg/cputlb.c | 4 ----
> >> >  1 file changed, 4 deletions(-)
> >> >
> >> > diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> >> > index b26c0e088f..2da803103c 100644
> >> > --- a/accel/tcg/cputlb.c
> >> > +++ b/accel/tcg/cputlb.c
> >> > @@ -381,8 +381,6 @@ static void tlb_flush_by_mmuidx_async_work(CPUSt=
ate *cpu, run_on_cpu_data data)
> >> >      uint16_t all_dirty, work, to_clean;
> >> >      int64_t now =3D get_clock_realtime();
> >> > =20
> >> > -    assert_cpu_is_self(cpu);
> >> > -
> >> >      tlb_debug("mmu_idx:0x%04" PRIx16 "\n", asked);
> >> > =20
> >> >      qemu_spin_lock(&cpu->neg.tlb.c.lock);
> >> > @@ -419,8 +417,6 @@ void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t=
 idxmap)
> >> >  {
> >> >      tlb_debug("mmu_idx: 0x%" PRIx16 "\n", idxmap);
> >> > =20
> >> > -    assert_cpu_is_self(cpu);
> >> > -
> >> >      tlb_flush_by_mmuidx_async_work(cpu, RUN_ON_CPU_HOST_INT(idxmap)=
);
> >> >  }   =20
> >>  =20
>=20


