Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B846CC48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 11:56:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcOjc-0006Sb-4D; Tue, 20 Feb 2024 06:56:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rcOjZ-0006SM-Vk
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 06:56:25 -0500
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rcOjY-0007jO-2P
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 06:56:25 -0500
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2d243797703so17544341fa.3
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 03:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708430182; x=1709034982; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bymRY9Qqw4BdFm18zaS03JMajlZ6OPZF8f+G7bQq/zk=;
 b=GYwhXf1aGe4C+KuWF1632WGDLCpuf/VwScBLuYcxQGOlbDBuU5leK4sx9B/pVjat6k
 89R0cqIEodDZyzUAISuzz1qEF0dITZCXFNkvfZiCn95gvqbUJ1F46dsB7BWPfhlgIOIt
 q68PTBQKWibx/P0MJPtiIb034xVBAHI+o2fx3G5UUtMBWa2YA/YvdKU0X0Vvr8KhnouJ
 H4MYuoJ1qmYDPhK7ywefEaKTECLWQjK9bAZLcOuwQgBDWMLl5BQq6MK8ppRno7kixuJ0
 ZFckPPOR5u4DJrdHAXO9BTZpOkqgYvjy28npZQFLPXisgyb1VWlag926Hj9k6peejGqi
 jcpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708430182; x=1709034982;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bymRY9Qqw4BdFm18zaS03JMajlZ6OPZF8f+G7bQq/zk=;
 b=IhAzUz9l9YdlBlHSI/Api1fTrJTPUte2ceRyKEPyU6yboWCCgs6eC/xXHnirQRL24t
 zzy7Q3fKu/Qa8ZydwROBZgLi5eN/X6B0lnASVGf1wB5LdhmWKr8BFWDza2eZeBa1G0P2
 Hb1M/0Disc1cxJvChx8+HT+ZDZdPAPB3yJdGFQ2iYuAa74H6xbPbfWekJ/Oipx40W7cR
 N3NhRR4CV/6mm4sLWDegIKc02RwY1/UwxwDa2MwqI1zU8pIpKnkrCVivQKL+E3oTLamI
 iimsGknVQ5uz3YjOYwUYlocWtAXytrbvPgNpq/58bNYjc9jsumdFNCnbIZGijGhU0AO0
 kxLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9Qt2uKhyMTRitpNQ4ArbbtMxgEMubxzqzFs9MpaRuxdBcUPNtdkIJJkqaSfVYbIDXbXlb12u0T02AT+/QC6eOHz/mEK4=
X-Gm-Message-State: AOJu0Yy1DOj0CAE1RuWck0s2UJcIa2fh50oAwGt54ukrEuWpfY6KBIFc
 jRf3w5OKj0RRfdEXHiWpiIFyThpVKJrs811lJVnpfVJAMyd6f25xDnjoD7eoi+8=
X-Google-Smtp-Source: AGHT+IHXWmYpALArkBYNG3H/2+0kXGPOOYUdkituEaM6R+uqompHK0Khl1c+DTIZlz+FSVDdiwv91Q==
X-Received: by 2002:a2e:9c8d:0:b0:2d2:42ff:484c with SMTP id
 x13-20020a2e9c8d000000b002d242ff484cmr2824105lji.37.1708430182216; 
 Tue, 20 Feb 2024 03:56:22 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 e4-20020adfe384000000b0033cfa00e497sm13147105wrm.64.2024.02.20.03.56.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 03:56:21 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 869805F8B9;
 Tue, 20 Feb 2024 11:56:21 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 <qemu-devel@nongnu.org>,  Peter Maydell <peter.maydell@linaro.org>,
 "Gregory Price" <gregory.price@memverge.com>,  Sajjan Rao
 <sajjanr@gmail.com>,  Dimitrios Palyvos <dimitrios.palyvos@zptcorp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 3/3] tcg: Avoid double lock if page tables happen to be
 in mmio memory.
In-Reply-To: <20240219121455.0000387d@Huawei.com> (Jonathan Cameron's message
 of "Mon, 19 Feb 2024 12:14:55 +0000")
References: <20240215150133.2088-1-Jonathan.Cameron@huawei.com>
 <20240215150133.2088-4-Jonathan.Cameron@huawei.com>
 <4b00b67d-cb3c-4173-bb7f-1ae68cdfbada@linaro.org>
 <20240219121455.0000387d@Huawei.com>
User-Agent: mu4e 1.11.28; emacs 29.1
Date: Tue, 20 Feb 2024 11:56:21 +0000
Message-ID: <87zfvvcpsq.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Jonathan Cameron <Jonathan.Cameron@Huawei.com> writes:

> On Thu, 15 Feb 2024 09:30:27 -1000
> Richard Henderson <richard.henderson@linaro.org> wrote:
>
>> On 2/15/24 05:01, Jonathan Cameron wrote:
>> > On i386, after fixing the page walking code to work with pages in
>> > MMIO memory (specifically CXL emulated interleaved memory),
>> > a crash was seen in an interrupt handling path.
>> >=20
>> > Useful part of bt
>> >=20
>> > Peter identified this as being due to the BQL already being
>> > held when the page table walker encounters MMIO memory and attempts
>> > to take the lock again.  There are other examples of similar paths
>> > TCG, so this follows the approach taken in those of simply checking
>> > if the lock is already held and if it is, don't take it again.
>> >=20
>> > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> > ---
>> >   accel/tcg/cputlb.c | 9 +++++++--
>> >   1 file changed, 7 insertions(+), 2 deletions(-)
>> >=20
>> > diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
>> > index 047cd2cc0a..3b8d178707 100644
>> > --- a/accel/tcg/cputlb.c
>> > +++ b/accel/tcg/cputlb.c
>> > @@ -2019,6 +2019,7 @@ static uint64_t do_ld_mmio_beN(CPUState *cpu, CP=
UTLBEntryFull *full,
>> >                                  int mmu_idx, MMUAccessType type, uint=
ptr_t ra)
>> >   {
>> >       MemoryRegionSection *section;
>> > +    bool locked =3D bql_locked();
>> >       MemoryRegion *mr;
>> >       hwaddr mr_offset;
>> >       MemTxAttrs attrs;
>> > @@ -2030,10 +2031,14 @@ static uint64_t do_ld_mmio_beN(CPUState *cpu, =
CPUTLBEntryFull *full,
>> >       section =3D io_prepare(&mr_offset, cpu, full->xlat_section, attr=
s, addr, ra);
>> >       mr =3D section->mr;
>> >=20=20=20
>> > -    bql_lock();
>> > +    if (!locked) {
>> > +        bql_lock();
>> > +    }
>> >       ret =3D int_ld_mmio_beN(cpu, full, ret_be, addr, size, mmu_idx,
>> >                             type, ra, mr, mr_offset);
>> > -    bql_unlock();
>> > +    if (!locked) {
>> > +        bql_unlock();
>> > +    }=20=20
>>=20
>> On top of other comments, I'm never keen on this type of test/lock/test/=
unlock.  When this=20
>> kind of thing is encountered, it means we should have been using a recur=
sive lock in the=20
>> first place.
>
> Hi Richard,
>
> Whilst I agree this stuff is really ugly, is it practical to fix it
> for this case?

You can use:

  BQL_LOCK_GUARD();

which does all the recursive checking and clean-up and for free also
ensures you don't miss an unlock leg.

> Or was intent here to make a general comment on QEMU locking?
>
> Jonathan
>
>
>>=20
>>=20
>> r~

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

