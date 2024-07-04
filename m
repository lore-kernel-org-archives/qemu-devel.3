Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F069C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 15:13:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPO8t-0005b4-Ue; Thu, 04 Jul 2024 11:13:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sPO8r-0005a7-1N
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 11:13:01 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sPO8p-0002ta-4s
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 11:13:00 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-57ccd1111aeso1066959a12.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 08:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720105977; x=1720710777; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iZY9lL/puiaybLWGlFSfXvw+LZrP1SoWXpkiflhRIt0=;
 b=L9OqazyIqdG0a55LkzvK0LYOpCSnTunqzSBvt4hsW3QyFPGx/csBN52aStPLvT5xQN
 P1DvZUFqfUIDFH72Rm+J9PjP8XKuAniSsCKydnfc1mSZPdNN8TeMTZOxaGzW90ZKVURx
 9v9hozDSvtiT5+JmUeVPGv+Pw0cypKpJeGee8WV6L8zDuGVC8YF0yqooKBixV5O3C37G
 O4GRq73s0lCBhuwrUjz761O9k/Sb8fWAOkxp2J6mxJOTLeHtqKfaeIO9yuQIC3ZVFEmf
 XeOlQMGG8LozoJw6ly9G+NQgI78vICDbEDBY6lndOpmNL7ED9W+8XQBHO6VecHCCuolp
 GdrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720105977; x=1720710777;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iZY9lL/puiaybLWGlFSfXvw+LZrP1SoWXpkiflhRIt0=;
 b=YMoepTEIXr2WPo/AQQQj0x0QuTYYtejZY+rSYwGscKU/9pR24Bdkohn+nZBvcEeZ7a
 l7YrBAPMz7JJREEWfbXIj0UeSkymwVykfWk4IOskyGcHNl3zkYJ49sqJJkyJ7A93c3yo
 bPYyJHM+95NI5S6SYLLkvxi7qoxZxdL6mTrnmnV0Gj56YIS6fpwxQtQwLBTSndjMmWNX
 /hjKI0MVv9LHB5tv2XMnEoelJJvhWtAjf53J48S6vibVFKIg6V+ZORT+RktsLhTF++Qb
 LyAu9wUqqCNMK6aP8ttpaXpGCaDz1Rf0zH9VNqN8EbkMofInTfeT0DoukNSLOrjEXyJn
 J68A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUA/wbFVq6R4m/EL+Ynz4f4NA6KPfHaenx3iuUbmmAbOJzRhCreqddvD+vkoKerpXUKUI9kBzlA0HGBNomxh4yr48X4ivQ=
X-Gm-Message-State: AOJu0YxKHIOvfyvQ2FVBjqwtGctGC4TtTWAJt6MeWu4f/UcJ9ORaZexF
 ovEjLqCXFHttJ8LuFX+dHrtMUlVIetAhmAY0W91Hosuxlbe5MxsIeWuFItNYcX9ekzR6HO4c6YX
 JOASyytslbtECUhSrK+GlF5W2nZQsEtKR4arPxQ==
X-Google-Smtp-Source: AGHT+IHQVs7EzlE2FWqJ84LuByID0jyB0rkFfGsK2Tzy3RrNxbRF/z9lQEGx7iLSUuO6pd/qNBVYgW6Bp9wr7l3fyUE=
X-Received: by 2002:a05:6402:3496:b0:57c:61a3:546 with SMTP id
 4fb4d7f45d1cf-58e5b1b752dmr1547957a12.21.1720105977272; Thu, 04 Jul 2024
 08:12:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240702155752.3022007-1-zheyuma97@gmail.com>
 <8aa595ef-efb2-45f8-a89f-9a4db3b2f11e@linaro.org>
In-Reply-To: <8aa595ef-efb2-45f8-a89f-9a4db3b2f11e@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Jul 2024 16:12:46 +0100
Message-ID: <CAFEAcA9EscdWuy2o2fLQV4+QL8gB0=FdGyP1F7u_vv=oMQ0b0g@mail.gmail.com>
Subject: Re: [PATCH v3] hw/char/pl011: Avoid division-by-zero in
 pl011_get_baudrate()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Zheyu Ma <zheyuma97@gmail.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Tue, 2 Jul 2024 at 17:18, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> On 2/7/24 17:57, Zheyu Ma wrote:
> > In pl011_get_baudrate(), when we calculate the baudrate we can
> > accidentally divide by zero. This happens because although (as the
> > specification requires) we treat UARTIBRD =3D 0 as invalid, we aren't
> > correctly limiting UARTIBRD and UARTFBRD values to the 16-bit and 6-bit
> > ranges the hardware allows, and so some non-zero values of UARTIBRD can
> > result in a zero divisor.
> >
> > Enforce the correct register field widths on guest writes and on inboun=
d
> > migration to avoid the division by zero.
> >
> > ASAN log:
> > =3D=3D2973125=3D=3DERROR: AddressSanitizer: FPE on unknown address 0x55=
f72629b348
> > (pc 0x55f72629b348 bp 0x7fffa24d0e00 sp 0x7fffa24d0d60 T0)
> >       #0 0x55f72629b348 in pl011_get_baudrate hw/char/pl011.c:255:17
> >       #1 0x55f726298d94 in pl011_trace_baudrate_change hw/char/pl011.c:=
260:33
> >       #2 0x55f726296fc8 in pl011_write hw/char/pl011.c:378:9
> >
> > Reproducer:
> > cat << EOF | qemu-system-aarch64 -display \
> > none -machine accel=3Dqtest, -m 512M -machine realview-pb-a8 -qtest std=
io
> > writeq 0x1000b024 0xf8000000
> > EOF
> >
> > Suggested-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
> Peter, feel free to replace that line by:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

OK; applied to target-arm.next, thanks.

-- PMM

