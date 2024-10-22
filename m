Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F6AD2C548
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 12:59:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3ETB-0004Bl-Kx; Tue, 22 Oct 2024 08:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1t3ET3-0004BI-Ff
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 08:58:35 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1t3ESz-0004A2-4J
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 08:58:31 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-71e74900866so3724368b3a.1
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 05:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1729601907; x=1730206707;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hbii7gfZoWiiW2ourDll7zlEm01lJXQYh9cR0oOFQ0k=;
 b=DMNaCU/aOR4kEAJOTDShbzaCuagIwcdowCp+pk2No5I7ULpZipgfmSG0ygHGxdXBfc
 G2/i1I/8DqF54LT/MxxOaSH7NI/qKjhDmKnB21RqJOn4J8pdK+GKaBhcxuiPy5OMJRKr
 2o3rlRe562TssfHFmKzlVIKEws28qDSm7y74V72jEJuWtiX5R2FrL8euFCh2Isy+bdDl
 3r057ILKqtZ6hazW1AgXg1x+Om+LAbNmmtU+kW3h8w97K5eQ8E2JQqmUhW9VzfPld8f9
 itPQTXbbH6JYR4bI3dKTAHqG/xlknaXUN2IFObMIdRm+STIVo+OKO+A03PVyj0yAkrzx
 xrMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729601907; x=1730206707;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hbii7gfZoWiiW2ourDll7zlEm01lJXQYh9cR0oOFQ0k=;
 b=uVtlF51m/grHo4yGKI8s2fpY08w8OJM2nlK0L61zv3hF6vfLCEJSqy/tvIpiqLpmbb
 A3uxbrT4xhMsbOIQaEOhhOkrDUqRNyxAVWSsevIjHovhLPG7WFpprKi8Q+JZ4brrYggH
 hqqT7f3GlUXzSrsvqTxfklAgE59nrTtaAqr3QjTjp+0PTQD1IrjPM6kmSKAE2st/IS6i
 Q7TKVw2uHch6OzWimlQPVHbN8WcQ6KtZeUg3Sx4ckbYJSwbEpz3PqztbdP0oGXA8BZzT
 Wjgky8cVFAwoDruFrdZnHj/WaQ5XO30YWTe1c0JLZM66cGHb0YMPsEZwl6HfXJXEp+N7
 OFhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxFLcmN27/M9uleVRzKt4eY42h2Yw69XJu93minC6wdR4JhjxsPZ8Wo9K3ZQnbrZkuUUDg5Ecq8c95@nongnu.org
X-Gm-Message-State: AOJu0Yy9dR233gLGkzO5SKUmFQZyjhN1Wi9jpmrczXYx7Qi2VDLAx66N
 AObiWexGl7XsteiiIx9G0KmoAau727gH1Rfh6xYI7ukYrLPR51eHuGvFwk4jSsK2dqMG8OfUL+L
 eKeh87l5DZ4sGB7KKY+QHrzAhPyHY2Bk6pG6Vww==
X-Google-Smtp-Source: AGHT+IHY1nSqzn4QRvqRvsXTsrEcE9dQxJFpSD3Q+3tgOqTnP2VJ29fn9XFNzCzmqzjq2Iamzt8qN2rdHGbXnIbU5lE=
X-Received: by 2002:a05:6a00:190f:b0:71e:4196:ddb2 with SMTP id
 d2e1a72fcca58-71ea3298a1bmr18143987b3a.9.1729601906694; Tue, 22 Oct 2024
 05:58:26 -0700 (PDT)
MIME-Version: 1.0
References: <20241009-pmu_event_machine-v1-0-dcbd7a60e3ba@rivosinc.com>
 <20241009-pmu_event_machine-v1-6-dcbd7a60e3ba@rivosinc.com>
 <fd89dafa-279d-436c-9569-f2fdc289bac9@yadro.com>
 <CAHBxVyE2C3sRJNbLOwhOZCnXAUTsEdh-mCewVAEJDDAURL10ug@mail.gmail.com>
 <3B504AA0-06F9-4316-9B10-ED46B1B271A4@syntacore.com>
In-Reply-To: <3B504AA0-06F9-4316-9B10-ED46B1B271A4@syntacore.com>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Tue, 22 Oct 2024 05:58:14 -0700
Message-ID: <CAHBxVyER0Lxp0uwed7ANW6d6pD1gvSVQ8b245scd+tm7HpT9ag@mail.gmail.com>
Subject: Re: [PATCH RFC 06/10] target/riscv: Define PMU event related
 structures
