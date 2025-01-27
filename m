Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E9DC02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 13:33:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcPF9-0000Gk-Cp; Mon, 27 Jan 2025 08:33:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tcPEz-0000FJ-6W
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 08:33:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tcPEv-0004tZ-RL
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 08:33:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737984799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4BGfrc5EFqQcfeAMVD2lB8mxJX0frQFb/EJN9v3iCyY=;
 b=CEKyGpTOeiqEuOJVEYR0+k1fZ9/4px3rfxdCHHcRzsqfzezmxgd9B7bszXee0RRkkHmbhd
 4ODfbJdUxxUe1jOuMyMQGqxwhNFHLi8keBOjvA4MwrHcKkzmhBm/yVd99/MdjlyzhOvt4o
 yP1z2HInayLvBfrGNiSM/o0PWjLZr2Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-uT4TbXR8P--iqzg8XPSA0A-1; Mon, 27 Jan 2025 08:33:18 -0500
X-MC-Unique: uT4TbXR8P--iqzg8XPSA0A-1
X-Mimecast-MFC-AGG-ID: uT4TbXR8P--iqzg8XPSA0A
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4361f371908so30360585e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 05:33:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737984797; x=1738589597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4BGfrc5EFqQcfeAMVD2lB8mxJX0frQFb/EJN9v3iCyY=;
 b=OoPFYSPdNzpNKIfke7zqKdTn7dy1i2Jm+MVKNlmOFOPnDUkik8WzBOHCLpoE7JIVaK
 tmj6i2Ay3ISVTaPMu8biDKdPB80foKOeNe0A1dxPqCoDr8FsjBFxXza0VINp2fez8Jy+
 75Dx2Lm30luf8eOsdjFt4VftX3Vs1OW2riy1wwsyXQdUVfy4VuP0gY9TyzTV+4FNnptd
 CwSk+oDX/wb2LSx+1HLRBBKALLnWw1N3utPoP8XN4ld9TvCCoXf1AYs/0CJ8d23iRaaz
 f2Z7qyQKLcbVe061KuNg8CJrKDAIJA5xt/9offd8agXFyCEAmOFmn0aFN5k5gQdwNiDa
 +yzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLMT4ZHQQWm1XNNNHd1XiVL7V17vljRU4QZF75TyHLBLrcylrWO/FnDGWlCEd+PbtZiIkfl1UOBoFM@nongnu.org
X-Gm-Message-State: AOJu0Yy2QVyBfUMXQY1hcReZdOVMDAcavw9znR0XvjoP03laaZVM5dTa
 VyKbOGPjlHcbTKZequ4ilbji+k7P5F1/9nRQsQ/c/QZ0JzUAhgNgVQ2j1evIV9+lSzrlinLts+i
 0vrHVYAl1hSECEE/z4TtrezaE+r00iALK7v/KE7E2vN2t2qIxcjWP
X-Gm-Gg: ASbGnctNl702dkile1hgSrC5xl1utJSI4e1S3r01bkTMsy1UsjvFt9nZPA0A7g49c44
 uhCl/Wx8cyTdiNqwxAewMtvv2HRfR2aIjwbpN31v0TUb01AK+6KrTw/j1fBGqRkEuAo5higgvuU
 eSEDhlWvvhZ0jRILXy6eF2jnazKcEPOQpsX3k98HZiJuNTtAtBZ0Wtkb6JmJZnqrr+C472q2Jl6
 u27yS3MLwMSlG154eKzjwbgRHpJOZMVUHmuRutzqcYVZvCiFIjnyRas+aG+s4pzscrnxL6Lw5Zf
 Po5h5JxOaGr7ViI2cpDFa6lKu50vJI9G1/H/hFA8l4fz/XpH26G5
X-Received: by 2002:a05:600c:4f42:b0:434:a7e3:db5c with SMTP id
 5b1f17b1804b1-438913cafacmr422967415e9.11.1737984796949; 
 Mon, 27 Jan 2025 05:33:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFWQeWAvZwfOSWTVoXy6+e0nIr+8TfoRPF3pvVjQEcG36wfeuX2JxFlUQhm03Tt3Rhe0Qs4g==
