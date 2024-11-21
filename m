Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A3BCE6400D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 19:54:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEDFp-0007xR-RY; Thu, 21 Nov 2024 14:54:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tEDFn-0007wt-Kp
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 14:54:15 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tEDFl-0008Q4-Gx
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 14:54:15 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-724df74b9aeso71329b3a.2
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 11:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1732218851; x=1732823651;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zI1mDY9U5PLx2jVo21zl0fti2fZEdZBz0xmbQGyiF8c=;
 b=oatXIjlEkT25QU2VoZt/HWbfskN8Q+hIoDdOY551Ap1eiWu6Dc3Tc3p/gL8ORCT3Ru
 CvUoYuygCoqMR0lwPD1+o+4zZadbRsnlaTfrjw+lQ3NJmhBqaixreveUjL8EUbcmYiGO
 YCAyb+lyRdI8xzxhTGl/NwjLXq4i3gncULMw3WH1gonSaFHwvYiolLqhm6v+8dy/g9UP
 ZJWcY4LUb0yG8Y8NXiUJo8rmCTs19/kAFmXukUWb3WB/mcRlc1DSkD3yCq7eeNpesRre
 qGe4Gm6JProyFk/LLT7y+aVlLk87xsBC1Z5cduaWG3ZmlgsMKPt7RIANl2hoDUsm2J/H
 FGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732218851; x=1732823651;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zI1mDY9U5PLx2jVo21zl0fti2fZEdZBz0xmbQGyiF8c=;
 b=AkxwqexrQEwWvUBFPiqTb6E/37zWprA4nAXN9HuZ6vgXFWdWwIeaajiLiT2n0GRfZt
 4mGDjt9T/VTSCgq4Msdgc2Jjd5KsyDmM/mKKDPD/dLYuy9geJMaexACNWwjxX/BynKgV
 DgQrh5NLIfUnFYig5lIdGBlNru3zw/qtCGB33G1u/svwy0/+cxn5FuJrRTQck1T/Ea6H
 RRD9SddO8hopU3Pdxf5lmNZwFkbSbDrSW7QQwyO1N4XF5hbrVOyqUzIoTyk2PR3wsvOb
 KclEAR2BUDmIuWEUUrfDBvQ7JpSQxGz3RRNo/FC/yUnX360j/atkF5ConDHL2fvNLvQC
 z3/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVowuGsAmItlQukEOtxLOP81tdVzrCm9e3bg0mPTeH+ags7/t8KfsX9lkyAnnl5CjkQDoFDQQng7+M/@nongnu.org
X-Gm-Message-State: AOJu0YzUGDGMmxQqBkYl26BoORff5iM5GNTC6EvDNbo4QqlntRFDtxW3
 Yn+B0amDIT3DUNP/Eyr+Hv6AYlog5mdEvUT32+2HPwfERO24QQG8zsYKPP69T4bt76bJwOUtwf1
 atzxs8CvODBiCadjfa7wJ16a0sxZrqhlXZnzQUw==
X-Gm-Gg: ASbGncu8/rMSJJL4IfyLCt8G0LHjzDOhfbwmCvzSJtnaxZyI0IkqtfTwkzS7UgyeDtA
 FTW2ehBKp7OcvszM4AuN9MeESgE9n
X-Google-Smtp-Source: AGHT+IGQB1Atgjlvrjg0mk1cr4DkB/pipTO6qelcCPJsyGhS/G/L0s/lVcSnqHDdnxzAABCPvSWAjMhR9D7aMRmTrBE=
X-Received: by 2002:a05:6a00:3392:b0:724:6dd7:ca1d with SMTP id
 d2e1a72fcca58-724df72891bmr272732b3a.25.1732218851256; Thu, 21 Nov 2024
 11:54:11 -0800 (PST)
