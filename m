Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84209C2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 18:17:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHnzd-0003jl-AJ; Wed, 21 May 2025 14:16:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uHnza-0003jb-Kw
 for qemu-devel@nongnu.org; Wed, 21 May 2025 14:16:38 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uHnzY-0003ZO-Nh
 for qemu-devel@nongnu.org; Wed, 21 May 2025 14:16:38 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-601dfef6a8dso6401810a12.1
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 11:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747851394; x=1748456194; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UCUyd1fZWwbFPz2RyC6UKrUSziF1ehp3vCOOlsbxCHg=;
 b=dRH1OKVgZzAR3xdKPRYFpA61p1em2jM2zUivJCyCTnKVYd8sa1L5s/+4fafV0f3M6m
 W+3gLVhV1ztN8ElDscj3d9d/oKultJgtILk1S43O9IhYbNqYoEsYOnPWga6ITJG1N/bd
 d9y8CXEknJL4NPhSkPJfCpo12Fw0ndyVeeb3ualdUB53dSFr/lO4EYDnglT6ZPoYeqGD
 VEizd3iIbdfUsffKJSNWtQkDOc9dRpnAXqm5lXJsQsPkJN1JAjzkLqRiTncMpIPrJE/A
 xpyogj0Vpex/cRfEYKplfZZKvmtt+u33/nM99HiEv+B9D1NGo341P8jwYIo/gFQxMJWD
 iRJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747851394; x=1748456194;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UCUyd1fZWwbFPz2RyC6UKrUSziF1ehp3vCOOlsbxCHg=;
 b=XWoZoVZbT78A8JXHpubBQEqD+uLhTmScvgrEMVuhwnQYpB7VSA3oLLTmuB7Dutajth
 TrLlP9X63XpJFLxGf9mypk/lk3IzV7Xpg54NOOWBAI5984UNsz7Im4l46/tCZYhAWEEi
 rYEmHICTyyV+sC0CT6fZTJtodCHQl5dmvIi6fHe80iMMiYi2KklvYMH0V8Og45Zp1avM
 h9+LrISIDXkyq6rPF4JqcyhWqa12D8p3ZjgWs/w/FwdWUR1i67Pg4+tA901DQoSCujUV
 2UasshWats44x7attbQAPSw3JkEj/HBD+k7AhAG5r+yk7R5555QmJ6zUIkxzth5BaTUA
 sB4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwnTzwXZe2sSeI5Tiyr4WiGwPa33q4XepRCbqIGJSlulwou+I5VONGKqLuRmPQt8zNYcWV0rYqLxKr@nongnu.org
X-Gm-Message-State: AOJu0YwU2k5wTTBlSOSHQ3nFIqGZJKjakdd2TgkLLVsTiOFubvoTfGTB
 Qk7UUHva2wbSgjCIvZgq6ZG0pjbcdZaDLd7I3+5R1VDDksPmvrwKIAlK+zeIaNKJ1uMBv0Hemao
 JnSABIJmwSBCRItYSGM0yr8J5pvBMr+I=
X-Gm-Gg: ASbGncspOp4gMYRFHm/Jqw0MaitMuA6RCygsjfWJhssDG0XMPfb27qflnVpFFgFyS4x
 RLmZV2YQttPwsEK27DxiB53HNLH04GdkpXbuR93wozuya90zL5nJh7B5AKw2FwO1lLaJKo0O3ON
 igr+7K2cn6efupsVdl135vuHol0kpx9ijb1Hfwwx+qYw==
X-Google-Smtp-Source: AGHT+IFW0/yQRN+Ped3NhjWuZ0ru5PmJJf0rpRolncfCMEFwIO44HlfKPL3DZY2TH4wT4ccUsm/frXbq278f/AKTIA8=
X-Received: by 2002:a05:6402:847:b0:5e7:b02b:1eb8 with SMTP id
 4fb4d7f45d1cf-600900cade8mr19254126a12.14.1747851393585; Wed, 21 May 2025
 11:16:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250519185108.14412-1-tanishdesai37@gmail.com>
 <CAJSP0QVOSGKnt8YCay5r+HR2O6xCz9Nb5Hp4TOzsSHE9fpYgHw@mail.gmail.com>
 <CABgObfY5uMM+Z4QpxqCya8om4_=0eYFN2dnWGYD0vsYhrmaR7w@mail.gmail.com>
In-Reply-To: <CABgObfY5uMM+Z4QpxqCya8om4_=0eYFN2dnWGYD0vsYhrmaR7w@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 21 May 2025 14:16:21 -0400
X-Gm-Features: AX0GCFuoW_OFfyvGNMFMrQ_tlhG1z64KhBxyizOlipvoXwOmjNyUI8uvgOxG-ag
Message-ID: <CAJSP0QXi=UbkdZ499GzMjW49UeCwvk1=EyE=51-jL-P6PH_UXQ@mail.gmail.com>
Subject: Re: [PATCH] trace/simple: seperate hot paths of tracing fucntions
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Tanish Desai <tanishdesai37@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 Mads Ynddal <mads@ynddal.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x535.google.com
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

On Tue, May 20, 2025 at 4:52=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
> Il mar 20 mag 2025, 21:01 Stefan Hajnoczi <stefanha@gmail.com> ha scritto=
:
>>
>> On Mon, May 19, 2025 at 2:52=E2=80=AFPM Tanish Desai <tanishdesai37@gmai=
l.com> wrote:
>> >
>> > Remove hot paths from .c file and added it in .h file to keep it inlin=
e.
>>
>> Please include performance results in the commit description so it's
>> clear what impact this change has.
>
>
> Hi Stefan,
>
> I am replying because I take the blame for this :) and as an example of h=
ow he could interact with the maintainer.
>
> For now we mostly looked at differences between the code that tracetool g=
enerates for the various backends, and the observation that some of them pu=
t code in the .h and some in the .c file. I explained to Tanish the concept=
 of separating hot vs cold code in theory, showed him some examples in QEMU=
 where performance measurements were done in the past, and suggested applyi=
ng this to various backends (starting with the one with the weirdest choice=
!). However we didn't do any measurement yet.
>
> Some possibilities that come to mind:
>
> 1) maybe the coroutine benchmarks are enough to show a difference, with s=
ome luck
>
> 2) a new microbenchmark (or a set of microbenchmarks that try various lev=
el of register pressure around the tracepoint), which would be nice to have=
 anyway

2 is going above and beyond :). I'm not trying to make life hard.

Another option if 1 or 2 are difficult to quantify: I'd be happy with
just a "before" and "after" disassembly snippet from objdump showing
that the instructions at a call site changed as intended.

What I'm looking for is a commit description that explains the purpose
of the commit followed by, since this is a performance improvement,
some form of evidence that the change achieved its goal. At that point
it's easy for me to merge because it has a justification and the
nature of the commit will be clear to anyone looking at the git log in
the future.

> 3) perhaps we could try to check the code size for some object files in b=
lock/ (for example libblock.a.p/*.c.o), as a proxy for how much instruction=
 cache space is saved when all tracepoints are disabled
>
> We can start from 3, but also try 1+3 and 2+3 if it fails if you think th=
at would be more persuasive.

Can you explain 3 more? Total code size on disk should stay about the
same because most trace events only have one call site. Moving code
between the caller and callee doesn't make a big difference in either
direction. At runtime there is a benefit from inlining the condition
check since the call site no longer needs to execute the callee's
function prologue/epilogue when the trace event is runtime-disabled,
but that CPU cycle and instruction cache effect won't be visible from
the on-disk code size.

Thanks,
Stefan

