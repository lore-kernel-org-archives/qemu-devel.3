Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08C4BD5CCBC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 15:24:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6AYv-0004Rs-Qs; Wed, 30 Oct 2024 11:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1t6AYY-0004Np-E4
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 11:24:24 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1t6AYW-0001z4-1W
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 11:24:22 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2e91403950dso2385708a91.3
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 08:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1730301858; x=1730906658;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Cw2vvZv6gfHQGMjxOTvnrzcju70OmJYpI6oHQDmYUg=;
 b=IZ6juVdsUqkhRVUHi8fjmu2ie5ceLNBV8JWAizAe3YuyEQvM6fsJmQ5xT4zwFQCwyv
 XPxXzCvasnTLTMTkTE93AIpmDtns4vhNhYZ9qUwtdQYsN9K2/6kEPwfH2s37K06uAO2u
 L0H/7CrlyuIkw2C2wNDZjAT2RomZkL6zuLpWdGlKlen8hgy9CC4kdXRSxatMfVR+F6S0
 Qbqw7AWeiP6qhBaDwb6Dm5qNcDpO32bAKgWe7jMCd2+86uxuVWVRpvVh5054b9ZQwOK1
 Gt3pjhbvFJ3LGQIv3+JK4Wz8+g8wuDB1lIzjUa13anUtJtXb3HzJ+CNYzW80wNvJGR9J
 hwaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730301858; x=1730906658;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Cw2vvZv6gfHQGMjxOTvnrzcju70OmJYpI6oHQDmYUg=;
 b=pL16Mxzmkq+WGEI4+FgKm9LItuws3zpbe/oq9G1Nzct+VX9a1Z2WtvlZMmhaCDjZLo
 o//VQFSV8TGQqi+CrSVeXHfy9bssSHQua5Kb8v391uRPs7OZ+Z8dihTphDyuZHe7rCJ+
 XBEij5QUS8ukMyHlBjBYPR/meKkLJP/1DlOP7hiPtxJY4x56wey8no2Zo3YpPTxLZOMr
 4H3w9m1Hc7HoCOiDLEgAf5ASU9r1eT4VTtoMMbbw+iJEcKa6tGsIxMII+arzTIIL2WQz
 DcIOONKchAw+9XgXPvs+hwnj3k7DZl1SWaL3dSEQoasivNhi15wJLD0o9vu4oQ7kMUmW
 Y/vQ==
X-Gm-Message-State: AOJu0YyhWITgMNwJ4LGvKAAKBwFIpDPCl79iNshGr/EDO3ZsxqhHWEc9
 zwbyMOCNEbou7r60T610B+cz6sctRkv4jODjVrHzlaYyRL6y9LpbKDxkhZsBWcgCc9SaxT21SJM
 jrDGMyE2d1JKKCh9bxrzoJMVQUuu7nS9CrMXh
X-Google-Smtp-Source: AGHT+IHWRjodhSfUWllWupsZ4n+IRuioGetdJ4Xq2y5XYQHTQgZiD4v/xIl13t+pZTAHbwin7ZRI8GxY4HGnHnVYgnc=
X-Received: by 2002:a17:90b:4c89:b0:2e2:d112:3b5c with SMTP id
 98e67ed59e1d1-2e8f11dcf0bmr18532970a91.37.1730301858014; Wed, 30 Oct 2024
 08:24:18 -0700 (PDT)
MIME-Version: 1.0
References: <20241029130401.525297-1-pbonzini@redhat.com>
 <CAGCz3vtb9Afiq0JbthJQrn=hkXJ=X6cEKywuCs++bAqsf_+HMg@mail.gmail.com>
 <5eedaf78-78f5-40c1-a240-942b55a2450e@redhat.com>
In-Reply-To: <5eedaf78-78f5-40c1-a240-942b55a2450e@redhat.com>
From: Phil Dennis-Jordan <lists@philjordan.eu>
Date: Wed, 30 Oct 2024 16:24:06 +0100
Message-ID: <CAGCz3vtXUitQF1-Bru=5bzAbMgwSEVX=R-PH6SD1KqKAaxppHQ@mail.gmail.com>
Subject: Re: [PATCH] target/i386/hvf: hide MPX states from XCR0
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: neutral client-ip=2607:f8b0:4864:20::102f;
 envelope-from=lists@philjordan.eu; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

On Wed, 30 Oct 2024 at 14:35, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 10/30/24 13:30, Phil Dennis-Jordan wrote:
> > On Tue, 29 Oct 2024 at 14:05, Paolo Bonzini <pbonzini@redhat.com> wrote=
:
> >>
> >> QEMU does not show availability of MPX in CPUID when running under
> >> Hypervisor.framework.  Therefore, in the unlikely chance that the host
> >> has MPX enabled, hide those bits from leaf 0xD as well.
> >
> > To clarify: is there some kind of issue with MPX in Qemu in general?
> > Or is this a consistency effort - normal Macs don't expose this
> > feature, so we have no idea if it were to work if someone did manage
> > to hack up some frankensteinian host system that somehow does have
> > those bits set?
>
> That, and also that real hardware will only show XSTATE_BNDREGS_MASK and
> XSTATE_BNDCSR_MASK if the MPX bit is set in CPUID; which it isn't in
> hvf_get_supported_cpuid().

Understood, and makes sense. Perhaps you could add this to the commit
message as well?

> In fact, for completeness it should also go the other way: if
> XSTATE_YMM_MASK is not set in the result of XGETBV, AVX should be
> hidden.  And if any of OPMASK, ZMM_Hi256 and Hi16_ZMM are not set in the
> result of XGETBV, AVX512F (and AVX10 eventually) should be hidden in
> hvf_get_supported_cpuid().

Indeed. macOS does also have AVX512 support, and I believe there were
two Mac models which shipped with Xeon CPUs that exposed some version
of the feature, the iMac Pro and the 2019 Mac Pro. I don't have access
to such a machine however, so I=E2=80=99m not sure exactly what the host
support entails. (I don't know if HVF guests theoretically could
support AVX512 features supported by the CPU but not the host OS as
long as it only uses register state correctly saved by the host OS?)

> By the way, could you check if Macs set the PKRU bit of XCR0 (bit 9)
> and/or the OSPKE bit in CPUID (that's bit 4 of CPUID[EAX=3D7, ECX=3D0].EC=
X)?

On a 2019 MacBook Pro 15" with a Coffee Lake Intel Core i9 9880H CPU,
the OSPKE bit is not set. (cpuid 7,0 returns: ebx =3D 0x029c67af, ecx =3D
0x40000000, edx =3D 0xbc000e00)

Assuming I'm doing this right, xcr0 on this machine appears to be 0x7,
so there's no PKRU bit set.

While trying to log xcr0, I noticed that xgetbv checks the passed ecx
value against CPUID_EXT_OSXSAVE. Except as far as I'm aware, OSXSAVE
is in cpuid function 1's ecx, whereas the code path in
hvf_get_supported_cpuid() is, by my reading, passing the ecx value for
cpuid function 0xD, index 0. The xgetbv call thus returns false on my
machine (ecx =3D 0x440), and eax is not modified. (stays 0x1f rather
than 0x7)

It seems like we ought to either fetch the CPUID_EXT_OSXSAVE bit in
another cpuid call, or cache it. Or do I have this wrong?

Thanks,
Phil

