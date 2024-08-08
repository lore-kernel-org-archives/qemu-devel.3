Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE921C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 12:06:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc1tZ-0003yX-7C; Thu, 08 Aug 2024 08:05:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sc1tU-0003x8-KH
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 08:05:26 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sc1tJ-0002kc-5b
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 08:05:18 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5bb8e62575eso267445a12.3
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 05:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723118709; x=1723723509; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ie9/zshnXJahaSjDJyr5B0VRG7Ex38kTtZj2BwALYOY=;
 b=A+SDeZXrrZIuT0ZoY/zIiiuyYmqkIjw91XmfvP8bGccIkByT+8GjLVXtHCOvYoyayL
 N8qTG6Ne58RTx8AxRuijSJQuWhsjkBHinLX1Et7H9chf/E8J4ggYgBnSgLuFa3cwhLRO
 lKbM153onnW1daZbFZT4QOkneIIau0etxWRVTJoPnmLVIf+r6fsHvwBtYu/t2KCCmm0/
 KiJx/moDwbrHVQZJJa0iE7bBrMMBv7sv5huqLdN+UswNKqvxY3f/iIfj5jroaVgY8jcb
 ruWqCytZR+8ZeJRfj/xEiGSmAYY3k4cYMoYu4GtfViogEpB8oZixVFMiKGvfH92xME/e
 gOAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723118709; x=1723723509;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ie9/zshnXJahaSjDJyr5B0VRG7Ex38kTtZj2BwALYOY=;
 b=SzG91MOTQugn9HguzYLP2kcdnemtUNHb660X8UKXdAUPU6F2QWEsnK/pMv+QeCO6IR
 dlaeC7Lkg5FX6hH68871BWdWrZ0YP38fOrw557+nZqvbA9McGdbzVINt29UjfcwijfKd
 PyYlYtNqlviGb7IYtzu3Taaxp/kpDMlixiH1rbArnK2pwfD2mNg0hppU9hNTa7p9xmmM
 +38+d9m+7uAW2iuF7XGYMDduwodcBNdbPLn1ZaeUCLTvGCXxHkfuMcIKanfqIjee1d0I
 5KpmAQ2FWB311e1FOfijugmUtaOgegiaVSqxsKO7CAQbjA4hBPCpHhfCqq5+4rJeMfu7
 Wh7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKXr/cWXOpm2ibFYg2xJ9b/8DVenv8RE1oOZu9yj1ZnRdsZ9OCQZ8lBedRHxy+vUPYN4iPiYNvqbS8KQTRlxZ6pYVAgkw=
X-Gm-Message-State: AOJu0Yyb0T0UzKW5onIpMEMYVZ2KzRkL+ppnQZ3l7nuX6rpMiDbge7h9
 es1fXm2ctQsMZVaks23GgWBdBGhKb1T1dTEk+YK6ShDkrdtipbvXT2WXTVvxAN29eDMbaLzIEhM
 UZc67fBOSrlDbrX+KLRl+tFarQYPYewzXiBHwtQ==
X-Google-Smtp-Source: AGHT+IGMDM0cbDlPBhRjwdc+E6prr95O7WFyn8nu2feRlNjHFPyE7jel1d7FCeABtOX6UXE8zNxPeK66X/SmYOk1m7U=
X-Received: by 2002:a05:6402:13d3:b0:5a1:f9bc:7f13 with SMTP id
 4fb4d7f45d1cf-5bbb235ae4dmr2037485a12.22.1723118709019; Thu, 08 Aug 2024
 05:05:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240806141940.22095-1-philmd@linaro.org>
 <20240806141940.22095-2-philmd@linaro.org>
 <f82397e9-3be4-49be-b291-5598acdaf39b@linaro.org>
 <CAFEAcA9emwsK07+itUzMxReOLG8gHaxNdDE8ymuwyuBfsoY2Pg@mail.gmail.com>
 <87bk23skhq.fsf@pond.sub.org>
 <CAFEAcA8J4i-81rOEHBpqbV=c4F26o6qd3Lg9dZV+BuNyZPGg7Q@mail.gmail.com>
 <87ed6z1j77.fsf@pond.sub.org>
 <CAFEAcA_=GYBGpbvfKMGsYrUKWgcTLrriBKd37jOVFV1YMfy8Mw@mail.gmail.com>
 <ZrSqsEedC3rmVbD9@redhat.com>
 <CAFEAcA-c7bYaWdOp0ShzUE83kKaYmqoH5DpW+EnU_sVzJgdu4A@mail.gmail.com>
 <ZrSwl0VBX4_1Tc71@redhat.com>
In-Reply-To: <ZrSwl0VBX4_1Tc71@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Aug 2024 13:04:58 +0100
Message-ID: <CAFEAcA9wG8okctQW7kEKX0xQWph6dgdt1v6vfe0eg2xKzmXYMw@mail.gmail.com>
Subject: Re: [RFC PATCH-for-9.1? 1/2] target/arm: Move
 qmp_query_gic_capabilities() to hw/intc/
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, qemu-arm@nongnu.org, 
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 8 Aug 2024 at 12:54, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>
> On Thu, Aug 08, 2024 at 12:32:35PM +0100, Peter Maydell wrote:
> > On Thu, 8 Aug 2024 at 12:23, Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om> wrote:
> > > On Thu, Aug 08, 2024 at 11:15:17AM +0100, Peter Maydell wrote:
> > > > It's not possible to use KVM with that machine type, so the
> > > > question is a bit moot. (This also indicates that the
> > > > interface is not very helpful -- it purports to tell the
> > > > management layer whether it can use an accelerated in-kernel
> > > > GIC, but because it doesn't specifiy the board type there's
> > > > no way to provide an accurate answer. It would be useful
> > > > to know exactly what libvirt/etc actually use this for...)
> > >
> > > Libvirt uses this exclusively with the arm 'virt' machine type.
> > >
> > > If the user didn't express any GIC preference, then if KVM is in use,
> > > we'll pick the highest GIC version QEMU reports as supported.
> >
> > You can get that without querying QEMU by asking for 'gic-version=3Dmax=
'
> > if you like.
>
> This isn't in the VM startup path. It is when we expand the user
> provided XML config into an ABI stable XML config by filling in
> the blanks left by the user. So we need to actually query the
> values available.
>
> > > If TCG
> > > is in use we'll always pick v2, even if QEMU reports v3 is emulatable
> > > due to the v3 impl lacking MSI controller which we need for PCI-e
> >
> > Our emulated GICv3 supports the ITS which has MSI support, so I'm not
> > sure what forcing GICv2 is getting you here. Looking at the linked
> > RHEL bugzilla bug, I suspect this is an out-of-date policy from before
> > we added the ITS emulation in 2021 (it's present by default
> > in virt-2.8 and later machine types). So that is something that
> > libvirt should update I think.
>
> It looks like it is virt-6.2 or later, and libvirt can probe it
> by looking for existence of the arm-gicv3-its QOM type IIUC.

Yes. (I was confused by the 'no_its' setting in virt-2.8, but
that is for "is there a KVM ITS", and no_tcg_its is separate
and as you say added with 6.2.)

-- PMM