MIME-Version: 1.0
References: <20241009-pmu_event_machine-v1-0-dcbd7a60e3ba@rivosinc.com>
 <20241009-pmu_event_machine-v1-6-dcbd7a60e3ba@rivosinc.com>
 <fd89dafa-279d-436c-9569-f2fdc289bac9@yadro.com>
 <CAHBxVyE2C3sRJNbLOwhOZCnXAUTsEdh-mCewVAEJDDAURL10ug@mail.gmail.com>
 <3B504AA0-06F9-4316-9B10-ED46B1B271A4@syntacore.com>
 <CAHBxVyER0Lxp0uwed7ANW6d6pD1gvSVQ8b245scd+tm7HpT9ag@mail.gmail.com>
 <0214DDE7-28F3-48C1-96ED-E700764D95D3@syntacore.com>
In-Reply-To: <0214DDE7-28F3-48C1-96ED-E700764D95D3@syntacore.com>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Thu, 21 Nov 2024 11:54:00 -0800
Message-ID: <CAHBxVyGU1nbY5HC7dk4fhWNEJP8EPP-eNxhNU992usQi7Cim7w@mail.gmail.com>
Subject: Re: [PATCH RFC 06/10] target/riscv: Define PMU event related
 structures
To: Aleksei Filippov <alexei.filippov@syntacore.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, 
 dbarboza@ventanamicro.com, alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=atishp@rivosinc.com; helo=mail-pf1-x433.google.com
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

