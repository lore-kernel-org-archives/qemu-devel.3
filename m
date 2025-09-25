Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0968DCAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 15:11:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1nbR-00009I-Vu; Thu, 25 Sep 2025 11:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1v1nbP-00009A-E7
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 11:09:47 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1v1nbG-0006d1-4g
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 11:09:47 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-62f24b7be4fso2133473a12.0
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 08:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758812972; x=1759417772; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gzYrpcQZJh2ZpUmlgDBwXE4Quanz+3Vl/W0wqZZ244g=;
 b=josN8630Kko9kt3CYAfocqZOezkwxLvbOD4mR7ua93tdSK6wRkjaRBbbCMDTJ/DbbB
 Q18lDsFOn0Z+6QehZJBMt6X4zRAlLbNwihL1ihScaT5n96vf6SHWXnvkxE3ae+uRbDnn
 6/QNDtfrT2bAZfDRImO9cNhk/pX4I3paCm8zCOInOwO2I5jsfchBlh8C0SHEGSrG5eti
 KZcz1Xq4CnbSzuQ6aqNzBn5rkTUQS7lYJl2ppa6QABHte/xmsHiDE1B3ERaFeYAegwZX
 aKia+mBGc/w84iENpjJwwI2L8SLygsR19ytqCQAxFclZGfa+t9KF6QSF2aeN+k8gn2Vx
 VpvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758812972; x=1759417772;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gzYrpcQZJh2ZpUmlgDBwXE4Quanz+3Vl/W0wqZZ244g=;
 b=wGziRGpajYH/33IYTAh3zIBxLXD+FtvHgoSnkG1hYfS+2b3+ff42BwUuM2k9pkyfgE
 JsbOk13E7BSJZnWy61KInzbrPJPa1yILlQ+z7swFXabf1wXcP3NBS4oINSyt0orpm247
 CGJdzwd1IEt25dfs9vU7xisVO0POl5zl2XS/1Dw+nUTvLh7QKeAt0QJz1CeiFuFA7HdV
 0klMbVqsHnz0jl3g5MeAz4m1947OfR7Wpd+whyfC4qDeuZwRmV+1yomVt0shKhkoC7oI
 8z90BwW2gP0g7QwkRb7lwjKSAOvQmZD+Q4B0ICz/+1mlhPU5berm0bfqCJOtPaWzHecB
 WkOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3g8e6j2cAA+SSceFkV8/vMa8nNkQuX47wMF6UmmBCBEjnm45G0CnyP54qqwGRMGD5WTUT7gVqDPYF@nongnu.org
X-Gm-Message-State: AOJu0YwZQQjgU1bswMDiCGbgI4QOEgbu2wvCdoWmC5Kr86QD5ew4ERzW
 34Mn/0EGVF/UZiTHN4TiC3hIxl2xmFabnu8duBTfV4/1HdkmY9fVWK8pvny+uyNbi0SV/CoV+/l
 Hah+0zyYTTxADh86DU9BZIXCWCrQXctc=
X-Gm-Gg: ASbGnctdo2a22O2kLTY0hrkbhT4nu93qzd65ejuGWz4v8sltagwaXoTRuBjGlljfhRG
 NcZaSTFFTv5JdPH8yTtCuoS8V50IEEaX9NbOVaqZBqVgjHD0IwGGCUUOhfPaSe5hdVriOy73baj
 0iLll8/4IkJpD+Pr3SofTUfL/r5pWrvDi0T8rV/Z7UHgONdhMZVR4XwpHy6kmTRfznZEhQwUJo4
 A32nQ==
X-Google-Smtp-Source: AGHT+IHDrpVbXetI3Rdn7rxkn5ohIDvt6utx5HKUYw0Ubmxju00InzgL3/d1y+ENaajxMHJzELOiNwMOxtOE75xBlgA=
X-Received: by 2002:a05:6402:4543:b0:632:df3d:7b04 with SMTP id
 4fb4d7f45d1cf-6349f9ef66dmr3041930a12.14.1758812971574; Thu, 25 Sep 2025
 08:09:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250919112536.141782-1-pbonzini@redhat.com>
 <20250919112536.141782-9-pbonzini@redhat.com>
 <20250923192354.GL509965@fedora>
 <85ebee67-3c30-4f14-93ca-d9cf65708619@redhat.com>
 <20250924181024.GB6015@fedora>
 <CABgObfbDphuWOx9r8JEpQCtvGtZM2XYkEd+mBxO4LeqoVPvW6A@mail.gmail.com>
 <20250925115047.GA22729@fedora>
 <4d7d946f-db87-43b6-a5f4-4f6cc583df20@redhat.com>
In-Reply-To: <4d7d946f-db87-43b6-a5f4-4f6cc583df20@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 25 Sep 2025 11:09:19 -0400
X-Gm-Features: AS18NWD3bB9uw1xWw5AWgVaEsneGxFLSlF01dfZ0NKdx18wvXzFMiklN0m4ojvw
Message-ID: <CAJSP0QU-XSrY3NZFoSiFDPLduJw_md0+7YEGr3PZ3UEWGyvEsQ@mail.gmail.com>
Subject: Re: [PATCH 08/16] tracetool: Add Rust format support
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, 
 Tanish Desai <tanishdesai37@gmail.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Mads Ynddal <mads@ynddal.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu, Sep 25, 2025 at 8:40=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> On 9/25/25 13:50, Stefan Hajnoczi wrote:
> > On Wed, Sep 24, 2025 at 09:58:04PM +0200, Paolo Bonzini wrote:
> >> On Wed, Sep 24, 2025, 20:10 Stefan Hajnoczi <stefanha@redhat.com> wrot=
e:
> >>
> >>>> fn trace_event_state_is_enabled(dstate: u16) -> bool {
> >>>>       unsafe { trace_events_enabled_count } !=3D 0 && dstate !=3D 0
> >>>> }
> >>>
> >>> The generated code is missing DTrace's SDT semaphore (see
> >>> generate_h_backend_dstate() in scripts/tracetool/backend/dtrace.py). =
The
> >>> conditional must be taken when a tool like SystemTap or GDB sets the =
SDT
> >>> semaphore. Right now it will not be taken because the conditional onl=
y
> >>> looks at _ ## id ## _DSTATE and not the SDT semaphore.
> >>>
> >>
> >> This is private code to trace-*.rs, for use within the tracepoint func=
tions
> >> only; it's not a public "is the tracepoint active" API. The public sid=
e in
> >> C does look at the semaphore.
> >
> > You're right, the code is fine just with the function renamed.
>
> No problem---in fact I have now realized that, for systemtap, I have to
> ensure that the semaphore is shared between C and Rust!

Is anyone working on the DTrace support? If not, I'll keep it in mind
in case I get some time over the next few weeks.

Stefan