To: Aleksei Filippov <alexei.filippov@syntacore.com>
Cc: Alexei Filippov <alexei.filippov@yadro.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, 
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=atishp@rivosinc.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Mon, Oct 21, 2024 at 6:45=E2=80=AFAM Aleksei Filippov
<alexei.filippov@syntacore.com> wrote:
>
>
>
> > On 11 Oct 2024, at 23:45, Atish Kumar Patra <atishp@rivosinc.com> wrote=
:
> >
> > On Thu, Oct 10, 2024 at 5:44=E2=80=AFAM Alexei Filippov
> > <alexei.filippov@yadro.com> wrote:
> >>
> >>
> >>
> >> On 10.10.2024 02:09, Atish Patra wrote:
> >>> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> >>> ---
> >>>  target/riscv/cpu.h | 25 +++++++++++++++++++++++++
> >>>  1 file changed, 25 insertions(+)
> >>>
> >>> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> >>> index 2ac391a7cf74..53426710f73e 100644
> >>> --- a/target/riscv/cpu.h
> >>> +++ b/target/riscv/cpu.h
> >>> @@ -189,6 +189,28 @@ typedef struct PMUFixedCtrState {
> >>>          uint64_t counter_virt_prev[2];
> >>>  } PMUFixedCtrState;
> >>>
> >>> +typedef uint64_t (*PMU_EVENT_CYCLE_FUNC)(RISCVCPU *);
> >>> +typedef uint64_t (*PMU_EVENT_INSTRET_FUNC)(RISCVCPU *);
> >>> +typedef uint64_t (*PMU_EVENT_TLB_FUNC)(RISCVCPU *, MMUAccessType acc=
ess_type);
> >>> +
> >>> +typedef struct PMUEventInfo {
> >>> +    /* Event ID (BIT [0:55] valid) */
> >>> +    uint64_t event_id;
> >>> +    /* Supported hpmcounters for this event */
> >>> +    uint32_t counter_mask;
> >>> +    /* Bitmask of valid event bits */
> >>> +    uint64_t event_mask;
> >>> +} PMUEventInfo;
> >>> +
> >>> +typedef struct PMUEventFunc {
> >>> +    /* Get the ID of the event that can monitor cycles */
> >>> +    PMU_EVENT_CYCLE_FUNC get_cycle_id;
> >>> +    /* Get the ID of the event that can monitor cycles */
> >>> +    PMU_EVENT_INSTRET_FUNC get_intstret_id;
> >>> +    /* Get the ID of the event that can monitor TLB events*/
> >>> +    PMU_EVENT_TLB_FUNC get_tlb_access_id;
> >> Ok, this is kinda interesting decision, but it's not scalable. AFAIU
> >
> > Yes it is not scalable if there is a need to scale as mentioned earlier=
.
> > Do you have any other events that can be emulated in Qemu ?
> >
> > Having said that, I am okay with single call back though but not too su=
re
> > about read/write callback unless there is a use case to support those.
> >
> >> none spec provide us full enum of existing events. So anytime when
> >> somebody will try to implement their own pmu events they would have to
> >> add additional callbacks, and this structure never will be fulled
> >> properly. And then we ended up with structure 1000+ callback with only=
 5
> >> machines wich supports pmu events. I suggest my approach with only
> >> read/write callbacks, where machine can decide by itself how to handle
> >> any of machine specific events.
> >
> > Lot of these events are microarchitectural events which can't be
> > supported in Qemu.
> > I don't think it's a good idea at all to add dummy values for all the
> > events defined in a platform
> > which is harder to debug for a user.
>
> Yes, you're right that the rest of the events are microarchitectural and =
that they can't be properly simulated in QEMU at the moment, but it seems t=
o me that's not really the point here. The point is how elastic this soluti=
on can be - that is, whether to do any events or not and how exactly they s=
hould be counted should be decided by the vendor of a particular machine, a=
nd not by the simulator in general. Plus, I have a very real use case where=
 it will come in handy - debugging perf. Support the possibility of simulat=
ing events on QEMU side will make the life of t perf folks much easier. I d=
o not insist specifically on my implementation of this solution, but I thin=
k that the solution with the creation of a callback for each of the events =
will significantly complicate the porting of the PMU for machine vendors.
> >

As I mentioned in other threads, I am absolutely okay with single call
backs. So Let's do that. However, I am not in favor of adding
microarchitectural events that we can't support in Qemu with
completely bogus data. Debugging perf in Qemu can be easily done with
the current set of events supported. Those are not the most accurate
but it's a representation of what Qemu is running. Do you foresee any
debugging issue if we don't support all the events a platform
advertises ?

> >
> >>> +} PMUEventFunc;
> >>> +
> >>>  struct CPUArchState {
> >>>      target_ulong gpr[32];
> >>>      target_ulong gprh[32]; /* 64 top bits of the 128-bit registers *=
/
> >>> @@ -386,6 +408,9 @@ struct CPUArchState {
> >>>      target_ulong mhpmeventh_val[RV_MAX_MHPMEVENTS];
> >>>
> >>>      PMUFixedCtrState pmu_fixed_ctrs[2];
> >>> +    PMUEventInfo *pmu_events;
> >>> +    PMUEventFunc pmu_efuncs;
> >>> +    int num_pmu_events;
> >>>
> >>>      target_ulong sscratch;
> >>>      target_ulong mscratch;
>
>