On Wed, Nov 20, 2024 at 6:25=E2=80=AFAM Aleksei Filippov
<alexei.filippov@syntacore.com> wrote:
>
>
>
> > On 22 Oct 2024, at 15:58, Atish Kumar Patra <atishp@rivosinc.com> wrote=
:
> >
> > On Mon, Oct 21, 2024 at 6:45=E2=80=AFAM Aleksei Filippov
> > <alexei.filippov@syntacore.com> wrote:
> >>
> >>
> >>
> >>> On 11 Oct 2024, at 23:45, Atish Kumar Patra <atishp@rivosinc.com> wro=
te:
> >>>
> >>> On Thu, Oct 10, 2024 at 5:44=E2=80=AFAM Alexei Filippov
> >>> <alexei.filippov@yadro.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 10.10.2024 02:09, Atish Patra wrote:
> >>>>> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> >>>>> ---
> >>>>> target/riscv/cpu.h | 25 +++++++++++++++++++++++++
> >>>>> 1 file changed, 25 insertions(+)
> >>>>>
> >>>>> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> >>>>> index 2ac391a7cf74..53426710f73e 100644
> >>>>> --- a/target/riscv/cpu.h
> >>>>> +++ b/target/riscv/cpu.h
> >>>>> @@ -189,6 +189,28 @@ typedef struct PMUFixedCtrState {
> >>>>>       uint64_t counter_virt_prev[2];
> >>>>> } PMUFixedCtrState;
> >>>>>
> >>>>> +typedef uint64_t (*PMU_EVENT_CYCLE_FUNC)(RISCVCPU *);
> >>>>> +typedef uint64_t (*PMU_EVENT_INSTRET_FUNC)(RISCVCPU *);
> >>>>> +typedef uint64_t (*PMU_EVENT_TLB_FUNC)(RISCVCPU *, MMUAccessType a=
ccess_type);
> >>>>> +
> >>>>> +typedef struct PMUEventInfo {
> >>>>> +    /* Event ID (BIT [0:55] valid) */
> >>>>> +    uint64_t event_id;
> >>>>> +    /* Supported hpmcounters for this event */
> >>>>> +    uint32_t counter_mask;
> >>>>> +    /* Bitmask of valid event bits */
> >>>>> +    uint64_t event_mask;
> >>>>> +} PMUEventInfo;
> >>>>> +
> >>>>> +typedef struct PMUEventFunc {
> >>>>> +    /* Get the ID of the event that can monitor cycles */
> >>>>> +    PMU_EVENT_CYCLE_FUNC get_cycle_id;
> >>>>> +    /* Get the ID of the event that can monitor cycles */
> >>>>> +    PMU_EVENT_INSTRET_FUNC get_intstret_id;
> >>>>> +    /* Get the ID of the event that can monitor TLB events*/
> >>>>> +    PMU_EVENT_TLB_FUNC get_tlb_access_id;
> >>>> Ok, this is kinda interesting decision, but it's not scalable. AFAIU
> >>>
> >>> Yes it is not scalable if there is a need to scale as mentioned earli=
er.
> >>> Do you have any other events that can be emulated in Qemu ?
> >>>
> >>> Having said that, I am okay with single call back though but not too =
sure
> >>> about read/write callback unless there is a use case to support those=
.
> >>>
> >>>> none spec provide us full enum of existing events. So anytime when
> >>>> somebody will try to implement their own pmu events they would have =
to
> >>>> add additional callbacks, and this structure never will be fulled
> >>>> properly. And then we ended up with structure 1000+ callback with on=
ly 5
> >>>> machines wich supports pmu events. I suggest my approach with only
> >>>> read/write callbacks, where machine can decide by itself how to hand=
le
> >>>> any of machine specific events.
> >>>
> >>> Lot of these events are microarchitectural events which can't be
> >>> supported in Qemu.
> >>> I don't think it's a good idea at all to add dummy values for all the
> >>> events defined in a platform
> >>> which is harder to debug for a user.
> >>
> >> Yes, you're right that the rest of the events are microarchitectural a=
nd that they can't be properly simulated in QEMU at the moment, but it seem=
s to me that's not really the point here. The point is how elastic this sol=
ution can be - that is, whether to do any events or not and how exactly the=
y should be counted should be decided by the vendor of a particular machine=
, and not by the simulator in general. Plus, I have a very real use case wh=
ere it will come in handy - debugging perf. Support the possibility of simu=
lating events on QEMU side will make the life of t perf folks much easier. =
I do not insist specifically on my implementation of this solution, but I t=
hink that the solution with the creation of a callback for each of the even=
ts will significantly complicate the porting of the PMU for machine vendors=
.
> >>>
> >
> > As I mentioned in other threads, I am absolutely okay with single call
> > backs. So Let's do that. However, I am not in favor of adding
> > microarchitectural events that we can't support in Qemu with
> > completely bogus data. Debugging perf in Qemu can be easily done with
> > the current set of events supported. Those are not the most accurate
> > but it's a representation of what Qemu is running. Do you foresee any
> > debugging issue if we don't support all the events a platform
> > advertises ?
> In general - there is only one potential problem. When perf would try to =
get event by the wrong id. The main algorithm indeed could be tested with l=
imited  quantities of events. But this

It won't get a wrong id as the Qemu platform won't support those.
Hence, you can not run perf for those events to begin with.

> gonna be a real pain for the testers which gonna deduce and remember what=
 particular event can/can=E2=80=99t be counted in QEMU and why does he gets=
 0 there and not 0 here. Moreover,

> perf list will show which events are supported on a particular platform. =
So user won't be confused. We

> we would allow events with even complete bogus data this would works perf=
ectly for CI stuff for the benchmark + perf ppl, and they wouldn=E2=80=99t =
restrict their CI to that. I really do  not see

IMO, it is more confusing to show bogus data rather than restricting
the number of events an user can run on Qemu platforms. Clearly, you
think otherwise. I think we can agree to disagree here. Let's
consolidate our patches to provide the infrastructure for the actual
events. The bogus event support can be a separate series(per vendor)
as that warrants a different discussion whether it is useful for users
or not.

Sounds good ?

any problem to let the vendor handle this situation. At least vendor
can decide by his own to count/not to count some types of event, this
gonna bring flexibility and the transparency of the solution and, in
general, if we=E2=80=99ll bring some rational reason why we can't add such
events we can always forbid to do such thing.
> >
> >>>
> >>>>> +} PMUEventFunc;
> >>>>> +
> >>>>> struct CPUArchState {
> >>>>>   target_ulong gpr[32];
> >>>>>   target_ulong gprh[32]; /* 64 top bits of the 128-bit registers */
> >>>>> @@ -386,6 +408,9 @@ struct CPUArchState {
> >>>>>   target_ulong mhpmeventh_val[RV_MAX_MHPMEVENTS];
> >>>>>
> >>>>>   PMUFixedCtrState pmu_fixed_ctrs[2];
> >>>>> +    PMUEventInfo *pmu_events;
> >>>>> +    PMUEventFunc pmu_efuncs;
> >>>>> +    int num_pmu_events;
> >>>>>
> >>>>>   target_ulong sscratch;
> >>>>>   target_ulong mscratch;
> >>
> >>
>

