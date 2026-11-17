Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4C9606A331
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 14:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X9mDgIOi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTKay-0005OF-A3; Tue, 17 Nov 2026 09:55:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xTKau-0005Ll-Fg
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 09:55:36 -0500
Received: from mail-dy1-x1334.google.com ([2607:f8b0:4864:20::1334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xTKaq-0001qY-Vg
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 09:55:34 -0500
Received: by mail-dy1-x1334.google.com with SMTP id
 5a478bee46e88-38190551625so1143969eec.1
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 06:55:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794927331; cv=none;
 d=google.com; s=arc-20260327;
 b=n30F+ZWOq/Ho5Ta26zX90awV3BLQwrQeyMVCfOgcQpLHG8ObM7kL7ILdEBXqKyKTP5
 EZljDgcHwIu4Y1z1oi2CXn+ybJA9mz4ZBrIuBOaINtD0TuAZg9M+GgjBifEPyN3IcOm+
 NnDzq3vpQrAymPgV5WBZxw9RNDYZedQQSEoc/BBCZEAuwONB3RedYpoeCXyMlBPclRr0
 cULKalf70mDs9pIKRmDyFm/bw2j+wGScS+2kKjiZyxjYhBDT8SfS3TPxJsQKiw7ZMmQ1
 FohCctA5eHGdGHQMIF6VhnNbY5xL7F8XQwy7wrZDmwp7AmxnX1el+u3Utd0Vz3LlHwBG
 Mbow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7HplxTCkkz9T30kJsagqZEeHmYwWpsPTU4WmCwXe3UA=;
 fh=RVbgGptn+3p9iqRvneDjSV7pT/Du8fnIR3Zrk8e69q4=;
 b=I715BeyaRSJHuP67TvDMBLYNczE/xsFbJp1S4f9sD31NLLEyfZpGHbRS+YN6FYEWrQ
 n/DB1k3ltCK7H2dxj78xK9c93Ty7wOjI7bbJ034nvF4o6kECh0R7DMmf1L85dk5MFgs7
 8WMrpgqDRJHrxNSu6qIH6SbQPf+4+U4ohqEYZPv2n143R1lkW9RyflttHCyJUgBwdMXG
 ErlYx5kQrdyuj6On51FP57LeLJ86j53y9Bf+KR6Kk17PwswSkk6gwYBl41gOpVe5sCyu
 Bp5wF4WrtEz52XUfpIQ7YuqCpx0h1+59EXuRjn745frJnq66w1biWiEggxmtI38TmXl8
 2yIA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794927331; x=1795532131; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7HplxTCkkz9T30kJsagqZEeHmYwWpsPTU4WmCwXe3UA=;
 b=X9mDgIOit9wZo4DAHBLFKvIEdZEKuGDp0ftoCRdzTZFEWtjyaVd4+w45sL1lGhjVHy
 fILiYPC6h4i49gyOkTWizPuz7BwQ+W7+mPv00H/I6uDOybmTd6BrO9IDpMG3TkGDT96U
 t723EvYHYKVpdu8RpDswgUkeMo38NqcR/+f9yIBKjFbDfr1yue1SqsZxfMfj6Kz5AQmc
 eCfxJMA4fZjQeuW2ZV+QlriadKHlAmVzTTpUReB3T13Rw3tAU/MCtr7bA5g+O5kNXhUS
 +XNPXi0eXr4cYUF6AsI0+d0XUu9vPhTMxbXgd9YgQQRntzhTbYqPYemkkVWq9v0gJ0bT
 43RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794927331; x=1795532131;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7HplxTCkkz9T30kJsagqZEeHmYwWpsPTU4WmCwXe3UA=;
 b=mDbXrU7yb7eD8gT6KyUlQ/YTMcskYeEhOz6I34k2B/QiDW/3k8e91XEJgTzX+2LRO7
 K5Uv1GqAm/6nvLJcZRbphqm6Udf8XUB/WHhf6A59s7mLNue5CIsZEA2yrYkZOHlrpufr
 vF7uvlBA3BdyfzFLeMRTSZvGaJoPLwB3V5CXOhVnjKkg9/aoP6zI+62ZKE1zDD1PC1vx
 ixzLYJZaxe8UGErQRylQHthkFeRgHItEYHUTU9NUuXsK3Xm7nAV5RpjilDOX9ttqJtHo
 AEPI4ZoWXEjCbWwYXnZRGpb8yt83A1GsCWEEob+merp7ETemMj135e7rxfh/Iia0nXIT
 3xjQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEyJIoIcxQ3EC9YC0V5lXfDINqoCDs5y+d2GnpXBDQfOH1bYWKBSohGkdJ+knG51TY21O7ZQKi690SU@nongnu.org
X-Gm-Message-State: APuU4Z9RiZdPIs9H22HjKs4DaPsqJDBt/M3dX2KPOUoO0wOdFJbhTQy3
 1FEs+ge1LgsdUISLhre0i+CZV+XAXe4ZzGlg2/YJIYExORmMqlnQNjodxBP2ud0hCabrHK3q51x
 RYIlKIu970L09IlSXoEdlRrlI7rkjWaM=
X-Gm-Gg: AYBFou0XphGeMwpwsxPP04rr/ktw51NYmOzAANYaiqPeCWaK4JdlLTM6wnaTPn64p5+
 JIA0EfiD2bQnizvbITWK1bwvUk4cn4JnXHxFoIS7O5YnNprU5QiDNMpQwhrK4iK62p3Kxy9FVSe
 7gKkgNWEJJJlmZewV5bKkDSR0NlgCdvEOviHE6SSMxRnSXoP/HWSpqgOXb1k6PZsWrjy9nzSqIA
 YVSt8rRiJWVwPQvjobz5flyQAINW4dCwB6U2h6tHnlC0BPMe0ROxIRvfV1lk3pkApfGj+iY1MoG
 djuq4UNbfnHCIYLORQkjMzvQjhkJQY9oBKfedMQQ3XJI3InOm+PhFawwrQpfGQe7dV094R2Q0YB
 fRF2faN0NH6NYWg4lJttUBi8wzjYoVqOjys6oVfFzpqCT1PpOdYw2LrewOuVkusH01Xmx
X-Received: by 2002:a05:7301:a2a:b0:381:6ecf:5389 with SMTP id
 5a478bee46e88-3816edea237mr1960427eec.41.1794927330323; Tue, 17 Nov 2026
 06:55:30 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <avwn7izLPHpSmVun@redhat.com>
 <CAFEAcA9otxN=xhb7C8JRQ7HGNZqvzdpDjBaFQ7rCxDviip-rZA@mail.gmail.com>
 <avwt7XWPt9WNo90r@redhat.com>
In-Reply-To: <avwt7XWPt9WNo90r@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 17 Nov 2026 18:55:17 +0400
X-Gm-Features: Aa3M54rb0XE8gyJ4NnsEIzkBzLw9KnBV_tlYN_YOtc7w66wp_VGC9nGofeHLwbk
Message-ID: <CAJ+F1CLNpSAw4Fp5Yph8iZjytqP+Fcy6e6yFtg6DEWoVTurY8Q@mail.gmail.com>
Subject: Re: System emulator security boundary policy now enforceable
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1334;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x1334.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi

On Tue, Nov 17, 2026 at 2:36=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Tue, Nov 17, 2026 at 10:24:26AM +0000, Peter Maydell wrote:
> > On Tue, 17 Nov 2026 at 10:10, Daniel P. Berrang=C3=A9 <berrange@redhat.=
com> wrote:
> > >
> > > With the latest pull request of mine that is merged, we now have
> > > the mechanism for enforcement of the QEMU security boundary policy
> > > with annotations completed across QOM classes for machine types,
> > > devices and accelerators.
> > >
> > > For a bug disclosure affecting a system emulator to be accepted
> > > as a security flaw the reproducer scenario must now pass without
> > > warnings when adding the '-compat insecure-input' flag.
> >
> > How does the marking work? I'm confused about what's going
> > on with the pl011 UART (which is on the security boundary
> > because the arm virt board uses it). Unlike hw/char/serial.c
> > and some others, there's no ".secure =3D true" in hw/char/pl011.c.
> > But it isn't being rejected by
> > ./build/kvmonly/qemu-system-aarch64 -accel kvm -M virt -display none
> > -compat insecure-input=3Dreject -serial stdio
> >
> > so presumably we have figured out it's secure somehow. What's
> > the mechanism here?
>
> Currently we've only marked things which are explicitly user
> creatable. ie they appear in '-machine help', '-accel help'
> or '-device help' lists.
>
> If a machine type is marked as secure, then implicitly devices
> which are built-in for that machine are also considered secure.
> Similarly if a device is marked as secure, then implicitly
> any QOM parents of that device are also secure.
>
> In the next release cycle, I want to explicitly mark the
> built-in devices to make this clear to developers, and also
> explicitly mark parent types.
>
> Then code can explicitly validate the built-in devices & parents,
> so that we can detect if someone adds something inappropriate
> in our security boundary without realizing implications.

We also need to cover devices created via -vga, -nic, -usbdevice, -audio

I am not sure how to approach this though. Should we make all the
object_new() path faillible? Or use a top-down solution?

I'd favour the bottom-up approach so we can properly check all objects
instantiations and fix as needed

>
> > Speaking of pl011, there's also a rust implementation (which
> > I am not using in this test). Do we mark both the C and Rust
> > implementations as 'secure' ?
>
> We still have Rust disabled by default. Did we ever declare it to
> be production ready yet ? If we still consider it experimental then
> the rust pl011 would be out of scope.
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>
>


--=20
Marc-Andr=C3=A9 Lureau