X-Received: by 2002:a05:600c:4f42:b0:434:a7e3:db5c with SMTP id
 5b1f17b1804b1-438913cafacmr422967075e9.11.1737984796543; 
 Mon, 27 Jan 2025 05:33:16 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd501c2dsm130506045e9.13.2025.01.27.05.33.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 05:33:15 -0800 (PST)
Date: Mon, 27 Jan 2025 14:33:14 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>, Peter Xu
 <peterx@redhat.com>, qemu-devel@nongnu.org, richard.henderson@linaro.org,
 pbonzini@redhat.com
Subject: Re: [PATCH] tcg: drop qemu_cpu_is_self() in
 tlb_flush_by_mmuidx[_async_work]
Message-ID: <20250127143314.2eea59ff@imammedo.users.ipa.redhat.com>
In-Reply-To: <f3567791-13f0-4696-81fe-19f4111705e7@linaro.org>
References: <20250123094511.156324-1-imammedo@redhat.com>
 <87frl9ls4g.fsf@draig.linaro.org>
 <20250123122343.6af8a6e1@imammedo.users.ipa.redhat.com>
 <87y0z1k9yg.fsf@draig.linaro.org>
 <20250123143846.586282b2@imammedo.users.ipa.redhat.com>
 <f3567791-13f0-4696-81fe-19f4111705e7@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, 27 Jan 2025 14:24:56 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> +Peter
>=20
> On 23/1/25 14:38, Igor Mammedov wrote:
> > On Thu, 23 Jan 2025 12:09:59 +0000
> > Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> >  =20
> >> Igor Mammedov <imammedo@redhat.com> writes:
> >> =20
> >>> On Thu, 23 Jan 2025 10:52:15 +0000
> >>> Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> >>>    =20
> >>>> Igor Mammedov <imammedo@redhat.com> writes:
> >>>>     =20
> >>>>> QEMU will crash with following debug enabled
> >>>>>    # define DEBUG_TLB_GATE 1
> >>>>>    # define DEBUG_TLB_LOG_GATE 1
> >>>>> due to [1] introduced assert and as it happenstlb_flush_by_mmuidx[_=
async_work]
> >>>>> functions are called not only from vcpu thread but also from reset =
handler
> >>>>> that is called from main thread at cpu realize time when vcpu is al=
ready
> >>>>> created
> >>>>>    x86_cpu_new -> ... ->
> >>>>>        x86_cpu_realizefn -> cpu_reset -> ... ->
> >>>>>            tcg_cpu_reset_hold
> >>>>>
> >>>>> drop assert to fix crash. =20
> >>>>
> >>>> Hmm the assert is there for a good reason because we do not want to =
be
> >>>> flushing another CPUs state. However the assert itself:
> >>>>
> >>>>    g_assert(!(cpu)->created || qemu_cpu_is_self(cpu));
> >>>>
> >>>> was trying to account for pre-initialised vCPUs. What has changed?
> >>>>
> >>>> cpu_thread_signal_created(cpu) is called just before we start running
> >>>> the main loop in mttcg_cpu_thread_fn. So any other thread messing wi=
th
> >>>> the CPUs TLB can potentially mess things up. =20
> >>>
> >>> it reproduces on current master, so yes it likely has changed over ti=
me.
> >>> I've just stumbled on it when attempting to get rid of cpu->created
> >>> usage. =20
> >>
> >> Why the drive to get rid of cpu->created? =20
> >=20
> > During review of Philippe's cpu cleanups,
> > I've noticed that  cpu->created is mostly used for signaling
> > main loop thread we've started vcpu thread with a couple of
> > odd cases in tcg and kvm.
> >    - 1st silently bit-rotted being behind ifdefs
> >    - 2nd is work around CPU being prematurely visible to others =20
>=20
> 2nd is:
>=20
> commit 56adee407fc564da19e49cfe18e20e3da92320be
> Author: Peter Xu <peterx@redhat.com>
> Date:   Fri Feb 17 00:18:32 2023 +0800
>=20
>      kvm: dirty-ring: Fix race with vcpu creation
>=20
>      It's possible that we want to reap a dirty ring on a vcpu that is=20
> during
>      creation, because the vcpu is put onto list (CPU_FOREACH visible)=20
> before
>      initialization of the structures.  In this case:
>=20
>      qemu_init_vcpu
>          x86_cpu_realizefn
>              cpu_exec_realizefn
>                  cpu_list_add      <---- can be probed by CPU_FOREACH
>              qemu_init_vcpu
>                  cpus_accel->create_vcpu_thread(cpu);
>                      kvm_init_vcpu
>                          map kvm_dirty_gfns  <--- kvm_dirty_gfns valid
>=20
>      Don't try to reap dirty ring on vcpus during creation or it'll crash.
>=20
> Looking at cpu_list_add() in cpu_exec_realizefn():
>=20
> hw/core/cpu-common.c-190-    /* Wait until cpu initialization complete=20
> before exposing cpu. */
> hw/core/cpu-common.c:191:    cpu_list_add(cpu);
>=20
> IMO the problem is with cpu_list_add(), we shouldn't expose the vCPU
> until it is realized.

that was my reasoning as well

>=20
> cpu_list_add() seems to be doing 2 things, auto-assign CPU index if
> UNASSIGNED_CPU_INDEX, then insert to global cpus_queue.
>=20
> IIRC cpu_list_add() is called early because various cpu init code
> expects cpu->index to be assigned.
>=20
> Maybe we could extract the 'safely assign an unique cpu index' part
> (guarding by qemu_cpu_list_lock), having cpu_list_add() just add to
> the global queue. I'll give it a try...

ok,
lets see if we can postpone cpu_list_add() till the end of realize time.

>=20
> >  =20
> >> I guess we could assert:
> >>
> >>    g_assert(!current_cpu || qemu_cpu_is_self(cpu);
> >>
> >> as current_cpu should only be set as we go into the main thread. Howev=
er
> >> there is a sketchy setting of current_cpu in cpu_exec() that I'm not
> >> sure should be there. Also do_run_on_cpu() messes with current_cpu in a
> >> way I don't fully understand either. =20
> >=20
> > I'd rather not rely on that, even if it works it would be subject to
> > to the same kind of breakage.
> >=20
> > How about instead of workaround check we would have 2 variants
> > of tlb_flush_by_mmuidx[_async_work], one that have self check
> > and other for usage externally (i.e. from reset handler).
> > That won't have to rely on sketchy globals (which becomes more
> > sketchy in context of Philippes's multi accel work),
> > and it would clearly document what can be used externally.
> >  =20
> >> =20
> >>>
> >>>    =20
> >>>>> 1)
> >>>>> Fixes: f0aff0f124028 ("cputlb: add assert_cpu_is_self checks")
> >>>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> >>>>> ---
> >>>>>   accel/tcg/cputlb.c | 4 ----
> >>>>>   1 file changed, 4 deletions(-)
> >>>>>
> >>>>> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> >>>>> index b26c0e088f..2da803103c 100644
> >>>>> --- a/accel/tcg/cputlb.c
> >>>>> +++ b/accel/tcg/cputlb.c
> >>>>> @@ -381,8 +381,6 @@ static void tlb_flush_by_mmuidx_async_work(CPUS=
tate *cpu, run_on_cpu_data data)
> >>>>>       uint16_t all_dirty, work, to_clean;
> >>>>>       int64_t now =3D get_clock_realtime();
> >>>>>  =20
> >>>>> -    assert_cpu_is_self(cpu);
> >>>>> -
> >>>>>       tlb_debug("mmu_idx:0x%04" PRIx16 "\n", asked);
> >>>>>  =20
> >>>>>       qemu_spin_lock(&cpu->neg.tlb.c.lock);
> >>>>> @@ -419,8 +417,6 @@ void tlb_flush_by_mmuidx(CPUState *cpu, uint16_=
t idxmap)
> >>>>>   {
> >>>>>       tlb_debug("mmu_idx: 0x%" PRIx16 "\n", idxmap);
> >>>>>  =20
> >>>>> -    assert_cpu_is_self(cpu);
> >>>>> -
> >>>>>       tlb_flush_by_mmuidx_async_work(cpu, RUN_ON_CPU_HOST_INT(idxma=
p));
> >>>>>   } =20
> >>>>     =20
> >> =20
> >=20
> >  =20
>=20


